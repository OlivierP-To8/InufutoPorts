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


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


start_notes:
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes: 
    defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes:
    defb N8,A4, N8,E5, N8,D5, N8,C5, N8,D5, N8,C5, N8,B4, N4P,A4
    defb N8,0, N4,G4, N8,G4, N4,A4
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts
