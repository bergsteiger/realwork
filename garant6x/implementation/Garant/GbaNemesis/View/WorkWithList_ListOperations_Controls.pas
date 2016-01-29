unit WorkWithList_ListOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkWithList_ListOperations_Controls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::ListOperations
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vcmExternalInterfaces {a}
  ;

(* List = operations
  {* ������ }
   ['{E27EA2A0-C07E-4410-951E-BD3D7F23E60E}']
   operation SortDirection; has states;
     {* ���������� ����������� ���������� }
      Ascending = state
       { ������������� �� ����������� }
       { ������������� �� ����������� �������� }
      end;//Ascending
      Descending = state
       { ������������� �� �������� }
       { ������������� �� �������� �������� }
      end;//Descending
   operation Sort; has states;
     {* ����������� ������ }
   operation AnalizeList;
     {* ������ ������... }
   operation SortForReminders;
     {* ����������� ������ }
   operation SortDirectionForReminders; has states;
     {* ���������� ����������� ���������� }
      Ascending = state
       { ������������� �� ����������� }
      end;//Ascending
      Descending = state
       { ������������� �� �������� }
      end;//Descending
   operation OrAnotherListForReminders;
   operation AndAnotherListForReminders;
   operation AndNotAnotherListForReminders;
   operation SpecifyListForReminders;
   operation ListInfo;
   operation Sort;
   operation SortDirection; has states;
   operation SpecifyList;
   operation ExportToXML;
   query OrAnotherList;
   query AndAnotherList;
   query AndNotAnotherList;
   operation Analize;
     {* ������ ������ }
 end;//List*)

(* CRList = operations
   ['{01A3CC80-5F89-45A8-84E3-0B97545932D6}']
   operation SetType;
 end;//CRList*)

(* WarnListFiltered = operations
  {* �������������� � ������������� ������ }
   ['{DD1309C7-0FEE-495F-9F46-99F093A24342}']
   query ClearAll;
     {* �������� ��� ������� }
 end;//WarnListFiltered*)

(* Reminder = operations
   ['{C14B163A-D44B-441A-BB34-712A2CE628E9}']
   operation RemListModified;
   operation RemListFiltered;
   FormActivate RemListTimeMachineWarning;
 end;//Reminder*)

(* List = operations
  {* ������ }
   ['{876EDE4D-6A8C-4519-AD3D-4378D49C73A8}']
   FormActivate WorkWithList;
     {* ������ �� ������� }
 end;//List*)

(* DocumentInList = operations
   ['{B75280D8-48BE-49BC-87CF-9C977EA2BB35}']
   operation OpenDocumentInNewTab;
     {* ������� �������� � ����� ������� }
   operation OpenDocumentInNewWindow;
     {* ������� �������� � ����� ���� }
 end;//DocumentInList*)

(* SelectedDocuments = operations
   ['{E8BFBCA0-14C8-4D00-9B18-992885F719F6}']
   operation AddToControl; has states;
     {* ��������� �� �������� }
      RemoveFromControl = state
       { ����� � �������� }
      end;//RemoveFromControl
   operation MakeHyperlinkToDocument;
     {* ������� ������ �� �������� }
 end;//SelectedDocuments*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// ��������� ��������:
var st_user_List_SortDirection_Ascending : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ���������� ����������� ���������� <-> ������������� �� �����������
var st_user_List_SortDirection_Descending : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ���������� ����������� ���������� <-> ������������� �� ��������
var st_user_List_SortDirectionForReminders_Ascending : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ���������� ����������� ���������� <-> ������������� �� �����������
var st_user_List_SortDirectionForReminders_Descending : TvcmOperationStateIndex = (rID : -1);
  // ������ -> ���������� ����������� ���������� <-> ������������� �� ��������
var st_user_SelectedDocuments_AddToControl_RemoveFromControl : TvcmOperationStateIndex = (rID : -1);
  // SelectedDocuments -> ��������� �� �������� <-> ����� � ��������
{$IfEnd} //not Admin AND not Monitorings

implementation

end.