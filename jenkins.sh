#!/bin/bash

# Update system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install dependencies
echo "Installing required packages..."
sudo apt install -y wget gnupg software-properties-common

# Add Eclipse Temurin repo for Java 21
echo "Adding Java 21 repository..."
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /usr/share/keyrings/adoptium-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/adoptium-archive-keyring.gpg] https://packages.adoptium.net/artifactory/deb stable main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# Install Java 21
echo "Installing Java 21..."
sudo apt update
sudo apt install -y temurin-21-jdk

# Check Java version
java -version

# Add Jenkins key and repo
echo "Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
echo "Installing Jenkins..."
sudo apt update
sudo apt install -y jenkins

# Start and enable Jenkins
echo "Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Status
sudo systemctl status jenkins
