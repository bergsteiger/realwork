{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.VirtualKeyboard.Android;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.TypInfo, System.Generics.Collections, System.UITypes, System.Types,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Embarcadero,
  FMX.Types, FMX.Helpers.Android, FMX.VirtualKeyboard, Androidapi.JNI.App, Androidapi.JNIBridge,
  System.SyncObjs, Androidapi.JNI.JavaTypes;

type
  TVirtualKeyboardAndroid = class;

  TVKListener = class(TJavaLocal, JVKStateChangeListener)
  private
    FKeyboardService: TVirtualKeyboardAndroid;
    FEvent: TEvent;
    function ObtainKeyboardRect: TRect;
  public
    constructor Create(Svc: TVirtualKeyboardAndroid);
    procedure ResetEvent;
    procedure WaitEvent;
    procedure onVirtualKeyboardShown; cdecl;
    procedure onVirtualKeyboardHidden; cdecl;
  end;


  TVirtualKeyboardAndroid = class(TInterfacedObject, IFMXVirtualKeyboardService)
  private type
    TvkbState = (Hidden, Shown);
  private
    FError: Boolean;
    FState: TvkbState;
    FVKListener: TVKListener;
    FTransient: Boolean;
    function IsAutoShow: Boolean;
    procedure SetState(Value: TvkbState);
    procedure RegisterListener;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXVirtualKeyboardService }
    function ShowVirtualKeyboard(const AControl: TFmxObject): Boolean;
    function HideVirtualKeyboard: Boolean;
    function GetVirtualKeyboardState: TVirtualKeyboardStates;
    procedure SetTransientState(Value: Boolean);
    property VirtualKeyboardState: TVirtualKeyboardStates read GetVirtualKeyboardState;
  end;

implementation

uses
  System.Messaging, FMX.Forms, FMX.Platform.Android, FMX.Platform;

{ TAndroidVirtualKeyboardService }

constructor TVirtualKeyboardAndroid.Create;
begin
  inherited Create;
end;

destructor TVirtualKeyboardAndroid.Destroy;
begin
  inherited;
end;

function TVirtualKeyboardAndroid.IsAutoShow: Boolean;
begin
  Result := VKAutoShowMode in [TVKAutoShowMode.Always, TVKAutoShowMode.DefinedBySystem];
end;

procedure TVirtualKeyboardAndroid.RegisterListener;
begin
  if FVKListener = nil then
  begin
    FVKListener := TVKListener.Create(Self);
    MainActivity.getTextEditorProxy.addOnVKStateChangeListener(FVKListener);
  end;
end;

function TVirtualKeyboardAndroid.GetVirtualKeyboardState: TVirtualKeyboardStates;
begin
  if FError then
    Result := [TVirtualKeyboardState.Error]
  else
    Result := [];
  if IsAutoShow then
    Result := Result + [TVirtualKeyboardState.AutoShow];
  if FTransient then
    Result := Result + [TVirtualKeyboardState.Transient];
  if not FError then
  begin
    if FState = TvkbState.Shown then
      Result := Result + [TVirtualKeyboardState.Visible];
  end;
end;

function TVirtualKeyboardAndroid.HideVirtualKeyboard: Boolean;
var
  TextView: JFMXTextEditorProxy;
begin
  Result := False;
  try
    if not FTransient then
    begin
      RegisterListener;
      TextView := MainActivity.getTextEditorProxy;
      FVKListener.ResetEvent;
      CallInUIThread(
        procedure
        begin
          TextView.setFocusable(false);
          TextView.setFocusableInTouchMode(false);
          TextView.showSoftInput(false);
          TextView.clearFocus;
        end);
      FVKListener.WaitEvent;
      Result := FState = TvkbState.Hidden;
    end
  except
    Application.HandleException(Screen.ActiveForm);
  end;
end;

function TVirtualKeyboardAndroid.ShowVirtualKeyboard(const AControl: TFmxObject): Boolean;
var
  TextView: JFMXTextEditorProxy;
begin
  RegisterListener;
  TextView := MainActivity.getTextEditorProxy;
  FVKListener.ResetEvent;
  CallInUIThread(
    procedure
    begin
      TextView.setFocusable(true);
      TextView.setFocusableInTouchMode(true);
      TextView.requestFocus;
      TextView.showSoftInput(true);
    end);
  FVKListener.WaitEvent;
  Result := FState = TvkbState.Shown;
end;

procedure TVirtualKeyboardAndroid.SetState(Value: TvkbState);
const
  StateStr: array [TvkbState] of String = ('Hidden', 'Shown');
begin
  FState := Value;
end;

procedure TVirtualKeyboardAndroid.SetTransientState(Value: Boolean);
begin
  FTransient := Value;
end;

{ TVKListener }

constructor TVKListener.Create(Svc: TVirtualKeyboardAndroid);
begin
  inherited Create;
  FKeyboardService := Svc;
  FEvent := TEvent.Create;
end;

procedure TVKListener.ResetEvent;
begin
  FEvent.ResetEvent;
end;

procedure TVKListener.WaitEvent;
begin
  FEvent.WaitFor(250);
end;

procedure TVKListener.onVirtualKeyboardShown;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      FKeyboardService.SetState(TVirtualKeyboardAndroid.TvkbState.Shown);
      TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(true, ObtainKeyboardRect), True);
    end);
  FEvent.SetEvent;
end;

procedure TVKListener.onVirtualKeyboardHidden;
begin
  TThread.Synchronize(nil,
    procedure
    begin
      FKeyboardService.SetState(TVirtualKeyboardAndroid.TvkbState.Hidden);
      TMessageManager.DefaultManager.SendMessage(Self, TVKStateChangeMessage.Create(false, ObtainKeyboardRect), True);
    end);
  FEvent.SetEvent;
end;

function TVKListener.ObtainKeyboardRect: TRect;
var
  ContentRect, TotalRect: JRect;
begin
  ContentRect := TJRect.Create;
  TotalRect := TJRect.Create;
  MainActivity.getWindow.getDecorView.getWindowVisibleDisplayFrame(ContentRect);
  MainActivity.getWindow.getDecorView.getDrawingRect(TotalRect);
  Result := TRectF.Create(ConvertPixelToPoint(TPointF.Create(TotalRect.left, TotalRect.top + ContentRect.height)),
    ConvertPixelToPoint(TPointF.Create(TotalRect.right, TotalRect.bottom))).Truncate;
end;


end.

