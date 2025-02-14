# echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ ! -d "$HOME/.config" ]; then
	echo "creating `.config`..."
	mkdir $HOME/.config
fi

echo "Installing Github CLI..."
brew install gh

echo "Installing Alacritty..."
brew install --cask alacritty

echo "Installing Aerospace..."
brew install --cask nikitabobko/tap/aerospace

echo "Installing Obsidian..."
brew install --cask obsidian

echo "Installing Google Chrome..."
brew install --cask google-chrome

echo "Installing Commitizen..."
brew install commitizen

echo "Installing zsh-autocomplete..."
brew install zsh-autocomplete

echo "Installing zsh-autosuggestions..."
brew install zsh-autosuggestions

echo "Installing zsh-syntax-highlighting..."
brew install zsh-syntax-highlighting

echo "Installing zoxide (better cd)..."
brew install zoxide

echo "Installing eza (better ls)..."
brew install eza

echo "Installing Lazygit..."
brew install jesseduffield/lazygit/lazygit

echo "Moving tmux config to config..." 
rm -rf "$HOME/.config/tmux"
ln -s "$PWD/tmux/" "$HOME/.config/tmux"

echo "Moving gitconfig config to home..." 
rm -rf "$HOME/.gitconfig"
ln -s "$PWD/gitconfig" "$HOME/.gitconfig"

echo "Moving Alacritty config to config..." 
rm -rf "$HOME/.config/alacritty"
ln -s "$PWD/alacritty/" "$HOME/.config/alacritty"

echo "Moving Aerospace config to config..." 
rm -rf "$HOME/.config/aerospace"
ln -s "$PWD/aerospace/" "$HOME/.config/aerospace"

echo "Moving Lazygit config to config..." 
rm -rf $HOME/Library/Application\ Support/lazygit
ln -s "$PWD/lazygit/" $HOME/Library/Application\ Support/lazygit

echo "Moving zshrc config to home..." 
rm -rf $HOME/.zshrc
ln -s "$PWD/zshrc" "$HOME/.zshrc"

echo "Moving shell prompt config to home..." 
rm -rf $HOME/.p10k.zsh
ln -s "$PWD/p10k.zsh" "$HOME/.p10k.zsh"

echo "Moving vimrc config to home..." 
rm -rf $HOME/.vimrc
ln -s "$PWD/vimrc" "$HOME/.vimrc"

echo "Installing nerd font..."
brew install font-meslo-lg-nerd-font

echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing powerleve10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Moving keyboard layout to input sources..."
sudo rm /Library/Keyboard\ Layouts/dvorak_prog_improved.keylayout
sudo cp ./keyboard/dvorak_prog_improved.keylayout /Library/Keyboard\ Layouts
 
echo "Authenticating with Github CLI..."
gh auth login
