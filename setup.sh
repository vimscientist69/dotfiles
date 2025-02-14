sudo rm /Library/Keyboard\ Layouts/dvorak_prog_improved.keylayout
sudo cp ./keyboard/dvorak_prog_improved.keylayout /Library/Keyboard\ Layouts

if [ ! -d "$HOME/.config" ]; then
	mkdir $HOME/.config
fi

ln -s "$PWD/tmux/" "$HOME/.config/tmux"

