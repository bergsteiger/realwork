unit UnderControl_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4CCACDDC0101)

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
 en_ControlCenter = 'ControlCenter';
 en_capControlCenter = '';
 op_Add = 'Add';
 op_capAdd = '';
 op_CreateList = 'CreateList';
 op_capCreateList = '';
 op_Sort = 'Sort';
 op_capSort = '';
 op_ClearAllStatus = 'ClearAllStatus';
 op_capClearAllStatus = '';
 en_ControledObject = 'ControledObject';
 en_capControledObject = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_ClearStatus = 'ClearStatus';
 op_capClearStatus = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
