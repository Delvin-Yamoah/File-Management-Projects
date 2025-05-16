#!/bin/bash

# This function helps show how to use the script
usage() {
  echo "Usage:"
  echo "  To encrypt a file: $0 -e file_to_encrypt"
  echo "  To decrypt a file: $0 -d file_to_decrypt.gpg"
  exit 1
}

# Check if GPG is installed
if ! command -v gpg &> /dev/null; then
  echo "GPG is not installed. Please install it first."
  exit 1
fi

# Ask the user if they want to encrypt or decrypt
echo "Do you want to (e)ncrypt or (d)ecrypt a file? (e/d)"
read ACTION

# If the user chooses to encrypt
if [ "$ACTION" == "e" ]; then
  echo "Enter the path of the file you want to encrypt (e.g., file.txt):"
  read FILE_TO_ENCRYPT
  if [ ! -f "$FILE_TO_ENCRYPT" ]; then
    echo "File does not exist. Exiting."
    exit 1
  fi
  
  # Ask for password to encrypt the file
  echo "Enter a password to encrypt the file:"
  read -s PASSWORD  # -s hides the password input
  
  # Encrypt the file
  echo "$PASSWORD" | gpg --batch --yes --passphrase-fd 0 -c "$FILE_TO_ENCRYPT"
  if [ $? -eq 0 ]; then
    echo "File encrypted successfully! The encrypted file is $FILE_TO_ENCRYPT.gpg"
  else
    echo "Encryption failed."
  fi

# If the user chooses to decrypt
elif [ "$ACTION" == "d" ]; then
  echo "Enter the path of the encrypted file you want to decrypt (e.g., file.txt.gpg):"
  read FILE_TO_DECRYPT
  if [ ! -f "$FILE_TO_DECRYPT" ]; then
    echo "Encrypted file does not exist. Exiting."
    exit 1
  fi
  
  # Ask for password to decrypt the file
  echo "Enter the password to decrypt the file:"
  read -s PASSWORD  # -s hides the password input
  
  # Decrypt the file
  echo "$PASSWORD" | gpg --batch --yes --passphrase-fd 0 -o "${FILE_TO_DECRYPT%.gpg}" -d "$FILE_TO_DECRYPT"
  if [ $? -eq 0 ]; then
    echo "File decrypted successfully! The decrypted file is ${FILE_TO_DECRYPT%.gpg}"
  else
    echo "Decryption failed. Please check the password."
  fi

else
  # Show usage if the input is invalid
  usage
fi
