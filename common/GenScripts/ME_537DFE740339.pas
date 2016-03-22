unit evdTasks_Schema;
 {* Схема для поддержки заданий в ALCU. Потом её надо будет выпилить отдельно }

// Модуль: "w:\common\components\rtl\Garant\EVD\evdTasks_Schema.pas"
// Стереотип: "TagTable"
// Элемент модели: "evdTasks" MUID: (537DFE740339)
// Имя типа: "TevdTasksSchema"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

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
