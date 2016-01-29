unit eDocHtmlViewer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Htmlview, gtXportIntf, gtHtmlViewIntf, gtXHTMLEng,
  gtWMFEng, gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng, gtJPEGEng,
  gtSVGEng, gtPNGEng, gtCstGfxEng, gtTIFFEng, gtSLKEng, gtDIFEng,
  gtLotusEng, gtQProEng, gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtExXLSEng,
  gtXLSEng, gtCstHTMLEng, gtExHTMLEng, gtHTMLEng, gtRTFEng, gtCstDocEng,
  gtCstPlnEng, gtCstPDFEng, gtExPDFEng, gtPDFEng, gtClasses3, ExtCtrls,
  gtCstXLS95Eng, gtExXLS95Eng, gtXLS95Eng;

type
  TfrmHtmlViewer = class(TForm)
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
    gtTIFFEngine1: TgtTIFFEngine;
    gtPNGEngine1: TgtPNGEngine;
    gtSVGEngine1: TgtSVGEngine;
    gtJPEGEngine1: TgtJPEGEngine;
    gtGIFEngine1: TgtGIFEngine;
    gtBMPEngine1: TgtBMPEngine;
    gtEMFEngine1: TgtEMFEngine;
    gtWMFEngine1: TgtWMFEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
    gtHtmlViewInterface1: TgtHtmlViewInterface;
    HTMLViewer1: THTMLViewer;
    gtXLSEngine1: TgtXLSEngine;
    procedure btnLoadfileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
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
  SExcelDescription = 'Microsoft Excel Workbook (*.xlsx)|*.xlsx|';
   SXLSDescription = 'Microsoft Excel Workbook (*.xls)|*.xls|';
  SQuattroProDescription = 'Quattro Pro for Windows (*.wb1)|*.wb1|';
  SLotusDescription = 'Lotus 1-2-3 (*.wk2)|*.wk2|';
  SDIFDescription = 'Data Interchange Format (*.dif)|*.dif|';
  SSYLKDescription = 'Symbolic Link (*.slk)|*.slk|';
	STextDescription = 'Text Document (*.txt)|*.txt|';

var
  frmHtmlViewer: TfrmHtmlViewer;

implementation

{$R *.dfm}

procedure TfrmHtmlViewer.btnLoadfileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
  	Exit;
  HTMLViewer1.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmHtmlViewer.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    SSVGDescription + STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SPNGDescription + STIFFDescription + SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription+SXLSDescription;

  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtHtmlViewInterface1.Engine := gtPDFEngine1;
    2: gtHtmlViewInterface1.Engine := gtRTFEngine1;
    3: gtHtmlViewInterface1.Engine := gtHTMLEngine1;
    4: gtHtmlViewInterface1.Engine := gtXHTMLEngine1;
    5: gtHtmlViewInterface1.Engine := gtSVGEngine1;
    6: gtHtmlViewInterface1.Engine := gtTextEngine1;
    7: gtHtmlViewInterface1.Engine := gtExcelEngine1;
    8: gtHtmlViewInterface1.Engine := gtDIFEngine1;
    9: gtHtmlViewInterface1.Engine := gtQuattroProEngine1;
    10: gtHtmlViewInterface1.Engine := gtLotusEngine1;
    11: gtHtmlViewInterface1.Engine := gtSYLKEngine1;
    12: gtHtmlViewInterface1.Engine := gtPNGEngine1;
    13: gtHtmlViewInterface1.Engine := gtTIFFEngine1;
    14: gtHtmlViewInterface1.Engine := gtBMPEngine1;
    15: gtHtmlViewInterface1.Engine := gtJPEGEngine1;
    16: gtHtmlViewInterface1.Engine := gtEMFEngine1;
    17: gtHtmlViewInterface1.Engine := gtWMFEngine1;
    18: gtHtmlViewInterface1.Engine := gtGIFEngine1;
    19: gtHtmlViewInterface1.Engine := gtXLSEngine1;
  end;
  IgtDocumentEngine(gtHtmlViewInterface1.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtHtmlViewInterface1.Engine).Preferences.ProcessAfterEachPage := True;
  gtHtmlViewInterface1.RenderDocument(HTMLViewer1);
end;

procedure TfrmHtmlViewer.FormCreate(Sender: TObject);
begin
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) + 'HtmlViewer.htm';
  HTMLViewer1.LoadFromFile(OpenDialog1.FileName);
end;

end.
