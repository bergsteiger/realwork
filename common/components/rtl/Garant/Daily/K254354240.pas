unit K254354240;
 {* [$254354240] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K254354240.pas"
// Стереотип: "TestCase"
// Элемент модели: "K254354240" MUID: (4D6F51C602F5)
// Имя типа: "TK254354240"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DrawSelectionInTableTest
 , nevTools
;

type
 TK254354240 = class(TDrawSelectionInTableTest)
  {* [$254354240] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   procedure GetSelectParam(out aStartRow: Integer;
    out aStartCell: Integer;
    out aFinishRow: Integer;
    out aFinishCell: Integer); override;
    {* Получить "координаты" точек выделения. }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK254354240
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
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

function TK254354240.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK254354240.GetFolder

function TK254354240.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4CC818F4022D_4D6F51C602F5_var*
//#UC END# *4CC818F4022D_4D6F51C602F5_var*
begin
//#UC START# *4CC818F4022D_4D6F51C602F5_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D6F51C602F5_impl*
end;//TK254354240.GetTablePara

procedure TK254354240.GetSelectParam(out aStartRow: Integer;
 out aStartCell: Integer;
 out aFinishRow: Integer;
 out aFinishCell: Integer);
 {* Получить "координаты" точек выделения. }
//#UC START# *4CC81D4101AC_4D6F51C602F5_var*
//#UC END# *4CC81D4101AC_4D6F51C602F5_var*
begin
//#UC START# *4CC81D4101AC_4D6F51C602F5_impl*
 aStartRow := 0;
 aStartCell := 1;
 aFinishRow := 0;
 aFinishCell := 1;
//#UC END# *4CC81D4101AC_4D6F51C602F5_impl*
end;//TK254354240.GetSelectParam

function TK254354240.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D6F51C602F5';
end;//TK254354240.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK254354240.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
