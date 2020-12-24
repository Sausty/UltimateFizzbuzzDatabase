;; CP/M FizzBuzz in 8080 assembly
 
bdos:	equ	5	; CP/M calls
puts:	equ	9
 
max:	equ	100 	; Amount of lines to print
 
	org	100h
	mvi	d,max
	lxi	b,0305h	; Fizz and buzz counters 
 
line:	lxi	h,num + 2	; Increment the ASCII number
incn:	inr	m
	mov	a,m
	cpi 	'9' + 1
	jnz	print
	mvi	m,'0'
	dcx	h
	jmp	incn
 
print:	mvi	e,0	; Mark that we haven't output anything
	dcr	b	; Time for fizz?
	cz	fizzo
	dcr	c	; Time for buzz?
	cz	buzzo
	dcr	e	; Output number if nothing else has been printed
	jz	check
	lxi	h,num 
	call	outs
check:	lxi	h,nl	; Output a newline
	call	outs
	dcr	d	; More lines?
	jnz	line 
	ret
 
	;; "Fizz", and reset the fizz counter
fizzo:	lxi	h,fizz
	mvi	b,3
	inr	e
	jmp	outs
 
	;; "Buzz", and reset the buzz counter
buzzo:	lxi	h,buzz
	mvi	c,5
	mvi	e,1
 
	;; Output string in HL preserving registers
outs:	push	b
	push	d
	push	h
	mvi	c,puts
	xchg
	call	bdos
	pop	h
	pop	d
	pop	b
	ret
 
	;; Strings
fizz:	db	'Fizz$'
buzz:	db	'Buzz$'
num:	db	'000$'
nl:	db	13, 10, '$'