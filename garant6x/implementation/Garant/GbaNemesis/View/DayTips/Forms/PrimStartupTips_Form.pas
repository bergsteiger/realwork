unit PrimStartupTips_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/Forms/PrimStartupTips_Form.pas"
// Начат: 01.10.2009 22:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::DayTips::View::DayTips::PrimStartupTips
//
// Совет дня
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
  l3Interfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  DayTipsInterfaces,
  vtPanel,
  vtFocusLabel,
  vtLabel,
  vtCheckBox,
  ElPopBtn,
  Windows,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimStartupTipsForm = {form} class(TvcmEntityForm, Il3WndProcListener)
  {* Совет дня }
 private
 // private fields
   f_TopPanel : TvtPanel;
    {* Поле для свойства TopPanel}
   f_TitlePaintBox : TPaintBox;
    {* Поле для свойства TitlePaintBox}
   f_TitleLabel : TvtLabel;
    {* Поле для свойства TitleLabel}
   f_BottomPanel : TvtPanel;
    {* Поле для свойства BottomPanel}
   f_HintPanel : TvtPanel;
    {* Поле для свойства HintPanel}
   f_TipLabel : TvtLabel;
    {* Поле для свойства TipLabel}
   f_DetailLabel : TvtFocusLabel;
    {* Поле для свойства DetailLabel}
   f_ShowCheckBox : TvtCheckBox;
    {* Поле для свойства ShowCheckBox}
   f_wwwPanel : TvtPanel;
    {* Поле для свойства wwwPanel}
   f_wwwPaintBox : TPaintBox;
    {* Поле для свойства wwwPaintBox}
   f_wwwLabel : TvtFocusLabel;
    {* Поле для свойства wwwLabel}
   f_NextButton : TElPopupButton;
    {* Поле для свойства NextButton}
   f_PrevButton : TElPopupButton;
    {* Поле для свойства PrevButton}
   f_CloseButton : TElPopupButton;
    {* Поле для свойства CloseButton}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure UpdateTip;
     {* Сигнатура метода UpdateTip }
   procedure TitlePaintBoxPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure WwwPaintBoxPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure CloseButtonClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure VcmEntityFormShow(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure WwwLabelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DetailLabelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure NextButtonClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure PrevButtonClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ShowCheckBoxClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
 protected
 // realized methods
   procedure WndProcListenerNotify(Msg: PCWPStruct;
     var theResult: Tl3HookProcResult);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetNeedSaveToTabHistory: Boolean; override;
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_Data : InsStartupTips;
 public
 // public methods
   class function MakeSingleChild(const aData: InsStartupTips;
    const aCont   : IvcmContainer;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property TopPanel: TvtPanel
     read f_TopPanel;
   property TitlePaintBox: TPaintBox
     read f_TitlePaintBox;
   property TitleLabel: TvtLabel
     read f_TitleLabel;
     {* Знаете ли Вы, что... }
   property BottomPanel: TvtPanel
     read f_BottomPanel;
   property HintPanel: TvtPanel
     read f_HintPanel;
   property TipLabel: TvtLabel
     read f_TipLabel;
   property DetailLabel: TvtFocusLabel
     read f_DetailLabel;
     {* См. подробнее }
   property ShowCheckBox: TvtCheckBox
     read f_ShowCheckBox;
     {* Не показывать совет дня при запуске }
   property wwwPanel: TvtPanel
     read f_wwwPanel;
   property wwwPaintBox: TPaintBox
     read f_wwwPaintBox;
   property wwwLabel: TvtFocusLabel
     read f_wwwLabel;
     {* Советы дня в Новостях онлайн }
   property NextButton: TElPopupButton
     read f_NextButton;
     {* Следующий }
   property PrevButton: TElPopupButton
     read f_PrevButton;
     {* Предыдущий }
   property CloseButton: TElPopupButton
     read f_CloseButton;
     {* Закрыть }
 end;//TPrimStartupTipsForm

 TvcmEntityFormRef = TPrimStartupTipsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsConst
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vtNavigatorUtils
  {$IfEnd} //not NoVCM
  ,
  l3ListenersManager
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorShapeMisc
  {$IfEnd} //evUseVisibleCursors
  ,
  SysUtils,
  Graphics,
  afwFacade
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

// start class TPrimStartupTipsForm

procedure TPrimStartupTipsForm.UpdateTip;
//#UC START# *5268E6380393_4AC4F49F010B_var*
var
 l_Delta: Integer;
//#UC END# *5268E6380393_4AC4F49F010B_var*
begin
//#UC START# *5268E6380393_4AC4F49F010B_impl*
 if Assigned(f_Data) then
 begin
  TipLabel.Autosize := False;
  try
   TipLabel.Width := HintPanel.Width - 2 * TipLabel.Left;
   TipLabel.CCaption := f_Data.TipCaption;
  finally
   TipLabel.Autosize := True;
  end;
 end;
 l_Delta := TipLabel.Top + TipLabel.Height - (DetailLabel.Top - DetailLabel.Height);
 if l_Delta > 0 then
 begin
  Height := Height + l_Delta;
  wwwPanel.Top := wwwPanel.Top + l_Delta;
  ShowCheckBox.Top := ShowCheckBox.Top + l_Delta;
  HintPanel.Height := HintPanel.Height + l_Delta;
  DetailLabel.Top := DetailLabel.Top + l_Delta;
  CloseButton.Top := CloseButton.Top + l_Delta;
 end;

 l_Delta := CloseButton.Top + CloseButton.Height + 16 - BottomPanel.Height;
 if l_Delta > 0 then
  Height := Height + l_Delta;
//#UC END# *5268E6380393_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.UpdateTip

procedure TPrimStartupTipsForm.TitlePaintBoxPaint(Sender: TObject);
//#UC START# *5268E6B602FF_4AC4F49F010B_var*
//#UC END# *5268E6B602FF_4AC4F49F010B_var*
begin
//#UC START# *5268E6B602FF_4AC4F49F010B_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cDayTips);
//#UC END# *5268E6B602FF_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.TitlePaintBoxPaint

procedure TPrimStartupTipsForm.WwwPaintBoxPaint(Sender: TObject);
//#UC START# *5268E6C000C2_4AC4F49F010B_var*
//#UC END# *5268E6C000C2_4AC4F49F010B_var*
begin
//#UC START# *5268E6C000C2_4AC4F49F010B_impl*
 with Sender as TPaintBox do
  dmStdRes.SmallImageList.Draw(Canvas, width - c_SmallSizeIcon, (Height - c_SmallSizeIcon) div 2, cInternetTips);
//#UC END# *5268E6C000C2_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.WwwPaintBoxPaint

procedure TPrimStartupTipsForm.CloseButtonClick(Sender: TObject);
//#UC START# *5268E6C90064_4AC4F49F010B_var*
//#UC END# *5268E6C90064_4AC4F49F010B_var*
begin
//#UC START# *5268E6C90064_4AC4F49F010B_impl*
 SafeClose;
//#UC END# *5268E6C90064_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.CloseButtonClick

procedure TPrimStartupTipsForm.VcmEntityFormShow(Sender: TObject);
//#UC START# *5268E6D90201_4AC4F49F010B_var*
//#UC END# *5268E6D90201_4AC4F49F010B_var*
begin
//#UC START# *5268E6D90201_4AC4F49F010B_impl*
 PostMessage(Handle, WM_SETFOCUS, 0, 0);
//#UC END# *5268E6D90201_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.VcmEntityFormShow

procedure TPrimStartupTipsForm.WwwLabelClick(Sender: TObject);
//#UC START# *5268E6E102F5_4AC4F49F010B_var*
//#UC END# *5268E6E102F5_4AC4F49F010B_var*
begin
//#UC START# *5268E6E102F5_4AC4F49F010B_impl*
 f_Data.GotoWeb;
//#UC END# *5268E6E102F5_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.WwwLabelClick

procedure TPrimStartupTipsForm.DetailLabelClick(Sender: TObject);
//#UC START# *5268E6EA00F5_4AC4F49F010B_var*
//#UC END# *5268E6EA00F5_4AC4F49F010B_var*
begin
//#UC START# *5268E6EA00F5_4AC4F49F010B_impl*
 f_Data.ShowDetails;
 SafeClose;
//#UC END# *5268E6EA00F5_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.DetailLabelClick

procedure TPrimStartupTipsForm.NextButtonClick(Sender: TObject);
//#UC START# *5268E6F1015A_4AC4F49F010B_var*
//#UC END# *5268E6F1015A_4AC4F49F010B_var*
begin
//#UC START# *5268E6F1015A_4AC4F49F010B_impl*
 f_Data.Next;
 UpdateTip;
//#UC END# *5268E6F1015A_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.NextButtonClick

procedure TPrimStartupTipsForm.PrevButtonClick(Sender: TObject);
//#UC START# *5268E6F902E6_4AC4F49F010B_var*
//#UC END# *5268E6F902E6_4AC4F49F010B_var*
begin
//#UC START# *5268E6F902E6_4AC4F49F010B_impl*
 f_Data.Prev;
 UpdateTip;
//#UC END# *5268E6F902E6_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.PrevButtonClick

procedure TPrimStartupTipsForm.ShowCheckBoxClick(Sender: TObject);
//#UC START# *5268E701030F_4AC4F49F010B_var*
//#UC END# *5268E701030F_4AC4F49F010B_var*
begin
//#UC START# *5268E701030F_4AC4F49F010B_impl*
 f_Data.DontShow := ShowCheckBox.Checked;
//#UC END# *5268E701030F_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.ShowCheckBoxClick

class function TPrimStartupTipsForm.MakeSingleChild(const aData: InsStartupTips;
  const aCont   : IvcmContainer;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimStartupTipsForm);
 begin
  with aForm do
  begin
//#UC START# *4AC4F567002A_4AC4F49F010B_impl*
   f_Data := aData;
   Assert(Assigned(f_Data), 'Invalid params');
   ShowCheckBox.Checked := f_Data.DontShow;
   UpdateTip;
//#UC END# *4AC4F567002A_4AC4F49F010B_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited MakeSingleChild(aCont, vcmMakeParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

procedure TPrimStartupTipsForm.WndProcListenerNotify(Msg: PCWPStruct;
  var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_4AC4F49F010B_var*
var
 l_IsAct: Boolean;
 l_ActWnd: THandle;

 function lpIsDropDown(aWnd : THandle) : Boolean;
 var
  lControl: TWinControl;
  lDropWindow: IafwDropDownWindow;
 begin
  Result := False;
  lControl := FindControl(aWnd);
  if Assigned(lControl) then
   if Supports(lControl, IafwDropDownWindow, lDropWindow) then
   try
    Result := True;
   finally
    lDropWindow := nil;
   end
   else
    Result := not Assigned(lControl.Parent) and not Assigned(lControl.Owner);
 end;

 procedure lpDoActivate(aActivate : Boolean);
 const
  cFlag: array [Boolean] of Cardinal = (SWP_HIDEWINDOW, SWP_SHOWWINDOW);
  cInsertAfter: array [Boolean] of HWND = (0, HWND_TOPMOST);
 begin
  SetWindowPos(Handle, cInsertAfter[aActivate], 0, 0, 0, 0,
   SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or cFlag[aActivate]);
 end;
//#UC END# *4F79CF3400BB_4AC4F49F010B_var*
begin
//#UC START# *4F79CF3400BB_4AC4F49F010B_impl*
 if ZoneType <> vcm_ztForToolbarsInfo then
  if (Msg.message = WM_ACTIVATE) then
   if (Msg.hwnd <> Application.Handle) then
   begin
    l_IsAct := LoWord(Msg.WParam) <> WA_INACTIVE;
    if l_IsAct then
    begin
     l_ActWnd := Msg.hwnd;
     if lpIsDropDown(l_ActWnd) then
      Exit;
     (* Показали модальную форму, прячем навигатор и выходим *)
     if npIsModalForm(l_ActWnd) then
     begin
      lpDoActivate(False);
      Exit;
     end;
     (* Активировали плавающую форму *)
     if not npIsInFloatNavigator(l_ActWnd) and npIsFloatingForm(l_ActWnd) then
     begin
      lpDoActivate(True);
      Exit;
     end;
    end
    else
    begin
    (* Окну aMessage.hwnd пришло сообщение о деактивации, handle активированного
       окна содержится в THandle(aMessage.lParam). Если окно принадлежит
       главному окну навигатора ничего не делаем или активируем, в противном
       случае спрячем *)
     l_ActWnd := THandle(Msg.lParam);
     (* Информацию о деактивации нет смысла обрабатывать если фокус не ушел на
        рабочий стол, потому что когда придет, через HOOK сообщение об активации
        окна, то мы спрячем навигаторы если активировалось окно другой главной
        формы, или совсем чужое окно *)
     if  l_ActWnd <> HWND_DESKTOP then
      Exit;
    end;
    (* Изменим состояние *)

    lpDoActivate(npIsOwnerWindow(afw.GetAnotherParentForm(Owner), l_ActWnd));
   end;
//#UC END# *4F79CF3400BB_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.WndProcListenerNotify

procedure TPrimStartupTipsForm.Cleanup;
//#UC START# *479731C50290_4AC4F49F010B_var*
//#UC END# *479731C50290_4AC4F49F010B_var*
begin
//#UC START# *479731C50290_4AC4F49F010B_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.Cleanup

procedure TPrimStartupTipsForm.InitFields;
//#UC START# *47A042E100E2_4AC4F49F010B_var*
//#UC END# *47A042E100E2_4AC4F49F010B_var*
begin
//#UC START# *47A042E100E2_4AC4F49F010B_impl*
 inherited;
 Tl3ListenersManager.AddWndProcListener(Self);
 wwwLabel.Cursor := evCursorShape2Cursor(ev_csExternalHand);
 OnShow := vcmEntityFormShow;
//#UC END# *47A042E100E2_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.InitFields

procedure TPrimStartupTipsForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AC4F49F010B_var*
//#UC END# *47EA4E9002C6_4AC4F49F010B_var*
begin
//#UC START# *47EA4E9002C6_4AC4F49F010B_impl*
 inherited;
 SafeClose;
//#UC END# *47EA4E9002C6_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimStartupTipsForm.InitControls;
//#UC START# *4A8E8F2E0195_4AC4F49F010B_var*
var
 l_Delta: Integer;
//#UC END# *4A8E8F2E0195_4AC4F49F010B_var*
begin
//#UC START# *4A8E8F2E0195_4AC4F49F010B_impl*
 inherited;
 with TopPanel do
 begin
  Height := 41;
  Align := alTop;
  TabOrder := 0;
 end;
  with TitlePaintBox do
  begin
   Left := 12;
   Top := 4;
   Width := 32;
   Height := 32;
   OnPaint := TitlePaintBoxPaint;
  end;
  with TitleLabel do
  begin
   Left := 57;
   Top := 11;
   Width := 156;
   Height := 19;
   Anchors := [akLeft, akTop, akRight];
   Font.Height := -16;
   Font.Style := [fsBold];
   Layout := tlCenter;
  end;
 with BottomPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
  with HintPanel do
  begin
   Left := 13;
   Top := 22;
   Width := 272;
   Height := 123;
   BorderStyle := bsSingle;
   Color := clWindow;
   TabOrder := 0;
  end;
   with TipLabel do
   begin
    AutoSize := False;
    Left := 11;
    Top := 9;
    Width := 6;
    Height := 16;
    WordWrap := True;
   end;
   with DetailLabel do
   begin
    Left := 142;
    Top := 93;
    Width := 103;
    Height := 18;
    Cursor := crHandPoint;
    TabOrder := 0;
    Font.Color := clBlue;
    Font.Style := [fsBold];
    HighlightColor := clBlue;
    Hyperlink := True;
    OnClick := DetailLabelClick;
   end;
 with ShowCheckBox do
 begin
  Left := 13;
  Top := 153;
  Width := 268;
  Height := 17;
  TabOrder := 1;
  OnClick := ShowCheckBoxClick;
 end;
 with wwwPanel do
 begin
  Left := 11;
  Top := 178;
  Width := 270;
  Height := 19;
  BevelOuter := bvNone;
  ParentColor := True;
  TabOrder := 2;
 end;
  with wwwPaintBox do
  begin
   Left := 0;
   Top := 2;
   Width := 16;
   Height := 16;
   OnPaint := wwwPaintBoxPaint;
  end;
  with wwwLabel do
  begin
   Left := 20;
   Top := 1;
   Width := 192;
   Height := 18;
   Cursor := crHandPoint;
   TabOrder := 0;
   Font.Color := clBlue;
   HighlightColor := clBlue;
   Hyperlink := True;
   OnClick := wwwLabelClick;
  end;
 with NextButton do
 begin
  Left := 290;
  Top := 22;
  Width := 105;
  Height := 26;
  DrawDefaultFrame := False;
  Default := True;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 3;
  ParentFont := True;
  OnClick := NextButtonClick;
  DockOrientation := doNoOrient;
 end;
 with PrevButton do
 begin
  Left := 290;
  Top := 56;
  Width := 105;
  Height := 26;
  DrawDefaultFrame := False;
  Default := True;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 4;
  ParentFont := True;
  OnClick := PrevButtonClick;
  DockOrientation := doNoOrient;
 end;
 with CloseButton do
 begin
  Left := 290;
  Top := 163;
  Width := 105;
  Height := 26;
  DrawDefaultFrame := False;
  Cancel := True;
  Default := True;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 5;
  ParentFont := True;
  OnClick := CloseButtonClick;
  DockOrientation := doNoOrient;
 end;
//#UC END# *4A8E8F2E0195_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimStartupTipsForm.SetupFormLayout;
//#UC START# *529332B40230_4AC4F49F010B_var*
//#UC END# *529332B40230_4AC4F49F010B_var*
begin
//#UC START# *529332B40230_4AC4F49F010B_impl*
 inherited;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 ClientHeight := 200;
 ClientWidth := 407;
 DetailLabel.Left := HintPanel.Width - DetailLabel.Width - (HintPanel.Height - DetailLabel.Top - DetailLabel.Height);

 ActiveControl := NextButton;
 Position := poMainFormCenter;
 UpdateTip;
//#UC END# *529332B40230_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.SetupFormLayout
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimStartupTipsForm.DoGetNeedSaveToTabHistory: Boolean;
//#UC START# *55B9F0BD0069_4AC4F49F010B_var*
//#UC END# *55B9F0BD0069_4AC4F49F010B_var*
begin
//#UC START# *55B9F0BD0069_4AC4F49F010B_impl*
 Result := False;
//#UC END# *55B9F0BD0069_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.DoGetNeedSaveToTabHistory
{$IfEnd} //not NoVCM

procedure TPrimStartupTipsForm.MakeControls;
begin
 inherited;
 f_TopPanel := TvtPanel.Create(Self);
 f_TopPanel.Name := 'TopPanel';
 f_TopPanel.Parent := Self;
 f_TitlePaintBox := TPaintBox.Create(Self);
 f_TitlePaintBox.Name := 'TitlePaintBox';
 f_TitlePaintBox.Parent := TopPanel;
 f_TitleLabel := TvtLabel.Create(Self);
 f_TitleLabel.Name := 'TitleLabel';
 f_TitleLabel.Parent := TopPanel;
 f_TitleLabel.Caption := 'Знаете ли Вы, что...';
 f_BottomPanel := TvtPanel.Create(Self);
 f_BottomPanel.Name := 'BottomPanel';
 f_BottomPanel.Parent := Self;
 f_HintPanel := TvtPanel.Create(Self);
 f_HintPanel.Name := 'HintPanel';
 f_HintPanel.Parent := BottomPanel;
 f_TipLabel := TvtLabel.Create(Self);
 f_TipLabel.Name := 'TipLabel';
 f_TipLabel.Parent := HintPanel;
 f_DetailLabel := TvtFocusLabel.Create(Self);
 f_DetailLabel.Name := 'DetailLabel';
 f_DetailLabel.Parent := HintPanel;
 f_DetailLabel.Caption := 'См. подробнее';
 f_ShowCheckBox := TvtCheckBox.Create(Self);
 f_ShowCheckBox.Name := 'ShowCheckBox';
 f_ShowCheckBox.Parent := BottomPanel;
 f_ShowCheckBox.Caption := 'Не показывать совет дня при запуске';
 f_wwwPanel := TvtPanel.Create(Self);
 f_wwwPanel.Name := 'wwwPanel';
 f_wwwPanel.Parent := BottomPanel;
 f_wwwPaintBox := TPaintBox.Create(Self);
 f_wwwPaintBox.Name := 'wwwPaintBox';
 f_wwwPaintBox.Parent := wwwPanel;
 f_wwwLabel := TvtFocusLabel.Create(Self);
 f_wwwLabel.Name := 'wwwLabel';
 f_wwwLabel.Parent := wwwPanel;
 f_wwwLabel.Caption := 'Советы дня в Новостях онлайн';
 f_NextButton := TElPopupButton.Create(Self);
 f_NextButton.Name := 'NextButton';
 f_NextButton.Parent := BottomPanel;
 f_NextButton.Caption := 'Следующий';
 f_PrevButton := TElPopupButton.Create(Self);
 f_PrevButton.Name := 'PrevButton';
 f_PrevButton.Parent := BottomPanel;
 f_PrevButton.Caption := 'Предыдущий';
 f_CloseButton := TElPopupButton.Create(Self);
 f_CloseButton.Name := 'CloseButton';
 f_CloseButton.Parent := BottomPanel;
 f_CloseButton.Caption := 'Закрыть';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimStartupTips
 TtfwClassRef.Register(TPrimStartupTipsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.