unit ExportToSingleNSRTest;
 {* ������� � ���� NSRC }

// ������: "w:\archi\source\projects\ImportExportTest\ExportToSingleNSRTest.pas"
// ���������: "TestCase"
// ������� ������: "ExportToSingleNSRTest" MUID: (55FF9F1102C9)
// ��� ����: "TExportToSingleNSRTest"

{$Include w:\archi\source\projects\ImportExportTest.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , ExportPipeTestPrim
;

type
 TExportToSingleNSRTest = class(TExportPipeTestPrim)
  {* ������� � ���� NSRC }
  protected
   procedure TuneExportPipe; override;
    {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportToSingleNSRTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , TestFrameWork
 , ddPipeOutInterfaces
 , l3Base
 //#UC START# *55FF9F1102C9impl_uses*
 //#UC END# *55FF9F1102C9impl_uses*
;

procedure TExportToSingleNSRTest.TuneExportPipe;
 {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
//#UC START# *55EEA16603AE_55FF9F1102C9_var*
//#UC END# *55EEA16603AE_55FF9F1102C9_var*
begin
//#UC START# *55EEA16603AE_55FF9F1102C9_impl*
 Pipe.AllPartsDivideBy([]);
//#UC END# *55EEA16603AE_55FF9F1102C9_impl*
end;//TExportToSingleNSRTest.TuneExportPipe

function TExportToSingleNSRTest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'ExportPipeTests';
end;//TExportToSingleNSRTest.GetFolder

function TExportToSingleNSRTest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '55FF9F1102C9';
end;//TExportToSingleNSRTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TExportToSingleNSRTest.Suite);
{$IfEnd} // Defined(nsTest)

end.
