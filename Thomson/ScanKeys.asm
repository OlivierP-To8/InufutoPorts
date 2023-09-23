include 'ThomsonTO.inc'

Keys_Left equ $04
Keys_Right equ $08
Keys_Up equ $01
Keys_Down equ $02
Keys_Dir equ $0f
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
        lda PRB1      ; get trigger data (if bit is 0)
        anda #$40     ; keep b6 for trigger of joystick 0
        if eq         ; if trigger button is pressed
            lda #Keys_Button0
        else
            lda PRA1  ; get direction data (if bit is 0)
            coma      ; value of direction
            anda #$0f ; only for joystick 0
            if eq     ; if no direction
                ldb MODELE ; check the Thomson model
                cmpb #$02
                if eq ; if TO9
                    ldb PRA
                    lsrb
                    if cs ; if a key is pressed
                        ldb SRDR
                    else
                        bra FIN
                    endif
                else
                    ; keyboard test
                    clrb
                    jsr KTST ; 49 cycles
                    if cs ; if a key is pressed (carry set)
                        jsr GETC ; 218 cycles
                        ; code of pressed key in B
                    else
                        bra FIN
                    endif
                endif

                ldx #table
                do
                    lda ,x
                while ne
                    cmpb ,x+
                    if eq
                        lda ,x
                        bra FIN
                    endif
                    leax 1,x
                wend
            endif
        endif
    FIN:
    puls b,x
rts
