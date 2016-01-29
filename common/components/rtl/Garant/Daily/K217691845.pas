unit K217691845;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K217691845.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K217691845
//
// [$217691845]
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
 TK217691845 = class(TScrollTest)
  {* [$217691845] }
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
 end;//TK217691845
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

// start class TK217691845

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691845.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C19C5C902F3_var*
//#UC END# *4C07AC6F036D_4C19C5C902F3_var*
begin
//#UC START# *4C07AC6F036D_4C19C5C902F3_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C19C5C902F3_impl*
end;//TK217691845.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691845.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C19C5C902F3_var*
//#UC END# *4C08CF700318_4C19C5C902F3_var*
begin
//#UC START# *4C08CF700318_4C19C5C902F3_impl*
 Result.X := 1024;
 Result.Y := 603;
//#UC END# *4C08CF700318_4C19C5C902F3_impl*
end;//TK217691845.FormExtent
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK217691845.SendKey: Boolean;
//#UC START# *4C091B9A0305_4C19C5C902F3_var*
//#UC END# *4C091B9A0305_4C19C5C902F3_var*
begin
//#UC START# *4C091B9A0305_4C19C5C902F3_impl*
 Result := True;
//#UC END# *4C091B9A0305_4C19C5C902F3_impl*
end;//TK217691845.SendKey
{$IfEnd} //nsTest AND not NoVCM

function TK217691845.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK217691845.GetFolder

function TK217691845.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C19C5C902F3';
end;//TK217691845.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK217691845.Suite);

end.