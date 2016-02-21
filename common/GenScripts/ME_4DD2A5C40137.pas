unit K266405030;
 {* [$266405030] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K266405030.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ScrollAndSelectPtTest
 , nevTools
 , Types
 , l3Units
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK266405030 = class(TScrollAndSelectPtTest)
  {* [$266405030] }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
    {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   {$If NOT Defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function FormExtent: TPoint; override;
    {* Размеры формы }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function NeedScrollByLine: Boolean; override;
 end;//TK266405030
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TextPara_Const
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

{$If NOT Defined(NoVCM)}
procedure TK266405030.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4DD2A5C40137_var*
//#UC END# *4BE419AF0217_4DD2A5C40137_var*
begin
//#UC START# *4BE419AF0217_4DD2A5C40137_impl*
 inherited DoVisit(aForm);
 Check(aForm.Text.Selection.Cursor.MostInner.AsObject.IsKindOf(k2_typTextPara));
//#UC END# *4BE419AF0217_4DD2A5C40137_impl*
end;//TK266405030.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

function TK266405030.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4DD2A5C40137_var*
//#UC END# *4BF4E6A00093_4DD2A5C40137_var*
begin
//#UC START# *4BF4E6A00093_4DD2A5C40137_impl*
 Result := aDocument.AsList.Para[1].AsList.Para[1].AsList.Para[1];
//#UC END# *4BF4E6A00093_4DD2A5C40137_impl*
end;//TK266405030.GetInnerPara

function TK266405030.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4DD2A5C40137_var*
//#UC END# *4BFE40CD0337_4DD2A5C40137_var*
begin
//#UC START# *4BFE40CD0337_4DD2A5C40137_impl*
 Result := 6;
//#UC END# *4BFE40CD0337_4DD2A5C40137_impl*
end;//TK266405030.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK266405030.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4DD2A5C40137_var*
//#UC END# *4C07AC6F036D_4DD2A5C40137_var*
begin
//#UC START# *4C07AC6F036D_4DD2A5C40137_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DD2A5C40137_impl*
end;//TK266405030.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK266405030.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4DD2A5C40137_var*
//#UC END# *4C08CF700318_4DD2A5C40137_var*
begin
//#UC START# *4C08CF700318_4DD2A5C40137_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DD2A5C40137_impl*
end;//TK266405030.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK266405030.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4DD2A5C40137_var*
//#UC END# *4C3C927B027E_4DD2A5C40137_var*
begin
//#UC START# *4C3C927B027E_4DD2A5C40137_impl*
 Result.X := aMap.Bounds.Right + 150;
 Result.Y := aMap.Bounds.Top + 100;
//#UC END# *4C3C927B027E_4DD2A5C40137_impl*
end;//TK266405030.GetPoint

function TK266405030.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK266405030.GetFolder

function TK266405030.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DD2A5C40137';
end;//TK266405030.GetModelElementGUID

function TK266405030.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4DD2A5C40137_var*
//#UC END# *4E44C9B00324_4DD2A5C40137_var*
begin
//#UC START# *4E44C9B00324_4DD2A5C40137_impl*
 Result := True;
//#UC END# *4E44C9B00324_4DD2A5C40137_impl*
end;//TK266405030.NeedScrollByLine

initialization
 TestFramework.RegisterTest(TK266405030.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
