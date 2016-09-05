unit l3ProtoDataContainerWithCOMQI;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoDataContainerWithCOMQI.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoDataContainerWithCOMQI" MUID: (4B277EE00256)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3IID
 , l3Interfaces
;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoDataContainer;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoDataContainerWithCOMQI = class(_l3COMQueryInterface_)
 end;//Tl3ProtoDataContainerWithCOMQI

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 //#UC START# *4B277EE00256impl_uses*
 //#UC END# *4B277EE00256impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

end.
