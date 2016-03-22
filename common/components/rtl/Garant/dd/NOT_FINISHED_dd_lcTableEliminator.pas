unit NOT_FINISHED_dd_lcTableEliminator;
 {* Удаляет таблицы из текста }

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dd_lcTableEliminator.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dd_lcTableEliminator" MUID: (4EA5339801FB)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , evdBufferedFilter
;

type
 TlcTableEliminator = class(Tk2TagFilter)
 end;//TlcTableEliminator

 TlcTableEliminator2 = class(TevdCustomChildBufferedFilter)
 end;//TlcTableEliminator2

implementation

uses
 l3ImplUses
;

end.
