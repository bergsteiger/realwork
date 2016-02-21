unit evArchi_Schema;
 {* Схема документа для Архивариуса }

// Модуль: "w:\common\components\gui\Garant\Everest\evArchi_Schema.pas"
// Стереотип: "TagTable"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(Archi)}
uses
 l3IntfUses
 , Everest_Schema
;

type
 // TevArchiSchema
{$IfEnd} // Defined(Archi)

implementation

{$If Defined(Archi)}
uses
 l3ImplUses
;

initialization
 TevArchiSchema.SetAsDefault;
{$IfEnd} // Defined(Archi)

end.
