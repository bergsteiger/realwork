unit evStandardStyles;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , evStandardStylesList
 , l3Variant
 , evResultFontInterfaces
 , evdStyles
 , evStandardStylesListPrim
;

type
 TevStandardStylesCacheByID = array [TevStandardCachedStyle] of TevStandardStylesCacheByJustification;
 
 TevStandardStyles = class(_evStyleTableListener_, IafwFontCache)
  {* Стандартные стили }
  function GetStandardStyleFont(aPara: Tl3Variant;
   aFixedFont: Boolean;
   out theFont: IevResultFont): Boolean;
  procedure FreeFonts;
  function GetStyleFont(aStyle: Tl3Variant;
   aPrinting: Boolean): IevResultFont;
  procedure CheckFontInCache(anObj: Tl3Variant;
   anID: Integer;
   aJust: Boolean;
   aVis: Boolean;
   aFixedFont: Boolean;
   out theFont: IevResultFont);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure DoStyleTableChanged;
 end;//TevStandardStyles
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , l3Base
 , evDefaultStylesFontSizes
 , SysUtils
 , evStyleInterface
 , k2Const
 , evResultFontHolder
 , evStyleTableSpy
;

end.
