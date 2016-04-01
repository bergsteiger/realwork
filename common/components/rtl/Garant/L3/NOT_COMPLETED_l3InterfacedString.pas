unit NOT_COMPLETED_l3InterfacedString;
 {* Реализация интерфейса строки }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_COMPLETED_l3InterfacedString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3InterfacedString" MUID: (47CC4CCC02FA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3NCString
 , l3Interfaces
;

type
 Tl3InterfacedString = class(Tl3NCString, Il3CString)
  {* Реализация интерфейса строки }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3InterfacedString

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwIl3CStringPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3InterfacedString.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_47CC4CCC02FA_var*
//#UC END# *47A6FEE600FC_47CC4CCC02FA_var*
begin
//#UC START# *47A6FEE600FC_47CC4CCC02FA_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47CC4CCC02FA_impl*
end;//Tl3InterfacedString.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
