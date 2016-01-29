{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Controls.Win;

interface

uses
  FMX.Types;

function GetSystemStyle: TFmxObject;

implementation

uses FMX.Styles, Winapi.Windows, System.Types, System.Classes, FMX.Forms;

{$R *.res}

function GetSystemStyle: TFmxObject;
var
  VI: TOSVersionInfo;
  ResName: string;
  PreviewStylePath: array [0..255] of Char;
begin
  Result := nil;

  if (Application <> nil) and not (TDeviceKind.dkDesktop in Application.FormFactor.Devices) and
    (Application.FormFactor.Devices * [TDeviceKind.dkiPhone, TDeviceKind.dkiPad] <> []) then
  begin
    ExpandEnvironmentStrings(PChar('%BDS%\ObjRepos\Devices\iOSAlternate.fsf'), PreviewStylePath, 256);
    Result := TStyleManager.LoadFromFile(PreviewStylePath);
  end;

  if Result = nil then
  begin
    FillChar(VI, SizeOf(VI), 0);
    VI.dwOSVersionInfoSize := SizeOf(VI);
    GetVersionEx(VI);
    if (VI.dwMajorVersion >= 6) and (VI.dwMinorVersion >= 2) then
      ResName := 'win8style'
    else
      ResName := 'win7style';

    if FindResource(HInstance, PChar(ResName), RT_RCDATA) <> 0 then
      Result := TStyleManager.LoadFromResource(HInstance, ResName, RT_RCDATA);
  end;
end;

end.
