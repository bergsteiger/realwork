unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  XpParser, StdCtrls, ComCtrls, XpBase;

type
  TfrmMain = class(TForm)
    btnParse: TButton;
    memo: TRichEdit;
    edtFile: TEdit;
    fodXMLDoc: TOpenDialog;
    btnOpenFile: TButton;
    Label1: TLabel;
    Parser: TXpParser;
    procedure btnParseClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure ParserAttribute(oOwner: TObject; sName, sValue: WideString;
      bSpecified: Boolean);
    procedure ParserStartElement(oOwner: TObject; sValue: WideString);
    procedure ParserEndElement(oOwner: TObject; sValue: WideString);
    procedure ParserCharData(oOwner: TObject; sValue: WideString);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnParseClick(Sender: TObject);
begin
  Memo.Lines.Clear;
  if edtFile.Text <> '' then begin
    if not Parser.ParseDataSource(edtFile.Text) then
      Memo.Lines.Assign(Parser.Errors);
  end else
    ShowMessage('You must select an XML document to parse.');
end;

procedure TfrmMain.btnOpenFileClick(Sender: TObject);
begin
  fodXMLDoc.Execute;
  edtFile.Text := fodXMLDoc.FileName;
end;

procedure TfrmMain.ParserAttribute(oOwner: TObject; sName,
  sValue: WideString; bSpecified: Boolean);
begin
  if sName = 'FontName' then
    Memo.SelAttributes.Name := sValue
  else if sName = 'PointSize' then
    Memo.SelAttributes.Size := StrToInt(sValue)
  else if sName = 'Color' then
    Memo.SelAttributes.Color := StrToInt(sValue);
end;

procedure TfrmMain.ParserStartElement(oOwner: TObject; sValue: WideString);
begin
  if sValue = 'B' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style + [fsBold];
  if sValue = 'I' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style + [fsItalic];
  if sValue = 'U' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style + [fsUnderline];
end;

procedure TfrmMain.ParserEndElement(oOwner: TObject; sValue: WideString);
begin
  if sValue = 'B' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style - [fsBold];
  if sValue = 'I' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style - [fsItalic];
  if sValue = 'U' then
    Memo.SelAttributes.Style := Memo.SelAttributes.Style - [fsUnderline];
end;

procedure TfrmMain.ParserCharData(oOwner: TObject; sValue: WideString);
begin
  Memo.SelLength := 0;
  Memo.SelText := sValue;
end;

end.
