{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Memo.Win;

interface

{$SCOPEDENUMS ON}

uses
  System.TypInfo, System.Types, System.Classes, FMX.Types, FMX.Controls.Presentation, FMX.Memo.Types, FMX.Memo,
  FMX.Presentation.Messages, FMX.Presentation.Win, Winapi.Messages, FMX.Controls.Model, FMX.Controls.Win,
  FMX.ScrollBox;

type
  TWinNativeMemo = class(TWinPresentation)
  private
    FModel: TCustomMemoModel;
    function GetMemo: TCustomMemo;
    procedure UpdateTextSettings;
    procedure CopyModelToNative;
    procedure CopyNativeToModel;
    procedure SetReadOnly;
    procedure SetMaxLength;
    procedure SetSelStart;
    procedure SetSelLength;
  protected
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function DefineModelClass: TDataModelClass; override;
    /// <summary>Updates visible of native scroll bars</summary>
    procedure UpdateScrollBarsVisibility; virtual;
  protected
    { Messages from Model }
    procedure MMTextSettingsChanged(var AMessage: TDispatchMessage); message MM_MEMO_TEXT_SETTINGS_CHANGED;
    procedure MMReadOnly(var AMessage: TDispatchMessage); message MM_MEMO_READONLY_CHANGED;
    procedure MMGetCaretPosition(var AMessage: TDispatchMessageWithValue<TCaretPosition>); message MM_MEMO_GET_CARET_POSITION;
    procedure MMSetCaretPosition(var AMessage: TDispatchMessageWithValue<TCaretPosition>); message MM_MEMO_SET_CARET_POSITION;
    procedure MMMaxLengthChanged(var AMessage: TDispatchMessage); message MM_MEMO_MAXLENGTH_CHANGED;
    procedure MMLinesInsertLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>); message MM_MEMO_LINES_INSERT_LINE;
    procedure MMLinesPutLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>); message MM_MEMO_LINES_PUT_LINE;
    procedure MMLinesDeleteLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>); message MM_MEMO_LINES_DELETE_LINE;
    procedure MMLinesExchangeLines(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>); message MM_MEMO_LINES_EXCHANGE_LINES;
    procedure MMLinesClear(var Message: TDispatchMessage); message MM_MEMO_LINES_CLEAR;
    procedure MMLinesChanged(var Message: TDispatchMessage); message MM_MEMO_LINES_CHANGED;
    procedure MMShowScrollBarChanged(var Message: TDispatchMessage); message MM_SHOW_SCROLLBAR_CHANGED;
    procedure MMCharCaseChanged(var Message: TDispatchMessage); message MM_MEMO_CHARCASE_CHANGED;
    procedure MMHideSelectionOnExitChanged(var Message: TDispatchMessage); message MM_MEMO_HIDESELECTIONONEXIT_CHANGED;
    /// <summary>Notification about changes of scroll direction in Model.ScrollDirection</summary>
    procedure MMScrollDirectionChanged(var AMessage: TDispatchMessageWithValue<TScrollDirections>); message MM_SCROLL_DIRECTIONS_CHANGED;
    { Messages from PresentationProxy }
    procedure PMDoEnter(var AMessage: TDispatchMessage); message PM_DO_ENTER;
    { Windows messages }
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Memo: TCustomMemo read GetMemo;
    property Model: TCustomMemoModel read FModel;
  end;

implementation

uses
  System.UITypes, System.SysUtils, System.Math, Winapi.Windows, FMX.Consts, FMX.Controls, FMX.Graphics,
  FMX.Presentation.Factory, FMX.Helpers.Win;

{ TWinNativeMemo }

constructor TWinNativeMemo.Create(AOwner: TComponent);
begin
  inherited;
  FModel := TCustomMemoModel(inherited Model);
end;

procedure TWinNativeMemo.CreateHandle;
begin
  inherited;
  if Handle <> NullHWnd then
  begin
    SetMaxLength;
    SetSelStart;
    SetSelLength;
    UpdateTextSettings;
    CopyModelToNative;
  end;
end;

procedure TWinNativeMemo.CreateParams(var Params: TCreateParams);
const
  EditClassName = 'EDIT'; // Do not localize
begin
  inherited;
  CreateSubClass(Params, EditClassName);
  with Params do
  begin
    Style := Style or ES_MULTILINE;
    if (Model.ScrollDirections = TScrollDirections.Both) or (Model.ScrollDirections = TScrollDirections.Vertical) then
      Style := Style or ES_AUTOVSCROLL;
    if not Model.TextSettingsInfo.ResultingTextSettings.WordWrap
      and (Model.ScrollDirections = TScrollDirections.Both) or (Model.ScrollDirections = TScrollDirections.Horizontal) then
      Style := Style or ES_AUTOHSCROLL;
    if Model.ShowScrollBars then
      case Model.ScrollDirections of
        TScrollDirections.Both:
          Style := Style or WS_HSCROLL or WS_VSCROLL;
        TScrollDirections.Horizontal:
          Style := Style or WS_HSCROLL;
        TScrollDirections.Vertical:
          Style := Style or WS_VSCROLL;
      end;
    case Model.TextSettingsInfo.ResultingTextSettings.HorzAlign of
      TTextAlign.Center:
        Style := Style or ES_CENTER;
      TTextAlign.Leading:
        Style := Style or ES_LEFT;
      TTextAlign.Trailing:
        Style := Style or ES_RIGHT;
    end;
    if Model.ReadOnly then
      Style := Style or ES_READONLY;
    if Model.CharCase = TEditCharCase.ecLowerCase then
      Style := Style or ES_LOWERCASE
    else if Model.CharCase = TEditCharCase.ecUpperCase then
      Style := Style or ES_UPPERCASE;
    if not Model.HideSelectionOnExit then
      Style := Style or ES_NOHIDESEL;
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

function TWinNativeMemo.DefineModelClass: TDataModelClass;
begin
  Result := TCustomMemoModel;
end;

destructor TWinNativeMemo.Destroy;
begin
  inherited;
end;

function TWinNativeMemo.GetMemo: TCustomMemo;
begin
  Result := Control as TCustomMemo
end;

procedure TWinNativeMemo.MMCharCaseChanged(var Message: TDispatchMessage);
begin
  RecreateWnd;
end;

procedure TWinNativeMemo.MMGetCaretPosition(var AMessage: TDispatchMessageWithValue<TCaretPosition>);
var
  Value: Integer;
begin
  SendMessage(Handle, EM_GETSEL, WPARAM(@Value), 0);
  AMessage.Value := Model.TextPosToPos(Value);
end;

procedure TWinNativeMemo.MMHideSelectionOnExitChanged(var Message: TDispatchMessage);
begin
  RecreateWnd;
end;

procedure TWinNativeMemo.MMLinesChanged(var Message: TDispatchMessage);
begin
  CopyModelToNative;
end;

procedure TWinNativeMemo.MMLinesClear(var Message: TDispatchMessage);
begin
  CopyModelToNative;
end;

procedure TWinNativeMemo.MMLinesDeleteLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>);
var
  SelStart, SelEnd: Integer;
begin
  SelStart := SendMessage(Handle, EM_LINEINDEX, Message.Value.Index, 0);
  if SelStart >= 0 then
  begin
    SelEnd := SendMessage(Handle, EM_LINEINDEX, Message.Value.Index + 1, 0);
    if SelEnd < 0 then
      SelEnd := SelStart + SendMessage(Handle, EM_LINELENGTH, SelStart, 0);
    SendMessage(Handle, EM_SETSEL, SelStart, SelEnd);
    SendTextMessage(Handle, EM_REPLACESEL, 0, '');
  end;
end;

procedure TWinNativeMemo.MMLinesExchangeLines(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>);
begin
  CopyModelToNative;
end;

procedure TWinNativeMemo.MMLinesInsertLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>);
var
  SelStart, LineLen: Integer;
  Line: string;
begin
  if Message.Value.Index >= 0 then
  begin
    SelStart := SendMessage(Handle, EM_LINEINDEX, Message.Value.Index, 0);
    if SelStart >= 0 then
      Line := Message.Value.Text + #13#10
    else
    begin
      SelStart := SendMessage(Handle, EM_LINEINDEX, Message.Value.Index - 1, 0);
      if SelStart < 0 then Exit;
      LineLen := SendMessage(Handle, EM_LINELENGTH, SelStart, 0);
      if LineLen > 0 then
      begin
        Inc(SelStart, LineLen);
        Line := #13#10 + Message.Value.Text;
        if Message.Value.Text.IsEmpty then
          Line := Line + #13#10;
      end;
    end;
    if not Line.IsEmpty then
    begin
      SendMessage(Handle, EM_SETSEL, SelStart, SelStart);
      SendTextMessage(Handle, EM_REPLACESEL, 0, Line);
    end;
  end;
end;

procedure TWinNativeMemo.MMLinesPutLine(var Message: TDispatchMessageWithValue<TCustomMemoModel.TLineInfo>);
var
  SelStart: Integer;
begin
  SelStart := SendMessage(Handle, EM_LINEINDEX, Message.Value.Index, 0);
  if SelStart >= 0 then
  begin
    SendMessage(Handle, EM_SETSEL, SelStart, SelStart + SendMessage(Handle, EM_LINELENGTH, SelStart, 0));
    SendTextMessage(Handle, EM_REPLACESEL, 0, Message.Value.Text);
  end;
end;

procedure TWinNativeMemo.MMMaxLengthChanged(var AMessage: TDispatchMessage);
begin
  SetMaxLength;
end;

procedure TWinNativeMemo.MMReadOnly(var AMessage: TDispatchMessage);
begin
  SetReadOnly;
end;

procedure TWinNativeMemo.MMScrollDirectionChanged(var AMessage: TDispatchMessageWithValue<TScrollDirections>);
begin
  UpdateScrollBarsVisibility;
end;

procedure TWinNativeMemo.MMSetCaretPosition(var AMessage: TDispatchMessageWithValue<TCaretPosition>);
var
  Value: Integer;
begin
  Value := Model.PosToTextPos(AMessage.Value);
  SendMessage(Handle, EM_SETSEL, Value, Value);
end;

procedure TWinNativeMemo.MMShowScrollBarChanged(var Message: TDispatchMessage);
begin
  UpdateScrollBarsVisibility;
end;

procedure TWinNativeMemo.MMTextSettingsChanged(var AMessage: TDispatchMessage);
begin
  UpdateTextSettings;
end;

procedure TWinNativeMemo.PMDoEnter(var AMessage: TDispatchMessage);
begin
  if Model.AutoSelect then
    TCustomMemo(Control).SelectAll;
  inherited;
end;

procedure TWinNativeMemo.SetMaxLength;
begin
  SendMessage(Handle, EM_LIMITTEXT, Model.MaxLength, 0);
end;

procedure TWinNativeMemo.SetReadOnly;
begin
  SendMessage(Handle, EM_SETREADONLY, Integer(Model.ReadOnly), 0);
end;

procedure TWinNativeMemo.SetSelLength;
begin
  SendMessage(Handle, EM_SETSEL, Model.SelStart, Model.SelStart + Model.SelLength);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TWinNativeMemo.SetSelStart;
begin
  SendMessage(Handle, EM_SETSEL, Model.SelStart, Model.SelStart);
end;

procedure TWinNativeMemo.UpdateScrollBarsVisibility;
var
  HorzVisible, VertVisible: Boolean;
  WindowStyle: NativeInt;
begin
  HorzVisible := (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Horizontal])
    and Model.ShowScrollBars;
  VertVisible := (Model.ScrollDirections in [TScrollDirections.Both, TScrollDirections.Vertical])
    and Model.ShowScrollBars;
  WindowStyle := GetWindowLong(Handle, GWL_STYLE);
  if (WindowStyle and WS_VSCROLL <> 0) <> VertVisible then
    ShowScrollBar(Handle, SB_VERT, VertVisible);
  if (WindowStyle and WS_HSCROLL <> 0) <> HorzVisible then
    ShowScrollBar(Handle, SB_HORZ, HorzVisible);
end;

procedure TWinNativeMemo.CopyModelToNative;
begin
  SetWindowText(Handle, PChar(Model.Lines.Text));
end;

procedure TWinNativeMemo.CopyNativeToModel;
var
  WindowsText: string;
begin
  if SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0 then
  begin
    WindowsText := GetHWNDText(Handle);
    if Model.Lines.Text <> WindowsText then
    begin
      Model.DisableNotify;
      try
        Model.SelLength := 0;
        Model.Lines.Text := WindowsText;
      finally
        Model.EnableNotify;
      end;
    end;
  end;
end;

procedure TWinNativeMemo.UpdateTextSettings;
var
  TextSettings: TTextSettings;
  FontHandle: HFONT;
begin
  TextSettings := Model.TextSettingsInfo.ResultingTextSettings;
  FontHandle := CreateFont(- Round(TextSettings.Font.Size * Scale), 0, 0, 0,
    FontWeightToWinapi(TextSettings.Font.StyleExt.Weight),
    DWORD(not TextSettings.Font.StyleExt.Slant.IsRegular),
    DWORD(TFontStyle.fsUnderline in TextSettings.Font.StyleExt.SimpleStyle),
    DWORD(TFontStyle.fsStrikeOut in TextSettings.Font.StyleExt.SimpleStyle), 0, 0, 0, 0, 0, PChar(TextSettings.Font.Family));
  SendMessage(Handle, WM_SETFONT, FontHandle, 1);
end;

procedure TWinNativeMemo.WMChar(var Message: TWMChar);
var
  KeyChar: Char;
begin
  inherited;
  CopyNativeToModel;
  KeyChar := Char(Message.CharCode);
  case KeyChar of
    ^A:
      if Model.Lines.Count > 0 then
      begin
        Model.DisableNotify;
        try
          Model.SelStart := 0;
          Model.SelLength := Model.PosToTextPos(
            TCaretPosition.Create(Model.Lines.Count, Model.Lines[Model.Lines.Count - 1].Length));
        finally
          Model.EnableNotify;
        end;
        SetSelLength;
      end;
    #13:
      Model.Change;
  end;
end;

procedure TWinNativeMemo.WMKeyDown(var Message: TWMKeyDown);
var
  Msg: TMsg;
begin
  if Message.CharCode = VK_TAB then
    PeekMessage(Msg, Handle, 0, 0, PM_REMOVE);
  inherited;
  if Message.CharCode = VK_DELETE then
    CopyNativeToModel;
end;

procedure TWinNativeMemo.WMKillFocus(var Message: TWMKillFocus);
begin
  if HandleAllocated then
    TImeModeHelper.ResetIme(Handle, Model.ImeMode);
  Model.Change;
  inherited;
end;

procedure TWinNativeMemo.WMSetFocus(var Message: TWMSetFocus);
begin
  TImeModeHelper.SetIme(Handle, Model.ImeMode);
  inherited;
  SetSelLength;
end;

initialization
  TPresentationProxyFactory.Current.Register(TMemo, TControlType.Platform, TWinPresentationProxy<TWinNativeMemo>);
finalization
  TPresentationProxyFactory.Current.Unregister(TMemo, TControlType.Platform, TWinPresentationProxy<TWinNativeMemo>);
end.
