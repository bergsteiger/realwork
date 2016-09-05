unit l3ProtoObjectPtrList;
 {* Список УКАЗАТЕЛЕЙ на Tl3ProtoObject }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoObjectPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoObjectPtrList" MUID: (4CE5224102C0)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3ProtoObject;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 Tl3ProtoObjectPtrList = class(_l3ObjectPtrList_)
  {* Список УКАЗАТЕЛЕЙ на Tl3ProtoObject }
 end;//Tl3ProtoObjectPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4CE5224102C0impl_uses*
 //#UC END# *4CE5224102C0impl_uses*
;

type _Instance_R_ = Tl3ProtoObjectPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

end.
