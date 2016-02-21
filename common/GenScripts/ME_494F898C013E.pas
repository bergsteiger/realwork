unit OfficeLike_Usual_Controls;
 {* "Обычные" операции }

// Модуль: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
;

type
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 // Controlled
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

 {$If Defined(Admin)}
 // User
 {$IfEnd} // Defined(Admin)

 {$If Defined(Admin)}
 // MultiUsers
 {$IfEnd} // Defined(Admin)

 {$If Defined(Admin)}
 // Group
 {$IfEnd} // Defined(Admin)

 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 // Contact
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

 // Delete

 // Edit

 // File

 // Common

 // History
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
