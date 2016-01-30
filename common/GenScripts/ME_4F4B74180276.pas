unit nevGarbageInterfaces;

// ������: "w:\common\components\gui\Garant\Everest\nevGarbageInterfaces.pas"
// ���������: "Interfaces"

{$Include evDefine.inc}

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
   CorrectItalic: Boolean = True): InevFont;
   {* �������� ����� �������. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* �������� ����� �������. }
 end;//MnevFontTool
 *)

type
 InevFontTool = interface(IafwFontCache)
  {* ��� �������. }
  ['{18AC2452-9182-4E5E-A089-AEDFDD334089}']
  function GetObjRealFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* �������� ����� �������. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* �������� ����� �������. }
 end;//InevFontTool

implementation

uses
 l3ImplUses
;

end.
