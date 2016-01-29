unit K269064546;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K269064546.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K269064546
//
// [$269064546]
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
  ScrollByLineBackAndSelectPt,
  nevTools,
  Types,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK269064546 = class(TScrollByLineBackAndSelectPt)
  {* [$269064546] }
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
 end;//TK269064546
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

// start class TK269064546

function TK269064546.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4E44C6EA03B0_var*
//#UC END# *4BF4E6A00093_4E44C6EA03B0_var*
begin
//#UC START# *4BF4E6A00093_4E44C6EA03B0_impl*
 Result := aDocument.AsList.Para[1].AsList.Para[1].AsList.Para[2];
//#UC END# *4BF4E6A00093_4E44C6EA03B0_impl*
end;//TK269064546.GetInnerPara

function TK269064546.GetScrollCount: Integer;
//#UC START# *4BFE40CD0337_4E44C6EA03B0_var*
//#UC END# *4BFE40CD0337_4E44C6EA03B0_var*
begin
//#UC START# *4BFE40CD0337_4E44C6EA03B0_impl*
 Result := 22;
//#UC END# *4BFE40CD0337_4E44C6EA03B0_impl*
end;//TK269064546.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK269064546.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E44C6EA03B0_var*
//#UC END# *4C07AC6F036D_4E44C6EA03B0_var*
begin
//#UC START# *4C07AC6F036D_4E44C6EA03B0_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4E44C6EA03B0_impl*
end;//TK269064546.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK269064546.FormExtent: TPoint;
//#UC START# *4C08CF700318_4E44C6EA03B0_var*
//#UC END# *4C08CF700318_4E44C6EA03B0_var*
begin
//#UC START# *4C08CF700318_4E44C6EA03B0_impl*
 Result.X := 950;
 Result.Y := 650;
//#UC END# *4C08CF700318_4E44C6EA03B0_impl*
end;//TK269064546.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK269064546.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4E44C6EA03B0_var*
//#UC END# *4C3C927B027E_4E44C6EA03B0_var*
begin
//#UC START# *4C3C927B027E_4E44C6EA03B0_impl*
 Result.X := 4600;
 Result.Y := 10;
//#UC END# *4C3C927B027E_4E44C6EA03B0_impl*
end;//TK269064546.GetPoint

function TK269064546.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK269064546.GetFolder

function TK269064546.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E44C6EA03B0';
end;//TK269064546.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK269064546.Suite);

end.