unit evEditorControlList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evEditorControlList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEditorControlList" MUID: (47CEBD65037B)

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
 , l3PureMixIns
;

type
 _ItemType_ = IevEditorControl;
 _ListType_ = IevEditorControlList;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 _l3InterfacedList_Parent_ = _l3InterfaceRefList_;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 TevEditorControlList = class(_l3InterfacedList_)
 end;//TevEditorControlList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47CEBD65037Bimpl_uses*
 //#UC END# *47CEBD65037Bimpl_uses*
;

type _Instance_R_ = TevEditorControlList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

end.
