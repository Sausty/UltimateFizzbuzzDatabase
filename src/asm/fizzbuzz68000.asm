;
; FizzBuzz for Motorola 68000 under AmigaOs 2+ by Thorham
;
; Uses counters instead of divisions.
;
_LVOOpenLibrary equ -552
_LVOCloseLibrary equ -414
_LVOVPrintf equ -954
 
execBase=4
 
start
    move.l  execBase,a6
 
    lea     dosName,a1
    moveq   #36,d0
    jsr     _LVOOpenLibrary(a6)
    move.l  d0,dosBase
    beq     exit
 
    move.l  dosBase,a6
    lea     counter,a2
 
    moveq   #3,d3   ; fizz counter
    moveq   #5,d4   ; buzz counter
 
    moveq   #1,d7
.loop
    clr.l   d5
 
; fizz
    subq.l  #1,d3
    bne     .noFizz
    moveq   #1,d5
    moveq   #3,d3
    move.l  #fizz,d1
    clr.l   d2
    jsr     _LVOVPrintf(a6)
.noFizz

; buzz
    subq.l  #1,d4
    bne     .noBuzz
    moveq   #1,d5
    moveq   #5,d4
    move.l  #buzz,d1
    clr.l   d2
    jsr     _LVOVPrintf(a6)
.noBuzz

; number
    tst.l   d5
    bne     .noNumber
    move.l  d7,(a2)
    move.l  #number,d1
    move.l  a2,d2
    jsr     _LVOVPrintf(a6)
 
.noNumber
    move.l  #newLine,d1
    clr.l   d2
    jsr     _LVOVPrintf(a6)
 
    addq.l  #1,d7
    cmp.l   #100,d7
    ble     .loop
 
exit
    move.l  execBase,a6
    move.l  dosBase,a1
    jsr     _LVOCloseLibrary(a6)
    rts
;
; variables
;
dosBase
    dc.l    0
 
counter
    dc.l    0
;
; strings
;
dosName
    dc.b    "dos.library",0
 
newLine
    dc.b    10,0
 
number
    dc.b    "%ld",0
 
fizz
    dc.b    "Fizz",0
 
buzz
    dc.b    "Buzz",0