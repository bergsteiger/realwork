unit k2Native_Schema;
 {* Стандартная таблица тегов. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2Native_Schema.pas"
// Стереотип: "TagTable"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2Core_Schema
;

type
 // Tk2NativeSchema

implementation

uses
 l3ImplUses
;

initialization
 Tk2NativeSchema.SetAsDefault;

end.
