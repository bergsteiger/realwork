unit ExportSeparatedBySizeTest;
 {* ������� � NSRC, ���������� �� ������� � ������� �������� DivideBy }

// ������: "w:\archi\source\projects\ImportExportTest\ExportSeparatedBySizeTest.pas"
// ���������: "TestCase"
// ������� ������: "ExportSeparatedBySizeTest" MUID: (55FFA0650118)
// ��� ����: "TExportSeparatedBySizeTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� ������� � ������� �������� DivideBy }
  protected
   procedure TuneExportPipe; override;
    {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportSeparatedBySizeTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
;

procedure TExportSeparatedBySizeTest.TuneExportPipe;
 {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
//#UC START# *55EEA16603AE_55FFA0650118_var*
//#UC END# *55EEA16603AE_55FFA0650118_var*
begin
//#UC START# *55EEA16603AE_55FFA0650118_impl*
 Pipe.AllPartsDivideBy([edbSize]);
 Pipe.OutputFileSize := 4096;
//#UC END# *55EEA16603AE_55FFA0650118_impl*
end;//TExportSeparatedBySizeTest.TuneExportPipe

function TExportSeparatedBySizeTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedBySizeTest.GetFolder

function TExportSeparatedBySizeTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55FFA0650118';
end;//TExportSeparatedBySizeTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportSeparatedBySizeTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
