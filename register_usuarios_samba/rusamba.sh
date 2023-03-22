#!/bin/bash

function read_csv(){


  while IFS=, read col1 col2 col3 col4 col5;
  do

    echo -ne "name = ${col1} | "
    echo -ne "lastname = ${col2} | "
    echo -ne "usuario = ${col3} | "
    echo -ne "userOU = ${col4} | "
    echo -ne "userOU = ${col5} \n"
    #samba-tool user create "${col3}" --userou="${col4}"
  
  done <<< $(cat $path | tr -d '"' | cut -d "," -f 1,2,3,4,5)
  }


#main
if [ "$(id -u)" == "0" ]; then
  declare -i parameter=0; while getopts ":p:" arg;do
    case $arg in
      p) path=$OPTARG; let parameter+=1 ;;
    esac
  done
  if [ $parameter -ne 1 ]; then
    echo -e "Paratmeters no valids"
  else
    read_csv
  fi
else
  echo -e "NO PERMISSION"
fi
 
