unit m3BaseStore;

// ������: "w:\common\components\rtl\Garant\m3\m3BaseStore.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m2InternalInterfaces
 , m3StorageInterfaces
;

type
 _m3BaseStore_Parent_ = Tl3CProtoObject;
 {$Include w:\common\components\rtl\Garant\m3\m3BaseStore.imp.pas}
 Tm3BaseStore = {abstract} class(_m3BaseStore_)
 end;//Tm3BaseStore

implementation

uses
 l3ImplUses
 , ActiveX
;

{$Include w:\common\components\rtl\Garant\m3\m3BaseStore.imp.pas}

end.
