unit K233014754;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K233014754.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K233014754
//
// [$233014754]
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
 TK233014754 = class(TScrollTest)
  {* [$233014754] }
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
 end;//TK233014754
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

// start class TK233014754

{$If defined(nsTest) AND not defined(NoVCM)}
function TK233014754.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_var*
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_var*
begin
//#UC START# *4C07AC6F036D_4C6CDC7B00F2_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4C6CDC7B00F2_impl*
end;//TK233014754.GetNormalFontSize
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK233014754.FormExtent: TPoint;
//#UC START# *4C08CF700318_4C6CDC7B00F2_var*
//#UC END# *4C08CF700318_4C6CDC7B00F2_var*
begin
//#UC START# *4C08CF700318_4C6CDC7B00F2_impl*
 Result.X := 768;
 Result.Y := 400;
//#UC END# *4C08CF700318_4C6CDC7B00F2_impl*
end;//TK233014754.FormExtent
{$IfEnd} //nsTest AND not NoVCM

function TK233014754.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK233014754.GetFolder

function TK233014754.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C6CDC7B00F2';
end;//TK233014754.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK233014754.Suite);

end.