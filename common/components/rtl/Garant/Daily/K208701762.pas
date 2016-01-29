unit K208701762;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K208701762.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K208701762
//
// {RequestLink:208701762}
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
  SearchAndReplaceTest
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK208701762 = class(TSearchAndReplaceTest)
  {* [RequestLink:208701762] }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForSearch: AnsiString; override;
     {* Строка для поиска }
   {$IfEnd} //nsTest AND not NoVCM
   {$If defined(nsTest) AND not defined(NoVCM)}
   function StringForReplace: AnsiString; override;
     {* Строка для замены }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK208701762
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

// start class TK208701762

{$If defined(nsTest) AND not defined(NoVCM)}
function TK208701762.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4BE046FF0067_var*
//#UC END# *4BE051200169_4BE046FF0067_var*
begin
//#UC START# *4BE051200169_4BE046FF0067_impl*
 Result := 'атестационная';
//#UC END# *4BE051200169_4BE046FF0067_impl*
end;//TK208701762.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK208701762.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4BE046FF0067_var*
//#UC END# *4BE0513800C9_4BE046FF0067_var*
begin
//#UC START# *4BE0513800C9_4BE046FF0067_impl*
 Result := 'аттестационная';
//#UC END# *4BE0513800C9_4BE046FF0067_impl*
end;//TK208701762.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK208701762.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK208701762.GetFolder

function TK208701762.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BE046FF0067';
end;//TK208701762.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK208701762.Suite);

end.