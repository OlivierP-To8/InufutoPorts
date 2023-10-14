ext WaitTimer_

Port_FM_Command equ $FD15
Port_FM_Data equ $FD16

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10
Psg_EnvTime equ 11
Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 15

Opn_OnOff equ 28h
Opn_Part equ 30h

MaxVol equ 63
tempo equ 220

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels defs unitSize*AllCount
time: defw 0


cseg
WriteSound: public WriteSound ;(a,b)
    pshs a,cc | orcc #$50
        sta Port_FM_Data
        lda #3
        sta Port_FM_Command
        clr Port_FM_Command

        stb Port_FM_Data
        lda #2
        sta Port_FM_Command
        clr Port_FM_Command
    puls a,cc
rts


ReadSound: public ReadSound ; (a):a
    pshs cc | orcc #$50
        sta Port_FM_Data
        lda #3
        sta Port_FM_Command
        clr Port_FM_Command

        lda #9
        sta Port_FM_Command
        lda Port_FM_Data
        clr Port_FM_Command
    puls cc
rts


ReadStatus: ; ():a
    pshs cc | orcc #$50
        lda #4
        sta Port_FM_Command
        lda Port_FM_Data
        clr Port_FM_Command
    puls cc
rts


WaitPort:
    pshs a
        do
            bsr ReadStatus
            bita #$80
        while ne | wend
    puls a
rts


; BassTone:
;     defb 58,48,48,48
;     defb 36,18,45,0
;     defb 31,95,31,95
;     defb 18,10,14,10
;     defb 0,4,4,3
;     defb 38,38,38,38
;     defb 58
; BassTone:
;     defb 96,96,96,96
;     defb 23,23,63,0
;     defb 158,156,152,156
;     defb 14,4,10,5
;     defb 8,9,9,9
;     defb 182,198,198,198
;     defb 48
BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
PianoTone:
    defb 15,82,50,2
    defb 65,27,0,0
    defb 94,94,94,158
    defb 15,8,7,8
    defb 5,5,5,5
    defb 143,143,143,143
    defb 60
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60

SetTone: ; (a,x)
    ldb #24
    do
        pshs b
            bsr WaitPort
            ldb ,x+
            bsr WriteSound
            adda #4
        puls b
        decb
    while ne | wend
    adda #$20
    ldb ,x+
    bsr WriteSound
rts


cseg
InitSound_: public InitSound_
    jsr $EBE5
    pshs a,b,x
        pshs cc | orcc #$50
            ldx #Channels
            ldb #AllCount
            clra
            do
                sta Channel_Ptr,x
                sta Channel_Ptr+1,x
                leax unitSize,x
                decb
            while ne | wend
            ldx #0
            stx time
        puls cc

        ldd #(Psg_Mixer shl 8) or $b8
        bsr WriteSound

        ldx #BassTone
        lda #Opn_Part
        bsr SetTone

        ldx #PianoTone
        lda #Opn_Part+1
        bsr SetTone

        ldx #SnareTone
        lda #Opn_Part+2
        bsr SetTone

        ldd #OpnCount shl 8
        do
            pshs a
                bsr WaitPort
                lda #Opn_OnOff
                bsr WriteSound
                incb
            puls a
            deca
        while ne | wend
    puls a,b,x
rts


ToneOn:
; in
;   d : cycle
    pshs a,b
        pshs a
            lda #Psg_ToneA
            bsr WriteSound
        puls a
        tfr a,b
        lda #Psg_ToneA+1
        bsr WriteSound

        ldd #(Psg_VolumeA shl 8) or 15
        bsr WriteSound
    puls a,b
rts


ToneOff:
    pshs a,b
        pshs b
            lda #Psg_ToneA
            bsr WriteSound
        puls b
        tfr a,b
        lda #Psg_ToneA+1
        bsr WriteSound

        ldd #Psg_VolumeA shl 8
        bsr WriteSound
    puls a,b
rts


Sound_Beep_: public Sound_Beep_
    pshs a
        ldd #174
        bsr ToneOn
        pshs a
            lda #2
            jsr WaitTimer_
        puls a
        bsr ToneOff
    puls a
rts


Sound_Get_: public Sound_Get_
    pshs a
        ldd #174
        bsr ToneOn
        pshs a
            lda #5
            jsr WaitTimer_
        puls a
        bsr ToneOff
    puls a
rts


Sound_Hit_: public Sound_Hit_
    pshs a,b
        ldd #300
        do
            bsr ToneOn
            pshs a
                lda #1
                jsr WaitTimer_
            puls a
            subd #5
            cmpd #150
        while cc | wend
        bsr ToneOff
    puls a,b
rts


Sound_Miss_: public Sound_Miss_
    pshs a,b
        ldd #150
        do
            bsr ToneOn
            pshs a
                lda #1
                jsr WaitTimer_
            puls a
            addd #5
            cmpd #300
        while cs | wend
        bsr ToneOff
    puls a,b
rts


Sound_Loose_: public Sound_Loose_
    pshs a,b
        ldd #1000
        bsr ToneOn
        pshs a
            lda #5
            jsr WaitTimer_
        puls a
        bsr ToneOff
    puls a,b
rts


zseg
SoundHandler_channel:
    defb 0

cseg
SoundHandler: public SoundHandler
    pshs a,b,x,y
        ldd time
        subd #tempo
        if cs
            pshs a,b
                ldx #Channels
                clr <SoundHandler_channel
                do
                    ldy Channel_Ptr,x
                    if ne
                        dec Channel_Len,x
                        if eq
                            continue:
                            lda ,y+
                            if eq
                                ; end
                                ldy #0
                                sty Channel_Ptr,x

                                lda <SoundHandler_channel
                                adda #Psg_VolumeA
                                clrb
                                bsr WriteSound
                                bra next
                            endif
                            cmpa #$ff
                            if eq 
                                ; repeat
                                ldy Channel_Start,x
                                bra continue
                            endif
                            sta Channel_Len,x
                            lda ,y+
                            sty Channel_Ptr,x
                            tsta
                            if ne
                                deca
                                lsla
                                ldy #cycles
                                leay a,y
                                
                                lda <SoundHandler_channel
                                lsla
                                adda #Psg_ToneA
                                ldb 1,y
                                bsr WriteSound
                                inca
                                ldb ,y
                                bsr WriteSound
                                ldb #MaxVol
                            else
                                rest:
                                clrb
                            endif
                            EndWriteCycle:
                            stb Channel_Vol,x
                        endif
                        lda <SoundHandler_channel
                        adda #Psg_VolumeA
                        ldb Channel_Vol,x
                        pshs b
                            lsrb | lsrb
                            bsr WriteSound
                        puls b
                        tstb
                        if ne
                            decb
                            stb Channel_Vol,x
                        endif
                    endif
                    next:
                    leax unitSize,x
                    ldb <SoundHandler_channel
                    incb
                    stb <SoundHandler_channel
                    cmpb #PsgCount
                while ne | wend
                clr <SoundHandler_channel
                do
                    ldy Channel_Ptr,x
                    if ne
                        dec Channel_Len,x
                        if eq
                            lda Channel_Vol,x
                            if ne
                                bsr WaitPort
                                lda #Opn_OnOff
                                ldb <SoundHandler_channel
                                bsr WriteSound
                                clr Channel_Vol,x
                            endif
                            continue2:
                            lda ,y
                            if eq
                                ; end
                                clr Channel_Ptr,x
                                clr Channel_Ptr+1,x
                                bra next2
                            endif
                            inca
                            if eq
                                ; repeat
                                ldy Channel_Start,x
                                bra continue2
                            endif
                            deca
                            sta Channel_Len,x
                            leay 1,y
                            lda ,y+
                            sty Channel_Ptr,x
                            tsta
                            if ne
                                deca
                                lsla
                                ldy #OpnScales
                                leay a,y
                                bsr WaitPort
                                
                                lda <SoundHandler_channel
                                adda #$a4
                                ldb ,y+
                                bsr WriteSound

                                lda <SoundHandler_channel
                                adda #$a0
                                ldb ,y
                                bsr WriteSound

                                bsr WaitPort
                                lda #Opn_OnOff
                                ldb <SoundHandler_channel
                                orb #$f0
                                bsr WriteSound

                                lda #$ff | sta Channel_Vol,x
                            endif
                        endif
                    endif
                    next2:
                    leax unitSize,x
                    ldb <SoundHandler_channel
                    incb
                    stb <SoundHandler_channel
                    cmpb #OpnCount
                while ne | wend
            puls a,b
            addd #500
        endif
        std time
    puls a,b,x,y
rts


Melody0:
    pshs cc,a,b | orcc #$50
        stx Channels+Channel_Ptr
        lda #1
        sta Channels+Channel_Len
    puls cc,a,b
rts

MelodyWait0:
    bsr Melody0
    do
        ldx Channels+Channel_Ptr
    while ne | wend
rts


Melody4:
    pshs cc,a,b | orcc #$50
        stx Channels+unitSize*4+Channel_Ptr
        lda #1
        sta Channels+unitSize*4+Channel_Len
    puls cc,a,b
rts

MelodyWait4:
    bsr Melody4
    do
        ldx Channels+unitSize*4+Channel_Ptr
    while ne | wend
rts

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2


start_notes: defb 3,C4, 3,G4, 3,E4, 3,G4, 12,C5, 0
Sound_Start_: public Sound_Start_
    pshs a,x
        ldx #start_notes
        bsr MelodyWait4
    puls a,x
rts

clear_notes: defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Sound_Clear_: public Sound_Clear_
    pshs a,x
        ldx #clear_notes
        bsr MelodyWait4
    puls a,x
rts


over_notes: defb 3,C5, 3,G4, 3,E4, 3,C5,  3,B4, 3,G4, 3,E4, 3,B4,  6,A4, 6,B4,  12,C5, 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,x
        ldx #over_notes
        bsr MelodyWait4
    puls a,x
rts


BGM_B:
    defb 3,D4, 3,F4, 3,G4
    defb 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4
    defb 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,A4, 3,G4
    defb 12,F4, 12,G4, 18,A4
    defb 3,D4, 3,F4, 3,G4
    defb 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4
    defb 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,A4, 3,G4
    defb 12,F4, 12,G4, 18,F4
    defb $ff
BGM_C: 
    defb 9,0
    defb 9,F3, 9,F3, 6,F3
    defb 9,C4, 9,C4, 6,C4
    defb 12,F3, 12,G3, 27,A3
    defb 9,A3, 9,A3, 6,A3
    defb 9,G3, 9,G3, 6,G3
    defb 12,F3, 12,C4, 18,F3
    defb $ff
; BGM_D:
;     defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
;     defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
;     defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
;     defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
;     defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4

;     defb N8,0, N8,A4, N8,0, N8,A4, N8,0, N8,A4, N8,0, N8,A4
;     defb N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4

;     defb $ff


StartBGM_: public StartBGM_
    pshs a,x,cc | orcc #$50
        lda #1
        ldx #BGM_B
        stx Channels+unitSize*4+Channel_Start
        stx Channels+unitSize*4+Channel_Ptr
        sta Channels+unitSize*4+Channel_Len
        ldx #BGM_C
        stx Channels+unitSize*3+Channel_Start
        stx Channels+unitSize*3+Channel_Ptr
        sta Channels+unitSize*3+Channel_Len
        ; ldx #BGM_D
        ; stx Channels+unitSize*5+Channel_Start
        ; stx Channels+unitSize*5+Channel_Ptr
        ; sta Channels+unitSize*5+Channel_Len
    puls a,x,cc
rts

StopBGM_: public StopBGM_
    pshs a,b,x,cc | orcc #$50
        ldx #0
        stx Channels+unitSize*4+Channel_Ptr
        stx Channels+unitSize*3+Channel_Ptr
        stx Channels+unitSize*5+Channel_Ptr
        lda #1
        sta Channels+unitSize*4+Channel_Len
        sta Channels+unitSize*3+Channel_Len
        sta Channels+unitSize*5+Channel_Len

        ldd #(Psg_VolumeB shl 8) or 2
        do
            pshs b,a
                clrb
                bsr WriteSound
            puls b,a
            inca
            decb
        while ne | wend
        ldd #(Psg_Mixer shl 8) or $b8
        bsr WriteSound

        lda #Opn_OnOff
        clr
        do
            bsr WaitPort
            bsr WriteSound
            incb
            cmpb #OpnCount
        while ne | wend
    puls a,b,x,cc
rts


E3 equ 1
F3 equ 2
F3S equ 3
G3 equ 4
G3S equ 5
A3 equ 6
A3S equ 7
B3 equ 8
C4 equ 9
C4S equ 10
D4 equ 11
D4S equ 12
E4 equ 13
F4 equ 14
F4S equ 15
G4 equ 16
G4S equ 17
A4 equ 18
A4S equ 19
B4 equ 20
C5 equ 21
C5S equ 22
D5 equ 23
D5S equ 24
E5 equ 25
F5 equ 26

cycles:
defw 465 ; E3
defw 439 ; F3
defw 415 ; F#3
defw 391 ; G3
defw 369 ; G#3
defw 349 ; A3
defw 329 ; A#3
defw 311 ; B3
defw 293 ; C4
defw 277 ; C#4
defw 261 ; D4
defw 246 ; D#4
defw 232 ; E4
defw 219 ; F4
defw 207 ; F#4
defw 195 ; G4
defw 184 ; G#4
defw 174 ; A4
defw 164 ; A#4
defw 155 ; B4
defw 146 ; C5
defw 138 ; C#5
defw 130 ; D5
defw 123 ; D#5
defw 116 ; E5
defw 109 ; F5

OpnScales:
defb 20,242 ; E3
defb 21,61 ; F3
defb 21,141 ; F#3
defb 21,225 ; G3
defb 22,59 ; G#3
defb 22,154 ; A3
defb 22,254 ; A#3
defb 23,105 ; B3
defb 27,237 ; C4
defb 28,40 ; C#4
defb 28,104 ; D4
defb 28,171 ; D#4
defb 28,242 ; E4
defb 29,61 ; F4
defb 29,141 ; F#4
defb 29,225 ; G4
defb 30,59 ; G#4
defb 30,154 ; A4
defb 30,254 ; A#4
defb 31,105 ; B4
defb 35,237 ; C5
defb 36,40 ; C#5
defb 36,104 ; D5
defb 36,171 ; D#5
defb 36,242 ; E5
defb 37,61 ; F5
defb 37,141 ; F#5
defb 37,225 ; G5
