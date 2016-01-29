unit evGeneratorsInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evGeneratorsInterfaces.pas"
// �����: 02.06.2009 18:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::Generators::evGeneratorsInterfaces
//
// ���������� ��� ��������� ������ �����������
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
  l3Base,
  l3Variant
  ;

type
 IevTextPainter = interface(IUnknown)
   ['{4840242F-084A-4805-9EB0-90C1126C5137}']
   procedure PaintLine(ParaVisible: Boolean;
    ParaStyle: Integer;
    S: Tl3String;
    Ob: Tl3Variant;
    First: Boolean;
    Last: Boolean);
     {* ��������� ��� "��������" ��������� ������ }
   procedure ValidateLine(aLine: Tl3String;
    aCodePage: Integer);
     {* ��������� ��� �������� ������������ ������ }
   procedure ValidateText(aText: Tl3String;
    aValidateText: Tl3String = nil);
     {* ��������� ������ �� ������� ���������� ��������� "������� ����" � "�� ������� � ����" � ���� �������� ���������� �� (������������ �� ����� ������). ���� aValidateText <> nil ��������� �� ���� ������, � aText ������ ��������. }
   function IsStyleEqual(aParaStyle: Integer;
    aSegmentStyle: Integer): Boolean;
     {* ���������� ��� ����� � ����� ������ ������� � NSRC. }
 end;//IevTextPainter

 IevJoinGenerator = interface(IUnknown)
  {* ������ ������������ ���� �� ���������� ��������� ��� ������� }
   ['{8772A98D-28F8-446E-9879-9B32BE75D08D}']
   procedure pm_SetNeedJoin(aValue: Boolean);
   procedure pm_SetAtEnd(aValue: Boolean);
   procedure pm_SetNeedSkipSubDocuments(aValue: Boolean);
   procedure Set_LoadFlags(aValue: TevLoadFlags);
   property NeedJoin: Boolean
     write pm_SetNeedJoin;
     {* �������� ������������ ���� �� ���������� ��������� ��� ������� }
   property AtEnd: Boolean
     write pm_SetAtEnd;
   property NeedSkipSubDocuments: Boolean
     write pm_SetNeedSkipSubDocuments;
   property LoadFlags: TevLoadFlags
     write Set_LoadFlags;
     {* ����� �������� }
 end;//IevJoinGenerator

 IevNSRCExport = interface(IUnknown)
   ['{E627D909-251B-410E-95CF-C8BAD64F222A}']
   procedure SetExportDirectory(const aDirName: AnsiString);
   procedure SetExternalDocHandle(anID: Integer);
 end;//IevNSRCExport

implementation

end.