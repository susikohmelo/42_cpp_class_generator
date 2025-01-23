#!/bin/bash

# All this does is append the alias to the .zshrc and .bashrc files

SCRIPT_DIR=$(pwd)
printf "\nalias cgen=\"%s\"" "${SCRIPT_DIR}/cgen.sh\n" >> "${HOME}/./.bashrc"
printf "\nalias cgen=\"%s\"" "${SCRIPT_DIR}/cgen.sh\n" >> "${HOME}/./.zshrc"

echo -e "\e[32mExit & reopen the terminal for alias to take effect\e[0m"
echo -e "\e[33mThe alias name is cgen\e[0m"
