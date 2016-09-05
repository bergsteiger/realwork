unit K200902351;
 {* [$200902351] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K200902351.pas"
// Стереотип: "TestCase"
// Элемент модели: "K200902351" MUID: (4C383752005F)
// Имя типа: "TK200902351"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TableSelectTest
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK200902351 = class({$If NOT Defined(NoVCM)}
 TTableSelectTest
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [$200902351] }
  protected
   {$If NOT Defined(NoVCM)}
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SelectColumn(var aColID: Integer): Boolean; override;
    {* Выделить колонку aColID }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK200902351
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4C383752005Fimpl_uses*
 //#UC END# *4C383752005Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
function TK200902351.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4C346D4B0351_4C383752005F_var*
//#UC END# *4C346D4B0351_4C383752005F_var*
begin
//#UC START# *4C346D4B0351_4C383752005F_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4C346D4B0351_4C383752005F_impl*
end;//TK200902351.GetTablePara

procedure TK200902351.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
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

function TK200902351.SelectColumn(var aColID: Integer): Boolean;
 {* Выделить колонку aColID }
//#UC START# *4C382DC50185_4C383752005F_var*
//#UC END# *4C382DC50185_4C383752005F_var*
begin
//#UC START# *4C382DC50185_4C383752005F_impl*
 Result := True;
 aColID := 2;
//#UC END# *4C382DC50185_4C383752005F_impl*
end;//TK200902351.SelectColumn

function TK200902351.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK200902351.GetFolder

function TK200902351.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C383752005F';
end;//TK200902351.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200902351.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
