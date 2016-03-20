nop
nop
mov a0, #33
mov a1, #22
mov a2, #0
add a2, a0
sub a2,a1

jp else
mov a2, #0
add a2, a1
jmp loop

else:
mov a2, #0
add a2, a0

loop:
jmp loop
nop
nop
