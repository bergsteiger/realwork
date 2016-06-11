{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgMetadata;

interface

uses Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.Grids, Vcl.StdCtrls, Vcl.ValEdit;

type
  TAzMetadata = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    vleMeta: TValueListEditor;
    btnDelMetadata: TButton;
    btnAddMetadata: TButton;
    procedure btnAddMetadataClick(Sender: TObject);
    procedure btnDelMetadataClick(Sender: TObject);
    procedure vleMetaStringsChange(Sender: TObject);
  private
    { Private declarations }
    function IsMetadata(const Data: String): boolean;
    function MetadataName(const Data: String): string;
    function ShortName(const xmsData: String): String;
  public
    { Public declarations }
    procedure PopulateContentFromHeader(const header: TStrings; AChange: boolean = false);
    procedure PopulateHeaderFromContainer(const header: TStrings);
  end;

implementation

const XMSMETA = 'x-ms-meta-';

{$R *.dfm}

procedure TAzMetadata.btnAddMetadataClick(Sender: TObject);
begin
  vleMeta.Col := 0;
  vleMeta.Row := vleMeta.InsertRow('', '', true);
  vleMeta.SetFocus;
  OKBtn.Enabled := true;
end;

procedure TAzMetadata.btnDelMetadataClick(Sender: TObject);
var
  row: Integer;
begin
  row := vleMeta.Row;
  if (row > 0) and (row < vleMeta.RowCount) then
  begin
    vleMeta.DeleteRow(row);
    OKBtn.Enabled := true;
  end;
end;

function TAzMetadata.IsMetadata(const Data: String): boolean;
begin
  Result := Pos(XMSMETA, Data) = 1;
end;

function TAzMetadata.MetadataName(const Data: String): string;
begin
  Result := XMSMETA + Data;
end;

procedure TAzMetadata.PopulateContentFromHeader(const header: TStrings; AChange: boolean);
var
  i, count: Integer;
begin
  count := header.Count;
  vleMeta.Strings.BeginUpdate;
  vleMeta.Strings.Clear;
  for i := 0 to count - 1 do
  begin
    if IsMetadata(header.Names[i]) then
      vleMeta.Strings.Values[ShortName(header.Names[i])] := header.ValueFromIndex[i];
  end;
  vleMeta.Strings.EndUpdate;

  OKBtn.Enabled := AChange;
end;

procedure TAzMetadata.PopulateHeaderFromContainer(const header: TStrings);
var
  i, count: Integer;
begin
  header.Clear;
  count := vleMeta.Strings.Count;
  for i := 0 to count - 1 do
    header.Values[MetadataName(vleMeta.Strings.Names[i])] := vleMeta.Strings.ValueFromIndex[i];
end;

function TAzMetadata.ShortName(const xmsData: String): String;
begin
  Result := Copy(xmsData, Length(XMSMETA) + 1);
end;

procedure TAzMetadata.vleMetaStringsChange(Sender: TObject);
begin
  OKBtn.Enabled := true;
end;

end.
