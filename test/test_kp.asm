ld a0, C000h
mov a1, #2h
sub a0, a1
jp print

jmp loop

print:
ld a2, 8001h

checkPrinter:
ld a0, C000h
or a0, #80h
mov a1, #81h
sub a0, a1
jnz checkPrinter

st a2, 8002h

jmp loop