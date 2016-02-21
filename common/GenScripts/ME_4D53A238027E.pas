unit K253664689;
 {* [$253664689] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K253664689.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MergeCellsTest
 , nevTools
;

type
 TK253664689 = class(TMergeCellsTest)
  {* [$253664689] }
  protected
   function SelectTableWholly: Boolean; override;
    {* Вылять таблицу целиком }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK253664689
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

function TK253664689.SelectTableWholly: Boolean;
 {* Вылять таблицу целиком }
//#UC START# *4C34625E021F_4D53A238027E_var*
//#UC END# *4C34625E021F_4D53A238027E_var*
begin
//#UC START# *4C34625E021F_4D53A238027E_impl*
 Result := True;
//#UC END# *4C34625E021F_4D53A238027E_impl*
end;//TK253664689.SelectTableWholly

function TK253664689.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK253664689.GetFolder

function TK253664689.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4CC818F4022D_4D53A238027E_var*
//#UC END# *4CC818F4022D_4D53A238027E_var*
begin
//#UC START# *4CC818F4022D_4D53A238027E_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D53A238027E_impl*
end;//TK253664689.GetTablePara

function TK253664689.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D53A238027E';
end;//TK253664689.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK253664689.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
