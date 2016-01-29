unit K267328230;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K267328230.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K267328230
//
// [$267328230]
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
  ScrollAndLinesTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK267328230 = class(TScrollAndLinesTest)
  {* [$267328230] }
 protected
 // realized methods
   function GetScrollCount: Integer; override;
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK267328230
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

// start class TK267328230

function TK267328230.GetScrollCount: Integer;
//#UC START# *4E54E5E2009E_4E54DF040323_var*
//#UC END# *4E54E5E2009E_4E54DF040323_var*
begin
//#UC START# *4E54E5E2009E_4E54DF040323_impl*
 Result := 30;
//#UC END# *4E54E5E2009E_4E54DF040323_impl*
end;//TK267328230.GetScrollCount

{$If defined(nsTest) AND not defined(NoVCM)}
function TK267328230.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E54DF040323_var*
//#UC END# *4C07AC6F036D_4E54DF040323_var*
begin
//#UC START# *4C07AC6F036D_4E54DF040323_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E54DF040323_impl*
end;//TK267328230.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK267328230.FormExtent: TPoint;
//#UC START# *4C08CF700318_4E54DF040323_var*
//#UC END# *4C08CF700318_4E54DF040323_var*
begin
//#UC START# *4C08CF700318_4E54DF040323_impl*
 Result.X := 950;
 Result.Y := 650;
//#UC END# *4C08CF700318_4E54DF040323_impl*
end;//TK267328230.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK267328230.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK267328230.GetFolder

function TK267328230.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E54DF040323';
end;//TK267328230.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK267328230.Suite);

end.