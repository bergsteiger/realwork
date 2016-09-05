unit K347636412;
 {* [Requestlink:347636412] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K347636412.pas"
// Стереотип: "TestCase"
// Элемент модели: "K347636412" MUID: (4F6C568000A6)
// Имя типа: "TK347636412"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
 , nevTools
;

type
 TK347636412 = class(TMergeCellsTest)
  {* [Requestlink:347636412] }
  protected
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* Получить "координаты" точек выделения. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK347636412
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
 //#UC START# *4F6C568000A6impl_uses*
 //#UC END# *4F6C568000A6impl_uses*
;

function TK347636412.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4CC818F4022D_4F6C568000A6_var*
//#UC END# *4CC818F4022D_4F6C568000A6_var*
begin
//#UC START# *4CC818F4022D_4F6C568000A6_impl*
 Result := aDocument.Para[0].AsList;
//#UC END# *4CC818F4022D_4F6C568000A6_impl*
end;//TK347636412.GetTablePara

procedure TK347636412.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4F6C568000A6_var*
//#UC END# *4CC81D4101AC_4F6C568000A6_var*
begin
//#UC START# *4CC81D4101AC_4F6C568000A6_impl*
 aStartRow := 3;
 aStartCell := 5;
 aFinishRow := 12;
 aFinishCell := 5;
//#UC END# *4CC81D4101AC_4F6C568000A6_impl*
end;//TK347636412.GetSelectParam

function TK347636412.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK347636412.GetFolder

function TK347636412.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F6C568000A6';
end;//TK347636412.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK347636412.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
