#!/bin/bash
# Fetch the public key from GitHub using the Personal Access Token for authentication
PUBLIC_KEYS=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/$GITHUB_USERNAME/keys | jq -r '.[].key')
# Check if any keys were fetched
if [ -z "$PUBLIC_KEYS" ]; then
    echo "Could not fetch any public keys from GitHub for username $GITHUB_USERNAME."
    exit 1
else
    echo "Fetched public keys from GitHub."
fi

# Ensure the SSH directory exists and has appropriate permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Add the public key to authorized_keys if not already present
echo "$PUBLIC_KEYS" | while read KEY; do
    if ! grep -qsF "$KEY" ~/.ssh/authorized_keys; then
        echo "$KEY" >> ~/.ssh/authorized_keys
        echo "Added key to ~/.ssh/authorized_keys: $KEY"
    else
        echo "Key already exists in ~/.ssh/authorized_keys: $KEY"
    fi
done

# Ensure authorized_keys has appropriate permissions
chmod 600 ~/.ssh/authorized_keys

echo "SSH setup complete. You can now SSH into this server using your GitHub public key."