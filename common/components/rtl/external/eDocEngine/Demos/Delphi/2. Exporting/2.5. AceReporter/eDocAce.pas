// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{$DEFINE gtPro}

unit eDocAce;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, gtWMFEng, gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng,
  gtCstGfxEng, gtJPEGEng, gtSLKEng, gtDIFEng, gtLotusEng, gtQProEng,
  gtTXTEng, gtCstSpdEng, gtCstXLSEng, gtXLSEng, gtXHTMLEng,
  gtCstHTMLEng, gtHTMLEng, gtRTFEng, gtCstDocEng, gtCstPlnEng,
  gtCstPDFEng, gtPDFEng, gtClasses3, gtXportIntf,
  gtAceXportIntf, AcePrev, StdCtrls, ExtCtrls
  {$IFDEF gtPro}
  , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents, gtCstXLS95Eng,
  gtExXLS95Eng, gtXLS95Eng
  {$ENDIF}
  ;

type
  TfrmAce = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnLoadFile: TButton;
    Button2: TButton;
    AcePreview1: TAcePreview;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    gtAceExportInterface1: TgtAceExportInterface;
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
    btnNextPage: TButton;
    btnPrevPage: TButton;
    gtXLSEngine1: TgtXLSEngine;
    procedure btnLoadFileClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  frmAce: TfrmAce;

implementation

{$R *.dfm}

procedure TfrmAce.btnLoadFileClick(Sender: TObject);
begin
	if OpenDialog1.Execute then
		AcePreview1.LoadFromFile(OpenDialog1.FileName);
end;

procedure TfrmAce.Button2Click(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription+ SXLSDescription;
    {$IFDEF gtPro}
    SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription +
      SPNGDescription + STIFFDescription;
    {$ENDIF}


  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtAceExportInterface1.Engine := gtPDFEngine1;
    2: gtAceExportInterface1.Engine := gtRTFEngine1;
    3: gtAceExportInterface1.Engine := gtHTMLEngine1;
    4: gtAceExportInterface1.Engine := gtXHTMLEngine1;
    5: gtAceExportInterface1.Engine := gtTextEngine1;
    6: gtAceExportInterface1.Engine := gtExcelEngine1;
    7: gtAceExportInterface1.Engine := gtDIFEngine1;
    8: gtAceExportInterface1.Engine := gtQuattroProEngine1;
    9: gtAceExportInterface1.Engine := gtLotusEngine1;
    10: gtAceExportInterface1.Engine := gtSYLKEngine1;
    11: gtAceExportInterface1.Engine := gtBMPEngine1;
    12: gtAceExportInterface1.Engine := gtJPEGEngine1;
    13: gtAceExportInterface1.Engine := gtEMFEngine1;
    14: gtAceExportInterface1.Engine := gtWMFEngine1;
    15: gtAceExportInterface1.Engine := gtGIFEngine1;
    16: gtAceExportInterface1.Engine := gtXLSEngine1;
    {$IFDEF gtPro}
    17: gtAceExportInterface1.Engine := FfrmProComponent.gtSVGEngine1;
    18: gtAceExportInterface1.Engine := FfrmProComponent.gtPNGEngine1;
    19: gtAceExportInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
    {$ENDIF}
  end;
  IgtDocumentEngine(gtAceExportInterface1.Engine).FileName :=  SaveDialog1.Filename;
  IgtDocumentEngine(gtAceExportInterface1.Engine).Page.LeftMargin := 0;
  IgtDocumentEngine(gtAceExportInterface1.Engine).Page.TopMargin := 0;
  IgtDocumentEngine(gtAceExportInterface1.Engine).Preferences.ProcessAfterEachPage := True;
  IgtDocumentEngine(gtAceExportInterface1.Engine).Preferences.ShowSetupDialog := True;
  gtAceExportInterface1.RenderDocument(OpenDialog1.FileName);
end;

procedure TfrmAce.FormCreate(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}
	AcePreview1.LoadFromFile(ExtractFilePath(Application.ExeName) + 'AceFile.ace');
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) + 'AceFile.ace';
end;

procedure TfrmAce.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF gtPro}
  FfrmProComponent.Free;
  {$ENDIF}
end;

procedure TfrmAce.btnNextPageClick(Sender: TObject);
begin
  AcePreview1.NextPage;
end;

procedure TfrmAce.btnPrevPageClick(Sender: TObject);
begin
  AcePreview1.PriorPage;
end;

end.
