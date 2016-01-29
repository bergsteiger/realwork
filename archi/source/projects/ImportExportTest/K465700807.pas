unit K465700807;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ImportExportTestLibrary"
// ������: "W:/archi/source/projects/ImportExportTest/K465700807.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$ImportExprortTest::ImportExportTestLibrary::ImportExport::TK465700807
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
  ietBaseTest,
  evdDTTypes
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TK465700807 = class(TietBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   function GetOutputFormat: TepSupportFileType; override;
 end;//TK465700807
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TK465700807

function TK465700807.GetFolder: AnsiString;
 {-}
begin
 Result := 'ImportExport';
end;//TK465700807.GetFolder

function TK465700807.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51CC0A110114';
end;//TK465700807.GetModelElementGUID

function TK465700807.GetOutputFormat: TepSupportFileType;
//#UC START# *51CBE62E006B_51CC0A110114_var*
//#UC END# *51CBE62E006B_51CC0A110114_var*
begin
//#UC START# *51CBE62E006B_51CC0A110114_impl*
 Result := outNSRC;
//#UC END# *51CBE62E006B_51CC0A110114_impl*
end;//TK465700807.GetOutputFormat

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TK465700807.Suite);

end.