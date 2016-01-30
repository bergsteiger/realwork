unit evDescriptionReqList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDescriptionReqList.pas"
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
 _ItemType_ = IevDescriptionReq;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TevDescriptionReqList = class(_l3InterfaceRefList_)
 end;//TevDescriptionReqList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TevDescriptionReqList;

{$Include l3InterfaceRefList.imp.pas}

end.
