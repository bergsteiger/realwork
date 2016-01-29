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
   {* �������� ����� �������. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): InevFont;
   {* �������� ����� �������. }
 end;//MnevFontTool
 *)
 
type
 InevFontTool = interface(IafwFontCache)
  {* ��� �������. }
  function GetObjRealFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): InevFont;
   {* �������� ����� �������. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean): InevFont;
   {* �������� ����� �������. }
 end;//InevFontTool
 
implementation

uses
 l3ImplUses
;

end.
