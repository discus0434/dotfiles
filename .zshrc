# alias
if type trash > /dev/null 2>&1; then
    alias rm='trash -F'
fi
export PROMPT="%n@%m(`uname -m`) %1~ %# "
alias change_profile='(){echo -e "\033]1337;SetProfile=$1\a"}'
alias arm="env /usr/bin/arch -arm64 /bin/zsh"
alias intel="env /usr/bin/arch -x86_64 /bin/zsh"
alias sed='gsed'
alias cmakeclean='rm CMakeCache.txt cmake_install.cmake && rm -r CMakeFiles && rm Makefile'

# auto complete
autoload -U compinit
compinit

# env
export LANG=ja_JP.UTF-8
setopt print_eight_bit
setopt share_history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# bindkey
bindkey -e
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# command complement
autoload -U compinit
compinit

# OpenSSL
if [ "$(uname -m)" = "arm64" ]; then
  export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
  export CPPFLAGS="-L/opt/homebrew/opt/openssl@3/include"
fi

# change iterm profile
if [ "$(uname -m)" = "arm64" ]; then
  # arm64
  change_profile LocalARM
else
  # x86_64
  change_profile LocalIntel
fi

# homebrew
if [ "$(uname -m)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/bin:$PATH"
else
  eval "$(/usr/local/bin/brew shellenv)"
  export PATH="/usr/local/bin:$PATH"
fi

# anyenv
if [ "$(uname -m)" = "arm64" ]; then
  # ARM
  export ANYENV_ROOT="$HOME/.anyenv_arm"
else
  # Intel
  export ANYENV_ROOT="$HOME/.anyenv_intel"
fi
export PATH="$ANYENV_ROOT/bin:$PATH"
if [ -e "$ANYENV_ROOT" ]; then
  eval "$($ANYENV_ROOT/libexec/anyenv init -)"
fi

# pyenv
export PYENV_ROOT="$ANYENV_ROOT/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# rbenv
[[ -d ~/.rbenv  ]] && \
  export PATH="$HOME/.rbenv/versions/3.0.5/bin:$PATH" && \
  eval "$(rbenv init -)" && \

# starship
eval "$(starship init zsh)"

# bzip2
if [ "$(uname -m)" = "arm64" ]; then
  export LDFLAGS="-L/opt/homebrew/opt/bzip2/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/bzip2/include"
fi

# tbb
if [ "$(uname -m)" = "arm64" ]; then
  export LDFLAGS="-L/opt/homebrew/opt/tbb/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/tbb/include"
fi

# XCode
export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# dotenv
function export-dotenv(){
  set -a && source $1 && set +a
}

# OpenJDK
export JAVA_HOME="/opt/homebrew/Cellar/openjdk/17.0.2/libexec/openjdk.jdk/Contents/Home"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# Maven
export PATH="/opt/homebrew/Cellar/maven/3.8.4/bin:$PATH"

# vim
export EDITOR="vim"
export VISUAL="vim"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# conda
if [ `uname -m` = "arm64" ]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/koheiohno/.anyenv_arm/envs/pyenv/versions/miniforge3-4.10.3-10/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/koheiohno/.anyenv_arm/envs/pyenv/versions/miniforge3-4.10.3-10/etc/profile.d/conda.sh" ]; then
          . "/Users/koheiohno/.anyenv_arm/envs/pyenv/versions/miniforge3-4.10.3-10/etc/profile.d/conda.sh"
      else
          export PATH="/Users/koheiohno/.anyenv_arm/envs/pyenv/versions/miniforge3-4.10.3-10/bin:$PATH"
      fi
  fi
  unset __conda_setup
else
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/koheiohno/.anyenv_intel/envs/pyenv/versions/miniforge3-4.10.1-5/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  fi
  unset __conda_setup
  # <<< conda initialize <<<
fi
