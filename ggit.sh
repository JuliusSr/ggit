#!/bin/bash

ggit_dir="$(dirname "$0")"
ggit_commands_dir="$ggit_dir/commands"

help_message="Usage: ggit <command> [<args>] 

Commands:
	commit         Commit changes
	mergeto, mt    Merge current branch into one or more branches
  pull           Multibranch pull

Options:
  -h, --help    Print usage help message
"

while [[ $# -gt 0 ]]; do
	case $1 in
		commit)
			shift
			"$ggit_commands_dir"/commit.sh "$@"
			exit $?
			;;
		mt|mergeto)
			shift
			"$ggit_commands_dir"/mergeto.sh "$@"
			exit $?
			;;
		pull)
			shift
			"$ggit_commands_dir"/pull.sh "$@"
			exit $?
			;;
		-h|--help)
			echo "$help_message"
			exit 0
			;;
		*)
			git $@
			exit $?
			;;
	esac
done
