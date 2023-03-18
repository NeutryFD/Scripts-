#!/bin/bash

function read_user_csv(){


  while IFS=, read col1 col2 col3 col4 col5;
  do

    echo -ne "name = ${col1} | "
    echo -ne "lastname = ${col2} | "
    echo -ne "usuario = ${col3} | "
    echo -ne "userOU = ${col4}  |"
    echo -ne "userOU = ${col5} \n"
    samba-tool user create "${col3}" --userou="${col4},${col5}"

  done <<< $(cat $file | tr -d '"' | cut -d "," -f 1,2,3,4,5)
  }

function read_user_pass_csv(){

  while IFS=, read col1 col2 col3 col4 col5;
  do

    echo -ne "name = ${col1} | "
    echo -ne "lastname = ${col2} | "
    echo -ne "usuario = ${col3} | "
    echo -ne "userOU = ${col4}  |"
    echo -ne "userOU = ${col5} \n"
    samba-tool user create "${col3}" "${pass}" --userou="${col4},${col5}"

  done <<< $(cat $file | tr -d '"' | cut -d "," -f 1,2,3,4,5)
  }

function help (){
    echo -e "./runsamba -f {file.csv}"
    echo -e "./runsamba -f {file.csv} -p{password for the users}"
}

#main
if [ "$(id -u)" == "0" ]; then
  declare -i parameter=0; while getopts ":f:p:h" arg;do
    case $arg in
      f) file=$OPTARG; let parameter=1 ;;
      p) pass=$OPTARG; let parameter=2 ;;
      h) help=$OPTARG; let parameter=5 ;;
     esac
  done
  if [ $parameter -eq 1 ]; then
    if  [ -f $file ]; then
	if [ "$(wc -w $file | awk '{print$1}')" -eq 0 ]; then
	   echo -e " file No nada"
	else
	   read_user_csv
	fi
    else
	echo -e "file no exits"
    fi
  elif [ $parameter -eq 2 ]; then
	echo "hola"
    if [ -z $pass ]; then
	echo -e "No password stablished"
    else
	read_user_pass_csv
    fi
  elif [ $parameter -eq 5 ]; then
    help
  else
    echo -e "parameter invalid \n -h for help"
  fi
else
  echo -e "NO PERMISSION"
fi
