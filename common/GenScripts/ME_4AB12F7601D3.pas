unit PrimPictureInfo_Form;
 {* Информация о картинке }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPictureInfo_Form.pas"
// Стереотип: "VCMForm"

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
  {* Информация о картинке }
  private
   f_Info: TeeMemoWithEditOperations;
    {* Поле для свойства Info }
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsLinkedObjectDescription): Result; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
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

class function TPrimPictureInfoForm.Make(const aData: InsLinkedObjectDescription): Result;
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

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoForm.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4AB12F7601D3_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AB12F7601D3_impl*
end;//TPrimPictureInfoForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4AB12F7601D3_var*
//#UC END# *4C762C910358_4AB12F7601D3_var*
begin
//#UC START# *4C762C910358_4AB12F7601D3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4AB12F7601D3_impl*
end;//TPrimPictureInfoForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureInfoForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureInfoForm);
 {* Регистрация PrimPictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
