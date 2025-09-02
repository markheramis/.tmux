# backup old config
if [ -f ~/.tmux.conf ]; then
  cp ~/.tmux.conf ~/.tmux.conf.bak
fi

# symlink new config
ln -s -f .tmux.conf ~/.tmux.conf

# copy local config
cp .tmux.conf.local ~/.tmux.conf.local
