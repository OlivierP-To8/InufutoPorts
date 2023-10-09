include "Vram.inc"
include "VVram.inc"

ext Sprites_
ext HideAllSprites_
ext SpritePatternSource_
ext SetRowFlags_, VVramPtr_
ext VVram_

SpriteCount equ 20
SpriteWidth equ 4
SpriteHeight equ 2
InvalidY equ 80h

Sprite_x equ 0
Sprite_y equ 1
Sprite_oldX equ 2
Sprite_oldY equ 3
Sprite_code equ 4
Sprite_type equ 5
Sprite_unitSize equ 6


zseg
halfY:
    defb 0
yCount:
    defb 0
xCount:
    defb 0
yMod:
    defb 0


; void SetSpriteRowFlags();
cseg
SetSpriteRowFlags_: public SetSpriteRowFlags_
    pshs a,b,x,y
        ldx #Sprites_
        ldb #SpriteCount
        do
            pshs b
                lda Sprite_oldY,x
                cmpa #InvalidY
                if ne
                    lsra
                    if cs
                        ldb #$07
                    else
                        ldb #$03
                    endif
                    jsr SetRowFlags_
                endif
            puls b
            leax Sprite_unitSize,x
            
            decb
        while ne | wend
    puls a,b,x,y
rts


; void DrawSprites();
cseg
DrawRow:
    pshs b
        ldb #SpriteWidth | stb <xCount
    puls b
    do
        sta ,y+
        inca
        stb ,y+
        dec <xCount
    while ne | wend
    leay VVramWidth-SpriteWidth*2,y
rts
DrawSprites_: public DrawSprites_
    pshs a,b,x,y
        ldx #Sprites_
        ldb #SpriteCount
        do
            pshs b
                lda Sprite_y,x
                cmpa #InvalidY
                if ne
                    tfr a,b
                    anda #$01 | sta <yMod
                    lsrb
                    stb <halfY
                    lda Sprite_x,x
                    jsr VVramPtr_
                    tfr d,y
                    
                    lda Sprite_type,x
                    if eq
                        lda <halfY
                        cmpa #VVramHeight
                        if cs
                            tst <yMod
                            if eq
                                ldb #1
                                jsr SetRowFlags_
                                lda Sprite_code,x | sta ,y+
                                clr ,y
                            else
                                ldb #3
                                jsr SetRowFlags_
                                lda Sprite_code,x | sta ,y+
                                ldb #1 | stb ,y
                                leay VVramWidth-1,y
                                sta ,y+
                                ldb #3 | stb ,y
                            endif
                        endif
                    else
                        tst <yMod
                        if eq
                            lda <halfY
                            cmpa #VVramHeight
                            if cs
                                ldb #3
                                jsr SetRowFlags_
                                lda Sprite_code,x
                                clrb
                                bsr DrawRow
                                ldb <halfY | incb | stb <halfY
                                cmpb #VVramHeight
                                if cs
                                    clrb
                                    bsr DrawRow
                                endif
                            endif
                        else
                            lda <halfY
                            cmpa #VVramHeight
                            if cs
                                ldb #7
                                jsr SetRowFlags_
                                lda Sprite_type,x
                                cmpa #3
                                if eq
                                    lda Sprite_code,x
                                    suba #4
                                    ldb #2
                                    bsr DrawRow
                                else
                                    lda Sprite_code,x
                                    ldb #1
                                    bsr DrawRow
                                endif
                                ldb <halfY | incb | stb <halfY
                                cmpb #VVramHeight
                                if cs
                                    lda Sprite_code,x
                                    ldb #2
                                    bsr DrawRow
                                    ldb <halfY | incb | stb <halfY
                                    cmpb #VVramHeight
                                    if cs
                                        ldb Sprite_type,x
                                        cmpb #2
                                        if eq
                                            ldb #2
                                        else
                                            ldb #3
                                        endif
                                        bsr DrawRow
                                    endif
                                endif
                            endif
                        endif
                    endif
                endif
                lda Sprite_x,x | sta Sprite_oldX,x
                lda Sprite_y,x | sta Sprite_oldY,x
                leax Sprite_unitSize,x
            puls b
            decb
        while ne | wend
    puls a,b,x,y
rts
