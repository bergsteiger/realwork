unit l3MouseWheelListenersList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MouseWheelListenersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3MouseWheelListenersList" MUID: (4F79BB5100DA)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3MouseWheelListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 Tl3MouseWheelListenersList = class(_l3InterfacePtrList_)
 end;//Tl3MouseWheelListenersList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F79BB5100DAimpl_uses*
 //#UC END# *4F79BB5100DAimpl_uses*
;

type _Instance_R_ = Tl3MouseWheelListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
