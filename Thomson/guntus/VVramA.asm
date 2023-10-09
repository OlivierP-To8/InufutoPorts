include 'VVram.inc'

zseg 
Dp.Word0:
    defw 0

dseg
VVram_: public VVram_
    defs VVramWidth*VVramHeight
RowFlags_: public RowFlags_
    defs 4


; void ClearVVram();
cseg
ClearVVram_: public ClearVVram_
    pshs x,y
        ldx #VVram_
        do
            clr ,x+
            cmpx #VVram_+VVramWidth*VVramHeight
        while ne | wend
    puls x,y
rts


; word VVramPtr(byte x, byte y)
cseg
VVramPtr_: public VVramPtr_
    lsla
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
    addd #VVram_
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
