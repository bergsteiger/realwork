unit ExportBySizeAndMain;

interface

uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportBySizeAndMain = class(TExportPipeTestPrim)
  {* �������, ���������� �� ������� � ����� (���� - � �������� ��� ������) }
  procedure TuneExportPipe;
   {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 end;//TExportBySizeAndMain
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
