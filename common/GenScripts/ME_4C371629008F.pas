unit WorkWithList_ListOperations_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_ListOperations_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "ListOperations" MUID: (4C371629008F)

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
 en_List = 'List';
 en_capList = '������';
 op_SortDirection = 'SortDirection';
 op_capSortDirection = '���������� ����������� ����������';
 op_Sort = 'Sort';
 op_capSort = '����������� ������';
 op_AnalizeList = 'AnalizeList';
 op_capAnalizeList = '������ ������...';
 op_SortForReminders = 'SortForReminders';
 op_capSortForReminders = '����������� ������';
 op_SortDirectionForReminders = 'SortDirectionForReminders';
 op_capSortDirectionForReminders = '���������� ����������� ����������';
 op_OrAnotherListForReminders = 'OrAnotherListForReminders';
 op_capOrAnotherListForReminders = '';
 op_AndAnotherListForReminders = 'AndAnotherListForReminders';
 op_capAndAnotherListForReminders = '';
 op_AndNotAnotherListForReminders = 'AndNotAnotherListForReminders';
 op_capAndNotAnotherListForReminders = '';
 op_SpecifyListForReminders = 'SpecifyListForReminders';
 op_capSpecifyListForReminders = '';
 op_ListInfo = 'ListInfo';
 op_capListInfo = '';
 op_SpecifyList = 'SpecifyList';
 op_capSpecifyList = '';
 op_ExportToXML = 'ExportToXML';
 op_capExportToXML = '';
 op_OrAnotherList = 'OrAnotherList';
 op_capOrAnotherList = '';
 op_AndAnotherList = 'AndAnotherList';
 op_capAndAnotherList = '';
 op_AndNotAnotherList = 'AndNotAnotherList';
 op_capAndNotAnotherList = '';
 op_Analize = 'Analize';
 op_capAnalize = '������ ������';
 en_CRList = 'CRList';
 en_capCRList = '';
 op_SetType = 'SetType';
 op_capSetType = '';
 en_WarnListFiltered = 'WarnListFiltered';
 en_capWarnListFiltered = '�������������� � ������������� ������';
 op_ClearAll = 'ClearAll';
 op_capClearAll = '�������� ��� �������';
 en_Reminder = 'Reminder';
 en_capReminder = '';
 op_RemListModified = 'RemListModified';
 op_capRemListModified = '';
 op_RemListFiltered = 'RemListFiltered';
 op_capRemListFiltered = '';
 op_RemListTimeMachineWarning = 'RemListTimeMachineWarning';
 op_capRemListTimeMachineWarning = '';
 op_WorkWithList = 'WorkWithList';
 op_capWorkWithList = '������ �� �������';
 en_DocumentInList = 'DocumentInList';
 en_capDocumentInList = '';
 op_OpenDocumentInNewTab = 'OpenDocumentInNewTab';
 op_capOpenDocumentInNewTab = '������� �������� � ����� �������';
 op_OpenDocumentInNewWindow = 'OpenDocumentInNewWindow';
 op_capOpenDocumentInNewWindow = '������� �������� � ����� ����';
 en_SelectedDocuments = 'SelectedDocuments';
 en_capSelectedDocuments = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = '��������� �� ��������';
 op_MakeHyperlinkToDocument = 'MakeHyperlinkToDocument';
 op_capMakeHyperlinkToDocument = '������� ������ �� ��������';

var st_user_List_SortDirection_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ���������� ����������� ���������� <-> ������������� �� ����������� }
var st_user_List_SortDirection_Descending: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ���������� ����������� ���������� <-> ������������� �� �������� }
var st_user_List_SortDirectionForReminders_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ���������� ����������� ���������� <-> ������������� �� ����������� }
var st_user_List_SortDirectionForReminders_Descending: TvcmOperationStateIndex = (rID : -1);
 {* ������ -> ���������� ����������� ���������� <-> ������������� �� �������� }
var st_user_SelectedDocuments_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> ��������� �� �������� <-> ����� � �������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
