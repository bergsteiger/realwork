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

unit imageenio;

{$R-}
{$Q-}


{$I ie.inc}

interface

{$ifdef IEKYLIX}
uses SysUtils, Types, Classes, QGraphics, QForms, QExtCtrls, QPrinters, QControls,
     iekdef,hyieutils,hyiedefs,ieview,imageenproc,iesane, l3Base;
{$endif}
{$ifdef IEDELPHI}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ieview,
  ImageEnProc, ExtCtrls, hyiedefs, hyieutils,
  {$ifdef IEINCLUDETWAIN}
  ietwain,
  {$endif}
  {$ifdef IEINCLUDEWIA}
  iewia,
  {$endif}
  {$ifdef IEINCLUDEDIRECTSHOW}
  ieds,
  {$endif}
  printers,
  l3Base,
  l3InterfacedComponent
  ;
{$endif}

const

   // types for TIOFileType
   ioUnknown=0;
   ioTIFF=1;
   ioGIF=2;
   ioJPEG=3;
   ioPCX=4;
   ioBMP=5;
   ioICO=6;
   ioCUR=7;
   {$ifdef IEINCLUDEPNG}
   ioPNG=8;
   {$endif}
   ioWMF=9;
   ioEMF=10;
   ioTGA=11;
   ioPXM=12;
	{$ifdef IEINCLUDEJPEG2000}
   ioJP2=13;
   ioJ2K=14;
   {$endif}
   ioAVI=15;
   ioWBMP=16;
   ioPS=17;
   ioPDF=18;
   ioUSER=10000;

   IEMAXICOIMAGES=16;

   // Jpeg markers
   JPEG_APP0  = $E0;
   JPEG_APP1  = $E1;
   JPEG_APP2  = $E2;
   JPEG_APP3  = $E3;
   JPEG_APP4  = $E4;
   JPEG_APP5  = $E5;
   JPEG_APP6  = $E6;
   JPEG_APP7  = $E7;
   JPEG_APP8  = $E8;
   JPEG_APP9  = $E9;
   JPEG_APP10 = $EA;
   JPEG_APP11 = $EB;
   JPEG_APP12 = $EC;
   JPEG_APP13 = $ED;
   JPEG_APP14 = $EE;
   JPEG_APP15 = $EF;
   JPEG_COM   = $FE;

   // Standard TWain sizes
   IETW_NONE = 0;
   IETW_A4LETTER = 1;
   IETW_B5LETTER = 2;
   IETW_USLETTER = 3;
   IETW_USLEGAL = 4;
   IETW_A5 = 5;
   IETW_B4 = 6;
   IETW_B6 = 7;
   IETW_USLEDGER = 9;
   IETW_USEXECUTIVE = 10;
   IETW_A3 = 11;
   IETW_B3 = 12;
   IETW_A6 = 13;
   IETW_C4 = 14;
   IETW_C5 = 15;
   IETW_C6 = 16;
   IETW_4A0 = 17;
   IETW_2A0 = 18;
   IETW_A0 = 19;
   IETW_A1 = 20;
   IETW_A2 = 21;
   IETW_A4 = IETW_A4LETTER;
   IETW_A7 = 22;
   IETW_A8 = 23;
   IETW_A9 = 24;
   IETW_A10 = 25;
   IETW_ISOB0 = 26;
   IETW_ISOB1 = 27;
   IETW_ISOB2 = 28;
   IETW_ISOB3 = IETW_B3;
   IETW_ISOB4 = IETW_B4;
   IETW_ISOB5 = 29;
   IETW_ISOB6 = IETW_B6;
   IETW_ISOB7 = 30;
   IETW_ISOB8 = 31;
   IETW_ISOB9 = 32;
   IETW_ISOB10 = 33;
   IETW_JISB0 = 34;
   IETW_JISB1 = 35;
   IETW_JISB2 = 36;
   IETW_JISB3 = 37;
   IETW_JISB4 = 38;
   IETW_JISB5 = IETW_B5LETTER;
   IETW_JISB6 = 39;
   IETW_JISB7 = 40;
   IETW_JISB8 = 41;
   IETW_JISB9 = 42;
   IETW_JISB10 = 43;
   IETW_C0 = 44;
   IETW_C1 = 45;
   IETW_C2 = 46;
   IETW_C3 = 47;
   IETW_C7 = 48;
   IETW_C8 = 49;
   IETW_C9 = 50;
   IETW_C10 = 51;
   IETW_USSTATEMENT = 52;
   IETW_BUSINESSCARD = 53;

type

	TIEAcquireApi = (ieaTWain, ieaWIA);

	TIEAcquireBitmapEvent = procedure(Sender: TObject; ABitmap:TIEBitmap; var Handled:boolean) of object;

   TIEJpegTransform=(jtNone, jtCut, jtHorizFlip, jtVertFlip, jtTranspose, jtTransverse, jtRotate90, jtRotate180, jtRotate270);
   TIEJpegCopyMarkers=(jcCopyNone, jcCopyComments, jcCopyAll);

   // Header used to save a jpeg inside a Stream
   TStreamJpegHeader = record
      ID:array [0..4] of char;	// ="JFIF\0"
      dim:integer;					// length of jpeg box
   end;

   // Header used to save a PCX inside a Stream
   PCXSHead=record
      ID:array [0..4] of char;	// 'PCX2\0'
      dim:integer;
   end;

   // Header used to save a TIFF inside a Stream
   TIFFSHead=record
      ID:array [0..4] of char;	// 'TIFF\0'
      dim:integer;
   end;

   TPreviewParams = set of (
    								 ppALL,
   								 ppAUTO,
                            ppJPEG,
                            ppTIFF,
                            ppGIF,
                            ppBMP,
                            ppPCX,
                            ppPNG,
                            ppTGA
									 {$ifdef IEINCLUDEJPEG2000}
                            ,ppJ2000
                            {$endif}
                            );

   // compression/decompression function for GIF
   TGIFLZWCompFunc=procedure(Stream: TStream; Height,Width:integer; Interlaced:boolean; FData:PAnsiChar; BitsPerPixel:integer);
   TGIFLZWDecompFunc=procedure(Stream: TStream; Height,Width:integer; Interlaced:boolean; FData:PAnsiChar);

   // compression/decompression function for TIFF
   TTIFFLZWDecompFunc=function(CompBuf:pbyte; LineSize:integer; var Id:integer):pbyte;
   TTIFFLZWCompFunc=procedure(indata:pbyte; inputlen:integer; outstream:TStream; var id:integer);

   // previews properties
   TIOPreviewsParamsItems=(ioppDefaultLockPreview,ioppApplyButton);
   TIOPreviewsParams=set of TIOPreviewsParamsItems;

   // printing properties
   TIEVerticalPos=(ievpTOP,ievpCENTER,ievpBOTTOM);
   TIEHorizontalPos=(iehpLEFT,iehpCENTER,iehpRIGHT);
   TIESize=(iesNORMAL, iesFITTOPAGE, iesFITTOPAGESTRETCH, iesSPECIFIEDSIZE);

   // File format consts
   TIOPSCompression= (
          ioPS_RLE,
          ioPS_G4FAX,
          ioPS_G3FAX2D,
          ioPS_JPEG
          );
   TIOPDFCompression= (
   		 ioPDF_UNCOMPRESSED,
          ioPDF_RLE,
          ioPDF_G4FAX,
          ioPDF_G3FAX2D,
          ioPDF_JPEG
          );
   TIOTIFFCompression= (
          ioTIFF_UNCOMPRESSED,
          ioTIFF_CCITT1D,
          ioTIFF_G3FAX1D,
          ioTIFF_G3FAX2D,
          ioTIFF_G4FAX,
          ioTIFF_LZW,
          ioTIFF_OLDJPEG,
          ioTIFF_JPEG,
          ioTIFF_PACKBITS,
          ioTIFF_ZIP,
          ioTIFF_UNKNOWN);
   TIOTIFFPhotometInterpret=(
          ioTIFF_WHITEISZERO,
          ioTIFF_BLACKISZERO,
          ioTIFF_RGB,
          ioTIFF_RGBPALETTE,
          ioTIFF_TRANSPMASK,
          ioTIFF_CMYK,
          ioTIFF_YCBCR,
          ioTIFF_CIELAB);
   TIOJPEGColorspace=(
          ioJPEG_RGB,
          ioJPEG_GRAYLEV,
          ioJPEG_YCbCr,
          ioJPEG_CMYK,
          ioJPEG_YCbCrK);
   {$ifdef IEINCLUDEJPEG2000}
   TIOJ2000ColorSpace=(
          ioJ2000_GRAYLEV,
          ioJ2000_RGB,
          ioJ2000_YCbCr);
   TIOJ2000ScalableBy=(
          ioJ2000_Rate,
          ioJ2000_Resolution);
   {$endif}
   TIOJPEGDctMethod=(
          ioJPEG_ISLOW,
          ioJPEG_IFAST,
          ioJPEG_FLOAT);
   TIOJPEGScale=(
          ioJPEG_AUTOCALC,
          ioJPEG_FULLSIZE,
          ioJPEG_HALF,
          ioJPEG_QUARTER,
          ioJPEG_EIGHTH);
   TIOBMPVersion=(
          ioBMP_BM,
          ioBMP_BM3,
          ioBMP_BMOS2V1,
          ioBMP_BMOS2V2);
   TIOBMPCompression=(
          ioBMP_UNCOMPRESSED,
          ioBMP_RLE);
   TIOPCXCompression=(
          ioPCX_UNCOMPRESSED,
          ioPCX_RLE);
   TIOPNGFilter=(
          ioPNG_FILTER_NONE,
          ioPNG_FILTER_SUB,
          ioPNG_FILTER_PAETH);

   TIEGifAction=(
   		ioGIF_None,
         ioGIF_DontRemove,
         ioGIF_DrawBackground,
         ioGIF_RestorePrev );

   TIOFileType=integer;

   TIOICOSizes=array [0..IEMAXICOIMAGES-1] of TSize;
   TIOICOBitCount=array [0..IEMAXICOIMAGES-1] of integer;

   TImageEnIO=class;

   TIOParamsVals=class(Tl3Base)
      private
         fImageEnIO:TImageEnIO;
         fBitsPerSample:integer;
         fSamplesPerPixel:integer;
         fWidth:integer;
         fHeight:integer;
         fDpiX:integer;
         fDpiY:integer;
         fFileType:TIOFileType;
         fTIFF_Compression:TIOTIFFCompression;
         fTIFF_ImageIndex:integer;
         fTIFF_PhotometInterpret:TIOTIFFPhotometInterpret;
         fTIFF_PlanarConf:integer;
         fTIFF_XPos:integer;
         fTIFF_YPos:integer;
         fTIFF_DocumentName:AnsiString;
         fTIFF_ImageDescription:AnsiString;
         fTIFF_PageName:AnsiString;
         fTIFF_PageNumber:integer;
         fTIFF_PageCount:integer;
         fTIFF_Orientation:integer;
         fTIFF_LZWDecompFunc:TTIFFLZWDecompFunc;
         fTIFF_LZWCompFunc:TTIFFLZWCompFunc;
         fTIFF_EnableAdjustOrientation:boolean;
         fTIFF_JPEGQuality:integer;
         fTIFF_JPEGColorSpace:TIOJPEGColorSpace;
         fGIF_Version:AnsiString;
         fGIF_ImageIndex:integer;
         fGIF_XPos:integer;
         fGIF_YPos:integer;
         fGIF_DelayTime:integer;
         fGIF_FlagTranspColor:boolean;
         fGIF_TranspColor:TRGB;
         fGIF_Interlaced:boolean;
         fGIF_WinWidth:integer;
         fGIF_WinHeight:integer;
         fGIF_Background:TRGB;
         fGIF_Ratio:integer;
         fGIF_Comments:TStringList;
         fGIF_Action:TIEGifAction;
         fGIF_LZWDecompFunc:TGIFLZWDecompFunc;
         fGIF_LZWCompFunc:TGIFLZWCompFunc;
         fJPEG_ColorSpace:TIOJPEGColorSpace;
         fJPEG_Quality:integer;
         fJPEG_DCTMethod:TIOJPEGDCTMethod;
         fJPEG_OptimalHuffman:boolean;
         fJPEG_Smooth:integer;
         fJPEG_Progressive:boolean;
         fJPEG_Scale:TIOJPEGScale;
         fJPEG_MarkerList:TIEMarkerList;
         fJPEG_Scale_Used:integer;
         fJPEG_WarningTot:integer;
         fJPEG_WarningCode:integer;
         fJPEG_OriginalWidth:integer;
         fJPEG_OriginalHeight:integer;
         {$ifdef IEINCLUDEJPEG2000}
         fJ2000_ColorSpace:TIOJ2000ColorSpace;
         fJ2000_Rate:double;
         fJ2000_ScalableBy:TIOJ2000ScalableBy;
         {$endif}
         fPCX_Version:integer;
         fPCX_Compression:TIOPCXCompression;
         fBMP_Version:TIOBMPVersion;
         fBMP_Compression:TIOBMPCompression;
         fICO_ImageIndex:integer;
         fICO_Background:TRGB;
         fCUR_ImageIndex:integer;
         fCUR_XHotSpot:integer;
         fCUR_YHotSpot:integer;
         fCUR_Background:TRGB;
         fPNG_Interlaced:boolean;
         fPNG_Background:TRGB;
         fPNG_Filter:TIOPNGFilter;
         fPNG_Compression:integer;
         fTGA_XPos:integer;
         fTGA_YPos:integer;
         fTGA_Compressed:boolean;
         fTGA_Descriptor:AnsiString;
         fTGA_Author:AnsiString;
         fTGA_Date:TDateTime;
         fTGA_ImageName:AnsiString;
         fTGA_Background:TRGB;
         fTGA_AspectRatio:double;
         fTGA_Gamma:double;
         fTGA_GrayLevel:boolean;
         fIPTC_Info:TIEIPTCInfoList;
         fImagingAnnot:TIEImagingAnnot;
         fPXM_Comments:TStringList;
         fEXIF_HasEXIFData:boolean;
         fEXIF_Bitmap:TIEBitmap;
         fEXIF_ImageDescription:AnsiString;
         fEXIF_Make:AnsiString;
         fEXIF_Model:AnsiString;
         fEXIF_Orientation:integer;
         fEXIF_XResolution:double;
         fEXIF_YResolution:double;
         fEXIF_ResolutionUnit:integer;
         fEXIF_Software:AnsiString;
         fEXIF_DateTime:AnsiString;
         fEXIF_WhitePoint:array [0..1] of double;
         fEXIF_PrimaryChromaticities:array [0..5] of double;
         fEXIF_YCbCrCoefficients:array [0..2] of double;
         fEXIF_YCbCrPositioning:integer;
         fEXIF_ReferenceBlackWhite:array [0..5] of double;
         fEXIF_Copyright:AnsiString;
         fEXIF_ExposureTime:double;
         fEXIF_FNumber:double;
         fEXIF_ExposureProgram:integer;
         fEXIF_ISOSpeedRatings:array [0..1] of integer;
         fEXIF_ExifVersion:AnsiString;
         fEXIF_DateTimeOriginal:AnsiString;
         fEXIF_DateTimeDigitized:AnsiString;
         fEXIF_CompressedBitsPerPixel:double;
         fEXIF_ShutterSpeedValue:double;
         fEXIF_ApertureValue:double;
         fEXIF_BrightnessValue:double;
         fEXIF_ExposureBiasValue:double;
         fEXIF_MaxApertureValue:double;
         fEXIF_SubjectDistance:double;
         fEXIF_MeteringMode:integer;
         fEXIF_LightSource:integer;
         fEXIF_Flash:integer;
         fEXIF_FocalLength:double;
         fEXIF_SubsecTime:AnsiString;
         fEXIF_SubsecTimeOriginal:AnsiString;
         fEXIF_SubsecTimeDigitized:AnsiString;
         fEXIF_FlashPixVersion:AnsiString;
         fEXIF_ColorSpace:integer;
         fEXIF_ExifImageWidth:integer;
         fEXIF_ExifImageHeight:integer;
         fEXIF_RelatedSoundFile:AnsiString;
         fEXIF_FocalPlaneXResolution:double;
         fEXIF_FocalPlaneYResolution:double;
         fEXIF_FocalPlaneResolutionUnit:integer;
         fEXIF_ExposureIndex:double;
         fEXIF_SensingMethod:integer;
         fEXIF_FileSource:integer;
         fEXIF_SceneType:integer;
         fEXIF_UserComment:AnsiString;
         fEXIF_UserCommentCode:AnsiString;
         fAVI_FrameCount:integer;
         fAVI_FrameDelayTime:integer;
         fPS_PaperWidth:integer;
         fPS_PaperHeight:integer;
         fPS_Compression:TIOPSCompression;
         fPS_Title:AnsiString;
         fPDF_PaperWidth:integer;
         fPDF_PaperHeight:integer;
         fPDF_Compression:TIOPDFCompression;
         fPDF_Title:AnsiString;
         fPDF_Author:AnsiString;
         fPDF_Subject:AnsiString;
         fPDF_Keywords:AnsiString;
         fPDF_Creator:AnsiString;
         fPDF_Producer:AnsiString;
         function GetFileTypeStr:AnsiString;
         procedure SetEXIF_WhitePoint(index:integer; v:double);
         function GetEXIF_WhitePoint(index:integer):double;
         procedure SetEXIF_PrimaryChromaticities(index:integer; v:double);
         function GetEXIF_PrimaryChromaticities(index:integer):double;
         procedure SetEXIF_YCbCrCoefficients(index:integer; v:double);
         function GetEXIF_YCbCrCoefficients(index:integer):double;
         procedure SetEXIF_ReferenceBlackWhite(index:integer; v:double);
         function GetEXIF_ReferenceBlackWhite(index:integer):double;
         procedure SetEXIF_ISOSpeedRatings(index:integer; v:integer);
         function GetEXIF_ISOSpeedRatings(index:integer):integer;
         procedure ResetEXIF;
         procedure SetDpi(Value:integer);
         procedure SetDpiX(Value:integer);
         procedure SetDpiY(Value:integer);
         procedure SetTIFF_Orientation(Value:integer);
         procedure SetEXIF_Orientation(Value:integer);
         procedure SetEXIF_XResolution(Value:double);
         procedure SetEXIF_YResolution(Value:double);
      public
         // Read-Only fields
         fFileName:AnsiString;
         fColorMap:PRGBROW;
         fColorMapCount:integer;
         fGIF_ImageCount:integer;
         fTIFF_ImageCount:integer;
         // ICO (not properties)
         ICO_Sizes:TIOICOSizes;
         ICO_BitCount:TIOICOBitCount;
         // GENERAL
         property FileName:AnsiString read fFileName;
         property FileTypeStr:AnsiString read GetFileTypeStr;
         property FileType:TIOFileType read fFileType write fFileType;
         property BitsPerSample:integer read fBitsPerSample write fBitsPerSample;
         property SamplesPerPixel:integer read fSamplesPerPixel write fSamplesPerPixel;
         property Width:integer read fWidth write fWidth;
         property Height:integer read fHeight write fHeight;
         property DpiX:integer read fDpiX write SetDpiX;
         property DpiY:integer read fDpiY write SetDpiY;
         property Dpi:integer read fDpiX write SetDpi;
         property ColorMap:PRGBROW read fColorMap;
         property ColorMapCount:integer read fColorMapcount;
         // IPTC
         property IPTC_Info:TIEIPTCInfoList read fIPTC_Info;
         // Imaging annotations
         property ImagingAnnot:TIEImagingAnnot read fImagingAnnot;
         // TIFF
         property TIFF_Compression:TIOTIFFCompression read fTIFF_Compression write fTIFF_Compression;
         property TIFF_ImageIndex:integer read fTIFF_ImageIndex write fTIFF_ImageIndex;
         property TIFF_ImageCount:integer read fTIFF_ImageCount;
         property TIFF_PhotometInterpret:TIOTIFFPhotometInterpret read fTIFF_PhotometInterpret write fTIFF_PhotometInterpret;
         property TIFF_PlanarConf:integer read fTIFF_PlanarConf write fTIFF_PlanarConf;
         property TIFF_XPos:integer read fTIFF_XPos write fTIFF_XPos;
         property TIFF_YPos:integer read fTIFF_YPos write fTIFF_YPos;
         property TIFF_DocumentName:AnsiString read fTIFF_DocumentName write fTIFF_DocumentName;
         property TIFF_ImageDescription:AnsiString read fTIFF_ImageDescription write fTIFF_ImageDescription;
         property TIFF_PageName:AnsiString read fTIFF_PageName write fTIFF_PageName;
         property TIFF_PageNumber:integer read fTIFF_PageNumber write fTIFF_PageNumber;
         property TIFF_PageCount:integer read fTIFF_PageCount write fTIFF_PageCount;
         property TIFF_Orientation:integer read fTIFF_Orientation write SetTIFF_Orientation;
         property TIFF_EnableAdjustOrientation:boolean read fTIFF_EnableAdjustOrientation write fTIFF_EnableAdjustOrientation;
         property TIFF_LZWDecompFunc:TTIFFLZWDecompFunc read fTIFF_LZWDecompFunc write fTIFF_LZWDecompFunc;
         property TIFF_LZWCompFunc:TTIFFLZWCompFunc read fTIFF_LZWCompFunc write fTIFF_LZWCompFunc;
         property TIFF_JPEGQuality:integer read fTIFF_JPEGQuality write fTIFF_JPEGQuality;
         property TIFF_JPEGColorSpace:TIOJPEGColorSpace read fTIFF_JPEGColorSpace write fTIFF_JPEGColorSpace;
         // GIF
         property GIF_Version:AnsiString read fGIF_Version write fGIF_Version;
         property GIF_ImageIndex:integer read fGIF_ImageIndex write fGIF_ImageIndex;
         property GIF_ImageCount:integer read fGIF_ImageCount;
         property GIF_XPos:integer read fGIF_XPos write fGIF_XPos;
         property GIF_YPos:integer read fGIF_YPos write fGIF_YPos;
         property GIF_DelayTime:integer read fGIF_DelayTime write fGIF_DelayTime;
         property GIF_FlagTranspColor:boolean read fGIF_FlagTranspColor write fGIF_FlagTranspColor;
         property GIF_TranspColor:TRGB read fGIF_TranspColor write fGIF_TranspColor;
         property GIF_Interlaced:boolean read fGIF_Interlaced write fGIF_Interlaced;
         property GIF_WinWidth:integer read fGIF_WinWidth write fGIF_WinWidth;
         property GIF_WinHeight:integer read fGIF_WinHeight write fGIF_WinHeight;
         property GIF_Background:TRGB read fGIF_Background write fGIF_Background;
         property GIF_Ratio:integer read fGIF_Ratio write fGIF_Ratio;
         property GIF_Comments:TStringList read fGIF_Comments;
         property GIF_Action:TIEGifAction read fGIF_Action write fGIF_Action;
         property GIF_LZWDecompFunc:TGIFLZWDecompFunc read fGIF_LZWDecompFunc write fGIF_LZWDecompFunc;
         property GIF_LZWCompFunc:TGIFLZWCompFunc read fGIF_LZWCompFunc write fGIF_LZWCompFunc;
         // JPEG
         property JPEG_ColorSpace:TIOJPEGColorSpace read fJPEG_ColorSpace write fJPEG_ColorSpace;
         property JPEG_Quality:integer read fJPEG_Quality write fJPEG_Quality;
         property JPEG_DCTMethod:TIOJPEGDCTMethod read fJPEG_DCTMethod write fJPEG_DCTMethod;
         property JPEG_OptimalHuffman:boolean read fJPEG_OptimalHuffman write fJPEG_OptimalHuffman;
         property JPEG_Smooth:integer read fJPEG_Smooth write fJPEG_Smooth;
         property JPEG_Progressive:boolean read fJPEG_Progressive write fJPEG_Progressive;
         property JPEG_Scale:TIOJPEGScale read fJPEG_Scale write fJPEG_Scale;
         property JPEG_MarkerList:TIEMarkerList read fJPEG_MarkerList;
         property JPEG_Scale_Used:integer read fJPEG_Scale_Used write fJPEG_Scale_Used;
         property JPEG_WarningTot:integer read fJPEG_WarningTot write fJPEG_WarningTot;
         property JPEG_WarningCode:integer read fJPEG_WarningCode write fJPEG_WarningCode;
         property JPEG_OriginalWidth:integer read fJPEG_OriginalWidth write fJPEG_OriginalWidth;
         property JPEG_OriginalHeight:integer read fJPEG_OriginalHeight write fJPEG_OriginalHeight;
         // JPEG2000
         {$ifdef IEINCLUDEJPEG2000}
         property J2000_ColorSpace:TIOJ2000ColorSpace read fJ2000_ColorSpace write fJ2000_ColorSpace;
         property J2000_Rate:double read fJ2000_Rate write fJ2000_Rate;
         property J2000_ScalableBy:TIOJ2000ScalableBy read fJ2000_ScalableBy write fJ2000_ScalableBy;
         {$endif}
         // PCX
         property PCX_Version:integer read fPCX_Version write fPCX_Version;
         property PCX_Compression:TIOPCXCompression read fPCX_Compression write fPCX_Compression;
         // BMP
         property BMP_Version:TIOBMPVersion read fBMP_Version write fBMP_Version;
         property BMP_Compression:TIOBMPCompression read fBMP_Compression write fBMP_Compression;
         // ICO
         property ICO_ImageIndex:integer read fICO_ImageIndex write fICO_ImageIndex;
         property ICO_Background:TRGB read fICO_Background write fICO_Background;
         // CUR
         property CUR_ImageIndex:integer read fCUR_ImageIndex write fCUR_ImageIndex;
         property CUR_XHotSpot:integer read fCUR_XHotSpot write fCUR_XHotSpot;
         property CUR_YHotSpot:integer read fCUR_YHotSpot write fCUR_YHotSpot;
         property CUR_Background:TRGB read fCUR_Background write fCUR_Background;
         // PNG
         property PNG_Interlaced:boolean read fPNG_Interlaced write fPNG_Interlaced;
         property PNG_Background:TRGB read fPNG_Background write fPNG_Background;
         property PNG_Filter:TIOPNGFilter read fPNG_Filter write fPNG_Filter;
         property PNG_Compression:integer read fPNG_Compression write fPNG_Compression;
         // TGA
         property TGA_XPos:integer read fTGA_XPos write fTGA_XPos;
         property TGA_YPos:integer read fTGA_YPos write fTGA_YPos;
         property TGA_Compressed:boolean read fTGA_Compressed write fTGA_Compressed;
         property TGA_Descriptor:AnsiString read fTGA_Descriptor write fTGA_Descriptor;
         property TGA_Author:AnsiString read fTGA_Author write fTGA_Author;
         property TGA_Date:TDateTime read fTGA_Date write fTGA_Date;
         property TGA_ImageName:AnsiString read fTGA_ImageName write fTGA_ImageName;
         property TGA_Background:TRGB read fTGA_Background write fTGA_Background;
         property TGA_AspectRatio:double read fTGA_AspectRatio write fTGA_AspectRatio;
         property TGA_Gamma:double read fTGA_Gamma write fTGA_Gamma;
         property TGA_GrayLevel:boolean read fTGA_GrayLevel write fTGA_GrayLevel;
         // AVI
         property AVI_FrameCount:integer read fAVI_FrameCount write fAVI_FrameCount;
         property AVI_FrameDelayTime:integer read fAVI_FrameDelayTime write fAVI_FrameDelayTime;
         // PXM
         property PXM_Comments:TStringList read fPXM_Comments;
         // PostScript (PS)
			property PS_PaperWidth:integer read fPS_PaperWidth write fPS_PaperWidth;
         property PS_PaperHeight:integer read fPS_paperHeight write fPS_PaperHeight;
         property PS_Compression:TIOPSCompression read fPS_Compression write fPS_Compression;
         property PS_Title:AnsiString read fPS_Title write fPS_Title;
         // PDF
			property PDF_PaperWidth:integer read fPDF_PaperWidth write fPDF_PaperWidth;
         property PDF_PaperHeight:integer read fPDF_paperHeight write fPDF_PaperHeight;
         property PDF_Compression:TIOPDFCompression read fPDF_Compression write fPDF_Compression;
         property PDF_Title:AnsiString read fPDF_Title write fPDF_Title;
         property PDF_Author:AnsiString read fPDF_Author write fPDF_Author;
         property PDF_Subject:AnsiString read fPDF_Subject write fPDF_Subject;
         property PDF_Keywords:AnsiString read fPDF_Keywords write fPDF_Keywords;
         property PDF_Creator:AnsiString read fPDF_Creator write fPDF_Creator;
         property PDF_Producer:AnsiString read fPDF_Producer write fPDF_Producer;
         // JPEG-EXIF
         property EXIF_HasEXIFData:boolean read fEXIF_HasEXIFData write fEXIF_HasEXIFData;
         property EXIF_Bitmap:TIEBitmap read fEXIF_Bitmap write fEXIF_Bitmap;
         property EXIF_ImageDescription:AnsiString read fEXIF_ImageDescription write fEXIF_ImageDescription;
         property EXIF_Make:AnsiString read fEXIF_Make write fEXIF_Make;
         property EXIF_Model:AnsiString read fEXIF_Model write fEXIF_Model;
         property EXIF_Orientation:integer read fEXIF_Orientation write SetEXIF_Orientation;
         property EXIF_XResolution:double read fEXIF_XResolution write SetEXIF_XResolution;
         property EXIF_YResolution:double read fEXIF_YResolution write SetEXIF_YResolution;
         property EXIF_ResolutionUnit:integer read fEXIF_ResolutionUnit write fEXIF_ResolutionUnit;
         property EXIF_Software:AnsiString read fEXIF_Software write fEXIF_Software;
         property EXIF_DateTime:AnsiString read fEXIF_DateTime write fEXIF_DateTime;
         property EXIF_WhitePoint[index:integer]:double read GetEXIF_WhitePoint write SetEXIF_WhitePoint;
         property EXIF_PrimaryChromaticities[index:integer]:double read GetEXIF_PrimaryChromaticities write SetEXIF_PrimaryChromaticities;
         property EXIF_YCbCrCoefficients[index:integer]:double read GetEXIF_YCbCrCoefficients write SetEXIF_YCbCrCoefficients;
         property EXIF_YCbCrPositioning:integer read fEXIF_YCbCrPositioning write fEXIF_YCbCrPositioning;
         property EXIF_ReferenceBlackWhite[index:integer]:double read GetEXIF_ReferenceBlackWhite write SetEXIF_ReferenceBlackWhite;
         property EXIF_Copyright:AnsiString read fEXIF_Copyright write fEXIF_Copyright;
         property EXIF_ExposureTime:double read fEXIF_ExposureTime write fEXIF_ExposureTime;
         property EXIF_FNumber:double read fEXIF_FNumber write fEXIF_FNumber;
         property EXIF_ExposureProgram:integer read fEXIF_ExposureProgram write fEXIF_ExposureProgram;
         property EXIF_ISOSpeedRatings[index:integer]:integer read GetEXIF_ISOSpeedRatings write SetEXIF_ISOSpeedRatings;
         property EXIF_ExifVersion:AnsiString read fEXIF_ExifVersion write fEXIF_ExifVersion;
         property EXIF_DateTimeOriginal:AnsiString read fEXIF_DateTimeOriginal write fEXIF_DateTimeOriginal;
         property EXIF_DateTimeDigitized:AnsiString read fEXIF_DateTimeDigitized write fEXIF_DateTimeDigitized;
         property EXIF_CompressedBitsPerPixel:double read fEXIF_CompressedBitsPerPixel write fEXIF_CompressedBitsPerPixel;
         property EXIF_ShutterSpeedValue:double read fEXIF_ShutterSpeedValue write fEXIF_ShutterSpeedValue;
         property EXIF_ApertureValue:double read fEXIF_ApertureValue write fEXIF_ApertureValue;
         property EXIF_BrightnessValue:double read fEXIF_BrightnessValue write fEXIF_BrightnessValue;
         property EXIF_ExposureBiasValue:double read fEXIF_ExposureBiasValue write fEXIF_ExposureBiasValue;
         property EXIF_MaxApertureValue:double read fEXIF_MaxApertureValue write fEXIF_MaxApertureValue;
         property EXIF_SubjectDistance:double read fEXIF_SubjectDistance write fEXIF_SubjectDistance;
         property EXIF_MeteringMode:integer read fEXIF_MeteringMode write fEXIF_MeteringMode;
         property EXIF_LightSource:integer read fEXIF_LightSource write fEXIF_LightSource;
         property EXIF_Flash:integer read fEXIF_Flash write fEXIF_Flash;
         property EXIF_FocalLength:double read fEXIF_FocalLength write fEXIF_FocalLength;
         property EXIF_SubsecTime:AnsiString read fEXIF_SubsecTime write fEXIF_SubsecTime;
         property EXIF_SubsecTimeOriginal:AnsiString read fEXIF_SubsecTimeOriginal write fEXIF_SubsecTimeOriginal;
         property EXIF_SubsecTimeDigitized:AnsiString read fEXIF_SubsecTimeDigitized write fEXIF_SubsecTimeDigitized;
         property EXIF_FlashPixVersion:AnsiString read fEXIF_FlashPixVersion write fEXIF_FlashPixVersion;
         property EXIF_ColorSpace:integer read fEXIF_ColorSpace write fEXIF_ColorSpace;
         property EXIF_ExifImageWidth:integer read fEXIF_ExifImageWidth write fEXIF_ExifImageWidth;
         property EXIF_ExifImageHeight:integer read fEXIF_ExifImageHeight write fEXIF_ExifImageHeight;
         property EXIF_RelatedSoundFile:AnsiString read fEXIF_RelatedSoundFile write fEXIF_RelatedSoundFile;
         property EXIF_FocalPlaneXResolution:double read fEXIF_FocalPlaneXResolution write fEXIF_FocalPlaneXResolution;
         property EXIF_FocalPlaneYResolution:double read fEXIF_FocalPlaneYResolution write fEXIF_FocalPlaneYResolution;
         property EXIF_FocalPlaneResolutionUnit:integer read fEXIF_FocalPlaneResolutionUnit write fEXIF_FocalPlaneResolutionUnit;
         property EXIF_ExposureIndex:double read fEXIF_ExposureIndex write fEXIF_ExposureIndex;
         property EXIF_SensingMethod:integer read fEXIF_SensingMethod write fEXIF_SensingMethod;
         property EXIF_FileSource:integer read fEXIF_FileSource write fEXIF_FileSource;
         property EXIF_SceneType:integer read fEXIF_SceneType write fEXIF_SceneType;
         property EXIF_UserComment:AnsiString read fEXIF_UserComment write fEXIF_UserComment;
         property EXIF_UserCommentCode:AnsiString read fEXIF_UserCommentCode write fEXIF_UserCommentCode;
         /////
         constructor Create(IEIO:TImageEnIO);
         reintroduce;
         procedure Cleanup; override;
         procedure SetDefaultParams;
         procedure Assign(Source:TIOParamsVals);reintroduce;
         procedure AssignCompressionInfo(Source:TIOParamsVals);
         procedure SaveToFile(const FileName:AnsiString);
         procedure SaveToStream(Stream:TStream);
         procedure LoadFromFile(const FileName:AnsiString);
         procedure LoadFromStream(Stream:TStream);
         property ImageEnIO:TImageEnIO read fImageEnIO;
         procedure ResetInfo;
         function IsNativePixelFormat:boolean;
   end;

   {$ifdef IEINCLUDETWAIN}
   TIEDRect=record
      Left:double;
      Top:double;
      Right:double;
      Bottom:double;
   end;

   // capabilities of the TWain source
   TIETWSourceCaps=record
      fXResolution:TIEDoubleList;	// X Resolution
      fYResolution:TIEDoubleList;	// Y Resolution
      fXScaling:TIEDoubleList;		// X Scaling
      fYScaling:TIEDoubleList;		// Y Scaling
      fPixelType:TIEIntegerList;		// Pixel type
      fGamma:double;						// Gamma
      fPhysicalHeight:double;			// Physical Height
      fPhysicalWidth:double;			// Physical Width
      fFeederEnabled:boolean;			// FeederEnabled
      fOrientation:TIEIntegerList;	// Orientation
      fIndicators:boolean;				// Progress Indicators
      fAcquireFrame:TIEDRect;			// image layout (this isn't a capability...)
      fBufferedTransfer:boolean;		// image transfer method (default is buffered(true))
      fFileTransfer:boolean;			// image transfer by File (if true overlap fBufferedTransfer), default false
      fDuplexEnabled:boolean;		   // Duplex
      fAcquireFrameEnabled:boolean; // make active fAcquireFrame
      fFeederLoaded:boolean;			// Feeder loaded
      fDuplexSupported:boolean;		// Duplex supported
      fPaperDetectable:boolean;		// Paper detectable
      fContrast:TIEDoubleList;		// Contrast
      fBrightness:TIEDoubleList;		// Brightness
      fThreshold:integer;				// Threshold
      fRotation:integer;				// Rotation
      fUndefinedImageSize:boolean;	// undefined image size
      fStandardSize:TIEIntegerList; // SupportedSizes
      fAutoFeed:boolean;            // enable/disable Autofeed
   end;

   // structure for parameters passed to imscan function
   TIETWainShared = record
      hDSMLib:THANDLE;
      DSM_Entry:TDSMEntryProc;
      hproxy:HWND;
   end;
   PIETWainShared=^TIETWainShared;

   TIETWainParams = class
  	   private
         fOwner:TComponent;
         fVisibleDialog:boolean;
         fSourceListData:TList;
         fSelectedSource:integer;			// index of fSourceListData
         fSourceListDataValid:boolean;		// false to get capabilities
         fCapabilitiesValid:boolean;		// false to get capabilities
         fCapabilities:TIETWSourceCaps;	// filled by imscan
         fAppVersionInfo:AnsiString;
         fAppManufacturer:AnsiString;
         fAppProductFamily:AnsiString;
         fAppProductName:AnsiString;
         fCompatibilityMode:boolean;
         procedure FillSourceListData;
         procedure FillCapabilities;
         function GetSourceName(idx:integer):AnsiString;
         function GetSourceCount:integer;
         function GetXResolution:TIEDoubleList;
         function GetYResolution:TIEDoubleList;
         function GetXScaling:TIEDoubleList;
         function GetYScaling:TIEDoubleList;
         function GetContrast:TIEDoubleList;
         function GetBrightness:TIEDoubleList;
         function GetThreshold:integer;
         function GetRotation:integer;
         procedure SetThreshold(v:integer);
         procedure SetRotation(v:integer);
         function GetPixelType:TIEIntegerList;
         function GetGamma:double;
         function GetPhysicalHeight:double;
         function GetPhysicalWidth:double;
         function GetFeederEnabled:boolean;
         function GetAutoFeed:boolean;
         function GetUndefinedImageSize:boolean;
         function GetOrientation:TIEIntegerList;
         function GetStandardSize:TIEIntegerList;
         procedure SetSelectedSource(v:integer);
         function GetIndicators:boolean;
         procedure SetFeederEnabled(v:boolean);
         procedure SetAutoFeed(v:boolean);
         procedure SetUndefinedImageSize(v:boolean);
         procedure SetIndicators(v:boolean);
         function GetAcquireFrame(idx:integer):double;
         procedure SetAcquireFrame(idx:integer; v:double);
         function GetBufferedTransfer:boolean;
         procedure SetBufferedTransfer(v:boolean);
         function GetFileTransfer:boolean;
         procedure SetFileTransfer(v:boolean);
         procedure SetAppVersionInfo(v:AnsiString);
         procedure SetAppManufacturer(v:AnsiString);
         procedure SetAppProductFamily(v:AnsiString);
         procedure SetAppProductName(v:AnsiString);
         procedure SetDuplexEnabled(v:boolean);
         function GetDuplexEnabled:boolean;
         procedure SetAcquireFrameEnabled(v:boolean);
         function GetAcquireFrameEnabled:boolean;
         function GetFeederLoaded:boolean;
         function GetDuplexSupported:boolean;
         function GetPaperDetectable:boolean;
         procedure SetLogFile(v:AnsiString);
         function GetLogFile:AnsiString;
      public
          // reserved
          TWainShared:TIETWainShared;
          // General properties
		    LastError:integer;
   		 LastErrorStr:AnsiString;
          property VisibleDialog:boolean read fVisibleDialog write fVisibleDialog;
          property SourceName[idx:integer]:AnsiString read GetSourceName;
          property SourceCount:integer read GetSourceCount;
          property SelectedSource:integer read fSelectedSource write SetSelectedSource;
          property LogFile:AnsiString read GetLogFile write SetLogFile;
          property CompatibilityMode:boolean read fCompatibilityMode write fCompatibilityMode;
          // Capabilities
          property XResolution:TIEDoubleList read GetXResolution;
          property YResolution:TIEDoubleList read GetYResolution;
          property XScaling:TIEDoubleList read GetXScaling;
          property YScaling:TIEDoubleList read GetYScaling;
          property PixelType:TIEIntegerList read GetPixelType;
          property Gamma:double read GetGamma;							// readonly
          property PhysicalHeight:double read GetPhysicalHeight;	// readonly
          property PhysicalWidth:double read GetPhysicalWidth;		// readonly
          property FeederEnabled:boolean read GetFeederEnabled write SetFeederEnabled;
          property AutoFeed:boolean read GetAutoFeed write SetAutoFeed;
          property FeederLoaded:boolean read GetFeederLoaded;
          property PaperDetectable:boolean read GetPaperDetectable;
          property Orientation:TIEIntegerList read GetOrientation;
          property ProgressIndicators:boolean read GetIndicators write SetIndicators;
          property AcquireFrameLeft:double index 0 read GetAcquireFrame write SetAcquireFrame;
          property AcquireFrameTop:double index 1 read GetAcquireFrame write SetAcquireFrame;
          property AcquireFrameRight:double index 2 read GetAcquireFrame write SetAcquireFrame;
          property AcquireFrameBottom:double index 3 read GetAcquireFrame write SetAcquireFrame;
          property BufferedTransfer:boolean read GetBufferedTransfer write SetBufferedTransfer;
          property FileTransfer:boolean read GetFileTransfer write SetFileTransfer;
          property DuplexEnabled:boolean read GetDuplexEnabled write SetDuplexEnabled;
          property DuplexSupported:boolean read GetDuplexSupported;
          property AcquireFrameEnabled:boolean read GetAcquireFrameEnabled write SetAcquireFrameEnabled;
          property Contrast:TIEDoubleList read GetContrast;
          property Brightness:TIEDoubleList read GetBrightness;
          property Threshold:integer read GetThreshold write SetThreshold;
          property Rotation:integer read GetRotation write SetRotation;
          property UndefinedImageSize:boolean read GetUndefinedImageSize write SetUndefinedImageSize;
          property StandardSize:TIEIntegerList read GetStandardSize;
          // Application identification
          property AppVersionInfo:AnsiString read fAppVersionInfo write SetAppVersionInfo;
          property AppManufacturer:AnsiString read fAppManufacturer write SetAppManufacturer;
          property AppProductFamily:AnsiString read fAppProductFamily write SetAppProductFamily;
          property AppProductName:AnsiString read fAppProductName write SetAppProductName;
          //
          constructor Create(Owner:TComponent);
          destructor Destroy; override;
          procedure SetDefaultParams;
          procedure Assign(Source:TIETWainParams);
          function SelectSourceByName(const sn:AnsiString):boolean;
          function GetDefaultSource:integer;
          procedure Update;
          procedure FreeResources;
          function GetFromScanner:boolean;
   end;
   {$endif}

   {$ifdef IEINCLUDESANE}

   TIESANEColorMode=(ieGray, ieColor);

   TIESANEParams = class
		private
      	fOwner:TComponent;
			fSaneDevices:PPSANE_Device;
         fSaneOptionDescriptors:PSANE_Option_Descriptor;
         fSelectedSource:integer;	// index of the selected device
         // options
         fBitDepth:integer;
         fColorMode:TIESANEColorMode;
         fXResolution,fYResolution:integer;
         //
         procedure FillSourceListData;
         function GetSourceName(idx:integer):AnsiString;
         function GetSourceFullName(idx:integer):AnsiString;
         function GetSourceCount:integer;
         procedure SetSelectedSource(v:integer);
         procedure SetResolution(Value:integer);
      public
      	// General properties
         property SourceName[idx:integer]:AnsiString read GetSourceName;
         property SourceFullName[idx:integer]:AnsiString read GetSourceFullName;
         property SourceCount:integer read GetSourceCount;
         property SelectedSource:integer read fSelectedSource write SetSelectedSource;
         // Options
         property BitDepth:integer read fBitDepth write fBitDepth;
         property ColorMode:TIESANEColorMode read fColorMode write fColorMode;
         property XResolution:integer read fXResolution write fXResolution;
         property YResolution:integer read fYResolution write fYResolution;
         property Resolution:integer read fXResolution write SetResolution;	// both X and Y resolutions
         //
         constructor Create(Owner:TComponent);
         destructor Destroy; override;
         procedure SetDefaultParams;
         procedure Assign(Source:TIESANEParams);
         function SelectSourceByName(const sn:AnsiString):boolean;
         procedure GetFromScanner;
   end;

   {$endif}

   // occurs after preview
   TIEIOPreviewEvent = procedure(Sender: TObject; PreviewForm:TForm) of object;
   // occurs before preview (user can use owner preview dialog)
   TIEDoPreviewsEvent = procedure(Sender: TObject; var Handled:boolean) of object;

   TIECSSource=(iecsScreen, iecsForegroundWindow, iecsForegroundWindowClient);

   TIEDialogType=(iedtDialog, iedtMaxi);

   TIEDialogsMeasureUnit=(ieduInches, ieduCm, ieduSelectableDefInches, ieduSelectableDefCm);

  	// C++Builder doesn't work if we import IEVFW in interface uses
	TAviStreamInfoA_Ex = record
      fccType               : DWORD;
      fccHandler            : DWORD;
      dwFlags        		 : DWORD;  	// Contains AVITF_* flags
      dwCaps                : DWORD;
      wPriority             : WORD;
      wLanguage             : WORD;
      dwScale               : DWORD;
      dwRate  					 : DWORD;		// dwRate / dwScale == samples/second
      dwStart               : DWORD;
      dwLength 				 : DWORD;		// In units above...
      dwInitialFrames       : DWORD;
      dwSuggestedBufferSize : DWORD;
      dwQuality             : DWORD;
      dwSampleSize          : DWORD;
      rcFrame               : TRECT;
      dwEditCount           : DWORD;
      dwFormatChangeCount   : DWORD;
      szName                : array[0..63] of AnsiChar;
	end;

   PMethod=^TMethod;

   TIEIOMethodTypes=(ieLoadSaveFile,ieLoadSaveStream,ieLoadSaveFileRetInt,ieRetBool,ieLoadSaveStreamRetInt,
                     ieLoadSaveFileFormat,ieLoadSaveStreamFormat,ieCaptureFromScreen,ieLoadSaveIndex,
                     ieImportMetaFile,ieLoadFromURL,ieAcquire);
   TIEIOMethodType_LoadSaveFile=procedure(const nf:AnsiString) of object;
   TIEIOMethodType_LoadSaveStream=procedure(Stream:TStream) of object;
   TIEIOMethodType_LoadSaveFileRetInt=function(const nf:AnsiString):integer of object;
   TIEIOMethodType_RetBool=function:boolean of object;
   TIEIOMethodType_LoadSaveStreamRetInt=function(Stream:TStream):integer of object;
   TIEIOMethodType_LoadSaveFileFormat=procedure(const nf:AnsiString; FileFormat:TIOFileType) of object;
   TIEIOMethodType_LoadSaveStreamFormat=procedure(Stream:TStream; FileFormat:TIOFileType) of object;
   TIEIOMethodType_CaptureFromScreen=procedure(Source:TIECSSource; MouseCursor:TCursor) of object;
   TIEIOMethodType_LoadSaveIndex=procedure(Index:integer) of object;
   TIEIOMethodType_ImportMetaFile=procedure(const nf:AnsiString; Width,Height:integer; WithAlpha:boolean) of object;
   TIEIOMethodType_LoadFromURL=procedure(URL:AnsiString) of object;
   TIEIOMethodType_Acquire=function(api:TIEAcquireAPI):boolean of object;

   TIEIOThread = class(TThread)
      private
         fThreadList:TList;
         fMethodType:TIEIOMethodTypes;
         fMethod_LoadSaveFile:TIEIOMethodType_LoadSaveFile;
         fMethod_LoadSaveStream:TIEIOMethodType_LoadSaveStream;
         fMethod_LoadSaveFileRetInt:TIEIOMethodType_LoadSaveFileRetInt;
         fMethod_RetBool:TIEIOMethodType_RetBool;
         fMethod_LoadSaveStreamRetInt:TIEIOMethodType_LoadSaveStreamRetInt;
         fMethod_LoadSaveFileFormat:TIEIOMethodType_LoadSaveFileFormat;
         fMethod_LoadSaveStreamFormat:TIEIOMethodType_LoadSaveStreamFormat;
         fMethod_CaptureFromScreen:TIEIOMethodType_CaptureFromScreen;
         fMethod_LoadSaveIndex:TIEIOMethodType_LoadSaveIndex;
         fMethod_ImportMetaFile:TIEIOMethodType_ImportMetaFile;
         fMethod_LoadFromURL:TIEIOMethodType_LoadFromURL;
         fMethod_Acquire:TIEIOMethodType_Acquire;
         p_nf:AnsiString;
         p_stream:TStream;
         p_fileformat:TIOFileType;
         p_source:TIECSSource;
         p_index:integer;
         p_width,p_height:integer;
         p_withalpha:boolean;
         p_mouseCursor:TCursor;
         p_URL:AnsiString;
         p_api:TIEAcquireAPI;
         fThreadID:dword;
         fOwner:TImageEnIO;
      public
         procedure Execute; override;
         constructor CreateLoadSaveFile(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFile; const in_nf:AnsiString);
         constructor CreateLoadSaveStream(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStream; in_Stream:TStream);
         constructor CreateLoadSaveFileRetInt(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFileRetInt; const in_nf:AnsiString);
         constructor CreateRetBool(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_RetBool);
         constructor CreateLoadSaveStreamRetInt(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStreamRetInt; in_Stream:TStream);
         constructor CreateLoadSaveFileFormat(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFileFormat; const in_nf:AnsiString; in_fileformat:TIOFileType);
         constructor CreateLoadSaveStreamFormat(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStreamFormat; in_Stream:TStream; in_fileformat:TIOFileType);
         constructor CreateCaptureFromScreen(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_CaptureFromScreen; in_source:TIECSSource; in_mouseCursor:TCursor);
         constructor CreateLoadSaveIndex(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveIndex; in_index:integer);
      			constructor CreateImportMetaFile(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_ImportMetaFile; const in_nf:AnsiString; in_width,in_height:integer; in_withalpha:boolean);
         constructor CreateAcquire(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_Acquire; in_api:TIEAcquireAPI);
         // dummy is necessary to C++Builder in order to compile
			constructor CreateLoadFromURL(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadFromURL; const in_URL:AnsiString; dummy:double);
         property ThreadID:dword read fThreadID;
   end;

   TImageEnIO = class(Tl3InterfacedComponent)
      private
         fBitmap:TBitmap;				// refers to the bitmap (if fImageEnView is valid then it is FImageEnView.bitmap)
         fIEBitmap:TIEBitmap;       // encapsulates fBitmap if SetBitmap, SetAttachedBitmap, SetAttachedImageEn, SetTImage are called
         fIEBitmapCreated:boolean;  // true is fIEBitmap is created by TImageEnIO
         fImageEnView:TIEView;		// refers to TIEView (fbitmap=fimageenview.bitmap)
         fImageEnViewIdx:integer;   // bitmap change index (-1=nothing)
         fTImage:TImage;	         // refers to TImage
         fBackground:TColor;			// valid only if fImageEnview=nil
         fMsgLanguage:TMsgLanguage;
         fPreviewsParams:TIOPreviewsParams;
         fSimplifiedParamsDialogs:boolean;
         fOnDoPreviews:TIEDoPreviewsEvent;
         fChangeBackground:boolean;	// if true change the Background property using the loaded image background
         {$ifdef IEINCLUDETWAIN}
         fTwainParams:TIETWainParams;
         {$endif}
         (*$ifdef IEINCLUDESANE*)
         fSANEParams:TIESANEParams;
         (*$endif*)
         fStreamHeaders:boolean;	// enable/disable load/save stream headers
         fPreviewFont:TFont;
         fOnIOPreview:TIEIOPreviewEvent;
         fDialogsMeasureUnit:TIEDialogsMeasureUnit;
         fAutoAdjustDPI:boolean;
         fFilteredAdjustDPI:boolean;
         {$ifdef IEDELPHI}
         fAVI_avf:pointer;	// PAVIFILE
         fAVI_avs:pointer;	// PAVISTREAM
         fAVI_avs1:pointer; // PAVISTREAM
         fAVI_gf:pointer;	// PGETFRAME
         fAVI_psi:TAviStreamInfoA_Ex;
   		fAVI_popts:pointer; 	// PAVICOMPRESSOPTIONS
         fAVI_idx:integer;
         {$endif}	// IEDELPHI
         fPS_handle:pointer;
         fPS_stream:TFileStream;
         fPDF_handle:pointer;
         fPDF_stream:TFileStream;
         fAsyncThreads:TList; 	// Count>0 is one o more threads are running
         fAsyncThreadsCS:TRTLCriticalSection;	// protect fAsyncThreads access
         fAsyncMode:boolean;		// true if we need async mode
         fPrintingFilterOnSubsampling:boolean;
         fNativePixelFormat:boolean;
         // TWain modeless
         fgrec:pointer;
         // WIA
         {$ifdef IEINCLUDEWIA}
         fWIA:TIEWia;
         {$endif}
         // DirectShow
         {$ifdef IEINCLUDEDIRECTSHOW}
         fDShow:TIEDirectShow;
         {$endif}
         // proxy settings
         fProxyAddress,fProxyUser,fProxyPassword:AnsiString;
         //
         fDefaultDitherMethod:TIEDitherMethod;
         fResetPrinter:boolean;
         //
         function IsInsideAsyncThreads:boolean;
         procedure SetAttachedBitmap(atBitmap:TBitmap);
         procedure SetAttachedImageEn(atImageEn:TIEView);
         function GetReBackground:TColor;
         procedure SetReBackground(v:TColor);
         procedure SetPreviewFont(f:TFont);
         procedure SetTImage(v:TImage);
         procedure SetIOPreviewParams(v:TIOPreviewsParams);
         function GetIOPreviewParams:TIOPreviewsParams;
         procedure AdjustDPI;
         function GetAsyncRunning:integer;
         function GetThreadsCount:integer;
         procedure SetDefaultDitherMethod(Value:TIEDitherMethod);
         {$ifdef IEINCLUDEWIA}
         function WiaOnProgress(Percentage:integer):boolean;
         {$endif}
      protected
      	{$ifndef IEDEBUG}
         fParams:TIOParamsVals;
         {$endif}
         fAborting:boolean;
         fOnProgress:TIEProgressEvent;
         fOnFinishWork:TNotifyEvent;
         fOnAcquireBitmap:TIEAcquireBitmapEvent;
         procedure Notification(AComponent: TComponent; Operation: TOperation); override;
         procedure OnBitmapChange(Sender:TObject; destroying:boolean);
         procedure PrintImageEx(PrtCanvas:TCanvas; dpix,dpiy:integer; pagewidth,pageheight:double; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
         procedure PrintImagePosEx(PrtCanvas:TCanvas; dpix,dpiy:integer; x,y:double; Width,Height:double; GammaCorrection:double);
         {$ifdef IEINCLUDEJPEG2000}
         procedure LoadFromStreamJ2000(Stream:TStream);
         procedure SaveToStreamJ2000(Stream:TStream; format:integer);
         {$endif}	// IEINCLUDEJPEG2000
         procedure SetBitmap(bmp:TBitmap);
         procedure SetIEBitmap(bmp:TIEBitmap);
         procedure SetAttachedIEBitmap(bmp:TIEBitmap);
         procedure TWMultiCallBack( Bitmap:TIEBitmap; var IOParams:TObject); virtual;
         procedure TWCloseCallBack; virtual;
         procedure DoAcquireBitmap(ABitmap:TIEBitmap; var Handled:boolean); virtual;
         procedure DoFinishWork; virtual;
         function GetBitmap:TBitmap; virtual;
			function MakeConsistentBitmap(allowedFormats:TIEPixelFormatSet):boolean;
         {$ifdef IEINCLUDEWIA}
         function GetWIAParams:TIEWia; virtual;
         {$endif}
         {$ifdef IEINCLUDEDIRECTSHOW}
         function GetDShowParams:TIEDirectShow; virtual;
         {$endif}
         function SyncLoadFromStreamGif(Stream:TStream):integer;
         procedure SyncLoadFromStreamPCX(Stream:TStream; streamhead:boolean);
         function SyncLoadFromStreamTIFF(Stream:TStream; streamhead:boolean):integer;
         procedure SyncSaveToStreamPS(Stream:TStream);
         procedure SyncSaveToStreamPDF(Stream:TStream);
         procedure SyncSaveToStreamBMP(Stream:TStream);
         procedure CheckDPI;
      public
      	{$ifdef IEDEBUG}
         fParams:TIOParamsVals;
         {$endif}
         constructor Create(Owner: TComponent); override;
         procedure Cleanup; override;
         property AttachedBitmap:TBitmap read fBitmap write SetAttachedBitmap;
         property AttachedIEBitmap:TIEBitmap read fIEBitmap write SetAttachedIEBitmap;
         procedure Update;
         property ChangeBackground:boolean read fChangeBackground write fChangeBackground;
         property ThreadsCount:integer read GetThreadsCount;
         property DefaultDitherMethod:TIEDitherMethod read fDefaultDitherMethod write SetDefaultDitherMethod;
         {$ifdef IEINCLUDEDIALOGIO}
            {$ifdef IESUPPORTDEFPARAMS}
         function DoPreviews(pp:TPreviewParams=[ppAll]):boolean; virtual;
            {$else}
         function DoPreviews(pp:TPreviewParams):boolean; virtual;
            {$endif}	// IESUPPORTDEFPARAMS
         {$endif}	// IEINCLUDEDIALOGIO
         property Bitmap:TBitmap read GetBitmap write SetBitmap;
         property IEBitmap:TIEBitmap read fIEBitmap write SetIEBitmap;
         property Params:TIOParamsVals read fParams;
         procedure AssignParams(Source:TObject);
         // JPEG
         procedure SaveToFileJpeg(const nf:AnsiString);
         procedure LoadFromFileJpeg(const nf:AnsiString);
         procedure SaveToStreamJpeg(Stream:TStream);
         procedure LoadFromStreamJpeg(Stream:TStream);
         function InjectJpegIPTC(const nf:AnsiString):boolean;
         function InjectJpegIPTCStream(InputStream,OutputStream:TStream):boolean;
         function InjectJpegEXIF(const nf:AnsiString):boolean;
         function InjectJpegEXIFStream(InputStream,OutputStream:TStream):boolean;
         // JPEG2000
         {$ifdef IEINCLUDEJPEG2000}
         procedure LoadFromFileJP2(const nf:AnsiString);
         procedure LoadFromFileJ2K(const nf:AnsiString);
         procedure LoadFromStreamJP2(Stream:TStream);
         procedure LoadFromStreamJ2K(Stream:TStream);
         procedure SaveToStreamJP2(Stream:TStream);
         procedure SaveToStreamJ2K(stream:TStream);
         procedure SaveToFileJP2(const nf:AnsiString);
         procedure SaveToFileJ2K(const nf:AnsiString);
         {$endif}	// IEINCLUDEJPEG2000
         // GIF
         function LoadFromFileGif(const nf:AnsiString):integer;
         procedure SaveToFileGif(const nf:AnsiString);
         function InsertToFileGif(const nf:AnsiString):integer;
         function LoadFromStreamGif(Stream:TStream):integer;
         procedure SaveToStreamGif(Stream:TStream);
         // PCX
         procedure SaveToStreamPCX(Stream:TStream);
         procedure LoadFromStreamPCX(Stream:TStream);
         procedure SaveToFilePCX(const nf:AnsiString);
         procedure LoadFromFilePCX(const nf:AnsiString);
         // TIFF
         function LoadFromStreamTIFF(Stream:TStream):integer;
         procedure SaveToStreamTIFF(Stream:TStream);
         function LoadFromFileTIFF(const nf:AnsiString):integer;
         procedure SaveToFileTIFF(const nf:AnsiString);
         function InsertToFileTIFF(const nf:AnsiString):integer;
         function InsertToStreamTIFF(aStream: TStream): integer;
         // BMP
         procedure SaveToStreamBMP(Stream:TStream);
         procedure LoadFromStreamBMP(Stream:TStream);
         procedure SaveToFileBMP(const nf:AnsiString);
         procedure LoadFromFileBMP(const nf:AnsiString);
         // ICO
         procedure LoadFromFileICO(const nf:AnsiString);
         procedure LoadFromStreamICO(Stream:TStream);
         procedure SaveToStreamICO(Stream:TStream);
         procedure SaveToFileICO(const nf:AnsiString);
         // CUR
         procedure LoadFromFileCUR(const nf:AnsiString);
         procedure LoadFromStreamCUR(Stream:TStream);
         // PNG
         {$ifdef IEINCLUDEPNG}
         procedure LoadFromFilePNG(const nf:AnsiString);
         procedure LoadFromStreamPNG(Stream:TStream);
         procedure SaveToFilePNG(const nf:AnsiString);
         procedure SaveToStreamPNG(Stream:TStream);
         {$endif}
         // TGA
         procedure LoadFromFileTGA(const nf:AnsiString);
         procedure LoadFromStreamTGA(Stream:TStream);
         procedure SaveToFileTGA(const nf:AnsiString);
         procedure SaveToStreamTGA(Stream:TStream);
         // METAFILE (WMF,EMF)
         {$ifdef IEDELPHI}
         procedure ImportMetafile(const nf:AnsiString; Width,Height:integer; WithAlpha:boolean); overload;
         procedure ImportMetafile(const aStream: TStream; Width,Height:integer; WithAlpha:boolean); overload;
         procedure MergeMetafile(const FileName:AnsiString; x,y,Width,Height:integer);
         {$endif}	// IEDELPHI
         // PXM, PBM, PGM, PPM
         procedure LoadFromFilePXM(const nf:AnsiString);
         procedure LoadFromStreamPXM(Stream:TStream);
         procedure SaveToFilePXM(const nf:AnsiString);
         procedure SaveToStreamPXM(Stream:TStream);
         // AVI
         {$ifdef IEDELPHI}
         function OpenAVIFile(const nf:AnsiString):integer;
         procedure CloseAVIFile;
         procedure LoadFromAVI(FrameIndex:integer);
         procedure CreateAVIFile(const nf:AnsiString; rate:integer; codec:AnsiString);
         procedure SaveToAVI;
         {$endif}	// IEDELPHI
         // WBMP
         procedure LoadFromFileWBMP(const nf:AnsiString);
         procedure LoadFromStreamWBMP(Stream:TStream);
         procedure SaveToFileWBMP(const nf:AnsiString);
         procedure SaveToStreamWBMP(Stream:TStream);
         // PostScript (PS)
         procedure CreatePSFile(const nf:AnsiString);
         procedure SaveToPS;
         procedure ClosePSFile;
         procedure SaveToStreamPS(Stream:TStream);
         procedure SaveToFilePS(const nf:AnsiString);
         // PDF
         procedure CreatePDFFile(const nf:AnsiString);
         procedure SaveToPDF;
         procedure ClosePDFFile;
         procedure SaveToStreamPDF(Stream:TStream);
         procedure SaveToFilePDF(const nf:AnsiString);
         // GENERAL
         procedure LoadFromFile(const nf:AnsiString); virtual;
         procedure SaveToFile(const nf:AnsiString); virtual;
         procedure LoadFromFileFormat(const nf:AnsiString; FileFormat:TIOFileType); virtual;
         property Aborting:boolean read fAborting write fAborting;
         procedure ParamsFromFile(const nf:AnsiString); virtual;
         procedure ParamsFromFileFormat(const nf:AnsiString; format:TIOFileType); virtual;
         procedure ParamsFromStream(Stream:TStream); virtual;
         procedure ParamsFromStreamFormat(Stream:TStream; format:TIOFileType); virtual;
         procedure LoadFromStream(Stream:TStream); virtual;
         procedure LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType); virtual;
         procedure SaveToStream(Stream:TStream; FileType:TIOFileType); virtual;
         {$ifdef IEINCLUDEOPENSAVEDIALOGS}
         	{$ifdef IESUPPORTDEFPARAMS}
         function ExecuteOpenDialog(InitialDir:AnsiString=''; InitialFileName:AnsiString=''; AlwaysAnimate:boolean=True; FilterIndex:integer=1; ExtendedFilters:AnsiString=''):AnsiString;
         function ExecuteSaveDialog(InitialDir:AnsiString=''; InitialFileName:AnsiString=''; AlwaysAnimate:boolean=False; FilterIndex:integer=1; ExtendedFilters:AnsiString=''):AnsiString;
         	{$else}
         function ExecuteOpenDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
         function ExecuteSaveDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
         	{$endif}	// IESUPPORTDEFPARAMS
         {$endif}	// IEINCLUDEOPENSAVEDIALOGS
         {$ifdef IESUPPORTDEFPARAMS}
         procedure CaptureFromScreen(Source:TIECSSource=iecsScreen; MouseCursor:TCursor=-1);
         {$else}
         procedure CaptureFromScreen(Source:TIECSSource; MouseCursor:TCursor);
         {$endif}	// IESUPPORTDEFPARAMS
         procedure LoadFromURL(URL:AnsiString);
         // TWAIN SCANNERS
         {$ifdef IEINCLUDETWAIN}
         	{$ifdef IESUPPORTDEFPARAMS}
         function Acquire(api:TIEAcquireApi=ieaTWain):boolean;
         function SelectAcquireSource(api:TIEAcquireApi=ieaTWain):boolean;
         	{$else}
         function Acquire(api:TIEAcquireApi):boolean;
         function SelectAcquireSource(api:TIEAcquireApi):boolean;
         	{$endif}
         function AcquireOpen:boolean;
         procedure AcquireClose;
         {$endif}	// IEINCLUDETWAIN
         {$ifdef IEINCLUDESANE}
         function Acquire:boolean;
         {$endif}	// IEINCLUDESANE
         // ASYNC WORKS
         property AsyncRunning:integer read GetAsyncRunning;
         property AsyncMode:boolean read fAsyncMode write fAsyncMode;
         procedure WaitThreads(Aborts:boolean);
         // TWAIN/WIA and SANE scanners
         {$ifdef IEINCLUDETWAIN}
         property TWainParams:TIETWainParams read fTWainParams;
         {$endif}
         {$ifdef IEINCLUDESANE}
         property SANEParams:TIESANEParams read fSANEParams;
         {$endif}
         {$ifdef IEINCLUDEWIA}
         property WIAParams:TIEWia read GetWIAParams;
         {$endif}
         // Video capture
         {$ifdef IEINCLUDEDIRECTSHOW}
         property DShowParams:TIEDirectShow read GetDShowParams;
         {$endif}
         // PRINTING
         {$ifdef IESUPPORTDEFPARAMS}
         procedure PrintImagePos(PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double=1);
         procedure PrintImage(PrtCanvas:TCanvas=nil; MarginLeft:double=1; MarginTop:double=1; MarginRight:double=1; MarginBottom:double=1; VerticalPos:TIEVerticalPos=ievpCENTER; HorizontalPos:TIEHorizontalPos=iehpCENTER; Size:TIESize=iesFITTOPAGE; SpecWidth:double=0; SpecHeight:double=0; GammaCorrection:double=1);
         procedure PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth:integer; MaxBitmapHeight:integer; PrinterObj:TPrinter=nil; MarginLeft:double=1; MarginTop:double=1; MarginRight:double=1; MarginBottom:double=1; VerticalPos:TIEVerticalPos=ievpCENTER; HorizontalPos:TIEHorizontalPos=iehpCENTER; Size:TIESize=iesFITTOPAGE; SpecWidth:double=0; SpecHeight:double=0; GammaCorrection:double=1);
         {$else}
         procedure PrintImagePos(PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double);
         procedure PrintImage(PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
         procedure PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth,MaxBitmapHeight:integer; PrinterObj:TPrinter; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
         {$endif}
         {$ifdef IEINCLUDEPRINTDIALOGS}
         	{$ifdef IESUPPORTDEFPARAMS}
         function DoPrintPreviewDialog(DialogType:TIEDialogType=iedtDialog; const TaskName:AnsiString=''):boolean;
         	{$else}
         function DoPrintPreviewDialog(DialogType:TIEDialogType; const TaskName:AnsiString):boolean;
         	{$endif}
         {$endif}
         property PrintingFilterOnSubsampling:boolean read fPrintingFilterOnSubsampling write fPrintingFilterOnSubsampling;
         // proxy settings (used by LoadFromURL and LoadFromFile with http:// prefix
         property ProxyAddress:AnsiString read fProxyAddress write fProxyAddress;
         property ProxyUser:AnsiString read fProxyUser write fProxyUser;
         property ProxyPassword:AnsiString read fProxyPassword write fProxyPassword;
         //
         property ResetPrinter:boolean read fResetPrinter write fResetPrinter;
      published
         property AttachedImageEn:TIEView read fImageEnView write SetAttachedImageEn;
         property Background:TColor read GetReBackground write SetReBackground default clBlack;
         property OnProgress:TIEProgressEvent read fOnProgress write fOnProgress;
         property MsgLanguage:TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;
         property PreviewsParams:TIOPreviewsParams read GetIOPreviewParams write SetIOPreviewParams default [];
         property StreamHeaders:boolean read fStreamHeaders write fStreamHeaders default false;
         property PreviewFont:TFont read fPreviewFont write SetPreviewFont;
         property AttachedTImage:TImage read fTImage write SetTImage;
         property OnIOPreview:TIEIOPreviewEvent read fOnIOPreview write fOnIOPreview;
         property DialogsMeasureUnit:TIEDialogsMeasureUnit read fDialogsMeasureUnit write fDialogsMeasureUnit default ieduInches;
         property AutoAdjustDPI:boolean read fAutoAdjustDPI write fAutoAdjustDPI default False;
         property FilteredAdjustDPI:boolean read fFilteredAdjustDPI write fFilteredAdjustDPI default false;
         property OnFinishWork:TNotifyEvent read fOnFinishWork write fOnFinishWork;
         property OnAcquireBitmap:TIEAcquireBitmapEvent read fOnAcquireBitmap write fOnAcquireBitmap;
         property SimplifiedParamsDialogs:boolean read fSimplifiedParamsDialogs write fSimplifiedParamsDialogs default true;
         property OnDoPreviews:TIEDoPreviewsEvent read fOnDoPreviews write fOnDoPreviews;
         property NativePixelFormat:boolean read fNativePixelFormat write fNativePixelFormat default false;
   end;

function IsKnownFormat(const FileName:AnsiString):boolean;
function FindFileFormat(const nf:AnsiString; VerifyExtension:boolean):TIOFileType;
function FindStreamFormat(fs:TStream):TIOFileType;
function DeleteGifIm(const nf:AnsiString; idx:integer):integer;
function DeleteTIFFIm(const nf:AnsiString; idx:integer):integer;
function DeleteTIFFImGroup(const nf:AnsiString; Indexes:array of integer):integer;
function EnumGifIm(const nf:AnsiString):integer;
function EnumTIFFIm(const nf:AnsiString):integer;
function EnumTIFFStream(Stream:TStream):integer;
function EnumICOIm(const nf:AnsiString):integer;
function CheckAniGif(const nf:AnsiString):boolean;
procedure IEWriteICOImages(const fileName:AnsiString; images:array of TObject);
(*$ifdef IEDELPHI*)
function JpegLosslessTransform(const SourceFile, DestFile:AnsiString; Transform:TIEJpegTransform; GrayScale:boolean; CopyMarkers:TIEJpegCopyMarkers; CutRect:TRect):boolean;
function JpegLosslessTransformStream(SourceStream, DestStream:TStream; Transform:TIEJpegTransform; GrayScale:boolean; CopyMarkers:TIEJpegCopyMarkers; CutRect:TRect):boolean;
(*$endif*)
procedure ExtractTIFFImageStream(SourceStream,OutStream:TStream; idx:integer);
procedure ExtractTIFFImageFile(const SourceFileName,OutFileName:AnsiString; idx:integer);
procedure InsertTIFFImageStream(SourceStream,InsertingStream,OutStream:TStream; idx:integer);
procedure InsertTIFFImageFile(const SourceFileName,InsertingFileName,OutFileName:AnsiString; idx:integer);
function IEAdjustDPI(bmp:TIEBitmap; Params:TIOParamsVals; FilteredAdjustDPI:boolean):TIEBitmap;


type

TIEReadImageStream=procedure(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec; Preview:boolean);
TIEWriteImageStream=procedure(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec);
TIETryImageStream=function(Stream:TStream):boolean;

TIEFileFormatInfo=record
	FileType:TIOFileType;
   FullName:String[80];		// ex 'JPEG Bitmap'
   Extensions:String[80];	// extensions without '.' ex 'jpg' (ex 'jpg;jpeg;jpe')
   DialogPage:TPreviewParams;
   ReadFunction:TIEReadImageStream;
	WriteFunction:TIEWriteImageStream;
	TryFunction:TIETryImageStream;
end;
PIEFileFormatInfo=^TIEFileFormatInfo;

// custom file formats registration functions
function IEFileFormatGetInfo(FileType:TIOFileType):PIEFileFormatInfo;
function IEFileFormatGetInfo2(Extension:AnsiString):PIEFileFormatInfo;
function IEFileFormatGetExt(FileType:TIOFileType; idx:integer):AnsiString;
function IEFileFormatGetExtCount(FileType:TIOFileType):integer;
procedure IEFileFormatAdd(const FileFormatInfo:TIEFileFormatInfo);
procedure IEFileFormatRemove(FileType:TIOFileType);
// others
procedure IEUpdateGIFStatus;

type

   TIEColorSpace=(ieBGR, ieCMYK, ieCIELab);
	TIEConvertColorFunction=procedure(InputScanline:pointer; InputColorSpace:TIEColorSpace; OutputScanline:pointer; OutputColorSpace:TIEColorSpace; ImageWidth:integer);

var
	DefGIF_LZWDECOMPFUNC:TGIFLZWDecompFunc;
   DefGIF_LZWCOMPFUNC:TGIFLZWCompFunc;
   DefTIFF_LZWDECOMPFUNC:TTIFFLZWDecompFunc;
   DefTIFF_LZWCOMPFUNC:TTIFFLZWCompFunc;
   iegFileFormats:TList;
   DefTEMPPATH:AnsiString;
   {$ifdef IEINCLUDETWAIN}
	iegTWainLogName:AnsiString;
   iegTWainLogFile:textfile;
   {$endif}
   IEConvertColorFunction:TIEConvertColorFunction;

function IECMYK2RGB(cmyk:TCMYK):TRGB;
function IERGB2CMYK(const rgb:TRGB):TCMYK;
procedure IEDefaultConvertColorFunction(InputScanline:pointer; InputColorSpace:TIEColorSpace; OutputScanline:pointer; OutputColorSpace:TIEColorSpace; ImageWidth:integer);

implementation

{$ifdef IEKYLIX}
uses iemview, bmpfilt,jpegfilt, tiffilt,ietgafil,giffilter,pcxfilter,pngfilt,pngfiltw, giflzw, tiflzw,
  Windows, Graphics;
{$endif}
{$ifdef IEDELPHI}
uses GifFilter, PCXFilter, imscan, Tiffilt, jpegfilt, BMPFilt, IOPreviews,
     pngfilt, pngfiltw, neurquant, ietgafil, IEMIO, IEMView, IEOpenSaveDlg, ieprnform1, ieprnform2, IEVfw, iej2000, giflzw, tiflzw,
     l3MetafileHeader;
{$endif}

{$R-}

function DetectMetafile(aStream: TStream): Boolean;
{$IfNDef XE}
var
 l_EnhHeader: TEnhMetaHeader;
 l_HEader   : TMetaHeader;
 {$IfNDef DesignTimeLibrary}
 l_WMFHeader: Tl3MetafileHeader;
 {$EndIf  DesignTimeLibrary}
 l_Size: Int64;
 l_StartPos: Int64;
{$EndIf XE}
begin
 {$IfNDef XE}
 Result := False;
 l_StartPos := aStream.Position;
 l_Size := aStream.Size - l_StartPos;
 // EMF
 if l_Size > SizeOf(TEnhMetaHeader) then
 begin
  aStream.Read(l_EnhHeader, SizeOf(TEnhMetaHeader));
  aStream.Seek(-SizeOf(TEnhMetaHeader), soFromCurrent);
  Result := (l_EnhHeader.iType = EMR_HEADER) and (l_EnhHeader.dSignature = ENHMETA_SIGNATURE);
 end;
 // WMF с заголовком
 {$IfNDef DesignTimeLibrary}
 if not Result and (l_Size > SizeOf(Tl3MetafileHeader)) then
 begin
  aStream.Read(l_WMFHeader, SizeOf(Tl3MetafileHeader));
  aStream.Seek(-SizeOf(Tl3MetafileHeader), soFromCurrent);
  Result := l3IsValidMetafileHeader(l_WMFHeader);
 end;
 {$EndIf DesignTimeLibrary}
 // WMF без заголовка
 if not Result and (l_Size > SizeOf(TMetaHeader)) then
 begin
  aStream.Read(l_Header, SizeOf(TMetaHeader));
  aStream.Seek(-SizeOf(TMetaHeader), soFromCurrent);
  Result := (l_Header.mtType in [1,2]) and ((l_Header.mtVersion = $0300) or (l_Header.mtVersion = $0100));
 end;
 {$Else  XE}
 Assert(false);
 {$EndIf XE}
end;


//procedure _HDIBDrawTo(DestCanvas:TCanvas; fhdib:THANDLE; orgx,orgy,orgdx,orgdy,destx,desty,destdx,destdy:integer); forward;

constructor TImageEnIO.Create(Owner: TComponent);
begin
	inherited Create(Owner);
	//
   fIEBitmap:=TIEBitmap.Create;
   fIEBitmapCreated:=true; // we create fIEBitmap
   InitializeCriticalSection(fAsyncThreadsCS);
   fImageEnViewIdx:=-1;
   fOnIOPreview:=nil;
   fStreamHeaders:=false;
   fParams:=TIOParamsVals.Create(self);
   {$ifdef IEINCLUDETWAIN}
   fTWainParams:=TIETWainParams.Create(Self);
   {$endif}
   (*$ifdef IEINCLUDESANE*)
   fSANEParams:=TIESANEParams.Create(Self);
   (*$endif*)
   fBitmap:=nil;
   fImageEnView:=nil;
   fTImage:=nil;
   fBackground:=clBlack;
   fOnProgress:=nil;
   fOnFinishWork:=nil;
   fPreviewsParams:=[];
   fPreviewFont:=TFont.Create;
   fMsgLanguage:=msSystem;
   fAborting:=false;
   fDialogsMeasureUnit:=ieduInches;
   fAutoAdjustDPI:=False;
   fFilteredAdjustDPI:=false;
   (*$ifdef IEDELPHI*)
   fAVI_avf:=nil;
   fAVI_avs:=nil;
   fAVI_avs1:=nil;
   fAVI_gf:=nil;
   (*$endif*)
   fAsyncThreads:=TList.Create;
   fAsyncMode:=false;
   fPrintingFilterOnSubsampling:=true;
   fgrec:=nil;
   fOnAcquireBitmap:=nil;
   SimplifiedParamsDialogs:=true;
   fOnDoPreviews:=nil;
   fChangeBackground:=false;
   ProxyAddress:='';
   ProxyUser:='';
   ProxyPassword:='';
   fDefaultDitherMethod:=ieThreshold;
   fResetPrinter:=true;
   fPS_handle:=nil;
   fPS_stream:=nil;
   fPDF_handle:=nil;
   fPDF_stream:=nil;
   {$ifdef IEINCLUDEWIA}
   fWIA:=nil;
   {$endif}
   {$ifdef IEINCLUDEDIRECTSHOW}
   fDShow:=nil;
   {$endif}
   fNativePixelFormat:=false;
end;

procedure TImageEnIO.WaitThreads(Aborts:boolean);
var
   i:integer;
begin
   repeat
   	EnterCriticalSection(fAsyncThreadsCS);
      if Aborts then
      	fAborting:=true;
      i:=fAsyncThreads.Count;
      LeaveCriticalSection(fAsyncThreadsCS);
      if i=0 then
         break;
      sleep(0); // give up the remainder of my current time slice
   until false;
end;

procedure TImageEnIO.Cleanup;
begin
   // wait threads
   WaitThreads(false);
   FreeAndNil(fAsyncThreads);
   //
   (*$ifdef IEDELPHI*)
	CloseAVIFile;	// works only if AVI is not closed
   (*$endif*)
   ClosePSFile;
   ClosePDFFile;
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
   FreeAndNil(fParams);
   {$ifdef IEINCLUDETWAIN}
   FreeAndNil(fTWainParams);
   {$endif}
   (*$ifdef IEINCLUDESANE*)
   FreeAndNil(fSANEParams);
   (*$endif*)
   FreeAndNil(fPreviewFont);
   if fIEBitmapCreated then
      FreeAndNil(fIEBitmap);
   {$ifdef IEINCLUDEWIA}
   if assigned(fWia) then
   	FreeAndNil(fWia);
   {$endif}
   {$ifdef IEINCLUDEDIRECTSHOW}
   if assigned(fDShow) then
   	FreeAndNil(fDShow);
   {$endif}
   //
   DeleteCriticalSection(fAsyncThreadsCS);
   //
   inherited;
end;

procedure TImageEnIO.Update;
begin
	// remove alpha if attached to fBitmap
   if assigned(fBitmap) then
		fIEBitmap.RemoveAlphaChannel;
   // imageen
   if assigned(fImageEnView) then
     	with fImageEnView do begin
      	{$ifdef IEDELPHI}
      	if IsInsideAsyncThreads then
         	PostMessage(handle,IEM_UPDATE,0,0)
         else
         {$endif}
		      Update;
	      ImageChange;
      end
   else if assigned(fBitmap) then
   	fBitmap.modified:=true;
end;

// Get effective background color
function TImageEnIO.GetReBackground:TColor;
begin
	if assigned(fImageEnView) then
   	result:=fImageEnView.background
   else
   	result:=fBackground;
end;

// Set background effective color
procedure TImageEnIO.SetReBackground(v:TColor);
begin
	if assigned(fImageEnView) then begin
   	{$ifdef IEINCLUDEMULTIVIEW}
   	if not (fImageEnView is TImageEnMView) then
      {$endif}
      	if fChangeBackground then
		   	fImageEnView.background:=v;
   end else
   	fBackground:=v;
end;

function TImageEnIO.IsInsideAsyncThreads:boolean;
var
   i:integer;
   ch:THandle;
begin
   result:=false;
   ch:=GetCurrentThreadId;
   try
   EnterCriticalSection(fAsyncThreadsCS);
   for i:=0 to fAsyncThreads.Count-1 do
      if TIEIOThread(fAsyncThreads.Items[i]).ThreadId=ch then begin
         result:=true;
         exit;
      end;
   finally
      LeaveCriticalSection(fAsyncThreadsCS);
   end;
end;

procedure TImageEnIO.DoFinishWork;
begin
   if assigned(fOnProgress) then
      fOnProgress(self, 100);
   if assigned(fOnFinishWork) then
      fOnFinishWork(self);
end;

function TImageEnIO.MakeConsistentBitmap(allowedFormats:TIEPixelFormatSet):boolean;
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

procedure TImageEnIO.SaveToFileGif(const nf:AnsiString);
var
	Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileGif,nf);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	WriteGif(nf,fiebitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

function TImageEnIO.InsertToFileGif(const nf:AnsiString):integer;
var
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFileRetInt(self,fAsyncThreads,InsertToFileGif,nf);
      result:=-1;
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
	result:=0;
   if not MakeConsistentBitmap([]) then
   	exit;
   if fParams.GIF_WinWidth<(fiebitmap.width+fParams.GIF_XPos) then
     	fParams.GIF_WinWidth:=fiebitmap.width+fParams.GIF_XPos;
   if fParams.GIF_WinHeight<(fiebitmap.height+fParams.GIF_ypos) then
     	fParams.GIF_WinHeight:=fiebitmap.height+fParams.GIF_ypos;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	result:=_InsertGifIm(nf,fIEBitmap,fParams,Progress);
   if not fAborting then
		_GifMakeAnimate(nf,0,fParams.GIF_WinWidth,fParams.GIF_WinHeight);	// makes it animated
   finally
		DoFinishWork;
   end;
end;

function TImageEnIO.InsertToFileTIFF(const nf:AnsiString):integer;
var
	Progress:TProgressRec;
   fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFileRetInt(self,fAsyncThreads,InsertToFileTIFF,nf);
      result:=-1;
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
	result:=0;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=nil;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fs:=TFileStream.Create(nf,fmOpenReadWrite);
   fAborting:=false;
   result:=TIFFWriteStream(fs,true,fIEBitmap,fParams,Progress);
   finally
   	FreeAndNil(fs);
   end;
   finally
		DoFinishWork;
   end;
end;

// Remove the image idx from the specified GIF
// returns the remaining images count
function DeleteGifIm(const nf:AnsiString; idx:integer):integer;
begin
	result:=_DeleteGifIm(nf,idx,true);
end;

// removes the image idx from the specified tiff
// returns the remained images
function DeleteTIFFIm(const nf:AnsiString; idx:integer):integer;
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmOpenReadWrite);
   try
   result:=_DeleteTIFFImStream(fs,idx);
   finally
   	FreeAndNil(fs);
   end;
end;

function DeleteTIFFImGroup(const nf:AnsiString; Indexes:array of integer):integer;
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmOpenReadWrite);
   try
   result:=_DeleteTIFFImStreamGroup(fs,@Indexes,high(Indexes)+1);
   finally
   	FreeAndNil(fs);
   end;
end;

// Enumerates images in the specified GIF
function EnumGifIm(const nf:AnsiString):integer;
begin
	try
   result:=_DeleteGifIm(nf,-1,false);
   except
   	result:=0;
   end;
end;

// Enumerates images in the specified TIFF
function EnumTIFFIm(const nf:AnsiString):integer;
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   try
   result:=_EnumTIFFImStream(fs);
   finally
		FreeAndNil(fs);
   end;
end;

function EnumTIFFStream(Stream:TStream):integer;
begin
	result:=_EnumTIFFImStream(Stream);
end;

function EnumICOIm(const nf:AnsiString):integer;
var
	fs:TFileStream;
begin
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   try
   result:=_EnumICOImStream(fs);
   finally
		FreeAndNil(fs);
   end;
end;

// Returns True is the specified GIF is animated
function CheckAniGif(const nf:AnsiString):boolean;
begin
	try
	result:=_CheckGifAnimate(nf);
   except
   	result:=false;
   end;
end;

procedure TImageEnIO.SaveToFile(const nf:AnsiString);
var
	ex:AnsiString;
   fpi:PIEFileFormatInfo;
	fs:TFileStream;
   Progress:TProgressRec;
begin
	ex:=lowercase(ExtractFileExt(nf));
   if nf='' then exit;
   if (ex='.jpg') or (ex='.jpeg') or (ex='.jpe') then
   	SaveToFileJpeg(nf)
   {$ifdef IEINCLUDEJPEG2000}
   else if (ex='.jp2') then
   	SaveToFileJP2(nf)
   else if (ex='.j2k') or (ex='.jpc') or (ex='.j2c') then
   	SaveToFileJ2K(nf)
   {$endif}
   else if ex='.pcx' then
      SaveToFilePCX(nf)
   else if ex='.gif' then
      SaveToFileGif(nf)
   else if (ex='.tif') or (ex='.tiff') or (ex='.fax') or (ex='.g3f') or (ex='.g3n') then
		SaveToFileTIFF(nf)
   {$ifdef IEINCLUDEPNG}
   else if (ex='.png') then
   	SaveToFilePNG(nf)
   {$endif}
   else if (ex='.bmp') or (ex='.dib') or (ex='.rle') then
      SaveToFileBMP(nf)
   else if (ex='.tga') or (ex='.targa') or (ex='.vda') or (ex='.icb') or (ex='.vst') or (ex='.win') then
   	SaveToFileTGA(nf)
   else if (ex='.pxm') or (ex='.pbm') or (ex='.pgm') or (ex='.ppm') then
   	SaveToFilePXM(nf)
   else if (ex='.ico') then
   	SaveToFileICO(nf)
   else if (ex='.wbmp') then
   	SaveToFileWBMP(nf)
   else if (ex='.ps') or (ex='.eps') then
   	SaveToFilePS(nf)
   else if (ex='.pdf') then
   	SaveToFilePDF(nf)
   else begin
      // try registered file formats
		fpi:=IEFileFormatGetInfo2(copy(ex,2,length(ex)-1));
      if assigned(fpi) and assigned(fpi^.WriteFunction) then
      	with fpi^ do begin
            if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
               TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFile,nf);
               exit;
            end;
            try
            fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
            Progress.Aborting:=@fAborting;
            if not MakeConsistentBitmap([]) then
               exit;
            if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
               fIEBitmap.PixelFormat:=ie24RGB;
            fs:=TFileStream.Create(nf,fmCreate);
            fAborting:=false;
            Progress.fOnProgress:=fOnProgress;
            Progress.Sender:=Self;
            fParams.fFileName:=nf;
            fParams.fFileType:=FileType;
            try
               WriteFunction(fs,fIEBitmap,fParams,Progress);
            finally
               FreeAndNil(fs);
            end;
            finally
					DoFinishWork;
            end;
      	end
      else
      	fAborting:=True;
	end;
end;

procedure TImageEnIO.SaveToStreamGif(Stream:TStream);
var
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamGif,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	WriteGifStream(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

{$ifdef IEINCLUDETWAIN}
function TImageEnIO.Acquire(api:TIEAcquireApi):boolean;
var
   Progress:TProgressRec;
begin
	// calling Acquire after AcquireOpen!!!!
	if assigned(fgrec) then begin
   	result:=true;	// there is already a scanner dialog open
	   exit;
   end;
   //
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateAcquire(self,fAsyncThreads,Acquire,api);
      result:=true;
      exit;
   end;
   try
	fAborting:=false;
	result:=false;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   if not MakeConsistentBitmap([]) then
   	exit;
   case api of
   	ieaTWain:
      	begin
            fTWainParams.LastError:=0;
            fTWainParams.LastErrorStr:='';
            if IETW_Acquire(fIEBitmap,false,nil,fTWainParams,fParams,Progress,@fTWainParams.TWainShared,IEFindHandle(self)) then begin
               result:=true;
               if fAutoAdjustDPI then
                  AdjustDPI;
               if assigned(fImageEnView) then begin
                  fImageEnView.dpix:=fParams.DpiX;
                  fImageEnView.dpiy:=fParams.DpiY;
               end;
            end;
            SetFocus(IEFindHandle(self));
         end;
      ieaWIA:
      	begin
         	{$ifdef iEINCLUDEWIA}
            WIAParams.ProcessingBitmap:=fIEBitmap;
            WIAParams.Transfer( nil, false );
            {$endif}
         end;
	end;
	Update;
   finally
		DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDETWAIN}
function TImageEnIO.SelectAcquireSource(api:TIEAcquireApi):boolean;
var
	sn:AnsiString;
begin
	result:=false;
	case api of
   	ieaTWain:
      	begin
            result:=IETW_SelectImageSource(sn,@fTWainParams.TWainShared,IEFindHandle(self));
            fTWainParams.SelectSourceByName(sn);
         end;
      ieaWIA:
      	begin
         	{$ifdef IEINCLUDEWIA}
            result:=WIAParams.ConnectToUsingDialog;
            {$endif}
         end;
   end;
end;
{$endif}

// return remaining images
(*
function TImageEnIO.SyncLoadFromStreamGif(Stream:TStream):integer;
var
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
 	ReadGifStream(Stream,fIEBitmap,result,fParams,Progress,false,tmpAlphaChannel,false);
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      tmpAlphaChannel.free;
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioGIF;
   if fParams.GIF_FlagTranspColor then
     	BackGround:=TRGB2TCOLOR(fParams.GIF_TranspColor)
   else
     	BackGround:=TRGB2TCOLOR(fParams.GIF_Background);
   update;
   finally
		DoFinishWork;
   end;
end;
*)

function TImageEnIO.SyncLoadFromStreamGif(Stream:TStream):integer;
var
	bmp,merged:TIEBitmap;
   numi,p1,reqidx:integer;
   Progress,Progress2:TProgressRec;
   im:integer;
   tempAlphaChannel:TIEMask;
   dummy1:ppointerarray;
   dummy2,dummy3:pinteger;
   act:TIEGifAction;
   backx,backy,backw,backh:integer;
   dx,dy:integer;
begin
	result:=0;
   try
   fAborting:=False;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;

   Progress2.fOnProgress:=nil;
   Progress2.Sender:=nil;
   Progress2.Aborting:=@fAborting;
   p1:=Stream.Position;
   im:=0;
   merged:=TIEBitmap.Create;
   merged.Location:=ieTBitmap;
   act:=ioGIF_None;
   backw:=0;
   backh:=0;
   backx:=0;
   backy:=0;
   reqidx:=fParams.GIF_ImageIndex;
   repeat
   	bmp:=TIEBitmap.Create;
      Stream.position:=p1;
      fParams.GIF_ImageIndex:=im;
      tempAlphaChannel:=nil;
   	ReadGifStream(Stream,bmp,numi,fParams,Progress2,False,tempAlphaChannel,false);
      CheckDPI;
      dx:=imax(fParams.GIF_WinWidth,bmp.Width);
      dy:=imax(fParams.GIF_WinHeight,bmp.Height);
      if assigned(tempAlphaChannel) then begin
         bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
         FreeAndNil(tempAlphaChannel);
      end;
      if numi>1 then begin
         if act=ioGIF_DrawBackground then begin
            merged.FillRect(backx,backy,backx+backw-1,backy+backh-1,TRGB2TColor(fParams.GIF_Background));
         end;
         if (merged.Width=0) or (bmp.PixelFormat<>merged.PixelFormat) then begin
            merged.Allocate(dx,dy,bmp.PixelFormat);
            merged.Fill( TRGB2TColor( fParams.GIF_Background ));
         end;
         if (dx>merged.Width) or (dy>merged.Height) then
            merged.Resize(dx,dy,TRGB2TColor( fparams.GIF_Background ),255,iehLeft,ievTop);
         dummy1:=nil;
         dummy2:=nil;
         dummy3:=nil;
         bmp.RenderToTBitmap(merged.VclBitmap,dummy1,dummy2,dummy3,nil,fParams.GIF_XPos,fParams.GIF_YPos,bmp.Width,bmp.Height,0,0,bmp.Width,bmp.Height, true ,false,255,rfNone,true,ielNormal);
         backw:=bmp.Width;
         backh:=bmp.Height;
         backx:=fParams.GIF_XPos;
         backy:=fParams.GIF_YPos;
         FreeAndNil(bmp);
         bmp:=merged;
         act:=fparams.GIF_Action;	// act refers to the action of next image
      end;
      //
      if fAborting then begin
         FreeAndNil(bmp);
         break;
      end;
		if numi>0 then begin
	      Progress.per1:=100/numi;
         fIEBitmap.Assign(bmp);
      end;
      if bmp<>merged then
	      FreeAndNil(bmp);
      with Progress do
	      if assigned(fOnProgress) then
    	  		fOnProgress(Sender,trunc(per1*im));
      if fAborting then
      	break;
      inc(im);
   until (im>=numi) or (im-1=reqidx);
   FreeAndNil(merged);
   fParams.GIF_ImageIndex:=reqidx;
   result:=numi;

   if fAutoAdjustDPI then
   	AdjustDPI;
   if fParams.GIF_FlagTranspColor then
       BackGround:=TRGB2TCOLOR(fParams.GIF_TranspColor)
    else
       BackGround:=TRGB2TCOLOR(fParams.GIF_Background);

   fParams.FileType:=ioGIF;
   fParams.fFileName:='';
   Update;
   finally
   	DoFinishWork;
   end;
end;


// return remaining images
function TImageEnIO.LoadFromFileGif(const nf:AnsiString):integer;
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFileRetInt(self,fAsyncThreads,LoadFromFileGif,nf);
      result:=-1;
      exit;
   end;
	fs:=TFileStream.create(nf,fmOpenRead or fmShareDenyWrite);
   try
   result:=SyncLoadFromStreamGif(fs);
   fParams.fFileName:=nf;
   finally
	   FreeAndNil(fs);
   end;
end;

// returns remaining images
function TImageEnIO.LoadFromStreamGif(Stream:TStream):integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStreamRetInt(self,fAsyncThreads,LoadFromStreamGif,Stream);
      result:=-1;
      exit;
   end;
	result:=SyncLoadFromStreamGif(Stream);
end;

// all'inizio dello stream si aspetta la struttura PCXSHead (se fStreamHeaders и true)
// Se non trova la struttura PCXSHead, ma solo la stringa 'PCX', allora il file
// PCX deve occupare tutto lo stream.
procedure TImageEnIO.SyncLoadFromStreamPCX(Stream:TStream; streamhead:boolean);
var
   SHead:PCXSHead;
   lp1:integer;
	Progress:TProgressRec;
begin
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   lp1:=0;
   if streamhead then begin
      // carica header
      lp1:=Stream.position;
      Stream.Read(SHead,sizeof(PCXSHead));
      if copy(SHead.id,1,3)<>'PCX' then begin
      	fAborting:=true;
         exit;
      end;
      if SHead.id<>'PCX2' then begin
         Stream.position:=lp1+4;
         SHead.dim:=Stream.size;
      end;
   end else
      SHead.dim:=Stream.size;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   ReadPcxStream(Stream,fIEBitmap,fParams,SHead.dim,Progress,false);
   CheckDPI;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioPCX;
   if assigned(fImageEnView) then
      fImageEnView.SetDpi(fParams.DpiX,fParams.DpiY);
   Update;
   if streamhead and (SHead.id='PCX2') then
      Stream.Position:=lp1+sizeof(SHead)+SHead.dim;	// posiziona alla fine del blocco PCX
   finally
		DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromStreamPCX(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamPCX,Stream);
      exit;
   end;
   SyncLoadFromStreamPCX(Stream,fStreamHeaders);
end;

procedure TImageEnIO.LoadFromFilePCX(const nf:AnsiString);
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFilePCX,nf);
      exit;
   end;
	fs:=TFileStream.create(nf,fmOpenRead or fmShareDenyWrite);
   try
   SyncLoadFromStreamPCX(fs,false);
   fParams.fFileName:=nf;
   finally
	   FreeAndNil(fs);
   end;
end;

// Carica immagine TIFF da stream.
// All'inizio dello stream si aspetta la struttura TIFFSHead (se fStreamHeaders и true)
// rest. numero immagini presenti nel file
function TImageEnIO.SyncLoadFromStreamTIFF(Stream:TStream; streamhead:boolean):integer;
var
	SHead:TIFFSHead;
 Progress:TProgressRec;
 p0:integer;
 tmpAlphaChannel:TIEMask;
begin
 try
	 fAborting:=false;
  Progress.Aborting:=@fAborting;
  if not MakeConsistentBitmap([]) then
  	exit;
	 fParams.ResetInfo;
  p0:=0;
  if streamhead then
  begin
   Stream.read(SHead,sizeof(SHead));
   p0:=Stream.position;
   if SHead.id<>'TIFF' then
   begin
    fAborting:=true;
    result:=0;
    exit;
   end;
  end;
  Progress.fOnProgress:=fOnProgress;
  Progress.Sender:=Self;
  fIEBitmap.RemoveAlphaChannel;
  tmpAlphaChannel:=nil;
  TIFFReadStream(fIEBitmap,Stream,result,fParams,Progress,false,tmpAlphaChannel, not streamhead,false,false);
  CheckDPI;
  if assigned(tmpAlphaChannel) then
  begin
   fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
   FreeAndNil(tmpAlphaChannel);
  end;
  if fAutoAdjustDPI then
   AdjustDPI;
  if streamhead then
   Stream.Position:=p0+SHead.dim;
  if assigned(fImageEnView) then
   fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
  fParams.fFileName:='';
  fParams.fFileType:=ioTIFF;
  update;
 finally
	 DoFinishWork;
 end;
end;

function TImageEnIO.LoadFromStreamTIFF(Stream:TStream):integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStreamRetInt(self,fAsyncThreads,LoadFromStreamTIFF,Stream);
      result:=-1;
      exit;
   end;
   result := SyncLoadFromStreamTIFF(Stream,fStreamHeaders);
end;

// returns remaining images
function TImageEnIO.LoadFromFileTIFF(const nf:AnsiString):integer;
var
   fs:TFileStream;
   I: Integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFileRetInt(self,fAsyncThreads,LoadFromFileTIFF,nf);
      result:=-1;
      exit;
   end;
   {V}
   // пробуем открывать файл в течении 30 секунд
   I := 0;
   fs := nil;
   repeat
    try
     fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
     I := 100;
    except
     on EFOpenError do
     begin
      if I < 30 then
      begin
       Inc(I);
       Sleep(1000);
      end
      else
       raise;
     end;
    end;
   until I > 30;
   {/V}
   try
    result:=SyncLoadFromStreamTIFF(fs,false);
   finally
      FreeAndNil(fs);
   end;
   fParams.fFileName:=nf;
end;

procedure TImageEnIO.LoadFromFile(const nf:AnsiString);
var
	ex:AnsiString;
   fpi:PIEFileFormatInfo;
   fs:TFileStream;
   Progress:TProgressRec;
begin
	if not assigned(fIEBitmap) then exit;
   if nf='' then begin
      fAborting:=True;
      DoFinishWork;
      exit;
   end;
	ex:=lowercase(ExtractFileExt(nf));
   if lowercase(copy(nf,1,7))='http://' then
   	LoadFromURL(nf)
   else if (ex='.jpg') or (ex='.jpeg') or (ex='.jpe') then
   	LoadFromFileJpeg(nf)
   {$ifdef IEINCLUDEJPEG2000}
   else if (ex='.jp2') then
      LoadFromFileJP2(nf)
   else if (ex='.j2k') or (ex='.jpc') or (ex='.j2c') then
      LoadFromFileJ2K(nf)
   {$endif}
   {$ifdef IEINCLUDEPNG}
   else if (ex='.png') then
   	LoadFromFilePNG(nf)
   {$endif}
   else if (ex='.tif') or (ex='.tiff') or (ex='.fax') or (ex='.g3n') or (ex='.g3f') then
     	LoadFromFileTiff(nf)
   else if (ex='.pcx') then
   	LoadFromFilePCX(nf)
   else if (ex='.gif') then
   	LoadFromFileGif(nf)
   (*$ifdef IEDELPHI*)
   else if (ex='.wmf') or (ex='.emf') then
		ImportMetaFile(nf,-1,-1,true)
   (*$endif*)
   else if (ex='.bmp') or (ex='.dib') or (ex='.rle') then
   	LoadFromFileBMP(nf)
   else if (ex='.cur') then
   	LoadFromFileCUR(nf)
   else if (ex='.ico') then
   	LoadFromFileICO(nf)
   else if (ex='.tga') or (ex='.targa') or (ex='.vda') or (ex='.icb') or (ex='.vst') or (ex='.win') then
   	LoadFromFileTGA(nf)
   else if (ex='.pxm') or (ex='.ppm') or (ex='.pgm') or (ex='.pbm') then
   	LoadFromFilePXM(nf)
   else if (ex='.wbmp') then
   	LoadFromFileWBMP(nf)
   else if (ex='.avi') then begin
   	{$ifdef IEDELPHI}
		OpenAVIFile(nf);
		LoadFromAVI(0);
      CloseAVIFile;
      Params.fFileName:=nf;
      Params.fFileType:=ioAVI;
      {$endif}
   end else begin
      Params.fFileName:='';
      Params.fFileType:=ioUnknown;
		fParams.ResetInfo;
   	// try registered file formats
		fpi:=IEFileFormatGetInfo2(copy(ex,2,length(ex)-1));
      if assigned(fpi) and assigned(fpi^.ReadFunction) then
      	with fpi^ do begin
   	   	// file format supported
            if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
               TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFile,nf);
               exit;
            end;
            fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
            Progress.Aborting:=@fAborting;
            if not MakeConsistentBitmap([]) then
               exit;
            fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
            fAborting:=false;
            Progress.fOnProgress:=fOnProgress;
            Progress.Sender:=Self;
            fParams.fFileName:=nf;
            fParams.fFileType:=FileType;
            try
            ReadFunction(fs,fIEBitmap,fParams,Progress,False);
            except
            fAborting:=True;
            end;
            if not fAborting then begin
               if fAutoAdjustDPI then
                  AdjustDPI;
               if assigned(fImageEnView) then
                  fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
            end;
            update;
            FreeAndNil(fs);
            DoFinishWork;
	      end
      else begin
      	fAborting:=True;
         DoFinishWork;
      end;
   end;
end;

procedure TImageEnIO.LoadFromFileFormat(const nf:AnsiString; FileFormat:TIOFileType);
var
   fpi:PIEFileFormatInfo;
   fs:TFileStream;
   Progress:TProgressRec;
begin
 if FileFormat = ioUnknown then
  FileFormat := FindFileFormat(nf, False);
	case FileFormat of
  		ioTIFF: LoadFromFileTiff(nf);
		ioGIF: LoadFromFileGif(nf);
		ioJPEG: LoadFromFileJpeg(nf);
 	   ioPCX: LoadFromFilePCX(nf);
	   ioBMP: LoadFromFileBMP(nf);
	   ioICO: LoadFromFileICO(nf);
	   ioCUR: LoadFromFileCUR(nf);
      {$ifdef IEINCLUDEPNG}
	   ioPNG: LoadFromFilePNG(nf);
      {$endif}
      (*$ifdef IEDELPHI*)
	   ioWMF: ImportMetaFile(nf,-1,-1,true);
	   ioEMF: ImportMetaFile(nf,-1,-1,true);
      (*$endif*)
	   ioTGA: LoadFromFileTGA(nf);
      ioPXM: LoadFromFilePXM(nf);
      ioWBMP: LoadFromFIleWBMP(nf);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2: LoadFromFileJP2(nf);
      ioJ2K: LoadFromFileJ2K(nf);
      {$endif}
      else begin
			fParams.ResetInfo;
         Params.fFileName:='';
         Params.fFileType:=ioUnknown;
         // try registered file formats
         fpi:=IEFileFormatGetInfo(FileFormat);
         if assigned(fpi) and assigned(fpi^.ReadFunction) then
            with fpi^ do begin
               // file format supported
               if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
                  TIEIOThread.CreateLoadSaveFileFormat(self,fAsyncThreads,LoadFromFileFormat,nf,FileFormat);
                  exit;
               end;
               try
               fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
               Progress.Aborting:=@fAborting;
               if not MakeConsistentBitmap([]) then
                  exit;
               fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
               fAborting:=false;
               try
               Progress.fOnProgress:=fOnProgress;
               Progress.Sender:=Self;
               fParams.fFileName:=nf;
               fParams.fFileType:=FileType;
               ReadFunction(fs,fIEBitmap,fParams,Progress,False);
               if fAutoAdjustDPI then
                  AdjustDPI;
               if assigned(fImageEnView) then
                  fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
               update;
               finally
                  FreeAndNil(fs);
               end;
               finally
               	DoFinishWork;
               end;
            end
         else begin
            fAborting:=True;
            DoFinishWork;
         end;
      end;
   end;
end;

procedure TImageEnIO.Notification(AComponent: TComponent; Operation: TOperation);
begin
	inherited Notification(AComponent, Operation);
	if (AComponent=fImageEnView) and (Operation=opRemove) then begin
	   fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);
   	fImageEnView:=nil;
   end;
   if (AComponent=fTImage) and (Operation=opRemove) then fTImage:=nil;
end;

procedure TImageEnIO.SaveToFileJpeg(const nf:AnsiString);
var
	fs:TFileStream;
   Progress:TProgressRec;
   buf:pointer;
   lbuf,mi:integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileJpeg,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   // update APP13 marker with IPTC_Info
   if fParams.IPTC_Info.UserChanged then begin
      fParams.IPTC_Info.SaveToStandardBuffer(buf,lbuf,true);
      mi:=fParams.JPEG_MarkerList.IndexOf(JPEG_APP13);
      if buf<>nil then begin
      	// replace or add IPTC marker
         if mi>=0 then
            fParams.JPEG_MarkerList.SetMarker(mi,JPEG_APP13,buf,lbuf)
         else
            fParams.JPEG_MarkerList.AddMarker(JPEG_APP13,buf,lbuf);
         freemem(buf);
      end else if mi>=0 then
      	// remove IPTC marker
      	fParams.JPEG_MarkerList.DeleteMarker( mi );
   end;
   // Exif info
   if fParams.EXIF_HasExifData then begin
   	SaveEXIFToStandardBuffer(fParams,buf,lbuf);
      mi:=fParams.JPEG_MarkerList.IndexOf(JPEG_APP1);
      if mi>=0 then
         fParams.JPEG_MarkerList.SetMarker(mi,JPEG_APP1,buf,lbuf)
      else
         fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
   end;
	//
   try
   	WriteJpegStream(fs,fIEBitmap,fParams,Progress);
   finally
   	FreeAndNil(fs);
   end;
   finally
	   DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromFileJpeg(const nf:AnsiString);
var
   fs:TFileStream;
   Progress:TProgressRec;
   mi:integer;
   dd:double;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileJpeg,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   ReadJPegStream(fs,nil,fIEBitmap,fParams,Progress,False,false);
   CheckDPI;
  	with fParams.JPEG_MarkerList do begin
   	// IPTC INFO
	   mi:=IndexOf(JPEG_APP13);
	   if mi>=0 then
	   	fParams.IPTC_Info.LoadFromStandardBuffer(MarkerData[mi],MarkerLength[mi]);
      // EXIF INFO
      mi:=IndexOf(JPEG_APP1);
      if mi>=0 then
      	if LoadEXIFFromStandardBuffer(MarkerData[mi],MarkerLength[mi],fParams) then begin
         	// exif found
				if (fParams.DpiX=1) and (fParams.DpiY=1) then begin
            	// use dpi of the Exif
				   if fParams.EXIF_ResolutionUnit=3 then dd:=2.54 else dd:=1;
				  	fParams.DpiX:=trunc(fParams.EXIF_XResolution*dd);
				   fParams.DpiY:=trunc(fParams.EXIF_YResolution*dd);
            end;
         end;
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:=nf;
   fParams.fFileType:=ioJPEG;
   if assigned(fImageEnView) then
      fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   update;
   finally
   	FreeAndNil(fs);
   end;
   finally
	   DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStream(Stream:TStream; FileType:TIOFileType);
var
   fpi:PIEFileFormatInfo;
   Progress:TProgressRec;
begin
	case FileType of
      ioTIFF: SaveToStreamTIFF(Stream);
      ioGIF: SaveToStreamGIF(Stream);
      ioJPEG: SaveToStreamJPEG(Stream);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2: SaveToStreamJP2(Stream);
      ioJ2K: SaveToStreamJ2K(Stream);
      {$endif}
      ioPCX: SaveToStreamPCX(Stream);
      ioBMP: SaveToStreamBMP(Stream);
      {$ifdef IEINCLUDEPNG}
      ioPNG: SaveToStreamPNG(Stream);
      {$endif}
      ioTGA: SaveToStreamTGA(Stream);
      ioPXM: SaveToStreamPXM(Stream);
      ioICO: SaveToStreamICO(Stream);
      ioWBMP: SaveToStreamWBMP(Stream);
      ioPS: SaveToStreamPS(Stream);
      ioPDF: SaveToStreamPDF(Stream);
      else begin
         if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
            TIEIOThread.CreateLoadSaveStreamFormat(self,fAsyncThreads,SaveToStream,Stream,FileType);
            exit;
         end;
         fpi:=IEFileFormatGetInfo(FileType);
         if assigned(fpi) and assigned(fpi^.WriteFunction) then
            with fpi^ do begin
               try
               fAborting:=false;
               Progress.Aborting:=@fAborting;
               if not MakeConsistentBitmap([]) then
                  exit;
               if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
                  fIEBitmap.PixelFormat:=ie24RGB;
               Progress.fOnProgress:=fOnProgress;
               Progress.Sender:=Self;
	            fParams.fFileType:=FileType;
               WriteFunction(Stream,fIEBitmap,fParams,Progress);
               finally
               	DoFinishWork;
               end;
            end
         else
            fAborting:=True;
      end;
   end;
end;

// load image from stream, call FindStreamFormat to select file format
procedure TImageEnIO.LoadFromStream(Stream:TStream);
var
	sf:TIOFileType;
   lp:integer;
   fpi:PIEFileFormatInfo;
   Progress:TProgressRec;
begin
	lp:=Stream.Position;
	sf:=FindStreamFormat(Stream);
   Stream.Position:=lp;
   case sf of
      ioTIFF: LoadFromStreamTIFF(Stream);
      ioGIF: LoadFromStreamGIF(Stream);
      ioJPEG: LoadFromStreamJPEG(Stream);
      ioPCX: LoadFromStreamPCX(Stream);
      ioBMP: LoadFromStreamBMP(Stream);
      ioICO: LoadFromStreamICO(Stream);
      ioCUR: LoadFromStreamCUR(Stream);
      ioEMF: ImportMetafile(Stream, -1, -1, True);
      {$ifdef IEINCLUDEPNG}
      ioPNG: LoadFromStreamPNG(Stream);
      {$endif}
      ioTGA: LoadFromStreamTGA(Stream);
      ioPXM: LoadFromStreamPXM(Stream);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2: LoadFromStreamJP2(Stream);
      ioJ2K: LoadFromStreamJ2K(Stream);
      {$endif}
      else begin
      	// unknown or user registered file formats
         if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
            TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStream,Stream);
            exit;
         end;
			fParams.ResetInfo;
         Params.fFileName:='';
         Params.fFileType:=ioUnknown;
         fpi:=IEFileFormatGetInfo(sf);
         if assigned(fpi) and assigned(fpi^.ReadFunction) then
            with fpi^ do begin
               // file format supported
               try
               fAborting:=false;
               Progress.Aborting:=@fAborting;
               if not MakeConsistentBitmap([]) then
                  exit;
               Progress.fOnProgress:=fOnProgress;
               Progress.Sender:=Self;
               fParams.fFileType:=FileType;
               ReadFunction(Stream,fIEBitmap,fParams,Progress,False);
               if fAutoAdjustDPI then
                  AdjustDPI;
               if assigned(fImageEnView) then
                  fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
               update;
               finally
               	DoFinishWork;
               end;
            end
         else begin
            fAborting:=True;
         	DoFinishWork;
         end;
      end;
	end;
 CheckDPI;
end;

procedure TImageEnIO.LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType);
var
   lp:integer;
   fpi:PIEFileFormatInfo;
   Progress:TProgressRec;
begin
	lp:=Stream.Position;
   Stream.Position:=lp;
   case FileFormat of
      ioTIFF: LoadFromStreamTIFF(Stream);
      ioGIF: LoadFromStreamGIF(Stream);
      ioJPEG: LoadFromStreamJPEG(Stream);
      ioPCX: LoadFromStreamPCX(Stream);
      ioBMP: LoadFromStreamBMP(Stream);
      ioICO: LoadFromStreamICO(Stream);
      ioCUR: LoadFromStreamCUR(Stream);
      {$ifdef IEINCLUDEPNG}
      ioPNG: LoadFromStreamPNG(Stream);
      {$endif}
      ioTGA: LoadFromStreamTGA(Stream);
      ioPXM: LoadFromStreamPXM(Stream);
      ioWBMP: LoadFromStreamWBMP(Stream);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2: LoadFromStreamJP2(Stream);
      ioJ2K: LoadFromStreamJ2K(Stream);
      {$endif}
      else begin
      	// unknown or user registered file formats
         if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
            TIEIOThread.CreateLoadSaveStreamFormat(self,fAsyncThreads,LoadFromStreamFormat,Stream,FileFormat);
            exit;
         end;
			fParams.ResetInfo;
         Params.fFileName:='';
         Params.fFileType:=ioUnknown;
         fpi:=IEFileFormatGetInfo(FileFormat);
         if assigned(fpi) and assigned(fpi^.ReadFunction) then
            with fpi^ do begin
               // file format supported
               try
               fAborting:=false;
               Progress.Aborting:=@fAborting;
               if not MakeConsistentBitmap([]) then
                  exit;
               Progress.fOnProgress:=fOnProgress;
               Progress.Sender:=Self;
               fParams.fFileType:=FileType;
               ReadFunction(Stream,fIEBitmap,fParams,Progress,False);
               if fAutoAdjustDPI then
                  AdjustDPI;
               if assigned(fImageEnView) then
                  fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
               update;
               finally
               	DoFinishWork;
               end;
            end
         else begin
            fAborting:=True;
            DoFinishWork;
         end;
      end;
	end;
end;

procedure TImageEnIO.LoadFromStreamBMP(Stream:TStream);
var
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamBMP,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   BMPReadStream(Stream,fIEBitmap,0,fParams,Progress,false,false);
   CheckDPI;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioBMP;
   update;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToFilePCX(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFilePCX,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
  	WritePcxStream(fs,fIEBitmap,fParams,Progress)
   finally
		FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromFileTGA(const nf:AnsiString);
var
   fs:TFileStream;
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
		TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileTGA,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   	Progress.fOnProgress:=fOnProgress;
      Progress.Sender:=Self;
      fIEBitmap.RemoveAlphaChannel;
      tmpAlphaChannel:=nil;
   	ReadTGAStream(fs,fIEBitmap,fParams,Progress,false,tmpAlphaChannel,false);
      CheckDPI;
      if assigned(tmpAlphaChannel) then begin
         fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
         FreeAndNil(tmpAlphaChannel);
      end;
      if fAutoAdjustDPI then
         AdjustDPI;
      fParams.fFileName:=nf;
      fParams.fFileType:=ioTGA;
		if assigned(fImageEnView) then
   	   fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
      update;
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromStreamTGA(Stream:TStream);
var
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamTGA,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
   ReadTGAStream(Stream,fIEBitmap,fParams,Progress,false,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioTGA;
   update;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToFileTGA(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
   iemask:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileTGA,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   if fIEBitmap.HasAlphaChannel then begin
      iemask:=TIEMask.Create;
      fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
	   WriteTGAStream(fs,fIEBitmap,fParams,Progress,iemask);
      FreeAndNil(iemask);
   end else
		WriteTGAStream(fs,fIEBitmap,fParams,Progress,nil);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamTGA(Stream:TStream);
var
	Progress:TProgressRec;
   iemask:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamTGA,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   if fIEBitmap.HasAlphaChannel then begin
      iemask:=TIEMask.Create;
      fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
	   WriteTGAStream(Stream,fIEBitmap,fParams,Progress,iemask);
      FreeAndNil(iemask);
   end else
		WriteTGAStream(Stream,fIEBitmap,fParams,Progress,nil);
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SyncSaveToStreamBMP(Stream:TStream);
var
	Progress:TProgressRec;
begin
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	BMPWriteStream(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamBMP(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamBMP,Stream);
      exit;
   end;
   SyncSaveToStreamBMP(Stream);
end;

procedure TImageEnIO.SaveToFileBMP(const nf:AnsiString);
var
  	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileBMP,nf);
      exit;
   end;
   fs:=nil;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   fs:=TFileStream.Create(nf,fmCreate);
   SyncSaveToStreamBMP(fs);
   finally
   	FreeAndNil(fs);
   end;
end;

procedure TImageEnIO.SaveToFileTIFF(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileTIFF,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
  	TIFFWriteStream(fs,false,fIEBitmap,fParams,Progress)
   finally
		FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

// all'inizio dello stream viene salvata la struttura TIFFSHead (se fStreamHeaders и true)
procedure TImageEnIO.SaveToStreamTIFF(Stream:TStream);
var
   SHead:TIFFSHead;
   lp1,lp2:integer;
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamTIFF,Stream);
      exit;
   end;
   try
	  fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   lp1:=0;
   if fStreamHeaders then begin
	   lp1:=Stream.position;
	   Stream.write(SHead,sizeof(SHead));	// lascia spazio per header TIFF stream
   end;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   TIFFWriteStream(Stream,false,fIEBitmap,fParams,Progress);
   if fStreamHeaders then begin
	   // salva HEADER-TIFF-STREAM
		  lp2:=Stream.position;
	   Stream.position:=lp1;
	   SHead.id:='TIFF';
	   SHead.dim:=lp2-lp1-sizeof(SHead);
	   Stream.Write(SHead,sizeof(SHead));
	   Stream.position:=lp2;
   end;
   finally
   	DoFinishWork;
   end;
end;

// all'inizio dello stream viene salvata la struttura PCXSHead (se fStreamHeaders и true)
procedure TImageEnIO.SaveToStreamPCX(Stream:TStream);
var
   SHead:PCXSHead;
   lp1,lp2:integer;
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamPCX,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   lp1:=0;
   if fStreamHeaders then begin
	   lp1:=Stream.position;
	   Stream.write(SHead,sizeof(SHead));	// lascia spazio per header PCX stream
   end;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
  	WritePcxStream(Stream,fIEBitmap,fParams,Progress);
   if fStreamHeaders and not fAborting then begin
	   // salva HEADER-PCX-STREAM
		lp2:=Stream.position;
	   Stream.position:=lp1;
	   SHead.id:='PCX2';	// PCX2 и PCX con dimensione
	   SHead.dim:=lp2-lp1-sizeof(SHead);
	   Stream.Write(SHead,sizeof(SHead));
	   Stream.position:=lp2;
   end;
   finally
   	DoFinishWork;
   end;
end;


// do parameters previews
// return True if user press OK
{$ifdef IEINCLUDEDIALOGIO}
function TImageEnIO.DoPreviews(pp:TPreviewParams):boolean;
var
	fIOPreviews:TfIOPreviews;
   Handled:boolean;
begin
	Handled:=false;
	if assigned(fOnDoPreviews) then
		fOnDoPreviews(self,Handled);
   if not Handled then begin
      result:=false;
      if not MakeConsistentBitmap([]) then
         exit;
      if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
         fIEBitmap.PixelFormat:=ie24RGB;
      fIOPreviews:=TfIOPreviews.Create(self);
      fIOPreviews.DefaultLockPreview:=ioppDefaultLockPreview in PreviewsParams;
      fIOPreviews.Button4.Visible:=ioppApplyButton in PreviewsParams;
      fIOPreviews.fParams:=fParams;
      fIOPreviews.fSimplified:=fSimplifiedParamsDialogs;
      if fSimplifiedParamsDialogs then begin
      	fIOPreviews.PageControl1.Height:=trunc(122/96*Screen.PixelsPerInch);
         fIOPreviews.Height:=trunc(360/96*Screen.PixelsPerInch);
      end;
      fIOPreviews.fDefaultDitherMethod:=fDefaultDitherMethod;
      //
      fIOPreviews.SetLanguage(fMsgLanguage);
      fIOPreviews.Font.assign(fPreviewFont);
      //
      with fIOPreviews.ImageEn1 do begin
         self.fIEBitmap.CopyToTBitmap(Bitmap);
         Update;
      end;
      if fIOPreviews.SetPreviewParams(pp) then begin
         if assigned(fOnIOPreview) then
            fOnIOPreview(self,fIOPreviews);
         result:= fIOPreviews.ShowModal=mrOk;
      end;
      fIOPreviews.Release;
      Update;
   end else
   	result:=true;	// handled
end;
{$endif}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

constructor TIOParamsVals.Create(IEIO:TImageEnIO);
begin
	inherited Create;
   fImageEnIO:=IEIO;
   fColorMap:=nil;
   fEXIF_Bitmap:=nil;
   fJPEG_MarkerList:=TIEMarkerList.Create;
   fIPTC_Info:=TIEIPTCInfoList.Create;
   fPXM_Comments:=TStringList.Create;
   fGIF_Comments:=TStringList.Create;
   fImagingAnnot:=TIEImagingAnnot.Create;
   SetDefaultParams;
end;

procedure TIOParamsVals.Cleanup;
begin
	if assigned(fEXIF_Bitmap) then
		FreeAndNil(fEXIF_Bitmap);
	if ColorMap<>nil then
   	freemem(ColorMap);
   FreeAndNil(fJPEG_MarkerList);
   FreeAndNil(fIPTC_Info);
   FreeAndNil(fImagingAnnot);
   FreeAndNil(fPXM_Comments);
   FreeAndNil(fGIF_Comments);
	inherited;
end;

function TIOParamsVals.IsNativePixelFormat:boolean;
begin
	if assigned(fImageEnIO) then
   	result:=fImageEnIO.NativePixelFormat
   else
   	result:=false;
end;

procedure TIOParamsVals.ResetEXIF;
var
	q:integer;
begin
   fEXIF_HasEXIFData:=false;
   if assigned(fEXIF_Bitmap) then
		FreeAndNil(fEXIF_Bitmap);
   fEXIF_Bitmap:=nil;
   fEXIF_ImageDescription:='';
   fEXIF_Make:='';
   fEXIF_Model:='';
   fEXIF_Orientation:=0;
   fEXIF_XResolution:=0;
   fEXIF_YResolution:=0;
   fEXIF_ResolutionUnit:=0;
   fEXIF_Software:='';
   fEXIF_DateTime:='';
   fEXIF_WhitePoint[0]:=0;
   fEXIF_WhitePoint[1]:=0;
   for q:=0 to 5 do
   	fEXIF_PrimaryChromaticities[q]:=0;
   for q:=0 to 2 do
   	fEXIF_YCbCrCoefficients[q]:=0;
   fEXIF_YCbCrPositioning:=0;
   for q:=0 to 5 do
   	fEXIF_ReferenceBlackWhite[q]:=0;
   fEXIF_Copyright:='';
   fEXIF_ExposureTime:=0;
   fEXIF_FNumber:=0;
   fEXIF_ExposureProgram:=0;
   fEXIF_ISOSpeedRatings[0]:=0;
   fEXIF_ISOSpeedRatings[1]:=0;
   fEXIF_ExifVersion:='';
   fEXIF_DateTimeOriginal:='';
   fEXIF_DateTimeDigitized:='';
   fEXIF_CompressedBitsPerPixel:=0;
   fEXIF_ShutterSpeedValue:=0;
   fEXIF_ApertureValue:=0;
   fEXIF_BrightnessValue:=0;
   fEXIF_ExposureBiasValue:=0;
   fEXIF_MaxApertureValue:=0;
   fEXIF_SubjectDistance:=0;
   fEXIF_MeteringMode:=0;
   fEXIF_LightSource:=0;
   fEXIF_Flash:=0;
   fEXIF_FocalLength:=0;
   fEXIF_SubsecTime:='';
   fEXIF_SubsecTimeOriginal:='';
   fEXIF_SubsecTimeDigitized:='';
   fEXIF_FlashPixVersion:='';
   fEXIF_ColorSpace:=0;
   fEXIF_ExifImageWidth:=0;
   fEXIF_ExifImageHeight:=0;
   fEXIF_RelatedSoundFile:='';
   fEXIF_FocalPlaneXResolution:=0;
   fEXIF_FocalPlaneYResolution:=0;
   fEXIF_FocalPlaneResolutionUnit:=0;
   fEXIF_ExposureIndex:=0;
   fEXIF_SensingMethod:=0;
   fEXIF_FileSource:=0;
   fEXIF_SceneType:=0;
   fEXIF_UserComment:='';
   fEXIF_UserCommentCode:='';
end;

// reset only info tags (EXIF, IPTC, JPEG_Tags and comments)
procedure TIOParamsVals.ResetInfo;
begin
   IPTC_Info.Clear;
   fImagingAnnot.Clear;
   JPEG_MarkerList.Clear;
   ResetEXIF;
   GIF_Comments.Clear;
   TIFF_DocumentName:='';
   TIFF_ImageDescription:='';
   TIFF_PageName:='';
   TGA_Descriptor:='';
   TGA_Author:='';
   TGA_ImageName:='';
   PXM_Comments.Clear;
end;

// Resetta parametri ai valori di default
procedure TIOParamsVals.SetDefaultParams;
begin
   // NO COLORMAP
   if ColorMap<>nil then
      freemem(ColorMap);
   fColorMap:=nil;
   fColorMapCount:=0;
   fFileName:='';
   fFileType:=ioUnknown;
   BitsPerSample:=8;		// 8 BITS x SAMPLE
   SamplesPerPixel:=3;  // 3 SAMPLES x PIXEL (RGB)
   if assigned(fImageEnIO) then begin
      if assigned(fImageEnIO.Bitmap) then begin
         fWidth:=fImageEnIO.Bitmap.Width;
         fHeight:=fImageEnIO.Bitmap.Height;
      end;
      if assigned(fImageEnIO.fImageEnView) then begin
         DpiX:=fImageEnIO.fImageEnView.DpiX;
         DpiY:=fImageEnIO.fImageEnView.DpiY;
      end;
   end;
   // GIF
   GIF_Version:='GIF89a';
   GIF_ImageIndex:=0;
   GIF_XPos:=0;
   GIF_YPos:=0;
   GIF_DelayTime:=0;
   GIF_FlagTranspColor:=false;
   GIF_TranspColor:=CreateRGB(0,0,0);
   GIF_Interlaced:=false;
   GIF_WinWidth:=0;
   GIF_WinHeight:=0;
   GIF_Background:=CreateRGB(0,0,0);
   GIF_Ratio:=0;
   GIF_LZWDecompFunc:=DefGIF_LZWDecompFunc;
   GIF_LZWCompFunc:=DefGIF_LZWCompFunc;
   fGIF_ImageCount:=0;
   GIF_Comments.Clear;
   GIF_Action:=ioGIF_None;
   // TIFF
   TIFF_Compression:=ioTIFF_UNCOMPRESSED;
   TIFF_PhotometInterpret:=ioTIFF_RGB;
   TIFF_PlanarConf:=1;
   TIFF_ImageIndex:=0;
   TIFF_XPos:=0;
   TIFF_YPos:=0;
   TIFF_DocumentName:='';
   TIFF_ImageDescription:='';
   TIFF_PageName:='';
   TIFF_PageNumber:=0;
   TIFF_PageCount:=0;
   TIFF_Orientation:=1;
   TIFF_LZWDecompFunc:=DefTIFF_LZWDecompFunc;
   TIFF_LZWCompFunc:=DefTIFF_LZWCompFunc;
   fTIFF_ImageCount:=0;
   fTIFF_EnableAdjustOrientation:=false;
   fTIFF_JPEGQuality:=80;
   fTIFF_JPEGColorSpace:=ioJPEG_YCBCR;
   // JPEG
   JPEG_ColorSpace:=ioJPEG_YCbCr;
   JPEG_Quality:=80;
   JPEG_DCTMethod:=ioJPEG_ISLOW;
   JPEG_OptimalHuffman:=false;
   JPEG_Smooth:=0;
   JPEG_Progressive:=false;
   JPEG_Scale:=ioJPEG_FULLSIZE;
   JPEG_MarkerList.clear;
   JPEG_Scale_Used:=1;
   JPEG_OriginalWidth:=0;
   JPEG_OriginalHeight:=0;
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   fJ2000_ColorSpace:=ioJ2000_RGB;
   fJ2000_Rate:=1;
   fJ2000_ScalableBy:=ioJ2000_Rate;
   {$endif}
   // BMP
   BMP_Compression:=ioBMP_UNCOMPRESSED;
   BMP_Version:=ioBMP_BM3;
   // PCX
   PCX_Version:=5;
   PCX_Compression:=ioPCX_RLE;
   // ICO
   ICO_ImageIndex:=0;
   ICO_Background:=CreateRGB(255,255,255);
   l3FillChar(ICO_Sizes[0],sizeof(TIOICOSizes),0);
   ICO_Sizes[0].cx:=64;
   ICO_Sizes[0].cy:=64;
   l3FillChar(ICO_BitCount[0],sizeof(TIOICOBitCount),0);
   ICO_BitCount[0]:=8;
   // CUR
   CUR_ImageIndex:=0;
   CUR_XHotSpot:=0;
   CUR_XHotSpot:=0;
   CUR_Background:=CreateRGB(255,255,255);
   // PNG
   PNG_Interlaced:=false;
   PNG_Background:=CreateRGB(0,0,0);
   PNG_Filter:=ioPNG_FILTER_NONE;
   PNG_Compression:=5;
   // TGA
   TGA_XPos:=0;
   TGA_YPos:=0;
   TGA_Compressed:=true;
   TGA_Descriptor:='';
   TGA_Author:='';
   TGA_Date:=date;
   TGA_ImageName:='';
   TGA_Background:=CreateRGB(0,0,0);
   TGA_AspectRatio:=1;
   TGA_Gamma:=2.2;
   TGA_GrayLevel:=false;
   // AVI
   AVI_FrameCount:=0;
   AVI_FrameDelayTime:=0;
   // IPTC
   IPTC_Info.Clear;
   // PXM
   PXM_Comments.Clear;
   // EXIF
   ResetEXIF;
   // PS
   PS_PaperWidth:=595;
   PS_PaperHeight:=842;
   PS_Compression:=ioPS_G4FAX;
   PS_Title:='No Title';
   // PDF
   PDF_PaperWidth:=595;
   PDF_PaperHeight:=842;
   PDF_Compression:=ioPDF_G4FAX;
   PDF_Title:='';
   PDF_Author:='';
   PDF_Subject:='';
   PDF_Keywords:='';
   PDF_Creator:='';
   PDF_Producer:='';
   // Imaging Annotations
   fImagingAnnot.Clear;
end;

// assign all parameters
procedure TIOParamsVals.Assign(Source:TIOParamsVals);
var
	q:integer;
begin
   fFileName:=Source.FileName;
   fFileType:=Source.FileType;
   BitsPerSample:=Source.BitsPerSample;
   SamplesPerPixel:=Source.SamplesPerPixel;
   fWidth:=Source.Width;
   fHeight:=Source.Height;
   DpiX:=Source.DpiX;
   DpiY:=Source.DpiY;
   fColorMapCount:=Source.ColorMapCount;
   if ColorMap<>nil then begin
      freemem(ColorMap);
      fColorMap:=nil;
   end;
   if Source.ColorMap<>nil then begin
      getmem(fColorMap,ColorMapCount*sizeof(TRGB));
      copymemory(ColorMap,Source.ColorMap,ColorMapCount*sizeof(TRGB));
   end;
   // TIFF
   TIFF_Compression:=Source.TIFF_Compression;
   TIFF_ImageIndex:=Source.TIFF_ImageIndex;
   TIFF_PhotometInterpret:=Source.TIFF_PhotometInterpret;
   TIFF_PlanarConf:=Source.TIFF_PlanarConf;
   TIFF_XPos:=Source.TIFF_XPos;
   TIFF_YPos:=Source.TIFF_YPos;
   TIFF_DocumentName:=Source.TIFF_DocumentName;
   TIFF_ImageDescription:=Source.TIFF_ImageDescription;
   TIFF_PageName:=Source.TIFF_PageName;
   TIFF_PageNumber:=Source.TIFF_PageNumber;
   TIFF_PageCount:=Source.TIFF_PageCount;
   TIFF_Orientation:=Source.TIFF_Orientation;
   TIFF_LZWDecompFunc:=Source.TIFF_LZWDecompFunc;
   TIFF_LZWCompFunc:=Source.TIFF_LZWCompFunc;
   fTIFF_ImageCount:=Source.TIFF_ImageCount;
   fTIFF_EnableAdjustOrientation:=Source.TIFF_EnableAdjustOrientation;
   fTIFF_JPEGQuality:=Source.fTIFF_JPEGQuality;
   fTIFF_JPEGColorSpace:=Source.fTIFF_JPEGColorSpace;
   // GIF
   GIF_Version:=Source.GIF_Version;
   GIF_ImageIndex:=Source.GIF_ImageIndex;
   GIF_XPos:=Source.GIF_XPos;
   GIF_YPos:=Source.GIF_YPos;
   GIF_DelayTime:=Source.GIF_DelayTime;
   GIF_FlagTranspColor:=Source.GIF_FlagTranspColor;
   GIF_TranspColor:=Source.GIF_TranspColor;
   GIF_Interlaced:=Source.GIF_Interlaced;
   GIF_WinWidth:=Source.GIF_WinWidth;
   GIF_WinHeight:=Source.GIF_WinHeight;
   GIF_Background:=Source.GIF_background;
   GIF_Ratio:=Source.GIF_Ratio;
   GIF_LZWDecompFunc:=Source.GIF_LZWDecompFunc;
   GIF_LZWCompFunc:=Source.GIF_LZWCompFunc;
   fGIF_ImageCount:=Source.GIF_ImageCount;
   GIF_Comments.Assign( Source.GIF_Comments );
   GIF_Action:=Source.GIF_Action;
   // JPEG
   JPEG_ColorSpace:=Source.JPEG_ColorSpace;
   JPEG_Quality:=Source.JPEG_Quality;
   JPEG_DCTMethod:=Source.JPEG_DCTMethod;
   JPEG_OptimalHuffman:=Source.JPEG_OptimalHuffman;
   JPEG_Smooth:=Source.JPEG_Smooth;
   JPEG_Progressive:=Source.JPEG_Progressive;
   JPEG_Scale:=Source.JPEG_Scale;
   JPEG_MarkerList.Assign(Source.JPEG_MarkerList);
   JPEG_Scale_Used:=Source.JPEG_Scale_Used;
   JPEG_OriginalWidth:=Source.JPEG_OriginalWidth;
   JPEG_OriginalHeight:=Source.JPEG_OriginalHeight;
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   fJ2000_ColorSpace:=Source.J2000_ColorSpace;
   fJ2000_Rate:=Source.J2000_Rate;
   fJ2000_ScalableBy:=Source.J2000_ScalableBy;
   {$endif}
   // PCX
   PCX_Version:=Source.PCX_Version;
   PCX_Compression:=Source.PCX_Compression;
   // BMP
   BMP_Version:=Source.BMP_Version;
   BMP_Compression:=Source.BMP_Compression;
   // ICO
   ICO_ImageIndex:=Source.ICO_ImageIndex;
   ICO_Background:=Source.ICO_Background;
   l3move(Source.ICO_Sizes[0],ICO_Sizes[0],sizeof(TIOICOSizes));
   l3move(Source.ICO_BitCount[0],ICO_BitCount[0],sizeof(TIOICOBitCount));
   // CUR
   CUR_ImageIndex:=Source.CUR_ImageIndex;
   CUR_XHotSpot:=Source.CUR_XHotSpot;
   CUR_YHotSpot:=Source.CUR_YHotSpot;
   CUR_Background:=Source.CUR_background;
   // PNG
   PNG_Interlaced:=Source.PNG_Interlaced;
   PNG_Background:=Source.PNG_Background;
   PNG_Filter:=Source.PNG_Filter;
   PNG_Compression:=Source.PNG_Compression;
   // TGA
   TGA_XPos:=Source.TGA_XPos;
   TGA_YPos:=Source.TGA_YPos;
   TGA_Compressed:=Source.TGA_Compressed;
   TGA_Descriptor:=Source.TGA_Descriptor;
   TGA_Author:=Source.TGA_Author;
   TGA_Date:=Source.TGA_Date;
   TGA_ImageName:=Source.TGA_ImageName;
   TGA_Background:=Source.TGA_Background;
   TGA_AspectRatio:=Source.TGA_AspectRatio;
   TGA_Gamma:=Source.TGA_Gamma;
   TGA_GrayLevel:=Source.TGA_GrayLevel;
   // AVI
   AVI_FrameCount:=Source.AVI_FrameCount;
   AVI_FrameDelayTime:=Source.AVI_FrameDelayTime;
   // IPTC
   IPTC_Info.Assign( Source.IPTC_Info );
   // Imaging annotations
   fImagingAnnot.Assign( Source.fImagingAnnot );
   // PXM
   PXM_Comments.Assign( Source.PXM_Comments );
   // EXIF
   fEXIF_HasEXIFData:=Source.fEXIF_HasEXIFData;
   if assigned(Source.fEXIF_Bitmap) then begin
   	if not assigned(fEXIF_Bitmap) then
	   	fEXIF_Bitmap:=TIEBitmap.Create;
      fEXIF_Bitmap.Assign(Source.fEXIF_Bitmap);
   end;
   fEXIF_ImageDescription:=Source.fEXIF_ImageDescription;
   fEXIF_Make:=Source.fEXIF_Make;
   fEXIF_Model:=Source.fEXIF_Model;
   fEXIF_XResolution:=Source.fEXIF_XResolution;
   fEXIF_YResolution:=Source.fEXIF_YResolution;
   fEXIF_ResolutionUnit:=Source.fEXIF_ResolutionUnit;
   fEXIF_Software:=Source.fEXIF_Software;
   fEXIF_DateTime:=Source.fEXIF_DateTime;
   fEXIF_WhitePoint:=Source.fEXIF_WhitePoint;
   for q:=0 to 5 do
   	fEXIF_PrimaryChromaticities[q]:=Source.fEXIF_PrimaryChromaticities[q];
   for q:=0 to 2 do
   	fEXIF_YCbCrCoefficients[q]:=Source.fEXIF_YCbCrCoefficients[q];
   fEXIF_YCbCrPositioning:=Source.fEXIF_YCbCrPositioning;
	for q:=0 to 5 do
   	fEXIF_ReferenceBlackWhite[q]:=Source.fEXIF_ReferenceBlackWhite[q];
   fEXIF_Copyright:=Source.fEXIF_Copyright;
   fEXIF_ExposureTime:=Source.fEXIF_ExposureTime;
   fEXIF_FNumber:=Source.fEXIF_FNumber;
   fEXIF_ExposureProgram:=Source.fEXIF_ExposureProgram;
   fEXIF_ISOSpeedRatings[0]:=Source.EXIF_ISOSpeedRatings[0];
   fEXIF_ISOSpeedRatings[1]:=Source.EXIF_ISOSpeedRatings[1];
   fEXIF_ExifVersion:=Source.EXIF_ExifVersion;
   fEXIF_DateTimeOriginal:=Source.EXIF_DateTimeOriginal;
   fEXIF_DateTimeDigitized:=Source.EXIF_DateTimeDigitized;
   fEXIF_CompressedBitsPerPixel:=Source.EXIF_CompressedBitsPerPixel;
   fEXIF_ShutterSpeedValue:=Source.EXIF_ShutterSpeedValue;
   fEXIF_ApertureValue:=Source.EXIF_ApertureValue;
   fEXIF_BrightnessValue:=Source.EXIF_BrightnessValue;
   fEXIF_ExposureBiasValue:=Source.EXIF_ExposureBiasValue;
   fEXIF_MaxApertureValue:=Source.EXIF_MaxApertureValue;
	fEXIF_SubjectDistance:=Source.EXIF_SubjectDistance;
   fEXIF_MeteringMode:=Source.EXIF_MeteringMode;
   fEXIF_LightSource:=Source.EXIF_LightSource;
   fEXIF_Flash:=Source.EXIF_Flash;
   fEXIF_FocalLength:=Source.EXIF_FocalLength;
   fEXIF_SubsecTime:=Source.EXIF_SubsecTime;
   fEXIF_SubsecTimeOriginal:=Source.EXIF_SubsecTimeOriginal;
   fEXIF_SubsecTimeDigitized:=Source.EXIF_SubsecTimeDigitized;
   fEXIF_FlashPixVersion:=Source.EXIF_FlashPixVersion;
   fEXIF_ColorSpace:=Source.EXIF_ColorSpace;
   fEXIF_ExifImageWidth:=Source.EXIF_ExifImageWidth;
   fEXIF_ExifImageHeight:=Source.EXIF_ExifImageHeight;
   fEXIF_RelatedSoundFile:=Source.EXIF_RelatedSoundFile;
   fEXIF_FocalPlaneXResolution:=Source.EXIF_FocalPlaneXResolution;
	fEXIF_FocalPlaneYResolution:=Source.EXIF_FocalPlaneYResolution;
   fEXIF_FocalPlaneResolutionUnit:=Source.EXIF_FocalPlaneResolutionUnit;
   fEXIF_ExposureIndex:=Source.EXIF_ExposureIndex;
   fEXIF_SensingMethod:=Source.EXIF_SensingMethod;
   fEXIF_FileSource:=Source.EXIF_FileSource;
   fEXIF_SceneType:=Source.EXIF_SceneType;
   fEXIF_UserComment:=Source.EXIF_UserComment;
   fEXIF_UserCommentCode:=Source.EXIF_UserCommentCode;
   // PS
   fPS_PaperWidth:=Source.fPS_PaperWidth;
   fPS_PaperHeight:=Source.fPS_PaperHeight;
   fPS_Compression:=Source.fPS_Compression;
   fPS_Title:=Source.fPS_Title;
   // PDF
   fPDF_PaperWidth:=Source.fPDF_PaperWidth;
   fPDF_PaperHeight:=Source.fPDF_PaperHeight;
   fPDF_Compression:=Source.fPDF_Compression;
   fPDF_Title:=Source.fPDF_Title;
   fPDF_Author:=Source.fPDF_Author;
   fPDF_Subject:=Source.fPDF_Subject;
   fPDF_Keywords:=Source.fPDF_Keywords;
   fPDF_Creator:=Source.fPDF_Creator;
   fPDF_Producer:=Source.fPDF_Producer;
end;

// assign compression parameters
procedure TIOParamsVals.AssignCompressionInfo(Source:TIOParamsVals);
begin
   BitsPerSample:=Source.BitsPerSample;
   SamplesPerPixel:=Source.SamplesPerPixel;
   // TIFF
   TIFF_Compression:=Source.TIFF_Compression;
   TIFF_PhotometInterpret:=Source.TIFF_PhotometInterpret;
   TIFF_PlanarConf:=Source.TIFF_PlanarConf;
   TIFF_Orientation:=Source.TIFF_Orientation;
   TIFF_LZWDecompFunc:=Source.TIFF_LZWDecompFunc;
   TIFF_LZWCompFunc:=Source.TIFF_LZWCompFunc;
   fTIFF_EnableAdjustOrientation:=Source.TIFF_EnableAdjustOrientation;
   fTIFF_JPEGQuality:=Source.fTIFF_JPEGQuality;
   fTIFF_JPEGColorSpace:=Source.fTIFF_JPEGColorSpace;
   // GIF
   GIF_Interlaced:=Source.GIF_Interlaced;
   GIF_LZWDecompFunc:=Source.GIF_LZWDecompFunc;
   GIF_LZWCompFunc:=Source.GIF_LZWCompFunc;
   // JPEG
   JPEG_ColorSpace:=Source.JPEG_ColorSpace;
   JPEG_Quality:=Source.JPEG_Quality;
   JPEG_DCTMethod:=Source.JPEG_DCTMethod;
   JPEG_OptimalHuffman:=Source.JPEG_OptimalHuffman;
   JPEG_Smooth:=Source.JPEG_Smooth;
   JPEG_Progressive:=Source.JPEG_Progressive;
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   fJ2000_ColorSpace:=Source.J2000_ColorSpace;
   fJ2000_Rate:=Source.J2000_Rate;
   fJ2000_ScalableBy:=Source.J2000_ScalableBy;
   {$endif}
   // PCX
   PCX_Version:=Source.PCX_Version;
   PCX_Compression:=Source.PCX_Compression;
   // BMP
   BMP_Version:=Source.BMP_Version;
   BMP_Compression:=Source.BMP_Compression;
   // ICO
   // CUR
   // PNG
   PNG_Interlaced:=Source.PNG_Interlaced;
   PNG_Filter:=Source.PNG_Filter;
   PNG_Compression:=Source.PNG_Compression;
   // TGA
   TGA_Compressed:=Source.TGA_Compressed;
   TGA_GrayLevel:=Source.TGA_GrayLevel;
   // AVI
   // IPTC
   // PXM
   // EXIF
end;

procedure TIOParamsVals.SetEXIF_ISOSpeedRatings(index:integer; v:integer);
begin
	fEXIF_ISOSpeedRatings[index]:=v;
end;

function TIOParamsVals.GetEXIF_ISOSpeedRatings(index:integer):integer;
begin
	result:=fEXIF_ISOSpeedRatings[index];
end;

procedure TIOParamsVals.SetEXIF_ReferenceBlackWhite(index:integer; v:double);
begin
	fEXIF_ReferenceBlackWhite[index]:=v;
end;

function TIOParamsVals.GetEXIF_ReferenceBlackWhite(index:integer):double;
begin
	result:=fEXIF_ReferenceBlackWhite[index];
end;

procedure TIOParamsVals.SetEXIF_WhitePoint(index:integer; v:double);
begin
	fEXIF_WhitePoint[index]:=v;
end;

function TIOParamsVals.GetEXIF_WhitePoint(index:integer):double;
begin
	result:=fEXIF_WhitePoint[index];
end;

procedure TIOParamsVals.SetEXIF_PrimaryChromaticities(index:integer; v:double);
begin
	fEXIF_PrimaryChromaticities[index]:=v;
end;

function TIOParamsVals.GetEXIF_PrimaryChromaticities(index:integer):double;
begin
	result:=fEXIF_PrimaryChromaticities[index];
end;

procedure TIOParamsVals.SetEXIF_YCbCrCoefficients(index:integer; v:double);
begin
	fEXIF_YCbCrCoefficients[index]:=v;
end;

function TIOParamsVals.GetEXIF_YCbCrCoefficients(index:integer):double;
begin
	result:=fEXIF_YCbCrCoefficients[index];
end;

procedure TIOParamsVals.SaveToFile(const FileName:AnsiString);
var
	fs:TFileStream;
begin
	fs:=nil;
	try
	fs:=TFileStream.Create(FileName,fmCreate);
	SaveToStream(fs);
   finally
	   FreeAndNil(fs);
   end;
end;

procedure TIOParamsVals.LoadFromFile(const FileName:AnsiString);
var
	fs:TFileStream;
begin
	fs:=nil;
	try
	fs:=TFileStream.Create(FileName,fmOpenRead or fmShareDenyWrite);
   LoadFromStream(fs);
   finally
	   FreeAndNil(fs);
   end;
end;

procedure TIOParamsVals.SetDpi(Value:integer);
begin
	DpiX:=Value;
   DpiY:=Value;
end;

procedure TIOParamsVals.SetDpiX(Value:integer);
begin
	fDpiX:=Value;
   fEXIF_XResolution:=Value;
end;

procedure TIOParamsVals.SetDpiY(Value:integer);
begin
	fDpiY:=Value;
   fEXIF_YResolution:=Value;
end;

procedure TIOParamsVals.SetTIFF_Orientation(Value:integer);
begin
	fTIFF_Orientation:=Value;
   fEXIF_Orientation:=Value;
end;

procedure TIOParamsVals.SetEXIF_Orientation(Value:integer);
begin
	fEXIF_Orientation:=Value;
   fTIFF_Orientation:=Value;
end;

procedure TIOParamsVals.SetEXIF_XResolution(Value:double);
begin
	SetDpiX(trunc(Value));
end;

procedure TIOParamsVals.SetEXIF_YResolution(Value:double);
begin
	SetDpiY(trunc(Value));
end;

// the first integer is the version: actual 15
procedure TIOParamsVals.SaveToStream(Stream:TStream);
var
	ver:integer;
begin
	ver:=16;
   Stream.Write(ver,sizeof(integer));
   //
	SaveStringToStream(Stream,fFileName);
	Stream.Write(fFileType,sizeof(TIOFileType));
   Stream.Write(fBitsPerSample,sizeof(integer));
	Stream.Write(fSamplesPerPixel,sizeof(integer));
   Stream.Write(fWidth,sizeof(integer));
   Stream.Write(fHeight,sizeof(integer));
   Stream.Write(fDpiX,sizeof(integer));
   Stream.Write(fDpiY,sizeof(integer));
   Stream.Write(fColorMapCount,sizeof(integer));
	if fColorMapCount>0 then
   	Stream.Write(fColorMap^,fColorMapCount*sizeof(TRGB));
   // TIFF
   Stream.Write(fTIFF_Compression,sizeof(TIOTIFFCompression));
	Stream.Write(fTIFF_ImageIndex,sizeof(integer));
	Stream.Write(fTIFF_PhotometInterpret,sizeof(TIOTIFFPhotometInterpret));
   Stream.Write(fTIFF_PlanarConf,sizeof(integer));
	Stream.Write(fTIFF_XPos,sizeof(integer));
   Stream.Write(fTIFF_YPos,sizeof(integer));
   SaveStringToStream(Stream,fTIFF_DocumentName);
   SaveStringToStream(Stream,fTIFF_ImageDescription);
   SaveStringToStream(Stream,fTIFF_PageName);
   Stream.Write(fTIFF_PageNumber,sizeof(integer));
   Stream.Write(fTIFF_PageCount,sizeof(integer));
   Stream.Write(fTIFF_ImageCount,sizeof(integer));
   Stream.Write(fTIFF_Orientation,sizeof(integer));
   Stream.Write(fTIFF_JPEGQuality,sizeof(integer));
   Stream.Write(fTIFF_JPEGColorSpace,sizeof(TIOJPEGColorSpace));
   // GIF
	SaveStringToStream(Stream,fGIF_Version);
   Stream.Write(fGIF_ImageIndex,sizeof(integer));
   Stream.Write(fGIF_XPos,sizeof(integer));
   Stream.Write(fGIF_YPos,sizeof(integer));
   Stream.Write(fGIF_DelayTime,sizeof(integer));
   Stream.Write(fGIF_FlagTranspColor,sizeof(boolean));
	Stream.Write(fGIF_TranspColor,sizeof(TRGB));
   Stream.Write(fGIF_Interlaced,sizeof(boolean));
   Stream.Write(fGIF_WinWidth,sizeof(integer));
   Stream.Write(fGIF_WinHeight,sizeof(integer));
   Stream.Write(fGIF_Background,sizeof(TRGB));
   Stream.Write(fGIF_Ratio,sizeof(integer));
   Stream.Write(fGIF_ImageCount,sizeof(integer));
   SaveStringListToStream(Stream,fGIF_Comments);
   Stream.Write(fGIF_Action,sizeof(TIEGifAction));
   // JPEG
   Stream.Write(fJPEG_ColorSpace,sizeof(TIOJPEGColorSpace));
	Stream.Write(fJPEG_Quality,sizeof(integer));
   Stream.Write(fJPEG_DCTMethod,sizeof(TIOJPEGDCTMethod));
   Stream.Write(fJPEG_OptimalHuffman,sizeof(boolean));
   Stream.Write(fJPEG_Smooth,sizeof(integer));
   Stream.Write(fJPEG_Progressive,sizeof(boolean));
   Stream.Write(fJPEG_Scale,sizeof(TIOJPEGScale));
   fJPEG_MarkerList.SaveToStream(Stream);
   Stream.Write(fJPEG_OriginalWidth,sizeof(integer));
   Stream.Write(fJPEG_OriginalHeight,sizeof(integer));
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   Stream.Write(fJ2000_ColorSpace,sizeof(TIOJ2000ColorSpace));
   Stream.Write(fJ2000_Rate,sizeof(double));
   Stream.Write(fJ2000_ScalableBy,sizeof(TIOJ2000ScalableBy));
   {$endif}
   // PCX
   Stream.Write(fPCX_Version,sizeof(integer));
   Stream.Write(fPCX_Compression,sizeof(TIOPCXCompression));
   // BMP
   Stream.Write(fBMP_Version,sizeof(TIOBMPVersion));
   Stream.Write(fBMP_Compression,sizeof(TIOBMPCompression));
   // ICO
   Stream.Write(fICO_ImageIndex,sizeof(integer));
   Stream.Write(fICO_Background,sizeof(TRGB));
   Stream.Write(ICO_Sizes[0],sizeof(TIOICOSizes));
   Stream.Write(ICO_BitCount[0],sizeof(TIOICOBitCount));
   // CUR
   Stream.Write(fCUR_ImageIndex,sizeof(integer));
   Stream.Write(fCUR_XHotSpot,sizeof(integer));
   Stream.Write(fCUR_YHotSpot,sizeof(integer));
   Stream.Write(fCUR_Background,sizeof(TRGB));
   // PNG
	Stream.Write(fPNG_Interlaced,sizeof(boolean));
	Stream.Write(fPNG_Background,sizeof(TRGB));
	Stream.Write(fPNG_Filter,sizeof(TIOPNGFilter));
   Stream.Write(fPNG_Compression,sizeof(integer));
   // TGA
   Stream.Write(fTGA_XPos,sizeof(integer));
   Stream.Write(fTGA_YPos,sizeof(integer));
   Stream.Write(fTGA_Compressed,sizeof(boolean));
   SaveStringToStream(Stream,fTGA_Descriptor);
   SaveStringToStream(Stream,fTGA_Author);
   Stream.Write(fTGA_Date,sizeof(TDateTime));
   SaveStringToStream(Stream,fTGA_ImageName);
   Stream.Write(fTGA_Background,sizeof(TRGB));
   Stream.Write(fTGA_AspectRatio,sizeof(double));
   Stream.Write(fTGA_Gamma,sizeof(double));
   Stream.Write(fTGA_GrayLevel,sizeof(boolean));
   // IPTC
   fIPTC_Info.SaveToStream(Stream);
   // PXM
   SaveStringListToStream(Stream,fPXM_Comments);
   // AVI
   Stream.Write(fAVI_FrameCount,sizeof(integer));
   Stream.Write(fAVI_FrameDelayTIme,sizeof(integer));
	// PS
   Stream.Write(fPS_PaperWidth,sizeof(integer));
   Stream.Write(fPS_PaperHeight,sizeof(integer));
   Stream.Write(fPS_Compression,sizeof(TIOPSCompression));
   SaveStringToStream(Stream,fPS_Title);
	// PDF
   Stream.Write(fPDF_PaperWidth,sizeof(integer));
   Stream.Write(fPDF_PaperHeight,sizeof(integer));
   Stream.Write(fPDF_Compression,sizeof(TIOPDFCompression));
   SaveStringToStream(Stream,fPDF_Title);
   SaveStringToStream(Stream,fPDF_Author);
   SaveStringToStream(Stream,fPDF_Subject);
   SaveStringToStream(Stream,fPDF_Keywords);
   SaveStringToStream(Stream,fPDF_Creator);
   SaveStringToStream(Stream,fPDF_Producer);
	// imaging annotations
   fImagingAnnot.SaveToStream(Stream);
end;

// read params stream with version :0..16
procedure TIOParamsVals.LoadFromStream(Stream:TStream);
var
	ver:integer;
   b:byte;
   idummy:integer;
begin
   Stream.Read(ver,sizeof(integer));
   LoadStringFromStream(Stream,fFileName);
   if ver<2 then begin
      // in versions 0 and 1, TIOFileType was a byte
      Stream.Read(b,1);
      fFileType:=TIOFileType(b);
   end else
      Stream.Read(fFileType,sizeof(TIOFileType));
   Stream.Read(fBitsPerSample,sizeof(integer));
   Stream.Read(fSamplesPerPixel,sizeof(integer));
   Stream.Read(fWidth,sizeof(integer));
   Stream.Read(fHeight,sizeof(integer));
   Stream.Read(fDpiX,sizeof(integer));
   Stream.Read(fDpiY,sizeof(integer));
   if fColorMap<>nil then begin
      freemem(fColorMap);
      fColorMap:=nil;
   end;
   Stream.Read(fColorMapCount,sizeof(integer));
   if fColorMapCount>0 then begin
      getmem(fColorMap,fColorMapCount*sizeof(TRGB));
      Stream.Read(fColorMap^,fColorMapCount*sizeof(TRGB));
   end;
   // TIFF
   Stream.Read(fTIFF_Compression,sizeof(TIOTIFFCompression));
   Stream.Read(fTIFF_ImageIndex,sizeof(integer));
   Stream.Read(fTIFF_PhotometInterpret,sizeof(TIOTIFFPhotometInterpret));
   Stream.Read(fTIFF_PlanarConf,sizeof(integer));
   Stream.Read(fTIFF_XPos,sizeof(integer));
   Stream.Read(fTIFF_YPos,sizeof(integer));
   LoadStringFromStream(Stream,fTIFF_DocumentName);
   LoadStringFromStream(Stream,fTIFF_ImageDescription);
   LoadStringFromStream(Stream,fTIFF_PageName);
   Stream.Read(fTIFF_PageNumber,sizeof(integer));
   Stream.Read(fTIFF_PageCount,sizeof(integer));
   if ver>=4 then begin
   	Stream.Read(fTIFF_ImageCount,sizeof(integer));
      if ver>=6 then
         Stream.Read(fTIFF_Orientation,sizeof(integer));
   end;
   if ver>=10 then
   	Stream.Read(fTIFF_JPEGQuality,sizeof(integer));
   if ver>=16 then
   	Stream.Read(fTIFF_JPEGColorSpace,sizeof(TIOJPegColorSpace));
   // GIF
   LoadStringFromStream(Stream,fGIF_Version);
   Stream.Read(fGIF_ImageIndex,sizeof(integer));
   Stream.Read(fGIF_XPos,sizeof(integer));
   Stream.Read(fGIF_YPos,sizeof(integer));
   Stream.Read(fGIF_DelayTime,sizeof(integer));
   Stream.Read(fGIF_FlagTranspColor,sizeof(boolean));
   Stream.Read(fGIF_TranspColor,sizeof(TRGB));
   Stream.Read(fGIF_Interlaced,sizeof(boolean));
   Stream.Read(fGIF_WinWidth,sizeof(integer));
   Stream.Read(fGIF_WinHeight,sizeof(integer));
   Stream.Read(fGIF_Background,sizeof(TRGB));
   Stream.Read(fGIF_Ratio,sizeof(integer));
   if ver>=4 then
   	Stream.Read(fGIF_ImageCount,sizeof(integer));
   if ver>=9 then
      LoadStringListFromStream(Stream,fGIF_Comments);
   if ver>=12 then
   	Stream.Read(fGIF_Action,sizeof(TIEGifAction));
   // JPEG
   Stream.Read(fJPEG_ColorSpace,sizeof(TIOJPEGColorSpace));
   Stream.Read(fJPEG_Quality,sizeof(integer));
   Stream.Read(fJPEG_DCTMethod,sizeof(TIOJPEGDCTMethod));
   Stream.Read(fJPEG_OptimalHuffman,sizeof(boolean));
   Stream.Read(fJPEG_Smooth,sizeof(integer));
   Stream.Read(fJPEG_Progressive,sizeof(boolean));
   if ver>=1 then
      Stream.Read(fJPEG_Scale,sizeof(TIOJPEGScale));
   if ver>=4 then
   	fJPEG_MarkerList.LoadFromStream(Stream);
   if ver>=7 then begin
		Stream.Read(fJPEG_OriginalWidth,sizeof(integer));
      Stream.Read(fJPEG_OriginalHeight,sizeof(integer));
   end;
   // JPEG2000
   {$ifdef IEINCLUDEJPEG2000}
   if ver>=8 then begin
   	Stream.Read(fJ2000_ColorSpace,sizeof(TIOJ2000ColorSpace));
      Stream.Read(fJ2000_Rate,sizeof(double));
      Stream.Read(fJ2000_ScalableBy,sizeof(TIOJ2000ScalableBy));
   end;
   {$endif}
   // PCX
   Stream.Read(fPCX_Version,sizeof(integer));
   Stream.Read(fPCX_Compression,sizeof(TIOPCXCompression));
   // BMP
   Stream.Read(fBMP_Version,sizeof(TIOBMPVersion));
   Stream.Read(fBMP_Compression,sizeof(TIOBMPCompression));
   // ICO
   if ver=0 then begin
      Stream.Read(idummy,sizeof(integer));
      Stream.Read(idummy,sizeof(integer));
      fICO_ImageIndex:=0;
   end else begin
      Stream.Read(fICO_ImageIndex,sizeof(integer));
      if ver>=3 then
         Stream.Read(fICO_Background,sizeof(TRGB));
      if ver>=11 then begin
      	Stream.Read(ICO_Sizes[0],sizeof(TIOICOSizes));
         Stream.Read(ICO_BitCount[0],sizeof(TIOICOBitCount));
      end;
   end;
   // CUR
   if ver=0 then begin
      Stream.Read(idummy,sizeof(integer));
      Stream.Read(idummy,sizeof(integer));
      fCUR_ImageIndex:=0;
      fCUR_XHotSpot:=0;
      fCUR_YHotSpot:=0;
   end else begin
      Stream.Read(fCUR_ImageIndex,sizeof(integer));
      Stream.Read(fCUR_XHotSpot,sizeof(integer));
      Stream.Read(fCUR_YHotSpot,sizeof(integer));
      if ver>=3 then
         Stream.Read(fCUR_Background,sizeof(TRGB));
   end;
   // PNG
   Stream.Read(fPNG_Interlaced,sizeof(boolean));
   Stream.Read(fPNG_Background,sizeof(TRGB));
   Stream.Read(fPNG_Filter,sizeof(TIOPNGFilter));
   Stream.Read(fPNG_Compression,sizeof(integer));
   // TGA
   if ver>=3 then begin
      Stream.Read(fTGA_XPos,sizeof(integer));
      Stream.Read(fTGA_YPos,sizeof(integer));
      Stream.Read(fTGA_Compressed,sizeof(boolean));
      LoadStringFromStream(Stream,fTGA_Descriptor);
      LoadStringFromStream(Stream,fTGA_Author);
      Stream.Read(fTGA_Date,sizeof(TDateTime));
      LoadStringFromStream(Stream,fTGA_ImageName);
      Stream.Read(fTGA_Background,sizeof(TRGB));
      Stream.Read(fTGA_AspectRatio,sizeof(double));
      Stream.Read(fTGA_Gamma,sizeof(double));
      Stream.Read(fTGA_GrayLevel,sizeof(boolean));
   end;
   // IPTC
   if ver>=4 then
   	fIPTC_Info.LoadFromStream(Stream);
   // PXM
   if ver>=5 then
      LoadStringListFromStream(Stream,fPXM_Comments);
   // AVI
   if ver>=6 then begin
      Stream.Read(fAVI_FrameCount,sizeof(integer));
      Stream.Read(fAVI_FrameDelayTime,sizeof(integer));
   end;
   // PS
   if ver>=14 then begin
   	Stream.Read(fPS_PaperWidth,sizeof(integer));
      Stream.Read(fPS_PaperHeight,sizeof(integer));
      Stream.Read(fPS_Compression,sizeof(TIOPSCompression));
      LoadStringFromStream(Stream,fPS_Title);
   end;
   // PDF
   if ver>=14 then begin
   	Stream.Read(fPDF_PaperWidth,sizeof(integer));
      Stream.Read(fPDF_PaperHeight,sizeof(integer));
      Stream.Read(fPDF_Compression,sizeof(TIOPDFCompression));
      if ver>=15 then begin
         LoadStringFromStream(Stream,fPDF_Title);
         LoadStringFromStream(Stream,fPDF_Author);
         LoadStringFromStream(Stream,fPDF_Subject);
         LoadStringFromStream(Stream,fPDF_Keywords);
         LoadStringFromStream(Stream,fPDF_Creator);
         LoadStringFromStream(Stream,fPDF_Producer);
      end;
   end;
   // Imagning annotations
   if ver>=13 then
   	fImagingAnnot.LoadFromStream(Stream);
end;

// returns the type of last loaded file
function TIOParamsVals.GetFileTypeStr:AnsiString;
var
	fi:PIEFileFormatInfo;
begin
	// main
   fi:=IEFileFormatGetInfo(fFileType);
   if assigned(fi) then
		with fi^ do
		   result:=FullName+' ('+uppercase(IEFileFormatGetExt(fFileType,0))+')'
   else
   	result:='';
   // sub formats
   case fFileType of
		ioTIFF:
      	case TIFF_Compression of
            ioTIFF_UNCOMPRESSED: result:=result+' Uncompressed';
            ioTIFF_CCITT1D: result:=result+' Huffman';
            ioTIFF_G3FAX1D: result:=result+' Group 3 Fax';
            ioTIFF_G3FAX2D: result:=result+' Group 3 Fax 2D';
            ioTIFF_G4FAX: result:=result+' Group 4 Fax';
            ioTIFF_LZW: result:=result+' LZW';
            ioTIFF_OLDJPEG: result:=result+' Jpeg v.5';
            ioTIFF_JPEG: result:=result+' Jpeg';
            ioTIFF_PACKBITS: result:=result+' PackBits RLE';
         end;
      ioJPEG:
      	case JPEG_ColorSpace of
      		ioJPEG_GRAYLEV: result:=result+' Gray level';
            ioJPEG_YCbCr: result:=result+' YCbCr';
            ioJPEG_CMYK: result:=result+' CMYK';
            ioJPEG_YCbCrK: result:=result+' YCbCrK';
         end;
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2,
      ioJ2k:
      	case fJ2000_ColorSpace of
  				ioJ2000_GRAYLEV: result:=result+' Gray level';
	         ioJ2000_RGB: result:=result+' RGB';
	         ioJ2000_YCbCr: result:=result+' YCbCr';
         end;
      {$endif}
		ioPCX:
      	if PCX_Compression=ioPCX_UNCOMPRESSED then
         	result:=result+' Uncompressed';
		ioBMP:
      	case BMP_Version of
            ioBMP_BM: result:=result+' ver.1';
            ioBMP_BM3: result:=result+' ver.3';
            ioBMP_BMOS2V1: result:=result+' OS/2 v.1';
            ioBMP_BMOS2V2: result:=result+' OS/2 v.2';
         end;
		ioGIF:
      	if GIF_Interlaced then
         	result:=result+' Interlaced';
      {$ifdef IEINCLUDEPNG}
      ioPNG:
			if PNG_Interlaced then
         	result:=result+' Interlaced';
      {$endif}
      ioTGA:
      	if TGA_Compressed then
         	result:=result+' Compressed'
         else
         	result:=result+' Uncompressed';
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// at the beginning could be a TStreamJpegHeader structure
procedure TImageEnIO.LoadFromStreamJpeg(Stream:TStream);
var
	sh:TStreamJpegHeader;
   lp:integer;
   Progress:TProgressRec;
   mi:integer;
   dd:double;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamJpeg,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   lp:=Stream.Position;
   Stream.Read(sh,sizeof(sh));	// carica header TStreamJpegHeader
   if sh.ID<>'JFIF' then
      // non ha lo stream header, torna all'inizio
      Stream.Position:=lp;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   ReadJpegStream(Stream,nil,fIEBitmap,fParams,Progress,False,false);
   CheckDPI;
  	with fParams.JPEG_MarkerList do begin
   	// IPTC INFO
	   mi:=IndexOf(JPEG_APP13);
	   if mi>=0 then
	   	fParams.IPTC_Info.LoadFromStandardBuffer(MarkerData[mi],MarkerLength[mi]);
      // EXIF INFO
      mi:=IndexOf(JPEG_APP1);
      if mi>=0 then
      	if LoadEXIFFromStandardBuffer(MarkerData[mi],MarkerLength[mi],fParams) then begin
         	// exif found
				if (fParams.DpiX=1) and (fParams.DpiY=1) then begin
            	// use dpi of the Exif
				   if fParams.EXIF_ResolutionUnit=3 then dd:=2.54 else dd:=1;
				  	fParams.DpiX:=trunc(fParams.EXIF_XResolution*dd);
				   fParams.DpiY:=trunc(fParams.EXIF_YResolution*dd);
            end;
         end;
   end;
   if sh.ID='JFIF' then
      Stream.Position:=lp+sizeof(sh)+sh.dim;
   if fAutoAdjustDPI then
      AdjustDPI;
   if assigned(fImageEnView) then begin
      fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   end;
   fParams.fFileName:='';
   fParams.fFileType:=ioJPEG;
   Update;
   finally
   	DoFinishWork;
   end;
end;

// All'inizio salva l'header TStreamJpegHeader (se fStreamHeaders и true)
procedure TImageEnIO.SaveToStreamJpeg(Stream:TStream);
var
   sh:TStreamJpegHeader;
   lp,lp2:integer;
   Progress:TProgressRec;
   buf:pointer;
   lbuf,mi:integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamJpeg,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   lp:=0;
   if fStreamHeaders then begin
		lp:=Stream.position;	// save initial position
	   Stream.write(sh,sizeof(sh));	// leaves spaces for the header
   end;
   // update APP13 marker with IPTC_Info
   if fParams.IPTC_Info.UserChanged then begin
      fParams.IPTC_Info.SaveToStandardBuffer(buf,lbuf,true);
      mi:=fParams.JPEG_MarkerList.IndexOf(JPEG_APP13);
      if buf<>nil then begin
      	// replace or add IPTC marker
         if mi>=0 then
            fParams.JPEG_MarkerList.SetMarker(mi,JPEG_APP13,buf,lbuf)
         else
            fParams.JPEG_MarkerList.AddMarker(JPEG_APP13,buf,lbuf);
         freemem(buf);
      end else if mi>=0 then
      	// remove IPTC marker
      	fParams.JPEG_MarkerList.DeleteMarker( mi );
   end;
   // Exif info
   if fParams.EXIF_HasExifData then begin
   	SaveEXIFToStandardBuffer(fParams,buf,lbuf);
      mi:=fParams.JPEG_MarkerList.IndexOf(JPEG_APP1);
      if mi>=0 then
         fParams.JPEG_MarkerList.SetMarker(mi,JPEG_APP1,buf,lbuf)
      else
         fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
   end;
   // save jpeg
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   WriteJpegStream(Stream,fIEBitmap,fParams,Progress);
   if fStreamHeaders then begin
		lp2:=Stream.position;	// saves final position
		Stream.position:=lp;		// return to initial position
	   sh.ID:='JFIF';
	   sh.dim:=lp2-lp-sizeof(sh);
	   Stream.Write(sh,sizeof(sh));	// Saves header TStreamJpegHeader
		Stream.position:=lp2;	// return to final position
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SetPreviewFont(f:TFont);
begin
	fPreviewFont.assign(f);
end;

procedure TImageEnIO.LoadFromFileBMP(const nf:AnsiString);
var
   fs:TFileStream;
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileBMP,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=nil;
	try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   fIEBitmap.RemoveAlphaChannel;
	BMPReadStream(fs,fIEBitmap,fs.size,fParams,Progress,false,false);
   CheckDPI;
   if fAutoAdjustDPI then
      AdjustDPI;
   finally
   	FreeAndNil(fs);
   end;
   fParams.fFileName:=nf;
   fParams.fFileType:=ioBMP;
   if assigned(fImageEnView) then
   	fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   update;
   finally
   	DoFinishWork;
   end;
end;

// Copy only Params
procedure TImageEnIO.AssignParams(Source: TObject);
begin
	if Source is TImageEnIO then
   	fParams.assign((Source as TImageEnIO).Params)
   else if Source is TIOParamsVals then
   	fParams.assign(Source as TIOParamsVals);
end;

// recognizes TIFF, GIF, JPEG, PCX, BMP, ICO, CUR, PNG, WMF, EMF, TGA, PMX, JP2, J2K, subformats and user formats
function IsKnownFormat(const FileName:AnsiString):boolean;
var
   ex:AnsiString;
   fpi:PIEFileFormatInfo;
begin
   ex:=lowercase(ExtractFileExt(FileName));
   fpi:=IEFileFormatGetInfo2(copy(ex,2,length(ex)-1));
   result:=assigned(fpi) and (@fpi^.ReadFunction<>nil);
end;

// recognize JPG, GIF, PCX, BMP, TIF, PNG, ICO, CUR, TGA, PXM, JP2, JPC, J2C, J2K
// supports registered file formats
function FindFileFormat(const nf:AnsiString; VerifyExtension:boolean):TIOFileType;
var
	fs:TFileStream;
   ex:AnsiString;
   fpi:PIEFileFormatInfo;
begin
	result:=ioUnknown;
   // verify stream
   try
	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   try
	result:=FindStreamFormat(fs);
   finally
   	FreeAndNil(fs);
   end;
   except
   end;
   if VerifyExtension and (result<>ioUnknown) then begin
      // verify extension
      ex:=lowercase(ExtractFileExt(nf));
      fpi:=IEFileFormatGetInfo2(copy(ex,2,length(ex)-1));
      if assigned(fpi) then begin
      	if (result<>ioICO) and (result<>ioCUR) then begin
		      if result<>fpi^.FileType then
		         result:=ioUnknown;
         end else
         	result:=fpi^.FileType;
      end else
      	result:=ioUnknown;
   end;
end;

function AVITryStream(Stream:TStream):boolean;
var
	l:integer;
   s1,s2:array [0..3] of char;
begin
 if (Stream.Size < 12) then
  Result := false
 else
 begin
  l:=Stream.Position;
  try
    Stream.Read(s1[0],4);
    Stream.Seek(4,soFromCurrent);
    Stream.Read(s2[0],4);
    result := (s1='RIFF') and (s2='AVI ');
  finally
    Stream.Position:=l;
  end;//try..finally
 end;//Stream.Size < 12
end;

// recognize JPG, GIF, PCX, BMP, TIF, PNG, ICO, CUR, TGA, PXM, J2P, JPC, J2C, J2K, AVI
// supports registered file formats
function FindStreamFormat(fs:TStream):TIOFileType;
(*$ifdef IEDELPHI*)
var
	Size:integer;
   HeaderJpegStream:TStreamJpegHeader;
   HeaderGif:TGifHeader;
   HeaderPcx:PCXSHead;
   HeaderPcx2:TPcxHeader;
   HeaderBmp:TBITMAPFILEHEADER;
   HeaderTIFF:TIFFSHead;
   HeaderTIFF2:TTIFFHeader;
   id:array [0..3] of char;
   lp:integer;
   q:integer;
begin
	result:=ioUnknown;
   try
   Size := fs.Size;
   lp:=fs.Position;
   // try user registered file formats
	for q:=0 to iegFileFormats.Count-1 do
   	with PIEFileFormatInfo(iegFileFormats[q])^ do
      	if assigned(TryFunction) then begin
	         fs.Position:=lp;
				if TryFunction(fs) then begin
					result:=FileType;
               break;
            end;
         end;
   fs.Position:=lp;
   if result<>ioUnknown then
   	exit;
   // try jpeg (with extra header)
   if Size > sizeof(TStreamJpegHeader) then begin
      fs.Read(HeaderJpegStream,sizeof(HeaderJpegStream));
      fs.Position:=lp;
      if HeaderJpegStream.ID='JFIF' then begin
         result:=ioJPEG;
         exit;
      end;
   end;
   // try Gif (no extra header)
   if Size > sizeof(TGifHeader) then begin
      fs.Read(HeaderGif,sizeof(HeaderGif));
      fs.Position:=lp;
      if (headergif.id[0]='G') and (headergif.id[1]='I') and (headergif.id[2]='F') then begin
         result:=ioGIF;
         exit;
      end;
   end;
   // try PCX (with extra header - ver.2)
   if Size > sizeof(PCXSHead) then begin
      fs.Read(HeaderPCX,sizeof(HeaderPCX));
      fs.Position:=lp;
      if HeaderPCX.id='PCX2' then begin
         result:=ioPCX;
         exit;
      end;
   end;
   // try PCX (with extra header - ver.1)
   if Size > 4 then begin
      fs.Read(id,4);
      fs.Position:=lp;
      if id='PCX' then begin
         result:=ioPCX;
         exit;
      end;
   end;
   // try BMP (no extra header)
   if Size > sizeof(HeaderBmp) then begin
      fs.Read(HeaderBmp,sizeof(HeaderBmp));
      fs.Position:=lp;
      if HeaderBmp.bfType=19778 then begin
         result:=ioBMP;
         exit;
      end;
   end;
   // try PCX (no extra header)
   if Size > sizeof(TPcxHeader) then begin
      fs.Read(HeaderPcx2,sizeof(HeaderPcx2));
      fs.Position:=lp;
      if (HeaderPcx2.Manufacturer=$0A) and (HeaderPcx2.Version<=5) then begin
      	result:=ioPCX;
         exit;
      end;
   end;
   // try TIFF (with extra header)
   if Size > sizeof(TIFFSHead) then begin
      fs.Read(HeaderTIFF,sizeof(HeaderTIFF));
      fs.Position:=lp;
		if HeaderTIFF.ID='TIFF' then begin
      	result:=ioTIFF;
         exit;
      end;
   end;
   // try TIFF (no extra header)
	if Size > sizeof(TTIFFHeader) then begin
   	fs.Read(HeaderTIFF2,sizeof(HeaderTIFF2));
		fs.Position:=lp;
      if ((HeaderTIFF2.Id=$4949) or (HeaderTIFF2.id=$4D4D)) then begin
			result:=ioTIFF;
         exit;
      end;
   end;
   // try PNG
   {$ifdef IEINCLUDEPNG}
   if Size > 8 then begin
   	if IsPNGStream(fs) then begin
      	result:=ioPNG;
         exit;
      end;
   end;
   {$endif}
   // try ICO
   if IcoTryStream(fs) then begin
      result:=ioICO;
      exit;
   end;
   // try CUR
   if CurTryStream(fs) then begin
   	result:=ioCUR;
      exit;
   end;
   // try TGA
   if TryTGA(fs) then begin
   	result:=ioTGA;
      exit;
   end;
   // try PXM
	if tryPXM(fs) then begin
   	result:=ioPXM;
      exit;
   end;
   // try jpeg (without extra header)
   if JpegTryStream(fs)>=0 then begin
   	result:=ioJPEG;
      exit;
   end;
   {$ifdef IEINCLUDEJPEG2000}
   // try jp2
   if J2KTryStreamJP2(fs) then begin
      result:=ioJP2;
      exit;
   end;
   // try j2k, jpc, j2c
   if J2KTryStreamJ2K(fs) then begin
      result:=ioJ2K;
      exit;
   end;
   {$endif}
   // try AVI
   if AVITryStream(fs) then begin
   	result:=ioAVI;
      exit;
   end;
   except
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
	result:=ioUnknown;
end;
(*$endif*)

// reset fBitmap (called from RegisterBitmapChangeEvent)
procedure TImageEnIO.OnBitmapChange(Sender:TObject; destroying:boolean);
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

/////////////////////////////////////////////////////////////////////////////////////
{$ifdef IEINCLUDEPNG}
procedure TImageEnIO.LoadFromFilePNG(const nf:AnsiString);
var
 fs              : TFileStream;
 Progress        : TProgressRec;
 tmpAlphaChannel : TIEMask;
begin
 if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
 begin
  TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFilePNG,nf);
  exit;
 end;
 try
	 fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
  Progress.Aborting:=@fAborting;
  if not MakeConsistentBitmap([]) then
  	exit;
	 fParams.ResetInfo;
  fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
  fAborting:=false;
  try
  	Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fParams.PNG_Background:=tcolor2trgb(Background);
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
  	ReadPNGStream(fs,fIEBitmap,fParams,Progress,false,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then
   begin
    fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
    FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
    AdjustDPI;
   fParams.fFileName:=nf;
   fParams.fFileType:=ioPNG;
		 if assigned(fImageEnView) then
    fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   BackGround:=TRGB2TCOLOR(fParams.PNG_Background);
   update;
  finally
  	FreeAndNil(fs);
  end;
 finally
 	DoFinishWork;
 end;
end;
{$endif}

{$ifdef IEINCLUDEPNG}
procedure TImageEnIO.LoadFromStreamPNG(Stream:TStream);
var
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamPNG,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
 	ReadPNGStream(Stream,fIEBitmap,fParams,Progress,false,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioPNG;
   if assigned(fImageEnView) then
      fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   BackGround:=TRGB2TCOLOR(fParams.PNG_Background);
   update;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEPNG}
procedure TImageEnIO.SaveToFilePNG(const nf:AnsiString);
var
	fs:TFileStream;
   Progress:TProgressRec;
   iemask:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFilePNG,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   try
		if fIEBitmap.HasAlphaChannel then begin
      	iemask:=TIEMask.Create;
         fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
			WritePNGStream(fs,fIEBitmap,fParams,Progress,iemask);
         FreeAndNil(iemask);
      end else
	   	WritePNGStream(fs,fIEBitmap,fParams,Progress,nil);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEPNG}
procedure TImageEnIO.SaveToStreamPNG(Stream:TStream);
var
   Progress:TProgressRec;
   iemask:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamPNG,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   if fIEBitmap.HasAlphaChannel then begin
      iemask:=TIEMask.Create;
      fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
      WritePNGStream(Stream,fIEBitmap,fParams,Progress,iemask);
      FreeAndNil(iemask);
   end else
		WritePNGStream(Stream,fIEBitmap,fParams,Progress,nil);
   finally
   	DoFinishWork;
   end;
end;
{$endif}

procedure TImageEnIO.SetIOPreviewParams(v:TIOPreviewsParams);
begin
	fPreviewsParams:=v;
end;

function TImageEnIO.GetIOPreviewParams:TIOPreviewsParams;
begin
	result:=fPreviewsParams;
end;

procedure TImageEnIO.LoadFromFileICO(const nf:AnsiString);
(*$ifdef IEDELPHI*)
var
   fs:TFileStream;
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileICO,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=nil;
	try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
	ICOReadStream(fs,fIEBitmap,fParams,false,Progress,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   finally
   	FreeAndNil(fs);
   end;
   fParams.fFileName:=nf;
   fParams.fFileType:=ioICO;
   if assigned(fImageEnView) then
   	fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   update;
   finally
   	DoFinishWork;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

procedure TImageEnIO.LoadFromStreamICO(Stream:TStream);
(*$ifdef IEDELPHI*)
var
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamICO,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
   ICOReadStream(Stream,fIEBitmap,fParams,false,Progress,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioICO;
   update;
   finally
   	DoFinishWork;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

procedure TImageEnIO.LoadFromStreamCUR(Stream:TStream);
(*$ifdef IEDELPHI*)
var
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamCUR,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
   CURReadStream(Stream,fIEBitmap,fParams,false,Progress,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioCUR;
   update;
   finally
   	DoFinishWork;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

procedure TImageEnIO.LoadFromFileCUR(const nf:AnsiString);
(*$ifdef IEDELPHI*)
var
   fs:TFileStream;
   Progress:TProgressRec;
   tmpAlphaChannel:TIEMask;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileCUR,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=nil;
	try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   fIEBitmap.RemoveAlphaChannel;
   tmpAlphaChannel:=nil;
	CURReadStream(fs,fIEBitmap,fParams,false,Progress,tmpAlphaChannel,false);
   CheckDPI;
   if assigned(tmpAlphaChannel) then begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
   end;
   if fAutoAdjustDPI then
      AdjustDPI;
   finally
   	FreeAndNil(fs);
   end;
   fParams.fFileName:=nf;
   fParams.fFileType:=ioCUR;
   if assigned(fImageEnView) then
   	fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   update;
   finally
   	DoFinishWork;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

// If Width or Height is -1 then it is auto-calculated maintain aspect ratio
// Import... because this is a vectorial image
// SHOULD NOT BE IN THREADS BECAUSE USE TCANVAS AND TMETAFILE!!
{$ifdef IEDELPHI}
procedure TImageEnIO.ImportMetafile(const aStream: TStream; Width,Height:integer; WithAlpha:boolean);
const
	MAXDIMS=16000;
var
 meta:TMetafile;
 dib:TIEDibBitmap;
 dibcanvas:TCanvas;
 x,y:integer;
 px:pbyte;
 p_rgb:PRGB;
begin
 (*
 if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
 begin
  TIEIOThread.CreateImportMetaFile(self,fAsyncThreads,ImportMetaFile,nf,Width,Height,WithAlpha);
  exit;
 end;
 { TODO -oАнтон Жучков -crepair : Восстановить функционал, если понадобится асинхронная загрузка метафайлов }
 *)
 try
	 fAborting:=false;
	 if (Width=0) or (Height=0) then
  	exit;
  if not MakeConsistentBitmap([]) then
  	exit;
	 fParams.ResetInfo;
  meta := tmetafile.create;
  try
   meta.LoadFromStream(aStream);
   if (Width>=0) or (Height>=0) then
   begin
   	if (Width>=0) and (Height>=0) then
    begin
			  meta.Width:=Width;
     meta.Height:=Height;
    end
    else
    begin
     if Width<0 then
     begin
      meta.Width:=(meta.Width*Height) div meta.Height;
      meta.Height:=Height;
     end
     else
     if Height<0 then
     begin
      meta.Height:=(meta.Height*Width) div meta.Width;
      meta.Width:=Width;
     end;
    end;
   end;
   if (meta.width=0) or (meta.height=0) then
   begin
   	fAborting:=true;
   	exit;	// finally will be executed (meta.free)
   end;
   if (meta.width>MAXDIMS) or (meta.height>MAXDIMS) then
   begin
		  if meta.Height>meta.Width then
    begin
     meta.Width:=(meta.Width*MAXDIMS) div meta.Height;
     meta.Height:=MAXDIMS;
    end
    else
    begin
     meta.Height:=(meta.Height*MAXDIMS) div meta.Width;
     meta.Width:=MAXDIMS;
    end;
   end;
   dib:=TIEDibBitmap.Create;
   dibcanvas:=TCanvas.Create;
   dib.AllocateBits(meta.Width,meta.Height,24);
   dibcanvas.Handle:=dib.HDC;
   fParams.fFileName := '';
   if meta.Enhanced then
	   fParams.fFileType:=ioEMF
   else
   	fParams.fFileType:=ioWMF;
   fParams.BitsPerSample:=8;
   fParams.SamplesPerPixel:=3;
   fParams.fWidth:=dib.Width;
   fParams.fHeight:=dib.Height;
   fParams.DpiX:=gDefaultDPIX;
   fParams.DpiY:=gDefaultDPIY;
   if fParams.ColorMap<>nil then
   begin
    freemem(fParams.ColorMap);
    fParams.fColorMap:=nil;
    fParams.fColorMapCount:=0;
   end;
   if assigned(fImageEnView) then
    fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
   dibCanvas.Brush.Color:= GetReBackground;
   dibcanvas.Brush.Style := bsSolid;
   dibCanvas.fillrect(rect(0,0,dib.width,dib.height));
   dibCanvas.Draw(0,0,meta);
   fIEBitmap.CopyFromTDibBitmap(dib);
   FreeAndNil(dibcanvas);
   FreeAndNil(dib);
	// alpha channel
   fIEBitmap.RemoveAlphaChannel;
	  if WithAlpha then
   begin
    dib:=TIEDibBitmap.Create;
    dibcanvas:=TCanvas.Create;
    dib.AllocateBits(meta.Width,meta.Height,24);
    dibcanvas.Handle:=dib.HDC;
    dibCanvas.Brush.Color:= $00010203;	// transparent color (we hope it isn't in the image)
    dibcanvas.Brush.Style := bsSolid;
    dibCanvas.fillrect(rect(0,0,dib.width,dib.height));
    dibcanvas.Draw(0,0,meta);
    for y:=0 to fIEBitmap.AlphaChannel.Height-1 do
    begin
     px:=fIEBitmap.AlphaChannel.Scanline[y];
     p_rgb:=dib.Scanline[y];
     for x:=0 to fIEBitmap.AlphaChannel.Width-1 do
     begin
      with p_rgb^ do
       if (b=$01) and (g=$02) and (r=$03) then
        px^:=0
       else
        px^:=255;
      inc(p_rgb);
      inc(px);
     end;
    end;
    fIEBitmap.AlphaChannel.SyncFull;
    FreeAndNil(dibcanvas);
    FreeAndNil(dib);
   end;
   //
   finally
    FreeAndNil(meta);
   end;
   update;
  finally
  	DoFinishWork;
  end;
end;
{$endif}

// Fills Params reading "nf", but doesn't load the image
// format specifies the file format
procedure TImageEnIO.ParamsFromFileFormat(const nf:AnsiString; format:TIOFileType);
{$ifdef IEDELPHI}
var
	idummy:integer;
   fpi:PIEFileFormatInfo;
	fs:TFileStream;
	nullpr:TProgressRec;
   mi:integer;
   dd:double;
   tempAlphaChannel:TIEMask;
begin
	fs:=nil;
	try
   fParams.fFileType:=format;
	fParams.ResetInfo;
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   with nullpr do begin
	   Aborting:=@fAborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   tempAlphaChannel:=nil;
  	fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
	case fParams.fFileType of
		ioTIFF: TIFFReadStream(fIEBitmap,fs,idummy,fParams,nullpr,True,tempAlphaChannel,true,true,false);
      ioGIF:  ReadGifStream(fs,fIEBitmap,idummy,fParams,nullpr,True,tempAlphaChannel,true);
      ioJPEG:  begin
				   	ReadJpegStream(fs,nil,fIEBitmap,fParams,nullpr,True,false);
                  with fParams.JPEG_MarkerList do begin
                  	// IPTC INFO
                     mi:=IndexOf(JPEG_APP13);
                     if mi>=0 then
                        fParams.IPTC_Info.LoadFromStandardBuffer(MarkerData[mi],MarkerLength[mi]);
                     // EXIF INFO
                     mi:=IndexOf(JPEG_APP1);
                     if mi>=0 then
                        if LoadEXIFFromStandardBuffer(MarkerData[mi],MarkerLength[mi],fParams) then begin
                           // exif found
                           if (fParams.DpiX=1) and (fParams.DpiY=1) then begin
                              // use dpi of the Exif
                              if fParams.EXIF_ResolutionUnit=3 then dd:=2.54 else dd:=1;
                              fParams.DpiX:=trunc(fParams.EXIF_XResolution*dd);
                              fParams.DpiY:=trunc(fParams.EXIF_YResolution*dd);
                           end;
                        end;
                  end;
      			end;
      ioICO:  ICOReadStream(fs,fIEBitmap,fParams,True,nullpr,tempAlphaChannel,true);
      ioCUR:  CURReadStream(fs,fIEBitmap,fParams,True,nullpr,tempAlphaChannel,true);
      ioPCX:  ReadPcxStream(fs,fIEBitmap,fParams,fs.size,nullpr,True);
      ioBMP:  BMPReadStream(fs,fIEBitmap,fs.size,fParams,nullpr,True,false);
      {$ifdef IEINCLUDEPNG}
      ioPNG:  ReadPNGStream(fs,fIEBitmap,fParams,nullpr,True,tempAlphaChannel,true);
      {$endif}
      ioTGA:  ReadTGAStream(fs,fIEBitmap,fParams,nullpr,True,tempAlphaChannel,true);
      ioPXM:  PXMReadStream(fs,fIEBitmap,fParams,nullpr,True);
      ioWBMP: WBMPReadStream(fs,fIEBitmap,fParams,nullpr,True);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2:  J2KReadStream(fs,fIEBitmap,fParams,nullpr,True);
      ioJ2K:  J2KReadStream(fs,fIEBitmap,fParams,nullpr,True);
      {$endif}
   	else begin
			fpi:=IEFileFormatGetInfo(fParams.fFileType);
         if assigned(fpi) then
            with fpi^ do
               if assigned(ReadFunction) then
                  ReadFunction(fs,fIEBitmap,fParams,nullpr,true);
      end;
   end;
   except
		fParams.fFileType:=ioUnknown;
   end;
   if fAborting then fParams.fFileType:=ioUnknown;
   fParams.fFileName:=nf;
   FreeAndNil(fs);
   DoFinishWork;
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}

// Fills Params reading the specified file, but the contained image
procedure TImageEnIO.ParamsFromFile(const nf:AnsiString);
begin
	try
   ParamsFromFileFormat(nf,FindFileFormat(nf,true));
   except
		fParams.fFileType:=ioUnknown;
   end;
end;

// Fills Params reading Stream, but doesn't load the image
// format specifies the file format
// The Stream position changes
procedure TImageEnIO.ParamsFromStreamFormat(Stream:TStream; format:TIOFileType);
{$ifdef IEDELPHI}
var
	idummy:integer;
   fpi:PIEFileFormatInfo;
 	nullpr:TProgressRec;
   mi:integer;
   dd:double;
   tempAlphaChannel:TIEMask;
begin
	try
   fParams.fFileType:=format;
	fParams.ResetInfo;
	fAborting:=false;
   with nullpr do begin
	   Aborting:=@fAborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   tempAlphaChannel:=nil;
	case fParams.fFileType of
		ioTIFF: TIFFReadStream(fIEBitmap,Stream,idummy,fParams,nullpr,True,tempAlphaChannel,true,true,false);
      ioGIF:  ReadGifStream(Stream,fIEBitmap,idummy,fParams,nullpr,True,tempAlphaChannel,true);
      ioJPEG:
      		begin
		      	ReadJpegStream(Stream,nil,fIEBitmap,fParams,nullpr,True,false);
               with fParams.JPEG_MarkerList do begin
               	// IPTC INFO
                  mi:=IndexOf(JPEG_APP13);
                  if mi>=0 then
                     fParams.IPTC_Info.LoadFromStandardBuffer(MarkerData[mi],MarkerLength[mi]);
                  // EXIF INFO
                  mi:=IndexOf(JPEG_APP1);
                  if mi>=0 then
                     if LoadEXIFFromStandardBuffer(MarkerData[mi],MarkerLength[mi],fParams) then begin
                        // exif found
                        if (fParams.DpiX=1) and (fParams.DpiY=1) then begin
                           // use dpi of the Exif
                           if fParams.EXIF_ResolutionUnit=3 then dd:=2.54 else dd:=1;
                           fParams.DpiX:=trunc(fParams.EXIF_XResolution*dd);
                           fParams.DpiY:=trunc(fParams.EXIF_YResolution*dd);
                        end;
                     end;
               end;
            end;
      ioICO:  ICOReadStream(Stream,fIEBitmap,fParams,True,nullpr,tempAlphaChannel,true);
      ioCUR:  CURReadStream(Stream,fIEBitmap,fParams,True,nullpr,tempAlphaChannel,true);
      ioPCX:  ReadPcxStream(Stream,fIEBitmap,fParams,Stream.size,nullpr,True);
      ioBMP:  BMPReadStream(Stream,fIEBitmap,Stream.size,fParams,nullpr,True,false);
      {$ifdef IEINCLUDEPNG}
      ioPNG:  ReadPNGStream(Stream,fIEBitmap,fParams,nullpr,True,tempAlphaChannel,true);
      {$endif}
      ioTGA:  ReadTGAStream(Stream,fIEBitmap,fParams,nullpr,True,tempAlphaChannel,true);
      ioPXM:  PXMReadStream(Stream,fIEBitmap,fParams,nullpr,True);
      ioWBMP: WBMPReadStream(Stream,fIEBitmap,fParams,nullpr,True);
      {$ifdef IEINCLUDEJPEG2000}
      ioJP2:  J2KReadStream(Stream,fIEBitmap,fParams,nullpr,True);
      ioJ2K:  J2KReadStream(Stream,fIEBitmap,fParams,nullpr,True);
      {$endif}
      else begin
			fpi:=IEFileFormatGetInfo(fParams.fFileType);
         if assigned(fpi) then
            with fpi^ do
               if assigned(ReadFunction) then
                  ReadFunction(Stream,fIEBitmap,fParams,nullpr,true);
		end;
   end;
   except
		fParams.fFileType:=ioUnknown;
   end;
   if fAborting then fParams.fFileType:=ioUnknown;
   DoFinishWork;
 CheckDPI;
end;
{$endif}
{$ifdef IEKYLIX}
begin
end;
{$endif}


// Riempie Params leggendo Stream, ma non l'immagine in esso contenuta.
// L'informazione sul tipo di file viene presa dalla funzione FindStreamFormat.
// La posizione dello stream и ripristinata all'uscita.
procedure TImageEnIO.ParamsFromStream(Stream:TStream);
begin
	try
  ParamsFromStreamFormat(Stream,FindStreamFormat(Stream));
 except
	 fParams.fFileType:=ioUnknown;
 end;
end;

{$ifdef IEINCLUDETWAIN}

constructor TIETWainParams.Create(Owner:TComponent);
begin
	inherited Create;
   fOwner:=Owner;
   fSourceListDataValid:=false;
   fSourceListData:=TList.Create;
   fCapabilitiesValid:=false;
   TWainShared.hDSMLib:=0;
   TWainShared.DSM_Entry:=nil;
   TWainShared.hproxy:=0;
   //
   with fCapabilities do begin
      fXResolution:=TIEDoubleList.Create;
      fYResolution:=TIEDoubleList.Create;
      fXScaling:=TIEDoubleList.Create;
      fYScaling:=TIEDoubleList.Create;
      fPixelType:=TIEIntegerList.Create;
      fOrientation:=TIEIntegerList.Create;
      fContrast:=TIEDoubleList.Create;
      fBrightness:=TIEDoubleList.Create;
      fStandardSize:=TIEIntegerList.Create;
   end;
   //
   SetDefaultParams;
end;

destructor TIETWainParams.Destroy;
begin
	IETW_FreeResources(@TWainShared,IEFindHandle(fOwner));
	SetDefaultParams;
   FreeAndNil(fSourceListData);
   //
   with fCapabilities do begin
      FreeAndNil(fXResolution);
      FreeAndNil(fYResolution);
      FreeAndNil(fXScaling);
      FreeAndNil(fYScaling);
      FreeAndNil(fPixelType);
      FreeAndNil(fOrientation);
      FreeAndNil(fContrast);
      FreeAndNil(fBrightness);
      FreeAndNil(fStandardSize);
   end;
   //
	inherited;
end;

procedure TIETWainParams.FreeResources;
begin
   IETW_FreeResources(@TWainShared,IEFindHandle(fOwner));
   TWainShared.hDSMLib:=0;
   TWainShared.DSM_Entry:=nil;
   TWainShared.hproxy:=0;
end;

function TIETWainParams.GetDefaultSource:integer;
var
	q,ll:integer;
   sn:AnsiString;
begin
	result:=0;
   sn:=IETW_GetDefaultSource(@TWainShared,IEFindHandle(fOwner));
	FillSourceListData;
   ll:=length(sn);
	for q:=0 to fSourceListData.Count-1 do
   	if uppercase(copy(pTW_IDENTITY(fSourceListData[q])^.ProductName,1,ll))=uppercase(sn) then begin
      	result:=q;
         break;
      end;
end;

// set defaults. Also free fSourceListData items and fCapabilities allocated data
procedure TIETWainParams.SetDefaultParams;
var
	q:integer;
begin
   for q:=0 to fSourceListData.Count-1 do
      Freemem(fSourceListData[q]);
   fSourceListData.Clear;
	fVisibleDialog:=true;
   fCompatibilityMode:=false;
   fSelectedSource:=0;
   fSourceListDataValid:=false;
   fCapabilitiesValid:=false;
   // set fCapabilities items
   with fCapabilities do begin
      fXResolution.Clear;
      fYResolution.Clear;
      fXScaling.Clear;
      fYScaling.Clear;
      fPixelType.Clear;
      fContrast.Clear;
      fBrightness.Clear;
      fGamma:=2.2;
      fPhysicalHeight:=0;
      fPhysicalWidth:=0;
      fThreshold:=128;
      fRotation:=0;
      {$ifdef IEINCLUDEMULTIVIEW}
      if fOwner is TImageEnMIO then begin
	      fFeederEnabled:=true;
	      fDuplexEnabled:=true;
         fAutoFeed:=true;
      end else begin
      {$endif}
	      fFeederEnabled:=false;
	      fDuplexEnabled:=false;
         fAutoFeed:=false;
      {$ifdef IEINCLUDEMULTIVIEW}
      end;
      {$endif}
      fAcquireFrameEnabled:=false;
      fOrientation.clear;
      fIndicators:=true;
      l3fillchar(fAcquireFrame,sizeof(TRect),0);
      fBufferedTransfer:=True;
      fFileTransfer:=false;
      fUndefinedImageSize:=false;
      fStandardSize.clear;
   end;
   // app identification
   fAppVersionInfo:='';
   fAppManufacturer:='';
   fAppProductFamily:='';
   fAppProductName:='';
   //
   LastError:=0;
	LastErrorStr:='';
end;

procedure TIETWainParams.Assign(Source:TIETWainParams);
var
	q:integer;
   pt:pTW_IDENTITY;
begin
   fVisibleDialog:=Source.fVisibleDialog;
   fCompatibilityMode:=Source.fCompatibilityMode;
   fSelectedSource:=Source.fSelectedSource;
   fSourceListDataValid:=Source.fSourceListDataValid;
   // free fSourceListData items
   for q:=0 to fSourceListData.Count-1 do
      Freemem(fSourceListData[q]);
   fSourceListData.Clear;
   // copy fSourceListData items
   for q:=0 to Source.fSourceListData.Count-1 do begin
		getmem(pt,sizeof(TW_IDENTITY));
      l3move(Source.fSourceListData[q]^,pt^,sizeof(TW_IDENTITY));
      fSourceListData.Add(pt);
   end;
	// copy fCapabilities (item by item)
   with fCapabilities do begin
      fXResolution.assign(Source.fCapabilities.fXResolution);
      fYResolution.assign(Source.fCapabilities.fYResolution);
      fXScaling.assign(Source.fCapabilities.fXScaling);
      fYScaling.assign(Source.fCapabilities.fYScaling);
      fPixelType.assign(Source.fCapabilities.fPixelType);
      fGamma:=Source.fCapabilities.fGamma;
      fPhysicalHeight:=Source.fCapabilities.fPhysicalHeight;
      fPhysicalWidth:=Source.fCapabilities.fPhysicalWidth;
      fFeederEnabled:=Source.fCapabilities.fFeederEnabled;
      fAutoFeed:=Source.fCapabilities.fAutoFeed;
      fDuplexEnabled:=Source.fCapabilities.fDuplexEnabled;
      fAcquireFrameEnabled:=Source.fCapabilities.fAcquireFrameEnabled;
      fOrientation.assign(Source.fCapabilities.fOrientation);
      fIndicators:=Source.fCapabilities.fIndicators;
      fAcquireFrame:=Source.fCapabilities.fAcquireFrame;
      fBufferedTransfer:=Source.fCapabilities.fBufferedTransfer;
      fFileTransfer:=Source.fCapabilities.fFileTransfer;
      fContrast.assign(Source.fCapabilities.fContrast);
      fBrightness.assign(Source.fCapabilities.fBrightness);
      fThreshold:=Source.fCapabilities.fThreshold;
      fRotation:=Source.fCapabilities.fRotation;
      fUndefinedImageSize:=Source.fCapabilities.fUndefinedImageSize;
      fStandardSize:=Source.fCapabilities.fStandardSize;
	end;
   // copy app id
   fAppVersionInfo:=Source.fAppVersionInfo;
   fAppManufacturer:=Source.fAppManufacturer;
   fAppProductFamily:=Source.fAppProductFamily;
   fAppProductName:=Source.fAppProductName;
end;

procedure TIETWainParams.FillSourceListData;
var
	q:integer;
begin
	if not fSourceListDataValid then begin
      // free fSourceListData items
      for q:=0 to fSourceListData.Count-1 do
         Freemem(fSourceListData[q]);
      fSourceListData.Clear;
      // get fSourceListData
      IETW_GetSourceList(fSourceListData,@TWainShared,IEFindHandle(fOwner));
      fSourceListDataValid:=True;
      // get source capabilities
      //FillCapabilities;	// removed in 1.8 version (works well?)
   end;
end;

function TIETWainParams.GetFromScanner:boolean;
begin
	result:=IETW_GetCapabilities(self,fCapabilities,false,@TWainShared,IEFindHandle(fOwner));
	fCapabilitiesValid:=True;
end;

procedure TIETWainParams.FillCapabilities;
begin
	if not fCapabilitiesValid then begin
   	IETW_GetCapabilities(self,fCapabilities,false,@TWainShared,IEFindHandle(fOwner));
   	fCapabilitiesValid:=True;
   end;
end;

function TIETWainParams.GetSourceName(idx:integer):AnsiString;
begin
	FillSourceListData;
   if idx<fSourceListData.Count then
	   result:=pTW_IDENTITY(fSourceListData[idx])^.ProductName
   else
   	result:='';
end;

function TIETWainParams.GetSourceCount:integer;
begin
	FillSourceListData;
   result:=fSourceListData.Count;
end;

// Seleziona il primo source che ha la parte sinistra uguale a "sn".
// Rest.true se trovato
function TIETWainParams.SelectSourceByName(const sn:AnsiString):boolean;
var
	q,ll:integer;
begin
	result:=false;
	FillSourceListData;
   ll:=length(sn);
	for q:=0 to fSourceListData.Count-1 do
   	if uppercase(copy(pTW_IDENTITY(fSourceListData[q])^.ProductName,1,ll))=uppercase(sn) then begin
			if fSelectedSource<>q then
         	SetSelectedSource(q);
	     	result:=true;
         break;
      end;
end;

function TIETWainParams.GetXResolution:TIEDoubleList;
begin
	FillCapabilities;
	result:=fCapabilities.fXResolution;
end;

function TIETWainParams.GetYResolution:TIEDoubleList;
begin
	FillCapabilities;
	result:=fCapabilities.fYResolution;
end;

function TIETWainParams.GetXScaling:TIEDoubleList;
begin
	FillCapabilities;
	result:=fCapabilities.fXScaling;
end;

function TIETWainParams.GetYScaling:TIEDoubleList;
begin
	FillCapabilities;
	result:=fCapabilities.fYScaling;
end;

function TIETWainParams.GetContrast:TIEDoubleList;
begin
	FillCapabilities;
   result:=fCapabilities.fContrast;
end;

function TIETWainParams.GetThreshold:integer;
begin
	FillCapabilities;
   result:=fCapabilities.fThreshold;
end;

procedure TIETWainParams.SetThreshold(v:integer);
begin
	fCapabilities.fThreshold:=v;
end;

function TIETWainParams.GetRotation:integer;
begin
	FillCapabilities;
   result:=fCapabilities.fRotation;
end;

procedure TIETWainParams.SetRotation(v:integer);
begin
	fCapabilities.fRotation:=v;
end;


function TIETWainParams.GetBrightness:TIEDoubleList;
begin
	FillCapabilities;
   result:=fCapabilities.fBrightness;
end;

function TIETWainParams.GetPixelType:TIEIntegerList;
begin
	FillCapabilities;
	result:=fCapabilities.fPixelType;
end;

function TIETWainParams.GetGamma:double;
begin
	FillCapabilities;
	result:=fCapabilities.fGamma;
end;

function TIETWainParams.GetFeederLoaded:boolean;
begin
	FillCapabilities;
   result:=fCapabilities.fFeederLoaded;
end;

function TIETWainParams.GetPaperDetectable:boolean;
begin
	FillCapabilities;
   result:=fCapabilities.fPaperDetectable;
end;

function TIETWainParams.GetDuplexSupported:boolean;
begin
	FillCapabilities;
   result:=fCapabilities.fDuplexSupported;
end;

function TIETWainParams.GetPhysicalHeight:double;
begin
	FillCapabilities;
	result:=fCapabilities.fPhysicalHeight;
end;

function TIETWainParams.GetPhysicalWidth:double;
begin
	FillCapabilities;
	result:=fCapabilities.fPhysicalWidth;
end;

function TIETWainParams.GetFeederEnabled:boolean;
begin
	FillCapabilities;
	result:=fCapabilities.fFeederEnabled;
end;

function TIETWainParams.GetAutoFeed:boolean;
begin
   FillCapabilities;
   result:=fCapabilities.fAutoFeed;
end;

function TIETWainParams.GetUndefinedImageSize:boolean;
begin
	// no need FillCapabilities
   result:=fCapabilities.fUndefinedImageSize;
end;

function TIETWainParams.GetDuplexEnabled:boolean;
begin
	FillCapabilities;
   result:=fCapabilities.fDuplexEnabled;
end;

function TIETWainParams.GetAcquireFrameEnabled:boolean;
begin
	FillCapabilities;
   result:=fCapabilities.fAcquireFrameEnabled;
end;

function TIETWainParams.GetOrientation:TIEIntegerList;
begin
	FillCapabilities;
	result:=fCapabilities.fOrientation;
end;

function TIETWainParams.GetStandardSize:TIEIntegerList;
begin
   FillCapabilities;
   result:=fCapabilities.fStandardSize;
end;

function TIETWainParams.GetIndicators:boolean;
begin
	FillCapabilities;
	result:=fCapabilities.fIndicators;
end;

procedure TIETWainParams.SetFeederEnabled(v:boolean);
begin
	fCapabilities.fFeederEnabled:=v;
end;

procedure TIETWainParams.SetAutoFeed(v:boolean);
begin
   fCapabilities.fAutoFeed:=v;
end;

procedure TIETWainParams.SetUndefinedImageSize(v:boolean);
begin
	fCapabilities.fUndefinedImageSize:=v;
end;

procedure TIETWainParams.SetDuplexEnabled(v:boolean);
begin
	fCapabilities.fDuplexEnabled:=v;
end;

procedure TIETWainParams.SetAcquireFrameEnabled(v:boolean);
begin
	fCapabilities.fAcquireFrameEnabled:=v;
end;

procedure TIETWainParams.SetIndicators(v:boolean);
begin
	fCapabilities.fIndicators:=v;
end;

function TIETWainParams.GetAcquireFrame(idx:integer):double;
begin
	FillCapabilities;
   case idx of
   	0: result:=fCapabilities.fAcquireFrame.Left;
      1: result:=fCapabilities.fAcquireFrame.Top;
      2: result:=fCapabilities.fAcquireFrame.Right;
      3: result:=fCapabilities.fAcquireFrame.Bottom;
      else result:=0;
   end;
end;

procedure TIETWainParams.SetAcquireFrame(idx:integer; v:double);
begin
	case idx of
		0: fCapabilities.fAcquireFrame.Left:=v;
		1: fCapabilities.fAcquireFrame.Top:=v;
      2: fCapabilities.fAcquireFrame.Right:=v;
      3: fCapabilities.fAcquireFrame.Bottom:=v;
   end;
end;

function TIETWainParams.GetBufferedTransfer:boolean;
begin
	result:=fCapabilities.fBufferedTransfer;
end;

procedure TIETWainParams.SetBufferedTransfer(v:boolean);
begin
	fCapabilities.fBufferedTransfer:=v;
end;

function TIETWainParams.GetFileTransfer:boolean;
begin
	result:=fCapabilities.fFileTransfer;
end;

procedure TIETWainParams.SetFileTransfer(v:boolean);
begin
	fCapabilities.fFileTransfer:=v;
end;

procedure TIETWainParams.SetSelectedSource(v:integer);
begin
	if v<>fSelectedSource then begin
   	fSelectedSource:=v;
      fCapabilitiesValid:=false;
      FillCapabilities;
   end;
end;

procedure TIETWainParams.Update;
begin
	IETW_GetCapabilities(self,fCapabilities,true,@TWainShared,IEFindHandle(fOwner));
   fCapabilitiesValid:=True;
end;

procedure TIETWainParams.SetAppVersionInfo(v:AnsiString);
begin
	fAppVersionInfo:=copy(v,1,32);
end;

procedure TIETWainParams.SetAppManufacturer(v:AnsiString);
begin
	fAppManufacturer:=copy(v,1,32);
end;

procedure TIETWainParams.SetAppProductFamily(v:AnsiString);
begin
	fAppProductFamily:=copy(v,1,32);
end;

procedure TIETWainParams.SetAppProductName(v:AnsiString);
begin
	fAppProductName:=copy(v,1,32);
end;

procedure TIETWainParams.SetLogFile(v:AnsiString);
begin
	if iegTWainLogName<>'' then
   	closefile(iegTWainLogFile);
	iegTWainLogName:=v;
   if v<>'' then begin
      assignfile(iegTWainLogFile,iegTWainLogName);
      rewrite(iegTwainLogFile);
   end;
end;

function TIETWainParams.GetLogFile:AnsiString;
begin
	result:=iegTWainLogName;
end;


{$endif}	// {$ifdef IEINCLUDETWAIN}


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Registered File formats support
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


// ret nil if FileType doesn't exists
function IEFileFormatGetInfo(FileType:TIOFileType):PIEFileFormatInfo;
var
	q:integer;
begin
	for q:=0 to iegFileFormats.Count-1 do begin
		result:=PIEFileFormatInfo(iegFileFormats[q]);
      if result^.FileType=FileType then
      	exit;
   end;
   result:=nil;
end;

// ret extension count
function IEFileFormatGetExtCount(FileType:TIOFileType):integer;
begin
	result:=0;
   while IEFileFormatGetExt(FileType,result)<>'' do
   	inc(result);
end;

// ret extension
// example: for Extensions='jpg;jpeg' idx=1 is 'jpeg'
function IEFileFormatGetExt(FileType:TIOFileType; idx:integer):AnsiString;
var
	fi:PIEFileFormatInfo;
   ss:AnsiString;
	//
   function ExtractNext:AnsiString;
   var
   	q:integer;
   begin
   	q:=pos(';',ss);
      if q=0 then begin
      	result:=ss;
         ss:='';
      end else begin
      	result:=copy(ss,1,q-1);
         ss:=copy(ss,q+1,length(ss)-q);
      end;
   end;
   //
var
	i:integer;
begin
	fi:=IEFileFormatGetInfo(FileType);
   if assigned(fi) then begin
      ss:=fi^.Extensions;
      i:=0;
      while length(ss)>0 do begin
         result:=ExtractNext;
         if i=idx then EXIT;
         inc(i);
      end;
   end;
   result:='';
end;

// ret nil if Extension doesn't exists
function IEFileFormatGetInfo2(Extension:AnsiString):PIEFileFormatInfo;
var
	q,i,c:integer;
begin
	Extension:=lowercase(Extension);
	for q:=0 to iegFileFormats.Count-1 do begin
	   result:=PIEFileFormatInfo(iegFileFormats[q]);
      c:=IEFileFormatGetExtCount(result^.FileType);
      for i:=0 to c-1 do
      	if lowercase(IEFileFormatGetExt(result^.FileType,i))=Extension then
            exit;
   end;
   result:=nil;
end;

procedure IEFileFormatAdd(const FileFormatInfo:TIEFileFormatInfo);
var
	fi:PIEFileFormatInfo;
begin
	getmem(fi,sizeof(TIEFileFormatInfo));
   l3move(FileFormatInfo,fi^,sizeof(TIEFileFormatInfo));
   iegFileFormats.Add(fi);
end;

procedure IEFileFormatRemove(FileType:TIOFileType);
var
	r:PIEFileFormatInfo;
begin
	r:=IEFileFormatGetInfo(FileType);
   if assigned(r) then
   	iegFileFormats.Remove(r);
end;

procedure DumpReadImageStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec; Preview:boolean);
begin
end;

procedure DumpWriteImageStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec);
begin
end;

function DumpTryImageStream(Stream:TStream):boolean;
begin
	result:=false;
end;

// Alloc iegFileFormats global variable and embedded file formats
procedure IEInitFileFormats;
var
	fi:TIEFileFormatInfo;
   L3118:TImageEnIO;
begin
	// this allows the linker to include all obj files avoiding Delphi "Internal Error L3118"
   L3118:=TImageEnIO.Create(nil);
   FreeAndNil(L3118);
   //
	iegFileFormats:=TList.Create;
	with fi do begin
      // TIFF
      FileType:=ioTIFF;
      FullName:='TIFF Bitmap';
      Extensions:='TIF;TIFF;FAX;G3N;G3F';
      DialogPage:=[ppTIFF];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // GIF
      FileType:=ioGIF;
      FullName:='CompuServe Bitmap';
      Extensions:='GIF';
      DialogPage:=[ppGIF];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // JPEG
      FileType:=ioJPEG;
      FullName:='JPEG Bitmap';
      Extensions:='JPG;JPEG;JPE';
      DialogPage:=[ppJPEG];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // PCX
      FileType:=ioPCX;
      FullName:='PaintBrush';
      Extensions:='PCX';
      DialogPage:=[ppPCX];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // BMP
      FileType:=ioBMP;
      FullName:='Windows Bitmap';
      Extensions:='BMP;DIB;RLE';
      DialogPage:=[ppBMP];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // ICO
      FileType:=ioICO;
      FullName:='Windows Icon';
      Extensions:='ICO';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // CUR
      FileType:=ioCUR;
      FullName:='Windows Cursor';
      Extensions:='CUR';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=nil;	// cannot write
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // PNG
      {$ifdef IEINCLUDEPNG}
      FileType:=ioPNG;
      FullName:='Portable Network Graphics';
      Extensions:='PNG';
      DialogPage:=[ppPNG];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      {$endif}
      // WMF
      FileType:=ioWMF;
      FullName:='Windows Metafile';
      Extensions:='WMF';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=nil;	// cannot write
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // EMF
      FileType:=ioEMF;
      FullName:='Enhanced Windows Metafile';
      Extensions:='EMF';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=nil;	// cannot write
      TryFunction := DetectMetafile;
      IEFileFormatAdd(fi);
      // TGA
      FileType:=ioTGA;
      FullName:='Targa Bitmap';
      Extensions:='TGA;TARGA;VDA;ICB;VST;PIX';
      DialogPage:=[ppTGA];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // PXM
      FileType:=ioPXM;
      FullName:='Portable Pixmap, GrayMap, BitMap';
      Extensions:='PXM;PPM;PGM;PBM';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // WBMP
      FileType:=ioWBMP;
      FullName:='Wireless Bitmap';
      Extensions:='WBMP';
      DialogPage:=[];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      {$ifdef IEINCLUDEJPEG2000}
      // JP2
      FileType:=ioJP2;
      FullName:='JPEG2000';
      Extensions:='JP2';
      DialogPage:=[ppJ2000];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // J2K
      FileType:=ioJ2K;
      FullName:='JPEG2000 Code Stream';
      Extensions:='J2K;JPC;J2C';
      DialogPage:=[ppJ2000];
      ReadFunction:=DumpReadImageStream;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      {$endif}
      // PostScript (PS)
      FileType:=ioPS;
      FullName:='PostScript Level 2';
      Extensions:='PS;EPS';
      DialogPage:=[];
      ReadFunction:=nil;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
      // Adobe PDF
      FileType:=ioPDF;
      FullName:='Adobe PDF';
      Extensions:='PDF';
      DialogPage:=[];
      ReadFunction:=nil;
      WriteFunction:=DumpWriteImageStream;
      TryFunction:=DumpTryimageStream;
      IEFileFormatAdd(fi);
   end;
end;

// update GIF WriteFunction and ReadFunction regarding to DefGIF_LZWCOMPFUNC and DefGIF_LZWDECOMPFUNC
procedure IEUpdateGIFStatus;
var
	fi:PIEFileFormatInfo;
begin
	fi:=IEFileFormatGetInfo(ioGIF);
   if assigned(fi) then begin
      if @DefGIF_LZWDECOMPFUNC<>nil then
         fi^.ReadFunction:=DumpReadImageStream
      else
         fi^.ReadFunction:=nil;
      if @DefGIF_LZWCOMPFUNC<>nil then
         fi^.WriteFunction:=DumpWriteImageStream
      else
         fi^.WriteFunction:=nil;
   end;
end;

// Free iegFileFormats global variable
procedure IEFreeFileFormats;
var
	q:integer;
begin
	for q:=0 to iegFileFormats.Count-1 do
		freemem(iegFileFormats[q]);
   FreeAndNil(iegFileFormats);
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnIO.LoadFromFilePXM(const nf:AnsiString);
var
   fs:TFileStream;
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFilePXM,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   	Progress.fOnProgress:=fOnProgress;
      Progress.Sender:=Self;
      fIEBitmap.RemoveAlphaChannel;
   	PXMReadStream(fs,fIEBitmap,fParams,Progress,false);
      CheckDPI;
      if fAutoAdjustDPI then
         AdjustDPI;
      fParams.fFileName:=nf;
      fParams.fFileType:=ioPXM;
      update;
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromStreamPXM(Stream:TStream);
var
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamPXM,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   PXMReadStream(Stream,fIEBitmap,fParams,Progress,false);
   CheckDPI;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioPXM;
   update;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToFilePXM(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFilePXM,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   PXMWriteStream(fs,fIEBitmap,fParams,Progress);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamPXM(Stream:TStream);
var
	Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamPXM,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	PXMWriteStream(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

//
procedure PrintImagePos_func1(x,y:dword; pixel:pointer; UserData:pointer);
begin
	with PRGB(pixel)^ do begin
   	r:=pbytearray(UserData)^[r];
      g:=pbytearray(UserData)^[g];
      b:=pbytearray(UserData)^[b];
   end;
end;

// dpix,dpiy cannot be 0
procedure TImageEnIO.PrintImagePosEx(PrtCanvas:TCanvas; dpix,dpiy:integer; x,y:double; Width,Height:double; GammaCorrection:double);
(*
const
   Inv255 = 1.0 / 255;
var
   i: Integer;
   InvGamma: double;
   lut:array [0..255] of byte;
	vbmp:TIEVirtualBitmap;
   ImageWidth,ImageHeight:integer;
   px,py,pWidth,pHeight:integer;
begin
   if assigned(fBitmap) then
      fIEBitmap.EncapsulateTBitmap(fBitmap,false); // synchronize fBitmap with fIEBitmap
   ImageWidth:=fIEBitmap.Width;
   ImageHeight:=fIEBitmap.Height;
	vbmp:=TIEVirtualBitmap.Create;
   // do copy and gamma correction
   case fIEBitmap.PixelFormat of
   	ie1g:
      	begin
      		// just copy
            vbmp.AllocateBits(ImageWidth,ImageHeight,1);
            vbmp.CopyFromIEBitmap(fIEBitmap,0,0,ImageWidth,ImageHeight);	// convert also 1 to 24 bit
      	end;
   	ie24RGB:
      	begin
         	vbmp.AllocateBits(ImageWidth,ImageHeight,24);
         	vbmp.CopyFromIEBitmap(fIEBitmap,0,0,ImageWidth,ImageHeight);
            if (GammaCorrection<>1) and (GammaCorrection>0) then begin
               InvGamma := 1.0/GammaCorrection;
               for i:=0 to 255 do
                  lut[i]:=blimit(round(255*iepower(i*Inv255,InvGamma)));
		      	vbmp.ApplyFunction(0,0,ImageWidth,ImageHeight,PrintImagePos_func1,@lut[0])
            end;
         end;
   end;
   //
   px:=trunc(x*dpix);
   py:=trunc(y*dpiy);
   pWidth:=trunc(Width*dpix);
   pHeight:=trunc(Height*dpiy);
   //
   vbmp.RenderTo(PrtCanvas,px,py,pWidth,pHeight,0,0,ImageWidth,ImageHeight,fPrintingFilterOnSubsampling);
   //
   FreeAndNil(vbmp);
end;
*)
var
   px,py,pWidth,pHeight:integer;
   zz:double;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   //
   px:=trunc(x*dpix);
   py:=trunc(y*dpiy);
   pWidth:=trunc(Width*dpix);
   pHeight:=trunc(Height*dpiy);
   zz:=pWidth/fIEBitmap.Width;
   //
   if fPrintingFilterOnSubsampling and (zz<1) then
		fIEBitmap.RenderToCanvas(PrtCanvas,px,py,pWidth,pHeight,rfFastLinear,GammaCorrection)
   else
   	fIEBitmap.RenderToCanvas(PrtCanvas,px,py,pWidth,pHeight,rfNone,GammaCorrection);
end;

// if width=0 and/or height=0, PrintImagePos autocalculates for normal size
procedure TImageEnIO.PrintImagePos(PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double);
var
	dpix,dpiy:integer;
begin
   (*$ifdef IEDELPHI*)
   dpix:=GetDeviceCaps(PrtCanvas.Handle,LOGPIXELSX);
	dpiy:=GetDeviceCaps(PrtCanvas.Handle,LOGPIXELSY);
   (*$endif*)
	(*$ifdef IEKYLIX*)
   dpix:=Printer.XDPI;
   dpiy:=Printer.YDPI;
   (*$endif*)
	PrintImagePosEx(PrtCanvas,dpix,dpiy,x,y,Width,Height,GammaCorrection);
end;

// dpix, dpiy are dpi of destination device, cannot be 0
procedure TImageEnIO.PrintImageEx(PrtCanvas:TCanvas; dpix,dpiy:integer; pagewidth,pageheight:double; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
var
	x,y,width,height:double;
   z:double;
   bitmapwidth,bitmapheight:double; // in inches
   imgdpix,imgdpiy:integer;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   if assigned(fImageEnView) then begin
      imgdpix:=fImageEnView.DpiX;
      imgdpiy:=fImageEnView.DpiY;
   end else begin
   	imgdpix:=Params.DpiX;
      imgdpiy:=Params.DpiY;
   end;
   if assigned(fTImage) then begin
   	if (fTImage.Picture.Bitmap.PixelFormat<>pf1bit) and (fTImage.Picture.Bitmap.PixelFormat<>pf24bit) then
			fTImage.Picture.Bitmap.PixelFormat:=pf24bit;
   end;
   (*
   if imgdpix<=1 then imgdpix:=gDefaultDpix;
   if imgdpiy<=1 then imgdpiy:=gDefaultDpiy;
   *)
   if imgdpix<=1 then imgdpix:=dpix;
   if imgdpiy<=1 then imgdpiy:=dpiy;
   (*
   if (dpix=0) or (dpiy=0) then begin
   	dpix:=imgdpix;
      dpiy:=imgdpiy;
      pagewidth:=pagewidth/dpix;
      pageheight:=pageheight/dpiy;
   end;*)
   pagewidth:=pagewidth-(MarginLeft+MarginRight);
   pageheight:=pageheight-(MarginTop+MarginBottom);
   width:=0;
   height:=0;
   x:=0;
   y:=0;
   case Size of
   	iesNORMAL:
      	begin
         	width:=fIEBitmap.Width/imgdpix;
            height:=fIEBitmap.Height/imgdpiy;
         end;
		iesFITTOPAGE:
      	begin
            bitmapwidth:=fIEBitmap.Width/dpix;
            bitmapheight:=fIEBitmap.Height/dpiy;
				z:=dmin( pagewidth/bitmapwidth, pageheight/bitmapheight );
            width:=bitmapwidth*z;
            height:=bitmapheight*z;
         end;
      iesFITTOPAGESTRETCH:
      	begin
            width:=pagewidth;
            height:=pageheight;
         end;
      iesSPECIFIEDSIZE:
      	begin
         	width:=SpecWidth;
            height:=SpecHeight;
         end;
   end;
	case HorizontalPos of
		iehpLEFT:
      	x:=MarginLeft;
      iehpCENTER:
      	x:=MarginLeft+(pagewidth-width)/2;
      iehpRIGHT:
      	x:=MarginLeft+pagewidth-width;
   end;
   case VerticalPos of
   	ievpTOP:
      	y:=MarginTop;
      ievpCENTER:
      	y:=MarginTop+(pageheight-height)/2;
      ievpBOTTOM:
      	y:=MarginTop+pageheight-height;
   end;
   PrintImagePosEx(PrtCanvas,dpix,dpiy,x,y,width,height,GammaCorrection);
end;

//
procedure TImageEnIO.PrintImage(PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size: TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
var
	dpix,dpiy:integer;
   pagewidth,pageheight:double;
begin
   if PrtCanvas=nil then
      PrtCanvas:=Printer.Canvas;
   (*$ifdef IEDELPHI*)
   dpix:=GetDeviceCaps(PrtCanvas.Handle,LOGPIXELSX);
	dpiy:=GetDeviceCaps(PrtCanvas.Handle,LOGPIXELSY);
	pagewidth:=GetDeviceCaps(PrtCanvas.Handle,8)/dpix;	// HORZRES
	pageheight:=GetDeviceCaps(PrtCanvas.Handle,10)/dpiy;// VERTRES
   (*$endif*)
	(*$ifdef IEKYLIX*)
   dpix:=Printer.XDPI;
   dpiy:=Printer.YDPI;
   pagewidth:=Printer.PageWidth/dpix;
   pageheight:=Printer.PageHeight/dpiy;
   (*$endif*)
	PrintImageEx(PrtCanvas,dpix,dpiy,pagewidth,pageheight,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,Size,SpecWidth,SpecHeight,GammaCorrection);
end;

// resize DestBitmap as needed
procedure TImageEnIO.PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth,MaxBitmapHeight:integer; PrinterObj:TPrinter; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:TIEVerticalPos; HorizontalPos:TIEHorizontalPos; Size:TIESize; SpecWidth,SpecHeight:double; GammaCorrection:double);
var
	Zoom,z1,z:double;
   x1,y1,x2,y2:integer;
	dpix,dpiy:integer; PageWidth,PageHeight:integer;
begin
   if PrinterObj=nil then
      PrinterObj:=Printer;
   Zoom:=(MaxBitmapWidth-5)/(PrinterObj.PageWidth/100);
   z1:=(MaxBitmapHeight-5)/(PrinterObj.PageHeight/100);
   if z1<Zoom then Zoom:=z1;
	z:=Zoom/100;
	PageWidth:=trunc(PrinterObj.PageWidth*z);
   PageHeight:=trunc(PrinterObj.PageHeight*z);
   (*$ifdef IEDELPHI*)
   dpix:=trunc(GetDeviceCaps(PrinterObj.Handle,LOGPIXELSX)*z);
   dpiy:=trunc(GetDeviceCaps(PrinterObj.Handle,LOGPIXELSY)*z);
   (*$endif*)
	(*$ifdef IEKYLIX*)
   dpix:=trunc(PrinterObj.XDPI*z);
   dpiy:=trunc(PrinterObj.YDPI*z);
   (*$endif*)
   DestBitmap.Width:=1; DestBitmap.Height:=1;
   DestBitmap.PixelFormat:=pf24bit;
   DestBitmap.Width:=PageWidth;
   DestBitmap.Height:=PageHeight;
	with DestBitmap.Canvas do begin
		Brush.Color:=clWhite;
   	Brush.Style:=bsSolid;
   	fillrect(rect(0,0,destbitmap.width,destbitmap.height));
	end;
	PrintImageEx(DestBitmap.Canvas,dpix,dpiy,PageWidth/dpix,PageHeight/dpiy,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,Size,SpecWidth,SpecHeight,GammaCorrection);
	with DestBitmap.Canvas do begin
   	Brush.Style:=bsClear;
      Pen.Color:=clBlack;
      Pen.Mode:=pmNot;
      Pen.Style:=psDash;
      Pen.Width:=1;
      x1:=trunc(MarginLeft*dpix);
      y1:=trunc(MarginTop*dpiy);
      x2:=trunc(PageWidth-MarginRight*dpix);
      y2:=trunc(PageHeight-MarginBOttom*dpiy);
      Rectangle(x1,y1,x2,y2);
   end;
end;

// return false if fail
function TImageEnIO.InjectJpegIPTC(const nf:AnsiString):boolean;
var
	fr:TMemoryStream;
   fm:TMemoryStream;
   Progress:TProgressRec;
begin
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fr:=TMemorystream.Create;
   fr.LoadFromFile(nf);
   fr.Position:=0;
   fm:=TMemoryStream.Create;
   fm.Size:=fr.Size;
	result:=IEJpegInjectIPTC(fr,fm,fParams.IPTC_Info,Progress);
   fm.Size:=fm.Position;
   FreeAndNil(fr);
   if result then
	   fm.SaveToFile(nf);
   FreeAndNil(fm);
   DoFinishWork;
end;

// return false if fail
function TImageEnIO.InjectJpegIPTCStream(InputStream,OutputStream:TStream):boolean;
var
	Progress:TProgressRec;
begin
	Progress.fOnProgress:=nil;
	result:=IEJpegInjectIPTC(InputStream,OutputStream,fParams.IPTC_Info,Progress);
end;

// return false if fail
function TImageEnIO.InjectJpegEXIF(const nf:AnsiString):boolean;
var
	fr:TMemoryStream;
   fm:TMemoryStream;
   Progress:TProgressRec;
begin
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fr:=TMemoryStream.Create;
   fr.LoadFromFile(nf);
   fr.Position:=0;
   fm:=TMemoryStream.Create;
   fm.Size:=fr.Size;
	result:=IEJpegInjectEXIF(fr,fm,fParams,Progress);
   fm.Size:=fm.Position;
   FreeAndNil(fr);
   if result then
	   fm.SaveToFile(nf);
   FreeAndNil(fm);
   DoFinishWork;
end;


// return false if fail
function TImageEnIO.InjectJpegEXIFStream(InputStream,OutputStream:TStream):boolean;
var
	Progress:TProgressRec;
begin
	Progress.fOnProgress:=nil;
	result:=IEJpegInjectEXIF(InputStream,OutputStream,fParams,Progress);
end;


//
{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEnIO.ExecuteOpenDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
{$ifdef IEDELPHI}
var
	fOpenImageEnDialog:TOpenImageEnDialog;
begin
	fOpenImageEnDialog:=TOpenImageEnDialog.create(self);
   fOpenImageEnDialog.InitialDir:=InitialDir;
	fOpenImageEnDialog.FileName:=InitialFileName;
   {$ifdef IEINCLUDEMULTIVIEW}
   fOpenImageEnDialog.AlwaysAnimate:=AlwaysAnimate;
   {$endif}

   {$ifndef IEDELPHI3}
   {$ifndef IECPPBUILDER3}
   fOpenImageEnDialog.Options:=fOpenImageEnDialog.Options+[OFENABLESIZING];
   {$endif}
   {$endif}

   fOpenImageEnDialog.PreviewBorderStyle:=IepsCropShadow;
   fOpenImageEnDialog.FilterIndex:=FilterIndex;
   fOpenImageEnDialog.AutoAdjustDPI:=AutoAdjustDPI;
   fOpenImageEnDialog.FilteredAdjustDPI:=FilteredAdjustDPI;
   fOpenImageEnDialog.ExtendedFilters:=ExtendedFilters;
   fOpenImageEnDialog.MsgLanguage:=fMsgLanguage;
   if fOpenImageEnDialog.Execute then
   	result:=fOpenImageEnDialog.FileName
   else
   	result:='';
   FreeAndNil(fOpenImageEnDialog);
end;
{$endif}	// IEDELPHI
{$ifdef IEKYLIX}
begin
end;
{$endif}	// IEKYLIX
{$endif}	// IEINCLUDEOPENSAVEDIALOGS

//
{$ifdef IEINCLUDEOPENSAVEDIALOGS}
function TImageEnIO.ExecuteSaveDialog(InitialDir:AnsiString; InitialFileName:AnsiString; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:AnsiString):AnsiString;
{$ifdef IEDELPHI}
var
	fSaveImageEnDialog:TSaveImageEnDialog;
begin
	fSaveImageEnDialog:=TSaveImageEnDialog.create(self);
	fSaveImageEnDialog.InitialDir:=InitialDir;
   fSaveImageEnDialog.FileName:=InitialFileName;
   {$ifdef IEINCLUDEMULTIVIEW}
   fSaveImageEnDialog.AlwaysAnimate:=AlwaysAnimate;
   {$endif}
   {$ifndef IEDELPHI3}
   {$ifndef IECPPBUILDER3}
   fSaveImageEnDialog.Options:=fSaveImageEnDialog.Options+[OFENABLESIZING];
   {$endif}
   {$endif}
   fsaveImageEnDialog.AttachedImageEnIO:=self;
   fSaveImageEnDialog.PreviewBorderStyle:=IepsCropShadow;
   fSaveImageEnDialog.FilterIndex:=FilterIndex;
   fSaveImageEnDialog.AutoAdjustDPI:=AutoAdjustDPI;
   fSaveImageEnDialog.FilteredAdjustDPI:=FilteredAdjustDPI;
   fSaveImageEnDialog.ExtendedFilters:=ExtendedFilters;
   fSaveImageEnDialog.MsgLanguage:=fMsgLanguage;
   if fSaveImageEnDialog.Execute then
   	result:=fSaveImageEnDialog.FileName
   else
   	result:='';
   FreeAndNil(fSaveImageEnDialog);
end;
{$endif}	// IEDELPHI
{$ifdef IEKYLIX}
begin
end;
{$endif}	// IEKYLIX
{$endif}	// IEINCLUDEOPENSAVEDIALOGS


procedure TImageEnIO.CaptureFromScreen(Source:TIECSSource; MouseCursor:TCursor);
(*$ifdef IEDELPHI*)
var
	hwin,hdc:THandle;
   x,y,w,h:integer;
   rc:trect;
   vdsk:boolean;
   pt:TPoint;
   xbmp:TIEDibBitmap;
   plc:TWINDOWPLACEMENT;
   hCursor:THandle;
   MousePt:TPoint;
   ClientLeftTop:TPoint;
   IconInfo:TIconInfo;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateCaptureFromScreen(self,fAsyncThreads,CaptureFromScreen,Source,MouseCursor);
      exit;
   end;
   if not MakeConsistentBitmap([]) then
   	exit;
   getcursorpos(MousePt);
   hCursor:=Screen.Cursors[-2];
   GetIconInfo(hCursor, IconInfo);
   ClientLeftTop:=Point(0,0);
	vdsk:=IEIs_98 or IEIs_Win2000_ME_XP;
	hwin:=0; w:=0; h:=0;
   x:=0;
   y:=0;
	case Source of
		iecsScreen:
      	begin
         	hwin:=GetDesktopWindow;
            if vdsk then begin
            	// available only on win98, me, 2000, Xp
            	x:=GetSystemMetrics(76);	// SM_XVIRTUALSCREEN
               y:=GetSystemMetrics(77);	// SM_YVIRTUALSCREEN
            	w:=GetSystemMetrics(78);	// SM_CXVIRTUALSCREEN
               h:=GetSystemMetrics(79);	// SM_CYVIRTUALSCREEN
            end else begin
					w:=Screen.Width;
	            h:=Screen.Height;
            end;
            dec(MousePt.x,integer(IconInfo.xHotspot));
            dec(MousePt.y,integer(IconInfo.yHotspot));
            Windows.ScreenToClient(hwin,MousePt);
         end;
      iecsForegroundWindow:
      	begin
            hwin:=GetForegroundWindow;
            if hwin<>0 then begin
               plc.length:=sizeof(TWINDOWPLACEMENT);
               GetWindowPlacement(hwin,@plc);
               if GetWindowRect(hwin,rc) then begin
	               if plc.showCmd=SW_SHOWMAXIMIZED then begin
                     if rc.left<0 then x:=-rc.left;
                     if rc.top<0 then y:=-rc.top;
                     w:=rc.Right-x;
                     h:=rc.Bottom-y;
                     if rc.left<0 then rc.left:=0;
                     if rc.top<0 then rc.top:=0;
	               end else begin
                     w:=rc.Right-rc.Left;
                     h:=rc.Bottom-rc.Top;
                  end;
                  Windows.ClientToScreen(hwin,ClientLeftTop);
                  dec(MousePt.x,-(ClientLeftTop.x-rc.left) +integer(IconInfo.xHotspot));
                  dec(MousePt.y,-(ClientLeftTop.y-rc.top)  +integer(IconInfo.yHotspot));
                  Windows.ScreenToClient(hwin,MousePt);
               end else
               	hwin:=0;
            end;
         end;
      iecsForegroundWindowClient:
      	begin
            hwin:=GetForegroundWindow;
            if hwin<>0 then begin
	            if GetClientRect(hwin,rc) then begin
                  pt.x:=rc.Left; pt.y:=rc.Top;
               	Windows.ClientToScreen(hwin,pt);
                  x:=pt.x; y:=pt.y;
                  pt.x:=rc.Right; pt.y:=rc.Bottom;
                  Windows.ClientToScreen(hwin,pt);
                  w:=pt.x-x;
                  h:=pt.y-y;
                  hwin:=GetDesktopWindow;
                  dec(MousePt.x,integer(IconInfo.xHotspot)+x);
                  dec(MousePt.y,integer(IconInfo.yHotspot)+y);
               end else
               	hwin:=0;
            end;
         end;
   end;
   if hwin<>0 then begin
   	xbmp:=TIEDibBitmap.Create;
      xbmp.AllocateBits(w,h,24);
      hdc:=GetWindowDC(hwin);
      if hdc<>0 then begin
			BitBlt(xbmp.HDC,0,0,w,h,hdc,x,y,SRCCOPY);
         if MouseCursor<>-1 then
         	DrawIconEx(xbmp.HDC,MousePt.x,MousePt.y,hCursor,0,0,0,0,DI_DEFAULTSIZE or DI_NORMAL);
         fIEBitmap.Allocate(w,h,ie24RGB);
         for y:=0 to h-1 do
            copymemory(fIEBitmap.Scanline[y],xbmp.Scanline[y],fIEBitmap.RowLen);
         FreeAndNil(xbmp);
	      ReleaseDC(hwin,hdc);
	      Update;
      end;
   end;
   DoFinishWork;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
end;
(*$endif*)

{$ifdef IEINCLUDEPRINTDIALOGS}
function TImageEnIO.DoPrintPreviewDialog(DialogType:TIEDialogType; const TaskName:AnsiString):boolean;
(*$ifdef IEDELPHI*)
var
	fieprnform1:tfieprnform1;
   fieprnform2:tfieprnform2;
begin
	if fResetPrinter then
   	IEResetPrinter;
	result:=false;
	case DialogType of
   	iedtDialog:
      	begin
            fieprnform2:=tfieprnform2.Create(self);
				fieprnform2.io:=self;
            fieprnform2.fDialogsMeasureUnit:=fDialogsMeasureUnit;
		   	fieprnform2.SetLanguage(fMsgLanguage);
			   fieprnform2.Font.assign(fPreviewFont);
            fieprnform2.fTaskName:=TaskName;
            if assigned(fOnIOPreview) then
		   		fOnIOPreview(self,fieprnform2);
				result:=fieprnform2.ShowModal=mrOk;
			   fieprnform2.Release;
         end;
      iedtMaxi:
      	begin
            fieprnform1:=tfieprnform1.Create(self);
            fieprnform1.io:=self;
            fieprnform1.fDialogsMeasureUnit:=fDialogsMeasureUnit;
		   	fieprnform1.SetLanguage(fMsgLanguage);
			   fieprnform1.Font.assign(fPreviewFont);
            fieprnform1.fTaskName:=TaskName;
	        	fieprnform1.Left:=0;
   	     	fieprnform1.Top:=0;
            if assigned(fOnIOPreview) then
		   		fOnIOPreview(self,fieprnform1);
				result:=fieprnform1.ShowModal=mrOk;
			   fieprnform1.Release;
         end;
   end;
end;
(*$endif*)
(*$ifdef IEKYLIX*)
begin
	result:=false;
end;
(*$endif*)
{$endif}


function IEAdjustDPI(bmp:TIEBitmap; Params:TIOParamsVals; FilteredAdjustDPI:boolean):TIEBitmap;
var
   new_w,new_h:integer;
begin
	result:=bmp;
	with Params do
      if (DpiX<>DpiY) and (DpiX>0) and (DpiY>0) then begin
         result:=TIEBitmap.Create;
      	if Width>Height then begin
         	new_h:=trunc((Height/DpiY)*DpiX);
            new_w:=Width;
            DpiY:=DpiX;
            Height:=new_h;
         end else begin
         	new_w:=trunc((Width/DpiX)*DpiY);
            new_h:=Height;
            DpiX:=DpiY;
            Width:=new_w;
         end;
         if FilteredAdjustDPI then begin
            result.Allocate( new_w,new_h,ie24RGB );
            if bmp.PixelFormat<>ie24RGB then
               bmp.PixelFormat:=ie24RGB;
            _ResampleEx(bmp,result,rfFastLinear,nil,nil);
         end else begin
         	result.Allocate( new_w,new_h,bmp.PixelFormat);
         	_IEBmpStretchEx(bmp,result,nil,nil);
         end;
      end;
end;

procedure TImageEnIO.AdjustDPI;
var
   new_w,new_h:integer;
   newbmp,oldalpha:TIEBitmap;
begin
	with fParams do
      if (DpiX<>DpiY) and (DpiX>0) and (DpiY>0) then begin
         if not MakeConsistentBitmap([]) then
            exit;
         newbmp:=TIEBitmap.Create;
      	if fWidth>fHeight then begin
         	new_h:=trunc((fHeight/fDpiY)*fDpiX);
            new_w:=fWidth;
            fDpiY:=fDpiX;
            fHeight:=new_h;
         end else begin
         	new_w:=trunc((fWidth/fDpiX)*fDpiY);
            new_h:=fHeight;
            fDpiX:=fDpiY;
            fWidth:=new_w;
         end;
         if fIEBitmap.HasAlphaChannel then begin
         	oldalpha:=TIEBitmap.Create;
            oldalpha.assign(fIEBitmap.AlphaChannel);
         end else
         	oldalpha:=nil;
         if fFilteredAdjustDPI then begin
            newbmp.Allocate( new_w,new_h,ie24RGB );
            if fIEBitmap.PixelFormat<>ie24RGB then
               fIEBitmap.PixelFormat:=ie24RGB;
            _ResampleEx(fIEBitmap,newbmp,rfFastLinear,nil,nil);
         end else begin
         	newbmp.Allocate( new_w,new_h,fIEBitmap.PixelFormat);
            _IEBmpStretchEx(fIEBitmap,newbmp,nil,nil);
         end;
         fIEBitmap.Assign( newbmp );
         FreeAndNil(newbmp);
         // stretch alpha
         if assigned(oldalpha) then begin
            _IEBmpStretchEx(oldalpha,fIEBitmap.AlphaChannel,nil,nil);
            FreeAndNil(oldalpha);
         end;
      end;
end;

(*$ifdef IEDELPHI*)
function JpegLosslessTransformStream(SourceStream, DestStream:TStream; Transform:TIEJpegTransform; GrayScale:boolean; CopyMarkers:TIEJpegCopyMarkers; CutRect:TRect):boolean;
var
	xp:TProgressRec;
   ab:boolean;
begin
	ab:=false;
   xp.Aborting:=@ab;
	IEJpegLosslessTransform(SourceStream,DestStream,xp,integer(Transform),GrayScale,integer(CopyMarkers),CutRect);
   result:= not ab;
end;
(*$endif*)

(*$ifdef IEDELPHI*)
function JpegLosslessTransform(const SourceFile, DestFile:AnsiString; Transform:TIEJpegTransform; GrayScale:boolean; CopyMarkers:TIEJpegCopyMarkers; CutRect:TRect):boolean;
var
   fr,fw:TFileStream;
begin
	try
	fr:=TFileStream.Create(SourceFile,fmOpenRead or fmShareDenyWrite);
   except
   	result:=false;
      exit;
   end;
   try
   fw:=TFileStream.Create(DestFile,fmCreate);
   except
   	FreeAndNil(fr);
      result:=false;
      exit;
   end;
	result:=JpegLosslessTransformStream(fr,fw,Transform,GrayScale,CopyMarkers,CutRect);
  	FreeAndNil(fw);
  	FreeAndNil(fr);
end;
(*$endif*)

// return frame count
(*$ifdef IEDELPHI*)
function TImageEnIO.OpenAVIFile(const nf:AnsiString):integer;
var
	psi:TAviStreamInfoA;
begin
	if fAVI_avf<>nil then
   	CloseAVIFile;
   result:=0;
   fParams.fAVI_FrameCount:=0;
   try
   fParams.fFileName:=nf;
   fParams.FileType:=ioUnknown;
	if not gAVIFILEinit then begin
		AVIFileInit;
		gAVIFILEinit:=true;
   end;
   if AVIFileOpen(PAVIFILE(fAVI_avf),pAnsichar(nf),OF_READ,nil)<>0 then begin
   	fAborting:=True;
      exit;
   end;
   if AVIFileGetStream(PAVIFILE(fAVI_avf),PAVISTREAM(fAVI_avs),streamtypeVIDEO,0)<>0 then begin
	   AVIFileRelease(fAVI_avf);
   	fAborting:=True;
      exit;
   end;
   if AVIStreamInfo(PAVISTREAM(fAVI_avs),psi,sizeof(TAVISTREAMINFO))<>0 then begin
	   AVIFileRelease(fAVI_avf);
      AVIStreamRelease(fAVI_avs);
   	fAborting:=True;
      exit;
   end;
   l3move(psi,fAVI_psi,sizeof(TAviStreamInfoA_Ex));
   fAVI_gf:=AVIStreamGetFrameOpen(fAVI_avs,nil);
   if fAVI_gf=nil then begin
	   AVIFileRelease(fAVI_avf);
      AVIStreamRelease(fAVI_avs);
		fAborting:=True;
   	exit;
   end;
   result:=fAVI_psi.dwLength;
   fParams.fAVI_FrameCount:=fAVI_psi.dwLength;
   fParams.fAVI_FrameDelayTime:=0;
   finally
      if fAborting then begin
         fAVI_avf:=nil;
         fAVI_avs:=nil;
         fAVI_gf:=nil;
      end;
   end;
end;

procedure TImageEnIO.CloseAVIFile;
begin
	if fAVI_avs1<>nil then begin
   	// save
      AVISaveOptionsFree(1,PAVICOMPRESSOPTIONS(fAVI_popts));
      freemem(fAVI_popts);
      AVIStreamRelease(fAVI_avs);
      AVIStreamRelease(fAVI_avs1);
      AVIFileRelease(fAVI_avf);
      fAVI_popts:=nil;
      fAVI_avs:=nil;
      fAVI_avs1:=nil;
      fAVI_avf:=nil;
   end else begin
   	// load
      if fAVI_avf=nil then exit;
      AVIStreamGetFrameClose(fAVI_gf);
      AVIStreamRelease(fAVI_avs);
      AVIFileRelease(fAVI_avf);
      fAVI_avf:=nil;
      fAVI_avs:=nil;
      fAVI_gf:=nil;
   end;
end;

// return frame count
procedure TImageEnIO.LoadFromAVI(FrameIndex:integer);
var
   pt:pointer;
   bitcount:integer;
   dib:TIEDibBitmap;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveIndex(self,fAsyncThreads,LoadFromAVI,FrameIndex);
      exit;
   end;
   try
   fAborting:=false;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fAVI_avf=nil) or (fAVI_avs=nil) or (fAVI_gf=nil) then exit;
   if dword(FrameIndex)>=fAVI_psi.dwLength then exit;
   pt:=AVIStreamGetFrame(fAVI_gf,FrameIndex);
   fParams.fAVI_FrameCount:=fAVI_psi.dwLength;
   fParams.fAVI_FrameDelayTime:=trunc((1/(fAVI_psi.dwRate/fAVI_psi.dwScale))*1000);
	dib:=TIEDibBitmap.create;
   if pt<>nil then begin
      bitcount:=_IECopyDIB2Bitmap2Ex(integer(pt),dib,nil,true);	// uses drawdibdraw
      fIEBitmap.CopyFromTDibBitmap(dib);
      case BitCount of
         1: begin fParams.BitsPerSample:=1; fParams.SamplesPerPixel:=1; end;
         4: begin fParams.BitsPerSample:=4; fParams.SamplesPerPixel:=1; end;
         8: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=1; end;
         15: begin fParams.BitsPerSample:=5; fParams.SamplesPerPixel:=3; end;
         16,24,32: begin fParams.BitsPerSample:=8; fParams.SamplesPerPixel:=3; end;
      end;
      fParams.DpiX:=gDefaultDPIX;
      fParams.DpiY:=gDefaultDPIY;
      fParams.Width:=dib.Width;
      fParams.Height:=dib.Height;
      if fParams.ColorMap<>nil then begin
         freemem(fParams.ColorMap);
         fParams.fColorMap:=nil;
         fParams.fColorMapCount:=0;
      end;
      Update;
   end;
   FreeAndNil(dib);
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.CreateAVIFile(const nf:AnsiString; rate:integer; codec:AnsiString);
var
	psi:TAVISTREAMINFOA;
begin
	fAborting:=False;
	if not gAVIFILEinit then begin
		AVIFileInit;
		gAVIFILEinit:=true;
   end;
   if AVIFileOpen(PAVIFILE(fAVI_avf),pAnsichar(nf),OF_WRITE or OF_CREATE,nil)<>0 then
	   raise EInvalidGraphic.Create('unable to create AVI file');
   l3zeromemory(@psi,sizeof(psi));
   psi.fccType:=streamtypeVIDEO;
   psi.dwScale:=1;
   psi.dwRate:= rate;
   psi.dwQuality:=$FFFFFFFF;
   fAVI_popts:=allocmem(sizeof(TAVICOMPRESSOPTIONS));
   if (fParams.BitsPerSample=8) and (fParams.SamplesPerPixel=1) then
   	psi.dwSuggestedBufferSize:=IEBitmapRowLen(fParams.Width,8,32)*fParams.Height
   else
	   psi.dwSuggestedBufferSize:=IEBitmapRowLen(fParams.Width,24,32)*fParams.Height;
   psi.rcFrame:=rect(0,0,fParams.Width,fParams.Height);
   AVIFileCreateStream(PAVIFILE(fAVI_avf),PAVISTREAM(fAVI_avs1),psi);
   if codec='' then begin
      if not AVISaveOptions(0,0,1,@fAVI_avs1,@fAVI_popts) then begin
         AVIStreamRelease(fAVI_avs1);
         fAVI_avs1:=nil;
         AVIFileRelease(fAVI_avf);
         fAVI_avf:=nil;
         fAborting:=True;
         exit;			// EXIT POINT
      end;
   end else begin
		PAVICOMPRESSOPTIONS(fAVI_popts)^.fccType:=streamtypeVIDEO;
		PAVICOMPRESSOPTIONS(fAVI_popts)^.fccHandler:= pinteger(PAnsiChar(codec))^;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.dwKeyFrameEvery:=0;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.dwQuality:=$FFFFFFFF;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.dwBytesPerSecond:=0;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.dwFlags:=0;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.lpFormat:=nil;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.cbFormat:=0;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.lpParms:=nil;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.cbParms:=0;
      PAVICOMPRESSOPTIONS(fAVI_popts)^.dwInterleaveEvery:=0;
   end;
   AVIMakeCompressedStream(PAVISTREAM(fAVI_avs),PAVISTREAM(fAVI_avs1),fAVI_popts,nil);
   fAVI_idx:=0;
end;

procedure TImageEnIO.SaveToAVI;
type
   TBitmapInfoHeader256Ex = packed record
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
      Palette: array [0..255] of TRGBQUAD;
   end;
   PBitmapInfoHeader256Ex=^TBitmapInfoHeader256Ex;
var
	he:TBitmapInfoHeader256Ex;
   i:integer;
   sw,sx:integer;
   bmp:TIEBitmap;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   bmp:=TIEBitmap.Create;
   bmp.Location:=ieMemory;
   bmp.Assign( fIEBitmap );
   // set video format
   he.biSize:=sizeof(TBitmapInfoHeader);
   he.biWidth:=bmp.Width;
   he.biHeight:=bmp.Height;
   he.biPlanes:=1;
   he.biCompression:=BI_RGB;
   he.biXPelsPerMeter:=0;
   he.biYPelsPerMeter:=0;
   he.biClrUsed:=256;
   he.biClrImportant:=0;
   if (fParams.fSamplesPerPixel=1) and (fParams.fBitsPerSample=8) then begin
      // 256 colors
      bmp.PixelFormat:=ie8p;
      he.biSizeImage:=bmp.RowLen*bmp.Height;
      he.biBitCount:=8;
      for i:=0 to 255 do begin
         he.Palette[i].rgbRed:=bmp.Palette[i].r;
         he.Palette[i].rgbGreen:=bmp.Palette[i].g;
         he.Palette[i].rgbBlue:=bmp.Palette[i].b;
         he.Palette[i].rgbReserved:=0;
      end;
      AVIStreamSetFormat(fAVI_avs,fAVI_idx,@he,sizeof(TBITMAPINFOHEADER)+256*sizeof(TRGBQUAD));
   end else begin
      // 24 bit
      he.biBitCount:=24;
      he.biSizeImage:=bmp.RowLen*bmp.Height;
      if fAVI_idx=0 then
      	AVIStreamSetFormat(fAVI_avs,0,@he,sizeof(TBITMAPINFOHEADER));
   end;
   sw:=0; sx:=0;
	AVIStreamWrite(fAVI_avs,fAVI_idx,1,bmp.Scanline[bmp.Height-1],he.biSizeImage,AVIIF_KEYFRAME,@sx,@sw);
   //if he.biBitCount=8 then
		//AVIStreamSetFormat(fAVI_avs,fAVI_idx,@he,sizeof(TBITMAPINFOHEADER)+256*sizeof(TRGBQUAD));
   FreeAndNil(bmp);
   inc(fAVI_idx);
end;


(*$endif*)

/////////////////////////////////////////////////////////////////////////////////////
// If Width or Height is -1 then it is auto-calculated maintain aspect ratio
// Import... because this is a vectorial image
// Doesn't set IO params
// DON't USE INSIDE A THREAD
(*$ifdef IEDELPHI*)
procedure TImageEnIO.MergeMetafile(const FileName:AnsiString; x,y,Width,Height:integer);
const
	MAXDIMS=16000;
var
   meta:TMetafile;
   dib:TIEDibBitmap;
   dibcanvas:TCanvas;
begin
   try
	fAborting:=false;
	if (Width=0) or (Height=0) then
   	exit;
   if not MakeConsistentBitmap([]) then
   	exit;
   meta:=tmetafile.create;
   try
   meta.LoadFromFile(FileName);
   if (Width>=0) or (Height>=0) then begin
   	if (Width>=0) and (Height>=0) then begin
			meta.Width:=Width;
         meta.Height:=Height;
      end else begin
         if Width<0 then begin
            meta.Width:=(meta.Width*Height) div meta.Height;
            meta.Height:=Height;
         end else if Height<0 then begin
            meta.Height:=(meta.Height*Width) div meta.Width;
            meta.Width:=Width;
         end;
      end;
   end;
   if (meta.width=0) or (meta.height=0) then begin
   	fAborting:=true;
   	exit;	// finally will be executed (meta.free)
   end;
   if (meta.width>MAXDIMS) or (meta.height>MAXDIMS) then begin
		if meta.Height>meta.Width then begin
         meta.Width:=(meta.Width*MAXDIMS) div meta.Height;
         meta.Height:=MAXDIMS;
      end else begin
         meta.Height:=(meta.Height*MAXDIMS) div meta.Width;
         meta.Width:=MAXDIMS;
      end;
   end;
   meta.transparent:=true;
   dib:=TIEDibBitmap.Create;
   dibcanvas:=TCanvas.Create;
   dib.AllocateBits(meta.Width-1,meta.Height-1,24);
   fIEBitmap.CopyToTDibBitmap(dib,x,y,dib.Width,dib.Height);
   dibcanvas.Handle:=dib.HDC;
   dibCanvas.Draw(0,0,meta);
   fIEBitmap.MergeFromTDibBitmap(dib,x,y);
   FreeAndNil(dibcanvas);
   FreeAndNil(dib);
   finally
      FreeAndNil(meta);
   end;
   update;
   finally
   	DoFinishWork;
   end;
end;
(*$endif*)

// doesn't set fParams.fFileType
{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.LoadFromStreamJ2000(Stream:TStream);
var
   Progress:TProgressRec;
begin
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   J2KReadStream(Stream,fIEBitmap,fParams,Progress,False);
   CheckDPI;
   if fAutoAdjustDPI then
      AdjustDPI;
   fParams.fFileName:='';
   if assigned(fImageEnView) then
      fImageEnView.SetDpi(fParams.dpix,fParams.dpiy);
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.LoadFromStreamJP2(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamJP2,Stream);
      exit;
   end;
   try
	LoadFromStreamJ2000(Stream);
	fParams.fFileType:=ioJP2;
   update;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.LoadFromStreamJ2K(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamJ2K,Stream);
      exit;
   end;
   try
	LoadFromStreamJ2000(Stream);
	fParams.fFileType:=ioJ2K;
   update;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.LoadFromFileJ2K(const nf:AnsiString);
var
   fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileJ2K,nf);
      exit;
   end;
   try
   fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   LoadFromStreamJ2000(fs);
   fParams.fFileName:=nf;
   fParams.fFileType:=ioJ2K;
   finally
   	FreeAndNil(fs);
   end;
   update;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.LoadFromFileJP2(const nf:AnsiString);
var
   fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileJP2,nf);
      exit;
   end;
   try
   fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   LoadFromStreamJ2000(fs);
   fParams.fFileName:=nf;
   fParams.fFileType:=ioJP2;
   finally
   	FreeAndNil(fs);
   end;
   update;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.SaveToStreamJ2000(Stream:TStream; format:integer);
var
   Progress:TProgressRec;
begin
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   J2KWriteStream(Stream,fIEBitmap,fParams,Progress,format);
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.SaveToStreamJP2(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamJP2,Stream);
      exit;
   end;
   try
	SaveToStreamJ2000(Stream,0);
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.SaveToStreamJ2K(stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamJ2K,Stream);
      exit;
   end;
   try
	SaveToStreamJ2000(Stream,1);
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.SaveToFileJP2(const nf:AnsiString);
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileJP2,nf);
      exit;
   end;
   try
   fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
	fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   SaveToStreamJ2000(fs,0);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

{$ifdef IEINCLUDEJPEG2000}
procedure TImageEnIO.SaveToFileJ2K(const nf:AnsiString);
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileJ2K,nf);
      exit;
   end;
   try
   fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
	fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   SaveToStreamJ2000(fs,1);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;
{$endif}

procedure TImageEnIO.SetIEBitmap(bmp:TIEBitmap);
begin
   fBitmap:=nil;
   if fIEBitmapCreated then
      FreeAndNil(fIEBitmap);
   fIEBitmapCreated:=false;
   fIEBitmap:=bmp;
end;

procedure TImageEnIO.SetAttachedIEBitmap(bmp:TIEBitmap);
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

procedure TImageEnIO.SetBitmap(bmp:TBitmap);
begin
   fBitmap:=bmp;
   fIEBitmap.EncapsulateTBitmap(fBitmap,true);
end;

procedure TImageEnIO.SetAttachedBitmap(atBitmap:TBitmap);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);	// remove previous if exists
	if (not assigned(atBitmap)) and (assigned(fImageEnView) or assigned(fTImage)) then
   	exit;	// error
   fBitmap:=atBitmap;
   fIEBitmap.EncapsulateTBitmap(fBitmap,true);
  	if assigned(fBitmap) then begin
     	fImageEnView:=nil;
      fTImage:=nil;
   end;
end;

procedure TImageEnIO.SetAttachedImageEn(atImageEn:TIEView);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);	// remove previous if exists
   fImageEnView:=atImageEn;
   if assigned(fImageEnView) then begin // fImageEnView now could be nil
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

procedure TImageEnIO.SetTImage(v:TImage);
begin
	if assigned(fImageEnView) then
   	fImageEnView.RemoveBitmapChangeEvent(fImageEnViewIdx);	// remove previous if exists
	fTImage:=v;
   if assigned(fTImage) then begin
   	fBitmap:=fTImage.Picture.Bitmap;
      fIEBitmap.EncapsulateTBitmap(fBitmap,true);
      fTImage.FreeNotification(self);
      fImageEnView:=nil;
   end else
      fIEBitmap.FreeImage;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEIOThread

function TImageEnIO.GetAsyncRunning:integer;
begin
	EnterCriticalSection(fAsyncThreadsCS);
   result:=fAsyncThreads.Count;
   LeaveCriticalSection(fAsyncThreadsCS);
end;

constructor TIEIOThread.CreateLoadSaveFile(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFile; const in_nf:AnsiString);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveFile;
   fMethod_LoadSaveFile:=InMethod;
   p_nf:=in_nf;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveStream(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStream; in_Stream:TStream);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveStream;
   fMethod_LoadSaveStream:=InMethod;
   p_stream:=in_Stream;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveStreamRetInt(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStreamRetInt; in_Stream:TStream);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveStreamRetInt;
   fMethod_LoadSaveStreamRetInt:=InMethod;
   p_stream:=in_Stream;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveFileRetInt(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFileRetInt; const in_nf:AnsiString);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveFileRetInt;
   fMethod_LoadSaveFileRetInt:=InMethod;
   p_nf:=in_nf;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateRetBool(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_RetBool);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieRetBool;
   fMethod_RetBool:=InMethod;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveFileFormat(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveFileFormat; const in_nf:AnsiString; in_fileformat:TIOFileType);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveFileFormat;
   fMethod_LoadSaveFileFormat:=InMethod;
   p_nf:=in_nf;
   p_fileformat:=in_fileformat;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveStreamFormat(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveStreamFormat; in_Stream:TStream; in_fileformat:TIOFileType);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveStreamFormat;
   fMethod_LoadSaveStreamFormat:=InMethod;
   p_stream:=in_stream;
   p_fileformat:=in_fileformat;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateCaptureFromScreen(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_CaptureFromScreen; in_source:TIECSSource; in_mouseCursor:TCursor);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieCaptureFromScreen;
   fMethod_CaptureFromScreen:=InMethod;
   p_source:=in_source;
   p_mouseCursor:=in_mouseCursor;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadSaveIndex(Owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadSaveIndex; in_index:integer);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadSaveIndex;
   fMethod_LoadSaveIndex:=InMethod;
   p_index:=in_index;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateImportMetaFile(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_ImportMetaFile; const in_nf:AnsiString; in_width,in_height:integer; in_withalpha:boolean);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieImportMetaFile;
   fMethod_ImportMetaFile:=InMethod;
   p_nf:=in_nf;
   p_width:=in_width;
   p_height:=in_height;
   p_withalpha:=in_withalpha;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateLoadFromURL(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_LoadFromURL; const in_URL:AnsiString; dummy:double);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieLoadFromURL;
   fMethod_LoadFromURL:=InMethod;
	p_URL:=in_URL;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

constructor TIEIOThread.CreateAcquire(owner:TImageEnIO; InThreadList:TList; InMethod:TIEIOMethodType_Acquire; in_api:TIEAcquireAPI);
begin
   inherited Create(true);
   fOwner:=Owner;
   fThreadList:=InThreadList;
   fMethodType:=ieAcquire;
   fMethod_Acquire:=InMethod;
   p_api:=in_api;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Add(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
   Resume;
end;

procedure TIEIOThread.Execute;
begin
   fThreadID:=GetCurrentThreadID;
   try
   case fMethodType of
      ieLoadSaveFile:   fMethod_LoadSaveFile(p_nf);
      ieLoadSaveStream: fMethod_LoadSaveStream(p_stream);
      ieLoadSaveFileRetInt: fMethod_LoadSaveFileRetInt(p_nf);
      ieRetBool: fMethod_RetBool;
      ieLoadSaveStreamRetInt: fMethod_LoadSaveStreamRetInt(p_stream);
      ieLoadSaveFileFormat: fMethod_LoadSaveFileFormat(p_nf,p_fileformat);
      ieLoadSaveStreamFormat: fMethod_LoadSaveStreamFormat(p_stream,p_FileFormat);
      ieCaptureFromScreen: fMethod_CaptureFromScreen(p_Source,p_mouseCursor);
      ieLoadSaveIndex: fMethod_LoadSaveIndex(p_index);
      ieImportMetaFile: fMethod_ImportMetaFile(p_nf,p_width,p_height,p_withalpha);
      ieLoadFromURL: fMethod_LoadFromURL(p_URL);
   end;
	except
      OutputDebugString('Exception in TIEIOThread.Execute');
		fOwner.Aborting:=true;
   end;
   FreeOnTerminate:=true;
   EnterCriticalSection(fOwner.fAsyncThreadsCS);
   fThreadList.Remove(self);
   LeaveCriticalSection(fOwner.fAsyncThreadsCS);
end;

// end of TIEIOThread
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure ExtractTIFFImageStream(SourceStream,OutStream:TStream; idx:integer);
begin
	_ExtractTIFFImStream(SourceStream,idx,OutStream);
end;

procedure ExtractTIFFImageFile(const SourceFileName,OutFileName:AnsiString; idx:integer);
var
	SourceStream,OutStream:TFileStream;
begin
	SourceStream:=TFileStream.Create(SourceFileName,fmOpenRead or fmShareDenyWrite);
   OutStream:=nil;
   try
   OutStream:=TFileStream.Create(OutFileName,fmCreate);
	_ExtractTIFFImStream(SourceStream,idx,OutStream);
   finally
   	FreeAndNil(OutStream);
   end;
   FreeAndNil(SourceStream);
end;

procedure InsertTIFFImageStream(SourceStream,InsertingStream,OutStream:TStream; idx:integer);
begin
	_InsertTIFFImStream(SourceStream, InsertingStream,idx, OutStream);
end;

// InsertingFileName is the page to insert
procedure InsertTIFFImageFile(const SourceFileName,InsertingFileName,OutFileName:AnsiString; idx:integer);
var
	SourceStream,InsertingStream,OutStream:TFileStream;
begin
	SourceStream:=TFileStream.Create(SourceFileName,fmOpenRead or fmShareDenyWrite);
   InsertingStream:=nil;
   OutStream:=nil;
   try
   InsertingStream:=TFileStream.Create(InsertingFileName,fmOpenRead or fmShareDenyWrite);
   try
   OutStream:=TFileStream.Create(OutFileName,fmCreate);
   _InsertTIFFImStream(SourceStream,InsertingStream,idx,OutStream);
   finally
   	FreeAndNil(OutStream);
   end;
   finally
   	FreeAndNil(InsertingStream);
   end;
   FreeAndNil(SourceStream);
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// load from url

{$ifdef IEDELPHI}

type
	HINTERNET = Pointer;
	INTERNET_PORT = Word;
	TInternetCloseHandle=function (hInet: HINTERNET): BOOL; stdcall;
	TInternetOpen=function (lpszAgent: PAnsiChar; dwAccessType: DWORD; lpszProxy, lpszProxyBypass: PAnsiChar; dwFlags: DWORD): HINTERNET; stdcall;
	TInternetConnect=function (hInet: HINTERNET; lpszServerName: PAnsiChar; nServerPort: INTERNET_PORT; lpszUsername: PAnsiChar; lpszPassword: PAnsiChar; dwService: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;
	THttpOpenRequest=function (hConnect: HINTERNET; lpszVerb: PAnsiChar; lpszObjectName: PAnsiChar; lpszVersion: PAnsiChar; lpszReferrer: PAnsiChar; lplpszAcceptTypes: PAnsiChar; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;
	THttpSendRequest=function (hRequest: HINTERNET; lpszHeaders: PAnsiChar; dwHeadersLength: DWORD; lpOptional: Pointer; dwOptionalLength: DWORD): BOOL; stdcall;
	TInternetReadFile=function (hFile: HINTERNET; lpBuffer: Pointer; dwNumberOfBytesToRead: DWORD; var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall;

const
  	INTERNET_OPEN_TYPE_DIRECT           = 1;
	INTERNET_SERVICE_HTTP = 3;
	INTERNET_OPEN_TYPE_PROXY            = 3;
  	INTERNET_FLAG_NO_CACHE_WRITE        = $04000000;
  	INTERNET_FLAG_DONT_CACHE            = INTERNET_FLAG_NO_CACHE_WRITE;
	INTERNET_FLAG_KEEP_CONNECTION       = $00400000;
	INTERNET_FLAG_RELOAD = $80000000;

var
	wininet:THandle;
	InternetOpen:TInternetOpen;
	InternetCloseHandle:TInternetCloseHandle;
   InternetConnect:TInternetConnect;
   HttpOpenRequest:THttpOpenRequest;
   HttpSendRequest:THttpSendRequest;
   InternetReadFile:TInternetReadFile;
{$endif}

// doesn't support password authentication
// doesn't support secure http (https)
// URL: 'http://domain[:port]/resource'  (example 'http://www.hicomponents.com/test.jpg' )
// ProxyAddress: 'domain:port' (example '10.2.7.2:8080' )
procedure TImageEnIO.LoadFromURL(URL:AnsiString);
{$ifdef IEDELPHI}
var
   hint:HINTERNET;
   hcon:HINTERNET;
   hreq:HINTERNET;
   buf:PAnsiChar;
   {$ifdef IEDC3}
   bx:dword;
   {$else}
   bx:cardinal;
   {$endif}
   Host,Page:AnsiString;
   Port,i:integer;
   ms:TMemoryStream;
   //
   procedure FreeHandles;
   begin
      if hreq<>nil then
         InternetCloseHandle(hreq);
      if hcon<>nil then
         InternetCloseHandle(hcon);
      if hint<>nil then
         internetCloseHandle(hint);
   end;
   procedure DoAbort;
   begin
   	fAborting:=true;
		DoFinishWork;
   end;
begin
	if wininet=0 then begin
   	// try to load the wininet.dll dynamic library
		wininet:=LoadLibrary('wininet.dll');
      if wininet=0 then begin
      	fAborting:=true;
         exit;
      end else begin
         InternetOpen:=GetProcAddress(wininet,'InternetOpenA');
         InternetCloseHandle:=GetProcAddress(wininet,'InternetCloseHandle');
         InternetConnect:=GetProcAddress(wininet,'InternetConnectA');
         HttpOpenRequest:=GetProcAddress(wininet,'HttpOpenRequestA');
         HttpSendRequest:=GetProcAddress(wininet,'HttpSendRequestA');
         InternetReadFile:=GetProcAddress(wininet,'InternetReadFile');
      end;
   end;
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadFromURL(self,fAsyncThreads,LoadFromURL,URL,0);
      exit;
   end;
   fAborting:=false;
   if lowercase(copy(URL,1,7))<>'http://' then begin
   	DoAbort;
      exit;
   end;
   delete(URL,1,7);
   i:=pos('/',URL);
   if i<1 then begin
      DoFinishWork;
      exit;
   end;
   Host:=copy(URL,1,i-1);
   Page:=copy(URL,i,length(URL));
   i:=pos(':',Host);
   if i>0 then begin
      Port:=strtointdef(copy(Host,i+1,length(Host)),80);
      Host:=copy(Host,1,i-1);
   end else
      Port:=80;
   hreq:=nil;
   hcon:=nil;
   hint:=nil;
   if ProxyAddress='' then begin
      hint:=InternetOpen('Mozilla/4.*',INTERNET_OPEN_TYPE_DIRECT,nil,nil,0);
      hcon:=InternetConnect(hint,pAnsichar(Host),Port,nil,nil,INTERNET_SERVICE_HTTP,0,0);
   end else begin
      hint:=InternetOpen('Mozilla/4.*',INTERNET_OPEN_TYPE_PROXY,pAnsichar(ProxyAddress),nil,0);
      hcon:=InternetConnect(hint,pAnsichar(Host),Port,pAnsichar(ProxyUser),pAnsichar(ProxyPassword),INTERNET_SERVICE_HTTP,0,0);
   end;
   if hcon=nil then begin
   	FreeHandles;
      DoFinishWork;
   	exit;
   end;
   hreq:=HttpOpenRequest(hcon,'GET',pAnsichar(Page),'HTTP/1.1',nil,nil,INTERNET_FLAG_DONT_CACHE or INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_RELOAD,1);
   if hreq=nil then begin
   	FreeHandles;
      DoFinishWork;
      exit;
   end;
   ms:=TMemoryStream.Create;
   HttpSendRequest(hreq, nil, 0, nil, 0);
   getmem(buf,65536);
   repeat
      InternetReadFile(hreq,buf,65536,bx);
      ms.Write(buf^,bx);
   until bx=0;
   freemem(buf);
   FreeHandles;
	//
   ms.Position:=0;
   try
   LoadFromStream(ms);	// this do other works, as IEBitmap sync, OnFinishWork, Update
   finally
      FreeAndNil(ms);
   end;
end;
{$else}	// IEDELPHI
begin
end;
{$endif}

// load from url
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnIO.DoAcquireBitmap(ABitmap:TIEBitmap; var Handled:boolean);
begin
	if assigned(fOnAcquireBitmap) then
   	fOnAcquireBitmap(self,ABitmap,Handled);
end;

procedure TImageEnIO.TWMultiCallBack( Bitmap:TIEBitmap; var IOParams:TObject);
var
   bHandled:boolean;  // Flag indicating whether the user has handled the acquired bitmap themselves
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   bHandled:=false;
   DoAcquireBitmap(Bitmap,bHandled);
   if not bHandled then begin
      IOParams:=fParams;
      fIEBitmap.Assign( Bitmap );
      if fAutoAdjustDPI then
      	AdjustDPI;
      Update;
   end;
end;

procedure TImageEnIO.TWCloseCallBack;
begin
	fgrec:=nil;
end;

{$ifdef IEINCLUDETWAIN}
function TImageEnIO.AcquireOpen:boolean;
begin
	if (not assigned(fgrec)) and assigned(fImageEnView) then begin
   	fAborting:=false;
      fTWainParams.FreeResources;
      fTWainParams.LastError:=0;
   	fTWainParams.LastErrorStr:='';
      fgrec:=IETWAINAcquireOpen(TWCloseCallBack,TWMultiCallBack, fTWainParams,@fTWainParams.TWainShared,fParams,fImageEnView);
      result:= fgrec<>nil;
   end else
   	result:= false;
end;
{$endif}

{$ifdef IEINCLUDETWAIN}
procedure TImageEnIO.AcquireClose;
begin
	if fgrec<>nil then begin
		IETWAINAcquireClose(fgrec);
      fgrec:=nil;
   end;
end;
{$endif}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////


(*$ifdef IEINCLUDESANE*)

constructor TIESANEParams.Create(Owner:TComponent);
begin
	inherited Create;
   fOwner:=Owner;
   fSaneDevices:=nil;
   fSelectedSource:=0;
   fSaneOptionDescriptors:=nil;
   SetDefaultParams;
end;

destructor TIESANEParams.Destroy;
begin
	inherited;
end;

procedure TIESANEParams.SetDefaultParams;
begin
	fBitDepth:=8;
   fColorMode:=ieColor;
   fXResolution:=150;
   fYResolution:=150;
end;

procedure TIESANEParams.Assign(Source:TIESANEParams);
begin
end;

procedure TIESANEParams.SetResolution(Value:integer);
begin
	fXResolution:=Value;
   fYResolution:=Value;
end;

function TIESANEParams.SelectSourceByName(const sn:AnsiString):boolean;
var
   sd:PPSANE_Device;
   i:integer;
begin
	result:=false;
	FillSourceListData;
   if fSaneDevices<>nil then begin
      sd:=fSaneDevices;
      i:=0;
      while sd^<>nil do begin
         if uppercase(sd^^.name) = uppercase(sn) then begin
            fSelectedSource:=i;
            break;
         end;
         inc(sd);
         inc(i);
      end;
   end;
end;

// fill fSaneDevices
procedure TIESANEParams.FillSourceListData;
begin
	if fSaneDevices = nil then
      if sane_get_devices(fSaneDevices,0) <> SANE_STATUS_GOOD then
      	fSaneDevices:=nil;
end;

function TIESANEParams.GetSourceName(idx:integer):AnsiString;
var
   sd:PPSANE_Device;
   i:integer;
begin
	result:='';
	FillSourceListData;
   if fSaneDevices<>nil then begin
      sd:=fSaneDevices;
      i:=0;
      while sd^<>nil do begin
         if i = idx then begin
            result:=sd^^.name;
            break;
         end;
         inc(sd);
      end;
   end;
end;

function TIESANEParams.GetSourceFullName(idx:integer):AnsiString;
var
   sd:PPSANE_Device;
   i:integer;
begin
	result:='';
	FillSourceListData;
   if fSaneDevices<>nil then begin
      sd:=fSaneDevices;
      i:=0;
      while sd^<>nil do begin
         if i = idx then begin
            with sd^^ do
               result:=name+' ('+vendor+') '+model+' '+xtype;
            break;
         end;
         inc(sd);
      end;
   end;
end;

function TIESANEParams.GetSourceCount:integer;
var
   sd:PPSANE_Device;
begin
   result:=0;
	FillSourceListData;
   if fSaneDevices<>nil then begin
      sd:=fSaneDevices;
      while sd^<>nil do begin
         inc(sd);
         inc(result);
      end;
   end;
end;

procedure TIESANEParams.SetSelectedSource(v:integer);
begin
	fSelectedSource:=v;
end;

procedure InitSANE;
var
	version_code:SANE_Int;
begin
	sane_init(version_code,nil);
end;

procedure ExitSANE;
begin
	sane_exit;
end;

// fill fSaneOptionDescriptors
procedure TIESANEParams.GetFromScanner;
var
	st:SANE_Status;
   shandle:SANE_Handle;
begin
	st:=sane_open(PAnsiChar(SourceName[fSelectedSource]),shandle);
   if st=SANE_STATUS_GOOD then begin
      //
      //..here a loop to get all option descriptors...
      //
   	sane_close(shandle);
   end;
end;

function TImageEnIO.Acquire:boolean;
var
   Progress:TProgressRec;
   st:SANE_Status;
   devicename:AnsiString;
   shandle:SANE_Handle;
   par:SANE_Parameters;
   buf,xbuf:pbyte;
   buflen,retlen,row,col:integer;
   px:PRGB;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateRetBool(self,fAsyncThreads,Acquire);
      result:=true;
      exit;
   end;
   try
	fAborting:=false;
	result:=false;
	if not assigned(fIEBitmap) then exit;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   if not MakeConsistentBitmap([]) then
   	exit;
   // acquire from SANE
   with fSANEParams do
	   devicename:=SourceName[SelectedSource];
	st:=sane_open(PAnsiChar(devicename),shandle);
   if st=SANE_STATUS_GOOD then begin
   	// set options
		IESANE_SetIntOption(shandle,'depth',fSANEParams.BitDepth);
      case fSANEParams.ColorMode of
      	ieColor: IESANE_SetStrOption(shandle,'mode','Color');
         ieGray:  IESANE_SetStrOption(shandle,'mode','Gray');
      end;
      IESANE_SetIntOption(shandle,'resolution',fSANEParams.XResolution);
		IESANE_SetIntOption(shandle,'y-resolution',fSANEParams.YResolution);
      //
   	st:=sane_start(shandle);
      if st=SANE_STATUS_GOOD then begin
			sane_get_parameters(shandle,par);
         if par.lines=-1 then begin
         	// it doesn't know the image height (hand scanner?)
         end else begin
         	// gets resulting DPI
            IESANE_GetIntOption(shandle,'resolution',fParams.fDPIX);
            if not IESANE_GetIntOption(shandle,'y-resolution',fParams.fDPIY) then
            	fParams.fDPIY:=fParams.fDPIX;
         	// it knows the image height
            fParams.fWidth:=par.pixels_per_line;
            fParams.fHeight:=par.lines;
            if par.format=SANE_FRAME_GRAY then
            	fParams.fSamplesPerPixel:=1
            else
            	fParams.fSamplesPerPixel:=3;
            fParams.fBitsPerSample:=par.depth;
            if (fParams.fBitsPerSample=1) and (fParams.fSamplesPerPixel=1) then
	            fIEBitmap.Allocate(par.pixels_per_line,par.lines,ie1g)
            else
					fIEBitmap.Allocate(par.pixels_per_line,par.lines,ie24RGB);
            buflen:=_BitmapRowLen(fParams.fWidth,fParams.fSamplesPerPixel*fParams.fBitsPerSample);
            getmem(buf,buflen);
            // acquire
            row:=0;
            while true do begin
            	st:=sane_read(shandle,PSANE_Byte(buf),par.bytes_per_line,retlen);
               if st<>SANE_STATUS_GOOD then break;
               case par.format of
                  SANE_FRAME_GRAY:
                     begin
                        // gray or black/white
                        if par.depth=8 then begin
                           px:=fIEBitmap.Scanline[row];
                           xbuf:=buf;
                           for col:=0 to fIEBitmap.Width-1 do begin
                              with px^ do begin
                                 r:=xbuf^;
                                 g:=xbuf^;
                                 b:=xbuf^;
                                 inc(xbuf);
                              end;
                              inc(px);
                           end;
                        end else if par.depth=1 then begin
                           CopyMemory(fIEBitmap.Scanline[row],buf,par.bytes_per_line);
                           _NegativeBuffer(fIEBitmap.Scanline[row],buflen);
                        end;
                     end;
                  SANE_FRAME_RGB:
                     begin
                        // RGB
                        px:=fIEBitmap.Scanline[row];
                        xbuf:=buf;
                        for col:=0 to fIEBitmap.Width-1 do begin
                           with px^ do begin
                              r:=xbuf^; inc(xbuf);
                              g:=xbuf^; inc(xbuf);
                              b:=xbuf^; inc(xbuf);
                           end;
                           inc(px);
                        end;
                     end;
               end;
               inc(row);
               with Progress do
               	if assigned(fOnProgress) then
                  	fOnProgress(self, trunc(100/par.lines*row));
            end;
            freemem(buf);
         end;
	      sane_cancel(shandle);
	   	result:=true;
      end;
      sane_close(shandle);
   end;
   //
   if result then begin
      if fAutoAdjustDPI then
      	AdjustDPI;
      if assigned(fImageEnView) then begin
	      fImageEnView.dpix:=fParams.DpiX;
	      fImageEnView.dpiy:=fParams.DpiY;
      end;
   end;
	Update;
   finally
   	DoFinishWork;
   end;
end;

(*$endif*)  // IEINCLUDESANE

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

function TImageEnIO.GetThreadsCount:integer;
begin
	EnterCriticalSection(fAsyncThreadsCS);
   result:=fAsyncThreads.Count;
   LeaveCriticalSection(fAsyncThreadsCS);
end;

procedure TImageEnIO.SetDefaultDitherMethod(Value:TIEDitherMethod);
begin
	if assigned(fIEBitmap) then
   	fIEBitmap.DefaultDitherMethod:=Value;
   fDefaultDitherMethod:=Value;
end;

function TImageEnIO.GetBitmap:TBitmap;
begin
	if assigned(fIEBitmap) and (fIEBitmap.Location=ieTBitmap) then
   	result:=fIEBitmap.VclBitmap
   else
   	result:=fBitmap;
end;

procedure TImageEnIO.SaveToStreamICO(Stream:TStream);
var
	Progress:TProgressRec;
   icount:integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamICO,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   icount:=0;
   while (Params.ICO_Sizes[icount].cx>0) and (icount<=high(Params.ICO_Sizes)) do
   	inc(icount);
	ICOWriteStream(Stream,fIEBitmap,fParams,Progress,slice(Params.ICO_Sizes,icount),slice(Params.ICO_BitCount,icount));
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToFileICO(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
   icount:integer;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileICO,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   icount:=0;
   while (Params.ICO_Sizes[icount].cx>0) and (icount<=high(Params.ICO_Sizes)) do
   	inc(icount);
   ICOWriteStream(fs,fIEBitmap,fParams,Progress,slice(Params.ICO_Sizes,icount),slice(Params.ICO_BitCount,icount));
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure IEWriteICOImages(const fileName:AnsiString; images:array of TObject);
var
   Progress:TProgressRec;
  	fs:TFileStream;
   fAborting:boolean;
begin
	fAborting:=false;
	Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=nil;
   Progress.Sender:=nil;
	fs:=TFileStream.Create(fileName,fmCreate);
   try
   ICOWriteStream2(fs,images,Progress);
   finally
   	FreeAndNil(fs);
   end;
end;

{$ifdef IEINCLUDEWIA}
function TImageEnIO.GetWIAParams:TIEWia;
begin
	if not assigned(fWIA) then begin
   	fWIA:=TIEWia.Create(self);
      fWIA.OnProgress:=WiaOnProgress;
   end;
   result:=fWIA;
end;

function TImageEnIO.WiaOnProgress(Percentage:integer):boolean;
begin
	if assigned(fOnProgress) then
   	fOnProgress(self,Percentage);
   result:= not fAborting;
end;
{$endif}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnIO.LoadFromFileWBMP(const nf:AnsiString);
var
   fs:TFileStream;
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,LoadFromFileWBMP,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   fs:=TFileStream.Create(nf,fmOpenRead or fmShareDenyWrite);
   fAborting:=false;
   try
   	Progress.fOnProgress:=fOnProgress;
      Progress.Sender:=Self;
      fIEBitmap.RemoveAlphaChannel;
   	WBMPReadStream(fs,fIEBitmap,fParams,Progress,false);
      CheckDPI;
      fParams.fFileName:=nf;
      fParams.fFileType:=ioWBMP;
      update;
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.LoadFromStreamWBMP(Stream:TStream);
var
   Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,LoadFromStreamWBMP,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
	fParams.ResetInfo;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   fIEBitmap.RemoveAlphaChannel;
   WBMPReadStream(Stream,fIEBitmap,fParams,Progress,false);
   CheckDPI;
   fParams.fFileName:='';
   fParams.fFileType:=ioWBMP;
   update;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToFileWBMP(const nf:AnsiString);
var
   Progress:TProgressRec;
  	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFileWBMP,nf);
      exit;
   end;
   try
	fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   fs:=TFileStream.Create(nf,fmCreate);
   fAborting:=false;
   try
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   WBMPWriteStream(fs,fIEBitmap,fParams,Progress);
   finally
   	FreeAndNil(fs);
   end;
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamWBMP(Stream:TStream);
var
	Progress:TProgressRec;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamWBMP,Stream);
      exit;
   end;
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	WBMPWriteStream(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

(*
function _CMYK2RGB(const cmyk:TCMYK):TRGB;
begin
	with cmyk,result do begin
		r := (255-k)*(255-c) div 255;
		g := (255-k)*(255-m) div 255;
		b := (255-k)*(255-y) div 255;
	end;
end;
*)

// CMYK to RGB
function IECMYK2RGB(cmyk:TCMYK):TRGB;
begin
	with cmyk,result do begin
		r := k*c div 255;
		g := k*m div 255;
		b := k*y div 255;
	end;
end;

// RGB to CMYK
function IERGB2CMYK(const rgb:TRGB):TCMYK;
begin
	with rgb,result do begin
	  	k:=imax(r,imax(g,b));
      if k=0 then k:=1;
      C := r*255 div k;
      M := g*255 div k;
      Y := b*255 div k;
   end;
end;

procedure IEDefaultConvertColorFunction(InputScanline:pointer; InputColorSpace:TIEColorSpace; OutputScanline:pointer; OutputColorSpace:TIEColorSpace; ImageWidth:integer);
var
	xlab:PIELAB;
   xcmyk:PCMYK;
   xbgr:PRGB;
   i:integer;
begin
	case InputColorSpace of
   	ieBGR:
      	case OutputColorSpace of
         	ieCMYK:
            	begin
               	// BGR->CMYK
                  xbgr:=PRGB(InputScanline);
                  xcmyk:=PCMYK(OutputScanline);
                  for i:=0 to ImageWidth-1 do begin
                     xcmyk^:=IERGB2CMYK(xbgr^);
                     inc(xbgr);
                     inc(xcmyk);
                  end;
               end;
            ieCIELab:
            	begin
               	// BGR->CIELab
                  xbgr:=PRGB(InputScanline);
                  xlab:=PIELAB(OutputScanline);
                  for i:=0 to ImageWidth-1 do begin
                  	xlab^:=IERGB2CIELAB(xbgr^);
                     inc(xbgr);
                     inc(xlab);
                  end;
               end;
         end;
      ieCMYK:
      	case OutputColorSpace of
         	ieBGR:
            	begin
               	// CMYK->BGR
                  xcmyk:=PCMYK(InputScanline);
                  xbgr:=OutputScanline;
                  for i:=0 to ImageWidth-1 do begin
                     xbgr^:=IECMYK2RGB(xcmyk^);
                     inc(xbgr);
                     inc(xcmyk);
                  end;
               end;
         end;
      ieCIELab:
      	case OutputColorSpace of
         	ieBGR:
            	begin
               	// ieCIELab->BGR
                  xlab:=PIELAB(InputScanline);
                  xbgr:=OutputScanline;
                  for i:=0 to ImageWidth-1 do begin
                     xbgr^:=IECIELAB2RGB(xlab^);
                     inc(xlab);
                     inc(xbgr);
                  end;
               end;
         end;
   end;
end;

procedure TImageEnIO.CreatePSFile(const nf:AnsiString);
begin
	fAborting:=False;
   fPS_stream:=TFileStream.Create(nf,fmCreate);
	fPS_handle:=IEPostScriptCreate(fPS_stream,fParams);
end;

procedure TImageEnIO.SaveToPS;
var
	Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	IEPostScriptSave(fPS_handle,fPS_stream,fIEBitmap,fParams,Progress);
end;

procedure TImageEnIO.ClosePSFile;
begin
	if fPS_handle<>nil then
		IEPostScriptClose(fPS_handle,fPS_stream);
   	FreeAndNil(fPS_stream);
   fPS_handle:=nil;
end;

procedure TImageEnIO.SyncSaveToStreamPS(Stream:TStream);
var
	Progress:TProgressRec;
begin
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   IEPostScriptSaveOneStep(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamPS(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamPS,Stream);
      exit;
   end;
   SyncSaveToStreamPS(Stream);
end;

procedure TImageEnIO.SaveToFilePS(const nf:AnsiString);
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFilePXM,nf);
      exit;
   end;
	fs:=TFileStream.Create(nf,fmCreate);
   try
   SyncSaveToStreamPS(fs);
   finally
   	FreeAndNil(fs);
   end;
end;

procedure TImageEnIO.CreatePDFFile(const nf:AnsiString);
begin
	fAborting:=False;
   fPDF_stream:=TFileStream.Create(nf,fmCreate);
	fPDF_handle:=IEPDFCreate(fParams);
end;

procedure TImageEnIO.SaveToPDF;
var
	Progress:TProgressRec;
begin
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
	IEPDFSave(fPDF_handle,fIEBitmap,fParams,Progress);
end;

procedure TImageEnIO.ClosePDFFile;
begin
	if fPDF_handle<>nil then
		IEPDFClose(fPDF_handle,fPDF_stream,fParams);
   	FreeAndNil(fPDF_stream);
   fPDF_handle:=nil;
end;

procedure TImageEnIO.SyncSaveToStreamPDF(Stream:TStream);
var
	Progress:TProgressRec;
begin
   try
	fAborting:=false;
   Progress.Aborting:=@fAborting;
   if not MakeConsistentBitmap([]) then
   	exit;
   if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   	fIEBitmap.PixelFormat:=ie24RGB;
   Progress.fOnProgress:=fOnProgress;
   Progress.Sender:=Self;
   IEPDFSaveOneStep(Stream,fIEBitmap,fParams,Progress);
   finally
   	DoFinishWork;
   end;
end;

procedure TImageEnIO.SaveToStreamPDF(Stream:TStream);
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveStream(self,fAsyncThreads,SaveToStreamPDF,Stream);
      exit;
   end;
   SyncSaveToStreamPDF(Stream);
end;

procedure TImageEnIO.SaveToFilePDF(const nf:AnsiString);
var
	fs:TFileStream;
begin
   if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then begin
      TIEIOThread.CreateLoadSaveFile(self,fAsyncThreads,SaveToFilePXM,nf);
      exit;
   end;
	fs:=TFileStream.Create(nf,fmCreate);
   try
   SyncSaveToStreamPDF(fs);
   finally
   	FreeAndNil(fs);
   end;
end;

{$ifdef IEINCLUDEDIRECTSHOW}
function TImageEnIO.GetDShowParams:TIEDirectShow;
begin
	if not assigned(fDShow) then begin
   	fDShow:=TIEDirectShow.Create;
      if assigned(fImageEnView) then begin
	      fDShow.SetNotifyWindow(fImageEnView.Handle,IEM_NEWFRAME,IEM_EVENT)
      end;
   end;
   result:=fDShow;
end;
{$endif}

procedure TImageEnIO.CheckDPI;
begin
	if fParams.DpiX<2 then fParams.DpiX:=gDefaultDPIX;
   if fParams.DpiY<2 then fParams.DpiY:=gDefaultDPIY;
end;

procedure TImageEnIO.ImportMetafile(const nf: AnsiString; Width,Height:integer; WithAlpha:boolean);
var
 l_FS: TFileStream;
begin
 l_FS := TFileStream.Create(nf, fmOpenRead);
 try
  ImportMetafile(l_FS, Width, Height, WithAlpha);
  fParams.fFileName := nf;
 finally
  FreeAndNil(l_FS);
 end;
end;

function TImageEnIO.InsertToStreamTIFF(aStream: TStream): integer;
var
 Progress:TProgressRec;
begin
 // NB!
 // The Stream MUST be rewinded to TIFF's starting point.
 if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
 begin
  TIEIOThread.CreateLoadSaveStreamRetInt(self, fAsyncThreads, InsertToStreamTIFF, aStream);
  result:=-1;
  exit;
 end;
 try
  fAborting:=true;	// this allow fAborting=true when the file is not found (or not accessible)
  Progress.Aborting:=@fAborting;
  result:=0;
  if not MakeConsistentBitmap([]) then
   exit;
  if (fIEBitmap.pixelformat<>ie24RGB) and (fIEBitmap.PixelFormat<>ie1g) then
   fIEBitmap.PixelFormat:=ie24RGB;
  Progress.fOnProgress:=fOnProgress;
  Progress.Sender:=Self;
  fAborting:=false;
  result:=TIFFWriteStream(aStream,true,fIEBitmap,fParams,Progress);
 finally
  DoFinishWork;
 end;
end;

initialization
	DefGIF_LZWDECOMPFUNC:=GIFLZWDecompress;
   DefGIF_LZWCOMPFUNC:=GIFLZWCompress;
   DefTIFF_LZWDECOMPFUNC:=TIFFLZWDecompress;
   DefTIFF_LZWCOMPFUNC:=TIFFLZWCompress;
   DefTEMPPATH:='';
   IEInitFileFormats;
 	gAVIFILEinit:=false;
   (*$ifdef IEINCLUDESANE*)
   InitSANE;
   (*$endif*)
   {$ifdef IEINCLUDETWAIN}
  	iegTWainLogName:='';
   {$endif}
   {$ifdef IEDELPHI}
   wininet:=0;
   {$endif}
   {$ifdef IEREGISTERTPICTUREFORMATS}
   IERegisterFormats;
   {$endif}
   IEConvertColorFunction:=IEDefaultConvertColorFunction;

finalization
	{$ifdef IEREGISTERTPICTUREFORMATS}
	IEUnregisterFormats;
   {$endif}
	IEFreeFileFormats;
   (*$ifdef IEDELPHI*)
	if gAVIFILEinit then
		AviFileExit;
   if wininet<>0 then
   	FreeLibrary(wininet);
   (*$endif*)
   (*$ifdef IEINCLUDESANE*)
   ExitSANE;
   (*$endif*)
   {$ifdef IEINCLUDETWAIN}
   if iegTWainLogName<>'' then
   	closefile(iegTWainLogFile);
   {$endif}


end.

