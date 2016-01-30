unit PrimAttributeSelect_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

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
 , l3StringIDEx
 , PrimAttributeSelect_utSingleSearch_UserType
;

type
 // Parent

 // Child

 TPrimAttributeSelectForm = class
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
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetQuery: TnsQueryInfo; override;
   function IsQuerySaved: Boolean; override;
   procedure SetQuery; override;
   procedure SetRoot; override;
   procedure ClearQuery; override;
   procedure ClearAll; override;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
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
;

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

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectForm.OkExt;
 {* OK }
//#UC START# *4A8AD47D0357_497EFC6002FC_var*
//#UC END# *4A8AD47D0357_497EFC6002FC_var*
begin
//#UC START# *4A8AD47D0357_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD47D0357_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectForm.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_497EFC6002FC_var*
//#UC END# *4AC5D61E0284_497EFC6002FC_var*
begin
//#UC START# *4AC5D61E0284_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

function TPrimAttributeSelectForm.GetQuery: TnsQueryInfo;
//#UC START# *4AE884E803AA_497EFC6002FC_var*
//#UC END# *4AE884E803AA_497EFC6002FC_var*
begin
//#UC START# *4AE884E803AA_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE884E803AA_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.GetQuery

function TPrimAttributeSelectForm.IsQuerySaved: Boolean;
//#UC START# *4AE8A577027D_497EFC6002FC_var*
//#UC END# *4AE8A577027D_497EFC6002FC_var*
begin
//#UC START# *4AE8A577027D_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8A577027D_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.IsQuerySaved

procedure TPrimAttributeSelectForm.SetQuery;
//#UC START# *4AEF213001F0_497EFC6002FC_var*
//#UC END# *4AEF213001F0_497EFC6002FC_var*
begin
//#UC START# *4AEF213001F0_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF213001F0_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.SetQuery

procedure TPrimAttributeSelectForm.SetRoot;
//#UC START# *4AF3EBC001C4_497EFC6002FC_var*
//#UC END# *4AF3EBC001C4_497EFC6002FC_var*
begin
//#UC START# *4AF3EBC001C4_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF3EBC001C4_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.SetRoot

procedure TPrimAttributeSelectForm.ClearQuery;
//#UC START# *4AF92B09017F_497EFC6002FC_var*
//#UC END# *4AF92B09017F_497EFC6002FC_var*
begin
//#UC START# *4AF92B09017F_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF92B09017F_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.ClearQuery

procedure TPrimAttributeSelectForm.ClearAll;
//#UC START# *4C2DFEE000BA_497EFC6002FC_var*
//#UC END# *4C2DFEE000BA_497EFC6002FC_var*
begin
//#UC START# *4C2DFEE000BA_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2DFEE000BA_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.ClearAll

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_497EFC6002FC_var*
//#UC END# *4C762C910358_497EFC6002FC_var*
begin
//#UC START# *4C762C910358_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimAttributeSelectForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_497EFC6002FC_var*
//#UC END# *4C762D9B0224_497EFC6002FC_var*
begin
//#UC START# *4C762D9B0224_497EFC6002FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_497EFC6002FC_impl*
end;//TPrimAttributeSelectForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

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

end.
