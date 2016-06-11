{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgPutBlockList;

interface

uses
  Vcl.Buttons, Vcl.CheckLst, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections,
  Vcl.Graphics, Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TStringTransform = reference to procedure(const InStr: string; var OutStr: String);

  TAzPutBlockList = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
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
    Label5: TLabel;
    edtCacheControl: TEdit;
    grbUploaded: TGroupBox;
    cbxCommitLatest: TCheckBox;
    clbCommitted: TCheckListBox;
    Label6: TLabel;
    Label7: TLabel;
    clbUncommitted: TCheckListBox;
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure cbxCommitLatestClick(Sender: TObject);
    procedure clbCommittedClickCheck(Sender: TObject);
    procedure clbUncommittedClickCheck(Sender: TObject);
  private
    { Private declarations }
    FEncode: TStringTransform;

  public
    { Public declarations }
    function GetContentType: String;
    function GetContentLanguage: String;
    function GetContentMD5: String;
    function GetContentEncoding: String;
    function GetCacheControl: String;

    procedure AddCommittedBlockName(const Name: string);
    procedure AddUncommittedBlockName(const Name: string);
    function BlockListAsXML: String;
    procedure ClearLists;

    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    function RawMetadata: TStrings;

    property Encode: TStringTransform read FEncode write FEncode;
  end;

implementation

uses Vcl.Dialogs;

{$R *.dfm}

procedure TAzPutBlockList.AddCommittedBlockName(const Name: string);
var
  idx: Integer;
begin
  idx := clbCommitted.Items.Add(Name);
  clbCommitted.Checked[idx] := true;
  OKBtn.Enabled := true;
end;

procedure TAzPutBlockList.AddUncommittedBlockName(const Name: string);
begin
  clbUncommitted.AddItem(Name, nil);
  OKBtn.Enabled := true;
end;

procedure TAzPutBlockList.AssignMetadata(
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

function TAzPutBlockList.BlockListAsXML: String;
var
  i, count, idx: Integer;
  encoded: string;
begin
  Result := '<?xml version="1.0" encoding="utf-8"?><BlockList>';
  count := clbCommitted.Items.Count;
  for i := 0 to count - 1 do
  begin
    if cbxCommitLatest.Checked then
    begin
      Encode(clbCommitted.Items[i], encoded);
      Result := Result + '<Latest>' + encoded + '</Latest>';
    end else if clbCommitted.Checked[i] then
    begin
      Encode(clbCommitted.Items[i], encoded);
      Result := Result + '<Committed>' + encoded + '</Committed>';
    end else begin
      idx := clbUncommitted.Items.IndexOf(clbCommitted.Items[i]);
      if (idx > -1) and clbUncommitted.Checked[idx] then
      begin
        Encode(clbCommitted.Items[i], encoded);
        Result := Result + '<Uncommitted>' + encoded + '</Uncommitted>';
      end;
    end;
  end;
  count := clbUncommitted.Items.Count;
  for i := 0 to count - 1 do
  begin
    idx := clbCommitted.Items.IndexOf(clbUncommitted.Items[i]);
    if idx = -1 then
    begin
      if cbxCommitLatest.Checked then
      begin
        Encode(clbUncommitted.Items[i], encoded);
        Result := Result + '<Latest>' + encoded + '</Latest>';
      end else if clbUncommitted.Checked[i] then
      begin
        Encode(clbUncommitted.Items[i], encoded);
        Result := Result + '<Uncommitted>' + encoded + '</Uncommitted>';
      end;
    end;
  end;
  Result := Result + '</BlockList>';
end;

procedure TAzPutBlockList.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzPutBlockList.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

procedure TAzPutBlockList.cbxCommitLatestClick(Sender: TObject);
begin
  clbCommitted.Enabled := not cbxCommitLatest.Checked;
  clbUncommitted.Enabled := not cbxCommitLatest.Checked;
end;

procedure TAzPutBlockList.clbCommittedClickCheck(Sender: TObject);
var
  blockName: string;
  blockIndex: Integer;
begin
  if clbCommitted.Checked[clbCommitted.ItemIndex] then
  begin
    blockName := clbCommitted.Items[clbCommitted.ItemIndex];
    blockIndex := clbUncommitted.Items.IndexOf(blockName);
    if blockIndex > -1 then
      clbUncommitted.Checked[blockIndex] := false;
  end;
end;

procedure TAzPutBlockList.clbUncommittedClickCheck(Sender: TObject);
var
  blockName: string;
  blockIndex: Integer;
begin
  if clbUncommitted.Checked[clbUncommitted.ItemIndex] then
  begin
    blockName := clbUncommitted.Items[clbUncommitted.ItemIndex];
    blockIndex := clbCommitted.Items.IndexOf(blockName);
    if blockIndex > -1 then
      clbCommitted.Checked[blockIndex] := false;
  end;
end;

procedure TAzPutBlockList.ClearLists;
begin
  clbCommitted.Clear;
  clbUncommitted.Clear;
  OKBtn.Enabled := false;
end;

function TAzPutBlockList.GetCacheControl: String;
begin
  Result := edtCacheControl.Text;
end;

function TAzPutBlockList.GetContentEncoding: String;
begin
  Result := edtEncoding.Text;
end;

function TAzPutBlockList.GetContentLanguage: String;
begin
  Result := edtLanguage.Text;
end;

function TAzPutBlockList.GetContentMD5: String;
begin
  Result := edtMD5.Text;
end;

function TAzPutBlockList.GetContentType: String;
begin
  Result := edtContentType.Text;
end;

procedure TAzPutBlockList.PopulateWithMetadata(
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

function TAzPutBlockList.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings
end;

end.
