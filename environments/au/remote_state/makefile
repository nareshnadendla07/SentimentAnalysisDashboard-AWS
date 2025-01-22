help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

init:           ## initialize terraform. Ex. $ make init
	terraform init

new:            ## create new workspace/env. Ex. $ make new env=prod
	echo "creating new workspace $(env)"
	terraform workspace new $(env)

list:           ## list workspaces/envs. Ex. $ make list
	echo "listing workspaces"
	terraform workspace list

delete:         ## delete workspace/env. Ex. $ make delete env=test
	echo "deleting workspace $(env)"
	terraform workspace select default
	terraform workspace delete $(env)

plan:           ## run a plan against an env. Ex. $ make plan env=dev
	echo "running plan against $(env)"
	terraform workspace select $(env)
	terraform plan -var-file="$(env).tfvars"

apply:          ## run an apply against an env. Ex. $ make apply env=dev
	echo "running apply against $(env)"
	terraform workspace select $(env)
	terraform apply -var-file="$(env).tfvars"

destroy:		## run an destroy against an env. Ex. $ make destroy env=dev
	echo "running destroy against $(env)"
	terraform workspace select $(env)
	terraform destroy -var-file="$(env).tfvars"
