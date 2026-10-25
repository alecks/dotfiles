set -U fish_greeting "🐟 fih v$FISH_VERSION"
set -l host (hostname)

alias nv "nvim"

if test "$host" = pleemcentre
    # Fedora PC
    # set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/keyring/ssh"
    function open --description 'Open a file with xdg-open and disown'
        xdg-open $argv[1] >/dev/null 2>&1 &
        disown
    end

    /home/alex/.local/bin/mise activate fish | source
else
    # Mac
	/opt/homebrew/bin/brew shellenv | source
    fish_add_path /opt/homebrew/opt/ruby/bin
    fish_add_path /opt/homebrew/opt/openjdk/bin
    fish_add_path /opt/homebrew/opt/postgresql@18/bin
end

set -gx OLLAMA_HOST 'http://localhost:11434'
set -gx UID (id -u)
set -gx GID (id -g)

fish_add_path /usr/local/go/bin
fish_add_path (go env GOPATH)/bin
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"

if command -q fzf
    fzf --fish | source
end

# zoxide
if command -q zoxide
    zoxide init fish | source
    abbr --add cd z
end

function gitignore --description "Generate a .gitignore from GitHub templates"
    if test (count $argv) -ne 1
        echo "Usage: gitignore <language>"
        return 1
    end

    gh api "gitignore/templates/$argv[1]" --jq '.source' > .gitignore
end
