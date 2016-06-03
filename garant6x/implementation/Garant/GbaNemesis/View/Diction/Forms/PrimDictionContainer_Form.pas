unit PrimDictionContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionContainer_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimDictionContainer" MUID: (4D7A69F9028C)
// Имя типа: "TPrimDictionContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSaveLoadOptions_Form
 , F1Like_InternalOperations_Controls
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
;

type
 _DictionContainerUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}
 TPrimDictionContainerForm = class(_DictionContainerUserTypes_)
  private
   f_pnBackground: TvtProportionalPanel;
   f_NavigatorZone: TvtSizeablePanel;
   f_pnWorkArea: TvtProportionalPanel;
   f_ChildZone: TvtSizeablePanel;
  private
   procedure ChildZoneQueryResize(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer;
    var aCanResize: Boolean);
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   class function IsDictionLike: Boolean; override;
    {* Определяет, что форма похожа на "словарь" }
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Common_ShowSplitter_Execute(aVisible: Boolean);
   procedure Common_ShowSplitter(const aParams: IvcmExecuteParams);
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AcceptForm(const aForm: IvcmEntityForm;
    aControl: TComponent): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property pnBackground: TvtProportionalPanel
    read f_pnBackground;
   property NavigatorZone: TvtSizeablePanel
    read f_NavigatorZone;
   property pnWorkArea: TvtProportionalPanel
    read f_pnWorkArea;
   property ChildZone: TvtSizeablePanel
    read f_ChildZone;
 end;//TPrimDictionContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DictionContainerUserTypes_slqtDiction_UserType
 , DictionContainerUserTypes_slqtMedicDiction_UserType
 , Search_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchLite_Strange_Controls
 , PrimPrimListInterfaces
 , bsTypes
 , eeInterfaces
 , nsTypes
 , FiltersUnit
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4D7A69F9028Cimpl_uses*
 //#UC END# *4D7A69F9028Cimpl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}

procedure TPrimDictionContainerForm.ChildZoneQueryResize(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer;
 var aCanResize: Boolean);
//#UC START# *4D7F8B4A0214_4D7A69F9028C_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4D7F8B4A0214_4D7A69F9028C_var*
begin
//#UC START# *4D7F8B4A0214_4D7A69F9028C_impl*
 if aCanResize then
 begin
  aCanResize := HasForm(vcm_ztChild, false, @l_Form);
  if aCanResize then
   aCanResize := l_Form.AsContainer.HasForm;
 end;//aCanResize
//#UC END# *4D7F8B4A0214_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.ChildZoneQueryResize

procedure TPrimDictionContainerForm.Common_ShowSplitter_Execute(aVisible: Boolean);
//#UC START# *4AE8744002F3_4D7A69F9028Cexec_var*
//#UC END# *4AE8744002F3_4D7A69F9028Cexec_var*
begin
//#UC START# *4AE8744002F3_4D7A69F9028Cexec_impl*
 if aVisible then
  ChildZone.SizeableSides := [szTop]
 else
  ChildZone.SizeableSides := [];
//#UC END# *4AE8744002F3_4D7A69F9028Cexec_impl*
end;//TPrimDictionContainerForm.Common_ShowSplitter_Execute

procedure TPrimDictionContainerForm.Common_ShowSplitter(const aParams: IvcmExecuteParams);
begin
 with ICommon_ShowSplitter_Params(aParams.Data) do
  Self.Common_ShowSplitter_Execute(Visible);
end;//TPrimDictionContainerForm.Common_ShowSplitter

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4D7A69F9028C_var*
//#UC END# *4A8E8F2E0195_4D7A69F9028C_var*
begin
//#UC START# *4A8E8F2E0195_4D7A69F9028C_impl*
 inherited;
 pnBackground.Align := alClient;
 NavigatorZone.Align := alLeft;
 NavigatorZone.Width := 100;
 NavigatorZone.SizeableSides := [szRight];
 NavigatorZone.BevelOuter := bvNone;
 NavigatorZone.BevelInner := bvNone;
 pnWorkArea.Align := alClient;
 pnWorkArea.BevelOuter := bvNone;
 pnWorkArea.BevelInner := bvNone;
 ChildZone.Align := alBottom;
 ChildZone.Height := 200;
 ChildZone.SizeableSides := [szTop];
 ChildZone.BevelOuter := bvNone;
 ChildZone.BevelInner := bvNone;
 ChildZone.OnQueryResize := ChildZoneQueryResize;
//#UC END# *4A8E8F2E0195_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_4D7A69F9028C_var*
//#UC END# *4D78E2BB0211_4D7A69F9028C_var*
begin
//#UC START# *4D78E2BB0211_4D7A69F9028C_impl*
 inherited;
 NavigatorZone.Color := ParentZone.Color;
 ChildZone.Color := ParentZone.Color;
 pnWorkArea.Color := ParentZone.Color;
//#UC END# *4D78E2BB0211_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

class function TPrimDictionContainerForm.IsDictionLike: Boolean;
 {* Определяет, что форма похожа на "словарь" }
//#UC START# *4F5DB2320323_4D7A69F9028C_var*
//#UC END# *4F5DB2320323_4D7A69F9028C_var*
begin
//#UC START# *4F5DB2320323_4D7A69F9028C_impl*
 Result := true;
//#UC END# *4F5DB2320323_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.IsDictionLike

{$If NOT Defined(NoVCM)}
function TPrimDictionContainerForm.AcceptForm(const aForm: IvcmEntityForm;
 aControl: TComponent): Boolean;
//#UC START# *52F2254D0058_4D7A69F9028C_var*
//#UC END# *52F2254D0058_4D7A69F9028C_var*
begin
//#UC START# *52F2254D0058_4D7A69F9028C_impl*
 //Не надо сюда ничего придочивать, во избежание AV.
 //http://mdp.garant.ru/pages/viewpage.action?pageId=370384532
 Result := false;
//#UC END# *52F2254D0058_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.AcceptForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimDictionContainerForm.DoGetFormSetImageIndex: Integer;
//#UC START# *53B649F600A3_4D7A69F9028C_var*
//#UC END# *53B649F600A3_4D7A69F9028C_var*
begin
//#UC START# *53B649F600A3_4D7A69F9028C_impl*
 if (DataSource <> nil) and (DataSource.UseCaseController <> nil) then
  Result := DataSource.UseCaseController.FormSetImageIndex
 else
  Result := 0;
//#UC END# *53B649F600A3_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM)}
function TPrimDictionContainerForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4D7A69F9028C_var*
//#UC END# *53F1C6EF02C9_4D7A69F9028C_var*
begin
//#UC START# *53F1C6EF02C9_4D7A69F9028C_impl*
 Result := nil;
//#UC END# *53F1C6EF02C9_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Common, nil);
  PublishOpWithResult(en_Common, op_ShowSplitter, Common_ShowSplitter, nil, nil);
 end;//with Entities.Entities
 AddUserTypeExclude(slqtDictionName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtDictionName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtDictionName, en_Loadable, op_Load, False);
 AddUserTypeExclude(slqtDictionName, en_Result, op_OkExt, False);
 AddUserTypeExclude(slqtDictionName, en_Result, op_Cancel, False);
 AddUserTypeExclude(slqtDictionName, en_Query, op_ClearAll, False);
 AddUserTypeExclude(slqtDictionName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Add, False);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Delete, False);
 AddUserTypeExclude(slqtDictionName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_ClearAll, False);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Refresh, False);
 AddUserTypeExclude(slqtDictionName, en_Result, op_ClearAll, False);
 AddUserTypeExclude(slqtDictionName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtDictionName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtDictionName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_GetListType, False);
 AddUserTypeExclude(slqtMedicDictionName, en_File, op_SaveToFolder, False);
 AddUserTypeExclude(slqtMedicDictionName, en_File, op_LoadFromFolder, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Loadable, op_Load, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_OkExt, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_Cancel, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_ClearAll, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_SetList, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Add, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Delete, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_GetList, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_ClearAll, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Refresh, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_ClearAll, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_GetOldQuery, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_SearchType, False);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicOr, False);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicAnd, False);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicNot, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filters, op_FiltersListOpen, False);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_GetListType, False);
end;//TPrimDictionContainerForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionContainerForm.MakeControls;
begin
 inherited;
 f_pnBackground := TvtProportionalPanel.Create(Self);
 f_pnBackground.Name := 'pnBackground';
 f_pnBackground.Parent := Self;
 f_NavigatorZone := TvtSizeablePanel.Create(Self);
 f_NavigatorZone.Name := 'NavigatorZone';
 f_NavigatorZone.Parent := pnBackground;
 with DefineZone(vcm_ztNavigator, NavigatorZone) do
 begin
 end;//with DefineZone(vcm_ztNavigator
 f_pnWorkArea := TvtProportionalPanel.Create(Self);
 f_pnWorkArea.Name := 'pnWorkArea';
 f_pnWorkArea.Parent := pnBackground;
 ParentZone.Parent := pnWorkArea;
 f_ChildZone := TvtSizeablePanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := pnWorkArea;
 with DefineZone(vcm_ztChild, ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild
end;//TPrimDictionContainerForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDictionContainerForm);
 {* Регистрация PrimDictionContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
