# gha
Commonly needed GitHub Actions

## `github-access`

Allows access to private repos / orgs via Personal Access Token

usage: `trackness/gha/github-access@main`

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
    timeout-minutes: 5
    runs-on: ubuntu-latest
    steps:

      - name: Github access
        uses: trackness/gha/github-access@main
        with:
          token: <github-pat>
```

## `terraform`

Execute terraform init, validate, plan, and apply

usage: `trackness/gha/terraform@main`

### Inputs:

`working-dir`
- `terraform init` working directory
- Required: false

`destroy`
- `terraform apply` destroy flag

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

### Example uses:

```
name: Checkout some private repo

on: [push]

jobs:
  github:
    timeout-minutes: 5
    runs-on: ubuntu-latest
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
          vars: vars: "
            -var owner=$GITHUB_ACTOR \
            -var commit=$GITHUB_SHA \
            -var repo=$GITHUB_REPOSITORY
            "
```

```
name: Destroy deployed plan

on: [workflow_dispatch]

jobs:
  github:
    timeout-minutes: 5
    runs-on: ubuntu-latest
    steps:

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: 0.15.4

      - name: Destroy
        uses: trackness/gha/terraform@main
        env:
          TF_CONFIG_DIR: config
        with:
          working-dir: ${{ env.TF_WORKING_DIR }}
          backend-config: ${{ env.TF_CONFIG_DIR }}/prod.config
          var-file: ${{ env.TF_CONFIG_DIR }}/prod.tfvars
          vars: vars: "
            -var owner=$GITHUB_ACTOR \
            -var commit=$GITHUB_SHA \
            -var repo=$GITHUB_REPOSITORY
            "
          destroy: true
```

## `poetry-build`

Builds and zips a Poetry app for uploading to AWS Lambda

usage: `trackness/gha/poetry-build@main`

### Inputs:

`app-name`
- Name of the app
- Required: true

`poetry-version`
- Version of poetry to use
- Required: false

`pak-name`
- Contributing package name
- Required: false

### Outputs:

None

### Example use:

```
name: Checkout some private repo

on: [push]

jobs:
  build:
    timeout-minutes: 5
    runs-on: ubuntu-latest
    steps:

      - uses: actions/checkout@v2

      - uses: actions/setup-python@v2
        with:
          python-version: ${{ env.PYTHON_VERSION }}
    
      - name: Build and zip
        uses: ./.github/actions/poetry-build
        with:
          poetry-version: ${{ env.POETRY_VERSION }}
          app-name: ${{ env.APP_NAME }}
          pak-name: python_lambda_template
```
