unit K221250480;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K221250480.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K221250480
//
// [$221250480]
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
 TK221250480 = class(TScrollTest)
  {* [$221250480] }
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
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK221250480
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

// start class TK221250480

{$If defined(nsTest) AND not defined(NoVCM)}
function TK221250480.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C2C75C9037A_var*
//#UC END# *4C07AC6F036D_4C2C75C9037A_var*
begin
//#UC START# *4C07AC6F036D_4C2C75C9037A_impl*
 Result := 14;
//#UC END# *4C07AC6F036D_4C2C75C9037A_impl*
end;//TK221250480.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK221250480.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C2C75C9037A_var*
//#UC END# *4C08CF700318_4C2C75C9037A_var*
begin
//#UC START# *4C08CF700318_4C2C75C9037A_impl*
 Result.X := 798;
 Result.Y := 453;
//#UC END# *4C08CF700318_4C2C75C9037A_impl*
end;//TK221250480.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK221250480.SendKey: Boolean;
//#UC START# *4C091B9A0305_4C2C75C9037A_var*
//#UC END# *4C091B9A0305_4C2C75C9037A_var*
begin
//#UC START# *4C091B9A0305_4C2C75C9037A_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C2C75C9037A_impl*
end;//TK221250480.SendKey
{$IfEnd} //nsTest AND not NoVCM

function TK221250480.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK221250480.GetFolder

function TK221250480.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C2C75C9037A';
end;//TK221250480.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK221250480.Suite);

end.