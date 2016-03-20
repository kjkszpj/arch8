nop
nop

mov a0, #42
mov a1, #33
mov @a0, a1
mov a2, @a0

mov @a0, a0
mov a0, @a0
mov a1, @a0