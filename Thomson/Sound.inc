include 'ThomsonTO.inc'

zseg
Dp.Word0:
    defw 0


cseg
Tone:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda CRC             ;5
        ora #$08            ; sound on
        sta CRC             ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        lda CRC             ;5
        anda #$F7           ; sound off
        sta CRC             ;5
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
        ldd <Dp.Word0       ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        ldd <Dp.Word0
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y           ;4+1
    while ne | wend         ;3 [8]
rts


Melody:
    pshs a,b
        ldb #0
        stb TIMBRE
        ldb #16
        stb TEMPO
        ldb ,x+
        stb DUREE
        do
            ldb ,x+       ; octave + note
            tfr b,a
            lsra
            lsra
            lsra
            lsra
            sta OCTAVE
            orb #$30
            jsr NOTE
            ldb ,x+
            stb DUREE
            tstb
        while ne | wend
    puls a,b
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

A3  equ $4a ; la
A3S equ $4b ; la#
B3  equ $4c ; si

C4  equ $21 ; do
C4S equ $22 ; do#
D4  equ $23 ; ré
D4S equ $24 ; re#
E4  equ $25 ; mi
F4  equ $26 ; fa
F4S equ $27 ; fa#
G4  equ $28 ; sol
G4S equ $29 ; sol#
A4  equ $2a ; la
A4S equ $2b ; la#
B4  equ $2c ; si

C5  equ $11 ; do
C5S equ $12 ; do#
D5  equ $13 ; ré
D5S equ $14 ; re#
E5  equ $15 ; mi
F5  equ $16 ; fa
F5S equ $17 ; fa#
G5  equ $18 ; sol
G5S equ $19 ; sol#
A5  equ $1a ; la
A5S equ $1b ; la#
B5  equ $1c ; si

; C1 => OCTAVE 16
; C2 => OCTAVE 8
; C3 => OCTAVE 4
; C4 => OCTAVE 2 (A4 = 440 Hz)
; C5 => OCTAVE 1

N32 equ 1     ; quadruple croche (1)
N16 equ 2     ; triple croche (2)
N8  equ 5     ; double croche (5)
N8P equ 8     ; double croche pointée (8)
N4  equ 11    ; croche (11)
N4P equ 17    ; croche pointée (17)
N2  equ 23    ; noire (23)
N2P equ 35    ; noire pointée (35)
N1  equ 47    ; blanche (47)
