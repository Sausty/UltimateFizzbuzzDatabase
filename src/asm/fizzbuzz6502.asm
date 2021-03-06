	.lf  fzbz6502.lst	
	.cr  6502	
	.tf  fzbz6502.obj,ap1
;------------------------------------------------------
; FizzBuzz for the 6502 by barrym95838 2013.04.04
; Thanks to sbprojects.com for a very nice assembler!
; The target for this assembly is an Apple II with
;   mixed-case output capabilities and Applesoft
;   BASIC in ROM (or language card)
; Tested and verified on AppleWin 1.20.0.0
;------------------------------------------------------
; Constant Section	
;			
FizzCt	 =   3		;Fizz Counter (must be < 255)
BuzzCt	 =   5		;Buzz Counter (must be < 255)
Lower	 =   1		;Loop start value (must be 1)
Upper	 =   100	;Loop end value (must be < 255)
CharOut	 =   $fded	;Specific to the Apple II
IntOut	 =   $ed24	;Specific to ROM Applesoft
;======================================================
	.or  $0f00	
;------------------------------------------------------
; The main program	
;			
main	ldx  #Lower	;init LoopCt	
	lda  #FizzCt	
	sta  Fizz	;init FizzCt
	lda  #BuzzCt	
	sta  Buzz	;init BuzzCt
next	ldy  #0		;reset string pointer (y)
	dec  Fizz	;LoopCt mod FizzCt == 0?
	bne  noFizz	;  yes:
	lda  #FizzCt	
	sta  Fizz	;    restore FizzCt
	ldy  #sFizz-str	;    point y to "Fizz"
	jsr  puts	;    output "Fizz"
noFizz	dec  Buzz	;LoopCt mod BuzzCt == 0?
	bne  noBuzz	;  yes:
	lda  #BuzzCt	
	sta  Buzz	;    restore BuzzCt
	ldy  #sBuzz-str	;    point y to "Buzz"
	jsr  puts	;    output "Buzz"
noBuzz	dey  		;any output yet this cycle?
	bpl  noInt	;  no:
	txa  		;    save LoopCt
	pha  		
	lda  #0		;    set up regs for IntOut
	jsr  IntOut	;    output itoa(LoopCt)
	pla  		
	tax  		;    restore LoopCt
noInt	ldy  #sNL-str	
	jsr  puts	;output "\n"
	inx  		;increment LoopCt
	cpx  #Upper+1	;LoopCt >= Upper+1?
	bcc  next	;  no:  loop back
	rts  		;  yes:  end main
;------------------------------------------------------
; Output zero-terminated string @ (str+y)
;   (Entry point is puts, not outch)
;			
outch	jsr  CharOut	;output string char
	iny  		;advance string ptr
puts	lda  str,y	;get a string char
	bne  outch	;output and loop if non-zero
	rts  		;return
;------------------------------------------------------
; String literals (in '+128' ascii, Apple II style)
;			
str:	;		string base offset
sFizz	.az	-"Fizz"	
sBuzz	.az	-"Buzz"	
sNL	.az	-#13	
;------------------------------------------------------
; Variable Section	
;			
Fizz	.da	#0	
Buzz	.da	#0	
;------------------------------------------------------
	.en  		