#!/bin/bash

# Function to find and execute Terraform commands
run_terraform() {
    terraform_dir=$(find . -type d -name "terraform" 2>/dev/null | head -n 1)
    if [[ -n "$terraform_dir" ]]; then
        echo "Found Terraform directory: $terraform_dir"
        cd "$terraform_dir" || exit
        echo "Initializing Terraform..."
        terraform init
        echo "plan terraform configuration..."
        terraform plan
        echo "Applying Terraform configuration..."
        terraform apply -auto-approve
        cd - || exit
    else
        echo "No Terraform directory found."
    fi
}

# Function to find and execute Ansible commands
run_ansible() {
    ansible_dir=$(find . -type d -name "ansible" 2>/dev/null | head -n 1)
    if [[ -n "$ansible_dir" ]]; then
        echo "Found Ansible directory: $ansible_dir"
        cd "$ansible_dir" || exit
        echo "Running Ansible playbook..."
        ansible-playbook -i inventory.ini setup.yml
        cd - || exit
    else
        echo "No Ansible directory found."
    fi
}

# Main script execution
run_terraform
run_ansible