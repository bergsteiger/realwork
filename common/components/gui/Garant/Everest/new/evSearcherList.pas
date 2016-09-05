unit evSearcherList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evSearcherList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSearcherList" MUID: (47E7CDD60349)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevSearcher;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevSearcherList = class(_l3InterfaceRefList_)
 end;//TevSearcherList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47E7CDD60349impl_uses*
 //#UC END# *47E7CDD60349impl_uses*
;

type _Instance_R_ = TevSearcherList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
