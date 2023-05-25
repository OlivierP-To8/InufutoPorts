include 'VVram.inc'

zseg 
Dp.Word0:
    defw 0

ext VVramBack_, VVramFront_, RowFlags_

; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pshs x,y
        ldx #VVramBack_
        ldy #VVramWidth*VVramHeight
        do
            clr 0,x
            leax 1,x        
            leay -1,y
        while ne | wend
    puls x,y
rts


; word VVramOffset(byte x, byte y)
cseg
VVramOffset_: public VVramOffset_
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
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
