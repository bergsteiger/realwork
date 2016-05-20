unit ExTextOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\ExTextOptions_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "ExTextOptions" MUID: (4C7F801D0304)
// Имя типа: "TExTextOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , DocumentAndListInterfaces
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
   procedure SetReminderOpParams(const aParams: IvcmTestParamsPrim;
    const aInfo: Il3CString;
    const aCaption: Il3CString = nil);
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
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Openable_OpenInNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure Openable_OpenInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SubPanelSettings_Show_Test(const aParams: IvcmTestParamsPrim);
    {* Показывать метки }
   procedure SubPanelSettings_Show_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Показывать метки }
   procedure Reminder_RemWarnJuror_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnJuror_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnTimeMachineOn_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnTimeMachineOn_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnRedaction_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnOnControl_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnOnControl_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnIsAbolished_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnIsAbolished_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnTimeMachineException_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnTimeMachineException_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnPreActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnPreActive_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_RemWarnTimeMachineWarning_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_RemWarnTimeMachineWarning_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Reminder_ViewInactualDocument_Test(const aParams: IvcmTestParamsPrim);
   procedure Reminder_ViewInactualDocument_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_ChangesButton_Test(const aParams: IvcmTestParamsPrim);
    {* Изменения в документе }
   procedure SubsPanel_CopySubNumber_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать позицию }
   procedure SubsPanel_CopySubNumber_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать позицию }
   procedure SubPanelSettings_ShowByShortCut_Execute(const aParams: IvcmExecuteParamsPrim);
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
 , bsUtilsConst
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

procedure TExTextOptionsForm.SetReminderOpParams(const aParams: IvcmTestParamsPrim;
 const aInfo: Il3CString;
 const aCaption: Il3CString = nil);

 function RefineBaloonHint(const aHint: Il3CString): Il3CString;

  procedure MergeText(aRoot: Tl3Tag;
   var theText: Il3CString);

   function DoIt(anItem: Tl3Variant;
    anIndex: Integer): Boolean;
    {* Подитеративная функция для вызова IterateChildrenF из MergeText }
   //#UC START# *66C7C35BA1A6__var*
   //#UC END# *66C7C35BA1A6__var*
   begin
   //#UC START# *66C7C35BA1A6__impl*
    Result := true;
    if anItem.IsKindOf(k2_typParaList) then
     MergeText(anItem, theText)
    else
    begin
     if (theText = nil) then
      theText := l3CStr(anItem.PCharLenA[k2_tiText])
     else
     begin
      theText := l3Cat(theText, #10);
      theText := l3Cat([theText, l3CStr(anItem.PCharLenA[k2_tiText])]);
     end;//theText = nil
    end;//anItem.IsKindOf(k2_typParaList)
   //#UC END# *66C7C35BA1A6__impl*
   end;//DoIt

  //#UC START# *4F916E210355__var*
  //#UC END# *4F916E210355__var*
  begin
   //#UC START# *4F916E210355iter*
   aRoot.
   //#UC END# *4F916E210355iter*
   IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DoIt));
  end;//MergeText

 //#UC START# *4F916DF101C2__var*
 var
  l_R : TevCustomWikiReader;
  l_G : Tk2DocumentBuffer;
  l_S : Tl3ConstMemoryStream;
  l_W : Tl3WString;
 //#UC END# *4F916DF101C2__var*
 begin
 //#UC START# *4F916DF101C2__impl*
  //Result := aHint;
  Result := nil;
  l_R := TevCustomWikiReader.Create;
  try
   l_G := Tk2DocumentBuffer.Create;
   try
    l_R.Generator := l_G;
    l_W := aHint.AsWStr;
    l_S := Tl3ConstMemoryStream.Create(l_W.S, l_W.SLen);
    try
     l_R.Filer.NeedProcessMessages := false;
     l_R.Filer.Indicator.NeedProgressProc := false;
     l_R.Filer.COMStream := l_S;
     try
      l_R.Filer.CodePage := l_W.SCodePage;
      l_R.Execute;
     finally
      l_R.Filer.COMStream := nil;
     end;//try..finally
    finally
     FreeAndNil(l_S);
    end;//try..finally
    MergeText(l_G.Root, Result);
   finally
    FreeAndNil(l_G);
   end;//try..finally
  finally
   FreeAndNil(l_R);
  end;//try..finally
 //#UC END# *4F916DF101C2__impl*
 end;//RefineBaloonHint

//#UC START# *4C7FAE9B01E1_4C7F801D0304_var*
var
 l_Hint: Il3CString;
//#UC END# *4C7FAE9B01E1_4C7F801D0304_var*
begin
//#UC START# *4C7FAE9B01E1_4C7F801D0304_impl*
 with aParams.Op do
 begin
  Flag[vcm_ofVisible] := (aInfo <> nil);
  if Flag[vcm_ofVisible] then
  begin
   l_Hint := RefineBaloonHint(aInfo);
   if not Document.HasRelatedDoc then
    if l3Ends(str_wgReferenceHyperlinkSearchText.AsCStr, l_Hint) then
     l3SetLen(l_Hint, l3Len(l_Hint) - l3Len(str_wgReferenceHyperlinkSearchText.AsCStr));
   Hint := l_Hint;
   LongHint := l_Hint;
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

procedure TExTextOptionsForm.Openable_OpenInNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C4EB6710127_4C7F801D0304test_var*
//#UC END# *4C4EB6710127_4C7F801D0304test_var*
begin
//#UC START# *4C4EB6710127_4C7F801D0304test_impl*
 HyperLink_OpenNewWindow_Test(aParams);
//#UC END# *4C4EB6710127_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Openable_OpenInNewWindow_Test

procedure TExTextOptionsForm.Openable_OpenInNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C4EB6710127_4C7F801D0304exec_var*
//#UC END# *4C4EB6710127_4C7F801D0304exec_var*
begin
//#UC START# *4C4EB6710127_4C7F801D0304exec_impl*
 HyperLink_OpenNewWindow_Execute(aParams);
//#UC END# *4C4EB6710127_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Openable_OpenInNewWindow_Execute

procedure TExTextOptionsForm.SubPanelSettings_Show_Test(const aParams: IvcmTestParamsPrim);
 {* Показывать метки }
//#UC START# *4C7F8DFF02BF_4C7F801D0304test_var*
//#UC END# *4C7F8DFF02BF_4C7F801D0304test_var*
begin
//#UC START# *4C7F8DFF02BF_4C7F801D0304test_impl*
 aParams.Op.Flag[vcm_ofVisible] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofEnabled] := DefDataAdapter.IsInternal;
 aParams.Op.Flag[vcm_ofChecked] := SubPanel.SubDescriptors.SubsLayer.Visible;
//#UC END# *4C7F8DFF02BF_4C7F801D0304test_impl*
end;//TExTextOptionsForm.SubPanelSettings_Show_Test

procedure TExTextOptionsForm.SubPanelSettings_Show_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Показывать метки }
//#UC START# *4C7F8DFF02BF_4C7F801D0304exec_var*
//#UC END# *4C7F8DFF02BF_4C7F801D0304exec_var*
begin
//#UC START# *4C7F8DFF02BF_4C7F801D0304exec_impl*
 ShowSubNumbers;                     
//#UC END# *4C7F8DFF02BF_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.SubPanelSettings_Show_Execute

procedure TExTextOptionsForm.Reminder_RemWarnJuror_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FACA8026E_4C7F801D0304test_var*
//#UC END# *4C7FACA8026E_4C7F801D0304test_var*
begin
//#UC START# *4C7FACA8026E_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, WarnJurorInfo);
//#UC END# *4C7FACA8026E_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnJuror_Test

procedure TExTextOptionsForm.Reminder_RemWarnJuror_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FACA8026E_4C7F801D0304exec_var*
//#UC END# *4C7FACA8026E_4C7F801D0304exec_var*
begin
//#UC START# *4C7FACA8026E_4C7F801D0304exec_impl*
 ShowWarningPage(False);
 MessageDlg(l3Cat(WarnJurorInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnJuror_Execute', mtInformation);
//#UC END# *4C7FACA8026E_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnJuror_Execute

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineOn_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FACBB005C_4C7F801D0304test_var*
//#UC END# *4C7FACBB005C_4C7F801D0304test_var*
begin
//#UC START# *4C7FACBB005C_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, TimeMachineWarningOnInfo, TimeMachineWarningOnHint);
//#UC END# *4C7FACBB005C_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineOn_Test

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineOn_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FACBB005C_4C7F801D0304exec_var*
//#UC END# *4C7FACBB005C_4C7F801D0304exec_var*
begin
//#UC START# *4C7FACBB005C_4C7F801D0304exec_impl*
 ShowWarningPage(False, cNotSureWarningSub);
 MessageDlg(l3Cat(TimeMachineWarningOnInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnTimeMachineOn_Execute', mtInformation);
//#UC END# *4C7FACBB005C_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineOn_Execute

procedure TExTextOptionsForm.Reminder_RemWarnRedaction_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FACCE013F_4C7F801D0304test_var*
//#UC END# *4C7FACCE013F_4C7F801D0304test_var*
begin
//#UC START# *4C7FACCE013F_4C7F801D0304test_impl*
 if Assigned(Document) then
  with defDataAdapter.TimeMachine do
   aParams.Op.Flag[vcm_ofVisible] := not HasNotSureWarning(Document) and
    not IsOn and not TdmStdRes.IsCurEditionActual(Document);
//#UC END# *4C7FACCE013F_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnRedaction_Test

procedure TExTextOptionsForm.Reminder_RemWarnRedaction_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FACCE013F_4C7F801D0304exec_var*
//#UC END# *4C7FACCE013F_4C7F801D0304exec_var*
begin
//#UC START# *4C7FACCE013F_4C7F801D0304exec_impl*
 ShowWarningPage(False, cEditionWarningSub);
 MessageDlg(l3Cat(WarnRedaction.Hint, '.'), 'TExTextOptionsForm.Reminder_RemWarnRedaction_Execute', mtInformation);
//#UC END# *4C7FACCE013F_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnRedaction_Execute

procedure TExTextOptionsForm.Reminder_RemWarnOnControl_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FACFE01D3_4C7F801D0304test_var*
//#UC END# *4C7FACFE01D3_4C7F801D0304test_var*
begin
//#UC START# *4C7FACFE01D3_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, WarnOnControlInfo);
//#UC END# *4C7FACFE01D3_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnOnControl_Test

procedure TExTextOptionsForm.Reminder_RemWarnOnControl_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FACFE01D3_4C7F801D0304exec_var*
//#UC END# *4C7FACFE01D3_4C7F801D0304exec_var*
begin
//#UC START# *4C7FACFE01D3_4C7F801D0304exec_impl*
 Op_Document_SetActive.Call(Aggregate, Byte(dftRelatedDoc));
 MessageDlg(l3Cat(WarnOnControlInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnOnControl_Execute', mtInformation);
//#UC END# *4C7FACFE01D3_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnOnControl_Execute

procedure TExTextOptionsForm.Reminder_RemWarnIsAbolished_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FAD0F014A_4C7F801D0304test_var*
//#UC END# *4C7FAD0F014A_4C7F801D0304test_var*
begin
//#UC START# *4C7FAD0F014A_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, WarnIsAbolishedInfo);
//#UC END# *4C7FAD0F014A_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnIsAbolished_Test

procedure TExTextOptionsForm.Reminder_RemWarnIsAbolished_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FAD0F014A_4C7F801D0304exec_var*
//#UC END# *4C7FAD0F014A_4C7F801D0304exec_var*
begin
//#UC START# *4C7FAD0F014A_4C7F801D0304exec_impl*
 ShowWarningPage(False);
 MessageDlg(l3Cat(WarnIsAbolishedInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnIsAbolished_Execute', mtInformation);
//#UC END# *4C7FAD0F014A_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnIsAbolished_Execute

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineException_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FAD1D038F_4C7F801D0304test_var*
//#UC END# *4C7FAD1D038F_4C7F801D0304test_var*
begin
//#UC START# *4C7FAD1D038F_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, BaseTimeMachineWarningInfo(tmwError));
//#UC END# *4C7FAD1D038F_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineException_Test

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineException_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FAD1D038F_4C7F801D0304exec_var*
//#UC END# *4C7FAD1D038F_4C7F801D0304exec_var*
begin
//#UC START# *4C7FAD1D038F_4C7F801D0304exec_impl*
 ShowWarningPage(False, cEditionWarningSub);
 MessageDlg(l3Cat(BaseTimeMachineWarningInfo(tmwError), '.'), 'TExTextOptionsForm.Reminder_RemWarnTimeMachineException_Execute', mtInformation);
//#UC END# *4C7FAD1D038F_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineException_Execute

procedure TExTextOptionsForm.Reminder_RemWarnPreActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FAD310195_4C7F801D0304test_var*
//#UC END# *4C7FAD310195_4C7F801D0304test_var*
begin
//#UC START# *4C7FAD310195_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, WarnPreActiveInfo);
//#UC END# *4C7FAD310195_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnPreActive_Test

procedure TExTextOptionsForm.Reminder_RemWarnPreActive_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FAD310195_4C7F801D0304exec_var*
//#UC END# *4C7FAD310195_4C7F801D0304exec_var*
begin
//#UC START# *4C7FAD310195_4C7F801D0304exec_impl*
 ShowWarningPage(False);
 MessageDlg(l3Cat(WarnPreActiveInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnPreActive_Execute', mtInformation);
//#UC END# *4C7FAD310195_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnPreActive_Execute

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineWarning_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FAD470142_4C7F801D0304test_var*
//#UC END# *4C7FAD470142_4C7F801D0304test_var*
begin
//#UC START# *4C7FAD470142_4C7F801D0304test_impl*
 SetReminderOpParams(aParams, TimeMachineWarningInfo);
//#UC END# *4C7FAD470142_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineWarning_Test

procedure TExTextOptionsForm.Reminder_RemWarnTimeMachineWarning_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FAD470142_4C7F801D0304exec_var*
//#UC END# *4C7FAD470142_4C7F801D0304exec_var*
begin
//#UC START# *4C7FAD470142_4C7F801D0304exec_impl*
 ShowWarningPage(False, cNotSureWarningSub);
 MessageDlg(l3Cat(TimeMachineWarningInfo, '.'), 'TExTextOptionsForm.Reminder_RemWarnTimeMachineWarning_Execute', mtInformation);
//#UC END# *4C7FAD470142_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_RemWarnTimeMachineWarning_Execute

procedure TExTextOptionsForm.Reminder_ViewInactualDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7FAD5900EE_4C7F801D0304test_var*
//#UC END# *4C7FAD5900EE_4C7F801D0304test_var*
begin
//#UC START# *4C7FAD5900EE_4C7F801D0304test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NeedShowIntranetWarning;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
 CheckForcedQueryForIntranet;
//#UC END# *4C7FAD5900EE_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Reminder_ViewInactualDocument_Test

procedure TExTextOptionsForm.Reminder_ViewInactualDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7FAD5900EE_4C7F801D0304exec_var*
//#UC END# *4C7FAD5900EE_4C7F801D0304exec_var*
begin
//#UC START# *4C7FAD5900EE_4C7F801D0304exec_impl*
 GoToIntranet;
//#UC END# *4C7FAD5900EE_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.Reminder_ViewInactualDocument_Execute

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

procedure TExTextOptionsForm.Document_ChangesButton_Test(const aParams: IvcmTestParamsPrim);
 {* Изменения в документе }
//#UC START# *4F88460903B1_4C7F801D0304test_var*

 function lp_MakeAvailableOps: IvcmItems;
   {-}
 begin//lp_MakeAvailableOps
  if (f_DocOpsList = nil) then
   f_DocOpsList := TvcmItems.Make;
  if (f_DocOpsList.Count = 0) then
  begin
   f_DocOpsList.AddOp(TdmStdRes.opcode_Document_CompareEditions);
   f_DocOpsList.AddOp(TdmStdRes.opcode_Document_ViewChangedFragments, str_ViewChangesOpName.AsCStr);
   f_DocOpsList.AddOp(TdmStdRes.opcode_TimeMachine_TimeMachineOnOffNew, vcmCStr(str_TimeMachineOp));
   f_DocOpsList.AddOp(TdmStdRes.opcode_Redactions_OpenRedactionListFrmAct);
   f_DocOpsList.AddOp(TdmStdRes.opcode_Document_ShowVersionComments, vcmCStr(str_ShowVersionCommentsOp));
  end;//f_DocOpsList.Count = 0
  Result := f_DocOpsList;
 end;//lp_MakeAvailableOps

var
 l_List : IvcmItems;
//#UC END# *4F88460903B1_4C7F801D0304test_var*
begin
//#UC START# *4F88460903B1_4C7F801D0304test_impl*
 l_List := lp_MakeAvailableOps;
 aParams.Op.SubItems := l_List;
 aParams.Op.Flag[vcm_ofEnabled] := (l_List <> nil) AND (l_List.Count > 0);
//#UC END# *4F88460903B1_4C7F801D0304test_impl*
end;//TExTextOptionsForm.Document_ChangesButton_Test

procedure TExTextOptionsForm.SubsPanel_CopySubNumber_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать позицию }
//#UC START# *4F884EF30187_4C7F801D0304test_var*
var
 l_eeSub : IeeSub;
//#UC END# *4F884EF30187_4C7F801D0304test_var*
begin
//#UC START# *4F884EF30187_4C7F801D0304test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (afw.Application.IsInternal or
  Settings.LoadBoolean(pi_Document_SubPanel_ShowSubNumbers, dv_Document_SubPanel_ShowSubNumbers)) and
  Assigned(dsDocument) and
  Supports(aParams.Target, IeeSub, l_eeSub) and
  (l_eeSub.LayerID = Ord(ev_sbtSub));
//#UC END# *4F884EF30187_4C7F801D0304test_impl*
end;//TExTextOptionsForm.SubsPanel_CopySubNumber_Test

procedure TExTextOptionsForm.SubsPanel_CopySubNumber_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать позицию }
//#UC START# *4F884EF30187_4C7F801D0304exec_var*
var
 l_eeSub : IeeSub;
//#UC END# *4F884EF30187_4C7F801D0304exec_var*
begin
//#UC START# *4F884EF30187_4C7F801D0304exec_impl*
 if Supports(aParams.Target, IeeSub, l_eeSub) and
    (l_eeSub.LayerID = Ord(ev_sbtSub)) and
    Assigned(dsDocument) then
 begin
  l3System.SetClipboardData(
   TevConstStringData.Make(dsDocument.GetSubPosition(l_eeSub.ID), nil));
  TnsUseDocumentSubPanelOperationEvent.Instance.Log;
 end;//Supports(aParams.Target, IeeSub, l_eeSub)
//#UC END# *4F884EF30187_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.SubsPanel_CopySubNumber_Execute

procedure TExTextOptionsForm.SubPanelSettings_ShowByShortCut_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *528373EC0026_4C7F801D0304exec_var*
//#UC END# *528373EC0026_4C7F801D0304exec_var*
begin
//#UC START# *528373EC0026_4C7F801D0304exec_impl*
 ShowSubNumbers;
//#UC END# *528373EC0026_4C7F801D0304exec_impl*
end;//TExTextOptionsForm.SubPanelSettings_ShowByShortCut_Execute

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

procedure TExTextOptionsForm.ClearFields;
begin
 f_DocOpsList := nil;
 inherited;
end;//TExTextOptionsForm.ClearFields

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

{$If NOT Defined(NoVCM)}
procedure TExTextOptionsForm.MakeControls;
begin
 inherited;
 f_RemindersLine := TnscRemindersLine.Create(Self);
 f_RemindersLine.Name := 'RemindersLine';
 f_RemindersLine.Parent := Self;
 with DefineZone(vcm_ztChild, f_RemindersLine) do
 begin
 end;//with DefineZone(vcm_ztChild
 f_WarnTimeMachineException := TnscReminder.Create(RemindersLine);
 f_WarnTimeMachineException.Name := 'WarnTimeMachineException';
 f_WarnIsAbolished := TnscReminder.Create(RemindersLine);
 f_WarnIsAbolished.Name := 'WarnIsAbolished';
 f_WarnPreActive := TnscReminder.Create(RemindersLine);
 f_WarnPreActive.Name := 'WarnPreActive';
 f_WarnTimeMachineWarning := TnscReminder.Create(RemindersLine);
 f_WarnTimeMachineWarning.Name := 'WarnTimeMachineWarning';
 f_WarnOnControl := TnscReminder.Create(RemindersLine);
 f_WarnOnControl.Name := 'WarnOnControl';
 f_WarnJuror := TnscReminder.Create(RemindersLine);
 f_WarnJuror.Name := 'WarnJuror';
 f_WarnRedaction := TnscReminder.Create(RemindersLine);
 f_WarnRedaction.Name := 'WarnRedaction';
 f_WarnInactualDocument := TnscReminder.Create(RemindersLine);
 f_WarnInactualDocument.Name := 'WarnInactualDocument';
 f_WarnTimeMachineOn := TnscReminder.Create(RemindersLine);
 f_WarnTimeMachineOn.Name := 'WarnTimeMachineOn';
end;//TExTextOptionsForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

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
