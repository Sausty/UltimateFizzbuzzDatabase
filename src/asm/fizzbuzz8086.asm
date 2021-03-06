                    ; Init the registers
mov dx,03030h       ; For easier printing, the number is
                    ;kept in Binary Coded Decimal, in
----
 
                    ;the DX register.
mov ah,0Eh          ; 0Eh is the IBM PC interrupt 10h
                    ;function that does write text on
                    ;the screen in teletype mode.
mov bl,100d         ; BL is the counter (100 numbers).
xor cx,cx           ; CX is a counter that will be used
                    ;for screen printing.
xor bh,bh           ; BH is the counter for counting
                    ;multiples of three.
 
writeloop:          ; Increment the BCD number in DX.          
inc dl              ; Increment the low digit
cmp dl,3Ah          ; If it does not overflow nine,
jnz writeloop1      ;continue with the program,
mov dl,30h          ;otherwise reset it to zero and
inc dh              ;increment the high digit
writeloop1:         
inc bh              ; Increment the BH counter.
cmp bh,03h          ; If it reached three, we did
                    ;increment the number three times
                    ;from the last time the number was
                    ;a multiple of three, so the number
                    ;is now a multiple of three now,
jz writefizz        ;then we need to write "fizz" on the
                    ;screen.
cmp dl,30h          ; The number isn't a multiple of
jz writebuzz        ;three, so we check if it's a
cmp dl,35h          ;multiple of five. If it is, we
jz writebuzz        ;need to write "buzz". The program
                    ;checks if the last digit is zero or
                    ;five.
mov al,dh           ; If we're here, there's no need to
int 10h             ;write neither "fizz" nor "buzz", so
mov al,dl           ;the program writes the BCD number
int 10h             ;in DX
writespace:
mov al,020h         ;and a white space.
int 10h
dec bl              ; Loop if we didn't process 100
jnz writeloop       ;numbers.
 
programend:         ; When we did reach 100 numbers,
cli                 ;the program flow falls here, where
hlt                 ;interrupts are cleared and the
jmp programend      ;program is stopped.
 
writefizz:          ; There's need to write "fizz":
mov si,offset fizz  ; SI points to the "fizz" string,
call write          ;that is written on the screen.
xor bh,bh           ; BH, the counter for computing the
                    ;multiples of three, is cleared.
cmp dl,30h          ; We did write "fizz", but, if the
jz writebuzz        ;number is a multiple of five, we
cmp dl,35h          ;could need to write "buzz" also:
jnz writespace      ;check if the number is multiple of
                    ;five. If not, write a space and
                    ;return to the main loop.
writebuzz:          ; (The above code falls here if
                    ;the last digit is five, otherwise
                    ;it jumps)
mov si,offset buzz  ;SI points to the "buzz" string,
call write          ;that is written on the screen.
jmp writespace      ; Write a space to return to the main
                    ;loop.
 
write:              ; Write subroutine: 
mov cl,04h          ; Set CX to the lenght of the string:
                    ;both strings are 4 bytes long.
write1:
mov al,[si]         ; Load the character to write in AL.
inc si              ; Increment the counter SI.
int 10h             ; Call interrupt 10h, function 0Eh to
                    ;write the character and advance the
                    ;text cursor (teletype mode)
loop write1         ; Decrement CX: if CX is not zero, do
ret                 ;loop, otherwise return from
                    ;subroutine.
 
fizz:               ;The "fizz" string.
db "fizz"
 
buzz:               ;The "buzz" string.
db "buzz"