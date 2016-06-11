{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Ole;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, Winapi.Windows, System.Win.ComObj, System.Win.OleControls, FMX.Controls, Winapi.Messages,
  Fmx.Controls.Win;

type
  /// <summary>
  /// Based class for OLE control with supporting interface IOLEFrameworkDelegate for using OLE in FMX
  /// </summary>
  TOLEFrameworkDelegate = class(TWinControl, IOLEFrameworkDelegate)
  private
    FDispatcher: TEventDispatchInvoker;
    procedure SetDefWndProc(const AWndProc: Pointer);
    function GetDefWndProc: Pointer;
    function InitWindowProc: Pointer;
    procedure SetHandle(const AHandle: HWND);
    function GetParentHandle: THandle;
    function GetBoundsRect: TRect; reintroduce;
    procedure SetCreationControl;
    procedure SetDispatcher(const ADisp: TEventDispatchInvoker);
    function Disp(const DispId: Integer; const AParams: TOleVariantArray): TOleVariantArray;
    function GetWindowHandle: HWND;
    procedure SetWindowHandle(AValue: HWND);
  protected
    /// <summary>
    /// Getter for Visible property
    /// </summary>
    function GetVisible: Boolean;
    procedure SetVisible(const AVisible: Boolean); override;
    procedure CreateWnd; override;
    procedure DestroyHandle; override;
    procedure DestroyWindowHandle; override;
  end;

implementation

{ TOLEFrameworkDelegate }

uses
  System.Win.ComConst;

procedure TOLEFrameworkDelegate.CreateWnd;
var
  Params: TOleVariantArray;
begin
  inherited;
  Disp(Integer(TInvoke.CreateWnd), Params);
end;

procedure TOLEFrameworkDelegate.DestroyHandle;
begin
  inherited;
end;

procedure TOLEFrameworkDelegate.DestroyWindowHandle;
var
  Params: TOleVariantArray;
begin
  Params := Disp(Integer(TInvoke.DestroyWindowHandle), CreateOleVarArray([False]));
end;

function TOLEFrameworkDelegate.Disp(const DispId: Integer; const AParams: TOleVariantArray): TOleVariantArray;
begin
  if Assigned(FDispatcher) then
  begin
    Result := AParams;
    FDispatcher(DispId, Result);
  end;
end;

function TOLEFrameworkDelegate.GetBoundsRect: TRect;
begin
  Result := Self.BoundsRect.Round;
end;

function TOLEFrameworkDelegate.GetDefWndProc: Pointer;
begin
  Result := inherited DefWndProc;
end;

function TOLEFrameworkDelegate.GetParentHandle: THandle;
begin
  if Parent <> nil then
    Result := TWinControl(Parent).Handle
  else
    Result := ParentWindow;
end;

function TOLEFrameworkDelegate.GetVisible: Boolean;
begin
  Result := inherited Visible;
end;

function TOLEFrameworkDelegate.GetWindowHandle: HWND;
begin
  Result := WindowHandle;
end;

function TOLEFrameworkDelegate.InitWindowProc: Pointer;
begin
  Result := @InitWndProc;
end;

procedure TOLEFrameworkDelegate.SetCreationControl;
begin
  CreationControl := Self;
end;

procedure TOLEFrameworkDelegate.SetDefWndProc(const AWndProc: Pointer);
begin
  inherited DefWndProc := AWndProc;
end;

procedure TOLEFrameworkDelegate.SetDispatcher(const ADisp: TEventDispatchInvoker);
begin
  FDispatcher := ADisp;
end;

procedure TOLEFrameworkDelegate.SetHandle(const AHandle: HWND);
begin
  //
end;

procedure TOLEFrameworkDelegate.SetVisible(const AVisible: Boolean);
begin
  inherited Visible := AVisible;
end;

procedure TOLEFrameworkDelegate.SetWindowHandle(AValue: HWND);
begin
  WindowHandle := AValue;
end;

end.
