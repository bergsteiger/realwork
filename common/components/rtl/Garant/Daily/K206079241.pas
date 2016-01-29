unit K206079241;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K206079241.pas"
// Начат: 17.06.2010 21:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K206079241
//
// {RequestLink:206079241}.
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
 TK206079241 = class(TScrollTest)
  {* [RequestLink:206079241]. }
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
 end;//TK206079241
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

// start class TK206079241

{$If defined(nsTest) AND not defined(NoVCM)}
function TK206079241.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C1A582D009F_var*
//#UC END# *4C08CF700318_4C1A582D009F_var*
begin
//#UC START# *4C08CF700318_4C1A582D009F_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C1A582D009F_impl*
end;//TK206079241.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK206079241.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK206079241.GetFolder

function TK206079241.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C1A582D009F';
end;//TK206079241.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK206079241.Suite);

end.