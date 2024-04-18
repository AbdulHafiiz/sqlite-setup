#!/bin/bash
# 
# Download and compile latest version of sqlite

# Install required libraries
echo "Installing dependencies: xsltproc, libreadline-dev..."
sudo apt-get -y install xsltproc > /dev/null
sudo apt-get -y install libreadline-dev > /dev/null

# Find the latest version of sqlite from the downloads page
# Extremely fragile, changes to the page html will break the script
# 1. Parses downloads page as html
# 2. Extracts latest tarball version from script tag
# 3. Downloads latest tarball
echo "Downloading latest version of sqlite..."
curl -s https://www.sqlite.org/download.html -o index.html > /dev/null
latest_scripts=$(xsltproc --html xpath.xsl index.html 2> /dev/null)
tarball_latest=$(grep -oP "\d{4}\/sqlite-\w*-\d*.tar.gz" <<< "$latest_scripts")
url_latest="https://sqlite.org/${tarball_latest}"
filename=$(grep -oP "(?<=\/).*" <<< "$tarball_latest")
IFS="." read -ra folders <<< "$filename"
curl -s $url_latest -o "$filename" > /dev/null

# Unzips tar ball
echo "Unzipping tarball..."
tar -xvf "$filename" && cd "$filename"

# Configures, makes and builds from source
echo "Building..."
./configure
make
sudo make install

# Remove old versions
echo "Removing old versions..."
sudo apt-get -y purge sqlite3

# Adds to path
echo "Exporting to path..."
export PATH="/usr/local/bin:$PATH"

# Cleanup
echo "Cleaning up temporary files..."
rm index.html
rm "$filename"
rm -rf "$folders"

installed_version=$(sqlite3 --version)
echo "Successfully installed sqlite version ${installed_version}"