unit K272666734;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K272666734.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K272666734
//
// [$272666734]
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
  RowSelectionTest,
  nevTools,
  l3Units
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK272666734 = class(TRowSelectionTest)
  {* [$272666734] }
 protected
 // overridden protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; override;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
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
 end;//TK272666734
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK272666734

function TK272666734.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4E12D7F90187_var*
//#UC END# *4BF4E6A00093_4E12D7F90187_var*
begin
//#UC START# *4BF4E6A00093_4E12D7F90187_impl*
 Result := aDocument.AsList.Para[0].AsList.Para[0].AsList.Para[0];
                          //^- таблица     ^- строка      ^- ячейка
//#UC END# *4BF4E6A00093_4E12D7F90187_impl*
end;//TK272666734.GetInnerPara

{$If defined(nsTest) AND not defined(NoVCM)}
function TK272666734.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E12D7F90187_var*
//#UC END# *4C07AC6F036D_4E12D7F90187_var*
begin
//#UC START# *4C07AC6F036D_4E12D7F90187_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E12D7F90187_impl*
end;//TK272666734.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK272666734.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4E12D7F90187_var*
//#UC END# *4C3C927B027E_4E12D7F90187_var*
begin
//#UC START# *4C3C927B027E_4E12D7F90187_impl*
 Result.X := aMap.Bounds.Left - 5;
 Result.Y := aMap.Bounds.Top + 70;
//#UC END# *4C3C927B027E_4E12D7F90187_impl*
end;//TK272666734.GetPoint

function TK272666734.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK272666734.GetFolder

function TK272666734.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E12D7F90187';
end;//TK272666734.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK272666734.Suite);

end.