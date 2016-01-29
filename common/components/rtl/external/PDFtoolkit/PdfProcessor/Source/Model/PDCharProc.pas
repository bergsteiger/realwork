unit PDCharProc;

interface

uses
  gtObject, PDElement, PDBaseObject;

type
 (**
  * A PDCharProc is a character procedure, which is a stream of graphic operators
  * (see PDGraphic) that draw a particular glyph of a Type 3 PostScript font.
  *
  * A glyph is the visual representation of a character, part of a character, or
  * even multiple characters. For example, a glyph can be a picture of the letter
  * A, it can be an accent mark, such as grave (`), or it can be a picture of
  * multiple characters such as the ligature fl, which represents the letters f
  * and l. Glyphs can also be used to represent arbitrary symbols, such as in
  * the font ITC Zapf Dingbats®. Every glyph has a name in a Type 1, Multiple
  * Master Type 1, or Type 3 font. In most TrueType fonts, glyphs are assigned
  * names. In some TrueType fonts, the glyph names are implicit.
  *
  * To determine the sequence of graphics operations used to draw one or more
  * glyphs in a Type 3 font, use TgtPDFont.EnumumerateCharProcs() to enumerate
  * the glyphs in the font. Then use TgtPDCharProc.Enumumerate() to enumerate
  * the graphic operators in each glyph of interest.
  *)
  TgtPDCharProc = class(TgtPDElement)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    procedure Update; override;



  end;

implementation

{ TgtPDCharProc }

constructor TgtPDCharProc.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

destructor TgtPDCharProc.Destroy;
begin

  inherited;
end;

procedure TgtPDCharProc.Update;
begin
  inherited;

end;

end.
