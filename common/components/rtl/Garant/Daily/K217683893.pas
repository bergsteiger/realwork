unit K217683893;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K217683893.pas"
// Начат: 08.06.2010 14:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217683893
//
// {RequestLink:217683893}.
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
  ScrollBackTest
  {$IfEnd} //nsTest AND not NoVCM
  ,
  Types
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK217683893 = class(TScrollBackTest)
  {* [RequestLink:217683893]. }
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
 end;//TK217683893
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

// start class TK217683893

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217683893.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C0E207401DD_var*
//#UC END# *4C07AC6F036D_4C0E207401DD_var*
begin
//#UC START# *4C07AC6F036D_4C0E207401DD_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C0E207401DD_impl*
end;//TK217683893.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217683893.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C0E207401DD_var*
//#UC END# *4C08CF700318_4C0E207401DD_var*
begin
//#UC START# *4C08CF700318_4C0E207401DD_impl*
 Result.X := 798;
 Result.Y := 465;
//#UC END# *4C08CF700318_4C0E207401DD_impl*
end;//TK217683893.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK217683893.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217683893.GetFolder

function TK217683893.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C0E207401DD';
end;//TK217683893.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217683893.Suite);

end.