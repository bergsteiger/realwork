unit BaseSearch_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "BaseSearch" MUID: (4C43D2BB005A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_EnclosedForms = 'EnclosedForms';
 en_capEnclosedForms = '';
 op_CloseChild = 'CloseChild';
 op_capCloseChild = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
