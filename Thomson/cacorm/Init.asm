include 'Vram.inc'
include '../ThomsonTO.inc'

ext InitVram_, InitSound_

dseg
TimerCount: 
    defb 0 public TimerCount

zseg
Direct: public Direct

cseg
Init_: public  Init_
    ; identification du modèle
    ;    00 = T9000,TO7  => bord écran par PRC + modifier la palette en 8c
    ;    01 = TO7-70     => bord écran par PRC
    ;    02 = TO9        => bord écran par LGATOU avec saturation $08
    ;    03 = TO8,TO8D   => bord écran par LGATOU
    ;    06 = TO9+
    ldb $FFF0
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

    ; commutation du bit de couleur (C0 a 0)
    lda PRC
    anda #$fe
    sta PRC

    ; on efface le haut de l'ecran (de $4000 à Vram)
    ; car on affiche 256x192 centré dans 320x200
    ldx #$4000
    ldy #$C0C0 ; noir sur noir
    do
        sty ,x+
        cmpx #Vram
    while ne | wend

    ; on efface le bas de l'ecran (jusque $5F3F)
    ; car on affiche 256x192 centré dans 320x200
    ldx #Vram+VramRowSize*VramHeight
    ldy #$C0C0 ; noir sur noir
    do
        sty ,x+
        cmpx #$5F3F
    while ne | wend

    ; mise en place de l'interruption pour le timer d'une seconde
    orcc #$50 ; disables IRQ & FIRQ
        clr TimerCount

        ; intervalle du timer pour une seconde
        ldd #5216
        std TMSB
        lda #$46
        sta TCR

        ; mise en place de la routine
        ldd #Handler
        std TIMEPT

        ; IRQ timer validée par bit 5 du registre STATUS à 1
        lda STATUS
        ora #$20
        sta STATUS
    andcc #not $50 ; enables IRQ & FIRQ

    jsr InitVram_
    jsr InitSound_
rts


Handler:
    inc TimerCount
jmp KBIN ; validation de l'interruption


dseg
WaitTimer_param:
    defb 0
cseg
WaitTimer_: public WaitTimer_
    sta WaitTimer_param
        do
            lda TimerCount
            cmpa WaitTimer_param
        while cs | wend
    lda WaitTimer_param
    orcc #$50
        clr TimerCount
    andcc #not $50
rts
