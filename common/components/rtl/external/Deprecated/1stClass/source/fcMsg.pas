unit fcmsg;
{
//
// Components : TfcCaptureMessageClass
//
// Copyright (c) 1999 by Woll2Woll Software
}
{$T-}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus;

type
  TfcWndProcEvent = procedure(var Message: TMessage) of object;
  TfcBeforeWndProcEvent = procedure(var Message: TMessage; var ProcessMessage: boolean) of object;

  TfcCaptureMessageClass = class(TComponent)
  private
    FOnWndProc: TfcWndProcEvent;
    FOnBeforeWndProc: TfcBeforeWndProcEvent;
    FEnabled: Boolean;
    FWndHandle: HWnd;
    FWndHandlerPtr: Pointer;
    FOldWndHandler: Pointer;  {Restore to this when this component is destroyed }
    FWinControl: TWinControl;

    procedure SetWndHandle(Value: Hwnd);
    procedure SetWndControl(Value: TWinControl);
    procedure SetEnabled(newValue: Boolean);
    procedure StartSubClass;
    procedure EndSubClass;
  protected
    procedure WndProc(var Message: TMessage); virtual;
    procedure Refresh; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NewWndProc(var Message: TMessage);
    property WindowHandle: HWnd read FWndHandle write SetWndHandle;
    property WinControl: TWinControl read FWinControl write SetWndControl;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property OnWndProc: TfcWndProcEvent read FOnWndProc write FOnWndProc;
    property OnBeforeWndProc: TfcBeforeWndProcEvent read FOnBeforeWndProc write FOnBeforeWndProc;
  end;

implementation

procedure TfcCaptureMessageClass.Refresh;
begin
end;  { Refresh }

constructor TfcCaptureMessageClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldWndHandler := nil;
  FWndHandlerPtr := nil;
  FWinControl := nil;
  FWndHandle := 0;
  FEnabled := false;
end;

destructor TfcCaptureMessageClass.Destroy;
begin
  Enabled := False;
  inherited Destroy;
end;

procedure TfcCaptureMessageClass.NewWndProc(var Message: TMessage);
begin
  WndProc(Message);
end;

procedure TfcCaptureMessageClass.WndProc(var Message: TMessage);
var ProcessMessage: boolean;
begin
  ProcessMessage:= True;
  if Assigned(FOnBeforeWndProc) then FOnBeforeWndProc(Message, ProcessMessage);
  if ProcessMessage=False then begin
//     DefaultHandler(Message);
     exit;  { Paul say call default handler }
  end;
  with Message do
  begin
    result := CallWindowProc(FOldWndHandler, FWndHandle, Msg, wParam, lParam);
  end;
  if Assigned(FOnWndProc) then FOnWndProc(Message);
end;

procedure TfcCaptureMessageClass.StartSubClass;
begin
  if IsWindow(FWndHandle) then
  begin
    FOldWndHandler := Pointer(GetWindowLong(FWndHandle,	GWL_WNDPROC));
    FWndHandlerPtr := MakeObjectInstance(NewWndProc);
    if FWndHandlerPtr = nil then
      raise EOutOfResources.Create('Windows Resources Exhausted');
    SetWindowLong(FWndHandle, GWL_WNDPROC, LongInt(FWndHandlerPtr));
    FEnabled := true;
  end
end;

procedure TfcCaptureMessageClass.EndSubClass;
begin
  if IsWindow(FWndHandle) then
  begin
    SetWindowLong(FWndHandle, GWL_WNDPROC, LongInt(FOldWndHandler));
      FOldWndHandler := nil;
  end;
  if FWndHandlerPtr <> nil then
    FreeObjectInstance(FWndHandlerPtr);
      FEnabled := false;
end;

procedure TfcCaptureMessageClass.SetWndControl(Value: TWinControl);
begin
  if Value <> FWinControl then
  if Value is TWinControl then
  begin
    FWinControl := Value;
    WindowHandle := FWinControl.Handle;
  end;
end;

procedure TfcCaptureMessageClass.SetWndHandle(Value: Hwnd);
begin
  if FWndHandle <> 0 then EndSubClass;
  FWndHandle := Value;
  if (FWndHandle <> 0) and FEnabled then StartSubClass;
end;

procedure TfcCaptureMessageClass.SetEnabled(newValue: Boolean);
begin
  if FEnabled <> newValue then
  begin
    FEnabled := newValue;
    if Enabled then StartSubClass
    else EndSubClass;
  end;
end;

end.
