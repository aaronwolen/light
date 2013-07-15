# !/bin/bash
#
# bootstrap: Create symbolic links for each qsub helper function in ~/bin
# Created by Aaron Wolen on 2013-07-15
# Based on https://github.com/paulmillr/dotfiles 

src_dir=$PWD
dest_dir="$HOME/bin"

if [ -d "$dest_dir" ]; then
  echo "Symbolic links will be created in $dest_dir."
else
  echo "$dest_dir does not exist."
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
} 

# Make copy of existing file (but not symbolic link) in backup directory
backup() {
  src_file="$1"
  backup_file="$2"
  if [ -f "$src_file" ] && [ ! -L "$src_file" ]; then
    echo "Existing $src_file preserved as backup/$backup_file"
    if [ ! -d "backup" ]; then mkdir backup; fi
    mv $src_file backup/$backup_file
  fi
}

for location in $src_dir/q*; do
  file="${location##*/}"  
  dest="$dest_dir/${file%.*}"
  backup $dest $file
  link "$location" "$dest"
done

exit 0;