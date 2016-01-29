{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.XPMan;

{$WEAKPACKAGEUNIT ON}

interface

uses
{$IF DEFINED(CLR)}
  System.ComponentModel.Design.Serialization,
{$ENDIF}
  System.SysUtils, System.Classes;

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TXPManifest = class(TComponent)
  end;

{$IF DEFINED(CLR)}
{$R Borland.Vcl.WindowsXP.res}
{$ELSE}
{$R WindowsXP.res}
{$ENDIF}

implementation

end.
