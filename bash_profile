. ~/.vim/bundle/powerline/powerline/bindings/bash/powerline.sh
alias ls='ls --color'
alias sgrep="find -L . -path '*/migrations' -prune -o -path '*/docs' -prune -o -path '*/.svn' -prune -o -path '*/.git' -prune -o \( -type f -a \! -name tags -a \! -name cscope.out -a \! -name '*.sql' -a \! -name '*.po' -a \! -name '*.mo' \) -print0 | xargs -0 grep --color -I -n"

function dualscreen() {
    xrandr --output DP-4 --off
    xrandr --output VGA-0 --primary --auto --output DP-1 --right-of VGA-0 --auto
}

function singlescreen() {
    xrandr --output VGA-0 --off
    xrandr --output DP-4 --auto
}

alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
