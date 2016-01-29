unit K232097143;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K232097143.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K232097143
//
// [$232097143]
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
 TK232097143 = class(TScrollTest)
  {* [$232097143] }
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
 end;//TK232097143
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

// start class TK232097143

{$If defined(nsTest) AND not defined(NoVCM)}
function TK232097143.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C6120070163_var*
//#UC END# *4C07AC6F036D_4C6120070163_var*
begin
//#UC START# *4C07AC6F036D_4C6120070163_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C6120070163_impl*
end;//TK232097143.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK232097143.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C6120070163_var*
//#UC END# *4C08CF700318_4C6120070163_var*
begin
//#UC START# *4C08CF700318_4C6120070163_impl*
 Result.X := 1280;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C6120070163_impl*
end;//TK232097143.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK232097143.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK232097143.GetFolder

function TK232097143.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6120070163';
end;//TK232097143.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK232097143.Suite);

end.