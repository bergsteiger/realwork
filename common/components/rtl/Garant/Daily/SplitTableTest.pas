unit SplitTableTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/SplitTableTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSplitTableTest
//
// Тесты разбиения таблиц
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
  TableToolsTest
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evEditorInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTableToolsTest;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TSplitTableTest = {abstract} class(_CursorMover_)
  {* Тесты разбиения таблиц }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure ApplyTools(const aRange: IedRange); override;
     {* Вызвать инструмент для таблицы }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function NeedSelection: Boolean; override;
     {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetLineCount: Integer; virtual;
     {* Количество строчек (текста), на которое нужно сдинуть курсор перед разбиванием табилцы на две. }
 end;//TSplitTableTest
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

// start class TSplitTableTest

function TSplitTableTest.GetLineCount: Integer;
//#UC START# *4C6CFAE20264_4C6CF18001AE_var*
//#UC END# *4C6CFAE20264_4C6CF18001AE_var*
begin
//#UC START# *4C6CFAE20264_4C6CF18001AE_impl*
 Result := 0;
//#UC END# *4C6CFAE20264_4C6CF18001AE_impl*
end;//TSplitTableTest.GetLineCount

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSplitTableTest.ApplyTools(const aRange: IedRange);
//#UC START# *4C345B580083_4C6CF18001AE_var*
//#UC END# *4C345B580083_4C6CF18001AE_var*
begin
//#UC START# *4C345B580083_4C6CF18001AE_impl*
 aRange.Table.Split(nil);
//#UC END# *4C345B580083_4C6CF18001AE_impl*
end;//TSplitTableTest.ApplyTools
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSplitTableTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C6CF18001AE_var*
var
 i: Integer;
//#UC END# *4BE419AF0217_4C6CF18001AE_var*
begin
//#UC START# *4BE419AF0217_4C6CF18001AE_impl*
 aForm.Text.Repaint;
 for i := 0 to GetLineCount - 1 do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 inherited DoVisit(aForm);
//#UC END# *4BE419AF0217_4C6CF18001AE_impl*
end;//TSplitTableTest.DoVisit
{$IfEnd} //nsTest AND not NoVCM

function TSplitTableTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSplitTableTest.GetFolder

function TSplitTableTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4C6CF18001AE_var*
//#UC END# *4CC8189D02DF_4C6CF18001AE_var*
begin
//#UC START# *4CC8189D02DF_4C6CF18001AE_impl*
 Result := False;
//#UC END# *4CC8189D02DF_4C6CF18001AE_impl*
end;//TSplitTableTest.NeedSelection

function TSplitTableTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6CF18001AE';
end;//TSplitTableTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.