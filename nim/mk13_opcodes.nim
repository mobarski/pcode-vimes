type Instr = enum
    HLT=0
    JMP=1
    CAL=2
    RET=3
    JZ=4
    JNZ=5
    LIT=6
    MOV=7
    PEEK=8
    POKE=9
    ADD=10
    SUB=11
    MOD=12
    MUL=13
    DIV=14
    NEG=15
    EQ=16
    NE=17
    LT=18
    LE=19
    GT=20
    GE=21
    PUT=22
    PUTC=23
    GET=24
    GETC=25
    EOF=26
    LDA=27
    STA=28
