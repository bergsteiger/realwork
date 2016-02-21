unit pgUtils;

// Модуль: "w:\common\components\rtl\Garant\PG\pgUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , LibPQ
;

procedure pgCheckStatus(aResult: PPGresult);
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , pgInterfaces
;

procedure pgCheckStatus(aResult: PPGresult);
//#UC START# *5604F2A802A0_5604F2910025_var*
//#UC END# *5604F2A802A0_5604F2910025_var*
begin
//#UC START# *5604F2A802A0_5604F2910025_impl*
 if Assigned(aResult) and (PQresultStatus(aResult) in [PGRES_BAD_RESPONSE, PGRES_NONFATAL_ERROR, PGRES_FATAL_ERROR]) then
  raise EpgError.Create(PQresultErrorMessage(aResult));
//#UC END# *5604F2A802A0_5604F2910025_impl*
end;//pgCheckStatus
{$IfEnd} // Defined(UsePostgres)

end.
