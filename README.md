# Poneyhos Toolbx Base

This is the base image to work with containers with PoneyhOS integration.
This image contains all the tools
that I'm using independently of the development language.

## How To

- Checkout the repository
- Run:

```shell
docker build . -t base-dev
```

When you want to create a new toolbx container, run:

```shell
toolbox create --image=base-dev $toolbox-name
```

Where `$toolbox-name` is the name you want to give to your toolbox container.

## Tools

| Name | Description |
|------|-------------|
| c-development | group with C development tools |
| development-tools | group withGeneral development tools |
| python3-devel | Be able to build against Python 3 |
| openssl-devel | Be able to build against OpenSSL |
| libffi-devel | Be able to build against libffi |
| git-delta | Diff tool for git |
| ripgrep | Us rp to grep. Handle regex  |
| fd-find | find alternative in rust |
| fzf | fuzzy file search |
| bat | Alternative to cat |
| jq | sed but for JSON  |
| gh | GitHub tooling |
| uv | uv to create and manage python env. |
| clang-tools-extra | because more LLVM is good for the health |
| ShellCheck | Analyze shell scripts |
| shfmt | Format shell scripts |
| podman-compose | Manage podman like docker-compose |
| zsh | I like zsh |
| lsd | Better ls alternative |
| vim | vim text editor |
| pre-commit | Git pre-commit hook manager (installed with uv tool, so I would not remove uv.)|
| Zed | Simple text editor or Full IDE, this one do both perfectly |
| GitHub Desktop | GitHub desktop client |
| ghostty | I suppose it does not support injecting into a container so needed when using ghostty on host to inject proper env|
| starship | Prompt theme for shell |
| Oh-My-Zsh | Zsh configuration framework |
