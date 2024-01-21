# p-code virtual machines experimentation sandbox v2



- **mk1** - as close to Wirth's machine as possible
- **mk2** - variable number of arguments, swapped a and l
- **mk3** - internal bytecode version of mk2



Extension 1 - stdio:

- PUTC, PUTI
- GETC, GETI



Extension 2 - ALU extension:

- INC, DEC
- AND, OR, XOR, NOT
- SHL, SHR, SAR
- EQZ, NEZ, LTZ, LEZ, GTZ, GEZ



Reference materials:

- https://en.wikipedia.org/wiki/P-code_machine
- https://github.com/mobarski/vimes
- https://github.com/mobarski/smol
- https://rosettacode.org/wiki/Category:PL/0
- https://rosettacode.org/wiki/Category:XPL0
