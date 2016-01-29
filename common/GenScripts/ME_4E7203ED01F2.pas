unit nevFontTool;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevGarbageInterfaces
;

type
 TnevFontTool = class(Tl3CProtoObject, InevFontTool)
  procedure Create;
  function Make: InevFontTool;
 end;//TnevFontTool
 
implementation

uses
 l3ImplUses
 , evStandardStyles
 , SysUtils
 , evResultFontHolder
 , evDef
 , evdTypes
 , nevTools
 , evStyleInterface
 , k2Tags
 , k2Const
 , evParaTools
 , l3Base
 , evDefaultStylesFontSizes
 , l3MinMax
 , ObjectSegment_Const
 , l3Types
 , Table_Const
 , l3Math
 , evGlyphFont
 , BitmapPara_Const
;

end.
