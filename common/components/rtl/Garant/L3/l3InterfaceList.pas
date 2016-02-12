unit l3InterfaceList;
 {* Список интерфейсов. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfaceList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IUnknown;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 Tl3InterfaceList = class(_l3InterfaceRefList_)
  {* Список интерфейсов. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//Tl3InterfaceList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tl3InterfaceList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3InterfaceList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4773DC580043_var*
//#UC END# *47A6FEE600FC_4773DC580043_var*
begin
//#UC START# *47A6FEE600FC_4773DC580043_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4773DC580043_impl*
end;//Tl3InterfaceList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
