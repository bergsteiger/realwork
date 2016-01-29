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

unit hyiedefs;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses iekdef, Types, QGraphics;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, Messages, SysUtils,Graphics;
(*$endif*)


const
   // version details
   IEMAINVERSION='2.1.4';
   IEMAINDATEDD=08;
   IEMAINDATEMM=05;
   IEMAINDATEYY=2004;

   {$ifdef IEDELPHI}
	IEM_UPDATE=WM_USER+7000;	// message to TImageEnView for Update needs
   {$endif}

   // messages from TImageEnIO.DShowParams
   const IEM_NEWFRAME=WM_USER+1;
   const IEM_EVENT=WM_USER+2;


type

	// pointers
   {$ifndef CLR}
	PBitmapInfoHeader256=^TBitmapInfoHeader256;
   PPointArray=^TPointArray;
   PIEPointArray=^TIEPointArray;
   {$ifdef IEDELPHI}
   PPointerArray=^TPointerArray;
   {$endif}
   PDoubleArray=^TDoubleArray;
	PDWordArray=^TDWordArray;
   psinglearray=^tsinglearray;
   PRGBA=^TRGBA;
   PIERGBAPalette=^TIERGBAPalette;
   PRGB = ^TRGB;
   PIERGBPalette=^TIERGBPalette;
   PCMYK=^TCMYK;
   PIELAB=^TIELAB;
   PCMYKROW=^TCMYKROW;
   PRGBROW= ^RGBROW;
   PBYTEROW= ^TBYTEROW;
   PBYTEROWS= ^TBYTEROWS;
   pIntegerArray=^IntegerArray;
   PPRGBArray= ^PRGBArray;
   //PRGBROWS= ^TRGBROWS;
   //PArrayOfPByte=^TArrayOfPByte;
   pboolean=^boolean;
   PProgressRec = ^TProgressRec;
   PIEAnimPoly=^TIEAnimPoly;
   {$endif}	// not CLR

   // DRAWDIB TYPES
   hDrawDib = THandle;
	TDrawDibTime = record
   	timeCount: LongInt;       // see below
      timeDraw: LongInt;        // time to draw bitmaps
      timeDecompress: LongInt;  // time to decompress bitmaps
      timeDither: LongInt;      // time to dither bitmaps
      timeStretch: LongInt;     // time to stretch bitmaps
      timeBlt: LongInt;         // time to transfer bitmaps (BitBlt)
      timeSetDIBits: LongInt;   // time to transfer bitmaps (SetDIBits)
   end;

   // TBitmapInfoHeader + palette 256 colors
   TBitmapInfoHeader256 = packed record
      biSize: DWORD;
      biWidth: Longint;
      biHeight: Longint;
      biPlanes: Word;
      biBitCount: Word;
      biCompression: DWORD;
      biSizeImage: DWORD;
      biXPelsPerMeter: Longint;
      biYPelsPerMeter: Longint;
      biClrUsed: DWORD;
      biClrImportant: DWORD;
      Palette: array [0..1] of TRGBQUAD;
   end;

   {$ifdef IEKYLIX}
   TPointArray=array [0..Maxint div 16] of TPoint;
   {$endif}

   {$ifdef WIN32}
   TPointArray=array [0..Maxint div 16] of Windows.TPoint;
   {$endif}


   // Why this? Because C++Builder doesn't want TPointArray or PPointArray for variable declarations (not function members)
   TIEPoint = record
      X: Longint;      Y: Longint;   end;
   TIEPointArray=array [0..Maxint div 16] of TIEPoint;

   {$ifdef WIN32}
   TPointerArray=array [0..maxint div 16] of pointer;
   {$endif}
   {$ifdef IEKYLIX}
   TPointerArray=array [0..maxint div 16] of pointer;
   {$endif}

   TDoubleArray=array [0..maxint div 16] of double;

   TDWordArray=array [0..maxint div 16] of dword;

   tsinglearray=array [0..maxint div 16] of single;

   TRGBA = packed record
   	b:byte;
      g:byte;
      r:byte;
      a:byte;
   end;

   TIERGBAPalette=array [0..maxint div 16] of TRGBA;

   TRGB = packed record
      b:byte;
      g:byte;
      r:byte;
   end;

   TIERGBPalette=array [0..maxint div 16] of TRGB;

   TCMYK = packed record
      c:byte;
      m:byte;
      y:byte;
      k:byte;
   end;

   TIELAB = packed record
      l:byte;
      a:shortint;
      b:shortint;
   end;

   TCMYKROW=array [0..Maxint div 16] of TCMYK;

   T3dPoint = record
      x,y,z:double;
   end;

   // row of TRGB
   RGBROW= array [0..Maxint div 16] of TRGB;

   // row of bytes
   TBYTEROW= array [0..Maxint div 16] of byte;

   // array of byte rows
   TBYTEROWS= array [0..Maxint div 16] of PBYTEROW;

   // pointer to integer array
   IntegerArray=array [0..MaxInt div 16] of integer;

   // pointer tp array of pointers to TRGB (scanline rows)
   PRGBArray= array [0..Maxint div 16] of pRGB;

   // pointer to pointers array to PRGBROW
   //TRGBROWS= array [0..Maxint div 16] of PRGBROW;

   //TArrayOfPByte=array [0..Maxint div 16] of pbyte;

   // Notify progress (per=percentage)
   TIEProgressEvent = procedure(Sender: TObject; per:integer) of object;

   TIEJob=(iejNOTHING,				// no job / end of work
           iejGENERALPROCESSING,	// generic processing
           iejVIDEOCAP_CONNECTING // Video capture - connecting...
          );

   // notigy working in progress (per=percentage; job=the job)
   TIEJobEvent = procedure(Sender: TObject; job:TIEJob; per:integer) of object;

   // helper structure for OnProgress
   TProgressRec = record
      fOnProgress:TIEProgressEvent;
      Sender:TObject;
      val:integer;	// counter (per=trunc(per1*val))
      tot:integer;
      per1:double;	// (100/maxval)
      per2:double;
      Aborting:pboolean;
   end;

   {$ifndef IEHASINT64}
   // only for Delphi 3 and C++Builder 3
   int64=integer;
   pint64=^int64;
   tint64array=array [0..MaxInt div 8] of int64;
   pint64array=^tint64array;
   {$endif}

   // resample filters
   TResampleFilter=(rfNone, rfTriangle, rfHermite, rfBell, rfBSpline, rfLanczos3, rfMitchell,rfNearest,rfLinear,rfFastLinear,rfBilinear,rfBicubic);

   THYIEGraphicHeader = record
     	Count: Word;                { Fixed at 1 }
     	HType: Word;                { Fixed at $0100 }
     	Size: Longint;              { Size not including header }
   end;


   TMsgLanguage=(
                msSystem
                {$ifdef IESUPPORTENGLISH}
                ,msEnglish
                {$endif}
                {$ifdef IESUPPORTITALIAN}
                ,msItalian
                {$endif}
                {$ifdef IESUPPORTGERMAN}
                ,msGerman
                {$endif}
                {$ifdef IESUPPORTSPANISH}
                ,msSpanish
                {$endif}
                {$ifdef IESUPPORTFRENCH}
                ,msFrench
                {$endif}
                {$ifdef IESUPPORTPORTUGUESE}
                ,msPortuguese
                {$endif}
                {$ifdef IESUPPORTGREEK}
                ,msGreek
                {$endif}
                {$ifdef IESUPPORTRUSSIAN}
                ,msRussian
                {$endif}
                {$ifdef IESUPPORTDUTCH}
                ,msDutch
                {$endif}
                {$ifdef IESUPPORTSWEDISH}
                ,msSwedish
                {$endif}
                {$ifdef IESUPPORTPOLISH}
                ,msPolish
                {$endif}
                {$ifdef IESUPPORTUSER}
                ,msUser
                {$endif}
                );
   //TMsgLanguageR=msEnglish..msUser;
   TMsgLanguageWords=(IEMSG_PREVIEW, IEMSG_SOURCE, IEMSG_RESULT, IEMSG_OK, IEMSG_CANCEL,
       IEMSG_LOCKPREVIEW, IEMSG_COPYRESULTTOSOURCE, IEMSG_CONTRAST, IEMSG_BRIGHTNESS,
       IEMSG_HUE, IEMSG_SATURATION, IEMSG_VALUE, IEMSG_BASECOLOR, IEMSG_NEWCOLOR,
       IEMSG_LUMINOSITY, IEMSG_RED, IEMSG_GREEN, IEMSG_BLUE, IEMSG_FILTERVALUES, IEMSG_PRESETS,
       IEMSG_DIVISOR, IEMSG_LOAD, IEMSG_SAVE, IEMSG_EQUALIZATION, IEMSG_THRESHOLD, IEMSG_EQUALIZE,
       IEMSG_HISTOGRAM, IEMSG_GRAY, IEMSG_LIGHT, IEMSG_LEFT, IEMSG_TOP, IEMSG_WIDTH, IEMSG_HEIGHT,
       IEMSG_COLOR, IEMSG_SOURCEIMAGEQUANTITY, IEMSG_LENS, IEMSG_REFRACTION, IEMSG_PARAMETERSPREVIEW,
       IEMSG_QUALITY, IEMSG_DCTMETHOD, IEMSG_SMOOTHINGFACTOR, IEMSG_GRAYSCALE, IEMSG_OPTIMALHUFFMAN,
       IEMSG_ORIGINALSIZE, IEMSG_COMPRESSEDSIZE, IEMSG_ADVANCED, IEMSG_PROGRESSIVE, IEMSG_COMPRESSION,
       IEMSG_IMAGEINDEX, IEMSG_PHOTOMETRIC, IEMSG_SCANNDEDDOCUMENTINFO, IEMSG_NAME, IEMSG_DESCRIPTION,
       IEMSG_PAGENAME, IEMSG_PAGENUMBER, IEMSG_OF, IEMSG_HORIZPOSITIONINCH, IEMSG_VERTPOSITIONINCH,
       IEMSG_COLORS, IEMSG_TRANSPARENT, IEMSG_TRANSPARENTCOLOR,	IEMSG_INTERLACED,	IEMSG_BACKGROUND,
       IEMSG_HORIZPOSITION, IEMSG_VERTPOSITION, IEMSG_DELAYTIME, IEMSG_FILTER, IEMSG_WAVE,
       IEMSG_AMPLITUDE, IEMSG_WAVELENGTH, IEMSG_PHASE, IEMSG_REFLECTIVE, IEMSG_USERFILTER,
       IEMSG_MORPHFILTER, IEMSG_WINDOWSIZE, IEMSG_MAXIMUM, IEMSG_MINIMUM, IEMSG_OPEN,
       IEMSG_CLOSE, IEMSG_ROTATE, IEMSG_FLIP, IEMSG_FLIPHOR,	IEMSG_FLIPVER,
       IEMSG_FREQUENCYDOMAINIMAGE, IEMSG_SELECTTHEREGIONTOCLEAR, IEMSG_CLEAR,IEMSG_RESET,
       IEMSG_ANIMATE, IEMSG_LOADFILTER, IEMSG_SAVEFILTER, IEMSG_BUMPMAP, IEMSG_PRINT, IEMSG_MARGINS, IEMSG_INCHES,
       IEMSG_RIGHT, IEMSG_BOTTOM, IEMSG_POSITION, IEMSG_SIZE, IEMSG_NORMAL, IEMSG_FITTOPAGE, IEMSG_STRETCHTOPAGE,
       IEMSG_SPECIFIEDSIZE, IEMSG_GAMMACORRECTION, IEMSG_VALUE2, IEMSG_PRINTSETUP, IEMSG_LEFTMARGIN, IEMSG_TOPMARGIN,
       IEMSG_RIGHTMARGIN, IEMSG_BOTTOMMARGIN, IEMSG_LOCATIONSIZE, IEMSG_TOPLEFT, IEMSG_TOPCENTER, IEMSG_TOPRIGHT,
       IEMSG_CENTERLEFT, IEMSG_CENTER, IEMSG_CENTERRIGHT, IEMSG_BOTTOMLEFT, IEMSG_BOTTOMCENTER, IEMSG_BOTTOMRIGHT,
       IEMSG_CLOSE2, IEMSG_APPLY, IEMSG_MEASUREUNITS, IEMSG_UNITS, IEMSG_RATE,
       IEMSG_ALLGRAPHICS,IEMSG_VIDEOFORWINDOWS,IEMSG_FILE,IEMSG_MEM,IEMSG_LOCKPREVIEWHINT,
       IEMSG_PRINTALL,IEMSG_PRINTSELECTED
       );
   //TMsgLanguageWordsR=low(TMsgLanguageWords)..high(TMsgLanguageWords);

   // animated polygons item
   TIEAnimPoly=record
      Poly:PPointArray;	 // coordinate (rif. al componente)
      PolyCount:integer; // vertex count
      Color1:TColor;		 // Color 1
      Color2:TColor;		 // Color 2
      //
      Animated:boolean;	 // Animated
      AniFt:integer;		 // frame counter
      C1:integer;		 	 // DDA counter
      Canvas:TCanvas;	 // destination canvas
      RX1,RY1,RX2,RY2:integer; // bounds of the polygon
      Enabled:boolean;	// if True show the polygon
      Sizeable:boolean; // shows and use resizing grips
   end;

const
   IESELBREAK=$FFFFF;	// selection break code

	// YUV formats
	IEBI_IYU1=$31555949;
   IEBI_IYU2=$32555949;
	IEBI_UYVY=$59565955;
   IEBI_UYNV=$564E5955;
   IEBI_cyuv=$76757963;
   IEBI_YUY2=$32595559;
   IEBI_YUNV=$564E5559;
   IEBI_YVYU=$55595659;
   IEBI_Y41P=$50313459;
   IEBI_Y211=$31313259;
   IEBI_Y41T=$54313459;
   IEBI_Y42T=$54323459;
   IEBI_CLJR=$524A4C43;
   IEBI_YVU9=$39555659;
   IEBI_IF09=$39304649;
   IEBI_YV12=$32315659;
   IEBI_I420=$30323449;
   IEBI_IYUV=$56555949;
   IEBI_CLPL=$4C504C43;

var
   {$IfNDef Nemesis}
   ieMessages:array [TMsgLanguage] of array [TMsgLanguageWords] of string;
   {$EndIf  Nemesis}
	gAVIFILEinit:boolean;	// true if AVIFILE library has been initialized
   gThreadCS:TRTLCriticalSection;	// global critical section

{$ifdef DEMOVERSION}
procedure _ctrlview(canvas:TCanvas);
{$endif}


implementation

(*$ifdef IEKYLIX*)
   {$ifdef DEMOVERSION}
   {$I demo1.inc}
   {$endif}
(*$endif*)

(*$ifdef IEDELPHI*)
   {$ifdef DEMOVERSION}
   {$I demo1.inc}
   {$endif}
(*$endif*)

initialization
	begin
      InitializeCriticalSection(gThreadCS);
   end;

finalization
	begin
   	DeleteCriticalSection(gThreadCS);
   end;


end.
