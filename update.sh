#!/usr/bin/env bash

repo=$GIT_REPO
user=$GIT_USER_NAME
email=$GIT_USER_EMAIL
work_path=/data/m_helm_repo
interval=${UPDATE_INTERVAL:-86400}

mkdir -p $work_path

function init(){
    git config --global user.name $user
    git config --global user.email $email

    cd $work_path
    if [ ! -d ".git" ]; then
      git init
    fi

    #git remote remove origin
    #git remote add origin $repo
    git pull origin master
}

function update(){
    mkdir -p $work_path/docs

    cd $work_path 

    echo #### Begin to update charts mirror ####
    python fetch.py
    echo #### charts mirror update complete ####

    date="`date '+%Y-%m-%d %H:%M:%S'`"

    git add --all
    git commit -a -m "update $date"
    git push -u origin master
}

init
while true; do
	update
	sleep $interval
done
