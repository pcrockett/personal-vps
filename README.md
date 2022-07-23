## Personal VPS

Configuration for my cloud virtual private server running Ubuntu 22.04. Based on
[IBHC](https://github.com/pcrockett/ibhc). Rather than configuring a local device, this is designed to configure a
remote device via Git, SSH, and Bash.

### Getting Started

1. Provision an Ubuntu server somewhere that gives you SSH access to an admin account.
2. Clone this repo to your laptop or whatever admin machine you're sitting in front of now.
3. Set the `SSH_DEST` variable in the [.envrc file](.envrc) to point to your server.
4. `make server-init && make deploy`

From then on, after making any changes to the repository, all you'll need is `make deploy`.
