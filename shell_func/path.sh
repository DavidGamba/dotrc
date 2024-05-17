#-------------------------------------------------------------
# PATH
# Scripts modifying the path should used the path_append function to append
# entries. These external entries not tracked in the bashrc will have lower priority.
#-------------------------------------------------------------
function path_append() {
	if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
		return 0
	fi
	PATH=$PATH:$1
}

function path_prepend() {
	if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]; then
		return 0
	fi
	if [[ "$PATH" == "" ]]; then
		PATH=$1
		return 0
	fi
	PATH=$1:$PATH
}

# Clear the PATH to ensure the right ordering
PATH=""
# Lowest priority at the top

if [[ $(/usr/bin/uname -r) =~ "microsoft" ]]; then
	path_prepend "/mnt/c/tools/neovim/Neovim/bin"
	path_prepend "/mnt/c/Users/David/AppData/Local/Programs/Microsoft VS Code/bin"
	path_prepend "/mnt/c/Users/David/AppData/Local/Microsoft/WindowsApps"
	path_prepend "/mnt/c/ProgramData/chocolatey/bin"
	path_prepend "/mnt/c/WINDOWS/System32/OpenSSH/"
	path_prepend "/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/"
	path_prepend "/mnt/c/WINDOWS/System32/Wbem"
	path_prepend "/mnt/c/WINDOWS"
	path_prepend "/mnt/c/WINDOWS/system32"
fi

if [[ $(/usr/bin/uname) =~ "Darwin" ]]; then
	export JAVA_HOME=/usr/local/opt/openjdk/
	path_prepend "/usr/local/opt/openjdk/bin"
	path_prepend "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi


path_prepend "$HOME/.krew/bin/" # k8s package manager
path_prepend "$HOME/.local/bin" # Python binaries
path_prepend "$HOME/.pyenv/shims"
path_prepend "$HOME/.cargo/bin" # Rust binaries
path_prepend "$HOME/go/bin"     # Go binaries
path_prepend "/snap/bin"        # Snap binaries
path_prepend "$HOME/local/bin"
path_prepend "$HOME/opt/bin"
path_prepend "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin"
path_prepend "/opt/homebrew/opt/postgresql@15/bin/"
path_prepend "/opt/homebrew/bin"
path_prepend "/opt/homebrew/opt/sqlite/bin"
path_prepend "/opt/homebrew/opt/make/libexec/gnubin"
path_prepend "/opt/homebrew/opt/less/bin"
path_prepend "$HOME/opt/n/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/private-bin"
