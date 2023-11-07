#!/bin/bash

echo "Choose an option:"
echo "1: Get shellcode from main (You can use CompileASM.sh to get main)"
echo "2: Paste shellcode to get assembly instructions"
echo "3: Simple objdump of main. Get shellcode and more from main (You can use CompileASM.sh to get main)"
echo "This script is still not 100% complete..."
read -p "> " Option

if [ $Option -eq 1 ]; then
objdump -d ./main|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g' > Output
cat Output
rm Output
fi

#Edit
if [ $Option -eq 2 ]; then
read -p "Insert Shellcode Here: " Input
echo "[+] Got Shellcode"
echo $Input > Output
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
