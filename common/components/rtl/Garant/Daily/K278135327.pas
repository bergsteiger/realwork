unit K278135327;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K278135327.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7::K278135327
//
// [$278135327]
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
  DrawTest,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK278135327 = class(TDrawTest)
  {* [$278135327] }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function WebStyle: Boolean; override;
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function FormExtent: TPoint; override;
     {* Размеры формы }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK278135327
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  nevTools
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

// start class TK278135327

{$If defined(nsTest) AND not defined(NoVCM)}
function TK278135327.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4E3BD18A01A3_var*
//#UC END# *4C07AC6F036D_4E3BD18A01A3_var*
begin
//#UC START# *4C07AC6F036D_4E3BD18A01A3_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4E3BD18A01A3_impl*
end;//TK278135327.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK278135327.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4E3BD18A01A3_var*
//#UC END# *4C08CF4300BE_4E3BD18A01A3_var*
begin
//#UC START# *4C08CF4300BE_4E3BD18A01A3_impl*
 Result := True;
//#UC END# *4C08CF4300BE_4E3BD18A01A3_impl*
end;//TK278135327.WebStyle
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK278135327.FormExtent: TPoint;
//#UC START# *4C08CF700318_4E3BD18A01A3_var*
//#UC END# *4C08CF700318_4E3BD18A01A3_var*
begin
//#UC START# *4C08CF700318_4E3BD18A01A3_impl*
 Result.X := 1000;
 Result.Y := 710; 
//#UC END# *4C08CF700318_4E3BD18A01A3_impl*
end;//TK278135327.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK278135327.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7';
end;//TK278135327.GetFolder

function TK278135327.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E3BD18A01A3';
end;//TK278135327.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK278135327.Suite);

end.