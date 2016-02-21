unit OfficeLike_ResultEx_Controls;
 {* Результат диалога }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_ResultEx_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , OfficeLike_Result_Controls
;

type
 // Search

 // Save

 // AttributesSelect

 // Consult

 // Chat

 {$If NOT Defined(Monitorings)}
 // SaveAndSend
 {$IfEnd} // NOT Defined(Monitorings)

 // OkExt

 // Result
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
