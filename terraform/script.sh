cd "$WORKING_DIR" || exit

destroy=$([ "$APPLY_DESTROY" == "true" ] && echo "-destroy")
backend_config=$([ -z "$BACKEND_CONFIG" ] || echo "-backend-config=$BACKEND_CONFIG")
var_file=$([ -z "$VAR_FILE" ] || echo "-var-file=$VAR_FILE ")

terraform init -no-color -input=false "$backend_config"

terraform validate

terraform plan -lock-timeout=60s -out=.terraform/"$PLAN_FILE" "$var_file$VARS"

terraform apply -lock-timeout=60s -input=false -auto-approve .terraform/"$PLAN_FILE" "$destroy"
