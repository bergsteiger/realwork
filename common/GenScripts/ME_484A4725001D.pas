unit evdNative_Schema;
 {* Собственно схема документа EVD }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas"
// Стереотип: "TagTable"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdTasks_Schema
;

type
 // TevdNativeSchema

implementation

uses
 l3ImplUses
 , evdNative_AttrValues
;

initialization
 TevdNativeSchema.SetAsDefault;

end.
