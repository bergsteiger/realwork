unit PrimStartupTips_Form;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\Forms\PrimStartupTips_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimStartupTips" MUID: (4AC4F49F010B)
// Имя типа: "TPrimStartupTipsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , DayTipsInterfaces
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimStartupTipsForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3WndProcListener)
  {* Совет дня }
  private
   f_TopPanel: TvtPanel;
    {* Поле для свойства TopPanel }
   f_TitlePaintBox: TPaintBox;
    {* Поле для свойства TitlePaintBox }
   f_TitleLabel: TvtLabel;
    {* Поле для свойства TitleLabel }
   f_BottomPanel: TvtPanel;
    {* Поле для свойства BottomPanel }
   f_HintPanel: TvtPanel;
    {* Поле для свойства HintPanel }
   f_TipLabel: TvtLabel;
    {* Поле для свойства TipLabel }
   f_DetailLabel: TvtFocusLabel;
    {* Поле для свойства DetailLabel }
   f_ShowCheckBox: TvtCheckBox;
    {* Поле для свойства ShowCheckBox }
   f_wwwPanel: TvtPanel;
    {* Поле для свойства wwwPanel }
   f_wwwPaintBox: TPaintBox;
    {* Поле для свойства wwwPaintBox }
   f_wwwLabel: TvtFocusLabel;
    {* Поле для свойства wwwLabel }
   f_NextButton: TElPopupButton;
    {* Поле для свойства NextButton }
   f_PrevButton: TElPopupButton;
    {* Поле для свойства PrevButton }
   f_CloseButton: TElPopupButton;
    {* Поле для свойства CloseButton }
  protected
   f_Data: InsStartupTips;
  private
   procedure UpdateTip;
   procedure TitlePaintBoxPaint(Sender: TObject);
   procedure wwwPaintBoxPaint(Sender: TObject);
   procedure CloseButtonClick(Sender: TObject);
   procedure vcmEntityFormShow(Sender: TObject);
   procedure wwwLabelClick(Sender: TObject);
   procedure DetailLabelClick(Sender: TObject);
   procedure NextButtonClick(Sender: TObject);
   procedure PrevButtonClick(Sender: TObject);
   procedure ShowCheckBoxClick(Sender: TObject);
  protected
   procedure WndProcListenerNotify(Msg: PCWPStruct;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetNeedSaveToTabHistory: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeSingleChild(const aData: InsStartupTips): IvcmEntityForm; reintroduce;
  public
   property TopPanel: TvtPanel
    read f_TopPanel;
   property BottomPanel: TvtPanel
    read f_BottomPanel;
   property TitlePaintBox: TPaintBox
    read f_TitlePaintBox;
   property TitleLabel: TvtLabel
    read f_TitleLabel;
    {* Знаете ли Вы, что... }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConst
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vtNavigatorUtils
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ListenersManager
 {$If Defined(evUseVisibleCursors)}
 , evCursorShapeMisc
 {$IfEnd} // Defined(evUseVisibleCursors)
 , SysUtils
 , Graphics
 , afwFacade
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4AC4F49F010Bimpl_uses*
 //#UC END# *4AC4F49F010Bimpl_uses*
;

{$If NOT Defined(NoVCM)}
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

procedure TPrimStartupTipsForm.wwwPaintBoxPaint(Sender: TObject);
//#UC START# *5268E6C000C2_4AC4F49F010B_var*
//#UC END# *5268E6C000C2_4AC4F49F010B_var*
begin
//#UC START# *5268E6C000C2_4AC4F49F010B_impl*
 with Sender as TPaintBox do
  dmStdRes.SmallImageList.Draw(Canvas, width - c_SmallSizeIcon, (Height - c_SmallSizeIcon) div 2, cInternetTips);
//#UC END# *5268E6C000C2_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.wwwPaintBoxPaint

procedure TPrimStartupTipsForm.CloseButtonClick(Sender: TObject);
//#UC START# *5268E6C90064_4AC4F49F010B_var*
//#UC END# *5268E6C90064_4AC4F49F010B_var*
begin
//#UC START# *5268E6C90064_4AC4F49F010B_impl*
 SafeClose;
//#UC END# *5268E6C90064_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.CloseButtonClick

procedure TPrimStartupTipsForm.vcmEntityFormShow(Sender: TObject);
//#UC START# *5268E6D90201_4AC4F49F010B_var*
//#UC END# *5268E6D90201_4AC4F49F010B_var*
begin
//#UC START# *5268E6D90201_4AC4F49F010B_impl*
 PostMessage(Handle, WM_SETFOCUS, 0, 0);
//#UC END# *5268E6D90201_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.vcmEntityFormShow

procedure TPrimStartupTipsForm.wwwLabelClick(Sender: TObject);
//#UC START# *5268E6E102F5_4AC4F49F010B_var*
//#UC END# *5268E6E102F5_4AC4F49F010B_var*
begin
//#UC START# *5268E6E102F5_4AC4F49F010B_impl*
 f_Data.GotoWeb;
//#UC END# *5268E6E102F5_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.wwwLabelClick

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

class function TPrimStartupTipsForm.MakeSingleChild(const aData: InsStartupTips): IvcmEntityForm;
var
 l_Inst : TPrimStartupTipsForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimStartupTipsForm.MakeSingleChild

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
 {* Функция очистки полей объекта. }
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

procedure TPrimStartupTipsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimStartupTipsForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
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

function TPrimStartupTipsForm.DoGetNeedSaveToTabHistory: Boolean;
//#UC START# *55B9F0BD0069_4AC4F49F010B_var*
//#UC END# *55B9F0BD0069_4AC4F49F010B_var*
begin
//#UC START# *55B9F0BD0069_4AC4F49F010B_impl*
 Result := False;
//#UC END# *55B9F0BD0069_4AC4F49F010B_impl*
end;//TPrimStartupTipsForm.DoGetNeedSaveToTabHistory

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
end;//TPrimStartupTipsForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStartupTipsForm);
 {* Регистрация PrimStartupTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
