unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, gtTIFFEng, gtSLKEng, gtQProEng, gtDIFEng, gtSVGEng,
  gtPNGEng, gtJPEGEng, gtCstGfxEng, gtBMPEng, gtLotusEng, gtTXTEng, gtCstSpdEng,
  gtCstXLSEng, gtExXLSEng, gtXLSEng, gtXHTMLEng, gtCstHTMLEng, gtExHTMLEng,
  gtHTMLEng, gtRTFEng, gtClasses3, gtCstDocEng, gtCstPlnEng, gtCstPDFEng,
  gtExPDFEng, gtPDFEng, gtUtils3, gtWMFEng, gtMetafileEng, gtEMFEng, gtGIFEng,
  ExtCtrls, gtCstXLS95Eng, gtExXLS95Eng, gtXLS95Eng;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    gtPDFEngine1: TgtPDFEngine;
    gtRTFEngine1: TgtRTFEngine;
    gtHTMLEngine1: TgtHTMLEngine;
    gtXHTMLEngine1: TgtXHTMLEngine;
    gtTextEngine1: TgtTextEngine;
    gtLotusEngine1: TgtLotusEngine;
    gtBMPEngine1: TgtBMPEngine;
    gtJPEGEngine1: TgtJPEGEngine;
    gtPNGEngine1: TgtPNGEngine;
    gtSVGEngine1: TgtSVGEngine;
    gtDIFEngine1: TgtDIFEngine;
    gtQuattroProEngine1: TgtQuattroProEngine;
    gtSYLKEngine1: TgtSYLKEngine;
    gtTIFFEngine1: TgtTIFFEngine;
    gtEMFEngine1: TgtEMFEngine;
    gtWMFEngine1: TgtWMFEngine;
    gtGIFEngine1: TgtGIFEngine;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Edit3: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    RadioGroup1: TRadioGroup;
    gtXLSEngine1: TgtXLSEngine;
    gtExcelEngine1: TgtExcelEngine;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
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
  Form3: TForm3;
  LMeta: TMetafile;
  Engine: TgtCustomDocumentEngine;

implementation

{$R *.dfm}


procedure TForm3.Button1Click(Sender: TObject);
begin
  OpenDialog1.Filter :=  SEMFDescription + SWMFDescription  ;
  OpenDialog1.Execute;
  Edit3.Color := clWhite;
  Edit3.Text := OpenDialog1.FileName;
end;

procedure TForm3.Button2Click(Sender: TObject);
var
  XRes, YRes : Integer;
begin
  Engine := TgtCustomDocumentEngine.Create(Self);
  SaveDialog1.Filter :=
    SPDFDescription + SRTFDescription + SHTMLDescription + SXHTMLDescription +
    STextDescription + SExcelDescription + SDIFDescription +
    SQuattroProDescription + SLotusDescription + SSYLKDescription +
    SBMPDescription + SJPEGDescription +
    SEMFDescription + SWMFDescription + SGIFDescription+ SXLSDescription ;
    {$IFDEF gtPro}
    SaveDialog1.Filter := SaveDialog1.Filter + SSVGDescription +
      SPNGDescription + STIFFDescription;
    {$ENDIF}

  if not SaveDialog1.Execute then
  	Exit;
  case SaveDialog1.FilterIndex of
    1: Engine := gtPDFEngine1;
    2: Engine := gtRTFEngine1;
    3: Engine := gtHTMLEngine1;
    4: Engine := gtXHTMLEngine1;
    5: Engine := gtTextEngine1;
    6: Engine := gtExcelEngine1;
    7: Engine := gtDIFEngine1;
    8: Engine := gtQuattroProEngine1;
    9: Engine := gtLotusEngine1;
    10: Engine := gtSYLKEngine1;
    11: Engine := gtBMPEngine1;
    12: Engine := gtJPEGEngine1;
    13: Engine := gtEMFEngine1;
    14: Engine := gtWMFEngine1;
    15: Engine := gtGIFEngine1;
    16: Engine := gtXLSEngine1;
    {$IFDEF gtPro}
    17: Engine := FfrmProComponent.gtSVGEngine1;
    18: Engine := FfrmProComponent.gtPNGEngine1;
    19: Engine := FfrmProComponent.gtTIFFEngine1;
    {$ENDIF}
  end;

  with IgtDocumentEngine(Engine) do
  begin
    FileName := SaveDialog1.FileName;
    Preferences.UseImagesAsResources := False;
    Preferences.ProcessAfterEachPage := True;
    XRes :=  StrToIntDef(Edit1.Text,0);
    YRes :=  StrToIntDef(Edit2.Text,0);
    if XRes = 0 then
      XRes := 96;
    if YRes = 0 then
      YRes := 96;
    Edit1.Text := IntToStr(XRes);
    Edit2.Text := IntToStr(YRes);
    Engine.InputXRes := XRes;
    Engine.InputXRes := XRes;
    BeginDoc;
      LMeta := TMetafile.Create ;
      LMeta.LoadFromFile(OpenDialog1.FileName);
      if RadioGroup1.ItemIndex = 0  then
        PlayMetafile(gtRect(0, 0, Page.Width, Page.Height), LMeta);
      if RadioGroup1.ItemIndex = 1 then
      begin
        Page.PaperSize := Custom;
        page.Width := LMeta.Width;
        page.Height := LMeta.Height;
        PlayMetafile(LMeta);

      end;
		EndDoc;
  end;
end;


end.
