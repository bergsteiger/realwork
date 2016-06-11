{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgPageBlob;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzPageBlob = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    lblBlobName: TLabel;
    edtBlobName: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtContentType: TEdit;
    edtLanguage: TEdit;
    edtMD5: TEdit;
    edtEncoding: TEdit;
    vleMeta: TValueListEditor;
    btnAddMetadata: TButton;
    btnDelMetadata: TButton;
    lblContentLength: TLabel;
    edtContentLength: TEdit;
    cbUnit: TComboBox;
    Label5: TLabel;
    edtSequence: TEdit;
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure edtBlobNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetBlobName: String;
    function GetContentType: String;
    function GetContentLanguage: String;
    function GetContentMD5: String;
    function GetContentEncoding: String;
    function GetContentLength: Int64;
    function GetSequenceNumber: Int64;

    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    function RawMetadata: TStrings;
  end;

implementation

uses Vcl.Dialogs, System.SysUtils;

{$R *.dfm}

procedure TAzPageBlob.AssignMetadata(
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


procedure TAzPageBlob.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzPageBlob.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

procedure TAzPageBlob.edtBlobNameChange(Sender: TObject);
begin
  OKBtn.Enabled := Length(edtBlobName.Text) > 0;
end;

function TAzPageBlob.GetBlobName: String;
begin
  Result := edtBlobName.Text;
end;

function TAzPageBlob.GetContentEncoding: String;
begin
  Result := edtEncoding.Text;
end;

function TAzPageBlob.GetContentLanguage: String;
begin
  Result := edtLanguage.Text;
end;

function TAzPageBlob.GetContentLength: Int64;
begin
  Result := StrToInt64(edtContentLength.Text);
  case cbUnit.ItemIndex of
  1: Result := Result * 1024;
  2: Result := Result * 1024 * 1024;
  3: Result := Result * 1024 * 1024 * 1024;
  end;
end;

function TAzPageBlob.GetContentMD5: String;
begin
  Result := edtMD5.Text;
end;

function TAzPageBlob.GetContentType: String;
begin
  Result := edtContentType.Text;
end;

function TAzPageBlob.GetSequenceNumber: Int64;
begin
  Result := StrToInt64(edtSequence.Text);
end;

procedure TAzPageBlob.PopulateWithMetadata(
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

function TAzPageBlob.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings
end;

end.
