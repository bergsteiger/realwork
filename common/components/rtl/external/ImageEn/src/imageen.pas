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

unit imageen;

{$R-}
{$Q-}

{$I ie.inc}

{$ifdef IEINCLUDETIMAGEEN}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Clipbrd, stdctrls, ImageEnView, ImageEnProc, ImageEnIO, hyiedefs, iefft, printers, hyieutils;


type

  TImageEn = class(TImageEnView)
  private
    procedure SetAutoUndo(v:boolean);
    function GetAutoUndo:boolean;
    function GetProcPreviewsParams:TPRPreviewsParams;
    procedure SetProcPreviewsParams(v:TPRPreviewsParams);
    function GetIOPreviewsParams:TIOPreviewsParams;
    procedure SetIOPreviewsParams(v:TIOPreviewsParams);
    function GetIOParams:TIOParamsVals;
    procedure SetPreviewFont(f:TFont);
    function GetPreviewFont:TFont;
    function GetMsgLanguage:TMsgLanguage;
    procedure SetMsgLanguage(v:TMsgLanguage);
    procedure SetStreamHeaders(v:boolean);
    function GetStreamHeaders:boolean;
    procedure SetAborting(v:boolean);
    function GetAborting:boolean;
    function GetCanUndo: boolean;
    {$ifdef IEINCLUDETWAIN}
    function GetTWainParams:TIETWainParams;
    {$endif}
    procedure SetOnPreview(v:TIEPreviewEvent);
    function GetOnPreview:TIEPreviewEvent;
    procedure SetOnIOPreview(v:TIEIOPreviewEvent);
    function GetOnIOPreview:TIEIOPreviewEvent;
    function GetDialogsMeasureUnit:TIEDialogsMeasureUnit;
    procedure SetDialogsMeasureUnit(v:TIEDialogsMeasureUnit);
    procedure SetUndoLocation(Value:TIELocation);
    function GetUndoLocation:TIELocation;
    procedure SetUndoLimit(Value:integer);
    function GetUndoLimit:integer;
    function GetUndoCount:integer;
     procedure SetUndoCaptions(index:integer; const Value:string);
     function GetUndoCaptions(index:integer):string;
  protected
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignIOParams(Source: TObject);
    // input/output
    procedure LoadFromStream(Stream:TStream);
    procedure LoadFromFileFormat(const nf:string; FileFormat:TIOFileType);
    procedure LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType);
    procedure SaveToStream(Stream:TStream; FileType:TIOFileType);
  	 procedure SaveToFileJpeg(const nf:string);
    procedure LoadFromFileJpeg(const nf:string);
    function LoadFromFileGif(const nf:string):integer;
    procedure SaveToFileGif(const nf:string);
    function InsertToFileGif(const nf:string):integer;
    procedure LoadFromFile(const nf:string); virtual;
    procedure SaveToFile(const nf:string); virtual;
    procedure SaveToStreamJpeg(Stream:TStream);
    procedure LoadFromStreamJpeg(Stream:TStream);
    function LoadFromStreamGif(Stream:TStream):integer;
    procedure SaveToStreamGif(Stream:TStream);
    procedure SaveToStreamPCX(Stream:TStream);
    procedure LoadFromStreamPCX(Stream:TStream);
    function LoadFromFileTIFF(const nf:string):integer;
    function LoadFromStreamTIFF(Stream:TStream):integer;
    procedure SaveToStreamBMP(Stream:TStream);
    procedure LoadFromStreamBMP(Stream:TStream);
    procedure SaveToFileBMP(const nf:string);
    procedure LoadFromFileBMP(const nf:string);
    procedure LoadFromFilePCX(const nf:string);
 	 procedure SaveToFilePCX(const nf:string);
    procedure SaveToStreamTIFF(Stream:TStream);
    procedure SaveToFileTIFF(const nf:string);
    procedure LoadFromFileICO(const nf:string);
    procedure LoadFromStreamICO(Stream:TStream);
    procedure LoadFromFileCUR(const nf:string);
    procedure LoadFromStreamCUR(Stream:TStream);
    {$ifdef IEINCLUDEPNG}
    procedure LoadFromFilePNG(const nf:string);
    procedure LoadFromStreamPNG(Stream:TStream);
    procedure SaveToFilePNG(const nf:string);
    procedure SaveToStreamPNG(Stream:TStream);
    {$endif}
    procedure ImportMetafile(const nf:string; Width,Height:integer; WithAlpha:boolean);
    function InsertToFileTIFF(const nf:string):integer;
    property IOParams:TIOParamsVals read GetIOParams;
    property Aborting:boolean read GetAborting write SetAborting;
    procedure ParamsFromFile(const nf:string); virtual;
    procedure ParamsFromStream(Stream:TStream); virtual;
    procedure ParamsFromFileFormat(const nf:string; format:TIOFileType); virtual;
    procedure ParamsFromStreamFormat(Stream:TStream; format:TIOFileType); virtual;
    procedure LoadFromFileTGA(const nf:string);
    procedure LoadFromStreamTGA(Stream:TStream);
    procedure SaveToFileTGA(const nf:string);
    procedure SaveToStreamTGA(Stream:TStream);
    {$ifdef IEINCLUDEOPENSAVEDIALOGS}
    function ExecuteOpenDialog(InitialDir:string; InitialFileName:string; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:string):string;
	 function ExecuteSaveDialog(InitialDir:string; InitialFileName:string; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:string):string;
    {$endif}
	 procedure LoadFromFilePXM(const nf:string);
    procedure LoadFromStreamPXM(Stream:TStream);
    procedure SaveToFilePXM(const nf:string);
    procedure SaveToStreamPXM(Stream:TStream);
    function InjectJpegIPTC(const nf:string):boolean;
    function InjectJpegIPTCStream(InputStream,OutputStream:TStream):boolean;
    procedure CaptureFromScreen(Source:TIECSSource; MouseCursor:TCursor);
    // TWAIN SCANNERS
    {$ifdef IEINCLUDETWAIN}
       {$ifdef IESUPPORTDEFPARAMS}
    function Acquire(api:TIEAcquireApi=ieaTWain):boolean;
    function SelectAcquireSource(api:TIEAcquireApi=ieaTWain):boolean;
       {$else}
    function Acquire(api:TIEAcquireApi):boolean;
    function SelectAcquireSource(api:TIEAcquireApi):boolean;
       {$endif}
    property TWainParams:TIETWainParams read GetTWainParams;
    {$endif}
    // Image processing
    procedure Negative;
    procedure HSLvar(oHue,oSat,oLum:integer);
    procedure HSVvar(oHue,oSat,oVal:integer);
    procedure IntensityRGBall(r,g,b:integer);
    procedure Contrast(vv:integer);
    procedure ApplyFilter(filter:TGraphFilter);
    procedure ApplyFilterPreset(filter:TIEFilterPresets);
    procedure ConvertToGray;
    procedure ConvertTo(NumColors:integer; DitherMethod:TIEDitherMethod);
    procedure CropSel;
    procedure CastColorRange(BeginColor,EndColor,CastColor:TRGB);
    procedure Rotate(fangle:double; antialias:boolean; AntialiasMode:TIEAntialiasMode; BackgroundColor:TColor);
    procedure Flip(dir:TFlipDir);
    procedure ImageResize(newWidth, newHeight:integer);
    procedure Resample(NewWidth,NewHeight:integer; FilterType:TResampleFilter);
    {$ifdef IEINCLUDEDIALOGIP}
    function DoPreviews(pe:TPreviewEffects):boolean;
    {$endif}
    {$ifdef IEINCLUDEDIALOGIO}
    function DoIOPreviews(pp:TPreviewParams):boolean;
    {$endif}
    procedure Clear;
    procedure ClearSel;
    procedure Merge(DBitmap:TBitmap; pcf:integer);
    procedure Threshold(DownLimit,UpLimit, DownVal,UpVal:TRGB);
	 procedure HistEqualize(LoThresh,HiThresh:TRGB);
    procedure HistAutoEqualize;
    procedure BumpMapping(LightX,LightY,LampX,LampY,pcf:integer; Color:TRGB);
    procedure Lens(cx,cy,Width,Height:integer; Refraction:double);
    procedure Wave(amplitude, wavelength, phase:integer; reflective:boolean);
    function WriteHiddenText(text:string):integer;
    function WriteHiddenData(data:PAnsiChar; count:integer):integer;
    procedure Maximum(WindowSize:integer);
    procedure Minimum(WindowSize:integer);
    procedure Opening(WindowSize:integer);
    procedure Closing(WindowSize:integer);
    procedure EdgeDetect_ShenCastan(Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean);
    // Image analysis
	 procedure GetHistogram(var Hist:THistogram);
    procedure CalcImagePalette(var Palette:array of TRGB; MaxCol:integer);
    function CalcImageNumColors:integer;
    function GetHSVChannel(ch:integer):TIEBitmap;
    procedure GetHSVChannelAll(BitmapH,BitmapS,BitmapV:TIEBitmap);
    function GetRGBChannel(ch:integer):TIEBitmap;
    procedure GetRGBChannelAll(BitmapR,BitmapG,BitmapB:TIEBitmap);
    procedure ConvertToBWOrdered;
    procedure ConvertToBWThreshold(Threshold:integer);
    procedure ConvertTo24Bit;
    function ReadHiddenText:string;
    function ReadHiddenData(data:PAnsiChar; maxlen:integer):integer;
    function GetHiddenDataSpace:integer;
    function FTCreateImage(ImageType:TIEFtImageType; NewWidth,NewHeight:integer):TIEFtImage;
    procedure FTConvertFrom(ft:TIEftImage);
    procedure FTDisplayFrom(ft:TIEftImage);
    // Undo
    {$ifdef IESUPPORTDEFPARAMS}
    procedure SaveUndo(Source:TIEUndoSource=ieuImage);
    procedure SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource=ieuImage);
    {$else}
    procedure SaveUndo(Source:TIEUndoSource);
    procedure SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource);
    {$endif}
    procedure ClearUndo;
    procedure Undo;
    procedure UndoAt(Position:integer);
    property CanUndo:boolean read GetCanUndo;
    property UndoLocation:TIELocation read GetUndoLocation write SetUndoLocation;
    property UndoLimit:integer read GetUndoLimit write SetUndoLimit;
    property UndoCount:integer read GetUndoCount;
    property UndoCaptions[index:integer]:string read GetUndoCaptions write SetUndoCaptions;
    // copy/cut/paste
 	 procedure SelCopyToClip;
    procedure CopyToClipboard;
	 procedure SelPasteFromClipStretch;
    procedure PasteFromClipboard;
    procedure PointPasteFromClip(x1,y1:integer);
    procedure SelCutToClip;
    // PRINTING
    procedure PrintImagePos(PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double);
    procedure PrintImage(PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
    procedure PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth,MaxBitmapHeight:integer; Printer:TPrinter; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
    {$ifdef IEINCLUDEPRINTDIALOGS}
	 function DoPrintPreviewDialog(DialogType:TIEDialogType; const TaskName:string):boolean;
    {$endif}
  published
    property AutoUndo:boolean read GetAutoUndo write SetAutoUndo default true;
    property MsgLanguage:TMsgLanguage read GetMsgLanguage write SetMsgLanguage default msSystem;
	 property ProcPreviewsParams:TPRPreviewsParams read GetProcPreviewsParams write SetProcPreviewsParams default [];
    property IOPreviewsParams:TIOPreviewsParams read GetIOPreviewsParams write SetIOPreviewsParams default [];
	 property PreviewFont:TFont read GetPreviewFont write SetPreviewFont;
    property StreamHeaders:boolean read GetStreamHeaders write SetStreamHeaders default false;
    property OnPreview:TIEPreviewEvent read GetOnPreview write SetOnPreview;
    property OnIOPreview:TIEIOPreviewEvent read GetOnIOPreview write SetOnIOPreview;
    property DialogsMeasureUnit:TIEDialogsMeasureUnit read GetDialogsMeasureUnit write SetDialogsMeasureUnit default ieduInches;
  end;

implementation

uses IEOpenSaveDlg;

{$R-}

/////////////////////////////////////////////////////////////////////////////////////
{$HINTS OFF}
constructor TImageEn.Create(Owner: TComponent);
var
	dummyio,dummyproc:TObject;
begin
	inherited Create(Owner);
   // this precreate embedded TImageEnIo and TImageEnProc. Without this Delphi hang up when put TImageEn on a form

   dummyio:=io;
   dummyproc:=proc;
end;
{$HINTS ON}

/////////////////////////////////////////////////////////////////////////////////////
destructor TImageEn.Destroy;
begin
   inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveUndo(Source:TIEUndoSource);
begin
	proc.SaveUndo(Source);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ClearUndo;
begin
	proc.ClearUndo;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Undo;
begin
	proc.Undo;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetAutoUndo(v:boolean);
begin
	proc.AutoUndo:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetAutoUndo:boolean;
begin
	result:=proc.AutoUndo;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Negative;
begin
	proc.Negative;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.HSLvar(oHue,oSat,oLum:integer);
begin
	proc.HSLvar(oHue,oSat,oLum);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.HSVvar(oHue,oSat,oVal:integer);
begin
	proc.HSVvar(oHue,oSat,oVal);
end;


/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.IntensityRGBall(r,g,b:integer);
begin
	proc.IntensityRGBall(r,g,b);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Contrast(vv:integer);
begin
	proc.Contrast(vv);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ApplyFilter(filter:TGraphFilter);
begin
	proc.ApplyFilter(filter);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ApplyFilterPreset(filter:TIEFilterPresets);
begin
	proc.ApplyFilterPreset(filter);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ConvertToGray;
begin
	proc.ConvertToGray;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.CastColorRange(BeginColor,EndColor,CastColor:TRGB);
begin
	proc.CastColorRange(BeginColor,EndColor,CastColor);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Rotate(fangle:double; antialias:boolean; AntialiasMode:TIEAntialiasMode; BackgroundColor:TColor);
begin
	proc.Rotate(fangle,antialias,AntialiasMode,BackgroundColor);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Flip(dir:TFlipDir);
begin
	proc.Flip(dir);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ImageResize(newWidth, newHeight:integer);
begin
	proc.ImageResize(newWidth,newHeight,iehLeft,ievTop);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Resample(NewWidth,NewHeight:integer; FilterType:TResampleFilter);
begin
	proc.Resample(NewWidth,NewHeight,FilterType);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEDIALOGIP}
function TImageEn.DoPreviews(pe:TPreviewEffects):boolean;
begin
	result:=proc.DoPreviews(pe);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEDIALOGIO}
function TImageEn.DoIOPreviews(pp:TPreviewParams):boolean;
begin
	result:=io.DoPreviews(pp);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Clear;
begin
	proc.Clear;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SelCopyToClip;
begin
	proc.SelCopyToClip;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.CopyToClipboard;
begin
	proc.CopyToClipboard;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SelPasteFromClipStretch;
begin
	proc.SelPasteFromClipStretch;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.PasteFromClipboard;
begin
	proc.PasteFromClipboard;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SelCutToClip;
begin
	proc.SelCutToClip;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFileJpeg(const nf:string);
begin
	io.SaveToFileJpeg(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileJpeg(const nf:string);
begin
	io.LoadFromFileJpeg(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.LoadFromFileGif(const nf:string):integer;
begin
	result:=io.LoadFromFileGif(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFileGif(const nf:string);
begin
	io.SaveToFileGif(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.InsertToFileGif(const nf:string):integer;
begin
	result:=io.InsertToFileGif(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFile(const nf:string);
begin
	io.LoadFromFile(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFile(const nf:string);
begin
	io.SaveToFile(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
// x1,y1 coordinate schermo
procedure TImageEn.PointPasteFromClip(x1,y1:integer);
begin
	proc.PointPasteFromClip( XScr2Bmp(x1),YScr2Bmp(y1));
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Merge(DBitmap:TBitmap; pcf:integer);
begin
	proc.Merge(DBitmap,pcf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Threshold(DownLimit,UpLimit, DownVal,UpVal:TRGB);
begin
	proc.Threshold(DownLimit,UpLimit,DownVal,UpVal);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.HistEqualize(LoThresh,HiThresh:TRGB);
begin
	proc.HistEqualize(LoThresh,HiThresh);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.HistAutoEqualize;
begin
	proc.HistAutoEqualize;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamJpeg(Stream:TStream);
begin
	io.SaveToStreamJpeg(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamJpeg(Stream:TStream);
begin
	io.LoadFromStreamJpeg(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.LoadFromStreamGif(Stream:TStream):integer;
begin
	result:=io.LoadFromStreamGif(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamGif(Stream:TStream);
begin
	io.SaveToStreamGif(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamPCX(Stream:TStream);
begin
	io.SaveToStreamPCX(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamPCX(Stream:TStream);
begin
	io.LoadFromStreamPCX(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDETWAIN}
function TImageEn.Acquire(api:TIEAcquireApi):boolean;
begin
   result:=io.Acquire(api);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDETWAIN}
function TImageEn.SelectAcquireSource(api:TIEAcquireApi):boolean;
begin
   result:=io.SelectAcquireSource(api);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.LoadFromFileTIFF(const nf:string):integer;
begin
	result:=io.LoadFromFileTIFF(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.LoadFromStreamTIFF(Stream:TStream):integer;
begin
	result:=io.LoadFromStreamTIFF(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamBMP(Stream:TStream);
begin
	io.SaveToStreamBMP(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamBMP(Stream:TStream);
begin
	io.LoadFromStreamBMP(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFileBMP(const nf:string);
begin
	io.SaveToFileBMP(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileBMP(const nf:string);
begin
	io.LoadFromFileBMP(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFilePCX(const nf:string);
begin
	io.LoadFromFilePCX(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFilePCX(const nf:string);
begin
	io.SaveToFilePCX(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileICO(const nf:string);
begin
	io.LoadFromFileICO(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamICO(Stream:TStream);
begin
	io.LoadFromStreamICO(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileCUR(const nf:string);
begin
	io.LoadFromFileCUR(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamCUR(Stream:TStream);
begin
	io.LoadFromStreamCUR(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamTIFF(Stream:TStream);
begin
	io.SaveToStreamTIFF(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFileTIFF(const nf:string);
begin
	io.SaveToFileTIFF(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetMsgLanguage:TMsgLanguage;
begin
	result:=proc.MsgLanguage;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetMsgLanguage(v:TMsgLanguage);
begin
	proc.MsgLanguage:=v;
   io.MsgLanguage:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetProcPreviewsParams:TPRPreviewsParams;
begin
	result:=proc.PreviewsParams;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetProcPreviewsParams(v:TPRPreviewsParams);
begin
	proc.PreviewsParams:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetIOPreviewsParams:TIOPreviewsParams;
begin
	result:=io.PreviewsParams;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetIOPreviewsParams(v:TIOPreviewsParams);
begin
	io.PreviewsParams:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetIOParams:TIOParamsVals;
begin
	result:=io.Params;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDETWAIN}
function TImageEn.GetTWainParams:TIETWainParams;
begin
	result:=io.TWainParams;
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetPreviewFont(f:TFont);
begin
	io.PreviewFont:=f;
   proc.PreviewFont:=f;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetPreviewFont:TFont;
begin
	result:=io.PreviewFont;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Assign(Source: TPersistent);
begin
	AssignIOParams(Source);
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Copia solo IOParams
procedure TImageEn.AssignIOParams(Source: TObject);
begin
	if Source is TImageEn then
		io.AssignParams((Source as TImageEn).IOParams)
   else if Source is TImageEnIO then
   	io.AssignParams((Source as TImageEnIO).Params);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetStreamHeaders(v:boolean);
begin
	io.StreamHeaders:=v;
end;


/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetStreamHeaders:boolean;
begin
	result:=io.StreamHeaders;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ClearSel;
begin
	proc.ClearSel;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ConvertTo(NumColors:integer; DitherMethod:TIEDitherMethod);
begin
	proc.ConvertTo(NumColors,DitherMethod);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.CropSel;
begin
	proc.CropSel;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.BumpMapping(LightX,LightY,LampX,LampY,pcf:integer; Color:TRGB);
begin
	proc.BumpMapping(LightX,LightY,LampX,LampY,pcf,Color);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.GetHistogram(var Hist:THistogram);
begin
	proc.GetHistogram(Hist);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.CalcImagePalette(var Palette:array of TRGB; MaxCol:integer);
begin
	proc.CalcImagePalette(Palette,MaxCol);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.CalcImageNumColors:integer;
begin
	result:=proc.CalciMageNumColors;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetHSVChannel(ch:integer):TIEBitmap;
begin
	result:=proc.GetHSVChannel(ch);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.GetHSVChannelAll(BitmapH,BitmapS,BitmapV:TIEBitmap);
begin
	proc.GetHSVChannelAll(BitmapH,BitmapS,BitmapV);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetRGBChannel(ch:integer):TIEBitmap;
begin
	result:=proc.GetRGBChannel(ch);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.GetRGBChannelAll(BitmapR,BitmapG,BitmapB:TIEBitmap);
begin
	proc.GetRGBChannelAll(BitmapR,BitmapG,BitmapB);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ConvertToBWOrdered;
begin
	proc.ConvertToBWOrdered;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ConvertToBWThreshold(Threshold:integer);
begin
	proc.ConvertToBWThreshold(Threshold);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ConvertTo24Bit;
begin
	proc.ConvertTo24Bit;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.InsertToFileTIFF(const nf:string):integer;
begin
	result:=io.InsertToFileTIFF(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Lens(cx,cy,Width,Height:integer; Refraction:double);
begin
	proc.Lens(cx,cy,Width,Height,Refraction);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Wave(amplitude, wavelength, phase:integer; reflective:boolean);
begin
	proc.Wave(amplitude,wavelength,phase,reflective);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEPNG}
procedure TImageEn.LoadFromFilePNG(const nf:string);
begin
	io.LoadFromFilePNG(nf);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////|
{$ifdef IEINCLUDEPNG}
procedure TImageEn.LoadFromStreamPNG(Stream:TStream);
begin
	io.LoadFromStreamPNG(Stream);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEPNG}
procedure TImageEn.SaveToFilePNG(const nf:string);
begin
	io.SaveToFilePNG(nf);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEPNG}
procedure TImageEn.SaveToStreamPNG(Stream:TStream);
begin
	io.SaveToStreamPNG(Stream);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.WriteHiddenText(text:string):integer;
begin
	result:=proc.WriteHiddenText(text);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.WriteHiddenData(data:PAnsiChar; count:integer):integer;
begin
	result:=proc.WriteHiddendata(data,count);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.ReadHiddenText:string;
begin
	result:=proc.ReadHiddenText;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.ReadHiddenData(data:PAnsiChar; maxlen:integer):integer;
begin
	result:=proc.ReadHiddenData(data,maxlen);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetHiddenDataSpace:integer;
begin
	result:=proc.GetHiddenDataSpace;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetAborting(v:boolean);
begin
	io.Aborting:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetAborting:boolean;
begin
	result:=io.Aborting;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetCanUndo: boolean;
begin
	result:=proc.CanUndo;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ImportMetafile(const nf:string; Width,Height:integer; WithAlpha:boolean);
begin
	io.ImportMetafile(nf,Width,Height,WithAlpha);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ParamsFromFile(const nf:string);
begin
	io.ParamsFromFile(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ParamsFromStream(Stream:TStream);
begin
	io.ParamsFromStream(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetOnPreview(v:TIEPreviewEvent);
begin
	proc.OnPreview:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetOnPreview:TIEPreviewEvent;
begin
	result:=proc.OnPreview;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SetOnIOPreview(v:TIEIOPreviewEvent);
begin
	io.OnIOPreview:=v;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.GetOnIOPreview:TIEIOPreviewEvent;
begin
	result:=io.OnIOPreview;
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.FTCreateImage(ImageType:TIEFtImageType; NewWidth,NewHeight:integer):TIEFtImage;
begin
	result:=proc.FTCreateImage(ImageType,NewWidth,NewHeight);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.FTConvertFrom(ft:TIEftImage);
begin
	proc.FTConvertFrom(ft);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.FTDisplayFrom(ft:TIEftImage);
begin
	proc.FTDisplayFrom(ft);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Maximum(WindowSize:integer);
begin
	proc.Maximum(WindowSize);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Minimum(WindowSize:integer);
begin
	proc.Minimum(WindowSize);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Opening(WindowSize:integer);
begin
	proc.Opening(WindowSize);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.Closing(WindowSize:integer);
begin
	proc.Closing(WindowSize);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStream(Stream:TStream);
begin
	io.LoadFromStream(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStream(Stream:TStream; FileType:TIOFileType);
begin
	io.SaveToStream(Stream, FileType);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileTGA(const nf:string);
begin
	io.LoadFromFileTGA(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamTGA(Stream:TStream);
begin
	io.LoadFromStreamTGA(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFileTGA(const nf:string);
begin
	io.SaveToFileTGA(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamTGA(Stream:TStream);
begin
	io.SaveToStreamTGA(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFileFormat(const nf:string; FileFormat:TIOFileType);
begin
	io.LoadFromFileFormat(nf,FileFormat);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType);
begin
	io.LoadFromStreamFormat(Stream,FileFormat);
end;

/////////////////////////////////////////////////////////////////////////////////////
// return '' for false
{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEn.ExecuteOpenDialog(InitialDir:string; InitialFileName:string; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:string):string;
begin
	result:=io.ExecuteOpenDialog(InitialDir,InitialFileName,AlwaysAnimate,FilterIndex,ExtendedFilters);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEn.ExecuteSaveDialog(InitialDir:string; InitialFileName:string; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:string):string;
begin
	result:=io.ExecuteSaveDialog(InitialDir,InitialFileName,AlwaysAnimate,FilterIndex,ExtendedFilters);
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ParamsFromFileFormat(const nf:string; format:TIOFileType);
begin
	io.ParamsFromFileFormat(nf,format);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.ParamsFromStreamFormat(Stream:TStream; format:TIOFileType);
begin
	io.ParamsFromStreamFormat(Stream,format);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromFilePXM(const nf:string);
begin
	io.LoadFromFilePXM(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.LoadFromStreamPXM(Stream:TStream);
begin
	io.LoadFromStreamPXM(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToFilePXM(const nf:string);
begin
	io.SaveToFilePXM(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.SaveToStreamPXM(Stream:TStream);
begin
	io.SaveToStreamPXM(Stream);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.PrintImagePos(PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double);
begin
	io.PrintImagePos(PrtCanvas,x,y,Width,Height,GammaCorrection);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.PrintImage(PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
begin
	io.PrintImage(PrtCanvas,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,Size,SpecWidth,SpecHeight,GammaCorrection);
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure TImageEn.PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth,MaxBitmapHeight:integer; Printer:TPrinter; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
begin
	io.PreviewPrintImage(DestBitmap,MaxBitmapWidth,MaxBitmapHeight,Printer,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,Size,SpecWidth,SpecHeight,GammaCorrection);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.InjectJpegIPTC(const nf:string):boolean;
begin
	result:=io.InjectJpegIPTC(nf);
end;

/////////////////////////////////////////////////////////////////////////////////////
function TImageEn.InjectJpegIPTCStream(InputStream,OutputStream:TStream):boolean;
begin
	result:=io.InjectJpegIPTCStream(InputStream,OutputStream);
end;

procedure TImageEn.CaptureFromScreen(Source:TIECSSource; MouseCursor:TCursor);
begin
	io.CaptureFromScreen(Source,MouseCursor);
end;

{$ifdef IEINCLUDEPRINTDIALOGS}
function TImageEn.DoPrintPreviewDialog(DialogType:TIEDialogType; const TaskName:string):boolean;
begin
	result:=io.DoPrintPreviewDialog(DialogType,TaskName);
end;
{$endif}

function TImageEn.GetDialogsMeasureUnit:TIEDialogsMeasureUnit;
begin
	result:=io.DialogsMeasureUnit;
end;

procedure TImageEn.SetDialogsMeasureUnit(v:TIEDialogsMeasureUnit);
begin
	io.DialogsMeasureUnit:=v;
end;

procedure TImageEn.EdgeDetect_ShenCastan(Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean);
begin
	proc.EdgeDetect_ShenCastan(Ratio,Smooth,WindowSize,ThinFactor,DoHysteresis);
end;

procedure TImageEn.SetUndoLocation(Value:TIELocation);
begin
	proc.UndoLocation:=Value;
end;

function TImageEn.GetUndoLocation:TIELocation;
begin
	result:=proc.UndoLocation;
end;

procedure TImageEn.SetUndoLimit(Value:integer);
begin
	proc.UndoLimit:=Value;
end;

function TImageEn.GetUndoLimit:integer;
begin
	result:=proc.UndoLimit;
end;

procedure TImageEn.UndoAt(Position:integer);
begin
	proc.UndoAt(Position);
end;

function TImageEn.GetUndoCount:integer;
begin
	result:=proc.UndoCount;
end;

procedure TImageEn.SetUndoCaptions(index:integer; const Value:string);
begin
	proc.UndoCaptions[index]:=Value;
end;

function TImageEn.GetUndoCaptions(index:integer):string;
begin
	result:=proc.UndoCaptions[index];
end;

procedure TImageEn.SaveUndoCaptioned(const Caption:string; Source:TIEUndoSource);
begin
	proc.SaveUndoCaptioned(Caption,Source);
end;


{$else} // IEINCLUDETIMAGEEN

interface
implementation

{$endif}

end.
