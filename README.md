# 42_cpp_class_generator
## a C++ tool for fast(er) class creation in the 42 schools

This tool is a shell script that takes 4 prompts and creates a .cpp and .hpp file with:
- The 42header
- Header guard
- Inclusions
- Public & private members
- Definitions in .cpp for functions in .hpp
- .hpp inclusion in the .cpp

Feel free to grab the 42header generator and use it for your own tools if you'd like. It's a 1 file .c program that takes filename, username and email as command line arguments and prints out a header to stdout. You can redirect this easily into a file.

## Installation
After downloading, run the install.sh script which will ask for your 42header username & email, compile the header generator and finally add the alias 'cgen' to your .bashrc and .zshrc config files. Naturally if you're using a different shell or it doesn't work, add the alias yourself.

Or do the whole shebang in one go by copy-pasting the following:
```
cd ~
git clone git@github.com:susikohmelo/42_cpp_class_generator.git
cd 42_cpp_class_generator
./install.sh
```
