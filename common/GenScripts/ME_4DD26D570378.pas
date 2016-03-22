unit l3ProtoObjectWithCOMQI;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoObjectWithCOMQI.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoObjectWithCOMQI" MUID: (4DD26D570378)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3IID
 , l3Interfaces
;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 Tl3ProtoObjectWithCOMQI = class(_l3COMQueryInterface_)
 end;//Tl3ProtoObjectWithCOMQI

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
;

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

end.
