# backup old config
if [ -f ~/.tmux.conf ]; then
  mv ~/.tmux.conf ~/.tmux.conf.bak
fi

# get absolute path to current working directory
CWD="$(pwd)"
TMUX_CONF_SRC="$CWD/.tmux.conf"

# symlink new config using absolute path
ln -s -f "$TMUX_CONF_SRC" ~/.tmux.conf

# copy local config using absolute path
cp "$CWD/.tmux.conf.local" ~/.tmux.conf.local
