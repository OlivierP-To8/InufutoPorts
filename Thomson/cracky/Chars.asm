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
; cracked floor
	defb $bf,$be,$dd,$d2,$ef,$6f,$b3,$bd
	defb $7d,$fd,$fb,$fb,$77,$cf,$b6,$b9
	defb $a8,$f0,$dc,$d2,$ea,$68,$b0,$b8
	defb $0d,$15,$0b,$a3,$57,$43,$12,$09
	defb $80,$e0,$c2,$d0,$e8,$4c,$b0,$80
	defb $00,$05,$0b,$43,$07,$09,$26,$01
	defb $80,$c0,$c0,$c0,$80,$00,$00,$00
	defb $00,$01,$03,$01,$01,$01,$00,$00
; hard floor
	defb $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
; ladder left
	defb $60,$7f,$7f,$60,$60,$7f,$7f,$60
; ladder right
	defb $06,$fe,$fe,$06,$06,$fe,$fe,$06
; item
	defb $00,$00,$00,$01,$01,$01,$7f,$3f
	defb $00,$80,$80,$c0,$c0,$c0,$ff,$fe
	defb $0f,$07,$07,$07,$0f,$0c,$08,$00
	defb $f8,$f0,$f0,$f0,$78,$18,$08,$00
include "../CharPat_ManLeft.inc"
include "../CharPat_ManRight.inc"
include "../CharPat_ManClimb.inc"
include "../CharPat_ManLoose.inc"
include "../CharPat_MonsterLeft.inc"
include "../CharPat_MonsterRight.inc"
include "../CharPat_MonsterUp.inc"
include "../CharPat_MonsterDown.inc"



ColorSource_: public ColorSource_
include "../CharCol_ManLeft.inc"
include "../CharCol_ManRight.inc"
include "../CharCol_ManClimb.inc"
include "../CharCol_ManLoose.inc"
