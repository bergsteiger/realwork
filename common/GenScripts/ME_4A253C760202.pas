unit evGeneratorsInterfaces;

interface

uses
 l3IntfUses
 , l3Base
 , l3Variant
 , nevBase
;

type
 IevTextPainter = interface
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
   aValidateText: Tl3String);
   {* ��������� ������ �� ������� ���������� ��������� "������� ����" � "�� ������� � ����" � ���� �������� ���������� �� (������������ �� ����� ������). ���� aValidateText <> nil ��������� �� ���� ������, � aText ������ ��������. }
  function IsStyleEqual(aParaStyle: Integer;
   aSegmentStyle: Integer): Boolean;
   {* ���������� ��� ����� � ����� ������ ������� � NSRC. }
 end;//IevTextPainter
 
 IevJoinGenerator = interface
  {* ������ ������������ ���� �� ���������� ��������� ��� ������� }
 end;//IevJoinGenerator
 
 IevNSRCExport = interface
  procedure SetExportDirectory(const aDirName: AnsiString);
  procedure SetExternalDocHandle(anID: Integer);
 end;//IevNSRCExport
 
implementation

uses
 l3ImplUses
;

end.
