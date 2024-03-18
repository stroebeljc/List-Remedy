Line10          DEFB $00,10                     ; Line 10
                DEFW Line10End-Line10Text       ; Line length
Line10Text      DEFB $F5,$C1                    ; PRINT AT
                DEFB $C5,_QT,_2,_0,_QT,_CM,$C5,_QT,_0,_QT,_SC ; VAL "20",VAL "0";
                DEFB _QT,_R,_E,_L,_O,_C,_A,_T,_E,,_T,_O,_CL,_QT ; "RELOCATE TO:"
                DEFB _NL                        ; Newline
Line10End 

Line20          DEFB $00,20                     ; Line 20
                DEFW Line20End-Line20Text       ; Line length
Line20Text      DEFB $EE,_R                     ; INPUT R
                DEFB _NL                        ; Newline
Line20End 

Line30          DEFB $00,30                     ; Line 30
                DEFW Line30End-Line30Text       ; Line length
Line30Text      DEFB $F9,_R                     ; RAND R
                DEFB _NL                        ; Newline
Line30End 

Line40          DEFB $00,40                     ; Line 40
                DEFW Line40End-Line40Text       ; Line length
Line40Text      DEFB $F9,$D4,$C5                ; RAND USR VAL
                DEFB _QT,_1,_6,_5,_1,_6,_QT,_PL,$D4,_R ; "16516"+USR R
                DEFB _NL                        ; Newline
Line40End 
