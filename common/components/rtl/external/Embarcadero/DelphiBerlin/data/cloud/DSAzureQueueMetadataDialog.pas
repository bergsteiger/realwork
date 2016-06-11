{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureQueueMetadataDialog;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit;

type
  TAzureQueueMetadataDialog = class(TForm)
    MetadataList: TValueListEditor;
    ButtClose: TButton;
    ButtCommit: TButton;
    btnDelMetadata: TButton;
    btnAddMetadata: TButton;
    procedure btnDelMetadataClick(Sender: TObject);
    procedure btnAddMetadataClick(Sender: TObject);
    procedure MetadataListStringsChange(Sender: TObject);
  public
    /// <summary>Sets the queue name and Metadata</summary>
    /// <param name="QueueName">The name of the queue to display metadata for</param>
    /// <param name="Metadata">The queue's current metadata</param>
    procedure SetActiveQueue(const QueueName: String; Metadata: TStrings);
    /// <summary>Returns the metadata as held by the list.</summary>
    /// <returns>the metadata as held by the list.</returns>
    function GetMetadata: TStringList;
  end;

var
  AzureQueueMetadataDialog: TAzureQueueMetadataDialog;

implementation

uses Data.DBXClientResStrs;

{$R *.dfm}

procedure TAzureQueueMetadataDialog.btnAddMetadataClick(Sender: TObject);
begin
  MetadataList.Col := 0;
  MetadataList.Row := MetadataList.InsertRow('', '', true);
  MetadataList.SetFocus;
  ButtCommit.Enabled := true;
end;

procedure TAzureQueueMetadataDialog.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := MetadataList.Row;
  if (row > 0) and (row < MetadataList.RowCount) then
  begin
    MetadataList.DeleteRow(row);
    ButtCommit.Enabled := true;
  end;
end;

function TAzureQueueMetadataDialog.GetMetadata: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(MetadataList.Strings);
end;

procedure TAzureQueueMetadataDialog.MetadataListStringsChange(Sender: TObject);
begin
  ButtCommit.Enabled := True;
end;

procedure TAzureQueueMetadataDialog.SetActiveQueue(const QueueName: String; Metadata: TStrings);
begin
  if (QueueName <> EmptyStr) then
  begin
    Caption := Format('%s: %s', [SQueueMetadataTitle, QueueName]);
    MetadataList.Strings.BeginUpdate;
    try
      MetadataList.Strings.Clear;
      if (MetaData <> nil) then
        MetadataList.Strings.AddStrings(Metadata);
    finally
      MetadataList.Strings.EndUpdate;
    end;
  end
  else
    Caption := SQueueMetadataTitle;
  ButtCommit.Enabled := False;
end;

end.
