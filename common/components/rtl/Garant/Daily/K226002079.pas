unit K226002079;
 {* [$226002079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K226002079.pas"
// Стереотип: "TestCase"
// Элемент модели: "K226002079" MUID: (4C3C6BDD0189)
// Имя типа: "TK226002079"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CheckTopAnchorTest
 , nevTools
 , l3Units
;

type
 TK226002079 = class(TCheckTopAnchorTest)
  {* [$226002079] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK226002079
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
 //#UC START# *4C3C6BDD0189impl_uses*
 //#UC END# *4C3C6BDD0189impl_uses*
;

function TK226002079.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4C3C6BDD0189_var*
//#UC END# *4BF4E6A00093_4C3C6BDD0189_var*
begin
//#UC START# *4BF4E6A00093_4C3C6BDD0189_impl*
 Result := aView.TopAnchor.Inner.Inner.Obj^.AsPara.AsList.Para[0];
//#UC END# *4BF4E6A00093_4C3C6BDD0189_impl*
end;//TK226002079.GetInnerPara

function TK226002079.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4C3C6BDD0189_var*
//#UC END# *4BFE40CD0337_4C3C6BDD0189_var*
begin
//#UC START# *4BFE40CD0337_4C3C6BDD0189_impl*
 Result := 7;
//#UC END# *4BFE40CD0337_4C3C6BDD0189_impl*
end;//TK226002079.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK226002079.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4C3C6BDD0189_var*
//#UC END# *4C07AC6F036D_4C3C6BDD0189_var*
begin
//#UC START# *4C07AC6F036D_4C3C6BDD0189_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C3C6BDD0189_impl*
end;//TK226002079.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK226002079.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4C3C6BDD0189_var*
//#UC END# *4C3C927B027E_4C3C6BDD0189_var*
begin
//#UC START# *4C3C927B027E_4C3C6BDD0189_impl*
 Result := l3Point(aMap.Bounds.Right + 1000, 1000);
//#UC END# *4C3C927B027E_4C3C6BDD0189_impl*
end;//TK226002079.GetPoint

function TK226002079.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK226002079.GetFolder

function TK226002079.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C3C6BDD0189';
end;//TK226002079.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK226002079.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
