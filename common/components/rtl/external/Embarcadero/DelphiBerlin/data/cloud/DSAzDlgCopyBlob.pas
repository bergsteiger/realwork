{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgCopyBlob;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzCopyBlob = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    gbDestination: TGroupBox;
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
    lbeDestContainer: TLabeledEdit;
    lbeDestBlob: TLabeledEdit;
    gbSource: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtSrcMod: TEdit;
    edtSrcUnmod: TEdit;
    edtSrcNoneMatch: TEdit;
    edtSrcMatch: TEdit;
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure lbeDestContainerChange(Sender: TObject);
  private
    { Private declarations }
    procedure ValidateCopy;

  public
    { Public declarations }
    function GetSrcModifiedSince: String;
    function GetSrcUnmodifiedSince: String;
    function GetSrcMatch: String;
    function GetSrcNoneMatch: String;

    function GetDestContainer: String;
    procedure SetDestContainer(const Name: String);
    function GetDestBlob: String;
    function GetDestModifiedSince: String;
    function GetDestUnmodifiedSince: String;
    function GetDestMatch: String;
    function GetDestNoneMatch: String;

    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    function RawMetadata: TStrings;

    property DestContainer: string read GetDestContainer write SetDestContainer;
  end;

implementation

uses Vcl.Dialogs;

{$R *.dfm}

procedure TAzCopyBlob.AssignMetadata(
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


procedure TAzCopyBlob.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzCopyBlob.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

function TAzCopyBlob.GetDestModifiedSince: String;
begin
  Result := edtModifiedSince.Text;
end;

function TAzCopyBlob.GetDestUnmodifiedSince: String;
begin
  Result := edtUnmodified.Text;
end;

function TAzCopyBlob.GetSrcMatch: String;
begin
 Result := edtSrcMatch.Text;
end;

function TAzCopyBlob.GetSrcModifiedSince: String;
begin
 Result := edtSrcMod.Text;
end;

function TAzCopyBlob.GetSrcNoneMatch: String;
begin
 Result := edtSrcNoneMatch.Text
end;

function TAzCopyBlob.GetSrcUnmodifiedSince: String;
begin
 Result := edtSrcUnmod.Text;
end;

procedure TAzCopyBlob.lbeDestContainerChange(Sender: TObject);
begin
  ValidateCopy;
end;

function TAzCopyBlob.GetDestBlob: String;
begin
  Result := lbeDestBlob.Text;
end;

function TAzCopyBlob.GetDestContainer: String;
begin
  Result := lbeDestContainer.Text;
end;

function TAzCopyBlob.GetDestMatch: String;
begin
  Result := edtMatch.Text;
end;

function TAzCopyBlob.GetDestNoneMatch: String;
begin
  Result := edtNoneMatch.Text;
end;

procedure TAzCopyBlob.PopulateWithMetadata(
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

function TAzCopyBlob.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings
end;

procedure TAzCopyBlob.SetDestContainer(const Name: String);
begin
  lbeDestContainer.Text := Name
end;

procedure TAzCopyBlob.ValidateCopy;
begin
  OKBtn.Enabled := (Length(lbeDestContainer.Text) > 0) and
                   (Length(lbeDestBlob.Text) > 0);
end;

end.
