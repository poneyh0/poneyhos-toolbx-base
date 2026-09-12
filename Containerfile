FROM registry.fedoraproject.org/fedora-toolbox:44

RUN dnf group --assumeyes install development-tools c-development && \
    dnf --assumeyes install python3-devel openssl-devel libffi-devel \
                            git-delta ripgrep fd-find fzf bat jq gh uv \
                            clang-tools-extra ShellCheck shfmt podman-compose \
                            zsh lsd vim

# pre-commit, installed system-wide.
# uv tool installs into ~/.local by default, which is /root at build time and
# unreadable by the user at runtime. Both directories are therefore redirected
# to system-wide paths, /usr/local/bin already being on everyone's PATH.
ENV UV_TOOL_DIR=/opt/uv/tools \
    UV_TOOL_BIN_DIR=/usr/local/bin
RUN uv tool install pre-commit

# Zed, installed system-wide rather than through the upstream install.sh.
# toolbox replaces $HOME with the host home at runtime, so anything installed
# into a home directory at build time is simply invisible from inside the
# container. install.sh targets ~/.local, so it cannot be used here.
RUN dnf --assumeyes install vulkan-loader mesa-vulkan-drivers && \
    curl -fsSL https://zed.dev/api/releases/stable/latest/zed-linux-x86_64.tar.gz \
        | tar -xz -C /opt && \
    ln -s /opt/zed.app/bin/zed /usr/local/bin/zed

# The container runtime bind-mounts the host NVIDIA userspace driver into the
# container (libGLX_nvidia and around fifty other files), but not the Vulkan ICD
# manifest that declares it. Without this file the loader only ever finds
# llvmpipe, and Zed renders in software or refuses to start.
# The manifest points at the versionless soname, so it survives driver updates.
COPY vulkan/nvidia_icd.x86_64.json /usr/share/vulkan/icd.d/

# GitHub Desktop, from the shiftkey community fork: GitHub publishes no Linux
# build of its own. Pinned by URL, so bumping the version is a deliberate edit.
#
# It belongs here rather than in a flatpak or a host AppImage because it must
# share an environment with git and pre-commit. A sandboxed or host-side client
# runs `git commit` without ever seeing the hooks, and commits straight past
# them — silently.
RUN dnf --assumeyes install \
        https://github.com/shiftkey/desktop/releases/download/release-3.4.13-linux1/GitHubDesktop-linux-x86_64-3.4.13-linux1.rpm

RUN dnf install --assumeyes --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
RUN dnf install --assumeyes ghostty starship

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


CMD ["/usr/bin/zsh"]
