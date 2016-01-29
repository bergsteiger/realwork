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

unit imageenproc;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses SysUtils, iekdef, Types, QGraphics, Classes, QForms, QExtCtrls,
	 ieview, hyiedefs, hyieutils, iefft, l3Base;
(*$endif*)
(*$ifdef IEDELPHI*)
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ieview,
  ExtCtrls, hyiedefs, hyieutils, iefft, l3Base;
(*$endif*)

type

   // 3x3 filter
   TGraphFilter = record
      Values:array [0..2,0..2] of integer;
      Divisor:integer;
   end;

   // filter exception
   EFilterInvalid = class(Exception);

   TFlipDir = (fdHorizontal, fdVertical);

   // channels and gray level histogram
   THistogramItem = record
       R: DWord;
       G: DWord;
       B: DWord;
       Gray: DWord;
   end;
   THistogram = array [0..255] of THistogramItem;
   PHistogram = ^THistogram;

   TPreviewEffects = set of (peAll, peContrast, peHSV, peHSL, peRGB, peUserFilt, peEqualize,
                             peBumpMap, peLens, peWave, peMorph, peRotate, peFFT, peGamma, peSharpen);

   // preview properties
   TPRPreviewsParamsItems=(prppDefaultLockPreview);
   TPRPreviewsParams=set of TPRPreviewsParamsItems;

   TIEFilterPresets=(fpNone, fpBlur, fpEdge, fpEmboss, fpHighPass1, fpHighPass2,
                   fpHighPass3, LowPass1, LowPass2);

   TIEPreviewEvent = procedure(Sender: TObject; PreviewForm:TForm) of object;

   TIEChannels=set of (iecRed,iecGreen,iecBlue);

   TIEUndoSource=(ieuUnknown, ieuImage, ieuSelection);

   TIEAntialiasMode=(ierFast, ierBilinear, ierBicubic);

   TIEMedFilType = (mfMedianFilter, mfSharpen, mfEdgeExtract);

   TImageEnProc = class(TComponent)
   private
     { Private declarations }
     fAutoUndo:boolean;
     fImageEnView:TIEView;			// refers to TIEView (fbitmap=fimageenview.bitmap)
     fImageEnViewIdx:integer;  // bitmap change index (-1=nothing)
     fBackground:TColor;			// valid only if fImageEnview=nil
     fMsgLanguage:TMsgLanguage;
     fPreviewsParams:TPRPreviewsParams;
     fPreviewFont:TFont;
     fOnPreview:TIEPreviewEvent;
     fTImage:TImage;	// riferimento a TImage
     fFiltersInitialDir:string;
     fIEBitmap:TIEBitmap;       // encapsulates fBitmap if SetBitmap, SetAttachedBitmap, SetAttachedImageEn, SetTImage are called
     fIEBitmapCreated:boolean;  // true is fIEBitmap is created by TImageEnIO
     procedure SetAttachedBitmap(atBitmap:TBitmap);
     procedure SetAttachedImageEn(atImageEn:TIEView);
     function GetReBackground:TColor;
     procedure SetReBackground(v:TColor);
     procedure SetPreviewFont(f:TFont);
     procedure SetTImage(v:TImage);
     procedure SetPRPreviewParams(v:TPRPreviewsParams);
     function GetPRPreviewParams:TPRPreviewsParams;
     function GetCanUndo: boolean;
     function GetUndoCount:integer;
     procedure SetUndoCaptions(index:integer; const Value:string);
     function GetUndoCaptions(index:integer):string;
     function GetRedoCount:integer;
     function GetRedoCaptions(index:integer):string;
     procedure SetUndoLimit(v:integer);
   protected
     { Protected declarations }
     fUndoList:TList;	// list of undo objects
     fUndoLocation:TIELocation;
     fUndoLimit:integer;
     fUndoCaptions:TStringList;
     fRedoList:TList;	// list of redo objects
     fRedoCaptions:TStringList;
     fBitmap:TBitmap;				// working bitmap (if fImageEnView is <>nil then fBitmap=FImageEnView.bitmap)
     fOnProgress:TIEProgressEvent;
     procedure Notification(AComponent: TComponent; Operation: TOperation); override;
     procedure OnBitmapChange(Sender:TObject; destroying:boolean);
     procedure SetIEBitmap(bmp:TIEBitmap);
     procedure SetAttachedIEBitmap(bmp:TIEBitmap);
     function MakeConsistentBitmap(allowedFormats:TIEPixelFormatSet):boolean;
   public
     { Public declarations }
     constructor Create(Owner: TComponent); override;
     destructor Destroy; override;
     property AttachedBitmap:TBitmap read fBitmap write SetAttachedBitmap;
     property AttachedIEBitmap:TIEBitmap read fIEBitmap write SetAttachedIEBitmap;
     procedure Update;
     property FiltersInitialDir:string read fFiltersInitialDir write fFiltersInitialDir;
     // Image processing
     function BeginImageProcessing(allowedFormats:TIEPixelFormatSet; var x1,y1,x2,y2:integer; const OpName:string; var ProcBitmap:TIEBitmap; var mask:TIEMask):boolean;
     procedure EndImageProcessing(ProcBitmap:TIEBitmap; mask:TIEMask);
     procedure Negative;
     procedure HSLvar(oHue,oSat,oLum:integer);
     procedure HSVvar(oHue,oSat,oVal:integer);
     procedure IntensityRGBall(r,g,b:integer);
     procedure Contrast(vv:integer);
     procedure ApplyFilter(filter:TGraphFilter);
     procedure ApplyFilterPreset(filter:TIEFilterPresets);
     procedure ConvertToGray;
     procedure CastColorRange(BeginColor,EndColor,CastColor:TRGB);
     procedure Flip(dir:TFlipDir);
     {$ifdef IESUPPORTDEFPARAMS}
     procedure ImageResize(newWidth, newHeight:integer; HorizAlign:TIEHAlign=iehLeft; VertAlign:TIEVAlign=ievTop);
     procedure Resample(NewWidth,NewHeight:integer; FilterType:TResampleFilter=rfNone);
     procedure Rotate(fangle:double; antialias:boolean=true; AntialiasMode:TIEAntialiasMode=ierFast; BackgroundColor:TColor=-1);
     procedure ConvertToBWThreshold(Threshold:integer=-1);
     procedure EdgeDetect_ShenCastan(Ratio:double=0.99; Smooth:double=0.9; WindowSize:integer=7; ThinFactor:integer=0; DoHysteresis:boolean=true);
     procedure RemoveIsolatedPixels(NoiseColor:integer=1; PixelsCount:integer=2);
     procedure RemoveNoise(Iterations:integer=2; InvertImage:boolean=false);
     procedure PaintMark(Frequency:integer; Color:TRGB);
     procedure GammaCorrect(Gamma:double; Channel:TIEChannels=[iecRed,iecGreen,iecBlue]);
     procedure PaintPenMarker(x,y:integer; Width:integer=20; Color:TColor=clYellow; BackgroundColor:TColor=clWhite; Tolerance:integer=10);
     procedure ConvertToPalette(NumColors:integer; Palette:pointer; DitherMethod:TIEDitherMethod=ieOrdered);
     procedure ConvertTo(NumColors:integer; DitherMethod:TIEDitherMethod=ieOrdered);
        {$ifdef IEINCLUDEDIALOGIP}
     function DoPreviews(pe:TPreviewEffects=[peAll]):boolean;
        {$endif}
     procedure AddSoftShadow(radius:double; OffSetX:integer; OffSetY:integer; AdaptSize:boolean=true; ShadowColor:TColor=clBlack);
     procedure MedianFilter(WindowX:integer=5; WindowY:integer=5; Brightness:integer=50; Contrast:integer=50; Multiplier:integer=1; Threshold:integer=50; MedianOp:TIEMedFilType=mfMedianFilter);
     procedure WallisFilter(WinWidth:integer=2; WinHeight:integer=2; Mean:integer=50; StDev:integer=50; InGain:integer=50; Edge:integer=10; Limit:integer=50; Thresholding:boolean=false);
     procedure Sharpen(Intensity:integer;Neighbourhood:integer=4);
     {$else}	// not IESUPPORTEDDEFPARAMS
     procedure ImageResize(newWidth, newHeight:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
     procedure Resample(NewWidth,NewHeight:integer; FilterType:TResampleFilter);
     procedure Rotate(fangle:double; antialias:boolean; AntialiasMode:TIEAntialiasMode; BackgroundColor:TColor);
     procedure ConvertToBWThreshold(Threshold:integer);
     procedure EdgeDetect_ShenCastan(Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean);
     procedure RemoveIsolatedPixels(NoiseColor:integer; PixelsCount:integer);
     procedure RemoveNoise(Iterations:integer; InvertImage:boolean);
     procedure PaintMark(Frequency:integer; Color:TRGB);
     procedure GammaCorrect(Gamma:double; Channel:TIEChannels);
     procedure PaintPenMarker(x,y:integer; Width:integer; Color:TColor; BackgroundColor:TColor; Tolerance:integer);
     procedure ConvertToPalette(NumColors:integer; Palette:pointer; DitherMethod:TIEDitherMethod);
     procedure ConvertTo(NumColors:integer; DitherMethod:TIEDitherMethod);
        {$ifdef IEINCLUDEDIALOGIP}
     function DoPreviews(pe:TPreviewEffects):boolean;
        {$endif}
     procedure AddSoftShadow(radius:double; OffSetX:integer; OffSetY:integer; AdaptSize:boolean; ShadowColor:TColor);
     procedure MedianFilter(WindowX,WindowY:integer; Brightness,Contrast,Multiplier,Threshold:integer; MedianOp:TIEMedFilType);
     procedure WallisFilter(WinWidth,WinHeight:integer; Mean,StDev,InGain,Edge,Limit:integer; Thresholding:boolean);
     procedure Sharpen(Intensity:integer;Neighbourhood:integer);
     {$endif}	// IESUPPORTEDDEFPARAMS
     procedure Clear;
     procedure ClearSel;
     {$ifdef IEDELPHI}
     procedure Merge(DBitmap:TBitmap; pcf:integer);
     {$endif}
     procedure MergeIEBitmap(DBitmap:TIEBitmap; pcf:integer);
     procedure Threshold(DownLimit,UpLimit, DownVal,UpVal:TRGB);
     procedure HistEqualize(LoThresh,HiThresh:TRGB);
     procedure HistAutoEqualize;
     procedure CropSel;
     procedure BumpMapping(LightX,LightY,LampX,LampY,pcf:integer; Color:TRGB);
     procedure Lens(cx,cy,Width,Height:integer; Refraction:double);
     procedure Wave(amplitude, wavelength, phase:integer; reflective:boolean);
     procedure ConvertToBWOrdered;
     procedure ConvertTo24Bit;
     function WriteHiddenText(text:string):integer;
     function WriteHiddenData(data:PAnsiChar; count:integer):integer;
     procedure Maximum(WindowSize:integer);
     procedure Minimum(WindowSize:integer);
     procedure Opening(WindowSize:integer);
     procedure Closing(WindowSize:integer);
     procedure Fill(FillColor:TRGB);
     procedure Blur(radius:double);
     procedure SetTransparentColors(MinColor,MaxColor:TRGB; Alpha:integer);
     procedure ResampleTo(Target:TIEBitmap; TargetWidth,TargetHeight:integer; FilterType:TResampleFilter);
     // Image analysis
     function CalcOrientation:integer;
     procedure GetHistogram(var Hist:THistogram);
     procedure CalcImagePalette(var Palette:array of TRGB; MaxCol:integer);
     function CalcImageNumColors:integer;
     function GetHSVChannel(ch:integer):TIEBitmap;
     procedure GetHSVChannelAll(BitmapH,BitmapS,BitmapV:TIEBitmap);
     function GetRGBChannel(ch:integer):TIEBitmap;
     procedure GetRGBChannelAll(BitmapR,BitmapG,BitmapB:TIEBitmap);
     function ReadHiddenText:string;
     function ReadHiddenData(data:PAnsiChar; maxlen:integer):integer;
     function GetHiddenDataSpace:integer;
     function FTCreateImage(ImageType:TIEFtImageType; NewWidth,NewHeight:integer):TIEFtImage;
     procedure FTConvertFrom(ft:TIEftImage);
     procedure FTDisplayFrom(ft:TIEftImage);
     {$ifdef IESUPPORTDEFPARAMS}
     function SkewDetection(ResampleWidth:integer=0; AngleRange:integer=30; Precision:double=0.1; EdgeDetect:boolean=false):double;
     {$else}
     function SkewDetection(ResampleWidth:integer; AngleRange:integer; Precision:double; EdgeDetect:boolean):double;
     {$endif}
     function SkewDetectionFine(StartingAngle:double; resolution:double; range:integer; maxQuality:boolean):double;
     procedure CalcDensityHistogram(VertHist,HorizHist:pointer; norm_vert,norm_horiz:integer);
     function ComputeImageEquality(SecondImage:TIEBitmap;var psnr_min,psnr_max:double; var mse_min,mse_max:double; var rmse_min,rmse_max:double; var pae_min,pae_max:double; var mae_min,mae_max:double):boolean;
     function CompareWith(SecondImage:TIEBitmap; DiffBitmap:TIEBitmap):double;
     function GetDominantColor(var Color:TRGB):integer;
     // Undo
     {$ifdef IESUPPORTDEFPARAMS}
     procedure SaveUndo(Source:TIEUndoSource=ieuImage); virtual;
     procedure SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource=ieuImage);
     {$else}
     procedure SaveUndo(Source:TIEUndoSource); virtual;
     procedure SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource);
     {$endif}
     procedure ClearUndo;
     procedure ClearUndoAt(Position:integer);
     procedure ClearAllUndo;
     procedure Undo; virtual;
     procedure UndoAt(Position:integer); virtual;
     property CanUndo:boolean read GetCanUndo;
     property UndoLocation:TIELocation read fUndoLocation write fUndoLocation;
     property UndoCount:integer read GetUndoCount;
     property UndoCaptions[index:integer]:string read GetUndoCaptions write SetUndoCaptions;
     function UndoPeekAt(Position:integer):TIEUndoSource;
     // Redo
     {$ifdef IESUPPORTDEFPARAMS}
     procedure SaveRedo(Source:TIEUndoSource=ieuImage); virtual;
     procedure SaveRedoCaptioned(const Caption:string; Source:TIEUndoSource=ieuImage);
     {$else}
     procedure SaveRedo(Source:TIEUndoSource); virtual;
     procedure SaveRedoCaptioned(const Caption:string; Source:TIEUndoSource);
     {$endif}
     property RedoCaptions[index:integer]:string read GetRedoCaptions;
     property RedoCount:integer read GetRedoCount;
     procedure ClearAllRedo;
     procedure ClearRedo; virtual;
     procedure Redo; virtual;
     procedure RedoAt(Position:integer); virtual;
     function RedoPeekAt(Position:integer):TIEUndoSource;
     // copy/cut and paste
     procedure SelCopyToClip;
     procedure CopyToClipboard;
     procedure SelPasteFromClipStretch;
     procedure PasteFromClipboard;
     procedure PointPasteFromClip(x1,y1:integer);
     procedure SelCutToClip;
     // selection area
     function GetReSel(var fsX1,fsY1,fsX2,fsY2:integer; var PolySel:PPointArray; var PolySelCount:integer; var mask:TIEMask):boolean; virtual;
   published
     { Published declarations }
     property AttachedImageEn:TIEView read fImageEnView write SetAttachedImageEn;
     property AutoUndo:boolean read fAutoUndo write fAutoUndo default true;
     property Background:TColor read GetReBackground write SetReBackground default clBlack;
     property OnProgress:TIEProgressEvent read fOnProgress write fOnProgress;
     property MsgLanguage:TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;
     property PreviewsParams:TPRPreviewsParams read GetPRPreviewParams write SetPRPreviewParams default [];
     property PreviewFont:TFont read fPreviewFont write SetPreviewFont;
     property AttachedTImage:TImage read fTImage write SetTImage;
     property OnPreview:TIEPreviewEvent read fOnPreview write fOnPreview;
     property UndoLimit:integer read fUndoLimit write SetUndoLimit default 1;
   end;

   TIETransitionType=(iettNone,
                      iettCrossDissolve, iettFadeOut, iettFadeIn, iettFadeOutIn,
   						 iettLeftRight1, iettLeftRight2,
                      iettRightLeft1, iettRightLeft2,
                      iettUpDown1, iettUpDown2,
                      iettDownUp1, iettDownUp2,
                      iettFromUpLeft, iettFromUpRight, iettFromBottomLeft, iettFromBottomRight,
                      iettMoveLeftRight1, iettMoveLeftRight2,
                      iettMoveRightLeft1, iettMoveRightLeft2,
                      iettMoveUpDown1, iettMoveUpDown2,
                      iettMoveDownUp1, iettMoveDownUp2,
                      iettRandomPoints, iettRandomBoxes,
                      iettCenter1, iettCenter2,
                      iettCenterZoom1,iettCenterZoom2
   );

   // trnasiction effects class
   TIETransitionEffects=class(Tl3Base)
		private
      	fSourceShot, fTargetShot, fActualView:TBitmap;
         fSourceShotLines,fTargetShotLines,fActualViewLines:PPointerArray;
         fWidth,fHeight:integer;
         fRunning:boolean;
         fOwner:TIEView;
         fTimer:TTimer;
         fStep:integer;
         fAccum1:integer;
         fTransition:TIETransitionType;
         fDuration:integer;	// time in millisecs
         {$ifdef IEDELPHI}
         fStartTick:dword;
         {$endif}
         fUpdateOnStop:boolean;
      protected
         fFrames:integer;	// debug counter
      	procedure TimerEvent(Sender:TObject);
         //
         procedure CrossDissolve(Step:integer);
         procedure FadeOut(Step:integer);
         procedure FadeIn(Step:integer);
         procedure FadeOutIn(Step:integer);
         procedure LeftRight1(Step:integer);
         procedure LeftRight2(Step:integer);
         procedure RightLeft1(Step:integer);
         procedure RightLeft2(Step:integer);
         procedure UpDown1(Step:integer);
         procedure UpDown2(Step:integer);
         procedure DownUp1(Step:integer);
         procedure DownUp2(Step:integer);
         procedure MoveLeftRight1(Step:integer);
         procedure MoveLeftRight2(Step:integer);
         procedure MoveRightLeft1(Step:integer);
         procedure MoveRightLeft2(Step:integer);
         procedure MoveUpDown1(Step:integer);
         procedure MoveUpDown2(Step:integer);
         procedure MoveDownUp1(Step:integer);
         procedure MoveDownUp2(Step:integer);
         procedure RandomPoints(Step:integer);
         procedure FromUpLeft(Step:integer);
         procedure FromUpRight(Step:integer);
         procedure FromBottomLeft(Step:integer);
         procedure FromBottomRight(Step:integer);
         procedure RandomBoxes(Step:integer);
         procedure Center1(Step:integer);
         procedure Center2(Step:integer);
         procedure CenterZoom1(Step:integer);
         procedure CenterZoom2(Step:integer);
      public
         constructor Create(Owner:TIEView);
         reintroduce;
         procedure Cleanup; override;
         property SourceShot:TBitmap read fSourceShot;
         property TargetShot:TBitmap read fTargetShot;
         property Running:boolean read fRunning;
         procedure Run(UpdateOnStop:boolean);
         procedure Stop;
         property Transition:TIETransitionType read fTransition write fTransition;
         procedure SetSizes(Width,Height:integer);
         property Duration:integer read fDuration write fDuration;
   end;

const
	ppeColorAdjust = [peContrast,peHSV,peHSL,peRGB,peEqualize,peFFT,peGamma,peSharpen];
   ppeEffects = [peUserFilt,peBumpMap,peLens,peWave,peMorph,peRotate];

	IEFiltPres: array [0..8] of TGraphFilter = (
   									(Values:( (0,0,0),	// None
                                			 (0,1,0),
                                			 (0,0,0) ); Divisor:0),
   									(Values:( (1,1,1),	// blur 1
                                			 (1,1,1),
                                			 (1,1,1) ); Divisor:9),
                              (Values:( (1,1,1),     // edge
                              			 (1,-8,1),
                               			 (1,1,1) ); Divisor:1),
                              (Values:( (-1,0,1),	   // emboss
                                			 (-1,1,1),
                                        (-1,0,1) ); Divisor:1),
                              (Values:( (0,-1,0),    // high pass 1
                                			 (-1,5,-1),
                                			 (0,-1,0) ); Divisor:1),
                              (Values:( (-1,-1,-1),  // high pass 2
                               			 (-1,9,-1),
                                			 (-1,-1,-1) ); Divisor:1),
                              (Values:( (1,-2,1),  // high pass 3
                                			 (-2,5,-2),
                                			 (1,-2,1) ); Divisor:1),
                              (Values:( (1,1,1),  // Low pass 1
                                			 (1,1,1),
                                			 (1,1,1) ); Divisor:10 ),
                              (Values:( (1,2,1),  // Low pass 2
                                			 (2,4,2),
                                			 (1,2,1) ); Divisor:16)
                              );


	BWORDERPATTERN:array [0..7,0..7] of integer= (
        ( 0, 32,  8, 40,  2, 34, 10, 42),
        (48, 16, 56, 24, 50, 18, 58, 26),
        (12, 44,  4, 36, 14, 46,  6, 38),
        (60, 28, 52, 20, 62, 30, 54, 22),
        ( 3, 35, 11, 43,  1, 33,  9, 41),
        (51, 19, 59, 27, 49, 17, 57, 25),
        (15, 47,  7, 39, 13, 45,  5, 37),
        (63, 31, 55, 23, 61, 29, 53, 21) );

procedure _GetMediaContrastRGB(bitmap:TIEBitmap; var mR,mG,mB:integer);
procedure _HSLvar(bitmap:TIEBitmap;oHue,oSat,oLum:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _HSVvar(bitmap:TIEBitmap;oHue,oSat,oVal:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IntensityRGBall(bitmap:TIEBitmap;r,g,b:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ContrastRGB(bitmap:TIEBitmap;vv:integer;mR,mG,mB:integer;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ApplyFilter(bitmap:TIEBitmap;filter:TGraphFilter; fSelx1,fSely1,fSelx2,fSely2:integer; var Progress:TProgressRec);
procedure _CastColorRange(bitmap:TIEBitmap;BeginColor,EndColor,CastColor:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _Rot90o(bakbmp:TBitmap; newbitmap:TBitmap);
procedure _Rot90oEx(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
procedure _Rot90oEx8(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
procedure _Rot90(bakbmp:TBitmap; newbitmap:TBitmap);
procedure _Rot90Ex(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
procedure _Rot90Ex8(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
procedure _Negative(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _Sharpen(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; Intensity:integer; Neighbourhood:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _SetTransparentColors(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; MinColor,MaxColor:TRGB; alpha:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ConvertToGray(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _Merge(bitmap:TIEBitmap; DBitmap:TIEBitmap; pcf:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _Threshold(bitmap:TIEBitmap; DownLimit,UpLimit, DownVal,UpVal:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _HistEqualize(bitmap:TIEBitmap; LoThresh,HiThresh:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _GetHistogram(Bitmap:TIEBitmap; var Hist:THistogram;fSelx1,fSely1,fSelx2,fSely2:integer);
procedure _HistAutoEqualize(bitmap:TIEBitmap; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
//procedure _Resample(Src, Dst: TBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleEx(Src, Dst: TIEBaseBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
function _GetImageNumColors(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer):integer;
//procedure _ConvertTo(Bitmap:TBitmap; NumColors:integer; OutPalette: PRGBROW; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ConvertToEx(Bitmap:TIEBitmap; NumColors:integer; OutPalette: PRGBROW; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _Negative1Bit(Bitmap:TBitmap);
procedure _Negative1BitEx(Bitmap:TIEBitmap);
function _GetHSVChannel(bitmap:TIEBitmap; ch:integer; fOnProgress:TIEProgressEvent; Sender:TObject):TIEBitmap;
procedure _GetHSVChannelAll(bitmap:TIEBitmap; BitmapH,BitmapS,BitmapV:TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
function _GetRGBChannel(bitmap:TIEBitmap; ch:integer; fOnProgress:TIEProgressEvent; Sender:TObject):TIEBitmap;
procedure _GetRGBChannelAll(bitmap:TIEBitmap; BitmapR,BitmapG,BitmapB:TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
function _RGBToGray(const rgb:TRGB):integer;
function _GetSimilColor(const ColorMap:array of TRGB; nc:integer; Col:TRGB):integer;
procedure _RGB2BGR(var ColorMap:array of TRGB; nc:integer);
procedure _BGR2RGB(buff:PRGB; width:integer);
procedure _CopyBits(Dest,Source:pbyte; DestStart,SourceStart,Len:integer; SourceRowLen:integer);
procedure _CopyBitmapRect(Source,Dest:TBitmap; x1,y1,x2,y2:integer);
//function _ConvertTo1bit(Bitmap:TBitmap; var BackCol,ForeCol:TRGB):TBitmap;
function _ConvertTo1bitEx(Bitmap:TIEBitmap; var BackCol,ForeCol:TRGB):TIEBitmap;
procedure _Conv1to24(var SrcBitmap,DstBitmap:TBitmap; var Progress:TProgressRec);
procedure _CopyPolygonBitmap(Dest:TBitmap; Source:TBitmap; x1,y1:integer; SelPoly:PPointArray; SelPolyCount:integer);
function _BitmapCompareX(Bitmap1,Bitmap2:TBitmap):boolean;
function _BitmapCompareXEx(Bitmap1,Bitmap2:TIEBitmap):boolean;
//procedure _ClearSel(fBitmap:TBitmap; SelPoly:PPointArray; SelPolyCount:integer; Background:TColor);
//procedure _ClearSelMask(fBitmap:TBitmap; mask:TIEMask; Background:TColor);
procedure _ClearSelMaskEx(fIEBitmap:TIEBitmap; mask:TIEMask; Background:TColor);
//procedure _CopyBitmapPoly(Source:TBitmap; Dest:TBitmap; sx1,sy1,sx2,sy2:integer; SelPoly:PPointArray; SelPolyCount:integer);
procedure _ConvertToBWOrdered(bitmap:TIEBitmap; var Progress:TProgressRec);
procedure _ConvertToBWThreshold(bitmap:TIEBitmap; Threshold:integer; var Progress:TProgressRec);
procedure _ConvertToBWThresholdEx(origbitmap,destbitmap:TIEBitmap; Threshold:integer; var Progress:TProgressRec);
procedure _BumpMapping(Bitmap:TIEBitmap; LightX,LightY,LAmpX,LAmpY,pcf:integer; Color:TRGB; fselx1,fsely1,fselx2,fsely2:integer; var Progress:TProgressRec);
procedure _lens(Bitmap:TIEBitmap; xx,yy:integer; width,height:integer; refraction:double; var Progress:TProgressRec);
procedure _rotate1bit(fBitmap:TBitmap; angle:double; background:integer; var Progress:TProgressRec);
procedure _rotate1bitEx(fBitmap:TIEBitmap; angle:double; background:integer; var Progress:TProgressRec);
procedure _rotate8bit(fBitmap:TIEBitmap; angle:double; background:integer);
function _GetPixelbw(row:pbyte; pix:integer):integer;
procedure _SetPixelbw(row:pbyte; pix:integer; vv:integer);
procedure _wave(Bitmap:TIEBitmap; amplitude, wavelength, phase:integer; reflective:boolean; var Progress:TProgressRec);
(*$ifdef IEDELPHI*)
function _CreateWinPalette(var ColorMap:array of TRGB; NCol:integer):HPalette;
function _CopyDIB2Bitmap(hbi:THandle; fBitmap:TBitmap; xbits:pbyte; unlck:boolean):integer;
function _CopyDIB2BitmapEx(hbi:THandle; fBitmap:TIEBaseBitmap; xbits:pbyte; unlck:boolean):integer;
function _CopyBitmaptoDIB(fBitmap:TBitmap; x1,y1,x2,y2:integer):THandle;
function _CopyBitmaptoDIBEx(fBitmap:TIEBaseBitmap; x1,y1,x2,y2:integer):THandle;
//function _IECopyDIB2Bitmap2(hbi:THandle; fBitmap:TBitmap; xbits:pbyte; unlck:boolean):integer;
function _IECopyDIB2Bitmap2Ex(hbi:THandle; fBitmap:TIEDibBitmap; xbits:pbyte; unlck:boolean):integer;
(*$endif*)
procedure _CopyIYU1ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyIYU2ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyUYVYToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyYUY2ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyYVYUToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyY41PToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyY211ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyCLJRToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyYVU9ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyYV12ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyI420ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
procedure _CopyPolygonToPoint(Source:TBitmap; Polygon:PPointArray; PolygonLen:integer; Dest:TBitmap; const Position:TPoint);
procedure _CopyPointToPolygon(Source:TBitmap; Polygon:PPointArray; PolygonLen:integer; Dest:TBitmap; const Position:TPoint);
procedure _CopyBGR_RGB(dst:PRGB; src:PRGB; width:integer);
procedure _MorphFilter(bitmap:TIEBitmap; WindowSize:integer; op:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
function _MakeMagicWandPoints(fBitmap:TIEBitmap; x,y:integer; maxfilter:boolean; tolerance:integer; var pcount:integer):PPointArray;
procedure _MakeMagicWandPointsEx(fBitmap:TIEBitmap; x,y:integer; maxfilter:boolean; tolerance:integer; mask:TIEMask);
procedure _MakeMagicWandPointsEx2(fBitmap:TIEBitmap; x,y:integer; tolerance:integer; mask:TIEMask);
procedure _IEBmpStretch(origBmp, destBmp:TBitmap);
procedure _IEBmpStretchEx(origBmp, destBmp:TIEBaseBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
function _ConvertXBitsToYBits(var Input,Output:TBYTEROW;Xbits,Ybits,Width:Word; Palette:array of TRGB; Quantizer:TObject):integer;
//procedure _SubResample1bitFiltered(src:TBitmap; sx1,sy1,sx2,sy2:integer; dst:TBitmap);
procedure _SubResample1bitFilteredEx(src:TIEBaseBitmap; sx1,sy1,sx2,sy2:integer; dst:TIEBitmap);
//function _SubResample1bitFilteredDIB(src:pbyte; sxx,syy:integer; sx1,sy1,sx2,sy2:integer; dxx,dyy:integer):pbyte;
procedure _IEResampleIEBitmap(source,dest:TIEBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleAlphaEx(Src, Dst: TIEBitmap; FilterType:TResampleFilter);
//procedure _Resample1bit(Src, Dst: TBitmap; FilterType:TResampleFilter);
procedure _Resample1bitEx(Src, Dst: TIEBitmap; FilterType:TResampleFilter);
function _iehough(image:TIEBitmap; var Progress:TProgressRec; anglerange:integer; Precision:Double):double;
procedure _Fill(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; FillColor:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
//procedure _ResampleLinear(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleLinearEx(Src, Dst: TIEBaseBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
//procedure _ResampleLinear1Bit(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleLinear1BitEx(Src, Dst: TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleLinearAlpha(Src, Dst: TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IEEdgeDetect_ShenCastan(SrcBitmap,DstBitmap:TIEBitmap; Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean; var Progress:TProgressRec);
procedure _CalcDensityHistogram(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject; VertHist,HorizHist:pintegerarray; norm_vert,norm_horiz:integer);
procedure _FlipEx(bmp:TIEBitmap; dir:TFlipDir);
procedure _RotateEx(fBitmap:TIEBitmap; fangle:double; antialias:boolean; Background:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _RotateEx8(fBitmap:TIEBitmap; fangle:double; antialias:boolean; Background:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IERemoveIsolatedPixels1Bit(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; NoiseColor:integer; IsolationMax:integer);
procedure _kf_kfill(bitmap:TIEBitmap; RetainConnectivity:boolean; RetainEndpoints:boolean; MaxIterations:integer; WindowSize:integer; InvertImage:boolean);
procedure _IEComputeDiff(x,y:TIEBitmap; var psnr_min,psnr_max:double; var mse_min,mse_max:double;
												var rmse_min,rmse_max:double; var pae_min,pae_max:double;
                                    var mae_min,mae_max:double; var equal:boolean);
procedure _IEGammaCorrect(ABitmap: TIEBitmap; AGamma: double; AChannel: TIEChannels; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _NegativeBuffer(buf:pbyte; WidthBytes:integer);
procedure _ConvRow1To24(spx,dpx:pbyte; Width:integer);
procedure _IEGBlur(Bitmap: TIEBitmap; radius: double; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IEGBlurRect8(Bitmap: TIEBitmap; x1,y1,x2,y2:integer; radius: double);
procedure _IEAddSoftShadow(bitmap:TIEBitmap; radius:double; OffSetX:integer; OffSetY:integer; AdaptBitmap:boolean; ShadowColor:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
function _IEAddSoftShadowRect(bitmap:TIEBitmap; radius:double; OffSetX:integer; OffSetY:integer; x1,y1,x2,y2:integer):integer;
procedure _IEQRotate(src: TIEBitmap; angle: double; Background: TColor; Filter:TIEAntialiasMode; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IEQRotate8(src: TIEBitmap; angle: double; Background:integer; Filter:TIEAntialiasMode);
procedure _IEQResample(SrcImg,DstImg : TIEBaseBitmap; filter:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IEMedianFilter(image:TIEBitmap; WindowX,WindowY:integer; Brightness,Contrast,Multiplier,Threshold:integer; MedianOp:TIEMedFilType; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _IEWallisFilter(image:TIEBitmap; WinWidth,WinHeight:integer; Mean,StDev,InGain,Edge,Limit:integer; Thresholding:boolean; fOnProgress:TIEProgressEvent; Sender:TObject);
function _IECalcVertOrientationFitness(bitmap:TIEBitmap):integer;
procedure _IEAddSoftShadowRect2(bitmap:TIEBitmap; size:integer; Intensity:double; OffsetX,OffsetY:integer; rx1,ry1,rx2,ry2:integer);
procedure _IESetAlpha0Color(bitmap:TIEBitmap; cl:TRGB);
procedure _Conv1to24Ex(var SrcBitmap,DstBitmap:TIEBitmap; var Progress:TProgressRec);

function IECloneBitmap(Source:TBitmap):TBitmap;
procedure IECopyBitmap(Source,Dest:TBitmap);
function IECompareImages(image1,image2:TIEBitmap; diffmap:TIEBitmap):double;

function dmin(v1,v2:double):double;
function dmax(v1,v2:double):double;
function imin(v1,v2:integer):integer;
function imax(v1,v2:integer):integer;
function ilimit(vv,min,max:integer):integer;
function blimit(vv:integer):integer;
procedure iswap(var B1, B2: LongInt); assembler;
procedure dwswap(var B1, B2: dword); assembler;
procedure bswap(var B1, B2: Byte); assembler;
procedure iedswap(var d1,d2:double);
procedure OrdCor(var x1,y1,x2,y2:integer);
function TRGB2TColor(rgb:TRGB):TColor;
function RGB2TColor(r,g,b:integer):TColor;
function TColor2TRGB(cl:TColor):TRGB;
procedure RGB2HSL(px:TRGB; var Hue,Sat,Lum:double);
procedure HSL2RGB(var px:TRGB; iHue,iSat,iLum:double);
procedure HSV2RGB(var px:TRGB; H,S,V:integer);
procedure RGB2HSV(RGB:TRGB; var h,s,v:integer);
function CreateRGB(r,g,b:byte):TRGB;
function EqualRGB(rgb1,rgb2:TRGB):boolean;
function LoadFilterFromFile(const nf:string):TGraphFilter;
procedure SaveFilterToFile(const nf:string; const filt:TGraphFilter);
procedure YUV2RGB(y,u,v:integer; var RGB:TRGB);
function IECeil(X: Extended): Integer;

var
	C1TO24:array [0..255,0..7] of TRGB;	// to convert 1bit to 24bit

implementation

(*$ifdef IEDELPHI*)
uses Previews, clipbrd, NeurQuant,ImageEnView;
(*$endif*)
(*$ifdef IEKYLIX*)
uses neurquant,imageenview;
(*$endif*)

{$R-}

function IECeil(X: Extended): Integer;
begin
	Result := Trunc(X);
   if Frac(X) > 0 then
   	Inc(Result);
end;

procedure iedswap(var d1,d2:double);
var
	v:double;
begin
	v:=d1;
   d1:=d2;
   d2:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function Floor(X: Extended): Integer;
begin
	Result := Trunc(X);
  	if Frac(X) < 0 then
   	Dec(Result);
end;

function CreateRGB(r,g,b:byte):TRGB;
begin
	result.r:=r;
   result.g:=g;
   result.b:=b;
end;

/////////////////////////////////////////////////////////////////////////////////////
function _RGBToGray(const rgb:TRGB):integer;
begin
	with rgb do
		//result:=(r*30 + g*59 + b*11) div 100;
      result:=(r*21 + g*71 + b*8) div 100;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TRGB2TColor(rgb:TRGB):TColor;
begin
	with rgb do
		result:= r or (g shl 8) or (b shl 16);
end;

/////////////////////////////////////////////////////////////////////////////////////
function RGB2TColor(r,g,b:integer):TColor;
begin
	result:= r or (g shl 8) or (b shl 16);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TColor2TRGB(cl:TColor):TRGB;
var
	rgb:longint;
begin
	rgb:=colortorgb(cl);
	result.r:=$FF and rgb;
   result.g:=($FF00 and rgb) shr 8;
   result.b:=($FF0000 and rgb) shr 16;
end;

/////////////////////////////////////////////////////////////////////////////////////
function dmin(v1,v2:double):double;
begin
	if v1<v2 then dmin:=v1 else dmin:=v2;
end;
function dmax(v1,v2:double):double;
begin
	if v1>v2 then dmax:=v1 else dmax:=v2;
end;
function IMax(v1, v2: Integer): Integer;
asm
	cmp	edx,eax
	jng	@1
	mov	eax,edx
@1:
end;
function IMin(v1, v2: Integer): Integer;
asm
	cmp	eax,edx
	jng	@1
	mov	eax,edx
@1:
end;

// vv=eax       result=eax
// min=edx
// max=ecx
function ilimit(vv,min,max:integer):integer;
asm
	cmp eax,edx
   jg @1		// vv>min
   mov eax,edx
   ret
@1:
	cmp eax,ecx
   jl @2		// vv<min
   mov eax,ecx
   ret
@2:
end;
(*
begin
	result:= IMin(IMax(vv,min),max);
end;
//*)

// limit 0 between 255
function blimit(vv:integer):integer;
asm
         OR EAX, EAX
         JNS @@plus
         XOR EAX, EAX
         RET

@@plus:
         CMP EAX, 255
         JBE @@END
         MOV EAX, 255
@@END:
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure iswap(var B1, B2: LongInt); assembler;
asm
   push EBX
   mov  ecx, [EAX];
   mov  ebx, [EDX];
   mov  [EDX], ecx
   mov  [EAX], ebx
   pop EBX
end;

procedure dwswap(var B1, B2: dword); assembler;
asm
   push EBX
   mov  ecx, [EAX];
   mov  ebx, [EDX];
   mov  [EDX], ecx
   mov  [EAX], ebx
   pop EBX
end;

/////////////////////////////////////////////////////////////////////////////////////
function EqualRGB(rgb1,rgb2:TRGB):boolean;
begin
	result:=(rgb1.r=rgb2.r) and (rgb1.g=rgb2.g) and (rgb1.b=rgb2.b);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure bswap(var B1, B2: Byte); assembler;
asm
  mov  cl, Byte Ptr [EAX];
  mov  ch, Byte Ptr [EDX];
  mov  Byte Ptr [EDX], cl
  mov  Byte Ptr [EAX], ch
end;

// order two coordinaqtes, putting the first as top-left
procedure OrdCor(var x1,y1,x2,y2:integer);
begin
   if x1>x2 then iswap(x1,x2);
   if y1>y2 then iswap(y1,y2);
end;

function ArcTan2(Y, X: Extended): Extended;
asm
   FLD     Y
   FLD     X
   FPATAN
   FWAIT
end;
function ACos(X: Extended): Extended;
begin
	Result := ArcTan2(Sqrt(1 - X*X), X);
end;
function ASin(X: Extended): Extended;
begin
	Result := ArcTan2(X, Sqrt(1 - X*X))
end;
function Tan(X: Extended): Extended;
asm
   FLD    X
   FPTAN
   FSTP   ST(0)
   FWAIT
end;

function Log2(X: Extended): Extended;
asm
   FLD1
   FLD     X
   FYL2X
   FWAIT
end;

function Log10(X: Extended): Extended;
asm
        FLDLG2
        FLD     X
        FYL2X
        FWAIT
end;


(*
function LogN(Base, X: Extended): Extended;
asm
   FLD1
   FLD     X
   FYL2X
   FLD1
   FLD     Base
   FYL2X
   FDIV
   FWAIT
end;
*)

/////////////////////////////////////////////////////////////////////////////////////
constructor TImageEnProc.Create(Owner: TComponent);
begin
	inherited Create(Owner);
   //
   fIEBitmap:=TIEBitmap.Create;
   fIEBitmapCreated:=true; // we create fIEBitmap
   fImageEnViewIdx:=-1;
   fOnPreview:=nil;
   fBitmap:=nil;
   fImageEnView:=nil;
   fTImage:=nil;
   fPreviewsParams:=[];
   fOnProgress:=nil;
	fUndoList:=TList.Create;
   fRedoList:=TList.Create;
   fUndoLocation:=ieFile;
   fAutoUndo:=true;
   fBackground:=clBlack;
   fMsgLanguage:=msSystem;
   fPreviewFont:=TFont.Create;
   fUndoLimit:=1;
   fUndoCaptions:=TStringList.Create;
   fRedoCaptions:=TStringList.Create;
   fFiltersInitialDir:='';
end;

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEnProc.Destroy;
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
   ClearAllUndo;
   ClearAllRedo;
   FreeAndNil(fUndoList);
   FreeAndNil(fRedoList);
   FreeAndNil(fPreviewFont);
   FreeAndNil(fUndoCaptions);
   FreeAndNil(fRedoCaptions);
   if fIEBitmapCreated then
      FreeAndNil(fIEBitmap);
   //
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Update;
begin
	// remove alpha if attached to fBitmap
   if assigned(fBitmap) then
		fIEBitmap.RemoveAlphaChannel;
   //
   if assigned(fImageEnView) then
     	with fImageEnView do begin
	      Update;
	      ImageChange;
      end
   else if assigned(fBitmap) then
   	fBitmap.modified:=true;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.ClearAllUndo;
begin
   while fUndoList.Count>0 do begin
   	TObject(fUndoList[0]).free;
   	fUndoList.delete(0);
      fUndoCaptions.Delete(0);
   end;
end;

procedure TImageEnProc.ClearAllRedo;
begin
   while fRedoList.Count>0 do begin
   	TObject(fRedoList[0]).free;
   	fRedoList.delete(0);
      fRedoCaptions.Delete(0);
   end;
end;

// remove only last undo
procedure TImageEnProc.ClearUndo;
var
	uc:integer;
begin
   uc:=fUndoList.Count;
   if uc>0 then begin
		TObject(fUndoList[uc-1]).free;
      fUndoList.delete(uc-1);
      fUndoCaptions.delete(uc-1);
   end;
end;

procedure TImageEnProc.ClearRedo;
var
	uc:integer;
begin
   uc:=fRedoList.Count;
   if uc>0 then begin
		TObject(fRedoList[uc-1]).free;
      fRedoList.delete(uc-1);
      fRedoCaptions.delete(uc-1);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Undo;
begin
   UndoAt(0);
end;

function TImageEnProc.MakeConsistentBitmap(allowedFormats:TIEPixelFormatSet):boolean;
begin
	result:=false;
	if not assigned(fIEBitmap) then
   	exit;
   if assigned(fBitmap) then
      fIEBitmap.EncapsulateTBitmap(fBitmap,false); // synchronize fBitmap with fIEBitmap
   if (not (allowedFormats=[])) and (not (fIEBitmap.PixelFormat in allowedFormats)) then
   	exit;
   result:=true;
end;


// Position: 0=last saved undo, 1=before last saved undo,  2...  up to UndoCount-1
procedure TImageEnProc.UndoAt(Position:integer);
var
	uc:integer;
   obj:TObject;
   ms:TMemoryStream;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   uc:=fUndoList.Count;
   if (uc>0) and (Position<uc) then begin
   	obj:=fUndoList[uc-1-Position];
      if obj is TIEBitmap then begin
      	// is an image
	      fIEBitmap.Assign( TIEBitmap(obj) );
	   	Update;
      end else if obj is TMemoryStream then begin
      	// is a selection
			ms:=TMemoryStream(obj);
         ms.Position:=0;
         if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
         	(fImageEnView as TImageEnView).LoadSelectionFromStream( ms );
      end;
   end;
end;

function TImageEnProc.UndoPeekAt(Position:integer):TIEUndoSource;
var
	obj:TObject;
begin
	result:=ieuUnknown;
	if (Position>=0) and (Position<fUndoList.Count) then begin
   	obj:=fUndoList[Position];
      if obj is TIEBitmap then
      	result:=ieuImage
      else if obj is TMemoryStream then
      	result:=ieuSelection;
   end;
end;

function TImageEnProc.RedoPeekAt(Position:integer):TIEUndoSource;
var
	obj:TObject;
begin
	result:=ieuUnknown;
	if (Position>=0) and (Position<fRedoList.Count) then begin
   	obj:=fRedoList[Position];
      if obj is TIEBitmap then
      	result:=ieuImage
      else if obj is TMemoryStream then
      	result:=ieuSelection;
   end;
end;

procedure TImageEnProc.Redo;
begin
   RedoAt(0);
end;

procedure TImageEnProc.RedoAt(Position:integer);
var
	uc:integer;
   obj:TObject;
   ms:TMemoryStream;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   uc:=fRedoList.Count;
   if (uc>0) and (Position<uc) then begin
   	obj:=fRedoList[uc-1-Position];
      if obj is TIEBitmap then begin
      	// is an image
         fIEBitmap.Assign( TIEBitmap(obj) );
         Update;
      end else if obj is TMemoryStream then begin
      	// is a selection
         ms:=TMemoryStream(obj);
         ms.Position:=0;
         if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
         	(fImageEnView as TImageEnView).LoadSelectionFromStream( ms );
      end;
   end;
end;

// remove specified undo
procedure TImageEnProc.ClearUndoAt(Position:integer);
var
	uc:integer;
begin
	uc:=fUndoList.Count;
   if (uc>0) and (Position<uc) then begin
		TObject(fUndoList[uc-1-Position]).free;
      fUndoList.delete(uc-1-Position);
      fUndoCaptions.delete(uc-1-Position);
   end;
end;

function TImageEnProc.GetCanUndo: boolean;
begin
	result:= fUndoList.Count>0;
end;

function TImageEnProc.GetUndoCount:integer;
begin
	result:= fUndoList.Count;
end;

function TImageEnProc.GetRedoCount:integer;
begin
	result:= fRedoList.Count;
end;

procedure TImageEnProc.SetUndoCaptions(index:integer; const Value:string);
begin
	if (index>=0) and (index<fUndoCaptions.Count) then
		fUndoCaptions[fUndoCaptions.Count-index-1]:=Value;
end;

function TImageEnProc.GetUndoCaptions(index:integer):string;
begin
	if (index>=0) and (index<fUndoCaptions.Count) then
		result:=fUndoCaptions[fUndoCaptions.Count-index-1];
end;

function TImageEnProc.GetRedoCaptions(index:integer):string;
begin
	if (index>=0) and (index<fRedoCaptions.Count) then
		result:=fRedoCaptions[fRedoCaptions.Count-index-1];
end;

procedure TImageEnProc.SaveUndo(Source:TIEUndoSource);
	//
   procedure SaveUndoObject(obj:TObject);
   begin
      while fUndoList.Count>=fUndoLimit do begin
         TObject(fUndoList[0]).free;
         fUndoList.delete(0);
         fUndoCaptions.delete(0);
      end;
      fUndoList.Add(obj);
      fUndoCaptions.Add('');
   end;
var
	ieb:TIEBitmap;
   ms:TMemoryStream;
begin
   case Source of
      ieuImage:
         begin
            // save the bitmap
            if not MakeConsistentBitmap([]) then
               exit;
            if (fIEBitmap.Width>0) and (fIEBitmap.Height>0) then begin
               ieb:=TIEBitmap.Create;
               ieb.MinFileSize:=0;
               ieb.Location:=fUndoLocation;
               ieb.Assign( fIEBitmap );
            	SaveUndoObject(ieb);
            end;
         end;
      ieuSelection:
         // save the selection (if connected to TImageEnView)
         if assigned(fImageEnView) and (fImageEnView is TImageEnView) then begin
         	ms:=TMemoryStream.Create;
				(fImageEnView as TImageEnView).SaveSelectionToStream(ms);
				SaveUndoObject(ms);
         end;
   end;
end;

procedure TImageEnProc.SaveRedo(Source:TIEUndoSource);
	//
   procedure SaveRedoObject(obj:TObject);
   begin
      while fRedoList.Count>=fUndoLimit do begin
         TObject(fRedoList[0]).free;
         fRedoList.delete(0);
         fRedoCaptions.delete(0);
      end;
      fRedoList.Add(obj);
      fRedoCaptions.Add('');
   end;
var
	ieb:TIEBitmap;
   ms:TMemoryStream;
begin
   case Source of
      ieuImage:
         begin
            // save the bitmap
            if not MakeConsistentBitmap([]) then
               exit;
            if (fIEBitmap.Width>0) and (fIEBitmap.Height>0) then begin
               ieb:=TIEBitmap.Create;
					ieb.MinFileSize:=0;
               ieb.Location:=fUndoLocation;
               ieb.Assign( fIEBitmap );
               saveRedoObject(ieb);
            end;
         end;
      ieuSelection:
         // save the selection (if connected to TImageEnView)
         if assigned(fImageEnView) and (fImageEnView is TImageEnView) then begin
         	ms:=TMemoryStream.Create;
				(fImageEnView as TImageEnView).SaveSelectionToStream(ms);
				SaveRedoObject(ms);
         end;
   end;
end;

procedure TImageEnProc.SaveRedoCaptioned(const Caption:string; Source:TIEUndoSource);
begin
   if not MakeConsistentBitmap([]) then
      exit;
   if (fIEBitmap.Width>0) and (fIEBitmap.Height>0) then begin
		SaveRedo(Source);
	   fRedoCaptions[ fRedoList.Count-1 ] := Caption;
   end;
end;

procedure TImageEnProc.SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource);
begin
   if not MakeConsistentBitmap([]) then
      exit;
   if (fIEBitmap.Width>0) and (fIEBitmap.Height>0) then begin
		SaveUndo(Source);
	   fUndoCaptions[ fUndoList.Count-1 ] := Caption;
   end;
end;

// Apply filter inside the specified area
// fSel.. in bitmap coordinates
procedure _ApplyFilter(bitmap:TIEBitmap;filter:TGraphFilter; fSelx1,fSely1,fSelx2,fSely2:integer; var Progress:TProgressRec);
var
   x,y:integer;
   newbitmap:TIEBitmap;
   mxh:integer;
   l1,l2,l3:pRGBROW;
   lr1,lr3:integer;
   px:pRGB;
   xl,xr,q,w:integer;
   multix:array [0..8,0..255] of integer;
   bitmapwidth1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
	if filter.divisor=0 then
   	filter.divisor:=1;
   // calc multix
   with filter do
	   for q:=0 to 255 do begin
      	w:=0;
      	for x:=0 to 2 do
         	for y:=0 to 2 do begin
	      		multix[w][q]:=Values[x][y]*q;
               inc(w);
            end;
      end;
   //
	newbitmap:=tiebitmap.create;
   newbitmap.Allocate(bitmap.width,bitmap.height,ie24RGB);
   mxh:=bitmap.Height-1;
   Progress.per1:=100/(fSelY2-fSelY1+0.5);
   bitmapwidth1:=bitmap.width-1;
	for y:=fSely1 to fSely2 do begin
   	lr1:=ilimit(y-1,0,mxh); l1:=PRGBROW(bitmap.GetRow(lr1));
      l2:=PRGBROW(bitmap.GetRow(y));
      lr3:=ilimit(y+1,0,mxh); l3:=PRGBROW(bitmap.GetRow(lr3));
      px:=PRGB(newbitmap.Scanline[y]); inc(px,fSelX1);
     	for x:=fSelx1 to fSelx2 do
        	with filter do begin
            xl:=imax(x-1,0);
            xr:=imin(x+1,bitmapwidth1);
            px^.r:=blimit(( multix[0,l1[xl].r]+multix[1,l1[x].r]+multix[2,l1[xr].r]+
                            multix[3,l2[xl].r]+multix[4,l2[x].r]+multix[5,l2[xr].r]+
                            multix[6,l3[xl].r]+multix[7,l3[x].r]+multix[8,l3[xr].r] ) div Divisor);
            px^.g:=blimit(( multix[0,l1[xl].g]+multix[1,l1[x].g]+multix[2,l1[xr].g]+
                            multix[3,l2[xl].g]+multix[4,l2[x].g]+multix[5,l2[xr].g]+
                            multix[6,l3[xl].g]+multix[7,l3[x].g]+multix[8,l3[xr].g] ) div Divisor);
            px^.b:=blimit(( multix[0,l1[xl].b]+multix[1,l1[x].b]+multix[2,l1[xr].b]+
                            multix[3,l2[xl].b]+multix[4,l2[x].b]+multix[5,l2[xr].b]+
                            multix[6,l3[xl].b]+multix[7,l3[x].b]+multix[8,l3[xr].b] ) div Divisor);
            inc(px);
     	   end;
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
      bitmap.FreeRow(lr3);
      bitmap.FreeRow(y);
      bitmap.FreeRow(lr1);
   end;
   newbitmap.CopyRectTo(bitmap,fSelX1,fSelY1,fSelX1,fSelY1,fSelX2-fSelX1+1,fSelY2-fSelY1+1);
   FreeAndNil(newbitmap);
end;

procedure _ApplyFilter8g(bitmap:TIEBitmap;filter:TGraphFilter; fSelx1,fSely1,fSelx2,fSely2:integer);
var
   x,y:integer;
   newbitmap:TIEBitmap;
   mxh:integer;
   l1,l2,l3:pbytearray;
   lr1,lr3:integer;
   px:pbyte;
   xl,xr,q,w:integer;
   multix:array [0..8,0..255] of integer;
   bitmapwidth1:integer;
begin
	if Bitmap.Pixelformat<>ie8g then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
	if filter.divisor=0 then
   	filter.divisor:=1;
   // calc multix
   with filter do
	   for q:=0 to 255 do begin
      	w:=0;
      	for x:=0 to 2 do
         	for y:=0 to 2 do begin
	      		multix[w][q]:=Values[x][y]*q;
               inc(w);
            end;
      end;
   //
	newbitmap:=tiebitmap.create;
   newbitmap.Allocate(bitmap.width,bitmap.height,ie8g);
   mxh:=bitmap.Height-1;
   bitmapwidth1:=bitmap.width-1;
	for y:=fSely1 to fSely2 do begin
   	lr1:=ilimit(y-1,0,mxh); l1:=pbytearray(bitmap.GetRow(lr1));
      l2:=pbytearray(bitmap.GetRow(y));
      lr3:=ilimit(y+1,0,mxh); l3:=pbytearray(bitmap.GetRow(lr3));
      px:=pbyte(newbitmap.Scanline[y]); inc(px,fSelX1);
     	for x:=fSelx1 to fSelx2 do
        	with filter do begin
            xl:=imax(x-1,0);
            xr:=imin(x+1,bitmapwidth1);
            px^:=blimit(( multix[0,l1[xl]]+multix[1,l1[x]]+multix[2,l1[xr]]+
                            multix[3,l2[xl]]+multix[4,l2[x]]+multix[5,l2[xr]]+
                            multix[6,l3[xl]]+multix[7,l3[x]]+multix[8,l3[xr]] ) div Divisor);
            inc(px);
     	   end;
      bitmap.FreeRow(lr3);
      bitmap.FreeRow(y);
      bitmap.FreeRow(lr1);
   end;
   newbitmap.CopyRectTo(bitmap,fSelX1,fSelY1,fSelX1,fSelY1,fSelX2-fSelX1+1,fSelY2-fSelY1+1);
   FreeAndNil(newbitmap);
end;


// Apply a filter to the current selection
procedure TImageEnProc.ApplyFilter(filter:TGraphFilter);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
   Progress:TProgressRec;
begin
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'ApplyFilter',ProcBitmap,mask) then
   	exit;
   _ApplyFilter(ProcBitmap,filter,x1,y1,x2,y2, Progress);
   EndImageProcessing(ProcBitmap,mask);
end;

// Varia HSL nella selezione specificata
// fSel.. sono espresse in coordinate della bitmap
// oHue [-180,+180]
// oSat,oLum [-100,+100]
procedure _HSLvar(bitmap:TIEBitmap;oHue,oSat,oLum:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   Hue,Sat,Lum, doHue,doSat,doLum:double;
   ppx:pRGB;
   per1:double;
begin
	if bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   doHue:=oHue/360;
   doSat:=oSat/100;
   doLum:=oLum/100;
   per1:=100/(fSelY2-fSelY1+0.5);
  	for y:=fSely1 to fSely2 do begin
		ppx:=bitmap.ScanLine[y];
      inc(ppx,fSelx1);
    	for x:=fSelx1 to fSelx2 do begin
         RGB2HSL(ppx^,Hue,Sat,Lum);
         HSL2RGB(ppx^,Hue+doHue,Sat+doSat,Lum+doLum);
         inc(ppx);
		end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

// Varia HSL nella selezione specificata
// fSel.. sono espresse in coordinate della bitmap
// oHue [-180,+180]
// oSat,oLum [-100,+100]
procedure TImageEnProc.HSLvar(oHue,oSat,oLum:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'HSLvar '+inttostr(oHue)+','+inttostr(oSat)+','+inttostr(oLum),ProcBitmap,mask) then
   	exit;
   _HSLvar(ProcBitmap,oHue,oSat,oLum,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// Varia HSV nella selezione specificata
// fSel.. sono espresse in coordinate della bitmap
procedure _HSVvar(bitmap:TIEBitmap;oHue,oSat,oVal:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   Hue,Sat,Val:integer;
   ppx:pRGB;
   per1:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSely1 to fSely2 do begin
		ppx:=bitmap.ScanLine[y];
      inc(ppx,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
	      RGB2HSV(ppx^,Hue,Sat,Val);
	      HSV2RGB(ppx^,Hue+oHue,Sat+oSat,Val+oVal);
         inc(ppx);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
	end;
end;

// Varia HSV nella selezione specificata
// fSel.. sono espresse in coordinate della bitmap
// oHue [0..359]
// oSat [0..99]
// oVal [0..99]
procedure TImageEnProc.HSVvar(oHue,oSat,oVal:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2, 'HSVvar '+inttostr(oHue)+','+inttostr(osat)+','+inttostr(oVal), ProcBitmap,mask) then
   	exit;
   _HSVvar(ProcBitmap,oHue,oSat,oVal,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// returns actual background color
function TImageEnProc.GetReBackground:TColor;
begin
	if assigned(fImageEnView) then
   	result:=fImageEnView.background
   else
   	result:=fBackground;
end;

// sets actual background color
procedure TImageEnProc.SetReBackground(v:TColor);
begin
	if assigned(fImageEnView) then
   	fImageEnView.background:=v
   else
   	fBackground:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
// return selected area (bitmap coordinates)
// return true when there is a selected area
// note: x2,y2 are the bottom/right side plus 1
function TImageEnProc.GetReSel(var fsX1,fsY1,fsX2,fsY2:integer; var PolySel:PPointArray; var PolySelCount:integer; var mask:TIEMask):boolean;
var
	ImageEnView:TImageEnView;
begin
   if assigned(fBitmap) then
      fIEBitmap.EncapsulateTBitmap(fBitmap,false); // synchronize fBitmap with fIEBitmap
	PolySelCount:=0;
   mask:=nil;
   // default apply full image
   fSX1:=0;
   fSY1:=0;
   fSX2:=fiebitmap.width;
   fSY2:=fiebitmap.height;
   result:=false;
   //
   if assigned(fImageEnView) and (fImageEnView is TImageEnView) then begin
   	// get selection from TImageEnView
      ImageEnView:=fImageEnView as TImageEnView;
      mask:=ImageEnView.SelectionMask;
      if ImageEnView.Selected then begin
      	if not mask.IsEmpty then begin
            fSX1:=mask.X1;
            fSY1:=mask.Y1;
            fSX2:=mask.X2+1;
            fSY2:=mask.Y2+1;
         end;
         PolySel:=ImageEnView.PolySelPoints;
         PolySelCount:=ImageEnView.PolySelCount;
         result:=true;
      end;
   end;
end;

procedure TImageEnProc.ApplyFilterPreset(filter:TIEFilterPresets);
begin
	ApplyFilter(IEFiltPres[ord(filter)]);
end;

// ruota in senso orario di 90 gradi
procedure _Rot90o(bakbmp:TBitmap; newbitmap:TBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pRGB;
   vertarray:pPRGBArray;	// list of pointers to scanline (vertical)
begin
	dx:=bakbmp.width; dy:=bakbmp.Height;
   newbitmap.PixelFormat:=bakbmp.PixelFormat;
   newbitmap.Width:=dy;
   newbitmap.Height:=dx;
   // costruisce puntatori a linee di bakbmp
   getmem(vertarray,bakbmp.height*sizeof(pRGB));
   for y:=0 to dy-1 do
		vertarray[y]:=bakbmp.scanline[dy-y-1];
   // ruota
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[x];
   	for y:=0 to dy-1 do begin
      	oldpx:=vertarray[y];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
   freemem(vertarray);
end;

procedure _Rot90oEx(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pRGB;
begin
	dx:=bakbmp.width;
   dy:=bakbmp.Height;
   newbitmap.Allocate(dy,dx,bakbmp.PixelFormat);
   (*
   newbitmap.PixelFormat:=bakbmp.PixelFormat;
   newbitmap.Width:=dy;
   newbitmap.Height:=dx;
   *)
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[x];
   	for y:=0 to dy-1 do begin
      	oldpx:=bakbmp.scanline[dy-y-1];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
end;

// accept ie8g and ie8p
procedure _Rot90oEx8(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pbyte;
begin
	dx:=bakbmp.width;
   dy:=bakbmp.Height;
   newbitmap.Allocate(dy,dx,bakbmp.PixelFormat);
   (*
   newbitmap.PixelFormat:=bakbmp.PixelFormat;
   newbitmap.Width:=dy;
   newbitmap.Height:=dx;
   *)
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[x];
   	for y:=0 to dy-1 do begin
      	oldpx:=bakbmp.scanline[dy-y-1];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
end;


// ruota in senso antiorario di 90 gradi
procedure _Rot90(bakbmp:TBitmap; newbitmap:TBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pRGB;
   vertarray:pPRGBArray;	// lista di puntatori a scanline (verticale)
begin
	dx:=bakbmp.width; dy:=bakbmp.Height;
   newbitmap.PixelFormat:=bakbmp.PixelFormat;
   newbitmap.Width:=dy;
   newbitmap.Height:=dx;
   // costruisce puntatori a linee di bakbmp
   getmem(vertarray,bakbmp.height*sizeof(pRGB));
   for y:=0 to dy-1 do
		vertarray[y]:=bakbmp.scanline[y];
   // ruota
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[dx-x-1];
   	for y:=0 to dy-1 do begin
      	oldpx:=vertarray[y];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
   freemem(vertarray);
end;

procedure _Rot90Ex(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pRGB;
begin
	dx:=bakbmp.width;
   dy:=bakbmp.Height;
   newbitmap.Allocate(dy,dx,bakbmp.PixelFormat);
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[dx-x-1];
   	for y:=0 to dy-1 do begin
      	oldpx:=bakbmp.scanline[y];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
end;

// accept ie8g and ie8p
procedure _Rot90Ex8(bakbmp:TIEBitmap; newbitmap:TIEBitmap);
var
	x,y:integer;
   dx,dy:integer;
   newpx,oldpx:pbyte;
begin
	dx:=bakbmp.width; dy:=bakbmp.Height;
   newbitmap.Allocate(dy,dx,bakbmp.PixelFormat);
   (*
   newbitmap.PixelFormat:=bakbmp.PixelFormat;
   newbitmap.Width:=dy;
   newbitmap.Height:=dx;
   *)
   for x:=0 to dx-1 do begin
   	newpx:=newbitmap.ScanLine[dx-x-1];
   	for y:=0 to dy-1 do begin
      	oldpx:=bakbmp.scanline[y];
         inc(oldpx,x);
			newpx^:=oldpx^;
         inc(newpx);
      end;
   end;
end;

// resize the bitmap without loss its content
procedure TImageEnProc.ImageResize(newWidth, newHeight:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
begin
   if not MakeConsistentBitmap([]) then
      exit;
   if (newWidth=0) or (newHeight=0) then exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ImageResize '+inttostr(newWidth)+','+inttostr(newHeight),ieuImage);
   fIEBitmap.Resize(newWidth,newHeight,GetReBackground,255,HorizAlign,VertAlign);
   Update;
end;

// h,s,l (Hue Saturation Luminosity) da 0 a 1
procedure RGB2HSL(px:TRGB; var Hue,Sat,Lum:double);
var
	delta,r,g,b,cmax,cmin:double;
begin
	r:=px.r/255;  g:=px.g/255;  b:=px.b/255;
	cmax:=dmax(r,dmax(g,b));  cmin:=dmin(r,dmin(g,b));
   Lum:=(cmax+cmin)/2;
   if cmax=cmin then begin
   	Sat:=0;
      Hue:=0;
   end else begin
   	if Lum<0.5 then
      	Sat:=(cmax-cmin)/(cmax+cmin)
      else
      	Sat:=(cmax-cmin)/(2-cmax-cmin);
      delta:=cmax-cmin;
      if r=cmax then
      	Hue:=(g-b)/delta
      else if g=cmax then
      	Hue:=2+(b-r)/delta
      else
      	Hue:=4+(r-g)/delta;
      Hue:=Hue/6;
      if Hue<0 then
      	Hue:=Hue+1;
   end;
end;

// iHue,iSat,iLum 0..1
procedure HSL2RGB(var px:TRGB; iHue,iSat,iLum:double);
function HueToRGB(m1,m2,h:double):double;
const C1=2/3;
begin
	if h<0 then h:=h+1
   else if h>1 then h:=h-1;
   if 6*h<1 then
   	result:=(m1+(m2-m1)*h*6)
   else if 2*h<1 then
   	result:=m2
   else if 3*h<2 then
   	result:=(m1+(m2-m1)*(C1-h)*6)
   else
   	result:=m1;
end;
const
	C1=1/3;
var
	r,g,b:double;
   m1,m2:double;
begin
	// check limits
   if iHue<0 then iHue:=1+iHue
   else if iHue>1 then iHue:=iHue-1;
   if iSat<0 then iSat:=0
   else if iSat>1 then iSat:=1;
   if iLum<0 then iLum:=0
   else if iLum>1 then iLum:=1;
   //
	if iSat=0 then begin
   	r:=iLum; g:=iLum; b:=iLum;
   end else begin
   	if iLum<=0.5 then
      	m2:=iLum*(1+iSat)
      else
      	m2:=iLum+iSat-iLum*iSat;
      m1:=2*iLum-m2;
      r:=HueToRGB(m1,m2,iHue+C1);
      g:=HueToRGB(m1,m2,iHue);
      b:=HueToRGB(m1,m2,iHue-C1);
   end;
	px.r:=blimit(round(r*255));
   px.g:=blimit(round(g*255));
   px.b:=blimit(round(b*255));
end;

// HSV to RGB.
//    H = 0 to 359 (corresponding to 0..359 degrees around hexcone)
//    S = 0 (shade of gray) to 99 (pure color)
//    V = 0 (black) to 99 {white)
//
//    Based on C Code in "Computer Graphics -- Principles and Practice,"
//    Foley et al, 1996, p. 594.  Floating point fractions, 0..1, replaced with
//    integer values, 0..99.
procedure HSV2RGB(var px:TRGB; H,S,V:integer);
const
      divisor:  INTEGER = 99*60;
var
      f    :  INTEGER;
      hTemp:  INTEGER;
      p,q,t:  INTEGER;
      VS   :  INTEGER;
begin
	 // check limits (changed at 2.1.1)
    if H<0 then
    	H:=360+H
    else if H>359 then
    	H:=H-360;
    if S<0 then S:=0
    else if S>99 then S:=99;
    if V<0 then V:=0
    else if V>99 then V:=99;
    //
    if S = 0 then begin
    	px.r:=v;
		px.g:=v;
      px.b:=v;
    end else begin
      IF H = 360 then
      	hTemp := 0
      else
      	hTemp := H;
      f := hTemp mod 60;
      hTemp := hTemp div 60;
      VS := V*S;
      p := V - VS div 99;
      q := V - (VS*f) div divisor;
      t := V - (VS*(60 - f)) div divisor;
      with px do
      begin
        case hTemp of
          0:  begin  R := V;  G := t;  B := p  end;
          1:  begin  R := q;  G := V;  B := p  end;
          2:  begin  R := p;  G := V;  B := t  end;
          3:  begin  R := p;  G := q;  B := V  end;
          4:  begin  R := t;  G := p;  B := V  end;
          5:  begin  R := V;  G := p;  B := q  end;
        end
      end
    end;
    px.r:=round(px.r/99*255);
    px.g:=round(px.g/99*255);
    px.b:=round(px.b/99*255);
end;

// RGB, each 0 to 255, to HSV.
//   H = 0 to 359 (corresponding to 0..359 degrees around hexcone)
//   S = 0 (shade of gray) to 99 (pure color)
//   V = 0 (black) to 99 {white)
//
//   Based on C Code in "Computer Graphics -- Principles and Practice,"
//   Foley et al, 1996, p. 592.  Floating point fractions, 0..1, replaced with
//   integer values, 0..99.
procedure RGB2HSV(RGB:TRGB; var h,s,v:integer);
  procedure MinMax3(const i,j,k:integer; var min, max:integer);
  begin
    IF i > j then begin
      IF i > k then max := i else max := k;
      IF j < k then min := j else min := k
    end else begin
      IF j > k then max := j else max := k;
      IF i < k then min := i else min := k
    end
  end;
var
   Delta   :  integer;
   MinValue:  integer;
   r,g,b:integer;
begin
	 r:=round( RGB.r/255*99 );
    g:=round( RGB.g/255*99 );
    b:=round( RGB.b/255*99 );
    MinMax3(R, G, B, MinValue, V);
    Delta := V - MinValue;
    if V = 0 then S := 0 else S := (99 * Delta) div V;
    if S = 0 then H := 0
    else begin
        if R = V then
        		h := (60*(G-B)) div Delta
        else if G = V then
        		h := 120 + (60*(B-R)) div Delta
        else if B = V then
        		h := 240 + (60*(R-G)) div Delta;
      if H < 0 then H := H + 360;
    end;
end;

// read filter file 3x3 version 1
function LoadFilterFromFile(const nf:string):TGraphFilter;
var
	bb,dx,dy:byte;
   fr:TFileStream;
begin
	fr:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fr.Read(bb,1);	// versione
	fr.Read(dx,1);	// dimensione orizzontale (byte) = 3
   fr.Read(dy,1);	// dimensione verticale (byte) = 3
   if (bb<>1) or (dx<>3) or (dy<>3) then
 		FreeAndNil(fr)
	else begin
		// carica
      fr.read(result,sizeof(TGraphFilter));
	   FreeAndNil(fr);
   end;
end;

// write 3x3 filter (version 1)
procedure SaveFilterToFile(const nf:string; const filt:TGraphFilter);
var
	bb:byte;
   fw:TFileStream;
begin
	fw:=TFileStream.Create(nf,fmCreate);
   bb:=1;  fw.Write(bb,1);	// v.1
	bb:=3;  fw.Write(bb,1); fw.Write(bb,1);	// 3x3
   fw.Write(filt,sizeof(TGraphFilter));
   FreeAndNil(fw);
end;

// applies contrast to the specified area
procedure _ContrastRGB(bitmap:TIEBitmap;vv:integer;mR,mG,mB:integer;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   vi:integer;
   x,y:integer;
   ppx:pRGB;
   per1:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   if vv>=0 then
      vi:=trunc((1+vv/10)*65536)
   else
     	vi:=trunc((1-sqrt(-vv)/10)*65536);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSely1 to fSely2 do begin
      ppx:=bitmap.ScanLine[y];
      inc(ppx,fSelX1);
    	for x:=fSelX1 to fSelX2 do begin
         ppx^.r:=blimit( mR+(((ppx^.r-mR)*vi) div 65536) );
         ppx^.g:=blimit( mG+(((ppx^.g-mG)*vi) div 65536) );
         ppx^.b:=blimit( mB+(((ppx^.b-mB)*vi) div 65536) );
         inc(ppx);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

procedure TImageEnProc.ConvertToGray;
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'ConvertToGray',ProcBitmap,mask) then
   	exit;
	_ConvertToGray(ProcBitmap,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Fonde la selezione di bitmap con tutta la DBitmap:
// pcf: percentuale di fusione (100=tutta bitmap, 0=tutta DBitmap)
// DBitmap viene adattata alla selezione specificata
procedure _Merge(bitmap:TIEBitmap; DBitmap:TIEBitmap; pcf:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   ppx,ppx2:pRGB;
   per1:double;
   bitmap2:TIEBitmap;
   c1,c2:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   //
	bitmap2:=TIEBitmap.Create;
   bitmap2.Allocate(fSelX2-fSelX1+1, fSelY2-fSelY1+1, ie24RGB);
   _IEBmpStretchEx(DBitmap,bitmap2,nil,nil);
   //
   per1:=100/(fSelY2-fSelY1+0.5);	// progress
   c1:=pcf/100;
   c2:=(100-pcf)/100;
   for y:=fSelY1 to fSelY2 do begin
     	ppx:=bitmap.ScanLine[y];
      ppx2:=bitmap2.ScanLine[y-fSelY1];
      inc(ppx,fSelX1);
     	for x:=fSelX1 to fSelX2 do begin
        ppx^.r:= blimit(round(ppx^.r*c1 + ppx2^.r*c2));
        ppx^.g:= blimit(round(ppx^.g*c1 + ppx2^.g*c2));
        ppx^.b:= blimit(round(ppx^.b*c1 + ppx2^.b*c2));
        inc(ppx);
        inc(ppx2);
 	   end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
   FreeAndNil(bitmap2);
end;

procedure TImageEnProc.MergeIEBitmap(DBitmap:TIEBitmap; pcf:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Merge '+inttostr(pcf),ProcBitmap,mask) then
   	exit;
   _Merge(ProcBitmap,Dbitmap,pcf,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


{$ifdef IEDELPHI}
procedure TImageEnProc.Merge(DBitmap:TBitmap; pcf:integer);
var
   iebmp:TIEBitmap;
begin
   iebmp:=TIEBitmap.Create;
   iebmp.EncapsulateTBitmap(DBitmap,true);
   MergeIEBitmap(iebmp,pcf);
   FreeAndNil(iebmp);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
// Forza un insieme di colori ad uno specifico
// fSel.. sono espresse in coordinate della bitmap
procedure _CastColorRange(bitmap:TIEBitmap;BeginColor,EndColor,CastColor:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   e:pRGB;
   per1:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSely1 to fSely2 do begin
     	e:=bitmap.ScanLine[y];
      inc(e,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
			if (e^.r>=BeginColor.r) and (e^.g>=BeginColor.g) and (e^.b>=BeginColor.b) and
				(e^.r<=EndColor.r) and (e^.g<=EndColor.g) and (e^.b<=EndColor.b) then
                e^:=CastColor;
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Effetto threshold (taglio)
// Assegna DownVal a tutti i colori inferiori a DownLimit e
// UpVal a tutti i colori superiori a UpLimit.
procedure _Threshold(bitmap:TIEBitmap; DownLimit,UpLimit, DownVal,UpVal:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   e:pRGB;
   per1:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	if EqualRGB(DownLimit,CreateRGB(0,0,0)) and EqualRGB(UpLimit,CreateRGB(255,255,255)) then
   	exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSely1 to fSely2 do begin
     	e:=bitmap.ScanLine[y];
      inc(e,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
      	if (e^.r<=DownLimit.r) then
         	e^.r:=DownVal.r;
         if (e^.g<=DownLimit.g) then
         	e^.g:=DownVal.g;
         if (e^.b<=DownLimit.b) then
         	e^.b:=DownVal.b;
         if (e^.r>UpLimit.r) then
         	e^.r:=UpVal.r;
         if (e^.g>UpLimit.g) then
         	e^.g:=UpVal.g;
         if (e^.b>UpLimit.b) then
         	e^.b:=UpVal.b;
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Effetto threshold (taglio)
// Assegna DownVal a tutti i colori inferiori a DownLimit e
// UpVal a tutti i colori superiori a UpLimit.
procedure TImageEnProc.Threshold(DownLimit,UpLimit, DownVal,UpVal:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Threshold',ProcBitmap,mask) then
   	exit;
   _Threshold(ProcBitmap,DownLimit,UpLimit,DownVal,UpVal,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// automatically equalize the histogram
procedure TImageEnProc.HistAutoEqualize;
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'HistAutoEqualize',ProcBitmap,mask) then
   	exit;
   _HistAutoEqualize(ProcBitmap,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Equalizza istogramma automaticamente
procedure _HistAutoEqualize(bitmap:TIEBitmap; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y,i,mxh,xl,xr:integer;
   e,s:pRGB;
   per1:double;
   Hist:THistogram;
   Left,Right:array [0..255] of integer;
   current:integer;
   newbitmap:TIEBitmap;
   average:TRGB;
   gaverage:integer;
	l1,l2,l3:pRGBROW;
   i1,i3:integer;
   g:integer;
   bitmapwidth1:integer;
   n_av,total:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	_GetHistogram(bitmap,Hist,0,0,bitmap.width-1,bitmap.height-1);
	n_av:=bitmap.width*bitmap.height / 256;
   //
	current:=0;  total:=0;
   for i:=0 to 255 do begin
   	left[i]:=blimit(current);
      total:=total+Hist[i].gray;
      while total>n_av do begin
      	total:=total-n_av;
         inc(current);
      end;
      right[i]:=blimit(current);
   end;
	//
   mxh:=bitmap.Height-1;
   newbitmap:=TIEBitmap.create;
   newbitmap.Allocate(bitmap.width,bitmap.height,ie24RGB);
   bitmapwidth1:=bitmap.width-1;
   for y:=fSely1 to fSely2 do begin
     	e:=bitmap.GetRow(y);
      s:=newbitmap.ScanLine[y];
      inc(e,fSelx1);
      inc(s,fSelx1);
      i1:=ilimit(y-1,0,mxh);
		l1:=bitmap.GetRow(i1);
		l2:=pRGBROW(e);
      i3:=ilimit(y+1,0,mxh);
     	l3:=bitmap.GetRow(i3);
     	for x:=fSelx1 to fSelx2 do begin
     		xl:=imax(x-1,0);
         xr:=imin(x+1,bitmapwidth1);
         average.r:=blimit((l1[xl].r+l1[x].r+l1[xr].r+
         						 l2[xl].r+l2[x].r+l2[xr].r+
                  			 l3[xl].r+l3[x].r+l3[xr].r) div 9);
         average.g:=blimit((l1[xl].g+l1[x].g+l1[xr].g+
         						 l2[xl].g+l2[x].g+l2[xr].g+
                  			 l3[xl].g+l3[x].g+l3[xr].g) div 9);
         average.b:=blimit((l1[xl].b+l1[x].b+l1[xr].b+
         						 l2[xl].b+l2[x].b+l2[xr].b+
                  			 l3[xl].b+l3[x].b+l3[xr].b) div 9);
         gaverage:=(average.r*21+average.g*71+average.b*8) div 100;
         g:=(e^.r*21+e^.g*71+e^.b*8) div 100;
         //
      	if left[ g ] = right[ g ] then begin
         	s^.r:=left[ e^.r ];
            s^.g:=left[ e^.g ];
            s^.b:=left[ e^.b ];
         end else begin
		 		if gaverage>right[g] then begin
	           	s^.r:=right[e^.r];
	            s^.g:=right[e^.g];
	            s^.b:=right[e^.b];
	         end else if gaverage<left[g] then begin
	           	s^.r:=left[e^.r];
	            s^.g:=left[e^.g];
	            s^.b:=left[e^.b];
	         end else begin
	          	s^.r:=average.r;
	            s^.g:=average.g;
	            s^.b:=average.b;
   	      end;
         end;
			//
         inc(e);
         inc(s);
      end;
      bitmap.FreeRow(y);
      bitmap.FreeRow(i1);
      bitmap.FreeRow(i3);
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
   newbitmap.CopyRectTo(bitmap,fSelX1,fSelY1,fSelX1,fSelY1,(fSelX2-fSelX1+1),(fSelY2-fSelY1+1));
   FreeAndNil(newbitmap);
end;

// Equalize Histogram
procedure TImageEnProc.HistEqualize(LoThresh,HiThresh:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'HistEqualize',ProcBitmap,mask) then
   	exit;
   _HistEqualize(ProcBitmap,LoThresh,HiThresh,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// Equalize Histogram
procedure _HistEqualize(bitmap:TIEBitmap; LoThresh,HiThresh:TRGB; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y,q:integer;
   e:pRGB;
   per1:double;
   LoMap,HiMap:THistogram;
	dx:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	HiThresh.r:=imax(HiThresh.r,1);
	HiThresh.g:=imax(HiThresh.g,1);
   HiThresh.b:=imax(HiThresh.b,1);
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   if equalrgb(LoThresh,HiThresh) then
   	exit;
	for q:=0 to 255 do begin
   	// work on LoThreh
   	dx:=255-LoThresh.r; if dx=0 then dx:=1;
   	LoMap[q].r:=blimit( round(((q-LoThresh.r)/dx)*255) );
   	dx:=255-LoThresh.g; if dx=0 then dx:=1;
      LoMap[q].g:=blimit( round(((q-LoThresh.g)/dx)*255) );
   	dx:=255-LoThresh.b; if dx=0 then dx:=1;
      LoMap[q].b:=blimit( round(((q-LoThresh.b)/dx)*255) );
      // work on HiThresh
   	HiMap[q].r:=blimit( round((q/HiThresh.r)*255) );
      HiMap[q].g:=blimit( round((q/HiThresh.g)*255) );
      HiMap[q].b:=blimit( round((q/HiThresh.b)*255) );
   end;
   for y:=fSely1 to fSely2 do begin
     	e:=bitmap.ScanLine[y];
      inc(e,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
      	e^.r:=LoMap[e^.r].r;
         e^.r:=HiMap[e^.r].r;
         e^.g:=LoMap[e^.g].g;
         e^.g:=HiMap[e^.g].g;
         e^.b:=LoMap[e^.b].b;
         e^.b:=HiMap[e^.b].b;
			//
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

// execute preview dialog
{$ifdef IEINCLUDEDIALOGIP}
function TImageEnProc.DoPreviews(pe:TPreviewEffects):boolean;
(*$ifdef IEDELPHI*)
var
  fPreviews: TfPreviews;
  x1,y1,x2,y2:integer;
  fPolyS:PPointArray;
  fPolySCount:integer;
  mask:TIEMask;
  iebmp:TIEBitmap;
begin
	result:=false;
	if assigned(fImageEnView) then
		fImageEnView.GetCanvas.Lock;
   try
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   if (fIEBitmap.Width<2) and (fIEBitmap.Height<2) then exit;
   GetReSel(x1,y1,x2,y2,fPolyS,fPolySCount,mask);
	fPreviews:=TfPreviews.Create(self);
   fPreviews.DefaultLockPreview:=prppDefaultLockPreview in PreviewsParams;
   fPreviews.SetLanguage(fMsgLanguage);
   fPreviews.Font.assign(fPreviewFont);
   fPreviews.Progress.fOnProgress:=fOnProgress;
   fPreviews.Progress.Sender:=self;
   fPreviews.ImageEn1.Background:=Background;
   fPreviews.ImageEn2.Background:=Background;
   fPreviews.OpenDialog1.InitialDir:=fFiltersInitialDir;
   fPreviews.SaveDialog1.InitialDir:=fFiltersInitialDir;
   with fPreviews do begin
   	(*
      iebmp:=TIEBitmap.Create;
      iebmp.EncapsulateTBitmap(Bitmap,true);
      iebmp.Width:=(x2-x1);   // not +1, because x2 and y2 are bottomright side plus 1
      iebmp.Height:=(y2-y1);
      fIEBitmap.CopyRectTo(iebmp,x1,y1,0,0,(x2-x1),(y2-y1));
      FreeAndNil(iebmp);
      *)
      ImageEn1.IEBitmap.Width:=(x2-x1);
		ImageEn1.IEBitmap.Height:=(y2-y1);
      fIEBitmap.CopyRectTo(ImageEn1.IEBitmap,x1,y1,0,0,(x2-x1),(y2-y1));
      if fIEBitmap.HasAlphaChannel then
      	fIEBitmap.AlphaChannel.CopyRectTo(ImageEn1.IEBitmap.AlphaChannel,x1,y1,0,0,(x2-x1),(y2-y1));
      Update;
   end;
   fPreviews.pe:=pe;
   fPreviews.InitialPage:=nil;
   if assigned(fOnPreview) then
   	fOnPreview(self,fPreviews);
	if fPreviews.ShowModal=mrOk then begin
   	result:=true;
		if fAutoUndo then
	   	SaveUndoCaptioned('Previews',ieuImage);
		// apply results
      with fPreviews do begin
         if assigned(mask) and (not mask.IsEmpty) and ((x1>0) or (y1>0) or (x2<=fIEBitmap.width) or (y2<=fIEBitmap.Height)) then begin
         	// polygonal selection
            iebmp:=TIEBitmap.Create;
            iebmp.EncapsulateTBitmap(imageen1.bitmap,true);
            mask.CopyIEBitmap(fIEBitmap,iebmp,false,true,false);
            FreeAndNil(iebmp);
		   end else begin
         	// change size if needed
            (*
            if (imageen1.bitmap.width<>fiebitmap.width) then
					fiebitmap.width:=imageen1.bitmap.width;
            if (imageen1.bitmap.height<>fiebitmap.height) then
            	fiebitmap.height:=imageen1.bitmap.height;
            iebmp:=TIEBitmap.Create;
            iebmp.EncapsulateTBitmap(imageen1.bitmap,true);
				//fbitmap.canvas.draw(x1,y1,imageen1.bitmap);
            iebmp.CopyRectTo(fIEBitmap,0,0,x1,y1,iebmp.Width,iebmp.Height);
            FreeAndNil(iebmp);
            *)
            fIEBitmap.Width:=ImageEn1.IEBitmap.Width;
            fIEBitmap.Height:=ImageEn1.IEBitmap.Height;
				imageen1.IEBitmap.CopyRectTo(fIEBitmap,0,0,x1,y1,imageen1.IEBitmap.Width,imageen1.IEBitmap.Height);
            if imageen1.IEBitmap.HasAlphaChannel then
            	imageen1.IEBitmap.AlphaChannel.CopyRectTo(fIEBitmap.AlphaChannel,0,0,x1,y1,imageen1.IEBitmap.Width,imageen1.IEBitmap.Height);
         end;
      end;
      update;
   end else
   	result:=false;
   fPreviews.Release;
   finally
      if assigned(fImageEnView) then
         fImageEnView.GetCanvas.UnLock;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)
{$endif}

// Resample the image to NewWidth and NewHeight
// if NewWidth or NewHeight is -1, it is calculated maintain aspect ratio
// if NewWidth or NewHeight is 0, it doesn't change
procedure TImageEnProc.Resample(NewWidth,NewHeight:integer; FilterType:TResampleFilter);
var
	newbitmap:TIEBitmap;
begin
	if (fIEBitmap.Width=0) or (fIEBitmap.Height=0) then exit;
	//
	newbitmap:=TIEBitmap.create;
   ResampleTo(newbitmap,NewWidth,NewHeight,FilterType);	// ResampleTo resizes the bitmap and set pixelformat
   fIEBitmap.assign( newbitmap );
   FreeAndNil(newbitmap);
   //
   Update;
end;

// if TargetWidth or TargetHeight is -1, it is calculated maintain aspect ratio
// if TargetWidth or TargetHeight is 0, it doesn't change
procedure TImageEnProc.ResampleTo(Target:TIEBitmap; TargetWidth,TargetHeight:integer; FilterType:TResampleFilter);
begin
   if not MakeConsistentBitmap([]) then
      exit;
   if (fIEBitmap.Width=0) or (fIEBitmap.Height=0) then exit;
	if fAutoUndo then
   	SaveUndoCaptioned('Resample '+inttostr(TargetWidth)+','+inttostr(TargetHeight),ieuImage);
   // check and adjust TargetWidth and NewHeight
	if (TargetWidth<0) and (TargetHeight<0) then
   	exit;		// ERROR
   case TargetWidth of
   	-1: TargetWidth:=(fIEbitmap.width*TargetHeight) div fIEbitmap.Height;
   	 0: TargetWidth:=fIEBitmap.Width;
       else TargetWidth:=abs(TargetWidth);
   end;
   if TargetWidth<1 then TargetWidth:=1;
   case TargetHeight of
   	-1: TargetHeight:=(fIEbitmap.Height*TargetWidth) div fIEbitmap.Width;
       0: TargetHeight:=fIEBitmap.Height;
       else TargetHeight:=abs(TargetHeight);
   end;
   if TargetHeight<1 then TargetHeight:=1;
   Target.Allocate(TargetWidth,TargetHeight,fIEBitmap.PixelFormat);
   _IEResampleIEBitmap(fIEBitmap,Target,FilterType,fOnProgress,self);
end;

procedure _IESetAlpha0Color(bitmap:TIEBitmap; cl:TRGB);
var
	x,y:integer;
   a:pbyte;
   p:PRGB;
begin
	for y:=0 to bitmap.height-1 do begin
   	a:=bitmap.AlphaChannel.Scanline[y];
      p:=bitmap.Scanline[y];
      for x:=0 to bitmap.width-1 do begin
      	if a^=0 then
         	p^:=cl;
      	inc(p);
         inc(a);
      end;
   end;
end;

// resample ie1g, ie24RGB. Resample also alphachannel
// if FilterType is not rfNone, it must be ie24RGB
procedure _IEResampleIEBitmap(source,dest:TIEBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
begin
	if source.HasAlphaChannel then
   	// this avoid transparent color merges with image colors
   	_IESetAlpha0Color(source,CreateRGB(128,128,128));
	if (FilterType=rfNone) then
   	// 1bit or 24bit unfiltered
   	_IEBmpStretchEx(source,dest,fOnProgress,Sender)
   else if (source.pixelformat=ie1g) then begin
   	// 1bit filtered
      dest.PixelFormat:=ie24RGB;
      _Resample1BitEx(source,dest,FilterType);
   end else
   	// 24bit filtered
  	   _ResampleEx(source,dest,FilterType,fOnProgress, Sender);
	if source.HasAlphaChannel then begin
      if (FilterType=rfNone) then
         _IEBmpStretchEx(source.AlphaChannel,dest.AlphaChannel,nil,nil)
      else
         _resamplealphaex(source.AlphaChannel,dest.AlphaChannel,FilterType);
      dest.AlphaChannel.Full:=source.AlphaChannel.Full;
   end;
end;

procedure TImageEnProc.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (AComponent=fImageEnView) and (Operation=opRemove) then begin
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
   	fImageEnView:=nil;
   end;
   if (AComponent=fTImage) and (Operation=opRemove) then fTImage:=nil;
end;

// accept all pixelformats
procedure _GetMediaContrastRGB(bitmap:TIEBitmap; var mR,mG,mB:integer);
var
   w,h,v:integer;
   tr,tg,tb,ww,hh:integer;
   x,y:integer;
   ppx:pRGB;
   bpx:pbyte;
   wpx:pword;
   fpx:psingle;
begin
   mR:=0; mG:=0; mB:=0;
   ww:=bitmap.Width;
   hh:=bitmap.Height;
   w:=ww-1;
   h:=hh-1;
   try
   for y:=0 to h do begin
      tr:=0; tg:=0; tb:=0;
      case bitmap.PixelFormat of
         ie1g:		// gray scale (black/white)
         	begin
               bpx:=bitmap.ScanLine[y];
               for x:=0 to w do
                  if pbytearray(bpx)^[x shr 3] and iebitmask1[x and $7]<>0 then begin
                     inc(tr,255);
                     inc(tg,255);
                     inc(tb,255);
                  end;
            end;
         ie8p:		// color (palette)
				begin
               bpx:=bitmap.ScanLine[y];
               for x:=0 to w do begin
                  with bitmap.Palette[bpx^] do begin
                     inc(tr,r);
                     inc(tg,g);
                     inc(tb,b);
                  end;
                  inc(bpx);
               end;
            end;
         ie8g:		// gray scale (256 levels)
				begin
               bpx:=bitmap.ScanLine[y];
               for x:=0 to w do begin
                  inc(tr,bpx^);
                  inc(tg,bpx^);
                  inc(tb,bpx^);
                  inc(bpx);
               end;
            end;
         ie16g:	//	gray scale (65536 levels)
				begin
               wpx:=bitmap.ScanLine[y];
               for x:=0 to w do begin
                  inc(tr,wpx^);
                  inc(tg,wpx^);
                  inc(tb,wpx^);
                  inc(wpx);
               end;
            end;
         ie24RGB:	// color (true color)
				begin
               ppx:=bitmap.ScanLine[y];
               for x:=0 to w do begin
                  with ppx^ do begin
                     inc(tr,r);
                     inc(tg,g);
                     inc(tb,b);
                  end;
                  inc(ppx);
               end;
            end;
         ie32f:	//	float point gray scale
				begin
               fpx:=bitmap.ScanLine[y];
               for x:=0 to w do begin
               	v:=trunc(fpx^*255);
                  inc(tr,v);
                  inc(tg,v);
                  inc(tb,v);
                  inc(fpx);
               end;
            end;
      end;
      mR:= mR+ (tr div ww);
      mG:= mG+ (tg div ww);
      mB:= mB+ (tb div ww);
   end;
   mR:=mR div hh;
   mG:=mG div hh;
   mB:=mB div hh;
   except
      // on overflow
      mR:=128;
      mG:=128;
      mB:=128;
   end;
end;

// make an histogram of r,g,b and gray channels
procedure TImageEnProc.GetHistogram(var Hist:THistogram);
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   GetReSel(fSX1,fSY1,fSX2,fSY2,fPolyS,fPolySCount,mask);
   _GetHistogram(fIEBitmap,Hist,fSx1,fSy1,fSx2,fSy2);
end;

// make an histogram of r,g,b and gray channels
procedure _GetHistogram(Bitmap:TIEBitmap; var Hist:THistogram;fSelx1,fSely1,fSelx2,fSely2:integer);
var
   x,y:integer;
   e:pRGB;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
  	fillmemory(@Hist,sizeof(THistogram),0);	// zero fill
   for y:=fSely1 to fSely2 do begin
     	e:=Bitmap.ScanLine[y];
      inc(e,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
        	inc( Hist[ e^.r ].r );
         inc( Hist[ e^.g ].g );
         inc( Hist[ e^.b ].b );
      	inc( Hist[ (e^.r*21+e^.g*71+e^.b*8) div 100 ].Gray );
         inc(e);
  		end;
   end;
end;

// return the number of colors in the specified selection
function _GetImageNumColors(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer):integer;
var
	x,y,c:integer;
   e:pRGB;
   hash:THash1;
begin
	result:=0;
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   hash:=THash1.Create(13);
   for y:=fSely1 to fSely2 do begin
   	e:=Bitmap.ScanLine[y];
      inc(e,fSelx1);
      for x:=fSelx1 to fSelx2 do begin
         c:=(e^.r shl 16) or (e^.g shl 8) or (e^.b);
			hash.Insert(c);
      	inc(e);
      end;
   end;
   result:=hash.nkeys;
   FreeAndNil(hash);
end;

// return the number of colors in the specified selection
function TImageEnProc.CalcImageNumColors:integer;
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
   mask:TIEMask;
begin
	result:=0;
   if not MakeConsistentBitmap([]) then
      exit;
   if fIEBitmap.PixelFormat=ie1g then begin
   	result:=2;
      exit;
   end;
   if fIEBitmap.Pixelformat<>ie24RGB then exit;
   GetReSel(fSX1,fSY1,fSX2,fSY2,fPolyS,fPolySCount,mask);
   result:=_GetImageNumColors(fIEBitmap,fSx1,fSy1,fSx2,fSy2);
end;

// apply the specified contrast offset
procedure TImageEnProc.Contrast(vv:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
   mR,mG,mB:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Contrast '+inttostr(vv),ProcBitmap,mask) then
   	exit;
   _GetMediaContrastRGB(fIEBitmap,mR,mG,mB);	// media over full image (not selection)
   _ContrastRGB(ProcBitmap,vv,mR,mG,mB,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


// like _ConvertTo1bit but uses TIEBitmap
// supports all TIEBitmap pixelformats
function _ConvertTo1bitEx(Bitmap:TIEBitmap; var BackCol,ForeCol:TRGB):TIEBitmap;
var
	x,y,c:integer;
   e:TRGB;
   d:pbyte;
   hash:THash1;
   bitpos:integer;
   bb,ff:byte;
   t:TRGB;
   bitmapwidth1,bitmapheight1:integer;
begin
   hash:=THash1.Create(13);
   result:=TIEBitmap.Create;
   result.Allocate(Bitmap.Width,Bitmap.Height,ie1g);
   bitmapwidth1:=bitmap.width-1;
   bitmapheight1:=bitmap.height-1;
   for y:=0 to Bitmapheight1 do begin
   	if hash.nkeys>2 then break;
      d:=result.ScanLine[y];
      bitpos:=0;
      for x:=0 to BitmapWidth1 do begin
         e:=Bitmap.Pixels[x,y];
         c:=(e.r shl 16) or (e.g shl 8) or (e.b);
			if hash.Insert(c) then begin
         	if hash.nkeys=1 then
            	BackCol:=e
            else
            	ForeCol:=e;
         end;
			if (e.r=BackCol.r) and (e.g=BackCol.g) and (e.b=BackCol.b) then
            d^:= d^ and (not iebitmask1[bitpos])
         else
         	d^:= d^ or iebitmask1[bitpos];
         inc(bitpos);
         if bitpos=8 then begin
         	bitpos:=0;
            inc(d);
         end;
      end;
   end;
   if hash.nkeys<>2 then
   	FreeAndNil(result)
   else begin
		bb:=Round((BackCol.r*21 + BackCol.g*71 + BackCol.b*8)/100);
      ff:=Round((ForeCol.r*21 + ForeCol.g*71 + ForeCol.b*8)/100);
      if bb>ff then begin
			_Negative1BitEx(result);
			t:=BackCol; BackCol:=ForeCol; ForeCol:=t;
      end;
   end;
   FreeAndNil(hash);
end;


// make LUT needed to convert 1bit to 24bit
procedure MakeC1TO24;
var
	q,w,v:integer;
begin
	for q:=0 to 255 do begin
   	for w:=0 to 7 do begin
      	if (q and iebitmask1[w])<>0 then v:=255 else v:=0;
	   	C1TO24[q][w].r:=v;
         C1TO24[q][w].g:=v;
         C1TO24[q][w].b:=v;
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// restituisce i colori trovati in bitmap.
// palette: palette dei colori trovati
// max: dimensione di palette
// nota: se il numero di colori dell'immagine è superiore a max, i colori vengono
// quantizzati.
procedure _GetImagePalette(bitmap:TIEBitmap; var palette:array of TRGB; max:integer);
var
   qt:TIEQuantizer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	qt:=TIEQuantizer.Create(Bitmap, palette, max, -1,0);
   FreeAndNil(qt);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.CalcImagePalette(var Palette:array of TRGB; MaxCol:integer);
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   _GetImagePalette(fIEBitmap,Palette,MaxCol);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.CopyToClipboard;
{$ifdef IEDELPHI}
var
	hbi:THandle;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if OpenClipboard(0) then begin
      EmptyClipboard;
      hbi:=_CopyBitmaptoDIBEx(fIEBitmap,0,0,0,0);
   	SetClipboardData(CF_DIB,hbi);
   	CloseClipboard;
      // the system own the memory (then we don't need GlobalFree(hbi) )
   end;
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.PasteFromClipboard;
(*$ifdef IEDELPHI*)
var
	hbi:THandle;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if OpenClipboard(0) then begin
		if IsClipboardFormatAvailable(CF_DIB) then begin
			hbi:=GetClipboardData(CF_DIB);
         if hbi<>0 then begin
				if fAutoUndo then
			   	SaveUndoCaptioned('PasteFromClipboard',ieuImage);
				_CopyDIB2BitmapEx(hbi,fIEBitmap,nil,false);
            Update;
         end;
      end;
   	CloseClipboard;
   end;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.PointPasteFromClip(x1,y1:integer);
(*$ifdef IEDELPHI*)
var
	pabitmap:tiebitmap;
	hbi:THandle;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if OpenClipboard(0) then begin
		if IsClipboardFormatAvailable(CF_DIB) then begin
			hbi:=GetClipboardData(CF_DIB);
         if hbi<>0 then begin
           	pabitmap:=TIEBitmap.create;
				_CopyDIB2BitmapEx(hbi,paBitmap,nil,false);
				if fAutoUndo then
			   	SaveUndoCaptioned('PointPasteFromClip '+inttostr(x1)+','+inttostr(y1),ieuImage);
			   if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            	with fImageEnView as TImageEnView do
	               if SelectionBase=iesbClientArea then begin
	                  x1:=XScr2Bmp(x1);
	                  y1:=YScr2Bmp(y1);
                  end;
            pabitmap.CopyRectTo(fIEBitmap,0,0,x1,y1,pabitmap.Width,pabitmap.Height);
			   FreeAndNil(pabitmap);
			   Update;
         end;
      end;
   	CloseClipboard;
   end;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.SelPasteFromClipStretch;
(*$ifdef IEDELPHI*)
var
	pabitmap,pbBitmap:TIEBitmap;
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
	hbi:THandle;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if GetReSel(fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask) then begin
		if OpenClipboard(0) then begin
			if IsClipboardFormatAvailable(CF_DIB) then begin
				hbi:=GetClipboardData(CF_DIB);
	         if hbi<>0 then begin
					pabitmap:=TIEBitmap.create;
					if fAutoUndo then
				   	SaveUndoCaptioned('SelPasteFromClipStretch',ieuImage);
					_CopyDIB2BitmapEx(hbi,paBitmap,nil,false);
					pbBitmap:=TIEbitmap.Create;
               pbBitmap.Allocate(fsx2-fsx1,fsy2-fsy1,paBitmap.PixelFormat);
               _IEBmpStretchEx(paBitmap,pbBitmap,nil,nil);
               pbBitmap.CopyRectTo(fIEBitmap,0,0,fsx1,fsy1,pbBitmap.Width,pbBitmap.Height);
				   FreeAndNil(pabitmap);
			    	Update;
	         end;
      	end;
	   	CloseClipboard;
   	end;
   end else
   	PasteFromClipboard;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
// Varia RGB nella selezione specificata
procedure TImageEnProc.IntensityRGBall(r,g,b:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'IntensityRGBall '+inttostr(r)+','+inttostr(g)+','+inttostr(b),ProcBitmap,mask) then
   	exit;
   _IntensityRGBall(ProcBitmap,r,g,b,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
// Varia RGB nella selezione specificata
// fSel.. sono espresse in coordinate della bitmap
procedure _IntensityRGBall(bitmap:TIEBitmap;r,g,b:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   e:pRGB;
   per1:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSely1 to fSely2 do begin
    	e:=bitmap.ScanLine[y];
      inc(e,fSelx1);
     	for x:=fSelx1 to fSelx2 do begin
			e^.b:=blimit(e^.b+b);
        	e^.g:=blimit(e^.g+g);
         e^.r:=blimit(e^.r+r);
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce una Bitmap contenente un solo canale H,S o B dell'immagine corrente
// ch: 0=H 1=S 2=V
// La bitmap risultante è sempre pf24bit
function _GetHSVChannel(bitmap:TIEBitmap; ch:integer; fOnProgress:TIEProgressEvent; Sender:TObject):TIEBitmap;
var
   x,y:integer;
   e,d:pRGB;
   per1:double;
   hsv:array [0..2] of integer;
   dv,r:integer;
   bitmapwidth1,bitmapheight1:integer;
begin
	result:=nil;
	if Bitmap.Pixelformat<>ie24RGB then exit;
	result:=TIEBitmap.Create;
   result.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   per1:=100/Bitmap.Height;
   case ch of
   	0: dv:=359;
      1: dv:=99;
      2: dv:=99;
      else begin
      	// caso in cui ch non è valido assume Hue
      	ch:=0;
         dv:=359;
      end;
   end;
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to BitmapHeight1 do begin
    	e:=bitmap.ScanLine[y];
      d:=result.ScanLine[y];
     	for x:=0 to BitmapWidth1 do begin
			RGB2HSV(e^,hsv[0],hsv[1],hsv[2]);
         r:= trunc((hsv[ch]/dv)*255);
			d^.r:=r;
        	d^.g:=r;
         d^.b:=r;
         inc(e);   inc(d);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*y));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce una Bitmap contenente un solo canale R,G o B dell'immagine corrente
// ch: B=0 G=1 R=2
// La bitmap risultante è sempre pf24bit
function _GetRGBChannel(bitmap:TIEBitmap; ch:integer; fOnProgress:TIEProgressEvent; Sender:TObject):TIEBitmap;
var
   x,y:integer;
   e:pbytearray;
   d:pRGB;
   per1:double;
   bitmapwidth1,bitmapheight1:integer;
begin
	result:=nil;
	if Bitmap.Pixelformat<>ie24RGB then exit;
	result:=TIEBitmap.Create;
   result.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   per1:=100/Bitmap.Height;
   if ch>2 then ch:=2;
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to BitmapHeight1 do begin
    	e:=bitmap.ScanLine[y];
      d:=result.ScanLine[y];
     	for x:=0 to BitmapWidth1 do begin
			d^.b:=e[ch];
        	d^.g:=e[ch];
         d^.r:=e[ch];
         inc(pbyte(e),3);
         inc(d);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*y));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce una Bitmap contenente un solo canale H,S o B dell'area selezionata
// ch: 0=H 1=S 2=V
function TImageEnProc.GetHSVChannel(ch:integer):TIEBitmap;
begin
	result:=nil;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   result:=_GetHSVChannel(fIEBitmap,ch,fOnProgress, self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce una Bitmap contenente un solo canale R,G o B dell'area selezionata
// ch: B=0 G=1 R=2
function TImageEnProc.GetRGBChannel(ch:integer):TIEBitmap;
begin
	result:=nil;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   result:=_GetRGBChannel(fIEBitmap,ch,fOnProgress, self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce tre Bitmap contenenti separatamente i canali H,S o B dell'immagine corrente
// ch: 0=H 1=S 2=V
// La bitmap risultante è sempre pf24bit
// E' cura della chiamante creare le bitmap
procedure _GetHSVChannelAll(bitmap:TIEBitmap; BitmapH,BitmapS,BitmapV:TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   e,d1,d2,d3:pRGB;
   per1:double;
	h,s,v:integer;
   r:integer;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
	BitmapH.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   BitmapS.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   BitmapV.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   per1:=100/Bitmap.Height;
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to BitmapHeight1 do begin
    	e:=bitmap.ScanLine[y];
      d1:=BitmapH.ScanLine[y];
      d2:=BitmapS.ScanLine[y];
      d3:=BitmapV.ScanLine[y];
     	for x:=0 to BitmapWidth1 do begin
			RGB2HSV(e^,h,s,v);
         // Sat
         r:= trunc((s/99)*255);
			d2^.r:=r; d2^.g:=r; d2^.b:=r;
         inc(d2);
         // Val
         r:= trunc((v/99)*255);
			d3^.r:=r; d3^.g:=r; d3^.b:=r;
         inc(d3);
         // Hue
         r:= trunc((h/359)*255);
			d1^.r:=r; d1^.g:=r; d1^.b:=r;
         //HSV2RGB(d1^,h,99,99);	// per ottenere la bitmap Hue colorata...
         inc(d1);
         //
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*y));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce tre Bitmap contenenti separatamente i canali H,S o B dell'immagine corrente
// ch: 0=H 1=S 2=V
// La bitmap risultante è sempre pf24bit
// E' cura della chiamante creare le bitmap
procedure TImageEnProc.GetHSVChannelAll(BitmapH,BitmapS,BitmapV:TIEBitmap);
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   _GetHSVChannelAll(fIEBitmap,BitmapH,BitmapS,BitmapV, fOnProgress, self);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce tre Bitmap contenenti separatamente i canali R,G o B dell'immagine corrente
// ch: 0=R 1=G 2=B
// La bitmap risultante è sempre pf24bit
// E' cura della chiamante creare le bitmap
procedure _GetRGBChannelAll(bitmap:TIEBitmap; BitmapR,BitmapG,BitmapB:TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
	e,d1,d2,d3:pRGB;
   per1:double;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   BitmapR.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   BitmapG.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   BitmapB.Allocate(Bitmap.Width,Bitmap.Height,ie24RGB);
   per1:=100/Bitmap.Height;
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to BitmapHeight1 do begin
    	e:=bitmap.ScanLine[y];
      d1:=BitmapR.ScanLine[y];
      d2:=BitmapG.ScanLine[y];
      d3:=BitmapB.ScanLine[y];
     	for x:=0 to BitmapWidth1 do begin
			d1^.r:=e^.r; d1^.g:=e^.r; d1^.b:=e^.r;
         inc(d1);
			d2^.r:=e^.g; d2^.g:=e^.g; d2^.b:=e^.g;
         inc(d2);
			d3^.r:=e^.b; d3^.g:=e^.b; d3^.b:=e^.b;
         inc(d3);
         //
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*y));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Restituisce tre Bitmap contenenti separatamente i canali R,G o B dell'immagine corrente
// ch: 0=R 1=G 2=B
// La bitmap risultante è sempre pf24bit
// E' cura della chiamante creare le bitmap
procedure TImageEnProc.GetRGBChannelAll(BitmapR,BitmapG,BitmapB:TIEBitmap);
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   _GetRGBChannelAll(fIEBitmap,BitmapR,BitmapG,BitmapB, fOnProgress, self);
end;

// Trova l'indice del colore più simile all'interno di una colormap
// Col: colore da trovare
// nc: numero colori in ColorMap
function _GetSimilColor(const ColorMap:array of TRGB; nc:integer; Col:TRGB):integer;
var
   q:integer;
	Diff,ADiff:integer;
begin
   ADiff:=1000;
   result:=0;
   for q:=0 to nc-1 do begin
   	Diff:=abs(Col.R-ColorMap[q].R)+abs(Col.G-ColorMap[q].G)+abs(Col.B-ColorMap[q].B);
      if Diff<ADiff then begin
      	result:=q;
      	ADiff:=Diff;
      end;
	end;
end;

// Inverte le R e B in una array di TRGB
// nc:numero colori da invertire
procedure _RGB2BGR(var ColorMap:array of TRGB; nc:integer);
var
	q:integer;
begin
	for q:=0 to nc-1 do
   	BSwap(ColorMap[q].R,ColorMap[q].B);
end;

// clone the bitmap
function IECloneBitmap(Source:TBitmap):TBitmap;
begin
	result:=TBitmap.Create;
   IECopyBitmap(Source,result);
end;

// Copia bitmap Source in Dest (già creata)
// Width,Height e PixelFormat di Source vengono copiati in Dest
// Nota: testato solo con pf1bit e pf24bit
procedure IECopyBitmap(Source,Dest:TBitmap);
var
	ps,pd:pbyte;
   l:integer;
   procedure ClearDest;
   begin
      Dest.Width:=1; Dest.Height:=1;
      Dest.Pixelformat:=Source.PixelFormat;
   end;
begin
	if (Source.Width=0) or (Source.Height=0) then begin
   	ClearDest;
   end else begin
   	if (Dest.Width<>Source.Width) or (Dest.Height<>Source.Height) or (Dest.PixelFormat<>Source.PixelFormat) then begin
      	ClearDest;
	      Dest.Width:=Source.Width;
	      Dest.Height:=Source.height;
      end;
      ps:= pbyte(imin(cardinal(Source.scanline[0]),integer(Source.scanline[source.height-1])));
      pd:= pbyte(imin(cardinal(Dest.scanline[0]),integer(Dest.scanline[Dest.height-1])));
      l:= IEBitmapRowlen(Dest.Width,_Pixelformat2Bitcount(Dest.Pixelformat),32);
      copymemory(pd,ps,l*Dest.height);
   end;
end;

// Create a DIB from a TBitmap object (that can be only pf1bit or pf24bit)
// returns the handle of the DIB (you have do release with GlobalFree() )
// x1,y1,x2,y2: selection to copy (if x2 and y2 are zero it copy entire bitmap)
(*$ifdef IEDELPHI*)
function _CopyBitmaptoDIB(fBitmap:TBitmap; x1,y1,x2,y2:integer):THandle;
var
   pbi:PBITMAPINFO;
   q:integer;
   pb:pbyte;
   px:PRGB;
   hh,ww,lw:integer;
   y:integer;
begin
	if x2=0 then x2:=fBitmap.Width;
   if y2=0 then y2:=fBitmap.Height;
	hh:=y2-y1;
   ww:=x2-x1;
   lw:=IEBitmapRowlen(ww,_Pixelformat2Bitcount(fBitmap.Pixelformat),32);
   if fBitmap.pixelformat=pf1bit then q:=8 else q:=0;	// spazio per colormap
   result:=GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE,sizeof(TBITMAPINFO)+q+lw*hh);
	pbi:=GlobalLock(result);
   l3fillchar(pbi^.bmiHeader,sizeof(TBITMAPINFOHEADER),0);
   with pbi^.bmiHeader do begin
     	biSize:=sizeof(TBITMAPINFOHEADER);
      biWidth:=ww;
      biHeight:=hh;
      biPlanes:=1;
      biCompression:=BI_RGB;
   end;
   if fBitmap.Pixelformat=pf24bit then begin
   	//// pf24bit
	   pbi^.bmiHeader.biBitCount:=24;
	   pb:=@(pbi^.bmiColors);
		for q:=y2-1 downto y1 do begin
	   	px:=fbitmap.Scanline[q];
	      inc(px,x1);
	     	CopyMemory(pb,px,lw);
	      inc(pb,lw);
	   end;
   end else if fBitmap.Pixelformat=pf1bit then begin
		//// pf1bit
	   pbi^.bmiHeader.biBitCount:=1;
      pb:=@(pbi^.bmiColors);
		// scrive colormap
      pdword(pb)^:=0;	// black
      inc(pb,4);
      pdword(pb)^:=$FFFFFFFF;	// white
      inc(pb,4);
      // scrive immagine
      for y:=y2-1 downto y1 do begin
      	px:=fBitmap.Scanline[y];
         _CopyBits(pb,pbyte(px),0,x1,ww,lw);
         inc(pb,lw);
   	end;
   end;
   GlobalUnLock(result);
end;
(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
// Create a DIB from a TIEDibBitmap object (that can be only ie1g or ie24RGB)
// returns the handle of the DIB (you have do release with GlobalFree() )
// x1,y1,x2,y2: selection to copy (if x2 and y2 are zero it copy entire bitmap)
(*$ifdef IEDELPHI*)
function _CopyBitmaptoDIBEx(fBitmap:TIEBaseBitmap; x1,y1,x2,y2:integer):THandle;
var
   pbi:PBITMAPINFO;
   q:integer;
   pb:pbyte;
   px:PRGB;
   hh,ww,lw:integer;
   y:integer;
begin
	if x2=0 then x2:=fBitmap.Width;
   if y2=0 then y2:=fBitmap.Height;
	hh:=y2-y1;
   ww:=x2-x1;
   lw:=fBitmap.RowLen;
   if fBitmap.pixelformat=ie1g then q:=8 else q:=0;	// colormap
   result:=GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE,sizeof(TBITMAPINFO)+q+lw*hh);
	pbi:=GlobalLock(result);
   Assert(pbi <> nil); // - <K>: 133137231.     
   l3fillchar(pbi^.bmiHeader,sizeof(TBITMAPINFOHEADER),0);
   with pbi^.bmiHeader do begin
     	biSize:=sizeof(TBITMAPINFOHEADER);
      biWidth:=ww;
      biHeight:=hh;
      biPlanes:=1;
      biCompression:=BI_RGB;
   end;
   if fBitmap.Pixelformat=ie24RGB then begin
   	//// pf24bit
	   pbi^.bmiHeader.biBitCount:=24;
      //pbi^.bmiHeader.biSizeImage:=_BitmapRowlen(ww,24)*hh;
	   pb:=@(pbi^.bmiColors);
		for q:=y2-1 downto y1 do begin
	   	px:=fbitmap.Scanline[q];
	      inc(px,x1);
	     	CopyMemory(pb,px,lw);
	      inc(pb,lw);
	   end;
   end else if fBitmap.Pixelformat=ie1g then begin
		//// pf1bit
	   pbi^.bmiHeader.biBitCount:=1;
      pb:=@(pbi^.bmiColors);
		// write colormap
      pdword(pb)^:=0;	// black
      inc(pb,4);
      pdword(pb)^:=$FFFFFFFF;	// white
      inc(pb,4);
      // write image
      for y:=y2-1 downto y1 do begin
      	px:=fBitmap.Scanline[y];
         _CopyBits(pb,pbyte(px),0,x1,ww,lw);
         inc(pb,lw);
   	end;
   end;
   GlobalUnLock(result);
end;
(*$endif*)


/////////////////////////////////////////////////////////////////////////////////////
// Copy Len bits from Source to Dest
// Dest: pointer to destination buffer
// Source: pointer to source buffer
// DestStart: start bit of Dest
// SourceStart: start bit of Source
// Len: number of bits to copy
procedure _CopyBits(Dest,Source:pbyte; DestStart,SourceStart,Len:integer; SourceRowLen:integer);
// fastest
//(*
const
	mask1:array [0..7] of byte=($0,$80,$C0,$E0,$F0,$F8,$FC,$FE);
   mask2:array [0..7] of byte=($0,$1,$3,$7,$F,$1F,$3F,$7F);
   mask3:array [0..7] of byte=($FF,$FE,$FC,$F8,$F0,$E0,$C0,$80);
var
	normalSourceStart,normalDestStart:integer;
   saveleft,saveright:byte;
   bitstosaveinright:integer;
   destrequiredbytes:integer;
   bytestocopy:integer;
   q:integer;
   pred,t,xmask3,xmask1,xmask2:byte;
   p1,p2,pr:pbyte;
   tbuf:pbyte;
   tbuf_predefined: array[0..3] of Int64;
   l_LocalBuf: Boolean;
begin
	if (Len<=0) or (DestStart<0) or (SourceStart<0) then exit;
	inc(Dest, DestStart shr 3);
   inc(Source, SourceStart shr 3);
   dec(SourceRowLen, SourceStart shr 3);
   normalDestStart:=DestStart and $7;
	normalSourceStart:=SourceStart and $7;
   destrequiredbytes:=(normalDestStart+Len+7) shr 3;
   xmask3:=mask3[normalSourceStart];
   xmask2:=mask2[normalDestStart];
   xmask1:=mask1[normalSourceStart];
   // 1 save
	saveleft:=Dest^ and mask1[normalDestStart];
   bitstosaveinright:=(destrequiredbytes shl 3)-normalDestStart-Len;
   pr:=@(pbytearray(Dest)[destrequiredbytes-1]);
  	saveright:=pr^ and mask2[bitstosaveinright];
   // 2 copy
   bytestocopy:=(normalSourceStart+Len+7) shr 3;
   l_LocalBuf := bytestocopy <= SizeOf(tbuf_predefined);
   if l_LocalBuf then
   begin
    l3FillChar(tbuf_predefined, SizeOf(tbuf_predefined), 0);
    tbuf := @tbuf_predefined;
   end
   else
    tbuf:=allocmem(bytestocopy+8);	// we need 0 filled from SourceRowLen to bytestocopy+8
	  copymemory(tbuf,Source,imin(bytestocopy+8,SourceRowLen));
   //
   if ((Len and $7)<>0) or (normalDestStart>0) or (normalSourceStart>0) then begin
	   // 3 shift left
      if normalSourceStart>0 then begin
         p1:=tbuf; p2:=tbuf; inc(p2);
			for q:=0 to bytestocopy-1 do begin
            p1^:= ((p1^ shl normalSourceStart) and xmask3) or ((p2^ and xmask1) shr (8-normalSourceStart));
            inc(p1);
            inc(p2);
         end;
      end;
      // 4 shift right
      if normalDestStart>0 then begin
         pred:=0;
         p1:=tbuf;
         for q:=0 to destrequiredbytes-1 do begin
            t:=(p1^ and xmask2) shl (8-normalDestStart);
            p1^:= (p1^ shr normalDestStart) or pred;
            pred:=t;
            inc(p1);
         end;
      end;
      // 5 restore
      tbuf^:=(tbuf^ and (not mask1[normalDestStart])) or saveleft;
      pr^:=(pr^ and (not mask2[bitstosaveinright])) or saveright;
   end;
   copymemory(Dest,tbuf,destrequiredbytes);
   if not l_LocalBuf then
    freemem(tbuf);
end;
//*)
(*
// medium fast version
var
	dx,sx:integer;
   bp:pbyte;
begin
	sx:=SourceStart;
	for dx:=DestStart to DestStart+Len-1 do begin
		bp:=@(pbytearray(Dest)^[dx shr 3]);
      if (pbytearray(Source)^[sx shr 3] and iebitmask1[sx and $7])<>0 then
         bp^:=bp^ or iebitmask1[dx and 7]
      else
         bp^:=bp^ and not iebitmask1[dx and 7];
      inc(sx);
   end;
end;
//*)
(*
// slower version
var
   rb:integer; // prossimo bit da leggere (0..7)  (7=ultimo a sinistra, MSB)
   wb:integer;	// prossimo bit da scrivere (0..7)
   tb:byte;		// buffer per byte da scrivere
begin
   inc(Source,SourceStart SHR 3);	// posiziona Source al byte iniziale
	rb:=7-(SourceStart and 7);			// Prossimo bit da leggere nel byte iniziale
   inc(Dest,DestStart SHR 3);			// posiziona Dest al byte iniziale
   wb:=7-(Deststart and 7);			// Prossimo bit da scrivere nel byte iniziale
   tb:=Dest^;
	while Len>0 do begin
		if (Source^ and (1 shl rb))<>0 then
			tb:=tb or (1 shl wb)	    		// bb è a 1
      else
         tb:=tb and not (1 shl wb);		// bb è a 0
		dec(wb);	// prossimo bit da scrivere
      if wb=-1 then begin
      	// fatti 8 bit, scrivi ed incrementa Dest
         Dest^:=tb;
         inc(Dest);
         tb:=Dest^;
         wb:=7;	// ricomincia dal bit a sinistra
      end;
      dec(rb);	// prossimo bit da leggere
      if rb=-1 then begin
      	// datti 8 bit, incrementa Source
         inc(Source);
         rb:=7;	// ricomincia dal bit a sinistra
      end;
      dec(Len);
   end;
   if wb<7 then
   	// scrivi bit rimanenti
      Dest^:=tb;
end;
//*)

/////////////////////////////////////////////////////////////////////////////////////
// Copia un'area di Source in Dest (già creata)
// PixelFormat di Source può essere solo pf24bit o pf1bit
// Width e Height di Dest vengono ricavati dalla porzione specificata
// x1,y1,x2,y2: selezione da copiare (se x2 e y2 sono zero prende tutta la bitmap)
procedure _CopyBitmapRect(Source,Dest:TBitmap; x1,y1,x2,y2:integer);
var
   pb,px:pbyte;
   hh,ww,lw:integer;
   y:integer;
   sinc,dinc:integer;
begin
	if x2=0 then x2:=Source.Width;
   if x2>Source.Width then x2:=Source.Width;
   if y2=0 then y2:=Source.Height;
   if y2>Source.Height then y2:=Source.Height;
	hh:=y2-y1;
   ww:=x2-x1;
   Dest.width:=1; Dest.height:=1;
   Dest.PixelFormat:=Source.PixelFormat;
   Dest.Width:=ww;
   Dest.Height:=hh;
   dinc:=-_PixelFormat2RowLen(Dest.Width,Dest.PixelFormat);
   sinc:=-_PixelFormat2RowLen(Source.Width,Source.PixelFormat);
   if Source.Pixelformat=pf24bit then begin
   	//// pf24bit
      lw:=ww*3;
		px:=Source.Scanline[y1];
      inc(px,x1*3);
      pb:=Dest.scanline[0];
		for y:=0 to hh-1 do begin
	     	CopyMemory(pb,px,lw);
			inc(pb,dinc);
         inc(px,sinc);
	   end;
   end else if Source.Pixelformat=pf1bit then begin
		//// pf1bit
      px:=Source.Scanline[y1];
      pb:=Dest.scanline[0];
      for y:=0 to hh-1 do begin
         _CopyBits(pb,px,0,x1,ww,-sinc);
         inc(pb,dinc);
         inc(px,sinc);
   	end;
   end;
end;

function TImageEnProc.BeginImageProcessing(allowedFormats:TIEPixelFormatSet; var x1,y1,x2,y2:integer; const OpName:string; var ProcBitmap:TIEBitmap; var mask:TIEMask):boolean;
var
   fPolyS:PPointArray;
   fPolySCount:integer;
begin
	result:=false;
   if not MakeConsistentBitmap(allowedFormats) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned(OpName,ieuImage);
   GetReSel(x1,y1,x2,y2,fPolyS,fPolySCount,mask);
   if assigned(mask) and (not mask.IsEmpty) then begin
      ProcBitmap:=TIEBitmap.Create;
      ProcBitmap.Allocate(mask.x2-mask.x1+1,mask.y2-mask.y1+1,fIEBitmap.PixelFormat);
      fIEBitmap.CopyRectTo(ProcBitmap,mask.x1,mask.y1,0,0,ProcBitmap.Width,ProcBitmap.Height);
      x1:=0;
      y1:=0;
      x2:=ProcBitmap.width;
      y2:=ProcBitmap.height;
   end else
   	ProcBitmap:=fIEBitmap;
   result:=true;
end;

procedure TImageEnProc.EndImageProcessing(ProcBitmap:TIEBitmap; mask:TIEMask);
begin
	if ProcBitmap<>fIEBitmap then begin
      mask.CopyIEBitmap(fIEBitmap,ProcBitmap,false,true,false);
      FreeAndNil(ProcBitmap);
   end;
	Update;
end;

procedure TImageEnProc.Negative;
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Negative',ProcBitmap,mask) then
   	exit;
	_Negative(ProcBitmap,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// negate the buffer
procedure _NegativeBuffer(buf:pbyte; WidthBytes:integer);
begin
	while WidthBytes>0 do begin
   	buf^:=not buf^;
      inc(buf);
      dec(WidthBytes);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Inverts the image (black/white)
procedure _Negative1Bit(Bitmap:TBitmap);
var
	x,y,dx:integer;
   w:pword;
begin
	dx:= _PixelFormat2RowLen(bitmap.Width,bitmap.PixelFormat) div 2;
	for y:=0 to bitmap.Height-1 do begin
		w:=bitmap.scanline[y];
      for x:=0 to dx-1 do begin
      	w^:=not w^;
         inc(w);
      end;
   end;
end;

// As _Negative1Bit but works with TIEBitmap
// works only with ie1g
procedure _Negative1BitEx(Bitmap:TIEBitmap);
var
	x,y,dx:integer;
   w:pword;
begin
   dx:= Bitmap.Rowlen div 2;
	for y:=0 to bitmap.Height-1 do begin
		w:=bitmap.scanline[y];
      for x:=0 to dx-1 do begin
      	w^:=not w^;
         inc(w);
      end;
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// supported pf1bit and pf24bit
procedure _Negative(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   col,row:integer;
   ppx:pRGB;
   per1:double;
   bx:pbyte;
   tb:byte;
   bb:integer;
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	if Bitmap.Pixelformat=ie24RGB then begin
   	// ie24RGB
	  	for row:=fSelY1 to fSelY2 do begin
	   	ppx:=bitmap.ScanLine[row];
	      inc(ppx,fSelX1);
	      for col:=fSelX1 to fSelX2 do begin
				ppx^.r:=255-ppx^.r;
	         ppx^.g:=255-ppx^.g;
	         ppx^.b:=255-ppx^.b;
	         inc(ppx);
	      end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
	   end;
   end else if Bitmap.Pixelformat=ie1g then begin
		// ie1g
      for row:=fSelY1 to fSelY2 do begin
      	bx:=Bitmap.Scanline[row];
		   inc(bx,fSelX1 SHR 3);
			bb:=7-(fSelX1 and 7);
         tb:=bx^;
         for col:=fSelX1 to fSelX2 do begin
				if (bx^ and (1 shl bb))=0 then
					tb:=tb or (1 shl bb)
		      else
		         tb:=tb and not (1 shl bb);
		      dec(bb);
		      if bb=-1 then begin
            	bx^:=tb;
		         inc(bx);
               tb:=bx^;
		         bb:=7;
		      end;
		   end;
		   if bb<7 then
		      bx^:=tb;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
      end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// accetta pf24bit e pf1bit
procedure TImageEnProc.Flip(dir:TFlipDir);
begin
   if not MakeConsistentBitmap([]) then
      exit;
   _FlipEx(fIEBitmap,dir);
   Update;
end;
(*
var
	x,y,w,h,xl:integer;
   newbitmap:TBitmap;
   newpx,oldpx:PRGB;
   newb,oldb:pbyte;
   m:integer;
   tbuf:pbyte;
begin
	if not assigned(fBitmap) then exit;
	if fAutoUndo then
   	SaveUndoCaptioned('Flip');
   newbitmap:=TBitmap.create;
   newbitmap.PixelFormat:=fbitmap.PixelFormat;
   newbitmap.Width:=fbitmap.width;
   newbitmap.Height:=fbitmap.height;
   w:=fbitmap.width-1;
   h:=fbitmap.height-1;
   if fBitmap.Pixelformat=pf24bit then m:=3 else m:=1;
   case dir of
     fdHorizontal:
     			if m=3 then
            	// pf24bit
	       		for y:=0 to h do begin
	            	newpx:=newbitmap.ScanLine[y];
	               oldpx:=fbitmap.ScanLine[y];
	               inc(oldpx,w);
						for x:=0 to w do begin
	               	newpx^:=oldpx^;
	                  inc(newpx);
	                  dec(oldpx);
	               end;
	            end
				else begin
            	// pf1bit
               w:=fbitmap.width div 8;
               if (fbitmap.width and 7)<>0 then begin
                  inc(w);
                  xl:=8-(fbitmap.width and 7); // we need to shift left the image
               end else xl:=0;
               if xl=0 then begin
                  for y:=0 to h do begin
                     newb:=newbitmap.ScanLine[y];
                     oldb:=fbitmap.ScanLine[y];
                     inc(oldb,w-1);
                     for x:=0 to w-1 do begin
                        newb^:=oldb^;
                        ReverseBitsB(newb^);
                        inc(newb);
                        dec(oldb);
                     end;
                  end;
               end else begin
                  // need to shift
                  getmem(tbuf,w);
                  for y:=0 to h do begin
                     newb:=tbuf;
                     oldb:=fbitmap.ScanLine[y];
                     inc(oldb,w-1);
                     for x:=0 to w-1 do begin
                        newb^:=oldb^;
                        ReverseBitsB(newb^);
                        inc(newb);
                        dec(oldb);
                     end;
                     _copybits(newbitmap.scanline[y],tbuf,0,xl,fBitmap.Width,w);
                  end;
                  freemem(tbuf);
               end;
            end;
     fdVertical:
     		if m=3 then
        		for y:=0 to h do
            	copymemory(newbitmap.scanline[y],fbitmap.scanline[h-y],m*fBitmap.Width)
         else begin
         	m:=_BitmapRowLen(fBitmap.Width,1);
        		for y:=0 to h do
            	copymemory(newbitmap.scanline[y],fbitmap.scanline[h-y],m)
         end;
   end;
	IECopyBitmap(newbitmap,fbitmap);
   FreeAndNil(newbitmap);
  	Update;
end;
*)

// Accepts TIEBitmap
// work with only ie24RGB and ie1g
procedure _FlipEx(bmp:TIEBitmap; dir:TFlipDir);
var
	x,y,w,h,xl:integer;
   newbitmap:TIEBitmap;
   newpx,oldpx:PRGB;
   newb,oldb,tbuf:pbyte;
   m:integer;
begin
   if (bmp.PixelFormat<>ie24RGB) and (bmp.PixelFormat<>ie1g) then exit;
   newbitmap:=TIEBitmap.create;
   newbitmap.Allocate(bmp.Width,bmp.Height,bmp.PixelFormat);
   w:=bmp.width-1;
   h:=bmp.height-1;
   if bmp.Pixelformat=ie24RGB then m:=3 else m:=1;
   case dir of
     fdHorizontal:
     			if m=3 then
            	// ie24RGB
	       		for y:=0 to h do begin
	            	newpx:=newbitmap.ScanLine[y];
	               oldpx:=bmp.ScanLine[y];
	               inc(oldpx,w);
						for x:=0 to w do begin
	               	newpx^:=oldpx^;
	                  inc(newpx);
	                  dec(oldpx);
	               end;
	            end
				else begin
            	// ie1g
               w:=bmp.width div 8;
               if (bmp.width and 7)<>0 then begin
                  inc(w);
                  xl:=8-(bmp.width and 7); // we need to shift left the image
               end else xl:=0;
               if xl=0 then begin
                  for y:=0 to h do begin
                     newb:=newbitmap.ScanLine[y];
                     oldb:=bmp.ScanLine[y];
                     inc(oldb,w-1);
                     for x:=0 to w-1 do begin
                        newb^:=oldb^;
                        ReverseBitsB(newb^);
                        inc(newb);
                        dec(oldb);
                     end;
                  end;
               end else begin
                  // need to shift
                  getmem(tbuf,w);
                  for y:=0 to h do begin
                     newb:=tbuf;
                     oldb:=bmp.ScanLine[y];
                     inc(oldb,w-1);
                     for x:=0 to w-1 do begin
                        newb^:=oldb^;
                        ReverseBitsB(newb^);
                        inc(newb);
                        dec(oldb);
                     end;
                     _copybits(newbitmap.scanline[y],tbuf,0,xl,bmp.Width,w);
                  end;
                  freemem(tbuf);
               end;

            end;
     fdVertical:
     		if m=3 then
        		for y:=0 to h do
            	copymemory(newbitmap.scanline[y],bmp.scanline[h-y],m*bmp.Width)
         else begin
         	m:=IEBitmapRowLen(bmp.Width,1,32);
        		for y:=0 to h do
            	copymemory(newbitmap.scanline[y],bmp.scanline[h-y],m)
         end;
   end;
   bmp.Assign(newbitmap);
   FreeAndNil(newbitmap);
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.SetPreviewFont(f:TFont);
begin
	fPreviewFont.assign(f);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Forza un insieme di colori ad uno specifico
// fSel.. sono espresse in coordinate della bitmap
procedure TImageEnProc.CastColorRange(BeginColor,EndColor,CastColor:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'CastColorRange',ProcBitmap,mask) then
   	exit;
   _CastColorRange(ProcBitmap,BeginColor,EndColor,CastColor,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


// Compare Bitmap1 with Bitmap2, return True if the images are equals
function _BitmapCompareX(Bitmap1,Bitmap2:TBitmap):boolean;
var
   l:integer;
begin
	if (Bitmap1.Width<>Bitmap2.Width) or (Bitmap1.Height<>Bitmap2.Height) then begin
   	result:=false;
   	exit;
   end;
   l:=_PixelFormat2RowLen(bitmap1.width,bitmap1.pixelformat);	// row length
   result:=CompareMem(Bitmap1.ScanLine[Bitmap1.Height-1],
   						 Bitmap2.ScanLine[Bitmap2.Height-1],
                      l*Bitmap1.Height);
end;

// Compare Bitmap1 with Bitmap2, return True if the images are equals
function _BitmapCompareXEx(Bitmap1,Bitmap2:TIEBitmap):boolean;
var
   y:integer;
begin
	if (Bitmap1.Width<>Bitmap2.Width) or (Bitmap1.Height<>Bitmap2.Height) then begin
   	result:=false;
   	exit;
   end;
   if Bitmap1.HasAlphaChannel<>Bitmap2.HasAlphaChannel then begin
   	result:=false;
      exit;
   end;
   // compare image
   for y:=0 to bitmap1.Height-1 do begin
	   result:=CompareMem(Bitmap1.ScanLine[y],Bitmap2.ScanLine[y],Bitmap1.RowLen);
      if not result then
      	exit;
   end;
   // compare alpha
   if Bitmap1.hasalphaChannel then begin
   	for y:=0 to bitmap1.AlphaChannel.Height-1 do begin
         result:=CompareMem(Bitmap1.AlphaChannel.ScanLine[y],Bitmap2.AlphaChannel.ScanLine[y],Bitmap1.AlphaChannel.RowLen);
         if not result then
            exit;
      end;
   end;
   result:=true;
end;


/////////////////////////////////////////////////////////////////////////////////////
// Crea un'immagine DIB dalla selezione poligonale specificata
// sx1..sy2: rettangolo che contiene la selezione poligonale
(*$ifdef IEDELPHI*)
function _CopyBitmaptoDibPoly(Source:TBitmap; sx1,sy1,sx2,sy2:integer; SelPoly:PPointArray; SelPolyCount:integer; mask:TIEMask):THandle;
var
	tmpbmp:TBitmap;
begin
	tmpbmp:=TBitmap.Create;
   tmpbmp.PixelFormat:=Source.PixelFormat;
   tmpbmp.width:=mask.x2-mask.x1+1;
   tmpbmp.height:=mask.y2-mask.y1+1;
   mask.CopyBitmap(tmpbmp,Source,true,false);
   result:=_CopyBitmaptoDIB(tmpbmp,0,0,tmpbmp.width,tmpbmp.height);
   FreeAndNil(tmpbmp);
end;

function _CopyBitmaptoDibPolyEx(Source:TIEBitmap; sx1,sy1,sx2,sy2:integer; SelPoly:PPointArray; SelPolyCount:integer; mask:TIEMask; fillcolor:integer):THandle;
var
	tmpbmp:TIEBitmap;
begin
	tmpbmp:=TIEBitmap.Create;
   tmpbmp.Allocate(mask.x2-mask.x1+1 , mask.y2-mask.y1+1 , Source.PixelFormat);
   tmpbmp.Fill(fillcolor);
   mask.CopyIEBitmap(tmpbmp,Source,true,false,false);
   result:=_CopyBitmaptoDIBEx(tmpbmp,0,0,tmpbmp.width,tmpbmp.height);
   FreeAndNil(tmpbmp);
end;
(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
// Copia la selezione nella clipboard
procedure TImageEnProc.SelCopyToClip;
(*$ifdef IEDELPHI*)
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
	hbi:THandle;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if GetReSel(fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask) then begin
		if OpenClipboard(0) then begin
	      EmptyClipboard;
         if assigned(mask) and (not mask.IsEmpty) then
         	hbi:=_CopyBitmaptoDibPolyEx(fIEBitmap,fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask,integer(GetReBackground))
         else
		      hbi:=_CopyBitmaptoDIBEx(fIEBitmap,fsx1,fsy1,fsx2,fsy2);
	   	SetClipboardData(CF_DIB,hbi);
	   	CloseClipboard;
	      //GlobalFree(hbi);	// the system own the memory
	   end;
   end else
   	CopyToClipboard;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.SelCutToClip;
(*$ifdef IEDELPHI*)
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
	hbi:THandle;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if GetReSel(fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask) then begin
		if fAutoUndo then
   		SaveUndoCaptioned('SelCutToClip',ieuImage);
		if OpenClipboard(0) then begin
	      EmptyClipboard;
         if assigned(mask) and (not mask.IsEmpty) then
         	hbi:=_CopyBitmaptoDibPolyEx(fIEBitmap,fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask,GetReBackground)
         else
		      hbi:=_CopyBitmaptoDIBEx(fIEBitmap,fsx1,fsy1,fsx2,fsy2);
	   	SetClipboardData(CF_DIB,hbi);
	   	CloseClipboard;
	      //GlobalFree(hbi);	// the system own the memory
	   end;
      if assigned(mask) and (not mask.IsEmpty) then
         // polygonal selection
         _ClearSelMaskEx(fIEBitmap,mask,GetReBackground)
      else
         fIEBitmap.FillRect(fSx1,fSy1,fSx2-1,fSy2-1,GetReBackground);
   	Update;
   end;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Clear;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('Clear',ieuImage);
   fIEBitmap.Fill(GetReBackground);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Clear specified selection (doesn't call SaveUndo and Update)
(*
procedure _ClearSel(fBitmap:TBitmap; SelPoly:PPointArray; SelPolyCount:integer; Background:TColor);
var
   hrgn:THandle;
   q,p1,p2:integer;
begin
   p1:=0;
   for q:=0 to SelPolyCount do
   	if (q=SelPolyCount) or (SelPoly^[q].x=IESELBREAK) then begin
      	p2:=q-p1;
         hrgn:=CreatePolygonRgn(SelPoly^[p1],p2,ALTERNATE);
         SelectClipRgn(fBitmap.Canvas.Handle,hrgn);
         fbitmap.Canvas.Brush.Color:= Background;
         fbitmap.canvas.Brush.Style := bsSolid;
         fbitmap.Canvas.fillrect(rect(0,0,fbitmap.width,fbitmap.height));
         SelectClipRgn(fBitmap.Canvas.Handle,0);
         DeleteObject(hrgn);
         p1:=q+1;
      end;
end;
*)

(*
// Clear masked area
procedure _ClearSelMask(fBitmap:TBitmap; mask:TIEMask; Background:TColor);
var
	tmpbmp:TBitmap;
begin
   tmpbmp:=TBitmap.Create;
   _CopyBitmapRect(fBitmap,tmpbmp,mask.x1,mask.y1,mask.x2+1,mask.y2+1);
   with tmpbmp.Canvas do begin
      Brush.Color:=Background;
      Brush.Style:=bsSolid;
      fillrect(rect(0,0,tmpbmp.Width,tmpbmp.Height));
   end;
   mask.CopyBitmap(fBitmap,tmpbmp,false,true);
   FreeAndNil(tmpbmp);
end;
*)

procedure _ClearSelMaskEx(fIEBitmap:TIEBitmap; mask:TIEMask; Background:TColor);
var
	tmpbmp:TIEBitmap;
begin
   tmpbmp:=TIEBitmap.Create;
   tmpbmp.Allocate(mask.x2-mask.x1+1,mask.y2-mask.y1+1,fIEBitmap.PixelFormat);
   fIEBitmap.CopyRectTo(tmpbmp,mask.x1,mask.y1,0,0,tmpbmp.Width,tmpbmp.Height);
   tmpbmp.Fill(Background);
   mask.CopyIEBitmap(fIEBitmap,tmpbmp,false,true,false);
   FreeAndNil(tmpbmp);
end;

/////////////////////////////////////////////////////////////////////////////////////
// clear current selection
procedure TImageEnProc.ClearSel;
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ClearSel',ieuImage);
	GetReSel(fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask);
   if assigned(mask) and (not mask.IsEmpty) then
	   _ClearSelMaskEx(fIEBitmap,mask,GetReBackground);
	Update;
end;

// copy the DIB hbi to fBitmap
(*$ifdef IEDELPHI*)
(*
function _IECopyDIB2Bitmap2(hbi:THandle; fBitmap:TBitmap; xbits:pbyte; unlck:boolean):integer;
var
   pbi:PBITMAPINFO;
	hdb:HDRAWDIB;
   Width,Height:integer;	// image width and height
   BitCount,y:integer;	// Bitcount
   bits:pbyte;
   Compression:DWORD;	// compression type
begin
	if unlck then
   	pbi:=pointer(hbi)
   else
		pbi:=GlobalLock(hbi);
   Width:=pbi^.bmiHeader.biWidth;
   Height:=pbi^.bmiHeader.biHeight;
   BitCount:=pbi^.bmiHeader.biBitCount;
   Compression:=pbi^.bmiHeader.biCompression;
   result:=BitCount;
   fBitmap.Width:=1; fBitmap.Height:=1;
   bits:=nil;
   case BitCount of
   	1: begin
            fBitmap.PixelFormat:=pf1bit;
            bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=2;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		4: begin
				fBitmap.PixelFormat:=pf24bit;
            bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=16;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		8: begin
				fBitmap.PixelFormat:=pf24bit;
            bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=256;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		16: begin
      		fBitmap.PixelFormat:=pf24bit;
            bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
          end;
		24: begin
      		fBitmap.PixelFormat:=pf24bit;
            bits:=pbyte(pbi); inc(bits,sizeof(TBITMAPINFOHEADER));
      	 end;
		32: begin
      		fBitmap.PixelFormat:=pf24bit;
            if Compression=BI_BITFIELDS then begin
               // BITFIELDS, bitfield must be FF,00FF and 0000FF
               bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
               inc(bits,3*sizeof(dword));	// bypass bitfield
            end else if Compression=BI_RGB then begin
               bits:=pbyte(pbi);	inc(bits,sizeof(TBITMAPINFOHEADER));
            end;
      	 end;
   end;
   if xbits<>nil then bits:=xbits;
   fBitmap.Width:=Width;
   fBitmap.Height:=Height;
   if bits<>nil then begin
      hdb:=IEDrawDibOpen;
      if fBitmap.PixelFormat=pf1bit then
      	fBitmap.HandleType:=bmDDB;
      IEDrawDibDraw(hdb,fBitmap.Canvas.Handle,0,0,Width,Height,PBitmapInfoHeader(pbi)^,bits,0,0,Width,Height,0);
      if fBitmap.HandleType=bmDDB then
      	fBitmap.HandleType:=bmDIB;
      IEDrawDibClose(hdb);
   end;
   if not unlck then
	   GlobalUnLock(hbi);
end;
*)
(*$endif*)

// copy the DIB hbi to fBitmap
(*$ifdef IEDELPHI*)
function _IECopyDIB2Bitmap2Ex(hbi:THandle; fBitmap:TIEDibBitmap; xbits:pbyte; unlck:boolean):integer;
var
   pbi:PBITMAPINFO;
	hdb:HDRAWDIB;
   Width,Height:integer;	// image width and height
   BitCount,y:integer;	// Bitcount
   bits:pbyte;
   Compression:DWORD;	// compression type
begin
	if unlck then
   	pbi:=pointer(hbi)
   else
		pbi:=GlobalLock(hbi);
   Width:=pbi^.bmiHeader.biWidth;
   Height:=pbi^.bmiHeader.biHeight;
   BitCount:=pbi^.bmiHeader.biBitCount;
   Compression:=pbi^.bmiHeader.biCompression;
   result:=BitCount;
   bits:=nil;
   case BitCount of
   	1: begin
            fBitmap.AllocateBits(Width,Height,1);
            bits:=pbyte(pbi);
            inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=2;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		4: begin
				fBitmap.AllocateBits(Width,Height,24);
            bits:=pbyte(pbi);
            inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=16;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		8: begin
				fBitmap.AllocateBits(Width,Height,24);
            bits:=pbyte(pbi);
            inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
            y:=pbi^.bmiHeader.biClrUsed;
            if y=0 then y:=256;
            inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
      	end;
		16: begin
      		fBitmap.AllocateBits(Width,Height,24);
            bits:=pbyte(pbi);
            inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
          end;
		24: begin
      		fBitmap.AllocateBits(Width,Height,24);
            bits:=pbyte(pbi);
            inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
      	 end;
		32: begin
      		fBitmap.AllocateBits(Width,Height,24);
            if Compression=BI_BITFIELDS then begin
               // BITFIELDS, bitfield must be FF,00FF and 0000FF
               bits:=pbyte(pbi);
               inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
               inc(bits,3*sizeof(dword));	// bypass bitfield
            end else if Compression=BI_RGB then begin
               bits:=pbyte(pbi);
               inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
            end;
      	 end;
   end;
   if xbits<>nil then bits:=xbits;
   if bits<>nil then begin
      hdb:=IEDrawDibOpen;
      IEDrawDibDraw(hdb,fBitmap.HDC,0,0,Width,Height,PBitmapInfoHeader(pbi)^,bits,0,0,Width,Height,0);
      IEDrawDibClose(hdb);
   end;
   if not unlck then
	   GlobalUnLock(hbi);
end;
(*$endif*)


/////////////////////////////////////////////////////////////////////////////////////
// Copia la zona poligonale selezionata di Source in Dest (già creato)
// sx1..sy2: rettangolo che contiene la selezione poligonale
(*
procedure _CopyBitmapPoly(Source:TBitmap; Dest:TBitmap; sx1,sy1,sx2,sy2:integer; SelPoly:PPointArray; SelPolyCount:integer);
var
   hrgn:THandle;
   NewPoly:PPointArray;
   q,p1,p2:integer;
begin
	GetMem(NewPoly,sizeof(TPoint)*SelPolyCount);
   // translate SelPoly
	for q:=0 to SelPolyCount-1 do begin
   	if SelPoly^[q].x=IESELBREAK then
      	NewPoly^[q]:=SelPoly^[q]
      else begin
         NewPoly^[q].x:=SelPoly^[q].x-sx1;
         NewPoly^[q].y:=SelPoly^[q].y-sy1;
      end;
   end;
	//
   Dest.PixelFormat:=Source.PixelFormat;
   Dest.Width:=sx2-sx1;
   Dest.Height:=sy2-sy1;
   //dest.HandleType:=bmDDB;
   p1:=0;
   for q:=0 to SelPolyCount do
   	if (q=SelPolyCount) or (NewPoly^[q].x=IESELBREAK) then begin
      	p2:=q-p1;
         hrgn:=CreatePolygonRgn(NewPoly^[p1],p2,ALTERNATE);
         SelectClipRgn(Dest.Canvas.Handle,hrgn);
         Dest.Canvas.CopyRect(rect(0,0,Dest.width,Dest.height),Source.Canvas,rect(sx1,sy1,sx2,sy2));
         SelectClipRgn(Dest.Canvas.Handle,0);
         DeleteObject(hrgn);
         p1:=q+1;
      end;
   freemem(NewPoly);
end;
*)

/////////////////////////////////////////////////////////////////////////////////////
// Cut selected area and copy as current image
procedure TImageEnProc.CropSel;
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
	tmpbmp:TIEBitmap;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('CropSel',ieuImage);
	if GetReSel(fsx1,fsy1,fsx2,fsy2,fPolyS,fPolySCount,mask) then begin
   	if assigned(mask) and (not mask.IsEmpty) then begin
         tmpbmp:=TIEBitmap.Create;
         tmpbmp.Allocate( mask.x2-mask.x1+1 , mask.y2-mask.y1+1 , fIEBitmap.PixelFormat );
         tmpbmp.Fill(GetReBackground);
         mask.CopyIEBitmap(tmpbmp,fIEBitmap,true,false,true);
         fIEBitmap.Assign( tmpbmp );
         FreeAndNil(tmpbmp);
         // do we need alpha channel?
         fIEBitmap.AlphaChannel.SyncFull;
         if fIEBitmap.AlphaChannel.Full then
         	fIEBitmap.RemoveAlphaChannel;
      end;
   end;
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Riduce il numero di colori presenti nell'immagine
// NumColors: numero colori
// Se NumColors=2 chiama ConvertToBWOrdered or ConvertTOBWThreshold
procedure TImageEnProc.ConvertTo(NumColors:integer; DitherMethod:TIEDitherMethod);
var
	Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ConvertTo '+inttostr(NumColors),ieuImage);
   if NumColors<3 then begin
      Progress.fOnProgress:=fOnProgress;
	   Progress.Sender:=Self;
      if DitherMethod=ieOrdered then
	   	_ConvertToBWOrdered(fIEBitmap,Progress)
      else
      	_ConvertToBWThreshold(fIEBitmap,-1,Progress);
   end else if NumColors<1025 then
	   _ConvertToEx(fIEBitmap,NumColors, nil, fOnProgress, self);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Riduce il numero di colori presenti nell'immagine
// NumColors: numero colori
// Se NumColors=2 chiama ConvertToBWOrdered
procedure TImageEnProc.ConvertToPalette(NumColors:integer; Palette:pointer; DitherMethod:TIEDitherMethod);
var
	Progress:TProgressRec;
   xpal:PRGBROW;
begin
	if NumColors=0 then exit;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   xpal:=Palette;
	if fAutoUndo then
   	SaveUndoCaptioned('ConvertToPalette',ieuImage);
   if NumColors<3 then begin
      Progress.fOnProgress:=fOnProgress;
	   Progress.Sender:=Self;
      if DitherMethod=ieOrdered then
	   	_ConvertToBWOrdered(fIEBitmap,Progress)
      else
      	_ConvertToBWThreshold(fIEBitmap,-1,Progress);
      xpal[0]:=CreateRGB(0,0,0);
      xpal[1]:=CreateRGB(255,255,255);
   end else if NumColors<1025 then
	   _ConvertToEx(fIEBitmap,NumColors, Palette, fOnProgress, self);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Riduce il numero di colori presenti nell'immagine
// NumColors: numero colori
// La qualità del quantizzatore è inversamente proporzionale alla dimensione dell'immagine.
(*
procedure _ConvertTo(Bitmap:TBitmap; NumColors:integer; OutPalette: PRGBROW; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	per1:double;
   palette:PRGBROW;
   x,y,i:integer;
   e:pRGB;
   qt:TIEQuantizer;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>pf24bit then exit;
   if OutPalette=nil then
		getmem(palette,sizeof(TRGB)*NumColors)
   else
   	palette:=OutPalette;
   per1:=100/(bitmap.height+0.5);
   qt:=TIEQuantizer.Create(Bitmap, palette^, NumColors, -1,0);
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to bitmapheight1 do begin
     	e:=bitmap.ScanLine[y];
     	for x:=0 to bitmapwidth1 do begin
      	i:=qt.RGBIndex[e^];
         e^:=palette^[i];
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
   FreeAndNil(qt);
   if OutPalette=nil then
	   freemem(palette);
end;
*)

procedure _ConvertToEx(Bitmap:TIEBitmap; NumColors:integer; OutPalette: PRGBROW; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	per1:double;
   palette:PRGBROW;
   x,y,i:integer;
   e:pRGB;
   qt:TIEQuantizer;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   if OutPalette=nil then
		getmem(palette,sizeof(TRGB)*NumColors)
   else
   	palette:=OutPalette;
   per1:=100/(bitmap.height+0.5);
   qt:=TIEQuantizer.Create(Bitmap, palette^, NumColors, -1,0);
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to bitmapheight1 do begin
     	e:=bitmap.ScanLine[y];
     	for x:=0 to bitmapwidth1 do begin
      	i:=qt.RGBIndex[e^];
         e^:=palette^[i];
         inc(e);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
   FreeAndNil(qt);
   if OutPalette=nil then
	   freemem(palette);
end;

procedure _ConvertToBWOrdered(bitmap:TIEBitmap; var Progress:TProgressRec);
var
	x,y,v,b:integer;
   newbmp:TIEBitmap;
   p1:pRGB;
   p2:pbyte;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   progress.per1:=100/(bitmap.height+0.5);
   newbmp:=TIEBitmap.Create;
   newbmp.Allocate(bitmap.Width,bitmap.Height,ie1g);
   bitmapheight1:=bitmap.height-1;
   bitmapwidth1:=bitmap.width-1;
   for y:=0 to bitmapheight1 do begin
   	p1:=bitmap.ScanLine[y];
      p2:=newbmp.ScanLine[y];
		for x:=0 to bitmapwidth1 do begin
      	b:=x and 7;
      	with p1^ do begin
         	if (r>250) and (g>250) and (b>250) then
            	v:=64
            else
	      		v:=((r*21 + g*71 + b*8) div 100) SHR 2;
         end;
			if v > BWORDERPATTERN[x and 7][y and 7] then
				p2^:=p2^ or iebitmask1[b]
         else
            p2^:=p2^ and (not iebitmask1[b]);
         inc(p1);
         if b=7 then
	         inc(p2);
   	end;
      with Progress do
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
   bitmap.AssignImage( newbmp );
   FreeAndNil(newbmp);
end;


/////////////////////////////////////////////////////////////////////////////////////
// Converts current image to Black/White with ordered dithering (Bayer algorithm)
// The image must be pf24bit
procedure TImageEnProc.ConvertToBWOrdered;
var
   Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ConvertToBWOrdered',ieuImage);
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   _ConvertToBWOrdered(fIEBitmap,Progress);
   Update;
end;

// If Threshold is -1 this one is autocalculated
// bitmap: Accept all TIEPixelFormat values
procedure _ConvertToBWThreshold(bitmap:TIEBitmap; Threshold:integer; var Progress:TProgressRec);
var
   newbmp:TIEBitmap;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   newbmp:=TIEBitmap.Create;
   newbmp.Allocate(bitmap.width,bitmap.height,ie1g);
   _ConvertToBWThresholdEx(bitmap,newbmp,Threshold,Progress);
   bitmap.AssignImage( newbmp );
   FreeAndNil(newbmp);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Filter functions for resampling
function HermiteFilter(Value: double): double;
begin
	if (Value < 0.0) then Value := -Value;
   if (Value < 1.0) then Result := (2 * Value - 3) * sqr(Value) + 1
   else Result := 0.0;
end;
// Triangle filter
function TriangleFilter(Value: double): double;
begin
	if (Value < 0.0) then Value := -Value;
	if (Value < 1.0) then Result := 1.0 - Value
	else Result := 0.0;
end;
// Bell filter
function BellFilter(Value: double): double;
begin
	if (Value < 0.0) then Value := -Value;
	if (Value < 0.5) then Result := 0.75 - Sqr(Value)
	else if (Value < 1.5) then begin
		Value := Value - 1.5;
	   Result := 0.5 * Sqr(Value);
	end else
   	Result := 0.0;
end;
// B-spline filter
function SplineFilter(Value: double): double;
var
  tt: double;
begin
	if (Value < 0.0) then Value := -Value;
   if (Value < 1.0) then begin
   	tt := Sqr(Value);
   	Result := 0.5*tt*Value - tt + 2.0 / 3.0;
	end else if (Value < 2.0) then begin
      Value := 2.0 - Value;
      Result := 1.0/6.0 * Sqr(Value) * Value;
   end else
      Result := 0.0;
end;
// Lanczos3 filter
function Lanczos3Filter(Value: double): double;
	function SinC(Value: double): double;
   begin
   	if (Value <> 0.0) then begin
      	Value := Value * Pi;
      	Result := sin(Value) / Value
    	end else
      	Result := 1.0;
	end;
begin
	if (Value < 0.0) then
  		Value := -Value;
   if (Value < 3.0) then
      Result := SinC(Value) * SinC(Value / 3.0)
   else
      Result := 0.0;
end;
//
function MitchellFilter(Value: double): double;
const
	B= (1.0 / 3.0);
   C= (1.0 / 3.0);
var
   tt: double;
begin
   if (Value < 0.0) then Value := -Value;
   tt := Sqr(Value);
  	if (Value < 1.0) then begin
   	Value := (((12.0 - 9.0 * B - 6.0 * C) * (Value * tt))	+ ((-18.0 + 12.0 * B + 6.0 * C) * tt) + (6.0 - 2 * B));
   	Result := Value / 6.0;
   end else if (Value < 2.0) then begin
   	Value := (((-1.0 * B - 6.0 * C) * (Value * tt)) + ((6.0 * B + 30.0 * C) * tt) + ((-12.0 * B - 48.0 * C) * Value) + (8.0 * B + 24 * C));
  		Result := Value / 6.0;
   end else
   	Result := 0.0;
end;
// Nearest Filter
function NearestFilter(Value: Double): Double;
begin
  if (Value > -0.5) and (Value <= 0.5) then Result := 1
  else Result := 0;
end;
// Linear Filter
function LinearFilter(Value: Double): Double;
begin
  if Value < -1 then Result := 0
  else if Value < 0 then Result := 1 + Value
  else if Value < 1 then Result := 1 - Value
  else Result := 0;
end;


/////////////////////////////////////////////////////////////////////////////////////
// Converts the current image to Black/White with threshold (0..255)
// If Threshold is -1 it is automatically calculated
// The image must be pf24bit
procedure TImageEnProc.ConvertToBWThreshold(Threshold:integer);
var
   Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ConvertToBWThreshold '+inttostr(Threshold),ieuImage);
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   _ConvertToBWThreshold(fIEBitmap,Threshold,Progress);
   Update;
end;

// convert a row from 1bit to 24bit
procedure _ConvRow1To24(spx,dpx:pbyte; Width:integer);
var
	x,xx:integer;
begin
	xx:=(Width div 8)-1;
   for x:=0 to xx do begin
      CopyMemory(dpx,@(C1TO24[spx^]),24);
      inc(spx);
      inc(dpx,24);
   end;
   x:=Width and 7;
   if x<>0 then
      // copy remaining
      CopyMemory(dpx,@(C1TO24[spx^]),x*3);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Converte una TBitmap da pf1bit (SrcBitmap) in pf24bit (DstBitmap)
// note: usa tabella C1TO24
// - Dstbitmap deve essere già stata creata
procedure _Conv1to24(var SrcBitmap,DstBitmap:TBitmap; var Progress:TProgressRec);
var
	spx,dpx:pbyte;
   x,y:integer;
   xx:integer;
begin
	DstBitmap.Width:=1;
   DstBitmap.Height:=1;
	DstBitmap.PixelFormat:=pf24bit;
   DstBitmap.Width:=SrcBitmap.Width;
   DstBitmap.Height:=SrcBitmap.Height;
   xx:=(SrcBitmap.Width div 8)-1;
   progress.per1:=100/(SrcBitmap.height+0.5);
   for y:=0 to SrcBitmap.Height-1 do begin
		spx:=SrcBitmap.ScanLine[y];
      dpx:=DstBitmap.ScanLine[y];
		for x:=0 to xx do begin
			CopyMemory(dpx,@(C1TO24[spx^]),24);
	      inc(spx);
   	   inc(dpx,24);
   	end;
      x:=SrcBitmap.Width and 7;
      if x<>0 then
			// copy remaining
         CopyMemory(dpx,@(C1TO24[spx^]),x*3);
      with Progress do
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
end;

procedure _Conv1to24Ex(var SrcBitmap,DstBitmap:TIEBitmap; var Progress:TProgressRec);
var
	spx,dpx:pbyte;
   x,y:integer;
   xx:integer;
begin
   DstBitmap.Allocate(SrcBitmap.Width,SrcBitmap.Height,ie24RGB);
   xx:=(SrcBitmap.Width div 8)-1;
   progress.per1:=100/(SrcBitmap.height+0.5);
   for y:=0 to SrcBitmap.Height-1 do begin
		spx:=SrcBitmap.ScanLine[y];
      dpx:=DstBitmap.ScanLine[y];
		for x:=0 to xx do begin
			CopyMemory(dpx,@(C1TO24[spx^]),24);
	      inc(spx);
   	   inc(dpx,24);
   	end;
      x:=SrcBitmap.Width and 7;
      if x<>0 then
			// copy remaining
         CopyMemory(dpx,@(C1TO24[spx^]),x*3);
      with Progress do
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// L'immagine deve essre pf1bit
procedure TImageEnProc.ConvertTo24Bit;
var
   Progress:TProgressRec;
   ftmp:TIEBitmap;
begin
   if not MakeConsistentBitmap([ie1g]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('ConvertTo24Bit',ieuImage);
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   ftmp:=TIEBitmap.Create;
   ftmp.Assign(fIEBitmap);
   _Conv1To24Ex(ftmp,fIEBitmap,Progress);
	FreeAndNil(ftmp);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.BumpMapping(LightX,LightY,LampX,LampY,pcf:integer; Color:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
   Progress:TProgressRec;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'BumpMapping',ProcBitmap,mask) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   _BumpMapping(ProcBitmap,LightX,LightY,LampX,LampY,pcf,Color,x1,y1,x2,y2, Progress);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure _ConvertToGray(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y:integer;
   v:byte;
   ppx:pRGB;
   per1:double;
begin
	if bitmap.Pixelformat<>ie24RGB then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   for y:=fSelY1 to fSelY2 do begin
     	ppx:=bitmap.ScanLine[y];
      inc(ppx,fSelX1);
     	for x:=fSelX1 to fSelX2 do begin
        with ppx^ do begin
           v:=(r*21 + g*71 + b*8) div 100;
	        r:=v;  g:=v; b:=v;
        end;
        inc(ppx);
 	   end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// LightX,LightY: posizione centro luce
// LAmpX,LAmpY: larghezza luce (in pixel)
// pcf: percentuale di applicazione dell'effetto
// Color: colore bump
procedure _BumpMapping(Bitmap:TIEBitmap; LightX,LightY,LAmpX,LAmpY,pcf:integer; Color:TRGB; fselx1,fsely1,fselx2,fsely2:integer; var Progress:TProgressRec);
type
	tenvmap=array [0..255,0..255] of byte;
   penvmap=^tenvmap;
var
	envmap:penvmap;
   x,y:integer;
   dnx,dny,dnz:double;
   nx,ny:integer;
   px1:pRGB;
   b1:pbyte;
   l1,l2,l3:pbytearray;
   bumpmap:TIEBitmap;
   lx,ly:integer;
   e:integer;
   c1,c2,c3:double;
   cr,cg,cb:double;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   if (LAmpX=0) or (LAmpY=0) then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   Progress.per1:=100/(fSelY2-fSelY1+0.5);
	// calc environment map
   getmem(envmap,256*256);
	for x:=0 to 255 do
   	for y:=0 to 255 do begin
			dnx:=(x-128)/128;
         dny:=(y-128)/128;
         dnz:=1-sqrt(dnx*dnx+dny*dny);
         if dnz<0 then dnz:=0;
         envmap^[x,y]:=trunc(dnz*256);
      end;
   // create bumpmap
	bumpmap:=TIEBitmap.Create;
   bumpmap.Allocate(bitmap.width,bitmap.height,ie8g);
   for y:=fSelY1 to fSelY2 do begin
     	px1:=bitmap.ScanLine[y];
      b1:=bumpmap.ScanLine[y];
      inc(px1,fSelX1);
      inc(b1,fSelX1);
     	for x:=fSelX1 to fSelX2 do begin
        with px1^ do
	        b1^:=(r*21 + g*71 + b*8) div 100;
        inc(px1);
        inc(b1);
 	   end;
   end;
   // make bump mapping
   c1:=pcf/100;
   c3:=(100-pcf)/100;
   cr:=Color.r/255;
   cg:=Color.g/255;
   cb:=Color.b/255;
   for y:=fSelY1 to fSelY2 do begin
     	px1:=bitmap.ScanLine[y];
      inc(px1,fSelX1);
      l1:=bumpmap.ScanLine[imax(y-1,0)];
      l2:=bumpmap.ScanLine[y];
      l3:=bumpmap.ScanLine[imin(y+1,fSelY2)];
     	for x:=fSelX1 to fSelX2 do begin
         nx:=l2^[imin(x+1,fSelX2)]-l2^[imax(x-1,fSelX1)];
         ny:=l3^[x]-l1[x];
         nx:=blimit(nx+128-trunc((x-LightX)/LAmpX*128));
         ny:=blimit(ny+128-trunc((y-LightY)/LAmpY*128));
			with px1^ do begin
            c2:=envmap[nx,ny]*c3;
				r:=blimit(round(r*c1+c2*cr));
            g:=blimit(round(g*c1+c2*cg));
            b:=blimit(round(b*c1+c2*cb));
         end;
      	inc(px1);
 	   end;
      with Progress do
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
	//
   FreeAndNil(bumpmap);
   freemem(envmap);
end;

// ret True is angle is 90,180,270,360 etc
function IsRectAngle(angle:double):boolean;
begin
	result:= (trunc(angle)=angle) and ( (trunc(angle) mod 90)=0 );
end;

// angle hasn't limits
// anticlockwise
procedure TImageEnProc.Rotate(fangle:double; antialias:boolean; AntialiasMode:TIEAntialiasMode; BackgroundColor:TColor);
var
	alpha:TIEBitmap;
   bcol:TColor;
begin
	if fangle=0 then exit;
   if not MakeConsistentBitmap([]) then
      exit;
   if fAutoUndo then
      SaveUndoCaptioned('Rotate '+floattostr(fangle),ieuImage);
   if BackgroundColor=-1 then
   	bcol:=GetReBackGround
   else
   	bcol:=BackgroundColor;
   if fIEBitmap.HasAlphaChannel then begin
      alpha:=TIEBitmap.Create;
      alpha.Assign(fIEBitmap.AlphaChannel);
	end else
   	alpha:=nil;
   if (not antialias) or (AntialiasMode=ierFast) or IsRectAngle(fangle) or (fIEBitmap.PixelFormat<>ie24RGB) then begin
      if assigned(alpha) then begin
      	if fIEBitmap.PixelFormat=ie1g then
         	_rotate8bit(alpha,fangle,0)
         else
				_RotateEx8(alpha,fangle,antialias,0,fOnProgress,self);
      end;
	   _RotateEx(fIEBitmap,fangle,antialias,TColor2TRGB(bcol),fOnProgress,self);
   end else begin
   	if assigned(alpha) then
         _IEQRotate8(alpha,fangle,0,AntialiasMode);
		_IEQRotate(fIEBitmap,fangle,bcol,AntialiasMode,fOnProgress,self);
   end;
   if assigned(alpha) then begin
      fIEBitmap.AlphaChannel.Assign(alpha);
      FreeAndNil(alpha);
   end;
   Update;
end;

// accept TIEBitmap and works only with ie24RGB and ie1g
procedure _RotateEx(fBitmap:TIEBitmap; fangle:double; antialias:boolean; Background:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
const
	SCALE=4096;
   HALFSCALE=2048;
var
	rangle:double;	// angle in radiants
   bakBitmap:tiebitmap;
	xshearfac, yshearfac, new0:double;
   cols,rows,tempcols,yshearjunk,newrows,x2shearjunk,newcols,row,intnew0:integer;
   col,fracnew0,omfracnew0,neww,xnew:integer;
   bgxel,prevxel,xel:TRGB;
   temp1xels,temp2xels:pRGBROW;
   xP,nxP:pRGB;
   ppx,ppx2:pRGB;
   Progress:TProgressRec;
   iangle:integer;
   nullpr:TProgressRec;
   per:double;
begin
   if fangle=0 then exit;
	if fbitmap.PixelFormat=ie24RGB then begin
      iangle:=trunc(fangle*1000);
   	iangle:=iangle mod 360000;
      fangle:=iangle/1000;
   	bakBitmap:=tiebitmap.create;
      //
   	if (fangle>=-45) and (fangle<=45) then
         bakBitmap.AssignImage(fBitmap);
      // ruota di 90 gradi finchè l'angolo non è uguale o inferiore a 45 gradi
   	while fangle>45 do begin
      	fangle:=fangle-90;
			_Rot90Ex(fBitmap,bakbitmap);
         if fangle<=45 then
         	break;
         fBitmap.AssignImage(bakBitmap);
      end;
      // ruota di -90 gradi finchè l'angolo non è uguale o inferiore a -45 gradi
   	while fangle<-45 do begin
      	fangle:=fangle+90;
			_Rot90oEx(fBitmap,bakbitmap);
         if fangle>=-45 then
         	break;
         fBitmap.AssignImage(bakbitmap);
      end;
      if fangle=0 then begin
         fBitmap.AssignImage(bakBitmap);
         FreeAndNil(bakbitmap);
         exit;
      end;
      // ora fangle è compreso nel range -45...45
      // in bakbitmap c'è l'immagine su cui lavorare
		rangle:=fangle*PI/180;		// converte fangle in radianti
	   cols:=bakbitmap.Width;				// colonne immagine originale
      rows:=bakbitmap.Height;				// righe immagine originale
	   xshearfac:= abs( sin(rangle/2) / cos(rangle/2) );	// shear orizzontale
	   yshearfac:= abs( sin(rangle) );							// shear verticale
      tempcols:=round(rows*xshearfac+cols+1);	// colonne nel buffer di shear orizzontale
      yshearjunk:=round( (tempcols-cols)*yshearfac );
      newrows:= round( tempcols*yshearfac+rows+1 );
      x2shearjunk:= round( (newrows-rows-yshearjunk)*xshearfac );
      newrows := round( newrows-(2 * yshearjunk) );
      newcols := round( newrows * xshearfac + tempcols + 1 - 2 * x2shearjunk );
      per:=100/(rows+tempcols+newrows);
      /////// FASE-1, shear orizzontale
      bgxel:=Background;				// colore di riempimento
      getmem(temp1xels,tempcols*rows*3);		// buffer di shear orizzontale
		for row:=0 to rows-1 do begin
			if rangle>0 then
         	new0:=row*xshearfac
         else
         	new0:=(rows-row)*xshearfac;
         intnew0:=round(new0);
         if antialias then begin
         	// ANTIALIAS (ottimizzare)
            fracnew0:=trunc((new0-intnew0)*SCALE);
			   omfracnew0:=trunc(SCALE-fracnew0);
            nxP:=@temp1xels[row*tempcols];
            for col:=0 to tempcols-1 do begin
					nxP^ := bgxel;
               inc(nxP);
            end;
			   prevxel:=bgxel;
            nxP := @(temp1xels[row*tempcols+intnew0]);
            xP:=pRGB(bakbitmap.scanline[row]);
			   for col:=0 to cols-1 do begin
            	nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0* xP^.r+HALFSCALE)/SCALE));
               nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0* xP^.g+HALFSCALE)/SCALE));
               nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0* xP^.b+HALFSCALE)/SCALE));
					prevxel:=xP^;
               inc(nxP);
               inc(xP);
				end;
			   if (fracnew0 > 0) and (intnew0+cols < tempcols) then begin
            	nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0* bgxel.r+HALFSCALE)/SCALE));
					nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0* bgxel.g+HALFSCALE)/SCALE));
               nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0* bgxel.b+HALFSCALE)/SCALE));
				end
         end else begin
         	// NO ANTIALIAS
				// riempie la parte sinistra con Background
            nxP:=@(temp1xels[row*tempcols]);
            for col:=0 to intnew0-1 do begin
            	nxP^:=bgxel;
               inc(nxP);
            end;
            // copia la parte dell'immagine
				CopyMemory(nxP,bakbitmap.scanline[row],cols*3);
            inc(nxP,cols);
            // riempie la parte restante con Background
            for col:=(intnew0+cols) to tempcols-1 do begin
            	nxP^:=bgxel;
               inc(nxP);
            end;
         end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(row)));
      end;
      /////// FASE-2, shear verticale
      getmem(temp2xels,tempcols*newrows*3);
      for col:=0 to tempcols-1 do begin
         if rangle>0 then
         	new0:=(tempcols-col)*yshearfac
         else
         	new0:=(col*yshearfac);
         intnew0:=round(new0);
			fracnew0:=round((new0-intnew0)*SCALE);
         omfracnew0:=SCALE-fracnew0;
         dec(intnew0,yshearjunk);
			// riempe la colonna col del colore di background
         for row:=0 to newrows-1 do
         	temp2xels[row*tempcols+col]:=bgxel;
         if antialias then begin
         	// ANTIALIAS
         	prevxel:=bgxel;
	   		for row:=0 to rows-1 do begin
					xnew:=row+intnew0;
					if (xnew>=0) and (xnew<newrows) then begin
						nxP := @temp2xels[xnew*tempcols+col];
					   xel := temp1xels[row*tempcols+col];
						nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0*xel.r+HALFSCALE)/SCALE));
						nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0*xel.g+HALFSCALE)/SCALE));
                  nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0*xel.b+HALFSCALE)/SCALE));
					   prevxel:=xel;
		   	   end;
				end;
		  	   if (fracnew0>0) and (intnew0+rows<newrows) then begin
					nxP:=@temp2xels[(intnew0+rows)*tempcols+col];
               nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0*bgxel.r+HALFSCALE)/SCALE));
               nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0*bgxel.g+HALFSCALE)/SCALE));
               nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0*bgxel.b+HALFSCALE)/SCALE));
				end;
         end else begin
         	// NO ANTIALIAS
            // trasla le colonne verticalmente
            for row:=0 to rows-1 do begin
            	neww:=row+intnew0;
               if (neww>=0) and (neww<newrows) then
               	temp2xels[neww*tempcols+col]:=temp1xels[row*tempcols+col];
            end;
         end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(rows+col)));
      end;
      freemem(temp1xels);
		/////// FASE-3, shear orizzontale
      fbitmap.height:=newrows;
      fbitmap.width:=newcols;
      fbitmap.fill(TRGB2TColor(Background));
      for row:=0 to newrows-1 do begin
			if rangle > 0 then
         	new0 := row*xshearfac
			else
	   		new0 := (newrows-row)*xshearfac;
         intnew0:=round(new0);
         fracnew0:=round((new0-intnew0)*SCALE);
         omfracnew0:=SCALE-fracnew0;
         dec(intnew0,x2shearjunk);
			if antialias then begin
         	// ANTIALIAS
			   prevxel:=bgxel;
            xP:=@temp2xels[row*tempcols];
            ppx:=fbitmap.scanline[row];
	   		for col:=0 to tempcols-1 do begin
					neww:=intnew0+col;
					if (neww>=0) and (neww<newcols) then begin
                   nxP:=ppx;
                   inc(nxP,neww);
                   //
                   nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0*xP^.r+HALFSCALE)/SCALE));
                   nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0*xP^.g+HALFSCALE)/SCALE));
                   nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0*xP^.b+HALFSCALE)/SCALE));
		   			 prevxel:=xP^;
               end;
               inc(xP);
				end;
			   if (fracnew0>0) and (intnew0+tempcols<newcols) then begin
					nxP:=ppx;
               inc(nxP,(intnew0+tempcols));
					//
               nxP^.r:=blimit(round((fracnew0*prevxel.r+omfracnew0*bgxel.r+HALFSCALE)/SCALE));
               nxP^.g:=blimit(round((fracnew0*prevxel.g+omfracnew0*bgxel.g+HALFSCALE)/SCALE));
               nxP^.b:=blimit(round((fracnew0*prevxel.b+omfracnew0*bgxel.b+HALFSCALE)/SCALE));
				end;
            //
         end else begin
         	// NO ANTIALIAS
         	xP := pRGB(@(temp2xels[row*tempcols]));
            ppx:=fbitmap.scanline[row];
			   for col := 0 to tempcols-1 do begin
					neww := intnew0 + col;
					if (neww >= 0) and (neww < newcols ) then begin
                  ppx2:=ppx;
                  inc(ppx2,neww);
                  ppx2^:=xP^;
               end;
               inc(xP);
				end;
	      end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(rows+tempcols+row)));
	   end; // ciclo row
      freemem(temp2xels);
		FreeAndNil(bakBitmap);
   end else begin
   	// ie1g
      nullpr.Aborting:=nil;
      nullpr.Sender:=Sender;
      nullpr.fOnProgress:=fOnProgress;
      if (BackGround.r<>0) and (background.g<>0) and (background.b<>0) then
         _rotate1bitEx(fBitmap,fangle,1,nullpr)
      else
         _rotate1bitEx(fBitmap,fangle,0,nullpr);
   end;
end;

// accept ie8g and ie8p
procedure _RotateEx8(fBitmap:TIEBitmap; fangle:double; antialias:boolean; Background:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
const
	SCALE=4096;
   HALFSCALE=2048;
var
	rangle:double;	// angle in radiants
   bakBitmap:tiebitmap;
	xshearfac, yshearfac, new0:double;
   cols,rows,tempcols,yshearjunk,newrows,x2shearjunk,newcols,row,intnew0:integer;
   col,fracnew0,omfracnew0,neww,xnew:integer;
   bgxel,prevxel,xel:byte;
   temp1xels,temp2xels:pbytearray;
   xP,nxP:pbyte;
   ppx,ppx2:pbyte;
   Progress:TProgressRec;
   iangle:integer;
   nullpr:TProgressRec;
   per:double;
begin
   if fangle=0 then exit;
	if (fbitmap.PixelFormat=ie8g) or (fBitmap.PixelFormat=ie8p) then begin
      iangle:=trunc(fangle*1000);
   	iangle:=iangle mod 360000;
      fangle:=iangle/1000;
   	bakBitmap:=tiebitmap.create;
      //
   	if (fangle>=-45) and (fangle<=45) then
         bakBitmap.AssignImage(fBitmap);
      // ruota di 90 gradi finchè l'angolo non è uguale o inferiore a 45 gradi
   	while fangle>45 do begin
      	fangle:=fangle-90;
			_Rot90Ex8(fBitmap,bakbitmap);
         if fangle<=45 then
         	break;
         fBitmap.Assign(bakBitmap);
      end;
      // ruota di -90 gradi finchè l'angolo non è uguale o inferiore a -45 gradi
   	while fangle<-45 do begin
      	fangle:=fangle+90;
			_Rot90oEx8(fBitmap,bakbitmap);
         if fangle>=-45 then
         	break;
         fBitmap.Assign(bakbitmap);
      end;
      if fangle=0 then begin
         fBitmap.Assign(bakBitmap);
         FreeAndNil(bakbitmap);
         exit;
      end;
      // ora fangle è compreso nel range -45...45
      // in bakbitmap c'è l'immagine su cui lavorare
		rangle:=fangle*PI/180;		// converte fangle in radianti
	   cols:=bakbitmap.Width;				// colonne immagine originale
      rows:=bakbitmap.Height;				// righe immagine originale
	   xshearfac:= abs( sin(rangle/2) / cos(rangle/2) );	// shear orizzontale
	   yshearfac:= abs( sin(rangle) );							// shear verticale
      tempcols:=round(rows*xshearfac+cols+1);	// colonne nel buffer di shear orizzontale
      yshearjunk:=round( (tempcols-cols)*yshearfac );
      newrows:= round( tempcols*yshearfac+rows+1 );
      x2shearjunk:= round( (newrows-rows-yshearjunk)*xshearfac );
      newrows := round( newrows-(2 * yshearjunk) );
      newcols := round( newrows * xshearfac + tempcols + 1 - 2 * x2shearjunk );
      per:=100/(rows+tempcols+newrows);
      /////// FASE-1, shear orizzontale
      bgxel:=Background;				// colore di riempimento
      getmem(temp1xels,tempcols*rows);		// buffer di shear orizzontale
		for row:=0 to rows-1 do begin
			if rangle>0 then
         	new0:=row*xshearfac
         else
         	new0:=(rows-row)*xshearfac;
         intnew0:=round(new0);
         if antialias then begin
         	// ANTIALIAS (ottimizzare)
            fracnew0:=trunc((new0-intnew0)*SCALE);
			   omfracnew0:=trunc(SCALE-fracnew0);
            nxP:=@temp1xels[row*tempcols];
            for col:=0 to tempcols-1 do begin
					nxP^ := bgxel;
               inc(nxP);
            end;
			   prevxel:=bgxel;
            nxP := @(temp1xels[row*tempcols+intnew0]);
            xP:=pbyte(bakbitmap.scanline[row]);
			   for col:=0 to cols-1 do begin
            	nxP^:=blimit(round((fracnew0*prevxel+omfracnew0* xP^+HALFSCALE)/SCALE));
					prevxel:=xP^;
               inc(nxP);
               inc(xP);
				end;
			   if (fracnew0 > 0) and (intnew0+cols < tempcols) then
            	nxP^:=blimit(round((fracnew0*prevxel+omfracnew0* bgxel+HALFSCALE)/SCALE));
         end else begin
         	// NO ANTIALIAS
				// riempie la parte sinistra con Background
            nxP:=@(temp1xels[row*tempcols]);
            for col:=0 to intnew0-1 do begin
            	nxP^:=bgxel;
               inc(nxP);
            end;
            // copia la parte dell'immagine
				CopyMemory(nxP,bakbitmap.scanline[row],cols);
            inc(nxP,cols);
            // riempie la parte restante con Background
            for col:=(intnew0+cols) to tempcols-1 do begin
            	nxP^:=bgxel;
               inc(nxP);
            end;
         end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(row)));
      end;
      /////// FASE-2, shear verticale
      getmem(temp2xels,tempcols*newrows);
      for col:=0 to tempcols-1 do begin
         if rangle>0 then
         	new0:=(tempcols-col)*yshearfac
         else
         	new0:=(col*yshearfac);
         intnew0:=round(new0);
			fracnew0:=round((new0-intnew0)*SCALE);
         omfracnew0:=SCALE-fracnew0;
         dec(intnew0,yshearjunk);
			// riempe la colonna col del colore di background
         for row:=0 to newrows-1 do
         	temp2xels[row*tempcols+col]:=bgxel;
         if antialias then begin
         	// ANTIALIAS
         	prevxel:=bgxel;
	   		for row:=0 to rows-1 do begin
					xnew:=row+intnew0;
					if (xnew>=0) and (xnew<newrows) then begin
						nxP := @temp2xels[xnew*tempcols+col];
					   xel := temp1xels[row*tempcols+col];
						nxP^:=blimit(round((fracnew0*prevxel+omfracnew0*xel+HALFSCALE)/SCALE));
					   prevxel:=xel;
		   	   end;
				end;
		  	   if (fracnew0>0) and (intnew0+rows<newrows) then begin
					nxP:=@temp2xels[(intnew0+rows)*tempcols+col];
               nxP^:=blimit(round((fracnew0*prevxel+omfracnew0*bgxel+HALFSCALE)/SCALE));
				end;
         end else begin
         	// NO ANTIALIAS
            // trasla le colonne verticalmente
            for row:=0 to rows-1 do begin
            	neww:=row+intnew0;
               if (neww>=0) and (neww<newrows) then
               	temp2xels[neww*tempcols+col]:=temp1xels[row*tempcols+col];
            end;
         end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(rows+col)));
      end;
      freemem(temp1xels);
		/////// FASE-3, horizontal shear
      fbitmap.height:=newrows;
      fbitmap.width:=newcols;
      fbitmap.fill(Background);
      for row:=0 to newrows-1 do begin
			if rangle > 0 then
         	new0 := row*xshearfac
			else
	   		new0 := (newrows-row)*xshearfac;
         intnew0:=round(new0);
         fracnew0:=round((new0-intnew0)*SCALE);
         omfracnew0:=SCALE-fracnew0;
         dec(intnew0,x2shearjunk);
			if antialias then begin
         	// ANTIALIAS
			   prevxel:=bgxel;
            xP:=@temp2xels[row*tempcols];
            ppx:=fbitmap.scanline[row];
	   		for col:=0 to tempcols-1 do begin
					neww:=intnew0+col;
					if (neww>=0) and (neww<newcols) then begin
                   nxP:=ppx;
                   inc(nxP,neww);
                   //
                   nxP^:=blimit(round((fracnew0*prevxel+omfracnew0*xP^+HALFSCALE)/SCALE));
		   			 prevxel:=xP^;
               end;
               inc(xP);
				end;
			   if (fracnew0>0) and (intnew0+tempcols<newcols) then begin
					nxP:=ppx;
               inc(nxP,(intnew0+tempcols));
					//
               nxP^:=blimit(round((fracnew0*prevxel+omfracnew0*bgxel+HALFSCALE)/SCALE));
				end;
            //
         end else begin
         	// NO ANTIALIAS
         	xP := pbyte(@(temp2xels[row*tempcols]));
            ppx:=fbitmap.scanline[row];
			   for col := 0 to tempcols-1 do begin
					neww := intnew0 + col;
					if (neww >= 0) and (neww < newcols ) then begin
                  ppx2:=ppx;
                  inc(ppx2,neww);
                  ppx2^:=xP^;
               end;
               inc(xP);
				end;
	      end;
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per*(rows+tempcols+row)));
	   end; // ciclo row
      freemem(temp2xels);
		FreeAndNil(bakBitmap);
   end;
end;


////////////////////////////////////////////////////////////////////////////////////////
// xx,yy: centro della lente
// width,height: larghezza e altezza della lente
// refraction: rifrazione (1.7)
procedure _lens(Bitmap:TIEBitmap; xx,yy:integer; width,height:integer; refraction:double; var Progress:TProgressRec);
   procedure find_projected_pos(refraction:double; a, b, x, y:double; projx, projy:pdouble);
   var
      c:double;
      n:array [0..2] of double;
      nxangle, nyangle, theta1, theta2:double;
      ri1,ri2:double;
   begin
      ri1:=1.0;
      ri2:=refraction;
      c := dmin(a, b);
      n[0] := x;
      n[1] := y;
      n[2] := sqrt((1-x*x/(a*a)-y*y/(b*b))*(c*c));
      nxangle := cos(n[0]/sqrt(n[0]*n[0]+n[2]*n[2]));
      theta1 := PI/2 - nxangle;
      theta2 := asin(sin(theta1)*ri1/ri2);
      theta2 := PI/2 - nxangle - theta2;
      projx^ := x - tan(theta2)*n[2];
      nyangle := acos(n[1]/sqrt(n[1]*n[1]+n[2]*n[2]));
      theta1 := PI/2 - nyangle;
      theta2 := asin(sin(theta1)*ri1/ri2);
      theta2 := PI/2 - nyangle - theta2;
      projy^ := y - tan(theta2)*n[2];
   end;
var
   row:integer;
   i, col,scol,srow:integer;
   regionwidth,regionheight:integer;
   dx, dy, xsqr, ysqr:double;
   a, b, asqr, bsqr, x, y:double;
   bgr_red, bgr_blue, bgr_green, alphaval:byte;
   origbmp,destbmp:TIEBitmap;
   src,dest:pPRGBArray;	// lista di puntatori a scanline (verticale)
   x1,y1,x2,y2:integer;
   bitmapwidth1,bitmapheight1:integer;
begin
	if Bitmap.Pixelformat<>ie24RGB then exit;
   x1:=xx-(width div 2);
   y1:=yy-(height div 2);
   x2:=xx+(width div 2);
   y2:=yy+(height div 2);
   x1:=ilimit(x1,0,bitmap.width-1);
   y1:=ilimit(y1,0,bitmap.height-1);
   x2:=ilimit(x2,0,bitmap.width-1);
   y2:=ilimit(y2,0,bitmap.height-1);
   if Refraction<1 then Refraction:=1;
   Progress.per1:=100/(Y2-Y1+0.5);
	//
   regionwidth := x2-x1;
   a := regionwidth/2;
   regionheight := y2-y1;
   b := regionheight/2;
   asqr := a*a;
   bsqr := b*b;
   destbmp:=TIEBitmap.Create;
   destbmp.Location:=ieMemory;   // needed to set dest[]
   destbmp.Allocate(x2-x1,y2-y1,ie24RGB);
   origbmp:=TIEBitmap.Create;
   origbmp.Location:=ieMemory;   // needed to set src[]
   origbmp.AssignImage( Bitmap );
   // costruisce puntatori a linee
   getmem(src,origbmp.height*sizeof(pRGB));
   for row:=0 to origbmp.height-1 do
		src[row]:=origbmp.scanline[row];
   getmem(dest,destbmp.height*sizeof(pRGB));
   for row:=0 to destbmp.height-1 do
		dest[row]:=destbmp.scanline[row];
   //
   bitmapwidth1:=origbmp.width-1;
   bitmapheight1:=origbmp.height-1;
   for col:=0 to regionwidth-1 do begin
		dx := col - a + 0.5;
		xsqr := dx*dx;
      for row:=0 to regionheight-1 do begin
	      dy := -(row - b) - 0.5;
	      ysqr := dy*dy;
	      if (ysqr < (bsqr - (bsqr*xsqr)/asqr)) then begin
				find_projected_pos(refraction,a, b, dx, dy, @x, @y);
				y := -y;
            srow:=trunc(y+b); srow:=ilimit(srow,0,bitmapheight1);
            scol:=trunc(x+a); scol:=ilimit(scol,0,bitmapwidth1);
            PRGBROW(dest^[row])[col]:=PRGBROW(src^[y1+srow])[x1+scol];
	      end else
				PRGBROW(dest^[row])[col]:=PRGBROW(src^[y1+row])[x1+col];
		end;
      with Progress do
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(col-X1+1)));
	end;
   destbmp.CopyRectTo(Bitmap,0,0,x1,y1,destbmp.Width,destbmp.Height);
   FreeAndNil(destbmp);
   FreeAndNil(origbmp);
   freemem(dest);
   freemem(src);
end;

/////////////////////////////////////////////////////////////////////////////////////
// cx,cy: lens center
// Width,Height: larghezza e altezza lente
// Refraction: rifrazione (da 1)
procedure TImageEnProc.Lens(cx,cy,Width,Height:integer; Refraction:double);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
   Progress:TProgressRec;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Lens',ProcBitmap,mask) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   _lens(ProcBitmap,cx,cy,Width,Height,Refraction,Progress);
   EndImageProcessing(ProcBitmap,mask);
end;

/////////////////////////////////////////////////////////////////////////////////////
// riassegna fBitmap (chiamato dal meccanismo RegisterBitmapChangeEvent)
procedure TImageEnProc.OnBitmapChange(Sender:TObject; destroying:boolean);
begin
	if destroying then begin
   	fImageEnView:=nil;
	end else if assigned(fImageEnView) then begin
   	fBitmap:=fImageEnView.Bitmap;
   	if fIEBitmapCreated then
      	fIEBitmap.EncapsulateTBitmap(fBitmap,true)
      else begin
         fIEBitmap:=fImageEnView.IEBitmap;
         if assigned(fIEbitmap) then
            fBitmap:=nil;	// both fBitmap and fIEBitmap aren't allowed if not encapsulated
      end;
   end;
end;

// return <>0 if active /   0=disattive
//result:=pbytearray(row)^[pix shr 3] and bitmask[pix and $7];
function _GetPixelbw(row:pbyte; pix:integer):integer;
begin
	result:=pbytearray(row)^[pix shr 3] and iebitmask1[pix and $7];
   (*
   asm
   	mov edx, pix
      mov esi, [row]
      shr edx, 3
		mov ecx, dword ptr [esi+edx]
      mov edx, pix
		and edx, 7
      mov eax, 7
      sub eax, edx
      bt ecx, eax
      setc al
      mov @result,eax
   end;
   *)
end;

/////////////////////////////////////////////////////////////////////////////////////
// Set pixel "pix" to vv (<>0=1 0=0)
procedure _SetPixelbw(row:pbyte; pix:integer; vv:integer);
var
   bp:pbyte;
begin
   bp:=pbyte(dword(row)+(dword(pix) shr 3));
   if vv<>0 then
		bp^:=bp^ or iebitmask1[pix and 7]
   else
   	bp^:=bp^ and not iebitmask1[pix and 7];
end;

// fBitmap.PixelFormat must be ie1g
procedure _rotate1bitex(fBitmap:TIEBitmap; angle:double; background:integer; var Progress:TProgressRec);
var
   xrotimage:TIEBitmap;
   nx,ny,newheight,newwidth,oldheight,oldwidth,i,j,x,x7,x6,y,w,xl,x3:integer;
   halfnewheight,halfnewwidth,halfoldheight,halfoldwidth:double;
   radians:double;
   cosval,sinval:double;
   drow,bp,newb,oldb,tbuf:pbyte;
   anx,any:pintegerarray;
begin
   oldheight := fBitmap.height;
   oldwidth := fBitmap.width;
   xrotimage:=TIEBitmap.Create;
   xrotimage.Location:=ieMemory;
   if (angle=90) or (angle=-90) or (angle=270) or (angle=180) or (angle=-180) then begin
      if angle=90 then begin
         // +90
         newwidth := oldheight;
         newheight := oldwidth;
         xrotimage.allocate(newwidth,newheight,ie1g);
         xrotimage.Fill(0);
         for x:=0 to oldwidth-1 do begin
            drow:=xrotimage.ScanLine[oldwidth-x-1];
            x7:=iebitmask1[x and $7];
            x3:=x shr 3;
            for y:=0 to oldheight-1 do begin
               if (pbytearray(fBitmap.Scanline[y])[x3] and x7)<>0 then begin
                  bp:=pbyte(dword(drow)+(dword(y) shr 3));
                  bp^:=bp^ or (iebitmask1[y and 7]);
               end;
            end;
         end;
      end else if (angle=-90) or (angle=270) then begin
         // -90, 270
         newwidth := oldheight;
         newheight := oldwidth;
         xrotimage.allocate(newwidth,newheight,ie1g);
         xrotimage.Fill(0);
         for x:=0 to oldwidth-1 do begin
            drow:=xrotimage.ScanLine[x];
            x7:=iebitmask1[x and $7];
            x3:=x shr 3;
            for y:=0 to oldheight-1 do
               if (pbytearray(fBitmap.Scanline[oldheight-y-1])[x3] and x7)<>0 then begin
                  bp:=pbyte(dword(drow)+(dword(y) shr 3));
                  bp^:=bp^ or (iebitmask1[y and 7]);
               end;
         end;
      end else if (angle=180) or (angle=-180) then begin
         // 180, -180
         newwidth := oldwidth;
         newheight := oldheight;
         xrotimage.allocate(newwidth,newheight,ie1g);
         w:=oldwidth div 8;
         if (oldwidth and 7)<>0 then begin
            inc(w);
            xl:=8-(oldwidth and 7); // we need to shift left the image
         end else xl:=0;
         if xl=0 then begin
            for y:=0 to oldheight-1 do begin
               newb:=xrotimage.ScanLine[y];
               oldb:=fBitmap.Scanline[oldheight-1-y];
               inc(oldb,w-1);
               for x:=0 to w-1 do begin
                  newb^:=oldb^;
                  ReverseBitsB(newb^);
                  inc(newb);
                  dec(oldb);
               end;
            end;
         end else begin
            // need to shift
            getmem(tbuf,w);
            for y:=0 to oldheight-1 do begin
               newb:=tbuf;
               oldb:=fBitmap.Scanline[oldheight-1-y];
               inc(oldb,w-1);
               for x:=0 to w-1 do begin
                  newb^:=oldb^;
                  ReverseBitsB(newb^);
                  inc(newb);
                  dec(oldb);
               end;
               _copybits(xrotimage.scanline[y],tbuf,0,xl,oldWidth,w);
            end;
            freemem(tbuf);
         end;
      end;
   end else begin
      radians :=  -(angle) / ((180 / PI));
      cosval := trunc(cos(radians)*10000)/10000;
      sinval := trunc(sin(radians)*10000)/10000;
      newwidth := trunc(abs(oldwidth*cosval) + abs(oldheight*sinval));
      newheight := trunc(abs(-oldwidth*sinval) + abs(oldheight*cosval));
      halfnewheight := newheight / 2 -0.5;
      halfnewwidth := newwidth / 2 -0.5;
      halfoldwidth := oldwidth / 2 -0.5;
      halfoldheight := oldheight / 2 -0.5;
      xrotimage.allocate(newwidth,newheight,ie1g);
      //
      Progress.per1:=100/(newheight);
      xrotimage.Fill(0);
      getmem(anx,sizeof(integer)*newwidth);
      getmem(any,sizeof(integer)*newwidth);
      for j:=0 to newwidth-1 do begin
         anx[j]:=trunc( (j-halfnewwidth)*cosval );
         any[j]:=trunc( (0-(j - halfnewwidth))*sinval );
      end;
      for i:=0 to newheight-1 do begin
         drow:=xrotimage.scanline[i];
         x6:=trunc((i-halfnewheight)*sinval+halfoldwidth);
         x7:=trunc((i-halfnewheight)*cosval+halfoldheight);
         for j:=0 to newwidth-1 do begin
            nx := anx[j]+x6;
            ny := any[j]+x7;
            if ((nx < oldwidth) and (ny < oldheight) and (nx >= 0) and (ny >= 0)) then begin
               if (pbytearray(fBitmap.Scanline[ny])^[nx shr 3] and iebitmask1[nx and $7])<>0 then begin
                  bp:=pbyte(dword(drow)+(dword(j) shr 3));
                  bp^:=bp^ or (iebitmask1[j and 7]);
               end;
            end else if background<>0 then begin
               bp:=pbyte(dword(drow)+(dword(j) shr 3));
               bp^:=bp^ or (iebitmask1[j and 7]);
            end;
         end;
         with Progress do
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*i));
      end;
      freemem(anx);
      freemem(any);
   end;
   fBitmap.Assign(xrotimage);
   FreeAndNil(xrotimage);
end;

procedure _rotate1bit(fBitmap:TBitmap; angle:double; background:integer; var Progress:TProgressRec);
var
   bmp:TIEBitmap;
begin
   bmp:=TIEBitmap.Create;
   bmp.EncapsulateTBitmap(fBitmap,true);
   _rotate1bitex(bmp,angle,background,Progress);
   FreeAndNil(bmp);
end;

// fBitmap must be ie8g or ie8p
procedure _rotate8bit(fBitmap:TIEBitmap; angle:double; background:integer);
var
   xrotimage:TIEBitmap;
   nx,ny,newheight,newwidth,oldheight,oldwidth,i,j,x,x7,x6,y:integer;
   halfnewheight,halfnewwidth,halfoldheight,halfoldwidth:double;
   radians:double;
   cosval,sinval:double;
   drow,bp:pbyte;
   anx,any:pintegerarray;
begin
	if (fBitmap.PixelFormat<>ie8g) and (fBitmap.PixelFormat<>ie8p) then exit;
   oldheight := fBitmap.height;
   oldwidth := fBitmap.width;
   xrotimage:=TIEBitmap.Create;
   xrotimage.Location:=ieMemory;
   if (angle=90) or (angle=-90) or (angle=270) or (angle=180) or (angle=-180) then begin
      if angle=90 then begin
         // +90
         newwidth := oldheight;
         newheight := oldwidth;
         xrotimage.allocate(newwidth,newheight,fBitmap.PixelFormat);
         for x:=0 to oldwidth-1 do begin
            drow:=xrotimage.ScanLine[oldwidth-x-1];
            for y:=0 to oldheight-1 do begin
					drow^:=pbytearray(fBitmap.Scanline[y])[x];
               inc(drow);
            end;
         end;
      end else if (angle=-90) or (angle=270) then begin
         // -90, 270
         newwidth := oldheight;
         newheight := oldwidth;
         xrotimage.allocate(newwidth,newheight,fBitmap.PixelFormat);
         for x:=0 to oldwidth-1 do begin
            drow:=xrotimage.ScanLine[x];
            for y:=0 to oldheight-1 do begin
            	drow^:=pbytearray(fBitmap.Scanline[oldheight-y-1])[x];
               inc(drow);
            end;
         end;
      end else if (angle=180) or (angle=-180) then begin
         // 180, -180
         newwidth := oldwidth;
         newheight := oldheight;
         xrotimage.allocate(newwidth,newheight,fBitmap.PixelFormat);
         for y:=0 to newheight-1 do begin
         	drow:=xrotimage.Scanline[y];
            bp:=fBitmap.Scanline[newheight-y-1]; inc(bp,newwidth-1);
         	for x:=0 to newwidth-1 do begin
					drow^:=bp^;
               inc(drow);
               dec(bp);
            end;
         end;
      end;
   end else begin
      radians :=  -(angle) / ((180 / PI));
      cosval := trunc(cos(radians)*10000)/10000;
      sinval := trunc(sin(radians)*10000)/10000;
      newwidth := trunc(abs(oldwidth*cosval) + abs(oldheight*sinval));
      newheight := trunc(abs(-oldwidth*sinval) + abs(oldheight*cosval));
      halfnewheight := newheight / 2 -0.5;
      halfnewwidth := newwidth / 2 -0.5;
      halfoldwidth := oldwidth / 2 -0.5;
      halfoldheight := oldheight / 2 -0.5;
      xrotimage.allocate(newwidth,newheight,fBitmap.PixelFormat);
      //
      getmem(anx,sizeof(integer)*newwidth);
      getmem(any,sizeof(integer)*newwidth);
      for j:=0 to newwidth-1 do begin
         anx[j]:=trunc( (j-halfnewwidth)*cosval );
         any[j]:=trunc( (0-(j - halfnewwidth))*sinval );
      end;
      for i:=0 to newheight-1 do begin
         drow:=xrotimage.scanline[i];
         x6:=trunc((i-halfnewheight)*sinval+halfoldwidth);
         x7:=trunc((i-halfnewheight)*cosval+halfoldheight);
         for j:=0 to newwidth-1 do begin
            nx := anx[j]+x6;
            ny := any[j]+x7;
            if ((nx < oldwidth) and (ny < oldheight) and (nx >= 0) and (ny >= 0)) then begin
					drow^:=pbytearray(fBitmap.Scanline[ny])[nx];
            end else begin
            	drow^:=background;
            end;
            inc(drow);
         end;
      end;
      freemem(anx);
      freemem(any);
   end;
   fBitmap.Assign(xrotimage);
   FreeAndNil(xrotimage);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.SetPRPreviewParams(v:TPRPreviewsParams);
begin
	fPreviewsParams:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnProc.GetPRPreviewParams:TPRPreviewsParams;
begin
	result:=fPreviewsParams;
end;

/////////////////////////////////////////////////////////////////////////////////////
// amplitude
// wavelength
// phase (angolo in gradi)
// reflective
procedure TImageEnProc.Wave(amplitude, wavelength, phase:integer; reflective:boolean);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
   Progress:TProgressRec;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Wave',ProcBitmap,mask) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   _wave(ProcBitmap,amplitude,wavelength,phase,reflective,Progress);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
// amplitude
// wavelength
// phase (angolo in gradi)
// reflective
procedure _wave(Bitmap:TIEBitmap; amplitude, wavelength, phase:integer; reflective:boolean; var Progress:TProgressRec);
   function bilinear(x, y:double; v:array of byte):byte;
   var
     m0, m1:double;
   begin
     x := x-trunc(x);
     y := y-trunc(y);
     if (x < 0) then
       x := x+1.0;
     if (y < 0) then
       y := y+1.0;
     m0 := (1.0 - x) * v[0] + x * v[1];
     m1 := (1.0 - x) * v[2] + x * v[3];
     result:=trunc((1.0 - y) * m0 + y * m1);
   end;
const
	BYPP=3;	// channels number
   BITCOUNT=8; // bits per pixel
var
  src,dst:pbyte;
  srcbmp,dstbmp:TIEBitmap;
  width,height:integer;
  fphase:double;
  rowsiz:integer;
  p:pbyte;
  dest:pbyte;
  x1, y1, x2, y2:integer;
  x, y:integer;
  x1_in, y1_in, x2_in, y2_in:boolean;
  cen_x, cen_y:double;
  xhsiz, yhsiz:double;
  radius, radius2:double;
  amnt, d:double;
  needx, needy:double;
  dx, dy:double;
  xscale, yscale:double;
  xi, yi:integer;
  values:array [0..3] of byte;
  val:byte;
  k:integer;
begin
  // Assign src and dst
  width:=Bitmap.Width;
  height:=Bitmap.Height;
  dstbmp:=TIEBitmap.Create;
  dstbmp.Location:=ieMemory;  // to allow use of dst pointer
  dstbmp.Allocate(width,height,ie24RGB);
  dst:=dstbmp.Scanline[height-1];
  srcbmp:=TIEBitmap.Create;
  srcbmp.Location:=ieMemory;  // to allow use of src pointer
  srcbmp.AssignImage( Bitmap );
  src:=srcbmp.Scanline[height-1];
  // check values
  if (amplitude=0) or (wavelength=0) then exit;
  //
  Progress.per1:=100/(height);
  fphase := phase*PI/180;
  rowsiz := IEBitmapRowLen(width,BITCOUNT*BYPP,32);//width * BYPP;
  x1:=0;
  y1:=0;
  x2:=width;
  y2:=height;
  cen_x := (x2 - 1 + x1) / 2.0;
  cen_y := (y2 - 1 + y1) / 2.0;
  xhsiz := (x2 - x1) / 2.0;
  yhsiz := (y2 - y1) / 2.0;
  if (xhsiz < yhsiz) then begin
    xscale := yhsiz / xhsiz;
    yscale := 1.0;
  end else if (xhsiz > yhsiz) then begin
    xscale := 1.0;
    yscale := xhsiz / yhsiz;
  end else begin
    xscale := 1.0;
    yscale := 1.0;
  end;
  radius  := DMAX(xhsiz, yhsiz);
  radius2 := radius * radius;
  inc(dst, y1 * rowsiz + x1 * BYPP);
  wavelength := (wavelength * 2);
  for y := y1 to y2-1 do begin
    dest := dst;
    for x := x1 to x2-1 do begin
      dx := (x - cen_x) * xscale;
      dy := (y - cen_y) * yscale;
      d := sqrt(dx * dx + dy * dy);
      if reflective then begin
        amnt := amplitude * abs(sin(((d / wavelength) * (2.0 * PI) + fphase)));
        needx := (amnt * dx) / xscale + cen_x;
        needy := (amnt * dy) / yscale + cen_y;
      end else begin
        amnt := amplitude * sin(((d / wavelength) * (2.0 * PI) +fphase));
        needx := (amnt + dx) / xscale + cen_x;
        needy := (amnt + dy) / yscale + cen_y;
      end;
      xi := trunc(needx);
      yi := trunc(needy);
      if (xi > width - 2) then
        xi := width - 2
      else if (xi < 0) then
        xi := 0;
      if (yi > height - 2) then
        yi := height - 2
      else if (yi < 0) then
        yi := 0;
      p := pbyte(integer(src) + rowsiz * yi + xi * BYPP);
      x1_in := (0<=xi) and (xi<=width-1);
      y1_in := (0<=yi) and (yi<=height-1);
      x2_in := (0<=xi+1) and (xi+1<=width-1);
      y2_in := (0<=yi+1) and (yi+1<=height-1);
      for k := 0 to BYPP-1 do begin
        if x1_in and y1_in then
          values[0] := pbyte(integer(p) + k)^
        else
          values[0] := 0;
        if x2_in and y1_in then
          values[1] := pbyte(integer(p) + BYPP + k)^
        else
          values[1] := 0;
        if x1_in and y2_in then
          values[2] := pbyte(integer(p) + rowsiz + k)^
        else
          values[2] := 0;
        if x2_in then begin
          if y2_in then
            values[3] := pbyte(integer(p) + BYPP + k + rowsiz)^
          else
            values[3] := 0;
        end else
          values[3] := 0;
        val := bilinear(needx, needy, values);
        dest^ := val;
        inc(dest);
      end;
    end;
    inc(dst,rowsiz);
    with Progress do
       if assigned(fOnProgress) then
          fOnProgress(Sender,trunc(per1*y));
  end;
  Bitmap.AssignImage( dstbmp );
  FreeAndNil(srcbmp);
  FreeAndNil(dstbmp);
end;

/////////////////////////////////////////////////////////////////////////////////////
// creates a palette from ColorMap
// Ncol max 256
// destroy with DeleteObject
(*$ifdef IEDELPHI*)
function _CreateWinPalette(var ColorMap:array of TRGB; NCol:integer):HPalette;
type
	tpal=record
   	palVersion:word;
      palNumEntries:word;
      PaletteEntry:array [0..255] of TPALETTEENTRY;
   end;
   plogpalette=^tlogpalette;
var
   pa:tpal;
   q:integer;
begin
   pa.palVersion:=$300;
   pa.palNumEntries:=NCol;
	for q:=0 to NCol-1 do begin
   	pa.PaletteEntry[q].peRed:=ColorMap[q].r;
      pa.PaletteEntry[q].peGreen:=ColorMap[q].g;
      pa.PaletteEntry[q].peBlue:=ColorMap[q].b;
      pa.PaletteEntry[q].peFlags:=0;
   end;
   result:=CreatePalette(plogpalette(@pa)^);
end;
(*$endif*)

type TIEHiddenRec=packed record
	Version:byte;	// version: 0
   EncodeAlg:byte; // crypt algorithm : 0 (nothing)
   res1,res2:byte; // reserved
   DataLen:integer; // data length
end;

/////////////////////////////////////////////////////////////////////////////////////
// return wrote bytes
function TImageEnProc.WriteHiddenData(data:PAnsiChar; count:integer):integer;
var
	row,col:integer;
   px:pbyte;
   wb,bc:integer;
   hr:TIEHiddenRec;
   bb:byte;
begin
	result:=0;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('WriteHiddenData',ieuImage);
   l3fillchar(hr,sizeof(TIEHiddenRec),0);
   hr.DataLen:=count;
   wb:=0;	// bit 0..7
   bc:=0;
   inc(count,sizeof(TIEHiddenRec));
   for row:=0 to fIEBitmap.Height-1 do begin
      px:=fIEBitmap.ScanLine[row];
      for col:=0 to (fIEBitmap.Width*3-1) do begin
      	if bc<sizeof(TIEHiddenRec) then
         	bb:=pbytearray(@hr)^[bc]
         else
         	bb:=pbyte(data)^;
         if (bb and (1 shl wb))<>0 then begin
            // scrive 1: rende px^ dispari
            if (px^ and 1)=0 then
            	inc(px^);
         end else begin
            // scrive 0: rende px^ pari
            if (px^ and 1)<>0 then begin
            	if px^=255 then
               	dec(px^)
               else
	            	inc(px^);
            end;
         end;
         inc(wb);
         if wb=8 then begin
            wb:=0;
            inc(bc);
				if bc=count then break;
         	if bc>sizeof(TIEHiddenRec) then
	            inc(data);
         end;
         inc(px);
      end;
      if bc=count then break;
   end;
	Update;
   result:=count-sizeof(TIEHiddenRec);
end;

/////////////////////////////////////////////////////////////////////////////////////
// return wrote bytes
function TImageEnProc.WriteHiddenText(text:string):integer;
begin
	result:=WriteHiddenData(PAnsiChar(text),length(text));
end;

/////////////////////////////////////////////////////////////////////////////////////
// Calcola dimensione spazio hidden
function TImageEnProc.GetHiddenDataSpace:integer;
begin
	result:=0;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	result:=fIEBitmap.Width*fIEBitmap.Height*3 div 8 - sizeof(TIEHiddenRec);
end;

/////////////////////////////////////////////////////////////////////////////////////
// se maxlen è 0 e data=nil restituisce lunghezza dati
function TImageEnProc.ReadHiddenData(data:PAnsiChar; maxlen:integer):integer;
var
	row,col:integer;
   px:pbyte;
   rb,rc:integer;
   hr:TIEHiddenRec;
   bb:byte;
begin
	result:=0;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   rb:=0; // read bits
   rc:=0; // read bytes
   bb:=0;
   for row:=0 to fIEBitmap.Height-1 do begin
      px:=fIEBitmap.ScanLine[row];
      for col:=0 to (fIEBitmap.Width*3)-1 do begin
         if (px^ and 1)<>0 then
            // dispari: 1
            bb:=bb or (1 shl rb);
         inc(rb);
         if rb=8 then begin
         	// filled a byte
         	if rc<sizeof(TIEHiddenRec) then
            	pbytearray(@hr)^[rc]:=bb
            else begin
               if (maxlen=0) or (rc=hr.DataLen+sizeof(TIEHiddenRec)) then break;
					pbyte(data)^:=bb;
               inc(data);
               dec(maxlen);
            end;
            inc(rc);
            rb:=0;
            bb:=0;
         end;
         inc(px);
      end;
      if (maxlen=0) or (rc=hr.DataLen+sizeof(TIEHiddenRec)) then break;
   end;
   result:=hr.DataLen;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEnProc.ReadHiddenText:string;
var
	ln:integer;
begin
	ln:=ReadHiddenData(nil,0);
   SetLength(result,ln);
   ReadHiddenData(PAnsiChar(result),ln);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure YUV2RGB(y,u,v:integer; var RGB:TRGB);
begin
	with RGB do begin
   	b:=blimit(round(1.164*(y-16)+2.018*(u-128)));
      g:=blimit(round(1.164*(y-16)-0.813*(v-128)-0.391*(u-128)));
      r:=blimit(round(1.164*(y-16)+1.596*(v-128)));
   end;
end;

// Convert IYU1 to Bitmap (24bit)
// YUV (4:1:1)
// "12 bit format used in mode 2 of the IEEE 1394 Digital Camera 1.04 spec"
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyIYU1ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TIYU1=packed record
   	u0:byte;
      y0:byte;
      y1:byte;
      v0:byte;
      y2:byte;
      y3:byte;
   end;
   PIYU1=^TIYU1;
var
	row,col,rr:integer;
   yuv:PIYU1;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PIYU1(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y1,u0,v0,px^); inc(px);
            YUV2RGB(y2,u0,v0,px^); inc(px);
            YUV2RGB(y3,u0,v0,px^); inc(px);
            inc(col,4);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert IYU2 to Bitmap (24bit)
// YUV (4:4:4)
// "24 bit format used in mode 2 of the IEEE 1394 Digital Camera 1.04 spec"
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyIYU2ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TIYU2=packed record
   	u0:byte;
      y0:byte;
      v0:byte;
   end;
   PIYU2=^TIYU2;
var
	row,col,rr:integer;
   yuv:PIYU2;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PIYU2(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            inc(col);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert UYVY to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyUYVYToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TUYVY=packed record
   	u0:byte;
      y0:byte;
      v0:byte;
      y1:byte;
   end;
   PUYVY=^TUYVY;
var
	row,col,rr:integer;
   yuv:PUYVY;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PUYVY(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y1,u0,v0,px^); inc(px);
            inc(col,2);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert YUY2 to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyYUY2ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TYUY2=packed record
   	y0:byte;
      u0:byte;
      y1:byte;
      v0:byte;
   end;
   PYUY2=^TYUY2;
var
	row,col,rr:integer;
   yuv:PYUY2;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PYUY2(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y1,u0,v0,px^); inc(px);
            inc(col,2);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert YVYU to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyYVYUToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TYVYU=packed record
   	y0:byte;
      v0:byte;
      y1:byte;
      u0:byte;
   end;
   PYVYU=^TYVYU;
var
	row,col,rr:integer;
   yuv:PYVYU;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PYVYU(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y1,u0,v0,px^); inc(px);
            inc(col,2);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert Y41P to Bitmap (24bit)
// YUV (4:1:1)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyY41PToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TY41P=packed record
   	u0:byte;
      y0:byte;
      v0:byte;
      y1:byte;
      u4:byte;
      y2:byte;
      v4:byte;
      y3:byte;
      y4:byte;
      y5:byte;
      y6:byte;
      y7:byte;
   end;
   PY41P=^TY41P;
var
	row,col,rr:integer;
   yuv:PY41P;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PY41P(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y1,u0,v0,px^); inc(px);
            YUV2RGB(y2,u0,v0,px^); inc(px);
            YUV2RGB(y3,u0,v0,px^); inc(px);
	         YUV2RGB(y4,u4,v4,px^); inc(px);
            YUV2RGB(y5,u4,v4,px^); inc(px);
            YUV2RGB(y6,u4,v4,px^); inc(px);
            YUV2RGB(y7,u4,v4,px^); inc(px);
            inc(col,8);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert Y211 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyY211ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
type
	TY211=packed record
   	y0:byte;
      u0:byte;
      y2:byte;
      v0:byte;
   end;
   PY211=^TY211;
var
	row,col,rr:integer;
   yuv:PY211;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PY211(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do
      	with yuv^ do begin
	         YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y0,u0,v0,px^); inc(px);
            YUV2RGB(y2,u0,v0,px^); inc(px);
            YUV2RGB(y2,u0,v0,px^); inc(px);
            inc(col,4);
            inc(yuv);
         end;
      inc(row,zinc);
   end;
end;

// Convert CLJR to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyCLJRToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
var
	row,col,rr:integer;
   u,v:integer;
   yuv:PDWORD;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	yuv:=PDWORD(xbits);
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      while col<fBitmap.Width-1 do begin
      	v:=yuv^ and $3F;
         u:=(yuv^ SHR 6) and $3F;
         YUV2RGB(((yuv^ SHR 12) and $1F),u,v,px^); inc(px);
         YUV2RGB(((yuv^ SHR 17) and $1F),u,v,px^); inc(px);
         YUV2RGB(((yuv^ SHR 22) and $1F),u,v,px^); inc(px);
         YUV2RGB(((yuv^ SHR 27) and $1F),u,v,px^); inc(px);
         inc(col,4);
         inc(yuv);
      end;
      inc(row,zinc);
   end;
end;

// Convert YVU9 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyYVU9ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
var
	row,col,rr:integer;
   y,u,v:pbyte;
   bu,bv:pbyte;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	y:=xbits;
   v:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width );
   u:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width+(fBitmap.Height div 4)*(fBitmap.Width div 4) );
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      bv:=v;
      bu:=u;
      while col<fBitmap.Width-1 do begin
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         inc(u);
         inc(v);
         inc(col,4);
      end;
      inc(row,zinc);
      if (row mod 4)<>0 then begin
      	v:=bv;
			u:=bu;
      end;
   end;
end;

// Converts YV12 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyYV12ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
var
	row,col,rr:integer;
   y,u,v:pbyte;
   bu,bv:pbyte;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	y:=xbits;
   v:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width );
   u:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width+(fBitmap.Height div 2)*(fBitmap.Width div 2) );
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      bv:=v;
      bu:=u;
      while col<fBitmap.Width-1 do begin
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         inc(u);
         inc(v);
         inc(col,2);
      end;
      inc(row,zinc);
      if (row mod 2)<>0 then begin
      	v:=bv;
			u:=bu;
      end;
   end;
end;

// Convert I420 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top
procedure _CopyI420ToBitmap(xbits:pbyte; fBitmap:TIEBaseBitmap; dirc:boolean);
var
	row,col,rr:integer;
   y,u,v:pbyte;
   bu,bv:pbyte;
   px:PRGB;
   zinc:integer;
begin
	if dirc then begin
   	zinc:=1;
      row:=0;
   end else begin
   	zinc:=-1;
      row:=fBitmap.Height-1;
   end;
	y:=xbits;
   u:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width );
   v:=pbyte( integer(xbits)+fBitmap.Height*fBitmap.Width+(fBitmap.Height div 2)*(fBitmap.Width div 2) );
   for rr:=0 to fBitmap.Height-1 do begin
      px:=fBitmap.Scanline[row];
     	col:=0;
      bv:=v;
      bu:=u;
      while col<fBitmap.Width-1 do begin
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         YUV2RGB(y^,u^,v^,px^); inc(px); inc(y);
         inc(u);
         inc(v);
         inc(col,2);
      end;
      inc(row,zinc);
      if (row mod 2)<>0 then begin
      	v:=bv;
			u:=bu;
      end;
   end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// Copy a DIB in fBitmap (fBitmap must exists)
// fBitmap will be pf1bit or pf24bit
// NOTE: desn't process DIB's colormap for 1 bpp bitmaps
// xbits: bitmap pixels. If "nil" the pixels are inside hbi.
// return bitcount of hbi
// unlck: If true hbi represents a pointer (then doesn't call GlobalLock)
// NOTE: for YUV formats xbits must point to image data
(*$ifdef IEDELPHI*)
function _CopyDIB2Bitmap(hbi:THandle; fBitmap:TBitmap; xbits:pbyte; unlck:boolean):integer;
var
   tbmp:TIEBitmap;
begin
   tbmp:=TIEBitmap.Create;
   tbmp.EncapsulateTBitmap(fBitmap,true);
   result:=_CopyDIB2BitmapEx(hbi,tbmp,xbits,unlck);
   FreeAndNil(tbmp);
end;

// assume that fBitmap is already allocated
// supports only BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS (not YUV...)
function _CopyDIB2BitmapEx(hbi:THandle; fBitmap:TIEBaseBitmap; xbits:pbyte; unlck:boolean):integer;
type
	TRGBQUADARRAY=array [0..Maxint div 16] of TRGBQUAD;
   PRGBQUADARRAY=^TRGBQUADARRAY;
var
   pbi:PBITMAPINFO;
   lw:integer;	// row length in bytes
   Compression:DWORD;	// compressino type
   Width,Height:integer;	// image width and height
   BitCount:integer;	// Bitcount
   y,x,z,zz,c:integer;
   bits,bits2:pbyte;
   wbits:pword;
   px:PRGB;
   bfdw:array [0..2] of dword;
   gbitcount,rbitcount,bbitcount:integer;
   rshift,gshift,bshift:integer;
   ColorMap:PRGBQUADARRAY;
begin
	if unlck then
   	pbi:=pointer(hbi)
   else
		pbi:=GlobalLock(hbi);
   Width:=pbi^.bmiHeader.biWidth;
   Height:=pbi^.bmiHeader.biHeight;
   BitCount:=pbi^.bmiHeader.biBitCount;
   result:=BitCount;
   Compression:=pbi^.bmiHeader.biCompression;
   lw:=(((Width*BitCount)+31) div 32) * 4;
   if BitCount=1 then
      fBitmap.Allocate(Width,Height,ie1g)
   else
      fBitmap.Allocate(Width,Height,ie24RGB);
   case Compression of
		BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS:
         case BitCount of
            1:
               begin
                  // 1 bit per pixel
                  bits:=pbyte(pbi);
                  inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                  y:=pbi^.bmiHeader.biClrUsed;
                  if y=0 then y:=2;
                  inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
                  if xbits<>nil then bits:=xbits;
                  CopyMemory(fBitmap.Scanline[height-1],bits,lw*fbitmap.height);
               end;
            4:
               begin
                  // 4 bit per pixel
                  bits:=pbyte(pbi);
                  inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                  Colormap:=PRGBQUADARRAY(bits);
                  y:=pbi^.bmiHeader.biClrUsed;
                  if y=0 then y:=16;
                  inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
                  if xbits<>nil then bits:=xbits;
                  zz:=Width div 2;
                  z:=zz+(Width and 1);	// if odd inc of 1
                  dec(zz);
                  for y:=Height-1 downto 0 do begin
                     px:=fbitmap.Scanline[y];
                     bits2:=bits;
                     for x:=0 to z-1 do begin
                        c:=bits2^ SHR 4;
                        px^.b:=ColorMap^[c].rgbBlue;
                        px^.g:=ColorMap^[c].rgbGreen;
                        px^.r:=ColorMap^[c].rgbRed;
                        inc(px);
                        if x=zz then
                           break;
                        c:=bits2^ and $0F;
                        px^.b:=ColorMap^[c].rgbBlue;
                        px^.g:=ColorMap^[c].rgbGreen;
                        px^.r:=ColorMap^[c].rgbRed;
                        inc(px);
                        inc(bits2);
                     end;
                     inc(bits,lw);
                  end;
               end;
            8:
               begin
                  // 8 bit per pixel
                  bits:=pbyte(pbi);
                  inc(bits,pbi^.bmiHeader.biSize); //inc(bits,sizeof(TBITMAPINFOHEADER));
                  Colormap:=PRGBQUADARRAY(bits);
                  y:=pbi^.bmiHeader.biClrUsed;
                  if y=0 then y:=256;
                  inc(bits,sizeof(TRGBQUAD)*y);	// salta colormap
                  if xbits<>nil then bits:=xbits;
                  for y:=Height-1 downto 0 do begin
                     px:=fbitmap.Scanline[y];
                     bits2:=bits;
                     for x:=0 to Width-1 do begin
                        px^.b:=ColorMap^[bits2^].rgbBlue;
                        px^.g:=ColorMap^[bits2^].rgbGreen;
                        px^.r:=ColorMap^[bits2^].rgbRed;
                        inc(bits2);
                        inc(px);
                     end;
                     inc(bits,lw);
                  end;
               end;
            16:	// 16 bit per pixel
               begin
                  bits:=pbyte(pbi);
                  inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                  if xbits<>nil then bits:=xbits;
                  if Compression=BI_RGB then begin
                     // configurazione 5-5-5
                     bfdw[0]:=$7C00;
                     bfdw[1]:=$03E0;
                     bfdw[2]:=$001F;
                  end else if Compression=BI_BITFIELDS then begin
                     CopyMemory(@bfdw,bits,3*sizeof(dword));
                     inc(bits,3*sizeof(dword));	// bypass bitfield
                  end;
                  rbitcount:=_GetBitCount(bfdw[0]);
                  gbitcount:=_GetBitCount(bfdw[1]);
                  bbitcount:=_GetBitCount(bfdw[2]);
                  rshift:=(gbitCount+bbitCount)-(8-rbitCount);
                  gshift:=bbitCount-(8-gbitCount);
                  bshift:=8-bbitCount;
                  for y:=Height-1 downto 0 do begin
                     px:=fbitmap.Scanline[y];
                     wbits:=pword(bits);
                     for x:=0 to Width-1 do begin
                        px^.r:= (wbits^ and bfdw[0]) SHR rshift;
                        px^.g:= (wbits^ and bfdw[1]) SHR gshift;
                        px^.b:= (wbits^ and bfdw[2]) SHL bshift;
                        inc(px);
                        inc(wbits);
                     end;
                     inc(bits,lw);
                  end;
               end;
            24:	// 24 bit per pixel
               begin
                  if Compression=BI_RGB then begin
                     bits:=pbyte(pbi);
                     inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                     if xbits<>nil then bits:=xbits;
                     for y:=Height-1 downto 0 do begin
                        CopyMemory(fbitmap.Scanline[y],bits,lw);
                        inc(bits,lw);
                     end;
                  end;
               end;
            32:	// 32 bit per pixel
               begin
                  if Compression=BI_BITFIELDS then begin
                     // BITFIELDS, bitfield must be FF,00FF and 0000FF
                     bits:=pbyte(pbi);
                     inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                     inc(bits,3*sizeof(dword));	// bypass bitfield
                  end else if Compression=BI_RGB then begin
                     bits:=pbyte(pbi);
                     inc(bits,pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                  end else begin
                     if not unlck then
                        GlobalUnLock(hbi);
                     exit;				// EXIT POINT!!
                  end;
                  if xbits<>nil then bits:=xbits;
                  for y:=Height-1 downto 0 do begin
                     px:=fbitmap.Scanline[y];
                     bits2:=bits;
                     for x:=0 to Width-1 do begin
                        px^.b:=bits2^; inc(bits2);
                        px^.g:=bits2^; inc(bits2);
                        px^.r:=bits2^; inc(bits2,2);
                        inc(px);
                     end;
                     inc(bits,lw);
                  end;
               end;
         end; // Case of Bitcount
      IEBI_IYU1: 				_CopyIYU1ToBitmap(xbits,fBitmap, Height>0);
      IEBI_IYU2: 				_CopyIYU2ToBitmap(xbits,fBitmap, Height>0);
      IEBI_UYVY,IEBI_UYNV: _CopyUYVYToBitmap(xbits,fBitmap, Height>0);
      IEBI_cyuv: 				_CopyUYVYToBitmap(xbits,fBitmap, Height<0);
      IEBI_YUY2,IEBI_YUNV: _CopyYUY2ToBitmap(xbits,fBitmap, Height>0);
      IEBI_YVYU: 				_CopyYVYUToBitmap(xbits,fBitmap, Height>0);
      IEBI_Y41P: 				_CopyY41PToBitmap(xbits,fBitmap, Height<0);
      IEBI_Y211: 				_CopyY211ToBitmap(xbits,fBitmap, Height>0);
      IEBI_CLJR: 				_CopyCLJRToBitmap(xbits,fBitmap, Height>0);
      IEBI_YVU9: 				_CopyYVU9ToBitmap(xbits,fBitmap, Height>0);
      IEBI_YV12:				_CopyYV12ToBitmap(xbits,fBitmap, Height>0);
      IEBI_I420,IEBI_IYUV:	_CopyI420ToBitmap(xbits,fBitmap, Height>0);
      // not supported...
      IEBI_Y41T: ;
      IEBI_Y42T: ;
		IEBI_CLPL: ;
      IEBI_IF09: ;
   end;
   if not unlck then
	   GlobalUnLock(hbi);
end;
(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
// Copy polygon "Polygon" of Source inside Position of Dest
procedure _CopyPolygonToPoint(Source:TBitmap; Polygon:PPointArray; PolygonLen:integer; Dest:TBitmap; const Position:TPoint);
(*$ifdef IEDELPHI*)
var
   hrgn:THandle;
   NewPoly:PPointArray;
   q:integer;
   sx1,sy1,sx2,sy2:integer;
   drect:TRect;
   p1,p2:integer;
begin
	if PolygonLen<3 then
   	exit;
	// find sx1,sy1,sx2,sy2, source rectangle
   sx1:=Polygon^[0].x;
   sy1:=Polygon^[0].y;
   sx2:=Polygon^[1].x;
   sy2:=Polygon^[1].y;
   OrdCor(sx1,sy1,sx2,sy2);
   for q:=2 to PolygonLen-1 do begin
   	if Polygon^[q].x<>IESELBREAK then begin
         sx1:=imin(sx1,Polygon^[q].x);
         sy1:=imin(sy1,Polygon^[q].y);
         sx2:=imax(sx2,Polygon^[q].x);
         sy2:=imax(sy2,Polygon^[q].y);
      end;
   end;
   //
	GetMem(NewPoly,sizeof(TPoint)*PolygonLen);
   // traslate Polygon, destination polygon
	for q:=0 to PolygonLen-1 do begin
   	if Polygon^[q].x=IESELBREAK then
      	NewPoly^[q]:=Polygon^[q]
      else begin
         NewPoly^[q].x:=Polygon^[q].x-sx1+Position.x;
         NewPoly^[q].y:=Polygon^[q].y-sy1+Position.y;
      end;
   end;
	//
   drect.Left:=Position.x;
   drect.Top:=Position.y;
   drect.Right:=Position.x+sx2-sx1;
   drect.Bottom:=Position.y+sy2-sy1;
   if Dest.Width<=drect.Right then
   	Dest.Width:=drect.Right;
   if Dest.Height<=drect.Bottom then
   	Dest.Height:=drect.bottom;
   p1:=0;
   for q:=0 to PolygonLen do
   	if (NewPoly^[q].x=IESELBREAK) or (q=PolygonLen) then begin
      	p2:=q-p1;
         hrgn:=CreatePolygonRgn(NewPoly^[p1],p2,ALTERNATE);
         SelectClipRgn(Dest.Canvas.Handle,hrgn);
         Dest.Canvas.CopyRect(drect,Source.Canvas,rect(sx1,sy1,sx2,sy2));
         SelectClipRgn(Dest.Canvas.Handle,0);
         DeleteObject(hrgn);
         p1:=q+1;
      end;
   freemem(NewPoly);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}


/////////////////////////////////////////////////////////////////////////////////////
// Copy rectangle that starts in Position of Source to polygon "Polygon" of Dest
procedure _CopyPointToPolygon(Source:TBitmap; Polygon:PPointArray; PolygonLen:integer; Dest:TBitmap; const Position:TPoint);
(*$ifdef IEDELPHI*)
var
   hrgn:THandle;
   q:integer;
   sx1,sy1,sx2,sy2:integer;
   p1,p2:integer;
begin
	if PolygonLen<3 then
   	exit;
	// find sx1,sy1,sx2,sy2, destination rectangle
   sx1:=Polygon^[0].x;
   sy1:=Polygon^[0].y;
   sx2:=Polygon^[1].x;
   sy2:=Polygon^[1].y;
   OrdCor(sx1,sy1,sx2,sy2);
   for q:=2 to PolygonLen-1 do begin
   	if Polygon^[q].x<>IESELBREAK then begin
         sx1:=imin(sx1,Polygon^[q].x);
         sy1:=imin(sy1,Polygon^[q].y);
         sx2:=imax(sx2,Polygon^[q].x);
         sy2:=imax(sy2,Polygon^[q].y);
      end;
   end;
   //
   if Dest.Width<sx2 then
   	Dest.Width:=sx2;
   if Dest.Height<sy2 then
   	Dest.Height:=sy2;
   p1:=0;
   for q:=0 to PolygonLen do
   	if (Polygon^[q].x=IESELBREAK) or (q=PolygonLen) then begin
      	p2:=q-p1;
         hrgn:=CreatePolygonRgn(Polygon^[p1],p2,ALTERNATE);
         SelectClipRgn(Dest.Canvas.Handle,hrgn);
         Dest.Canvas.CopyRect(rect(sx1,sy1,sx2,sy2),Source.Canvas,rect(Position.x,Position.y,Position.x+sx2-sx1,Position.y+sy2-sy1));
         SelectClipRgn(Dest.Canvas.Handle,0);
         DeleteObject(hrgn);
         p1:=q+1;
      end;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
// copy a BGR row to RGB (and viceversa)
procedure _CopyBGR_RGB(dst:PRGB; src:PRGB; width:integer);
var
	q:integer;
begin
	CopyMemory(dst,src,width*3);
	for q:=0 to width-1 do begin
   	bswap(dst^.r,dst^.b);
      inc(dst);
   end;
end;

procedure _BGR2RGB(buff:PRGB; width:integer);
var
	q:integer;
begin
	for q:=0 to width-1 do begin
   	bswap(buff^.r,buff^.b);
      inc(buff);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// op:
//   0=maximum (dilation)
//   1=minimum (erosion)
//   2=open (erosion+dilation)
//   3=close (dilation+erosion)
procedure _MorphFilter(bitmap:TIEBitmap; WindowSize:integer; op:integer; fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   col,row,x,y,w,e,xx,yy,q1,q2,xxx,yyy:integer;
   e1:integer;
   ppx:pRGB;
   per1:double;
   graypix:pbyte;
   rgbpix:PRGB;
   ww,hh:integer;
   mm:byte;
   subop:integer;	// 0=dilate 1=erode
   it:integer;
   canexit:boolean;
begin
	if Bitmap.Pixelformat<>ie24RGB then
   	exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   // alloc graypix and rgbpix
   ww:=(fSelX2-fSelX1+1);
   hh:=(fSelY2-fSelY1+1);
   getmem(graypix,(ww+2)*hh);
   getmem(rgbpix,(ww+2)*hh*3);
   //
   q1:=-WindowSize;
   q2:=WindowSize;
   it:=0;
   canexit:=false;
   subop:=0;
   per1:=0;
   repeat
		if op<2 then begin
      	subop:=op;
			canexit:=true;
         per1:=100/(fSelY2-fSelY1+0.5);
      end else begin
      	if op=2 then begin
         	// open (erosion(1) + dilation(0))
            per1:=100/(fSelY2-fSelY1+0.5)/2;
         	if it=0 then
            	subop:=1
            else begin
            	subop:=0;
               canexit:=true;
            end;
         end else if op=3 then begin
         	// close (dilation(0) + erosion(1))
            per1:=100/(fSelY2-fSelY1+0.5)/2;
            if it=0 then
            	subop:=0
            else begin
            	subop:=1;
               canexit:=true;
            end;
         end else
         	break;
      end;
      // fill graypix and rgbpix
      y:=0;
      for row:=fSelY1 to fSelY2 do begin
         ppx:=bitmap.ScanLine[row];
         inc(ppx,fSelX1);
         x:=0;
         for col:=fSelX1 to fSelX2 do begin
            with ppx^ do
               pbyte(integer(graypix)+y+x)^:=(r*21 + g*71 + b*8) div 100;
            prgb(integer(rgbpix)+(y+x)*3)^:=ppx^;
            inc(ppx);
            inc(x);
         end;
         inc(y,ww);
      end;
      //
      y:=0;
      for row:=fsely1 to fsely2 do begin
         ppx:=bitmap.ScanLine[row];
         inc(ppx,fSelX1);
         x:=0;
         case subop of
            0:	// maximum
               for col:=fselx1 to fselx2 do begin
                  mm:=0; xxx:=0; yyy:=0;
                  for yy:=q1 to q2 do begin
                     e:=integer(graypix)+ilimit(y+yy,0,hh-1)*ww;
                     for xx:=q1 to q2 do begin
                        w:=pbyte(e+ilimit(x+xx,0,ww-1))^;
                        if w>mm then begin
                           xxx:=xx; yyy:=yy; mm:=w;
                        end;
                     end;
                  end;
                  ppx^:=prgb(integer(rgbpix)+(ilimit(y+yyy,0,hh-1)*ww+ilimit(x+xxx,0,ww-1))*3)^;
                  inc(x);
                  inc(ppx);
               end;
            1: // minimum
               for col:=fselx1 to fselx2 do begin
                  mm:=255; xxx:=0; yyy:=0;
                  for yy:=q1 to q2 do begin
                     e:=integer(graypix)+ilimit(y+yy,0,hh-1)*ww;
                     for xx:=q1 to q2 do begin
                        w:=pbyte(e+ilimit(xx+x,0,ww-1))^;
                        if w<mm then begin
                           xxx:=xx; yyy:=yy; mm:=w;
                        end;
                     end;
                  end;
                  ppx^:=prgb(integer(rgbpix)+(ilimit(y+yyy,0,hh-1)*ww+ilimit(x+xxx,0,ww-1))*3)^;
                  inc(x);
                  inc(ppx);
               end;
         end;
         inc(y);
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per1*(row-fSelY1+1+it*hh)));
      end;
      inc(it);
   until canexit;
   //
   freemem(graypix);
   freemem(rgbpix);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Maximum(WindowSize:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Maximum '+inttostr(WindowSize),ProcBitmap,mask) then
   	exit;
   _MorphFilter(ProcBitmap,WindowSize,0,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Minimum(WindowSize:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Minimum '+inttostr(WindowSize),ProcBitmap,mask) then
   	exit;
   _MorphFilter(ProcBitmap,WindowSize,1,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Opening(WindowSize:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Opening '+inttostr(WindowSize),ProcBitmap,mask) then
   	exit;
   _MorphFilter(ProcBitmap,WindowSize,2,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEnProc.Closing(WindowSize:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Closing '+inttostr(WindowSize),ProcBitmap,mask) then
   	exit;
   _MorphFilter(ProcBitmap,WindowSize,3,x1,y1,x2,y2, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


/////////////////////////////////////////////////////////////////////////////////////
// Create a Fourier transformations of current image
// ImageType can be ieitRGB or ieitGrayscale
// NewWidth and NewHeight can be each -1 (autocalc) or the new image sizes
function TImageEnProc.FTCreateImage(ImageType:TIEFtImageType; NewWidth,NewHeight:integer):TIEFtImage;
var
	newbitmap:TIEBitmap;
begin
	result:=nil;
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if (NewWidth<0) and (NewHeight<0) then
   	newbitmap:=fIEBitmap
   else begin
   	if NewWidth<0 then
	   	NewWidth:=(fIEbitmap.width*NewHeight) div fIEbitmap.Height
	   else if NewHeight<0 then
	   	NewHeight:=(fIEbitmap.Height*NewWidth) div fIEbitmap.Width;
      newbitmap:=TIEBitmap.Create;
      newbitmap.Allocate(NewWidth,NewHeight,fIEBitmap.PixelFormat);
      // Resample (you can use _ResampleEx(fIEBitmap,newbitmap,rfFastLinear,nil,nil); )
      _IEBmpStretchEx(fIEBitmap,newbitmap,nil,nil);
   end;
	result:=TIEFtImage.Create;
   result.OnProgress:=fOnProgress;
   result.BuildFT(newbitmap,ImageType);
   if newbitmap<>fIEBitmap then
   	FreeAndNil(newbitmap);
end;

/////////////////////////////////////////////////////////////////////////////////////
// Convert the specified Fourier transformation to current image
procedure TImageEnProc.FTConvertFrom(ft:TIEftImage);
begin
   if not MakeConsistentBitmap([]) then
      exit;
	ft.BuildBitmap(fIEBitmap);
   Update;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Display the specified Fourier transformation in current image
procedure TImageEnProc.FTDisplayFrom(ft:TIEftImage);
begin
   if not MakeConsistentBitmap([]) then
      exit;
	ft.GetFTImage(fIEBitmap);
   Update;
end;

procedure addPt(var a, b, c:TPoint);
begin
	c.x := a.x + b.x;
	c.y := a.y + b.y;
end;

procedure subPt(var a, b, c:TPoint);
begin
   c.x := a.x - b.x;
   c.y := a.y - b.y;
end;

// Return a closed and non nested polygon from a flood-fill at (x,y)
function _MakeMagicWandPoints(fBitmap:TIEBitmap; x,y:integer; maxfilter:boolean; tolerance:integer; var pcount:integer):PPointArray;
type
	TItem=record
   	yy,xl,xr,dy:integer;
   end;
   PItem=^TItem;
const
	CONTOUR=3;	//'c'
	VISITED=2;	//'v'
	BLACK=1;		//'1'
	WHITE=0;		//'0'
   xcontour_dir:array [0..7] of TPoint = ((x:1;y:0),(x:0;y:-1),(x:-1;y:0),(x:0;y:1),
   												  (x:1;y:-1),(x:-1;y:-1),(x:-1;y:1),(x:1;y:1));
	xdirection_code:array [0..7] of byte= (0,2,4,6,1,3,5,7);
var
	BUFALLOC:integer;	// allocation cluster size
   Buffer:TIERecordList;
   dy, sp, start, x1, x2, y1,y2:integer;
   c:integer;
   seed_color:TRGB;
   outbmp:pPRGBArray;
   obmp:ppointerarray;
   fbmp:PBYTEROWS;
   fdx,fdy:integer;
   j,i,v,u,q,w,row,col:integer;
   enter:boolean;
   rr:pbyte;
   xx1,yy1,xx2,yy2:integer;
   xx,yy:integer;
   dx:integer;
   pix:PRGB;
   flag:boolean;
   bbox:array [0..1] of TPoint;
   pixel,start_pixel,test_pixel:TPoint;
   distance,d,last_dir:integer;
   code:TIEByteArray;
   rs:TIERecordList;
   pv:byte;
   pcode:pbyte;
   bitmapwidth,bitmapheight,opt1,opt2:integer;
	contour_dir:array [0..7] of TPoint;
	direction_code:array [0..7] of byte;
   //
   function _eqpixel:boolean;
   var
      dr,dg,db:integer;
      col:TRGB;
   begin
      if (x >= BitmapWidth) or (y >= BitmapHeight) then
         result:=false
      else begin
      	col:=fBitmap.Pixels[x,y];
			dr:=abs( seed_color.r - col.r );
         dg:=abs( seed_color.g - col.g );
         db:=abs( seed_color.b - col.b );
         result:= (dr<tolerance) and (dg<tolerance) and (db<tolerance);
      end;
   end;
	//
begin
	for j:=0 to high(xcontour_dir) do
   	contour_dir[j]:=xcontour_dir[j];
   for j:=0 to high(xdirection_code) do
   	direction_code[j]:=xdirection_code[j];
	pcount:=0;
   bitmapwidth:=fbitmap.width;
   bitmapheight:=fbitmap.height;
	// Makes a flood fill bitmap (B/W) in outbmp
	if (x<0) or (x>=BitmapWidth) or (y<0) or (y>=BitmapHeight) then
   	exit;
	BUFALLOC:=2*fBitmap.Width;
   Buffer:=TIERecordList.CreateList(sizeof(TItem));
   Buffer.Count:=BUFALLOC;
	// make outbmp and fill with 0
   getmem(outbmp,fbitmap.height*sizeof(pRGB));
   for q:=0 to bitmapHeight-1 do
		outbmp[q]:=allocmem(fbitmap.width shr 3 +1);	// zero filled
	//
   seed_color:=fBitmap.Pixels[x,y];
   start:=0;
	sp:=0;
	PItem(buffer[sp])^.yy := y;
	PItem(buffer[sp])^.xl := x;
	PItem(buffer[sp])^.xr := x;
	PItem(buffer[sp])^.dy := 1;
   inc(sp);
	PItem(buffer[sp])^.yy := y+1;
	PItem(buffer[sp])^.xl := x;
	PItem(buffer[sp])^.xr := x;
	PItem(buffer[sp])^.dy := -1;
   inc(sp);
   xx1:=2147483647; yy1:=2147483647; xx2:=0; yy2:=0;
   while sp>0 do begin
   	dec(sp);
      if sp<0 then
      	break;
      if sp>buffer.Count-1 then
      	buffer.Count:=buffer.Count+BUFALLOC;
      dy := PItem(buffer[sp])^.dy;
      y := PItem(buffer[sp])^.yy + dy;
      x1 := PItem(buffer[sp])^.xl;
      x2 := PItem(buffer[sp])^.xr;
      x := x1;
		if (y >= 0) and (y < BitmapHeight) then begin
         c := _GetPixelBw(pbyte(outbmp[y]),x);
			while (x>=0) and (x<BitmapWidth) and _eqpixel and (c=0) do begin
            _SetPixelBw(pbyte(outbmp[y]),x,1);
            if x<xx1 then xx1:=x;
            if x>xx2 then xx2:=x;
            if y<yy1 then yy1:=y;
            if y>yy2 then yy2:=y;
            dec(x);
            if x<0 then
            	break;
            c := _GetPixelBw(pbyte(outbmp[y]),x);
			end;
		end;
		if (y<0) then
			continue;
		if (y >= BitmapHeight) then dy:=-dy;
		enter:= (x >= x1);
      if not enter then begin
         start := x + 1;
         if (start < x1) then begin
            PItem(buffer[sp])^.yy := y;
            PItem(buffer[sp])^.xl := start;
            PItem(buffer[sp])^.xr := x1 - 1;
            PItem(buffer[sp])^.dy := -dy;
            inc(sp);
            if (sp<0) then
            	break;
            if sp>buffer.Count-1 then
            	buffer.Count:=buffer.Count+BUFALLOC;
         end;
         x := x1 + 1;
      end;
		repeat
      	if not enter then begin
            if (y>=0) and (y < BitmapHeight) then begin
               if x<bitmapwidth then
	               c := _GetPixelBw(pbyte(outbmp[y]),x)
               else
               	c:=0;
               while (x>=0) and (x<BitmapWidth) and _eqpixel and (c=0) do begin
                  _SetPixelBw(pbyte(outbmp[y]),x,1);
                  if x<xx1 then xx1:=x;
                  if x>xx2 then xx2:=x;
                  if y<yy1 then yy1:=y;
                  if y>yy2 then yy2:=y;
                  inc(x);
                  if x=BitmapWidth then
                  	break;
                  c := _GetPixelBw(pbyte(outbmp[y]),x);
               end;
            end;
            PItem(buffer[sp])^.yy := y;
            PItem(buffer[sp])^.xl := start;
            PItem(buffer[sp])^.xr := x - 1;
            PItem(buffer[sp])^.dy := dy;
            inc(sp);
            if sp<0 then
            	break;
            if sp>buffer.Count-1 then
            	buffer.Count:=buffer.Count+BUFALLOC;
            if (x > (x2 + 1)) then begin
               PItem(buffer[sp])^.yy := y;
               PItem(buffer[sp])^.xl := x2 + 1;
               PItem(buffer[sp])^.xr := x - 1;
               PItem(buffer[sp])^.dy := -dy;
               inc(sp);
               if sp<0 then
               	break;
               if sp>buffer.Count-1 then
               	buffer.Count:=buffer.Count+BUFALLOC;
            end;
         end else
         	enter:=false;
			inc(x);
			if (y >= 0) and (y < BitmapHeight) then begin
            if x<bitmapwidth then
	            c := _GetPixelBw(pbyte(outbmp[y]),x)
            else
            	c:=0;
				if (x2 >= bitmapWidth) then x2 := BitmapWidth-1;
				while (x<=x2) and ((not _eqpixel) or (c = 1)) do begin
					inc(x);
               if x=BitmapWidth then
               	break;
               c := _GetPixelBw(pbyte(outbmp[y]),x);
				end;
			end;
			start := x;
		until not (x <= x2);
		if sp>buffer.Count-1 then
      	buffer.Count:=buffer.Count+BUFALLOC;
	end;
	FreeAndNil(Buffer);
   // apply maximum filter in outbmp (result in obmp)
   dx:=xx2-xx1+1;
   dy:=yy2-yy1+1;
   getmem(obmp,sizeof(pointer)*dy);
   for q:=0 to dy-1 do
		obmp[q]:=allocmem(dx shr 3 +1);	// zero filled
   yy:=0;
	for row:=yy1 to yy2 do begin
      y1:=imax(0,yy-1);
      y2:=imin(dy-1,yy+1);
      xx:=0;
   	for col:=xx1 to xx2 do begin
      	if _GetPixelBw(pbyte(outbmp[row]),col)<>0 then begin
         	if maxfilter then begin
               x1:=imax(0,xx-1);
               x2:=imin(dx-1,xx+1);
               for q:=y1 to y2 do
                  for w:=x1 to x2 do begin
                     _SetPixelBw(obmp[q],w,1)
                  end;
            end else begin
					_SetPixelBw(obmp[yy],xx,1)
            end;
         end;
         inc(xx);
      end;
      inc(yy);
   end;
   // free outbmp
   for q:=0 to bitmapHeight-1 do
		freemem(outbmp[q]);
   freemem(outbmp);
   // resample obmp to 4x4 (result in fbmp)
   fdx:=2+4*dx+2;
   fdy:=2+4*dy+2;
	getmem(fbmp,fdy*sizeof(PBYTEROW));
   for q:=0 to fdy-1 do
   	fbmp[q]:=allocmem(fdx);	// zero filled (WHITE)
   for j:=0 to dy-1 do begin
   	opt1:=2+(j shl 2);
	   for i:=0 to dx-1 do begin
      	opt2:=2+(i shl 2);
      	if _GetPixelBw(obmp[j],i)<>0 then
	         for v:=0 to 3 do
         		for u:=0 to 3 do begin
               	fbmp[opt1+v][opt2+u]:=BLACK;
               end;
      end;
   end;
   // free obmp
   for q:=0 to dy-1 do
		freemem(obmp[q]);
   freemem(obmp);
   // PASS 1: LEFTWARDS
   flag:=false;
   for j:=0 to fdy-1 do
   	for i:=1 to fdx-1 do
	      if fbmp[j,i]=BLACK then begin
         	if not flag then begin
	            fbmp[j,i-1] := CONTOUR;
            	flag := true;
            end;
         end else
         	flag := false;
   // PASS 2: RIGHTWARDS
   for j:=0 to fdy-1 do
	   for i:=fdx-1 downto 0 do
	      if (fbmp[j,i] = BLACK) then begin
	         if not flag then begin
            	fbmp[j,i+1] := CONTOUR;
               flag := true;
            end;
         end else
         	flag := false;
   // PASS 3: DOWNWARDS
   flag := false;
   for i:=0 to fdx-1 do
   	for j:=0 to fdy-1 do
      	if (fbmp[j,i] = BLACK) then begin
	         if not flag then begin
            	fbmp[j-1,i] := CONTOUR;
               flag := true;
            end;
         end else
         	flag := false;
   // PASS 4: UPWARDS
   flag := false;
   for i:=0 to fdx-1 do
	   for j:=fdy-1 downto 0 do
			if (fbmp[j,i] = BLACK) then begin
				if not flag then begin
            	fbmp[j+1,i] := CONTOUR;
               flag := true;
            end;
         end else
				flag := false;
   //
   bbox[0]:=point(2147483647,2147483647);
   bbox[1]:=point(0,0);
   for j:=0 to fdy-1 do
   	for i:=1 to fdx-1 do
	      if fbmp[j,i]=CONTOUR then begin
            bbox[0].x := IMIN(i, bbox[0].x);
            bbox[0].y := IMIN(j, bbox[0].y);
            bbox[1].x := IMAX(i, bbox[1].x);
            bbox[1].y := IMAX(j, bbox[1].y);
         end;
   //
   distance:=2147483647;
   for j:=0 to fdy-1 do
	   for i:=1 to fdx-1 do
   	   if (fbmp[j,i]=CONTOUR) then begin
      	   d := (i-bbox[0].x) * (i-bbox[0].x) + (j-bbox[0].y) * (j-bbox[0].y);
            if (d < distance) then begin
         	   distance := d;
               start_pixel.x := i;
               start_pixel.y := j;
         	end;
         end;
	//
   code:=TIEByteArray.Create;
   pixel.x := start_pixel.x;
   pixel.y := start_pixel.y;
   fbmp[pixel.y, pixel.x] := VISITED;
   last_dir := 4;
   while (0 < 1) do begin
      addPt(pixel, contour_dir[last_dir], test_pixel);
      if (fbmp[test_pixel.y, test_pixel.x] = CONTOUR) then begin
         pixel.x := test_pixel.x;
         pixel.y := test_pixel.y;
         fbmp[pixel.y, pixel.x] := VISITED;
         code.AddByte(direction_code[last_dir]);
      end;
      for i:=0 to 7 do begin
          addPt(pixel, contour_dir[i], test_pixel);
          if (fbmp[test_pixel.y, test_pixel.x] = CONTOUR) then begin
             pixel.x := test_pixel.x;
             pixel.y := test_pixel.y;
             fbmp[pixel.y, pixel.x] := VISITED;
             code.AddByte(direction_code[i]);
             last_dir := i;
             break;
          end;
      end;
      if (i = 8) then
	      break;
   end;
   for i:=0 to 7 do begin
	   subPt(start_pixel, pixel, test_pixel);
      if (test_pixel.x=contour_dir[i].x) and (test_pixel.y=contour_dir[i].y) then begin
         code.AddByte(direction_code[i]);
         break;
      end;
   end;
   // free fbmp
   for q:=0 to fdy-1 do
   	freemem(fbmp[q]);
   freemem(fbmp);
   //
	pixel.x:=(start_pixel.x-1) + xx1*4;
   pixel.y:=(start_pixel.y-1) + yy1*4;
   rs:=TIERecordList.CreateList(sizeof(TPoint));
   rs.Add(@pixel);
   pcode:=pbyte(code.Data);
   pv:=pcode^;
   for q:=0 to code.Size-1 do begin
      if pv<>pcode^ then begin
	      rs.add(@pixel);
         pv:=pcode^;
      end;
		case pcode^ of
      	0:		// right
         			inc(pixel.x);
      	2:		// up
                  dec(pixel.y);
      	4:		// left
                  dec(pixel.x);
      	6: 	// down
                  inc(pixel.y);
      	1: 	begin
         			// up-right
                  dec(pixel.y);
                  inc(pixel.x);
         		end;
      	3: 	begin
         			// up-left
                  dec(pixel.y);
                  dec(pixel.x);
         		end;
      	5: 	begin
         			// down-left
                  inc(pixel.y);
                  dec(pixel.x);
         		end;
      	7: 	begin
         			// down-right
                  inc(pixel.y);
                  inc(pixel.x);
         		end;
      end;
      inc(pcode);
   end;
   FreeAndNil(code);
   for q:=0 to rs.count-1 do begin
   	with ppoint(rs[q])^ do begin
      	x:=x shr 2;
         y:=y shr 2;
      end;
   end;
	//
   pcount:=rs.Count;
   if pcount>0 then begin
      getmem(result,sizeof(TPoint)*pcount);
      copymemory(result,rs.Items[0],sizeof(TPoint)*pcount);
   end;
   FreeAndNil(rs);
end;

// Make a mask with a flood-fill at (x,y)
procedure _MakeMagicWandPointsEx(fBitmap:TIEBitmap; x,y:integer; maxfilter:boolean; tolerance:integer; mask:TIEMask);
type
	TItem=record
   	yy,xl,xr,dy:integer;
   end;
   PItem=^TItem;
var
	BUFALLOC:integer;	// allocation cluster size
   Buffer:TIERecordList;
   dy, sp, start, x1, x2, y1,y2:integer;
   c:integer;
   seed_color:TRGB;
   //col2:pbytearray;
   outbmp:pPRGBArray;
   j,i,v,u,q,w,row,col:integer;
   enter:boolean;
   xx1,yy1,xx2,yy2:integer;
   bitmapwidth,bitmapheight,opt1,opt2:integer;
   //
   (*
   function _eqpixel:boolean;
   var
      max, b, diff:integer;
      col1:pbytearray;
   begin
      if (x >= BitmapWidth) or (y >= BitmapHeight) then
         result:=false
      else begin
         col1 := pbytearray(@(PRGBROW(fBitmap.Scanline[y])[x]));
         max:=0;
         for b:=0 to 2 do begin
         	diff:=abs(col1[b]-col2[b]);
            if diff > max then
               max := diff;
         end;
         result:= max<=tolerance;
      end;
   end;
   *)
   function _eqpixel:boolean;
   var
      dr,dg,db:integer;
      col:TRGB;
   begin
      if (x >= BitmapWidth) or (y >= BitmapHeight) then
         result:=false
      else begin
      	col:=fBitmap.Pixels[x,y];
			dr:=abs( seed_color.r - col.r );
         dg:=abs( seed_color.g - col.g );
         db:=abs( seed_color.b - col.b );
         result:= (dr<tolerance) and (dg<tolerance) and (db<tolerance);
      end;
   end;
	//
begin
	(*
   if fBitmap.PixelFormat<>ie24RGB then
   	exit;
      *)
   bitmapwidth:=fbitmap.width;
   bitmapheight:=fbitmap.height;
	// Makes a flood fill bitmap (B/W) in outbmp
	if (x<0) or (x>=BitmapWidth) or (y<0) or (y>=BitmapHeight) then
   	exit;
	BUFALLOC:=2*fBitmap.Width;
   Buffer:=TIERecordList.CreateList(sizeof(TItem));
   Buffer.Count:=BUFALLOC;
	// make outbmp and fills with 0
   getmem(outbmp,fbitmap.height*sizeof(pRGB));
   for q:=0 to bitmapHeight-1 do
		outbmp[q]:=allocmem(fbitmap.width shr 3 +1);	// zero filled
	//
   //seed_color:=PRGBROW(fBitmap.Scanline[y])[x];
   seed_color:=fBitmap.Pixels[x,y];
   //col2 := pbytearray(@seed_color);
   start:=0;
	sp:=0;
	PItem(buffer[sp])^.yy := y;
	PItem(buffer[sp])^.xl := x;
	PItem(buffer[sp])^.xr := x;
	PItem(buffer[sp])^.dy := 1;
   inc(sp);
	PItem(buffer[sp])^.yy := y+1;
	PItem(buffer[sp])^.xl := x;
	PItem(buffer[sp])^.xr := x;
	PItem(buffer[sp])^.dy := -1;
   inc(sp);
   xx1:=2147483647; yy1:=2147483647; xx2:=0; yy2:=0;
   while sp>0 do begin
   	dec(sp);
      if sp<0 then
      	break;
      if sp>buffer.Count-1 then
      	buffer.Count:=buffer.Count+BUFALLOC;
      dy := PItem(buffer[sp])^.dy;
      y := PItem(buffer[sp])^.yy + dy;
      x1 := PItem(buffer[sp])^.xl;
      x2 := PItem(buffer[sp])^.xr;
      x := x1;
		if (y >= 0) and (y < BitmapHeight) then begin
         c := _GetPixelBw(pbyte(outbmp[y]),x);
			while (x>=0) and (x<BitmapWidth) and _eqpixel and (c=0) do begin
            _SetPixelBw(pbyte(outbmp[y]),x,1);
            if x<xx1 then xx1:=x;
            if x>xx2 then xx2:=x;
            if y<yy1 then yy1:=y;
            if y>yy2 then yy2:=y;
            dec(x);
            if x<0 then
            	break;
            c := _GetPixelBw(pbyte(outbmp[y]),x);
			end;
		end;
		if (y<0) then
			continue;
		if (y >= BitmapHeight) then dy:=-dy;
		enter:= (x >= x1);
      if not enter then begin
         start := x + 1;
         if (start < x1) then begin
            PItem(buffer[sp])^.yy := y;
            PItem(buffer[sp])^.xl := start;
            PItem(buffer[sp])^.xr := x1 - 1;
            PItem(buffer[sp])^.dy := -dy;
            inc(sp);
            if (sp<0) then
            	break;
            if sp>buffer.Count-1 then
            	buffer.Count:=buffer.Count+BUFALLOC;
         end;
         x := x1 + 1;
      end;
		repeat
      	if not enter then begin
            if (y>=0) and (y < BitmapHeight) then begin
               if x<bitmapwidth then
	               c := _GetPixelBw(pbyte(outbmp[y]),x)
               else
               	c:=0;
               while (x>=0) and (x<BitmapWidth) and _eqpixel and (c=0) do begin
                  _SetPixelBw(pbyte(outbmp[y]),x,1);
                  if x<xx1 then xx1:=x;
                  if x>xx2 then xx2:=x;
                  if y<yy1 then yy1:=y;
                  if y>yy2 then yy2:=y;
                  inc(x);
                  if x=BitmapWidth then
                  	break;
                  c := _GetPixelBw(pbyte(outbmp[y]),x);
               end;
            end;
            PItem(buffer[sp])^.yy := y;
            PItem(buffer[sp])^.xl := start;
            PItem(buffer[sp])^.xr := x - 1;
            PItem(buffer[sp])^.dy := dy;
            inc(sp);
            if sp<0 then
            	break;
            if sp>buffer.Count-1 then
            	buffer.Count:=buffer.Count+BUFALLOC;
            if (x > (x2 + 1)) then begin
               PItem(buffer[sp])^.yy := y;
               PItem(buffer[sp])^.xl := x2 + 1;
               PItem(buffer[sp])^.xr := x - 1;
               PItem(buffer[sp])^.dy := -dy;
               inc(sp);
               if sp<0 then
               	break;
               if sp>buffer.Count-1 then
               	buffer.Count:=buffer.Count+BUFALLOC;
            end;
         end else
         	enter:=false;
			inc(x);
			if (y >= 0) and (y < BitmapHeight) then begin
            if x<bitmapwidth then
	            c := _GetPixelBw(pbyte(outbmp[y]),x)
            else
            	c:=0;
				if (x2 >= bitmapWidth) then x2 := BitmapWidth-1;
				while (x<=x2) and ((not _eqpixel) or (c = 1)) do begin
					inc(x);
               if x=BitmapWidth then
               	break;
               c := _GetPixelBw(pbyte(outbmp[y]),x);
				end;
			end;
			start := x;
		until not (x <= x2);
		if sp>buffer.Count-1 then
      	buffer.Count:=buffer.Count+BUFALLOC;
	end;
	FreeAndNil(Buffer);
   // apply maximum filter in outbmp (result in obmp)
	for row:=yy1 to yy2 do begin
      y1:=imax(0,row-1);
      y2:=imin(bitmapheight-1,row+1);
   	for col:=xx1 to xx2 do begin
      	if _GetPixelBw(pbyte(outbmp[row]),col)<>0 then begin
         	if maxfilter then begin
               x1:=imax(0,col-1);
               x2:=imin(bitmapwidth-1,col+1);
               for q:=y1 to y2 do
                  for w:=x1 to x2 do begin
                     mask.SetPixel(w,q,1);
                  end;
            end else begin
            	mask.SetPixel(col,row,1)
            end;
         end;
      end;
   end;
   // free outbmp
   for q:=0 to bitmapHeight-1 do
		freemem(outbmp[q]);
   freemem(outbmp);
end;

// create a mask with all colors like (x,y)
// works only with pf24bit images
procedure _MakeMagicWandPointsEx2(fBitmap:TIEBitmap; x,y:integer; tolerance:integer; mask:TIEMask);
var
	row,col:integer;
   rowhi,colhi:integer;
   seed_color:TRGB;
   dr,dg,db:integer;
   v:TRGB;
begin
   rowhi:=fBitmap.Height-1;
   colhi:=fBitmap.Width-1;
   seed_color:=fBitmap.Pixels[x,y];
   for row:=0 to rowhi do begin
      for col:=0 to colhi do begin
         v:=fBitmap.Pixels[col,row];
         dr:=abs( seed_color.r - v.r );
         dg:=abs( seed_color.g - v.g );
         db:=abs( seed_color.b - v.b );
         if (dr<tolerance) and (dg<tolerance) and (db<tolerance) then
            mask.SetPixel(col,row,1);
      end;
   end;
end;

// Stretch origBmp to width,height of destBmp
// Use DrawDib api functions
procedure _IEBmpStretch(origBmp, destBmp:TBitmap);
(*$ifdef IEDELPHI*)
var
	hdb:HDRAWDIB;
   BitmapInfoHeader256:^TBitmapInfoHeader256;
begin
	destBmp.PixelFormat:=origBmp.PixelFormat;
   new(BitmapInfoHeader256);
   l3ZeroMemory(BitmapInfoHeader256,sizeof(TBitmapInfoHeader256));
   with BitmapInfoHeader256^ do begin
      biSize:=sizeof(TBitmapInfoHeader);
      biWidth:=origBmp.Width;
      biHeight:=origBmp.Height;
      biPlanes:=1;
      if origBmp.pixelformat=pf1bit then begin
          biBitCount:=1;
          Palette[1].rgbRed:=255;
          Palette[1].rgbGreen:=255;
          Palette[1].rgbBlue:=255;
      end else
          biBitCount:=24;
      biCompression:=BI_RGB;
   end;
	hdb:=IEDrawDibOpen;
   if destBmp.PixelFormat=pf1bit then
      destBmp.HandleType:=bmDDB;
   IEDrawDibDraw(hdb,destBmp.canvas.handle,0,0,destBmp.Width,destBmp.Height,PBitmapInfoHeader(BitmapInfoHeader256)^,origBmp.ScanLine[origBmp.height-1],
              0,0,origBmp.Width,origBmp.Height,0);
   if destBmp.HandleType=bmDDB then
      destBmp.HandleType:=bmDIB;
   IEDrawDibClose(hdb);
   dispose(BitmapInfoHeader256);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}


// origBmp.PixelFormat must be = detBmp.PixelFormat
procedure _IEBmpStretchEx(origBmp, destBmp:TIEBaseBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   x,y,sx:integer;
   zx,zy:double;
   sxarr:pintegerarray;
   d_rgb:PRGB;
   s_rgb:PRGBROW;
   d_g,s_g,bp:pbyte;
   s_ga:pbytearray;
   d_w:pword;
   s_wa:pwordarray;
   d_f:psingle;
   s_fa:psinglearray;
   l1,l2:TIEDataAccess;
   per1:double;
begin
	per1:=100/(destBmp.Height+0.5);
	l1:=origBmp.Access;
   l2:=destBmp.Access;
   origBmp.Access:=[iedRead];
   destBmp.Access:=[iedWrite];
   zx:=origBmp.Width/destBmp.Width;
   zy:=origBmp.Height/destBmp.Height;
   getmem(sxarr,sizeof(integer)*destBmp.Width);
   for x:=0 to destBmp.Width-1 do
      sxarr[x]:=trunc(x*zx);
   case origBmp.PixelFormat of
      ie1g:
         for y:=0 to destBmp.Height-1 do begin
            s_g:=origBmp.Scanline[trunc(y*zy)];
            d_g:=destBmp.Scanline[y];
            for x:=0 to destBmp.Width-1 do begin
               sx:=sxarr[x];
               //_SetPixelbw(d_g,x, pbytearray(s_g)^[sx shr 3] and iebitmask1[sx and $7] );
               bp:=pbyte(dword(d_g)+(dword(x) shr 3));
               if (pbytearray(s_g)^[sx shr 3] and iebitmask1[sx and $7]) <>0 then
                  bp^:=bp^ or iebitmask1[x and 7]
               else
                  bp^:=bp^ and not iebitmask1[x and 7];
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*y));
         end;
      ie8p,ie8g:
         for y:=0 to destBmp.Height-1 do begin
            s_ga:=origBmp.Scanline[trunc(y*zy)];
            d_g:=destBmp.Scanline[y];
            for x:=0 to destBmp.Width-1 do begin
               d_g^:=s_ga[sxarr[x]];
               inc(d_g);
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*y));
         end;
      ie16g:
         // to optimize
         for y:=0 to destBmp.Height-1 do begin
            s_wa:=origBmp.Scanline[trunc(y*zy)];
            d_w:=destBmp.Scanline[y];
            for x:=0 to destBmp.Width-1 do begin
               d_w^:=s_wa[sxarr[x]];
               inc(d_w);
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*y));
         end;
      ie24RGB:
         for y:=0 to destBmp.Height-1 do begin
            s_rgb:=origBmp.Scanline[trunc(y*zy)];
            d_rgb:=destBmp.Scanline[y];
            for x:=0 to destBmp.Width-1 do begin
               d_rgb^:=s_rgb[sxarr[x]];
               inc(d_rgb);
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*y));
         end;
      ie32f:
         // to optimize
         for y:=0 to destBmp.Height-1 do begin
            s_fa:=origBmp.Scanline[trunc(y*zy)];
            d_f:=destBmp.Scanline[y];
            for x:=0 to destBmp.Width-1 do begin
               d_f^:=s_fa[sxarr[x]];
               inc(d_f);
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*y));
         end;
   end;
   freemem(sxarr);
	origBmp.Access:=l1;
   destBmp.Access:=l2;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// Converts a row from a bit format to an other
// Allowed combinations:
//    "Xbits_to_Ybits"
//    1_to_1
//    1_to_4
//    1_to_8
//    1_to_24 (palette[2] required)
//    4_to_4
//    4_to_8
//    4_to_24 (palette[16] required)
//    8_to_1 (each byte in input must be 0 or 1. Compact input to output)
//    8_to_8
//    8_to_24 (palette[256] required)
//   	24_to_4 (Quantizer required)
//    24_to_8 (Quantizer required)
//    24_to_24
//    32_to_24 (remove alpha channel)
// true color are in BGR (or BGRA)
// returns the byte width of Output
function _ConvertXBitsToYBits(var Input,Output:TBYTEROW;Xbits,Ybits,Width:Word; Palette:array of TRGB; Quantizer:TObject):integer;
var
	X,Z,i:integer;
   B1:Byte;
   Q:TIEQuantizer;
begin
	Q:=TIEQuantizer(Quantizer);
   case Xbits of
      1:	// from 1 bit...
         case Ybits of
         	1: // ...to 1 bit
            	copymemory(@Output[0],@Input[0],(Width+7) Div 8);
            4:	// ...to 4 bit
               for X:=0 to Width-1 do begin
                  B1:=(Input[X shr 3] shr (7-(X mod 8))) and 1;
                  OutPut[X shr 1]:=OutPut[X shr 1] or (B1 shl ((1-(X mod 2))*4));
               end;
            8: // ...to 8 bit
               for X:=0 to Width-1 do begin
                  B1:=(Input[X shr 3] shr (7-(X mod 8) )) and 1;
                  OutPut[X]:=B1;
               end;
            24: // ...to 8*3 bit
               begin
                  Z:=0;
                  for X:=0 to Width-1 do begin
                     B1:=(Input[X shr 3] shr (7-(X mod 8))) and 1;
                     OutPut[Z+0]:=Palette[B1].b;
                     OutPut[Z+1]:=Palette[B1].g;
                     OutPut[Z+2]:=Palette[B1].r;
                     inc(Z,3);
                  end;
               end;
         end;
      4: // from 4 bit to...
         case Ybits of
            4: // ...to 4 bit
               CopyMemory(@Output[0],@Input[0],(Width+1) div 2);
            8: // ...to 8 bit
               for X:=0 to Width-1 do begin
                  B1:=(Input[X shr 1] shr ((1-(X mod 2))*4)) and $0F;
                  OutPut[X]:=B1;
               end;
            24: // ...to 24 bit
               begin
                  Z:=0;
                  for X:=0 to Width-1 do begin
                      B1:=(Input[X shr 1] shr ((1-(X mod 2))*4)) and $0F;
                      OutPut[Z+0]:=Palette[B1].b;
                      OutPut[Z+1]:=Palette[B1].g;
                      OutPut[Z+2]:=Palette[B1].r;
                      inc(Z,3);
                  end;
               end;
         end;
      8: // from 8 bit to...
         case Ybits of
            1: // ...to 1 bit (compact 8 bit to 1 bit)
               begin
               	l3zeromemory(@Output[0],(Width+7) Div 8);
                  for X:=0 to Width-1 do begin
                      B1:=InPut[X];
                      OutPut[X shr 3]:=OutPut[X shr 3] or (B1 shl (7-(X mod 8)));
                  end;
               end;
            8: // ...to 8 bit
               CopyMemory(@Output[0],@Input[0],Width);
            24:// ...to 24 bit
               begin
                  Z:=0;
                  for X:=0 to Width-1 do begin
                      B1:=Input[X];
                      OutPut[Z+0]:=Palette[B1].b;
                      OutPut[Z+1]:=Palette[B1].g;
                      OutPut[Z+2]:=Palette[B1].r;
                      inc(Z,3);
                  end;
              end;
         end;
      24: // from 24 bit...
         case Ybits of
         	4:	 // ...to 4 bit
					begin
               	Z:=0;
               	for X:=0 to Width-1 do begin
                  	B1:=Q.RGBIndex[ CreateRGB(Input[Z+2],Input[Z+1],Input[Z]) ];
                     OutPut[X shr 1]:=OutPut[X shr 1] or (B1 shl ((1-(X mod 2))*4));
                     inc(Z,3);
                  end;
               end;
            8:  // ...to 8 bit
            	begin
               	Z:=0;
                  for X:=0 to Width-1 do begin
                     Output[X]:=Q.RGBIndex[ CreateRGB(Input[Z+2],Input[Z+1],Input[Z]) ];
                     inc(Z,3);
                  end;
               end;
            24: // ...to 24 bit
               CopyMemory(@Output[0],@Input[0],Width*3);
         end;
      32: // from 32 bit...
      	case Ybits of
         	24: //...to 24 bit (bypass alpha channel)
            	begin
               	X:=0; Z:=0;
						for i:=0 to Width-1 do begin
							Output[X]:=Input[Z];
                     Output[X+1]:=Input[Z+1];
                     Output[X+2]:=Input[Z+2];
                     inc(X,3);
                     inc(Z,4);
                  end;
               end;
         end;
   end;
   case Ybits of
      1: result:=(Width+7) Div 8;
      4:	result:=(Width+1) div 2;
      8: result:=Width;
      24: result:=Width*3;
      else result:=0;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copy Source in Dest, inside area delimited by SelPoly
// x1,y1 up-left polygon limit
procedure _CopyPolygonBitmap(Dest:TBitmap; Source:TBitmap; x1,y1:integer; SelPoly:PPointArray; SelPolyCount:integer);
(*$ifdef IEDELPHI*)
var
   hrgn:THandle;
   p1,p2,q:integer;
begin
   p1:=0;
   for q:=0 to SelPolyCount do
   	if (q=SelPolyCount) or (SelPoly^[q].x=IESELBREAK) then begin
      	p2:=q-p1;
         hrgn:=CreatePolygonRgn(SelPoly^[p1],p2,ALTERNATE);
         SelectClipRgn(Dest.Canvas.Handle,hrgn);
         SetPolyFillMode(Dest.Canvas.Handle,ALTERNATE);
         Dest.Canvas.Draw(x1,y1,Source);
         SelectClipRgn(Dest.Canvas.Handle,0);
         DeleteObject(hrgn);
         p1:=q+1;
      end;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// TIETransitionEffects

//
constructor TIETransitionEffects.Create(Owner:TIEView);
begin
	inherited Create;
   //
   fOwner:=Owner;
   fSourceShot:=TBitmap.Create;
   fSourceShot.Width:=1;
	fSourceShot.Height:=1;
	fSourceShot.PixelFormat:=pf24bit;
   fTargetShot:=TBitmap.Create;
   fTargetShot.Width:=1;
	fTargetShot.Height:=1;
   fTargetShot.PixelFormat:=pf24bit;
   fActualView:=TBitmap.Create;
   fActualView.Width:=1;
   fActualView.Height:=1;
	fActualView.PixelFormat:=pf24bit;
   fRunning:=false;
   fTransition:=iettNone;
   fDuration:=1000;
   fSourceShotLines:=nil;
   fTargetShotLines:=nil;
   fActualViewLines:=nil;
   fUpdateOnStop:=false;
   fTimer:=TTimer.Create(fOwner);
   fTimer.Enabled:=false;
   fTimer.OnTimer:=TimerEvent;
   fTimer.Interval:=1;
end;

//
procedure TIETransitionEffects.Cleanup;
begin
	if fSourceShotLines<>nil then
	   freemem(fSourceShotLines);
   if fTargetShotLines<>nil then
	   freemem(fTargetShotLines);
   if fActualViewLines<>nil then
	   freemem(fActualViewLines);
   fSourceShotLines:=nil;
   fTargetShotLines:=nil;
   fActualViewLines:=nil;
	FreeAndNil(fTimer);
	FreeAndNil(fSourceShot);
   FreeAndNil(fTargetShot);
   FreeAndNil(fActualView);
	//
   inherited;
end;

//
procedure TIETransitionEffects.SetSizes(Width,Height:integer);
begin
	Stop;
   fWidth:=Width;
   fHeight:=Height;
   fActualView.Width:=fWidth;
   fActualView.Height:=fHeight;
   fSourceShot.Width:=fWidth;
   fSourceShot.Height:=fHeight;
   fTargetShot.Width:=fWidth;
   fTargetShot.Height:=fHeight;
end;

//
procedure TIETransitionEffects.Run(UpdateOnStop:boolean);
(*$ifdef IEDELPHI*)
var
	q:integer;
begin
	if fTransition=iettNone then
   	exit;
	if fRunning then
   	fOwner.NPUnLockPaint;
   fUpdateOnStop:=UpdateOnStop;
	fRunning:=true;
   fStep:=0;
   fAccum1:=0;
   fFrames:=0;
   if (fWidth<2) and (fHeight<2) then begin
   	fRunning:=false;
      exit;
   end;
   fOwner.LockPaint;
	if fSourceShotLines<>nil then
	   freemem(fSourceShotLines);
   if fTargetShotLines<>nil then
	   freemem(fTargetShotLines);
   if fActualViewLines<>nil then
	   freemem(fActualViewLines);
   getmem(fSourceShotLines,sizeof(pointer)*fHeight);
   getmem(fTargetShotLines,sizeof(pointer)*fHeight);
   getmem(fActualViewLines,sizeof(pointer)*fHeight);
	for q:=0 to fHeight-1 do begin
   	fSourceShotLines[q]:=fSourceShot.Scanline[q];
      fTargetShotLines[q]:=fTargetShot.Scanline[q];
      fActualViewLines[q]:=fActualView.scanline[q];
   end;
   fStartTick:=GetTickCount;
	fTimer.Enabled:=true;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}


//
procedure TIETransitionEffects.Stop;
begin
	if not fRunning then
   	exit;
	if fTransition=iettNone then
   	exit;
	fTimer.Enabled:=false;
	fRunning:=false;
   fActualView.Width:=1;
   fActualView.Height:=1;
   fSourceShot.Width:=1;
   fSourceShot.Height:=1;
   fTargetShot.Width:=1;
   fTargetShot.Height:=1;
   fOwner.NPUnLockPaint;
   if fUpdateOnStop then
	   fOwner.Update;
end;

//
procedure TIETransitionEffects.TimerEvent(Sender:TObject);
(*$ifdef IEDELPHI*)
var
	elap:dword;
begin
	if not fRunning then exit;
   inc(fFrames);
   // make transition
	case fTransition of
   	iettCrossDissolve:
      	CrossDissolve(fStep);
      iettFadeOut:
      	FadeOut(fStep);
      iettFadeIn:
      	FadeIn(fStep);
      iettFadeOutIn:
      	FadeOutIn(fStep);
      iettLeftRight1:
      	LeftRight1(fStep);
      iettLeftRight2:
      	LeftRight2(fStep);
      iettRightLeft1:
      	RightLeft1(fStep);
      iettRightLeft2:
      	RightLeft2(fStep);
      iettUpDown1:
      	UpDown1(fStep);
      iettUpDown2:
      	UpDown2(fStep);
      iettDownUp1:
      	DownUp1(fStep);
      iettDownUp2:
      	DownUp2(fStep);
      iettMoveLeftRight1:
      	MoveLeftRight1(fStep);
      iettMoveLeftRight2:
      	MoveLeftRight2(fStep);
      iettMoveRightLeft1:
      	MoveRightLeft1(fStep);
      iettMoveRightLeft2:
      	MoveRightLeft2(fStep);
      iettMoveUpDown1:
      	MoveUpDown1(fStep);
      iettMoveUpDown2:
      	MoveUpDown2(fStep);
      iettMoveDownUp1:
      	MoveDownUp1(fStep);
      iettMoveDownUp2:
      	MoveDownUp2(fStep);
      iettRandomPoints:
      	RandomPoints(fStep);
      iettFromUpLeft:
      	FromUpLeft(fStep);
      iettFromUpRight:
      	FromUpRight(fStep);
      iettFromBottomLeft:
      	FromBottomLeft(fStep);
      iettFromBottomRight:
      	FromBottomRight(fStep);
      iettRandomBoxes:
      	RandomBoxes(fStep);
      iettCenter1:
      	Center1(fStep);
      iettCenter2:
      	Center2(fStep);
      iettCenterZoom1:
      	CenterZoom1(fStep);
      iettCenterZoom2:
      	CenterZoom2(fStep);
   end;
   // paint result
	BitBlt(fOwner.GetCanvas.handle,0,0,fWidth,fHeight,fActualView.Canvas.Handle,0,0,SRCCOPY);
	//
   elap:=GetTickCount-fStartTick;
   if elap>=dword(fDuration) then
   	Stop;
	fStep:=trunc((elap/fDuration)*1024);
   if fStep>1024 then fStep:=1024;
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}


procedure TIETransitionEffects.RandomPoints(Step:integer);
var
	y,fRowLen:integer;
   px1,px2:PRGBROW;
   r:integer;
   s,q:integer;
begin
	fRowLen:=IEBitmapRowLen(fWidth,24,32);
	if fStep=0 then
   	CopyMemory(fActualViewLines[fHeight-1],fSourceShotLines[fHeight-1],fRowLen*fHeight)
   else begin
      q:=round(Step*fWidth*(Step/180) / 1024);
		s:=q-fAccum1;
      fAccum1:=q;
      for y:=0 to fHeight-1 do begin
         px1:=fActualViewLines[y];
         px2:=fTargetShotLines[y];
         for q:=0 to s-1 do begin
            r:=random(fWidth);
            px1^[r].r:=px2^[r].r;
            px1^[r].b:=px2^[r].b;
            px1^[r].g:=px2^[r].g;
         end;
      end;
   end;
end;

// fade from background
procedure TIETransitionEffects.FadeIn(Step:integer);
var
   x,y:integer;
   ppx,ppx3:pRGB;
   c1:integer;
   rr,gg,bb:integer;
begin
   c1:=1024-Step;
	with TColor2TRGB(fOwner.Background) do begin
   	rr:=r*c1;
      gg:=g*c1;
      bb:=b*c1;
   end;
   for y:=0 to fHeight-1 do begin
   	ppx:=fTargetShotLines[y];
      ppx3:=fActualViewLines[y];
      for x:=0 to fWidth-1 do begin
      	with ppx3^ do begin
            r:=(ppx^.r*Step+rr) shr 10;
            g:=(ppx^.g*Step+gg) shr 10;
            b:=(ppx^.b*Step+bb) shr 10;
         end;
         inc(ppx);
         inc(ppx3);
      end;
   end;
end;

procedure TIETransitionEffects.FadeOutIn(Step:integer);
begin
	if Step<512 then
   	FadeOut(Step*2)
   else
   	FadeIn((Step-512)*2);
end;

// dissolve to background
procedure TIETransitionEffects.FadeOut(Step:integer);
var
   x,y:integer;
   ppx,ppx3:pRGB;
   c1:integer;
   rr,gg,bb:integer;
begin
   c1:=1024-Step;
	with TColor2TRGB(fOwner.Background) do begin
   	rr:=r*Step;
      gg:=g*Step;
      bb:=b*Step;
   end;
   for y:=0 to fHeight-1 do begin
   	ppx:=fSourceShotLines[y];
      ppx3:=fActualViewLines[y];
      for x:=0 to fWidth-1 do begin
      	with ppx3^ do begin
            r:=(ppx^.r*c1+rr) shr 10;
            g:=(ppx^.g*c1+gg) shr 10;
            b:=(ppx^.b*c1+bb) shr 10;
         end;
         inc(ppx);
         inc(ppx3);
      end;
   end;
end;

//
procedure TIETransitionEffects.CrossDissolve(Step:integer);
var
   x,y:integer;
   ppx,ppx2,ppx3:pRGB;
   c1:integer;
begin
   c1:=1024-Step;
   for y:=0 to fHeight-1 do begin
   	ppx:=fSourceShotLines[y];
      ppx2:=fTargetShotLines[y];
      ppx3:=fActualViewLines[y];
      for x:=0 to fWidth-1 do begin
      	with ppx3^ do begin
            r:=(ppx^.r*c1+ppx2^.r*Step) shr 10;
            g:=(ppx^.g*c1+ppx2^.g*Step) shr 10;
            b:=(ppx^.b*c1+ppx2^.b*Step) shr 10;
         end;
         inc(ppx);
         inc(ppx2);
         inc(ppx3);
      end;
   end;
end;

//
procedure TIETransitionEffects.LeftRight1(Step:integer);
begin
(*$ifdef IEDELPHI*)
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,0,((Step*fWidth) shr 10),fHeight,fTargetShot.Canvas.Handle,0,0,SRCCOPY);
(*$endif*)
end;

procedure TIETransitionEffects.LeftRight2(Step:integer);
(*$ifdef IEDELPHI*)
var
	sx:integer;
begin
	sx:=(Step*fWidth) shr 10;
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,0,sx,fHeight,fTargetShot.Canvas.Handle,0,0,SRCCOPY);
   fActualView.Canvas.Pen.color:=clRed;
   fActualView.Canvas.MoveTo(sx,0);
   fActualView.canvas.LineTo(sx,fHeight);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

//
procedure TIETransitionEffects.RightLeft1(Step:integer);
(*$ifdef IEDELPHI*)
var
	sx,sx2:integer;
begin
	sx:=round(((1024-Step)*fWidth)/1024);
   sx2:=round((Step*fWidth)/1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,sx,0,sx2,fHeight,fTargetShot.Canvas.Handle,sx,0,SRCCOPY);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

//
procedure TIETransitionEffects.RightLeft2(Step:integer);
(*$ifdef IEDELPHI*)
var
	sx,sx2:integer;
begin
	sx:=round(((1024-Step)*fWidth) / 1024);
   sx2:=round((Step*fWidth) / 1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,sx,0,sx2,fHeight,fTargetShot.Canvas.Handle,sx,0,SRCCOPY);
   fActualView.Canvas.Pen.color:=clRed;
   fActualView.Canvas.MoveTo(sx,0);
   fActualView.canvas.LineTo(sx,fHeight);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.UpDown1(Step:integer);
(*$ifdef IEDELPHI*)
var
	sy:integer;
begin
   sy:=round((Step*fHeight) / 1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,0,fWidth,sy,fTargetShot.Canvas.Handle,0,0,SRCCOPY);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.UpDown2(Step:integer);
(*$ifdef IEDELPHI*)
var
	sy:integer;
begin
   sy:=round((Step*fHeight) / 1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,0,fWidth,sy,fTargetShot.Canvas.Handle,0,0,SRCCOPY);
   fActualView.Canvas.Pen.Color:=clRed;
   fActualView.Canvas.MoveTo(0,sy);
   fActualView.Canvas.LineTo(fWidth,sy);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.DownUp1(Step:integer);
(*$ifdef IEDELPHI*)
var
	sy,sy2:integer;
begin
	sy:=round(((1024-Step)*fHeight) / 1024);
   sy2:=round((Step*fHeight) / 1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,sy,fWidth,sy2,fTargetShot.Canvas.Handle,0,sy,SRCCOPY);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.DownUp2(Step:integer);
(*$ifdef IEDELPHI*)
var
	sy,sy2:integer;
begin
	sy:=round(((1024-Step)*fHeight) / 1024);
   sy2:=round((Step*fHeight) / 1024);
   if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   BitBlt(fActualView.Canvas.Handle,0,sy,fWidth,sy2,fTargetShot.Canvas.Handle,0,sy,SRCCOPY);
   fActualView.Canvas.Pen.Color:=clRed;
   fActualView.Canvas.MoveTo(0,sy);
   fActualView.Canvas.LineTo(fWidth,sy);
end;
(*$endif*)
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.MoveLeftRight1(Step:integer);
var
	sx,y:integer;
   ppx,ppx2:PRGB;
begin
	sx:=Step*fWidth shr 10;
	for y:=0 to fHeight-1 do begin
   	ppx:=fActualViewLines[y];
      ppx2:=fTargetShotLines[y];
      inc(ppx2,fWidth-sx);
   	CopyMemory(ppx,ppx2,sx*3);
      inc(ppx,sx);
      CopyMemory(ppx,fSourceShotLines[y],(fWidth-sx)*3);
   end;
end;

procedure TIETransitionEffects.MoveLeftRight2(Step:integer);
var
	sx,y:integer;
   ppx:PRGB;
begin
	sx:=Step*fWidth shr 10;
	for y:=0 to fHeight-1 do begin
   	ppx:=fActualViewLines[y];
   	CopyMemory(ppx,fTargetShotLines[y],sx*3);
      inc(ppx,sx);
      CopyMemory(ppx,fSourceShotLines[y],(fWidth-sx)*3);
   end;
end;

procedure TIETransitionEffects.MoveRightLeft1(Step:integer);
var
	sx,y:integer;
   ppx,ppx2:PRGB;
begin
	sx:=(1024-Step)*fWidth shr 10;
	for y:=0 to fHeight-1 do begin
   	ppx:=fActualViewLines[y];
      ppx2:=fSourceShotLines[y];
      inc(ppx2,fWidth-sx);
   	CopyMemory(ppx,ppx2,sx*3);
      inc(ppx,sx);
      CopyMemory(ppx,fTargetShotLines[y],(fWidth-sx)*3);
   end;
end;

procedure TIETransitionEffects.MoveRightLeft2(Step:integer);
var
	sx,y:integer;
   ppx:PRGB;
begin
	sx:=(1024-Step)*fWidth shr 10;
	for y:=0 to fHeight-1 do begin
   	ppx:=fActualViewLines[y];
   	CopyMemory(ppx,fSourceShotLines[y],sx*3);
      inc(ppx,sx);
      CopyMemory(ppx,fTargetShotLines[y],(fWidth-sx)*3);
   end;
end;

procedure TIETransitionEffects.MoveUpDown1(Step:integer);
var
	sy,fRowLen,y:integer;
begin
	sy:=Step*fHeight shr 10;
   fRowLen:=IEBitmapRowLen(fWidth,24,32);
   for y:=0 to sy-1 do
		CopyMemory(fActualViewLines[y],fTargetShotLines[fHeight-sy+y],fRowLen);
   for y:=sy to fHeight-1 do
   	CopyMemory(fActualViewLines[y],fSourceShotLines[y-sy],fRowLen);
end;

// source image go away
procedure TIETransitionEffects.MoveUpDown2(Step:integer);
var
	sy,fRowLen,y:integer;
begin
	sy:=Step*fHeight shr 10;
   fRowLen:=IEBitmapRowLen(fWidth,24,32);
   for y:=0 to sy-1 do
		CopyMemory(fActualViewLines[y],fTargetShotLines[y],fRowLen);
   for y:=sy to fHeight-1 do
   	CopyMemory(fActualViewLines[y],fSourceShotLines[y-sy],fRowLen);
end;

procedure TIETransitionEffects.MoveDownUp1(Step:integer);
var
	sy,fRowLen,y:integer;
begin
	sy:=(1024-Step)*fHeight shr 10;
   fRowLen:=IEBitmapRowLen(fWidth,24,32);
   for y:=0 to sy-1 do
		CopyMemory(fActualViewLines[y],fSourceShotLines[fHeight-sy+y],fRowLen);
   for y:=sy to fHeight-1 do
   	CopyMemory(fActualViewLines[y],fTargetShotLines[y-sy],fRowLen);
end;

// source image go away
procedure TIETransitionEffects.MoveDownUp2(Step:integer);
var
	sy,fRowLen,y:integer;
begin
	sy:=(1024-Step)*fHeight shr 10;
   fRowLen:=IEBitmapRowLen(fWidth,24,32);
   for y:=0 to sy-1 do
		CopyMemory(fActualViewLines[y],fSourceShotLines[fHeight-sy+y],fRowLen);
   for y:=sy to fHeight-1 do
   	CopyMemory(fActualViewLines[y],fTargetShotLines[y],fRowLen);
end;

procedure TIETransitionEffects.FromUpLeft(Step:integer);
var
	sx,sy:integer;
begin
	sx:=(1024-Step)*fWidth shr 10;
   sy:=(1024-Step)*fHeight shr 10;
   if Step=0 then
		fActualView.Canvas.Draw(0,0,fSourceShot);
   fActualView.Canvas.Draw(-sx,-sy,fTargetShot)
end;

procedure TIETransitionEffects.FromUpRight(Step:integer);
var
	sx,sy:integer;
begin
	sx:=(1024-Step)*fWidth shr 10;
   sy:=(1024-Step)*fHeight shr 10;
   if Step=0 then
		fActualView.Canvas.Draw(0,0,fSourceShot);
   fActualView.Canvas.Draw(sx,-sy,fTargetShot)
end;

procedure TIETransitionEffects.FromBottomLeft(Step:integer);
var
	sx,sy:integer;
begin
	sx:=(1024-Step)*fWidth shr 10;
   sy:=(1024-Step)*fHeight shr 10;
   if Step=0 then
		fActualView.Canvas.Draw(0,0,fSourceShot);
   fActualView.Canvas.Draw(-sx,sy,fTargetShot)
end;

procedure TIETransitionEffects.FromBottomRight(Step:integer);
var
	sx,sy:integer;
begin
	sx:=(1024-Step)*fWidth shr 10;
   sy:=(1024-Step)*fHeight shr 10;
   if Step=0 then
		fActualView.Canvas.Draw(0,0,fSourceShot);
   fActualView.Canvas.Draw(sx,sy,fTargetShot)
end;

procedure TIETransitionEffects.RandomBoxes(Step:integer);
{$ifdef IEDELPHI}
const
	boxdim=8;
var
	s,q,x,y:integer;
begin
   if fStep=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot)
   else begin
		q:=round(Step*(fWidth*fHeight div (boxdim*boxdim))*(Step/180) / 1024);
      s:=q-fAccum1;
      fAccum1:=q;
      for q:=0 to s-1 do begin
         x:=random(fWidth) and $fffffff8;
         y:=random(fheight) and $fffffff8;
         BitBlt(fActualView.Canvas.Handle,x,y,boxdim,boxdim,fTargetShot.Canvas.Handle,x,y,SRCCOPY);
      end;
   end;
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

// the new image begin from center
procedure TIETransitionEffects.Center1(Step:integer);
{$ifdef IEDELPHI}
var
	sx,sy:integer;
   sx2,sy2:integer;
   cx,cy:integer;
begin
	cx:=fWidth shr 1;
   cy:=fheight shr 1;
	sx:=(Step*cx) shr 10;
   sx2:=Step*fWidth shr 10;
   sy:=(Step*cy) shr 10;
   sy2:=step*fHeight shr 10;
	if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
	BitBlt(fActualView.Canvas.Handle,cx-sx,cy-sy,sx2,sy2,fTargetShot.Canvas.Handle,cx-sx,cy-sy,SRCCOPY);
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

// the old image collapse in the center
procedure TIETransitionEffects.Center2(Step:integer);
{$ifdef IEDELPHI}
var
	sx,sy:integer;
   sx2,sy2:integer;
   cx,cy:integer;
begin
	cx:=fWidth shr 1;
   cy:=fheight shr 1;
	sx:=((1024-Step)*cx) shr 10;
   sx2:=(1024-Step)*fWidth shr 10;
   sy:=((1024-Step)*cy) shr 10;
   sy2:=(1024-step)*fHeight shr 10;
  	fActualView.Canvas.Draw(0,0,fTargetShot);
	BitBlt(fActualView.Canvas.Handle,cx-sx,cy-sy,sx2,sy2,fSourceShot.Canvas.Handle,cx-sx,cy-sy,SRCCOPY);
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.CenterZoom1(Step:integer);
{$ifdef IEDELPHI}
var
	sx,sy:integer;
   sx2,sy2:integer;
   cx,cy:integer;
begin
	cx:=fWidth shr 1;
   cy:=fheight shr 1;
	sx:=(Step*cx) shr 10;
   sx2:=Step*fWidth shr 10;
   sy:=(Step*cy) shr 10;
   sy2:=step*fHeight shr 10;
	if Step=0 then
   	fActualView.Canvas.Draw(0,0,fSourceShot);
   StretchBlt(fActualView.Canvas.Handle,cx-sx,cy-sy,sx2,sy2,fTargetShot.Canvas.Handle,0,0,fWidth,fHeight,SRCCOPY);
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

procedure TIETransitionEffects.CenterZoom2(Step:integer);
{$ifdef IEDELPHI}
var
	sx,sy:integer;
   sx2,sy2:integer;
   cx,cy:integer;
begin
	cx:=fWidth shr 1;
   cy:=fheight shr 1;
	sx:=((1024-Step)*cx) shr 10;
   sx2:=(1024-Step)*fWidth shr 10;
   sy:=((1024-Step)*cy) shr 10;
   sy2:=(1024-step)*fHeight shr 10;
  	fActualView.Canvas.Draw(0,0,fTargetShot);
	StretchBlt(fActualView.Canvas.Handle,cx-sx,cy-sy,sx2,sy2,fSourceShot.Canvas.Handle,0,0,fWidth,fHeight,SRCCOPY);
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

// end of TIETransitionEffects
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

type
  // Type of a filter for use with Stretch()
  TFilterProc = function(Value: double): double;
  // Contributor for a pixel
  TContributor = record
  		pixel: integer;		// Source pixel
		weight: integer;		// Pixel weight
  end;
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  TRGBList = packed array[0..0] of TRGB;
  PRGBList = ^TRGBList;
  TFRGB = packed record
  		r, g, b	: double;
  end;
const
  ResampleFilters: array[0..7] of record
    Filter: TFilterProc;
    Width: double;
  end = (    (Filter: TriangleFilter; Width: 1.0),
			    (Filter: HermiteFilter; Width: 1.0),
			    (Filter: BellFilter; Width: 1.5),
			    (Filter: SplineFilter; Width: 2.0),
			    (Filter: Lanczos3Filter; Width: 3.0),
			    (Filter: MitchellFilter; Width: 2.0),
             (Filter: NearestFilter; Width: 1.0),
             (Filter: LinearFilter; Width: 1.0)    );


/////////////////////////////////////////////////////////////////////////////////////
// resample only specified alpha channel (8 bit)
// The algorithms and methods used in this function are based on the article
// "General Filtered Image Rescaling" by Dale Schumacher which appeared in the
// book Graphics Gems III, published by Academic Press, Inc.
procedure _ResampleAlphaEx(Src, Dst: TIEBitmap; FilterType:TResampleFilter);
type
   TContributorList = array[0..0] of TContributor;
   PContributorList = ^TContributorList;
   // List of source pixels contributing to a destination pixel
   TCList = record
       n: integer;
       p: PContributorList;
   end;
   TCListList = array[0..0] of TCList;
   PCListList = ^TCListList;
   TByteList=array [0..0] of byte;
   PByteLIst=^TByteList;
var
	filter:TFilterProc;
   fwidth:double;
	xscale, yscale	: double;		// Zoom scale factors
	i, j, k		   : integer;		// Loop variables
	center		      : double;		// Filter calculation variables
   weight:integer;
	width, fscale: double;		// Filter calculation variables
	left, right		: integer;		// Filter calculation variables
	n					: integer;		// Pixel number
	Work				: TIEMask;
	contrib			: PCListList;
	vv,tt					: integer;
	color				: byte;
	SourceLine,DestLine		: pbytelist;
	SourcePixel,DestPixel		: pbyte;
	Delta,DestDelta				: integer;
	SrcWidth,SrcHeight,DstWidth,DstHeight: integer;
   per1:double;
   t,t1,t2:integer;
begin
	if (FilterType=rfFastLinear) or (FilterType=rfBicubic) or (FilterType=rfBilinear) then begin
   	_ResampleLinearAlpha(Src,Dst,nil,nil);
   	exit;
   end;
   filter:=ResampleFilters[ord(FilterType)-1].Filter;
   fwidth:=ResampleFilters[ord(FilterType)-1].Width;
	DstWidth := Dst.Width;
	DstHeight := Dst.Height;
	SrcWidth := Src.Width;
	SrcHeight := Src.Height;
   if (SrcWidth=0) or (SrcHeight=0) then exit;
   if (SrcWidth<2) and (SrcHeight<2) then exit;
   //
   per1:=100/(SrcHeight+DstWidth+0.5);
	// Create intermediate image to hold horizontal zoom
	Work := TIEMask.Create;
	try
   Work.AllocateBits(DstWidth,SrcHeight,8);
   if (SrcWidth=1) or (DstWidth=1) then
	   xscale := DstWidth / SrcWidth
   else
   	xscale := (DstWidth-1)/(SrcWidth-1);
   if (SrcHeight=1) or (DstHeight=1) then
	   yscale := DstHeight / SrcHeight
   else
		yscale := (DstHeight-1) / (SrcHeight-1);
   // --------------------------------------------
   // Pre-calculate filter contributions for a row
   // -----------------------------------------------
   GetMem(contrib, DstWidth* sizeof(TCList));
   // Horizontal sub-sampling
   // Scales from bigger to smaller width
   if (xscale < 1.0) then begin
	   width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
      	   k := contrib^[i].n;
            contrib^[i].n := contrib^[i].n + 1;
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
         end;
      end;
   end else begin
   	// Horizontal super-sampling
      // Scales from smaller to bigger width
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
	      	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // ----------------------------------------------------
   // Apply filter to sample horizontally from Src to Work
   // ----------------------------------------------------
   for k := 0 to SrcHeight-1 do begin
   	SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth-1 do begin
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
         	t:=contrib^[i].p^[j].pixel;
            if t>=SrcWidth then t:=SrcWidth-1 else if t<0 then t:=0;
	      	color := SourceLine^[t];
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
         end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         // Set new pixel value
         DestPixel^ := color;
         // Move on to next column
         inc(DestPixel);
      end;
   end;
   // Free the memory allocated for horizontal filter weights
   for i := 0 to DstWidth-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   // Pre-calculate filter contributions for a column
   GetMem(contrib, DstHeight* sizeof(TCList));
   // Vertical sub-sampling
   // Scales from bigger to smaller height
   if (yscale < 1.0) then begin
   	width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
        	end;
      end
   end else begin
	   // Vertical super-sampling
      // Scales from smaller to bigger height
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
         	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // Apply filter to sample vertically from Work to Dst
   SourceLine := Work.ScanLine[0];
   Delta := - Work.Rowlen;
   DestLine := Dst.ScanLine[0];
   DestDelta := - Dst.Rowlen;
   t1:=integer(Work.Scanline[0]);
   t2:=integer(Work.Scanline[Work.Height-1]);
   if t1>t2 then iswap(t1,t2);
   inc(t2,abs(Delta)-1);
   for k := 0 to DstWidth-1 do begin
   	DestPixel := pointer(DestLine);
      for i := 0 to DstHeight-1 do begin
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
				t:=integer(SourceLine)+integer(contrib^[i].p^[j].pixel*Delta);
            if t<t1 then t:=t1 else if t>t2 then t:=t2;
            color := pbyte(t)^;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
        	end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         DestPixel^ := color;
         inc(integer(DestPixel), DestDelta);
      end;
      Inc(SourceLine, 1);
      Inc(DestLine, 1);
   end;
   // Free the memory allocated for vertical filter weights
   for i := 0 to DstHeight-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   finally
   	FreeAndNil(Work);
  	end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// resample 1bit TBitmap to 24bit Tbitmap
// The algorithms and methods used in this function are based on the article
// "General Filtered Image Rescaling" by Dale Schumacher which appeared in the
// book Graphics Gems III, published by Academic Press, Inc.
(*
procedure _Resample1bit(Src, Dst: TBitmap; FilterType:TResampleFilter);
type
   TContributorList = array[0..0] of TContributor;
   PContributorList = ^TContributorList;
   // List of source pixels contributing to a destination pixel
   TCList = record
       n: integer;
       p: PContributorList;
   end;
   TCListList = array[0..0] of TCList;
   PCListList = ^TCListList;
   TByteList=array [0..0] of byte;
   PByteLIst=^TByteList;
var
	filter:TFilterProc;
   fwidth:double;
	xscale, yscale	: double;		// Zoom scale factors
	i, j, k		   : integer;		// Loop variables
	center		      : double;		// Filter calculation variables
   weight:integer;
	width, fscale: double;		// Filter calculation variables
	left, right		: integer;		// Filter calculation variables
	n					: integer;		// Pixel number
	Work				: TIEMask;
	contrib			: PCListList;
	tt,vv			: integer;
	color				: byte;
	SourceLine		: pbytelist;
   DestLine:PRGB;
	SourcePixel,DestPixel		: pbyte;
   DestPixelRGB:PRGB;
	Delta,DestDelta				: integer;
	SrcWidth,SrcHeight,DstWidth,DstHeight: integer;
   per1:double;
   t,t1,t2:integer;
begin
	if (FilterType=rfFastLinear) or (FilterType=rfBicubic) or (FilterType=rfBilinear) then begin
		_ResampleLinear1Bit(Src,Dst,nil,nil);
      exit;
   end;
   filter:=ResampleFilters[ord(FilterType)-1].Filter;
   fwidth:=ResampleFilters[ord(FilterType)-1].Width;
	DstWidth := Dst.Width;
	DstHeight := Dst.Height;
	SrcWidth := Src.Width;
	SrcHeight := Src.Height;
   if (SrcWidth=0) or (SrcHeight=0) then exit;
   if (SrcWidth<2) and (SrcHeight<2) then exit;
   //
   per1:=100/(SrcHeight+DstWidth+0.5);
	// Create intermediate image to hold horizontal zoom
	Work := TIEMask.Create;
	try
   Work.AllocateBits(DstWidth,SrcHeight,8);
   if (SrcWidth=1) or (DstWidth=1) then
	   xscale := DstWidth / SrcWidth
   else
   	xscale := (DstWidth-1)/(SrcWidth-1);
   if (SrcHeight=1) or (DstHeight=1) then
	   yscale := DstHeight / SrcHeight
   else
		yscale := (DstHeight-1) / (SrcHeight-1);
   // --------------------------------------------
   // Pre-calculate filter contributions for a row
   // -----------------------------------------------
   GetMem(contrib, DstWidth* sizeof(TCList));
   // Horizontal sub-sampling
   // Scales from bigger to smaller width
   if (xscale < 1.0) then begin
	   width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
      	   k := contrib^[i].n;
            contrib^[i].n := contrib^[i].n + 1;
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
         end;
      end;
   end else begin
   	// Horizontal super-sampling
      // Scales from smaller to bigger width
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
	      	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // ----------------------------------------------------
   // Apply filter to sample horizontally from Src to Work
   // ----------------------------------------------------
   for k := 0 to SrcHeight-1 do begin
   	SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth-1 do begin
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
         	t:=contrib^[i].p^[j].pixel;
            if t>=SrcWidth then t:=SrcWidth-1 else if t<0 then t:=0;
            if pbytearray(SourceLine)^[t shr 3] and iebitmask1[t and $7] = 0 then
            	color:=0
            else
            	color:=255;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
         end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         // Set new pixel value
         DestPixel^ := color;
         // Move on to next column
         inc(DestPixel);
      end;
   end;
   // Free the memory allocated for horizontal filter weights
   for i := 0 to DstWidth-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   // Pre-calculate filter contributions for a column
   GetMem(contrib, DstHeight* sizeof(TCList));
   // Vertical sub-sampling
   // Scales from bigger to smaller height
   if (yscale < 1.0) then begin
   	width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
        	end;
      end
   end else begin
	   // Vertical super-sampling
      // Scales from smaller to bigger height
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
         	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // Apply filter to sample vertically from Work to Dst
   SourceLine := Work.ScanLine[0];
   Delta := - Work.Rowlen;
   DestLine := Dst.ScanLine[0];
   DestDelta := - _PixelFormat2RowLen(Dst.Width,Dst.PixelFormat);
   t1:=integer(Work.Scanline[0]);
   t2:=integer(Work.Scanline[Work.Height-1]);
   if t1>t2 then iswap(t1,t2);
   inc(t2,abs(Delta)-1);
   for k := 0 to DstWidth-1 do begin
   	DestPixelRGB := pointer(DestLine);
      for i := 0 to DstHeight-1 do begin
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
				t:=integer(SourceLine)+integer(contrib^[i].p^[j].pixel*Delta);
            if t<t1 then t:=t1 else if t>t2 then t:=t2;
            color:=pbyte( t )^;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
        	end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         with DestPixelRGB^ do begin
         	r := color;
            g := color;
            b := color;
         end;
         inc(integer(DestPixelRGB), DestDelta);
      end;
      Inc(SourceLine, 1);
      Inc(DestLine, 1);
   end;
   // Free the memory allocated for vertical filter weights
   for i := 0 to DstHeight-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   finally
   	FreeAndNil(Work);
  	end;
end;
*)

procedure _Resample1bitEx(Src, Dst: TIEBitmap; FilterType:TResampleFilter);
type
   TContributorList = array[0..0] of TContributor;
   PContributorList = ^TContributorList;
   // List of source pixels contributing to a destination pixel
   TCList = record
       n: integer;
       p: PContributorList;
   end;
   TCListList = array[0..0] of TCList;
   PCListList = ^TCListList;
   TByteList=array [0..0] of byte;
   PByteLIst=^TByteList;
var
	filter:TFilterProc;
   fwidth:double;
	xscale, yscale	: double;		// Zoom scale factors
	i, j, k		   : integer;		// Loop variables
	center		      : double;		// Filter calculation variables
   weight:integer;
	width, fscale: double;		// Filter calculation variables
	left, right		: integer;		// Filter calculation variables
	n					: integer;		// Pixel number
	Work				: TIEMask;
	contrib			: PCListList;
	tt,vv			: integer;
	color				: byte;
	SourceLine		: pbytelist;
	SourcePixel,DestPixel		: pbyte;
   DestPixelRGB:PRGB;
	Delta				: integer;
	SrcWidth,SrcHeight,DstWidth,DstHeight: integer;
   per1:double;
   t,t1,t2,DestCol:integer;
begin
	if (FilterType=rfFastLinear) or (FilterType=rfBicubic) or (FilterType=rfBilinear) then begin
		_ResampleLinear1BitEx(Src,Dst,nil,nil);
      exit;
   end;
   filter:=ResampleFilters[ord(FilterType)-1].Filter;
   fwidth:=ResampleFilters[ord(FilterType)-1].Width;
	DstWidth := Dst.Width;
	DstHeight := Dst.Height;
	SrcWidth := Src.Width;
	SrcHeight := Src.Height;
   if (SrcWidth=0) or (SrcHeight=0) then exit;
   if (SrcWidth<2) and (SrcHeight<2) then exit;
   //
   per1:=100/(SrcHeight+DstWidth+0.5);
	// Create intermediate image to hold horizontal zoom
	Work := TIEMask.Create;
	try
   Work.AllocateBits(DstWidth,SrcHeight,8);
   if (SrcWidth=1) or (DstWidth=1) then
	   xscale := DstWidth / SrcWidth
   else
   	xscale := (DstWidth-1)/(SrcWidth-1);
   if (SrcHeight=1) or (DstHeight=1) then
	   yscale := DstHeight / SrcHeight
   else
		yscale := (DstHeight-1) / (SrcHeight-1);
   // --------------------------------------------
   // Pre-calculate filter contributions for a row
   // -----------------------------------------------
   GetMem(contrib, DstWidth* sizeof(TCList));
   // Horizontal sub-sampling
   // Scales from bigger to smaller width
   if (xscale < 1.0) then begin
	   width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
      	   k := contrib^[i].n;
            contrib^[i].n := contrib^[i].n + 1;
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
         end;
      end;
   end else begin
   	// Horizontal super-sampling
      // Scales from smaller to bigger width
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
	      	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // ----------------------------------------------------
   // Apply filter to sample horizontally from Src to Work
   // ----------------------------------------------------
   for k := 0 to SrcHeight-1 do begin
   	SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth-1 do begin
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
         	t:=contrib^[i].p^[j].pixel;
            if t>=SrcWidth then t:=SrcWidth-1 else if t<0 then t:=0;
            if pbytearray(SourceLine)^[t shr 3] and iebitmask1[t and $7] = 0 then
            	color:=0
            else
            	color:=255;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
         end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         // Set new pixel value
         DestPixel^ := color;
         // Move on to next column
         inc(DestPixel);
      end;
   end;
   // Free the memory allocated for horizontal filter weights
   for i := 0 to DstWidth-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   // Pre-calculate filter contributions for a column
   GetMem(contrib, DstHeight* sizeof(TCList));
   // Vertical sub-sampling
   // Scales from bigger to smaller height
   if (yscale < 1.0) then begin
   	width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
        	end;
      end
   end else begin
	   // Vertical super-sampling
      // Scales from smaller to bigger height
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
         	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	contrib^[i].n := contrib^[i].n + 1;
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // Apply filter to sample vertically from Work to Dst
   SourceLine := Work.ScanLine[0];
   Delta := - Work.Rowlen;
	DestCol :=0;
   t1:=integer(Work.Scanline[0]);
   t2:=integer(Work.Scanline[Work.Height-1]);
   if t1>t2 then iswap(t1,t2);
   inc(t2,abs(Delta)-1);
   for k := 0 to DstWidth-1 do begin
      for i := 0 to DstHeight-1 do begin
      	DestPixelRGB:=Dst.Scanline[i];
         inc(DestPixelRGB,DestCol);
         vv := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
				t:=integer(SourceLine)+integer(contrib^[i].p^[j].pixel*Delta);
            if t<t1 then t:=t1 else if t>t2 then t:=t2;
            color:=pbyte( t )^;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            inc(vv, color*weight);
        	end;
         if tt=0 then
         	color:=blimit(vv shr 8)
         else
         	color:=blimit(vv div tt);
         with DestPixelRGB^ do begin
         	r := color;
            g := color;
            b := color;
         end;
      end;
      Inc(SourceLine, 1);
		inc(DestCol);
   end;
   // Free the memory allocated for vertical filter weights
   for i := 0 to DstHeight-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   finally
   	FreeAndNil(Work);
  	end;
end;


/////////////////////////////////////////////////////////////////////////////////////
// works only with 24bit source images
// Slow resample (no optimized, but also apply filters to subsampling)
// The algorithms and methods used in this function are based on the article
// "General Filtered Image Rescaling" by Dale Schumacher which appeared in the
// book Graphics Gems III, published by Academic Press, Inc.
(*
procedure _Resample(Src, Dst: TBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
type
   TContributorList = array[0..0] of TContributor;
   PContributorList = ^TContributorList;
   // List of source pixels contributing to a destination pixel
   TCList = record
       n: integer;
       p: PContributorList;
   end;
   TCListList = array[0..0] of TCList;
   PCListList = ^TCListList;
var
	filter:TFilterProc;
   fwidth:double;
	xscale, yscale	: double;		// Zoom scale factors
	i, j, k		   : integer;		// Loop variables
   t,t1,t2:integer;
	center		      : double;		// Filter calculation variables
   weight:integer;
	width, fscale: double;		// Filter calculation variables
	left, right		: integer;		// Filter calculation variables
	n					: integer;		// Pixel number
	Work				: TBitmap;
	contrib			: PCListList;
	rgb					: TFRGB;
	color				: TRGB;
	SourceLine,DestLine		: PRGBList;
	SourcePixel,DestPixel		: PRGB;
	Delta,DestDelta				: integer;
	SrcWidth,SrcHeight,DstWidth,DstHeight: integer;
   per1:double;
   rr,gg,bb,tt:integer;
begin
	if Src.Pixelformat<>pf24bit then exit;
   if (FilterType=rfFastLinear) or (FilterType=rfBicubic) or (FilterType=rfBilinear) then begin
   	_ResampleLinear(Src,Dst,fOnProgress,Sender);
      exit;
   end;
   filter:=ResampleFilters[ord(FilterType)-1].Filter;
   fwidth:=ResampleFilters[ord(FilterType)-1].Width;
	DstWidth := Dst.Width;
	DstHeight := Dst.Height;
	SrcWidth := Src.Width;
	SrcHeight := Src.Height;
   if (SrcWidth=0) or (SrcHeight=0) then exit;
   if (SrcWidth<2) and (SrcHeight<2) then exit;
   //
   per1:=100/(SrcHeight+DstWidth+0.5);
	// Create intermediate image to hold horizontal zoom
	Work := TBitmap.Create;
	try
	Work.Height := SrcHeight;
   Work.Width := DstWidth;
   if (SrcWidth=1) or (DstWidth=1) then
	   xscale := DstWidth / SrcWidth
   else
   	xscale := (DstWidth-1)/(SrcWidth-1);
   if (SrcHeight=1) or (DstHeight=1) then
	   yscale := DstHeight / SrcHeight
   else
		yscale := (DstHeight-1) / (SrcHeight-1);
   // This implementation only works on 24-bit images because it uses
   // TBitmap.Scanline
   Src.PixelFormat := pf24bit;
   Dst.PixelFormat := Src.PixelFormat;
   Work.PixelFormat := Src.PixelFormat;
   // --------------------------------------------
   // Pre-calculate filter contributions for a row
   // -----------------------------------------------
   GetMem(contrib, DstWidth* sizeof(TCList));
   // Horizontal sub-sampling
   // Scales from bigger to smaller width
   if (xscale < 1.0) then begin
	   width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
      	   k := contrib^[i].n;
            inc(contrib^[i].n);
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
         end;
      end;
   end else begin
   	// Horizontal super-sampling
      // Scales from smaller to bigger width
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
	      	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // ----------------------------------------------------
   // Apply filter to sample horizontally from Src to Work
   // ----------------------------------------------------
   for k := 0 to SrcHeight-1 do begin
   	SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth-1 do begin
         rr := 0;
         gg := 0;
         bb := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
         	t:=contrib^[i].p^[j].pixel;
            if t>=SrcWidth then
	            t:=SrcWidth-1
            else if t<0 then
	            t:=0;
            color := SourceLine^[t];
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            with color do begin
	            inc(rr, r*weight );
               inc(gg, g*weight );
               inc(bb, b*weight );
            end;
         end;
         if tt=0 then with color do begin
         	r:=blimit(rr shr 8);
            g:=blimit(gg shr 8);
            b:=blimit(bb shr 8);
         end else with color do begin
         	r:=blimit(rr div tt);
            g:=blimit(gg div tt);
            b:=blimit(bb div tt);
         end;
         // Set new pixel value
         DestPixel^ := color;
         // Move on to next column
         inc(DestPixel);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(k+1)));
   end;
   // Free the memory allocated for horizontal filter weights
   for i := 0 to DstWidth-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   // Pre-calculate filter contributions for a column
   GetMem(contrib, DstHeight* sizeof(TCList));
   // Vertical sub-sampling
   // Scales from bigger to smaller height
   if (yscale < 1.0) then begin
   	width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
        	end;
      end
   end else begin
	   // Vertical super-sampling
      // Scales from smaller to bigger height
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
         	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // Apply filter to sample vertically from Work to Dst
   SourceLine := Work.ScanLine[0];
   Delta := - _PixelFormat2RowLen(Work.Width,Work.pixelformat);
   DestLine := Dst.ScanLine[0];
   DestDelta := - _PixelFormat2RowLen(Dst.Width,Dst.pixelformat);
   t1:=integer(Work.Scanline[0]);
   t2:=integer(Work.Scanline[Work.Height-1]);
   if t1>t2 then iswap(t1,t2);
   inc(t2,abs(Delta)-1);
   for k := 0 to DstWidth-1 do begin
   	DestPixel := pointer(DestLine);
      for i := 0 to DstHeight-1 do begin
         rr := 0;
         gg := 0;
         bb := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
				t:=integer(SourceLine)+integer(contrib^[i].p^[j].pixel*Delta);
            if t<t1 then t:=t1 else if t>t2 then t:=t2;
            color := PRGB(t)^;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            with color do begin
	            inc(rr, r*weight );
               inc(gg, g*weight );
               inc(bb, b*weight );
            end;
        	end;
         if tt=0 then with color do begin
         	r:=blimit(rr shr 8);
            g:=blimit(gg shr 8);
            b:=blimit(bb shr 8);
         end else with color do begin
         	r:=blimit(rr div tt);
            g:=blimit(gg div tt);
            b:=blimit(bb div tt);
         end;
         DestPixel^ := color;
         inc(integer(DestPixel), DestDelta);
      end;
      inc(t1);
      Inc(SourceLine, 1);
      Inc(DestLine, 1);
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(k+SrcHeight+1)));
   end;
   // Free the memory allocated for vertical filter weights
   for i := 0 to DstHeight-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   finally
   	FreeAndNil(Work);
  	end;
end;
*)

procedure _ResampleEx(Src, Dst: TIEBaseBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
type
   TContributorList = array[0..0] of TContributor;
   PContributorList = ^TContributorList;
   // List of source pixels contributing to a destination pixel
   TCList = record
       n: integer;
       p: PContributorList;
   end;
   TCListList = array[0..0] of TCList;
   PCListList = ^TCListList;
var
	filter:TFilterProc;
   fwidth:double;
	xscale, yscale	: double;		// Zoom scale factors
	i, j, k		   : integer;		// Loop variables
   t,t1,t2:integer;
	center		      : double;		// Filter calculation variables
   weight:integer;
	width, fscale: double;		// Filter calculation variables
	left, right		: integer;		// Filter calculation variables
	n					: integer;		// Pixel number
	Work				: TIEWorkBitmap;
	contrib			: PCListList;
	rgb					: TFRGB;
	color				: TRGB;
	SourceLine		: PRGBList;
	SourcePixel,DestPixel		: PRGB;
	Delta				: integer;
	SrcWidth,SrcHeight,DstWidth,DstHeight: integer;
   per1:double;
   rr,gg,bb,tt,DestCol:integer;
begin
	if Src.Pixelformat<>ie24RGB then exit;
   if FilterType=rfFastLinear then begin
   	_ResampleLinearEx(Src,Dst,fOnProgress,Sender);
      exit;
   end;
   if (FilterType=rfBicubic) then begin
   	_IEQResample(Src,Dst,1,fOnProgress,Sender);
      exit;
   end;
   if (FilterType=rfBilinear) then begin
   	_IEQResample(Src,Dst,0,fOnProgress,Sender);
      exit;
   end;
   filter:=ResampleFilters[ord(FilterType)-1].Filter;
   fwidth:=ResampleFilters[ord(FilterType)-1].Width;
	DstWidth := Dst.Width;
	DstHeight := Dst.Height;
	SrcWidth := Src.Width;
	SrcHeight := Src.Height;
   if (SrcWidth=0) or (SrcHeight=0) then exit;
   if (SrcWidth<2) and (SrcHeight<2) then exit;
   //
   per1:=100/(SrcHeight+DstWidth+0.5);
	// Create intermediate image to hold horizontal zoom
   work:=nil;
	try
   if (SrcWidth=1) or (DstWidth=1) then
	   xscale := DstWidth / SrcWidth
   else
   	xscale := (DstWidth-1)/(SrcWidth-1);
   if (SrcHeight=1) or (DstHeight=1) then
	   yscale := DstHeight / SrcHeight
   else
		yscale := (DstHeight-1) / (SrcHeight-1);
   // This implementation only works on 24-bit images
	Work := TIEWorkBitmap.Create(DstWidth,SrcHeight,24);
   // --------------------------------------------
   // Pre-calculate filter contributions for a row
   // -----------------------------------------------
   GetMem(contrib, DstWidth* sizeof(TCList));
   // Horizontal sub-sampling
   // Scales from bigger to smaller width
   if (xscale < 1.0) then begin
	   width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
      	   k := contrib^[i].n;
            inc(contrib^[i].n);
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
         end;
      end;
   end else begin
   	// Horizontal super-sampling
      // Scales from smaller to bigger width
      for i := 0 to DstWidth-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / xscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
	      	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcWidth) then n := SrcWidth - j + SrcWidth - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // ----------------------------------------------------
   // Apply filter to sample horizontally from Src to Work
   // ----------------------------------------------------
   for k := 0 to SrcHeight-1 do begin
   	SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth-1 do begin
         rr := 0;
         gg := 0;
         bb := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
         	t:=contrib^[i].p^[j].pixel;
            if t>=SrcWidth then
	            t:=SrcWidth-1
            else if t<0 then
	            t:=0;
            color := SourceLine^[t];
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            with color do begin
	            inc(rr, r*weight );
               inc(gg, g*weight );
               inc(bb, b*weight );
            end;
         end;
         if tt=0 then with color do begin
         	r:=blimit(rr shr 8);
            g:=blimit(gg shr 8);
            b:=blimit(bb shr 8);
         end else with color do begin
         	r:=blimit(rr div tt);
            g:=blimit(gg div tt);
            b:=blimit(bb div tt);
         end;
         // Set new pixel value
         DestPixel^ := color;
         // Move on to next column
         inc(DestPixel);
      end;
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(k+1)));
   end;
   // Free the memory allocated for horizontal filter weights
   for i := 0 to DstWidth-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   // Pre-calculate filter contributions for a column
   GetMem(contrib, DstHeight* sizeof(TCList));
   // Vertical sub-sampling
   // Scales from bigger to smaller height
   if (yscale < 1.0) then begin
   	width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - width);
         right := ieceil(center + width);
         for j := left to right do begin
         	weight := round(256*filter((center - j) / fscale) / fscale);
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
        	end;
      end
   end else begin
	   // Vertical super-sampling
      // Scales from smaller to bigger height
      for i := 0 to DstHeight-1 do begin
      	contrib^[i].n := 0;
         GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
         center := i / yscale;
         left := floor(center - fwidth);
         right := ieceil(center + fwidth);
         for j := left to right do begin
         	weight := round(256*filter(center - j));
            if (weight = 0) then continue;
            if (j < 0) then n := -j
            else if (j >= SrcHeight) then n := SrcHeight - j + SrcHeight - 1
            else n := j;
          	k := contrib^[i].n;
          	inc(contrib^[i].n);
          	contrib^[i].p^[k].pixel := n;
          	contrib^[i].p^[k].weight := weight;
         end;
      end;
   end;
   // Apply filter to sample vertically from Work to Dst
   SourceLine := Work.ScanLine[0];
   Delta := - Work.RowLen;
   DestCol:=0;
   t1:=integer(Work.Scanline[0]);
   t2:=integer(Work.Scanline[Work.Height-1]);
   if t1>t2 then iswap(t1,t2);
   inc(t2,abs(Delta)-1);
   for k := 0 to DstWidth-1 do begin
      for i := 0 to DstHeight-1 do begin
         DestPixel := Dst.Scanline[i];
         inc(DestPixel,DestCol);
         rr := 0;
         gg := 0;
         bb := 0;
         tt := 0;
         for j := 0 to contrib^[i].n-1 do begin
				t:=integer(SourceLine)+integer(contrib^[i].p^[j].pixel*Delta);
            if t<t1 then t:=t1 else if t>t2 then t:=t2;
            color := PRGB(t)^;
            weight := contrib^[i].p^[j].weight;
            inc(tt,weight);
            if (weight = 0) then continue;
            with color do begin
	            inc(rr, r*weight );
               inc(gg, g*weight );
               inc(bb, b*weight );
            end;
        	end;
         if tt=0 then with color do begin
         	r:=blimit(rr shr 8);
            g:=blimit(gg shr 8);
            b:=blimit(bb shr 8);
         end else with color do begin
         	r:=blimit(rr div tt);
            g:=blimit(gg div tt);
            b:=blimit(bb div tt);
         end;
         DestPixel^ := color;
      end;
      inc(t1);
      Inc(SourceLine, 1);
      Inc(DestCol);
      if assigned(fOnProgress) then
      	fOnProgress(Sender,trunc(per1*(k+SrcHeight+1)));
   end;
   // Free the memory allocated for vertical filter weights
   for i := 0 to DstHeight-1 do
   	FreeMem(contrib^[i].p);
   FreeMem(contrib);
   finally
   	FreeAndNil(Work);
  	end;
end;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Shen-Castan edge detector


// Create TIEWorkBitmap filled with gray scale of the original bitmap (pf24bit)
function sh_CreateGrayPixMap(Source:TIEBitmap):TIEWorkBitmap;
var
	x,y,width,height:integer;
   px:pbyte;
   rgb:PRGB;
begin
	width:=Source.Width;
   height:=Source.Height;
   result:=TIEWorkBitmap.Create(width,height,8);
	for y:=0 to height-1 do begin
   	px:=result.Scanline[y];
      rgb:=Source.Scanline[y];
   	for x:=0 to width-1 do begin
      	with rgb^ do
	      	px^:=(r*21 + g*71 + b*8) div 100;
      	inc(px);
         inc(rgb);
      end;
   end;
end;

const sh_OUTLINE=25;

type
   tsh_rc=record
      imwidth,imheight:integer;
      b:double;
      high_thresh,low_thresh:double;
      ratio:double;
      window_size:integer;
      do_hysteresis:boolean;
      lap:TIEWorkBitmap;
      nr, nc:integer;
      edges:TIEWorkBitmap;
      thinFactor:integer;
      Progress:TProgressRec;
   end;

procedure sh_embed(var im:TIEWorkBitmap; width:integer; var rc:tsh_rc);
var
	i,j,_I,_J:integer;
	xnew:TIEWorkBitmap;
   pb:pbyte;
begin
	inc(width,2);
   xnew:=TIEWorkBitmap.Create(im.Width+width+width, im.Height+width+width , 8);
	for i:=0 to xnew.Height-1 do begin
   	pb:=xnew.Scanline[i];
      _I := (i-width+im.Height) mod im.Height;
      for j:=0 to xnew.Width-1 do begin
         _J := (j-width+im.Width) mod im.Width;
         pb^ := im.GetPByte(_I,_J)^;
         inc(pb);
      end;
   end;
   FreeAndNil(im);
   im:=xnew;
end;

procedure sh_apply_ISEF_vertical(var x:TIEWorkBitmap; var y:TIEWorkBitmap; var A:TIEWorkBitmap; var B:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc);
var
	row, col:integer;
	b1, b2:double;
   ps1,ps2,ps3:psingle;
begin
	b1 := (1.0 - rc.b)/(1.0 + rc.b);
	b2 := rc.b*b1;
	for col:=0 to ncols-1 do begin
	   A.GetPSingle(0,col)^ := b1 * x.GetPSingle(0,col)^;
	   B.GetPSingle(nrows-1,col)^ := b2 * x.GetPSingle(nrows-1,col)^;
	end;
	for row:=1 to nrows-1 do begin
   	ps1:=A.Scanline[row];
      ps2:=A.Scanline[row-1];
      ps3:=x.Scanline[row];
   	for col:=0 to ncols-1 do begin
         ps1^ := b1 * ps3^ + rc.b * ps2^;
         inc(ps1);
         inc(ps2);
         inc(ps3);
      end;
   end;
	for row:=nrows-2 downto 0 do begin
   	ps1:=B.Scanline[row];
      ps2:=x.Scanline[row];
      ps3:=B.Scanline[row+1];
   	for col:=0 to ncols-1 do begin
         ps1^ := b2 * ps2^ + rc.b * ps3^;
         inc(ps1);
         inc(ps2);
         inc(ps3);
      end;
   end;
   ps1:=y.Scanline[nrows-1];
   ps2:=A.Scanline[nrows-1];
	for col:=0 to ncols-1 do begin
      ps1^ := ps2^;
      inc(ps1);
      inc(ps2);
   end;
	for row:=0 to nrows-2 do begin
   	ps1:=y.Scanline[row];
      ps2:=A.Scanline[row];
      ps3:=B.Scanline[row+1];
   	for col:=0 to ncols-1 do begin
         ps1^ := ps2^ + ps3^;
         inc(ps1);
         inc(ps2);
         inc(ps3);
      end;
   end;
end;

procedure sh_apply_ISEF_horizontal(var x:TIEWorkBitmap; var y:TIEWorkBitmap; var A:TIEWorkBitmap; var B:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc);
var
	row, col:integer;
	b1, b2:double;
   ps1,ps2,ps3:psingle;
   rlA,rlx,rlB:integer;
begin
	b1 := (1.0 - rc.b)/(1.0 + rc.b);
	b2 := rc.b*b1;
	for row:=0 to nrows-1 do begin
	   A.GetPSingle(row,0)^ := b1 * x.GetPSingle(row,0)^;
	   B.GetPSingle(row,ncols-1)^ := b2 * x.GetPSingle(row,ncols-1)^;
	end;
	rlA:=A.Rowlen div 4;
   rlx:=x.Rowlen div 4;
   rlB:=B.Rowlen div 4;
	for col:=1 to ncols-1 do begin
   	ps1:=A.GetPSingle(0,col);
      ps2:=x.GetPSingle(0,col);
      ps3:=A.GetPSingle(0,col-1);
   	for row:=0 to nrows-1 do begin
         ps1^ := b1 * ps2^ + rc.b * ps3^;
         dec(ps1,rlA);
         dec(ps2,rlx);
         dec(ps3,rlA);
      end;
   end;
	for col:=ncols-2 downto 0 do begin
   	ps1:=B.GetPSingle(0,col);
      ps2:=x.GetPSingle(0,col);
      ps3:=B.GetPSingle(0,col+1);
   	for row:=0 to nrows-1 do begin
         ps1^ := b2 * ps2^ + rc.b * ps3^;
         dec(ps1,rlB);
         dec(ps2,rlx);
         dec(ps3,rlB);
      end;
   end;
	for row:=0 to nrows-1 do
   	y.GetPSingle(row,ncols-1)^ := A.GetPSingle(row,ncols-1)^;
	for row:=0 to nrows-1 do begin
   	ps1:=y.Scanline[row];
      ps2:=A.Scanline[row];
      ps3:=B.Scanline[row]; inc(ps3);
   	for col:=0 to ncols-2 do begin
         ps1^ := ps2^ + ps3^;
         inc(ps1);
         inc(ps2);
         inc(ps3);
      end;
   end;
end;

//	Recursive filter realization of the ISEF (Shen and Castan CVIGP March 1992)
procedure sh_compute_ISEF(var x:TIEWorkBitmap; y:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc);
var
	A,B:TIEWorkBitmap;
begin
	A:=TIEWorkBitmap.Create(ncols,nrows,32);
	B:=TIEWorkBitmap.Create(ncols,nrows,32);
	sh_apply_ISEF_vertical(x, y, A, B, nrows, ncols,rc);
	sh_apply_ISEF_horizontal(y, y, A, B, nrows, ncols, rc);
   FreeAndNil(B);
   FreeAndNil(A);
end;

// compute the band-limited laplacian of the input image
function sh_compute_bli(var buff1:TIEWorkBitmap; var buff2:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc):TIEWorkBitmap;
var
	row, col:integer;
	bli_buffer:TIEWorkBitmap;
   ps1:pbyte;
   ps2,ps3:psingle;
begin
	bli_buffer := TIEWorkBitmap.Create(ncols,nrows,8);
   l3zeromemory(bli_buffer.Bits,bli_buffer.Rowlen*bli_buffer.Height);
	for row:=0 to nrows-1 do begin
      ps1:=bli_buffer.Scanline[row];
      ps2:=buff1.Scanline[row];
      ps3:=buff2.Scanline[row];
   	for col:=0 to ncols-1 do begin
      	if (row<sh_OUTLINE) or (row >= nrows-sh_OUTLINE) or (col<sh_OUTLINE) or (col >= ncols-sh_OUTLINE) then begin
            inc(ps1);
            inc(ps2);
            inc(ps3);
         	continue;
         end;
         ps1^ := byte((ps2^ - ps3^) >0);
         inc(ps1);
         inc(ps2);
         inc(ps3);
	  	end;
   end;
	result:=bli_buffer;
end;

function sh_compute_adaptive_gradient(var BLI_buffer:TIEWorkBitmap; var orig_buffer:TIEWorkBitmap; row, col:integer; var rc:tsh_rc):double;
var
	i, j:integer;
	sum_on, sum_off:double;
	avg_on, avg_off:double;
	num_on, num_off:integer;
   wd2:integer;
   ps1:pbyte;
   ps2:psingle;
begin
	sum_on := 0;
   sum_off := 0;
	num_on := 0;
   num_off := 0;
   wd2:=rc.window_size div 2;
	for i:=-wd2 to wd2 do begin
      ps1:=BLI_buffer.Scanline[row+i]; inc(ps1,col-wd2);
      ps2:=orig_buffer.Scanline[row+i]; inc(ps2,col-wd2);
	   for j:=-wd2 to wd2 do begin
      	if ps1^<>0 then begin
         	sum_on := sum_on + ps2^;
         	inc(num_on);
			end else begin
         	sum_off := sum_off + ps2^;
         	inc(num_off);
      	end;
         inc(ps1);
         inc(ps2);
   	end;
	end;
	if (sum_off<>0) then
   	avg_off := sum_off / num_off
	else
   	avg_off := 0;
	if (sum_on<>0) then
   	avg_on := sum_on / num_on
	else
   	avg_on := 0;
	result:= (avg_off - avg_on);
end;

// finds zero-crossings in laplacian (buff)  orig is the smoothed image
function sh_is_candidate_edge(var buff:TIEWorkBitmap; var orig:TIEWorkBitmap; row, col:integer; var rc:tsh_rc):boolean;
begin
	if (buff.GetPByte(row,col)^ = 1) and (buff.GetPByte(row+1,col)^ = 0) then begin
	   result:= (orig.GetPSingle(row+1,col)^ - orig.GetPSingle(row-1,col)^) > 0;
	end else if (buff.GetPByte(row,col)^ = 1) and (buff.GetPByte(row,col+1)^ = 0 ) then begin
	   result:= (orig.GetPSingle(row,col+1)^ - orig.GetPSingle(row,col-1)^) > 0;
	end else if ( buff.GetPByte(row,col)^ = 1) and (buff.GetPByte(row-1,col)^ = 0) then begin
	   result:= (orig.GetPSingle(row+1,col)^ - orig.GetPSingle(row-1,col)^) < 0;
	end else if (buff.GetPByte(row,col)^ = 1) and (buff.GetPByte(row,col-1)^ = 0 ) then begin
   	result:= (orig.GetPSingle(row,col+1)^ - orig.GetPSingle(row,col-1)^) < 0;
	end else
   	result:=false;
end;

procedure sh_locate_zero_crossings(var orig:TIEWorkBitmap; var smoothed:TIEWorkBitmap; var bli:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc);
var
	row, col:integer;
   ps1:psingle;
begin
	for row:=0 to nrows-1 do begin
      ps1:=orig.Scanline[row];
      l3zeromemory(ps1,orig.rowlen);
      inc(ps1,sh_OUTLINE);
      if (row>=sh_OUTLINE) and (row<nrows-sh_OUTLINE) then
         for col:=sh_OUTLINE to ncols-1-sh_OUTLINE do begin
            if (sh_is_candidate_edge(bli, smoothed, row, col,rc)) then
               ps1^ := sh_compute_adaptive_gradient(bli, smoothed, row, col,rc);
            inc(ps1);
         end;
	end;
end;

procedure sh_estimate_thresh(low:pdouble; hi:pdouble; nr, nc:integer; var rc:tsh_rc);
var
	vmax, vmin, scale, x:double;
	i,j,k,count:integer;
   hist:array [0..255] of integer;
   ps1:psingle;
begin
   vmax := abs(rc.lap.GetPSingle(20,20)^);
	vmin := vmax;
	for i:=0 to nr-1 do begin
      ps1:=rc.lap.Scanline[i];
   	for j:=0 to nc-1 do begin
      	if (i<sh_OUTLINE) or (i >= nr-sh_OUTLINE) or (j<sh_OUTLINE) or (j >= nc-sh_OUTLINE) then begin
            inc(ps1);
         	continue;
         end;
         x := ps1^;
	      if (vmin > x) then vmin := x;
	      if (vmax < x) then vmax := x;
         inc(ps1);
	  	end;
   end;
	for k:=0 to 255 do
   	hist[k] := 0;
	scale := 256/(vmax-vmin + 1);
	for i:=0 to nr-1 do begin
      ps1:=rc.lap.Scanline[i];
   	for j:=0 to nc-1 do begin
      	if (i<sh_OUTLINE) or (i >= nr-sh_OUTLINE) or (j<sh_OUTLINE) or (j >= nc-sh_OUTLINE) then begin
            inc(ps1);
         	continue;
         end;
         x := ps1^;
	    	k := trunc(((x - vmin)*scale));
	    	hist[k] := hist[k]+1;
         inc(ps1);
	  	end;
   end;
	k := 255;
	j := trunc(rc.ratio*nr*nc);
	count := hist[255];
	while (count < j) do	begin
   	dec(k);
	  	if (k<0) then
      	break;
	  	inc(count, hist[k]);
	end;
	hi^ := k/scale   + vmin ;
	low^ := (hi^)/2;
end;

//	return true if it marked something
function sh_mark_connected(i, j, level:integer; var rc:tsh_rc):boolean;
var
	notChainEnd:boolean;
begin
	if (i >= rc.nr) or (i < 0) or (j >= rc.nc) or (j < 0) then begin
   	result:=false;
      exit;
   end;
	if (rc.edges.GetPByte(i,j)^ <> 0) then begin
      result:=false;
      exit;
   end;
	if (rc.lap.GetPSingle(i,j)^ = 0) then begin
      result:=false;
      exit;
   end;
	if rc.lap.GetPSingle(i,j)^ > rc.low_thresh then	begin
	   rc.edges.GetPByte(i,j)^ := 1;
	end else	begin
	   rc.edges.GetPByte(i,j)^ := 255;
	end;
	notChainEnd := false;
	notChainEnd := notChainEnd or sh_mark_connected(i  ,j+1, level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i  ,j-1, level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i+1,j+1, level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i+1,j  , level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i+1,j-1, level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i-1,j-1, level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i-1,j  , level+1,rc);
	notChainEnd := notChainEnd or sh_mark_connected(i-1,j+1, level+1,rc);
	if (notChainEnd and ( level > 0 ) ) then begin
   	if ( rc.thinFactor > 0 ) then
	  		if ( (level mod rc.thinFactor) <> 0  ) then begin
	    		rc.edges.GetPByte(i,j)^ := 255;
	  		end;
	end;
   result:=true;
end;

procedure sh_threshold_edges(var xin:TIEWorkbitmap; var xout:TIEWorkBitmap; nrows, ncols:integer; var rc:tsh_rc);
var
	i, j:integer;
   pb1:pbyte;
   ps1:psingle;
begin
	rc.lap := xin;
	rc.edges := xout;
	rc.nr := nrows;
	rc.nc := ncols;
	sh_estimate_thresh(@rc.low_thresh, @rc.high_thresh, rc.nr, rc.nc,rc);
	if (not rc.do_hysteresis) then
   	rc.low_thresh := rc.high_thresh;
	for i:=0 to nrows-1 do begin
      pb1:=rc.edges.Scanline[i];
   	for j:=0 to ncols-1 do begin
      	//rc.edges.GetPByte(i,j)^ := 0;
         pb1^:=0;
         inc(pb1);
      end;
   end;
	for i:=0 to nrows-1 do begin
      ps1:=rc.lap.Scanline[i];
   	for j:=0 to ncols-1 do begin
      	if (i<sh_OUTLINE) or (i >= nrows-sh_OUTLINE) or (j<sh_OUTLINE) or (j >= ncols-sh_OUTLINE) then begin
            inc(ps1);
         	continue;
         end;
	    	//if ((rc.lap.GetPSingle(i,j)^) > rc.high_thresh) then
         if ((ps1^) > rc.high_thresh) then
         	sh_mark_connected(i,j,0,rc);
         inc(ps1);
	  	end;
   end;
	for i:=0 to nrows-1 do begin
      pb1:=rc.edges.Scanline[i];
   	for j:=0 to ncols-1 do begin
      	if (pb1^ = 255) then
         	pb1^ := 0;
         inc(pb1);
      end;
   end;
end;

procedure sh_shen(var im:TIEWorkBitmap; var res:TIEWorkBitmap; var rc:tsh_rc);
var
	i,j:integer;
	buffer:TIEWorkBitmap;
	smoothed_buffer:TIEWorkBitmap;
	bli_buffer:TIEWorkBitmap;
   ps1:psingle;
   pb1:pbyte;
begin
	rc.Progress.per1:=100/6;
   buffer:=TIEWorkBitmap.Create(im.Width,im.Height,32);	// bitmap of float points
	for i:=0 to im.height-1 do begin
      ps1:=buffer.scanline[i];
      pb1:=im.scanline[i];
      for j:=0 to im.width-1 do begin
         ps1^ := pb1^;
         inc(ps1);
         inc(pb1);
      end;
   end;
   with rc.Progress do
	   if assigned(fOnProgress) then
   	   fOnProgress(Sender,trunc(per1*(1)));
   // 1
	smoothed_buffer := TIEWorkBitmap.Create(im.Width,im.Height,32);
	sh_compute_ISEF(buffer, smoothed_buffer, im.Height, im.Width,rc);
   with rc.Progress do
	   if assigned(fOnProgress) then
	      fOnProgress(Sender,trunc(per1*(2)));
   // 2
	bli_buffer := sh_compute_bli(smoothed_buffer,buffer,im.Height,im.Width,rc);
   with rc.Progress do
	   if assigned(fOnProgress) then
	      fOnProgress(Sender,trunc(per1*(3)));
   // 3
	sh_locate_zero_crossings(buffer, smoothed_buffer, bli_buffer,im.Height, im.Width, rc);
   with rc.Progress do
	   if assigned(fOnProgress) then
   	   fOnProgress(Sender,trunc(per1*(4)));
   // 4
   FreeAndNil(smoothed_buffer);
	FreeAndNil(bli_buffer);
	sh_threshold_edges(buffer, res, im.Height, im.Width,rc);
   with rc.Progress do
	   if assigned(fOnProgress) then
   	   fOnProgress(Sender,trunc(per1*(5)));
   // 5
	for i:=0 to im.Height-1 do begin
      pb1:=res.scanline[i];
   	for j:=0 to im.Width-1 do begin
      	if (pb1^ > 0) then
         	pb1^ := 0
	     	else
         	pb1^ := 255;
         inc(pb1);
      end;
   end;
	FreeAndNil(buffer);
   with rc.Progress do
	   if assigned(fOnProgress) then
   	   fOnProgress(Sender,trunc(per1*(6)));
	// 6
end;

procedure sh_debed2(var im:TIEWorkBitmap; Bitmap:TIEBitmap; width:integer; var rc:tsh_rc);
var
	i,j:integer;
   hh,ww:integer;
   pb:pbyte;
begin
	inc(width,2);
   ww:=im.Width-width-width;
   hh:=im.Height-width-width;
   Bitmap.Allocate(ww,hh,ie1g);
	for i:=0 to hh-2 do begin
      pb:=Bitmap.Scanline[i];
   	for j:=1 to ww-1 do
			_SetPixelbw(pb,j, im.GetPByte(i+width,j+width)^ );
      _SetPixelbw(pb,0, 255);
	end;
   pb:=Bitmap.Scanline[hh-1];
   for j:=0 to ww-1 do
		_SetPixelbw(pb,j, 255);
end;

// SrcBitmap and DstBitmap can refer to some bitmap object
procedure _IEEdgeDetect_ShenCastan(SrcBitmap,DstBitmap:TIEBitmap; Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean; var Progress:TProgressRec);
var
	rc:tsh_rc;
	im, res:TIEWorkBitmap;
begin
   l3fillchar(rc,sizeof(tsh_rc),0);
   with rc do begin
      imwidth:=SrcBitmap.Width;
      imheight:=SrcBitmap.Height;
      b:=Smooth;
      low_thresh:=20;
      high_thresh:=22;
      window_size:=WindowSize;
      do_hysteresis:=DoHysteresis;
   end;
   rc.Progress:=Progress;
   rc.Ratio:=Ratio;
   rc.thinFactor:=ThinFactor;
   im:=sh_CreateGrayPixMap(SrcBitmap);
	sh_embed(im, sh_OUTLINE, rc);
   res:=TIEWorkBitmap.Create(im.Width, im.Height,8);
	sh_shen(im, res,rc);
   sh_debed2(res, DstBitmap, sh_OUTLINE,rc);
   FreeAndNil(res);
   FreeAndNil(im);
end;

procedure TImageEnProc.EdgeDetect_ShenCastan(Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean);
var
   Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('EdgeDetect',ieuImage);
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	_IEEdgeDetect_ShenCastan(fIEBitmap,fIEBitmap,Ratio,Smooth,WindowSize,ThinFactor,DoHysteresis,Progress);
   Update;
end;


// end of Shen-Castan edge detector
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Skew Detection


//(*
function _iehough(image:TIEBitmap; var Progress:TProgressRec; anglerange:integer; Precision:Double):double;
const
	conv:double= 3.1415926535/180;
   ar:array [-1..1] of integer=(-1,1,-1);
var
	z:TIEWorkBitmap;
	r1,r2,r, rr,center_x, center_y, i, s, j, jj,jj8,rl,rmax, rmax2,tmax:integer;
	oc:double;
	tmval:integer;
   nc,nr,om,omi,omr:integer;
   row:pbyte;
   pf:pinteger;
   precmul   : Integer;
   s1,s2,totaldegrees : Integer;
   px,ps:pinteger;
   ksin,kcos : pintegerarray;
   dsin,dcos:pdoublearray;
begin
	result:=0;
	if image.pixelformat<>ie1g then
      exit;
   Precision:=trunc(Precision*10)/10;	// allow only first decimal digit
   if (Precision < 0.1) or (Precision > 1) then
      exit;
   if (AngleRange<0) or (AngleRange>180) then
      exit;
   precmul := round(1 / Precision);
   Precision:= (1/PrecMul)*conv; // now is in radians
   totaldegrees:= 180*precmul;
   nc:=image.Width;
   nr:=image.Height;
	center_x := nc div 2;
   center_y := nr div 2;
	rmax := trunc( sqrt(nc*nc+nr*nr)/2 );
   z := TIEWorkBitmap.Create(2*rmax+1,totaldegrees,32);
   l3ZeroMemory(z.Bits,z.Height*z.RowLen);
   omr:=(anglerange*precmul) div 2;
   omi:=(totaldegrees div 2);
	Progress.per1:=100/(nr);
   getmem(ksin,sizeof(integer)*1800);
   getmem(kcos,sizeof(integer)*1800);
   getmem(dsin,sizeof(double)*1800);
   getmem(dcos,sizeof(double)*1800);
   oc:=0;
   for om:=0 to 1799 do begin
      ksin[om]:=trunc(sin(oc)*131072);
      kcos[om]:=trunc(cos(oc)*131072);
      dsin[om]:=sin(oc);
      dcos[om]:=cos(oc);
      oc:=oc+Precision;
   end;
   rl:=IEBitmapRowLen(image.width,1,32);
	for i := 0 to nr-1 do begin
	   row:=image.Scanline[i];
      jj:=0;
      while jj<rl do begin
         if (row^<255) then begin
         	jj8:=jj*8;
         	for j:=0 to 7 do
               if row^ and iebitmask1[j] = 0 then begin	// found a "black"
                  om := omi-omr;
                  while om< omi+omr-1 do begin
                     r1:=(i-center_y)*ksin[om];
                     if r1<0 then begin
                     	r1:=-r1;
                        s1:=r1 and $1FFFF;
                        r1:=-(r1 shr 17);
                        if s1>65535 then dec(r1);
                     end else begin
                     	s1:=r1 and $1FFFF;
                        r1:=r1 shr 17;
                        if s1>65535 then inc(r1);
                     end;
                     r2:=(jj8+j-center_x)*kcos[om];
                     if r2<0 then begin
                     	r2:=-r2;
                     	s2:=r2 and $1FFFF;
                        r2:=-(r2 shr 17);
                        if s2>65535 then dec(r2);
                     end else begin
                     	s2:=r2 and $1FFFF;
                        r2:=r2 shr 17;
                        if s2>65535 then inc(r2);
                     end;

                     with z do
                        px:=pinteger(dword(Bits)+dword((Height-om-1)*Rowlen+(rmax+r1+r2)*4));
                     inc( px^ );
                     inc( om );
                  end;
               end;
         end;
         inc(jj);
         inc(row);
      end;
      with Progress do
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per1*(i)));
   end;
	tmax := 0;
   tmval := 0;
   rmax2:=2*rmax;
   for i:= (omi-omr) to omi+omr-1 do begin
   	pf:=z.Scanline[i];
   	for j:=0 to rmax2 do begin
      	if pf^ > tmval then begin
				tmval := pf^;
				tmax := i;
    		end;
         inc(pf);
      end;
   end;
  	result := tmax/PrecMul-90;
   FreeAndNil(z);
   freemem(ksin);
   freemem(kcos);
   freemem(dsin);
   freemem(dcos);
end;
//*)

(*
function _iehough(image:TBitmap; var Progress:TProgressRec; anglerange:integer; Precision:Double):double;
const
	conv:double= 3.1415926535/180;
var
	z:TIEWorkBitmap;
	r, center_x, center_y, i, j, rmax, tmax:integer;
	oc:double;
	tmval:integer;
   nc,nr,om,omi,omr:integer;
   r1,r2:double;
   row:pbyte;
   pf:pinteger;
   precmul   : Integer;
   totaldegrees : Integer;
   ksin,kcos : pdoublearray;
begin
	result:=0;
	if image.pixelformat<>pf1bit then
      exit;
   Precision:=trunc(Precision*10)/10;	// allow only first decimal digit
   if (Precision < 0.1) or (Precision > 1) then
      exit;
   if (AngleRange<0) or (AngleRange>180) then
      exit;
   precmul := round(1 / Precision);
   Precision:= (1/PrecMul)*conv; // now is in radians
   totaldegrees:= 180*precmul;
   nc:=image.Width;
   nr:=image.Height;
	center_x := nc div 2;
   center_y := nr div 2;
	rmax := trunc( sqrt(nc*nc+nr*nr)/2 );
   z := TIEWorkBitmap.Create(2*rmax+1,totaldegrees,32);
   omr:=(anglerange*precmul) div 2;
   omi:=(totaldegrees div 2);
	for r:=0 to 2 * rmax do
   	for om := (omi-omr) to omi+omr-1 do
			z.GetPSingle(om,r)^ := 0;
	Progress.per1:=100/(nr);
   getmem(ksin,sizeof(double)*1800);
   getmem(kcos,sizeof(double)*1800);
   oc:=0;
   for om:=0 to 1799 do begin
      ksin[om]:=sin(oc);
      kcos[om]:=cos(oc);
      oc:=oc+Precision;
   end;
	for i := 0 to nr-1 do begin
	   row:=image.Scanline[i];
   	for j := 0 to nc-1 do begin
			if pbytearray(row)^[j shr 3] and iebitmask1[j and $7] = 0 then begin	// found a "black"
            om := omi-omr;
            while om< omi+omr-1 do begin
               r1:=round((i-center_y)*ksin[om]);
               r2:=round((j-center_x)*kcos[om]);
               inc( z.GetPInteger(om,rmax+trunc(r1+r2))^ );
               inc( om );
  	 			end;
         end;
      end;
      with Progress do
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per1*(i)));
   end;
	tmax := 0;
   tmval := 0;
   for i:= (omi-omr) to omi+omr-1 do
   	for j:=0 to 2*rmax do begin
      	pf:=z.GetPInteger(i,j);
      	if pf^ > tmval then begin
				tmval := pf^;
				tmax := i;
    		end;
      end;
  	result := tmax/PrecMul-90;
   FreeAndNil(z);
   freemem(ksin);
   freemem(kcos);
end;
//*)


(*
// only for 1bit images
//function _iehough(image:TBitmap; var Progress:TProgressRec):double;
function _iehough(image:TBitmap; var Progress:TProgressRec; anglerange:integer; Precision:Double):double;
var
	z:TIEWorkBitmap;
	center_x, center_y, r, i, j, rmax, tmax:integer;
	conv,omega,oc:double;
	tmval:integer;
   nc,nr,om:integer;
   row:pbyte;
   pf:pinteger;
   ksin,kcos:array [0..1799] of double;
   glo,ghi:integer;
begin
	glo:=700;
   ghi:=700;
	result:=0;
	if image.pixelformat<>pf1bit then
   	exit;
	conv := 3.1415926535/180;
   nc:=image.Width;
   nr:=image.Height;
	center_x := nc div 2;
   center_y := nr div 2;
	rmax := trunc( sqrt(nc*nc+nr*nr)/2 );
   z:=TIEWorkBitmap.Create(2*rmax+1,1800,32);
	for r:=0 to 2 * rmax do
	   for om := 0+glo to 1799-ghi do
			z.GetPSingle(om,r)^ := 0;
	Progress.per1:=100/(nr);
   omega:=0;
   om:=0;
   while om<1800 do begin
   	oc:=omega*conv;
		ksin[om]:=sin(oc);
      kcos[om]:=cos(oc);
      omega:=omega+0.1;
      inc(om);
   end;
	for i := 0 to nr-1 do begin
   	row:=image.Scanline[i];
   	for j := 0 to nc-1 do begin
			if pbytearray(row)^[j shr 3] and iebitmask1[j and $7] = 0 then begin
            om:=0+glo;
            while om<1800-ghi do begin
               r := trunc( (i-center_y)*ksin[om] + (j-center_x)*kcos[om] );
               inc( z.GetPInteger(om,rmax+r)^ );
               inc(om);
		   	end;
         end;
      end;
      with Progress do
         if assigned(fOnProgress) then
            fOnProgress(Sender,trunc(per1*(i)));
   end;
	tmax := 0;
   tmval := 0;
	for i:=0+glo to 1799-ghi do begin
         for j:=0 to 2*rmax do begin
            pf:=z.GetPInteger(i,j);
            if pf^ > tmval then begin
               tmval := pf^;
               tmax := i;
            end;
         end;
   end;
	result := tmax/10-90;
   FreeAndNil(z);
end;
//*)

(*
ANOTHER ALGORITHM (ALWAYS BASED ON HOUGH), FASTEST BUT WITH LOW PRECISION

// oldimage must be 8 bit per pixel
function ie_hough_transform(oldimage:TIEWorkBitmap; slopeval,cval:integer; pixelval:byte):TIEWorkBitmap;
var
   transformed:TIEWorkBitmap;
   i,j:integer;
   ycoord,xcoord,maxnum,holdnum:integer;
   ycoord1,xcoord1:integer;
   yint:integer;
   halfheight,halfwidth:integer;
   fullwidth:integer;
   fullheight:integer;
   halfimageheight,halfimagewidth:integer;
   slope:double;
begin
   fullwidth := oldimage.height div cval;
   fullheight := slopeval*2;
   halfheight := slopeval;
   halfwidth := fullwidth div 2;
   halfimagewidth := oldimage.width div 2;
   halfimageheight := oldimage.height div 2;
   transformed := TIEWorkBitmap.Create(fullwidth,fullheight,8);
   for i:=0 to fullwidth-1 do begin
      for j:=0 to fullheight-1 do begin
         yint:=cval*(-i + halfwidth);
         xcoord:=0;
         xcoord1:=0;
         slope:=(j-halfheight)/slopeval;
         maxnum:=0;
         holdnum:=0;
         while ((xcoord <= halfimagewidth)) do begin
	         ycoord:=trunc(slope*(xcoord) + yint);
         	ycoord1:=trunc(slope*(xcoord1) + yint);
         	if ((ycoord < halfimageheight) and (ycoord > -halfimageheight)) then begin
               if (oldimage.GetPByte(ycoord+halfimageheight,xcoord + halfimagewidth)^ = pixelval) then
                  inc(holdnum);
               inc(maxnum);
            end;
         	if ((ycoord1 < halfimageheight) and (ycoord1 > -halfimageheight)) then	begin
               if (oldimage.GetPByte(ycoord1+halfimageheight,xcoord1+halfimagewidth)^ = pixelval) then
                  inc(holdnum);
               inc(maxnum);
            end;
	         inc(xcoord);
	         dec(xcoord1);
         end;
         inc(maxnum);
         transformed.GetPByte(j,i)^ := trunc(((holdnum / maxnum) * 255.0));
      end;
   end;
   result:=transformed;
end;

procedure ie_binarize(image:TIEWorkBitmap; splitval:integer);
var
   i,j:integer;
   p:pbyte;
begin
  for i:=0 to image.height-1 do begin
    for j:=0 to image.width-1 do begin
      p:=image.GetPByte(i,j);
      if p^ < splitval then
	      p^ := 0
      else
         p^ := 255;
    end;
  end;
end;

// supports only pf1bit
// return always 8 bits per pixel
function ie_CreateWorkBitmap8_pf1bit(bitmap:TBitmap):TIEWorkBitmap;
var
   width,height:integer;
   i,j:integer;
   row,px:pbyte;
begin
   width:=bitmap.width;
   height:=bitmap.height;
   result:=TIEWorkBitmap.Create(width,height,8);
   for i:=0 to height-1 do begin
      row:=bitmap.Scanline[i];
      for j:=0 to width-1 do begin
         px:=result.GetPByte(i,j);
         if _GetPixelbw(row,j)<>0 then
            px^:=255
         else
            px^:=0;
      end;
   end;
end;

function ie_calchoughskew(houghimg:TIEWorkBitmap):double;
var
   slope_hold:double;
   return_rad:double;
   height,width:integer;
   holdval,realval:integer;
   i,zeroval:integer;
   otherval:integer;
   pb:pbyte;
begin
   holdval := 0;
   height := houghimg.height;
   width := houghimg.width;
   zeroval := height div 2;
   realval:=0;
   for i:=0 to width-1 do begin
      pb:=houghimg.GetPByte(zeroval,i);
      if (pb^ > holdval) then begin
         holdval := pb^;
         realval := i;
      end;
   end;
   otherval := realval - (width div 2);
   slope_hold := otherval/(width/2);
   return_rad := arctan(slope_hold); //return_rad := atan(slope_hold);
   return_rad := (return_rad)*((180.0 / 3.142));
   result:=-return_rad;
end;

function ie_hough2(image:TBitmap; var Progress:TProgressRec):double;
var
   tmpimg1,tmpimg2:TIEWorkBitmap;
begin
   result:=0;
	if image.pixelformat<>pf1bit then
   	exit;
   tmpimg1:=ie_CreateWorkBitmap8_pf1bit(image);
   tmpimg2:=ie_hough_transform(tmpimg1,64,4,255);
   FreeAndNil(tmpimg1);
   ie_binarize(tmpimg2,245);
   tmpimg1:=ie_hough_transform(tmpimg2,1,1,255);
   FreeAndNil(tmpimg2);
   result:=ie_calchoughskew(tmpimg1);
end;
*)

// If ResampleWidth is Zero (0) doesn't resample original image (more slow)
function TImageEnProc.SkewDetection(ResampleWidth:integer; AngleRange:integer; Precision:double; EdgeDetect:boolean):double;
var
	tmpbmp:TIEBitmap;
   nullpr:TProgressRec;
   Progress:TProgressRec;
begin
	result:=0;
   if not MakeConsistentBitmap([]) then
      exit;
   with nullpr do begin
      fOnProgress:=nil;
      Sender:=nil;
	end;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	if (ResampleWidth>0) and (ResampleWidth<>fIEBitmap.Width) then begin
	   tmpbmp:=TIEBitmap.Create;
      tmpbmp.Allocate(ResampleWidth, (fIEbitmap.Height*ResampleWidth) div fIEbitmap.Width , fIEBitmap.pixelformat);
      if tmpbmp.Pixelformat=ie1g then begin
      	if EdgeDetect then begin
            tmpbmp.Allocate(tmpbmp.Width,tmpbmp.Height,ie24RGB);
	      	_Resample1BitEx(fIEBitmap,tmpbmp,rfFastLinear);
         end else
         	_IEBmpStretchEx(fIEBitmap,tmpbmp,nil,nil);
      end else
      	_ResampleEx(fIEBitmap,tmpbmp,rfFastLinear,nil,nil);
      if EdgeDetect then
	      _IEEdgeDetect_ShenCastan(tmpbmp,tmpbmp,0.99,0.9,7,0,true,nullpr);
   end else begin
   	if fIEBitmap.PixelFormat=ie1g then begin
      	if EdgeDetect then begin
         	tmpbmp:=TIEBitmap.Create;
	      	_Conv1To24Ex(fIEBitmap,tmpbmp,nullpr);
	         _IEEdgeDetect_ShenCastan(tmpbmp,tmpbmp,0.99,0.9,7,0,true,nullpr);
         end else
         	tmpbmp:=fIEBitmap;
      end else begin
      	tmpbmp:=TIEBitmap.Create;
      	_IEEdgeDetect_ShenCastan(fIEBitmap,tmpbmp,0.99,0.9,7,0,true,nullpr);
      end;
	end;
   result:=_iehough(tmpbmp,Progress,AngleRange,Precision);
   if tmpbmp<>fIEBitmap then
	   FreeAndNil(tmpbmp);
end;


// Skew Detection
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


procedure TImageEnProc.Fill(FillColor:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'Fill',ProcBitmap,mask) then
   	exit;
   _Fill(ProcBitmap,x1,y1,x2,y2, FillColor, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


// on pf1bit images FillColor can be only (0,0,0) for black and (255,255,255) for white
procedure _Fill(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; FillColor:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   col,row:integer;
   ppx:pRGB;
   per1:double;
   bx:pbyte;
   tb:byte;
   bb:integer;
   bw:boolean;
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	if Bitmap.Pixelformat=ie24RGB then begin
   	// ie24RGB
	  	for row:=fSelY1 to fSelY2 do begin
	   	ppx:=bitmap.ScanLine[row];
	      inc(ppx,fSelX1);
	      for col:=fSelX1 to fSelX2 do begin
				ppx^.r:=FillColor.r;
	         ppx^.g:=FillColor.g;
	         ppx^.b:=FillColor.b;
	         inc(ppx);
	      end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
	   end;
   end else if Bitmap.Pixelformat=ie1g then begin
		// ie1g
      bw:=(FillColor.r<>0);
      for row:=fSelY1 to fSelY2 do begin
      	bx:=Bitmap.Scanline[row];
		   inc(bx,fSelX1 SHR 3);
			bb:=7-(fSelX1 and 7);
         tb:=bx^;
         for col:=fSelX1 to fSelX2 do begin
				if bw then
					tb:=tb or (1 shl bb)
		      else
		         tb:=tb and not (1 shl bb);
		      dec(bb);
		      if bb=-1 then begin
            	bx^:=tb;
		         inc(bx);
               tb:=bx^;
		         bb:=7;
		      end;
		   end;
		   if bb<7 then
		      bx^:=tb;
      end;
   end;
end;

// Src and Dst must be 24bit
(*
procedure _ResampleLinear(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	zx,zy,rold,d:double;
   iold,iold2,x,y,idiff,xx,yy:integer;
   a,mm_r,mm_g,mm_b,mc:integer;
   OldWidth,OldHeight,NewWidth,NewHeight:integer;
   OldImRow,NewImRow,OldImRow2:PRGBROW;
   OldScanline:ppointerarray;
   bmp1:TIEWorkBitmap;
   darr1:pintegerarray;
   iarr1,iarr2:pintegerarray;
   per1:double;
begin
	OldWidth:=Src.Width;
   OldHeight:=Src.Height;
   NewWidth:=Dst.Width;
   NewHeight:=Dst.Height;
	zx:=NewWidth/OldWidth;
   zy:=NewHeight/OldHeight;
   if (zx=1) and (zy=1) then begin
   	IECopyBitmap(Src,Dst);
      exit;
   end;
   getmem(darr1,sizeof(integer)*NewWidth);
   getmem(iarr1,sizeof(integer)*NewWidth);
   getmem(iarr2,sizeof(integer)*NewWidth);
   for x:=0 to NewWidth-1 do begin
   	d:=x/zx;
      iarr1[x]:=trunc(d);
    	darr1[x]:=trunc((d-iarr1[x])*131072);	// 2^17
      iarr2[x]:=trunc(imin(x+1,NewWidth-1)/zx+0.0000000001);	// the 0.0000000001 avoid a Delphi math bug
   end;
   bmp1:=TIEWorkBitmap.Create(NewWidth,OldHeight,24);
   ////// horizontal
   per1:=100/(OldHeight+NewHeight+0.5);
   if zx>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
         for x:=0 to NewWidth-1 do begin
            iold:=iarr1[x];
            idiff:=darr1[x];
            iold2:=imin(iold+1,OldWidth-1);
            // r
            a:=OldImRow[iold].r;
            NewImRow[x].r:=a+(((OldImRow[iold2].r-a)*idiff) shr 17);
            // g
            a:=OldImRow[iold].g;
            NewImRow[x].g:=a+(((OldImRow[iold2].g-a)*idiff) shr 17);
            // b
            a:=OldImRow[iold].b;
            NewImRow[x].b:=a+(((OldImRow[iold2].b-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end else begin
   	// zoom-out (median)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
			for x:=0 to NewWidth-1 do begin
         	iold:=iarr1[x];
            iold2:=iarr2[x];
            mm_r:=0; mm_g:=0; mm_b:=0; mc:=0;
				for xx:=iold to iold2 do begin
            	with OldImRow[xx] do begin
	            	inc(mm_r,r);
                  inc(mm_g,g);
                  inc(mm_b,b);
               end;
               inc(mc);
            end;
            with NewImRow[x] do begin
	            r:=mm_r div mc;
   	         g:=mm_g div mc;
               b:=mm_b div mc;
            end;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end;
   // vertical
   if zy>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to NewHeight-1 do begin
         rold:=y/zy;
         iold:=trunc(rold);
         idiff:=trunc((rold-iold)*131072);	// 2^17
         OldImRow:=bmp1.Scanline[iold];
         NewImRow:=Dst.Scanline[y];
         if iold+1 < OldHeight then OldImRow2:=bmp1.Scanline[iold+1] else OldImRow2:=OldImRow;
         for x:=0 to NewWidth-1 do begin
            // r
            a:=OldImRow[x].r;
            NewImRow[x].r:=a+(((OldImRow2[x].r-a)*idiff) shr 17);
            // b
            a:=OldImRow[x].b;
            NewImRow[x].b:=a+(((OldImRow2[x].b-a)*idiff) shr 17);
            // g
            a:=OldImRow[x].g;
            NewImRow[x].g:=a+(((OldImRow2[x].g-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
   end else begin
   	// zoom-out (median)
      getmem(OldScanline,sizeof(pointer)*OldHeight);
      for y:=0 to OldHeight-1 do
      	OldScanline[y]:=bmp1.Scanline[y];
      for y:=0 to NewHeight-1 do begin
      	iold:=trunc( y / zy );
         iold2:=trunc( imin(y+1,NewHeight-1) / zy );
         NewImRow:=Dst.Scanline[y];
         for x:=0 to NewWidth-1 do begin
         	mm_r:=0; mm_g:=0; mm_b:=0; mc:=0;
				for yy:=iold to iold2 do begin
               OldImRow:=OldScanline[yy];
            	with OldImRow[x] do begin
	            	inc(mm_r,r);
                  inc(mm_g,g);
                  inc(mm_b,b);
               end;
               inc(mc);
            end;
            with NewImRow[x] do begin
	            r:=mm_r div mc;
   	         g:=mm_g div mc;
               b:=mm_b div mc;
            end;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
      freemem(OldScanline);
   end;
   FreeAndNil(bmp1);
   freemem(darr1);
   freemem(iarr1);
   freemem(iarr2);
end;
*)

// Src and Dst must be ie24RGB
procedure _ResampleLinearEx(Src, Dst: TIEBaseBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	zx,zy,rold,d:double;
   iold,iold2,x,y,idiff,xx,yy:integer;
   a,mm_r,mm_g,mm_b,mc:integer;
   OldWidth,OldHeight,NewWidth,NewHeight:integer;
   OldImRow,NewImRow,OldImRow2:PRGBROW;
   OldScanline:ppointerarray;
   bmp1:TIEWorkBitmap;
   darr1:pintegerarray;
   iarr1,iarr2:pintegerarray;
   per1:double;
begin
	OldWidth:=Src.Width;
   OldHeight:=Src.Height;
   NewWidth:=Dst.Width;
   NewHeight:=Dst.Height;
	zx:=NewWidth/OldWidth;
   zy:=NewHeight/OldHeight;
   if (zx=1) and (zy=1) then begin
      Dst.Assign(Src);
      exit;
   end;
   getmem(darr1,sizeof(integer)*NewWidth);
   getmem(iarr1,sizeof(integer)*NewWidth);
   getmem(iarr2,sizeof(integer)*NewWidth);
   for x:=0 to NewWidth-1 do begin
   	d:=x/zx;
      iarr1[x]:=trunc(d);
    	darr1[x]:=trunc((d-iarr1[x])*131072);	// 2^17
      iarr2[x]:=trunc(imin(x+1,NewWidth-1)/zx+0.0000000001);	// the 0.0000000001 avoids a Delphi math bug
   end;
   bmp1:=TIEWorkBitmap.Create(NewWidth,OldHeight,24);
   ////// horizontal
   per1:=100/(OldHeight+NewHeight+0.5);
   if zx>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
         for x:=0 to NewWidth-1 do begin
            iold:=iarr1[x];
            idiff:=darr1[x];
            iold2:=imin(iold+1,OldWidth-1);
            // r
            a:=OldImRow[iold].r;
            NewImRow[x].r:=a+(((OldImRow[iold2].r-a)*idiff) shr 17);
            // g
            a:=OldImRow[iold].g;
            NewImRow[x].g:=a+(((OldImRow[iold2].g-a)*idiff) shr 17);
            // b
            a:=OldImRow[iold].b;
            NewImRow[x].b:=a+(((OldImRow[iold2].b-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end else begin
   	// zoom-out (median)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
			for x:=0 to NewWidth-1 do begin
         	iold:=iarr1[x];
            iold2:=iarr2[x];
            mm_r:=0; mm_g:=0; mm_b:=0; mc:=0;
				for xx:=iold to iold2 do begin
            	with OldImRow[xx] do begin
	            	inc(mm_r,r);
                  inc(mm_g,g);
                  inc(mm_b,b);
               end;
               inc(mc);
            end;
            with NewImRow[x] do begin
	            r:=mm_r div mc;
   	         g:=mm_g div mc;
               b:=mm_b div mc;
            end;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end;
   // vertical
   if zy>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to NewHeight-1 do begin
         rold:=y/zy;
         iold:=trunc(rold);
         idiff:=trunc((rold-iold)*131072);	// 2^17
         OldImRow:=bmp1.Scanline[iold];
         NewImRow:=Dst.Scanline[y];
         if iold+1 < OldHeight then
         	OldImRow2:=bmp1.Scanline[iold+1]
         else
         	OldImRow2:=OldImRow;
         for x:=0 to NewWidth-1 do begin
            // r
            a:=OldImRow[x].r;
            NewImRow[x].r:=a+(((OldImRow2[x].r-a)*idiff) shr 17);
            // b
            a:=OldImRow[x].b;
            NewImRow[x].b:=a+(((OldImRow2[x].b-a)*idiff) shr 17);
            // g
            a:=OldImRow[x].g;
            NewImRow[x].g:=a+(((OldImRow2[x].g-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
   end else begin
   	// zoom-out (median)
      getmem(OldScanline,sizeof(pointer)*OldHeight);
      for y:=0 to OldHeight-1 do
      	OldScanline[y]:=bmp1.Scanline[y];
      for y:=0 to NewHeight-1 do begin
      	iold:=trunc( y / zy );
         iold2:=trunc( imin(y+1,NewHeight-1) / zy );
         NewImRow:=Dst.Scanline[y];
         for x:=0 to NewWidth-1 do begin
         	mm_r:=0; mm_g:=0; mm_b:=0; mc:=0;
				for yy:=iold to iold2 do begin
               OldImRow:=OldScanline[yy];
            	with OldImRow[x] do begin
	            	inc(mm_r,r);
                  inc(mm_g,g);
                  inc(mm_b,b);
               end;
               inc(mc);
            end;
            with NewImRow[x] do begin
	            r:=mm_r div mc;
   	         g:=mm_g div mc;
               b:=mm_b div mc;
            end;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
      freemem(OldScanline);
   end;
   FreeAndNil(bmp1);
   freemem(darr1);
   freemem(iarr1);
   freemem(iarr2);
end;


// for zoom-out call _SubResample1bitFiltered
// Src must be 1bit
// Dst must be 24bit
(*
procedure _ResampleLinear1Bit(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	zx,zy,rold,d:double;
   iold,iold2,x,y,idiff,xx,yy:integer;
   OldWidth,OldHeight,NewWidth,NewHeight:integer;
   SrcImRow:pbyte;
   OldImRow,NewImRow,OldImRow2:PRGBROW;
   OldScanline:ppointerarray;
   bmp1:TIEWorkBitmap;
   darr1:pintegerarray;
   iarr1:pintegerarray;
   per1:double;
   v1,v2:integer;
begin
	OldWidth:=Src.Width;
   OldHeight:=Src.Height;
   NewWidth:=Dst.Width;
   NewHeight:=Dst.Height;
	zx:=NewWidth/OldWidth;
   zy:=NewHeight/OldHeight;
   if (zx=1) and (zy=1) then begin
   	IECopyBitmap(Src,Dst);
      exit;
   end;
   if (zx<1) and (zy<1) then begin
   	_SubResample1bitFiltered(Src,0,0,Src.Width-1,Src.Height-1,Dst);
      exit;
   end;
   getmem(darr1,sizeof(integer)*NewWidth);
   getmem(iarr1,sizeof(integer)*NewWidth);
   for x:=0 to NewWidth-1 do begin
   	d:=x/zx;
      iarr1[x]:=trunc(d);
    	darr1[x]:=trunc((d-iarr1[x])*131072);	// 2^17
   end;
   bmp1:=TIEWorkBitmap.Create(NewWidth,OldHeight,24);
   ////// horizontal
   per1:=100/(OldHeight+NewHeight+0.5);
   for y:=0 to OldHeight-1 do begin
      SrcImRow:=Src.Scanline[y];
      NewImRow:=bmp1.Scanline[y];
      for x:=0 to NewWidth-1 do begin
         iold:=iarr1[x];
         idiff:=darr1[x];
         iold2:=imin(iold+1,OldWidth-1);
			v1:=pbytearray(SrcImRow)^[iold2 shr 3] and iebitmask1[iold2 and $7];
         if v1<>0 then v1:=255 else v1:=0;
         v2:=pbytearray(SrcImRow)^[iold shr 3] and iebitmask1[iold and $7];
         if v2<>0 then v2:=255 else v2:=0;
         with NewImRow[x] do begin
         	r:=v2+(((v1-v2)*idiff) shr 17);
            b:=r;
            g:=r;
         end;
      end;
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*y));
   end;
   // vertical
   for y:=0 to NewHeight-1 do begin
      rold:=y/zy;
      iold:=trunc(rold);
      idiff:=trunc((rold-iold)*131072);	// 2^17
      OldImRow:=bmp1.Scanline[iold];
      NewImRow:=Dst.Scanline[y];
      if iold+1 < OldHeight then OldImRow2:=bmp1.Scanline[iold+1] else OldImRow2:=OldImRow;
      for x:=0 to NewWidth-1 do begin
         v1:=OldImRow[x].r;
         with NewImRow[x] do begin
         	r:=v1+(((OldImRow2[x].r-v1)*idiff) shr 17);
            g:=r;
            b:=r;
         end;
      end;
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*(y+OldHeight)));
   end;
   FreeAndNil(bmp1);
   freemem(darr1);
   freemem(iarr1);
end;
*)

// for zoom-out call _SubResample1bitFilteredEx
// Src must be 1bit
// Dst must be 24bit
procedure _ResampleLinear1BitEx(Src, Dst: TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	zx,zy,rold,d:double;
   iold,iold2,x,y,idiff,xx,yy:integer;
   OldWidth,OldHeight,NewWidth,NewHeight:integer;
   SrcImRow:pbyte;
   OldImRow,NewImRow,OldImRow2:PRGBROW;
   OldScanline:ppointerarray;
   bmp1:TIEWorkBitmap;
   darr1:pintegerarray;
   iarr1:pintegerarray;
   per1:double;
   v1,v2:integer;
begin
	OldWidth:=Src.Width;
   OldHeight:=Src.Height;
   NewWidth:=Dst.Width;
   NewHeight:=Dst.Height;
	zx:=NewWidth/OldWidth;
   zy:=NewHeight/OldHeight;
   if (zx=1) and (zy=1) then begin
   	Dst.Assign( Src );
      exit;
   end;
   if (zx<1) and (zy<1) then begin
   	_SubResample1bitFilteredEx(Src,0,0,Src.Width-1,Src.Height-1,Dst);
      exit;
   end;
   getmem(darr1,sizeof(integer)*NewWidth);
   getmem(iarr1,sizeof(integer)*NewWidth);
   for x:=0 to NewWidth-1 do begin
   	d:=x/zx;
      iarr1[x]:=trunc(d);
    	darr1[x]:=trunc((d-iarr1[x])*131072);	// 2^17
   end;
   bmp1:=TIEWorkBitmap.Create(NewWidth,OldHeight,24);
   ////// horizontal
   per1:=100/(OldHeight+NewHeight+0.5);
   for y:=0 to OldHeight-1 do begin
      SrcImRow:=Src.Scanline[y];
      NewImRow:=bmp1.Scanline[y];
      for x:=0 to NewWidth-1 do begin
         iold:=iarr1[x];
         idiff:=darr1[x];
         iold2:=imin(iold+1,OldWidth-1);
			v1:=pbytearray(SrcImRow)^[iold2 shr 3] and iebitmask1[iold2 and $7];
         if v1<>0 then v1:=255 else v1:=0;
         v2:=pbytearray(SrcImRow)^[iold shr 3] and iebitmask1[iold and $7];
         if v2<>0 then v2:=255 else v2:=0;
         with NewImRow[x] do begin
         	r:=v2+(((v1-v2)*idiff) shr 17);
            b:=r;
            g:=r;
         end;
      end;
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*y));
   end;
   // vertical
   for y:=0 to NewHeight-1 do begin
      rold:=y/zy;
      iold:=trunc(rold);
      idiff:=trunc((rold-iold)*131072);	// 2^17
      OldImRow:=bmp1.Scanline[iold];
      NewImRow:=Dst.Scanline[y];
      if iold+1 < OldHeight then OldImRow2:=bmp1.Scanline[iold+1] else OldImRow2:=OldImRow;
      for x:=0 to NewWidth-1 do begin
         v1:=OldImRow[x].r;
         with NewImRow[x] do begin
         	r:=v1+(((OldImRow2[x].r-v1)*idiff) shr 17);
            g:=r;
            b:=r;
         end;
      end;
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*(y+OldHeight)));
   end;
   FreeAndNil(bmp1);
   freemem(darr1);
   freemem(iarr1);
end;

// Src and Dst must 8 bit
procedure _ResampleLinearAlpha(Src, Dst: TIEBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	zx,zy,rold,d:double;
   iold,iold2,x,y,idiff,xx,yy:integer;
   a,mm,mc:integer;
   OldWidth,OldHeight,NewWidth,NewHeight:integer;
   OldImRow,NewImRow,OldImRow2:pbytearray;
   OldScanline:ppointerarray;
   bmp1:TIEWorkBitmap;
   darr1:pintegerarray;
   iarr1,iarr2:pintegerarray;
   per1:double;
begin
	OldWidth:=Src.Width;
   OldHeight:=Src.Height;
   NewWidth:=Dst.Width;
   NewHeight:=Dst.Height;
	zx:=NewWidth/OldWidth;
   zy:=NewHeight/OldHeight;
   if (zx=1) and (zy=1) then begin
   	Dst.Assign(Src);
      exit;
   end;
   getmem(darr1,sizeof(integer)*NewWidth);
   getmem(iarr1,sizeof(integer)*NewWidth);
   getmem(iarr2,sizeof(integer)*NewWidth);
   for x:=0 to NewWidth-1 do begin
   	d:=x/zx;
      iarr1[x]:=trunc(d);
    	darr1[x]:=trunc((d-iarr1[x])*131072);	// 2^17
      iarr2[x]:=trunc(imin(x+1,NewWidth-1)/zx+0.0000000001);	// the 0.0000000001 avoid a math problem of Delphi
   end;
   bmp1:=TIEWorkBitmap.Create(NewWidth,OldHeight,8);
   ////// horizontal
   per1:=100/(OldHeight+NewHeight+0.5);
   if zx>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
         for x:=0 to NewWidth-1 do begin
            iold:=iarr1[x];
            idiff:=darr1[x];
            iold2:=imin(iold+1,OldWidth-1);
            a:=OldImRow[iold];
            NewImRow[x]:=a+(((OldImRow[iold2]-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end else begin
   	// zoom-out (median)
      for y:=0 to OldHeight-1 do begin
         OldImRow:=Src.Scanline[y];
         NewImRow:=bmp1.Scanline[y];
			for x:=0 to NewWidth-1 do begin
         	iold:=iarr1[x];
            iold2:=iarr2[x];
            mm:=0; mc:=0;
				for xx:=iold to iold2 do begin
            	inc(mm,OldImRow[xx]);
               inc(mc);
            end;
            NewImRow[x]:=mm div mc;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*y));
      end;
   end;
   // vertical
   if zy>1 then begin
   	// zoom-in (linear interpolation)
      for y:=0 to NewHeight-1 do begin
         rold:=y/zy;
         iold:=trunc(rold);
         idiff:=trunc((rold-iold)*131072);	// 2^17
         OldImRow:=bmp1.Scanline[iold];
         NewImRow:=Dst.Scanline[y];
         if iold+1 < OldHeight then
         	OldImRow2:=bmp1.Scanline[iold+1]
         else
         	OldImRow2:=OldImRow;
         for x:=0 to NewWidth-1 do begin
            a:=OldImRow[x];
            NewImRow[x]:=a+(((OldImRow2[x]-a)*idiff) shr 17);
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
   end else begin
   	// zoom-out (median)
      getmem(OldScanline,sizeof(pointer)*OldHeight);
      for y:=0 to OldHeight-1 do
      	OldScanline[y]:=bmp1.Scanline[y];
      for y:=0 to NewHeight-1 do begin
      	iold:=trunc( y / zy );
         iold2:=trunc( imin(y+1,NewHeight-1) / zy );
         NewImRow:=Dst.Scanline[y];
         for x:=0 to NewWidth-1 do begin
         	mm:=0; mc:=0;
				for yy:=iold to iold2 do begin
               OldImRow:=OldScanline[yy];
            	inc(mm,OldImRow[x]);
               inc(mc);
            end;
            NewImRow[x]:=mm div mc;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(y+OldHeight)));
      end;
      freemem(OldScanline);
   end;
   FreeAndNil(bmp1);
   freemem(darr1);
   freemem(iarr1);
   freemem(iarr2);
end;

/////////////////////////////////////////////////////////////////////////////////////////
// Subsample with filter sx? area of src to dst sizes
// note: works only with 1 bpp images
// the dst bitmap will be pf24bit
(*
procedure _SubResample1bitFiltered(src:TBitmap; sx1,sy1,sx2,sy2:integer; dst:TBitmap);
var
	x,y:integer;
   zdx,zdy,zdx1,zdy1:double;
   pxx:PRGB;
   rows:PArrayOfPByte;
   drows:PRGBROWS;
   wx,wy,t,tt,wy1,wy2,wx1,wx2:integer;
   rzdx,rzdy:integer;
   px2:pbytearray;
   twy1,twy2:pintegerarray;
   twx1,twx2:pintegerarray;
   bmask:pbytearray;
   dww1,dhh1:integer;
begin
	if (src.Width=0) or (src.Height=0) or (dst.Width=0) or (dst.Height=0) then exit;
   dst.pixelformat:=pf24bit;
   dhh1:=dst.height-1;
   dww1:=dst.width-1;
   // build an array of row pointers for source image
	getmem(rows,(sy2-sy1+1)*sizeof(pbyte));
	for y:=0 to sy2-sy1 do
   	rows^[y]:=src.scanline[y+sy1];
   // build an array of row pointer for target image
   getmem(drows,dst.height*sizeof(PRGBROW));
   for y:=0 to dhh1 do
   	drows^[y]:=dst.scanline[y];
   // subsample horizontal rate
	zdx:=(sx2-sx1+1)/dst.width;
   rzdx:=trunc(zdx);
   // subsample vertical rate
   zdy:=(sy2-sy1+1)/dst.height;
   rzdy:=trunc(zdy);
   // precalculate x and y coef
   getmem(twy1,dst.height*sizeof(integer));
   getmem(twy2,dst.height*sizeof(integer));
	for y:=0 to dhh1 do begin
      zdy1:=y*zdy;
      twy1^[y]:=trunc(zdy1 -zdy/2);
		if twy1^[y]<0 then twy1^[y]:=0;
      if twy1^[y]>=src.Height then twy1^[y]:=src.Height-1;
      twy2^[y]:=trunc(zdy1 +rzdy/2);
		if twy2^[y]<0 then twy2^[y]:=0;
      if twy2^[y]>=src.Height then twy2^[y]:=src.Height-1;
	end;
   getmem(twx1,dst.width*sizeof(integer));
   getmem(twx2,dst.width*sizeof(integer));
   for x:=0 to dww1 do begin
      zdx1:=x*zdx;
      twx1^[x]:=trunc(zdx1 -zdx/2)+sx1;
      if twx1^[x]<0 then twx1^[x]:=0;
      if (twx1^[x]-sx1)>src.Width then twx1^[x]:=src.Width-1;
      twx2^[x]:=trunc(zdx1 +zdx/2)+sx1;
      if twx2^[x]<0 then twx2^[x]:=0;
      if (twx2^[x]-sx1)>src.Width then twx2^[x]:=src.Width-1;
   end;
   // precalculate bitmask
   getmem(bmask,src.width);
   for x:=0 to src.width-1 do
		bmask^[x]:=iebitmask1[x mod 8];
   // subsample
	for y:=0 to dhh1 do begin
		pxx:=PRGB(drows^[y]);
      wy1:=twy1^[y];
      wy2:=twy2^[y];
      for x:=0 to dww1 do begin
         wx1:=twx1^[x];
         wx2:=twx2^[x];
         t:=0;
         tt:=0;
         for wy:=wy1 to wy2 do begin
            px2:=pbytearray(rows^[wy]);
            for wx:=wx1 to wx2 do begin
               if (px2^[wx shr 3] and bmask^[wx])<>0 then
                  inc(tt,255);
               inc(t);
            end;
         end;
         with pxx^ do begin
            r:=tt div t;
            g:=r;
            b:=r;
         end;
         inc(pxx);
      end;
   end;
   //
   freemem(twy1);
   freemem(twy2);
   freemem(twx1);
   freemem(twx2);
   freemem(rows);
   freemem(drows);
   freemem(bmask);
end;
*)

/////////////////////////////////////////////////////////////////////////////////////////
// Subsample with filter sx? area of src to dst sizes
// note: works only with 1 bpp images
// the dst bitmap MUST BE ie24RGB
procedure _SubResample1bitFilteredEx(src:TIEBaseBitmap; sx1,sy1,sx2,sy2:integer; dst:TIEBitmap);
var
	x,y:integer;
   zdx,zdy,zdx1,zdy1:double;
   pxx:PRGB;
   wx,wy,t,tt,wy1,wy2,wx1,wx2:integer;
   rzdx,rzdy:integer;
   px2:pbytearray;
   twy1,twy2:pintegerarray;
   twx1,twx2:pintegerarray;
   bmask:pbytearray;
   dww1,dhh1:integer;
begin
	if (src.Width=0) or (src.Height=0) or (dst.Width=0) or (dst.Height=0) then exit;
   dhh1:=dst.height-1;
   dww1:=dst.width-1;
   // subsample horizontal rate
	zdx:=(sx2-sx1+1)/dst.width;
   rzdx:=trunc(zdx);
   // subsample vertical rate
   zdy:=(sy2-sy1+1)/dst.height;
   rzdy:=trunc(zdy);
   // precalculate x and y coef
   getmem(twy1,dst.height*sizeof(integer));
   getmem(twy2,dst.height*sizeof(integer));
	for y:=0 to dhh1 do begin
      zdy1:=y*zdy;
      twy1^[y]:=trunc(zdy1 -zdy/2);
		if twy1^[y]<0 then twy1^[y]:=0;
      if twy1^[y]>=src.Height then twy1^[y]:=src.Height-1;
      twy2^[y]:=trunc(zdy1 +rzdy/2);
		if twy2^[y]<0 then twy2^[y]:=0;
      if twy2^[y]>=src.Height then twy2^[y]:=src.Height-1;
	end;
   getmem(twx1,dst.width*sizeof(integer));
   getmem(twx2,dst.width*sizeof(integer));
   for x:=0 to dww1 do begin
      zdx1:=x*zdx;
      twx1^[x]:=trunc(zdx1 -zdx/2)+sx1;
      if twx1^[x]<0 then twx1^[x]:=0;
      if (twx1^[x]-sx1)>src.Width then twx1^[x]:=src.Width-1;
      twx2^[x]:=trunc(zdx1 +zdx/2)+sx1;
      if twx2^[x]<0 then twx2^[x]:=0;
      if (twx2^[x]-sx1)>src.Width then twx2^[x]:=src.Width-1;
   end;
   // precalculate bitmask
   getmem(bmask,src.width);
   for x:=0 to src.width-1 do
		bmask^[x]:=iebitmask1[x mod 8];
   // subsample
	for y:=0 to dhh1 do begin
		pxx:=PRGB(dst.scanline[y]);
      wy1:=twy1^[y];
      wy2:=twy2^[y];
      for x:=0 to dww1 do begin
         wx1:=twx1^[x];
         wx2:=twx2^[x];
         t:=0;
         tt:=0;
         for wy:=wy1 to wy2 do begin
            px2:=pbytearray(src.scanline[wy+sy1]);
            for wx:=wx1 to wx2 do begin
               if (px2^[wx shr 3] and bmask^[wx])<>0 then
                  inc(tt,255);
               inc(t);
            end;
         end;
         with pxx^ do begin
            r:=tt div t;
            g:=r;
            b:=r;
         end;
         inc(pxx);
      end;
   end;
   //
   freemem(twy1);
   freemem(twy2);
   freemem(twx1);
   freemem(twx2);
   freemem(bmask);
end;


/////////////////////////////////////////////////////////////////////////////////////////
// Subsample with filter sx? area of src to dst sizes
// note: works only with 1 bpp images
(*
function _SubResample1bitFilteredDIB(src:pbyte; sxx,syy:integer; sx1,sy1,sx2,sy2:integer; dxx,dyy:integer):pbyte;
var
	x,y:integer;
   zdx,zdy,zdx1,zdy1:double;
   pxx:PRGB;
   rows:PArrayOfPByte;
   drows:PRGBROWS;
   wx,wy,t,tt,wy1,wy2,wx1,wx2:integer;
   rzdx,rzdy:integer;
   px2:pbytearray;
   twy1,twy2:pintegerarray;
   twx1,twx2:pintegerarray;
   bmask:pbytearray;
   dww1,dhh1:integer;
   lw1,lw24:integer;
   dst:pbyte;
begin
	result:=nil;
	if (dxx<=0) or (dyy<=0) then exit;
   dhh1:=dyy-1;
   dww1:=dxx-1;
   lw1:=IEBitmapRowLen(sxx,1,32);
   lw24:=IEBitmapRowLen(dxx,24,32);
   getmem(result,lw24*dyy);
   // build an array of row pointers for source image
	getmem(rows,(sy2-sy1+1)*sizeof(pbyte));
	for y:=0 to sy2-sy1 do
      rows^[y]:=pointer(integer(src)+(syy-(sy1+y)-1)*lw1);
   // build an array of row pointer for target image
   dst:=result;
   getmem(drows,dyy*sizeof(PRGBROW));
   for y:=0 to dhh1 do
      drows^[y]:=PRGBROW( pointer(integer(dst)+(dyy-y-1)*lw24) );
   // subsample horizontal rate
	zdx:=(sx2-sx1+1)/dxx;
   rzdx:=trunc(zdx);
   // subsample vertical rate
   zdy:=(sy2-sy1+1)/dyy;
   rzdy:=trunc(zdy);
   // precalculate x and y coef
   getmem(twy1,dyy*sizeof(integer));
   getmem(twy2,dyy*sizeof(integer));
	for y:=0 to dhh1 do begin
      zdy1:=y*zdy;
      twy1^[y]:=trunc(zdy1 -zdy/2);
		if twy1^[y]<0 then twy1^[y]:=0;
      if twy1^[y]>=syy then twy1^[y]:=syy-1;
      twy2^[y]:=trunc(zdy1 +rzdy/2);
		if twy2^[y]<0 then twy2^[y]:=0;
      if twy2^[y]>=syy then twy2^[y]:=syy-1;
	end;
   getmem(twx1,dxx*sizeof(integer));
   getmem(twx2,dxx*sizeof(integer));
   for x:=0 to dww1 do begin
      zdx1:=x*zdx;
      twx1^[x]:=trunc(zdx1 -zdx/2)+sx1;
      if twx1^[x]<0 then twx1^[x]:=0;
      if (twx1^[x]-sx1)>sxx then twx1^[x]:=sxx-1;
      twx2^[x]:=trunc(zdx1 +zdx/2)+sx1;
      if twx2^[x]<0 then twx2^[x]:=0;
      if (twx2^[x]-sx1)>sxx then twx2^[x]:=sxx-1;
   end;
   // precalculate bitmask
   getmem(bmask,sxx);
   for x:=0 to sxx-1 do
		bmask^[x]:=iebitmask1[x mod 8];
   // subsample
	for y:=0 to dhh1 do begin
		pxx:=PRGB(drows^[y]);
      wy1:=twy1^[y];
      wy2:=twy2^[y];
      for x:=0 to dww1 do begin
         wx1:=twx1^[x];
         wx2:=twx2^[x];
         t:=0;
         tt:=0;
         for wy:=wy1 to wy2 do begin
            px2:=pbytearray(rows^[wy]);
            for wx:=wx1 to wx2 do begin
               if (px2^[wx shr 3] and bmask^[wx])<>0 then
                  inc(tt,255);
               inc(t);
            end;
         end;
         with pxx^ do begin
            r:=tt div t;
            g:=r;
            b:=r;
         end;
         inc(pxx);
      end;
   end;
   //
   freemem(twy1);
   freemem(twy2);
   freemem(twx1);
   freemem(twx2);
   freemem(rows);
   freemem(drows);
   freemem(bmask);
end;
*)

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// VertHist and HorizHist are outputs
// norm_vert, norm_horiz are inputs
procedure TImageEnProc.CalcDensityHistogram(VertHist,HorizHist:pointer; norm_vert,norm_horiz:integer);
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
   tmpbmp:TIEBitmap;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
   GetReSel(fSX1,fSY1,fSX2,fSY2,fPolyS,fPolySCount,mask);
   if assigned(mask) and (not mask.IsEmpty) then begin
      tmpbmp:=TIEBitmap.Create;
      tmpbmp.Allocate(mask.x2-mask.x1+1,mask.y2-mask.y1+1,fIEBitmap.PixelFormat);
      fIEBitmap.CopyRectTo(tmpbmp,mask.x1,mask.y1,0,0,tmpbmp.Width,tmpbmp.Height);
      _CalcDensityHistogram(tmpbmp,0,0,tmpbmp.width,tmpbmp.height, fOnProgress, self, VertHist,HorizHist,norm_vert,norm_horiz);
      FreeAndNil(tmpbmp);
   end else
      _CalcDensityHistogram(fiebitmap,fSx1,fSy1,fSx2,fSy2, fOnProgress, self, VertHist,HorizHist,norm_vert,norm_horiz);
end;

// for pf24bit and pf1bit
// VertHist and HorizHist are outputs
// norm_vert, norm_horiz are inputs
procedure _CalcDensityHistogram(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject; VertHist,HorizHist:pintegerarray; norm_vert,norm_horiz:integer);
var
   col,row,pp:integer;
   ppx:pRGB;
   per1:double;
   bx:pbyte;
   tb:byte;
   bb,i,vmax,hmax,ww,hh:integer;
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	if Bitmap.Pixelformat=ie24RGB then begin
   	// ie24RGB
      for col:=fSelX1 to fSelX2 do
         HorizHist[col-fSelX1]:=0;
	  	for row:=fSelY1 to fSelY2 do begin
	   	ppx:=bitmap.ScanLine[row];
	      inc(ppx,fSelX1);
         VertHist[row-fSelY1]:=0;
	      for col:=fSelX1 to fSelX2 do begin
            with ppx^ do
               pp:=(r*21 + g*71 + b*8) div 100;
            inc( VertHist[row-fSelY1], pp);
            inc( HorizHist[col-fSelX1], pp);
	         inc(ppx);
	      end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
	   end;
   end else if Bitmap.Pixelformat=ie1g then begin
		// ie1g
      for col:=fSelX1 to fSelX2 do
         HorizHist[col-fSelX1]:=0;
      for row:=fSelY1 to fSelY2 do begin
      	bx:=Bitmap.Scanline[row];
		   inc(bx,fSelX1 SHR 3);
			bb:=7-(fSelX1 and 7);
         tb:=bx^;
         VertHist[row-fSelY1]:=0;
         for col:=fSelX1 to fSelX2 do begin
				if (bx^ and (1 shl bb))<>0 then begin
               inc( VertHist[row-fSelY1] );
               inc( HorizHist[col-fSelX1] );
            end;
		      dec(bb);
		      if bb=-1 then begin
            	bx^:=tb;
		         inc(bx);
               tb:=bx^;
		         bb:=7;
		      end;
		   end;
		   if bb<7 then
		      bx^:=tb;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
      end;
   end;
   // normalize outputs
   ww:=fSelX2-fSelX1+1;
   hh:=fSelY2-fSelY1+1;
   vmax:=VertHist[0];
   for i:=1 to hh-1 do
      if VertHist[i]>vmax then
         vmax:=VertHist[i];
   hmax:=HorizHist[0];
   for i:=1 to ww-1 do
      if HorizHist[i]>hmax then
         hmax:=HorizHist[i];
   if vmax<>0 then
      for i:=0 to hh-1 do
         VertHist[i]:=trunc((VertHist[i]/vmax)*norm_vert);
   if hmax<>0 then
      for i:=0 to ww-1 do
         HorizHist[i]:=trunc((HorizHist[i]/hmax)*norm_horiz);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure TImageEnProc.RemoveIsolatedPixels(NoiseColor:integer; PixelsCount:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if PixelsCount=0 then exit;
	if not BeginImageProcessing([],x1,y1,x2,y2,'RemoveIsolatedPixels',ProcBitmap,mask) then
   	exit;
	_IERemoveIsolatedPixels1Bit(ProcBitmap,x1,y1,x2,y2, NoiseColor, PixelsCount);
   EndImageProcessing(ProcBitmap,mask);
end;

procedure _IERemoveIsolatedPixels1Bit(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; NoiseColor:integer; IsolationMax:integer);
var
   col,row,y:integer;
   nmap:TIEWorkBitmap;
   ww,hh,vv:integer;
   pb:pbyte;
   r_lefttop,r_top,r_righttop,r_left,r_central,r_right,r_leftbottom,r_bottom,r_rightbottom:pbyte;
   lc:integer;
begin
	if IsolationMax=0 then exit;
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
	if Bitmap.Pixelformat=ie1g then begin
		// ie1g
      ww:=fSelX2-fSelX1+1;
      hh:=fSelY2-fSelY1+1;
      nmap:=TIEWorkBitmap.Create(ww+2,hh+2,8);
      l3zeromemory(nmap.Scanline[nmap.Height-1],nmap.RowLen*nmap.height);
      // calc map
      y:=1;
      if NoiseColor=0 then begin
	      // Noise (foreground) is BLACK
         for row:=fSelY1 to fSelY2 do begin
            pb:=bitmap.Scanline[row];
            r_top:=nmap.Scanline[y-1]; inc(r_top);
            r_lefttop:=r_top; dec(r_lefttop);
            r_righttop:=r_top; inc(r_righttop);
            r_central:=nmap.Scanline[y]; inc(r_central);
            r_left:=r_central; dec(r_left);
            r_right:=r_central; inc(r_right);
            r_bottom:=nmap.Scanline[y+1]; inc(r_bottom);
            r_leftbottom:=r_bottom; dec(r_leftbottom);
            r_rightbottom:=r_bottom; inc(r_rightbottom);
            lc:=0;
            for col:=fSelX1 to fSelX2 do begin
               if (pbytearray(pb)^[col shr 3] and iebitmask1[col and $7])=0 then begin
               	lc:=col-lc;
                  inc(r_lefttop,lc);
                  inc(r_top,lc);
                  inc(r_righttop,lc);
                  inc(r_left,lc);
                  inc(r_central,lc);
                  inc(r_right,lc);
                  inc(r_leftbottom,lc);
                  inc(r_bottom,lc);
                  inc(r_rightbottom,lc);
                  lc:=col;
                  //
                  inc(r_lefttop^);
                  inc(r_top^);
                  inc(r_righttop^);
                  inc(r_left^);
                  inc(r_central^);
                  inc(r_right^);
                  inc(r_leftbottom^);
                  inc(r_bottom^);
                  inc(r_rightbottom^);
               end;
            end;
            inc(y);
         end;
      end else begin
	      // Noise (foreground) is WHITE
         for row:=fSelY1 to fSelY2 do begin
            pb:=bitmap.Scanline[row];
            r_top:=nmap.Scanline[y-1]; inc(r_top);
            r_lefttop:=r_top; dec(r_lefttop);
            r_righttop:=r_top; inc(r_righttop);
            r_central:=nmap.Scanline[y]; inc(r_central);
            r_left:=r_central; dec(r_left);
            r_right:=r_central; inc(r_right);
            r_bottom:=nmap.Scanline[y+1]; inc(r_bottom);
            r_leftbottom:=r_bottom; dec(r_leftbottom);
            r_rightbottom:=r_bottom; inc(r_rightbottom);
            lc:=0;
            for col:=fSelX1 to fSelX2 do begin
               if (pbytearray(pb)^[col shr 3] and iebitmask1[col and $7])<>0 then begin
               	lc:=col-lc;
                  inc(r_lefttop,lc);
                  inc(r_top,lc);
                  inc(r_righttop,lc);
                  inc(r_left,lc);
                  inc(r_central,lc);
                  inc(r_right,lc);
                  inc(r_leftbottom,lc);
                  inc(r_bottom,lc);
                  inc(r_rightbottom,lc);
                  lc:=col;
                  //
                  inc(r_lefttop^);
                  inc(r_top^);
                  inc(r_righttop^);
                  inc(r_left^);
                  inc(r_central^);
                  inc(r_right^);
                  inc(r_leftbottom^);
                  inc(r_bottom^);
                  inc(r_rightbottom^);
               end;
            end;
            inc(y);
         end;
      end;
      // apply map
      if NoiseColor=0 then vv:=1 else vv:=0;
      y:=1;
      for row:=fSelY1 to fSelY2 do begin
	      pb:=bitmap.Scanline[row];
      	r_central:=nmap.Scanline[y]; inc(r_central);
         for col:=fSelX1 to fSelX2 do begin
            if (r_central^>0) and (r_central^<=IsolationMax) then
               _SetPixelbw(pb,col,vv);
            inc(r_central);
         end;
         inc(y);
      end;
      FreeAndNil(nmap);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Kfill - binary noise removal from "Practical Algorithms for Image Analysis" - Seul - O'Gorman - J.Sammon
const kf_MAXKMAX=21;
const kf_DFLTDIRTY=0;
const kf_MIN0RUN=5;
const kf_FILLINITIAL=false;

type tpintegerarray=array [0..maxint div 16] of pintegerarray;
type ppintegerarray=^tpintegerarray;
type tpbyte=array [0..maxint div 16] of pbytearray;
type ppbyte=^tpbyte;

kf_rec=record
	_OFF, _ON:integer;	// initial/final values of pixels
	FILL0, FILL1:byte;   // values of OFF fill, ON fill
	fDiff:integer;       // fNum difference from default
   cFlag:boolean;       // if =1, retain connectivity; if 0, don't
   eFlag:boolean;       // if =1, retain endpoint; if 0, don't
   imgSizex,imgSizey:integer;
	ySizeM1, xSizeM1:integer; // y,x lengths minus 1
	xRun:ppintegerarray;                    // no., then x locns of 1/0 runs for each y
   image:TIEWorkBitmap;
end;

function kf_GetPByte(image:TIEWorkBitmap; row,col:integer):pbyte;
begin
	with image do
		result:=pbyte(dword(Bits)+dword((Height-row-1)*Rowlen+col));
end;

function kf_ksize(x, y, kMax:integer; fillFlag:boolean; var rc:kf_rec):integer;
var
	xMask, yMask, xEnd, yEnd, k:integer;
	upHalf, downHalf, xStart, yStart:integer;
   px:pbyte;
begin
	with rc do begin
      if (fillFlag=false) then begin
         if (kf_GetPByte(image,y,x)^ <= FILL0) then begin
            result:=0;
            exit;
         end else if (kMax = 3) then begin
            result:=3;
            exit;
         end;
      end else begin
         if (kf_GetPByte(image,y,x)^ >= FILL1) then begin
            result:=0;
            exit;
         end else if (kMax = 3) then begin
            result:=3;
            exit;
         end;
      end;
      for k := 4 to kMax do begin
         if (k and 1 = 1) then begin
            upHalf := (k - 3) shr 1;
            downHalf := upHalf;
         end else begin
            upHalf := (k - 2) shr 1;
            downHalf := (k - 4) shr 1;
         end;
         xStart := x - downHalf;
         xEnd := x + upHalf;
         yStart := y - downHalf;
         yEnd := y + upHalf;
         if ((xStart <= 0) or (yStart <= 0) or (xEnd >= (imgSizex - 1)) or (yEnd >= ySizeM1)) then begin
            result:=(k - 1);
            exit;
         end;
         for yMask := yStart to yEnd do begin
         	px:=image.scanline[yMask];
            inc(px,xStart);
            for xMask := xStart to xEnd do begin
               if (fillFlag = false) then begin
                  if (px^ < FILL0) then begin
                     result:= (k - 1);
                     exit;
                  end;
               end else if (px^ > FILL1) then begin
                  result:=(k - 1);
                  exit;
               end;
               inc(px);
            end;
         end;
      end;
      result:=kMax;
   end;
end;

function kf_getring(x, y, k:integer; fillFlag:boolean; ring:pinteger; var rc:kf_rec):integer;
var
   xEnd, yEnd, i, xStart, yStart:integer;
   upHalf, downHalf:integer;
   px:pbyte;
begin
	with rc do begin
      if (k and 1 = 1) then begin
         upHalf := (k - 1) shr 1;
         downHalf := upHalf;
      end else begin
         upHalf := k shr 1;
         downHalf := (k - 2) shr 1;
      end;
      xStart := x - downHalf;
      xEnd := x + upHalf;
      yStart := y - downHalf;
      yEnd := y + upHalf;
      i := 0;
      ring^ := 0;
      if (fillFlag = false) then begin
         px:=image.scanline[yStart]; inc(px,xStart);
         for x := xStart to xEnd do begin
            if (px^ >= FILL0) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            inc(px);
         end;
         px:=kf_GetPByte(image,yStart+1,xEnd);
         for y := yStart + 1 to yEnd do begin
            if (px^ >= FILL0) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            dec(px,image.rowlen);
         end;
         px:=image.scanline[yEnd]; inc(px,xEnd-1);
         for x := xEnd - 1 downto xStart do begin
            if (px^ >= FILL0) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            dec(px);
         end;
         px:=kf_GetPByte(image,yEnd-1,xStart);
         for y := yEnd - 1 downto yStart+1 do begin
            if (px^ >= FILL0) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            inc(px,image.rowlen);
         end;
      end else begin
         px:=image.scanline[yStart]; inc(px,xStart);
         for x := xStart to xEnd do begin
            if (px^ > FILL1) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            inc(px);
         end;
         px:=kf_GetPByte(image,yStart+1,xEnd);
         for y := yStart + 1 to yEnd do begin
            if (px^ > FILL1) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            dec(px,image.rowlen);
         end;
         px:=image.scanline[yEnd]; inc(px,xEnd-1);
         for x := xEnd - 1 downto xStart do begin
            if (px^ > FILL1) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            dec(px);
         end;
         px:=kf_GetPByte(image,yEnd-1,xStart);
         for y := yEnd - 1 downto yStart+1 do begin
            if (px^ > FILL1) then
               ring^ := ring^ or (01 shl i);
            inc(i);
            inc(px,image.rowlen);
         end;
      end;
      result:=0;
   end;
end;

function kf_fillsqr(x, y, k:integer; fillFlag:boolean; nFill:pinteger; var rc:kf_rec):integer;
var
  xEnd, yEnd:integer;
  upHalf, downHalf, yStart, xStart:integer;
  px:pbyte;
begin
	with rc do begin
      if (k = 3) then begin
         if (fillFlag = false) then begin
            if (kf_GetPByte(image,y,x)^ > FILL0) then begin
               inc(nFill^);
               kf_GetPByte(image,y,x)^ := FILL0;
            end;
         end else begin
            if (kf_GetPByte(image,y,x)^ < FILL1) then begin
               inc(nFill^);
               kf_GetPByte(image,y,x)^ := FILL1;
            end;
         end;
      end else begin
         if (k and 1 = 1) then begin
            upHalf := (k - 3) shr 1;
            downHalf := upHalf ;
         end else begin
            upHalf := (k - 2) shr 1;
            downHalf := (k - 4) shr 1;
         end;
         xStart := x - downHalf;
         xEnd := x + upHalf;
         yStart := y - downHalf;
         yEnd := y + upHalf;
         for y := yStart to yEnd do begin
         	px:=image.scanline[y];
            inc(px,xStart);
            for x := xStart to xEnd do begin
               if (fillFlag = false) then begin
                  if (px^ > FILL0) then begin
                     inc(nFill^);
                     px^ := FILL0;
                  end;
               end else if (px^ < FILL1) then begin
                  inc(nFill^);
                  px^ := FILL1;
               end;
               inc(px);
            end;
         end;
      end;
      result:=0;
   end;
end;

function kf_fill(f0Table, f1Table:ppbyte; fillFlag:boolean; kMax:integer; change:pintegerarray; nFill:pinteger; var rc:kf_rec):integer;
var
  x, y, xStart, xEnd, iXRun, k, kM1:integer;
  ring, nChange, fillValue:integer;
begin
	with rc do begin
      nChange := 0;
      for y := 1 to ySizeM1-1 do begin
         iXRun := 1; x := 1;
         while iXRun <= xRun[y][0] do begin
            xStart := xRun[y][iXRun] - kMax + 2;
            if (xStart > x) then
            	xStart := xStart
            else
            	xStart := x;
            xEnd := xRun[y][iXRun + 1] + kMax - 2;
            if (xEnd > xSizeM1) then
               xEnd := xSizeM1;
				x := xStart;
            while x<=xEnd do begin
               k := kf_ksize(x, y, kMax, fillFlag,rc);
               if (k > 3) then
               	kM1 := k - 1
               else
               	kM1 := 3;
               while (k >= kM1) do begin
                  kf_getring(x, y, k, fillFlag, @ring,rc);
                  if (fillFlag = false) then
                  	fillValue := f0Table[k - 3][ring]
                  else
                  	fillValue := f1Table[k - 3][ring];
                  if (fillValue = 1) then begin
                     inc(nChange);
                     inc(change[k]);
                     kf_fillsqr(x, y, k, fillFlag, nFill,rc);
                     break;
                  end;
                  dec(k);
               end;
               inc(x);
	         end;
         	inc(iXRun,2);
      	end;
     	end;
     	result:=nChange;
   end;
end;

function kf_filltest(pack, k, fill01:integer; var rc:kf_rec):integer;
var
   nRing, n, i:integer;
   ring:pbytearray;
   fNum,cNum,m:integer;
   lower, upper:integer;
   nCornerOn, fNumThresh:integer;
begin
	with rc do begin
      getmem(ring, 4 * (k - 1));
      try
      // unpack ring from word to array
      nRing := 4 * k - 4;
      for i := 0 to nRing-1 do
         ring[i] := (pack shr i) and 01;
      // calculate CNUM, first skipping corners
      cNum := 0;
      i:=2;
      while i<nRing do begin
         lower := ring[i - 1];
         if ((i mod (k - 1)) = 0) then
            inc(i);                      // skip the corner pixels
         upper := ring[i];
         if ((upper <> 0) and (lower = 0)) then
            inc(cNum);
         inc(i);
      end;
      if ((ring[1] <> 0) and (ring[nRing - 1] = 0)) then
         inc(cNum);
      // CNUM at corners
      nCornerOn := 0;
      for n := 1 to 4-1 do begin
         m := n * (k - 1);
         if (ring[m] <> 0) then begin
            if ((ring[m - 1] = 0) and (ring[m + 1] = 0)) then
               inc(cNum);
            inc(nCornerOn);
         end;
      end;
     	if (ring[0] <> 0) then begin
      	if ((ring[1] = 0) and (ring[nRing - 1] = 0)) then
         	inc(cNum);
       	inc(nCornerOn);
     	end;
   	// calculate FNUM
     	if (fill01 = FILL1) then begin
      	fNum := 0;
      	for i := 0 to nRing-1 do
         	if (ring[i] <> 0) then
           		inc(fNum);
     	end else begin
      	fNum := 0;
      	for i := 0 to nRing-1 do
         	if (ring[i] = 0) then
           		inc(fNum);
     	end;
   	// to fill or not to fill
      if ((cFlag = false) or ((cFlag) and (cNum <= 1))) then begin
      	fNumThresh := 3 * (k - 1) - 1 + fDiff;
       	if ((fill01 = FILL1) or (eFlag = false)) then begin
         	if (fNum > fNumThresh) then begin
            	result:=1;
               exit;
         	end;
            if ((fNum = fNumThresh) and (nCornerOn = 2)) then begin
               result:=1;
               exit;
            end;
      	end else begin
            if (fNum = nRing) then begin
               result:=1;
               exit;
            end;
            if ((fNum = fNumThresh) and (nCornerOn = 2)) then begin
               result:=1;
               exit;
            end;
         end;
      end;
      result:=0;
      finally
      	freemem(ring);
      end;
   end;	// end with
end;

function kf_fill0(f0Table,f1Table:ppbyte; fillFlag:boolean; kMax:integer; change:pintegerarray; nONs, nFill:pinteger; var rc:kf_rec):integer;
var
  x, y, iXRun, k, kM1:integer;
  ring, nChange, fillValue, onRun:integer;
  image_px:pbyte;
begin
	with rc do begin
      nChange := 0;
      nONs^ := 0;
      for y := 1 to ySizeM1-1 do begin
         getmem(xRun[y], (imgSizex + 1)*sizeof(integer));
         xRun[y][0] := -kf_MIN0RUN;
         iXRun := 1;
         onRun := 0;
			x := 1;
         image_px:=image.scanline[y]; inc(image_px);
         while x<xSizeM1 do begin
            if (image_px^ <= FILL0) then begin
               if (onRun = 1) then begin
                  onRun := 0;
                  if (x - 1 >= imgSizex) then
                     xRun[y][iXRun] := xSizeM1
                  else
                     xRun[y][iXRun] := x - 1;
                  inc(iXRun);
               end;
            end else begin
            	if (onRun = 0) then begin
             		onRun := 1;
             		if ((x - xRun[y][iXRun - 1]) < kf_MIN0RUN) then
               		dec(iXRun)
                  else begin
                  	if (x < 0) then
               			xRun[y][iXRun] := 1
                     else
	                     xRun[y][iXRun] := x;
                     inc(iXRun);
                  end;
           		end;
           		inc(nONs^);
         	end;
         	k := kf_ksize(x, y, kMax, fillFlag,rc);
            if (k > 3) then
	         	kM1 :=  k - 1
            else
					kM1 :=  3;
         	while (k >= kM1) do begin
           		kf_getring(x, y, k, fillFlag, @ring,rc);
               if (fillFlag = false) then
	           		fillValue := f0Table[k - 3][ring]
               else
               	fillValue := f1Table[k - 3][ring];
           		if (fillValue = 1) then begin
             		inc(nChange);
             		inc(change[k]);
             		kf_fillsqr(x, y, k, fillFlag, nFill,rc);
             		break;
           		end;
           		dec(k);
         	end;
            inc(x);
            inc(image_px);
       	end;
       	dec(iXRun);
       	if (iXRun and 1 = 1) then
         	inc(iXRun);
         xRun[y][iXRun] := x;
         xRun[y][0] := iXRun;
         reallocmem(xRun[y], sizeof(integer)*(iXRun + 1));
      end;
      result:=nChange;
   end;	// end with
end;

procedure _kf_kfill(bitmap:TIEBitmap; RetainConnectivity:boolean; RetainEndpoints:boolean; MaxIterations:integer; WindowSize:integer; InvertImage:boolean);
var
   x, y, i, k:integer;
   f0Table:ppbyte;
   f1Table:ppbyte;
   kMax,maxIter,nTable,nIter,
   pctDirty,nChange,nChangeB4,
   nChangeMax,nChangeThresh,
   nONs,nFill:integer;
   invertFlag:boolean;
   fillflag:boolean;
   change: array [0..kf_MAXKMAX-1] of integer;
   rc:kf_rec;
   ps,pd:pbyte;
begin
	with rc do begin
   	// inputs
      fDiff:=0;
      cFlag:=RetainConnectivity;
      eFlag:=RetainEndpoints;
      maxIter:=MaxIterations;
      pctDirty:=kf_DFLTDIRTY;
      kMax:=WindowSize;
      fillFlag:=kf_FILLINITIAL;
      invertFlag:=InvertImage;
      //
      imgSizex := bitmap.width;
     	imgSizey := bitmap.height;
      ySizeM1 := imgSizey - 1;
      xSizeM1 := imgSizex - 1;
		// invert image
      if invertFlag then
      	_Negative1BitEx(bitmap);
      // create image (working bitmap)
		image:=TIEWorkBitmap.Create(bitmap.width,bitmap.height,8);
      l3fillchar(pbyte(image.Scanline[image.Height-1])^,image.RowLen*image.height,255);
      for y:=0 to image.height-1 do begin
      	ps:=bitmap.scanline[y];
      	pd:=image.scanline[y];
      	for x:=0 to image.width-1 do begin
				if (pbytearray(ps)^[x shr 3] and iebitmask1[x and $7])=0 then
            	pd^:=0;
            inc(pd);
         end;
      end;
      //
      getmem(xRun,imgSizey*sizeof(integer));
      _OFF := 0;
      FILL0 := _OFF + 1;
      _ON := 255;
      FILL1 := _ON - 1;
   	// make table of fill-values for FILL0 and FILL1
      getmem(f0Table, (kMax - 2)* sizeof(pointer));
      getmem(f1Table, (kMax - 2)* sizeof(pointer));
      for k := 3 to kMax do begin
         nTable := trunc(iepower(2.0, 4.0 * (k - 1.0)));
         getmem(f0Table[k - 3], nTable* sizeof(byte));
         getmem(f1Table[k - 3], nTable* sizeof(byte));
         for i := 0 to nTable-1 do begin
            f0Table[k - 3][i] := kf_filltest (i, k, FILL0,rc);
            f1Table[k - 3][i] := kf_filltest (i, k, FILL1,rc);
			end;
     	end;
   	// zero image borders
      for y := 0 to imgSizey-1 do begin
	      kf_GetPByte(image,y,imgSizex - 1)^ := _OFF;
      	kf_GetPByte(image,y,0)^ := _OFF;
      end;
      for x := 0 to imgSizex-1 do begin
      	kf_GetPByte(image,ySizeM1,x)^ := _OFF;
      	kf_GetPByte(image,0,x)^ := _OFF;
      end;
      for k := 0 to kMax do
      	change[k] := 0;
		// iteratively convolve through image until filled
   	// on first iteration, perform filling and accumulate x-run info
      nChange := kf_fill0(f0Table, f1Table, fillFlag, kMax, @change[0], @nONs, @nFill,rc);
      nChangeMax := nChange;
      nChangeThresh := 0;
      nChangeB4 := nChangeThresh + 1;
      for i := 3 to kMax do
      	change[i] := 0;
      if (fillFlag = true) then begin
      	fillFlag := false;
       	inc(FILL0);
     	end else  begin
      	fillFlag := true;
       	dec(FILL1);
     	end;
   	// on subsequent iterations, perform filling
		nIter := 1;
      while (nIter < maxIter) and ((nChange > nChangeThresh) or (nChangeB4 > nChangeThresh)) do begin
      	nChangeB4 := nChange;
         nChange := kf_fill(f0Table, f1Table, fillFlag, kMax, @change[0], @nFill,rc);
       	for i := 3 to kMax do
         	change[i] := 0;
       	if (fillFlag = true)  then begin
         	inc(FILL0);
         	if (nChangeB4 <> 0) then
           		fillFlag := false;
       	end else begin
         	dec(FILL1);
         	if (nChangeB4 <> 0) then
           		fillFlag := true;
       	end;
       	if (nChange > nChangeMax) then
         	nChangeMax := nChange;
       	nChangeThresh := (pctDirty * nChangeMax) div 100;
         inc(nIter);
      end;
      for y := 1 to ySizeM1-1 do begin
      	pd:=image.scanline[y]; inc(pd);
			for x := 1 to imgSizex - 2 do begin
         	if (pd^ <= FILL0) then
           		pd^ := _OFF
         	else if (pd^ >= FILL1) then
           		pd^ := _ON;
            inc(pd);
       	end;
     	end;
		// un-invert image
      if invertFlag then begin
      	for y := 0 to imgSizey-1 do
         	for x := 0 to imgSizex-1 do
         		kf_GetPByte(image,y,x)^ := 255 - kf_GetPByte(image,y,x)^;
     	end;
		// finish, get bitmap from image
      for y:=1 to image.height-2 do begin
      	ps:=bitmap.scanline[y];
      	pd:=image.scanline[y]; inc(pd);
      	for x:=1 to image.width-2 do begin
         	_setpixelbw(ps,x,pd^);
            inc(pd);
         end;
      end;
      //
      for y := 1 to ySizeM1-1 do
         freemem(xRun[y]);
      freemem(xRun);
      for k := 3 to kMax do begin
         freemem(f0Table[k - 3]);
         freemem(f1Table[k - 3]);
      end;
      freemem(f0Table);
      freemem(f1Table);
      //
   	FreeAndNil(image);
	end;	// end with
end;

// works only with black/white images
procedure TImageEnProc.RemoveNoise(Iterations:integer; InvertImage:boolean);
var
   fSX1,fSY1,fSX2,fSY2:integer;
   fPolyS:PPointArray;
   fPolySCount:integer;
   tmpbmp:TIEBitmap;
   mask:TIEMask;
begin
   if not MakeConsistentBitmap([]) then
      exit;
   if Iterations=0 then exit;
	if fAutoUndo then
   	SaveUndoCaptioned('RemoveNoise',ieuImage);
   GetReSel(fSX1,fSY1,fSX2,fSY2,fPolyS,fPolySCount,mask);
   if assigned(mask) and (not mask.IsEmpty) then begin
      tmpbmp:=TIEBitmap.Create;
      tmpbmp.Allocate(mask.x2-mask.x1+1,mask.y2-mask.y1+1,fIEBitmap.PixelFormat);
      fIEBitmap.CopyRectTo(tmpbmp,mask.x1,mask.y1,0,0,tmpbmp.Width,tmpbmp.Height);
		_kf_kfill(tmpbmp,true,true,Iterations,3,InvertImage);
      mask.CopyIEBitmap(fIEBitmap,tmpbmp,false,true,false);
      FreeAndNil(tmpbmp);
   end else
   	_kf_kfill(fIEBitmap,true,true,Iterations,3,InvertImage);
	Update;
end;

// end of kfill
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure _IEPaintMark(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; frequency:integer; color:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   col,row:integer;
   frx,fry:integer;
   px:PRGB;
   per1:double;
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	if Bitmap.Pixelformat=ie24RGB then begin
      fry:=0;
      for row:=fSelY1 to fSelY2 do begin
      	if fry=0 then begin
            frx:=0;
            px:=Bitmap.Scanline[row];
            for col:=fSelX1 to fSelX2 do begin
            	if frx=0 then
               	px^:=color;
               inc(frx);
               if frx>frequency then frx:=0;
               inc(px);
            end;
         end;
         inc(fry);
         if fry>frequency then fry:=0;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*(row-fSelY1+1)));
      end;
   end;
end;

procedure TImageEnProc.PaintMark(Frequency:integer; Color:TRGB);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'RemoveIsolatedPixels',ProcBitmap,mask) then
   	exit;
   _IEPaintMArk(ProcBitmap,x1,y1,x2,y2,frequency,color, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// images must have some size
function TImageEnProc.ComputeImageEquality(SecondImage:TIEBitmap;var psnr_min,psnr_max:double; var mse_min,mse_max:double; var rmse_min,rmse_max:double; var pae_min,pae_max:double; var mae_min,mae_max:double):boolean;
begin
	result:=false;
   if not MakeConsistentBitmap([]) then
      exit;
	if (fIEBitmap.PixelFormat<>ie24RGB) or (SecondImage.PixelFormat<>ie24RGB) then exit;
   if (fIEBitmap.Width<>SecondImage.Width) or (fIEBitmap.Height<>SecondImage.Height) then exit;
   _IEComputeDiff(fIEBitmap,SecondImage,psnr_min,psnr_max,mse_min,mse_max,rmse_min,rmse_max,pae_min,pae_max,mae_min,mae_max,result);
end;

// must be x.width=y.width and x.height=y.height and x.pixelformat=y.pixelformat
// psnr .... peak signal to noise ratio
// mse ..... mean squared error
// rmse .... root mean squared error
// pae ..... peak absolute error
// mae ..... mean absolute error
// equal ... equality (boolean)
procedure _IEComputeDiff(x,y:TIEBitmap; var psnr_min,psnr_max:double; var mse_min,mse_max:double;
												var rmse_min,rmse_max:double; var pae_min,pae_max:double;
                                    var mae_min,mae_max:double; var equal:boolean);
var
   compno:integer;
   msen1,msen2,pae,psnr:double;
	d:double;
	i,j:integer;
   px,py:pbyte;
begin
	psnr_min:=1000000000;
   psnr_max:=0;
   mse_min:= 1000000000;
   mse_max:=0;
   rmse_min:=1000000000;
   rmse_max:=0;
   pae_min:= 1000000000;
   pae_max:=0;
   mae_min:= 1000000000;
   mae_max:=0;
   equal:=true;
	for compno := 0 to 2 do begin
      msen1:=0; msen2:=0; pae:=0;
      for i := 0 to x.height-1 do begin
         px:=x.Scanline[i]; inc(px,compno);
         py:=y.Scanline[i]; inc(py,compno);
         for j := 0 to x.width-1 do begin
            d := py^ - px^;
            msen1 := msen1 + abs(d);
            msen2 := msen2+ (d * d);
            if (d > pae) then
               pae := d;
            inc(px,3);
            inc(py,3);
         end;
      end;
      msen1:= msen1 / (x.height * x.width);
      msen2:= msen2 / (x.height * x.width);
      if msen2<>0 then
	      psnr:= 20 * log10(255 / sqrt(msen2))
      else
      	psnr:=0;
      //
		if psnr>psnr_max then psnr_max:=psnr;
      if psnr<psnr_min then psnr_min:=psnr;
      if msen2>mse_max then mse_max:=msen2;
      if msen2<mse_min then mse_min:=msen2;
      d:=sqrt(msen2);
      if d<rmse_min then rmse_min:=d;
      if d>rmse_max then rmse_max:=d;
		if pae<pae_min then pae_min:=pae;
      if pae>pae_max then pae_max:=pae;
      if msen1<mae_min then mae_min:=msen1;
      if msen1>mae_max then mae_max:=msen1;
      if pae<>0 then equal:=false;
	end;
end;

function TImageEnProc.CompareWith(SecondImage:TIEBitmap; DiffBitmap:TIEBitmap):double;
begin
	result:=0;
   if not MakeConsistentBitmap([]) then
      exit;
   result:=IECompareImages(fIEBitmap,SecondImage,DiffBitmap);
end;

// diffmap must be ie8g or ie8p
function IECompareImages(image1,image2:TIEBitmap; diffmap:TIEBitmap):double;
var
	x,y:integer;
   w,h:integer;
   prgb1,prgb2:PRGB;
   i1,i2:integer;
   di:integer;
   d:double;
   dm:pbyte;
begin
	result:=0;
	if (image1.PixelFormat<>ie24RGB) or (image2.PixelFormat<>ie24RGB) then exit;
   if (image1.Width<>image2.Width) or (image1.Height<>image2.Height) then exit;
   w:=image1.Width;
   h:=image1.Height;
   d:=1;
   dm:=nil;
   for y:=0 to h-1 do begin
   	prgb1:=image1.Scanline[y];
      prgb2:=image2.Scanline[y];
		if assigned(diffmap) then
      	dm:=diffmap.Scanline[y];
   	for x:=0 to w-1 do begin

         with prgb1^ do
      		i1:=(r*21 + g*71 + b*8) div 100;
         with prgb2^ do
      		i2:=(r*21 + g*71 + b*8) div 100;

         di:=abs(i1-i2);

         d:=d+di/255;

      	inc(prgb1);
         inc(prgb2);
         if assigned(dm) then begin
         	dm^:=di;
            //diffmap.Alpha[x,y]:=di;
            inc(dm);
         end;
      end;
   end;
   d:=d / (w*h);
   result:=1-d;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure _IEGammaCorrect(ABitmap: TIEBitmap; AGamma: double; AChannel: TIEChannels; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	LUT: array[byte] of byte;
	C1, C2: integer;
   px:PRGB;
   per1:double;
   procedure BuildLUT(AValue: double); // Build Look-Up-Table
   var
      C1: integer;
   begin
      for C1 := 0 to 255 do
         LUT[C1] := blimit(Round(iepower(C1/255, 1/AValue)*255));
   end;
   //
begin
	per1:=100/ABitmap.Height;
   BuildLUT(AGamma);
   with ABitmap do
      for C1 := 0 to (Height-1) do begin
         px := ScanLine[C1];
         if AChannel=[iecRed,iecGreen,iecBlue] then begin
            for C2 := 0 to (width-1) do begin
               with px^ do begin
                  r:=LUT[r];
                  g:=LUT[g];
                  b:=LUT[b];
               end;
               inc(px);
            end;
         end else begin
            for C2 := 0 to (width-1) do begin
               with px^ do begin
               	if iecRed in AChannel then
	                  r:=LUT[r];
                  if iecGreen in AChannel then
	                  g:=LUT[g];
                  if iecBlue in AChannel then
   	               b:=LUT[b];
               end;
               inc(px);
            end;
         end;
	      if assigned(fOnProgress) then
	      	fOnProgress(Sender,trunc(per1*C1));
      end;
end;

procedure TImageEnProc.GammaCorrect(Gamma:double; Channel:TIEChannels);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'GammaCorrect',ProcBitmap,mask) then
   	exit;
	_IEGammaCorrect(ProcBitmap,Gamma,Channel,fOnProgress,Self);
   EndImageProcessing(ProcBitmap,mask);
end;


procedure TImageEnProc.SetIEBitmap(bmp:TIEBitmap);
begin
   fBitmap:=nil;
   if fIEBitmapCreated then
      FreeAndNil(fIEBitmap);
   fIEBitmapCreated:=false;
   fIEBitmap:=bmp;
end;

procedure TImageEnProc.SetAttachedIEBitmap(bmp:TIEBitmap);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);	// remove previous if exists
	if (not assigned(bmp)) and (assigned(fImageEnView) or assigned(fTImage)) then
   	exit;	// error
   SetIEBitmap(bmp);
  	if assigned(bmp) then begin
     	fImageEnView:=nil;
      fTImage:=nil;
   end;
end;

procedure TImageEnProc.SetAttachedBitmap(atBitmap:TBitmap);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);	// rimuove precedente, se c'è
	if (not assigned(atBitmap)) and (assigned(fImageEnView) or assigned(fTImage)) then
   	exit;	// error
   fBitmap:=atBitmap;
   fIEBitmap.EncapsulateTBitmap(fBitmap,true);
   if assigned(fBitmap) then begin
     	fImageEnView:=nil;
      fTImage:=nil;
   end;
end;

procedure TImageEnProc.SetAttachedImageEn(atImageEn:TIEView);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
   fImageEnView:=atImageEn;
   if assigned(fImageEnView) then begin		// fImageEnView now could be nil
      if fIEBitmapCreated then begin
         fIEBitmapCreated:=false;
         FreeAndNil(fIEBitmap);
      end;
      fBitmap:=fImageEnView.Bitmap;
      fIEBitmap:=fImageEnView.IEBitmap;
      if assigned(fIEBitmap) then
      	// use TIEBitmap
      	fBitmap:=nil	// both fBitmap and fIEBitmap not allowed
      else begin
      	// use TBitmap
      	fIEBitmapCreated:=true;
         fIEBitmap:=TIEBitmap.Create;
         fIEBitmap.EncapsulateTBitmap(fBitmap,true);
      end;
      fImageEnView.FreeNotification(self);
      fTImage:=nil;
      fImageEnViewIdx:=fImageEnView.RegisterBitmapChangeEvent(OnBitmapChange);
   end else begin
      fIEBitmap:=TIEBitmap.Create;
	   fIEBitmapCreated:=true; // we create fIEBitmap
   end;
end;

procedure TImageEnProc.SetTImage(v:TImage);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
	fTImage:=v;
   if assigned(fTImage) then begin
   	fBitmap:=fTImage.Picture.Bitmap;
      fIEBitmap.EncapsulateTBitmap(fBitmap,true);
      fTImage.FreeNotification(self);
      fImageEnView:=nil;
   end else
      fIEBitmap.FreeImage;
end;

(*
procedure DrawLine(bitmap:TIEBitmap; x1, y1, x2, y2:integer; color:TRGB);
var
	dx, dy, incr1, incr2, d, x, y, xend, yend, xdirflag, ydirflag:integer;
begin
	dx := abs(x2-x1);
	dy := abs(y2-y1);
	if (dy <= dx) then begin
		d := 2*dy - dx;
		incr1 := 2*dy;
		incr2 := 2 * (dy - dx);
		if (x1 > x2) then begin
			x := x2;
			y := y2;
			ydirflag := (-1);
			xend := x1;
		end else begin
			x := x1;
			y := y1;
			ydirflag := 1;
			xend := x2;
		end;
      bitmap.Pixels_ie24RGB[x,y]:=color;
		if (((y2 - y1) * ydirflag) > 0) then begin
			while (x < xend) do begin
				inc(x);
				if (d <0) then begin
					inc(d,incr1);
				end else begin
					inc(y);
					inc(d,incr2);
				end;
            bitmap.Pixels_ie24RGB[x,y]:=color;
			end;
		end else begin
			while (x < xend) do begin
				inc(x);
				if (d <0) then begin
					inc(d,incr1);
				end else begin
					dec(y);
					inc(d,incr2);
				end;
            bitmap.Pixels_ie24RGB[x,y]:=color;
			end;
		end;
	end else begin
		d := 2*dx - dy;
		incr1 := 2*dx;
		incr2 := 2 * (dx - dy);
		if (y1 > y2) then begin
			y := y2;
			x := x2;
			yend := y1;
			xdirflag := (-1);
		end else begin
			y := y1;
			x := x1;
			yend := y2;
			xdirflag := 1;
		end;
      bitmap.Pixels_ie24RGB[x,y]:=color;
		if (((x2 - x1) * xdirflag) > 0) then begin
			while (y < yend) do begin
				inc(y);
				if (d <0) then begin
					inc(d,incr1);
				end else begin
					inc(x);
					inc(d,incr2);
				end;
            bitmap.Pixels_ie24RGB[x,y]:=color;
			end;
		end else begin
			while (y < yend) do begin
				inc(y);
				if (d <0) then begin
					inc(d,incr1);
				end else begin
					dec(x);
					inc(d,incr2);
				end;
            bitmap.Pixels_ie24RGB[x,y]:=color;
			end;
		end;
	end;
end;
*)

// this function doesn't SaveUndo
// call UpdateRect if connected to TImageEnView
// just draw a circle at x,y of "Width" size
procedure TImageEnProc.PaintPenMarker(x,y:integer; Width:integer; Color:TColor; BackgroundColor:TColor; Tolerance:integer);
var
   rgbColor,rgbBack:TRGB;
   //
   procedure DrawPix(px,py:integer);
   var
      bk:TRGB;
      max,v:integer;
   begin
      bk:=fIEBitmap.Pixels_ie24RGB[px,py];
      max:=abs(bk.r-rgbBack.r);
      v:=abs(bk.g-rgbBack.g);
      if v>max then max:=v;
      v:=abs(bk.b-rgbBack.b);
      if v>max then max:=v;
      if max<=Tolerance then begin
         fIEBitmap.Pixels_ie24RGB[px,py]:=rgbColor;
         if fIEBitmap.HasAlphaChannel then
         	fIEBitmap.Alpha[px,py]:=255;
      end;
   end;
   //
var
   p,xx,yy,g,w:integer;
   a,p2:double;
   iv:TImageEnView;
begin
   if not MakeConsistentBitmap([ie24RGB]) then
      exit;
   if (x<0) or (y<0) or (x>=fIEBitmap.Width) or (y>=fIEBitmap.Height) then exit;
   rgbColor:=TColor2TRGB(Color);
   rgbBack:=TColor2TRGB(BackgroundColor);
   DrawPix(x,y);  // draw central pixel
   Width:=Width div 2;
   for w:=1 to Width do begin
      p:=round(2*pi*w) shl 1;
      p2:=(2*pi/p);
      for g:=0 to p-1 do begin
         a:=p2*g;
         xx:=round(x+cos(a)*w);
         if xx<0 then xx:=0 else if xx>=fIEBitmap.Width then xx:=fIEBitmap.Width-1;
         yy:=round(y+sin(a)*w);
         if yy<0 then yy:=0 else if yy>=fIEBitmap.Height then yy:=fIEBitmap.Height-1;
         DrawPix(xx,yy);
      end;
   end;
   // update rect if attached to TImageEnView
   if assigned(AttachedImageEn) and (AttachedImageEn is TImageEnView) then begin
      iv:=AttachedImageEn as TImageEnView;
      xx:=iv.XBmp2Scr(x);
      yy:=iv.YBmp2Scr(y);
      w:=round((Width+1)*(iv.Zoom/100));
      iv.UpdateRect(rect(xx-w,yy-w,xx+w+1,yy+w+1));
   end;
end;

// fills the hist array (256 elements) with the gray levels histogram
// accept all TIEPixelFormat values
procedure _IEGetHistogram(Bitmap:TIEBitmap; hist:pintegerarray);
var
	y,x,v:integer;
   p_byte:pbyte;
   p_word:pword;
   p_rgb:PRGB;
   p_single:psingle;
begin
	l3zeromemory(hist,256*sizeof(integer));
	for y:=0 to Bitmap.Height-1 do begin
      case Bitmap.PixelFormat of
      	ie1g:		// black/white
         	begin
            	p_byte:=Bitmap.Scanline[y];
					for x:=0 to Bitmap.Width-1 do begin
               	if pbytearray(p_byte)^[x shr 3] and iebitmask1[x and $7]=0 then
                  	inc(hist[0])
                  else
                  	inc(hist[1]);
               end;
            end;
         ie8p:		// color (palette)
         	begin
            	p_byte:=Bitmap.Scanline[y];
               for x:=0 to Bitmap.Width-1 do begin
               	with Bitmap.Palette[ p_byte^ ] do
	               	v:=(r*21+g*71+b*8) div 100;
                  inc(hist[v]);
                  inc(p_byte);
               end;
            end;
         ie8g:		// gray scale (256 levels)
         	begin
            	p_byte:=Bitmap.Scanline[y];
               for x:=0 to Bitmap.Width-1 do begin
						inc(hist[p_byte^]);
                  inc(p_byte);
               end;
            end;
         ie16g:	//	gray scale (65536 levels), the array is always 256 levels
         	begin
            	p_word:=Bitmap.Scanline[y];
               for x:=0 to Bitmap.Width-1 do begin
               	inc(hist[p_word^ shr 8]);
                  inc(p_word);
               end;
            end;
         ie24RGB:	// color (true color)
				begin
               p_rgb:=Bitmap.ScanLine[y];
               for x:=0 to Bitmap.Width-1 do begin
               	with p_rgb^ do
							v:=(r*21+g*71+b*8) div 100;
                  inc(hist[v]);
                  inc(p_rgb);
               end;
            end;
         ie32f:	//	32bit float point gray scale, the array is always 256 levels
         	begin
            	p_single:=Bitmap.Scanline[y];
               for x:=0 to Bitmap.Width-1 do begin
               	inc(hist[trunc(p_single^*255)]);
                  inc(p_single);
               end;
            end;
      end;
   end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// binarization

// If Threshold is:
// >=0 : apply just specified threshold
// -1  : autocalculated using media
// -2 : calc Threshold, maximum entropy mode
// origbitmap and destbitmap must have some size
// destbitmap must be ie1g
// origbitmap: Accept all TIEPixelFormat values
procedure _ConvertToBWThresholdEx(OrigBitmap,DestBitmap:TIEBitmap; Threshold:integer; var Progress:TProgressRec);
var
	i,j,n:integer;
	x,y,v,b,mR,mG,mB:integer;
   p_rgb:pRGB;
   p_byte:pbyte;
   p_word:pword;
   p_single:psingle;
   p2:pbyte;
   hist:pintegerarray;
   prob:pdoublearray;
   hn,psiMax,Ps,Hs,psi:double;
   //
   procedure ConvPixel(Color:TRGB);
   begin
      b:=x and 7;
      with Color do
         v:=(r*21 + g*71 + b*8) div 100;
      if v>=Threshold then
         p2^:=p2^ or iebitmask1[b]
      else
         p2^:=p2^ and (not iebitmask1[b]);
      if b=7 then
         inc(p2);
   end;
begin
	if OrigBitmap.PixelFormat=ie1g then begin
   	// already black/white, just copy
      DestBitmap.AssignImage(OrigBitmap);
      exit;
   end;
   progress.per1:=100/(OrigBitmap.Height+0.5);
   hist:=nil;
   prob:=nil;
   case Threshold of
   	-1:
      	begin
            // calc Threshold, media mode
            _GetMediaContrastRGB(origBitmap,mR,mG,mB);
            Threshold:=(mR*21+mG*71+mB*8) div 100;
         end;
      -2:
      	begin
         	// calc Threshold, maximum entropy mode
            getmem(hist,256*sizeof(integer));
            _IEGetHistogram(origBitmap,hist);
				getmem(prob,256*sizeof(double));
            n:=OrigBitmap.Width*OrigBitmap.Height;
				for i := 0 to 255 do
            	prob[i] := hist[i] / n;
            hn:=0;
            psi:=0;
            for i := 0 to 255 do
            	if prob[i] <> 0 then
               	hn := hn - prob[i] * ln(prob[i]);
            psiMax := 0;
            for i := 1 to 255 do begin
            	Ps := 0;
               Hs := 0;
            	for j := 0 to i-1 do begin
               	Ps := Ps + prob[j];
                	if prob[j] > 0 then
                  	Hs := Hs - prob[j] * ln(prob[j]);
              	end;
              	if (Ps > 0) and (Ps < 1) then
               	psi := ln(Ps - Ps * Ps) + Hs / Ps + (Hn - Hs) / (1.0 - Ps);
              	if psi > psiMax then begin
               	psiMax := psi;
                	Threshold := i;
               end;
            end;
         end;
   end;
   if hist<>nil then
   	freemem(hist);
   if prob<>nil then
   	freemem(prob);
   for y:=0 to OrigBitmap.Height-1 do begin
      p2:=DestBitmap.ScanLine[y];
      case OrigBitmap.PixelFormat of
         ie8p:		// color (palette)
         	begin
            	p_byte:=OrigBitmap.Scanline[y];
               for x:=0 to OrigBitmap.Width-1 do begin
               	ConvPixel(OrigBitmap.Palette[ p_byte^ ]);
                  inc(p_byte);
               end;
            end;
         ie8g:		// gray scale (256 levels)
         	begin
            	p_byte:=OrigBitmap.Scanline[y];
               for x:=0 to OrigBitmap.width-1 do begin
               	ConvPixel(CreateRGB(p_byte^,p_byte^,p_byte^));
                  inc(p_byte);
               end;
            end;
         ie16g:	//	gray scale (65536 levels)
         	begin
            	p_word:=OrigBitmap.Scanline[y];
               for x:=0 to OrigBitmap.Width-1 do begin
               	ConvPixel(CreateRGB(p_word^ shr 8,p_word^ shr 8,p_word^ shr 8));
                  inc(p_word);
               end;
            end;
         ie24RGB:	// color (true color)
				begin
               p_rgb:=OrigBitmap.ScanLine[y];
               for x:=0 to OrigBitmap.Width-1 do begin
                  ConvPixel(p_rgb^);
                  inc(p_rgb);
               end;
            end;
         ie32f:	//	32bit float point gray scale
         	begin
            	p_single:=OrigBitmap.Scanline[y];
               for x:=0 to OrigBitmap.Width-1 do begin
               	ConvPixel(CreateRGB(trunc(p_single^*255),trunc(p_single^*255),trunc(p_single^*255)));
                  inc(p_single);
               end;
            end;
      end;
      with Progress do
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*(y+1)));
   end;
end;

// binarization
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// blur
// thanks to Roy Magne Klever for optimized code

const
   IEMaxGaussKernelSize = 100; // New Gaussian Blur optimized
   IEKernelScale = 16;
   IEKernelMultiplier = 1 shl IEKernelScale;
   IEKernelMultiplierd2 = IEKernelMultiplier div 2;

Type
   TIEGaussKernelSize = 1..IEMaxGaussKernelSize;
   TIEGaussKernel = record
      Size: TIEGaussKernelSize;
      RealWeights: array[-IEMaxGaussKernelSize..IEMaxGaussKernelSize] of double;
      IntWeights: array[-IEMaxGaussKernelSize..IEMaxGaussKernelSize] of integer;
   end;

procedure _IEMakeGaussKernel(var Kernel: TIEGaussKernel; Radius: double);
var
   J: Integer;
   Temp: double;
begin
   for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do begin
      Temp := J / Radius;
      Kernel.RealWeights[J] := Exp( -Temp * Temp / 1.5);	// was / 2 instead of 1.5
   end;
   // normalize kernel
   Temp := 0;
   for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do
   	Temp := Temp + Kernel.RealWeights[J];
   for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do
   	Kernel.IntWeights[j] := round(Kernel.RealWeights[j] * IEKernelMultiplier / Temp);
   Kernel.Size := IEMaxGaussKernelSize;
   // optimize size
   while (Kernel.Size > 1) and (Kernel.IntWeights[Kernel.Size] = 0) and
   	(Kernel.IntWeights[-Kernel.Size] = 0) do dec(Kernel.Size);
end;

procedure _IEBlurRow24Bit(const Kernel: TIEGaussKernel; SourcePtr, DestPtr: PRGBROW; RowLen: Integer);
var
   RowIndex, LoopIndex, KernelIndex, StopIndex: Integer;
   Src, Dst: PRGB;
   MaxLen: Integer;
   RR, GG, BB: Integer;
   W: Integer;
begin
   MaxLen := RowLen - 1;
   Dst := @DestPtr^[0];
   for RowIndex := 0 to MaxLen do begin
      KernelIndex := -Kernel.Size;
      LoopIndex := RowIndex - Kernel.Size;
      StopIndex := RowIndex + Kernel.Size;
      if StopIndex > MaxLen then
      	StopIndex := MaxLen;
      // start values
      RR := IEKernelMultiplierd2;
      GG := IEKernelMultiplierd2;
      BB := IEKernelMultiplierd2;
      // left part
      W := 0;
      while LoopIndex < 0 do begin
         inc(W, Kernel.IntWeights[KernelIndex]);
         inc(KernelIndex);
         inc(LoopIndex);
      end;
      with PRGB(SourcePtr)^ do begin
         inc(RR, W * r);
         inc(GG, W * g);
         inc(BB, W * b);
   	end;
      Src := @SourcePtr^[LoopIndex];
      // center part
      while LoopIndex <= StopIndex do begin
         W := Kernel.IntWeights[KernelIndex];
         with Src^ do begin
            inc(RR, W * r);
            inc(GG, W * g);
            inc(BB, W * b);
         end;
         inc(KernelIndex);
         inc(LoopIndex);
         inc(Src);
      end;
      W := 0;
      while KernelIndex <= Kernel.Size do begin
         inc(W, Kernel.IntWeights[KernelIndex]);
         inc(KernelIndex);
      end;
      with SourcePtr^[MaxLen] do begin
         inc(RR, W * r);
         inc(GG, W * g);
         inc(BB, W * b);
      end;
      // set pixel
      with Dst^ do begin
         r := RR shr IEKernelScale;
         g := GG shr IEKernelScale;
         b := BB shr IEKernelScale;
      end;
      inc(Dst);
   end;
end;

procedure _IEBlurRow8Bit(const Kernel: TIEGaussKernel; SourcePtr, DestPtr: pbytearray; RowLen: Integer);
var
   RowIndex, LoopIndex, KernelIndex, StopIndex: Integer;
   Src, Dst: pbyte;
   MaxLen: Integer;
   GR: Integer;
   W: Integer;
begin
   MaxLen := RowLen - 1;
   Dst := @DestPtr^[0];
   for RowIndex := 0 to MaxLen do begin
      KernelIndex := -Kernel.Size;
      LoopIndex := RowIndex - Kernel.Size;
      StopIndex := RowIndex + Kernel.Size;
      if StopIndex > MaxLen then
      	StopIndex := MaxLen;
      // start values
      GR := IEKernelMultiplierd2;
      // left part
      W := 0;
      while LoopIndex < 0 do begin
         inc(W, Kernel.IntWeights[KernelIndex]);
         inc(KernelIndex);
         inc(LoopIndex);
      end;
      inc(GR, W* SourcePtr[0]);
      Src := @SourcePtr^[LoopIndex];
      // center part
      while LoopIndex <= StopIndex do begin
         W := Kernel.IntWeights[KernelIndex];
         inc(GR,W*Src^);
         inc(KernelIndex);
         inc(LoopIndex);
         inc(Src);
      end;
      W := 0;
      while KernelIndex <= Kernel.Size do begin
         inc(W, Kernel.IntWeights[KernelIndex]);
         inc(KernelIndex);
      end;
      inc(GR,W*SourcePtr^[MaxLen]);
      // set pixel
      Dst^:=GR shr IEKernelScale;
      inc(Dst);
   end;
end;

procedure _IEGBlur(Bitmap: TIEBitmap; radius: double; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   X, Y: Integer;
   RowPtr, ColPtr: PRGBROW;
   RowPtr8, ColPtr8: pbytearray;
   Kernel: TIEGaussKernel;
   per:double;
begin
   if Radius > 0 then begin
      // calculate kernel
      per:=100/(Bitmap.Height+Bitmap.Width);
      _IEMakeGaussKernel(Kernel, Radius);
      case Bitmap.PixelFormat of
      	ie24RGB:
         	begin
               if Bitmap.Width > Bitmap.Height then
                  GetMem(RowPtr, Bitmap.Width * SizeOf(TRGB))
               else
                  GetMem(RowPtr, Bitmap.Height * SizeOf(TRGB));
               // blur rows
               for Y := 0 to Bitmap.Height - 1 do begin
                  _IEBlurRow24Bit(Kernel, Bitmap.ScanLine[y], RowPtr, Bitmap.Width);
                  copymemory(Bitmap.ScanLine[Y],RowPtr,Bitmap.Width*SizeOf(TRGB));
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per*Y));
               end;
               // blur columns
               GetMem(ColPtr, Bitmap.Height * SizeOf(TRGB));
               for X := 0 to Bitmap.Width - 1 do begin
                  for Y := 0 to Bitmap.Height - 1 do
                     RowPtr[Y] := PRGBROW(Bitmap.Scanline[y])[x];
                  _IEBlurRow24Bit(Kernel, RowPtr, ColPtr, Bitmap.Height);
                  for Y := 0 to Bitmap.Height - 1 do
                     PRGBROW(Bitmap.Scanline[y])[x] := ColPtr[Y];
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per*(X+Bitmap.Height)));
               end;
               FreeMem(ColPtr);
               FreeMem(RowPtr);
            end;
         ie8g:
         	begin
               if Bitmap.Width > Bitmap.Height then
                  GetMem(RowPtr8, Bitmap.Width )
               else
                  GetMem(RowPtr8, Bitmap.Height );
               // blur rows
               for Y := 0 to Bitmap.Height - 1 do begin
                  _IEBlurRow8Bit(Kernel, Bitmap.ScanLine[y], RowPtr8, Bitmap.Width);
                  copymemory(Bitmap.ScanLine[Y],RowPtr8,Bitmap.Width);
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per*Y));
               end;
               // blur columns
               GetMem(ColPtr8, Bitmap.Height );
               for X := 0 to Bitmap.Width - 1 do begin
                  for Y := 0 to Bitmap.Height - 1 do
                     RowPtr8[Y] := pbytearray(Bitmap.Scanline[y])[x];
                  _IEBlurRow8Bit(Kernel, RowPtr8, ColPtr8, Bitmap.Height);
                  for Y := 0 to Bitmap.Height - 1 do
                     pbytearray(Bitmap.Scanline[y])[x] := ColPtr8[Y];
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per*(X+Bitmap.Height)));
               end;
               FreeMem(ColPtr8);
               FreeMem(RowPtr8);
            end;
      end;
   end;
end;

procedure _IEGBlurRect8(Bitmap: TIEBitmap; x1,y1,x2,y2:integer; radius: double);
var
   X, Y, ww,hh : Integer;
   RowPtr8, ColPtr8: pbytearray;
   Kernel: TIEGaussKernel;
   p:pbyte;
begin
	if Bitmap.PixelFormat<>ie8g then exit;
   if Radius > 0 then begin
      // calculate kernel
      _IEMakeGaussKernel(Kernel, Radius);
      ww:=x2-x1+1;
      hh:=y2-y1+1;
      if ww > hh then
         GetMem(RowPtr8, ww )
      else
         GetMem(RowPtr8, hh );
      // blur rows
      for Y := y1 to y2 do begin
         p:=Bitmap.ScanLine[y];
         inc(p,x1);
         _IEBlurRow8Bit(Kernel, pointer(p), RowPtr8, ww);
         copymemory(p,RowPtr8,ww);
      end;
      // blur columns
      GetMem(ColPtr8, hh );
      for X := x1 to x2 do begin
         for Y := y1 to y2 do
            RowPtr8[Y-y1] := pbytearray(Bitmap.Scanline[y])[x];
         _IEBlurRow8Bit(Kernel, RowPtr8, ColPtr8, hh);
         for Y := y1 to y2 do
            pbytearray(Bitmap.Scanline[y])[x] := ColPtr8[Y-y1];
      end;
      FreeMem(ColPtr8);
      FreeMem(RowPtr8);
   end;
end;


// make gaussian blur
// PixelFormat can be: ie8g and ie24RGB
procedure TImageEnProc.Blur(radius:double);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB,ie8g],x1,y1,x2,y2,'Blur '+floattostr(radius),ProcBitmap,mask) then
   	exit;
	_IEGBlur(ProcBitmap,radius,fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// blur
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure _IEAddSoftShadow(bitmap:TIEBitmap; radius:double; OffSetX:integer; OffSetY:integer; AdaptBitmap:boolean; ShadowColor:TRGB; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	oldalpha:TIEBitmap;
   x,y,sz,omax:integer;
   po,pn,pb:pbyte;
   px:PRGB;
begin
   bitmap.AlphaChannel.Full:=false; // here we also create the alphachannel if doesn't exists
   if AdaptBitmap then begin
      // enlarge bitmap
      omax:=imax(abs(OffSetX),abs(OffsetY))*2;
      sz:=imax(trunc(radius*5)+omax,1);
      bitmap.Resize(bitmap.Width+sz,bitmap.Height+sz,0,0,iehCenter,ievCenter);
   end;
	//
	oldalpha:=TIEBitmap.Create;
   oldalpha.Assign( bitmap.AlphaChannel );
	_IEGBlur(bitmap.AlphaChannel,radius,fOnProgress,Sender);
   //
   if (offsetx<>0) or (offsety<>0) then
	   bitmap.AlphaChannel.MoveRegion(0,0,bitmap.AlphaChannel.Width-1,bitmap.AlphaChannel.Height-1,offsetx,offsety,0);
	//
   case bitmap.PixelFormat of
   	ie24RGB:
         for y:=0 to bitmap.AlphaChannel.Height-1 do begin
            po:=oldalpha.Scanline[y];
            pn:=bitmap.AlphaChannel.scanline[y];
            px:=bitmap.Scanline[y];
            for x:=0 to bitmap.AlphaChannel.Width-1 do begin
               if (po^=0) and (po^<>pn^) then
               	px^:=ShadowColor
               else
                  pn^:=po^;
               inc(po);
               inc(pn);
               inc(px);
            end;
         end;
      ie1g:
         for y:=0 to bitmap.AlphaChannel.Height-1 do begin
            po:=oldalpha.Scanline[y];
            pn:=bitmap.AlphaChannel.scanline[y];
            pb:=bitmap.Scanline[y];
            for x:=0 to bitmap.AlphaChannel.Width-1 do begin
               if (po^=0) and (po^<>pn^) then
						_SetPixelbw(pb,x,0)
               else
                  pn^:=po^;
               inc(po);
               inc(pn);
            end;
         end;
   end;
   FreeAndNil(oldalpha);
end;

// radius is the half of the shadow (ex radius=2, the shadow is 4 pixels)
procedure TImageEnProc.AddSoftShadow(radius:double; OffSetX:integer; OffSetY:integer; AdaptSize:boolean; ShadowColor:TColor);
begin
   if not MakeConsistentBitmap([]) then
      exit;
	if fAutoUndo then
   	SaveUndoCaptioned('AddSoftShadow',ieuImage);
	_IEAddSoftShadow(fIEBitmap,radius,OffSetX,OffSetY,AdaptSize,TColor2TRGB(ShadowColor),fOnProgress,self);
   Update;
end;

// radius is 0 use a 3x3 filter (fast)
function _IEAddSoftShadowRect(bitmap:TIEBitmap; radius:double; OffSetX:integer; OffSetY:integer; x1,y1,x2,y2:integer):integer;
var
	oldalpha:TIEBitmap;
   x,y:integer;
   po,pn,pb:pbyte;
   px:PRGB;
   sz,omax,sz2:integer;
   xx1,yy1,xx2,yy2:integer;
   filt:boolean;
begin
	filt:= radius=0;
	if filt then
   	radius:=2;
   omax:=imax(abs(OffSetX),abs(OffsetY))*2;
	sz:=imax(trunc(radius*5)+omax,1);
   sz2:=sz div 2;
   result:=sz;
   //
   bitmap.AlphaChannel.Full:=false; // here we also create the alphachannel if doesn't exists
	//
	oldalpha:=TIEBitmap.Create;
   oldalpha.Assign( bitmap.AlphaChannel );
   xx1:=x1-sz2;
   yy1:=y1-sz2;
   xx2:=x2+sz2;
   yy2:=y2+sz2;
   xx1:=imin(imax(0,xx1),Bitmap.Width-1);
   yy1:=imin(imax(0,yy1),Bitmap.Height-1);
   xx2:=imin(imax(0,xx2),Bitmap.Width-1);
   yy2:=imin(imax(0,yy2),Bitmap.Height-1);
   if filt then begin
	   _ApplyFilter8g(Bitmap.AlphaChannel,IEFiltPres[1],xx1,yy1,xx2,yy2);
   end else
	   _IEGBlurRect8(Bitmap.AlphaChannel,xx1,yy1,xx2,yy2,radius);
   //
   if (offsetx<>0) or (offsety<>0) then
      bitmap.AlphaChannel.MoveRegion(xx1,yy1,xx2,yy2,xx1+offsetx,yy1+offsety,0);
	//
   dec(x1,sz);
   inc(x2,sz);
   dec(y1,sz);
   inc(y2,sz);
   x1:=imin(imax(x1,0),bitmap.Width-1);
   y1:=imin(imax(y1,0),bitmap.Height-1);
   x2:=imin(imax(x2,0),bitmap.Width-1);
   y2:=imin(imax(y2,0),bitmap.Height-1);
   case bitmap.PixelFormat of
   	ie24RGB:
         for y:=y1 to y2 do begin
            po:=oldalpha.Scanline[y]; inc(po,x1);
            pn:=bitmap.AlphaChannel.scanline[y]; inc(pn,x1);
            px:=bitmap.Scanline[y]; inc(px,x1);
            for x:=x1 to x2 do begin
               if (po^=0) and (po^<>pn^) then
                  with px^ do begin
                     r:=0;
                     g:=0;
                     b:=0;
                  end
               else
                  pn^:=po^;
               inc(po);
               inc(pn);
               inc(px);
            end;
         end;
      ie1g:
         for y:=y1 to y2 do begin
            po:=oldalpha.Scanline[y];
            pn:=bitmap.AlphaChannel.scanline[y];
            pb:=bitmap.Scanline[y];
            for x:=x1 to x2 do begin
               if (po^=0) and (po^<>pn^) then
						_SetPixelbw(pb,x,0)
               else
                  pn^:=po^;
               inc(po);
               inc(pn);
            end;
         end;
   end;
   FreeAndNil(oldalpha);
end;

procedure _IEAddSoftShadowRect2(bitmap:TIEBitmap; size:integer; Intensity:double; OffsetX,OffsetY:integer; rx1,ry1,rx2,ry2:integer);
var
	x,y:integer;
   outbitmap:TIEBitmap;
   halfsize:integer;
 	kk:pdoublearray;
   p0,p1,p2,
   p3,   p4,
   p5,p6,p7:integer;
   x1,x2:integer;
   y1,y2:integer;
   k2d:ppointerarray;
   pym1,py,pyp1:pbyte;
   inp,oup:pbyte;
   width,height:integer;
   rrx1,rrx2:integer;
   rry1,rry2:integer;
   prgb1:PRGB;
   //
   procedure MakeGaussKernel1D(Kernel: pdoublearray; KernelLen:integer; Radius:double);
   var
      J: Integer;
      Temp: double;
      d:integer;
   begin
      d:=KernelLen div 2;
      for J := 0 to KernelLen-1 do begin
         Temp := (J-d) / Radius;
         Kernel[J] := Exp(-Intensity  -Temp * Temp / 2);
      end;
   end;
	//
   procedure IEDrawSpot8g;
   var
      xx,yy:integer;
      px:pbyte;
      pi:pinteger;
   begin
      for yy:=y1 to y2 do begin
         px:=outbitmap.Scanline[yy-ry1];
         inc(px,x1-rx1);
         pi:=k2d[yy-(y+OffsetY)+halfsize]; inc(pi,x1-(x+OffsetX)+halfsize);
         for xx:=x1 to x2 do begin
            px^:= imax( px^, pi^*inp^ shr 16 );
            inc(px);
            inc(pi);
         end;
      end;
   end;
   //
begin
	Intensity:=(100-Intensity)/100;
	halfsize:=size div 2;
   getmem(kk,sizeof(double)*size);

   MakeGaussKernel1D(kk,size, size/5);

   getmem(k2d,sizeof(pointer)*size);
   for y:=0 to size-1 do begin
   	getmem(k2d[y],sizeof(integer)*size);
   	for x:=0 to size-1 do
			pintegerarray(k2d[y])[x] := trunc(kk[x]*kk[y]*65536);
   end;
   freemem(kk);

   rx1:= imax(rx1-halfsize,0);
   ry1:= imax(ry1-halfsize,0);
   rx2:= imin(rx2+halfsize,bitmap.width-1);
   ry2:= imin(ry2+halfsize,bitmap.height-1);

   width:=rx2-rx1+1;
   height:=ry2-ry1+1;
   outbitmap:=TIEBitmap.Create;
   outbitmap.Allocate(width,height,ie8g);
   outbitmap.Fill(0);
	//
   rrx1:=imax(rx1,1);
   rrx2:=imin(rx2,bitmap.width-2);
   rry1:=imax(ry1,1);
   rry2:=imin(ry2,bitmap.height-2);
	for y:=rry1 to rry2 do begin
      y1:=imax(y+OffsetY-halfsize,0);
      y2:=imin(y+OffsetY+halfsize-1,bitmap.height-1);
      pym1:=bitmap.alphachannel.GetRow(y-1);
      py  :=bitmap.alphachannel.GetRow(y);
      pyp1:=bitmap.alphachannel.GetRow(y+1);
      inp:=py;
      oup:=outbitmap.GetRow(y-ry1);
      inc(oup,rrx1-rx1);
      inc(inp,rrx1);
      for x:=rrx1 to rrx2 do begin
         if inp^>0 then begin
            p0:=pbytearray(pym1)[x-1];
				p1:=pbytearray(pym1)[x];
            p2:=pbytearray(pym1)[x+1];
				//
            p3:=pbytearray(py)[x-1];
            p4:=pbytearray(py)[x+1];
				//
            p5:=pbytearray(pyp1)[x-1];
				p6:=pbytearray(pyp1)[x];
            p7:=pbytearray(pyp1)[x+1];
				if p0+p1+p2+p3+p4+p5+p6+p7<2040 then begin
               x1:=imax(x+OffsetX-halfsize,0);
               x2:=imin(x+OffsetX+halfsize-1,bitmap.width-1);
            	IEDrawSpot8g;
            end;
            oup^:=inp^;
         end;
         inc(inp);
         inc(oup);
      end;
      bitmap.alphachannel.FreeRow(y-1);
      bitmap.alphachannel.FreeRow(y);
      bitmap.alphachannel.FreeRow(y+1);
      outbitmap.FreeRow(y);
   end;
   //
   for y:=ry1 to ry2 do begin
   	prgb1:=bitmap.Scanline[y]; inc(prgb1,rx1);
      inp:=outbitmap.Scanline[y-ry1];
      oup:=bitmap.alphachannel.Scanline[y]; inc(oup,rx1);
   	for x:=rx1 to rx2 do begin
      	if oup^=0 then
         	with prgb1^ do begin
            	r:=0;
               g:=0;
               b:=0;
            end;
      	oup^:=inp^;
			inc(inp);
         inc(oup);
      	inc(prgb1);
      end;
   end;
   //
   for y:=0 to size-1 do
   	freemem(k2d[y]);
   freemem(k2d);
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// QRotate

// for AntialiasMode supports only Bilinear and Bicubic
procedure _IEQRotate(src: TIEBitmap; angle: double; Background: TColor; Filter:TIEAntialiasMode; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   fx, fy, a, tsin, tcos, cxSrc, cySrc, cxDest, cyDest: double;
   dw, dh, width, height, x, y: integer;
   bColor: TRGB;
   dest: TIEBitmap;
	//
   procedure RC(x, y: integer; var rgb:TRGB);
   begin
   	if (x <= width - 1) and (x >= 0) and (y <= height - 1) and (y >= 0) then
         rgb := PRGBROW(src.Scanline[y])^[x]
     	else
      	rgb := bColor;
   end;
	//
   function Bilinear(x, y: double): TRGB;
   var
      j, k, rr, gg, bb: integer;
      cx, cy, m0, m1: double;
      p0, p1, p2, p3: TRGB;
   begin
      j := trunc(x);
      k := trunc(y);
      cx := x - floor(x);
      cy := y - floor(y);
      RC(j, k,p0);
      RC(j + 1, k,p1);
      RC(j, k + 1,p2);
      RC(j + 1, k + 1,p3);
      with p0 do
      	m0 := r + cx * (p1.r - r);
      with p2 do
      	m1 := r + cx * (p3.r - r);
      rr := trunc(m0 + cy * (m1 - m0));
      with p0 do
      	m0 := g + cx * (p1.g - g);
      with p2 do
      	m1 := g + cx * (p3.g - g);
      gg := trunc(m0 + cy * (m1 - m0));
      with p0 do
	      m0 := b + cx * (p1.b - b);
      with p2 do
	      m1 := b + cx * (p3.b - b);
      bb := trunc(m0 + cy * (m1 - m0));
      with result do begin
      	r := rr;
         g := gg;
         b := bb;
      end;
   end;
   //
   function Bicubic(x, y: double): TRGB;
   var
      cr, cg, cb, j, k: integer;
      a, aa, b, bb, cc, dd, ee, ff, gg, hh, fr, fg, fb: double;
      t1, t2, t3, t4: double;
      p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16: TRGB;
   begin
      j := trunc(x);
      k := trunc(y);
      a := x - j;
      b := y - k;
      aa := -a * (1 - a) * (1 - a);
      bb := (1 - 2 * a * a + a * a * a);
      cc := a * (1 + a - a * a);
      dd := a * a * (1 - a);
      ee := -b * (1 - b) * (1 - b);
      ff := (1 - 2 * b * b + b * b * b);
      gg := b * (1 + b - b * b);
      hh := b * b * (b - 1);
      RC(j - 1, k - 1,p1);
      RC(j, k - 1,p2);
      RC(j + 1, k - 1,p3);
      RC(j + 2, k - 1,p4);
      RC(j - 1, k,p5);
      RC(j, k,p6);
      RC(j + 1, k,p7);
      RC(j + 2, k,p8);
      RC(j - 1, k + 1,p9);
      RC(j, k + 1,p10);
      RC(j + 1, k + 1,p11);
      RC(j + 2, k + 1,p12);
      RC(j - 1, k + 2,p13);
      RC(j, k + 2,p14);
      RC(j + 1, k + 2,p15);
      RC(j + 2, k + 2,p16);
      t1 := aa * p1.r + bb * p2.r + cc * p3.r - dd * p4.r;
      t2 := aa * p5.r + bb * p6.r + cc * p7.r - dd * p8.r;
      t3 := aa * p9.r + bb * p10.r + cc * p11.r - dd * p12.r;
      t4 := aa * p13.r + bb * p14.r + cc * p15.r - dd * p16.r;
      fr := ee * t1 + ff * t2 + gg * t3 + hh * t4;
      t1 := aa * p1.g + bb * p2.g + cc * p3.g - dd * p4.g;
      t2 := aa * p5.g + bb * p6.g + cc * p7.g - dd * p8.g;
      t3 := aa * p9.g + bb * p10.g + cc * p11.g - dd * p12.g;
      t4 := aa * p13.g + bb * p14.g + cc * p15.g - dd * p16.g;
      fg := ee * t1 + ff * t2 + gg * t3 + hh * t4;
      t1 := aa * p1.b + bb * p2.b + cc * p3.b - dd * p4.b;
      t2 := aa * p5.b + bb * p6.b + cc * p7.b - dd * p8.b;
      t3 := aa * p9.b + bb * p10.b + cc * p11.b - dd * p12.b;
      t4 := aa * p13.b + bb * p14.b + cc * p15.b - dd * p16.b;
      fb := ee * t1 + ff * t2 + gg * t3 + hh * t4;
      cr := trunc(fr);
      cg := trunc(fg);
      cb := trunc(fb);
      if cr < 0 then cr := abs(cr);
      if (cr > 255) then cr := 255;
      if cg < 0 then cg := abs(cg);
      if (cg > 255) then cg := 255;
      if cb < 0 then cb := abs(cb);
      if (cb > 255) then cb := 255;
      with result do begin
         r := cr;
         g := cg;
         b := cb;
      end;
   end;
	//
var
   px:PRGB;
   arx1,arx2:pdoublearray;
   ary1,ary2:double;
	per:double;
begin
   bColor := TColor2TRGB(Background);
   src.Resize(src.Width+6,src.Height+6,Background,255,iehLeft,ievTop);
   src.MoveRegion(0,0,src.Width-1-3,src.Height-1-3,3,3,Background);
   width := src.Width;
   height := src.Height;
   a := angle * pi / 180;
   dw := round(abs((width - 1) * cos(a)) + abs((height - 1) * sin(a)));
   dh := round(abs((width - 1) * sin(a)) + abs((height - 1) * cos(a)));
   dest:=TIEBitmap.Create;
   dest.Allocate(dw,dh,ie24RGB);
   tsin := sin(a);
   tcos := cos(a);
   cxSrc := (src.Width - 1) / 2;
   cySrc := (src.Height - 1) / 2;
   cxDest := (dest.Width - 1) / 2;
   cyDest := (dest.Height - 1) / 2;
   getmem(arx1,sizeof(double)*dest.Width);
   getmem(arx2,sizeof(double)*dest.Width);
   for x:=0 to dest.Width-1 do begin
   	arx1[x]:=cxSrc + (x - cxDest) * tcos;
      arx2[x]:=cySrc + (x - cxDest) * tsin;
	end;
   per:=100/(dest.Height);
   for y := 0 to dest.Height - 1 do begin
      px:=dest.Scanline[y];
      ary1:=(y - cyDest) * tsin;
      ary2:=(y - cyDest) * tcos;
      for x := 0 to dest.Width - 1 do begin
         fx := arx1[x] - ary1;
         fy := arx2[x] + ary2;
         case Filter of
            ierBilinear: px^ := Bilinear(fx, fy);
            ierBicubic: px^ := BiCubic(fx, fy);
         end;
         inc(px);
      end;
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per*y));
   end;
   freemem(arx1);
   freemem(arx2);
   src.AssignImage(dest);
   src.MoveRegion(3,3,src.Width-1-3,src.Height-1-3,0,0,Background);
   src.Resize(src.Width-6,src.Height-6,Background,255,iehLeft,ievTop);
   FreeAndNil(dest);
end;

// accept ie8g and ie8p
procedure _IEQRotate8(src: TIEBitmap; angle: double; Background:integer; Filter:TIEAntialiasMode);
var
   fx, fy, a, tsin, tcos, cxSrc, cySrc, cxDest, cyDest: double;
   dw, dh, width, height, x, y: integer;
   bColor: integer;
   dest: TIEBitmap;
	//
   procedure RC(x, y: integer; var col:integer);
   begin
   	if (x <= width - 1) and (x >= 0) and (y <= height - 1) and (y >= 0) then
         col := pbytearray(src.Scanline[y])^[x]
     	else
      	col := bColor;
   end;
	//
   function Bilinear(x, y: double): integer;
   var
      j, k: integer;
      cx, cy, m0, m1: double;
      p0, p1, p2, p3: integer;
   begin
      j := trunc(x);
      k := trunc(y);
      cx := x - floor(x);
      cy := y - floor(y);
      RC(j, k,p0);
      RC(j + 1, k,p1);
      RC(j, k + 1,p2);
      RC(j + 1, k + 1,p3);
     	m0 := p0 + cx * (p1 - p0);
     	m1 := p2 + cx * (p3 - p2);
      result := trunc(m0 + cy * (m1 - m0));
   end;
   //
   function Bicubic(x, y: double): integer;
   var
      cr, j, k: integer;
      a, aa, b, bb, cc, dd, ee, ff, gg, hh, fr: double;
      t1, t2, t3, t4: double;
      p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16: integer;
   begin
      j := trunc(x);
      k := trunc(y);
      a := x - j;
      b := y - k;
      aa := -a * (1 - a) * (1 - a);
      bb := (1 - 2 * a * a + a * a * a);
      cc := a * (1 + a - a * a);
      dd := a * a * (1 - a);
      ee := -b * (1 - b) * (1 - b);
      ff := (1 - 2 * b * b + b * b * b);
      gg := b * (1 + b - b * b);
      hh := b * b * (b - 1);
      RC(j - 1, k - 1,p1);
      RC(j, k - 1,p2);
      RC(j + 1, k - 1,p3);
      RC(j + 2, k - 1,p4);
      RC(j - 1, k,p5);
      RC(j, k,p6);
      RC(j + 1, k,p7);
      RC(j + 2, k,p8);
      RC(j - 1, k + 1,p9);
      RC(j, k + 1,p10);
      RC(j + 1, k + 1,p11);
      RC(j + 2, k + 1,p12);
      RC(j - 1, k + 2,p13);
      RC(j, k + 2,p14);
      RC(j + 1, k + 2,p15);
      RC(j + 2, k + 2,p16);
      t1 := aa * p1 + bb * p2 + cc * p3 - dd * p4;
      t2 := aa * p5 + bb * p6 + cc * p7 - dd * p8;
      t3 := aa * p9 + bb * p10 + cc * p11 - dd * p12;
      t4 := aa * p13 + bb * p14 + cc * p15 - dd * p16;
      fr := ee * t1 + ff * t2 + gg * t3 + hh * t4;
      cr := trunc(fr);
      if cr < 0 then cr := abs(cr);
      if (cr > 255) then cr := 255;
      result:=cr;
   end;
	//
var
   px:pbyte;
   arx1,arx2:pdoublearray;
   ary1,ary2:double;
begin
   bColor := Background;
   src.Resize(src.Width+6,src.Height+6,Background,255,iehLeft,ievTop);
   src.MoveRegion(0,0,src.Width-1-3,src.Height-1-3,3,3,Background);
   width := src.Width;
   height := src.Height;
   a := angle * pi / 180;
   dw := round(abs((width - 1) * cos(a)) + abs((height - 1) * sin(a)));
   dh := round(abs((width - 1) * sin(a)) + abs((height - 1) * cos(a)));
   dest:=TIEBitmap.Create;
   dest.Allocate(dw,dh,src.PixelFormat);
   tsin := sin(a);
   tcos := cos(a);
   cxSrc := (src.Width - 1) / 2;
   cySrc := (src.Height - 1) / 2;
   cxDest := (dest.Width - 1) / 2;
   cyDest := (dest.Height - 1) / 2;
   getmem(arx1,sizeof(double)*dest.Width);
   getmem(arx2,sizeof(double)*dest.Width);
   for x:=0 to dest.Width-1 do begin
   	arx1[x]:=cxSrc + (x - cxDest) * tcos;
      arx2[x]:=cySrc + (x - cxDest) * tsin;
	end;
   for y := 0 to dest.Height - 1 do begin
      px:=dest.Scanline[y];
      ary1:=(y - cyDest) * tsin;
      ary2:=(y - cyDest) * tcos;
      for x := 0 to dest.Width - 1 do begin
         fx := arx1[x] - ary1;
         fy := arx2[x] + ary2;
         case Filter of
            ierBilinear: px^ := Bilinear(fx, fy);
            ierBicubic: px^ := BiCubic(fx, fy);
         end;
         inc(px);
      end;
   end;
   freemem(arx1);
   freemem(arx2);
   src.AssignImage(dest);
   src.MoveRegion(3,3,src.Width-1-3,src.Height-1-3,0,0,Background);
   src.Resize(src.Width-6,src.Height-6,Background,255,iehLeft,ievTop);
   FreeAndNil(dest);
end;



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Bicubic and Bilinear resample

function Cubic(dx : double; jm1,j,jp1,jp2 : integer) : double;
var
	dx1,dx2,dx3 : double;
	h1,h2,h3,h4 : double;
begin
   dx1 := abs (dx);
   dx2 := dx1 * dx1;
   dx3 := dx2 * dx1;
   h1 := dx3 - 2 * dx2 + 1;
   result := h1 * j;
   dx1 := abs (dx - 1.0);
   dx2 := dx1 * dx1;
   dx3 := dx2 * dx1;
   h2 := dx3 - 2 * dx2 + 1;
   result := result + h2 * jp1;
   dx1 := abs (dx - 2.0);
   dx2 := dx1 * dx1;
   dx3 := dx2 * dx1;
   h3 := -dx3 + 5 * dx2 - 8 * dx1 + 4;
   result := result + h3 * jp2;
   dx1 := abs (dx + 1.0);
   dx2 := dx1 * dx1;
   dx3 := dx2 * dx1;
   h4 := -dx3 + 5 * dx2 - 8 * dx1 + 4;
   result := result + h4 * jm1;
   if (result < 0.0) then
      result := 0.0;
   if (result > 255.0) then
      result := 255.0;
end;

// filter 0=bilinear 1=bicubic
// works with ie24RGB and ie1g
procedure _IEQResample(SrcImg,DstImg : TIEBaseBitmap; filter:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   src_m1,src,src_p1,src_p2,
   s_m1,s,s_p1,s_p2 : PByteArray;
   d,dest : PByteArray;
   r,row : PDoubleArray;
   src_row,src_col : integer;
   bytes,b : integer;
   width,height : integer;
   orig_width,orig_height : integer;
   x_rat,y_rat : double;
   x_cum,y_cum : double;
   x_last,y_last : double;
   x_frac : PDoubleArray;
   y_frac,tot_frac : Double;
   dx,dy : double;
   i,j : integer;
   frac : integer;
   t : double;
   advance_dest_x,advance_dest_y : boolean;
   ix,minus_x,plus_x,plus2_x : integer;
   scale_type : (MAX_MAY,MAX_MIY,MIX_MAY,MIX_MIY);
   cancel : boolean;
   lp,np : integer;
begin
	lp := 0;
	cancel := false;
	orig_width := SrcImg.width;
	orig_height := SrcImg.height;
	width := DstImg.width;
	height := DstImg.height;
   case SrcImg.PixelFormat of
   	ie24RGB: bytes:=3;
      ie1g: bytes:=1;
      else
      	exit;
   end;
	x_rat := orig_width / width;
	y_rat := orig_height / height;
	if (x_rat < 1.0) and (y_rat < 1.0) then
   	scale_type := MAX_MAY
	else if (x_rat < 1.0) and (y_rat >= 1.0) then
   	scale_type := MAX_MIY
	else if (x_rat >= 1.0) and (y_rat < 1.0) then
   	scale_type := MIX_MAY
	else
   	scale_type := MIX_MIY;
   GetMem(src_m1,orig_width * bytes);
   GetMem(src,orig_width * bytes);
   GetMem(src_p1,orig_width * bytes);
   GetMem(src_p2,orig_width * bytes);
   GetMem(dest,width * bytes);
   GetMem(row,sizeof(double)* width * bytes);
   GetMem(x_frac,sizeof(double)*(width+orig_width));
   src_col := 0;
   x_cum := src_col;
   x_last := x_cum;
	for i := 0 to (width+orig_width-1) do begin
   	if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then begin
      	x_cum := x_cum + x_rat;
      	x_frac[i] := x_cum - x_last;
      end else begin
      	inc(src_col);
      	x_frac[i] := src_col-x_last;
      end;
   	x_last := x_last + x_frac[i];
   end;
	l3FillChar(row^, sizeof(double)*width*bytes,0);
	src_row := 0;
	y_cum := src_row;
	y_last := y_cum;
	CopyMemory(src,SrcImg.Scanline[0],orig_width * bytes);
	if src_row < (orig_height - 1) then
   	CopyMemory(src_p1,SrcImg.ScanLine[1],orig_width * bytes);
	if (src_row + 1) < (orig_height - 1) then
   	CopyMemory(src_p2,SrcImg.Scanline[2],orig_width * bytes);
	i := height;
	while i > 0 do begin
   	src_col := 0;
   	x_cum := src_col;
	   if ( (y_cum + y_rat) <= (src_row + 1 + 0.0001)) then begin
      	y_cum := y_cum + y_rat;
      	dy := y_cum-src_row;
      	y_frac := y_cum - y_last;
      	advance_dest_y := true;
      end else begin
      	y_frac := (src_row+1) - y_last;
      	dy := 1.0;
      	advance_dest_y := false;
      end;
   	y_last := y_last + y_frac;
   	s := src;
   	if src_row > 0 then
     		s_m1 := src_m1
   	else
      	s_m1 := src;
   	if src_row < (orig_height-1) then
      	s_p1 := src_p1
   	else
      	s_p1 := src;
   	if (src_row+1) < (orig_height-1) then
      	s_p2 := src_p2
   	else
      	s_p2 := s_p1;
   	r := row;
   	frac := 0;
   	j := width;
   	while j <> 0 do begin
      	if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then begin
         	x_cum := x_cum + x_rat;
         	dx := x_cum - src_col;
         	advance_dest_x := true;
         end else begin
         	dx := 1.0;
         	advance_dest_x := false;
         end;
      	tot_frac := x_frac[frac] * y_frac;
      	inc(frac);
      	if src_col > 0 then
         	minus_x := -bytes
      	else
         	minus_x := 0;
      	if src_col < (orig_width-1) then
         	plus_x := bytes
      	else
         	plus_x := 0;
      	if (src_col+1) < (orig_width-1) then
         	plus2_x := bytes * 2
      	else
         	plus2_x := plus_x;
      	if filter=1 then begin
         	// bicubic
            case scale_type of
               MAX_MAY :
                  for b := 0 to bytes-1 do
                        r[b] := r[b] + cubic(dy,Trunc(cubic(dx,s_m1[b+minus_x],s_m1[b],s_m1[b+plus_x],s_m1[b+plus2_x])),
                                                Trunc(cubic (dx, s[b+minus_x], s[b],s[b+plus_x], s[b+plus2_x])),
                                                Trunc(cubic (dx, s_p1[b+minus_x], s_p1[b], s_p1[b+plus_x], s_p1[b+plus2_x])),
                                                Trunc(cubic (dx, s_p2[b+minus_x], s_p2[b], s_p2[b+plus_x], s_p2[b+plus2_x]))) * tot_frac;
               MAX_MIY:
                  for  b := 0 to bytes-1 do
                     r[b] := r[b] + cubic (dx, s[b+minus_x], s[b], s[b+plus_x], s[b+plus2_x]) * tot_frac;
               MIX_MAY:
                  for b := 0 to bytes-1 do
                     r[b] := r[b] + cubic (dy, s_m1[b], s[b], s_p1[b], s_p2[b]) * tot_frac;
               MIX_MIY:
                  for b := 0 to bytes-1 do
                     r[b] := r[b] + s[b] * tot_frac;
            end;
      	end else begin
         	// bilinear
      		case scale_type of
         		MAX_MAY :
            		for b := 0 to bytes-1 do
	       				r[b] := r[b] + ((1 - dy) * ((1 - dx) * s[b] + dx * s[b+plus_x]) + dy  * ((1 - dx) * s_p1[b] + dx * s_p1[b+plus_x])) * tot_frac;
         		MAX_MIY :
                  for b := 0 to bytes-1 do
                     r[b] := r[b] + (s[b] * (1 - dx) + s[b+plus_x] * dx) * tot_frac;
         		MIX_MAY:
                  for b := 0 to bytes-1 do
                     r[b] := r[b] + (s[b] * (1 - dy) + s_p1[b] * dy) * tot_frac;
         		MIX_MIY:
                  for b := 0 to bytes-1 do
                     r[b] := r[b] + s[b] * tot_frac;
         	end;
			end;
      	if(advance_dest_x) then begin
         	inc(Integer(r),bytes*sizeof(double));
         	dec(j);
         end else begin
            inc(Integer(s_m1),bytes);
            inc(Integer(s),bytes);
            inc(Integer(s_p1),bytes);
            inc(Integer(s_p2),bytes);
            inc(src_col);
         end;
		end;
   	if advance_dest_y then begin
      	tot_frac := 1.0 / (x_rat * y_rat);
	      d := dest;
      	r := row;
      	ix := 0;
      	for j:= 0 to width-1 do begin
         	for b := 1 to bytes do begin
            	d[ix] := Byte(Trunc(r[ix] * tot_frac));
            	inc(ix);
            end;
         end;
      	copymemory(DstImg.scanline[height-i],dest,width*bytes);
      	l3FillChar(row^,sizeof(double) * width * bytes,0);
      	dec(i);
         if assigned(fOnProgress) then
         	fOnProgress(Sender,trunc((height-i)/height*100));
   	end else begin
         s := src_m1;
         src_m1 := src;
         src := src_p1;
         src_p1 := src_p2;
         src_p2 := s;
         inc(src_row);
         if (src_row+1) < (orig_height-1) then
            CopyMemory(src_p2,SrcImg.Scanline[src_row+2],orig_width * bytes);
      end;
   end;
   FreeMem(src_m1);
   FreeMem(src);
   FreeMem(src_p1);
   FreeMem(src_p2);
   FreeMem(dest);
   FreeMem(row);
   FreeMem(x_frac);
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnProc.SetTransparentColors(MinColor,MaxColor:TRGB; Alpha:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'SetTransparentColors',ProcBitmap,mask) then
   	exit;
	_SetTransparentColors(ProcBitmap,x1,y1,x2,y2, MinColor,MaxColor,Alpha, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;

// works with ie24RGB and ie1g
// for ie1g only MinColor.r cares
procedure _SetTransparentColors(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; MinColor,MaxColor:TRGB; alpha:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
	x,y:integer;
   px:PRGB;
   pa,pb:pbyte;
   per1:double;
   st:boolean;
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
   case bitmap.PixelFormat of
   	ie24RGB:
         for y:=fSelY1 to fSelY2 do begin
            px:=bitmap.Scanline[y]; inc(px,fSelX1);
            pa:=bitmap.AlphaChannel.Scanline[y]; inc(pa,fSelX1);
            for x:=fSelX1 to fSelX2 do begin
               with px^ do
                  if (r>=MinColor.r) and (g>=MinColor.g) and (b>=MinColor.b) and (r<=MaxColor.r) and (g<=MaxColor.g) and (b<=MaxColor.b) then
                     pa^:=alpha;
               inc(px);
               inc(pa);
            end;
            if assigned(fOnProgress) then
               fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
         end;
      ie1g:
      	begin
         	st:= MinColor.r>0;
            for y:=fSelY1 to fSelY2 do begin
               pb:=bitmap.Scanline[y];
               pa:=bitmap.AlphaChannel.Scanline[y]; inc(pa,fSelX1);
               for x:=fSelX1 to fSelX2 do begin
                  if pbytearray(pb)^[x shr 3] and iebitmask1[x and $7]=0 then begin
                  	if not st then
                  		pa^:=alpha;
                  end else begin
                  	if st then
                     	pa^:=alpha;
                  end;
                  inc(pa);
               end;
               if assigned(fOnProgress) then
                  fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
            end;
         end;
   end;
   bitmap.AlphaChannel.SyncFull;
end;

// return:
//   in Color the dominant color
//   in result the percentage
// works with ie1g and ie24RGB
function TImageEnProc.GetDominantColor(var Color:TRGB):integer;
var
	hist:array [0..255] of integer;
   x,y,tot,c,v,i:integer;
   hash:THash1;
   ptr1:integer;
   ptr2:Thash1Item;
   pxrgb:PRGB;
   maxv,maxi:integer;
   clist,vlist:TList;
begin
	result:=-1;
   if not MakeConsistentBitmap([]) then
      exit;
	tot:=fIEBitmap.Width*fIEBitmap.Height;
   if tot=0 then exit;
   case fIEBitmap.PixelFormat of
   	ie1g:
      	begin
			   _IEGetHistogram(fIEBitmap,@hist);
            if hist[0]>hist[1] then begin
            	result:= trunc((hist[0]/tot)*100);
               Color:=CreateRGB(0,0,0);
            end else begin
            	result:= trunc((hist[1]/tot)*100);
               Color:=CreateRGB(255,255,255);
            end;
         end;
      ie24RGB:
      	begin
         	clist:=TList.Create;
            vlist:=TList.Create;
            hash:=THash1.Create(13);
            for y:=0 to fIEBitmap.Height-1 do begin
               pxrgb:=fIEBitmap.ScanLine[y];
               for x:=0 to fIEBitmap.Width-1 do begin
               	with pxrgb^ do
                  	c:=(r shl 16) or (g shl 8) or (b);
                  if not hash.Insert2(c,ptr1,ptr2) then begin
                  	// the key (color) already exists
                  	v:=hash.GetValue(ptr1,ptr2);
                     vlist[v]:=pointer(integer(vlist[v])+1);
                  end else begin
                  	// the key (color) is new
                     v:=vlist.Add(pointer(1));
                     clist.Add(pointer(TRGB2TColor(pxrgb^)));
                     hash.SetValue(ptr1,ptr2,v);
                  end;
                  inc(pxrgb);
               end;
            end;
            maxv:=0;
            maxi:=0;
            hash.IterateBegin;
            repeat
					i:=hash.IterateGetValue;
               v:=integer(vlist[i]);
               if v>maxv then begin
               	maxv:=v;
                  maxi:=i;
               end;
            until not hash.IterateNext;
            Color:=TColor2TRGB(integer(clist[maxi]));
            result:=trunc((maxv/tot)*100);
            FreeAndNil(hash);
            FreeAndNil(clist);
            FreeAndNil(vlist);
         end;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(* Median Filtering

 purpose:

 Carry out fast median filtering on images using windows from 3x3 to 19x19
 maximum size.  Filtering can be of three types:

 1) substitute median if central point differs from median by a threshold amount,
 2) high pass sharpening
 3) edge extraction

 operation:

 Histogram in moving window at beginning of line is initiated. Histogram is
 updated after each move subtracting left column values from previous
 window, adding right column values.  Median updated by counting up
 or down number of pixels less than or greater than old median.

 For color images, the grayscale intensity of a pixel is computed as a weighted
 linear combination of RGB and counted in the histogram. The pixel with the
 nearest (L1 norm) color to the average of all pixels in the moving window except
 the central point is used in place of the median.
 The computation of the median for a color image has a complexity of O(N^4),
 whereas this technique is only O(N^2) or less and is as good when
 the window size is 19x19 when the median differs only by a
 small amount from the mean. For smaller windows performance degrades as
 the mean differs from the median, but it is still satisfactory down to
 a 5x5 window.

 Adaptive thresholding is used to preserve sharp edges. A pixel is replaced by
 the median or its nearast average color equivalent if it lies outside the 1st
 and 3rd quantile of the intensity distribution. The user may modify the
 position of the quantiles interactively. Defaults are the first and third
 quartiles. For grayscale images, the quantiles and medians are used directly.
 The green element of a TRGB record is used as an intensity measurement.
 The user must provide means of detecting whether or not an image is color
 or grayscale.

 author:

 I.Scollar, following Huang, Yang, Tang, unpublished report
 submitted under Defence Advanced Research Projects Agency contract
 no. MDA 903-77-G-1,"A fast two dimensional median filtering algorithm"
 T.S.Huang, G.J.Yang, G.Y.Tang, School of Electrical Engineering,
 Purdue University, West Lafayette, Indiana 47907, USA.

 First publication: T.S.Huang, G.J.Yang, G.Y.Tang, Proceedings IEEE Conference
 Pattern Recognition and Image Processing, Chicago 1978, p. 128 ff.

 I.Scollar, B.Weidner, T.S.Huang, Image enhancement using the median and the interquartile
 distance, Computer Vision, Graphics and Image Processing, 25 1984 236-251

 Original Fortran IV, 512x512 grayscale images G.Y.Tang, 1976
 Modifications:
 Large images on DEC PDP11, I. Scollar Sept. 1978
 Normalized sharpening, I.Scollar Sept. 1980
 Adaptive quantile thresholding, I.Scollar Sept. 1980
 Ported from DEC Fortran IV to Delphi 7 Pascal, I.Scollar March 11, 2003
 Extenstion to color images, I. Scollar, March 13, 2003
*)

type
  TSource = array[0..0] of pRGBRow;
  pSourcePtr = ^TSource;

procedure TImageEnProc.MedianFilter(WindowX,WindowY:integer; Brightness,Contrast,Multiplier,Threshold:integer; MedianOp:TIEMedFilType);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'MedianFilter',ProcBitmap,mask) then
   	exit;
	_IEMedianFilter(ProcBitmap,WindowX,WindowY,Brightness,Contrast,Multiplier,Threshold,MedianOp,fOnProgress,Self);
   EndImageProcessing(ProcBitmap,mask);
end;


procedure _IEMedianFilter(image: TIEBitmap; WindowX, WindowY: integer; Brightness, Contrast, Multiplier, Threshold: integer; MedianOp: TIEMedFilType; fOnProgress: TIEProgressEvent; Sender: TObject);
type
  PixelInt = packed record
    r: integer;
    g: integer;
    b: integer;
  end;
var
  aHeight, aHeight32, aWidth, aWidth32: integer;
  pTarget: pRGB;
  pSource: pRGB;
  Source: TIEBitmap;
  Target: TIEBitmap;
  Nwx, Nwx2, Nwx21, Nwy, Nwy2, WinTot, WinTot2: Integer;
  i, j, k, m, n: Integer;
  ii, jj: integer;
  Hist: array[0..255] of integer;
  HistIndex: integer;
  Sum, LTMedian, Median: integer;
  left1, right1: integer;
  Thresh: integer;
  CenterPixel: PRGB;
  CP, CPM, Gain, Off: double;
  Value: integer;
  Pix: TRGB;
  PixOut: TRGB;
  PixAverage: TRGB;
  PixelInteger: PixelInt;
  WinTot1: double;
  Diff, LastDiff: integer;
  Q, Q25, Q75, TQ25, TQ75, LTQ25, LTQ75: integer;

  procedure GetAveragePixelColor;
  var
    ii, jj: Integer;
  begin
      // compute average value of pixels in the window, excluding central pixel
    l3FillChar(PixelInteger, SizeOf(PixelInteger));
    l3FillChar(PixOut, SizeOf(PixOut), 255);
    for ii := -Nwy2 to Nwy2 do begin
      for jj := -Nwx2 to Nwx2 do begin
        if (ii = 0) and (jj = 0) then
          continue
        else begin
        	 with Source.Pixels_ie24RGB[jj + j,ii + i] do begin
             inc(PixelInteger.r,r);
             inc(PixelInteger.g,g);
             inc(PixelInteger.b,b);
          end;
        end;
      end;
    end;
    PixAverage.r := imax(0, iMin(255, trunc(PixelInteger.r * WinTot1)));
    PixAverage.g := imax(0, iMin(255, trunc(PixelInteger.g * WinTot1)));
    PixAverage.b := imax(0, iMin(255, trunc(PixelInteger.b * WinTot1)));
      // get the pixel in the window whose color is nearest to the average so that there are no color shifts}
    LastDiff := MaxInt;
    for ii := -Nwy2 to Nwy2 do begin
      for jj := -Nwx2 to Nwx2 do begin
        if (ii = 0) and (jj = 0) then
          continue
        else begin
          Pix := Source.Pixels_ie24RGB[jj + j,ii + i];
          Diff := (Abs(Pix.r - PixAverage.r) + Abs(Pix.g - PixAverage.g) + Abs(Pix.b - PixAverage.b));
          if (Diff = 0) then begin
            PixOut := Pix;
            break;
          end;
          if (Diff < LastDiff) then begin
            PixOut := Pix;
            LastDiff := Diff;
          end;
        end;
      end;
    end;
    pTarget^ := PixOut;
  end;

begin
  pSource := nil;
  Target := nil;
  try
    Source := image;
    aHeight := Source.Height - 1;
    aWidth := Source.Width;
    Target := TIEBitmap.Create;
    Target.Location := ieMemory;
    Target.Allocate(Source.Width, Source.Height, IE24RGB);
     {get processing window sizes}
    Nwx := WindowX;
    Nwy := WindowY;
    WinTot := Nwx * Nwy;
    WinTot1 := 1.0 / (WinTot - 1);
    Nwx2 := Nwx div 2;
    Nwy2 := Nwy div 2;
    Nwx21 := Nwx2 + 1;
    WinTot2 := Nwx * Nwy div 2;
    TQ25 := WinTot div 4;
    TQ75 := 3 * TQ25;
    aWidth32 := Source.Width - Nwx2;
    aHeight32 := Source.Height - Nwy2;
    CP := WinTot;
    Off := 5.1 * (Brightness - 50);
    CPM := Multiplier;
    Gain := Contrast;
    Thresh := trunc(Threshold * 2.56);
      {set other parameters}
    case MedianOp of
      mfMedianFilter:
        begin
          Thresh := trunc(Threshold * 2.56);
          TQ25 := (WinTot div 4) - trunc((Threshold - 50) * 0.02 * TQ25);
          TQ75 := 3 * (WinTot div 4) + trunc((Threshold - 50) * 0.02 * TQ25);
        end;
      mfSharpen:
        begin
          CPM := 6.36 - (1.0 + Multiplier * 0.04);
          CPM := CPM * (WinTot - 1);
          CP := CPM + 1.0;
          Gain := 1.0 / (CP - WinTot);
        end;
      mfEdgeExtract:
        begin
          CP := Wintot;
          Gain := 0.5 * Contrast / (WinTot - 1);
          Thresh := trunc(Threshold * 2.56);
        end;
    end;
    i := 0;
      {copy top of image or set it to white}
    while (i < Nwy2) do begin
      if assigned(fOnProgress) then
        fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      if (MedianOp = mfEdgeExtract) then
        l3FillChar(Target.Scanline[i]^, Source.Width * SizeOf(TRGB), 255)
      else
        l3Move(Source.ScanLine[i]^, Target.Scanline[i]^, Source.Width * SizeOf(TRGB));
      Inc(i);
    end;
     {main loop}
    while (i < aHeight32) do begin
      if (i mod 10) = 0 then
        if assigned(fOnProgress) then
          fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      pSource := pRGB(Source.Scanline[i]);
      pTarget := pRGB(Target.Scanline[i]);
       {copy left unprocessed side of image}
      if (MedianOp = mfEdgeExtract) then
        l3FillChar(Target.Scanline[i]^, Nwx2 * SizeOf(TRGB), 255)
      else
        l3Move(pSource^, pTarget^, SizeOf(TRGB) * Nwx2);
      inc(pTarget, Nwx2);
       {Initialize histogram for this line}
      l3FillChar(Hist, Sizeof(Hist));
      for k := -Nwy2 to Nwy2 do begin
        for n := -Nwx2 to Nwx2 do begin
          with Source.Pixels_ie24RGB[n + Nwx2,k + i] do
	          HistIndex := (r*54+g*182+b*20) shr 8;
          Inc(Hist[HistIndex]);
        end;
      end;
      Sum := 0;
      for m := 0 to 255 do begin
        Sum := Sum + Hist[m];
        if (Sum > TQ25) then
          break;
      end;
      Q25 := m;
      LTQ25 := Sum - Hist[m];
      Sum := 0;
      for m := 0 to 255 do begin
        Sum := Sum + Hist[m];
        if (Sum > WinTot2) then
          break;
      end;
      Median := m;
      LTMedian := Sum - Hist[m];
      Sum := 0;
      for m := 0 to 255 do begin
        Sum := Sum + Hist[m];
        if (Sum > TQ75) then
          break;
      end;
      Q75 := m;
      LTQ75 := Sum - Hist[m];
       {process all pixels in this line}
      CenterPixel := Source.Scanline[i];
      inc(CenterPixel,Nwx21);
      for j := Nwx21 to aWidth32-1 do begin

        left1 := j - Nwx21;
        right1 := j + Nwx2;
        for k := -Nwy2 to Nwy2 do begin
            {remove left side counts of window from histogram}
          with Source.Pixels_ie24RGB[left1,k+i] do
	          HistIndex := (r*54+g*182+b*20) shr 8;
          Dec(Hist[HistIndex]);
          if (HistIndex < Q25) then
            Dec(LTQ25);
          if (HistIndex < Median) then
            Dec(LTMedian);
          if (HistIndex < Q75) then
            Dec(LTQ75);
            {add right side counts of window to histogram}
          with Source.Pixels_ie24RGB[right1,k+i] do
	          HistIndex := (r*54+g*182+b*20) shr 8;
          Inc(Hist[HistIndex]);
          if (HistIndex < Q25) then
            Inc(LTQ25);
          if (HistIndex < Median) then
            Inc(LTMedian);
          if (HistIndex < Q75) then
            Inc(LTQ75);
        end;
          {update quartiles and median}
        if (LTQ25 < TQ25) then begin
          while ((LTQ25 + HIST[Q25]) < TQ25) do begin
            LTQ25 := LTQ25 + HIST[Q25];
            Inc(Q25);
          end;
        end else begin
          repeat
            Dec(Q25);
            LTQ25 := LTQ25 - HIST[Q25];
          until (LTQ25 < TQ25);
        end;
        if (LTMedian < WinTot2) then begin
          while ((LTMedian + HIST[Median]) < WinTot2) do begin
            LTMedian := LTMedian + HIST[Median];
            Inc(Median);
          end;
        end else begin
          repeat
            Dec(Median);
            LTMedian := LTMedian - HIST[Median];
          until (LTMedian < WinTot2);
        end;
        if (LTQ75 < TQ75) then begin
          while ((LTQ75 + HIST[Q75]) < TQ75) do begin
            LTQ75 := LTQ75 + HIST[Q75];
            Inc(Q75);
          end;
        end else begin
          repeat
            Dec(Q75);
            LTQ75 := LTQ75 - HIST[Q75];
          until (LTQ75 < TQ75);
        end;
        case MedianOp of
          mfMedianFilter:
            if (Thresh = 0) then
              GetAveragePixelColor
            else begin
              Q := Q75 - Q25;
              if (abs(CenterPixel^.g - Median) < Q) and
              (abs(CenterPixel^.r - Median) < Q) and
              (abs(CenterPixel^.b - Median) < Q) then
                pTarget^ := CenterPixel^
              else
                GetAveragePixelColor;
            end;
          mfSharpen:
            begin
              GetAveragePixelColor;
              value := trunc((CP * CenterPixel^.r - PixOut.r * WinTot) * Gain + Off);
              value := imax(0, iMin(255, value));
              pTarget^.r := value;
              value := trunc((CP * CenterPixel^.g - PixOut.g * WinTot) * Gain + Off);
              value := imax(0, iMin(255, value));
              pTarget^.g := value;
              value := trunc((CP * CenterPixel^.b - PixOut.b * WinTot) * Gain + Off);
              value := imax(0, iMin(255, value));
              pTarget^.b := value;
            end;
          mfEdgeExtract:
            begin
              value := trunc((CP * CenterPixel^.g - Median * WinTot) * Gain + Off);
              value := 255 - imax(0, iMin(255, value));
              if value < Thresh then
                value := 0
              else
                value := 255;
              pTarget^.r := value;
              pTarget^.g := value;
              pTarget^.b := value;
            end;
        end;
        inc(pTarget);
        inc(CenterPixel);
      end;
  {copy right unprocessed side of image}
      pSource := pRGB(Source.Scanline[i]);
      Inc(pSource, aWidth32-Nwx21+2);
      pTarget := pRGB(Target.Scanline[i]);
      Inc(pTarget, aWidth32-Nwx21+2);
      if (MedianOp = mfEdgeExtract) then
        l3FillChar(pTarget^, SizeOf(TRGB) * Nwx21, 255)
      else
        l3Move(pSource^, pTarget^, SizeOf(TRGB) * Nwx21);
      inc(i);
    end;
   {copy bottom of image}
    while (i <= aHeight) do begin
      if assigned(fOnProgress) then
        fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      if (MedianOp = mfEdgeExtract) then
        l3FillChar(Target.Scanline[i]^, Source.Width * SizeOf(TRGB), 255)
      else
        l3Move(Source.ScanLine[i]^, Target.Scanline[i]^, Source.Width * SizeOf(TRGB));
      Inc(i);
    end;
    Source.Assign(Target);
  finally
    FreeAndNil(Target);
  end;
end;

// Mediang Filtering
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
Locally adaptive image enhancement based on:

Wallis, R. An approach to the space variant restoration and enhancement of images. Proceedings, Symposium on Current Mathematical Problems in Image Science, Monterey CA,  1976 10-12 reprinted in C.O. Wilde E. Barrett, eds. Image Science Mathematics, Western Periodicals, North hollywood,CA, 1977. Summarised in Pratt:


Pratt, W.K. Digital Image Processing, 2nd. ed. John Wiley & Sons, New York, 1991, 248, 503

Programming for Delphi:

I. Scollar 2003

  W A L L I S  -  STATISTICAL DIFFERENCING USING WALLIS ALGORITHM

  PURPOSE:

  IMPLEMENT THE STATISTICAL DIFFERENCING FILTER OF WALLIS (SEE
  W. PRATT, DIGITAL IMAGE PROCESSING) FOR LARGE PICTURES
  AND LARGE WINDOWS GREATER THAN 20X20

  EFFICIENT SAMPLING TECHNIQUE TO COMPUTE LOCAL MEANS AND VARIANCES.

  OPERATION:

  THE WINDOW DIMENSIONS AND 5 PARAMETERS FOR THE WALLIS FORMULA:
	MEAN		- DESIRED LOCAL MEAN OF OUTPUT
			  A COMMONLY USED VALUE FOR MANY APPLICATIONS
			  IS 128.ALLOWED RANGE 0-255.
	S.D.		  DESIRED LOCAL STANDARD DEVIATION (CONTRAST)
			  OF OUTPUT PICTURE. ALLOWED RANGE 0-100.
			  COMMONLY USED RANGE 50-75.
	GAIN		  CONTROLS RATIO OF MEASURED TO DESIRED
			  LOCAL VARIANCE. ALLOWED RANGE 0-INFINITY
			  EFFECT:
				0	NO VARIANCE EQUALIZATION
					THIS IS THE SAME AS LEE'S
					ALGORITHM (IEEE PROC. PRIP 1978,P.56)


				INF	MAXIMUM VARIANCE EQUALIZATION
					THIS IS EQUIVALENT TO WATKIN'S
					ALGORITHM.
			  COMMONLY USED RANGE 4-25.
	EDGE FACT.	  CONTROLS AMOUNT OF MEAN EQUALIZATION
			  ALLOWED RANGE 0-1.
			  EFFECT:
				1	FULL MEAN EQUALIZATION
				0	MEASURED MEAN RESTORED

  AUTHORS:

  B. WEIDNER, RLMB, 1979
  BASED ON IDEAS TAKEN FROM MVEQN/F BY I. SCOLLAR 1979
  BASED ON IDEAS TAKEN FROM ANAY14 BY G. TANG, 1977

}

procedure _IEWallisFilter(image:TIEBitmap; WinWidth,WinHeight:integer; Mean,StDev,InGain,Edge,Limit:integer; Thresholding:boolean; fOnProgress:TIEProgressEvent; Sender:TObject);
const
	VH=15;
   VW=15;
type
	ColumnSums = array[0..0] of Extended;
	ColumnSumsPtr = ^ColumnSums;
var
	Target: TIEBitmap;
	aHeight, aWidth, aWidth32: Integer;
	Pix, White, Black: TRGB;
	r, g, b, h, l, s: double;
   ColSum: ColumnSumsPtr;
   ColSqs: ColumnSumsPtr;
   Nwx, Nwx2, Nwy, Nwy2: Integer;
   Bndx, Bndy: Boolean;
   i, j, jp: Integer;
   Total, W, C1, C2, C3, AMean, SDev, Gain, EF, ALim,
   Sum, SumSq, Asd, Amy, F1, F2: double;
   vwidth,vheight:integer;
   function getpx(x,y:integer):TRGB;
   begin
   	dec(x,VW);
      dec(y,VH);
   	if y<0 then y:=0 else if y>image.Height-1 then y:=image.Height-1;
      if x<0 then x:=0 else if x>image.Width-1 then x:=image.Width-1;
   	result:=image.Pixels_ie24RGB[x,y];
   end;
   procedure setpx(x,y:integer; v:TRGB);
   begin
   	dec(x,VW);
      dec(y,VH);
   	if y<0 then y:=0 else if y>image.Height-1 then y:=image.Height-1;
      if x<0 then x:=0 else if x>image.Width-1 then x:=image.Width-1;
   	target.Pixels_ie24RGB[x,y]:=v;
   end;
begin
   ColSum := nil;
   ColSqs := nil;
   White.b := 255;
   White.g := 255;
   White.r := 255;
   Black.b := 0;
   Black.g := 0;
   Black.r := 0;
  	try
   Target := TIEBitmap.Create;
   Target.Location := ieFile;
   Target.Allocate(image.Width, image.Height, IE24RGB);
	//
   vwidth := image.Width + VW*2;
   vheight := image.height + VH*2;
   {get window sizes and half sizes}
   aHeight := vHeight - 1;
   aWidth := vWidth - 1;
   if aHeight < aWidth then begin
      Nwx := Trunc(WinWidth / 100 * aHeight);
      Nwy := Trunc(WinHeight / 100 * aHeight);
   end else begin
      Nwx := Trunc(WinWidth / 100 * aWidth);
      Nwy := Trunc(WinHeight / 100 * aWidth);
   end;
   Nwx := iMax(Nwx, 21);
   Nwy := iMax(Nwy, 21);
   Nwx2 := (Nwx + 1) div 2;
   Nwy2 := (Nwy + 1) div 2;
   aWidth32 := aWidth - Nwx2;
   Total := Nwx * Nwy;
   W := 1 / Total;
   {get memory for the column sums and the column sum squared buffers}
   GetMem(ColSum, (vWidth + Nwx) * SizeOf(Extended));
   GetMem(ColSqs, (vWidth + Nwx) * SizeOf(Extended));
   l3FillChar(ColSum^, (vWidth + Nwx) * SizeOf(Extended));
   l3FillChar(ColSqs^, (vWidth + Nwx) * SizeOf(Extended));
   {initialization of Wallis formula parameters}
   Amean := (1.0 * Mean / 100);
   Sdev := (3.0 * StDev / 100);
   Gain := (100.0 * InGain / 100);
   EF := (1.0 * Edge / 100);
   Alim := (6.0 * Limit / 100);
   C1 := Gain * Sdev;
   C2 := EF * Amean;
   C3 := 1.0 - EF;
   {initialize column sums and squares of sums for first window swath}
   i := 0;
   while (i < Nwy) do begin
      jp := 0;
      while (jp < aWidth) do begin
         Pix := getpx(jp,i);
         RGB2HSL(Pix, h, s, l);
         ColSum^[jp] := ColSum^[jp] + l;
         ColSqs^[jp] := ColSqs^[jp] + Sqr(l);
         Inc(jp);
      end;
      Inc(i);
   end;
   {main loop}
   for i := 0 to aHeight do begin
      if assigned(fOnProgress) then
         fOnProgress(Sender,Trunc(i / vHeight * 100) + 1);
      if not ((i - Nwy2 < 0) or (i + Nwy2 > aHeight)) then begin

         {initialize sums in window for beginning of new line}
         Sum := 0.0;
         Sumsq := 0.0;
         jp := 0;
         while (jp <= Nwx - 1) do begin
            Sum := Sum + Colsum^[jp];
            Sumsq := Sumsq + Colsqs^[jp];
            Inc(jp);
         end;
         {new line}
         j := 0;
         while j < Nwx2 do begin
            if not Thresholding then
               setpx(j,i, getpx(j,i) )
            else
               setpx(j,i, White);
            Inc(j);
         end;
         jp := 0;
         while (j <= aWidth32) do begin
            {do the Wallis correction on the luminance l}
            Pix := getpx(j,i);
            RGB2HSL(Pix, h, s, l);
            amy := sum * w;
            asd := sqrt((sumsq * w - Sqr(amy)) + 1.0);
            if (asd > alim) then
               asd := alim;
            f1 := c1 / (gain * asd + sdev + 0.00001);
            f2 := c2 + c3 * amy;
            l := (l - amy) * f1 + f2;
            if (l > 1.0) then
               l := 1.0;
            if (l < 0.0) then
               l := 0.0;
            HSL2RGB(Pix, h, s, l);
            if not Thresholding then
               setpx(j,i,Pix)
            else
               if l > 0.5 then
                  setpx(j,i,White)
               else
                  setpx(j,i,Black);
            {update window}
            sum := sum + colsum^[jp + nwx] - colsum^[jp];
            sumsq := sumsq + colsqs^[jp + nwx] - colsqs^[jp];
            Inc(j);
            Inc(jp);
         end;
         {fill in the non-computable remainder of the line}
         while j <= aWidth do begin
            if not Thresholding then
               setpx(j,i, getpx(j,i) )
            else
               setpx(j,i, White);
            Inc(j);
         end;
         {update column sums for a new line}
         j := 0;
         l := 127;
         while (j <= aWidth32) do begin
            Pix := getpx(j, i-Nwy2 );
            RGB2HSL(Pix, h, s, l);
            ColSum^[j] := ColSum^[j] - l;
            ColSqs^[j] := ColSqs^[j] - Sqr(l);
            Pix := getpx(j, i+Nwy2 );
            RGB2HSL(Pix, h, s, l);
            ColSum^[j] := ColSum^[j] + l;
            ColSqs^[j] := ColSqs^[j] + Sqr(l);
            Inc(j);
         end;

      end;

   end; // end for
   image.Assign(Target);
  	finally
      FreeMem(ColSum);
      FreeMem(ColSqs);
      FreeAndNil(Target);
  	end;
end;

procedure TImageEnProc.WallisFilter(WinWidth,WinHeight:integer; Mean,StDev,InGain,Edge,Limit:integer; Thresholding:boolean);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([],x1,y1,x2,y2,'MedianFilter',ProcBitmap,mask) then
   	exit;
	_IEWallisFilter(ProcBitmap,WinWidth,WinHeight,Mean,StDev,InGain,Edge,Limit,Thresholding,fOnProgress,Self);
   EndImageProcessing(ProcBitmap,mask);
end;


// Wallis filter
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// works for ie24RGB ie1g
// return 0 or 90 (cannot detect down-up, inverted text)
function TImageEnProc.CalcOrientation:integer;
var
   VertHist,HorizHist:pintegerarray;
   i:integer;
   rh,rv:double;
begin
	result:=0;
   if not MakeConsistentBitmap([]) then
      exit;
   getmem(HorizHist,sizeof(integer)*fIEBitmap.Width);
   getmem(VertHist,sizeof(integer)*fIEBitmap.Height);
	_CalcDensityHistogram(fIEBitmap,0,0,fIEBitmap.Width,fIEBitmap.Height,fOnProgress,self,VertHist,HorizHist,1000,1000);
   rh:=0;
	for i:=0 to fIEBitmap.Width-2 do
		rh:=rh + sqr( HorizHist[i+1]-HorizHist[i] );
   rv:=0;
	for i:=0 to fIEBitmap.Height-2 do
		rv:=rv + sqr( VertHist[i+1]-VertHist[i] );
	if rh>rv then
   	result:=90;
   freemem(VertHist);
   freemem(horizHist);
end;

function _IECalcVertOrientationFitness(bitmap:TIEBitmap):integer;
var
   VertHist,HorizHist:pintegerarray;
   i:integer;
   rv:double;
begin
   getmem(HorizHist,sizeof(integer)*bitmap.Width);
   getmem(VertHist,sizeof(integer)*bitmap.Height);
	_CalcDensityHistogram(bitmap,0,0,bitmap.Width,bitmap.Height,nil,nil,VertHist,HorizHist,1000,1000);
   rv:=0;
	for i:=0 to bitmap.Height-2 do
		rv:=rv + sqr( VertHist[i+1]-VertHist[i] );
   freemem(VertHist);
   freemem(horizHist);
   result:=trunc(rv);
end;

function TImageEnProc.SkewDetectionFine(StartingAngle:double; resolution:double; range:integer; maxQuality:boolean):double;
var
	orgbmp,tmpbmp:TIEBitmap;
   bestfit,curfit,w,h:integer;
   bestangle:double;
   aa,r:double;
begin
	result:=StartingAngle;
   if not MakeConsistentBitmap([]) then
      exit;
   orgbmp:=TIEBitmap.Create;
   if not maxQuality then begin
      w:=imax(imin(fIEBitmap.Width div 8,fIEBitmap.Width),256);
      h:=trunc(fIEBitmap.Height/fIEBitmap.Width*w);
      orgbmp.Allocate(w,h,ie24RGB);
      if fIEBitmap.PixelFormat=ie1g then
	      _Resample1BitEx(fIEBitmap,orgbmp,rfFastLInear)
      else
      	_ResampleEx(fIEBitmap,orgbmp,rfFastLInear,nil,nil);
   end else
   	orgbmp.Assign(fIEBitmap);
   tmpbmp:=TIEBitmap.Create;
   r:=range / 2;
   // try left (including 0°)
   bestfit:=0;
   bestangle:=0;
   aa:=0;
   while abs(aa)<r do begin
   	tmpbmp.assign( orgbmp );
      _RotateEx(tmpbmp,StartingAngle+aa,false,CreateRGB(0,0,0),nil,nil);
		curfit:=_iECalcVertOrientationFitness(tmpbmp);
		if curfit>bestfit then begin
      	bestfit:=curfit;
         bestangle:=aa;
      end;
      aa:=aa-resolution;
   end;
   // try right
   aa:=resolution;
   while abs(aa)<r do begin
   	tmpbmp.assign( orgbmp );
      _RotateEx(tmpbmp,StartingAngle+aa,false,CreateRGB(0,0,0),nil,nil);
		curfit:=_iECalcVertOrientationFitness(tmpbmp);
		if curfit>bestfit then begin
      	bestfit:=curfit;
         bestangle:=aa;
      end;
      aa:=aa+resolution;
   end;
   result:=StartingAngle+bestangle;
   FreeAndNil(tmpbmp);
   FreeAndNil(orgbmp);
end;

procedure TImageEnProc.SetUndoLimit(v:integer);
begin
	fUndoLimit:=imax(1,v);
end;

procedure TImageEnProc.Sharpen(Intensity:integer;Neighbourhood:integer);
var
	ProcBitmap:TIEBitmap;
   mask:TIEMask;
   x1,y1,x2,y2:integer;
begin
	if not BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'Sharpen',ProcBitmap,mask) then
   	exit;
	_Sharpen(ProcBitmap,x1,y1,x2,y2, Intensity,Neighbourhood, fOnProgress, self);
   EndImageProcessing(ProcBitmap,mask);
end;


// Intensity from 1 to 100 (but allowed more than 100 values)
// Neighbourhood from 2, must be divisible by 2 (2,4,6,8,10...)
procedure _Sharpen(bitmap:TIEBitmap;fSelx1,fSely1,fSelx2,fSely2:integer; Intensity:integer; Neighbourhood:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
   per1:double;
	x,y:integer;
   nsize:integer;	// neighbourhood size / 2
   nr,ng,nb:integer;
   newbmp:TIEBitmap;
   ps,pd:PRGB;
   k:double;
   //
   procedure GetNeighbourhood;
   var
   	i,j:integer;
      px:PRGB;
      x1,x2,y1,y2:integer;
   begin
      nr:=0;
      ng:=0;
      nb:=0;
      x1:=imax(0,x-nsize);
      x2:=imin(bitmap.Width-1,x+nsize);
      y1:=imax(0,y-nsize);
      y2:=imin(bitmap.Height-1,y+nsize);
      for i:=y1 to y-1 do begin
         px:=bitmap.Scanline[i]; inc(px,x1);
         for j:=x1 to x-1 do begin
            with px^ do begin
               inc(nr,r);
               inc(ng,g);
               inc(nb,b);
            end;
            inc(px);
         end;
         for j:=x+1 to x2 do begin
            with px^ do begin
               inc(nr,r);
               inc(ng,g);
               inc(nb,b);
            end;
            inc(px);
         end;
      end;
      for i:=y+1 to y2 do begin
         px:=bitmap.Scanline[i]; inc(px,x1);
         for j:=x1 to x-1 do begin
            with px^ do begin
               inc(nr,r);
               inc(ng,g);
               inc(nb,b);
            end;
            inc(px);
         end;
         for j:=x+1 to x2 do begin
            with px^ do begin
               inc(nr,r);
               inc(ng,g);
               inc(nb,b);
            end;
            inc(px);
         end;
      end;
      i:=y2-y1;
      j:=i*(x2-x1);
      if j<>0 then begin
         nr:= nr div j;
         ng:= ng div j;
         nb:= nb div j;
      end;
   end;
   //
begin
	fSelX2:=imin(fSelX2,bitmap.Width); dec(fSelX2);
   fSelY2:=imin(fSelY2,bitmap.Height); dec(fSelY2);
   per1:=100/(fSelY2-fSelY1+0.5);
	nsize:= Neighbourhood div 2;
   k:= Intensity/10;
   newbmp:=TIEBitmap.Create;
   newbmp.Allocate(bitmap.width,bitmap.height,ie24rgb);
   for y:=fSelY1 to fSelY2 do begin
      ps:=bitmap.GetRow(y); inc(ps,fSelX1);
      pd:=newbmp.Scanline[y]; inc(pd,fSelX1);
      for x:=fSelX1 to fSelX2 do begin
         GetNeighbourhood;
         with ps^ do begin
            pd^.r := blimit(trunc(r+k*(r-nr)));
            pd^.g := blimit(trunc(g+k*(g-ng)));
            pd^.b := blimit(trunc(b+k*(b-nb)));
         end;
         inc(pd);
         inc(ps);
      end;
      bitmap.FreeRow(y);
      if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*(y-fSelY1+1)));
   end;
   bitmap.AssignImage(newbmp);
end;


initialization
   begin
   	MakeC1TO24;
   end;






end.
