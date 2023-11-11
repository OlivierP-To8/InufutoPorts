include 'Vram.inc'
include 'VVram.inc'
include '../ThomsonTO.inc'

VramTop equ Vram

ext VVramFront_, RowFlags_
ext PatternRam_
ext ColorRam_

dseg
Backup:
    defs VVramWidth*VVramHeight

zseg
yCount:
    defb 0
xCount:
    defb 0
pVram:
    defw 0
pFlag:
    defw 0
flagByte:
    defb 0
flagBit:
    defb 0


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,b,x,y

        ; commutation du bit de couleur (C0 a 0)
        lda PRC
        anda #$fe
        sta PRC

        ldx #Vram
        ldy #$C0C0 ; noir sur noir
        do
            sty ,x+
            cmpx #Vram+VramRowSize*VramHeight
        while ne | wend

        ; commutation du bit de forme (C0 a 1)
        lda PRC
        ora #$01
        sta PRC

        ldx #Vram
        do
            clr ,x+
            cmpx #Vram+VramRowSize*VramHeight
        while ne | wend

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend

        bsr ClearFlags

    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y

        lda #PatternSize
        mul

        pshs a,b,x

        ldy #ColorRam_
        leay d,y

        ; commutation du bit de couleur (C0 a 0)
        lda PRC
        anda #$fe
        sta PRC

        ldb #CharHeight
        do
            lda ,y+
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend

        puls a,b,x

        ldy #PatternRam_
        leay d,y

        ; commutation du bit de forme (C0 a 1)
        lda PRC
        ora #$01
        sta PRC

        ldb #CharHeight
        do
            lda ,y+
            sta ,x
            leax VramWidth,x
            decb
        while ne | wend

    puls a,b,x,y
    tfr	x,d
    addd #VramStep
rts


VVramToVramRow:
    lda #VVramWidth | sta <xCount
    do 
        ldb ,x+
        cmpb ,y
        if ne
            stb ,y
            pshs x
                ldx <pVram
                bsr Put_
                std <pVram
            puls x
        else
            ldd <pVram
            addd #VramStep
            std <pVram
        endif
        leay 1,y
        dec <xCount
    while ne | wend
    ldd <pVram
    addd #VramRowSize-VVramWidth*VramStep
    std <pVram
rts

ClearFlags:
    clra
    sta RowFlags_
    sta RowFlags_+1
    sta RowFlags_+2
rts


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
            bsr VVramToVramRow
            dec <yCount
        while ne | wend
        bsr ClearFlags
    puls a,b,x,y
rts


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    pshs a,b,x,y
        ldx #VramTop
        stx <pVram
        
        ldx #RowFlags_
        lda ,x+
        sta <flagByte
        stx <pFlag
        lda #1
        sta <flagBit

        ldx #VVramFront_
        ldy #Backup
        lda #VVramHeight
        sta <yCount
        do
            lda <flagByte
            anda <flagBit
            if ne
                bsr VVramToVramRow
            else
                leax VVramWidth,x
                leay VVramWidth,y
                ldd <pVram
                addd #VramRowSize
                std <pVram
            endif
            lsl <flagBit
            if eq
                pshs x
                    ldx <pFlag
                    lda ,x+
                    sta <flagByte
                    stx <pFlag
                    lda #1
                    sta <flagBit
                puls x
            endif
            dec <yCount
        while ne | wend
        bsr ClearFlags
    puls a,b,x,y
rts
