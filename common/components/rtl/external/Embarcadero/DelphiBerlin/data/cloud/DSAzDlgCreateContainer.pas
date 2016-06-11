{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgCreateContainer;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, System.Generics.Collections, Vcl.Graphics,
  Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzCreateContainerDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    GridPanel1: TGridPanel;
    FlowPanel1: TFlowPanel;
    lbName: TLabel;
    edtContainerName: TEdit;
    rgPublicDataAccess: TRadioGroup;
    vleMeta: TValueListEditor;
    btnAddMetadata: TButton;
    btnDelMetadata: TButton;
    procedure OKBtnClick(Sender: TObject);
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure edtContainerNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PopulateWithMetadata(const meta: TDictionary<String, String>);
    procedure AssignMetadata(const meta: TDictionary<String, String>);
    procedure SetContainerName(const Name: String; Enabled: boolean = true);
    function GetContainerName: String;
    procedure SetPublicDataAccess(const DataAccess: String);
    function GetPublicDataAccess: String;
    procedure SetTitle(const Title: String);
    function RawMetadata: TStrings;

    property PublicDataAccess: String read GetPublicDataAccess write SetPublicDataAccess;
  end;

implementation

{$R *.dfm}

{ TAzCreateContainerDlg }

procedure TAzCreateContainerDlg.AssignMetadata(
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

procedure TAzCreateContainerDlg.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
end;

procedure TAzCreateContainerDlg.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
    vleMeta.DeleteRow(row);
end;

procedure TAzCreateContainerDlg.edtContainerNameChange(Sender: TObject);
begin
  OKBtn.Enabled := Length(edtContainerName.Text) > 0;
end;

function TAzCreateContainerDlg.GetContainerName: String;
begin
  Result := edtContainerName.Text;
end;

function TAzCreateContainerDlg.GetPublicDataAccess: String;
begin
  if rgPublicDataAccess.ItemIndex = 0 then
    Result := 'container'
  else if rgPublicDataAccess.ItemIndex = 1 then
    Result := 'blob'
  else
    Result := '';
end;

procedure TAzCreateContainerDlg.OKBtnClick(Sender: TObject);
begin
                   
  CloseModal;
end;

procedure TAzCreateContainerDlg.PopulateWithMetadata(
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

function TAzCreateContainerDlg.RawMetadata: TStrings;
begin
  Result := vleMeta.Strings;
end;

procedure TAzCreateContainerDlg.SetContainerName(const Name: String;
  Enabled: boolean);
begin
  edtContainerName.Text := Name;
  edtContainerName.Enabled := Enabled;
end;

procedure TAzCreateContainerDlg.SetPublicDataAccess(const DataAccess: String);
begin
  if DataAccess = 'container' then
    rgPublicDataAccess.ItemIndex := 0
  else
    rgPublicDataAccess.ItemIndex := 1;
end;

procedure TAzCreateContainerDlg.SetTitle(const Title: String);
begin
  Caption := Title;
end;

end.
