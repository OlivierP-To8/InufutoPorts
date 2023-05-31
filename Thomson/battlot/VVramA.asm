VVramWidth equ 32;
VVramHeight equ 22;

ext VVramBack_, VVramFront_, RowFlags_

zseg
pVVram:
    defw 0

cseg
; void ClearVVram();
ClearVVram_: public ClearVVram_
    ldx #VVramBack_
    ldy #VVramWidth*VVramHeight
    do
        clr 0,x
        leax 1,x        
        leay -1,y
    while ne | wend
rts


; word VVramOffset(byte x, byte y)
VVramOffset_: public VVramOffset_
    sta <pVVram+1
    clr <pVVram
    lda #VVramWidth
    mul
    addd <pVVram
rts


; void VVramBackToFront()
cseg
VVramBackToFront_: public VVramBackToFront_
    pshs a,x,y
        ldx #VVramBack_
        ldy #VVramFront_
        do
            lda ,x+
            sta ,y+
            cmpx #VVramBack_+VVramWidth*VVramHeight
        while ne | wend
        clr RowFlags_
        clr RowFlags_+1
        clr RowFlags_+2
    puls a,x,y
rts
