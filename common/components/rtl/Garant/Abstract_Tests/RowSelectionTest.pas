unit RowSelectionTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Abstract Tests"
// ������: "w:/common/components/rtl/Garant/Abstract_Tests/RowSelectionTest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TRowSelectionTest
//
// ���� ��������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evCustomEditorWindow,
  l3Units,
  nevTools,
  nevGUIInterfaces
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _ClipboardOperations_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _MouseClickOnPoint_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickOnPoint.imp.pas}
 TRowSelectionTest = {abstract} class(_MouseClickOnPoint_)
  {* ���� ��������� ������. }
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
 end;//TRowSelectionTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\MouseClickOnPoint.imp.pas}

// start class TRowSelectionTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TRowSelectionTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4E12DCB800E4_var*
//#UC END# *4BE13147032C_4E12DCB800E4_var*
begin
//#UC START# *4BE13147032C_4E12DCB800E4_impl*
 ClickOnPoint(aForm.Text, False);
 CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4BE13147032C_4E12DCB800E4_impl*
end;//TRowSelectionTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TRowSelectionTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TRowSelectionTest.GetFolder

function TRowSelectionTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E12DCB800E4';
end;//TRowSelectionTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.