unit ExportToSeparateNSRTest;
 {* ������� � NSRC, ���������� �� �������. }

// ������: "w:\archi\source\projects\ImportExportTest\ExportToSeparateNSRTest.pas"
// ���������: "TestCase"
// ������� ������: "ExportToSeparateNSRTest" MUID: (55F28FE60235)
// ��� ����: "TExportToSeparateNSRTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSeparateNSRTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �������. }
  protected
   procedure TuneExportPipe; override;
    {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportToSeparateNSRTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
;

procedure TExportToSeparateNSRTest.TuneExportPipe;
 {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
//#UC START# *55EEA16603AE_55F28FE60235_var*
//#UC END# *55EEA16603AE_55F28FE60235_var*
begin
//#UC START# *55EEA16603AE_55F28FE60235_impl*
 Pipe.AllPartsDivideBy([edbTopic]);
//#UC END# *55EEA16603AE_55F28FE60235_impl*
end;//TExportToSeparateNSRTest.TuneExportPipe

function TExportToSeparateNSRTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ExportPipeTests';
end;//TExportToSeparateNSRTest.GetFolder

function TExportToSeparateNSRTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55F28FE60235';
end;//TExportToSeparateNSRTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportToSeparateNSRTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
