unit ExTextOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ExTextOptions_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ExText_Form
 , Base_Operations_Strange_Controls
 , Search_Strange_Controls
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 , l3Interfaces
 , l3Variant
 , DataAdapterInterfaces
 , eeInterfaces
 , l3Units
 , nevTools
 , afwInterfaces
 , bsTypesNew
 , Classes
 , nsTypes
 , DocumentUnit
 , AdapterFacade
 , nevNavigation
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

const
 {* Локализуемые строки Reminders' Hints }
 str_WarnRedactionHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionHint'; rValue : 'Внимание! Настоящая редакция документа не действует');
  {* 'Внимание! Настоящая редакция документа не действует' }
 str_WarnTimeMachineOnHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineOnHint'; rValue : 'Машина времени включена');
  {* 'Машина времени включена' }

type
 // RemindersLineZone

 TExTextOptionsForm = class(TExTextForm)
  private
   f_RemindersLine: TnscRemindersLine;
    {* Поле для свойства RemindersLine }
   f_WarnTimeMachineException: TnscReminder;
    {* Поле для свойства WarnTimeMachineException }
   f_WarnIsAbolished: TnscReminder;
    {* Поле для свойства WarnIsAbolished }
   f_WarnPreActive: TnscReminder;
    {* Поле для свойства WarnPreActive }
   f_WarnTimeMachineWarning: TnscReminder;
    {* Поле для свойства WarnTimeMachineWarning }
   f_WarnOnControl: TnscReminder;
    {* Поле для свойства WarnOnControl }
   f_WarnJuror: TnscReminder;
    {* Поле для свойства WarnJuror }
   f_WarnRedaction: TnscReminder;
    {* Поле для свойства WarnRedaction }
   f_WarnInactualDocument: TnscReminder;
    {* Поле для свойства WarnInactualDocument }
   f_WarnTimeMachineOn: TnscReminder;
    {* Поле для свойства WarnTimeMachineOn }
  protected
   f_DocOpsList: IvcmItems;
  private
   procedure TextBlockChange(aSender: TObject);
   procedure TextBlockScroll(aSender: TObject;
    aDown: Boolean);
   function TextMouseAction(aSender: TObject;
    const aHotSpot: IeeHotSpot;
    aButton: TeeMouseButton;
    anAction: TeeMouseAction;
    Keys: TeeShiftState;
    aWasSelection: Boolean): Boolean;
   procedure TextCanSplitPara(aSender: TObject;
    const aPara: IeePara;
    var Allow: Boolean);
   procedure TextUserCommentsHidden(Sender: TObject);
   procedure TextAfterFirstPaint(Sender: TObject);
   procedure TextCommentsVisibleChanged(Sender: TObject);
   procedure TextShowDocumentPartsChanged(Sender: TObject);
   procedure TextDrawSpecialChange(Sender: TObject);
   function SubPanelMouseOverSub(Sender: TObject;
    const Pt: Tl3SPoint;
    const R: Tl3SRect;
    const aSub: IevSub;
    aLayer: Integer): Boolean;
   procedure SubPanelClickSub(Sender: TObject;
    SubType: Integer;
    SubHandle: Integer;
    aKind: TafwClickKind);
   procedure vcmEntityFormRefGetStatus(aSender: TObject;
    out theStatus: TafwStatusInfo);
   function GetContentsElement(const aBlock: IevDocumentPart): IevDocumentPart;
  protected
   procedure SetReminderOpParams;
   function WarnJurorInfo: Il3CString;
    {* сообщение к предупреждению "В настоящий документ внесены изменения" }
   function TimeMachineWarningOnInfo: Il3CString;
    {* сообщение к предупреждению машина времени включена }
   function TimeMachineWarningOnHint: Il3CString;
    {* сообщение к предупреждению машина времени включена }
   function WarnPreActiveInfo: Il3CString;
    {* сообщение к предупреждению документ не вступил в силу }
   function HasWarning: Boolean;
   function WarnOnControlInfo: Il3CString;
    {* сообщение к предупреждению документ на контроле измене }
   function WarnIsAbolishedInfo: Il3CString;
    {* сообщение к предупреждению документ устратил силу }
   function BaseTimeMachineWarningInfo(aType: TTMWarningType): Il3CString;
    {* сообщение к предупрежедению включенной машины времени }
   function TimeMachineWarningInfo: Il3CString;
    {* сообщение к предупреждению ??? }
   function CurrentParaPos: TbsDocPos;
   function ContextEntitiesGetTarget(aControl: TComponent;
    aX: Integer;
    aY: Integer;
    out theTarget: IUnknown): Boolean;
   function SubPanelEntitiesGetTarget(aControl: TComponent;
    aX: Integer;
    aY: Integer;
    out theTarget: IUnknown): Boolean;
   procedure ReloadRedaction(aChangeType: TnsChangeRedactionType;
    aRedaction: TRedactionID = 0); override;
   function ReloadRedaction(const aDate: AdapterDate): Boolean; override;
   procedure SetActualRedaction; override;
   function ExtractRangeFromContents(const aData: IUnknown;
    aUserType: Integer): InevRange; override;
   procedure ExportBlock(const aRange: InevRange;
    ToActiveWindow: Boolean); override;
   procedure SelectBlock(const aRange: InevRange); override;
   procedure CopyBlock(const aRange: InevRange); override;
   procedure PrintBlock(const aRange: InevRange); override;
   procedure PrintDialogBlock(const aRange: InevRange); override;
   procedure PreviewBlock(const aRange: InevRange); override;
   function FindBookmarkInText(const aBookmark: IBookmark;
    out aSub: IeeSub): Boolean; override;
   procedure InitHyperLink(const aHyperLink: IevHyperlink;
    const aBaseEntity: IUnknown); override;
   function EnableRedactionOps(const aParams: IvcmTestParamsPrim): Boolean; override;
   procedure OpenInWindow(aNew: Boolean = True); override;
   procedure CreateTOC(const aTOC: IdeSimpleTree); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
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
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure EntitiesInited; override;
    {* Вызывается после того как все операции зарегистрированы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SaveOwnFormState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ReleaseResources; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure OpenInNewWindow; override;
   procedure Show; override;
    {* Показывать метки }
   procedure RemWarnJuror; override;
   procedure RemWarnTimeMachineOn; override;
   procedure RemWarnRedaction; override;
   procedure RemWarnOnControl; override;
   procedure RemWarnIsAbolished; override;
   procedure RemWarnTimeMachineException; override;
   procedure RemWarnPreActive; override;
   procedure RemWarnTimeMachineWarning; override;
   procedure ViewInactualDocument; override;
   procedure ChangesButton; override;
    {* Изменения в документе }
   procedure CopySubNumber; override;
    {* Копировать позицию }
   procedure ShowByShortCut; override;
   {$If NOT Defined(NoVCM)}
   procedure FindContext; override;
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindNext; override;
    {* Найти далее }
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
   procedure NextDocumentInList; override;
    {* Следующий документ в списке }
   procedure ReturnToList; override;
    {* Вернуться в списк }
   procedure SaveToFolder; override;
    {* Сохранить в папки }
   procedure LoadFromFolder; override;
    {* Загрузить из папок }
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   procedure GetRelatedDocFrmAct; override;
    {* Справка к документу }
   procedure AddBookmark; override;
    {* Добавить закладку }
   procedure GetCorrespondentList; override;
    {* Ссылки на документ }
   procedure GetRespondentList; override;
    {* Ссылки из документа }
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindPrev; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ShowJurorComments; override;
    {* Показать юридические комментарии }
   procedure ShowSpecial; override;
    {* Показывать спецсимволы }
   procedure ShowInfo; override;
    {* Показывать блоки }
   procedure FindInDict; override;
    {* Найти в Толковом словаре }
   procedure GetCorrespondentListExFrmAct; override;
    {* Ссылки на документ (вид информации) }
   procedure GetRespondentListExFrmAct; override;
    {* Ссылки из документа (вид информации) }
   procedure ActualRedaction; override;
   procedure OpenRedactionListFrmAct; override;
    {* Список редакций }
   procedure GetCorrespondentList; override;
   procedure GetRespondentList; override;
   procedure GetAnnotationDocFrmAct; override;
   procedure SimilarDocuments; override;
   procedure GetTypedCorrespondentList; override;
   procedure PrevRedaction; override;
   procedure NextRedaction; override;
   procedure AddToControl; override;
   procedure ShowCorrespondentListToPart; override;
   procedure ShowRespondentListToPart; override;
   procedure ClearStatusSettings; override;
    {* Способ сброса статуса "изменен" }
   procedure AddBookmark; override;
   procedure ToMSWord; override;
   procedure Print; override;
   procedure PrintDialog; override;
   procedure AddBookmark; override;
    {* Установить закладку на фрагмент }
   procedure OpenContentsFrmAct; override;
   procedure ShowDocumentPicture; override;
   procedure OpenActualRedaction; override;
   procedure ShowChanges; override;
    {* Показать изменения }
   procedure ClearStatus; override;
    {* Сбросить статус "изменен" }
   procedure AddUserComment; override;
   procedure GetGraphicImage; override;
   procedure DocumentSynchroOpenWindow; override;
   procedure DocumentSynchroOpenNewWindow; override;
   procedure DictListOpenFrmAct; override;
   procedure GotoBookmark; override;
   procedure LiteratureListForDictionary; override;
   procedure AddBookmark; override;
   procedure OpenNewWindow; override;
   procedure OpenProducedDrugList; override;
   procedure OpenSimilarDrugList; override;
   procedure ShowJurorComments; override;
    {* Показать/скрыть комментарии ГАРАНТа }
   procedure ShowUserComments; override;
    {* Показать/скрыть мои комментарии }
   procedure ShowTechComments; override;
    {* Показывать технические комментарии }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure UserCR1; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 1 }
   procedure UserCR2; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 2 }
   procedure ShowVersionComments; override;
    {* Включить/выключить информацию об изменениях документа }
   procedure CompareEditions; override;
    {* Сравнение редакций }
   procedure TimeMachineOnOffNew; override;
    {* Включить Машину времени }
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure TimeMachineOnOffNew; override;
    {* Включить/Выключить Машину времени }
   procedure ShowInfo; override;
    {* Показать текст предупреждения }
   procedure UserCR1; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 1 }
   procedure UserCR2; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 2 }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure MakeHyperlinkToDocument; override;
    {* Создать ссылку на документ }
   procedure PrevDocumentInList; override;
    {* Предыдущий документ в списке }
   procedure DocumentIsUseful; override;
    {* Нравится }
   procedure DocumentIsUseless; override;
    {* Не нравится }
   procedure SelectWord; override;
   procedure SelectPara; override;
   procedure GetSimilarDocsToBlock; override;
  public
   property RemindersLine: TnscRemindersLine
    read f_RemindersLine;
 end;//TExTextOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , nsHyperLinkProcessor
 , evCustomEditor
 {$If Defined(Nemesis)}
 , eePara
 {$IfEnd} // Defined(Nemesis)
 , eeInterfacesEx
 , evdTypes
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTypesUnit
 , nsDocumentTools
 , DocumentUserTypes_dftDocument_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , DocumentUserTypes_dftRelatedDoc_UserType
 , bsUtils
 , WarningConst
 , ControlStatusUtils
 , resWarnImages
 , DocumentUserTypes_dftDrug_UserType
 , DocumentUserTypes_dftAutoreferat_UserType
 , DocumentUserTypes_dftAutoreferatAfterSearch_UserType
 , nsManagers
 , nsConst
 {$If Defined(Nemesis)}
 , eeParaTools
 {$IfEnd} // Defined(Nemesis)
 , l3Chars
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , nsValueMaps
 , nsValueMapsIDs
 , DocumentUserTypes_dftDictEntry_UserType
 , DocumentUserTypes_dftMedDictEntry_UserType
 , DocumentUserTypes_dftConsultation_UserType
 , bsChangeRedationWorker
 , nevContainers
 , afwFacade
 , afwNavigation
 , nsOpenUtils
 , DocumentInterfaces
 , l3TreeInterfaces
 , deSimpleTree
 , nevRangeList
 , nevRangeListTools
 , evMultiSelectionBlock
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , evConstStringData
 , eeEditor
 , eeSubPanel
 , DocumentUserTypes_dftAACRight_UserType
 , DocumentUserTypes_dftAACLeft_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , nsUseDocumentSubPanelOperationEvent
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Memory
 , k2DocumentBuffer
 , evCustomWikiReader
 , ParaList_Const
 , k2Tags
;

const
 c_Div = 10;
 c_GarantComment = - (Ord(ev_sbtMark) * c_Div + 0);
  {* Комментарий юристов в SubPanel }
 c_UserComment = - (Ord(ev_sbtMark) * c_Div + 1);
  {* Пользовательский комментарий в SubPanel }
 c_VersionComment = - (Ord(ev_sbtMark) * c_Div + 2);
  {* Версионный комментарий юристов в SubPanel }

procedure TExTextOptionsForm.SetReminderOpParams;
//#UC START# *4C7FAE9B01E1_4C7F801D0304_var*
//#UC END# *4C7FAE9B01E1_4C7F801D0304_var*
begin
//#UC START# *4C7FAE9B01E1_4C7F801D0304_impl*
 with aParams.Op do
 begin
  Flag[vcm_ofVisible] := (aInfo <> nil);
  if Flag[vcm_ofVisible] then
  begin
   Hint := RefineBaloonHint(aInfo);
   LongHint := Hint;
   Caption := aCaption;
  end;//Flag[vcm_ofVisible]
 end;//with aParams.Op do
//#UC END# *4C7FAE9B01E1_4C7F801D0304_impl*
end;//TExTextOptionsForm.SetReminderOpParams

function TExTextOptionsForm.WarnJurorInfo: Il3CString;
 {* сообщение к предупреждению "В настоящий документ внесены изменения" }
//#UC START# *4C80CFC301F1_4C7F801D0304_var*
//#UC END# *4C80CFC301F1_4C7F801D0304_var*
begin
//#UC START# *4C80CFC301F1_4C7F801D0304_impl*
 if HasWarning and
    not (Document.GetStatus in [IS_ABOLISHED, IS_PREACTIVE]) and
    not (UserType in [dftAACRight]) then
  Result := nsGetDocumentWarning(Document)
 else
  Result := nil;
//#UC END# *4C80CFC301F1_4C7F801D0304_impl*
end;//TExTextOptionsForm.WarnJurorInfo

function TExTextOptionsForm.TimeMachineWarningOnInfo: Il3CString;
 {* сообщение к предупреждению машина времени включена }
//#UC START# *4C80D03001DC_4C7F801D0304_var*
//#UC END# *4C80D03001DC_4C7F801D0304_var*
begin
//#UC START# *4C80D03001DC_4C7F801D0304_impl*
 if (UserType in [dftDocument, dftAACLeft]) and
   DefDataAdapter.TimeMachine.IsOn then
  Result := l3Fmt(vcmConstString(str_TimeMachineTurnOnOnDate),
   [DefDataAdapter.TimeMachine.DateStr])
 else
  Result := nil;
//#UC END# *4C80D03001DC_4C7F801D0304_impl*
end;//TExTextOptionsForm.TimeMachineWarningOnInfo

function TExTextOptionsForm.TimeMachineWarningOnHint: Il3CString;
 {* сообщение к предупреждению машина времени включена }
//#UC START# *4C80D0730151_4C7F801D0304_var*
//#UC END# *4C80D0730151_4C7F801D0304_var*
begin
//#UC START# *4C80D0730151_4C7F801D0304_impl*
 if (UserType in [dftDocument, dftAACLeft]) and DefDataAdapter.TimeMachine.IsOn then
  Result := DefDataAdapter.TimeMachine.DateStr
 else
  Result := nil;
//#UC END# *4C80D0730151_4C7F801D0304_impl*
end;//TExTextOptionsForm.TimeMachineWarningOnHint

function TExTextOptionsForm.WarnPreActiveInfo: Il3CString;
 {* сообщение к предупреждению документ не вступил в силу }
//#UC START# *4C80D2370306_4C7F801D0304_var*
//#UC END# *4C80D2370306_4C7F801D0304_var*
begin
//#UC START# *4C80D2370306_4C7F801D0304_impl*
 Result := nil;
 if not (UserType in [dftAACRight]) then
  if HasWarning and (Document.GetStatus = IS_PREACTIVE) then
   Result := nsGetDocumentWarning(Document);
//#UC END# *4C80D2370306_4C7F801D0304_impl*
end;//TExTextOptionsForm.WarnPreActiveInfo

function TExTextOptionsForm.HasWarning: Boolean;
//#UC START# *4C80D52A007B_4C7F801D0304_var*
//#UC END# *4C80D52A007B_4C7F801D0304_var*
begin
//#UC START# *4C80D52A007B_4C7F801D0304_impl*
 Result := Assigned(Document) and Document.HasWarning;
//#UC END# *4C80D52A007B_4C7F801D0304_impl*
end;//TExTextOptionsForm.HasWarning

function TExTextOptionsForm.WarnOnControlInfo: Il3CString;
 {* сообщение к предупреждению документ на контроле измене }
//#UC START# *4C80D61203E4_4C7F801D0304_var*
//#UC END# *4C80D61203E4_4C7F801D0304_var*
begin
//#UC START# *4C80D61203E4_4C7F801D0304_impl*
 if not (UserType in [dftAACRight])
  then Result := bsFullControlStatusHint(ucpUnderControl)
  else Result := nil;
//#UC END# *4C80D61203E4_4C7F801D0304_impl*
end;//TExTextOptionsForm.WarnOnControlInfo

function TExTextOptionsForm.WarnIsAbolishedInfo: Il3CString;
 {* сообщение к предупреждению документ устратил силу }
//#UC START# *4C80D65C01D8_4C7F801D0304_var*
//#UC END# *4C80D65C01D8_4C7F801D0304_var*
begin
//#UC START# *4C80D65C01D8_4C7F801D0304_impl*
 Result := nil;
 if not (UserType in [dftAACRight]) then
  if HasWarning and (Document.GetStatus = IS_ABOLISHED) then
   Result := nsGetDocumentWarning(Document);
//#UC END# *4C80D65C01D8_4C7F801D0304_impl*
end;//TExTextOptionsForm.WarnIsAbolishedInfo

function TExTextOptionsForm.BaseTimeMachineWarningInfo(aType: TTMWarningType): Il3CString;
 {* сообщение к предупрежедению включенной машины времени }
//#UC START# *4C80D68600A1_4C7F801D0304_var*
//#UC END# *4C80D68600A1_4C7F801D0304_var*
begin
//#UC START# *4C80D68600A1_4C7F801D0304_impl*
 if not (defDataAdapter.TimeMachine.
   GetTimeMachineWarning(Document, Result) = aType) then
  Result := nil;
//#UC END# *4C80D68600A1_4C7F801D0304_impl*
end;//TExTextOptionsForm.BaseTimeMachineWarningInfo

function TExTextOptionsForm.TimeMachineWarningInfo: Il3CString;
 {* сообщение к предупреждению ??? }
//#UC START# *4C80D6CB002A_4C7F801D0304_var*
//#UC END# *4C80D6CB002A_4C7F801D0304_var*
begin
//#UC START# *4C80D6CB002A_4C7F801D0304_impl*
 Result := BaseTimeMachineWarningInfo(tmwWarning);
 if (Result = nil) and
   defDataAdapter.TimeMachine.HasNotSureWarning(Document) then
  Result := str_wgNotShureWarningHint.AsCStr;
//#UC END# *4C80D6CB002A_4C7F801D0304_impl*
end;//TExTextOptionsForm.TimeMachineWarningInfo

procedure TExTextOptionsForm.TextBlockChange(aSender: TObject);
//#UC START# *4F82F0810313_4C7F801D0304_var*
var
 l_CurSub: IevSub;
//#UC END# *4F82F0810313_4C7F801D0304_var*
begin
//#UC START# *4F82F0810313_4C7F801D0304_impl*
 if (UserType in [dftDocument, dftDrug]) then
 begin
  with Text do
   l_CurSub := GetContentsElement(GetNearestBlockByCursor(nil));
  try
   if (l_CurSub <> nil) then
    Op_Contents_SetCurrent.Call(Aggregate, l_CurSub.ID);
  finally
   l_CurSub := nil;
  end;//try..finally
 end;//UserType in [dftDocument,dftDrug]
//#UC END# *4F82F0810313_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextBlockChange

procedure TExTextOptionsForm.TextBlockScroll(aSender: TObject;
 aDown: Boolean);
//#UC START# *4F82F0A0030A_4C7F801D0304_var*
var
 l_TopCursor : InevBasePoint;
 l_CurSub    : IevSub;
//#UC END# *4F82F0A0030A_4C7F801D0304_var*
begin
//#UC START# *4F82F0A0030A_4C7F801D0304_impl*
 if (UserType in [dftDocument, dftDrug]) then
  with Text do
  begin
   if GetTopCursor(l_TopCursor) then
   try
    l_CurSub := GetContentsElement(GetNearestBlockByCursor(l_TopCursor));
    try
     if (l_CurSub <> nil) then
      Op_Contents_MoveCurrent.Call(Aggregate, l_CurSub.ID, aDown);
    finally
     l_CurSub := nil;
    end;
   finally
    l_TopCursor := nil;
   end;
  end;
//#UC END# *4F82F0A0030A_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextBlockScroll

function TExTextOptionsForm.TextMouseAction(aSender: TObject;
 const aHotSpot: IeeHotSpot;
 aButton: TeeMouseButton;
 anAction: TeeMouseAction;
 Keys: TeeShiftState;
 aWasSelection: Boolean): Boolean;
//#UC START# *4F82F0C7004D_4C7F801D0304_var*
var
 l_Picture : IeePicture;
//#UC END# *4F82F0C7004D_4C7F801D0304_var*
begin
//#UC START# *4F82F0C7004D_4C7F801D0304_impl*
 Result := false;
 if (aButton = ee_mbLeft) and (anAction in [ee_maUp, ee_maDouble])
    and (not aWasSelection) then
 begin
  if (ee_ssCtrl in Keys) then
   Exit;
  if Supports(aHotSpot.Para, IeePicture, l_Picture) then
   try
    Result := true;
    OpenPicture(aHotSpot.Para, l_Picture);
   finally
    l_Picture := nil;
   end;//try..finally
 end;//aButton = ee_mbLeft..
//#UC END# *4F82F0C7004D_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextMouseAction

procedure TExTextOptionsForm.TextCanSplitPara(aSender: TObject;
 const aPara: IeePara;
 var Allow: Boolean);
//#UC START# *4F82F10600ED_4C7F801D0304_var*
//#UC END# *4F82F10600ED_4C7F801D0304_var*
begin
//#UC START# *4F82F10600ED_4C7F801D0304_impl*
 Allow := (Document <> nil) and (aPara.ID > 0);
//#UC END# *4F82F10600ED_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextCanSplitPara

procedure TExTextOptionsForm.TextUserCommentsHidden(Sender: TObject);
//#UC START# *4F82F137005B_4C7F801D0304_var*
//#UC END# *4F82F137005B_4C7F801D0304_var*
begin
//#UC START# *4F82F137005B_4C7F801D0304_impl*
 if Ask(qr_UserCommentsHidden) then
  Text.ShowUserComments := true;
//#UC END# *4F82F137005B_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextUserCommentsHidden

procedure TExTextOptionsForm.TextAfterFirstPaint(Sender: TObject);
//#UC START# *4F82F15D0133_4C7F801D0304_var*
//#UC END# *4F82F15D0133_4C7F801D0304_var*
begin
//#UC START# *4F82F15D0133_4C7F801D0304_impl*
 {$IfDef vcmUseProfilers}
 if UserType = dftDocument then
  ProfilersManager.Document.DocumentPainted;
 {$EndIf vcmUseProfilers}
//#UC END# *4F82F15D0133_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextAfterFirstPaint

procedure TExTextOptionsForm.TextCommentsVisibleChanged(Sender: TObject);
//#UC START# *4F82F18203A7_4C7F801D0304_var*
//#UC END# *4F82F18203A7_4C7F801D0304_var*
begin
//#UC START# *4F82F18203A7_4C7F801D0304_impl*
 UpdateSubPanelDescription;
//#UC END# *4F82F18203A7_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextCommentsVisibleChanged

procedure TExTextOptionsForm.TextShowDocumentPartsChanged(Sender: TObject);
//#UC START# *4F82F1A901BD_4C7F801D0304_var*
//#UC END# *4F82F1A901BD_4C7F801D0304_var*
begin
//#UC START# *4F82F1A901BD_4C7F801D0304_impl*
 Settings.SaveBoolean(pi_Document_ShowBlockBorders,
                      Text.ShowDocumentParts,
                      dv_Document_ShowBlockBorders);
//#UC END# *4F82F1A901BD_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextShowDocumentPartsChanged

procedure TExTextOptionsForm.TextDrawSpecialChange(Sender: TObject);
//#UC START# *4F82F1CC00F6_4C7F801D0304_var*
//#UC END# *4F82F1CC00F6_4C7F801D0304_var*
begin
//#UC START# *4F82F1CC00F6_4C7F801D0304_impl*
 Settings.SaveBoolean(pi_Document_ShowSpecial,
                      Text.DrawSpecial,
                      dv_Document_ShowSpecial);
//#UC END# *4F82F1CC00F6_4C7F801D0304_impl*
end;//TExTextOptionsForm.TextDrawSpecialChange

function TExTextOptionsForm.SubPanelMouseOverSub(Sender: TObject;
 const Pt: Tl3SPoint;
 const R: Tl3SRect;
 const aSub: IevSub;
 aLayer: Integer): Boolean;
//#UC START# *4F82F1F10297_4C7F801D0304_var*
var
 l_Sep       : Il3CString;
 l_CT        : TeeCommentType;
 l_Hint      : Il3CString;

 procedure ParaProccessed(const aPara: IeePara);
 var
  l_ParaNumber : Integer;
  l_CurPara    : IeePara;
//  l_Subs       : IeeSubList;
  l_Marks       : IeeSubList;
  l_TextPara   : IeeTextPara;
 begin
  if (aPara <> nil) then
  begin
   l_CurPara := aPara;
   l_ParaNumber := 0;
   while l_CurPara <> nil do
   begin
    inc(l_ParaNumber);
    if Supports(l_CurPara, IeeTextPara, l_TextPara) then
     try
      if not l_TextPara.IsComment(l_CT) and
         not l3IsNil(l_TextPara.Text) then
       break;
(*    // Так писать и проверять НЕ НАДО
      l_Subs := l_TextPara.Subs;
      if Assigned(l_Subs) then
       try
        if ((l_Subs.Count > 0) or (l_TextPara.IndexInParent = 0)) and (l_ParaNumber > 1) then //(если есть Sub) and (этот параграф не первый)
         break; //это комментарий к следующему параграфу
       finally
        l_Subs := nil
       end;*)

      if not l3IsNil(l_TextPara.Text) then
      begin
       l_Hint := l3Cat([l_Hint, l_Sep, l_TextPara.Text]);
       l_Sep := l3CStr(cc_HardEnter);
      end;//not l3IsNil(l_TextPara.Text)

      l_CurPara := eeNextOverallPara(l_TextPara, Text){.Next};
      // Параграф последний - лесом.
      if l_CurPara = nil then
       break;
      l_Marks := l_CurPara.Marks;
      //это комментарий к следующей точке входа - лесом его
      if Assigned(l_Marks) and (l_Marks.Count > 0) then
       Break;
     finally
      l_TextPara := nil;
     end//try..finally
    else
     break;
   end;//while true
   if l3IsChar(l_Hint, l3Len(l_Hint) - 1, cc_HardEnter) then
    l_Hint := l3Copy(l_Hint, 0, l3Len(l_Hint) - 1);
  end;//aPara <> nil
 end;

var
 l_Para : IeePara;
 l_Sub  : IeeSub;
//#UC END# *4F82F1F10297_4C7F801D0304_var*
begin
//#UC START# *4F82F1F10297_4C7F801D0304_impl*
 Result := False;
 with Sender As TControl do
 begin
  ShowHint := false;
  l_Hint := nil;
  try
   case aLayer of
    c_GarantComment:
     begin
      l_Sub := Text.Editor.Data.Document.Marks.SubsByID[aSub.ID];
      if (l_Sub <> nil) then
      begin
       l_Para := l_Sub.LeafPara;
       l_CT := ee_ctUsual;
       l_Hint := vcmCStr(str_nsGarantComment);
       if Text.ShowComments then
        Exit
       else
        l_Sep := vcmCStr(str_nsColonSpace);

       Result := True;
       ParaProccessed(l_Para);
      end;//l_Sub <> nil
     end; // c_GarantComment
    c_UserComment:
     begin
      l_Sub := Text.Editor.Data.Document.Marks.SubsByID[aSub.ID];
      if (l_Sub <> nil) then
      begin
       l_Para := l_Sub.LeafPara;
       l_CT := ee_ctUser;
       l_Hint := vcmCStr(str_nsUserComment);
       if Text.ShowUserComments then
        Exit
       else
        l_Sep := vcmCStr(str_nsColonSpace);

       Result := True;
       ParaProccessed(l_Para);
      end;//l_Sub <> nil
     end;// c_UserComment
    c_VersionComment:
     begin
      l_Sub := Text.Editor.Data.Document.Marks.SubsByID[aSub.ID];
      if (l_Sub <> nil) then
      begin
       l_Para := l_Sub.LeafPara;
       l_CT := ee_ctVersion;
       l_Hint := vcmCStr(str_nsVersionComment);
       if Text.ShowVersionComments then
        Exit
       else
        l_Sep := vcmCStr(str_nsColonSpace);

       Result := True;
       ParaProccessed(l_Para);
      end;//l_Sub <> nil
     end; // c_GarantComment
    else
     begin
      Result := True;
      if l3IsNil(l_Hint) then
      begin
       if (aSub.LayerID = Ord(ev_sbtSub)) and
          ((aSub.SubPlace in ev_spInContents) OR
           (aSub.ID = c_DocumentSubID)) then
       begin
        if (aSub.ID <> c_DocumentSubID) then
         l_Hint := l3CStr(Text.GetDocumentPartHint(Text.Document.DocumentContainer.SubList.Block[aSub.ID]))
        else
         l_Hint := vcmCStr(str_WholeDocumentSubsMenu);
       end//aSub.LayerID = ev_sbtSub
       else
        l_Hint := l3CStr(aSub.Name);
       if l3IsNil(l_Hint) then
        l_Hint := l3CStr(evGetBlockName(aSub.AsObject.Box).AsPCharLen);
       // Для закладок к подсказке добавляется еще префикс
       if aSub.LayerID = Ord(ev_sbtBookmark) then
        l_Hint := l3Cat([vcmCStr(str_nsBookmarkPrefix), l_Hint]);
      end;//l3IsNil(l_Hint)
     end;//else
   end;//case aLayer
  finally
   if not l3Same(l_Hint, Hint) then
    Application.CancelHint;
   Hint := l3Str(l_Hint);
   ShowHint := True;
  end;//try..finally
 end;//Sender As TControl
//#UC END# *4F82F1F10297_4C7F801D0304_impl*
end;//TExTextOptionsForm.SubPanelMouseOverSub

procedure TExTextOptionsForm.SubPanelClickSub(Sender: TObject;
 SubType: Integer;
 SubHandle: Integer;
 aKind: TafwClickKind);
//#UC START# *4F82F22B023D_4C7F801D0304_var*
//#UC END# *4F82F22B023D_4C7F801D0304_var*
begin
//#UC START# *4F82F22B023D_4C7F801D0304_impl*
 if (aKind = afw_ckSingle) then
  SubPanel.ShowMenu;
(* if (SubType = c_GarantComment) and
     not Text.ShowComments then
  ChangeJurorCommentsVisibility
 else
  if (SubType = c_UserComment) and
     not Text.ShowUserComments then
   ChangeUserCommentsVisibility;*)
//#UC END# *4F82F22B023D_4C7F801D0304_impl*
end;//TExTextOptionsForm.SubPanelClickSub

procedure TExTextOptionsForm.vcmEntityFormRefGetStatus(aSender: TObject;
 out theStatus: TafwStatusInfo);
//#UC START# *4F82F2FF00B9_4C7F801D0304_var*
//#UC END# *4F82F2FF00B9_4C7F801D0304_var*
begin
//#UC START# *4F82F2FF00B9_4C7F801D0304_impl*
 if (UserType in [dftAutoreferatAfterSearch, dftAutoreferat]) and
    (Document <> nil) then
 begin
  SetLength(theStatus.rStrings, Length(theStatus.rStrings) + 1);
  theStatus.rStrings[Length(theStatus.rStrings) - 1] := vcmFmt(str_AnnotationCount, [Document.GetAutoReferatDocCount]);
 end;//UserType in [dftAutoreferatAfterSearch, dftAutoreferat]
//#UC END# *4F82F2FF00B9_4C7F801D0304_impl*
end;//TExTextOptionsForm.vcmEntityFormRefGetStatus

function TExTextOptionsForm.GetContentsElement(const aBlock: IevDocumentPart): IevDocumentPart;
//#UC START# *4F82FDD7022B_4C7F801D0304_var*
var
 l_Block: IevDocumentPart;
//#UC END# *4F82FDD7022B_4C7F801D0304_var*
begin
//#UC START# *4F82FDD7022B_4C7F801D0304_impl*
 Result := nil;
 if (aBlock <> nil) then
 begin
  l_Block := aBlock;
  while (l_Block <> nil) do
  begin
   if (l_Block.SubPlace in ev_spInContents) then
   begin
    Result := l_Block;
    break;
   end//l_Block.SubPlace in ev_spInContents
   else
    l_Block := l_Block.ParentDocumentPart;
  end;//while (l_Block <> nil)
 end;//aBlock <> nil
//#UC END# *4F82FDD7022B_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetContentsElement

function TExTextOptionsForm.CurrentParaPos: TbsDocPos;
//#UC START# *4F85B70C035A_4C7F801D0304_var*
var
 l_Para: IeePara;
//#UC END# *4F85B70C035A_4C7F801D0304_var*
begin
//#UC START# *4F85B70C035A_4C7F801D0304_impl*
 l_Para := GetTopParaID;
 try
  if Assigned(l_Para) then
   Result := TbsDocPos_P(l_Para)
  else
   Result := TbsDocPos_E;
 finally
  l_Para := nil;
 end;{try..finally}
//#UC END# *4F85B70C035A_4C7F801D0304_impl*
end;//TExTextOptionsForm.CurrentParaPos

function TExTextOptionsForm.ContextEntitiesGetTarget(aControl: TComponent;
 aX: Integer;
 aY: Integer;
 out theTarget: IUnknown): Boolean;
//#UC START# *4F88454E023C_4C7F801D0304_var*
var
 l_Editor: IeeEditor;
//#UC END# *4F88454E023C_4C7F801D0304_var*
begin
//#UC START# *4F88454E023C_4C7F801D0304_impl*
 if (aControl is TeeEditor) then
 begin
  Result := True;
  if Supports(aControl, IeeEditor, l_Editor) then
   l_Editor.GetHotspotOnPoint(Point(aX, aY), IeeHotSpot(theTarget))
  else
  begin
   theTarget := nil;
   Assert(False);
  end;
 end//aControl is TeeEditor
 else
  Result := False;
//#UC END# *4F88454E023C_4C7F801D0304_impl*
end;//TExTextOptionsForm.ContextEntitiesGetTarget

function TExTextOptionsForm.SubPanelEntitiesGetTarget(aControl: TComponent;
 aX: Integer;
 aY: Integer;
 out theTarget: IUnknown): Boolean;
//#UC START# *4F884583015D_4C7F801D0304_var*
//#UC END# *4F884583015D_4C7F801D0304_var*
begin
//#UC START# *4F884583015D_4C7F801D0304_impl*
 if (aControl is TeeSubPanel) then
 begin
  Result := True;
  TeeSubPanel(aControl).CheckSubOnPoint(aX, aY, IeeSub(theTarget));
 end//aControl is TeeSubPanel
 else
  Result := False;
//#UC END# *4F884583015D_4C7F801D0304_impl*
end;//TExTextOptionsForm.SubPanelEntitiesGetTarget

procedure TExTextOptionsForm.ReloadRedaction(aChangeType: TnsChangeRedactionType;
 aRedaction: TRedactionID = 0);
//#UC START# *4AE7354E03A4_4C7F801D0304_var*
var
 l_Para   : IeePara;
 l_Worker : IbsChangeRedactionWorker;
//#UC END# *4AE7354E03A4_4C7F801D0304_var*
begin
//#UC START# *4AE7354E03A4_4C7F801D0304_impl*
 if Assigned(dsDocument) and Assigned(dsDocument.DocInfo) then
 begin
  l_Para := RedactionCurrentPara;
  with DocumentSet do
  begin
   l_Worker := TbsChangeRedationById.Make(aChangeType, aRedaction);
   if Assigned(l_Para) then
    ChangeRedaction(l_Worker, TbsDocPos_P(l_Para))
   else
    ChangeRedaction(l_Worker, TbsDocPos_E);
  end;//with DocumentSet
 end;//Assigned(dsDocument)..
 SynchronizeWithRedationsForm;
//#UC END# *4AE7354E03A4_4C7F801D0304_impl*
end;//TExTextOptionsForm.ReloadRedaction

function TExTextOptionsForm.ReloadRedaction(const aDate: AdapterDate): Boolean;
//#UC START# *4AE7358F03E2_4C7F801D0304_var*
var
 l_Para   : IeePara;
 l_Worker : IbsChangeRedactionWorker;
//#UC END# *4AE7358F03E2_4C7F801D0304_var*
begin
//#UC START# *4AE7358F03E2_4C7F801D0304_impl*
 Result := False;
 if Assigned(dsDocument) and Assigned(dsDocument.DocInfo) then
 begin
  l_Para := RedactionCurrentPara;
  l_Worker := TbsChangeRelationByDate.Make(aDate);
  with DocumentSet do
   if Assigned(l_Para) then
    Result := ChangeRedaction(l_Worker, TbsDocPos_P(l_Para))
   else
    Result := ChangeRedaction(l_Worker, TbsDocPos_E);
 end;//if Assigned(dsDocument) and Assigned(dsDocument.DocInfo) then
 if Result then
  SynchronizeWithRedationsForm;
//#UC END# *4AE7358F03E2_4C7F801D0304_impl*
end;//TExTextOptionsForm.ReloadRedaction

procedure TExTextOptionsForm.SetActualRedaction;
//#UC START# *4AE73936003E_4C7F801D0304_var*
//#UC END# *4AE73936003E_4C7F801D0304_var*
begin
//#UC START# *4AE73936003E_4C7F801D0304_impl*
 if Assigned(dsDocument) and Assigned(dsDocument.DocInfo) then
  if not TdmStdRes.IsCurEditionActual(dsDocument.DocInfo.Doc) then
   ReloadRedaction(crtActual)
  else
  if (UserType = dftDocument) and
     Visible then
   DocumentSet.OpenWarning;
//#UC END# *4AE73936003E_4C7F801D0304_impl*
end;//TExTextOptionsForm.SetActualRedaction

function TExTextOptionsForm.ExtractRangeFromContents(const aData: IUnknown;
 aUserType: Integer): InevRange;
//#UC START# *4AE9DB55008E_4C7F801D0304_var*
var
 l_Sub  : IevSub;
 l_List : InevFlatSubsList;
//#UC END# *4AE9DB55008E_4C7F801D0304_var*
begin
//#UC START# *4AE9DB55008E_4C7F801D0304_impl*
 Result := nil;
 if not CheckParamForUserType(aUserType) then
  Exit;
 if Supports(aData, IevSub, l_Sub) then
  Result := ExtractRangeFromSub(l_Sub.ID, l_Sub.LayerID)
 else
 if Supports(aData, InevFlatSubsList, l_List) then
  Result := ExtractRangeFromList(l_List)
 else
 begin
  Result := nil;
  Assert(false);
 end;//Supports(aData, InevFlatSubsList, l_List)
//#UC END# *4AE9DB55008E_4C7F801D0304_impl*
end;//TExTextOptionsForm.ExtractRangeFromContents

procedure TExTextOptionsForm.ExportBlock(const aRange: InevRange;
 ToActiveWindow: Boolean);
//#UC START# *4AE9DC630356_4C7F801D0304_var*
const
 cMap: array [Boolean] of TnsExportKind = (ekShell, ekActiveWord);
//#UC END# *4AE9DC630356_4C7F801D0304_var*
begin
//#UC START# *4AE9DC630356_4C7F801D0304_impl*
 if Assigned(aRange) then
  DocumentExport(cMap[ToActiveWindow], true, aRange);
//#UC END# *4AE9DC630356_4C7F801D0304_impl*
end;//TExTextOptionsForm.ExportBlock

procedure TExTextOptionsForm.SelectBlock(const aRange: InevRange);
//#UC START# *4AEB099C0216_4C7F801D0304_var*
//#UC END# *4AEB099C0216_4C7F801D0304_var*
begin
//#UC START# *4AEB099C0216_4C7F801D0304_impl*
 if Assigned(aRange) then
  InevSelection(Text.Selection).Select(aRange, true);
//#UC END# *4AEB099C0216_4C7F801D0304_impl*
end;//TExTextOptionsForm.SelectBlock

procedure TExTextOptionsForm.CopyBlock(const aRange: InevRange);
//#UC START# *4AEB09F0027F_4C7F801D0304_var*
//#UC END# *4AEB09F0027F_4C7F801D0304_var*
begin
//#UC START# *4AEB09F0027F_4C7F801D0304_impl*
 if Assigned(aRange) then
  Text.CopyRange(aRange);
//#UC END# *4AEB09F0027F_4C7F801D0304_impl*
end;//TExTextOptionsForm.CopyBlock

procedure TExTextOptionsForm.PrintBlock(const aRange: InevRange);
//#UC START# *4AEB0A3A028D_4C7F801D0304_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *4AEB0A3A028D_4C7F801D0304_var*
begin
//#UC START# *4AEB0A3A028D_4C7F801D0304_impl*
 if Assigned(aRange) then
 begin
  l_Preview := Text.MakePreviewRangeAsDocument(aRange, nil);
  if (l_Preview <> nil) then
   l_Preview.Print;
 end;
//#UC END# *4AEB0A3A028D_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrintBlock

procedure TExTextOptionsForm.PrintDialogBlock(const aRange: InevRange);
//#UC START# *4AEB0A7902CA_4C7F801D0304_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *4AEB0A7902CA_4C7F801D0304_var*
begin
//#UC START# *4AEB0A7902CA_4C7F801D0304_impl*
 if Assigned(aRange) and (afw.Application <> nil) AND
    (afw.Application.PrintManager <> nil) then
 begin
  l_Preview := Text.MakePreviewRangeAsDocument(aRange, nil);
  if (l_Preview <> nil) then
   afw.Application.PrintManager.PrintDialog(l_Preview);
 end;//if Assigned(aRange) and (afw.Application <> nil) AND...
//#UC END# *4AEB0A7902CA_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrintDialogBlock

procedure TExTextOptionsForm.PreviewBlock(const aRange: InevRange);
//#UC START# *4AEB0AA60373_4C7F801D0304_var*
var
 l_Preview : IafwComplexDocumentPreview;
//#UC END# *4AEB0AA60373_4C7F801D0304_var*
begin
//#UC START# *4AEB0AA60373_4C7F801D0304_impl*
 if Assigned(aRange) and (afw.Application <> nil) AND
    (afw.Application.PrintManager <> nil) then
 begin
  l_Preview := Text.MakePreviewRangeAsDocument(aRange, nil);
  if (l_Preview <> nil) then
   afw.Application.PrintManager.ShowPreview(l_Preview);
 end;
//#UC END# *4AEB0AA60373_4C7F801D0304_impl*
end;//TExTextOptionsForm.PreviewBlock

function TExTextOptionsForm.FindBookmarkInText(const aBookmark: IBookmark;
 out aSub: IeeSub): Boolean;
//#UC START# *4AEEF8180282_4C7F801D0304_var*
var
 l_BookmarkID : Cardinal;
 l_Index      : Integer;
 l_Sub        : IeeSub;
//#UC END# *4AEEF8180282_4C7F801D0304_var*
begin
//#UC START# *4AEEF8180282_4C7F801D0304_impl*
 Result := False;
 aSub := nil;
 if Document.IsMyBookmark(aBookmark) then
  with Text.Editor.Data.Document.Bookmarks do
  begin
   l_BookmarkID := aBookmark.GetParagraph;
   for l_Index := 0 to Pred(Count) do
   begin
    l_Sub := Subs[l_Index];
    try
     if (l_Sub <> nil) and
        (LongWord(l_Sub.ID) = l_BookmarkID) then
     begin
      aSub := l_Sub;
      Result := True;
      Exit;
     end;//l_Sub <> nil
    finally
     l_Sub := nil;
    end;//try..finally
   end;//for l_Index
  end;//with Text.Editor.Data.Document.Bookmarks
//#UC END# *4AEEF8180282_4C7F801D0304_impl*
end;//TExTextOptionsForm.FindBookmarkInText

procedure TExTextOptionsForm.InitHyperLink(const aHyperLink: IevHyperlink;
 const aBaseEntity: IUnknown);
//#UC START# *4AEEFBF102AF_4C7F801D0304_var*
var
 l_Bookmark: IBookmark;
 l_PID: TPId;
 l_Entity: IEntityBase;
//#UC END# *4AEEFBF102AF_4C7F801D0304_var*
begin
//#UC START# *4AEEFBF102AF_4C7F801D0304_impl*
 if (aHyperLink <> nil) and
    Supports(aBaseEntity, IBookmark, l_Bookmark) then
  try
   l_Bookmark.GetPid(l_PID);
   aHyperlink.Address := TevAddress_C(l_PID.rObjectId,
                                   Integer(l_Bookmark.GetParagraph or POSITION_TYPE_PARA_ID),
                                   CI_TOPIC);
  finally
   l_Bookmark := nil;
  end//try..finall
 else
 if Supports(aBaseEntity, IEntityBase, l_Entity) then
  aHyperlink.Address := TevAddress_C(l_Entity.GetEid, 0, CI_FolderLink);

 aHyperlink.Hint := l3PCharLen;
//#UC END# *4AEEFBF102AF_4C7F801D0304_impl*
end;//TExTextOptionsForm.InitHyperLink

function TExTextOptionsForm.EnableRedactionOps(const aParams: IvcmTestParamsPrim): Boolean;
//#UC START# *4AFAF4620059_4C7F801D0304_var*
//#UC END# *4AFAF4620059_4C7F801D0304_var*
begin
//#UC START# *4AFAF4620059_4C7F801D0304_impl*
 Result := (ViewArea <> nil) and ViewArea.CanWorkWithRedactions;
 aParams.Op.Flag[vcm_ofEnabled] := Result;
//#UC END# *4AFAF4620059_4C7F801D0304_impl*
end;//TExTextOptionsForm.EnableRedactionOps

procedure TExTextOptionsForm.OpenInWindow(aNew: Boolean = True);
//#UC START# *4B04318202FC_4C7F801D0304_var*
var
 l_Cont : IvcmContainer;
//#UC END# *4B04318202FC_4C7F801D0304_var*
begin
//#UC START# *4B04318202FC_4C7F801D0304_impl*
 if (ViewArea <> nil) then
 begin
  if aNew then
   (*l_Cont := nsOpenNewWindowParams(NativeMainForm)*)
   l_Cont := nsOpenNewWindowTabbed(NativeMainForm)
  else
   l_Cont := NativeMainForm;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
  if (l_Cont <> nil) then
  try
   TdmStdRes.OpenDocument(ViewArea.NewDocInfo(CurrentParaPos),
                          l_Cont);
  finally
   l_Cont := nil;
  end;//try..finally
 end;//ViewArea <> nil
//#UC END# *4B04318202FC_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenInWindow

procedure TExTextOptionsForm.OpenInNewWindow;
//#UC START# *4C4EB6710127_4C7F801D0304_var*
//#UC END# *4C4EB6710127_4C7F801D0304_var*
begin
//#UC START# *4C4EB6710127_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4EB6710127_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenInNewWindow

procedure TExTextOptionsForm.Show;
 {* Показывать метки }
//#UC START# *4C7F8DFF02BF_4C7F801D0304_var*
//#UC END# *4C7F8DFF02BF_4C7F801D0304_var*
begin
//#UC START# *4C7F8DFF02BF_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F8DFF02BF_4C7F801D0304_impl*
end;//TExTextOptionsForm.Show

procedure TExTextOptionsForm.RemWarnJuror;
//#UC START# *4C7FACA8026E_4C7F801D0304_var*
//#UC END# *4C7FACA8026E_4C7F801D0304_var*
begin
//#UC START# *4C7FACA8026E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FACA8026E_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnJuror

procedure TExTextOptionsForm.RemWarnTimeMachineOn;
//#UC START# *4C7FACBB005C_4C7F801D0304_var*
//#UC END# *4C7FACBB005C_4C7F801D0304_var*
begin
//#UC START# *4C7FACBB005C_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FACBB005C_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnTimeMachineOn

procedure TExTextOptionsForm.RemWarnRedaction;
//#UC START# *4C7FACCE013F_4C7F801D0304_var*
//#UC END# *4C7FACCE013F_4C7F801D0304_var*
begin
//#UC START# *4C7FACCE013F_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FACCE013F_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnRedaction

procedure TExTextOptionsForm.RemWarnOnControl;
//#UC START# *4C7FACFE01D3_4C7F801D0304_var*
//#UC END# *4C7FACFE01D3_4C7F801D0304_var*
begin
//#UC START# *4C7FACFE01D3_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FACFE01D3_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnOnControl

procedure TExTextOptionsForm.RemWarnIsAbolished;
//#UC START# *4C7FAD0F014A_4C7F801D0304_var*
//#UC END# *4C7FAD0F014A_4C7F801D0304_var*
begin
//#UC START# *4C7FAD0F014A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FAD0F014A_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnIsAbolished

procedure TExTextOptionsForm.RemWarnTimeMachineException;
//#UC START# *4C7FAD1D038F_4C7F801D0304_var*
//#UC END# *4C7FAD1D038F_4C7F801D0304_var*
begin
//#UC START# *4C7FAD1D038F_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FAD1D038F_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnTimeMachineException

procedure TExTextOptionsForm.RemWarnPreActive;
//#UC START# *4C7FAD310195_4C7F801D0304_var*
//#UC END# *4C7FAD310195_4C7F801D0304_var*
begin
//#UC START# *4C7FAD310195_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FAD310195_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnPreActive

procedure TExTextOptionsForm.RemWarnTimeMachineWarning;
//#UC START# *4C7FAD470142_4C7F801D0304_var*
//#UC END# *4C7FAD470142_4C7F801D0304_var*
begin
//#UC START# *4C7FAD470142_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FAD470142_4C7F801D0304_impl*
end;//TExTextOptionsForm.RemWarnTimeMachineWarning

procedure TExTextOptionsForm.ViewInactualDocument;
//#UC START# *4C7FAD5900EE_4C7F801D0304_var*
//#UC END# *4C7FAD5900EE_4C7F801D0304_var*
begin
//#UC START# *4C7FAD5900EE_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7FAD5900EE_4C7F801D0304_impl*
end;//TExTextOptionsForm.ViewInactualDocument

procedure TExTextOptionsForm.CreateTOC(const aTOC: IdeSimpleTree);
//#UC START# *4EBAA060033D_4C7F801D0304_var*
var
 l_TreeResetted: Boolean;
 l_Tree: InsContentsTree;
 l_FilterableTree: Il3FilterableTree;
 l_TOC: Il3SimpleTree;
 l_TOCData : IdeSimpleTree;
 l_Dummy: Integer;
//#UC END# *4EBAA060033D_4C7F801D0304_var*
begin
//#UC START# *4EBAA060033D_4C7F801D0304_impl*
 // А извращизм с f_RecallCreateTOCTree из-за того, что CreateToc приездает сильно раньше, чем по истории
 // воссановять _DataSource.. Как результат содержание не открывается. K-118392311
 if NeedShowTOC then
 begin
  l_TreeResetted := Supports(aTOC.Contents, InsContentsTree, l_Tree) and
                    (l_Tree.RootResetted or Assigned(f_RecallCreateTOCTree));
  l_TOC := FiltrateTOCTree(aTOC.Contents,
                           (f_RecallCreateTOCTree = nil)
                           { OR (f_RecallCreateTOCTree.Tree = nil)});
  f_RecallCreateTOCTree := nil;
  if not l_TreeResetted then
   l_TreeResetted := Op_ContentsValidator_IsDocumentAdornmentsChanged.Call(Aggregate, aTOC.Adornments);
  l_TOCData := TdeSimpleTree.Make(l_TOC, aTOC.Adornments);
  if (DocumentWithContents <> nil) then
  begin
   if (not Dispatcher.History.InBF or l_TreeResetted) then
    DocumentWithContents.OpenContents(l_TOCData, cBooleanToContentsOpenMode[l_TreeResetted], Text.TextSource.DocumentContainer);
  end//DocumentWithContents <> nil
  else
  if l_TreeResetted then
   f_RecallCreateTOCTree := l_TOCData;
 end;//NeedShowTOC
//#UC END# *4EBAA060033D_4C7F801D0304_impl*
end;//TExTextOptionsForm.CreateTOC

procedure TExTextOptionsForm.ChangesButton;
 {* Изменения в документе }
//#UC START# *4F88460903B1_4C7F801D0304_var*
//#UC END# *4F88460903B1_4C7F801D0304_var*
begin
//#UC START# *4F88460903B1_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F88460903B1_4C7F801D0304_impl*
end;//TExTextOptionsForm.ChangesButton

procedure TExTextOptionsForm.CopySubNumber;
 {* Копировать позицию }
//#UC START# *4F884EF30187_4C7F801D0304_var*
//#UC END# *4F884EF30187_4C7F801D0304_var*
begin
//#UC START# *4F884EF30187_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F884EF30187_4C7F801D0304_impl*
end;//TExTextOptionsForm.CopySubNumber

procedure TExTextOptionsForm.ShowByShortCut;
//#UC START# *528373EC0026_4C7F801D0304_var*
//#UC END# *528373EC0026_4C7F801D0304_var*
begin
//#UC START# *528373EC0026_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *528373EC0026_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowByShortCut

procedure TExTextOptionsForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C7F801D0304_var*
//#UC END# *479731C50290_4C7F801D0304_var*
begin
//#UC START# *479731C50290_4C7F801D0304_impl*
 // Пытаемся закрывать вкладку новостной ленты (cq24583)
 if (UserType = dftAutoReferat) and Assigned(Aggregate) then
  op_Form_RequestClose.Call(Aggregate);
 inherited;
//#UC END# *479731C50290_4C7F801D0304_impl*
end;//TExTextOptionsForm.Cleanup

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.FindContext;
 {* Поиск }
//#UC START# *49512B5D0009_4C7F801D0304_var*
//#UC END# *49512B5D0009_4C7F801D0304_var*
begin
//#UC START# *49512B5D0009_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49512B5D0009_4C7F801D0304_impl*
end;//TExTextOptionsForm.FindContext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.FindNext;
 {* Найти далее }
//#UC START# *495130C40123_4C7F801D0304_var*
//#UC END# *495130C40123_4C7F801D0304_var*
begin
//#UC START# *495130C40123_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495130C40123_4C7F801D0304_impl*
end;//TExTextOptionsForm.FindNext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C7F801D0304_var*
//#UC END# *49521D8E0295_4C7F801D0304_var*
begin
//#UC START# *49521D8E0295_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C7F801D0304_impl*
end;//TExTextOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C7F801D0304_var*
//#UC END# *495220DE0298_4C7F801D0304_var*
begin
//#UC START# *495220DE0298_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C7F801D0304_var*
//#UC END# *495220F2033A_4C7F801D0304_var*
begin
//#UC START# *495220F2033A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4C7F801D0304_var*
//#UC END# *495235F401C0_4C7F801D0304_var*
begin
//#UC START# *495235F401C0_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4C7F801D0304_impl*
end;//TExTextOptionsForm.Save
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.ToMSWord;
 {* Экспорт в Word }
//#UC START# *495238EB0160_4C7F801D0304_var*
//#UC END# *495238EB0160_4C7F801D0304_var*
begin
//#UC START# *495238EB0160_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495238EB0160_4C7F801D0304_impl*
end;//TExTextOptionsForm.ToMSWord

procedure TExTextOptionsForm.SendMailAsAttachment;
 {* Послать по e-mail }
//#UC START# *495253870002_4C7F801D0304_var*
//#UC END# *495253870002_4C7F801D0304_var*
begin
//#UC START# *495253870002_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *495253870002_4C7F801D0304_impl*
end;//TExTextOptionsForm.SendMailAsAttachment

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4C7F801D0304_var*
var
 l_FromHistory : Boolean;
//#UC END# *497469C90140_4C7F801D0304_var*
begin
//#UC START# *497469C90140_4C7F801D0304_impl*
 inherited;
 if (Dispatcher = nil) OR (Dispatcher.History = nil) then
  l_FromHistory := false
 else
  l_FromHistory := Dispatcher.History.InBF;
 // Запомним данные смены источинка данных, чтобы отложенно при первой отрисовке
 // ими воспользоваться:
 FormDataChangedInfo.Init(l_FromHistory);
 // Если документы разные, то обнуляем контейнер, чтобы при первой отрисовке
 // получить данные:
 if not l_FromHistory then
 begin
  if (aNew <> nil) and not aNew.IsSame(anOld) then
   Text.TextSource.DocumentContainer := nil
  else
  begin
   // Если документы одинаковые - то позиционируемся:
   if (ViewArea <> nil) then
    with ViewArea.DocInfo.Pos do
     GotoPoint(rPos, rRefType);
   InvalidateDataSources;
  end;//(aNew <> nil) and not aNew.IsSame(aOld)
 end//if not l_FromHistory then
 else
 begin
  // Если документ из истории не был получен значит до сих пор он никому был не
  // нужен, подождем момента когда он понадобится:
  if Text.HasDocument then
   InvalidateDataSources;
  if UserType in [dftAutoreferat, dftAutoreferatAfterSearch] then
   Dispatcher.UpdateStatus;
 end;
//#UC END# *497469C90140_4C7F801D0304_impl*
end;//TExTextOptionsForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C7F801D0304_var*
//#UC END# *49803F5503AA_4C7F801D0304_var*
begin
//#UC START# *49803F5503AA_4C7F801D0304_impl*
 inherited;
 Self.OnGetStatus := VcmEntityFormRefGetStatus;
 f_ControlMap := nsStringMapManager.Map[smap_pi_DropChangeStatus];
//#UC END# *49803F5503AA_4C7F801D0304_impl*
end;//TExTextOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TExTextOptionsForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_4C7F801D0304_var*
var
 l_Handle : THandle;
//#UC END# *4980407F0076_4C7F801D0304_var*
begin
//#UC START# *4980407F0076_4C7F801D0304_impl*
 if (aCaller = nil)
  then l_Handle := Handle
  else l_Handle := aCaller.Handle;
 Result := Text.TextSource.CloseQuery(l_Handle) AND
  inherited CallCloseQuery(aCaller);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=515838818
  // потому что в PrimText - сохранение в Журнал работы
//#UC END# *4980407F0076_4C7F801D0304_impl*
end;//TExTextOptionsForm.CallCloseQuery
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.NextDocumentInList;
 {* Следующий документ в списке }
//#UC START# *49880FD20039_4C7F801D0304_var*
//#UC END# *49880FD20039_4C7F801D0304_var*
begin
//#UC START# *49880FD20039_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FD20039_4C7F801D0304_impl*
end;//TExTextOptionsForm.NextDocumentInList

procedure TExTextOptionsForm.ReturnToList;
 {* Вернуться в списк }
//#UC START# *49880FE90145_4C7F801D0304_var*
//#UC END# *49880FE90145_4C7F801D0304_var*
begin
//#UC START# *49880FE90145_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FE90145_4C7F801D0304_impl*
end;//TExTextOptionsForm.ReturnToList

procedure TExTextOptionsForm.SaveToFolder;
 {* Сохранить в папки }
//#UC START# *49885D540232_4C7F801D0304_var*
//#UC END# *49885D540232_4C7F801D0304_var*
begin
//#UC START# *49885D540232_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D540232_4C7F801D0304_impl*
end;//TExTextOptionsForm.SaveToFolder

procedure TExTextOptionsForm.LoadFromFolder;
 {* Загрузить из папок }
//#UC START# *49885D59018D_4C7F801D0304_var*
//#UC END# *49885D59018D_4C7F801D0304_var*
begin
//#UC START# *49885D59018D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49885D59018D_4C7F801D0304_impl*
end;//TExTextOptionsForm.LoadFromFolder

procedure TExTextOptionsForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *498891640253_4C7F801D0304_var*
//#UC END# *498891640253_4C7F801D0304_var*
begin
//#UC START# *498891640253_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *498891640253_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetAttributesFrmAct

procedure TExTextOptionsForm.GetRelatedDocFrmAct;
 {* Справка к документу }
//#UC START# *498993C801DC_4C7F801D0304_var*
//#UC END# *498993C801DC_4C7F801D0304_var*
begin
//#UC START# *498993C801DC_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetRelatedDocFrmAct

procedure TExTextOptionsForm.AddBookmark;
 {* Добавить закладку }
//#UC START# *4989D06D014E_4C7F801D0304_var*
//#UC END# *4989D06D014E_4C7F801D0304_var*
begin
//#UC START# *4989D06D014E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddBookmark

procedure TExTextOptionsForm.GetCorrespondentList;
 {* Ссылки на документ }
//#UC START# *4989D65C0275_4C7F801D0304_var*
//#UC END# *4989D65C0275_4C7F801D0304_var*
begin
//#UC START# *4989D65C0275_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D65C0275_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetCorrespondentList

procedure TExTextOptionsForm.GetRespondentList;
 {* Ссылки из документа }
//#UC START# *4989D8430128_4C7F801D0304_var*
//#UC END# *4989D8430128_4C7F801D0304_var*
begin
//#UC START# *4989D8430128_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D8430128_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetRespondentList

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.Undo;
 {* Отмена }
//#UC START# *49EDFCA2006D_4C7F801D0304_var*
//#UC END# *49EDFCA2006D_4C7F801D0304_var*
begin
//#UC START# *49EDFCA2006D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C7F801D0304_impl*
end;//TExTextOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.Redo;
 {* Возврат }
//#UC START# *49EDFCB100BC_4C7F801D0304_var*
//#UC END# *49EDFCB100BC_4C7F801D0304_var*
begin
//#UC START# *49EDFCB100BC_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C7F801D0304_impl*
end;//TExTextOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.FindPrev;
//#UC START# *49FEDE4703B8_4C7F801D0304_var*
//#UC END# *49FEDE4703B8_4C7F801D0304_var*
begin
//#UC START# *49FEDE4703B8_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEDE4703B8_4C7F801D0304_impl*
end;//TExTextOptionsForm.FindPrev
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.ShowJurorComments;
 {* Показать юридические комментарии }
//#UC START# *4A7C0AFD02BA_4C7F801D0304_var*
//#UC END# *4A7C0AFD02BA_4C7F801D0304_var*
begin
//#UC START# *4A7C0AFD02BA_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C0AFD02BA_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowJurorComments

procedure TExTextOptionsForm.ShowSpecial;
 {* Показывать спецсимволы }
//#UC START# *4A7C18B20241_4C7F801D0304_var*
//#UC END# *4A7C18B20241_4C7F801D0304_var*
begin
//#UC START# *4A7C18B20241_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C18B20241_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowSpecial

procedure TExTextOptionsForm.ShowInfo;
 {* Показывать блоки }
//#UC START# *4A7C1F420169_4C7F801D0304_var*
//#UC END# *4A7C1F420169_4C7F801D0304_var*
begin
//#UC START# *4A7C1F420169_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A7C1F420169_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowInfo

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4C7F801D0304_var*
//#UC END# *4A8E8F2E0195_4C7F801D0304_var*
begin
//#UC START# *4A8E8F2E0195_4C7F801D0304_impl*
 ActiveControl := Text;
 inherited;
 RemindersLine.Images := resWarnImages.nsWarnImages.WarnImages;
 RemindersLine.BeginUpdate;
 try
  with WarnPreActive do
  begin
   UserType := BaloonWarningUserTypes_WarnPreActive_UserType.WarnPreActive;
   ImageIndex := 5;
   Visible := False;
   SortIndex := 6;
  end;
  with WarnRedaction do
  begin
   UserType := BaloonWarningUserTypes_WarnRedaction_UserType.WarnRedaction;
   ImageIndex := 3;
   Visible := False;
   Hint := str_WarnRedactionHint.AsCStr;
   SortIndex := 2;
  end;
  with WarnIsAbolished do
  begin
   UserType := BaloonWarningUserTypes_WarnIsAbolished_UserType.WarnIsAbolished;
   ImageIndex := 0;
   Visible := False;
   SortIndex := 4;
  end;
  with WarnJuror do
  begin
   UserType := BaloonWarningUserTypes_WarnJuror_UserType.WarnJuror;
   ImageIndex := 1;
   Visible := False;
   SortIndex := 0;
  end;
  with WarnTimeMachineException do
  begin
   UserType := BaloonWarningUserTypes_WarnTimeMachineException_UserType.WarnTimeMachineException;
   ImageIndex := 8;
   Visible := False;
   SortIndex := 5;
  end;
  with WarnOnControl do
  begin
   UserType := BaloonWarningUserTypes_WarnOnControl_UserType.WarnOnControl;
   ImageIndex := 2;
   Visible := False;
   SortIndex := 3;
  end;
  with WarnTimeMachineOn do
  begin
   UserType := BaloonWarningUserTypes_WarnTimeMachineOn_UserType.WarnTimeMachineOn;
   ImageIndex := 7;
   Hint := str_WarnTimeMachineOnHint.AsCStr;
   Visible := False;
   SortIndex := 1;
  end;
  with WarnTimeMachineWarning do
  begin
   UserType := BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.WarnTimeMachineWarning;
   ImageIndex := 13;
   Visible := False;
   SortIndex := 7;
  end;
  with WarnInactualDocument do
  begin
   UserType := BaloonWarningUserTypes_WarnInactualDocument_UserType.WarnInactualDocument;
   ImageIndex := 16;
   Visible := False;
   SortIndex := 8;
  end;
  RemindersLine.Sorted := True;
 finally
  RemindersLine.EndUpdate;
 end;
 with Text do
 begin
  Left := 45;
  Top := 0;
  Width := 600;
  Height := 336;
  Align := alClient;
  TabOrder := 0;
  TextSource := Self.TextSource;
  VSubPanel := Self.SubPanel;
  OnBlockChange := TextBlockChange;
  OnBlockScroll := TextBlockScroll;
  OnMouseAction := TextMouseAction;
  OnCanSplitPara := TextCanSplitPara;
  OnUserCommentsHidden := TextUserCommentsHidden;
  OnAfterFirstPaint := TextAfterFirstPaint;
  OnCommentsVisibleChanged := TextCommentsVisibleChanged;
  OnShowDocumentPartsChanged := TextShowDocumentPartsChanged;
  OnDrawSpecialChange := TextDrawSpecialChange;
 end;//with Text
 with SubPanel do
 begin
  Left := 0;
  Top := 0;
  Width := 5;
  Height := 336;
  Align := alLeft;
  TabOrder := 1;
  OnMouseOverSub := SubPanelMouseOverSub;
  OnClickSub := SubPanelClickSub;
 end;//with SubPanel
 {$If not defined(Admin) AND not defined(Monitorings)}
 if (DefDataAdapter <> nil) then
  Text.DisableDragAndDropSupport := DefDataAdapter.IsTrialMode;
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A8E8F2E0195_4C7F801D0304_impl*
end;//TExTextOptionsForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.FindInDict;
 {* Найти в Толковом словаре }
//#UC START# *4A9D3FC50134_4C7F801D0304_var*
//#UC END# *4A9D3FC50134_4C7F801D0304_var*
begin
//#UC START# *4A9D3FC50134_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A9D3FC50134_4C7F801D0304_impl*
end;//TExTextOptionsForm.FindInDict

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.EntitiesInited;
 {* Вызывается после того как все операции зарегистрированы }
//#UC START# *4AE1948900DE_4C7F801D0304_var*
//#UC END# *4AE1948900DE_4C7F801D0304_var*
begin
//#UC START# *4AE1948900DE_4C7F801D0304_impl*
 inherited;
 with WarnPreActive do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnPreActive;
 end;
 with WarnRedaction do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnRedaction;
 end;
 with WarnIsAbolished do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnIsAbolished;
 end;
 with WarnJuror do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnJuror;
 end;
 with WarnTimeMachineException do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnTimeMachineException;
 end;
 with WarnOnControl do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnOnControl;
 end;
 with WarnTimeMachineOn do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnTimeMachineOn;
 end;
 with WarnTimeMachineWarning do
 begin
  EntityName := en_Reminder;
  OperationName := op_RemWarnTimeMachineWarning;
 end;
 with WarnInactualDocument do
 begin
  EntityName := en_Reminder;
  OperationName := op_ViewInactualDocument;
 end;

 SetTargetGetter(en_SubsPanel, SubPanelEntitiesGetTarget);
 SetTargetGetter(en_DocumentBlockHeader, SubPanelEntitiesGetTarget);
 SetTargetGetter(en_DocumentBlock, SubPanelEntitiesGetTarget);
 SetTargetGetter(en_DocumentBlockBookmarks, SubPanelEntitiesGetTarget);
 SetTargetGetter(en_BookmarkIcon, SubPanelEntitiesGetTarget);
 SetTargetGetter(en_UserCommentIcon, SubPanelEntitiesGetTarget);

 MakeEntitySupportedByControl(en_SubsPanel, SubPanel);
 MakeEntitySupportedByControl(en_DocumentBlockHeader, SubPanel);
 MakeEntitySupportedByControl(en_DocumentBlock, SubPanel);
 MakeEntitySupportedByControl(en_DocumentBlockBookmarks, SubPanel);
 MakeEntitySupportedByControl(en_BookmarkIcon, SubPanel);
 MakeEntitySupportedByControl(en_UserCommentIcon, SubPanel);

 SetTargetGetter(en_Text, ContextEntitiesGetTarget);
 SetTargetGetter(en_HyperLink, ContextEntitiesGetTarget);
 SetTargetGetter(en_Selection, ContextEntitiesGetTarget);
 SetTargetGetter(en_UserComment, ContextEntitiesGetTarget);
 SetTargetGetter(en_ExternalObject, ContextEntitiesGetTarget);

 MakeEntitySupportedByControl(en_Text, Text);
 MakeEntitySupportedByControl(en_HyperLink, Text);
 MakeEntitySupportedByControl(en_Selection, Text);
 MakeEntitySupportedByControl(en_UserComment, Text);
 MakeEntitySupportedByControl(en_ExternalObject, Text);

 f_RemindersLine.Visible := True;
//#UC END# *4AE1948900DE_4C7F801D0304_impl*
end;//TExTextOptionsForm.EntitiesInited
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.GetCorrespondentListExFrmAct;
 {* Ссылки на документ (вид информации) }
//#UC START# *4AF329F6002A_4C7F801D0304_var*
//#UC END# *4AF329F6002A_4C7F801D0304_var*
begin
//#UC START# *4AF329F6002A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329F6002A_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetCorrespondentListExFrmAct

procedure TExTextOptionsForm.GetRespondentListExFrmAct;
 {* Ссылки из документа (вид информации) }
//#UC START# *4AF329FD014D_4C7F801D0304_var*
//#UC END# *4AF329FD014D_4C7F801D0304_var*
begin
//#UC START# *4AF329FD014D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329FD014D_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetRespondentListExFrmAct

procedure TExTextOptionsForm.ActualRedaction;
//#UC START# *4AFAF4900270_4C7F801D0304_var*
//#UC END# *4AFAF4900270_4C7F801D0304_var*
begin
//#UC START# *4AFAF4900270_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AFAF4900270_4C7F801D0304_impl*
end;//TExTextOptionsForm.ActualRedaction

procedure TExTextOptionsForm.OpenRedactionListFrmAct;
 {* Список редакций }
//#UC START# *4B262F9701DE_4C7F801D0304_var*
//#UC END# *4B262F9701DE_4C7F801D0304_var*
begin
//#UC START# *4B262F9701DE_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B262F9701DE_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenRedactionListFrmAct

{$If NOT Defined(NoVCM)}
function TExTextOptionsForm.SaveOwnFormState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
//#UC START# *4B4F49900003_4C7F801D0304_var*
var
 l_OldCanRefresh: Boolean;
//#UC END# *4B4F49900003_4C7F801D0304_var*
begin
//#UC START# *4B4F49900003_4C7F801D0304_impl*
 Result := inherited SaveOwnFormState(theState, aStateType, aForClone);
 if (aStateType = vcm_stContent) then
 begin
  if UserType in [dftDocument, dftDictEntry, dftMedDictEntry, dftDrug] then
  begin
    // ничего не делаем 
  end
  else
  if (not aForClone) and
     (UserType = dftConsultation) and Assigned(ViewArea)
     and (Consultation <> nil) and Consultation.NeedGiveMark
     and (not f_HyperlinkCallStatus)
     and Ask(qr_CloseUnmarkedConsultation) then
  begin
   l_OldCanRefresh := Consultation.FormSet.CanRefresh;
   Consultation.FormSet.PushFromHistory;
   try
    Consultation.GiveMark;
   finally
    with Consultation.FormSet do
     if l_OldCanRefresh then
      PushFromHistory
     else
      PopToHistory;
   end;//try..finally
  end;//UserType = dftConsultation) and Assigned(ViewArea)..
  f_HyperlinkCallStatus := false; // сбрасываем, чтобы не сохранять на следующий раз
 end;//aStateType = vcm_stContent
//#UC END# *4B4F49900003_4C7F801D0304_impl*
end;//TExTextOptionsForm.SaveOwnFormState
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.GetCorrespondentList;
//#UC START# *4C2AEDB3003B_4C7F801D0304_var*
//#UC END# *4C2AEDB3003B_4C7F801D0304_var*
begin
//#UC START# *4C2AEDB3003B_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDB3003B_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetCorrespondentList

procedure TExTextOptionsForm.GetRespondentList;
//#UC START# *4C2AEDC503CC_4C7F801D0304_var*
//#UC END# *4C2AEDC503CC_4C7F801D0304_var*
begin
//#UC START# *4C2AEDC503CC_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2AEDC503CC_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetRespondentList

procedure TExTextOptionsForm.GetAnnotationDocFrmAct;
//#UC START# *4C3AA77E00A3_4C7F801D0304_var*
//#UC END# *4C3AA77E00A3_4C7F801D0304_var*
begin
//#UC START# *4C3AA77E00A3_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA77E00A3_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetAnnotationDocFrmAct

procedure TExTextOptionsForm.SimilarDocuments;
//#UC START# *4C3AA78E024D_4C7F801D0304_var*
//#UC END# *4C3AA78E024D_4C7F801D0304_var*
begin
//#UC START# *4C3AA78E024D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AA78E024D_4C7F801D0304_impl*
end;//TExTextOptionsForm.SimilarDocuments

procedure TExTextOptionsForm.GetTypedCorrespondentList;
//#UC START# *4C3ADFA5018F_4C7F801D0304_var*
//#UC END# *4C3ADFA5018F_4C7F801D0304_var*
begin
//#UC START# *4C3ADFA5018F_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ADFA5018F_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetTypedCorrespondentList

procedure TExTextOptionsForm.PrevRedaction;
//#UC START# *4C3AE0950253_4C7F801D0304_var*
//#UC END# *4C3AE0950253_4C7F801D0304_var*
begin
//#UC START# *4C3AE0950253_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0950253_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrevRedaction

procedure TExTextOptionsForm.NextRedaction;
//#UC START# *4C3AE0CD0079_4C7F801D0304_var*
//#UC END# *4C3AE0CD0079_4C7F801D0304_var*
begin
//#UC START# *4C3AE0CD0079_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AE0CD0079_4C7F801D0304_impl*
end;//TExTextOptionsForm.NextRedaction

procedure TExTextOptionsForm.AddToControl;
//#UC START# *4C3AFAD90234_4C7F801D0304_var*
//#UC END# *4C3AFAD90234_4C7F801D0304_var*
begin
//#UC START# *4C3AFAD90234_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFAD90234_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddToControl

procedure TExTextOptionsForm.ShowCorrespondentListToPart;
//#UC START# *4C3AFB450234_4C7F801D0304_var*
//#UC END# *4C3AFB450234_4C7F801D0304_var*
begin
//#UC START# *4C3AFB450234_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFB450234_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowCorrespondentListToPart

procedure TExTextOptionsForm.ShowRespondentListToPart;
//#UC START# *4C3AFB51020D_4C7F801D0304_var*
//#UC END# *4C3AFB51020D_4C7F801D0304_var*
begin
//#UC START# *4C3AFB51020D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFB51020D_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowRespondentListToPart

procedure TExTextOptionsForm.ClearStatusSettings;
 {* Способ сброса статуса "изменен" }
//#UC START# *4C3AFBA702E4_4C7F801D0304_var*
//#UC END# *4C3AFBA702E4_4C7F801D0304_var*
begin
//#UC START# *4C3AFBA702E4_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3AFBA702E4_4C7F801D0304_impl*
end;//TExTextOptionsForm.ClearStatusSettings

procedure TExTextOptionsForm.AddBookmark;
//#UC START# *4C3B17DC02C4_4C7F801D0304_var*
//#UC END# *4C3B17DC02C4_4C7F801D0304_var*
begin
//#UC START# *4C3B17DC02C4_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17DC02C4_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddBookmark

procedure TExTextOptionsForm.ToMSWord;
//#UC START# *4C3B17ED0192_4C7F801D0304_var*
//#UC END# *4C3B17ED0192_4C7F801D0304_var*
begin
//#UC START# *4C3B17ED0192_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17ED0192_4C7F801D0304_impl*
end;//TExTextOptionsForm.ToMSWord

procedure TExTextOptionsForm.Print;
//#UC START# *4C3B17FF03D2_4C7F801D0304_var*
//#UC END# *4C3B17FF03D2_4C7F801D0304_var*
begin
//#UC START# *4C3B17FF03D2_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B17FF03D2_4C7F801D0304_impl*
end;//TExTextOptionsForm.Print

procedure TExTextOptionsForm.PrintDialog;
//#UC START# *4C3B180E038F_4C7F801D0304_var*
//#UC END# *4C3B180E038F_4C7F801D0304_var*
begin
//#UC START# *4C3B180E038F_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B180E038F_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrintDialog

procedure TExTextOptionsForm.AddBookmark;
 {* Установить закладку на фрагмент }
//#UC START# *4C3B1AEA0127_4C7F801D0304_var*
//#UC END# *4C3B1AEA0127_4C7F801D0304_var*
begin
//#UC START# *4C3B1AEA0127_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B1AEA0127_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddBookmark

procedure TExTextOptionsForm.OpenContentsFrmAct;
//#UC START# *4C3B3754034D_4C7F801D0304_var*
//#UC END# *4C3B3754034D_4C7F801D0304_var*
begin
//#UC START# *4C3B3754034D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B3754034D_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenContentsFrmAct

procedure TExTextOptionsForm.ShowDocumentPicture;
//#UC START# *4C3B3792000E_4C7F801D0304_var*
//#UC END# *4C3B3792000E_4C7F801D0304_var*
begin
//#UC START# *4C3B3792000E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B3792000E_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowDocumentPicture

procedure TExTextOptionsForm.OpenActualRedaction;
//#UC START# *4C3B4A7D029B_4C7F801D0304_var*
//#UC END# *4C3B4A7D029B_4C7F801D0304_var*
begin
//#UC START# *4C3B4A7D029B_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B4A7D029B_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenActualRedaction

procedure TExTextOptionsForm.ShowChanges;
 {* Показать изменения }
//#UC START# *4C3B5337022E_4C7F801D0304_var*
//#UC END# *4C3B5337022E_4C7F801D0304_var*
begin
//#UC START# *4C3B5337022E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B5337022E_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowChanges

procedure TExTextOptionsForm.ClearStatus;
 {* Сбросить статус "изменен" }
//#UC START# *4C3B535F0064_4C7F801D0304_var*
//#UC END# *4C3B535F0064_4C7F801D0304_var*
begin
//#UC START# *4C3B535F0064_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3B535F0064_4C7F801D0304_impl*
end;//TExTextOptionsForm.ClearStatus

procedure TExTextOptionsForm.AddUserComment;
//#UC START# *4C3C75240091_4C7F801D0304_var*
//#UC END# *4C3C75240091_4C7F801D0304_var*
begin
//#UC START# *4C3C75240091_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C75240091_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddUserComment

procedure TExTextOptionsForm.GetGraphicImage;
//#UC START# *4C3C77CC012A_4C7F801D0304_var*
//#UC END# *4C3C77CC012A_4C7F801D0304_var*
begin
//#UC START# *4C3C77CC012A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3C77CC012A_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetGraphicImage

procedure TExTextOptionsForm.DocumentSynchroOpenWindow;
//#UC START# *4C3EA65F0233_4C7F801D0304_var*
//#UC END# *4C3EA65F0233_4C7F801D0304_var*
begin
//#UC START# *4C3EA65F0233_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA65F0233_4C7F801D0304_impl*
end;//TExTextOptionsForm.DocumentSynchroOpenWindow

procedure TExTextOptionsForm.DocumentSynchroOpenNewWindow;
//#UC START# *4C3EA671007A_4C7F801D0304_var*
//#UC END# *4C3EA671007A_4C7F801D0304_var*
begin
//#UC START# *4C3EA671007A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA671007A_4C7F801D0304_impl*
end;//TExTextOptionsForm.DocumentSynchroOpenNewWindow

procedure TExTextOptionsForm.DictListOpenFrmAct;
//#UC START# *4C3EA90300E1_4C7F801D0304_var*
//#UC END# *4C3EA90300E1_4C7F801D0304_var*
begin
//#UC START# *4C3EA90300E1_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EA90300E1_4C7F801D0304_impl*
end;//TExTextOptionsForm.DictListOpenFrmAct

procedure TExTextOptionsForm.GotoBookmark;
//#UC START# *4C3EBF860139_4C7F801D0304_var*
//#UC END# *4C3EBF860139_4C7F801D0304_var*
begin
//#UC START# *4C3EBF860139_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EBF860139_4C7F801D0304_impl*
end;//TExTextOptionsForm.GotoBookmark

procedure TExTextOptionsForm.LiteratureListForDictionary;
//#UC START# *4C3ED13D03A5_4C7F801D0304_var*
//#UC END# *4C3ED13D03A5_4C7F801D0304_var*
begin
//#UC START# *4C3ED13D03A5_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED13D03A5_4C7F801D0304_impl*
end;//TExTextOptionsForm.LiteratureListForDictionary

procedure TExTextOptionsForm.AddBookmark;
//#UC START# *4C3ED5D502AE_4C7F801D0304_var*
//#UC END# *4C3ED5D502AE_4C7F801D0304_var*
begin
//#UC START# *4C3ED5D502AE_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED5D502AE_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddBookmark

procedure TExTextOptionsForm.OpenNewWindow;
//#UC START# *4C3ED7190010_4C7F801D0304_var*
//#UC END# *4C3ED7190010_4C7F801D0304_var*
begin
//#UC START# *4C3ED7190010_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3ED7190010_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenNewWindow

procedure TExTextOptionsForm.OpenProducedDrugList;
//#UC START# *4C3EDBA7030C_4C7F801D0304_var*
//#UC END# *4C3EDBA7030C_4C7F801D0304_var*
begin
//#UC START# *4C3EDBA7030C_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EDBA7030C_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenProducedDrugList

procedure TExTextOptionsForm.OpenSimilarDrugList;
//#UC START# *4C3EDBB80283_4C7F801D0304_var*
//#UC END# *4C3EDBB80283_4C7F801D0304_var*
begin
//#UC START# *4C3EDBB80283_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C3EDBB80283_4C7F801D0304_impl*
end;//TExTextOptionsForm.OpenSimilarDrugList

procedure TExTextOptionsForm.ShowJurorComments;
 {* Показать/скрыть комментарии ГАРАНТа }
//#UC START# *4C7BAA4800A7_4C7F801D0304_var*
//#UC END# *4C7BAA4800A7_4C7F801D0304_var*
begin
//#UC START# *4C7BAA4800A7_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAA4800A7_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowJurorComments

procedure TExTextOptionsForm.ShowUserComments;
 {* Показать/скрыть мои комментарии }
//#UC START# *4C7BAA9102F7_4C7F801D0304_var*
//#UC END# *4C7BAA9102F7_4C7F801D0304_var*
begin
//#UC START# *4C7BAA9102F7_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAA9102F7_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowUserComments

procedure TExTextOptionsForm.ShowTechComments;
 {* Показывать технические комментарии }
//#UC START# *4C7BAADA039E_4C7F801D0304_var*
//#UC END# *4C7BAADA039E_4C7F801D0304_var*
begin
//#UC START# *4C7BAADA039E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAADA039E_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowTechComments

procedure TExTextOptionsForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *4C7BABCE03C0_4C7F801D0304_var*
//#UC END# *4C7BABCE03C0_4C7F801D0304_var*
begin
//#UC START# *4C7BABCE03C0_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BABCE03C0_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddToControl

procedure TExTextOptionsForm.UserCR1;
 {* Пользовательские ссылки на документ (ссылки из документа) 1 }
//#UC START# *4C7BAC1902F5_4C7F801D0304_var*
//#UC END# *4C7BAC1902F5_4C7F801D0304_var*
begin
//#UC START# *4C7BAC1902F5_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC1902F5_4C7F801D0304_impl*
end;//TExTextOptionsForm.UserCR1

procedure TExTextOptionsForm.UserCR2;
 {* Пользовательские ссылки на документ (ссылки из документа) 2 }
//#UC START# *4C7BAC5101CA_4C7F801D0304_var*
//#UC END# *4C7BAC5101CA_4C7F801D0304_var*
begin
//#UC START# *4C7BAC5101CA_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC5101CA_4C7F801D0304_impl*
end;//TExTextOptionsForm.UserCR2

procedure TExTextOptionsForm.ShowVersionComments;
 {* Включить/выключить информацию об изменениях документа }
//#UC START# *4C7BAC9C0105_4C7F801D0304_var*
//#UC END# *4C7BAC9C0105_4C7F801D0304_var*
begin
//#UC START# *4C7BAC9C0105_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC9C0105_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowVersionComments

procedure TExTextOptionsForm.CompareEditions;
 {* Сравнение редакций }
//#UC START# *4C7BAEB4010E_4C7F801D0304_var*
//#UC END# *4C7BAEB4010E_4C7F801D0304_var*
begin
//#UC START# *4C7BAEB4010E_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAEB4010E_4C7F801D0304_impl*
end;//TExTextOptionsForm.CompareEditions

procedure TExTextOptionsForm.TimeMachineOnOffNew;
 {* Включить Машину времени }
//#UC START# *4C7BD34501EB_4C7F801D0304_var*
//#UC END# *4C7BD34501EB_4C7F801D0304_var*
begin
//#UC START# *4C7BD34501EB_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BD34501EB_4C7F801D0304_impl*
end;//TExTextOptionsForm.TimeMachineOnOffNew

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.Copy;
 {* Копировать }
//#UC START# *4C7D0C7B0185_4C7F801D0304_var*
//#UC END# *4C7D0C7B0185_4C7F801D0304_var*
begin
//#UC START# *4C7D0C7B0185_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C7F801D0304_impl*
end;//TExTextOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D345C006D_4C7F801D0304_var*
//#UC END# *4C7D345C006D_4C7F801D0304_var*
begin
//#UC START# *4C7D345C006D_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D345C006D_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowInfo

procedure TExTextOptionsForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D34A903C5_4C7F801D0304_var*
//#UC END# *4C7D34A903C5_4C7F801D0304_var*
begin
//#UC START# *4C7D34A903C5_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D34A903C5_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowInfo

procedure TExTextOptionsForm.TimeMachineOnOffNew;
 {* Включить/Выключить Машину времени }
//#UC START# *4C7D34DE02D2_4C7F801D0304_var*
//#UC END# *4C7D34DE02D2_4C7F801D0304_var*
begin
//#UC START# *4C7D34DE02D2_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D34DE02D2_4C7F801D0304_impl*
end;//TExTextOptionsForm.TimeMachineOnOffNew

procedure TExTextOptionsForm.ShowInfo;
 {* Показать текст предупреждения }
//#UC START# *4C7D354603D3_4C7F801D0304_var*
//#UC END# *4C7D354603D3_4C7F801D0304_var*
begin
//#UC START# *4C7D354603D3_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D354603D3_4C7F801D0304_impl*
end;//TExTextOptionsForm.ShowInfo

procedure TExTextOptionsForm.UserCR1;
 {* Пользовательские ссылки на документ (ссылки из документа) 1 }
//#UC START# *4C7D36900317_4C7F801D0304_var*
//#UC END# *4C7D36900317_4C7F801D0304_var*
begin
//#UC START# *4C7D36900317_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D36900317_4C7F801D0304_impl*
end;//TExTextOptionsForm.UserCR1

procedure TExTextOptionsForm.UserCR2;
 {* Пользовательские ссылки на документ (ссылки из документа) 2 }
//#UC START# *4C7D36C40097_4C7F801D0304_var*
//#UC END# *4C7D36C40097_4C7F801D0304_var*
begin
//#UC START# *4C7D36C40097_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D36C40097_4C7F801D0304_impl*
end;//TExTextOptionsForm.UserCR2

procedure TExTextOptionsForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *4C7D39A7029B_4C7F801D0304_var*
//#UC END# *4C7D39A7029B_4C7F801D0304_var*
begin
//#UC START# *4C7D39A7029B_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D39A7029B_4C7F801D0304_impl*
end;//TExTextOptionsForm.AddToControl

procedure TExTextOptionsForm.MakeHyperlinkToDocument;
 {* Создать ссылку на документ }
//#UC START# *4CDD5C3901E0_4C7F801D0304_var*
//#UC END# *4CDD5C3901E0_4C7F801D0304_var*
begin
//#UC START# *4CDD5C3901E0_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDD5C3901E0_4C7F801D0304_impl*
end;//TExTextOptionsForm.MakeHyperlinkToDocument

procedure TExTextOptionsForm.PrevDocumentInList;
 {* Предыдущий документ в списке }
//#UC START# *4FE1BA1303D3_4C7F801D0304_var*
//#UC END# *4FE1BA1303D3_4C7F801D0304_var*
begin
//#UC START# *4FE1BA1303D3_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1BA1303D3_4C7F801D0304_impl*
end;//TExTextOptionsForm.PrevDocumentInList

procedure TExTextOptionsForm.DocumentIsUseful;
 {* Нравится }
//#UC START# *4FE1EF1201D6_4C7F801D0304_var*
//#UC END# *4FE1EF1201D6_4C7F801D0304_var*
begin
//#UC START# *4FE1EF1201D6_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1201D6_4C7F801D0304_impl*
end;//TExTextOptionsForm.DocumentIsUseful

procedure TExTextOptionsForm.DocumentIsUseless;
 {* Не нравится }
//#UC START# *4FE1EF1B039A_4C7F801D0304_var*
//#UC END# *4FE1EF1B039A_4C7F801D0304_var*
begin
//#UC START# *4FE1EF1B039A_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1B039A_4C7F801D0304_impl*
end;//TExTextOptionsForm.DocumentIsUseless

procedure TExTextOptionsForm.ClearFields;
begin
 f_DocOpsList := nil;
 inherited;
end;//TExTextOptionsForm.ClearFields

procedure TExTextOptionsForm.SelectWord;
//#UC START# *528777B1010F_4C7F801D0304_var*
//#UC END# *528777B1010F_4C7F801D0304_var*
begin
//#UC START# *528777B1010F_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *528777B1010F_4C7F801D0304_impl*
end;//TExTextOptionsForm.SelectWord

procedure TExTextOptionsForm.SelectPara;
//#UC START# *528777C803B4_4C7F801D0304_var*
//#UC END# *528777C803B4_4C7F801D0304_var*
begin
//#UC START# *528777C803B4_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *528777C803B4_4C7F801D0304_impl*
end;//TExTextOptionsForm.SelectPara

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.ReleaseResources;
//#UC START# *538C374A00B7_4C7F801D0304_var*
var
 l_RH: IvcmResourceHolder;
//#UC END# *538C374A00B7_4C7F801D0304_var*
begin
//#UC START# *538C374A00B7_4C7F801D0304_impl*
 inherited;
 if Supports(f_RemindersLine, IvcmResourceHolder, l_RH) then
  l_RH.ReleaseResources;
//#UC END# *538C374A00B7_4C7F801D0304_impl*
end;//TExTextOptionsForm.ReleaseResources
{$IfEnd} // NOT Defined(NoVCM)

procedure TExTextOptionsForm.GetSimilarDocsToBlock;
//#UC START# *5587AA310201_4C7F801D0304_var*
//#UC END# *5587AA310201_4C7F801D0304_var*
begin
//#UC START# *5587AA310201_4C7F801D0304_impl*
 !!! Needs to be implemented !!!
//#UC END# *5587AA310201_4C7F801D0304_impl*
end;//TExTextOptionsForm.GetSimilarDocsToBlock

initialization
 str_WarnRedactionHint.Init;
 {* Инициализация str_WarnRedactionHint }
 str_WarnTimeMachineOnHint.Init;
 {* Инициализация str_WarnTimeMachineOnHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TExTextOptionsForm);
 {* Регистрация ExTextOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
