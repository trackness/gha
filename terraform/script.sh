
echo "$WORKING_DIR"
echo "$BACKEND_CONFIG"
echo "$PLAN_FILE"

_DESTROY=$([ -z "$DESTROY" ] || echo "-destroy")

echo "$_DESTROY"

#function args() {
#
#	while getopts ":w:d:b:p:f:v:" arg; do
#	do
#		case $arg in
#			w) WORKING_DIR=$OPTARG;;
#			d) DESTROY=$OPTARG;;
#			b) BACKEND_CONFIG=$([ -z ${{ inputs.backend-config }} ] || echo "-backend-config=${{ inputs.backend-config }}");;
#			p) PLAN_FILE=$OPTARG;;
#			f) VAR_FILE=$OPTARG;;
#			v) VARS=$OPTARG;;
#		esac
#	done
#}