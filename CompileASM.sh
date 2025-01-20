#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <filename.asm>"
	exit 1
fi

FullFilename="$1"
BaseName=$(basename "$FullFilename" .asm)

nasm -f elf "$FullFilename"
ld -m elf_i386 -o main "$BaseName.o"

echo "Clearing File Object"
rm "$BaseName.o"

echo "Done"
