linux user Creation Automation Script :


Overview :


This project automates the process of creating system users in Linux based on a CSV file containing user details. It consists of two main scripts:

data.sh: Collects user input (username and full name) and stores it in employee.csv.

user_mang_account.sh: Reads employee.csv, creates system users, assigns them secure random passwords, and logs all actions.

Project Structure :

File	Description
data.sh	Collects usernames and full names and appends them to employee.csv.
user_mang_account.sh Reads from employee.csv and creates users with secure passwords, logging the process.
employee.csv	Contains user records in the format username,fullname.
logfile	Logs user creation status, errors, and assigned passwords.

Prerequisites
A Linux system.

Bash shell.

Must be run with root privileges for the user.sh script.

openssl must be installed for password generation.

 Step 1: Collect User Data (data.sh)
Run the following script to input user data :
./data.sh

Actions Performed:
Prompts for:

username

full name

Asks for confirmation before saving.

Appends the data to employee.csv in the format:

username,fullname
Step 2: Create System Users (user_mang_account.sh)
Once user data is stored in employee.csv, run the following script to create users:

sudo ./user_mang_account.sh
Actions Performed:
Verifies the script is being run as root.

Checks for the existence of employee.csv.

Reads each line from the file and for each user:

Checks if the user already exists.

If not, creates the user with a home directory and full name.

Generates a secure random password using openssl.

Sets the password and forces a password change at first login.

Logs success or error messages to logfile.

