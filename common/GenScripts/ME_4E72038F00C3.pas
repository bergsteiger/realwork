unit nevFontTool.imp;

interface

uses
 l3IntfUses
 , nevGarbageInterfaces
 , evResultFontInterfaces
 , l3Variant
 , nevBase
;

type
 _nevFontTool_ = class(Ml3Unknown)
  function DocumentUseFixedFontForPrintAndExportSetting: Boolean;
  function GetObjFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): IevResultFont;
  function GetObjRealFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): InevFont;
   {* получить шрифт объекта. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): InevFont;
   {* получить шрифт объекта. }
 end;//_nevFontTool_
 
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
