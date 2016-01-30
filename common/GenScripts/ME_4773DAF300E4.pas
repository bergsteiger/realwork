unit l3CObjectRefList;
 {* Кешируемый список ссылок на объекты. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3CObjectRefList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectRefList1
;

type
 Tl3CObjectRefList = class(Tl3ObjectRefList1)
  {* Кешируемый список ссылок на объекты. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CObjectRefList

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CObjectRefList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DAF300E4_var*
//#UC END# *47A6FEE600FC_4773DAF300E4_var*
begin
//#UC START# *47A6FEE600FC_4773DAF300E4_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DAF300E4_impl*
end;//Tl3CObjectRefList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
