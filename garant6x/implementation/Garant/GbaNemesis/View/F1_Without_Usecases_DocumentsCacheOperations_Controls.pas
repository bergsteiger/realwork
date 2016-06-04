unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "DocumentsCacheOperations" MUID: (5391D16303CD)

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
 en_DocumentsCache = 'DocumentsCache';
 en_capDocumentsCache = '';
 op_Clear = 'Clear';
 op_capClear = 'Очистить кэш документов';
 op_Disable = 'Disable';
 op_capDisable = 'Запретить кэш документов';

var st_user_DocumentsCache_Disable_Disable: TvcmOperationStateIndex = (rID : -1);
 {*  -> Запретить кэш документов <->  }
var st_user_DocumentsCache_Disable_Enable: TvcmOperationStateIndex = (rID : -1);
 {*  -> Запретить кэш документов <->  }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
