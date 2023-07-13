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
	dev := opt.NewCommand("dev", "Setup dev environment: some cargo and golang tools").SetCommandFn(DevDeps)
	dev.Bool("fast", false, opt.Description("skip cargo and interactive install tools"))
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
		return fmt.Errorf("source files changed so the binary was rebuilt: plese run again")
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
		"$HOME/.config/bat",
		"$HOME/.config/yamllint",
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
	cg.symlink("$HOME/dotrc/ssh_config", "$HOME/.ssh/config")
	cg.symlink("$HOME/dotrc/nvim-lua", "$HOME/.config/nvim")
	cg.symlink("$HOME/dotrc/bat.config", "$HOME/.config/bat/config")
	cg.symlink("$HOME/dotrc/kitty.conf", "$HOME/.config/kitty/kitty.conf")
	cg.symlink("$HOME/dotrc/yamllint.config.yaml", "$HOME/.config/yamllint/config")
	cg.symlink("dotrc/terraformrc", "$HOME/.terraformrc")
	// cg.symlink("dotrc/yabai/yabairc", "$HOME/.yabairc")
	// cg.symlink("dotrc/yabai/skhdrc", "$HOME/.skhdrc")

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
	version := "0.8.0"
	Logger.Printf("NVIM %s\n", version)

	os.Chdir(os.Getenv("HOME") + "/opt")

	switch runtime.GOOS {
	case "darwin":
		cg := CMDGroup{}
		cg.cmd("brew install --HEAD neovim")
		cg.cmd("brew install pyenv")
		cg.cmd("pyenv install --skip-existing 3")
		cg.cmd("pyenv global 3")

		cg.cmdPipe("python -m venv ~/venvs/jedi && source ~/venvs/jedi/bin/activate && pip install jedi")
		cg.cmdPipe("python -m venv ~/venvs/neovim && source ~/venvs/neovim/bin/activate && pip install neovim")
		cg.cmdPipe("python -m venv ~/venvs/black && source ~/venvs/black/bin/activate && pip install black")
		cg.cmdPipe("python -m venv ~/venvs/pylint && source ~/venvs/pylint/bin/activate && pip install pylint pylint-venv")

		return cg.Error
	}

	release, err := os.ReadFile("/etc/os-release")
	if err != nil {
		return err
	}
	cg := CMDGroup{}
	if strings.Contains(string(release), "ubuntu") {
		cg.cmd("sudo apt-get install software-properties-common git xclip")
		cg.cmd("sudo add-apt-repository ppa:neovim-ppa/unstable")
		cg.cmd("sudo apt-get update")
		cg.cmd("sudo apt-get install neovim")
		cg.cmdIgnore("sudo apt-get install python-dev python-pip")
		cg.cmd("sudo apt-get install python3-dev python3-pip")
		cg.cmdIgnore("python2 -m pip install --user --upgrade pynvim")
		cg.cmd("python3 -m pip install --user --upgrade pynvim")
	} else {
		cg.cmd("sudo yum install git xclip")
		cg.cmd("python3 -m pip install --user --upgrade pynvim")
		cg.cmdIgnore("python2 -m pip install --user --upgrade pynvim")
		cg.cmd(fmt.Sprintf("curl -LO https://github.com/neovim/neovim/releases/download/v%s/nvim.appimage", version))
		cg.cmd("chmod u+x nvim.appimage")
		cg.symlink("$HOME/opt/nvim.appimage", "$HOME/opt/bin/nvim")
		// Download app image update tool
		// cmd("wget https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage -O bin/appimageupdatetool")
		// cmd("chmod u+x bin/appimageupdatetool")
		// "$HOME/opt/bin/appimageupdatetool" "$HOME/opt/nvim.appimage"
	}

	return cg.Error
}

func DevDeps(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	fast := opt.Value("fast").(bool)

	os.Chdir(os.Getenv("HOME"))

	if !fast {
		out, err := run.CMD("curl", "https://sh.rustup.rs", "-sSf").Log().PrintErr().STDOutOutput()
		if err != nil {
			return err
		}
		err = run.CMD("sh").Log().PrintErr().In(out).Run()
		if err != nil {
			return err
		}
	}

	cg := CMDGroup{}
	cg.cmd("go install golang.org/x/tools/gopls@latest")             // golang language server
	cg.cmd("go install github.com/philpennock/character@latest")     // emoji picker
	cg.cmd("go install github.com/jesseduffield/lazygit@latest")     // git cli gui
	cg.cmd("go install github.com/tomwright/dasel/cmd/dasel@master") // data selector
	cg.cmd("go install github.com/sachaos/viddy@latest")             // watch command with rewind and other options

	cg.cmd("cargo install diffr")         // diff tool
	cg.cmd("cargo install git-delta")     // diff tool
	cg.cmd("cargo install ripgrep")       // grep tool
	cg.cmd("cargo install tealdeer")      // man page summaries
	cg.cmd("cargo install code-minimap")  // code minimap for vim
	cg.cmd("cargo install fd-find")       // find tool
	cg.cmd("cargo install igrep")         // interactive grep
	cg.cmd("cargo install watchexec-cli") // watch and run command
	cg.cmd("cargo install --locked bat")  // cat replacement
	cg.cmd("cargo install tuc")           // cut replacement

	cg.cmdIgnore("git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf")
	os.Chdir(filepath.Join(os.Getenv("HOME"), ".fzf"))
	cg.cmd("git pull")
	cg.cmd("$HOME/.fzf/install --all")

	switch runtime.GOOS {
	case "darwin":
		cg.cmd("brew install coreutils")         // gnu core utils
		cg.cmd("brew install jq")                // json parsing
		cg.cmd("brew install bash")              // bash 5
		cg.cmd("brew install bash-completion@2") // bash completion
		cg.cmd("brew install asdf")              // package manager

		// cg.cmd("brew install koekeishiya/formulae/yabai") // tiling window manager
		// cg.cmd("brew install koekeishiya/formulae/skhd") // hotkey daemon
		cg.cmd("brew install --cask alt-tab") // alt-tab replacement
		cg.cmd("brew install --cask jumpcut") // clipboard manager

		cg.cmd("brew install gawk") // GNU awk
		cg.cmd("brew install wget") // wget

		cg.cmd("brew install xsv")         // csv parsing
		cg.cmd("brew install age")         // encryption
		cg.cmd("brew install asciidoctor") // asciidoc to html
		cg.cmd("brew install graphviz")    // graphviz
		cg.cmd("brew install gron")        // json parsing
		cg.cmd("brew install nmap")        // network scanning
		cg.cmd("brew install watch")       // watch command
		cg.cmd("brew install yamllint")    // yaml linting
		cg.cmd("brew install tree")        // tree command
		cg.cmd("brew install sipcalc")     // ip range calculator

		cg.cmd("brew install tree-sitter")                // tree-sitter
		cg.cmd("brew install terraform-ls")               // terraform language server
		cg.cmd("brew install lua-language-server")        // lua language server
		cg.cmd("brew install shellcheck")                 // bash linting
		cg.cmd("brew install gh")                         // github client
		cg.cmd("brew install stern")                      // kubernetes logs
		cg.cmd("brew install minamijoyo/hcledit/hcledit") // terraform hcl edits
	}

	return cg.Error
}

func TMuxInstall(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	os.Chdir(filepath.Join(os.Getenv("HOME"), "general/code"))

	cg := CMDGroup{}
	switch runtime.GOOS {
	case "darwin":
		cg.cmd("brew install tmux")
		return cg.Error
	}

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

	setupTool := func(name string) {
		cg.symlink(fmt.Sprintf("$HOME/general/code/dgtools/%s/%s", name, name), fmt.Sprintf("$HOME/bin/%s", name))
		cg.cmdDir("go build", fmt.Sprintf("$HOME/general/code/dgtools/%s", name))
	}

	cg.symlink("$HOME/general/code/dgtools/clitable/cmd/csvtable/csvtable", "$HOME/bin/csvtable")
	cg.cmdDir("go build", "$HOME/general/code/dgtools/clitable/cmd/csvtable")

	setupTool("cathtml")
	setupTool("cli-bookmarks")
	setupTool("diffdir")
	setupTool("ffind")
	setupTool("grepp")
	setupTool("joinlines")
	setupTool("json-parse")
	setupTool("kcherry")
	setupTool("password-cache")
	setupTool("patch-seam")
	setupTool("reverseproxy")
	setupTool("tz")
	setupTool("webserve")
	setupTool("yaml-parse")
	setupTool("yaml-seam")

	cg.clone("https://github.com/DavidGamba/go-wardley.git", "$HOME/general/code/go-wardley")
	cg.cmdDir("go build", "$HOME/general/code/go-wardley")
	cg.symlink("$HOME/general/code/go-wardley/go-wardley", "$HOME/bin/wardley")

	cg.clone("https://github.com/DavidGamba/go-getoptions.git", "$HOME/general/code/go-getoptions")

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

func (cg *CMDGroup) cmdPipe(command string) {
	if cg.Error != nil {
		return
	}
	var c []string
	c, cg.Error = fsmodtime.ExpandEnv([]string{command})
	if cg.Error != nil {
		return
	}
	cg.Error = run.CMD("bash", "-c", c[0]).Log().PrintErr().Stdin().Run()
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
