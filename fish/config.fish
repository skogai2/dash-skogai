# fish configuration
#
fish_hybrid_key_bindings

# disable greeting
set -g fish_greeting

# # bootstrap fisher (plugin manager) if not installed
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
end
#
# environment: EDITOR, VISUAL, PAGER, SKOGAI_CONFIG_DIR and friends come from
# atuin dotfiles vars (loaded by conf.d/00_atuin_init.fish before this file).
# See atuin.md.

# path
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.bun/bin

# direnv
if type -q direnv
    direnv hook fish | source
end

# fzf
if type -q fzf
    fzf --fish | source
end

if type -q herdr
    herdr completion fish | source
end

if type -q codex
    codex completion fish | source
end

fish_ssh_agent

function pbcopy
    fish_clipboard_copy
end

function pbpaste
    fish_clipboard_paste
end

function fishrc
    nvim /home/skogix/.config/fish/config.fish
end

abbr -a lg lazygit
abbr -a lsa ls -la .
abbr -a lzd lazydocker
abbr -a pc paperclipai
abbr -a vim nvim

# argc-completions (ARGC_COMPLETIONS_ROOT and ARGC_COMPLETIONS_PATH from atuin)
fish_add_path "$ARGC_COMPLETIONS_ROOT/bin"
# To add completions for only the specified command, modify next line e.g. set argc_scripts cargo git
set argc_scripts (ls -1 "$ARGC_COMPLETIONS_ROOT/completions/linux" "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p')
argc --argc-completions fish $argc_scripts | source

fish_add_path "/skogai/bin/"

# pnpm (PNPM_HOME from atuin)
fish_add_path "$PNPM_HOME/bin"
