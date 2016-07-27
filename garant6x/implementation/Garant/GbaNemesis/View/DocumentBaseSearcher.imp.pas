{$IfNDef DocumentBaseSearcher_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentBaseSearcher.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "DocumentBaseSearcher" MUID: (4B4DB88E01B6)
// Имя типа: "_DocumentBaseSearcher_"

{$Define DocumentBaseSearcher_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentBaseSearcher_ = {abstract} class(_DocumentBaseSearcher_Parent_, InsContextSearcher, InsBaseSearchContextProvider, InsBaseSearchVisibleWatcher)
  private
   f_SearchWindowVisible: Boolean;
   f_SearchArea: TnsSearchArea;
   f_IsPageActive: Boolean;
   f_ContextSearcher: IbsBaseDocumentContextSearcher;
  private
   procedure RequestCheckFragmentsCount;
   procedure CheckFocusedInPaint(aSender: TObject;
    var aFocused: Boolean);
  protected
   function pm_GetContextSearcher: IbsBaseDocumentContextSearcher;
   procedure DoEditFindContextTest(const aParams: IvcmTestParamsPrim); virtual;
   procedure CheckTrial(const aParams: IvcmTestParamsPrim); virtual;
   function DocumentForSearch: IDocument; virtual; abstract;
   function ContinueSearchInWholeBase: Boolean; virtual;
   function pm_GetArea: TnsSearchArea;
   procedure pm_SetArea(aValue: TnsSearchArea);
   function Kind: TnsBaseSearchKind;
   function Find(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
   function AllowSearchInTitles: Boolean;
   function IsLocalSearchArea: Boolean;
   procedure ContextChanged(const aNewContext: Il3CString);
   function IsLocalDataReady: Boolean;
   procedure RepairMistakes;
   function pm_GetContext: Il3CString;
   procedure VisibleChanged(aNewVisible: Boolean);
   function FindBack(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
    {* Искать назад }
   function FindBackSupported: Boolean;
   function FindBackEnabled: Boolean;
   function FragmentsCountSuffix: Il3CString;
   function AllowPrompts: Boolean;
   function PromptsInfo: LongWord;
   function Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
   function SwitchToTextIfPossible: Boolean;
   function IsSearchLocked: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PageInactive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Копировать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Cut_Test(const aParams: IvcmTestParamsPrim);
    {* Вырезать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Cut_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вырезать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Поиск }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
    {* Найти далее }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Найти далее }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Paste_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вставка }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Выделить всё }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Снять выделение }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   function SupportDisabled: Boolean;
  protected
   property ContextSearcher: IbsBaseDocumentContextSearcher
    read pm_GetContextSearcher;
 end;//_DocumentBaseSearcher_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentBaseSearcher_ = _DocumentBaseSearcher_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentBaseSearcher_imp}

{$IfNDef DocumentBaseSearcher_imp_impl}

{$Define DocumentBaseSearcher_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _DocumentBaseSearcher_.pm_GetContextSearcher: IbsBaseDocumentContextSearcher;
//#UC START# *4B4DB9720181_4B4DB88E01B6get_var*
//#UC END# *4B4DB9720181_4B4DB88E01B6get_var*
begin
//#UC START# *4B4DB9720181_4B4DB88E01B6get_impl*
 if not Assigned(f_ContextSearcher) then
  f_ContextSearcher := TbsDocumentContextSearcher.Make(Text);
 Result := f_ContextSearcher;
//#UC END# *4B4DB9720181_4B4DB88E01B6get_impl*
end;//_DocumentBaseSearcher_.pm_GetContextSearcher

procedure _DocumentBaseSearcher_.DoEditFindContextTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8DCA3402C1_4B4DB88E01B6_var*
//#UC END# *4C8DCA3402C1_4B4DB88E01B6_var*
begin
//#UC START# *4C8DCA3402C1_4B4DB88E01B6_impl*
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := TextSource.HasDocument;
//#UC END# *4C8DCA3402C1_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.DoEditFindContextTest

procedure _DocumentBaseSearcher_.CheckTrial(const aParams: IvcmTestParamsPrim);
//#UC START# *4B4DCA8D01DC_4B4DB88E01B6_var*
//#UC END# *4B4DCA8D01DC_4B4DB88E01B6_var*
begin
//#UC START# *4B4DCA8D01DC_4B4DB88E01B6_impl*
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4B4DCA8D01DC_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.CheckTrial

function _DocumentBaseSearcher_.ContinueSearchInWholeBase: Boolean;
//#UC START# *4B4EF0D2016A_4B4DB88E01B6_var*
//#UC END# *4B4EF0D2016A_4B4DB88E01B6_var*
begin
//#UC START# *4B4EF0D2016A_4B4DB88E01B6_impl*
 Result := not (DocumentForSearch.GetDocType in
                [DT_MEDICAL_EXPLANATORY, DT_MEDICAL_FIRM, DT_MEDICAL_DOCUMENT]);
//#UC END# *4B4EF0D2016A_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.ContinueSearchInWholeBase

procedure _DocumentBaseSearcher_.RequestCheckFragmentsCount;
//#UC START# *4B4EF6A701F4_4B4DB88E01B6_var*
//#UC END# *4B4EF6A701F4_4B4DB88E01B6_var*
begin
//#UC START# *4B4EF6A701F4_4B4DB88E01B6_impl*
 TdmStdRes.BaseSearchCheckFragmentsCount(NativeMainForm);
//#UC END# *4B4EF6A701F4_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.RequestCheckFragmentsCount

procedure _DocumentBaseSearcher_.CheckFocusedInPaint(aSender: TObject;
 var aFocused: Boolean);
//#UC START# *4B4EFBF200E2_4B4DB88E01B6_var*
//#UC END# *4B4EFBF200E2_4B4DB88E01B6_var*
begin
//#UC START# *4B4EFBF200E2_4B4DB88E01B6_impl*
 if not aFocused then
  aFocused := f_SearchWindowVisible; 
//#UC END# *4B4EFBF200E2_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.CheckFocusedInPaint

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_4B4DB88E01B6test_var*
//#UC END# *4951284902BD_4B4DB88E01B6test_var*
begin
//#UC START# *4951284902BD_4B4DB88E01B6test_impl*
 aParams.CallControl;
 //CheckTrial(aParams);
//#UC END# *4951284902BD_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Copy_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Копировать }
//#UC START# *4951284902BD_4B4DB88E01B6exec_var*
//#UC END# *4951284902BD_4B4DB88E01B6exec_var*
begin
//#UC START# *4951284902BD_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *4951284902BD_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Copy_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Cut_Test(const aParams: IvcmTestParamsPrim);
 {* Вырезать }
//#UC START# *4951285702E1_4B4DB88E01B6test_var*
//#UC END# *4951285702E1_4B4DB88E01B6test_var*
begin
//#UC START# *4951285702E1_4B4DB88E01B6test_impl*
 aParams.CallControl;
 //CheckTrial(aParams);
//#UC END# *4951285702E1_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Cut_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Cut_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вырезать }
//#UC START# *4951285702E1_4B4DB88E01B6exec_var*
//#UC END# *4951285702E1_4B4DB88E01B6exec_var*
begin
//#UC START# *4951285702E1_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *4951285702E1_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Cut_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
 {* Поиск }
//#UC START# *49512B5D0009_4B4DB88E01B6test_var*
//#UC END# *49512B5D0009_4B4DB88E01B6test_var*
begin
//#UC START# *49512B5D0009_4B4DB88E01B6test_impl*
 DoEditFindContextTest(aParams);
//#UC END# *49512B5D0009_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_FindContext_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Поиск }
//#UC START# *49512B5D0009_4B4DB88E01B6exec_var*
//#UC END# *49512B5D0009_4B4DB88E01B6exec_var*
begin
//#UC START# *49512B5D0009_4B4DB88E01B6exec_impl*
 TdmStdRes.OpenBaseSearch(ns_bsokLocal, nil);
//#UC END# *49512B5D0009_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_FindContext_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindNext_Test(const aParams: IvcmTestParamsPrim);
 {* Найти далее }
//#UC START# *495130C40123_4B4DB88E01B6test_var*
//#UC END# *495130C40123_4B4DB88E01B6test_var*
begin
//#UC START# *495130C40123_4B4DB88E01B6test_impl*
 Edit_FindContext_Test(aParams);
//#UC END# *495130C40123_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_FindNext_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindNext_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Найти далее }
//#UC START# *495130C40123_4B4DB88E01B6exec_var*
//#UC END# *495130C40123_4B4DB88E01B6exec_var*
begin
//#UC START# *495130C40123_4B4DB88E01B6exec_impl*
 if Assigned(f_ContextSearcher) and f_ContextSearcher.CanContinue then
  Find(Self, nil)
 else
  TdmStdRes.OpenBaseSearch(ns_bsokLocal,
                           nil);
//#UC END# *495130C40123_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_FindNext_Execute
{$IfEnd} // NOT Defined(NoVCM)

function _DocumentBaseSearcher_.pm_GetArea: TnsSearchArea;
//#UC START# *49513239027A_4B4DB88E01B6get_var*
//#UC END# *49513239027A_4B4DB88E01B6get_var*
begin
//#UC START# *49513239027A_4B4DB88E01B6get_impl*
 Result := f_SearchArea;
//#UC END# *49513239027A_4B4DB88E01B6get_impl*
end;//_DocumentBaseSearcher_.pm_GetArea

procedure _DocumentBaseSearcher_.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *49513239027A_4B4DB88E01B6set_var*
//#UC END# *49513239027A_4B4DB88E01B6set_var*
begin
//#UC START# *49513239027A_4B4DB88E01B6set_impl*
 f_SearchArea := aValue;
 if not IsLocalSearchArea then
  ContextChanged(nil);
//#UC END# *49513239027A_4B4DB88E01B6set_impl*
end;//_DocumentBaseSearcher_.pm_SetArea

function _DocumentBaseSearcher_.Kind: TnsBaseSearchKind;
//#UC START# *4951325E03B6_4B4DB88E01B6_var*
//#UC END# *4951325E03B6_4B4DB88E01B6_var*
begin
//#UC START# *4951325E03B6_4B4DB88E01B6_impl*
 Result := ns_bskDocument;
//#UC END# *4951325E03B6_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.Kind

function _DocumentBaseSearcher_.Find(const aContext: InsBaseSearchContextProvider;
 const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *4951329202AB_4B4DB88E01B6_var*
var
 l_Result: TbsBaseSearchResult;
 l_Visualizer: IafwLongProcessVisualizer;
//#UC END# *4951329202AB_4B4DB88E01B6_var*
begin
//#UC START# *4951329202AB_4B4DB88E01B6_impl*
 if IsLocalSearchArea then
 begin
  Result := True;
  if l3IsNil(aContext.Context) then
   raise ETryToFindEmptyContext.Create('');

  if not Text.HasDocument OR not Text.Document.AsObject.IsValid then
   Text.TextSource.DocumentContainer.Document;
   // - дёргаем, чтобы прогрузить документ

  Assert(Text.HasDocument and Text.Document.AsObject.IsValid,'Document not loaded yet');

  if (DocumentForSearch <> nil) then
  begin
   if DocumentForSearch.IsMorphoSearchSupported and
      not ContextSearcher.CanContinue then
   try
    aContext.RepairMistakes;
   except
    // http://mdp.garant.ru/pages/viewpage.action?pageId=477633558    
    on EAbort do
    begin
     TnsSearchInDocumentDoneEvent.Log(DocumentForSearch, aContext.Context, 0);
     Raise;
    end;//on EAbort
   end;//try..except
  end;//DocumentForSearch <> nil
  l_Visualizer := bsMakeSearchVisualizer(aContext.Context);
  try
   // http://mdp.garant.ru/pages/viewpage.action?pageId=477633558
   if (ContextSearcher.FragmentsCount = 0) then
    TnsSearchInDocumentEvent.Log(DocumentForSearch, aContext.Context);
   l_Result := ContextSearcher.Find(aContext.Context);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=477633558
   if ContextSearcher.CanFindBack then
    TnsSearchInDocumentNextEvent.Log(DocumentForSearch, aContext.Context)
   else
    TnsSearchInDocumentDoneEvent.Log(DocumentForSearch, aContext.Context,
     ContextSearcher.FragmentsCount);
   TdmStdRes.BaseSearchCheckFindBack(NativeMainForm);
  finally
   l_Visualizer := nil;
  end;
  case l_Result of
   bsrContinueSearch:
    if Assigned(aProcessor) then
     aProcessor.SearchResultExists;
   bsrSearchFinished:
    Say(inf_SearchFinished);
   bsrSearchFinishedNotFound:
    if not ContinueSearchInWholeBase then
     Say(inf_SearchFinishedContextNotFound)
    else
    if Ask(qr_SearchFinishedContextNotFoundQ) then
     TdmStdRes.TryAnotherBaseSearch(NativeMainForm, aProcessor);
   bsrSearchFinishedAllInHidden:
    Say(inf_SearchFinishedAllInHidden);
  end;//case l_Result of
 end//IsLocalSearchArea
 else
  Result := False;
//#UC END# *4951329202AB_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.Find

function _DocumentBaseSearcher_.AllowSearchInTitles: Boolean;
//#UC START# *495132A703DF_4B4DB88E01B6_var*
//#UC END# *495132A703DF_4B4DB88E01B6_var*
begin
//#UC START# *495132A703DF_4B4DB88E01B6_impl*
 Result := False;
//#UC END# *495132A703DF_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.AllowSearchInTitles

function _DocumentBaseSearcher_.IsLocalSearchArea: Boolean;
//#UC START# *495132B70156_4B4DB88E01B6_var*
//#UC END# *495132B70156_4B4DB88E01B6_var*
begin
//#UC START# *495132B70156_4B4DB88E01B6_impl*
 Result := f_SearchArea = ns_saText;
//#UC END# *495132B70156_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.IsLocalSearchArea

procedure _DocumentBaseSearcher_.ContextChanged(const aNewContext: Il3CString);
//#UC START# *495132C20005_4B4DB88E01B6_var*
//#UC END# *495132C20005_4B4DB88E01B6_var*
begin
//#UC START# *495132C20005_4B4DB88E01B6_impl*
 ContextSearcher.ContextChanged(aNewContext);
 RequestCheckFragmentsCount;
//#UC END# *495132C20005_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.ContextChanged

function _DocumentBaseSearcher_.IsLocalDataReady: Boolean;
//#UC START# *495132CE010F_4B4DB88E01B6_var*
//#UC END# *495132CE010F_4B4DB88E01B6_var*
begin
//#UC START# *495132CE010F_4B4DB88E01B6_impl*
 Result := Text.HasDocument and Text.Document.AsObject.IsValid;
//#UC END# *495132CE010F_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.IsLocalDataReady

procedure _DocumentBaseSearcher_.RepairMistakes;
//#UC START# *49513746034D_4B4DB88E01B6_var*
//#UC END# *49513746034D_4B4DB88E01B6_var*
begin
//#UC START# *49513746034D_4B4DB88E01B6_impl*
// DoNothing
//#UC END# *49513746034D_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.RepairMistakes

function _DocumentBaseSearcher_.pm_GetContext: Il3CString;
//#UC START# *4951375B0052_4B4DB88E01B6get_var*
//#UC END# *4951375B0052_4B4DB88E01B6get_var*
begin
//#UC START# *4951375B0052_4B4DB88E01B6get_impl*
 Result := ContextSearcher.Context;
//#UC END# *4951375B0052_4B4DB88E01B6get_impl*
end;//_DocumentBaseSearcher_.pm_GetContext

procedure _DocumentBaseSearcher_.VisibleChanged(aNewVisible: Boolean);
//#UC START# *496B517202C5_4B4DB88E01B6_var*
//#UC END# *496B517202C5_4B4DB88E01B6_var*
begin
//#UC START# *496B517202C5_4B4DB88E01B6_impl*
 if (f_SearchWindowVisible <> aNewVisible) then
 begin
  f_SearchWindowVisible := aNewVisible;
  if Assigned(Text.Selection) and not Text.Selection.Collapsed then
   Text.Invalidate;
 end;//f_SearchWindowVisible <> aNewVisible
//#UC END# *496B517202C5_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.VisibleChanged

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Paste_Test(const aParams: IvcmTestParamsPrim);
 {* Вставка }
//#UC START# *49EDFA3701B0_4B4DB88E01B6test_var*
//#UC END# *49EDFA3701B0_4B4DB88E01B6test_var*
begin
//#UC START# *49EDFA3701B0_4B4DB88E01B6test_impl*
 aParams.CallControl;
//#UC END# *49EDFA3701B0_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Paste_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Paste_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вставка }
//#UC START# *49EDFA3701B0_4B4DB88E01B6exec_var*
//#UC END# *49EDFA3701B0_4B4DB88E01B6exec_var*
begin
//#UC START# *49EDFA3701B0_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *49EDFA3701B0_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Paste_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *49EDFCA2006D_4B4DB88E01B6test_var*
//#UC END# *49EDFCA2006D_4B4DB88E01B6test_var*
begin
//#UC START# *49EDFCA2006D_4B4DB88E01B6test_impl*
 aParams.CallControl;
//#UC END# *49EDFCA2006D_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Undo_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *49EDFCA2006D_4B4DB88E01B6exec_var*
//#UC END# *49EDFCA2006D_4B4DB88E01B6exec_var*
begin
//#UC START# *49EDFCA2006D_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *49EDFCA2006D_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Undo_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
 {* Возврат }
//#UC START# *49EDFCB100BC_4B4DB88E01B6test_var*
//#UC END# *49EDFCB100BC_4B4DB88E01B6test_var*
begin
//#UC START# *49EDFCB100BC_4B4DB88E01B6test_impl*
 aParams.CallControl;
//#UC END# *49EDFCB100BC_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Redo_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Возврат }
//#UC START# *49EDFCB100BC_4B4DB88E01B6exec_var*
//#UC END# *49EDFCB100BC_4B4DB88E01B6exec_var*
begin
//#UC START# *49EDFCB100BC_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *49EDFCB100BC_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Redo_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_SelectAll_Test(const aParams: IvcmTestParamsPrim);
 {* Выделить всё }
//#UC START# *49EE01AA02BE_4B4DB88E01B6test_var*
//#UC END# *49EE01AA02BE_4B4DB88E01B6test_var*
begin
//#UC START# *49EE01AA02BE_4B4DB88E01B6test_impl*
 aParams.CallControl;
//#UC END# *49EE01AA02BE_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_SelectAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_SelectAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Выделить всё }
//#UC START# *49EE01AA02BE_4B4DB88E01B6exec_var*
//#UC END# *49EE01AA02BE_4B4DB88E01B6exec_var*
begin
//#UC START# *49EE01AA02BE_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *49EE01AA02BE_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_SelectAll_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
 {* Снять выделение }
//#UC START# *49EE01BC022E_4B4DB88E01B6test_var*
//#UC END# *49EE01BC022E_4B4DB88E01B6test_var*
begin
//#UC START# *49EE01BC022E_4B4DB88E01B6test_impl*
 aParams.CallControl;
//#UC END# *49EE01BC022E_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_Deselect_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Снять выделение }
//#UC START# *49EE01BC022E_4B4DB88E01B6exec_var*
//#UC END# *49EE01BC022E_4B4DB88E01B6exec_var*
begin
//#UC START# *49EE01BC022E_4B4DB88E01B6exec_impl*
 aParams.CallControl;
//#UC END# *49EE01BC022E_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_Deselect_Execute
{$IfEnd} // NOT Defined(NoVCM)

function _DocumentBaseSearcher_.FindBack(const aContext: InsBaseSearchContextProvider;
 const aProcessor: InsBaseSearchResultProcessor): Boolean;
 {* Искать назад }
//#UC START# *49FEA325027E_4B4DB88E01B6_var*
var
 l_Result: TbsBaseSearchResult;
 l_Visualizer: IafwLongProcessVisualizer;
//#UC END# *49FEA325027E_4B4DB88E01B6_var*
begin
//#UC START# *49FEA325027E_4B4DB88E01B6_impl*
 if IsLocalSearchArea then
 begin
  Result := True;
  if l3IsNil(aContext.Context) then
   raise ETryToFindEmptyContext.Create('');

  Assert(Text.HasDocument and Text.Document.AsObject.IsValid,'Document not loaded yet');

  Assert(ContextSearcher.CanFindBack);

  l_Visualizer := bsMakeSearchVisualizer(aContext.Context);
  try
   // http://mdp.garant.ru/pages/viewpage.action?pageId=477633558
   TnsSearchInDocumentPrevEvent.Log(DocumentForSearch, aContext.Context);
   l_Result := ContextSearcher.FindBack;
   TdmStdRes.BaseSearchCheckFindBack(NativeMainForm);
  finally
   l_Visualizer := nil;
  end;
  case l_Result of
   bsrContinueSearch:
    if Assigned(aProcessor) then
     aProcessor.SearchResultExists;
   bsrSearchFinished:
    Say(inf_SearchFinished);
   bsrSearchFinishedNotFound:
    if not ContinueSearchInWholeBase then
     Say(inf_SearchFinishedContextNotFound)
    else
    if Ask(qr_SearchFinishedContextNotFoundQ) then
     TdmStdRes.TryAnotherBaseSearch(NativeMainForm, aProcessor);
   bsrSearchFinishedAllInHidden:
    Say(inf_SearchFinishedAllInHidden);
  end;//case l_Result of
 end//IsLocalSearchArea
 else
  Result := False;
//#UC END# *49FEA325027E_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.FindBack

function _DocumentBaseSearcher_.FindBackSupported: Boolean;
//#UC START# *49FEB37C02FB_4B4DB88E01B6_var*
//#UC END# *49FEB37C02FB_4B4DB88E01B6_var*
begin
//#UC START# *49FEB37C02FB_4B4DB88E01B6_impl*
 Result := IsLocalSearchArea;
//#UC END# *49FEB37C02FB_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.FindBackSupported

function _DocumentBaseSearcher_.FindBackEnabled: Boolean;
//#UC START# *49FEB3960023_4B4DB88E01B6_var*
//#UC END# *49FEB3960023_4B4DB88E01B6_var*
begin
//#UC START# *49FEB3960023_4B4DB88E01B6_impl*
 Result := ContextSearcher.CanFindBack;
//#UC END# *49FEB3960023_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.FindBackEnabled

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindPrev_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49FEDE4703B8_4B4DB88E01B6test_var*
//#UC END# *49FEDE4703B8_4B4DB88E01B6test_var*
begin
//#UC START# *49FEDE4703B8_4B4DB88E01B6test_impl*
 Edit_FindContext_Test(aParams);
 if aParams.Op.Flag[vcm_ofEnabled] and
   not (Assigned(f_ContextSearcher) and f_ContextSearcher.CanFindBack) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49FEDE4703B8_4B4DB88E01B6test_impl*
end;//_DocumentBaseSearcher_.Edit_FindPrev_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.Edit_FindPrev_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49FEDE4703B8_4B4DB88E01B6exec_var*
//#UC END# *49FEDE4703B8_4B4DB88E01B6exec_var*
begin
//#UC START# *49FEDE4703B8_4B4DB88E01B6exec_impl*
 if Assigned(f_ContextSearcher) and f_ContextSearcher.CanFindBack then
  FindBack(Self, nil);
//#UC END# *49FEDE4703B8_4B4DB88E01B6exec_impl*
end;//_DocumentBaseSearcher_.Edit_FindPrev_Execute
{$IfEnd} // NOT Defined(NoVCM)

function _DocumentBaseSearcher_.FragmentsCountSuffix: Il3CString;
//#UC START# *49FFD8230333_4B4DB88E01B6_var*
var
 l_FoundCount: Integer;
const
 cMaxFragmentsCount = 999;
//#UC END# *49FFD8230333_4B4DB88E01B6_var*
begin
//#UC START# *49FFD8230333_4B4DB88E01B6_impl*
 l_FoundCount := ContextSearcher.FragmentsCount;
 if l_FoundCount > cMaxFragmentsCount then
  Result := nsCStr(Format(' >%d',[cMaxFragmentsCount]))
 else
  if l_FoundCount = 0 then
   Result := nil
  else
   Result := nsCStr(Format(' %d',[l_FoundCount]));
//#UC END# *49FFD8230333_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.FragmentsCountSuffix

function _DocumentBaseSearcher_.AllowPrompts: Boolean;
//#UC START# *4AA4E63900F9_4B4DB88E01B6_var*
//#UC END# *4AA4E63900F9_4B4DB88E01B6_var*
begin
//#UC START# *4AA4E63900F9_4B4DB88E01B6_impl*
 Result := HasDoc or not IsLocalSearchArea;
 if Result and IsLocalSearchArea then
  try
   DocumentForSearch.GetInternalId;
  except
   on ECanNotFindData do
    Result := False;
  end;//try..except
//#UC END# *4AA4E63900F9_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.AllowPrompts

function _DocumentBaseSearcher_.PromptsInfo: LongWord;
//#UC START# *4AA4E64E0395_4B4DB88E01B6_var*
//#UC END# *4AA4E64E0395_4B4DB88E01B6_var*
begin
//#UC START# *4AA4E64E0395_4B4DB88E01B6_impl*
 if IsLocalSearchArea and HasDoc then
  Result := DocumentForSearch.GetInternalId
 else
  Result := 0;
//#UC END# *4AA4E64E0395_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.PromptsInfo

function _DocumentBaseSearcher_.SupportDisabled: Boolean;
//#UC START# *4ACA17770179_4B4DB88E01B6_var*
//#UC END# *4ACA17770179_4B4DB88E01B6_var*
begin
//#UC START# *4ACA17770179_4B4DB88E01B6_impl*
 Result := False;
//#UC END# *4ACA17770179_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.SupportDisabled

function _DocumentBaseSearcher_.Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
//#UC START# *4AD608860210_4B4DB88E01B6get_var*
//#UC END# *4AD608860210_4B4DB88E01B6get_var*
begin
//#UC START# *4AD608860210_4B4DB88E01B6get_impl*
 Result := Self;
//#UC END# *4AD608860210_4B4DB88E01B6get_impl*
end;//_DocumentBaseSearcher_.Get_VisibleWatcher

function _DocumentBaseSearcher_.SwitchToTextIfPossible: Boolean;
//#UC START# *4B263ADE02E0_4B4DB88E01B6_var*
//#UC END# *4B263ADE02E0_4B4DB88E01B6_var*
begin
//#UC START# *4B263ADE02E0_4B4DB88E01B6_impl*
 Result := True;
//#UC END# *4B263ADE02E0_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.SwitchToTextIfPossible

function _DocumentBaseSearcher_.IsSearchLocked: Boolean;
//#UC START# *561641EE03D8_4B4DB88E01B6_var*
//#UC END# *561641EE03D8_4B4DB88E01B6_var*
begin
//#UC START# *561641EE03D8_4B4DB88E01B6_impl*
 Result := not f_IsPageActive;
//#UC END# *561641EE03D8_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.IsSearchLocked

procedure _DocumentBaseSearcher_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B4DB88E01B6_var*
//#UC END# *479731C50290_4B4DB88E01B6_var*
begin
//#UC START# *479731C50290_4B4DB88E01B6_impl*
 f_ContextSearcher := nil;
 inherited;
//#UC END# *479731C50290_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.Cleanup

procedure _DocumentBaseSearcher_.InitFields;
//#UC START# *47A042E100E2_4B4DB88E01B6_var*
//#UC END# *47A042E100E2_4B4DB88E01B6_var*
begin
//#UC START# *47A042E100E2_4B4DB88E01B6_impl*
 f_IsPageActive := True;
 inherited;
//#UC END# *47A042E100E2_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.InitFields

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4B4DB88E01B6_var*
//#UC END# *497469C90140_4B4DB88E01B6_var*
begin
//#UC START# *497469C90140_4B4DB88E01B6_impl*
 inherited NotifyDataSourceChanged(anOld, aNew);
 RequestCheckFragmentsCount;
//#UC END# *497469C90140_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4B4DB88E01B6_var*
//#UC END# *4A8E8F2E0195_4B4DB88E01B6_var*
begin
//#UC START# *4A8E8F2E0195_4B4DB88E01B6_impl*
 Text.OnCheckFocusedInPaint := CheckFocusedInPaint;
 inherited;
//#UC END# *4A8E8F2E0195_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.PageActive;
//#UC START# *4C52E8030278_4B4DB88E01B6_var*
//#UC END# *4C52E8030278_4B4DB88E01B6_var*
begin
//#UC START# *4C52E8030278_4B4DB88E01B6_impl*
 inherited;
 f_IsPageActive := True;
 TnsSearchWindowManager.Instance.CheckFindEnabled;
//#UC END# *4C52E8030278_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.PageActive
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.PageInactive;
//#UC START# *4C52E81603A9_4B4DB88E01B6_var*
//#UC END# *4C52E81603A9_4B4DB88E01B6_var*
begin
//#UC START# *4C52E81603A9_4B4DB88E01B6_impl*
 inherited;
 f_IsPageActive := False;
 TnsSearchWindowManager.Instance.CheckFindEnabled;
//#UC END# *4C52E81603A9_4B4DB88E01B6_impl*
end;//_DocumentBaseSearcher_.PageInactive
{$IfEnd} // NOT Defined(NoVCM)

procedure _DocumentBaseSearcher_.ClearFields;
begin
 f_ContextSearcher := nil;
 inherited;
end;//_DocumentBaseSearcher_.ClearFields

{$If NOT Defined(NoVCM)}
procedure _DocumentBaseSearcher_.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  PublishOp(en_Edit, op_Cut, Edit_Cut_Execute, Edit_Cut_Test, nil);
  PublishOp(en_Edit, op_FindContext, Edit_FindContext_Execute, Edit_FindContext_Test, nil);
  PublishOp(en_Edit, op_FindNext, Edit_FindNext_Execute, Edit_FindNext_Test, nil);
  PublishOp(en_Edit, op_Paste, Edit_Paste_Execute, Edit_Paste_Test, nil);
  PublishOp(en_Edit, op_Undo, Edit_Undo_Execute, Edit_Undo_Test, nil);
  PublishOp(en_Edit, op_Redo, Edit_Redo_Execute, Edit_Redo_Test, nil);
  PublishOp(en_Edit, op_SelectAll, Edit_SelectAll_Execute, Edit_SelectAll_Test, nil);
  PublishOp(en_Edit, op_Deselect, Edit_Deselect_Execute, Edit_Deselect_Test, nil);
  PublishOp(en_Edit, op_FindPrev, Edit_FindPrev_Execute, Edit_FindPrev_Test, nil);
 end;//with Entities.Entities
end;//_DocumentBaseSearcher_.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf DocumentBaseSearcher_imp_impl}

{$EndIf DocumentBaseSearcher_imp}

