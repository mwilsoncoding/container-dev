# container-dev

An opinionated, language-agnostic, starting point for containerized development.

This is a repo from which similarly-opinionated, language-specific, template repos are derived.

Language-specific derivations of this repo:

## How to Use

- Follow [the official instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) on creating a new repo from a template.
- Create a new project in the new repo's root directory and modify the template as needed

### Examples

In the following examples, `$MY_NEW_REPO_ACCESS_LEVEL` is either `--public` or `--private`

Modification of a number of these template files is dependent on language choice.

#### Elixir

Check out [the Elixir template](https://github.com/mwilsoncoding/container-dev-elixir)

```console
MY_NEW_REPO=container-dev-elixir
MY_NEW_REPO_ACCESS_LEVEL=--public
OTP_APP=my_app
gh repo create $MY_NEW_REPO $MY_NEW_REPO_ACCESS_LEVEL --template mwilsoncoding/container-dev
cd $MY_NEW_REPO
docker run \
  --rm \
  -it \
  -v $(pwd):/workspace \
  -w /workspace \
  -e OTP_APP \
  elixir:1.14.0-alpine \
  mix new --app $OTP_APP .
```
