#!/bin/bash

help_message="Usage: ggit mergeto <branch> [<branch>...]

Merge current branch into one or more branches

Options:
  -s, --stash    Create stash entry before pull and apply it after the operation ends
  -h, --help     Print usage help message
"

working_branch=$(git rev-parse --abbrev-ref HEAD)

stash=0
branches=()
while [[ $# -gt 0 ]]; do
	case $1 in
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

if (( ${#branches[@]} == 0 )) ; then
	echo "no branch to merge into"
	exit 1
fi 

if (( "$stash" == 1 )) ; then
	git stash
fi

for branch in ${branches[@]} ; do
	if [ $working_branch != $branch ] ; then
		git checkout $branch
		git merge $working_branch
		echo
	fi
done

git checkout $working_branch

if (( "$stash" == 1 )) ; then
	git stash pop
fi
