unit PrimMedicListSynchroView_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicListSynchroView_Form.pas"
// Начат: 27.01.2009 13:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::PrimMedicListSynchroView
//
// Синхронный просмотр
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
  SimpleListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  l3StringIDEx,
  PrimMedicListSynchroView_mlsfDrugList_UserType,
  Inpharm_Strange_Controls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimMedicListSynchroView_mlsfMedicFirm_UserType,
  l3Interfaces,
  nsTypes,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimMedicListSynchroViewForm = {form} class(TvcmContainerForm)
  {* Синхронный просмотр }
 private
 // private fields
   f_ztChild : TvtPanel;
    {* Поле для свойства ztChild}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure SynchroView_BecomeActive_Execute(aFormType: TnsShowSynchroForm);
   procedure SynchroView_BecomeActive(const aParams: IvcmExecuteParams);
   procedure MedicListSynchroView_OpenDocument_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenDocument_GetState(var State: TvcmOperationStateIndex);
   procedure MedicListSynchroView_OpenDocument_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicListSynchroView_OpenAttributesForm_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenAttributesForm_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicListSynchroView_OpenList_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenList_GetState(var State: TvcmOperationStateIndex);
   procedure MedicListSynchroView_OpenList_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure PageInactive; override;
   {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
     {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsSimpleListSynchroView : IdsSimpleListSynchroView;
 protected
 // protected methods
   procedure MlsfDrugListQueryClose(aSender: TObject);
     {* Обработчик события mlsfDrugList.OnQueryClose }
   procedure MlsfMedicFirmQueryClose(aSender: TObject);
     {* Обработчик события mlsfMedicFirm.OnQueryClose }
 public
 // public properties
   property ztChild: TvtPanel
     read f_ztChild;
 end;//TPrimMedicListSynchroViewForm

 TvcmContainerFormRef = TPrimMedicListSynchroViewForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  F1Like_InternalOperations_Controls,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a},
  SysUtils {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки mlsfDrugListLocalConstants }
  str_mlsfDrugListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfDrugListCaption'; rValue : 'Синхронный просмотр');
   { Заголовок пользовательского типа "Синхронный просмотр" }

var
   { Локализуемые строки mlsfMedicFirmLocalConstants }
  str_mlsfMedicFirmCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mlsfMedicFirmCaption'; rValue : 'Описание');
   { Заголовок пользовательского типа "Описание" }

// start class TPrimMedicListSynchroViewForm

procedure TPrimMedicListSynchroViewForm.MlsfDrugListQueryClose(aSender: TObject);
//#UC START# *65F272629DB8_497EE1F10134_var*
//#UC END# *65F272629DB8_497EE1F10134_var*
begin
//#UC START# *65F272629DB8_497EE1F10134_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *65F272629DB8_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.MlsfDrugListQueryClose

procedure TPrimMedicListSynchroViewForm.MlsfMedicFirmQueryClose(aSender: TObject);
//#UC START# *C155D2625A02_497EE1F10134_var*
//#UC END# *C155D2625A02_497EE1F10134_var*
begin
//#UC START# *C155D2625A02_497EE1F10134_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *C155D2625A02_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.MlsfMedicFirmQueryClose

procedure TPrimMedicListSynchroViewForm.SynchroView_BecomeActive_Execute(aFormType: TnsShowSynchroForm);
//#UC START# *4AE9E3CC03C7_497EE1F10134exec_var*
//#UC END# *4AE9E3CC03C7_497EE1F10134exec_var*
begin
//#UC START# *4AE9E3CC03C7_497EE1F10134exec_impl*
 case aFormType of
  ssfAttribute:
   if (dsSimpleListSynchroView <> nil) then
   begin
    dsSimpleListSynchroView.OpenAttributes;
    SetActiveInParent;
   end;//dsSimpleListSynchroView <> nil
 end;//case aFormType
//#UC END# *4AE9E3CC03C7_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.SynchroView_BecomeActive_Execute

procedure TPrimMedicListSynchroViewForm.SynchroView_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISynchroView_BecomeActive_Params) do
  SynchroView_BecomeActive_Execute(FormType);
end;

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52E5D702B0_497EE1F10134test_var*
//#UC END# *4C52E5D702B0_497EE1F10134test_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134test_impl*
 aParams.Op.Flag[vcm_ofChecked] := dsSimpleListSynchroView.IsDocumentActive;
 aParams.Op.Flag[vcm_ofEnabled] := dsSimpleListSynchroView.HasDocument;
//#UC END# *4C52E5D702B0_497EE1F10134test_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Test

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C52E5D702B0_497EE1F10134getstate_var*
//#UC END# *4C52E5D702B0_497EE1F10134getstate_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134getstate_impl*
 case UserType of
  mlsfDrugList:
   State := st_user_MedicListSynchroView_OpenDocument_Drug;
  mlsfMedicFirm:
   State := st_user_MedicListSynchroView_OpenDocument_MedicFirm;
 else
  Assert(False);
 end; 
//#UC END# *4C52E5D702B0_497EE1F10134getstate_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_GetState

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52E5D702B0_497EE1F10134exec_var*
//#UC END# *4C52E5D702B0_497EE1F10134exec_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134exec_impl*
 dsSimpleListSynchroView.OpenDocument;
//#UC END# *4C52E5D702B0_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Execute

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenAttributesForm_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52E5F203CC_497EE1F10134test_var*
//#UC END# *4C52E5F203CC_497EE1F10134test_var*
begin
//#UC START# *4C52E5F203CC_497EE1F10134test_impl*
 with aParams.Op do
 begin
  Flag[vcm_ofVisible] := afw.Application.IsInternal;
  Flag[vcm_ofChecked] := dsSimpleListSynchroView.IsAttributesActive;
  Flag[vcm_ofEnabled] := dsSimpleListSynchroView.HasAttributes;
 end;//with aParams.Op do
//#UC END# *4C52E5F203CC_497EE1F10134test_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenAttributesForm_Test

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenAttributesForm_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52E5F203CC_497EE1F10134exec_var*
//#UC END# *4C52E5F203CC_497EE1F10134exec_var*
begin
//#UC START# *4C52E5F203CC_497EE1F10134exec_impl*
 dsSimpleListSynchroView.OpenAttributes;
//#UC END# *4C52E5F203CC_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenAttributesForm_Execute

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52E61002B5_497EE1F10134test_var*
//#UC END# *4C52E61002B5_497EE1F10134test_var*
begin
//#UC START# *4C52E61002B5_497EE1F10134test_impl*
 aParams.Op.Flag[vcm_ofChecked] := dsSimpleListSynchroView.IsListActive;
 aParams.Op.Flag[vcm_ofEnabled] := dsSimpleListSynchroView.HasList;
//#UC END# *4C52E61002B5_497EE1F10134test_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Test

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C52E61002B5_497EE1F10134getstate_var*
//#UC END# *4C52E61002B5_497EE1F10134getstate_var*
begin
//#UC START# *4C52E61002B5_497EE1F10134getstate_impl*
 case UserType of
  mlsfDrugList:
   State := st_user_MedicListSynchroView_OpenList_Drug;
  mlsfMedicFirm:
   State := st_user_MedicListSynchroView_OpenList_MedicFirm;
 else
  Assert(False);
 end; 
//#UC END# *4C52E61002B5_497EE1F10134getstate_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_GetState

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52E61002B5_497EE1F10134exec_var*
//#UC END# *4C52E61002B5_497EE1F10134exec_var*
begin
//#UC START# *4C52E61002B5_497EE1F10134exec_impl*
 dsSimpleListSynchroView.OpenList;
//#UC END# *4C52E61002B5_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Execute

{$If not defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.InitControls;
//#UC START# *4A8E8F2E0195_497EE1F10134_var*
//#UC END# *4A8E8F2E0195_497EE1F10134_var*
begin
//#UC START# *4A8E8F2E0195_497EE1F10134_impl*
 with ztChild do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
//#UC END# *4A8E8F2E0195_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimMedicListSynchroViewForm.DoGetTabInfo(out theCaption: Il3CString;
  out theItemIndex: Integer): Boolean;
//#UC START# *4AC497FD00A2_497EE1F10134_var*
//#UC END# *4AC497FD00A2_497EE1F10134_var*
begin
//#UC START# *4AC497FD00A2_497EE1F10134_impl*
 if (CurUserType <> nil) then
 begin
  Result := true;
  theCaption := CCaption;
  theItemIndex := CurUserType.ImageIndex;
 end//CurUserType <> nil
 else
  Result := false;
//#UC END# *4AC497FD00A2_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.DoGetTabInfo
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.PageActive;
//#UC START# *4C52E8030278_497EE1F10134_var*
//#UC END# *4C52E8030278_497EE1F10134_var*
begin
//#UC START# *4C52E8030278_497EE1F10134_impl*
 op_List_SetCurrentVisible.Call(Aggregate);
//#UC END# *4C52E8030278_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageActive
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.PageInactive;
//#UC START# *4C52E81603A9_497EE1F10134_var*
//#UC END# *4C52E81603A9_497EE1F10134_var*
begin
//#UC START# *4C52E81603A9_497EE1F10134_impl*
//#UC END# *4C52E81603A9_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageInactive
{$IfEnd} //not NoVCM

procedure TPrimMedicListSynchroViewForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsSimpleListSynchroView := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsSimpleListSynchroView, dsSimpleListSynchroView);
 end;//aDsNew = nil
end;

procedure TPrimMedicListSynchroViewForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_SynchroView, nil);
  PublishFormEntity(en_MedicListSynchroView, nil);
  PublishOpWithResult(en_SynchroView, op_BecomeActive, SynchroView_BecomeActive, nil, nil);
  PublishOp(en_MedicListSynchroView, op_OpenDocument, MedicListSynchroView_OpenDocument_Execute, MedicListSynchroView_OpenDocument_Test, MedicListSynchroView_OpenDocument_GetState);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenDocument, false);
  ShowInToolbar(en_MedicListSynchroView, op_OpenDocument, true);
  PublishOp(en_MedicListSynchroView, op_OpenAttributesForm, MedicListSynchroView_OpenAttributesForm_Execute, MedicListSynchroView_OpenAttributesForm_Test, nil);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenAttributesForm, false);
  ShowInToolbar(en_MedicListSynchroView, op_OpenAttributesForm, true);
  PublishOp(en_MedicListSynchroView, op_OpenList, MedicListSynchroView_OpenList_Execute, MedicListSynchroView_OpenList_Test, MedicListSynchroView_OpenList_GetState);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenList, false);
  ShowInToolbar(en_MedicListSynchroView, op_OpenList, true);
 end;//with Entities.Entities
end;

procedure TPrimMedicListSynchroViewForm.MakeControls;
begin
 inherited;
 with AddUsertype(mlsfDrugListName,
  str_mlsfDrugListCaption,
  str_mlsfDrugListCaption,
  false,
  84,
  -1,
  '',
  nil,
  nil,
  MlsfDrugListQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(mlsfDrugListName
 with AddUsertype(mlsfMedicFirmName,
  str_mlsfMedicFirmCaption,
  str_mlsfMedicFirmCaption,
  false,
  84,
  -1,
  '',
  nil,
  nil,
  MlsfMedicFirmQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(mlsfMedicFirmName
 f_ztChild := TvtPanel.Create(Self);
 f_ztChild.Name := 'ztChild';
 f_ztChild.Parent := Self;
 with DefineZone(vcm_ztChild, f_ztChild) do
 begin
  FormStyle.Toolbars.Top.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztChild, f_ztChild)
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_mlsfDrugListCaption
 str_mlsfDrugListCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_mlsfMedicFirmCaption
 str_mlsfMedicFirmCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimMedicListSynchroView
 TtfwClassRef.Register(TPrimMedicListSynchroViewForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.