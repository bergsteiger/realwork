unit Document_Strange_Controls;
 {* Странные операции, не подавшиеся пока логическому анализу }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (498874B90391)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , nevBase
 , l3TreeInterfaces
 , bsTypes
 , eeInterfaces
 , DocumentAndListInterfaces
 , DocumentDomainInterfaces
 , Base_Operations_Editions_Controls
 , BaseSearchInterfaces
 , F1TagDataProviderInterface
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IEditions_SetCurrent_Params = interface
  {* Параметры для операции Editions.SetCurrent }
  function Get_Document: IDocument;
  property Document: IDocument
   read Get_Document;
 end;//IEditions_SetCurrent_Params

 Op_Editions_SetCurrent = {final} class
  {* Класс для вызова операции Editions.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aDocument: IDocument): Boolean; overload;
    {* Вызов операции Editions.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aDocument: IDocument): Boolean; overload;
    {* Вызов операции Editions.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aDocument: IDocument): Boolean; overload;
    {* Вызов операции Editions.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aDocument: IDocument): Boolean; overload;
    {* Вызов операции Editions.SetCurrent у контейнера }
 end;//Op_Editions_SetCurrent

 ISystem_TimeMachineStateChange_Params = interface
  {* Параметры для операции System.TimeMachineStateChange }
  function Get_StayInCurrentRedaction: Boolean;
  property StayInCurrentRedaction: Boolean
   read Get_StayInCurrentRedaction;
 end;//ISystem_TimeMachineStateChange_Params

 Op_System_TimeMachineStateChange = {final} class
  {* Класс для вызова операции System.TimeMachineStateChange }
  public
   class function Call(const aTarget: IvcmEntity;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* Вызов операции System.TimeMachineStateChange у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* Вызов операции System.TimeMachineStateChange у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* Вызов операции System.TimeMachineStateChange у формы }
   class function Call(const aTarget: IvcmContainer;
    aStayInCurrentRedaction: Boolean = False): Boolean; overload;
    {* Вызов операции System.TimeMachineStateChange у контейнера }
   class procedure Broadcast(aStayInCurrentRedaction: Boolean = False);
    {* Вызов операции System.TimeMachineStateChange у всех зарегистрированных сущностей }
 end;//Op_System_TimeMachineStateChange

 IContents_SetCurrent_Params = interface
  {* Параметры для операции Contents.SetCurrent }
  function Get_Sub: Integer;
  property Sub: Integer
   read Get_Sub;
 end;//IContents_SetCurrent_Params

 Op_Contents_SetCurrent = {final} class
  {* Класс для вызова операции Contents.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    aSub: Integer): Boolean; overload;
    {* Вызов операции Contents.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aSub: Integer): Boolean; overload;
    {* Вызов операции Contents.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aSub: Integer): Boolean; overload;
    {* Вызов операции Contents.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    aSub: Integer): Boolean; overload;
    {* Вызов операции Contents.SetCurrent у контейнера }
 end;//Op_Contents_SetCurrent

 IContents_MoveCurrent_Params = interface
  {* Параметры для операции Contents.MoveCurrent }
  function Get_Sub: Integer;
  function Get_Down: Boolean;
  property Sub: Integer
   read Get_Sub;
  property Down: Boolean
   read Get_Down;
 end;//IContents_MoveCurrent_Params

 Op_Contents_MoveCurrent = {final} class
  {* Класс для вызова операции Contents.MoveCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    aSub: Integer;
    aDown: Boolean): Boolean; overload;
    {* Вызов операции Contents.MoveCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aSub: Integer;
    aDown: Boolean): Boolean; overload;
    {* Вызов операции Contents.MoveCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aSub: Integer;
    aDown: Boolean): Boolean; overload;
    {* Вызов операции Contents.MoveCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    aSub: Integer;
    aDown: Boolean): Boolean; overload;
    {* Вызов операции Contents.MoveCurrent у контейнера }
 end;//Op_Contents_MoveCurrent

 IContents_HasUserComments_Params = interface
  {* Параметры для операции Contents.HasUserComments }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_HasUserComments_Params

 Op_Contents_HasUserComments = {final} class
  {* Класс для вызова операции Contents.HasUserComments }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Contents.HasUserComments у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Contents.HasUserComments у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Contents.HasUserComments у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Contents.HasUserComments у контейнера }
 end;//Op_Contents_HasUserComments

 IContents_HasBookmarks_Params = interface
  {* Параметры для операции Contents.HasBookmarks }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_HasBookmarks_Params

 Op_Contents_HasBookmarks = {final} class
  {* Класс для вызова операции Contents.HasBookmarks }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Contents.HasBookmarks у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Contents.HasBookmarks у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Contents.HasBookmarks у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Contents.HasBookmarks у контейнера }
 end;//Op_Contents_HasBookmarks

 IContents_ToggleContentsVisibility_Params = interface
  {* Параметры для операции Contents.ToggleContentsVisibility }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_ToggleContentsVisibility_Params

 Op_Contents_ToggleContentsVisibility = {final} class
  {* Класс для вызова операции Contents.ToggleContentsVisibility }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Contents.ToggleContentsVisibility у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Contents.ToggleContentsVisibility у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Contents.ToggleContentsVisibility у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Contents.ToggleContentsVisibility у контейнера }
 end;//Op_Contents_ToggleContentsVisibility

 IContents_IsContentsVisible_Params = interface
  {* Параметры для операции Contents.IsContentsVisible }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContents_IsContentsVisible_Params

 Op_Contents_IsContentsVisible = {final} class
  {* Класс для вызова операции Contents.IsContentsVisible }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Contents.IsContentsVisible у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Contents.IsContentsVisible у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Contents.IsContentsVisible у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Contents.IsContentsVisible у контейнера }
 end;//Op_Contents_IsContentsVisible

 IWarning_BecomeActive_Params = interface
  {* Параметры для операции Warning.BecomeActive }
  function Get_SubID: TnsWarningSub;
  property SubID: TnsWarningSub
   read Get_SubID;
 end;//IWarning_BecomeActive_Params

 Op_Warning_BecomeActive = {final} class
  {* Класс для вызова операции Warning.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.BecomeActive у контейнера }
 end;//Op_Warning_BecomeActive

 IWarning_SwitchActive_Params = interface
  {* Параметры для операции Warning.SwitchActive }
  function Get_SubID: TnsWarningSub;
  property SubID: TnsWarningSub
   read Get_SubID;
 end;//IWarning_SwitchActive_Params

 Op_Warning_SwitchActive = {final} class
  {* Класс для вызова операции Warning.SwitchActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.SwitchActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.SwitchActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.SwitchActive у формы }
   class function Call(const aTarget: IvcmContainer;
    aSubID: TnsWarningSub): Boolean; overload;
    {* Вызов операции Warning.SwitchActive у контейнера }
 end;//Op_Warning_SwitchActive

 IPicture_InitNewContent_Params = interface
  {* Параметры для операции Picture.InitNewContent }
  function Get_Data: InsLinkedObjectData;
  property Data: InsLinkedObjectData
   read Get_Data;
 end;//IPicture_InitNewContent_Params

 Op_Picture_InitNewContent = {final} class
  {* Класс для вызова операции Picture.InitNewContent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: InsLinkedObjectData): Boolean; overload;
    {* Вызов операции Picture.InitNewContent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: InsLinkedObjectData): Boolean; overload;
    {* Вызов операции Picture.InitNewContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: InsLinkedObjectData): Boolean; overload;
    {* Вызов операции Picture.InitNewContent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: InsLinkedObjectData): Boolean; overload;
    {* Вызов операции Picture.InitNewContent у контейнера }
 end;//Op_Picture_InitNewContent

 IContentsValidator_IsDocumentAdornmentsChanged_Params = interface
  {* Параметры для операции ContentsValidator.IsDocumentAdornmentsChanged }
  function Get_New: InsDocumentAdornments;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property New: InsDocumentAdornments
   read Get_New;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IContentsValidator_IsDocumentAdornmentsChanged_Params

 Op_ContentsValidator_IsDocumentAdornmentsChanged = {final} class
  {* Класс для вызова операции ContentsValidator.IsDocumentAdornmentsChanged }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNew: InsDocumentAdornments): Boolean; overload;
    {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNew: InsDocumentAdornments): Boolean; overload;
    {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNew: InsDocumentAdornments): Boolean; overload;
    {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNew: InsDocumentAdornments): Boolean; overload;
    {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у контейнера }
 end;//Op_ContentsValidator_IsDocumentAdornmentsChanged

 Op_DocumentSubPanel_UpdateSubPanel = {final} class
  {* Класс для вызова операции DocumentSubPanel.UpdateSubPanel }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции DocumentSubPanel.UpdateSubPanel у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции DocumentSubPanel.UpdateSubPanel у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции DocumentSubPanel.UpdateSubPanel у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции DocumentSubPanel.UpdateSubPanel у контейнера }
 end;//Op_DocumentSubPanel_UpdateSubPanel

 IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = interface
  {* Параметры для операции BaseSearchPresentationHolder.GetBaseSearchPresentation }
  function Get_ResultValue: InsBaseSearchPresentation;
  procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
  property ResultValue: InsBaseSearchPresentation
   read Get_ResultValue
   write Set_ResultValue;
 end;//IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

 Op_BaseSearchPresentationHolder_GetBaseSearchPresentation = {final} class
  {* Класс для вызова операции BaseSearchPresentationHolder.GetBaseSearchPresentation }
  public
   class function Call(const aTarget: IvcmEntity): InsBaseSearchPresentation; overload;
    {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у сущности }
   class function Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation; overload;
    {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у агрегации }
   class function Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation; overload;
    {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у формы }
   class function Call(const aTarget: IvcmContainer): InsBaseSearchPresentation; overload;
    {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у контейнера }
 end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation

const
 en_Editions = 'Editions';
 en_capEditions = 'Редакции';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = 'Установить текущую';
 en_System = 'System';
 en_capSystem = '';
 op_TimeMachineStateChange = 'TimeMachineStateChange';
 op_capTimeMachineStateChange = '';
 en_Selection = 'Selection';
 en_capSelection = 'Выделенные элементы';
 op_InsertHyperlink = 'InsertHyperlink';
 op_capInsertHyperlink = 'Поставить ссылку...';
 op_FindInDict = 'FindInDict';
 op_capFindInDict = 'Найти в Толковом словаре';
 en_Contents = 'Contents';
 en_capContents = 'Структура документа';
 op_MoveCurrent = 'MoveCurrent';
 op_capMoveCurrent = '';
 op_HasUserComments = 'HasUserComments';
 op_capHasUserComments = 'Есть ли в оглавление пользовательские комментарии';
 op_HasBookmarks = 'HasBookmarks';
 op_capHasBookmarks = 'Есть ли в оглавлении закладки';
 op_ToggleContentsVisibility = 'ToggleContentsVisibility';
 op_capToggleContentsVisibility = 'Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось';
 op_IsContentsVisible = 'IsContentsVisible';
 op_capIsContentsVisible = 'Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления';
 en_Warning = 'Warning';
 en_capWarning = '';
 op_BecomeActive = 'BecomeActive';
 op_capBecomeActive = '';
 op_SwitchActive = 'SwitchActive';
 op_capSwitchActive = '';
 en_Picture = 'Picture';
 en_capPicture = 'Картинка';
 op_InitNewContent = 'InitNewContent';
 op_capInitNewContent = '';
 en_DocumentBlock = 'DocumentBlock';
 en_capDocumentBlock = 'Пункт оглавления';
 op_GetTypedCorrespondentList = 'GetTypedCorrespondentList';
 op_capGetTypedCorrespondentList = 'Ссылки на фрагмент (вид информации)';
 op_PrintPreview = 'PrintPreview';
 op_capPrintPreview = '';
 op_Select = 'Select';
 op_capSelect = '';
 op_GetSimilarDocsToBlock = 'GetSimilarDocsToBlock';
 op_capGetSimilarDocsToBlock = '';
 op_GetCorrespondentList = 'GetCorrespondentList';
 op_capGetCorrespondentList = '';
 op_GetRespondentList = 'GetRespondentList';
 op_capGetRespondentList = '';
 op_GetTypedRespondentList = 'GetTypedRespondentList';
 op_capGetTypedRespondentList = '';
 op_ToMSWord = 'ToMSWord';
 op_capToMSWord = '';
 op_PrintDialog = 'PrintDialog';
 op_capPrintDialog = '';
 op_Copy = 'Copy';
 op_capCopy = '';
 op_Print = 'Print';
 op_capPrint = '';
 en_DocumentBlockHeader = 'DocumentBlockHeader';
 en_capDocumentBlockHeader = 'Пункт оглавления - Заголовок документ';
 op_UserCR1 = 'UserCR1';
 op_capUserCR1 = 'Пользовательские ссылки на документ (ссылки из документа) 1';
 op_UserCR2 = 'UserCR2';
 op_capUserCR2 = 'Пользовательские ссылки на документ (ссылки из документа) 2';
 op_AddBookmark = 'AddBookmark';
 op_capAddBookmark = '';
 en_WarnOnControl = 'WarnOnControl';
 en_capWarnOnControl = 'Предупреждение (на контроле)';
 op_ClearStatusSettings = 'ClearStatusSettings';
 op_capClearStatusSettings = 'Способ сброса статуса "изменен"';
 op_ShowChanges = 'ShowChanges';
 op_capShowChanges = 'Показать изменения';
 op_ClearStatus = 'ClearStatus';
 op_capClearStatus = 'Сбросить статус "изменен"';
 en_TasksPanel = 'TasksPanel';
 en_capTasksPanel = '';
 op_TimeMachineOnOff = 'TimeMachineOnOff';
 op_capTimeMachineOnOff = 'Включить Машину времени с календарной даты\Выключить Машину времени';
 en_Document = 'Document';
 en_capDocument = '';
 op_OpenContentsFrmAct = 'OpenContentsFrmAct';
 op_capOpenContentsFrmAct = 'Структура документа';
 op_ShowDocumentPicture = 'ShowDocumentPicture';
 op_capShowDocumentPicture = '';
 op_DocumentSynchroOpenWindow = 'DocumentSynchroOpenWindow';
 op_capDocumentSynchroOpenWindow = '';
 op_DocumentSynchroOpenNewWindow = 'DocumentSynchroOpenNewWindow';
 op_capDocumentSynchroOpenNewWindow = '';
 op_DictListOpenFrmAct = 'DictListOpenFrmAct';
 op_capDictListOpenFrmAct = '';
 op_GotoBookmark = 'GotoBookmark';
 op_capGotoBookmark = '';
 op_LiteratureListForDictionary = 'LiteratureListForDictionary';
 op_capLiteratureListForDictionary = '';
 op_OpenProducedDrugList = 'OpenProducedDrugList';
 op_capOpenProducedDrugList = '';
 op_OpenSimilarDrugList = 'OpenSimilarDrugList';
 op_capOpenSimilarDrugList = '';
 en_ExternalObject = 'ExternalObject';
 en_capExternalObject = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_Save = 'Save';
 op_capSave = '';
 en_WarnRedaction = 'WarnRedaction';
 en_capWarnRedaction = 'Предупреждение о неактуальной редакции';
 op_ShowInfo = 'ShowInfo';
 op_capShowInfo = 'Показать текст предупреждения';
 op_OpenActualRedaction = 'OpenActualRedaction';
 op_capOpenActualRedaction = '';
 en_WarnTimeMachine = 'WarnTimeMachine';
 en_capWarnTimeMachine = 'Предупреждение для Машины времени';
 op_TimeMachineOnOffNew = 'TimeMachineOnOffNew';
 op_capTimeMachineOnOffNew = 'Включить/Выключить Машину времени';
 en_WarnJuror = 'WarnJuror';
 en_capWarnJuror = 'Предупреждение (юридическое)';
 en_BookmarkIcon = 'BookmarkIcon';
 en_capBookmarkIcon = '';
 op_Delete = 'Delete';
 op_capDelete = '';
 op_Edit = 'Edit';
 op_capEdit = '';
 en_UserCommentIcon = 'UserCommentIcon';
 en_capUserCommentIcon = '';
 op_HideShow = 'HideShow';
 op_capHideShow = 'Скрыть/Показать';
 en_UserComment = 'UserComment';
 en_capUserComment = '';
 en_Text = 'Text';
 en_capText = '';
 op_AddUserComment = 'AddUserComment';
 op_capAddUserComment = '';
 op_DeleteBookmark = 'DeleteBookmark';
 op_capDeleteBookmark = '';
 op_EditBookmark = 'EditBookmark';
 op_capEditBookmark = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = '';
 op_TimeMachineOffAndReset = 'TimeMachineOffAndReset';
 op_capTimeMachineOffAndReset = '';
 op_ActualRedaction = 'ActualRedaction';
 op_capActualRedaction = '';
 op_TimeMachineOff = 'TimeMachineOff';
 op_capTimeMachineOff = '';
 en_Reminder = 'Reminder';
 en_capReminder = '';
 op_RemWarnJuror = 'RemWarnJuror';
 op_capRemWarnJuror = '';
 op_RemWarnTimeMachineOn = 'RemWarnTimeMachineOn';
 op_capRemWarnTimeMachineOn = '';
 op_RemWarnRedaction = 'RemWarnRedaction';
 op_capRemWarnRedaction = '';
 op_RemWarnOnControl = 'RemWarnOnControl';
 op_capRemWarnOnControl = '';
 op_RemWarnIsAbolished = 'RemWarnIsAbolished';
 op_capRemWarnIsAbolished = '';
 op_RemWarnTimeMachineException = 'RemWarnTimeMachineException';
 op_capRemWarnTimeMachineException = '';
 op_RemWarnPreActive = 'RemWarnPreActive';
 op_capRemWarnPreActive = '';
 op_RemWarnTimeMachineWarning = 'RemWarnTimeMachineWarning';
 op_capRemWarnTimeMachineWarning = '';
 op_ViewInactualDocument = 'ViewInactualDocument';
 op_capViewInactualDocument = '';
 en_SynchroView = 'SynchroView';
 en_capSynchroView = '';
 op_ShowText = 'ShowText';
 op_capShowText = '';
 op_Annotation = 'Annotation';
 op_capAnnotation = '';
 op_ShowAttributes = 'ShowAttributes';
 op_capShowAttributes = '';
 op_ShowRelated = 'ShowRelated';
 op_capShowRelated = '';
 op_ShowUserCRList1 = 'ShowUserCRList1';
 op_capShowUserCRList1 = '';
 op_ShowUserCRList2 = 'ShowUserCRList2';
 op_capShowUserCRList2 = '';
 op_SimilarDocuments = 'SimilarDocuments';
 op_capSimilarDocuments = '';
 en_Edition = 'Edition';
 en_capEdition = '';
 op_OpenNewTab = 'OpenNewTab';
 op_capOpenNewTab = '';
 en_Attribute = 'Attribute';
 en_capAttribute = '';
 op_Resize = 'Resize';
 op_capResize = '';
 op_Enlarge = 'Enlarge';
 op_capEnlarge = '';
 op_Shrink = 'Shrink';
 op_capShrink = '';
 op_ActualSize = 'ActualSize';
 op_capActualSize = '';
 op_FitInWIndow = 'FitInWIndow';
 op_capFitInWIndow = '';
 en_ContentsValidator = 'ContentsValidator';
 en_capContentsValidator = 'http://mdp.garant.ru/pages/viewpage.action?pageId=259891063';
 op_IsDocumentAdornmentsChanged = 'IsDocumentAdornmentsChanged';
 op_capIsDocumentAdornmentsChanged = '';
 en_DocumentSubPanel = 'DocumentSubPanel';
 en_capDocumentSubPanel = '';
 op_UpdateSubPanel = 'UpdateSubPanel';
 op_capUpdateSubPanel = '';
 op_DoCompareEditions = 'DoCompareEditions';
 op_capDoCompareEditions = 'Сравнить редакции';
 op_BuildChangedFragments = 'BuildChangedFragments';
 op_capBuildChangedFragments = 'Построить обзор изменений';
 en_DocumentBlockBookmarks = 'DocumentBlockBookmarks';
 en_capDocumentBlockBookmarks = 'Закладки на пункт оглавления';
 en_IntranetSourcePoint = 'IntranetSourcePoint';
 en_capIntranetSourcePoint = '';
 op_GoToIntranet = 'GoToIntranet';
 op_capGoToIntranet = '';
 op_ChangesButton = 'ChangesButton';
 op_capChangesButton = 'Изменения в документе';
 en_SubsPanel = 'SubsPanel';
 en_capSubsPanel = 'Панель меток';
 op_CopySubNumber = 'CopySubNumber';
 op_capCopySubNumber = 'Копировать позицию';
 en_BaseSearchPresentationHolder = 'BaseSearchPresentationHolder';
 en_capBaseSearchPresentationHolder = '';
 op_GetBaseSearchPresentation = 'GetBaseSearchPresentation';
 op_capGetBaseSearchPresentation = '';
 op_SelectWord = 'SelectWord';
 op_capSelectWord = '';
 op_SelectPara = 'SelectPara';
 op_capSelectPara = '';

var opcode_Editions_SetCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_System_TimeMachineStateChange: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Selection_InsertHyperlink: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Selection_InsertHyperlink_ModifyLink: TvcmOperationStateIndex = (rID : -1);
 {* Выделенные элементы -> Поставить ссылку... <-> Изменить ссылку... }
var opcode_Selection_FindInDict: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_SetCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_MoveCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_HasUserComments: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_HasBookmarks: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_ToggleContentsVisibility: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Contents_IsContentsVisible: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Warning_BecomeActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Warning_SwitchActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_InitNewContent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_GetTypedCorrespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_DocumentBlock_GetTypedCorrespondentList_InText: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления -> Ссылки на фрагмент (вид информации) <-> Ссылки на фрагмент: }
var opcode_DocumentBlock_PrintPreview: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_Select: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_GetSimilarDocsToBlock: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_GetCorrespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_GetRespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_GetTypedRespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_ToMSWord: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_PrintDialog: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_Copy: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlock_Print: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockHeader_UserCR1: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_DocumentBlockHeader_UserCR1_Corr: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 1 <->  }
var opcode_DocumentBlockHeader_UserCR2: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_DocumentBlockHeader_UserCR2_Corr: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 2 <->  }
var opcode_DocumentBlockHeader_GetTypedCorrespondentList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockHeader_AddBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockHeader_ToMSWord: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockHeader_Print: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockHeader_PrintDialog: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_ClearStatusSettings: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_ShowChanges: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnOnControl_ClearStatus: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_TasksPanel_TimeMachineOnOff: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_TasksPanel_TimeMachineOnOff_On: TvcmOperationStateIndex = (rID : -1);
 {*  -> Включить Машину времени с календарной даты\Выключить Машину времени <-> Включить Машину времени }
var st_user_TasksPanel_TimeMachineOnOff_Off: TvcmOperationStateIndex = (rID : -1);
 {*  -> Включить Машину времени с календарной даты\Выключить Машину времени <-> Выключить Машину времени }
var opcode_Document_OpenContentsFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_Document_OpenContentsFrmAct_Drug: TvcmOperationStateIndex = (rID : -1);
 {*  -> Структура документа <-> Структура препарата }
var opcode_Document_ShowDocumentPicture: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_DocumentSynchroOpenWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_DocumentSynchroOpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_DictListOpenFrmAct: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_GotoBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_LiteratureListForDictionary: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenProducedDrugList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_OpenSimilarDrugList: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ExternalObject_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ExternalObject_Save: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnRedaction_ShowInfo: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_WarnRedaction_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение о неактуальной редакции -> Показать текст предупреждения <-> Скрыть текст предупреждения }
var opcode_WarnRedaction_OpenActualRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_WarnTimeMachine_ShowInfo: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_WarnTimeMachine_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Показать текст предупреждения <-> Скрыть текст предупреждения }
var opcode_WarnTimeMachine_TimeMachineOnOffNew: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOn: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Включить/Выключить Машину времени <-> Включить Машину времени }
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOff: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Включить/Выключить Машину времени <-> Выключить Машину времени/Изменить дату }
var opcode_WarnJuror_ShowInfo: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_WarnJuror_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение (юридическое) -> Показать текст предупреждения <-> Скрыть текст предупреждения }
var opcode_BookmarkIcon_Delete: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_BookmarkIcon_Edit: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_UserCommentIcon_HideShow: TvcmOPID = (rEnID : -1; rOpID : -1);
var st_user_UserCommentIcon_HideShow_GarantHidden: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Показать комментарии ГАРАНТа }
var st_user_UserCommentIcon_HideShow_GarantShown: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Скрыть комментарии ГАРАНТа }
var st_user_UserCommentIcon_HideShow_UserShown: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Скрыть мои комментарии }
var st_user_UserCommentIcon_HideShow_UserHidden: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Показать мои комментарии }
var st_user_UserCommentIcon_HideShow_Invisible: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <->  }
var st_user_UserCommentIcon_HideShow_VersionShown: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Выключить информацию об изменениях документа }
var st_user_UserCommentIcon_HideShow_VersionHidden: TvcmOperationStateIndex = (rID : -1);
 {*  -> Скрыть/Показать <-> Включить информацию об изменениях документа }
var opcode_UserCommentIcon_Delete: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_UserComment_Delete: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_AddUserComment: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_DeleteBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_EditBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_AddBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Warning_TimeMachineOffAndReset: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Warning_ActualRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Warning_TimeMachineOff: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnJuror: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnTimeMachineOn: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnRedaction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnOnControl: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnIsAbolished: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnTimeMachineException: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnPreActive: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_RemWarnTimeMachineWarning: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Reminder_ViewInactualDocument: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_ShowText: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_Annotation: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_ShowAttributes: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_ShowRelated: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_ShowUserCRList1: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_ShowUserCRList2: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SynchroView_SimilarDocuments: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edition_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Edition_OpenNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_Copy: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_Resize: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_Enlarge: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_Shrink: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_ActualSize: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_FitInWIndow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ContentsValidator_IsDocumentAdornmentsChanged: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentSubPanel_UpdateSubPanel: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Editions_DoCompareEditions: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Editions_BuildChangedFragments: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_DocumentBlockBookmarks_AddBookmark: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_IntranetSourcePoint_GoToIntranet: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_Open: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_OpenNewWindow: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Picture_OpenNewTab: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Document_ChangesButton: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SubsPanel_CopySubNumber: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_SelectWord: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Text_SelectPara: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TEditions_SetCurrent_Params = {final} class(Tl3CProtoObject, IEditions_SetCurrent_Params)
  {* Реализация IEditions_SetCurrent_Params }
  private
   f_Document: IDocument;
  protected
   function Get_Document: IDocument;
   procedure ClearFields; override;
  public
   constructor Create(const aDocument: IDocument); reintroduce;
   class function Make(const aDocument: IDocument): IEditions_SetCurrent_Params; reintroduce;
 end;//TEditions_SetCurrent_Params

 TSystem_TimeMachineStateChange_Params = {final} class(Tl3CProtoObject, ISystem_TimeMachineStateChange_Params)
  {* Реализация ISystem_TimeMachineStateChange_Params }
  private
   f_StayInCurrentRedaction: Boolean;
  protected
   function Get_StayInCurrentRedaction: Boolean;
  public
   constructor Create(aStayInCurrentRedaction: Boolean = False); reintroduce;
   class function Make(aStayInCurrentRedaction: Boolean = False): ISystem_TimeMachineStateChange_Params; reintroduce;
 end;//TSystem_TimeMachineStateChange_Params

 TContents_SetCurrent_Params = {final} class(Tl3CProtoObject, IContents_SetCurrent_Params)
  {* Реализация IContents_SetCurrent_Params }
  private
   f_Sub: Integer;
  protected
   function Get_Sub: Integer;
  public
   constructor Create(aSub: Integer); reintroduce;
   class function Make(aSub: Integer): IContents_SetCurrent_Params; reintroduce;
 end;//TContents_SetCurrent_Params

 TContents_MoveCurrent_Params = {final} class(Tl3CProtoObject, IContents_MoveCurrent_Params)
  {* Реализация IContents_MoveCurrent_Params }
  private
   f_Sub: Integer;
   f_Down: Boolean;
  protected
   function Get_Sub: Integer;
   function Get_Down: Boolean;
  public
   constructor Create(aSub: Integer;
    aDown: Boolean); reintroduce;
   class function Make(aSub: Integer;
    aDown: Boolean): IContents_MoveCurrent_Params; reintroduce;
 end;//TContents_MoveCurrent_Params

 TContents_HasUserComments_Params = {final} class(Tl3CProtoObject, IContents_HasUserComments_Params)
  {* Реализация IContents_HasUserComments_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IContents_HasUserComments_Params; reintroduce;
 end;//TContents_HasUserComments_Params

 TContents_HasBookmarks_Params = {final} class(Tl3CProtoObject, IContents_HasBookmarks_Params)
  {* Реализация IContents_HasBookmarks_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IContents_HasBookmarks_Params; reintroduce;
 end;//TContents_HasBookmarks_Params

 TContents_ToggleContentsVisibility_Params = {final} class(Tl3CProtoObject, IContents_ToggleContentsVisibility_Params)
  {* Реализация IContents_ToggleContentsVisibility_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IContents_ToggleContentsVisibility_Params; reintroduce;
 end;//TContents_ToggleContentsVisibility_Params

 TContents_IsContentsVisible_Params = {final} class(Tl3CProtoObject, IContents_IsContentsVisible_Params)
  {* Реализация IContents_IsContentsVisible_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IContents_IsContentsVisible_Params; reintroduce;
 end;//TContents_IsContentsVisible_Params

 TWarning_BecomeActive_Params = {final} class(Tl3CProtoObject, IWarning_BecomeActive_Params)
  {* Реализация IWarning_BecomeActive_Params }
  private
   f_SubID: TnsWarningSub;
  protected
   function Get_SubID: TnsWarningSub;
  public
   constructor Create(aSubID: TnsWarningSub); reintroduce;
   class function Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params; reintroduce;
 end;//TWarning_BecomeActive_Params

 TWarning_SwitchActive_Params = {final} class(Tl3CProtoObject, IWarning_SwitchActive_Params)
  {* Реализация IWarning_SwitchActive_Params }
  private
   f_SubID: TnsWarningSub;
  protected
   function Get_SubID: TnsWarningSub;
  public
   constructor Create(aSubID: TnsWarningSub); reintroduce;
   class function Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params; reintroduce;
 end;//TWarning_SwitchActive_Params

 TPicture_InitNewContent_Params = {final} class(Tl3CProtoObject, IPicture_InitNewContent_Params)
  {* Реализация IPicture_InitNewContent_Params }
  private
   f_Data: InsLinkedObjectData;
  protected
   function Get_Data: InsLinkedObjectData;
   procedure ClearFields; override;
  public
   constructor Create(const aData: InsLinkedObjectData); reintroduce;
   class function Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params; reintroduce;
 end;//TPicture_InitNewContent_Params

 TContentsValidator_IsDocumentAdornmentsChanged_Params = {final} class(Tl3CProtoObject, IContentsValidator_IsDocumentAdornmentsChanged_Params)
  {* Реализация IContentsValidator_IsDocumentAdornmentsChanged_Params }
  private
   f_New: InsDocumentAdornments;
   f_ResultValue: Boolean;
  protected
   function Get_New: InsDocumentAdornments;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create(const aNew: InsDocumentAdornments); reintroduce;
   class function Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params; reintroduce;
 end;//TContentsValidator_IsDocumentAdornmentsChanged_Params

 TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params = {final} class(Tl3CProtoObject, IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params)
  {* Реализация IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params }
  private
   f_ResultValue: InsBaseSearchPresentation;
  protected
   function Get_ResultValue: InsBaseSearchPresentation;
   procedure Set_ResultValue(const aValue: InsBaseSearchPresentation);
   procedure ClearFields; override;
  public
   class function Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params; reintroduce;
 end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params

constructor TEditions_SetCurrent_Params.Create(const aDocument: IDocument);
begin
 inherited Create;
 f_Document := aDocument;
end;//TEditions_SetCurrent_Params.Create

class function TEditions_SetCurrent_Params.Make(const aDocument: IDocument): IEditions_SetCurrent_Params;
var
 l_Inst : TEditions_SetCurrent_Params;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TEditions_SetCurrent_Params.Make

function TEditions_SetCurrent_Params.Get_Document: IDocument;
begin
 Result := f_Document;
end;//TEditions_SetCurrent_Params.Get_Document

procedure TEditions_SetCurrent_Params.ClearFields;
begin
 f_Document := nil;
 inherited;
end;//TEditions_SetCurrent_Params.ClearFields

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntity;
 const aDocument: IDocument): Boolean;
 {* Вызов операции Editions.SetCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TEditions_SetCurrent_Params.Make(aDocument));
  aTarget.Operation(opcode_Editions_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aDocument: IDocument): Boolean;
 {* Вызов операции Editions.SetCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TEditions_SetCurrent_Params.Make(aDocument));
  aTarget.Operation(opcode_Editions_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aDocument: IDocument): Boolean;
 {* Вызов операции Editions.SetCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDocument);
end;//Op_Editions_SetCurrent.Call

class function Op_Editions_SetCurrent.Call(const aTarget: IvcmContainer;
 const aDocument: IDocument): Boolean;
 {* Вызов операции Editions.SetCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDocument);
end;//Op_Editions_SetCurrent.Call

constructor TSystem_TimeMachineStateChange_Params.Create(aStayInCurrentRedaction: Boolean = False);
begin
 inherited Create;
 f_StayInCurrentRedaction := aStayInCurrentRedaction;
end;//TSystem_TimeMachineStateChange_Params.Create

class function TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction: Boolean = False): ISystem_TimeMachineStateChange_Params;
var
 l_Inst : TSystem_TimeMachineStateChange_Params;
begin
 l_Inst := Create(aStayInCurrentRedaction);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSystem_TimeMachineStateChange_Params.Make

function TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction: Boolean;
begin
 Result := f_StayInCurrentRedaction;
end;//TSystem_TimeMachineStateChange_Params.Get_StayInCurrentRedaction

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntity;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* Вызов операции System.TimeMachineStateChange у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  aTarget.Operation(opcode_System_TimeMachineStateChange, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmAggregate;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* Вызов операции System.TimeMachineStateChange у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  aTarget.Operation(opcode_System_TimeMachineStateChange, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmEntityForm;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* Вызов операции System.TimeMachineStateChange у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aStayInCurrentRedaction);
end;//Op_System_TimeMachineStateChange.Call

class function Op_System_TimeMachineStateChange.Call(const aTarget: IvcmContainer;
 aStayInCurrentRedaction: Boolean = False): Boolean;
 {* Вызов операции System.TimeMachineStateChange у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aStayInCurrentRedaction);
end;//Op_System_TimeMachineStateChange.Call

class procedure Op_System_TimeMachineStateChange.Broadcast(aStayInCurrentRedaction: Boolean = False);
 {* Вызов операции System.TimeMachineStateChange у всех зарегистрированных сущностей }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSystem_TimeMachineStateChange_Params.Make(aStayInCurrentRedaction));
  vcmDispatcher.EntityOperationBroadcast(opcode_System_TimeMachineStateChange, l_Params);
 end//vcmDispatcher <> nil
end;//Op_System_TimeMachineStateChange.Broadcast

constructor TContents_SetCurrent_Params.Create(aSub: Integer);
begin
 inherited Create;
 f_Sub := aSub;
end;//TContents_SetCurrent_Params.Create

class function TContents_SetCurrent_Params.Make(aSub: Integer): IContents_SetCurrent_Params;
var
 l_Inst : TContents_SetCurrent_Params;
begin
 l_Inst := Create(aSub);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_SetCurrent_Params.Make

function TContents_SetCurrent_Params.Get_Sub: Integer;
begin
 Result := f_Sub;
end;//TContents_SetCurrent_Params.Get_Sub

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntity;
 aSub: Integer): Boolean;
 {* Вызов операции Contents.SetCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_SetCurrent_Params.Make(aSub));
  aTarget.Operation(opcode_Contents_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmAggregate;
 aSub: Integer): Boolean;
 {* Вызов операции Contents.SetCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_SetCurrent_Params.Make(aSub));
  aTarget.Operation(opcode_Contents_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmEntityForm;
 aSub: Integer): Boolean;
 {* Вызов операции Contents.SetCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSub);
end;//Op_Contents_SetCurrent.Call

class function Op_Contents_SetCurrent.Call(const aTarget: IvcmContainer;
 aSub: Integer): Boolean;
 {* Вызов операции Contents.SetCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSub);
end;//Op_Contents_SetCurrent.Call

constructor TContents_MoveCurrent_Params.Create(aSub: Integer;
 aDown: Boolean);
begin
 inherited Create;
 f_Sub := aSub;
 f_Down := aDown;
end;//TContents_MoveCurrent_Params.Create

class function TContents_MoveCurrent_Params.Make(aSub: Integer;
 aDown: Boolean): IContents_MoveCurrent_Params;
var
 l_Inst : TContents_MoveCurrent_Params;
begin
 l_Inst := Create(aSub, aDown);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_MoveCurrent_Params.Make

function TContents_MoveCurrent_Params.Get_Sub: Integer;
begin
 Result := f_Sub;
end;//TContents_MoveCurrent_Params.Get_Sub

function TContents_MoveCurrent_Params.Get_Down: Boolean;
begin
 Result := f_Down;
end;//TContents_MoveCurrent_Params.Get_Down

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntity;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* Вызов операции Contents.MoveCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_MoveCurrent_Params.Make(aSub, aDown));
  aTarget.Operation(opcode_Contents_MoveCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmAggregate;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* Вызов операции Contents.MoveCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_MoveCurrent_Params.Make(aSub, aDown));
  aTarget.Operation(opcode_Contents_MoveCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmEntityForm;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* Вызов операции Contents.MoveCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSub, aDown);
end;//Op_Contents_MoveCurrent.Call

class function Op_Contents_MoveCurrent.Call(const aTarget: IvcmContainer;
 aSub: Integer;
 aDown: Boolean): Boolean;
 {* Вызов операции Contents.MoveCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSub, aDown);
end;//Op_Contents_MoveCurrent.Call

class function TContents_HasUserComments_Params.Make: IContents_HasUserComments_Params;
var
 l_Inst : TContents_HasUserComments_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_HasUserComments_Params.Make

function TContents_HasUserComments_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TContents_HasUserComments_Params.Get_ResultValue

procedure TContents_HasUserComments_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TContents_HasUserComments_Params.Set_ResultValue

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Contents.HasUserComments у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasUserComments_Params.Make);
  aTarget.Operation(opcode_Contents_HasUserComments, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasUserComments_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Contents.HasUserComments у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasUserComments_Params.Make);
  aTarget.Operation(opcode_Contents_HasUserComments, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasUserComments_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Contents.HasUserComments у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_HasUserComments.Call

class function Op_Contents_HasUserComments.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Contents.HasUserComments у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_HasUserComments.Call

class function TContents_HasBookmarks_Params.Make: IContents_HasBookmarks_Params;
var
 l_Inst : TContents_HasBookmarks_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_HasBookmarks_Params.Make

function TContents_HasBookmarks_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TContents_HasBookmarks_Params.Get_ResultValue

procedure TContents_HasBookmarks_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TContents_HasBookmarks_Params.Set_ResultValue

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Contents.HasBookmarks у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasBookmarks_Params.Make);
  aTarget.Operation(opcode_Contents_HasBookmarks, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasBookmarks_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Contents.HasBookmarks у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_HasBookmarks_Params.Make);
  aTarget.Operation(opcode_Contents_HasBookmarks, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_HasBookmarks_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Contents.HasBookmarks у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_HasBookmarks.Call

class function Op_Contents_HasBookmarks.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Contents.HasBookmarks у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_HasBookmarks.Call

class function TContents_ToggleContentsVisibility_Params.Make: IContents_ToggleContentsVisibility_Params;
var
 l_Inst : TContents_ToggleContentsVisibility_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_ToggleContentsVisibility_Params.Make

function TContents_ToggleContentsVisibility_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TContents_ToggleContentsVisibility_Params.Get_ResultValue

procedure TContents_ToggleContentsVisibility_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TContents_ToggleContentsVisibility_Params.Set_ResultValue

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Contents.ToggleContentsVisibility у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_ToggleContentsVisibility_Params.Make);
  aTarget.Operation(opcode_Contents_ToggleContentsVisibility, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_ToggleContentsVisibility_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Contents.ToggleContentsVisibility у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_ToggleContentsVisibility_Params.Make);
  aTarget.Operation(opcode_Contents_ToggleContentsVisibility, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_ToggleContentsVisibility_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Contents.ToggleContentsVisibility у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_ToggleContentsVisibility.Call

class function Op_Contents_ToggleContentsVisibility.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Contents.ToggleContentsVisibility у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_ToggleContentsVisibility.Call

class function TContents_IsContentsVisible_Params.Make: IContents_IsContentsVisible_Params;
var
 l_Inst : TContents_IsContentsVisible_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContents_IsContentsVisible_Params.Make

function TContents_IsContentsVisible_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TContents_IsContentsVisible_Params.Get_ResultValue

procedure TContents_IsContentsVisible_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TContents_IsContentsVisible_Params.Set_ResultValue

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Contents.IsContentsVisible у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_IsContentsVisible_Params.Make);
  aTarget.Operation(opcode_Contents_IsContentsVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_IsContentsVisible_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Contents.IsContentsVisible у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContents_IsContentsVisible_Params.Make);
  aTarget.Operation(opcode_Contents_IsContentsVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContents_IsContentsVisible_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Contents.IsContentsVisible у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Contents_IsContentsVisible.Call

class function Op_Contents_IsContentsVisible.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Contents.IsContentsVisible у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Contents_IsContentsVisible.Call

constructor TWarning_BecomeActive_Params.Create(aSubID: TnsWarningSub);
begin
 inherited Create;
 f_SubID := aSubID;
end;//TWarning_BecomeActive_Params.Create

class function TWarning_BecomeActive_Params.Make(aSubID: TnsWarningSub): IWarning_BecomeActive_Params;
var
 l_Inst : TWarning_BecomeActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWarning_BecomeActive_Params.Make

function TWarning_BecomeActive_Params.Get_SubID: TnsWarningSub;
begin
 Result := f_SubID;
end;//TWarning_BecomeActive_Params.Get_SubID

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntity;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.BecomeActive у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_BecomeActive_Params.Make(aSubID));
  aTarget.Operation(opcode_Warning_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmAggregate;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.BecomeActive у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_BecomeActive_Params.Make(aSubID));
  aTarget.Operation(opcode_Warning_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmEntityForm;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.BecomeActive у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSubID);
end;//Op_Warning_BecomeActive.Call

class function Op_Warning_BecomeActive.Call(const aTarget: IvcmContainer;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.BecomeActive у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSubID);
end;//Op_Warning_BecomeActive.Call

constructor TWarning_SwitchActive_Params.Create(aSubID: TnsWarningSub);
begin
 inherited Create;
 f_SubID := aSubID;
end;//TWarning_SwitchActive_Params.Create

class function TWarning_SwitchActive_Params.Make(aSubID: TnsWarningSub): IWarning_SwitchActive_Params;
var
 l_Inst : TWarning_SwitchActive_Params;
begin
 l_Inst := Create(aSubID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWarning_SwitchActive_Params.Make

function TWarning_SwitchActive_Params.Get_SubID: TnsWarningSub;
begin
 Result := f_SubID;
end;//TWarning_SwitchActive_Params.Get_SubID

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntity;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.SwitchActive у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_SwitchActive_Params.Make(aSubID));
  aTarget.Operation(opcode_Warning_SwitchActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmAggregate;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.SwitchActive у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TWarning_SwitchActive_Params.Make(aSubID));
  aTarget.Operation(opcode_Warning_SwitchActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmEntityForm;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.SwitchActive у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aSubID);
end;//Op_Warning_SwitchActive.Call

class function Op_Warning_SwitchActive.Call(const aTarget: IvcmContainer;
 aSubID: TnsWarningSub): Boolean;
 {* Вызов операции Warning.SwitchActive у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aSubID);
end;//Op_Warning_SwitchActive.Call

constructor TPicture_InitNewContent_Params.Create(const aData: InsLinkedObjectData);
begin
 inherited Create;
 f_Data := aData;
end;//TPicture_InitNewContent_Params.Create

class function TPicture_InitNewContent_Params.Make(const aData: InsLinkedObjectData): IPicture_InitNewContent_Params;
var
 l_Inst : TPicture_InitNewContent_Params;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPicture_InitNewContent_Params.Make

function TPicture_InitNewContent_Params.Get_Data: InsLinkedObjectData;
begin
 Result := f_Data;
end;//TPicture_InitNewContent_Params.Get_Data

procedure TPicture_InitNewContent_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TPicture_InitNewContent_Params.ClearFields

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntity;
 const aData: InsLinkedObjectData): Boolean;
 {* Вызов операции Picture.InitNewContent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TPicture_InitNewContent_Params.Make(aData));
  aTarget.Operation(opcode_Picture_InitNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmAggregate;
 const aData: InsLinkedObjectData): Boolean;
 {* Вызов операции Picture.InitNewContent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TPicture_InitNewContent_Params.Make(aData));
  aTarget.Operation(opcode_Picture_InitNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmEntityForm;
 const aData: InsLinkedObjectData): Boolean;
 {* Вызов операции Picture.InitNewContent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData);
end;//Op_Picture_InitNewContent.Call

class function Op_Picture_InitNewContent.Call(const aTarget: IvcmContainer;
 const aData: InsLinkedObjectData): Boolean;
 {* Вызов операции Picture.InitNewContent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData);
end;//Op_Picture_InitNewContent.Call

constructor TContentsValidator_IsDocumentAdornmentsChanged_Params.Create(const aNew: InsDocumentAdornments);
begin
 inherited Create;
 f_New := aNew;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Create

class function TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(const aNew: InsDocumentAdornments): IContentsValidator_IsDocumentAdornmentsChanged_Params;
var
 l_Inst : TContentsValidator_IsDocumentAdornmentsChanged_Params;
begin
 l_Inst := Create(aNew);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Make

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New: InsDocumentAdornments;
begin
 Result := f_New;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_New

function TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Get_ResultValue

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.Set_ResultValue

procedure TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields;
begin
 f_New := nil;
 inherited;
end;//TContentsValidator_IsDocumentAdornmentsChanged_Params.ClearFields

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntity;
 const aNew: InsDocumentAdornments): Boolean;
 {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(aNew));
  aTarget.Operation(opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContentsValidator_IsDocumentAdornmentsChanged_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmAggregate;
 const aNew: InsDocumentAdornments): Boolean;
 {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContentsValidator_IsDocumentAdornmentsChanged_Params.Make(aNew));
  aTarget.Operation(opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IContentsValidator_IsDocumentAdornmentsChanged_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmEntityForm;
 const aNew: InsDocumentAdornments): Boolean;
 {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNew);
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(const aTarget: IvcmContainer;
 const aNew: InsDocumentAdornments): Boolean;
 {* Вызов операции ContentsValidator.IsDocumentAdornmentsChanged у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNew);
end;//Op_ContentsValidator_IsDocumentAdornmentsChanged.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции DocumentSubPanel.UpdateSubPanel у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции DocumentSubPanel.UpdateSubPanel у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции DocumentSubPanel.UpdateSubPanel у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function Op_DocumentSubPanel_UpdateSubPanel.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции DocumentSubPanel.UpdateSubPanel у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_DocumentSubPanel_UpdateSubPanel.Call

class function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make: IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
var
 l_Inst : TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make

function TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue: InsBaseSearchPresentation;
begin
 Result := f_ResultValue;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Get_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue(const aValue: InsBaseSearchPresentation);
begin
 f_ResultValue := aValue;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Set_ResultValue

procedure TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.ClearFields

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntity): InsBaseSearchPresentation;
 {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make);
  aTarget.Operation(opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmAggregate): InsBaseSearchPresentation;
 {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TBaseSearchPresentationHolder_GetBaseSearchPresentation_Params.Make);
  aTarget.Operation(opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IBaseSearchPresentationHolder_GetBaseSearchPresentation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmEntityForm): InsBaseSearchPresentation;
 {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

class function Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call(const aTarget: IvcmContainer): InsBaseSearchPresentation;
 {* Вызов операции BaseSearchPresentationHolder.GetBaseSearchPresentation у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_BaseSearchPresentationHolder_GetBaseSearchPresentation.Call

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Editions, op_SetCurrent, en_capEditions, op_capSetCurrent, True, False, opcode_Editions_SetCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_System, op_TimeMachineStateChange, en_capSystem, op_capTimeMachineStateChange, True, True, opcode_System_TimeMachineStateChange)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_InsertHyperlink, en_capSelection, op_capInsertHyperlink, False, True, opcode_Selection_InsertHyperlink)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('ModifyLink', st_user_Selection_InsertHyperlink_ModifyLink))^ do
  begin
   rCaption := 'Изменить ссылку...';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_FindInDict, en_capSelection, op_capFindInDict, False, False, opcode_Selection_FindInDict)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_SetCurrent, en_capContents, op_capSetCurrent, True, False, opcode_Contents_SetCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_MoveCurrent, en_capContents, op_capMoveCurrent, True, False, opcode_Contents_MoveCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_HasUserComments, en_capContents, op_capHasUserComments, True, False, opcode_Contents_HasUserComments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_HasBookmarks, en_capContents, op_capHasBookmarks, True, False, opcode_Contents_HasBookmarks)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_ToggleContentsVisibility, en_capContents, op_capToggleContentsVisibility, True, False, opcode_Contents_ToggleContentsVisibility)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Contents, op_IsContentsVisible, en_capContents, op_capIsContentsVisible, True, False, opcode_Contents_IsContentsVisible)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Warning, op_BecomeActive, en_capWarning, op_capBecomeActive, True, False, opcode_Warning_BecomeActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Warning, op_SwitchActive, en_capWarning, op_capSwitchActive, True, False, opcode_Warning_SwitchActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_InitNewContent, en_capPicture, op_capInitNewContent, True, False, opcode_Picture_InitNewContent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetTypedCorrespondentList, en_capDocumentBlock, op_capGetTypedCorrespondentList, False, False, opcode_DocumentBlock_GetTypedCorrespondentList)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('InText', st_user_DocumentBlock_GetTypedCorrespondentList_InText))^ do
  begin
   rCaption := 'Ссылки на фрагмент:';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_PrintPreview, en_capDocumentBlock, op_capPrintPreview, False, False, opcode_DocumentBlock_PrintPreview)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_Select, en_capDocumentBlock, op_capSelect, False, False, opcode_DocumentBlock_Select)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetSimilarDocsToBlock, en_capDocumentBlock, op_capGetSimilarDocsToBlock, False, False, opcode_DocumentBlock_GetSimilarDocsToBlock)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetCorrespondentList, en_capDocumentBlock, op_capGetCorrespondentList, False, False, opcode_DocumentBlock_GetCorrespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetRespondentList, en_capDocumentBlock, op_capGetRespondentList, False, False, opcode_DocumentBlock_GetRespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetTypedCorrespondentList, en_capDocumentBlock, op_capGetTypedCorrespondentList, False, False, opcode_DocumentBlock_GetTypedCorrespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_GetTypedRespondentList, en_capDocumentBlock, op_capGetTypedRespondentList, False, False, opcode_DocumentBlock_GetTypedRespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_ToMSWord, en_capDocumentBlock, op_capToMSWord, False, False, opcode_DocumentBlock_ToMSWord)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_PrintDialog, en_capDocumentBlock, op_capPrintDialog, False, False, opcode_DocumentBlock_PrintDialog)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_Copy, en_capDocumentBlock, op_capCopy, False, False, opcode_DocumentBlock_Copy)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlock, op_Print, en_capDocumentBlock, op_capPrint, False, False, opcode_DocumentBlock_Print)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_UserCR1, en_capDocumentBlockHeader, op_capUserCR1, False, False, opcode_DocumentBlockHeader_UserCR1)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Corr', st_user_DocumentBlockHeader_UserCR1_Corr))^ do
  begin
   rImageIndex := 18;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_UserCR2, en_capDocumentBlockHeader, op_capUserCR2, False, False, opcode_DocumentBlockHeader_UserCR2)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Corr', st_user_DocumentBlockHeader_UserCR2_Corr))^ do
  begin
   rImageIndex := 18;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_UserCR1, en_capDocumentBlockHeader, op_capUserCR1, False, False, opcode_DocumentBlockHeader_UserCR1)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_UserCR2, en_capDocumentBlockHeader, op_capUserCR2, False, False, opcode_DocumentBlockHeader_UserCR2)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_GetTypedCorrespondentList, en_capDocumentBlockHeader, op_capGetTypedCorrespondentList, False, False, opcode_DocumentBlockHeader_GetTypedCorrespondentList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_AddBookmark, en_capDocumentBlockHeader, op_capAddBookmark, False, False, opcode_DocumentBlockHeader_AddBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_ToMSWord, en_capDocumentBlockHeader, op_capToMSWord, False, False, opcode_DocumentBlockHeader_ToMSWord)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_Print, en_capDocumentBlockHeader, op_capPrint, False, False, opcode_DocumentBlockHeader_Print)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockHeader, op_PrintDialog, en_capDocumentBlockHeader, op_capPrintDialog, False, False, opcode_DocumentBlockHeader_PrintDialog)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_ClearStatusSettings, en_capWarnOnControl, op_capClearStatusSettings, False, False, opcode_WarnOnControl_ClearStatusSettings)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_ShowChanges, en_capWarnOnControl, op_capShowChanges, False, False, opcode_WarnOnControl_ShowChanges)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnOnControl, op_ClearStatus, en_capWarnOnControl, op_capClearStatus, False, False, opcode_WarnOnControl_ClearStatus)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TasksPanel, op_TimeMachineOnOff, en_capTasksPanel, op_capTimeMachineOnOff, False, False, opcode_TasksPanel_TimeMachineOnOff)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('On', st_user_TasksPanel_TimeMachineOnOff_On))^ do
  begin
   rCaption := 'Включить Машину времени';
   rImageIndex := 111;
  end;
  with AddState(TvcmOperationStateForRegister_C('Off', st_user_TasksPanel_TimeMachineOnOff_Off))^ do
  begin
   rCaption := 'Выключить Машину времени';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_TasksPanel, op_TimeMachineOnOff, en_capTasksPanel, op_capTimeMachineOnOff, False, False, opcode_TasksPanel_TimeMachineOnOff)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenContentsFrmAct, en_capDocument, op_capOpenContentsFrmAct, False, False, opcode_Document_OpenContentsFrmAct)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Drug', st_user_Document_OpenContentsFrmAct_Drug))^ do
  begin
   rCaption := 'Структура препарата';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenContentsFrmAct, en_capDocument, op_capOpenContentsFrmAct, False, False, opcode_Document_OpenContentsFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ShowDocumentPicture, en_capDocument, op_capShowDocumentPicture, False, False, opcode_Document_ShowDocumentPicture)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_DocumentSynchroOpenWindow, en_capDocument, op_capDocumentSynchroOpenWindow, False, True, opcode_Document_DocumentSynchroOpenWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_DocumentSynchroOpenNewWindow, en_capDocument, op_capDocumentSynchroOpenNewWindow, False, True, opcode_Document_DocumentSynchroOpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_DictListOpenFrmAct, en_capDocument, op_capDictListOpenFrmAct, False, False, opcode_Document_DictListOpenFrmAct)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_GotoBookmark, en_capDocument, op_capGotoBookmark, False, False, opcode_Document_GotoBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_LiteratureListForDictionary, en_capDocument, op_capLiteratureListForDictionary, False, False, opcode_Document_LiteratureListForDictionary)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenProducedDrugList, en_capDocument, op_capOpenProducedDrugList, False, False, opcode_Document_OpenProducedDrugList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_OpenSimilarDrugList, en_capDocument, op_capOpenSimilarDrugList, False, False, opcode_Document_OpenSimilarDrugList)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ExternalObject, op_Open, en_capExternalObject, op_capOpen, False, False, opcode_ExternalObject_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ExternalObject, op_Save, en_capExternalObject, op_capSave, False, False, opcode_ExternalObject_Save)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnRedaction, op_ShowInfo, en_capWarnRedaction, op_capShowInfo, False, True, opcode_WarnRedaction_ShowInfo)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_WarnRedaction_ShowInfo_Hide))^ do
  begin
   rCaption := 'Скрыть текст предупреждения';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnRedaction, op_OpenActualRedaction, en_capWarnRedaction, op_capOpenActualRedaction, False, True, opcode_WarnRedaction_OpenActualRedaction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnTimeMachine, op_ShowInfo, en_capWarnTimeMachine, op_capShowInfo, False, False, opcode_WarnTimeMachine_ShowInfo)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_WarnTimeMachine_ShowInfo_Hide))^ do
  begin
   rCaption := 'Скрыть текст предупреждения';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnTimeMachine, op_TimeMachineOnOffNew, en_capWarnTimeMachine, op_capTimeMachineOnOffNew, False, False, opcode_WarnTimeMachine_TimeMachineOnOffNew)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('MachineOn', st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOn))^ do
  begin
   rCaption := 'Включить Машину времени';
   rImageIndex := 111;
  end;
  with AddState(TvcmOperationStateForRegister_C('MachineOff', st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOff))^ do
  begin
   rCaption := 'Выключить Машину времени/Изменить дату';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnTimeMachine, op_ShowInfo, en_capWarnTimeMachine, op_capShowInfo, False, False, opcode_WarnTimeMachine_ShowInfo)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnTimeMachine, op_TimeMachineOnOffNew, en_capWarnTimeMachine, op_capTimeMachineOnOffNew, False, False, opcode_WarnTimeMachine_TimeMachineOnOffNew)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnJuror, op_ShowInfo, en_capWarnJuror, op_capShowInfo, False, True, opcode_WarnJuror_ShowInfo)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('Hide', st_user_WarnJuror_ShowInfo_Hide))^ do
  begin
   rCaption := 'Скрыть текст предупреждения';
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_WarnJuror, op_ShowInfo, en_capWarnJuror, op_capShowInfo, False, True, opcode_WarnJuror_ShowInfo)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_BookmarkIcon, op_Delete, en_capBookmarkIcon, op_capDelete, False, False, opcode_BookmarkIcon_Delete)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_BookmarkIcon, op_Edit, en_capBookmarkIcon, op_capEdit, False, False, opcode_BookmarkIcon_Edit)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_UserCommentIcon, op_HideShow, en_capUserCommentIcon, op_capHideShow, False, False, opcode_UserCommentIcon_HideShow)) do
 begin
  with AddState(TvcmOperationStateForRegister_C('GarantHidden', st_user_UserCommentIcon_HideShow_GarantHidden))^ do
  begin
   rCaption := 'Показать комментарии ГАРАНТа';
   rImageIndex := 207;
  end;
  with AddState(TvcmOperationStateForRegister_C('GarantShown', st_user_UserCommentIcon_HideShow_GarantShown))^ do
  begin
   rCaption := 'Скрыть комментарии ГАРАНТа';
   rImageIndex := 207;
  end;
  with AddState(TvcmOperationStateForRegister_C('UserShown', st_user_UserCommentIcon_HideShow_UserShown))^ do
  begin
   rCaption := 'Скрыть мои комментарии';
   rImageIndex := 50;
  end;
  with AddState(TvcmOperationStateForRegister_C('UserHidden', st_user_UserCommentIcon_HideShow_UserHidden))^ do
  begin
   rCaption := 'Показать мои комментарии';
   rImageIndex := 50;
  end;
  with AddState(TvcmOperationStateForRegister_C('Invisible', st_user_UserCommentIcon_HideShow_Invisible))^ do
  begin
   rVisible := vcm_osfFalse;
  end;
  with AddState(TvcmOperationStateForRegister_C('VersionShown', st_user_UserCommentIcon_HideShow_VersionShown))^ do
  begin
   rCaption := 'Выключить информацию об изменениях документа';
   rImageIndex := 206;
  end;
  with AddState(TvcmOperationStateForRegister_C('VersionHidden', st_user_UserCommentIcon_HideShow_VersionHidden))^ do
  begin
   rCaption := 'Включить информацию об изменениях документа';
   rImageIndex := 206;
  end;
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_UserCommentIcon, op_Delete, en_capUserCommentIcon, op_capDelete, False, False, opcode_UserCommentIcon_Delete)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_UserCommentIcon, op_HideShow, en_capUserCommentIcon, op_capHideShow, False, False, opcode_UserCommentIcon_HideShow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_UserComment, op_Delete, en_capUserComment, op_capDelete, False, False, opcode_UserComment_Delete)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_AddUserComment, en_capText, op_capAddUserComment, False, False, opcode_Text_AddUserComment)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_DeleteBookmark, en_capText, op_capDeleteBookmark, False, False, opcode_Text_DeleteBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_EditBookmark, en_capText, op_capEditBookmark, False, False, opcode_Text_EditBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_AddBookmark, en_capText, op_capAddBookmark, False, False, opcode_Text_AddBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_OpenNewWindow, en_capText, op_capOpenNewWindow, False, False, opcode_Text_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Warning, op_TimeMachineOffAndReset, en_capWarning, op_capTimeMachineOffAndReset, False, False, opcode_Warning_TimeMachineOffAndReset)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Warning, op_ActualRedaction, en_capWarning, op_capActualRedaction, False, False, opcode_Warning_ActualRedaction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Warning, op_TimeMachineOff, en_capWarning, op_capTimeMachineOff, False, False, opcode_Warning_TimeMachineOff)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnJuror, en_capReminder, op_capRemWarnJuror, False, False, opcode_Reminder_RemWarnJuror)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnTimeMachineOn, en_capReminder, op_capRemWarnTimeMachineOn, False, False, opcode_Reminder_RemWarnTimeMachineOn)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnRedaction, en_capReminder, op_capRemWarnRedaction, False, False, opcode_Reminder_RemWarnRedaction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnOnControl, en_capReminder, op_capRemWarnOnControl, False, False, opcode_Reminder_RemWarnOnControl)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnIsAbolished, en_capReminder, op_capRemWarnIsAbolished, False, False, opcode_Reminder_RemWarnIsAbolished)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnTimeMachineException, en_capReminder, op_capRemWarnTimeMachineException, False, False, opcode_Reminder_RemWarnTimeMachineException)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnPreActive, en_capReminder, op_capRemWarnPreActive, False, False, opcode_Reminder_RemWarnPreActive)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_RemWarnTimeMachineWarning, en_capReminder, op_capRemWarnTimeMachineWarning, False, False, opcode_Reminder_RemWarnTimeMachineWarning)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Reminder, op_ViewInactualDocument, en_capReminder, op_capViewInactualDocument, False, False, opcode_Reminder_ViewInactualDocument)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_ShowText, en_capSynchroView, op_capShowText, False, True, opcode_SynchroView_ShowText)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_Annotation, en_capSynchroView, op_capAnnotation, False, False, opcode_SynchroView_Annotation)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_ShowAttributes, en_capSynchroView, op_capShowAttributes, False, True, opcode_SynchroView_ShowAttributes)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_ShowRelated, en_capSynchroView, op_capShowRelated, False, True, opcode_SynchroView_ShowRelated)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_ShowUserCRList1, en_capSynchroView, op_capShowUserCRList1, False, True, opcode_SynchroView_ShowUserCRList1)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_ShowUserCRList2, en_capSynchroView, op_capShowUserCRList2, False, True, opcode_SynchroView_ShowUserCRList2)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SynchroView, op_SimilarDocuments, en_capSynchroView, op_capSimilarDocuments, False, False, opcode_SynchroView_SimilarDocuments)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edition, op_OpenNewWindow, en_capEdition, op_capOpenNewWindow, False, False, opcode_Edition_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Edition, op_OpenNewTab, en_capEdition, op_capOpenNewTab, False, False, opcode_Edition_OpenNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_Copy, en_capAttribute, op_capCopy, False, False, opcode_Attribute_Copy)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_Resize, en_capPicture, op_capResize, False, False, opcode_Picture_Resize)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_Enlarge, en_capPicture, op_capEnlarge, False, False, opcode_Picture_Enlarge)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_Shrink, en_capPicture, op_capShrink, False, False, opcode_Picture_Shrink)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_ActualSize, en_capPicture, op_capActualSize, False, False, opcode_Picture_ActualSize)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_FitInWIndow, en_capPicture, op_capFitInWIndow, False, False, opcode_Picture_FitInWIndow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ContentsValidator, op_IsDocumentAdornmentsChanged, en_capContentsValidator, op_capIsDocumentAdornmentsChanged, True, False, opcode_ContentsValidator_IsDocumentAdornmentsChanged)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentSubPanel, op_UpdateSubPanel, en_capDocumentSubPanel, op_capUpdateSubPanel, True, False, opcode_DocumentSubPanel_UpdateSubPanel)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Editions, op_DoCompareEditions, en_capEditions, op_capDoCompareEditions, False, False, opcode_Editions_DoCompareEditions)) do
 begin
  SetImageIndex(200);
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Editions, op_BuildChangedFragments, en_capEditions, op_capBuildChangedFragments, False, False, opcode_Editions_BuildChangedFragments)) do
 begin
  SetImageIndex(205);
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_DocumentBlockBookmarks, op_AddBookmark, en_capDocumentBlockBookmarks, op_capAddBookmark, False, False, opcode_DocumentBlockBookmarks_AddBookmark)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_IntranetSourcePoint, op_GoToIntranet, en_capIntranetSourcePoint, op_capGoToIntranet, False, False, opcode_IntranetSourcePoint_GoToIntranet)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_Open, en_capPicture, op_capOpen, False, False, opcode_Picture_Open)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_OpenNewWindow, en_capPicture, op_capOpenNewWindow, False, False, opcode_Picture_OpenNewWindow)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Picture, op_OpenNewTab, en_capPicture, op_capOpenNewTab, False, False, opcode_Picture_OpenNewTab)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Document, op_ChangesButton, en_capDocument, op_capChangesButton, False, False, opcode_Document_ChangesButton)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SubsPanel, op_CopySubNumber, en_capSubsPanel, op_capCopySubNumber, False, False, opcode_SubsPanel_CopySubNumber)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_BaseSearchPresentationHolder, op_GetBaseSearchPresentation, en_capBaseSearchPresentationHolder, op_capGetBaseSearchPresentation, True, False, opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_SelectWord, en_capText, op_capSelectWord, False, False, opcode_Text_SelectWord)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Text, op_SelectPara, en_capText, op_capSelectPara, False, False, opcode_Text_SelectPara)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
