unit K217684334;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K217684334.pas"
// Начат: 08.06.2010 17:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217684334
//
// {RequestLink:217684334}
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
 TK217684334 = class(TScrollTest)
  {* [RequestLink:217684334] }
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
   {$If defined(nsTest) AND not defined(NoVCM)}
   function SendKey: Boolean; override;
     {* Управлять ли окном реактора посредсвом посылки клавиш, а не вызова методов редактора }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function MaxHeight: Integer; override;
     {* Если возвращается не 0, то будет организован цикл подбора высоты от FormExtent.Y до MaxHeight }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK217684334
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

// start class TK217684334

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217684334.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C0E4A360101_var*
//#UC END# *4C07AC6F036D_4C0E4A360101_var*
begin
//#UC START# *4C07AC6F036D_4C0E4A360101_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C0E4A360101_impl*
end;//TK217684334.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217684334.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C0E4A360101_var*
//#UC END# *4C08CF700318_4C0E4A360101_var*
begin
//#UC START# *4C08CF700318_4C0E4A360101_impl*
 Result.X := 798;
 Result.Y := 296{200};
//#UC END# *4C08CF700318_4C0E4A360101_impl*
end;//TK217684334.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217684334.SendKey: Boolean;
//#UC START# *4C091B9A0305_4C0E4A360101_var*
//#UC END# *4C091B9A0305_4C0E4A360101_var*
begin
//#UC START# *4C091B9A0305_4C0E4A360101_impl*
 Result := true;
//#UC END# *4C091B9A0305_4C0E4A360101_impl*
end;//TK217684334.SendKey
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217684334.MaxHeight: Integer;
//#UC START# *4C0E56F000A4_4C0E4A360101_var*
//#UC END# *4C0E56F000A4_4C0E4A360101_var*
begin
//#UC START# *4C0E56F000A4_4C0E4A360101_impl*
 Result := 0{600}; 
//#UC END# *4C0E56F000A4_4C0E4A360101_impl*
end;//TK217684334.MaxHeight
{$IfEnd} //nsTest AND not NoVCM

function TK217684334.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217684334.GetFolder

function TK217684334.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C0E4A360101';
end;//TK217684334.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217684334.Suite);

end.