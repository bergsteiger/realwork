unit NOT_COMPLETED_nevRangePrim;
 {* Выделенная часть объекта }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_nevRangePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevRangePrim" MUID: (4BAA279500E6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evLocation
 , nevTools
;

type
 TnevRangePrim = class(TevLocation, InevRangePrim)
  {* Выделенная часть объекта }
 end;//TnevRangePrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evSelection
 , nevFacade
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
