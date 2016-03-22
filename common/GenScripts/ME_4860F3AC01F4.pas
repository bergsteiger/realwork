unit My_Schema;

// Модуль: "w:\common\components\gui\Garant\Everest\My_Schema.pas"
// Стереотип: "TagTable"
// Элемент модели: "My" MUID: (4860F3AC01F4)
// Имя типа: "TMySchema"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evMyEditor)}
uses
 l3IntfUses
 , Everest_Schema
;

type
 // TMySchema
{$IfEnd} // Defined(evMyEditor)

implementation

{$If Defined(evMyEditor)}
uses
 l3ImplUses
;

initialization
 TMySchema.SetAsDefault;
{$IfEnd} // Defined(evMyEditor)

end.
