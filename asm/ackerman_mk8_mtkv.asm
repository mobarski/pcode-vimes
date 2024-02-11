# Ackerman function: multi-token kv variant

# REF: https://en.wikipedia.org/wiki/Ackermann_function
#  A(x,y) -> y+1             if x==0
#            A(x-1,1)        if y==0
#            A(x-1,A(x,y-1)) otherwise

from=lda
to=sta
peek=lpa
poke=spa
push-s=inc,s,poke,s
pop-s=peek,s,dec,s

x=2
y=3
s=4 # stack
xx=5
yy=6
sb=10 # stack base

lit 0 to 0
lit 1 to 1
in 0 to x
in 0 to y
lit sb to s

from x push-s # push
from y push-s # push
cal ack
pop-s out 0 # show result
hlt 0

ack:
    pop-s to yy
    pop-s to xx
    from xx jz x_is_0
    from yy jz y_is_0
    otherwise: # return A(x-1,A(x,y-1))
        from xx sub 1
        push-s # push x'
        from xx
        push-s # push x''
        from yy sub 1
        push-s # push y''
        cal ack # x'' y''
        cal ack # x' A(x'',y'')
        ret 0

    x_is_0: # return y+1
        from yy add 1
        push-s # push result
        ret 0
    
    y_is_0: # return A(x-1,1)
        from xx sub 1
        push-s # push x'
        lit 1
        push-s # push y'
        cal ack
        ret 0
