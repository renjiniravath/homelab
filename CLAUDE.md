# Homelab

This is the root repo for homelab provisioning and base infrastructure. The goal of this project is to provide a way to fully automate configuring the homelab servers ready to run services. The services are not part of this repo, and will be their own repositories.

## Current Setup

As of now, the homelab consists of these machines
- HP EliteDesk 705 G4 Mini running Ubuntu 26.04 LTE
- Raspberry Pi 4B (to be added soon)

All the homelab machines are accessible using SSH.

## Goal

- The machines are intended to run services over Docker and VMs. Automation using Ansible should take care of configuring a OS and SSH enabled machine ready to run the services.
- Use Github actions to update configurations on any new commits.

## Important

- Do not commit any sensitive data. No IP, hostname, user or key getting committed.

