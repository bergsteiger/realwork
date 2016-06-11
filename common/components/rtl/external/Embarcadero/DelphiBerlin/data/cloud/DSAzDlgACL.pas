{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgACL;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, DSAzure, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.Grids,
  Vcl.StdCtrls;

type
  TAzACL = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    rgPublicDataAccess: TRadioGroup;
    sgId: TStringGrid;
    cbxRead: TCheckBox;
    cbxDelete: TCheckBox;
    cbxWrite: TCheckBox;
    cbxList: TCheckBox;
    gbxAccessPolicy: TGroupBox;
    lbeStart: TLabeledEdit;
    lbeExpiry: TLabeledEdit;
    gbxIdentifiers: TGroupBox;
    procedure sgIdSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure sgIdSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgIdGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure FormCreate(Sender: TObject);
    procedure lbeStartChange(Sender: TObject);
    procedure lbeExpiryChange(Sender: TObject);
    procedure cbxReadClick(Sender: TObject);
    procedure cbxWriteClick(Sender: TObject);
    procedure cbxDeleteClick(Sender: TObject);
    procedure cbxListClick(Sender: TObject);
    procedure rgPublicDataAccessClick(Sender: TObject);
  private
    { Private declarations }
    FAPArray: TAccessPolicyArray;
    FIndex: Integer;
    FLastValidIdentifier: String;

    procedure MoveIndex(NewIndex: Integer);
    procedure SetPublicDataAccess(const Access: string);
    function GetPublicDataAccess: string;
    function GetAccessPolicy(idx: Integer): TAccessPolicy;
    function GetIdentifier(idx: Integer): string;
    function GetCount: Integer;
    procedure DeleteRow(ARow: Integer);
    function GetRawIdentifier(idx: Integer): string;

  public
    { Public declarations }
    procedure SetAccessPolicyLength(Size: Integer);
    procedure SetAccessPolicy(Index: Integer; const Id: string; AP: TAccessPolicy);
    procedure SetBaseline;
    procedure MoveToRow(ARow: Integer);

    property PublicDataAccess: string read GetPublicDataAccess write SetPublicDataAccess;
    property AccessPolicy[idx: Integer]: TAccessPolicy read GetAccessPolicy;
    property Identifier[idx: Integer]: string read GetIdentifier;
    property RawIdentifier[idx: Integer]: string read GetRawIdentifier;
    property Count: Integer read GetCount;
  end;

implementation

uses Data.DBXClientResStrs, Vcl.Dialogs, System.SysUtils, System.UITypes;

{$R *.dfm}

{ TAzACL }

procedure TAzACL.cbxDeleteClick(Sender: TObject);
begin
  FAPArray[FIndex].PermDelete := cbxDelete.Checked;
  OKBtn.Enabled := true;
end;

procedure TAzACL.cbxListClick(Sender: TObject);
begin
  FAPArray[FIndex].PermList := cbxList.Checked;
  OKBtn.Enabled := true;
end;

procedure TAzACL.cbxReadClick(Sender: TObject);
begin
  FAPArray[FIndex].PermRead := cbxRead.Checked;
  OKBtn.Enabled := true;
end;

procedure TAzACL.cbxWriteClick(Sender: TObject);
begin
  FAPArray[FIndex].PermWrite := cbxWrite.Checked;
  OKBtn.Enabled := true;
end;

procedure TAzACL.DeleteRow(ARow: Integer);
begin
  if (ARow < (sgId.RowCount - 1)) and (sgId.Cells[0, ARow+1] <> EmptyStr) then
  begin
    while ARow < sgId.RowCount - 1 do
    begin
      sgId.Cells[0, ARow] := sgId.Cells[0, ARow + 1];
      FAPArray[ARow] := FAPArray[ARow + 1];
      Inc(ARow);
    end;
    sgId.Cells[0, ARow] := EmptyStr;
  end;
end;

procedure TAzACL.FormCreate(Sender: TObject);
begin
  SetLength(FAPArray, sgId.RowCount);
end;

function TAzACL.GetAccessPolicy(idx: Integer): TAccessPolicy;
begin
  Result := FAPArray[idx];
end;

function TAzACL.GetCount: Integer;
begin
  Result := Length(FAPArray);
end;

function TAzACL.GetIdentifier(idx: Integer): string;
begin
  Result := TAzureService.Encode(sgId.Cells[0, idx]);
end;

function TAzACL.GetPublicDataAccess: string;
begin
  case rgPublicDataAccess.ItemIndex of
  0: Result := 'container';
  1: Result := 'blob';
  else
    Result := '';
  end;
end;

function TAzACL.GetRawIdentifier(idx: Integer): string;
begin
  Result := sgId.Cells[0, idx];
end;

procedure TAzACL.lbeExpiryChange(Sender: TObject);
begin
  FAPArray[FIndex].Expiry := lbeExpiry.Text;
  OKBtn.Enabled := true;
end;

procedure TAzACL.lbeStartChange(Sender: TObject);
begin
  FAPArray[FIndex].Start := lbeStart.Text;
  OKBtn.Enabled := true;
end;

procedure TAzACL.MoveIndex(NewIndex: Integer);
begin
  FIndex := NewIndex;
  cbxRead.Checked := FAPArray[FIndex].PermRead;
  cbxWrite.Checked := FAPArray[FIndex].PermWrite;
  cbxDelete.Checked := FAPArray[FIndex].PermDelete;
  cbxList.Checked := FAPArray[FIndex].PermList;
  lbeStart.Text := FAPArray[FIndex].Start;
  lbeExpiry.Text := FAPArray[FIndex].Expiry;
end;

procedure TAzACL.MoveToRow(ARow: Integer);
begin
  if sgId.Cells[0, ARow] = EmptyStr then
  begin
    gbxAccessPolicy.Caption := SNewPolicyCaption;
    FAPArray[ARow] := TAccessPolicy.Create;
  end else
    gbxAccessPolicy.Caption := sgId.Cells[0, ARow];
  MoveIndex(ARow);
end;

procedure TAzACL.rgPublicDataAccessClick(Sender: TObject);
begin
  OKBtn.Enabled := true;
end;

procedure TAzACL.SetAccessPolicy(Index: Integer; const Id: string;
  AP: TAccessPolicy);
begin
  FAPArray[Index] := AP;
  sgId.Cells[0, Index] := TAzureService.Decode(Id);
end;

procedure TAzACL.SetAccessPolicyLength(Size: Integer);
begin
  SetLength(FAPArray, Size);
end;

procedure TAzACL.SetBaseline;
begin
  OKBtn.Enabled := false;
end;

procedure TAzACL.SetPublicDataAccess(const Access: string);
begin
  if 'blob' = Access then
    rgPublicDataAccess.ItemIndex := 1
  else if 'container' = Access then
    rgPublicDataAccess.ItemIndex := 0
  else if EmptyStr = Access then
    rgPublicDataAccess.ItemIndex := 2
  else
    rgPublicDataAccess.ItemIndex := -1
end;

procedure TAzACL.sgIdGetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  MoveToRow(ARow);
  FLastValidIdentifier := Value;
end;

procedure TAzACL.sgIdSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if ARow > 0 then
    CanSelect := sgId.Cells[ACol, ARow-1] <> EmptyStr;
  if CanSelect then
  begin
    MoveToRow(ARow);
    FLastValidIdentifier := sgId.Cells[ACol, ARow];
  end;
end;

procedure TAzACL.sgIdSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  if ARow = FIndex then
  begin
    if Value = EmptyStr then
    begin
      if MessageDlg(Format(SAreYouSurePolicy, [ARow+1]), mtWarning, [mbYes, mbNo], 0) = mrYes then
      begin
        DeleteRow(ARow);
        MoveToRow(ARow);
      end else
        sgId.Cells[ACol, ARow] := FLastValidIdentifier;
    end else
      FLastValidIdentifier := Value;
    gbxAccessPolicy.Caption := sgId.Cells[ACol, ARow];
    OKBtn.Enabled := true;
  end;
end;

end.
