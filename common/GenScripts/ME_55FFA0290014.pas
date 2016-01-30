unit ExportSeparatedByMainTest;
 {* ������� � NSRC, ���������� �� �����, � ������� �������� DivideBy }

// ������: "w:\archi\source\projects\ImportExportTest\ExportSeparatedByMainTest.pas"
// ���������: "TestCase"

{$Include ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedByMainTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �����, � ������� �������� DivideBy }
  protected
   procedure TuneExportPipe; override;
    {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportSeparatedByMainTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TExportSeparatedByMainTest.TuneExportPipe;
 {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
//#UC START# *55EEA16603AE_55FFA0290014_var*
//#UC END# *55EEA16603AE_55FFA0290014_var*
begin
//#UC START# *55EEA16603AE_55FFA0290014_impl*
 Pipe.AllPartsDivideBy([edbAccGroup]);
//#UC END# *55EEA16603AE_55FFA0290014_impl*
end;//TExportSeparatedByMainTest.TuneExportPipe

function TExportSeparatedByMainTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedByMainTest.GetFolder

function TExportSeparatedByMainTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55FFA0290014';
end;//TExportSeparatedByMainTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportSeparatedByMainTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
