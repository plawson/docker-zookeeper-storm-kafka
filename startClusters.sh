#!/bin/bash

function usage {
	echo "$0: [-h] --datadisk DATADISK COMMAND"
	echo "arguments:"
	echo -e "\t-h, --help\t\t\t\tshow this help message and exit"
	echo -e "\t-d DATADISK, --datadisk DATADISK\tProvide the root directory where clusters daa directory are located"
	exit
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
	key="$1"
	case $key in
		-d|--datadisk)
		export DATA_DISK="$2"
		shift # past argument
		shift # past value
		;;
		-h|--help)
		usage
		;;
		*) # unknown option
		POSITIONAL+=("$1") # save it in an array for later
		shift # past argument
		;;
	esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z "${DATA_DISK// }" ]]; then
	usage
fi

if [[ $# -eq 0 ]]; then
	echo ""
	echo "ERROR: Command is missing"
	echo ""
	usage
fi

docker-compose $*
