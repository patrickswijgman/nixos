set -l rg_command 'reload:rg --column --color=always --smart-case {q} || :'

fzf --disabled --ansi \
    --bind "start:$rg_command" --bind "change:$rg_command" \
    --bind "enter:execute:$EDITOR {1}:{2}" \
    --delimiter : \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query $argv
