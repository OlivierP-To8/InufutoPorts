cseg

PatternRam_: public PatternRam_
include "../CharPat_Ascii.inc"
; logo
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $f0,$f0,$f0,$f0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$f0,$f0,$f0,$f0
	defb $f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $0f,$0f,$0f,$0f,$00,$00,$00,$00
	defb $ff,$ff,$ff,$ff,$00,$00,$00,$00
	defb $0f,$0f,$0f,$0f,$f0,$f0,$f0,$f0
	defb $ff,$ff,$ff,$ff,$f0,$f0,$f0,$f0
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $f0,$f0,$f0,$f0,$0f,$0f,$0f,$0f
	defb $00,$00,$00,$00,$ff,$ff,$ff,$ff
	defb $f0,$f0,$f0,$f0,$ff,$ff,$ff,$ff
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $ff,$ff,$ff,$ff,$0f,$0f,$0f,$0f
	defb $0f,$0f,$0f,$0f,$ff,$ff,$ff,$ff
	defb $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
; mono8
	defb $60,$7f,$7f,$60,$60,$7f,$7f,$60
	defb $06,$fe,$fe,$06,$06,$fe,$fe,$06
	defb $ff,$ff,$ff,$ff,$00,$00,$00,$00
	defb $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
include "../CharPat_ManLeft.inc"
include "../CharPat_ManRight.inc"
include "../CharPat_ManClimb.inc"
include "../CharPat_ManLoose.inc"
; Char_Fire_Left0
	defb $01,$07,$0f,$1f,$3f,$7f,$7f,$ed
	defb $c0,$f0,$98,$cc,$e0,$f0,$f0,$f8
	defb $ed,$ff,$ff,$e1,$73,$3f,$0f,$00
	defb $f8,$f8,$f8,$f8,$f0,$e0,$c0,$00
; Char_Fire_Left1
	defb $00,$03,$07,$0f,$1f,$3f,$7f,$7f
	defb $e0,$f8,$cc,$80,$c0,$e0,$f0,$f8
	defb $ed,$ed,$ff,$ff,$61,$3f,$0f,$00
	defb $fc,$fc,$fc,$fc,$f8,$f0,$c0,$00
; Char_Fire_Right0
	defb $03,$0f,$19,$33,$07,$0f,$0f,$1f
	defb $80,$e0,$f0,$f8,$fc,$fe,$fe,$b7
	defb $1f,$1f,$1f,$1f,$0f,$07,$03,$00
	defb $b7,$ff,$ff,$87,$ce,$fc,$f0,$00
; Char_Fire_Right1
	defb $07,$1f,$33,$01,$03,$07,$0f,$1f
	defb $00,$c0,$e0,$f0,$f8,$fc,$fe,$fe
	defb $3f,$3f,$3f,$3f,$1f,$0f,$03,$00
	defb $b7,$b7,$ff,$ff,$86,$fc,$f0,$00
include "../CharPat_MonsterLeft.inc"
include "../CharPat_MonsterRight.inc"
include "../CharPat_Item1Up.inc"
; Char_Item_Power
	defb $00,$00,$00,$1f,$3f,$7c,$7c,$7c
	defb $00,$00,$00,$f8,$fc,$7e,$7e,$7e
	defb $7c,$7c,$7c,$7f,$7c,$7c,$3f,$1f
	defb $7e,$7e,$7e,$fe,$7e,$7e,$fc,$f8
; Char_Block
	defb $7f,$ff,$c0,$df,$df,$df,$df,$df
	defb $fe,$ff,$03,$fb,$fb,$fb,$fb,$fb
	defb $df,$df,$df,$df,$df,$c0,$ff,$7f
	defb $fb,$fb,$fb,$fb,$fb,$03,$ff,$fe



ColorSource_: public ColorSource_
include "../CharCol_ManLeft.inc"
include "../CharCol_ManRight.inc"
include "../CharCol_ManClimb.inc"
include "../CharCol_ManLoose.inc"
