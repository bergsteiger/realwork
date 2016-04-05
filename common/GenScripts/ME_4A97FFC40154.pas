unit Folders_Result_Controls;
 {* Результат диалога }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Result_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Result" MUID: (4A97FFC40154)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
