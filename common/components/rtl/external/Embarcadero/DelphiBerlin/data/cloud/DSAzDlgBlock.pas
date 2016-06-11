{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzDlgBlock;

interface

uses Vcl.Buttons, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.StdCtrls, System.SysUtils;

type
  TAzBlock = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    lblBlockId: TLabeledEdit;
    lblMD5: TLabeledEdit;
    lblLeaseId: TLabeledEdit;
    lblLocation: TLabeledEdit;
    btnFile: TButton;
    procedure btnFileClick(Sender: TObject);
  private
    { Private declarations }
    function GetBlockId: String;
    procedure SetBlockId(const Data: String);
    function GetLeaseId: String;
    procedure SetLeaseId(const Id: String);
    function GetMD5: String;
    procedure SetMD5(const Val: String);
    function GetLocation: String;
    procedure SetLocation(const Data: String);
  public
    { Public declarations }

    function Content: TArray<Byte>;

    property BlockId: String read GetBlockId write SetBlockId;
    property Location: String read GetLocation write SetLocation;
    property MD5: String read GetMD5 write SetMD5;
    property LeaseId: String read GetLeaseId write SetLeaseId;
  end;

implementation

uses Data.DBXClientResStrs, System.UITypes, Vcl.Dialogs, DSAzure;

{$R *.dfm}

procedure TAzBlock.btnFileClick(Sender: TObject);
var
  foDlg: TOpenDialog;
  fs: TFileStream;
begin
  foDlg := TOpenDialog.Create(self);
  if foDlg.Execute(Handle) then
  begin
    fs := TFileStream.Create(foDlg.FileName, fmOpenRead);
    try
      if fs.Size >= 4*1024*1024 then
        MessageDlg(SMaxSizeBlock, mtError, [mbOK], 0)
      else
        lblLocation.Text := foDlg.FileName;
    finally
      fs.Free;
    end;
  end;
  foDlg.Free;
end;

function TAzBlock.Content: TArray<Byte>;
var
  fs: TFileStream;

begin
  if Length(lblLocation.Text) > 0 then
  begin
    fs := TFileStream.Create(lblLocation.Text, fmOpenRead);
    try
      SetLength(Result, fs.Size);
      fs.ReadBuffer(Result[0], fs.Size);
    finally
      fs.Free;
    end
  end;
end;

function TAzBlock.GetBlockId: String;
begin
  Result := TAzureService.Encode(lblBlockId.Text);
end;

function TAzBlock.GetLeaseId: String;
begin
  Result := lblLeaseId.Text;
end;

function TAzBlock.GetLocation: String;
begin
  Result := lblLocation.Text;
end;

function TAzBlock.GetMD5: String;
begin
  Result := lblMD5.Text;
end;

procedure TAzBlock.SetBlockId(const Data: String);
begin
  lblBlockId.Text := TAzureService.Decode(Data);
end;

procedure TAzBlock.SetLeaseId(const Id: String);
begin
  lblLeaseId.Text := Id;
end;

procedure TAzBlock.SetLocation(const Data: String);
begin
  lblLocation.Text := Data;
end;

procedure TAzBlock.SetMD5(const Val: String);
begin
  lblMD5.Text := Val;
end;

end.
