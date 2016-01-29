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

(*

   Data container classes
		TIEByteArray
      TIEList
      TIEDoubleList
      TIEIntegerList
      TIERecordList

   Image container classes
   	TIEMask	( memory bitmap for selections and alpha channel )
      TIEVirtualDIBList ( DIB bitmap list )
      TIEDibBitmap inherited from TIEBaseBitmap	( DIB Bitmap )
      TIEWorkBitmap	( memory bitmap )
      TIEVirtualBitmap (memory mapped file bitmap, TILED)
      TIEBitmap inherited from TIEBaseBitmap (generic memory mapped file or memory bitmap, will replaces TBitmap)

   Hash classes:
   	THash1

   Dialog classes:
		TImageEnPaletteDialog

   Specific classes:
		TIEScrollBarParams
      TIEMouseWheelParams
		TIEHint

   JPEG/IPTC/EXIF
   	TIEMarkerList
      TIEIPTCInfoList

   Stream classes
   	TNulStream

*)

unit hyieutils;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses QTypes,iekdef, Types, QGraphics, Classes, hyiedefs, SysUtils, iewords, Graphics,
     l3Types, l3Base, l3BaseStream, l3RecList, l3Memory;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, Messages, Forms, Classes, StdCtrls, Graphics, Controls, SysUtils, hyiedefs
  {$IfNDef Nemesis}
  ,
  iewords
  {$EndIf  Nemesis}
  ,
  l3Types,
  l3Base,
  l3BaseStream,
  l3RecList,
  l3Memory,
  l3ProtoPersistent
  ;
(*$endif*)

type

   (*$ifdef IEDELPHI*)
	TIEDialogCenter = procedure(Wnd: HWnd);
   (*$endif*)

 EieImageReadError = class(Exception);
   
	TTIFFHeader = packed record
   	Id:word;
      Ver:word;
      PosIFD:integer;
   end;

   TTIFFTAG = packed record
   	IdTag:word;	// tag identified
      DataType:word;	// data type
      DataNum:integer; // data count
      DataPos:integer; // data position
   end;
   PTIFFTAG = ^TTIFFTAG;

   TIFD = array [0..MaxInt div 16] of TTIFFTag;
   PIFD = ^TIFD;

   TTIFFEnv = record
   	Intel:boolean; // true:Intel - false:Motorola
		Stream:TStream;
      IFD:PIFD;
      NumTags:word;
     	StreamBase:integer;
   end;

   // handles hash code for numeric values
   THash1Item=class(Tl3Base)
     public
      key:integer;
      nextitem:THash1Item;	// nil=end of list
      value:integer;
   end;
   
	THash1=class(Tl3Base)
   	private
      	fMainKeys:TList; // main key array
			fMainKeysUse:TList; // main key array - state [0=free; 1=busy; 2=more keys]
         fMainKeysValue:TList;	// array of values
         fHbits:integer;	// has table size in bits
         fHdim:integer;		// items count of fMainKeys and fMainKeyUse
         fIteratePtr1:integer;
         fIteratePtr2:THash1Item;
         function HashFunc(kk:integer):integer;
      public
      	nkeys:integer;	// inserted key count
      	constructor Create(Hbits:integer);
         reintroduce;
         procedure Cleanup; override;
         function Insert(kk:integer):boolean;
         function KeyPresent(kk:integer):boolean;
         function Insert2(kk:integer; var ptr1:integer; var ptr2:Thash1Item):boolean;
         procedure SetValue(ptr1:integer; ptr2:Thash1Item; Value:integer);
         function GetValue(ptr1:integer; ptr2:Thash1Item):integer;
         function IterateBegin:boolean;
         function IterateNext:boolean;
         function IterateGetValue:integer;
   end;

   (*$ifdef IEDELPHI*)
   // TImageEnPaletteDialog
   TImageEnPaletteDialog=class(TForm)
   	private
      	MouseCol:integer;
         fPalette:PRGBROW;
         fNumCol:integer;
         procedure FormPaint(Sender:TObject);
         procedure FormMouseMove(Sender:TObject; Shift:TShiftState;x,y:integer);
         procedure FormClick(Sender:TObject);
   	public
      	ButtonCancel:TButton;
         SelCol:TColor;
         property NumCol:integer read MouseCol;
      	constructor Create(AOwner: TComponent); override;
			procedure SetPalette(var Palette:array of TRGB; NumCol:integer);
         function Execute:boolean;
   end;
   (*$endif*)

   TIEScrollBarParams=class(Tl3Base)
   	private
      	fLineStep:integer; // click on up/down/left/right (-1=default size)
         fPageStep:integer; // page step (-1=default size)
         fTracking:boolean; // scroll-bar updates display in real-time (true=default)
      public
         constructor Create;
         reintroduce;
         procedure Cleanup; override;
         property LineStep:integer read fLineStep write fLineStep;
         property PageStep:integer read fPageStep write fPageStep;
         property Tracking:boolean read fTracking write fTracking;
   end;

   TIEMouseWheelParamsAction=(iemwNone, iemwVScroll, iemwZoom);
   TIEMouseWheelParamsVariation=(iemwAbsolute, iemwPercentage);
   TIEMouseWheelParamsZoomPosition=(iemwCenter,iemwMouse);

   TIEMouseWheelParams=class(Tl3Base)
      public
      	InvertDirection:boolean; // invert wheel direction
         Action:TIEMouseWheelParamsAction; // action
         Variation:TIEMouseWheelParamsVariation; // variation mode
         Value:integer; // value o percentage of variation
         ZoomPosition:TIEMouseWheelParamsZoomPosition;
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
	end;

   (*$ifdef IEDELPHI*)
   TIEHint=class(TCustomControl)
      private
         fText:AnsiString;
         fFont:TFont;
         procedure SetText(s:AnsiString);
         procedure SetFont(f:TFont);
      protected
			procedure CreateParams(var Params: TCreateParams); override;
		   procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
		   procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
      public
         constructor Create(Owner: TComponent); override;
         destructor Destroy; override;
         procedure Paint; override;
         property Text:AnsiString read fText write SetText;
         //property Color:TColor read fColor write SetColor;
         property Font:TFont read fFont write SetFont;
   end;
   (*$endif*)

   TIEByteArray=class(Tl3Base)
   	private
      	fSize:integer;		// size of datas
         fRSize:integer;	// size of allocated buffer
         fBlockSize:integer;	// allocation block size
         procedure SetSize(v:integer);
      public
      	Data:pbytearray;
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         procedure AddByte(v:byte);
         property Size:integer read fSize write SetSize;
         property BlockSize:integer read fBlockSize write fBlockSize;
         procedure Clear; virtual;
         function AppendFromStream(Stream:TStream; Count:integer):integer;
   end;

   TNulStream=class(Tl3Stream)
   private
   	fposition:integer;
      fsize:integer;
  	public
     constructor Create;
     reintroduce;
     procedure Cleanup; override;
     function Read(var Buffer; Count: Longint): Longint; override;
     function Write(const Buffer; Count: Longint): Longint; override;
     function Seek(Offset: Longint; Origin: Word): Longint; override;
   end;

   TIEListChanges=set of (ielItems, ielRange, ielCurrentValue);

   // abstract class for IE lists
   TIEList=class(Tl3Base)
   	private
      	fCount:integer;
   	protected
      	fItemSize:integer;	// sizeof(...)
         fData:pointer;
         fChanged:TIEListChanges;
         procedure SetCount(v:integer); virtual;
         function AddItem(v:pointer):integer;
         procedure InsertItem(idx:integer; v:pointer);
         function IndexOfItem(v:pointer):integer;
         function BaseGetItem(idx:integer):pointer;
         procedure BaseSetItem(idx:integer; v:pointer);
      public
      	constructor Create; reintroduce; virtual;
         procedure Cleanup; override;
	      procedure Delete(idx:integer); virtual;
         property Count:integer read fCount write SetCount;
         procedure Clear; virtual;
         procedure Assign(Source:TIEList); reintroduce; virtual;
         property WasChanged:TIEListChanges read fChanged write fChanged;
   end;

   // double list (with range)
   TIEDoubleList=class(TIEList)
   	private
         fRangeMin:double;
         fRangeMax:double;
         fRangeStep:double;
         fCurrentValue:double;
         function GetItem(idx:integer):double;
         procedure SetItem(idx:integer; v:double);
         procedure SetRangeMax(v:double);
         procedure SetRangeMin(v:double);
         procedure SetRangeStep(v:double);
         procedure SetCurrentValue(v:double);
      public
         function Add(v:double):integer;
         procedure Insert(idx:integer; v:double);
         procedure Clear; override;
         function IndexOf(v:double):integer;
			property RangeMin:double read fRangeMin write SetRangeMin;
         property RangeMax:double read fRangeMax write SetRangeMax;
         property RangeStep:double read fRangeStep write SetRangeStep;
         property Items[idx:integer]:double read GetItem write SetItem; default;
         procedure Assign(Source:TIEList); override;
         property CurrentValue:double read fCurrentValue write SetCurrentValue;
   end;

   TIEIntegerList=class(TIEList)
   	private
         fRangeMin:integer;
         fRangeMax:integer;
         fRangeStep:integer;
         fCurrentValue:integer;
         function GetItem(idx:integer):integer;
         procedure SetItem(idx:integer; v:integer);
         procedure SetRangeMax(v:integer);
         procedure SetRangeMin(v:integer);
         procedure SetRangeStep(v:integer);
         procedure SetCurrentValue(v:integer);
      public
         function Add(v:integer):integer;
         procedure Insert(idx:integer; v:integer);
         procedure Clear; override;
         function IndexOf(v:integer):integer;
			property RangeMin:integer read fRangeMin write SetRangeMin;
         property RangeMax:integer read fRangeMax write SetRangeMax;
         property RangeStep:integer read fRangeStep write SetRangeStep;
         property Items[idx:integer]:integer read GetItem write SetItem; default;
         procedure Assign(Source:TIEList); override;
         property CurrentValue:integer read fCurrentValue write SetCurrentValue;
   end;

   TIERecordList=class(TIEList)
   	private
         function GetItem(idx:integer):pointer;
         procedure SetItem(idx:integer; v:pointer);
      public
         function Add(v:pointer):integer;
         procedure Insert(idx:integer; v:pointer);
         function IndexOf(v:pointer):integer;
         property Items[idx:integer]:pointer read GetItem write SetItem; default;
         constructor CreateList(RecordSize:integer);
   end;

   TIEMarkerList=class(Tl3Base)
   	private
      	fData:TList;	// list of TMemoryStream
         fType:TList;	// list of byte
         function GetCount:integer;
         function GetMarkerData(idx:integer):PAnsiChar;
         function GetMarkerStream(idx:integer):TStream;
         function GetMarkerType(idx:integer):byte;
         function GetMarkerLength(idx:integer):word;
      public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         function AddMarker(marker:byte; data:PAnsiChar; datalen:word):integer;
         procedure SetMarker(idx:integer; marker:byte; data:PAnsiChar; datalen:word);
         procedure InsertMarker(idx:integer; data:PAnsiChar; marker:byte; datalen:word);
         procedure Clear; virtual;
         property MarkerData[idx:integer]:PAnsiChar read GetMarkerData;
         property MarkerStream[idx:integer]:TStream read GetMarkerStream;
         property MarkerLength[idx:integer]:word read GetMarkerLength;
         property MarkerType[idx:integer]:byte read GetMarkerType;
         function IndexOf(marker:byte):integer;
         procedure SaveToStream(Stream:TStream);
         procedure LoadFromStream(Stream:TStream);
	      procedure DeleteMarker(idx:integer);
         property Count:integer read GetCount;
         procedure Assign(Source:TIEMarkerList); reintroduce;
   end;

   TIPTCInfo=packed record
       fRecord:integer;
       fDataSet:integer;
       fLength:integer;
   end;
   PIPTCInfo=^TIPTCInfo;

   TIEIPTCInfoList=class(Tl3Base)
   	private
         fBuffer:TList;
         fInfo:TList;
         fUserChanged:boolean;
         function GetStrings(idx:integer):AnsiString;
         procedure SetStrings(idx:integer; Value:AnsiString);
         function GetRecordNumber(idx:integer):integer;
         procedure SetRecordNumber(idx:integer; Value:integer);
         function GetDataSet(idx:integer):integer;
         procedure SetDataSet(idx:integer; Value:integer);
         function GetCount:integer;
      public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         property StringItem[idx:integer]:AnsiString read GetStrings write SetStrings;
         property RecordNumber[idx:integer]:integer read GetRecordNumber write SetRecordNumber;
			property DataSet[idx:integer]:integer read GetDataSet write SetDataSet;
         function AddStringItem(RecordNumber:integer; DataSet:integer; Value:AnsiString):integer;
         function AddBufferItem(RecordNumber:integer; DataSet:integer; Buffer:pointer; BufferLength:integer):integer;
			procedure InsertStringItem(idx:integer; RecordNumber:integer; DataSet:integer; Value:AnsiString);
			procedure Clear; virtual;
         function IndexOf(RecordNumber:integer; DataSet:integer):integer;
         procedure DeleteItem(idx:integer);
         property Count:integer read GetCount;
         procedure Assign(Source:TIEIPTCInfoList); reintroduce;
         procedure SaveToStream(Stream:TStream);
         procedure LoadFromStream(Stream:TStream);
         procedure LoadFromStandardBuffer(Buffer:pointer; BufferLength:integer);
         procedure SaveToStandardBuffer(var Buffer:pointer; var BufferLength:integer; WriteHeader:boolean);
         property UserChanged:boolean read fUserChanged write fUserChanged;
	end;

   // annotation types
   const IEAnnotImageEmbedded=1;
   const IEAnnotImageReference=2;
   const IEAnnotStraightLine=3;
   const IEAnnotFreehandLine=4;
   const IEAnnotHollowRectangle=5;
   const IEAnnotFilledRectangle=6;
   const IEAnnotTypedText=7;
   const IEAnnotTextFromFile=8;
   const IEAnnotTextStamp=9;
   const IEAnnotAttachANote=10;
   const IEAnnotForm=12;
   const IEAnnotOCRRegion=13;

   const IEMAXCHANNELS = 4;

   type

   TIEBitmap=class;

   OIAN_MARK_ATTRIBUTES=record
      uType:integer;
      lrBounds:TRect;
      rgbColor1:TRGBQUAD;
      rgbColor2:TRGBQUAD;
      bHighlighting:longbool;
      bTransparent:longbool;
      uLineSize:dword;
      uReserved1:dword;
      uReserved2:dword;
      lfFont:TLOGFONTA;
      bReserved3:dword;
      Time:integer;
      bVisible:longbool;
      dwReserved4:dword;
      lReserved:array [0..9] of integer;
   end;

   TIEImagingObject=class(Tl3Base)
   	private
         attrib:OIAN_MARK_ATTRIBUTES;
		   points:PIEPointArray;
		   pointsLen:integer;
         text:PAnsiChar;
         image:TIEBitmap;
   	public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
   end;

   TIEImagingAnnot=class(Tl3Base)
   	private
      	fUserChanged:boolean;
         fObjects:TList;
         function GetObject(idx:integer):TIEImagingObject;
         function GetObjectsCount:integer;
   	public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         procedure LoadFromStandardBuffer(buffer:pointer; buflen:integer);
         procedure SaveToStandardBuffer(var Buffer:pointer; var BufferLength:integer);
         property UserChanged:boolean read fUserChanged write fUserChanged;
         procedure Clear; virtual;
         procedure Assign(Source:TIEImagingAnnot);reintroduce;
         procedure SaveToStream(Stream:TStream);
         procedure LoadFromStream(Stream:TStream);
         (*$ifdef IEDELPHI*)
         procedure CopyToTImageEnVect(Target:TObject);
         procedure CopyFromTImageEnVect(Target:TObject);
         procedure DrawToBitmap(target:TIEBitmap; Antialias:boolean);
         (*$endif*)
         property Objects[idx:integer]:TIEImagingObject read GetObject;
         property ObjectsCount:integer read GetObjectsCount;
   end;

   //TIEDibBitmap=class;		// removed for kylix

   TIEMask=class(Tl3Base)
   	private
         fWidth:integer;  			 // width of bit mask
         fHeight:integer; 			 // height of bit mask
         fBitsperpixel:integer; 	 // max 8 bits per pixel
         fRowlen:integer;			 // len in bytes of a row
         fBits:pbyte;		 		 // bit mask (0=not selected,  1=selected)
         fX1,fY1,fX2,fY2:integer; // bounding rect
			fBitmapInfoHeader1:TBitmapInfoHeader256;
         fTmpBmp:pbyte;	// used by DrawOutline
         fTmpBmpWidth,fTmpBmpHeight:integer;	// used by DrawOutline
         fTmpBmpScanline:ppointerarray; // used by DrawOutline
         fFull:boolean;		// true if all pixels are 1 or 255
	      function DrawHorizontalLine(Alpha:integer; xleft,xright,y:integer):integer;
         procedure DrawSinglePolygon(Alpha:integer; SelPoly:PPointArray; SelPolyCount:integer);
         function GetScanLine(Row:integer):pointer;
      protected
      public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         procedure SetPixel(x,y:integer; Alpha:integer);
         function GetPixel(x,y:integer):integer;
         procedure AllocateBits(width,height:integer; bitsperpixel:integer);
         procedure Resize(NewWidth,NewHeight:integer);
         procedure FreeBits;
			procedure CopyBitmap(Dest,Source:TBitmap; dstonlymask,srconlymask:boolean);
         procedure CopyIEBitmap(Dest,Source:TIEBitmap; dstonlymask,srconlymask:boolean; UseAlphaChannel:boolean);
         procedure CopyIEBitmapAlpha(Dest,Source:TIEBitmap; dstonlymask,srconlymask:boolean);
			procedure DrawPolygon(Alpha:integer; SelPoly:PPointArray; SelPolyCount:integer);
         //procedure DrawLine(Alpha:integer; x1,y1,x2,y2:integer);
         procedure Fill(Alpha:integer);
         procedure Empty;
         function IsPointInside(x,y:integer):boolean;
         procedure TranslateBitmap(var ox,oy:integer; CutSel:boolean);
         procedure InvertCanvas(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer);
         procedure DrawOuter(Dest:TBitmap; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer);
         procedure DrawOutline(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer; AniCounter:integer; Color1,Color2:TColor; Zoom:double);
			procedure Negative(MaxVal:integer);
         procedure SyncFull;	// set Full to True if all values are 255
         procedure SyncRect;	// set X1,Y1,X2,Y2
         //
         property Width:integer read fWidth;
         property Height:integer read fHeight;
         property BitsPerPixel:integer read fBitsPerPixel;
         property X1:integer read fX1 write fX1;
         property Y1:integer read fY1 write fY1;
         property X2:integer read fX2 write fX2;
         property Y2:integer read fY2 write fY2;
         function IsEmpty:boolean;
         property ScanLine[row:integer]:pointer read GetScanLine;
         procedure Assign(Source:TIEMask);reintroduce;
         property Rowlen:integer read fRowlen;
         property Bits:pbyte read fBits;
         property Full:boolean read fFull write fFull;
   end;

   TIEPixelFormat=(  ienull,
   						ie1g,		// gray scale (black/white)
                     ie8p,		// color (palette)
				         ie8g,		// gray scale (256 levels)
				         ie16g,	//	gray scale (65536 levels)
				         ie24RGB,	// color (true color)
                     ie32f		// float point values, 32 bit - Single in Pascal - gray scale
                     );

	TIEPixelFormatSet=set of TIEPixelFormat;

	TIEDataAccess=set of (iedRead,iedWrite);

   TIEBaseBitmap=class(Tl3ProtoPersistent)
      protected
      	fAccess:TIEDataAccess;
         function GetScanLine(Row:integer):pointer; virtual; abstract;
         function GetBitCount:integer; virtual; abstract;
         function GetHeight:integer; virtual; abstract;
         function GetWidth:integer; virtual; abstract;
         function GetPixelFormat:TIEPixelFormat; virtual; abstract;
         function GetRowLen:integer; virtual; abstract;
      public
         property Scanline[row:integer]:pointer read GetScanline;
         property BitCount:integer read GetBitCount;
         property Width:integer read GetWidth;
         property Height:integer read GetHeight;
         property PixelFormat:TIEPixelFormat read GetPixelFormat;
         procedure Allocate(ImageWidth,ImageHeight:integer; ImagePixelFormat:TIEPixelFormat); virtual; abstract;
         procedure Assign(Source:TObject); reintroduce; virtual; abstract;
         property RowLen:integer read GetRowLen;
         property Access:TIEDataAccess read fAccess write fAccess;
   end;

   (*
   // the memory mapped object
   TIEFileBuffer=class
      private
         fHTempFile:THandle;
         fHFileMap:THandle;
         fFileName:AnsiString;
         fMapped:TList;
      public
         constructor Create;
         destructor Destroy; override;
         function AllocateFile(FileName:AnsiString; SizeLo,SizeHi:dword):boolean;
         procedure ReAllocateFile(NewSizeLo,NewSizeHi:dword);
         function Map(OffsetHi, OffsetLo, Size:integer):pointer;
         procedure UnMap(ptr:pointer);
         procedure UnMapAll;
         function IsAllocated:boolean;
         procedure DeAllocate;
         procedure CopyTo(Dest:TIEFileBuffer; Offsethi,OffSetLo,Size:integer);
   end;
   //*)

   //(*

   TIEFileBufferItem=record
   	Pos:int64;		// buffer position inside the file
      Size:int64;		// buffer size
      ptr:pointer;	// allocated buffer
      access:TIEDataAccess;
   end;
   PIEFileBufferItem=^TIEFileBufferItem;

   TIEFileBuffer=class(Tl3Base)
      private
         fSimFile:TFileStream;
         fFileName:AnsiString;
         fMapped:Tl3RecList;	// list of TIEFileBufferItem structures
         function IndexOf(ptr:pointer):integer;
      public
         constructor Create;
         reintroduce;
         procedure Cleanup; override;
         function AllocateFile(FileName:AnsiString; InSize:int64):boolean;
         procedure ReAllocateFile(NewSize:int64);
         function Map(InPos,InSize:int64; DataAccess:TIEDataAccess):pointer;
         procedure UnMap(ptr: Pointer); overload;
         procedure UnMap(aIdx: Integer); overload;
         procedure UnMapAll;
         function IsAllocated:boolean;
         procedure DeAllocate;
         procedure CopyTo(Dest:TIEFileBuffer; InPos,InSize:int64);
   end;
   //*)

   (*$ifdef IEDELPHI*)
   TIEDibbitmap=class;
   (*$endif*)

   TIELocation=( ieMemory,	// use GetMem, no Canvas available (FOR FAST AND LITTLE IMAGES)
   				  ieFile,	// use Memory mapped file, no Canvas available (FOR BIG IMAGES)
                 ieTBitmap	// use TBitmap VCL object, Canvas available (FOR DRAWING)
                 );

	TIERenderOperation=(
   					     ielNormal,
   						  ielAdd,		// Additive
                       ielSub,		// Difference
                       ielDiv,
                       ielMul,
                       ielOR,
                       ielAND,
                       ielXOR,
                       ielMAX,      // Lighten
                       ielMIN,		// Darken
                       ielAverage,
                       ielScreen,
                       ielNegation,
                       ielExclusion,
                       ielOverlay,
                       ielHardLight,
                       ielSoftLight,
                       ielXFader,
                       ielColorEdge,
                       ielColorBurn,
                       ielInverseColorDodge,
                       ielInverseColorBurn,
                       ielSoftDodge,
                       ielSoftBurn,
                       ielReflect,
                       ielGlow,
                       ielFreeze,
                       ielEat,
                       ielSubtractive,
                       ielInterpolation,
                       ielStamp,
                       ielRed,
                       ielGreen,
                       ielBlue,
                       ielHue,
                       ielSaturation,
                       ielColor,
                       ielLuminosity,
                       ielGreyDown
                       );

   TIEDitherMethod=(ieOrdered,ieThreshold);

   TIEHAlign=(iehLeft, iehCenter, iehRight);
   TIEVAlign=(ievTop, ievCenter, ievBottom);

   TIEBitmap=class(TIEBaseBitmap)
   	private
         fmemmap:TIEFileBuffer;
      	fWidth,fHeight:integer;
         fBitCount:integer;
         fWorkingMap:pointer;	// last mapped memory buffer
         fRowLen:integer;
         fPixelFormat:TIEPixelFormat;
         fRGBPalette:PIERGBPalette;
         fRGBPaletteLen:integer;
         fAlphaChannel:TIEBitmap;
         fIsAlpha:boolean;	// if true this object is the alpha channel of another TIEBitmap object
         fMemory : Tl3Ptr;  // used only when fLocation=ieMemory
         fBitmap:TBitmap;	// used only when fLocation=ieTBitmap
         fBitmapScanlines:ppointerarray;  // used by scanline[] for TBitmap object
         fLocation:TIELocation;
			fFull:boolean;		// True if all bits are 1, Modified by SetPixels__, SetAlpha, Fill
         fEncapsulatedFromTBitmap:boolean; // True if fBitmap comes from an original TBitmap. Do not free it.
         fEncapsulatedFromMemory:boolean;	 // True if fMemory comes from an original memory. Do not free it.
         fMinFileSize:integer;	// if fRowLen*height < fMinFileSize Location will be ieMemory otherwise will be ieFile
         fScanlinesToUnMap:TList;   // list of scanlines to unmap, valid only for ieFile and using GetRow (and FreeRow)
         fDefaultDitherMethod:TIEDitherMethod;	// default method used to convert color image to black/white
         fPaletteUsed:integer;	// number of colors used of the palette
         // rendering options
         fBlackValue:double;	// pixels with value <= fBlackValue will be black (appliable only to ie8g,ie16g) - boths fBlackValue and fWhiteValue to zero disables them
         fWhiteValue:double;	// pixels with value >= fWhiteValue will be white (appliable only to ie8g,ie16g)
         fChannelOffset:array [0..IEMAXCHANNELS-1] of integer;
         fEnableChannelOffset:boolean;	// automatically set to true when one of fChannelOffset values is <>0
         fContrast:integer;
         fBitAlignment:integer;	// number of bits of alignment (32 bit is the default) - works only for ieMemory images
         //
         procedure SetWidth(Value:integer);
         procedure SetHeight(Value:integer);
         procedure AllocateImage;
         procedure SetPixelFormat(Value:TIEPixelFormat);
         procedure ConvertToPixelFormat(DestPixelFormat:TIEPixelFormat);
         function GetPalette(index:integer):TRGB;
         procedure SetPalette(index:integer; Value:TRGB);
         function GetPixels_ie1g(x,y:integer):boolean;
         function GetPixels_ie8(x,y:integer):byte;
         function GetPixels_ie16g(x,y:integer):word;
         function GetPixels_ie24RGB(x,y:integer):TRGB;
         function GetPixels_ie32f(x,y:integer):single;
         function GetPPixels_ie24RGB(x,y:integer):PRGB;
         function GetPixels(x,y:integer):TRGB;
         procedure SetPixels_ie1g(x,y:integer; Value:boolean);
         procedure SetPixels_ie8(x,y:integer; Value:byte);
         procedure SetPixels_ie16g(x,y:integer; Value:word);
         procedure SetPixels_ie24RGB(x,y:integer; Value:TRGB);
         procedure SetPixels_ie32f(x,y:integer; Value:single);
         function GetAlpha(x,y:integer):byte;
         procedure SetAlpha(x,y:integer; Value:byte);
         procedure SetLocation(Value:TIELocation);
         procedure UpdateTBitmapPalette;
         function GetHasAlphaChannel:boolean;
         procedure FreeBitmapScanlines;
         procedure BuildBitmapScanlines;
         function GetVclBitmap:TBitmap;
         procedure SetChannelOffset(idx:integer; value:integer);
         function GetChannelOffset(idx:integer):integer;
         procedure SetBitAlignment(value:integer);
      protected
         constructor CreateAsAlphaChannel(ImageWidth,ImageHeight:integer; ImageLocation:TIELocation);
         function GetCanvas:TCanvas;
         function GetAlphaChannel:TIEBitmap;
         function GetBitCount:integer; override;
         function GetWidth:integer; override;
         function GetHeight:integer; override;
         function GetRowLen:integer; override;
			function GetScanLine(Row:integer):pointer; override;
         function GetPixelFormat:TIEPixelFormat; override;
         procedure FreeAllMaps;
         procedure UpdateFromTBitmap;
         procedure Render_ie24RGB(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean; RenderOperation:TIERenderOperation); virtual;
			procedure Render_ie24RGB_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean; RenderOperation:TIERenderOperation); virtual;
         procedure Render_ie1g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
			procedure Render_ie1g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
         procedure Render_ie8g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
			procedure Render_ie8g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
         procedure Render_ie8p(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
			procedure Render_ie8p_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
         procedure Render_ie16g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
			procedure Render_ie16g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
         procedure Render_ie32f(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
			procedure Render_ie32f_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean); virtual;
      public
      	// methods and properties like TBitmap
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         property Width:integer read GetWidth write SetWidth;
         property Height:integer read GetHeight write SetHeight;
         property PixelFormat:TIEPixelFormat read GetPixelFormat write SetPixelFormat;
         procedure Assign(Source:TObject); override;	// for TIEBitmap and TBitmap
         procedure AssignImage(Source:TIEBitmap);	// assign without alpha channel
         property ScanLine[Row:integer]:pointer read GetScanLine;
         {$ifdef IEDELPHI}
         property Canvas:TCanvas read GetCanvas;
         {$endif}
         // extended methods and properties
         property EncapsulatedFromTBitmap:boolean read fEncapsulatedFromTBitmap write fEncapsulatedFromTBitmap;
         property EncapsulatedFromMemory:boolean read fEncapsulatedFromMemory write fEncapsulatedFromMemory;
         property Rowlen:integer read GetRowlen;
         procedure Allocate(ImageWidth,ImageHeight:integer; ImagePixelFormat:TIEPixelFormat); override;
         procedure EncapsulateTBitmap(obj:TBitmap; DoFreeImage:boolean);
         procedure EncapsulateMemory(mem:pointer; bmpWidth,bmpHeight:integer; bmpPixelFormat:TIEPixelFormat; DoFreeImage:boolean);
         procedure FreeImage;
         procedure SwitchTo(Target:TIEBitmap);
         property AlphaChannel:TIEBitmap read GetAlphaChannel;
         property Location:TIELocation read fLocation write SetLocation;	// default ieFile
         procedure CopyToTBitmap(Dest:TBitmap);
         procedure CopyFromTBitmap(Source:TBitmap);
         procedure CopyFromTIEMask(Source:TIEMask);
         procedure CopyToTIEMask(Dest:TIEMask);
         procedure CopyRectTo(Dest:TIEBitmap; SrcX,SrcY,DstX,DstY:integer; RectWidth,RectHeight:integer);
         function GetRow(Row:integer):pointer;
         procedure FreeRow(Row:integer);
         procedure Resize(NewWidth,NewHeight:integer; BackgroundValue:integer; AlphaValue:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
         property VclBitmap:TBitmap read GetVclBitmap;
         procedure MoveRegion(x1,y1,x2,y2,DstX,DstY:integer; BackgroundValue:integer);
         (*$ifdef IEDELPHI*)
         procedure CopyFromTDibBitmap(Source:TIEDibBitmap);
         procedure MergeFromTDibBitmap(Source:TIEDibBitmap; x,y:integer);
         procedure CopyToTDibBitmap(Dest:TIEDibBitmap; source_x, source_y, sourceWidth, sourceHeight:integer);
         (*$endif*)
         property Palette[index:integer]:TRGB read GetPalette write SetPalette;
         property PaletteLength:integer read fRGBPaletteLen;
         property Pixels_ie1g[x,y:integer]:boolean read GetPixels_ie1g write SetPixels_ie1g;
         property Pixels_ie8[x,y:integer]:byte read GetPixels_ie8 write SetPixels_ie8;
         property Pixels_ie16g[x,y:integer]:word read GetPixels_ie16g write SetPixels_ie16g;
         property Pixels_ie24RGB[x,y:integer]:TRGB read GetPixels_ie24RGB write SetPixels_ie24RGB;
         property Pixels_ie32f[x,y:integer]:single read GetPixels_ie32f write SetPixels_ie32f;
         property PPixels_ie24RGB[x,y:integer]:PRGB read GetPPixels_ie24RGB;
         property Pixels[x,y:integer]:TRGB read GetPixels;  // return always RGB (also with ie1g,ie8...)
         property Alpha[x,y:integer]:byte read GetAlpha write SetAlpha;
         procedure RenderToTBitmap(ABitmap:TBitmap; var ABitmapScanline:ppointerarray; var XLUT,YLUT:pinteger; UpdRect:PRect;
             xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer; EnableAlpha:boolean; SolidBackground:boolean;
             Transparency:integer; Filter:TResampleFilter; FreeTables:boolean; RenderOperation:TIERenderOperation); overload;
         procedure StretchRectTo(Dest:TIEBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer; Filter:TResampleFilter; Transparency:integer);
         procedure RenderToCanvas(DestCanvas:TCanvas; xDst,yDst,dxDst,dyDst:integer; Filter:TResampleFilter; Gamma:double);
         property Full:boolean read fFull write fFull;
         procedure SyncFull;	// set Full to True if all values are 255
         procedure Fill(Value:double);	// for ie1g, ie8, ie16g and ie24RGB (using TColor)
         procedure FillRect(x1,y1,x2,y2:integer; Value:double); // for ie1g, ie8, ie16g and ie24RGB (using TColor)
         property HasAlphaChannel:boolean read GetHasAlphaChannel;
         property BitCount:integer read GetBitCount;
         property MinFileSize:integer read fMinFileSize write fMinFileSize;
         procedure RemoveAlphaChannel;
         property DefaultDitherMethod:TIEDitherMethod read fDefaultDitherMethod write fDefaultDitherMethod;
         property BlackValue:double read fBlackValue write fBlackValue;
         property WhiteValue:double read fWhiteValue write fWhiteValue;
         property ChannelOffset[idx:integer]:integer read GetChannelOffset write SetChannelOffset;
         property Contrast:integer read fContrast write fContrast;
         procedure CreateAlphaChannel;
         function IsGrayScale:boolean;
         procedure RenderToTBitmap(ABitmap:TBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer;
             EnableAlpha:boolean; Filter:TResampleFilter; AlphaEnabled: Boolean = False; CommonAlpha: Byte = 255;
             RenderOperation:TIERenderOperation = ielNormal); overload;
         property PaletteUsed:integer read fPaletteUsed write fPaletteUsed;
         property BitAlignment:integer read fBitAlignment write SetBitAlignment;
   end;

   TIEGotBitmap=record
   	Left,Top:dword;
      Width,Height:integer;
      Bitmap:TBitmap;
      maps:TList;
   end;
   PIEGotBitmap=^TIEGotBitmap;

   //TIEVirtualBitmapFunction=procedure(x,y:dword; pixel:pointer; UserData:pointer);

   // actual implementation max size 4,294,967,295 x 4,294,967,295 pixels
   // The entire bitmap is built with TILEWIDTHxTILEHEIGHT indipendent tiles.
	// For example with 512x512 tile in a 24 bit bitmap, byte from 0 to 786431 contains
   // the top-left 512x512 rectangle, byte from 786432 to 1572863 contains the next right
   // or bottom rectangle.
   // Each tile is bottom-up bitmap.
   (*$ifdef IEDELPHI*)
   (*
   TIEVirtualBitmap=class
		private
         fWidth,fHeight:dword;
         fBitCount:dword;
         fTileWidth,fTileHeight:dword;
         fXTileCount,fYTileCount:dword;
         fTileRowLen:dword;
         fGotBitmaps:TList;
         fWorkingTileX,fWorkingTileY:dword;
         fWorkingMap:pointer;
         fTempBitmapInfoHeader256:TBitmapInfoHeader256;
         fmemmap:TIEFileBuffer;
         procedure SetWidth(v:dword);
         procedure SetHeight(v:dword);
         procedure SetBitCount(v:dword);
      protected
      public
      	constructor Create;
         destructor Destroy; override;
         // allocations
         procedure AllocateBits(Width,Height:dword; BitCount:dword);
         procedure FreeBits;
         // properties
         property ImageWidth:dword read fWidth write SetWidth;
         property ImageHeight:dword read fHeight write Setheight;
			property BitCount:dword read fBitCount write SetBitCount;
         // bitmap import/export
         function GetBitmap(Left,Top,Width,Height:dword):TBitmap;
         procedure ReleaseBitmap(bitmap:TBitmap);
         procedure CopyFromIEBitmap(bitmap:TIEBitmap; xdst,ydst,dxdst,dydst:dword);
         // rendering
			procedure RenderTo(Canvas:TCanvas; xDst,yDst,dxDst,dyDst:dword; xSrc,ySrc,dxSrc,dySrc:dword; SubSampleFilter:boolean);
         // direct access
         procedure GetPixel(x,y:dword; var Value);
         procedure SetPixel(x,y:dword; const Value);
         procedure ApplyFunction(Left,Top,Width,Height:dword; func:TIEVirtualBitmapFunction; UserData:pointer);
   end;
   *)
   (*$endif*)

   TIEVirtualImageInfo=record
   	pos:int64;
      size:int64;
      vsize:int64;
      ptr:pointer;	// pointer to a memory buffer. it is <>nil if view mapped
      bitmapped:boolean;	// true if this image is in the fBmpToRelease list
      orig_width:integer;	// assigned by class user (info for original image when here is stored a thumbnail)
      orig_height:integer; // assigned by class user (info for original image when here is stored a thumbnail)
      HasAlphaChannel:boolean;
      currentaccess:TIEDataAccess;
   end;
   PIEVirtualImageInfo=^TIEVirtualImageInfo;

   TIEVirtualToReleaseBmp=record
   	info:PIEVirtualImageInfo;
      bmp:TIEBitmap;
      refcount:integer;
   end;
	PIEVirtualToReleaseBmp=^TIEVirtualToReleaseBmp;

   TIEVirtualFreeBlock=record
   	pos:int64;
      vsize:dword;	// size of the free block
   end;
   PIEVirtualFreeBlock=^TIEVirtualFreeBlock;

   // each DIB cannot be large than normal system DIB
   (*$ifdef IEDELPHI*)
   TIEVirtualDIBList=class(Tl3Base)
		private
         fmemmap:TIEFileBuffer;
         fSize:int64;	// allocated size
         fImageCount:integer;
         fImageInfo:TList;
         fToDiscardList:TList;	// list of the image to unmap (the first is the next to discard)
         fFreeBlocks:TList; // list of free blocks in the file
         fInsPos:int64;	// next free space
         fAllocationBlock:dword;
         fMaxImagesInMemory:integer;
         fImagesInMemory:integer;
         fBmpToRelease:TList;		// list of to release bitmaps (TBItmap) objects, list of TIEVirtualToReleaseBmp
         fLastVImageSize:dword;
         fTempBitmapInfoHeader256:TBitmapInfoHeader256;
         function GetImageCount:integer;
			function BmpToReleaseIndexOf(image:pointer):integer;
      protected
      	procedure ReAllocateBits;
         procedure FreeBits;
         procedure RemoveImageInfo(idx:integer);
         procedure DiscardImage(info:PIEVirtualImageInfo);
         procedure DiscardOne;
         procedure DiscardAll;
         procedure MapImage(image:pointer; access:TIEDataAccess);
         function AllocImage(image:pointer; Width,Height,Bitcount:integer; HasAlpha:boolean):boolean;
         procedure DirectCopyToBitmap(image:pointer; bitmap:TIEBitmap);
      public
      	constructor Create;
        reintroduce;
         procedure Cleanup; override;
         procedure PrepareSpaceFor(Width,Height:integer; Bitcount:integer; ImageCount:integer);
         function AddBlankImage(Width,Height,Bitcount:integer; HasAlpha:boolean):pointer;
         // bitmaps import/export
         function AddBitmap(bitmap:TBitmap):pointer;
         function AddIEBitmap(bitmap:TIEBaseBitmap):pointer;
         function AddBitmapRect(bitmap:TBitmap; xsrc,ysrc,dxsrc,dysrc:integer):pointer;
         procedure CopyToIEBitmap(image:pointer; bitmap:TIEBitmap);
         //procedure CopyFromBitmap(image:pointer; bitmap:TBitmap);
         procedure CopyFromIEBitmap(image:pointer; bitmap:TIEBitmap);
         function GetBitmap(image:pointer):TIEBitmap;
         procedure ReleaseBitmap(bitmap:TIEBitmap; changed:boolean);
         procedure ReleaseBitmapByImage(image:pointer; changed:boolean);
         // rendering
         //procedure RenderTo(image:pointer; Canvas:TCanvas; hdd:THandle; xDst,yDst,dxDst,dyDst:dword; xSrc,ySrc,dxSrc,dySrc:dword);
			//
         property MaxImagesInMemory:integer read fMaxImagesInMemory write fMaxImagesInMemory;
         property ImageCount:integer read GetImageCount;
         procedure Delete(image:pointer);
         // image info
         function GetImageWidth(image:pointer):integer;
         function GetImageHeight(image:pointer):integer;
         function GetImageOriginalWidth(image:pointer):integer;
         function GetImageOriginalHeight(image:pointer):integer;
         procedure SetImageOriginalWidth(image:pointer; Value:integer);
         procedure SetImageOriginalHeight(image:pointer; Value:integer);
         function GetImageBitCount(image:pointer):integer;
         function GetImageBits(image:pointer):pointer;
         function GetAlphaBits(image:pointer):pointer;
         function GetImageInfoHeader(image:pointer):PBitmapInfoHeader256;
   end;
   (*$endif*)

   // a DIB section (used for little image processing and transfers tasks)
   // BitCount supportted:
   //		1 : black/white images
   //    24: true color images
   (*$ifdef IEDELPHI*)
   TIEDibBitmap=class(TIEBaseBitmap)
   	private
      	fWidth,fHeight:dword;
         fBitCount:dword;
         fRowLen:dword;
         fHDC:THandle;
         fDIB:THandle;
         fBitmapInfoHeader1:TBitmapInfoHeader256;
         fBits:pointer;
      protected
	      function GetBitCount:integer; override;
         function GetWidth:integer; override;
         function GetHeight:integer; override;
         function GetPixelFormat:TIEPixelFormat; override;
         function GetRowLen:integer; override;
         function GetScanline(row:integer):pointer; override;
      public
	   	constructor Create;
                reintroduce;
	      procedure Cleanup; override;
         procedure AllocateBits(BmpWidth,BmpHeight,BmpBitCount:dword);
         procedure Allocate(ImageWidth,ImageHeight:integer; ImagePixelFormat:TIEPixelFormat); override;
         procedure FreeBits;
         property HDC:THandle read fHDC;
         property DIB:Thandle read fDIB;
         property Width:dword read fWidth;
         property Height:dword read fHeight;
         property BitCount:dword read fBitCount;
         property Scanline[row:integer]:pointer read GetScanline;
         property Bits:pointer read fBits;
         property Rowlen:integer read GetRowlen;
         procedure CopyToTBitmap(Dest:TBitmap);
         procedure Assign(Source:TObject); override;
   end;
   (*$endif*)

   // a bitmap in memory that doesn't use system handles
   // BitCount supported:
   //		1	: black/white
   //		8  : gray (no palette)
   //   24  : true color
   //   32  : true color + alpha (or 32 bit float point)
   //   64  : double (64 bit float point)
   TIEWorkBitmap=class(Tl3Base)
   	private
      	fWidth,fHeight:integer;
         fBitCount:integer;
         fRowLen:integer;
         fBits:pointer;
         function GetScanline(row:integer):pointer;
      public
         constructor Create(BmpWidth,BmpHeight,BmpBitCount:integer);
         reintroduce;
	      procedure Cleanup; override;
         procedure AllocateBits(BmpWidth,BmpHeight,BmpBitCount:integer);
         procedure FreeBits;
         property Width:integer read fWidth;
         property Height:integer read fHeight;
         property BitCount:integer read fBitCount;
         property Scanline[row:integer]:pointer read GetScanline;
         property Bits:pointer read fBits;
         property Rowlen:integer read fRowlen;
         function GetPByte(row,col:integer):pbyte;
         function GetPRGB(row,col:integer):PRGB;
         function GetPDouble(row,col:integer):PDouble;
         function GetPSingle(row,col:integer):PSingle;
         function GetPInteger(row,col:integer):pinteger;
         procedure SetBit(row,col:integer; value:integer);
   end;

   TIETifTagsReader=class(Tl3Base)
      private
         fFileStream:TStream;
         fStream:TStream;
         fTIFFEnv:TTIFFEnv;
         fNumi:integer;
      public
         constructor CreateFromFile(const FileName:AnsiString; ImageIndex:integer);
         constructor CreateFromStream(Stream:TStream; ImageIndex:integer);
         constructor CreateFromIFD( tagReader:TIETifTagsReader; IFDTag:integer );
         procedure Cleanup; override;
         property ImageCount:integer read fNumi;
         function TagExists(Tag:integer):boolean;
         function TagLength(Tag:integer):integer;
         function GetInteger(Tag:integer):integer;
         function GetIntegerIndexed(Tag:integer; index:integer):integer;
         function GetRational(Tag:integer):double;
         function GetRationalIndexed(Tag:integer; index:integer):double;
         function GetIntegerArray(Tag:integer; var ar:pintegerarray):integer;
         function GetRawData(Tag:integer):pointer;
         function GetString(Tag:integer):AnsiString;
         function GetMiniString(Tag:integer):AnsiString;
   end;

   TIEGraphicBase=class(TGraphic)
      private
         fio:TObject;	// TImageEnIO
			bmp:TIEBitmap;
         fFiletype:integer;
      protected
         procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
         function GetEmpty: Boolean;  override;
         function GetHeight: Integer;  override;
         function GetWidth: Integer;  override;
         procedure SetHeight(Value: Integer);  override;
         procedure SetWidth(Value: Integer);  override;
         procedure WriteData(Stream: TStream); override;
         procedure ReadData(Stream: TStream); override;
      public
         constructor Create;  override;
         destructor Destroy; override;
         procedure LoadFromStream(Stream: TStream);  override;
         procedure SaveToStream(Stream: TStream);  override;
			{$ifdef IEDELPHI}
         procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);  override;
         procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);  override;
         {$endif}
         {$ifdef IEKYLIX}
	      procedure LoadFromMimeSource(MimeSource: TMimeSource); override;
    		procedure SaveToMimeSource(MimeSource: TClxMimeSource); override;
			{$endif}
         procedure Assign(Source: TPersistent); override;
         property IO:TObject read fio;
   end;

   // a memorystream that doesn't create the memory space (and doesn't free it)
   TIEMemStream=class(TCustomMemoryStream)
   	public
   		constructor Create(Ptr:pointer; Size:integer);
	    	procedure SetSize(NewSize: Longint); override;
    		function Write(const Buffer; Count: Longint): Longint; override;
   end;

   TIETiffImage=class(TIEGraphicBase)
   end;
   TIEGifImage=class(TIEGraphicBase)
   end;
   TIEJpegImage=class(TIEGraphicBase)
   end;
   TIEPCXImage=class(TIEGraphicBase)
   end;
   TIEBMPImage=class(TIEGraphicBase)
   end;
   TIEICOImage=class(TIEGraphicBase)
   end;
   {$ifdef IEINCLUDEPNG}
   TIEPNGImage=class(TIEGraphicBase)
   end;
   {$endif}
   TIETGAImage=class(TIEGraphicBase)
   end;
   TIEPXMImage=class(TIEGraphicBase)
   end;
   {$ifdef IEINCLUDEJPEG2000}
   TIEJP2Image=class(TIEGraphicBase)
   end;
   TIEJ2KImage=class(TIEGraphicBase)
   end;
   {$endif}

	TIEShadowType= (iestNone, iestSolid, iestSmooth1, iestSmooth2);

   TIEMultiCallBack = procedure(Bitmap:TIEBitmap; var IOParams:TObject) of object;

   //////////////////////////////////////////////////////////////////////////////
   // PDF support
   // base class for all objects( direct and indirect )

   // for indirect object:
   // 	ObjectNumber is not included because it always starts at 1
   // 	GenerationNumber is not included because it is always 0
   TIEPDFObject=class(Tl3Base)
     public
      Index:integer;
      Position:integer; // position inside the start of stream (wrote when we save the objects to the stream)
      DontFree:boolean;	// if True the parent doesn't free this object
      constructor Create;
      reintroduce;
      procedure Cleanup; override;
      procedure Write(Stream:TStream); virtual; abstract;
   end;

   // object reference
   TIEPDFRefObject=class(TIEPDFObject)
     public
      ObjectNumber:integer;
      GenerationNumber:integer;
      constructor Create(ObjNumber:integer; GenNumber:integer);
      procedure Write(Stream:TStream); override;
   end;

   // boolean object
   TIEPDFBooleanObject=class(TIEPDFObject)
    public
      Value:boolean;
      constructor Create(vv:boolean);
      procedure Write(Stream:TStream); override;
   end;

   // numeric object
   TIEPDFNumericObject=class(TIEPDFObject)
     public
      Value:double;
      constructor Create(vv:double);
      procedure Write(Stream:TStream); override;
   end;

   // AnsiString object
   TIEPDFStringObject=class(TIEPDFObject)
     public
      Value:AnsiString;
      constructor Create(vv:AnsiString);
      procedure Write(Stream:TStream); override;
   end;

   // name object
   TIEPDFNameObject=class(TIEPDFObject)
     public
      Value:AnsiString;
      constructor Create(vv:AnsiString);	// do not specify '\'
      procedure Write(Stream:TStream); override;
   end;

   // array object
   TIEPDFArrayObject=class(TIEPDFObject)
     public
      Items:TList;
      constructor Create;
      procedure Cleanup; override;
      procedure Write(Stream:TStream); override;
   end;

   // dictionary object
   TIEPDFDictionaryObject=class(TIEPDFObject)
     public
      items:TStringList;	// Items[] for key (without '/') and Objects[] for values
      constructor Create;
      procedure Cleanup; override;
      procedure Write(Stream:TStream); override;
   end;

   // stream object
   TIEPDFStreamObject=class(TIEPDFObject)
     public
      data:pointer;
      length:integer;
      dict:TIEPDFDictionaryObject;
      constructor Create;
      constructor CreateCopy(copydata:pointer; copylength:integer);
      procedure Cleanup; override;
      procedure Write(Stream:TStream); override;
   end;


   procedure iepdf_WriteHeader(Stream:TStream);
   procedure iepdf_WriteFooter(Stream:TStream; IndirectObjects:TList; info:TIEPDFObject);
   procedure iepdf_WriteIndirectObjects(Stream:TStream; IndirectObjects:TList);
   procedure iepdf_AddCatalog(IndirectObjects:TList);
   procedure iepdf_AddPageTree(IndirectObjects:TList; pages:TList);
   procedure iepdf_AddPage(IndirectObjects:TList; pages:TList; Resources:TIEPDFDictionaryObject; MediaBox:TIEPDFArrayObject; Content:integer);
   procedure iepdf_AddIndirectObject(IndirectObjects:TList; obj:TIEPDFObject);
   procedure iepdf_WriteLn(Stream:TStream; line:AnsiString);
   procedure iepdf_Write(Stream:TStream; line:AnsiString);

	// End of PDF support
	//////////////////////////////////////////////////////////////////////////////


   //////////////////////////////////////////////////////////////////////////////
   // functions
   function _GetBitCount(b: Integer): Integer;
   function _NColToBitsPixel(NCol:integer):integer;
   function IEBitmapRowLen(Width:integer; BitCount:integer; align:integer):integer;
   function _PixelFormat2RowLen(Width:integer; PixelFormat:TPixelFormat):integer;
	function _Pixelformat2BitCount(PixelFormat:TPixelFormat):integer;
   function _Bitcount2Pixelformat(Bitcount:integer):TPixelFormat;
   procedure ReverseBits(var inp: dword); assembler
   procedure ReverseBitsB(var inp:byte);
   procedure _CastPolySelCC(const x1,y1:integer; var x2,y2:integer);
   function _RectXRect(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2:integer):boolean;
	function _RectPRect(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2:integer):integer;
   function _InRect(xx,yy,x1,y1,x2,y2:integer):boolean;
   function _InRectO(xx,yy,x1,y1,x2,y2:integer):boolean;
   function _getfilesize(const nf:AnsiString):integer;
   procedure SaveStringToStream(Stream:TStream; const ss:AnsiString);
   procedure LoadStringFromStream(Stream:TStream; var ss:AnsiString);
   procedure SaveStringListToStream(Stream:TStream; sl:TStringList);
   procedure LoadStringListFromStream(Stream:TStream; sl:TStringList);
   function _GetNumCol(BitsPerSample:integer; SamplesPerPixel:integer):integer;
   function iemsg(const msg:TMsgLanguageWords; const lang:TMsgLanguage):AnsiString;
   procedure IESetTranslationWord(const lang:TMsgLanguage; const msg:TMsgLanguageWords; const trans:AnsiString);
	function IEFloor(X: Extended): Integer;
	function _DistPoint2Line(xp,yp,x1,y1,x2,y2:integer):double;
	function _DistPoint2Seg(xp,yp,x1,y1,x2,y2:integer):double;
   function _DistPoint2Point(x1,y1,x2,y2:integer):double;
   function _DistPoint2Polyline(x,y:integer; PolyPoints:PPointArray; PolyPointsCount:integer; ToSubX, ToSubY, ToAddX, ToAddY:integer; ToMulX,ToMulY:double):double;
   function IEMMXSupported:bytebool;
   procedure IEMul64(op1,op2:dword; resultlo:pdword; resulthi:pdword);
   function IEAdd64(op1_lo,op1_hi,op2_lo,op2_hi:dword; result_lo,result_hi:pdword):integer;
   function IEGreater64(op1_lo,op1_hi,op2_lo,op2_hi:dword):boolean;
   procedure SafeStreamWrite(Stream:TStream; var Aborting:boolean; const Buffer; Count:Longint);
   procedure IEBitmapMapXCopy(map:pbyte; maprowlen:dword; mapbitcount:dword; bitmap:TBitmap; mapx,mapy,bitmapx,bitmapy,dx,dy:dword; dir:integer);
   function IEPower(Base, Exponent: Extended): Extended;
	function IESwapWord(i:word):word;
	function IESwapDWord(i:integer):integer;
	procedure IERightShadow(Canvas:TCanvas; x1,y1,x2,y2:integer; st:TIEShadowType);
   procedure IEBottomShadow(Canvas:TCanvas; x1,y1,x2,y2:integer; st:TIEShadowType);
   (*$ifdef IEDELPHI*)
   function IEIs_Win2000_ME_XP:boolean;
   function IEIs_XP:boolean;
   function IEIs_98:boolean;
   function IEFindHandle(cmp:TComponent):integer;
   procedure DrawDibDrawEmu(hdd: THandle; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt);
	procedure DrawDib(hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer);
   function IEDrawDibClose(hdd: hDrawDib): Boolean;
   function IEDrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean;
   function IEDrawDibOpen: hDrawDib;
   function IEDrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt;
	procedure IECenterWindow(Wnd: HWnd);
   procedure IEResetPrinter;
   (*$endif*)
   //procedure IEStretchBmpWithAlpha(SrcBitmap,DstBitmap:TBitmap; Alpha:TIEMask; xs1,ys1,xs2,ys2,xd1,yd1,xd2,yd2:integer; opt:boolean);
   //procedure IEStretchBmp(SrcBitmap,DstBitmap:TBitmap; xs1,ys1,xs2,ys2,xd1,yd1,xd2,yd2:integer; opt:boolean);
   function IEStrToFloatDef(s:AnsiString; Def:extended):extended;
   function IERGB2CIELAB(rgb:TRGB):TIELAB;
   function IECIELAB2RGB(const lab:TIELAB):TRGB;
   procedure IEDraw3DRect(Canvas:TCanvas; x1,y1,x2,y2:integer; cl1,cl2:TColor);
   procedure IEDrawHint(Canvas:TCanvas; var x,y:integer; const ss:AnsiString; Font:TFont; Brush:TBrush; var SaveBitmap:TBitmap; MaxWidth,MaxHeight:integer; Border1,Border2:TColor);
	function IEDirectoryExists(const Name: AnsiString): Boolean;
   procedure IEForceDirectories(Dir: AnsiString);
   function IEGetFreeMemory:integer;
   procedure IESetplim(var plim:trect; x,y:integer);
   function IEAngle(x1,y1,x2,y2,x3,y3:integer):double;
   function IEArcCos(X: Extended): Extended;
   function IEExtractStylesFromLogFont(logfont:PLogFont):TFontStyles;
   function IEConvertGUIDToString(g:PGUID):AnsiString;
   procedure IEConvertStringToGUID(invar:AnsiString; gg:PGUID);
   procedure IEFitResample(owidth,oheight,fwidth,fheight:integer; var rwidth,rheight:integer);

   function IEASCII85EncodeBlock(var inbytes:pbyte; buflen:integer; var outstr:PAnsiChar; var asciilen:integer):integer;
   function IEASCII85DecodeBlock(var instr:PAnsiChar; buflen:integer; var outbytes:pbyte):integer;
   function IEPSRunLengthEncode(inbytes:pbytearray; inlen:integer; outbytes:pbytearray):integer;
   procedure IEWriteStrLn(s:TStream; ss:AnsiString);

   procedure IEBlend(var src:TRGB; var dst:TRGB; RenderOperation:TIERenderOperation);

   // EXIF SUPPORT FUNCTIONS
   function LoadEXIFFromStandardBuffer(Buffer:pointer; BufferLength:integer; params:TObject):boolean;
   procedure SaveEXIFToStandardBuffer(params:TObject; var Buffer:pointer; var BufferLength:integer);

   procedure IERegisterFormats;
   procedure IEUnregisterFormats;

	const	iebitmask1:array [0..7] of byte=($80, $40, $20, $10, $08, $04, $02, $01);	// $80 shr index

var
	(*$ifdef IEDELPHI*)
	IEDefDialogCenter:TIEDialogCenter;
	(*$endif*)
   IEDefMinFileSize:integer;


implementation

(*$ifdef IEKYLIX*)
uses imageenview, imageenproc, imageenio, ieview, tiffilt, neurquant, ievect,QPrinters
  l3Bits;
(*$endif*)
(*$ifdef IEDELPHI*)
uses ImageEnView, ImageEnProc, ImageEnIO, ieview, neurquant,Tiffilt, ievect,printers,
  l3Bits;
(*$endif*)

{$R-}

// DRAWDIB LIBRARY
const
  DLL = 'MsVfW32.dll';
function DrawDibClose(hdd: hDrawDib): Boolean; stdcall; external DLL name 'DrawDibClose';
function DrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean; stdcall; external DLL name 'DrawDibDraw';
function DrawDibOpen: hDrawDib; stdcall; external DLL name 'DrawDibOpen';
function DrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt; stdcall; external DLL name 'DrawDibRealize';

const A90=PI/2;

var
	IECosineTab:array [0..255] of integer;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// THash1
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// sbits: hash table size in bit.
constructor THash1.Create(Hbits:integer);
begin
	inherited Create;
	fHbits:=Hbits;
   fHdim:=1 shl fHbits;
   fMainKeys:=TList.Create;
   fMainKeys.Count:=fHdim;
   fMainKeysUse:=TList.Create;
   fMainKeysUse.Count:=fHdim;
   fMainKeysValue:=TList.Create;
   fMainKeysValue.Count:=fHdim;
   nkeys:=0;
end;

procedure THash1.Cleanup;
var
	q:integer;
   p1,p2:THash1Item;
begin
	for q:=0 to fHdim-1 do
   	case integer(fMainKeysUse[q]) of
      	2: // free concurrences
         	begin
					p1:=Thash1Item(fMainKeys[q]);
		         repeat
			         p2:=p1.nextitem;
                  FreeAndNil(p1);
		            p1:=p2;	// free next item
		         until p1=nil;
		      end;
      end;
	FreeAndNil(fMainKeys);
   FreeAndNil(fMainKeysUse);
   FreeAndNil(fMainKeysValue);
   inherited;
end;

// hash function
// uses first fHbits-1 as direct index
function THash1.HashFunc(kk:integer):integer;
begin
	result:= kk and (fHdim-1);
end;

// insert a new key (kk) only if it already present
// ret TRUE if key inserted
function THash1.Insert2(kk:integer; var ptr1:integer; var ptr2:Thash1Item):boolean;
var
	ix:integer;
   p1,p2:THash1Item;
begin
   ptr2:=nil;
	result:=false;
	ix:=HashFunc(kk);
   ptr1:=ix;
   case integer(fMainKeysUse[ix]) of
	  	0:	// free position
      	begin
		   	fMainKeysUse[ix]:=TObject(1);
		      fMainKeys[ix]:=TObject(kk);
         end;
      1: // position busy, verify if this already exists
      	begin
         	if integer(fMainKeys[ix])=kk then
            	exit;	// key already inserted
            // create a list of keys
            p1:=THash1Item.Create;
            p1.key:=kk;
            p1.nextitem:=nil;
            ptr2:=p1;
            //
            p2:=THash1Item.Create;
            p2.key:=integer(fMainKeys[ix]);
            p2.nextitem:=p1;
            p2.value:=integer(fMainKeysValue[ix]);
            //
            fMainKeys[ix]:=p2;
  				fMainKeysUse[ix]:=TObject(2);
            // from here fMainKeyValue[ix] is no longer valid
         end;
      2: // position busy, with more one key, verify also if already present
      	begin
         	// search for last key or if already present
            p1:=Thash1Item(fMainKeys[ix]);
            while true do begin
            	if p1.key=kk then
               	exit;	// key already inserted
               if p1.nextitem=nil then
               	break;	// found last item
               p1:=p1.nextitem;
            end;
            // now p1 point to the last item, create a new one
            p2:=THash1Item.Create;
            p2.key:=kk;
            p2.nextitem:=nil;
            ptr2:=p2;
            p1.nextitem:=p2;	// append item just created
         end;
   end;
   inc(nkeys);
   result:=true;
end;

// insert a new key (kk) only if it already present
// ret TRUE if key inserted
function THash1.Insert(kk:integer):boolean;
var
   ptr1:integer;
   ptr2:Thash1Item;
begin
   result:=Insert2(kk,ptr1,ptr2);
end;

// verify if key kk exists
function THash1.KeyPresent(kk:integer):boolean;
var
	ix:integer;
   p1:THash1Item;
begin
	result:=false;
	ix:=HashFunc(kk);
   case integer(fMainKeysUse[ix]) of
      1: // position busy, check if it exists
      	begin
         	if integer(fMainKeys[ix])=kk then
            	result:=true;
         end;
      2: // position busy, with more than one ket, check if it exists
      	begin
         	// find last key or if it already exists
            p1:=Thash1Item(fMainKeys[ix]);
            while true do begin
            	if p1.key=kk then begin
               	result:=true;	// actual key
                  break;
               end;
               if p1.nextitem=nil then
               	break;	// find last item
               p1:=p1.nextitem;
            end;
         end;
   end;
end;

procedure THash1.SetValue(ptr1:integer; ptr2:Thash1Item; Value:integer);
begin
	if ptr2<>nil then
   	ptr2.value:=Value
   else
   	fMainKeysValue[ptr1]:=TObject(Value);
end;

function THash1.GetValue(ptr1:integer; ptr2:Thash1Item):integer;
begin
	if ptr2<>nil then
   	result:=ptr2.Value
   else
   	result:=integer(fMainKeysValue[ptr1]);
end;

function THash1.IterateBegin:boolean;
begin
	fIterateptr1:=-1;
   fIterateptr2:=nil;
   result:=IterateNext;
end;

function THash1.IterateNext:boolean;
begin
	result:=false;
	if fIterateptr2=nil then begin
   	inc(fIterateptr1);
      while fIterateptr1<fHdim do begin
      	case integer(fMainKeysUse[fIterateptr1]) of
         	1:
            	begin
               	result:=true;
                  exit;
               end;
            2:
            	begin
                  fIterateptr2:=THash1Item(fMainKeys[fIterateptr1]);
                  result:=true;
                  exit;
               end;
			end;
         inc(fIterateptr1);
      end;
   end else begin
   	fIterateptr2:=fIterateptr2.nextitem;
      if fIterateptr2=nil then
      	result:=IterateNext
      else
      	result:=true;
   end;
end;

function THash1.IterateGetValue:integer;
begin
	if fIterateptr2<>nil then
   	result:=fIterateptr2.Value
   else
   	result:=integer(fMainKeysValue[fIterateptr1]);
end;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

function IEDirectoryExists(const Name: AnsiString): Boolean;
(*$ifdef IEDELPHI*)
var
	Code: Integer;
begin
	Code := GetFileAttributesA(PAnsiChar(Name));
	Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;
(*$else*)
begin
	result:=DirectoryExists(Name);
end;
(*$endif*)

procedure IEForceDirectories(Dir: AnsiString);
begin
	if Length(Dir) = 0 then
		raise Exception.Create('Cannot Create Directory');
	if (AnsiLastChar(Dir) <> nil) and (AnsiLastChar(Dir)^ = '\') then
   	Delete(Dir, Length(Dir), 1);
  	if (Length(Dir) < 3) or IEDirectoryExists(Dir) or (ExtractFilePath(Dir) = Dir) then Exit;
  	IEForceDirectories(ExtractFilePath(Dir));
  	CreateDir(Dir);
end;

// count consecutive bits
// ex  000111110000  return 5
function _GetBitCount(b: Integer): Integer;
(*var
    i: Integer;*)
begin
 Result := l3BitCountF(B);
(*    i := 0;
    while (i<31) and (((1 shl i) and b)=0) do Inc(i);
    Result := 0;
    while ((1 shl i) and b)<>0 do begin
      Inc(i);
      Inc(Result);
    end;*)
end;

// Converte numero colori a bits per pixel necessari (arr. in eccesso)
function _NColToBitsPixel(NCol:integer):integer;
var
	q:integer;
begin
	result:=-1;
	for q:=0 to 31 do
		if (NCol and (1 shl q))<>0 then begin
      	if result<>-1 then result:=q+1 else result:=q;
      end;
end;

// return line length in bytes
// align is the number of bits of alignment. Allowed multiple of 8 bits (8,16,24,32,48...)
function IEBitmapRowLen(Width:integer; BitCount:integer; align:integer):integer;
begin
	case align of
   	32:
      	// formula optimized for 32
			result:=(((Width*BitCount)+31) shr 5) shl 2;	// (((Width*BitCount)+31) div 32) * 4
      else
      	// generic formula
      	result:=(((Width*BitCount)+(align-1)) div align) * (align div 8);
   end;
end;

// Converts Pixelformat of TBitmap to BitCount
function _Pixelformat2BitCount(PixelFormat:TPixelFormat):integer;
(*$ifdef IEDELPHI*)
const
	conv:array [pfDevice..pfCustom] of integer=(0,1,4,8,15,16,24,32,0);
begin
	case PixelFormat of
      pf1bit: result:=1;
      pf4bit: result:=4;
      pf8bit: result:=8;
      pf15bit: result:=15;
      pf16bit: result:=16;
      pf24bit: result:=24;
      pf32bit: result:=32;
   	else
      	result:=0;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
const
	conv:array [pf1bit..pfCustom] of integer=(1,8,16,32,0);
begin
	case PixelFormat of
      pf1bit: result:=1;
      pf8bit: result:=8;
      pf16bit: result:=16;
      pf32bit: result:=32;
   	else
      	result:=0;
   end;
end;
(*$endif*)

// Get rowlen from PixelFormat
function _PixelFormat2RowLen(Width:integer; PixelFormat:TPixelFormat):integer;
begin
	result:=IEBitmapRowLen(Width,_Pixelformat2BitCount(PixelFormat),32);
end;

// converts BitCount to PixelFormat (of TBitmap)
function _Bitcount2Pixelformat(Bitcount:integer):TPixelFormat;
(*$ifdef IEDELPHI*)
begin
	case BitCount of
   	1: result:=pf1bit;
      4: result:=pf4bit;
      8: result:=pf8bit;
      15:result:=pf15bit;
      16:result:=pf16bit;
      24:result:=pf24bit;
      32:result:=pf32bit;
      else result:=pfCustom;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
	case BitCount of
   	1: result:=pf1bit;
      8: result:=pf8bit;
      16:result:=pf16bit;
      32:result:=pf32bit;
      else result:=pfCustom;
   end;
end;
(*$endif*)

// reverse byte bits
procedure ReverseBitsB(var inp:byte);
const
	invtab:array [0..255] of byte=($00,$80,$40,$C0,$20,$A0,$60,$E0,$10,$90,$50,$D0,$30,$B0,
   		$70,$F0,$08,$88,$48,$C8,$28,$A8,$68,$E8,$18,$98,$58,$D8,$38,$B8,$78,$F8,$04,$84,
         $44,$C4,$24,$A4,$64,$E4,$14,$94,$54,$D4,$34,$B4,$74,$F4,$0C,$8C,$4C,$CC,$2C,$AC,
         $6C,$EC,$1C,$9C,$5C,$DC,$3C,$BC,$7C,$FC,$02,$82,$42,$C2,$22,$A2,$62,$E2,$12,$92,
         $52,$D2,$32,$B2,$72,$F2,$0A,$8A,$4A,$CA,$2A,$AA,$6A,$EA,$1A,$9A,$5A,$DA,$3A,$BA,
         $7A,$FA,$06,$86,$46,$C6,$26,$A6,$66,$E6,$16,$96,$56,$D6,$36,$B6,$76,$F6,$0E,$8E,
         $4E,$CE,$2E,$AE,$6E,$EE,$1E,$9E,$5E,$DE,$3E,$BE,$7E,$FE,$01,$81,$41,$C1,$21,$A1,
         $61,$E1,$11,$91,$51,$D1,$31,$B1,$71,$F1,$09,$89,$49,$C9,$29,$A9,$69,$E9,$19,$99,
         $59,$D9,$39,$B9,$79,$F9,$05,$85,$45,$C5,$25,$A5,$65,$E5,$15,$95,$55,$D5,$35,$B5,
         $75,$F5,$0D,$8D,$4D,$CD,$2D,$AD,$6D,$ED,$1D,$9D,$5D,$DD,$3D,$BD,$7D,$FD,$03,$83,
         $43,$C3,$23,$A3,$63,$E3,$13,$93,$53,$D3,$33,$B3,$73,$F3,$0B,$8B,$4B,$CB,$2B,$AB,
         $6B,$EB,$1B,$9B,$5B,$DB,$3B,$BB,$7B,$FB,$07,$87,$47,$C7,$27,$A7,$67,$E7,$17,$97,
         $57,$D7,$37,$B7,$77,$F7,$0F,$8F,$4F,$CF,$2F,$AF,$6F,$EF,$1F,$9F,$5F,$DF,$3F,$BF,
         $7F,$FF);
begin
	inp:=invtab[inp];
end;

procedure ReverseBits(var inp: dword); assembler;
asm
      push esi
      push ebx
      mov  esi, eax
      mov  eax, DWord Ptr [esi]
      BSWAP   EAX
      MOV     EDX, EAX
      AND     EAX, 0AAAAAAAAh
      SHR     EAX, 1
      AND     EDX, 055555555h
      SHL     EDX, 1
      OR      EAX, EDX
      MOV     EDX, EAX
      AND     EAX, 0CCCCCCCCh
      SHR     EAX, 2
      AND     EDX, 033333333h
      SHL     EDX, 2
      OR      EAX, EDX
      MOV     EDX, EAX
      AND     EAX, 0F0F0F0F0h
      SHR     EAX, 4
      AND     EDX, 00F0F0F0Fh
      SHL     EDX, 4
      OR      EAX, EDX
      mov DWord Ptr [esi], eax
      pop    ebx
      pop    esi
end;

// reverse dword bits
(*
procedure ReverseBits(var inp: dword); assembler;
asm
      push esi
      push ebx
      mov  esi, eax
      mov  ebx, DWord Ptr [esi]
      sub   eax, eax
      mov   ecx, 32
      sub   edx, edx
   @1:
      shl   eax, 1
(.* without this comment delphi6 doesn't compile!!!! *.)
      shr   ebx, 1
      adc   eax, edx
      loop @1
      mov DWord Ptr [esi], eax
      pop    ebx
      pop    esi
End;
*)

function IntPower(Base: Extended; Exponent: Integer): Extended;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;

function IEPower(Base, Exponent: Extended): Extended;
begin
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Trunc(Exponent))
  else
    Result := Exp(Exponent * Ln(Base))
end;

(*$ifdef IEDELPHI*)

// if hdd<>0 uses DibDrawDib otherwise StetchDIBits
// USE THIS ONLY ON PRINTING FUNCTION OF TIMAGEENIO
procedure DrawDibDrawEmu(hdd: THandle; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt);
var
	fr:boolean;
begin
	fr:=(lpbi.biBitCount=24) and (hdd=0);
	if fr then
		hdd:=drawdibopen;
	if hdd=0 then begin
   	StretchDIBits(hDC,xDst,yDst,dxDst,dyDst,xSrc,ySrc,dxSrc,dySrc,Bits,PBITMAPINFO(@lpbi)^,DIB_RGB_COLORS,SRCCOPY);
   end else
		DrawDibDraw(hdd,hDC,xDst, yDst, dxDst, dyDst,lpbi,Bits,xSrc, ySrc, dxSrc, dySrc,wFlags);
   if fr then
   	drawdibclose(hdd);
end;

procedure DrawDib(hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer);
begin
	SetStretchBltMode(hDC,HALFTONE);
  	StretchDIBits(hDC,xDst,yDst,dxDst,dyDst,xSrc,ySrc,dxSrc,dySrc,Bits,PBITMAPINFO(@lpbi)^,DIB_RGB_COLORS,SRCCOPY);
end;


(*$endif*)


////////////////////////////////////////////////////////////////////////////////////
// exchanges WORD [ ex result:=hibyte(i) or (lobyte(i) shl 8); ]
function IESwapWord(i:word):word; assembler;
asm
	ror ax,8
end;

////////////////////////////////////////////////////////////////////////////////////
// exchanges DWORD
function IESwapDWord(i:integer):integer;
begin
	asm
 	mov EAX,i
 	bswap EAX
  mov @result,EAX
 end;
end;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// DoPaletteDialog
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

(*$ifdef IEDELPHI*)

procedure TImageEnPaletteDialog.SetPalette(var Palette:array of TRGB; NumCol:integer);
begin
	fPalette:=PRGBROW(@(Palette[0]));
   fNumCol:=NumCol;
end;

//
constructor TImageEnPaletteDialog.Create(AOwner: TComponent);
begin
	inherited CreateNew(AOwner);
  	OnPaint:=self.FormPaint;
  	OnMouseMove:=self.FormMouseMove;
  	OnClick:=self.FormClick;
  	BorderIcons:=[biSystemMenu];
  	BorderStyle:=bsDialog;
  	Caption:='Palette';
  	Height:=199;
  	Position:=poScreenCenter;
  	Width:=520;
   ButtonCancel:=TButton.Create(self);
   with ButtonCancel do begin
   	Parent:=self;
   	ModalResult:=mrCancel;
   	Caption:='&Cancel';
   	Cancel:=true;
   	Left:=4;
   	Top:=136;
   end;
   MouseCol:=-1;
end;

//
procedure TImageEnPaletteDialog.FormPaint(Sender:TObject);
var
	c,x,y:integer;
begin
   for c:=0 to fNumCol-1 do begin
   	y:=1+(c div 32)*16;
      x:=1+(c-(c div 32)*32)*16;
      Canvas.Brush.Color:=TRGB2TColor(fPalette^[c]);
      if MouseCol=c then
			Canvas.Pen.Color:=clBlack
      else
	      Canvas.Pen.Color:=clWhite;
      Canvas.Rectangle(x,y,x+15,y+15);
   end;
end;

//
procedure TImageEnPaletteDialog.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var
	c:integer;
begin
	c:=((x-1) div 16)+((y-1) div 16)*32;
   if (c>=0) and (c<fNumCol) and (c<>MouseCol) then begin
   	MouseCol:=c;
      FormPaint(self);
   end;
end;

//
procedure TImageEnPaletteDialog.FormClick(Sender: TObject);
begin
	SelCol:=TRGB2TCOLOR(fPalette^[MouseCol]);
   modalresult:=mrOK;
end;

//
function TImageEnPaletteDialog.Execute:boolean;
begin
	result:= ShowModal=mrOK;
end;

(*$endif*)


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// changes x2,y2 to make an angle of 45° or 90° with the line to x1,y1
// useful when CTRL is pressed (polygon selection)
procedure _CastPolySelCC(const x1,y1:integer; var x2,y2:integer);
var
   dx,dy:integer;
   adx,ady:integer;
begin
   dx:=x1-x2; adx:=abs(dx);
   dy:=y1-y2; ady:=abs(dy);
   if adx+30<ady then
      x2:=x1
   else if adx-30>ady then
      y2:=y1
   else begin
      if (dx<0) and (dy<0) then begin
         if (adx<ady) then
            inc(x2,abs(adx-ady))
         else
            inc(y2,abs(adx-ady));
      end else if (dx>0) and (dy>0) then begin
         if (adx<ady) then
            inc(y2,abs(adx-ady))
         else
            inc(x2,abs(adx-ady));
      end else if (dx>0) then begin
         if (adx<ady) then
            dec(x2,abs(adx-ady))
         else
            inc(y2,abs(adx-ady));
      end else if (dy>0) then begin
         if (adx<ady) then
            inc(x2,abs(adx-ady))
         else
            dec(y2,abs(adx-ady));
      end;
   end;
end;

// Return true if the two rectangles have an common region
// The rectangles must have ordered coordinates
function _RectXRect(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2:integer):boolean;
begin
	result:=not ((IMAX(ax1,ax2)<bx1) or (IMIN(ax1,ax2)>bx2) or
   		       (IMAX(ay1,ay2)<by1) or (IMIN(ay1,ay2)>by2));
end;

// Return "How much" the rectangle "b" is included in "a"
// 0 = no common region
// 1 = common region (not all)
// 2 = common region
// The rectangles must have ordered coordinates
function _RectPRect(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2:integer):integer;
var
	vx1,vx2:boolean;
   vy1,vy2:boolean;
begin
	vx1:= (bx1>=ax1) and (bx1<=ax2);
   vx2:= (bx2>=ax1) and (bx2<=ax2);
	vy1:= (by1>=ay1) and (by1<=ay2);
   vy2:= (by2>=ay1) and (by2<=ay2);
   if (vx1 xor vx2) and (vy1 or vy2) then
   	result:=1	// partial x
   else if (vx1 or vx2) and (vy1 xor vy2) then
   	result:=1   // partial y
   else if (vx1 xor vx2) and (vy1 xor vy2) then
   	result:=1   // partial xy
   else if vx1 and vx2 and vy1 and vy2 then
   	result:=2	// full
   else
   	result:=0;	// null
end;

// return true if the point xx,yy is inside the rectangle x1,y1,x2,y2
// x1,y1,x2,y2 must be ordered
function _InRect(xx,yy,x1,y1,x2,y2:integer):boolean;
begin
   result:=(xx>=x1) and (xx<=x2) and (yy>=y1) and (yy<=y2);
end;

// return true if the point xx,yy is inside the rectangle x1,y1,x2,y2
// x1,y1,x2,y2 ordered or not ordered
function _InRectO(xx,yy,x1,y1,x2,y2:integer):boolean;
begin
	OrdCor(x1,y1,x2,y2);
   result:=(xx>=x1) and (xx<=x2) and (yy>=y1) and (yy<=y2);
end;


// return file size
function _getfilesize(const nf:AnsiString):integer;
(*$ifdef IEDELPHI*)
var
	hh:THandle;
begin
	hh:=CreateFileA(PAnsiChar(nf),0,FILE_SHARE_READ,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
	result:=GetFileSize(hh,nil);
   CloseHandle(hh);
end;
(*$endif*)
(*$ifdef IEKYLIX*)
var
	f:file of byte;
begin
    AssignFile(f, nf);
    Reset(f);
    result := FileSize(f);
end;
(*$endif*)

(*$ifdef IEDELPHI*)
/////////////////////////////////////////////////////////////////////////////////////
// search for the window handle that contains cmp, going back (start from cmp)
function IEFindHandle(cmp:TComponent):integer;
var
	xowner:TComponent;
begin
	xowner:=cmp;
	while assigned(xowner) and not (xowner is TWinControl) do
   	xowner:=xowner.owner;
   if assigned(xowner) and (xowner as TWinControl).handleallocated then
	   result:=(xowner as TWinControl).Handle
   else
   	result:=0;
end;
(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
procedure IERightShadow(Canvas:TCanvas; x1,y1,x2,y2:integer; st:TIEShadowType);
var
	y,x,ww,hh:integer;
   cl1,cl2,cl:integer;
   o:integer;
begin
	ww:=x2-x1+1;
   hh:=y2-y1+1;
   case st of
   	iestSolid:
        	Canvas.FillRect(Rect(x1,y1+ww,x2,y2+1));
   	iestSmooth1:
      	begin
         	Canvas.Pen.Style:=psSolid;
            Canvas.Pen.Mode:=pmCopy;
				for x:=0 to ww-1 do begin
            	cl:= trunc(exp(x/ww)/exp(1)*255);
            	Canvas.Pen.Color:=TColor((cl) + (cl shl 8) + (cl shl 16));
            	Canvas.MoveTo(x1+x,y1+ww);
               Canvas.LineTo(x1+x,y2-ww+x+3);
            end;
         end;
   	iestSmooth2:
      	begin
            o:=0;
            for y:=0 to hh do begin
               cl2:= blimit(trunc(exp((hh-y*3)/hh)/exp(1)*255));
               if y>hh-ww+1 then
                  inc(o);
               for x:=o to ww do begin
                  cl1:= trunc(exp(x/ww)/exp(1)*255);
                  cl:=imax(cl1,cl2);
                  Canvas.Pixels[x1+x,y1+y]:=TColor((cl) + (cl shl 8) + (cl shl 16));
               end;
            end;
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
procedure IEBottomShadow(Canvas:TCanvas; x1,y1,x2,y2:integer; st:TIEShadowType);
var
	y,x,ww,hh:integer;
   cl1,cl2,cl:integer;
   o:integer;
begin
	ww:=x2-x1+1;
   hh:=y2-y1+1;
   case st of
   	iestSolid:
        	Canvas.FillRect(Rect(x1+hh,y1,x2+1,y2));
   	iestSmooth1:
      	begin
         	Canvas.Pen.Style:=psSolid;
            Canvas.Pen.Mode:=pmCopy;
				for y:=0 to hh-1 do begin
            	cl:= trunc(exp(y/hh)/exp(1)*255);
            	Canvas.Pen.Color:=TColor((cl) + (cl shl 8) + (cl shl 16));
            	Canvas.MoveTo(x1+hh,y1+y);
               Canvas.LineTo(x2-hh+y+3,y1+y);
            end;
         end;
   	iestSmooth2:
      	begin
            o:=0;
            for x:=0 to ww do begin
               cl2:= blimit(trunc(exp((ww-x*3)/ww)/exp(1)*255));
               if x>ww-hh+1 then
                  inc(o);
               for y:=o to hh do begin
                  cl1:= trunc(exp(y/hh)/exp(1)*255);
                  cl:=imax(cl1,cl2);
                  Canvas.Pixels[x1+x,y1+y]:=TColor((cl) + (cl shl 8) + (cl shl 16));
               end;
            end;
         end;
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

constructor TIEByteArray.Create;
begin
	fBlockSize:=8192;
   fSize:=0;
   fRSize:=fBlockSize;
	getmem(Data,fRSize);
end;

procedure TIEByteArray.Cleanup;
begin
	freemem(Data);
	inherited;
end;

procedure TIEByteArray.AddByte(v:byte);
begin
	SetSize(fSize+1);
   Data^[fSize-1]:=v;
end;

procedure TIEByteArray.Clear;
begin
	freemem(Data);
   fSize:=0;
   fRSize:=fBlockSize;
	getmem(Data,fRSize);
end;

procedure TIEByteArray.SetSize(v:integer);
var
	tmp:pbytearray;
begin
	if v>fSize then begin
   	// ingrandisci
		if v>fRSize then begin
         fRSize:=v+fBlockSize;
			getmem(tmp,fRSize);
         CopyMemory(tmp,Data,fSize);
         freemem(Data);
         Data:=tmp;
      end;
   end else begin
   	// diminuisci
		if v<(fRSize-fBlockSize) then begin
         fRSize:=v+fBlockSize;
			getmem(tmp,fRSize);
         CopyMemory(tmp,Data,fSize);
         freemem(Data);
         Data:=tmp;
      end;
   end;
   fSize:=v;
end;

// return writed bytes
function TIEByteArray.AppendFromStream(Stream:TStream; Count:integer):integer;
var
	l:integer;
begin
	l:=fSize;
	SetSize(fSize+Count);
	result:=Stream.Read(Data^[l],Count);
   if result<Count then
   	SetSize(l+result);
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// Saves the AnsiString ss to Stream. Saves the size (integer) then the AnsiString.
// Compatible with LoadStringFromStream
procedure SaveStringToStream(Stream:TStream; const ss:AnsiString);
var
	i:integer;
begin
	i:=length(ss);
	Stream.Write(i,sizeof(integer));
   Stream.Write(PAnsiChar(ss)^,i);
end;

// Loads a AnsiString from Stream. Compatible with SaveStringToStream
procedure LoadStringFromStream(Stream:TStream; var ss:AnsiString);
var
	i:integer;
begin
	Stream.Read(i,sizeof(integer));
   SetLength(ss,i);
   Stream.Read(PAnsiChar(ss)^,i);
end;

procedure SaveStringListToStream(Stream:TStream; sl:TStringList);
var
	i:integer;
begin
	i:=sl.Count; Stream.Write(i,sizeof(integer));
   for i:=0 to sl.Count-1 do
   	SaveStringToStream(Stream,sl[i]);
end;

procedure LoadStringListFromStream(Stream:TStream; sl:TStringList);
var
	i,w:integer;
   ss:AnsiString;
begin
	Stream.Read(w,sizeof(integer));
   sl.Clear;
   for i:=0 to w-1 do begin
   	LoadStringFromStream(Stream,ss);
      sl.Add(ss);
   end;
end;

// Returns number of colors calculated from BitsPerSample and SamplesperPixel
function _GetNumCol(BitsPerSample:integer; SamplesPerPixel:integer):integer;
begin
	result:=1;
   while SamplesPerPixel>0 do begin
		result:=result*(1 shl BitsPerSample);
      dec(SamplesPerPixel);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

constructor TNulStream.Create;
begin
	inherited;
   fposition:=0;
   fsize:=0;
end;

procedure TNulStream.Cleanup;
begin
 inherited;
end;

function TNulStream.Read(var Buffer; Count: Longint): Longint;
begin
	inc(fposition,Count);
   if fposition>=fsize then fsize:=fposition;
	result:=Count;
end;

function TNulStream.Write(const Buffer; Count: Longint): Longint;
begin
	inc(fposition,Count);
   if fposition>=fsize then fsize:=fposition;
	result:=Count;
end;

function TNulStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
	case Origin of
   	soFromBeginning:
      	begin
         	fPosition:=offset;
            if fposition>=fsize then fsize:=fposition;
         end;
      soFromCurrent:
      	begin
         	inc(fposition,offset);
            if fposition>=fsize then fsize:=fposition;
         end;
      soFromEnd:
      	begin
            fposition:=fsize-offset;
         end;
   end;
 	result:=fPosition;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// set translation
// lang: language
// msg: message to translate
// trans: translation AnsiString
procedure IESetTranslationWord(const lang:TMsgLanguage; const msg:TMsgLanguageWords; const trans:AnsiString);
begin
 {$IfNDef Nemesis}
	ieMessages[lang][msg]:=trans;
 {$EndIf  Nemesis}       
end;

// returns the message "msg" in language "lang"
function iemsg(const msg:TMsgLanguageWords; const lang:TMsgLanguage):AnsiString;
begin
 {$IfDef Nemesis}
 Assert(false, 'Ну и зачем библиотеке обработки изображений общаться с пользователем');
 {$Else  Nemesis}
	if lang=msSystem then begin
   	(*$ifdef IEDELPHI*)
   	case syslocale.PriLangID of
      	{$ifdef IESUPPORTITALIAN}
      	LANG_ITALIAN: result:=ieMessages[msItalian][msg];
         {$endif}
         {$ifdef IESUPPORTPORTUGUESE}
         LANG_PORTUGUESE: result:=ieMessages[msPortuguese][msg];
         {$endif}
         {$ifdef IESUPPORTENGLISH}
			LANG_ENGLISH: result:=ieMessages[msEnglish][msg];
         {$endif}
         {$ifdef IESUPPORTSPANISH}
         LANG_SPANISH: result:=ieMessages[msSpanish][msg];
         {$endif}
         {$ifdef IESUPPORTFRENCH}
         LANG_FRENCH: result:=ieMessages[msFrench][msg];
			{$endif}
         {$ifdef IESUPPORTGERMAN}
         LANG_GERMAN: result:=ieMessages[msGerman][msg];
         {$endif}
         {$ifdef IESUPPORTGREEK}
         LANG_GREEK: result:=ieMessages[msGreek][msg];
         {$endif}
         {$ifdef IESUPPORTRUSSIAN}
         LANG_RUSSIAN: result:=ieMessages[msRussian][msg];
         {$endif}
         {$ifdef IESUPPORTDUTCH}
         LANG_DUTCH: result:=ieMessages[msDutch][msg];
         {$endif}
         {$ifdef IESUPPORTSWEDISH}
         LANG_SWEDISH: result:=ieMessages[msSwedish][msg];
         {$endif}
         {$ifdef IESUPPORTPOLISH}
         LANG_POLISH: result:=ieMessages[msPolish][msg];
         {$endif}
	      else
         	{$ifdef IESUPPORTENGLISH}
   	   	result:=ieMessages[msEnglish][msg];
            {$else}
            result:=ieMessages[TMsgLanguage(1)][msg];
            {$endif}
      end;
      (*$endif*)
      (*$ifdef IEKYLIX*)
      result:=ieMessages[msEnglish][msg];
      (*$endif*)
   end else begin
   	result:=ieMessages[lang][msg];
      if result='' then
         	{$ifdef IESUPPORTENGLISH}
   	   	result:=ieMessages[msEnglish][msg];
            {$else}
            result:=ieMessages[TMsgLanguage(1)][msg];
            {$endif}
   end;
 {$EndIf Nemesis}
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEList

constructor TIEList.Create;
begin
	inherited Create;
   fData:=nil;
   Clear;
end;

procedure TIEList.Cleanup;
begin
	freemem(fData);
        inherited;
end;

procedure TIEList.Clear;
begin
   fCount:=0;
   if assigned(fData) then
   	freemem(fData);
   fData:=nil;
   fChanged:=[];
end;

procedure TIEList.SetCount(v:integer);
var
	xData:pointer;
begin
	getmem(xData,v*fItemSize);
   if assigned(fData) then begin
	   l3move(pbyte(fData)^,pbyte(xData)^,imin(fCount,v)*fItemSize);
	   freemem(fData);
   end;
   fData:=xData;
   fCount:=v;
   fChanged:=fChanged+[ielItems];
end;

procedure TIEList.Delete(idx:integer);
var
	xData:pointer;
   q:integer;
   psrc,pdst:pbyte;
begin
	if (idx>=0) and (idx<fCount) then begin
      getmem(xData,(fCount-1)*fItemSize);
      psrc:=fData;
      pdst:=xData;
      for q:=0 to fCount-1 do begin
         if q<>idx then begin
            // copy
            l3move(psrc^,pdst^,fItemSize);
            inc(pdst,fItemSize);
         end;
         inc(psrc,fItemSize);
      end;
      freemem(fData);
      fData:=xData;
      dec(fCount);
      fChanged:=fChanged+[ielItems];
   end;
end;

procedure TIEList.InsertItem(idx:integer; v:pointer);
var
	xData:pointer;
   q:integer;
   psrc,pdst:pbyte;
begin
	if idx<fCount then begin
      inc(fCount);
      getmem(xData,fCount*fItemSize);
      psrc:=fData;
      pdst:=xData;
      for q:=0 to fCount-1 do begin
         if q<>idx then begin
            // copy
            l3move(psrc^,pdst^,fItemSize);
            inc(psrc,fItemSize);
         end else
            // insert
            l3move(pbyte(v)^,pdst^,fItemSize);
         inc(pdst,fItemSize);
      end;
      freemem(fData);
      fData:=xData;
      fChanged:=fChanged+[ielItems];
   end else
   	AddItem(v);
end;

function TIEList.IndexOfItem(v:pointer):integer;
var
   pp:pbyte;
begin
	pp:=fData;
	for result:=0 to fCount-1 do begin
   	if CompareMem(pp,v,fItemSize) then
      	exit;
      inc(pp,fItemSize);
   end;
   result:=-1;
end;

function TIEList.AddItem(v:pointer):integer;
begin
	result:=fCount;
   SetCount(fCount+1);
   l3move( pbyte(v)^,pbyte(integer(fData)+result*fItemSize)^,fItemSize );
   fChanged:=fChanged+[ielItems];
end;

function TIEList.BaseGetItem(idx:integer):pointer;
begin
	result:=pointer( integer(fData)+idx*fItemSize )
end;

procedure TIEList.BaseSetItem(idx:integer; v:pointer);
begin
	if idx<fCount then begin
		l3move( pbyte(v)^,pbyte(integer(fData)+idx*fItemSize)^,fItemSize );
      fChanged:=fChanged+[ielItems];
   end;
end;

procedure TIEList.Assign(Source:TIEList);
begin
	if assigned(Source) then begin
      fCount:=Source.fCount;
      fItemSize:=Source.fItemSize;
      fChanged:=Source.fChanged;
      if assigned(fData) then
         freemem(fData);
      getmem(fData,fItemSize*fCount);
      l3move(pbyte(Source.fData)^,pbyte(fData)^,fItemSize*fCount);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEDoubleList

procedure TIEDoubleList.Assign(Source:TIEList);
begin
	inherited;
   if assigned(Source) then begin
      fRangeMin:=(Source as TIEDoubleList).fRangeMin;
      fRangeMax:=(Source as TIEDoubleList).fRangeMax;
      fRangeStep:=(Source as TIEDoubleList).fRangeStep;
      fCurrentValue:=(Source as TIEDoubleList).fCurrentValue;
   end;
end;

function TIEDoubleList.Add(v:double):integer;
begin
	result:=AddItem(@v);
end;

procedure TIEDoubleList.Clear;
begin
	inherited;
   fItemSize:=sizeof(double);
   fRangeMin:=0;
   fRangeMax:=0;
   fRangeStep:=0;
   fCurrentValue:=0;
end;

function TIEDoubleList.GetItem(idx:integer):double;
begin
	result:=PDouble(BaseGetItem(idx))^;
end;

procedure TIEDoubleList.SetItem(idx:integer; v:double);
begin
	BaseSetItem(idx,@v);
end;

procedure TIEDoubleList.Insert(idx:integer; v:double);
begin
	InsertItem(idx,@v);
end;

function TIEDoubleList.IndexOf(v:double):integer;
begin
	result:=IndexOfItem(@v);
end;

procedure TIEDoubleList.SetRangeMin(v:double);
begin
	fRangeMin:=v;
	fChanged:=fChanged+[ielRange];
end;

procedure TIEDoubleList.SetRangeMax(v:double);
begin
	fRangeMax:=v;
   fChanged:=fChanged+[ielRange];
end;

procedure TIEDoubleList.SetRangeStep(v:double);
begin
	fRangeStep:=v;
   fChanged:=fChanged+[ielRange];
end;

procedure TIEDoubleList.SetCurrentValue(v:double);
begin
	fCurrentValue:=v;
   fChanged:=fChanged+[ielCurrentValue];
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEIntegerList

procedure TIEIntegerList.Assign(Source:TIEList);
begin
	inherited;
   if assigned(Source) then begin
	   fRangeMin:=(Source as TIEIntegerList).fRangeMin;
	   fRangeMax:=(Source as TIEIntegerList).fRangeMax;
	   fRangeStep:=(Source as TIEIntegerList).RangeStep;
	   fCurrentValue:=(Source as TIEIntegerList).fCurrentValue;
   end;
end;

function TIEIntegerList.Add(v:Integer):integer;
begin
	result:=AddItem(@v);
end;

procedure TIEIntegerList.Clear;
begin
	inherited;
   fRangeMin:=0;
   fRangeMax:=0;
   fRangeStep:=0;
   fCurrentValue:=0;
   fItemSize:=sizeof(Integer);
end;

function TIEIntegerList.GetItem(idx:integer):Integer;
begin
	result:=PInteger(BaseGetItem(idx))^;
end;

procedure TIEIntegerList.SetItem(idx:integer; v:Integer);
begin
	BaseSetItem(idx,@v);
end;

procedure TIEIntegerList.Insert(idx:integer; v:Integer);
begin
	InsertItem(idx,@v);
end;

function TIEIntegerList.IndexOf(v:Integer):integer;
begin
	result:=IndexOfItem(@v);
end;

procedure TIEIntegerList.SetRangeMin(v:integer);
begin
	fRangeMin:=v;
   fChanged:=fChanged+[ielRange];
end;

procedure TIEIntegerList.SetRangeMax(v:integer);
begin
	fRangeMax:=v;
   fChanged:=fChanged+[ielRange];
end;

procedure TIEIntegerList.SetRangeStep(v:integer);
begin
	fRangeStep:=v;
   fChanged:=fChanged+[ielRange];
end;

procedure TIEIntegerList.SetCurrentValue(v:integer);
begin
	fCurrentValue:=v;
   fChanged:=fChanged+[ielCurrentValue];
end;


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEMarkerList

constructor TIEMarkerList.Create;
begin
	inherited Create;
	fData:=TList.Create;
   fType:=TList.Create;
end;

procedure TIEMarkerList.Cleanup;
begin
	Clear;
   FreeAndNil(fData);
   FreeAndNil(fType);
   inherited;
end;

function TIEMarkerList.GetCount:integer;
begin
	result:=fData.Count;
end;

function TIEMarkerList.GetMarkerStream(idx:integer):TStream;
begin
	result:=TStream(fData.Items[idx]);
   result.Position:=0;
end;

function TIEMarkerList.GetMarkerData(idx:integer):PAnsiChar;
begin
	result:=PAnsiChar(TMemoryStream(fData.Items[idx]).memory);
end;

function TIEMarkerList.GetMarkerType(idx:integer):byte;
begin
	result:=byte(integer(fType.Items[idx]));
end;

function TIEMarkerList.GetMarkerLength(idx:integer):word;
begin
	result:=TMemoryStream(fData.Items[idx]).size;
end;

function TIEMarkerList.IndexOf(marker:byte):integer;
begin
	for result:=0 to fType.Count-1 do
		if byte(integer(fType.Items[result]))=marker then
      	exit;
   result:=-1;
end;

function TIEMarkerList.AddMarker(marker:byte; data:PAnsiChar; datalen:word):integer;
var
	ms:TMemoryStream;
   i:integer;
begin
	ms:=TMemoryStream.Create;
   ms.Write(data^,datalen);
   fData.Add(ms);
   i:=marker;
   result:=fType.Add(pointer(i));
end;

procedure TIEMarkerList.SetMarker(idx:integer; marker:byte; data:PAnsiChar; datalen:word);
var
	ms:TMemoryStream;
   i:integer;
begin
	TMemoryStream(fData.Items[idx]).Free;
	ms:=TMemoryStream.Create;
   ms.Write(data^,datalen);
   fData.Items[idx]:=ms;
   i:=marker;
   fType.Items[idx]:=pointer(i);
end;

procedure TIEMarkerList.InsertMarker(idx:integer; data:PAnsiChar; marker:byte; datalen:word);
var
	ms:TMemoryStream;
   i:integer;
begin
	ms:=TMemoryStream.Create;
   ms.Write(data^,datalen);
   fData.Insert(idx,ms);
   i:=marker;
   fType.Insert(idx,pointer(i));
end;

procedure TIEMarkerList.Clear;
begin
 while fData.Count>0 do
 begin
  TMemoryStream(fData.Items[0]).Free;
  fData.Delete(0);
  fType.Delete(0);
 end;
end;

procedure TIEMarkerList.SaveToStream(Stream:TStream);
var
	bb:byte;
   ii,w:integer;
begin
	bb:=0;
	Stream.Write(bb,1); // version
	ii:=fData.Count;
   Stream.Write(ii,sizeof(integer));	// markers count
   for ii:=0 to fData.Count-1 do begin
   	bb:=byte(integer(fType.Items[ii]));
		Stream.Write(bb,1);	// marker type
      w:=TMemoryStream(fData.Items[ii]).Size;
      Stream.Write(w,sizeof(integer));	// marker length
		TMemoryStream(fData.Items[ii]).Position:=0;
      TMemoryStream(fData.Items[ii]).SaveToStream(Stream);	// data
   end;
end;

procedure TIEMarkerList.LoadFromStream(Stream:TStream);
var
	bb:byte;
   ii,q,w,l:integer;
  	ms:TMemoryStream;
begin
	Clear;
	Stream.Read(bb,1);
   Stream.Read(ii,sizeof(integer));
	for q:=0 to ii-1 do begin
   	Stream.Read(bb,1);
      w:=bb;
      fType.Add(pointer(w));
      Stream.Read(l,sizeof(integer));
		ms:=TMemoryStream.Create;
      ms.SetSize(l);
      Stream.Read(PAnsiChar(ms.memory)^,l);
      fData.Add(ms);
   end;
end;

procedure TIEMarkerList.DeleteMarker(idx:integer);
begin
   TMemoryStream(fData.Items[idx]).Free;
   fData.Delete(idx);
   fType.Delete(idx);
end;

procedure TIEMarkerList.Assign(Source:TIEMarkerList);
var
	q:integer;
begin
	if assigned(Source) then begin
		Clear;
		for q:=0 to Source.Count-1 do
	      AddMarker(Source.MarkerType[q],Source.MarkerData[q],Source.MarkerLength[q]);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// PIEIPTCInfoList

function TIEIPTCInfoList.GetStrings(idx:integer):AnsiString;
begin
	if (idx>=0) and (idx<fInfo.Count) then begin
		setlength(result,PIPTCInfo(fInfo[idx])^.fLength);
	   l3move(pbyte(fBuffer[idx])^,result[1],PIPTCInfo(fInfo[idx])^.fLength);
   end else
   	result:='';
end;

procedure TIEIPTCInfoList.SetStrings(idx:integer; Value:AnsiString);
begin
	freemem(fBuffer[idx]);
   fBuffer[idx]:=allocmem(length(Value));
   copymemory(fBuffer[idx],PAnsiChar(Value),length(Value));
	PIPTCInfo(fInfo[idx])^.fLength:=length(Value);
   fUserChanged:=true;
end;

function TIEIPTCInfoList.GetRecordNumber(idx:integer):integer;
begin
	result:=PIPTCInfo(fInfo[idx])^.fRecord;
end;

procedure TIEIPTCInfoList.SetRecordNumber(idx:integer; Value:integer);
begin
	PIPTCInfo(fInfo[idx])^.fRecord:=Value;
   fUserChanged:=true;
end;

function TIEIPTCInfoList.GetDataSet(idx:integer):integer;
begin
	result:=PIPTCInfo(fInfo[idx])^.fDataSet;
end;

procedure TIEIPTCInfoList.SetDataSet(idx:integer; Value:integer);
begin
	PIPTCInfo(fInfo[idx])^.fDataSet:=Value;
   fUserChanged:=true;
end;

function TIEIPTCInfoList.GetCount:integer;
begin
	result:=fInfo.Count;
end;

constructor TIEIPTCInfoList.Create;
begin
   fInfo:=TList.Create;
   fBuffer:=TList.Create;
   fUserChanged:=false;
end;

procedure TIEIPTCInfoList.Cleanup;
begin
	Clear;
	FreeAndNil(fInfo);
   FreeAndNil(fBuffer);
   inherited;
end;

function TIEIPTCInfoList.AddStringItem(RecordNumber:integer; DataSet:integer; Value:AnsiString):integer;
var
	pinfo:PIPTCInfo;
   xbuffer:PAnsiChar;
begin
	getmem(xbuffer,length(Value));
   copymemory(xbuffer,PAnsiChar(Value),length(Value));
   result:=fBuffer.Add(xbuffer);
   new(pinfo);
   pinfo^.fRecord:=RecordNumber;
   pinfo^.fDataSet:=DataSet;
   pinfo^.fLength:=length(Value);
   fInfo.Add(pinfo);
   fUserChanged:=true;
end;

function TIEIPTCInfoList.AddBufferItem(RecordNumber:integer; DataSet:integer; Buffer:pointer; BufferLength:integer):integer;
var
	pinfo:PIPTCInfo;
   xbuffer:pointer;
begin
	getmem(xbuffer,BufferLength);
   copymemory(xbuffer,Buffer,BufferLength);
	result:=fBuffer.Add(xbuffer);
   new(pinfo);
   pinfo^.fRecord:=RecordNumber;
   pinfo^.fDataSet:=DataSet;
   pinfo^.fLength:=BufferLength;
   fInfo.Add(pinfo);
   fUserChanged:=true;
end;

procedure TIEIPTCInfoList.InsertStringItem(idx:integer; RecordNumber:integer; DataSet:integer; Value:AnsiString);
var
	pinfo:PIPTCInfo;
   xbuffer:pointer;
begin
	getmem(xbuffer,length(Value));
   copymemory(xbuffer,PAnsiChar(Value),length(Value));
	fBuffer.Insert(idx,xbuffer);
   new(pinfo);
   pinfo^.fRecord:=RecordNumber;
   pinfo^.fDataSet:=DataSet;
   pinfo^.fLength:=length(Value);
   fInfo.Add(pinfo);
   fUserChanged:=true;
end;

procedure TIEIPTCInfoList.Clear;
begin
	while fInfo.Count>0 do begin
   	dispose( PIPTCInfo(fInfo[0]) );
   	freemem( fBuffer[0] );
      fInfo.Delete(0);
      fBuffer.Delete(0);
   end;
   fUserChanged:=true;
end;

function TIEIPTCInfoList.IndexOf(RecordNumber:integer; DataSet:integer):integer;
begin
	for result:=0 to fInfo.Count-1 do
   	with PIPTCInfo(fInfo[result])^ do
      	if (fRecord=RecordNumber) and (fDataSet=DataSet) then
         	exit;
	result:=-1;
end;

procedure TIEIPTCInfoList.DeleteItem(idx:integer);
begin
   dispose( PIPTCInfo(fInfo[idx]) );
   fInfo.Delete(idx);
   freemem( fBuffer[idx] );
   fBuffer.Delete(idx);
   fUserChanged:=true;
end;

procedure TIEIPTCInfoList.Assign(Source:TIEIPTCInfoList);
var
	q:integer;
begin
	if assigned(Source) then begin
		Clear;
		for q:=0 to Source.Count-1 do
	   	AddBufferItem(Source.RecordNumber[q],Source.DataSet[q],Source.fBuffer[q],PIPTCInfo(Source.fInfo[q])^.fLength);
		fUserChanged:=true;
   end;
end;

procedure TIEIPTCInfoList.SaveToStream(Stream:TStream);
var
	q,v:integer;
begin
	v:=0; Stream.Write(v,sizeof(integer));	// version
   v:=fInfo.Count; Stream.Write(v,sizeof(integer)); // count
	for q:=0 to fInfo.Count-1 do begin
   	Stream.Write( PIPTCInfo(fInfo[q])^, sizeof(TIPTCInfo) );
      Stream.Write( pbyte(fBuffer[q])^, PIPTCInfo(fInfo[q])^.fLength );
   end;
end;

procedure TIEIPTCInfoList.LoadFromStream(Stream:TStream);
var
	q,v:integer;
   info:TIPTCInfo;
   xbuffer:pbyte;
begin
	Clear;
	Stream.Read(v,sizeof(integer));	// version
   Stream.Read(v,sizeof(integer));	// count
   for q:=0 to v-1 do begin
   	Stream.Read( info, sizeof(TIPTCInfo) );
      getmem(xbuffer,info.fLength);
      Stream.Read(xbuffer^,info.fLength);
		AddBufferItem(info.fRecord,info.fDataSet,xbuffer,info.fLength);
      freemem(xbuffer);
   end;
   fUserChanged:=true;
end;

// Buffer is allocated by SaveToStandardBuffer
procedure TIEIPTCInfoList.SaveToStandardBuffer(var Buffer:pointer; var BufferLength:integer; WriteHeader:boolean);
const
	psheader:PAnsiChar=(*0*)'Photoshop 3.0'+#0+(*14*)'8BIM'+(*18*)#4#4+(*20*)#0#0+(*22*)#0#0#0#0;
   psheader2:PAnsiChar=#28#2#0#0#2#0#2;
var
	q:integer;
   ms:TMemoryStream;
   l,tl:dword;
	b:byte;
begin
	if fInfo.Count=0 then begin
   	Buffer:=nil;
      BufferLength:=0;
   end else begin
      ms:=TMemoryStream.Create;

      if WriteHeader then
         // good for Jpegs
         ms.Write(psheader^,26) // PhotoShop 3.0 marker
      else
         // good for TIFF
         ms.Write(psheader2^,7);	// marker for TIFFs

      tl:=0;
      for q:=0 to fInfo.Count-1 do begin
         with PIPTCInfo(fInfo[q])^ do begin
            if ((fRecord=2) and (fDataSet=0)) or (fLength=0) then
               continue;
            b:=$1C; ms.Write(b,1);	// tag marker
            b:=fRecord; ms.Write(b,1); // recnum
            b:=fDataSet; ms.Write(b,1); // dataset
            l:=fLength;
            if l>32767 then begin
               // long
               b:=0; ms.Write(b,1); // length of data field count field (hi)
               b:=4; ms.Write(b,1); // length of data field count field (lo)
               b:=(l and $FF000000) shr 24; ms.Write(b,1); // data length
               b:=(l and $00FF0000) shr 16; ms.Write(b,1);
               b:=(l and $0000FF00) shr 8; ms.Write(b,1);
               b:=(l and $000000FF); ms.Write(b,1);
               inc(tl,3+6+l);
            end else begin
               // short
               b:=(l and $0000FF00) shr 8; ms.Write(b,1); // data length
               b:=(l and $000000FF); ms.Write(b,1);
               inc(tl,3+2+l);
            end;
            ms.Write(pbyte(fBuffer[q])^,l);
         end;
      end;
      BufferLength:=ms.Size;
      if (BufferLength and $1)<>0 then begin
         inc(BufferLength);
         b:=0; ms.Write(b,1);
      end;
      getmem(Buffer,BufferLength);
      copymemory(Buffer,ms.Memory,BufferLength);

      if WriteHeader then begin
         pbytearray(Buffer)^[22]:=(tl and $FF000000) shr 24;
         pbytearray(Buffer)^[23]:=(tl and $00FF0000) shr 16;
         pbytearray(Buffer)^[24]:=(tl and $0000FF00) shr 8;
         pbytearray(Buffer)^[25]:=(tl and $000000FF);
      end;

      FreeAndNil(ms);
   end;
end;

procedure TIEIPTCInfoList.LoadFromStandardBuffer(Buffer:pointer; BufferLength:integer);
var
	pc:PAnsiChar;
   ps:integer;
   dataset,recnum:integer;
   len:integer;
begin
	Clear;
	pc:=PAnsiChar(Buffer);
   ps:=0;
	while (ps<BufferLength) do
   	if (pc[ps]=AnsiChar($1c)) (*and (pc[ps+1]=AnsiChar($02))*) then
      	break
      else
      	inc(ps);
   repeat
   	if pc[ps]<>AnsiChar($1c) then
      	break;
      inc(ps);
      if (ps+4)>=BufferLength then
      	break;
		recnum:=integer(pc[ps]); inc(ps);
      dataset:=integer(pc[ps]); inc(ps);
      if (byte(pc[ps]) and $80)<>0 then begin
      	// long tag
			len:=(integer(pc[ps+2]) shl 24)+(integer(pc[ps+3]) shl 16)+
         	  (integer(pc[ps+4]) shl 8)+(integer(pc[ps+5]));
         inc(ps,6);
      end else begin
      	// short tag
         len:=(integer(pc[ps]) shl 8) or integer(pc[ps+1]);
         inc(ps,2);
      end;
      len:=abs(len);
      if (ps+len)>BufferLength then
      	break;
		AddBufferItem(recnum,dataset,@(pc[ps]),len);
   	inc(ps,len);
   until ps>=BufferLength;
   fUserChanged:=false;	// the user should not call LoadFromStandardBuffer, then this is not an user changement
end;


/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIERecordList

constructor TIERecordList.CreateList(RecordSize:integer);
begin
	inherited Create;
	fItemSize:=RecordSize;
end;

function TIERecordList.GetItem(idx:integer):pointer;
begin
	result:=BaseGetItem(idx);
end;

procedure TIERecordList.SetItem(idx:integer; v:pointer);
begin
	BaseSetItem(idx,v);
end;

function TIERecordList.Add(v:pointer):integer;
begin
	result:=AddItem(v);
end;

procedure TIERecordList.Insert(idx:integer; v:pointer);
begin
	InsertItem(idx,v);
end;

function TIERecordList.IndexOf(v:pointer):integer;
begin
	result:=IndexOfItem(v);
end;

////////////////////////////////////////////////////////////////////////////////////////
function IEFloor(X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

// point to point distance
function _DistPoint2Point(x1,y1,x2,y2:integer):double;
begin
	result:=sqrt( sqr(x2-x1)+sqr(y2-y1) );
end;

// point to line distance
function _DistPoint2Line(xp,yp,x1,y1,x2,y2:integer):double;
var
	a,b,c:integer;
begin
   a:=y1-y2;
	b:=x2-x1;
   c:=x1*y2-x2*y1;
   result:=abs(a*xp+b*yp+c)/sqrt(a*a+b*b);
end;

// Point<->Segment distance
function _DistPoint2Seg(xp,yp,x1,y1,x2,y2:integer):double;
var
	r:double;
begin
 	result:=1000000;
	try
	if (x1=x2) and (y1=y2) then
   	result:=sqrt(sqr(xp-x1)+sqr(yp-y1))
   else begin
      r:=((y1-yp)*(y1-y2)-(x1-xp)*(x2-x1))/sqr(sqrt(sqr(x2-x1)+sqr(y2-y1)));
      if r>1 then begin
         // distance from xp,yp to x2,y2
			if abs(xp-x2)>45000 then exit;
         if abs(yp-y2)>45000 then exit;
         result:=sqrt(sqr(xp-x2)+sqr(yp-y2));
      end else if r<0 then begin
         // distance from xp,yp to x1,y1
         if abs(x1-xp)>45000 then exit;
         if abs(y1-yp)>45000 then exit;
         result:=sqrt(sqr(x1-xp)+sqr(y1-yp))
      end else begin
         // distance from the line
         result:=_DistPoint2Line(xp,yp,x1,y1,x2,y2);
      end;
   end;
   except
   end;
end;

function _DistPoint2Polyline(x,y:integer; PolyPoints:PPointArray; PolyPointsCount:integer; ToSubX, ToSubY, ToAddX, ToAddY:integer; ToMulX,ToMulY:double):double;
var
	i:integer;
   d:double;
   x1,y1,x2,y2:integer;
begin
	result:=1000000;
	if PolyPointsCount>0 then begin
   	x1:=round((PolyPoints^[0].x-ToSubX)*ToMulX+ToAddX);
      y1:=round((PolyPoints^[0].y-ToSubY)*ToMulY+ToAddY);
      for i:=1 to PolyPointsCount-1 do begin
         x2:=round((PolyPoints^[i].x-ToSubX)*ToMulX+ToAddX);
         y2:=round((PolyPoints^[i].y-ToSubY)*ToMulY+ToAddY);
         d:=_DistPoint2Seg(x,y,x1,y1,x2,y2);
         if d<result then
         	result:=d;
         iswap(x1,x2);
         iswap(y1,y2);
      end;
   end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEScrollBarParams
constructor TIEScrollBarParams.Create;
begin
   fLineStep:=-1;
   fPageStep:=-1;
   fTracking:=true;
end;

procedure TIEScrollBarParams.Cleanup;
begin
	inherited;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

constructor TIEMouseWheelParams.Create;
begin
   InvertDirection:=false;
   Action:=iemwZoom;
   Variation:=iemwPercentage;
   Value:=8;
   ZoomPosition:=iemwCenter;
end;

procedure TIEMouseWheelParams.Cleanup;
begin
	inherited;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

// check if mmx available
function IEMMXSupported:bytebool;
begin
	result:=false;
	asm
     	push ebx
		// check if the cpuid instruction is available
      pushfd
      pushfd
      pop    eax
      mov    ecx, eax
      xor    eax, 200000h
      push   eax
      popfd
      pushfd
      pop    eax
      popfd
      xor    eax, ecx
      jz @nocpuid
      // cpuid supported, check MMX
      mov eax, 1
      Dw $A20F	// CPUID
      test edx, 800000h
      setnz result
   @nocpuid:
      pop ebx
   end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEMask class

constructor TIEMask.Create;
begin
	inherited Create;
   fFull:=false;
   fWidth:=0;
   fHeight:=0;
   fBitsperpixel:=0;
   fRowlen:=0;
   fBits:=nil;
   fX1:=2147483647;
   fY1:=2147483647;
   fX2:=0;
   fY2:=0;
   //
	l3ZeroMemory(@fBitmapInfoHeader1,sizeof(TBitmapInfoHeader256));
   with fBitmapInfoHeader1 do begin
      biSize:=sizeof(TBitmapInfoHeader);
      biPlanes:=1;
      biBitCount:=1;
      Palette[1].rgbRed:=255;
      Palette[1].rgbGreen:=255;
      Palette[1].rgbBlue:=255;
      biCompression:=BI_RGB;
   end;
   fTmpBmp:=nil;
   fTmpBmpScanline:=nil;
   fTmpBmpWidth:=0;
   fTmpBmpHeight:=0;
end;

procedure TIEMask.Cleanup;
begin
   FreeBits;
	inherited;
end;

//
procedure TIEMask.Assign(Source:TIEMask);
begin
	if assigned(Source) then begin
		AllocateBits(Source.fWidth,Source.fHeight,Source.fBitsPerPixel);
	   copymemory(fBits,Source.fBits,fRowlen*fHeight);
	   fX1:=Source.fX1;
	   fY1:=Source.fY1;
	   fX2:=Source.fX2;
	   fY2:=Source.fY2;
	   fFull:=Source.fFull;
   end;
end;

// set mask pixel
// supported bitsperpixel: 1, 8
// Alpha for 1bpp:
//     1 = over image is fully visible (for selections: the region is selected)
//     0 = over image is not visible (for selections: the region is not selected)
// Alpha for 8bpp:
//     255 = over image si fully visible
//     ...
//     0 = over image is not visible
procedure TIEMask.SetPixel(x,y:integer; Alpha:integer);
begin
	if (x>=fWidth) or (y>=fHeight) or (x<0) or (y<0) then
   	exit;
   if Alpha<>0 then begin
      if x<fX1 then fX1:=x;
      if x>fX2 then fX2:=x;
      if y<fY1 then fY1:=y;
      if y>fY2 then fY2:=y;
      if fX1<0 then fX1:=0;
      if fX2>=fWidth then fX2:=fWidth-1;
      if fY1<0 then fY1:=0;
      if fY2>=fHeight then fY2:=fHeight-1;
   end;
   if fFull then
	   fFull:=not ((fBitsPerPixel=8) and (Alpha<>255)) or ((fBitsPerPixel=1) and (Alpha=0));
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel
            _SetPixelbw(pbyte(integer(fBits)+(fHeight-y-1)*fRowlen),x,Alpha);
         end;
      8: begin
            // 8 bits per pixel
            pbyte(integer(fBits)+(fHeight-y-1)*fRowlen+x)^:=Alpha;
         end;
   end;
end;

procedure TIEMask.SyncRect;
var
	y,x:integer;
   px:pbyte;
   //
   procedure SetRect;
   begin
      if x<fX1 then fX1:=x;
      if x>fX2 then fX2:=x;
      if y<fY1 then fY1:=y;
      if y>fY2 then fY2:=y;
      if fX1<0 then fX1:=0;
      if fX2>=fWidth then fX2:=fWidth-1;
      if fY1<0 then fY1:=0;
      if fY2>=fHeight then fY2:=fHeight-1;
	end;
   //
begin
   fX1:=2147483647;
   fY1:=2147483647;
   fX2:=0;
   fY2:=0;
	for y:=0 to fHeight-1 do begin
      case fBitsPerPixel of
      	1:
            for x:=0 to fWidth-1 do
               if _GetPixelbw(pbyte(integer(fBits)+(fHeight-y-1)*fRowlen),x)<>0 then
               	SetRect;
         8:
         	begin
            	px:=Scanline[y];
               for x:=0 to fWidth-1 do begin
                  if px^<>0 then
                  	SetRect;
                  inc(px);
               end;
            end;
      end;
   end;
end;

// get mask pixel
// supported bitsperpixel: 1, 8
// Value for 1bpp:
//     1 = over image is fully visible (for selections: the region is selected)
//     0 = over image is not visible (for selections: the region is not selected)
// Value for 8bpp:
//     255 = over image si fully visible
//     ...
//     0 = over image is not visible
function TIEMask.GetPixel(x,y:integer):integer;
begin
	if (x>=fWidth) or (y>=fHeight) or (x<0) or (y<0) then
   	result:=0
	else
      case fBitsperpixel of
         1: begin
               // 1 bit per pixel
               result:=_GetPixelbw(pbyte(integer(fBits)+(fHeight-y-1)*fRowlen),x);
            end;
         8: begin
               // 8 bits per pixel
               result:=pbyte(integer(fBits)+(fHeight-y-1)*fRowlen+x)^;
            end;
         else
            result:=0;
      end;
end;

// return true if the x,y point is inside non zero mask
function TIEMask.IsPointInside(x,y:integer):boolean;
begin
	result:=GetPixel(x,y)<>0;
end;

// allocate Mask (and free previous)
// supported bitsperpixel: 1, 8
// memory is initialized to zero
procedure TIEMask.AllocateBits(width,height:integer; bitsperpixel:integer);
begin
  	FreeBits;
   fWidth:=width;
   fHeight:=height;
   fBitsperpixel:=bitsperpixel;
   fRowlen:=IEBitmapRowLen(width,fBitsPerPixel,32);
   fBits:=allocmem(height*fRowlen);
   fX1:=2147483647;
   fY1:=2147483647;
   fX2:=0;
   fY2:=0;
   fFull:=false;
end;

procedure TIEMask.Resize(NewWidth,NewHeight:integer);
var
   lBits,ps,pd:pbyte;
   lRowLen,y,rl:integer;
begin
   lBits:=fBits;
   lRowLen:=fRowLen;
   fRowLen:=IEBitmapRowLen(NewWidth,fBitsPerPixel,32);
   fBits:=allocmem(NewHeight*fRowlen);
   rl:=imin(lRowLen,fRowLen);
   ps:=pbyte( integer(lBits)+(fHeight-1)*lRowLen );
   pd:=pbyte( integer(fBits)+(NewHeight-1)*fRowLen );
   for y:=0 to fHeight-1 do begin
      copymemory( pd, ps, rl );
      dec(ps,lRowLen);
      dec(pd,fRowLen);
   end;
   freemem(lBits);
   fWidth:=NewWidth;
   fHeight:=NewHeight;
   if fX1<fX2 then begin
      fX1:=imin(fX1,fWidth-1);
      fY1:=imin(fY1,fHeight-1);
      fX2:=imin(fX2,fWidth-1);
      fY2:=imin(fY2,fHeight-1);
   end;
end;

// free Mask
procedure TIEMask.FreeBits;
begin
   if fTmpBmp<>nil then begin
      freemem(fTmpBmp);
      freemem(fTmpBmpScanline);
   end;
   fTmpBmp:=nil;
   fTmpBmpScanline:=nil;
   fTmpBmpWidth:=0;
   fTmpBmpHeight:=0;
   //
   if fBits<>nil then
      freemem(fBits);
   fBits:=nil;
   fWidth:=0;
   fHeight:=0;
   fBitsperpixel:=0;
   fRowlen:=0;
end;

// Inverts pixels of Dest rect, stretching mask rect
// Only with fBitsPerPixel=1
procedure TIEMask.InvertCanvas(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer);
(*$ifdef IEDELPHI*)
var
	bi:^TBitmapInfo;
begin
	if (fX1=2147483647) or (fY1=2147483647) or (fBitsPerPixel<>1) then exit;
   with fBitmapInfoHeader1 do begin
      biWidth:=fWidth;
      biHeight:=fHeight;
   end;
   bi:=@fBitmapInfoHeader1;
   StretchDIBits(Dest.Handle,xDst,yDst,dxDst,dyDst,xMask,(fheight-dyMask-yMask),dxMask,dyMask,fBits,bi^,DIB_RGB_COLORS,SRCINVERT);
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

procedure Stretch(BitsPerPixel:integer; dest:pbyte; dxDst,dyDst,xSrc,ySrc,dxSrc,dySrc:integer; src:pbyte; srcWidth,srcHeight:integer; fx1,fy1,fx2,fy2:integer);
var
	rx,ry,sy:integer;
   y2,x2:integer;
   x,y:integer;
   px1,px2,px3:pbyte;
   destRowlen,srcRowLen,sx:integer;
   ffx1,ffy1,ffx2,ffy2:integer;
   zx,zy:double;
   arx,arxp:pinteger;
begin
	if (dxDst<1) or (dyDst<1) then exit;
	destRowlen:=IEBitmapRowLen(dxDst,BitsPerPixel,32);
  	l3zeromemory(dest,destRowlen*dyDst);
   srcRowLen:=IEBitmapRowLen(srcWidth,BitsPerPixel,32);
   ry:=trunc((dySrc/dyDst)*16384);  // 2^14
   rx:=trunc((dxSrc/dxDst)*16384);
   y2:=dyDst-1;
   x2:=dxDst-1;
   zx:=dxDst/dxSrc;
   zy:=dyDst/dySrc;
   ffy1:=imax(trunc(zy*(fy1-ySrc)),0);
   ffx1:=imax(trunc(zx*(fx1-xSrc)),0);
   ffy2:=imin(trunc(zy*(fy2-ySrc+1)),y2);
   ffx2:=imin(trunc(zx*(fx2-xSrc+1)),x2);
   l3zeromemory(dest,IEBitmapRowLen(dxDst,BitsPerPixel,32)*dyDst);
   getmem(arx,sizeof(integer)*(ffx2-ffx1+1));
   try
    arxp:=arx;
         for x:=ffx1 to ffx2 do begin
         arxp^:=((rx*x) shr 14)+xSrc;
       inc(arxp);
    end;
    for y:=ffy1 to ffy2 do begin
       px2:= pbyte( integer(dest)+(dyDst-y-1)*destRowlen );
       sy:= ((ry*y) shr 14)+ySrc;
       px1:= pbyte( integer(src)+(srcHeight-sy-1)*srcRowlen );
       arxp:=arx;
       case BitsPerPixel of
         1:
                 begin
                for x:=ffx1 to ffx2 do begin
                   if (pbytearray(px1)^[arxp^ shr 3] and iebitmask1[arxp^ and $7])<>0 then begin
                      px3:=@(pbytearray(px2)^[x shr 3]);
                      px3^:=px3^ or iebitmask1[x and 7];	// to 1
                   end;
                   inc(arxp);
                end;
             end;
          8:
                 begin
                for x:=ffx1 to ffx2 do begin
                 pbytearray(px2)^[x] := pbytearray(px1)^[arxp^];
                   inc(arxp);
                end;
             end;
       end;
    end;
   finally
    freemem(arx);
   end;//try..finally 
end;

procedure TIEMask.DrawOutline(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer; AniCounter:integer; Color1,Color2:TColor; Zoom:double);
(*$ifdef IEDELPHI*)
var
   row,col,x,y:integer;
   px,px2:pbyte;
   rowlo,rowhi,collo,colhi:integer;
   zx,zy:integer;
   c1,c2:integer;
   crgb:array [false..true] of integer;
   rgb:integer;
   ch:THandle;
   xx,yy:integer;
   row1,row2:integer;
   //
   procedure DrawPix;
   var
   	y:integer;
   begin
      xx:=col+xDst;
      rgb:=crgb[(((xx+yy+AniCounter) and 7)<4)];
      if col=0 then begin
         x:=((col*zx)shr 14)+xMask;
         if (x<=fX1) then
            Windows.SetPixel(ch, xx, yy, rgb);
      end else if col=colhi then begin
         x:=((col*zx)shr 14)+xMask;
         if (x>=fX2) or (dxMask=Width) then
            Windows.SetPixel(ch, xx, yy, rgb);
      end else if row=0 then begin
         y:=((row*zy)shr 14)+yMask;
         if (y<=fY1) then
            Windows.SetPixel(ch, xx, yy, rgb);
      end else if row=rowhi then begin
         y:=((row*zy)shr 14)+yMask;
         if (y>=fY2) or (dyMask=Height) then
            Windows.SetPixel(ch, xx, yy, rgb);
      end else begin
      	case fBitsPerPixel of
         	1:
            	begin
                  c1:=13-((col-1) and 7);
                  c2:=(col-1) shr 3;
                  for y:=row1 to row2 do begin
                     // read 3 pixels at the time
                     px2:=pbyte(dword(fTmpBmpScanline[y])+dword(c2));
                     if ((IESwapWord(pword(px2)^) shr c1) and 7) < 7 then begin
                        Windows.SetPixel(ch, xx, yy, rgb);
                        break;
                     end;
                  end;
               end;
            8:
               for y:=row1 to row2 do begin
						px2:=pbyte(dword(fTmpBmpScanline[y])+dword(col-1));
                  if px2^=0 then Windows.SetPixel(ch, xx, yy, rgb); inc(px2);
						if px2^=0 then Windows.SetPixel(ch, xx, yy, rgb); inc(px2);
                  if px2^=0 then Windows.SetPixel(ch, xx, yy, rgb);
               end;
         end;
      end;
   end;
   //
begin
	if (dxDst<1) or (dyDst<1) then exit;
	if (fX1=2147483647) or (fY1=2147483647) then exit;
   crgb[false]:=ColorToRGB(Color1);
   crgb[true]:=ColorToRGB(Color2);
   if (fTmpBmpWidth<>dxDst) or (fTmpBmpHeight<>dyDst) then begin
		fTmpBmpWidth:=dxDst;
      fTmpBmpHeight:=dyDst;
      row:=IEBitmaprowlen(dxDst,fBitsPerPixel,32);
      if fTmpBmp<>nil then begin
      	freemem(fTmpBmp);
         freemem(fTmpBmpScanline);
      end;
      getmem(fTmpBmp,row*dyDst);
      getmem(fTmpBmpScanline,sizeof(pointer)*dyDst);
      for y:=0 to dyDst-1 do
         fTmpBmpScanline[y]:=pointer(integer(fTmpBmp)+(dyDst-y-1)*row);
	end;
	Stretch(fBitsPerPixel,fTmpBmp,dxDst,dyDst,xMask,yMask,dxMask,dyMask,fBits,fWidth,fHeight,fx1,fy1,fx2,fy2);
   zx:=trunc((dxMask/dxDst)*16384);
   zy:=trunc((dyMask/dyDst)*16384);
   rowlo:=imax(((fY1-yMask)*16384 div zy),0);
   rowhi:=imin(((fY2-yMask+1)*16384 div zy)+1,(dyDst-1));
   collo:=imax(((fX1-xMask)*16384 div zx),0);
   colhi:=imin(((fX2-xMask+1)*16384 div zx)+1,(dxDst-1));
   // draw outline of the mask
   Dest.Pen.Style:=psSolid;
   Dest.Pen.Mode:=pmCopy;
   ch:=Dest.Handle;
	for row:=rowlo to rowhi do begin
   	px:=fTmpBmpScanline[row];
      yy:=row+yDst;
      row1:=imax(row-1,0);
     	row2:=imin(row+1,dyDst-1);
      case fBitsPerPixel of
      	1:
            for col:=collo to colhi do begin
               if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7])<>0 then
                  DrawPix;
            end;
         8:
            for col:=collo to colhi do begin
            	if pbytearray(px)^[col]<>0 then
                  DrawPix;
            end;
      end;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

procedure TIEMask.DrawOuter(Dest:TBitmap; xDst,yDst,dxDst,dyDst:integer; xMask,yMask,dxMask,dyMask:integer);
(*$ifdef IEDELPHI*)
(*
var
   row,col,y,dw,dh:integer;
   px:pbyte;
   rowlo,rowhi,collo,colhi:integer;
   zx,zy:integer;
   pxd:PRGB;
begin
	if (dxDst<1) or (dyDst<1) then exit;
	if (fX1=2147483647) or (fY1=2147483647) then exit;
   if (fTmpBmpWidth<>dxDst) or (fTmpBmpHeight<>dyDst) then begin
		fTmpBmpWidth:=dxDst;
      fTmpBmpHeight:=dyDst;
      row:=_Bitmaprowlen(dxDst,fBitsPerPixel);
      if fTmpBmp<>nil then begin
      	freemem(fTmpBmp);
         freemem(fTmpBmpScanline);
      end;
      getmem(fTmpBmp,row*dyDst);
      getmem(fTmpBmpScanline,sizeof(pointer)*dyDst);
      for y:=0 to dyDst-1 do
         fTmpBmpScanline[y]:=pointer(integer(fTmpBmp)+(dyDst-y-1)*row);
	end;
   Stretch(fBitsPerPixel,fTmpBmp,dxDst,dyDst,xMask,yMask,dxMask,dyMask,fBits,fWidth,fHeight,fx1,fy1,fx2,fy2);
   zx:=trunc((dxMask/dxDst)*16384);
   zy:=trunc((dyMask/dyDst)*16384);
   dw:=Dest.Width;
   dh:=Dest.Height;
   rowlo:=imax(((-yMask)*16384 div zy),0);
   rowhi:=imin(((Height-yMask)*16384 div zy)+1,(dyDst-1));
   rowhi:=imin(rowhi,dh-1);
   collo:=imax(((0-xMask)*16384 div zx),0);
   colhi:=imin(((Width-xMask)*16384 div zx)+1,(dxDst-1));
   colhi:=imin(colhi,dw-1);
	for row:=rowlo to rowhi do
   	if (row and 1)=0 then begin
         px:=fTmpBmpScanline[row];
         pxd:=Dest.Scanline[row+yDst];
         inc(pxd,collo+xDst);
         case fBitsPerPixel of
         	1:
               for col:=collo to colhi do begin
                  if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7])=0 then
                     if (col and 1)=0 then
                        with pxd^ do begin
                           r:=255; g:=255; b:=255;
                        end;
                  inc(pxd);
               end;
         	8:
               for col:=collo to colhi do begin
                  if (pbytearray(px)^[col])=0 then
                     if (col and 1)=0 then
                        with pxd^ do begin
                           r:=255; g:=255; b:=255;
                        end;
                  inc(pxd);
               end;
         end;
      end;
end;
//*)
var
   row,col,y,dw,dh:integer;
   px:pbyte;
   rowlo,rowhi,collo,colhi:integer;
   zx,zy:integer;
   pxd:PRGB;
begin
	if (dxDst<1) or (dyDst<1) then exit;
	if (fX1=2147483647) or (fY1=2147483647) then exit;
   if (fTmpBmpWidth<>dxDst) or (fTmpBmpHeight<>dyDst) then begin
		fTmpBmpWidth:=dxDst;
      fTmpBmpHeight:=dyDst;
      row:=IEBitmaprowlen(dxDst,fBitsPerPixel,32);
      if fTmpBmp<>nil then begin
      	freemem(fTmpBmp);
         freemem(fTmpBmpScanline);
      end;
      getmem(fTmpBmp,row*dyDst);
      getmem(fTmpBmpScanline,sizeof(pointer)*dyDst);
      for y:=0 to dyDst-1 do
         fTmpBmpScanline[y]:=pointer(integer(fTmpBmp)+(dyDst-y-1)*row);
	end;
	Stretch(fBitsPerPixel,fTmpBmp,dxDst,dyDst,xMask,yMask,dxMask,dyMask,fBits,fWidth,fHeight,fx1,fy1,fx2,fy2);
   zx:=trunc((dxMask/dxDst)*16384);
   zy:=trunc((dyMask/dyDst)*16384);
   dw:=Dest.Width;
   dh:=Dest.Height;
   rowlo:=imax(((-yMask)*16384 div zy),0);
   rowhi:=imin(((Height-yMask)*16384 div zy)+1,(dyDst-1));
   rowhi:=imin(rowhi,dh-1);
   collo:=imax(((0-xMask)*16384 div zx),0);
   colhi:=imin(((Width-xMask)*16384 div zx)+1,(dxDst-1));
   colhi:=imin(colhi,dw-1);
	for row:=rowlo to rowhi do begin
      px:=fTmpBmpScanline[row];
      pxd:=Dest.Scanline[row+yDst];
      inc(pxd,collo+xDst);
      case fBitsPerPixel of
      1:
            for col:=collo to colhi do begin
               if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7])=0 then
                 if (((row and 1)=0) and ((col and 1)=0)) or
                    (((row and 1)=1) and ((col and 1)=1)) then
                      with pxd^ do
                        begin
                          r:=97; g:=97; b:=97;
                        end;
               inc(pxd);
            end;
      8:
            for col:=collo to colhi do begin
               if (pbytearray(px)^[col])=0 then
                 if (((row and 1)=0) and ((col and 1)=0)) or
                    (((row and 1)=1) and ((col and 1)=1)) then
                      with pxd^ do
                        begin
                          r:=97; g:=97; b:=97;
                        end;
               inc(pxd);
            end;
      end;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)


// copy Source in Dest applying mask
// Source and Dest can be pf24bit or pf1bit (must be Source.PixelFormat=Dest.PixelFormat)
// when dstonlymask is false the entire source bitmap is copied to dest
// when dstonlymask is true only the effective mask region is copied to dest
// when srconlymask is false the source has some size of the mask
// when srconlymask is true the source has size of real used mask
procedure TIEMask.CopyBitmap(Dest,Source:TBitmap; dstonlymask,srconlymask:boolean);
var
	row,col:integer;
   px1,px2:PRGB;
   a:integer;
   pb:pbyte;
   ii:integer;
   ox,oy,sx,sy:integer;
begin
   if (fX1>fX2) and (fY1>fY2) then exit;
   if dstonlymask then begin
   	ox:=fX1;
      oy:=fY1;
   end else begin
   	ox:=0;
      oy:=0;
   end;
   if srconlymask then begin
   	sx:=fX1;
      sy:=fY1;
   end else begin
   	sx:=0;
      sy:=0;
   end;
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel (copy if mask is 1)
            if (Source.PixelFormat=pf24bit) and (Dest.PixelFormat=pf24bit) then begin
            	// pf24bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  inc(px1,fX1-sx);
                  px2:=Dest.ScanLine[row-oy];
                  inc(px2,fX1-ox);
                  pb:=pbyte(integer(fBits)+(fHeight-row-1)*fRowlen);
                  for col:=fX1 to fX2 do begin
                     if _GetPixelbw(pb,col)<>0 then
								px2^:=px1^;
                     inc(px2);
                     inc(px1);
                  end;
               end;
            end else if (Source.PixelFormat=pf1bit) and (Dest.PixelFormat=pf1bit) then begin
            	// pf1bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  px2:=Dest.ScanLine[row-oy];
                  pb:=pbyte(integer(fBits)+(fHeight-row-1)*fRowlen);
                  for col:=fX1 to fX2 do begin
                     if _GetPixelbw(pb,col)<>0 then
                     	_SetPixelbw(pbyte(px2),col-ox, _GetPixelbw(pbyte(px1),col-sx) );
                  end;
               end;
            end;
         end;
      8: begin
            // 8 bits per pixel (alpha blend)
            if (Source.PixelFormat=pf24bit) and (Dest.PixelFormat=pf24bit) then begin
            	// pf24bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  inc(px1,fX1-sx);
                  px2:=Dest.ScanLine[row-oy];
                  inc(px2,fX1-ox);
                  ii:=integer(fBits)+(fHeight-row-1)*fRowlen;
                  for col:=fX1 to fX2 do begin
                     a:=pbyte(ii+col)^ shl 10;
                     px2^.r:=(a*(px1^.r-px2^.r) shr 18 +px2^.r);
                     px2^.g:=(a*(px1^.g-px2^.g) shr 18 +px2^.g);
                     px2^.b:=(a*(px1^.b-px2^.b) shr 18 +px2^.b);
                     inc(px2);
                     inc(px1);
                  end;
               end;
            end else if (Source.PixelFormat=pf1bit) and (Dest.PixelFormat=pf1bit) then begin
            	// pf1bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  px2:=Dest.ScanLine[row-oy];
                  ii:=integer(fBits)+(fHeight-row-1)*fRowlen;
                  for col:=fX1 to fX2 do begin
                  	a:=pbyte(ii+col)^;
                     if a<>0 then
                     	_SetPixelbw(pbyte(px2),col-ox, _GetPixelbw(pbyte(px1),col-sx) );
                  end;
               end;
            end;
         end;
   end;
end;

// copy Source in Dest applying mask (using TIEBItmap instead of TBitmap)
// Source and Dest can be ie24RGB or ie1g (must be Source.PixelFormat=Dest.PixelFormat)
// when dstonlymask is false the entire source bitmap is copied to dest
// when dstonlymask is true only the effective mask region is copied to dest
// when srconlymask is false the source has some size of the mask
// when srconlymask is true the source has size of real used mask
// If UseAlphaChannel is true then calls CopyIEBitmapAlpha
procedure TIEMask.CopyIEBitmap(Dest,Source:TIEBitmap; dstonlymask,srconlymask:boolean; UseAlphaChannel:boolean);
var
	row,col:integer;
   px1,px2:PRGB;
   a:integer;
   pb:pbyte;
   ii:integer;
   ox,oy,sx,sy:integer;
begin
   if (fX1>fX2) and (fY1>fY2) then exit;
   if dstonlymask then begin
   	ox:=fX1;
      oy:=fY1;
   end else begin
   	ox:=0;
      oy:=0;
   end;
   if srconlymask then begin
   	sx:=fX1;
      sy:=fY1;
   end else begin
   	sx:=0;
      sy:=0;
   end;
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel (copy if mask is 1)
            if (Source.PixelFormat=ie24RGB) and (Dest.PixelFormat=ie24RGB) then begin
            	// ie24RGB
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  inc(px1,fX1-sx);
                  px2:=Dest.ScanLine[row-oy];
                  inc(px2,fX1-ox);
                  pb:=pbyte(integer(fBits)+(fHeight-row-1)*fRowlen);
                  for col:=fX1 to fX2 do begin
                     if _GetPixelbw(pb,col)<>0 then
								px2^:=px1^;
                     inc(px2);
                     inc(px1);
                  end;
               end;
            end else if (Source.PixelFormat=ie1g) and (Dest.PixelFormat=ie1g) then begin
            	// pf1bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  px2:=Dest.ScanLine[row-oy];
                  pb:=pbyte(integer(fBits)+(fHeight-row-1)*fRowlen);
                  for col:=fX1 to fX2 do begin
                     if _GetPixelbw(pb,col)<>0 then
                     	_SetPixelbw(pbyte(px2),col-ox, _GetPixelbw(pbyte(px1),col-sx) );
                  end;
               end;
            end;
         end;
      8: begin
            // 8 bits per pixel (alpha blend)
            if (Source.PixelFormat=ie24RGB) and (Dest.PixelFormat=ie24RGB) then begin
            	// pf24bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  inc(px1,fX1-sx);
                  px2:=Dest.ScanLine[row-oy];
                  inc(px2,fX1-ox);
                  ii:=integer(fBits)+(fHeight-row-1)*fRowlen;
                  for col:=fX1 to fX2 do begin
                     a:=pbyte(ii+col)^ shl 10;
                     px2^.r:=(a*(px1^.r-px2^.r) shr 18 +px2^.r);
                     px2^.g:=(a*(px1^.g-px2^.g) shr 18 +px2^.g);
                     px2^.b:=(a*(px1^.b-px2^.b) shr 18 +px2^.b);
                     inc(px2);
                     inc(px1);
                  end;
               end;
            end else if (Source.PixelFormat=ie1g) and (Dest.PixelFormat=ie1g) then begin
            	// pf1bit
               for row:=fY1 to fY2 do begin
               	px1:=Source.ScanLine[row-sy];
                  px2:=Dest.ScanLine[row-oy];
                  ii:=integer(fBits)+(fHeight-row-1)*fRowlen;
                  for col:=fX1 to fX2 do begin
                  	a:=pbyte(ii+col)^;
                     if a<>0 then
                     	_SetPixelbw(pbyte(px2),col-ox, _GetPixelbw(pbyte(px1),col-sx) );
                  end;
               end;
            end;
         end;
   end;
   if UseAlphaChannel then
   	CopyIEBitmapAlpha(Dest,Source,dstonlymask,srconlymask);
end;

// Like CopyIEBitmap, but sets the alpha channel in Dest (0=no selection, 255=selection, if Source is 255, otherwise set Source.Alpha)
procedure TIEMask.CopyIEBitmapAlpha(Dest,Source:TIEBitmap; dstonlymask,srconlymask:boolean);
var
	row,col:integer;
   px1,px2:pbyte;
   pb:pbyte;
   ox,oy,sx,sy,ii:integer;
   al255:pbyte;
begin
   if (fX1>fX2) and (fY1>fY2) then exit;
   if dstonlymask then begin
   	ox:=fX1;
      oy:=fY1;
   end else begin
   	ox:=0;
      oy:=0;
   end;
   if srconlymask then begin
   	sx:=fX1;
      sy:=fY1;
   end else begin
   	sx:=0;
      sy:=0;
   end;
   al255:=nil;
   if not Source.HasAlphaChannel then begin
		getmem(al255,Source.Width);
      l3fillchar(al255^,Source.Width,255);
   end;
   for row:=fY1 to fY2 do begin
      if Source.HasAlphaChannel then
         px1:=Source.AlphaChannel.ScanLine[row-sy]
      else
         px1:=al255;
      inc(px1,fX1-sx);
      px2:=Dest.AlphaChannel.ScanLine[row-oy];
      inc(px2,fX1-ox);
      pb:=pbyte(integer(fBits)+(fHeight-row-1)*fRowlen);
      case fBitsPerPixel of
      	1:
            for col:=fX1 to fX2 do begin
               if _GetPixelbw(pb,col)<>0 then
                  // selected
                  px2^:=imin(px1^,255)
               else
                  // not selected
                  px2^:=0;
               inc(px2);
               inc(px1);
            end;
      	8:
            for col:=fX1 to fX2 do begin
            	ii:=pbytearray(pb)^[col];
               if ii<>0 then
                  // selected
                  px2^:=imin(px1^,ii)
               else
                  // not selected
                  px2^:=0;
               inc(px2);
               inc(px1);
            end;
      end;
   end;
   if al255<>nil then
   	freemem(al255);
   Dest.AlphaChannel.Full:=false;
end;


// draw an horizontal line, associating Alpha value to the setted pixels
// return number of pixel written
function TIEMask.DrawHorizontalLine(Alpha:integer; xleft,xright,y:integer):integer;
var
	x:integer;
   pb:pbyte;
   pp:pbytearray;
begin
	result:=0;
   if xleft<0 then xleft:=0;
   if xright>=fWidth then xright:=fWidth-1;
   if y<0 then y:=0;
   if y>=fHeight then y:=fHeight-1;
   if fFull then
	   fFull:=not ((fBitsPerPixel=8) and (Alpha<>255)) or ((fBitsPerPixel=1) and (Alpha=0));
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel, Alpha must be 1
            pp:=pbytearray(integer(fBits)+(fHeight-y-1)*fRowlen);
            for x:=xleft to xright do begin
            	pb:=@(pp^[x shr 3]);
               pb^:=pb^ or iebitmask1[x and 7];
               inc(result);
            end;
         end;
      8: begin
            // 8 bits per pixel
            l3fillchar(pbyte(integer(fBits)+(fHeight-y-1)*fRowlen+xleft)^,xright-xleft+1,Alpha);
            inc(result,xright-xleft+1);
         end;
   end;
end;

function TIEMask.GetScanLine(Row:integer):pointer;
begin
	result:=pointer( integer(fBits)+(fHeight-Row-1)*fRowlen );
end;

//
procedure TIEMask.Fill(Alpha:integer);
begin
	l3fillchar(fBits^,fRowLen*fHeight,Alpha);
	fFull:=not ((fBitsPerPixel=8) and (Alpha<>255)) or ((fBitsPerPixel=1) and (Alpha=0));
end;

function TIEMask.IsEmpty:boolean;
begin
	result:= fX1=2147483647;
end;

procedure TIEMask.Empty;
begin
	Fill(0);
   fX1:=2147483647;
   fY1:=2147483647;
   fX2:=0;
   fY2:=0;
end;

// draw multi polygons separated by IESELBREAK, using DrawSinglePolygon
procedure TIEMask.DrawPolygon(Alpha:integer; SelPoly:PPointArray; SelPolyCount:integer);
var
   p1,p2,q:integer;
begin
   if SelPolyCount>0 then begin
      p1:=0;
      for q:=0 to SelPolyCount do
         if (q=SelPolyCount) or (SelPoly^[q].x=IESELBREAK) then begin
            p2:=q-p1;
            DrawSinglePolygon(Alpha,PPointArray(@(SelPoly^[p1])),p2);
            p1:=q+1;
         end;
   end;
end;

// draw a filled polygon in the mask, associating Alpha value to the setted pixels
procedure TIEMask.DrawSinglePolygon(Alpha:integer; SelPoly:PPointArray; SelPolyCount:integer);
type
	eltptr=^element;
	element=record
   	xP,yQ,dx,dy,E:integer;
      next:eltptr;
   end;
	telementarray=array [0..32767] of eltptr;
   pelementarray=^telementarray;
var
	x,y,i,ymin,ymax,j,ny,i1,xP,yP,xQ,yQ,temp,dx,dy,m,dyQ,E,xleft,xright:integer;
   table:pelementarray;
   p,start,_end,p0,q:eltptr;
   pw:integer;	// pixel written
begin
	ymin:=2147483647;
   ymax:=0;
   for i:=0 to SelPolyCount-1 do begin
   	x:=selpoly^[i].x;
      y:=selpoly^[i].y;
      if y<ymin then ymin:=y;
      if y>ymax then ymax:=y;
      if Alpha<>0 then begin
         if x<fX1 then fX1:=x;
         if x>fX2 then fX2:=x-1;
         if y<fY1 then fY1:=y;
         if y>fY2 then fY2:=y-1;
      end;
   end;
   if fX1<0 then fX1:=0;
   if fX2>=fWidth then fX2:=fWidth-1;
   if fY1<0 then fY1:=0;
   if fY2>=fHeight then fY2:=fHeight-1;
   ny:=ymax-ymin+1;
   getmem(table,ny*sizeof(eltptr));
   for j:=0 to ny-1 do
   	table[j]:=nil;
   for i:=0 to SelPolyCount-1 do begin
   	i1:=i+1;
      if i1=SelPolyCount then i1:=0;
      xP:=selpoly^[i].x; yP:=selpoly^[i].y;
      xQ:=selpoly^[i1].x; yQ:=selpoly^[i1].y;
      if yP=yQ then continue;
      if yQ<yP then begin
      	temp:=xP; xP:=xQ; xQ:=temp;
         temp:=yP; yP:=yQ; yQ:=temp;
      end;
      getmem(p,sizeof(element));
      p^.xP:=xP; p^.dx:=xQ-xP;
      p^.yQ:=yQ; p^.dy:=yQ-yP;
      j:=yP-ymin;
      p^.next:=table[j]; table[j]:=p;
   end;
   getmem(start,sizeof(element));
   _end:=start;
   pw:=0;
   for j:=0 to ny-1 do begin
   	y:=ymin+j;
      p:=start;
      while p<>_end do begin
      	if p^.yQ=y then begin
         	q:=p^.next;
         	if (q=_end) then _end:=p else p^:=q^;
            freemem(q);
         end else begin
         	dx:=p^.dx;
         	if dx<>0 then begin
            	x:=p^.xP;
               dy:=p^.dy;
					E:=p^.E;
               m:=dx div dy;
               dyQ:=2*dy;
               inc(x,m); inc(E,2*dx-m*dyQ);
               if (E>dy) or (E<-dy) then begin
               	if dx>0 then begin
                  	inc(x);
                     dec(E,dyQ);
                  end else begin
                  	dec(x);
                     inc(E,dyQ);
                  end;
               end;
               p^.xP:=x;
               p^.E:=E;
            end;
            p:=p^.next;
         end;
      end;
      p:=table[j];
      while p<>nil do begin
         _end^.xP:=p^.xP;
         x:=_end^.xP;
         yQ:=p^.yQ;
         dx:=p^.dx; dy:=p^.dy; q:=start;
         while (q^.xP<x) or (q^.xP=x) and (q<>_end) and (q^.dx*dy<dx*q^.dy) do
            q:=q^.next;
         p0:=p; p:=p^.next;
         if q=_end then _end:=p0 else p0^:=q^;
         q^.xP:=x; q^.yQ:=yQ;
         q^.dx:=dx; q^.dy:=dy;
         q^.E:=0; q^.next:=p0;
      end;
      p:=start;
      while p<>_end do begin
         xleft:=p^.xP; p:=p^.next;
         xright:=p^.xP-1;
         if xleft<=xright then
            inc(pw , DrawHorizontalLine(Alpha,xleft,xright,y) );
         p:=p^.next;
      end;
   end;
   p:=start;
   while p<>_end do begin
   	p0:=p;
      p:=p^.next;
      freemem(p0);
   end;
   freemem(start);
   freemem(table);
	if pw=0 then begin
   	// empty selection
      fX1:=2147483647;
      fY1:=2147483647;
      fX2:=0;
      fY2:=0;
	end;
end;

// translate the bitmap
// adjust ox,oy
// If CalcOnly is True only ox and oy are changed (not the mask)
procedure TIEMask.TranslateBitmap(var ox,oy:integer; CutSel:boolean);
//(*
var
	xbits,ps,pd:pbyte;
   x,y:integer;
   xx,yy:integer;
   p:integer;
   dx,dy,slen:integer;
begin
	if CutSel then begin
   	if (ox+fX1)<0 then inc(fX1,abs(ox+fX1));
      if (oy+fY1)<0 then inc(fY1,abs(oy+fY1));
      if (ox+fX2)>=fWidth then dec(fX2,1+abs(fWidth-(ox+fX2)));
      if (oy+fY2)>=fHeight then dec(fY2,1+abs(fHeight-(oy+fY2)));
   end else begin
      if (ox+fX1)<0 then dec(ox, (ox+fX1) );
      if (ox+fX2)>=fWidth then dec(ox, (ox+fX2-fWidth+1) );
      if (oy+fY1)<0 then dec(oy, (oy+fY1) );
      if (oy+fY2)>=fHeight then dec(oy, (oy+fY2-fHeight+1) );
   end;
	if (ox=0) and (oy=0) then exit;
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel
            dx:=fX2-fX1+1;
            dy:=fY2-fY1+1;
            slen:=IEBitmapRowLen(dx,fBitsPerPixel,32);
            xbits:=allocmem(slen*dy);	// we need zero filled memory
            ps:=pbyte(integer(fBits)+(fHeight-fY1-1)*fRowlen);
            pd:=pbyte(integer(xBits)+(dy-1)*slen);
            for y:=0 to dy-1 do begin
               _CopyBits(pd,ps,0,fX1,dx,fRowLen);
               l3zeromemory(ps,fRowLen);
               dec(ps,fRowlen);
               dec(pd,slen);
            end;
            ps:=pbyte(integer(xBits)+(dy-1)*slen);
            pd:=pbyte(integer(fBits)+(fHeight-fY1-oy-1)*fRowlen);
            for y:=0 to dy-1 do begin
               _CopyBits(pd,ps,fX1+ox,0,dx,slen);
               dec(pd,fRowlen);
               dec(ps,slen);
            end;
            freemem(xbits);
         end;
      8: begin
            // 8 bits per pixel
            getmem(xbits,frowlen*fheight);
            copymemory(xbits,fbits,frowlen*fheight);
            l3zeromemory(fbits,frowlen*fheight);
            for y:=fY1 to fY2 do begin
            	yy:=y+oy;
            	if (yy<fHeight) and (yy>=0) then begin
                  for x:=fX1 to fX2 do begin
                  	xx:=x+ox;
                     if (xx<fWidth) and (xx>=0) then begin
								p:=pbyte(integer(xBits)+(fHeight-y-1)*fRowlen+x)^;
                        pbyte(integer(fBits)+(fHeight-yy-1)*fRowlen+xx)^:=p;
                     end;
                  end;
               end;
            end;
            freemem(xbits);
         end;
   end;
   inc(fX1,ox); if fX1<0 then fX1:=0; if fX1>=fWidth then fX1:=fWidth-1;
   inc(fY1,oy); if fY1<0 then fY1:=0; if fY1>=fHeight then fY1:=fHeight-1;
   inc(fX2,ox); if fX2<0 then fX2:=0; if fX2>=fWidth then fX2:=fWidth-1;
   inc(fY2,oy); if fY2<0 then fY2:=0; if fY2>=fHeight then fY2:=fHeight-1;
end;
//*)
(*
var
	xbits:pbyte;
   x,y:integer;
   xx,yy:integer;
   p:integer;
begin
	if CutSel then begin
   	if (ox+fX1)<0 then inc(fX1,abs(ox+fX1));
      if (oy+fY1)<0 then inc(fY1,abs(oy+fY1));
      if (ox+fX2)>=fWidth then dec(fX2,1+abs(fWidth-(ox+fX2)));
      if (oy+fY2)>=fHeight then dec(fY2,1+abs(fHeight-(oy+fY2)));
   end else begin
      if (ox+fX1)<0 then dec(ox, (ox+fX1) );
      if (ox+fX2)>=fWidth then dec(ox, (ox+fX2-fWidth+1) );
      if (oy+fY1)<0 then dec(oy, (oy+fY1) );
      if (oy+fY2)>=fHeight then dec(oy, (oy+fY2-fHeight+1) );
   end;
	if (ox=0) and (oy=0) then exit;
   getmem(xbits,frowlen*fheight);
   copymemory(xbits,fbits,frowlen*fheight);
   l3zeromemory(fbits,frowlen*fheight);
   case fBitsperpixel of
      1: begin
            // 1 bit per pixel
            xx:=fx2-fx1+1;
            for y:=fY1 to fY2 do begin
            	yy:=y+oy;
            	if (yy<fHeight) and (yy>=0) then
                  _CopyBits(pbyte(integer(fBits)+(fHeight-yy-1)*fRowlen),pbyte(integer(xBits)+(fHeight-y-1)*fRowlen),fx1+ox,fx1,xx,fRowlen)
               else
                  showmessage('err');
            end;
         end;
      8: begin
            // 8 bits per pixel
            for y:=fY1 to fY2 do begin
            	yy:=y+oy;
            	if (yy<fHeight) and (yy>=0) then begin
                  for x:=fX1 to fX2 do begin
                  	xx:=x+ox;
                     if (xx<fWidth) and (xx>=0) then begin
								p:=pbyte(integer(xBits)+(fHeight-y-1)*fRowlen+x)^;
                        pbyte(integer(fBits)+(fHeight-yy-1)*fRowlen+xx)^:=p;
                     end;
                  end;
               end;
            end;
         end;
   end;
   inc(fX1,ox); if fX1<0 then fX1:=0; if fX1>=fWidth then fX1:=fWidth-1;
   inc(fY1,oy); if fY1<0 then fY1:=0; if fY1>=fHeight then fY1:=fHeight-1;
   inc(fX2,ox); if fX2<0 then fX2:=0; if fX2>=fWidth then fX2:=fWidth-1;
   inc(fY2,oy); if fY2<0 then fY2:=0; if fY2>=fHeight then fY2:=fHeight-1;
   freemem(xbits);
end;
//*)

procedure TIEMask.Negative(MaxVal:integer);
var
	x,y:integer;
begin
	if (fX1=2147483647) or (fY1=2147483647) then
   	exit;
   fFull:=false;
   fX1:=2147483647;
   fY1:=2147483647;
   fX2:=0;
   fY2:=0;
	for y:=0 to fHeight-1 do begin
   	for x:=0 to fWidth-1 do begin
      	if GetPixel(x,y)=0 then begin
         	SetPixel(x,y,MaxVal);
            if x<fX1 then fX1:=x;
            if x>fX2 then fX2:=x;
            if y<fY1 then fY1:=y;
            if y>fY2 then fY2:=y;
         end else
         	SetPixel(x,y,0);
      end;
   end;
end;

// set Full to True if all values are 255
// works both 1 and 8 bitsperpixel
procedure TIEMask.SyncFull;
var
	px:pbyte;
   y,x,l:integer;
begin
	l:=fRowLen;
	for y:=0 to fHeight-1 do begin
   	px:=Scanline[y];
      for x:=0 to l-1 do begin
      	if px^<$FF then begin
         	fFull:=False;
            exit;
         end;
      	inc(px);
      end;
   end;
   fFull:=True;
end;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEVirtualDIBList

(*$ifdef IEDELPHI*)

// Location:
//   ielTempFile : create in a temp directory a new file
// TempDirectory:
//   if empty uses windows temp directory
//   otherwise must be a full path ending with '\'
constructor TIEVirtualDIBList.Create;
begin
	inherited Create;
   fmemmap:=TIEFileBuffer.Create;
   fAllocationBlock:=65536;
   fSize:=fAllocationBlock;
   fImageCount:=0;
   fInsPos:=0;
   fImageInfo:=TList.Create;
   fFreeBlocks:=TList.Create;
   fToDiscardList:=TList.Create;
   fMaxImagesInMemory:=10;
   fImagesInMemory:=0;
   fBmpToRelease:=TList.Create;
   fLastVImageSize:=0;
   l3ZeroMemory(@fTempBitmapInfoHeader256,sizeof(TBitmapInfoHeader256));
   ReAllocateBits;
end;

procedure TIEVirtualDIBList.Cleanup;
begin
   FreeBits;
   FreeAndNil(fmemmap);
   FreeAndNil(fImageInfo);
   FreeAndNil(fFreeBlocks);
   FreeAndNil(fToDiscardList);
   FreeAndNil(fBmpToRelease);
   inherited;
end;

// allocate (or re-allocate) bits without memory loss
procedure TIEVirtualDIBList.ReAllocateBits;
begin
	// delete free block list
   while fFreeBlocks.Count>0 do begin
   	dispose(fFreeBlocks[0]);
      fFreeBlocks.Delete(0);
   end;
   //
	if not fmemmap.IsAllocated then begin
      FreeBits;
      fmemmap.AllocateFile('',fSize);
	end else begin
   	DiscardAll;
      fmemmap.ReAllocateFile(fSize);
   end;
end;

procedure TIEVirtualDIBList.FreeBits;
begin
	// unmap views
   while fImageInfo.Count>0 do
		RemoveImageInfo(0);
   fToDiscardList.Clear;
	// delete free block list
   while fFreeBlocks.Count>0 do begin
   	dispose(fFreeBlocks[0]);
      fFreeBlocks.Delete(0);
   end;
   // bmp to release list
   while fBmpToRelease.Count>0 do begin
   	FreeAndNil(PIEVirtualToReleaseBmp(fBmpToRelease[0])^.bmp);
   	dispose( fBmpToRelease[0] );
      fBmpToRelease.Delete(0);
   end;
   //
   fmemmap.DeAllocate;
   fImageCount:=0;
   fInsPos:=0;
end;

procedure TIEVirtualDIBList.RemoveImageInfo(idx:integer);
var
	qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	qidx:=BmpToReleaseIndexOf( fImageInfo[idx] );
   if qidx>-1 then begin
		inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
		FreeAndNil(inf^.bmp);
      dispose( inf );
		fBmpToRelease.Delete( qidx );
   end;
	DiscardImage(fImageInfo[idx]);	// discard if needed
	dispose( fImageInfo[idx] );
   fImageInfo.Delete(idx);
end;

procedure TIEVirtualDIBList.DiscardImage(info:PIEVirtualImageInfo);
begin
	with info^ do begin
   	if ptr<>nil then begin
         fmemmap.UnMap(ptr);
	      fToDiscardList.Remove( info );
   	   dec(fImagesInMemory);
      end;
      ptr:=nil;
   end;
end;

procedure TIEVirtualDIBList.DiscardOne;
begin
	if fToDiscardList.Count>0 then
	   DiscardImage( fToDiscardList[0] );
end;

procedure TIEVirtualDIBList.DiscardAll;
begin
	while fToDiscardList.Count>0 do
   	DiscardImage( fToDiscardList[0] );
end;

// the opposite of DiscardImage
// if the image is already mapped, MapImage bring it at last position of the discard list
procedure TIEVirtualDIBList.MapImage(image:pointer; access:TIEDataAccess);
var
	pinfo:PIEVirtualImageInfo;
begin
	pinfo:=image;
	with pinfo^ do begin
   	if access<>currentaccess then
         DiscardImage(pinfo);
   	if ptr=nil then begin
         while (fImagesInMemory+1)>fMaxImagesInMemory do
            DiscardOne;
         ptr:=fmemmap.Map(pos,vsize,access);
         if ptr<>nil then begin
  	         inc(fImagesInMemory);
	         fToDiscardList.Add( pinfo );
         end;
         currentaccess:=access;
      end else begin
      	// _move to the end of discard list
         if pinfo^.ptr<>nil then begin
	         fToDiscardList.Remove( pinfo );
	         fToDiscardList.Add( pinfo );
         end;
      end;
   end;
end;

procedure TIEVirtualDIBList.PrepareSpaceFor(Width,Height:integer; Bitcount:integer; ImageCount:integer);
var
	rowlen,bmplen,vbmplen:int64;
begin
	rowlen:= IEBitmapRowLen( Width, Bitcount ,32);
	bmplen:= Height * rowlen + sizeof(TBitmapInfoHeader256);
	vbmplen:= bmplen;
   fSize:= fSize+vbmplen*ImageCount;
   ReAllocateBits;
end;

// the image remains mapped
function TIEVirtualDIBList.AddBlankImage(Width,Height,Bitcount:integer; HasAlpha:boolean):pointer;
var
   ii:PIEVirtualImageInfo;
begin
	result:=nil;
	new(ii);
   if AllocImage(ii,Width,Height,Bitcount,HasAlpha) then begin
	   fImageInfo.Add(ii);
   	result:=ii;
   end else
   	dispose(ii);
end;

function TIEVirtualDIBList.AllocImage(image:pointer; Width,Height,Bitcount:integer; HasAlpha:boolean):boolean;
var
	rowlen,bmplen,vbmplen,alphalen:int64;
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   ne:int64;
   ii:PIEVirtualImageInfo;
   fb:PIEVirtualFreeBlock;
   q:integer;
begin
	rowlen:= IEBitmapRowLen( Width, Bitcount,32 );
   if HasAlpha then
	   alphalen:=sizeof(boolean)+IEBitmapRowLen(Width,8,32)*Height
   else
   	alphalen:=0;
	bmplen:= Height * rowlen + sizeof(TBitmapInfoHeader256) + alphalen;
   vbmplen:=bmplen;
   // look for a free block before last image (VERY SIMPLE ALGORITHM, TO OPTIMIZE)
   q:=0;
   fb:=nil;
   while q<fFreeBlocks.Count do begin
		fb:=PIEVirtualFreeBlock(fFreeBlocks[q]);
      if vbmplen<=fb^.vsize then
         break
      else
      	fb:=nil;
      inc(q);
   end;
   //
   if fb<>nil then begin
   	// found a free block
      ne:=fInsPos;
      fInsPos:=fb^.pos;
      // remove free block (should ramment the block if greater)
      dispose(fb);
      fFreeBlocks.Delete(q);
   end else begin
   	// no free blocks found, allocate new
      if fAllocationBlock<vbmplen then
         fAllocationBlock:=fLastVImageSize+vbmplen;
      fLastVImageSize:=vbmplen;
      ne:=fInsPos+vbmplen;
      if ne>fSize then begin
         // expand file (of fAllocationBlock bytes)
         fSize:=fSize+fAllocationBlock;
         ReAllocateBits;
      end;
   end;
   //
   ii:=image;
   with ii^ do begin
      pos:=fInsPos;
      size:=bmplen;
      vsize:=vbmplen;
      ptr:=nil;
      bitmapped:=false;
      orig_width:=Width;
      orig_height:=Height;
      HasAlphaChannel:=HasAlpha;
      //currentaccess:=[iedRead,iedWrite];
      currentaccess:=[iedWrite];
   end;
   MapImage(ii,ii^.currentaccess);
   //
   if ii^.ptr<>nil then begin
      BitmapInfoHeader256:=ii^.ptr;
      l3ZeroMemory(BitmapInfoHeader256,sizeof(TBitmapInfoHeader256));
      with BitmapInfoHeader256^ do begin
         biSize:=sizeof(TBitmapInfoHeader);
         biWidth:=Width;
         biHeight:=Height;
         biPlanes:=1;
         biBitCount:=Bitcount;
         Palette[1].rgbRed:=255;
         Palette[1].rgbGreen:=255;
         Palette[1].rgbBlue:=255;
         biCompression:=BI_RGB;
      end;
      fInsPos:=ne;
   end;
   result:=true;
end;

function TIEVirtualDIBList.AddBitmap(bitmap:TBitmap):pointer;
var
   tbmp:TIEBitmap;
begin
   tbmp:=TIEBitmap.Create;
   tbmp.EncapsulateTBitmap(bitmap,true);
   result:=AddIEBitmap(tbmp);
   FreeAndNil(tbmp);
end;

// the image remains mapped
function TIEVirtualDIBList.AddIEBitmap(bitmap:TIEBaseBitmap):pointer;
var
   row:integer;
   pbmp:pbyte;
   ii:PIEVirtualImageInfo;
   rowlen:integer;
   bitcount:integer;
   iebmp:TIEBitmap;
   HasAlpha:boolean;
begin
	bitcount:=bitmap.BitCount;
   HasAlpha:= (bitmap is TIEBitmap) and ((bitmap as TIEBitmap).HasAlphaChannel);
	result:=AddBlankImage(bitmap.Width,bitmap.Height,bitcount,HasAlpha);
  	ii:=result;
   if (ii<>nil) and (ii^.ptr<>nil) then begin
      pbmp:=ii^.ptr;
      inc(pbmp,sizeof(TBitmapInfoHeader256));
      rowlen:= IEBitmapRowLen( bitmap.Width, bitcount ,32);
      for row:=0 to bitmap.height-1 do begin
         copymemory(pbmp,bitmap.Scanline[bitmap.height-row-1],rowlen);
         inc(pbmp,rowlen);
      end;
      if HasAlpha then begin
         // copy alpha channel
         rowlen:=IEBitmapRowLen( bitmap.Width,8 ,32);
         iebmp:=bitmap as TIEBitmap;
         pboolean(pbmp)^:=iebmp.Full;
         inc(pbmp,sizeof(boolean));
         for row:=0 to bitmap.height-1 do begin
            copymemory(pbmp,iebmp.AlphaChannel.Scanline[bitmap.height-row-1],rowlen);
            inc(pbmp,rowlen);
         end;
      end;
   end;
end;

// the image remains mapped
function TIEVirtualDIBList.AddBitmapRect(bitmap:TBitmap; xsrc,ysrc,dxsrc,dysrc:integer):pointer;
var
   pbmp:pbyte;
   ii:PIEVirtualImageInfo;
   rowlen:integer;
   bitcount:integer;
begin
	bitcount:=_Pixelformat2BitCount(bitmap.PixelFormat);
	result:=AddBlankImage(dxsrc,dysrc,bitcount,false);
   if result<>nil then begin
   	ii:=result;
      pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
      rowlen:= IEBitmapRowLen( dxsrc, bitcount ,32);
		IEBitmapMapXCopy(pbmp,rowlen,bitcount,bitmap,0,0,xsrc,ysrc,dxsrc,dysrc,1);
   end;
end;

// get the image from the memory mapped file (NOT FROM BmpToRelease!!)
procedure TIEVirtualDIBList.DirectCopyToBitmap(image:pointer; bitmap:TIEBitmap);
var
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   pbmp:pbyte;
   rowlen:dword;
   width,height,bitcount:integer;
   row:integer;
   ii:PIEVirtualImageInfo;
   pixfor:TIEPixelFormat;
begin
	ii:=image;
   //MapImage(ii,[iedRead,iedWrite]);
   MapImage(ii,[iedRead]);
   if ii^.ptr<>nil then begin
      BitmapInfoHeader256:=ii^.ptr;
      pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
      width:=BitmapInfoHeader256^.biWidth;
      height:=BitmapInfoHeader256^.biHeight;
      bitcount:=BitmapInfoHeader256^.biBitCount;
      rowlen:=IEBitmapRowLen(width,bitcount,32);
      case bitcount of
         1: pixfor:=ie1g;
         else pixfor:=ie24RGB;
      end;
      if (bitmap.PixelFormat<>pixfor) or (bitmap.width<>width) or (bitmap.height<>height) then begin
      	bitmap.Allocate(width,height,pixfor);
      end;
      for row:=0 to height-1 do begin
         copymemory(bitmap.scanline[height-row-1],pbmp,rowlen);
         inc(pbmp,rowlen);
      end;
      // alpha channel
      if (not ii^.HasAlphaChannel) or pboolean(pbmp)^ then
      	bitmap.RemoveAlphaChannel
      else begin
      	// load alpha
         bitmap.AlphaChannel.Full:=pboolean(pbmp)^;
         inc(pbmp,sizeof(boolean));
         rowlen:=IEBitmapRowLen(width,8,32);
         for row:=0 to height-1 do begin
         	copymemory(bitmap.AlphaChannel.Scanline[height-row-1],pbmp,rowlen);
            inc(pbmp,rowlen);
         end;
      end;
   end;
end;

// can get the image from memory mapped or from BmpToRelease
procedure TIEVirtualDIBList.CopyToIEBitmap(image:pointer; bitmap:TIEBitmap);
var
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   pbmp:pbyte;
   rowlen:dword;
   width,height,bitcount:integer;
   row:integer;
   ii:PIEVirtualImageInfo;
   qidx:integer;
begin
	ii:=image;
   //MapImage(ii,[iedRead,iedWrite]);
   MapImage(ii,[iedRead]);
   if ii^.ptr<>nil then begin
   	qidx:=BmpToReleaseIndexOf(image);
		if qidx<0 then begin
         BitmapInfoHeader256:=ii^.ptr;
         pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
         width:=BitmapInfoHeader256^.biWidth;
         height:=BitmapInfoHeader256^.biHeight;
         bitcount:=BitmapInfoHeader256^.biBitCount;
         rowlen:=IEBitmapRowLen(width,bitcount,32);
         case bitcount of
            1: bitmap.Allocate(width,height,ie1g);
            24: bitmap.Allocate(width,height,ie24RGB);
         end;
         for row:=0 to height-1 do begin
            copymemory(bitmap.scanline[height-row-1],pbmp,rowlen);
            inc(pbmp,rowlen);
         end;
         // alpha channel
         if (not ii^.HasAlphaChannel) or pboolean(pbmp)^ then
            bitmap.RemoveAlphaChannel
         else begin
            // load alpha
            bitmap.AlphaChannel.Full:=pboolean(pbmp)^;
            inc(pbmp,sizeof(boolean));
            rowlen:=IEBitmapRowLen(width,8,32);
            for row:=0 to height-1 do begin
               copymemory(bitmap.AlphaChannel.Scanline[height-row-1],pbmp,rowlen);
               inc(pbmp,rowlen);
            end;
         end;
      end else begin
      	// stored in TBitmap
			bitmap.Assign( PIEVirtualToReleaseBmp(fBmpToRelease[qidx]).bmp );
			//bitmap.CopyFromTBitmap( PIEVirtualToReleaseBmp(fBmpToRelease[qidx]).bmp );
      end;
   end;
end;

(*
procedure TIEVirtualDIBList.CopyFromBitmap(image:pointer; bitmap:TBitmap);
var
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   pbmp:pbyte;
   rowlen:dword;
   width,height,bitcount:integer;
   row:integer;
   ii:PIEVirtualImageInfo;
   bmpbitcount:integer;
begin
	ii:=image;
   MapImage(ii);
   if ii^.ptr<>nil then begin
      BitmapInfoHeader256:=ii^.ptr;
      width:=BitmapInfoHeader256^.biWidth;
      height:=BitmapInfoHeader256^.biHeight;
      bitcount:=BitmapInfoHeader256^.biBitCount;
      bmpbitcount:=_PixelFormat2BitCount(bitmap.pixelformat);
      if (width<>bitmap.width) or (height<>bitmap.height) or (bmpbitcount<>bitcount) then begin
      	width:=bitmap.width;
         height:=bitmap.height;
         bitcount:=bmpbitcount;
			DiscardImage(ii);
         AllocImage(ii,width,height,bitcount); // changes ii^.ptr
      end;
      pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
      rowlen:=_BitmapRowLen(width,bitcount);
      for row:=0 to height-1 do begin
         copymemory(pbmp,bitmap.scanline[height-row-1],rowlen);
         inc(pbmp,rowlen);
      end;
   end;
end;
*)

procedure TIEVirtualDIBList.CopyFromIEBitmap(image:pointer; bitmap:TIEBitmap);
var
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   pbmp:pbyte;
   rowlen:dword;
   width,height,bitcount:integer;
   row:integer;
   ii:PIEVirtualImageInfo;
   bmpbitcount:integer;
begin
	//bitmap.updatefromtbitmap;

	ii:=image;
   MapImage(ii,[iedRead,iedWrite]);
   if ii^.ptr<>nil then begin
      BitmapInfoHeader256:=ii^.ptr;
      width:=BitmapInfoHeader256^.biWidth;
      height:=BitmapInfoHeader256^.biHeight;
      bitcount:=BitmapInfoHeader256^.biBitCount;
      bmpbitcount:=bitmap.BitCount;
      if (width<>bitmap.width) or (height<>bitmap.height) or (bmpbitcount<>bitcount) or (bitmap.HasAlphaChannel<>ii^.HasAlphaChannel) then begin
      	width:=bitmap.width;
         height:=bitmap.height;
         bitcount:=bmpbitcount;
			DiscardImage(ii);
         AllocImage(ii,width,height,bitcount,bitmap.HasAlphaChannel); // changes ii^.ptr
      end;
      pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
      rowlen:=IEBitmapRowLen(width,bitcount,32);
      for row:=0 to height-1 do begin
         copymemory(pbmp,bitmap.scanline[height-row-1],rowlen);
         inc(pbmp,rowlen);
      end;
      // alpha channel
      rowlen:=IEBitmapRowLen( bitmap.Width,8 ,32);
      if bitmap.HasAlphaChannel then begin
			// copy alpha channel
         pboolean(pbmp)^:=bitmap.Full;
         inc(pbmp,sizeof(boolean));
         for row:=0 to bitmap.height-1 do begin
            copymemory(pbmp,bitmap.AlphaChannel.Scanline[bitmap.height-row-1],rowlen);
            inc(pbmp,rowlen);
         end;
      end;
   end;
end;

function TIEVirtualDIBList.BmpToReleaseIndexOf(image:pointer):integer;
var
	q:integer;
begin
   result:=-1;
	for q:=0 to fBmpToRelease.Count-1 do
   	if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.info=image then begin
      	result:=q;
         break;
      end;
end;

// create a bitmap (must be released with ReleaseBitmap)
function TIEVirtualDIBList.GetBitmap(image:pointer):TIEBitmap;
var
	inf:PIEVirtualToReleaseBmp;
   qidx:integer;
begin
	result:=nil;
   //MapImage(image,[iedRead,iedWrite]);
   MapImage(image,[iedRead]);
   if PIEVirtualImageInfo(image)^.ptr<>nil then begin
      qidx:=BmpToReleaseIndexOf(image);
      if qidx<0 then begin
         result:=TIEBitmap.Create;
         new( inf );
         inf^.info:=image;
         inf^.bmp:=result;
         inf^.refcount:=1;
         fBmpToRelease.Add(inf);
         DirectCopyToBitmap(image,result);
      end else begin
         // already got
         inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
         inc( inf^.refcount );
         result:=inf^.bmp;
      end;
      PIEVirtualImageInfo(image)^.bitmapped:=true;
   end;
end;

// release a bitmap created by GetBitmap
// if changed is true copy the bitmap back to internal DIB
// warning: changed with refcount>1 should make changes lost
procedure TIEVirtualDIBList.ReleaseBitmap(bitmap:TIEBitmap; changed:boolean);
var
	q,idx:integer;
	inf:PIEVirtualToReleaseBmp;
begin
	if bitmap<>nil then begin
   	if (bitmap.Location=ieTBitmap) then
	   	bitmap.UpdateFromTBitmap;
   	//
      idx:=-1;
      for q:=0 to fBmpToRelease.Count-1 do
         if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.bmp=bitmap then begin
            idx:=q;
            break;
         end;
      if idx<0 then exit;
      inf:=PIEVirtualToReleaseBmp(fBmpToRelease[idx]);
      dec( inf^.refcount );
      if changed then begin
         // copy back
         CopyFromIEBitmap(inf^.info,bitmap);
      end;
      if inf^.refcount=0 then begin
         // free memory
         PIEVirtualImageInfo(inf^.info)^.bitmapped:=false;
         FreeAndNil(bitmap);
         dispose( inf );
         fBmpToRelease.Delete( idx );
      end;
   end;
end;

// release a bitmap created by GetBitmap
// if changed is true copy the bitmap back to internal DIB
// warning: changed with refcount>1 should make changes lost
procedure TIEVirtualDIBList.ReleaseBitmapByImage(image:pointer; changed:boolean);
var
	q,idx:integer;
begin
   idx:=-1;
	for q:=0 to fBmpToRelease.Count-1 do
   	if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.info=image then begin
      	idx:=q;
         break;
      end;
   if idx<0 then exit;
   ReleaseBitmap( PIEVirtualToReleaseBmp(fBmpToRelease[idx])^.bmp, changed);
end;

// render using DrawDibDraw
(*
procedure TIEVirtualDIBList.RenderTo(image:pointer; Canvas:TCanvas; hdd:THandle; xDst,yDst,dxDst,dyDst:dword; xSrc,ySrc,dxSrc,dySrc:dword);
var
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   pbmp:pbyte;
   ii:PIEVirtualImageInfo;
begin
	ii:=image;
   MapImage(ii);
   if ii^.ptr<>nil then begin
      BitmapInfoHeader256:=ii^.ptr;
      pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
      DrawDibDraw(hdd,Canvas.Handle,xDst,yDst,dxDst,dyDst,PBitmapInfoHeader(@BitmapInfoHeader256)^,pbmp,xSrc,ySrc,dxSrc,dySrc,0)
   end;
end;
*)

function TIEVirtualDIBList.GetImageCount:integer;
begin
	result:=fImageInfo.Count;
end;

function TIEVirtualDIBList.GetImageWidth(image:pointer):integer;
var
	ii:PIEVirtualImageInfo;
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	result:=0;
	ii:=image;
   if ii^.bitmapped then begin
   	qidx:=BmpToReleaseIndexOf(image);
		inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      result:=inf^.bmp.Width;
   end else begin
      //MapImage(ii,[iedRead,iedWrite]);
      MapImage(ii,[iedRead]);
      if ii^.ptr<>nil then begin
         BitmapInfoHeader256:=ii^.ptr;
         result:=BitmapInfoHeader256^.biWidth;
      end;
   end;
end;

function TIEVirtualDIBList.GetImageHeight(image:pointer):integer;
var
	ii:PIEVirtualImageInfo;
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	result:=0;
	ii:=image;
   if ii^.bitmapped then begin
   	qidx:=BmpToReleaseIndexOf(image);
		inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      result:=inf^.bmp.Height;
   end else begin
      //MapImage(ii,[iedRead,iedWrite]);
      MapImage(ii,[iedRead]);
      if ii^.ptr<>nil then begin
         BitmapInfoHeader256:=ii^.ptr;
         result:=BitmapInfoHeader256^.biHeight;
      end;
   end;
end;

function TIEVirtualDIBList.GetImageOriginalWidth(image:pointer):integer;
begin
   result:=PIEVirtualImageInfo(image)^.orig_width;
end;

function TIEVirtualDIBList.GetImageOriginalHeight(image:pointer):integer;
begin
   result:=PIEVirtualImageInfo(image)^.orig_height;
end;

procedure TIEVirtualDIBList.SetImageOriginalWidth(image:pointer; Value:integer);
begin
   PIEVirtualImageInfo(image)^.orig_width:=Value;
end;

procedure TIEVirtualDIBList.SetImageOriginalHeight(image:pointer; Value:integer);
begin
   PIEVirtualImageInfo(image)^.orig_height:=Value;
end;

function TIEVirtualDIBList.GetImageBitCount(image:pointer):integer;
var
	ii:PIEVirtualImageInfo;
	BitmapInfoHeader256:^TBitmapInfoHeader256;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	result:=0;
	ii:=image;
   if ii^.bitmapped then begin
   	qidx:=BmpToReleaseIndexOf(image);
		inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      result:=inf^.bmp.Bitcount;
   end else begin
      //MapImage(ii,[iedRead,iedWrite]);
      MapImage(ii,[iedRead]);
      if ii^.ptr<>nil then begin
         BitmapInfoHeader256:=ii^.ptr;
         result:=BitmapInfoHeader256^.biBitCount;
      end;
   end;
end;

// returned pointer is valid until next call to TIEVirtualDBList class
function TIEVirtualDIBList.GetImageBits(image:pointer):pointer;
var
	ii:PIEVirtualImageInfo;
   pbmp:pbyte;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	result:=nil;
	ii:=image;
   if ii^.bitmapped then begin
   	qidx:=BmpToReleaseIndexOf(image);
      if qidx>=0 then begin
         inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
         result:=inf^.bmp.scanline[ inf^.bmp.height-1 ];
      end;
   end else begin
      //MapImage(ii,[iedRead,iedWrite]);
      MapImage(ii,[iedRead]);
      if ii^.ptr<>nil then begin
         pbmp:=ii^.ptr; inc(pbmp,sizeof(TBitmapInfoHeader256));
         result:=pbmp;
      end;
   end;
end;

// returned pointer is valid until next call to TIEVirtualDBList class
function TIEVirtualDIBList.GetAlphaBits(image:pointer):pointer;
var
	ii:PIEVirtualImageInfo;
   pbmp:pbyte;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
   head:PBitmapInfoHeader256;
begin
	result:=nil;
	ii:=image;
   if ii^.HasAlphaChannel then begin
      if ii^.bitmapped then begin
         qidx:=BmpToReleaseIndexOf(image);
         if qidx>=0 then begin
            inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
            if inf^.bmp.HasAlphaChannel then
               result:=inf^.bmp.AlphaChannel.scanline[ inf^.bmp.height-1 ]
            else
               result:=nil;
         end;
      end else begin
         //MapImage(ii,[iedRead,iedWrite]);
         MapImage(ii,[iedRead]);
         if ii^.ptr<>nil then begin
            head:=PBitmapInfoHeader256(ii^.ptr);
            pbmp:=ii^.ptr;
            inc(pbmp,sizeof(TBitmapInfoHeader256)+IEBitmapRowLen(head^.biWidth,head^.biBitcount,32)*head^.biHeight);
            if pboolean(pbmp)^ then
               result:=nil
            else begin
               inc(pbmp,sizeof(boolean));
               result:=pbmp;
            end;
         end;
      end;
   end;
end;


// returned pointer is valid until next call to TIEVirtualDBList class
function TIEVirtualDIBList.GetImageInfoHeader(image:pointer):PBitmapInfoHeader256;
var
	ii:PIEVirtualImageInfo;
   qidx:integer;
   inf:PIEVirtualToReleaseBmp;
begin
	ii:=image;
   if ii^.bitmapped then begin
      qidx:=BmpToReleaseIndexOf(image);
      inf:=PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      // temporaney use of fTempBitmapInfoHeader256
      with fTempBitmapInfoHeader256 do begin
         biSize:=sizeof(TBitmapInfoHeader);
         biWidth:=inf^.bmp.Width;
         biHeight:=inf^.bmp.Height;
         biPlanes:=1;
         //biBitCount:=_PixelFormat2BitCount(inf^.bmp.PixelFormat);
         biBitCount:=inf^.bmp.Bitcount;
         Palette[1].rgbRed:=255;
         Palette[1].rgbGreen:=255;
         Palette[1].rgbBlue:=255;
         biCompression:=BI_RGB;
      end;
      result:=@fTempBitmapInfoHeader256;
   end else begin
      MapImage(ii,[iedRead,iedWrite]);
      result:=ii^.ptr;
   end;
end;

procedure TIEVirtualDIBList.Delete(image:pointer);
var
	fb:PIEVirtualFreeBlock;
   ii:PIEVirtualImageInfo;
begin
	// make a new entry in the free blocks list (fFreeBlocks)
	ii:=image;
	new( fb );
   fb^.pos:=ii^.pos;
   fb^.vsize:=ii^.vsize;
   fFreeBlocks.Add( fb );
   //
	RemoveImageInfo( fImageInfo.IndexOf(image) );
   if fImageInfo.Count=0 then begin
   	fSize:=fAllocationBlock;
	   fInsPos:=0;
      ReAllocateBits;
   end;
end;

(*$endif*)


// end of TIEVirtualDIBArray
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


// Sum two 64 bit values, return one 64 value
// return also the carry
// probably there is a better method...
function IEAdd64(op1_lo,op1_hi,op2_lo,op2_hi:dword; result_lo,result_hi:pdword):integer;
var
	v32:dword;
   c:byte;
   q:integer;
begin
	result_lo^:=0;
   result_hi^:=0;
	// low
	c:=0;
	for q:=0 to 3 do begin
      v32:=pbytearray(@op1_lo)[q]+pbytearray(@op2_lo)[q]+c;
      pbytearray(result_lo)[q]:=v32 and $FF;
      if v32>255 then c:=1 else c:=0;
   end;
	// hi
	for q:=0 to 3 do begin
      v32:=pbytearray(@op1_hi)[q]+pbytearray(@op2_hi)[q]+c;
      pbytearray(result_hi)[q]:=v32 and $FF;
      if v32>255 then c:=1 else c:=0;
   end;
   result:=c;
end;

// return true if op1>op2
// probably there is a better method...
function IEGreater64(op1_lo,op1_hi,op2_lo,op2_hi:dword):boolean;
var
	q:integer;
   o1,o2:byte;
begin
	result:=false;
	// hi
	for q:=3 downto 0 do begin
   	o1:=pbytearray(@op1_hi)[q];
      o2:=pbytearray(@op2_hi)[q];
   	if o1>o2 then begin
      	result:=true;
         exit;
      end else if o1<o2 then
      	exit;
   end;
   // low
	for q:=3 downto 0 do begin
   	o1:=pbytearray(@op1_lo)[q];
      o2:=pbytearray(@op2_lo)[q];
   	if o1>o2 then begin
      	result:=true;
         exit;
      end else if o1<o2 then
      	exit;
   end;
end;

procedure IEMul64(op1,op2:dword; resultlo:pdword; resulthi:pdword);
var
	lo,hi:dword;
begin
	asm
   	push edx
      push eax
		mov eax,op1
      mul op2
      mov lo,eax
      mov hi,edx
      pop eax
      pop edx
   end;
   resultlo^:=lo;
   resulthi^:=hi;
end;

//
procedure SafeStreamWrite(Stream:TStream; var Aborting:boolean; const Buffer; Count:Longint);
begin
	if Stream.Write(Buffer,Count)<Count then
   	Aborting:=true;
end;

// copy a bitmap/map to a map/bitmap
// dir:  0=map to bitmap
//       1=bitmap to map
// map and bitmap must have some pixel format: exception for from bitmap (pf1bit) to map (24 bit)
procedure IEBitmapMapXCopy(map:pbyte; maprowlen:dword; mapbitcount:dword; bitmap:TBitmap; mapx,mapy,bitmapx,bitmapy,dx,dy:dword; dir:integer);
var
	s1,d1:pbyte;
   rgb:PRGB;
   yy,xx:integer;
   rl:integer;
begin
	case dir of
   	0:
      	begin
            // copy from map to bitmap
            s1:=map;
            inc(s1,maprowlen*mapy);
            case bitmap.PixelFormat of
               pf1bit:
                  begin
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        _CopyBits(bitmap.Scanline[yy],s1,bitmapx,mapx,dx,maprowlen);
                        inc(s1,maprowlen);
                     end;
                  end;
               pf8bit:
                  begin
                     inc(s1,mapx);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx);
                        CopyMemory(d1,s1,dx);
                        inc(s1,maprowlen);
                     end;
                  end;
               pf24bit:
                  begin
                     inc(s1,mapx*3);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx*3);
                        CopyMemory(d1,s1,dx*3);
                        inc(s1,maprowlen);
                     end;
                  end;
            end;
         end;
      1:
      	begin
            // copy from bitmap to map
            s1:=map;
            inc(s1,maprowlen*mapy);
            case bitmap.PixelFormat of
               pf1bit:
                  begin
                  	if mapbitcount=24 then begin
                     	// convert 1bit to 24bit
                        inc(s1,mapx*3);
                        for yy:=bitmapy+dy-1 downto bitmapy do begin
                        	rgb:=PRGB(s1);
                           d1:=bitmap.scanline[yy];
                        	for xx:=bitmapx to bitmapx+dx-1 do begin
                           	with rgb^ do
	                           	if _getpixelbw(d1,xx)<>0 then begin
                                 	r:=255;
                                    g:=255;
                                    b:=255;
                                 end else begin
                                 	r:=0;
                                    g:=0;
                                    b:=0;
                                 end;
                           	inc(rgb);
                           end;
                           inc(s1,maprowlen);
                        end;
                     end else begin
                     	rl:=_PixelFormat2RowLen(bitmap.width,bitmap.pixelformat);
                        for yy:=bitmapy+dy-1 downto bitmapy do begin
                           _CopyBits(s1,bitmap.Scanline[yy],mapx,bitmapx,dx,rl);
                           inc(s1,maprowlen);
                        end;
                     end;
                  end;
               pf8bit:
                  begin
                     inc(s1,mapx);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx);
                        CopyMemory(s1,d1,dx);
                        inc(s1,maprowlen);
                     end;
                  end;
               pf24bit:
                  begin
                     inc(s1,mapx*3);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx*3);
                        CopyMemory(s1,d1,dx*3);
                        inc(s1,maprowlen);
                     end;
                  end;
            end;
         end;
   end;
end;

// copy a bitmap/map to a map/bitmap
// dir:  0=map to bitmap
//       1=bitmap to map
// map and bitmap must have some pixel format: exception for from bitmap (ie1g) to map (ie24RGB)
procedure IEBitmapMapXCopyEx(map:pbyte; maprowlen:dword; mapbitcount:dword; bitmap:TIEBitmap; mapx,mapy,bitmapx,bitmapy,dx,dy:dword; dir:integer);
var
	s1,d1:pbyte;
   rgb:PRGB;
   yy,xx:integer;
begin
	case dir of
   	0:
      	begin
            // copy from map to bitmap
            s1:=map;
            inc(s1,maprowlen*mapy);
            case bitmap.PixelFormat of
               ie1g:
                  begin
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        _CopyBits(bitmap.Scanline[yy],s1,bitmapx,mapx,dx,maprowlen);
                        inc(s1,maprowlen);
                     end;
                  end;
               ie8g, ie8p:
                  begin
                     inc(s1,mapx);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx);
                        CopyMemory(d1,s1,dx);
                        inc(s1,maprowlen);
                     end;
                  end;
               ie24RGB:
                  begin
                     inc(s1,mapx*3);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx*3);
                        CopyMemory(d1,s1,dx*3);
                        inc(s1,maprowlen);
                     end;
                  end;
            end;
         end;
      1:
      	begin
            // copy from bitmap to map
            s1:=map;
            inc(s1,maprowlen*mapy);
            case bitmap.PixelFormat of
               ie1g:
                  begin
                  	if mapbitcount=24 then begin
                     	// convert 1bit to 24bit
                        inc(s1,mapx*3);
                        for yy:=bitmapy+dy-1 downto bitmapy do begin
                        	rgb:=PRGB(s1);
                           d1:=bitmap.scanline[yy];
                        	for xx:=bitmapx to bitmapx+dx-1 do begin
                           	with rgb^ do
	                           	if _getpixelbw(d1,xx)<>0 then begin
                                 	r:=255;
                                    g:=255;
                                    b:=255;
                                 end else begin
                                 	r:=0;
                                    g:=0;
                                    b:=0;
                                 end;
                           	inc(rgb);
                           end;
                           inc(s1,maprowlen);
                        end;
                     end else
                        for yy:=bitmapy+dy-1 downto bitmapy do begin
                           _CopyBits(s1,bitmap.Scanline[yy],mapx,bitmapx,dx,bitmap.RowLen);
                           inc(s1,maprowlen);
                        end;
                  end;
               ie8g, ie8p:
                  begin
                     inc(s1,mapx);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx);
                        CopyMemory(s1,d1,dx);
                        inc(s1,maprowlen);
                     end;
                  end;
               ie24RGB:
                  begin
                     inc(s1,mapx*3);
                     for yy:=bitmapy+dy-1 downto bitmapy do begin
                        d1:=bitmap.Scanline[yy];
                        inc(d1,bitmapx*3);
                        CopyMemory(s1,d1,dx*3);
                        inc(s1,maprowlen);
                     end;
                  end;
            end;
         end;
   end;
end;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEDibBitmap

(*$ifdef IEDELPHI*)

constructor TIEDibBitmap.Create;
begin
	inherited Create;
	fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fHDC:=0;
   fDIB:=0;
   fBits:=nil;
	l3ZeroMemory(@fBitmapInfoHeader1,sizeof(TBitmapInfoHeader256));
   with fBitmapInfoHeader1 do begin
      biSize:=sizeof(TBitmapInfoHeader);
      biPlanes:=1;
      Palette[1].rgbRed:=255;
      Palette[1].rgbGreen:=255;
      Palette[1].rgbBlue:=255;
      biCompression:=BI_RGB;
   end;
end;

procedure TIEDibBitmap.Cleanup;
begin
	FreeBits;
	inherited;
end;

function TIEDibBitmap.GetBitCount:integer;
begin
   result:=fBitCount;
end;

function TIEDibBitmap.GetWidth:integer;
begin
   result:=fWidth;
end;

function TIEDibBitmap.GetHeight:integer;
begin
   result:=fHeight;
end;

function TIEDibBitmap.GetPixelFormat:TIEPixelFormat;
begin
   case fBitCount of
      1: result:=ie1g;
      24: result:=ie24RGB;
      else result:=ienull;
   end;
end;

function TIEDibBitmap.GetRowLen:integer;
begin
   result:=fRowLen;
end;

procedure TIEDibBitmap.Allocate(ImageWidth,ImageHeight:integer; ImagePixelFormat:TIEPixelFormat);
begin
   if ImagePixelFormat=ie1g then
      AllocateBits(ImageWidth,ImageHeight,1)
   else if ImagePixelFormat=ie24RGB then
      AllocateBits(ImageWidth,ImageHeight,24);
end;

procedure TIEDibBitmap.AllocateBits(BmpWidth,BmpHeight,BmpBitCount:dword);
begin
   if (BmpWidth>0) and (BmpHeight>0) (*and ((BmpBitCount=1) or (BmpBitCount=24))*) then begin
      FreeBits;
      fBitCount:=BmpBitCount;
      fWidth:=BmpWidth;
      fHeight:=BmpHeight;
      fRowLen:=IEBitmapRowLen(fWidth,BmpBitCount,32);
      fHDC:=CreateCompatibleDC(0);
      with fBitmapInfoHeader1 do begin
         biBitCount:=BmpBitCount;
         biWidth:=BmpWidth;
         biHeight:=BmpHeight;
         biSizeImage:=fRowLen*fHeight;
      end;
      fDIB:=CreateDIBSection(fHDC,PBITMAPINFO(@fBitmapInfoHeader1)^,DIB_RGB_COLORS,fBits,0,0);
      SelectObject(fHDC,fDIB);
   end;
end;

procedure TIEDibBitmap.FreeBits;
begin
	if fDIB<>0 then
   	DeleteObject(fDIB);
   fDIB:=0;
   if fHDC<>0 then
		DeleteDC(fHDC);
   fHDC:=0;
   fBits:=nil;
	fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
end;

function TIEDibBitmap.GetScanline(row:integer):pointer;
begin
	result:=pointer(dword(fBits)+(fHeight-dword(row)-1)*fRowlen);
end;

procedure TIEDibBitmap.CopyToTBitmap(Dest:TBitmap);
var
   row:integer;
begin
   Dest.Width:=1; Dest.Height:=1;
   case fBitCount of
      1:  Dest.PixelFormat:=pf1bit;
      24: Dest.PixelFormat:=pf24bit;
   end;
   Dest.Width:=fWidth; Dest.Height:=fHeight;
   for row:=0 to fHeight-1 do
   	CopyMemory(Dest.Scanline[row],Scanline[row],fRowLen);
end;

// only for TIEDibBitmap
procedure TIEDibBitmap.Assign(Source:TObject);
var
   src:TIEDibBitmap;
begin
   if Source is TIEDibBitmap then begin
      src:=Source as TIEDibBitmap;
      AllocateBits(src.Width,src.Height,src.BitCount);
      CopyMemory(fBits,src.fBits,fRowlen*fHeight);
   end;
end;

(*$endif*)

// end of TIEDibBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEWorkBitmap

constructor TIEWorkBitmap.Create(BmpWidth,BmpHeight,BmpBitCount:integer);
begin
	inherited Create;
   fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fRowLen:=0;
   fBits:=nil;
   if (BmpWidth>0) and (BmpHeight>0) then
		AllocateBits(BmpWidth,BmpHeight,BmpBitCount);
end;

procedure TIEWorkBitmap.Cleanup;
begin
	FreeBits;
	inherited;
end;

function TIEWorkBitmap.GetScanline(row:integer):pointer;
begin
	result:=pointer(dword(fBits)+dword((fHeight-row-1)*fRowlen));
end;

function TIEWorkBitmap.GetPByte(row,col:integer):pbyte;
begin
   result:=pbyte(dword(fBits)+dword((fHeight-row-1)*fRowlen+col));
end;

function TIEWorkBitmap.GetPRGB(row,col:integer):PRGB;
begin
	result:=PRGB(dword(fBits)+dword((fHeight-row-1)*fRowlen+col*3));
end;

function TIEWorkBitmap.GetPDouble(row,col:integer):PDouble;
begin
	result:=PDouble(dword(fBits)+dword((fHeight-row-1)*fRowlen+col*8));
end;

function TIEWorkBitmap.GetPSingle(row,col:integer):PSingle;
begin
   result:=PSingle(dword(fBits)+dword((fHeight-row-1)*fRowlen+col*4));
end;

function TIEWorkBitmap.GetPInteger(row,col:integer):pinteger;
begin
	result:=pinteger(dword(fBits)+dword((fHeight-row-1)*fRowlen+col*4));
end;

procedure TIEWorkBitmap.SetBit(row,col:integer; value:integer);
var
   bp:pbyte;
begin
	bp:=pbyte(dword(fBits)+dword((fHeight-row-1)*fRowlen+(col shr 3)));
   if value<>0 then
		bp^:=bp^ or iebitmask1[col and 7]
   else
   	bp^:=bp^ and not iebitmask1[col and 7];
end;

procedure TIEWorkBitmap.AllocateBits(BmpWidth,BmpHeight,BmpBitCount:integer);
begin
	if (BmpWidth<>fWidth) or (BmpHeight<>fHeight) or (BmpBitCount<>fBitCount) then begin
      FreeBits;
      fBitCount:=BmpBitCount;
      fWidth:=BmpWidth;
      fHeight:=BmpHeight;
      fRowLen:=IEBitmapRowLen(fWidth,BmpBitCount,32);
      getmem(fBits,fRowLen*fHeight);
   end;
end;

procedure TIEWorkBitmap.FreeBits;
begin
	if fBits<>nil then
   	freemem(fBits);
   fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fRowLen:=0;
   fBits:=nil;
end;

// TIEWorkBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// EXIF SUPPORT FUNCTIONS

procedure CopyEXIF(source,dest:TIOParamsVals);
var
	q:integer;
begin
   dest.EXIF_ImageDescription:=source.TIFF_ImageDescription;
   dest.EXIF_Make:=source.EXIF_Make;
   dest.EXIF_Model:=source.EXIF_Model;
   dest.EXIF_Orientation:=source.EXIF_Orientation;
   dest.EXIF_XResolution:=source.EXIF_XResolution;
   dest.EXIF_YResolution:=source.EXIF_YResolution;
   dest.EXIF_ResolutionUnit:=source.EXIF_ResolutionUnit;
   dest.EXIF_Software:=source.EXIF_Software;
   dest.EXIF_DateTime:=source.EXIF_DateTime;
   dest.EXIF_WhitePoint[0]:=source.EXIF_WhitePoint[0];
   dest.EXIF_WhitePoint[1]:=source.EXIF_WhitePoint[1];
   for q:=0 to 5 do
   	dest.EXIF_PrimaryChromaticities[q]:=source.EXIF_PrimaryChromaticities[q];
   for q:=0 to 2 do
   	dest.EXIF_YCbCrCoefficients[q]:=source.EXIF_YCbCrCoefficients[q];
   dest.EXIF_YCbCrPositioning:=source.EXIF_YCbCrPositioning;
	for q:=0 to 5 do
   	dest.EXIF_ReferenceBlackWhite[q]:=source.EXIF_ReferenceBlackWhite[q];
   dest.EXIF_Copyright:=source.EXIF_Copyright;
   dest.EXIF_ExposureTime:=source.EXIF_ExposureTime;
   dest.EXIF_FNumber:=source.EXIF_FNumber;
   dest.EXIF_ExposureProgram:=source.EXIF_ExposureProgram;
   dest.EXIF_ISOSpeedRatings[0]:=source.EXIF_ISOSpeedRatings[0];
   dest.EXIF_ISOSpeedRatings[1]:=source.EXIF_ISOSpeedRatings[1];
   dest.EXIF_ExifVersion:=source.EXIF_ExifVersion;
   dest.EXIF_DateTimeOriginal:=source.EXIF_DateTimeOriginal;
   dest.EXIF_DateTimeDigitized:=source.EXIF_DateTimeDigitized;
   dest.EXIF_CompressedBitsPerPixel:=source.EXIF_CompressedBitsPerPixel;
   dest.EXIF_ShutterSpeedValue:=source.EXIF_ShutterSpeedValue;
   dest.EXIF_ApertureValue:=source.EXIF_ApertureValue;
   dest.EXIF_BrightnessValue:=source.EXIF_BrightnessValue;
   dest.EXIF_ExposureBiasValue:=source.EXIF_ExposureBiasValue;
   dest.EXIF_MaxApertureValue:=source.EXIF_MaxApertureValue;
   dest.EXIF_SubjectDistance:=source.EXIF_SubjectDistance;
   dest.EXIF_MeteringMode:=source.EXIF_MeteringMode;
   dest.EXIF_LightSource:=source.EXIF_LightSource;
   dest.EXIF_Flash:=source.EXIF_Flash;
   dest.EXIF_FocalLength:=source.EXIF_FocalLength;
   dest.EXIF_SubsecTime:=source.EXIF_SubsecTime;
   dest.EXIF_SubsecTimeOriginal:=source.EXIF_SubsecTimeOriginal;
   dest.EXIF_SubsecTimeDigitized:=source.EXIF_SubsecTimeDigitized;
   dest.EXIF_FlashPixVersion:=source.EXIF_FlashPixVersion;
   dest.EXIF_ColorSpace:=source.EXIF_ColorSpace;
   dest.EXIF_ExifImageWidth:=source.EXIF_ExifImageWidth;
   dest.EXIF_ExifImageHeight:=source.EXIF_ExifImageHeight;
   dest.EXIF_RelatedSoundFile:=source.EXIF_RelatedSoundFile;
   dest.EXIF_FocalPlaneXResolution:=source.EXIF_FocalPlaneXResolution;
   dest.EXIF_FocalPlaneYResolution:=source.EXIF_FocalPlaneYResolution;
   dest.EXIF_FocalPlaneResolutionUnit:=source.EXIF_FocalPlaneResolutionUnit;
   dest.EXIF_ExposureIndex:=source.EXIF_ExposureIndex;
   dest.EXIF_SensingMethod:=source.EXIF_SensingMethod;
   dest.EXIF_FileSource:=source.EXIF_FileSource;
   dest.EXIF_SceneType:=source.EXIF_SceneType;
   dest.EXIF_UserComment:=source.EXIF_UserComment;
   dest.EXIF_UserCommentCode:=source.EXIF_UserCommentCode;
end;

// return a  pointer (to free!)
procedure SaveEXIFToStandardBuffer(params:TObject; var Buffer:pointer; var BufferLength:integer);
const
	EXF='Exif'#0#0;
var
	ioparams:TIOParamsVals;
   ms:TMemoryStream;
   nullpr:TProgressRec;
   fAbort:boolean;
begin
	fAbort:=false;
   with nullpr do begin
	   Aborting:=@fAbort;
      fOnProgress:=nil;
      Sender:=nil;
	end;
	ioparams:=TIOParamsVals(Params);
	ms:=TMemoryStream.Create;
	TIFFWriteStream(ms,false,nil,ioparams,nullpr);
   BufferLength:=ms.Size+6;
	getmem(Buffer,BufferLength);
   l3move(EXF[1],pbyte(Buffer)^,6);
   l3move(pbyte(ms.Memory)^,PAnsiChar(Buffer)[6],BufferLength-6);
   FreeAndNil(ms);
end;

function LoadEXIFFromStandardBuffer(Buffer:pointer; BufferLength:integer; params:TObject):boolean;
var
	ioparams:TIOParamsVals;
   tmpio:TIOParamsVals;
   ms:TMemoryStream;
   numi:integer;
   nullpr:TProgressRec;
   fAbort:boolean;
   tempAlphaChannel:TIEMask;
begin
	result:=false;
   if PAnsiChar(Buffer)<>'Exif' then exit;
	//
   ioparams:=TIOParamsVals(Params);
	tmpio:=TIOParamsVals.Create(ioparams.ImageEnIO);
   ms:=TMemoryStream.Create;
   ms.Write(pbytearray(Buffer)[6],BufferLength-6);
   ms.position:=0;
	fAbort:=false;
   with nullpr do begin
	   Aborting:=@fAbort;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   // load data
   if not assigned(ioparams.EXIF_Bitmap) then begin
   	ioparams.EXIF_Bitmap:=TIEBitmap.Create;
   end;
   tempAlphaChannel:=nil;
	TIFFReadStream(ioparams.EXIF_Bitmap,ms,numi,tmpio,nullpr,false,tempAlphaChannel,true,true,false);
   CopyEXIF(tmpio,ioparams);
   ioparams.EXIF_HasEXIFData:=true;
   // load thumbnail
   tmpio.TIFF_ImageIndex:=1;
   ms.position:=0;
   fAbort:=false;
   if not assigned(ioparams.EXIF_Bitmap) then begin
   	ioparams.EXIF_Bitmap:=TIEBitmap.Create;
   end;
   tempAlphaChannel:=nil;
   TIFFReadStream(ioparams.EXIF_Bitmap,ms,numi,tmpio,nullpr,false,tempAlphaChannel,true,true,true);
   FreeAndNil(ms);
   //
   FreeAndNil(tmpio);
	result:=true;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

(*$ifdef IEDELPHI*)
function IEIs_Win2000_ME_XP:boolean;
var
	ver:TOSVersionInfo;
begin
   result:=false;
   ver.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);
   if not GetVersionEx(ver) then
   	Exit;
   if (ver.dwPlatformId=VER_PLATFORM_WIN32_NT) and (ver.dwMajorVersion>=5) then
   	result:=true	// win 2k
   else if (ver.dwPlatformId=VER_PLATFORM_WIN32_WINDOWS) and (ver.dwMajorVersion>=4) and (ver.dwMinorVersion>=90) then
   	result:=true;	// win ME
end;
(*$endif*)

(*$ifdef IEDELPHI*)
function IEIs_XP:boolean;
var
	ver:TOSVersionInfo;
begin
   result:=false;
   ver.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);
   if not GetVersionEx(ver) then
   	Exit;
   result:=(ver.dwPlatformId=VER_PLATFORM_WIN32_NT) and (ver.dwMajorVersion=5) and (ver.dwMinorVersion=1);
end;
(*$endif*)

(*$ifdef IEDELPHI*)
function IEIs_98:boolean;
var
	ver:TOSVersionInfo;
begin
   result:=false;
   ver.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);
   if not GetVersionEx(ver) then
   	Exit;
   result:=(ver.dwPlatformId=VER_PLATFORM_WIN32_WINDOWS) and (ver.dwMajorVersion=4) and (ver.dwMinorVersion=10);
end;
(*$endif*)

function IEStrToFloatDef(s:AnsiString; Def:extended):extended;
var
	q:integer;
begin
	if not TextToFloat(PAnsiChar(s),result,fvExtended) then begin
   	q:=pos(',',s);
      if q>0 then
      	s[q]:='.'
      else begin
			q:=pos('.',s);
         if q>0 then
         	s[q]:=',';
      end;
      if not TextToFloat(PAnsiChar(s),result,fvExtended) then
      	result:=Def;
   end;
end;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

(*
// use opt=true on when fBackgroundstyle=iebsSolid
procedure IEStretchBmpWithAlpha(SrcBitmap,DstBitmap:TBitmap; Alpha:TIEMask; xs1,ys1,xs2,ys2,xd1,yd1,xd2,yd2:integer; opt:boolean);
	procedure IEStretchBmpWithAlpha_Stretch24(x1,x2,y1,y2,yr,yw:integer);
   var
   	dx,dy,e,d,dx2:integer;
      src,dst:PRGB;
      alp:pbyte;
      a:integer;
	   sr,sg,sb:integer;
   begin
   	dx:=x2-x1;
      dy:=y2-y1;
      e:=(dy shl 1)-dx;
      dx2:=dx shl 1;
      dy:=dy shl 1;
      src:=SrcBitmap.scanline[yr];
      dst:=Dstbitmap.scanline[yw];
      alp:=Alpha.scanline[yr];
      dx:=imin(dx,dstbitmap.width-1);
      inc(alp,y1);
      inc(src,y1);
      inc(dst,x1);
      for d:=0 to dx do begin
         a:=alp^ shl 10;
         with src^ do begin
            sr:=r;
            sg:=g;
            sb:=b;
         end;
         with dst^ do begin
            r:=(a*(sr-r) shr 18 +r);
            g:=(a*(sg-g) shr 18 +g);
            b:=(a*(sb-b) shr 18 +b);
         end;
         while(e>=0) do begin
         	inc(alp);
            inc(src);
            dec(e,dx2);
         end;
         inc(dst);
         inc(e,dy);
      end;
   end;
	procedure IEStretchBmpWithAlpha_Stretch1(x1,x2,y1,y2,yr,yw:integer);
   var
   	dx,dy,e,d,dx2:integer;
      dst:PRGB;
      src:pbytearray;
      alp:pbyte;
      a:integer;
   begin
   	dx:=x2-x1;
      dy:=y2-y1;
      e:=(dy shl 1)-dx;
      dx2:=dx shl 1;
      dy:=dy shl 1;
      src:=SrcBitmap.scanline[yr];
      dst:=Dstbitmap.scanline[yw];
      alp:=Alpha.scanline[yr];
      dx:=imin(dx,dstbitmap.width-1);
      inc(alp,y1);
      inc(dst,x1);
      for d:=0 to dx do begin
         a:=alp^ shl 10;
         if (src^[y1 shr 3] and iebitmask1[y1 and $7])=0 then with dst^ do begin
            r:=(a*(0-r) shr 18 +r);
            g:=r;
            b:=r;
         end else with dst^ do begin
            r:=(a*(255-r) shr 18 +r);
            g:=r;
            b:=r;
         end;
         while(e>=0) do begin
         	inc(alp);
            inc(y1);
            dec(e,dx2);
         end;
         inc(dst);
         inc(e,dy);
      end;
   end;
var
	dx,dy,e,d,dx2:integer;
   l:integer;
   rl:integer;
begin
	dx:=yd2-yd1;
   dy:=ys2-ys1;
   e:=(dy shl 1)-dx;
   dx2:=dx shl 1;
   dy:=dy shl 1;
   l:=-1;
   rl:=_PixelFormat2RowLen(dstbitmap.width,dstbitmap.pixelformat);
   for d:=0 to dx do begin
      if ys1>=srcbitmap.height then ys1:=srcbitmap.height-1;
      if yd1>=dstbitmap.height then yd1:=dstbitmap.height-1;
   	if (ys1=l) and opt then begin
      	copymemory(dstbitmap.scanline[yd1],dstbitmap.scanline[yd1-1],rl);
      end else begin
      	case srcbitmap.pixelformat of
         	pf24bit:
			   	IEStretchBmpWithAlpha_Stretch24(xd1,xd2,xs1,xs2,ys1,yd1);
            pf1bit:
					IEStretchBmpWithAlpha_Stretch1(xd1,xd2,xs1,xs2,ys1,yd1);
         end;
	      l:=ys1;
      end;
      while e>=0 do begin
      	inc(ys1);
         dec(e,dx2);
      end;
      inc(yd1);
      inc(e,dy);
   end;
end;

// use opt=true on when fBackgroundstyle=iebsSolid
procedure IEStretchBmp(SrcBitmap,DstBitmap:TBitmap; xs1,ys1,xs2,ys2,xd1,yd1,xd2,yd2:integer; opt:boolean);
	procedure IEStretchBmp_Stretch24(x1,x2,y1,y2,yr,yw:integer);
   var
   	dx,dy,e,d,dx2:integer;
      src,dst:PRGB;
   begin
   	dx:=x2-x1;
      dy:=y2-y1;
      e:=(dy shl 1)-dx;
      dx2:=dx shl 1;
      dy:=dy shl 1;
      src:=SrcBitmap.scanline[yr];
      dst:=Dstbitmap.scanline[yw];
      dx:=imin(dx,dstbitmap.width-1);
      inc(src,y1);
      inc(dst,x1);
      for d:=0 to dx do begin
      	dst^:=src^;
         while(e>=0) do begin
            inc(src);
            dec(e,dx2);
         end;
         inc(dst);
         inc(e,dy);
      end;
   end;
	procedure IEStretchBmp_Stretch1(x1,x2,y1,y2,yr,yw:integer);
   var
   	dx,dy,e,d,dx2:integer;
      dst:PRGB;
      src:pbytearray;
   begin
   	dx:=x2-x1;
      dy:=y2-y1;
      e:=(dy shl 1)-dx;
      dx2:=dx shl 1;
      dy:=dy shl 1;
      src:=SrcBitmap.scanline[yr];
      dst:=Dstbitmap.scanline[yw];
      dx:=imin(dx,dstbitmap.width-1);
      inc(dst,x1);
      for d:=0 to dx do begin
         if (src^[y1 shr 3] and iebitmask1[y1 and $7])=0 then with dst^ do begin
            r:=0; g:=0; b:=0;
         end else with dst^ do begin
            r:=255; g:=255; b:=255;
         end;
         while(e>=0) do begin
            inc(y1);
            dec(e,dx2);
         end;
         inc(dst);
         inc(e,dy);
      end;
   end;
var
	dx,dy,e,d,dx2:integer;
   l:integer;
   rl:integer;
begin
	dx:=yd2-yd1;
   dy:=ys2-ys1;
   e:=(dy shl 1)-dx;
   dx2:=dx shl 1;
   dy:=dy shl 1;
   l:=-1;
   rl:=_PixelFormat2RowLen(dstbitmap.width,dstbitmap.pixelformat);
   for d:=0 to dx do begin
      if ys1>=srcbitmap.height then ys1:=srcbitmap.height-1;
      if yd1>=dstbitmap.height then yd1:=dstbitmap.height-1;
   	if (ys1=l) and opt then begin
      	copymemory(dstbitmap.scanline[yd1],dstbitmap.scanline[yd1-1],rl);
      end else begin
      	case srcbitmap.pixelformat of
         	pf24bit:
			   	IEStretchBmp_Stretch24(xd1,xd2,xs1,xs2,ys1,yd1);
            pf1bit:
					IEStretchBmp_Stretch1(xd1,xd2,xs1,xs2,ys1,yd1);
         end;
	      l:=ys1;
      end;
      while e>=0 do begin
      	inc(ys1);
         dec(e,dx2);
      end;
      inc(yd1);
      inc(e,dy);
   end;
end;
*)

// Converts RGB to CIELAB
// L: 0..255
// A: -127...127
// B: -127...127
function IERGB2CIELAB(rgb:TRGB):TIELAB;
var
	var_R,var_G,var_B:double;
   var_X,var_Y,var_Z:double;
   _l,_a,_b:double;
begin
	// rgb to xyz
	with rgb do begin
		var_R:=r/255;
      var_G:=g/255;
      var_B:=b/255;
   end;
	if (var_R > 0.03928) then
   	var_R := iepower(( ( var_R + 0.055 ) / 1.055 ) , 2.4)
	else
   	var_R := var_R / 12.92;
	if (var_G > 0.03928) then
   	var_G := iepower(( ( var_G + 0.055 ) / 1.055 ) , 2.4)
	else
   	var_G := var_G / 12.92;
   if (var_B > 0.03928) then
   	var_B := iepower(( ( var_B + 0.055 ) / 1.055 ) , 2.4)
	else
   	var_B := var_B / 12.92;
	var_R := var_R * 100;
	var_G := var_G * 100;
	var_B := var_B * 100;
	var_X := (var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805);
	var_Y := (var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722);
	var_Z := (var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505);
   // xyz to CIELAB
	if ( var_X > 0.008856 ) then
   	var_X := iepower(var_X , ( 1/3 ))
	else
   	var_X := ( 7.787 * var_X ) + ( 16 / 116 );
	if ( var_Y > 0.008856 ) then
   	var_Y := iepower( var_Y , ( 1/3 ) )
	else
   	var_Y := ( 7.787 * var_Y ) + ( 16 / 116 );
	if ( var_Z > 0.008856 ) then
   	var_Z := iepower( var_Z , ( 1/3 ) )
	else
   	var_Z := ( 7.787 * var_Z ) + ( 16 / 116 );
	with result do begin
		_L := (( 116 * var_Y ) - 16)/550*255;
		_a := (500 * ( var_X - var_Y ))/200*128;
		_b := (200 * ( var_Y - var_Z ))/500*128;
      if _L<0 then l:=0
      else if _L>255 then l:=255
      else l:=trunc(_L);
      if _a<-128 then a:=-128
      else if _a>127 then a:=127
      else a:=trunc(_a);
      if _b<-128 then b:=-128
      else if _b>127 then b:=127
      else b:=trunc(_b);
   end;
end;

// Converts CIELAB to RGB
// L: 0..255
// A: -127...127
// B: -127...127
function IECIELAB2RGB(const lab:TIELAB):TRGB;
var
	frac,tmp:double;
   x,y,z:double;
   l,a,b:double;
   rr,gg,bb:double;
begin
   l:=lab.l/255*100;
   a:=lab.a;
   if a=-128 then a:=128;
   b:=lab.b;
   if b=-128 then b:=128;
   a:=(a+127)/255*200-100;
   b:=(b+127)/255*200-100;
   // convert from LAB to XYZ
   frac := (L + 16) / 116;
   if ( L < 7.9996 ) then begin
      Y := L / 903.3;
      X := a / 3893.5 + Y;
      Z := Y - b / 1557.4;
   end else begin
      tmp := frac + a / 500;
      X := tmp * tmp * tmp;
      Y := frac * frac * frac;
      tmp := frac - b / 200;
      Z := tmp * tmp * tmp;
   end;
   // converts from XYZ to RGB (using D65 white point)
	rr:=+2.690*x -1.276*y -0.414*z;
   gg:=-1.022*x +1.978*y +0.044*z;
   bb:=+0.061*x -0.224*y +1.163*z;
	with result do begin
		if rr<=0 then r:=0
      else if rr>=1 then r:=255
   	else r:=trunc(256*sqrt(rr));
		if gg<=0 then g:=0
      else if gg>=1 then g:=255
   	else g:=trunc(256*sqrt(gg));
		if bb<=0 then b:=0
      else if bb>=1 then b:=255
   	else b:=trunc(256*sqrt(bb));
   end;
end;

// draw a 3d rect
procedure IEDraw3DRect(Canvas:TCanvas; x1,y1,x2,y2:integer; cl1,cl2:TColor);
begin
   with Canvas do begin
      Pen.Mode:=pmCopy;
      Pen.Style:=psSolid;
      Pen.Color:=cl1;
      MoveTo(x1,y2);
      LineTo(x1,y1);
      LineTo(x2,y1);
      Pen.Color:=cl2;
      MoveTo(x1,y2);
      LineTo(x2,y2);
      LineTo(x2,y1);
   end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEVirtualBitmap

(*$ifdef IEDELPHI*)

// Location:
//   ielTempFile : create in a temp directory a new file
//   ielPageFile : use system page file
// TempDirectory:
//   if empty uses windows temp directory
//   otherwise must be a full path ending with '\'
(*
constructor TIEVirtualBitmap.Create;
begin
	inherited Create;
   fmemmap:=TIEFileBuffer.Create;
   fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fXTileCount:=0;
   fYTileCount:=0;
   fTileWidth:=512;
   fTileHeight:=512;
   fWorkingTileX:=$ffff;
   fWorkingTileY:=$ffff;
   fWorkingMap:=nil;
	l3ZeroMemory(@fTempBitmapInfoHeader256,sizeof(TBitmapInfoHeader256));
   with fTempBitmapInfoHeader256 do begin
      biSize:=sizeof(TBitmapInfoHeader);
      biPlanes:=1;
      biBitCount:=1;
      Palette[1].rgbRed:=255;
      Palette[1].rgbGreen:=255;
      Palette[1].rgbBlue:=255;
      biCompression:=BI_RGB;
   end;
   fGotBitmaps:=TList.Create;
end;

destructor TIEVirtualBitmap.Destroy;
begin
	FreeBits;
   fmemmap.free;
   fGotBitmaps.free;	// the list must be empty
	inherited;
end;

// Supported SamplesPerpixel and BitsPerSample:
//    bitspersample  samplesperpixel
//         1               1
//         8               1
//         8               3
procedure TIEVirtualBitmap.AllocateBits(Width,Height:dword; BitCount:dword);
var
	ms:int64;
begin
	FreeBits;
   fWidth:=Width;
   fHeight:=Height;
   fBitCount:=BitCount;
   case fBitCount of
   	1:
         begin
            fTileWidth:= 1024;
            fTileHeight:= 512;
         end;
      8:
         begin
            fTileWidth:= 256;
            fTileHeight:= 256;
         end;
      24:
         begin
            fTileWidth:= 512;
            fTileHeight:= 512;
         end;
   end;
   fXTileCount:=(fWidth+fTileWidth-1) div fTileWidth;
   fYTileCount:=(fHeight+fTileHeight-1) div fTileHeight;
   fTileRowLen:=IEBitmapRowLen(fTileWidth,fBitCount,32);
   ms:= fTileRowLen*fXTileCount * fTileHeight*fYTileCount;
   fmemmap.AllocateFile('',ms);
end;

procedure TIEVirtualBitmap.FreeBits;
begin
	// unmap bitmaps
   while fGotBitmaps.Count>0 do
   	ReleaseBitmap( PIEGotBitmap(fGotBitmaps[0])^.bitmap );
	// unmap working map
   if fWorkingMap<>nil then
      fmemmap.UnMap(fWorkingMap);
   fWorkingTileX:=$ffff;
   fWorkingTileY:=$ffff;
   fWorkingMap:=nil;
   fmemmap.DeAllocate;
   fGotBitmaps.Clear;	// the list must be empty
end;

procedure TIEVirtualBitmap.SetWidth(v:dword);
begin
	fWidth:=v;
   if (fWidth>0) and (fHeight>0) and (fBitCount>0) then
   	AllocateBits(fWidth,fHeight,fBitCount);
end;

procedure TIEVirtualBitmap.SetHeight(v:dword);
begin
	fHeight:=v;
   if (fWidth>0) and (fHeight>0) and (fBitCount>0) then
   	AllocateBits(fWidth,fHeight,fBitCount);
end;

procedure TIEVirtualBitmap.SetBitCount(v:dword);
begin
	fBitCount:=v;
   if (fWidth>0) and (fHeight>0) and (fBitCount>0) then
   	AllocateBits(fWidth,fHeight,fBitCount);
end;

// copy specified area to a new bitmap
// returned bitmap.pixelformat can be pf1bit, pf8bit, pf24bit
// work only with:
//    bitspersample  samplesperpixel
//         1               1
//         8               1
//         8               3
// (you have to release the bitmap with ReleaseBitmap)
function TIEVirtualBitmap.GetBitmap(Left,Top,Width,Height:dword):TBitmap;
var
	x,y:dword;
   TileX,TileY:dword;
   source:pbyte;
   off:int64;
   ox,oy:dword;
   dx,dy:dword;
   pgotbitmap:PIEGotBitmap;
begin
	result:=TBitmap.Create;
   if fBitCount=1 then begin
      result.PixelFormat:=pf1bit;
   end else if fBitCount=8 then begin
      result.PixelFormat:=pf8bit;
      // ...insert palette here
   end else if fBitCount=24 then begin
      result.PixelFormat:=pf24bit;
   end else begin
      result.free;
      result:=nil;
      exit;
   end;
   result.Width:=Width;
   result.Height:=Height;
   new(pgotbitmap);
   pgotbitmap^.Left:=Left;
   pgotbitmap^.Top:=Top;
   pgotbitmap^.Width:=Width;
   pgotbitmap^.Height:=Height;
   pgotbitmap^.Bitmap:=result;
   pgotbitmap^.maps:=TList.Create;
   x:=Left; y:=Top;
   while (y<(Top+Height-1)) do begin
   	// load the tile
   	TileY:=y div fTileHeight;
      TileX:=x div fTileWidth;
      oy:=y-TileY*fTileHeight;
      ox:=x-TileX*fTileWidth;
      dy:=imin(fTileHeight-oy , Height-y+Top);
      dx:=imin(fTileWidth-ox , Width-x+Left);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      source:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
		pgotbitmap^.maps.Add(source);
      // copy
      IEBitmapMapXCopy(source,fTileRowlen,fBitCount,result,ox,oy,(x-Left),(y-Top),dx,dy,0);
      //
      inc(x,fTileWidth-ox);
      if x>=(Left+Width-1) then begin
      	x:=Left;
         inc(y,fTileHeight-oy);
      end;
   end;
   fGotBitmaps.Add(pgotbitmap);
end;

// copy the bitmap back and release it
procedure TIEVirtualBitmap.ReleaseBitmap(bitmap:TBitmap);
var
	x,y:dword;
   TileX,TileY:dword;
   source:pbyte;
   ox,oy:dword;
   q:integer;
   pgotbitmap:PIEGotBitmap;
   windex:integer;
   Left,Top,Width,Height:dword;
   dx,dy:dword;
begin
	pgotbitmap:=nil;
   windex:=-1;
	for q:=0 to fGotBitmaps.Count-1 do
   	if PIEGotBitmap(fGotBitmaps[q])^.Bitmap=bitmap then begin
      	pgotbitmap:=PIEGotBitmap(fGotBitmaps[q]);
         windex:=q;
         break;
      end;
   if windex=-1 then exit;
   Left:=pgotbitmap^.Left;
   Top:=pgotbitmap^.Top;
   Width:=pgotbitmap^.Width;
   Height:=pgotbitmap^.Height;
   x:=Left; y:=Top;
   while (y<(Top+Height-1)) do begin
   	// load the tile
   	TileY:=y div fTileHeight;
      TileX:=x div fTileWidth;
      oy:=y-TileY*fTileHeight;
      ox:=x-TileX*fTileWidth;
      dy:=imin(fTileHeight-oy , Height-y+Top);
      dx:=imin(fTileWidth-ox , Width-x+Left);
		source:=pgotbitmap^.maps[0];
		pgotbitmap^.maps.Delete(0);
      // copy back
		IEBitmapMapXCopy(source,fTileRowlen,fBitCount,bitmap,ox,oy,(x-Left),(y-Top),dx,dy,1);
      //
      fmemmap.UnMap(source);
      inc(x,fTileWidth-ox);
      if x>=(Left+Width-1) then begin
      	x:=Left;
         inc(y,fTileHeight-oy);
      end;
   end;
   bitmap.free;
   pgotbitmap^.maps.Free;
   dispose( pgotbitmap );
   fGotBitmaps.Delete(windex);
end;

procedure TIEVirtualBitmap.CopyFromIEBitmap(bitmap:TIEBitmap; xdst,ydst,dxdst,dydst:dword);
var
	x,y:dword;
   TileX,TileY:dword;
   source:pbyte;
   off:int64;
   ox,oy:dword;
   dx,dy:dword;
begin
   x:=xdst; y:=ydst;
   while (y<(ydst+dydst-1)) do begin
   	// load the tile
   	TileY:=y div fTileHeight;
      TileX:=x div fTileWidth;
      oy:=y-TileY*fTileHeight;
      ox:=x-TileX*fTileWidth;
      dy:=imin(fTileHeight-oy , dydst-y+ydst);
      dx:=imin(fTileWidth-ox , dxdst-x+xdst);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      source:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
      // copy
      IEBitmapMapXCopyEx(source,fTileRowlen,fBitCount,bitmap,ox,oy,(x-xdst),(y-ydst),dx,dy,1);
      //
      fmemmap.UnMap(source);
      inc(x,fTileWidth-ox);
      if x>=(xdst+dxdst-1) then begin
      	x:=xdst;
         inc(y,fTileHeight-oy);
      end;
   end;
end;


procedure TIEVirtualBitmap.GetPixel(x,y:dword; var Value);
var
   TileX,TileY:dword;
   ox,oy:dword;
   off:dword;
   pp:pbyte;
begin
   TileY:=y div fTileHeight;
   TileX:=x div fTileWidth;
   oy:=y-TileY*fTileHeight;
   ox:=x-TileX*fTileWidth;
   if (TileX<>fWorkingTileX) or (TileY<>fWorkingTileY) or (fWorkingMap=nil) then begin
		if fWorkingMap<>nil then
         fmemmap.UnMap(fWorkingMap);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      fWorkingMap:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
   end;
   pp:=pointer(dword(fWorkingMap)+fTileRowLen*oy);
	case fBitCount of
   	1:
      	begin
         	byte(Value):=_GetPixelbw(pp,ox);
         end;
      8:
      	begin
         	inc(pp,ox);
            byte(Value):=pp^;
         end;
      24:
      	begin
         	inc(pp,ox*sizeof(TRGB));
         	TRGB(Value):=PRGB(pp)^;
         end;
   end;
end;

procedure TIEVirtualBitmap.SetPixel(x,y:dword; const Value);
var
   TileX,TileY:dword;
   ox,oy:dword;
   off:int64;
   pp:pbyte;
begin
   TileY:=y div fTileHeight;
   TileX:=x div fTileWidth;
   oy:=y-TileY*fTileHeight;
   ox:=x-TileX*fTileWidth;
   if (TileX<>fWorkingTileX) or (TileY<>fWorkingTileY) or (fWorkingMap=nil) then begin
		if fWorkingMap<>nil then
         fmemmap.UnMap(fWorkingMap);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      fWorkingMap:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
   end;
   pp:=pointer(dword(fWorkingMap)+fTileRowLen*oy);
	case fBitCount of
   	1:
      	begin
         	_SetPixelbw(pp,ox,byte(Value));
         end;
      8:
      	begin
         	inc(pp,ox);
            pp^:=byte(Value);
         end;
      24:
      	begin
         	inc(pp,ox*sizeof(TRGB));
         	PRGB(pp)^:=TRGB(Value);
         end;
   end;
end;

procedure TIEVirtualBitmap.ApplyFunction(Left,Top,Width,Height:dword; func:TIEVirtualBitmapFunction; UserData:pointer);
var
	x,y:dword;
   TileX,TileY:dword;
   source,pp,p2:pbyte;
   p3:PRGB;
   off:dword;
   ox,oy:dword;
   dx,dy:dword;
   xx,yy:dword;
   b,c:byte;
begin
   x:=Left; y:=Top;
   while (y<(Top+Height-1)) do begin
   	// load the tile
   	TileY:=y div fTileHeight;
      TileX:=x div fTileWidth;
      oy:=y-TileY*fTileHeight;
      ox:=x-TileX*fTileWidth;
      dy:=imin(fTileHeight-oy , Height-y+Top);
      dx:=imin(fTileWidth-ox , Width-x+Left);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      source:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
      // function
      pp:=pbyte( dword(source)+fTileRowLen*oy );
      case fBitCount of
      	1:
         	begin
               for yy:=0 to dy-1 do begin
                  for xx:=ox to ox+dx-1 do begin
                  	b:=_getpixelbw(pp,xx);
                     c:=b;
                  	func(x+xx-ox,y+yy,@b,UserData);
                     if b<>c then
	                     _setpixelbw(pp,xx,b);
                  end;
                  inc(pp,fTileRowLen);
               end;
            end;
         8:
         	begin
               for yy:=0 to dy-1 do begin
               	p2:=pp;
                  for xx:=ox to ox+dx-1 do begin
                  	func(x+xx-ox,y+yy,p2,UserData);
                     inc(p2);
                  end;
                  inc(pp,fTileRowLen);
               end;
            end;
         24:
         	begin
               for yy:=0 to dy-1 do begin
               	p3:=PRGB(pp);
                  for xx:=ox to ox+dx-1 do begin
                  	func(x+xx-ox,y+yy,p3,UserData);
                     inc(p3);
                  end;
                  inc(pp,fTileRowLen);
               end;
            end;
      end;
      //
      fmemmap.UnMap(source);
      inc(x,fTileWidth-ox);
      if x>=(Left+Width-1) then begin
      	x:=Left;
         inc(y,fTileHeight-oy);
      end;
   end;
end;

procedure _DrawDIB(hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt);
begin
	StretchDIBits(hDC,xDst,yDst,dxDst,dyDst,xSrc,ySrc,dxSrc,dySrc,Bits,PBITMAPINFO(@lpbi)^,DIB_RGB_COLORS,SRCCOPY);
end;

// if hdd<>0 uses DibDrawDib otherwise StetchDIBits
procedure TIEVirtualBitmap.RenderTo(Canvas:TCanvas; xDst,yDst,dxDst,dyDst:dword; xSrc,ySrc,dxSrc,dySrc:dword; SubSampleFilter:boolean);
var
	x,y:dword;
   TileX,TileY:dword;
   source:pbyte;
   off:dword;
   ox,oy:dword;
   dx,dy:dword;
   x1,y1,xx,yy:integer;
   rx,ry:double;
   pp:pbyte;
begin
	fTempBitmapInfoHeader256.biBitCount:=fBitCount;
   x:=xsrc; y:=ysrc;
   rx:=dxDst/dxSrc;
   ry:=dyDst/dySrc;
   while (y<(ysrc+dysrc-1)) do begin
   	// load the tile
   	TileY:=y div fTileHeight;
      TileX:=x div fTileWidth;
      oy:=y-TileY*fTileHeight;
      ox:=x-TileX*fTileWidth;
      dy:=imin(fTileHeight-oy , dysrc-y+ysrc);
      dx:=imin(fTileWidth-ox , dxsrc-x+xsrc);
      off:=(TileY*fXTileCount+TileX) * fTileRowLen*fTileHeight;
      source:=fmemmap.Map(off,fTileRowLen*fTileHeight,[iedRead,iedWrite]);
      //
      x1:=xDst+trunc((x-xsrc)*rx);
      y1:=yDst+trunc((y-ysrc)*ry);
      xx:=imin(trunc(dx*rx)+1,dxDst);
      yy:=imin(trunc(dy*ry)+1,dyDst);
      if SubSampleFilter and ((rx<1) or (ry<1)) then begin
      	if fBitCount=1 then begin
         	// subsampling black white
            pp:=_SubResample1bitFilteredDIB(source,fTileWidth,dy,ox,oy,ox+dx-1,oy+dy-1,xx,yy);
            fTempBitmapInfoHeader256.biWidth:=xx;
            fTempBitmapInfoHeader256.biHeight:=yy;
            fTempBitmapInfoHeader256.biBitCount:=24;
            _DrawDIB(Canvas.Handle,x1,y1,xx,yy,PBitmapInfoHeader(@fTempBitmapInfoHeader256)^,pp,0,0,xx,yy,0);
            fTempBitmapInfoHeader256.biBitCount:=fBitCount;
            freemem(pp);
         end else begin
         	// subsampling color (NOT IMPLEMENTED)
            fTempBitmapInfoHeader256.biWidth:=fTileWidth;
            fTempBitmapInfoHeader256.biHeight:=dy;
            _DrawDIB(Canvas.Handle,x1,y1,xx,yy,PBitmapInfoHeader(@fTempBitmapInfoHeader256)^,source,ox,oy,dx,dy,0);
         end;
      end else begin
      	// no subsampling filter or Zoom=100
         fTempBitmapInfoHeader256.biWidth:=fTileWidth;
         fTempBitmapInfoHeader256.biHeight:=dy;
         _DrawDIB(Canvas.Handle,x1,y1,xx,yy,PBitmapInfoHeader(@fTempBitmapInfoHeader256)^,source,ox,oy,dx,dy,0);
      end;
      //
      fmemmap.UnMap(source);
      inc(x,fTileWidth-ox);
      if x>=(xsrc+dxsrc-1) then begin
      	x:=xsrc;
         inc(y,fTileHeight-oy);
      end;
   end;
end;
*)

(*$endif*)


// end of TIEVirtualBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEBitmap

const
	PIXELFORMAT2BITCOUNT:array [ienull..ie32f] of integer=(0,1,8,8,16,24,32);

constructor TIEBitmap.Create;
var
	fm:integer;
begin
	inherited Create;
   fmemmap:=TIEFileBuffer.Create;
   fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fWorkingMap:=nil;
   fPixelFormat:=ienull;
   fRGBPalette:=nil;
   fIsAlpha:=false;
   fAlphaChannel:=nil;
   fRGBPaletteLen:=0;
   fLocation:=ieFile;
   fBitmap:=nil;
   fBitmapScanlines:=nil;
   fFull:=false;
   fEncapsulatedFromTBitmap:=false;
   fEncapsulatedFromMemory:=false;
   fScanlinesToUnMap:=TList.Create;
   fDefaultDitherMethod:=ieThreshold;
   fBlackValue:=0;
   fWhiteValue:=0;
   // calculates fMinFileSize
   fm:=IEGetFreeMemory;
   if IEDefMinFileSize=-1 then begin
      if fm<=0 then begin
         // we cannot know how much memory is free
         fMinFileSize:=32*1024*1024;	// 32 Mbytes
      end else begin
         fMinFileSize:=fm div 2;		// we get maximum the half of memory size
      end;
   end else
   	fMinFileSize:=IEDefMinFileSize;
   // channels
   for fm:=0 to IEMAXCHANNELS-1 do
		fChannelOffset[fm]:=0;
   //
   fContrast:=0;
   fAccess:=[iedRead,iedWrite];
   fPaletteUsed:=256;
   fBitAlignment:=32;
end;

procedure TIEBitmap.UpdateFromTBitmap;
var
	px:TIEPixelFormat;
begin
	if assigned(fBitmap) then begin
   	px:=ie24RGB;
      case fBitmap.PixelFormat of
         pf1bit: px:=ie1g;
			pf8bit: if fIsAlpha then px:=ie8g else px:=ie8p;
         pf24bit: px:=ie24RGB;
      end;
   	if (fWidth<>fBitmap.Width) or (fHeight<>fBitmap.Height) or (fPixelFormat<>px) then begin
         fWidth:=fBitmap.Width;
         fHeight:=fBitmap.Height;
      	fPixelFormat:=px;
         fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
         fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
         if HasAlphaChannel and ((fAlphaChannel.Width<>fWidth) or (fAlphaChannel.Height<>fHeight)) then begin
				fAlphaChannel.Allocate(fWidth,fHeight,ie8g);
         end;
         BuildBitmapScanlines;
      end;
      if (fHeight>0) and assigned(fBitmapScanlines) and (fBitmapScanlines[0]<>fBitmap.Scanline[0]) then
	      BuildBitmapScanlines;
   end;
end;

function TIEBitmap.GetBitCount:integer;
begin
	if (fLocation=ieTBitmap) then
   	UpdateFromTBitmap;
   result:=fBitCount;
end;

function TIEBitmap.GetWidth:integer;
begin
	if (fLocation=ieTBitmap) then
   	UpdateFromTBitmap;
   result:=fWidth;
end;

function TIEBitmap.GetHeight:integer;
begin
	if (fLocation=ieTBitmap) then
   	UpdateFromTBitmap;
   result:=fHeight;
end;

function TIEBitmap.GetPixelFormat:TIEPixelFormat;
begin
	if (fLocation=ieTBitmap) then
   	UpdateFromTBitmap;
   result:=fPixelFormat;
end;

function TIEBitmap.GetRowLen:integer;
begin
	if (fLocation=ieTBitmap) then
   	UpdateFromTBitmap;
   result:=fRowLen;
end;

function TIEBitmap.GetVclBitmap:TBitmap;
begin
	SetLocation(ieTBitmap);
	result:=fBitmap;
end;

// used by Allocate
// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
constructor TIEBitmap.CreateAsAlphaChannel(ImageWidth,ImageHeight:integer; ImageLocation:TIELocation);
begin
	Create;
   fEncapsulatedFromTBitmap:=false;
   fEncapsulatedFromMemory:=false;
   fIsAlpha:=true;
   fLocation:=ImageLocation;
   if fLocation=ieTBitmap then
      fLocation:=ieMemory;
  	Allocate(ImageWidth,ImageHeight,ie8g);
   Fill(255);	// full opaque
end;

procedure TIEBitmap.RemoveAlphaChannel;
begin
   if (not fIsAlpha) and assigned(fAlphaChannel) then
      FreeAndNil(fAlphaChannel);
end;

// used by AlphaChannel property
function TIEBitmap.GetAlphaChannel:TIEBitmap;
begin
	if (not fIsAlpha) and (not assigned(fAlphaChannel)) then
      // we need to create alpha channel
      CreateAlphaChannel;
  	result:=fAlphaChannel;	// it could be nil
end;

// used by HasAlphaChannel
function TIEBitmap.GetHasAlphaChannel:boolean;
begin
   result:= assigned(fAlphaChannel);
end;

procedure TIEBitmap.Cleanup;
begin
	FreeImage;
   FreeAndNil(fmemmap);
   FreeAndNil(fScanlinesToUnMap);
	inherited;
end;

// assigns all fields to Target, and set to zero all parameters (do not free the image or allocated memory)
// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
procedure TIEBitmap.SwitchTo(Target:TIEBitmap);
begin
	Target.FreeImage;
   Target.fWidth:=fWidth;
   Target.fHeight:=fHeight;
   Target.fBitCount:=fBitCount;
   Target.fWorkingMap:=fWorkingMap;
   Target.fRowLen:=fRowLen;
   Target.fPixelFormat:=fPixelFormat;
   Target.fRGBPalette:=fRGBPalette;
   Target.fRGBPaletteLen:=fRGBPaletteLen;
   Target.fAlphaChannel:=fAlphaChannel;
   Target.fIsAlpha:=fIsAlpha;
   Target.fMemory := fMemory;
   Target.fBitmap:=fBitmap;
   Target.fLocation:=fLocation;
   Target.fFull:=fFull;
   Target.fEncapsulatedFromTBitmap:=fEncapsulatedFromTBitmap;
   Target.fEncapsulatedFromMemory:=fEncapsulatedFromMemory;
   Target.fBitmapScanlines:=fBitmapScanlines;
   FreeAndNil(Target.fmemmap);
   Target.fmemmap:=fmemmap;
   FreeAndNil(Target.fScanlinesToUnMap);
   Target.fScanlinesToUnMap:=fScanlinesToUnMap;
   Target.fDefaultDitherMethod:=fDefaultDitherMethod;
   Target.fBitAlignment:=fBitAlignment;
	fWidth:=0;
   fHeight:=0;
   fBitCount:=0;
   fWorkingMap:=nil;
   fRowLen:=0;
   fPixelFormat:=ienull;
   fRGBPalette:=nil;
   fRGBPaletteLen:=0;
   fAlphaChannel:=nil;
   fIsAlpha:=false;
   l3FillChar(fMemory, SizeOf(fMemory), 0);
   fBitmap:=nil;
   fBitmapScanlines:=nil;
   fScanlinesToUnMap:=TList.Create;
   fFull:=false;
   fEncapsulatedFromTBitmap:=false;
   fEncapsulatedFromMemory:=false;
   fmemmap:=TIEFileBuffer.Create;
end;

// free bitmap scanlines
procedure TIEBitmap.FreeBitmapScanlines;
begin
   if fBitmapScanlines<>nil then
      freemem(fBitmapScanlines);
   fBitmapScanlines:=nil;
end;

// free and build bitmap scanlines
procedure TIEBitmap.BuildBitmapScanlines;
var
   i:integer;
begin
   FreeBitmapScanlines;
   if assigned(fBitmap) then begin
      getmem(fBitmapScanlines,sizeof(pointer)*fHeight);
      for i:=0 to fHeight-1 do
         fBitmapScanlines[i]:=fBitmap.Scanline[i];
   end;
end;

procedure TIEBitmap.SetBitAlignment(value:integer);
var
	old:TIEBitmap;
   row,mi:integer;
begin
	if value<>fBitAlignment then begin
   	if (fLocation=ieMemory) then begin
         old:=TIEBitmap.Create;
         SwitchTo(old);
         fBitAlignment:=value;
         Allocate(old.Width,old.fHeight,old.fPixelFormat);
         mi:=imin( fRowLen, old.fRowLen );
         for row:=0 to fHeight-1 do
            CopyMemory( ScanLine[row], old.ScanLine[row], mi );
         // copy alpha (already sized in "resize alpha")
         if old.HasAlphaChannel then
            AlphaChannel.Assign( old.AlphaChannel );
         FreeAndNil(old);
		end;
   end;
end;

// resize also alpha channel
procedure TIEBitmap.SetWidth(Value:integer);
var
	old:TIEBitmap;
   row,mi,mih:integer;
   {$ifdef IEDELPHI}
   tmpbmp:TBitmap;
   {$endif}
begin
	if Value<>fWidth then begin
      // resize alpha
      if HasAlphaChannel then
         AlphaChannel.Width:=Value;
      // resize image
      case fLocation of
         ieMemory,
         ieFile:
            begin
            	if (fPixelFormat<>ienull) and (fHeight>0) then begin
                  old:=TIEBitmap.Create;
                  SwitchTo(old);
                  Allocate(Value,old.fHeight,old.fPixelFormat);
                  if old.fPixelFormat<>ienull then begin
                     mi:=imin( fRowLen, old.fRowLen );
                     mih:=imin( fHeight, old.fHeight );
                     for row:=0 to mih-1 do
                        CopyMemory( ScanLine[row], old.ScanLine[row], mi );
                  end;
                  // copy alpha (already sized in "resize alpha")
                  if old.HasAlphaChannel then
                  	AlphaChannel.Assign( old.AlphaChannel );
                  FreeAndNil(old);
                  fFull:=false;
               end else
               	fWidth:=Value;
            end;
         ieTBitmap:
            begin
         		if fBitmap=nil then
	            	fBitmap:=TBitmap.Create;
               {$ifdef IEDELPHI}
               if fBitmap.PixelFormat=pf1bit then begin
               	// we need this because sometime just set fBitmap.Width:=xx doesn't work
                  tmpbmp:=TBitmap.Create;
                  IECopyBitmap(fBitmap,tmpbmp);
                  fBitmap.Width:=Value;
                  fbitmap.HandleType:=bmDDB;
                  fBitmap.Canvas.Draw(0,0,tmpbmp);
                  fbitmap.HandleType:=bmDIB;
                  FreeAndNil(tmpbmp);
               end else
               {$endif}
						fBitmap.Width:=Value;
               fWidth:=fBitmap.Width;
               fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
               BuildBitmapScanlines;
               // no need to copy alpha
            end;
      end;
   end;
end;

// resize also alpha channel
procedure TIEBitmap.SetHeight(Value:integer);
var
	old:TIEBitmap;
   row,mi,miw:integer;
   {$ifdef IEDELPHI}
   tmpbmp:TBitmap;
   {$endif}
begin
	if Value<>fHeight then begin
      // resize alpha
      if HasAlphaChannel then
         AlphaChannel.Height:=Value;
      case fLocation of
         ieMemory,
         ieFile:
            begin
	            if (fPixelFormat<>ienull) and (fWidth>0) then begin
                  old:=TIEBitmap.Create;
                  SwitchTo(old);
                  Allocate(old.fWidth,Value,old.fPixelFormat);
                  if old.fPixelFormat<>ienull then begin
                     mi:=imin( fHeight, old.fHeight );
                     miw:=imin( fRowLen, old.fRowLen );
                     for row:=0 to mi-1 do
                        CopyMemory( ScanLine[row], old.ScanLine[row], miw );
                  end;
                  // copy alpha (already sized in "resize alpha")
                  if old.HasAlphaChannel then
                  	AlphaChannel.Assign( old.AlphaChannel );
                  FreeAndNil(old);
                  fFull:=false;
               end else
               	fHeight:=Value;
            end;
         ieTBitmap:
            begin
               if fBitmap=nil then
                  fBitmap:=TBitmap.Create;
					{$ifdef IEDELPHI}
               if fBitmap.PixelFormat=pf1bit then begin
               	// we need this because sometime just set fBitmap.Height:=xx doesn't work
                  tmpbmp:=TBitmap.Create;
                  IECopyBitmap(fBitmap,tmpbmp);
                  fBitmap.Height:=Value;
                  fbitmap.HandleType:=bmDDB;
                  fBitmap.Canvas.Draw(0,0,tmpbmp);
                  fbitmap.HandleType:=bmDIB;
                  FreeAndNil(tmpbmp);
               end else
               {$endif}
						fBitmap.Height:=Value;
               fHeight:=fBitmap.Height;
               BuildBitmapScanlines;
               // no need to copy alpha
            end;
      end;
   end;
end;

// works only on enlarging bitmap
procedure DoAlignAfter(Bitmap:TIEBitmap; OldWidth,OldHeight,bk:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
begin
   if Bitmap.Width>OldWidth then begin
      Bitmap.FillRect(OldWidth,0,Bitmap.Width-1,Bitmap.Height-1,bk);
      case HorizAlign of
         iehLeft:	; // do nothing, already aligned
         iehCenter:
            Bitmap.MoveRegion(0,0,OldWidth-1,OldHeight-1,((Bitmap.Width-OldWidth)div 2),0,bk);
         iehRight:
            Bitmap.MoveRegion(0,0,OldWidth-1,OldHeight-1,Bitmap.Width-OldWidth,0,bk);
      end;
   end;
   if Bitmap.Height>OldHeight then begin
      Bitmap.FillRect(0,OldHeight,Bitmap.Width-1,Bitmap.Height-1,bk);
      case VertAlign of
         ievTop: ;	// do nothing, already aligned
         ievCenter:
            Bitmap.MoveRegion(0,0,Bitmap.Width-1,OldHeight-1,0,((Bitmap.Height-OldHeight)div 2),bk);
         ievBottom:
            Bitmap.MoveRegion(0,0,Bitmap.Width-1,OldHeight-1,0,Bitmap.Height-OldHeight,bk);
      end;
   end;
end;

// works only on reducing bitmap
procedure DoAlignBefore(Bitmap:TIEBitmap; NewWidth,NewHeight,bk:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
var
	cx,cy:integer;
begin
	if Bitmap.Width>NewWidth then begin
   	cx:=(Bitmap.Width-NewWidth)div 2;
   	case HorizAlign of
      	iehLeft: ; // do nothing, already aligned
         iehCenter:
         	Bitmap.MoveRegion(cx,0,cx+NewWidth-1,Bitmap.Height-1,0,0,bk);
         iehRight:
         	Bitmap.MoveRegion(Bitmap.Width-NewWidth,0,Bitmap.Width-1,Bitmap.Height-1,0,0,bk);
      end;
   end;
   if Bitmap.Height>NewHeight then begin
   	cy:=(Bitmap.Height-NewHeight)div 2;
   	case VertAlign of
      	ievTop:	; // do nothing, already aligned
         ievCenter:
         	Bitmap.MoveRegion(0,cy,Bitmap.Width-1,cy+NewHeight-1,0,0,bk);
         ievBottom:
         	Bitmap.MoveRegion(0,Bitmap.Height-NewHeight,Bitmap.Width-1,Bitmap.height-1,0,0,bk);
      end;
   end;
end;

// resize also the alpha channel
// HorizAlign acts only when NewWidth>Width
// VertAlign acts only when NewHeight>Height
// AlphaValue is valid only when HasAlphaChannel is true and this is not an alpha channel
procedure TIEBitmap.Resize(NewWidth,NewHeight:integer; BackgroundValue:integer; AlphaValue:integer; HorizAlign:TIEHAlign; VertAlign:TIEVAlign);
var
   lw,lh:integer;
begin
   lw:=Width;
   lh:=Height;
   DoAlignBefore(self,NewWidth,NewHeight,BackgroundValue,HorizAlign,VertAlign);
   if HasAlphaChannel then
   	DoAlignBefore(AlphaChannel,NewWidth,NewHeight,AlphaValue,HorizAlign,VertAlign);
   SetWidth(NewWidth);
   SetHeight(NewHeight);
   DoAlignAfter(self,lw,lh,BackgroundValue,HorizAlign,VertAlign);
   if HasAlphaChannel then
   	DoAlignAfter(AlphaChannel,lw,lh,AlphaValue,HorizAlign,VertAlign);
end;

// do not copy alpha channel
procedure TIEBitmap.MoveRegion(x1,y1,x2,y2,DstX,DstY:integer; BackgroundValue:integer);
var
	tmp:TIEBitmap;
begin
	tmp:=TIEBitmap.Create;
   tmp.Allocate(x2-x1+1,y2-y1+1,PixelFormat);
   CopyRectTo(tmp,x1,y1,0,0,tmp.Width,tmp.Height);
   FillRect(x1,y1,x2,y2,BackgroundValue);
   tmp.CopyRectTo(self,0,0,DstX,DstY,tmp.Width,tmp.Height);
   FreeAndNil(tmp);
end;

procedure TIEBitmap.SetPixelFormat(Value:TIEPixelFormat);
begin
	if Value<>fPixelFormat then
		ConvertToPixelFormat(Value);
end;

procedure TIEBitmap.FreeAllMaps;
begin
   if fWorkingMap<>nil then
      fmemmap.UnMap(fWorkingMap);
   while fScanlinesToUnMap.Count>0 do begin
      fmemmap.UnMap(fScanlinesToUnMap[fScanlinesToUnMap.Count-1]);
      fScanlinesToUnMap.Delete(fScanlinesToUnMap.Count-1);
   end;
   fWorkingMap:=nil;
end;

// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
procedure TIEBitmap.FreeImage;
begin
   FreeAndNil(fAlphaChannel);
   if fRGBPalette<>nil then
      freemem(fRGBPalette);
   FreeAllMaps;
   fmemmap.DeAllocate;
   if (not fEncapsulatedFromMemory) then
      fMemory.Clear;
   if (not fEncapsulatedFromTBitmap) and (fBitmap<>nil) then
      FreeAndNil(fBitmap);
   FreeBitmapScanlines; // this set fBitmapScanlines:=nil
   l3FillChar(fMemory, SizeOf(fMemory), 0);
   fBitmap:=nil;
   fRGBPalette:=nil;
   fRGBPaletteLen:=0;
   fWidth:=0;
   fHeight:=0;
   fRowlen:=0;
   fBitCount:=0;
   fFull:=false;
   fEncapsulatedFromTBitmap:=false;
   fEncapsulatedFromMemory:=false;
end;

// before call AlocateImage make sure to call FreeImage
procedure TIEBitmap.AllocateImage;
var
	ms:int64;
begin
   {$ifdef IEKYLIX}
   // Under Kylix the ieTBitmap is not allowed
   if fLocation=ieTBitmap then fLocation:=ieMemory;
   {$endif}
	if (fWidth>0) and (fHeight>0) and (fPixelFormat<>ienull) then begin
      if fPixelFormat=ie8p then begin
         getmem(fRGBPalette,sizeof(TRGBA)*256);
         fRGBPaletteLen:=256;
      end;
	   fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
      fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
      ms:=fRowLen*fHeight;
      if (fLocation=ieFile) and (ms<fMinFileSize) then
      	fLocation:=ieMemory;
      if (fLocation=ieMemory) and (ms>fMinFileSize) then
      	fLocation:=ieFile;
      if fLocation=ieFile then begin
         // use file memory
         if not fmemmap.AllocateFile('',ms) then
         	fLocation:=ieMemory;
      end;
      if fLocation=ieMemory then begin
         // use memory  (max 4GByte)
       fMemory.SetSize(ms);
      end;
      if fLocation=ieTBitmap then begin
      	// use VCL TBitmap
         if not fEncapsulatedFromTBitmap then
            fBitmap:=TBitmap.Create;
         fBitmap.Width:=1; fBitmap.Height:=1;
         case fPixelFormat of
            ie1g: fBitmap.PixelFormat:=pf1bit;
            ie8p: fBitmap.PixelFormat:=pf8bit;
            ie8g: fBitmap.PixelFormat:=pf8bit;
            ie16g:	// ie16g in TBitmap converted to ie8g
            	begin
               	fBitmap.PixelFormat:=pf8bit;
                  fPixelFormat:=ie8g;
					   fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
				      fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
               end;
            ie32f: // ie32f not supported when Location=ieTBitmap
            	raise Exception.Create('ie32f pixel format not allowed when Location=ieTBitmap');
            ie24RGB: fBitmap.PixelFormat:=pf24bit;
         end;
         fBitmap.Width:=fWidth;
         fBitmap.Height:=fHeight;
         BuildBitmapScanlines;
      end;
      fFull:=false;
   end;
end;

procedure TIEBitmap.Allocate(ImageWidth,ImageHeight:integer; ImagePixelFormat:TIEPixelFormat);
begin
   if not fEncapsulatedFromTBitmap then
   	FreeImage;
   fWidth:=ImageWidth;
   fHeight:=ImageHeight;
   fPixelFormat:=ImagePixelFormat;
   AllocateImage;
end;

// supports only TBitmap with PixelFormat= pf1bit or pf24bit
procedure TIEBitmap.EncapsulateTBitmap(obj:TBitmap; DoFreeImage:boolean);
begin
   if DoFreeImage then
      FreeImage;
   if obj<>nil then begin
      fWidth:=obj.Width;
      fHeight:=obj.Height;
      case obj.PixelFormat of
         pf1bit: fPixelFormat:=ie1g;
         pf24bit: fPixelFormat:=ie24RGB;
      end;
      fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
      fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
      fLocation:=ieTBitmap;
      fEncapsulatedFromTBitmap:=true;
      fBitmap:=obj;
      BuildBitmapScanlines;
   end;
end;

// note: an encapsulated from memory cannot be allocated/resized/freedom, but just used
procedure TIEBitmap.EncapsulateMemory(mem:pointer; bmpWidth,bmpHeight:integer; bmpPixelFormat:TIEPixelFormat; DoFreeImage:boolean);
begin
   if DoFreeImage then
      FreeImage;
   if mem<>nil then begin
      fWidth:=bmpWidth;
      fHeight:=bmpHeight;
      fPixelFormat:=bmpPixelFormat;
      fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
      fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
      fLocation:=ieMemory;
      fEncapsulatedFromMemory:=true;
      fMemory.AsPointer := mem;
      BuildBitmapScanlines;
   end;
end;

// Accept TIEBitmap and TBitmap
procedure TIEBitmap.Assign(Source:TObject);
var
	src:TIEBitmap;
   row,i:integer;
   l1,l2:TIEDataAccess;
begin
	if Source is TIEBitmap then begin
   	src:=Source as TIEBitmap;
      if fLocation=ieTBitmap then begin
         // works with fBitmap (TBitmap)
         fWidth:=src.fWidth;
         fHeight:=src.fHeight;
         fPixelFormat:=src.fPixelFormat;
         fBitAlignment:=src.fBitAlignment;
         fFull:=src.fFull;
         if fBitmap=nil then
            fBitmap:=TBitmap.Create;
         fBitmap.Width:=1; fBitmap.Height:=1;
         case fPixelFormat of
            ie1g: fBitmap.PixelFormat:=pf1bit;
            ie8p: fBitmap.PixelFormat:=pf8bit;
            ie8g: fBitmap.PixelFormat:=pf8bit;
            ie16g: ; //not supported
            ie32f: ; //not supported
            ie24RGB: fBitmap.PixelFormat:=pf24bit;
         end;
         fBitmap.Width:=fWidth;
         fBitmap.Height:=fHeight;
         fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
         fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
         BuildBitmapScanlines;
      end else begin
         // works with native mapped file or memory bitmap
         FreeImage;
         fWidth:=src.fWidth;
         fHeight:=src.fHeight;
         fPixelFormat:=src.fPixelFormat;
         fFull:=src.fFull;
         fBitAlignment:=src.fBitAlignment;
         AllocateImage;
      end;
      // copy image
      l1:=src.Access;
      l2:=Access;
      src.Access:=[iedRead];
      Access:=[iedWrite];
      if (fLocation=ieFile) and (src.fLocation=ieFile) then begin
         // do a raw copy
         FreeAllMaps;
         src.FreeAllMaps;
         src.fmemmap.CopyTo(fmemmap,0,fRowLen*fHeight);
      end else
         for row:=0 to fHeight-1 do
            copymemory( ScanLine[row], src.ScanLine[row], fRowLen);
      src.Access:=l1;
      Access:=l2;
      // copy alpha channel
      if (not fIsAlpha) and assigned(src.fAlphaChannel) then begin	// fAlphaChannel avoid to create it if doesn't exist
      	// here we use GetAlphaChannel instead of fAlphaChannel to create alphachannel on the fly
         AlphaChannel.Assign( src.AlphaChannel );
		end;
      // copy palette
      for i:=0 to fRGBPaletteLen-1 do
      	fRGBPalette[i]:=src.fRGBPalette[i];
      UpdateTBitmapPalette;
      // Copy other params
      fDefaultDitherMethod:=src.fDefaultDitherMethod;
   end else if Source is TBitmap then begin
   	CopyFromTBitmap(Source as TBitmap);
   end;
end;

// assign only from TIEBitmap and without alpha channel
procedure TIEBitmap.AssignImage(Source:TIEBitmap);
var
   row,i:integer;
   l1,l2:TIEDataAccess;
begin
   if fLocation=ieTBitmap then begin
      // works with fBitmap (TBitmap)
      fWidth:=Source.fWidth;
      fHeight:=Source.fHeight;
      fPixelFormat:=Source.fPixelFormat;
      fBitAlignment:=Source.fBitAlignment;
      fFull:=false;
      if fBitmap=nil then
         fBitmap:=TBitmap.Create;
      fBitmap.Width:=1; fBitmap.Height:=1;
      case fPixelFormat of
         ie1g: fBitmap.PixelFormat:=pf1bit;
         ie8p: fBitmap.PixelFormat:=pf8bit;
         ie8g: fBitmap.PixelFormat:=pf8bit;
         ie16g: ; //not supported
         ie32f: ; //not supported
         ie24RGB: fBitmap.PixelFormat:=pf24bit;
      end;
      fBitmap.Width:=fWidth;
      fBitmap.Height:=fHeight;
      fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
      fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
      BuildBitmapScanlines;
   end else begin
      // works with native mapped file or memory bitmap
      FreeImage;
      fWidth:=Source.fWidth;
      fHeight:=Source.fHeight;
      fPixelFormat:=Source.fPixelFormat;
      fBitAlignment:=Source.fBitAlignment;
      fFull:=false;
      AllocateImage;
   end;
   // copy image
	l1:=Source.Access;
   l2:=Access;
   Source.Access:=[iedRead];
   Access:=[iedWrite];
   if (fLocation=ieFile) and (Source.fLocation=ieFile) then begin
   	// do a raw copy
      FreeAllMaps;
      Source.FreeAllMaps;
      Source.fmemmap.CopyTo(fmemmap,0,fRowLen*fHeight);
   end else
      for row:=0 to fHeight-1 do
         copymemory( ScanLine[row], Source.ScanLine[row], fRowLen);
	Source.Access:=l1;
   Access:=l2;
   // copy palette
   for i:=0 to fRGBPaletteLen-1 do
      fRGBPalette[i]:=Source.fRGBPalette[i];
   UpdateTBitmapPalette;
end;

// for performance we never control if Row is valid
function TIEBitmap.GetScanLine(Row:integer):pointer;
begin
	case fLocation of
   	ieMemory:
         result:= fMemory.AsPointer + (fHeight-Row-1)*fRowlen ;
      ieTBitmap:
         result := fBitmapScanlines[row];
   	ieFile:
      	begin
            if fWorkingMap<>nil then
               fmemmap.UnMap(fWorkingMap);
            fWorkingMap:=fmemmap.Map( Row*fRowLen,fRowLen,fAccess);
            result:=fWorkingMap;
         end;
      else
      	result:=nil;
   end;
end;

// if ieMemory or ieTBitmap is just like GetScanline
// for performance we never control if Row is valid
function TIEBitmap.GetRow(Row:integer):pointer;
begin
	case fLocation of
   	ieMemory:
         result := fMemory.AsPointer + (fHeight-Row-1)*fRowlen;
      ieTBitmap:
         result := fBitmapScanlines[row];
   	ieFile:
      	begin
            result:=fmemmap.Map( Row*fRowLen,fRowLen,fAccess);
            fScanlinesToUnMap.Add(result);
         end;
      else
      	result:=nil;
   end;
end;

// if ieMemory or ieTBitmap does nothing
// for performance we never control if Row is valid
procedure TIEBitmap.FreeRow(Row:integer);
begin
   if (fLocation=ieFile) and (Row<fScanlinesToUnMap.Count) then begin
      fmemmap.UnMap( fScanlinesToUnMap[Row] );
      fScanlinesToUnMap.Delete(Row);
   end;
end;

// use color quantizers when convert from a true color to a paletted
// if fLocation is ieTBitmap only ie1g and ie24RGB are supported
procedure TIEBitmap.ConvertToPixelFormat(DestPixelFormat:TIEPixelFormat);
var
	old,tmp:TIEBitmap;
   bold:TBitmap;
   row,col,q,v:integer;
   px_src,px_dst:pbyte;
   px_src_w,px_dst_w:pword;
   px_src_rgb:PRGB;
   px_dst_f,px_src_f:psingle;
   qt:TIEQuantizer;
   tmpcolormap:array [0..255] of TRGB;
   nullpr:TProgressRec;
begin
   with nullpr do begin
      Aborting:=nil;
      fOnProgress:=nil;
      Sender:=nil;
   end;
   case fLocation of
      ieMemory,
      ieFile:
         begin
            old:=TIEBitmap.Create;
            SwitchTo(old);
            fWidth:=old.fWidth;
            fHeight:=old.fHeight;
            fPixelFormat:=DestPixelFormat;
            AllocateImage;
            if old.fPixelFormat<>ienull then begin
               case old.fPixelFormat of
                  ie1g:
                     case DestPixelFormat of
                        ie8p:
                           begin
                              // 1bit gray scale ==> 8bit paletted
                              with fRGBPalette[0] do begin
                                 r:=0; b:=0; g:=0;
                              end;
                              with fRGBPalette[1] do begin
                                 r:=255; b:=255; g:=255;
                              end;
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=ord(_GetPixelbw(px_src,col)<>0);
                                    inc(px_dst);
                                 end;
                              end;
                           end;
                        ie8g:
                           begin
                              // 1bit gray scale ==> 8bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=ord(_GetPixelbw(px_src,col)<>0)*255;
                                    inc(px_dst);
                                 end;
                              end;
                           end;
                        ie16g:
                           begin
                              // 1bit gray scale ==> 16bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_w:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_w^:=ord(_GetPixelbw(px_src,col)<>0)*65535;
                                    inc(px_dst_w);
                                 end;
                              end;
                           end;
                        ie24RGB:
                           begin
                              // 1bit gray scale ==> 24bit RGB
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    v:=ord(_GetPixelbw(px_src,col)<>0)*255;
                                    px_dst^:=v; inc(px_dst);
                                    px_dst^:=v; inc(px_dst);
                                    px_dst^:=v; inc(px_dst);
                                 end;
                              end;
                           end;
                        ie32f:
                           begin
                              // 1bit gray scale ==> 32bit float point gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_f:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_f^:=ord(_GetPixelbw(px_src,col)<>0);
                                    inc(px_dst_f);
                                 end;
                              end;
                           end;
                     end;
                  ie8p:
                     case DestPixelFormat of
                        ie1g:
                           begin
                              // 8bit paletted ==> 1bit gray scale
                              case fDefaultDitherMethod of
                              	ieOrdered:
                                    // use ordered black/white convertion
                                    for row:=0 to fHeight-1 do begin
                                       px_src:=old.ScanLine[row];
                                       px_dst:=ScanLine[row];
                                       for col:=0 to fWidth-1 do begin
                                          with old.fRGBPalette[ px_src^ ] do
                                             v:=((r*21 + g*71 + b*8) div 100) SHR 2;
                                          _SetPixelbw(px_dst,col, ord( v > BWORDERPATTERN[col and 7][row and 7] ) );
                                          inc(px_src);
                                       end;
                                    end;
                                 ieThreshold:
                                 	// use threshold convertion
                                    _ConvertToBWThresholdEx(old,self,-1,nullpr);
                              end;
                           end;
                        ie8g:
                           begin
                              // 8bit paletted ==> 8bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with old.fRGBPalette[ px_src^ ] do
                                       px_dst^:=(r*21 + g*71 + b*8) div 100;
                                    inc(px_dst);
                                    inc(px_src);
                                 end;
                              end;
                           end;
                        ie16g:
                           begin
                              // 8bit paletted ==> 16bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_w:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with old.fRGBPalette[ px_src^ ] do
                                       px_dst_w^:= (212*(r shl 8)+ 713*(g shl 8) + 75*(b shl 8)) div 1000;
                                    inc(px_dst_w);
                                    inc(px_src);
                                 end;
                              end;
                           end;
                        ie24RGB:
                           begin
                              // 8bit paletted ==> 24bit RGB
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with old.fRGBPalette[ px_src^ ] do begin
                                       px_dst^:=b; inc(px_dst);
                                       px_dst^:=g; inc(px_dst);
                                       px_dst^:=r; inc(px_dst);
                                    end;
                                    inc(px_src);
                                 end;
                              end;
                           end;
                        ie32f:
                           begin
                              // 8bit paletted ==> 32bit float point gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_f:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with old.fRGBPalette[ px_src^ ] do
                                       px_dst_f^:= (0.2126*r + 0.7152*g + 0.0722*b)/255;	// Rec 709
                                    inc(px_dst_f);
                                    inc(px_src);
                                 end;
                              end;
                           end;
                     end;
                  ie8g:
                     case DestPixelFormat of
                        ie1g:
                           begin
                              // 8bit gray scale ==> 1bit gray scale
                              case fDefaultDitherMethod of
                              	ieOrdered:
                                    // use ordered black/white convertion
                                    for row:=0 to fHeight-1 do begin
                                       px_src:=old.ScanLine[row];
                                       px_dst:=ScanLine[row];
                                       for col:=0 to fWidth-1 do begin
                                          _SetPixelbw(px_dst,col, ord( (px_src^ shr 2) > BWORDERPATTERN[col and 7][row and 7] ) );
                                          inc(px_src);
                                       end;
                                    end;
                                 ieThreshold:
                                 	// use threshold convertion
                                    _ConvertToBWThresholdEx(old,self,-1,nullpr);
                              end;
                           end;
                        ie8p:
                           begin
                              // 8bit gray scale ==> 8bit paletted
                              for q:=0 to 255 do
                                 with fRGBPalette[q] do begin
                                    r:=q; g:=q; b:=q;
                                 end;
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 CopyMemory(px_dst,px_src,fRowLen);
                              end;
                           end;
                        ie16g:
                           begin
                              // 8bit gray scale ==> 16bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_w:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_w^:=px_src^ shl 8;
                                    inc(px_src);
                                    inc(px_dst_w);
                                 end;
                              end;
                           end;
                        ie24RGB:
                           begin
                              // 8bit gray scale ==> 24bit RGB
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=px_src^;	inc(px_dst);
                                    px_dst^:=px_src^;	inc(px_dst);
                                    px_dst^:=px_src^;	inc(px_dst);
                                    inc(px_src);
                                 end;
                              end;
                           end;
                        ie32f:
                           begin
                              // 8bit gray scale ==> 32bit float point gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src:=old.ScanLine[row];
                                 px_dst_f:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_f^:=px_src^ / 255;
                                    inc(px_src);
                                    inc(px_dst_f);
                                 end;
                              end;
                           end;
                     end;
                  ie16g:
                     case DestPixelFormat of
                        ie1g:
                           begin
                              // 16bit gray scale ==> 1bit gray scale
                              case fDefaultDitherMethod of
                              	ieOrdered:
                                    // use ordered black/white convertion
                                    for row:=0 to fHeight-1 do begin
                                       px_src_w:=old.ScanLine[row];
                                       px_dst:=ScanLine[row];
                                       for col:=0 to fWidth-1 do begin
                                          _SetPixelbw(px_dst,col, ord( (px_src_w^ shr 10) > BWORDERPATTERN[col and 7][row and 7] ) );
                                          inc(px_src_w);
                                       end;
                                    end;
                                 ieThreshold:
                                 	// use threshold convertion
                                    _ConvertToBWThresholdEx(old,self,-1,nullpr);
                              end;
                           end;
                        ie8p:
                           begin
                              // 16bit gray scale ==> 8bit paletted
                              for q:=0 to 255 do
                                 with fRGBPalette[q] do begin
                                    r:=q; g:=q; b:=q;
                                 end;
                              for row:=0 to fHeight-1 do begin
                                 px_src_w:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=px_src_w^ shr 8;
                                    inc(px_dst);
                                    inc(px_src_w);
                                 end;
                              end;
                           end;
                        ie8g:
                           begin
                              // 16bit gray scale ==> 8bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_w:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=px_src_w^ shr 8;
                                    inc(px_dst);
                                    inc(px_src_w);
                                 end;
                              end;
                           end;
                        ie24RGB:
                           begin
                              // 16bit gray scale ==> 24bit RGB
                              for row:=0 to fHeight-1 do begin
                                 px_src_w:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=px_src_w^ shr 8; inc(px_dst);
                                    px_dst^:=px_src_w^ shr 8; inc(px_dst);
                                    px_dst^:=px_src_w^ shr 8; inc(px_dst);
                                    inc(px_src_w);
                                 end;
                              end;
                           end;
                        ie32f:
                           begin
                              // 16bit gray scale ==> 32bit float point gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_w:=old.ScanLine[row];
                                 px_dst_f:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_f^:=px_src_w^ / 65535;
                                    inc(px_dst_f);
                                    inc(px_src_w);
                                 end;
                              end;
                           end;
                     end;
                  ie24RGB:
                     case DestPixelFormat of
                        ie1g:
                           begin
                              // 24bit RGB ==> 1bit gray scale
                              case fDefaultDitherMethod of
                              	ieOrdered:
                                    // use ordered black/white convertion
                                    for row:=0 to fHeight-1 do begin
                                       px_src_rgb:=old.ScanLine[row];
                                       px_dst:=ScanLine[row];
                                       for col:=0 to fWidth-1 do begin
                                          with px_src_rgb^ do
                                             v:=((r*21 + g*71 + b*8) div 100) SHR 2;
                                          _SetPixelbw(px_dst,col, ord( v > BWORDERPATTERN[col and 7][row and 7] ) );
                                          inc(px_src_rgb);
                                       end;
                                    end;
                                 ieThreshold:
                                 	// use threshold convertion
                                    _ConvertToBWThresholdEx(old,self,-1,nullpr);
                              end;
                           end;
                        ie8p:
                           begin
                              // 24bit RGB ==> 8bit paletted
                              // use color reduction
                              qt:=TIEQuantizer.Create(old, tmpcolormap, fPaletteUsed, -1, 0);
                              for q:=0 to 255 do begin
                                 fRGBPalette[q].r:=tmpcolormap[q].r;
                                 fRGBPalette[q].g:=tmpcolormap[q].g;
                                 fRGBPalette[q].b:=tmpcolormap[q].b;
                              end;
                              for row:=0 to fHeight-1 do begin
                                 px_src_rgb:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=qt.RGBIndex[ px_src_rgb^ ];
                                    inc(px_dst);
                                    inc(px_src_rgb);
                                 end;
                              end;
                              FreeAndNil(qt);
                           end;
                        ie8g:
                           begin
                              // 24bit RGB ==> 8bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_rgb:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with px_src_rgb^ do
                                       px_dst^:=(r*21 + g*71 + b*8) div 100;
                                    inc(px_src_rgb);
                                    inc(px_dst);
                                 end;
                              end;
                           end;
                        ie16g:
                           begin
                              // 24bit RGB ==> 16bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_rgb:=old.ScanLine[row];
                                 px_dst_w:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with px_src_rgb^ do
                                       px_dst_w^:= (212*(r shl 8)+ 713*(g shl 8) + 75*(b shl 8)) div 1000;
                                    inc(px_src_rgb);
                                    inc(px_dst_w);
                                 end;
                              end;
                           end;
                        ie32f:
                           begin
                              // 24bit RGB ==> 32bit float point gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_rgb:=old.ScanLine[row];
                                 px_dst_f:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    with px_src_rgb^ do
                                       px_dst_f^:= (0.2126*r + 0.7152*g + 0.0722*b)/255;	// Rec 709
                                    inc(px_src_rgb);
                                    inc(px_dst_f);
                                 end;
                              end;
                           end;
                     end;
                  ie32f:
                     case DestPixelFormat of
                        ie1g:
                           begin
                              // 32bit float pointgray scale ==> 1bit gray scale
                              case fDefaultDitherMethod of
                              	ieOrdered:
                                    // use ordered black/white convertion
                                    for row:=0 to fHeight-1 do begin
                                       px_src_f:=old.ScanLine[row];
                                       px_dst:=ScanLine[row];
                                       for col:=0 to fWidth-1 do begin
                                          _SetPixelbw(px_dst,col, ord( (px_src_f^/2) > BWORDERPATTERN[col and 7][row and 7] ) );
                                          inc(px_src_f);
                                       end;
                                    end;
                                 ieThreshold:
                                 	// use threshold convertion
                                    _ConvertToBWThresholdEx(old,self,-1,nullpr);
                              end;
                           end;
                        ie8p:
                           begin
                              // 32bit float point gray scale ==> 8bit paletted
                              for q:=0 to 255 do
                                 with fRGBPalette[q] do begin
                                    r:=q; g:=q; b:=q;
                                 end;
                              for row:=0 to fHeight-1 do begin
                                 px_src_f:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=trunc(px_src_f^*255);
                                    inc(px_src_f);
                                    inc(px_dst);
                                 end;
                              end;
                           end;
                        ie8g:
                           begin
                              // 32bit float point gray scale ==> 8bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_f:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst^:=trunc(px_src_f^*255);
                                    inc(px_src_f);
                                    inc(px_dst);
                                 end;
                              end;
                           end;
                        ie16g:
                           begin
                              // 32bit float point gray scale ==> 16bit gray scale
                              for row:=0 to fHeight-1 do begin
                                 px_src_f:=old.ScanLine[row];
                                 px_dst_w:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                    px_dst_w^:=trunc(px_src_f^*65535);
                                    inc(px_src_f);
                                    inc(px_dst_w);
                                 end;
                              end;
                           end;
                        ie24RGB:
                           begin
                              // 32bit float point gray scale ==> 24bit RGB
                              for row:=0 to fHeight-1 do begin
                                 px_src_f:=old.ScanLine[row];
                                 px_dst:=ScanLine[row];
                                 for col:=0 to fWidth-1 do begin
                                 	v:=trunc(px_src_f^*255);
                                    px_dst^:=v; inc(px_dst);
                                    px_dst^:=v; inc(px_dst);
                                    px_dst^:=v; inc(px_dst);
                                    inc(px_src_f);
                                 end;
                              end;
                           end;
                     end;
               end; // end of src PixelFormat case
            end;
            // alpha channel
            fAlphaChannel:=old.fAlphaChannel;
            old.fAlphaChannel:=nil;
            //
            FreeAndNil(old);
            UpdateTBitmapPalette;
         end;
      ieTBitmap:
         begin
            case fBitmap.PixelFormat of
               pf1bit:
                  if DestPixelFormat=ie24RGB then begin
                     bold:=IECloneBitmap(fBitmap);
                     _Conv1To24(bold,fBitmap,nullpr);
                     FreeAndNil(bold);
                  end;
               pf24bit:
                  if DestPixelFormat=ie1g then begin
                     tmp:=TIEBitmap.Create;
                     tmp.EncapsulateTBitmap(fBitmap,true);
                     case fDefaultDitherMethod of
                        ieOrdered:
                           // use ordered convertion
                           _ConvertToBWOrdered(tmp,nullpr);
                        ieThreshold:
                           // use threshold convertion
                           _ConvertToBWThreshold(tmp,-1,nullpr);
                     end;
                     FreeAndNil(tmp);
                  end;
            end;
            fPixelFormat:=DestPixelFormat;
            fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
            fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
            BuildBitmapScanlines;
         end;
   end;  // end case (fLocation)
end;

procedure TIEBitmap.CopyToTBitmap(Dest:TBitmap);
var
   i,row,col:integer;
   {$ifdef IEDELPHI}
   ppee:array [0..255] of TPALETTEENTRY;
   {$endif}
   {$ifdef IEKYLIX}
   ppee:PBGRQUADARRAY256;
   px_rgb:PRGB;
   px_rgba:PRGBA;
   {$endif}
   px_w:pword;
   px_b:pbyte;
   px_f:psingle;
begin
	(*$ifdef IEDELPHI*)
	Dest.Width:=1; Dest.Height:=1;
   (*$endif*)
   (*$ifdef IEKYLIX*)
   // Kylix prefers to set size before set pixelformat
   Dest.Width:=fWidth;
   Dest.Height:=fHeight;
   (*$endif*)
	case fPixelFormat of
   	ie1g:		// gray scale (black/white) ==>> pf1bit
      	begin
         	Dest.PixelFormat:=pf1bit;
            {$ifdef IEDELPHI}
            ppee[0].peRed:=0;
            ppee[0].peGreen:=0;
            ppee[0].peBlue:=0;
            ppee[0].peFlags:=0;
            ppee[1].peRed:=255;
            ppee[1].peGreen:=255;
            ppee[1].peBlue:=255;
            ppee[1].peFlags:=0;
            SetPaletteEntries(dest.palette,0,2,ppee);
            {$endif}
            dest.Monochrome:=true;
         end;
      ie8p:		// color (palette)	==>> pf8bit
      	begin
         	Dest.PixelFormat:=pf8bit;
            {$ifdef IEDELPHI}
				for i:=0 to 255 do begin
               ppee[i].peRed:=fRGBPalette[i].r;
               ppee[i].peGreen:=fRGBPalette[i].g;
               ppee[i].peBlue:=fRGBPalette[i].b;
               ppee[i].peFlags:=0;
            end;
            SetPaletteEntries(dest.palette,0,256,ppee);
            {$endif}
            {$ifdef IEKYLIX}
            ppee:=Dest.ColorTable;
				for i:=0 to 255 do begin
               ppee[i].rgbRed:=fRGBPalette[i].r;
               ppee[i].rgbGreen:=fRGBPalette[i].g;
               ppee[i].rgbBlue:=fRGBPalette[i].b;
               ppee[i].rgbReserved:=0;
            end;
            {$endif}
         end;
		ie8g:		// gray scale (256 levels) ==>> pf8bit
      	begin
         	Dest.PixelFormat:=pf8bit;
            {$ifdef IEDELPHI}
				for i:=0 to 255 do begin
               ppee[i].peRed:=i;
               ppee[i].peGreen:=i;
               ppee[i].peBlue:=i;
               ppee[i].peFlags:=0;
            end;
            SetPaletteEntries(dest.palette,0,256,ppee);
            {$endif}
            {$ifdef IEKYLIX}
            ppee:=Dest.ColorTable;
				for i:=0 to 255 do begin
               ppee[i].rgbRed:=i;
               ppee[i].rgbGreen:=i;
               ppee[i].rgbBlue:=i;
               ppee[i].rgbReserved:=0;
            end;
            {$endif}
         end;
		ie16g:	//	gray scale (65536 levels) ==>> pf8bit
      	begin
         	Dest.PixelFormat:=pf8bit;
            {$ifdef IEDELPHI}
				for i:=0 to 255 do begin
               ppee[i].peRed:=i;
               ppee[i].peGreen:=i;
               ppee[i].peBlue:=i;
               ppee[i].peFlags:=0;
            end;
            SetPaletteEntries(dest.palette,0,256,ppee);
            {$endif}
            {$ifdef IEKYLIX}
            ppee:=Dest.ColorTable;
				for i:=0 to 255 do begin
               ppee[i].rgbRed:=i;
               ppee[i].rgbGreen:=i;
               ppee[i].rgbBlue:=i;
               ppee[i].rgbReserved:=0;
            end;
            {$endif}
            Dest.Width:=fWidth;
            Dest.Height:=fHeight;
            for row:=0 to fHeight-1 do begin
            	px_w:=Scanline[row];
               px_b:=Dest.Scanline[row];
               for col:=0 to fWidth-1 do begin
                  px_b^ := px_w^ shr 8;
                  inc(px_b);
                  inc(px_w);
               end;
            end;
         end;
		ie32f:	//	gray scale (32bit float point) ==>> pf8bit
      	begin
         	Dest.PixelFormat:=pf8bit;
            {$ifdef IEDELPHI}
				for i:=0 to 255 do begin
               ppee[i].peRed:=i;
               ppee[i].peGreen:=i;
               ppee[i].peBlue:=i;
               ppee[i].peFlags:=0;
            end;
            SetPaletteEntries(dest.palette,0,256,ppee);
            {$endif}
            {$ifdef IEKYLIX}
            ppee:=Dest.ColorTable;
				for i:=0 to 255 do begin
               ppee[i].rgbRed:=i;
               ppee[i].rgbGreen:=i;
               ppee[i].rgbBlue:=i;
               ppee[i].rgbReserved:=0;
            end;
            {$endif}
            Dest.Width:=fWidth;
            Dest.Height:=fHeight;
            for row:=0 to fHeight-1 do begin
            	px_f:=Scanline[row];
               px_b:=Dest.Scanline[row];
               for col:=0 to fWidth-1 do begin
                  px_b^ := trunc(px_f^*255);
                  inc(px_b);
                  inc(px_f);
               end;
            end;
         end;
		ie24RGB:	// color (true color) ==>> pf24bit
      	begin
         	Dest.PixelFormat:=pf24bit;
         end;
   end;
   if (fPixelFormat<>ie16g) and (fPixelFormat<>ie32f) then begin
      {$ifdef IEDELPHI}
      Dest.Width:=fWidth;
      Dest.Height:=fHeight;
      for row:=0 to fHeight-1 do
         CopyMemory( Dest.Scanline[row], Scanline[row], fRowLen );
      {$endif}
      {$ifdef IEKYLIX}
      // size already set
      if fPixelFormat=ie24RGB then
         for row:=0 to fHeight-1 do begin
            px_rgb:=Scanline[row];
				px_rgba:=Dest.Scanline[row];
            for col:=0 to fWidth-1 do begin
            	with px_rgba^ do begin
               	r:=px_rgb^.r;
                  g:=px_rgb^.g;
                  b:=px_rgb^.b;
                  a:=0;
               end;
            	inc(px_rgb);
               inc(px_rgba);
            end;
         end
      else
         for row:=0 to fHeight-1 do
            CopyMemory( Dest.Scanline[row], Scanline[row], fRowLen );
      if Dest.PixelFormat=pf1bit then
	      _Negative1Bit(Dest);
      {$endif}	// IEKYLIX
   end;
end;

// do not copy alpha channel
// also works with negative values for DstX, DstY (cut the top-left rectangle and reduce sizes)
procedure TIEBitmap.CopyRectTo(Dest:TIEBitmap; SrcX,SrcY,DstX,DstY:integer; RectWidth,RectHeight:integer);
var
   y,x,ml,v:integer;
   ps,pd:pbyte;
begin
   // adjust DstX and DstY
   if DstX<0 then begin
   	inc(SrcX,-DstX);
      dec(RectWidth,-DstX);
      DstX:=0;
   end;
   if DstY<0 then begin
   	inc(SrcY,-DstY);
      dec(RectHeight,-DstY);
      DstY:=0;
   end;
   DstX:=imin(DstX,Dest.Width-1);
   DstY:=imin(DstY,Dest.Height-1);
   // adjust SrcX and SrcY
   SrcX:=imin(imax(SrcX,0),Width-1);
   SrcY:=imin(imax(SrcY,0),Height-1);
   // adjust rect size comparing with Source
   if SrcX+RectWidth > Width then
      RectWidth := Width-SrcX;
   if SrcY+RectHeight > Height then
      RectHeight := Height-SrcY;
   // adjust rect size comparing with Dest
   if DstX+RectWidth > Dest.Width then
      RectWidth := Dest.Width-DstX;
   if DstY+RectHeight > Dest.Height then
      RectHeight := Dest.Height-DstY;
   //
   if (PixelFormat=ie1g) and (Dest.PixelFormat=ie1g) then begin
      // gray scale (black/white)
      for y:=0 to RectHeight-1 do begin
         ps:=Scanline[SrcY+y];
         pd:=Dest.Scanline[DstY+y];
         _CopyBits(pd,ps,DstX,SrcX,RectWidth,Rowlen);
      end;
   end else if (PixelFormat=ie1g) and (dest.PixelFormat=ie24RGB) then begin
   	// blackwhite to rgb
		for y:=0 to RectHeight-1 do begin
         ps:=Scanline[SrcY+y];
         pd:=Dest.Scanline[DstY+y]; inc(pd,DstX*3);
         for x:=SrcX to SrcX+RectWidth-1 do begin
            v:=ord(_GetPixelbw(ps,x)<>0)*255;
            pd^:=v; inc(pd);
            pd^:=v; inc(pd);
            pd^:=v; inc(pd);
         end;
      end;
   end else if (PixelFormat=Dest.PixelFormat) then begin
   	// same format
      case PixelFormat of
         ie8p,ie8g: ml:=1;
         ie16g:     ml:=2;
         ie24RGB:   ml:=3;
         ie32f:	  ml:=4;
         else exit;
      end;
      for y:=0 to RectHeight-1 do begin
         ps:=Scanline[SrcY+y]; inc(ps,SrcX*ml);
         pd:=Dest.Scanline[DstY+y]; inc(pd,DstX*ml);
         CopyMemory(pd,ps,RectWidth*ml);
      end;
   end;
end;

// should accept pf1bit, pf4bit, pf8bit, pf15bit, pf16bit, pf24bit, pf32bit
// if location is ieTBitmap, accept only pf1bit and pf24bit
procedure TIEBitmap.CopyFromTBitmap(Source:TBitmap);
var
	row,col:integer;
   pxb1,pxb2:pbyte;
   pxw1:pword;
   pxrgb:PRGB;
   pxrgba:PRGBA;
   {$ifdef IEDELPHI}
   ppee:array [0..255] of TPALETTEENTRY;
   {$endif}
   {$ifdef IEKYLIX}
   ppee:PBGRQUADARRAY256;
   {$endif}
   //
   procedure CopyPalette(cols:integer);
   var
   	j:integer;
   begin
      {$ifdef IEDELPHI}
      l3ZeroMemory(@(ppee[0]),sizeof(TPALETTEENTRY)*cols);
      getpaletteentries(Source.Palette,0,cols,ppee);
      for j:=0 to cols-1 do begin
         fRGBPalette[j].r:=ppee[j].peRed;
         fRGBPalette[j].g:=ppee[j].peGreen;
         fRGBPalette[j].b:=ppee[j].peBlue;
      end;
      {$endif}
      {$ifdef IEKYLIX}
      ppee:=Source.ColorTable;
      for j:=0 to cols-1 do begin
         fRGBPalette[j].r:=ppee[j].rgbRed;
         fRGBPalette[j].g:=ppee[j].rgbGreen;
         fRGBPalette[j].b:=ppee[j].rgbBlue;
      end;
      {$endif}
   end;
   //
begin
   case fLocation of
      ieMemory,
      ieFile:
         begin
            case Source.PixelFormat of
               pf1bit:	// pf1bit ==>> ie1g or ie8p
                  begin
                     if Source.Monochrome then begin
                        // pf1bit to ie1g
                        Allocate(Source.Width,Source.Height,ie1g);
                        for row:=0 to fHeight-1 do
                           CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
                     end else begin
                        // pf1bit to ie8p
                        Allocate(Source.Width,Source.Height,ie8p);
                        CopyPalette(2);
                        for row:=0 to fHeight-1 do begin
                           pxb1:=Source.Scanline[row];
                           pxb2:=Scanline[row];
                           for col:=0 to fWidth-1 do begin
                              pxb2^:=ord(_GetPixelbw(pxb1,col)<>0);
                              inc(pxb2);
                           end;
                        end;
                     end;
                  end;
               {$ifdef IEDELPHI}
               pf4bit:	// pf4bit ==>> ie8p
                  begin
                     Allocate(Source.Width,Source.Height,ie8p);
                     CopyPalette(16);
                     for row:=0 to fHeight-1 do begin
                        pxb1:=Source.Scanline[row];
                        pxb2:=Scanline[row];
                        for col:=0 to fWidth-1 do begin
                           if (col mod 2)=0 then begin
                              pxb2^:=(pxb1^ and $F0) shr 4;
                           end else begin
                              pxb2^:=pxb1^ and $0F;
                              inc(pxb1);
                           end;
                           inc(pxb2);
                        end;
                     end;
                  end;
               {$endif}
               pf8bit:	// pf8bit ==>> ie8p
                  begin
                     Allocate(Source.Width,Source.Height,ie8p);
                     CopyPalette(256);
                     for row:=0 to fHeight-1 do
                        CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
                  end;
               {$ifdef IEDELPHI}
               pf15bit: // pf15bit ==>> ie24RGB
                  // 5 43210 98765 43210
                  // 0 rrrrr ggggg bbbbb
                  //   0-31   0-31  0-31
                  begin
                     Allocate(Source.Width,Source.Height,ie24RGB);
                     for row:=0 to fHeight-1 do begin
                        pxw1:=Source.Scanline[row];
                        pxrgb:=Scanline[row];
                        for col:=0 to fWidth-1 do begin
                           with pxrgb^ do begin
                              r:= ((pxw1^ and $7C00) shr 10) shl 3;
                              g:= ((pxw1^ and $03E0) shr 5) shl 3;
                              b:= (pxw1^ and $001F) shl 3;
                           end;
                           inc(pxw1);
                           inc(pxrgb);
                        end;
                     end;
                  end;
               {$endif}
               pf16bit:	// pf16bit ==>> ie24RGB
                  // 54321 098765 43210
                  // rrrrr gggggg bbbbb
                  // 0-31   0-63   0-31
                  begin
                     Allocate(Source.Width,Source.Height,ie24RGB);
                     for row:=0 to fHeight-1 do begin
                        pxw1:=Source.Scanline[row];
                        pxrgb:=Scanline[row];
                        for col:=0 to fWidth-1 do begin
                           with pxrgb^ do begin
                              r:= ((pxw1^ and $F800) shr 11) shl 3;
                              g:= ((pxw1^ and $07E0) shr 5) shl 2;
                              b:= (pxw1^ and $001F) shl 3;
                           end;
                           inc(pxw1);
                           inc(pxrgb);
                        end;
                     end;
                  end;
               {$ifdef IEDELPHI}
               pf24bit:
                  begin	// pf24bit ==>> ie24RGB
                     Allocate(Source.Width,Source.Height,ie24RGB);
                     for row:=0 to fHeight-1 do
                        CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
                  end;
               {$endif}
               pf32bit:	// pf32bit ==>> ie24RGB
                  begin
                     Allocate(Source.Width,Source.Height,ie24RGB);
                     for row:=0 to fHeight-1 do begin
                        pxrgba:=Source.Scanline[row];
                        pxrgb:=Scanline[row];
                        for col:=0 to fWidth-1 do begin
                           pxrgb^:=PRGB(pxrgba)^;	// the "a" comes after bgr
                           inc(pxrgb);
                           inc(pxrgba);
                        end;
                     end;
                  end;
            end;
            fFull:=false;
         end;
      ieTBitmap:
         begin
         	if fBitmap=nil then
            	fBitmap:=TBitmap.Create;
            IECopyBitmap(Source,fBitmap);
            fWidth:=fBitmap.Width;
            fHeight:=fBitmap.Height;
            case fBitmap.PixelFormat of
               pf1bit: fPixelFormat:=ie1g;
               pf24bit: fPixelFormat:=ie24RGB;
            end;
            fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
            fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
            BuildBitmapScanlines;
         end;
   end;  // end case
end;

// if Source is nil the fill the bitmap with all 255 (support for copying empty alpha channels)
procedure TIEBitmap.CopyFromTIEMask(Source:TIEMask);
var
	row:integer;
begin
	if assigned(Source) then begin
      case Source.BitsPerPixel of
         1:
            begin
               Allocate(Source.Width,Source.Height,ie1g);
               for row:=0 to fHeight-1 do
                  CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
               fFull:=Source.fFull;
            end;
         8:
            begin
               Allocate(Source.Width,Source.Height,ie8g);
               for row:=0 to fHeight-1 do
                  CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
               fFull:=Source.fFull;
            end;
      end;
   end else
   	self.Fill(255);
end;

(*$ifdef IEDELPHI*)
procedure TIEBitmap.CopyFromTDibBitmap(Source:TIEDibBitmap);
var
	row:integer;
begin
	if assigned(Source) then begin
   	if fLocation=ieTBitmap then begin
         fWidth:=Source.Width;
         fHeight:=Source.Height;
         if fBitmap=nil then
            fBitmap:=TBitmap.Create;
         case Source.BitCount of
            1:
            	begin
            		fPixelFormat:=ie1g;
                  fBitmap.Width:=1; fBitmap.Height:=1;
                  fBitmap.PixelFormat:=pf1bit;
            	end;
            24:
            	begin
		            fPixelFormat:=ie24RGB;
                  fBitmap.Width:=1; fBitmap.Height:=1;
                  fBitmap.PixelFormat:=pf24bit;
               end;
         end;
         fBitmap.Width:=fWidth;
         fBitmap.Height:=fHeight;
         fBitCount:=PIXELFORMAT2BITCOUNT[fPixelFormat];
         fRowLen:=IEBitmapRowLen(fWidth,fBitCount,fBitAlignment);
         BuildBitmapScanlines;
      end else begin
         case Source.BitCount of
            1: Allocate(Source.Width,Source.Height,ie1g);
            8: Allocate(Source.Width,Source.Height,ie8g);	// don't copy palette (useful only when source is an alpha channel)
            24: Allocate(Source.Width,Source.Height,ie24RGB);
         end;
      end;
      for row:=0 to fHeight-1 do
         CopyMemory(Scanline[row],Source.Scanline[row],fRowlen);
   end;
end;
(*$endif*)

// Source.Pixelformat and PixelFormat must be both 1bit or both 24bit
(*$ifdef IEDELPHI*)
procedure TIEBitmap.MergeFromTDibBitmap(Source:TIEDibBitmap; x,y:integer);
var
   ww,hh,row:integer;
   ps,pd:pbyte;
begin
   if assigned(Source) then begin
      ww:=imin(Source.Width,fWidth-x);
      hh:=imin(Source.Height,fHeight-y);
      case Source.BitCount of
         1:
            begin
               for row:=0 to hh-1 do begin
                  ps:=Source.Scanline[row];
                  pd:=Scanline[row+y];
                  _CopyBits(pd,ps,x,0,ww,Source.Rowlen);
               end;
            end;
         24:
            begin
               for row:=0 to hh-1 do begin
                  ps:=Source.Scanline[row];
                  pd:=Scanline[row+y];
                  inc(pd,x*3);
                  copymemory(pd,ps,ww*3);
               end;
            end;
      end;
   end;
end;
(*$endif*)

// Copy specified source rectangle inside Dest (at top-left side)
// Dest.Pixelformat and PixelFormat must be both 1bit or both 24bit
(*$ifdef IEDELPHI*)
procedure TIEBitmap.CopyToTDibBitmap(Dest:TIEDibBitmap; source_x, source_y, sourceWidth, sourceHeight:integer);
var
   ww,hh,row:integer;
   ps,pd:pbyte;
begin
   ww:=imin(Dest.Width,sourceWidth);
   hh:=imin(Dest.Height,sourceHeight);
   case Dest.BitCount of
      1:
         begin
            for row:=0 to hh-1 do begin
               ps:=Scanline[row+source_y];
               pd:=Dest.Scanline[row];
               _CopyBits(pd,ps,0,source_x,ww,RowLen);
            end;
         end;
      24:
         begin
            for row:=0 to hh-1 do begin
               ps:=Scanline[row+source_y];
               inc(ps,3*source_x);
               pd:=Dest.Scanline[row];
               CopyMemory(pd,ps,ww*3);
            end;
         end;
   end;
end;
(*$endif*)

// supports only ie1g, ie8g PixelFormat
procedure TIEBitmap.CopyToTIEMask(Dest:TIEMask);
var
   row:integer;
begin
   case PixelFormat of
      ie1g:
         begin
            Dest.AllocateBits(fWidth,fHeight,1);
            for row:=0 to fHeight-1 do
               CopyMemory( Dest.Scanline[row], Scanline[row], fRowLen );
            Dest.fFull:=fFull;
         end;
      ie8g:
         begin
            Dest.AllocateBits(fWidth,fHeight,8);
            for row:=0 to fHeight-1 do
               CopyMemory( Dest.Scanline[row], Scanline[row], fRowLen );
            Dest.fFull:=fFull;
         end;
   end;
end;

function TIEBitmap.GetPalette(index:integer):TRGB;
begin
	if (index<fRGBPaletteLen) and (index>=0) then
   	result:=fRGBPalette[index];
end;

procedure TIEBitmap.SetPalette(index:integer; Value:TRGB);
begin
	if (index<fRGBPaletteLen) and (index>=0) then begin
   	fRGBPalette[index]:=Value;
      UpdateTBitmapPalette;
   end;
end;

function TIEBitmap.GetPixels_ie1g(x,y:integer):boolean;
begin
   result:=(pbytearray(Scanline[y])^[x shr 3] and iebitmask1[x and $7])<>0;
end;

procedure TIEBitmap.SetPixels_ie1g(x,y:integer; Value:boolean);
begin
	_SetPixelbw(Scanline[y],x,ord(Value));
   if not Value then fFull:=false;
end;

function TIEBitmap.GetPixels_ie8(x,y:integer):byte;
begin
	result:=pbytearray(Scanline[y])^[x];
end;

procedure TIEBitmap.SetPixels_ie8(x,y:integer; Value:byte);
begin
	pbytearray(Scanline[y])^[x]:=Value;
   if Value<255 then fFull:=false;
end;

function TIEBitmap.GetPixels_ie16g(x,y:integer):word;
begin
	result:=pwordarray(Scanline[y])^[x];
end;

procedure TIEBitmap.SetPixels_ie16g(x,y:integer; Value:word);
begin
	pwordarray(Scanline[y])^[x]:=Value;
   if Value<65535 then fFull:=false;
end;

function TIEBitmap.GetPixels_ie32f(x,y:integer):single;
begin
	result:=psinglearray(Scanline[y])^[x];
end;

procedure TIEBitmap.SetPixels_ie32f(x,y:integer; Value:single);
begin
	psinglearray(Scanline[y])^[x]:=Value;
   if Value<1 then fFull:=false;
end;

function TIEBitmap.GetPixels_ie24RGB(x,y:integer):TRGB;
begin
	result:=PRGBROW(Scanline[y])^[x];
end;

function TIEBitmap.GetPPixels_ie24RGB(x,y:integer):PRGB;
begin
	result:=@(PRGBROW(Scanline[y])^[x]);
end;


function TIEBitmap.GetPixels(x,y:integer):TRGB;
begin
   case fPixelFormat of
      ie1g:
         if (pbytearray(Scanline[y])^[x shr 3] and iebitmask1[x and $7])=0 then
            with result do begin
               r:=0;
               g:=0;
               b:=0;
            end
         else
            with result do begin
               r:=255;
               g:=255;
               b:=255;
            end;
      ie8p:
         result:=fRGBPalette[pbytearray(Scanline[y])^[x]];
      ie8g:
         with result do begin
            r:=pbytearray(Scanline[y])^[x];
            g:=r;
            b:=r;
         end;
      ie16g:
         with result do begin
            r:=pwordarray(Scanline[y])^[x] shr 8;
            g:=pwordarray(Scanline[y])^[x] shr 8;
            b:=pwordarray(Scanline[y])^[x] shr 8;
         end;
      ie32f:
         with result do begin
            r:=trunc(psinglearray(Scanline[y])^[x]*255);
            g:=trunc(psinglearray(Scanline[y])^[x]*255);
            b:=trunc(psinglearray(Scanline[y])^[x]*255);
         end;
      ie24RGB:
         result:=PRGBROW(Scanline[y])^[x];
      else result:=CreateRGB(0,0,0);
   end;
end;

procedure TIEBitmap.SetPixels_ie24RGB(x,y:integer; Value:TRGB);
begin
	PRGBROW(Scanline[y])^[x]:=Value;
   with Value do
	   if (r<255) or (g<255) or (b<255) then fFull:=false;
end;

function TIEBitmap.GetAlpha(x,y:integer):byte;
begin
	if fIsAlpha then
   	result:=GetPixels_ie8(x,y)
   else
		result:=GetAlphaChannel.GetPixels_ie8(x,y);	// use GetAlphaChannel instead of fAlphaChannel to create it on the fly
end;

procedure TIEBitmap.SetAlpha(x,y:integer; Value:byte);
begin
	if fIsAlpha then
   	SetPixels_ie8(x,y,Value)
   else
		GetAlphaChannel.SetPixels_ie8(x,y,Value);	// use GetAlphaChannel instead of fAlphaChannel to create it on the fly
   if Value<255 then fFull:=false;
end;

// for ie1g, ie8, ie16g, ie32f (Value can be a TColor for ie24RGB)
procedure TIEBitmap.Fill(Value:double);
var
	row,col,iValue:integer;
   pxw:pword;
   pxrgb:PRGB;
   vrgb:TRGB;
   pxf:psingle;
begin
	ivalue:=trunc(Value);
   case fPixelFormat of
      ie1g:
      	begin
         	if iValue>0 then iValue:=255;
            for row:=0 to fHeight-1 do
               l3fillchar(pbyte(Scanline[row])^,fRowLen,iValue);
         	fFull:= (iValue<>0);
         end;
      ie8p, ie8g:
      	begin
            for row:=0 to fHeight-1 do
               l3fillchar(pbyte(Scanline[row])^,fRowLen,iValue);
		      fFull:= (iValue=255);
         end;
      ie16g:
      	begin
            for row:=0 to fHeight-1 do begin
            	pxw:=Scanline[row];
               for col:=0 to fWidth-1 do begin
               	pxw^:=iValue;
                  inc(pxw);
               end;
            end;
		      fFull:= (iValue=65535);
         end;
      ie32f:
      	begin
            for row:=0 to fHeight-1 do begin
            	pxf:=Scanline[row];
               for col:=0 to fWidth-1 do begin
               	pxf^:=Value;
                  inc(pxf);
               end;
            end;
		      fFull:= (Value=1);
         end;
      ie24RGB:
      	begin
         	vrgb:=TColor2TRGB(TColor(iValue));
         	for row:=0 to fHeight-1 do begin
            	pxrgb:=Scanline[row];
               for col:=0 to fWidth-1 do begin
               	pxrgb^:=vrgb;
                  inc(pxrgb);
               end;
            end;
            with vrgb do
		      	fFull:= (r=255) and (g=255) and (b=255);
         end;
   end;
end;

// for ie1g, ie8, ie16g, ie32f (Value can be a TColor for ie24RGB)
procedure TIEBitmap.FillRect(x1,y1,x2,y2:integer; Value:double);
var
	row,col,iValue:integer;
   pxb:pbyte;
   pxw:pword;
   pxrgb:PRGB;
   vrgb:TRGB;
   pxf:psingle;
begin
	x1:=imax(x1,0);
   y1:=imax(y1,0);
   x2:=imin(x2,fWidth-1);
   y2:=imin(y2,fHeight-1);
	iValue:=trunc(Value);
   case fPixelFormat of
      ie1g:
         for row:=y1 to y2 do begin
            pxb:=Scanline[row];
            for col:=x1 to x2 do
               _SetPixelbw(pxb,col,iValue);
         end;
      ie8p, ie8g:
      	begin
            for row:=y1 to y2 do begin
               pxb:=Scanline[row]; inc(pxb,x1);
               l3fillchar(pxb^,x2-x1+1,iValue);
            end;
         end;
      ie16g:
      	begin
            for row:=y1 to y2 do begin
            	pxw:=Scanline[row]; inc(pxw,x1);
               for col:=x1 to x2 do begin
               	pxw^:=iValue;
                  inc(pxw);
               end;
            end;
         end;
      ie32f:
      	begin
            for row:=y1 to y2 do begin
            	pxf:=Scanline[row]; inc(pxf,x1);
               for col:=x1 to x2 do begin
               	pxf^:=iValue;
                  inc(pxf);
               end;
            end;
         end;
      ie24RGB:
      	begin
         	vrgb:=TColor2TRGB(TColor(iValue));
         	for row:=y1 to y2 do begin
            	pxrgb:=Scanline[row]; inc(pxrgb,x1);
               for col:=x1 to x2 do begin
               	pxrgb^:=vrgb;
                  inc(pxrgb);
               end;
            end;
         end;
   end;
end;

procedure TIEBitmap.SetLocation(Value:TIELocation);
var
	old:TIEBitmap;
   row,i:integer;
begin
   {$ifdef IEKYLIX}
   // Under Kylix the ieTBitmap is not allowed
   if Value=ieTBitmap then Value:=ieMemory;
   {$endif}
	if fLocation<>Value then begin
   	old:=TIEBitmap.Create;
   	SwitchTo(old);
		fLocation:=Value;
      Allocate(old.fWidth,old.fHeight,old.fPixelFormat);
      for row:=0 to fHeight-1 do
      	CopyMemory( Scanline[row],old.Scanline[row],fRowLen );
		for i:=0 to fRGBPaletteLen-1 do
      	fRGBPalette[i]:=old.fRGBPalette[i];
      UpdateTBitmapPalette;
      fIsAlpha:=old.fIsAlpha;
		fAlphaChannel:=old.fAlphaChannel;
      old.fAlphaChannel:=nil;
      FreeAndNil(old);
   end;
end;

procedure TIEBitmap.UpdateTBitmapPalette;
(*$ifdef IEDELPHI*)
var
	i:integer;
   ppee:array [0..255] of TPALETTEENTRY;
begin
	if fLocation=ieTBitmap then begin
      if fRGBPaletteLen>0 then begin
         for i:=0 to fRGBPaletteLen-1 do begin
            ppee[i].peRed:=fRGBPalette[i].r;
            ppee[i].peGreen:=fRGBPalette[i].g;
            ppee[i].peBlue:=fRGBPalette[i].b;
            ppee[i].peFlags:=0;
         end;
         SetPaletteEntries(fBitmap.palette,0,fRGBPaletteLen,ppee);
      end;
   end;
end;
(*$else*)
begin
end;
(*$endif*)

// ATN: GetCanvas convert to ieTBitmap (from ieFile or ieMemory)
function TIEBitmap.GetCanvas:TCanvas;
begin
	if (fLocation=ieFile) or (fLocation=ieMemory) then
      SetLocation(ieTBitmap);
 if (fBitmap = nil) then
  Result := nil
 else      
   result:=fBitmap.Canvas;
end;

{$ifdef IEDELPHI}
(*
procedure PrintPict(DestCanvas:TCanvas; x,y:integer; const Bitmap: TBitmap);
var
   Info: PBitmapInfo;
   InfoSize: DWORD;
   Image: Pointer;
   ImageSize: DWORD;
   Bits: HBITMAP;
   iSrcWidth, iSrcHeight: LongInt;
begin
	try
	DestCanvas.Lock;
   Bits := Bitmap.Handle;
   GetDIBSizes(Bits, InfoSize, ImageSize);
   Info := AllocMem(InfoSize);
   Image := AllocMem(ImageSize);
   GetDIB(Bits, 0, Info^, Image^);
   with Info^.bmiHeader do begin
      iSrcWidth := biWidth;
      iSrcHeight := biHeight;
   end;
   StretchDIBits(DestCanvas.Handle, x,y, iSrcWidth,iSrcHeight,0, 0, iSrcWidth,iSrcHeight, Image,Info^, DIB_RGB_COLORS,SRCCOPY);
   FreeMem(Image, ImageSize);
   FreeMem(Info, InfoSize);
   finally
   	DestCanvas.Unlock;
   end;
end;
//*)
//(*
// draw an hdib in a canvas
procedure _DIBDrawTo(DestCanvas:TCanvas; fhdib:THANDLE; orgx,orgy,orgdx,orgdy,destx,desty,destdx,destdy:integer);
var
	bminfo:^TBITMAPINFO;
begin
	bminfo:=GlobalLock(fhdib);
   SetStretchBltMode(destcanvas.handle,COLORONCOLOR);
   if bminfo^.bmiHeader.biBitCount<=8 then
   	// <=256 colors
		StretchDIBits(destcanvas.Handle,destx,desty,destdx,destdy,orgx,orgy,orgdx,orgdy,
						pointer(cardinal(bminfo)+sizeof(TBITMAPINFOHEADER)+ (1 shl bminfo^.bmiHeader.biBitCount)*4),
                  bminfo^,DIB_RGB_COLORS,SRCCOPY)
   else
   	// >256 colors
		StretchDIBits(destcanvas.Handle,destx,desty,destdx,destdy,orgx,orgy,orgdx,orgdy,
						pointer(cardinal(bminfo)+sizeof(TBITMAPINFOHEADER)),
                  bminfo^,DIB_RGB_COLORS,SRCCOPY);
   GlobalUnLock(fhdib);
end;


procedure PrintPict(DestCanvas:TCanvas; x,y:integer; const Bitmap:TIEBitmap; srcx,srcy,srcdx,srcdy:integer);
var
	hdib:THandle;
begin
	hdib:=_CopyBitmaptoDIBEx(Bitmap,srcx,srcy,srcx+srcdx,srcy+srcdy);
   try
    _DIBDrawTo(DestCanvas,hdib,0,0,srcdx,srcdy,x,y,srcdx,srcdy);
   finally
    GlobalFree(hdib);
   end;//try..finally 
end;
//*)
{$endif}

// render the tiebitmap to a canvas, converting a strip at the time to TBitmap then drawing it to the cnvas
// the tbitmap memory size will be minor than fMinFileSize
{$ifdef IEKYLIX}
procedure TIEBitmap.RenderToCanvas(DestCanvas:TCanvas; xDst,yDst,dxDst,dyDst:integer; Filter:TResampleFilter; Gamma:double);
const
   Inv255 = 1.0 / 255;
var
   i: Integer;
   InvGamma: double;
   lut:array [0..255] of byte;
	tmpbmp:TBitmap;
   resbmp:TIEBitmap;
   stripHeight,y,yy,y1,x1:integer;
   src,dst:pbyte;
   px:PRGB;
   GammaInit:boolean;
begin
	if (fWidth=0) or (fHeight=0) then exit;
   // calc stripHeight
   stripHeight:=fMinFileSize div IEBitmapRowLen(dxDst,24,fBitAlignment);
   stripHeight:=imin(dyDst,stripHeight);
   // resample to resbmp
   resbmp:=TIEBitmap.Create;
   resbmp.Allocate(dxDst,dyDst,fPixelFormat);
   if (Filter=rfNone) then
      // 1bit or 24bit unfiltered
      _IEBmpStretchEx(self,resbmp,nil,nil)
   else if (fPixelFormat=ie1g) then begin
      // 1bit filtered
      resbmp.PixelFormat:=ie24RGB;
      _Resample1BitEx(self,resbmp,Filter);
   end else
      // 24bit filtered
      _ResampleEx(self,resbmp,Filter,nil, nil);
   // create temp bitmap
   tmpbmp:=TBitmap.Create;
   tmpbmp.Width:=1; tmpbmp.Height:=1;
   if resbmp.PixelFormat=ie1g then
      tmpbmp.PixelFormat:=pf1bit
   else
      tmpbmp.PixelFormat:=pf24bit;
   tmpbmp.Width:=dxDst;
   tmpbmp.Height:=stripHeight;
   // copy strips
   DestCanvas.CopyMode:=cmSrcCopy;
   GammaInit:=false;
   yy:=0;
   for y:=0 to dyDst-1 do begin
      src:=resbmp.Scanline[y];
      dst:=tmpbmp.Scanline[yy];
      copymemory(dst,src,resbmp.RowLen);
      if yy<stripHeight-1 then
         inc(yy)
      else begin
         // apply gamma
         if (tmpbmp.PixelFormat=pf24bit) and (Gamma<>1) and (Gamma>0) then begin
            if not GammaInit then begin
               // calc gamma LUT
               InvGamma := 1.0/Gamma;
               for i:=0 to 255 do
                  lut[i]:=blimit(round(255*iepower(i*Inv255,InvGamma)));
               GammaInit:=true;
            end;
            for y1:=0 to tmpbmp.Height-1 do begin
               px:=tmpbmp.Scanline[y1];
               for x1:=0 to tmpbmp.Width-1 do begin
                  with px^ do begin
                     r:=lut[r];
                     g:=lut[g];
                     b:=lut[b];
                  end;
                  inc(px);
               end;
            end;
         end;
         // draw to canvas
         {$ifdef IEKYLIX}
         DestCanvas.Draw(xDst,yDst,tmpbmp);
         {$endif}
         {$ifdef IEDELPHI}
         PrintPict(DestCanvas,xDst,yDst,tmpbmp);
         {$endif}
         // next strip
         inc(yDst,stripHeight);
         stripHeight:=imin( (dyDst-y-1), stripHeight );
         if (tmpbmp.Height<>stripHeight) and (stripHeight>0) then
            tmpbmp.Height:=stripHeight;
         yy:=0;
      end;
   end;
   //
   FreeAndNil(resbmp);
   FreeAndNil(tmpbmp);
end;
{$endif}
{$ifdef IEDELPHI}
procedure TIEBitmap.RenderToCanvas(DestCanvas:TCanvas; xDst,yDst,dxDst,dyDst:integer; Filter:TResampleFilter; Gamma:double);
const
   Inv255 = 1.0 / 255;
var
   i: Integer;
   InvGamma: double;
   lut:array [0..255] of byte;
   resbmp:TIEBitmap;
   stripHeight,y,y1,x1:integer;
   px:PRGB;
	hdib:THandle;
begin
	if (fWidth=0) or (fHeight=0) then exit;
   if (Filter=rfNone) and ((Gamma=1) or (Gamma=0)) then begin

      hdib:=_CopyBitmaptoDIBEx(Self,0,0,fWidth,fHeight);
      try
       _DIBDrawTo(DestCanvas,hdib,0,0,fWidth,fHeight,xDst,yDst,dxDst,dyDst);
      finally
       GlobalFree(hdib);
      end;//try..finally 

   end else begin
      // calc stripHeight
      stripHeight:=fMinFileSize div IEBitmapRowLen(dxDst,24,fBitAlignment);
      stripHeight:=imin(dyDst,stripHeight);
      Assert(stripHeight > 0);
      // resample to resbmp
      resbmp:=TIEBitmap.Create;
      resbmp.Allocate(dxDst,dyDst,fPixelFormat);
      if (Filter=rfNone) then
         // 1bit or 24bit unfiltered
         _IEBmpStretchEx(self,resbmp,nil,nil)
      else if (fPixelFormat=ie1g) then begin
         // 1bit filtered
         resbmp.PixelFormat:=ie24RGB;
         _Resample1BitEx(self,resbmp,Filter);
      end else
         // 24bit filtered
         _ResampleEx(self,resbmp,Filter,nil, nil);
      // copy strips
      DestCanvas.CopyMode:=cmSrcCopy;
      // apply gamma
      if (resbmp.PixelFormat=ie24RGB) and (Gamma<>1) and (Gamma>0) then begin
         // calc gamma LUT
         InvGamma := 1.0/Gamma;
         for i:=0 to 255 do
            lut[i]:=blimit(round(255*iepower(i*Inv255,InvGamma)));
         for y1:=0 to resbmp.Height-1 do begin
            px:=resbmp.Scanline[y1];
            for x1:=0 to resbmp.Width-1 do begin
               with px^ do begin
                  r:=lut[r];
                  g:=lut[g];
                  b:=lut[b];
               end;
               inc(px);
            end;
         end;
      end;
      //
      y:=0;
      while y<dyDst do begin
         // draw to canvas
         PrintPict(DestCanvas,xDst,yDst,resbmp,0,y,resbmp.Width,stripHeight);
         // next strip
         inc(yDst,stripHeight);
         inc(y,stripHeight);
         stripHeight:=imin( (dyDst-y), stripHeight );
      end;
      //
      FreeAndNil(resbmp);
   end;
end;
{$endif}

// ABitmapScanline can be nil
// XLUT,YLUT: x and y screen to bitmap convertion table, can be NIL
// ABitmap must be pf24bit under Delphi or pf32bit under Kylix
procedure TIEBitmap.RenderToTBitmap(ABitmap:TBitmap; var ABitmapScanline:ppointerarray; var XLUT,YLUT:pinteger;
    UpdRect:PRect; xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer; EnableAlpha:boolean;
    SolidBackground:boolean; Transparency:integer; Filter:TResampleFilter; FreeTables:boolean;
    RenderOperation:TIERenderOperation);
var
	i,y,x,ww,hh:integer;
   DBitmapScanline:ppointerarray;
	x1,y1,x2,y2:integer;
	rx,ry:integer;
   cx1,cy1,cx2,cy2:integer;
   SimAlphaRow:pbyte;   // the simulated alpha channel, needed when TIELayer.GlobalAlpha is not 255 (255=opaque)
   UseAlpha:boolean;
   sxarr,psx,syarr,psy:pinteger;
   ietmp1,ietmp2:TIEBitmap;
   {$ifdef IEDEBUG}
   deb1:dword;
   {$endif}
   dummy1,dummy2:pinteger;
   zx,zy:double;
   laccess:TIEDataAccess;
begin
	try
   laccess:=Access;
   Access:=[iedRead];
	if (dxDst=0) or (dyDst=0) or (dxSrc=0) or (dySrc=0) then exit;
   if yDst>ABitmap.Height-1 then exit;
   if xDst>ABitmap.Width-1 then exit;
	zy:=dySrc/dyDst;
   zx:=dxSrc/dxDst;
	if yDst<0 then begin
   	y:=-yDst;
      yDst:=0;
      dec(dyDst,y);
		inc(ySrc,  trunc(y*zy) );
      dec(dySrc, trunc(y*zy) );
   end;
   if xDst<0 then begin
   	x:=-xDst;
      xDst:=0;
      dec(dxDst,x);
		inc(xSrc,  trunc(x*zx) );
      dec(dxSrc, trunc(x*zx) );
   end;
   if yDst+dyDst>ABitmap.Height then begin
   	y:=yDst+dyDst-ABitmap.Height;
      dyDst:=ABitmap.Height-yDst;
      dec(dySrc, trunc(y*zy) );
   end;
   if xDst+dxDst>ABitmap.Width then begin
   	x:=xDst+dxDst-ABitmap.Width;
      dxDst:=ABitmap.Width-xDst;
      dec(dxSrc, trunc(x*zx) );
   end;
	xDst:=imax(imin(xDst,ABitmap.Width-1),0);
   yDst:=imax(imin(yDst,ABitmap.Height-1),0);
   dxDst:=imax(imin(dxDst,ABitmap.Width),0);
   dyDst:=imax(imin(dyDst,ABitmap.Height),0);
   xSrc:=imax(imin(xSrc,Width-1),0);
   ySrc:=imax(imin(ySrc,Height-1),0);
   dxSrc:=imax(imin(dxSrc,Width),0);
   dySrc:=imax(imin(dySrc,Height),0);
	//
	if (Filter<>rfNone) and ((dxSrc<>dxDst) or (dySrc<>dyDst)) and ((PixelFormat=ie1g) or (PixelFormat=ie24RGB)) then begin
      dummy1:=nil;
      dummy2:=nil;
   	// need to resample using a filter
      if (dxDst<=dxSrc) and (PixelFormat=ie1g) and ((not EnableAlpha) or (not HasAlphaChannel)) then begin
         // subsample 1 bit bitmap
         if (dxDst>0) and (dyDst>0) then begin
            ietmp1:=TIEBitmap.Create;
            ietmp1.Allocate(dxDst,dyDst,ie24RGB);
            _SubResample1bitFilteredEx(self,xSrc,ySrc,xSrc+dxSrc-1,ySrc+dySrc-1,ietmp1);
            ietmp1.RenderToTBitmap(ABitmap,ABitmapScanline,dummy1,dummy2,UpdRect,xDst,yDst,dxDst,dyDst,0,0,dxDst,dyDst,EnableAlpha,SolidBackground,Transparency,rfNone,true,RenderOperation);
            FreeAndNil(ietmp1);
         end;
      end else if (PixelFormat=ie24RGB) or (PixelFormat=ie1g) then begin
      	// sub/over resample 1/24 bits bitmap
         ietmp1:=TIEBitmap.Create;
         ietmp1.Allocate(dxSrc,dySrc,PixelFormat);
         CopyRectTo(ietmp1,xSrc,ySrc,0,0,dxSrc,dySrc);
         if EnableAlpha and HasAlphaChannel then begin
         	AlphaChannel.CopyRectTo(ietmp1.AlphaChannel,xSrc,ySrc,0,0,dxSrc,dySrc);
            ietmp1.AlphaChannel.Full:=AlphaChannel.Full;
         end;
         ietmp2:=TIEBitmap.Create;
         ietmp2.Allocate(dxDst,dyDst,ie24RGB);
         if PixelFormat=ie1g then
            _Resample1bitEx(ietmp1,ietmp2,Filter)
         else
            _ResampleEx(ietmp1,ietmp2,Filter,nil,nil);
         if EnableAlpha and HasAlphaChannel then begin
            _ResampleAlphaEx(ietmp1.AlphaChannel,ietmp2.AlphaChannel,Filter);
            ietmp2.AlphaChannel.Full:=ietmp1.AlphaChannel.Full;
         end;
         for i:=0 to IEMAXCHANNELS-1 do
	         ietmp2.fChannelOffset[i]:=fChannelOffset[i];
         ietmp2.fEnableChannelOffset:=fEnableChannelOffset;
         ietmp2.fContrast:=fContrast;
         ietmp2.RenderToTBitmap(ABitmap,ABitmapScanline,dummy1,dummy2,UpdRect,xDst,yDst,dxDst,dyDst,0,0,dxDst,dyDst,EnableAlpha,SolidBackground,Transparency,rfNone,true,RenderOperation);
         FreeAndNil(ietmp2);
         FreeAndNil(ietmp1);
      end;
		exit;	// EXIT POINT
   end;
   {$ifdef IEDEBUG}
   deb1:=gettickcount;
   {$endif}
   if (dxDst=0) or (dyDst=0) or (dxSrc=0) or (dySrc=0) then exit;
	ww:=ABitmap.Width;
   hh:=ABitmap.Height;
	if ABitmapScanline=nil then begin
      getmem(DBitmapScanline,hh*sizeof(pointer));
      for y:=0 to hh-1 do
         DBitmapScanline[y]:=ABitmap.Scanline[y];
   end else
   	DBitmapScanline:=ABitmapScanline;
	//
   if (dxDst<>0) and (dyDst<>0) then begin
      SimAlphaRow:=nil;
      if (Transparency<255) then begin
         if SimAlphaRow=nil then
            getmem(SimAlphaRow,Width);
         l3fillchar(SimAlphaRow^,Width,Transparency);
      end;
      sxarr:=nil;
      syarr:=nil;
      try
      ry:=trunc((dySrc/dyDst)*16384);  // 2^14
      rx:=trunc((dxSrc/dxDst)*16384);
      y2:=imin(yDst+dyDst-1,hh-1);
      x2:=imin(xDst+dxDst-1,ww-1);
      // set update rect
      if UpdRect<>nil then begin
         cx1:=UpdRect^.Left;
         cy1:=UpdRect^.Top;
         cx2:=UpdRect^.Right;
         cy2:=UpdRect^.Bottom;
      end else begin
         cx1:=-2147483646;
         cy1:=-2147483646;
         cx2:=2147483646;
         cy2:=2147483646;
      end;
      cx1:=imax(cx1,xDst);
      cx2:=imin(cx2,x2);
      cy1:=imax(cy1,yDst);
      cy2:=imin(cy2,y2);
      //
      cx1:=imax(cx1,0);
      cx1:=imin(cx1,ABitmap.Width-1);
      cx2:=imax(cx2,0);
      cx2:=imin(cx2,ABitmap.Width-1);
      cy1:=imax(cy1,0);
      cy1:=imin(cy1,ABitmap.Height-1);
      cy2:=imax(cy2,0);
      cy2:=imin(cy2,ABitmap.Height-1);
      //
      UseAlpha:=EnableAlpha and HasAlphaChannel and (not AlphaChannel.Full);
      if (ry<>16384) or (rx<>16384) or (PixelFormat=ie1g) or (PixelFormat=ie16g) or (PixelFormat=ie32f) or {$ifdef IEKYLIX} true or {$endif}
         (PixelFormat=ie8g) or (PixelFormat=ie8p) or (Transparency<255) or UseAlpha or fEnableChannelOffset or (fContrast<>0) or (RenderOperation<>ielNormal) then begin
      	if XLUT<>nil then begin
         	// set provided horizontal LUT
            sxarr:=XLUT;
            inc(sxarr,cx1-xDst);
         end else begin
            // build horizontal LUT
            getmem(sxarr,(cx2-cx1+1)*sizeof(integer));
            psx:=sxarr;
            for x:=cx1 to cx2 do begin
               psx^:=(rx*(x-xDst) shr 14)+xSrc;
               inc(psx);
            end;
         end;
         if YLUT<>nil then begin
         	// set provided vertical LUT
            syarr:=YLUT;
            inc(syarr,cy1-yDst);
         end else begin
            // build vertical LUT
            getmem(syarr,(cy2-cy1+1)*sizeof(integer));
            psy:=syarr;
            for y:=cy1 to cy2 do begin
               psy^:=(ry*(y-yDst) shr 14)+ySrc;
               inc(psy);
            end;
         end;
      end;
      {$ifdef IEDEBUG}
      (*
      OutputDebugString(PAnsiChar('ABitmap.Width='+inttostr(ABitmap.Width)+'  ABitmap.Height='+inttostr(ABitmap.Height) ));
      OutputDebugString(PAnsiChar('IEBitmap.Width='+inttostr(Width)+'  IEBitmap.Height='+inttostr(Height) ));
      OutputDebugString(PAnsiChar( 'xSrc='+inttostr(xSrc)+'  ySrc='+inttostr(ySrc) ));
      OutputDebugString(PAnsiChar( 'xDst='+inttostr(xDst)+'  yDst='+inttostr(yDst) ));
      OutputDebugString(PAnsiChar( 'cx1='+inttostr(cx1)+'  cy1='+inttostr(cy1)+'  cx2='+inttostr(cx2)+'  cy2='+inttostr(cy2) ));
      OutputDebugString(PAnsiChar( 'rx='+inttostr(rx)+'  ry='+inttostr(ry) ));
      *)
      {$endif}
      if (Transparency<255) or UseAlpha then begin
      	// Draw with alpha channel
         case PixelFormat of
            ie1g:
               // 1 bit per pixel
               Render_ie1g_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie8g:
               // 8 bit gray scale
               Render_ie8g_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie8p:
               // 8 bit color mapped
               Render_ie8p_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie16g:
               // 16 bit gray scale
               Render_ie16g_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie24RGB:
               // 24 bits per pixel
               Render_ie24RGB_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground,RenderOperation);
            ie32f:
               // 32 bit float point gray scale
               Render_ie32f_alpha(dbitmapscanline,ABitmap,Transparency,UseAlpha,SimAlphaRow,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
         end;
      end else begin
      	// Draw without alpha channel
         case PixelFormat of
            ie1g:
               // 1 bit per pixel
               Render_ie1g(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie8g:
               // 8 bit gray scale
               Render_ie8g(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie8p:
               // 8 bit color mapped
               Render_ie8p(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie16g:
               // 16 bit gray scale
               Render_ie16g(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
            ie24RGB:
               // 24 bits per pixel
               Render_ie24RGB(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground,RenderOperation);
            ie32f:
               // 32 bit float point gray scale
               Render_ie32f(dbitmapscanline,ABitmap,sxarr,syarr,xSrc,ySrc,xDst,yDst,cx1,cy1,cx2,cy2,rx,ry,SolidBackground);
         end;
      end;
      except
      	{$ifdef IEDEBUG}
         OutputDebugString('TIEBitmap.RenderToTBitmap: EXCEPTION!');
         {$endif}
      end;
      if SimAlphaRow<>nil then
         FreeMem(SimAlphaRow);
      if (sxarr<>nil) and (XLUT=nil) then begin
      	if FreeTables then
	         freemem(sxarr)
         else
         	XLUT:=sxarr;
      end;
      if (syarr<>nil) and (YLUT=nil) then begin
      	if FreeTables then
	      	freemem(syarr)
         else
         	YLUT:=syarr;
      end;
   end;
	//
   if ABitmapScanline=nil then begin
   	if FreeTables then
	      freemem(DBitmapScanline)
      else
      	ABitmapScanline:=DBitmapScanline;
   end;
   {$ifdef IEDEBUG}
   deb1:=gettickcount-deb1;
   OutputDebugString(PAnsiChar('TIEBitmap.RenderToTBitmap: '+inttostr(deb1)+'ms'));
   {$endif}
   finally
   	Access:=laccess;
   end;
end;

procedure TIEBitmap.Render_ie8p(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   x,y,rl,l:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   pwb:pbytearray;
   sr,sg,sb:integer;
begin
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwb:=Scanline[psy^];
      psx:=sxarr;
      for x:=cx1 to cx2 do begin
         with fRGBPalette[pwb[psx^]] do begin
            sr:=r;
            sg:=g;
            sb:=b;
         end;
         with px2^ do begin
            r:=sr;
            g:=sg;
            b:=sb;
         end;
         inc(px2);
         inc(psx);
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie8p_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,rl,l:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   pwb:pbytearray;
   sr,sg,sb:integer;
begin
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwb:=Scanline[psy^];
      if UseAlpha then
         px3:=AlphaChannel.ScanLine[psy^]
      else
         px3:=PByteArray(SimAlphaRow);
      psx:=sxarr;
      for x:=cx1 to cx2 do begin
         alpha:=imin(Transparency,px3[psx^]) shl 10;
         with fRGBPalette[pwb[psx^]] do begin
            sr:=r;
            sg:=g;
            sb:=b;
         end;
         with px2^ do begin
            r:=(alpha*(sr-r) shr 18 +r);
            g:=(alpha*(sg-g) shr 18 +g);
            b:=(alpha*(sb-b) shr 18 +b);
         end;
         inc(px2);
         inc(psx);
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie8g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   x,y,v:integer;
   pwb:pbytearray;
   black,white:integer;
   range:double;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
begin
	black:=trunc(fBlackValue);
   white:=trunc(fWhiteValue);
   range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwb:=Scanline[psy^];
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            with px2^ do begin
               r:=pwb[ psx^ ];
               g:=r;
               b:=r;
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
      	// applies fBlackValue and fWhiteValue
         for x:=cx1 to cx2 do begin
            v:=pwb[ psx^ ];
            if v<=black then v:=black;
            if v>=white then v:=white;
            v:= trunc( ((v-black)/range)*255 );
            with px2^ do begin
               r:=v;
               g:=v;
               b:=v;
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie8g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,rl,l:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   pwb:pbytearray;
   black,white:integer;
   range:double;
begin
	black:=trunc(fBlackValue);
   white:=trunc(fWhiteValue);
   range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwb:=Scanline[psy^];
      if UseAlpha then
         px3:=AlphaChannel.ScanLine[psy^]
      else
         px3:=PByteArray(SimAlphaRow);
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
            l:=pwb[psx^];
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
            l:=pwb[psx^];
            if l<=black then l:=black;
            if l>=white then l:=white;
            l:= trunc( ((l-black)/range)*255 );
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie16g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   x,y,v:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   pwa:pwordarray;
   black,white:integer;
   range:double;
begin
	black:=trunc(fBlackValue);
   white:=trunc(fWhiteValue);
   range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwa:=Scanline[psy^];
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            with px2^ do begin
               r:=pwa[ psx^ ] shr 8;
               g:=r;
               b:=r;
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
      	// applies fBlackValue and fWhiteValue
         for x:=cx1 to cx2 do begin
         	v:=pwa[psx^];
            if v<=black then v:=black;
            if v>=white then v:=white;
            v:= trunc( ((v-black)/range)*255 );
            with px2^ do begin
               r:=v;
               g:=v;
               b:=v;
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie16g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,l,rl:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   pwa:pwordarray;
   pwb:pbytearray;
   black,white:integer;
   range:double;
begin
	black:=trunc(fBlackValue);
   white:=trunc(fWhiteValue);
   range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwa:=Scanline[psy^];
      if UseAlpha then
         px3:=AlphaChannel.ScanLine[psy^]
      else
         px3:=PByteArray(SimAlphaRow);
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
            l:=pwa[psx^] shr 8;
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
      	// applies fBlackValue and fWhiteValue
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
         	l:=pwa[psx^];
            if l<=black then l:=black;
            if l>=white then l:=white;
            l:= trunc( ((l-black)/range)*255 );
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie32f(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   x,y,l:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   pwa:psinglearray;
   range:double;
   v:single;
begin
   range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwa:=Scanline[psy^];
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            with px2^ do begin
               r:=trunc(pwa[ psx^ ]*255);
               g:=r;
               b:=r;
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
      	// applies fBlackValue and fWhiteValue
         for x:=cx1 to cx2 do begin
         	v:=pwa[psx^];
            if v<=fBlackValue then v:=fBlackValue;
            if v>=fWhiteValue then v:=fWhiteValue;
            l:= trunc( ((v-fBlackValue)/range)*255 );
            with px2^ do begin
               r:=l;
               g:=l;
               b:=l;
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie32f_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,l,rl:integer;
   //px2,px4:prgb;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   pwa:psinglearray;
   pwb:pbytearray;
   range:double;
   v:single;
begin
	range:=fWhiteValue-fBlackValue;
	//
   sxarr:=XLUT;
	syarr:=YLUT;
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      px2:=dBitmapScanline[y]; inc(px2,cx1);
      pwa:=Scanline[psy^];
      if UseAlpha then
         px3:=AlphaChannel.ScanLine[psy^]
      else
         px3:=PByteArray(SimAlphaRow);
      psx:=sxarr;
      if range=0 then begin
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
            l:=trunc(pwa[psx^]*255);
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end else begin
      	// applies fBlackValue and fWhiteValue
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
         	v:=pwa[psx^];
            if v<=fBlackValue then v:=fBlackValue;
            if v>=fWhiteValue then v:=fWhiteValue;
            l:= trunc( ((v-fBlackValue)/range)*255 );
            with px2^ do begin
               r:=(alpha*(l-r) shr 18 +r);
               g:=(alpha*(l-g) shr 18 +g);
               b:=(alpha*(l-b) shr 18 +b);
            end;
            inc(px2);
            inc(psx);
         end;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie1g(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   x,y,l,rl,ww:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
begin
	ww:=ABitmap.Width;
   sxarr:=XLUT;
	syarr:=YLUT;
   l:=-1;
   rl:=_PixelFormat2RowLen(ww,abitmap.pixelformat);
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      if (l=psy^) and SolidBackground then begin
         copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
      end else begin
         px2:=dBitmapScanline[y]; inc(px2,cx1);
         px1:=Scanline[psy^];
         psx:=sxarr;
         for x:=cx1 to cx2 do begin
            if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7])=0 then begin
               pword(px2)^:=0;	// set b,g
               inc(pword(px2));
               pbyte(px2)^:=0;	// set r
               inc(pbyte(px2));
            end else begin
               pword(px2)^:=$ffff; 	// set b,g
               inc(pword(px2));
               pbyte(px2)^:=$ff;		// set r
               inc(pbyte(px2));
            end;
            {$ifdef IEKYLIX}
            inc(pbyte(px2));
            {$endif}
            inc(psx);
         end;
         l:=psy^;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.Render_ie1g_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,l,rl,ww:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
begin
	ww:=ABitmap.Width;
   sxarr:=XLUT;
	syarr:=YLUT;
   l:=-1;
   rl:=_PixelFormat2RowLen(ww,abitmap.pixelformat);
   psy:=syarr;
   for y:=cy1 to cy2 do begin
      if (l=psy^) and SolidBackground {$ifdef IEKYLIX}and false{$endif}then begin
         copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
      end else begin
         px2:=dBitmapScanline[y]; inc(px2,cx1);
         px1:=Scanline[psy^];
         if UseAlpha then
            px3:=AlphaChannel.ScanLine[psy^]
         else
            px3:=PByteArray(SimAlphaRow);
         psx:=sxarr;
         for x:=cx1 to cx2 do begin
            alpha:=imin(Transparency,px3[psx^]) shl 10;
            if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7])=0 then
               with px2^ do begin
                  r:=(alpha*(0-r) shr 18 +r);
                  g:=(alpha*(0-g) shr 18 +g);
                  b:=(alpha*(0-b) shr 18 +b);
               end
            else
               with px2^ do begin
                  r:=(alpha*(255-r) shr 18 +r);
                  g:=(alpha*(255-g) shr 18 +g);
                  b:=(alpha*(255-b) shr 18 +b);
               end;
            inc(px2);
            inc(psx);
         end;
         l:=psy^;
      end;
      inc(psy);
   end
end;

procedure TIEBitmap.SetChannelOffset(idx:integer; value:integer);
var
	i:integer;
begin
	if (idx>=0) and (idx<IEMAXCHANNELS) then
		fChannelOffset[idx]:=value;
   fEnableChannelOffset:=false;
   for i:=0 to IEMAXCHANNELS-1 do
   	if fChannelOffset[i]<>0 then begin
      	fEnableChannelOffset:=true;
         break;
      end;
end;

function TIEBitmap.GetChannelOffset(idx:integer):integer;
begin
	if (idx>=0) and (idx<IEMAXCHANNELS) then
		result:=fChannelOffset[idx]
   else
   	result:=0;
end;

procedure IEBlend(var src:TRGB; var dst:TRGB; RenderOperation:TIERenderOperation);
var
 lMaxComponent: Byte;
	// filters
   function softlight(ib,ia:integer):integer;
   var
   	a,b,r:double;
   begin
		a:=ia/255;
      b:=ib/255;
      if b<0.5 then
      	r:=2 * a * b + sqr(a) * (1 - 2 * b)
      else
      	r:=sqrt(a) * (2 * b - 1) + (2 * a) * (1 - b);
      result:=trunc(r*255);
   end;
   function xfader(b,a:integer):integer;
   var
   	c:integer;
   begin
   	c := a * b SHR 8;
		result := c + a * (255 - ((255-a)*(255-b) SHR 8)-c) SHR 8;
   end;
   function coloredge(b,a:integer):integer;
   var
   	c:integer;
   begin
   	if b = 255 then
  			result := 255
		else begin
  			c := (a SHL 8) DIV (255-b);
  			if c > 255 then result := 255 else result := c;
		end;
   end;
   function colorburn(b,a:integer):integer;
   var
   	c:integer;
   begin
     if b = 0 then
       result := 0
     else begin
       c := 255 - (((255-a) SHL 8) DIV b);
       if c < 0 then result := 0 else result := c;
     end;
   end;
   function inversecolordodge(b,a:integer):integer;
   var
   	c:integer;
	begin
      if a = 255 then
        result := 255
      else begin
        c := (b SHL 8) DIV (255-a);
        if c > 255 then result := 255 else result := c;
      end;
	end;
   function inversecolorburn(b,a:integer):integer;
   var
   	c:integer;
   begin
      if a = 0 then
        result := 0
      else begin
        c := 255 - (((255-b) SHL 8) DIV a);
        if c < 0 then result := 0 else result := c;
      end;
   end;
   function softdodge(b,a:integer):integer;
   var
   	c:integer;
   begin
      if a + b < 256 then begin
        if b = 255 then
          result := 255
        else begin
          c := (a SHL 7) DIV (255-b);
          if c > 255 then result := 255 else result := c;
        end;
      end
      else begin
        c := 255 - (((255-b) SHL 7) DIV a);
        if c < 0 then result := 0 else result := c;
      end;
   end;
   function softburn(b,a:integer):integer;
   var
   	c:integer;
   begin
      if a+b < 256 then begin
        if a = 255 then
          Result := 255
        else begin
          c := (b SHL 7) DIV (255-a);
          if c > 255 then Result := 255 else Result := c;
        end;
      end
      else begin
        c := 255-(((255-a) SHL 7) DIV b);
        if c < 0 then Result := 0 else Result := c;
      end;
   end;
   function reflect(b,a:integer):integer;
   var
   	c:integer;
   begin
      if b = 255 then
        result := 255
      else begin
        c := a*a DIV (255-b);
        if c > 255 then result := 255 else result := c;
      end;
   end;
   function glow(b,a:integer):integer;
   var
   	c:integer;
   begin
      if a = 255 then
        result := 255
      else begin
        c := b*b DIV (255-a);
        if c > 255 then result := 255 else result := c;
      end;
   end;
   function freeze(b,a:integer):integer;
   var
   	c:integer;
   begin
      if b = 0 then
        result := 0
      else begin
        c := 255 - sqr(255-a) DIV b;
        if c < 0 then result := 0 else result := c;
      end;
	end;
   function eat(b,a:integer):integer;
   var
   	c:integer;
   begin
      if a = 0 then
        result := 0
      else begin
        c := 255 - sqr(255-b) DIV a;
        if c < 0 then result := 0 else result := c;
      end;
   end;
   function interpolation(b,a:integer):integer;
   var
   	c:integer;
   begin
      c := IECosineTab[b] + IECosineTab[a];
      if c > 255 then result := 255 else result := c;
   end;
   function stamp(b,a:integer):integer;
   var
   	c:integer;
   begin
      c := a + 2*b - 256;
      if c < 0 then
        result := 0
      else if c > 255 then
        result := 255
      else
        result := c;
   end;
   //
   var
   	Ha,Sa,La:double;
      Hb,Sb,Lb:double;
begin
   case RenderOperation of
      ielNormal:
         begin
            dst.r:=src.r;
            dst.g:=src.g;
            dst.b:=src.b;
         end;
      ielAdd:
         begin
            dst.r:=blimit(dst.r+ src.r);
            dst.g:=blimit(dst.g+ src.g);
            dst.b:=blimit(dst.b+ src.b);
         end;
      ielSub:
         begin
            dst.r:=abs(dst.r- src.r);
            dst.g:=abs(dst.g- src.g);
            dst.b:=abs(dst.b- src.b);
         end;
      ielDiv:
         begin
            dst.r:=blimit(dst.r div ilimit( src.r,1,255));
            dst.g:=blimit(dst.g div ilimit( src.g,1,255));
            dst.b:=blimit(dst.b div ilimit( src.b,1,255));
         end;
      ielMul:
         begin
            dst.r:=(dst.r * src.r) shr 8;
            dst.g:=(dst.g * src.g) shr 8;
            dst.b:=(dst.b * src.b) shr 8;
         end;
      ielOR:
         begin
            dst.r:=blimit(dst.r or src.r);
            dst.g:=blimit(dst.g or src.g);
            dst.b:=blimit(dst.b or src.b);
         end;
      ielAND:
         begin
            dst.r:=blimit(dst.r and src.r);
            dst.g:=blimit(dst.g and src.g);
            dst.b:=blimit(dst.b and src.b);
         end;
      ielXOR:
         begin
            dst.r:=blimit(dst.r xor src.r);
            dst.g:=blimit(dst.g xor src.g);
            dst.b:=blimit(dst.b xor src.b);
         end;
      ielMAX:
         begin
            dst.r:=imax(dst.r , src.r);
            dst.g:=imax(dst.g , src.g);
            dst.b:=imax(dst.b , src.b);
         end;
      ielMIN:
         begin
            dst.r:=imin(dst.r , src.r);
            dst.g:=imin(dst.g , src.g);
            dst.b:=imin(dst.b , src.b);
         end;
      ielAverage:
         begin
            dst.r:=(dst.r + src.r) shr 1;
            dst.g:=(dst.g + src.g) shr 1;
            dst.b:=(dst.b + src.b) shr 1;
         end;
      ielScreen:
      	begin
         	dst.r := 255 - ((255-dst.r) * (255-src.r) SHR 8);
            dst.g := 255 - ((255-dst.g) * (255-src.g) SHR 8);
            dst.b := 255 - ((255-dst.b) * (255-src.b) SHR 8);
         end;
      ielNegation:
      	begin
         	dst.r := 255 - abs(255-src.r-dst.r);
            dst.g := 255 - abs(255-src.g-dst.g);
            dst.b := 255 - abs(255-src.b-dst.b);
         end;
      ielExclusion:
      	begin
         	dst.r := src.r + dst.r - (src.r*dst.r SHR 7);
            dst.g := src.g + dst.g - (src.g*dst.g SHR 7);
            dst.b := src.b + dst.b - (src.b*dst.b SHR 7);
         end;
      ielOverlay:
      	begin
         	if dst.r < 128 then dst.r := (src.r*dst.r) SHR 7 else dst.r := 255 - ((255-src.r) * (255-dst.r) SHR 7);
            if dst.g < 128 then dst.g := (src.g*dst.g) SHR 7 else dst.g := 255 - ((255-src.g) * (255-dst.g) SHR 7);
            if dst.b < 128 then dst.b := (src.b*dst.b) SHR 7 else dst.b := 255 - ((255-src.b) * (255-dst.b) SHR 7);
         end;
      ielHardLight:
      	begin
				if src.r < 128 then dst.r := (src.r*dst.r) SHR 7 else dst.r := 255 - ((255-src.r) * (255-dst.r) SHR 7);
            if src.g < 128 then dst.g := (src.g*dst.g) SHR 7 else dst.g := 255 - ((255-src.g) * (255-dst.g) SHR 7);
            if src.b < 128 then dst.b := (src.b*dst.b) SHR 7 else dst.b := 255 - ((255-src.b) * (255-dst.b) SHR 7);
         end;
      ielSoftLight:
      	begin
         	dst.r:=softlight(src.r,dst.r);
            dst.g:=softlight(src.r,dst.g);
            dst.b:=softlight(src.r,dst.b);
         end;
      ielXFader:
      	begin
         	dst.r:=XFader(src.r,dst.r);
            dst.g:=XFader(src.g,dst.g);
            dst.b:=XFader(src.b,dst.b);
         end;
      ielColorEdge:
      	begin
         	dst.r:=ColorEdge(src.r,dst.r);
            dst.g:=ColorEdge(src.g,dst.g);
            dst.b:=ColorEdge(src.b,dst.b);
         end;
      ielColorBurn:
      	begin
         	dst.r:=ColorBurn(src.r,dst.r);
            dst.g:=ColorBurn(src.g,dst.g);
            dst.b:=ColorBurn(src.b,dst.b);
         end;
      ielInverseColorDodge:
      	begin
         	dst.r:=InverseColorDodge(src.r,dst.r);
            dst.g:=InverseColorDodge(src.g,dst.g);
            dst.b:=InverseColorDodge(src.b,dst.b);
         end;
      ielInverseColorBurn:
      	begin
         	dst.r:=InverseColorBurn(src.r,dst.r);
            dst.g:=InverseColorBurn(src.g,dst.g);
            dst.b:=InverseColorBurn(src.b,dst.b);
         end;
      ielSoftDodge:
      	begin
         	dst.r:=SoftDodge(src.r,dst.r);
            dst.g:=SoftDodge(src.g,dst.g);
            dst.b:=SoftDodge(src.b,dst.b);
         end;
      ielSoftBurn:
      	begin
         	dst.r:=SoftBurn(src.r,dst.r);
            dst.g:=SoftBurn(src.g,dst.g);
            dst.b:=SoftBurn(src.b,dst.b);
         end;
      ielReflect:
      	begin
         	dst.r:=Reflect(src.r,dst.r);
            dst.g:=Reflect(src.g,dst.g);
            dst.b:=Reflect(src.b,dst.b);
         end;
      ielGlow:
      	begin
         	dst.r:=Glow(src.r,dst.r);
            dst.g:=Glow(src.g,dst.g);
            dst.b:=Glow(src.b,dst.b);
         end;
      ielFreeze:
      	begin
         	dst.r:=Freeze(src.r,dst.r);
            dst.g:=Freeze(src.g,dst.g);
            dst.b:=Freeze(src.b,dst.b);
         end;
      ielEat:
      	begin
         	dst.r:=Eat(src.r,dst.r);
            dst.g:=Eat(src.g,dst.g);
            dst.b:=Eat(src.b,dst.b);
         end;
      ielSubtractive:
         begin
            dst.r:=blimit(dst.r+ src.r -256);
            dst.g:=blimit(dst.g+ src.g -256);
            dst.b:=blimit(dst.b+ src.b -256);
         end;
      ielInterpolation:
      	begin
         	dst.r:=Interpolation(src.r,dst.r);
            dst.g:=Interpolation(src.g,dst.g);
            dst.b:=Interpolation(src.b,dst.b);
         end;
      ielStamp:
      	begin
         	dst.r:=Stamp(src.r,dst.r);
            dst.g:=Stamp(src.g,dst.g);
            dst.b:=Stamp(src.b,dst.b);
         end;
      ielRed:
      	begin
         	dst.r:=src.r;
         end;
      ielGreen:
      	begin
         	dst.g:=src.g;
         end;
      ielBlue:
      	begin
         	dst.b:=src.b;
         end;
      ielHue:
      	begin
         	RGB2HSL(src,Ha,Sa,La);
            RGB2HSL(dst,Hb,Sb,Lb);
            HSL2RGB(dst,Ha,Sb,Lb);
         end;
      ielSaturation:
      	begin
         	RGB2HSL(src,Ha,Sa,La);
            RGB2HSL(dst,Hb,Sb,Lb);
            HSL2RGB(dst,Hb,Sa,Lb);
         end;
      ielColor:
      	begin
         	RGB2HSL(src,Ha,Sa,La);
            RGB2HSL(dst,Hb,Sb,Lb);
            HSL2RGB(dst,Ha,Sa,Lb);
         end;
      ielLuminosity:
      	begin
         	RGB2HSL(src,Ha,Sa,La);
            RGB2HSL(dst,Hb,Sb,Lb);
            HSL2RGB(dst,Ha,Sb,La);
         end;
      ielGreyDown:
       begin
        if src.r > src.g then
         lMaxComponent := src.r
        else
         lMaxComponent := src.g;
        if src.b > lMaxComponent then
         lMaxComponent := src.b;
        dst.r := lMaxComponent;
        dst.g := lMaxComponent;
        dst.b := lMaxComponent; 
       end;
   end;
end;

procedure TIEBitmap.CreateAlphaChannel;
begin
 if fAlphaChannel = nil then
  fAlphaChannel:=TIEBitmap.CreateAsAlphaChannel(fWidth,fHeight,fLocation);
end;

procedure TIEBitmap.Render_ie24RGB(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean; RenderOperation:TIERenderOperation);
var
	psy,syarr,psx,sxarr:pinteger;
   a,x,y,l,rl,ww:integer;
   {$ifdef IEDELPHI}
   px4,px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   vi:integer;
   vv:TRGB;
begin
	ww:=ABitmap.Width;
   sxarr:=XLUT;
	syarr:=YLUT;
   l:=-1;
   rl:=_PixelFormat2RowLen(ww,abitmap.pixelformat);
   if fEnableChannelOffset or (fContrast<>0) or (RenderOperation<>ielNormal) then begin
   	// special drawing (channels separation)
      if fContrast>=0 then
         vi:=trunc((1+fContrast/10)*65536)
      else
         vi:=trunc((1-sqrt(-fContrast)/10)*65536);
      psy:=syarr;
      for y:=cy1 to cy2 do begin
         if (l=psy^) and SolidBackground then begin
            copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
         end else begin
            px2:=dBitmapScanline[y]; inc(px2,cx1);
            px1:=Scanline[psy^];
            psx:=sxarr;
            for x:=cx1 to cx2 do begin
               vv.r:=blimit( 128+(((px1[ psx^ ].r + fChannelOffset[0] -128)*vi)div 65536) );
               vv.g:=blimit( 128+(((px1[ psx^ ].g + fChannelOffset[1] -128)*vi)div 65536) );
               vv.b:=blimit( 128+(((px1[ psx^ ].b + fChannelOffset[2] -128)*vi)div 65536) );
               IEBLend(vv,px2^,RenderOperation);
               inc(px2);
               inc(psx);
            end;
            l:=psy^;
         end;
         inc(psy);
      end
   {$ifdef IEDELPHI}
   end else if (ry=16384) and (rx=16384) then begin
      // original sizes
      rl2:=integer(dbitmapscanline[1])-integer(dbitmapscanline[0]);
      px2:=dbitmapscanline[cy1];
      inc(px2,cx1);
      rl4:=(cx2-cx1+1)*3;
      for y:=cy1 to cy2 do begin
         px4:=scanline[ySrc+(y-yDst)]; inc(px4,xSrc+(cx1-xDst));
         copymemory( px2 , px4, rl4 );
         inc(pbyte(px2),rl2);
      end;
   {$endif}
   end else begin
      // subsample/oversample
      psy:=syarr;
      for y:=cy1 to cy2 do begin
         if (l=psy^) and SolidBackground {$ifdef IEKYLIX}and false{$endif} then begin
            copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
         end else begin
            px2:=dBitmapScanline[y]; inc(px2,cx1);
            px1:=Scanline[psy^];
            psx:=sxarr;
            for x:=cx1 to cx2 do begin

            	{$ifdef IEDELPHI}
               px2^:=px1[ psx^ ];
               {$endif}

               {$ifdef IEKYLIX}
               with px1[psx^] do begin
	               px2^.r:=r;
                  px2^.g:=g;
                  px2^.b:=b;
               end;
               {$endif}

               inc(px2);
               inc(psx);
            end;
            l:=psy^;
         end;
         inc(psy);
      end
   end;
end;

procedure TIEBitmap.Render_ie24RGB_alpha(dbitmapscanline:ppointerarray; var ABitmap:TBitmap; Transparency:integer; UseAlpha:boolean; SimAlphaRow:pbyte; XLUT,YLUT:pinteger; xSrc,ySrc:integer; xDst,yDst:integer; cx1,cy1,cx2,cy2:integer; rx,ry:integer; SolidBackground:boolean; RenderOperation:TIERenderOperation);
var
	psy,syarr,psx,sxarr:pinteger;
   alpha,x,y,l,rl,ww:integer;
   {$ifdef IEDELPHI}
   px2:prgb;
   {$endif}
   {$ifdef IEKYLIX}
   px2:prgba;
   {$endif}
   px4:prgb;
   px1:PRGBROW;
   px3:pbytearray;
   rl2,rl4:integer;
   vi:integer;
   vv,v1:TRGB;
begin
	ww:=ABitmap.Width;
   sxarr:=XLUT;
	syarr:=YLUT;
   l:=-1;
   rl:=_PixelFormat2RowLen(ww,abitmap.pixelformat);
   if fEnableChannelOffset or (fContrast<>0) or (RenderOperation<>ielNormal) then begin
   	// special drawing (channels separation)
      if fContrast>=0 then
         vi:=trunc((1+fContrast/10)*65536)
      else
         vi:=trunc((1-sqrt(-fContrast)/10)*65536);
      psy:=syarr;
      for y:=cy1 to cy2 do begin
         if (l=psy^) and SolidBackground then begin
            copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
         end else begin
            px2:=dBitmapScanline[y]; inc(px2,cx1);
            px1:=Scanline[psy^];
            if UseAlpha then
               px3:=AlphaChannel.ScanLine[psy^]
            else
               px3:=PByteArray(SimAlphaRow);
            psx:=sxarr;
            for x:=cx1 to cx2 do begin
            	alpha:=imin(Transparency,px3[psx^]) shl 10;
            	vv.r:=blimit( 128+(((px1[ psx^ ].r + fChannelOffset[0] -128)*vi)div 65536) );
               vv.g:=blimit( 128+(((px1[ psx^ ].g + fChannelOffset[1] -128)*vi)div 65536) );
               vv.b:=blimit( 128+(((px1[ psx^ ].b + fChannelOffset[2] -128)*vi)div 65536) );

               v1:=px2^;
               IEBLend(vv,v1,RenderOperation);

               px2^.r:=(alpha*(v1.r-px2^.r) shr 18 +px2^.r);
               px2^.g:=(alpha*(v1.g-px2^.g) shr 18 +px2^.g);
               px2^.b:=(alpha*(v1.b-px2^.b) shr 18 +px2^.b);

               inc(px2);
               inc(psx);
            end;
            l:=psy^;
         end;
         inc(psy);
      end
   end else begin
      psy:=syarr;
      for y:=cy1 to cy2 do begin
         if (l=psy^) and SolidBackground then begin
            copymemory(dbitmapscanline[y],dbitmapscanline[y-1],rl);
         end else begin
            px2:=dBitmapScanline[y]; inc(px2,cx1);
            px1:=Scanline[psy^];
            if UseAlpha then
               px3:=AlphaChannel.ScanLine[psy^]
            else
               px3:=PByteArray(SimAlphaRow);
            psx:=sxarr;
            for x:=cx1 to cx2 do begin
               alpha:=imin(Transparency,px3[psx^]) shl 10;
               with px2^ do begin
                  r:=(alpha*(px1[psx^].r-r) shr 18 +r);
                  g:=(alpha*(px1[psx^].g-g) shr 18 +g);
                  b:=(alpha*(px1[psx^].b-b) shr 18 +b);
               end;
               inc(px2);
               inc(psx);
            end;
            l:=psy^;
         end;
         inc(psy);
      end
   end;
end;


// note: this function doesn't merge the image with the background, but just replace it (image and alpha)
// Dest must be ie24RGB
// this function assumes that there is an alpha channel (if not creates it)
procedure TIEBitmap.StretchRectTo(Dest:TIEBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer; Filter:TResampleFilter; Transparency:integer);
var
	y,x,ww,hh:integer;
   px2,px4:prgb;
   px1:PRGBROW;
   px3:pbytearray;
   pb1,pb2:pbyte;
	x1,y1,x2,y2:integer;
	rx,ry:integer;
   a:integer;
   sr,sg,sb:integer;
   rl,rl2,rl4:integer;
   xx:integer;
   cx1,cy1,cx2,cy2:integer;
   fOffX,fOffY,frx,fry,fo1x,fo1y,fo2x,fo2y:integer;
   UseAlpha:boolean;
   sxarr,psx,syarr,psy:pinteger;
   ietmp1,ietmp2:TIEBitmap;
begin
	if (Filter<>rfNone) and ((dxSrc<>dxDst) or (dySrc<>dyDst))  then begin
   	// need to resample using a filter
      if (dxDst<=dxSrc) and (PixelFormat=ie1g) and (not HasAlphaChannel) then begin
         // subsample 1 bit bitmap
         if (dxDst>0) and (dyDst>0) then begin
            ietmp1:=TIEBitmap.Create;
            ietmp1.Allocate(dxDst,dyDst,ie24RGB);
            _SubResample1bitFilteredEx(self,xSrc,ySrc,xSrc+dxSrc-1,ySrc+dySrc-1,ietmp1);
            ietmp1.StretchRectTo(Dest,xDst,yDst,dxDst,dyDst,0,0,dxDst,dyDst,rfNone,Transparency);
            FreeAndNil(ietmp1);
         end;
      end else begin
      	// sub/over resample 1/24 bits bitmap
         ietmp1:=TIEBitmap.Create;
         ietmp1.Allocate(dxSrc,dySrc,PixelFormat);
         CopyRectTo(ietmp1,xSrc,ySrc,0,0,dxSrc,dySrc);
         if HasAlphaChannel then begin
         	AlphaChannel.CopyRectTo(ietmp1.AlphaChannel,xSrc,ySrc,0,0,dxSrc,dySrc);
            ietmp1.AlphaChannel.Full:=AlphaChannel.Full;
         end;
         ietmp2:=TIEBitmap.Create;
         ietmp2.Allocate(dxDst,dyDst,ie24RGB);
         if PixelFormat=ie1g then
            _Resample1bitEx(ietmp1,ietmp2,Filter)
         else
            _ResampleEx(ietmp1,ietmp2,Filter,nil,nil);
         if HasAlphaChannel then begin
            _ResampleAlphaEx(ietmp1.AlphaChannel,ietmp2.AlphaChannel,Filter);
            ietmp2.AlphaChannel.Full:=ietmp1.AlphaChannel.Full;
         end;
         ietmp2.StretchRectTo(Dest,xDst,yDst,dxDst,dyDst,0,0,dxDst,dyDst,rfNone,Transparency);
         FreeAndNil(ietmp2);
         FreeAndNil(ietmp1);
      end;
		exit;	// EXIT POINT
   end;
   fOffX:=xDst;
   fOffY:=yDst;
   frx:=dxDst;
   fry:=dyDst;
   fo1x:=xSrc;
   fo1y:=ySrc;
   fo2x:=dxSrc;
   fo2y:=dySrc;
	if (dxDst=0) or (dyDst=0) then exit;
	ww:=Dest.Width;
   hh:=Dest.Height;
	//
   if (dxDst<>0) and (dyDst<>0) then begin
      sxarr:=nil;
      syarr:=nil;
      try
      ry:=trunc((fo2y/fry)*16384);  // 2^14
      rx:=trunc((fo2x/frx)*16384);
      y2:=imin(fOffY+fry-1,hh-1);
      x2:=imin(fOffX+frx-1,ww-1);
      cx1:=-2147483646;
      cy1:=-2147483646;
      cx2:=2147483646;
      cy2:=2147483646;
      cx1:=imax(cx1,fOffX);
      cx2:=imin(cx2,x2);
      cy1:=imax(cy1,fOffY);
      cy2:=imin(cy2,y2);
      //
      cx1:=imax(cx1,0);
      cx2:=imin(cx2,Dest.Width-1);
      cy1:=imax(cy1,0);
      cy2:=imin(cy2,Dest.Height-1);
      //
      rl:=Dest.RowLen;
      //l:=-1;
      UseAlpha:=HasAlphaChannel and (not AlphaChannel.Full);
      if (ry<>16384) or (rx<>16384) or (PixelFormat=ie1g) or UseAlpha then begin
         // build horizontal LUT
         getmem(sxarr,(cx2-cx1+1)*sizeof(integer));
         psx:=sxarr;
         for x:=cx1 to cx2 do begin
            psx^:=(rx*(x-fOffX) shr 14)+fo1x;
            inc(psx);
         end;
         // build vertical LUT
         getmem(syarr,(cy2-cy1+1)*sizeof(integer));
         psy:=syarr;
         for y:=cy1 to cy2 do begin
            psy^:=(ry*(y-fOffy) shr 14)+fo1y;
            inc(psy);
         end;
      end;
      if UseAlpha then begin
      	// copy alpha channel
         if (ry=16384) and (rx=16384) then begin
            // original sizes
            rl4:=(cx2-cx1+1);
            for y:=cy1 to cy2 do begin
               pb1:=dest.AlphaChannel.Scanline[y]; inc(pb1,cx1);
               pb2:=AlphaChannel.scanline[fo1y+(y-fOffY)]; inc(pb2,fo1x+(cx1-fOffX));
               copymemory( pb1 , pb2, rl4 );
            end;
         end else begin
            // subsample/oversample
            psy:=syarr;
            for y:=cy1 to cy2 do begin
               pb2:=Dest.AlphaChannel.Scanline[y]; inc(pb2,cx1);
               pb1:=AlphaChannel.Scanline[psy^];
               psx:=sxarr;
               for x:=cx1 to cx2 do begin
                  pb2^:=pbytearray(pb1)[ psx^ ];
                  inc(pb2);
                  inc(psx);
               end;
               inc(psy);
            end
         end;
         for y:=cy1 to cy2 do begin
         	pb1:=Dest.AlphaChannel.Scanline[y]; inc(pb1,cx1);
            for x:=cx1 to cx2 do begin
            	pb1^:=imin(Transparency,pb1^);
               inc(pb1);
            end;
         end;
      end else
      	dest.AlphaChannel.FillRect(cx1,cy1,cx2,cy2,Transparency);
      case PixelFormat of
         ie24RGB:
            // 24 bits per pixel
            begin
               if (ry=16384) and (rx=16384) then begin
                  // original sizes
                  rl4:=(cx2-cx1+1)*3;
                  for y:=cy1 to cy2 do begin
                  	px2:=dest.Scanline[y]; inc(px2,cx1);
                     px4:=scanline[fo1y+(y-fOffY)]; inc(px4,fo1x+(cx1-fOffX));
                     copymemory( px2 , px4, rl4 );
                  end;
               end else begin
                  // subsample/oversample
                  psy:=syarr;
                  for y:=cy1 to cy2 do begin
                     px2:=Dest.Scanline[y]; inc(px2,cx1);
                     px1:=Scanline[psy^];
                     psx:=sxarr;
                     for x:=cx1 to cx2 do begin
                        px2^:=px1[ psx^ ];
                        inc(px2);
                        inc(psx);
                     end;
                     inc(psy);
                  end
               end;
            end;
         ie1g:
            // 1 bit per pixel
            begin
               psy:=syarr;
               for y:=cy1 to cy2 do begin
                  px2:=Dest.Scanline[y]; inc(px2,cx1);
                  px1:=Scanline[psy^];
                  psx:=sxarr;
                  for x:=cx1 to cx2 do begin
                     if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7])=0 then begin
                        pword(px2)^:=0;	// set b,g
                        inc(pword(px2));
                        pbyte(px2)^:=0;	// set r
                        inc(pbyte(px2));
                     end else begin
                        pword(px2)^:=$ffff; 	// set b,g
                        inc(pword(px2));
                        pbyte(px2)^:=$ff;		// set r
                        inc(pbyte(px2));
                     end;
                     inc(psx);
                  end;
                  inc(psy);
               end
            end;
      end;	// end of case
      except
      end;
      if (sxarr<>nil) then
      	freemem(sxarr);
      if (syarr<>nil) then
      	freemem(syarr);
   end;
end;

// set Full to True if all values are 255
// works with all pixelformats
procedure TIEBitmap.SyncFull;
var
	px:pbyte;
   y,x,l:integer;
begin
	l:=fRowLen;
	for y:=0 to fHeight-1 do begin
   	px:=Scanline[y];
      for x:=0 to l-1 do begin
      	if px^<$FF then begin
         	fFull:=False;
            exit;
         end;
      	inc(px);
      end;
   end;
   fFull:=True;
end;

// check if all pixels have some r,g,b values (the bitmap is grayscale)
// works with all pixelformats
function TIEBitmap.IsGrayScale:boolean;
var
   x,y:integer;
   pp:PRGB;
begin
	result:=true;
   case fPixelFormat of
      ie8p:
         for y:=0 to fRGBPaletteLen-1 do begin
            with fRGBPalette[y] do
               if (r<>g) or (r<>b) or (g<>b) then begin
                  result:=false;
                  exit;
               end;
         end;
      ie24RGB:
         for y:=0 to fHeight-1 do begin
            pp:=scanline[y];
            for x:=0 to fWidth-1 do begin
               with pp^ do
                  if (r<>g) or (r<>b) or (g<>b) then begin
                     result:=false;
                     exit;
                  end;
               inc(pp);
            end;
         end;
	end;
end;

procedure TIEBitmap.RenderToTBitmap(ABitmap:TBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc,ySrc,dxSrc,dySrc:integer;
    EnableAlpha:boolean; Filter:TResampleFilter; AlphaEnabled: Boolean = False; CommonAlpha: Byte = 255;
    RenderOperation:TIERenderOperation = ielNormal);
var
 lPAdummy: ppointerarray;
 lIdummy : pinteger;
begin
 lPADummy := nil;
 lIDummy  := nil;
 RenderToTBitmap(ABitmap, lPADummy, lIdummy, lIdummy, nil, xDst,yDst,dxDst,dyDst,
    xSrc,ySrc,dxSrc,dySrc, AlphaEnabled, False, CommonAlpha, Filter, True, RenderOperation);
end;


// end of TIEBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// IEHint

(*$ifdef IEDELPHI*)

constructor TIEHint.Create(Owner: TComponent);
begin
	inherited;
   fFont:=TFont.Create;
   visible:=false;
   Color:=$E0FFFF;
   Font.Color:=clBlack;
   Canvas.Brush.Style := bsClear;
end;

destructor TIEHint.Destroy;
begin
	FreeAndNil(fFont);
	inherited;
end;

procedure TIEHint.WMNCHitTest(var Message: TWMNCHitTest);
begin
   Message.Result := HTTRANSPARENT;
end;

procedure TIEHint.WMNCPaint(var Message: TMessage);
var
   R: TRect;
begin
   Canvas.Handle := GetWindowDC(Handle);
   with Canvas do
   try
      R := Rect(0, 0, Width, Height);
      DrawEdge(Handle, R, BDR_RAISEDOUTER, BF_RECT);
   finally
      ReleaseDC(Handle,Canvas.Handle);
      Canvas.Handle := 0;
   end;
end;

procedure TIEHint.Paint;
begin
	Canvas.TextOut(1,1,fText);
end;

procedure TIEHint.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   with Params do begin
      Style := WS_POPUP or WS_BORDER;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
      if NewStyleControls then ExStyle := WS_EX_TOOLWINDOW;
   end;
end;

procedure TIEHint.SetFont(f:TFont);
begin
	if assigned(f) then begin
		fFont.assign(f);
	   Canvas.Font:=fFont;
	   invalidate;
   end;
end;

procedure TIEHint.SetText(s:AnsiString);
var
	M: TMessage;
begin
	fText:=s;
	Width:=Canvas.TextWidth(fText)+4;
   Height:=Canvas.TextHeight(fText)+4;
   WMNCPaint(M);
   invalidate;
end;

(*$endif*)

// End of IEHint
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


procedure IEDrawHint(Canvas:TCanvas; var x,y:integer; const ss:AnsiString; Font:TFont; Brush:TBrush; var SaveBitmap:TBitmap; MaxWidth,MaxHeight:integer; Border1,Border2:TColor);
const
	ox=6;
   oy=6;
var
	tw,th:integer;
begin
	Canvas.Font.assign(Font);
   Canvas.Brush.Assign(Brush);
	tw:=Canvas.TextWidth(ss)+6+ox;
   th:=Canvas.TextHeight(ss)+6+oy;
   if x<0 then x:=0;
   if y<0 then y:=0;
   x:=imin(x,MaxWidth-1-tw);
	y:=imin(y,MaxHeight-1-th);
   SaveBitmap.PixelFormat:=pf24bit;
   SaveBitmap.Width:=tw;
   SaveBitmap.Height:=th;
   SaveBitmap.Canvas.CopyMode:=cmSrcCopy;
   SaveBitmap.Canvas.CopyRect(rect(0,0,tw,th),Canvas,rect(x,y,x+tw,y+th));
   canvas.FillRect(rect(x+ox,y+oy,x+tw,y+th));
   IEDraw3DRect(Canvas,x+ox,y+oy,x+tw-1,y+th-1,Border1,Border2);
	Canvas.TextOut(x+3+ox,y+3+oy,ss);
end;

function IEDrawDibClose(hdd: hDrawDib): Boolean;
begin
	result:=DrawDibClose(hdd);
end;

function IEDrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean;
begin
	result:=DrawDibDraw(hdd,hDC,xDst, yDst, dxDst, dyDst,lpbi,Bits,xSrc, ySrc, dxSrc, dySrc,wFlags);
end;

function IEDrawDibOpen: hDrawDib;
begin
	result:=DrawDibOpen;
end;

function IEDrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt;
begin
	result:=DrawDibRealize(hdd,hDC,fBackground);
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIETifTagsReader

function TIETifTagsReader.GetMiniString(Tag:integer):AnsiString;
begin
	result:=TIFFReadMiniString(fTIFFEnv,Tag);
end;

function TIETifTagsReader.GetString(Tag:integer):AnsiString;
begin
	result:=TIFFReadString(fTIFFEnv,Tag);
end;

function TIETifTagsReader.GetRawData(Tag:integer):pointer;
var
	Size:integer;
begin
	result:=TIFFReadRawData(fTIFFEnv,Tag,Size);
end;

function TIETifTagsReader.GetIntegerArray(Tag:integer; var ar:pintegerarray):integer;
begin
	result:=TIFFReadArrayIntegers(fTIFFEnv,ar,Tag);
end;

function TIETifTagsReader.GetIntegerIndexed(Tag:integer; index:integer):integer;
begin
	result:=TIFFReadIndexValN(fTIFFEnv,Tag,index);
end;

function TIETifTagsReader.GetRationalIndexed(Tag:integer; index:integer):double;
begin
	result:=TIFFReadRationalIndex(fTIFFEnv,Tag,index);
end;

function TIETifTagsReader.GetRational(Tag:integer):double;
begin
	result:=TIFFReadSingleRational(fTIFFEnv,Tag);
end;

function TIETifTagsReader.GetInteger(Tag:integer):integer;
begin
	result:=TIFFReadSingleValDef(fTIFFEnv,tag,0);
end;

function TIETifTagsReader.TagLength(Tag:integer):integer;
begin
	result:=TIFFGetDataLength(fTIFFEnv,Tag);
end;

function TIETifTagsReader.TagExists(Tag:integer):boolean;
begin
	result:= TIFFFindTAG(Tag,fTIFFEnv)>-1;
end;

constructor TIETifTagsReader.CreateFromFile(const FileName:AnsiString; ImageIndex:integer);
begin
	inherited;
	fFileStream:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyWrite);
   fStream:=fFileStream;
   TIFFLoadTags(fStream,fNumi,ImageIndex,fTIFFEnv);
end;

constructor TIETifTagsReader.CreateFromStream(Stream:TStream; ImageIndex:integer);
begin
	inherited;
	fFileStream:=nil;
   fStream:=Stream;
   TIFFLoadTags(fStream,fNumi,ImageIndex,fTIFFEnv);
end;

constructor TIETifTagsReader.CreateFromIFD( tagReader:TIETifTagsReader; IFDTag:integer );
var
	pos:integer;
begin
	inherited;
   fFileStream:=nil;
   fStream:=tagReader.fStream;
	pos:=tagReader.GetInteger(IFDTag);
   fillmemory(@fTIFFEnv,sizeof(TTIFFEnv),0);
   fTIFFEnv.Stream:=fStream;
   fTIFFEnv.Intel:=tagReader.fTIFFEnv.Intel;
   fTIFFEnv.IFD:=nil;
   TIFFReadIFD(0,pos,fTIFFEnv,fnumi);
end;

procedure TIETifTagsReader.Cleanup;
begin
	TIFFFreeTags(fTIFFEnv);
	if assigned(fFileStream) then
   	FreeAndNil(fFileStream);
	//
	inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIEFileBuffer
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

(*
constructor TIEFileBuffer.Create;
begin
   inherited;
   fFileName:='';
   fMapped:=TList.Create;
   fHTempFile:=INVALID_HANDLE_VALUE;
   fHFileMap:=0;
end;

destructor TIEFileBuffer.Destroy;
begin
   DeAllocate;
   FreeAndNil(fMapped);
   inherited;
end;

procedure TIEFileBuffer.DeAllocate;
begin
   if IsAllocated then begin
      UnMapAll;
      CloseHandle(fHFileMap);
      fHFileMap:=0;
      CloseHandle(fHTempFile);
      fHTempFile:=INVALID_HANDLE_VALUE;
      DeleteFile(fFileName);
   end;
end;

function TIEFileBuffer.IsAllocated:boolean;
begin
   result:= fHFileMap<>0;
end;

// if FileName is '', creates a temp file name in DefTEMPPATH
function TIEFileBuffer.AllocateFile(FileName:AnsiString; SizeLo,SizeHi:dword):boolean;
var
   cms_l,cms_h:dword;
	temppath:array [0..MAX_PATH] of AnsiChar;
   tempfile:array [0..MAX_PATH] of AnsiChar;
begin
   if FileName='' then begin
      if DefTEMPPATH='' then begin
         GetTempPath(250,temppath);
         IEForceDirectories(AnsiString(temppath));
         GetTempFileName(temppath,'imageen',0,tempfile);
      end else begin
         IEForceDirectories(DefTEMPPATH);
         GetTempFileName(PAnsiChar(DefTEMPPATH),'imageen',0,tempfile);
      end;
      fFileName:=tempfile;
   end else
      fFileName:=FileName;
   result:=false;
   fHTempFile:=CreateFile(PAnsiChar(fFileName),GENERIC_WRITE or GENERIC_READ,0,nil,CREATE_ALWAYS,FILE_ATTRIBUTE_TEMPORARY,0);
   if fHTempFile<>INVALID_HANDLE_VALUE then begin
      SetFilePointer(fHTempFile,SizeLo,@SizeHi,FILE_BEGIN);
      SetEndOfFile(fHTempFile);
      cms_l:=GetFileSize(fHTempFile,@cms_h);
      if (SizeLo<>cms_l) or (SizeHi<>cms_h) then begin
         // low free disk space?
         CloseHandle(fHTempFile);
         DeleteFile(fFileName);
         fHTempFile:=INVALID_HANDLE_VALUE;
      end else begin
         fHFileMap:=CreateFileMapping(fHTempFile,nil,PAGE_READWRITE,0,0,nil);
         if fHFileMap=0 then begin
            // unable to create file mapping
            CloseHandle(fHTempFile);
            DeleteFile(fFileName);
            fHTempFile:=INVALID_HANDLE_VALUE;
         end else
            result:=true;
      end;
   end;
end;

procedure TIEFileBuffer.ReAllocateFile(NewSizeLo,NewSizeHi:dword);
var
	ms_l,ms_h:integer;
begin
   if IsAllocated then begin
      CloseHandle(fHFileMap);
      ms_l:=NewSizeLo;
      ms_h:=NewSizeHi;
      SetFilePointer(fHTempFile,ms_l,@ms_h,FILE_BEGIN);
      SetEndOfFile(fHTempFile);
      fHFileMap:=CreateFileMapping(fHTempFile,nil,PAGE_READWRITE,0,0,nil);
   end;
end;

// can copy maximum 2^31 bytes
procedure TIEFileBuffer.CopyTo(Dest:TIEFileBuffer; Offsethi,OffSetLo,Size:integer);
const
	BUFSIZE=1*1024*1024;
var
	sbuf,dbuf,tmp:pointer;
   i:integer;
begin
   // using a temporary buffer enhances performance under MS Windows
   getmem(tmp,BUFSIZE);
   repeat
   	i:=imin(Size,BUFSIZE);
   	sbuf:=Map(OffSetHi,OffSetLo,i);
      copymemory(tmp,sbuf,i);
      UnMap(sbuf);
      dbuf:=Dest.Map(OffSetHi,OffSetLo,i);
      copymemory(dbuf,tmp,i);
      Dest.UnMap(dbuf);
      dec(Size,i);
      inc(OffSetLo,i);
   until Size<=0;
   freemem(tmp);
end;


function TIEFileBuffer.Map(OffsetHi, OffsetLo, Size:integer):pointer;
begin
   result:=MapViewOfFile(fHFileMap,FILE_MAP_WRITE,OffsetHi,OffsetLo,Size);
   fMapped.Add( result );
end;

procedure TIEFileBuffer.UnMap(ptr:pointer);
var
   i:integer;
begin
   i:=fMapped.IndexOf(ptr);
   fMapped.Delete( i );
   UnMapViewOfFile(ptr);
end;

procedure TIEFileBuffer.UnMapAll;
begin
   if IsAllocated then
      while fMapped.Count>0 do
         UnMap( fMapped[fMapped.Count-1] );
end;

//*)

//(*
constructor TIEFileBuffer.Create;
begin
   inherited Create;
   fFileName:='';
   fMapped:=Tl3RecList.Create(SizeOf(TIEFileBufferItem));
   fSimFile:=nil;
end;

procedure TIEFileBuffer.Cleanup;
begin
   DeAllocate;
   FreeAndNil(fMapped);
   inherited;
end;

procedure TIEFileBuffer.DeAllocate;
begin
   if IsAllocated then
   begin
    UnMapAll;
    FreeAndNil(fSimFile);
    DeleteFile(fFileName);
   end;
end;

function TIEFileBuffer.IsAllocated:boolean;
begin
   result:= fSimFile<>nil
end;

// if FileName is '', creates a temp file name in DefTEMPPATH
function TIEFileBuffer.AllocateFile(FileName:AnsiString; InSize:int64):boolean;
var
	temppath:array [0..MAX_PATH] of AnsiChar;
   tempfile:array [0..MAX_PATH] of AnsiChar;
begin
   if FileName='' then begin
      if DefTEMPPATH='' then begin
         GetTempPathA(250,temppath);
         IEForceDirectories(AnsiString(temppath));
         GetTempFileNameA(temppath,'imageen',0,tempfile);
      end else begin
         IEForceDirectories(DefTEMPPATH);
         GetTempFileNameA(PAnsiChar(DefTEMPPATH),'imageen',0,tempfile);
      end;
      fFileName:=tempfile;
   end else
      fFileName:=FileName;
   try
   fSimFile:=TFileStream.Create(fFileName,fmCreate);
   fSimFile.Size:=InSize;
   result:=true;
   except
   	result:=false;
   end;
end;

procedure TIEFileBuffer.ReAllocateFile(NewSize:int64);
begin
   fSimFile.Size:=NewSize;
end;

// can copy maximum 2^31 bytes
procedure TIEFileBuffer.CopyTo(Dest:TIEFileBuffer; InPos,InSize:int64);
const
	BUFSIZE=1024*1024;
var
	i:integer;
   buf:pbyte;
begin
	if (not IsAllocated) or (not Dest.IsAllocated) then exit;
	UnMapAll;
   Dest.UnMapAll;
   if (InPos=0) and (InSize=fSimFile.Size) then begin
   	// copy the full file using operating system functions
      (*$ifdef IEDELPHI*)
      FreeAndNil(fSimFile);
      FreeAndNil(Dest.fSimFile);
      deletefile(Dest.fFileName);
      copyfileA(PAnsiChar(fFileName),PAnsiChar(Dest.fFileName),false);
      Dest.fSimFile:=TFileStream.Create(Dest.fFileName,fmOpenReadWrite);
      fSimFile:=TFileStream.Create(fFileName,fmOpenReadWrite);
      (*$endif*)
      (*$ifdef IEKYLIX*)
      // Linux hasn't CopyFile API call
		Dest.fSimFile:=TFileStream.Create(Dest.fFileName,fmCreate);
      Dest.fSimFile.CopyFrom(fSimFile,0);
      (*$endif*)
   end else begin
      fSimFile.Position:=InPos;
      Dest.fSimFile.Position:=InPos;
      getmem(buf,BUFSIZE);
      repeat
         if InSize<BUFSIZE then i:=InSize else i:=BUFSIZE;
         fSimFile.Read(buf^,i);
         Dest.fSimFile.Write(buf^,i);
         dec(InSize,i);
      until InSize<=0;
      freemem(buf);
   end;
end;
(*
begin
	UnMapAll;
   Dest.UnMapAll;
	fSimFile.Position:=InPos;
   Dest.fSimFile.Position:=InPos;
	Dest.fSimFile.CopyFrom( fSimFile, InSize );
end;
*)

function TIEFileBuffer.IndexOf(ptr:pointer):integer;
var
	i:integer;
begin
	result:=-1;
	for i:=0 to fMapped.Count-1 do
  if PIEFileBufferItem(fMapped.ItemSlot(i))^.ptr=ptr then
  begin
  	result:=i;
   break;
  end;
end;

function TIEFileBuffer.Map(InPos,InSize:int64; DataAccess:TIEDataAccess):pointer;
var
	item:TIEFileBufferItem;
begin
 getmem(result,InSize);
 if iedRead in DataAccess then begin
  fSimFile.Position:=InPos;
  fSimFile.Read(pbyte(result)^,InSize);
 end;
 item.Pos := InPos;
 item.Size := InSize;
 item.ptr := result;
 item.access := DataAccess;
 fMapped.Add(item);
end;

procedure TIEFileBuffer.UnMap(ptr: Pointer);
var
 i:integer;
begin
 i:=IndexOf(ptr);
 UnMap(i);
end;

procedure TIEFileBuffer.UnMap(aIdx: Integer);
var
 item:PIEFileBufferItem;
begin
 if (aIdx < 0) or (aIdx > fMapped.Count-1) then
  Exit;

 item:=PIEFileBufferItem(fMapped.ItemSlot(aIdx));
 if iedWrite in item^.access then
 begin
  fSimFile.Position:=item^.Pos;
  fSimFile.Write(pbyte(item^.ptr)^, item^.Size);
 end;
 freemem(item^.ptr);
 fMapped.Delete(aIdx);
end;

procedure TIEFileBuffer.UnMapAll;
begin
 if IsAllocated then
  while fMapped.Count > 0 do
   UnMap(fMapped.Count-1);
end;

//*)

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

{$ifdef IEDELPHI}
procedure IECenterWindow(Wnd: HWnd);
var
  Rect: TRect;
begin
	if @IEDefDialogCenter<>nil then
   	IEDefDialogCenter(Wnd)
   else begin
      GetWindowRect(Wnd, Rect);
      SetWindowPos(Wnd, 0,
        (GetSystemMetrics(SM_CXSCREEN) - Rect.Right + Rect.Left) div 2,
        (GetSystemMetrics(SM_CYSCREEN) - Rect.Bottom + Rect.Top) div 3,
        0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
   end;
end;
{$endif}

function IEGetFreeMemory:integer;
{$ifdef IEDELPHI}
var
	ms:TMemoryStatus;
begin
	ms.dwLength:=sizeof(ms);
   GlobalMemoryStatus(ms);
   result:=ms.dwAvailPhys;
end;
{$endif}
{$ifdef IEKYLIX}
begin
	result:=0;
end;
{$endif}

procedure IESetplim(var plim:trect; x,y:integer);
begin
	if x<plim.Left then plim.left:=x;
   if x>plim.Right then plim.right:=x;
   if y<plim.Top then plim.top:=y;
   if y>plim.Bottom then plim.bottom:=y;
end;

function IEArcTan2(Y, X: Extended): Extended;
asm
   FLD     Y
   FLD     X
   FPATAN
   FWAIT
end;

function IEArcCos(X: Extended): Extended;
begin
	if (X=1) or (X=-1) then
   	result:=0
   else
		Result := IEArcTan2(Sqrt(1 - X*X), X);
end;

// calculates the angle (rad) of the specified triangle. x2,y2 is the angle center
function IEAngle(x1,y1,x2,y2,x3,y3:integer):double;
var
	vx1,vy1,vx2,vy2:integer;
   d1,d2 : double;
begin
	vx1:=x2-x1; vy1:=y2-y1;
   vx2:=x3-x2; vy2:=y3-y2;
   d1:=sqrt(vx1*vx1+vy1*vy1);
   d2:=sqrt(vx2*vx2+vy2*vy2);
   if (d1=0) or (d2=0) then
   	result:=0
   else begin
      d1:=(vx1*vx2+vy1*vy2)/(d1*d2);
      if abs(d1)<=1 then
      	result:=IEArcCos(d1)
      else
      	result:=0;
   end;
end;

function IEExtractStylesFromLogFont(logfont:PLogFont):TFontStyles;
begin
   result:=[];
   if LogFont<>nil then
      with LogFont^ do begin
         if lfItalic<>0 then include(result,fsItalic);
         if lfUnderline<>0 then include(result,fsUnderline);
         if lfStrikeOut<>0 then include(result,fsStrikeOut);
         if lfWeight>=FW_BOLD then include(result,fsBold);
      end;
end;

function IEConvertGUIDToString(g:PGUID):AnsiString;
var
	p:pbyte;
   i:integer;
begin
	p:=pbyte(g);
   result:='{'+inttohex( pinteger(p)^, 8 )+'-';
   inc(p,4);
   result:=result+inttohex( pword(p)^, 4 )+'-';
	inc(p,2);
   result:=result+inttohex( pword(p)^, 4 )+'-';
	inc(p,2);
   result:=result+inttohex( p^, 2 );
	inc(p);
   result:=result+inttohex( p^, 2 )+'-';
	inc(p);
   for i:=0 to 5 do begin
   	result:=result+inttohex(p^,2);
      inc(p);
   end;
   result:=lowercase(result)+'}';
end;

procedure IEConvertStringToGUID(invar:AnsiString; gg:PGUID);
const
	cv:array [48..70] of integer=(0,1,2,3,4,5,6,7,8,9, 0,0,0,0,0,0,0, 10,11,12,13,14,15);
   mm:array [0..7] of integer=(268435456,16777216,1048576,65536,4096,256,16,1);
var
	i:integer;
   v:cardinal;
begin
	invar:=uppercase(invar);
   v:=0;
	for i:=2 to 9 do
   	v:=v + cardinal(cv[ord(invar[i])]*mm[i-2]);
   gg^.D1:=v;
   gg^.D2:=0;
   for i:=11 to 14 do
		gg^.D2:=gg^.D2 + cv[ord(invar[i])]*mm[i-11+4];
   gg^.D3:=0;
   for i:=16 to 19 do
		gg^.D3:=gg^.D3 + cv[ord(invar[i])]*mm[i-16+4];
   invar:=copy(invar,21,4)+copy(invar,26,12);
   for i:=0 to 7 do begin
		gg^.D4[i] := cv[ord(invar[i*2+1])]*mm[6] + cv[ord(invar[i*2+2])]*mm[7];
   end;
end;

{$ifdef IEDELPHI}
procedure IEResetPrinter;
var
	Device, Driver, Port: array[0..80] of Char;
   DevMode: THandle;
begin
	Printer.GetPrinter(Device, Driver, Port, DevMode);
	Printer.SetPrinter(Device, Driver, Port, 0)
end;
{$endif}

// Adjust the resampling size to match fwidth and fheight
// owidth, oheight: source image size
// fwidth, fheight: container box size
// rwidth, rheight: output - new size
procedure IEFitResample(owidth,oheight,fwidth,fheight:integer; var rwidth,rheight:integer);
var
	zz:double;
begin
	if (owidth<>0) and (oheight<>0) then begin
      zz:=dmin(fwidth/owidth,fheight/oheight);
      rwidth:=trunc(owidth*zz);
      if rwidth=0 then rwidth:=1;
      rheight:=trunc(oheight*zz);
      if rheight=0 then rheight:=1;
   end;
end;

// encode maximum 4 bytes (len can be 1 to 4)
// pad if len<4
// return chars wrote
function _IEASCII85Encode4(var inbytes:pbyte; inlen:integer; var outstr:PAnsiChar):integer;
var
	c:array [1..5] of cardinal;
   value:cardinal;
   i:integer;
begin
   value:=16777216*inbytes^; inc(inbytes);
   value:=value+65536*inbytes^; inc(inbytes);
   value:=value+256*inbytes^; inc(inbytes);
   value:=value+inbytes^; inc(inbytes);
	if (value=0) and (inlen=4) then begin
   	outstr^:='z';
      inc(outstr);
      result:=1;
   end else begin
      c[1]:= value div 52200625;
      value:=value-c[1]*52200625;
      c[2]:= value div 614125;
      value:=value-c[2]*614125;
      c[3]:= value div 7225;
      value:=value-c[3]*7225;
      c[4]:= value div 85;
      value:=value-c[4]*85;
      c[5]:=value;
      for i:=1 to inlen+1 do begin
			outstr^:= AnsiChar( c[i]+33 );
         inc(outstr);
      end;
      result:=inlen+1;
   end;
end;

function IEASCII85EncodeBlock(var inbytes:pbyte; buflen:integer; var outstr:PAnsiChar; var asciilen:integer):integer;
var
	w:integer;
   row:integer;
begin
	result:=0;
   row:=0;
   repeat
   	w:=_IEASCII85Encode4(inbytes,imin(4,buflen),outstr);
      inc(result,w);
      inc(asciilen,w);
      inc(row,w);
      dec(buflen,4);
      if row>=75 then begin
      	outstr^:=#13; inc(outstr);
         outstr^:=#10; inc(outstr);
         inc(result,2);
         row:=0;
      end;
	until buflen<=0;
   outstr^:='~'; inc(outstr);
   outstr^:='>'; inc(outstr);
   outstr^:=#13; inc(outstr);
   outstr^:=#10; inc(outstr);
   inc(result,4);
end;

// decode maximum 5 characters (inlen)
procedure _IEASCII85Decode5(var instr:PAnsiChar; inlen:integer; var outbytes:pbyte);
var
   value:cardinal;
begin
	if instr^='z' then begin
   	value:=0;
      inc(instr);
   end else begin
      value:=(ord(instr^)-33)*52200625; inc(instr);
      if inlen>=2 then begin value:=value+ cardinal(ord(instr^)-33)*614125; inc(instr); end;
      if inlen>=3 then begin value:=value+ cardinal(ord(instr^)-33)*7225; inc(instr); end;
      if inlen>=4 then begin value:=value+ cardinal(ord(instr^)-33)*85; inc(instr); end;
      if inlen>=5 then begin value:=value+ cardinal(ord(instr^)-33); inc(instr); end;
	end;
   outbytes^:= value div 16777216;
   value:=value-(outbytes^*16777216); inc(outbytes);
   outbytes^:= value div 65536;
   value:=value-(outbytes^*65536); inc(outbytes);
   outbytes^:= value div 256;
   value:=value-(outbytes^*256); inc(outbytes);
   outbytes^:= value;
   inc(outbytes);
end;

// a block is terminates with a '~>' (EOD)
// buflen refers to instr length
// return output length
function IEASCII85DecodeBlock(var instr:PAnsiChar; buflen:integer; var outbytes:pbyte):integer;
var
   i,l,flatlen:integer;
   flatbuf,ptr,instr2:PAnsiChar;
begin
	result:=0;
   flatlen:=0;
   getmem(flatbuf,buflen);
   ptr:=flatbuf;
   i:=0;
   while i<buflen do begin
   	while ((ord(instr^)<33) or (ord(instr^)>117)) and (instr^<>'~') and (instr^<>'>') do begin
      	inc(instr);
         inc(i);
      end;
      if instr^='~' then begin
			instr2:=instr;
         l:=i;
         inc(instr);
         while ((ord(instr^)<33) or (ord(instr^)>117)) and (instr^<>'~') and (instr^<>'>') do
            inc(instr);
			if instr^='>' then begin
         	inc(instr);
         	break;
         end else begin
         	instr:=instr2;
            i:=l;
         end;
      end;
		ptr^:=instr^;
      inc(instr);
      inc(i);
      inc(ptr);
      inc(flatlen);
   end;
   ptr:=flatbuf;
   repeat
   	i:=imin(flatlen,5);
		_IEASCII85Decode5(ptr,i,outbytes);
      inc(result,i-1);
      dec(flatlen,i);
   until flatlen<=0;
   freemem(flatbuf);
end;

// return the number of bytes actually written
function IEPSRunLengthEncode(inbytes:pbytearray; inlen:integer; outbytes:pbytearray):integer;
var
	inpos,i,l,j:integer;
begin
	result:=0;	// this is output position
   inpos:=0;
	while inpos<inlen do begin

   	// search for run lengths

   	i:=inpos+1;
   	while (i<inlen) and (inbytes[inpos]=inbytes[i]) and (i-inpos<128) do
      	inc(i);
      l:=i-inpos;
      if l>1 then begin
      	// do run length
         outbytes[result]:=257-l; inc(result);
         outbytes[result]:=inbytes[inpos]; inc(result);
         inpos:=i;
      end else begin

         // search for literals

         i:=inpos+1;
         while (i<inlen) and (inbytes[i-1]<>inbytes[i]) and (i-inpos<128) do
            inc(i);
         l:=i-inpos;
         // do literals
         outbytes[result]:=l-1; inc(result);
         for j:=0 to l-1 do begin
            outbytes[result]:=inbytes[inpos]; inc(result);
            inc(inpos);
         end;

      end;

   end;
   // do EOD
   outbytes[result]:=128; inc(result);
end;

procedure IEWriteStrLn(s:TStream; ss:AnsiString);
begin
   ss:=ss+#13#10;
   s.Write(PAnsiChar(ss)^,length(ss));
end;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEGrahicBase

procedure TIEGraphicBase.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
	bmp.RenderToCanvas(ACanvas,Rect.Left,Rect.Top,Rect.Right-Rect.Left+1,Rect.Bottom-Rect.Top+1,rfNone,1);
end;

function TIEGraphicBase.GetEmpty: Boolean;
begin
	result:=false;
end;

function TIEGraphicBase.GetHeight: Integer;
begin
	result:=bmp.Height;
end;

function TIEGraphicBase.GetWidth: Integer;
begin
	result:=bmp.Width;
end;

procedure TIEGraphicBase.SetHeight(Value: Integer);
begin
	bmp.Height:=Value;
end;

procedure TIEGraphicBase.SetWidth(Value: Integer);
begin
	bmp.Width:=Value;
end;

constructor TIEGraphicBase.Create;
begin
	inherited;
   bmp:=TIEBitmap.Create;
	fio:=TImageEnIO.Create(nil);
   TImageEnIO(fio).AttachedIEBitmap:=bmp;
   if self is TIETiffImage then
   	fFileType:=ioTIFF
   else if self is TIEJpegImage then
   	fFileType:=ioJPEG
   else if self is TIEPCXImage then
   	fFileType:=ioPCX
   else if self is TIEBMPImage then
   	fFileType:=ioBMP
   else if self is TIEICOImage then
   	fFileType:=ioICO
   {$ifdef IEINCLUDEPNG}
   else if self is TIEPNGImage then
   	fFileType:=ioPNG
   {$endif}
	else if self is TIETGAImage then
   	fFileType:=ioTGA
   else if self is TIEPXMImage then
   	fFileType:=ioPXM
	else if self is TIEGIFImage then
   	fFileType:=ioGIF
   {$ifdef IEINCLUDEJPEG2000}
   else if self is TIEJP2Image then
   	fFileType:=ioJP2
   else if self is TIEJ2KImage then
   	fFileType:=ioJ2K;
   {$endif}
end;

destructor TIEGraphicBase.Destroy;
begin
 FreeAndNil(fio);
 FreeAndNil(bmp);
 inherited;
end;

procedure TIEGraphicBase.Assign(Source: TPersistent);
var
	vclbmp:TBitmap;
begin
	if (Source<>nil) and (Source is TIEGraphicBase) then begin
		bmp.Assign( (Source as TIEGraphicBase).bmp );
      Changed(Self);
   end else if (Source<>nil) and (Source is TBitmap) then begin
		vclbmp:=Source as TBitmap;
      if (vclbmp.PixelFormat<>pf24bit) and (vclbmp.PixelFormat<>pf1bit) then
      	vclbmp.PixelFormat:=pf24bit;
      bmp.Assign( vclbmp );
      Changed(Self);
   end else
		inherited Assign(Source);
end;

procedure TIEGraphicBase.LoadFromStream(Stream: TStream);
begin
	if assigned(fio) then
		TImageEnIO(fio).LoadFromStreamFormat(Stream,fFileType);
end;

procedure TIEGraphicBase.SaveToStream(Stream: TStream);
begin
	if assigned(fio) then
		TImageEnIO(fio).SaveToStream(Stream,fFiletype);
end;

procedure TIEGraphicBase.WriteData(Stream: TStream);
var
	ms:TMemoryStream;
   sz:integer;
begin
  ms:=TMemoryStream.Create;
  SaveToStream(ms);
  ms.Position:=0;
  sz:=ms.Size;
  Stream.Write(sz,sizeof(integer));
  Stream.CopyFrom(ms,ms.Size);
  FreeAndNil(ms);
end;

procedure TIEGraphicBase.ReadData(Stream: TStream);
var
	sz:integer;
begin
	if (Stream.Read(sz,sizeof(integer))>0) and (sz>0) then
		LoadFromStream(Stream);
end;

{$ifdef IEDELPHI}
procedure TIEGraphicBase.LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);
begin
	if AFormat=CF_DIB then
		_CopyDIB2BitmapEx(AData,bmp,nil,false);
end;

procedure TIEGraphicBase.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
begin
	AData:=_CopyBitmaptoDIBEx(bmp,0,0,0,0);
   AFormat:=CF_DIB;
end;
{$endif}

{$ifdef IEKYLIX}
procedure TIEGraphicBase.LoadFromMimeSource(MimeSource: TMimeSource);
begin
end;

procedure TIEGraphicBase.SaveToMimeSource(MimeSource: TClxMimeSource);
begin
end;
{$endif}

procedure IERegisterFormats;
begin
	TPicture.RegisterFileFormat('TIF','TIFF Bitmap',TIETiffImage);
   TPicture.RegisterFileFormat('TIFF','TIFF Bitmap',TIETiffImage);
   TPicture.RegisterFileFormat('FAX','TIFF Bitmap',TIETiffImage);
   TPicture.RegisterFileFormat('G3N','TIFF Bitmap',TIETiffImage);
	TPicture.RegisterFileFormat('G3F','TIFF Bitmap',TIETiffImage);

   TPicture.RegisterFileFormat('GIF','CompuServe Bitmap',TIEGifImage);

	TPicture.RegisterFileFormat('JPG','JPEG Bitmap',TIEJpegImage);
   TPicture.RegisterFileFormat('JPEG','JPEG Bitmap',TIEJpegImage);
   TPicture.RegisterFileFormat('JPE','JPEG Bitmap',TIEJpegImage);

	TPicture.RegisterFileFormat('PCX','PaintBrush',TIEPCXImage);

	TPicture.RegisterFileFormat('BMP','Windows Bitmap',TIEBMPImage);
   TPicture.RegisterFileFormat('DIB','Windows Bitmap',TIEBMPImage);
   TPicture.RegisterFileFormat('RLE','Windows Bitmap',TIEBMPImage);

   // ICO is disabled to avoi conflicts with VCL version
	//TPicture.RegisterFileFormat('ICO','Windows Icon',TIEICOImage);

   {$ifdef IEINCLUDEPNG}
	TPicture.RegisterFileFormat('PNG','Portable Network Graphics',TIEPNGImage);
   {$endif}

	TPicture.RegisterFileFormat('TGA','Targa Bitmap',TIETGAImage);
   TPicture.RegisterFileFormat('TARGA','Targa Bitmap',TIETGAImage);
	TPicture.RegisterFileFormat('VDA','Targa Bitmap',TIETGAImage);
   TPicture.RegisterFileFormat('ICB','Targa Bitmap',TIETGAImage);
   TPicture.RegisterFileFormat('VST','Targa Bitmap',TIETGAImage);
   TPicture.RegisterFileFormat('PIX','Targa Bitmap',TIETGAImage);

   TPicture.RegisterFileFormat('PXM','Portable Pixmap, GreyMap, BitMap',TIEPXMImage);
   TPicture.RegisterFileFormat('PPM','Portable Pixmap, GreyMap, BitMap',TIEPXMImage);
   TPicture.RegisterFileFormat('PGM','Portable Pixmap, GreyMap, BitMap',TIEPXMImage);
   TPicture.RegisterFileFormat('PBM','Portable Pixmap, GreyMap, BitMap',TIEPXMImage);

   {$ifdef IEINCLUDEJPEG2000}
   TPicture.RegisterFileFormat('JP2','JPEG2000',TIEJP2Image);
   TPicture.RegisterFileFormat('J2K','JPEG2000 Code Stream',TIEJ2KImage);
   TPicture.RegisterFileFormat('JPC','JPEG2000 Code Stream',TIEJ2KImage);
   TPicture.RegisterFileFormat('J2C','JPEG2000 Code Stream',TIEJ2KImage);
   {$endif}

end;

procedure IEUnregisterFormats;
begin
	try
	TPicture.UnregisterGraphicClass(TIETiffImage);
   TPicture.UnregisterGraphicClass(TIEGifImage);
   TPicture.UnregisterGraphicClass(TIEJpegImage);
   TPicture.UnregisterGraphicClass(TIEPCXImage);
   TPicture.UnregisterGraphicClass(TIEBMPImage);
   //TPicture.UnregisterGraphicClass(TIEICOImage); // ICO is disabled to avoi conflicts with VCL version
   TPicture.UnregisterGraphicClass(TIEPNGImage);
   TPicture.UnregisterGraphicClass(TIETGAImage);
   TPicture.UnregisterGraphicClass(TIEPXMImage);
   {$ifdef IEDELPHI}
   TPicture.UnregisterGraphicClass(TIEJP2Image);
   TPicture.UnregisterGraphicClass(TIEJ2KImage);
   {$endif}
   except
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEMemStream

constructor TIEMemStream.Create(Ptr:pointer; Size:integer);
begin
	inherited Create;
   SetPointer(Ptr,Size);
end;

procedure TIEMemStream.SetSize(NewSize: Longint);
begin
	// not implemented
end;

function TIEMemStream.Write(const Buffer; Count: Longint): Longint;
begin
	// not implemented
	result:=0;
end;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEImagingAnnot

constructor TIEImagingAnnot.Create;
begin
	inherited Create;
   fObjects:=TList.Create;
end;

procedure TIEImagingAnnot.Cleanup;
begin
 Clear;
 FreeAndNil(fObjects);
 inherited;
end;

procedure TIEImagingAnnot.Clear;
begin
	while fObjects.Count>0 do begin
   	TIEImagingObject(fObjects[0]).Free;
      fObjects.Delete(0);
   end;
end;

procedure TIEImagingAnnot.Assign(Source:TIEImagingAnnot);
var
	i,l:integer;
   dst,src:TIEImagingObject;
begin
	Clear;
   for i:=0 to Source.fObjects.Count-1 do begin
   	dst:=TIEImagingObject.Create;
      src:=TIEImagingObject(Source.fObjects[i]);
      l3move( src.attrib, dst.attrib, sizeof(OIAN_MARK_ATTRIBUTES) );
      if assigned(src.points) then begin
      	getmem( dst.points, sizeof(TPoint)*src.pointsLen );
         l3move( src.points[0], dst.points[0], sizeof(TPoint)*src.pointsLen );
         dst.pointsLen := src.pointsLen;
      end;
		if assigned(src.text) then begin
         l:=strlen(src.text)+1;
			getmem( dst.text, l);
         l3move( src.text[0], dst.text[0], l);
      end;
      if assigned(src.image) then begin
      	dst.image:=TIEBitmap.Create;
         dst.image.Assign( src.image );
      end;
      fObjects.Add( dst );
   end;
end;

procedure TIEImagingAnnot.SaveToStream(Stream:TStream);
begin
	// not implemented
end;

procedure TIEImagingAnnot.LoadFromStream(Stream:TStream);
begin
	// not implemented
end;

function TIEImagingAnnot.GetObject(idx:integer):TIEImagingObject;
begin
	result:=TIEImagingObject(fObjects[idx]);
end;

function TIEImagingAnnot.GetObjectsCount:integer;
begin
	result:=fObjects.Count;
end;

(*$ifdef IEDELPHI*)
procedure TIEImagingAnnot.DrawToBitmap(target:TIEBitmap; Antialias:boolean);
var
	ievect:TImageEnVect;
begin
	ievect:=TImageEnVect.Create(nil);
   CopyToTImageEnVect(ievect);
   ievect.ObjGraphicRender:=true;
   ievect.DrawObjectsToBitmap(target,Antialias);
   FreeAndNil(ievect);
end;
(*$endif*)

constructor TIEImagingObject.Create;
begin
	inherited Create;
   points:=nil;
   pointsLen:=0;
   text:=nil;
   image:=nil;
end;

procedure TIEImagingObject.Cleanup;
begin
	if assigned(points) then
   	freemem(points);
   if assigned(text) then
   	freemem(text);
   if assigned(image) then
   	FreeAndNil(image);
	inherited;
end;

function TRGBQuad2TColor(q:TRGBQuad):TColor;
var
	rgb:TRGB;
begin
	rgb.r:=q.rgbRed;
   rgb.g:=q.rgbGreen;
   rgb.b:=q.rgbBlue;
   result:=TRGB2TColor(rgb);
end;

function TColor2TRGBQuad(q:TColor):TRGBQuad;
var
	rgb:TRGB;
begin
	rgb:=TColor2TRGB(q);
   result.rgbRed:=rgb.r;
	result.rgbGreen:=rgb.g;
   result.rgbBlue:=rgb.b;
   result.rgbReserved:=0;
end;

(*$ifdef IEDELPHI*)
procedure TIEImagingAnnot.CopyFromTImageEnVect(Target:TObject);
var
	vect:TImageEnVect;
   i,j,hobj:integer;
   obj:TIEImagingObject;
   rect:TRect;
   procedure AddNew;
   var
   	rc:TRect;
   begin
      obj:=TIEImagingObject.Create;
      l3fillchar(obj.attrib,sizeof(OIAN_MARK_ATTRIBUTES),0);
      obj.attrib.dwReserved4:=$FF83F;
      fObjects.Add( obj );
      vect.GetObjRect(hobj,rect);
      rc:=rect;
      if rc.Left>rc.Right then iswap(rc.Left,rc.Right);
      if rc.Top>rc.Bottom then iswap(rc.Top,rc.Bottom);
      obj.attrib.lrBounds:=rc;
      obj.attrib.bVisible:=true;
   end;
   procedure PutCommonMemoData;
   var
   	l:integer;
      s1,s2:AnsiString;
   begin
      obj.attrib.lfFont.lfHeight:= -round((vect.ObjFontHeight[hobj]/gSystemDPIY)*72);
      strcopy(obj.attrib.lfFont.lfFaceName,PAnsiChar(vect.ObjFontName[hobj]));
      if fsBold in vect.ObjFontStyles[hobj] then
         obj.attrib.lfFont.lfWeight:=FW_BOLD
      else
         obj.attrib.lfFont.lfWeight:=FW_NORMAL;
      obj.attrib.lfFont.lfItalic := Byte(fsItalic in vect.ObjFontStyles[hobj]);
      obj.attrib.lfFont.lfUnderline := Byte(fsUnderline in vect.ObjFontStyles[hobj]);
      obj.attrib.lfFont.lfStrikeOut := Byte(fsStrikeOut in vect.ObjFontStyles[hobj]);
      s1:=''; s2:=vect.ObjText[hobj];
      for l:=1 to length(s2) do
      	if s2[l]=#10 then
         	s1:=s1+#13#10
         else
         	s1:=s1+s2[l];
      l:=length(s1)+1;
      getmem(obj.text,l);
      strcopy(obj.text,PAnsiChar(s1));
   end;
begin
	Clear;
	vect:=Target as TImageEnVect;
	for i:=0 to vect.ObjectsCount-1 do begin
		hobj:=vect.GetObjFromIndex(i);
		case vect.ObjKind[hobj] of
      	iekBITMAP:
         	begin
            	AddNew;
               obj.attrib.uType:=IEAnnotImageEmbedded;
					obj.image:=TIEBitmap.Create;
               obj.image.Assign( vect.ObjBitmap[hobj] );
            end;
         iekLINE:
         	begin
            	AddNew;
               obj.attrib.uType:=IEAnnotStraightLine;
               obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjPenColor[hobj]);
               obj.attrib.uLineSize:=vect.ObjPenWidth[hobj];
               obj.attrib.bHighlighting:=vect.ObjTransparency[hobj]<200;
               getmem(obj.points,2*sizeof(TPoint));
               obj.pointslen:=2;
               obj.points[0].x:=rect.Left - obj.attrib.lrBounds.Left;
					obj.points[0].y:=rect.Top - obj.attrib.lrBounds.Top;
               obj.points[1].x:=rect.Right - obj.attrib.lrBounds.Left;
					obj.points[1].y:=rect.Bottom - obj.attrib.lrBounds.Top;
            end;
         iekPOLYLINE:
         	begin
            	AddNew;
               obj.attrib.uType:=IEAnnotFreehandLine;
               obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjPenColor[hobj]);
               obj.attrib.uLineSize:=vect.ObjPenWidth[hobj];
               obj.attrib.bHighlighting:=vect.ObjTransparency[hobj]<200;
               obj.pointslen:=vect.ObjPolylinePointsCount[hobj];
               getmem(obj.points,obj.pointslen*sizeof(TPoint));
       			for j:=0 to obj.pointslen-1 do begin
	               obj.points[j].x:=vect.ObjPolylinePoints[hobj,j].x - obj.attrib.lrBounds.Left;
						obj.points[j].y:=vect.ObjPolylinePoints[hobj,j].y - obj.attrib.lrBounds.Top;
               end;
            end;
         iekBOX:
         	begin
            	AddNew;
               if vect.ObjBrushStyle[hobj]=bsClear then begin
						obj.attrib.uType:=IEAnnotHollowRectangle;
                  obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjPenColor[hobj]);
                  obj.attrib.uLineSize:=vect.ObjPenWidth[hobj];
                  obj.attrib.bHighlighting:=vect.ObjBoxHighLight[hobj];
               end else begin
						obj.attrib.uType:=IEAnnotFilledRectangle;
                  obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjBrushColor[hobj]);
                  obj.attrib.bHighlighting:=vect.ObjBoxHighLight[hobj];
               end;
            end;
         iekMEMO,iekTEXT:
         	begin
            	AddNew;
               if vect.ObjBrushStyle[hobj]=bsClear then begin
						obj.attrib.uType:=IEAnnotTypedText;
                  obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjPenColor[hobj]);
						PutCommonMemoData;
               end else begin
						obj.attrib.uType:=IEAnnotAttachANote;
                  obj.attrib.rgbColor1:=TColor2TRGBQuad(vect.ObjBrushColor[hobj]);
                  obj.attrib.rgbColor2:=TColor2TRGBQuad(vect.ObjPenColor[hobj]);
                  PutCommonMemoData;
               end;
            end;
      end;
   end;
end;
(*$endif*)

(*$ifdef IEDELPHI*)
procedure TIEImagingAnnot.CopyToTImageEnVect(Target:TObject);
var
	vect:TImageEnVect;
   idx,i,j:integer;
   o:TIEImagingObject;
   x1,y1,x2,y2:integer;
   poly:PPointArray;
begin
	vect:=Target as TImageEnVect;
   for i:=0 to fObjects.Count-1 do begin
   	o:=fObjects[i];
		case o.attrib.uType of
         IEAnnotImageEmbedded:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekBITMAP;
               vect.SetObjRect(idx,o.attrib.lrBounds);
					vect.ObjBitmap[idx]:=o.image;
            end;
         IEAnnotImageReference:
            begin
            end;
         IEAnnotStraightLine:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekLINE;
               x1:= o.attrib.lrBounds.Left + o.points[0].x;
               y1:= o.attrib.lrBounds.Top + o.points[0].y;
               x2:= o.attrib.lrBounds.Left + o.points[1].x;
               y2:= o.attrib.lrBounds.Top + o.points[1].y;
               vect.SetObjRect(idx,rect(x1,y1,x2,y2));
               vect.ObjPenColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjPenStyle[idx]:=psSolid;
               vect.ObjPenWidth[idx]:=o.attrib.uLineSize;
               if o.attrib.bHighlighting then
               	vect.ObjTransparency[idx]:=127
               else
               	vect.ObjTransparency[idx]:=255;
            end;
         IEAnnotFreehandLine:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekPOLYLINE;
               getmem(poly,sizeof(TPoint)*o.pointslen);
               for j:=0 to o.pointslen-1 do begin
               	poly[j].x := o.attrib.lrBounds.Left + o.points[j].x;
						poly[j].y := o.attrib.lrBounds.Top + o.points[j].y;
               end;
               vect.SetObjPolylinePoints(idx,slice(poly^,o.pointslen));
               freemem(poly);
               vect.ObjPenColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjPenStyle[idx]:=psSolid;
               vect.ObjPenWidth[idx]:=o.attrib.uLineSize;
               if o.attrib.bHighlighting then
               	vect.ObjTransparency[idx]:=127
               else
               	vect.ObjTransparency[idx]:=255;
            end;
         IEAnnotHollowRectangle:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekBOX;
               vect.SetObjRect(idx,rect(o.attrib.lrBounds.Left,o.attrib.lrBounds.Top,o.attrib.lrBounds.Right,o.attrib.lrBounds.Bottom));
               vect.ObjPenColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjPenWidth[idx]:=o.attrib.uLineSize;
               vect.ObjPenStyle[idx]:=psSolid;
               vect.ObjBrushStyle[idx]:=bsClear;
               vect.ObjBoxHighLight[idx]:=o.attrib.bHighlighting;
            end;
         IEAnnotFilledRectangle:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekBOX;
               vect.SetObjRect(idx,rect(o.attrib.lrBounds.Left,o.attrib.lrBounds.Top,o.attrib.lrBounds.Right,o.attrib.lrBounds.Bottom));
               vect.ObjBrushColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjBrushStyle[idx]:=bsSolid;
               vect.ObjPenStyle[idx]:=psClear;
               vect.ObjBoxHighLight[idx]:=o.attrib.bHighlighting;
            end;
         IEAnnotTypedText,IEAnnotTextStamp,IEAnnotTextFromFile:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekMEMO;
					vect.SetObjRect(idx,rect(o.attrib.lrBounds.Left,o.attrib.lrBounds.Top,o.attrib.lrBounds.Right,o.attrib.lrBounds.Bottom));
               vect.ObjPenColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjBrushColor[idx]:=clwhite;
               vect.ObjBrushStyle[idx]:=bsClear;
               vect.ObjMemoBorderStyle[idx]:=psClear;
               vect.ObjFontHeight[idx]:=o.attrib.lfFont.lfHeight;
               vect.ObjFontName[idx]:=o.attrib.lfFont.lfFaceName;
               vect.ObjFontStyles[idx]:=IEExtractStylesFromLogFont(@o.attrib.lfFont);
               vect.ObjTextAlign[idx]:=iejLeft;
               vect.objFontLocked[idx]:=true;
               vect.ObjText[idx]:=o.text;
            end;
         IEAnnotAttachANote:
            begin
            	idx:=vect.AddNewObject;
            	vect.ObjKind[idx]:=iekMEMO;
					vect.SetObjRect(idx,rect(o.attrib.lrBounds.Left,o.attrib.lrBounds.Top,o.attrib.lrBounds.Right,o.attrib.lrBounds.Bottom));
               vect.ObjPenColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor2);
               vect.ObjBrushColor[idx]:=TRGBQuad2TColor(o.attrib.rgbColor1);
               vect.ObjBrushStyle[idx]:=bsSolid;
               vect.ObjMemoBorderStyle[idx]:=psClear;
               vect.ObjFontHeight[idx]:=o.attrib.lfFont.lfHeight;
               vect.ObjFontName[idx]:=o.attrib.lfFont.lfFaceName;
               vect.ObjFontStyles[idx]:=IEExtractStylesFromLogFont(@o.attrib.lfFont);
               vect.ObjTextAlign[idx]:=iejLeft;
               vect.objFontLocked[idx]:=true;
               vect.ObjText[idx]:=o.text;
            end;
         IEAnnotForm:
            begin
            end;
         IEAnnotOCRRegion:
            begin
            end;
      end;
   end;
end;
(*$endif*)


type
AN_POINTS=packed record
   nMaxPoints:integer;
	nPoints:integer;
	ptPoint:PPointArray;
end;
PAN_POINTS=^AN_POINTS;

AN_NEW_ROTATE_STRUCT=packed record
	rotation:integer;
	scale:integer;
   nHRes:integer;
   nVRes:integer;
   nOrigHRes:integer;
	nOrigVRes:integer;
   bReserved1:integer;
	bReserved2:integer;
	nReserved:array [0..5] of integer;
end;
PAN_NEW_ROTATE_STRUCT=^AN_NEW_ROTATE_STRUCT;

OIAN_TEXTPRIVDATA=packed record
	nCurrentOrientation:integer;
	uReserved1:dword;
	uCreationScale:dword;
	uAnoTextLength:dword;
	szAnoText:AnsiChar;
end;
POIAN_TEXTPRIVDATA=^OIAN_TEXTPRIVDATA;

HYPERLINK_NB=packed record
	nVersion:integer;
	nLinkSize:integer;
	LinkString:PAnsiChar;
	nLocationSize:integer;
	LocationString:PAnsiChar;
	nWorkDirSize:integer;
	WorkDirString:PAnsiChar;
	nFlags:integer;
end;
PHYPERLINK_NB=^HYPERLINK_NB;

TNamedBlocks=record
	// OiAnoDat_lines - AN_POINTS
   p_OiAnoDat_lines:PAN_POINTS;
   // OiAnoDat_images - AN_NEW_ROTATE_STRUCT
	p_OiAnoDat_images:PAN_NEW_ROTATE_STRUCT;
   // OiFilNam - AN_NAME_STRUCT
	p_OiFilNam:PAnsiChar;
   // OiDIB - AN_IMAGE_STRUCT
	p_OiDIB:pointer;
   // OiGroup - STR
	p_OiGroup:PAnsiChar;
	// OiIndex - STR
	p_OiIndex:PAnsiChar;
   // OiAnText - OIAN_TEXTPRIVDATA
	p_OiAnText:POIAN_TEXTPRIVDATA;
   // OiHypLnk - HYPERLINK_NB
	p_OiHypLnk:PHYPERLINK_NB;
end;

procedure LoadNamedBlock(var namedblocks:TNamedBlocks; ptr:pbytearray; buflen:integer; var pos:integer; IntegerLen:integer; CurrentMark:integer);
var
	name:AnsiString;
   size:integer;
   l:integer;
   pc:PAnsiChar;
begin
	pc:=@ptr[pos];
	name:='';
   while (pc^<>#0) and (length(name)<8) do begin
		name:=name+pc^;
      inc(pc);
   end;
	inc(pos,8);
	size:=pinteger(@ptr[pos])^; inc(pos,4);
   if IntegerLen=0 then
   	inc(pos,4);
   if name='OiAnoDat' then begin
   	if (CurrentMark=IEAnnotForm) or (CurrentMark=IEAnnotImageEmbedded) or (CurrentMark=IEAnnotImageReference) then begin
      	// AN_NEW_ROTATE_STRUCT
         if assigned(namedblocks.p_OiAnoDat_images) then
         	dispose(namedblocks.p_OiAnoDat_images);
         new( namedblocks.p_OiAnoDat_images );
         l3move( ptr[pos],namedblocks.p_OiAnoDat_images^, sizeof(AN_NEW_ROTATE_STRUCT) );
      end else if (CurrentMark=IEAnnotFreehandLine) or (CurrentMark=IEAnnotStraightLine) then begin
      	// AN_POINTS
         if assigned(namedblocks.p_OiAnoDat_lines) then
         	dispose(namedblocks.p_OiAnoDat_lines);
         new( namedblocks.p_OiAnoDat_lines );
			l3move( ptr[pos],namedblocks.p_OiAnoDat_lines^, sizeof(AN_POINTS)-sizeof(PPointArray) );
         l:=sizeof(TPoint)*namedblocks.p_OiAnoDat_lines.nPoints;
			getmem(namedblocks.p_OiAnoDat_lines.ptPoint,l);
         l3move( ptr[pos+sizeof(AN_POINTS)-sizeof(PPointArray)],namedblocks.p_OiAnoDat_lines.ptPoint^[0],l);
      end;
   end else if name='OiFilNam' then begin
   	// STR
      if assigned(namedblocks.p_OiFilNam) then
      	freemem(namedblocks.p_OiFilNam);
      l:=strlen( PAnsiChar(@ptr[pos]) );
      getmem( namedblocks.p_OiFilNam, l+1);
      l3move( ptr[pos], namedblocks.p_OiFilNam^, l+1 );
   end else if name='OiDIB' then begin
   	// DIB
      if assigned(namedblocks.p_OiDIB) then
      	freemem(namedblocks.p_OiDIB);
		getmem( namedblocks.p_OiDIB, size );
      l3move( ptr[pos], namedblocks.p_OiDIB^, size );
   end else if name='OiGroup' then begin
   	// STR
      if assigned(namedblocks.p_OiGroup) then
      	freemem(namedblocks.p_OiGroup);
      l:=strlen( PAnsiChar(@ptr[pos]) );
      getmem( namedblocks.p_OiGroup, l+1);
      l3move( ptr[pos], namedblocks.p_OiGroup^, l+1 );
   end else if name='OiIndex' then begin
   	// STR
      if assigned(namedblocks.p_OiIndex) then
      	freemem(namedblocks.p_OiIndex);
      l:=strlen( PAnsiChar(@ptr[pos]) );
      getmem( namedblocks.p_OiIndex, l+1);
      l3move( ptr[pos], namedblocks.p_OiIndex^, l+1 );
   end else if name='OiAnText' then begin
   	// OIAN_TEXTPRIVDATA
      if assigned(namedblocks.p_OiAnText) then
      	freemem(namedblocks.p_OiAnText);
		getmem( namedblocks.p_OiAnText, size );
      l3move( ptr[pos], namedblocks.p_OiAnText^, size );
   end;
   // OiHypLnk not supported
   inc(pos,size);
end;

procedure FreeNamedBlocks(var namedblocks:TNamedBlocks);
begin
	if assigned(namedblocks.p_OiAnoDat_images) then
   	dispose(namedblocks.p_OiAnoDat_images);
   if assigned(namedblocks.p_OiAnoDat_lines) then begin
   	if assigned(namedblocks.p_OiAnoDat_lines.ptPoint) then
      	freemem(namedblocks.p_OiAnoDat_lines.ptPoint);
   	dispose(namedblocks.p_OiAnoDat_lines);
   end;
   if assigned(namedblocks.p_OiFilNam) then
   	freemem(namedblocks.p_OiFilNam);
   if assigned(namedblocks.p_OiDIB) then
   	freemem(namedblocks.p_OiDIB);
   if assigned(namedblocks.p_OiGroup) then
   	freemem(namedblocks.p_OiGroup);
   if assigned(namedblocks.p_OiIndex) then
   	freemem(namedblocks.p_OiIndex);
   if assigned(namedblocks.p_OiAnText) then
   	freemem(namedblocks.p_OiAnText);
   l3fillchar(namedblocks,sizeof(TNamedBlocks),0);
end;

// add only if Mark.uType<>0
procedure AddMark(annot:TIEImagingAnnot; const DefaultNamedBlocks:TNamedBlocks; const CurrentNamedBlocks:TNamedBlocks; const Mark:OIAN_MARK_ATTRIBUTES);
var
	obj:TIEImagingObject;
   //
   procedure Get_OiAnoDat;
   begin
      if assigned(CurrentNamedBlocks.p_OiAnoDat_lines) then begin
         obj.pointsLen:=CurrentNamedBlocks.p_OiAnoDat_lines^.nPoints;
         getmem(obj.points,sizeof(TPoint)*obj.pointslen);
         l3move(CurrentNamedBlocks.p_OiAnoDat_lines^.ptPoint^[0],obj.points[0],sizeof(TPoint)*obj.pointslen);
      end;
   end;
   procedure Get_OiAnText;
   var
   	l:integer;
   begin
   	if assigned(CurrentNamedBlocks.p_OiAnText) then
    begin
    	l:=strlen(PAnsiChar(@CurrentNamedBlocks.p_OiAnText^.szAnoText))+1;
			  getmem(obj.text,l);
     l3move(CurrentNamedBlocks.p_OiAnText^.szAnoText,obj.text^,l);
     obj.attrib.lfFont.lfHeight:=round(-obj.attrib.lfFont.lfHeight* ((72000/CurrentNamedBlocks.p_OiAnText^.uCreationScale )/gSystemDPIY) );
    end;
   end;
   //
begin
	if Mark.uType>0 then begin
      obj:=TIEImagingObject.Create;
      l3move( Mark, obj.attrib, sizeof(OIAN_MARK_ATTRIBUTES) );
      case Mark.uType of
         IEAnnotImageEmbedded:
            begin
					if assigned(CurrentNamedBlocks.p_OiDIB) then begin
						obj.image:=TIEBitmap.Create;
                  (*$ifdef IEDELPHI*)
                  _CopyDIB2BitmapEx(cardinal(CurrentNamedBlocks.p_OiDIB),obj.image,nil,true);
                  (*$endif*)
               end;
            end;
         IEAnnotImageReference:
            begin
            end;
         IEAnnotStraightLine,IEAnnotFreehandLine:
         	Get_OiAnoDat;
         IEAnnotHollowRectangle,IEAnnotFilledRectangle:
         	; // nothing to do
         IEAnnotTypedText,IEAnnotTextStamp,IEAnnotAttachANote,IEAnnotTextFromFile:
         	Get_OiAnText;
         IEAnnotForm:
            begin
            end;
         IEAnnotOCRRegion:
            begin
            end;
      end;
      annot.fObjects.Add(obj);
   end;
end;

procedure TIEImagingAnnot.LoadFromStandardBuffer(buffer:pointer; buflen:integer);
var
	ptr:pbytearray;
   pos:integer;
   IntegerLen:integer;	// integer length (0=16 bit, 1=32 bit)
   DataType:integer;		// 2=default named blocks, 5=mark data, 6=named block
   //DataSize:integer;		// size of the block
   DefaultNamedBlocks:TNamedBlocks;
   CurrentNamedBlocks:TNamedBlocks;
   CurrentMark:OIAN_MARK_ATTRIBUTES;
begin
	pos:=0;
	ptr:=buffer;
   inc(pos,4); // bypass 4 bytes null header
	IntegerLen:=pinteger(@ptr[pos])^; inc(pos,4);
   l3fillchar(DefaultNamedBlocks,sizeof(TNamedBlocks),0);
   l3fillchar(CurrentNamedBlocks,sizeof(TNamedBlocks),0);
   l3fillchar(CurrentMark,sizeof(OIAN_MARK_ATTRIBUTES),0);
   while pos<buflen do begin
		DataType:=pinteger(@ptr[pos])^; inc(pos,4);
		(*DataSize:=pinteger(@ptr[pos])^; *)inc(pos,4);
      case DataType of
      	2:	// default named block
         	begin
            	LoadNamedBlock(DefaultNamedBlocks,ptr,buflen,pos,IntegerLen,CurrentMark.uType);
            end;
         5:	// mark data
         	begin
            	AddMark(self,DefaultNamedBlocks,CurrentNamedBlocks,CurrentMark);	// add previuos mark
               FreeNamedBlocks(CurrentNamedBlocks);
            	l3move( ptr[pos], CurrentMark, sizeof(OIAN_MARK_ATTRIBUTES) );
               inc(pos, sizeof(OIAN_MARK_ATTRIBUTES));
            end;
         6:	// named block
         	begin
            	LoadNamedBlock(CurrentNamedBlocks,ptr,buflen,pos,IntegerLen,CurrentMark.uType);
            end;
      end;
   end;
   AddMark(self,DefaultNamedBlocks,CurrentNamedBlocks,CurrentMark);	// add last mark
   FreeNamedBlocks(CurrentNamedBlocks);
   FreeNamedBlocks(DefaultNamedBlocks);
	fUserChanged:=false;	// the user should not call LoadFromStandardBuffer, then this is not an user changement
end;

procedure TIEImagingAnnot.SaveToStandardBuffer(var Buffer:pointer; var BufferLength:integer);
const
	OiAnoDat:PAnsiChar='OiAnoDat';
	OiAnText:PAnsiChar='OiAnText';
   OiDIB:PAnsiChar   ='OiDIB'#0#0#0;
   OiIndex:PAnsiChar ='OiIndex'#0;
   OiGroup:PAnsiChar ='OiGroup'#0;
var
	ms:TMemoryStream;
   i:integer;
   ii:integer;
   l:integer;
   o:TIEImagingObject;
   anp:AN_POINTS;
   tex:OIAN_TEXTPRIVDATA;
   rot:AN_NEW_ROTATE_STRUCT;
   (*$ifdef IEDELPHI*)
   hdib:THandle;
   ptr1:pbyte;
   (*$endif*)
   stk:TList;
   ss:AnsiString;
   //
   procedure PostPos;
   var
   	ii:integer;
   begin
   	stk.add(pointer(ms.Position));
      ii:=0; ms.Write(ii,4);	// dummy value: fill with the data size
   end;
   procedure SavePos;
   var
   	pp,p1,ii:integer;
   begin
   	pp:=ms.Position;
      p1:=integer(stk[stk.count-1]);
      ms.position:=p1;
      ii:=pp-p1-4;
      ms.Write(ii,4);
      stk.delete(stk.Count-1);
      ms.position:=pp;
   end;
begin
	if fObjects.Count=0 then begin
   	Buffer:=nil;
      BufferLength:=0;
      exit;
   end;
   stk:=TList.Create;
	ms:=TMemoryStream.Create;
   ii:=0; ms.write(ii,4);
   ii:=1; ms.Write(ii,4);
   // default OiGroup
   ii:=2; ms.Write(ii,4);	// named block
   ii:=12; ms.Write(ii,4);
   ms.Write(OiGroup[0],8); // name
   PostPos;
   ss:='0';
   ms.Write(PAnsiChar(ss)[0],length(ss)+1);
   SavePos;
   // default OiIndex
   ii:=2; ms.Write(ii,4);	// named block
   ii:=12; ms.Write(ii,4);
   ms.Write(OiIndex[0],8); // name
   PostPos;
   ss:='1';
   ms.Write(PAnsiChar(ss)[0],length(ss)+1);
   SavePos;
   //
   for i:=0 to fObjects.Count-1 do begin
   	ii:=5; ms.Write(ii,4);	// mark data
      PostPos;
   	o:=TIEImagingObject(fObjects[i]);
		ms.Write(o.attrib,sizeof(OIAN_MARK_ATTRIBUTES));
      SavePos;
      //
      case o.attrib.uType of
         IEAnnotImageEmbedded:
            begin
            	// OiAnoDat
              	ii:=6; ms.Write(ii,4);	// named block
               ii:=12; ms.Write(ii,4);
					ms.Write(OiAnoDat[0],8); // name
               PostPos;
               //
               rot.rotation:=1;
               rot.scale:=1000;
               rot.nHRes:=gSystemDPIX;
               rot.nVRes:=gSystemDPIY;
               rot.nOrigHRes:=gSystemDPIX;
               rot.nOrigVRes:=gSystemDPIY;
               rot.bReserved1:=0;
               rot.bReserved2:=0;
               l3fillchar(rot.nReserved[0],4*6,0);
               ms.Write(rot,sizeof(AN_NEW_ROTATE_STRUCT));
					//
               SavePos;
            	// OiDIB
              	ii:=6; ms.Write(ii,4);	// named block
            	ii:=12; ms.Write(ii,4);
					ms.Write(OiDIB[0],8); // name
               PostPos;
               //
               (*$ifdef IEDELPHI*)
               hdib:=_CopyBitmaptoDIBEx(o.image,0,0,0,0);
					ptr1:=GlobalLock(hdib);
               try
                ms.Write(ptr1^,GlobalSize(hdib));
                GlobalUnlock(hdib);
               finally
                GlobalFree(hdib);
               end;//try..finally 
               (*$endif*)
					//
               SavePos;
            end;
         IEAnnotStraightLine,IEAnnotFreehandLine:
         	begin
            	// OiAnoDat
              	ii:=6; ms.Write(ii,4);	// named block
               ii:=12; ms.Write(ii,4);
					ms.Write(OiAnoDat[0],8); // name
               PostPos;
               //
					anp.nMaxPoints:=o.pointsLen;
               anp.nPoints:=o.pointsLen;
               ms.Write(anp,sizeof(AN_POINTS)-sizeof(PPointArray));
               ms.Write(o.points[0],sizeof(TPoint)*o.pointsLen);
					//
               SavePos;
            end;
         IEAnnotHollowRectangle,IEAnnotFilledRectangle:
         	; // nothing to do
         IEAnnotTypedText,IEAnnotTextStamp,IEAnnotAttachANote,IEAnnotTextFromFile:
         	begin
            	// OiAnText
              	ii:=6; ms.Write(ii,4);	// named block
               ii:=12; ms.Write(ii,4);
					ms.Write(OiAnText[0],8); // name
               PostPos;
               //
               l:=strlen(o.text)+1;
               tex.nCurrentOrientation:=0;
               tex.uReserved1:=1000;
               tex.uCreationScale:=trunc(72000/gSystemDPIY);
               tex.uAnoTextLength:=l-1;
               ms.Write(tex,sizeof(OIAN_TEXTPRIVDATA)-1);
               ms.Write(o.text[0],l);
					//
               SavePos;
            end;
      end;
      // OiGroup
      ii:=6; ms.Write(ii,4);	// named block
      ii:=12; ms.Write(ii,4);
      ms.Write(OiGroup[0],8); // name
      PostPos;
		ss:='0';
      ms.Write(PAnsiChar(ss)[0],length(ss)+1);
      SavePos;
      // OiIndex
      ii:=6; ms.Write(ii,4);	// named block
		ii:=12; ms.Write(ii,4);
      ms.Write(OiIndex[0],8); // name
      PostPos;
		ss:=inttostr(i);
      ms.Write(PAnsiChar(ss)[0],length(ss)+1);
      SavePos;
   end;
   getmem(Buffer, ms.Size);
   CopyMemory(Buffer,ms.Memory,ms.Size);
   BufferLength:=ms.Size;
   FreeAndNil(ms);
   FreeAndNil(stk);
end;


// TIEImagingAnnot
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PDF Support

procedure iepdf_WriteLn(Stream:TStream; line:AnsiString);
begin
	line:=line+#10;
	Stream.Write(PAnsiChar(line)^,length(line));
end;

procedure iepdf_Write(Stream:TStream; line:AnsiString);
begin
	Stream.Write(PAnsiChar(line)^,length(line))
end;

constructor TIEPDFObject.Create;
begin
	DontFree:=false;
	inherited Create;
end;

procedure TIEPDFObject.Cleanup;
begin
	inherited;
end;

constructor TIEPDFRefObject.Create(ObjNumber:integer; GenNumber:integer);
begin
	inherited Create;
	ObjectNumber:=ObjNumber;
   GenerationNumber:=GenNumber;
end;

constructor TIEPDFNumericObject.Create(vv:double);
begin
	inherited Create;
	Value:=vv;
end;

constructor TIEPDFBooleanObject.Create(vv:boolean);
begin
	inherited Create;
	Value:=vv;
end;

constructor TIEPDFStringObject.Create(vv:AnsiString);
begin
	inherited Create;
	Value:=vv;
end;

constructor TIEPDFNameObject.Create(vv:AnsiString);
begin
	inherited Create;
	Value:=vv;
end;

constructor TIEPDFArrayObject.Create;
begin
	inherited Create;
	Items:=TList.Create;
end;

procedure TIEPDFArrayObject.Cleanup;
var
	i:integer;
begin
	for i:=Items.Count-1 downto 0 do
   	if not TIEPDFObject(Items[i]).DontFree then
	   	TIEPDFObject(Items[i]).Free;
   FreeAndNil(Items);
	inherited;
end;

constructor TIEPDFDictionaryObject.Create;
begin
	inherited Create;
	Items:=TStringList.Create;
end;

procedure TIEPDFDictionaryObject.Cleanup;
var
	i:integer;
begin
	for i:=Items.Count-1 downto 0 do
   	if not TIEPDFObject(Items.Objects[i]).DontFree then
	   	TIEPDFObject(Items.Objects[i]).Free;
   FreeAndNil(Items);
	inherited;
end;

constructor TIEPDFStreamObject.Create;
begin
	inherited Create;
	data:=nil;
   length:=0;
   dict:=TIEPDFDictionaryObject.Create;
   dict.items.AddObject('Length',TIEPDFNumericObject.Create(0))
end;

constructor TIEPDFStreamObject.CreateCopy(copydata:pointer; copylength:integer);
begin
	inherited Create;
   Create;
   getmem(data,copylength);
   length:=copylength;
   copymemory(data,copydata,length);
end;

procedure TIEPDFStreamObject.Cleanup;
begin
	FreeAndNil(dict);
   if data<>nil then
   	freemem(data);
	inherited;
end;

procedure TIEPDFRefObject.Write(Stream:TStream);
begin
	Position:=Stream.Position;
	iepdf_Write(Stream,IntToStr(ObjectNumber)+#32+IntToStr(GenerationNumber)+#32+'R');
end;


procedure TIEPDFBooleanObject.Write(Stream:TStream);
const
	ar:array [false..true] of AnsiString=('false','true');
begin
	Position:=Stream.Position;
	iepdf_Write(Stream,ar[value]);
end;

procedure TIEPDFNumericObject.Write(Stream:TStream);
begin
	Position:=Stream.Position;
	iepdf_Write(Stream,FloatToStr(Value));
end;

procedure TIEPDFStringObject.Write(Stream:TStream);
var
	ss:AnsiString;
   i:integer;
begin
	Position:=Stream.Position;
	// writes only normal strings (not hex)
	for i:=1 to length(Value) do
   	case Value[i] of
      	#10: ss:=ss+'\n';
         #13: ss:=ss+'\r';
         #9:  ss:=ss+'\t';
         #8:  ss:=ss+'\b';
         #12: ss:=ss+'\f';
         '(': ss:=ss+'\(';
         ')': ss:=ss+'\)';
         '\': ss:=ss+'\\';
      	else ss:=ss+Value[i];
      end;
	iepdf_Write(Stream,'('+ss+')');
end;

procedure TIEPDFNameObject.Write(Stream:TStream);
var
	ss:AnsiString;
   i:integer;
begin
	Position:=Stream.Position;
	for i:=1 to length(Value) do
   	if (Value[i]<#33) or (Value[i]>#126) then
			ss:=ss+'#'+IntToHex(ord(Value[i]),2)
      else
      	ss:=ss+Value[i];
	iepdf_Write(Stream,'/'+ss);
end;

procedure TIEPDFArrayObject.Write(Stream:TStream);
var
	i:integer;
begin
	Position:=Stream.Position;
	iepdf_Write(Stream,'[');
	for i:=0 to items.Count-1 do begin
   	TIEPDFObject(items[i]).Write(Stream);
      iepdf_Write(Stream,' ');	// space among items
   end;
   iepdf_Write(Stream,']');
end;

procedure TIEPDFDictionaryObject.Write(Stream:TStream);
var
	i:integer;
begin
	Position:=Stream.Position;
	iepdf_Write(Stream,'<< ');
   for i:=0 to items.count-1 do begin
		iepdf_Write(Stream,'/'+items[i]+' ');
      TIEPDFObject(items.Objects[i]).Write(Stream);
      iepdf_Write(Stream,#10);
   end;
   iepdf_Write(Stream,'>>');
end;

procedure TIEPDFStreamObject.Write(Stream:TStream);
var
	i:integer;
begin
	Position:=Stream.Position;
   //
	i:=dict.items.IndexOf('Length');
   TObject(dict.items.Objects[i]).Free;
   dict.items.Objects[i]:=TIEPDFNumericObject.Create(length);
   //
	dict.Write(Stream);
   iepdf_Write(Stream,#10);
   iepdf_WriteLn(Stream,'stream');
	Stream.Write(pbyte(data)^,length);
   iepdf_Write(Stream,#10);
   iepdf_Write(Stream,'endstream');
end;

// write version and binary comment
procedure iepdf_WriteHeader(Stream:TStream);
begin
	iepdf_WriteLn(Stream, '%PDF-1.4' );				// version
   iepdf_WriteLn(Stream, #200#210#240#254 );		// binary four random bytes
end;

function Pad(val:AnsiString; reqLen:integer; padchar:AnsiChar):AnsiString;
begin
	result:=val;
   while length(result)<reqLen do
   	result:=padchar+result;
end;

// write cross reference table (xref), trailer, startxref and the end of file
procedure iepdf_WriteFooter(Stream:TStream; IndirectObjects:TList; info:TIEPDFObject);
var
   i:integer;
   xrefPos:integer;
begin
	// xref (cross reference table)
   xrefPos:=Stream.Position;
	iepdf_WriteLn(Stream, 'xref' );	// cross reference keyword
	iepdf_WriteLn(Stream, '0 ' + IntToStr(IndirectObjects.Count+1) );	// first object number and objects count
	iepdf_WriteLn(Stream, '0000000000 65535 f ' );	// first free object
   for i:=0 to IndirectObjects.Count-1 do
      iepdf_Write(Stream, Pad(IntToStr(TIEPDFObject(IndirectObjects[i]).Position),10,'0')+#32+'00000'+#32+'n '+#10 );
   // trailer
   iepdf_WriteLn(Stream, 'trailer' ); // trailer keyword
   iepdf_WriteLn(Stream, '<< /Size '+IntToStr(IndirectObjects.Count+1) );
   iepdf_WriteLn(Stream, '/Root 1 0 R' );	// root must be object number 1 (the first object defined)
   iepdf_WriteLn(Stream, '/Info '+inttostr(info.Index)+' 0 R' );
   iepdf_WriteLn(Stream, '>>' );
   // startxref (defines xref position)
   iepdf_WriteLn(Stream, 'startxref' );
	iepdf_WriteLn(Stream, IntToStr(xrefPos) );
   // end of file
   iepdf_WriteLn(Stream, '%%EOF' );
end;

procedure iepdf_AddIndirectObject(IndirectObjects:TList; obj:TIEPDFObject);
begin
	IndirectObjects.Add( obj );
   obj.Index:=IndirectObjects.Count;
end;

// encloses an object to make as indirect object
procedure iepdf_WriteIndirectObjects(Stream:TStream; IndirectObjects:TList);
var
	i,j:integer;
   obj:TIEPDFObject;
begin
	for i:=0 to IndirectObjects.Count-1 do begin
   	obj:=TIEPDFObject(IndirectObjects[i]);
      j:=Stream.Position;
      iepdf_WriteLn(Stream, IntToStr(obj.Index)+' 0 obj' );
      obj.Write(Stream);
      iepdf_Write(Stream, #10 );	// just new line
      iepdf_WriteLn(Stream, 'endobj' );
      obj.Position:=j;	// adjust position to include indirect object info
   end;
end;

// prepares the empty root catalog, adding it to IndirectObjects list (must be empty but not nil)
procedure iepdf_AddCatalog(IndirectObjects:TList);
var
	dict:TIEPDFDictionaryObject;
begin
	dict:=TIEPDFDictionaryObject.Create;
   dict.items.AddObject('Type',TIEPDFNameObject.Create('Catalog'));
   iepdf_AddIndirectObject(IndirectObjects,dict);
end;

// * add /Pages for the specified list of /Page tags
// * the list of pages is a list of indexes at the IndirectObjects list
// * add "/Parent" for each page
procedure iepdf_AddPageTree(IndirectObjects:TList; pages:TList);
var
	page_tree,root,page:TIEPDFDictionaryObject;
   parr:TIEPDFArrayObject;
   i:integer;
begin
	page_tree:=TIEPDFDictionaryObject.Create;
   iepdf_AddIndirectObject(IndirectObjects,page_tree);
   page_tree.items.AddObject('Type',TIEPDFNameObject.Create('Pages'));
   parr:=TIEPDFArrayObject.Create;
	for i:=0 to pages.Count-1 do begin
   	page:=TIEPDFDictionaryObject(pages[i]);
		parr.Items.Add(TIEPDFRefObject.Create(page.Index,0));
      // add parent tag foreach page
      page.items.AddObject('Parent', TIEPDFRefObject.Create( page_tree.Index ,0) );
   end;
   page_tree.items.AddObject('Kids',parr);
   page_tree.items.AddObject('Count',TIEPDFNumericObject.Create(pages.count));
   // update root catalog
	root:=TIEPDFDictionaryObject(IndirectObjects[0]);
   root.items.AddObject('Pages',TIEPDFRefObject.Create( page_tree.Index ,0));
end;

// add /Page object
// pages is updated with the new page index inside IndirectObjects
// Resources can be nil
procedure iepdf_AddPage(IndirectObjects:TList; pages:TList; Resources:TIEPDFDictionaryObject; MediaBox:TIEPDFArrayObject; Content:integer);
var
	page:TIEPDFDictionaryObject;
begin
	page:=TIEPDFDictionaryObject.Create;
   page.items.AddObject('Type',TIEPDFNameObject.Create('Page'));
   if assigned(Resources) then
	   page.items.AddObject('Resources',TIEPDFRefObject.Create(Resources.Index,0));
	page.items.AddObject('MediaBox',MediaBox);
	page.items.AddObject('Contents',TIEPDFRefObject.Create(Content,0));
   iepdf_AddIndirectObject( IndirectObjects, page );
	pages.Add(page);	// do not free items of pages list
end;

// End fo PDF Support
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure InitIECosineTab;
var
   i:integer;
begin
	for i := 0 to 255 do
   	IECosineTab[i] := Round(64-Cos(i*Pi/255)*64);
end;

initialization
	begin
        {$IfNDef Nemesis}
		IESetDefaultTranslationWords;
        {$EndIf  Nemesis}        
      (*$ifdef IEDELPHI*)
      IEDefDialogCenter:=nil;
      (*$endif*)
      IEDefMinFileSize:=-1;
      //
      InitIECosineTab;
   end;

finalization
	begin
   end;


end.