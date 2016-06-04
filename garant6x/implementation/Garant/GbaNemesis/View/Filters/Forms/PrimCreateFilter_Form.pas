unit PrimCreateFilter_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimCreateFilter" MUID: (4CB6D95D003A)
// ��� ����: "TPrimCreateFilterForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , FiltersInterfaces
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimCreateFilterForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   ViewArea: IdsCreateFilter;
   f_NameLabel: TvtLabel;
    {* �������� ������� }
   f_FilterName: TnscEdit;
  protected
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IdsCreateFilter;
    const aParams: IvcmMakeParams = nil;
    aZoneType: TvcmZoneType = vcm_ztAny;
    aUserType: TvcmEffectiveUserType = 0): IvcmEntityForm; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property NameLabel: TvtLabel
    read f_NameLabel;
    {* �������� ������� }
   property FilterName: TnscEdit
    read f_FilterName;
 end;//TPrimCreateFilterForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimCreateFilter_cfCreate_UserType
 , PrimCreateFilter_cfRename_UserType
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4CB6D95D003Aimpl_uses*
 //#UC END# *4CB6D95D003Aimpl_uses*
;

{$If NOT Defined(NoVCM)}
class function TPrimCreateFilterForm.Make(const aData: IdsCreateFilter;
 const aParams: IvcmMakeParams = nil;
 aZoneType: TvcmZoneType = vcm_ztAny;
 aUserType: TvcmEffectiveUserType = 0): IvcmEntityForm;
begin
 Result := inherited Make(aParams, aZoneType, aUserType, nil, aData);
end;//TPrimCreateFilterForm.Make

procedure TPrimCreateFilterForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_4CB6D95D003Aexec_var*
//#UC END# *4C762A1501FC_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762A1501FC_4CB6D95D003Aexec_impl*
 Result_OkExt_Execute(aParams);
//#UC END# *4C762A1501FC_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_Ok_Execute

procedure TPrimCreateFilterForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4C762C910358_4CB6D95D003Aexec_var*
//#UC END# *4C762C910358_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762C910358_4CB6D95D003Aexec_impl*
 ModalResult := mrCancel;
//#UC END# *4C762C910358_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_Cancel_Execute

procedure TPrimCreateFilterForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762D9B0224_4CB6D95D003Aexec_var*
//#UC END# *4C762D9B0224_4CB6D95D003Aexec_var*
begin
//#UC START# *4C762D9B0224_4CB6D95D003Aexec_impl*
 if (UserType = cfCreate) then
  ViewArea.CreateFilter(FilterName.Text)
 else
  ViewArea.RenameFilter(FilterName.Text);
 ModalResult := mrOk;
//#UC END# *4C762D9B0224_4CB6D95D003Aexec_impl*
end;//TPrimCreateFilterForm.Result_OkExt_Execute

procedure TPrimCreateFilterForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_4CB6D95D003A_var*
//#UC END# *497469C90140_4CB6D95D003A_var*
begin
//#UC START# *497469C90140_4CB6D95D003A_impl*
 inherited;
 if Assigned(ViewArea) then
  FilterName.Text := ViewArea.Name;
//#UC END# *497469C90140_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.NotifyDataSourceChanged

procedure TPrimCreateFilterForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4CB6D95D003A_var*
//#UC END# *49803F5503AA_4CB6D95D003A_var*
begin
//#UC START# *49803F5503AA_4CB6D95D003A_impl*
 inherited;
 CCaption := l3CStr(CurUserType.Caption);
//#UC END# *49803F5503AA_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.DoInit

procedure TPrimCreateFilterForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4CB6D95D003A_var*
//#UC END# *4A8E8F2E0195_4CB6D95D003A_var*
begin
//#UC START# *4A8E8F2E0195_4CB6D95D003A_impl*
 inherited;
 BorderStyle := bsDialog;
 NameLabel.Top := 4;
 NameLabel.Left := 4;
 FilterName.Top := NameLabel.Top + NameLabel.Height + 4;
 FilterName.Left := 4;
 FilterName.Width := 300;
 Width := FilterName.Left + FilterName.Width + 4;
 Height := FilterName.Top + FilterName.Height + 4;
 ClientWidth := Width;
 ClientHeight := Height;
 Position := poScreenCenter;
//#UC END# *4A8E8F2E0195_4CB6D95D003A_impl*
end;//TPrimCreateFilterForm.InitControls

procedure TPrimCreateFilterForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  ViewArea := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsCreateFilter, ViewArea);
 end;//aNew = nil
end;//TPrimCreateFilterForm.SignalDataSourceChanged

procedure TPrimCreateFilterForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_OkExt, False);
  ShowInToolbar(en_Result, op_OkExt, False);
 end;//with Entities.Entities
end;//TPrimCreateFilterForm.InitEntities

procedure TPrimCreateFilterForm.MakeControls;
begin
 inherited;
 with AddUsertype(cfCreateName,
  str_cfCreateCaption,
  str_cfCreateCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cfCreateName
 with AddUsertype(cfRenameName,
  str_cfRenameCaption,
  str_cfRenameCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cfRenameName
 f_NameLabel := TvtLabel.Create(Self);
 f_NameLabel.Name := 'NameLabel';
 f_NameLabel.Parent := Self;
 f_NameLabel.Caption := '�������� �������';
 f_FilterName := TnscEdit.Create(Self);
 f_FilterName.Name := 'FilterName';
 f_FilterName.Parent := Self;
end;//TPrimCreateFilterForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCreateFilterForm);
 {* ����������� PrimCreateFilter }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
