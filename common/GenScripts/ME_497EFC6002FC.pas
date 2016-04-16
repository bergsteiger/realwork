unit PrimAttributeSelect_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimAttributeSelect" MUID: (497EFC6002FC)
// Имя типа: "TPrimAttributeSelectForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , SearchInterfaces
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 , l3Interfaces
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Parent

 // Child

 TPrimAttributeSelectForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel }
   f_SelectedZone: TvtSizeablePanel;
    {* Поле для свойства SelectedZone }
   f_ValuesZone: TvtPanel;
    {* Поле для свойства ValuesZone }
   {$If NOT Defined(Admin)}
   f_FormState: InsQueryFormState;
    {* Поле для свойства FormState }
   {$IfEnd} // NOT Defined(Admin)
   f_Tag: Il3CString;
    {* Поле для свойства Tag }
  protected
   dsAttributeSelect: IdsAttributeSelect;
  private
   procedure vcmContainerFormLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType;
    var Loaded: Boolean);
   procedure vcmContainerFormSaveState(out aState: IvcmBase;
    aStateType: TvcmStateType;
    var Saved: Boolean);
  protected
   {$If NOT Defined(Admin)}
   function pm_GetFormState: InsQueryFormState; virtual;
   {$IfEnd} // NOT Defined(Admin)
   function FillQuery(WithCreate: Boolean = True): IQuery;
   {$If NOT Defined(Admin)}
   function GetFormState: InsQueryFormState;
   {$IfEnd} // NOT Defined(Admin)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
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
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   function SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
   procedure SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
   function SearchParameters_IsQuerySaved_Execute: Boolean;
   procedure SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_SetQuery_Execute(const aQuery: IQuery);
   procedure SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
   procedure AttributeTree_SetRoot_Execute(const aTag: Il3CString);
   procedure AttributeTree_SetRoot(const aParams: IvcmExecuteParamsPrim);
   procedure SearchParameters_ClearQuery_Execute;
   procedure SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
   procedure Result_ClearAll_Test(const aParams: IvcmTestParamsPrim);
   procedure Result_ClearAll_Execute(const aParams: IvcmExecuteParamsPrim);
  protected
   {$If NOT Defined(Admin)}
   property FormState: InsQueryFormState
    read pm_GetFormState;
   {$IfEnd} // NOT Defined(Admin)
   property Tag: Il3CString
    read f_Tag;
    {* значение тега, которое можно выставить в vcmContainerFormChangedDataSource }
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
 end;//TPrimAttributeSelectForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 , PrimAttributeSelect_utSingleSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsNodes
 , nsAttributeTreeCacheNew
 {$If NOT Defined(Admin)}
 , nsQuery
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 , DynamicTreeUnit
 , DataAdapter
 , tasSaveLoadProxy
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimAttributeSelect_utAttributeSelect_UserType
;

{$If NOT Defined(NoVCM)}
type
 // ExludeForSingleSearch

const
 {* Локализуемые строки utAttributeSelectLocalConstants }
 str_utAttributeSelectCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utAttributeSelectCaption'; rValue : 'Выбор значения атрибута');
  {* Заголовок пользовательского типа "Выбор значения атрибута" }
 {* Локализуемые строки utSingleSearchLocalConstants }
 str_utSingleSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSingleSearchCaption'; rValue : 'Атомарный поиск');
  {* Заголовок пользовательского типа "Атомарный поиск" }

{$If NOT Defined(Admin)}
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
{$IfEnd} // NOT Defined(Admin)

procedure TPrimAttributeSelectForm.vcmContainerFormLoadState(const aState: IvcmBase;
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
end;//TPrimAttributeSelectForm.vcmContainerFormLoadState

procedure TPrimAttributeSelectForm.vcmContainerFormSaveState(out aState: IvcmBase;
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
end;//TPrimAttributeSelectForm.vcmContainerFormSaveState

function TPrimAttributeSelectForm.FillQuery(WithCreate: Boolean = True): IQuery;
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

{$If NOT Defined(Admin)}
function TPrimAttributeSelectForm.GetFormState: InsQueryFormState;
//#UC START# *51220C2B0092_497EFC6002FC_var*
//#UC END# *51220C2B0092_497EFC6002FC_var*
begin
//#UC START# *51220C2B0092_497EFC6002FC_impl*
 Result := FormState;
//#UC END# *51220C2B0092_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.GetFormState
{$IfEnd} // NOT Defined(Admin)

procedure TPrimAttributeSelectForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A8AD47D0357_497EFC6002FCtest_var*
//#UC END# *4A8AD47D0357_497EFC6002FCtest_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FCtest_impl*
 // - ничего не делаем
//#UC END# *4A8AD47D0357_497EFC6002FCtest_impl*
end;//TPrimAttributeSelectForm.Result_OkExt_Test

procedure TPrimAttributeSelectForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
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

procedure TPrimAttributeSelectForm.Result_OkExt_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A8AD47D0357_497EFC6002FCgetstate_var*
//#UC END# *4A8AD47D0357_497EFC6002FCgetstate_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FCgetstate_impl*
 State := st_user_Result_OkExt_AttributesSelect
//#UC END# *4A8AD47D0357_497EFC6002FCgetstate_impl*
end;//TPrimAttributeSelectForm.Result_OkExt_GetState

procedure TPrimAttributeSelectForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_497EFC6002FCtest_var*
//#UC END# *4AC5D61E0284_497EFC6002FCtest_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCtest_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_497EFC6002FCtest_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_Test

procedure TPrimAttributeSelectForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4AC5D61E0284_497EFC6002FCexec_var*
//#UC END# *4AC5D61E0284_497EFC6002FCexec_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCexec_impl*
 ModalResult := mrCancel;
//#UC END# *4AC5D61E0284_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_Execute

procedure TPrimAttributeSelectForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* Отмена }
//#UC START# *4AC5D61E0284_497EFC6002FCgetstate_var*
//#UC END# *4AC5D61E0284_497EFC6002FCgetstate_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FCgetstate_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_497EFC6002FCgetstate_impl*
end;//TPrimAttributeSelectForm.Result_Cancel_GetState

function TPrimAttributeSelectForm.SearchParameters_GetQuery_Execute(aIgnoreError: Boolean = False): TnsQueryInfo;
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

procedure TPrimAttributeSelectForm.SearchParameters_GetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_GetQuery_Params) do
  ResultValue := Self.SearchParameters_GetQuery_Execute(IgnoreError);
end;//TPrimAttributeSelectForm.SearchParameters_GetQuery

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

procedure TPrimAttributeSelectForm.SearchParameters_IsQuerySaved(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_IsQuerySaved_Params) do
  ResultValue := Self.SearchParameters_IsQuerySaved_Execute;
end;//TPrimAttributeSelectForm.SearchParameters_IsQuerySaved

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

procedure TPrimAttributeSelectForm.SearchParameters_SetQuery(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISearchParameters_SetQuery_Params) do
  Self.SearchParameters_SetQuery_Execute(Query);
end;//TPrimAttributeSelectForm.SearchParameters_SetQuery

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

procedure TPrimAttributeSelectForm.AttributeTree_SetRoot(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IAttributeTree_SetRoot_Params) do
  Self.AttributeTree_SetRoot_Execute(Tag);
end;//TPrimAttributeSelectForm.AttributeTree_SetRoot

procedure TPrimAttributeSelectForm.SearchParameters_ClearQuery_Execute;
//#UC START# *4AF92B09017F_497EFC6002FCexec_var*
//#UC END# *4AF92B09017F_497EFC6002FCexec_var*
begin
//#UC START# *4AF92B09017F_497EFC6002FCexec_impl*
 Op_AttributeTree_DropAllLogicSelection.Call(Aggregate, True, True, False);
//#UC END# *4AF92B09017F_497EFC6002FCexec_impl*
end;//TPrimAttributeSelectForm.SearchParameters_ClearQuery_Execute

procedure TPrimAttributeSelectForm.SearchParameters_ClearQuery(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchParameters_ClearQuery_Execute;
end;//TPrimAttributeSelectForm.SearchParameters_ClearQuery

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
 {* Функция очистки полей объекта. }
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

procedure TPrimAttributeSelectForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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

procedure TPrimAttributeSelectForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_497EFC6002FC_var*
//#UC END# *49803F5503AA_497EFC6002FC_var*
begin
//#UC START# *49803F5503AA_497EFC6002FC_impl*
 inherited;
 CCaption := nil;
//#UC END# *49803F5503AA_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.DoInit

procedure TPrimAttributeSelectForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimAttributeSelectForm.ClearFields;
begin
 {$If NOT Defined(Admin)}
 f_FormState := nil;
 {$IfEnd} // NOT Defined(Admin)
 f_Tag := nil;
 inherited;
end;//TPrimAttributeSelectForm.ClearFields

initialization
 str_utAttributeSelectCaption.Init;
 {* Инициализация str_utAttributeSelectCaption }
 str_utSingleSearchCaption.Init;
 {* Инициализация str_utSingleSearchCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimAttributeSelectForm);
 {* Регистрация PrimAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
