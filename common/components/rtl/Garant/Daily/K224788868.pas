unit K224788868;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K224788868.pas"
// Начат: 08.07.2010 12:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K224788868
//
// {RequestLink:224788868}
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
 TK224788868 = class(TSearchAndReplaceTest)
  {* [RequestLink:224788868] }
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
 end;//TK224788868
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

// start class TK224788868

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224788868.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4C358BF70329_var*
//#UC END# *4BE051200169_4C358BF70329_var*
begin
//#UC START# *4BE051200169_4C358BF70329_impl*
 Result := 'хаба';
//#UC END# *4BE051200169_4C358BF70329_impl*
end;//TK224788868.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK224788868.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4C358BF70329_var*
//#UC END# *4BE0513800C9_4C358BF70329_var*
begin
//#UC START# *4BE0513800C9_4C358BF70329_impl*
 Result := 'дабамаба';
//#UC END# *4BE0513800C9_4C358BF70329_impl*
end;//TK224788868.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK224788868.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK224788868.GetFolder

function TK224788868.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C358BF70329';
end;//TK224788868.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK224788868.Suite);

end.