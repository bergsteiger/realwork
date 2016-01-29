unit PrimStyleEditorContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorContainer_Form.pas"
// Начат: 02.10.2009 22:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimStyleEditorContainer
//
// Редактор стилей
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
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  ConfigInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  Settings_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimStyleEditorContainer_utStyleEditorContainer_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimStyleEditorContainerForm = {form} class(TvcmContainerForm)
  {* Редактор стилей }
 private
 // private fields
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_MainZone : TvtPanel;
    {* Поле для свойства MainZone}
   f_ParentZone : TvtSizeablePanel;
    {* Поле для свойства ParentZone}
   f_ChildZone : TvtPanel;
    {* Поле для свойства ChildZone}
   f_NavigatorZone : TvtSizeablePanel;
    {* Поле для свойства NavigatorZone}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure FormResize(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure VcmContainerFormCloseQueryEx(Sender: TObject;
     var CanClose: Boolean;
     aCaller: TCustomForm);
 protected
 // realized methods
   procedure StyleEditor_ReloadStyleTable_Execute;
   procedure StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_SettingsInfo : InsStyleTableSettingsInfo;
 protected
 // protected methods
   procedure DoUpdateCaption;
     {* Сигнатура метода DoUpdateCaption }
 public
 // public methods
   class function Make(const aData: InsStyleTableSettingsInfo;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read f_BackgroundPanel;
   property MainZone: TvtPanel
     read f_MainZone;
   property ParentZone: TvtSizeablePanel
     read f_ParentZone;
   property ChildZone: TvtPanel
     read f_ChildZone;
   property NavigatorZone: TvtSizeablePanel
     read f_NavigatorZone;
 end;//TPrimStyleEditorContainerForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  afwFacade,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utStyleEditorContainerLocalConstants }
  str_utStyleEditorContainerCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorContainerCaption'; rValue : 'Редактор стилей');
   { Заголовок пользовательского типа "Редактор стилей" }

// start class TPrimStyleEditorContainerForm

procedure TPrimStyleEditorContainerForm.FormResize(Sender: TObject);
//#UC START# *526A55940144_4AC6402401E4_var*
//#UC END# *526A55940144_4AC6402401E4_var*
begin
//#UC START# *526A55940144_4AC6402401E4_impl*
 // fix: для нормального поведения при изменении размеров формы, если у нее стоят ограничения.
 if ((f_NavigatorZone.Width + f_MainZone.Width) > ClientWidth) then
  if ClientWidth > f_MainZone.Width then
   f_NavigatorZone.Width := ClientWidth - f_MainZone.Width;
//#UC END# *526A55940144_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.FormResize

procedure TPrimStyleEditorContainerForm.VcmContainerFormCloseQueryEx(Sender: TObject;
  var CanClose: Boolean;
  aCaller: TCustomForm);
//#UC START# *526A55DF0164_4AC6402401E4_var*
//#UC END# *526A55DF0164_4AC6402401E4_var*
begin
//#UC START# *526A55DF0164_4AC6402401E4_impl*
 if not defDataAdapter.InTerminateProcess then
 begin
  if (ModalResult = mrCancel) and f_SettingsInfo.Modified then
   if Ask(qr_StyleTableChanged) then
    f_SettingsInfo.Load
   else
    CanClose := False;
 end;
//#UC END# *526A55DF0164_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.VcmContainerFormCloseQueryEx

class function TPrimStyleEditorContainerForm.Make(const aData: InsStyleTableSettingsInfo;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimStyleEditorContainerForm);
 begin
  with aForm do
  begin
//#UC START# *4AE06B82037F_4AC6402401E4_impl*
   f_SettingsInfo := aData;
   if not f_SettingsInfo.IsActive then
    f_SettingsInfo.Load;
   DoUpdateCaption;
//#UC END# *4AE06B82037F_4AC6402401E4_impl*
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

procedure TPrimStyleEditorContainerForm.DoUpdateCaption;
//#UC START# *526A556A020C_4AC6402401E4_var*
var
 l_Caption: String;
 l_CaptionLength: Integer;
//#UC END# *526A556A020C_4AC6402401E4_var*
begin
//#UC START# *526A556A020C_4AC6402401E4_impl*
 l_Caption := Caption;
 l_CaptionLength := Length(l_Caption);
 if f_SettingsInfo.Modified or f_SettingsInfo.IsDifferFromDefault then
 begin
  if ((l_CaptionLength = 0) or (l_Caption[l_CaptionLength] <> '*')) then
   l_Caption := l_Caption+' *';
 end
 else
 begin
  if ((l_CaptionLength > 1) and (l_Caption[l_CaptionLength] = '*')) then
   Delete(l_Caption, l_CaptionLength-1, 2);
 end;
 Caption := l_Caption;
//#UC END# *526A556A020C_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.DoUpdateCaption

procedure TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable_Execute;
//#UC START# *4AF8660E0079_4AC6402401E4exec_var*
//#UC END# *4AF8660E0079_4AC6402401E4exec_var*
begin
//#UC START# *4AF8660E0079_4AC6402401E4exec_impl*
 DoUpdateCaption;
//#UC END# *4AF8660E0079_4AC6402401E4exec_impl*
end;//TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable_Execute

procedure TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParams);
begin
 StyleEditor_ReloadStyleTable_Execute;
end;

procedure TPrimStyleEditorContainerForm.Cleanup;
//#UC START# *479731C50290_4AC6402401E4_var*
//#UC END# *479731C50290_4AC6402401E4_var*
begin
//#UC START# *479731C50290_4AC6402401E4_impl*
 f_SettingsInfo := nil;
 inherited;
//#UC END# *479731C50290_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.Cleanup

procedure TPrimStyleEditorContainerForm.InitFields;
//#UC START# *47A042E100E2_4AC6402401E4_var*
//#UC END# *47A042E100E2_4AC6402401E4_var*
begin
//#UC START# *47A042E100E2_4AC6402401E4_impl*
 inherited;
 ActiveControl := f_NavigatorZone;
 Constraints.MinHeight := 510;
 Constraints.MinWidth := 650;
 Position := poOwnerFormCenter;
 OnResize := FormResize;
 OnCloseQueryEx := vcmContainerFormCloseQueryEx;
//#UC END# *47A042E100E2_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimStyleEditorContainerForm.InitControls;
//#UC START# *4A8E8F2E0195_4AC6402401E4_var*
//#UC END# *4A8E8F2E0195_4AC6402401E4_var*
begin
//#UC START# *4A8E8F2E0195_4AC6402401E4_impl*
 inherited;
 with BackgroundPanel do
 begin
  align := alClient;
  BevelOuter := bvNone;
 end;
 with MainZone do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinWidth := 480;
  TabOrder := 0;
 end;
  with ParentZone do
  begin
   SizeableSides := [szBottom];
   Align := alTop;
   BevelOuter := bvNone;
   if afw.Application.IsInternal then
    Height := 240
   else
    Height := 150;

   Constraints.MinHeight := Height;
   TabOrder := 0;
  end;
  with ChildZone do
  begin
   Align := alClient;
   BevelOuter := bvNone;
   TabOrder := 1;
  end;
 with NavigatorZone do
 begin
  Width := 182;
  ResizeAreaWidth := 5;
  SizeableSides := [szRight];
  SplitterBevel := bvRaised;
  Align := alLeft;
  BevelOuter := bvNone;
  Constraints.MinWidth := 182;
  TabOrder := 1;
 end;
//#UC END# *4A8E8F2E0195_4AC6402401E4_impl*
end;//TPrimStyleEditorContainerForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimStyleEditorContainerForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_StyleEditor, nil);
  PublishOpWithResult(en_StyleEditor, op_ReloadStyleTable, StyleEditor_ReloadStyleTable, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimStyleEditorContainerForm.MakeControls;
begin
 inherited;
 with AddUsertype(utStyleEditorContainerName,
  str_utStyleEditorContainerCaption,
  str_utStyleEditorContainerCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utStyleEditorContainerName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_MainZone := TvtPanel.Create(Self);
 f_MainZone.Name := 'MainZone';
 f_MainZone.Parent := BackgroundPanel;
 f_ParentZone := TvtSizeablePanel.Create(Self);
 f_ParentZone.Name := 'ParentZone';
 f_ParentZone.Parent := MainZone;
 with DefineZone(vcm_ztParent, f_ParentZone) do
 begin
 end;//with DefineZone(vcm_ztParent, f_ParentZone)
 f_ChildZone := TvtPanel.Create(Self);
 f_ChildZone.Name := 'ChildZone';
 f_ChildZone.Parent := MainZone;
 with DefineZone(vcm_ztChild, f_ChildZone) do
 begin
 end;//with DefineZone(vcm_ztChild, f_ChildZone)
 f_NavigatorZone := TvtSizeablePanel.Create(Self);
 f_NavigatorZone.Name := 'NavigatorZone';
 f_NavigatorZone.Parent := BackgroundPanel;
 with DefineZone(vcm_ztNavigator, f_NavigatorZone) do
 begin
 end;//with DefineZone(vcm_ztNavigator, f_NavigatorZone)
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utStyleEditorContainerCaption
 str_utStyleEditorContainerCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimStyleEditorContainer
 TtfwClassRef.Register(TPrimStyleEditorContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.