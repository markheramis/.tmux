if [ -f $HOME/.tmux.conf ]; then
  mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
fi
if [ -f $HOME/.tmux.conf.local ]; then
  mv $HOME/.tmux.conf.local $HOME/.tmux.conf.local.bak
fi
ln -s $(pwd)/config/.tmux.conf $HOME/.tmux.conf
cp $(pwd)/config/.tmux.conf.local $HOME/.tmux.conf.local