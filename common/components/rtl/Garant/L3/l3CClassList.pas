unit l3CClassList;
 {* Кешируемый список классов. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3CClassList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ClassList
;

type
 Tl3CClassList = class(Tl3ClassList)
  {* Кешируемый список классов. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3CClassList

implementation

uses
 l3ImplUses
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3CClassList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DC3502A7_var*
//#UC END# *47A6FEE600FC_4773DC3502A7_var*
begin
//#UC START# *47A6FEE600FC_4773DC3502A7_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC3502A7_impl*
end;//Tl3CClassList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
