unit NOT_FINISHED_SecuritySrv_int;

// ������: "w:\common\components\rtl\external\MTDOrb\build\NOT_FINISHED_SecuritySrv_int.pas"
// ���������: "UtilityPack"
// ������� ������: "SecuritySrv_int" MUID: (4CA0DD21015F)

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
 //#UC START# *4CA0DD21015Fimpl_uses*
 //#UC END# *4CA0DD21015Fimpl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
