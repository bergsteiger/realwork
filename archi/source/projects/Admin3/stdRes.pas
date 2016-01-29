unit stdRes;

{ $Id: stdRes.pas,v 1.1 2012/04/04 08:56:31 lulin Exp $}

// $Log: stdRes.pas,v $
// Revision 1.1  2012/04/04 08:56:31  lulin
// {RequestLink:237994598}
//
// Revision 1.38  2011/06/01 14:22:02  fireton
// - ����� ���� ���������� DocID
//
// Revision 1.37  2010/11/19 12:25:40  fireton
// - ����������� �������� ���
//
// Revision 1.36  2010/10/26 12:13:27  fireton
// - ������ � ������� �����
//
// Revision 1.35  2010/10/26 08:17:38  fireton
// - ��������� ����� �������� �� ������� �����
//
// Revision 1.34  2010/02/08 15:20:01  lulin
// {RequestLink:188416017}.
//
// Revision 1.33  2009/03/06 14:18:19  fireton
// - ������� ���������� � ����������� VCM
//
// Revision 1.32  2009/01/29 15:04:50  fireton
// - ����� �������� ����������� ���������� docid ��� ��������� ��������
//
// Revision 1.31  2009/01/29 14:22:48  fireton
// - ���������� ��� ����������� VCM
//
// Revision 1.30  2009/01/28 15:32:24  fireton
// - ���������� ��� ����������� VCM
//
// Revision 1.29  2008/09/29 08:47:27  fireton
// - bugfix: �������� ������ ����
//
// Revision 1.28  2008/06/30 14:35:24  fireton
// - ������ masked edit �� ������ ����� DocID � ��
//
// Revision 1.27  2008/04/04 15:18:19  fireton
// - ������� ������ ���������� �� ���������
//
// Revision 1.26  2007/10/31 14:34:58  fireton
// - ��������� � VCM
//
// Revision 1.25  2007/05/14 12:29:46  fireton
// no message
//
// Revision 1.24  2007/05/02 11:10:28  fireton
// - ������ ���������� ���������
//
// Revision 1.23  2007/04/27 08:46:17  fireton
// - ������ ���������. ������� ������� � ���� � ����� "�����".
//
// Revision 1.22  2007/02/19 15:19:40  fireton
// - "admin" flag ������ �������������� � �������������
// - ������� �������� ��������� ������
// - ������ "� ���������" � ������� ������
//
// Revision 1.21  2006/11/30 15:37:31  fireton
// - ������� � ���������
//
// Revision 1.20  2006/11/22 16:22:21  fireton
// - ������� �� ����� ���������� VCM
//
// Revision 1.19  2006/06/08 15:55:50  fireton
// - ���������� � �������� �� ������� User ID
//
// Revision 1.18.2.1  2006/06/08 09:26:50  fireton
// - ������� User ID �� Longword
//
// Revision 1.18  2006/02/15 14:15:37  fireton
// - ������������ ��� � ������/������� �������������
//
// Revision 1.17  2006/02/14 11:20:44  fireton
// - ���������� �������� �����
//
// Revision 1.16  2006/02/07 15:33:34  fireton
// - ����� ������������� (������������)
//
// Revision 1.15  2006/02/03 07:17:44  fireton
// - ����� ���������� ����� �������������
//
// Revision 1.14  2006/02/01 16:08:23  fireton
// - ������ � ���� � ������
//
// Revision 1.13  2005/09/23 14:53:27  fireton
// - ��������� ���������� � �������� �����
//
// Revision 1.12  2005/09/14 10:52:26  fireton
// - add: �������� ���������� ����� ��������� (����� � �������������)
//
// Revision 1.11  2005/09/12 14:10:46  fireton
// - add: ���������� ������ ��� ��������� ������ ����� � �������������
//
// Revision 1.10  2005/09/09 13:51:31  fireton
// - add: ��������� ����������� �������������� ������ ������������� ������ ������
//
// Revision 1.9  2005/08/30 10:17:22  fireton
// - ��������� ������� �������������� ���� ����� � ������ ��������
//
// Revision 1.7  2005/08/26 13:16:55  fireton
// - ������������� ������ (������� ������ + bug fix)
//
// Revision 1.6  2005/08/22 13:13:29  fireton
// - ������������� ������ (���������� ���������� ����� - bug fix � ������ �������������)
//
// Revision 1.4  2005/08/20 11:05:54  fireton
// - ������������� ������ (���������� ���������� ����� � �������� ��� ������)
//
// Revision 1.2  2005/08/17 14:10:58  fireton
// - ������������� ������ (�������� ��� ������� ������)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - ������ ������
//

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList,
  ActnMan,

  l3InterfacedComponent,

  vcmInterfaces,
  vcmBaseMenuManager,
  vcmMenuManager,
  vcmComponent,
  vcmBaseEntities,
  vcmExternalInterfaces,
  vcmGUI;

type
  TdmStdRes = class(TDataModule)
    MenuManager: TvcmMenuManager;
    ActionManager: TActionList;
    ilOffice: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmStdRes: TdmStdRes;

const // start VCM generated section
  xxCxx_op_user_Loadable_Load : TvcmOPID = (rEnID : 1; rOpID : 1);
   // enLoadable -> opLoad
  xxCxx_op_user_Reminder_RemMWControlledChangingWarning : TvcmOPID = (rEnID : 2; rOpID : 1);
   // enReminder -> opRemMWControlledChangingWarning
  xxCxx_op_user_Reminder_RemMWOldBaseWarning : TvcmOPID = (rEnID : 2; rOpID : 2);
   // enReminder -> opRemMWOldBaseWarning
  xxCxx_op_user_Reminder_RemMWGlobalFiltersWarning : TvcmOPID = (rEnID : 2; rOpID : 3);
   // enReminder -> opRemMWGlobalFiltersWarning
  xxCxx_op_user_Result_Cancel : TvcmOPID = (rEnID : 3; rOpID : 1);
   // enResult -> opCancel
  xxCxx_op_user_System_UpdateComplete : TvcmOPID = (rEnID : 4; rOpID : 1);
   // enSystem -> opUpdateComplete
  xxCxx_op_user_System_ActiveConfigChange : TvcmOPID = (rEnID : 4; rOpID : 2);
   // enSystem -> opActiveConfigChange
  xxCxx_op_user_System_ConfigUpdated : TvcmOPID = (rEnID : 4; rOpID : 3);
   // enSystem -> opConfigUpdated
  xxCxx_op_user_System_BookmarkList : TvcmOPID = (rEnID : 4; rOpID : 4);
   // enSystem -> opBookmarkList
  xxCxx_op_user_Tools_BigBrother : TvcmOPID = (rEnID : 5; rOpID : 1);
   // ����������� -> ������� ����
  xxCxx_op_Tools_BaseSwitch : TvcmOPID = (rEnID : 5; rOpID : 2);
   // ����������� -> ����������� ����
  xxCxx_op_user_Tools_SupervisorPassword : TvcmOPID = (rEnID : 5; rOpID : 3);
   // ����������� -> ������� ������ �����������
  xxCxx_op_user_Tools_DocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 4);
   // ����������� -> ��������� ������� ����������
  xxCxx_op_user_Tools_ListDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 5);
   // ����������� -> �������� DocID (�������)
  xxCxx_op_user_Tools_ListDocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 6);
   // ����������� -> ��������� ������� ���������� (�������)
  xxCxx_op_user_Tools_Lawcase : TvcmOPID = (rEnID : 5; rOpID : 7);
   // ����������� -> opLawcaseIDRangeEdit
  xxCxx_op_user_Tools_LawcaseIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 8);
   // ����������� -> ��������� ������� ���������� (����������� ��������)
  xxCxx_op_user_Tools_Opo : TvcmOPID = (rEnID : 5; rOpID : 9);
   // ����������� -> opVASDocIDRangeEdit
  xxCxx_op_user_Tools_VASDocIDRangeEdit : TvcmOPID = (rEnID : 5; rOpID : 10);
   // ����������� -> ��������� ������� ���������� (������������� ���)
  xxCxx_op_user_Tools_SPBDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 11);
   // ����������� -> ��������� ������� ���������� (�����-���������)
  xxCxx_op_user_Tools_SvOblDocIDEdit : TvcmOPID = (rEnID : 5; rOpID : 12);
   // ����������� -> ��������� ������� ���������� (������������ �������)
  xxCxx_op_user_History_Back : TvcmOPID = (rEnID : 6; rOpID : 1);
   // ������� -> opBack
  xxCxx_op_user_History_Forward : TvcmOPID = (rEnID : 6; rOpID : 2);
   // ������� -> opForward
  xxCxx_op_user_Common_OpenNewWindowByUser : TvcmOPID = (rEnID : 7; rOpID : 1);
   // ���� -> opOpenNewWindowByUser
  xxCxx_op_user_Common_OpenNewWindow : TvcmOPID = (rEnID : 7; rOpID : 2);
   // ���� -> opOpenNewWindow
  xxCxx_op_user_Common_Exit : TvcmOPID = (rEnID : 7; rOpID : 3);
   // ���� -> opExit
  xxCxx_op_user_Common_GetWindowList : TvcmOPID = (rEnID : 7; rOpID : 4);
   // ���� -> opGetWindowList
  xxCxx_op_user_Common_ShowSplitter : TvcmOPID = (rEnID : 7; rOpID : 5);
   // ���� -> opShowSplitter
  xxCxx_op_user_Common_CheckChildZone : TvcmOPID = (rEnID : 7; rOpID : 6);
   // ���� -> opCheckChildZone
  xxCxx_op_user_Common_MemUsage : TvcmOPID = (rEnID : 7; rOpID : 7);
   // ���� -> opMemUsage
  xxCxx_op_user_Common_OnControlChanged : TvcmOPID = (rEnID : 7; rOpID : 8);
   // ���� -> opOnControlChanged
  xxCxx_op_user_Common_OnGlobalFilterChanged : TvcmOPID = (rEnID : 7; rOpID : 9);
   // ���� -> opOnGlobalFilterChanged
  xxCxx_op_user_Common_CascadeWindows : TvcmOPID = (rEnID : 7; rOpID : 10);
   // ���� -> opCascadeWindows
  xxCxx_op_user_Common_TileWindowsHorizontal : TvcmOPID = (rEnID : 7; rOpID : 11);
   // ���� -> opTileWindowsHorizontal
  xxCxx_op_user_Common_TileWindowsVertical : TvcmOPID = (rEnID : 7; rOpID : 12);
   // ���� -> opTileWindowsVertical
  xxCxx_op_user_Common_CloseAllWindows : TvcmOPID = (rEnID : 7; rOpID : 13);
   // ���� -> opCloseAllWindows
  xxCxx_op_user_Navigator_SetLeftFloat : TvcmOPID = (rEnID : 8; rOpID : 1);
   // ������ ���������� -> opSetLeftFloat
  xxCxx_op_user_Navigator_SetRightFloat : TvcmOPID = (rEnID : 8; rOpID : 2);
   // ������ ���������� -> opSetRightFloat
  xxCxx_op_user_Navigator_FormHideBegin : TvcmOPID = (rEnID : 8; rOpID : 3);
   // ������ ���������� -> opFormHideBegin
  xxCxx_op_user_Navigator_FormHideEnd : TvcmOPID = (rEnID : 8; rOpID : 4);
   // ������ ���������� -> opFormHideEnd
  xxCxx_op_user_Switcher_SetActive : TvcmOPID = (rEnID : 9; rOpID : 1);
   // ������������� �������� -> opSetActive
  xxCxx_op_user_Switcher_SetIcon : TvcmOPID = (rEnID : 9; rOpID : 2);
   // ������������� �������� -> opSetIcon
  xxCxx_op_user_Find_Search : TvcmOPID = (rEnID : 10; rOpID : 1);
   // ����� -> ������
  xxCxx_op_user_Find_SearchMore : TvcmOPID = (rEnID : 10; rOpID : 2);
   // ����� -> ������ ������
  xxCxx_op_user_Edit_Delete : TvcmOPID = (rEnID : 11; rOpID : 1);
   // ������������� -> �������
  xxCxx_op_user_Edit_Create : TvcmOPID = (rEnID : 11; rOpID : 2);
   // ������������� -> �������
  xxCxx_op_user_Properties_Save : TvcmOPID = (rEnID : 12; rOpID : 1);
   // �������� -> ���������
  xxCxx_op_user_Properties_Revert : TvcmOPID = (rEnID : 12; rOpID : 2);
   // �������� -> ������������
  xxCxx_op_user_Help_HelpTopics : TvcmOPID = (rEnID : 13; rOpID : 1);
   // ������� -> opHelpTopics
  xxCxx_op_user_Help_HelpShortCuts : TvcmOPID = (rEnID : 13; rOpID : 2);
   // ������� -> opHelpShortCuts
  xxCxx_op_user_Help_HelpNewFeatures : TvcmOPID = (rEnID : 13; rOpID : 3);
   // ������� -> opHelpNewFeatures
  xxCxx_op_user_Help_ContactInformation : TvcmOPID = (rEnID : 13; rOpID : 4);
   // ������� -> opContactInformation
  xxCxx_op_user_Help_ReplyBook : TvcmOPID = (rEnID : 13; rOpID : 5);
   // ������� -> opReplyBook
  xxCxx_op_user_Help_GarantInternet : TvcmOPID = (rEnID : 13; rOpID : 6);
   // ������� -> opGarantInternet
  xxCxx_op_user_Help_About : TvcmOPID = (rEnID : 13; rOpID : 7);
   // ������� -> � ���������...
  xxCxx_op_user_StatusBar_Clean : TvcmOPID = (rEnID : 14; rOpID : 1);
   // ������ ��������� -> opClean
  xxCxx_op_user_StatusBar_AddField : TvcmOPID = (rEnID : 14; rOpID : 2);
   // ������ ��������� -> opAddField
  xxCxx_op_user_StatusBar_SetValue : TvcmOPID = (rEnID : 14; rOpID : 3);
   // ������ ��������� -> opSetValue
  xxCxx_op_user_File_Save : TvcmOPID = (rEnID : 15; rOpID : 1);
   // ���� -> ��������
  xxCxx_op_user_File_Print : TvcmOPID = (rEnID : 15; rOpID : 2);
   // ���� -> ����������
  xxCxx_op_user_File_Exit : TvcmOPID = (rEnID : 15; rOpID : 3);
   // ���� -> �����
  xxCxx_op_Test_Test : TvcmOPID = (rEnID : 16; rOpID : 1);
   // ���� -> opSave
  xxCxx_op_user_Test_Save : TvcmOPID = (rEnID : 16; rOpID : 2);
   // ���� -> ��������
  xxCxx_op_user_Fonts_IncreaseFont : TvcmOPID = (rEnID : 17; rOpID : 1);
   // ������ -> opIncreaseFont
  xxCxx_op_user_Fonts_DecreaseFont : TvcmOPID = (rEnID : 17; rOpID : 2);
   // ������ -> opDecreaseFont
  xxCxx_op_user_ExportImport_Export : TvcmOPID = (rEnID : 18; rOpID : 1);
   // �������/������ -> ������� �������������
  xxCxx_op_user_ExportImport_Import : TvcmOPID = (rEnID : 18; rOpID : 2);
   // �������/������ -> ������ �������������
  mop_Admin_OpenUsersList : TvcmMOPID = (rMoID : 1; rOpID : 1);
   // moAdmin -> opOpenUsersList
const // - �������������� ����
  fm_MainForm : TvcmFormID = (rName : 'MainForm'; rID: 1);
   // "����������". ������������� �������
  fm_cfHorizontal : TvcmFormID = (rName : 'cfHorizontal'; rID: 2);
   // a
  fm_enMarkedListForm : TvcmFormID = (rName : 'enMarkedListForm'; rID: 3);
   // a
  fm_cfProps : TvcmFormID = (rName : 'cfProps'; rID: 4);
   // cfProps
  fm_cfVertical : TvcmFormID = (rName : 'cfVertical'; rID: 5);
   // cfVertical
  fm_efUserList : TvcmFormID = (rName : 'efUserList'; rID: 6);
   // efUserList
  fm_en1 : TvcmFormID = (rName : 'en1'; rID: 7);
   // en1
  fm_enBigBrotherForm : TvcmFormID = (rName : 'enBigBrotherForm'; rID: 8);
   // enBigBrotherForm
  fm_enGroupRightsForm : TvcmFormID = (rName : 'enGroupRightsForm'; rID: 9);
   // enGroupRightsForm
  fm_enNoEditForm : TvcmFormID = (rName : 'enNoEditForm'; rID: 10);
   // enNoEditForm
  fm_enRigthsValuesForm : TvcmFormID = (rName : 'enRigthsValuesForm'; rID: 11);
   // enRigthsValuesForm
  fm_enUserTree : TvcmFormID = (rName : 'enUserTree'; rID: 12);
   // enUserTree
  fm_nsMainWindow : TvcmFormID = (rName : 'nsMainWindow'; rID: 13);
   // ������ ��������� F1
  fm_enUserGroupPropetriesForm : TvcmFormID = (rName : 'enUserGroupPropetriesForm'; rID: 14);
   // �������� ������
  fm_enUserPropertiesForm : TvcmFormID = (rName : 'enUserPropertiesForm'; rID: 15);
   // �������� ������������
type // ���������������� ���� ����� "a"
  TcfHorizontalUT = (
           utHUserProperties, // �������� ������������
           utHUserGroupProperties  // �������� ������
  ); //TcfHorizontalUT
type // ���������������� ���� ����� "a"
  TenMarkedListFormUT = (
           utGroupsList, // ������ �������������
           utUsersList  // ������ �������������
  ); //TenMarkedListFormUT
type // ���������������� ���� ����� "cfProps"
  TcfPropsUT = (
           utProperties  // utProperties
  ); //TcfPropsUT
type // ���������������� ���� ����� "cfVertical"
  TcfVerticalUT = (
           utVGeneral, // utVGeneral
           utVGroupRights  // utVGroupRights
  ); //TcfVerticalUT
type // ���������������� ���� ����� "efUserList"
  TefUserListUT = (
           admUserList  // ������ ������������� � �����
  ); //TefUserListUT
type // ���������������� ���� ����� "enBigBrotherForm"
  TenBigBrotherFormUT = (
           ugBigBrother  // ������� ����
  ); //TenBigBrotherFormUT
type // ���������������� ���� ����� "enGroupRightsForm"
  TenGroupRightsFormUT = (
           utGroupRights  // utGroupRights
  ); //TenGroupRightsFormUT
type // ���������������� ���� ����� "enNoEditForm"
  TenNoEditFormUT = (
           utNoEdit  // utNoEdit
  ); //TenNoEditFormUT
type // ���������������� ���� ����� "enRigthsValuesForm"
  TenRigthsValuesFormUT = (
           utRightsValues  // utRightsValues
  ); //TenRigthsValuesFormUT
type // ���������������� ���� ����� "enUserTree"
  TenUserTreeUT = (
           utUsersTree  // utUsersTree
  ); //TenUserTreeUT
type // ���������������� ���� ����� "������ ��������� F1"
  TnsMainWindowUT = (
           utMainWindow  // ������� ����
  ); //TnsMainWindowUT
type // ���������������� ���� ����� "�������� ������"
  TenUserGroupPropetriesFormUT = (
           utUserGroupPropetries  // �������� ������
  ); //TenUserGroupPropetriesFormUT
type // ���������������� ���� ����� "�������� ������������"
  TenUserPropertiesFormUT = (
           utUserProperties  // ������ ������������
  ); //TenUserPropertiesFormUT
const // - �������������� ������
  fs_Admin : TvcmFormSetID = (rName : 'fsAdmin');
   // ������ ���� "������������� ������������� � �����"
  fs_List : TvcmFormSetID = (rName : 'fs_List');
   // ������ ���� "������"
const // - �������������� ���������
  inf_msgFinishSearch : TvcmMessageID = (rM : 0);
   // "����� ��������. ��������� �� �������."
// end VCM generated section

implementation

{$R *.dfm}

end.
