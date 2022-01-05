package main

import (
	"context"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
	"time"

	"github.com/DavidGamba/dgtools/fsmodtime"
	"github.com/DavidGamba/go-getoptions"
)

var Logger = log.New(os.Stderr, "", log.LstdFlags)

func main() {
	os.Exit(program(os.Args))
}

func program(args []string) int {
	opt := getoptions.New()
	opt.Bool("quiet", false)
	opt.SetUnknownMode(getoptions.Pass)
	opt.NewCommand("cmd", "description").SetCommandFn(Run)
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

func Run(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	Logger.Printf("Running")
	return nil
}

func DotRCSymlinks(ctx context.Context, opt *getoptions.GetOpt, args []string) error {
	Logger.Printf("DotRCSymlinks")

	dirs, err := fsmodtime.ExpandEnv([]string{"$HOME/opt", "$HOME/mnt", "$HOME/general/code", "$HOME/general/projects", "$HOME/work"})
	if err != nil {
		return err
	}
	for _, d := range dirs {
		err := os.MkdirAll(d, 0755)
		if err != nil {
			return err
		}
	}

	symlink := func(target, name string) {
		if err != nil {
			return
		}
		_ = os.Remove(name)
		err = os.Symlink(target, name)
	}

	symlink("dotrc/bashrc", "$HOME/.bashrc")
	symlink("dotrc/screenrc", "$HOME/.screenrc")
	symlink("dotrc/tmux.conf", "$HOME/.tmux.conf")
	symlink("dotrc/perltidyrc", "$HOME/.perltidyrc")
	symlink("dotrc/inputrc", "$HOME/.inputrc")
	symlink("dotrc/gitignore", "$HOME/.gitignore")
	symlink("dotrc/gitconfig", "$HOME/.gitconfig")
	symlink("dotrc/hgrc", "$HOME/.hgrc")
	symlink("dotrc/nvimrc", "$HOME/.nvimrc")
	symlink("$HOME/dotrc/nvim", "$HOME/.config/nvim")
	symlink("dotrc/terraformrc", "$HOME/.terraformrc")

	if err != nil {
		return err
	}

	return nil
}

func touch(filename string) error {
	_, err := os.Stat(filename)
	if os.IsNotExist(err) {
		file, err := os.Create(filename)
		if err != nil {
			return err
		}
		defer file.Close()
	} else {
		currentTime := time.Now().Local()
		err = os.Chtimes(filename, currentTime, currentTime)
		if err != nil {
			return err
		}
	}
	return nil
}
