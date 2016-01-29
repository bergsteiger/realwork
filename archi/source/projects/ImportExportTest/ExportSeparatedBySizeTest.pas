unit ExportSeparatedBySizeTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SimpleTests"
// ������: "W:/archi/source/projects/ImportExportTest/ExportSeparatedBySizeTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportSeparatedBySizeTest
//
// ������� � NSRC, ���������� �� ������� � ������� �������� DivideBy
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
 TExportSeparatedBySizeTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� ������� � ������� �������� DivideBy }
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
 end;//TExportSeparatedBySizeTest
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

// start class TExportSeparatedBySizeTest

procedure TExportSeparatedBySizeTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFA0650118_var*
//#UC END# *55EEA16603AE_55FFA0650118_var*
begin
//#UC START# *55EEA16603AE_55FFA0650118_impl*
 Pipe.AllPartsDivideBy([edbSize]);
 Pipe.OutputFileSize := 4096;
//#UC END# *55EEA16603AE_55FFA0650118_impl*
end;//TExportSeparatedBySizeTest.TuneExportPipe

function TExportSeparatedBySizeTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportSeparatedBySizeTest.GetFolder

function TExportSeparatedBySizeTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFA0650118';
end;//TExportSeparatedBySizeTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportSeparatedBySizeTest.Suite);

end.