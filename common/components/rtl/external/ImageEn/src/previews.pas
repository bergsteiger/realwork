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

unit previews;

{$R-}
{$Q-}


{$I ie.inc}

{$ifdef IEINCLUDEDIALOGIP}

interface



uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, 
  StdCtrls, ComCtrls, ImageEn, ExtCtrls, HSVBox, ImageEnProc, ImageEnView,
  checklst, HistogramBox, RulerBox, Buttons, ImageEnIO,hyiedefs,iefft,
  ieview, Dialogs;

const
	PREVIEWSTABCOUNT=14;

type
  TfPreviews = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar5: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    GroupBox1: TGroupBox;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    UpDown9: TUpDown;
    GroupBox3: TGroupBox;
    ListBox1: TListBox;
    Button6: TButton;
    TabSheet5: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    TrackBar9: TTrackBar;
    TrackBar10: TTrackBar;
    TrackBar11: TTrackBar;
    Label13: TLabel;
    Label14: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Edit20: TEdit;
    UpDown10: TUpDown;
    Label15: TLabel;
    TabSheet6: TTabSheet;
    Panel5: TPanel;
    GroupBox4: TGroupBox;
    CheckListBox1: TCheckListBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    SpeedButton3: TSpeedButton;
    Label22: TLabel;
    Edit21: TEdit;
    TrackBar12: TTrackBar;
    HSVBox3: THSVBox;
    HSVBox1: THSVBox;
    RulerBox2: TRulerBox;
    RulerBox1: TRulerBox;
    HistogramBox1: THistogramBox;
    Button3: TButton;
    ImageEn1: TImageEnView;
    ImageEn2: TImageEnView;
    TabSheet7: TTabSheet;
    GroupBox2: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Panel1: TPanel;
    HSVBox2: THSVBox;
    Label27: TLabel;
    Label28: TLabel;
    Label25: TLabel;
    Edit22: TEdit;
    UpDown11: TUpDown;
    UpDown12: TUpDown;
    Edit23: TEdit;
    Edit24: TEdit;
    UpDown13: TUpDown;
    Edit25: TEdit;
    UpDown14: TUpDown;
    Edit26: TEdit;
    UpDown15: TUpDown;
    TabSheet8: TTabSheet;
    GroupBox5: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Edit27: TEdit;
    UpDown16: TUpDown;
    UpDown17: TUpDown;
    Edit28: TEdit;
    Edit29: TEdit;
    UpDown18: TUpDown;
    Edit30: TEdit;
    UpDown19: TUpDown;
    Label31: TLabel;
    UpDown20: TUpDown;
    Edit31: TEdit;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox6: TGroupBox;
    Label34: TLabel;
    Edit32: TEdit;
    UpDown21: TUpDown;
    UpDown22: TUpDown;
    Edit33: TEdit;
    Label35: TLabel;
    Label36: TLabel;
    Edit34: TEdit;
    UpDown23: TUpDown;
    CheckBox2: TCheckBox;
    GroupBox7: TGroupBox;
    Label37: TLabel;
    ListBox2: TListBox;
    Label38: TLabel;
    Edit35: TEdit;
    UpDown24: TUpDown;
    TabSheet11: TTabSheet;
    LabelFlip: TLabel;
    SpeedButtonFlipHor: TSpeedButton;
    SpeedButtonFlipVer: TSpeedButton;
    TrackBarRotate: TTrackBar;
    EditRotate: TEdit;
    LabelRotate: TLabel;
    TabSheet12: TTabSheet;
    GroupBox8: TGroupBox;
    ImageEnView1: TImageEnView;
    ImageEnProc2: TImageEnProc;
    Clear: TButton;
    Button7: TButton;
    ProgressBar1: TProgressBar;
    CheckBox1: TCheckBox;
    tabGamma: TTabSheet;
    GroupBox9: TGroupBox;
    cbxGamma: TCheckListBox;
    Label39: TLabel;
    edtGamma: TEdit;
    trkGamma: TTrackBar;
    ImageEnView2: TImageEnView;
    Label41: TLabel;
    Label42: TLabel;
    Label40: TLabel;
    Label43: TLabel;
    TabSheet14: TTabSheet;
    Label44: TLabel;
    Edit36: TEdit;
    TrackBar4: TTrackBar;
    Label45: TLabel;
    Edit37: TEdit;
    UpDown25: TUpDown;
    chkLockPreview: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ImageEn1ViewChange(Sender: TObject; Change: Integer);
    procedure TrackBar6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure Edit19Change(Sender: TObject);
    procedure HSVBox3Change(Sender: TObject);
    procedure ImageEn2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckListBox1Click(Sender: TObject);
    procedure RulerBox2RulerPosChange(Sender: TObject; Grip: Integer);
    procedure RulerBox1RulerPosChange(Sender: TObject; Grip: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit22Change(Sender: TObject);
    procedure HSVBox2Change(Sender: TObject);
    procedure Edit27Change(Sender: TObject);
    procedure Edit32Change(Sender: TObject);
    procedure Edit35Change(Sender: TObject);
    procedure TrackBarRotateChange(Sender: TObject);
    procedure EditRotateChange(Sender: TObject);
    procedure SpeedButtonFlipHorClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ImageEnProc2Progress(Sender: TObject; per: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure trkGammaChange(Sender: TObject);
    procedure cbxGammaClick(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure Edit36Change(Sender: TObject);
  private
    { Private declarations }
    mr,mg,mb:integer;	 // contrast: median values
    domod:boolean; 		 // used by user filters
    dochange:boolean;	// if true, controls can change their status
    doProgress:boolean;
	 NeedToFlip: boolean; // true when image must be flipped
    procedure applyAct(im:TImageEnView);
    procedure CopyOrg;
    procedure CopyModToOrg;
    procedure LoadFilt;
    procedure ResetParameters(rs:boolean);
    procedure UpdatePreviewZoom;
    procedure UpdatePreview;
    procedure DrawGammaGraph(g:double);
  public
    { Public declarations }
    Contrast:integer;		// contrasto(output)
    Brightness:integer;		// Brightness (output) = luminosity
    Hue,Sat,Lum:integer;	// Hue/Sat/Lum (output)
    bHue,bSat,bVal:integer;	// Hue/Sat/Val (output)
    Red,Green,Blue:integer;// RGB (output)
    Filter:TGraphFilter;   // Filtro (output)
    DownLimit,UpLimit:TRGB;	// threshold
    EDownLimit,EUpLimit:TRGB;	// equalize
    AutoEqualize:boolean;	// autoequalize
    BumpLeft,BumpTop,BumpWidth,BumpHeight:integer;	// bump map
    BumpCol:TRGB;	// bump map light color
    BumpSrc:integer;	// bump map % image
    LensLeft,LensTop,LensWidth,LensHeight:integer; // Lens
    LensRef:double;  // Lens reflection
    WaveAmplitude:integer;
    WaveWaveLength:integer;
    WavePhase:integer;
    WaveReflect:boolean;
    MorphFilter:integer;
    MorphWinSize:integer;
	 RotationAngle: double;   // rotate
    Sharpen:integer;
    SharpenSize:integer;
    // FFT
    FFTProgressPos:integer;
    FTImage:TIEFtImage;
    //
    pe:TPreviewEffects;
    Progress:TProgressRec;
    DefaultLockPreview:boolean;
    ars:array [0..PREVIEWSTABCOUNT-1] of boolean;
    InitialPage:TTabSheet;
    procedure SetLanguage(l:TMsgLanguage);
  end;

implementation

uses hyieutils;

{$R-}

{$R *.DFM}

/////////////////////////////////////////////////////////////////////////////////////
procedure TfPreviews.FormDestroy(Sender: TObject);
begin
	if assigned(FTImage) then
   	FTImage.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfPreviews.FormCreate(Sender: TObject);
{$ifdef IEFIXPREVIEWS}
var
	q:integer;
{$endif}
begin
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
   ImageEn2.Proc.AutoUndo:=False;
	{$ifdef IEFIXPREVIEWS}
	for q:=0 to ComponentCount-1 do
   	if (Components[q] is TTrackBar) then
      	(Components[q] as TTrackBar).ThumbLength:=10;
	{$endif}
   FTImage:=nil;
   PageControl1.ActivePage:=TabSheet1;
   ImageEn2.Proc.UndoLocation:=ieMemory;
end;

/////////////////////////////////////////////////////////////////////////////////////
// if rs is True initialize all
procedure TfPreviews.ResetParameters(rs:boolean);
var
	i,x,y:integer;
   iebmp:TIEBitmap;
begin
	if rs then
   	for x:=0 to high(ars) do
      	ars[x]:=false;
	//
	dochange:=false;
	// inizializza contrasto e brightness
   if (PageControl1.ActivePage=TabSheet1) and not ars[0] then begin
   	iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(imageen1.Bitmap,true);
      _getmediacontrastRGB(iebmp,mR,mG,mB);
      iebmp.free;
      Contrast:=0;
      Brightness:=0;
      edit1.text:='0';
      edit21.text:='0';
      trackbar1.position:=0;
      trackbar12.position:=0;
      ars[0]:=true;
   end;
   // inizializza HSL
   if (PageControl1.ActivePage=TabSheet2) and not ars[1] then begin
      Hue:=0; Sat:=0; Lum:=0;
      trackbar2.Position:=0;
      trackbar3.Position:=0;
      trackbar5.Position:=0;
      edit4.text:='0';
      edit2.text:='0';
      edit3.text:='0';
      ars[1]:=true;
   end;
   // inizializza rgb
   if (PageControl1.ActivePage=TabSheet3) and not ars[2] then begin
      red:=0; green:=0; blue:=0;
      trackbar6.Position:=red;
      trackbar7.Position:=green;
      trackbar8.Position:=blue;
      edit7.text:='0';
      edit6.text:='0';
      edit5.texT:='0';
      ars[2]:=true;
   end;
   // inizializza filtro utente
   if (PageControl1.ActivePage=TabSheet4) and not ars[3] then begin
      for x:=0 to 2 do
         for y:=0 to 2 do
            Filter.Values[x,y]:=0;
      Filter.Values[1,1]:=1;
      Filter.Divisor:=0;
      listbox1.itemindex:=0;
      LoadFilt;
      ars[3]:=true;
   end;
   // inizializza HSV
   if (PageControl1.ActivePage=TabSheet5) and not ars[4] then begin
      bHue:=0; bSat:=0; bVal:=0;
      trackbar9.Position:=bHue;
      trackbar10.Position:=bSat;
      trackbar11.Position:=bVal;
      edit19.text:='0';
      edit18.text:='0';
      edit17.text:='0';
      ars[4]:=true;
   end;
   // inizializza threshold (histogram)
   if (PageControl1.ActivePage=TabSheet6) and not ars[5] then begin
      DownLimit.r:=0; DownLimit.g:=0; DownLimit.b:=0;
      UpLimit.r:=255; UpLimit.g:=255; UpLimit.b:=255;
      EDownLimit.r:=0; EDownLimit.g:=0; EDownLimit.b:=0;
      EUpLimit.r:=255; EUpLimit.g:=255; EUpLimit.b:=255;
      AutoEqualize:=false;
      CheckListBox1.Checked[0]:=false;
      CheckListBox1.Checked[1]:=false;
      CheckListBox1.Checked[2]:=false;
      CheckListBox1.Checked[3]:=true;
      HistogramBox1.HistogramKind:=[hkGray];
      with RulerBox1 do begin
         GripsPos[0]:=0;
         GripsColor[0]:=clGray;
         GripsKind[0]:=gkArrow2;
         GripsPos[1]:=255;
         GripsColor[1]:=clGray;
         GripsKind[1]:=gkArrow2;
      end;
      with RulerBox2 do begin
         GripsPos[0]:=0;
         GripsColor[0]:=clGray;
         GripsPos[1]:=255;
         GripsColor[1]:=clGray;
      end;
      speedbutton3.down:=false;
      ars[5]:=true;
   end;
   // inizializza bump map
   if (PageControl1.ActivePage=TabSheet7) and not ars[6] then begin
      BumpLeft:=ImageEn1.IEBitmap.Width div 2;
      BumpTop:=ImageEn1.IEBitmap.Height div 2;
      BumpWidth:=imax(ImageEn1.IEBitmap.Width,ImageEn1.IEBitmap.Height) div 2;
      BumpHeight:=BumpWidth;
      BumpCol:=CreateRGB(255,255,255);
      BumpSrc:=0;
      edit22.text:=inttostr(BumpLeft);
      edit23.text:=inttostr(BumpTop);
      edit24.text:=inttostr(BumpWidth);
      edit25.text:=inttostr(BumpHeight);
      edit26.text:='0';
      HsvBox2.SetRGB(255,255,255);
      ars[6]:=true;
   end;
   // inizializza Lens
   if (PageControl1.ActivePage=TabSheet8) and not ars[7] then begin
      LensLeft:=ImageEn1.IEBitmap.Width div 2;
      LensTop:=ImageEn1.IEBitmap.Height div 2;
      LensWidth:=imax(ImageEn1.IEBitmap.Width,ImageEn1.IEBitmap.Height) div 2;
      LensHeight:=LensWidth;
      LensRef:=1.7;
      edit27.text:=inttostr(LensLeft);
      edit28.text:=inttostr(LensTop);
      edit29.text:=inttostr(LensWidth);
      edit30.text:=inttostr(LensHeight);
      edit31.text:=inttostr( trunc(LensRef*10-10) );
      ars[7]:=true;
   end;
   // inizializza Wave
   if (PageControl1.ActivePage=TabSheet9) and not ars[8] then begin
      WaveAmplitude:=10;
      WaveWaveLength:=10;
      WavePhase:=0;
      WaveReflect:=false;
      edit32.text:=inttostr(WaveAmplitude);
      edit33.text:=inttostr(WaveWaveLength);
      edit34.text:=inttostr(WavePhase);
      checkbox2.checked:=WaveReflect;
		ars[8]:=true;
   end;
   // inizializza Morph filters
   if (PageControl1.ActivePage=TabSheet10) and not ars[9] then begin
   	MorphFilter:=0;
      MorphWinSize:=1;
      ListBox2.ItemIndex:=MorphFilter;
      Edit35.Text:=IntToStr(MorphWinSize);
      ars[9]:=true;
   end;
   // initialize Rotate
	if (PageControl1.ActivePage=TabSheet11) and not ars[10] then begin
		RotationAngle := 0;
		EditRotate.Text := '0';
		TrackBarRotate.Position := 0;
		SpeedButtonFlipHor.Down := false;
		SpeedButtonFlipVer.Down := false;
		NeedToFlip := false;
		ars[10] := true;
	end;
   // initialize FFT
	if (PageControl1.ActivePage=TabSheet12) and not ars[11] then begin
   	CheckBox1.Checked:=true;
		ars[11] := true;
	end;
   // initialize Gamma Correction
	if (PageControl1.ActivePage=tabGamma) and not ars[12] then begin
      trkGamma.Position:=10;
      trkGammaChange(nil);
      // Check all the gamma boxes
      for I := 0 to cbxGamma.items.count - 1 do
      	cbxGamma.checked[i]:=true;
      ars[12] := true;
   end;
	// initialize Sharpen
   if (PageControl1.ActivePage=TabSheet14) and not ars[13] then begin
   	Sharpen:=1;
      SharpenSize:=4;
      edit36.text:='1';
      edit37.text:='4';
      trackbar4.position:=1;
      ars[13]:=true;
   end;
	//
   dochange:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfPreviews.FormActivate(Sender: TObject);
begin
	doProgress:=false;
	dochange:=true;
   ResetParameters(true);
   chkLockPreview.checked:=DefaultLockPreview;
   button3.enabled:=not chkLockPreview.checked;
   HistogramBox1.AttachedImageEnProc:=ImageEn2.Proc;
   PageControl1.Visible:=false;
	TabSheet1.TabVisible:= (peAll in pe) or (peContrast in pe); TabSheet1.tag:=1;
   TabSheet2.TabVisible:= (peAll in pe) or (peHSL in pe);      TabSheet2.tag:=2;
   TabSheet3.TabVisible:= (peAll in pe) or (peRGB in pe);      TabSheet3.tag:=3;
   TabSheet4.TabVisible:= (peAll in pe) or (peUserFilt in pe); TabSheet4.tag:=4;
   TabSheet5.TabVisible:= (peAll in pe) or (peHSV in pe);      TabSheet5.tag:=5;
   TabSheet6.TabVisible:= (peAll in pe) or (peEqualize in pe); TabSheet6.tag:=6;
   TabSheet7.TabVisible:= (peAll in pe) or (peBumpMap in pe);  TabSheet7.tag:=7;
   TabSheet8.TabVisible:= (peAll in pe) or (peLens in pe);     TabSheet8.tag:=8;
   TabSheet9.TabVisible:= (peAll in pe) or (peWave in pe);     TabSheet9.tag:=9;
   TabSheet10.TabVisible:=(peAll in pe) or (peMorph in pe);    TabSheet10.tag:=10;
   TabSheet11.TabVisible:=(peAll in pe) or (peRotate in pe);   TabSheet11.tag:=11;
   TabSheet12.TabVisible:=(peAll in pe) or (peFFT in pe);      TabSheet12.tag:=12;
   TabGamma.TabVisible:=(peAll in pe) or (peGamma in pe);      TabGamma.tag:=13;
   TabSheet14.TabVisible:=(peAll in pe) or (peSharpen in pe);  TabSheet14.tag:=14;
   if InitialPage<>nil then
      PageControl1.ActivePage:=InitialPage
   else
      PageControl1.ActivePage:=PageControl1.FindNextPage(nil,true,true);
   PageControl1.Visible:=true;
	// fit
	imageen1.Fit;
   //
   if assigned(application) then
	  	application.processmessages;
   PageControl1Change(self);	// Chiama CopyOrg
end;

/////////////////////////////////////////////////////////////////////////////////////
// applica solo l'effetto corrente
procedure TfPreviews.ApplyAct(im:TImageEnView);
var
  gamChannels:TIEChannels;
	v1:TIEProgressEvent;
	v2:TObject;
   xProgress:TProgressRec;
   xLeft,xTop,xWidth,xHeight,x1,x2,y1,y2:integer;
   xz:double;
   tmpft:TIEFtImage;
   cx,cy:double;
   iebmp:TIEBitmap;
begin
	if doProgress then
   	xProgress:=Progress
   else
   	fillchar(xProgress,sizeof(xProgress),0);
  	v1:=xProgress.fOnProgress;
   v2:=xProgress.Sender;
	if PageControl1.ActivePage=TabSheet1 then begin
   	iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.bitmap,true);
		_ContrastRGB(iebmp,Contrast,mr,mg,mb,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      _IntensityRGBall(iebmp,Brightness,Brightness,Brightness,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
   end;
	if PageControl1.ActivePage=TabSheet2 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	_HSLvar(iebmp,Hue,Sat,Lum,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet3 then begin
   	iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.bitmap,true);
   	_IntensityRGBall(iebmp,red,green,blue,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet4 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	_ApplyFilter(iebmp,Filter,0,0,im.IEBitmap.Width,im.IEBitmap.Height,xProgress);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet5 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	_HSVvar(iebmp,bHue,bSat,bVal,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet6 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	_Threshold(iebmp,DownLimit,UpLimit,CreateRGB(0,0,0),CreateRGB(255,255,255),0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
		_HistEqualize(iebmp,EDownLimit,EUpLimit,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
		if SpeedButton3.Down then
      	_HistAutoEqualize(iebmp,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
	end;
   if PageControl1.ActivePage=TabSheet7 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	if im<>ImageEn1 then begin
         xz:=ImageEn1.Zoom/100;
         xLeft:=trunc(BumpLeft*xz-ImageEn1.ViewX);
         xTop:=trunc(BumpTop*xz-ImageEn1.ViewY);
         xWidth:= trunc(BumpWidth*xz);
         xHeight:= trunc(BumpHeight*xz );
         _BumpMapping(iebmp,xLeft,xTop,xWidth,xHeight,BumpSrc,BumpCol,0,0,im.IEBitmap.Width,im.IEBitmap.Height,xProgress);
      end else
			_BumpMapping(iebmp,BumpLeft,BumpTop,BumpWidth,BumpHeight,BumpSrc,BumpCol,0,0,im.IEBitmap.Width,im.IEBitmap.Height,xProgress);
      iebmp.free;
   end;
	if PageControl1.ActivePage=TabSheet8 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	if im<>ImageEn1 then begin
         xz:=ImageEn1.Zoom/100;
         xLeft:=trunc(LensLeft*xz-ImageEn1.ViewX);
         xTop:=trunc(LensTop*xz-ImageEn1.ViewY);
         xWidth:= trunc(LensWidth*xz);
         xHeight:= trunc(LensHeight*xz );
         _Lens(iebmp,xLeft,xTop,xWidth,xHeight,LensRef,xProgress);
      end else
      	_Lens(iebmp,LensLeft,LensTop,LensWidth,LensHeight,LensRef,xProgress);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet9 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
   	if im<>ImageEn1 then begin
         xz:=ImageEn1.Zoom/100;
         x1:= trunc(WaveAmplitude*xz);
         x2:= trunc(WaveWaveLength*xz );
         _Wave(iebmp,x1,x2,WavePhase,WaveReflect,xProgress);
      end else
      	_Wave(iebmp,WaveAmplitude,WaveWaveLength,WavePhase,WaveReflect,xProgress);
      iebmp.free;
   end;
   if PageControl1.ActivePage=TabSheet10 then begin
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.Bitmap,true);
      _MorphFilter(iebmp,MorphWinSize,MorphFilter,0,0,im.IEBitmap.Width,im.IEBitmap.Height,v1,v2);
      iebmp.free;
   end;
	if PageControl1.ActivePage=TabSheet11 then begin
		if SpeedButtonFlipHor.Down then
        	im.Proc.Flip(fdHorizontal);
		if SpeedButtonFlipVer.Down then
        	im.Proc.Flip(fdVertical);
		if (RotationAngle <> 0) then
			im.Proc.Rotate(RotationAngle, true, ierFast,-1);
		NeedToFlip := false;
	end;
	if PageControl1.ActivePage=TabSheet12 then begin
   	if im<>ImageEn2 then begin
      	// final image (full size)
         iebmp:=TIEBitmap.Create;
         iebmp.EncapsulateTBitmap(im.Bitmap,true);
         FFTProgressPos:=0;
         cx:=FTImage.ComplexWidth;
         cy:=FTImage.ComplexHeight;
         if checkbox1.checked then
				FTImage.BuildFT(iebmp,ieitGRAYSCALE)
         else
	         FTImage.BuildFT(iebmp,ieitRGB);
         cx:=FTImage.ComplexWidth/cx;
         cy:=FTImage.ComplexHeight/cy;
         with ImageEnView1 do begin
         	x1:=trunc(SelX1*cx);
            y1:=trunc(SelY1*cy);
            x2:=trunc(SelX2*cx);
            y2:=trunc(SelY2*cy);
            if Selected then
               FTImage.ClearZone(x1,y1,x2,y2);
            Deselect;
         end;
         FFTProgressPos:=0;
         im.Proc.FTConvertFrom(FTImage);
         ProgressBar1.Position:=0;
         iebmp.free;
      end else begin
      	// preview
         FFTProgressPos:=0;
         tmpft:=TIEFtImage.Create;
         tmpft.assign(FTImage);
         with ImageEnView1 do
            if Selected then
               FTImage.ClearZone(SelX1,SelY1,SelX2,SelY2);
         ImageEnProc2.FTDisplayFrom(FTImage);
         ImageEnView1.Fit;
         FFTProgressPos:=0;
         ImageEn2.Proc.FTConvertFrom(FTImage);
         ProgressBar1.Position:=0;
         FTImage.assign(tmpft);
         tmpft.free;
      end;
   end;
   // Gamma Correction
   if PageControl1.ActivePage=TabGamma then begin
      gamChannels:=[];
      if cbxGamma.checked[0] then gamChannels:=gamChannels+[iecRed];
      if cbxGamma.checked[1] then gamChannels:=gamChannels+[iecGreen];
      if cbxGamma.checked[2] then gamChannels:=gamChannels+[iecBlue];
      im.Proc.GammaCorrect(trkGamma.position / 10, gamChannels);
   end;
   // Sharpen
	if PageControl1.ActivePage=TabSheet14 then begin
   	iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(im.bitmap,true);
		_Sharpen(iebmp,0,0,im.IEBitmap.Width,im.IEBitmap.Height,Sharpen,SharpenSize,v1,v2);
      iebmp.free;
   end;
	//
   UpdatePreviewZoom;
end;

procedure TfPreviews.UpdatePreviewZoom;
begin
   // pages that disables the zoom
   case PageControl1.ActivePage.tag of
   	1,2,3,4,5,6,10,13,14:
          ImageEn1.MouseInteract:=ImageEn1.MouseInteract+[miZoom];
        else
          begin
             ImageEn1.MouseInteract:=ImageEn1.MouseInteract-[miZoom];
             ImageEn1.Fit;
           end;
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// Copia zona originale in elaborata e applica l'effetto corrente
procedure TfPreviews.CopyOrg;
var
   tmpbitmap:TBitmap;
   iebmp:TIEBitmap;
   newwidth,newheight:integer;
begin
	ImageEn2.LockPaint;
	imageen2.IEBitmap.Width:=imageen1.ExtentX;
   imageen2.IEbitmap.Height:=imageen1.ExtentY;
   imageen1.DrawTo(imageen2.bitmap.canvas);
  	imageen2.Proc.SaveUndo(ieuImage);
   // FFT
   if not assigned(FTImage) then begin
      FTImage:=TIEFtImage.Create;
      FTImage.OnProgress:=ImageEnProc2.OnProgress;
   end;
   if imageen1.IEBitmap.Width>imageen1.IEBitmap.Height then begin
   	newwidth:=128;
      NewHeight:=(imageen1.IEBitmap.Height*NewWidth) div imageen1.IEBitmap.Width;
   end else begin
      newheight:=128;
   	NewWidth:=(imageen1.IEBitmap.Width*NewHeight) div imageen1.IEBitmap.Height;
   end;
   tmpbitmap:=tbitmap.create;
   tmpbitmap.pixelformat:=pf24bit;
   tmpbitmap.width:=newwidth;
   tmpbitmap.height:=newheight;
   SetStretchBltMode(tmpbitmap.canvas.handle,HALFTONE);
   SetBrushOrgEx(tmpbitmap.canvas.handle,0,0,nil);
   tmpbitmap.Canvas.StretchDraw(rect(0,0,newwidth,newheight),ImageEn1.bitmap);
   FFTProgressPos:=0;
   iebmp:=TIEBitmap.Create;
   iebmp.EncapsulateTBitmap(tmpBitmap,true);
   if checkbox1.checked then
		FTImage.BuildFT(iebmp,ieitGRAYSCALE)
   else
	   FTImage.BuildFT(iebmp,ieitRGB);
   iebmp.free;
   tmpbitmap.free;
   ProgressBar1.Position:=0;
   //
   ApplyAct(imageen2);
   ImageEn2.UnLockPaint;
   if PageControl1.ActivePage=TabSheet6 then
   	HistogramBox1.Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copia immagine modificata in originale (applica effetto corrente a imageen1)
procedure TfPreviews.CopyModToOrg;
begin
	ApplyAct(imageen1);
   imageen1.update;
   imageen1.paint;	// <- needed
   CopyOrg;
end;

/////////////////////////////////////////////////////////////////////////////////////
// variazione HSL (trackbars 2/3/5)
procedure TfPreviews.TrackBar2Change(Sender: TObject);
begin
	if not dochange then exit;
   if (Hue<>trackbar2.position) or (Sat<>trackbar3.position) or (Lum<>trackbar5.position) then begin
      Hue:=trackbar2.position; Sat:=trackbar3.position; Lum:=trackbar5.position;
		edit4.text:=inttostr(Hue);
		edit2.text:=inttostr(Sat);
	   edit3.text:=inttostr(Lum);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// variazione HSL (edits 4/2/3)
procedure TfPreviews.Edit4Change(Sender: TObject);
var
	h,s,l:integer;
begin
	if not dochange then exit;
	h:=strtointdef(edit4.text,0);
	s:=strtointdef(edit2.text,0);
   l:=strtointdef(edit3.text,0);
   if (Hue<>h) or (Sat<>s) or (Lum<>l) then begin
		trackbar2.position:=h;
      trackbar3.position:=s;
      trackbar5.position:=l;
      trackbar2change(self);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// cambia tipo effetto (pagecontrol1)
procedure TfPreviews.PageControl1Change(Sender: TObject);
begin
   ResetParameters(false);
  UpdatePreviewZoom;
	CopyOrg;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copia immagine modificata in originale (applica effetto corrente a imageen1)
procedure TfPreviews.Button6Click(Sender: TObject);
begin
	CopyModToOrg;
   ResetParameters(true);
   CopyOrg;
end;

/////////////////////////////////////////////////////////////////////////////////////
// cambia zoom/view di imageen1 (immagine originale)
procedure TfPreviews.ImageEn1ViewChange(Sender: TObject; Change: Integer);
begin
//	if (Change=0) and imageen1.MouseCapture then
//   	exit;	// movimento in corso
	CopyOrg;
end;

/////////////////////////////////////////////////////////////////////////////////////
// variazione RGB (trackbars6/7/8)
procedure TfPreviews.TrackBar6Change(Sender: TObject);
begin
	if not dochange then exit;
   if (red<>trackbar6.position) or (green<>trackbar7.position) or (blue<>trackbar8.position) then begin
      red:=trackbar6.position; green:=trackbar7.position; blue:=trackbar8.position;
		edit7.text:=inttostr(red);
		edit6.text:=inttostr(green);
	   edit5.text:=inttostr(blue);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// variazione RGB (edit7-6-5)
procedure TfPreviews.Edit7Change(Sender: TObject);
var
	rr,gg,bb:integer;
begin
	if not dochange then exit;
	rr:=strtointdef(edit7.text,0);
	gg:=strtointdef(edit6.text,0);
   bb:=strtointdef(edit5.text,0);
   if (red<>rr) or (green<>gg) or (blue<>bb) then begin
		trackbar6.position:=rr;
      trackbar7.position:=gg;
      trackbar8.position:=bb;
      trackbar6change(self);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// variazione valori filtro (edit8...16)
procedure TfPreviews.Edit8Change(Sender: TObject);
begin
  	if domod then begin
		filter.Divisor:=strtointdef(edit20.text,1);
	  	with TEdit(sender) do
	   	filter.Values[(tag div 3),tag-(tag div 3)*3]:=strtointdef(text,0);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Selezione valore nel list box - valori presettati filtri
procedure TfPreviews.ListBox1Click(Sender: TObject);
begin
	if not dochange then exit;
	filter:=IEFiltPres[listbox1.itemindex];
   LoadFilt;
      if chkLockPreview.checked then begin
		imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfPreviews.LoadFilt;
begin
	domod:=false;
	edit8.text:=inttostr(filter.Values[0,0]);
   edit9.text:=inttostr(filter.Values[1,0]);
   edit10.text:=inttostr(filter.Values[2,0]);
   edit11.text:=inttostr(filter.Values[0,1]);
   edit12.text:=inttostr(filter.Values[1,1]);
   edit13.text:=inttostr(filter.Values[2,1]);
   edit14.text:=inttostr(filter.Values[0,2]);
   edit15.text:=inttostr(filter.Values[1,2]);
   edit16.text:=inttostr(filter.Values[2,2]);
   edit20.text:=inttostr(filter.divisor);
   domod:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Rende effettivo l'effetto corrente e chiude (implicito)
procedure TfPreviews.Button1Click(Sender: TObject);
begin
	DoProgress:=true;
	ApplyAct(imageen1);
   imageen1.update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// load filter
procedure TfPreviews.Button4Click(Sender: TObject);
begin
	if OpenDialog1.execute then begin
		filter:=LoadFilterFromFile(OpenDialog1.filename);
      LoadFilt;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// save filter
procedure TfPreviews.Button5Click(Sender: TObject);
begin
	if SaveDialog1.execute then
   	SaveFilterToFile(SaveDialog1.filename,Filter);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Channels
procedure TfPreviews.CheckListBox1Click(Sender: TObject);
begin
	if not dochange then exit;
	HistogramBox1.HistogramKind:=[];
	if CheckListBox1.Checked[0] then
   	HistogramBox1.HistogramKind:=HistogramBox1.HistogramKind+[hkRed];
	if CheckListBox1.Checked[1] then
   	HistogramBox1.HistogramKind:=HistogramBox1.HistogramKind+[hkGreen];
	if CheckListBox1.Checked[2] then
   	HistogramBox1.HistogramKind:=HistogramBox1.HistogramKind+[hkBlue];
	if CheckListBox1.Checked[3] then
   	HistogramBox1.HistogramKind:=HistogramBox1.HistogramKind+[hkGray];
   RulerBox1.Left:=HistogramBox1.HistogramXPos;
   RulerBox1.Width:=HistogramBox1.Width-RulerBox1.Left;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambia posizione RulerBox1
procedure TfPreviews.RulerBox1RulerPosChange(Sender: TObject;
  Grip: Integer);
begin
	if not dochange then exit;
	// Aggiorna labels
	if RulerBox1.GripsPos[0]>RulerBox1.GripsPos[1] then
   	if Grip=0 then
	   	RulerBox1[1]:=RulerBox1[0]
      else
			RulerBox1[0]:=RulerBox1[1];
	if Grip=0 then
   	Label16.Caption:=inttostr(trunc(RulerBox1.GripsPos[0]))
	else if Grip=1 then
   	Label17.Caption:=inttostr(trunc(RulerBox1.GripsPos[1]));
	//
   if (CheckListBox1.Checked[0]) or (CheckListBox1.Checked[3]) then begin
   	// RED
	  	DownLimit.r:=trunc(RulerBox1.GripsPos[0]);
   	UpLimit.r:=trunc(RulerBox1.GripsPos[1]);
   end;
   if (CheckListBox1.Checked[1]) or (CheckListBox1.Checked[3]) then begin
   	// GREEN
	  	DownLimit.g:=trunc(RulerBox1.GripsPos[0]);
   	UpLimit.g:=trunc(RulerBox1.GripsPos[1]);
   end;
   if (CheckListBox1.Checked[2]) or (CheckListBox1.Checked[3]) then begin
   	// BLUE
	  	DownLimit.b:=trunc(RulerBox1.GripsPos[0]);
   	UpLimit.b:=trunc(RulerBox1.GripsPos[1]);
   end;
   if chkLockPreview.checked then begin
		imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TfPreviews.RulerBox2RulerPosChange(Sender: TObject;
  Grip: Integer);
begin
	if not dochange then exit;
	// Aggiorna labels
	if RulerBox2.GripsPos[0]>RulerBox2.GripsPos[1] then
   	if Grip=0 then
	   	RulerBox2[1]:=RulerBox2[0]
      else
			RulerBox2[0]:=RulerBox2[1];
	if Grip=0 then
   	Label20.Caption:=inttostr(trunc(RulerBox2.GripsPos[0]))
	else if Grip=1 then
   	Label21.Caption:=inttostr(trunc(RulerBox2.GripsPos[1]));
	//
   if (CheckListBox1.Checked[0]) or (CheckListBox1.Checked[3]) then begin
   	// RED
	  	EDownLimit.r:=trunc(RulerBox2.GripsPos[0]);
   	EUpLimit.r:=trunc(RulerBox2.GripsPos[1]);
   end;
   if (CheckListBox1.Checked[1]) or (CheckListBox1.Checked[3]) then begin
   	// GREEN
	  	EDownLimit.g:=trunc(RulerBox2.GripsPos[0]);
   	EUpLimit.g:=trunc(RulerBox2.GripsPos[1]);
   end;
   if (CheckListBox1.Checked[2]) or (CheckListBox1.Checked[3]) then begin
   	// BLUE
	  	EDownLimit.b:=trunc(RulerBox2.GripsPos[0]);
   	EUpLimit.b:=trunc(RulerBox2.GripsPos[1]);
   end;
   if chkLockPreview.checked then begin
		imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// BUTTON - AUTOEQUALIZE
procedure TfPreviews.SpeedButton3Click(Sender: TObject);
begin
	if chkLockPreview.checked then begin
		imageen2.Proc.undo;
	   ApplyAct(imageen2);
	   imageen2.paint;
   end;
end;

// change contrast (trackbar1) or brightness (trackbar12)
procedure TfPreviews.TrackBar1Change(Sender: TObject);
begin
	if not dochange then exit;
	if (Contrast<>trackbar1.position) or (Brightness<>trackbar12.position) then begin
   	Contrast:=trackbar1.position;
      edit1.text:=inttostr(Contrast);
      Brightness:=trackbar12.position;
      edit21.text:=inttostr(Brightness);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

// change contrast (edit1) or brightness (edit21)
procedure TfPreviews.Edit1Change(Sender: TObject);
var
	v,b:integer;
begin
	if not dochange then exit;
	v:=strtointdef(edit1.text,0);
   b:=strtointdef(edit21.text,0);
   if (v<>Contrast) or (b<>Brightness) then begin
		trackbar1.position:=v;
      trackbar12.position:=b;
      trackbar1change(self);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Set language
procedure TfPreviews.SetLanguage(l:TMsgLanguage);
begin
	Caption:=iemsg(IEMSG_PREVIEW,l);
   Label1.Caption:=iemsg(IEMSG_SOURCE,l)+':';
   Label2.Caption:=iemsg(IEMSG_RESULT,l)+':';
   Button1.Caption:=iemsg(IEMSG_OK,l);
   Button2.Caption:=iemsg(IEMSG_CANCEL,l);
   chkLockPreview.Caption:=iemsg(IEMSG_LOCKPREVIEW,l);
   chkLockPreview.Hint:=iemsg(IEMSG_LOCKPREVIEWHINT,l);
   Button6.hint:=iemsg(IEMSG_COPYRESULTTOSOURCE,l);
   button3.caption:=iemsg(IEMSG_PREVIEW,l);
   // Contrast
   TabSheet1.Caption:=iemsg(IEMSG_CONTRAST,l);
   Label3.Caption:=iemsg(IEMSG_CONTRAST,l);
   Label22.Caption:=iemsg(IEMSG_BRIGHTNESS,l)+':';
   // HSB
	Label10.Caption:=iemsg(IEMSG_HUE,l)+' (H):';
   Label11.Caption:=iemsg(IEMSG_SATURATION,l)+' (S):';
   Label12.Caption:=iemsg(IEMSG_VALUE,l)+' (V):';
   Label13.Caption:=iemsg(IEMSG_BASECOLOR,l)+':';
   Label14.Caption:=iemsg(IEMSG_NEWCOLOR,l)+':';
   // HSL
	Label4.Caption:=iemsg(IEMSG_HUE,l)+' (H):';
	Label5.Caption:=iemsg(IEMSG_SATURATION,l)+' (S):';
   Label6.Caption:=iemsg(IEMSG_LUMINOSITY,l)+' (L):';
   // RGB
	Label7.Caption:=iemsg(IEMSG_RED,l)+' (R):';
   Label8.Caption:=iemsg(IEMSG_GREEN,l)+' (G):';
	Label9.Caption:=iemsg(IEMSG_BLUE,l)+' (B):';
   // Filters
   TabSheet4.Caption:=iemsg(IEMSG_USERFILTER,l);
   GroupBox1.Caption:=' '+iemsg(IEMSG_FILTERVALUES,l)+' ';
   GroupBox3.Caption:=' '+iemsg(IEMSG_PRESETS,l)+' ';
   Label15.Caption:=iemsg(IEMSG_DIVISOR,l);
   Button4.Caption:=iemsg(IEMSG_LOAD,l);
   Button5.Caption:=iemsg(IEMSG_SAVE,l);
   SaveDialog1.Title:=iemsg(IEMSG_SAVEFILTER,l);
   OpenDialog1.Title:=iemsg(IEMSG_LOADFILTER,l);
   // Hist equalization
   TabSheet6.Caption:=iemsg(IEMSG_EQUALIZATION,l);
   Label19.Caption:=iemsg(IEMSG_EQUALIZATION,l);
   Label18.Caption:=iemsg(IEMSG_THRESHOLD,l);
   SpeedButton3.Caption:=iemsg(IEMSG_EQUALIZE,l);
   GroupBox4.Caption:=' '+iemsg(IEMSG_HISTOGRAM,l)+' ';
   // we have to clear before add, this avoid memory leak on some Delphi versions
   CheckListBox1.Items.Clear;
	CheckListBox1.Items.add( iemsg(IEMSG_RED,l) );
	CheckListBox1.Items.add( iemsg(IEMSG_GREEN,l) );
	CheckListBox1.Items.add( iemsg(IEMSG_BLUE,l) );
	CheckListBox1.Items.add( iemsg(IEMSG_GRAY,l) );
   // Bump map
   TabSheet7.Caption:=iemsg(IEMSG_BUMPMAP,l);
	GroupBox2.Caption:=' '+iemsg(IEMSG_LIGHT,l)+' ';
   label27.Caption:=iemsg(IEMSG_LEFT,l)+':';
   label28.caption:=iemsg(IEMSG_TOP,l)+':';
   label23.caption:=iemsg(IEMSG_WIDTH,l)+':';
   label24.caption:=iemsg(IEMSG_HEIGHT,l)+':';
   label26.caption:=iemsg(IEMSG_COLOR,l)+':';
   label25.caption:=iemsg(IEMSG_SOURCEIMAGEQUANTITY,l)+' (%):';
   // Lens
   TabSheet8.Caption:=iemsg(IEMSG_LENS,l);
	GroupBox5.Caption:=' '+iemsg(IEMSG_LENS,l)+' ';
   label32.Caption:=iemsg(IEMSG_LEFT,l)+':';
	label33.caption:=iemsg(IEMSG_TOP,l)+':';
	label29.caption:=iemsg(IEMSG_WIDTH,l)+':';
	label30.caption:=iemsg(IEMSG_HEIGHT,l)+':';
	label31.caption:=iemsg(IEMSG_REFRACTION,l)+':';
   // Wave
   TabSheet9.Caption:=iemsg(IEMSG_WAVE,l);
   GroupBox6.Caption:=' '+iemsg(IEMSG_WAVE,l)+' ';
   label34.caption:=iemsg(IEMSG_AMPLITUDE,l);
   label35.caption:=iemsg(IEMSG_WAVELENGTH,l);
   label36.caption:=iemsg(IEMSG_PHASE,l);
   checkbox2.Caption:=iemsg(IEMSG_REFLECTIVE,l);
   // Morph filter
   TabSheet10.Caption:=iemsg(IEMSG_MORPHFILTER,l);
   GroupBox7.Caption:=' '+iemsg(IEMSG_MORPHFILTER,l)+' ';
   Label37.Caption:=iemsg(IEMSG_FILTER,l)+':';
   Label38.Caption:=iemsg(IEMSG_WINDOWSIZE,l)+':';
   ListBox2.Clear;
   ListBox2.Items.Add(iemsg(IEMSG_MAXIMUM,l));
	ListBox2.Items.Add(iemsg(IEMSG_MINIMUM,l));
   ListBox2.Items.Add(iemsg(IEMSG_OPEN,l));
   ListBox2.Items.Add(iemsg(IEMSG_CLOSE,l));
   // Rotate
   TabSheet11.Caption := iemsg(IEMSG_ROTATE,l);
	LabelRotate.Caption := iemsg(IEMSG_ROTATE,l)+':';
	LabelFlip.Caption := iemsg(IEMSG_FLIP,l);
	SpeedButtonFlipHor.Caption := iemsg(IEMSG_FLIPHOR,l);
	SpeedButtonFlipVer.Caption := iemsg(IEMSG_FLIPVER,l);
   // FFT
   GroupBox8.Caption:=' '+iemsg(IEMSG_SELECTTHEREGIONTOCLEAR,l)+' ';
   Clear.Caption:=iemsg(IEMSG_CLEAR,l);
   Button7.Caption:=iemsg(IEMSG_RESET,l);
   CheckBox1.Caption:=iemsg(IEMSG_GRAYSCALE,l);
   // gamma
	label39.caption:=iemsg(IEMSG_GAMMACORRECTION,l);
   cbxGamma.Items[0]:=iemsg(IEMSG_RED,l);
   cbxGamma.Items[1]:=iemsg(IEMSG_GREEN,l);
   cbxGamma.Items[2]:=iemsg(IEMSG_BLUE,l);
   // sharpen
   Label44.Caption:=iemsg(IEMSG_AMPLITUDE,l);
   Label45.Caption:=iemsg(IEMSG_WINDOWSIZE,l);
end;

/////////////////////////////////////////////////////////////////////////////////////
// preview
procedure TfPreviews.Button3Click(Sender: TObject);
begin
	imageen2.Proc.undo;
   ApplyAct(imageen2);
   imageen2.paint;
end;

/////////////////////////////////////////////////////////////////////////////////////
// preview-lock
procedure TfPreviews.SpeedButton1Click(Sender: TObject);
begin
	if chkLockPreview.checked then begin
		imageen2.Proc.undo;
	   ApplyAct(imageen2);
	   imageen2.paint;
   end;
  	button3.enabled:=not chkLockPreview.checked;	// enable/disable preview button
end;

/////////////////////////////////////////////////////////////////////////////////////
// Variazione HSV (trackbar9-10-11)
procedure TfPreviews.TrackBar9Change(Sender: TObject);
begin
	if not dochange then exit;
   if (bHue<>trackbar9.position) or (bSat<>trackbar10.position) or (bVal<>trackbar11.position) then begin
      bHue:=trackbar9.position; bSat:=trackbar10.position; bVal:=trackbar11.position;
		edit19.text:=inttostr(bHue);
		edit18.text:=inttostr(bSat);
	   edit17.text:=inttostr(bVal);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Variazione HSV (edit19-18-17)
procedure TfPreviews.Edit19Change(Sender: TObject);
var
	h,s,v:integer;
begin
	if not dochange then exit;
	h:=strtointdef(edit19.text,0);
	s:=strtointdef(edit18.text,0);
   v:=strtointdef(edit17.text,0);
   if (bHue<>h) or (bSat<>s) or (bVal<>v) then begin
		trackbar9.position:=h;
      trackbar10.position:=s;
      trackbar11.position:=v;
      trackbar2change(self);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambia HSVBox
// 3=org   1=dest
procedure TfPreviews.HSVBox3Change(Sender: TObject);
begin
	trackbar9.Position:=HSVBox1.Hue-HSVBox3.Hue;
   trackbar10.Position:=HSVBox1.Sat-HSVBox3.Sat;
	trackbar11.Position:=HSVBox1.Val-HSVBox3.Val;
   TrackBar9Change(Self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambia BumpLeft, BumpTop, BumpWidth, BumpHeight (edit22-25)
procedure TfPreviews.Edit22Change(Sender: TObject);
var
	bleft,btop,bwidth,bheight:integer;
   bsrc:integer;
begin
	if not dochange then exit;
	bleft:=strtointdef(edit22.text,0);
   btop:=strtointdef(edit23.text,0);
   bwidth:=strtointdef(edit24.text,0);
   bheight:=strtointdef(edit25.text,0);
   bsrc:=strtointdef(edit26.text,0);
   if (bleft<>BumpLeft) or (btop<>BumpTop) or (bwidth<>BumpWidth) or (bheight<>BumpHeight) or
      (bsrc<>BumpSrc) then begin
		BumpLeft:=bleft;
      BumpTop:=btop;
      BumpWidth:=bwidth;
      BumpHeight:=bheight;
      BumpSrc:=bsrc;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambia BumpCol (HSVBox2)
procedure TfPreviews.HSVBox2Change(Sender: TObject);
begin
	if not dochange then exit;
   BumpCol:=CreateRGB(HSVBox2.Red,HSVBox2.Green,HSVBox2.Blue);
   if chkLockPreview.checked then begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// click sull'immagine, preleva colore se siamo in variazione HSV
// sposta luce se siamo in BumpMap
// sposta lente se siamo in Lens
procedure TfPreviews.ImageEn2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
	h,s,v:integer;
   c:TColor;
   rgb:TRGB;
begin
   if (PageControl1.ActivePage=TabSheet5) and (Button=mbLeft) then begin
   	// HSV
   	c:=imageen2.GetCanvas.pixels[x,y];
      rgb:=TColor2TRGB(c);
   	RGB2HSV(rgb,h,s,v);
      HSVBox3.Hue:=h;
      HSVBox3.Sat:=s;
      HSVBox3.Val:=v;
	end;
	if PageControl1.ActivePage=TabSheet7 then begin
   	// Bump map
      BumpLeft:=trunc((X-ImageEn1.OffSetX)*(100/ImageEn1.Zoom))+ImageEn1.ViewX;
      BumpTop:=trunc((Y-ImageEn1.OffSetY)*(100/ImageEn1.zoom))+ImageEn1.ViewY;
      dochange:=false;
	   edit22.text:=inttostr(BumpLeft);
	   edit23.text:=inttostr(BumpTop);
      dochange:=true;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
	if PageControl1.ActivePage=TabSheet8 then begin
   	// Lens
      LensLeft:=trunc((X-ImageEn1.OffSetX)*(100/ImageEn1.Zoom))+ImageEn1.ViewX;
      LensTop:=trunc((Y-ImageEn1.OffSetY)*(100/ImageEn1.zoom))+ImageEn1.ViewY;
      dochange:=false;
	   edit27.text:=inttostr(LensLeft);
	   edit28.text:=inttostr(LensTop);
      dochange:=true;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambio controlli Lens
procedure TfPreviews.Edit27Change(Sender: TObject);
var
	lleft,ltop,lwidth,lheight:integer;
   lref:double;
begin
	if not dochange then exit;
	lleft:=strtointdef(edit27.text,0);
   ltop:=strtointdef(edit28.text,0);
   lwidth:=strtointdef(edit29.text,0);
   lheight:=strtointdef(edit30.text,0);
   lref:=strtointdef(edit31.text,0)/10+1;
   if (lleft<>LensLeft) or (ltop<>LensTop) or (lwidth<>LensWidth) or (lheight<>LensHeight) or
      (lref<>LensRef) then begin
		LensLeft:=lleft;
      LensTop:=ltop;
      LensWidth:=lwidth;
      LensHeight:=lheight;
      LensRef:=lref;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Cambio controlli Wave
procedure TfPreviews.Edit32Change(Sender: TObject);
var
    lWaveAmplitude:integer;
    lWaveWaveLength:integer;
    lWavePhase:integer;
    lWaveReflect:boolean;
begin
	if not dochange then exit;
	lWaveAmplitude:=strtointdef(edit32.text,0);
   lWaveWaveLength:=strtointdef(edit33.text,0);
   lWavePhase:=strtointdef(edit34.text,0);
   lWaveReflect:=checkbox2.checked;
	if (lWaveAmplitude<>WaveAmplitude) or (lWaveWaveLength<>WaveWaveLength) or
      (lWavePhase<>WavePhase) or (lWaveReflect<>WaveReflect) then begin
		WaveAmplitude:=lWaveAmplitude;
      WaveWaveLength:=lWaveWaveLength;
      WavePhase:=lWavePhase;
      WaveReflect:=lWaveReflect;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// cambio controlli Morph filter
procedure TfPreviews.Edit35Change(Sender: TObject);
var
	lMorphFilter:integer;
   lMorphWinSize:integer;
begin
	if not dochange then exit;
	lMorphFilter:=ListBox2.ItemIndex;
   lMorphWinSize:=StrToIntDef(edit35.text,1);
   if (lMorphFilter<>MorphFilter) or (lMorphWinSize<>MorphWinSize) then begin
      MorphFilter:=lMorphFilter;
      MorphWinSize:=lMorphWinSize;
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

// change rotate track bar
procedure TfPreviews.TrackBarRotateChange(Sender: TObject);
begin
	if not dochange then exit;
   if (TrackBarRotate.Position/100) <> RotationAngle then begin
       RotationAngle := TrackBarRotate.Position/100;
       EditRotate.Text := FloatToStr(RotationAngle);
       if chkLockPreview.checked then begin
          imageen2.Proc.undo;
          ApplyAct(imageen2);
          imageen2.paint;
       end;
    end;
end;

// change rotate edit
procedure TfPreviews.EditRotateChange(Sender: TObject);
var
	r: double;
begin
	if not dochange then exit;
   r:=IEStrToFloatDef(editRotate.text,0);
	if (r <> RotationAngle) then begin
		RotationAngle := r;
		trackbarRotate.position:=trunc(r*100);
		trackbarRotateChange(self);
	end;
end;

// flip hor/ver
procedure TfPreviews.SpeedButtonFlipHorClick(Sender: TObject);
begin
	if not dochange then exit;
   if chkLockPreview.checked then begin
       imageen2.Proc.undo;
       NeedToFlip := true;
       ApplyAct(imageen2);
       imageen2.paint;
    end;
end;

// Clear button (FFT)
procedure TfPreviews.ClearClick(Sender: TObject);
begin
	if not dochange then exit;
   imageen2.Proc.undo;
   ApplyAct(imageen2);
   imageen2.paint;
end;

// Reset (FFT)
procedure TfPreviews.Button7Click(Sender: TObject);
begin
	ImageEnView1.DeSelect;
	CopyOrg;
end;

// FFT progress
procedure TfPreviews.ImageEnProc2Progress(Sender: TObject; per: Integer);
begin
	ProgressBar1.Position:=FFTProgressPos+per;
end;

// FFT gray scale
procedure TfPreviews.CheckBox1Click(Sender: TObject);
begin
	CopyOrg;
end;


// Gamma Change Start
procedure TfPreviews.UpdatePreview;
begin
  if chkLockPreview.checked then
    begin
      imageen2.Proc.undo;
      ApplyAct(imageen2);
      imageen2.paint;
    end;
end;

// Gamma Change Start
procedure TfPreviews.trkGammaChange(Sender: TObject);
begin
  edtGamma.Text:=FloatToStr(trkGamma.position / 10);
  DrawGammaGraph(trkGamma.position / 10);
  UpdatePreview;
end;

// Gamma Change Start
procedure TfPreviews.cbxGammaClick(Sender: TObject);
begin
  if not dochange then exit;
  DrawGammaGraph(trkGamma.position / 10);
  UpdatePreview;
end;

procedure TfPreviews.DrawGammaGraph(g:double);
var
   c,y,x,ww,hh: integer;
begin
	ww:=ImageEnView2.Width;
   hh:=ImageEnView2.Height;
	ImageEnView2.IEBitmap.Width:=ww;
   ImageEnView2.IEBitmap.Height:=hh;
   ImageEnView2.IEBitmap.Fill(clSilver);
   ImageEnView2.IEBitmap.Canvas.Pen.Color:=clBlack;
	ImageEnView2.IEBitmap.Canvas.Pen.Style:=psSolid;
   ImageEnView2.IEBitmap.Canvas.MoveTo(0,hh);
   for c := 0 to 255 do begin
      y := ilimit(trunc((255-blimit(Round(iepower(c/255, 1/g)*255)))/255*hh),0,hh-1);
      x := ilimit(trunc(c/255*ww),0,ww-1);
		ImageEnView2.IEBitmap.Canvas.LineTo(x,y);
   end;
   ImageEnView2.Update;
end;

// Sharpen Amplitude or Sharpen window size
procedure TfPreviews.TrackBar4Change(Sender: TObject);
begin
	if not dochange then exit;
	if (Sharpen<>trackbar4.position) or (SharpenSize<>StrToIntdef(Edit37.Text,2)) then begin
   	Sharpen:=trackbar4.position;
      edit36.text:=inttostr(Sharpen);
      SharpenSize:=StrToIntDef(Edit37.Text,2);
      if chkLockPreview.checked then begin
			imageen2.Proc.undo;
	      ApplyAct(imageen2);
	      imageen2.paint;
      end;
   end;
end;

procedure TfPreviews.Edit36Change(Sender: TObject);
begin
	if not dochange then exit;
   if Sharpen<>StrToIntDef(Edit36.Text,1) then begin
		trackbar4.position:=StrToIntDef(Edit36.Text,1);
      trackbar4change(self);
   end;
end;


{$else} // {$ifdef IEINCLUDEDIALOGIP}

interface
implementation

{$endif}

























end.
