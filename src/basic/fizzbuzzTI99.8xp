10 REM **FIZZBUZZ IN TI-BASIC**
20 FOR I = 1 TO 100
30 IF ((I/15)-INT(I/15))=0 THEN 120
40 IF ((I/3)-INT(I/3))=0 THEN 80
50 IF ((I/5)-INT(I/5))=0 THEN 100
60 PRINT I
70 GOTO 140
80 PRINT "FIZZ"
90 GOTO 140
100 PRINT "BUZZ"
110 GOTO 140
120 PRINT "FIZZBUZZ"
130 GOTO 140
140 NEXT I
150 END