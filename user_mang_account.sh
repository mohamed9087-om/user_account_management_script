gen_password() {
    openssl rand -base64 12
}

CSV_FILE="employee.csv"
LOG_FILE="logfile"

# Check if the script is run as root
if [ $UID -ne 0 ]; then
    echo "The script must be run as root."
    exit 1
fi

# Check if the CSV file exists
if [ ! -f "$CSV_FILE" ]; then
    echo "CSV file not found: $CSV_FILE"
    exit 1
fi

# Read the CSV file line by line
while IFS=, read -r username fullname; do
   

    # Generate a random password
    PASSWORD=$(gen_password)

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists. Skipping creation." | tee -a "$LOG_FILE"
    else
        # Create the user with the specified username and full name
        if useradd -m -c "$fullname" -s /bin/bash "$username"; then
            # Set the initial password
            if echo "$username:$PASSWORD" | chpasswd; then
                # Force the user to change password on first login
                chage -d 0 "$username"
                echo "User '$username' created with initial password: $PASSWORD and Full Name: $fullname" | tee -a "$LOG_FILE"
            else
                echo "Failed to set password for user '$username'. Skipping user." | tee -a "$LOG_FILE"
            fi
        else
            echo "Failed to create user '$username'. Skipping user." | tee -a "$LOG_FILE"
        fi
    fi
done < "$CSV_FILE"