unit PrimForbidAutoregistration_Form;
 {* Используется при запрете авторегистрации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimForbidAutoregistration_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimForbidAutoregistration" MUID: (497ED39B034F)
// Имя типа: "TPrimForbidAutoregistrationForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
 , vtLabel
 , vtGroupBox
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
;

type
 TPrimForbidAutoregistrationForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Используется при запрете авторегистрации }
  private
   f_lblReference: TvtLabel;
    {* Поле для свойства lblReference }
   f_gbInfo: TvtGroupBox;
    {* Поле для свойства gbInfo }
   f_lblPhone: TvtLabel;
    {* Поле для свойства lblPhone }
   f_lblEmail: TvtLabel;
    {* Поле для свойства lblEmail }
   f_lblHint: TvtLabel;
    {* Поле для свойства lblHint }
   f_cbPhone: TnscEdit;
    {* Поле для свойства cbPhone }
   f_cbEmail: TnscEdit;
    {* Поле для свойства cbEmail }
  protected
   dsForbidAutoregistration: IdsForbidAutoregistration;
  private
   procedure cbEmailChange(Sender: TObject);
  protected
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make: IvcmEntityForm; reintroduce;
  public
   property lblReference: TvtLabel
    read f_lblReference;
    {* Введите координаты, по которым пользователи могут связаться с вами для регистрации в системе ГАРАНТ. }
   property gbInfo: TvtGroupBox
    read f_gbInfo;
    {* Администратор системы }
   property lblPhone: TvtLabel
    read f_lblPhone;
    {* Телефон }
   property lblEmail: TvtLabel
    read f_lblEmail;
    {* E-mail }
   property lblHint: TvtLabel
    read f_lblHint;
    {* (Заполнение одного из полей обязательно) }
   property cbPhone: TnscEdit
    read f_cbPhone;
   property cbEmail: TnscEdit
    read f_cbEmail;
 end;//TPrimForbidAutoregistrationForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , Graphics
 , nsVerifyValue
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *497ED39B034Fimpl_uses*
 //#UC END# *497ED39B034Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimForbidAutoregistrationForm.cbEmailChange(Sender: TObject);
//#UC START# *51C3165101B7_497ED39B034F_var*
const
 c_FontColor: array [Boolean] of TColor = (clRed, clWindowText);
//#UC END# *51C3165101B7_497ED39B034F_var*
begin
//#UC START# *51C3165101B7_497ED39B034F_impl*
 cbEmail.Font.Color := c_FontColor[nsEmailVerify.Verify(cbEmail.Text)];
//#UC END# *51C3165101B7_497ED39B034F_impl*
end;//TPrimForbidAutoregistrationForm.cbEmailChange

class function TPrimForbidAutoregistrationForm.Make: IvcmEntityForm;
var
 l_Inst : TPrimForbidAutoregistrationForm;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimForbidAutoregistrationForm.Make

procedure TPrimForbidAutoregistrationForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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

procedure TPrimForbidAutoregistrationForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimForbidAutoregistrationForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  dsForbidAutoregistration := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsForbidAutoregistration, dsForbidAutoregistration);
 end;//aNew = nil
end;//TPrimForbidAutoregistrationForm.SignalDataSourceChanged

procedure TPrimForbidAutoregistrationForm.MakeControls;
begin
 inherited;
 f_lblReference := TvtLabel.Create(Self);
 f_lblReference.Name := 'lblReference';
 f_lblReference.Parent := Self;
 f_lblReference.Caption := 'Введите координаты, по которым пользователи могут связаться с вами для регистрации в системе ГАРАНТ.';
 f_gbInfo := TvtGroupBox.Create(Self);
 f_gbInfo.Name := 'gbInfo';
 f_gbInfo.Parent := Self;
 f_gbInfo.Caption := 'Администратор системы';
 f_lblPhone := TvtLabel.Create(Self);
 f_lblPhone.Name := 'lblPhone';
 f_lblPhone.Parent := gbInfo;
 f_lblPhone.Caption := 'Телефон';
 f_lblEmail := TvtLabel.Create(Self);
 f_lblEmail.Name := 'lblEmail';
 f_lblEmail.Parent := gbInfo;
 f_lblEmail.Caption := 'E-mail';
 f_lblHint := TvtLabel.Create(Self);
 f_lblHint.Name := 'lblHint';
 f_lblHint.Parent := gbInfo;
 f_lblHint.Caption := '(Заполнение одного из полей обязательно)';
 f_cbPhone := TnscEdit.Create(Self);
 f_cbPhone.Name := 'cbPhone';
 f_cbPhone.Parent := gbInfo;
 f_cbEmail := TnscEdit.Create(Self);
 f_cbEmail.Name := 'cbEmail';
 f_cbEmail.Parent := gbInfo;
end;//TPrimForbidAutoregistrationForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimForbidAutoregistrationForm);
 {* Регистрация PrimForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
