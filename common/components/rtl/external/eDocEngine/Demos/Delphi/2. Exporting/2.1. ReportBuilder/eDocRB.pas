// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{$DEFINE gtPro}
unit eDocRB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ppComm, ppRelatv, ppProd, ppArchiv, gtWMFEng, gtMetafileEng,
  gtEMFEng, gtBMPEng, gtGIFEng, gtCstGfxEng, gtJPEGEng, gtSLKEng, gtDIFEng,
  gtLotusEng, gtQProEng, gtTXTEng, gtCstSpdEng, gtCstXLSEng,
  gtXLSEng, gtXHTMLEng, gtCstHTMLEng, gtHTMLEng, gtRTFEng,
  gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtPDFEng, gtClasses3,
  gtXportIntf, gtRBXportIntf, ppViewr, StdCtrls, ExtCtrls, ppReport
{$IFDEF gtPro}
    , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents, gtCstXLS95Eng,
  gtExXLS95Eng, gtXLS95Eng
{$ENDIF}
    ;

type
  TfrmRB = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnLoadFile: TButton;
    btnExportfile: TButton;
    ppViewer1: TppViewer;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    gtDocSettings1: TgtDocSettings;
    gtPDFEngine1: TgtPDFEngine;
    gtRTFEngine1: TgtRTFEngine;
    gtHTMLEngine1: TgtHTMLEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
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
    ppArchiveReader1: TppArchiveReader;
    btnNextPage: TButton;
    btnPrevPage: TButton;
    gtRBExportInterface1: TgtRBExportInterface;
    gtXLSEngine1: TgtXLSEngine;
    procedure btnLoadFileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNextPageClick(Sender: TObject);
    procedure btnPrevPageClick(Sender: TObject);
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
  SJPEGDescription = 'JPEG File Interchange Format (*.jpg)|*.jpg|';
  SWMFDescription = 'Windows Metafiles (*.wmf)|*.wmf|';
  SEMFDescription = 'Enhanced Metafiles (*.emf)|*.emf|';
  SGIFDescription = 'Graphics Interchange Format (*.gif)|*.gif|';
  SHTMLDescription = 'HyperText Markup Language (*.htm)|*.htm|';
  SXHTMLDescription = 'Extended HyperText Markup Language (*.htm)|*.htm|';
  SExcelDescription = 'Microsoft Excel Workbook (*.xlsx)|*.xlsx|';
  SXLSDescription = 'Microsoft Excel Workbook (*.xls)|*.xls|';
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
  frmRB: TfrmRB;

implementation

{$R *.dfm}

procedure TfrmRB.btnLoadFileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;
  ppArchiveReader1.ArchiveFileName := OpenDialog1.FileName;
  ppViewer1.Report.PrintToDevices;
end;

procedure TfrmRB.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter := SPDFDescription + SRTFDescription + SHTMLDescription +
    SXHTMLDescription + STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SBMPDescription + SJPEGDescription + SEMFDescription + SWMFDescription +
    SGIFDescription+SXLSDescription;
{$IFDEF gtPro}
  SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription + SPNGDescription +
    STIFFDescription;
{$ENDIF}
  if not SaveDialog1.Execute then
    Exit;
  case SaveDialog1.FilterIndex of
    1:
      gtRBExportInterface1.Engine := gtPDFEngine1;
    2:
      gtRBExportInterface1.Engine := gtRTFEngine1;
    3:
      gtRBExportInterface1.Engine := gtHTMLEngine1;
    4:
      gtRBExportInterface1.Engine := gtXHTMLEngine1;
    5:
      gtRBExportInterface1.Engine := gtTextEngine1;
    6:
      gtRBExportInterface1.Engine := gtExcelEngine1;
    7:
      gtRBExportInterface1.Engine := gtDIFEngine1;
    8:
      gtRBExportInterface1.Engine := gtQuattroProEngine1;
    9:
      gtRBExportInterface1.Engine := gtLotusEngine1;
    10:
      gtRBExportInterface1.Engine := gtSYLKEngine1;
    11:
      gtRBExportInterface1.Engine := gtBMPEngine1;
    12:
      gtRBExportInterface1.Engine := gtJPEGEngine1;
    13:
      gtRBExportInterface1.Engine := gtEMFEngine1;
    14:
      gtRBExportInterface1.Engine := gtWMFEngine1;
    15:
      gtRBExportInterface1.Engine := gtGIFEngine1;
     16:
      gtRBExportInterface1.Engine := gtXLSEngine1;
{$IFDEF gtPro}
    17:
      gtRBExportInterface1.Engine := FfrmProComponent.gtSVGEngine1;
    18:
      gtRBExportInterface1.Engine := FfrmProComponent.gtPNGEngine1;
    19:
      gtRBExportInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
{$ENDIF}
  end;
  IgtDocumentEngine(gtRBExportInterface1.Engine).FileName :=
    SaveDialog1.FileName;
  IgtDocumentEngine(gtRBExportInterface1.Engine)
    .Preferences.UseImagesAsResources := False;
  IgtDocumentEngine(gtRBExportInterface1.Engine)
    .Preferences.ProcessAfterEachPage := True;
  gtRBExportInterface1.RenderDocument(TppReport(ppViewer1.Report));
end;

procedure TfrmRB.FormCreate(Sender: TObject);
begin
{$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
{$ENDIF}
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) +
    'ReportBuilder.raf';
  ppArchiveReader1.ArchiveFileName := OpenDialog1.FileName;
  ppViewer1.Report.PrintToDevices;
end;

procedure TfrmRB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{$IFDEF gtPro}
  FfrmProComponent.Free;
{$ENDIF}
end;

procedure TfrmRB.btnNextPageClick(Sender: TObject);
begin
  ppViewer1.NextPage;
end;

procedure TfrmRB.btnPrevPageClick(Sender: TObject);
begin
  ppViewer1.PriorPage;
end;

end.
