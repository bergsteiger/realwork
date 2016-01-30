unit MouseMoveCellsSelectTest;
 {* Тест выделения с помощью мыши диапазона ячеек. }

// Модуль: "w:\common\components\rtl\Garant\Daily\MouseMoveCellsSelectTest.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MouseMoveSelectionTest
 , nevTools
 , l3Units
;

type
 TMouseMoveCellsSelectTest = {abstract} class(TMouseMoveSelectionTest)
  {* Тест выделения с помощью мыши диапазона ячеек. }
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
 end;//TMouseMoveCellsSelectTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evConst
 , TestFrameWork
;

function TMouseMoveCellsSelectTest.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4D3D429001F4_var*
//#UC END# *4BF4E6A00093_4D3D429001F4_var*
begin
//#UC START# *4BF4E6A00093_4D3D429001F4_impl*
 if f_StartPoint then
  Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[2].AsList.Para[0].AsList.Para[0]
 else
  Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[2].AsList.Para[2].AsList.Para[0]
//#UC END# *4BF4E6A00093_4D3D429001F4_impl*
end;//TMouseMoveCellsSelectTest.GetInnerPara

function TMouseMoveCellsSelectTest.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4D3D429001F4_var*
//#UC END# *4C3C927B027E_4D3D429001F4_var*
begin
//#UC START# *4C3C927B027E_4D3D429001F4_impl*
 if f_StartPoint then
  Result := l3Point(aMap.Bounds.Left + 3 * evEpsilon, aMap.Bounds.Top + 3 * evEpsilon)
 else
  Result := l3Point(aMap.Bounds.Right - 3 * evEpsilon, aMap.Bounds.Top + 2 * evEpsilon)
//#UC END# *4C3C927B027E_4D3D429001F4_impl*
end;//TMouseMoveCellsSelectTest.GetPoint

function TMouseMoveCellsSelectTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TMouseMoveCellsSelectTest.GetFolder

function TMouseMoveCellsSelectTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D3D429001F4';
end;//TMouseMoveCellsSelectTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
