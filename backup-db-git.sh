#!/bin/bash

# Open configuration file with data

if [ -f db_conf ];then 
	. db_conf
fi

# Initalize repository
git_init () {
  git init
}

# Create first commit when directory created
git_first_commit() {
  echo 'Backup database ```' $dbname '``` \n' > README.md
  git add README.md 
  git commit -m "First commit created with BackUp Database with Git support
More info https://github.com/BrunIF/backup-db-git
Created by Igor Bronovskyi 2017"
  # Add remote repository
  git remote add origin $repository_path
} 

# Commit changes when backup created
git_commit() {
  # Add dump and commit
  git add ${dbname}.sql
  git commit -m $date_now 
  # Add description to README file and commit
  echo $(date_now) 'created new backup for database ```'$dbname'``` Hash: ```'$(git rev-parse HEAD)'```'  >> README.md
  git add README.md 
  git commit -m "Previes backup: $(git rev-parse HEAD)"
} 

# Function return current date and time
date_now() {
  DATE=`date +'%Y-%m-%d %H:%M:%S'`
  echo '['$DATE'] '
}

# Create mysqdump
mysql_backup_db() {
  mysqldump -u$user -p$password $dbname > ./${dbname}.sql
}

create_directory() {

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


}

create_dump_git() {

  # Control will enter here if $DIRECTORY exists.
  cd $storepath
  echo
  echo $(date_now) "change directory" $(pwd)

  mysql_backup_db
  echo
  echo $(date_now) "Dump created"

  git_commit
  echo
  echo $(date_now) "Changes commited"

}

if [ -d "$storepath" ]; then

  create_dump_git

else

  create_directory

fi


