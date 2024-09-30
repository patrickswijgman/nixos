rg --hidden --column --color=always --smart-case $argv \
    | fzf --ansi \
    --bind "enter:execute:$EDITOR {1}:{2}:{3}" \
    --delimiter : \
    --preview "bat --style=full --color=always --highlight-line={2} {1}" \
    --preview-window '~4,+{2}+4/3,<80(up)'
