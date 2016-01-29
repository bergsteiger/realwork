unit TextMericsAfterDeleteTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/TextMericsAfterDeleteTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TTextMericsAfterDeleteTest
//
// �������� ������ ����� ��������.
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
  TextMetricsTest,
  nevTools,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _SelectTablePart_Parent_ = TTextMetricsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TTextMericsAfterDeleteTest = {abstract} class(_SelectTablePart_)
  {* �������� ������ ����� ��������. }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* ���������� ������� ��������� ������ }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   function NeedSelection: Boolean; override;
     {* ����� �� ����-������ ��������. }
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
 end;//TTextMericsAfterDeleteTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

// start class TTextMericsAfterDeleteTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTextMericsAfterDeleteTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D1B16D302DD_var*
//#UC END# *4BE13147032C_4D1B16D302DD_var*
begin
//#UC START# *4BE13147032C_4D1B16D302DD_impl*
 MakeSelection(aForm.Text);
 aForm.Text.Range.Delete;
//#UC END# *4BE13147032C_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TTextMericsAfterDeleteTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextMericsAfterDeleteTest.GetFolder

function TTextMericsAfterDeleteTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4D1B16D302DD_var*
//#UC END# *4CC8189D02DF_4D1B16D302DD_var*
begin
//#UC START# *4CC8189D02DF_4D1B16D302DD_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4D1B16D302DD_impl*
end;//TTextMericsAfterDeleteTest.NeedSelection

function TTextMericsAfterDeleteTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D1B16D302DD';
end;//TTextMericsAfterDeleteTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.