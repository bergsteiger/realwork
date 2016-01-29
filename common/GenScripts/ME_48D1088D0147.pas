unit nevFontPrim;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , l3Interfaces
 , nevBase
 , l3Variant
;

type
 TnevFontPrim = class(Tl3CacheableBase, InevFontPrim)
  function SubFont(const aFont: InevFontPrim): Boolean;
   {* вычитает шрифт. }
  function AsFont(CorrectItalic: Boolean): Il3Font;
   {* преобразует к Il3Font. }
  function GetParam(ItemIndex: TnevFontParam): Integer;
  procedure Set2Font(const aFont: Il3Font;
   CorrectItalic: Boolean);
   {* присваивает себя Il3Font. }
  function Empty: Boolean;
  procedure MakeFontArray(BlockFont: Boolean);
  procedure InitFromTag(aTag: Tl3Variant);
 end;//TnevFontPrim
 
implementation

uses
 l3ImplUses
;

end.
