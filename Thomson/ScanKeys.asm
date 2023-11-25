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
GeyKey:
    defw 0

cseg
table:
    defb $08, Keys_Left    ; ←
    defb $09, Keys_Right   ; →
    defb $0b, Keys_Up      ; ↑
    defb $0a, Keys_Down    ; ↓
    defb $20, Keys_Button0 ; space
    defb $0d, Keys_Button1 ; enter
    defb 0

GetKeyROM:
    clrb
    jsr KTST               ; fast test if key pressed
    if cs                  ; if a key is pressed (carry set)
        jsr GETC           ; code of pressed key in B
    endif
rts

GetKeyTO9:
    ldb PRA                ; $01 if key pressed, $00 otherwise
    lsrb                   ; carry set if was #1
    if cs                  ; if a key is pressed
        ldb SRDR           ; last key code
    endif
rts

InitScanKeys_: public InitScanKeys_
    pshs b,x

        ; clear keyboard buffer
        lda #0
        ldb SIZCLV
        ldx BUFCLV
        do
            tstb
        while ne
            sta ,x+
            decb
        wend

        ldb MODELE         ; check the Thomson model
        cmpb #$02
        if eq              ; if TO9
            ldx #GetKeyTO9
        else
            ldb #3         ; size of keyboard buffer
            stb SIZCLV

            ldx #GetKeyROM
        endif
        stx GeyKey

    puls b,x
rts

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
            jsr [GeyKey]
            tstb
            if ne                 ; if a key is pressed
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
                    ldx #$959E    ; start of string to test
                    do
                        cmpx #$95D5
                    while ne
                        addb ,x+  ; compute checksum
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
