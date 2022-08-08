## Personal VPS

Configuration for my cloud virtual private server running Ubuntu 22.04. Based on
[IBHC](https://github.com/pcrockett/ibhc). Rather than configuring a local device, this is designed to configure a
remote device via Git, SSH, and Bash.

**Current Status:** Work-in-progress. Serves no purpose besides a Tailscale exit node. Sets up a strict iptables-based
firewall only allowing SSH connections via Tailscale.

### Dependencies

Installing [direnv](https://direnv.net/) and `make` on your local device will make your life easier, though with some
manual work it's not strictly required.

### Getting Started

1. Provision an Ubuntu server somewhere that gives you SSH access to an admin account.
2. Clone this repo to your laptop or whatever admin machine you're sitting in front of now.
3. Copy [.envrc.example](.envrc.example) to `.envrc`.
4. Edit the variables in `.envrc` accordingly.
5. `make server-init && make deploy`

From then on, after making any changes to the repository, all you'll need is `make deploy`.
