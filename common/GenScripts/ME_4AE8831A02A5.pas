unit PrimOldSituationSearch_Form;
 {* Поиск по ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_Form.pas"
// Стереотип: "VCMContainer"

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
 , Messages
 , SearchUnit
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

 TPrimOldSituationSearchForm = {abstract} class(TvcmContainerForm)
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
   procedure AfterInit(var Message: TMessage);
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
   function IsQueryEmpty: Boolean; override;
   function GetQuery: TnsQueryInfo; override;
   function IsQuerySaved: Boolean; override;
   procedure SetQuery; override;
   procedure ContextChanged; override;
   procedure ClearQuery; override;
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
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
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
;

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

function TPrimOldSituationSearchForm.IsQueryEmpty: Boolean;
//#UC START# *4AE879D00143_4AE8831A02A5_var*
//#UC END# *4AE879D00143_4AE8831A02A5_var*
begin
//#UC START# *4AE879D00143_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE879D00143_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.IsQueryEmpty

function TPrimOldSituationSearchForm.GetQuery: TnsQueryInfo;
//#UC START# *4AE884E803AA_4AE8831A02A5_var*
//#UC END# *4AE884E803AA_4AE8831A02A5_var*
begin
//#UC START# *4AE884E803AA_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE884E803AA_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.GetQuery

function TPrimOldSituationSearchForm.IsQuerySaved: Boolean;
//#UC START# *4AE8A577027D_4AE8831A02A5_var*
//#UC END# *4AE8A577027D_4AE8831A02A5_var*
begin
//#UC START# *4AE8A577027D_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8A577027D_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.IsQuerySaved

procedure TPrimOldSituationSearchForm.SetQuery;
//#UC START# *4AEF213001F0_4AE8831A02A5_var*
//#UC END# *4AEF213001F0_4AE8831A02A5_var*
begin
//#UC START# *4AEF213001F0_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF213001F0_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.SetQuery

procedure TPrimOldSituationSearchForm.ContextChanged;
//#UC START# *4AF4008101F4_4AE8831A02A5_var*
//#UC END# *4AF4008101F4_4AE8831A02A5_var*
begin
//#UC START# *4AF4008101F4_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF4008101F4_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.ContextChanged

procedure TPrimOldSituationSearchForm.ClearQuery;
//#UC START# *4AF92B09017F_4AE8831A02A5_var*
//#UC END# *4AF92B09017F_4AE8831A02A5_var*
begin
//#UC START# *4AF92B09017F_4AE8831A02A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF92B09017F_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.ClearQuery

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

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AE8831A02A5_var*
//#UC END# *4F7C65380244_4AE8831A02A5_var*
begin
//#UC START# *4F7C65380244_4AE8831A02A5_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=271749118&focusedCommentId=290954110&#comment-290954110
 PostMessage(Handle, CM_AFTER_INIT, 0, 0);
//#UC END# *4F7C65380244_4AE8831A02A5_impl*
end;//TPrimOldSituationSearchForm.FormInsertedIntoContainer
{$IfEnd} // NOT Defined(NoVCM)

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
