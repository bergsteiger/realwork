unit evQueryGroupList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evQueryGroupList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevQueryGroupList" MUID: (47D019BE0158)

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
 _ItemType_ = IevQueryGroup;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevQueryGroupList = class(_l3InterfaceRefList_)
 end;//TevQueryGroupList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47D019BE0158impl_uses*
 //#UC END# *47D019BE0158impl_uses*
;

type _Instance_R_ = TevQueryGroupList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
