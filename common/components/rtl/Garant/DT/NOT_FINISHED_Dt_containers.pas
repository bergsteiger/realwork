unit NOT_FINISHED_Dt_containers;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_Dt_containers.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Dt_containers" MUID: (537F6D3F0319)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , dtNumRangeList
;

type
 TNumSet = class(Tl3ProtoObject)
  private
   f_Ranges: TdtNumRangeList;
 end;//TNumSet
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *537F6D3F0319impl_uses*
 //#UC END# *537F6D3F0319impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.
