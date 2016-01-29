// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{$DEFINE gtPro}

unit eDocFR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtWMFEng, gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng,
  gtJPEGEng, gtCstGfxEng, gtSLKEng, gtDIFEng, gtLotusEng, gtQProEng,
  gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtXLSEng, gtXHTMLEng, gtCstHTMLEng,
  gtHTMLEng, gtRTFEng, gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtXportIntf,
  gtFRXportIntf, frxClass, gtPDFEng,gtClasses3, frxPreview, ExtCtrls,
  frxDesgn, frxDCtrl, frxChart, frxRich, frxBarcode, ImgList,
  ComCtrls, frxOLE, frxCross, frxADOComponents, frxPrinter
  {$IFDEF gtPro}
  , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents
  {$ENDIF}
  ;

type
  TfrmFR = class(TForm)
    frxPreview1: TfrxPreview;
    frxReport1: TfrxReport;
    pnlButtons: TPanel;
    btnLoadfile: TButton;
    btnExportfile: TButton;
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
    gtFRFilter: TgtFRExportInterface;
    procedure btnLoadfileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  frmFR: TfrmFR;

implementation

{$R *.dfm}

procedure TfrmFR.btnLoadfileClick(Sender: TObject);
begin
  frxReport1.Clear;
  OpenDialog1.Filter := 'FP3 file|*.Fp3' ;
  if not OpenDialog1.Execute then
    Exit;
  frxPreview1.LoadFromFile(OpenDialog1.FileName);
  frxReport1.ShowPreparedReport;
end;

procedure TfrmFR.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter :=
  SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
  STextDescription + SExcelDescription + SDIFDescription +
  SQuattroProDescription + SLotusDescription + SSYLKDescription +
  SBMPDescription + SJPEGDescription + SEMFDescription + SWMFDescription +     SGIFDescription;
  {$IFDEF gtPro}
  SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription +
  SPNGDescription + STIFFDescription;
  {$ENDIF}
  if not SaveDialog1.Execute then
    Exit;
  case SaveDialog1.FilterIndex of
    1: gtFRFilter.Engine := gtPDFEngine1;
    2: gtFRFilter.Engine := gtRTFEngine1;
    3: gtFRFilter.Engine := gtHTMLEngine1;
    4: gtFRFilter.Engine := gtXHTMLEngine1;
    5: gtFRFilter.Engine := gtTextEngine1;
    6: gtFRFilter.Engine := gtExcelEngine1;
    7: gtFRFilter.Engine := gtDIFEngine1;
    8: gtFRFilter.Engine := gtQuattroProEngine1;
    9: gtFRFilter.Engine := gtLotusEngine1;
    10: gtFRFilter.Engine := gtSYLKEngine1;
    11: gtFRFilter.Engine := gtBMPEngine1;
    12: gtFRFilter.Engine := gtJPEGEngine1;
    13: gtFRFilter.Engine := gtEMFEngine1;
    14: gtFRFilter.Engine := gtWMFEngine1;
    15: gtFRFilter.Engine := gtGIFEngine1;
    {$IFDEF gtPro}
    16: gtFRFilter.Engine := FfrmProComponent.gtSVGEngine1;
    17: gtFRFilter.Engine := FfrmProComponent.gtPNGEngine1;
    18: gtFRFilter.Engine := FfrmProComponent.gtTIFFEngine1;
    {$ENDIF}
  end;
  IgtDocumentEngine(gtFRFilter.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtFRFilter.Engine).Preferences.ShowSetupDialog := True;
  gtFRFilter.RenderDocument(frxReport1, True, True);
end;

procedure TfrmFR.FormCreate(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) + 'FastReport.fp3';
  frxPreview1.LoadFromFile(OpenDialog1.FileName);
  frxReport1.ShowPreparedReport;
end;

procedure TfrmFR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF gtPro}
  FfrmProComponent.Free;
  {$ENDIF}
end;

end.

