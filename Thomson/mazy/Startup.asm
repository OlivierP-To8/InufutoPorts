include 'Vram.inc'
include '../ThomsonTO.inc'

ext InitVram_, Main_

dseg
TimerCount: 
    defb 0 public TimerCount

zseg
Direct: public Direct

cseg
    ; set S (system stack) and DP (direct page) registers to ZSEG value from makefile
    lds #DIRECT

    lda #high Direct
    tfr a,dp

    ; mise en place de l'interruption pour le timer d'une seconde
    orcc #$50 ; disables IRQ & FIRQ
        clr TimerCount

        ; intervalle du timer pour une seconde
        ldd #2100
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
jmp Main_


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
