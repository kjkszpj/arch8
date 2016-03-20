nop
nop

mov a0, #42
push a0
pop a1

nop
nop

call f
nop

mov a1, #8

loop:
jmp loop

f:
mov a1, #11
push a1
pop a2
ret