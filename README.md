# Introduction

This repository contains the design for a very low part count 6502 design. It was designed as a hobby project to learn more about writing in assembly language and as a cheap retro computing project. I will upload more design documents, utilities, and general information to this repo as it becomes available.

# Minimality

The full computer fits across two double breadboards. Expensive ICs were removed from the design to bring the cost and size of the project down significantly. A few of the changes are listed below:

* The ROM which usually holds the program was removed; the program is now loaded into and executed from RAM.
* An Arduino Nano writes the assembled program to RAM, generates the 6502's clock, and can print the state of the data bus.
* The 6522 Versatile Interface Adapter was removed and replaced with simple address decoding logic. This makes the project harder to extend.

# Memory Map

Below is the memory map for the current design of the computer.

`0x0000 - 0x00FF` Zero-page general purpose memory

`0x0100 - 0x01FF` Stack

`0x0200 - 0x7FF9` Program memory / General purpose memory

`0x7FFA - 0x7FFF` Illegal - mirrored vector addresses

`0x8000 - 0x8001` Display Data Write

`0x8002 - 0xBFFF` Unused I/O

`0xC000 - 0xFFF9` Illegal - mirrored program addresses

`0xFFFA - 0xFFFB` Non-maskable Interrupt Vector

`0xFFFC - 0xFFFD` Reset Vector

`0xFFFE - 0xFFFF` Interrupt Request/Break Vector

# References

The amazing Ben Eater series on the 6502 inspired this project; it can be found here: https://www.youtube.com/watch?v=LnzuMJLZRdU&list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH