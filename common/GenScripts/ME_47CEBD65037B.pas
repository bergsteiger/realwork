unit evEditorControlList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evEditorControlList.pas"
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
 , l3PureMixIns
;

type
 _ItemType_ = IevEditorControl;
 _ListType_ = IevEditorControlList;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 _l3InterfacedList_Parent_ = _l3InterfaceRefList_;
 {$Include l3InterfacedList.imp.pas}
 TevEditorControlList = class(_l3InterfacedList_)
 end;//TevEditorControlList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TevEditorControlList;

{$Include l3InterfaceRefList.imp.pas}

{$Include l3InterfacedList.imp.pas}

end.
