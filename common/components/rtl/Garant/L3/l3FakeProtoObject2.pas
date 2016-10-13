unit l3FakeProtoObject2;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FakeProtoObject2.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FakeProtoObject2" MUID: (MSM39F096F9ECB4)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _l3ObjectPtrList_Parent_ = Tl3ProtoObject;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 Tl3FakeProtoObject2 = class(_l3ObjectPtrList_)
 end;//Tl3FakeProtoObject2

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *MSM39F096F9ECB4impl_uses*
 //#UC END# *MSM39F096F9ECB4impl_uses*
;

type _Instance_R_ = Tl3FakeProtoObject2;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

end.
