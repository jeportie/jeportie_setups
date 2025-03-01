# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/02/28 23:57:23 by jeportie          #+#    #+#              #
#    Updated: 2025/03/01 03:04:48 by jeportie         ###   ########.fr        #
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

# Install required packages for C/C++ development, Neovim, X11 support, and Python venv
RUN apt-get update && apt-get install -y \
    zsh \
    git \
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

# Install Norminette (42 school checker) using pip in the venv
RUN /root/venv/bin/pip install norminette

# Ensure the venv bin directory is in PATH
ENV PATH="/root/venv/bin:${PATH}"

# (Optional) If you want to keep any other lazy clones, do it here; but we no
# longer need the lines that clone Avante/Neotest into ~/.local/share/nvim/lazy.

# Make sure the custom plugin directory exists
RUN mkdir -p /root/.config/nvim/lua/custom/plugins

# Copy our custom plugin config files into place
COPY avante.lua /root/.config/nvim/lua/custom/plugins/avante.lua
COPY neotest.lua /root/.config/nvim/lua/custom/plugins/neotest.lua

# (Optional) Copy custom configuration files if you have them
COPY nvjej.zshrc /root/.zshrc
COPY custom_agnoster.zsh-theme /root/.oh-my-zsh/themes/agnoster.zsh-theme

# Copy the NVChad installation helper script and the container entrypoint script
COPY install_nvchad.sh /usr/local/bin/install_nvchad.sh
RUN chmod +x /usr/local/bin/install_nvchad.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Optionally run a headless sync now, so the plugins are already installed
RUN nvim --headless +"Lazy! sync" +qa

# Set the entrypoint to launch our customized shell
ENTRYPOINT ["/entrypoint.sh"]
