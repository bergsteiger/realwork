unit Admin_Users_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin_Users_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 �������������::Admin::View::Users
//
// �������� ��� ����� � �������� �������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  vcmExternalInterfaces {a}
  ;

(* Users = operations
  {* ������������ }
   ['{0B5DD01F-00EA-4EBA-83B9-539EAEFC687F}']
   operation LogoutUser; has states;
     {* ��������� ������������ }
      SingleUser = state
      end;//SingleUser
      MultiUsers = state
       { ��������� ���������� ������������� }
      end;//MultiUsers
   query ConsultingStateForNewbie; has states;
     {* ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
      Enabled = state
       { ��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
      end;//Enabled
      Disabled = state
       { ��������� ����� ��������� ������������� ������������� ������ ��������� ����������� }
      end;//Disabled
   query Autoregistration; has states;
     {* ���������/��������� ��������������� ����� ������������� }
      Enabled = state
       { ��������� ��������������� ����� ������������� }
      end;//Enabled
      Disabled = state
       { ��������� ��������������� ����� ������������� }
      end;//Disabled
   operation AddPrivelegedRight; has states;
     {* ������� ���������� ������������� ������������������ }
      MultiUsers = state
      end;//MultiUsers
      SingleUser = state
       { ������� ����������������� }
      end;//SingleUser
   operation RemovePrivelegedRight; has states;
     {* �������� ��� ���������� ������������� ����� ���������� }
      MultiUsers = state
      end;//MultiUsers
      SingleUser = state
       { �������� ����� ���������� }
      end;//SingleUser
   operation UserFilter;
   operation DisableConsulting;
   operation EnableConsulting;
   operation MakeFiltersShared;
     {* ������� ������� ������� ������������ ������ }
   operation DenyDeleteIdle;
     {* �� ������� ��� ����������� }
   operation Add;
     {* �������� }
 end;//Users*)

(* Groups = operations
  {* ������ }
   ['{8E4CE498-63B9-40FF-8F38-9206BEECDD02}']
   operation Add;
     {* �������� }
   operation ChangeBaseAccess;
   operation Rename;
     {* ������������� ������ }
 end;//Groups*)

(* Result = operations
   ['{41A48F4D-7C40-4F47-BF30-91E4FF0E3B80}']
   operation Save; has states;
     {* ��������� }
      Create = state
       { ������� }
      end;//Create
   operation Save;
 end;//Result*)
{$IfEnd} //Admin

{$If defined(Admin)}
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

// ��������� ��������:
var st_user_Users_LogoutUser_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ��������� ������������ <-> SingleUser
var st_user_Users_LogoutUser_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ��������� ������������ <-> ��������� ���������� �������������
var st_user_Users_ConsultingStateForNewbie_Enabled : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� <-> ��������� ����� ��������� ������������� ������������� ������ ��������� �����������
var st_user_Users_ConsultingStateForNewbie_Disabled : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ���������/��������� ����� ��������� ������������� ������������� ������ ��������� ����������� <-> ��������� ����� ��������� ������������� ������������� ������ ��������� �����������
var st_user_Users_Autoregistration_Enabled : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ���������/��������� ��������������� ����� ������������� <-> ��������� ��������������� ����� �������������
var st_user_Users_Autoregistration_Disabled : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ���������/��������� ��������������� ����� ������������� <-> ��������� ��������������� ����� �������������
var st_user_Users_AddPrivelegedRight_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ������� ���������� ������������� ������������������ <-> MultiUsers
var st_user_Users_AddPrivelegedRight_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> ������� ���������� ������������� ������������������ <-> ������� �����������������
var st_user_Users_RemovePrivelegedRight_MultiUsers : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> �������� ��� ���������� ������������� ����� ���������� <-> MultiUsers
var st_user_Users_RemovePrivelegedRight_SingleUser : TvcmOperationStateIndex = (rID : -1);
  // ������������ -> �������� ��� ���������� ������������� ����� ���������� <-> �������� ����� ����������
var st_user_Result_Save_Create : TvcmOperationStateIndex = (rID : -1);
  // Result -> ��������� <-> �������
{$IfEnd} //Admin

implementation

end.