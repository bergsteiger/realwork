unit WorkWithList_ListOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkWithList_ListOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "ListOperations" MUID: (4C371629008F)

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
 en_capList = 'Список';
 op_SortDirection = 'SortDirection';
 op_capSortDirection = 'Установить направление сортировки';
 op_Sort = 'Sort';
 op_capSort = 'Сортировать список';
 op_AnalizeList = 'AnalizeList';
 op_capAnalizeList = 'Анализ списка...';
 op_SortForReminders = 'SortForReminders';
 op_capSortForReminders = 'Сортировать список';
 op_SortDirectionForReminders = 'SortDirectionForReminders';
 op_capSortDirectionForReminders = 'Установить направление сортировки';
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
 op_capAnalize = 'Анализ списка';
 en_CRList = 'CRList';
 en_capCRList = '';
 op_SetType = 'SetType';
 op_capSetType = '';
 en_WarnListFiltered = 'WarnListFiltered';
 en_capWarnListFiltered = 'Предупреждение о фильтрованном списке';
 op_ClearAll = 'ClearAll';
 op_capClearAll = 'Отменить все фильтры';
 en_Reminder = 'Reminder';
 en_capReminder = '';
 op_RemListModified = 'RemListModified';
 op_capRemListModified = '';
 op_RemListFiltered = 'RemListFiltered';
 op_capRemListFiltered = '';
 op_RemListTimeMachineWarning = 'RemListTimeMachineWarning';
 op_capRemListTimeMachineWarning = '';
 op_WorkWithList = 'WorkWithList';
 op_capWorkWithList = 'Работа со списком';
 en_DocumentInList = 'DocumentInList';
 en_capDocumentInList = '';
 op_OpenDocumentInNewTab = 'OpenDocumentInNewTab';
 op_capOpenDocumentInNewTab = 'Открыть документ в новой вкладке';
 op_OpenDocumentInNewWindow = 'OpenDocumentInNewWindow';
 op_capOpenDocumentInNewWindow = 'Открыть документ в новом окне';
 en_SelectedDocuments = 'SelectedDocuments';
 en_capSelectedDocuments = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = 'Поставить на контроль';
 op_MakeHyperlinkToDocument = 'MakeHyperlinkToDocument';
 op_capMakeHyperlinkToDocument = 'Создать ссылку на документ';

var opcode_List_SortDirection: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_List_SortDirection_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по возрастанию }
var st_user_List_SortDirection_Descending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по убыванию }
var opcode_List_Sort: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_AnalizeList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SortForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SortDirectionForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_List_SortDirectionForReminders_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по возрастанию }
var st_user_List_SortDirectionForReminders_Descending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по убыванию }
var opcode_List_OrAnotherListForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_AndAnotherListForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_AndNotAnotherListForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SpecifyListForReminders: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_ListInfo: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_SpecifyList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_ExportToXML: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_OrAnotherList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_AndAnotherList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_AndNotAnotherList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_Analize: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_CRList_SetType: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnListFiltered_ClearAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemListModified: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemListFiltered: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemListTimeMachineWarning: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_List_WorkWithList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentInList_OpenDocumentInNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentInList_OpenDocumentInNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SelectedDocuments_AddToControl: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_SelectedDocuments_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> Поставить на контроль <-> Снять с контроля }
var opcode_SelectedDocuments_MakeHyperlinkToDocument: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SortDirection, en_capList, op_capSortDirection, False, False, opcode_List_SortDirection)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Ascending', st_user_List_SortDirection_Ascending))^ do
  begin
   rCaption := 'Отсортировано по возрастанию';
   rHint := 'Отсортировано по возрастанию значений';
  end;
  with AddState(TvcmOperationStateForRegister_C('Descending', st_user_List_SortDirection_Descending))^ do
  begin
   rCaption := 'Отсортировано по убыванию';
   rHint := 'Отсортировано по убыванию значений';
   rImageIndex := 14;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_Sort, en_capList, op_capSort, False, False, opcode_List_Sort)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_AnalizeList, en_capList, op_capAnalizeList, False, False, opcode_List_AnalizeList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SortForReminders, en_capList, op_capSortForReminders, False, False, opcode_List_SortForReminders)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SortDirectionForReminders, en_capList, op_capSortDirectionForReminders, False, False, opcode_List_SortDirectionForReminders)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Ascending', st_user_List_SortDirectionForReminders_Ascending))^ do
  begin
   rCaption := 'Отсортировано по возрастанию';
  end;
  with AddState(TvcmOperationStateForRegister_C('Descending', st_user_List_SortDirectionForReminders_Descending))^ do
  begin
   rCaption := 'Отсортировано по убыванию';
   rImageIndex := 14;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_OrAnotherListForReminders, en_capList, op_capOrAnotherListForReminders, False, False, opcode_List_OrAnotherListForReminders)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_AndAnotherListForReminders, en_capList, op_capAndAnotherListForReminders, False, False, opcode_List_AndAnotherListForReminders)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_AndNotAnotherListForReminders, en_capList, op_capAndNotAnotherListForReminders, False, False, opcode_List_AndNotAnotherListForReminders)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SpecifyListForReminders, en_capList, op_capSpecifyListForReminders, False, False, opcode_List_SpecifyListForReminders)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_ListInfo, en_capList, op_capListInfo, False, False, opcode_List_ListInfo)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_Sort, en_capList, op_capSort, False, False, opcode_List_Sort)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SortDirection, en_capList, op_capSortDirection, False, False, opcode_List_SortDirection)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_SpecifyList, en_capList, op_capSpecifyList, False, False, opcode_List_SpecifyList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_ExportToXML, en_capList, op_capExportToXML, False, False, opcode_List_ExportToXML)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_OrAnotherList, en_capList, op_capOrAnotherList, False, False, opcode_List_OrAnotherList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_AndAnotherList, en_capList, op_capAndAnotherList, False, False, opcode_List_AndAnotherList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_AndNotAnotherList, en_capList, op_capAndNotAnotherList, False, False, opcode_List_AndNotAnotherList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_Analize, en_capList, op_capAnalize, False, False, opcode_List_Analize)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_CRList, op_SetType, en_capCRList, op_capSetType, False, True, opcode_CRList_SetType)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnListFiltered, op_ClearAll, en_capWarnListFiltered, op_capClearAll, False, False, opcode_WarnListFiltered_ClearAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemListModified, en_capReminder, op_capRemListModified, False, False, opcode_Reminder_RemListModified)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemListFiltered, en_capReminder, op_capRemListFiltered, False, False, opcode_Reminder_RemListFiltered)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemListTimeMachineWarning, en_capReminder, op_capRemListTimeMachineWarning, False, False, opcode_Reminder_RemListTimeMachineWarning)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_List, op_WorkWithList, en_capList, op_capWorkWithList, False, False, opcode_List_WorkWithList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentInList, op_OpenDocumentInNewTab, en_capDocumentInList, op_capOpenDocumentInNewTab, False, False, opcode_DocumentInList_OpenDocumentInNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentInList, op_OpenDocumentInNewWindow, en_capDocumentInList, op_capOpenDocumentInNewWindow, False, False, opcode_DocumentInList_OpenDocumentInNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SelectedDocuments, op_AddToControl, en_capSelectedDocuments, op_capAddToControl, False, False, opcode_SelectedDocuments_AddToControl)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('RemoveFromControl', st_user_SelectedDocuments_AddToControl_RemoveFromControl))^ do
  begin
   rCaption := 'Снять с контроля';
   rChecked := vcm_osfTrue;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SelectedDocuments, op_MakeHyperlinkToDocument, en_capSelectedDocuments, op_capMakeHyperlinkToDocument, False, False, opcode_SelectedDocuments_MakeHyperlinkToDocument)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
