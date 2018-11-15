;
; AVR_Recursion.asm
;
; Created: 11/15/2018 2:13:14 PM
; Author : WeiJun Syu
;

start:
    ldi r16, high(RAMEND)
	out SPH, r16
	ldi r16, low(RAMEND)
	out SPL, r16

	ldi r16, 3
	mov r0, r16
	push r16
	call sum
	pop r16
	jmp done


sum:
	push ZH
	push ZL
	push r16

	in ZH, SPH
	in ZL, SPL
	
	ldd r16, z+7
	push r16
	call sumHelper
	pop r16
	add r0, r16

	pop r16
	pop ZL
	pop ZH
	ret


sumHelper:
	push ZH
	push ZL
	push r16

	in ZH, SPH
	in ZL, SPL
	
	ldd r16, z+7
	cpi r16, 1
	breq base

	; recursive step
	dec r16
	push r16
	call sumHelper
	pop r16
	add r0, r16

	pop r16
	pop ZL
	pop ZH
	ret

base:
	clr r0
	
	pop r16
	pop ZL
	pop ZH
	ret


done:
	jmp done