unit k2ParentedTypedHugeListTag;
 {* Список параграфов с числом атрибутов больше 32 }

// Модуль: "w:\common\components\rtl\Garant\K2\k2ParentedTypedHugeListTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2ParentedTypedHugeListTag" MUID: (4FBE24BC0158)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TypedHugeListTag
 , l3Variant
;

type
 _k2ParentedTagObject_Parent_ = Tk2TypedHugeListTag;
 {$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}
 Tk2ParentedTypedHugeListTag = class(_k2ParentedTagObject_)
  {* Список параграфов с числом атрибутов больше 32 }
 end;//Tk2ParentedTypedHugeListTag

implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
 , l3BitArr
 , l3Memory
 //#UC START# *4FBE24BC0158impl_uses*
 //#UC END# *4FBE24BC0158impl_uses*
;

{$Include w:\common\components\rtl\Garant\K2\k2ParentedTagObject.imp.pas}

end.
