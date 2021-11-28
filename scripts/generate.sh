#!/bin/sh
. ${0%/*}/utils.sh

# Generates api code using openapi-generator
# @param api type: the parent folder for the api file inside src
# @param api version: file name for the api file, expected to be named 
# after a version
# @param generator type as specified by openapi generator
# @param config file path, of whose specs are defined by openapi generator
generate() {
  if [ -z "$(which docker)" ]; then
    echo "You need docker to run this script" && exit 1
  fi

  if [ -z "$1" ]; then
    echo "Api type is required as param 1" && exit 1
  fi

  if [ -z "$2" ]; then
    echo "Api version is required as param 2" && exit 1
  fi

  if [ -z "$3" ]; then
    echo "Output type is required as param 3" && exit 1
  fi

  if [ -z "$4" ]; then
    echo "Config file path is required as param 4" && exit 1
  fi

  API_TYPE=$(tolower $1)
  API_VERSION=$(tolower "$2")
  OUTPUT_TYPE="$3"
  CONFIG_FILE_PATH=$(echo $4 | awk '{gsub(/\.\//, ""); print}')

  SOURCE_PATH="/repo/src"
  OUTPUT_PATH="/repo/lib"

  docker run --rm \
    -v "${PWD}/src:$SOURCE_PATH" \
    -v "${PWD}/lib:$OUTPUT_PATH" \
    openapitools/openapi-generator-cli generate \
      -i "/$SOURCE_PATH/$API_TYPE/$API_VERSION.yml"\
      -g "$OUTPUT_TYPE" \
      -o "$OUTPUT_PATH/$OUTPUT_TYPE" \
      -c "$SOURCE_PATH/$CONFIG_FILE_PATH"
}

