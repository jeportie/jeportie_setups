# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/28 23:57:23 by jeportie          #+#    #+#              #
#    Updated: 2025/03/08 01:25:13 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use an Ubuntu base image
FROM ubuntu:22.04

# Set noninteractive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install locales, generate en_US.UTF-8, and set environment variables
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Set working directory to /root so the shell starts there
WORKDIR /root

# Install required packages for development, Neovim, X11 support, and Python venv
RUN apt-get update && apt-get install -y \
    zsh \
    git \
    tree \
    ripgrep \
    build-essential \
    make \
    valgrind \
    exuberant-ctags \
    check \
    tig \
    lldb \
    libreadline-dev \
    libxext-dev \
    libbsd-dev \
    libx11-dev \
    wget \
    curl \
    x11-apps \
    xclip \
    python3-venv \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

# Install the latest stable Neovim by downloading its tarball and copying files to /usr/local
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz && \
    tar -xzf nvim-linux-x86_64.tar.gz && \
    cp -r nvim-linux-x86_64/* /usr/local/ && \
    rm -rf nvim-linux-x86_64.tar.gz nvim-linux-x86_64

# Install Oh-My-Zsh (unattended) and set the theme to agnoster
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended && \
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc

# Set zsh as the default shell for root
RUN chsh -s $(which zsh)

# Clone NVChad starter into the Neovim config folder and remove its .git folder
RUN git clone https://github.com/NvChad/starter ~/.config/nvim && \
    rm -rf ~/.config/nvim/.git

# Clone and build minilibx (42 school library)
RUN git clone https://github.com/42Paris/minilibx-linux.git /opt/minilibx && \
    cd /opt/minilibx && \
    make

# Create a Python virtual environment and install pip, setuptools, and pynvim
RUN python3 -m venv /root/venv && \
    /root/venv/bin/pip install --upgrade pip setuptools pynvim
ENV VIRTUAL_ENV_DISABLE_PROMPT=1

# Install Norminette (42 school checker) using pip in the venv
RUN /root/venv/bin/pip install norminette

# Ensure the venv bin directory is in PATH
ENV PATH="/root/venv/bin:${PATH}"
# Configure Git to trust all directories
RUN git config --global --add safe.directory "*"
RUN git config --global user.email "jeportie@student.42.fr"
RUN git config --global user.name "jeportie"


# ------------------------------------------------------------------------------
# Copy lazy.nvim plugin configuration for Avante into NVChad’s config.
# ------------------------------------------------------------------------------
RUN mkdir -p /root/.config/nvim/lua
COPY lua/lazy.lua /root/.config/nvim/lua/plugins/lazy.lua
COPY lua/toggleterm_venv.lua /root/.config/nvim/lua/custom/toggleterm_venv.lua
COPY lua/chadrc.lua /root/.config/nvim/lua/chadrc.lua
COPY lua/dynamic_style.lua /root/.config/nvim/lua/dynamic_style.lua

# (Optional) Copy any other configuration files if needed:
COPY config/nvjej.zshrc /root/.zshrc
COPY custom/custom_agnoster.zsh-theme /root/.oh-my-zsh/themes/agnoster.zsh-theme
COPY script/install_nvchad.sh /usr/local/bin/install_nvchad.sh
RUN chmod +x /usr/local/bin/install_nvchad.sh
COPY script/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Trigger lazy.nvim to sync plugins in headless mode
RUN nvim --headless +"Lazy! sync" +qa

# Set the entrypoint to launch our customized shell
ENTRYPOINT ["/entrypoint.sh"]
