unit K265412167;
 {* [$265412167] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K265412167.pas"
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
;

type
 TK265412167 = class(TScrollAndSelectPtTest)
  {* [$265412167] }
  protected
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
 end;//TK265412167
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

function TK265412167.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
//#UC START# *4BF4E6A00093_4DCB9E470051_var*
//#UC END# *4BF4E6A00093_4DCB9E470051_var*
begin
//#UC START# *4BF4E6A00093_4DCB9E470051_impl*
 Result := aDocument.AsList.Para[1].AsList.Para[1].AsList.Para[1];
//#UC END# *4BF4E6A00093_4DCB9E470051_impl*
end;//TK265412167.GetInnerPara

function TK265412167.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4DCB9E470051_var*
//#UC END# *4BFE40CD0337_4DCB9E470051_var*
begin
//#UC START# *4BFE40CD0337_4DCB9E470051_impl*
 Result := 6;
//#UC END# *4BFE40CD0337_4DCB9E470051_impl*
end;//TK265412167.GetScrollCount

{$If NOT Defined(NoVCM)}
function TK265412167.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4DCB9E470051_var*
//#UC END# *4C07AC6F036D_4DCB9E470051_var*
begin
//#UC START# *4C07AC6F036D_4DCB9E470051_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DCB9E470051_impl*
end;//TK265412167.GetNormalFontSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK265412167.FormExtent: TPoint;
 {* Размеры формы }
//#UC START# *4C08CF700318_4DCB9E470051_var*
//#UC END# *4C08CF700318_4DCB9E470051_var*
begin
//#UC START# *4C08CF700318_4DCB9E470051_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DCB9E470051_impl*
end;//TK265412167.FormExtent
{$IfEnd} // NOT Defined(NoVCM)

function TK265412167.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4DCB9E470051_var*
//#UC END# *4C3C927B027E_4DCB9E470051_var*
begin
//#UC START# *4C3C927B027E_4DCB9E470051_impl*
 Result.X := aMap.Bounds.Right + 150;
 Result.Y := aMap.Bounds.Top + 100;
//#UC END# *4C3C927B027E_4DCB9E470051_impl*
end;//TK265412167.GetPoint

function TK265412167.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK265412167.GetFolder

function TK265412167.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4DCB9E470051';
end;//TK265412167.GetModelElementGUID

function TK265412167.NeedScrollByLine: Boolean;
//#UC START# *4E44C9B00324_4DCB9E470051_var*
//#UC END# *4E44C9B00324_4DCB9E470051_var*
begin
//#UC START# *4E44C9B00324_4DCB9E470051_impl*
 Result := True;
//#UC END# *4E44C9B00324_4DCB9E470051_impl*
end;//TK265412167.NeedScrollByLine

initialization
 TestFramework.RegisterTest(TK265412167.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
