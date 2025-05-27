#!/bin/bash
read -p " Enter the username " username
read -p " Enter the full name " fullname

info=$username,$fullname

read -p  "Please, Confirm from data you entered. Is it correct ?[yes/no]" input

case $input in 
	yes | Yes )
		echo "$info" >> employee.csv
		echo " Your data has been stored successfully " 
		exit 1
		;;
	no | No )
		exit
		;;
	*)
		exit
		;;

esac
