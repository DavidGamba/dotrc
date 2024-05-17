# cdd allows you to cd to the directory of the given file or directory
function cdd()
{
	if [[ $# -eq 0 ]]; then
		cd
	elif [[ "$1" == "-" ]]; then
		cd "$*"
	elif [[ -d "$*" ]]; then
		cd "$*"
	elif [[ -f "$*" ]]; then
		echo "WARNING: file given, cd to file's dirname" 1>&2
		local dir
		dir=$(dirname "$*")
		cd "$dir"
	elif [[ "$1" == *"/"* ]]; then
		cd "$*"
	else
		# Try to use the given target as an element in the path
		# Example:
		# tree:
		# /home/david/
		#    dev/a/b
		#    qa/a/b
		#    prod/a/b
		# PWD=/home/david/dev/a/b
		# $ cd qa
		# will change dir to /home/david/qa/a/b
		local dir
		dir=$(__cdd_find_in_path "$*")
		# >&2 echo "found: $dir"
		retval=$?
		if [[ $retval -ne 1 ]]; then
			local rel
			if [[ $(uname) =~ "Darwin" ]]; then
				rel=$(echo "$PWD" | sed -E "s#^$dir/[^/]+##")
			else
				rel=$(echo "$PWD" | sed "s#^$dir/[^/]\+##")
			fi
			# >&2 echo "pwd $PWD, dir $dir, rel $rel"
			# >&2 echo "$dir/$1/$rel"
			if [[ -d "$dir/$1/$rel" ]]; then
				cd "$dir/$1/$rel"
			elif [ -d $dir/*$1/$rel ]; then
				cd $dir/*$1/$rel
			elif [ -d $dir/$1*/$rel ]; then
				cd $dir/$1*/$rel
			else
				cd $dir/$1/$rel
			fi
		else
			cd "$*"
		fi
	fi
}

# Returns the top level dir
# Input can be either the full dirname or its prefix or suffix
# For this to work, the prefix or suffix glob must return a single result.
function __cdd_find_in_path()
{
	local dir
	dir="../$(dirname "$1")"
	local base
	base=$(basename "$1")

	# >&2 echo "searching for $1, recursing to $dir, $dir/*$base*"
	if [[ -d "../$1" ]]; then
		realpath "$dir"
		return 0
	elif [ -d $dir/*$base ]; then
		# suffix
		realpath "$dir"
		return 0
	elif [ -d $dir/$base* ]; then
		# prefix
		realpath "$dir"
		return 0
	else
		if [[ $(realpath "$dir") == "/" ]]; then
			return 1
		fi
		__cdd_find_in_path "../$1"
	fi
}

function cs()
{
	cdd $* && ls
}

# vim:filetype=bash
