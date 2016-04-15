unit PrimStyleEditorContainer_Form;
 {* Редактор стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorContainer_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimStyleEditorContainer" MUID: (4AC6402401E4)
// Имя типа: "TPrimStyleEditorContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 , ConfigInterfaces
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 // Parent

 // Child

 // Navigator

 TPrimStyleEditorContainerForm = class(TvcmContainerForm)
  {* Редактор стилей }
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel }
   f_MainZone: TvtPanel;
    {* Поле для свойства MainZone }
   f_ParentZone: TvtSizeablePanel;
    {* Поле для свойства ParentZone }
   f_ChildZone: TvtPanel;
    {* Поле для свойства ChildZone }
   f_NavigatorZone: TvtSizeablePanel;
    {* Поле для свойства NavigatorZone }
  protected
   f_SettingsInfo: InsStyleTableSettingsInfo;
  private
   procedure FormResize(Sender: TObject);
   procedure vcmContainerFormCloseQueryEx(Sender: TObject;
    var CanClose: Boolean;
    aCaller: TCustomForm);
  protected
   procedure DoUpdateCaption;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsStyleTableSettingsInfo); reintroduce;
   procedure StyleEditor_ReloadStyleTable_Execute;
   procedure StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParamsPrim);
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
 end;//TPrimStyleEditorContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , DataAdapter
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimStyleEditorContainer_utStyleEditorContainer_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utStyleEditorContainerLocalConstants }
 str_utStyleEditorContainerCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorContainerCaption'; rValue : 'Редактор стилей');
  {* Заголовок пользовательского типа "Редактор стилей" }

class function TPrimStyleEditorContainerForm.Make(const aData: InsStyleTableSettingsInfo);
var
 l_Inst : TPrimStyleEditorContainerForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimStyleEditorContainerForm.Make

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

procedure TPrimStyleEditorContainerForm.vcmContainerFormCloseQueryEx(Sender: TObject;
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
end;//TPrimStyleEditorContainerForm.vcmContainerFormCloseQueryEx

procedure TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable_Execute;
//#UC START# *4AF8660E0079_4AC6402401E4exec_var*
//#UC END# *4AF8660E0079_4AC6402401E4exec_var*
begin
//#UC START# *4AF8660E0079_4AC6402401E4exec_impl*
 DoUpdateCaption;
//#UC END# *4AF8660E0079_4AC6402401E4exec_impl*
end;//TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable_Execute

procedure TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable(const aParams: IvcmExecuteParamsPrim);
begin
 Self.StyleEditor_ReloadStyleTable_Execute;
end;//TPrimStyleEditorContainerForm.StyleEditor_ReloadStyleTable

procedure TPrimStyleEditorContainerForm.Cleanup;
 {* Функция очистки полей объекта. }
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

procedure TPrimStyleEditorContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

initialization
 str_utStyleEditorContainerCaption.Init;
 {* Инициализация str_utStyleEditorContainerCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorContainerForm);
 {* Регистрация PrimStyleEditorContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
