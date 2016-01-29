{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclStackTraceViewerOptions.pas.                                             }
{                                                                                                  }
{ The Initial Developer of the Original Code is Uwe Schuster.                                      }
{ Portions created by Uwe Schuster are Copyright (C) 2009 Uwe Schuster. All rights reserved.       }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Uwe Schuster (uschuster)                                                                       }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Last modified: $Date: 2013/04/05 14:49:13 $ }
{ Revision:      $Rev:: 2969                                                                     $ }
{ Author:        $Author: lulin $ }
{                                                                                                  }
{**************************************************************************************************}

unit JclStackTraceViewerOptions;

{$I jcl.inc}

interface

uses
  Classes
  {$IFDEF UNITVERSIONING}
  , JclUnitVersioning
  {$ENDIF UNITVERSIONING}
  ;

type
  TExceptionViewerOption = class(TPersistent)
  private
    FExpandTreeView: Boolean;
    FModuleVersionAsRevision: Boolean;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create;
    property ExpandTreeView: Boolean read FExpandTreeView write FExpandTreeView;
    property ModuleVersionAsRevision: Boolean read FModuleVersionAsRevision write FModuleVersionAsRevision;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jcl.svn.sourceforge.net:443/svnroot/jcl/tags/JCL-2.3-Build4197/jcl/experts/stacktraceviewer/JclStackTraceViewerOptions.pas $';
    Revision: '$Revision: 1.1 $';
    Date: '$Date: 2013/04/05 14:49:13 $';
    LogPath: 'JCL\experts\stacktraceviewer';
    Extra: '';
    Data: nil
    );
{$ENDIF UNITVERSIONING}

implementation

{ TExceptionViewerOption }

constructor TExceptionViewerOption.Create;
begin
  inherited Create;
  FExpandTreeView := False;
  FModuleVersionAsRevision := False;
end;

procedure TExceptionViewerOption.AssignTo(Dest: TPersistent);
begin
  if Dest is TExceptionViewerOption then
  begin
    TExceptionViewerOption(Dest).FExpandTreeView := ExpandTreeView;
    TExceptionViewerOption(Dest).FModuleVersionAsRevision := ModuleVersionAsRevision;
  end
  else
    inherited AssignTo(Dest);
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.