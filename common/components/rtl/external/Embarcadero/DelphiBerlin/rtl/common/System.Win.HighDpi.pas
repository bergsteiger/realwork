{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.HighDpi;

interface

function IsDpiAware: Boolean;
function SetHighDpiAware: Boolean;

implementation

uses
  Winapi.Windows, Winapi.ShellScaling, System.SysUtils;

function SetHighDpiAware: Boolean;
begin
  if CheckWin32Version(6,3) then
    Result := SetProcessDpiAwareness(TProcessDpiAwareness.PROCESS_PER_MONITOR_DPI_AWARE) = S_OK
  else
    Result := SetProcessDpiAware;
end;


function IsDpiAware: Boolean;
var
  LLevel: TProcessDpiAwareness;
begin
  if CheckWin32Version(6,3) then
  begin
    GetProcessDpiAwareness(GetCurrentProcess, LLevel);
    Result := LLevel = TProcessDpiAwareness.PROCESS_PER_MONITOR_DPI_AWARE;
  end
  else
    Result := IsProcessDPIAware;
end;

{$IFDEF MSWINDOWS}
initialization
  SetHighDpiAware;
{$ENDIF}
end.
