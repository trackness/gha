# gha
Commonly needed GitHub Actions

## github-access

Allows access to private repos / orgs via Personal Access Token

usage: `trackness/gha/github-access`

### Inputs:

`token`
- GitHub Personal Access Token
- Required: true

### Outputs:

None

### Example use:

```
name: Checkout some private repo

on: [push]

jobs:
  github:
    steps:

      - name: Github access
        uses: trackness/gha/github-access
        with:
          token: <github-pat>
```

## terraform

Execute terraform init, validate, plan, and apply

usage: `trackness/gha/terraform`

### Inputs:

`working-dir`
- `terraform init` working directory
- Required: false

`backend-config`
- `terraform init` backend config file location
- Required: false

`plan-file`
- `terraform plan` output filename
- Required: false

`var-file`
- `terraform plan` tfvars file location
- Required: false

`vars`
- `terraform plan` CLI variables
- Required: false

### Outputs:

None

### Example use:

```
name: Checkout some private repo

on: [push]

jobs:
  github:
    steps:

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: 0.15.4

      - name: Deploy
        uses: trackness/gha/terraform
        env:
          TF_CONFIG_DIR: config
        with:
          working-dir: ${{ env.TF_WORKING_DIR }}
          backend-config: ${{ env.TF_CONFIG_DIR }}/prod.config
          var-file: ${{ env.TF_CONFIG_DIR }}/prod.tfvars
          vars: """
            -var owner=$GITHUB_ACTOR \
            -var commit=$GITHUB_SHA \
            -var repo=$GITHUB_REPOSITORY
          """
```
