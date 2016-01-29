{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$I ..\ElPack.inc}

(*

Version History

10/27/2002

  Fixed setting of default and cancel buttons for ElMessageDlg function
and ElMessageDlgEx functions

06/26/2002

  Changed default for Position property
  Added All button

06/05/2002

  Added Position property.

02/07/2002

  Font and ParentFont properties added

08/03/2001

  ShowAgainChecked property was not set to checkbox value after the form is shown

12/19/2000

  OnFormClose event didn't get called. Fixed.

10/20/2000

  TopMost property added

10/16/2000

  HTML support added

10/06/2000

  Button captions made published to simplify translation of the dialog

09/20/2000

  ElMessageDlg function added.

*)

unit ElPromptDlg;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Clipbrd,
  Dialogs,
  ElBtnCtl,
  ElCheckCtl,
  ElPopBtn,
  ElStrPool,
  ElStrUtils,
  ElStrArray,
{$IFDEF VCL_4_USED}
  ImgList,
{$ENDIF}
{$ifdef ELPACK_UNICODE}
  ElUnicodeStrings,
{$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
  ElImgLst,
  ElHTMLLbl,
  HTMLRender,
  ElFrmPers,
  ElVCLUtils,
  ExtCtrls,
  StdCtrls,
  ElXPThemedControl,
  ElPanel,
  TypInfo,
  Consts,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ElCaption,
  ElCLabel;

type

  TElPromptFormClass = class of TElPromptForm;

  TPromptCloseEvent = procedure (Sender : TObject; Result : integer) of object;

  TElPromptForm = class(TForm)
    Timer: TTimer;
    ElPanel1: TElPanel;
    TimeLabel: TLabel;
    Image: TImage;
    MessageLabel: TElHTMLLabel;
    ShowAgainCB: TElCheckBox;
    HelpBtn: TElPopupButton;
    OkBtn: TElPopupButton;
    IgnoreBtn: TElPopupButton;
    YesBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    NoBtn: TElPopupButton;
    NoToAllBtn: TElPopupButton;
    AbortBtn: TElPopupButton;
    RetryBtn: TElPopupButton;
    YesToAllBtn: TElPopupButton;
    ElFormPersist1: TElFormPersist;
    DisabledImages: TElImageList;
    EnabledImages: TElImageList;
    Captions: TElFormCaption;
    ElPopupButton1: TElPopupButton;
    procedure TimerTimer(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnClick(Sender: TObject);
    procedure MessageLabelLinkClick(Sender: TObject; HRef: TElFString);
    procedure MessageLabelImageNeeded(Sender: TObject; Src: TElFString;
      var Image: TBitmap);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FDisableOk : boolean;
    FLeft      : integer;
    FShowTime  : boolean;
    FSaveDefText: TElFString;
    SecondsCaption: TElFString;
    DefaultButton : TElPopupButton;
    Modal      : boolean;
    FOnImageNeed: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnTimer    : TNotifyEvent;
    FOnClose    : TPromptCloseEvent;

    procedure WMSysCommand(var Message : TMessage); message WM_SYSCOMMAND;
  public
    CustomData  : pointer;
  end;

  TElPromptDialog = class(TCommonDialog)
  protected
    FTopmost      : boolean;
    FControlTexts : TElFStringArray;
    FMessage    : TElFString;
    FCaptionIdx,
    FMessageIdx : integer;
    FDlgType    : TMsgDlgType;
    FCaptions,
    FTexts      : TElFStringArray;
    FButtons    : TMsgDlgButtons;
    FDefBtn     : TMsgDlgBtn;
    FCancelBtn  : TMsgDlgBtn;
    FShowGlyphs : boolean;
    FTimeLimit  : integer;
    FShowOnceMore: boolean;
    FShowAgainChecked : boolean;
    FTimedShow  : boolean;
    FHelpCtx    : THelpContext;
    FShowAgainText : TElFString;
    FDlgCaption    : TElFString;
    FIsHTML        : boolean;
    FPosition      : TPosition;

    FOnBeforeShow  : TNotifyEvent;
    FOnTimer    : TNotifyEvent;
    FOnClose    : TPromptCloseEvent;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FClass      : TElPromptFormClass;
    FParentFont,
    FParentCaptionFont : Boolean;
    FFont,
    FCaptionFont : TFont;
    FForm       : TElPromptForm;
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleManager: TElStyleManager;
    FStyleName: string;
    {$endif}
    FUseXPThemes: Boolean;
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    {$endif}
    procedure CloseTransfer(Sender : TObject; Result : integer);
    procedure SetTexts(anArray : TElFStringArray);
    procedure SetCaptions(anArray : TElFStringArray);
    procedure SetControlTexts(newValue : TElFStringArray);
    function  CreateWndx : TElPromptForm;
    procedure SetParentFont(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetParentCaptionFont(Value: Boolean);
    procedure SetCaptionFont(Value: TFont);
    procedure FontChange(Sender : TObject);
    procedure CaptionFontChange(Sender : TObject);
  public
    CustomData : pointer;

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    function ShowModal : integer;
    procedure Show;
    function Execute: Boolean; override;

    property FormClass : TElPromptFormClass read FClass write FClass;
  published
    property DisableDefault: boolean read FTimedShow write FTimedShow;
    property DefaultButton : TMsgDlgBtn read FDefBtn write FDefBtn;
    property CancelButton  : TMsgDlgBtn read FCancelBtn write FCancelBtn;
    property TimeDelay     : integer read FTimeLimit write FTimeLimit;
    property ShowGlyphs    : boolean read FShowGlyphs write FShowGlyphs;
    property Texts         : TElFStringArray read FTexts write SetTexts;
    property ControlTexts  : TElFStringArray read FControlTexts write SetControlTexts;  { Published }
    property DialogCaption : TElFString read FDlgCaption write FDlgCaption;
    property Message       : TElFString read FMessage write FMessage;
    property MessageIdx    : integer read FMessageIdx write FMessageIdx default -1;
    property DlgType       : TMsgDlgType read FDlgType write FDlgType;
    property Buttons       : TMsgDlgButtons read FButtons write FButtons;
    property ShowAgainCheck   : boolean read FShowOnceMore write FShowOnceMore;
    property ShowAgainChecked : boolean read FShowAgainChecked write FShowAgainChecked;
    property ShowAgainText    : TElFString read FShowAgainText write FShowAgainText;
    property Captions         : TElFStringArray read FCaptions write SetCaptions;
    property CaptionIdx       : integer read FCaptionIdx write FCaptionIdx;
    property HelpContext      : THelpContext read FHelpCtx write FHelpCtx;
    property IsHTML           : boolean read FIsHTML write FIsHTML;
    property TopMost          : boolean read FTopmost write FTopmost;
    property Position         : TPosition read FPosition write FPosition;
    property OnTimer          : TNotifyEvent read FOnTimer write FOnTimer;
    property OnClose          : TPromptCloseEvent read FOnClose write FOnClose;
    property OnBeforeShow     : TNotifyEvent read FOnBeforeShow write FOnBeforeShow;
    property OnHTMLImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick      : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property ParentFont       : Boolean read FParentFont write SetParentFont default true;
    property Font             : TFont read FFont write SetFont;
    property ParentCaptionFont: Boolean read FParentCaptionFont write SetParentCaptionFont default true;
    property CaptionFont      : TFont read FCaptionFont write SetCaptionFont;
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
    property UseXPThemes: Boolean read FUseXPThemes write FUseXPThemes default true;
  end;

var
  ElPromptForm: TElPromptForm;

function ElMessageDlg(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
function ElMessageDlgEx(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; FormClass : TElPromptFormClass): Word;
function ElMessageDlgEx2(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; IsHTML : boolean; OnLinkClick : TElHTMLLinkClickEvent ): Word;

resourcestring
  SShowNextTime = 'Show next time';
  SDSecondsLeft = '%d seconds left';

implementation

uses ElList, ElTools;

{$R *.DFM}

const

    ModalResults: array[TMsgDlgBtn] of Integer = (
             mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
             mrYesToAll, 0);

function ElMessageDlg(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Word;
begin
  result := ElMessageDlgEx(Msg, DlgType, Buttons, HelpCtx, TElPromptForm);
end;

function ElMessageDlgEx2(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; IsHTML : boolean; OnLinkClick : TElHTMLLinkClickEvent): Word;
var Dlg : TElPromptDialog;
begin
  Dlg := TElPromptDialog.Create(nil);
  try
    Dlg.DlgType := DlgType;
    Dlg.Buttons := Buttons;

    if mbOk in Buttons then
      Dlg.DefaultButton := mbOk
    else
    if mbYes in Buttons then
      Dlg.DefaultButton := mbYes
    else
      Dlg.DefaultButton := mbRetry;

    if mbCancel in Buttons then
      Dlg.CancelButton := mbCancel
    else
    if mbNo in Buttons then
      Dlg.CancelButton := mbNo
    else
      Dlg.CancelButton := mbOk;


    Dlg.Message := Msg;
    Dlg.HelpContext := HelpCtx;
    Dlg.IsHTML := true;
    Dlg.OnLinkClick := OnLinkClick;
    result := Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

function ElMessageDlgEx(const Msg: TElFString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; FormClass : TElPromptFormClass): Word;
var Dlg : TElPromptDialog;
begin
  Dlg := TElPromptDialog.Create(nil);
  try
    Dlg.DlgType := DlgType;
    Dlg.Buttons := Buttons;

    if mbOk in Buttons then
      Dlg.DefaultButton := mbOk
    else
    if mbYes in Buttons then
      Dlg.DefaultButton := mbYes
    else
      Dlg.DefaultButton := mbRetry;

    if mbCancel in Buttons then
      Dlg.CancelButton := mbCancel
    else
    if mbNo in Buttons then
      Dlg.CancelButton := mbNo
    else
      Dlg.CancelButton := mbOk;

    Dlg.Message := Msg;
    Dlg.HelpContext := HelpCtx;
    Dlg.FormClass := FormClass;
    result := Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TElPromptDialog.SetCaptions(anArray : TElFStringArray);
begin
  FCaptions.Assign(anArray);
end;

procedure TElPromptDialog.SetTexts(anArray : TElFStringArray);
begin
  FTexts.Assign(anArray);
end;

constructor TElPromptDialog.Create(AOwner : TComponent);
begin
  inherited;
  FUseXPThemes := true;
  FTexts := TElFStringArray.Create;
  FCaptions:= TElFStringArray.Create;
  FControlTexts := TElFStringArray.Create;
  FControlTexts.Capacity := 13;

  FControlTexts[0] := SMsgDlgYes;
  FControlTexts[1] := SMsgDlgNo;
  FControlTexts[2] := SMsgDlgOK;
  FControlTexts[3] := SMsgDlgCancel;
  FControlTexts[4] := SMsgDlgAbort;
  FControlTexts[5] := SMsgDlgRetry;
  FControlTexts[6] := SMsgDlgIgnore;
  FControlTexts[7] := SMsgDlgAll;
  FControlTexts[8] := SMsgDlgNoToAll;
  FControlTexts[9] := SMsgDlgYesToAll;
  FControlTexts[10]:= SMsgDlgHelp;

  FControlTexts[11]:= SShowNextTime;
  FControlTexts[12] := SDSecondsLeft;

  FMessageIdx := -1;
  FCaptionIdx := -1;
  FFont := TFont.Create;
  FFont.OnChange := FontChange;
  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := CaptionFontChange;
end;

destructor TElPromptDialog.Destroy;
begin
  FTexts.Free;
  FCaptions.Free;
  FControlTexts.Free;
  FFont.Free;
  FCaptionFont.Free;
  inherited;
end;

function TElPromptDialog.Execute: Boolean;
begin
  result := ShowModal in [mrOk, mrYes, mrYesToAll];
end;

function TElPromptDialog.ShowModal : integer;
begin
  with CreateWndx do
  try
    Modal := true;
    result := ShowModal;
    Self.ShowAgainChecked := ShowAgainCB.Checked;
  finally
    Free;
  end;
end;

procedure TElPromptDialog.Show;
begin
  with CreateWndx do
  begin
    Application.BringToFront;
    BringToFront;
    Modal := false;
    Show;
  end;
end;

var ButtonWidths : array[TMsgDlgBtn] of integer;  // initialized to zero

function TElPromptDialog.CreateWndx : TElPromptForm;
const
    IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
             IDI_ASTERISK, IDI_QUESTION, nil);

var
    FButtons : TElList;

    function GetBtn(ABtnType : TMsgDlgBtn) : TElPopupButton;
    var i : integer;
    begin
      result := nil;
      for i := 0 to FButtons.Count - 1 do
      begin
        if TElPopupButton(FButtons[i]).ModalResult = ModalResults[aBtnType] then
        begin
          result := TElPopupButton(FButtons[i]);
          exit;
        end;
      end;
    end;

    function GetAveCharSize(Canvas: TCanvas): TPoint;
    var
      I: Integer;
      Buffer: array[0..51] of Char;
    begin
      for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
      for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
      GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
      Result.X := Result.X div 52;
    end;

var
  i, j : integer;
  S    : String;
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, Y, ALeft: Integer;
  B: TMsgDlgBtn;
  aBtn     : TElPopupButton;
  Rect1,
  TxtRect  : TRect;
  TOrder   : integer;
  AControl : TControl;
  yoffs    : integer;
  IconID   : PChar;
  PropInfo : PPropInfo;

const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
begin
  case DlgType of
    mtError: i := MB_ICONHAND;
    mtWarning: i := MB_ICONEXCLAMATION;
    mtInformation: i := MB_ICONASTERISK;
    mtConfirmation: i := MB_ICONQUESTION;
    else i := -1;
  end;
  MessageBeep(i);
  if FClass = nil then
     result := TElPromptForm.create(Application)
  else
     result := FClass.Create(Application);
  result.MessageLabel.WordWrap := false;
  result.MessageLabel.IsHTML := FIsHTML;
  if FMessageIdx <> -1 then
     Result.MessageLabel.Caption := FTexts[FMessageIdx]
  else
     Result.MessageLabel.Caption := FMessage;
  Result.FOnImageNeed := FOnImageNeeded;
  Result.FOnLinkClick := FOnLinkClick;

  FButtons := TElList.Create;

  Result.Font := Font;
  // Result.Font.Style := []; //Force label font style to normal

  if not ParentCaptionFont then
  begin
    Result.Captions.Font := CaptionFont;
    Result.Captions.SystemFont := false;
  end
  else
    Result.Captions.SystemFont := true;
     
  j := Result.ElPanel1.ControlCount;
  for i := 0 to j - 1 do
  begin
    AControl := Result.ElPanel1.Controls[i];
    if (AControl is TElPopupButton) and (AControl.Tag = 1458) then
      FButtons.Add(AControl);
  end;

  with result do
  begin
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    TOrder := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TxtRect := Rect(0,0,0,0);
          {$ifdef ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(canvas.handle,
            PWideChar(FControlTexts[Integer(B)]), -1,
            TxtRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE
{$IFDEF VCL_4_USED}
            or DrawTextBiDiModeFlagsReadingOnly
{$ENDIF}
            );
          {$else}
          Windows.DrawText(canvas.handle,
            PChar(FControlTexts[Integer(B)]), -1,
            TxtRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE
{$IFDEF VCL_4_USED}
            or DrawTextBiDiModeFlagsReadingOnly
{$ENDIF}
            );
          {$endif}
          with TxtRect do
            ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
           ButtonWidth := ButtonWidths[B];
      end;
    end;

    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TxtRect, 0, 0, Screen.Width div 2, 0);

    TxtRect := MessageLabel.TextRect;

    IconID := IconIDs[DlgType];

    IconTextWidth := TxtRect.Right;
    IconTextHeight := TxtRect.Bottom;

    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;

    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(MessageLabel.Left + TxtRect.Right, Max(IconTextWidth, ButtonGroupWidth)) + HorzMargin * 2;
    if FShowOnceMore then
       yoffs := ShowAgainCB.Height + VertSpacing
    else
       yoffs := 0;
    if (FTimeLimit > 0) and (not Self.FTimedShow) then
    begin
      SetRectEmpty(Rect1);
      Rect1.Right := ClientWidth - HorzSpacing * 2;
      S := Format(FControlTexts[12], [FTimeLimit]);
      DrawText(Canvas.Handle, PChar(S), Length(S) + 1, Rect1,
               DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK
{$IFDEF VCL_4_USED}
               or
               DrawTextBiDiModeFlagsReadingOnly
{$ENDIF}
               );
      TimeLabel.Caption := S;
      inc(yoffs, Rect1.Bottom + VertSpacing);
      TimeLabel.Visible := true;
    end;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing + VertMargin * 2 + yoffs;

    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);

    if IconID <> nil then
    with Result.Image do
    begin
      Picture.Icon.Handle := LoadIcon(0, IconID);
      SetBounds(HorzMargin, VertMargin, 32, 32);
    end;

    with MessageLabel do
    begin
      BoundsRect := TxtRect;
{$IFDEF VCL_4_USED}
      BiDiMode := Result.BiDiMode;
{$ENDIF}
      ALeft := IconTextWidth - TxtRect.Right + HorzMargin;
{$IFDEF VCL_4_USED}
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
{$ENDIF}
      SetBounds(ALeft, VertMargin,
        TxtRect.Right, TxtRect.Bottom);
    end;

    if FDefBtn in Buttons then
    begin
      DefaultButton := GetBtn(FDefBtn);
      if DefaultButton <> nil then
        DefaultButton.Default := true;
    end;

    if FCancelBtn in Buttons then
    begin
      aBtn := GetBtn(FCancelBtn);
      if aBtn <> nil then aBtn.Cancel := true;
    end;

    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      aBtn := GetBtn(B);
      if aBtn <> nil then
      begin
        aBtn.Visible := B in Buttons;
        if aBtn.Visible then
          with aBtn do
          begin
            TabOrder := TOrder;
            Inc(TOrder);

            Caption := FControlTexts[Integer(B)];
            ModalResult := ModalResults[B];
            ShowGlyph := Self.FShowGlyphs;

            SetBounds(X, IconTextHeight + VertMargin + VertSpacing + yoffs,
              ButtonWidth, ButtonHeight);
            Inc(X, ButtonWidth + ButtonSpacing);
          end;
      end;
    end;
    if TimeLabel.Visible then
    begin
      Y := Max(VertMargin + MessageLabel.Height, Image.Top + Image.Height) + VertSpacing;
      X := (ClientWidth - Rect1.Right) div 2;
      TimeLabel.SetBounds(X, Y, Rect1.Right, Rect1.Bottom);
      Inc(Y, Rect1.Bottom + VertSpacing);
    end else
      Y := Max(VertMargin + MessageLabel.Height, Image.Top + Image.Height) + VertSpacing;
    ShowAgainCB.SetBounds(HorzMargin, Y, Width - HorzMargin * 2, ShowAgainCB.Height);
  end;

  FButtons.Free;

  if CaptionIdx <> -1 then
     Result.Captions.Texts[0].Caption := Captions[CaptionIdx]
  else
  if DialogCaption <> '' then
     Result.Captions.Texts[0].Caption := FDlgCaption
  else
    Result.Captions.Texts[0].Caption := Application.Title;

  Result.ShowAgainCB.Visible := FShowOnceMore;
  if FShowOnceMore then
    Result.ShowAgainCB.TabOrder := TOrder;

  Result.ShowAgainCB.Checked := FShowAgainChecked;
  if FShowAgainText <> '' then
     Result.ShowAgainCB.Caption := FShowAgainText
  else
     Result.ShowAgainCB.Caption := FControlTexts[11];

  Result.ElFormPersist1.TopMost := Topmost;

  if FTimeLimit > 0 then
  begin
    Result.FLeft := FTimeLimit;
    Result.FShowTime := true;
    Result.Timer.Interval := 1000;
    Result.Timer.Enabled  := true;
    Result.FDisableOk := FTimedShow;
    if FTimedShow then
    begin
      if Result.DefaultButton <> nil then
      begin
        Result.FSaveDefText := Result.DefaultButton.Caption;
        Result.DefaultButton.Caption := IntToStr(FTimeLimit);
        Result.DefaultButton.Enabled := false;
      end;
    end;
  end;

  Result.SecondsCaption := FControlTexts[12];
  Result.FOnTimer := FOnTimer;
  Result.FOnClose := CloseTransfer;
  Result.Tag := Tag;
  Result.CustomData := CustomData;
  Result.HelpContext := HelpContext;
  Result.Position := Position;
  FForm := Result;

{$IFDEF ELPACK_USE_STYLEMANAGER}
  with FForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
      if PropInfo <> nil then
        SetObjectProp(Components[i], PropInfo, Self.StyleManager);
      PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
      if PropInfo <> nil then
        SetStrProp(Components[i], PropInfo, Self.StyleName);
    end;
{$ENDIF}
  with FForm do
    for i := 0 to ComponentCount - 1 do
    begin
      PropInfo := TypInfo.GetPropInfo(Components[i].ClassInfo, 'UseXPThemes');
      if PropInfo <> nil then
        SetOrdProp(Components[i], PropInfo, Ord(UseXPThemes));
    end;

  if assigned(FOnBeforeShow) then FOnBeforeShow(Result);
end;

procedure TElPromptDialog.SetControlTexts(newValue : TElFStringArray);
begin
  FControlTexts.Assign(newValue);
end;  { SetControlTexts }

procedure TElPromptDialog.SetParentFont(Value: Boolean);
var AForm : TForm;
begin
  if FParentFont <> Value then
  begin
    if Value then
    begin
      AForm := GetOwnerForm(Self);
      if AForm <> nil then
        Font := AForm.Font;
      FParentFont := true;
    end
    else
      FParentFont := false;
  end;
end;

procedure TElPromptDialog.SetParentCaptionFont(Value: Boolean);
var AForm : TForm;
begin
  if FParentCaptionFont <> Value then
  begin
    if Value then
    begin
      AForm := GetOwnerForm(Self);
      if AForm <> nil then
        CaptionFont := AForm.Font;
      FParentCaptionFont := true;
    end
    else
      FParentCaptionFont := false;
  end;
end;

procedure TElPromptDialog.SetFont(Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    ParentFont := false;
  end;
end;

procedure TElPromptDialog.SetCaptionFont(Value: TFont);
begin
  if FCaptionFont <> Value then
  begin
    FCaptionFont.Assign(Value);
    ParentCaptionFont := false;
  end;
end;

procedure TElPromptDialog.CloseTransfer(Sender : TObject; Result : integer);
begin
  FForm := nil;
  if assigned(FOnClose) then
    FOnClose(Sender, Result);
end;

procedure TElPromptDialog.FontChange(Sender : TObject);
begin
  ParentFont := false;
  if FForm <> nil then
  begin
    FForm.Font := FFont;
    //FForm.Captions.Font := FFont;
    //FForm.Captions.SystemFont := false;
  end;
end;

procedure TElPromptDialog.CaptionFontChange(Sender : TObject);
begin
  ParentCaptionFont := false;
  if FForm <> nil then
  begin
    FForm.Captions.Font := FCaptionFont;
    FForm.Captions.SystemFont := false;
  end;
end;
{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TElPromptDialog.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    FStyleManager := Value;
    if FStyleManager <> nil then
      FStyleManager.FreeNotification(Self);
  end;
end;

procedure TElPromptDialog.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
    FStyleName := Value;
end;
{$endif}

procedure TElPromptForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TElPromptForm.MessageLabelImageNeeded(Sender: TObject;
  Src: TElFString; var Image: TBitmap);
begin
  if Assigned(FOnImageNeed) then
     FOnImageNeed(Self, Src, Image);
end;

procedure TElPromptForm.MessageLabelLinkClick(Sender: TObject;
  HRef: TElFString);
begin
  if Assigned(FOnLinkClick) then
     FOnLinkClick(Self, HRef);
end;

procedure TElPromptForm.FormShow(Sender: TObject);
begin
  ElPanel1.TabStop := false;
  if Assigned(DefaultButton) then
    DefaultButton.SetFocus;
  MessageLabel.OnLinkClick := MessageLabelLinkClick;
  MessageLabel.OnImageNeeded := MessageLabelImageNeeded;
  if FDisableOk then
  begin
    EnableMenuItem(GetSystemMenu(Handle, false), SC_CLOSE, MF_BYCOMMAND or MF_DISABLED);
  end;
end;

procedure TElPromptForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FOnClose) then
     FOnClose(Self, ModalResult);
  if not Modal then
     Action := caFree;
end;

procedure TElPromptForm.BtnClick(Sender: TObject);
var Btn : TElPopupButton;
begin
  Btn := Sender as TElPopupButton;
  if (Btn.ModalResult <> mrNone) and (not Modal) then
  begin
    ModalResult := Btn.ModalResult;
    Close;
  end;
end;

procedure TElPromptForm.WMSysCommand(var Message : TMessage);
begin
  if (Message.wParam = SC_CLOSE) and FDisableOk and (FLeft > 0) then
  begin
    Message.Result := 0;
    exit;
  end;
  inherited;
end;

procedure TElPromptForm.TimerTimer(Sender: TObject);
begin
  dec(FLeft);
  if not FDisableOk then
  begin
    if FLeft > 0 then
    begin
      TimeLabel.Caption := Format(SecondsCaption, [FLeft]);
    end else
    begin
      if assigned(FOnTimer) then FOnTimer(Self);
      if assigned(FOnClose) then
      begin
        if DefaultButton <> nil then
           FOnClose(Self, DefaultButton.ModalResult)
        else
           FOnClose(Self, mrNone);
      end;
      if DefaultButton <> nil then
         DefaultButton.Click
      else
        Close;
    end;
  end else
  begin
    if FLeft > 0 then
    begin
      if DefaultButton <> nil then
         DefaultButton.Caption := IntToStr(FLeft);
    end else
    begin
      if assigned(FOnTimer) then FOnTimer(Self);
      EnableMenuItem(GetSystemMenu(Handle, false), SC_CLOSE, MF_BYCOMMAND or MF_ENABLED);
      if DefaultButton <> nil then
      begin
        DefaultButton.Enabled := true;
        DefaultButton.Caption := FSaveDefText;
      end;
    end;
  end;
end;

procedure TElPromptForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and ((Key = VK_INSERT) or (Key = ord('c'))) then
  begin
    CopyTextToClipboard(MessageLabel.PlainText);
    Key := 0;
  end;
end;

end.
