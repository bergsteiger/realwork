unit IafwSettingsReplaceListenerPtrList;
 {* Список УКАЗАТЕЛЕЙ на IafwSettingsReplaceListener }

// Модуль: "w:\common\components\gui\Garant\AFW\IafwSettingsReplaceListenerPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TIafwSettingsReplaceListenerPtrList" MUID: (491441E201E0)

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
 _ItemType_ = IafwSettingsReplaceListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwSettingsReplaceListenerPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IafwSettingsReplaceListener }
 end;//TIafwSettingsReplaceListenerPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *491441E201E0impl_uses*
 //#UC END# *491441E201E0impl_uses*
;

type _Instance_R_ = TIafwSettingsReplaceListenerPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
