unit K460275638Suite;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/K460275638Suite.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::DailyTest::RegExpUtils::TK460275638Suite
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
  CustomFolderTestSuite
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK460275638Suite = class(TCustomFolderTestSuite)
 protected
 // overridden protected methods
   function GetExt: AnsiString; override;
 end;//TK460275638Suite
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK460275638Suite

function TK460275638Suite.GetExt: AnsiString;
//#UC START# *4EA50C04021B_51BB0020030A_var*
//#UC END# *4EA50C04021B_51BB0020030A_var*
begin
//#UC START# *4EA50C04021B_51BB0020030A_impl*
 Result := '.regexp';
//#UC END# *4EA50C04021B_51BB0020030A_impl*
end;//TK460275638Suite.GetExt

{$IfEnd} //nsTest AND not NoScripts

end.