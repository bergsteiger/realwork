unit NOT_FINISHED_dt_Mail;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_Mail.pas"
// ���������: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TMailServer = class
 end;//TMailServer
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
