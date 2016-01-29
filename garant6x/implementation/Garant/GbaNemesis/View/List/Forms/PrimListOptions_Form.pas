unit PrimListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListOptions_Form.pas"
// Начат: 21.07.2010 12:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::PrimListOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  bsTypes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  ,
  Base_Operations_F1Specific_Controls,
  PrimList_Form,
  afwNavigation,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  BaseSearchInterfaces,
  Common_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  WorkWithList_ListOperations_Controls,
  Hypertext_Controls_Controls,
  l3Variant
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  ,
  PrimPrimListInterfaces,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Interfaces,
  DynamicDocListUnit,
  l3TreeInterfaces,
  FiltersUnit,
  FoldersDomainInterfaces,
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
var
  { Локализуемые строки Reminders' Hints }
 str_remListModifiedHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedHint'; rValue : 'Список был изменен');
  { 'Список был изменен' }
 str_remListFilteredHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredHint'; rValue : 'Список отфильтрован');
  { 'Список отфильтрован' }
 str_remTimeMachineWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningHint'; rValue : 'Машина времени включена');
  { 'Машина времени включена' }

var
  { Локализуемые строки List constants }
 str_DocumentList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentList'; rValue : 'Список документов');
  { 'Список документов' }
 str_DrugList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DrugList'; rValue : 'Список препаратов');
  { 'Список препаратов' }
 str_MedicinalPlantList : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MedicinalPlantList'; rValue : 'Список лекарственных растений');
  { 'Список лекарственных растений' }

type
 TPrimListOptionsForm = {form} class(TPrimListForm, InsBaseSearchListSource)
 private
 // private fields
   f_RemindersLine : TnscRemindersLine;
    {* Поле для свойства RemindersLine}
   f_remListFiltered : TnscReminder;
    {* Поле для свойства remListFiltered}
   f_remListModified : TnscReminder;
    {* Поле для свойства remListModified}
   f_remTimeMachineWarning : TnscReminder;
    {* Поле для свойства remTimeMachineWarning}
   f_EmptyListEditor : TnscEditor;
    {* Поле для свойства EmptyListEditor}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure GenerateText(const aGen: Ik2TagGenerator);
     {* генерирует текст, в случае когда списка корреспондентов/
          респоспондентов заданного типа нет. }
   procedure ChangeControlsVisible(aShowList: Boolean);
     {* редактор и список могут подменять друг друга, редактор показывается
           для пустого списка с разъяснением почему список пустой }
   function EditorJumpTo(Sender: TObject;
     anEffects: TafwJumpToEffects;
     const aMoniker: IevMoniker): Boolean;
   procedure OpenSelectedDocumentInContainer(aOpenKind: TvcmMainFormOpenKind;
     aNoActivate: Boolean = False);
   function MakeCaption: IvcmCString;
   procedure UpdateStatusBar;
     {* Сигнатура метода UpdateStatusBar }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Test(const aParams: IvcmTestParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Сохранить }
   {$IfEnd} //not NoVCM
   procedure File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
     {* Экспорт в Word }
   procedure File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Экспорт в Word }
   procedure File_SendMailAsAttachment_Test(const aParams: IvcmTestParamsPrim);
     {* Послать по e-mail }
   procedure File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Послать по e-mail }
   procedure Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
     {* Добавить закладку }
   procedure Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Добавить закладку }
   function Get_SearchList: IDynList;
   {$If not defined(NoVCM)}
   procedure Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
     {* Выделить всё }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Выделить всё }
   {$IfEnd} //not NoVCM
   procedure ShowEditorOrList(const aTree: Il3SimpleTree); override;
   function ApplyFilter(const aFilter: IFilterFromQuery;
    aAdd: Boolean = False): Boolean; override;
   function IsListEmpty: Boolean; override;
   procedure QueryMaximized; override;
   procedure QueryOpen; override;
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
     {* Перенос по словам }
   {$IfEnd} //not NoVCM
   procedure SaveToFolders(aOperation: Integer = 0); override;
   function MakeFilterInfo(aType: TnsFolderFilter): InsFolderFilterInfo; override;
   procedure ResetSaveToFolderOperations; override;
   function CheckValidSortTypes(aSortType: TbsValidSortTypes): Boolean; override;
   procedure List_OrAnotherList_Test(const aParams: IvcmTestParamsPrim);
   procedure List_OrAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_AndAnotherList_Test(const aParams: IvcmTestParamsPrim);
   procedure List_AndAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_AndNotAnotherList_Test(const aParams: IvcmTestParamsPrim);
   procedure List_AndNotAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Openable_OpenInNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Openable_OpenInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_Save_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_Save_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_Print_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_Print_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure WarnListFiltered_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отменить все фильтры }
   procedure Reminder_RemListModified_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemListModified_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemListFiltered_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemListFiltered_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemListTimeMachineWarning_Test(const aParams: IvcmTestParamsPrim);
   procedure List_WorkWithList_Test(const aParams: IvcmTestParamsPrim);
     {* Работа со списком }
   procedure DocumentInList_OpenDocumentInNewTab_Test(const aParams: IvcmTestParamsPrim);
     {* Открыть документ в новой вкладке }
   procedure DocumentInList_OpenDocumentInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Открыть документ в новой вкладке }
   procedure DocumentInList_OpenDocumentInNewWindow_Test(const aParams: IvcmTestParamsPrim);
     {* Открыть документ в новом окне }
   procedure DocumentInList_OpenDocumentInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Открыть документ в новом окне }
   procedure SelectedDocuments_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Создать ссылку на документ }
   procedure SelectedDocuments_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Создать ссылку на документ }
   procedure List_OrAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
   procedure List_OrAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_AndAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
   procedure List_AndAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_AndNotAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
   procedure List_AndNotAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SelectedDocuments_AddToControl_Test(const aParams: IvcmTestParamsPrim);
     {* Поставить на контроль }
   procedure SelectedDocuments_AddToControl_GetState(var State: TvcmOperationStateIndex);
     {* Поставить на контроль }
   procedure SelectedDocuments_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Поставить на контроль }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure EntitiesInited; override;
     {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
    {$If not defined(NoVCM)}
   procedure ReleaseResources; override;
     {* Сигнатура метода ReleaseResources }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
     {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_ListOpsList : IvcmItems;
   f_ValidSortTypes : TbsValidSortTypes;
 protected
 // protected methods
   function CurrentImageIndex: Integer;
   procedure DefineCaption;
 public
 // public properties
   property RemindersLine: TnscRemindersLine
     read f_RemindersLine;
   property remListFiltered: TnscReminder
     read f_remListFiltered;
   property remListModified: TnscReminder
     read f_remListModified;
   property remTimeMachineWarning: TnscReminder
     read f_remTimeMachineWarning;

   property EmptyListEditor: TnscEditor
     read f_EmptyListEditor;
 end;//TPrimListOptionsForm

 TvcmContainerFormRef = TPrimListOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a},
  nsToMSWordOp,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsExternalObjectPrim,
  nsTypes,
  bsUtils
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  ,
  DocumentUnit,
  nsUtils,
  DocumentInterfaces,
  PresentationInterfaces,
  BaseTypesUnit,
  nsDocumentTools,
  l3String,
  DataAdapter,
  nsConst,
  resWarnImages,
  SysUtils,
  TextPara_Const,
  Document_Const,
  k2Tags,
  l3Chars,
  nevNavigation,
  Windows,
  nsListSortTypeMap,
  nsFolderFilterInfo,
  ListUserTypes_lftConsultation_UserType,
  ListUserTypes_lftCorrespondent_UserType,
  ListUserTypes_lftCorrespondentsSynchroForm_UserType,
  ListUserTypes_lftDrugInternationalNameSynonyms_UserType,
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType,
  ListUserTypes_lftRespondent_UserType,
  ListUserTypes_lftSynchroView_UserType,
  ListUserTypes_lftUserCR1_UserType,
  ListUserTypes_lftUserCR2_UserType,
  ListUserTypes_lftCToPart_UserType,
  nsValueMaps,
  Common_FormDefinitions_Controls,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
  ListUserTypes_lftProducedDrugsSynchroForm_UserType,
  ListUserTypes_lftNone_UserType,
  ListUserTypes_lftProducedDrugs_UserType,
  ListUserTypes_lftSimilarDocuments_UserType,
  nsValueMapsIDs,
  ListUserTypes_lftDrugList_UserType
  {$If not defined(NoVCM)}
  ,
  vcmItems
  {$IfEnd} //not NoVCM
  ,
  nsQuestions,
  nsExternalObjectModelPart,
  ListUserTypes_lftRToPart_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  ListUserTypes_lftSimilarDocumentsToFragment_UserType,
  nsListExceptions,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  nsManagers,
  LoggingUnit
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef
  {$IfEnd} //Nemesis
  ,
  l3InterfacesMisc,
  nsBaseSearchService,
  evConstStringData,
  evdHyperlinkInfo,
  nsHyperlinkToDocumentProducerConst
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  Search_Strange_Controls,
  WorkWithList_StatusBar_Controls
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

const
   { LinkHandles }
  c_nsClearFiltersLink = 1;
   { ссылка в документе очистить все фильтры }
  c_nsOpenReferenceLink = 2;
   { ссылка в списке справка к списку }

// start class TPrimListOptionsForm

procedure TPrimListOptionsForm.GenerateText(const aGen: Ik2TagGenerator);
//#UC START# *4F82B4C6025F_4C46AA3401DB_var*

  procedure lpOutString(const aValue: Il3CString);

   procedure lpAddParagraph(const aValue: Il3CString);
   begin//lpAddParagraph
    aGen.StartChild(k2_typTextPara);
    try
     if (aValue <> nil) then
      aGen.AddStringAtom(k2_tiText, aValue.AsWStr);
    finally
     aGen.Finish;
    end;//StartChild(ee_idTextPara);
   end;//lpAddParagraph

  var
   lPos   : Integer;
   l_Temp : Il3CString;
   lStr   : Il3CString;
   l_TerminateInc: Integer;
  begin//lpOutString
   if l3ISNil(aValue)  then
    lpAddParagraph(nil)
   else
   begin
    l_Temp := aValue;
    while not l3IsNil(l_Temp) do
    begin
     lPos := l3Pos(l_Temp, cc_EOLStr);
     if (lPos > 0) then
      l_TerminateInc := 2
     else
     begin
      l_TerminateInc := 1;
      lPos := l3Pos(l_Temp, cc_HardEnterNativeStr);
      if (lPos = 0) then
       lPos := l3Pos(l_Temp, cc_SoftEnterNativeStr);
     end;//lPos > 0
     if (lPos > 0) then
      lStr := l3Copy(l_Temp, 0, lPos)
     else
      lStr := l_Temp;
     lpAddParagraph(lStr);
     if (lPos > 0) then
     begin
      Inc(lPos, l_TerminateInc);
      l_Temp := l3Copy(l_Temp, lPos + l_TerminateInc - 1, l3Len(l_Temp));
     end//lPos > 0
     else
      l_Temp := nil;
    end;//while not l3IsNil(l_Temp)
   end;//l3ISNil(aValue)
  end;//lpOutString

  procedure lpOutCRInfo(const aHas        : Boolean;
                        //const aCRTemplate : TvcmStringID;
                        const aCRType     : Il3CString);
(*  var
   l_Str: Tl3WString;*)
  begin//lpOutCRInfo
   if not aHas then
    lpOutString(vcmCStr(str_CommonCRNotFound))
   else
   begin
(*    l_Str := dsDocumentList.CRMissingBlocks;
    if not l3IsNil(l_Str) then
    begin
     lpOutString(vcmFmt(aCRTemplate, [aCRType]));
     lpOutString(nil);
     lpOutString(nsCStr(l_Str));
    end//not l3IsNil(l_Str)
    else*)
     lpOutString(vcmCStr(str_CommonCRNotFound));
   end;//not aHas
  end;//lpOutCRInfo

  procedure lp_AddLink(aStrId: TvcmStringId; aLinkId: Integer);
  var
   l_Text  : IvcmCString;
  begin//lp_AddLink
   lpOutString(nil);
   aGen.StartChild(k2_typTextPara);
   try
    l_Text := vcmCStr(aStrId);
    bsAddLink(aGen, aLinkId, 1, l_Text.AsWStr.SLen);
    aGen.AddStringAtom(k2_tiText, l_Text.AsWStr);
   finally
    aGen.Finish;
   end;//StartChild(ee_idTextPara);
  end;//lp_AddLink

  procedure lp_AllDocumentFiltered;
  var
   l_Index : Integer;
   l_Filter: IFilterFromQuery;
  begin
   lpOutString(vcmCStr(str_AllDocumentFiltered));
   lpOutString(nil);
   with dsList do
    for l_Index := 0 to Pred(ActiveFilters.Count) do
    begin
     ActiveFilters.pm_GetItem(l_Index, l_Filter);
     lpOutString(l3Cat(' - ', nsGetFilterCaption(l_Filter)));
    end;//for l_Index
   lp_AddLink(str_ClearFilters, c_nsClearFiltersLink);
  end;//lp_AllDocumentFiltered

  procedure lp_AllDocumentDeleted;
  begin//lp_AllDocumentDeleted
   lpOutString(vcmCStr(str_AllDocumentsInListDeleted));
   lpOutString(nil);
   lp_AddLink(str_ReferenceLinkList, c_nsOpenReferenceLink);
  end;//lp_AllDocumentDeleted

//#UC END# *4F82B4C6025F_4C46AA3401DB_var*
begin
//#UC START# *4F82B4C6025F_4C46AA3401DB_impl*
 with aGen do
 begin
  Start;
  try
   StartChild(k2_typDocument);
   try
    if dsList.AllDocumentFiltered then
     lp_AllDocumentFiltered
    else
    if (dsList.IsChanged) and (dsList.IsListEmpty) then
     lp_AllDocumentDeleted
    else
     case UserType of
      lftRespondent:
       lpOutString(vcmCStr(str_UsualRespondentsNotFound));
      lftCorrespondent:
        lpOutString(vcmCStr(str_UsualCorrespondentsFound));
      lftSynchroView, lftUserCR1, lftUserCR2:
       with dsDocumentList do
        case DocumentListType of
         crtRespondents:
          lpOutCRInfo(HasRespondents, {str_RespondetnsInOtherBlock, }CRTypeName);
         crtCorrespondents:
          lpOutCRInfo(HasCorrespondents, {str_CorrespondetnsInOtherBlock, }CRTypeName);
        end;//case DocumentListType of
      else
       lpOutString(vcmCStr(str_CommonCRNotFound));
     end;//case UserType of
   finally
    Finish;
   end;//StartChild(ee_idDocument);
  finally
   Finish;
  end;//Start;
 end;//with aGen do
//#UC END# *4F82B4C6025F_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.GenerateText

procedure TPrimListOptionsForm.ChangeControlsVisible(aShowList: Boolean);
//#UC START# *4F82B4EE0330_4C46AA3401DB_var*

(* procedure lp_Show(const aControl: TWinControl);
   {* - используем такой способ смены видимости потому, что по другому в
        варианте CQ: OIT500021506 не работает. }
 const
  c_Show: array [Boolean] of UINT = (SWP_HIDEWINDOW, SWP_SHOWWINDOW);
 begin//lp_Show
  SetWindowPos(aControl.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
   SWP_NOZORDER or c_Show[aControl.Visible]);
  // Обновим строку состояния (<K>: 105578851):
  // Нужно еще проверять, что вкладка активна, иначе может возникать неприятное:
  // http://mdp.garant.ru/pages/viewpage.action?pageId=469809301
  if aControl.Visible and (IsMainObjectForm or IsActiveInParent) then
  begin
   SetFocusedControl(aControl);
   Dispatcher.UpdateStatus;
  end;//aControl.Visible
 end;//lp_Show*)

//#UC END# *4F82B4EE0330_4C46AA3401DB_var*
begin
//#UC START# *4F82B4EE0330_4C46AA3401DB_impl*
 tvList.Visible := aShowList;
// lp_Show(tvList);
 f_EmptyListEditor.Visible := not aShowList;
// lp_Show(f_EmptyListEditor);
 UpdateStatusBar;
//#UC END# *4F82B4EE0330_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ChangeControlsVisible

function TPrimListOptionsForm.EditorJumpTo(Sender: TObject;
  anEffects: TafwJumpToEffects;
  const aMoniker: IevMoniker): Boolean;
//#UC START# *4F82B51B0333_4C46AA3401DB_var*
var
 l_HL   : IevHyperlink;
 l_Form : IvcmEntityForm;
//#UC END# *4F82B51B0333_4C46AA3401DB_var*
begin
//#UC START# *4F82B51B0333_4C46AA3401DB_impl*
 Result := False;
 if Supports(aMoniker, IevHyperlink, l_HL) then
 begin
  case l_HL.ID of
   c_nsClearFiltersLink:
   begin
    ClearFilters;
    Result := True;
   end;//c_nsClearFiltersLink
   c_nsOpenReferenceLink:
   begin
    if NativeMainForm.HasForm(fm_efListInfo.rFormID, vcm_ztChild, True, @l_Form) then
     l_Form.SetActiveInParent;
    Result := True;
   end;//c_nsOpenReferenceLink
  end;//case l_HL.ID of
 end;//if Supports(aMoniker, IevHyperlink, l_HL) then
//#UC END# *4F82B51B0333_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.EditorJumpTo

procedure TPrimListOptionsForm.OpenSelectedDocumentInContainer(aOpenKind: TvcmMainFormOpenKind;
  aNoActivate: Boolean = False);
//#UC START# *53DB3D9100F3_4C46AA3401DB_var*
var
 l_DataInfo: IdeDocInfo;
 l_Container: IvcmContainer;
//#UC END# *53DB3D9100F3_4C46AA3401DB_var*
begin
//#UC START# *53DB3D9100F3_4C46AA3401DB_impl*
 if Assigned(dsList) and dsList.OpenDocument(l_DataInfo) then
 try
  l_Container := nsNewWindow(NativeMainForm, aOpenKind, (not aNoActivate));
  if (l_Container <> nil) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=568142448 
  begin
   InitNewContainerBaseSearch(l_Container, aOpenKind);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807
   OpenDocument(l_DataInfo, l_Container, (aOpenKind = vcm_okInNewTab));
  end;
 finally
  l_DataInfo := nil;
 end;{try..finally}
//#UC END# *53DB3D9100F3_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenSelectedDocumentInContainer

function TPrimListOptionsForm.MakeCaption: IvcmCString;
//#UC START# *53F32E6A037D_4C46AA3401DB_var*

  function lp_DefineByListName(const aListName: Il3CString): Il3CString;
  begin
   if l3IsNil(aListName) and (CurUserTypeDef <> nil) then
    Result := CurUserTypeDef.Caption
   else
    Result := aListName;
  end;//lp_DefineByListName

  function lp_UseListNameForUserTypes: Boolean;
  begin
   Result := UserType in [lftSynchroView,
                                     lftSimilarDocumentsSynchroView,
                                     lftProducedDrugsSynchroForm,
                                     lftDrugInternationalNameSynonymsSynchroForm];
  end;//lp_UserListNameForUserTypes

  function lp_UseListNameForDocumentList: Boolean;
  begin
   Result := (dsDocumentList <> nil) and (dsDocumentList.
    OpenFrom in [lofRubricator, lofMultilink, lofFullScreenCR]) and
     not dsDocumentList.IsSaved;
  end;//lp_UseListNameForDocumentList

//#UC END# *53F32E6A037D_4C46AA3401DB_var*
begin
//#UC START# *53F32E6A037D_4C46AA3401DB_impl*
 if Assigned(dsList) then
 begin
  if lp_UseListNameForUserTypes or lp_UseListNameForDocumentList then
   Result := lp_DefineByListName(dsList.ListName)
  else
   case UserType of
    lftNone,
    lftDrugList:
     if dsList.IsSaved then
      Result := l3Cat([vcmCStr(str_lcSavedList), dsList.ListName])
     else
      Result := l3Cat([vcmCStr(str_lcUsualList), dsList.ListName]);
    lftRespondent:
     Result := vcmCStr(str_lcRespondents);
    lftCorrespondent:
     Result := vcmCStr(str_lcCorrespondents);
    lftCToPart:
     Result := vcmCStr(str_lcFragmentCorrespondents);
    lftRToPart:
     Result := vcmCStr(str_lcFragmentRespondents);
    lftUserCR1, lftUserCR2:
    begin
     Assert(dsDocumentList <> nil);
     Result := dsDocumentList.CRTypeName;
    end;
    lftConsultation:
     Result := vcmCStr(str_lcConsultation);
    lftSimilarDocuments:
     Result := vcmCStr(str_lcSimilarDocuments);
    lftSimilarDocumentsToFragment:
     Result := vcmCStr(CurUserType.Caption);
    lftProducedDrugs:
     Result := vcmCStr(str_lcProducedDrugs);
    lftDrugInternationalNameSynonyms:
     Result := vcmCStr(str_lcDrugInternationalName);
   else
    Result := l3Cat([vcmCStr(str_lcUsualList), dsList.ListName]);
   end;//case (UserType of
 end;//if Assigned(dsList) then
//#UC END# *53F32E6A037D_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.MakeCaption

procedure TPrimListOptionsForm.UpdateStatusBar;
//#UC START# *558010F802FC_4C46AA3401DB_var*
//#UC END# *558010F802FC_4C46AA3401DB_var*
begin
//#UC START# *558010F802FC_4C46AA3401DB_impl*
 tvList.NeedStatus := not IsListEmpty;
 Dispatcher.UpdateStatus;
//#UC END# *558010F802FC_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.UpdateStatusBar

function TPrimListOptionsForm.CurrentImageIndex: Integer;
//#UC START# *4F82B02C00CC_4C46AA3401DB_var*
//#UC END# *4F82B02C00CC_4C46AA3401DB_var*
begin
//#UC START# *4F82B02C00CC_4C46AA3401DB_impl*
 Result := UserTypes[UserType].ImageIndex;
 if (UserType in [lftSynchroView,
                  lftRToPart,
                  lftCToPart,
                  lftUserCR1,
                  lftUserCR2]) then
 begin
  if (Container <> nil) and Assigned(dsDocumentList) then
   case dsDocumentList.DocumentListType of
    crtRespondents:
     Result := UserTypes[Integer(lftRespondent)].ImageIndex;
    crtCorrespondents:
     Result := UserTypes[Integer(lftCorrespondent)].ImageIndex;
   end;//case dsDocumentList.DocumentListType of
 end;//if (UserType in [lftSynchroView,
//#UC END# *4F82B02C00CC_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.CurrentImageIndex

procedure TPrimListOptionsForm.DefineCaption;
//#UC START# *4F82BF6E011A_4C46AA3401DB_var*
//#UC END# *4F82BF6E011A_4C46AA3401DB_var*
begin
//#UC START# *4F82BF6E011A_4C46AA3401DB_impl*
 CCaption := MakeCaption;
//#UC END# *4F82BF6E011A_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DefineCaption

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_4C46AA3401DBtest_var*
//#UC END# *494F89C30197_4C46AA3401DBtest_var*
begin
//#UC START# *494F89C30197_4C46AA3401DBtest_impl*
 SelectionOpsTest(aParams);
//#UC END# *494F89C30197_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_4C46AA3401DBgetstate_var*
//#UC END# *494F89C30197_4C46AA3401DBgetstate_var*
begin
//#UC START# *494F89C30197_4C46AA3401DBgetstate_impl*
 // - ничего не делаем
//#UC END# *494F89C30197_4C46AA3401DBgetstate_impl*
end;//TPrimListOptionsForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_4C46AA3401DBexec_var*
//#UC END# *494F89C30197_4C46AA3401DBexec_var*
begin
//#UC START# *494F89C30197_4C46AA3401DBexec_impl*
 if aParams.Control = tvList then
  DeleteSelectionFromList
 else
  aParams.CallControl;
//#UC END# *494F89C30197_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4C46AA3401DBtest_var*
//#UC END# *49521D8E0295_4C46AA3401DBtest_var*
begin
//#UC START# *49521D8E0295_4C46AA3401DBtest_impl*
 ListOpsWithTrialModeTest(aParams);
//#UC END# *49521D8E0295_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49521D8E0295_4C46AA3401DBexec_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *49521D8E0295_4C46AA3401DBexec_var*
begin
//#UC START# *49521D8E0295_4C46AA3401DBexec_impl*
 l_Preview := MakePreview(False);
 if (l_Preview <> nil) then
 begin
  l_Preview.Print;
 end;//if (l_Preview <> nil) then
//#UC END# *49521D8E0295_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_Print_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4C46AA3401DBtest_var*
//#UC END# *495220DE0298_4C46AA3401DBtest_var*
begin
//#UC START# *495220DE0298_4C46AA3401DBtest_impl*
 ListOpsWithTrialModeTest(aParams);
//#UC END# *495220DE0298_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4C46AA3401DBexec_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *495220DE0298_4C46AA3401DBexec_var*
begin
//#UC START# *495220DE0298_4C46AA3401DBexec_impl*
 if (afw.Application <> nil) AND (afw.Application.PrintManager <> nil) then
 begin
  l_Preview := MakePreview(True);
  with l_Preview do
  begin
   if (ContentKind = afw_pckSelection) then
    case MessageDlg(str_ListPrintSelectedConfirmation) of
     -1:
      ;
     -2:
      ContentKind := afw_pckDocument;
     mrCancel:
      Exit;
    end;//MessageDlg(str_DocumentPrintSelectedConfirmation)
  end;//with l_Preview
  afw.Application.PrintManager.PrintDialog(l_Preview);
  // Регистрируем событие печати, без гарантий, что печать действительно была
  // выполнена. Т.к. пользователь в диалоге мог нажать кнопку отмена:
 end;//if (afw.Application <> nil)...
//#UC END# *495220DE0298_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220F2033A_4C46AA3401DBtest_var*
//#UC END# *495220F2033A_4C46AA3401DBtest_var*
begin
//#UC START# *495220F2033A_4C46AA3401DBtest_impl*
 ListopPrintTest(aParams);
//#UC END# *495220F2033A_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_PrintPreview_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4C46AA3401DBexec_var*
var
 l_Preview: IafwComplexDocumentPreview;
//#UC END# *495220F2033A_4C46AA3401DBexec_var*
begin
//#UC START# *495220F2033A_4C46AA3401DBexec_impl*
 l_Preview := MakePreview(False);
 if dsList <> nil then
  TnsListPrintPreviewEvent.Log(dsList.List, ApproxExportCount(l_Preview.ContentKind =  afw_pckSelection), l_Preview.ContentKind =  afw_pckSelection);
 TdmStdRes.MakePreview(l_Preview);
//#UC END# *495220F2033A_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495235F401C0_4C46AA3401DBtest_var*
//#UC END# *495235F401C0_4C46AA3401DBtest_var*
begin
//#UC START# *495235F401C0_4C46AA3401DBtest_impl*
 ListOpsWithTrialModeTest(aParams);
//#UC END# *495235F401C0_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_Save_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.File_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495235F401C0_4C46AA3401DBexec_var*
//#UC END# *495235F401C0_4C46AA3401DBexec_var*
begin
//#UC START# *495235F401C0_4C46AA3401DBexec_impl*
 SaveList(True);
//#UC END# *495235F401C0_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_Save_Execute
{$IfEnd} //not NoVCM

procedure TPrimListOptionsForm.File_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495238EB0160_4C46AA3401DBtest_var*
//#UC END# *495238EB0160_4C46AA3401DBtest_var*
begin
//#UC START# *495238EB0160_4C46AA3401DBtest_impl*
 ListOpsWithTrialModeTest(aParams);
 TnsToMSWordOp.Test(aParams);
//#UC END# *495238EB0160_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_ToMSWord_Test

procedure TPrimListOptionsForm.File_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495238EB0160_4C46AA3401DBexec_var*
var
 //l_PathName   : Il3CString;
 l_Output: TnsGetGenOutputStruct;
 l_Stream     : IStream;
 l_Visualizer : IafwLongProcessVisualizer;
 l_ExportSelection : Boolean;
//#UC END# *495238EB0160_4C46AA3401DBexec_var*
begin
//#UC START# *495238EB0160_4C46AA3401DBexec_impl*
 if Assigned(dsList) then
 try
  l_ExportSelection := tvList.TreeView.Tree.SelectedCount > 1;
  if (l_ExportSelection) then
   case MessageDlg(str_ListExportSelectionToWord) of
     -1:
      ;
     -2:
      l_ExportSelection := False;
     mrCancel:
      Exit;
   end;//case MessageDlg(str_ListExportSelectionToWord)

  if (ApproxExportCount(l_ExportSelection) > c_MaxTotalDocumentInListLimit) then
   if not afw.Application.IsInternal or
      not afw.Settings.LoadBoolean(pi_List_ExportWORestrictions,
                                   dv_List_ExportWORestrictions) then
   begin
    Say(war_TryToExportTooManyTotalDocs, [c_MaxTotalDocumentInListLimit]);
    Exit;
   end;//not afw.Application.IsInternal

   // Экспортировать в Word
//  l_PathName := nsMakeTemporaryFileName(nsPrepareFileName(CreateListName(l_ExportSelection)),
//   nsGetFileFormatExt(ns_ffRTF), False);
  l_Output := TnsGetGenOutputStruct_Create(
    nsMakeTemporaryFileName(nsPrepareFileName(CreateListName(l_ExportSelection)),
    nsGetFileFormatExt(ns_ffRTF), False)
     );
  l_Visualizer := bsMakeExportVisualizer(vcmCStr(str_ExportListVisualizer));
  try
   l_Stream := dsList.ListAsText(CalcSaveListKind, l_ExportSelection);
   try
    nsEvdStreamSaveAs(l_Stream, l_Output, ns_ffRTF, False);
    TnsListExportToWordEvent.Log(dsList.List, ApproxExportCount(l_ExportSelection), l_ExportSelection);
   finally
    l_Stream := nil;
   end;//try..finally
  finally
   l_Visualizer := nil;
  end;//try..finally
  if not TnsToMSWordOp.Execute(l_Output.rName, aParams) then
   Say(err_CannotOpen, [dsList.ListName]);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//if Assigned(dsDocumentList) then
//#UC END# *495238EB0160_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_ToMSWord_Execute

procedure TPrimListOptionsForm.File_SendMailAsAttachment_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495253870002_4C46AA3401DBtest_var*
//#UC END# *495253870002_4C46AA3401DBtest_var*
begin
//#UC START# *495253870002_4C46AA3401DBtest_impl*
 ListOpsWithTrialModeTest(aParams);
//#UC END# *495253870002_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.File_SendMailAsAttachment_Test

procedure TPrimListOptionsForm.File_SendMailAsAttachment_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495253870002_4C46AA3401DBexec_var*
var
 //l_PathName   : Il3CString;
 l_Output: TnsGetGenOutputStruct;
 l_Stream     : IStream;
 l_Visualizer : IafwLongProcessVisualizer;
 l_ExportSelection : Boolean;
//#UC END# *495253870002_4C46AA3401DBexec_var*
begin
//#UC START# *495253870002_4C46AA3401DBexec_impl*
 if Assigned(dsList) then
 try
  l_ExportSelection := tvList.TreeView.Tree.SelectedCount > 1;
  if (l_ExportSelection) then
   case MessageDlg(str_ListEMailSelection) of
     -1:
      ;
     -2:
      l_ExportSelection := False;
     mrCancel:
      Exit;
   end;//case MessageDlg(str_ListEMailSelection)
   // Экспортировать в Word
//  l_PathName := nsMakeTemporaryFileName(nsPrepareFileName(CreateListName(l_ExportSelection)),
//   nsGetFileFormatExt(ns_ffRTF), False);
  l_Output := TnsGetGenOutputStruct_Create(
   nsMakeTemporaryFileName(nsPrepareFileName(CreateListName(l_ExportSelection)),
   nsGetFileFormatExt(ns_ffRTF), False)
  );
  l_Visualizer := bsMakeEMailVisualizer;
  try
   l_Stream := dsList.ListAsText(CalcSaveListKind, l_ExportSelection);
   try
    nsEvdStreamSaveAs(l_Stream, l_Output, ns_ffRTF, False);
   finally
    l_Stream := nil;
   end;//try..finally
  finally
   l_Visualizer := nil;
  end;//try..finally
  try
   nsSendAttachedFile(l_Output.rName);
   TnsSendListByEmailEvent.Log(dsList.List, ApproxExportCount(l_ExportSelection),
    l_ExportSelection);
  except
   on EDefaultMailCLientAbsent do
    Say(err_DefaultMailCLientAbsent);
  end;//try..except
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//if Assigned(dsDocumentList) then
//#UC END# *495253870002_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.File_SendMailAsAttachment_Execute

procedure TPrimListOptionsForm.Document_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4989D06D014E_4C46AA3401DBtest_var*
//#UC END# *4989D06D014E_4C46AA3401DBtest_var*
begin
//#UC START# *4989D06D014E_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent;
//#UC END# *4989D06D014E_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_AddBookmark_Test

procedure TPrimListOptionsForm.Document_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4989D06D014E_4C46AA3401DBexec_var*

  function lp_FolderElementType: TFoldersElementType;
  begin//lp_FolderElementType
   case dsList.ListType of
    bs_ltDocument:
     Result := fetBookmark;
    bs_ltDrug:
     Result := fetDrugBookmark;
    else
    begin
     Assert(False);
     Result := Low(TFoldersElementType);
    end;//else
   end;//case dsList.ListType
  end;//lp_FolderElementType
  
var
 l_Bookmark: IBookmark;
//#UC END# *4989D06D014E_4C46AA3401DBexec_var*
begin
//#UC START# *4989D06D014E_4C46AA3401DBexec_impl*
 if (dsList <> nil) then
 begin
  l_Bookmark := dsList.CreateBookmark;
  if (l_Bookmark <> nil) then
   TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                      MakeFilterInfo(ffBookmark),
                      lp_FolderElementType,
                      l_Bookmark,
                      false);
 end;//dsList <> nil
//#UC END# *4989D06D014E_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_AddBookmark_Execute

function TPrimListOptionsForm.Get_SearchList: IDynList;
//#UC START# *49916C1E001D_4C46AA3401DBget_var*
//#UC END# *49916C1E001D_4C46AA3401DBget_var*
begin
//#UC START# *49916C1E001D_4C46AA3401DBget_impl*
 if (f_SearchArea in [ns_saText, ns_saTitlesOnly]) and (dsList <> nil) then
  Result := dsList.List
 else
  Result := nil;
//#UC END# *49916C1E001D_4C46AA3401DBget_impl*
end;//TPrimListOptionsForm.Get_SearchList

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EE01AA02BE_4C46AA3401DBtest_var*
//#UC END# *49EE01AA02BE_4C46AA3401DBtest_var*
begin
//#UC START# *49EE01AA02BE_4C46AA3401DBtest_impl*
 aParams.CallControl;
//#UC END# *49EE01AA02BE_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Edit_SelectAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EE01AA02BE_4C46AA3401DBexec_var*
//#UC END# *49EE01AA02BE_4C46AA3401DBexec_var*
begin
//#UC START# *49EE01AA02BE_4C46AA3401DBexec_impl*
 aParams.CallControl;
//#UC END# *49EE01AA02BE_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Edit_SelectAll_Execute
{$IfEnd} //not NoVCM

procedure TPrimListOptionsForm.ShowEditorOrList(const aTree: Il3SimpleTree);
//#UC START# *4AEAD69A0151_4C46AA3401DB_var*
//#UC END# *4AEAD69A0151_4C46AA3401DB_var*
begin
//#UC START# *4AEAD69A0151_4C46AA3401DB_impl*
 if dsList <> nil then
 begin
  if IsListEmpty then
  begin
   //CreateEditor
   GenerateText(EmptyListEditor.TextSource.GetGenerator(EmptyListEditor.View, nil));
   ChangeControlsVisible(False);
  end else
  if Assigned(aTree) then
  begin
   ChangeControlsVisible(True);
   if not Dispatcher.History.InBF then
    dsList.CurrentChanged(tvList.GetCurrentNode);
  end;//if Assigned(aTree) then
 end;//if dsList <> nil then
//#UC END# *4AEAD69A0151_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ShowEditorOrList

function TPrimListOptionsForm.ApplyFilter(const aFilter: IFilterFromQuery;
  aAdd: Boolean = False): Boolean;
//#UC START# *4AEF0A9403DD_4C46AA3401DB_var*

 procedure lp_ResetTree;
 begin//lp_ResetTree
  cfList.BeginAssignState;
  try
   tvList.TreeStruct := nil;
   tvList.TreeStruct;
  finally
   cfList.EndAssignState;
  end;//try..finally
 end;//lp_ResetTree

var
 l_Applied: Boolean;
 l_NeedResetTree: Boolean;
//#UC END# *4AEF0A9403DD_4C46AA3401DB_var*
begin
//#UC START# *4AEF0A9403DD_4C46AA3401DB_impl*
 Result := True;
 // Применяем фильтр только к основному списку, чтобы в месте с основным не
 // фильтровался список СКР в области синхронного просмотра (cq: 00018368);
 if Assigned(dsList) and dsList.IsMain then
 begin
  l_NeedResetTree := false;
  try
   l_NeedResetTree := Assigned(dsDocumentList) and dsDocumentList.IsSnippet;
   l_Applied := dsList.ApplyFilter(aFilter, aAdd);
  except
   on EListIsTooLong do
   begin
    l_Applied := False;
    if aAdd then
    begin
     vcmAsk(str_ListIsTooLong, []);
     Result := False;
     Exit;
    end;//if aAdd then
   end;
   on ENotAllAttributesRestored do
   begin
    l_Applied := False;
    if aAdd then
    begin
     Say(war_NotAllAttributesRestored);
     Result := False;
     Exit;
    end;//if aAdd then
   end;//on ENotAllAttributesRestored do
  end;//try..except
  // Обновим информацию о примененных фильтрах:
  if l_Applied then
  begin
   if dsList.AllDocumentFiltered then
   begin
    //if l_NeedResetTree then
     lp_ResetTree;
    ShowEditorOrList(nil);
   end//dsList.AllDocumentFiltered
   // Обновим дерево:
   else
    lp_ResetTree;
  end;//if l_Applied then
 end;//if Assigned(dsDocumentList) then
//#UC END# *4AEF0A9403DD_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ApplyFilter

function TPrimListOptionsForm.IsListEmpty: Boolean;
//#UC START# *4AEF2BEB032D_4C46AA3401DB_var*
//#UC END# *4AEF2BEB032D_4C46AA3401DB_var*
begin
//#UC START# *4AEF2BEB032D_4C46AA3401DB_impl*
 Result := (dsList <> nil) and dsList.IsListEmpty;
//#UC END# *4AEF2BEB032D_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.IsListEmpty

procedure TPrimListOptionsForm.QueryMaximized;
//#UC START# *4BD5912900BD_4C46AA3401DB_var*
//#UC END# *4BD5912900BD_4C46AA3401DB_var*
begin
//#UC START# *4BD5912900BD_4C46AA3401DB_impl*
 if not IsListEmpty then
  OpenInNewWindow;
//#UC END# *4BD5912900BD_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.QueryMaximized

procedure TPrimListOptionsForm.QueryOpen;
//#UC START# *4BD5913B0204_4C46AA3401DB_var*
//#UC END# *4BD5913B0204_4C46AA3401DB_var*
begin
//#UC START# *4BD5913B0204_4C46AA3401DB_impl*
 if not IsListEmpty then
  OpenCurrentList(NativeMainForm);
//#UC END# *4BD5913B0204_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.QueryOpen

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7880236_4C46AA3401DBexec_var*
//#UC END# *4BDAF7880236_4C46AA3401DBexec_var*
begin
//#UC START# *4BDAF7880236_4C46AA3401DBexec_impl*
 tvList.LockChangeSelected;
 try
  aParams.CallControl;
 finally
  tvList.UnLockChangeSelected;
 end;//try..finally
//#UC END# *4BDAF7880236_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Tree_ExpandAll_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Tree_CollapseAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BDAF7A2005C_4C46AA3401DBexec_var*
//#UC END# *4BDAF7A2005C_4C46AA3401DBexec_var*
begin
//#UC START# *4BDAF7A2005C_4C46AA3401DBexec_impl*
 tvList.LockChangeSelected;
 try
  aParams.CallControl;
 finally
  tvList.UnLockChangeSelected;
 end;//try..finally
//#UC END# *4BDAF7A2005C_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Tree_CollapseAll_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.Tree_Wrap_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7B803CF_4C46AA3401DBtest_var*
//#UC END# *4BDAF7B803CF_4C46AA3401DBtest_var*
begin
//#UC START# *4BDAF7B803CF_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4BDAF7B803CF_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Tree_Wrap_Test
{$IfEnd} //not NoVCM

procedure TPrimListOptionsForm.SaveToFolders(aOperation: Integer = 0);
//#UC START# *4C3418190372_4C46AA3401DB_var*
var
 l_CurEntity: IEntityBase;

 procedure lpOverrideList;
 var
  l_Storage: IEntityStorage;
 begin
  if l_CurEntity.GetIsSaved and Ask(qr_ListOverride) then
  try
   l_CurEntity.SaveTo(nil, l_Storage);
  except
   on EAccessDenied do
    Say(err_SaveReadOnlyList);
   on ECanNotSave do
    Say(err_CannotSaveSomething);
   on ENotSaved do
    Say(err_NotSaved);
  end;{try..except}
 end;//lpOverrideList

 procedure lpSaveToFolders;

  function lp_FolderElementType: TFoldersElementType;
  begin
   case dsList.ListType of
    bs_ltDocument:
     Result := fetList;
    bs_ltDrug:
     Result := fetDrugList;
    else
    begin
     Result := Low(TFoldersElementType);
     Assert(False);
    end;
   end;
  end;

 begin
  TdmStdRes.SaveOpen(Self.As_IvcmEntityForm,
                     MakeFilterInfo(ffListAndBookMarks),
                     lp_FolderElementType,
                     l_CurEntity,
                     True);
  DefineCaption;
 end;//lpSaveToFolders

//#UC END# *4C3418190372_4C46AA3401DB_var*
begin
//#UC START# *4C3418190372_4C46AA3401DB_impl*
 l_CurEntity := nil;
 // При перезаписи и сохранении списка в папки
 if aOperation <> g_SaveToFoldersSelected then
  Supports(dsList.List, IEntityBase, l_CurEntity)
 else
  // Сохранение выделенных в папки:
  Supports(dsList.NewListFromSelected, IEntityBase, l_CurEntity);
 if Assigned(l_CurEntity) then
 try
  // Сохранить список в мои документы целиком или только выделенные
  if (aOperation = g_SaveToFolders) or
   (aOperation = g_SaveToFoldersSelected) then
   lpSaveToFolders
  else
   // Перезаписать список
   if aOperation = g_OverrideList then
    lpOverrideList;
 finally
  l_CurEntity := nil;
 end;//try..finally
//#UC END# *4C3418190372_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SaveToFolders

function TPrimListOptionsForm.MakeFilterInfo(aType: TnsFolderFilter): InsFolderFilterInfo;
//#UC START# *4C34188000A6_4C46AA3401DB_var*
//#UC END# *4C34188000A6_4C46AA3401DB_var*
begin
//#UC START# *4C34188000A6_4C46AA3401DB_impl*
 Result := TnsFolderFilterInfo.Make(aType,
  nsListTypeToFilterFor(dsList.ListType));
//#UC END# *4C34188000A6_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.MakeFilterInfo

procedure TPrimListOptionsForm.ResetSaveToFolderOperations;
//#UC START# *4C341C77005C_4C46AA3401DB_var*
//#UC END# *4C341C77005C_4C46AA3401DB_var*
begin
//#UC START# *4C341C77005C_4C46AA3401DB_impl*
 g_SaveToFolders := -1;
 g_SaveToFoldersSelected := -1;
 g_OverrideList := -1;
//#UC END# *4C341C77005C_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ResetSaveToFolderOperations

function TPrimListOptionsForm.CheckValidSortTypes(aSortType: TbsValidSortTypes): Boolean;
//#UC START# *4C3722EE03A8_4C46AA3401DB_var*
//#UC END# *4C3722EE03A8_4C46AA3401DB_var*
begin
//#UC START# *4C3722EE03A8_4C46AA3401DB_impl*
 Result := (f_ValidSortTypes <> aSortType);
 if Result then
 begin
  f_ValidSortTypes := aSortType;
  if (f_ValidSortTypes = cDefaultListSortTypes) then
   f_SortTypeMap := nsIntegerMapManager.Map[imap_pi_List_SortType]
  else
   f_SortTypeMap := TnsListSortTypeMap.Make(f_ValidSortTypes);
 end;//Result
//#UC END# *4C3722EE03A8_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.CheckValidSortTypes

procedure TPrimListOptionsForm.List_OrAnotherList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46E1A20174_4C46AA3401DBtest_var*
//#UC END# *4C46E1A20174_4C46AA3401DBtest_var*
begin
//#UC START# *4C46E1A20174_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty) and
  (aParams.Control <> nil) {and (tvList <> aParams.Control)};
//#UC END# *4C46E1A20174_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_OrAnotherList_Test

procedure TPrimListOptionsForm.List_OrAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46E1A20174_4C46AA3401DBexec_var*
//#UC END# *4C46E1A20174_4C46AA3401DBexec_var*
begin
//#UC START# *4C46E1A20174_4C46AA3401DBexec_impl*
 TdmStdRes.SelectOpenWithOperation(Self.as_IvcmEntityForm,
                                   MakeFilterInfo(ffList),
                                   str_ListAppend,
                                   LLO_OR);
 StatusParamsShow;
//#UC END# *4C46E1A20174_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_OrAnotherList_Execute

procedure TPrimListOptionsForm.List_AndAnotherList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46E1BD0315_4C46AA3401DBtest_var*
//#UC END# *4C46E1BD0315_4C46AA3401DBtest_var*
begin
//#UC START# *4C46E1BD0315_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty) and
  (aParams.Control <> nil) {and (tvList <> aParams.Control)};
//#UC END# *4C46E1BD0315_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_AndAnotherList_Test

procedure TPrimListOptionsForm.List_AndAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46E1BD0315_4C46AA3401DBexec_var*
//#UC END# *4C46E1BD0315_4C46AA3401DBexec_var*
begin
//#UC START# *4C46E1BD0315_4C46AA3401DBexec_impl*
 TdmStdRes.SelectOpenWithOperation(Self.as_IvcmEntityForm,
                                   MakeFilterInfo(ffList),
                                   str_ListIntersect,
                                   LLO_AND);
 StatusParamsShow;
//#UC END# *4C46E1BD0315_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_AndAnotherList_Execute

procedure TPrimListOptionsForm.List_AndNotAnotherList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46E1E302A8_4C46AA3401DBtest_var*
//#UC END# *4C46E1E302A8_4C46AA3401DBtest_var*
begin
//#UC START# *4C46E1E302A8_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty) and
  (aParams.Control <> nil) {and (tvList <> aParams.Control)};
//#UC END# *4C46E1E302A8_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_AndNotAnotherList_Test

procedure TPrimListOptionsForm.List_AndNotAnotherList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46E1E302A8_4C46AA3401DBexec_var*
//#UC END# *4C46E1E302A8_4C46AA3401DBexec_var*
begin
//#UC START# *4C46E1E302A8_4C46AA3401DBexec_impl*
 TdmStdRes.SelectOpenWithOperation(Self.as_IvcmEntityForm,
                                   MakeFilterInfo(ffList),
                                   str_ListSubtract,
                                   LLO_AND_NOT);
 StatusParamsShow;
//#UC END# *4C46E1E302A8_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_AndNotAnotherList_Execute

procedure TPrimListOptionsForm.Document_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4EAC0701B4_4C46AA3401DBtest_var*
//#UC END# *4C4EAC0701B4_4C46AA3401DBtest_var*
begin
//#UC START# *4C4EAC0701B4_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent;
//#UC END# *4C4EAC0701B4_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_Open_Test

procedure TPrimListOptionsForm.Document_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4EAC0701B4_4C46AA3401DBexec_var*
var
 l_DataInfo: IdeDocInfo;
//#UC END# *4C4EAC0701B4_4C46AA3401DBexec_var*
begin
//#UC START# *4C4EAC0701B4_4C46AA3401DBexec_impl*
 if Assigned(dsList) and dsList.OpenDocument(l_DataInfo) then
 try
  OpenDocument(l_DataInfo, nil, False);
 finally
  l_DataInfo := nil;
 end;//try..finally
//#UC END# *4C4EAC0701B4_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_Open_Execute

procedure TPrimListOptionsForm.Document_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4EAC20007F_4C46AA3401DBtest_var*
//#UC END# *4C4EAC20007F_4C46AA3401DBtest_var*
begin
//#UC START# *4C4EAC20007F_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (not IsListEmpty);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=561019302 
//#UC END# *4C4EAC20007F_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_OpenNewWindow_Test

procedure TPrimListOptionsForm.Document_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4EAC20007F_4C46AA3401DBexec_var*
//#UC END# *4C4EAC20007F_4C46AA3401DBexec_var*
begin
//#UC START# *4C4EAC20007F_4C46AA3401DBexec_impl*
 OpenSelectedDocumentInContainer(vcm_okInNewWindow);
//#UC END# *4C4EAC20007F_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_OpenNewWindow_Execute

procedure TPrimListOptionsForm.Openable_OpenInNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4EB6710127_4C46AA3401DBtest_var*
//#UC END# *4C4EB6710127_4C46AA3401DBtest_var*
begin
//#UC START# *4C4EB6710127_4C46AA3401DBtest_impl*
 Document_Open_Test(aParams);
//#UC END# *4C4EB6710127_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Openable_OpenInNewWindow_Test

procedure TPrimListOptionsForm.Openable_OpenInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4EB6710127_4C46AA3401DBexec_var*
//#UC END# *4C4EB6710127_4C46AA3401DBexec_var*
begin
//#UC START# *4C4EB6710127_4C46AA3401DBexec_impl*
 Document_OpenNewWindow_Execute(aParams);
//#UC END# *4C4EB6710127_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Openable_OpenInNewWindow_Execute

procedure TPrimListOptionsForm.Document_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C5285F5004B_4C46AA3401DBtest_var*
//#UC END# *4C5285F5004B_4C46AA3401DBtest_var*
begin
//#UC START# *4C5285F5004B_4C46AA3401DBtest_impl*
 if not ForbidOpForDocumentSchema(aParams) then
  DocumentOpsWithTrialModeTest(aParams);
//#UC END# *4C5285F5004B_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_PrintDialog_Test

procedure TPrimListOptionsForm.Document_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C5285F5004B_4C46AA3401DBexec_var*
//#UC END# *4C5285F5004B_4C46AA3401DBexec_var*
begin
//#UC START# *4C5285F5004B_4C46AA3401DBexec_impl*
 if Assigned(dsList) and (afw.Application <> nil) AND
   (afw.Application.PrintManager <> nil) then
  afw.Application.PrintManager.PrintDialog(dsList.MakeDocumentPreview);
//#UC END# *4C5285F5004B_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_PrintDialog_Execute

procedure TPrimListOptionsForm.Document_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52860A017C_4C46AA3401DBtest_var*
//#UC END# *4C52860A017C_4C46AA3401DBtest_var*
begin
//#UC START# *4C52860A017C_4C46AA3401DBtest_impl*
 if not ForbidOpForDocumentSchema(aParams) then
  DocumentOpsTest(aParams);
//#UC END# *4C52860A017C_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_PrintPreview_Test

procedure TPrimListOptionsForm.Document_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52860A017C_4C46AA3401DBexec_var*
//#UC END# *4C52860A017C_4C46AA3401DBexec_var*
begin
//#UC START# *4C52860A017C_4C46AA3401DBexec_impl*
 if Assigned(dsList) then
  TdmStdRes.MakePreview(dsList.MakeDocumentPreview);
//#UC END# *4C52860A017C_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_PrintPreview_Execute

procedure TPrimListOptionsForm.Document_Save_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52861800F7_4C46AA3401DBtest_var*
//#UC END# *4C52861800F7_4C46AA3401DBtest_var*
begin
//#UC START# *4C52861800F7_4C46AA3401DBtest_impl*
 if not ForbidOpForDocumentSchema(aParams) then
  DocumentOpsWithTrialModeTest(aParams);
//#UC END# *4C52861800F7_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_Save_Test

procedure TPrimListOptionsForm.Document_Save_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52861800F7_4C46AA3401DBexec_var*
var
 l_Visualizer : IafwLongProcessVisualizer;
 l_Document   : IDocument;
//#UC END# *4C52861800F7_4C46AA3401DBexec_var*
begin
//#UC START# *4C52861800F7_4C46AA3401DBexec_impl*
 if Assigned(dsList) then
 begin
  with dmStdRes do
  begin
   SaveDialog.DialogKind := ns_sdkDocument;
   SaveDialog.SelectedOnlyEnabled := false;
   SaveDialog.SelectedOnlyChecked := false;
   l_Document := bsExtractDocument(tvList.GetCurrentNode);
   if Assigned(l_Document) then
   begin
    SaveDialog.FileName := nsEStr(CreateFileName(l_Document));
    if SaveDialog.Execute then
    begin
     afw.ProcessMessages;
     try
      l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveDocumentVisualizer));
      try
       dsList.ExportDocument(l_Document, nsCStr(SaveDialog.FileName),
        SaveDialog.SelectedFileFormat);
      finally
       l_Visualizer := nil;
      end//try..finally
     except
      on ECannotSave do
       Say(err_ListSaveToFileError);
     end{try..except}
    end;//if SaveDialog.Execute then
   end;//if Assigned(l_Document) then
  end;//with dmStdRes do
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C52861800F7_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_Save_Execute

procedure TPrimListOptionsForm.Document_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52879C00F4_4C46AA3401DBtest_var*
//#UC END# *4C52879C00F4_4C46AA3401DBtest_var*
begin
//#UC START# *4C52879C00F4_4C46AA3401DBtest_impl*
 if not ForbidOpForDocumentSchema(aParams) then
  DocumentOpsWithTrialModeTest(aParams);
//#UC END# *4C52879C00F4_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Document_Print_Test

procedure TPrimListOptionsForm.Document_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52879C00F4_4C46AA3401DBexec_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *4C52879C00F4_4C46AA3401DBexec_var*
begin
//#UC START# *4C52879C00F4_4C46AA3401DBexec_impl*
 if Assigned(dsList) then
 begin
  l_Preview := dsList.MakeDocumentPreview;
  if (l_Preview <> nil) then
   l_Preview.Print;
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C52879C00F4_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Document_Print_Execute

procedure TPrimListOptionsForm.WarnListFiltered_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C5290E2008C_4C46AA3401DBexec_var*
//#UC END# *4C5290E2008C_4C46AA3401DBexec_var*
begin
//#UC START# *4C5290E2008C_4C46AA3401DBexec_impl*
 ClearFilters;
//#UC END# *4C5290E2008C_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.WarnListFiltered_ClearAll_Execute

procedure TPrimListOptionsForm.Reminder_RemListModified_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52914202E1_4C46AA3401DBtest_var*
//#UC END# *4C52914202E1_4C46AA3401DBtest_var*
begin
//#UC START# *4C52914202E1_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := Assigned(dsList) and dsList.IsChanged;
//#UC END# *4C52914202E1_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Reminder_RemListModified_Test

procedure TPrimListOptionsForm.Reminder_RemListModified_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52914202E1_4C46AA3401DBexec_var*
//#UC END# *4C52914202E1_4C46AA3401DBexec_var*
begin
//#UC START# *4C52914202E1_4C46AA3401DBexec_impl*
 Say(inf_ListWasModified);
//#UC END# *4C52914202E1_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Reminder_RemListModified_Execute

procedure TPrimListOptionsForm.Reminder_RemListFiltered_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52915602E4_4C46AA3401DBtest_var*
//#UC END# *4C52915602E4_4C46AA3401DBtest_var*
begin
//#UC START# *4C52915602E4_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := Assigned(dsList) and dsList.IsFiltered;
//#UC END# *4C52915602E4_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Reminder_RemListFiltered_Test

procedure TPrimListOptionsForm.Reminder_RemListFiltered_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52915602E4_4C46AA3401DBexec_var*
//#UC END# *4C52915602E4_4C46AA3401DBexec_var*
begin
//#UC START# *4C52915602E4_4C46AA3401DBexec_impl*
 MessageDlg(l3Cat(remListFiltered.Hint, '.'), 'TPrimListOptionsForm.Reminder_RemListFiltered_Execute');
//#UC END# *4C52915602E4_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.Reminder_RemListFiltered_Execute

procedure TPrimListOptionsForm.Reminder_RemListTimeMachineWarning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C5292A60085_4C46AA3401DBtest_var*
//#UC END# *4C5292A60085_4C46AA3401DBtest_var*
begin
//#UC START# *4C5292A60085_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofVisible] := Assigned(dsList) and
  dsList.IsTimeMachineEnable and defDataAdapter.TimeMachine.IsOn;
 if aParams.Op.Flag[vcm_ofVisible] then
  aParams.Op.Caption := DefDataAdapter.TimeMachine.DateStr
 else
  aParams.Op.Caption := nil;
//#UC END# *4C5292A60085_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.Reminder_RemListTimeMachineWarning_Test

procedure TPrimListOptionsForm.List_WorkWithList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4F82C5D50033_4C46AA3401DBtest_var*

 function lp_MakeAvailableOps: IvcmItems;
   {-}
 begin//lp_MakeAvailableOps
  if (f_ListOpsList = nil) then
   f_ListOpsList := TvcmItems.Make;
  if (f_ListOpsList.Count = 0) then
  begin
   f_ListOpsList.AddOp(TdmStdRes.opcode_Selection_Analize);
   f_ListOpsList.AddOp(TdmStdRes.opcode_List_SwitchToFullList);
   f_ListOpsList.AddOp(TdmStdRes.opcode_Filters_FiltersListOpen, vcmCStr(str_ApplyFilters));
   f_ListOpsList.AddOp(TdmStdRes.opcode_LocalList_SearchInList);
   f_ListOpsList.AddOp(TdmStdRes.opcode_List_Sort);
  end;//f_ListOpsList.Count = 0
  Result := f_ListOpsList;
 end;//lp_MakeAvailableOps

var
 l_List : IvcmItems;
//#UC END# *4F82C5D50033_4C46AA3401DBtest_var*
begin
//#UC START# *4F82C5D50033_4C46AA3401DBtest_impl*
 l_List := lp_MakeAvailableOps;
 aParams.Op.SubItems := l_List;
 aParams.Op.Flag[vcm_ofEnabled] := (l_List <> nil) AND (l_List.Count > 0);
//#UC END# *4F82C5D50033_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_WorkWithList_Test

procedure TPrimListOptionsForm.DocumentInList_OpenDocumentInNewTab_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53DB36DC031F_4C46AA3401DBtest_var*
//#UC END# *53DB36DC031F_4C46AA3401DBtest_var*
begin
//#UC START# *53DB36DC031F_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty) and NoMoreThanOneSelected
  and HasCurrent and (aParams.Control = tvList);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=561019302
//#UC END# *53DB36DC031F_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.DocumentInList_OpenDocumentInNewTab_Test

procedure TPrimListOptionsForm.DocumentInList_OpenDocumentInNewTab_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53DB36DC031F_4C46AA3401DBexec_var*
//#UC END# *53DB36DC031F_4C46AA3401DBexec_var*
begin
//#UC START# *53DB36DC031F_4C46AA3401DBexec_impl*
 OpenSelectedDocumentInContainer(vcm_okInNewTab, True);
//#UC END# *53DB36DC031F_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.DocumentInList_OpenDocumentInNewTab_Execute

procedure TPrimListOptionsForm.DocumentInList_OpenDocumentInNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53DB36F40164_4C46AA3401DBtest_var*
//#UC END# *53DB36F40164_4C46AA3401DBtest_var*
begin
//#UC START# *53DB36F40164_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (not IsListEmpty) and (aParams.Control = tvList); 
//#UC END# *53DB36F40164_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.DocumentInList_OpenDocumentInNewWindow_Test

procedure TPrimListOptionsForm.DocumentInList_OpenDocumentInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53DB36F40164_4C46AA3401DBexec_var*
//#UC END# *53DB36F40164_4C46AA3401DBexec_var*
begin
//#UC START# *53DB36F40164_4C46AA3401DBexec_impl*
 OpenSelectedDocumentInContainer(vcm_okInNewWindow);
//#UC END# *53DB36F40164_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.DocumentInList_OpenDocumentInNewWindow_Execute

procedure TPrimListOptionsForm.SelectedDocuments_MakeHyperlinkToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53DB37280279_4C46AA3401DBtest_var*
//#UC END# *53DB37280279_4C46AA3401DBtest_var*
begin
//#UC START# *53DB37280279_4C46AA3401DBtest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (HyperlinkDocID > 0) AND
                                    NoMoreThanOneSelected AND
                                   (not l3IsNil(HyperlinkDocumentName)) AND
                                   (aParams.Control = tvList);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=530839714
//#UC END# *53DB37280279_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.SelectedDocuments_MakeHyperlinkToDocument_Test

procedure TPrimListOptionsForm.SelectedDocuments_MakeHyperlinkToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53DB37280279_4C46AA3401DBexec_var*
//#UC END# *53DB37280279_4C46AA3401DBexec_var*
begin
//#UC START# *53DB37280279_4C46AA3401DBexec_impl*
 Document_MakeHyperlinkToDocument_Execute(aParams);
//#UC END# *53DB37280279_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.SelectedDocuments_MakeHyperlinkToDocument_Execute

procedure TPrimListOptionsForm.List_OrAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B94BE0081_4C46AA3401DBtest_var*
//#UC END# *545B94BE0081_4C46AA3401DBtest_var*
begin
//#UC START# *545B94BE0081_4C46AA3401DBtest_impl*
 List_OrAnotherList_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B94BE0081_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_OrAnotherListForReminders_Test

procedure TPrimListOptionsForm.List_OrAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B94BE0081_4C46AA3401DBexec_var*
//#UC END# *545B94BE0081_4C46AA3401DBexec_var*
begin
//#UC START# *545B94BE0081_4C46AA3401DBexec_impl*
 List_OrAnotherList_Execute(aParams);
//#UC END# *545B94BE0081_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_OrAnotherListForReminders_Execute

procedure TPrimListOptionsForm.List_AndAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B94DA0240_4C46AA3401DBtest_var*
//#UC END# *545B94DA0240_4C46AA3401DBtest_var*
begin
//#UC START# *545B94DA0240_4C46AA3401DBtest_impl*
 List_AndAnotherList_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B94DA0240_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_AndAnotherListForReminders_Test

procedure TPrimListOptionsForm.List_AndAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B94DA0240_4C46AA3401DBexec_var*
//#UC END# *545B94DA0240_4C46AA3401DBexec_var*
begin
//#UC START# *545B94DA0240_4C46AA3401DBexec_impl*
 List_AndAnotherList_Execute(aParams);
//#UC END# *545B94DA0240_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_AndAnotherListForReminders_Execute

procedure TPrimListOptionsForm.List_AndNotAnotherListForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B94E90205_4C46AA3401DBtest_var*
//#UC END# *545B94E90205_4C46AA3401DBtest_var*
begin
//#UC START# *545B94E90205_4C46AA3401DBtest_impl*
 List_AndNotAnotherList_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B94E90205_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.List_AndNotAnotherListForReminders_Test

procedure TPrimListOptionsForm.List_AndNotAnotherListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B94E90205_4C46AA3401DBexec_var*
//#UC END# *545B94E90205_4C46AA3401DBexec_var*
begin
//#UC START# *545B94E90205_4C46AA3401DBexec_impl*
 List_AndNotAnotherList_Execute(aParams);
//#UC END# *545B94E90205_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.List_AndNotAnotherListForReminders_Execute

procedure TPrimListOptionsForm.SelectedDocuments_AddToControl_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *551D2A900072_4C46AA3401DBtest_var*
//#UC END# *551D2A900072_4C46AA3401DBtest_var*
begin
//#UC START# *551D2A900072_4C46AA3401DBtest_impl*
 Document_AddToControl_Test(aParams);
//#UC END# *551D2A900072_4C46AA3401DBtest_impl*
end;//TPrimListOptionsForm.SelectedDocuments_AddToControl_Test

procedure TPrimListOptionsForm.SelectedDocuments_AddToControl_GetState(var State: TvcmOperationStateIndex);
//#UC START# *551D2A900072_4C46AA3401DBgetstate_var*
//#UC END# *551D2A900072_4C46AA3401DBgetstate_var*
begin
//#UC START# *551D2A900072_4C46AA3401DBgetstate_impl*
 Document_AddToControl_GetState(State);
//#UC END# *551D2A900072_4C46AA3401DBgetstate_impl*
end;//TPrimListOptionsForm.SelectedDocuments_AddToControl_GetState

procedure TPrimListOptionsForm.SelectedDocuments_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *551D2A900072_4C46AA3401DBexec_var*
//#UC END# *551D2A900072_4C46AA3401DBexec_var*
begin
//#UC START# *551D2A900072_4C46AA3401DBexec_impl*
 Document_AddToControl_Execute(aParams);
//#UC END# *551D2A900072_4C46AA3401DBexec_impl*
end;//TPrimListOptionsForm.SelectedDocuments_AddToControl_Execute

procedure TPrimListOptionsForm.Cleanup;
//#UC START# *479731C50290_4C46AA3401DB_var*
//#UC END# *479731C50290_4C46AA3401DB_var*
begin
//#UC START# *479731C50290_4C46AA3401DB_impl*
 f_SortTypeMap := nil;
 f_ListOpsList := nil;
 inherited;
//#UC END# *479731C50290_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Cleanup

procedure TPrimListOptionsForm.InitFields;
//#UC START# *47A042E100E2_4C46AA3401DB_var*
//#UC END# *47A042E100E2_4C46AA3401DB_var*
begin
//#UC START# *47A042E100E2_4C46AA3401DB_impl*
 inherited;
 f_ValidSortTypes := cDefaultListSortTypes;
 f_SortTypeMap := nsIntegerMapManager.Map[imap_pi_List_SortType];
//#UC END# *47A042E100E2_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.InitFields

procedure TPrimListOptionsForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4C46AA3401DB_var*
//#UC END# *47EA4E9002C6_4C46AA3401DB_var*
begin
//#UC START# *47EA4E9002C6_4C46AA3401DB_impl*
 inherited;
 f_NeedDropCRList := True;
//#UC END# *47EA4E9002C6_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.FinishDataUpdate

procedure TPrimListOptionsForm.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4C46AA3401DB_var*
//#UC END# *47EA8B9601FE_4C46AA3401DB_var*
begin
//#UC START# *47EA8B9601FE_4C46AA3401DB_impl*
 inherited;
 f_NeedDropCRList := True;
//#UC END# *47EA8B9601FE_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SettingsReplaceFinish

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4C46AA3401DB_var*

 procedure lp_NodeForPositioning;
 begin
  if (dsList <> nil) then
  begin
   with dsList do
    if NodeForPositioning <> nil then
    begin
     with tvList do
     begin
      TreeStruct;
       // - получим TreeStruct, иначе позиционирование не произойдет;
      GotoOnNode(NodeForPositioning);
     end;
     ReleaseNodeForPositioning;
    end;//if NodeForPositioning <> nil then
  end;//try..finally
 end;//lp_InitDocumentList

 procedure lp_UpdateTreeStruct;
 begin//lp_UpdateTreeStruct
  tvList.TreeStruct := nil;
  ChangeControlsVisible(true);
 end;//lp_UpdateTreeStruct

//#UC END# *497469C90140_4C46AA3401DB_var*
begin
//#UC START# *497469C90140_4C46AA3401DB_impl*
 inherited;
 if (dsList <> nil) then
 begin
  // Выключим машину времени
  if dsList.TimeMachineOff then
   DefDataAdapter.TimeMachine.SwitchOff;
  with tvList do
  begin
   Images := dsList.ImageList.Hack;
   if not Dispatcher.History.InBF then
   begin
    lp_UpdateTreeStruct;
    lp_NodeForPositioning;
   end//not Dispatcher.History.InBF
   else
   if tvList.IsTreeAssign then
   begin
    // При переходе по истории изменился источник данных, нужно обновить
    // данные:
    if Assigned(dsSimpleTree) and
       (tvList.TreeStruct <> dsSimpleTree.SimpleTree) then
     lp_UpdateTreeStruct
    else
     ShowEditorOrList(tvList.TreeStruct);
     // - при загрузке из истории сначала устанавливается TreeStruct, потом
     //   _DataSource. Поэтому только теперь мы можем понять, нужно показывать
     //   редактор или нет;
    UpdateFooter;
   end;//not Dispatcher.History.InBF
  end;//with tvList do
  DefineCaption;
 end;//dsList <> nil
//#UC END# *497469C90140_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4C46AA3401DB_var*
//#UC END# *49803F5503AA_4C46AA3401DB_var*
begin
//#UC START# *49803F5503AA_4C46AA3401DB_impl*
 inherited;
 nsWarnImages;
 f_NeedDropCRList := True;
 cfList.Visible := HasContextFiltration;
 StatusParamsShow;
 cfList.Images := dmStdRes.SmallImageList;
//#UC END# *49803F5503AA_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.InitControls;
//#UC START# *4A8E8F2E0195_4C46AA3401DB_var*
//#UC END# *4A8E8F2E0195_4C46AA3401DB_var*
begin
//#UC START# *4A8E8F2E0195_4C46AA3401DB_impl*
 inherited;
 RemindersLine.Images := resWarnImages.nsWarnImages.WarnImages;
 RemindersLine.BeginUpdate;
 try
  with remListModified do
  begin
   Hint := str_remListModifiedHint.AsCStr;
   ShowHint := False; // для этих медалей хинты не нужны 532632476
   ImageIndex := 10;
   Visible := False;
   SortIndex := 0;
  end;
  with remListFiltered do
  begin
   Hint := str_remListFilteredHint.AsCStr;
   ShowHint := False;
   ImageIndex := 9;
   Visible := False;
   SortIndex := 1;
  end;
  with remTimeMachineWarning do
  begin
   Hint := str_remTimeMachineWarningHint.AsCStr;
   ShowHint := False;
   ImageIndex := 7;
   Visible := False;
   SortIndex := 2;
  end;
  RemindersLine.Sorted := True;
 finally
  RemindersLine.EndUpdate;
 end;
 with EmptyListEditor do
 begin
  Align := alClient;
  IsStaticText := True;
  OnJumpTo := EditorJumpTo;
 end;
//#UC END# *4A8E8F2E0195_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimListOptionsForm.DoGetTabInfo(out theCaption: Il3CString;
  out theItemIndex: Integer): Boolean;
//#UC START# *4AC497FD00A2_4C46AA3401DB_var*
//#UC END# *4AC497FD00A2_4C46AA3401DB_var*
begin
//#UC START# *4AC497FD00A2_4C46AA3401DB_impl*
 Result := true;
 theCaption := nil;
 theItemIndex := CurrentImageIndex;
//#UC END# *4AC497FD00A2_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DoGetTabInfo
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.EntitiesInited;
//#UC START# *4AE1948900DE_4C46AA3401DB_var*
//#UC END# *4AE1948900DE_4C46AA3401DB_var*
begin
//#UC START# *4AE1948900DE_4C46AA3401DB_impl*
 inherited;
 with remListModified do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemListModified;
  UserType := BaloonWarningUserTypes_remListModified_UserType.remListModified;
 end;
 with remListFiltered do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemListFiltered;
  UserType := BaloonWarningUserTypes_remListFiltered_UserType.remListFiltered;
 end;
 with remTimeMachineWarning do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemListTimeMachineWarning;
  UserType := BaloonWarningUserTypes_remTimeMachineWarning_UserType.remTimeMachineWarning;
 end;
 f_RemindersLine.Visible := True;
//#UC END# *4AE1948900DE_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.EntitiesInited
{$IfEnd} //not NoVCM

procedure TPrimListOptionsForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ListOpsList := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimListOptionsForm.ClearFields

{$If not defined(NoVCM)}
procedure TPrimListOptionsForm.ReleaseResources;
//#UC START# *538C374A00B7_4C46AA3401DB_var*
var
 l_RH: IvcmResourceHolder;
//#UC END# *538C374A00B7_4C46AA3401DB_var*
begin
//#UC START# *538C374A00B7_4C46AA3401DB_impl*
 inherited;
 if Supports(f_RemindersLine, IvcmResourceHolder, l_RH) then
  l_RH.ReleaseResources;
//#UC END# *538C374A00B7_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ReleaseResources
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimListOptionsForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4C46AA3401DB_var*
//#UC END# *53F1C6EF02C9_4C46AA3401DB_var*
begin
//#UC START# *53F1C6EF02C9_4C46AA3401DB_impl*
 case UserType of
  lftNone:
   Result := vcmCStr(str_DocumentList);
  lftDrugList:
   Result := vcmCStr(str_DrugList);
 else
  Result := MakeCaption;
 end;
//#UC END# *53F1C6EF02C9_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DoGetTabCaption
{$IfEnd} //not NoVCM

procedure TPrimListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Openable, nil);
  PublishFormEntity(en_WarnListFiltered, nil);
  PublishFormEntity(en_Reminder, nil);
  PublishFormEntity(en_List, nil);
  PublishFormEntity(en_DocumentInList, nil);
  PublishFormEntity(en_SelectedDocuments, nil);
  ContextMenuWeight(en_Edit, 50);
  ContextMenuWeight(en_List, 60);
  ContextMenuWeight(en_LocalList, 70);
  ContextMenuWeight(en_Selection, 80);
  ContextMenuWeight(en_Document, 90);
  ContextMenuWeight(en_Tree, 100);
  ContextMenuWeight(en_WarnListFiltered, 110);
  ContextMenuWeight(en_CRList, 95);
  ContextMenuWeight(en_DocumentInList, 0);
  ContextMenuWeight(en_SelectedDocuments, 55);
  MakeEntitySupportedByControl(en_List, remListFiltered);
  MakeEntitySupportedByControl(en_WarnListFiltered, remListFiltered);
  MakeEntitySupportedByControl(en_List, remListModified);
  MakeEntitySupportedByControl(en_List, remTimeMachineWarning);
  PublishFormEntity(en_Text, nil);
  MakeEntitySupportedByControl(en_Text, EmptyListEditor);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  ContextMenuWeight(en_Edit, op_Delete, 20);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  ShowInContextMenu(en_File, op_PrintPreview, false);
  ShowInToolbar(en_File, op_PrintPreview, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Save, File_Save_Execute, File_Save_Test, nil);
  ShowInContextMenu(en_File, op_Save, false);
  ShowInToolbar(en_File, op_Save, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_File, op_ToMSWord, File_ToMSWord_Execute, File_ToMSWord_Test, nil);
  ShowInContextMenu(en_File, op_ToMSWord, false);
  ShowInToolbar(en_File, op_ToMSWord, true);
  PublishOp(en_File, op_SendMailAsAttachment, File_SendMailAsAttachment_Execute, File_SendMailAsAttachment_Test, nil, true);
  ShowInContextMenu(en_File, op_SendMailAsAttachment, false, true);
  ShowInToolbar(en_File, op_SendMailAsAttachment, false, true);
  PublishOp(en_Document, op_AddBookmark, Document_AddBookmark_Execute, Document_AddBookmark_Test, nil);
  ShowInContextMenu(en_Document, op_AddBookmark, false);
  ContextMenuWeight(en_Document, op_AddBookmark, 70);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  ShowInToolbar(en_Edit, op_Paste, true);
  ContextMenuWeight(en_Edit, op_Paste, 15);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, Edit_SelectAll_Execute, Edit_SelectAll_Test, nil);
  ContextMenuWeight(en_Edit, op_SelectAll, 30);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, Tree_ExpandAll_Execute, nil, nil);
  ShowInContextMenu(en_Tree, op_ExpandAll, false);
  ContextMenuWeight(en_Tree, op_ExpandAll, 10);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, Tree_CollapseAll_Execute, nil, nil);
  ShowInContextMenu(en_Tree, op_CollapseAll, false);
  ContextMenuWeight(en_Tree, op_CollapseAll, 20);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_Wrap, nil, Tree_Wrap_Test, nil);
  ShowInContextMenu(en_Tree, op_Wrap, false);
  ShowInToolbar(en_Tree, op_Wrap, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_List, op_OrAnotherList, List_OrAnotherList_Execute, List_OrAnotherList_Test, nil);
  ShowInContextMenu(en_List, op_OrAnotherList, false);
  ShowInToolbar(en_List, op_OrAnotherList, true);
  ContextMenuWeight(en_List, op_OrAnotherList, 40);
  PublishOp(en_List, op_AndAnotherList, List_AndAnotherList_Execute, List_AndAnotherList_Test, nil);
  ShowInContextMenu(en_List, op_AndAnotherList, false);
  ShowInToolbar(en_List, op_AndAnotherList, true);
  ContextMenuWeight(en_List, op_AndAnotherList, 50);
  PublishOp(en_List, op_AndNotAnotherList, List_AndNotAnotherList_Execute, List_AndNotAnotherList_Test, nil);
  ShowInContextMenu(en_List, op_AndNotAnotherList, false);
  ShowInToolbar(en_List, op_AndNotAnotherList, true);
  ContextMenuWeight(en_List, op_AndNotAnotherList, 60);
  PublishOp(en_Document, op_Open, Document_Open_Execute, Document_Open_Test, nil);
  ShowInContextMenu(en_Document, op_Open, false);
  ContextMenuWeight(en_Document, op_Open, 10);
  PublishOp(en_Document, op_OpenNewWindow, Document_OpenNewWindow_Execute, Document_OpenNewWindow_Test, nil);
  ShowInContextMenu(en_Document, op_OpenNewWindow, false);
  ContextMenuWeight(en_Document, op_OpenNewWindow, 20);
  PublishOp(en_Openable, op_OpenInNewWindow, Openable_OpenInNewWindow_Execute, Openable_OpenInNewWindow_Test, nil);
  PublishOp(en_Document, op_PrintDialog, Document_PrintDialog_Execute, Document_PrintDialog_Test, nil);
  ShowInContextMenu(en_Document, op_PrintDialog, false);
  ContextMenuWeight(en_Document, op_PrintDialog, 40);
  PublishOp(en_Document, op_PrintPreview, Document_PrintPreview_Execute, Document_PrintPreview_Test, nil);
  ShowInContextMenu(en_Document, op_PrintPreview, false);
  ContextMenuWeight(en_Document, op_PrintPreview, 50);
  PublishOp(en_Document, op_Save, Document_Save_Execute, Document_Save_Test, nil);
  ShowInContextMenu(en_Document, op_Save, false);
  ContextMenuWeight(en_Document, op_Save, 60);
  PublishOp(en_Document, op_Print, Document_Print_Execute, Document_Print_Test, nil);
  ShowInContextMenu(en_Document, op_Print, false);
  PublishOp(en_WarnListFiltered, op_ClearAll, WarnListFiltered_ClearAll_Execute, nil, nil);
  ShowInContextMenu(en_WarnListFiltered, op_ClearAll, true);
  PublishOp(en_Reminder, op_RemListModified, Reminder_RemListModified_Execute, Reminder_RemListModified_Test, nil);
  ShowInContextMenu(en_Reminder, op_RemListModified, true);
  ShowInToolbar(en_Reminder, op_RemListModified, true);
  PublishOp(en_Reminder, op_RemListFiltered, Reminder_RemListFiltered_Execute, Reminder_RemListFiltered_Test, nil);
  ShowInContextMenu(en_Reminder, op_RemListFiltered, true);
  ShowInToolbar(en_Reminder, op_RemListFiltered, true);
  PublishOp(en_Reminder, op_RemListTimeMachineWarning, nil, Reminder_RemListTimeMachineWarning_Test, nil);
  PublishOp(en_List, op_WorkWithList, nil, List_WorkWithList_Test, nil);
  PublishOp(en_DocumentInList, op_OpenDocumentInNewTab, DocumentInList_OpenDocumentInNewTab_Execute, DocumentInList_OpenDocumentInNewTab_Test, nil);
  ShowInContextMenu(en_DocumentInList, op_OpenDocumentInNewTab, true);
  ContextMenuWeight(en_DocumentInList, op_OpenDocumentInNewTab, 5);
  PublishOp(en_DocumentInList, op_OpenDocumentInNewWindow, DocumentInList_OpenDocumentInNewWindow_Execute, DocumentInList_OpenDocumentInNewWindow_Test, nil);
  ShowInContextMenu(en_DocumentInList, op_OpenDocumentInNewWindow, true);
  ContextMenuWeight(en_DocumentInList, op_OpenDocumentInNewWindow, 10);
  PublishOp(en_SelectedDocuments, op_MakeHyperlinkToDocument, SelectedDocuments_MakeHyperlinkToDocument_Execute, SelectedDocuments_MakeHyperlinkToDocument_Test, nil);
  ShowInContextMenu(en_SelectedDocuments, op_MakeHyperlinkToDocument, true);
  ContextMenuWeight(en_SelectedDocuments, op_MakeHyperlinkToDocument, 10);
  PublishOp(en_List, op_OrAnotherListForReminders, List_OrAnotherListForReminders_Execute, List_OrAnotherListForReminders_Test, nil);
  ShowInContextMenu(en_List, op_OrAnotherListForReminders, true);
  ShowInToolbar(en_List, op_OrAnotherListForReminders, false);
  ContextMenuWeight(en_List, op_OrAnotherListForReminders, 40);
  PublishOp(en_List, op_AndAnotherListForReminders, List_AndAnotherListForReminders_Execute, List_AndAnotherListForReminders_Test, nil);
  ShowInContextMenu(en_List, op_AndAnotherListForReminders, true);
  ShowInToolbar(en_List, op_AndAnotherListForReminders, false);
  ContextMenuWeight(en_List, op_AndAnotherListForReminders, 50);
  PublishOp(en_List, op_AndNotAnotherListForReminders, List_AndNotAnotherListForReminders_Execute, List_AndNotAnotherListForReminders_Test, nil);
  ShowInContextMenu(en_List, op_AndNotAnotherListForReminders, true);
  ShowInToolbar(en_List, op_AndNotAnotherListForReminders, false);
  ContextMenuWeight(en_List, op_AndNotAnotherListForReminders, 60);
  PublishOp(en_SelectedDocuments, op_AddToControl, SelectedDocuments_AddToControl_Execute, SelectedDocuments_AddToControl_Test, SelectedDocuments_AddToControl_GetState);
  ShowInContextMenu(en_SelectedDocuments, op_AddToControl, true);
  ContextMenuWeight(en_SelectedDocuments, op_AddToControl, 20);{$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, true);
  ContextMenuWeight(en_Edit, op_Copy, 10);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Edit, op_FindContext, false);
  ShowInToolbar(en_Edit, op_FindContext, true);
  ContextMenuWeight(en_Edit, op_FindContext, 50);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_File, op_SaveToFolder, false);
  ShowInToolbar(en_File, op_SaveToFolder, true);
  
  ShowInContextMenu(en_File, op_LoadFromFolder, false);
  ShowInToolbar(en_File, op_LoadFromFolder, true);
  
  ShowInContextMenu(en_Document, op_AddToControl, false);
  ContextMenuWeight(en_Document, op_AddToControl, 90);
  
  ShowInContextMenu(en_Document, op_GetAttributesFrmAct, true);
  ContextMenuWeight(en_Document, op_GetAttributesFrmAct, 30);
  
  ShowInContextMenu(en_Document, op_GetRelatedDocFrmAct, false);
  ContextMenuWeight(en_Document, op_GetRelatedDocFrmAct, 35);
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Edit, op_Deselect, false);
  ContextMenuWeight(en_Edit, op_Deselect, 40);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_TimeMachine, op_TimeMachineOnOffNew, false);
  ShowInToolbar(en_TimeMachine, op_TimeMachineOnOffNew, false);
  
  ContextMenuWeight(en_List, op_SwitchToFullList, 100);
  
  ShowInContextMenu(en_List, op_ListInfo, true);
  ShowInToolbar(en_List, op_ListInfo, true);
  ContextMenuWeight(en_List, op_ListInfo, 10);
  
  ShowInContextMenu(en_List, op_Sort, false);
  ContextMenuWeight(en_List, op_Sort, 20);
  
  ShowInContextMenu(en_List, op_SortDirection, false);
  ContextMenuWeight(en_List, op_SortDirection, 30);
  
  ShowInContextMenu(en_List, op_SpecifyList, false);
  ShowInToolbar(en_List, op_SpecifyList, true);
  ContextMenuWeight(en_List, op_SpecifyList, 70);
  
  ShowInContextMenu(en_List, op_ExportToXML, true);
  ContextMenuWeight(en_List, op_ExportToXML, 90);
  
  ShowInContextMenu(en_Filters, op_FiltersList, false);
  ShowInToolbar(en_Filters, op_FiltersList, false);
  
  ShowInContextMenu(en_LocalList, op_PublishSourceSearchInList, false);
  ShowInToolbar(en_LocalList, op_PublishSourceSearchInList, true);
  ContextMenuWeight(en_LocalList, op_PublishSourceSearchInList, 30);
  
  ShowInContextMenu(en_LocalList, op_SearchDrugInList, true);
  ShowInToolbar(en_LocalList, op_SearchDrugInList, true);
  ContextMenuWeight(en_LocalList, op_SearchDrugInList, 15);
  
  ShowInContextMenu(en_Document, op_GetAnnotationDocFrmAct, false);
  ContextMenuWeight(en_Document, op_GetAnnotationDocFrmAct, 92);
  
  ShowInContextMenu(en_Document, op_SimilarDocuments, false);
  ContextMenuWeight(en_Document, op_SimilarDocuments, 95);
  
  ShowInContextMenu(en_CRList, op_SetType, false, true);
  ShowInToolbar(en_CRList, op_SetType, true, true);
  
  ShowInContextMenu(en_LocalList, op_OpenNewWindow, false);
  ContextMenuWeight(en_LocalList, op_OpenNewWindow, 10);
  
  ShowInContextMenu(en_Selection, op_CopyToNewList, false);
  ContextMenuWeight(en_Selection, op_CopyToNewList, 10);
  
  ShowInContextMenu(en_Selection, op_Analize, false);
  ShowInToolbar(en_Selection, op_Analize, false);
  
  ShowInContextMenu(en_LocalList, op_SearchInList, false);
  ShowInToolbar(en_LocalList, op_SearchInList, true);
  ContextMenuWeight(en_LocalList, op_SearchInList, 20);
  
  ShowInContextMenu(en_Filters, op_FiltersListOpen, false);
  ShowInToolbar(en_Filters, op_FiltersListOpen, false);
  
  ShowInContextMenu(en_Text, op_MakeHyperlinkToDocument, false);
  ShowInToolbar(en_Text, op_MakeHyperlinkToDocument, false);
  
  ShowInContextMenu(en_Document, op_MakeHyperlinkToDocument, false);
  ShowInToolbar(en_Document, op_MakeHyperlinkToDocument, false);
  ContextMenuWeight(en_Document, op_MakeHyperlinkToDocument, 80);
  
  ShowInContextMenu(en_List, op_Analize, false);
  ContextMenuWeight(en_List, op_Analize, 30);
  
  ShowInContextMenu(en_List, op_AnalizeList, true);
  ShowInToolbar(en_List, op_AnalizeList, false);
  ContextMenuWeight(en_List, op_AnalizeList, 100);
 end;//with Entities.Entities
end;

procedure TPrimListOptionsForm.MakeControls;
begin
 inherited;
 f_RemindersLine := TnscRemindersLine.Create(Self);
 f_RemindersLine.Name := 'RemindersLine';
 f_RemindersLine.Parent := Self;
 with DefineZone(vcm_ztChild, f_RemindersLine) do
 begin
 end;//with DefineZone(vcm_ztChild, f_RemindersLine)
 f_remListFiltered := TnscReminder.Create(RemindersLine);
 f_remListFiltered.Name := 'remListFiltered';
 f_remListModified := TnscReminder.Create(RemindersLine);
 f_remListModified.Name := 'remListModified';
 f_remTimeMachineWarning := TnscReminder.Create(RemindersLine);
 f_remTimeMachineWarning.Name := 'remTimeMachineWarning';
 ListPanel.Parent := Self;
 f_EmptyListEditor := TnscEditor.Create(Self);
 f_EmptyListEditor.Name := 'EmptyListEditor';
 f_EmptyListEditor.Parent := ListPanel;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_remListModifiedHint
 str_remListModifiedHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_remListFilteredHint
 str_remListFilteredHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_remTimeMachineWarningHint
 str_remTimeMachineWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DocumentList
 str_DocumentList.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_DrugList
 str_DrugList.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_MedicinalPlantList
 str_MedicinalPlantList.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimListOptions
 TtfwClassRef.Register(TPrimListOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.