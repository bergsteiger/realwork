{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgSnapshotBlob;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzSnapshotBlob = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtModifiedSince: TEdit;
    edtUnmodified: TEdit;
    edtNoneMatch: TEdit;
    edtMatch: TEdit;
    vleMeta: TValueListEditor;
    btnAddMetadata: TButton;
    btnDelMetadata: TButton;
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetModifiedSince: String;
    function GetUnmodifiedSince: String;
    function GetMatch: String;
    function GetNoneMatch: String;

    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    function RawMetadata: TStrings;
  end;

implementation

uses Vcl.Dialogs;

{$R *.dfm}

procedure TAzSnapshotBlob.AssignMetadata(
  const meta: TDictionary<String, String>);
var
  I, Count: Integer;
  key, value: String;
begin
  meta.Clear;
  Count := vleMeta.Strings.Count;
  for I := 0 to Count - 1 do
  begin
    key := vleMeta.Strings.Names[I];
    value := vleMeta.Strings.ValueFromIndex[I];
    if (Length(key) > 0) and (Length(value) > 0) then
      meta.Add(key, value);
  end;
end;


procedure TAzSnapshotBlob.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzSnapshotBlob.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

function TAzSnapshotBlob.GetModifiedSince: String;
begin
  Result := edtModifiedSince.Text;
end;

function TAzSnapshotBlob.GetUnmodifiedSince: String;
begin
  Result := edtUnmodified.Text;
end;

function TAzSnapshotBlob.GetMatch: String;
begin
  Result := edtMatch.Text;
end;

function TAzSnapshotBlob.GetNoneMatch: String;
begin
  Result := edtNoneMatch.Text;
end;

procedure TAzSnapshotBlob.PopulateWithMetadata(
  const meta: TDictionary<String, String>);
var
  keys: TArray<String>;
  I, Count: Integer;
begin
  vleMeta.Strings.Clear;
  keys := meta.Keys.ToArray;
  Count := meta.Keys.Count;
  for I := 0 to Count - 1 do
    vleMeta.Values[keys[I]] := meta.Items[keys[I]];
end;

function TAzSnapshotBlob.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings
end;

end.
