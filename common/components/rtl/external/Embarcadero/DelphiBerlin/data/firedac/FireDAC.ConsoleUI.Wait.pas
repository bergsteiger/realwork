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

unit FireDAC.ConsoleUI.Wait;

interface

implementation

uses
  System.Classes, System.SysUtils,
  FireDAC.Stan.Factory, FireDAC.Stan.Consts,
  FireDAC.UI.Intf, FireDAC.UI;

{-------------------------------------------------------------------------------}
{- TFDGUIxConsoleWaitCursorImpl                                                -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxConsoleWaitCursorImpl = class(TFDGUIxWaitCursorImplBase)
  protected
    // IFDGUIxWaitCursor
    procedure StartWait; override;
    procedure StopWait; override;
    procedure PushWait; override;
    procedure PopWait; override;
    procedure ForceStopWait; override;
  end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleWaitCursorImpl.StartWait;
begin
  if FDGUIxSilent() then
    Exit;
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleWaitCursorImpl.StopWait;
begin
  if FDGUIxSilent() then
    Exit;
  if Assigned(FOnHide) then
    FOnHide(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleWaitCursorImpl.PopWait;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleWaitCursorImpl.PushWait;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleWaitCursorImpl.ForceStopWait;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{- TFDGUIxConsoleTimerImpl                                                     -}
{-------------------------------------------------------------------------------}
type
  TFDGUIxConsoleTimerImpl = class(TFDGUIxObject, IFDGUIxTimer)
  protected
    // IFDGUIxTimer
    function GetEnabled: Boolean;
    procedure SetEnabled(AValue: Boolean);
    procedure SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
  end;

{-------------------------------------------------------------------------------}
function TFDGUIxConsoleTimerImpl.GetEnabled: Boolean;
begin
  Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleTimerImpl.SetEnabled(AValue: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDGUIxConsoleTimerImpl.SetEvent(AProc: TNotifyEvent; ATimeout: LongWord);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
var
  oFact1: TFDFactory;
  oFact2: TFDFactory;

initialization
  oFact1 := TFDSingletonFactory.Create(TFDGUIxConsoleWaitCursorImpl,
    IFDGUIxWaitCursor, C_FD_GUIxConsoleProvider);
  oFact2 := TFDMultyInstanceFactory.Create(TFDGUIxConsoleTimerImpl,
    IFDGUIxTimer, C_FD_GUIxConsoleProvider);

finalization
  FDReleaseFactory(oFact1);
  FDReleaseFactory(oFact2);

end.
