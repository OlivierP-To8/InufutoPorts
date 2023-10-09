INIT0 equ $FF90
INIT1 equ $FF91
VMODE equ $FF98
VRES equ $FF99

ext Direct
cseg
    lds #$8000
    
    lda #high Direct
    tfr a,dp

    inc $FFD9
