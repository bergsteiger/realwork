unit NOT_FINISHED_CsNotification;

// ������: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsNotification.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , evdTaskTypes
;

type
 TCsNotificationType = evdTaskTypes.TCsNotificationType;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
