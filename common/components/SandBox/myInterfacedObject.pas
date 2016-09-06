unit myInterfacedObject;

// Модуль: "w:\common\components\SandBox\myInterfacedObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmyInterfacedObject" MUID: (516D4F4E0326)

{$Include w:\common\components\SandBox\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _Unknown_Parent_ = TObject;
 {$Include w:\common\components\rtl\Garant\L3\Unknown.imp.pas}
 TmyInterfacedObject = class(_Unknown_)
 end;//TmyInterfacedObject

implementation

uses
 l3ImplUses
 , Windows
 //#UC START# *516D4F4E0326impl_uses*
 //#UC END# *516D4F4E0326impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\Unknown.imp.pas}

end.
