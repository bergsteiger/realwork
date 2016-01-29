// DISABLE THE SWITCH IF YOU ARE USING THE STANDARD EDITION OF eDocEngine
{.$DEFINE gtPro}

unit eDocRave;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtCstXLSEng, gtXLSEng, gtWMFEng,
  gtMetafileEng, gtEMFEng, gtBMPEng, gtGIFEng, gtCstGfxEng, gtJPEGEng,
  gtSLKEng, gtDIFEng, gtLotusEng, gtCstSpdEng, gtQProEng, gtTXTEng,
  gtXHTMLEng, gtCstHTMLEng, gtHTMLEng, gtRTFEng, gtCstDocEng,
  gtCstPlnEng, gtCstPDFEng, gtPDFEng, gtClasses3, gtXportIntf,
  gtRvXportIntf, RpBase, RpSystem, RpDefine, RpRender, RpRenderCanvas,
  RpRenderPreview, ExtCtrls, gtCstXLS95Eng, gtExXLS95Eng, gtXLS95Eng,
  gtExXLSEng, gtExHTMLEng, gtExPDFEng
  {$IFDEF gtPro}
  , gtExXLSEng, gtExHTMLEng, gtExPDFEng, eDocProComponents
  {$ENDIF}
  ;

type
  TfrmRave = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnLoadFile: TButton;
    btnExportfile: TButton;
    RvRenderPreview1: TRvRenderPreview;
    RvSystem1: TRvSystem;
    ScrollBox1: TScrollBox;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    gtRaveExportInterface1: TgtRaveExportInterface;
    gtDocSettings1: TgtDocSettings;
    gtPDFEngine1: TgtPDFEngine;
    gtRTFEngine1: TgtRTFEngine;
    gtHTMLEngine1: TgtHTMLEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
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
    gtExcelEngine1: TgtExcelEngine;
    btnNextPage: TButton;
    btnPrevPage: TButton;
    gtRaveExportInterface2: TgtRaveExportInterface;
    gtXLSEngine1: TgtXLSEngine;
    procedure btnLoadFileClick(Sender: TObject);
    procedure btnExportfileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  frmRave: TfrmRave;

implementation

{$R *.dfm}

procedure TfrmRave.btnLoadFileClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
  	Exit;
  RvRenderPreview1.Render(OpenDialog1.FileName);
end;

procedure TfrmRave.btnExportfileClick(Sender: TObject);
begin
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription+SXLSDescription;
    {$IFDEF gtPro}
    SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription +
      SPNGDescription + STIFFDescription;
    {$ENDIF}
  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: gtRaveExportInterface1.Engine := gtPDFEngine1;
    2: gtRaveExportInterface1.Engine := gtRTFEngine1;
    3: gtRaveExportInterface1.Engine := gtHTMLEngine1;
    4: gtRaveExportInterface1.Engine := gtXHTMLEngine1;
    5: gtRaveExportInterface1.Engine := gtTextEngine1;
    6: gtRaveExportInterface1.Engine := gtExcelEngine1;
    7: gtRaveExportInterface1.Engine := gtDIFEngine1;
    8: gtRaveExportInterface1.Engine := gtQuattroProEngine1;
    9: gtRaveExportInterface1.Engine := gtLotusEngine1;
    10: gtRaveExportInterface1.Engine := gtSYLKEngine1;
    11: gtRaveExportInterface1.Engine := gtBMPEngine1;
    12: gtRaveExportInterface1.Engine := gtJPEGEngine1;
    13: gtRaveExportInterface1.Engine := gtEMFEngine1;
    14: gtRaveExportInterface1.Engine := gtWMFEngine1;
    15: gtRaveExportInterface1.Engine := gtGIFEngine1;
    16: gtRaveExportInterface1.Engine := gtXLSEngine1;
    {$IFDEF gtPro}
    17: gtRaveExportInterface1.Engine := FfrmProComponent.gtSVGEngine1;
    18: gtRaveExportInterface1.Engine := FfrmProComponent.gtPNGEngine1;
    19: gtRaveExportInterface1.Engine := FfrmProComponent.gtTIFFEngine1;
    {$ENDIF}
  end;
  IgtDocumentEngine(gtRaveExportInterface1.Engine).FileName := SaveDialog1.FileName;
  IgtDocumentEngine(gtRaveExportInterface1.Engine).Preferences.UseImagesAsResources := False;
  IgtDocumentEngine(gtRaveExportInterface1.Engine).Preferences.ProcessAfterEachPage := True;
  RvSystem1.SystemFiler.FileName := OpenDialog1.FileName;
  gtRaveExportInterface1.RenderDocument(RvSystem1, True);
end;

procedure TfrmRave.FormShow(Sender: TObject);
begin
  {$IFDEF gtPro}
  FfrmProComponent := TfrmeDocProComponents.Create(Application);
  {$ENDIF}
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) +
  	'RaveNDRFile.ndr';
  RvRenderPreview1.Render(OpenDialog1.FileName);
end;

procedure TfrmRave.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFDEF gtPro}
  FfrmProComponent.Free;
  {$ENDIF}
end;

procedure TfrmRave.btnNextPageClick(Sender: TObject);
begin
  RvRenderPreview1.NextPage;
end;

procedure TfrmRave.btnPrevPageClick(Sender: TObject);
begin
  RvRenderPreview1.PrevPage;
end;

end.
