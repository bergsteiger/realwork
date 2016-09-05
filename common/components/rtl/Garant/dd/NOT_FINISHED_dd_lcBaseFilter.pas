unit NOT_FINISHED_dd_lcBaseFilter;
 {* Базовые фильтры }

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dd_lcBaseFilter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dd_lcBaseFilter" MUID: (4EA662DD02E1)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2TagFilter
 , ddHeaderFilter
;

type
 Tdd_lcParaFilter = class(TevdLeafParaFilter)
 end;//Tdd_lcParaFilter

 Tdd_lcBaseFilter = class(Tk2TagFilter)
 end;//Tdd_lcBaseFilter

 Tdd_lcSynoFilter = class(Tdd_lcBaseFilter)
 end;//Tdd_lcSynoFilter

 Tdd_lcBaseHeaderFilter = class(TddHeaderFilter)
 end;//Tdd_lcBaseHeaderFilter

implementation

uses
 l3ImplUses
 //#UC START# *4EA662DD02E1impl_uses*
 //#UC END# *4EA662DD02E1impl_uses*
;

end.
