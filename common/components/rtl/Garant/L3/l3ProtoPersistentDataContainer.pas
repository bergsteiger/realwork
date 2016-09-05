unit l3ProtoPersistentDataContainer;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPersistentDataContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoPersistentDataContainer" MUID: (4DD3BB3C03BC)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPersistent
 , l3PureMixIns
 , l3IID
 , l3Interfaces
;

type
 _l3DataContainer_Parent_ = Tl3ProtoPersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}
 _l3Changing_Parent_ = _l3DataContainer_;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3Changing_;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoPersistentDataContainer = {abstract} class(_l3COMQueryInterface_)
 end;//Tl3ProtoPersistentDataContainer

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 //#UC START# *4DD3BB3C03BCimpl_uses*
 //#UC END# *4DD3BB3C03BCimpl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

end.
