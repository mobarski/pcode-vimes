# mk2: variable number of arguments, a and l swapped

type Cell = int16
const STACK_SIZE = 1000

include opcodes
include ex1
include ex2

var p : Cell # program counter
var b : Cell # base pointer
var t : Cell # top of stack pointer

var s : array[STACK_SIZE, Cell] # stack

proc base(level: Cell) : Cell =
    var b1 = b
    var l = level
    while l > 0:
        b1 = s[b1]
        l = l - 1
    return b1

proc run(code : openArray[int]) =
    while true:
        var i = code[p+0].Cell
        var a = code[p+1].Cell
        var l : Cell # not always used
        p += 2

        case i:
            of LIT: t+=1; s[t]=a
            of LOD:
                l = code[p].Cell; p+=1
                t+=1; s[t]=s[base(l)+a]
            of STO:
                l = code[p].Cell; p+=1
                s[base(l)+a]=s[t]; t-=1
            of INT: t+=a
            of JMP: p=a
            of JPC:
                if s[t]==0:
                    p = a
                    t -= 1
            of CAL:
                l = code[p].Cell; p+=1
                s[t+1] = base(l)
                s[t+2] = b
                s[t+3] = p
                b = t + 1
                p = a
            of OPR:
                case a:
                    of RET: t=b-1; p=s[t+3]; b=s[t+2]
                    of NEG: s[t] = -s[t]
                    of ADD: t-=1; s[t] += s[t+1]
                    of SUB: t-=1; s[t] -= s[t+1]
                    of MUL: t-=1; s[t] *= s[t+1]
                    of DIV: t-=1; s[t] = s[t] div s[t+1]
                    of ODD: s[t] = s[t] mod 2
                    of MOD: t-=1; s[t] = s[t] mod s[t+1]
                    of EQ:  t-=1; s[t] = ord(s[t] == s[t+1]).Cell
                    of NE:  t-=1; s[t] = ord(s[t] != s[t+1]).Cell
                    of LT:  t-=1; s[t] = ord(s[t] <  s[t+1]).Cell
                    of LE:  t-=1; s[t] = ord(s[t] <= s[t+1]).Cell
                    of GT:  t-=1; s[t] = ord(s[t] >  s[t+1]).Cell
                    of GE:  t-=1; s[t] = ord(s[t] >= s[t+1]).Cell
                    else: assert false, "unknown OPR opcode"
            of EX1: ex1(a,s,t)
            of EX2: ex2(a,s,t)
            else: assert false, "unknown opcode"
        if p == 0: break

proc reset(quick=false) =
    p=0; b=0; t=0
    if quick: return
    for j in low(s)..high(s):
        s[j] = 0

# TODO: rename (canditates: debug, trace, dump, show)
proc debug() =
    echo "p:", p, " b:", b, " t:", t, " s:", s[1..t]

# ============================================================

const vm_code = @[
    INT, 0, # nop
    LIT, 11,
    LIT, 22,
    OPR, ADD,
    OPR, NEG,
    LIT, -9,
    OPR, ADD,
    JMP, 0, # halt
]
run(vm_code)
debug()
reset()
run(@[LIT, 64, EX2, PUTC, LIT, -777, EX2, PUTI, LIT, 32, EX2, PUTC, JMP, 0])
debug()
