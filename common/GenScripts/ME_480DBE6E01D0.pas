unit evResultFont;

interface

uses
 l3IntfUses
 , k2Tags
;

type
 TevFontArray = array [Tk2FontParam] of Integer;
 
 TevResultFont = object
 end;//TevResultFont
 
 TevResultFontEx = object(TevResultFont)
 end;//TevResultFontEx
 
 PevResultFontEx = ^TevResultFontEx;
 
implementation

uses
 l3ImplUses
;

end.
