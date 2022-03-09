package main

import (
	"context"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"

	"github.com/DavidGamba/dgtools/buildutils"
	"github.com/DavidGamba/dgtools/fsmodtime"
	"github.com/DavidGamba/dgtools/run"
	"github.com/DavidGamba/go-getoptions"
)

var Logger = log.New(os.Stderr, "", log.LstdFlags)

func main() {
	os.Exit(program(os.Args))
}

func program(args []string) int {
	opt := getoptions.New()
	opt.Bool("quiet", false)
	opt.NewCommand("symlinks", "Install dotrc files").SetCommandFn(DotRCSymlinks)
	opt.NewCommand("nvim", "Install Neovim").SetCommandFn(NeovimInstall)
	opt.NewCommand("tmux", "Install TMUX").SetCommandFn(TMuxInstall)
	opt.NewCommand("awscli", "Install AWS CLI v2").SetCommandFn(AWSCLIInstall)
	opt.NewCommand("dev", "Setup dev environment: some cargo and golang tools").SetCommandFn(DevDeps)
	opt.NewCommand("toolbox", "Setup toolbox").SetCommandFn(ToolBox)
	opt.HelpCommand("help", opt.Alias("?"))
	remaining, err := opt.Parse(args[1:])
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: %s\n", err)
		return 1
	}
	if opt.Called("quiet") {
		Logger.SetOutput(io.Discard)
	}
	Logger.Println(remaining)

	ctx, cancel, done := getoptions.InterruptContext()
	defer func() { cancel(); <-done }()

	err = checkSelf(ctx)
	if err != nil {
		fmt.Fprintf(os.Stderr, "ERROR: %s\n", err)
		return 1
	}

	err = opt.Dispatch(ctx, remaining)
	if err != nil {
		if errors.Is(err, getoptions.ErrorHelpCalled) {
			return 1
		}
		fmt.Fprintf(os.Stderr, "ERROR: %s\n", err)
		return 1
	}
	return 0
}

func checkSelf(ctx context.Context) error {
	wd, err := os.Getwd()
	if err != nil {
		return err
	}
	err = buildutils.CDGitRepoRoot()
	if err != nil {
		return err
	}
	files, modified, err := fsmodtime.Target(os.DirFS("."),
		[]string{"build"},
		[]string{"go.mod", "go.sum", "*.go"})
	if err != nil {
		return err
	}
	if modified {
		Logger.Printf("file modified: %v\n", files)
		err := run.CMD("go", "build", "-o", "build").Log().Run()
		if err != nil {
			return fmt.Errorf("failed to rebuild itself: %w", err)
		}
		return fmt.Errorf("source files changed so the binary was rebuilt: plese run again!")
	}
	err = os.Chdir(wd)
	if err != nil {
		return err
	}
	return nil
}

func DotRCSymlinks(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	Logger.Printf("DotRCSymlinks")

	os.Chdir(os.Getenv("HOME"))

	dirs, err := fsmodtime.ExpandEnv([]string{
		"$HOME/opt/bin",
		"$HOME/mnt",
		"$HOME/general/code",
		"$HOME/general/projects",
		"$HOME/work",
		"$HOME/.ssh",
		"$HOME/.aws",
		"$HOME/.terraform.d/plugin-cache",
	})
	if err != nil {
		return err
	}
	for _, d := range dirs {
		Logger.Printf("Create dir %s\n", d)
		err := os.MkdirAll(d, 0755)
		if err != nil {
			return err
		}
	}

	cg := CMDGroup{}
	cg.symlink("dotrc/bashrc", "$HOME/.bashrc")
	cg.symlink("dotrc/screenrc", "$HOME/.screenrc")
	cg.symlink("dotrc/tmux.conf", "$HOME/.tmux.conf")
	cg.symlink("dotrc/perltidyrc", "$HOME/.perltidyrc")
	cg.symlink("dotrc/inputrc", "$HOME/.inputrc")
	cg.symlink("dotrc/gitignore", "$HOME/.gitignore")
	cg.symlink("dotrc/gitconfig", "$HOME/.gitconfig")
	cg.symlink("dotrc/hgrc", "$HOME/.hgrc")
	cg.symlink("dotrc/nvimrc", "$HOME/.nvimrc")
	cg.symlink("$HOME/dotrc/ssh_config", "$HOME/.ssh/config")
	cg.symlink("$HOME/dotrc/nvim-lua", "$HOME/.config/nvim")
	cg.symlink("dotrc/terraformrc", "$HOME/.terraformrc")
	cg.symlink("$HOME/opt/nvim.appimage", "$HOME/opt/bin/nvim")

	switch runtime.GOOS {
	case "darwin":
		_ = os.Mkdir(os.ExpandEnv("$HOME/Library/Application Support/lazygit"), 0755)
		cg.symlink("$HOME/dotrc/lazygit-config.yml", "$HOME/Library/Application Support/lazygit/config.yml")
	default:
		_ = os.Mkdir(os.ExpandEnv("$HOME/.config/lazygit"), 0755)
		cg.symlink("$HOME/dotrc/lazygit-config.yml", "$HOME/.config/lazygit/config.yml")
	}

	return err
}

func NeovimInstall(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	version := "0.6.1"
	Logger.Printf("NVIM %s\n", version)

	os.Chdir(os.Getenv("HOME") + "/opt")

	cg := CMDGroup{}
	cg.cmd("sudo yum install git xclip")
	cg.cmd("python3 -m pip install --user --upgrade pynvim")
	cg.cmdIgnore("python2 -m pip install --user --upgrade pynvim")
	cg.cmd(fmt.Sprintf("curl -LO https://github.com/neovim/neovim/releases/download/v%s/nvim.appimage", version))
	cg.cmd("chmod u+x nvim.appimage")
	// Download app image update tool
	// cmd("wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage -O bin/appimageupdatetool")
	// cmd("chmod u+x bin/appimageupdatetool")
	// "$HOME/opt/bin/appimageupdatetool" "$HOME/opt/nvim.appimage"

	return cg.Error
}

func DevDeps(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	os.Chdir(os.Getenv("HOME"))

	out, err := run.CMD("curl", "https://sh.rustup.rs", "-sSf").Log().PrintErr().STDOutOutput()
	if err != nil {
		return err
	}
	err = run.CMD("sh").Log().PrintErr().In(out).Run()
	if err != nil {
		return err
	}

	cg := CMDGroup{}
	cg.cmd("go install golang.org/x/tools/gopls@latest")
	cg.cmd("go install arp242.net/uni@latest")
	cg.cmd("go install github.com/jesseduffield/lazygit@latest")
	cg.cmd("go install github.com/tomwright/dasel/cmd/dasel@master")

	cg.cmd("cargo install diffr")
	cg.cmd("cargo install ripgrep")
	cg.cmd("cargo install tealdeer")
	cg.cmd("cargo install code-minimap")
	cg.cmd("cargo install fd-find")

	_ = run.CMD(strings.Split("git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf", " ")...).Log().PrintErr().Stdin().Run()
	os.Chdir(filepath.Join(os.Getenv("HOME"), ".fzf"))
	cg.cmd("git pull")
	cg.cmd("$HOME/.fzf/install")

	return cg.Error
}

func TMuxInstall(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	os.Chdir(filepath.Join(os.Getenv("HOME"), "general/code"))

	cg := CMDGroup{}
	cg.cmd("sudo yum install git autoconf automake")
	cg.cmd("sudo yum install libevent-devel ncurses-devel gcc make bison pkg-config")
	cg.cmd("git clone https://github.com/tmux/tmux.git")
	os.Chdir("tmux")
	cg.cmd("sh autogen.sh")
	cg.cmd("./configure")
	cg.cmd("make")
	cg.cmd("sudo make install")

	return cg.Error
}

func AWSCLIInstall(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	os.Chdir(filepath.Join(os.Getenv("HOME"), "opt"))

	cg := CMDGroup{}
	cg.cmd("curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip")
	cg.cmd("unzip awscliv2.zip")
	cg.cmd("./aws/install --install-dir $HOME/opt/aws-cli --bin-dir $HOME/opt/bin")
	cg.cmd("rm aws/ -rf")
	return cg.Error
}

func ToolBox(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	cg := CMDGroup{}
	cg.clone("https://github.com/DavidGamba/bin.git", "$HOME/bin")

	cg.clone("https://github.com/DavidGamba/dgtools.git", "$HOME/general/code/dgtools")

	cg.cmdDir("go build", "$HOME/general/code/dgtools/grepp")
	cg.symlink("$HOME/general/code/dgtools/grepp/grepp", "$HOME/bin/grepp")

	cg.symlink("$HOME/general/code/dgtools/ffind/ffind", "$HOME/bin/ffind")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/ffind")

	cg.symlink("$HOME/general/code/dgtools/cli-bookmarks/cli-bookmarks", "$HOME/bin/cli-bookmarks")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/cli-bookmarks")

	cg.symlink("$HOME/general/code/dgtools/joinlines/joinlines", "$HOME/bin/joinlines")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/joinlines")

	cg.symlink("$HOME/general/code/dgtools/password-cache/password-cache", "$HOME/bin/password-cache")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/password-cache")

	cg.symlink("$HOME/general/code/dgtools/yaml-parse/yaml-parse", "$HOME/bin/yaml-parse")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/yaml-parse")

	cg.symlink("$HOME/general/code/dgtools/webserve/webserve", "$HOME/bin/webserve")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/webserve")

	cg.symlink("$HOME/general/code/dgtools/diffdir/diffdir", "$HOME/bin/diffdir")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/diffdir")

	cg.clone("https://github.com/DavidGamba/go-wardley.git", "$HOME/general/code/go-wardley")
	cg.cmdDir("go build", "$HOME/general/code/go-wardley")
	cg.symlink("$HOME/general/code/go-wardley/go-wardley", "$HOME/bin/wardley")

	cg.cmd("git clone https://github.com/DavidGamba/go-getoptions.git $HOME/general/code/go-getoptions")

	return cg.Error
}

type CMDGroup struct {
	Error error
}

func (cg *CMDGroup) cmd(command string) {
	if cg.Error != nil {
		return
	}
	var c []string
	c, cg.Error = fsmodtime.ExpandEnv(strings.Split(command, " "))
	if cg.Error != nil {
		return
	}
	cg.Error = run.CMD(c...).Log().PrintErr().Stdin().Run()
}

func (cg *CMDGroup) cmdIgnore(command string) {
	if cg.Error != nil {
		return
	}
	var c []string
	c, cg.Error = fsmodtime.ExpandEnv(strings.Split(command, " "))
	if cg.Error != nil {
		return
	}
	_ = run.CMD(c...).Log().PrintErr().Stdin().Run()
}

func (cg *CMDGroup) cmdDir(command, dir string) {
	if cg.Error != nil {
		return
	}
	var c []string
	c, cg.Error = fsmodtime.ExpandEnv(strings.Split(command, " "))
	if cg.Error != nil {
		return
	}
	var d []string
	d, cg.Error = fsmodtime.ExpandEnv(strings.Split(dir, " "))
	if cg.Error != nil {
		return
	}
	cg.Error = run.CMD(c...).Dir(d[0]).Log().PrintErr().Stdin().Run()
}

func (cg *CMDGroup) symlink(target, name string) {
	if cg.Error != nil {
		return
	}
	var t, n []string
	t, cg.Error = fsmodtime.ExpandEnv([]string{target})
	if cg.Error != nil {
		return
	}
	n, cg.Error = fsmodtime.ExpandEnv([]string{name})
	if cg.Error != nil {
		return
	}
	_ = os.Remove(n[0])
	Logger.Printf("Create symlink %s <- %s\n", t[0], n[0])
	cg.Error = os.Symlink(t[0], n[0])
}

func (cg *CMDGroup) cloneUpdate(repo, dir string) {
	if cg.Error != nil {
		return
	}
	var d []string
	d, cg.Error = fsmodtime.ExpandEnv([]string{dir})
	if cg.Error != nil {
		return
	}
	if _, err := os.Stat(dir); os.IsNotExist(err) {
		cg.Error = run.CMD("git", "clone", repo, d[0]).Dir(d[0]).Log().PrintErr().Stdin().Run()
	} else {
		cg.Error = run.CMD("git", "pull").Dir(d[0]).Log().PrintErr().Stdin().Run()
	}
}

func (cg *CMDGroup) clone(repo, dir string) {
	if cg.Error != nil {
		return
	}
	var d []string
	d, cg.Error = fsmodtime.ExpandEnv([]string{dir})
	if cg.Error != nil {
		return
	}
	_ = run.CMD("git", "clone", repo, d[0]).Log().PrintErr().Stdin().Run()
}
