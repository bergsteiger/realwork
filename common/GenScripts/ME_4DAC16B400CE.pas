unit K263293373;
 {* [$263293373] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K263293373.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MouseSelectPtTest
 , nevTools
 , l3Units
;

type
 TK263293373 = class(TMouseSelectPtTest)
  {* [$263293373] }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CheckTopAnchor(const aView: InevInputView); override;
    {* проверить якорь начала отрисовки после окончания прокрутки }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK263293373
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

function TK263293373.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4DAC16B400CE_var*
//#UC END# *4BF4E6A00093_4DAC16B400CE_var*
begin
//#UC START# *4BF4E6A00093_4DAC16B400CE_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- таблица     ^- строка      ^- ячейка
//#UC END# *4BF4E6A00093_4DAC16B400CE_impl*
end;//TK263293373.GetInnerPara

{$If NOT Defined(NoVCM)}
function TK263293373.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4DAC16B400CE_var*
//#UC END# *4C07AC6F036D_4DAC16B400CE_var*
begin
//#UC START# *4C07AC6F036D_4DAC16B400CE_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DAC16B400CE_impl*
end;//TK263293373.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TK263293373.CheckTopAnchor(const aView: InevInputView);
 {* проверить якорь начала отрисовки после окончания прокрутки }
//#UC START# *4C1F0A260192_4DAC16B400CE_var*
//#UC END# *4C1F0A260192_4DAC16B400CE_var*
begin
//#UC START# *4C1F0A260192_4DAC16B400CE_impl*
 Check(aView.TopAnchor.AtStart);
//#UC END# *4C1F0A260192_4DAC16B400CE_impl*
end;//TK263293373.CheckTopAnchor
{$IfEnd} // NOT Defined(NoVCM)

function TK263293373.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4DAC16B400CE_var*
//#UC END# *4C3C927B027E_4DAC16B400CE_var*
begin
//#UC START# *4C3C927B027E_4DAC16B400CE_impl*
 Assert(aMap <> nil);
 Result.X := aMap.Bounds.Left + 50;
 Result.Y := aMap.Bounds.Bottom - 200;
//#UC END# *4C3C927B027E_4DAC16B400CE_impl*
end;//TK263293373.GetPoint

function TK263293373.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK263293373.GetFolder

function TK263293373.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DAC16B400CE';
end;//TK263293373.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK263293373.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
