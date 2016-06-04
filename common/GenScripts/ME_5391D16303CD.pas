unit F1_Without_Usecases_DocumentsCacheOperations_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Without_Usecases_DocumentsCacheOperations_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "DocumentsCacheOperations" MUID: (5391D16303CD)

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
 op_capClear = '�������� ��� ����������';
 op_Disable = 'Disable';
 op_capDisable = '��������� ��� ����������';

var st_user_DocumentsCache_Disable_Disable: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� ��� ���������� <->  }
var st_user_DocumentsCache_Disable_Enable: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� ��� ���������� <->  }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
