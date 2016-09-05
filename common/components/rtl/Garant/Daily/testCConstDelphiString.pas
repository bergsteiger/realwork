unit testCConstDelphiString;

// Модуль: "w:\common\components\rtl\Garant\Daily\testCConstDelphiString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtestCConstDelphiString" MUID: (55793634010B)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Base
;

type
 TtestCConstDelphiString = class(Tl3CConstDelphiString)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//TtestCConstDelphiString
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *55793634010Bimpl_uses*
 //#UC END# *55793634010Bimpl_uses*
;

{$If NOT Defined(DesignTimeLibrary)}
class function TtestCConstDelphiString.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_55793634010B_var*
//#UC END# *47A6FEE600FC_55793634010B_var*
begin
//#UC START# *47A6FEE600FC_55793634010B_impl*
 Result := True;
//#UC END# *47A6FEE600FC_55793634010B_impl*
end;//TtestCConstDelphiString.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
