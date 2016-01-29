unit K209584437;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K209584437.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.5::K209584437
//
// {RequestLink:209584437}
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
 TK209584437 = class(TSearchAndReplaceTest)
  {* [RequestLink:209584437] }
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
 end;//TK209584437
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

// start class TK209584437

{$If defined(nsTest) AND not defined(NoVCM)}
function TK209584437.StringForSearch: AnsiString;
//#UC START# *4BE051200169_4BE122870343_var*
//#UC END# *4BE051200169_4BE122870343_var*
begin
//#UC START# *4BE051200169_4BE122870343_impl*
 Result := 'атестационная';
//#UC END# *4BE051200169_4BE122870343_impl*
end;//TK209584437.StringForSearch
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
function TK209584437.StringForReplace: AnsiString;
//#UC START# *4BE0513800C9_4BE122870343_var*
//#UC END# *4BE0513800C9_4BE122870343_var*
begin
//#UC START# *4BE0513800C9_4BE122870343_impl*
 Result := 'XXX';
//#UC END# *4BE0513800C9_4BE122870343_impl*
end;//TK209584437.StringForReplace
{$IfEnd} //nsTest AND not NoVCM

function TK209584437.GetFolder: AnsiString;
 {-}
begin
 Result := '7.5';
end;//TK209584437.GetFolder

function TK209584437.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BE122870343';
end;//TK209584437.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK209584437.Suite);

end.