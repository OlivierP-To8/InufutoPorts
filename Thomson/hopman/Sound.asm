include '../ThomsonTO.inc'

cseg

Melody:
    pshs b
        ldb #0
        stb TIMBRE
        ldb #16
        stb TEMPO
        ldb ,x+
        stb DUREE
        do
            ldb ,x+
            stb OCTAVE
            ldb ,x+
            jsr NOTE
            ldb ,x+
            stb DUREE
            tstb
        while ne | wend
    puls b
rts


P0  equ $30 ; pause
C0  equ $31 ; do
C0S equ $32 ; do#
D0  equ $33 ; ré
D0S equ $34 ; re#
E0  equ $35 ; mi
F0  equ $36 ; fa
F0S equ $37 ; fa#
G0  equ $38 ; sol
G0S equ $39 ; sol#
A0  equ $3a ; la
A0S equ $3b ; la#
B0  equ $3c ; si

; C1 => OCTAVE 16
; C2 => OCTAVE 8
; C3 => OCTAVE 4
; C4 => OCTAVE 2 (A4 = 440 Hz)
; C5 => OCTAVE 1

N8  equ 6       ; double croche (6)
N8P equ N8*3/2  ; double croche pointée (9)
N4  equ N8*2    ; croche (12)
N4P equ N4*3/2  ; croche pointée (18)
N2  equ N4*2    ; noire (24)
N2P equ N2*3/2  ; noire pointée (36)
N1  equ N2*2    ; blanche (48)
N16 equ N8/2    ; triple croche (3)
N32 equ N16/2   ; quadruple croche (1)


loose_notes:
    defb 2,2,C0, 2,2,P0, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
rts


hit_notes:
    defb 1,2,F0, 1,2,G0, 1,2,A0, 1,2,B0, 1,1,C0, 1,1,D0, 1,1,E0, 1,1,F0
    defb 0 
Sound_Hit_: public Sound_Hit_
    pshs x
        ldx #hit_notes
        bsr Melody
    puls x
rts


beep_notes:
    defb 1,2,A0, 1,2,P0, 0
Sound_Beep_: public Sound_Beep_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts


bonus_notes:
    defb 1,2,C0, 1,2,C0S, 1,2,D0, 1,2,F0, 1,2,A0, 1,1,C0, 0
Sound_Bonus_: public Sound_Bonus_
    pshs x
        ldx #bonus_notes
        bsr Melody
    puls x
rts


start_notes:
	defb 11,2,C0, 11,2,E0
	defb 5,2,G0, 11,2,E0, 11,2,F0
	defb 5,2,F0, 11,2,A0, 5,1,C0
	defb 17,2,A0, 31,1,C0
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes: 
	defb 5,2,A0, 5,2,A0, 5,2,G0, 5,2,F0
	defb 5,2,G0, 11,2,A0, 11,2,B0
	defb 5,2,B0, 5,2,A0, 5,2,G0, 5,2,A0
	defb 11,2,B0, 29,1,C0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes:
	defb 5,1,C0, 5,2,F0, 5,2,A0, 5,2,E0
	defb 5,2,G0, 5,2,A0, 5,2,B0, 5,1,C0
	defb 31,1,C0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts
