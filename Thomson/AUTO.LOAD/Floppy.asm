; Thomson Floppy Disk BIN Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include '../ThomsonTO.inc'

ext printError_
ext loadBinFile_
ext nbbanks_


; byte ReadSector(byte track, byte sector, ptr<byte> pDest);
dseg
ReadSector_@Param2: public ReadSector_@Param2
    defw 0
cseg
ReadSector_: public ReadSector_
    pshs b

        ; track in A
        sta DKTRK

        ; sector in B
        stb DKSEC

        ; buffer address
        ldd ReadSector_@Param2
        std DKBUF

        ; read sector command
        lda #$02
        sta DKOPC

        ; call ROM
        jsr DKCO
                if cs
            ; error
            lda DKSTA
            jsr printError_
        else
            lda #0
        endif

    puls b
rts


; void LoadFile(byte nb, byte bank);
LoadFile_: public LoadFile_

    tstb
    if eq               ; if bank == 0
        ldb nbbanks_    ; use last bank
        if ne           ; if not 0
            stb LGA5
        endif
        jsr loadBinFile_ ; always load from floppy
    else
        stb LGA5
        ldb $DFFF
        cmpb #$54       ; $DFFF == 'T' ?
        if ne           ; if not, load from floppy
            jsr loadBinFile_
            ldb #$54
            stb $DFFF
        endif
    endif

    ldx #$A000
    jmp ,X

rts
