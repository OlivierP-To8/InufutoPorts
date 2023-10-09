MaxVolume equ $fc
VolumeStep equ $04*3
SoundPort equ $ff20

zseg 
Dp.Word0:
    defw 0

cseg

tempo equ 200*2

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


Sound_Fire_: public Sound_Fire_
    pshs a,b,y
        lda #MaxVolume | sta Volume
        ldd #100*2
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            addd #5*2
            std <Dp.Word0
            cmpd #300*2
        while ne | wend
    puls a,b,y
rts


Sound_Hit:
    pshs a,b,y
        lda #MaxVolume | sta Volume
        ldd #500*2
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            subd #5*2
            std <Dp.Word0
            cmpd #300*2
        while ne | wend
    puls a,b,y
rts

Sound_Hit_:  public Sound_Hit_
    pshs x
        ldx #Sound_Hit
        stx SoundProc_
    puls x
rts


Sound_Loose:
    pshs a,b,y
        lda #MaxVolume | sta Volume
        ldd #150*2
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            addd #1*2
            std <Dp.Word0
            cmpd #300*2
        while ne | wend
    puls a,b,y
rts

Sound_Loose_:  public Sound_Loose_
    pshs x
        ldx #Sound_Loose
        stx SoundProc_
    puls x
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


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
    pshs a,b,x,y
        ldx #up_notes
        bsr Melody
    puls a,b,x,y
rts
Sound_Up_:  public Sound_Up_
    pshs x
        ldx #Sound_Up
        stx SoundProc_
    puls x
rts


start_notes:
	defb 5,A4,1,0, 11,B4,1,0, 11,C5,1,0
	defb 11,C5,1,0, 5,A4,1,0, 11,D5,1,0
	defb 11,D5,1,0, 5,C5,1,0, 17,D5,1,0
	defb 35,E5,1,0
	defb 12,0
    defb 0
Sound_Start_: 
    public Sound_Start_
    pshs a,b,x,y
        ldx #start_notes
        bsr Melody
    puls a,b,x,y
rts


over_notes:
	defb 11,A4,1,0, 5,E4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 5,F4,1,0, 5,E4,1,0, 5,D4,1,0
	defb 35,E4,1,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,b,x,y
        ldx #over_notes
        bsr Melody
    puls a,b,x,y
rts


cycles: public cycles
defw 482,(8900000/tempo)/(6772+8)*2 ; C4
defw 455,(8900000/tempo)/(6394+8)*2 ; C4S
defw 429,(8900000/tempo)/(6030+8)*2 ; D4
defw 405,(8900000/tempo)/(5694+8)*2 ; D4S
defw 382,(8900000/tempo)/(5372+8)*2 ; E4
defw 360,(8900000/tempo)/(5064+8)*2 ; F4
defw 340,(8900000/tempo)/(4784+8)*2 ; F4S
defw 320,(8900000/tempo)/(4504+8)*2 ; G4
defw 302,(8900000/tempo)/(4252+8)*2 ; G4S
defw 285,(8900000/tempo)/(4014+8)*2 ; A4
defw 269,(8900000/tempo)/(3790+8)*2 ; A4S
defw 254,(8900000/tempo)/(3580+8)*2 ; B4
defw 239,(8900000/tempo)/(3370+8)*2 ; C5
defw 225,(8900000/tempo)/(3174+8)*2 ; C5S
defw 213,(8900000/tempo)/(3006+8)*2 ; D5
defw 200,(8900000/tempo)/(2824+8)*2 ; D5S
defw 189,(8900000/tempo)/(2670+8)*2 ; E5
defw 178,(8900000/tempo)/(2516+8)*2 ; F5
