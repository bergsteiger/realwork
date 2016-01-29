unit pgUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::PG::Provider::pgUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  LibPQ
  ;

procedure PgCheckStatus(aResult: PPGresult);
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  pgInterfaces
  ;

// unit methods

procedure PgCheckStatus(aResult: PPGresult);
//#UC START# *5604F2A802A0_5604F2910025_var*
//#UC END# *5604F2A802A0_5604F2910025_var*
begin
//#UC START# *5604F2A802A0_5604F2910025_impl*
 if Assigned(aResult) and (PQresultStatus(aResult) in [PGRES_BAD_RESPONSE, PGRES_NONFATAL_ERROR, PGRES_FATAL_ERROR]) then
  raise EpgError.Create(PQresultErrorMessage(aResult));
//#UC END# *5604F2A802A0_5604F2910025_impl*
end;//PgCheckStatus
{$IfEnd} //UsePostgres

end.