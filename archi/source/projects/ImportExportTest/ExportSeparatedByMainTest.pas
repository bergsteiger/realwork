unit ExportSeparatedByMainTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SimpleTests"
// ������: "W:/archi/source/projects/ImportExportTest/ExportSeparatedByMainTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportSeparatedByMainTest
//
// ������� � NSRC, ���������� �� �����, � ������� �������� DivideBy
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include W:\archi\source\projects\ImportExportTest.inc}

interface

{$If defined(nsTest)}
uses
  ExportPipeTestPrim
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TExportSeparatedByMainTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �����, � ������� �������� DivideBy }
 protected
 // realized methods
   procedure TuneExportPipe; override;
     {* ��������� ��������� �����. ����� ��� ���������� � ��������. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TExportSeparatedByMainTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  TestFrameWork,
  ddPipeOutInterfaces,
  l3Base
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TExportSeparatedByMainTest

procedure TExportSeparatedByMainTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFA0290014_var*
//#UC END# *55EEA16603AE_55FFA0290014_var*
begin
//#UC START# *55EEA16603AE_55FFA0290014_impl*
 Pipe.AllPartsDivideBy([edbAccGroup]);
//#UC END# *55EEA16603AE_55FFA0290014_impl*
end;//TExportSeparatedByMainTest.TuneExportPipe

function TExportSeparatedByMainTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedByMainTest.GetFolder

function TExportSeparatedByMainTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFA0290014';
end;//TExportSeparatedByMainTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportSeparatedByMainTest.Suite);

end.