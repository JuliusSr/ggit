#!/bin/bash

ggit_dir="$(dirname "$0")"

help_message="Usage: ggit <command> [<args>] 

Commands:
	mergeto, mt    Merge current branch into one or more branches
  pull           Multibranch pull

Options:
  -h, --help    Print usage help message
"

while [[ $# -gt 0 ]]; do
	case $1 in
		mt|mergeto)
			shift
			"$ggit_dir"/commands/mergeto.sh $@
			exit $?
			;;
		pull)
			shift
			"$ggit_dir"/commands/pull.sh $@
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
