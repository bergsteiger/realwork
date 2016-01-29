unit uConvert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc, ShellAPI,
  gtPDFDoc, PDFtoolkitUsage, ExtCtrls, jpeg, gtExProPDFDoc;


type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbFormat: TComboBox;
    chkOpenAfterCreate: TCheckBox;
    btnConvert: TButton;
    cbConvertPageno: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label75: TLabel;
    edPDFfilename: TEdit;
    edSavePDFTo: TEdit;
    btnSaveFileName: TButton;
    btnLoadPDF: TButton;
    gtPDFDocument1: TgtPDFDocument;
    OpenDialog1: TOpenDialog;
    btnReset: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnLoadPDFClick(Sender: TObject);
    procedure btnSaveFileNameClick(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
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
    PopulatePageno(cbConvertPageno);
    cbConvertPageno.ItemIndex := 0;
  end;
end;

procedure TForm1.btnSaveFileNameClick(Sender: TObject);
begin
   if SaveDialog1.Execute then
  begin
    edSavePDFTo.Text := SaveDialog1.FileName;
  end;
end;

procedure TForm1.btnConvertClick(Sender: TObject);
var
  LBitmap: TBitmap;
  LJpeg: TJPEGImage;
//  LEMF: TMetafile;
//  LMetaFileCanvas: TMetafileCanvas;
  LPageSize: TgtPageSize;
  ASaveFileName: string;
  LStream: TMemoryStream;
begin
  if Assigned(gtPDFDocument1) then
  begin
    LPageSize := gtPDFDocument1.GetPageSize(cbConvertPageno.ItemIndex + 1,muPixels);
    if cbFormat.ItemIndex = 0 then
    begin
      LBitmap := TBitmap.Create;
      try
        LBitmap.PixelFormat := pf24bit;
        LBitmap.Width := Round(LPageSize.Width);
        LBitmap.Height := Round(LPageSize.Height);
        gtPDFDocument1.RenderToDC(LBitmap.Canvas.Handle, LBitmap.Width,
          LBitmap.Height, cbConvertPageno.ItemIndex + 1, Screen.PixelsPerInch,
          Screen.PixelsPerInch);
        ASaveFileName := edSavePDFTo.Text + IntToStr(cbConvertPageno.ItemIndex + 1) +'.bmp';

        LBitmap.SaveToFile(ASaveFileName);
      finally
        LBitmap.Free;
      end;
    end
    else if cbFormat.ItemIndex = 1 then
    begin
     LJpeg := TJPEGImage.Create;
     LBitmap := TBitmap.Create;
     try
       LBitmap.Width := Round(LPageSize.Width);
       LBitmap.Height := Round(LPageSize.Height);
        gtPDFDocument1.RenderToDC(LBitmap.Canvas.Handle, LBitmap.Width,
          LBitmap.Height, cbConvertPageno.ItemIndex + 1, Screen.PixelsPerInch,
          Screen.PixelsPerInch);
       LJpeg.Assign(LBitmap);
       ASaveFileName := 'C:\Page'+IntToStr(cbConvertPageno.ItemIndex + 1)+'.jpeg';
       LJpeg.SaveToFile(ASaveFileName);
     finally
       LJpeg.Free;
       LBitmap.Free;
     end;
    end
    else if cbFormat.ItemIndex = 2 then
    begin
     try
      LStream := TMemoryStream.Create;
      gtPDFDocument1.RenderToStream(LStream, cbConvertPageno.ItemIndex + 1,
        LPageSize.Width, LPageSize.Height, 72, 72, 0, True, False);
      ASaveFileName := 'Page'+IntToStr(cbConvertPageno.ItemIndex +
        1)+'.emf';
      LStream.Position := 0;
      LStream.SaveToFile(ASaveFileName);
     finally
//
     end;
    end;
    if chkOpenAfterCreate.Checked then
          ShellExecute(Application.Handle, 'Open', PChar(ASaveFileName), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
  if Assigned(gtPDFDocument1) then
  begin
    gtPDFDocument1.Reset;
  end;
  cbConvertPageno.Clear;
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
