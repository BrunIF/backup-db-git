#!/bin/bash

if [ -f db_conf ];then 
	. db_conf
fi

# need to delete
echo $user $password

git_init () {
  git init
}

git_first_commit() {
  echo 'Backup database ```' $dbname '``` \n' > README.md
  git add README.md 
  git commit -m "First commit created with BackUp Database with Git support
More info https://github.com/BrunIF/backup-db-git
Created by Igor Bronovskyi 2017"
  # Add remote repository
  git remote add origin $repository_path
} 

date_now() {
  DATE=`date +'%Y-%m-%d %H:%M:%S'`
  echo '['$DATE'] '
}

if [ -d "$storepath" ]; then
  # Control will enter here if $DIRECTORY exists.
  cd $storepath
  echo
  echo $(date_now) "change directory" $(pwd)
else
  #echo "You must create dir"
  mkdir $storepath
  echo
  echo $(date_now) "Create directory" $storepath
  
  cd $storepath
  echo
  echo $(date_now) "change directory" $(pwd)
  
  git_init
  echo
  echo $(date_now) "repository was Initialized"

  git_first_commit
  echo
  echo $(date_now) "added first commit and ready to use"
  
fi
