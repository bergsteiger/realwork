unit TableToolsTest;
 {* Тесты инструментов работы с таблицами }

// Модуль: "w:\common\components\rtl\Garant\Daily\TableToolsTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TableToolsTestPrim
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 , evCustomEditorWindow
;

type
 _CursorMover_Parent_ = TTableToolsTestPrim;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _SelectTablePart_Parent_ = _CursorMover_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TTableToolsTest = {abstract} class(_SelectTablePart_)
  {* Тесты инструментов работы с таблицами }
  protected
   {$If NOT Defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
    {* Проверка после применения инструмента. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* Собственно процесс обработки текста }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TTableToolsTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
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
 , l3Base
;

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

procedure TTableToolsTest.CheckOperation(aForm: TPrimTextLoadForm);
 {* Проверка после применения инструмента. }
//#UC START# *4C9999C50326_4C345A91014E_var*
//#UC END# *4C9999C50326_4C345A91014E_var*
begin
//#UC START# *4C9999C50326_4C345A91014E_impl*
 
//#UC END# *4C9999C50326_4C345A91014E_impl*
end;//TTableToolsTest.CheckOperation

procedure TTableToolsTest.Process(aForm: TPrimTextLoadForm);
 {* Собственно процесс обработки текста }
//#UC START# *4BE13147032C_4C345A91014E_var*
//#UC END# *4BE13147032C_4C345A91014E_var*
begin
//#UC START# *4BE13147032C_4C345A91014E_impl*
 MakeSelection(aForm.Text);
 inherited Process(aForm);
//#UC END# *4BE13147032C_4C345A91014E_impl*
end;//TTableToolsTest.Process

function TTableToolsTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TTableToolsTest.GetFolder

function TTableToolsTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C345A91014E';
end;//TTableToolsTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
