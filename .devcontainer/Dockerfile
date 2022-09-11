# Select a base image for developing your language
# Alpine images are preferred
#
# Elixir examples provided:
#
#   ARG BASE_IMAGE=elixir
#   ARG ELIXIR_VERSION=elixir
#   ARG BASE_IMAGE_TAG=${ELIXIR_VERSION}-alpine
ARG REGISTRY=docker.io
ARG REGISTRY_PATH=library
ARG BASE_IMAGE=alpine
ARG BASE_IMAGE_TAG=3.16.2
FROM ${REGISTRY}/${REGISTRY_PATH}/${BASE_IMAGE}:${BASE_IMAGE_TAG}

RUN apk add --no-cache bash git sudo

# Add any additional desired development tooling. Eg:
# 
RUN apk add --no-cache py3-pip yamllint
RUN pip install yamlfix

# Set environment variables for any paths that language-specific
# tooling may need for interacting with the host filesystem
#
#   ENV MIX_HOME $WORKSPACE/.mix
#   ENV HEX_HOME $WORKSPACE/.hex
#   ENV REBAR_CACHE_DIR $WORKSPACE/.cache
# 
# Set an ENV to persist the app build env as development mode
#   ENV MIX_ENV dev

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup -g $USER_GID $USERNAME \
    && adduser -s /bin/bash -u $USER_UID -G $USERNAME -h /home/$USERNAME -D $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV HOME /home/$USERNAME
