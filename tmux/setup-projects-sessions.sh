echo "Killing tmux server..."
tmux kill-server
sleep 5

tmux set-option remain-on-exit on
echo "Setting up notes project session..."

tmux new-session -ds notes -c ~/Documents/notes -n editor
tmux split-w -hd "cd ~/Documents/notes ; vim ./Daily"
tmux new-window -d "cd ~/Documents/notes && lazygit"

echo "Setting up dotfiles project session..."
tmux new-session -ds dotfiles -c ~/dev/dotfiles -n editor
tmux new-window -d "cd ~/dev/dotfiles && lazygit"

echo "Setting up kernel project session..."
tmux new-session -ds kernel -c ~/dev/kernel -n editor
tmux new-window -d "cd ~/dev/kernel && lazygit"

echo "Setting up game project session..."
tmux new-session -ds game -c ~/dev/game -n editor
tmux new-window -d "cd /dev/game && lazygit"

echo "Setup all project sessions success! 🎊"
