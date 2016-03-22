unit K272666734;
 {* [$272666734] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K272666734.pas"
// Стереотип: "TestCase"
// Элемент модели: "K272666734" MUID: (4E12D7F90187)
// Имя типа: "TK272666734"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RowSelectionTest
 , nevTools
 , l3Units
;

type
 TK272666734 = class(TRowSelectionTest)
  {* [$272666734] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
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
 end;//TK272666734
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TK272666734.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4E12D7F90187_var*
//#UC END# *4BF4E6A00093_4E12D7F90187_var*
begin
//#UC START# *4BF4E6A00093_4E12D7F90187_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- таблица     ^- строка      ^- ячейка
//#UC END# *4BF4E6A00093_4E12D7F90187_impl*
end;//TK272666734.GetInnerPara

{$If NOT Defined(NoVCM)}
function TK272666734.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4E12D7F90187_var*
//#UC END# *4C07AC6F036D_4E12D7F90187_var*
begin
//#UC START# *4C07AC6F036D_4E12D7F90187_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E12D7F90187_impl*
end;//TK272666734.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

function TK272666734.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4E12D7F90187_var*
//#UC END# *4C3C927B027E_4E12D7F90187_var*
begin
//#UC START# *4C3C927B027E_4E12D7F90187_impl*
 Result.X := aMap.Bounds.Left - 5;
 Result.Y := aMap.Bounds.Top + 70;
//#UC END# *4C3C927B027E_4E12D7F90187_impl*
end;//TK272666734.GetPoint

function TK272666734.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK272666734.GetFolder

function TK272666734.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E12D7F90187';
end;//TK272666734.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK272666734.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
