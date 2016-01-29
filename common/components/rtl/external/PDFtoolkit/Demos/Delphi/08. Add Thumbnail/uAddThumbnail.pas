unit uAddThumbnail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, gtPDFDoc,
  StdCtrls, ComCtrls, jpeg, PDFtoolkitUsage;

type
  TForm1 = class(TForm)
    Label13: TLabel;
    Label75: TLabel;
    Label14: TLabel;
    edPDFfilename: TEdit;
    btnLoadPDF: TButton;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnSave: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    pgncntrlEnhancement: TPageControl;
    tbshBookMark: TTabSheet;
    tbshThumbnail: TTabSheet;
    GroupBox11: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    btnAddthumbnail: TButton;
    edImageName: TEdit;
    btnOpenImage: TButton;
    cbThumbPageNo: TComboBox;
    btnReset: TButton;
    cbOpenAfterCreate: TCheckBox;
    SaveDialog1: TSaveDialog;
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnOpenImageClick(Sender: TObject);
    procedure btnAddthumbnailClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure ResetControls(Sender: TObject);
    
  private
    { Private declarations }
  public
    procedure PopulatePageno(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
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
    PopulatePageno(cbThumbPageNo);
    cbThumbPageNo.ItemIndex := 0;
  end;
end;

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  if (cbOpenAfterCreate.Checked) then
    gtPDFDocument1.OpenAfterSave := True
  else
    gtPDFDocument1.OpenAfterSave := False;
  gtPDFDocument1.SaveToFile(edSavePDFTo.Text);
  btnResetClick(Self);
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnOpenImageClick(Sender: TObject);
begin
  OpenDialog1.Filter := '*.bmp';
  OpenDialog1.Execute;
  edImageName.Text := OpenDialog1.FileName;
end;

procedure TForm1.btnAddthumbnailClick(Sender: TObject);
var
  LImage: TBitmap;
  LJPEG: TJPEGImage;
  LExt: string;
begin
  try
    if Assigned(gtPDFDocument1) then
    begin
      try
        {Adds thumbnail to the specified page, even JPEG could be added}
        LExt := ExtractFileExt(Trim(edImageName.Text));
        LImage := TBitmap.Create;
        if( LExt = '.bmp') or (LExt = '.BMP')then
        begin
          LImage.LoadFromFile(Trim(edImageName.Text));
          AddThumbnail(gtPDFDocument1,LImage,cbThumbPageNo.ItemIndex + 1);
        end;
         if( LExt = '.jpeg') or (LExt = '.JPEG') or (LExt = '.jpg') or (LExt = '.JPG')then
        begin
          LJPEG := TJPEGImage.Create;
          LJPEG.LoadFromFile(Trim(edImageName.Text));
          AddThumbnail(gtPDFDocument1,LJPEG,cbThumbPageNo.ItemIndex + 1);
          LJPEG.Free;
        end;
      finally
        if Assigned(LImage) then
          LImage.free;
      end;
    end;
  except
    //
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbThumbPageNo.Clear;
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
  edSavePDFTo.Text := 'C:\Output.pdf';
  edPDFfilename.Text := '';
end;



end.
