include '../Sound.inc'

cseg

loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
rts


item_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Item_: public Sound_Item_
    pshs x
        ldx #item_notes
        bsr Melody
    puls x
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
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N1,C5
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes:
    defb N8,C5, N8,C5, N8,G4, N8,G4, N8,A4, N8,A4, N8,B4, N8,B4
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts

