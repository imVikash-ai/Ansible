# Ansible

Infrastructure provisioning and configuration management using **Terraform** and **Ansible**. Terraform creates the servers, and Ansible playbooks configure them.

![Ansible](https://img.shields.io/badge/Ansible-EE0000?logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)

---

## Overview

This repository is a hands-on DevOps project that combines two tools:

- **Terraform** provisions the infrastructure (virtual machines, networking, key pairs).
- **Ansible** connects over SSH and configures those machines using playbooks.

## Repository Structure

```
Ansible/
├── playbooks/             # Ansible playbooks for configuring servers
├── terraform/             # Terraform code for provisioning infrastructure
├── terraform_for_ansible/ # Terraform setup that creates hosts to manage with Ansible
├── ansible.cfg            # Ansible configuration (inventory, SSH, privilege settings)
├── .gitignore
└── README.md
```

## Prerequisites

| Tool | Purpose |
|------|---------|
| [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/) | Configuration management |
| [Terraform](https://developer.hashicorp.com/terraform/install) | Infrastructure provisioning |
| Cloud account & CLI credentials | Required by Terraform (e.g. AWS) |
| SSH key pair | Used by Ansible to connect to hosts |

## Ansible Configuration

Key settings in `ansible.cfg`:

| Setting | Value | Description |
|---------|-------|-------------|
| `inventory` | `inventories/dev/hosts.ini` | Default inventory file |
| `private_key_file` | `~/keys/terra-key-ansible` | SSH private key for target hosts |
| `host_key_checking` | `False` | Skips SSH host key prompts |
| `forks` | `10` | Parallel host connections |
| `roles_path` | `roles` | Location of Ansible roles |
| `pipelining` | `True` | Faster SSH execution |
| `become` | `False` | Privilege escalation is off by default |

> Update `private_key_file` and `inventory` to match your own environment.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/imVikash-ai/Ansible.git
cd Ansible
```

### 2. Provision infrastructure with Terraform

```bash
cd terraform_for_ansible
terraform init
terraform plan
terraform apply
```

Note the public IPs of the created servers.

### 3. Create the inventory

Create `inventories/dev/hosts.ini` (the path set in `ansible.cfg`):

```ini
[web]
<server-ip> ansible_user=ubuntu
```

### 4. Verify connectivity

```bash
ansible all -m ping
```

### 5. Run a playbook

```bash
ansible-playbook playbooks/<playbook-name>.yml
```

Useful flags:

```bash
ansible-playbook playbooks/<playbook-name>.yml --check   # dry run
ansible-playbook playbooks/<playbook-name>.yml -v        # verbose output
ansible-playbook playbooks/<playbook-name>.yml --become  # run with sudo
```

### 6. Clean up

```bash
cd terraform_for_ansible
terraform destroy
```

## Security Notes

- Never commit private keys, `.tfstate` files, or credentials. Check that `.gitignore` covers them.
- `host_key_checking = False` is convenient for labs and dev, but should be enabled in production.
- Use [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) for sensitive variables.

## Learning Goals

- Provisioning cloud infrastructure with Terraform
- Writing and running Ansible playbooks
- Connecting Terraform outputs to Ansible inventories
- Building repeatable, idempotent server configuration

## Contributing

Suggestions and improvements are welcome. Fork the repo, create a branch, and open a pull request.

## Author

**Vikash** — [@imVikash-ai](https://github.com/imVikash-ai)