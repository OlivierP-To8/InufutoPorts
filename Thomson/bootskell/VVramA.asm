VVramWidth equ 32;
VVramHeight equ 22;

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


; void SetRowFlags(byte y, byte b);
cseg
SetRowFlags_: public SetRowFlags_
    pshs a,b,x
        stb <Dp.Word0+1
        clr <Dp.Word0
        pshs a
            anda #7
            if ne
                do
                    asl <Dp.Word0+1
                    rol <Dp.Word0
                    deca
                while ne | wend
            endif
        puls a
        lsra | lsra | lsra | anda #3
        ldx #RowFlags_
        leax a,x
        lda 0,x
        ora Dp.Word0+1
        sta 0,x
        lda 1,x
        ora Dp.Word0
        sta 1,x
    puls a,b,x
rts