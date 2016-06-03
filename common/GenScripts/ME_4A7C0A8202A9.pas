unit Base_Operations_View_Controls;
 {* �������� �������� �� ��������� ������������� �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_View_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "View" MUID: (4A7C0A8202A9)

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
 en_Document = 'Document';
 en_capDocument = '��������';
 op_ShowJurorComments = 'ShowJurorComments';
 op_capShowJurorComments = '��������/������ ����������� �������';
 op_ShowUserComments = 'ShowUserComments';
 op_capShowUserComments = '��������/������ ��� �����������';
 op_ShowTechComments = 'ShowTechComments';
 op_capShowTechComments = '���������� ����������� �����������';
 op_ShowVersionComments = 'ShowVersionComments';
 op_capShowVersionComments = '��������/��������� ���������� �� ���������� ���������';
 op_ShowCommentsGroup = 'ShowCommentsGroup';
 op_capShowCommentsGroup = '�����������';

var st_user_Document_ShowJurorComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ����������� ������� <-> ������ ����������� ������� }
var st_user_Document_ShowJurorComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ����������� ������� <-> �������� ����������� ������� }
var st_user_Document_ShowUserComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ��� ����������� <-> ������ ��� ����������� }
var st_user_Document_ShowUserComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/������ ��� ����������� <-> �������� ��� ����������� }
var st_user_Document_ShowTechComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������� ����������� ����������� <->  }
var st_user_Document_ShowTechComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ���������� ����������� ����������� <->  }
var st_user_Document_ShowVersionComments_Hide: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/��������� ���������� �� ���������� ��������� <-> ��������� ���������� �� ���������� ��������� }
var st_user_Document_ShowVersionComments_Show: TvcmOperationStateIndex = (rID : -1);
 {* �������� -> ��������/��������� ���������� �� ���������� ��������� <-> �������� ���������� �� ���������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
