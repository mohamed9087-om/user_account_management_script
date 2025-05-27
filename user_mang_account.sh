#!/bin/bash
csv_file="employee.csv"

if [ "$UID" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

if [ ! -f "$csv_file" ]; then
    echo "The file was not found: $csv_file"
    exit 1
fi

while IFS=, read -r username full_name; do
    # Skip empty usernames
    if [ -z "$username" ]; then
        echo "Skipping entry with empty username"
        continue
    fi

    password=$(openssl rand -base64 15)
    if useradd -m -c "$full_name" "$username"; then
        echo "$username:$password" | chpasswd
        chage -d 0 "$username"
        echo "User created : $username"
        echo "Random password : $password"
        echo "Full name : $full_name"
        echo
        echo "$username,$password" >> out.txt
    else
        echo "Failed to create user: $username"
    fi
done < "$csv_file"

echo "User creation done."
