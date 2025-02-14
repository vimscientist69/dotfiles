echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Moving keyboard layout to input sources..."
sudo rm /Library/Keyboard\ Layouts/dvorak_prog_improved.keylayout
sudo cp ./keyboard/dvorak_prog_improved.keylayout /Library/Keyboard\ Layouts

if [ ! -d "$HOME/.config" ]; then
	echo "creating `.config`..."
	mkdir $HOME/.config
fi

echo "Moving tmux config to config..." 
ln -s "$PWD/tmux/" "$HOME/.config/tmux"

echo "Moving tmux config to home..." 
ln -s "$PWD/gitconfig/" "$HOME/.gitconfig"

echo "Installing Github CLI..."
brew install gh

echo "Authenticating with github cli..."
gh auth login

echo "Installing Obsidian..."
brew install --cask obsidian

echo "Installing Lazygit..."
brew install jesseduffield/lazygit/lazygit
