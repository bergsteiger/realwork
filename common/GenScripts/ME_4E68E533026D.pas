unit evResultFontHolder;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , evResultFontInterfaces
 , evResultFont
 , l3Interfaces
 , l3Core
 , l3Variant
;

type
 TevResultFontHolder = class(Tl3CProtoObject, IevResultFont)
  procedure Create;
  function Make: IevResultFont;
  function Font: PevResultFontEx;
  procedure Clear;
  function AsFont(aCorrectItalic: Boolean;
   aCheckNew: Boolean): Il3Font;
  procedure AddStyledTag(aTag: Tl3Variant);
  function GetItem(anIndex: Integer): PInteger;
  procedure SetItem(anIndex: Integer;
   aValue: Integer);
  function IsTransparent(anIndex: Integer): Boolean;
  procedure AddTag(aTag: Tl3Variant);
  procedure AddFont(const aFont: IevResultFont);
 end;//TevResultFontHolder
 
implementation

uses
 l3ImplUses
 , k2Const
;

end.
