unit K227477421;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K227477421.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K227477421
//
// [$227477421]
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
  ScrollBackByLineWithCheckTopAnchoTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK227477421 = class(TScrollBackByLineWithCheckTopAnchoTest)
  {* [$227477421] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK227477421
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

// start class TK227477421

{$If defined(nsTest) AND not defined(NoVCM)}
function TK227477421.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C46BCC6031B_var*
//#UC END# *4C07AC6F036D_4C46BCC6031B_var*
begin
//#UC START# *4C07AC6F036D_4C46BCC6031B_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C46BCC6031B_impl*
end;//TK227477421.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

function TK227477421.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK227477421.GetFolder

function TK227477421.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C46BCC6031B';
end;//TK227477421.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK227477421.Suite);

end.