org &4000		; put code at memory address 0x4000
wr_char equ &bb5a ; write ASCII character in register A to screen
cursor equ &bb78 ; get cursor position
 
push bc
push de
push hl
 
ld b,100		; loop from 100 to 1
loop:
 
; check for Fizz condition
ld a,(count3)
dec a
jr nz,next3
push bc
ld b,4
ld de,fizz
printfizz:
ld a,(de)
call wr_char
inc de
djnz printfizz
pop bc
ld a,3
next3:
ld (count3),a
 
; check for Buzz condition
ld a,(count5)
dec a
jr nz,next5
push bc
ld b,4
ld de,buzz
printbuzz:
ld a,(de)
call wr_char
inc de
djnz printbuzz
pop bc
ld a,5
next5:
ld (count5),a
 
; test if cursor is still in first column
;   (i.e., no Fizz or Buzz has been printed)
call cursor
ld a,h
dec a
jr nz,skipnum
 
; print number
push bc
ld b,3
ld de,count
loop2:
ld a,(de)
call wr_char
inc de
djnz loop2
pop bc
 
skipnum:
; print carriage return/line feed
ld a,13
call wr_char
ld a,10
call wr_char
 
; increment rightmost digit 
ld hl,count+2
inc (hl)
ld a,(hl)
; check if value is 10 (ASCII 58)
;   if so, set to 48 (ASCII 0) and increase 10's digit
cp 58
jr nz,noinc
ld a,48
ld (count+2),a
ld (hl),a
dec hl
inc (hl)
 
ld a,(hl)
; check second-to-right digit, if it is 10 (0), carry over to 100's
cp 58
jr nz,noinc
ld a,48
ld (count+1),a
ld (hl),a
dec hl
inc (hl)
 
noinc:
 
djnz loop
 
pop hl
pop de
pop bc
 
; return to BASIC
ret
 
count:
db "001"
 
count3:
db 3
 
count5:
db 5
 
fizz:
db "Fizz"
 
buzz:
db "Buzz"