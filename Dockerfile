# Set args for image overrides
ARG REGISTRY=docker.io
ARG REGISTRY_PATH=library
ARG BASE_IMAGE=alpine

# # Set language-specific versioning
# ARG ELIXIR_VERSION=1.14.0
# ARG BASE_IMAGE_TAG=${ELIXIR_VERSION}-alpine
ARG BASE_IMAGE_TAG=3.16.2

# Set a base directory ARG for running the build of your app
ARG APP_DIR=/opt/app

# # Set an ARG for switching app build envs
# ARG MIX_ENV=prod
# 
# # Set any other args shared between build stages
# ARG OTP_APP=elixir_dev

# Build stage
FROM ${REGISTRY}/${REGISTRY_PATH}/${BASE_IMAGE}:${BASE_IMAGE_TAG} AS builder
# 
# # Import necessary ARGs defined at top level
ARG APP_DIR
# ARG MIX_ENV
# ARG ELIXIR_VERSION
# 
# # Persist necessary ARGs as ENVs for use in CI
# ENV ELIXIR_VERSION $ELIXIR_VERSION
# ENV MIX_ENV $MIX_ENV
# ENV MIX_HOME $APP_DIR/.mix
# ENV HEX_HOME $APP_DIR/.hex
# ENV REBAR_CACHE_DIR $APP_DIR/.cache
# 
# # Copy all src. Leverage .dockerignore to exclude unnecessary files.
# # This will copy any host directories used for local dependency
# # caching if they exist in the root of the repository.
COPY . $APP_DIR
# 
# Install OS build/test dependencies
RUN apk add --no-cache yamllint
# 
WORKDIR $APP_DIR
# 
# # Install local package manager caches if missing (see above note re: COPY . $APP_DIR)
# # Get dependencies for the currently configured environment
# # Build, overwriting any extant build artifacts copied in from the host filesystem
# RUN mix do local.hex --force --if-missing, \
#     local.rebar --force --if-missing, \
#     deps.get --only $MIX_ENV, \
#     release --overwrite
# 
# # GitHub Actions will break if any cached directories don't exist in the
# # generated container. Assure they exist
# RUN mkdir -p deps .cache .hex
# 
# # Some artifacts are generated for testing purposes only
# # If the configured env is appropriate, generate them in the container
# RUN if [ "$MIX_ENV" == "test" ]; then mix dialyzer --plt; fi
# 
# 
# Runner stage
# Using the same image as the builder assures compatibility between [build|run]time
FROM ${REGISTRY}/${REGISTRY_PATH}/${BASE_IMAGE}:${BASE_IMAGE_TAG}

# Import necessary ARGs defined at top level
ARG APP_DIR
# ARG OTP_APP
# ARG MIX_ENV
# 
# # Copy from the built directory into the runner stage at the same directory
# ARG BUILD_DIR=$APP_DIR/_build
# WORKDIR $BUILD_DIR
# COPY --from=builder $BUILD_DIR .
# 
# # Preserve the build environment in an ENV if necessary
# ENV MIX_ENV $MIX_ENV
# 
# # Set a running directory
# ARG RUN_DIR=$BUILD_DIR/$MIX_ENV/rel/$OTP_APP/bin
# WORKDIR $RUN_DIR
WORKDIR $APP_DIR
# 
# # Use CMD to allow overrides when invoked via `docker container run`
# CMD ["./elixir_dev","start"]
