unit nevGarbageInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/nevGarbageInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::nevGarbageInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  afwInterfaces
  ;

(*
 MnevFontTool = PureMixIn
   function GetObjRealFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* �������� ����� �������. }
   function GetObjIFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aParentFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* �������� ����� �������. }
 end;//MnevFontTool
*)

type
 InevFontTool = interface(IafwFontCache)
  {* ��� �������. }
   ['{18AC2452-9182-4E5E-A089-AEDFDD334089}']
  // MnevFontTool
   function GetObjRealFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* �������� ����� �������. }
   function GetObjIFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aParentFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* �������� ����� �������. }
 end;//InevFontTool

implementation

end.