#!/bin/bash

ggit_commands_dir="$(dirname "$0")"

help_message="Usage: ggit commit [<options>]

Commit changes into current branch

Options:
  -a, --add         Add changes to staging
  -m, --message     Commit with message
  -mt, --mergeto    Merge to other branches after commit
  -p, --push        Push commit to remote
  -h, --help        Print usage help message
"

working_branch=$(git rev-parse --abbrev-ref HEAD)

message=""
add=0
merge=0
merge_branches=()
push=0
wtc=0
while [[ $# -gt 0 ]]; do
	case $1 in
		-a|--add)
			add=1
			shift
			;;
		-m|--message)
			message="$2"
			shift
			shift
			;;
		-mt|--mergeto)
			merge=1
			shift
			while [[ $# -gt 0 ]] ; do
				if [[ "$1" == -* ]] ; then
					break
				fi
				merge_branches+=("$1")
				shift
			done
			;;
		-p|--push)
			push=1
			shift
			;;
		-wtc|--whatthecommit)
			wtc=1
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
			echo "invalid argument $1"
			exit 1
			;;
	esac
done

wtc() {
	response=$(curl -s 'https://whatthecommit.com/')
	if [[ "$OSTYPE" == "darwin"* ]]; then
		message=$(echo "$response" | ggrep -oP '<p>\K.*')
	else
		message=$(echo "$response" | grep -oP '<p>\K.*')
	fi
	echo "$message"
}

if (( "$add" == 1 )) ; then
	git add .
fi

if (( "$wtc" == 1 )); then
	message=$(wtc)
fi

if [ "$message" != "" ] ; then
	git commit -m "$message"
else
	git commit
fi

if (( "$push" == 1 )) ; then
	git push
fi

if (( "$merge" == 1 )) ; then
	if (( "$push" == 1 )) ; then
		"$ggit_commands_dir"/mergeto.sh ${merge_branches[@]} --push
	else
		"$ggit_commands_dir"/mergeto.sh ${merge_branches[@]}
	fi
fi
