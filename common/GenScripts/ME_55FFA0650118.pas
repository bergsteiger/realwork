unit ExportSeparatedBySizeTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� ������� � ������� �������� DivideBy }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportSeparatedBySizeTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
