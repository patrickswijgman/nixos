function search
    rg --hidden --column --color=always --smart-case $argv
end

function filter
    fzf --ansi \
        --bind "enter:execute:$EDITOR {1}:{2}:{3}" \
        --delimiter : \
        --preview "bat --highlight-line={2} {1}" \
        --preview-window '~4,+{2}+4/3,<80(up)'
end

search $argv | filter
