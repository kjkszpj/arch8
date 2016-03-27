mov a0, #10
mov a1, #1

for:
push a0
push a1

checkPrinter:
ld a0, C000h
or a0, #80h
mov a1, #81h
sub a0, a1
jnz checkPrinter

pop a1
pop a0
st a0, 8002h
sub a0, a1
jp for
loop:
jmp loop

