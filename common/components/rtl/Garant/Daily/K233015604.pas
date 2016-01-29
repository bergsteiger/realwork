unit K233015604;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K233015604.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K233015604
//
// [$235869058]
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
 TK233015604 = class(TScrollTest)
  {* [$235869058] }
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
 end;//TK233015604
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

// start class TK233015604

{$If defined(nsTest) AND not defined(NoVCM)}
function TK233015604.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4CBC3C0C0141_var*
//#UC END# *4C07AC6F036D_4CBC3C0C0141_var*
begin
//#UC START# *4C07AC6F036D_4CBC3C0C0141_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4CBC3C0C0141_impl*
end;//TK233015604.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK233015604.FormExtent: TPoint;
//#UC START# *4C08CF700318_4CBC3C0C0141_var*
//#UC END# *4C08CF700318_4CBC3C0C0141_var*
begin
//#UC START# *4C08CF700318_4CBC3C0C0141_impl*
 Result.X := 768;
 Result.Y := 403;
//#UC END# *4C08CF700318_4CBC3C0C0141_impl*
end;//TK233015604.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK233015604.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK233015604.GetFolder

function TK233015604.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CBC3C0C0141';
end;//TK233015604.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK233015604.Suite);

end.