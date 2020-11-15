# search
export FZF_DEFAULT_COMMAND='fd -HI --color=always'
alias find='fd -HI -E=".git" --color=always'
alias fzf='fzf --ansi --exact --multi --no-sort'
alias rg='rg --color=always --hidden --glob !.git --ignore-case --line-number --no-heading --sort=path'


# ls
alias ls='exa -aF --git --color=always --color-scale -s=extension --group-directories-first'
ll() {
  ls -ghlmu --time-style=long-iso $@
}

alias tree='ll -T -L=3'
compdef _ls ll ll=ls

# Pattern matching support for `cp`, `ln` and `mv`
# See http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zcp='zmv -Civ'
alias zln='zmv -Liv'
alias zmv='zmv -Miv'

# Color `grep`
alias grep='grep --color=always'

# Syntax highlighting in `less`
# Requires `bat`.
alias less='bat --pager "$PAGER $LESS" --style=snip,header --color=always'

# Log file highlighting in `tail`
# Requires `multitail`.
alias tail='multitail -Cs --follow-all'
