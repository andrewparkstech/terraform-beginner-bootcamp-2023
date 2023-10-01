# Terraform Beginner Bootcamp 2023

## Semantic Versioning

This project is going to utilize semantic vrsioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest CLI installation instructions via Terraform documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntun.
Please consider checking your Linux distribution and change according to your needs.

[How to check Linux OS version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version:
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg issues, we noticed that steps included a considerable amount of code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the GitPod YML file clean. ([.gitpod.yml](.gitpod.yml))
- This will make it easier to debug and execute
- This will allow better portability for other projects that need to install Terraform CLI

#### Shebang

A Shebang (pronounced sha-Bang) tells the shell which program should execute the script

ChatGPT recommends we use this format for bash: `#!/usr/bin/env bash`
- for portability on different OS distributions
- will search user's PATH for bash executable

#### Execution considerations
When executing the bash script, we can use the `./` shorthand notation.
eg. `./bin/install_terraform_cli`
If we are using a script in gitpod.yml, we need to specify the program to run the script
eg. `source ./bin/install_terraform_cli`

[Shebang Docs](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Linux Permissions

In order to make our bash scripts executable, we need to change the permissions on the file:
```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

[Linux Permissions](https://en.wikipedia.org/wiki/Chmod)

### Gitpod Lifecycle (before, init, command)
Be careful with `init` because it will not run if we restart an existing workspace
[GitPod task types](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Environment Variables

We can list out all environment variables (Env Vars) using the `env` command.

We can filter specific env vars using grep. eg. `env | grep AWS_`

#### Setting and unsetting Env Vars

In the terminal, we can set using `export VARNAME='VALUE'`

    and unset using `unset VARNAME`

We can set an env var temporarily when running a comamnd:

```
VARNAME='value' ./bin/print_message
```

Within a bash script, we can set an env var without writing export:

```
#!/usr/bin/env bash
VARNAME='value'
echo $VARNAME
```

#### Printing Env Vars

We can print an env var using echo eg. `echo $VARNAME`

#### Scope of env vars

When you open up new bash terminals in VS Code, they will not be aware of the env vars in other terminals.
If you want env vars to persist across all terminals, you need to set env vars in your bash profile. eg. `.bash_profile`

#### Gitpod persisting env vars

We can persist env vars in Gitpod by storing them in Gitpod Environment Varables.
```
gp env VARNAME='value'
```

All future workspaces launched will use this value for all terminals.

You can also set env vars in `gitpod.yml` but this should only be used with non-sensitive values.


### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is succesful, you should see a json payload returned that looks like this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM in order to use the AWS CLI.


## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we must run `terraform init` to download the binaries for the terraform providers that we'll use in the project.

#### Terraform Plan

`terraform plan`

This will generate a plan showing what will change based on our terraform code.

We can output this plan or changeset to a file if you want, but it's not required.

#### Terraform Apply

`terraform apply`

This will run the plan which will deploy/modify/destroy infrasturcture as needed. Apply should prompt yes or no.

If we want to automatically approve, we can provide the auto approve flag: `terraform apply --auto-approve`

#### Terraform Destroy

`teraform destroy` will destroy resources.

You can also use the auto approve flag to skip the approve prompt:
`terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VCS) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.