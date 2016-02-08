unit PrimListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\PrimListOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Specific_Controls
 , BaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
 , Base_Operations_Strange_Controls
 , WorkWithList_ListOperations_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , l3Variant
 , afwInterfaces
 , afwNavigation
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicDocListUnit
 , FoldersDomainInterfaces
 , l3TreeInterfaces
 , FiltersUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3StringIDEx
;

const
 {* Локализуемые строки Reminders' Hints }
 str_remListModifiedHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListModifiedHint'; rValue : 'Список был изменен');
  {* 'Список был изменен' }
 str_remListFilteredHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredHint'; rValue : 'Список отфильтрован');
  {* 'Список отфильтрован' }
 str_remTimeMachineWarningHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remTimeMachineWarningHint'; rValue : 'Машина времени включена');
  {* 'Машина времени включена' }
 {* Локализуемые строки List constants }
 str_DocumentList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentList'; rValue : 'Список документов');
  {* 'Список документов' }
 str_DrugList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DrugList'; rValue : 'Список препаратов');
  {* 'Список препаратов' }
 str_MedicinalPlantList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MedicinalPlantList'; rValue : 'Список лекарственных растений');
  {* 'Список лекарственных растений' }

type
 // RemindersLineZone

 TPrimListOptionsForm = class(TPrimListForm, InsBaseSearchListSource)
  private
   f_RemindersLine: TnscRemindersLine;
    {* Поле для свойства RemindersLine }
   f_remListFiltered: TnscReminder;
    {* Поле для свойства remListFiltered }
   f_remListModified: TnscReminder;
    {* Поле для свойства remListModified }
   f_remTimeMachineWarning: TnscReminder;
    {* Поле для свойства remTimeMachineWarning }
   f_EmptyListEditor: TnscEditor;
    {* Поле для свойства EmptyListEditor }
  protected
   f_ListOpsList: IvcmItems;
   f_ValidSortTypes: TbsValidSortTypes;
  private
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
  protected
   function CurrentImageIndex: Integer;
   procedure DefineCaption;
   function Get_SearchList: IDynList;
   procedure ShowEditorOrList(const aTree: Il3SimpleTree); override;
   function ApplyFilter(const aFilter: IFilterFromQuery;
    aAdd: Boolean = False): Boolean; override;
   function IsListEmpty: Boolean; override;
   procedure QueryMaximized; override;
   procedure QueryOpen; override;
   procedure SaveToFolders(aOperation: Integer = 0); override;
   function MakeFilterInfo(aType: TnsFolderFilter): InsFolderFilterInfo; override;
   procedure ResetSaveToFolderOperations; override;
   function CheckValidSortTypes(aSortType: TbsValidSortTypes): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure EntitiesInited; override;
    {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ToMSWord; override;
    {* Экспорт в Word }
   procedure SendMailAsAttachment; override;
    {* Послать по e-mail }
   procedure AddBookmark; override;
    {* Добавить закладку }
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Wrap; override;
    {* Перенос по словам }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure OrAnotherList; override;
   procedure AndAnotherList; override;
   procedure AndNotAnotherList; override;
   procedure Open; override;
   procedure OpenNewWindow; override;
   procedure OpenInNewWindow; override;
   procedure PrintDialog; override;
   procedure PrintPreview; override;
   procedure Save; override;
   procedure Print; override;
   procedure ClearAll; override;
    {* Отменить все фильтры }
   procedure RemListModified; override;
   procedure RemListFiltered; override;
   procedure RemListTimeMachineWarning; override;
   procedure WorkWithList; override;
    {* Работа со списком }
   procedure OpenDocumentInNewTab; override;
    {* Открыть документ в новой вкладке }
   procedure OpenDocumentInNewWindow; override;
    {* Открыть документ в новом окне }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure OrAnotherListForReminders; override;
   procedure AndAnotherListForReminders; override;
   procedure AndNotAnotherListForReminders; override;
   procedure AddToControl; override;
    {* Поставить на контроль }
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindContext; override;
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SaveToFolder; override;
    {* Сохранить в папки }
   procedure LoadFromFolder; override;
    {* Загрузить из папок }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   procedure GetRelatedDocFrmAct; override;
    {* Справка к документу }
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure TimeMachineOnOffNew; override;
    {* Включить Машину времени }
   procedure SwitchToFullList; override;
    {* Построить полный список }
   procedure ListInfo; override;
   procedure Sort; override;
   procedure SortDirection; override;
   procedure SpecifyList; override;
   procedure ExportToXML; override;
   procedure FiltersList; override;
   procedure PublishSourceSearchInList; override;
    {* Искать по источнику опубликования в текущем списке }
   procedure SearchDrugInList; override;
   procedure GetAnnotationDocFrmAct; override;
   procedure SimilarDocuments; override;
   procedure SetType; override;
   procedure OpenNewWindow; override;
    {* Открыть текущий список в новом окне }
   procedure CopyToNewList; override;
   procedure Analize; override;
    {* Анализ списка... }
   procedure SearchInList; override;
    {* Искать по реквизитам в текущем списке }
   procedure FiltersListOpen; override;
    {* Фильтры (вкладка) }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure Analize; override;
    {* Анализ списка }
   procedure AnalizeList; override;
    {* Анализ списка... }
  public
   property RemindersLine: TnscRemindersLine
    read f_RemindersLine;
 end;//TPrimListOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsToMSWordOp
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsExternalObjectPrim
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsTypes
 , bsUtils
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , nsUtils
 , DocumentInterfaces
 , PresentationInterfaces
 , BaseTypesUnit
 , nsDocumentTools
 , l3String
 , DataAdapter
 , l3Base
 , nsConst
 , resWarnImages
 , SysUtils
 , TextPara_Const
 , Document_Const
 , k2Tags
 , l3Chars
 , nevNavigation
 , Windows
 , nsListSortTypeMap
 , nsFolderFilterInfo
 , ListUserTypes_lftConsultation_UserType
 , ListUserTypes_lftCorrespondent_UserType
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , ListUserTypes_lftRespondent_UserType
 , ListUserTypes_lftSynchroView_UserType
 , ListUserTypes_lftUserCR1_UserType
 , ListUserTypes_lftUserCR2_UserType
 , ListUserTypes_lftCToPart_UserType
 , nsValueMaps
 , Common_FormDefinitions_Controls
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 , ListUserTypes_lftNone_UserType
 , ListUserTypes_lftProducedDrugs_UserType
 , ListUserTypes_lftSimilarDocuments_UserType
 , nsValueMapsIDs
 , ListUserTypes_lftDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , nsQuestions
 , nsExternalObjectModelPart
 , ListUserTypes_lftRToPart_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , ListUserTypes_lftSimilarDocumentsToFragment_UserType
 , nsListExceptions
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , nsManagers
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , LoggingUnit
 , l3InterfacesMisc
 , nsBaseSearchService
 , evConstStringData
 , evdHyperlinkInfo
 , nsHyperlinkToDocumentProducerConst
;

const
 c_nsClearFiltersLink = 1;
  {* ссылка в документе очистить все фильтры }
 c_nsOpenReferenceLink = 2;
  {* ссылка в списке справка к списку }

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

procedure TPrimListOptionsForm.GenerateText(const aGen: Ik2TagGenerator);
 {* генерирует текст, в случае когда списка корреспондентов/
          респоспондентов заданного типа нет. }
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
 {* редактор и список могут подменять друг друга, редактор показывается
           для пустого списка с разъяснением почему список пустой }
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

procedure TPrimListOptionsForm.DefineCaption;
//#UC START# *4F82BF6E011A_4C46AA3401DB_var*
//#UC END# *4F82BF6E011A_4C46AA3401DB_var*
begin
//#UC START# *4F82BF6E011A_4C46AA3401DB_impl*
 CCaption := MakeCaption;
//#UC END# *4F82BF6E011A_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DefineCaption

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

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Delete;
 {* Удалить }
//#UC START# *494F89C30197_4C46AA3401DB_var*
//#UC END# *494F89C30197_4C46AA3401DB_var*
begin
//#UC START# *494F89C30197_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C46AA3401DB_var*
//#UC END# *49521D8E0295_4C46AA3401DB_var*
begin
//#UC START# *49521D8E0295_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C46AA3401DB_var*
//#UC END# *495220DE0298_4C46AA3401DB_var*
begin
//#UC START# *495220DE0298_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C46AA3401DB_var*
//#UC END# *495220F2033A_4C46AA3401DB_var*
begin
//#UC START# *495220F2033A_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4C46AA3401DB_var*
//#UC END# *495235F401C0_4C46AA3401DB_var*
begin
//#UC START# *495235F401C0_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Save
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListOptionsForm.ToMSWord;
 {* Экспорт в Word }
//#UC START# *495238EB0160_4C46AA3401DB_var*
//#UC END# *495238EB0160_4C46AA3401DB_var*
begin
//#UC START# *495238EB0160_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *495238EB0160_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ToMSWord

procedure TPrimListOptionsForm.SendMailAsAttachment;
 {* Послать по e-mail }
//#UC START# *495253870002_4C46AA3401DB_var*
//#UC END# *495253870002_4C46AA3401DB_var*
begin
//#UC START# *495253870002_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *495253870002_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SendMailAsAttachment

procedure TPrimListOptionsForm.AddBookmark;
 {* Добавить закладку }
//#UC START# *4989D06D014E_4C46AA3401DB_var*
//#UC END# *4989D06D014E_4C46AA3401DB_var*
begin
//#UC START# *4989D06D014E_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AddBookmark

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

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Paste;
 {* Вставка }
//#UC START# *49EDFA3701B0_4C46AA3401DB_var*
//#UC END# *49EDFA3701B0_4C46AA3401DB_var*
begin
//#UC START# *49EDFA3701B0_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.SelectAll;
 {* Выделить всё }
//#UC START# *49EE01AA02BE_4C46AA3401DB_var*
//#UC END# *49EE01AA02BE_4C46AA3401DB_var*
begin
//#UC START# *49EE01AA02BE_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C46AA3401DB_var*
//#UC END# *4BDAF7880236_4C46AA3401DB_var*
begin
//#UC START# *4BDAF7880236_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C46AA3401DB_var*
//#UC END# *4BDAF7A2005C_4C46AA3401DB_var*
begin
//#UC START# *4BDAF7A2005C_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Wrap;
 {* Перенос по словам }
//#UC START# *4BDAF7B803CF_4C46AA3401DB_var*
//#UC END# *4BDAF7B803CF_4C46AA3401DB_var*
begin
//#UC START# *4BDAF7B803CF_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Wrap
{$IfEnd} // NOT Defined(NoVCM)

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

procedure TPrimListOptionsForm.OrAnotherList;
//#UC START# *4C46E1A20174_4C46AA3401DB_var*
//#UC END# *4C46E1A20174_4C46AA3401DB_var*
begin
//#UC START# *4C46E1A20174_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46E1A20174_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OrAnotherList

procedure TPrimListOptionsForm.AndAnotherList;
//#UC START# *4C46E1BD0315_4C46AA3401DB_var*
//#UC END# *4C46E1BD0315_4C46AA3401DB_var*
begin
//#UC START# *4C46E1BD0315_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46E1BD0315_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AndAnotherList

procedure TPrimListOptionsForm.AndNotAnotherList;
//#UC START# *4C46E1E302A8_4C46AA3401DB_var*
//#UC END# *4C46E1E302A8_4C46AA3401DB_var*
begin
//#UC START# *4C46E1E302A8_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46E1E302A8_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AndNotAnotherList

procedure TPrimListOptionsForm.Open;
//#UC START# *4C4EAC0701B4_4C46AA3401DB_var*
//#UC END# *4C4EAC0701B4_4C46AA3401DB_var*
begin
//#UC START# *4C4EAC0701B4_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4EAC0701B4_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Open

procedure TPrimListOptionsForm.OpenNewWindow;
//#UC START# *4C4EAC20007F_4C46AA3401DB_var*
//#UC END# *4C4EAC20007F_4C46AA3401DB_var*
begin
//#UC START# *4C4EAC20007F_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4EAC20007F_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenNewWindow

procedure TPrimListOptionsForm.OpenInNewWindow;
//#UC START# *4C4EB6710127_4C46AA3401DB_var*
//#UC END# *4C4EB6710127_4C46AA3401DB_var*
begin
//#UC START# *4C4EB6710127_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4EB6710127_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenInNewWindow

procedure TPrimListOptionsForm.PrintDialog;
//#UC START# *4C5285F5004B_4C46AA3401DB_var*
//#UC END# *4C5285F5004B_4C46AA3401DB_var*
begin
//#UC START# *4C5285F5004B_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C5285F5004B_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.PrintDialog

procedure TPrimListOptionsForm.PrintPreview;
//#UC START# *4C52860A017C_4C46AA3401DB_var*
//#UC END# *4C52860A017C_4C46AA3401DB_var*
begin
//#UC START# *4C52860A017C_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52860A017C_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.PrintPreview

procedure TPrimListOptionsForm.Save;
//#UC START# *4C52861800F7_4C46AA3401DB_var*
//#UC END# *4C52861800F7_4C46AA3401DB_var*
begin
//#UC START# *4C52861800F7_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52861800F7_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Save

procedure TPrimListOptionsForm.Print;
//#UC START# *4C52879C00F4_4C46AA3401DB_var*
//#UC END# *4C52879C00F4_4C46AA3401DB_var*
begin
//#UC START# *4C52879C00F4_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52879C00F4_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Print

procedure TPrimListOptionsForm.ClearAll;
 {* Отменить все фильтры }
//#UC START# *4C5290E2008C_4C46AA3401DB_var*
//#UC END# *4C5290E2008C_4C46AA3401DB_var*
begin
//#UC START# *4C5290E2008C_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C5290E2008C_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ClearAll

procedure TPrimListOptionsForm.RemListModified;
//#UC START# *4C52914202E1_4C46AA3401DB_var*
//#UC END# *4C52914202E1_4C46AA3401DB_var*
begin
//#UC START# *4C52914202E1_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52914202E1_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.RemListModified

procedure TPrimListOptionsForm.RemListFiltered;
//#UC START# *4C52915602E4_4C46AA3401DB_var*
//#UC END# *4C52915602E4_4C46AA3401DB_var*
begin
//#UC START# *4C52915602E4_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52915602E4_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.RemListFiltered

procedure TPrimListOptionsForm.RemListTimeMachineWarning;
//#UC START# *4C5292A60085_4C46AA3401DB_var*
//#UC END# *4C5292A60085_4C46AA3401DB_var*
begin
//#UC START# *4C5292A60085_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C5292A60085_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.RemListTimeMachineWarning

procedure TPrimListOptionsForm.WorkWithList;
 {* Работа со списком }
//#UC START# *4F82C5D50033_4C46AA3401DB_var*
//#UC END# *4F82C5D50033_4C46AA3401DB_var*
begin
//#UC START# *4F82C5D50033_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F82C5D50033_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.WorkWithList

procedure TPrimListOptionsForm.OpenDocumentInNewTab;
 {* Открыть документ в новой вкладке }
//#UC START# *53DB36DC031F_4C46AA3401DB_var*
//#UC END# *53DB36DC031F_4C46AA3401DB_var*
begin
//#UC START# *53DB36DC031F_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DB36DC031F_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenDocumentInNewTab

procedure TPrimListOptionsForm.OpenDocumentInNewWindow;
 {* Открыть документ в новом окне }
//#UC START# *53DB36F40164_4C46AA3401DB_var*
//#UC END# *53DB36F40164_4C46AA3401DB_var*
begin
//#UC START# *53DB36F40164_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DB36F40164_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenDocumentInNewWindow

procedure TPrimListOptionsForm.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *53DB37280279_4C46AA3401DB_var*
//#UC END# *53DB37280279_4C46AA3401DB_var*
begin
//#UC START# *53DB37280279_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DB37280279_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.MakeHyperlinkToDocument

procedure TPrimListOptionsForm.OrAnotherListForReminders;
//#UC START# *545B94BE0081_4C46AA3401DB_var*
//#UC END# *545B94BE0081_4C46AA3401DB_var*
begin
//#UC START# *545B94BE0081_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *545B94BE0081_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OrAnotherListForReminders

procedure TPrimListOptionsForm.AndAnotherListForReminders;
//#UC START# *545B94DA0240_4C46AA3401DB_var*
//#UC END# *545B94DA0240_4C46AA3401DB_var*
begin
//#UC START# *545B94DA0240_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *545B94DA0240_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AndAnotherListForReminders

procedure TPrimListOptionsForm.AndNotAnotherListForReminders;
//#UC START# *545B94E90205_4C46AA3401DB_var*
//#UC END# *545B94E90205_4C46AA3401DB_var*
begin
//#UC START# *545B94E90205_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *545B94E90205_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AndNotAnotherListForReminders

procedure TPrimListOptionsForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *551D2A900072_4C46AA3401DB_var*
//#UC END# *551D2A900072_4C46AA3401DB_var*
begin
//#UC START# *551D2A900072_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551D2A900072_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AddToControl

procedure TPrimListOptionsForm.Cleanup;
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Copy;
 {* Копировать }
//#UC START# *4951284902BD_4C46AA3401DB_var*
//#UC END# *4951284902BD_4C46AA3401DB_var*
begin
//#UC START# *4951284902BD_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.FindContext;
 {* Поиск }
//#UC START# *49512B5D0009_4C46AA3401DB_var*
//#UC END# *49512B5D0009_4C46AA3401DB_var*
begin
//#UC START# *49512B5D0009_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49512B5D0009_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.FindContext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListOptionsForm.SaveToFolder;
 {* Сохранить в папки }
//#UC START# *49885D540232_4C46AA3401DB_var*
//#UC END# *49885D540232_4C46AA3401DB_var*
begin
//#UC START# *49885D540232_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D540232_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SaveToFolder

procedure TPrimListOptionsForm.LoadFromFolder;
 {* Загрузить из папок }
//#UC START# *49885D59018D_4C46AA3401DB_var*
//#UC END# *49885D59018D_4C46AA3401DB_var*
begin
//#UC START# *49885D59018D_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D59018D_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.LoadFromFolder

procedure TPrimListOptionsForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *498863B203D0_4C46AA3401DB_var*
//#UC END# *498863B203D0_4C46AA3401DB_var*
begin
//#UC START# *498863B203D0_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *498863B203D0_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AddToControl

procedure TPrimListOptionsForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *498891640253_4C46AA3401DB_var*
//#UC END# *498891640253_4C46AA3401DB_var*
begin
//#UC START# *498891640253_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *498891640253_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.GetAttributesFrmAct

procedure TPrimListOptionsForm.GetRelatedDocFrmAct;
 {* Справка к документу }
//#UC START# *498993C801DC_4C46AA3401DB_var*
//#UC END# *498993C801DC_4C46AA3401DB_var*
begin
//#UC START# *498993C801DC_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.GetRelatedDocFrmAct

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.Deselect;
 {* Снять выделение }
//#UC START# *49EE01BC022E_4C46AA3401DB_var*
//#UC END# *49EE01BC022E_4C46AA3401DB_var*
begin
//#UC START# *49EE01BC022E_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimListOptionsForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
//#UC START# *4AC497FD00A2_4C46AA3401DB_var*
//#UC END# *4AC497FD00A2_4C46AA3401DB_var*
begin
//#UC START# *4AC497FD00A2_4C46AA3401DB_impl*
 Result := true;
 theCaption := nil;
 theItemIndex := CurrentImageIndex;
//#UC END# *4AC497FD00A2_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.DoGetTabInfo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimListOptionsForm.EntitiesInited;
 {* Вызывается после того как все операции зарегистрированы }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListOptionsForm.TimeMachineOnOffNew;
 {* Включить Машину времени }
//#UC START# *4B261EC80086_4C46AA3401DB_var*
//#UC END# *4B261EC80086_4C46AA3401DB_var*
begin
//#UC START# *4B261EC80086_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B261EC80086_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.TimeMachineOnOffNew

procedure TPrimListOptionsForm.SwitchToFullList;
 {* Построить полный список }
//#UC START# *4B556F56016B_4C46AA3401DB_var*
//#UC END# *4B556F56016B_4C46AA3401DB_var*
begin
//#UC START# *4B556F56016B_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B556F56016B_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SwitchToFullList

procedure TPrimListOptionsForm.ListInfo;
//#UC START# *4C3716AC02AC_4C46AA3401DB_var*
//#UC END# *4C3716AC02AC_4C46AA3401DB_var*
begin
//#UC START# *4C3716AC02AC_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3716AC02AC_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ListInfo

procedure TPrimListOptionsForm.Sort;
//#UC START# *4C3716C50005_4C46AA3401DB_var*
//#UC END# *4C3716C50005_4C46AA3401DB_var*
begin
//#UC START# *4C3716C50005_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3716C50005_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Sort

procedure TPrimListOptionsForm.SortDirection;
//#UC START# *4C3716D1012E_4C46AA3401DB_var*
//#UC END# *4C3716D1012E_4C46AA3401DB_var*
begin
//#UC START# *4C3716D1012E_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3716D1012E_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SortDirection

procedure TPrimListOptionsForm.SpecifyList;
//#UC START# *4C3716E20109_4C46AA3401DB_var*
//#UC END# *4C3716E20109_4C46AA3401DB_var*
begin
//#UC START# *4C3716E20109_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3716E20109_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SpecifyList

procedure TPrimListOptionsForm.ExportToXML;
//#UC START# *4C3716EF02DF_4C46AA3401DB_var*
//#UC END# *4C3716EF02DF_4C46AA3401DB_var*
begin
//#UC START# *4C3716EF02DF_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3716EF02DF_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.ExportToXML

procedure TPrimListOptionsForm.FiltersList;
//#UC START# *4C3740FA02D7_4C46AA3401DB_var*
//#UC END# *4C3740FA02D7_4C46AA3401DB_var*
begin
//#UC START# *4C3740FA02D7_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3740FA02D7_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.FiltersList

procedure TPrimListOptionsForm.PublishSourceSearchInList;
 {* Искать по источнику опубликования в текущем списке }
//#UC START# *4C3A96BD0239_4C46AA3401DB_var*
//#UC END# *4C3A96BD0239_4C46AA3401DB_var*
begin
//#UC START# *4C3A96BD0239_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3A96BD0239_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.PublishSourceSearchInList

procedure TPrimListOptionsForm.SearchDrugInList;
//#UC START# *4C3A97210318_4C46AA3401DB_var*
//#UC END# *4C3A97210318_4C46AA3401DB_var*
begin
//#UC START# *4C3A97210318_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3A97210318_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SearchDrugInList

procedure TPrimListOptionsForm.GetAnnotationDocFrmAct;
//#UC START# *4C3AA77E00A3_4C46AA3401DB_var*
//#UC END# *4C3AA77E00A3_4C46AA3401DB_var*
begin
//#UC START# *4C3AA77E00A3_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA77E00A3_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.GetAnnotationDocFrmAct

procedure TPrimListOptionsForm.SimilarDocuments;
//#UC START# *4C3AA78E024D_4C46AA3401DB_var*
//#UC END# *4C3AA78E024D_4C46AA3401DB_var*
begin
//#UC START# *4C3AA78E024D_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA78E024D_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SimilarDocuments

procedure TPrimListOptionsForm.SetType;
//#UC START# *4C3AA94D0041_4C46AA3401DB_var*
//#UC END# *4C3AA94D0041_4C46AA3401DB_var*
begin
//#UC START# *4C3AA94D0041_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA94D0041_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SetType

procedure TPrimListOptionsForm.OpenNewWindow;
 {* Открыть текущий список в новом окне }
//#UC START# *4C46E7160275_4C46AA3401DB_var*
//#UC END# *4C46E7160275_4C46AA3401DB_var*
begin
//#UC START# *4C46E7160275_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46E7160275_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.OpenNewWindow

procedure TPrimListOptionsForm.CopyToNewList;
//#UC START# *4C46EB11016B_4C46AA3401DB_var*
//#UC END# *4C46EB11016B_4C46AA3401DB_var*
begin
//#UC START# *4C46EB11016B_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C46EB11016B_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.CopyToNewList

procedure TPrimListOptionsForm.Analize;
 {* Анализ списка... }
//#UC START# *4C8103FB02FD_4C46AA3401DB_var*
//#UC END# *4C8103FB02FD_4C46AA3401DB_var*
begin
//#UC START# *4C8103FB02FD_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8103FB02FD_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Analize

procedure TPrimListOptionsForm.SearchInList;
 {* Искать по реквизитам в текущем списке }
//#UC START# *4C810A2702D9_4C46AA3401DB_var*
//#UC END# *4C810A2702D9_4C46AA3401DB_var*
begin
//#UC START# *4C810A2702D9_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C810A2702D9_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.SearchInList

procedure TPrimListOptionsForm.FiltersListOpen;
 {* Фильтры (вкладка) }
//#UC START# *4C81191003E5_4C46AA3401DB_var*
//#UC END# *4C81191003E5_4C46AA3401DB_var*
begin
//#UC START# *4C81191003E5_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C81191003E5_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.FiltersListOpen

procedure TPrimListOptionsForm.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDD5C3901E0_4C46AA3401DB_var*
//#UC END# *4CDD5C3901E0_4C46AA3401DB_var*
begin
//#UC START# *4CDD5C3901E0_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD5C3901E0_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.MakeHyperlinkToDocument

procedure TPrimListOptionsForm.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDE7C2C0258_4C46AA3401DB_var*
//#UC END# *4CDE7C2C0258_4C46AA3401DB_var*
begin
//#UC START# *4CDE7C2C0258_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDE7C2C0258_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.MakeHyperlinkToDocument

procedure TPrimListOptionsForm.ClearFields;
begin
 f_ListOpsList := nil;
 inherited;
end;//TPrimListOptionsForm.ClearFields

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListOptionsForm.Analize;
 {* Анализ списка }
//#UC START# *53DB376C0239_4C46AA3401DB_var*
//#UC END# *53DB376C0239_4C46AA3401DB_var*
begin
//#UC START# *53DB376C0239_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *53DB376C0239_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.Analize

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimListOptionsForm.AnalizeList;
 {* Анализ списка... }
//#UC START# *53FF40030272_4C46AA3401DB_var*
//#UC END# *53FF40030272_4C46AA3401DB_var*
begin
//#UC START# *53FF40030272_4C46AA3401DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *53FF40030272_4C46AA3401DB_impl*
end;//TPrimListOptionsForm.AnalizeList

initialization
 str_remListModifiedHint.Init;
 {* Инициализация str_remListModifiedHint }
 str_remListFilteredHint.Init;
 {* Инициализация str_remListFilteredHint }
 str_remTimeMachineWarningHint.Init;
 {* Инициализация str_remTimeMachineWarningHint }
 str_DocumentList.Init;
 {* Инициализация str_DocumentList }
 str_DrugList.Init;
 {* Инициализация str_DrugList }
 str_MedicinalPlantList.Init;
 {* Инициализация str_MedicinalPlantList }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimListOptionsForm);
 {* Регистрация PrimListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
