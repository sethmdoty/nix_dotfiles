# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
## Themes #####
#zinit light denysdovhan/spaceship-prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
## Path
typeset -gU PATH path=(
  $path
  .
)
### OMZ #######
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet PZT::modules/helper/init.zsh
#########
# Advanced auto-completion
# zstyle ':autocomplete:*' groups always
zinit light-mode for marlonrichert/zsh-autocomplete
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
# source ~/.zinit/plugins/marlonrichert---zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Sensible defaults
zstyle ':prezto:*:*' color 'yes'
zinit light-mode for \
  id-as'prezto/environment' \
    https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh \
  id-as'prezto/history' \
    https://github.com/sorin-ionescu/prezto/blob/master/modules/history/init.zsh \
  id-as'prezto/directory' \
    https://github.com/sorin-ionescu/prezto/blob/master/modules/directory/init.zsh
HISTSIZE=200000
SAVEHIST=100000

# Environment variables
export LANG='en_US.UTF-8'
export WORDCHARS='*?~&|;!#$%^'
export VISUAL='emacs -c'
export EDITOR='emacsclient'
export PAGER='less'
export LESS='-g -i -M -R -S -w -z-4'

# History settings
setopt histfcntllock histreduceblanks NO_histignorespace

# History editing tools
local key_codes=( '^Q' '^[Q' '^[q' )
eval 'bindkey '${(b)^key_codes}' push-line-or-edit; '
zinit light-mode for marlonrichert/zsh-hist

# Bash/Readline compatibility
# Zsh's default kills the whole line.
bindkey '^U' backward-kill-line

# Prezto/Emacs-undo-tree compatibility
# Zsh does not have a default keybinding for this.
bindkey '^[_' redo

# Enable alt-h help function.
unalias run-help
autoload -Uz  run-help    run-help-git  run-help-ip   run-help-openssl \
              run-help-p4 run-help-sudo run-help-svk  run-help-svn

# Pattern matching support for `cp`, `ln` and `mv`
# See http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zcp='zmv -Civ'
alias zln='zmv -Liv'
alias zmv='zmv -Miv'

# Fuzzy search
# Requires `brew install fd`, `brew install fzf` and `brew install ripgrep`
export FZF_DEFAULT_COMMAND='fd -HI --color=always'
zinit light-mode for \
  id-as'fzf/completion' https://github.com/junegunn/fzf/blob/master/shell/completion.zsh \
  id-as'fzf/key-bindings' https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
alias find='fd -HI -E=".git" --color=always'
alias fzf='fzf --ansi --exact --multi --no-sort'
alias rg='rg --color=always --hidden --glob !.git --ignore-case --line-number --no-heading --sort=path'

##########
# Better `ls`
# Requires `brew install exa`.
alias ls='exa -aF --git --color=always --color-scale -s=extension --group-directories-first'
ll() {
  ls -ghlmu --time-style=long-iso $@ | $PAGER
}
alias tree='ll -T -L=3'
compdef _ls ll ll=ls

# Colors for 'ls' and completions
# Requires `brew install coreutils`.
zinit light-mode for atclone'gdircolors -b LS_COLORS > clrs.zsh' atpull'%atclone' pick'clrs.zsh' \
  nocompile'!' atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"' trapd00r/LS_COLORS

# Color `grep`
alias grep='grep --color=always'

# Syntax highlighting in `less`
# Requires `brew install bat`.
alias less='bat --pager "$PAGER $LESS" --style=snip,header --color=always'

# Log file highlighting in `tail`
# Requires `brew install multitail`.
alias tail='multitail -Cs --follow-all'

# zinit light-mode for zsh-users/zsh-autosuggestions

# Command-line syntax highlighting
# Must be AFTER after all calls to `compdef`, `zle -N` or `zle -C`.
export ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
# zinit light-mode for zdharma/fast-syntax-highlighting
zinit light-mode for zsh-users/zsh-syntax-highlighting

# Lazy `pyenv init`
# Requires `brew install pyenv`.
zinit light-mode for davidparsson/zsh-pyenv-lazy

## autopair ###
zinit light-mode for hlissner/zsh-autopair

# thefuck
zplugin light laggardkernel/zsh-thefuck

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
