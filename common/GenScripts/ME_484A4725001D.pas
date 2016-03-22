unit evdNative_Schema;
 {* Собственно схема документа EVD }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdNative_Schema.pas"
// Стереотип: "TagTable"
// Элемент модели: "evdNative" MUID: (484A4725001D)
// Имя типа: "TevdNativeSchema"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

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
