#!/bin/bash

set +x
set +e

PROJECT_NAME=$1
FOLDER_NAME="Project"

if [[ $PROJECT_NAME != "" ]]
then
	FOLDER_NAME="${PROJECT_NAME}"
fi

# copy the template repository
git clone ssh://git@phab.corp.vivant.com.au/diffusion/IS/ios-seed.git "${FOLDER_NAME}"

# jump into the folder and run the configure script
cd "./${FOLDER_NAME}"

./configure "${PROJECT_NAME}"
