unit nsMedicFirmsSubscribersList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsSubscribersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMedicFirmsSubscribersList" MUID: (49071C6300FF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , bsInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsMedicFirmsTreeNotifyRecipient;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TnsMedicFirmsSubscribersList = class(_l3InterfacePtrList_)
 end;//TnsMedicFirmsSubscribersList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnsMedicFirmsSubscribersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
