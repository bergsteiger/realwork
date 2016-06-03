unit Admin_Users_Controls;
 {* �������� ��� ����� � �������� �������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_Users_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Users" MUID: (494FD61000CC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Users = 'Users';
 en_capUsers = '������������';
 op_LogoutUser = 'LogoutUser';
 op_capLogoutUser = '��������� ������������';
 op_ConsultingStateForNewbie = 'ConsultingStateForNewbie';
 op_capConsultingStateForNewbie = '���������/��������� ����� ��������� ������������� ������������� ������ ��������� �����������';
 op_Autoregistration = 'Autoregistration';
 op_capAutoregistration = '���������/��������� ��������������� ����� �������������';
 op_AddPrivelegedRight = 'AddPrivelegedRight';
 op_capAddPrivelegedRight = '������� ���������� ������������� ������������������';
 op_RemovePrivelegedRight = 'RemovePrivelegedRight';
 op_capRemovePrivelegedRight = '�������� ��� ���������� ������������� ����� ����������';
 op_UserFilter = 'UserFilter';
 op_capUserFilter = '';
 op_DisableConsulting = 'DisableConsulting';
 op_capDisableConsulting = '';
 op_EnableConsulting = 'EnableConsulting';
 op_capEnableConsulting = '';
 op_MakeFiltersShared = 'MakeFiltersShared';
 op_capMakeFiltersShared = '������� ������� ������� ������������ ������';
 op_DenyDeleteIdle = 'DenyDeleteIdle';
 op_capDenyDeleteIdle = '�� ������� ��� �����������';
 op_Add = 'Add';
 op_capAdd = '��������';
 en_Groups = 'Groups';
 en_capGroups = '������';
 op_ChangeBaseAccess = 'ChangeBaseAccess';
 op_capChangeBaseAccess = '';
 op_Rename = 'Rename';
 op_capRename = '������������� ������';
 en_Result = 'Result';
 en_capResult = '';
 op_Save = 'Save';
 op_capSave = '���������';

var st_user_Users_LogoutUser_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ��������� ������������ <->  }
var st_user_Users_LogoutUser_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ��������� ������������ <-> ��������� ���������� ������������� }
var st_user_Users_ConsultingStateForNewbie_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� <-> ��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
var st_user_Users_ConsultingStateForNewbie_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� <-> ��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
var st_user_Users_Autoregistration_Enabled: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ���������/��������� ��������������� ����� ������������� <-> ��������� ��������������� ����� ������������� }
var st_user_Users_Autoregistration_Disabled: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ���������/��������� ��������������� ����� ������������� <-> ��������� ��������������� ����� ������������� }
var st_user_Users_AddPrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ������� ���������� ������������� ������������������ <->  }
var st_user_Users_AddPrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> ������� ���������� ������������� ������������������ <-> ������� ����������������� }
var st_user_Users_RemovePrivelegedRight_MultiUsers: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> �������� ��� ���������� ������������� ����� ���������� <->  }
var st_user_Users_RemovePrivelegedRight_SingleUser: TvcmOperationStateIndex = (rID : -1);
 {* ������������ -> �������� ��� ���������� ������������� ����� ���������� <-> �������� ����� ���������� }
var st_user_Result_Save_Create: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� <-> ������� }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Admin)

end.
