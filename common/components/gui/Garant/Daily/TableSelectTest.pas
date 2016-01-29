unit TableSelectTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/TableSelectTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TTableSelectTest
//
// Базовый тест для работы с выделением таблицы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  nevTools,
  TextEditorVisitor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TTableSelectTest = {abstract} class(TTextEditorVisitor)
  {* Базовый тест для работы с выделением таблицы }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function GetTablePara(const aDocument: InevParaList): InevParaList; virtual; abstract;
     {* Возвращает параграф с таблицей }
   function SelectColumn(var aColID: Integer): Boolean; virtual;
     {* Выделить колонку aColID }
 end;//TTableSelectTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  evOp,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TTableSelectTest

function TTableSelectTest.SelectColumn(var aColID: Integer): Boolean;
//#UC START# *4C382DC50185_4C382CB00345_var*
//#UC END# *4C382DC50185_4C382CB00345_var*
begin
//#UC START# *4C382DC50185_4C382CB00345_impl*
 Result := False;
 aColID := 0;
//#UC END# *4C382DC50185_4C382CB00345_impl*
end;//TTableSelectTest.SelectColumn

procedure TTableSelectTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C382CB00345_var*
var
 l_ColID     : Integer;
 l_Selection : InevSelection;
//#UC END# *4BE419AF0217_4C382CB00345_var*
begin
//#UC START# *4BE419AF0217_4C382CB00345_impl*
 l_Selection := aForm.Text.Selection;
 if (l_Selection <> nil) and SelectColumn(l_ColID) then
  evSelectTableColumn(l_Selection, GetTablePara(aForm.Text.Document), l_ColID)
//#UC END# *4BE419AF0217_4C382CB00345_impl*
end;//TTableSelectTest.DoVisit

function TTableSelectTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TTableSelectTest.GetFolder

function TTableSelectTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C382CB00345';
end;//TTableSelectTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.