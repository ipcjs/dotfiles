
sudo apt-get update
sudo apt-get install -y git
git clone https://github.com/ipcjs/dotfiles.git

DIR=$(pwd)
REPO_DIR=${DIR}/dotfiles

echo "source $REPO_DIR/etc/init.sh" >> ~/.bashrc