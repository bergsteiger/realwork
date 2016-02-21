unit l3CObjectList;
 {* Кешируемый список указателей на объекты. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3CObjectList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectList
;

type
 Tl3CObjectList = class(Tl3ObjectList)
  {* Кешируемый список указателей на объекты. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CObjectList

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CObjectList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DBEA0260_var*
//#UC END# *47A6FEE600FC_4773DBEA0260_var*
begin
//#UC START# *47A6FEE600FC_4773DBEA0260_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DBEA0260_impl*
end;//Tl3CObjectList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
