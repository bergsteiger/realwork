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
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimPreviewForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  private
   f_PreviewPanel: TnscPreviewPanel;
    {* ���� ��� �������� PreviewPanel }
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
  public
   class function Make(const aData: IafwDocumentPreview): File; reintroduce;
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
   procedure Scalable_ChangeScale(const aParams: IvcmExecuteParamsPrim);
    {* �������� ������� }
   function Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
    {* ��������������� ��������� }
   procedure Scalable_CanChangeScale(const aParams: IvcmExecuteParamsPrim);
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
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ utPrintPreviewLocalConstants }
 str_utPrintPreviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utPrintPreviewCaption'; rValue : '��������������� �������� ������');
  {* ��������� ����������������� ���� "��������������� �������� ������" }
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

class function TPrimPreviewForm.Make(const aData: IafwDocumentPreview): File;
var
 l_Inst : TPrimPreviewForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
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
 nsDisableOperationInTrialMode(aParams);
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
 nsDisableOperationInTrialMode(aParams);
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
 nsDisableOperationInTrialMode(aParams);
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

procedure TPrimPreviewForm.Scalable_ChangeScale(const aParams: IvcmExecuteParamsPrim);
 {* �������� ������� }
begin
 with (aParams.Data As IScalable_ChangeScale_Params) do
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

procedure TPrimPreviewForm.Scalable_CanChangeScale(const aParams: IvcmExecuteParamsPrim);
 {* ��������������� ��������� }
begin
 with (aParams.Data As IScalable_CanChangeScale_Params) do
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

initialization
 str_utPrintPreviewCaption.Init;
 {* ������������� str_utPrintPreviewCaption }
 str_PrintPreviewTabCaption.Init;
 {* ������������� str_PrintPreviewTabCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPreviewForm);
 {* ����������� PrimPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.
