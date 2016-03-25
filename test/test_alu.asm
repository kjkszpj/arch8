nop
nop

mov a0, #42
mov a1, #33

mov a2, #0
add a2, a0
add a2, a1

mov a2, #0
add a2, a0
sub a2, a1

mov a2, #0
add a2, a0
mov @a1, a1
mov a2, @a1
adc a2, @a1

mov a2, #0
add a2, a0
asr a2

mov a2, #0
add a2, a0
or a2, #10

st a2, 7E20h
inc 7E20h
ld a2, 7E20h
