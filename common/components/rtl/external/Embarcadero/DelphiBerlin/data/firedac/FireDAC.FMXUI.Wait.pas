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

unit FireDAC.FMXUI.Wait;

interface

implementation

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  FMX.Types, FMX.Platform, FMX.Forms,
  FireDAC.Stan.Factory, FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.UI.Intf, FireDAC.Comp.UI, FireDAC.UI;

{-------------------------------------------------------------------------------}
{- TFDGUIxFMXWaitCursorImpl                                                    -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxFMXWaitCursorImpl = class(TFDGUIxVisualWaitCursorImplBase)
  private
    FCurCursor: TCursor;
    function CheckGetCursor(out ACrs: TCursor): Boolean;
  protected
    function CheckCurCursor: Boolean; override;
    function InternalHideCursor: Boolean;  override;
    procedure InternalShowCursor; override;
  end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXWaitCursorImpl.CheckGetCursor(out ACrs: TCursor): Boolean;
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
function TFDGUIxFMXWaitCursorImpl.CheckCurCursor: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXWaitCursorImpl.InternalHideCursor: Boolean;
var
  oCrsSrv: IFMXCursorService;
begin
  Result := (FCurCursor <> crDefault) and
    TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, IInterface(oCrsSrv));
  if Result then begin
    FCurCursor := crDefault;
    oCrsSrv.SetCursor(crDefault);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXWaitCursorImpl.InternalShowCursor;
var
  iCrs: TCursor;
  oCrsSrv: IFMXCursorService;
begin
  if CheckGetCursor(iCrs) and (FCurCursor <> iCrs) and
     TPlatformServices.Current.SupportsPlatformService(IFMXCursorService, IInterface(oCrsSrv)) then begin
    FCurCursor := iCrs;
    oCrsSrv.SetCursor(iCrs);
  end;
end;

{-------------------------------------------------------------------------------}
function CheckGuiRunning: Boolean;
begin
  Result := (Application <> nil) and not Application.Terminated;
end;

{-------------------------------------------------------------------------------}
{- TFDGUIxFMXTimerImpl                                                         -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxFMXTimerImpl = class(TFDGUIxObject, IFDGUIxTimer)
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
procedure TFDGUIxFMXTimerImpl.Initialize;
begin
  inherited Initialize;
  FTimer := TTimer.Create(nil);
end;

{-------------------------------------------------------------------------------}
destructor TFDGUIxFMXTimerImpl.Destroy;
begin
  FDFreeAndNil(FTimer);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDGUIxFMXTimerImpl.GetEnabled: Boolean;
begin
  Result := FTimer.Enabled;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXTimerImpl.SetEnabled(AValue: Boolean);
begin
  FTimer.Enabled := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxFMXTimerImpl.SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
begin
  FTimer.Interval := ATimeout;
  FTimer.OnTimer := AProc;
end;

{-------------------------------------------------------------------------------}
var
  oFact1: TFDFactory;
  oFact2: TFDFactory;

initialization
  oFact1 := TFDSingletonFactory.Create(TFDGUIxFMXWaitCursorImpl, IFDGUIxWaitCursor,
    C_FD_GUIxFMXProvider);
  oFact2 := TFDMultyInstanceFactory.Create(TFDGUIxFMXTimerImpl, IFDGUIxTimer,
    C_FD_GUIxFMXProvider);

  GCheckGuiRunning := CheckGuiRunning;

finalization
  FDReleaseFactory(oFact1);
  FDReleaseFactory(oFact2);

end.
