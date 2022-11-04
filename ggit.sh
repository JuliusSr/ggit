#!/bin/bash

ggit_dir="$(dirname "$0")"

help_message="Usage: ggit <command> [<args>] 

Options:
  -h, --help    Print usage help message
"

while [[ $# -gt 0 ]]; do
	case $1 in
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
