#!/bin/zsh
PROJECT_NAME=$1
PROJECT_PATH=$2

# If the user did not specify a project path,
# create it at the current working directory
if [[ -z $PROJECT_PATH ]]; then
    PROJECT_NAME=$(pwd)/$PROJECT_NAME
else
    PROJECT_PATH=$(realpath $PROJECT_PATH)
fi

# Handle the presence of a project directory
if [[ -f $PROJECT_PATH ]]; then
    echo "File at path $PROJECT_PATH already exists, bailing"
    exit 1
elif [[ -d $PROJECT_PATH ]]; then
    echo "Directory already exists at $PROJECT_PATH, skipping creation"
    EXISTING_DIR=1
else
    echo "Creating directory for project at $PROJECT_PATH"
    mkdir -p $PROJECT_PATH
    EXISTING_DIR=0
fi

#########################################################################
# Obtain the project title
#########################################################################
PROJECT_TITLE="programming $PROJECT_NAME"

read "REPLY?The title for this project will be '$PROJECT_TITLE'. Would you like to change it? [y/N]: "

if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
    read "PROJECT_TITLE?Please enter the project title: "
fi

#########################################################################
# Obtain the project description
#########################################################################
read "PROJECT_DESC?Please enter a description for this project: "

#########################################################################
# Obtain the project repository name
#########################################################################
PROJECT_REPO="john-craig/$PROJECT_NAME"

read "REPLY?The Gitea repository for this project will be '$PROJECT_REPO'. Would you like to change it? [y\N]: "

if [[ "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
    read "PROJECT_REPO?Please enter the name to use for the Gitea repository: "
fi

#########################################################################
# Create the project repository, if necessary
#########################################################################
if ! $(tea repo list -o json | grep -q "gitea.chiliahedron.wtf:$PROJECT_REPO.git"); then
    echo "Creating new Gitea repository for this project"

    EXISTING_REPO=0
else
    echo "A Gitea repository with the name '$PROJECT_REPO' already exists"
    EXISTING_REPO=1
fi

# TODO: if there is an EXISTING_DIR=1, check to see the following:
#       1) is the directory empty? If so, do nothing
#       2) does the directory contain an existing Git repository?
#           2a) is the origin URL of the repository set to the SSH URL of the 
#               project repository? If not, bail.
#       3) if the directory not empty, but also does not contain a Git repo?
#          If so, prompt the user before cloning into it
#
# TODO: create a repository file in the vault for this project
#       this needs to have:
#        - $REPO_TITLE, e.g. "repository faustroll"
#        - $PROJECT_TAGS, optional, maybe a v2 thing
#        - $PROJECT_TITLE_PROPERCASE, e.g. "Repository Faustroll"
#        - $PROJECT_HTTP_URL, e.g. "https://gitea.chiliahedron.wtf/john-craig/faustroll"
#
# REPO_FILE="$VAULT_PATH/repositories/$REPO_TITLE"
# echo "Category: #repository" > $PROJECT_FILE
# echo "Tags: $PROJECT_TAGS" > $PROJECT_FILE
# echo "# Repository $PROJECT_TITLE_PROPERCASE" > $PROJECT_FILE
# echo "" > $PROJECT_FILE
# echo "**Internal URL:** $PROJECT_HTTP_URL" > $PROJECT_FILE
# echo "**Public URL:** N/A" > $PROJECT_FILE
# echo "**Local Path:** $PROJECT_PATH" > $PROJECT_FILE