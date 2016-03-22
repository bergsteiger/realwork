unit K216074128;
 {* [$216074128] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K216074128.pas"
// Стереотип: "TestCase"
// Элемент модели: "K216074128" MUID: (4BFE3F220082)
// Имя типа: "TK216074128"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 , l3Units
;

type
 TK216074128 = class(TScrollAndSelectPtTest)
  {* [$216074128] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK216074128
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
;

function TK216074128.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4BFE3F220082_var*
//#UC END# *4BF4E6A00093_4BFE3F220082_var*
begin
//#UC START# *4BF4E6A00093_4BFE3F220082_impl*
 Result := aDocument.AsList.Para[1]; // Таблица
 Result := Result.AsList.Para[8]; // Строка
 Result := Result.AsList.Para[0]; // Ячейка
//#UC END# *4BF4E6A00093_4BFE3F220082_impl*
end;//TK216074128.GetInnerPara

function TK216074128.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4BFE3F220082_var*
//#UC END# *4BFE40CD0337_4BFE3F220082_var*
begin
//#UC START# *4BFE40CD0337_4BFE3F220082_impl*
 Result := 3;
//#UC END# *4BFE40CD0337_4BFE3F220082_impl*
end;//TK216074128.GetScrollCount

function TK216074128.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4BFE3F220082_var*
//#UC END# *4C3C927B027E_4BFE3F220082_var*
begin
//#UC START# *4C3C927B027E_4BFE3F220082_impl*
 Result := l3Point(aMap.Bounds.Left - 500, aMap.Bounds.Bottom);
//#UC END# *4C3C927B027E_4BFE3F220082_impl*
end;//TK216074128.GetPoint

function TK216074128.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK216074128.GetFolder

function TK216074128.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BFE3F220082';
end;//TK216074128.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK216074128.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
