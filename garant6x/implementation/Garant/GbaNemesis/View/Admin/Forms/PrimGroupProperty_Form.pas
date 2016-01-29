unit PrimGroupProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimGroupProperty_Form.pas"
// Начат: 01.10.2009 21:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimGroupProperty
//
// Свойства группы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  AdminInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  l3StringIDEx,
  PrimGroupProperty_admCreateGroup_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimGroupProperty_admRenameGroup_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimGroupPropertyForm = {form} class(TvcmEntityForm)
  {* Свойства группы }
 private
 // private fields
   f_edName : TnscEdit;
    {* Поле для свойства edName}
   f_Label1 : TvtLabel;
    {* Поле для свойства Label1}
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
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_Data : IbsEditGroupName;
 public
 // public methods
   class function Make(const aData: IbsEditGroupName;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property edName: TnscEdit
     read f_edName;
   property Label1: TvtLabel
     read f_Label1;
     {* Имя группы }
 end;//TPrimGroupPropertyForm
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3String
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

var
   { Локализуемые строки admCreateGroupLocalConstants }
  str_admCreateGroupCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admCreateGroupCaption'; rValue : 'Новая группа');
   { Заголовок пользовательского типа "Новая группа" }

var
   { Локализуемые строки admRenameGroupLocalConstants }
  str_admRenameGroupCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admRenameGroupCaption'; rValue : 'Переименовать группу');
   { Заголовок пользовательского типа "Переименовать группу" }

// start class TPrimGroupPropertyForm

class function TPrimGroupPropertyForm.Make(const aData: IbsEditGroupName;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimGroupPropertyForm);
 begin
  with aForm do
  begin
//#UC START# *4AC4EDA102E4_4AC4ED6801F3_impl*
   f_Data := aData;
   Assert(Assigned(f_Data));
   edName.CText := f_Data.Name;
   Position := poScreenCenter;
//#UC END# *4AC4EDA102E4_4AC4ED6801F3_impl*
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
procedure TPrimGroupPropertyForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD46D0226_4AC4ED6801F3test_var*
//#UC END# *4A8AD46D0226_4AC4ED6801F3test_var*
begin
//#UC START# *4A8AD46D0226_4AC4ED6801F3test_impl*
 // - ничего не делаем
//#UC END# *4A8AD46D0226_4AC4ED6801F3test_impl*
end;//TPrimGroupPropertyForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupPropertyForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AC4ED6801F3exec_var*
//#UC END# *4A8AD46D0226_4AC4ED6801F3exec_var*
begin
//#UC START# *4A8AD46D0226_4AC4ED6801F3exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4AC4ED6801F3exec_impl*
end;//TPrimGroupPropertyForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupPropertyForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AC4ED6801F3test_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3test_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not l3IsNil(edName.CText);
//#UC END# *4A97EBE702F8_4AC4ED6801F3test_impl*
end;//TPrimGroupPropertyForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupPropertyForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AC4ED6801F3getstate_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3getstate_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3getstate_impl*
 // - ничего не делаем
//#UC END# *4A97EBE702F8_4AC4ED6801F3getstate_impl*
end;//TPrimGroupPropertyForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimGroupPropertyForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AC4ED6801F3exec_var*
//#UC END# *4A97EBE702F8_4AC4ED6801F3exec_var*
begin
//#UC START# *4A97EBE702F8_4AC4ED6801F3exec_impl*
 f_Data.Name := edName.CText;
 ModalResult := mrOk;
//#UC END# *4A97EBE702F8_4AC4ED6801F3exec_impl*
end;//TPrimGroupPropertyForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimGroupPropertyForm.Cleanup;
//#UC START# *479731C50290_4AC4ED6801F3_var*
//#UC END# *479731C50290_4AC4ED6801F3_var*
begin
//#UC START# *479731C50290_4AC4ED6801F3_impl*
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4AC4ED6801F3_impl*
end;//TPrimGroupPropertyForm.Cleanup

{$If not defined(NoVCM)}
procedure TPrimGroupPropertyForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimGroupPropertyForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ContextMenuWeight(en_Result, op_Cancel, 10);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TPrimGroupPropertyForm.MakeControls;
begin
 inherited;
 f_edName := TnscEdit.Create(Self);
 f_edName.Name := 'edName';
 f_edName.Parent := Self;
 with AddUsertype(admCreateGroupName,
  str_admCreateGroupCaption,
  str_admCreateGroupCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(admCreateGroupName
 with AddUsertype(admRenameGroupName,
  str_admRenameGroupCaption,
  str_admRenameGroupCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(admRenameGroupName
 f_Label1 := TvtLabel.Create(Self);
 f_Label1.Name := 'Label1';
 f_Label1.Parent := Self;
 f_Label1.Caption := 'Имя группы';
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_admCreateGroupCaption
 str_admCreateGroupCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_admRenameGroupCaption
 str_admRenameGroupCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimGroupProperty
 TtfwClassRef.Register(TPrimGroupPropertyForm);
{$IfEnd} //Admin AND not NoScripts

end.