unit Translate2TextTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/Translate2TextTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TTranslate2TextTest
//
// ������������� ������� ��� � ����� � �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TableToolsTest,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TTranslate2TextTest = {abstract} class(TTableToolsTest)
  {* ������������� ������� ��� � ����� � ����� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* ������� ���������� ��� ������� }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTranslate2TextTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TTranslate2TextTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTranslate2TextTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C3463D800E5_var*
//#UC END# *4C345B580083_4C3463D800E5_var*
begin
//#UC START# *4C345B580083_4C3463D800E5_impl*
 aRange.Table.Cells.Translate2Text;
//#UC END# *4C345B580083_4C3463D800E5_impl*
end;//TTranslate2TextTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

function TTranslate2TextTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTranslate2TextTest.GetFolder

function TTranslate2TextTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3463D800E5';
end;//TTranslate2TextTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.