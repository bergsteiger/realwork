unit PrimDictionContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimDictionContainer_Form.pas"
// Начат: 11.03.2011 21:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Встроенные продукты::Diction::View::Diction::PrimDictionContainer
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
  PrimSaveLoad_Form,
  vtSizeablePanel,
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
  Search_Strange_Controls,
  PrimSaveLoadOptions_Form,
  DictionContainerUserTypes_slqtDiction_UserType,
  DictionContainerUserTypes_slqtMedicDiction_UserType
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _DictionContainerUserTypes_Parent_ = TPrimSaveLoadOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}
 TPrimDictionContainerForm = {form} class(_DictionContainerUserTypes_)
 private
 // private fields
   f_pnBackground : TvtProportionalPanel;
    {* Поле для свойства pnBackground}
   f_NavigatorZone : TvtSizeablePanel;
    {* Поле для свойства NavigatorZone}
   f_pnWorkArea : TvtProportionalPanel;
    {* Поле для свойства pnWorkArea}
   f_ChildZone : TvtSizeablePanel;
    {* Поле для свойства ChildZone}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ChildZoneQueryResize(ALeft: Integer;
     ATop: Integer;
     AWidth: Integer;
     AHeight: Integer;
     var aCanResize: Boolean);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   class function IsDictionLike: Boolean; override;
     {* Определяет, что форма похожа на "словарь" }
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
    {$If not defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
     {* Сигнатура метода NotifyUserTypeSet }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function AcceptForm(const aForm: IvcmEntityForm;
     aControl: TComponent): Boolean; override;
    {$IfEnd} //not NoVCM
 public
 // public properties
   property pnBackground: TvtProportionalPanel
     read f_pnBackground;
   property NavigatorZone: TvtSizeablePanel
     read f_NavigatorZone;
   property pnWorkArea: TvtProportionalPanel
     read f_pnWorkArea;
   property ChildZone: TvtSizeablePanel
     read f_ChildZone;
 end;//TPrimDictionContainerForm

 TvcmContainerFormRef = TPrimDictionContainerForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}

// start class TPrimDictionContainerForm

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

{$If not defined(NoVCM)}
procedure TPrimDictionContainerForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

class function TPrimDictionContainerForm.IsDictionLike: Boolean;
//#UC START# *4F5DB2320323_4D7A69F9028C_var*
//#UC END# *4F5DB2320323_4D7A69F9028C_var*
begin
//#UC START# *4F5DB2320323_4D7A69F9028C_impl*
 Result := true;
//#UC END# *4F5DB2320323_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.IsDictionLike

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
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
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoVCM)}
function TPrimDictionContainerForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4D7A69F9028C_var*
//#UC END# *53F1C6EF02C9_4D7A69F9028C_var*
begin
//#UC START# *53F1C6EF02C9_4D7A69F9028C_impl*
 Result := nil;
//#UC END# *53F1C6EF02C9_4D7A69F9028C_impl*
end;//TPrimDictionContainerForm.DoGetTabCaption
{$IfEnd} //not NoVCM

procedure TPrimDictionContainerForm.InitEntities;
begin
 inherited;
 AddUserTypeExclude(slqtDictionName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtDictionName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtDictionName, en_Loadable, op_Load, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtDictionName, en_Result, op_OkExt, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtDictionName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(slqtDictionName, en_Query, op_ClearAll, false);
 AddUserTypeExclude(slqtDictionName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Add, false);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Delete, false);
 AddUserTypeExclude(slqtDictionName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_ClearAll, false);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_Refresh, false);
 AddUserTypeExclude(slqtDictionName, en_Result, op_ClearAll, false);
 AddUserTypeExclude(slqtDictionName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtDictionName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtDictionName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtDictionName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtDictionName, en_Filterable, op_GetListType, false);
 AddUserTypeExclude(slqtMedicDictionName, en_File, op_SaveToFolder, false);
 AddUserTypeExclude(slqtMedicDictionName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Loadable, op_Load, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_OkExt, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_Cancel, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_ClearAll, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_SetList, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Add, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Delete, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_GetList, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_ClearAll, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_Refresh, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Result, op_ClearAll, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_GetOldQuery, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Query, op_SearchType, false);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicOr, false);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicAnd, false);
 AddUserTypeExclude(slqtMedicDictionName, en_LogicOperation, op_LogicNot, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(slqtMedicDictionName, en_Filterable, op_GetListType, false);
end;

procedure TPrimDictionContainerForm.MakeControls;
begin
 inherited;
 f_pnBackground := TvtProportionalPanel.Create(Self);
 f_pnBackground.Name := 'pnBackground';
 f_pnBackground.Parent := Self;
 f_NavigatorZone := TvtSizeablePanel.Create(Self);
 f_NavigatorZone.Name := 'NavigatorZone';
 f_NavigatorZone.Parent := pnBackground;
 with DefineZone(vcm_ztNavigator, f_NavigatorZone) do
 begin
 end;//with DefineZone(vcm_ztNavigator, f_NavigatorZone)
 f_pnWorkArea := TvtProportionalPanel.Create(Self);
 f_pnWorkArea.Name := 'pnWorkArea';
 f_pnWorkArea.Parent := pnBackground;
 ParentZone.Parent := pnWorkArea;
 f_ChildZone := TvtSizeablePanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := pnWorkArea;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_ChildZone)
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimDictionContainer
 TtfwClassRef.Register(TPrimDictionContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.