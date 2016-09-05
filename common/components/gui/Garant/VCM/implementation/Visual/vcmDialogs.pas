unit vcmDialogs;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDialogs.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmDialogs" MUID: (4B8E676500AD)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , Types
 , l3MessageID
 , Classes
 , Windows
 , Pl3StringIDExList
 , evCustomEditorWindow
 , l3PrinterInterfaces
 , vcmMessageFormPrim
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , nevBase
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , vtVGButton
;

const
 vcm_mrCustomButton = mrYesToAll + 1000;
 cCustomButtonName = 'Custom';
 cCheckName = 'Check';
 cChoicesName = 'Choices';
 cMsgDlgBtnOrder: array [TMsgDlgBtn] of TMsgDlgBtn = (
 mbYes
 , mbAll
 , mbYesToAll
 , mbNo
 , mbNoToAll
 , mbOk
 , mbCancel
 , mbAbort
 , mbRetry
 , mbIgnore
 , mbHelp
 {$If Defined(XE)}
 , mbClose
 {$IfEnd} // Defined(XE)
 );

type
 TMessageFormClass = class of TMessageForm;

 TvtEffectiveDialogButton = class(TvtVGButton)
  protected
   function pm_GetCaption: WideString;
   procedure pm_SetCaption(aValue: WideString);
   procedure ApplyStyle; override;
  public
   property Caption: WideString
    read pm_GetCaption
    write pm_SetCaption;
 end;//TvtEffectiveDialogButton

 TButtonWidths = array [TMsgDlgBtn] of integer;

 TMessageForm = class(TvcmMessageFormPrim)
  private
   f_WndParent: HWND;
   f_CloseTimer: TTimer;
   f_AutoCloseButton: TvtEffectiveDialogButton;
   f_AutoCloseCaption: WideString;
   f_CloseInterval: integer;
   f_NeedShowInTaskBar: Boolean;
  private
   procedure HelpButtonClick(Sender: TObject);
   procedure evntOnCloseTimer(Sender: TObject);
   procedure evntOnClickFocusLabel(Sender: TObject);
   procedure UpdateAutoCloseButton;
  protected
   function pm_GetNeedShowInTaskBar: Boolean; virtual;
   procedure pm_SetNeedShowInTaskBar(aValue: Boolean); virtual;
   procedure TextSourceGetControlItemImg(aSender: TObject;
    const aControl: TnevControlInfo;
    out theImageInfo: TnevControlImageInfo);
   procedure DoAfterAdjustHeight(Sender: TObject;
    anOldHeight: Integer;
    aNewHeight: Integer);
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure SetCloseInterval(aCloseInterval: Integer);
   procedure SetAutoCloseButton(const Value: TvtEffectiveDialogButton);
   constructor CreateNewEx(aWndParent: HWND;
    AOwner: TComponent;
    Dummy: Integer = 0); reintroduce; virtual;
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   function ShowModal: Integer; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property NeedShowInTaskBar: Boolean
    read pm_GetNeedShowInTaskBar
    write pm_SetNeedShowInTaskBar;
 end;//TMessageForm

function vcmMessageDlgPrim(const aMsg: Tl3Message;
 out Checked: Boolean;
 aTextAlign: TAlignment = Classes.taCenter;
 aWndParent: HWND = 0;
 aChoices: TPl3StringIDExList = nil;
 aJumpTo: TevJumpToEvent = nil;
 aNeedShowInTaskBar: Boolean = False): Integer;

var ButtonWidths: TButtonWidths;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , vtDialogsRes
 , vtVGSceneRes
 , vtF1InterfaceConst
 , vtDialogsResEx
 , vg_scene
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmMessagesSupport
 , SysUtils
 , vtCheckBox
 , afwFacade
 , l3BatchService
 , l3Interfaces
 , nscSimpleEditorForDialogs
 , vtStdRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vtFocusLabel
 , l3Base
 , Graphics
 , l3String
 , vg_controls
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3WinControlCanvas
 , l3FormCanvas
 , l3Math
 , l3MinMax
 , Cloak_Const
 , vg_objects
 , vtUtils
 , afwVCL
 , vcmInterfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4B8E676500ADimpl_uses*
 //#UC END# *4B8E676500ADimpl_uses*
;

function GetAvgCharSize(aCanvas: TCanvas): TPoint;
//#UC START# *4F8FFF1901ED_4B8E676500AD_var*
var
  I: Integer;
  Buffer: array[0..51] of Char;
//#UC END# *4F8FFF1901ED_4B8E676500AD_var*
begin
//#UC START# *4F8FFF1901ED_4B8E676500AD_impl*
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(aCanvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div Length(Buffer);
//#UC END# *4F8FFF1901ED_4B8E676500AD_impl*
end;//GetAvgCharSize

function vtCreateMessageDialog(const aMsg: Tl3Message;
 aFormClass: TMessageFormClass;
 aTextAlign: TAlignment;
 aWndParent: HWND;
 aAutoCloseInterval: Integer;
 aChoices: TPl3StringIDExList;
 aJumpTo: TevJumpToEvent = nil): TMessageForm;
//#UC START# *4F915A68031C_4B8E676500AD_var*
const
  mcHorzMargin      = 8;
  mcVertMargin      = 8;
  mcHorzSpacing     = 10;
  mcVertSpacing     = 10;
  mcButtonWidth     = 50;
  mcButtonHeight    = 14;
  mcButtonSpacing   = 4;
  mcCheckSquareSize = 20;
  mcButtonPadding   = 14;
  mcMinDialogWidth  = 500;

var
  HorzMargin       : Integer;
  VertMargin       : Integer;
  HorzSpacing      : Integer;
  VertSpacing      : Integer;
  ButtonWidth      : Integer;
  ButtonHeight     : Integer;
  ButtonSpacing    : Integer;
  DefaultButton    : TMsgDlgBtn;
  CancelButton     : TMsgDlgBtn;
  ButtonPadding    : Integer;
  l_Scene          : TvgScene;
  l_BackGround     : TvgBackGround;

 function lpLeftForCheck(aText : Boolean = False) : Integer;
 {* - возращает значение Left для checkbox-а. }
 begin//lpLeftForCheck
  Result := 0;
  if aText then
   Inc(Result, mcCheckSquareSize);
  Inc(Result, HorzMargin);
 end;//lpLeftForCheck

 procedure lp_CreateFocusLabels(aOwner: TForm;
                                const aLeft: Integer;
                                const aTop: Integer;
                                const aChoicesHeight: Integer);
 var
  I            : Integer;
  l_FocusLabel : TvtFocusLabel;
 begin
  for I := 0 to aChoices.Count-1 do
  begin
   l_FocusLabel := TvtFocusLabel.Create(aOwner);
   with l_FocusLabel do
   begin
    Parent := aOwner;
    Name := cChoicesName + IntToStr(I);
    CCaption := aChoices[I].AsCStr;
    Left := aLeft + HorzMargin;
    Top  := aTop  + I * aChoicesHeight + VertSpacing;
    ShowMark := True;
    with Font do
    begin
     Assign(aOwner.Font);
     Size := aOwner.Font.Size + 1;
     Style := [fsUnderline];
     Color := cGarant2011LinkColor;
    end;//with Font
    HighlightColor := cGarant2011LinkColor;
    Hyperlink := true;
    Cursor := crHandPoint;
    AutoWidth := true;
    TabStop := true;
    if aFormClass.InheritsFrom(TMessageForm) then
      OnClick := TMessageForm(Result).evntOnClickFocusLabel;
    if Result.Width < (HorzMargin + l_FocusLabel.Left + l_FocusLabel.Width) then
     Result.Width := (HorzMargin + l_FocusLabel.Left + l_FocusLabel.Width);
   end;//with TvtFocusLabel.Create(Result)
  end;//for I..
 end;

 procedure lp_CreateButtons(aOwner: TForm;
                            aLeft: Integer;
                            const aTop: Integer;
                            const aHasCustomBTN: Boolean;
                            const aNewBtnWidth: Integer);
 var
  B     : TMsgDlgBtn;
  l_Btn : TvtEffectiveDialogButton;
 const
  ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', {$IfDef XE}'YesToAll',{$EndIf} 'Help');
 begin//lp_CreateButtons
  for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
   if cMsgDlgBtnOrder[B] in aMsg.rData.rButtons then
   begin
    l_Btn := TvtEffectiveDialogButton.Create(aOwner);
    with l_Btn do
    begin
     Name := ButtonNames[cMsgDlgBtnOrder[B]];
     Parent := TvgObject(l_Scene.Root);
     Caption := l3WideString(vtGetDlgBtnCaption(cMsgDlgBtnOrder[B]));
     SetBounds(aLeft, VertSpacing, ButtonWidth, ButtonHeight);
     Resource := cButtonStyleLayoutName;
     Font.Assign(aOwner.Font);

     ModalResult := vtGetDlgBtnResult(cMsgDlgBtnOrder[B]);
     if (cMsgDlgBtnOrder[B] = DefaultButton) then
     begin
      Default := True;
      aOwner.ActiveControl := l_Scene;
      l_Scene.ActiveControl := l_Btn;
      TMessageForm(aOwner).SetAutoCloseButton(l_Btn);
     end;//cMsgDlgBtnOrder[B] = DefaultButton
     if (cMsgDlgBtnOrder[B] = CancelButton) then
      Cancel := True;

     Inc(aLeft, ButtonWidth + ButtonSpacing);
     if (cMsgDlgBtnOrder[B] = mbHelp) then
      OnClick := TMessageForm(aOwner).HelpButtonClick;
    end;//with lBtn
   end;//cMsgDlgBtnOrder[B] in aButtons

  if aHasCustomBTN then //Пользовательская кнопка
  begin
   l_Btn := TvtEffectiveDialogButton.Create(aOwner);
   with l_Btn do
   begin
    Name := cCustomButtonName;
    Caption := aMsg.rData.rCustomButtonCaption;
    Parent := TvgObject(l_Scene.Root);
    SetBounds(aLeft, VertSpacing, aNewBtnWidth, ButtonHeight);
    Resource := cButtonStyleLayoutName;
    Font.Assign(aOwner.Font);
    ModalResult := vcm_mrCustomButton;
   end;//with lBtn
  end;//l_CustomBTN
 end;//lp_CreateButtons

 procedure lp_CreateCheckBox(aOwner: TForm;
                             const aLeft: Integer;
                             const aTop: Integer;
                             const aHeight: Integer;
                             const aIsVGStyle: Boolean);
 begin//lp_CreateCheckBox
  if aIsVGStyle then
  begin
   with TvgCheckBox.Create(aOwner) do
   begin
    Parent := TvgObject(l_Scene.Root);
    Text := aMsg.CheckCaption;
    Resource := cCheckBoxStyleLayoutName;
    Font.Assign(aOwner.Font);
    WordWrap := true;
    Name := cCheckName;
    IsChecked := false;
    SetBounds(aLeft,
              aTop - l_Scene.Top,
              aOwner.ClientWidth - 2 * HorzMargin,
              aHeight);
   end;//with TvgCheckBox.Create(aOwner)
  end;//aIsVGStyle

  if not aIsVGStyle then
  begin
   with TvtCheckBox.Create(aOwner) do
   begin
    WordWrap := true;
    Name := cCheckName;
    Parent := Result;
    Caption := aMsg.CheckCaption;
    Checked := false;
    SetBounds(aLeft,
              aTop,
              aOwner.ClientWidth - 2 * HorzMargin,
              aHeight);
    BiDiMode := Result.BiDiMode;
   end;//with TvtCheckBox.Create(aOwner)
  end;//not aIsVGStyle
 end;//lp_CreateCheckBox

var
  l_Label : TnscSimpleEditorForDialogs;
  lCanvas : Tl3WinControlCanvas;

(* function ChoicesWidth: Integer;
 var
  l_Index : Integer;
  l_DX    : Integer;
 begin//ChoicesWidth
  Result := l_Label.Width;
  l_DX := lCanvas.LP2DP(lCanvas.TextExtent(l3PCharLen('W'))).X * 3;
  for l_Index := 0 to Pred(aChoices.Count) do
   Result := Max(Result, lCanvas.LP2DP(lCanvas.TextExtent(aChoices.ItemW[l_Index])).X + l_DX);
 end;//ChoicesWidth*)

 function ChoicesHeight: Integer;
 begin
  Result := lCanvas.Canvas.TextHeight('W') * 2;
 end;

const
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  str_JustificationPrefix = '{justification:ev_itLeft}'#13#10;
  str_JustificationSuffix = #13#10'{/justification}';

var
  DialogUnits      : TPoint;
  ButtonCount      : Integer;
  ButtonGroupWidth : Integer;
  IconTextWidth    : Integer;
  IconTextHeight   : Integer;
  X                : Integer;
  I                : Integer;
  ALeft            : Integer;
  B                : TMsgDlgBtn;
  IconID           : PChar;
  TextRect         : TRect;
  lCheckTextRect   : TRect;
  lCaption         : Il3CString;
  l_NewBtnWidth    : Integer;
  l_CustomBTN      : Boolean;
  l_FontStyle      : TFontStyles;
  l_FontSize       : Integer;
  l_HasButtons     : Boolean;
  l_HasChoices     : Boolean;
  l_TopForCheck    : Integer;
  l_IsVGStyleCheck : Boolean;
  l_MaxTextWidth   : Integer;
  l_Footer : TnscSimpleEditorForDialogs;
  l_Msg    : Il3CString;
  l_FooterSpacing  : Integer;
//#UC END# *4F915A68031C_4B8E676500AD_var*
begin
//#UC START# *4F915A68031C_4B8E676500AD_impl*
 if (aFormClass = nil) then
  aFormClass := TMessageForm;

 Result := TMessageFormClass(aFormClass).CreateNewEx(aWndParent, Application);

 l_NewBtnWidth := 0;
 l_CustomBTN := aMsg.rData.rCustomButtonCaption <> '';

 l_HasChoices := (aChoices <> nil) AND (aChoices.Count > 1); // VK. Рефакторинг: Introduce Explaining Variable

 with Result do
 begin
  Font.Size := 11;
  Font.Charset := RUSSIAN_CHARSET;
  lCanvas := Tl3FormCanvas.Create(Result);
  try
   lCanvas.Font.AssignFont(Font);
   BiDiMode := Application.BiDiMode;
   BorderStyle := bsDialog;
   lCanvas.BeginPaint;
   try
    DialogUnits := GetAvgCharSize(Canvas);
    HorzMargin  := l3MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin  := l3MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := l3MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := l3MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := l3MulDiv(mcButtonWidth, DialogUnits.X, 4);
    ButtonPadding := l3MulDiv(mcButtonPadding, Font.Size, 8);

    for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
    begin
     if (cMsgDlgBtnOrder[B] in aMsg.rData.rButtons) then
     begin
      if (ButtonWidths[cMsgDlgBtnOrder[B]] = 0) then
      begin
       SetRectEmpty(TextRect);
       lCaption := vtGetDlgBtnCaption(cMsgDlgBtnOrder[B]);
       lCanvas.DrawText(lCaption.AsWStr,
                        TextRect,
                        DT_CALCRECT   or
                        DT_LEFT       or
                        DT_SINGLELINE or
                        DrawTextBiDiModeFlagsReadingOnly);
       with TextRect do
        ButtonWidths[cMsgDlgBtnOrder[B]] := Right - Left + ButtonPadding;
      end;//ButtonWidths[cMsgDlgBtnOrder[B]] = 0
      if (ButtonWidths[cMsgDlgBtnOrder[B]]) > ButtonWidth then
       ButtonWidth := ButtonWidths[cMsgDlgBtnOrder[B]];
     end;//cMsgDlgBtnOrder[B] in aButtons
    end;//for b..

    if l_CustomBTN then //Если нужна пользовательская кнопка, то высчитываем её ширину.
    begin
     SetRectEmpty(TextRect);
     lCanvas.DrawText(l3PCharLen(aMsg.rData.rCustomButtonCaption),
                      TextRect,
                      DT_CALCRECT   or
                      DT_LEFT       or
                      DT_SINGLELINE or
                      DrawTextBiDiModeFlagsReadingOnly);
     with TextRect do
      l_NewBtnWidth := Right - Left + ButtonPadding;
    end;//l_CustomBTN

    if (aAutoCloseInterval > 0) then
    begin
     SetRectEmpty(TextRect);
     lCaption := l3Fmt(' (%d)', [aAutoCloseInterval]);
     lCanvas.DrawText(lCaption.AsWStr,
                      TextRect,
                      DT_CALCRECT   or
                      DT_LEFT       or
                      DT_SINGLELINE or
                      DrawTextBiDiModeFlagsReadingOnly);
     ButtonWidth := ButtonWidth + TextRect.Right - TextRect.Left;
    end;//aAutoCloseInterval > 0

    ButtonHeight := l3MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := l3MulDiv(mcButtonSpacing, DialogUnits.X, 4);

    l_MaxTextWidth := Screen.Width div 2;
    Dec(l_MaxTextWidth, HorzMargin * 2);
    Dec(l_MaxTextWidth, Width - ClientWidth);
    IconID := IconIDs[aMsg.rData.rDlgType];
    if (IconID <> nil) then
     Dec(l_MaxTextWidth, 32 + HorzSpacing);

    l_FontStyle := lCanvas.Font.Style;
    l_FontSize  := lCanvas.Font.Size;
    try
     if l_HasChoices then
     begin
      lCanvas.Font.Size := Result.Font.Size +1;
      lCanvas.Font.Style := lCanvas.Font.Style + [fsBold];
     end;//l_HasChoices

     SetRect(TextRect, 0, 0, 0, 0);
     lCanvas.DrawText(l3PCharLen(aMsg.rMessage),
                      TextRect,
                      DT_EXPANDTABS or
                      DT_CALCRECT   or
                      DT_WORDBREAK  or
                      DrawTextBiDiModeFlagsReadingOnly);

     TextRect.Right := Min(TextRect.Right + 50, l_MaxTextWidth);

     l_Label := TnscSimpleEditorForDialogs.Create(Result);

     with l_Label do
     begin
      {$ifdef nsTest}
      AutoHideSelection := False;
      {$else}
      AutoHideSelection := True;
      {$endif}
      if Assigned(aJumpTo) then
       OnJumpTo := aJumpTo;
      Color := cGarant2011BackColor;
      ScrollStyle := ssVertical;
      //Alignment := aTextAlign;
      Name := 'Message';
      Parent := Result;
      l_Msg := aMsg.rMessage;
      if l_HasChoices then
      begin
       l_Msg := l3Cat([l3CStr('h3. '), l_Msg]);
       l_Label.Font.Size := Result.Font.Size + 1;
       l_Label.Font.Style := Font.Style + [fsBold];
      end//l_HasChoices
      else
      begin
       l_Label.Font.Size := Result.Font.Size;
       l_Label.Font.Style := Font.Style;
      end;//l_HasChoices
      l_Msg := l3Cat([l3CStr(str_JustificationPrefix), l_Msg, l3CStr(str_JustificationSuffix)]);
      l_Label.Width := TextRect.Right - TextRect.Left;
      Buffer := l_Msg.AsWStr;
      //BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      //ParentFont := True;
      TextRect.Bottom := TextRect.Top +  l_Label.Height;
      IconTextWidth := TextRect.Right;
      if (IconID <> nil) then
       Inc(IconTextWidth, 32 + HorzSpacing);
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        TextRect.Right, VertMargin + l_Label.Height);
      l_Label.AdjustHeightByText;
      l_Label.AfterAdjustHeight := Result.DoAfterAdjustHeight;
      l_Label.TextSource.OnGetControlItemImg := Result.TextSourceGetControlItemImg;
     end;//with l_Label
     l_Label.AutoHeightByText := False;
     l_Label.Height := Min(l_Label.Height, l3MulDiv(Screen.Height, 3, 4));
     TextRect.Bottom := TextRect.Top +  l_Label.Height;
     IconTextHeight := TextRect.Bottom;
     if (IconID <> nil) then
      if (IconTextHeight < 32) then
       IconTextHeight := 32;

    finally
     lCanvas.Font.Style := l_FontStyle;
     lCanvas.Font.Size := l_FontSize;
    end;//try..finally

    ButtonCount := 0;
    for B := Low(cMsgDlgBtnOrder) to High(cMsgDlgBtnOrder) do
      if (cMsgDlgBtnOrder[B] in aMsg.rData.rButtons) then
       Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
     ButtonGroupWidth := ButtonWidth * ButtonCount +
       ButtonSpacing * (ButtonCount - 1) + l_NewBtnWidth;

    SetRect(lCheckTextRect,
            lpLeftForCheck(True),
            0,
            Screen.Width div 2,
            0);
    if l3IsNil(aMsg.CheckCaption) then
     l3FillChar(lCheckTextRect, SizeOf(lCheckTextRect), 0)
    else
     lCanvas.DrawText(l3PCharLen(aMsg.CheckCaption),
                      lCheckTextRect,
                      DT_EXPANDTABS or
                      DT_CALCRECT   or
                      DT_WORDBREAK  or
                      DrawTextBiDiModeFlagsReadingOnly);
    lCheckTextRect.Left := lpLeftForCheck;
    ClientWidth := Max(Max(IconTextWidth, ButtonGroupWidth),
     lCheckTextRect.Right)+ HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    if (Width < mcMinDialogWidth) then
    begin
     Width := mcMinDialogWidth;
    end;//Width < mcMinDialogWidth
    with Screen.MonitorFromWindow(aWndParent) do
    begin
     Result.Left := Left + (Width - Result.Width) div 2;
     Result.Top := Top + (Height - Result.Height) div 2;
    end;
    if (aMsg.rData.rDlgType <> mtCustom) then
     Caption := vtGetDlgCaption(aMsg.rData.rDlgType)
    else
     Caption := Application.Title;
    if (IconID <> nil) then
     with TImage.Create(Result) do
     begin
       Name := 'Image';
       Parent := Result;
       Picture.Icon.Handle := LoadIcon(0, IconID);
       SetBounds(HorzMargin, VertMargin, 32, 32);
     end;//with TImage.Create(Result)

    // VK. В диалогах нового стиля если имеются aChoices, то кнопки aButtons не отображаются
    l_HasButtons := NOT l_HasChoices;
    Result.Color := cGarant2011BackColor;

    if l_HasChoices then
    begin
     lp_CreateFocusLabels(Result, l_Label.Left, l_Label.Top + l_Label.Height, ChoicesHeight);
     IconTextHeight := Max(IconTextHeight, l_Label.Height{Top} + aChoices.Count * ChoicesHeight);
     Result.Height  := Result.Height + aChoices.Count * ChoicesHeight;
    end;//l_HasChoices

    if not l3IsNil(aMsg.rData.rFooterInfo) then
    begin
     l_Footer := TnscSimpleEditorForDialogs.Create(Result);
     with l_Footer do
     begin
      Color := cGarant2011BackColor;
      //Alignment := aTextAlign;
      Name := 'Footer';
      Parent := Result;
(*      if l_HasChoices then
      begin
       l_Footer.Font.Size := Result.Font.Size + 1;
       l_Footer.Font.Style := Font.Style + [fsBold];
      end//l_HasChoices
      else*)
      begin
       l_Footer.Font.Size := Result.Font.Size;
       l_Footer.Font.Style := Font.Style;
      end;//l_HasChoices
      //l_Footer.Width := TextRect.Right - TextRect.Left;
      l_Footer.Left := HorzMargin - 4;
      //l_Footer.Left := l_Label.Left;
      l_Footer.Width := (l_Label.Left + l_Label.Width) - l_Footer.Left;
      l_FooterSpacing := VertSpacing;
      l_Footer.Top := l_Label.Top + l_Label.Height + l_FooterSpacing;
      if l_HasChoices then
       l_Footer.Top := l_Footer.Top + aChoices.Count * ChoicesHeight;
      Buffer := aMsg.rData.rFooterInfo.AsWStr;
      //BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      //ParentFont := True;
(*      TextRect.Bottom := TextRect.Top +  l_Label.Height;
      IconTextWidth := TextRect.Right;
      if (IconID <> nil) then
       Inc(IconTextWidth, 32 + HorzSpacing);
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin,
        TextRect.Right, VertMargin + l_Label.Height);*)
      l_Footer.AdjustHeightByText;
      Result.Height  := Result.Height + l_Footer.Height + l_FooterSpacing;
      if l_HasChoices then
       Result.Height  := Result.Height - VertSpacing;
      l_Footer.AfterAdjustHeight := Result.DoAfterAdjustHeight;
      l_Footer.TextSource.OnGetControlItemImg := Result.TextSourceGetControlItemImg;
      end;//with l_Label
    end;//not l3IsNil(aMsg.rData.rFooter)

    if l_HasButtons then
    begin
     if (aMsg.rData.rDefaultButton <> mbOk) and
        (aMsg.rData.rDefaultButton in aMsg.rData.rButtons) then
      DefaultButton := aMsg.rData.rDefaultButton
     else
     if (mbOk in aMsg.rData.rButtons) then
      DefaultButton := mbOk
     else
     if (mbYes in aMsg.rData.rButtons) then
      DefaultButton := mbYes
     else
      DefaultButton := mbRetry;

     if (aMsg.rData.rCancelButton <> mbCancel) and
        (aMsg.rData.rCancelButton in aMsg.rData.rButtons) then
      CancelButton := aMsg.rData.rCancelButton
     else
     if (mbCancel in aMsg.rData.rButtons) then
      CancelButton := mbCancel
     else
     if (mbNo in aMsg.rData.rButtons) then
      CancelButton := mbNo
     else
      CancelButton := mbOk;
    end//l_HasButtons
    else
    begin
     DefaultButton := mbOk;
     CancelButton := mbCancel;
    end;//l_HasButtons

    if (Result is TMessageForm) then
    begin
     TMessageForm(Result).f_DefaultButton := DefaultButton;
     TMessageForm(Result).f_CancelButton := CancelButton;
     TMessageForm(Result).f_HasButtons := l_HasButtons;
     if (aAutoCloseInterval > 0) then
       TMessageForm(Result).SetCloseInterval(aAutoCloseInterval);
    end;//Result is TMessageForm..

    X := (ClientWidth - ButtonGroupWidth) - HorzMargin;

    if l3IsNil(aMsg.CheckCaption) then
    begin
     if l_HasChoices then
      Result.Height := Result.Height + VertSpacing;
    end//l3IsNil(aMsg.CheckCaption)
    else
     Result.Height := Result.Height + lCheckTextRect.Bottom + VertSpacing;

    if l_HasButtons then
    begin
     l_BackGround := TvgBackGround.Create(Result);
     with l_BackGround do
     begin
      Fill.Style := vgBrushSolid;
      Fill.Color := vgColorToStr(vgColorFromVCL(Result.Color));
     end;//with l_BackGround

     l_Scene := TvgScene.Create(Result);
     with l_Scene do
     begin
      //сохраняем для доступа из TMessageForm.CMDialogKey
      if (Result Is TMessageForm) then
       TMessageForm(Result).Scene := l_Scene;

      Parent := Result;
      AddObject(l_BackGround);
      SetBounds(0, IconTextHeight + VertMargin, Result.Width, Result.Height - IconTextHeight - VertMargin);
      Style := vtVGSceneResources.vgResources;
     end;//with l_Scene
     lp_CreateButtons(Result, X, IconTextHeight, l_CustomBTN, l_NewBtnWidth)
    end//l_HasButtons
    else
     Result.Height := Result.Height - VertSpacing - ButtonHeight;

    if not l3IsNil(aMsg.CheckCaption) then
    begin
     l_IsVGStyleCheck := l_HasButtons;

     if l_HasButtons then
      l_TopForCheck := IconTextHeight + VertMargin + 2 * VertSpacing + ButtonHeight
     else
      l_TopForCheck := IconTextHeight + VertMargin + l3MulDiv(VertSpacing,3,2);

     lp_CreateCheckBox(Result, lpLeftForCheck, l_TopForCheck, lCheckTextRect.Bottom, l_IsVGStyleCheck);
    end;//not l3IsNil(aMsg.CheckCaption)
   finally
    lCanvas.EndPaint;
   end;//try..finally
  finally
   l3Free(lCanvas);
  end;//try..finally
 end;//with Result
 Result.Loaded;
 // - заточка для того, чтобы дёрнуть TvcmEntityForm.Loaded, в котором на самом деле инициализируется вся обвязка VCM
 //   при отказе от dfm'ов - это должно куда-то переехать.
//#UC END# *4F915A68031C_4B8E676500AD_impl*
end;//vtCreateMessageDialog

function vcmMessageDlgPrim(const aMsg: Tl3Message;
 out Checked: Boolean;
 aTextAlign: TAlignment = Classes.taCenter;
 aWndParent: HWND = 0;
 aChoices: TPl3StringIDExList = nil;
 aJumpTo: TevJumpToEvent = nil;
 aNeedShowInTaskBar: Boolean = False): Integer;
//#UC START# *4B8E6787035D_4B8E676500AD_var*
 function lp_GetChoiceIndex(aOwner: TForm): Integer;
 var
  I            : Integer;
  l_FocusLabel : TvtFocusLabel;
 begin//lp_GetChoiceIndex
  Result := 0;
  for I := 0 to aChoices.Count-1 do
  begin
   l_FocusLabel := TvtFocusLabel(aOwner.FindComponent(cChoicesName + IntToStr(I)));
   if (l_FocusLabel <> nil) and (aOwner.ActiveControl = l_FocusLabel) then
   begin
    Result := I;
    Break;
   end;//l_FocusLabel <> nil
  end;//for I
 end;//lp_GetChoiceIndex

var
 l_Check : TComponent;
 l_Form  : TMessageForm;
 {$IfDef InsiderTest}
 l_Answer : Integer;
 {$EndIf InsiderTest}
//#UC END# *4B8E6787035D_4B8E676500AD_var*
begin
//#UC START# *4B8E6787035D_4B8E676500AD_impl*
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if (aMsg.rData.rDlgType = mtError) then
   raise Exception.Create(l3Str(aMsg.rMessage));
  l_Answer := Tl3BatchService.Instance.PopAnswer;
  if (l_Answer <> mrNone) and (l_Answer > 0) then
  begin
   Tl3BatchService.Instance.SignalWasDialog;
   // - эта строчка была НИЖЕ Assert'ов
   // http://mdp.garant.ru/pages/viewpage.action?pageId=337513713
   // http://mdp.garant.ru/pages/viewpage.action?pageId=337513713&focusedCommentId=337514042#comment-337514042
   if not (vtGetDlgResultBtn(l_Answer) in aMsg.rData.rButtons) then
    raise EvcmInvalidWaitedButton.Create('Неожиданная кнопка');
   if not ((l_Answer = mrOk) OR (aChoices = nil) OR (aChoices.Count <= 0)) then
    raise EvcmDialogHasChoices.Create('В диалоге есть сссылки');
   Result := l_Answer;
   Exit;
  end//l_Answer <> mrNone..
  else
  begin
   Tl3BatchService.Instance.SignalWasDialog;
   Result := l_Answer;
   Exit;
  end;
  if ((aMsg.rData.rButtons = [mbOK]) OR
      (aMsg.rData.rButtons = [mbYes])) AND
     ((aChoices = nil) OR (aChoices.Count <= 0)) then
  begin
   if (aMsg.rData.rButtons = [mbYes]) then
    Result := mrYes
   else
    Result := mrOk;
   Exit;
  end;//aButtons = [mbOK]
  raise EvcmUnwaitedDialog.Create('Неожиданный диалог');
 end;//Tl3BatchService.Instance.IsBatchMode
 {$EndIf InsiderTest}

 l_Form := vtCreateMessageDialog(aMsg,
                                 nil,
                                 aTextAlign,
                                 aWndParent,
                                 0,
                                 aChoices,
                                 aJumpTo);
 with l_Form do
  try
   Checked := false;
   HelpContext := aMsg.rData.rHelpCtx;

   NeedShowInTaskBar := aNeedShowInTaskBar;

   Result := ShowModal;
   if (Result in [mrOk, mrYes]) AND (aChoices <> nil) AND (aChoices.Count > 1) then
     Result := -(lp_GetChoiceIndex(l_Form)+1);

   if not l3IsNil(aMsg.CheckCaption) then
   begin
    // - здесь надо вытащить значение CheckBox'а
    l_Check := FindComponent(cCheckName);
    if (l_Check <> nil) then
    begin
     if (l_Check Is TvgCheckBox) then
      Checked := (l_Check As TvgCheckBox).IsChecked
     else
      Checked := (l_Check As TvtCheckBox).Checked;
    end;//l_Check <> nil
   end;//not l3IsNil(aMsg.CheckCaption)
  finally
   Free;
  end;//try..finally
//#UC END# *4B8E6787035D_4B8E676500AD_impl*
end;//vcmMessageDlgPrim

function TvtEffectiveDialogButton.pm_GetCaption: WideString;
//#UC START# *4F8FFFC80242_4F8FFF7302A2get_var*
//#UC END# *4F8FFFC80242_4F8FFF7302A2get_var*
begin
//#UC START# *4F8FFFC80242_4F8FFF7302A2get_impl*
 Result := Text;
//#UC END# *4F8FFFC80242_4F8FFF7302A2get_impl*
end;//TvtEffectiveDialogButton.pm_GetCaption

procedure TvtEffectiveDialogButton.pm_SetCaption(aValue: WideString);
//#UC START# *4F8FFFC80242_4F8FFF7302A2set_var*
//#UC END# *4F8FFFC80242_4F8FFF7302A2set_var*
begin
//#UC START# *4F8FFFC80242_4F8FFF7302A2set_impl*
 SetText(aValue);
//#UC END# *4F8FFFC80242_4F8FFF7302A2set_impl*
end;//TvtEffectiveDialogButton.pm_SetCaption

procedure TvtEffectiveDialogButton.ApplyStyle;
//#UC START# *4F90008B02C6_4F8FFF7302A2_var*
var
 l_Text: TvgText;
const
 cTextResourceName = 'Text';
//#UC END# *4F90008B02C6_4F8FFF7302A2_var*
begin
//#UC START# *4F90008B02C6_4F8FFF7302A2_impl*
 inherited;
 
 if Assigned(FChildren) then
 begin
  l_Text := TvgText(FindResource(cTextResourceName));
  if Assigned(l_Text) then
  begin
   l_Text.Padding.Left := 0;
   l_Text.Padding.Right := 0;
  end;
 end;
//#UC END# *4F90008B02C6_4F8FFF7302A2_impl*
end;//TvtEffectiveDialogButton.ApplyStyle

function TMessageForm.pm_GetNeedShowInTaskBar: Boolean;
//#UC START# *54507466026E_4F9000EA02E5get_var*
//#UC END# *54507466026E_4F9000EA02E5get_var*
begin
//#UC START# *54507466026E_4F9000EA02E5get_impl*
 Result := f_NeedShowInTaskBar;
//#UC END# *54507466026E_4F9000EA02E5get_impl*
end;//TMessageForm.pm_GetNeedShowInTaskBar

procedure TMessageForm.pm_SetNeedShowInTaskBar(aValue: Boolean);
//#UC START# *54507466026E_4F9000EA02E5set_var*
var
 l_ExStyle: LongInt;
//#UC END# *54507466026E_4F9000EA02E5set_var*
begin
//#UC START# *54507466026E_4F9000EA02E5set_impl*
 if (aValue <> f_NeedShowInTaskBar) then
 begin
  f_NeedShowInTaskBar := aValue;
  l_ExStyle := GetWindowLong(Handle, GWL_EXSTYLE);
  if f_NeedShowInTaskBar then
  begin
   if ((l_ExStyle and WS_EX_APPWINDOW) = 0) then
    SetWindowLong(Handle, GWL_EXSTYLE, l_ExStyle or WS_EX_APPWINDOW);
  end
  else
  begin
   if ((l_ExStyle and WS_EX_APPWINDOW) <> 0) then
    SetWindowLong(Handle, GWL_EXSTYLE, l_ExStyle and not WS_EX_APPWINDOW);
  end;
 end;
//#UC END# *54507466026E_4F9000EA02E5set_impl*
end;//TMessageForm.pm_SetNeedShowInTaskBar

procedure TMessageForm.SetCloseInterval(aCloseInterval: Integer);
//#UC START# *4F90082D0015_4F9000EA02E5_var*
//#UC END# *4F90082D0015_4F9000EA02E5_var*
begin
//#UC START# *4F90082D0015_4F9000EA02E5_impl*
 if Assigned(f_CloseTimer) then
  FreeAndNil(f_CloseTimer);

 if aCloseInterval > 0 then
 begin
  f_CloseTimer := TTimer.Create(Self);
  f_CloseTimer.Interval := 1000;
  f_CloseInterval := aCloseInterval;
  f_CloseTimer.OnTimer := evntOnCloseTimer;
  UpdateAutoCloseButton;
 end;
//#UC END# *4F90082D0015_4F9000EA02E5_impl*
end;//TMessageForm.SetCloseInterval

procedure TMessageForm.HelpButtonClick(Sender: TObject);
//#UC START# *4F9016AC027C_4F9000EA02E5_var*
//#UC END# *4F9016AC027C_4F9000EA02E5_var*
begin
//#UC START# *4F9016AC027C_4F9000EA02E5_impl*
 Application.HelpContext(HelpContext);
//#UC END# *4F9016AC027C_4F9000EA02E5_impl*
end;//TMessageForm.HelpButtonClick

procedure TMessageForm.evntOnCloseTimer(Sender: TObject);
//#UC START# *4F901822022E_4F9000EA02E5_var*
//#UC END# *4F901822022E_4F9000EA02E5_var*
begin
//#UC START# *4F901822022E_4F9000EA02E5_impl*
 Dec(f_CloseInterval);
 UpdateAutoCloseButton;
 if f_CloseInterval <= 0 then
  ModalResult := vtGetDlgBtnResult(f_DefaultButton);
//#UC END# *4F901822022E_4F9000EA02E5_impl*
end;//TMessageForm.evntOnCloseTimer

procedure TMessageForm.evntOnClickFocusLabel(Sender: TObject);
//#UC START# *4F90183A00D5_4F9000EA02E5_var*
//#UC END# *4F90183A00D5_4F9000EA02E5_var*
begin
//#UC START# *4F90183A00D5_4F9000EA02E5_impl*
 ModalResult := vtGetDlgBtnResult(f_DefaultButton);
//#UC END# *4F90183A00D5_4F9000EA02E5_impl*
end;//TMessageForm.evntOnClickFocusLabel

procedure TMessageForm.UpdateAutoCloseButton;
//#UC START# *4F90186F0386_4F9000EA02E5_var*
//#UC END# *4F90186F0386_4F9000EA02E5_var*
begin
//#UC START# *4F90186F0386_4F9000EA02E5_impl*
 if (f_AutoCloseButton <> nil) then
 begin
  f_AutoCloseButton.Caption := f_AutoCloseCaption;
  if f_CloseInterval > 0 then
   f_AutoCloseButton.Caption := f_AutoCloseButton.Caption + ' (' + IntToStr(f_CloseInterval) + ')';
 end;
//#UC END# *4F90186F0386_4F9000EA02E5_impl*
end;//TMessageForm.UpdateAutoCloseButton

procedure TMessageForm.SetAutoCloseButton(const Value: TvtEffectiveDialogButton);
//#UC START# *4F9008560068_4F9000EA02E5_var*
//#UC END# *4F9008560068_4F9000EA02E5_var*
begin
//#UC START# *4F9008560068_4F9000EA02E5_impl*
 f_AutoCloseButton := Value;
 f_AutoCloseCaption := Value.Caption;
 if f_CloseInterval > 0 then
  UpdateAutoCloseButton; 
//#UC END# *4F9008560068_4F9000EA02E5_impl*
end;//TMessageForm.SetAutoCloseButton

procedure TMessageForm.TextSourceGetControlItemImg(aSender: TObject;
 const aControl: TnevControlInfo;
 out theImageInfo: TnevControlImageInfo);
//#UC START# *4F914AE901C1_4F9000EA02E5_var*
//#UC END# *4F914AE901C1_4F9000EA02E5_var*
begin
//#UC START# *4F914AE901C1_4F9000EA02E5_impl*
 if aControl.rControl.AsObject.IsKindOf(k2_typCloak) then
 begin
  theImageInfo.rImageList := vtMakeImageListWrapper(vtResources.EditorImages);
  theImageInfo.rFirstIndex := -1;
  theImageInfo.rLastIndex := 0;
 end;//aControl.InheritsFrom(k2_idCloak)
//#UC END# *4F914AE901C1_4F9000EA02E5_impl*
end;//TMessageForm.TextSourceGetControlItemImg

procedure TMessageForm.DoAfterAdjustHeight(Sender: TObject;
 anOldHeight: Integer;
 aNewHeight: Integer);
//#UC START# *4F914B470122_4F9000EA02E5_var*
//#UC END# *4F914B470122_4F9000EA02E5_var*
begin
//#UC START# *4F914B470122_4F9000EA02E5_impl*
 Self.Height := Self.Height - anOldHeight + aNewHeight;
//#UC END# *4F914B470122_4F9000EA02E5_impl*
end;//TMessageForm.DoAfterAdjustHeight

constructor TMessageForm.CreateNewEx(aWndParent: HWND;
 AOwner: TComponent;
 Dummy: Integer = 0);
//#UC START# *4F9007D9001B_4F9000EA02E5_var*
//#UC END# *4F9007D9001B_4F9000EA02E5_var*
begin
//#UC START# *4F9007D9001B_4F9000EA02E5_impl*
 f_WndParent := aWndParent;
 if (f_WndParent = HWnd(0)) then
  f_WndParent := GetActiveWindow;
 //
 {$IfDef XE}
 CreateNew(AOwner);
 {$Else  XE}
 CreateNew(AOwner, Dummy);
 {$EndIf XE}
//#UC END# *4F9007D9001B_4F9000EA02E5_impl*
end;//TMessageForm.CreateNewEx

constructor TMessageForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4F9000EA02E5_var*
//#UC END# *47D1602000C6_4F9000EA02E5_var*
begin
//#UC START# *47D1602000C6_4F9000EA02E5_impl*
 inherited;
 {$IfDef XE}
 afwHackControlFont(Self);
 ZoneType := vcm_ztModal;
 {$EndIf XE}
//#UC END# *47D1602000C6_4F9000EA02E5_impl*
end;//TMessageForm.Create

{$If NOT Defined(NoVCL)}
procedure TMessageForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_4F9000EA02E5_var*
const
 WM_REACTIVATE_FORM = WM_USER+$0900;
 //
 function IsActivateAppMessage: Boolean;
 begin
  Result := ((Message.Msg = WM_ACTIVATEAPP) and TWMActivateApp(Message).Active);
 end;
 function IsReactivateFormMessage: Boolean;
 begin
  Result := ((Message.Msg = WM_REACTIVATE_FORM) and (GetActiveWindow <> Handle));
 end;
 //
 function IsSetCursorByLeftButtonMessage: Boolean;
 begin
  Result := ((Message.Msg = WM_SETCURSOR) and (Message.LParamHi = WM_LBUTTONDOWN) and not(IsWindowEnabled(Handle)));
 end;
 //
//#UC END# *47E136A80191_4F9000EA02E5_var*
begin
//#UC START# *47E136A80191_4F9000EA02E5_impl*
 if (not(csDesigning in ComponentState) and (GetWindowLong(Application.Handle, GWL_EXSTYLE) and not(WS_EX_TOOLWINDOW) <> 0)) then
 begin
  if (IsActivateAppMessage and HasFormModalState) then
  begin
   Message.Result := 0;
   PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
   Exit;
  end
  else
   if IsSetCursorByLeftButtonMessage then
   begin
    with Screen do
     if (ActiveForm <> nil) then
      with ActiveForm do
       if (Handle <> HWND(0)) then
       begin
        PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
        Message.Result := 0;
        Exit;
       end;
   end
   else
    if IsReactivateFormMessage then
    begin
     Message.Result := 0;
     SetActiveWindow(Handle);
     Exit;
    end;
 end;
 //
 inherited;
//#UC END# *47E136A80191_4F9000EA02E5_impl*
end;//TMessageForm.WndProc
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TMessageForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4F9000EA02E5_var*
//#UC END# *48C7925A02E5_4F9000EA02E5_var*
begin
//#UC START# *48C7925A02E5_4F9000EA02E5_impl*
 inherited;
 if (GetWindowLong(Application.Handle, GWL_EXSTYLE) and not(WS_EX_TOOLWINDOW) <> 0) then
  Params.WndParent := f_WndParent;
 if f_NeedShowInTaskBar then
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
//#UC END# *48C7925A02E5_4F9000EA02E5_impl*
end;//TMessageForm.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TMessageForm.DoShow;
//#UC START# *4B321D1301DD_4F9000EA02E5_var*
var
 l_Mon: TMonitor;
 l_Left, l_Top: Integer;
//#UC END# *4B321D1301DD_4F9000EA02E5_var*
begin
//#UC START# *4B321D1301DD_4F9000EA02E5_impl*
 inherited;
 l_Mon := Screen.MonitorFromWindow(f_WndParent);
 l_Left := l_Mon.Left + (l_Mon.Width - Width) div 2;
 l_Top := l_Mon.Top + (l_Mon.Height - Height) div 2;
 SetWindowPos(Handle, 0, l_Left, l_Top, 0, 0, SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE);
 SetForegroundWindow(Handle);
//#UC END# *4B321D1301DD_4F9000EA02E5_impl*
end;//TMessageForm.DoShow
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
constructor TMessageForm.CreateNew(AOwner: TComponent;
 Dummy: Integer = 0);
//#UC START# *4F9007B20376_4F9000EA02E5_var*
//#UC END# *4F9007B20376_4F9000EA02E5_var*
begin
//#UC START# *4F9007B20376_4F9000EA02E5_impl*
 inherited;
 afwHackControlFont(Self);
 ZoneType := vcm_ztModal;
//#UC END# *4F9007B20376_4F9000EA02E5_impl*
end;//TMessageForm.CreateNew
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TMessageForm.ShowModal: Integer;
//#UC START# *520B42AF0115_4F9000EA02E5_var*
//#UC END# *520B42AF0115_4F9000EA02E5_var*
begin
//#UC START# *520B42AF0115_4F9000EA02E5_impl*
 afw.ProcessMessages;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=566102125
 Result := inherited ShowModal;
//#UC END# *520B42AF0115_4F9000EA02E5_impl*
end;//TMessageForm.ShowModal
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtEffectiveDialogButton);
 {* Регистрация TvtEffectiveDialogButton }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMessageForm);
 {* Регистрация TMessageForm }
{$IfEnd} // NOT Defined(NoScripts)
//#UC START# *4F9151EF00EF*
 l3FillChar(ButtonWidths, SizeOf(TButtonWidths));
//#UC END# *4F9151EF00EF*
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene)

end.
