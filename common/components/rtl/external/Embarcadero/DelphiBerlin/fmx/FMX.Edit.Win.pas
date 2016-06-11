{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Edit.Win;

interface

{$SCOPEDENUMS ON}

uses
  System.TypInfo, System.Types, System.Classes, Winapi.Messages, FMX.Types, FMX.Controls, FMX.Controls.Presentation,
  FMX.Edit, FMX.Presentation.Messages, FMX.Presentation.Win, FMX.Controls.Model, FMX.Controls.Win;

type
  TWinNativeEdit = class(TWinPresentation)
  private
    FModel: TCustomEditModel;
    function GetEdit: TCustomEdit;
    procedure UpdateTextSettings;
    procedure CopyModelToNative;
    procedure CopyNativeToModel;
    procedure SetPasswordChar;
    procedure SetReadOnly;
    procedure SetMaxLength;
    procedure SetPromptText;
    procedure SetSelStart;
    procedure SetSelLength;
    { Messages From Model}
    procedure MMSelLengthChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_EDIT_SELLENGTH_CHANGED;
    procedure MMSelStartChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_EDIT_SELSTART_CHANGED;
    procedure MMPasswordChanged(var Message: TDispatchMessage); message MM_EDIT_ISPASSWORD_CHANGED;
    procedure MMTextSettingsChanged(var Message: TDispatchMessage); message MM_EDIT_TEXT_SETTINGS_CHANGED;
    procedure MMTextChanged(var Message: TDispatchMessage); message MM_EDIT_TEXT_CHANGED;
    procedure MMReadOnly(var Message: TDispatchMessage); message MM_EDIT_READONLY_CHANGED;
    procedure MMPromptTextChanged(var Message: TDispatchMessageWithValue<string>); message MM_EDIT_PROMPTTEXT_CHANGED;
    procedure MMMaxLengthChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_EDIT_MAXLENGTH_CHANGED;
    procedure MMCaretPositionChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_EDIT_CARETPOSITION_CHANGED;
    { Windows messages }
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMChar(var Message: TWMKey); message WM_CHAR;
  protected
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function DefineModelClass: TDataModelClass; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Edit: TCustomEdit read GetEdit;
    property Model: TCustomEditModel read FModel;
  end;

implementation

uses
  System.UITypes, System.SysUtils, System.Math, Winapi.Windows, Winapi.CommCtrl, FMX.Consts, FMX.Graphics,
  FMX.Presentation.Factory, FMX.Helpers.Win;

{ TWinNativeEdit }

resourcestring
  sInvalidComCtl32 = 'This control requires version 4.70 or greater of COMCTL32.DLL';

function InitCommonControl(CC: Integer): Boolean;
var
  ICC: TInitCommonControlsEx;
begin
  ICC.dwSize := SizeOf(TInitCommonControlsEx);
  ICC.dwICC := CC;
  Result := InitCommonControlsEx(ICC);
  if not Result then InitCommonControls;
end;

procedure CheckCommonControl(CC: Integer);
begin
  if not InitCommonControl(CC) then
    raise EComponentError.CreateRes(@SInvalidComCtl32);
end;

constructor TWinNativeEdit.Create(AOwner: TComponent);
begin
  CheckCommonControl(ICC_STANDARD_CLASSES);
  inherited;
  FModel := TCustomEditModel(inherited Model);
end;

procedure TWinNativeEdit.CreateHandle;
begin
  inherited;
  if Handle <> NullHWnd then
  begin
    SetMaxLength;
    SetPasswordChar;
    SetSelStart;
    SetSelLength;
    UpdateTextSettings;
    CopyModelToNative;
    SetPromptText;
  end;
end;

procedure TWinNativeEdit.CreateParams(var Params: TCreateParams);
const
  EditClassName = 'EDIT'; // Do not localize
begin
  inherited;
  CreateSubClass(Params, EditClassName);
  with Params do
  begin
    Style := Style or ES_AUTOHSCROLL or ES_AUTOVSCROLL;
    case Model.TextSettingsInfo.ResultingTextSettings.HorzAlign of
      TTextAlign.Center:
        Style := Style or ES_CENTER;
      TTextAlign.Leading:
        Style := Style or ES_LEFT;
      TTextAlign.Trailing:
        Style := Style or ES_RIGHT;
    end;
    if Model.Password then
      Style := Style or ES_PASSWORD;
    if Model.ReadOnly then
      Style := Style or ES_READONLY;
    Style := Style and not WS_BORDER;
    ExStyle := ExStyle or WS_EX_CLIENTEDGE;
  end;
end;

function TWinNativeEdit.DefineModelClass: TDataModelClass;
begin
  Result := TCustomEditModel;
end;

function TWinNativeEdit.GetEdit: TCustomEdit;
begin
  Result := Control as TCustomEdit
end;

procedure TWinNativeEdit.MMCaretPositionChanged(var Message: TDispatchMessageWithValue<Integer>);
begin
  SetSelStart;
end;

procedure TWinNativeEdit.MMMaxLengthChanged(var Message: TDispatchMessageWithValue<Integer>);
begin
  SetMaxLength;
end;

procedure TWinNativeEdit.MMPasswordChanged(var Message: TDispatchMessage);
begin
  SetPasswordChar;
end;

procedure TWinNativeEdit.MMPromptTextChanged(var Message: TDispatchMessageWithValue<string>);
begin
  SetPromptText;
end;

procedure TWinNativeEdit.MMReadOnly(var Message: TDispatchMessage);
begin
  SetReadOnly;
end;

procedure TWinNativeEdit.MMSelLengthChanged(var Message: TDispatchMessageWithValue<Integer>);
begin
  SetSelLength;
end;

procedure TWinNativeEdit.MMSelStartChanged(var Message: TDispatchMessageWithValue<Integer>);
begin
  SetSelStart;
end;

procedure TWinNativeEdit.MMTextChanged(var Message: TDispatchMessage);
begin
  CopyModelToNative;
end;

procedure TWinNativeEdit.MMTextSettingsChanged(var Message: TDispatchMessage);
begin
  UpdateTextSettings;
end;

procedure TWinNativeEdit.SetMaxLength;
begin
  SendMessage(Handle, EM_LIMITTEXT, Model.MaxLength, 0);
end;

procedure TWinNativeEdit.SetPasswordChar;
const
  PasswordChar = '*'; // Do not localize
begin
  if Model.Password then
    SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(PasswordChar), 0)
  else
    SendMessage(Handle, EM_SETPASSWORDCHAR, 0, 0);
end;

procedure TWinNativeEdit.SetPromptText;
begin
  if CheckWin32Version(5, 1) and HandleAllocated then
  begin
    if SendTextMessage(Handle, EM_SETCUEBANNER, WPARAM(1), Model.TextPrompt) = 0 then
      Log.d(SysErrorMessage(GetLastError));
  end;
end;

procedure TWinNativeEdit.SetReadOnly;
begin
  SendMessage(Handle, EM_SETREADONLY, Integer(Model.ReadOnly), 0);
end;

procedure TWinNativeEdit.SetSelLength;
begin
  SendMessage(Handle, EM_SETSEL, Model.SelStart, Model.SelStart + Model.SelLength);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TWinNativeEdit.SetSelStart;
begin
  SendMessage(Handle, EM_SETSEL, Model.SelStart, Model.SelStart);
end;

procedure TWinNativeEdit.CopyModelToNative;
begin
  SetWindowText(Handle, PChar(Model.Text));
end;

procedure TWinNativeEdit.CopyNativeToModel;
var
  WindowsText: string;
begin
  if SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0 then
  begin
    WindowsText := GetHWNDText(Handle);
    if WindowsText <> Model.Text then
    begin
      Model.DisableNotify;
      try
        Model.SelLength := 0;
        Model.Typing := True;
        Model.Text := WindowsText;
        Model.Typing := False;
      finally
        Model.EnableNotify;
      end;
      if Assigned(Model.OnTyping) then
        Model.OnTyping(Control);
    end;
  end;
end;

procedure TWinNativeEdit.UpdateTextSettings;
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

procedure TWinNativeEdit.WMKeyDown(var Message: TWMKeyDown);
var
  Msg: TMsg;
begin
  if Message.CharCode = VK_TAB then
    PeekMessage(Msg, Handle, 0, 0, PM_REMOVE)
  else if Message.CharCode = VK_RETURN then
    Model.Change;
  inherited;
  if Message.CharCode = VK_DELETE then
    CopyNativeToModel;
end;

procedure TWinNativeEdit.WMChar(var Message: TWMKey);
begin
  inherited;
  CopyNativeToModel;
end;

procedure TWinNativeEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  if HandleAllocated then
    TImeModeHelper.ResetIme(Handle, Model.ImeMode);
  Model.Change;
  inherited;
end;

procedure TWinNativeEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  TImeModeHelper.SetIme(Handle, Model.ImeMode);
  inherited;
end;

initialization
  TPresentationProxyFactory.Current.Register(TEdit, TControlType.Platform, TWinPresentationProxy<TWinNativeEdit>);
finalization
  TPresentationProxyFactory.Current.Unregister(TEdit, TControlType.Platform, TWinPresentationProxy<TWinNativeEdit>);
end.
