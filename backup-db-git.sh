#!/bin/bash


if [ -f db_conf ];then 
	. db_conf
fi

echo $user $password

git_init () {
  git init
  git add .
  git commit -m "First commit created with BackUp Database with Git support\nCreated by Igor Bronovskyi 2017"
}

if [ -d "$storepath" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "Dir exists"
  cd $storepath
  pwd
  git_init
else
  echo "You must create dir"
  mkdir $storepath
fi
