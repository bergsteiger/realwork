unit K200902351;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K200902351.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K200902351
//
// [$200902351]
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
  TableSelectTest
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  ,
  nevTools
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK200902351 = class(TTableSelectTest)
  {* [$200902351] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
     {* Возвращает параграф с таблицей }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function SelectColumn(var aColID: Integer): Boolean; override;
     {* Выделить колонку aColID }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK200902351
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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

// start class TK200902351

{$If defined(nsTest) AND not defined(NoVCM)}
function TK200902351.GetTablePara(const aDocument: InevParaList): InevParaList;
//#UC START# *4C346D4B0351_4C383752005F_var*
//#UC END# *4C346D4B0351_4C383752005F_var*
begin
//#UC START# *4C346D4B0351_4C383752005F_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4C346D4B0351_4C383752005F_impl*
end;//TK200902351.GetTablePara
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TK200902351.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C383752005F_var*
var
 l_Range : InevRange;
//#UC END# *4BE419AF0217_4C383752005F_var*
begin
//#UC START# *4BE419AF0217_4C383752005F_impl*
 inherited DoVisit(aForm);
 l_Range := aForm.Text.View.Control.Selection.GetBlock;
 l_Range := l_Range.GetChildSel(aForm.Text.View, 1, False); // Таблица...
 l_Range := l_Range.GetChildSel(aForm.Text.View, 1, False); // Строка...
 l_Range := l_Range.GetChildSel(aForm.Text.View, 2, False); // Ячейка...
 CheckTrue((l_Range <> nil) and (l_Range.Obj.PID = 2) and (l_Range.Obj^.OwnerObj.PID = 1), 'Не выделили среднюю ячейку в последней колонке!');
//#UC END# *4BE419AF0217_4C383752005F_impl*
end;//TK200902351.DoVisit
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK200902351.SelectColumn(var aColID: Integer): Boolean;
//#UC START# *4C382DC50185_4C383752005F_var*
//#UC END# *4C382DC50185_4C383752005F_var*
begin
//#UC START# *4C382DC50185_4C383752005F_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C382DC50185_4C383752005F_impl*
end;//TK200902351.SelectColumn
{$IfEnd} //nsTest AND not NoVCM

function TK200902351.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK200902351.GetFolder

function TK200902351.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C383752005F';
end;//TK200902351.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK200902351.Suite);

end.