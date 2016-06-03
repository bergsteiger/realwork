unit PrimMedicListSynchroView_Form;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimMedicListSynchroView" MUID: (497EE1F10134)
// Имя типа: "TPrimMedicListSynchroViewForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Inpharm_Strange_Controls
 , SimpleListInterfaces
 , vtPanel
 , nsTypes
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimMedicListSynchroViewForm = class({$If NOT Defined(NoVCM)}
 TvcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Синхронный просмотр }
  private
   f_ztChild: TvtPanel;
  protected
   dsSimpleListSynchroView: IdsSimpleListSynchroView;
  protected
   procedure MlsfDrugListQueryClose(aSender: TObject);
    {* Обработчик события mlsfDrugList.OnQueryClose }
   procedure MlsfMedicFirmQueryClose(aSender: TObject);
    {* Обработчик события mlsfMedicFirm.OnQueryClose }
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
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
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
   procedure SynchroView_BecomeActive_Execute(aFormType: TnsShowSynchroForm);
   procedure SynchroView_BecomeActive(const aParams: IvcmExecuteParams);
   procedure MedicListSynchroView_OpenDocument_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenDocument_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicListSynchroView_OpenDocument_GetState(var State: TvcmOperationStateIndex);
   procedure MedicListSynchroView_OpenAttributesForm_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenAttributesForm_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicListSynchroView_OpenList_Test(const aParams: IvcmTestParamsPrim);
   procedure MedicListSynchroView_OpenList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure MedicListSynchroView_OpenList_GetState(var State: TvcmOperationStateIndex);
   {$If NOT Defined(NoVCM)}
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; override;
    {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ztChild: TvtPanel
    read f_ztChild;
 end;//TPrimMedicListSynchroViewForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , F1Like_InternalOperations_Controls
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 , PrimMedicListSynchroView_mlsfMedicFirm_UserType
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *497EE1F10134impl_uses*
 //#UC END# *497EE1F10134impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimMedicListSynchroViewForm.MlsfDrugListQueryClose(aSender: TObject);
 {* Обработчик события mlsfDrugList.OnQueryClose }
//#UC START# *65F272629DB8_497EE1F10134_var*
//#UC END# *65F272629DB8_497EE1F10134_var*
begin
//#UC START# *65F272629DB8_497EE1F10134_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *65F272629DB8_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.MlsfDrugListQueryClose

procedure TPrimMedicListSynchroViewForm.MlsfMedicFirmQueryClose(aSender: TObject);
 {* Обработчик события mlsfMedicFirm.OnQueryClose }
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
 with ISynchroView_BecomeActive_Params(aParams.Data) do
  Self.SynchroView_BecomeActive_Execute(FormType);
end;//TPrimMedicListSynchroViewForm.SynchroView_BecomeActive

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C52E5D702B0_497EE1F10134test_var*
//#UC END# *4C52E5D702B0_497EE1F10134test_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134test_impl*
 aParams.Op.Flag[vcm_ofChecked] := dsSimpleListSynchroView.IsDocumentActive;
 aParams.Op.Flag[vcm_ofEnabled] := dsSimpleListSynchroView.HasDocument;
//#UC END# *4C52E5D702B0_497EE1F10134test_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Test

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52E5D702B0_497EE1F10134exec_var*
//#UC END# *4C52E5D702B0_497EE1F10134exec_var*
begin
//#UC START# *4C52E5D702B0_497EE1F10134exec_impl*
 dsSimpleListSynchroView.OpenDocument;
//#UC END# *4C52E5D702B0_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenDocument_Execute

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

procedure TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52E61002B5_497EE1F10134exec_var*
//#UC END# *4C52E61002B5_497EE1F10134exec_var*
begin
//#UC START# *4C52E61002B5_497EE1F10134exec_impl*
 dsSimpleListSynchroView.OpenList;
//#UC END# *4C52E61002B5_497EE1F10134exec_impl*
end;//TPrimMedicListSynchroViewForm.MedicListSynchroView_OpenList_Execute

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

procedure TPrimMedicListSynchroViewForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

function TPrimMedicListSynchroViewForm.DoGetTabInfo(out theCaption: Il3CString;
 out theItemIndex: Integer): Boolean;
 {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
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

procedure TPrimMedicListSynchroViewForm.PageActive;
//#UC START# *4C52E8030278_497EE1F10134_var*
//#UC END# *4C52E8030278_497EE1F10134_var*
begin
//#UC START# *4C52E8030278_497EE1F10134_impl*
 op_List_SetCurrentVisible.Call(Aggregate);
//#UC END# *4C52E8030278_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageActive

procedure TPrimMedicListSynchroViewForm.PageInactive;
//#UC START# *4C52E81603A9_497EE1F10134_var*
//#UC END# *4C52E81603A9_497EE1F10134_var*
begin
//#UC START# *4C52E81603A9_497EE1F10134_impl*
//#UC END# *4C52E81603A9_497EE1F10134_impl*
end;//TPrimMedicListSynchroViewForm.PageInactive

procedure TPrimMedicListSynchroViewForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  dsSimpleListSynchroView := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsSimpleListSynchroView, dsSimpleListSynchroView);
 end;//aNew = nil
end;//TPrimMedicListSynchroViewForm.SignalDataSourceChanged

procedure TPrimMedicListSynchroViewForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_SynchroView, nil);
  PublishFormEntity(en_MedicListSynchroView, nil);
  PublishOpWithResult(en_SynchroView, op_BecomeActive, SynchroView_BecomeActive, nil, nil);
  PublishOp(en_MedicListSynchroView, op_OpenDocument, MedicListSynchroView_OpenDocument_Execute, MedicListSynchroView_OpenDocument_Test, MedicListSynchroView_OpenDocument_GetState);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenDocument, False);
  ShowInToolbar(en_MedicListSynchroView, op_OpenDocument, True);
  PublishOp(en_MedicListSynchroView, op_OpenAttributesForm, MedicListSynchroView_OpenAttributesForm_Execute, MedicListSynchroView_OpenAttributesForm_Test, nil);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenAttributesForm, False);
  ShowInToolbar(en_MedicListSynchroView, op_OpenAttributesForm, True);
  PublishOp(en_MedicListSynchroView, op_OpenList, MedicListSynchroView_OpenList_Execute, MedicListSynchroView_OpenList_Test, MedicListSynchroView_OpenList_GetState);
  ShowInContextMenu(en_MedicListSynchroView, op_OpenList, False);
  ShowInToolbar(en_MedicListSynchroView, op_OpenList, True);
 end;//with Entities.Entities
end;//TPrimMedicListSynchroViewForm.InitEntities

procedure TPrimMedicListSynchroViewForm.MakeControls;
begin
 inherited;
 with AddUsertype(mlsfDrugListName,
  str_mlsfDrugListCaption,
  str_mlsfDrugListCaption,
  False,
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
  False,
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
 with DefineZone(vcm_ztChild, ztChild) do
 begin
  FormStyle.Toolbars.Top.MergeWithContainer := vcm_bTrue;
 end;//with DefineZone(vcm_ztChild
end;//TPrimMedicListSynchroViewForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMedicListSynchroViewForm);
 {* Регистрация PrimMedicListSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
