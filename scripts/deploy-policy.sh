#!/bin/bash

# Azure Policy Deployment Script
# Deploys all policies from examples folder

set -e

echo "🚀 Starting Azure Policy Deployment"

# Login to Azure (if not already logged in)
az account show > /dev/null 2>&1 || {
    echo "🔐 Logging into Azure..."
    az login
}

# Select subscription
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo "📋 Using subscription: $SUBSCRIPTION_ID"

# Create resource group for policies
RG_NAME="policy-rg-$(date +%s)"
echo "📦 Creating resource group: $RG_NAME"
az group create --name $RG_NAME --location eastus

# Deploy each policy
for policy_file in examples/*.json; do
    POLICY_NAME=$(basename "$policy_file" .json)
    echo "📝 Deploying policy: $POLICY_NAME"
    
    # Create policy definition
    az policy definition create \
        --name "$POLICY_NAME" \
        --display-name "$POLICY_NAME" \
        --description "Policy from $POLICY_NAME" \
        --rules "$policy_file" \
        --subscription "$SUBSCRIPTION_ID"
    
    # Assign policy
    az policy assignment create \
        --name "$POLICY_NAME-assignment" \
        --policy "$POLICY_NAME" \
        --scope "/subscriptions/$SUBSCRIPTION_ID"
done

echo "✅ Deployment complete!"
echo "📊 Check compliance: az policy state list"
