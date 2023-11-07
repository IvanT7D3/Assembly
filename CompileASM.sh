#!/bin/bash
read -p "Filename (No Extension): " name
nasm -f elf $name.asm
ld -m elf_i386 -o main $name.o
echo "Clearing File Object"
rm $name.o
echo "Done"
