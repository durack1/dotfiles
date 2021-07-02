#.bash_profile for use across *nix and MacOS systems

: '''
This file captures a number of environment-specific configurations that are
shared across *nix and MacOS systems. For guidance, a number of references are
worth noting:
    https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
    https://github.com/webpro/dotfiles/blob/master/runcom/.bash_profile
    https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
    https://github.com/doutriaux1/dotfiles/blob/master/.bashrc

PJD 20 May 2020 	- Initialized file
PJD  1 Jul 2021 	- Updated with new durack1ml/MacOS11.4 paths
'''

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export SYNCPATH="$HOME/sync/git/dotfiles/";

# Load the shell dotfiles, and then some:
# * ~/.paths can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in .{paths,exports,aliases}; do
	echo "sourcing file: $SYNCPATH$file"
	[ -r "$SYNCPATH$file" ] && [ -f "$SYNCPATH$file" ] && source "$SYNCPATH$file";
done;
unset file;
