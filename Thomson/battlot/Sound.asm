include '../ThomsonTO.inc'

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


fire_notes:
    defb 1,1,F0, 1,1,D0S, 1,1,C0S, 1,2,B0, 1,2,A0, 1,1,G0, 0
Sound_Fire_: public Sound_Fire_
    pshs a,b,x,y
        ldx #fire_notes
        bsr Melody
    puls a,b,x,y
rts


hit_notes:
    defb 1,2,F0, 1,2,G0, 1,2,A0, 1,2,B0, 1,1,C0, 1,1,D0, 1,1,E0, 1,1,F0
    defb 0
Sound_Hit_:  public Sound_Hit_
    pshs a,b,x,y
        ldx #hit_notes
        bsr Melody
    puls a,b,x,y
rts


loose_notes:
    defb 1,1,F0, 1,1,E0, 1,1,D0, 1,1,C0, 1,2,B0, 1,2,A0, 1,2,G0, 1,2,F0, 0
Sound_Loose_: public Sound_Loose_
    pshs a,b,x,y
        ldx #loose_notes
        bsr Melody
    puls a,b,x,y
rts


Melody:
    pshs cc
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
    puls cc
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

N8  equ 6       ; double croche
N8P equ N8*3/2  ; double croche pointée
N4  equ N8*2    ; croche
N4P equ N4*3/2  ; croche pointée
N2  equ N4*2    ; noire
N2P equ N2*3/2  ; noire pointée
N1  equ N2*2    ; blanche
N16 equ N8/2


beep_notes:
    defb 1,2,A0, 1,2,P0, 0
Sound_Beep_: public Sound_Beep_
    pshs a,b,x,y
        ldx #beep_notes
        bsr Melody
    puls a,b,x,y
rts


start_notes:
    defb 11,2,A0, 11,2,A0
	defb 5,2,A0, 11,1,C0, 5,1,D0
	defb 23,1,E0
	defb 12,2,P0, 12,2,P0
    defb 0
Sound_Start_: 
    public Sound_Start_
    pshs a,b,x,y
        ldx #start_notes
        bsr Melody
    puls a,b,x,y
rts


clear_notes: 
    defb 5,2,A0, 6,2,P0, 5,2,A0, 5,2,G0
	defb 5,2,A0, 11,1,C0, 5,1,D0
	defb 6,2,P0, 5,1,C0, 6,2,P0, 17,2,A0
	defb 24,2,P0
    defb 0
Sound_Clear_:
    public Sound_Clear_
    pshs a,b,x,y
        ldx #clear_notes
        bsr Melody
    puls a,b,x,y
rts


over_notes:
	defb 5,2,A0, 5,1,E0, 5,1,D0, 5,1,C0
	defb 5,1,D0, 5,1,C0, 5,2,B0, 17,2,A0
	defb 6,2,P0, 11,2,G0, 5,2,G0
	defb 11,2,A0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,b,x,y
        ldx #over_notes
        bsr Melody
    puls a,b,x,y
rts

