# Remote State Stack

This stack is for setting up and managing s3 backends for Terraform. It relies on workspaces to differentiate between different environments.

A makefile is provided to help with planning and applying to different environments. Run `make help` for more information.

## First Time Setup

1. Initialize stack and create required environment(s)

```sh
$ make init
$ make new env=dev
```

2. Create/Update the required .tfvars file(s)

```sh
$ touch dev.tfvars
```

3. Define the following variables in that file

```sh
customer    = "customerA"
application = "applicationA"
region      = "us-east-1"
environment = "dev"
```

### Subsequent Plans/Applies

```bash
$ make plan env=dev
$ make apply env=dev
```

Note: Be sure to track the resulting state file(s) in Git so other developers can make changes to the backend as necessary.
