#.bash_profile for use across *nix and MacOS systems

: '''
This file captures a number of environment-specific configurations that are
shared across *nix and MacOS systems. For guidance, a number of references are
worth noting:
    https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
    https://github.com/webpro/dotfiles/blob/master/runcom/.bash_profile
    https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
    https://github.com/doutriaux1/dotfiles/blob/master/.bashrc
    https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html#Bash-Startup-Files - .bash_profile vs .bashrc vs .profile etc

PJD 20 May 2020     - Initialized file
PJD  1 Jul 2021     - Updated with new durack1ml/MacOS11.4 paths
PJD 22 Jul 2021     - Updated to deal with system paths - MacOS/Linux; SYNCPATH set system-dependent
PJD 22 Jul 2021     - .bashrc symlink to .bash_profile created for RHEL7
PJD 26 Jul 2021     - Convert echos to only interactive (not login) shell
PJD 15 Sep 2021     - Updated some path issues across files, overwrite conda precedence with shell dotfile load last
'''

# Create system dependent SYNCPATH
if [ `uname` == 'Linux' ]; then
    export SYNCPATH="$HOME/git/dotfiles/";
elif [ `uname` == 'Darwin' ]; then
    export SYNCPATH="$HOME/sync/git/dotfiles/";
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Case Linux
if [ `uname` == 'Linux' ]; then
	__conda_setup="$('/home/durack1/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "/home/durack1/anaconda3/etc/profile.d/conda.sh" ]; then
		. "/home/durack1/anaconda3/etc/profile.d/conda.sh"
	    else
		export PATH="/home/durack1/anaconda3/bin:$PATH"
	    fi
	fi
# Case MacOS
elif [ `uname` == 'Darwin' ]; then
	__conda_setup="$('/Users/durack1/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
	    eval "$__conda_setup"
	else
	    if [ -f "/Users/durack1/opt/anaconda3/etc/profile.d/conda.sh" ]; then
	        . "/Users/durack1/opt/anaconda3/etc/profile.d/conda.sh"
	    else
	        export PATH="/Users/durack1/opt/anaconda3/bin:$PATH"
	    fi
	fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Load the shell dotfiles last, and then some:
# * ~/.paths can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
if shopt -q login_shell; then
    for file in .{paths,exports,aliases}; do
    	echo "sourcing file: $SYNCPATH$file"
    	[ -r "$SYNCPATH$file" ] && [ -f "$SYNCPATH$file" ] && source "$SYNCPATH$file";
    done;
    unset file;
fi