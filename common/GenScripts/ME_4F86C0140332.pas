unit NOT_FINISHED_nsIntegrationSupport;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NOT_FINISHED_nsIntegrationSupport.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TnsLinkDataArray = array of ;

 PnsLinkDataArray = ^TnsLinkDataArray;

 TIntegrationData = packed record
 end;//TIntegrationData

 PIntegrationData = ^TIntegrationData;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
