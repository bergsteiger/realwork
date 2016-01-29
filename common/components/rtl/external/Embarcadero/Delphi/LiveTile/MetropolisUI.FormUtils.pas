{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit MetropolisUI.FormUtils;

interface

{$IFDEF MSWINDOWS}
uses
  Winapi.Windows;
{$ENDIF}

type
  TFindMainForms = class
{$IFDEF MSWINDOWS}
  public
    class var
      hwndMain: THandle;
  private
    class function EnumWndProc (hwnd: THandle;
      Param: Cardinal): Bool; stdcall; static;
{$ENDIF}
  public
    class procedure ExtractHandles;
  end;

implementation

uses
  System.SysUtils;

{$IFDEF MSWINDOWS}
class function TFindMainForms.EnumWndProc (hwnd: THandle;
  Param: Cardinal): Bool; stdcall;
var
  FoundClassName: string;
  Style: Integer;
  dwProcessId: Cardinal;
begin
  Result := True;
  SetLength (FoundClassName, 255);

  GetWindowThreadProcessId (hwnd, dwProcessId);
  if dwProcessId = GetCurrentProcessId then
  begin
    Style := GetWindowLong(hwnd, GWL_EXSTYLE);
    if (Style and WS_EX_APPWINDOW = WS_EX_APPWINDOW) or
      (Style and WS_EX_WINDOWEDGE = WS_EX_WINDOWEDGE) then
    begin
      hwndMain := hwnd;
      Result := False;
    end;
  end;
end;
{$ENDIF}

class procedure TFindMainForms.ExtractHandles;
begin
{$IFDEF MSWINDOWS}
  hwndMain := 0;
  EnumWindows (@EnumWndProc, 0);
{$ENDIF}
end;

end.
