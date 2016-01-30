unit NOT_FINISHED_DT_DbInfo;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_DT_DbInfo.pas"
// Стереотип: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , dtFamilyInfoList
;

type
 TDbInfo = class(Tl3ProtoObject)
  private
   f_FamiliesData: TdtFamilyInfoList;
 end;//TDbInfo
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
