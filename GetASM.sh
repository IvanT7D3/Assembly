#!/bin/bash

echo "Choose an option:"
echo "This script was tested only with assembly x86 files"
echo "1: Get shellcode from main"
echo "2: Paste shellcode to get assembly instructions"
echo "3: Simple objdump of main. Get shellcode and more"
read -p "> " Option

if [ $Option -eq 1 ]; then
	objdump -d ./main|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g' > Output
	cat Output
	rm Output
fi

if [ $Option -eq 2 ]; then
	read -p "Insert Shellcode Here: " Input
	echo -n "$Input" | xxd -r -p > Output
	echo "[+] Assembly Instructions:"
	ndisasm -b32 Output
	rm Output
fi

if [ $Option -eq 3 ]; then
	objdump -D -m i386 main -M intel
fi

if [ $Option -ne 1 ] && [ $Option -ne 2 ] && [ $Option -ne 3 ]; then
	echo "Please choose a valid option (1, 2, or 3)"
fi
