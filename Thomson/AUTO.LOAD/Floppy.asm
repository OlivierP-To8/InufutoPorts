; Thomson Floppy Disk BIN Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include '../ThomsonTO.inc'

ext printError_


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


; void RunAddress(word address);
RunAddress_: public RunAddress_

    jmp ,X

rts
