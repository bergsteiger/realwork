// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{.$DEFINE gtPro}

unit OneFromMany;

interface

uses
  Windows, Messages, SysUtils, {Variants, }Classes, Graphics, Controls, Forms,
  Dialogs, {RpDefine, RpRave, }QRCtrls, QuickRpt, ExtCtrls, DB, DBTables,
  gtAceXportIntf, {RpBase, RpSystem, }gtRBXportIntf, gtQRXportIntf,
  gtRvXportIntf, gtXportIntf, gtFRXportIntf,
  gtClipboard, gtWMFEng, gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng,
  gtCstGfxEng, gtJPEGEng, gtSLKEng, gtDIFEng, gtLotusEng, gtQProEng,
  gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtXLSEng, gtXHTMLEng,
  gtCstHTMLEng, gtHTMLEng, gtRTFEng, gtClasses3, gtCstDocEng,
  gtCstPlnEng, gtCstPDFEng, gtPDFEng, ppBands, ppCtrls,
  ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, FR_Class,
  StdCtrls, SctCtrl, SctVar, SctRep, RpDefine, RpRave, RpBase, RpSystem
  {$IFDEF gtPro}
  , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents
  {$ENDIF}
  ;

type
  TForm1 = class(TForm)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRImage1: TQRImage;
    frReport1: TfrReport;
    ppReport1: TppReport;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    Button1: TButton;
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
    gtClipboard1: TgtClipboard;
    gtFRExportInterface1: TgtFRExportInterface;
    gtRaveExportInterface1: TgtRaveExportInterface;
    gtQRExportInterface1: TgtQRExportInterface;
    gtRBExportInterface1: TgtRBExportInterface;
    SaveDialog1: TSaveDialog;
    //RvProject1: TRvProject;
    //RvSystem1: TRvSystem;
    ppImage2: TppImage;
    ppLabel1: TppLabel;
    QRLabel2: TQRLabel;
    ppLabel2: TppLabel;
    gtAceExportInterface1: TgtAceExportInterface;
    DataSource1: TDataSource;
    Table1: TTable;
    Label1: TLabel;
    Label2: TLabel;
    SctReport1: TSctReport;
    ReportPage: TSctGrouppage;
    ReportHeaderBand: TSctBand;
    ReportHeaderBandlevel: TSctLevel;
    PageHeaderBand: TSctBand;
    PageHeaderBandlevel: TSctLevel;
    DetailBand: TSctBand;
    DetailBandlevel: TSctLevel;
    PageFooterBand: TSctBand;
    PageFooterBandlevel: TSctLevel;
    ReportFooterBand: TSctBand;
    ReportFooterBandlevel: TSctLevel;
    Sctvarlabel1: TSctvarlabel;
    Sctvarlabel2: TSctvarlabel;
    SctImageLabel1: TSctImageLabel;
    RvSystem1: TRvSystem;
    RvProject1: TRvProject;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    {$IFDEF gtPro}
    FfrmProComponent: TfrmeDocProComponents;
    {$ENDIF}

    FEngine: TgtCustomDocumentEngine;
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
  SClipboardDescription = 'Windows Clipboard';

{$IFDEF gtPro}
  SSVGDescription = 'Scalable Vector Graphics (*.svg)|*.svg|';
  SPNGDescription = 'Portable Network Graphics (*.png)|*.png|';
  STIFFDescription = 'Tagged Image File Format (*.tif)|*.tif|';
{$ENDIF}

  var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  CFileExt: array[1..18] of string = ('pdf', 'rtf', 'htm', 'htm', 'txt',
                                      'xls', 'dif', 'wk2', 'wb1', 'slk',
                                      'bmp', 'jpg', 'emf', 'wmf', 'gif',
                                      'svg', 'png', 'tif');
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
  if (Trim(SaveDialog1.FileName) <> '') then
  begin
    case SaveDialog1.FilterIndex of
      1: FEngine := TgtPDFEngine.Create(Self);        //pdf
      2: FEngine := TgtRTFEngine.Create(Self);        //rtf
      3: FEngine := TgtHTMLEngine.Create(Self);       //htm
      4: FEngine := TgtXHTMLEngine.Create(Self);      //htm
      5: FEngine := TgtTextEngine.Create(Self);       //txt
      6: FEngine := TgtExcelEngine.Create(Self);      //xls
      7: FEngine := TgtDIFEngine.Create(Self);        //dif
      8: FEngine := TgtQuattroProEngine.Create(Self); //wk2
      9: FEngine := TgtLotusEngine.Create(Self);     //wb1
      10: FEngine := TgtSYLKEngine.Create(Self);      //slk
      11: FEngine := TgtBMPEngine.Create(Self);       //bmp
      12: FEngine := TgtJPEGEngine.Create(Self);      //jpg
      13: FEngine := TgtEMFEngine.Create(Self);       //emf
      14: FEngine := TgtWMFEngine.Create(Self);       //wmf
      15: FEngine := TgtGIFEngine.Create(Self);       //gif
      {$IFDEF gtPro}
      16: gtRBExportInterface1.Engine := FfrmProComponent.gtSVGEngine1;
      17: gtRBExportInterface1.Engine := FfrmProComponent.gtPNGEngine1;
      18: gtRBExportInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
      {$ENDIF}
    end;
    IgtDocumentEngine(FEngine).FileName := SaveDialog1.FileName;

    gtQRExportInterface1.DoBeginDoc := False;
    gtQRExportInterface1.DoEndDoc := False;
    gtRaveExportInterface1.DoBeginDoc := False;
    gtRaveExportInterface1.DoEndDoc := False;
    gtFRExportInterface1.DoBeginDoc := False;
    gtFRExportInterface1.DoEndDoc := False;
    gtRBExportInterface1.DoBeginDoc := False;
    gtRBExportInterface1.DoEndDoc := False;
    gtAceExportInterface1.DoBeginDoc := False;
    gtAceExportInterface1.DoEndDoc := False;

    gtQRExportInterface1.Engine := FEngine;
    gtRaveExportInterface1.Engine := FEngine;
    gtFRExportInterface1.Engine := FEngine;
    gtRBExportInterface1.Engine := FEngine;
    gtAceExportInterface1.Engine := FEngine;

    IgtDocumentEngine(FEngine).BeginDoc;
    gtRaveExportInterface1.RenderDocument(RvSystem1, True);
    IgtDocumentEngine(FEngine).NewPage;
    gtFRExportInterface1.RenderDocument(frReport1, False, False);
    IgtDocumentEngine(FEngine).NewPage;
    gtRBExportInterface1.RenderDocument(ppReport1);
    IgtDocumentEngine(FEngine).NewPage;
    gtAceExportInterface1.RenderDocument(SctReport1);
    IgtDocumentEngine(FEngine).NewPage;
    gtQRExportInterface1.RenderDocument(QuickRep1, False);
    IgtDocumentEngine(FEngine).EndDoc;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}

	frReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'FR.frf');
	ppReport1.Template.FileName := ExtractFilePath(Application.ExeName) +
  	'RB.rtm';
  RvProject1.ProjectFile := ExtractFilePath(Application.ExeName) +
  	'RaveDemo.rav';
  RvSystem1.SystemFiler.FileName := ExtractFilePath(Application.ExeName) +
  	'RaveReports.ndr';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF gtPro}
  FfrmProComponent.Free;
  {$ENDIF}
end;

end.
