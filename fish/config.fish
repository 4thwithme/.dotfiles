
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/4thwithme/miniconda3/bin/conda
    eval /Users/4thwithme/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/4thwithme/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/4thwithme/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/4thwithme/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

