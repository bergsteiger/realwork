unit afwPreviewNotifierPtrList;
 {* Список УКАЗАТЕЛЕЙ на IafwPreviewNotifier. }

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\afwPreviewNotifierPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TafwPreviewNotifierPtrList" MUID: (47ED0A030258)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , afwInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IafwPreviewNotifier;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TafwPreviewNotifierPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IafwPreviewNotifier. }
 end;//TafwPreviewNotifierPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TafwPreviewNotifierPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
