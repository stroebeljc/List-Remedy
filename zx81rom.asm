;ZX81 ROM routines Editions 2 & 3 (Edition 1 marked in comments with R1
ERROR1          EQU $08
PRINT           EQU $10
PRINTAT         EQU $08F5
DISPROUT        EQU $0281
DISPLAY_3       EQU $0292 ;restore registers after a 'slow' display
DISPLAY_5       EQU $02B5
OUTNO           EQU $0AA5
TOKENS          EQU $094B
PLOT            EQU $0BB2   ;note ROM plot is 0baf - however first thing it does try to pull BC from the calculator stack
                            ; so we'll skip past that and set BC ourselves
CLS             EQU $0A2A
KSCAN           EQU $02BB
DEBOUNCE        EQU $0F4B   ;(R1,$0F48)
FINDCHR         EQU $07BD
COPY            EQU $0869
PAUSE           EQU $0F32   ;(R1,$0F2F)
FAST            EQU $0F23   ;(R1,$0F20)
SLOW            EQU $0F2B   ;(R1,$0F28)
SLOWORFAST      EQU $0207
;sys vars
ERR_NR          EQU $4000