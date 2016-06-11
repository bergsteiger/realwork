{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Win;

interface

{$SCOPEDENUMS ON}

uses
  Winapi.Messages, Winapi.Windows, System.Classes, FMX.Forms, FMX.Controls, FMX.Types;

type
  /// <summary>
  ///   Encapsulates the information needed when creating a control
  /// </summary>
  TCreateParams = record
    Caption: PChar;
    Style: DWORD;
    ExStyle: DWORD;
    X, Y: Integer;
    Width, Height: Integer;
    WndParent: HWND;
    Param: Pointer;
    WindowClass: TWndClass;
    WinClassName: array [0 .. 63] of Char;
  end;

  { TWinControl }
  /// <summary>
  ///  Wrapper for FMX.Controls.TControl for using native controls
  /// </summary>
  TWinControl = class(TControl)
  private
    FWindowProc: TWndMethod;
  private
    FParentWindow: HWND;
    FWinControls: TList;
    FDefWndProc: Pointer;
    FHandle: HWND;
    FObjectInstance: Pointer;
    function PrecedingWindow(const Control: TWinControl): HWND;
    procedure SetParentWindow(const Value: HWND);
    procedure UpdateShowing;
  protected
    /// <summary>
    ///   Return HWND handle to the component
    /// </summary>
    function GetHandle: HWND; virtual;
    /// <summary>
    ///   Set the FMX parent to the component
    /// </summary>
    procedure SetParent(const AParent: TFmxObject); reintroduce; virtual;
    /// <summary>
    ///   Return the parent
    /// </summary>
    function GetParent: TFmxObject; virtual;
    /// <summary>
    ///   WndProc procedure for this control
    /// </summary>
    procedure WndProc(var Message: TMessage); virtual;
    /// <summary>
    ///  Create native WindowHandle for control
    /// </summary>
    procedure CreateHandle; virtual;
    /// <summary>
    ///   Fill the structure using default parameters
    /// </summary>
    procedure CreateParams(var Params: TCreateParams); virtual;
    /// <summary>
    ///   Abstract method that would be call in CreateHandle method
    /// </summary>
    procedure CreateWnd; virtual; abstract;
    /// <summary>
    ///   Destroy the handle and all child handles if it exist
    /// </summary>
    procedure DestroyHandle; virtual;
    /// <summary>
    ///   Call Win API method for destroing handle from window
    /// </summary>
    procedure DestroyWindowHandle; virtual;
    /// <summary>
    ///   Return parents handle if exist. In other case return components handle
    /// </summary>
    function GetTopParentHandle: HWND;
    /// <summary>
    ///   Procedure for calling MakeObjectInstance
    /// </summary>
    procedure MainWndProc(var Message: TMessage);
    /// <summary>
    ///   Pointer to default WndProc
    /// </summary>
    property DefWndProc: Pointer read FDefWndProc write FDefWndProc;
    /// <summary>
    ///   Property for providing acceess to FHandle field
    /// </summary>
    property WindowHandle: HWND read FHandle write FHandle;
    /// <summary>
    ///   Method for sync Bounds between FMX and native control.
    /// </summary>
    procedure DoMatrixChanged(Sender: TObject); override;
    /// <summary>
    ///   Method for process of MouseActivate message
    /// </summary>
    procedure DoMouseActivate; virtual;
    /// <summary>
    ///   method for getting decision about focus setting
    /// </summary>
    procedure DoSetFocus; virtual;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor CreateParented(ParentWindow: HWND);
    class function CreateParentedControl(ParentWindow: HWND): TWinControl;
    destructor Destroy; override;
    function HandleAllocated: Boolean;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); reintroduce; virtual;
    procedure UpdateControlState;
    property Handle: HWND read GetHandle;
    property ParentWindow: HWND read FParentWindow write SetParentWindow;
    /// <summary>
    ///   Call Win API method update
    /// </summary>
    procedure Update; virtual;
    property WindowProc: TWndMethod read FWindowProc write FWindowProc;
    property Parent: TFmxObject read GetParent write SetParent;
  end;

function InitWndProc(HWindow: HWND; Msg: UINT; WParam: WParam; LParam: LParam): LRESULT; stdcall;

var
  CreationControl: TWinControl = nil;

implementation

uses
  Winapi.CommCtrl, System.Types, System.SysUtils, FMX.Platform.Win, FMX.Styles, FMX.Platform;

{$R *.res}

{ Initialization window procedure }

function InitWndProc(HWindow: HWND; Msg: UINT; WParam: WParam; LParam: LParam): LRESULT;
{$IFDEF WIN64}
type
  TThunkProc = function(HWindow: HWND; Message: Longint; WParam: Winapi.Windows.WParam; LParam: Winapi.Windows.LParam):
    LRESULT; stdcall;
var
  WinControl: TWinControl;
{$ENDIF}
begin
  CreationControl.FHandle := HWindow;
  if IsWindowUnicode(HWindow) then
  begin
    SetWindowLongW(HWindow, GWL_WNDPROC, IntPtr(CreationControl.FObjectInstance));
    if (GetWindowLongW(HWindow, GWL_STYLE) and WS_CHILD <> 0) and (GetWindowLongW(HWindow, GWL_ID) = 0) then
      SetWindowLongW(HWindow, GWL_ID, HWindow);
  end
  else
  begin
    SetWindowLongA(HWindow, GWL_WNDPROC, IntPtr(CreationControl.FObjectInstance));
    if (GetWindowLongA(HWindow, GWL_STYLE) and WS_CHILD <> 0) and (GetWindowLongA(HWindow, GWL_ID) = 0) then
      SetWindowLongA(HWindow, GWL_ID, HWindow);
  end;
{$IFDEF WIN32}
  asm
    PUSH    LParam
    PUSH    WParam
    PUSH    Msg
    PUSH    HWindow
    MOV     EAX,CreationControl
    MOV     CreationControl,0
    CALL    [EAX].TWinControl.FObjectInstance
    MOV     Result,EAX
  end;
{$ENDIF}
{$IFDEF WIN64}
  WinControl := CreationControl;
  CreationControl := nil;
  Result := TThunkProc(WinControl.FObjectInstance)(HWindow, Msg, WParam, LParam);
{$ENDIF}
end;

{ TWinControl }

function TWinControl.GetParent: TFmxObject;
begin
  Result := TWinControl(FParent);
end;

procedure TWinControl.SetParent(const AParent: TFmxObject);
var
  LForm: TCustomForm;
  LComponent: TComponent;
begin
  LForm := nil;
  if AParent is TCustomForm then
    LForm := TCustomForm(AParent)
  else
  begin
    if (AParent <> nil) and (AParent.Root <> nil) then
    begin
      LComponent := AParent.Root.GetObject;
      if LComponent is TCustomForm then
        LForm := TCustomForm(LComponent);
    end;
  end;
  if LForm <> nil then
    Self.ParentWindow := WindowHandleToPlatform(LForm.Handle).Wnd;
end;

procedure TWinControl.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_MOUSEACTIVATE then
    DoMouseActivate;
  Dispatch(Message);
end;

constructor TWinControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FObjectInstance := MakeObjectInstance(MainWndProc);
  FWindowProc := WndProc;
end;

constructor TWinControl.CreateParented(ParentWindow: HWND);
begin
  FParentWindow := ParentWindow;
  Create(nil);
end;

class function TWinControl.CreateParentedControl(ParentWindow: HWND): TWinControl;
begin
  Result := TWinControl(NewInstance);
  Result.FParentWindow := ParentWindow;
  Result.Create(nil);
end;

destructor TWinControl.Destroy;
begin
  Destroying;
  if WindowHandle <> 0 then
    DestroyWindowHandle;
  if FObjectInstance <> nil then
    FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

{$IFDEF WIN64}
var
  UserLibrary: THandle;
{$ENDIF  }

procedure TWinControl.CreateParams(var Params: TCreateParams);
begin
  FillChar(Params, SizeOf(Params), 0);
  Params.Style := WS_CHILD or WS_CLIPSIBLINGS;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  Params.ExStyle := Params.ExStyle or WS_EX_CONTROLPARENT;
  if not(csDesigning in ComponentState) and not Enabled then
    Params.Style := Params.Style or WS_DISABLED;
  Params.X := Round(Position.X);
  Params.Y := Round(Position.Y);
  Params.Width := Round(Size.Width);
  Params.Height := Round(Size.Height);
  if Parent <> nil then
    Params.WndParent := TWinControl(Parent).GetHandle
  else
    Params.WndParent := FParentWindow;
  Params.WindowClass.Style := CS_VREDRAW + CS_HREDRAW + CS_DBLCLKS;
  Params.WindowClass.hCursor := LoadCursor(0, IDC_ARROW);
  Params.WindowClass.hbrBackground := 0;
  Params.WindowClass.hInstance := hInstance;
{$IFDEF WIN64}
  if UserLibrary = 0 then
    UserLibrary := LoadLibrary('User32.dll');
  Assert(UserLibrary <> 0, 'Unable to load User32.dll');
  Params.WindowClass.lpfnWndProc := GetProcAddress(UserLibrary, 'DefWindowProcW');
{$ELSE}
  Params.WindowClass.lpfnWndProc := @DefWindowProc;
{$ENDIF}
  StrPCopy(Params.WinClassName, ClassName);
end;

procedure TWinControl.DoMouseActivate;
begin
  DoSetFocus;
end;

procedure TWinControl.DoSetFocus;
begin
  SetFocus;
end;

procedure TWinControl.DoMatrixChanged(Sender: TObject);
begin
  inherited;
  SetBounds(Round(Position.Point.X), Round(Position.Point.Y), Round(Size.Width), Round(Size.Height));
end;

procedure TWinControl.DestroyWindowHandle;
begin
  try
    if not Winapi.Windows.DestroyWindow(WindowHandle) then
      RaiseLastOSError;
  finally
    WindowHandle := 0;
  end;
end;

function TWinControl.PrecedingWindow(const Control: TWinControl): HWND;
var
  I: Integer;
begin
  for I := FWinControls.IndexOf(Control) + 1 to FWinControls.Count - 1 do
  begin
    Result := TWinControl(FWinControls[I]).WindowHandle;
    if Result <> 0 then
      Exit;
  end;
  Result := HWND_TOP;
end;

procedure TWinControl.CreateHandle;
begin
  if WindowHandle = 0 then
  begin
    CreateWnd;
    if Parent <> nil then
      SetWindowPos(WindowHandle, TWinControl(Parent).PrecedingWindow(Self), 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE
        + SWP_NOACTIVATE);
  end;
end;

procedure TWinControl.DestroyHandle;
var
  I: Integer;
begin
  if WindowHandle <> 0 then
  begin
    if FWinControls <> nil then
      for I := 0 to FWinControls.Count - 1 do
        TWinControl(FWinControls[I]).DestroyHandle;
    DestroyWindowHandle;
  end;
end;

procedure TWinControl.UpdateShowing;
var
  ShowControl: Boolean;
  I: Integer;
  LShowing: Boolean;
const
  ShowFlags: array[Boolean] of Word = (
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_HIDEWINDOW,
    SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW);
begin
  ShowControl := True;
  if ShowControl then
  begin
    if WindowHandle = 0 then
      CreateHandle;
    if FWinControls <> nil then
      for I := 0 to FWinControls.Count - 1 do
        TWinControl(FWinControls[I]).UpdateShowing;
  end;
  if WindowHandle <> 0 then
    begin
      LShowing := ShowControl;
      SetWindowPos(WindowHandle, 0, 0, 0, 0, 0, ShowFlags[LShowing]);
    end;
end;

procedure TWinControl.UpdateControlState;
var
  Control: TWinControl;
begin
  Control := Self;
  while Control.Parent <> nil do
    Control := TWinControl(TWinControl(Control).Parent);
  if (not(csDestroying in ComponentState) and (Control.FParentWindow <> 0)) then
    UpdateShowing;
end;

procedure TWinControl.SetParentWindow(const Value: HWND);
begin
  if (FParent = nil) and (FParentWindow <> Value) then
  begin
    if (WindowHandle <> 0) and (FParentWindow <> 0) and (Value <> 0) then
    begin
      FParentWindow := Value;
      Winapi.Windows.SetParent(WindowHandle, Value);
      UpdateControlState;
    end
    else
    begin
      DestroyHandle;
      FParentWindow := Value;
      UpdateControlState;
    end;
  end;
end;

procedure TWinControl.MainWndProc(var Message: TMessage);
begin
  try
    WindowProc(Message);
  except
    Application.HandleException(Self);
  end;
end;

procedure TWinControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if HandleAllocated then
    SetWindowPos(WindowHandle, 0, ALeft, ATop, AWidth, AHeight, SWP_NOZORDER + SWP_NOACTIVATE);
end;

function TWinControl.GetTopParentHandle: HWND;
begin
  Result := Self.ParentWindow;
  if Result = 0 then
    Result := Self.Handle;
end;

procedure TWinControl.Update;
begin
  if HandleAllocated then
    UpdateWindow(WindowHandle);
end;

function TWinControl.GetHandle: HWND;
begin
  if WindowHandle = 0 then
    CreateHandle;
  Result := WindowHandle;
end;

function TWinControl.HandleAllocated: Boolean;
begin
  Result := WindowHandle <> 0;
end;

function WindowsStyleSelection(const APlatform: TOSPlatform): string;
begin
  if TOSVersion.Check(10) then
    Result := 'win10style'
  else if TOSVersion.Check(6, 2) then
    Result := 'win8style'
  else
    Result := 'win7style';
end;

type
  TWindowsHint = class(THint)
  private
    FWindowHandle: TWindowHandle;
    FNativeControlHandle: HWND;
    FToolTipHandle: HWND;
    FHintString: string;
  protected
    procedure SetEnabled(const Value: Boolean); override;
  public
    constructor Create(const AHandle: TWindowHandle); override;
    destructor Destroy; override;
    procedure SetPosition(const X, Y: Single); override;
    procedure SetHint(const AString: string); override;
  end;

{ TWindowsHint }

constructor TWindowsHint.Create(const AHandle: TWindowHandle);
var
  LToolInfo: TOOLINFO;
begin
  inherited;
  FWindowHandle := AHandle;
  FNativeControlHandle := WindowHandleToPlatform(AHandle).Wnd;
  if FNativeControlHandle <> 0 then
  begin
    FToolTipHandle := CreateWindowEx(0, TOOLTIPS_CLASS, nil, WS_POPUP or TTS_ALWAYSTIP, 0, 0, 300, 300,
      FNativeControlHandle, 0, hInstance, nil);

    SetWindowPos(FToolTipHandle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);

    FillChar(LToolInfo, SizeOf(TOOLINFO), 0);
    LToolInfo.cbSize := SizeOf(TOOLINFO);
    LToolInfo.uFlags := TTF_SUBCLASS or TTF_IDISHWND or TTF_PARSELINKS;
    LToolInfo.hinst := hInstance;
    LToolInfo.hwnd := FNativeControlHandle;
    LToolInfo.uId := FNativeControlHandle;
    LToolInfo.lpszText := nil;

    SendMessage(FToolTipHandle, TTM_ADDTOOL, 0, LPARAM(@LToolInfo));
    SendMessage(FToolTipHandle, TTM_ACTIVATE, NativeInt(False), LPARAM(@LToolInfo));
  end;
end;

destructor TWindowsHint.Destroy;
begin
  if FToolTipHandle <> 0 then
    DestroyWindow(FToolTipHandle);
  inherited;
end;

procedure TWindowsHint.SetEnabled(const Value: Boolean);
var
  LToolInfo: TOOLINFO;
begin
  if Value <> FEnabled then
  begin
    inherited;

    FillChar(LToolInfo, SizeOf(TOOLINFO), 0);
    LToolInfo.cbSize := SizeOf(TOOLINFO);
    LToolInfo.uFlags := TTF_SUBCLASS or TTF_IDISHWND;
    LToolInfo.hinst := hInstance;
    LToolInfo.hwnd := FNativeControlHandle;
    LToolInfo.uId := FNativeControlHandle;

    if Value then
      SendMessage(FToolTipHandle, TTM_ACTIVATE, NativeInt(TRUE), LPARAM(@LToolInfo))
    else
      SendMessage(FToolTipHandle, TTM_ACTIVATE, NativeInt(FALSE), LPARAM(@LToolInfo));
  end;
end;

procedure TWindowsHint.SetHint(const AString: string);
const
  DefaultMaxWidth = 640;
var
  LToolInfo: TOOLINFO;
  LShortText: string;
  DisplaySvc: IFMXMultiDisplayService;
  MaxTooltipWidth: Integer;
begin
  if GetHint <> AString then
  begin
    inherited;
    LShortText := GetShortText;
    if LShortText <> FHintString then
    begin
      FHintString := LShortText;
      FillChar(LToolInfo, SizeOf(TOOLINFO), 0);
      LToolInfo.cbSize := SizeOf(TOOLINFO);
      LToolInfo.uFlags := TTF_SUBCLASS or TTF_IDISHWND or TTF_PARSELINKS;
      LToolInfo.hinst := hInstance;
      LToolInfo.hwnd := FNativeControlHandle;
      LToolInfo.uId := FNativeControlHandle;
      LToolInfo.lpszText := PWideChar(FHintString);
      if TPlatformServices.Current.SupportsPlatformService(IFMXMultiDisplayService, DisplaySvc) then
        try
          MaxTooltipWidth := DisplaySvc.DisplayFromWindow(FWindowHandle).Bounds.Width;
        except
          MaxTooltipWidth := DefaultMaxWidth;
        end
      else
        MaxTooltipWidth := DefaultMaxWidth;
      SendMessage(FToolTipHandle, TTM_SETMAXTIPWIDTH, 0, MaxTooltipWidth);
      SendMessage(FToolTipHandle, TTM_UPDATETIPTEXT, 0, LPARAM(@LToolInfo))
    end;
  end
  else
    inherited;
end;

procedure TWindowsHint.SetPosition(const X, Y: Single);
begin
  inherited;

end;

initialization
  THint.RegisterClass(TWindowsHint);
  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.Windows, 'win7style');
  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.Windows, 'win8style');
  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.Windows, 'win10style');
  TStyleManager.RegisterPlatformStyleSelection(TOSPlatform.Windows, WindowsStyleSelection);
end.
