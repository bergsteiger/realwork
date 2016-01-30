unit evdTasks_Schema;
 {* Схема для поддержки заданий в ALCU. Потом её надо будет выпилить отдельно }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas"
// Стереотип: "TagTable"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , k2Native_Schema
;

type
 // TevdTasksSchema

implementation

uses
 l3ImplUses
 , ddTaskItemPrim
;

initialization
 TevdTasksSchema.SetAsDefault;

end.
