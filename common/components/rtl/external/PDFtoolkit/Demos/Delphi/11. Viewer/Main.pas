unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, gtPDFViewer, ComCtrls, gtAboutBoxDlg,
  Password, gtPDFConsts,gtPDFPrinter, gtPDFOutlineViewer, gtPDFClasses,
  gtCstPDFDoc, gtExPDFDoc, gtExProPDFDoc, gtPDFDoc, gtCrypt,
  gtPDFSearchPanel, ImgList,gtScrollingPanel, gtViewerTypes;

const

  ZoomIncrement = 25;

type
  TfrmPDFViewerDemo = class(TForm)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    BtnActive: TSpeedButton;
    BtnPrint: TSpeedButton;
    BtnFitPage: TSpeedButton;
    BtnActualSize: TSpeedButton;
    BtnFirstPage: TSpeedButton;
    BtnPriorPage: TSpeedButton;
    BtnNextPage: TSpeedButton;
    BtnLastPage: TSpeedButton;
    Label1: TLabel;
    EdtGotoPage: TEdit;
    SbPageNo: TStatusBar;
    BtnOpenfile: TSpeedButton;
    Timer1: TTimer;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    btnFitWidth: TSpeedButton;
    BtnZoomOut: TSpeedButton;
    BtnZoomIn: TSpeedButton;
    edZoom: TEdit;
    SearchButton: TSpeedButton;
    gtPDFOutlineViewer1: TgtPDFOutlineViewer;
    Splitter1: TSplitter;
    gtPDFSearchPanel1: TgtPDFSearchPanel;
    Splitter2: TSplitter;
    BtnClkRotate: TSpeedButton;
    BtnResetRotate: TSpeedButton;
    ImageList1: TImageList;
    Panel3: TPanel;
    Label2: TLabel;
    gtPDFDocument1: TgtPDFDocument;
    procedure BtnActiveClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnFirstPageClick(Sender: TObject);
    procedure BtnPriorPageClick(Sender: TObject);
    procedure BtnNextPageClick(Sender: TObject);
    procedure BtnLastPageClick(Sender: TObject);
    procedure BtnFitPageClick(Sender: TObject);
    procedure BtnActualSizeClick(Sender: TObject);
    procedure BtnOpenfileClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    function UpdateButton: string;
    procedure UpdateStatusBar;
    procedure EdtGotoPageKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

    procedure btnFitWidthClick(Sender: TObject);
    procedure edZoomKeyPress(Sender: TObject; var Key: Char);
    procedure edZoomChange(Sender: TObject);
    procedure BtnZoomOutClick(Sender: TObject);
    procedure BtnZoomInClick(Sender: TObject);
    procedure edZoomExit(Sender: TObject);
    procedure gtPDFDocument1Password(Sender: TObject; var Password: String;
      var Continue: Boolean; const Tries: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);              
    procedure gtPDFViewer1ViewerChange(Sender: TgtPDFViewer;
      const CurrentIndex: TPageIndex);
    procedure BtnClkRotateClick(Sender: TObject);
    procedure BtnResetRotateClick(Sender: TObject);
  private
    { Private declarations }
    gtPDFViewer1: TgtPDFViewer;
  public
    { Public declarations }
  end;

const
  ActiveBtnHint: array[False..True] of string = ('Activate','Deactivate');

var
  frmPDFViewerDemo: TfrmPDFViewerDemo;

implementation

uses Math;

{$R *.dfm}

procedure TfrmPDFViewerDemo.BtnActiveClick(Sender: TObject);
begin
  BtnActive.Hint := ActiveBtnHint[BtnActive.down];
  gtPDFViewer1.Active := not gtPDFViewer1.Active;
  BtnPrint.Enabled := gtPDFViewer1.Active;
  UpdateButton;
end;

procedure TfrmPDFViewerDemo.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPDFViewerDemo.BtnFirstPageClick(Sender: TObject);
begin
  gtPDFViewer1.First;
  UpdateButton;
  UpdateStatusBar
end;

procedure TfrmPDFViewerDemo.BtnPriorPageClick(Sender: TObject);
begin
  gtPDFViewer1.Prior;
  UpdateButton;
  UpdateStatusBar
end;

procedure TfrmPDFViewerDemo.BtnNextPageClick(Sender: TObject);
begin
  gtPDFViewer1.Next;
  UpdateButton;
  UpdateStatusBar
end;

procedure TfrmPDFViewerDemo.BtnLastPageClick(Sender: TObject);
begin
  gtPDFViewer1.Last;
  UpdateButton;
  UpdateStatusBar
end;

procedure TfrmPDFViewerDemo.BtnFitPageClick(Sender: TObject);
begin
  gtPDFViewer1.Zoom := gtPDFViewer1.GetStandardZoomValue(sztFitPage);
  UpdateStatusBar;
end;

procedure TfrmPDFViewerDemo.BtnActualSizeClick(Sender: TObject);
begin
  gtPDFViewer1.Zoom := gtPDFViewer1.GetStandardZoomValue(sztActualSize);
  UpdateStatusBar;
end;

procedure TfrmPDFViewerDemo.BtnOpenfileClick(Sender: TObject);
var
  LBmp: TBitmap;
begin
  if not OpenDialog1.Execute then
    Exit;
  try
    gtPDFDocument1.Filename := OpenDialog1.FileName;
    gtPDFDocument1.CMapPath := ExtractFilePath(Application.ExeName) + '\CMaps';
    if assigned(gtPDFViewer1) then
      gtPDFViewer1.Free;
    gtPDFViewer1 := TgtPDFViewer.create(nil);
    gtPDFViewer1.Parent := Panel3;
    gtPDFViewer1.Left := 124;
    gtPDFViewer1.Top := 36;
    gtPDFViewer1.Align := alClient;

    gtPDFViewer1.PDFDocument := gtPDFDocument1;
    gtPDFOutlineViewer1.PDFDocument := gtPDFDocument1;
    gtPDFOutlineViewer1.PDFViewer := gtPDFViewer1;
    gtPDFSearchPanel1.PDFViewer := gtPDFViewer1;

    gtPDFSearchPanel1.Hide;
    if gtPDFDocument1.IsLoaded then
    begin
      gtPDFViewer1.Zoom := 100;
      BtnPrint.Enabled := True;
      gtPDFViewer1.PageNo := 1;
      gtPDFViewer1.Active := False;
      gtPDFViewer1.RotationAngle := ra0;
      gtPDFViewer1.Active := True;
      gtPDFOutlineViewer1.Active := True;
      UpdateButton;
      UpdateStatusBar;
      EdtGotoPage.SetFocus;
      LBmp := TBitmap.Create;
      ImageList1.GetBitmap(0, LBmp);
      BtnClkRotate.Glyph.Assign(LBmp);
      LBmp.Free;
    end;
    gtPDFViewer1.OnPageChange :=  gtPDFViewer1ViewerChange;
    except
    //
    end;
end;

procedure TfrmPDFViewerDemo.BtnPrintClick(Sender: TObject);
begin
  gtPDFViewer1.PrintDoc;
end;

function TfrmPDFViewerDemo.UpdateButton: string;
begin
  BtnFirstPage.Enabled := not gtPDFViewer1.IsFirst;
  BtnPriorPage.Enabled := not gtPDFViewer1.IsFirst;
  BtnNextPage.Enabled := not gtPDFViewer1.IsLast;
  BtnLastPage.Enabled := not gtPDFViewer1.IsLast;
  BtnActive.Enabled := True;
  BtnFitPage.Enabled := True;
  btnFitWidth.Enabled := True;
  BtnActualSize.Enabled := True;
  if round(gtPDFViewer1.Zoom) = round(gtPDFViewer1.GetStandardZoomValue(sztActualSize)) then
    BtnActualSize.Down := True;
  if round(gtPDFViewer1.Zoom) = round(gtPDFViewer1.GetStandardZoomValue(sztFitPage)) then
    BtnFitPage.Down := True;
  if round(gtPDFViewer1.Zoom) = round(gtPDFViewer1.GetStandardZoomValue(sztFitWidth)) then
    btnFitWidth.Down := True;
  SearchButton.Enabled := True;
  BtnZoomOut.Enabled := True;
  BtnZoomIn.Enabled := True;
  EdtGotoPage.Enabled := True;
  edZoom.Enabled := True;
  BtnClkRotate.Enabled := True;
  BtnResetRotate.Enabled := True;
  EdtGotoPage.Text := IntToStr(gtPDFViewer1.PageNo);
  Label2.Caption := ' of ' + IntToStr(gtPDFViewer1.PDFDocument.PageCount);
end;

procedure TfrmPDFViewerDemo.UpdateStatusBar;
begin
  SbPageNo.Panels[0].Text := Format('Page %d of %d',[gtPDFViewer1.PageNo,gtPDFViewer1.PDFDocument.PageCount ]);
  edZoom.Text := FormatFloat('#.##', gtPDFViewer1.Zoom);
  BtnZoomIn.Enabled := (StrToFloat(edZoom.Text)) <> 1 ;
end;

procedure TfrmPDFViewerDemo.EdtGotoPageKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #13]) and (Ord(Key) <> VK_BACK) then
  begin
    Key := #0;
  end;
  Timer1.Enabled := true;
end;

procedure TfrmPDFViewerDemo.SpeedButton2Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TfrmPDFViewerDemo.Timer1Timer(Sender: TObject);
begin
  gtPDFViewer1.GoToPage(StrToIntDef(EdtGotoPage.Text,1));
  UpdateButton;
  UpdateStatusBar;
  Timer1.Enabled := False;
end;

procedure TfrmPDFViewerDemo.btnFitWidthClick(Sender: TObject);
begin
  gtPDFViewer1.Zoom := gtPDFViewer1.GetStandardZoomValue(sztFitWidth);
  UpdateStatusBar;
end;

procedure TfrmPDFViewerDemo.edZoomKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.', #13]) and (Ord(Key) <> VK_BACK) then
  begin
    Key := #0;
  end;
end;

procedure TfrmPDFViewerDemo.edZoomChange(Sender: TObject);
begin
  if edZoom.Text <> '' then
    gtPDFViewer1.Zoom := StrToFloat(edZoom.text)
  else
    gtPDFViewer1.Zoom := 1;
  UpdateButton;
end;

procedure TfrmPDFViewerDemo.BtnZoomOutClick(Sender: TObject);
var
  Lfactor: Integer;
begin
  if edZoom.Text = '' then
  begin
    gtPDFViewer1.Zoom := ZoomIncrement;
    UpdateStatusBar;
  end
  else
  begin
    Lfactor := Floor(strtofloat(edZoom.text)/ ZoomIncrement);
    gtPDFViewer1.Zoom := (ZoomIncrement * (Lfactor+1));
    UpdateStatusBar;
  end;
end;

procedure TfrmPDFViewerDemo.BtnZoomInClick(Sender: TObject);
var
  Lfactor: Integer;
begin
  if edZoom.Text = '' then
  begin
    gtPDFViewer1.Zoom := 1;
    UpdateStatusBar;
  end
  else
  begin
    Lfactor := Floor((gtPDFViewer1.Zoom)/ ZoomIncrement);
    if ((gtPDFViewer1.Zoom) - (ZoomIncrement * Lfactor)) = 0 then
      gtPDFViewer1.Zoom := (ZoomIncrement * (Lfactor-1))
    else
      gtPDFViewer1.Zoom := (ZoomIncrement * (Lfactor));

    UpdateStatusBar;
  end;
end;
procedure TfrmPDFViewerDemo.edZoomExit(Sender: TObject);
begin
  if edZoom.Text <> '' then
    gtPDFViewer1.Zoom := StrToFloat(edZoom.Text);
end;

procedure TfrmPDFViewerDemo.gtPDFDocument1Password(Sender: TObject;
  var Password: String; var Continue: Boolean; const Tries: Integer);
begin
  if (Tries <> 0) and (Tries < 3) then
    ShowMessage('Wrong Password!' + CRLF + 'Enter the password again.');

  if Tries < 3 then
  begin
    frmPassword.ShowModal;
    frmPassword.edtpassword.Text := '';
    Password := frmPassword.FPwd;
    if frmPassword.IsCancel then
      Continue := false
    else
      Continue := True;
  end
  else
  begin
    Continue := False;
    ShowMessage('Wrong Password!' + CRLF + 'Please open the document again.')
  end;
end;

procedure TfrmPDFViewerDemo.FormCreate(Sender: TObject);
begin
  SearchButton.Enabled := False;
  BtnClkRotate.Enabled := False;
  BtnResetRotate.Enabled := False;
end;

procedure TfrmPDFViewerDemo.SearchButtonClick(Sender: TObject);
begin
  gtPDFSearchPanel1.Visible := not gtPDFSearchPanel1.Visible;
  Splitter2.Visible := gtPDFSearchPanel1.Visible;
  if gtPDFSearchPanel1.Visible then
    Splitter2.Left := gtPDFSearchPanel1.Left;
end;

procedure TfrmPDFViewerDemo.gtPDFViewer1ViewerChange(Sender: TgtPDFViewer;
  const CurrentIndex: TPageIndex);
begin
  UpdateButton;
  UpdateStatusBar;
end;

procedure TfrmPDFViewerDemo.BtnClkRotateClick(Sender: TObject);
var
  LBmp: TBitmap;
begin
  if gtPDFViewer1.RotationAngle = ra0 then
    gtPDFViewer1.RotationAngle := raCW90
  else if gtPDFViewer1.RotationAngle = raCW90 then
    gtPDFViewer1.RotationAngle := raCW180
  else if gtPDFViewer1.RotationAngle = raCW180 then
    gtPDFViewer1.RotationAngle := raCW270
  else if gtPDFViewer1.RotationAngle = raCW270 then
    gtPDFViewer1.RotationAngle := ra0;
  LBmp := TBitmap.Create;
  if (gtPDFViewer1.RotationAngle = ra0) then
  begin
    ImageList1.GetBitmap(0, LBmp);
    BtnClkRotate.Glyph.Assign(LBmp);
  end
  else if (gtPDFViewer1.RotationAngle = raCW90) then
  begin
    ImageList1.GetBitmap(1, LBmp);
    BtnClkRotate.Glyph.Assign(LBmp);
  end
  else if (gtPDFViewer1.RotationAngle = raCW180) then
  begin
    ImageList1.GetBitmap(2, LBmp);
    BtnClkRotate.Glyph.Assign(LBmp);
  end
  else if (gtPDFViewer1.RotationAngle = raCW270) then
  begin
    ImageList1.GetBitmap(3, LBmp);
    BtnClkRotate.Glyph.Assign(LBmp);
  end;
  LBmp.Free;
end;

procedure TfrmPDFViewerDemo.BtnResetRotateClick(Sender: TObject);
var
  LBmp: TBitmap;
begin
  gtPDFViewer1.RotationAngle := ra0;
  LBmp := TBitmap.Create;
  ImageList1.GetBitmap(0, LBmp);
  BtnClkRotate.Glyph.Assign(LBmp);
  LBmp.Free;
end;
end.
