include '../Sound.inc'

cseg

Sound_Fire_: public Sound_Fire_
    pshs a,b,y
        ldd #100
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            addd #5
            std <Dp.Word0
            cmpd #300
        while ne | wend
    puls a,b,y
rts


Sound_Hit_: public Sound_Hit_
    pshs a,b,y
        ldd #500
        std <Dp.Word0
        do
            ldy #1
            bsr Tone
            ldd <Dp.Word0
            subd #5
            std <Dp.Word0
            cmpd #300
        while ne | wend
    puls a,b,y
rts


Sound_Loose_: public Sound_Loose_
    pshs a,b,y
        ldd #150
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


up_notes:
    defb 1,C4, 1,C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    pshs x
        ldx #up_notes
        bsr Melody
    puls x
rts


start_notes:
    defb 3,A4, 3,G4, 3,A4, 6,C5, 3,E5, 12,D5, 3,0, 6,C5, 3,C5, 6,D5
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes: 
    defb 3,E4, 3,G4, 3,C5, 3,A4, 3,0, 3,A4, 3,0, 3,G4, 3,0, 3,G4, 3,0, 3,G4, 3,0, 3,G4, 6,A4
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes:
    defb 3,E4, 3,E4, 3,G4, 6,E4, 3,C5, 3,B4, 3,A4, 3,G4, 3,A4, 3,0, 6,A4, 3,G4, 6,A4
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts
