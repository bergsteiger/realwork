unit m3StoragePrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoragePrim.pas"
// Стереотип: "SimpleClass"

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
;

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

end.
