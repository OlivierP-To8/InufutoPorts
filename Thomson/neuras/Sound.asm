include '../Sound.inc'

cseg

Sound_Get_: public Sound_Get_
    pshs a,b,y
        ldd #140
        std <Dp.Word0
        ldy #20
        bsr Tone
    puls a,b,y
rts


Sound_Hit_: public Sound_Hit_
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


Sound_Miss_: public Sound_Miss_
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


Sound_Loose_: public Sound_Loose_
    pshs a,b,y
        ldd #600
        std <Dp.Word0
        ldy #10
        bsr Tone
    puls a,b,y
rts


start_notes:
    defb 3,C4, 3,G4, 3,E4, 3,G4, 12,C5, 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes:
    defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes:
    defb 3,C5, 3,G4, 3,E4, 3,C5, 3,B4, 3,G4, 3,E4, 3,B4, 6,A4, 6,B4, 12,C5, 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts
