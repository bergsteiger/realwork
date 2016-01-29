unit DeleteColumnToolTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/DeleteColumnToolTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TDeleteColumnToolTest
//
// ���� �������� ������� ����� ��������
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TDeleteColumnToolTest = {abstract} class(TTextViaEditorProcessor)
  {* ���� �������� ������� ����� �������� }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TDeleteColumnToolTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  nevTools,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TDeleteColumnToolTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TDeleteColumnToolTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4CC6E92E0233_var*
var
 l_Selection : InevSelection;
//#UC END# *4BE13147032C_4CC6E92E0233_var*
begin
//#UC START# *4BE13147032C_4CC6E92E0233_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) then
 begin
  evSelectTableColumn(l_Selection, aForm.Text.Document.Para[0].AsList, 2);
  aForm.Text.DeleteColumn;
 end; // if (l_Selection <> nil) then
//#UC END# *4BE13147032C_4CC6E92E0233_impl*
end;//TDeleteColumnToolTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TDeleteColumnToolTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TDeleteColumnToolTest.GetFolder

function TDeleteColumnToolTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CC6E92E0233';
end;//TDeleteColumnToolTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.