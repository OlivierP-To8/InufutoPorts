# InufutoPorts
Inufuto's tools and games ported to Thomson 8-bit computers (only TO models: TO7/TO7-70/TO9/TO8/TO8D/TO9+)

Learn more on the family of 8-bit French micro-computers built by Thomson in the 80's at <https://www-apr.lip6.fr/~mine/mess/index.html.en> and <https://pulkomandy.tk/wiki/doku.php?id=documentations:start>

I added 3 linker targets to Inufuto's tools (in tools/asm8-1.5.0/Linker/Thomson*.cs):
* Floppy disk (.fd)
* Audio tape (.k7)
* ROM cartridge (.m7)

I ported the 14 games, with color changes because the graphic mode compatible with the whole Thomson range only supports 2 colors for 8 pixels.

To play the games, the easiest way is to use the InufuTO.fd image on the emulator of your choice: [DCMOTO](http://dcmoto.free.fr/emulateur/index.html), [RetroArch](https://www.retroarch.com/) with [Theodore](https://docs.libretro.com/library/theodore/) core, [MAME](https://www.mamedev.org/), [Teo](https://sourceforge.net/projects/teoemulator/).

See HARDWARE.md to play the games on real hardware.
