#!/bin/bash

function linkconfig() {
	local src=$1
	local tgt=$2
	local backup=${tgt}.myconf.bak

	if [[ ! -e ${src} ]]; then
		echo "No such source ${src}"
		return
	fi

	# If target exists and is a link
	if [[ -L ${tgt} ]]; then
		local oldsrc=`readlink ${tgt}`
		if [[ ${oldsrc} == ${src} ]]; then
		# target already linked to ${src} nothing to do
			echo "Target already linked ${tgt} -> ${src}"
			return
		else
		# move link 
			echo "Backing up old link ${oldsrc} to ${backup}"
			ln -sf ${oldsrc} ${backup}
			rm ${tgt}
		fi
	fi
	
	# If target exists and is a directory
	if [[ -d ${tgt} ]]; then
		# target dir exists move it out of the way
		echo "Backing up old directory ${tgt} to ${backup}"
      		mv ${tgt} ${backup}		
	fi

	if [[ -f ${tgt} ]]; then
		# target file exists move it out of the way
		echo "Backing up old file ${tgt} to ${backup}"
      		mv ${tgt} ${backup}
	fi

	# link target
	echo "installing ${tgt}"
	ln -s ${src} ${tgt}
}

# link vim config 
cd $HOME
linkconfig .myconfig/.vim .vim
linkconfig .myconfig/.vimrc .vimrc
