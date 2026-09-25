# Poneyhos Toolbx Base

Toolbx images to work in containers with PoneyhOS integration.
Two images are built on top of a common base:

- **dev**, with all the tools I use independently of the development language.
- **sysadmin**, with tools to inspect and troubleshoot the host.

Both are rebuilt every week and published on GHCR.

## How To

### Use a published image

```shell
toolbox create --image ghcr.io/poneyh0/poneyhos-toolbx-dev:latest $toolbox-name
toolbox create --image ghcr.io/poneyh0/poneyhos-toolbx-sysadmin:latest $toolbox-name
```

Where `$toolbox-name` is the name you want to give to your toolbox container.

Every build is also tagged with its date, as `YYYYMMDD`.
Use such a tag instead of `latest` to go back to a previous build.

### Build locally

- Checkout the repository
- Run:

```shell
podman build --target dev -t poneyhos-toolbx-dev .
podman build --target sysadmin -t poneyhos-toolbx-sysadmin .
```

Without `--target`, `podman build .` builds the last stage, `sysadmin`.

Then create the toolbox container from the local image:

```shell
toolbox create --image localhost/poneyhos-toolbx-dev $toolbox-name
toolbox create --image localhost/poneyhos-toolbx-sysadmin $toolbox-name
```

## Tools

### Common

| Name | Description |
|------|-------------|
| zsh | I like zsh |
| vim | vim text editor |
| lsd | Better ls alternative |
| ripgrep | Use rg to grep. Handle regex |
| fd-find | find alternative in rust |
| fzf | fuzzy file search |
| bat | Alternative to cat |
| jq | sed but for JSON |
| git-delta | Diff tool for git |
| gh | GitHub tooling |
| uv | uv to create and manage python env. |
| ShellCheck | Analyze shell scripts |
| shfmt | Format shell scripts |
| starship | Prompt theme for shell |

### Dev

| Name | Description |
|------|-------------|
| development-tools | group with general development tools |
| c-development | group with C development tools |
| python3-devel | Be able to build against Python 3 |
| openssl-devel | Be able to build against OpenSSL |
| libffi-devel | Be able to build against libffi |
| clang-tools-extra | because more LLVM is good for the health |
| podman-compose | Manage podman like docker-compose |
| pre-commit | Git pre-commit hook manager (installed with uv tool, so I would not remove uv.) |
| Zed | Simple text editor or Full IDE, this one do both perfectly |
| GitHub Desktop | GitHub desktop client |

### Sysadmin

| Name | Description |
|------|-------------|
| btop | Resource monitor |
| htop | Interactive process viewer |
| ncdu | Disk usage analyzer |
| mtr | traceroute and ping combined |
| iperf3 | Network bandwidth measurement |
| nmap | Network scanner |
| bind-utils | DNS tools: dig, host, nslookup |
| lsof | List open files |
