MODULE Allegro5Colors;
IMPORT Al := Allegro5Lib;

PROCEDURE MapRGBA*(r, g, b, a: INTEGER; OUT c: Al.Color);
BEGIN
  c.r := SHORT(r / 255);
  c.g := SHORT(g / 255);
  c.b := SHORT(b / 255);
  c.a := SHORT(a / 255)
END MapRGBA;

PROCEDURE MapRGB*(r, g, b: INTEGER; OUT c: Al.Color);
BEGIN
  c.r := SHORT(r / 255);
  c.g := SHORT(g / 255);
  c.b := SHORT(b / 255);
  c.a := 1.0
END MapRGB;

END Allegro5Colors.