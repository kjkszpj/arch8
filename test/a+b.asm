CALL init
mov a0, #0
mov a1, #0
CALL input
mov a0, #0
mov a1, #0
CALL calc
mov a0, #0
mov a1, #0
CALL output
exit:
jmp exit

init:
	mov a0, #0h
	mov a2, #0
	st a0, 7E00h
	loop_1:
		mov @a0, a2
		inc 7E00h
		ld a0, 7E00h
	jnz loop_1
	mov a0, #0
	mov a1, #0
	mov a2, #0
	ret

input:
	push a2
	push a3
	loop_input1:
		CALL check_input

		ld a1, 8001h
		mov a2, #9
		mov a3, #0
		add a3, a1
		sub a3, a2
		jp break_input1

		inc 7E00h
		ld a0, 7E00h
		mov a2, #9
		add a0, a2
		mov @a0, a1
	jmp loop_input1
	break_input1:

	loop_input2:
		CALL check_input

		ld a1, 8001h
		mov a2, #9
		mov a3, #0
		add a3, a1
		sub a3, a2
		jp break_input2

		inc 7E01h
		ld a0, 7E01h
		ld a2, 7E00h
		add a0, a2
		mov a2, #9
		add a0, a2
		mov @a0, a1
	jmp loop_input2
	break_input2:

	pop a3
	pop a2
	ret

check_input:
	ld a0, C000h
	mov a1, #2h
	sub a0, a1
	jp input_ready
	jmp check_input
	input_ready:
	ret

calc:
	push a2
	push a3

	mov a2, #10
	st a2, 7E02h

	ld a0, 7E00h
	add a0, a2
	st a0, 7E03h

	ld a0, 7E02h
	ld a1, 7E00h
	mov a2, #1
	add a0, a1
	sub a0, a2
	st a0, 7E04h

	ld a0, 7E03h
	ld a1, 7E01h
	mov a2, #1
	add a0, a1
	sub a0, a2
	st a0, 7E05h

	mov a2, #0
	st a2, 7E06h

	loop_calc:
		ld a0, 7E04h
		ld a1, 7E02h
		CALL getv
		push a0
		ld a0, 7E05h
		ld a1, 7E03h
		CALL getv
		push a0
		pop a1
		pop a0
		add a0, a1
		push a0

		ld a0, 7E03h
		ld a1, 7E01h
		add a0, a1
		push a0
		ld a0, 7E03h
		ld a1, 7E04h
		sub a0, a1
		pop a3
		add a3, a0
		mov a2, #1
		sub a3, a2
		pop a0
		mov a1, @a3
		add a0, a1
		mov @a3, a0

		mov a2, #10
		sub a0, a2
		jc continue
		mov @a3, a0
		mov a2, #1
		add a3, a2
		mov @a3, a2
		continue:
		ld a0, 7E04h
		ld a1, 7E05h
		mov a2, #01
		sub a0, a2
		sub a1, a2
		st a0, 7E04h
		st a1, 7E05h
		ld a3, 7E02h
		sub a3, a0
		jp overa
		jmp loop_calc
		overa:
		ld a3, 7E03h
		sub a3, a1
		jp overb
		jmp loop_calc
	overb:
	ld a0, 7E03h
	ld a1, 7E04h
	sub a0, a1
	st a0, 7E06h

	ld a0, 7E03h
	ld a1, 7E01h
	add a0, a1
	ld a1, 7E06h
	add a0, a1
	mov a2, #1
	sub a0, a2
	mov a0, @a0
	or a0, #0
	jp carryc
	ld a0, 7E06h
	mov a2, #1
	sub a0, a2
	st a0, 7E06h
	carryc:
	pop a3
	pop a2
	ret

getv:
	sub a1, a0
	jp over
	jmp nover
	over:
	mov a0, #0
	ret
	nover:
	mov a0, @a0
	ret

output:
	push a2
	push a3
	ld a0, 7E02h
	ld a1, 7E00h
	add a0, a1
	mov a2, #FFh
	add a0, a2
	CALL puts

	ld a0, 7E03h
	ld a1, 7E01h
	add a0, a1
	mov a2, #FFh
	add a0, a2
	CALL puts

	CALL check_print
	mov a0, #10h
	st a0, 8002h
	CALL check_print
	mov a0, #0bh
	st a0, 8002h
	CALL check_print
	mov a0, #09h
	st a0, 8002h
	CALL check_print
	mov a0, #1Ah
	st a0, 8002h

	ld a0, 7E03h
	ld a1, 7E01h
	add a0, a1
	ld a1, 7E06h
	mov a2, #1
	CALL puts
	pop a3
	pop a2
	ret

check_print:
	push a2
	push a3
	checkPrinter:
	ld a2, C000h
	or a2, #80h
	mov a3, #81h
	sub a2, a3
	jnz checkPrinter
	pop a3
	pop a2
	ret

puts:
	push a2
	push a3
	CALL check_print
	mov a3, #0Ah
	st a3, 8002h
	CALL check_print
	st a3, 8002h
	loop_put:
		mov a3, #1
		sub a1, a3
		mov a3, @a0
		jnz noend
		or a3, #10h
		CALL check_print
		st a3, 8002h
		jmp break_put
		noend:
		CALL check_print
		st a3, 8002h
		add a0, a2
	jmp loop_put
	break_put:
	pop a3
	pop a2
	ret
