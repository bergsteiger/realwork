unit eDocGmPrintSuite;

interface

//Remove the dot (.) below to configure demo for eDocEngine Pro
{$DEFINE gtPro}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GmTypes, GmClasses, GmRtfPreview, gtXportIntf,
  gtGmSuiteIntf, GmCanvas, GmPageList, GmPreview, gtXHTMLEng, gtWMFEng,
  gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng, gtJPEGEng,
  gtCstGfxEng, gtSLKEng, gtDIFEng, gtLotusEng,
  gtQProEng, gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtXLSEng,
  gtCstHTMLEng, gtHTMLEng, gtRTFEng, gtCstDocEng, gtCstPlnEng,
  gtCstPDFEng, gtPDFEng, gtClasses3, ExtCtrls, GmPageNavigator, eDocProComponents
  {$IFDEF gtPro}
  , gtExXLSEng, gtSVGEng, gtPNGEng, gtTIFFEng, gtExHTMLEng, gtExPDFEng
  {$ENDIF}
  ;

type
  TfrmGmPrintSuite = class(TForm)
    Panel1: TPanel;
    btnLoadfile: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    btnExportfile: TButton;
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
    GmPreview1: TGmPreview;
    gtGmSuiteInterface1: TgtGmSuiteInterface;
    GmPageNavigator1: TGmPageNavigator;
    GmRtfPreview1: TGmRtfPreview;
    procedure btnLoadfileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
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
  STIFFDescription = 'Tagged Image File Format (*.tif)|*.tif|';
  SPNGDescription = 'Portable Network Graphics (*.png)|*.png|';
  SJPEGDescription = 'JPEG File Interchange Format (*.jpg)|*.jpg|';
  SWMFDescription = 'Windows Metafiles (*.wmf)|*.wmf|';
  SEMFDescription = 'Enhanced Metafiles (*.emf)|*.emf|';
  SGIFDescription = 'Graphics Interchange Format (*.gif)|*.gif|';
  SSVGDescription = 'Scalable Vector Graphics (*.svg)|*.svg|';
  SHTMLDescription = 'HyperText Markup Language (*.htm)|*.htm|';
  SXHTMLDescription = 'Extended HyperText Markup Language (*.htm)|*.htm|';
  SExcelDescription = 'Microsoft Excel Workbook (*.xls)|*.xls|';
  SQuattroProDescription = 'Quattro Pro for Windows (*.wb1)|*.wb1|';
  SLotusDescription = 'Lotus 1-2-3 (*.wk2)|*.wk2|';
  SDIFDescription = 'Data Interchange Format (*.dif)|*.dif|';
  SSYLKDescription = 'Symbolic Link (*.slk)|*.slk|';
	STextDescription = 'Text Document (*.txt)|*.txt|';

var
  frmGmPrintSuite: TfrmGmPrintSuite;

implementation

{$R *.dfm}

procedure TfrmGmPrintSuite.btnLoadfileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
  	Exit;
  GmRtfPreview1.LoadRtfFromFile(OpenDialog1.FileName);
  GmPreview1.FirstPage;
end;

procedure TfrmGmPrintSuite.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    {$IFDEF gtPro}SSVGDescription + {$ENDIF}STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    {$IFDEF gtPro}SPNGDescription + STIFFDescription + {$ENDIF}SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription;

  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtGmSuiteInterface1.Engine := gtPDFEngine1;
    2: gtGmSuiteInterface1.Engine := gtRTFEngine1;
    3: gtGmSuiteInterface1.Engine := gtHTMLEngine1;
    4: gtGmSuiteInterface1.Engine := gtXHTMLEngine1;
    6: gtGmSuiteInterface1.Engine := gtTextEngine1;
    7: gtGmSuiteInterface1.Engine := gtExcelEngine1;
    8: gtGmSuiteInterface1.Engine := gtDIFEngine1;
    9: gtGmSuiteInterface1.Engine := gtQuattroProEngine1;
    10: gtGmSuiteInterface1.Engine := gtLotusEngine1;
    11: gtGmSuiteInterface1.Engine := gtSYLKEngine1;
    {$IFDEF gtPro}
    12: gtGmSuiteInterface1.Engine := FfrmProComponent.gtPNGEngine1;
    13: gtGmSuiteInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
    5: gtGmSuiteInterface1.Engine := FfrmProComponent.gtSVGEngine1;
    {$ENDIF}
    14: gtGmSuiteInterface1.Engine := gtBMPEngine1;
    15: gtGmSuiteInterface1.Engine := gtJPEGEngine1;
    16: gtGmSuiteInterface1.Engine := gtEMFEngine1;
    17: gtGmSuiteInterface1.Engine := gtWMFEngine1;
    18: gtGmSuiteInterface1.Engine := gtGIFEngine1;
  end;
  IgtDocumentEngine(gtGmSuiteInterface1.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtGmSuiteInterface1.Engine).Preferences.UseImagesAsResources := False;
  IgtDocumentEngine(gtGmSuiteInterface1.Engine).Preferences.ProcessAfterEachPage := True;
  gtGmSuiteInterface1.RenderDocument(GmPreview1);
end;

procedure TfrmGmPrintSuite.FormCreate(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}
end;

procedure TfrmGmPrintSuite.FormShow(Sender: TObject);
begin
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) + 'GmPrintSuite.rtf';
  GmRtfPreview1.LoadRtfFromFile(OpenDialog1.FileName);
  GmPreview1.FirstPage;
end;

end.
