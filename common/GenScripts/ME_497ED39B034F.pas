unit PrimForbidAutoregistration_Form;
 {* Используется при запрете авторегистрации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimForbidAutoregistration_Form.pas"
// Стереотип: "VCMForm"

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
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimForbidAutoregistrationForm = class(TvcmEntityForm)
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
  public
   class function Make: BadFactoryType; reintroduce;
  public
   property lblReference: TvtLabel
    read f_lblReference;
    {* Введите координаты, по которым пользователи могут связаться с вами для регистрации в системе ГАРАНТ. }
   property gbInfo: TvtGroupBox
    read f_gbInfo;
    {* Администратор системы }
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

class function TPrimForbidAutoregistrationForm.Make: BadFactoryType;
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimForbidAutoregistrationForm);
 {* Регистрация PrimForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
