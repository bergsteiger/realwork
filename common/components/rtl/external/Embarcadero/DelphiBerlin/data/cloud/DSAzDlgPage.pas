{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgPage;

interface

uses Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls, System.SysUtils;

type
  TAzPage = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    lbStartByte: TLabel;
    edtStartByte: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPageCount: TEdit;
    rgOperation: TRadioGroup;
    gbCriteria: TGroupBox;
    lblMD5: TLabeledEdit;
    lblLease: TLabeledEdit;
    lblSequence: TLabel;
    cbSequenceOp: TComboBox;
    edtSequence: TEdit;
    Label3: TLabel;
    cbSince: TComboBox;
    edtSince: TEdit;
    lblIf: TLabel;
    cbMatch: TComboBox;
    edtMatch: TEdit;
    lblContentLocation: TLabeledEdit;
    btnExplorer: TButton;
    procedure btnExplorerClick(Sender: TObject);
  private
    { Private declarations }
  public
    function GetContentMD5: String;
    function GetPageWrite: String;
    function GetLeaseID: String;
    procedure SetLeaseID(LeaseId: String);
    function GetSequenceNumberLte: String;
    function GetSequenceNumberLt: String;
    function GetSequenceNumberEq: String;
    function GetModifiedSince: String;
    function GetUnmodifiedSince: String;
    function IfMatch: String;
    function IfNoneMatch: String;
    function FirstByte: Int64;
    function EndByte: Int64;
    function Content: TArray<Byte>;
  end;

implementation

uses Vcl.Dialogs;

{$R *.dfm}

procedure TAzPage.btnExplorerClick(Sender: TObject);
var
  foDlg: TOpenDialog;
  fs: TFileStream;
begin
  foDlg := TOpenDialog.Create(self);
  if foDlg.Execute(Handle) then
  begin
    lblContentLocation.Text := foDlg.FileName;
    fs := TFileStream.Create(foDlg.FileName, fmOpenRead);
    edtPageCount.Text := IntToStr((fs.Size div 512)+ 1);
    fs.Free;
  end;
  foDlg.Free;
end;

function TAzPage.Content: TArray<Byte>;
var
  fs: TFileStream;

begin
  if Length(lblContentLocation.Text) > 0 then
  begin
    fs := TFileStream.Create(lblContentLocation.Text, fmOpenRead);
    try
      SetLength(Result, ((fs.Size div 512) + 1) * 512);
      fs.ReadBuffer(Result[0], fs.Size);
    finally
      fs.Free;
    end
  end;
end;

function TAzPage.EndByte: Int64;
begin
  Result := (StrToInt64(edtStartByte.Text) + StrToInt64(edtPageCount.Text)) * 512 - 1;
end;

function TAzPage.FirstByte: Int64;
begin
  Result := StrToInt64(edtStartByte.Text) * 512;
end;

function TAzPage.GetContentMD5: String;
begin
  Result := lblMD5.Text;
end;

function TAzPage.GetLeaseID: String;
begin
  Result := lblLease.Text;
end;

procedure TAzPage.SetLeaseID(LeaseId: String);
begin
  lblLease.Text := LeaseId;
end;

function TAzPage.GetModifiedSince: String;
begin
  Result := '';
  if cbSince.ItemIndex = 0 then
    Result := edtSince.Text;
end;

function TAzPage.GetPageWrite: String;
begin
  if rgOperation.ItemIndex = 0 then
    Result := 'update'
  else
    Result := 'clear';
end;

function TAzPage.GetSequenceNumberEq: String;
begin
  Result := '';
  if cbSequenceOp.ItemIndex = 2 then
    Result := edtSequence.Text
end;

function TAzPage.GetSequenceNumberLt: String;
begin
  Result := '';
  if cbSequenceOp.ItemIndex = 1 then
    Result := edtSequence.Text
end;

function TAzPage.GetSequenceNumberLte: String;
begin
  Result := '';
  if cbSequenceOp.ItemIndex = 0 then
    Result := edtSequence.Text
end;

function TAzPage.GetUnmodifiedSince: String;
begin
  Result := '';
  if cbSince.ItemIndex = 1 then
    Result := edtSince.Text;
end;

function TAzPage.IfMatch: String;
begin
  Result := '';
  if cbMatch.ItemIndex = 0 then
    Result := edtMatch.Text
end;

function TAzPage.IfNoneMatch: String;
begin
  Result := '';
  if cbMatch.ItemIndex = 1 then
    Result := edtMatch.Text
end;
end.
