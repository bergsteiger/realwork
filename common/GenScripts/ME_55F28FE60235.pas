unit ExportToSeparateNSRTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSeparateNSRTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �������. }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportToSeparateNSRTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
