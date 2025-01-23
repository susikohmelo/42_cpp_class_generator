#!/bin/bash

# Simple-ish C++ fast(er) class creation tool
# by susikohmelo, aka. ljylhank
version="1.0"


# Colors
color_comment="\e[90m"
color_startnote="\e[33m"
color_warning="\e[31m"
color_end="\e[0m"


# Startup message
echo -e $color_comment
echo "-- Version ${version} --"
echo -e -n $color_startnote
echo "# leave any of the fields in this script empty to stop adding to them"
echo -e $color_end


# Getting the class name
echo -n "class name: "
read classname
if [ -z "$classname" ]
then
	echo "Class name can't be empty"
	exit 1
fi


# Checking if the file exists already
if [ -f "./${classname}.cpp" ] || [ -f "./${classname}.hpp" ]; then
	echo -e $color_warning
	echo "WARNING! a .cpp or .hpp file with that name exists already."
	echo
	echo "Type 'YES' to overwrite this file."
	echo "Type anything else to cancel"
	echo -e $color_end
	echo -n "Overwrite?: "
	read overwrite
	if [ "$overwrite" != "YES" ]; then
		exit
	fi
fi


# Starting header guard
classheader=$(echo "${classname}_HPP" | tr '[:lower:]' '[:upper:]')
echo "#ifndef $classheader" > ${classname}.hpp
echo "# define $classheader" >> ${classname}.hpp
echo >> ${classname}.hpp


# Getting / setting includes
echo -e $color_comment
printf "# include <> or \" \" in the name\n"
echo -e -n $color_end
addnl=0
linecount=1
while [ 1 ]
do
	printf "include [%d]: " "$linecount"
	read include

	if [ -z "$include" ]
	then
		break
	fi
	
	addnl=1
	echo "# include $include" >> ${classname}.hpp
	let "linecount++"
done
if [ "$addnl" -eq 1 ]
then
	echo >> ${classname}.hpp
fi
# Including our .hpp in the .cpp
printf "#include \"${classname}.hpp\"\n" > ${classname}.cpp


# Write class + open bracket
echo class $classname >> ${classname}.hpp
printf "{\n" >> ${classname}.hpp


# Public members
echo -e $color_comment
echo "# if the line ends with ); it will be added to .cpp as a function"
echo -e -n $color_end
addedsomething=0
linecount=1;
while [ 1 ]
do
	printf "public member [line %d]: " "$linecount"
	read input

	if [ -z "$input" ]
	then
		break
	fi

	# if this is the first line, add 'public: ' first
	if [ "$addedsomething" -eq 0 ]; then
		printf "\tpublic:\n" >> ${classname}.hpp
	fi
	
	printf "\t\t%s\n" "$input"  >> ${classname}.hpp

	# if input is a function, add the prototype to the .cpp file
	# Constructors / destructors are detected;
	if [[ "$input" == *");" ]]; then
		if [[ "$input" == "${classname}("* ]] || [[ "$input" == "~${classname}("* ]]
		then
			cutinput=${input:0:-1}
		else
			cutinput=$(echo ${input:0:-1} | cut -d\  -f2-)
		fi
		printf "\n%s::%s\n" "${classname}" "${cutinput}" >> "${classname}.cpp"
	fi

	addedsomething=1
	let "linecount++"
done


# Private members
echo -e $color_comment
echo "# if the line ends with ); it will be added to .cpp as a function"
echo -e -n $color_end
addedsomething=0
linecount=1;
while [ 1 ]
do
	printf "private member [line %d]: " "$linecount"
	read input

	if [ -z "$input" ]
	then
		break
	fi

	# if this is the first line, add 'private: ' first
	if [ "$addedsomething" -eq 0 ]; then
		printf "\n\tprivate:\n" >> ${classname}.hpp
	fi
	
	printf "\t\t%s\n" "$input"  >> ${classname}.hpp

	# if input is a function, add the prototype to the .cpp file
	if [[ "$input" == *");" ]]; then
		cutinput=$(echo ${input:0:-1} | cut -d\  -f2-)
		printf "\n%s::%s\n" "${classname}" "${cutinput}" >> "${classname}.cpp"
	fi

	addedsomething=1
	let "linecount++"
done

# Close bracket & end guard
printf "};\n\n#endif\n" >> ${classname}.hpp


# Done!
echo -e $color_comment
printf "# finished creating %s and %s c:\n" "${classname}.cpp" "${classname}.hpp"
echo -e -n $color_end
