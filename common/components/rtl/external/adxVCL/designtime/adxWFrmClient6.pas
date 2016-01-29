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

unit adxWFrmClient6;

{$I adxDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Contnrs,
  adxWFrmClient;

type
  TfrmClient6 = class(TfrmClient)
    sgPages: TStringGrid;
    btnAdd: TButton;
    btnRemove: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure sgPagesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    constructor Create(AOwner: TComponent); override;
    function Check: boolean; override;
  end;

implementation

uses adxWForm, ActiveX;

{$R *.DFM}

{ TfrmClient6 }

constructor TfrmClient6.Create(AOwner: TComponent);
var
  i: Integer;
  Item: TTaskPane;
begin
  inherited Create(AOwner);
  if MainForm.FDestApp = daOutlook then begin
    lblTitle.Caption := 'Outlook 2007 Task Panes';
    lblComment.Caption :=
      'On this page, you can add task panes to Outlook 2007.'#13#10 +
      '' + #13#10 +
      '';
  end else begin
    lblTitle.Caption := 'Office 2007 Task Panes';
    lblComment.Caption :=
      'You can add a task pane to the following Office 2007 applications: Excel, Word, Outlook, Access, PowerPoint and InfoPath.'#13#10 +
      '' + #13#10 +
      '';
  end;
  sgPages.ColWidths[0] := 100;
  sgPages.ColWidths[1] := 240;
  sgPages.Cells[0, 0] := ' CoClass Name';
  sgPages.Cells[1, 0] := ' Title';

  for i := 0 to MainForm.TaskPanes.Count - 1 do begin
    Item := MainForm.TaskPanes[i];
    if (sgPages.RowCount = 2) and (sgPages.Cells[0, 1] = '') then
    else
      sgPages.RowCount := sgPages.RowCount + 1;
    sgPages.Cells[0, sgPages.RowCount - 1] := Item.CoClassName;
    sgPages.Cells[1, sgPages.RowCount - 1] := Item.Title;
  end;
end;

function TfrmClient6.Check: boolean;
  function CheckColumn(const Index: Integer): boolean;
  var
    i, RowIndex: Integer;
  begin
    Result := True;
    RowIndex := 1;
    for i := 1 to sgPages.RowCount - 1 do begin
      if ((sgPages.Cells[Index, i] = '') and ((sgPages.Cells[0, i] <> '') or (sgPages.Cells[1, i] <> ''))) or
        ((Index = 0) and ((sgPages.Cells[Index, i] = MainForm.ProjectName) or (sgPages.Cells[Index, i] = MainForm.AddInCoClassName))) then
      begin
        Result := False;
        RowIndex := i;
        Break;
      end;
    end;
    if not Result then begin
      sgPages.Row := RowIndex;
      sgPages.Col := Index;
      if Index = 0 then
        MessageDlg('CoClass Name can be neither empty, nor the same as Project Name, nor the same as the main CoClass name.', mtError, [mbCancel], 0)
      else
        MessageDlg('The Title can'#39't be empty.', mtError, [mbCancel], 0);
      sgPages.SetFocus;
      sgPages.EditorMode := True;
    end;
  end;

var
  i: Integer;
  Item: TTaskPane;
begin
  Result := CheckColumn(0);
  if Result then Result := CheckColumn(1);
  if Result then begin
    MainForm.TaskPanes.Clear;
    for i := 1 to sgPages.RowCount - 1 do
      if sgPages.Cells[0, i] <> '' then begin
        Item := TTaskPane.Create;
        Item.CoClassName := StringReplace(sgPages.Cells[0, i], #32, '_', [rfReplaceAll]);
        Item.Title := sgPages.Cells[1, i];
        MainForm.TaskPanes.Add(Item);
      end;
  end;
end;

procedure TfrmClient6.btnAddClick(Sender: TObject);
begin
  if sgPages.Cells[0, sgPages.RowCount - 1] <> '' then
    sgPages.RowCount := sgPages.RowCount + 1;
  sgPages.Row := sgPages.RowCount - 1;
  sgPages.Col := 0;
  sgPages.SetFocus;
  sgPages.EditorMode := True;
end;

procedure TfrmClient6.btnRemoveClick(Sender: TObject);
var
  i: Integer;
begin
  if sgPages.RowCount = 2 then sgPages.Rows[sgPages.Row].Clear
  else begin
    for i := sgPages.Row to sgPages.RowCount - 2 do begin
      sgPages.Rows[i].Clear;
      sgPages.Rows[i] := sgPages.Rows[i + 1];
      sgPages.Rows[i + 1].Clear;
    end;
    sgPages.Rows[sgPages.RowCount - 1].Clear;
    sgPages.RowCount := sgPages.RowCount - 1;
  end;
end;

procedure TfrmClient6.sgPagesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_INSERT) and not sgPages.EditorMode then btnAdd.Click;
  if (Key = VK_DELETE) and not sgPages.EditorMode then btnRemove.Click;
end;

end.
