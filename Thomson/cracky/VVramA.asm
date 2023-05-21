include "VVram.inc"

ext VVramBack_,VVramFront_,RowFlags_

ext @Temp@Word


; ptr<byte> VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #VVramWidth
    mul
    addd <@Temp@Word
rts


; void ClearVVramBack();
cseg
ClearVVramBack_: public ClearVVramBack_
    pshs x
        ldx #VVramBack_
        do
            clr ,x+
            cmpx #VVramBack_+VVramWidth*VVramHeight
        while ne | wend
    puls x
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
    puls a,x,y
rts


; void SetRowFlags(byte y, byte b);
zseg
SetRowFlags_low:
    defb 0
SetRowFlags_high:
    defb 0
cseg
SetRowFlags_: public SetRowFlags_
    pshs a,b,x,y
        stb <SetRowFlags_low
        clr <SetRowFlags_high
        tfr a,b
        andb #7
        if ne
            do
                asl <SetRowFlags_low | rol <SetRowFlags_high
                decb
            while ne | wend
        endif
        
        lsra | lsra | lsra
        ldx #RowFlags_
        leax a,x

        lda ,x
        ora <SetRowFlags_low
        sta ,x+
        lda ,x
        ora <SetRowFlags_high
        sta ,x
    puls a,b,x,y
rts


; void ClearRowFlags();
ClearRowFlags_: public ClearRowFlags_
    pshs x
        ldx #RowFlags_
        do
            clr ,x+
            cmpx #RowFlags_+4
        while ne | wend
    puls x
rts
