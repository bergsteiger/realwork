unit nsFiltersListenersList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Filters\nsFiltersListenersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFiltersListenersList" MUID: (4F98251800B4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , nsFiltersInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsFiltersListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsFiltersListenersList = class(_l3InterfacePtrList_)
 end;//TnsFiltersListenersList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F98251800B4impl_uses*
 //#UC END# *4F98251800B4impl_uses*
;

type _Instance_R_ = TnsFiltersListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
