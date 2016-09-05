unit ImsmEventsSubscriberList;

// Модуль: "w:\common\components\gui\Garant\msm\ImsmEventsSubscriberList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TImsmEventsSubscriberList" MUID: (57AB4966013D)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmEvents
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmEventsSubscriber;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TImsmEventsSubscriberList = class(_l3InterfacePtrList_)
 end;//TImsmEventsSubscriberList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57AB4966013Dimpl_uses*
 //#UC END# *57AB4966013Dimpl_uses*
;

type _Instance_R_ = TImsmEventsSubscriberList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
