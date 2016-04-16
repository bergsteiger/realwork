unit PrimOldSituationSearch_Form;
 {* Поиск по ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimOldSituationSearch" MUID: (4AE8831A02A5)
// Имя типа: "TPrimOldSituationSearchForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , nsQueryInterfaces
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , vtProportionalPanel
 , vtSizeablePanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , SearchUnit
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 CM_AFTER_INIT = WM_USER + 201;

type
 // MainZone

 // ChildZone

 // ParentZone

 TPrimOldSituationSearchForm = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Поиск по ситуации }
  private
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_InnerBackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства InnerBackgroundPanel }
   f_BotomPanel: TvtSizeablePanel;
    {* Поле для свойства BotomPanel }
   f_ParentZone: TvtPanel;
    {* Поле для свойства ParentZone }
   f_ZoneContainer: TvtProportionalPanel;
    {* Поле для свойства ZoneContainer }
   f_ChildZone: TvtPanel;
    {* Поле для свойства ChildZone }
   f_MainZone: TvtSizeablePanel;
    {* Поле для свойства MainZone }
  protected
   f_FormState: InsQueryFormState;
  private
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   procedure AfterInit(var Message: TMessage); message CM_AFTER_INIT;
  protected
   function FillQuery: IQuery;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   function SearchParameters_IsQueryEmpty_Execute: Boolean;
   procedure SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParamsPrim);
   function SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
   procedure SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
   function SearchParameters_IsQuerySaved_Execute: Boolean;
   procedure SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_SetQuery_Execute(const aQuery: IQuery);
   procedure SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
   procedure ContextParams_ContextChanged_Execute(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget);
   procedure ContextParams_ContextChanged(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_ClearQuery_Execute;
   procedure SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimOldSituationSearchForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , Windows
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , DataAdapter
 , nsQuery
 , l3InterfacesMisc
 , nsQueryUtils
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimOldSituationSearch_cutOldKeyWord_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки cutOldKeyWordLocalConstants }
 str_cutOldKeyWordCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordCaption'; rValue : 'Поиск по ситуации');
  {* Заголовок пользовательского типа "Поиск по ситуации" }
 str_cutOldKeyWordSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
  {* Заголовок пользовательского типа "Поиск по ситуации" для настройки панелей инструментов }

function TPrimOldSituationSearchForm.FillQuery: IQuery;
//#UC START# *52442A050274_4AE8831A02A5_var*
//#UC END# *52442A050274_4AE8831A02A5_var*
begin
//#UC START# *52442A050274_4AE8831A02A5_impl*
 if (f_FormState.Query <> nil) then
  Result := f_FormState.Query
 else
 begin
  f_FormState.Query := DefDataAdapter.CreateEmptyQuery(QT_KEYWORD);
  Result := f_FormState.Query;
 end;//f_FormState.Query <> nil

 // Добавляем выбранные элементы в Query
 if (Result <> nil) then
  Op_AttributeTree_SaveToQuery.Call(Aggregate, Result);
//#UC END# *52442A050274_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.FillQuery

procedure TPrimOldSituationSearchForm.ContextFilterChange(Sender: TObject);
//#UC START# *5245624602AE_4AE8831A02A5_var*
//#UC END# *5245624602AE_4AE8831A02A5_var*
begin
//#UC START# *5245624602AE_4AE8831A02A5_impl*
 Op_Context_SetContext.Call(Aggregate, ContextFilter.MakeState);
//#UC END# *5245624602AE_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.ContextFilterChange

procedure TPrimOldSituationSearchForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *524562520333_4AE8831A02A5_var*
//#UC END# *524562520333_4AE8831A02A5_var*
begin
//#UC START# *524562520333_4AE8831A02A5_impl*
 nsBeepWrongContext;
//#UC END# *524562520333_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.ContextFilterWrongContext

procedure TPrimOldSituationSearchForm.AfterInit(var Message: TMessage);
//#UC START# *524565FD004E_4AE8831A02A5_var*
var
 l_C : TControl;  
//#UC END# *524565FD004E_4AE8831A02A5_var*
begin
//#UC START# *524565FD004E_4AE8831A02A5_impl*
 if (MainZone.ControlCount > 0) then
 begin
  l_C := MainZone.Controls[0];
  if (l_C is TvcmEntityForm) then
   if TvcmEntityForm(l_C).CanFocus then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=271749118
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=271749118&focusedCommentId=274468233#comment-274468233
    TvcmEntityForm(l_C).SetFocus;
 end;//MainZone.ControlCount > 0
//#UC END# *524565FD004E_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.AfterInit

function TPrimOldSituationSearchForm.SearchParameters_IsQueryEmpty_Execute: Boolean;
//#UC START# *4AE879D00143_4AE8831A02A5exec_var*
//#UC END# *4AE879D00143_4AE8831A02A5exec_var*
begin
//#UC START# *4AE879D00143_4AE8831A02A5exec_impl*
 Result := false;
//#UC END# *4AE879D00143_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_IsQueryEmpty_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_IsQueryEmpty_Params) do
  ResultValue := Self.SearchParameters_IsQueryEmpty_Execute;
end;//TPrimOldSituationSearchForm.SearchParameters_IsQueryEmpty

function TPrimOldSituationSearchForm.SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
//#UC START# *4AE884E803AA_4AE8831A02A5exec_var*
//#UC END# *4AE884E803AA_4AE8831A02A5exec_var*
begin
//#UC START# *4AE884E803AA_4AE8831A02A5exec_impl*
 l3FillChar(Result, SizeOf(Result));
 if (f_FormState.Query <> nil) then
  f_FormState.Query.Clear;
 Result.rQuery := FillQuery;
 if (f_FormState.Filter <> nil) then
  Result.rFilter := f_FormState.Filter
 else
  Result.rAskFilters := true; 
//#UC END# *4AE884E803AA_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_GetQuery_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_GetQuery_Params) do
  ResultValue := Self.SearchParameters_GetQuery_Execute(IgnoreError);
end;//TPrimOldSituationSearchForm.SearchParameters_GetQuery

function TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved_Execute: Boolean;
//#UC START# *4AE8A577027D_4AE8831A02A5exec_var*
//#UC END# *4AE8A577027D_4AE8831A02A5exec_var*
begin
//#UC START# *4AE8A577027D_4AE8831A02A5exec_impl*
 Result := nsIsQuerySaved(f_FormState.Query);
//#UC END# *4AE8A577027D_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_IsQuerySaved_Params) do
  ResultValue := Self.SearchParameters_IsQuerySaved_Execute;
end;//TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved

procedure TPrimOldSituationSearchForm.SearchParameters_SetQuery_Execute(const aQuery: IQuery);
//#UC START# *4AEF213001F0_4AE8831A02A5exec_var*
//#UC END# *4AEF213001F0_4AE8831A02A5exec_var*
begin
//#UC START# *4AEF213001F0_4AE8831A02A5exec_impl*
 f_FormState.Query := nil;

 // Очищаем текущие выбранные значения
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, true, true);

 if (aQuery <> nil) then
 begin
  f_FormState.Query := aQuery;
  op_AttributeTree_LoadQuery.Call(Aggregate, f_FormState.Query);
 end;//aQuery <> nil
//#UC END# *4AEF213001F0_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_SetQuery_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_SetQuery_Params) do
  Self.SearchParameters_SetQuery_Execute(Query);
end;//TPrimOldSituationSearchForm.SearchParameters_SetQuery

procedure TPrimOldSituationSearchForm.ContextParams_ContextChanged_Execute(const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget);
//#UC START# *4AF4008101F4_4AE8831A02A5exec_var*
//#UC END# *4AF4008101F4_4AE8831A02A5exec_var*
begin
//#UC START# *4AF4008101F4_4AE8831A02A5exec_impl*
 ContextFilter.AssignState(aContextState);
 Assert(Assigned(aContextTarget));
 ContextFilter.UpdateIsContextWrong(aContextTarget);
//#UC END# *4AF4008101F4_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.ContextParams_ContextChanged_Execute

procedure TPrimOldSituationSearchForm.ContextParams_ContextChanged(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IContextParams_ContextChanged_Params) do
  Self.ContextParams_ContextChanged_Execute(ContextState, ContextTarget);
end;//TPrimOldSituationSearchForm.ContextParams_ContextChanged

procedure TPrimOldSituationSearchForm.SearchParameters_ClearQuery_Execute;
//#UC START# *4AF92B09017F_4AE8831A02A5exec_var*
//#UC END# *4AF92B09017F_4AE8831A02A5exec_var*
begin
//#UC START# *4AF92B09017F_4AE8831A02A5exec_impl*
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, true, true);
 // Очищаем поле фильтра
 f_FormState.Filter := nil;
//#UC END# *4AF92B09017F_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_ClearQuery_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameters_ClearQuery_Execute;
end;//TPrimOldSituationSearchForm.SearchParameters_ClearQuery

procedure TPrimOldSituationSearchForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AE8831A02A5_var*
//#UC END# *479731C50290_4AE8831A02A5_var*
begin
//#UC START# *479731C50290_4AE8831A02A5_impl*
 f_FormState := nil;
 inherited;
//#UC END# *479731C50290_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.Cleanup

procedure TPrimOldSituationSearchForm.InitFields;
//#UC START# *47A042E100E2_4AE8831A02A5_var*
var
 l_FormState : TnsQueryFormState;
//#UC END# *47A042E100E2_4AE8831A02A5_var*
begin
//#UC START# *47A042E100E2_4AE8831A02A5_impl*
 inherited;
 ContextFilter.Images := dmStdRes.SmallImageList;
 l_FormState := TnsQueryFormState.Create;
 try
  Supports(l_FormState, InsQueryFormState, f_FormState);
 finally
  vcmFree(l_FormState);
 end;
//#UC END# *47A042E100E2_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.InitFields

function TPrimOldSituationSearchForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_4AE8831A02A5_var*
//#UC END# *49806ED503D5_4AE8831A02A5_var*
begin
//#UC START# *49806ED503D5_4AE8831A02A5_impl*
 if aStateType = vcm_stContent then
  theState := f_FormState as IvcmBase;
//#UC END# *49806ED503D5_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.DoSaveState

function TPrimOldSituationSearchForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4AE8831A02A5_var*
//#UC END# *49807428008C_4AE8831A02A5_var*
begin
//#UC START# *49807428008C_4AE8831A02A5_impl*
 if aStateType = vcm_stContent then
  if not l3BQueryInterface(aState, InsQueryFormState, f_FormState) then
   Assert(False);
//#UC END# *49807428008C_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.DoLoadState

procedure TPrimOldSituationSearchForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AE8831A02A5_var*
//#UC END# *4A8E8F2E0195_4AE8831A02A5_var*
begin
//#UC START# *4A8E8F2E0195_4AE8831A02A5_impl*
 ActiveControl := MainZone;
 Scaled := False;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with ContextFilter do
 begin
  ImageIndex := 77;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;
 with InnerBackgroundPanel do
 begin
  TabOrder := 1;
 end;
 with BotomPanel do
 begin
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with ParentZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with ZoneContainer do
 begin
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
 with ChildZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
 with MainZone do
 begin
  ResizeAreaWidth := 5;
  SizeableSides := [szRight];
  SplitterBevel := bvRaised;
  Align := alLeft;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
//#UC END# *4A8E8F2E0195_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.InitControls

procedure TPrimOldSituationSearchForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AE8831A02A5_var*
//#UC END# *4F7C65380244_4AE8831A02A5_var*
begin
//#UC START# *4F7C65380244_4AE8831A02A5_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=271749118&focusedCommentId=290954110&#comment-290954110
 PostMessage(Handle, CM_AFTER_INIT, 0, 0);
//#UC END# *4F7C65380244_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.FormInsertedIntoContainer

procedure TPrimOldSituationSearchForm.ClearFields;
begin
 f_FormState := nil;
 inherited;
end;//TPrimOldSituationSearchForm.ClearFields

initialization
 str_cutOldKeyWordCaption.Init;
 {* Инициализация str_cutOldKeyWordCaption }
 str_cutOldKeyWordSettingsCaption.Init;
 {* Инициализация str_cutOldKeyWordSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimOldSituationSearchForm);
 {* Регистрация PrimOldSituationSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
