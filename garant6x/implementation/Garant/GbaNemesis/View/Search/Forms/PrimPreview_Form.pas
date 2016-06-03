unit PrimPreview_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimPreview" MUID: (4AAF6F4E010E)
// ��� ����: "TPrimPreviewForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_ScalingSupport_Controls
 , Search_Strange_Controls
 , afwInterfaces
 {$If Defined(Nemesis)}
 , nscPreviewPanel
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimPreviewForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  private
   f_PreviewPanel: TnscPreviewPanel;
  protected
   f_Preview: IafwDocumentPreview;
  protected
   function IsReady: Boolean;
    {* ��� ������, ����� �������� }
   function Preview: IafwDocumentPreview;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IafwDocumentPreview;
    const aParams: IvcmMakeParams = nil;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aUserType: TvcmEffectiveUserType = 0;
    const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
    {* ������... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   function Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
    {* �������� ������� }
   procedure Scalable_ChangeScale(const aParams: IvcmExecuteParams);
    {* �������� ������� }
   function Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
    {* ��������������� ��������� }
   procedure Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
    {* ��������������� ��������� }
  public
   property PreviewPanel: TnscPreviewPanel
    read f_PreviewPanel;
 end;//TPrimPreviewForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTrialSupport
 , evStyles_SH
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmHistoryService
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimPreview_utPrintPreview_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AAF6F4E010Eimpl_uses*
 //#UC END# *4AAF6F4E010Eimpl_uses*
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ Local }
 str_PrintPreviewTabCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintPreviewTabCaption'; rValue : '��������������� ��������');
  {* '��������������� ��������' }

type _Instance_R_ = TPrimPreviewForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

function TPrimPreviewForm.IsReady: Boolean;
 {* ��� ������, ����� �������� }
//#UC START# *4AC61241009B_4AAF6F4E010E_var*
//#UC END# *4AC61241009B_4AAF6F4E010E_var*
begin
//#UC START# *4AC61241009B_4AAF6F4E010E_impl*
 Result := (PreviewPanel <> nil) AND PreviewPanel.IsReady and
           PreviewPanel.Preview.Printer.HasPrinter and
           not PreviewPanel.Preview.InPrinting;
//#UC END# *4AC61241009B_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.IsReady

function TPrimPreviewForm.Preview: IafwDocumentPreview;
//#UC START# *4AC612AF032F_4AAF6F4E010E_var*
//#UC END# *4AC612AF032F_4AAF6F4E010E_var*
begin
//#UC START# *4AC612AF032F_4AAF6F4E010E_impl*
 if (f_Preview = nil) AND (PreviewPanel <> nil) then
  f_Preview := PreviewPanel.Preview;
 Result := f_Preview;
//#UC END# *4AC612AF032F_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Preview

class function TPrimPreviewForm.Make(const aData: IafwDocumentPreview;
 const aParams: IvcmMakeParams = nil;
 aZoneType: TvcmZoneType = vcm_ztAny;
 aUserType: TvcmEffectiveUserType = 0;
 const aDataSource: IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimPreviewForm);
 begin
  with aForm do
  begin
  //#UC START# *4AC610DF03A7_4AAF6F4E010E_impl*
   f_Preview := aData;
   PreviewPanel.Preview := f_Preview;
  //#UC END# *4AC610DF03A7_4AAF6F4E010E_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;//TPrimPreviewForm.Make

procedure TPrimPreviewForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* ������ }
//#UC START# *49521D8E0295_4AAF6F4E010Etest_var*
//#UC END# *49521D8E0295_4AAF6F4E010Etest_var*
begin
//#UC START# *49521D8E0295_4AAF6F4E010Etest_impl*
 aParams.CallControl;
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)} 
 //nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *49521D8E0295_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.File_Print_Test

procedure TPrimPreviewForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
 {* ������... }
//#UC START# *495220DE0298_4AAF6F4E010Etest_var*
//#UC END# *495220DE0298_4AAF6F4E010Etest_var*
begin
//#UC START# *495220DE0298_4AAF6F4E010Etest_impl*
 aParams.CallControl;
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)} 
 //nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *495220DE0298_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.File_PrintDialog_Test

procedure TPrimPreviewForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4A8AD46D0226_4AAF6F4E010Eexec_var*
//#UC END# *4A8AD46D0226_4AAF6F4E010Eexec_var*
begin
//#UC START# *4A8AD46D0226_4AAF6F4E010Eexec_impl*
 if IsModalForm then
  ModalResult := mrCancel
 else
 {$If not defined(Admin) AND not defined(Monitorings)}
  TvcmHistoryService.Instance.Back(As_IvcmEntityForm);
 {$Else}
  Dispatcher.History.Back;
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A8AD46D0226_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Result_Cancel_Execute

procedure TPrimPreviewForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF6F4E010Etest_var*
//#UC END# *4A97EBE702F8_4AAF6F4E010Etest_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Etest_impl*
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)}
 //nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A97EBE702F8_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.Result_Ok_Test

procedure TPrimPreviewForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF6F4E010Eexec_var*
var
 l_Printed: Boolean;
//#UC END# *4A97EBE702F8_4AAF6F4E010Eexec_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Eexec_impl*
 l_Printed := PreviewPanel.Print;
 if IsModalForm then
  ModalResult := mrOk
 else
  if l_Printed then
   Dispatcher.History.Back;
//#UC END# *4A97EBE702F8_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Result_Ok_Execute

procedure TPrimPreviewForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AAF6F4E010Egetstate_var*
//#UC END# *4A97EBE702F8_4AAF6F4E010Egetstate_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Egetstate_impl*
 State := st_user_Result_Ok_Print;
//#UC END# *4A97EBE702F8_4AAF6F4E010Egetstate_impl*
end;//TPrimPreviewForm.Result_Ok_GetState

function TPrimPreviewForm.Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
 {* �������� ������� }
//#UC START# *4BB32C1401C0_4AAF6F4E010Eexec_var*
//#UC END# *4BB32C1401C0_4AAF6F4E010Eexec_var*
begin
//#UC START# *4BB32C1401C0_4AAF6F4E010Eexec_impl*
 Result := False;
//#UC END# *4BB32C1401C0_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Scalable_ChangeScale_Execute

procedure TPrimPreviewForm.Scalable_ChangeScale(const aParams: IvcmExecuteParams);
 {* �������� ������� }
begin
 with IScalable_ChangeScale_Params(aParams.Data) do
  ResultValue := Self.Scalable_ChangeScale_Execute(Inc);
end;//TPrimPreviewForm.Scalable_ChangeScale

function TPrimPreviewForm.Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
 {* ��������������� ��������� }
//#UC START# *4BB366A901D7_4AAF6F4E010Eexec_var*
const
 cCanChangeScaleArr : array[Boolean] of TCanChangeScale = (ccsNo, ccsYesIfPossible);
//#UC END# *4BB366A901D7_4AAF6F4E010Eexec_var*
begin
//#UC START# *4BB366A901D7_4AAF6F4E010Eexec_impl*
 Result := cCanChangeScaleArr[SHevStyles.PrintAndExportDefaultSetting];
//#UC END# *4BB366A901D7_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Scalable_CanChangeScale_Execute

procedure TPrimPreviewForm.Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
 {* ��������������� ��������� }
begin
 with IScalable_CanChangeScale_Params(aParams.Data) do
  ResultValue := Self.Scalable_CanChangeScale_Execute(nInc);
end;//TPrimPreviewForm.Scalable_CanChangeScale

procedure TPrimPreviewForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AAF6F4E010E_var*
//#UC END# *479731C50290_4AAF6F4E010E_var*
begin
//#UC START# *479731C50290_4AAF6F4E010E_impl*
 f_Preview := nil;
 inherited;
//#UC END# *479731C50290_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Cleanup

procedure TPrimPreviewForm.InitFields;
//#UC START# *47A042E100E2_4AAF6F4E010E_var*
//#UC END# *47A042E100E2_4AAF6F4E010E_var*
begin
//#UC START# *47A042E100E2_4AAF6F4E010E_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *47A042E100E2_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.InitFields

function TPrimPreviewForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_4AAF6F4E010E_var*
//#UC END# *4980407F0076_4AAF6F4E010E_var*
begin
//#UC START# *4980407F0076_4AAF6F4E010E_impl*
 Result := inherited CallCloseQuery(aCaller);
 if Result AND (Preview <> nil) AND Preview.InProcess then
 begin
  // ��������� ������� �� ����� ���������� ������, ������, ��� ��������
  // ��������������� ������ � Preview �������� afw.BeginOp, afw.EndOp;
  //Result := false;
  Preview.Stop(Handle);
 end;//Result
//#UC END# *4980407F0076_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.CallCloseQuery

procedure TPrimPreviewForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AAF6F4E010E_var*
//#UC END# *4A8E8F2E0195_4AAF6F4E010E_var*
begin
//#UC START# *4A8E8F2E0195_4AAF6F4E010E_impl*
 ActiveControl := PreviewPanel;
 with PreviewPanel do
 begin
  Cursor := 1;
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinHeight := 120;
  Constraints.MinWidth := 160;
  UseDockManager := False;
  TabOrder := 0;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.InitControls

function TPrimPreviewForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_var*
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_var*
begin
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_impl*
 Result := str_PrintPreviewTabCaption.AsCStr;
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabCaption

{$If NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimPreviewForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4AAF6F4E010E_var*
//#UC END# *543E3AA801D0_4AAF6F4E010E_var*
begin
//#UC START# *543E3AA801D0_4AAF6F4E010E_impl*
 Result := NsTabIconIndex(titPrintPreview);
//#UC END# *543E3AA801D0_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

procedure TPrimPreviewForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Scalable, nil);
  PublishFormEntity(en_Preview, nil);
  PublishFormEntity(en_Document, nil);
  ToolbarAtBottom(en_Result);
  ToolbarAtBottom(en_Result);
  ContextMenuWeight(en_File, -1);
  ContextMenuWeight(en_Result, 10);
  PublishOp(en_File, op_Print, nil, File_Print_Test, nil);
  ShowInToolbar(en_File, op_Print, True);
  PublishOp(en_File, op_PrintDialog, nil, File_PrintDialog_Test, nil);
  ShowInContextMenu(en_File, op_PrintDialog, False);
  ShowInToolbar(en_File, op_PrintDialog, False);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
  PublishOpWithResult(en_Scalable, op_ChangeScale, Scalable_ChangeScale, nil, nil);
  PublishOpWithResult(en_Scalable, op_CanChangeScale, Scalable_CanChangeScale, nil, nil);
  PublishOp(en_Preview, op_ZoomIn, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomIn, True);
  ShowInToolbar(en_Preview, op_ZoomIn, True);
  ContextMenuWeight(en_Preview, op_ZoomIn, 1);
  PublishOp(en_Preview, op_ZoomOut, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomOut, True);
  ShowInToolbar(en_Preview, op_ZoomOut, True);
  ContextMenuWeight(en_Preview, op_ZoomOut, 2);
  PublishOp(en_Preview, op_ZoomWidth, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomWidth, True);
  ShowInToolbar(en_Preview, op_ZoomWidth, True);
  ContextMenuWeight(en_Preview, op_ZoomWidth, 3);
  PublishOp(en_Preview, op_ZoomPage, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomPage, True);
  ShowInToolbar(en_Preview, op_ZoomPage, True);
  ContextMenuWeight(en_Preview, op_ZoomPage, 4);
  PublishOp(en_Document, op_FullSelectedSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_FullSelectedSwitch, True);
  ShowInToolbar(en_Document, op_FullSelectedSwitch, True);
  PublishOp(en_Document, op_RGBGrayscaleSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_RGBGrayscaleSwitch, True);
  ShowInToolbar(en_Document, op_RGBGrayscaleSwitch, True);
  PublishOp(en_Document, op_PrintInfoSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_PrintInfoSwitch, True);
  ShowInToolbar(en_Document, op_PrintInfoSwitch, True);
 end;//with Entities.Entities
end;//TPrimPreviewForm.InitEntities

procedure TPrimPreviewForm.MakeControls;
begin
 inherited;
 with AddUsertype(utPrintPreviewName,
  str_utPrintPreviewCaption,
  str_utPrintPreviewCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utPrintPreviewName
 f_PreviewPanel := TnscPreviewPanel.Create(Self);
 f_PreviewPanel.Name := 'PreviewPanel';
 f_PreviewPanel.Parent := Self;
end;//TPrimPreviewForm.MakeControls

initialization
 str_PrintPreviewTabCaption.Init;
 {* ������������� str_PrintPreviewTabCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPreviewForm);
 {* ����������� PrimPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
