unit evEditorControlFieldList;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evEditorControlFieldList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEditorControlFieldList" MUID: (47CEDDA9005A)

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
 _ItemType_ = IevEditorControlField;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevEditorControlFieldList = class(_l3InterfaceRefList_)
 end;//TevEditorControlFieldList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TevEditorControlFieldList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
