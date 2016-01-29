unit PrimForbidAutoregistration_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimForbidAutoregistration_Form.pas"
// �����: 27.01.2009 12:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 �������������::Admin::View::Admin::PrimForbidAutoregistration
//
// ������������ ��� ������� ���������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes,
  AdminInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimForbidAutoregistrationForm = {form} class(TvcmEntityForm)
  {* ������������ ��� ������� ��������������� }
 private
 // private fields
   f_lblReference : TvtLabel;
    {* ���� ��� �������� lblReference}
   f_gbInfo : TvtGroupBox;
    {* ���� ��� �������� gbInfo}
   f_lblPhone : TvtLabel;
    {* ���� ��� �������� lblPhone}
   f_lblEmail : TvtLabel;
    {* ���� ��� �������� lblEmail}
   f_lblHint : TvtLabel;
    {* ���� ��� �������� lblHint}
   f_cbPhone : TnscEdit;
    {* ���� ��� �������� cbPhone}
   f_cbEmail : TnscEdit;
    {* ���� ��� �������� cbEmail}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure MakeControls; override;
 private
 // private methods
   procedure CbEmailChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsForbidAutoregistration : IdsForbidAutoregistration;
 public
 // public methods
   class function Make(
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property lblReference: TvtLabel
     read f_lblReference;
     {* ������� ����������, �� ������� ������������ ����� ��������� � ���� ��� ����������� � ������� ������. }
   property gbInfo: TvtGroupBox
     read f_gbInfo;
     {* ������������� ������� }
   property lblPhone: TvtLabel
     read f_lblPhone;
     {* ������� }
   property lblEmail: TvtLabel
     read f_lblEmail;
     {* E-mail }
   property lblHint: TvtLabel
     read f_lblHint;
     {* (���������� ������ �� ����� �����������) }
   property cbPhone: TnscEdit
     read f_cbPhone;
   property cbEmail: TnscEdit
     read f_cbEmail;
 end;//TPrimForbidAutoregistrationForm
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Graphics,
  nsVerifyValue
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils {a},
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimForbidAutoregistrationForm

procedure TPrimForbidAutoregistrationForm.CbEmailChange(Sender: TObject);
//#UC START# *51C3165101B7_497ED39B034F_var*
const
 c_FontColor: array [Boolean] of TColor = (clRed, clWindowText);
//#UC END# *51C3165101B7_497ED39B034F_var*
begin
//#UC START# *51C3165101B7_497ED39B034F_impl*
 cbEmail.Font.Color := c_FontColor[nsEmailVerify.Verify(cbEmail.Text)];
//#UC END# *51C3165101B7_497ED39B034F_impl*
end;//TPrimForbidAutoregistrationForm.CbEmailChange

class function TPrimForbidAutoregistrationForm.Make(
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;
begin
 Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource);
end;

{$If not defined(NoVCM)}
procedure TPrimForbidAutoregistrationForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497ED39B034F_var*
//#UC END# *497469C90140_497ED39B034F_var*
begin
//#UC START# *497469C90140_497ED39B034F_impl*
 if Assigned(dsForbidAutoregistration) then
 begin
  cbEmail.Text := dsForbidAutoregistration.Email;
  cbPhone.Text := dsForbidAutoregistration.Phone;
 end; 
//#UC END# *497469C90140_497ED39B034F_impl*
end;//TPrimForbidAutoregistrationForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimForbidAutoregistrationForm.InitControls;
//#UC START# *4A8E8F2E0195_497ED39B034F_var*
//#UC END# *4A8E8F2E0195_497ED39B034F_var*
begin
//#UC START# *4A8E8F2E0195_497ED39B034F_impl*
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 ClientHeight := 169;
 ClientWidth := 355;
 with lblReference do
 begin
  Font.Color := clBlue;
  WordWrap := True;
  Left := 15;
  Top := 7;
  Width := 329;
  Height := 48;
 end;
 with gbInfo do
 begin
  Left := 10;
  Top := 60;
  Width := 340;
  Height := 101;
 end;
 with lblPhone do
 begin
  Left := 16;
  Top := 24;
  Width := 51;
  Height := 16;
 end;
 with lblEmail do
 begin
  Left := 22;
  Top := 56;
  Width := 37;
  Height := 16;
 end;
 with lblHint do
 begin
  WordWrap := True;
  Left := 8;
  Top := 80;
  Width := 261;
  Height := 16;
  Font.Color := clBlue;
 end;
 with cbPhone do
 begin
  Left := 74;
  Top := 20;
  Width := 257;
  Height := 21;
  TabOrder := 0;
  ShowHint := True;
 end;
 with cbEmail do
 begin
  Left := 74;
  Top := 52;
  Width := 257;
  Height := 21;
  OnChange := cbEmailChange;
  TabOrder := 1;
  ParentShowHint := False;
  ShowHint := True;
 end;
//#UC END# *4A8E8F2E0195_497ED39B034F_impl*
end;//TPrimForbidAutoregistrationForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimForbidAutoregistrationForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsForbidAutoregistration := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsForbidAutoregistration, dsForbidAutoregistration);
 end;//aDsNew = nil
end;

procedure TPrimForbidAutoregistrationForm.MakeControls;
begin
 inherited;
 f_lblReference := TvtLabel.Create(Self);
 f_lblReference.Name := 'lblReference';
 f_lblReference.Parent := Self;
 f_lblReference.Caption := '������� ����������, �� ������� ������������ ����� ��������� � ���� ��� ����������� � ������� ������.';
 f_gbInfo := TvtGroupBox.Create(Self);
 f_gbInfo.Name := 'gbInfo';
 f_gbInfo.Parent := Self;
 f_gbInfo.Caption := '������������� �������';
 f_lblPhone := TvtLabel.Create(Self);
 f_lblPhone.Name := 'lblPhone';
 f_lblPhone.Parent := gbInfo;
 f_lblPhone.Caption := '�������';
 f_lblEmail := TvtLabel.Create(Self);
 f_lblEmail.Name := 'lblEmail';
 f_lblEmail.Parent := gbInfo;
 f_lblEmail.Caption := 'E-mail';
 f_lblHint := TvtLabel.Create(Self);
 f_lblHint.Name := 'lblHint';
 f_lblHint.Parent := gbInfo;
 f_lblHint.Caption := '(���������� ������ �� ����� �����������)';
 f_cbPhone := TnscEdit.Create(Self);
 f_cbPhone.Name := 'cbPhone';
 f_cbPhone.Parent := gbInfo;
 f_cbEmail := TnscEdit.Create(Self);
 f_cbEmail.Name := 'cbEmail';
 f_cbEmail.Parent := gbInfo;
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� PrimForbidAutoregistration
 TtfwClassRef.Register(TPrimForbidAutoregistrationForm);
{$IfEnd} //Admin AND not NoScripts

end.