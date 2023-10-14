include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext AsciiPattern, ColorPattern

VramTop equ Vram+VramRowSize*0
MMR_Vram equ $fd80+(Vram shr 12)

Backup:
    defs VVramWidth*VVramHeight

zseg
yCount:
    defb 0
xCount:
    defb 0
pVram:
    defw 0


; void InitPalette();
dseg
bvalue:
    defb 0
rvalue:
    defb 0
gvalue:
    defb 0
cseg
InitPalette_: public InitPalette_
    pshs a,b,x
        ldd #0
        do
            std $fd30
            tfr d,x
                bita #$08
                if ne
                    lda #$0f
                else
                    clra
                endif
                sta $fd34

                bitb #$80
                if ne
                    lda #$0f
                else
                    clra
                endif
                sta $fd33

                bitb #$08
                if ne
                    lda #$0f
                else
                    clra
                endif
                sta $fd32
            tfr x,d
            addd #1
            cmpd #$1000
        while ne | wend
    puls a,b,x
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pshs a,b,x,y
        clrb
        do
            stb $f430
            lda #$10
            do
                sta MMR_Vram
                ldx #Vram
                do
                    clr ,x+
                    cmpx #Vram+$1000
                while ne | wend
                inca
                cmpa #$1c
            while cs | wend
            addb #$20
            cmpb #$40
        while ne | wend
        clr $f430

        ldx #Backup
        ldy #VVramWidth*VVramHeight
        do
            clr ,x+
            leay -1,y
        while ne | wend
    puls a,b,x,y
rts


Put:
    lda #$10
    do
        sta MMR_Vram
        inca
        sta MMR_Vram+1
        adda #3
        pshs a
            ldb #CharHeight
            do
                lda ,y+ | sta ,x
                leax VramWidth,x
                decb
            while ne | wend
            leax -VramWidth*CharHeight,x
        puls a
        cmpa #$1c
    while cs | wend
rts

; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs x,y
        lda #PatternSize
        mul
        addd #ColorPattern
        tfr d,y
        bsr Put
    puls x,y
    tfr x,d
    addd #1
rts


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pshs a,b,x,y
        ldx #VramTop | stx <pVram
        ldx #VVram_
        ldy #Backup
        lda #VVramHeight | sta <yCount
        do
            lda #VVramWidth
            sta <xCount
            do 
                ldb ,x+
                cmpb ,y
                if ne
                    stb ,y
                    pshs x,y
                        lda #PatternSize
                        mul
                        addd #ColorPattern
                        tfr d,y
                        ldx <pVram
                        bsr Put
                    puls x,y
                endif
                leay 1,y
                pshs x
                    ldx <pVram
                    leax 1,x
                    stx <pVram
                puls x
                dec <xCount
            while ne | wend
            pshs x
                ldx <pVram
                leax VramRowSize-VVramWidth,x
                stx <pVram
            puls x
            dec <yCount
        while ne | wend
    puls a,b,x,y
rts


; word PrintC(word vram, byte c);
cseg
PrintC_: public PrintC_
    pshs x,y
        subb #$20
        lda #CharHeight
        mul
        addd #AsciiPattern
        tfr d,y

        lda #$10
        do
            sta MMR_Vram
            inca
            sta MMR_Vram+1
            adda #3
            pshs a
                ldb #CharHeight
                do
                    lda ,y+ | sta ,x
                    leax VramWidth,x
                    decb
                while ne | wend
                leax -VramWidth*CharHeight,x
                leay -CharHeight,y
            puls a
            cmpa #$1c
        while cs | wend
    puls x,y
    tfr x,d
    addd #1
rts
