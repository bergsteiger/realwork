unit nsNodeBaseList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\nsNodeBaseList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , DynamicTreeUnit
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = INodeBase;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TnsNodeBaseList = class(_l3InterfaceRefList_)
 end;//TnsNodeBaseList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnsNodeBaseList;

{$Include l3InterfaceRefList.imp.pas}

end.
