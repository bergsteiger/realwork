unit TableToolsTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/TableToolsTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TTableToolsTest
//
// Тесты инструментов работы с таблицами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TableToolsTestPrim
  {$IfEnd} //nsTest AND not NoVCM
  ,
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
 _CursorMover_Parent_ = TTableToolsTestPrim;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _SelectTablePart_Parent_ = _CursorMover_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}
 TTableToolsTest = {abstract} class(_SelectTablePart_)
  {* Тесты инструментов работы с таблицами }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
     {* Проверка после применения инструмента. }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TTableToolsTest
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

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\SelectTablePart.imp.pas}

// start class TTableToolsTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTableToolsTest.CheckOperation(aForm: TPrimTextLoadForm);
//#UC START# *4C9999C50326_4C345A91014E_var*
//#UC END# *4C9999C50326_4C345A91014E_var*
begin
//#UC START# *4C9999C50326_4C345A91014E_impl*
 
//#UC END# *4C9999C50326_4C345A91014E_impl*
end;//TTableToolsTest.CheckOperation
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTableToolsTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C345A91014E_var*
//#UC END# *4BE13147032C_4C345A91014E_var*
begin
//#UC START# *4BE13147032C_4C345A91014E_impl*
 MakeSelection(aForm.Text);
 inherited Process(aForm);
//#UC END# *4BE13147032C_4C345A91014E_impl*
end;//TTableToolsTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TTableToolsTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTableToolsTest.GetFolder

function TTableToolsTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C345A91014E';
end;//TTableToolsTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.