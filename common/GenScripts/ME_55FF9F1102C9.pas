unit ExportToSingleNSRTest;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSingleNSRTest = class(TExportPipeTestPrim)
  {* ������� � ���� NSRC }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportToSingleNSRTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
