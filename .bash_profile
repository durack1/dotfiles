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
PJD 25 Jan 2022     - Updated to latest miniconda3 (macOS), conda block updated
PJD 25 Jan 2022     - Reordered shell dotfiles before conda initialize
PJD  5 Aug 2022     - Removed shopt if statement from path,exports,aliases source as not working on linux
PJD  8 Aug 2022     - conda initialize block updated by mambaforge 4.13.0-1
PJD  8 Aug 2022     - Turned off path echos, rsync protocol version mismatch https://serverfault.com/questions/304125/rsync-seems-incompatible-with-bashrc-causes-is-your-shell-clean
PJD  9 Aug 2022     - Added back conda_setup block for linux - /home/durack1/anaconda3
PJD  9 Aug 2022     - Updated for mambaforge-4.13.0-1 update /home/durack1/mambaforge
PJD  1 Sep 2022     - Update conda_setup to use $HOME rather than platform specific paths
'''

# Create system dependent SYNCPATH
if [ `uname` == 'Darwin' ]; then
    export SYNCPATH="$HOME/sync/git/dotfiles/";
elif [ `uname` == 'Linux' ]; then
    export SYNCPATH="$HOME/git/dotfiles/";

fi

# Load the shell dotfiles last, and then some:
# * ~/.paths can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in .{paths,exports,aliases}; do
	#echo "sourcing: $SYNCPATH$file"
	[ -r "$SYNCPATH$file" ] && [ -f "$SYNCPATH$file" ] && source "$SYNCPATH$file";
done;
unset file;

# >>> conda initialize >>> ml-9953359, detect, oceanonly, crunchy
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/mambaforge/etc/profile.d/conda.sh" ]; then
        . "$HOME/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$HOME/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "$HOME/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
