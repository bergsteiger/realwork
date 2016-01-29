// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{$DEFINE gtPro}

unit eDocQR2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, gtXHTMLEng, gtWMFEng, gtMetafileEng, gtEMFEng, gtBMPEng,
  gtGIFEng, gtCstGfxEng, gtJPEGEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtQProEng, gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtXLSEng,
  gtCstHTMLEng, gtHTMLEng, gtRTFEng, gtCstDocEng, gtCstPlnEng,
  gtCstPDFEng, gtPDFEng, gtClasses3, gtXportIntf, gtQRXportIntf,
  QRDDlgs,qrdQuickrep, gtExXLSEng, gtExHTMLEng, gtExPDFEng, QRPrntr,
  StdCtrls, ExtCtrls, QRPrntr, StdCtrls, ExtCtrls
  {$IFDEF gtPro}
  , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents
  {$ENDIF}
  ;


type
  TfrmQR2 = class(TForm)
    Panel1: TPanel;
    btnLoadfile: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    QRPreview1: TQRPreview;
    btnExportfile: TButton;
    gtQRExportInterface1: TgtQRExportInterface;
    gtDocSettings1: TgtDocSettings;
    gtPDFEngine1: TgtPDFEngine;
    gtRTFEngine1: TgtRTFEngine;
    gtHTMLEngine1: TgtHTMLEngine;
    gtExcelEngine1: TgtExcelEngine;
    gtTextEngine1: TgtTextEngine;
    gtQuattroProEngine1: TgtQuattroProEngine;
    gtLotusEngine1: TgtLotusEngine;
    gtDIFEngine1: TgtDIFEngine;
    gtSYLKEngine1: TgtSYLKEngine;
    gtJPEGEngine1: TgtJPEGEngine;
    gtGIFEngine1: TgtGIFEngine;
    gtBMPEngine1: TgtBMPEngine;
    gtEMFEngine1: TgtEMFEngine;
    gtWMFEngine1: TgtWMFEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
    btnPrevPage: TButton;
    btnNextPage: TButton;
    ReportDesignerDialog1: TReportDesignerDialog;
    procedure btnLoadfileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNextPageClick(Sender: TObject);
    procedure btnPrevPageClick(Sender: TObject);
  private
    { Private declarations }
    FQRPrinter: TQRPrinter;
    {$IFDEF gtPro}
    FfrmProComponent: TfrmeDocProComponents;
    {$ENDIF}
  public
    { Public declarations }
  end;

const
  SPDFDescription = 'Adobe PDF Files (*.pdf)|*.pdf|';
  SRTFDescription = 'Rich Text Format (*.rtf)|*.rtf|';
  SBMPDescription = 'Windows Bitmap (*.bmp)|*.bmp|';
  SJPEGDescription = 'JPEG File Interchange Format (*.jpg)|*.jpg|';
  SWMFDescription = 'Windows Metafiles (*.wmf)|*.wmf|';
  SEMFDescription = 'Enhanced Metafiles (*.emf)|*.emf|';
  SGIFDescription = 'Graphics Interchange Format (*.gif)|*.gif|';
  SHTMLDescription = 'HyperText Markup Language (*.htm)|*.htm|';
  SXHTMLDescription = 'Extended HyperText Markup Language (*.htm)|*.htm|';
  SExcelDescription = 'Microsoft Excel Workbook (*.xls)|*.xls|';
  SQuattroProDescription = 'Quattro Pro for Windows (*.wb1)|*.wb1|';
  SLotusDescription = 'Lotus 1-2-3 (*.wk2)|*.wk2|';
  SDIFDescription = 'Data Interchange Format (*.dif)|*.dif|';
  SSYLKDescription = 'Symbolic Link (*.slk)|*.slk|';
  STextDescription = 'Text Document (*.txt)|*.txt|';
{$IFDEF gtPro}
  SSVGDescription = 'Scalable Vector Graphics (*.svg)|*.svg|';
  SPNGDescription = 'Portable Network Graphics (*.png)|*.png|';
  STIFFDescription = 'Tagged Image File Format (*.tif)|*.tif|';
{$ENDIF}

var
  frmQR2: TfrmQR2;

implementation

{$R *.dfm}

procedure TfrmQR2.btnLoadfileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;
  ReportDesignerDialog1.PreviewReport(OpenDialog1.FileName);
end;

procedure TfrmQR2.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription;
    {$IFDEF gtPro}
    SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription +
      SPNGDescription + STIFFDescription;
    {$ENDIF}

  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtQRExportInterface1.Engine := gtPDFEngine1;
    2: gtQRExportInterface1.Engine := gtRTFEngine1;
    3: gtQRExportInterface1.Engine := gtHTMLEngine1;
    4: gtQRExportInterface1.Engine := gtXHTMLEngine1;
    5: gtQRExportInterface1.Engine := gtTextEngine1;
    6: gtQRExportInterface1.Engine := gtExcelEngine1;
    7: gtQRExportInterface1.Engine := gtDIFEngine1;
    8: gtQRExportInterface1.Engine := gtQuattroProEngine1;
    9: gtQRExportInterface1.Engine := gtLotusEngine1;
    10: gtQRExportInterface1.Engine := gtSYLKEngine1;
    11: gtQRExportInterface1.Engine := gtBMPEngine1;
    12: gtQRExportInterface1.Engine := gtJPEGEngine1;
    13: gtQRExportInterface1.Engine := gtEMFEngine1;
    14: gtQRExportInterface1.Engine := gtWMFEngine1;
    15: gtQRExportInterface1.Engine := gtGIFEngine1;
    {$IFDEF gtPro}
    16: gtQRExportInterface1.Engine := FfrmProComponent.gtSVGEngine1;
    17: gtQRExportInterface1.Engine := FfrmProComponent.gtPNGEngine1;
    18: gtQRExportInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
    {$ENDIF}
  end;
  IgtDocumentEngine(gtQRExportInterface1.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtQRExportInterface1.Engine).Preferences.UseImagesAsResources := False;
  IgtDocumentEngine(gtQRExportInterface1.Engine).Preferences.ProcessAfterEachPage := True;
  if ReportDesignerDialog1.LoadReport(OpenDialog1.FileName) then
  begin
    gtQRExportInterface1.RenderDocument(TDesignQuickReport(ReportDesignerDialog1.QRD.ParentControl), False);
  end;
end;

procedure TfrmQR2.FormCreate(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}

  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) +
    'QR2Demo.qr2';
  ReportDesignerDialog1.PreviewReport(OpenDialog1.FileName);
end;

procedure TfrmQR2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF gtPro}
  FfrmProComponent.Free;
  {$ENDIF}
  FQRPrinter.Free;
end;


procedure TfrmQR2.btnNextPageClick(Sender: TObject);
begin
  QRPreview1.PageNumber := QRPreview1.PageNumber + 1; 
end;

procedure TfrmQR2.btnPrevPageClick(Sender: TObject);
begin
  QRPreview1.PageNumber := QRPreview1.PageNumber - 1;
end;

end.
