# InufutoPorts
Inufuto's tools and games ported to Thomson 8-bit computers (only TO models: TO7/TO7-70/TO9/TO8/TO8D/TO9+)

Learn more on the family of 8-bit French micro-computers built by Thomson in the 80's at <https://www-apr.lip6.fr/~mine/mess/index.html.en> and <https://pulkomandy.tk/wiki/doku.php?id=documentations:start>

I added 3 linker targets to Inufuto's tools (in tools/asm8-1.5.0/Linker/Thomson*.cs):
* Floppy disk (.fd)
* Audio tape (.k7)
* ROM cartridge (.m7)

I ported 9 games so far, with minimal changes to the graphics most of the time, so there are a few color conflics because the graphic mode compatible with the whole Thomson range only supports 2 colors for 8 pixels. I had to change the color to monochrome in the battlot, aerial and impetus games.

