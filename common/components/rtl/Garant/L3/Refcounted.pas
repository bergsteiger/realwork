unit Refcounted;

// Модуль: "w:\common\components\rtl\Garant\L3\Refcounted.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 _RefCounted_Parent_ = TObject;
 {$Include RefCounted.imp.pas}
 TRefcounted = class(_RefCounted_)
 end;//TRefcounted

implementation

uses
 l3ImplUses
 , Windows
;

{$Include RefCounted.imp.pas}

end.
