unit K210436976;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K210436976.pas"
// Начат: 04.06.2010 12:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K210436976
//
// {RequestLink:210436976}
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
 TK210436976 = class(TScrollTest)
  {* [RequestLink:210436976] }
 protected
 // overridden protected methods
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
 end;//TK210436976
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

// start class TK210436976

{$If defined(nsTest) AND not defined(NoVCM)}
function TK210436976.WebStyle: Boolean;
//#UC START# *4C08CF4300BE_4C08B91B002B_var*
//#UC END# *4C08CF4300BE_4C08B91B002B_var*
begin
//#UC START# *4C08CF4300BE_4C08B91B002B_impl*
 Result := false;
//#UC END# *4C08CF4300BE_4C08B91B002B_impl*
end;//TK210436976.WebStyle
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK210436976.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C08B91B002B_var*
//#UC END# *4C08CF700318_4C08B91B002B_var*
begin
//#UC START# *4C08CF700318_4C08B91B002B_impl*
 Result.X := 1024;
 Result.Y := 768;
//#UC END# *4C08CF700318_4C08B91B002B_impl*
end;//TK210436976.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK210436976.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK210436976.GetFolder

function TK210436976.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C08B91B002B';
end;//TK210436976.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK210436976.Suite);

end.