
;defs
#include "zx81defs.asm"
;ROM routines
#include "zx81rom.asm"
;ZX81 char codes/how to survive without ASCII
#include "charcodes.asm"
;system variables
#include "zx81sys.asm"

;Line 0
;the standard REM statement that will contain our 'hex' code
Line0:          DEFB $00,0                      ; Line 0
                DEFW Line0End-Line0Text         ; Line length
Line0Text:      DEFB $EA                        ; REM
                DEFB _NL                        ; Newline
                DEFB _NL                        ; Newline to hide rest of line from ROM list routine


COPYTOADDR:
             ld   hl,NEWLIST                 ;start of package
             ld   bc,CODEEND-NEWLIST         ;size to copy
             ld   de,(SEED)                  ;get destination from RAND
             ldir                            ;copy
             ret


NEWLIST:
             ld   d,21
             push de
             ld   bc,1400h
             call PRINTAT                    ;print at b,c (20,0)
             ld   hl,BASICPROG               ;beginning of program
NL:
             call OUTNO                      ;print line no.
             pop  de
             ld   e,22
             push de
             inc  hl
             ld   c,(hl)
             inc  hl
             ld   b,(hl)
             push hl
             add  hl,bc
             ld   b,h
             ld   c,l                        ;bc points to newline at end of line
             pop  hl
             inc  hl
             ld   a,(hl)
             exx
             ld   b,a                        ;store instruction code
             exx
             xor  a
NEWLINE:
             jr   nz,NL
START:
             push bc
             ld   a,(hl)
             cp   126                        ;check if numeric (7Eh) follows
             jr   nz,NOT126
             exx
             ld   a,b
             exx
             cp   0EAh                       ;ignore numerics for REM statements
             jr   z,NOT126
             ld   bc,5
             add  hl,bc                      ;jump over 5 bytes of data
             sub  c
             jr   SKIP
NOT126:
             ld   a,(hl)
             bit  6,a                        ;see if chr$(a) is printable
             push af                         ;preserve carry flag
             call nz,TOKENS                  ;expands chr$(a)
             pop  af
             call z,PRINT                    ;prints chr$(a)
SKIP:
             inc  hl
             ld   a,(S_POSN+1)
             cp   3
             pop  bc
             jr   nz,NOSCROLL
             pop  de
             dec  d
             dec  e
             xor  a
             cp   d                          ;see if pause is needed
             push af                         ;preserve carry flag
             jr   nz,MISS
             or   e
             and  0FEh
             jr   nz,UPDATED
             ld   e,21
UPDATED:
             ld   d,e
MISS:
             pop  af
             push de     
             push hl     
             push bc
             jr   z,PAUSER
NOPAUSE:
             ld   hl,(D_FILE)
             push hl
             ld   de,33
             add  hl,de
             pop  de
             ld   bc,693
             ldir                            ;scroll a line
             xor  a
             ld   b,32
LOOP:
             inc  de
             ld   (de),a
             djnz LOOP
             ld   a,(S_POSN)
             ld   c,a
             ld   a,33
             sub  c
             ld   c,a
             ld   b,20
             call PRINTAT                    ;print at 20,c
             pop  bc
             pop  hl
NOSCROLL:
             xor  a
             sbc  hl,bc
             rla
             add  hl,bc
             rra
             jr   c,START
             ld   a,(hl)
             rst  10
             inc  hl
             ld   a,(hl)
             cp   _NL
             jr   nz,NEWLINE                 ;if end of program then return to BASIC
             pop  de
             ret

PAUSER:
             ld   hl,(D_FILE)
             ld   de,760
             add  hl,de                      ;address for 23,0
             push hl
             ld   (hl),80h 	                 ;print an inverse space
             ld   b,0FFh
             call PAUSE+3
             ld   a,0FFh
             ld   (FRAMES+1),a               ; sv FRAMES_hi (ROM Edition 2 bug)
             ld   hl,(LAST_K)                ;last key
             ld   de,0FD7Fh                  ;code for 'break'
             and  a
             sbc  hl,de
             add  hl,de                      ;cp hl,de
             jr   z,BREAK                    ;if break pressed then
             pop  hl
             ld   (hl),0
             jr   NOPAUSE

BREAK:
             rst  08                         ;if break pressed then
             DEFB 12                         ;output error code D

CODEEND:

                DEFB _NL                        ; Newline

Line0End


;append the BASIC code that runs the program
#include "line10.asm"

; ===========================================================
; code ends
; ===========================================================
;display file defintion
#include "screen.asm"

;close out the basic program
#include "endbasic.asm"
