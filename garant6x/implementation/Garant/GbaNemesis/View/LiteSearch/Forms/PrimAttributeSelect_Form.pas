unit PrimAttributeSelect_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelect_Form.pas"
// Начат: 27.01.2009 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimAttributeSelect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SearchUnit,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  SearchInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls,
  l3StringIDEx,
  PrimAttributeSelect_utAttributeSelect_UserType,
  PrimAttributeSelect_utSingleSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmEntityForm {a},
  vcmContainerForm {a}
  ;

type
 TPrimAttributeSelectForm = {form} class(TvcmContainerForm)
 private
 // private fields
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_SelectedZone : TvtSizeablePanel;
    {* Поле для свойства SelectedZone}
   f_ValuesZone : TvtPanel;
    {* Поле для свойства ValuesZone}
  {$If not defined(Admin)}
   f_FormState : InsQueryFormState;
    {* Поле для свойства FormState}
  {$IfEnd} //not Admin
   f_Tag : Il3CString;
    {* Поле для свойства Tag}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure VcmContainerFormLoadState(const aState: IvcmBase;
     aStateType: TvcmStateType;
     var Loaded: Boolean);
   procedure VcmContainerFormSaveState(out aState: IvcmBase;
     aStateType: TvcmStateType;
     var Saved: Boolean);
 protected
 // property methods
   {$If not defined(Admin)}
   function pm_GetFormState: InsQueryFormState; virtual;
   {$IfEnd} //not Admin
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   function SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = false): TnsQueryInfo;
   procedure SearchParameters_GetQuery(const aParams: IvcmExecuteParams);
   function SearchParameters_IsQuerySaved_Execute: Boolean;
   procedure SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParams);
   procedure SearchParameters_SetQuery_Execute(const aQuery: IQuery);
   procedure SearchParameters_SetQuery(const aParams: IvcmExecuteParams);
   procedure AttributeTree_SetRoot_Execute(const aTag: Il3CString);
   procedure AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
   procedure SearchParameters_ClearQuery_Execute;
   procedure SearchParameters_ClearQuery(const aParams: IvcmExecuteParams);
   procedure Result_ClearAll_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
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
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   dsAttributeSelect : IdsAttributeSelect;
 protected
 // protected methods
   function FillQuery(WithCreate: Boolean = true): IQuery;
    {$If not defined(Admin)}
   function GetFormState: InsQueryFormState;
    {$IfEnd} //not Admin
 protected
 // protected properties
    {$If not defined(Admin)}
   property FormState: InsQueryFormState
     read pm_GetFormState;
    {$IfEnd} //not Admin
   property Tag: Il3CString
     read f_Tag;
     {* значение тега, которое можно выставить в vcmContainerFormChangedDataSource }
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read f_BackgroundPanel;
   property SelectedZone: TvtSizeablePanel
     read f_SelectedZone;
   property ValuesZone: TvtPanel
     read f_ValuesZone;
 end;//TPrimAttributeSelectForm

implementation

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsNodes,
  nsAttributeTreeCacheNew
  {$If not defined(Admin)}
  ,
  nsQuery
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3String,
  DynamicTreeUnit,
  DataAdapter,
  tasSaveLoadProxy,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a},
  SysUtils {a}
  ;

var
   { Локализуемые строки utAttributeSelectLocalConstants }
  str_utAttributeSelectCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAttributeSelectCaption'; rValue : 'Выбор значения атрибута');
   { Заголовок пользовательского типа "Выбор значения атрибута" }

var
   { Локализуемые строки utSingleSearchLocalConstants }
  str_utSingleSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSingleSearchCaption'; rValue : 'Атомарный поиск');
   { Заголовок пользовательского типа "Атомарный поиск" }

// start class TPrimAttributeSelectForm

procedure TPrimAttributeSelectForm.VcmContainerFormLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType;
  var Loaded: Boolean);
//#UC START# *511FAA24016D_497EFC6002FC_var*
//#UC END# *511FAA24016D_497EFC6002FC_var*
begin
//#UC START# *511FAA24016D_497EFC6002FC_impl*
 {$If not Defined(Admin)}
 if (aStateType = vcm_stContent) then
 begin
  Supports(aState, InsQueryFormState, f_FormState);
  Assert(f_FormState <> nil);
 end;//if (aStateType = vcm_stContent) then
 {$Else}
 Loaded := false;
 {$IfEnd}
//#UC END# *511FAA24016D_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.VcmContainerFormLoadState

procedure TPrimAttributeSelectForm.VcmContainerFormSaveState(out aState: IvcmBase;
  aStateType: TvcmStateType;
  var Saved: Boolean);
//#UC START# *511FA9C8030E_497EFC6002FC_var*
//#UC END# *511FA9C8030E_497EFC6002FC_var*
begin
//#UC START# *511FA9C8030E_497EFC6002FC_impl*
 {$If not Defined(Admin)}
 if aStateType = vcm_stContent then
 aState := FormState as IvcmBase;
 {$Else}
 Saved := false;
 {$IfEnd}
//#UC END# *511FA9C8030E_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.VcmContainerFormSaveState

function TPrimAttributeSelectForm.FillQuery(WithCreate: Boolean = true): IQuery;
//#UC START# *51220BFE013D_497EFC6002FC_var*
var
 l_Type: TQueryType;
//#UC END# *51220BFE013D_497EFC6002FC_var*
begin
//#UC START# *51220BFE013D_497EFC6002FC_impl*
 {$If not Defined(Admin)}
 if not l3IsNil(f_Tag) then
  FormState.Tag := f_Tag;
 if (FormState.Query <> nil) then
  Result := FormState.Query
 else
  if WithCreate then
  begin
   if (f_Tag = nil) AND (dsAttributeSelect = nil) AND (UserType = utSingleSearch) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=263293561
    l_Type := QT_PUBLISHED_SOURCE
   else
   begin
    Assert(f_Tag <> nil, 'http://mdp.garant.ru/pages/viewpage.action?pageId=228688510&focusedCommentId=256934628#comment-256934628');
    if (l3Same(FormState.Tag, AT_KW)) then
     l_Type := QT_KEYWORD
    else
    if (l3Same(FormState.Tag, AT_PUBLISH_SOURCE)) then
     l_Type := QT_PUBLISHED_SOURCE
    else
     l_Type := QT_ATTRIBUTE;
   end;//f_Tag = nil..
   FormState.Query := DefDataAdapter.CreateEmptyQuery(l_Type);
   Result := FormState.Query;
  end//WithCreate
  else
   Result := nil;
 // Добавляем выбранные элементы в Query
 if (Result <> nil) then
  Op_AttributeTree_SaveToQuery.Call(Aggregate, Result);
 {$Else}
 Result := nil;
 Assert(false);
 {$IfEnd}
//#UC END# *51220BFE013D_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.FillQuery

{$If not defined(Admin)}
function TPrimAttributeSelectForm.GetFormState: InsQueryFormState;
//#UC START# *51220C2B0092_497EFC6002FC_var*
//#UC END# *51220C2B0092_497EFC6002FC_var*
begin
//#UC START# *51220C2B0092_497EFC6002FC_impl*
 Result := FormState;
//#UC END# *51220C2B0092_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.GetFormState
{$IfEnd} //not Admin

{$If not defined(Admin)}
function TPrimAttributeSelectForm.pm_GetFormState: InsQueryFormState;
//#UC START# *5121EE47013D_497EFC6002FCget_var*
//#UC END# *5121EE47013D_497EFC6002FCget_var*
begin
//#UC START# *5121EE47013D_497EFC6002FCget_impl*
 if f_FormState = nil then
  f_FormState := TnsQueryFormState.Make;
 Result := f_FormState;
//#UC END# *5121EE47013D_497EFC6002FCget_impl*
end;//TPrimAttributeSelectForm.pm_GetFormState
{$IfEnd} //not Admin

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD47D0357_497EFC6002FCtest_var*
//#UC END# *4A8AD47D0357_497EFC6002FCtest_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FCtest_impl*
 // - ничего не делаем
//#UC END# *4A8AD47D0357_497EFC6002FCtest_impl*
end;//TPrimAttributeSelectForm.Result_OkExt_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_OkExt_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A8AD47D0357_497EFC6002FCgetstate_var*
//#UC END# *4A8AD47D0357_497EFC6002FCgetstate_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FCgetstate_impl*
 State := st_user_Result_OkExt_AttributesSelect
//#UC END# *4A8AD47D0357_497EFC6002FCgetstate_impl*
end;//TPrimAttributeSelectForm.Result_OkExt_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD47D0357_497EFC6002FCexec_var*
//#UC END# *4A8AD47D0357_497EFC6002FCexec_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FCexec_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290259092
 // if not (UserType in [utAttributeSelect]) then // отключаем условие, а то http://mdp.garant.ru/pages/viewpage.action?pageId=327812892
 Op_AttributeTree_AddNodeIfEmpty.Call(Aggregate);

 ModalResult := mrOk;
//#UC END# *4A8AD47D0357_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.Result_OkExt_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AC5D61E0284_497EFC6002FCtest_var*
//#UC END# *4AC5D61E0284_497EFC6002FCtest_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCtest_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_497EFC6002FCtest_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4AC5D61E0284_497EFC6002FCgetstate_var*
//#UC END# *4AC5D61E0284_497EFC6002FCgetstate_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCgetstate_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_497EFC6002FCgetstate_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AC5D61E0284_497EFC6002FCexec_var*
//#UC END# *4AC5D61E0284_497EFC6002FCexec_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCexec_impl*
 ModalResult := mrCancel;
//#UC END# *4AC5D61E0284_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

function TPrimAttributeSelectForm.SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = false): TnsQueryInfo;
//#UC START# *4AE884E803AA_497EFC6002FCexec_var*
//#UC END# *4AE884E803AA_497EFC6002FCexec_var*
begin
//#UC START# *4AE884E803AA_497EFC6002FCexec_impl*
 {$If not Defined(Admin)}
 l3FillChar(Result, SizeOf(Result));
 if (GetFormState.Query <> nil) then
  GetFormState.Query.Clear;
 Result.rQuery := FillQuery;
 Result.rAskFilters := true;
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *4AE884E803AA_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.SearchParameters_GetQuery_Execute

procedure TPrimAttributeSelectForm.SearchParameters_GetQuery(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_GetQuery_Params) do
  ResultValue := SearchParameters_GetQuery_Execute(IgnoreError);
end;

function TPrimAttributeSelectForm.SearchParameters_IsQuerySaved_Execute: Boolean;
//#UC START# *4AE8A577027D_497EFC6002FCexec_var*
//#UC END# *4AE8A577027D_497EFC6002FCexec_var*
begin
//#UC START# *4AE8A577027D_497EFC6002FCexec_impl*
 {$If not Defined(Admin)}
 Result := //nsIsQuerySaved(GetFormState.Query);
           TtasSaveLoadProxy.Instance.IsQuerySaved(GetFormState.Query);
 {$Else}
 Result := false;
 Assert(false);
 {$IfEnd}
//#UC END# *4AE8A577027D_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.SearchParameters_IsQuerySaved_Execute

procedure TPrimAttributeSelectForm.SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_IsQuerySaved_Params) do
  ResultValue := SearchParameters_IsQuerySaved_Execute;
end;

procedure TPrimAttributeSelectForm.SearchParameters_SetQuery_Execute(const aQuery: IQuery);
//#UC START# *4AEF213001F0_497EFC6002FCexec_var*
//#UC END# *4AEF213001F0_497EFC6002FCexec_var*
begin
//#UC START# *4AEF213001F0_497EFC6002FCexec_impl*
 {$If not Defined(Admin)}
 GetFormState.Query := nil;

 // Очищаем текущие выбранные значения
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, True, True);

 if (aQuery <> nil) then
 begin
  GetFormState.Query := aQuery;
  // Заполняем список выбранных значений из Query
  op_AttributeTree_LoadQuery.Call(Aggregate, GetFormState.Query);
 end;//aQuery <> nil
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *4AEF213001F0_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.SearchParameters_SetQuery_Execute

procedure TPrimAttributeSelectForm.SearchParameters_SetQuery(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISearchParameters_SetQuery_Params) do
  SearchParameters_SetQuery_Execute(Query);
end;

procedure TPrimAttributeSelectForm.AttributeTree_SetRoot_Execute(const aTag: Il3CString);
//#UC START# *4AF3EBC001C4_497EFC6002FCexec_var*
//#UC END# *4AF3EBC001C4_497EFC6002FCexec_var*
begin
//#UC START# *4AF3EBC001C4_497EFC6002FCexec_impl*
 {$ifndef admin}
 GetFormState.Tag := aTag;
 {$endif}
 if (UserType = utAttributeSelect) then
  CCaption := nsGetCaption(TnsAttributeTreeCacheNew.Instance.AttributeRoot[aTag]);
//#UC END# *4AF3EBC001C4_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.AttributeTree_SetRoot_Execute

procedure TPrimAttributeSelectForm.AttributeTree_SetRoot(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IAttributeTree_SetRoot_Params) do
  AttributeTree_SetRoot_Execute(Tag);
end;

procedure TPrimAttributeSelectForm.SearchParameters_ClearQuery_Execute;
//#UC START# *4AF92B09017F_497EFC6002FCexec_var*
//#UC END# *4AF92B09017F_497EFC6002FCexec_var*
begin
//#UC START# *4AF92B09017F_497EFC6002FCexec_impl*
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, True, True, False);
//#UC END# *4AF92B09017F_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.SearchParameters_ClearQuery_Execute

procedure TPrimAttributeSelectForm.SearchParameters_ClearQuery(const aParams: IvcmExecuteParams);
begin
 SearchParameters_ClearQuery_Execute;
end;

procedure TPrimAttributeSelectForm.Result_ClearAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2DFEE000BA_497EFC6002FCtest_var*
//#UC END# *4C2DFEE000BA_497EFC6002FCtest_var*
begin
//#UC START# *4C2DFEE000BA_497EFC6002FCtest_impl*
 // - ничего не делаем
//#UC END# *4C2DFEE000BA_497EFC6002FCtest_impl*
end;//TPrimAttributeSelectForm.Result_ClearAll_Test

procedure TPrimAttributeSelectForm.Result_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2DFEE000BA_497EFC6002FCexec_var*
//#UC END# *4C2DFEE000BA_497EFC6002FCexec_var*
begin
//#UC START# *4C2DFEE000BA_497EFC6002FCexec_impl*
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, True, True, False);
//#UC END# *4C2DFEE000BA_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.Result_ClearAll_Execute

procedure TPrimAttributeSelectForm.Cleanup;
//#UC START# *479731C50290_497EFC6002FC_var*
//#UC END# *479731C50290_497EFC6002FC_var*
begin
//#UC START# *479731C50290_497EFC6002FC_impl*
 f_Tag := nil;
 {$ifndef admin}
 f_FormState := nil;
 {$endif}
 inherited;
//#UC END# *479731C50290_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.Cleanup

procedure TPrimAttributeSelectForm.InitFields;
//#UC START# *47A042E100E2_497EFC6002FC_var*
//#UC END# *47A042E100E2_497EFC6002FC_var*
begin
//#UC START# *47A042E100E2_497EFC6002FC_impl*
 inherited; 

 OnLoadState := vcmContainerFormLoadState;
 OnSaveState := vcmContainerFormSaveState;
//#UC END# *47A042E100E2_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497EFC6002FC_var*
//#UC END# *497469C90140_497EFC6002FC_var*
begin
//#UC START# *497469C90140_497EFC6002FC_impl*
 inherited;
 if (dsAttributeSelect <> nil) then
  with dsAttributeSelect.Search do
  begin
   f_Tag := Tag;
   {$If not Defined(Admin)}
   FormState.Query := Query;
   {$IfEnd}
  end;//with dsAttributeSelect.Search do
//#UC END# *497469C90140_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_497EFC6002FC_var*
//#UC END# *49803F5503AA_497EFC6002FC_var*
begin
//#UC START# *49803F5503AA_497EFC6002FC_impl*
 inherited;
 CCaption := nil;
//#UC END# *49803F5503AA_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimAttributeSelectForm.InitControls;
//#UC START# *4A8E8F2E0195_497EFC6002FC_var*
//#UC END# *4A8E8F2E0195_497EFC6002FC_var*
begin
//#UC START# *4A8E8F2E0195_497EFC6002FC_impl*
 Width := 640;
 Height := 480;

 BackgroundPanel.Align := alClient;
 with ValuesZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinHeight := 100;
 end;
 with SelectedZone do
 begin
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  BevelOuter := bvNone;
  Height := 200;
 end;
//#UC END# *4A8E8F2E0195_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimAttributeSelectForm.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_FormState := nil;
 {$IfEnd} //not Admin
 f_Tag := nil;
 inherited;
end;//TPrimAttributeSelectForm.ClearFields

procedure TPrimAttributeSelectForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsAttributeSelect := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsAttributeSelect, dsAttributeSelect);
 end;//aDsNew = nil
end;

procedure TPrimAttributeSelectForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_SearchParameters, nil);
  PublishFormEntity(en_AttributeTree, nil);
  ToolbarAtBottom(en_Result);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, Result_OkExt_GetState);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_SearchParameters, op_GetQuery, SearchParameters_GetQuery, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_IsQuerySaved, SearchParameters_IsQuerySaved, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_SetQuery, SearchParameters_SetQuery, nil, nil);
  PublishOpWithResult(en_AttributeTree, op_SetRoot, AttributeTree_SetRoot, nil, nil);
  PublishOpWithResult(en_SearchParameters, op_ClearQuery, SearchParameters_ClearQuery, nil, nil);
  PublishOp(en_Result, op_ClearAll, Result_ClearAll_Execute, Result_ClearAll_Test, nil);
 end;//with Entities.Entities
 {$If not defined(NoVCM)}
 AddUserTypeExclude(utSingleSearchName, en_Result, op_OkExt, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(utSingleSearchName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(utSingleSearchName, en_Result, op_ClearAll, false);
end;

procedure TPrimAttributeSelectForm.MakeControls;
begin
 inherited;
 with AddUsertype(utAttributeSelectName,
  str_utAttributeSelectCaption,
  str_utAttributeSelectCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utAttributeSelectName
 with AddUsertype(utSingleSearchName,
  str_utSingleSearchCaption,
  str_utSingleSearchCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utSingleSearchName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_SelectedZone := TvtSizeablePanel.Create(Self);
 f_SelectedZone.Name := 'SelectedZone';
 f_SelectedZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, f_SelectedZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_SelectedZone)
 f_ValuesZone := TvtPanel.Create(Self);
 f_ValuesZone.Name := 'ValuesZone';
 f_ValuesZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, f_ValuesZone) do
 begin
 end;//with DefineZone(vcm_ztParent, f_ValuesZone)
end;

initialization
// Инициализация str_utAttributeSelectCaption
 str_utAttributeSelectCaption.Init;
// Инициализация str_utSingleSearchCaption
 str_utSingleSearchCaption.Init;
{$If not defined(NoScripts)}
// Регистрация PrimAttributeSelect
 TtfwClassRef.Register(TPrimAttributeSelectForm);
{$IfEnd} //not NoScripts

end.