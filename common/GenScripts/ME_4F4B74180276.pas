unit nevGarbageInterfaces;

interface

uses
 l3IntfUses
 , nevBase
 , afwInterfaces
;

 (*
 MnevFontTool = interface
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
 end;//MnevFontTool
 *)
 
type
 InevFontTool = interface(IafwFontCache)
  {* Кэш шрифтов. }
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
 end;//InevFontTool
 
implementation

uses
 l3ImplUses
;

end.
