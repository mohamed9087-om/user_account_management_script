read -p " Enter the username " username
read -p " Enter the full name " fullname

info=$username,$fullname
CSV_FILE=employee.csv
read -p  "Please, Confirm from data you entered. Is it correct ?[y/n]" input

case $input in 
	yes | Yes )
		echo "$info" >> $CSV_FILE
		echo " Your data has been stored successfully " 
		exit 0
		;;
	no | No )
		exit
		;;
	*)
		exit
		;;

esac