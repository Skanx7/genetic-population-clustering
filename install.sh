#!/bin/bash

sudo apt update
sudo apt install -y wget unzip
# Set the PLINK download URL
PLINK_URL="http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20230116.zip"
PLINK_FOLDER="plink_folder"

# Download PLINK
echo "Downloading PLINK..."
wget $PLINK_URL -O plink.zip

# Create the folder if it doesn't exist
mkdir -p $PLINK_FOLDER

# Unzip the downloaded file into the plink_folder
echo "Extracting PLINK..."
unzip plink.zip -d $PLINK_FOLDER

# Remove the zip file to save space
echo "Cleaning up the zip file..."
rm plink.zip

# Add PLINK to the PATH for the current session
echo "Adding PLINK to the PATH for this session..."
export PATH=$PATH:$(pwd)/$PLINK_FOLDER

# Permanently add PLINK to the PATH in the .bashrc file
echo "Making the PATH change permanent..."
if ! grep -q "$PLINK_FOLDER" ~/.bashrc; then
    echo "export PATH=\$PATH:$(pwd)/$PLINK_FOLDER" >> ~/.bashrc
    echo "PATH updated in .bashrc."
else
    echo "PLINK path already exists in .bashrc."
fi

# Check PLINK installation by displaying version
echo "Checking PLINK version..."
plink --version

# Check if requirements.txt exists and install dependencies
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies from requirements.txt..."
    pip install -r requirements.txt
else
    echo "requirements.txt not found. Skipping pip install."
fi

echo "Installation complete! Please restart your terminal or run 'source ~/.bashrc' to refresh the PATH."
