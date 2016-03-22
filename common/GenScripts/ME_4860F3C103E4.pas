unit F1_Schema;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas"
// Стереотип: "TagTable"
// Элемент модели: "F1" MUID: (4860F3C103E4)
// Имя типа: "TF1Schema"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , Everest_Schema
;

type
 // TF1Schema
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeDocument_Schema
 , F1_AttrValues
;

initialization
 TF1Schema.SetAsDefault;
{$IfEnd} // Defined(Nemesis)

end.
