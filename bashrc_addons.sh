export PATH=$PATH:~/bin:/usr/texbin:$DCF_ROOT/bin:~/repos/androidsigning/tools:~/apportable/apportable_sdk/toolchain/macosx/android-sdk/platform-tools
export PS1='[\[\e[0;35m\]\d, \t\e[0m\] \u \[\033[0;36m\]\W\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")]\$ ' 

### ALIASES

alias t='todo.sh'

alias todo='mvim $HOME/Dropbox/todo/todo.txt'
#open worklog editor
alias wlog='vim $HOME/Dropbox/todo/worklog'

alias gs='git status'
alias gf='git fetch'
alias gc='git checkout'
alias grhh='git reset --hard head'
alias rebase='git pull --rebase origin'
alias push='git push origin'
alias gsu='git submodule update --recursive --init'

alias gitk='gitk 2> /dev/null 1> /dev/null'

alias rr='cd $HOME/repos/rescuerangers'
alias dr='cd $HOME/repos/dragons3d'
alias pgengine='cd $HOME/repos/dragons3d/Externals/pgengine'
alias pgcommon='cd $HOME/repos/dragons3d/Externals/pgengine/Externals/pgcommon'

### FUNCTIONS

editbashrc() {
	subl $HOME/.bashrc
}

latestLog() {
	git log -1 | grep "^commit [a-z0-9]*$" -m1 | sed 's/commit //'
}

rewrite_tmxs_in_folder() {
	for file in *.tmx; do
		replace_tmx $file
	done	
}

replace_tmx() {
	if [ $# = 0 ]
	then
		echo "No tmx file specified."
		return -1
	fi
	TEMP_FILE=temp_tmx_file
	sed 's/\.\.\/\.\.\/\.\.\/Resources\/Assets/\.\./g' < $1 > $TEMP_FILE
	rm $1
	mv $TEMP_FILE $1
}

#####################
# OBSOLETE: ANDROID!!
#####################

alias prebuild='./Tools/AndroidScripts/prebuild.py'
export DCF_ROOT=~/apportable/apportable_sdk

rr_prebuild_and_build () {
	rr
	prebuild
	dt build
}

rr_open_filtered_gamelog () {
	if [ $# = 0 ]
	then
		echo "No filename specified."
		return -1
	fi	
	echo "Opening the gamelog with PG-only logs..."
	NEW_FILENAME=$1"_cleared"
	GREP_SUFFIX=$(cat $1 | grep "PGGameLog:" | sed 's/PGGameLog.*//' | sed 's/^.*(//' | sed 's/)://' | uniq | awk '{for(i=0;++i<=NF;) printf " -e " $i}END{printf "\n"}')
	cat $1 | grep $GREP_SUFFIX > $NEW_FILENAME
	subl $NEW_FILENAME
}

rr_remove_generated_parameters () {
	rr
	find . -name generated*json* | xargs rm
}

rr_get_into_apk () {
	echo "run-as com.pocketgems.android.animalvoyage" | adb shell
}

export_sqlite () {
	if [ $# = 0 ]
	then
		echo "No export filename specified."
		return -1
	fi

	DIR=temp_dir_gamestate
	rm -rf DIR
	mkdir DIR
	cd DIR
	adb pull /mnt/sdcard/com.pocketgems.gameState .
	unzip com.pocketgems.gameState
	mv rescue.sqlite ../$1".sqlite"
	cd ..
	rm -rf DIR
}

copy_game_state () {
	adb pull /mnt/sdcard/com.pocketgems.gameState .
}

#####################
# OBSOLETE: ANDROID!!
#####################
