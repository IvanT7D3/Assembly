#!/bin/bash
read -p "Don't give the extension. Filename: " name
nasm -f elf $name.asm
ld -m elf_i386 -o main $name.o
echo "Clearing File Object"
rm $name.o
echo "Done"
