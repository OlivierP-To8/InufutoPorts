include '../ThomsonTO.inc'

Keys_Up equ $01
Keys_Down equ $02
Keys_Left equ $04
Keys_Right equ $08
Keys_Button0 equ $10
Keys_Button1 equ $20

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
        lda PRB1                      ; get trigger data
        anda #$40                     ; keep b6 for trigger of joystick 0
        if eq                         ; if trigger button is pressed
            lda #Keys_Button0
        else
            lda PRA1                  ; get direction data (if bit is 0)
            coma                      ; value of direction
            anda #$0f                 ; only for joystick 0
            if eq                     ; if no direction
                jsr KTST              ; fast test if key pressed
                if cs                 ; if a key is pressed (carry set)
                    clrb
                    jsr GETC          ; code of pressed key in B

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

                    ; allow 'A' to 'Z'
                    cmpb #65
                    if ge
                        cmpb #90
                        if le
                            tfr b,a
                        endif
                    endif
                endif
            endif
        endif
    FIN:
    puls b,x
rts
