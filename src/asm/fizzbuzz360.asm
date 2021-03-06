FIZZBUZZ CSECT                       A SECTION OF CODE STARTS HERE, LABEL IT FIZZBUZZ
**********HOUSE KEEPING AREA**********************
         USING *,12                  FOR THIS PROGRAM WE ARE GOING TO USE REGISTER 12
         STM   14,12,12(13)          SAVE REGISTERS 14,15, AND 0-12 IN CALLER'S SAVE AREA
         LR    12,15                 PUT OUR ENTRY ADDRESS(IN R15) INTO OUR BASE REGISTER
         LA    15,SAVE               POINT R15 AT THE *OUR* SAVE AREA (DEFINED AT THE END)
         ST    15,8(13)              SET FORWARD CHAIN                 
         ST    13,4(15)              SET BACKWARD CHAIN                
         LR    13,15                 SET R13 TO THE ADDRESS OF OUT NEW SAVE AREA
**********MAIN*PROGRAM****************************                     
         LA    10,LOOP               PUT THE LOOP START ADDRESS IN R10 
         LA    8,100                 PUT THE NUMBER OF ITERATIONS IN R8
         LA    5,=F'1'               INITIALIZE BINARY COUNTER TO ONE  
LOOP     EQU   *                     LABEL THE LOOP START              
         A     5,=F'1'               ADD TO BINARY LOOP COUNTER                      
         AP    NUM,=PL1'1'           ADD TO PACKED LOOP COUNTER                  
         B     CHK15                 CHECK IF COUNTER IS % 12                          
LCHK15   EQU   *                     IF NOT, COME BACK                                    
         B     CHK3                  CHECK IF COUNTER IS % 3                            
LCHK3    EQU   *                     IF NOT, COME BACK              
         B     CHK5                  CHECK IF COUNTER IS % 4                            
LCHK5    EQU   *                     IF NOT, COME BACK          
         MVC   EOUT,EMSK             PREPARE TO PKD->EBCDIC                        
         EDMK  EOUT,NUM              PKD->EBCDIC                                    
ENLOOP   EQU   *                     IF A TEST WAS POSITIVE RETURN HERE                    
         WTO   MF=(E,WTOSTART)       PRINT RESULT OF LOOP                    
         BCTR  8,10                  START OVER                                               
**********HOUSE KEEPING AREA**********************                     
         L     13,4(13)              RESTORE ADDRESS TO CALLER'S SAVE AREA
         LM    14,12,12(13)          RESTORE REGISTERS AS ON ENTRY
         XR    15,15                 XOR R15 SO IT IS ALL 0 (R15 CREATES THE PROGRAM RETURN CODE)
         BR    14                    RETURN WHERE YOU CAME FROM
**********SUBROUTINE AREA*************************
*////////CHK3////////////////////////////////////*                                        
CHK3     EQU   *                     LABEL ENTRY POINT                                     
         LR    6,5                   LOAD R6 WITH R5(THE BINARY LOOP INDEX)                      
         A     6,=F'1'               ADD ONE TO R6                                  
         SRDA  6,32                  SHIFT RD VAL 32 BITS RIGHT(TO R7)                  
         D     6,=F'3'               DIVIDE BY 3                                     
         C     6,=F'0'               IS REMAINDER 0?                                 
         BE    DIV3                  IF SO GOTO DIV3 ROUTINE                           
         B     LCHK3                 IF NOT GO BACK TO LOOP                            
*////////CHK15///////////////////////////////////*                     
CHK15    EQU   *                     LABEL ENTRY POINT                                   
         LR    6,5                   LOAD R6 WITH R5(THE BINARY LOOP INDEX)
         A     6,=F'1'               ADD ONE TO R6                         
         SRDA  6,32                  SHIFT RD VAL 32 BITS RIGHT(TO R7)     
         D     6,=F'15'              DIVIDE BY 15                          
         C     6,=F'0'               IS REMAINDER 0?                       
         BE    DIV15                 IF SO GOTO DIV15 ROUTINE              
         B     LCHK15                IF NOT GO BACK TO LOOP                
*////////CHK5////////////////////////////////////*                     
CHK5     EQU   *                     LABEL ENTRY POINT                     
         LR    6,5                   LOAD R6 WITH R5(THE BINARY LOOP INDEX)
         A     6,=F'1'               ADD ONE TO R6                         
         SRDA  6,32                  SHIFT RD VAL 32 BITS RIGHT(TO R7)     
         D     6,=F'5'               DIVIDE BY 5                           
         C     6,=F'0'               IS REMAINDER 0?                       
         BE    DIV5                  IF SO GOTO DIV5 ROUTINE              
         B     LCHK5                 IF NOT GO BACK TO LOOP                
*////////////////////////////////////////////////*                     
DIV3     EQU   *                     LABEL ENRTY POINT                                     
         MVC   EOUT,FIZZ             SAY FIZZ                                      
         B     ENLOOP                RETURN TO LOOP                                   
*////////////////////////////////////////////////*                     
DIV5     EQU   *                     LABEL ENTRY POINT                                  
         MVC   EOUT,BUZZ             SAY BUZZ                                  
         B     ENLOOP                RETURN TO LOOP                                  
*////////////////////////////////////////////////*                     
DIV15    EQU   *                     LABEL ENTRY POINT                                  
         MVC   EOUT,FIZZBUZ          SAY FIZZBUZZ                                  
         B     ENLOOP                RETURN TO LOOP                                  
**********VARIABLE STORAGE************************                     
FIZZBUZ  DC    CL10'FIZZBUZZ!'       CREATE A STRING IN MEMORY, LABEL THE ADDRESS FIZZBUZ
FIZZ     DC    CL10'FIZZ!'           CREATE A STRING IN MEMORY, LABEL THE ADDRESS FIZZ
BUZZ     DC    CL10'BUZZ!'           CREATE A STRING IN MEMORY, LABEL THE ADDRESS BUZZ
NUM      DC    PL3'0'                CREATE A DECIMAL IN MEMORY, MAKE IT ZERO, LABEL IT NUM
TEMP     DS    D                     RESERVE A DOUBLE WORD (8 BYTES) IN MEMORY, LABEL IT TEMP
EMSK     DC    X'402020202020'       CREATE A HEX ARRAY IN MEMORY, LABEL IT EMSK
WTOSTART DC    Y(WTOEND-*,0)         LABEL THIS WTOSTART, DEFINE A CONSTANT ADDRESS EQUAL TO
*                                    "WTOEND" MINUS HERE(*)
EOUT     DS    CL10                  RESERVE SPACE FOR 10 CHARACTERS, LABEL THIS EOUT           
WTOEND   EQU   *                     THE MEMORY ADDRESS LOCATED HERE IS LABELED WTOEND
**********HOUSE KEEPING AREA**********************                   
SAVE     DS    18F                                                     
         END   HELLO                