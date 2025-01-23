#!/bin/bash
# This script adds the alias for cgen and compiles the .c program that generates 42 headers


# Getting info required for 42 header and putting it into a file
echo
echo -e "\e[36mIf you fumble any of the input, you can CTRL-C and rerun the script\e[0m"
echo -e "\e[36mOr edit the '42header_userinfo' file afterwards\e[0m"
echo -e -n "\e[33mEnter the email for your 42 header: \e[0m"
read email;
echo -e -n "\e[33mEnter the username for your 42 header: \e[0m"
read username;
echo $email > 42header-userinfo
echo $username >> 42header-userinfo

SCRIPT_DIR=$(pwd)

echo -e "\e[90m~ Compiling 42 header generation program.\e[0m"
gcc 42header-gen.c -o 42header-gen
chmod +x "${SCRIPT_DIR}/42header-gen"
chmod +x "${SCRIPT_DIR}/cgen.sh"


echo -e "\e[90m~ Appending the cgen alias to .bashrc and .zshrc\e[0m"
printf "\nalias cgen=\"%s\"\n" "${SCRIPT_DIR}/cgen.sh" >> "${HOME}/./.bashrc"
printf "\nalias cgen=\"%s\"\n" "${SCRIPT_DIR}/cgen.sh" >> "${HOME}/./.zshrc"


echo -e "\e[32mExit & reopen the terminal for alias to take effect\e[0m"
echo -e "\e[33mThe alias name is cgen\e[0m"
