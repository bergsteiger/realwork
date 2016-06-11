{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC wait time user interface            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.VCLUI.Wait;

interface

implementation

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
  FireDAC.Stan.Consts, FireDAC.Stan.Util, FireDAC.Stan.Factory,
  FireDAC.UI.Intf, FireDAC.UI;

{-------------------------------------------------------------------------------}
{- TFDGUIxVCLWaitCursorImpl                                                    -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxVCLWaitCursorImpl = class(TFDGUIxVisualWaitCursorImplBase)
  private
    function CheckGetCursor(out ACrs: TCursor): Boolean;
  protected
    function CheckCurCursor: Boolean; override;
    function InternalHideCursor: Boolean;  override;
    procedure InternalShowCursor; override;
  end;

{-------------------------------------------------------------------------------}
function TFDGUIxVCLWaitCursorImpl.CheckGetCursor(out ACrs: TCursor): Boolean;
begin
  case FWaitCursor of
    gcrDefault:   ACrs := crDefault;
    gcrHourGlass: ACrs := crHourGlass;
    gcrSQLWait:   ACrs := crSQLWait;
    gcrAppWait:   ACrs := crAppStart;
  else            ACrs := crNone;
  end;
  Result := ACrs <> crNone;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxVCLWaitCursorImpl.CheckCurCursor: Boolean;
var
  iCrs: TCursor;
begin
  Result := (Screen <> nil) and CheckGetCursor(iCrs) and (Screen.Cursor = iCrs);
end;

{-------------------------------------------------------------------------------}
function TFDGUIxVCLWaitCursorImpl.InternalHideCursor: Boolean;
begin
  Result := Screen <> nil;
  if Result then
    Screen.Cursor := crDefault;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVCLWaitCursorImpl.InternalShowCursor;
var
  iCrs: TCursor;
begin
  if CheckGetCursor(iCrs) then
    Screen.Cursor := iCrs;
end;

{-------------------------------------------------------------------------------}
function CheckGuiRunning: Boolean;
begin
  Result := (Application <> nil) and not Application.Terminated;
end;

{-------------------------------------------------------------------------------}
{- TFDGUIxVCLTimerImpl                                                         -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxVCLTimerImpl = class(TFDGUIxObject, IFDGUIxTimer)
  private
    FTimer: TTimer;
  protected
    // IFDGUIxTimer
    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);
    procedure SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVCLTimerImpl.Initialize;
begin
  inherited Initialize;
  FTimer := TTimer.Create(nil);
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxVCLTimerImpl.Destroy;
begin
  FDFreeAndNil(FTimer);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxVCLTimerImpl.GetEnabled: Boolean;
begin
  Result := FTimer.Enabled;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVCLTimerImpl.SetEnabled(AValue: Boolean);
begin
  FTimer.Enabled := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxVCLTimerImpl.SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
begin
  FTimer.Interval := ATimeout;
  FTimer.OnTimer := AProc;
end;

{-------------------------------------------------------------------------------}
var
  oFact1: TFDFactory;
  oFact2: TFDFactory;

initialization
  oFact1 := TFDSingletonFactory.Create(TFDGUIxVCLWaitCursorImpl, IFDGUIxWaitCursor,
    C_FD_GUIxFormsProvider);
  oFact2 := TFDMultyInstanceFactory.Create(TFDGUIxVCLTimerImpl, IFDGUIxTimer,
    C_FD_GUIxFormsProvider);

  GCheckGuiRunning := CheckGuiRunning;

finalization
  FDReleaseFactory(oFact1);
  FDReleaseFactory(oFact2);

end.
