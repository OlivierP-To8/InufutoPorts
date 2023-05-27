MaxVolume equ $fc
VolumeStep equ $04*3
SoundPort equ $ff20

zseg 
Dp.Word0:
    defw 0

cseg

tempo equ 220

dseg
SoundProc_: public SoundProc_
    defw 0
Volume:
    defb 0

cseg

InitSound_: public InitSound_
    pshs x
        ldx #0
        stx SoundProc_
    puls x
rts


CallSound_: public CallSound_
    pshs x
        ldx SoundProc_
        if ne
            jsr ,x
        endif
        ldx #0
        stx SoundProc_
    puls x
rts


cseg
Tone:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda Volume          ;5
        sta SoundPort      ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        clr SoundPort
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y           ;4+1
    while ne | wend         ;3 [8]
rts


Rest:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda #MaxVolume        ;2
        ldd <Dp.Word0       ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        ; lda #OffByte
        ldd <Dp.Word0
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y           ;4+1
    while ne | wend         ;3 [8]
rts


Sound_Get_:
    public Sound_Get_
    pshs a,b,y
        ldd #140
        std <Dp.Word0
        ldy #20
        bsr Tone
    puls a,b,y
rts


Sound_Hit_:
    public Sound_Hit_
    pshs a,b,y
        ldd #300
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            subd #1
            std <Dp.Word0
            cmpd #200
        while ne | wend
    puls a,b,y
rts


Sound_Miss_:
    public Sound_Miss_
    pshs a,b,y
        ldd #200
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            addd #1
            std <Dp.Word0
            cmpd #300
        while ne | wend
    puls a,b,y
rts


Sound_Loose_:
    public Sound_Loose_
    pshs a,b,y
        ldd #600
        std <Dp.Word0
        ldy #10
        bsr Tone
    puls a,b,y
rts


Melody:
    pshs cc
        orcc #$60
        do
            ldb ,x+
        while ne
            lda ,x+
            if ne
                pshs b
                    ldy #cycles
                    deca
                    asla
                    asla
                    leay a,y
                    ldb #MaxVolume | stb Volume
                    ldd ,y++
                    std <Dp.Word0
                    ldy ,y
                puls b
                do
                    pshs b,y
                        bsr Tone
                        ldb Volume
                        if ne
                            subb #VolumeStep
                            if cs
                                clrb
                            endif
                            stb Volume
                        endif
                    puls b,y
                    decb
                while ne | wend
            else
                pshs b
                    ldd cycles
                    std <Dp.Word0
                    ldy cycles+2
                puls b
                do
                    pshs b,y
                        bsr Rest
                    puls b,y
                    decb
                while ne | wend
            endif
        wend
    puls cc
rts

C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N1 equ N2*2
N16 equ N8/2


start_notes: defb 3,C4, 3,G4, 3,E4, 3,G4, 12,C5, 0
Sound_Start_: 
    public Sound_Start_
    pshs a,b,x,y
        ldx #start_notes
        bsr Melody
    puls a,b,x,y
rts


clear_notes: defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Sound_Clear_:
    public Sound_Clear_
    pshs a,b,x,y
        ldx #clear_notes
        bsr Melody
    puls a,b,x,y
rts


over_notes: defb 3,C5, 3,G4, 3,E4, 3,C5,  3,B4, 3,G4, 3,E4, 3,B4,  6,A4, 6,B4,  12,C5, 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,b,x,y
        ldx #over_notes
        bsr Melody
    puls a,b,x,y
rts


cycles: public cycles
defw 241,(8900000/tempo)/(3398+8) ; C4
defw 227,(8900000/tempo)/(3202+8) ; C4S
defw 214,(8900000/tempo)/(3020+8) ; D4
defw 202,(8900000/tempo)/(2852+8) ; D4S
defw 191,(8900000/tempo)/(2698+8) ; E4
defw 180,(8900000/tempo)/(2544+8) ; F4
defw 170,(8900000/tempo)/(2404+8) ; F4S
defw 160,(8900000/tempo)/(2264+8) ; G4
defw 151,(8900000/tempo)/(2138+8) ; G4S
defw 142,(8900000/tempo)/(2012+8) ; A4
defw 134,(8900000/tempo)/(1900+8) ; A4S
defw 127,(8900000/tempo)/(1802+8) ; B4
defw 119,(8900000/tempo)/(1690+8) ; C5
defw 112,(8900000/tempo)/(1592+8) ; C5S
defw 106,(8900000/tempo)/(1508+8) ; D5
defw 100,(8900000/tempo)/(1424+8) ; D5S
defw 94,(8900000/tempo)/(1340+8) ; E5
defw 89,(8900000/tempo)/(1270+8) ; F5
