# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jeportie <jeportie@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/12 12:58:41 by jeportie          #+#    #+#              #
#    Updated: 2025/03/12 15:35:41 by jeportie         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Base System Configuration
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Locale Configuration
RUN apt-get update && apt-get install -y locales locales-all && \
    locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /root

# Copy and execute installation script
COPY script/install.dockerfile /tmp/install.dockerfile
RUN chmod +x /tmp/install.dockerfile
RUN bash /tmp/install.dockerfile && rm /tmp/install.dockerfile

# Install & config docker shell UI
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended && \
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc
RUN chsh -s $(which zsh)
RUN npm i @vscode/codicons
COPY custom/custom_agnoster.zsh-theme /root/.oh-my-zsh/themes/agnoster.zsh-theme
COPY config/nvjej.zshrc /root/.zshrc

# Set the entrypoint to launch our customized shell
COPY script/entrypoint.sh /sh/entrypoint.sh
RUN chmod +x /sh/entrypoint.sh
ENTRYPOINT ["/sh/entrypoint.sh"]
RUN git config --global user.email "jeportie@student.42.fr"
RUN git config --global user.name "jeportie"
