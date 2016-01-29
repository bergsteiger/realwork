unit PrimPictureInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimPictureInfo_Form.pas"
// Начат: 16.09.2009 22:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Picture::PrimPictureInfo
//
// Информация о картинке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  DocumentDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  eeMemoWithEditOperations,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimPictureInfoForm = {form} class(TvcmEntityForm)
  {* Информация о картинке }
 private
 // private fields
   f_Info : TeeMemoWithEditOperations;
    {* Поле для свойства Info}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
 public
 // public methods
   class function Make(const aData: InsLinkedObjectDescription;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property Info: TeeMemoWithEditOperations
     read f_Info;
 end;//TPrimPictureInfoForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String
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
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimPictureInfoForm

class function TPrimPictureInfoForm.Make(const aData: InsLinkedObjectDescription;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimPictureInfoForm);
 begin
  with aForm do
  begin
//#UC START# *4AC4F7760311_4AB12F7601D3_impl*
   Info.Text := l3Str(vcmFmt(str_PictureInfoTemplate, [aData.Name, aData.ShortName, aData.ID]));
//#UC END# *4AC4F7760311_4AB12F7601D3_impl*
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
end;

{$If not defined(NoVCM)}
procedure TPrimPictureInfoForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AC5D61E0284_4AB12F7601D3test_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3test_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3test_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_4AB12F7601D3test_impl*
end;//TPrimPictureInfoForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureInfoForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4AC5D61E0284_4AB12F7601D3getstate_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3getstate_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3getstate_impl*
 State := st_user_Result_Cancel_Close;
//#UC END# *4AC5D61E0284_4AB12F7601D3getstate_impl*
end;//TPrimPictureInfoForm.Result_Cancel_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureInfoForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AC5D61E0284_4AB12F7601D3exec_var*
//#UC END# *4AC5D61E0284_4AB12F7601D3exec_var*
begin
//#UC START# *4AC5D61E0284_4AB12F7601D3exec_impl*
 ModalResult := mrCancel;
//#UC END# *4AC5D61E0284_4AB12F7601D3exec_impl*
end;//TPrimPictureInfoForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureInfoForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPictureInfoForm.SetupFormLayout;
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
{$IfEnd} //not NoVCM

procedure TPrimPictureInfoForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, Info);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimPictureInfoForm.MakeControls;
begin
 inherited;
 f_Info := TeeMemoWithEditOperations.Create(Self);
 f_Info.Name := 'Info';
 f_Info.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimPictureInfo
 TtfwClassRef.Register(TPrimPictureInfoForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.