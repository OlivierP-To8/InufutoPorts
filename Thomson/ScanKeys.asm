include 'ThomsonTO.inc'

Keys_Up equ $01
Keys_Down equ $02
Keys_Left equ $04
Keys_Right equ $08
Keys_Button0 equ $10
Keys_Button1 equ $20

zseg
trigger:
    defb 0

cseg
table:
    defb $08, Keys_Left    ; ←
    defb $09, Keys_Right   ; →
    defb $0b, Keys_Up      ; ↑
    defb $0a, Keys_Down    ; ↓
    defb $20, Keys_Button0 ; space
    defb $0d, Keys_Button1 ; enter
    defb 0
ScanKeys_: public ScanKeys_
    pshs b,x

        ; joystick test
        lda PRB1                  ; get trigger data (if bit is 0)
        coma                      ; to check bit is 1
        anda #$40                 ; keep b6 for trigger of joystick 0
        if ne                     ; if trigger button is pressed
            lda #Keys_Button0
        endif
        sta trigger
        lda PRA1                  ; get direction data (if bit is 0)
        coma                      ; value of direction
        anda #$0f                 ; only for joystick 0
        adda trigger
        if eq                     ; if no direction or trigger
            ; keyboard test
            jsr KTST              ; fast test if key pressed
            if cs                 ; if a key is pressed (carry set)
                ldb MODELE        ; check the Thomson model
                cmpb #$02
                if eq             ; if TO9
                    ldb SRDR
                else
                    clrb
                    jsr GETC      ; code of pressed key in B
                endif

                ; convert scankey to internal value
                ldx #table
                do
                    lda ,x        ; A = scankey to compare with B
                while ne          ; while not end of table (A==0)
                    cmpb ,x+      ; compare B with table value
                    if eq
                        lda ,x    ; A = interval value of pressed key (next value in table)
                        bra FIN
                    endif
                    leax 1,x
                wend

                ; press STOP key to exit game, only if loaded from floppy (not K7, M7 or CHG)
                cmpb #$02
                if eq
                    ldx #$9599    ; start of string to test
                    do
                        cmpx #$95D0
                    while ne
                        addb ,X+  ; compute checksum
                    wend
                    cmpb #$09
                    if eq         ; if loaded from custom BIN loader
                        pshs pc   ; test if the PC is in the game or loader
                        puls x
                        cmpx #$A000
                        if ge     ; if PC is in the game
                            jmp $9500
                        endif
                    endif
                endif
            endif
        endif
    FIN:
    puls b,x
rts
