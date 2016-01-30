unit TableToolsTest;
 {* Тесты инструментов работы с таблицами }

// Модуль: "w:\common\components\rtl\Garant\Daily\TableToolsTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

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
 {$Include CursorMover.imp.pas}
 _SelectTablePart_Parent_ = _CursorMover_;
 {$Include SelectTablePart.imp.pas}
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
;

{$Include CursorMover.imp.pas}

{$Include SelectTablePart.imp.pas}

{$If NOT Defined(NoVCM)}
procedure TTableToolsTest.CheckOperation(aForm: TPrimTextLoadForm);
 {* Проверка после применения инструмента. }
//#UC START# *4C9999C50326_4C345A91014E_var*
//#UC END# *4C9999C50326_4C345A91014E_var*
begin
//#UC START# *4C9999C50326_4C345A91014E_impl*
 
//#UC END# *4C9999C50326_4C345A91014E_impl*
end;//TTableToolsTest.CheckOperation
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

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
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
