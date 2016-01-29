unit uContentExtraction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, PDFtoolkitUsage, ShellAPI, gtWideStrings, gtExProPDFDoc;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edExtractionSave: TEdit;
    btnOpenTxtfile: TButton;
    btnExtractText: TButton;
    cbExtractPageno: TComboBox;
    Label13: TLabel;
    Label75: TLabel;
    edPDFfilename: TEdit;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnReset: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnOpenTxtfileClick(Sender: TObject);
    procedure btnExtractTextClick(Sender: TObject);
    procedure btnLoadPDFClick(Sender: TObject);
    procedure PopulatePageno(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);

    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnOpenTxtfileClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  edExtractionSave.Text := SaveDialog1.FileName + '.txt';
end;

procedure TForm1.btnExtractTextClick(Sender: TObject);
var
  LTextResult: TgtWideStringList;
  LStream: TFileStream;
  LBuf: widestring;
  I: Integer;
begin
  try
    LTextResult := ExtractTextFormatted(gtPDFDocument1, cbExtractPageno.ItemIndex + 1);
    LStream := TFileStream.Create(edExtractionSave.Text, fmCreate);
    for I := 0 to LTextResult.Count - 1 do
    begin
      LBuf := LTextResult.Strings[I] + #13#10;;
      LStream.Write(LBuf[1], (Length(LBuf) * Sizeof(WideChar)));
    end;
    LStream.Free;
    LTextResult.Free;
    ShellExecute(Application.Handle, 'Open', PChar(edExtractionSave.Text), nil, nil, SW_SHOWNORMAL);
  except
    //
  end;
end;
procedure TForm1.PopulatePageno(Sender: TObject);
var
  Li: Integer;
begin
  if (Sender is TComboBox) then
  begin
  (Sender as TComboBox).Clear;
    for Li := 0 to gtPDFDocument1.PageCount - 1 do
    begin
      (Sender as TComboBox).Items.Add(IntToStr(Li + 1));
    end;
  end;
end;





procedure TForm1.btnLoadPDFClick(Sender: TObject);
begin
   if OpenDialog1.Execute then
  begin
    gtPDFDocument1.LoadFromFile(OpenDialog1.FileName);
    edPDFfilename.Text := OpenDialog1.FileName;
    PopulatePageno(cbExtractPageno);
    cbExtractPageno.ItemIndex := 0;
    end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbExtractPageno.Clear;
  ResetControls(Form1);
end;

procedure TForm1.ResetControls(Sender: TObject);
var
  cntrlCnt: Integer;
begin
  if (Sender is TWinControl) then
  begin
    for cntrlCnt := 0 to TWinControl(Sender).ControlCount - 1 do
    begin
      if TWinControl(Sender).ContainsControl(TWinControl(Sender).Controls[cntrlCnt]) then
      begin
        ResetControls(TWinControl(Sender).Controls[cntrlCnt]);
      end;
      if (TWinControl(Sender).Controls[cntrlCnt] is TEdit) then
        (TWinControl(Sender).Controls[cntrlCnt] As TEdit).Text := ''
      else if (TWinControl(Sender).Controls[cntrlCnt] is TCheckBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TCheckBox).Checked := False
      else if (TWinControl(Sender).Controls[cntrlCnt] is TComboBox) then
        (TWinControl(Sender).Controls[cntrlCnt] As TComboBox).ItemIndex := 0;
    end;
  end;
  edPDFfilename.Text := '';
end;


end.
