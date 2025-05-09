#!/bin/bash

set -e

# Embedded Values
EC2_INSTANCE_ID="i-123456789123455"
REMOTE_PORT="12345"
LOCAL_PORT="1234"
AWS_REGION="ap-southeast-1"
AWS_CONFIG_FILE="$HOME/.aws/config"
AWS_CRED_FILE="$HOME/.aws/credentials"

echo "----------------------------------------------"
echo "🔎 AWS Profile Selector for SSM Connection"
echo "----------------------------------------------"

# List SSO profiles if exist
SSO_PROFILES=$(grep -E '^\[profile ' "$AWS_CONFIG_FILE" 2>/dev/null | sed -E 's/\[profile (.*)\]/\1/')

if [ -n "$SSO_PROFILES" ]; then
    echo "🚀 Available AWS SSO Profiles:"
    echo ""
# Embedded Values
EC2_INSTANCE_ID="i-123456789123455"
REMOTE_PORT="12345"
LOCAL_PORT="1234"
AWS_REGION="ap-southeast-1"
AWS_CONFIG_FILE="$HOME/.aws/config"
AWS_CRED_FILE="$HOME/.aws/credentials"

echo "----------------------------------------------"
echo "🔎 AWS Profile Selector for SSM Connection"
echo "----------------------------------------------"

# List SSO profiles if exist
SSO_PROFILES=$(grep -E '^\[profile ' "$AWS_CONFIG_FILE" 2>/dev/null | sed -E 's/\[profile (.*)\]/\1/')

if [ -n "$SSO_PROFILES" ]; then
    echo "🚀 Available AWS SSO Profiles:"
    echo ""
    select AWS_PROFILE in $SSO_PROFILES; do
        if [ -n "$AWS_PROFILE" ]; then
            echo "✅ Selected AWS SSO profile: $AWS_PROFILE"
            break
        else
            echo "⚠️ Invalid selection, try again."
        fi
    done
else
    echo "❌ No AWS SSO profiles found in ~/.aws/config."
    echo ""
    echo "Configuring AWS SSO..."
    aws configure sso --profile "$AWS_PROFILE"
    SSO_PROFILES=$(grep -E '^\[profile ' "$AWS_CONFIG_FILE" 2>/dev/null | sed -E 's/\[profile (.*)\]/\1/')
    if [ -n "$SSO_PROFILES" ]; then
        echo "✅ AWS SSO configured successfully."
        echo "🚀 Select your newly configured AWS SSO profile:"
        select AWS_PROFILE in $SSO_PROFILES; do
            if [ -n "$AWS_PROFILE" ]; then
                echo "✅ Selected AWS SSO profile: $AWS_PROFILE"
                break
            fi
        done
    fi
fi
        if [ -n "$AWS_PROFILE" ]; then
            echo "✅ Selected AWS SSO profile: $AWS_PROFILE"
            break
        else
            echo "⚠️ Invalid selection, try again."
        fi
    done
else
    echo "❌ No AWS SSO profiles found in ~/.aws/config."
    echo ""
    echo "Configuring AWS SSO..."
    aws configure sso --profile "$AWS_PROFILE"
    SSO_PROFILES=$(grep -E '^\[profile ' "$AWS_CONFIG_FILE" 2>/dev/null | sed -E 's/\[profile (.*)\]/\1/')
    if [ -n "$SSO_PROFILES" ]; then
        echo "✅ AWS SSO configured successfully."
        echo "🚀 Select your newly configured AWS SSO profile:"
        select AWS_PROFILE in $SSO_PROFILES; do
            if [ -n "$AWS_PROFILE" ]; then
                echo "✅ Selected AWS SSO profile: $AWS_PROFILE"
                break
            else
                echo "⚠️ Invalid selection, try again."
            fi
        done
    else
        echo "❌ Still no profiles found. Exiting."
        exit 1
    fi
fi

start_ssm_session() {
    echo ""
    echo "---------------------------------"
    echo "🔧 Embedded Connection Details"
    echo "---------------------------------"
    echo "AWS Profile     : $AWS_PROFILE"
    echo "EC2 Instance ID : $EC2_INSTANCE_ID"
    echo "Remote Port     : $REMOTE_PORT"
    echo "Local Port      : $LOCAL_PORT"
    echo "AWS Region      : $AWS_REGION"
    echo "---------------------------------"
    echo ""

    # Ensure SSO token is valid or refresh it
echo ""

    # Ensure SSO token is valid or refresh it
    if ! aws sts get-caller-identity --profile "$AWS_PROFILE" &>/dev/null; then
        echo "🔑 AWS SSO session expired or inactive. Logging in..."
        aws sso login --profile "$AWS_PROFILE"
    fi
        echo "🔑 AWS SSO session expired or inactive. Logging in..."
        aws sso login --profile "$AWS_PROFILE"
    fi

    # Try up to 2 times to start the session, refreshing token if needed
    for attempt in 1 2; do
        echo "🔒 Please keep this terminal session open to access aws resources!"
        echo "🚀 Initiating AWS SSM Port Forwarding..."
        if aws ssm start-session \
            --target "$EC2_INSTANCE_ID" \
            --document-name staging-Responio-StartPortForwardingSession \
            --parameters "{\"portNumber\":[\"$REMOTE_PORT\"],\"localPortNumber\":[\"$LOCAL_PORT\"]}" \
            --profile "$AWS_PROFILE" \
            --reasons "Port Forwarding" \
            --region "$AWS_REGION"; then
            return 0
        fi

        echo "⚠️ Session start failed (token may have expired). Re-authenticating..."
        aws sso login --profile "$AWS_PROFILE"
    done

    echo "❌ Unable to start SSM session after multiple attempts."
    exit 1
}

# Start SSM Port Forwarding Session
start_ssm_session