# gha
Commonly needed GitHub Actions

## github-access

Allows access to private repos / orgs via Personal Access Token

### Inputs:

`token`: GitHub Personal Access Token

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