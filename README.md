# Homelab

Ansible provisioning for the homelab hosts. Services live in their own repos under `services/`.

## What the bootstrap does

`playbooks/bootstrap.yml` takes an SSH-enabled Ubuntu host to "ready to run services":

- `common` role: apt update/upgrade, unattended security upgrades, UFW (SSH allowed, deny incoming, allow outgoing), warns if a reboot is needed.
- `docker` role: Docker Engine, Buildx and Compose plugins from Docker's apt repo, service enabled, login user added to the `docker` group.

Note: ports published by Docker containers bypass UFW. Publish to `127.0.0.1` unless a service should be reachable on the LAN.

## Requirements

- [uv](https://docs.astral.sh/uv/) on the control machine. Ansible and ansible-lint are pinned dev dependencies.
- Each host reachable via an SSH config alias (`~/.ssh/config`) that matches its inventory name, with key auth.
- Passwordless sudo for the SSH user on the host.

## Usage

```bash
cp inventory/hosts.yml.example inventory/hosts.yml   # gitignored; set real host names
uv run ansible -m ansible.builtin.ping homelab
uv run ansible-playbook playbooks/bootstrap.yml --check --diff
uv run ansible-playbook playbooks/bootstrap.yml
uv run ansible-lint playbooks roles
```

`--check` cannot fully simulate the Docker install (the repo is not written in dry-run mode), so expect harmless noise there.

## Layout

| Path | Purpose |
| --- | --- |
| `ansible.cfg` | Default inventory and roles path |
| `inventory/` | `hosts.yml.example` is tracked; the real `hosts.yml` is gitignored |
| `playbooks/` | Entry-point playbooks |
| `roles/` | `common` and `docker` |
| `services/` | Service repos (gitignored, each has its own repository) |
| `.claude/` | Claude Code hooks, skills and agents for this repo |

## Services

| Service | Repo | Purpose |
| --- | --- | --- |
| AdGuard Home | `services/adguard-home` | Opt-in DNS ad blocking for signed-up devices |

## Rules

No IPs, hostnames, users or keys are committed. Run the `secrets-scan` skill before committing.
