{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgBlockBlob;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzBlockBlob = class(TForm)
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
    edtFilename: TEdit;
    lblContentLocation: TLabel;
    btnFile: TButton;
    vleMeta: TValueListEditor;
    btnAddMetadata: TButton;
    btnDelMetadata: TButton;
    procedure btnFileClick(Sender: TObject);
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure edtBlobNameChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetBlobName(const Name: string);
    procedure SetContentType(const Name: string);
    procedure SetContentLanguage(const Name: string);
    procedure SetContentMD5(const Name: string);
    procedure SetContentEncoding(const Name: string);

  public
    { Public declarations }
    function GetBlobName: String;
    function GetContentType: String;
    function GetContentLanguage: String;
    function GetContentMD5: String;
    function GetContentEncoding: String;
    function GetContentLocation: String;

    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    procedure SetOKCaption(const Name: string);
    function RawMetadata: TStrings;

    property BlobName: string read GetBlobName write SetBlobName;
    property ContentType: string read GetContentType write SetContentType;
    property ContentLanguage: string read GetContentLanguage write SetContentLanguage;
    property ContentEncoding: string read GetContentEncoding write SetContentEncoding;
    property ContentMD5: string read GetContentMD5 write SetContentMD5;
  end;

implementation

uses Data.DBXClientResStrs, Vcl.Dialogs, System.SysUtils, System.UITypes;

{$R *.dfm}

procedure TAzBlockBlob.AssignMetadata(
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


procedure TAzBlockBlob.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzBlockBlob.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

procedure TAzBlockBlob.btnFileClick(Sender: TObject);
var
  foDlg: TOpenDialog;
  fs: TFileStream;
begin
  foDlg := TOpenDialog.Create(self);
  if foDlg.Execute(Handle) then
  begin
    fs := TFileStream.Create(foDlg.FileName, fmOpenRead);
    try
      if fs.Size >= 64*1024*1024 then
        MessageDlg(SMaxSize, mtError, [mbOK], 0)
      else
        edtFilename.Text := foDlg.FileName;
    finally
      fs.Free;
    end;
  end;
  foDlg.Free;
end;

procedure TAzBlockBlob.edtBlobNameChange(Sender: TObject);
begin
  OKBtn.Enabled := Length(edtBlobName.Text) > 0;
end;

function TAzBlockBlob.GetBlobName: String;
begin
  Result := edtBlobName.Text;
end;

function TAzBlockBlob.GetContentEncoding: String;
begin
  Result := edtEncoding.Text;
end;

function TAzBlockBlob.GetContentLanguage: String;
begin
  Result := edtLanguage.Text;
end;

function TAzBlockBlob.GetContentLocation: String;
begin
  Result := edtFilename.Text;
end;

function TAzBlockBlob.GetContentMD5: String;
begin
  Result := edtMD5.Text;
end;

function TAzBlockBlob.GetContentType: String;
begin
  Result := edtContentType.Text;
end;

procedure TAzBlockBlob.PopulateWithMetadata(
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

function TAzBlockBlob.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings
end;

procedure TAzBlockBlob.SetBlobName(const Name: string);
begin
  edtBlobName.Text := Name;
  edtBlobName.Enabled := Length(Name) = 0;
end;

procedure TAzBlockBlob.SetContentEncoding(const Name: string);
begin
  edtEncoding.Text := Name;
end;

procedure TAzBlockBlob.SetContentLanguage(const Name: string);
begin
  edtLanguage.Text := Name;
end;

procedure TAzBlockBlob.SetContentMD5(const Name: string);
begin
  edtMD5.Text := Name;
end;

procedure TAzBlockBlob.SetContentType(const Name: string);
begin
  edtContentType.Text := Name;
end;

procedure TAzBlockBlob.SetOKCaption(const Name: string);
begin
  if Length(Name) = 0 then
    OKBtn.Caption := 'OK'
  else
    OKBtn.Caption := Name;
end;

end.
