{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MobilePreview;

{$HPPEMIT LINKUNIT}

interface

{$SCOPEDENUMS ON}

implementation

{$IFDEF WIN32}
uses 
  System.SysUtils, System.Types, FMX.Styles;

{$R *.res}

var
  OldInitProc: Pointer;

procedure InitializeStyle;
begin
  if Assigned(OldInitProc) then
    TProcedure(OldInitProc);
  if FindResource(HInstance, PChar('mobilepreviewstyle'), RT_RCDATA) <> 0 then
    TStyleManager.SetStyle(TStyleStreaming.LoadFromResource(HInstance, 'mobilepreviewstyle', RT_RCDATA));
end;

initialization
  OldInitProc := InitProc;
  InitProc := @InitializeStyle;

{$ENDIF}
end.
