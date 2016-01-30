unit NOT_FINISHED_Dt_containers;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_Dt_containers.pas"
// Стереотип: "UtilityPack"

{$Include DtDefine.inc}

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.
