unit NOT_FINISHED_csMessageManager;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csMessageManager.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TcsMessageManager = class
 end;//TcsMessageManager
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMessageRecepientListPrim
 , csMessageRecepientList
;
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
