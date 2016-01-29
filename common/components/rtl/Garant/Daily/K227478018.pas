unit K227478018;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K227478018.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K227478018
//
// [$227478018]
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  DrawLineTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK227478018 = class(TDrawLineTest)
  {* [$227478018] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK227478018
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

// start class TK227478018

{$If defined(nsTest) AND not defined(NoVCM)}
function TK227478018.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C46F5FE0082_var*
//#UC END# *4C08CF700318_4C46F5FE0082_var*
begin
//#UC START# *4C08CF700318_4C46F5FE0082_impl*
 Result.X := 1000;
 Result.Y := 600;
//#UC END# *4C08CF700318_4C46F5FE0082_impl*
end;//TK227478018.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK227478018.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK227478018.GetFolder

function TK227478018.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C46F5FE0082';
end;//TK227478018.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK227478018.Suite);

end.