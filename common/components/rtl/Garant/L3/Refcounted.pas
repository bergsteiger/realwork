unit Refcounted;

// Модуль: "w:\common\components\rtl\Garant\L3\Refcounted.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TRefcounted" MUID: (516137AD0362)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 _RefCounted_Parent_ = TObject;
 {$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}
 TRefcounted = class(_RefCounted_)
 end;//TRefcounted

implementation

uses
 l3ImplUses
 , Windows
 //#UC START# *516137AD0362impl_uses*
 //#UC END# *516137AD0362impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

end.
