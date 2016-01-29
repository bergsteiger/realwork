unit PrimOldSituationSearch_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimOldSituationSearch_Form.pas"
// Начат: 28.10.2009 20:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Search::View::Search::PrimOldSituationSearch
//
// Поиск по ситуации
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
  SearchUnit,
  nsQueryInterfaces,
  Messages,
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  SearchLite_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimOldSituationSearch_cutOldKeyWord_UserType
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  Controls {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
  { OldSituationSearch_Form msg }
 CM_AFTER_INIT = WM_USER + 201;

type
 TPrimOldSituationSearchForm = {abstract form} class(TvcmContainerForm)
  {* Поиск по ситуации }
 private
 // private fields
   f_BackgroundPanel : TvtPanel;
    {* Поле для свойства BackgroundPanel}
   f_ContextFilter : TnscContextFilter;
    {* Поле для свойства ContextFilter}
   f_InnerBackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства InnerBackgroundPanel}
   f_BotomPanel : TvtSizeablePanel;
    {* Поле для свойства BotomPanel}
   f_ParentZone : TvtPanel;
    {* Поле для свойства ParentZone}
   f_ZoneContainer : TvtProportionalPanel;
    {* Поле для свойства ZoneContainer}
   f_ChildZone : TvtPanel;
    {* Поле для свойства ChildZone}
   f_MainZone : TvtSizeablePanel;
    {* Поле для свойства MainZone}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ContextFilterChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ContextFilterWrongContext(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure AfterInit(var Message: TMessage); message CM_AFTER_INIT;
 protected
 // realized methods
   function SearchParameters_IsQueryEmpty_Execute: Boolean;
   procedure SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParams);
   function SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = false): TnsQueryInfo;
   procedure SearchParameters_GetQuery(const aParams: IvcmExecuteParams);
   function SearchParameters_IsQuerySaved_Execute: Boolean;
   procedure SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParams);
   procedure SearchParameters_SetQuery_Execute(const aQuery: IQuery);
   procedure SearchParameters_SetQuery(const aParams: IvcmExecuteParams);
   procedure ContextParams_ContextChanged_Execute(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget);
   procedure ContextParams_ContextChanged(const aParams: IvcmExecuteParams);
   procedure SearchParameters_ClearQuery_Execute;
   procedure SearchParameters_ClearQuery(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
    {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_FormState : InsQueryFormState;
 protected
 // protected methods
   function FillQuery: IQuery;
 public
 // public properties
   property BackgroundPanel: TvtPanel
     read f_BackgroundPanel;
   property ContextFilter: TnscContextFilter
     read f_ContextFilter;
   property InnerBackgroundPanel: TvtProportionalPanel
     read f_InnerBackgroundPanel;
   property BotomPanel: TvtSizeablePanel
     read f_BotomPanel;
   property ParentZone: TvtPanel
     read f_ParentZone;
   property ZoneContainer: TvtProportionalPanel
     read f_ZoneContainer;
   property ChildZone: TvtPanel
     read f_ChildZone;
   property MainZone: TvtSizeablePanel
     read f_MainZone;
 end;//TPrimOldSituationSearchForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  DataAdapter,
  nsQuery,
  l3InterfacesMisc,
  nsQueryUtils,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки cutOldKeyWordLocalConstants }
  str_cutOldKeyWordCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordCaption'; rValue : 'Поиск по ситуации');
   { Заголовок пользовательского типа "Поиск по ситуации" }
  str_cutOldKeyWordSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cutOldKeyWordSettingsCaption'; rValue : 'Поиск: По ситуации (Преемственный)');
   { Заголовок пользовательского типа "Поиск по ситуации" для настройки панелей инструментов }

// start class TPrimOldSituationSearchForm

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

procedure TPrimOldSituationSearchForm.SearchParameters_IsQueryEmpty(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_IsQueryEmpty_Params) do
  ResultValue := SearchParameters_IsQueryEmpty_Execute;
end;

function TPrimOldSituationSearchForm.SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = false): TnsQueryInfo;
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

procedure TPrimOldSituationSearchForm.SearchParameters_GetQuery(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_GetQuery_Params) do
  ResultValue := SearchParameters_GetQuery_Execute(IgnoreError);
end;

function TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved_Execute: Boolean;
//#UC START# *4AE8A577027D_4AE8831A02A5exec_var*
//#UC END# *4AE8A577027D_4AE8831A02A5exec_var*
begin
//#UC START# *4AE8A577027D_4AE8831A02A5exec_impl*
 Result := nsIsQuerySaved(f_FormState.Query);
//#UC END# *4AE8A577027D_4AE8831A02A5exec_impl*
end;//TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved_Execute

procedure TPrimOldSituationSearchForm.SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_IsQuerySaved_Params) do
  ResultValue := SearchParameters_IsQuerySaved_Execute;
end;

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

procedure TPrimOldSituationSearchForm.SearchParameters_SetQuery(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_SetQuery_Params) do
  SearchParameters_SetQuery_Execute(Query);
end;

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

procedure TPrimOldSituationSearchForm.ContextParams_ContextChanged(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IContextParams_ContextChanged_Params) do
  ContextParams_ContextChanged_Execute(ContextState, ContextTarget);
end;

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

procedure TPrimOldSituationSearchForm.SearchParameters_ClearQuery(const aParams: IvcmExecuteParams);
begin
 SearchParameters_ClearQuery_Execute;
end;

procedure TPrimOldSituationSearchForm.Cleanup;
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

{$If not defined(NoVCM)}
function TPrimOldSituationSearchForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_4AE8831A02A5_var*
//#UC END# *49806ED503D5_4AE8831A02A5_var*
begin
//#UC START# *49806ED503D5_4AE8831A02A5_impl*
 if aStateType = vcm_stContent then
  theState := f_FormState as IvcmBase;
//#UC END# *49806ED503D5_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.DoSaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimOldSituationSearchForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_4AE8831A02A5_var*
//#UC END# *49807428008C_4AE8831A02A5_var*
begin
//#UC START# *49807428008C_4AE8831A02A5_impl*
 if aStateType = vcm_stContent then
  if not l3BQueryInterface(aState, InsQueryFormState, f_FormState) then
   Assert(False);
//#UC END# *49807428008C_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.DoLoadState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimOldSituationSearchForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimOldSituationSearchForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AE8831A02A5_var*
//#UC END# *4F7C65380244_4AE8831A02A5_var*
begin
//#UC START# *4F7C65380244_4AE8831A02A5_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=271749118&focusedCommentId=290954110&#comment-290954110
 PostMessage(Handle, CM_AFTER_INIT, 0, 0);
//#UC END# *4F7C65380244_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.FormInsertedIntoContainer
{$IfEnd} //not NoVCM

procedure TPrimOldSituationSearchForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_FormState := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimOldSituationSearchForm.ClearFields

procedure TPrimOldSituationSearchForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_SearchParameters, nil);
  PublishFormEntity(en_ContextParams, nil);
  PublishOpWithResult(en_SearchParameters, op_IsQueryEmpty, SearchParameters_IsQueryEmpty, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_GetQuery, SearchParameters_GetQuery, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_IsQuerySaved, SearchParameters_IsQuerySaved, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_SetQuery, SearchParameters_SetQuery, nil, nil);
  PublishOpWithResult(en_ContextParams, op_ContextChanged, ContextParams_ContextChanged, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_ClearQuery, SearchParameters_ClearQuery, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimOldSituationSearchForm.MakeControls;
begin
 inherited;
 with AddUsertype(cutOldKeyWordName,
  str_cutOldKeyWordCaption,
  str_cutOldKeyWordSettingsCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cutOldKeyWordName
 f_BackgroundPanel := TvtPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_ContextFilter := TnscContextFilter.Create(Self);
 f_ContextFilter.Name := 'ContextFilter';
 f_ContextFilter.Parent := BackgroundPanel;
 f_InnerBackgroundPanel := TvtProportionalPanel.Create(Self);
 f_InnerBackgroundPanel.Name := 'InnerBackgroundPanel';
 f_InnerBackgroundPanel.Parent := BackgroundPanel;
 f_BotomPanel := TvtSizeablePanel.Create(Self);
 f_BotomPanel.Name := 'BotomPanel';
 f_BotomPanel.Parent := InnerBackgroundPanel;
 f_ParentZone := TvtPanel.Create(Self);
 f_ParentZone.Name := 'ParentZone';
 f_ParentZone.Parent := BotomPanel;
 with DefineZone(vcm_ztParent, f_ParentZone) do
 begin
  FormStyle.Toolbars.Bottom.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztParent, f_ParentZone)
 f_ZoneContainer := TvtProportionalPanel.Create(Self);
 f_ZoneContainer.Name := 'ZoneContainer';
 f_ZoneContainer.Parent := InnerBackgroundPanel;
 f_ChildZone := TvtPanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := ZoneContainer;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_ChildZone)
 f_MainZone := TvtSizeablePanel.Create(Self);
 f_MainZone.Name := 'MainZone';
 f_MainZone.Parent := ZoneContainer;
 with DefineZone(vcm_ztMain, f_MainZone) do
 begin
 end;//with DefineZone(vcm_ztMain, f_MainZone)
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_cutOldKeyWordCaption
 str_cutOldKeyWordCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_cutOldKeyWordSettingsCaption
 str_cutOldKeyWordSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimOldSituationSearch
 TtfwClassRef.Register(TPrimOldSituationSearchForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.