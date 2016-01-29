unit nsValueMapsIDs;
{* ���������� ���� "������"-"�����" }

{$I nsDefine.inc }

interface

uses
 afwInterfaces;

const
// ������-������
 // ��������� - �� ������� ������������� ��� ��������������
 smap_Settings: TafwValueMapID = (rName: 'Settings'; rID: 0);
 // ��������� - pi_IfaceLanguage - ���� ����������
 smap_pi_IfaceLanguage : TafwValueMapID = (rName: 'pi_IfaceLanguage'; rID: 1);
 // ��������� - pi_OpenOnStart - ��������� �������
 smap_pi_OpenOnStart : TafwValueMapID = (rName: 'pi_OpenOnStart'; rID: 2);
 // ��������� - pi_Search_SituationType - ����� �� ����������:
 smap_pi_Search_SituationType : TafwValueMapID = (rName: 'pi_Search_SituationType'; rID: 3);
 // ��������� - pi_piDocumentPictureScale - ������� ����������� �����������
 smap_piDocumentPictureScale : TafwValueMapID = (rName: 'piDocumentPictureScale'; rID: 4);
 // ��������� - pi_DropChangeStatus - ����� ������� ���������� �� ��������
 smap_pi_DropChangeStatus : TafwValueMapID = (rName: 'pi_DropChangeStatus'; rID: 5);
 // ��������� ����� ����������� ���������
 smap_ContextParamsCaptions : TafwValueMapID = (rName: 'ContextParamsCaptions'; rID: 6);
 // ������� ���� - ������ � ���������
 smap_InternetCaptions : TafwValueMapID = (rName: 'InternetItemType'; rID: 7);
 // ��������� - pi_Document_CRType - ���� ���������������/������������
 smap_SettingsCRType : TafwValueMapID = (rName: 'SettingsCRType'; rID: 8);
 // ������� ����� - ���� ���������������/������������
 //smap_BaseSearchCRType : TafwValueMapID = (rName: 'SettingsCRType'; rID: 9);

// ������-�����
 // ������������� - TUserListFilterTypes - ���� ���������� ������ �������������
 imap_UserListFilterTypes: TafwValueMapID = (rName: 'UserListFilterTypes'; rID: 0);
 // ��������� - pi_Document_PermanentSelection - ��������� ������
 imap_pi_Document_PermanentSelection: TafwValueMapID = (rName: 'pi_Document_PermanentSelection'; rID: 1);
 // ��������� - TbsLanguage - ���� ���������� ��� ��������
 imap_IfaceLanguage : TafwValueMapID = (rName: 'TbsLanguage'; rID: 2);
 // ��������� - TNavigatorState - ��������� ����������
 imap_NavigatorPosition : TafwValueMapID = (rName: 'TNavigatorState'; rID: 3);
 // ��������� - TnsNavigatorFormPositionType - ��������� ������� � ���������
 imap_NavigatorSheetPosition : TafwValueMapID = (rName: 'TnsNavigatorFormPositionType'; rID: 4);
 // ��������� - TbsSortType - ��� ���������� �� ��������� ��� �������
 imap_pi_List_SortType : TafwValueMapID = (rName: 'TbsSortType'; rID: 5);
 // ��������� - TbsSortOrder - ��������� ������� � ���������
 imap_pi_List_OrderType : TafwValueMapID = (rName: 'TbsSortOrder'; rID: 6);
 // ��������� - TlstCRType - ���� ��������������/������������ ��� ������� ���������
 imap_lstCRType : TafwValueMapID = (rName: 'TlstCRType'; rID: 7);
 // ??? - TbsLanguage - ����
 imap_Interface_Language : TafwValueMapID = (rName: 'TbsLanguage'; rID: 8);
 // ����� - TnsFolderFilter - ������� �����
 imap_FolderFilters : TafwValueMapID = (rName: 'TnsFolderFilter'; rID: 9);
 // �� �������� - TnsUCSortType - ��� ����������
 imap_UnderCOntrolSortType : TafwValueMapID = (rName: 'TnsUCSortType'; rID: 10);
 // ��������� - pi_MainMenuType - ��� ��������� ����:
 // http://mdp.garant.ru/pages/viewpage.action?pageId=434744658
 (*imap_pi_MainMenuType : TafwValueMapID = (rName: 'pi_MainMenuType'; rID: 13);*)
 // ��������� - imap_pi_BaseSearch_BuildShortList - ������ ����� �������� ������
 imap_pi_BaseSearch_BuildShortList : TafwValueMapID = (rName: 'pi_BaseSearch_BuildShortList'; rID: 15);
 // ��������� - TvcmMainFormOpenKind - ��������� ��� �������� ���������� � �����
 imap_DocumentAndLinkOpenKind : TafwValueMapID = (rName: 'TvcmMainFormOpenKind'; rID: 16);

implementation

end.

