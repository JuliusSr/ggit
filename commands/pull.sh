#!/bin/bash

help_message="Usage: ggit pull [<options>] [<branch>...]

Pulls specified branches.
If no branch or flag is specified it pulls only current branch.
If --all flag specified it overrides branches passed as arguments.

Options:
  -a, --all       Pull all branches. By default it only pulls branches tracked locally
  -r, --remote    Pass --remote in conjunction with all to pull all remote branches
  -s, --stash     Create stash entry before pull and apply it after the operation ends
  -h, --help      Print usage help message
"

working_branch=$(git rev-parse --abbrev-ref HEAD)

refs="refs/heads/"
all=0
branches=()
while [[ $# -gt 0 ]]; do
	case $1 in
		-a|--all)
			all=1
			shift
			;;
		-r|--remote)
			refs="refs/remotes/origin/"
			shift
			;;
		-s|--stash)
			stash=1
			shift
			;;
		-h|--help)
			echo "$help_message"
			exit 0
			;;
		-*|--**)
			echo "invalid option $1"
			exit 1
			;;
		*)
			branches+=($1)
			shift
			;;
	esac
done

if (( "$all" == 1 )) ; then
	branches=$(git for-each-ref --format='%(refname)' "$refs" | sed "s/${refs////\\/}//")
fi


if (( "$stash" == 1 )) ; then
	git stash
fi

if (( ${#branches[@]} == 0 )) ; then
	git pull
else 
	echo "branches: "
	echo "${branches[@]}"
	echo 

	for branch in ${branches[@]} ; do
		git checkout $branch
		git pull
		echo 
	done

	if [ $working_branch != $(git rev-parse --abbrev-ref HEAD) ] ; then
		git checkout $working_branch
	fi
fi

if (( "$stash" == 1 )) ; then
	git stash pop
fi
