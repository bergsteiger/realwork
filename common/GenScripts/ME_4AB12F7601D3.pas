unit PrimPictureInfo_Form;
 {* ���������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureInfo_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimPictureInfo" MUID: (4AB12F7601D3)
// ��� ����: "TPrimPictureInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , eeMemoWithEditOperations
 , DocumentDomainInterfaces
;

type
 TPrimPictureInfoForm = class(TvcmEntityForm)
  {* ���������� � �������� }
  private
   f_Info: TeeMemoWithEditOperations;
    {* ���� ��� �������� Info }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* ��� ����� ��������� ������� ��� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsLinkedObjectDescription): BadFactoryType; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property Info: TeeMemoWithEditOperations
    read f_Info;
 end;//TPrimPictureInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3String
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
class function TPrimPictureInfoForm.Make(const aData: InsLinkedObjectDescription): BadFactoryType;
var
 l_Inst : TPrimPictureInfoForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimPictureInfoForm.Make

procedure TPrimPictureInfoForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* ������ }
//#UC START# *4AC5D61E0284_4AB12F7601D3test_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3test_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3test_impl*
 // - ������ �� ������
//#UC END# *4AC5D61E0284_4AB12F7601D3test_impl*
end;//TPrimPictureInfoForm.Result_Cancel_Test

procedure TPrimPictureInfoForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������ }
//#UC START# *4AC5D61E0284_4AB12F7601D3exec_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3exec_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3exec_impl*
 ModalResult := mrCancel;
//#UC END# *4AC5D61E0284_4AB12F7601D3exec_impl*
end;//TPrimPictureInfoForm.Result_Cancel_Execute

procedure TPrimPictureInfoForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
 {* ������ }
//#UC START# *4AC5D61E0284_4AB12F7601D3getstate_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3getstate_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3getstate_impl*
 State := st_user_Result_Cancel_Close;
//#UC END# *4AC5D61E0284_4AB12F7601D3getstate_impl*
end;//TPrimPictureInfoForm.Result_Cancel_GetState

procedure TPrimPictureInfoForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4AB12F7601D3_var*
//#UC END# *4A8E8F2E0195_4AB12F7601D3_var*
begin
//#UC START# *4A8E8F2E0195_4AB12F7601D3_impl*
 inherited;
 with Info do
 begin
  AutoSelect := False;
  TextSource.ReadOnly := True;
  Align := alClient;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  ReadOnly := True;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_4AB12F7601D3_impl*
end;//TPrimPictureInfoForm.InitControls

procedure TPrimPictureInfoForm.SetupFormLayout;
 {* ��� ����� ��������� ������� ��� ����� }
//#UC START# *529332B40230_4AB12F7601D3_var*
//#UC END# *529332B40230_4AB12F7601D3_var*
begin
//#UC START# *529332B40230_4AB12F7601D3_impl*
 inherited;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 Position := poScreenCenter;
 ClientHeight := 185;
 ClientWidth := 340;
//#UC END# *529332B40230_4AB12F7601D3_impl*
end;//TPrimPictureInfoForm.SetupFormLayout

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureInfoForm);
 {* ����������� PrimPictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
