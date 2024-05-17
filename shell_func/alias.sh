# Darwin = mac
if [ `uname | grep Darwin` ]; then
	# use coreutils: brew install coreutils
	alias ll='gls -l --color=auto --hyperlink=auto'
	alias ls='gls -hF --color=auto --hyperlink=auto'
	alias la='gls -la --color=auto --hyperlink=auto'
	alias l='gls -CF --color=auto --hyperlink=auto'

	alias rm='grm'

	alias chromium='/Applications/Chromium.app/Contents/MacOS/Chromium'
else
	alias ls='ls -hF --color=auto --hyperlink=auto'
	alias ll='ls -l --color=auto --hyperlink=auto'
	alias la='ls -la --color=auto --hyperlink=auto'
	alias l='ls -CF --color=auto --hyperlink=auto'
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias pong='ping -c4 www.google.com' 
# alias emacs="emacs -nw"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# to run banshee behind a proxy
alias banshee='dbus-launch banshee'
alias nautilus='nautilus --no-desktop'
alias most='du -hsx * | sort -rh | head -15'
alias df='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'
alias vim=nvim
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
# alias asciidoctor='docker run --rm -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor'
alias path='PATH="${PATH//":$PWD"/}:$PWD"; echo $PATH'
alias rg='rg -i --color=always'
alias hg='kitty +kitten hyperlinked_grep'
alias ccat='source-highlight --out-format=esc -o STDOUT -i'
alias color='source-highlight --out-format=esc -o STDOUT -s'
alias csvlook='csvlook -I | less -S'
# alias csvtable='csvtable | less -S'
alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'
alias myip="curl https://ifconfig.co"
alias root="cd \$(git rev-parse --show-toplevel)"
alias dotpng="dot -ograph.png -Tpng"

# Terraform aliases
alias .tinit='time ./terraform init'
alias .tplan='time ./terraform plan -no-color -out tf.plan'
alias .tapply='time ./terraform apply -input tf.plan && rm tf.plan'
alias .tcopy='./terraform show -no-color tf.plan | copy'
alias .tshow='./terraform show tf.plan'
alias tinit='time terraform init'
alias tplan='time terraform plan -no-color -out tf.plan'
alias tapply='time terraform apply -input tf.plan && rm tf.plan'
alias tcopy='terraform show -no-color tf.plan | copy'
alias tshow='terraform show tf.plan'

# kubernetes
alias kcd='kubectl config set-context --current --namespace '
alias kgc='kubectl config get-contexts'
alias kuc='kubectl config use-context '

if [[ $(uname -r) =~ "microsoft" ]]; then
	alias copy='win32yank.exe -i'
	alias copy-file='win32yank.exe -i <<<'
	alias copy-path='pwd | tr -d "\n" | win32yank.exe -i'
elif [[ $(uname) =~ "Darwin" ]]; then
	alias copy='pbcopy'
	alias copy-file='pbcopy <'
	alias copy-path='pwd | tr -d "\n" | pbcopy'
else
	# alias copy-file="xsel -i -b < "
	alias copy-file='xclip -selection clipboard'
	alias copy-path='pwd | tr -d "\n" | xclip -selection clipboard'
fi
