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
    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,D5, N8,C5
    defb N8P,D5, N16,D5, N8,D5, N8,E5, N4,D5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


over_notes:
    defb N8,F5, N8,F5, N8,E5, N8,E5, N8,D5, N8,D5, N8,C5, N8,C5
    defb N8,B4, N8,G4, N8,A4, N8,B4, N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts
