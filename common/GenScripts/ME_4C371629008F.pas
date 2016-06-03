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

var st_user_List_SortDirection_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по возрастанию }
var st_user_List_SortDirection_Descending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по убыванию }
var st_user_List_SortDirectionForReminders_Ascending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по возрастанию }
var st_user_List_SortDirectionForReminders_Descending: TvcmOperationStateIndex = (rID : -1);
 {* Список -> Установить направление сортировки <-> Отсортировано по убыванию }
var st_user_SelectedDocuments_AddToControl_RemoveFromControl: TvcmOperationStateIndex = (rID : -1);
 {*  -> Поставить на контроль <-> Снять с контроля }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
