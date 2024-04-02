#!/bin/bash

# Check if jq is already installed
if jq --version >/dev/null 2>&1; then
    echo "jq is already installed."
else
    echo "jq is not installed. Attempting to install..."

    # Determine the package manager
    if command -v yum >/dev/null 2>&1; then
        # Use yum to install jq
        echo "Using yum to install jq..."
        sudo yum install jq -y
    elif command -v apt-get >/dev/null 2>&1; then
        # Use apt-get to install jq
        echo "Using apt-get to install jq..."
        sudo apt-get update
        sudo apt-get install jq -y
    else
        echo "Neither yum nor apt-get is available. Unable to install jq."
        exit 1
    fi
fi

# Verify installation
if jq --version >/dev/null 2>&1; then
    echo "jq installation was successful."
else
    echo "jq installation failed."
fi