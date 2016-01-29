unit eDocScaleRichView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, gtClasses3, gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtExPDFEng,
  gtPDFEng, SclRView, StdCtrls, ExtCtrls, gtUtils3, gtWMFEng, gtMetafileEng,
  gtEMFEng, gtBMPEng, gtGIFEng, gtJPEGEng, gtSVGEng, gtPNGEng, gtCstGfxEng,
  gtTIFFEng, gtSLKEng, gtDIFEng, gtLotusEng, gtQProEng, gtTXTEng, gtCstSpdEng,
  gtCstXLSEng, gtExXLSEng, gtXLSEng, gtXHTMLEng, gtCstHTMLEng, gtExHTMLEng,
  gtHTMLEng, gtRTFEng, gtXportIntf, gtScaleRichViewIntf, gtCstXLS95Eng,
  gtExXLS95Eng, gtXLS95Eng, RVScroll;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    gtDocSettings1: TgtDocSettings;
    gtRTFEngine1: TgtRTFEngine;
    gtHTMLEngine1: TgtHTMLEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
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
    SaveDialog1: TSaveDialog;
    Panel2: TPanel;
    SRichViewEdit1: TSRichViewEdit;
    Button2: TButton;
    gtXLSEngine1: TgtXLSEngine;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    gtScaleRichViewInterface1: TgtScaleRichViewInterface;
    gtPDFEngine1: TgtPDFEngine;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    Exit;
  SRichViewEdit1.RVHeader.Clear;
  SRichViewEdit1.RVFooter.Clear;
  SRichViewEdit1.RichViewEdit.Clear;
  case OpenDialog1.FilterIndex of
    1:
      begin
        SRichViewEdit1.LoadRVF(OpenDialog1.FileName);
        SRichViewEdit1.Format;
      end;
    2:
      begin
        SRichViewEdit1.RichViewEdit.LoadRTF(OpenDialog1.FileName);
        SRichViewEdit1.RichViewEdit.Format;
      end;
  end;
  SRichViewEdit1.RVHeader.Format;
  SRichViewEdit1.RVFooter.Format;
  SRichViewEdit1.SetRVMargins;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SaveDialog1.Filter := SPDFDescription + SRTFDescription + SHTMLDescription +
    SXHTMLDescription + SSVGDescription + STextDescription + SExcelDescription +
    SDIFDescription + SQuattroProDescription + SLotusDescription +
    SSYLKDescription + SPNGDescription + STIFFDescription + SBMPDescription +
    SJPEGDescription + SEMFDescription + SWMFDescription + SGIFDescription +
    SXLSDescription;

  if not SaveDialog1.Execute then
    Exit;
  case SaveDialog1.FilterIndex of
    1:
      gtScaleRichViewInterface1.Engine := gtPDFEngine1;
    2:
      gtScaleRichViewInterface1.Engine := gtRTFEngine1;
    3:
      gtScaleRichViewInterface1.Engine := gtHTMLEngine1;
    4:
      gtScaleRichViewInterface1.Engine := gtXHTMLEngine1;
    5:
      gtScaleRichViewInterface1.Engine := gtSVGEngine1;
    6:
      gtScaleRichViewInterface1.Engine := gtTextEngine1;
    7:
      gtScaleRichViewInterface1.Engine := gtExcelEngine1;
    8:
      gtScaleRichViewInterface1.Engine := gtDIFEngine1;
    9:
      gtScaleRichViewInterface1.Engine := gtQuattroProEngine1;
    10:
      gtScaleRichViewInterface1.Engine := gtLotusEngine1;
    11:
      gtScaleRichViewInterface1.Engine := gtSYLKEngine1;
    12:
      gtScaleRichViewInterface1.Engine := gtPNGEngine1;
    13:
      gtScaleRichViewInterface1.Engine := gtTIFFEngine1;
    14:
      gtScaleRichViewInterface1.Engine := gtBMPEngine1;
    15:
      gtScaleRichViewInterface1.Engine := gtJPEGEngine1;
    16:
      gtScaleRichViewInterface1.Engine := gtEMFEngine1;
    17:
      gtScaleRichViewInterface1.Engine := gtWMFEngine1;
    18:
      gtScaleRichViewInterface1.Engine := gtGIFEngine1;
    19:
      gtScaleRichViewInterface1.Engine := gtXLSEngine1;
  end;

  gtScaleRichViewInterface1.RenderingOptions := [];
  if CheckBox1.Checked then
    gtScaleRichViewInterface1.RenderingOptions :=
      gtScaleRichViewInterface1.RenderingOptions + [srvroPageNoVisible];
  if CheckBox2.Checked then
    gtScaleRichViewInterface1.RenderingOptions :=
      gtScaleRichViewInterface1.RenderingOptions + [srvroClipMargins];
  if CheckBox3.Checked then
    gtScaleRichViewInterface1.RenderingOptions :=
      gtScaleRichViewInterface1.RenderingOptions + [srvroPrinting];

  IgtDocumentEngine(gtScaleRichViewInterface1.Engine).FileName :=
    SaveDialog1.FileName;

  gtScaleRichViewInterface1.RenderDocument(SRichViewEdit1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenDialog1.FileName := ExtractFilePath(Application.ExeName) +
    'SRichView.rvf';
  SRichViewEdit1.LoadRVF(OpenDialog1.FileName);
  SRichViewEdit1.Format;
end;

end.
