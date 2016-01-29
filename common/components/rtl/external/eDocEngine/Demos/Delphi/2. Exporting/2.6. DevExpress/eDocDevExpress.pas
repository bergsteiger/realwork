unit eDocDevExpress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, gtXportIntf,
  gtXPressPrntIntf, gtSVGEng, gtPNGEng, gtTIFFEng, gtWMFEng, gtMetafileEng,
  gtEMFEng, gtBMPEng, gtGIFEng, gtCstGfxEng, gtJPEGEng, gtSLKEng, gtDIFEng,
  gtLotusEng, gtQProEng, gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtExXLSEng,
  gtXLSEng, gtXHTMLEng, gtCstHTMLEng, gtExHTMLEng, gtHTMLEng, gtRTFEng,
  gtClasses3, gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtExPDFEng, gtPDFEng,
  dxPSCore, dxPSBaseGridLnk, dxPSGrLnks, dxPSStdGrLnk, Grids, StdCtrls,
  ExtCtrls;

type
  TfrmDevExpress = class(TForm)
    dxComponentPrinter1: TdxComponentPrinter;
    Panel1: TPanel;
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
    gtTIFFEngine1: TgtTIFFEngine;
    gtPNGEngine1: TgtPNGEngine;
    gtSVGEngine1: TgtSVGEngine;
    gtXPressPrntInterface1: TgtXPressPrntInterface;
    StringGrid: TStringGrid;
    SaveDialog1: TSaveDialog;
    dxComponentPrinter1Link1: TdxStringGridReportLink;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
  SExcelDescription = 'Microsoft Excel Workbook (*.xls)|*.xls|';
  SQuattroProDescription = 'Quattro Pro for Windows (*.wb1)|*.wb1|';
  SLotusDescription = 'Lotus 1-2-3 (*.wk2)|*.wk2|';
  SDIFDescription = 'Data Interchange Format (*.dif)|*.dif|';
  SSYLKDescription = 'Symbolic Link (*.slk)|*.slk|';
	STextDescription = 'Text Document (*.txt)|*.txt|';

var
  frmDevExpress: TfrmDevExpress;

implementation

{$R *.DFM}

procedure TfrmDevExpress.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
	with StringGrid do
  begin
  	Cells[0,0] := 'X';
    for i := 1 to ColCount - 1 do
    begin
      Cells[0,i] := IntToStr(i);
      for j := 1 to RowCount - 1 do
      begin
        Cells[j,0] := IntToStr(j);
        Cells[j,i] := IntToStr(i*j);
      end;
    end;
  end;
  dxComponentPrinter1.CurrentLink := dxComponentPrinter1Link1;
end;

procedure TfrmDevExpress.Button1Click(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    SSVGDescription + STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SPNGDescription + STIFFDescription + SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription;

  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtXPressPrntInterface1.Engine := gtPDFEngine1;
    2: gtXPressPrntInterface1.Engine := gtRTFEngine1;
    3: gtXPressPrntInterface1.Engine := gtHTMLEngine1;
    4: gtXPressPrntInterface1.Engine := gtXHTMLEngine1;
    5: gtXPressPrntInterface1.Engine := gtSVGEngine1;
    6: gtXPressPrntInterface1.Engine := gtTextEngine1;
    7: gtXPressPrntInterface1.Engine := gtExcelEngine1;
    8: gtXPressPrntInterface1.Engine := gtDIFEngine1;
    9: gtXPressPrntInterface1.Engine := gtQuattroProEngine1;
    10: gtXPressPrntInterface1.Engine := gtLotusEngine1;
    11: gtXPressPrntInterface1.Engine := gtSYLKEngine1;
    12: gtXPressPrntInterface1.Engine := gtPNGEngine1;
    13: gtXPressPrntInterface1.Engine := gtTIFFEngine1;
    14: gtXPressPrntInterface1.Engine := gtBMPEngine1;
    15: gtXPressPrntInterface1.Engine := gtJPEGEngine1;
    16: gtXPressPrntInterface1.Engine := gtEMFEngine1;
    17: gtXPressPrntInterface1.Engine := gtWMFEngine1;
    18: gtXPressPrntInterface1.Engine := gtGIFEngine1;
  end;
  IgtDocumentEngine(gtXPressPrntInterface1.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtXPressPrntInterface1.Engine).Preferences.ShowSetupDialog := True;
  dxComponentPrinter1.RebuildReport;
  gtXPressPrntInterface1.RenderDocument(dxComponentPrinter1);
end;

end.
