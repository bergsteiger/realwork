unit evDescriptionReqList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDescriptionReqList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDescriptionReqList" MUID: (47CEE423036C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevDescriptionReqList = class(_l3InterfaceRefList_)
 end;//TevDescriptionReqList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47CEE423036Cimpl_uses*
 //#UC END# *47CEE423036Cimpl_uses*
;

type _Instance_R_ = TevDescriptionReqList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
