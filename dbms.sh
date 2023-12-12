#!/bin/bash

### Connecting to an Existing Database Function
function connectDatabase 
{

  echo -e "Enter Database Name: \c"
  read name

  cd ./Database/$name 2> /dev/null

  if [ $? -eq 0 ]
	then
    echo "Connected to $name Successfully"
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

### Drop Table Function
function dropTable {
  echo -e "Enter table name to drop: \c";
  read tname;
  rm $tname .$tname 2> /dev/null

  if [ -f $tname ]
  then
    echo "Table $tname Dropped Successfully"
  else
    echo "Cannot Drop Table $tname, table may not exists"
  fi
}




function tableMenue {
    select option in "Create table" "insert into table" "drop table" "select from table"
    do 
        case $REPLY in 
        1)  #create new table
            createTable
            tableMenue;;  
        2)  #List databases
            listDBs;;
        3)  #Drop table
            dropTable;;
	4)  #Select from table
            selectAll;;     
        *) echo " Please Select from menu " ; mainMenu;
        esac
    done
}
function createTable {
    echo Please,Enter Table Name
    read tableName
    if [ -f $tableName ]
    then
        echo Table already exist
        createTable
    else
        touch $tableName
    fi
    echo Enter number of columns
    read colNum
    typeset -i i=0

    while [ $i -lt $colNum ] 
    do
        echo Enter column Name
        read colName
        echo "Enter column type"
        read colType
        if [ -z $pk ]
        then
            echo Primarykey??
            select answer in "yes" "no"
            do 
                case $REPLY in 
                1) 
                    pk=$colName
                    break;;
                2) break;;
                *) echo " Please Select from yes or no " ;;
                esac
            done
        fi
	if [ $i -eq $colNum ] 
	then
	      struct=$struct$colName
        else
		separator=":"

    	      struct=$struct$colName$separator
    	fi
	
        i=$i+1
    done
  echo -e $struct >> $tableName
    tableMenue
}

function selectAll {
  echo -e "Enter Table Name: \c"
  read tName
  column -t -s ':' $tName 2> /dev/null
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $tName"
  fi
  tableMenue
}
tableMenue


