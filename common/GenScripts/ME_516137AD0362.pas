unit Refcounted;

// Модуль: "w:\common\components\rtl\Garant\L3\Refcounted.pas"
// Стереотип: "SimpleClass"

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
;

{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

end.
