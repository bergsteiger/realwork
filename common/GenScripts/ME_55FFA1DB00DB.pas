unit ExportByMainRelNamedTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* ������� ���������� � ���� NSRC �� ���������, ���������� �� ������ � ������� ������� �����. (DivideBy = divNone) }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportByMainRelNamedTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
