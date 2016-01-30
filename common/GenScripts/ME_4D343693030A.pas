unit NOT_FINISHED_vcmTasksPanel;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\NOT_FINISHED_vcmTasksPanel.pas"
// Стереотип: "UtilityPack"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBase
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3Notifier_Parent_ = TvcmBase;
 {$Include l3Notifier.imp.pas}
 TvcmCustOpsNotifier = class(_l3Notifier_)
 end;//TvcmCustOpsNotifier
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
;

{$Include l3Notifier.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
