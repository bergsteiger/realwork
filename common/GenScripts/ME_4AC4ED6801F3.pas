unit PrimGroupProperty_Form;
 {* Свойства группы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimGroupProperty_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtLabel
;

type
 TPrimGroupPropertyForm = class(TvcmEntityForm)
  {* Свойства группы }
  private
   f_edName: TnscEdit;
    {* Поле для свойства edName }
   f_Label1: TvtLabel;
    {* Поле для свойства Label1 }
  protected
   f_Data: IbsEditGroupName;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IbsEditGroupName): Result; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
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
  public
   property edName: TnscEdit
    read f_edName;
   property Label1: TvtLabel
    read f_Label1;
    {* Имя группы }
 end;//TPrimGroupPropertyForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки admCreateGroupLocalConstants }
 str_admCreateGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admCreateGroupCaption'; rValue : 'Новая группа');
  {* Заголовок пользовательского типа "Новая группа" }
 {* Локализуемые строки admRenameGroupLocalConstants }
 str_admRenameGroupCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admRenameGroupCaption'; rValue : 'Переименовать группу');
  {* Заголовок пользовательского типа "Переименовать группу" }

class function TPrimGroupPropertyForm.Make(const aData: IbsEditGroupName): Result;
var
 l_Inst : TPrimGroupPropertyForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimGroupPropertyForm.Make

procedure TPrimGroupPropertyForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC4ED6801F3test_var*
//#UC END# *4A8AD46D0226_4AC4ED6801F3test_var*
begin
//#UC START# *4A8AD46D0226_4AC4ED6801F3test_impl*
 // - ничего не делаем
//#UC END# *4A8AD46D0226_4AC4ED6801F3test_impl*
end;//TPrimGroupPropertyForm.Result_Cancel_Test

procedure TPrimGroupPropertyForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4AC4ED6801F3exec_var*
//#UC END# *4A8AD46D0226_4AC4ED6801F3exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4ED6801F3exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4ED6801F3exec_impl*
end;//TPrimGroupPropertyForm.Result_Cancel_Execute

procedure TPrimGroupPropertyForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4ED6801F3test_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3test_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not l3IsNil(edName.CText);
//#UC END# *4A97EBE702F8_4AC4ED6801F3test_impl*
end;//TPrimGroupPropertyForm.Result_Ok_Test

procedure TPrimGroupPropertyForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4ED6801F3exec_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3exec_impl*
 f_Data.Name := edName.CText;
 ModalResult := mrOk;
//#UC END# *4A97EBE702F8_4AC4ED6801F3exec_impl*
end;//TPrimGroupPropertyForm.Result_Ok_Execute

procedure TPrimGroupPropertyForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4AC4ED6801F3getstate_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4ED6801F3getstate_impl*
end;//TPrimGroupPropertyForm.Result_Ok_GetState

procedure TPrimGroupPropertyForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AC4ED6801F3_var*
//#UC END# *479731C50290_4AC4ED6801F3_var*
begin
//#UC START# *479731C50290_4AC4ED6801F3_impl*
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Cleanup

procedure TPrimGroupPropertyForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AC4ED6801F3_var*
//#UC END# *4A8E8F2E0195_4AC4ED6801F3_var*
begin
//#UC START# *4A8E8F2E0195_4AC4ED6801F3_impl*
 BorderIcons := [biSystemMenu];
 BorderStyle := bsDialog;
 ClientHeight := 39;
 ClientWidth := 279;
 ShowHint := True;

 with Label1 do
 begin
  Left := 8;
  Top := 12;
  AutoSize := False;
  Width := 105;
  Height := 16;
 end;

 with edName do
 begin
  Left := 120;
  Top := 8;
  Width := 153;
  Height := 21;
  TabOrder := 0;
  ParentShowHint := False;
  ShowHint := True;
 end;
//#UC END# *4A8E8F2E0195_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.InitControls

initialization
 str_admCreateGroupCaption.Init;
 {* Инициализация str_admCreateGroupCaption }
 str_admRenameGroupCaption.Init;
 {* Инициализация str_admRenameGroupCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimGroupPropertyForm);
 {* Регистрация PrimGroupProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(Admin)
end.
