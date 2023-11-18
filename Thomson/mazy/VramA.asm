include 'Vram.inc'
include 'VVram.inc'
include '../ThomsonTO.inc'

VramTop equ Vram

ext VVram_
ext PatternRam_
ext ColorRam_
ext BlackScreen_

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


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,b,x,y

        jsr BlackScreen_

        ldx #Backup
        ldy #VVramWidth*VVramHeight
        do
            clr ,x+
            leay -1,y
        while ne | wend

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


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVram_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
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

            dec <yCount
        while ne | wend
    puls a,b,x,y
rts
