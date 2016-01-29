unit K265412167;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K265412167.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K265412167
//
// [$265412167]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ScrollAndSelectPtTest,
  nevTools,
  Types,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK265412167 = class(TScrollAndSelectPtTest)
  {* [$265412167] }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetScrollCount: Integer; override;
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function NeedScrollByLine: Boolean; override;
 end;//TK265412167
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK265412167

function TK265412167.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
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

{$If defined(nsTest) AND not defined(NoVCM)}
function TK265412167.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4DCB9E470051_var*
//#UC END# *4C07AC6F036D_4DCB9E470051_var*
begin
//#UC START# *4C07AC6F036D_4DCB9E470051_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4DCB9E470051_impl*
end;//TK265412167.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK265412167.FormExtent: TPoint;
//#UC START# *4C08CF700318_4DCB9E470051_var*
//#UC END# *4C08CF700318_4DCB9E470051_var*
begin
//#UC START# *4C08CF700318_4DCB9E470051_impl*
 Result.X := 1000;
 Result.Y := 700;
//#UC END# *4C08CF700318_4DCB9E470051_impl*
end;//TK265412167.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK265412167.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4DCB9E470051_var*
//#UC END# *4C3C927B027E_4DCB9E470051_var*
begin
//#UC START# *4C3C927B027E_4DCB9E470051_impl*
 Result.X := aMap.Bounds.Right + 150;
 Result.Y := aMap.Bounds.Top + 100;
//#UC END# *4C3C927B027E_4DCB9E470051_impl*
end;//TK265412167.GetPoint

function TK265412167.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK265412167.GetFolder

function TK265412167.GetModelElementGUID: AnsiString;
 {-}
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

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK265412167.Suite);

end.