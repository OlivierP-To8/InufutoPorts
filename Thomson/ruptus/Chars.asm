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
; Char_Barrier
	defb $00,$00,$00,$ff,$ff,$00,$00,$00
	defb $18,$18,$18,$18,$18,$18,$18,$18
; Char_EnemyBullet
	defb $00,$00,$18,$3c,$3c,$18,$00,$00
; Char_Map
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $fc,$fc,$fc,$fc,$fc,$fc,$00,$00
; Char_Star
	defb $00,$00,$00,$00,$08,$00,$00,$00
; Char_FighterBullet
	defb $01,$01,$01,$01,$01,$01,$01,$01
	defb $00,$02,$04,$08,$10,$20,$40,$00
	defb $00,$00,$00,$00,$00,$00,$00,$ff
	defb $00,$40,$20,$10,$08,$04,$02,$00
; Char_BarrierHead
	defb $3c,$7e,$e7,$db,$db,$e7,$7e,$3c
; Char_Fighter
	defb $10,$10,$30,$31,$73,$76,$75,$f7
	defb $10,$10,$18,$18,$9c,$dc,$5c,$de
	defb $f7,$f7,$f7,$77,$33,$10,$00,$00
	defb $de,$de,$de,$dc,$98,$10,$00,$00

	defb $03,$0f,$3f,$7e,$fd,$fa,$f7,$ef
	defb $c0,$80,$00,$00,$e0,$22,$a6,$ae
	defb $df,$1f,$0f,$06,$01,$03,$03,$00
	defb $de,$bc,$7c,$f8,$f8,$f0,$e0,$00

	defb $0f,$1f,$3f,$7f,$00,$1f,$3f,$3f
	defb $00,$e0,$f8,$fe,$00,$c0,$60,$b0
	defb $3f,$1f,$00,$7f,$3f,$1f,$0f,$00
	defb $60,$c0,$00,$fe,$f8,$e0,$00,$00

	defb $03,$03,$01,$06,$0f,$1f,$df,$ef
	defb $e0,$f0,$f8,$f8,$7c,$bc,$de,$ae
	defb $f7,$fa,$fd,$7e,$3f,$0f,$03,$00
	defb $a6,$22,$e0,$00,$00,$80,$c0,$00

	defb $00,$10,$33,$77,$f7,$f7,$f7,$f7
	defb $00,$10,$98,$dc,$de,$de,$de,$de
	defb $75,$76,$73,$31,$30,$10,$10,$00
	defb $5c,$dc,$9c,$18,$18,$10,$10,$00

	defb $0f,$1f,$3f,$3e,$7d,$7b,$f7,$eb
	defb $80,$80,$00,$c0,$e0,$f0,$f6,$ee
	defb $cb,$88,$0f,$00,$01,$03,$07,$00
	defb $de,$be,$7e,$fc,$f8,$e0,$80,$00

	defb $01,$0f,$3f,$ff,$00,$07,$0d,$1b
	defb $e0,$f0,$f8,$fc,$00,$f0,$f8,$f8
	defb $0d,$07,$00,$ff,$3f,$0f,$01,$00
	defb $f8,$f0,$00,$fc,$f8,$f0,$e0,$00

	defb $07,$03,$01,$00,$0f,$88,$cb,$eb
	defb $80,$e0,$f8,$fc,$7e,$be,$de,$ee
	defb $f7,$7b,$7d,$3e,$3f,$1f,$0f,$00
	defb $f6,$f0,$e0,$c0,$00,$80,$80,$00
; Char_Enemy
	defb $00,$03,$07,$0c,$0b,$2f,$6f,$ef
	defb $00,$80,$c0,$60,$a0,$e8,$ec,$ee
	defb $ef,$cf,$8e,$05,$01,$01,$01,$00
	defb $ee,$e6,$e2,$40,$00,$00,$00,$00

	defb $00,$00,$3c,$79,$f3,$07,$0f,$1f
	defb $00,$00,$f0,$18,$c8,$e8,$e8,$f0
	defb $1f,$03,$0b,$13,$00,$00,$00,$00
	defb $e0,$c8,$98,$38,$38,$30,$20,$00

	defb $07,$03,$01,$00,$07,$0f,$07,$fb
	defb $80,$c0,$e0,$00,$f8,$d8,$ec,$ec
	defb $07,$0f,$07,$00,$01,$03,$07,$00
	defb $ec,$d8,$f8,$00,$e0,$c0,$80,$00

	defb $00,$00,$00,$09,$05,$01,$0f,$0f
	defb $10,$18,$1c,$9c,$cc,$e4,$f0,$f8
	defb $07,$03,$79,$3c,$1e,$00,$00,$00
	defb $f4,$f4,$e4,$8c,$78,$00,$00,$00

	defb $00,$00,$00,$00,$02,$47,$67,$77
	defb $00,$80,$80,$80,$a0,$71,$f3,$f7
	defb $77,$37,$17,$05,$06,$03,$01,$00
	defb $f7,$f6,$f4,$d0,$30,$e0,$c0,$00

	defb $00,$04,$0c,$1c,$1c,$19,$13,$07
	defb $00,$00,$00,$00,$c8,$d0,$c0,$f8
	defb $0f,$17,$17,$13,$18,$0f,$00,$00
	defb $f8,$f0,$e0,$cf,$9e,$3c,$00,$00

	defb $00,$01,$03,$07,$00,$1f,$37,$6f
	defb $00,$e0,$c0,$80,$00,$e0,$f0,$e0
	defb $6f,$6f,$37,$1f,$00,$07,$03,$01
	defb $de,$e0,$f0,$e0,$00,$80,$c0,$e0

	defb $00,$00,$00,$1e,$31,$27,$2f,$2f
	defb $00,$00,$00,$78,$3c,$9e,$c0,$e0
	defb $1f,$0f,$27,$33,$39,$38,$18,$08
	defb $f0,$f0,$80,$a0,$90,$00,$00,$00
include "../CharPat_Item1Up.inc"
include "../CharPat_SmallBang.inc"
include "../CharPat_LargeBang.inc"
; fort
	defb $00,$00,$00,$07,$03,$10,$1b,$1b
	defb $00,$00,$00,$ef,$e0,$0f,$00,$37
	defb $0c,$1e,$3f,$bf,$1e,$ac,$01,$fd
	defb $30,$78,$fc,$fd,$78,$35,$80,$bf
	defb $00,$00,$00,$f7,$07,$f0,$00,$ec
	defb $00,$00,$00,$e0,$c0,$08,$d8,$d8
	defb $18,$19,$00,$0f,$00,$19,$3d,$3d
	defb $78,$79,$35,$40,$0e,$ce,$ce,$ce
	defb $01,$99,$bc,$7e,$ff,$ff,$7e,$bc
	defb $80,$99,$3d,$7e,$ff,$ff,$7e,$3d
	defb $1e,$9e,$ac,$02,$70,$73,$73,$73
	defb $18,$98,$00,$f0,$00,$98,$bc,$bc

	defb $18,$01,$fd,$fd,$00,$b5,$b5,$b5
	defb $00,$d0,$c3,$c3,$00,$77,$77,$77
	defb $19,$00,$fe,$fe,$00,$bd,$bd,$bd
	defb $98,$00,$7f,$7f,$00,$bd,$bd,$bd
	defb $00,$0b,$c3,$c3,$00,$ee,$ee,$ee
	defb $18,$80,$bf,$bf,$00,$ad,$ad,$ad
	defb $b5,$b5,$b5,$00,$fd,$fd,$01,$18
	defb $77,$77,$77,$00,$c3,$c3,$d0,$00
	defb $bd,$bd,$bd,$00,$fe,$fe,$00,$19
	defb $bd,$bd,$bd,$00,$7f,$7f,$00,$98
	defb $ee,$ee,$ee,$00,$c3,$c3,$0b,$00
	defb $ad,$ad,$ad,$00,$bf,$bf,$80,$18

	defb $3d,$3d,$19,$00,$0f,$00,$19,$18
	defb $ce,$ce,$ce,$0e,$40,$35,$79,$78
	defb $bc,$7e,$ff,$ff,$7e,$bc,$99,$01
	defb $3d,$7e,$ff,$ff,$7e,$3d,$99,$80
	defb $73,$73,$73,$70,$02,$ac,$9e,$1e
	defb $bc,$bc,$98,$00,$f0,$00,$98,$18
	defb $1b,$1b,$10,$03,$07,$00,$00,$00
	defb $37,$00,$0f,$e0,$ef,$00,$00,$00
	defb $fd,$01,$ac,$1e,$bf,$3f,$1e,$0c
	defb $bf,$80,$35,$78,$fd,$fc,$78,$30
	defb $ec,$00,$f0,$07,$f7,$00,$00,$00
	defb $d8,$d8,$08,$c0,$e0,$00,$00,$00



ColorSource_: public ColorSource_
; fort
	defb $40,$40,$40,$70,$70,$70,$58,$58
	defb $40,$40,$40,$70,$70,$70,$40,$78
	defb $70,$70,$70,$70,$70,$70,$78,$78
	defb $70,$70,$70,$70,$70,$70,$78,$78
	defb $40,$40,$40,$70,$70,$70,$40,$78
	defb $40,$40,$40,$70,$70,$70,$58,$58
	defb $70,$70,$40,$78,$40,$70,$70,$70
	defb $78,$78,$78,$70,$78,$78,$78,$78
	defb $78,$78,$48,$48,$48,$48,$48,$48
	defb $78,$78,$48,$48,$48,$48,$48,$48
	defb $78,$78,$78,$70,$78,$78,$78,$78
	defb $70,$70,$40,$78,$40,$70,$70,$70

	defb $40,$68,$68,$68,$40,$78,$78,$78
	defb $40,$68,$68,$68,$40,$78,$78,$78
	defb $78,$40,$60,$60,$40,$78,$78,$78
	defb $78,$40,$60,$60,$40,$78,$78,$78
	defb $40,$68,$68,$68,$40,$78,$78,$78
	defb $40,$68,$68,$68,$40,$78,$78,$78
	defb $78,$78,$78,$40,$68,$68,$68,$40
	defb $78,$78,$78,$40,$68,$68,$68,$40
	defb $78,$78,$78,$40,$60,$60,$40,$78
	defb $78,$78,$78,$40,$60,$60,$40,$78
	defb $78,$78,$78,$40,$68,$68,$68,$40
	defb $78,$78,$78,$40,$68,$68,$68,$40

	defb $70,$70,$70,$40,$78,$40,$70,$70
	defb $78,$78,$78,$78,$70,$78,$78,$78
	defb $48,$48,$48,$48,$48,$48,$78,$78
	defb $48,$48,$48,$48,$48,$48,$78,$78
	defb $78,$78,$78,$78,$70,$78,$78,$78
	defb $70,$70,$70,$40,$78,$40,$70,$70
	defb $58,$58,$70,$70,$70,$40,$40,$40
	defb $78,$40,$70,$70,$70,$40,$40,$40
	defb $78,$78,$70,$70,$70,$70,$70,$70
	defb $78,$78,$70,$70,$70,$70,$70,$70
	defb $78,$40,$70,$70,$70,$40,$40,$40
	defb $58,$58,$70,$70,$70,$40,$40,$40
