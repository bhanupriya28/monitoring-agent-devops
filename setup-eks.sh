#!/bin/bash

# EKS Cluster Setup Script

# Prerequisites: AWS CLI configured, eksctl installed

CLUSTER_NAME=my-cluster
REGION=us-east-1

# Create EKS cluster
eksctl create cluster --name $CLUSTER_NAME --region $REGION --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 3

# Update kubeconfig
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Install NATS (using Helm)
helm repo add nats https://nats-io.github.io/k8s/helm/charts/
helm repo update
helm install nats nats/nats

# Install OpenSearch (simplified, for demo)
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update
helm install opensearch opensearch/opensearch

# Note: For production, configure security, persistence, etc.