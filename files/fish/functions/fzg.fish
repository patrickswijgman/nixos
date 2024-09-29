# The "--" here is mandatory, it tells it from where to read the arguments.
argparse h/help f/files -- $argv
# exit if argparse failed because it found an option it didn't recognize - it will print an error
or return

# If -h or --help is given, we print a little help text and return
if set -ql _flag_help
    echo "fzg [-h|--help] [-f|--files] [ARGUMENT ...]"
    return 0
end

set -l show_files (
    if set -ql _flag_files
        echo -n "--files"
    end
)

set -l highlight_line (
    if not set -ql _flag_files
        echo -n "--highlight-line {2}"
    end
)

set -l exe (
    if set -ql _flag_files
        echo -n "$EDITOR {1}"
    else
        echo -n "$EDITOR {1}:{2}"
    end
)

set -l rg_command "reload:rg $show_files --hidden --column --color=always --smart-case $argv[1] || :"

fzf --ansi \
    --bind "start:$rg_command" \
    --bind "enter:execute:$exe" \
    --delimiter : \
    --preview "bat --style=full --color=always $highlight_line {1}" \
    --preview-window '~4,+{2}+4/3,<80(up)'
