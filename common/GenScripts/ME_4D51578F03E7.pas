unit K252524358;
 {* [$252524358] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K252524358.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Translate2TextTest
 , nevTools
;

type
 TK252524358 = class(TTranslate2TextTest)
  {* [$252524358] }
  protected
   function SelectTableWholly: Boolean; override;
    {* Вылять таблицу целиком }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetTablePara(const aDocument: InevParaList): InevParaList; override;
    {* Возвращает параграф с таблицей }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK252524358
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

function TK252524358.SelectTableWholly: Boolean;
 {* Вылять таблицу целиком }
//#UC START# *4C34625E021F_4D51578F03E7_var*
//#UC END# *4C34625E021F_4D51578F03E7_var*
begin
//#UC START# *4C34625E021F_4D51578F03E7_impl*
 Result := True;
//#UC END# *4C34625E021F_4D51578F03E7_impl*
end;//TK252524358.SelectTableWholly

function TK252524358.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK252524358.GetFolder

function TK252524358.GetTablePara(const aDocument: InevParaList): InevParaList;
 {* Возвращает параграф с таблицей }
//#UC START# *4CC818F4022D_4D51578F03E7_var*
//#UC END# *4CC818F4022D_4D51578F03E7_var*
begin
//#UC START# *4CC818F4022D_4D51578F03E7_impl*
 Result := aDocument.Para[1].AsList;
//#UC END# *4CC818F4022D_4D51578F03E7_impl*
end;//TK252524358.GetTablePara

function TK252524358.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D51578F03E7';
end;//TK252524358.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252524358.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
