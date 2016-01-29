{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit adxWFrmClient4;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  adxWFrmClient, StdCtrls;

type
  TfrmClient4 = class(TfrmClient)
    memFinish: TMemo;
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses adxWForm;

{$R *.DFM}

{ TfrmClient4 }

constructor TfrmClient4.Create(AOwner: TComponent);

  procedure Check;
  begin
    {$IFDEF ADX_INTERNAL}
    {$I check.inc}
    {$ENDIF}
  end;

var
  i: Integer;
begin
  inherited Create(AOwner);
  Check;
  if MainForm.FDestApp in [daRTD, daSmartTag] then
    lblComment.Caption :=
      'Click Finish to create and to open the project, or click Back if ' +
      'you want to review or change any settings.'
  else
    lblComment.Caption :=
      'Click Finish to create and to open the add-in project, or click Back if ' +
      'you want to review or change any settings.';
  MemFinish.Lines.Clear;
  MemFinish.Lines.Add('Project Name: ');
  MemFinish.Lines.Add('       ' + MainForm.ProjectName);
  MemFinish.Lines.Add('Destination Folder:');
  MemFinish.Lines.Add('       ' + MainForm.DestinationFolder);
  MemFinish.Lines.Add('Setup project:');
  if MainForm.IsInnoSetup or MainForm.IsWiXSetup then begin
    if MainForm.IsInnoSetup then
      MemFinish.Lines.Add('       ' + MainForm.ProjectName + '.iss');
    if MainForm.IsWiXSetup then
      MemFinish.Lines.Add('       ' + MainForm.ProjectName + '.wxs');
  end
  else
    MemFinish.Lines.Add('       none');
  if MainForm.FDestApp = daRTD then begin
    MemFinish.Lines.Add('CoClass Name:');
    MemFinish.Lines.Add('       ' + MainForm.AddInCoClassName);
    MemFinish.Lines.Add('COM Server Type:');
    if MainForm.RTDFormat = afStandalone then
      MemFinish.Lines.Add('       EXE')
    else
      MemFinish.Lines.Add('       DLL');
  end
  else begin
    if MainForm.FDestApp = daSmartTag then begin
      MemFinish.Lines.Add('CoClass Names:');
      MemFinish.Lines.Add('       ' + MainForm.AddInCoClassName + 'Recognizer');
      MemFinish.Lines.Add('       ' + MainForm.AddInCoClassName + 'Action');
    end
    else begin
      MemFinish.Lines.Add('Add-in CoClass Name:');
      MemFinish.Lines.Add('       ' + MainForm.AddInCoClassName);
    end;

    if (MainForm.FDestApp = daOutlook) and (MainForm.PropPages.Count > 0) then begin
      MemFinish.Lines.Add('Option Pages: ');
      for i := 0 to MainForm.PropPages.Count - 1 do
        if MainForm.PropPages[i].IsOptionPage then
          MemFinish.Lines.Add('       ' + 'CoClass: "' + MainForm.PropPages[i].CoClassName +
            '" Tab Title: "' + MainForm.PropPages[i].TabTitle + '"')
        else
          if MainForm.PropPages[i].FolderName = '*' then
            MemFinish.Lines.Add('       ' + 'CoClass: "' + MainForm.PropPages[i].CoClassName +
              '" Tab Title: "' + MainForm.PropPages[i].TabTitle + '" Folder Name: ' + '"All Folders"')
          else
            MemFinish.Lines.Add('       ' + 'CoClass: "' + MainForm.PropPages[i].CoClassName +
              '" Tab Title: "' + MainForm.PropPages[i].TabTitle + '" Folder Name: "' + MainForm.PropPages[i].FolderName + '"');
    end;

    if (MainForm.TaskPanes.Count > 0) then begin
      MemFinish.Lines.Add('Task Panes: ');
      for i := 0 to MainForm.TaskPanes.Count - 1 do
        MemFinish.Lines.Add('       ' + 'CoClass: "' + MainForm.TaskPanes[i].CoClassName +
          '" Title: "' + MainForm.TaskPanes[i].Title + '"');
    end;
  end;
end;

end.
