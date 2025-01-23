#!/bin/bash

SCRIPT_DIR=$(pwd)
printf "alias cgen=\"%s\"" "${SCRIPT_DIR}/cgen.sh" >> "${HOME}/./.bashrc"
printf "alias cgen=\"%s\"" "${SCRIPT_DIR}/cgen.sh" >> "${HOME}/./.zshrc"

echo -e "\e[32mExit & reopen the terminal for alias to take effect\e[0m"
