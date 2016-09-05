unit l3DataContainerWithoutIUnknownPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3DataContainerWithoutIUnknownPrim" MUID: (5319E8FF0107)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CastablePersistent
 , l3PureMixIns
 , l3IID
 , l3Interfaces
;

 {$Define l3Unknown_NoIUnknown}

 {$Undef l3Unknown_NoMultiThread}

type
 _l3Unknown_Parent_ = Tl3CastablePersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 _l3DataContainer_Parent_ = _l3Unknown_;
 {$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3DataContainer_;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 Tl3DataContainerWithoutIUnknownPrim = {abstract} class(_l3COMQueryInterface_)
 end;//Tl3DataContainerWithoutIUnknownPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , l3InterfacesMisc
 //#UC START# *5319E8FF0107impl_uses*
 //#UC END# *5319E8FF0107impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

end.
