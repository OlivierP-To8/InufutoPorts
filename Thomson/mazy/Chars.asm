cseg

PatternRam_: public PatternRam_
; ascii
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $18,$18,$18,$18,$18,$00,$18,$00
	defb $36,$36,$36,$00,$00,$00,$00,$00
	defb $06,$37,$3e,$77,$3e,$76,$30,$00
	defb $08,$3f,$48,$3e,$09,$7e,$08,$00
	defb $00,$32,$54,$68,$16,$2a,$4c,$00
	defb $38,$6c,$6c,$38,$6b,$66,$3b,$00
	defb $0c,$18,$30,$00,$00,$00,$00,$00
	defb $0c,$18,$30,$30,$30,$18,$0c,$00
	defb $30,$18,$0c,$0c,$0c,$18,$30,$00
	defb $08,$2a,$1c,$7f,$1c,$2a,$08,$00
	defb $00,$18,$18,$7e,$18,$18,$00,$00
	defb $00,$00,$00,$00,$18,$18,$30,$00
	defb $00,$00,$00,$7e,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$18,$18,$00
	defb $00,$03,$06,$0c,$18,$30,$60,$00
	defb $3e,$63,$67,$6b,$73,$63,$3e,$00
	defb $18,$78,$18,$18,$18,$18,$7e,$00
	defb $3e,$63,$07,$1e,$3c,$70,$7f,$00
	defb $3e,$63,$03,$1e,$03,$63,$3e,$00
	defb $06,$0e,$1e,$36,$66,$7f,$06,$00
	defb $7f,$60,$7e,$03,$03,$63,$3e,$00
	defb $1e,$30,$60,$7e,$63,$63,$3e,$00
	defb $7f,$63,$06,$0c,$18,$18,$18,$00
	defb $3e,$63,$63,$3e,$63,$63,$3e,$00
	defb $3e,$63,$63,$3f,$03,$63,$3e,$00
	defb $00,$00,$18,$00,$00,$18,$00,$00
	defb $00,$00,$18,$00,$00,$18,$30,$00
	defb $0c,$18,$30,$60,$30,$18,$0c,$00
	defb $00,$00,$7e,$00,$7e,$00,$00,$00
	defb $30,$18,$0c,$06,$0c,$18,$30,$00
	defb $3e,$63,$03,$0e,$18,$00,$18,$00
	defb $1e,$21,$4d,$55,$4e,$20,$1e,$00
	defb $1c,$36,$63,$63,$7f,$63,$63,$00
	defb $7e,$63,$63,$7e,$63,$63,$7e,$00
	defb $1e,$33,$60,$60,$60,$33,$1e,$00
	defb $7c,$66,$63,$63,$63,$66,$7c,$00
	defb $7e,$60,$60,$7e,$60,$60,$7e,$00
	defb $7e,$60,$60,$7e,$60,$60,$60,$00
	defb $1e,$33,$60,$6f,$63,$33,$1f,$00
	defb $63,$63,$63,$7f,$63,$63,$63,$00
	defb $7e,$18,$18,$18,$18,$18,$7e,$00
	defb $06,$06,$06,$06,$06,$66,$3c,$00
	defb $63,$66,$6c,$78,$6c,$66,$63,$00
	defb $60,$60,$60,$60,$60,$60,$7e,$00
	defb $7e,$6b,$6b,$6b,$6b,$6b,$6b,$00
	defb $63,$73,$7b,$7f,$6f,$67,$63,$00
	defb $3e,$63,$63,$63,$63,$63,$3e,$00
	defb $7e,$63,$63,$63,$7e,$60,$60,$00
	defb $3e,$63,$63,$63,$6b,$66,$3b,$00
	defb $7e,$63,$63,$67,$7c,$6e,$67,$00
	defb $3e,$63,$60,$3e,$03,$63,$3e,$00
	defb $7e,$18,$18,$18,$18,$18,$18,$00
	defb $63,$63,$63,$63,$63,$63,$3e,$00
	defb $63,$63,$63,$36,$36,$1c,$1c,$00
	defb $63,$6b,$6b,$6b,$6b,$6b,$7e,$00
	defb $63,$63,$36,$1c,$36,$63,$63,$00
	defb $66,$66,$66,$3c,$18,$18,$18,$00
	defb $7f,$06,$0c,$18,$30,$60,$7f,$00
	defb $3c,$20,$20,$20,$20,$20,$3c,$00
	defb $22,$22,$14,$3e,$08,$3e,$08,$00
	defb $3c,$04,$04,$04,$04,$04,$3c,$00
	defb $08,$14,$22,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$7e,$00
; Char_Kn_Left
	defb $00,$00,$04,$7f,$3f,$04,$00,$00
; Char_Kn_Right
	defb $00,$00,$20,$fe,$fc,$20,$00,$00
; Char_Kn_Up
	defb $00,$08,$18,$18,$18,$3c,$18,$18
; Char_Kn_Down
	defb $18,$18,$3c,$18,$18,$18,$08,$00
; Char_Wall
	defb $aa,$55,$aa,$55,$aa,$55,$aa,$55
; Char_Man_Left_Stop
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$0f
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$c0
	defb $1f,$37,$37,$04,$0c,$0c,$0c,$0c
	defb $e0,$b0,$b0,$80,$c0,$c0,$c0,$c0
; Char_Man_Left0
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $07,$37,$37,$07,$0e,$1c,$38,$10
	defb $e0,$f0,$b0,$00,$e0,$e0,$00,$00
; Char_Man_Left1
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $03,$03,$07,$06,$00,$06,$06,$06
	defb $00,$00,$00,$00,$80,$80,$80,$00
; Char_Man_Left2
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $07,$1e,$1d,$03,$05,$0e,$1c,$08
	defb $a0,$b0,$b0,$80,$f0,$70,$00,$00
; Char_Man_Left3
	defb $00,$07,$0f,$0a,$0a,$0f,$07,$03
	defb $00,$80,$c0,$c0,$c0,$c0,$80,$80
	defb $03,$03,$07,$06,$00,$05,$05,$04
	defb $00,$00,$00,$00,$80,$80,$80,$00
; Char_Man_Right_Stop
	defb $00,$01,$03,$03,$03,$03,$01,$03
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$f0
	defb $07,$0d,$0d,$01,$03,$03,$03,$03
	defb $f8,$ec,$ec,$20,$30,$30,$30,$30
; Char_Man_Right0
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $07,$0f,$0d,$00,$07,$07,$00,$00
	defb $e0,$ec,$ec,$e0,$70,$38,$1c,$08
; Char_Man_Right1
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $00,$00,$00,$00,$01,$01,$01,$00
	defb $c0,$c0,$e0,$60,$00,$60,$60,$60
; Char_Man_Right2
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $05,$0d,$0d,$01,$0f,$0e,$00,$00
	defb $e0,$78,$b8,$c0,$a0,$70,$38,$10
; Char_Man_Right3
	defb $00,$01,$03,$03,$03,$03,$01,$01
	defb $00,$e0,$f0,$50,$50,$f0,$e0,$c0
	defb $00,$00,$00,$00,$01,$01,$01,$00
	defb $c0,$c0,$e0,$60,$00,$a0,$a0,$20
; Char_Man_Up_Stop
	defb $00,$00,$00,$00,$3d,$67,$7f,$67
	defb $00,$00,$60,$e0,$8f,$ff,$e0,$e0
	defb $7f,$3d,$00,$00,$00,$00,$00,$00
	defb $ff,$8f,$e0,$60,$00,$00,$00,$00
; Char_Man_Up0
	defb $00,$00,$00,$00,$3c,$66,$7f,$67
	defb $00,$00,$62,$67,$0e,$fc,$f8,$f0
	defb $7f,$3c,$00,$00,$00,$00,$00,$00
	defb $ec,$cc,$ec,$60,$00,$00,$00,$00
; Char_Man_Up1
	defb $00,$00,$00,$00,$3c,$66,$7f,$67
	defb $00,$00,$00,$00,$00,$37,$f7,$e0
	defb $7f,$3c,$00,$00,$00,$00,$00,$00
	defb $02,$00,$00,$00,$00,$00,$00,$00
; Char_Man_Up2
	defb $00,$00,$00,$00,$3c,$66,$7f,$67
	defb $00,$00,$00,$62,$67,$ee,$d4,$b8
	defb $7f,$3c,$00,$00,$00,$00,$00,$00
	defb $f8,$0c,$ec,$6c,$00,$00,$00,$00
; Char_Man_Up3
	defb $00,$00,$00,$00,$3c,$66,$7f,$67
	defb $00,$00,$00,$00,$00,$37,$f0,$e6
	defb $7f,$3c,$00,$00,$00,$00,$00,$00
	defb $0e,$00,$00,$00,$00,$00,$00,$00
; Char_Man_Down_Stop
	defb $00,$00,$00,$00,$00,$00,$3d,$7f
	defb $00,$00,$00,$00,$60,$e0,$8f,$ff
	defb $67,$7f,$67,$3d,$00,$00,$00,$00
	defb $e0,$e0,$ff,$8f,$e0,$60,$00,$00
; Char_Man_Down0
	defb $00,$00,$00,$00,$00,$00,$3c,$7f
	defb $00,$00,$00,$00,$60,$ec,$cc,$ec
	defb $67,$7f,$66,$3c,$00,$00,$00,$00
	defb $f0,$f8,$fc,$0e,$67,$62,$00,$00
; Char_Man_Down1
	defb $00,$00,$00,$00,$00,$00,$3c,$7f
	defb $00,$00,$00,$00,$00,$00,$00,$0e
	defb $67,$7f,$66,$3c,$00,$00,$00,$00
	defb $e0,$f7,$37,$00,$00,$00,$00,$00
; Char_Man_Down2
	defb $00,$00,$00,$00,$00,$00,$3c,$7f
	defb $00,$00,$00,$00,$6c,$ec,$0c,$f8
	defb $67,$7f,$66,$3c,$00,$00,$00,$00
	defb $b8,$d4,$ee,$67,$62,$00,$00,$00
; Char_Man_Down3
	defb $00,$00,$00,$00,$00,$00,$3c,$7f
	defb $00,$00,$00,$00,$00,$00,$00,$0e
	defb $67,$7f,$66,$3c,$00,$00,$00,$00
	defb $e6,$f0,$37,$00,$00,$00,$00,$00
; Char_Man_Die2
	defb $03,$03,$03,$03,$01,$0d,$0d,$07
	defb $30,$30,$30,$30,$20,$ec,$ec,$f8
	defb $03,$01,$03,$03,$03,$03,$01,$00
	defb $f0,$e0,$f0,$50,$50,$f0,$e0,$00
; Char_Man_Die3
	defb $00,$00,$06,$07,$f1,$ff,$07,$07
	defb $00,$00,$00,$00,$bc,$e6,$fe,$e6
	defb $ff,$f1,$07,$06,$00,$00,$00,$00
	defb $fe,$bc,$00,$00,$00,$00,$00,$00
; Char_Chaser
	defb $00,$18,$3c,$66,$66,$66,$3c,$1c
	defb $00,$18,$3c,$66,$66,$66,$3c,$38
	defb $0b,$07,$1f,$39,$36,$7f,$73,$61
	defb $d0,$e0,$f8,$9c,$6c,$fe,$ce,$86
; Char_Disturber
	defb $00,$03,$0f,$1f,$1f,$31,$31,$39
	defb $00,$c0,$f0,$f8,$f8,$8c,$8c,$9c
	defb $3f,$3a,$18,$1c,$1f,$3f,$7b,$71
	defb $fc,$5c,$18,$38,$f8,$fc,$ce,$86
; Char_Goal
	defb $00,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $00,$fc,$fc,$fc,$fc,$fc,$ec,$d4
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$00
	defb $d4,$ec,$fc,$fc,$fc,$fc,$fc,$00
; Char_Bang
	defb $00,$00,$02,$10,$0a,$05,$2b,$07
	defb $00,$80,$a0,$84,$a8,$d0,$ea,$f0
	defb $7f,$07,$2b,$05,$0a,$10,$02,$00
	defb $ff,$f0,$ea,$d0,$a8,$84,$a0,$80
; Char_Title
	defb $3f,$3f,$3c,$3c,$3c,$3c,$3c,$3c
	defb $fc,$fc,$cf,$cf,$cf,$cf,$cf,$cf
	defb $3c,$3c,$3c,$3c,$3c,$3c,$00,$00
	defb $cf,$cf,$cf,$cf,$cf,$cf,$00,$00
	defb $03,$03,$0f,$0f,$3c,$3c,$3c,$3c
	defb $f0,$f0,$3c,$3c,$0f,$0f,$0f,$0f
	defb $3f,$3f,$3c,$3c,$3c,$3c,$00,$00
	defb $ff,$ff,$0f,$0f,$0f,$0f,$00,$00
	defb $3f,$3f,$00,$00,$00,$00,$03,$03
	defb $ff,$ff,$3c,$3c,$f0,$f0,$c0,$c0
	defb $0f,$0f,$3c,$3c,$3f,$3f,$00,$00
	defb $00,$00,$00,$00,$ff,$ff,$00,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$0c,$0c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$30,$30
	defb $03,$03,$03,$03,$03,$03,$00,$00
	defb $c0,$c0,$c0,$c0,$c0,$c0,$00,$00



PaletteValues_: public PaletteValues_
	defb	$c0, $00, $f0, $00, $d8, $d8, $e8, $d8
	defb	$00, $e0, $c8, $00, $d0, $f0, $c8, $f8

; tableau des couleurs

; B7 : 1/2 teinte fond (1 = saturée, 0 = pastel)
; B6 : 1/2 teinte forme (1 = saturée, 0 = pastel)
; B543 : couleur forme
; B321 : couleur fond

; B V R teinte (saturée / pastel)
; 0 0 0 NOIR    $C0 / $80 GRIS
; 0 0 1 ROUGE   $C8 / $88 ROSE
; 0 1 0 VERT    $D0 / $90 VERT CLAIR
; 0 1 1 JAUNE   $D8 / $98 SABLE
; 1 0 0 BLEU    $E0 / $A0 BLEU CLAIR
; 1 0 1 MAGENTA $E8 / $A8 PARME
; 1 1 0 CYAN    $F0 / $B0 BLEU CIEL
; 1 1 1 BLANC   $F8 / $B8 ORANGE



ColorSource_: public ColorSource_
; Char_Man_Left_Stop
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
; Char_Man_Left0
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
	defb $0a,$0a,$04,$00,$09,$09,$00,$00
; Char_Man_Left1
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0a,$04,$00,$09,$09,$04
	defb $00,$00,$00,$00,$09,$09,$04,$00
; Char_Man_Left2
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
	defb $0a,$0a,$04,$09,$09,$09,$00,$00
; Char_Man_Left3
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$0a,$04,$00,$09,$09,$04
	defb $00,$00,$00,$00,$09,$09,$04,$00
; Char_Man_Right_Stop
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
; Char_Man_Right0
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$00,$09,$09,$00,$00
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
; Char_Man_Right1
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$00,$00,$00,$09,$09,$04,$00
	defb $0a,$0a,$0a,$04,$00,$09,$09,$04
; Char_Man_Right2
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $0a,$0a,$04,$09,$09,$09,$00,$00
	defb $0a,$0a,$04,$09,$09,$09,$09,$04
; Char_Man_Right3
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$0f,$0f,$0f,$0f,$0f,$0f,$0a
	defb $00,$00,$00,$00,$09,$09,$04,$00
	defb $0a,$0a,$0a,$04,$00,$09,$09,$04
; Char_Man_Up_Stop
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$09,$09,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$0a,$0a,$0a,$0a
; Char_Man_Up0
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$09,$09,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$0a,$0a,$0a,$0a
; Char_Man_Up1
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$09,$09,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$0a,$0a,$0a,$0a
; Char_Man_Up2
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$09,$09,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$0a,$0a,$0a,$0a
; Char_Man_Up3
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$09,$09,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$0a,$0a,$0a,$0a
; Char_Man_Down_Stop
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$0a,$0a,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$09,$09,$0a,$0a,$0a,$0a
; Char_Man_Down0
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$0a,$0a,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$09,$09,$0a,$0a,$0a,$0a
; Char_Man_Down1
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$0a,$0a,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$09,$09,$0a,$0a,$0a,$0a
; Char_Man_Down2
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$0a,$0a,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$09,$09,$0a,$0a,$0a,$0a
; Char_Man_Down3
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0a,$0a,$0a,$0a,$0a,$0a,$09,$09
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $09,$09,$09,$09,$0a,$0a,$0a,$0a
; Char_Man_Die2
	defb $04,$09,$09,$09,$09,$04,$0a,$0a
	defb $04,$09,$09,$09,$09,$04,$0a,$0a
	defb $0a,$0f,$0f,$0f,$0f,$0f,$0f,$00
	defb $0a,$0f,$0f,$0f,$0f,$0f,$0f,$00
; Char_Man_Die3
	defb $00,$00,$0a,$0a,$09,$09,$09,$09
	defb $00,$00,$00,$00,$0f,$0f,$0f,$0f
	defb $09,$09,$0a,$0a,$00,$00,$00,$00
	defb $0f,$0f,$00,$00,$00,$00,$00,$00
; Char_Chaser
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $0f,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	defb $06,$06,$06,$06,$06,$06,$06,$06
	defb $06,$06,$06,$06,$06,$06,$06,$06
