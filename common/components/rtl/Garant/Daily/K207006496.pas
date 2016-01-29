unit K207006496;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K207006496.pas"
// Начат: 17.06.2010 21:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K207006496
//
// {RequestLink:207006496}
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
  ScrollTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK207006496 = class(TScrollTest)
  {* [RequestLink:207006496] }
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
 end;//TK207006496
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

// start class TK207006496

{$If defined(nsTest) AND not defined(NoVCM)}
function TK207006496.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C1A5CE401A0_var*
//#UC END# *4C08CF700318_4C1A5CE401A0_var*
begin
//#UC START# *4C08CF700318_4C1A5CE401A0_impl*
 Result.X := 800;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C1A5CE401A0_impl*
end;//TK207006496.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK207006496.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK207006496.GetFolder

function TK207006496.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1A5CE401A0';
end;//TK207006496.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK207006496.Suite);

end.