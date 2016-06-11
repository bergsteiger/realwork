{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ZOrder.Win;

interface

{$SCOPEDENUMS ON}

uses
  FMX.Controls, System.Generics.Collections, FMX.Forms, System.Types, Winapi.Windows;

type
  /// <summary>Helper class used to manage platform controls</summary>
  TWinZOrderManager = class
  private
    FLinks: TDictionary<TControl, HWND>;
    function FindControlForm(const AControl: TControl; out AForm: TCommonCustomForm): Boolean;
    function GetFormHandle(const AForm: TCommonCustomForm): HWND; inline;
  public
    destructor Destroy; override;
    /// <summary>Add or set new link of TControl and HWnd to manager</summary>
    procedure AddOrSetLink(const Control: TControl; const AWinHandle: HWND);
    /// <summary>Remove link of TControl and HWnd from manager</summary>
    procedure RemoveLink(const Control: TControl);

    /// <summary>Find first parented platform control</summary>
    function FindParentControl(const ForControl: TControl; out AControl: TControl): Boolean;
    /// <summary>Find first parented HWnd and return true if it exists</summary>
    function FindParentHWnd(const ForControl: TControl): Boolean; overload;
    /// <summary>Find first parented HWnd and return true if it exists</summary>
    function FindParentHWnd(const ForControl: TControl; out AWinHandle: HWND): Boolean; overload;
    /// <summary>Checks is control is a platform control</summary>
    function FindHWnd(const AControl: TControl; out AWinHandle: HWND): Boolean;
    /// <summary>Find first previous platform handle in same form's handle</summary>
    function FindPreviousSiblingHWnd(const AControl: TControl; out AWinHandle: HWND): Boolean;

    /// <summary>Convert absolute coordinates to parent window's platform coordinates</summary>
    function AbsoluteToParentHWnd(const AControl: TControl; const Bounds: TRectF): TRect;
    /// <summary>Fix z-order for platform control</summary>
    procedure UpdateOrder(const AControl: TControl; const WinHandle: HWND = 0);
    /// <summary>Update platform windows coordinates using control coordinates</summary>
    procedure UpdateBounds(const AControl: TControl; const WinHandle: HWND = 0);
    /// <summary>Call of FixOrder and FixBounds</summary>
    procedure UpdateOrderAndBounds(const AControl: TControl; const WinHandle: HWND = 0);
  end;

implementation

uses
  FMX.Platform.Win, FMX.Types, System.Math, FMX.Consts, System.Math.Vectors;

{ TWinZOrderManager }

function TWinZOrderManager.AbsoluteToParentHWnd(const AControl: TControl; const Bounds: TRectF): TRect;
var
  View: HWnd;
  Form: TCommonCustomForm;
begin
  if FindParentHWnd(AControl, View) and FindControlForm(AControl, Form) then
  begin
    Result := TRect.Create(Round(Bounds.Left * Form.Handle.Scale), Round(Bounds.Top * Form.Handle.Scale),
      Round(Bounds.Right * Form.Handle.Scale), Round(Bounds.Bottom * Form.Handle.Scale));

    ClientToScreen(WindowHandleToPlatform(Form.Handle).Wnd, Result.TopLeft);
    ClientToScreen(WindowHandleToPlatform(Form.Handle).Wnd, Result.BottomRight);
    ScreenToClient(View, Result.TopLeft);
    ScreenToClient(View, Result.BottomRight);
  end
  else
    Result := Bounds.Round;
end;

procedure TWinZOrderManager.AddOrSetLink(const Control: TControl; const AWinHandle: HWND);
var
  CurrentHWnd: HWND;
begin
  if FLinks = nil then
    FLinks := TDictionary<TControl, HWND>.Create;
  if not FLinks.ContainsKey(Control) then
    FLinks.Add(Control, AWinHandle)
  else if FLinks.TryGetValue(Control, CurrentHWnd) then
    if CurrentHWnd <> AWinHandle then
      FLinks.AddOrSetValue(Control, AWinHandle);
end;

destructor TWinZOrderManager.Destroy;
begin
  FLinks.Free;
  inherited;
end;

function TWinZOrderManager.FindControlForm(const AControl: TControl; out AForm: TCommonCustomForm): Boolean;
begin
  Result := AControl.Root is TCommonCustomForm;
  if Result then
    AForm := TCommonCustomForm(AControl.Root)
  else
    AForm := nil;
end;

function TWinZOrderManager.FindParentControl(const ForControl: TControl; out AControl: TControl): Boolean;
var
  ParentTmp: TControl;
  WinHandle: HWND;
begin
  AControl := nil;
  ParentTmp := ForControl.ParentControl;
  Result := False;
  while not Result and (ParentTmp <> nil) do
  begin
    if FindHWnd(ParentTmp, WinHandle) then
      Result := True
    else
      ParentTmp := ParentTmp.ParentControl;
  end;
  if Result then
    AControl := ParentTmp;
end;

function TWinZOrderManager.FindParentHWnd(const ForControl: TControl; out AWinHandle: HWND): Boolean;
var
  Form: TCommonCustomForm;
  ParentControl: TControl;
begin
  AWinHandle := 0;
  if FindParentControl(ForControl, ParentControl) then
    FindHWnd(ParentControl, AWinHandle);

  if (AWinHandle = 0) and FindControlForm(ForControl, Form) then
    AWinHandle := GetFormHandle(Form);

  Result := AWinHandle <> 0;
end;

function TWinZOrderManager.FindParentHWnd(const ForControl: TControl): Boolean;
var
  WinHandle: HWND;
begin
  Result := FindParentHWnd(ForControl, WinHandle);
end;

function TWinZOrderManager.FindPreviousSiblingHWnd(const AControl: TControl; out AWinHandle: HWND): Boolean;
var
  I: Integer;
  Parent: TFmxObject;
begin
  AWinHandle := 0;
  Parent := AControl.Parent;
  if Parent <> nil then
    for I := AControl.Index + 1 to Parent.ChildrenCount - 1 do
      if (Parent.Children[I] is TControl) and FindHWnd(TControl(Parent.Children[I]), AWinHandle) then
        Break;
  Result := AWinHandle <> 0;
end;

function TWinZOrderManager.FindHWnd(const AControl: TControl; out AWinHandle: HWND): Boolean;
begin
  AWinHandle := 0;
  if FLinks <> nil then
    Result := FLinks.TryGetValue(AControl, AWinHandle)
  else
    Result := False;
end;

function TWinZOrderManager.GetFormHandle(const AForm: TCommonCustomForm): HWND;
var
  FormHandle: TWinWindowHandle;
begin
  FormHandle := WindowHandleToPlatform(AForm.Handle);
  Result := FormHandle.Wnd;
end;

procedure TWinZOrderManager.RemoveLink(const Control: TControl);
begin
  if FLinks <> nil then
    FLinks.Remove(Control);
end;

procedure TWinZOrderManager.UpdateBounds(const AControl: TControl; const WinHandle: HWND);
var
  Bounds: TRectF;
  LWinHandle: HWND;
  WinBounds: TRect;
begin
  if WinHandle = 0 then
    FindHWnd(AControl, LWinHandle)
  else
  begin
    LWinHandle := WinHandle;
    AddOrSetLink(AControl, WinHandle);
  end;

  if LWinHandle <> 0 then
  begin
    Bounds := AControl.AbsoluteRect;
    WinBounds := AbsoluteToParentHWnd(AControl, Bounds);
    SetWindowPos(LWinHandle, 0, WinBounds.Left, WinBounds.Top, WinBounds.Width, WinBounds.Height, SWP_NOZORDER
      or SWP_NOACTIVATE);
  end;
end;

procedure TWinZOrderManager.UpdateOrder(const AControl: TControl; const WinHandle: HWND);
var
  PreviousWnd, LWinHandle, ParentWinHandle: HWND;
begin
  if WinHandle = 0 then
    FindHWnd(AControl, LWinHandle)
  else
  begin
    LWinHandle := WinHandle;
    AddOrSetLink(AControl, WinHandle);
  end;

  if (LWinHandle <> 0) and FindParentHWnd(AControl, ParentWinHandle) then
  begin
    if GetParent(LWinHandle) <> ParentWinHandle then
      SetParent(LWinHandle, ParentWinHandle);
    if FindPreviousSiblingHWnd(AControl, PreviousWnd) then
      SetWindowPos(LWinHandle, PreviousWnd, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE)
    else
      SetWindowPos(LWinHandle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TWinZOrderManager.UpdateOrderAndBounds(const AControl: TControl; const WinHandle: HWND);
begin
  UpdateOrder(AControl, WinHandle);
  UpdateBounds(AControl, WinHandle);
end;

end.
