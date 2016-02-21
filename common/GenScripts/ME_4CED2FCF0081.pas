unit CellMouseSelectionTest;
 {* Выделение ячейки с помощью мыши. }

// Модуль: "w:\common\components\rtl\Garant\Daily\CellMouseSelectionTest.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HotSpotSelectionTest
 , nevTools
 , l3Units
;

type
 TCellMouseSelectionTest = {abstract} class(THotSpotSelectionTest)
  {* Выделение ячейки с помощью мыши. }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TCellMouseSelectionTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evConst
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

function TCellMouseSelectionTest.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4CED2FCF0081_var*
//#UC END# *4BF4E6A00093_4CED2FCF0081_var*
begin
//#UC START# *4BF4E6A00093_4CED2FCF0081_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
//#UC END# *4BF4E6A00093_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetInnerPara

function TCellMouseSelectionTest.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4CED2FCF0081_var*
//#UC END# *4C3C927B027E_4CED2FCF0081_var*
begin
//#UC START# *4C3C927B027E_4CED2FCF0081_impl*
 Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Outer.Bounds.Bottom - 2 * evEpsilon);
//#UC END# *4C3C927B027E_4CED2FCF0081_impl*
end;//TCellMouseSelectionTest.GetPoint

function TCellMouseSelectionTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TCellMouseSelectionTest.GetFolder

function TCellMouseSelectionTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CED2FCF0081';
end;//TCellMouseSelectionTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
