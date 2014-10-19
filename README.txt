Bundles installed wiht git and pathogen in .vim/bundle needs to be added as a
submodule to do this install it as

cd ~/.myconfig/
git submodule add <repos> <path>

example to install vim-fugitive do:

cd ~/.myconfig
git submodule add \
    git://github.com/tpope/vim-fugitive.git .vim/bundle/vim-fugitive

When cloning homecfg.git you need to dot the following. First clone the
repos then update the submodules to download them as well.

cd ~
git clone git://github.com:cptBaines/homecfg.git .myconfig
cd .myconfig
git submodule update --init

Init is only needed the first time to initalize the submodule if
you instal a newer version of the moudle and wants to synchronize
you only need to run git submodule update
