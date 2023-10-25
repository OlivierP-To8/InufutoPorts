; Thomson Floppy Disk BIN Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include 'Vram.inc'
include '../ThomsonTO.inc'

ext InitVram_, Main_

zseg
Direct: public Direct

cseg
    ; set S (system stack) and DP (direct page) registers to ZSEG value from makefile
    lds #DIRECT

    lda #high Direct
    tfr a,dp

    ; identification du modèle
    ;    00 = T9000,TO7  => bord écran par PRC + modifier la palette en 8c
    ;    01 = TO7-70     => bord écran par PRC
    ;    02 = TO9        => bord écran par LGATOU avec saturation $08
    ;    03 = TO8,TO8D   => bord écran par LGATOU
    ;    06 = TO9+
    ldb MODELE
    cmpb #$03
    if ge
        ; bord noir sur TO8/TO8D/TO9+
        lda #$00   ; XXXXPBVR (pastel bleu vert rouge)
        sta LGATOU ; registre uniquement en écriture
    else
        cmpb #$02
        if eq
            ; bord noir sur TO9
            lda #$08   ; XXXXSBVR (saturation bleu vert rouge)
            sta LGATOU ; registre uniquement en écriture
        else
            ; bord noir sur TO7 et TO7-70
            lda PRC
            anda #$8f ; border color b654=000
            sta PRC

            ; buzzer clavier TO7
            lda #1     ; 0=ON 1=OFF
            sta BUZZ
        endif
    endif

    ; passage au mode TO7 320x200x16c avec conflit de proximite (2 couleurs pour 8 pixels)
    ; la mémoire écran se trouve entre $4000 et $5F3F
    lda #$0
    sta LGAMOD

    ; curseur invisible
    lda STATUS
    anda #$fb
    sta STATUS

    ; commutation du bit de couleur (C0 a 0)
    lda PRC
    anda #$fe
    sta PRC

    ; on efface l'ecran (de $4000 à $5F3F)
    ldx #$4000
    ldy #$C0C0 ; noir sur noir
    do
        sty ,x+
        cmpx #$5F3F
    while ne | wend

    jsr InitVram_
jmp Main_

