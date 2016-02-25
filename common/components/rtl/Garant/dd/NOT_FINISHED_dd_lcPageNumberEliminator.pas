unit NOT_FINISHED_dd_lcPageNumberEliminator;
 {* Удаляет псевдономера страниц из текста судебных постановлений }

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dd_lcPageNumberEliminator.pas"
// Стереотип: "SimpleClass"

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
;

end.
