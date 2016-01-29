unit ExportToSingleNSRTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SimpleTests"
// ������: "W:/archi/source/projects/ImportExportTest/ExportToSingleNSRTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportToSingleNSRTest
//
// ������� � ���� NSRC
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
 TExportToSingleNSRTest = class(TExportPipeTestPrim)
  {* ������� � ���� NSRC }
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
 end;//TExportToSingleNSRTest
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

// start class TExportToSingleNSRTest

procedure TExportToSingleNSRTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FF9F1102C9_var*
//#UC END# *55EEA16603AE_55FF9F1102C9_var*
begin
//#UC START# *55EEA16603AE_55FF9F1102C9_impl*
 Pipe.AllPartsDivideBy([]);
//#UC END# *55EEA16603AE_55FF9F1102C9_impl*
end;//TExportToSingleNSRTest.TuneExportPipe

function TExportToSingleNSRTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportToSingleNSRTest.GetFolder

function TExportToSingleNSRTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FF9F1102C9';
end;//TExportToSingleNSRTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportToSingleNSRTest.Suite);

end.