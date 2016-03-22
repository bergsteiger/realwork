unit Document;

// Модуль: ""
// Стереотип: "TagOverride"
// Элемент модели: "Document" MUID: (54BE5365004B)
// Имя типа: "DocumentTag"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

 // DocumentTag
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
