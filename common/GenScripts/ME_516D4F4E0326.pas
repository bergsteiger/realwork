unit myInterfacedObject;

// Модуль: "w:\common\components\SandBox\myInterfacedObject.pas"
// Стереотип: "SimpleClass"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 _Unknown_Parent_ = TObject;
 {$Include Unknown.imp.pas}
 TmyInterfacedObject = class(_Unknown_)
 end;//TmyInterfacedObject

implementation

uses
 l3ImplUses
 , Windows
;

{$Include Unknown.imp.pas}

end.
