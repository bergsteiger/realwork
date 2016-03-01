unit MergeAndCheckSelectionTest;
 {* Тест проверки выделения после объединения ячеек. }

// Модуль: "w:\common\components\rtl\Garant\Daily\MergeAndCheckSelectionTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , evCustomEditorWindow
;

type
 _ClipboardOperations_Parent_ = TMergeCellsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TMergeAndCheckSelectionTest = {abstract} class(_SelectOperation_)
  {* Тест проверки выделения после объединения ячеек. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
    {* Проверка после применения инструмента. }
   {$IfEnd} // NOT Defined(NoVCM)
   function NeedSelection: Boolean; override;
    {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TMergeAndCheckSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , evTypes
 , evMsgCode
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

function TMergeAndCheckSelectionTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TMergeAndCheckSelectionTest.GetFolder

{$If NOT Defined(NoVCM)}
procedure TMergeAndCheckSelectionTest.CheckOperation(aForm: TPrimTextLoadForm);
 {* Проверка после применения инструмента. }
//#UC START# *4C9999C50326_4CE133F801BA_var*
//#UC END# *4C9999C50326_4CE133F801BA_var*
begin
//#UC START# *4C9999C50326_4CE133F801BA_impl*
 if aForm.Text.HasSelection then
  CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4C9999C50326_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.CheckOperation
{$IfEnd} // NOT Defined(NoVCM)

function TMergeAndCheckSelectionTest.NeedSelection: Boolean;
 {* Нужно ли чего-нибудь выделять. }
//#UC START# *4CC8189D02DF_4CE133F801BA_var*
//#UC END# *4CC8189D02DF_4CE133F801BA_var*
begin
//#UC START# *4CC8189D02DF_4CE133F801BA_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.NeedSelection

function TMergeAndCheckSelectionTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CE133F801BA';
end;//TMergeAndCheckSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
