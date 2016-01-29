{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1997 Paolo Giacomuzzi              }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

12/16/2000

  Improved auto-hiding of the auto-hide bars.

*)
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElAppBarForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, Dialogs, Controls, ExtCtrls,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ElAppBar,
  ShellApi,
  Menus;

type

  // TAppBar class ////////////////////////////////////////////////////////////
  TElAppBarForm = class(TForm)
  protected
    FAppBar : TElAppBar;
    function GetEdge: TAppBarEdge;
    procedure SetAlwaysOnTop(bAlwaysOnTop: Boolean);
    procedure SetAutoHide(bAutoHide: Boolean);
    procedure SetEdge(abEdge: TAppBarEdge);
    procedure SetFlags(newValue: TAppBarFlags);
    procedure SetKeepSize(newValue: Boolean);
    procedure SetPreventOffScreen(newValue: Boolean);
    function GetAlwaysOnTop: Boolean;
    function GetAutoHide: Boolean;
    function GetAutoHideIsVisible: Boolean;
    function GetDockDims: TRect;
    function GetFlags: TAppBarFlags;
    function GetFloatRect: TRect;
    function GetHorzSizeInc: LongInt;
    procedure SetHorzSizeInc(Value: LongInt);
    function GetKeepSize: Boolean;
    function GetMaxHeight: LongInt;
    procedure SetMaxHeight(Value: LongInt);
    function GetMaxWidth: LongInt;
    procedure SetMaxWidth(Value: LongInt);
    function GetMinHeight: LongInt;
    procedure SetMinHeight(Value: LongInt);
    function GetMinWidth: LongInt;
    procedure SetMinWidth(Value: LongInt);
    function GetOnEdgeChanged: TNotifyEvent;
    procedure SetOnEdgeChanged(Value: TNotifyEvent);
    function GetOnForcedToDocked: TNotifyEvent;
    procedure SetOnForcedToDocked(Value: TNotifyEvent);
    function GetPreventOffScreen: Boolean;
    function GetTaskEntry: TElAppBarTaskEntry;
    procedure SetTaskEntry(Value: TElAppBarTaskEntry);
    function GetVertSizeInc: LongInt;
    procedure SetVertSizeInc(Value: LongInt);
  public
    constructor Create(AOwner : TComponent); override;
    procedure SetDockDims(rc: TRect);
    procedure SetFloatRect(rc: TRect);
    property AutoHideIsVisible: Boolean read GetAutoHideIsVisible;
    property DockDims: TRect read GetDockDims write SetDockDims;
    property FloatRect: TRect read GetFloatRect write SetFloatRect;
  published
    property AlwaysOnTop: Boolean read GetAlwaysOnTop write SetAlwaysOnTop;
    property AutoHide: Boolean read GetAutoHide write SetAutoHide;
    property Edge: TAppBarEdge read GetEdge write SetEdge;
    property Flags: TAppBarFlags read GetFlags write SetFlags;
    property HorzSizeInc: LongInt read GetHorzSizeInc write SetHorzSizeInc;
    property KeepSize: Boolean read GetKeepSize write SetKeepSize;
    property MaxHeight: LongInt read GetMaxHeight write SetMaxHeight;
    property MaxWidth: LongInt read GetMaxWidth write SetMaxWidth;
    property MinHeight: LongInt read GetMinHeight write SetMinHeight;
    property MinWidth: LongInt read GetMinWidth write SetMinWidth;
    property OnEdgeChanged: TNotifyEvent read GetOnEdgeChanged write
        SetOnEdgeChanged;
    property OnForcedToDocked: TNotifyEvent read GetOnForcedToDocked write
        SetOnForcedToDocked;
    property PreventOffScreen: Boolean read GetPreventOffScreen write
        SetPreventOffScreen default false;
    property TaskEntry: TElAppBarTaskEntry read GetTaskEntry write SetTaskEntry;
    property VertSizeInc: LongInt read GetVertSizeInc write SetVertSizeInc;
  end;

implementation

constructor TElAppBarForm.Create(AOwner : TComponent);
begin
  inherited;
  FAppBar := TElAppBar.Create(Self);
end;

function TElAppBarForm.GetEdge: TAppBarEdge;
begin
  Result := FAppBar.Edge;
end;

procedure TElAppBarForm.SetAlwaysOnTop(bAlwaysOnTop: Boolean);
begin
  FAppBar.AlwaysOnTop := bAlwaysOnTop;
end;

procedure TElAppBarForm.SetAutoHide(bAutoHide: Boolean);
begin
  FAppBar.Autohide := bAutoHide;
end;

procedure TElAppBarForm.SetDockDims(rc: TRect);
begin
  {$ifdef BUILDER_USED}
  FAppBar.SetDockDims(rc);
  {$else}
  FAppBar.DockDims := rc;
  {$endif}
end;

procedure TElAppBarForm.SetEdge(abEdge: TAppBarEdge);
begin
  FAppBar.Edge := abEdge;
end;

procedure TElAppBarForm.SetFlags(newValue: TAppBarFlags);
begin
  FAppBar.Flags := newValue;
end;

procedure TElAppBarForm.SetFloatRect(rc: TRect);
begin
  {$ifdef BUILDER_USED}
  FAppBar.SetFloatRect(rc);
  {$else}
  FAppBar.FloatRect := rc;
  {$endif}
end;

procedure TElAppBarForm.SetKeepSize(newValue: Boolean);
begin
  FAppBar.KeepSize := newValue;
end;

procedure TElAppBarForm.SetPreventOffScreen(newValue: Boolean);
begin
  FAppBar.PreventOffScreen := newValue;
end;

function TElAppBarForm.GetAlwaysOnTop: Boolean;
begin
  Result := FAppBar.AlwaysOnTop;
end;

function TElAppBarForm.GetAutoHide: Boolean;
begin
  Result := FAppBar.AutoHide;
end;

function TElAppBarForm.GetAutoHideIsVisible: Boolean;
begin
  Result := FAppBar.AutoHideIsVisible;
end;

function TElAppBarForm.GetDockDims: TRect;
begin
  {$ifdef BUILDER_USED}
  FAppBar.GetDockDims(Result);
  {$else}
  Result := FAppBar.DockDims;
  {$endif}
end;

function TElAppBarForm.GetFlags: TAppBarFlags;
begin
  Result := FAppBar.Flags;
end;

function TElAppBarForm.GetFloatRect: TRect;
begin
  {$ifdef BUILDER_USED}
  FAppBar.GetFloatRect(Result);
  {$else}
  Result := FAppBar.FloatRect;
  {$endif}
end;

function TElAppBarForm.GetHorzSizeInc: LongInt;
begin
  Result := FAppBar.HorzSizeInc;
end;

procedure TElAppBarForm.SetHorzSizeInc(Value: LongInt);
begin
  FAppBar.HorzSizeInc := Value;
end;

function TElAppBarForm.GetKeepSize: Boolean;
begin
  Result := FAppBar.KeepSize;
end;

function TElAppBarForm.GetMaxHeight: LongInt;
begin
  Result := FAppBar.MaxHeight;
end;

procedure TElAppBarForm.SetMaxHeight(Value: LongInt);
begin
  FAppBar.MaxHeight := Value;
end;

function TElAppBarForm.GetMaxWidth: LongInt;
begin
  Result := FAppBar.MaxWidth;
end;

procedure TElAppBarForm.SetMaxWidth(Value: LongInt);
begin
  FAppBar.MaxWidth := Value;
end;

function TElAppBarForm.GetMinHeight: LongInt;
begin
  Result := FAppBar.MinHeight;
end;

procedure TElAppBarForm.SetMinHeight(Value: LongInt);
begin
  FAppBar.MinHeight := Value;
end;

function TElAppBarForm.GetMinWidth: LongInt;
begin
  Result :=FAppBar.MinWidth;
end;

procedure TElAppBarForm.SetMinWidth(Value: LongInt);
begin
  FAppBar.MinWidth := Value;
end;

function TElAppBarForm.GetOnEdgeChanged: TNotifyEvent;
begin
  Result :=FAppBar.OnEdgeChanged;
end;

procedure TElAppBarForm.SetOnEdgeChanged(Value: TNotifyEvent);
begin
  FAppBar.OnEdgeChanged := Value;
end;

function TElAppBarForm.GetOnForcedToDocked: TNotifyEvent;
begin
  Result :=FAppBar.OnForcedToDocked;
end;

procedure TElAppBarForm.SetOnForcedToDocked(Value: TNotifyEvent);
begin
  FAppBar.OnForcedToDocked := Value;
end;

function TElAppBarForm.GetPreventOffScreen: Boolean;
begin
  Result :=FAppBar.PreventOffScreen;
end;

function TElAppBarForm.GetTaskEntry: TElAppBarTaskEntry;
begin
  Result :=FAppBar.TaskEntry;
end;

procedure TElAppBarForm.SetTaskEntry(Value: TElAppBarTaskEntry);
begin
  FAppBar.TaskEntry := Value;
end;

function TElAppBarForm.GetVertSizeInc: LongInt;
begin
  Result :=FAppBar.VertSizeInc;
end;

procedure TElAppBarForm.SetVertSizeInc(Value: LongInt);
begin
  FAppBar.VertSizeInc := Value;
end;


end.
