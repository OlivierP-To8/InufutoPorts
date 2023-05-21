include '../ThomsonTO.inc'

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
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

joypos:
    defb $07, Keys_Left    ; ←
    defb $03, Keys_Right   ; →
    defb $01, Keys_Up      ; ↑
    defb $05, Keys_Down    ; ↓
    defb 0

ScanKeys_: public ScanKeys_
    pshs b,x

        ; joystick test
        clra ; A=0 => joystick 0
        jsr JOYS ; 191 cycles
        if cs ; if trigger button is pressed (carry set)
            lda #Keys_Button0
        else
            tstb ; B=0 => center of joystick, no direction
            if ne
                ldx #joypos
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
            else
                ldb $FFF0
                cmpb #$01
                if le ; if TO7 or TO7-70
                    ; keyboard test
                    clrb
                    jsr KTST ; 49 cycles
                    if cs ; if a key is pressed (carry set)
                        jsr GETC ; 218 cycles
                        ; code of pressed key in B

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
            endif
        endif
    FIN:
    puls b,x
rts
