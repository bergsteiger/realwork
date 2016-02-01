unit l3InterfacedInterfaceList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacedInterfaceList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3InterfaceList
 , l3Interfaces
 , l3PureMixIns
;

type
 _ListType_ = Il3InterfaceList;
 _l3InterfacedList_Parent_ = Tl3InterfaceList;
 {$Include l3InterfacedList.imp.pas}
 Tl3InterfacedInterfaceList = class(_l3InterfacedList_)
 end;//Tl3InterfacedInterfaceList

implementation

uses
 l3ImplUses
;

type _Instance_R_ = Tl3InterfacedInterfaceList;

{$Include l3InterfacedList.imp.pas}

end.
