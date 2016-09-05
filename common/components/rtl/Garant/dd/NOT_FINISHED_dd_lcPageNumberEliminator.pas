unit NOT_FINISHED_dd_lcPageNumberEliminator;
 {* Удаляет псевдономера страниц из текста судебных постановлений }

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dd_lcPageNumberEliminator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tdd_lcPageNumberEliminator" MUID: (4EA5353F022A)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
;

type
 Tdd_lcPageNumberEliminator = class(TevdChildBufferedFilter)
  {* Удаляет псевдономера страниц из текста судебных постановлений }
 end;//Tdd_lcPageNumberEliminator

implementation

uses
 l3ImplUses
 //#UC START# *4EA5353F022Aimpl_uses*
 //#UC END# *4EA5353F022Aimpl_uses*
;

end.
