unit evResultFontInterfaces;

interface

uses
 l3IntfUses
 , evResultFont
 , l3Interfaces
 , l3Core
 , l3Variant
;

type
 IevResultFont = interface
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
 end;//IevResultFont
 
implementation

uses
 l3ImplUses
;

end.
