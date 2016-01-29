unit ExportToSeparateNSRTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SimpleTests"
// ������: "W:/archi/source/projects/ImportExportTest/ExportToSeparateNSRTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportToSeparateNSRTest
//
// ������� � NSRC, ���������� �� �������.
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
 TExportToSeparateNSRTest = class(TExportPipeTestPrim)
  {* ������� � NSRC, ���������� �� �������. }
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
 end;//TExportToSeparateNSRTest
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

// start class TExportToSeparateNSRTest

procedure TExportToSeparateNSRTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55F28FE60235_var*
//#UC END# *55EEA16603AE_55F28FE60235_var*
begin
//#UC START# *55EEA16603AE_55F28FE60235_impl*
 Pipe.AllPartsDivideBy([edbTopic]);
//#UC END# *55EEA16603AE_55F28FE60235_impl*
end;//TExportToSeparateNSRTest.TuneExportPipe

function TExportToSeparateNSRTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportToSeparateNSRTest.GetFolder

function TExportToSeparateNSRTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55F28FE60235';
end;//TExportToSeparateNSRTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportToSeparateNSRTest.Suite);

end.