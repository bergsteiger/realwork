unit evReqList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evReqList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evQueryCardInt
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevReq;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TevReqList = class(_l3InterfaceRefList_)
 end;//TevReqList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TevReqList;

{$Include l3InterfaceRefList.imp.pas}

end.
