#!/bin/bash

# Check if a file path is provided
if [[ -z "$1" ]]; then
  echo "Usage $0 <file.asm>"
  exit 1
fi

# Check if file exists
if [[ ! -f "$1" ]]; then
  echo "Error: File '$1' does not exist"
  exit 1
fi

dir=$(dirname "$1")
base=$(basename "$1" .asm)

yasm -g dwarf2 -f elf64 -o "$dir/$base.o" "$dir/$base.asm"
ld -g -o "$dir/$base" "$dir/$base.o"
gdb "$dir/$base"
