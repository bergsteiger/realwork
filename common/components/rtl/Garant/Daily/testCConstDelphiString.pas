unit testCConstDelphiString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/testCConstDelphiString.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::DailyTest::TestStrings::TtestCConstDelphiString
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
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TtestCConstDelphiString = class(Tl3CConstDelphiString)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 end;//TtestCConstDelphiString
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TtestCConstDelphiString

{$If not defined(DesignTimeLibrary)}
class function TtestCConstDelphiString.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_55793634010B_var*
//#UC END# *47A6FEE600FC_55793634010B_var*
begin
//#UC START# *47A6FEE600FC_55793634010B_impl*
 Result := True;
//#UC END# *47A6FEE600FC_55793634010B_impl*
end;//TtestCConstDelphiString.IsCacheable
{$IfEnd} //not DesignTimeLibrary

{$IfEnd} //nsTest AND not NoScripts

end.