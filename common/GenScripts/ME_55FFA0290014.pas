unit ExportSeparatedByMainTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedByMainTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �����, � ������� �������� DivideBy }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportSeparatedByMainTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
