unit evGeneratorsInterfaces;
 {* ���������� ��� ��������� ������ ����������� }

// ������: "w:\common\components\gui\Garant\Everest\evGeneratorsInterfaces.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Base
 , l3Variant
 , nevBase
;

type
 IevTextPainter = interface
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

 IevJoinGenerator = interface
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

 IevNSRCExport = interface
  ['{E627D909-251B-410E-95CF-C8BAD64F222A}']
  procedure SetExportDirectory(const aDirName: AnsiString);
  procedure SetExternalDocHandle(anID: Integer);
 end;//IevNSRCExport

implementation

uses
 l3ImplUses
;

end.
