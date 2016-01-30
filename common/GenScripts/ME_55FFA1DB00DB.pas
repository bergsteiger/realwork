unit ExportByMainRelNamedTest;
 {* ������� ���������� � ���� NSRC �� ���������, ���������� �� ������ � ������� ������� �����. (DivideBy = divNone) }

// ������: "w:\archi\source\projects\ImportExportTest\ExportByMainRelNamedTest.pas"
// ���������: "TestCase"

{$Include ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* ������� ���������� � ���� NSRC �� ���������, ���������� �� ������ � ������� ������� �����. (DivideBy = divNone) }
  protected
   procedure TuneExportPipe; override;
    {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportByMainRelNamedTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
;

procedure TExportByMainRelNamedTest.TuneExportPipe;
 {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
//#UC START# *55EEA16603AE_55FFA1DB00DB_var*
//#UC END# *55EEA16603AE_55FFA1DB00DB_var*
begin
//#UC START# *55EEA16603AE_55FFA1DB00DB_impl*
 Pipe.AllPartsDivideBy([]);
 Pipe.FileMask[edpReference] := l3CStr('rel_%main%');
//#UC END# *55EEA16603AE_55FFA1DB00DB_impl*
end;//TExportByMainRelNamedTest.TuneExportPipe

function TExportByMainRelNamedTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ExportPipeTests';
end;//TExportByMainRelNamedTest.GetFolder

function TExportByMainRelNamedTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55FFA1DB00DB';
end;//TExportByMainRelNamedTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportByMainRelNamedTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
