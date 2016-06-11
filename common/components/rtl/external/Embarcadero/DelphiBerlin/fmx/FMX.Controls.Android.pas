{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Android;

interface

{$SCOPEDENUMS ON}

implementation

uses FMX.Types, FMX.Styles, System.Types, System.Classes, System.SysUtils;

{$R *.res}

initialization
  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.Android, 'androidstyle');
end.

