export $REPOS_DIR=$HOME/repos
export $SCRIPTS_DIR=$REPOS_DIR/bash_scripts

if [ -f $SCRIPTS_DIR/bashrc_addons.sh ]; then 
    . $SCRIPTS_DIR/bashrc_addons.sh; 
fi
