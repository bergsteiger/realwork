unit m3StoragePrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoragePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StoragePrim" MUID: (540F286903C7)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseStorage
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tm3BaseStorage;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StoragePrim = {abstract} class(_l3CriticalSectionHolder_)
 end;//Tm3StoragePrim

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *540F286903C7impl_uses*
 //#UC END# *540F286903C7impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

end.
