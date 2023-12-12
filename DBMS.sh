#!/bin/bash
arr=(Create List table)
#main function
function mainMenu {
PS3="Enter a Choice : "
echo  +.......Enter Your Choice........+
select element in "Create Database" "List Databas" "Drop Database" "Connect to Database"
do 
    case $REPLY in 
        1)  #create new database
            createDB
            mainMenu;;  
        2)  #List databases
            listDBs;;
        3)  #Create table
            dropDatabase
            mainMenu;;   
        4) connectDatabase ;;
        *) echo " Please Select from menu " ; mainMenu;
    esac
done
}
function createDB {
    echo Enter Name of New Database
    read Name
        if [ -d ./Database/$Name  ]
        then
            echo This Database is already exist
        else
            mkdir ./Database/$Name
            echo Database created successfully!
        fi
}
function listDBs {
    ls ./Database
}
function connectDatabase 
{

  echo -e "Enter Database Name: \c"
  read name

  cd ./Database/$name 2> /dev/null

  if [ $? -eq 0 ]
	then
    echo "Connected to $name Successfully"
    ../../tables.sh $name
  else
    echo "Database $name wasn't found"

  fi
}
### Dropping an existing Database Function
function dropDatabase {
  echo -e "Enter Database Name: \c"
  read name

  rm -r ./Database/$name 2> /dev/null

  if [ -d $name ]
	then
    echo "Successful Drop for $name Database"
  else
    echo "Database Not found"
  
 fi
}
mainMenu
