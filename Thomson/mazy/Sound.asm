include '../Sound.inc'

cseg

beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


Sound_Get_: public Sound_Get_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5, 0
Sound_Hit_: public Sound_Hit_
    pshs x
        ldx #hit_notes
        bsr Melody
    puls x
rts


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
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
