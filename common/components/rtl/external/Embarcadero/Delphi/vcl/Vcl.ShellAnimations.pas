{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.ShellAnimations;
{$WEAKPACKAGEUNIT ON}
interface

uses
  System.SysUtils, System.Classes;

{$R FindFolder.res }
{$R FindFile.res }
{$R FindComputer.res }
{$R CopyFiles.res }
{$R CopyFile.res }
{$R RecycleFile.res }
{$R EmptyRecycle.res }
{$R DeleteFile.res }

type
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  TShellResources = class(TComponent)
  end;
  
implementation

end.

