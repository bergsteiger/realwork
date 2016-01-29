unit K226002079;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K226002079.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K226002079
//
// [$226002079]
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
  CheckTopAnchorTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK226002079 = class(TCheckTopAnchorTest)
  {* [$226002079] }
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
   function GetPoint(const aMap: InevMap): Tl3Point; override;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK226002079
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

// start class TK226002079

function TK226002079.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
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

{$If defined(nsTest) AND not defined(NoVCM)}
function TK226002079.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C3C6BDD0189_var*
//#UC END# *4C07AC6F036D_4C3C6BDD0189_var*
begin
//#UC START# *4C07AC6F036D_4C3C6BDD0189_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C3C6BDD0189_impl*
end;//TK226002079.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK226002079.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4C3C6BDD0189_var*
//#UC END# *4C3C927B027E_4C3C6BDD0189_var*
begin
//#UC START# *4C3C927B027E_4C3C6BDD0189_impl*
 Result := l3Point(aMap.Bounds.Right + 1000, 1000);
//#UC END# *4C3C927B027E_4C3C6BDD0189_impl*
end;//TK226002079.GetPoint

function TK226002079.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK226002079.GetFolder

function TK226002079.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3C6BDD0189';
end;//TK226002079.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK226002079.Suite);

end.