include 'Vram.inc'
include 'VVram.inc'

INIT1 equ $FF91
VramTop equ Vram+VramRowSize*2

ext VVram_
ext PatternRam_

dseg
Backup:
    defs VVramWidth*VVramHeight

zseg
yCount:
    defb 0
xCount:
    defb 0
bitCount:
    defb 0
pattern:
    defb 0
pVram:
    defw 0


; void MakePatternMono(byte c, ptr<byte> pSource, byte count, byte color);
dseg
MakePatternMono_@Param2: public MakePatternMono_@Param2
    defb 0 ; count
MakePatternMono_@Param3: public MakePatternMono_@Param3
    defb 0 ; color

cseg
MakePatternMono_: public MakePatternMono_
    pshs a,b,x,y
        ldb #PatternSize
        mul
        addd #PatternRam_
        tfr d,x

        do
            lda #CharHeight | sta <yCount
            do
                ldb ,y+
                lda #VramStep | sta <xCount
                do
                    clr <pattern
                    lda #2 | sta <bitCount
                    do
                        lda <pattern
                        lsla | lsla | lsla | lsla
                        sta <pattern

                        lda MakePatternMono_@Param3 ; color
                        bitb #$80
                        if ne
                            lda MakePatternMono_@Param3 ; color
                            anda #$0f
                        else
                            lsra | lsra | lsra | lsra
                        endif
                        ora <pattern
                        sta <pattern

                        lslb
                        dec <bitCount
                    while ne | wend
                    lda <pattern | sta ,x+
                    dec <xCount
                while ne | wend
                dec <yCount
            while ne | wend
            dec MakePatternMono_@Param2 ; count
        while ne | wend
    puls a,b,x,y
rts


; void MakePatternColor(byte c, ptr<byte> pSource, byte count);
dseg
MakePatternColor_@Param2: public MakePatternColor_@Param2
    defb 0 ; count
cseg
MakePatternColor_: public MakePatternColor_
    pshs a,b,x,y
        ldb #PatternSize
        mul
        addd #PatternRam_
        tfr d,x

        lda MakePatternColor_@Param2 ; count
        ldb #PatternSize
        mul

        do
            pshs a,b
                lda ,y+ | sta ,x+
            puls a,b
            subd #1
        while ne | wend
    puls a,b,x,y
rts


; void ClearScreen();
cseg
ClearScreen_:   public ClearScreen_
    pshs a,b,x,y
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldx #Vram
            do
                clr ,x+
                cmpx #Vram+VramRowSize*VramHeight
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc

        ldx #Backup
        do
            clr ,x+
            cmpx #Backup+VVramWidth*VVramHeight
        while ne | wend
    puls a,b,x,y
rts


; word Put(word vram, byte c);
cseg
Put_: public Put_
    pshs a,b,x,y
        lda #PatternSize
        mul
        ldy #PatternRam_
        leay d,y
        
        pshs cc | orcc #$50
            lda INIT1
            ora #$01
            sta INIT1

            ldb #CharHeight
            do
                pshs b
                    ldb #VramStep
                    do
                        lda ,y+
                        sta ,x+
                        decb
                    while ne | wend
                    leax VramWidth-VramStep,x
                puls b
                decb
            while ne | wend

            lda INIT1
            anda #not $01
            sta INIT1
        puls cc
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