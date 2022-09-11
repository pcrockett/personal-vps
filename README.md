## Personal VPS

Configuration for my cloud virtual private server running Ubuntu 22.04. Based on
[IBHC](https://github.com/pcrockett/ibhc). This repository assumes three things:

1. You've cloned this repository on a local Linux workstation
    * _I call this the "controller," analogous to [Ansible][ansible]'s "control node" concept._
2. Your controller device has administrator access via SSH to an Ubuntu server somewhere.
3. Git, SSH, and Bash aren't completely foreign concepts to you.

**Current Status:** Work in progress. Sets up a server that has no purpose besides a [Tailscale](https://tailscale.com)
exit node, with an iptables-based firewall only allowing SSH connections via the Tailscale VPN.

### TODO

* [ ] Set up [Podman](https://podman.io)
* [ ] Set up a [Nextcloud](https://github.com/nextcloud/docker) pod
    * More about pods: https://www.redhat.com/sysadmin/compose-podman-pods

### Dependencies

Installing [direnv](https://direnv.net/) and `make` on your controller machine will make your life easier, though it's
not strictly required.

### Getting Started

1. Provision an Ubuntu server somewhere that gives you SSH access to an admin account.
2. Clone this repo to your controller machine.
3. Copy [.envrc.example](.envrc.example) to `.envrc`.
4. Edit the variables in `.envrc` accordingly.
5. `make server-init && make deploy`

From then on, after making any changes to the repository, the main command you'll use is `make deploy`.

### Code Organization

Everything you see in the [`Makefile`](Makefile), [`bin` directory](bin), and `.envrc` file is designed to run on the
local controller device. Everything else in this repo is designed to run on the server.

When you run `make deploy` on the controller, the latest changes in the repository will be pushed to your server via
Git + SSH, and then the [`run.sh` script](run.sh) will be executed on the remote server. This script executes the
[`default` target](targets/default.sh), which is the main entrypoint for all other targets.

What's a "target" then? A target is like a "goal" or a desired outcome. And a target _script_ is a little atomic bit of
logic that clearly specifies 3 things:

1. Dependencies: Which other targets need to be reached before this one can be applied.
2. Logic that determines whether the target has been reached yet or not.
3. Logic that should be applied to actually reach the desired outcome.

A very simple, typical example of a target is the [`tailscale-installed` target](targets/tailscale-installed.sh).

[ansible]: https://docs.ansible.com/ansible/latest/getting_started/index.html
