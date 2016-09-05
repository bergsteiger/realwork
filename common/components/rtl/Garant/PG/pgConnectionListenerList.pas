unit pgConnectionListenerList;

// Модуль: "w:\common\components\rtl\Garant\PG\pgConnectionListenerList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgConnectionListenerList" MUID: (5769249C0015)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , pgInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IpgConnectionListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TpgConnectionListenerList = class(_l3InterfacePtrList_)
 end;//TpgConnectionListenerList
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5769249C0015impl_uses*
 //#UC END# *5769249C0015impl_uses*
;

type _Instance_R_ = TpgConnectionListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // Defined(UsePostgres)

end.
