#!/bin/bash
############################
# installdots.sh 
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Adapted from http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

mkdir ../sauce_old

########## Variables

dir=~/sauce                    # dotfiles directory
olddir=~/sauce_old             # old dotfiles backup directory
files="bashrc vimrc vim tmux.conf bash_git minttyrc gitconfig"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done

echo "Cloning Vundle so you can install your plugins ..."
git clone https://github.com/gmarik/Vundle.vim.git ~/sauce/.vim/bundle/Vundle.vim 

vim -c $(echo -e ':PluginInstall\n:q\n:q\n')
