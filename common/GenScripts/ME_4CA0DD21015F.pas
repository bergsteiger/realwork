unit NOT_FINISHED_SecuritySrv_int;

// Модуль: "w:\common\components\rtl\external\MTDOrb\build\NOT_FINISHED_SecuritySrv_int.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\l3Define.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
;

type
 TCoreSrv_SecuritySrv_Token = class
 end;//TCoreSrv_SecuritySrv_Token

 ICoreSrv_SecuritySrv_SessionManager = interface
  ['{577D0C09-6ECE-4F9E-96D7-279B2A0B4576}']
 end;//ICoreSrv_SecuritySrv_SessionManager
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
