unit ExportByMainRelNamedTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SimpleTests"
// ������: "W:/archi/source/projects/ImportExportTest/ExportByMainRelNamedTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::SimpleTests::ExportPipeTests::ExportByMainRelNamedTest
//
// ������� ���������� � ���� NSRC �� ���������, ���������� �� ������ � ������� ������� �����.
// (DivideBy = divNone)
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
 TExportByMainRelNamedTest = class(TExportPipeTestPrim)
  {* ������� ���������� � ���� NSRC �� ���������, ���������� �� ������ � ������� ������� �����. (DivideBy = divNone) }
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
 end;//TExportByMainRelNamedTest
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

// start class TExportByMainRelNamedTest

procedure TExportByMainRelNamedTest.TuneExportPipe;
//#UC START# *55EEA16603AE_55FFA1DB00DB_var*
//#UC END# *55EEA16603AE_55FFA1DB00DB_var*
begin
//#UC START# *55EEA16603AE_55FFA1DB00DB_impl*
 Pipe.AllPartsDivideBy([]);
 Pipe.FileMask[edpReference] := l3CStr('rel_%main%');
//#UC END# *55EEA16603AE_55FFA1DB00DB_impl*
end;//TExportByMainRelNamedTest.TuneExportPipe

function TExportByMainRelNamedTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'ExportPipeTests';
end;//TExportByMainRelNamedTest.GetFolder

function TExportByMainRelNamedTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '55FFA1DB00DB';
end;//TExportByMainRelNamedTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TExportByMainRelNamedTest.Suite);

end.