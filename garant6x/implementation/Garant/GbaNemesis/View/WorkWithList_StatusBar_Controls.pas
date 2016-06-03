unit WorkWithList_StatusBar_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_StatusBar_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "StatusBar" MUID: (4B20DE9B0154)

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
 en_Selection = 'Selection';
 en_capSelection = 'Выделенные элементы';
 op_Analize = 'Analize';
 op_capAnalize = 'Анализ списка...';
 op_CopyToNewList = 'CopyToNewList';
 op_capCopyToNewList = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
