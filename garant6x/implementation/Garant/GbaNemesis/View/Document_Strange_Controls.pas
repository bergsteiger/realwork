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

var st_user_Selection_InsertHyperlink_ModifyLink: TvcmOperationStateIndex = (rID : -1);
 {* Выделенные элементы -> Поставить ссылку... <-> Изменить ссылку... }
var st_user_DocumentBlock_GetTypedCorrespondentList_InText: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления -> Ссылки на фрагмент (вид информации) <-> Ссылки на фрагмент: }
var st_user_DocumentBlockHeader_UserCR1_Corr: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 1 <->  }
var st_user_DocumentBlockHeader_UserCR2_Corr: TvcmOperationStateIndex = (rID : -1);
 {* Пункт оглавления - Заголовок документ -> Пользовательские ссылки на документ (ссылки из документа) 2 <->  }
var st_user_TasksPanel_TimeMachineOnOff_On: TvcmOperationStateIndex = (rID : -1);
 {*  -> Включить Машину времени с календарной даты\Выключить Машину времени <-> Включить Машину времени }
var st_user_TasksPanel_TimeMachineOnOff_Off: TvcmOperationStateIndex = (rID : -1);
 {*  -> Включить Машину времени с календарной даты\Выключить Машину времени <-> Выключить Машину времени }
var st_user_Document_OpenContentsFrmAct_Drug: TvcmOperationStateIndex = (rID : -1);
 {*  -> Структура документа <-> Структура препарата }
var st_user_WarnRedaction_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение о неактуальной редакции -> Показать текст предупреждения <-> Скрыть текст предупреждения }
var st_user_WarnTimeMachine_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Показать текст предупреждения <-> Скрыть текст предупреждения }
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOn: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Включить/Выключить Машину времени <-> Включить Машину времени }
var st_user_WarnTimeMachine_TimeMachineOnOffNew_MachineOff: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение для Машины времени -> Включить/Выключить Машину времени <-> Выключить Машину времени/Изменить дату }
var st_user_WarnJuror_ShowInfo_Hide: TvcmOperationStateIndex = (rID : -1);
 {* Предупреждение (юридическое) -> Показать текст предупреждения <-> Скрыть текст предупреждения }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
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
  aTarget.Operation(TdmStdRes.opcode_Editions_SetCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Editions_SetCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
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
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_System_TimeMachineStateChange, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_SetCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_SetCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_MoveCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_MoveCurrent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_HasUserComments, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_HasUserComments, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_HasBookmarks, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_HasBookmarks, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_ToggleContentsVisibility, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_ToggleContentsVisibility, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_IsContentsVisible, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Contents_IsContentsVisible, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Warning_BecomeActive, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Warning_BecomeActive, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Warning_SwitchActive, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Warning_SwitchActive, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Picture_InitNewContent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_Picture_InitNewContent, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_ContentsValidator_IsDocumentAdornmentsChanged, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_DocumentSubPanel_UpdateSubPanel, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
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
  aTarget.Operation(TdmStdRes.opcode_BaseSearchPresentationHolder_GetBaseSearchPresentation, l_Params);
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
