unit OfficeLike_Usual_Controls;
 {* "�������" �������� }

// ������: "w:\common\components\gui\Garant\VCM\UserInteraction\OfficeLike_Usual_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Usual" MUID: (494F898C013E)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
;

const
 en_Edit = 'Edit';
 en_capEdit = '������';
 op_Delete = 'Delete';
 op_capDelete = '�������';
 en_File = 'File';
 en_capFile = '����';
 op_Print = 'Print';
 op_capPrint = '������';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = '������...';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = '��������������� ��������';
 op_Save = 'Save';
 op_capSave = '���������';
 en_Common = 'Common';
 en_capCommon = '����';
 op_Exit = 'Exit';
 op_capExit = '';
 en_History = 'History';
 en_capHistory = '�������';
 op_Back = 'Back';
 op_capBack = '�����';
 op_Forward = 'Forward';
 op_capForward = '�����';

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Controlled: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ����� � �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$If Defined(Admin)}
var st_user_Edit_Delete_User: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������������ }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ���������� ������������� }
{$IfEnd} // Defined(Admin)
{$If Defined(Admin)}
var st_user_Edit_Delete_Group: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������ }
{$IfEnd} // Defined(Admin)
{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
var st_user_Edit_Delete_Contact: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ������� <-> ������� ������������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
