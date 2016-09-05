unit l3CBTListenersList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CBTListenersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3CBTListenersList" MUID: (4F66F88103D4)

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
 _ItemType_ = Il3CBTListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 Tl3CBTListenersList = class(_l3InterfacePtrList_)
 end;//Tl3CBTListenersList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F66F88103D4impl_uses*
 //#UC END# *4F66F88103D4impl_uses*
;

type _Instance_R_ = Tl3CBTListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
