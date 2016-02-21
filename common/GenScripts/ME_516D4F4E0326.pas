unit myInterfacedObject;

// Модуль: "w:\common\components\SandBox\myInterfacedObject.pas"
// Стереотип: "SimpleClass"

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
;

{$Include w:\common\components\rtl\Garant\L3\Unknown.imp.pas}

end.
