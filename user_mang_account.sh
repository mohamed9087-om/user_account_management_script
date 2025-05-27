
#!/bin/bash

csv_file="employee.csv"
log="logfile"

if [ "$UID" -ne 0  ]
then
        echo " this script must be run as root " | tee -a "$log"
        exit 1
fi
if [ ! -f "$csv_file" ]
then
        echo "csv file not found : $csv_file" | tee -a "$log"
        exit 1
fi
while IFS=, read -r username full_name
do
        password=$(openssl rand -base64 12)
        useradd -m -c "$full_name" "$username"
        echo "$username:$password" | chpasswd
        chage -d 0 "$username"
        echo "user created : $username"
        echo "full_name : $full_name"
        echo "random password : $password"
        echo
        echo "$username,$password" >> out.txt
done < $csv_file
echo "user creation completed"
