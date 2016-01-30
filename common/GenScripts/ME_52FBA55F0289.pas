unit NOT_FINISHED_dt_UserTypes;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_UserTypes.pas"
// Стереотип: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TArchiUser = class(Tl3ProtoObject)
 end;//TArchiUser
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
