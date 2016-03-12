unit PrimProgressIndicator_Form;
 {* Индикатор прогресса }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimProgressIndicator_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVGScene)}
 , vtVGButton
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_scene
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

const
 WM_USER_SET_CURRENT = WM_USER + $0101;
 WM_USER_FINISH_PROCESS = WM_USER + $0102;

type
 TPrimProgressIndicatorForm = class(TvcmEntityForm)
  {* Индикатор прогресса }
  private
   f_CancelButton: TvtVGButton;
   f_Scene: TvgScene;
   f_Background: TvgBackground;
   f_ProgressBar: TProgressBar;
    {* Поле для свойства ProgressBar }
  protected
   f_Owner: InsProgressIndicator;
   f_Caption: Il3CString;
   f_SearchStarted: Boolean;
   f_SearchFinished: Boolean;
   f_SearchFinishing: Boolean;
  private
   procedure VcmEntityFormRefCloseQuery(Sender: TObject;
    var CanClose: Boolean);
   procedure WMUserSetCurrent(var Message: TMessage); message WM_USER_SET_CURRENT;
   procedure WMUserFinishProcess(var Message: TMessage); message WM_USER_FINISH_PROCESS;
  protected
   function pm_GetProgressBar: TProgressBar;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer): BadFactoryType; reintroduce;
  public
   property ProgressBar: TProgressBar
    read pm_GetProgressBar;
 end;//TPrimProgressIndicatorForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3Defaults
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , vtDialogsResEx
 , l3String
 , l3Math
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 {$If NOT Defined(NoVGScene)}
 , vtVGSceneRes
 {$IfEnd} // NOT Defined(NoVGScene)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utProgressIndicatorLocalConstants }
 str_utProgressIndicatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utProgressIndicatorCaption'; rValue : 'Ход выполнения');
  {* Заголовок пользовательского типа "Ход выполнения" }
 str_utProgressIndicatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utProgressIndicatorSettingsCaption'; rValue : 'Ход выполнения');
  {* Заголовок пользовательского типа "Ход выполнения" для настройки панелей инструментов }
 {* Локализуемые строки ProgressIndicatorLocalConst }
 str_CancelButtonCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CancelButtonCaption'; rValue : '&Отмена');
  {* '&Отмена' }

function TPrimProgressIndicatorForm.pm_GetProgressBar: TProgressBar;
//#UC START# *4AC627D2039B_4A93F1980324get_var*
//#UC END# *4AC627D2039B_4A93F1980324get_var*
begin
//#UC START# *4AC627D2039B_4A93F1980324get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC627D2039B_4A93F1980324get_impl*
end;//TPrimProgressIndicatorForm.pm_GetProgressBar

procedure TPrimProgressIndicatorForm.VcmEntityFormRefCloseQuery(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *50F98967031E_4A93F1980324_var*
//#UC END# *50F98967031E_4A93F1980324_var*
begin
//#UC START# *50F98967031E_4A93F1980324_impl*
 if Assigned(f_Owner) and not f_SearchFinished then
 begin
  CanClose := False;
  if not f_SearchFinishing then
  begin
   f_Owner.StopProcess;
   f_SearchFinishing := True;
  end;
 end;
//#UC END# *50F98967031E_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.VcmEntityFormRefCloseQuery

class function TPrimProgressIndicatorForm.Make(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer): BadFactoryType;
var
 l_Inst : TPrimProgressIndicatorForm;
begin
 l_Inst := Create(aProgress, aCaption, aMaxCount);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimProgressIndicatorForm.Make

procedure TPrimProgressIndicatorForm.WMUserSetCurrent(var Message: TMessage);
//#UC START# *50F98780007B_4A93F1980324_var*
var
 l_Percentage: LongInt;
//#UC END# *50F98780007B_4A93F1980324_var*
begin
//#UC START# *50F98780007B_4A93F1980324_impl*
 ProgressBar.Position := Message.WParam;
 if (Message.WParam > 0) then
 begin
  l_Percentage := l3MulDiv(ProgressBar.Position,100,ProgressBar.Max);
  CCaption := l3Cat([f_Caption, vcmFmt(str_ProgressSuffix, [l_Percentage])])
 end
 else
 begin
  CCaption := f_Caption;
  l_Percentage := 0;
 end;
 f_CancelButton.Enabled := l_Percentage < 100;
 f_CancelButton.Repaint;
 Message.Result := 0;
//#UC END# *50F98780007B_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.WMUserSetCurrent

procedure TPrimProgressIndicatorForm.WMUserFinishProcess(var Message: TMessage);
//#UC START# *50F987AA03D9_4A93F1980324_var*
//#UC END# *50F987AA03D9_4A93F1980324_var*
begin
//#UC START# *50F987AA03D9_4A93F1980324_impl*
 Message.Result := 0;
 f_CancelButton.Repaint;
 f_SearchFinished := True;
 ModalResult := mrCancel;
//#UC END# *50F987AA03D9_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.WMUserFinishProcess

procedure TPrimProgressIndicatorForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A93F1980324_var*
//#UC END# *479731C50290_4A93F1980324_var*
begin
//#UC START# *479731C50290_4A93F1980324_impl*
 f_Owner := nil;
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.Cleanup

procedure TPrimProgressIndicatorForm.BecomeActive;
//#UC START# *4A8AE0FA03B2_4A93F1980324_var*
//#UC END# *4A8AE0FA03B2_4A93F1980324_var*
begin
//#UC START# *4A8AE0FA03B2_4A93F1980324_impl*
 inherited;
 if Assigned(f_Owner) and not f_SearchStarted then
 begin
  f_SearchStarted := True;
  f_Owner.StartProcess(self.Entity);
 end;//Assigned(f_Owner) and not f_SearchStarted
//#UC END# *4A8AE0FA03B2_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.BecomeActive

procedure TPrimProgressIndicatorForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A93F1980324_var*
var
 l_Top : Integer;
//#UC END# *4A8E8F2E0195_4A93F1980324_var*
begin
//#UC START# *4A8E8F2E0195_4A93F1980324_impl*
 inherited;

 OnCloseQuery := VcmEntityFormRefCloseQuery;

 Self.Color := cGarant2011BackColor;
 Self.ClientHeight := 71;
 Self.ClientWidth := 425;
 Self.BorderIcons := [];
 Self.BorderStyle := bsSingle;
 Self.Position := poScreenCenter;

 with ProgressBar do
 begin
  SetBounds(8, 8, 409, 25);
 end;
 
 f_BackGround := TvgBackGround.Create(Self);
 with f_BackGround do
 begin
  Fill.Style := vgBrushSolid;
  Fill.Color := vgColorToStr($FF000000 OR Cardinal(ColorToRGB(Self.Color)));
 end;

 f_Scene := TvgScene.Create(Self);
 with f_Scene do
 begin
  Parent := Self;
  AddObject(f_BackGround);
  l_Top := ProgressBar.BoundsRect.Bottom;
  SetBounds(0, l_Top, Self.Width, Self.Height - l_Top);
  Style := vtVGSceneResources.vgResources;
 end;
 f_CancelButton := TvtVGButton.Create(Self);
 with f_CancelButton do
 begin
  Name := 'CancelButton';
  Parent := TvgObject(f_Scene.Root);
  SetBounds(l3MulDiv(Self.Width - Round(Width), 1, 2),
            l3MulDiv(Round(Height), 1, 3),
            Round(Width),
            Round(Height));
  Resource := cButtonStyleLayoutName;
  Font.Assign(Self.Font);
  Cancel := True;
  Caption := str_CancelButtonCaption.AsStr;
  Default := True;
  ModalResult := mrCancel;
  Text := l3WideString(vtGetDlgBtnCaption(mbCancel));
  TabOrder := 0;
 end;
 Self.ActiveControl := f_Scene;
 f_Scene.ActiveControl := f_CancelButton;
//#UC END# *4A8E8F2E0195_4A93F1980324_impl*
end;//TPrimProgressIndicatorForm.InitControls

initialization
 str_utProgressIndicatorCaption.Init;
 {* Инициализация str_utProgressIndicatorCaption }
 str_utProgressIndicatorSettingsCaption.Init;
 {* Инициализация str_utProgressIndicatorSettingsCaption }
 str_CancelButtonCaption.Init;
 {* Инициализация str_CancelButtonCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimProgressIndicatorForm);
 {* Регистрация PrimProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
