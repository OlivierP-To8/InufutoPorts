/*
; B7 : 1/2 teinte fond (1 = saturée, 0 = pastel)
; B6 : 1/2 teinte forme (1 = saturée, 0 = pastel)
; B543 : couleur forme
; B321 : couleur fond

; B V R teinte (saturée / pastel) sur fond noir
; 0 0 0 NOIR    $C0 / $80 GRIS
; 0 0 1 ROUGE   $C8 / $88 ROSE
; 0 1 0 VERT    $D0 / $90 VERT CLAIR
; 0 1 1 JAUNE   $D8 / $98 SABLE
; 1 0 0 BLEU    $E0 / $A0 BLEU CLAIR
; 1 0 1 MAGENTA $E8 / $A8 PARME
; 1 1 0 CYAN    $F0 / $B0 BLEU CIEL
; 1 1 1 BLANC   $F8 / $B8 ORANGE
*/
constexpr byte FormeNoir    = 0x40;
constexpr byte FormeRouge   = 0x48;
constexpr byte FormeVert    = 0x50;
constexpr byte FormeJaune   = 0x58;
constexpr byte FormeBleu    = 0x60;
constexpr byte FormeMagenta = 0x68;
constexpr byte FormeCyan    = 0x70;
constexpr byte FormeBlanc   = 0x78;
/* not available on TO7
constexpr byte FormeGris      = 0x00;
constexpr byte FormeRose      = 0x08;
constexpr byte FormeVertClair = 0x10;
constexpr byte FormeSable     = 0x18;
constexpr byte FormeBleuClair = 0x20;
constexpr byte FormeParme     = 0x28;
constexpr byte FormeBleuCiel  = 0x30;
constexpr byte FormeOrange    = 0x38;
*/
constexpr byte FondNoir    = 0x80;
constexpr byte FondRouge   = 0x81;
constexpr byte FondVert    = 0x82;
constexpr byte FondJaune   = 0x83;
constexpr byte FondBleu    = 0x84;
constexpr byte FondMagenta = 0x85;
constexpr byte FondCyan    = 0x86;
constexpr byte FondBlanc   = 0x87;
/* not available on TO7
constexpr byte FondGris      = 0x00;
constexpr byte FondRose      = 0x01;
constexpr byte FondVertClair = 0x02;
constexpr byte FondSable     = 0x03;
constexpr byte FondBleuClair = 0x04;
constexpr byte FondParme     = 0x05;
constexpr byte FondBleuCiel  = 0x06;
constexpr byte FondOrange    = 0x07;
*/
extern void MakeMono(byte count, ptr<byte> pDest, byte color);
extern void MakeColor(byte count, ptr<byte> pDest);

