; Thomson Floppy Disk BIN Loader by OlivierP-To8
; https://github.com/OlivierP-To8

include '../ThomsonTO.inc'

; byte InitDrive(byte drive);
InitDrive_: public InitDrive_

    ; drive in A
    sta DKDRV

    ; init controller
    lda #$01
    sta DKOPC

    ; call ROM
    jsr DKCONT
    if cs
        ; error
        lda DKSTA
    else
        lda #0
    endif

rts


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

        ; search for track DKTRK
        lda #$40
        sta DKOPC

        ; call ROM
        jsr DKCONT
        if cs
            ; error
            lda DKSTA
        else
            ; buffer address
            ldd ReadSector_@Param2
            std DKBUF

            ; read sector
            lda #$02
            sta DKOPC

            ; call ROM
            jsr DKCONT
            if cs
                ; error
                lda DKSTA
            else
                lda #0
            endif
        endif

    puls b
rts


; void RunAddress(word address);
RunAddress_: public RunAddress_

    jmp ,X

rts
