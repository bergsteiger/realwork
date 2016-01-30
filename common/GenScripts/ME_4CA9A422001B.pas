unit l3InterfacedIntegerList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacedIntegerList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoIntegerList
 , l3Interfaces
;

type
 Tl3InterfacedIntegerList = class(Tl3ProtoIntegerList, Il3IntegerList)
  protected
   function pm_GetCount: Integer;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3InterfacedIntegerList

implementation

uses
 l3ImplUses
;

function Tl3InterfacedIntegerList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4CA9A422001Bget_var*
//#UC END# *4BB08B8902F2_4CA9A422001Bget_var*
begin
//#UC START# *4BB08B8902F2_4CA9A422001Bget_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4CA9A422001Bget_impl*
end;//Tl3InterfacedIntegerList.pm_GetCount

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3InterfacedIntegerList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4CA9A422001B_var*
//#UC END# *47A6FEE600FC_4CA9A422001B_var*
begin
//#UC START# *47A6FEE600FC_4CA9A422001B_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4CA9A422001B_impl*
end;//Tl3InterfacedIntegerList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
