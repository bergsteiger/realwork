(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit iopreviews;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEDIALOGIO}

interface



uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  ImageEnProc, ComCtrls, StdCtrls, ImageEnView, ImageEn, ExtCtrls, ImageEnIO,
  Buttons,hyiedefs, ieview, hyieutils, Dialogs;

type
  TfIOPreviews = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheetJPEG1: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Edit22: TEdit;
    TrackBar13: TTrackBar;
    GroupBox5: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    CheckBox2: TCheckBox;
    ComboBox1: TComboBox;
    Edit23: TEdit;
    UpDown11: TUpDown;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox3: TCheckBox;
    Button3: TButton;
    TabSheetTIFF1: TTabSheet;
    Label5: TLabel;
    ComboBox2: TComboBox;
    Label6: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label7: TLabel;
    ComboBox3: TComboBox;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label12: TLabel;
    Edit4: TEdit;
    Label13: TLabel;
    Edit5: TEdit;
    Label14: TLabel;
    Edit6: TEdit;
    Label15: TLabel;
    Edit7: TEdit;
    Label16: TLabel;
    Edit8: TEdit;
    Label19: TLabel;
    ComboBox4: TComboBox;
    TabSheetGIF1: TTabSheet;
    Label20: TLabel;
    Edit9: TEdit;
    UpDown2: TUpDown;
    Label21: TLabel;
    ComboBox5: TComboBox;
    Label34: TLabel;
    Panel3: TPanel;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label35: TLabel;
    Panel4: TPanel;
    GroupBox2: TGroupBox;
    Edit12: TEdit;
    Label33: TLabel;
    Label31: TLabel;
    Edit10: TEdit;
    Label32: TLabel;
    Edit11: TEdit;
    Label36: TLabel;
    TabSheetBMP1: TTabSheet;
    Label37: TLabel;
    ComboBox6: TComboBox;
    Label38: TLabel;
    ComboBox7: TComboBox;
    TabSheetPCX1: TTabSheet;
    Label43: TLabel;
    ComboBox8: TComboBox;
    Label44: TLabel;
    ComboBox9: TComboBox;
    TabSheetPNG1: TTabSheet;
    Label49: TLabel;
    ComboBox10: TComboBox;
    Label54: TLabel;
    Panel1: TPanel;
    ColorDialog1: TColorDialog;
    GroupBox3: TGroupBox;
    Label55: TLabel;
    ComboBox11: TComboBox;
    CheckBox6: TCheckBox;
    Label56: TLabel;
    ComboBox12: TComboBox;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ImageEn1: TImageEnView;
    ImageEn2: TImageEnView;
    ProgressBar1: TProgressBar;
    Label57: TLabel;
    ComboBox13: TComboBox;
    TabSheetTGA1: TTabSheet;
    Label62: TLabel;
    ComboBox14: TComboBox;
    Label63: TLabel;
    Panel5: TPanel;
    CheckBox1: TCheckBox;
    Label64: TLabel;
    Edit13: TEdit;
    Label65: TLabel;
    Edit14: TEdit;
    Label9: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Button4: TButton;
    TabSheetJ20001: TTabSheet;
    Label66: TLabel;
    Edit15: TEdit;
    TrackBar1: TTrackBar;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    ComboBox15: TComboBox;
    TabSheetJPEG2: TTabSheet;
    Label72: TLabel;
    Edit16: TEdit;
    TrackBar2: TTrackBar;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    TabSheetTIFF2: TTabSheet;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    ComboBox16: TComboBox;
    Label82: TLabel;
    ComboBox17: TComboBox;
    TabSheetGIF2: TTabSheet;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    ComboBox18: TComboBox;
    chkLockPreview: TCheckBox;
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit22Change(Sender: TObject);
    procedure TrackBar13Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ImageEn1ViewChange(Sender: TObject; Change: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure ComboBox5Click(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox10Change(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure ComboBox14Click(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit15Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit16Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure ComboBox16Change(Sender: TObject);
    procedure ComboBox18Change(Sender: TObject);
  private
    { Private declarations }
    pp:TPreviewParams;
    msgCancel:string;	// Stringa 'Cancel'
    dochange:boolean;	// se true i controlli possono cambiare il loro stato
    fImageEnIO:TImageEnIO;
    fImageEnProc:TImageEnProc;
    procedure applyAct(im:TImageEnView);
    function HasTIFFLZW:boolean;
	 function CompToCombo(v:TIOTIFFCompression):integer;
	 function ComboToComp(i:integer):TIOTIFFCompression;
  public
    { Public declarations }
    fSimplified:boolean;   // use simplified tabs
    fParams:TIOParamsVals;
    JPEG_Quality:integer;
    JPEG_Photometric:integer;
    JPEG_DCTMethod:integer;
    JPEG_OptimalHuffman:boolean;
    JPEG_Smooth:integer;
    JPEG_Progressive:boolean;
    {$ifdef IEINCLUDEJPEG2000}
    J2000_Rate:double;
    J2000_ColorSpace:integer;
    {$endif}
    TIFF_Compression:TIOTIFFCompression;
    TIFF_ImageIndex:integer;
    TIFF_PhotometInterpret:TIOTIFFPhotometInterpret;
    TIFF_XPos:integer;
    TIFF_YPos:integer;
    TIFF_DocumentName:string;
    TIFF_ImageDescription:string;
    TIFF_PageName:string;
    TIFF_PageNumber:integer;
    TIFF_PageCount:integer;
    TIFF_BitsPerSample:integer;
    TIFF_SamplesPerPixel:integer;
    TIFF_LZWDecompFunc:TTIFFLZWDecompFunc;
    TIFF_LZWCompFunc:TTIFFLZWCompFunc;
    GIF_ImageIndex:integer;
    GIF_XPos:integer;
    GIF_YPos:integer;
    GIF_DelayTime:integer;
    GIF_FlagTranspColor:boolean;
    GIF_TranspColor:TRGB;
    GIF_Interlaced:boolean;
    GIF_Background:TRGB;
    GIF_BitsPerSample:integer;
    GIF_LZWDecompFunc:TGIFLZWDecompFunc;
    GIF_LZWCompFunc:TGIFLZWCompFunc;
    BMP_Compression:TIOBMPCompression;
    BMP_BitsPerPixel:integer;	// index of comboxbox (0=1bit, 1=4bit, 2=8bit...)
    PCX_Compression:TIOPCXCompression;
    PCX_BitsPerPixel:integer;	// index of comboxbox (0=1bit, 1=4bit, 2=8bit...)
    PNG_Colors:integer;
    PNG_Interlaced:boolean;
    PNG_Background:TRGB;
    PNG_Filter:integer;
    PNG_Compression:integer;
    TGA_Colors:integer; // index (0=1bit, 1=8bit, 2=24bit)
    TGA_Background:TRGB;
    TGA_Compressed:boolean;
    TGA_Name:string;
    TGA_Description:string;
    DefaultLockPreview:boolean;
    ars:array [0..7] of boolean;
    xper:integer;
    xdiv:integer;
    fDefaultDitherMethod:TIEDitherMethod;
    procedure SetLanguage(l:TMsgLanguage);
    procedure ApplyParameters;
    procedure ResetParameters;
    procedure Progress(Sender: TObject; per: Integer);
  	 function SetPreviewParams(xpp:TPreviewParams):boolean;
  end;

implementation

{$R-}

{$R *.DFM}

function TfIOPreviews.HasTIFFLZW:boolean;
begin
	result:= @DefTIFF_LZWCOMPFUNC<>nil;
end;

// convert from compression value to combobox index
function TfIOPreviews.CompToCombo(v:TIOTIFFCompression):integer;
var
	d:integer;
begin
	result:=0;
	if not HasTIFFLZW then d:=1 else d:=0;
   case v of
      ioTIFF_UNCOMPRESSED: result:=0;
      ioTIFF_CCITT1D: result:=1;
      ioTIFF_G3FAX1D: result:=2;
      ioTIFF_G3FAX2D: result:=3;
      ioTIFF_G4FAX: result:=4;
      ioTIFF_LZW:
      	begin
            if HasTIFFLZW then
               result:=5
            else
               result:=6;	// if not lzw available set packbits
         end;
      ioTIFF_JPEG: result:=6-d;	// 5 if not lzw
      ioTIFF_PACKBITS: result:=7-d;	// 6 if not lzw
      ioTIFF_UNKNOWN: result:=0;	// unknow becomes uncompressed
   end;
end;

// convert from combobox index to compression value
function TfIOpreviews.ComboToComp(i:integer):TIOTIFFCompression;
begin
	result:=ioTIFF_UNCOMPRESSED;
	case i of
   	0: result:=ioTIFF_UNCOMPRESSED;
      1: result:=ioTIFF_CCITT1D;
      2: result:=ioTIFF_G3FAX1D;
      3: result:=ioTIFF_G3FAX2D;
      4: result:=ioTIFF_G4FAX;
      5: if HasTIFFLZW then result:=ioTIFF_LZW else result:=ioTIFF_JPEG;
      6: if HasTIFFLZW then result:=ioTIFF_JPEG else result:=ioTIFF_PACKBITS;
      7: if HasTIFFLZW then result:=ioTIFF_PACKBITS;
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.FormDestroy(Sender: TObject);
begin
	fImageEnIO.free;
   fImageEnProc.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.FormCreate(Sender: TObject);
{$ifdef IEFIXPREVIEWS}
var
	q:integer;
{$endif}
begin
	fDefaultDitherMethod:=ieThreshold;
   with ImageEn1.IO do begin
      PreviewFont.Charset := DEFAULT_CHARSET;
      PreviewFont.Color := clWindowText;
      PreviewFont.Height := -11;
      PreviewFont.Name := 'MS Sans Serif';
      PreviewFont.Style := [];
   end;
   with ImageEn2.IO do begin
      PreviewFont.Charset := DEFAULT_CHARSET;
      PreviewFont.Color := clWindowText;
      PreviewFont.Height := -11;
      PreviewFont.Name := 'MS Sans Serif';
      PreviewFont.Style := [];
   end;
	fImageEnIO:=TImageEnIO.Create(self);
   fImageEnIO.OnProgress:=Progress;
   fImageEnIO.StreamHeaders:=false;
   fImageEnProc:=TImageEnProc.Create(Self);
   msgCancel:='&Cancel';
	{$ifdef IEFIXPREVIEWS}
	for q:=0 to ComponentCount-1 do
   	if (Components[q] is TTrackBar) then
      	(Components[q] as TTrackBar).ThumbLength:=10;
	{$endif}
   {$ifdef IEDELPHI7}
   Panel3.ParentBackground:=false;
   Panel4.ParentBackground:=false;
   Panel1.ParentBackground:=false;
   Panel5.ParentBackground:=false;
   {$endif}
   Button4.Enabled:=False;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.ResetParameters;
begin
   // JPEG PARAMETERS
   JPEG_Quality:=fParams.JPEG_Quality;
   JPEG_Photometric:= ord(fParams.JPEG_ColorSpace);
   case fParams.JPEG_DCTMethod of
   	ioJPEG_ISLOW: JPEG_DCTMethod:=0;
      ioJPEG_IFAST: JPEG_DCTMethod:=1;
      ioJPEG_FLOAT: JPEG_DCTMethod:=2;
   end;
   JPEG_OptimalHuffman:=fParams.JPEG_OptimalHuffman;
   JPEG_Smooth:=fParams.JPEG_Smooth;
   JPEG_Progressive:=fParams.JPEG_Progressive;
   // JPEG2000 PARAMETERS
   {$ifdef IEINCLUDEJPEG2000}
   J2000_Rate:=fParams.J2000_Rate;
   J2000_ColorSpace:=integer(fParams.J2000_ColorSpace);
   {$endif}
   // TIFF PARAMETERS
   TIFF_LZWDecompFunc:=fParams.TIFF_LZWDecompFunc;
   TIFF_LZWCompFunc:=fParams.TIFF_LZWCompFunc;
   TIFF_Compression:=fParams.TIFF_Compression;
   TIFF_ImageIndex:=fParams.TIFF_ImageIndex;
   TIFF_PhotometInterpret:=fParams.TIFF_PhotometInterpret;
   TIFF_XPos:=fParams.TIFF_XPos;
   TIFF_YPos:=fParams.TIFF_YPos;
   TIFF_DocumentName:=fParams.TIFF_DocumentName;
   TIFF_ImageDescription:=fParams.TIFF_ImageDescription;
   TIFF_PageName:=fParams.TIFF_PageName;
   TIFF_PageNumber:=fParams.TIFF_PageNumber;
   TIFF_PageCount:=fParams.TIFF_PageCount;
   TIFF_SamplesPerPixel:=fParams.SamplesPerPixel;
   TIFF_BitsPerSample:=fParams.BitsPerSample;
   // GIF PARAMETERS
   GIF_LZWDecompFunc:=fParams.GIF_LZWDecompFunc;
   GIF_LZWCompFunc:=fParams.GIF_LZWCompFunc;
   GIF_ImageIndex:=fParams.GIF_ImageIndex;
   GIF_XPos:=fParams.GIF_XPos;
   GIF_YPos:=fParams.GIF_YPos;
   GIF_DelayTime:=fParams.GIF_DelayTime;
   GIF_FlagTranspColor:=fParams.GIF_FlagTranspColor;
   GIF_TranspColor:=fParams.GIF_TranspColor;
   GIF_Interlaced:=fParams.GIF_Interlaced;
   GIF_Background:=fParams.GIF_Background;
   GIF_BitsPerSample:=fParams.BitsPerSample;
   // BMP PARAMETERS
   BMP_Compression:=fParams.BMP_Compression;
   if fParams.SamplesPerPixel=1 then begin
		case fParams.BitsPerSample of
      	1: BMP_BitsPerPixel:=0;
         4: BMP_BitsPerPixel:=1;
         8: BMP_BitsPerPixel:=2;
      end;
   end else if fParams.SamplesPerPixel=3 then begin
		case fParams.BitsPerSample of
      	5: BMP_BitsPerPixel:=3;
         8: BMP_BitsPerPixel:=4;
      end;
   end;
   // PCX PARAMETERS
   PCX_Compression:=fParams.PCX_Compression;
   if fParams.SamplesPerPixel=1 then begin
		case fParams.BitsPerSample of
      	1: PCX_BitsPerPixel:=0;
         4: PCX_BitsPerPixel:=1;
         8: PCX_BitsPerPixel:=2;
      end;
   end else if fParams.SamplesPerPixel=3 then
   	PCX_BitsPerPixel:=3;
   // PNG PARAMETERS
   if fParams.SamplesPerPixel=1 then begin
   	if fParams.BitsPerSample=1 then
      	PNG_Colors:=0	// BW
      else
      	PNG_Colors:=1;	// 256 (palette)
   end else
   	PNG_Colors:=2;	// True color
   PNG_Interlaced:=fParams.PNG_Interlaced;
   PNG_Background:=fParams.PNG_Background;
   PNG_Filter:=ord(fParams.PNG_Filter)-ord(ioPNG_FILTER_NONE);
   PNG_Compression:=fParams.PNG_Compression;
   // TGA Parameters
   if fParams.SamplesPerPixel=1 then begin
   	if fparams.BitsPerSample=1 then
      	TGA_Colors:=0
      else
      	TGA_Colors:=1;
   end else
   	TGA_Colors:=2;
   TGA_Background:=fParams.TGA_Background;
   TGA_Compressed:=fParams.TGA_Compressed;
   TGA_Name:=fParams.TGA_ImageName;
   TGA_Description:=fParams.TGA_Descriptor;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.ApplyParameters;
var
	lw,idim:integer;
   xbitcount:integer;
begin
	dochange:=false;
   // pf1bit and pf24bit only are supported now
   case imageen1.bitmap.PixelFormat of
   	pf1bit: xbitcount:=1;
      //pf8bit: xbitcount:=8;
      //pf16bit: xbitcount:=16;
      //pf32bit: xbitcount:=32;
      else xbitcount:=24;
   end;
   lw:=(((imageen1.bitmap.Width*xBitCount)+31) div 32) * 4;
   idim:=lw*imageen1.bitmap.height;
   if (PageControl1.ActivePage=TabSheetJPEG1) then begin
      // JPEG
      edit22.text:=inttostr(JPEG_Quality);
      trackbar13.position:=JPEG_Quality;
      combobox13.itemindex:=JPEG_Photometric;
      combobox1.itemindex:=JPEG_DCTMethod;
      checkbox2.checked:=JPEG_OptimalHuffman;
      label4.caption:=inttostr(idim)+' bytes';
      checkbox3.Checked:=JPEG_Progressive;
      edit23.text:=inttostr(JPEG_Smooth);
   end;
   if (PageControl1.ActivePage=TabSheetJPEG2) then begin
      // JPEG simplified
      edit16.text:=inttostr(JPEG_Quality);
      trackbar2.position:=JPEG_Quality;
      Label74.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetJ20001) then begin
      // JPEG2000
      {$ifdef IEINCLUDEJPEG2000}
      edit15.text:=inttostr(round(J2000_Rate*1000));
      TrackBar1.position:=round(J2000_Rate*1000);
      ComboBox15.itemindex:=J2000_ColorSpace;
      label68.caption:=inttostr(idim)+' bytes';
      {$endif}
   end;
   if (PageControl1.ActivePage=TabSheetTIFF1) then begin
      // TIFF
      if TIFF_SamplesPerPixel=1 then begin
         case TIFF_BitsPerSample of
            1: combobox4.itemindex:=0;
            2: combobox4.itemindex:=1;
            3: combobox4.itemindex:=1;
            4: combobox4.itemindex:=1;
            5: combobox4.itemindex:=2;
            6: combobox4.itemindex:=2;
            7: combobox4.itemindex:=2;
            8: combobox4.itemindex:=2;
            16:combobox4.itemindex:=3;
         end;
      end else if TIFF_SamplesPerPixel=3 then begin
         case TIFF_BitsPerSample of
            8: combobox4.itemindex:=4;
         end;
      end;
      combobox2.itemindex:=CompToCombo(TIFF_Compression);
      edit1.text:=inttostr(TIFF_ImageIndex);
      combobox3.itemindex:=ord(TIFF_PhotometInterpret)-ord(ioTIFF_WHITEISZERO);
      if (combobox3.itemindex>=5) and (combobox3.itemindex<=7) then begin
         // CMYK, YCbCr, CIELab
         combobox4.itemindex:=4;	// (sempre 16m colori)
      end else if (combobox3.itemindex>=0) and (combobox3.itemindex<=1) then begin
         // B/W or grayscale
         if TIFF_BitsPerSample=1 then
	         combobox4.itemindex:=0
         else
         	combobox4.itemindex:=2;
      end else begin
         if combobox4.itemindex=0 then combobox4.itemindex:=4;
      end;
      edit4.text:= TIFF_DocumentName;
      edit5.text:= TIFF_ImageDescription;
      edit6.text:= TIFF_PageName;
      edit7.text:= inttostr(TIFF_PageNumber);
      edit8.text:= inttostr(TIFF_PageCount);
      edit2.text:= inttostr(TIFF_XPos);
      edit3.text:= inttostr(TIFF_YPos);
      label11.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetTIFF2) then begin
      // TIFF-simplified
      ComboBox16.itemindex:=CompToCombo(TIFF_Compression);
      case TIFF_Compression of
          ioTIFF_CCITT1D:      begin TIFF_BitsPerSample:=1; TIFF_SamplesPerPixel:=1; end;
          ioTIFF_G3FAX1D:      begin TIFF_BitsPerSample:=1; TIFF_SamplesPerPixel:=1; end;
          ioTIFF_G3FAX2D:      begin TIFF_BitsPerSample:=1; TIFF_SamplesPerPixel:=1; end;
          ioTIFF_G4FAX:        begin TIFF_BitsPerSample:=1; TIFF_SamplesPerPixel:=1; end;
          ioTIFF_JPEG:         begin TIFF_BitsPerSample:=8; TIFF_SamplesPerPixel:=3; end;
      end;
      if TIFF_SamplesPerPixel=1 then
         case TIFF_BitsPerSample of
            1: combobox17.itemindex:=0;
            2: combobox17.itemindex:=1;
            3: combobox17.itemindex:=1;
            4: combobox17.itemindex:=1;
            5: combobox17.itemindex:=2;
            6: combobox17.itemindex:=2;
            7: combobox17.itemindex:=2;
            8: combobox17.itemindex:=2;
            16:combobox17.itemindex:=3;
         end
      else if TIFF_SamplesPerPixel=3 then
         case TIFF_BitsPerSample of
            8: combobox17.itemindex:=4;
         end;
      Label78.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetGIF1) then begin
      // GIF
      combobox5.itemindex:=GIF_BitsPerSample-1;
      edit9.text:=inttostr(GIF_ImageIndex);
      checkbox4.checked:=GIF_FlagTranspColor;
      label34.enabled:=GIF_FlagTranspColor;
      panel3.enabled:=GIF_FlagTranspColor;
      panel3.color:=TRGB2TColor(GIF_TranspColor);
      checkbox5.checked:=GIF_Interlaced;
      edit10.text:=inttostr(GIF_XPos);
      edit11.text:=inttostr(GIF_YPos);
      edit12.text:=inttostr(GIF_DelayTime);
      panel4.color:=TRGB2TColor(GIF_Background);
      label28.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetGIF2) then begin
      // GIF-simplified
      combobox18.itemindex:=GIF_BitsPerSample-1;
      Label84.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetBMP1) then begin
      // BMP
      combobox6.itemindex:=ord(BMP_Compression)-ord(ioBMP_UNCOMPRESSED);
      combobox7.itemindex:=BMP_BitsPerPixel;
      label40.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetPCX1) then begin
      // PCX
      combobox8.itemindex:=ord(PCX_Compression)-ord(ioPCX_UNCOMPRESSED);
      combobox9.itemindex:=PCX_BitsPerPixel;
      label46.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetPNG1) then begin
   	// PNG
      ComboBox10.itemindex:=PNG_Colors;
      checkbox6.checked:=PNG_Interlaced;
      panel1.color:=TRGB2TColor(PNG_Background);
      combobox11.ItemIndex:=PNG_Filter;
      combobox12.itemindex:=PNG_Compression;
      label51.caption:=inttostr(idim)+' bytes';
   end;
   if (PageControl1.ActivePage=TabSheetTGA1) then begin
   	// TGA
		ComboBox14.itemindex:=TGA_Colors;
      Panel5.color:=TRGB2TColor(TGA_Background);
      CheckBox1.Checked:=TGA_Compressed;
      Edit13.text:=TGA_Name;
      Edit14.text:=TGA_Description;
      label59.caption:=inttostr(idim)+' bytes';
   end;
   //
   dochange:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.FormActivate(Sender: TObject);
var
   i:integer;
   fi:PIEFileFormatInfo;
begin
	dochange:=true;
   chkLockPreview.Checked:=DefaultLockPreview;
   button3.enabled:=not chkLockPreview.Checked;	// enable/diable preview button
   //
   PageControl1.Visible:=false;
   for i:=0 to PageControl1.PageCount-1 do
      PageControl1.Pages[i].TabVisible:=false;
   fi:=IEFileFormatGetInfo(fParams.FileType);
   if fSimplified then begin
      // Simplified tabs
      TabSheetJPEG2.TabVisible:= (ppAll in pp) or (ppJPEG in pp);
      if assigned(fi) and (ppJPEG in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetJPEG2;

      TabSheetTIFF2.TabVisible:= (ppAll in pp) or (ppTIFF in pp);
		if assigned(fi) and (ppTIFF in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetTIFF2;

      TabSheetGIF2.TabVisible:= (ppAll in pp) or (ppGIF in pp);
      if assigned(fi) and (ppGIF in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetGIF2;

      TabSheetBMP1.Tabvisible:=(ppAll in pp) or (ppBMP in pp);
      if assigned(fi) and (ppBMP in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetBMP1;

      TabSheetPCX1.Tabvisible:=(ppAll in pp) or (ppPCX in pp);
      if assigned(fi) and (ppPCX in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetPCX1;

      Label39.Top:=61; Label40.Top:=77;
      Label41.Top:=61; Label42.top:=77;
      Label45.Top:=61; Label46.Top:=77;
      Label47.Top:=61; Label48.top:=77;
      chkLockPreview.Top:=302;

      {$ifdef IEINCLUDEPNG}
      TabSheetPNG1.TabVisible:=(ppAll in pp) or (ppPNG in pp);
      if assigned(fi) and (ppPNG in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetPNG1;

      Label54.Visible:=false;
      Panel1.Visible:=false;
      GroupBox3.Visible:=false;
      Label50.Top:=61; Label51.Top:=77;
      Label52.Top:=61; Label53.top:=77;
      {$endif}

      TabSheetTGA1.TabVisible:=(ppAll in pp) or (ppTGA in pp);
      if assigned(fi) and (ppTGA in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetTGA1;

      Label63.Visible:=false;
      Panel5.Visible:=false;
      Label64.Visible:=false;
      Edit13.Visible:=false;
      Label65.Visible:=false;
      Edit14.Visible:=false;
      Label58.Top:=61; Label59.Top:=77;
      Label60.Top:=61; Label61.top:=77;

      {$ifdef IEINCLUDEJPEG2000}
      TabSheetJ20001.TabVisible:=(ppAll in pp) or (ppJ2000 in pp);
		if assigned(fi) and (ppJ2000 in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetJ20001;

      Label71.Visible:=false;
      ComboBox15.Visible:=false;
      Label67.Top:=61; Label68.Top:=77;
      Label69.Top:=61; Label70.top:=77;
      {$endif}

      //PageControl1.ActivePage:=PageControl1.FindNextPage(nil,true,true);
   end else begin
      // normal tabs
      TabSheetJPEG1.TabVisible:= (ppAll in pp) or (ppJPEG in pp);
      if assigned(fi) and (ppJPEG in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetJPEG1;

      TabSheetTIFF1.TabVisible:= (ppAll in pp) or (ppTIFF in pp);
      if assigned(fi) and (ppTIFF in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetTIFF1;

      TabSheetGIF1.TabVisible:= (ppAll in pp) or (ppGIF in pp);
      if assigned(fi) and (ppGIF in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetGIF1;

      TabSheetBMP1.Tabvisible:=(ppAll in pp) or (ppBMP in pp);
      if assigned(fi) and (ppBMP in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetBMP1;

      TabSheetPCX1.Tabvisible:=(ppAll in pp) or (ppPCX in pp);
      if assigned(fi) and (ppPCX in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetPCX1;

      {$ifdef IEINCLUDEPNG}
      TabSheetPNG1.TabVisible:=(ppAll in pp) or (ppPNG in pp);
      if assigned(fi) and (ppPNG in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetPNG1;
      {$endif}

      TabSheetTGA1.TabVisible:=(ppAll in pp) or (ppTGA in pp);
      if assigned(fi) and (ppTGA in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetTGA1;

      {$ifdef IEINCLUDEJPEG2000}
      TabSheetJ20001.TabVisible:=(ppAll in pp) or (ppJ2000 in pp);
      if assigned(fi) and (ppJ2000 in fi^.DialogPage) then PageControl1.ActivePage:=TabSheetJ20001;
      {$endif}

      //PageControl1.ActivePage:=PageControl1.FindNextPage(nil,true,true);
   end;
   // fill TIFF compression comboboxes
   ComboBox2.Items.Clear;
   ComboBox2.Items.Add('UNCOMPRESSED');
	ComboBox2.Items.Add('CCITT1D');
	ComboBox2.Items.Add('G3FAX1D');
	ComboBox2.Items.Add('G3FAX2D');
	ComboBox2.Items.Add('G4FAX');
   if HasTIFFLZW then
		ComboBox2.Items.Add('LZW');
	ComboBox2.Items.Add('JPEG');
	ComboBox2.Items.Add('PACKBITS');
   ComboBox16.Items.Assign( ComboBox2.Items );
   //
   PageControl1.Visible:=true;
   ResetParameters;
   ApplyParameters;
	// fit
	imageen1.Fit;
   //
   if assigned(application) then
	  	application.processmessages;
   PageControl1Change(self);	// it calls CopyOrg
end;

// Apply
procedure TfIOPreviews.Button4Click(Sender: TObject);
begin
	Button1Click(self);
   Button4.Enabled:=False;
end;

/////////////////////////////////////////////////////////////////////////////////////
// works only with current page
procedure TfIOPreviews.ApplyAct(im:TImageEnView);
var
   mf:TMemoryStream;
   ns:TNulStream;
   ncol:integer;
begin
	mf:=TMemoryStream.Create;
   ns:=TNulStream.Create;
   fImageEnIO.DefaultDitherMethod:=fDefaultDitherMethod;
   fImageEnIO.AttachedBitmap:=ImageEn1.Bitmap;
   xper:=0;
	if (PageControl1.ActivePage=TabSheetJPEG1) or (PageControl1.ActivePage=TabSheetJPEG2) then begin
		// JPEG and JPEG simplified
      xdiv:=2;
      fImageEnIO.Params.JPEG_QUALITY:=JPEG_Quality;
      fImageEnIO.Params.JPEG_COLORSPACE:=TIOJPEGColorspace(JPEG_Photometric);
  		case JPEG_DCTMethod of
        	0: fImageEnIO.Params.JPEG_DCTMETHOD:=ioJPEG_ISLOW;
         1: fImageEnIO.Params.JPEG_DCTMETHOD:=ioJPEG_IFAST;
         2: fImageEnIO.Params.JPEG_DCTMETHOD:=ioJPEG_FLOAT;
      end;
      fImageEnIO.Params.JPEG_OPTIMALHUFFMAN:=JPEG_OptimalHuffman;
      fImageEnIO.Params.JPEG_SMOOTH:=JPEG_Smooth;
      fImageEnIO.Params.JPEG_PROGRESSIVE:=JPEG_Progressive;
      fImageEnIO.SaveToStreamJpeg(mf);
      label25.caption:=inttostr(mf.size)+' bytes';
      label76.caption:=inttostr(mf.size)+' bytes';
      mf.position:=0;
      fImageEnIO.AttachedBitmap:=im.Bitmap;
      xper:=50;
      fImageEnIO.LoadFromStreamJpeg(mf);
   end else if PageControl1.ActivePage=TabSheetJ20001 then begin
   	{$ifdef IEINCLUDEJPEG2000}
      // JPEG2000
      xdiv:=2;
      fImageEnIO.Params.J2000_Rate:=J2000_Rate;
      fImageEnIO.Params.J2000_ColorSpace:=TIOJ2000ColorSpace(J2000_ColorSpace);
      fImageEnIo.Params.BitsPerSample:=8;
      fImageEnIO.Params.SamplesPerPixel:=3;
      fImageEnIO.SaveToStreamJ2K(mf);  // uses only codestream
      Label70.caption:=inttostr(mf.size)+' bytes';
      mf.position:=0;
      fImageEnIO.AttachedBitmap:=im.Bitmap;
      xper:=50;
      fImageEnIO.LoadFromStreamJ2K(mf);
      {$endif}
   end else if (PageControl1.ActivePage=TabSheetTIFF1) or (PageControl1.ActivePage=TabSheetTIFF2) then begin
   	// TIFF
      xdiv:=1;
      fImageEnIO.Params.TIFF_LZWDecompFunc:=TIFF_LZWDecompFunc;
		fImageEnIO.Params.TIFF_LZWCompFunc:=TIFF_LZWCompFunc;
      fImageEnIO.Params.TIFF_Compression:=TIFF_Compression;
      fImageEnIO.Params.TIFF_PhotometInterpret:=TIFF_PhotometInterpret;
      fImageEnIO.Params.SamplesPerPixel:=TIFF_SamplesPerPixel;
      fImageEnIO.Params.BitsPerSample:=TIFF_BitsPerSample;
      fImageEnIO.SaveToStreamTIFF(ns);
      label18.caption:=inttostr(ns.size)+' bytes';
      Label80.caption:=inttostr(ns.size)+' bytes';
      IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
      if ((TIFF_PhotometInterpret=IOTIFF_BLACKISZERO) or (TIFF_photometInterpret=IOTIFF_WHITEISZERO)) and
      (TIFF_BitsPerSample=8) and (TIFF_SamplesPerPixel=1) then begin
      	fImageEnProc.ConvertToGray;
         freemem(fImageEnIO.Params.ColorMap);
         fImageEnIO.Params.fColorMap:=nil;
         fImageEnIO.Params.fColorMapCount:=0;
      end else if TIFF_PhotometInterpret<ioTIFF_CMYK then begin
         ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
         if ncol<=256 then begin
            fImageEnProc.AttachedBitmap:=im.Bitmap;
            if fImageEnIO.Params.fColorMap<>nil then
            	freemem(fImageEnIO.Params.fColorMap);
            getmem(fImageEnIO.Params.fColorMap,sizeof(TRGB)*ncol);
            fImageEnIO.Params.fcolorMapCount:=ncol;
            fImageEnProc.ConvertToPalette(ncol,fImageEnIO.Params.fColorMap,fDefaultDitherMethod);
         end else begin
            freemem(fImageEnIO.Params.ColorMap);
            fImageEnIO.Params.fColorMap:=nil;
            fImageEnIO.Params.fColorMapCount:=0;
         end;
      end;
   end else if (PageControl1.ActivePage=TabSheetGIF1) or (PageControl1.ActivePage=TabSheetGIF2) then begin
   	// GIF
      xdiv:=1;
      fImageEnIO.Params.GIF_LZWDecompFunc:=GIF_LZWDecompFunc;
      fImageEnIO.Params.GIF_LZWCompFunc:=GIF_LZWCompFunc;
      fImageEnIO.Params.BitsPerSample:=GIF_BitsPerSample;
      fImageEnIO.Params.SamplesPerPixel:=1;
      fImageEnIO.Params.GIF_Interlaced:=GIF_Interlaced;
      fImageEnIO.SaveToStreamGIF(ns);
      label30.caption:=inttostr(ns.size)+' bytes';
      Label86.caption:=inttostr(ns.size)+' bytes';
      IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
      ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
      if ncol<=256 then begin
	      fImageEnProc.AttachedBitmap:=im.Bitmap;
         if fImageEnIO.Params.fColorMap<>nil then
            freemem(fImageEnIO.Params.fColorMap);
         getmem(fImageEnIO.Params.fColorMap,sizeof(TRGB)*ncol);
         fImageEnIO.Params.fcolorMapCount:=ncol;
         fImageEnProc.ConvertToPalette(ncol,fImageEnIO.Params.fColorMap,fDefaultDitherMethod);
      end else begin
         freemem(fImageEnIO.Params.ColorMap);
         fImageEnIO.Params.fColorMap:=nil;
         fImageEnIO.Params.fColorMapCount:=0;
      end;
   end else if PageControl1.ActivePage=TabSheetBMP1 then begin
   	// BMP
      xdiv:=1;
      with fImageEnIO do begin
      	Params.BMP_Compression:=BMP_Compression;
	      case BMP_BitsPerPixel of
	      	0: begin Params.BitsPerSample:=1; Params.SamplesPerPixel:=1; end;
	         1: begin Params.BitsPerSample:=4; Params.SamplesPerPixel:=1; end;
	         2: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=1; end;
	         3: begin Params.BitsPerSample:=5; Params.SamplesPerPixel:=3; end;
	         4: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=3; end;
	         5: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=3; end;
         end;
         SaveToStreamBMP(ns);
	      label42.caption:=inttostr(ns.size)+' bytes';
         IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
         ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
         if ncol<=256 then begin
            fImageEnProc.AttachedBitmap:=im.Bitmap;
            fImageEnProc.ConvertTo(ncol,fDefaultDitherMethod);
         end;
      end;
   end else if PageControl1.ActivePage=TabSheetPCX1 then begin
   	// PCX
      xdiv:=1;
      with fImageEnIO do begin
      	Params.PCX_Compression:=PCX_Compression;
	      case PCX_BitsPerPixel of
	      	0: begin Params.BitsPerSample:=1; Params.SamplesPerPixel:=1; end;
	         1: begin Params.BitsPerSample:=4; Params.SamplesPerPixel:=1; end;
	         2: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=1; end;
	         3: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=3; end;
         end;
         SaveToStreamPCX(ns);
	      label48.caption:=inttostr(ns.size)+' bytes';
         IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
         ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
         if ncol<=256 then begin
            fImageEnProc.AttachedBitmap:=im.Bitmap;
            fImageEnProc.ConvertTo(ncol,fDefaultDitherMethod);
         end;
      end;
   end else if PageControl1.ActivePage=TabSheetPNG1 then begin
   	// PNG
      {$ifdef IEINCLUDEPNG}
      xdiv:=1;
      with fImageEnIO do begin
      	case PNG_Colors of
         	0: begin Params.BitsPerSample:=1; Params.SamplesPerPixel:=1; end;
				1: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=1; end;
            2: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=3; end;
         end;
         Params.PNG_Interlaced:=PNG_Interlaced;
         Params.PNG_Filter:=TIOPNGFilter(PNG_Filter);
         Params.PNG_Compression:=PNG_Compression;
         SaveToStreamPNG(ns);
         Label53.caption:=inttostr(ns.size)+' bytes';
         IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
         ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
         if ncol<=256 then begin
            fImageEnProc.AttachedBitmap:=im.Bitmap;
            if fImageEnIO.Params.fColorMap<>nil then
            	freemem(fImageEnIO.Params.fColorMap);
            getmem(fImageEnIO.Params.fColorMap,sizeof(TRGB)*ncol);
            fImageEnIO.Params.fcolorMapCount:=ncol;
            fImageEnProc.ConvertToPalette(ncol,fImageEnIO.Params.fColorMap,fDefaultDitherMethod);
         end else begin
            freemem(fImageEnIO.Params.ColorMap);
            fImageEnIO.Params.fColorMap:=nil;
            fImageEnIO.Params.fColorMapCount:=0;
         end;
      end;
      {$endif}
   end else if PageControl1.ActivePage=TabSheetTGA1 then begin
   	// TGA
      xdiv:=1;
      with fImageEnIO do begin
      	case TGA_Colors of
         	0: begin Params.BitsPerSample:=1; Params.SamplesPerPixel:=1; end;
				1: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=1; end;
            2: begin Params.BitsPerSample:=8; Params.SamplesPerPixel:=3; end;
         end;
         Params.TGA_Compressed:=TGA_Compressed;
         SaveToStreamTGA(ns);
         Label61.caption:=inttostr(ns.size)+' bytes';
         IECopyBitmap(fImageEnIO.Bitmap,im.Bitmap);
         ncol:=_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel);
         if ncol<=256 then begin
            fImageEnProc.AttachedBitmap:=im.Bitmap;
            if fImageEnIO.Params.fColorMap<>nil then
            	freemem(fImageEnIO.Params.fColorMap);
            getmem(fImageEnIO.Params.fColorMap,sizeof(TRGB)*ncol);
            fImageEnIO.Params.fcolorMapCount:=ncol;
            fImageEnProc.ConvertToPalette(ncol,fImageEnIO.Params.fColorMap,fDefaultDitherMethod);
         end else begin
            freemem(fImageEnIO.Params.ColorMap);
            fImageEnIO.Params.fColorMap:=nil;
            fImageEnIO.Params.fColorMapCount:=0;
         end;
      end;
   end;
 	ProgressBar1.Position:=0;
   mf.free;
   ns.free;
   if im=ImageEn2 then begin
     	imageen2.LockPaint;
    	imageen2.zoom:=imageen1.zoom;
      imageen2.setviewxy(imageen1.viewx,imageen1.viewy);
      imageen2.UnLockPaint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change format type (pagecontrol1)
procedure TfIOPreviews.PageControl1Change(Sender: TObject);
begin
	dochange:=true;
	ResetParameters;
   ApplyParameters;
   if chkLockPreview.Checked then
	   ApplyAct(imageen2);
   Button4.Enabled:=False;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
	dochange:=false;
end;

/////////////////////////////////////////////////////////////////////////////////////
// changes zoom/view of ImageEn1 (source image)
procedure TfIOPreviews.ImageEn1ViewChange(Sender: TObject; Change: Integer);
begin
	//ApplyAct(imageen2);
   imageen2.LockPaint;
   imageen2.zoom:=imageen1.zoom;
   imageen2.setviewxy(imageen1.viewx,imageen1.viewy);
   imageen2.UnLockPaint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change TIFF
(* combobox3
0: WHITEISZERO
1: BLACKISZERO
2: RGB
3: RGBPALETTE
4: TRANSPMASK
5: CMYK
6: YCBCR
7: CIELAB
*)
(* combobox4
0: B/W
1: 16
2: 256
3: 65536
4: 16M
*)
procedure TfIOPreviews.ComboBox2Click(Sender: TObject);
const
	//											samplesperpixel, bitspersample
	cb2:array [0..4,0..1] of integer=(  (1,1),	// b/w
                                       (1,4),	// 16 colors
                                       (1,8),	// 256 colors
                                       (1,16),	// 65536 colors
                                       (3,8) );	// 16M
var
	co:TIOTIFFCompression;
   ph:TIOTIFFPhotometInterpret;
   bx,sx:integer;
begin
	if not dochange then exit;
	if sender=ComboBox3 then begin
   	case ComboBox3.ItemIndex of
      	0,1: if combobox4.itemindex>0 then combobox4.itemindex:=2;
			2,5,6,7: combobox4.itemindex:=4;
         3: combobox4.itemindex:=2;
		end;
   end else if sender=ComboBox4 then begin
   	case ComboBox4.ItemIndex of
      	0: if combobox3.itemindex>1 then combobox3.itemindex:=1;
         1: combobox3.itemindex:=3;
         2: if (combobox3.itemindex=2) or (combobox3.itemindex>3) then combobox3.itemindex:=3;
      end;
   end;
   (*
   if (combobox3.itemindex>=5) and (combobox3.itemindex<=7) then begin
      // CMYK, YCbCr, CIELab
      combobox4.itemindex:=4;	// (sempre 16m colori)
      combobox4.enabled:=false;
   end else if (combobox3.itemindex>=0) and (combobox3.itemindex<=1) then begin
   	// B/W
      combobox4.itemindex:=0;	// (sempre B/W)
      combobox4.enabled:=false;
   end else begin
   	if combobox4.itemindex=0 then combobox4.itemindex:=4;
      combobox4.enabled:=true;
   end;
   *)
   co:=ComboToComp(combobox2.itemindex);
	ph:=TIOTIFFPhotometInterpret(ord(ioTIFF_WHITEISZERO)+combobox3.itemindex);
   if (ph=ioTIFF_CMYK) then begin
   	// CMYK
		bx:=8;
      sx:=4;
	end else begin
      bx:=cb2[combobox4.itemindex,1];	// BitsPerSample
      sx:=cb2[combobox4.itemindex,0];  // SamplesPerPixel
   end;
	if (co<>TIFF_Compression) or (ph<>TIFF_PhotometInterpret) or
      (bx<>TIFF_BitsPerSample) or (sx<>TIFF_SamplesPerPixel) then begin
		TIFF_Compression:=co;
	   TIFF_PhotometInterpret:=ph;
      TIFF_SamplesPerPixel:=sx;
      TIFF_BitsPerSample:=bx;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   TIFF_ImageIndex:=strtointdef(edit1.text,0);
   TIFF_XPos:=strtointdef(edit2.text,0);
   TIFF_YPos:=strtointdef(edit3.text,0);
   TIFF_DocumentName:=edit4.text;
   TIFF_ImageDescription:=edit5.text;
   TIFF_PageName:=edit6.text;
   TIFF_PageNumber:=strtointdef(edit7.text,0);
   TIFF_PageCount:=strtointdef(edit8.text,0);
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change GIF
procedure TfIOPreviews.ComboBox5Click(Sender: TObject);
var
	co:integer;
   it:boolean;
begin
	if not dochange then exit;
	co:=combobox5.itemindex+1;
   it:=checkbox5.checked;
   if (co<>GIF_BitsPerSample) or (it<>GIF_Interlaced) then begin
   	GIF_BitsPerSample:=co;
      GIF_Interlaced:=it;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
	GIF_ImageIndex:=strtointdef(edit9.text,0);
   GIF_XPos:=strtointdef(edit10.text,0);
   GIF_YPos:=strtointdef(edit11.text,0);
   GIF_DelayTime:=strtointdef(edit12.text,0);
   GIF_FlagTranspColor:=checkbox4.checked;
   label34.enabled:=GIF_FlagTranspColor;
   panel3.enabled:=GIF_FlagTranspColor;
   GIF_Interlaced:=checkbox5.checked;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change BMP
procedure TfIOPreviews.ComboBox6Change(Sender: TObject);
var
	cl:integer;
   cm:integer;
begin
	if not dochange then exit;
	cl:=combobox7.itemindex;
   cm:=combobox6.itemindex;
   if (cl<>BMP_BitsPerPixel) or (cm<>ord(BMP_Compression)) then begin
   	BMP_BitsPerPixel:=cl;
      if cm=0 then
	      BMP_Compression:=ioBMP_UNCOMPRESSED
      else
      	BMP_Compression:=ioBMP_RLE;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change PCX
procedure TfIOPreviews.ComboBox8Change(Sender: TObject);
var
	cl:integer;
   cm:integer;
begin
	if not dochange then exit;
	cl:=combobox9.itemindex;
   cm:=combobox8.itemindex;
   if (cl<>PCX_BitsPerPixel) or (cm<>ord(PCX_Compression)) then begin
   	PCX_BitsPerPixel:=cl;
      if cm=0 then
	      PCX_Compression:=ioPCX_UNCOMPRESSED
      else
      	PCX_Compression:=ioPCX_RLE;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// set language
procedure TfIOPreviews.SetLanguage(l:TMsgLanguage);
begin
	Caption:=iemsg(IEMSG_PARAMETERSPREVIEW,l);
	Label1.Caption:=iemsg(IEMSG_SOURCE,l)+':';
	Label2.Caption:=iemsg(IEMSG_RESULT,l)+':';
   Button2.Caption:=iemsg(IEMSG_CANCEL,l);
   Button1.Caption:=iemsg(IEMSG_OK,l);
	button3.caption:=iemsg(IEMSG_PREVIEW,l);
	chkLockPreview.Caption:=iemsg(IEMSG_LOCKPREVIEW,l);
   Button4.Caption:=iemsg(IEMSG_APPLY,l);
   // JPEG
	Label23.Caption:=iemsg(IEMSG_QUALITY,l)+':';
   Label26.Caption:=iemsg(IEMSG_DCTMETHOD,l)+':';
   Label27.Caption:=iemsg(IEMSG_SMOOTHINGFACTOR,l)+':';
   label57.Caption:=iemsg(IEMSG_PHOTOMETRIC,l)+':';
   CheckBox2.Caption:=iemsg(IEMSG_OPTIMALHUFFMAN,l);
   label3.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   Label24.Caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   GroupBox5.Caption:=' '+iemsg(IEMSG_ADVANCED,l)+' ';
   checkbox3.caption:=iemsg(IEMSG_PROGRESSIVE,l);
   // JPEG-simplified
	Label72.Caption:=iemsg(IEMSG_QUALITY,l)+':';
   Label73.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   Label75.Caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   Label66.Caption:=iemsg(IEMSG_RATE,l)+':';
   Label71.Caption:=iemsg(IEMSG_PHOTOMETRIC,l)+':';
   Label67.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   Label69.Caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   {$endif}
   // TIFF
   label5.caption:=iemsg(IEMSG_COMPRESSION,l)+':';
   label6.caption:=iemsg(IEMSG_IMAGEINDEX,l)+':';
   label7.caption:=iemsg(IEMSG_PHOTOMETRIC,l)+':';
   groupbox1.caption:=' '+iemsg(IEMSG_SCANNDEDDOCUMENTINFO,l)+' ';
   label12.caption:=iemsg(IEMSG_NAME,l)+':';
   label13.caption:=iemsg(IEMSG_DESCRIPTION,l)+':';
   label14.caption:=iemsg(IEMSG_PAGENAME,l)+':';
   label15.caption:=iemsg(IEMSG_PAGENUMBER,l)+':';
   label16.caption:=iemsg(IEMSG_OF,l);
   label8.caption:=iemsg(IEMSG_HORIZPOSITIONINCH,l)+':';
   label10.caption:=iemsg(IEMSG_VERTPOSITIONINCH,l)+':';
   label9.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
	label17.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
	label19.caption:=iemsg(IEMSG_COLORS,l)+':';
   // TIFF-simplified
   Label81.caption:=iemsg(IEMSG_COMPRESSION,l)+':';
   Label77.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
	Label79.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
	Label82.caption:=iemsg(IEMSG_COLORS,l)+':';
   // GIF
	label21.caption:=iemsg(IEMSG_COLORS,l)+':';
	label20.caption:=iemsg(IEMSG_IMAGEINDEX,l)+':';
   checkbox4.Caption:=iemsg(IEMSG_TRANSPARENT,l)+':';
   label34.caption:=iemsg(IEMSG_TRANSPARENTCOLOR,l)+':';
   checkbox5.caption:=iemsg(IEMSG_INTERLACED,l)+':';
   label35.caption:=iemsg(IEMSG_BACKGROUND,l)+':';
   groupbox2.Caption:=' '+iemsg(IEMSG_ADVANCED,l)+' ';
   label31.caption:=iemsg(IEMSG_HORIZPOSITION,l)+':';
   label32.caption:=iemsg(IEMSG_VERTPOSITION,l)+':';
   label33.caption:=iemsg(IEMSG_DELAYTIME,l)+':';
   label22.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
	label29.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   // GIF-simplified
	Label87.caption:=iemsg(IEMSG_COLORS,l)+':';
   Label83.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
	Label85.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   // BMP
   label37.caption:=iemsg(IEMSG_COMPRESSION,l)+':';
	label38.caption:=iemsg(IEMSG_COLORS,l)+':';
	label39.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   label41.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   // PCX
   label43.caption:=iemsg(IEMSG_COMPRESSION,l)+':';
	label44.caption:=iemsg(IEMSG_COLORS,l)+':';
	label45.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   label47.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   // PNG
	label49.caption:=iemsg(IEMSG_COLORS,l)+':';
	checkbox6.Caption:=iemsg(IEMSG_INTERLACED,l);
	label54.caption:=iemsg(IEMSG_BACKGROUND,l)+':';
   label50.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
	label52.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
	groupbox3.Caption:=' '+iemsg(IEMSG_ADVANCED,l)+' ';
	label55.caption:=iemsg(IEMSG_FILTER,l)+':';
   label56.caption:=iemsg(IEMSG_COMPRESSION,l)+':';
   // TGA
   Label62.caption:=iemsg(IEMSG_COLORS,l)+':';
   label63.caption:=iemsg(IEMSG_BACKGROUND,l)+':';
   checkbox1.Caption:=iemsg(IEMSG_COMPRESSION,l)+':';
   label64.caption:=iemsg(IEMSG_NAME,l)+':';
   label65.caption:=iemsg(IEMSG_DESCRIPTION,l)+':';
   label58.caption:=iemsg(IEMSG_ORIGINALSIZE,l)+':';
   label60.caption:=iemsg(IEMSG_COMPRESSEDSIZE,l)+':';
   //
   msgCancel:='&'+iemsg(IEMSG_CANCEL,l);
end;

/////////////////////////////////////////////////////////////////////////////////////
// preview-lock
procedure TfIOPreviews.SpeedButton1Click(Sender: TObject);
begin
	if chkLockPreview.Checked then
		ApplyAct(imageen2);
   button3.enabled:=not chkLockPreview.Checked;	// enable/diable preview button
end;

/////////////////////////////////////////////////////////////////////////////////////
// preview
procedure TfIOPreviews.Button3Click(Sender: TObject);
begin
	ApplyAct(imageen2);
end;

/////////////////////////////////////////////////////////////////////////////////////
// select GIF-Transp.Color
procedure TfIOPreviews.Panel3Click(Sender: TObject);
var
	fPalDial:TImageEnPaletteDialog;
begin
	if fImageEnIO.Params.ColorMap=nil then
		ApplyAct(imageen2);   
   fPalDial:=TImageEnPaletteDialog.Create(self);
   fPalDial.SetPalette(fImageEnIO.Params.ColorMap^,1 shl GIF_BitsPerSample);
   fPalDial.ButtonCancel.Caption:=msgCancel;
   if fPalDial.Execute then
   	panel3.color:=fPalDial.SelCol;
   GIF_TranspColor:=TCOLOR2TRGB(panel3.color);
   fPalDial.free;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// select GIF-Background
procedure TfIOPreviews.Panel4Click(Sender: TObject);
var
	fPalDial:TImageEnPaletteDialog;
begin
	if fImageEnIO.Params.ColorMap=nil then
		ApplyAct(imageen2);   
   fPalDial:=TImageEnPaletteDialog.Create(self);
   fPalDial.SetPalette(fImageEnIO.Params.ColorMap^,1 shl GIF_BitsPerSample);
   fPalDial.ButtonCancel.Caption:=msgCancel;
   if fPalDial.Execute then
   	panel4.color:=fPalDial.SelCol;
   GIF_Background:=TCOLOR2TRGB(panel4.color);
   fPalDial.free;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// OK
procedure TfIOPreviews.Button1Click(Sender: TObject);
begin
   if (PageControl1.ActivePage=TabSheetJPEG1) or (PageControl1.ActivePage=TabSheetJPEG2) then begin
      // READ JPEG PARAMETERS
      fParams.JPEG_Quality:=JPEG_Quality;
      fParams.JPEG_ColorSpace:=TIOJPEGColorspace(JPEG_Photometric);
      case JPEG_DCTMethod of
         0: fParams.JPEG_DCTMethod:=ioJPEG_ISLOW;
         1: fParams.JPEG_DCTMethod:=ioJPEG_IFAST;
         2: fParams.JPEG_DCTMethod:=ioJPEG_FLOAT;
      end;
      fParams.JPEG_OptimalHuffman:=JPEG_OptimalHuffman;
      fParams.JPEG_Smooth:=JPEG_Smooth;
      fParams.JPEG_Progressive:=JPEG_Progressive;
      fParams.FileType:=ioJPEG;
   end else if (PageControl1.ActivePage=TabSheetTIFF1) or (PageControl1.ActivePage=TabSheetTIFF2) then begin
      // READ TIFF PARAMETERS
      fParams.TIFF_Compression:=TIFF_Compression;
      fParams.TIFF_ImageIndex:=TIFF_ImageIndex;
      fParams.TIFF_PhotometInterpret:=TIFF_PhotometInterpret;
      fParams.TIFF_XPos:=TIFF_XPos;
      fParams.TIFF_YPos:=TIFF_YPos;
      fParams.TIFF_DocumentName:=TIFF_DocumentName;
      fParams.TIFF_ImageDescription:=TIFF_ImageDescription;
      fParams.TIFF_PageName:=TIFF_PageName;
      fParams.TIFF_PageNumber:=TIFF_PageNumber;
      fParams.TIFF_PageCount:=TIFF_PageCount;
      fParams.SamplesPerPixel:=TIFF_SamplesPerPixel;
      fParams.BitsPerSample:=TIFF_BitsPerSample;
      fParams.FileType:=ioTIFF;
   end else if (Pagecontrol1.ActivePage=TabSheetGIF1) or (Pagecontrol1.ActivePage=TabSheetGIF2) then begin
      // READ GIF PARAMETERS
      fParams.GIF_ImageIndex:=GIF_ImageIndex;
      fParams.GIF_XPos:=GIF_XPos;
      fParams.GIF_YPos:=GIF_YPos;
      fParams.GIF_DelayTime:=GIF_DelayTime;
      fParams.GIF_FlagTranspColor:=GIF_FlagTranspColor;
      fParams.GIF_TranspColor:=GIF_TranspColor;
      fParams.GIF_Interlaced:=GIF_Interlaced;
      fParams.GIF_Background:=GIF_Background;
      fParams.BitsPerSample:=GIF_BitsPerSample;
      fParams.FileType:=ioGIF;
   end else if PageControl1.ActivePage=TabSheetBMP1 then begin
      // READ BMP PARAMETERS
      fParams.BMP_Compression:=BMP_Compression;
      case BMP_BitsPerPixel of
         0: begin fParams.BitsPerSample:=1; fParams.SamplesPerPixel:=1; end;
         1: begin fParams.BitsPerSample:=4; fParams.SamplesPerPixel:=1; end;
         2: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=1; end;
         3: begin fParams.BitsPerSample:=5; fParams.SamplesPerPixel:=3; end;
         4: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
         5: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
      end;
      fParams.FileType:=ioBMP;
   end else if PageControl1.ActivePage=TabSheetPCX1 then begin
      // READ PCX PARAMETERS
      fParams.PCX_Compression:=PCX_Compression;
      case PCX_BitsPerPixel of
         0: begin fParams.BitsPerSample:=1; fParams.SamplesPerPixel:=1; end;
         1: begin fParams.BitsPerSample:=4; fParams.SamplesPerPixel:=1; end;
         2: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=1; end;
         3: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
      end;
      fParams.FileType:=ioPCX;
   end else if PageControl1.ActivePage=TabSheetPNG1 then begin
   	// READ PNG PARAMETERS
      case PNG_Colors of
         0: begin fParams.BitsPerSample:=1; fParams.SamplesPerPixel:=1; end;
         1: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=1; end;
         2: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
      end;
      fParams.PNG_Background:=PNG_Background;
      fParams.PNG_Interlaced:=PNG_Interlaced;
      fParams.PNG_Filter:=TIOPNGFilter(PNG_Filter);
      fParams.PNG_Compression:=PNG_Compression;
      fParams.FileType:=ioPNG;
   end else if PageControl1.ActivePage=TabSheetTGA1 then begin
   	// READ TGA PARAMETERS
      case TGA_Colors of
         0: begin fParams.BitsPerSample:=1; fParams.SamplesPerPixel:=1; end;
         1: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=1; end;
         2: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
      end;
      fParams.TGA_Background:=TGA_Background;
      fParams.TGA_Compressed:=TGA_Compressed;
      fParams.TGA_ImageName:=TGA_Name;
      fParams.TGA_Descriptor:=TGA_Description;
      fParams.FileType:=ioTGA;
   end else if PageControl1.ActivePage=TabSheetJ20001 then begin
      // READ Jpeg2000 PARAMETERS
      {$ifdef IEINCLUDEJPEG2000}
      case J2000_ColorSpace of
         0: begin
              fParams.BitsPerSample:=8;
              fParams.SamplesPerPixel:=1;
              fParams.J2000_ColorSpace:=ioJ2000_GRAYLEV
            end;
         1: begin
              fParams.BitsPerSample:=8;
              fParams.SamplesPerPixel:=3;
              fParams.J2000_ColorSpace:=ioJ2000_RGB;
            end;
         2: begin
              fParams.BitsPerSample:=8;
              fParams.SamplesPerPixel:=3;
              fParams.J2000_ColorSpace:=ioJ2000_YCbCr;
            end;
      end;
      fParams.J2000_Rate:=J2000_Rate;
      fParams.FileType:=ioJ2K;	// or ioJ2P?
      {$endif}
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfIOPreviews.Progress(Sender: TObject; per: Integer);
begin
	ProgressBar1.Position:=trunc(per/xdiv)+xper;
end;

/////////////////////////////////////////////////////////////////////////////////////
// return false if the dialog doesn't contains parameters
function TfIOPreviews.SetPreviewParams(xpp:TPreviewParams):boolean;
begin
	pp:=xpp;
   if (ppAuto in pp) then
      case fParams.FileType of
         ioTIFF: pp:=pp+[ppTIFF];
         ioGIF: pp:=pp+[ppGIF];
         ioJPEG: pp:=pp+[ppJPEG];
         ioPCX: pp:=pp+[ppPCX];
         ioBMP: pp:=pp+[ppBMP];
         {$ifdef IEINCLUDEPNG}
         ioPNG: pp:=pp+[ppPNG];
         {$endif}
         ioTGA: pp:=pp+[ppTGA];
         {$ifdef IEINCLUDEJPEG2000}
         ioJ2K: pp:=pp+[ppJ2000];
         ioJP2: pp:=pp+[ppJ2000];
         {$endif}
      end;
	result:= not (pp=[ppAuto]);
end;

/////////////////////////////////////////////////////////////////////////////////////
// change PNG
procedure TfIOPreviews.ComboBox10Change(Sender: TObject);
var
	cl,ff,cc:integer;
   ii:boolean;
begin
	if not dochange then exit;
	cl:=combobox10.itemindex;
   ii:=checkbox6.checked;
   ff:=combobox11.itemindex;
   cc:=combobox12.itemindex;
   if (cl<>PNG_Colors) or (ii<>PNG_Interlaced) or (ff<>PNG_Filter)
      or (cc<>PNG_Compression) then begin
   	PNG_Colors:=cl;
      PNG_Interlaced:=ii;
      PNG_Filter:=ff;
      PNG_Compression:=cc;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// select PNG-Background color
procedure TfIOPreviews.Panel1Click(Sender: TObject);
var
	fPalDial:TImageEnPaletteDialog;
begin
	if fImageEnIO.Params.ColorMap=nil then begin
   	// true color
      if ColorDialog1.Execute then
      	panel1.color:=ColorDialog1.Color;
   end else begin
   	// palette
      fPalDial:=TImageEnPaletteDialog.Create(self);
      fPalDial.SetPalette(fImageEnIO.Params.ColorMap^,_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel));
      fPalDial.ButtonCancel.Caption:=msgCancel;
      if fPalDial.Execute then
         panel1.color:=fPalDial.SelCol;
      fPalDial.free;
   end;
   PNG_Background:=TCOLOR2TRGB(panel1.color);
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// change TGA
procedure TfIOPreviews.ComboBox14Click(Sender: TObject);
var
	cl:integer;
   cc:boolean;
begin
	if not dochange then exit;
	cl:=combobox14.itemindex;
   cc:=checkbox1.checked;
   if (cl<>TGA_Colors) or (cc<>TGA_Compressed) then begin
   	TGA_Colors:=cl;
      TGA_Compressed:=cc;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   TGA_Name:=Edit13.text;
   TGA_Description:=Edit14.text;
   Button4.Enabled:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// select TGA-Background
procedure TfIOPreviews.Panel5Click(Sender: TObject);
var
	fPalDial:TImageEnPaletteDialog;
begin
	if fImageEnIO.Params.ColorMap=nil then begin
   	// true color
      if ColorDialog1.Execute then
      	panel5.color:=ColorDialog1.Color;
   end else begin
   	// palette
      fPalDial:=TImageEnPaletteDialog.Create(self);
      fPalDial.SetPalette(fImageEnIO.Params.ColorMap^,_GetNumCol(fImageEnIO.Params.BitsPerSample,fImageEnIO.Params.SamplesPerPixel));
      fPalDial.ButtonCancel.Caption:=msgCancel;
      if fPalDial.Execute then
         panel5.color:=fPalDial.SelCol;
      fPalDial.free;
   end;
   TGA_Background:=TCOLOR2TRGB(panel5.color);
   Button4.Enabled:=true;
end;

// JPEG2000 edit change
procedure TfIOPreviews.Edit15Change(Sender: TObject);
{$ifdef IEINCLUDEJPEG2000}
var
	q:double;
begin
	if not dochange then exit;
	q:=strtointdef(edit15.text,1000)/1000;
   if (q<>J2000_Rate) then begin
   	trackbar1.position:=trunc(q*1000);
      trackbar1change(self);
   end;
   Button4.Enabled:=true;
end;
{$else}
begin
end;
{$endif}

// JPEG2000 other controls change
procedure TfIOPreviews.TrackBar1Change(Sender: TObject);
begin
	{$ifdef IEINCLUDEJPEG2000}
	if not dochange then exit;
	if (round(J2000_Rate*1000)<>trackbar1.position) or (J2000_ColorSpace<>combobox15.itemindex) then begin
   	J2000_Rate:=trackbar1.position/1000;
      J2000_ColorSpace:=combobox15.itemindex;
      edit15.text:=inttostr(round(J2000_Rate*1000));      
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
      Button4.Enabled:=true;
   end;
   {$endif}
end;

// change JPEG (edit controls)
procedure TfIOPreviews.Edit22Change(Sender: TObject);
var
	q,w:integer;
begin
	if not dochange then exit;
	q:=strtointdef(edit22.text,50);
   w:=strtointdef(edit23.text,0);
   if (q<>JPEG_Quality) or (w<>JPEG_Smooth) then begin
   	trackbar13.position:=q;
      trackbar13change(self);
   end;
   Button4.Enabled:=true;
end;

// change JPEG-simplified (edit controls)
procedure TfIOPreviews.Edit16Change(Sender: TObject);
var
	q:integer;
begin
	if not dochange then exit;
	q:=strtointdef(edit16.text,50);
   if (q<>JPEG_Quality) then begin
   	trackbar2.position:=q;
      trackbar2change(self);
   end;
   Button4.Enabled:=true;
end;

// change JPEG (trackbar13, checkbox1)
procedure TfIOPreviews.TrackBar13Change(Sender: TObject);
var
	w:integer;
begin
	if not dochange then exit;
   w:=strtointdef(edit23.text,0);
	if (JPEG_Quality<>trackbar13.position) or
   	(JPEG_Photometric<>combobox13.itemindex) or
      (JPEG_DCTMethod<>combobox1.ItemIndex) or
      (JPEG_OptimalHuffman<>checkbox2.checked) or
      (JPEG_Smooth<>w) or
      (JPEG_Progressive<>checkbox3.checked) then begin
   	JPEG_Quality:=trackbar13.position;
      edit22.text:=inttostr(JPEG_Quality);
      JPEG_Photometric:=combobox13.itemindex;
      JPEG_DCTMethod:=combobox1.itemindex;
      JPEG_OptimalHuffman:=checkbox2.checked;
      JPEG_Smooth:=w;
      JPEG_Progressive:=checkbox3.checked;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
      Button4.Enabled:=true;
   end;
end;

// change JPEG-simplified (trackbar)
procedure TfIOPreviews.TrackBar2Change(Sender: TObject);
begin
	if not dochange then exit;
	if (JPEG_Quality<>trackbar2.position) then begin
   	JPEG_Quality:=trackbar2.position;
      edit16.text:=inttostr(JPEG_Quality);
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
      Button4.Enabled:=true;
   end;
end;

// changes TIFF-simplified compression combobox
// changes TIFF-simplified colors combobox
procedure TfIOPreviews.ComboBox16Change(Sender: TObject);
var
	co:TIOTIFFCompression;
   ph:TIOTIFFPhotometInterpret;
   bx,sx:integer;
begin
	if not dochange then exit;
   co:=TIFF_Compression;
   ph:=TIFF_PhotometInterpret;
   sx:=TIFF_SamplesPerPixel;
   bx:=TIFF_BitsPerSample;
   if Sender=ComboBox16 then begin
   	// changes compression
      co:=ComboToComp(ComboBox16.ItemIndex);
      case co of
         ioTIFF_CCITT1D: begin ph:=ioTIFF_BLACKISZERO; bx:=1; sx:=1; combobox17.itemindex:=0; end;
         ioTIFF_G3FAX1D: begin ph:=ioTIFF_BLACKISZERO; bx:=1; sx:=1; combobox17.itemindex:=0; end;
         ioTIFF_G3FAX2D: begin ph:=ioTIFF_BLACKISZERO; bx:=1; sx:=1; combobox17.itemindex:=0; end;
         ioTIFF_G4FAX: begin ph:=ioTIFF_BLACKISZERO; bx:=1; sx:=1; combobox17.itemindex:=0; end;
         ioTIFF_JPEG: begin ph:=ioTIFF_YCBCR; bx:=8; sx:=3; combobox17.itemindex:=4; end;
      end;
   end else begin
   	// changes colors
      case ComboBox17.ItemIndex of
			0: begin bx:=1; sx:=1; end;
         1: begin bx:=4; sx:=1; end;
         2: begin bx:=8; sx:=1; end;
         3: begin bx:=16; sx:=1; end;
         4: begin bx:=8; sx:=3; end;
      end;
      if (bx>1) and (co<=ioTIFF_G4FAX) then begin
         co:=ioTIFF_UNCOMPRESSED;
         combobox16.ItemIndex:=0;
      end;
      if (bx<>8) and (sx<>3) and (co=ioTIFF_JPEG) then begin
         co:=ioTIFF_UNCOMPRESSED;
         combobox16.ItemIndex:=0;
      end;
      if (bx=16) and (sx=1) then
      	ph:=ioTIFF_BLACKISZERO;
   end;
	if (co<>TIFF_Compression) or (ph<>TIFF_PhotometInterpret) or
      (bx<>TIFF_BitsPerSample) or (sx<>TIFF_SamplesPerPixel) then begin
		TIFF_Compression:=co;
	   TIFF_PhotometInterpret:=ph;
      TIFF_SamplesPerPixel:=sx;
      TIFF_BitsPerSample:=bx;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   Button4.Enabled:=true;
end;

// change simplified GIF
procedure TfIOPreviews.ComboBox18Change(Sender: TObject);
var
	co:integer;
begin
	if not dochange then exit;
	co:=ComboBox18.itemindex+1;
   if (co<>GIF_BitsPerSample) then begin
   	GIF_BitsPerSample:=co;
      if chkLockPreview.Checked then begin
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
   Button4.Enabled:=true;
end;


{$else} // {$ifdef IEINCLUDEDIALOGIO}

interface
implementation

{$endif}

















end.
