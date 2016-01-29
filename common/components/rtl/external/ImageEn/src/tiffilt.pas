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

unit tiffilt;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses iekdef, Types, QGraphics, Classes, ImageEnProc,ImageEnIO,hyieutils,hyiedefs, SysUtils;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils;
(*$endif*)

// TIFF image load/save
procedure TIFFReadStream(Bitmap:TIEBitmap; Stream:TStream; var numi:integer; IOParams:TIOParamsVals; var Progress:TProgressRec; Preview:boolean; var AlphaChannel:TIEMask; TranslateBase:boolean; IgnoreAlpha:boolean; IsExifThumb:boolean);
function TIFFWriteStream(Stream:TStream; Ins:boolean; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec):integer;
function _EnumTIFFImStream(Stream:TStream):integer;
function _DeleteTIFFImStream(Stream:TStream; idx:integer):integer;
function _DeleteTIFFImStreamGroup(Stream:TStream; idxlist:pintegerarray; idxcount:integer):integer;
procedure _ExtractTIFFImStream(Stream:TStream; idx:integer; OutStream:TStream);
procedure _InsertTIFFImStream(Stream:TStream; ToInsert:TStream; idx:integer; OutStream:TStream);


// single tags load
function TIFFLoadTags(Stream:TStream; var numi:integer; ImageIndex:integer; var TIFFEnv:TTIFFEnv):boolean;
procedure TIFFFreeTags(var TIFFEnv:TTIFFEnv);
function TIFFFindTAG(IdTag:word; var TIFFEnv:TTIFFEnv):integer;
function TIFFGetDataLength(var TIFFEnv:TTIFFEnv; nTag:integer):integer;
function TIFFReadSingleValDef(var TIFFEnv:TTIFFEnv; ntag:integer; def:integer):integer;
function TIFFReadSingleRational(var TIFFEnv:TTIFFEnv; nTag:integer):double;
function TIFFReadRationalIndex(var TIFFEnv:TTIFFEnv; nTag:integer; idx:integer):double;
function TIFFReadIndexValN(var TIFFEnv:TTIFFEnv; nTag:integer; idx:integer):integer;
function TIFFReadArrayIntegers(var TIFFEnv:TTIFFEnv; var ar:pintegerarray; NTag:integer):integer;
function TIFFReadRawData(var TIFFEnv:TTIFFEnv; NTag:integer; var Size:integer):pointer;
function TIFFReadString(var TIFFEnv:TTIFFEnv; NTag:integer):string;
function TIFFReadMiniString(var TIFFEnv:TTIFFEnv; NTag:integer):string;
function TIFFReadIFD(imageindex:integer; Offset:integer; var TIFFEnv:TTIFFEnv; var numi:integer):boolean;


implementation

uses giffilter, tifccitt, imageenview, ieview, jpegfilt, neurquant, l3MemUtils;

{$R-}

const
	RATMUL=1000000;

 tcUncompressed = 1;
 tcCCITT1D      = 2;              
 tcG3FAX        = 3;
 tcG4FAX        = 4;              
 tcLZW          = 5;              
 tcOldJPEG      = 6;              
 tcJPEG         = 7;              
 tcPackbits     = $8005;
 tcZIP          = $80B2;

 ZLIB_VERSION = '1.1.4';
                                  
type

   //TIntegerArray = array [0..Maxint div 16] of integer;
   //PIntegerArray = ^TIntegerArray;

   // Colormap item
   TTIFFColor = packed record
   	R,G,B:word;
   end;

   // Colormap
   TTIFFRGBArray = array [0..Maxint div 16] of TTIFFColor;
   PTIFFRGBArray = ^TTIFFRGBArray;

   TTIFFVars = record
	   ImageWidth, ImageHeight:integer;
	   SamplesPerPixel:integer;
	   BitsPerSample:integer;
	   RowsPerStrip:integer;
	   TileWidth,TileLength:integer;
	   PhotometricInterpretation:word;
	   PlanarConfiguration:word;
	   Orientation:word;
	   Compression:word;
   	StripOffsets:PIntegerArray;
      StripOffsets_Num:integer;		// numero elementi in StripOffsets
      StripByteCounts:PIntegerArray;
      StripByteCounts_Num:integer;	// numero elementi in StripByteCounts
      TileOffsets:PIntegerArray;
      TileOffsets_Num:integer;		// numero elementi in TileOffsets
      TileByteCounts:PIntegerarray;
      TileByteCounts_Num:integer;	// numero elementi in TileByteCounts
      ColorMap:PRGBROW;			// Colormap (dim=2^BitsPerSample)
      ColorMap_Num:integer;			// numero entries in Colormap (2^BitsPerSample)
      TransferFunction:PTIFFRGBArray;
      Transferfunction_Num:integer;	// numero elementi TransferFunction
      ResolutionUnit:integer;			// unitа di misura
      XResolution:double;				// risoluzione X
      YResolution:double;				// risoluzione Y
      Predictor:integer;
      JPEGTables:pointer;				// compression tables (JPEG 7)
      JPEGTablesSize:integer;			// size in bytes of JPEGTables
      T4Options:integer;
      T6Options:integer;
      FillOrder:integer;
      XPosition:double;
      YPosition:double;
      DocumentName:string;
		ImageDescription:string;
		PageName:string;
      PageNumber:integer;
      PageCount:integer;
      Software:string;
      InkSet:integer;
      NumberOfInks:integer;
      DotRange:array [0..7] of integer;
      // OLD Jpeg fields
		JPEGProc:integer;
      JPEGInterchangeFormat:integer;
      JPEGInterchangeFormatLength:integer;
      JPEGRestartInterval:integer;
      JPEGLosslessPredictors:array [0..6] of integer;
      JPEGPointTransforms:array [0..6] of integer;
      JPEGQTables:array [0..6] of integer;
      JPEGDCTables:array [0..6] of integer;
      JPEGACTables:array [0..6] of integer;
      // no tiff fields
      LZWDecompFunc:TTIFFLZWDecompFunc;	// funzione di decompressione LZW
      intel:boolean;
      RefParams:TIOParamsVals;
      // Alpha
      AlphaChannel:TIEMask;
      IgnoreAlpha:boolean;
      ExtraSamples:integer;
   end;

procedure Decompress1(var TIFFVars:TTIFFVars; outbuf:TIEBitmap; baserow:integer; basecol:integer; xbuf:pbyte; sz:integer; Width,Height:integer; var Progress:TProgressRec); forward;
procedure Decompress2(var TIFFVars:TTIFFVars; outbuf:TIEBitmap; baserow:integer; xbuf1,xbuf2,xbuf3:pbyte; sz1,sz2,sz3:integer; Width,Height:integer; var Progress:TProgressRec); forward;
procedure Strips2Bitmap(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; var Bitmap:TIEBitmap; var Progress:TProgressRec); forward;
procedure Tiles2Bitmap(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; var Bitmap:TIEBitmap; var Progress:TProgressRec); forward;


type
 // portions of ZLib
 TZAlloc = function (opaque: Pointer; items, size: Integer): Pointer;
 TZFree  = procedure (opaque, block: Pointer);
 //TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);

 TZStreamRec = packed record
   next_in  : PAnsiChar;     // next input byte
   avail_in : Longint;   // number of bytes available at next_in
   total_in : Longint;   // total nb of input bytes read so far

   next_out : PAnsiChar;     // next output byte should be put here
   avail_out: Longint;   // remaining free space at next_out
   total_out: Longint;   // total nb of bytes output so far

   msg      : PAnsiChar;     // last error message, NULL if no error
   state    : Pointer;   // not visible by applications

   zalloc   : TZAlloc;   // used to allocate the internal state
   zfree    : TZFree;    // used to free the internal state
   opaque   : Pointer;   // private data object passed to zalloc and zfree

   data_type: Integer;   // best guess about the data type: ascii or binary
   adler    : Longint;   // adler32 value of the uncompressed data
   reserved : Longint;   // reserved for future use
 end;

const
 _z_errmsg: array[0..9] of PAnsiChar = (
  'need dictionary',      // Z_NEED_DICT      (2)
  'stream end',           // Z_STREAM_END     (1)
  '',                     // Z_OK             (0)
  'file error',           // Z_ERRNO          (-1)
  'stream error',         // Z_STREAM_ERROR   (-2)
  'data error',           // Z_DATA_ERROR     (-3)
  'insufficient memory',  // Z_MEM_ERROR      (-4)
  'buffer error',         // Z_BUF_ERROR      (-5)
  'incompatible version', // Z_VERSION_ERROR  (-6)
  ''
  );

{$L inflate.obj}
{$L infblock.obj}
{$L inftrees.obj}
{$L infcodes.obj}
{$L infutil.obj}
{$L inffast.obj}
{$L adler32.obj}

function inflateInit_(var strm: TZStreamRec; version: PAnsiChar;  recsize: Integer): Integer; external;
function inflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function inflateEnd(var strm: TZStreamRec): Integer; external;

function zcalloc(opaque: Pointer; items, size: Integer): Pointer;
begin
 Tl3MemUtils.GetLocalMem(Result, Items * Size);
end;

procedure zcfree(opaque, block: Pointer);
begin
 Tl3MemUtils.FreeLocalMem(block);
end;

procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl;
begin
  FillChar(P^, count, B);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

////////////////////////////////////////////////////////////////////////////////////
// scambia WORD se sc=true
function scSwapWord(i:word; sc:boolean):word;
begin
	if sc then
	   result:=hibyte(i) or (lobyte(i) shl 8)
   else
   	result:=i;
end;

////////////////////////////////////////////////////////////////////////////////////
// scambia DWORD se sc=true
function scSwapDWord(i:integer;sc:boolean):integer;
begin
	if sc then begin
      asm
         mov EAX,i
         bswap EAX
         mov @result,EAX
      end;
   end else
   	result:=i;
end;

function ReorderTagsCompare(Item1, Item2: Pointer): Integer;
begin
 result := PTIFFTAG(Item1)^.IdTag - PTIFFTAG(Item2)^.IdTag;
end;

// reorder tags
procedure ReorderTags(imed:TList);
begin
	imed.Sort(ReorderTagsCompare);
end;


////////////////////////////////////////////////////////////////////////////////////
// trova indice tag (-1=non trovato)
function TIFFFindTAG(IdTag:word; var TIFFEnv:TTIFFEnv):integer;
begin
	for result:=0 to TIFFEnv.NumTags-1 do
  if TIFFEnv.IFD^[result].IdTag=IdTag then
  	exit;
	result:=-1;
end;

function TIFFGetDataLength(var TIFFEnv:TTIFFEnv; nTag:integer):integer;
var
   t:integer;
begin
	result:=0;	// default
	t:=TIFFFindTAG(ntag,TIFFEnv);
   if t>=0 then
		with TIFFEnv do
      	result:=TIFFEnv.IFD^[t].DataNum;
end;

//////////////////////////////////////////////////////////////////////////////////////
// legge una SHORT o un LONG da nTag (specifica del numero tag)
// def: и il valore di default
function TIFFReadSingleValDef(var TIFFEnv:TTIFFEnv; ntag:integer; def:integer):integer;
var
	t:integer;
begin
	t:=TIFFFindTAG(ntag,TIFFEnv);
   if t>=0 then begin
	   result:=TIFFEnv.IFD^[t].DataPos;
      if TIFFEnv.Intel then begin
      	// intel
         if (TIFFEnv.IFD^[t].DataType=3) then
         	result:=result and $ffff;
      end else begin
      	// non intel
 			if (TIFFEnv.IFD^[t].DataType=3) then
         	result:=result shr 16;
      end;
   end else
   	result:=def;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge una SHORT o un LONG da TAG
function ReadSingleIntTag(var TIFFEnv:TTIFFEnv; Tag:TTIFFTAG):integer;
begin
   result:=Tag.DataPos;
   if TIFFEnv.Intel then begin
      // intel
		if (Tag.DataType=3) then
      	result:=result and $ffff;
   end else begin
      // non intel
      if (Tag.DataType=3) then
         result:=result shr 16;
   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge un RATIONAL da nTag (specifica del numero tag)
// note: rest. un double
function TIFFReadSingleRational(var TIFFEnv:TTIFFEnv; nTag:integer):double;
var
	num,den:longint;
   t:integer;
begin
	result:=0;	// default
	t:=TIFFFindTAG(ntag,TIFFEnv);
 if t>=0 then
		with TIFFEnv do
  begin
	 	Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos,soFromBeginning);
	  Stream.Read(num,sizeof(dword));	// numeratore
	  Stream.Read(den,sizeof(dword));	// denominatore
	  if not TIFFEnv.Intel then
   begin
	  	num:=IESwapDWord(num);
	   den:=IESwapDWord(den);
	  end;
	  if den=0 then
    den:=1;
	  result:=num/den;
	 end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge un RATIONAL da nTag (specifica del numero tag)
// note: rest. un double
function TIFFReadRationalIndex(var TIFFEnv:TTIFFEnv; nTag:integer; idx:integer):double;
var
	num,den:longint;
   t:integer;
begin
	result:=0;	// default
	t:=TIFFFindTAG(ntag,TIFFEnv);
   if t>=0 then
		with TIFFEnv do begin
      	if idx<TIFFEnv.IFD^[t].DataNum then begin
            Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos+idx*sizeof(dword)*2,soFromBeginning);
            Stream.Read(num,sizeof(dword));	// numeratore
            Stream.Read(den,sizeof(dword));	// denominatore
            if not TIFFEnv.Intel then begin
               num:=IESwapDWord(num);
               den:=IESwapDWord(den);
            end;
            if den=0 then den:=1;
            result:=num/den;
         end;
	   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge SHORT/LONG indicizzata (idx) da ntag
function TIFFReadIndexValN(var TIFFEnv:TTIFFEnv; nTag:integer; idx:integer):integer;
var
	ss:word;
 t:integer;
begin
	result:=0;	// default
	t:=TIFFFindTAG(ntag,TIFFEnv);
 if t >= 0 then
		with TIFFEnv do
  begin
	 	if TIFFEnv.IFD^[t].DataType=4 then
   begin
	   // LONG
		  Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos+idx*sizeof(integer),soFromBeginning);
		  Stream.Read(result,sizeof(integer));
		  if not TIFFEnv.Intel then
		  	result:=IESwapDWord(result);
	  end
   else
   if TIFFEnv.IFD^[t].DataType=3 then
   begin
	  	// SHORT
    if TIFFEnv.IFD^[t].DataNum=1 then
     result:=ReadSingleIntTag(TIFFEnv,TIFFEnv.IFD^[t])
    else
     if TIFFEnv.IFD^[t].DataNum=2 then
     begin
      result:=TIFFEnv.IFD^[t].DataPos;
      if TIFFEnv.Intel then
      begin
       // intel
       if idx=0 then
        result:=result and $ffff	// get low
       else
        if idx=1 then
         result:=result shr 16;		// get high
      end
      else
      begin
       // non intel
       if idx=0 then
        result:=result shr 16		// get high
       else
       if idx=1 then
        result:=result and $ffff;	// get low
      end;
     end
     else
     begin
      Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos+idx*sizeof(word),soFromBeginning);
      Stream.Read(ss,sizeof(word));
      if not TIFFenv.Intel then
       ss:=IESwapWord(ss);
      result:=ss;
     end;
	  end;
	 end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge SHORT/LONG indicizzata (idx) da TAG
function ReadIndexVal(var TIFFEnv:TTIFFEnv; Tag:TTIFFTAG; idx:integer):integer;
var
	ss:word;
begin
	with TIFFEnv do begin
   	if Tag.DataType=4 then begin
      	// LONG
	   	Stream.Seek(StreamBase+Tag.DataPos+idx*sizeof(integer),soFromBeginning);
	      Stream.Read(result,sizeof(integer));
	      if not TIFFEnv.Intel then
	      	result:=IESwapDWord(result);
      end else if Tag.DataType=3 then begin
      	// SHORT
         if Tag.DataNum=1 then
				result:=ReadSingleIntTag(TIFFEnv,Tag)
         else if Tag.DataNum=2 then begin
         	result:=Tag.DataPos;
            if TIFFEnv.Intel then begin
            	// intel
            	if idx=0 then
               	result:=result and $ffff	// get low
               else if idx=1 then
			         result:=result shr 16;		// get high
            end else begin
            	// non intel
            	if idx=0 then
               	result:=result shr 16		// get high
               else if idx=1 then
               	result:=result and $ffff;	// get low
            end;
         end else begin
            Stream.Seek(StreamBase+Tag.DataPos+idx*sizeof(word),soFromBeginning);
            Stream.Read(ss,sizeof(word));
            if not TIFFenv.Intel then
               ss:=IESwapWord(ss);
            result:=ss;
         end;
      end;
   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge array di integers
// ar: puntatore all'array (non allocare, liberare quando non piщ usato)
// NTag: numero del tag
// result: numero elementi
function TIFFReadArrayIntegers(var TIFFEnv:TTIFFEnv; var ar:pintegerarray; NTag:integer):integer;
var
	t,q:integer;
begin
	t:=TIFFFindTAG(NTag,TIFFEnv);
 if t<0 then
 	// non trovato
  result:=0
 else
 begin
 	result:=TIFFEnv.IFD^[t].DataNum;
  getmem(ar,sizeof(integer)*result);
		if result=1 then
  begin
  	// un solo valore
			ar^[0]:=ReadSingleIntTag(TIFFEnv,TIFFEnv.IFD^[t]);
  end
  else
  begin
  	// piщ valori
			for q:=0 to result-1 do
   	ar^[q]:=ReadIndexVal(TIFFenv,TIFFEnv.IFD^[t],q);
  end;
 end;
end;

////////////////////////////////////////////////////////////////////////////////////
// Legge un blocco UNDEFINED
// Rest. un puntatore al blocco dati (che deve essere liberato dal chiamante)
function TIFFReadRawData(var TIFFEnv:TTIFFEnv; NTag:integer; var Size:integer):pointer;
var
	t:integer;
begin
	t:=TIFFFindTAG(NTag,TIFFEnv);
   if t<0 then
   	// non trovato
      result:=nil
   else
		with TIFFEnv do begin
	   	Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos,soFromBeginning);
	      getmem(result,TIFFEnv.IFD^[t].DataNum);
	      Stream.Read(pbyte(result)^,TIFFEnv.IFD^[t].DataNum);
         Size:=TIFFEnv.IFD^[t].DataNum;
	   end;
end;

procedure LoadWang(var TIFFEnv:TTIFFEnv; Params:TIOParamsVals);
var
	t,buflen:integer;
   buf:pointer;
begin
	t:=TIFFFindTAG(32932,TIFFEnv);
   if t>=0 then
		with TIFFEnv do begin
	   	Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos,soFromBeginning);
	      getmem(buf,TIFFEnv.IFD^[t].DataNum);
	      Stream.Read(pbyte(buf)^,TIFFEnv.IFD^[t].DataNum);
         buflen:=TIFFEnv.IFD^[t].DataNum;
			Params.ImagingAnnot.LoadFromStandardBuffer(buf,buflen);
         freemem(buf);
	   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// read a string
function TIFFReadString(var TIFFEnv:TTIFFEnv; NTag:integer):string;
var
	t,l:integer;
begin
	t:=TIFFFindTAG(NTag,TIFFEnv);
   if t<0 then
   	// not found
      result:=''
   else
		with TIFFEnv do begin
	   	Stream.Seek(StreamBase+TIFFEnv.IFD^[t].DataPos,soFromBeginning);
         l:=TIFFEnv.IFD^[t].DataNum;
         if l<1048576 then begin	// maximum allowed strings of 1MByte 
            setlength(result,l);
            Stream.Read(result[1],l);
         end;
	   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// read a string of constant chars
function TIFFReadMiniString(var TIFFEnv:TTIFFEnv; NTag:integer):string;
var
	t,l:integer;
   v:dword;
begin
	t:=TIFFFindTAG(NTag,TIFFEnv);
   if t<0 then
   	// not found
      result:=''
   else
		with TIFFEnv do begin
	   	v:=TIFFEnv.IFD^[t].DataPos;
         l:=TIFFEnv.IFD^[t].DataNum;
         if (l>0) and (l<1048576) then begin
	         setlength(result,l);
            if l<5 then
               move(v,result[1],l);
         end;
	   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// read colormap
procedure ReadColorMap(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars);
var
	t,q:integer;
begin
	t:=TIFFFindTAG(320,TIFFEnv);
   if t<0 then
   	// not found
      TIFFVars.ColorMap_Num:=0
   else with TIFFVars do begin
      ColorMap_Num:=1 shl BitsPerSample;
      getmem(ColorMap,ColorMap_Num*sizeof(TRGB));
      for q:=0 to ColorMap_Num-1 do begin
         ColorMap^[q].R:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],q) shr 8;
         ColorMap^[q].G:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],ColorMap_Num+q) shr 8;
         ColorMap^[q].B:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],(ColorMap_Num*2)+q) shr 8;
      end;
   end;
end;

////////////////////////////////////////////////////////////////////////////////////
// legge TransferFunction
procedure ReadTransferFunction(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars);
var
	t,q:integer;
begin
	t:=TIFFFindTAG(301,TIFFEnv);
   if t<0 then
   	// non travata
      TIFFVars.TransferFunction_Num:=0
   else with TIFFVars do begin
   	TransferFunction_Num:=1 shl BitsPerSample;
   	getmem(TransferFunction,TransferFunction_Num*sizeof(TTIFFColor));
      for q:=0 to TransferFunction_Num-1 do begin
      	TransferFunction^[q].R:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],q*3);
			TransferFunction^[q].G:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],q*3+1);
         TransferFunction^[q].B:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],q*3+2);
      end;
   end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// legge BitsPerSample
// **** IMPLEMENTAZIONE:
// 	Restituisce solo il primo. Se ci sono piщ valori di BitsPerSampe diversi
// 	ritorna false
// return false on exception
function ReadBitsPerSample(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars):boolean;
var
	t: integer;
	w: word;
 q: integer;
begin
	result:=true;
	t:=TIFFFindTAG(258,TIFFEnv);
 if t<0 then
 	TIFFVars.BitsPerSample:=1	// default
 else
 begin
 	if TIFFEnv.IFD^[t].DataNum=1 then
  begin
 	 // un solo valore
   TIFFVars.BitsPerSample:=ReadSingleIntTag(TIFFEnv,TIFFEnv.IFD^[t]);
  end
  else
  begin
	 	TIFFVars.BitsPerSample:=-1;
			for q:=0 to TIFFEnv.IFD^[t].DataNum-1 do
   begin
				w:=ReadIndexVal(TIFFEnv,TIFFEnv.IFD^[t],q);
	   if (TIFFVars.BitsPerSample<>-1) and (TIFFVars.BitsPerSample<>w) then
    	result:=false;
	   TIFFVars.BitsPerSample:=w;
	  end;
  end;
 end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// read tiles
procedure Tiles2Bitmap(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; var Bitmap:TIEBitmap; var Progress:TProgressRec);
var
	q,sz:integer;
   buf:pbyte;
   row,col,basecol:integer;
begin
	with TIFFVars do begin
   	row:=0;
      col:=0;
      Progress.per1:=100/ImageHeight;
      Progress.per2:=100/TileOffsets_Num;
      Progress.val:=0;
      basecol:=0;
		if PlanarConfiguration=1 then begin
         bitmap.width:=bitmap.width+TileWidth;
         bitmap.height:=bitmap.height+TileLength;
			for q:=0 to TileOffsets_Num-1 do begin
            TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+TileOffsets^[q],soFromBeginning);
            if TileByteCounts_Num>q then
	           	sz:=TileByteCounts^[q]
            else
            	sz:=0;
            if sz=0 then sz:=TIFFenv.Stream.size-TileOffsets^[q];
            getmem(buf,sz);
            TIFFEnv.Stream.Read(buf^,sz);
            if bitmap.pixelformat=ie24RGB then
               basecol:=col*3
            else if bitmap.pixelformat=ie1g then
               basecol:=(col shr 3)
            else if (bitmap.pixelformat=ie8g) or (bitmap.PixelFormat=ie8p) then
            	basecol:=col
            else if (bitmap.pixelformat=ie16g) then
            	basecol:=col*2
            else begin
            	Progress.Aborting^:=true;
            	exit;
            end;
            Decompress1(TIFFVars,Bitmap,row,basecol,buf,sz,TileWidth,TileLength,Progress);	// compress strip (buffer)
            //
            freemem(buf);
            inc(col,TileWidth);
            if col>=ImageWidth then begin
            	col:=0;
	            inc(row,TileLength);
            end;
            //
            if Progress.Aborting^ then
            	break;
         end;
         bitmap.width:=ImageWidth;
         bitmap.height:=Imageheight;
      end else if PlanarConfiguration=2 then begin
      	// not supported
         Progress.Aborting^:=true;
         exit;
      end;
   end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// read strips
procedure Strips2Bitmap(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; var Bitmap:TIEBitmap; var Progress:TProgressRec);
var
	q,w,e,sz,sz1,sz2:integer;
   buf,buf1,buf2:pbyte;
   row:integer;
begin
	with TIFFVars do
 begin
 	row:=0;
  Progress.per1:=100/ImageHeight;
  Progress.per2:=100/StripOffsets_Num;
  Progress.val:=0;
		if PlanarConfiguration=1 then
  begin
   // consecutive channels

   // А не пытаются ли нас обмануть с StripByteCounts?
   // Если у нас один стрип и это изображение "один байт на пиксель" без компрессии
   if (StripByteCounts_Num = 1) and (SamplesPerPixel = 1) and (BitsPerSample = 8) and (Compression = 1) and
      (StripByteCounts^[0] <> ImageHeight*ImageWidth) then // и StripByteCounts не равен высоте на ширину
    StripByteCounts^[0] := ImageHeight*ImageWidth; // присвоим правильное значение

   for q:=0 to StripOffsets_Num-1 do
   begin
    TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+StripOffsets^[q],soFromBeginning);
    if StripByteCounts_Num>q then
	   	sz:=StripByteCounts^[q]
    else
    	sz:=0;
    if sz=0 then
     sz:=TIFFenv.Stream.size-StripOffsets^[q];
    if sz>0 then
    begin
     if sz > TIFFEnv.Stream.Size then
      raise EieImageReadError.Create('TIFF read: source stream is corrupted');
     getmem(buf,sz);
     sz:=TIFFEnv.Stream.Read(buf^,sz);
     Decompress1(TIFFVars,bitmap,row,0,buf,sz,ImageWidth,imin(RowsPerStrip,ImageHeight-row),Progress);	// decompress strip (buffer)
     freemem(buf);
    end;
    inc(row,RowsPerStrip);
    //
    if Progress.Aborting^ then
     break;
   end;
  end
  else
   if PlanarConfiguration=2 then
   begin
    // channels are on separate strips
    q:=0;
    e:=StripOffsets_Num div 3;
    while q<e do
    begin
     // canale 1
     sz:=StripByteCounts^[q];
     getmem(buf,sz);
     TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+StripOffsets^[q],soFromBeginning);
     sz:=TIFFEnv.Stream.Read(buf^,sz);
     // canale 2
     sz1:=StripByteCounts^[q+e];
     getmem(buf1,sz1);
     TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+StripOffsets^[q+e],soFromBeginning);
     sz1:=TIFFEnv.Stream.Read(buf1^,sz1);
     // canale 3
     sz2:=StripByteCounts^[q+e+e];
     getmem(buf2,sz2);
     TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+StripOffsets^[q+e+e],soFromBeginning);
     sz2:=TIFFEnv.Stream.Read(buf2^,sz2);
     inc(q);
     //
     w:=imin(RowsPerStrip,ImageHeight-row);
				 Decompress2(TIFFVars,bitmap,row,buf,buf1,buf2,sz,sz1,sz2,ImageWidth,w,Progress);	// decomprime striscia (buffer)
				//
     freemem(buf);
     freemem(buf1);
     freemem(buf2);
     inc(row,RowsPerStrip);
     //
     if Progress.Aborting^ then
      break;
    end; // while q<e do
   end; // if PlanarConfiguration=2 then
 end;
end;

function GetNextPixel(var theData: PByte; var thePos: Integer; aBPS: Integer): Byte;
var
 I: Integer;
 B: Byte;
begin
 // нам надо получить aBPS бит из байта по адресу theData, находящихся на позиции thePos
 // при этом надо обеспечить переход на следующий байт и сместить позицию
 // некратные степени 2-ки позиции и размер тоже должны нормально поддерживаться
 Assert(aBPS <= 8, 'ImageEn.TIFFilt - BitsPerSample > 8 is not supported for this format');
 Result := 0;
 B := theData^ shl (thePos - 1);
 for I := 1 to aBPS do
 begin
  Result := (Result shl 1) or ((B and $80) shr 7);
  Inc(thePos);
  if thePos > 8 then
  begin
   thePos := 1;
   Inc(theData);
   B := theData^;
  end
  else
   B := B shl 1;
 end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// Decomprime riga
// buf= buffer di output (se BitsPerSample>=8 e non c'и compressione punta direttamente
//			al buffer di input)
// xbuf= buffer di input (posizione corrente)
// xbuflen = length of xbuf
// Width= dimensione riga
// brow = dimensione riga in byte (decompressa, non scompattata)
// LZW = Id del decompressore LZW
// predbuf = buffer linea precedente per decompressione CCITT 2D (deve avere dimensione brow)
// CCITTposb = posizione prossimo bit da leggere per decompressione CCITT (intput/output)
// return false if aborting
function GetNextLine(var buf, xbuf: pbyte;
                         xbuflen:integer;
                         TIFFVars:TTIFFVars;
                         Width, brow:integer;
                         var LzwId:integer;
                         var theZRec: TZStreamRec;
                         predbuf: pbyte;
                         var CCITTposb:integer):boolean;
var
	z,v,v2,z2,cw:integer;
   buf2:pbyte;
   ra1,ra2,ra3,ra4,rp1,rp2,rp3,rp4:pbyte;
   dra1,dra2,dra3,drp1,drp2,drp3:pword;
 l_Pos: Integer;
begin
	result:=true;
	case TIFFVars.Compression of
  tcUncompressed:		// NO COMPRESSION
   begin
    if TIFFVars.BitsperSample>=8 then
     buf:=xbuf
    else
     CopyMemory(buf,xbuf,brow);
    inc(xbuf,brow);
   end;

  tcCCITT1D:		// HUFFMAN (TIFF: CCITT 1D)
   inc(xbuf,CCITTHuffmanGetLine(buf,xbuf,Width,TIFFVars.FillOrder));

  tcG3FAX:
   if (TIFFVars.T4Options and 1)=0 then
	   // CCITT 3 - 1D (TIFF: Group 3 Fax, oppure T.4)
    CCITTposb := _CCITTHuffmanGetLine(buf,xbuf,Width,CCITTposb,TIFFVars.FillOrder)
   else
   	// CCITT 3 - 2D (TIFF: Group 3 Fax, oppure T.4 - 2D)
    CCITTposb := CCITT3_2D_GetLine(buf,xbuf,xbuflen,Width,predbuf,CCITTposb,TIFFVars.FillOrder,(TIFFVars.T4Options and $4)<>0);

   tcG4FAX:
    // CCITT 4 (TIFF: Group 4 Fax, oppure T.6)
    CCITTposb := CCITT3_2D_GetLine(buf,xbuf,xbuflen,Width,predbuf,CCITTposb,TIFFVars.FillOrder,(TIFFVars.T4Options and $4)<>0);

   tcLZW:
  		// LZW
   	begin
    	buf2:=TIFFVars.LZWDecompFunc(xbuf, brow, LzwId);
     if buf2 <> nil then
      CopyMemory(buf,buf2,brow)
     else
      // aborting
      result:=false;
    end;

   	tcPackbits:// RLE PACKBITS
    	begin
      {$WARNINGS OFF}
     	buf2:=buf;
				  z := 0;	// reading position
      v := brow;
      cw := 0;
      while z < v do
      begin
					  if (shortint(xbuf^)>=0) and (shortint(xbuf^)<=127) then
       begin
        // read next shortint(xbuf^)+1 bytes
        v2:=shortint(xbuf^);
        inc(xbuf);
        for z2 := 0 to v2 do
        begin	// it isn't v2-1, because I have first removed v2+1
         if cw<brow then
	        	buf2^:=xbuf^;
         inc(buf2);
         inc(xbuf);
         inc(z);
         inc(cw);
        end;
					  end
       else
        if (shortint(xbuf^)>=-127) and (shortint(xbuf^)<=-1) then
        begin
         // ripete successivo byte per abs(shortint(xbuf^))+1 volte
						   v2:=-1*(shortint(xbuf^));	// vedi sopra perchи non c'и il +1
         inc(xbuf);
         for z2:=0 to v2 do
         begin
         	if cw<brow then
	         	buf2^:=xbuf^;
          inc(buf2);
          inc(z);
          inc(cw);
         end;
         inc(xbuf);
        end
        else
        	inc(xbuf);
      end; // while
      {$WARNINGS ON}
     end;

  tcZIP:
   begin
    theZRec.next_out  := PAnsiChar(buf);
    theZRec.avail_out := brow;
    if inflate(theZRec, 0) < 0 then
     Result := False; // decompression error - aborting
   end;
 end; //case

 if TIFFVars.PhotometricInterpretation = 3 then // у нас палитра
 begin
  if TIFFVars.BitsPerSample < 8 then // надо распихать битовые семплы в байты (потому что оно так устроено)
  begin
   buf2 := allocmem(width);
   ra1 := buf;
   for z := 0 to width-1 do
    pbytearray(buf2)^[z] := GetNextPixel(ra1, l_Pos, TIFFVars.BitsPerSample);
   copymemory(buf, buf2, width);
   freemem(buf2);
  end;
 end
 else
 if TIFFVars.BitsPerSample=4 then
 begin
  // scompatta nibble in byte
  v:=brow*2-1;
  v2:=brow-1;
  while v>=0 do
  begin
   pbytearray(buf)^[v]:=pbytearray(buf)^[v2] and $0F;
   dec(v);
   pbytearray(buf)^[v]:=(pbytearray(buf)^[v2] and $F0) shr 4;
   dec(v);
   dec(v2);
  end;
 end
 else
 if (TIFFVars.PhotometricInterpretation < 2) and
    (TIFFVars.BitsPerSample > 1) and
    (TIFFVars.BitsPerSample < 8) and
    ((TIFFVars.Compression = tcUncompressed) or (TIFFVars.Compression > tcG4FAX)) then
 begin
  // scompatta gruppi di BitsPerSample bit in byte
  buf2:=allocmem(width);
  ra1:=buf2;
  v:=0;
  for z := 0 to width*TIFFVars.BitsPerSample-1 do
  begin
   // Это очень кривой код. Предполагается группировать семплы в байты (непонятно зачем, кстати), но
   // используются функции, подходящие только для чёрно-белых изображений, причём проверяется один пиксель, а не
   // стрип. В общем, если какое-то ч/б изображение будет читаться неверно, сюда нужно обратить пристальное внимание
   if _GetPixelbw(buf,z)<>0 then
    ra1^:=ra1^ or (1 shl (TIFFVars.BitsPerSample-1-v));
   inc(v);
   if v = TIFFVars.BitsPerSample then
   begin
    v:=0;
    inc(ra1);
   end;
  end;
  copymemory(buf,buf2,width);
  freemem(buf2);
 end;

 if (TIFFVars.Predictor=2) and ((TIFFVars.Compression = tcLZW) or (TIFFVars.Compression = tcZIP)) then
 begin
  // Predictor
  if (TIFFVars.BitsPerSample=8) and (TIFFVars.SamplesPerPixel=1) then
  begin
   // 8 bits per sample - 1 sample per pixel
   ra1:=@(pbytearray(buf)^[1]);
   rp1:=buf;
   for z:=1 to Width-1 do
   begin
    inc(ra1^,rp1^);
    inc(ra1);
    inc(rp1);
   end;
  end
  else
  if (TIFFVars.BitsPerSample=8) and (TIFFVars.SamplesPerPixel=3) then
  begin
   // 8 bits per sample - 3 samples per pixel
   ra1:=@(pbytearray(buf)^[3]);
   ra2:=@(pbytearray(buf)^[4]);
   ra3:=@(pbytearray(buf)^[5]);
   rp1:=buf;
   rp2:=@(pbytearray(buf)^[1]);
   rp3:=@(pbytearray(buf)^[2]);
   for z:=1 to width-1 do
   begin
    inc(ra1^,rp1^);	inc(ra1,3); inc(rp1,3);
    inc(ra2^,rp2^);	inc(ra2,3); inc(rp2,3);
    inc(ra3^,rp3^);	inc(ra3,3); inc(rp3,3);
   end;
  end
  else
  if (TIFFVars.BitsPerSample=16) and (TIFFVars.SamplesPerPixel=3) then
  begin
   // 16 bits per sample - 3 samples per pixel
   dra1:=@(pwordarray(buf)^[3]);
   dra2:=@(pwordarray(buf)^[4]);
   dra3:=@(pwordarray(buf)^[5]);
   drp1:=pword(buf);
   drp2:=@(pwordarray(buf)^[1]);
   drp3:=@(pwordarray(buf)^[2]);
   for z:=1 to width-1 do
   begin
    inc(dra1^,drp1^);	inc(dra1,3); inc(drp1,3);
    inc(dra2^,drp2^);	inc(dra2,3); inc(drp2,3);
    inc(dra3^,drp3^);	inc(dra3,3); inc(drp3,3);
   end;
  end
  else
  if (TIFFVars.BitsPerSample=8) and (TIFFVars.SamplesPerPixel=4) then
  begin
   // 8 bits per sample - 4 samples per pixel
   ra1:=@(pbytearray(buf)^[4]);
   ra2:=@(pbytearray(buf)^[5]);
   ra3:=@(pbytearray(buf)^[6]);
   ra4:=@(pbytearray(buf)^[7]);
   rp1:=buf;
   rp2:=@(pbytearray(buf)^[1]);
   rp3:=@(pbytearray(buf)^[2]);
   rp4:=@(pbytearray(buf)^[3]);
   for z:=1 to width-1 do
   begin
    inc(ra1^,rp1^);	inc(ra1,4); inc(rp1,4);
    inc(ra2^,rp2^);	inc(ra2,4); inc(rp2,4);
    inc(ra3^,rp3^);	inc(ra3,4); inc(rp3,4);
    inc(ra4^,rp4^);	inc(ra4,4); inc(rp4,4);
   end;
  end;
 end;

 if (TIFFVars.BitsPerSample=4) and (TIFFVars.PhotometricInterpretation<=1) then begin
    // immagine (4 bit, 16 livelli) a livelli di grigio, trasforma in 8 bit
    buf2:=buf;
    z:=0;
    v:=brow*2;
    while z<v do begin
      buf2^:=buf2^ shl 4;
       inc(buf2);
       inc(z);
    end;
 end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// Converte CMYK a RGB - La conversione non tiene conto delle caratteristiche del
// dispositivo per cui и stato calcolato il valore CMYK
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

procedure InitZRec(var theRec: TZStreamRec; aBuf: PAnsiChar; aSize: Integer);
begin
 // init ZLib
 FillChar(theRec, SizeOf(theRec), #0);
 theRec.next_in  := aBuf;
 theRec.avail_in := aSize;
 inflateInit_(theRec, ZLIB_VERSION, SizeOf(theRec));
end;

// decompress buffer (PlanarConfiguration=1)
// baserow = first row to fill in outbuf (y coordinate of the subimage)
// basecol = first col x 3 to fill in outbuf (x coordinate X 3 of the subimage)
// xbuf = compressed data
// sz = length of uncompressed data
// Width = width of the sub image (in pixel)
// Height = height of the sub image (in pixel)
procedure Decompress1(var TIFFVars:TTIFFVars; outbuf:TIEBitmap; baserow:integer; basecol:integer; xbuf:pbyte; sz:integer; Width,Height:integer; var Progress:TProgressRec);
var
	q,w,i,e:integer;
 px:PRGB;
 pw:pword;
 buf,zbuf,predbuf,pxx,pb:pbyte;
 wbuf:pword;
 brow:integer;	// dimensione in byte di una riga (decompressa, non scompattata)
 CCITTposb:integer;
 inv:boolean;
 LzwId:integer;
 hasalpha:boolean;
 ms,tbs:TMemoryStream;
 tmpBMP:TIEBitmap;
 nullpr:TProgressRec;
 raw:boolean;
 ldpix,ldpiy:integer;
 l_Col: Integer;
 l_IsMolli: Boolean;
 l_ZRec   : TZStreamRec;
begin
 predbuf:=nil;
	// calc brow
 if TIFFVars.PlanarConfiguration=1 then
	 brow:=trunc(Width*TIFFVars.SamplesPerPixel*(TIFFVars.BitsPerSample / 8))
 else
 	brow:=trunc(Width*(TIFFVars.BitsPerSample / 8));
 if ((TIFFVars.BitsPerSample=4) and (Width and 1 <>0)) or
    ((TIFFVars.BitsPerSample=1) and (Width mod 8 <>0)) then
 	inc(brow);
	//
 LzwId:=0;	// initialize Id of LZW compressor
 //

 // Дальше идут различные варианты декомпрессии в зависимости от исходных параметров

 if TIFFVars.Compression = tcZIP then // init ZLib
  InitZRec(l_ZRec, PAnsiChar(xbuf), sz);

 if (TIFFVars.Compression=7) and (TIFFVars.JPEGTables=nil) then
 begin
 	// jpeg compression (DRAFT TIFF Technical Note #2), without jpeg tables
		ms:=TMemoryStream.Create;
  ms.Write(xbuf^,sz);
  ms.Position:=0;
  tmpBMP:=TIEBitmap.Create;
  tmpBMP.Allocate(Width,Height,ie24RGB);
  if (TIFFVars.StripOffsets_Num=1) or (TIFFVars.TileOffsets_Num=1) then
  	nullpr:=Progress
  else
  begin
   with Progress do
   begin
    inc(val);
    if assigned(fOnProgress) then
     fOnProgress(Sender,trunc(per2*val));
   end;
	  nullpr.fOnProgress:=nil;
	  nullpr.Aborting:=Progress.Aborting;
  end;
  //raw:= TIFFVars.PhotometricInterpretation=2;  // saved as native RGB
  raw:=false;
  // save dpi because ReadJPegStream overwrite them
  ldpix:=TIFFVars.RefParams.DpiX;
  ldpiy:=TIFFVars.RefParams.DpiY;
		ReadJPegStream(ms,nil,tmpBMP,TIFFVars.RefParams,nullpr,false,raw);
  TIFFVars.RefParams.DpiX:=ldpix;
  TIFFVars.RefParams.DpiY:=ldpiy;

  if not nullpr.Aborting^ then
  begin
   if raw then
    for q:=0 to tmpBMP.Height-1 do
    begin
     px:=tmpBMP.Scanline[q];
     _BGR2RGB(px,tmpBMP.Width);
    end;
   tmpBMP.CopyRectTo(outbuf,0,0,basecol div 3,baserow,Width,Height);
  end;
  tmpBMP.free;
  ms.free;
 end
 else

 if (TIFFVars.Compression = 7) and (TIFFVars.JPEGTables <> nil) then
 begin
  // jpeg compression (DRAFT TIFF Technical Note #2), with jpeg tables
  ms:=TMemoryStream.Create;
  ms.Write(xbuf^,sz);
  ms.Position:=0;
  tbs:=TMemoryStream.Create;
  tbs.Write(pbyte(TIFFVars.JPEGTables)^,TIFFVars.JPEGTablesSize);
  tbs.Position:=0;
  tmpBMP:=TIEBitmap.Create;
  tmpBMP.Allocate(Width,Height,ie24RGB);
  if (TIFFVars.StripOffsets_Num=1) or (TIFFVars.TileOffsets_Num=1) then
   nullpr:=Progress
  else
  begin
   with Progress do
   begin
    inc(val);
    if assigned(fOnProgress) then
     fOnProgress(Sender,trunc(per2*val));
   end;
   nullpr.fOnProgress:=nil;
   nullpr.Aborting:=Progress.Aborting;
  end;
  raw:= TIFFVars.PhotometricInterpretation=2;  // saved as native RGB
  ReadJPegStream(ms,tbs,tmpBMP,TIFFVars.RefParams,nullpr,false,raw);
  if not nullpr.Aborting^ then
  begin
   if raw then
    for q:=0 to tmpBMP.Height-1 do
    begin
     px:=tmpBMP.Scanline[q];
     _BGR2RGB(px,tmpBMP.Width);
    end;
    tmpBMP.CopyRectTo(outbuf,0,0,basecol div 3,baserow,Width,Height);
  end;
  tmpBMP.free;
  ms.free;
  tbs.free;
 end
 else

 if (TIFFVars.PhotometricInterpretation=2) and
    ((TIFFVars.SamplesPerPixel=3) or (TIFFVars.SamplesPerPixel=4)) and
    (TIFFVars.BitsPerSample=8) then
 begin
  // without ColorMap, RGB and 24/32 bit (8 per pixel)
  hasalpha:= ( ((TIFFVars.SamplesPerPixel=4) and (TIFFVars.ExtraSamples=2)) or
               ((TIFFVars.SamplesPerPixel=4) and (TIFFVars.PhotometricInterpretation=2)) )
             and (not TIFFVars.IgnoreAlpha);
  if hasalpha then
   TIFFVars.AlphaChannel.Full:=false;
  if (TIFFVars.Compression<>1) then
   getmem(buf,Width*TIFFVars.SamplesPerPixel);
  for q:=0 to Height-1 do
  begin
   if GetNextLine(buf,xbuf,sz,TIFFVars,Width,brow,LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    zbuf:=buf;
    px:=outbuf.Scanline[baserow+q]; inc(pbyte(px),basecol);
    if hasalpha then
    begin
     for w:=0 to Width-1 do
     begin
      px^:=PRGB(zbuf)^;
      bswap(px^.r,px^.b);
      inc(zbuf,3);
      TIFFVars.AlphaChannel.SetPixel(w,q+BaseRow,zbuf^);
      inc(zbuf);
      inc(px);
     end;
    end
    else
    begin
     for w:=0 to Width-1 do
     begin
      px^:=PRGB(zbuf)^;
      bswap(px^.r,px^.b);
      inc(zbuf,TIFFVars.SamplesPerPixel);
      inc(px);
     end;
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // Error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if (TIFFVars.Compression <> 1) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation = 2) and
    (TIFFVars.SamplesPerPixel = 4) and
    (TIFFVars.BitsPerSample = 2) then
 begin
  // RGB and 8 bit (2 bits per pixel)
  if (TIFFVars.Compression <> 1) then
   getmem(buf,Width * TIFFVars.SamplesPerPixel * 2);
  for q := 0 to Height - 1 do
  begin
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    pb:=PByte(buf);
    px:=outbuf.Scanline[baserow+q];
    inc(pbyte(px), basecol);
    for w:=0 to Width-1 do
    begin
     px^.r := ((pb^ shr 6) and $03) * 85;
     px^.g := ((pb^ shr 4) and $03) * 85;
     px^.b := ((pb^ shr 2) and $03) * 85;
     if not TIFFVars.IgnoreAlpha then
      TIFFVars.AlphaChannel.SetPixel(w, q + BaseRow, (pb^ and $03) * 85);
     inc(px);
     Inc(pb);
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // Error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if (TIFFVars.Compression<>1) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation=2) and
    ((TIFFVars.SamplesPerPixel=3) or (TIFFVars.SamplesPerPixel=4)) and
    (TIFFVars.BitsPerSample=16) then
 begin
  // without ColorMap, RGB and 48 bit (16 per pixel)
  if (TIFFVars.Compression<>1) then
   getmem(buf,Width*TIFFVars.SamplesPerPixel*2);
  for q:=0 to Height-1 do
  begin
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    pw:=pword(buf);
    px:=outbuf.Scanline[baserow+q]; inc(pbyte(px),basecol);
    if not TIFFVars.Intel then
    begin
     for w:=0 to Width-1 do
     begin
      px^.r:=pw^ and $FF; inc(pw);
      px^.g:=pw^ and $FF; inc(pw);
      px^.b:=pw^ and $FF; inc(pw);
      inc(px);
     end;
    end
    else
    begin
     for w:=0 to Width-1 do
     begin
      px^.r:=pw^ shr 8; inc(pw);
      px^.g:=pw^ shr 8; inc(pw);
      px^.b:=pw^ shr 8; inc(pw);
      inc(px);
     end;
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // Error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if (TIFFVars.Compression<>1) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation=2) and
    (TIFFVars.SamplesPerPixel=1) and
    (TIFFVars.BitsPerSample=16) then
 begin
  // without ColorMap, RGB e 16 bit
  if (TIFFVars.Compression <> 1) then
    getmem(buf,Width*TIFFVars.SamplesPerPixel);
  for q:=0 to Height-1 do
  begin
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    zbuf := buf;
    px := outbuf.Scanline[baserow+q]; inc(pbyte(px),basecol);
    for w:=0 to Width-1 do
    begin
     px^.r:=(pword(zbuf)^ shr 10) shl 3;
     px^.g:=((pword(zbuf)^ shr 5) and $1f) shl 3;
     px^.b:=(pword(zbuf)^ and $1f) shl 3;
     inc(zbuf,2);
     inc(px);
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // Error detected
    Progress.Aborting^:=True;
     break;
   end;
  end;
  if (TIFFVars.Compression<>1) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation = 3) and (TIFFVars.BitsPerSample <= 8) then
 begin
  // with ColorMap
  if (TIFFVars.SamplesPerPixel=2) and (TIFFVars.BitsPerSample=8) then
  begin
   // with alpha channel
   if ((TIFFVars.Compression <> 1)) then
    getmem(buf,Width*2);
   with TIFFVars do
    for q:=0 to Height-1 do
    begin
     px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
     if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
     begin
      zbuf:=buf;
      // RGB colormap
      for i:=0 to Width-1 do
      begin
       px^:= ColorMap^[zbuf^];
       inc(zbuf);
       TIFFVars.AlphaChannel.SetPixel(i,q+BaseRow,255-zbuf^);
       inc(zbuf);	//
       inc(px);
      end;
      // OnProgress
      with Progress do
      begin
       inc(val);
       if assigned(fOnProgress) then
        fOnProgress(Sender,trunc(per1*val));
      end;
      if Progress.Aborting^ then
       break;
     end
     else
     begin
      // error detected
      Progress.Aborting^:=True;
      break;
     end;
    end;
   if ((TIFFVars.Compression <> 1)) then
    freemem(buf);
  end
  else
  begin
   // without alpha channel
   if ((TIFFVars.Compression<>1)) or (TIFFVars.BitsperSample<8) then
    getmem(buf,Width);
   with TIFFVars do
    for q:=0 to Height-1 do
    begin
     px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
     if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
     begin
      zbuf:=buf;
      // RGB colormap
      if outbuf.PixelFormat=ie8p then
      begin
       for i:=0 to Width-1 do
       begin
        pbyte(px)^:= zbuf^;
        inc(zbuf);
        inc(pbyte(px));
       end;
      end
      else
      begin
       for i:=0 to Width-1 do
       begin
        try
         px^:= ColorMap^[zbuf^];
        except
         Random;
        end;
        inc(zbuf);
        inc(px);
       end;
      end;
      // OnProgress
      with Progress do
      begin
       inc(val);
       if assigned(fOnProgress) then
        fOnProgress(Sender,trunc(per1*val));
      end;
      if Progress.Aborting^ then
       break;
     end
     else
     begin
      // error detected
      Progress.Aborting^:=True;
      break;
     end;
    end;
    if ((TIFFVars.Compression<>1)) or (TIFFVars.BitsperSample<8) then
     freemem(buf);
  end;
 end
 else

 if (TIFFVars.PhotometricInterpretation<=1) and (TIFFVars.SamplesPerPixel=1) and
    ((TIFFVars.BitsPerSample=8) or (TIFFVars.BitsPerSample=4)) then
 begin
  // gray levels (8 bit)
  if ((TIFFVars.Compression <> 1)) or (TIFFVars.BitsperSample = 4) then
   getmem(buf,Width);
  for q:=0 to Height-1 do
  begin
   px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    zbuf:=buf;
    if outbuf.PixelFormat=ie8g then
    begin
     for w:=0 to Width-1 do
     begin
      pbyte(px)^:=zbuf^;
      inc(zbuf);
      inc(pbyte(px));
     end;
    end
    else
    begin
     if TIFFVars.PhotometricInterpretation=0 then
      for w:=0 to Width-1 do
      begin
       i:=255-zbuf^;
       px^.r:=i; px^.g:=i; px^.b:=i;
       inc(zbuf);
       inc(px);
      end
      else
       for w:=0 to Width-1 do
       begin
        px^.r:=zbuf^; px^.g:=zbuf^; px^.b:=zbuf^;
        inc(zbuf);
        inc(px);
       end;
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if ((TIFFVars.Compression <>1 )) or (TIFFVars.BitsperSample = 4) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation <= 1) and (TIFFVars.SamplesPerPixel = 1) and
    (TIFFVars.BitsPerSample=16) (*and (TIFFVars.Compression=1)*) then
 begin
  // gray levels (16 bit)
  if (TIFFVars.Compression <> 1) then
   getmem(buf,Width*2);
  // requested by one user
  l_IsMolli := copy(TIFFVars.Software, 1, 15) = 'Look@Molli v1.1';
  for q:=0 to Height-1 do
  begin
   px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    wbuf:=pword(buf);
    // requested by one user
    if l_IsMolli then
     e:=4
    else
     e:=8;
    //
    if outbuf.PixelFormat=ie16g then
    begin
     if TIFFVars.PhotometricInterpretation=0 then
      for w:=0 to Width-1 do
      begin
       wbuf^ := scSwapWord(wbuf^,not TIFFVars.Intel);
       pword(px)^:=65535-wbuf^;
       inc(wbuf);
       inc(pword(px));
      end
      else
       for w:=0 to Width-1 do
       begin
        wbuf^:=scSwapWord(wbuf^,not TIFFVars.Intel);
        pword(px)^:=wbuf^;
        inc(wbuf);
        inc(pword(px));
       end;
    end
    else
    begin
     if TIFFVars.PhotometricInterpretation=0 then
      for w:=0 to Width-1 do
      begin
       wbuf^:=scSwapWord(wbuf^,not TIFFVars.Intel);
       i:=(65535-wbuf^) shr e;
       px^.r:=i; px^.g:=i; px^.b:=i;
       inc(wbuf);
       inc(px);
      end
      else
       for w:=0 to Width-1 do
       begin
        wbuf^:=scSwapWord(wbuf^,not TIFFVars.Intel);
        i:=wbuf^ shr e;
        px^.r:=i; px^.g:=i; px^.b:=i;
        inc(wbuf);
        inc(px);
       end;
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if TIFFVars.Compression<>1 then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation <= 1) and (TIFFVars.SamplesPerPixel = 1) and
    (TIFFVars.BitsPerSample = 1) then
 begin
  // Bianco e nero
  getmem(buf,Width);
  getmem(predbuf,brow);	// linea precedente per decompressione CCITT 2D
  fillmemory(predbuf,brow,255);	// inizializza
  CCITTposb:=0;
  if ((TIFFVars.PhotometricInterpretation=0) and ((TIFFVars.Compression=1) or (TIFFVars.Compression>=5))) or
     ((TIFFVars.PhotometricInterpretation=1) and ((TIFFVars.Compression>2) and (TIFFVars.Compression<4))) then
   inv:=true
  else
   inv:=false;
  for q:=0 to Height-1 do
  begin
   px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    zbuf:=buf;
    pxx:=pbyte(px);
    case inv of
     true:
      for w:=0 to brow-1 do
      begin
       pxx^:=not zbuf^;
       inc(zbuf);
       inc(pxx);
      end;
     false:
      copymemory(pxx,zbuf,brow);
    end;
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  freemem(predbuf);
  freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation=5) and (TIFFVars.SamplesPerPixel=4) and
    (TIFFVars.BitsPerSample=8) then
 begin
  // CMYK
  if (TIFFVars.Compression <> 1) then
   getmem(buf,Width*4);
  for q:=0 to Height-1 do
  begin
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
    // invert CMYK values, because IEConvertColorFunction wants normal values
    pb:=buf;
    for w:=0 to Width*4-1 do
    begin
     pb^:=255-pb^;
     inc(pb);
    end;
    IEConvertColorFunction(buf,ieCMYK,px,ieBGR,Width);
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if (TIFFVars.Compression <> 1) then
   freemem(buf);
 end
 else

 if (TIFFVars.PhotometricInterpretation=8) and (TIFFVars.SamplesPerPixel=3) and
    (TIFFVars.BitsPerSample=8) then
 begin
  // CIE L*a*b*
  if (TIFFVars.Compression<>1) then
   getmem(buf,Width*3);
  for q:=0 to Height-1 do
  begin
   if GetNextLine(buf, xbuf, sz, TIFFVars, Width, brow, LzwId, l_ZRec, predbuf, CCITTposb) then
   begin
    //lab:=PIELAB(buf);
    px:=outbuf.scanline[baserow+q]; inc(pbyte(px),basecol);
    IEConvertColorFunction(buf,ieCIELab,px,ieBGR,Width);
    // OnProgress
    with Progress do
    begin
     inc(val);
     if assigned(fOnProgress) then
      fOnProgress(Sender,trunc(per1*val));
    end;
    if Progress.Aborting^ then
     break;
   end
   else
   begin
    // error detected
    Progress.Aborting^:=True;
    break;
   end;
  end;
  if (TIFFVars.Compression<>1) then
   freemem(buf);
 end;
 if TIFFVars.Compression = tcLZW then // free LZW compressor
  TIFFVars.LZWDecompFunc(nil,0,LzwId);

 if TIFFVars.Compression = tcZIP then // free ZLib
  inflateEnd(l_ZRec);
end;

// decompress buffer (PlanarConfiguration=2)
procedure Decompress2(var TIFFVars:TTIFFVars; outbuf:TIEBitmap; baserow:integer; xbuf1,xbuf2,xbuf3:pbyte; sz1,sz2,sz3:integer; Width,Height:integer; var Progress:TProgressRec);
var
	q,w:integer;
   px:PRGB;
   buf1,buf2,buf3,zbuf1,zbuf2,zbuf3,predbuf:pbyte;
   LZW1,LZW2,LZW3:integer;
   l_ZRec1, l_ZRec2, l_ZRec3: TZStreamRec;
   brow:integer;	// size in byte of one row (decompressed, not compacted)
   CCITTposb:integer;
begin
   predbuf:=nil;
	// calc brow
  	brow:=trunc(Width*(TIFFVars.BitsPerSample / 8));
   if (TIFFVars.BitsPerSample=4) and (Width and 1 <>0) then
   	inc(brow);
	// init Id LZW decompressor
   LZW1:=0;
   LZW2:=0;
   LZW3:=0;

 if TIFFVars.Compression = tcZIP then
 begin
  // init ZLib buffers
  InitZRec(l_ZRec1, PAnsiChar(xbuf1), sz1);
  InitZRec(l_ZRec2, PAnsiChar(xbuf2), sz2);
  InitZRec(l_ZRec3, PAnsiChar(xbuf3), sz3);
 end;

	if (TIFFVars.PhotometricInterpretation=2) and (TIFFVars.SamplesPerPixel=3) and
     	(TIFFVars.BitsPerSample=8) then begin
     	// without ColorMap, RGB e 24 bit (8 per pixel)
      if TIFFVars.Compression<>1 then begin
      	getmem(buf1,Width);
         getmem(buf2,Width);
         getmem(buf3,Width);
      end;
      for q:=0 to Height-1 do begin
         px:=outbuf.scanline[baserow+q];
         if not GetNextLine(buf1, xbuf1, sz1, TIFFVars, Width, brow, LZW1, l_ZRec1, predbuf, CCITTposb) then begin
         	Progress.Aborting^:=True;
            break;
         end;
         zbuf1:=buf1;
         if not GetNextLine(buf2, xbuf2, sz2, TIFFVars, Width, brow, LZW2, l_ZRec2, predbuf, CCITTposb) then begin
         	Progress.Aborting^:=True;
            break;
         end;
         zbuf2:=buf2;
         if not GetNextLine(buf3, xbuf3, sz3, TIFFVars, Width, brow, LZW3, l_ZRec3, predbuf, CCITTposb) then begin
         	Progress.Aborting^:=True;
            break;
         end;
         zbuf3:=buf3;
        	for w:=0 to Width-1 do
         begin
         	px^.r:=zbuf1^; inc(zbuf1);
          px^.g:=zbuf2^; inc(zbuf2);
          px^.b:=zbuf3^; inc(zbuf3);
          inc(px);
         end;
         // OnProgress
         with Progress do begin
	         inc(val);
	         if assigned(fOnProgress) then
	         	fOnProgress(Sender,trunc(per1*val));
         end;
         if Progress.Aborting^ then
            break;
      end;
      if TIFFVars.Compression <> 1 then
      begin
      	freemem(buf1);
       freemem(buf2);
       freemem(buf3);
      end;
   end;
  //
  if TIFFVars.Compression = tcLZW then
  begin
   // free LZW decompressor
   TIFFVars.LZWDecompFunc(nil,0,LZW1);
   TIFFVars.LZWDecompFunc(nil,0,LZW2);
   TIFFVars.LZWDecompFunc(nil,0,LZW3);
  end;

  if TIFFVars.Compression = tcZIP then
  begin
   // free ZLib
   inflateEnd(l_ZRec1);
   inflateEnd(l_ZRec2);
   inflateEnd(l_ZRec3);
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////
procedure LoadSimpleJpegV6(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; var Bitmap:TIEBitmap; var Progress:TProgressRec);
var
	ms:TMemoryStream;
   ioparams:TIOParamsVals;
   l:integer;
begin
	ioparams:=TIOParamsVals.Create(nil);
	ms:=TMemoryStream.Create;
	TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+TIFFVars.JPEGInterchangeFormat,soFromBeginning);
   if TIFFVars.JPEGInterchangeFormatLength=0 then
   	l:=TIFFEnv.Stream.Size-TIFFEnv.Stream.Position
   else if TIFFVars.JPEGInterchangeFormatLength>0 then
	   l:=imin(TIFFVars.JPEGInterchangeFormatLength,(TIFFEnv.Stream.Size-TIFFEnv.Stream.Position))
   else
		l:=TIFFEnv.Stream.Size-TIFFEnv.Stream.Position;
	ms.CopyFrom(TIFFEnv.Stream,l);
   ms.position:=0;
	ReadJpegStream(ms,nil,Bitmap,ioparams,Progress,false,false);
   ms.free;
   ioparams.free;
end;

procedure LoadIPTC(var TIFFEnv:TTIFFEnv; var TIFFVars:TTIFFVars; Params:TIOParamsVals);
const
	mul:array [1..9] of integer=(1,1,2,4,8,1,1,2,4);
var
	ms:TMemoryStream;
   t:integer;
begin
	t:=TIFFFindTAG(33723,TIFFEnv);
   if t<0 then
   	// not found
      Params.IPTC_Info.Clear
   else begin
      ms:=TMemoryStream.Create;
      TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+TIFFEnv.IFD^[t].DataPos,soFromBeginning);
      ms.CopyFrom(TIFFEnv.Stream,TIFFEnv.IFD^[t].DataNum*mul[TIFFEnv.IFD^[t].DataType]);
      ms.position:=0;
      Params.IPTC_Info.LoadFromStandardBuffer(ms.memory,ms.size);
      ms.free;
   end;
end;


// input
//		imageindex: image to read (0=first image)
//		Offset: the offset of the image IFD (TIFFHeader.PosIFD)
// 	TIFFEnv.Intel must be valid
// 	TIFFEnv.Stream must be valid
// 	TIFFEnv.StreamBase must be valid
// output
//		numi: images count
//		TIFFEnv.NumTags
//		TIFFEnv.IFD (you must free this)
// return
//		true if the image exists, false otherwise
function TIFFReadIFD(imageindex:integer; Offset:integer; var TIFFEnv:TTIFFEnv; var numi:integer):boolean;
var
	PosIFD,q: integer;
 nt: word;
begin
 // read TAGS for image idx
 result := false;
 TIFFEnv.IFD := nil;
	numi:=0;
 PosIFD := Offset;
 repeat
  TIFFEnv.Stream.Seek(TIFFEnv.StreamBase+PosIFD,soFromBeginning);
		TIFFEnv.Stream.read(nt,2);	// read tag count
  if not TIFFEnv.Intel then
   nt:=IESwapWord(nt);
  if numi=ImageIndex then
  begin
  	TIFFEnv.NumTags := nt;
			getmem(TIFFEnv.IFD,TIFFEnv.NumTags*sizeof(TTIFFTAG));
		 TIFFEnv.Stream.read(pbyte(TIFFEnv.IFD)^,sizeof(TTIFFTAG)*TIFFEnv.NumTags);	   // read tags
  end
  else
			TIFFEnv.Stream.seek(sizeof(TTIFFTAG)*nt,soFromCurrent);
  if TIFFEnv.stream.position>=TIFFEnv.stream.size then
  	break;
  TIFFEnv.Stream.read(q,4);	// next IFD
  if not TIFFEnv.Intel then
  	q:=IESwapDWord(q);
  if q<>PosIFD then // some TIFFs loop the IFD on itself
  	PosIFD:=q
		else
  	PosIFD:=0;
  if (PosIFD<0) or (PosIFD>=TIFFEnv.Stream.Size) then
  	PosIFD:=0;	// invalid IFD
  inc(numi);
 until PosIFD=0;
 if not assigned(TIFFEnv.IFD) then
 	exit;		// image doesn't exists
	// Convert TAGS to Intel (if needed)
 if not TIFFEnv.Intel then
  for q:=0 to TIFFEnv.NumTags-1 do
  begin
  	TIFFEnv.IFD^[q].IdTag:=IESwapWord(TIFFEnv.IFD^[q].IdTag);
			TIFFEnv.IFD^[q].DataType:=IESwapWord(TIFFEnv.IFD^[q].DataType);
			TIFFEnv.IFD^[q].DataNum:=IESwapDWord(TIFFEnv.IFD^[q].DataNum);
   TIFFEnv.IFD^[q].DataPos:=IESwapDWord(TIFFEnv.IFD^[q].DataPos);
  end;
 result:=true;
end;

//////////////////////////////////////////////////////////////////////////////////////
// read a TIFF stream
// Bitmap: bitmap da scrivere, giа creata
// numi: images count (output)
// NOTE:
//    - can return a bitmap with pixelformat to pf24bit or pf1bit
procedure TIFFReadStream(Bitmap:        TIEBitmap;
                         Stream:        TStream;
                     var numi:          integer;
                         IOParams:      TIOParamsVals;
                     var Progress:      TProgressRec;
                         Preview:       boolean;
                     var AlphaChannel:  TIEMask;
                         TranslateBase: boolean;
                         IgnoreAlpha:   boolean;
                         IsExifThumb:   boolean);
var
	TIFFHeader:TTIFFHeader;
 PosIFD    :integer;
 TIFFEnv   :TTIFFEnv;
 SubTIFFEnv:TTIFFEnv;
	TIFFVars  :TTIFFVars;
 q         :integer;
 dd        :double;
 laccess   :TIEDataAccess;
begin
 fillmemory(@TIFFEnv,sizeof(TTIFFEnv),0);
 fillmemory(@TIFFVars,sizeof(TTIFFVars),0);
 fillmemory(@SubTIFFEnv,sizeof(TTIFFEnv),0);
	numi:=0;
 try
  TIFFVars.RefParams:=IOParams;
	 // read header
  TIFFEnv.Stream:=Stream;
  if TranslateBase then
	  TIFFEnv.StreamBase:=Stream.Position
  else
		 TIFFEnv.StreamBase:=0;
	 Stream.read(TIFFHeader,sizeof(TTIFFHeader));
  if (TIFFHeader.Id<>$4949) and (TIFFHeader.id<>$4D4D) then
  begin
  	Progress.Aborting^:=True;
   exit;
  end;
  TIFFEnv.Intel:=TIFFHeader.Id=$4949;
  TIFFVars.intel:=TIFFEnv.Intel;
  if not TIFFEnv.Intel then
		 TIFFHeader.PosIFD:=IESwapDWord(TIFFHeader.PosIFD); // converts Intel header
  // read main IFD (of the selected image)
  TIFFEnv.IFD:=nil;
  PosIFD:=TIFFHeader.PosIFD;
  if PosIFD = 0 then
   exit;
  if assigned(IOParams) then
  	q:=IOParams.TIFF_ImageIndex
  else
  	q := -1;
  if not TIFFReadIFD(q,TIFFHeader.PosIFD,TIFFEnv,numi) then
  	exit;
  // Get Sub IFD (for EXIF)
	 PosIFD:=TIFFReadSingleValDef(TIFFEnv,34665,0);
  if PosIFD > 0 then
  begin
   SubTIFFEnv.Intel:=TIFFEnv.Intel;
		 SubTIFFEnv.Stream:=TIFFEnv.Stream;
   SubTIFFEnv.StreamBase:=0;
   TIFFReadIFD(0,PosIFD,SubTIFFEnv,q);
   IOParams.EXIF_HasEXIFData:=true;
  end;
   // Decode TAGS
	 TIFFVars.ImageWidth:=TIFFReadSingleValDef(TIFFEnv,256,0);
  TIFFVars.ImageHeight:=TIFFReadSingleValDef(TIFFEnv,257,0);
  TIFFVars.SamplesPerPixel:=TIFFReadSingleValDef(TIFFEnv,277,1);
  if not ReadBitsPerSample(TIFFEnv,TIFFVars) then
  begin
  	Progress.Aborting^:=True;
  	exit;
  end;
	 TIFFVars.RowsPerStrip:=TIFFReadSingleValDef(TIFFEnv,278,TIFFVars.ImageHeight);
  if TIFFVars.RowsPerStrip=-1 then
		 TIFFVars.RowsPerStrip:=TIFFVars.ImageHeight;
  TIFFVars.TileWidth:=TIFFReadSingleValDef(TIFFEnv,322,-1);
  TIFFVars.TileLength:=TIFFReadSingleValDef(TIFFEnv,323,-1);
  TIFFVars.PhotometricInterpretation:=TIFFReadSingleValDef(TIFFEnv,262,2);
  TIFFVars.PlanarConfiguration:=TIFFReadSingleValDef(TIFFEnv,284,1);
  TIFFVars.Orientation:=TIFFReadSingleValDef(TIFFEnv,274,1);
  TIFFVars.Compression:=TIFFReadSingleValDef(TIFFEnv,259,1);
  TIFFVars.Predictor:=TIFFReadSingleValDef(TIFFEnv,317,1);
  TIFFVars.ResolutionUnit:=TIFFReadSingleValDef(TIFFEnv,296,2);
  TIFFVars.XResolution:=TIFFReadSingleRational(TIFFEnv,282);
  TIFFVars.YResolution:=TIFFReadSingleRational(TIFFEnv,283);
  TIFFVars.T4Options:=TIFFReadSingleValDef(TIFFEnv,292,0);
  TIFFVars.T6Options:=TIFFReadsingleValDef(TIFFEnv,293,0);
  TIFFVars.FillOrder:=TIFFReadSingleValDef(TIFFEnv,266,1);
 	TIFFVars.XPosition:=TIFFReadSingleRational(TIFFEnv,286);
  TIFFVars.YPosition:=TIFFReadSingleRational(TIFFEnv,287);
  TIFFVars.DocumentName:=TIFFReadString(TIFFEnv,269);
  TIFFVars.ImageDescription:=TIFFReadString(TIFFEnv,270);
  TIFFVars.PageName:=TIFFReadString(TIFFEnv,285);
	 TIFFVars.PageNumber:=TIFFReadIndexValN(TIFFEnv,297,0);
	 TIFFVars.PageCount:=TIFFReadIndexValN(TIFFEnv,297,1);
  TIFFVars.Software:=TIFFReadString(TIFFEnv,305);
  TIFFVars.InkSet:=TIFFReadSingleValDef(TIFFEnv,332,1);
  TIFFVars.NumberOfInks:=TIFFReadSingleValDef(TIFFEnv,334,4);
	 TIFFVars.JPEGProc:=TIFFReadSingleValDef(TIFFEnv,512,0);
  TIFFVars.JPEGInterchangeFormat:=TIFFReadSingleValDef(TIFFEnv,513,0);
  TIFFVars.JPEGInterchangeFormatLength:=TIFFReadSingleValDef(TIFFEnv,514,0);
  TIFFVars.JPEGRestartInterval:=TIFFReadSingleValDef(TIFFEnv,515,0);
  for q:=0 to TIFFVars.SamplesPerPixel-1 do
  begin
  	TIFFVars.JPEGLosslessPredictors[q]:=TIFFReadIndexValN(TIFFEnv,517,q);
   TIFFVars.JPEGPointTransforms[q]:=TIFFReadIndexValN(TIFFEnv,518,q);
   TIFFVars.JPEGQTables[q]:=TIFFReadIndexValN(TIFFEnv,519,q);
   TIFFVars.JPEGDCTables[q]:=TIFFReadIndexValN(TIFFEnv,520,q);
   TIFFVars.JPEGACTables[q]:=TIFFReadIndexValN(TIFFEnv,521,q);
  end;
  TIFFVars.ExtraSamples:=TIFFReadSingleValDef(TIFFEnv,338,0);
  // We assume that SamplesPerPixel=4
  for q := 0 to 7 do
  	TIFFVars.DotRange[q]:=TIFFReadIndexValN(TIFFEnv,336,q);
	 //
  TIFFVars.StripOffsets_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.StripOffsets,273);
  TIFFVars.StripByteCounts_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.StripByteCounts,279);
	 TIFFVars.TileOffsets_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.TileOffsets,324);
  TIFFVars.TileByteCounts_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.TileByteCounts,325);
  // fix wrong files of ACDSee 3.1
  if (TIFFVars.SamplesPerPixel=1) and (TIFFVars.BitsPerSample=1) and
    	(TIFFVars.Compression>0) and (TIFFVars.Compression<5) and (TIFFVars.PhotometricInterpretation=2) then
		 TIFFVars.PhotometricInterpretation:=0;
	 //
  TIFFVars.JPEGTables:=TIFFReadRawData(TIFFEnv,347,TIFFVars.JPEGTablesSize);	// for Compression=7
	 //
  ReadColorMap(TIFFEnv,TIFFVars);
  ReadTransferFunction(TIFFEnv,TIFFVars);
  // IPTC
  LoadIPTC(TIFFEnv,TIFFVars,IOParams);
  // Wang annotations
  LoadWang(TIFFEnv,IOParams);
  // set TIOParamsVals parameters
  with IOParams do
  begin
   BitsPerSample:=TIFFVars.BitsPerSample;
   SamplesPerPixel:=TIFFVars.SamplesPerPixel;
   Width:=TIFFVars.ImageWidth;
   Height:=TIFFVars.ImageHeight;
   fTIFF_ImageCount:=numi;
   TIFF_Orientation:=TIFFVars.Orientation;
   //TIFFVars.Compression := 7;
   case TIFFVars.Compression of
   	tcUncompressed: TIFF_Compression := ioTIFF_UNCOMPRESSED;
    tcCCITT1D     : TIFF_Compression:=ioTIFF_CCITT1D;
    tcG3FAX       : if TIFFVars.T4Options and 1 = 0 then
	      	             TIFF_Compression:=ioTIFF_G3FAX1D
		                  else
 		                  TIFF_Compression:=ioTIFF_G3FAX2D;
    tcG4FAX       : TIFF_Compression:=ioTIFF_G4FAX;
    tcLZW         : TIFF_Compression:=ioTIFF_LZW;
    tcOldJPEG     : TIFF_Compression:=ioTIFF_OLDJPEG;
    tcJPEG        : TIFF_Compression:=ioTIFF_JPEG;
    tcPackbits    : TIFF_Compression:=ioTIFF_PACKBITS;
    tcZIP         : TIFF_Compression:=ioTIFF_ZIP;
   else
    TIFF_Compression:=ioTIFF_UNKNOWN;
   end;
   case TIFFVars.PhotometricInterpretation of
   	0:TIFF_PhotometInterpret:=ioTIFF_WHITEISZERO;
    1:TIFF_PhotometInterpret:=ioTIFF_BLACKISZERO;
    2:TIFF_PhotometInterpret:=ioTIFF_RGB;
    3:TIFF_PhotometInterpret:=ioTIFF_RGBPALETTE;
    4:TIFF_PhotometInterpret:=ioTIFF_TRANSPMASK;
    5:TIFF_PhotometInterpret:=ioTIFF_CMYK;
    6:TIFF_PhotometInterpret:=ioTIFF_YCBCR;
    8:TIFF_PhotometInterpret:=ioTIFF_CIELAB;
   end;
   TIFF_PlanarConf:=TIFFVars.PlanarConfiguration;
   TIFF_DocumentName:=TIFFVars.DocumentName;
   TIFF_ImageDescription:=TIFFVars.ImageDescription;
   TIFF_PageName:=TIFFVars.PageName;
   TIFF_PageNumber:=TIFFVars.PageNumber;
   TIFF_PageCount:=TIFFVars.PageCount;
   // EXIF (not in sub IDF)
   EXIF_Make:=TIFFReadString(TIFFEnv,271);
   EXIF_Model:=TIFFReadString(TIFFEnv,272);
   EXIF_DateTime:=TIFFReadString(TIFFEnv,306);
   EXIF_Orientation:=TIFFVars.Orientation;
   EXIF_XResolution:=TIFFVars.XResolution;
   EXIF_YResolution:=TIFFVars.YResolution;
   EXIF_ResolutionUnit:=TIFFVars.ResolutionUnit;
   EXIF_Software:=TIFFVars.Software;
   EXIF_WhitePoint[0]:=TIFFReadRationalIndex(TIFFEnv,318,0);
   EXIF_WhitePoint[1]:=TIFFReadRationalIndex(TIFFEnv,318,1);
   EXIF_YCbCrPositioning:=TIFFReadSingleValDef(TIFFEnv,531,0);
   for q:=0 to 5 do
    EXIF_PrimaryChromaticities[q]:=TIFFReadRationalIndex(TIFFEnv,319,q);
   for q:=0 to 2 do
    EXIF_YCbCrCoefficients[q]:=TIFFReadRationalIndex(TIFFEnv,529,q);
   for q:=0 to 5 do
    EXIF_ReferenceBlackWhite[q]:=TIFFReadRationalIndex(TIFFEnv,532,q);
   EXIF_Copyright:=TIFFReadString(TIFFEnv,33432);
   // EXIF (in sub IFD)
   EXIF_ExposureTime:=TIFFReadSingleRational(SubTIFFEnv,$829A);
		 EXIF_FNumber:=TIFFReadSingleRational(SubTIFFEnv,$829D);
   EXIF_ExposureProgram:=TIFFReadSingleValDef(SubTIFFEnv,$8822,0);
   EXIF_ISOSpeedRatings[0]:=TIFFReadIndexValN(SubTIFFEnv,$8827,0);
   EXIF_ISOSpeedRatings[1]:=TIFFReadIndexValN(SubTIFFEnv,$8827,1);
   EXIF_ExifVersion:=TIFFReadMiniString(SubTIFFEnv,$9000);
   EXIF_DateTimeOriginal:=TIFFReadString(SubTIFFEnv,$9003);
   EXIF_DateTimeDigitized:=TIFFReadString(SubTIFFEnv,$9004);
   EXIF_CompressedBitsPerPixel:=TIFFReadSingleRational(SubTIFFEnv,$9102);
   EXIF_ShutterSpeedValue:=TIFFReadSingleRational(SubTIFFEnv,$9201);
   EXIF_ApertureValue:=TIFFReadSingleRational(SubTIFFEnv,$9202);
   EXIF_BrightnessValue:=TIFFReadSingleRational(SubTIFFEnv,$9203);
   EXIF_ExposureBiasValue:=TIFFReadSingleRational(SubTIFFEnv,$9204);
   EXIF_MaxApertureValue:=TIFFReadSingleRational(SubTIFFEnv,$9205);
   EXIF_SubjectDistance:=TIFFReadSingleRational(SubTIFFEnv,$9206);
   EXIF_MeteringMode:=TIFFReadSingleValDef(SubTIFFEnv,$9207,0);
   EXIF_LightSource:=TIFFReadSingleValDef(SubTIFFEnv,$9208,0);
   EXIF_Flash:=TIFFReadSingleValDef(SubTIFFEnv,$9209,0);
   EXIF_FocalLength:=TIFFReadSingleRational(SubTIFFEnv,$920A);
   EXIF_SubsecTime:=TIFFReadString(SubTIFFEnv,$9290);
   EXIF_SubsecTimeOriginal:=TIFFReadString(SubTIFFEnv,$9291);
   EXIF_SubsecTimeDigitized:=TIFFReadString(SubTIFFEnv,$9292);
   EXIF_FlashPixVersion:=TIFFReadMiniString(SubTIFFEnv,$A000);
   EXIF_ColorSpace:=TIFFReadSingleValDef(SubTIFFEnv,$A001,0);
   EXIF_ExifImageWidth:=TIFFReadSingleValDef(SubTIFFEnv,$A002,0);
   EXIF_ExifImageHeight:=TIFFReadSingleValDef(SubTIFFEnv,$A003,0);
   EXIF_RelatedSoundFile:=TIFFReadString(SubTIFFEnv,$A004);
   EXIF_FocalPlaneXResolution:=TIFFReadSingleRational(SubTIFFEnv,$A20E);
   EXIF_FocalPlaneYResolution:=TIFFReadSingleRational(SubTIFFEnv,$A20F);
   EXIF_FocalPlaneResolutionUnit:=TIFFReadSingleValDef(SubTIFFEnv,$A210,0);
   EXIF_ExposureIndex:=TIFFReadSingleRational(SubTIFFEnv,$A215);
   EXIF_SensingMethod:=TIFFReadSingleValDef(SubTIFFEnv,$A217,0);
   EXIF_FileSource:=TIFFReadSingleValDef(SubTIFFEnv,$A300,0);
   EXIF_SceneType:=TIFFReadSingleValDef(SubTIFFEnv,$A301,0);
   EXIF_UserCommentCode:=TIFFReadString(SubTIFFEnv,$9286);
   if length(EXIF_UserCommentCode) > 0 then
   begin
    EXIF_UserComment:=copy(EXIF_UserCommentCode,9,length(EXIF_UserCommentCode));
    EXIF_UserCommentCode:=copy(EXIF_UserCommentCode,1,8);
   end
   else
    EXIF_UserComment:='';
		 // Colormap
		 if ColorMap <> nil then
   begin
   	freemem(ColorMap);
    fColorMap:=nil;
    fColorMapCount:=0;
   end;
   if TIFFVars.ColorMap_Num>0 then
   begin
    fColorMapCount:=TIFFVars.ColorMap_Num;
    getmem(fColorMap,TIFFVars.ColorMap_Num*sizeof(TRGB));
    CopyMemory(ColorMap,TIFFVars.ColorMap,TIFFVars.ColorMap_Num*sizeof(TRGB));
   end;
	  // resolution unit and dpi
	  if TIFFVars.ResolutionUnit=3 then
    dd:=2.54
   else
    dd:=1;
	  DpiX:=trunc(TIFFVars.XResolution*dd);
	  DpiY:=trunc(TIFFVars.YResolution*dd);
   if DpiX=0 then
    DpiX:=gDefaultDPIX;
   if DpiY=0 then
    DpiY:=gDefaultDPIY;
		 TIFF_XPos:=trunc(TIFFVars.XPosition*dd);
	  TIFF_YPos:=trunc(TIFFVars.YPosition*dd);
   if ((Width=0) or (Height=0)) and (not IsExifThumb) then
   begin
   	Progress.Aborting^:=True;
    exit;
   end;
  end;

  if TIFFVars.Compression = tcLZW then
  begin
   // verify that exists a LZW function for decompression
   if assigned(IOParams.TIFF_LZWDecompFunc) then
   	TIFFVars.LZWDecompFunc:=IOParams.TIFF_LZWDecompFunc
   else
    if assigned(DefTIFF_LZWDECOMPFUNC) then
     TIFFVars.LZWDecompFunc:=DefTIFF_LZWDECOMPFUNC
    else
    begin
    	Progress.Aborting^:=True;
     exit;
    end;
  end;

  TIFFVars.IgnoreAlpha:=IgnoreAlpha;
  if not Preview then
  begin
   // Load the image
   if not IgnoreAlpha then
   begin
    if ( ((TIFFVars.SamplesPerPixel=4) and (TIFFVars.ExtraSamples=2)) or
      	  ((TIFFVars.SamplesPerPixel=2) and (TIFFVars.BitsPerSample=8)) or
         ((TIFFVars.SamplesPerPixel=4) and (TIFFVars.PhotometricInterpretation=2)) )
         and (not assigned(AlphaChannel)) then
     // alpha required
     AlphaChannel:=TIEMask.Create;
    if assigned(AlphaChannel) then
    begin
     AlphaChannel.AllocateBits(TIFFVars.ImageWidth,TIFFVars.ImageHeight,8);
     AlphaChannel.Fill(255);
    end;
   end;

   TIFFVars.AlphaChannel:=AlphaChannel;
   laccess:=Bitmap.Access;
   Bitmap.Access:=[iedWrite];	// write only
   if (TIFFVars.Compression = 6) and (TIFFVars.JPEGProc < 2) then
   begin
   	LoadSimpleJpegV6(TIFFEnv,TIFFVars,Bitmap,Progress);
   end
   else
   begin
    if (TIFFVars.ImageWidth=0) or (TIFFVars.ImageHeight=0) then
    begin
     Progress.Aborting^:=True;
     exit;
    end;
    if (TIFFVars.BitsPerSample=1) and (TIFFVars.SamplesPerPixel=1) and (TIFFVars.PhotometricInterpretation<>3) then
     Bitmap.Allocate(TIFFVars.ImageWidth,TIFFVars.ImageHeight,ie1g)
    else
     if IOParams.IsNativePixelFormat and (TIFFVars.BitsPerSample=8) and (TIFFVars.SamplesPerPixel=1) and (TIFFVars.PhotometricInterpretation=3) then
     begin
     	Bitmap.Allocate(TIFFVars.ImageWidth,TIFFVars.ImageHeight,ie8p);
				  for q:=0 to IOParams.ColorMapCount-1 do
      	Bitmap.Palette[q]:=IOParams.ColorMap[q];
     end
     else
      if IOParams.IsNativePixelFormat and (TIFFVars.BitsPerSample=8) and (TIFFVars.SamplesPerPixel=1) and (TIFFVars.PhotometricInterpretation=1) then
       Bitmap.Allocate(TIFFVars.ImageWidth,TIFFVars.ImageHeight,ie8g)
      else
       if IOParams.IsNativePixelFormat and (TIFFVars.BitsPerSample=16) and (TIFFVars.SamplesPerPixel=1) and (TIFFVars.PhotometricInterpretation=1) then
       	Bitmap.Allocate(TIFFVars.ImageWidth,TIFFVars.ImageHeight,ie16g)
       else
        Bitmap.Allocate(TIFFVars.ImageWidth,TIFFVars.ImageHeight,ie24RGB);

    if (TIFFVars.TileWidth>0) or (TIFFVars.TileLength>0) then
    begin
     // tiled
     if TIFFVars.TileOffsets_Num > 0 then
      Tiles2Bitmap(TIFFEnv,TIFFVars,Bitmap,Progress)
     else
      if TIFFVars.StripOffsets_Num>0 then
      begin
       // old tiff, uses Strips instead of Tiles...
					  TIFFVars.TileOffsets_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.TileOffsets,273);
				   TIFFVars.TileByteCounts_Num:=TIFFReadArrayIntegers(TIFFEnv,TIFFVars.TileByteCounts,279);
       Tiles2Bitmap(TIFFEnv,TIFFVars,Bitmap,Progress)
      end;
    end
    else
    begin
     // stripped
     if TIFFVars.StripOffsets_Num>0 then
      Strips2Bitmap(TIFFEnv,TIFFVars,Bitmap,Progress);
    end;
   end;
   Bitmap.Access:=laccess;
   // adjust orientation if <>1
   if IOParams.TIFF_EnableAdjustOrientation and (TIFFVars.Orientation<>1) then
   begin
    case TIFFVars.Orientation of
     2: // 0th row = top of the image, 0th column = right-hand side.
       	begin
	       	_FlipEx(Bitmap,fdHorizontal);
       	end;
     3: // 0th row = bottom of the image, 0th column = right-hand side.
        begin
         _FlipEx(Bitmap,fdVertical);
         _FlipEx(Bitmap,fdHorizontal);
       end;
     4: // 0th row = bottom of the image, 0th column = left-hand side.
        begin
         _FlipEx(Bitmap,fdVertical);
        end;
     5: // 0th row = left-hand side of the image, 0th column = visual top.
        begin
         _RotateEx(Bitmap,90,false,creatergb(0,0,0),nil,nil);
         _FlipEx(Bitmap,fdHorizontal);
        end;
     6: // 0th row = right-hand side of the image, 0th column = visual top.
        begin
         _RotateEx(Bitmap,-90,false,creatergb(0,0,0),nil,nil);
        end;
     7: // 0th row = right-hand side of the image, 0th column = visual bottom.
        begin
         _RotateEx(Bitmap,-90,false,creatergb(0,0,0),nil,nil);
         _FlipEx(Bitmap,fdHorizontal);
        end;
     8: // 0th row = left-hand side of the image, 0th column = visual bottom.
        begin
         _RotateEx(Bitmap,90,false,creatergb(0,0,0),nil,nil);
        end;
    end;
   end;
  end;
 finally
  // free memory allocated in TIFFEnv
  if TIFFEnv.IFD<>nil then
   freemem(TIFFEnv.IFD);
  // free memory allocated in SubTIFFEnv
  if SubTIFFEnv.IFD<>nil then
   freemem(SubTIFFEnv.IFD);
  // free memory allocated in TIFFVars
  with TIFFVars do
  begin
   if StripOffsets_Num>0 then
    freemem(Stripoffsets);
   if StripByteCounts_Num>0 then
    freemem(StripByteCounts);
   if TileOffsets_Num>0 then
    freemem(TileOffsets);
   if TileByteCounts_Num>0 then
    freemem(TileByteCounts);
   if ColorMap_Num>0 then
    freemem(ColorMap);
   if TransferFunction_Num>0 then
    freemem(TransferFunction);
   if JPEGTables<>nil then
    freemem(JPEGTables);
  end;
 end;
end;

  //////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////
//**********************************************************************************//
//* WRITE TIFF    																					  *//
//**********************************************************************************//
 ////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////

type TCompRec=record
	LZWCompFunc:TTIFFLZWCompFunc;	// LZW decompression function
	Compression:integer;
   T4Options:integer;
   Photomet:TIOTIFFPhotometInterpret;
   Predictor:integer;
   qt:TIEQuantizer;
   BitsPerSample:integer;
   jpegquality:integer;	// jpeg quality
   jpegcolorspace:TIOJPEGColorSpace;
end;

//////////////////////////////////////////////////////////////////////////////////////
// write LONG value
procedure WriteSingleLong(imed:TList; tag:integer; val:integer);
var
	tg:PTIFFTAG;
begin
	new(tg);
	tg^.IdTag:=tag;  tg^.DataType:=4;	tg^.DataNum:=1;	tg^.DataPos:=val;
   imed.add( tg );
end;

procedure WriteMiniString(imed:TList; tag:integer; ss:string);
var
	tg:PTIFFTAG;
begin
	new(tg);
	tg^.IdTag:=tag;
   tg^.DataType:=7;
   tg^.DataNum:=length(ss);
   move(PAnsiChar(ss)^,tg^.DataPos,length(ss));
   imed.add( tg );
end;


//////////////////////////////////////////////////////////////////////////////////////
// write SHORT value
procedure WriteSingleShort(imed:TList; tag:integer; val:word);
var
	tg:PTIFFTAG;
begin
	new(tg);
	tg^.IdTag:=tag;  tg^.DataType:=3;	tg^.DataNum:=1;	tg^.DataPos:=val;
	imed.add( tg );
end;

//////////////////////////////////////////////////////////////////////////////////////
// write RATIONAL value
procedure WriteSingleRational(imed:TList; Stream:TStream; tag:integer; num,den:integer; var Aborting:boolean);
var
	tg:PTIFFTAG;
begin
	new(tg);
   tg^.IdTag:=tag; tg^.DataType:=5; tg^.DataNum:=1;
   tg^.DataPos:=Stream.Position;
   imed.add( tg );
   SafeStreamWrite(Stream,Aborting,num,sizeof(integer));
   SafeStreamWrite(Stream,Aborting,den,sizeof(integer));
end;

// numden=[num,den, num,den...]
procedure WriteMultiRational(imed:TList; Stream:TStream; tag:integer; numden:array of integer; var Aborting:boolean);
var
	tg:PTIFFTAG;
   count,i:integer;
begin
	count:=(high(numden)+1)div 2;
	new(tg);
   tg^.IdTag:=tag; tg^.DataType:=5; tg^.DataNum:=count;
   tg^.DataPos:=Stream.Position;
   imed.add( tg );
   for i:=0 to count-1 do begin
	   SafeStreamWrite(Stream,Aborting,numden[i*2],sizeof(integer));
	   SafeStreamWrite(Stream,Aborting,numden[i*2+1],sizeof(integer));
   end;
end;


//////////////////////////////////////////////////////////////////////////////////////
// Scrive una stringa (solo se <> da '')
procedure WriteString(imed:TList; Stream:TStream; tag:integer; ss:string; var Aborting:boolean);
var
	tg:PTIFFTAG;
begin
	if length(ss) > 0 then
 begin
		new(tg);
	 tg^.IdTag:=tag; tg^.DataType:=2;
  tg^.DataNum:=length(ss)+1;
	 tg^.DataPos:=Stream.Position;
	 imed.add(tg);
  SafeStreamWrite(Stream,Aborting,PAnsiChar(ss)^,length(ss)+1);
 end;
end;

//////////////////////////////////////////////////////////////////////////////////////
procedure WriteMultiLongEx(imed:TList; Stream:TStream; tag:integer; arr:pdwordarray; arraylen:integer; var Aborting:boolean);
var
	tg:PTIFFTAG;
begin
	new(tg);
   tg^.IdTag:=tag; tg^.DataType:=4;
   tg^.DataNum:=arraylen;
   tg^.DataPos:=Stream.Position;
   imed.add( tg );
   SafeStreamWrite(Stream,Aborting,arr[0],arraylen*sizeof(dword));
end;

//////////////////////////////////////////////////////////////////////////////////////
procedure WriteMultiShort(imed:TList; Stream:TStream; tag:integer; const vals:array of word; var Aborting:boolean);
var
	tg:PTIFFTAG;
   l:integer;
begin
	new(tg);
   tg^.IdTag:=tag; tg^.DataType:=3;
   l:=high(vals)+1;
   tg^.DataNum:=l;
   if l=1 then begin
		tg^.DataPos:= vals[0];
   end else if l=2 then begin
   	tg^.DataPos:= vals[0] or (vals[1] shl 16);
   end else begin
      tg^.DataPos:=Stream.Position;
      SafeStreamWrite(Stream,Aborting,vals,l*sizeof(word));
   end;
   imed.add( tg );
end;

procedure WriteIPTC(imed:TList; Stream:TStream; Params:TIOParamsVals; var Aborting:boolean);
var
	tg:PTIFFTAG;
   buf:pointer;
   buflen:integer;
begin
   Params.IPTC_Info.SaveToStandardBuffer(buf,buflen,false);
   if buf<>nil then begin
      new(tg);
      tg^.IdTag:=33723; tg^.DataType:=4;
      tg^.DataNum:=buflen div 4;
      if (buflen and 7)<>0 then inc( tg^.DataNum );
      tg^.DataPos:=Stream.Position;
      imed.add( tg );
      SafeStreamWrite(Stream,Aborting,pbyte(buf)^,buflen);
      freemem(buf);
   end;
end;

procedure WriteWang(imed:TList; Stream:TStream; Params:TIOParamsVals; var Aborting:boolean);
var
	tg:PTIFFTAG;
   buf:pointer;
   buflen:integer;
begin
   Params.ImagingAnnot.SaveToStandardBuffer(buf,buflen);
   if buf<>nil then begin
      new(tg);
      tg^.IdTag:=32932; tg^.DataType:=1;
      tg^.DataNum:=buflen;
      tg^.DataPos:=Stream.Position;
      imed.add( tg );
      SafeStreamWrite(Stream,Aborting,pbyte(buf)^,buflen);
      freemem(buf);
   end;
end;

//////////////////////////////////////////////////////////////////////////////////////
// Scrive rowbuf (di dimensione sz bytes) in Stream, compresso con PackBits
procedure _WritePackBits(rowbuf:pbyte; sz:integer; Stream:TStream; var Aborting:boolean);
var
	pa:pbytearray;
   n,rl:integer;
   si:shortint;
   bp:integer;
procedure SavB;
var
	qq:integer;
begin
 	// scrive byte assoluti da bp a n-1
   qq:=n-bp;
   if qq>0 then begin
      // piщ bytes
      si:=qq-1;
      SafeStreamWrite(Stream,Aborting,si,1);
      SafeStreamWrite(Stream,Aborting,pbyte(@pa^[bp])^,qq);
   end;
end;
begin
	pa:=pbytearray(rowbuf);
	n:=0;	// n и la posizione iniziale del prossimo gruppo da comprimere
   bp:=0;
   while n<sz do begin
   	// cerca eventuali byte uguali
      rl:=1;
		while ((n+rl)<sz) and (pa^[n]=pa^[n+rl]) and (rl<128) do
      	inc(rl);
		if rl>3 then begin
         SavB; // scrive byte assoluti da bp a n-1
      	// replica bytes
         si:=-1*(rl-1);
         SafeStreamWrite(Stream,Aborting,si,1);
         SafeStreamWrite(Stream,Aborting,pa^[n],1);
         inc(n,rl);
         bp:=n;
      end else if (n-bp)=128 then begin
      	SavB;
         bp:=n;
   	end else
      	inc(n);
   end;
   SavB; // scrive byte assoluti da bp a n-1
end;

/////////////////////////////////////////////////////////////////////////////////////
// Converte RGB a CMYK
(*
function _RGB2CMYK(const rgb:TRGB):TCMYK;
begin
	with rgb,result do begin
	  	k:=imax(r,imax(g,b));
      if k=0 then k:=1;
      C := r*255 div k;
      M := g*255 div k;
      Y := b*255 div k;
      c:=255-c;
      m:=255-m;
      y:=255-y;
      k:=255-k;
   end;
end;
*)

// jpeg compression (DRAFT TIFF Technical Note #2)
procedure WriteStripJpeg(Stream:TStream; Bitmap:TIEBitmap; var crec:TCompRec; var Progress:TProgressRec);
var
	iop:TIOParamsVals;
begin
	iop:=TIOParamsVals.Create(nil);
   iop.JPEG_Quality:=crec.jpegquality;
   iop.JPEG_ColorSpace:=crec.jpegcolorspace;
	WriteJPegStream(Stream,Bitmap,iop,Progress);
   iop.free;
end;

procedure WriteStrip(Stream:TStream; Bitmap:TIEBitmap; var imed:TList; var crec:TCompRec; var Progress:TProgressRec);
const
	MAXSTRIPDIM=512*1024; // 512 K
var
	row,q,ww,dbit,sbit:integer;
   rowbuf,bufb,pb:pbyte;
   bufw:pword;
   inrow,buf1,buf2:PRGB;
   bwr,bb:byte;		// byte to write
   bwrl:integer; 		// remaining bits in bwr to write
   p_byte,predline:pbyte;	// predline allocated by compressing function
   Samples:integer;	// Samples per pixel
   lzwid:integer;
   bitmapwidth1,bitmapheight1:integer;
   StripsPerImage:integer;
   RowsPerStrip:integer;
   striprow:integer;	// current row of strip
   stripidx:integer;	// current strip
   pos_ar:pdwordarray;
   siz_ar:pdwordarray;
   p_word:pword;
   //
   procedure FinalizeCompressors;
   begin
      if (crec.Compression=3) and (crec.T4Options=0) then
         // finalize G3FAX1D
         CCITTHuffmanPutLineG3(nil,0,Stream,bwr,bwrl,Progress.Aborting^);
      if (crec.Compression=3) and (crec.T4Options=1) then
         // finalize G3FAX2D
         CCITTHuffmanPutLineG32D(nil,0,Stream,bwr,bwrl,predline,Progress.Aborting^);
      if (crec.Compression=4) then
         // finalize G4FAX
         CCITTHuffmanPutLineG4(nil,0,Stream,bwr,bwrl,predline,Progress.Aborting^);
      if crec.Compression=5 then
         // finalize LZW
         crec.LZWCompFunc(nil,0,Stream,lzwid);
   end;
   //
begin
	if crec.Compression=7 then begin
   	StripsPerImage:= 1;
      RowsPerStrip:= Bitmap.Height;
   end else begin
      StripsPerImage:= imax( (Bitmap.Height*Bitmap.RowLen) div MAXSTRIPDIM , 1 );
      RowsPerStrip:= Bitmap.Height div StripsPerImage;
      if frac(Bitmap.Height/StripsPerImage)>0 then
      	inc(StripsPerImage);
	end;
   getmem(pos_ar,sizeof(dword)*(StripsPerImage*2));
   getmem(siz_ar,sizeof(dword)*(StripsPerImage*2));
   StripsPerImage:=0;	// above values was only an estimation. Now calculates the actual value.
	case crec.Photomet of
      ioTIFF_WHITEISZERO: begin Samples:=1; end;
      ioTIFF_BLACKISZERO: begin Samples:=1; end;
      ioTIFF_RGB:			  begin Samples:=3; end;
      ioTIFF_RGBPALETTE:  begin Samples:=1; end;
      ioTIFF_TRANSPMASK:  begin Samples:=1; end;
      ioTIFF_CMYK: 		  begin Samples:=4; end;
      ioTIFF_YCBCR:		  begin Samples:=3; end;
      ioTIFF_CIELAB:		  begin Samples:=3; end;
      else begin Samples:=3; end;
	end;
   bitmapwidth1:=bitmap.width-1;
   bitmapheight1:=bitmap.height-1;
   lzwid:=0;
   if crec.Compression=7 then begin
   	pos_ar[0]:=Stream.Position;
      WriteStripJpeg(Stream,Bitmap,crec,Progress);
      siz_ar[0]:=Stream.Position-int64(pos_ar[0]);
      StripsPerImage:=1;
   end else begin
      case Bitmap.PixelFormat of
      	ie8p,ie8g,ie16g:
         	begin

               if crec.Compression=7 then
                  exit;
               ww:=(Samples*crec.BitsPerSample*Bitmap.Width);
               if (ww and 7)<>0 then
                  ww:=(ww div 8)+1
               else
                  ww:=ww div 8;
               Progress.per1:=100/Bitmap.Height;
               getmem(rowbuf,(Bitmap.Width*Samples)*imax(1,crec.BitsPerSample div 8)+4);
               striprow:=0;
               stripidx:=0;
               pos_ar[0]:=Stream.Position;
               for row:=0 to BitmapHeight1 do begin
                  // OnProgress
                  with Progress do
                     if assigned(fOnProgress) then
                        fOnProgress(Sender,trunc(per1*row));

                     // PALETTE or GRAYSCALE
                     if crec.BitsPerSample=8 then begin
                        // 8 bits per pixel
                        p_byte:=Bitmap.Scanline[row];
                        bufb:=rowbuf;
                        for q:=0 to BitmapWidth1 do begin
                           bufb^:=p_byte^;
                           inc(p_byte);
                           inc(bufb);
                        end;
                     end else if crec.BitsPerSample=16 then begin
                        // 16 bits per pixel (grayscale)
                        p_word:=Bitmap.Scanline[row];
                        bufw:=pword(rowbuf);
                        for q:=0 to BitmapWidth1 do begin
                           bufw^:=p_word^;
                           inc(p_word);
                           inc(bufw);
                        end;
                     end else begin
                        // 7,6,5,4,3,2 bits per pixel
                        // compact pixels in bytes
                        p_byte:=Bitmap.Scanline[row];
                        dbit:=0; // dest bit (0..7)
                        bufb:=rowbuf;  // dest buffer
                        for q:=0 to BitmapWidth1 do begin
                           bb:=p_byte^;
                           for sbit:=0 to crec.BitsPerSample-1 do begin
                              if (bb and (1 shl (crec.BitsPerSample-1-sbit)))<>0 then
                                 // write 1
                                 bufb^:=bufb^ or iebitmask1[dbit]
                              else
                                 // write 0
                                 bufb^:=bufb^ and not iebitmask1[dbit];
                              inc(dbit);
                              if dbit=8 then begin
                                 dbit:=0;
                                 inc(bufb);
                              end;
                           end;
                           inc(p_byte);
                        end;
                     end;
                  // from here in rowbuf (allocated) there is the row do compress and write
                  case crec.Compression of
                     1:
                        // NO COMPRESSION
                        SafeStreamWrite(Stream,Progress.Aborting^,rowbuf^,ww);
                     5:
                        // LZW
                        crec.LZWCompFunc(rowbuf,ww,Stream,lzwid);
                     32773:
                        // PACKBITS
                        _WritePackBits(rowbuf,ww,Stream,Progress.Aborting^);
                  end;
                  if Progress.Aborting^ then
                     break;

                  inc(striprow);
                  if (striprow=RowsPerStrip) or (row=BitmapHeight1) then begin
                  	FinalizeCompressors;
                     lzwid:=0;
                     //
                  	siz_ar[stripidx] := Stream.Position-int64(pos_ar[stripidx]);
                     StripsPerImage := stripidx+1;
                     striprow:=0;
                     if row<BitmapHeight1 then begin
                     	// this isn't the last one
                        inc(stripidx);
                        pos_ar[stripidx] := Stream.Position;
                     end;
                  end;

               end;	// of row for
               freemem(rowbuf);
            end;

         ie24RGB:
            ///////////// COLOR IMAGES
            begin
               if crec.Compression=7 then
                  exit;
               // RGB/CMYK/CIELAB/PALETTE
               if (Samples<3) and (crec.Photomet<>ioTIFF_RGBPALETTE) and (crec.Photomet<>ioTIFF_BLACKISZERO) then
                  Samples:=3;
               ww:=(Samples*crec.BitsPerSample*Bitmap.Width);
               if (ww and 7)<>0 then
                  ww:=(ww div 8)+1
               else
                  ww:=ww div 8;
               Progress.per1:=100/Bitmap.Height;
               getmem(rowbuf,(Bitmap.Width*Samples)*imax(1,crec.BitsPerSample div 8)+4);
               striprow:=0;
               stripidx:=0;
               pos_ar[0]:=Stream.Position;
               for row:=0 to BitmapHeight1 do begin
                  // OnProgress
                  with Progress do
                     if assigned(fOnProgress) then
                        fOnProgress(Sender,trunc(per1*row));
                  // prepare buffer to write
                  if crec.Photomet=ioTIFF_CMYK then begin
                     // CMYK
                     inrow:=Bitmap.Scanline[row];
                     // from BGR to CMYK
                     IEConvertColorFunction(inrow,ieBGR,rowbuf,ieCMYK,Bitmap.Width);
                     pb:=rowbuf;
                     for q:=0 to Bitmap.Width*4-1 do begin
                     	pb^:=255-pb^;
                     	inc(pb);
                     end;
                  end else if crec.Photomet=ioTIFF_CIELAB then begin
                     // CIELAB
                     inrow:=Bitmap.Scanline[row];
                     IEConvertColorFunction(inrow,ieBGR,rowbuf,ieCIELab,Bitmap.Width);
                  end else if (crec.Photomet=ioTIFF_RGBPALETTE) or (crec.Photomet=ioTIFF_BLACKISZERO) then begin
                     // PALETTE or GRAYSCALE
                     inrow:=PRGB(Bitmap.Scanline[row]);
                     if crec.BitsPerSample=8 then begin
                        // 8 bits per pixel
                        bufb:=rowbuf;
                        for q:=0 to BitmapWidth1 do begin
                           bufb^:=crec.qt.RGBIndex[ inrow^ ];
                           inc(inrow);
                           inc(bufb);
                        end;
                     end else if crec.BitsPerSample=16 then begin
                        // 16 bits per pixel (grayscale)
                        bufw:=pword(rowbuf);
                        for q:=0 to BitmapWidth1 do begin
                           bufw^:=crec.qt.RGBIndex[ inrow^ ] shl 8;
                           inc(inrow);
                           inc(bufw);
                        end;
                     end else begin
                        // 7,6,5,4,3,2 bits per pixel
                        // compact pixels in bytes
                        dbit:=0; // dest bit (0..7)
                        bufb:=rowbuf;  // dest buffer
                        for q:=0 to BitmapWidth1 do begin
                           bb:=crec.qt.RGBIndex[ inrow^ ];
                           for sbit:=0 to crec.BitsPerSample-1 do begin
                              if (bb and (1 shl (crec.BitsPerSample-1-sbit)))<>0 then
                                 // write 1
                                 bufb^:=bufb^ or iebitmask1[dbit]
                              else
                                 // write 0
                                 bufb^:=bufb^ and not iebitmask1[dbit];
                              inc(dbit);
                              if dbit=8 then begin
                                 dbit:=0;
                                 inc(bufb);
                              end;
                           end;
                           inc(inrow);
                        end;
                     end;
                  end else begin
                     // RGB
                     if crec.Predictor=2 then begin
                        // Predictor, BGR to RGB
                        buf1:=PRGB(integer(rowbuf)+BitmapWidth1*3);
                        inrow:=PRGB(integer(Bitmap.Scanline[row])+(BitmapWidth1)*3);
                        buf2:=inrow;
                        dec(buf2);
                        for q:=BitmapWidth1 downto 1 do begin
                           buf1^.r:=inrow^.b-buf2^.b;
                           buf1^.g:=inrow^.g-buf2^.g;
                           buf1^.b:=inrow^.r-buf2^.r;
                           dec(buf1);
                           dec(inrow);
                           dec(buf2);
                        end;
                        buf1^.r:=inrow^.b;
                        buf1^.g:=inrow^.g;
                        buf1^.b:=inrow^.r;
                     end else begin
                        // No predictor, from BGR to RGB
                        inrow:=PRGB(Bitmap.Scanline[row]);
                        buf1:=PRGB(rowbuf);
                        CopyMemory(rowbuf,inrow,Bitmap.Width*Samples);
                        for q:=0 to BitmapWidth1 do begin
                           bswap(buf1.r,buf1.b);
                           inc(buf1);
                        end;
                     end;
                  end;
                  // from here in rowbuf (allocated) there is the row do compress and write
                  case crec.Compression of
                     1:
                        // NO COMPRESSION
                        SafeStreamWrite(Stream,Progress.Aborting^,rowbuf^,ww);
                     5:
                        // LZW
                        crec.LZWCompFunc(rowbuf,ww,Stream,lzwid);
                     32773:
                        // PACKBITS
                        _WritePackBits(rowbuf,ww,Stream,Progress.Aborting^);
                  end;
                  if Progress.Aborting^ then
                     break;

                  inc(striprow);
                  if (striprow=RowsPerStrip) or (row=BitmapHeight1) then begin
                  	FinalizeCompressors;
                     lzwid:=0;
                     //
                  	siz_ar[stripidx] := Stream.Position-int64(pos_ar[stripidx]);
                     StripsPerImage := stripidx+1;
                     striprow:=0;
                     if row<BitmapHeight1 then begin
                     	// this isn't the last one
                        inc(stripidx);
                        pos_ar[stripidx] := Stream.Position;
                     end;
                  end;

               end;	// of row for
               freemem(rowbuf);
            end;
         ie1g:
            ///////////// B/W IMAGES
            begin
               Progress.per1:=100/Bitmap.Height;
               // calculates row length in bytes
               ww:=Bitmap.Width div 8;
               if (Bitmap.Width mod 8)<>0 then inc(ww);
               //
               striprow:=0;
               stripidx:=0;
               pos_ar[0]:=Stream.Position;
               bwrl:=0;
               bwr:=0;
               predline:=nil;
               for row:=0 to BitmapHeight1 do begin
                  // OnProgress
                  with Progress do
                     if assigned(fOnProgress) then
                        fOnProgress(Sender,trunc(per1*row));
                  //
                  case crec.Compression of
                     1:
                        // NO COMPRESSION
                        SafeStreamWrite(Stream,Progress.Aborting^,pbyte(Bitmap.Scanline[row])^,ww);
                     2:
                        // CCITT HUFFMAN 1D
                        CCITTHuffmanPutLine(pbyte(Bitmap.Scanline[row]),Bitmap.Width,Stream,Progress.Aborting^);
                     3:
                        if crec.T4Options=0 then
                           // CCITT G3FAX1D
                           CCITTHuffmanPutLineG3(pbyte(Bitmap.Scanline[row]),Bitmap.Width,Stream,bwr,bwrl,Progress.Aborting^)
                        else
                           // CCITT G3FAX2D
                           CCITTHuffmanPutLineG32D(pbyte(Bitmap.Scanline[row]),Bitmap.Width,Stream,bwr,bwrl,predline,Progress.Aborting^);
                     4:
                        // CCITT G4FAX
                        CCITTHuffmanPutLineG4(pbyte(Bitmap.Scanline[row]),Bitmap.Width,Stream,bwr,bwrl,predline,Progress.Aborting^);
                     5:
                        // LZW
                        crec.LZWCompFunc(pbyte(Bitmap.Scanline[row]),ww,Stream,lzwid);
                     32773:
                        // PACKBITS
                        _WritePackBits(pbyte(Bitmap.Scanline[row]),ww,Stream,Progress.Aborting^);
                  end;
                  if Progress.Aborting^ then
                     break;

                  inc(striprow);
                  if (striprow=RowsPerStrip) or (row=BitmapHeight1) then begin
                  	FinalizeCompressors;
                     bwrl:=0;
                     bwr:=0;
                     predline:=nil;
                     lzwid:=0;
                     //
                  	siz_ar[stripidx] := Stream.Position-int64(pos_ar[stripidx]);
                     StripsPerImage := stripidx+1;
                     striprow:=0;
                     if row<BitmapHeight1 then begin
                     	// this isn't the last one
                        inc(stripidx);
                        pos_ar[stripidx] := Stream.Position;
                     end;
                  end;

               end;
            end;
      end;	// end PixelFormat case
   end;	// end if (jpeg compression)
   WriteSingleLong(imed,278,RowsPerStrip); 	// RowsPerStrip
   if StripsPerImage=1 then begin
      WriteSingleLong(imed,273,pos_ar[0]);	// StripOffsets (array)
      WriteSingleLong(imed,279,siz_ar[0]);	// StripByteCounts (array)
   end else begin
   	WriteMultiLongEx(imed,Stream,273,pos_ar,StripsPerImage,Progress.Aborting^);
      WriteMultiLongEx(imed,Stream,279,siz_ar,StripsPerImage,Progress.Aborting^);
   end;
   freemem(pos_ar);
   freemem(siz_ar);
end;

// return images count
function _EnumTIFFImStream(Stream:TStream):integer;
var
	pr:TProgressRec;
   tempAlphaChannel:TIEMask;
   ab:boolean;
begin
	tempAlphaChannel:=nil;
   ab:=false;
   pr.Aborting:=@ab;
	TIFFReadStream(nil,Stream,result,nil,pr,false,tempAlphaChannel,true,true,false);	// result is inside...
end;

procedure WriteExifBlock(upimed:TList; Stream:TStream; var IOParams:TIOParamsVals; var Aborting:boolean); forward;

//////////////////////////////////////////////////////////////////////////////////////
// Bitmap puт essere pf24bit o pf1bit
// Compression:  1=nessuna
// Ins: true inserisce immagine di indice IOParams.TIFF_ImageIndex, false salva come unica immagine
// Se Ins и True, Stream deve essere aperto in fmOpenReadWrite
// Rest numero immagini presenti nel file (sempre 1 se Ins=false)
// note: Bitmap can be nil. If it is nil write only parameters (for EXIF inside Jpeg)
function TIFFWriteStream(Stream:TStream; Ins:boolean; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var Progress:TProgressRec):integer;
var
	tifhead:TTIFFHEADER;
 imed:TList;	// Strutture TTIFFTAG da scrivere
 q,w:integer;
 BasePos:integer;
 tw:word;
 WBitmap:TIEBitmap;
 BackCol,ForeCol:TRGB;
 crec:TCompRec;
 inv1bit:boolean;
 PosIFD,numi:integer;
 nt:word;
 WPosIFD:integer; // where to write position of new IFD
 SPosIFD:integer; // position of IFD to connect to the new IFD
 nullpr:TProgressRec;
 GlobalColorMap:array [0..255] of TRGB;
 wcolormap:array [0..255*3] of word;
 ncol:integer;
 laccess:TIEDataAccess;
begin
	//
 imed:=nil;
 crec.qt:=nil;
 wbitmap:=nil;
 ncol:=0;
 try
	 fillchar(crec,sizeof(TCompRec),0);
	 imed:=TList.Create;
  //
  with nullpr do
  begin
	  Aborting:=Progress.Aborting;
   fOnProgress:=nil;
   Sender:=nil;
	 end;
  WBitmap := Bitmap;
  if WBitmap <> nil then
  begin
   if (IOParams.BitsPerSample=1) and (IOParams.SamplesPerPixel=1) then
   begin
    // save in black/white
    if Bitmap.pixelformat <> ie1g then
    begin
     // Converts to 1 bit
     WBitmap := _ConvertTo1bitEx(Bitmap,BackCol,ForeCol);
     if WBitmap = nil then
     begin
      // impossible to convert to 1 bit, converts with ordered dither
      WBitmap:=TIEBitmap.Create;
      WBitmap.Assign(Bitmap);
      WBitmap.PixelFormat:=ie1g;
     end;
    end;
   end
   else
   begin
    // save in true color
    if Bitmap.pixelformat = ie1g then
    begin
     // Converts to 24 bit
     WBitmap:=TIEBitmap.Create;
     WBitmap.Assign(Bitmap);
     WBitmap.PixelFormat:=ie24RGB;
    end;
   end;

   if (IOParams.SamplesPerPixel=1) and ((IOParams.BitsPerSample<=8) or (IOParams.BitsPerSample=16)) and (IOParams.BitsPerSample>1) then
   begin
    // paletted image
    ncol := imin(1 shl IOParams.BitsPerSample,256);
    crec.qt:=TIEQuantizer.Create(wBitmap, GlobalColorMap, ncol, -1, 0);
    if (IOParams.TIFF_Compression<>ioTIFF_LZW) and (IOParams.TIFF_Compression<>ioTIFF_PACKBITS) then
     IOParams.TIFF_Compression:=ioTIFF_UNCOMPRESSED;
    if crec.qt.grayScale then
     IOParams.TIFF_PhotometInterpret:=ioTIFF_BLACKISZERO
    else
    begin
     IOParams.TIFF_PhotometInterpret:=ioTIFF_RGBPALETTE;
     if IOParams.BitsPerSample=16 then
      IOParams.BitsPerSample:=8;	// color image cannot be 16 bit gray scale
    end;
   end;

   if (IOParams.TIFF_PhotometInterpret=ioTIFF_RGBPALETTE) and (IOParams.SamplesPerPixel>1) then
    IOParams.TIFF_PhotometInterpret:=ioTIFF_RGB;
   if (IOParams.BitsPerSample>8) and (IOParams.SamplesPerPixel<>1) then
   begin
    IOParams.SamplesPerPixel:=3;
    IOParams.BitsPerSample:=8;
    IOParams.TIFF_PhotometInterpret:=ioTIFF_RGB;
   end;
   if ((IOParams.TIFF_PhotometInterpret=ioTIFF_BLACKISZERO) or (IOParams.TIFF_PhotometInterpret=ioTIFF_WHITEISZERO)) and
      (IOParams.BitsPerSample=8) and (IOParams.SamplesPerPixel=3) then
    IOParams.TIFF_PhotometInterpret:=ioTIFF_RGB;
   if (IOParams.TIFF_PhotoMetInterpret=ioTIFF_RGB) and (IOParams.SamplesPerPixel=1) and (IOParams.BitsPerSample=1) then
    IOParams.TIFF_PhotometInterpret:=ioTIFF_BLACKISZERO;
   if (IOParams.TIFF_PhotoMetInterpret=ioTIFF_YCBCR) and (IOParams.TIFF_Compression<>ioTIFF_JPEG) then
    IOParams.TIFF_PhotoMetInterpret:=ioTIFF_RGB;
   //
   crec.T4Options:=0;
   case IOParams.TIFF_PhotometInterpret of
    ioTIFF_WHITEISZERO: crec.Photomet:=ioTIFF_BLACKISZERO;
    ioTIFF_BLACKISZERO: crec.Photomet:=ioTIFF_BLACKISZERO;
    ioTIFF_RGBPALETTE:  crec.Photomet:=ioTIFF_RGBPALETTE;
    ioTIFF_RGB:			  crec.Photomet:=ioTIFF_RGB;
    ioTIFF_TRANSPMASK:  crec.Photomet:=ioTIFF_RGB;
    ioTIFF_CMYK:
     begin
      crec.Photomet:=ioTIFF_CMYK;
      IOParams.SamplesPerPixel:=4;
     end;
    ioTIFF_YCBCR:		  crec.Photomet:=ioTIFF_RGB;
    ioTIFF_CIELAB:		  crec.Photomet:=ioTIFF_CIELAB;
   else
    crec.Photomet:=ioTIFF_RGB;
   end; //case

   inv1bit:=false;
   case IOParams.TIFF_Compression of
    ioTIFF_LZW:
     begin
      crec.Compression:=5;	// LZW
      crec.Predictor:=2;
      if Assigned(IOParams.TIFF_LZWCompFunc) then
       crec.LZWCompFunc:=IOParams.TIFF_LZWCompFunc
      else
       if assigned(DefTIFF_LZWCOMPFUNC) then
        crec.LZWCompFunc:=DefTIFF_LZWCOMPFUNC
       else
       begin
        crec.Compression:=1;
        crec.Predictor:=1;
       end;
     end;

    ioTIFF_PACKBITS: crec.Compression:=32773;	// Packbits
    ioTIFF_CCITT1D:
     begin
      crec.Compression:=2;		// CCITT1D
      crec.Photomet:=ioTIFF_WHITEISZERO;
      inv1bit:=true;
     end;
    ioTIFF_G3FAX1D:
     begin
      crec.Compression:=3;		// G3FAX1D
      crec.Photomet:=ioTIFF_WHITEISZERO;
      inv1bit:=true;
     end;
    ioTIFF_G3FAX2D:
     begin
      crec.Compression:=3;	// G3FAX2D
      crec.T4Options:=1;
      crec.Photomet:=ioTIFF_WHITEISZERO;
      inv1bit:=true;
     end;
    ioTIFF_G4FAX:
     begin
      crec.Compression:=4;	 	// F4FAX
      crec.Photomet:=ioTIFF_WHITEISZERO;
      inv1bit:=true;
     end;
    ioTIFF_JPEG:
     begin
      crec.Compression:=7;		// new jpeg
      crec.jpegquality:=IOParams.TIFF_JPEGQuality;
      crec.jpegcolorspace:=IOParams.TIFF_JPEGColorSpace;
      case crec.jpegcolorspace of
       ioJPEG_RGB:     crec.Photomet:=ioTIFF_RGB;
       ioJPEG_GRAYLEV: crec.Photomet:=ioTIFF_BLACKISZERO;
       ioJPEG_YCbCr:   crec.Photomet:=ioTIFF_YCBCR;
       ioJPEG_CMYK:	 crec.Photomet:=ioTIFF_CMYK;
       ioJPEG_YCbCrK:  begin crec.Photomet:=ioTIFF_RGB; crec.jpegcolorspace:=ioJPEG_RGB; end;
      end;
     end;
    ioTIFF_ZIP: Assert(False, 'ZIP compression is not supported');
    else
     crec.Compression:=1; 		// no compression
   end; //case

   if (WBitmap.PixelFormat <> ie1g) and (crec.Compression > 1) and (crec.Compression < 5) then
   begin
    crec.Compression:=1;			// no compression
    inv1bit:=false;
   end;
   if (IOParams.BitsPerSample <> 8) or ((IOParams.SamplesPerPixel <> 1) and (IOParams.SamplesPerPixel <> 3)) or
      (crec.PhotoMet=ioTIFF_RGBPALETTE) or ((IOParams.BitsPerSample>1) and (crec.PhotoMet=ioTIFF_BLACKISZERO)) then
    crec.Predictor:=1;
   //
   if inv1bit then
   begin
    if wbitmap = bitmap then
    begin
     wbitmap:=TIEBitmap.Create;
     wbitmap.assign(bitmap);
    end;
    _Negative1BitEx(wbitmap);
   end;
  end;	// end of WBitmap<>nil
  //
  BasePos := Stream.Position;
  //
  WPosIFD:=0;
  SPosIFD:=0;
  if Ins then
  begin
  	// insert as TIFF_ImageIndex image
   Stream.Read(tifhead,sizeof(TTIFFHEADER)-4);	// read header minus posifd
   if tifhead.Id <> $4949 then
   begin
    Progress.Aborting^:=true;
    result:=0;
    exit;
   end;
   numi:=0;
		 repeat
   	q := Stream.Position;
   	Stream.Read(PosIFD,4);
    if (numi = IOParams.TIFF_ImageIndex) or	((PosIFD=0) and (numi < IOParams.TIFF_ImageIndex)) then
    begin
    	WPosIFD := q;
     SPosIFD := PosIFD;
    end;
    if (PosIFD=0) then
     break;
    Stream.Position := PosIFD;
    Stream.Read(nt,2);
    Stream.Seek(nt*sizeof(TTIFFTAG), soFromCurrent);
    inc(numi);
   until false;
   result := numi+1;
   Stream.Seek(0,soFromEnd);	// write from the end
  end
  else
  begin
	  SafeStreamWrite(Stream,Progress.Aborting^,tifhead,sizeof(TTIFFHEADER)); // writes an empty header
   result:=1;
  end;
	 // exif
  if IOParams.EXIF_HasEXIFData then
  begin
   // this also write imagedescription, dpix, dpiy and dpi unit
		 WriteExifBlock(imed,Stream,IOParams,Progress.Aborting^);
  end
  else
  begin
   // WriteExifBlock not called, then we have to write this
   WriteString(imed,Stream,270,IOParams.TIFF_ImageDescription,Progress.Aborting^);
   WriteSingleRational(imed,Stream,282,IOParams.DpiX,1,Progress.Aborting^);	// dpix
   WriteSingleRational(imed,Stream,283,IOParams.DpiY,1,Progress.Aborting^);	// dpiy
   WriteSingleShort(imed,296,2);	// inches units
  end;
  //
  if WBitmap <> nil then
  begin
		 WriteSingleLong(imed,256,WBitmap.Width);	// ImageWidth
	  WriteSingleLong(imed,257,WBitmap.Height);	// ImageHeight
   //
   if WBitmap.pixelformat = ie1g then
    WriteSingleShort(imed,258,1) // BitsPerSample: 1 bit x sample
   else
   begin
    case crec.Photomet of
     ioTIFF_CMYK: WriteMultiShort(imed,Stream,258,[8,8,8,8],Progress.Aborting^);	// CMYK
     ioTIFF_RGBPALETTE: WriteSingleShort(imed,258,IOParams.BitsPerSample);	// RGBPALETTE
     ioTIFF_BLACKISZERO: WriteSingleShort(imed,258,IOParams.BitsPerSample);	// RGBPALETTE
    else
     WriteMultiShort(imed,Stream,258,[8,8,8],Progress.Aborting^);	// RGB/YCBCR
    end;
   end;
   WriteSingleShort(imed,259,crec.Compression); 	// Compression
   if WBitmap.pixelformat = ie1g then
   begin
    case crec.Photomet of
     ioTIFF_WHITEISZERO: WriteSingleShort(imed,262,0);	// PhotometricInterpretation=0 (0=white)
     ioTIFF_BLACKISZERO: WriteSingleShort(imed,262,1);	// PhotometricInterpretation=1 (0=black)
    end;
   end
   else
   begin
    case crec.Photomet of
     ioTIFF_CMYK:        WriteSingleShort(imed,262,5);	// CMYK
     ioTIFF_CIELAB:      WriteSingleShort(imed,262,8); // CIELAB
     ioTIFF_RGBPALETTE:  WriteSingleShort(imed,262,3); // RGBPAlette
     ioTIFF_BLACKISZERO: WriteSingleShort(imed,262,1);	// PhotometricInterpretation=1 (0=black)
     ioTIFF_YCBCR:       WriteSingleShort(imed,262,6);	// YCBCR
    else
     WriteSingleShort(imed,262,2);		// PhotometricInterpretation=2 (RGB)
    end;
   end;
   WriteString(imed, Stream, 269, IOParams.TIFF_DocumentName, Progress.Aborting^);
   // some fax programs requires to send default and other parameters to work
   if (crec.Compression=2) or (crec.Compression=3) or (crec.Compression=4) then
   begin
   	WriteSingleShort(imed,266,1);	// FillOrder
    WriteSingleShort(imed,284,1); // Planar configuration
    WriteSingleShort(imed,327,0);	// CleanFaxData (0=no incorrect lines)
   end;
   //
   crec.BitsPerSample:=IOParams.BitsPerSample;
   // write strip
   laccess:=WBitmap.Access;
   WBitmap.Access:=[iedRead];
   WriteStrip(Stream,WBitmap,imed,crec,Progress);
   WBitmap.Access:=laccess;
  end;
   //
  if not Progress.Aborting^ then
  begin
  	if WBitmap <> nil then
   begin
    if WBitmap.pixelformat = ie1g then
     WriteSingleShort(imed,277,1)						// SamplesPerPixel: 1 sample x pixel
    else
     case crec.Photomet of
      ioTIFF_CMYK: WriteSingleShort(imed,277,4); // CMYK 4 sample x pixel
      ioTIFF_RGBPALETTE: WriteSingleShort(imed,277,1);   // RGBPALETTE, 1 sample x pixel
      ioTIFF_BLACKISZERO: WriteSingleShort(imed,277,1);   // GRAYSCALE, 1 sample x pixel
     else
      WriteSingleShort(imed,277,3);			 // SamplesPerPixel: 3 sample x pixel
     end; //case
    if crec.Predictor=2 then
     WriteSingleShort(imed,317,2);	// Predictor
    WriteString(imed,Stream,285,IOParams.TIFF_PageName,Progress.Aborting^);
    if IOParams.TIFF_XPos<>0 then
	    WriteSingleRational(imed,Stream,286,round(IOParams.TIFF_XPos*10000),10000,Progress.Aborting^);
    if IOParams.TIFF_YPos<>0 then
	    WriteSingleRational(imed,Stream,287,round(IOParams.TIFF_YPos*10000),10000,Progress.Aborting^);
    if (crec.Compression=3) then
     WriteSingleLong(imed,292,crec.T4Options)
    else
    	WriteSingleLong(imed,292,0);
    if (crec.Compression=3) or (crec.Compression=4) then
    	WriteSingleLong(imed,293,0);	// T6Options
    if (IOParams.TIFF_PageNumber<>0) or (IOParams.TIFF_PageCount<>0) then
     WriteMultiShort(imed,Stream,297,[IOParams.TIFF_PageNumber,IOParams.TIFF_PageCount],Progress.Aborting^);
    // NewSubfileType
    WriteSingleLong(imed,254,0);
    // Page number
    WriteMultiShort(imed,Stream,297,[0,0],Progress.Aborting^);
    // IPTC
    WriteIPTC(imed,Stream,IOParams,Progress.Aborting^);
    // Wang Imaging
			 WriteWang(imed,Stream,IOParams,Progress.Aborting^);
    // colormap
    if crec.Photomet=ioTIFF_RGBPALETTE then
    begin
     for q:=0 to ncol-1 do
     begin
      wcolormap[q]:=GlobalColorMap[q].r shl 8;
      wcolormap[q+ncol]:=GlobalColorMap[q].g shl 8;
      wcolormap[q+ncol*2]:=GlobalColorMap[q].b shl 8;
     end;
     WriteMultiShort(imed,Stream,320,slice(wcolormap,ncol*3),Progress.Aborting^);
    end;
   end;
   //
   w := Stream.Position;
   if (w and 1) <> 0 then
   begin
    inc(w);	// align to word
    q := 0;
    SafeStreamWrite(Stream,Progress.Aborting^,q,1);	// write an align byte
   end;
   if Ins then
   begin
    // insert image
    Stream.Position := WPosIFD;
    SafeStreamWrite(Stream,Progress.Aborting^,w,4);
   end
   else
   begin
    // write header
    Stream.Position:=BasePos;
    tifhead.Id:=$4949;
    tifhead.Ver:=42;
    tifhead.PosIFD := w;
    SafeStreamWrite(Stream,Progress.Aborting^,tifhead,sizeof(TTIFFHEADER));
   end;
   // write IFD
   Stream.Position:=w;
   tw:=imed.Count;
   SafeStreamWrite(Stream,Progress.Aborting^,tw,2);	// Numero tags
   ReorderTags(imed);
   for q:=0 to imed.count-1 do
   begin
	   SafeStreamWrite(Stream,Progress.Aborting^, PTIFFTAG(imed[q])^ , sizeof(TTIFFTAG) );
    dispose(PTIFFTAG(imed[q]));
   end;
   if Ins then
   begin
    // insert image
    SafeStreamWrite(Stream, Progress.Aborting^, SPosIFD, 4);
   end
   else
   begin
    q:=0;
    SafeStreamWrite(Stream,Progress.Aborting^,q,4);	// Prossimo IFD (nullo)
   end;
  end; 	// end of aborting
 finally
  if imed <> nil then
   imed.free;
  if (WBitmap <> nil) and (WBitmap <> Bitmap) then
   WBitmap.free;
  if crec.qt <> nil then
   crec.qt.free;
 end;
end;

function _DeleteTIFFImStream(Stream:TStream; idx:integer):integer;
begin
	result:=_DeleteTIFFImStreamGroup(Stream,@idx,1);
end;

function _DeleteTIFFImStreamGroup(Stream:TStream; idxlist:pintegerarray; idxcount:integer):integer;
const
	vsz:array [1..12] of integer=(1,1,2,4,8,1,1,2,4,8,4,8);	// size of tags
var
	TIFFHeader:TTIFFHeader;
   PosIFD,t,q:integer;
   Intel:boolean;
   numi,ii:integer;
   os:TMemoryStream;
   IFD:PIFD;
   nt,ww:word;
   wp,bp,lp1,lp2,lp3,lp4:integer;
   sz:integer;
   ia1,ia2:pintegerarray;
   wa1,wa2:pwordarray;
   xIdTag:word;	// tag identifier
   xDataType,lxDataType:word;	// data type
   xDataNum:integer; // data count
   xDataPos:integer; // data position
   tmpbuf:pointer;
   idx:integer;
begin
	result:=0;
	// read header (minus IFD position)
   bp:=Stream.Position;
	Stream.read(TIFFHeader,sizeof(TTIFFHeader)-4);	// doesn't read IFD position
   if (TIFFHeader.Id<>$4949) and (TIFFHeader.id<>$4D4D) then
      exit;
   Intel:=TIFFHeader.Id=$4949;
   // write header (minus IFD position)
   os:=TMemoryStream.Create;
   os.Size:=Stream.Size;
   os.Write(TIFFHeader,sizeof(TIFFHeader)-4);
   // IFD read loop
   numi:=0;
   idx:=0;
   wp:=os.Position;
   PosIFD:=0; os.Write(PosIFD,4);	// blank space for IFD position
   lp4:=0;	// watch-dog for auto-looping IFD
   repeat
   	Stream.Read(PosIFD,4);	// read IFD position
      if (PosIFD=0) or (lp4=PosIFD) then
      	break;	// end of images
      lp4:=PosIFD;
		PosIFD:=scSwapDWord(PosIFD, not Intel);
      Stream.Position:=PosIFD; // go to the IFD
		Stream.read(nt,2);	// read tags count
      nt:=scSwapWord(nt,not Intel);
      // read tags
		getmem(IFD,nt*sizeof(TTIFFTAG));
	   Stream.read(pbyte(IFD)^,sizeof(TTIFFTAG)*nt);
      lp3:=Stream.Position;	// save reading position
		//
      if (idx<idxcount) and (idxlist[idx]=numi) then
      	inc(idx)
      else begin
			// write tags
         ia1:=nil;
         ia2:=nil;
         wa1:=nil;
         lxDataType:=0;
         // search for StripByteCount or TileByteCount (we need them now)
         for t:=0 to nt-1 do
         	with IFD^[t] do begin
		      	xIdTag:=scSwapWord(IdTag,not Intel);
               if (xIdTag=279) or (xIdTag=325) then begin
                  xDataType:=scSwapWord(DataType,not Intel);
                  xDataNum:=scSwapDWord(DataNum,not Intel);
                  xDataPos:=scSwapDWord(DataPos,not Intel);
                  sz:=vsz[xDataType]*xDataNum;
                  lxDataType:=xDataType;
                  getmem(ia1,sz);
                  wa1:=pwordarray(ia1);
                  if sz>4 then begin
	                  Stream.Position:=xDataPos;
	                  Stream.Read(ia1^,sz);
                  end else
                  	CopyMemory(ia1,@DataPos,sz);
               end;
            end;
         for t:=0 to nt-1 do
         	with IFD^[t] do begin
		      	xIdTag:=scSwapWord(IdTag,not Intel);
               xDataType:=scSwapWord(DataType,not Intel);
               xDataNum:=scSwapDWord(DataNum,not Intel);
               xDataPos:=scSwapDWord(DataPos,not Intel);
					sz:=vsz[xDataType]*xDataNum;
               if (xIdTag=273) or (xIdTag=324) then begin
                  // we are reading StripOffsets or TileOffsets
                  getmem(ia2,sz);
                  wa2:=pwordarray(ia2);
                  if sz>4 then begin
	                  Stream.Position:=xDataPos;
	                  Stream.Read(ia2^,sz);
                  end else
                  	CopyMemory(ia2,@DataPos,sz);
                  // write data referenced by array
                  for q:=0 to xDataNum-1 do begin
                     if xDataType=3 then begin
                        // SHORT
                        Stream.Position:=scSwapWord(wa2^[q],not Intel);
                        ww:=os.Position;
                        wa2^[q]:=scSwapWord(ww,not Intel);
                     end else begin
                        // LONG
                        Stream.Position:=scSwapDWord(ia2^[q],not Intel);
                        ia2^[q]:=scSwapDWord(os.Position,not Intel);
                     end;
                     if lxDataType=3 then
                        os.CopyFrom(Stream, scSwapWord(wa1^[q],not Intel))	// SHORT
                     else
                        os.CopyFrom(Stream, scSwapDWord(ia1^[q],not Intel));	// LONG
                  end;
                  // write array
                  if sz>4 then begin
	                  DataPos:=scSwapDWord(os.Position,not Intel);
	                  os.Write(ia2^,sz);
                  end else
                  	CopyMemory(@DataPos,ia2,sz);
               end else if (sz>4) or (xDataType=2) then begin
               	// DataPos now point to an area of the file (it can be ASCII, too)
                  DataPos:=scSwapDWord(os.Position,not Intel);
                  Stream.Position:=xDataPos;
                  os.CopyFrom(Stream,sz);
               end;
	         end;
         freemem(ia2);
         freemem(ia1);
         // write IFD
         lp1:=os.Position;	// save IFD position
         ww:=scSwapWord(nt,not Intel);
			os.Write(ww,2);	// write tags count
			os.Write(IFD^,nt*sizeof(TTIFFTAG));
         lp2:=os.Position;	// save position of next reading
         // write IFD position
         os.Position:=wp;
         ii:=scSwapDWord(lp1,not Intel);
         os.Write(ii,4);
         os.Position:=lp2;	// point to next byte to reading
         wp:=lp2;
			PosIFD:=0; os.Write(PosIFD,4);	// write blank space for IFD position
         //
         inc(result);
      end;
		// free tags
      freemem(IFD);
      inc(numi);
      // point to the next byte to read
      Stream.Position:=lp3;
   until false;
   // write final IFD position (0)
   lp1:=os.Position;
   os.Position:=wp;
	PosIFD:=0; os.Write(PosIFD,4);
   // write "os" to Stream
	Stream.size:=bp;
   os.Position:=0;
   Stream.CopyFrom(os,lp1+1);
   os.free;
end;

function TIFFLoadTags(Stream:TStream; var numi:integer; ImageIndex:integer; var TIFFEnv:TTIFFEnv):boolean;
var
	TIFFHeader:TTIFFHeader;
   PosIFD:integer;
begin
	result:=false;
   fillmemory(@TIFFEnv,sizeof(TTIFFEnv),0);
	// read header
   TIFFEnv.Stream:=Stream;
   TIFFEnv.StreamBase:=0;
	Stream.read(TIFFHeader,sizeof(TTIFFHeader));
   if (TIFFHeader.Id<>$4949) and (TIFFHeader.id<>$4D4D) then
      exit;
   TIFFEnv.Intel:=TIFFHeader.Id=$4949;
   if not TIFFEnv.Intel then
		TIFFHeader.PosIFD:=IESwapDWord(TIFFHeader.PosIFD); // converts Intel header
   // read main IFD (of the selected image)
   TIFFEnv.IFD:=nil;
	numi:=0;
   PosIFD:=TIFFHeader.PosIFD;
   if PosIFD=0 then
      exit;
   if not TIFFReadIFD(ImageIndex,TIFFHeader.PosIFD,TIFFEnv,numi) then
   	exit;
   result:=true;
end;

procedure TIFFFreeTags(var TIFFEnv:TTIFFEnv);
begin
   // free memory allocated in TIFFEnv
   if TIFFEnv.IFD<>nil then
      freemem(TIFFEnv.IFD);
end;

// extract a TIFF from a multipage TIFF
procedure _ExtractTIFFImStream(Stream:TStream; idx:integer; OutStream:TStream);
const
	vsz:array [1..12] of integer=(1,1,2,4,8,1,1,2,4,8,4,8);	// size of tags
var
	TIFFHeader:TTIFFHeader;
   PosIFD,t,q:integer;
   Intel:boolean;
   numi,ii:integer;
   IFD:PIFD;
   nt,ww:word;
   wp,lp1,lp2,lp3,lp4:integer;
   sz:integer;
   ia1,ia2:pintegerarray;
   wa1,wa2:pwordarray;
   xIdTag:word;	// tag identifier
   xDataType,lxDataType:word;	// data type
   xDataNum:integer; // data count
   xDataPos:integer; // data position
begin
	Stream.Position:=0;
	// read header (minus IFD position)
	Stream.read(TIFFHeader,sizeof(TTIFFHeader)-4);	// doesn't read IFD position
 if (TIFFHeader.Id<>$4949) and (TIFFHeader.id<>$4D4D) then
  exit;
 Intel:=TIFFHeader.Id=$4949;
 // write header (minus IFD position)
 OutStream.Write(TIFFHeader,sizeof(TIFFHeader)-4);
 // IFD read loop
 numi:=0;
 wp:=OutStream.Position;
 PosIFD:=0;
 OutStream.Write(PosIFD,4);	// blank space for IFD position
 lp4:=0;	// watch-dog for auto-looping IFD
 repeat
 	Stream.Read(PosIFD,4);	// read IFD position
  if (PosIFD=0) or (lp4=PosIFD) then
  	break;	// end of images
  lp4:=PosIFD;
		PosIFD:=scSwapDWord(PosIFD, not Intel);
  Stream.Position:=PosIFD; // go to the IFD
		Stream.read(nt,2);	// read tags count
  nt:=scSwapWord(nt,not Intel);
  // read tags
		getmem(IFD,nt*sizeof(TTIFFTAG));
	 Stream.read(pbyte(IFD)^,sizeof(TTIFFTAG)*nt);
  lp3:=Stream.Position;	// save reading position
		//
  if numi=idx then
  begin
		 // write tags
   ia1:=nil;
   ia2:=nil;
   wa1:=nil;
   lxDataType:=0;
   // search for StripByteCount or TileByteCount (we need them now)
   for t:=0 to nt-1 do
  	 with IFD^[t] do
    begin
		  	xIdTag:=scSwapWord(IdTag,not Intel);
     if (xIdTag=279) or (xIdTag=325) then
     begin
      xDataType:=scSwapWord(DataType,not Intel);
      xDataNum:=scSwapDWord(DataNum,not Intel);
      xDataPos:=scSwapDWord(DataPos,not Intel);
      sz:=vsz[xDataType]*xDataNum;
      lxDataType:=xDataType;
      getmem(ia1,sz);
      wa1:=pwordarray(ia1);
      if sz>4 then
      begin
	      Stream.Position:=xDataPos;
	      Stream.Read(ia1^,sz);
      end
      else
      	CopyMemory(ia1,@DataPos,sz);
     end;
    end;
   for t:=0 to nt-1 do
   	with IFD^[t] do
    begin
		  	xIdTag:=scSwapWord(IdTag,not Intel);
     xDataType:=scSwapWord(DataType,not Intel);
     xDataNum:=scSwapDWord(DataNum,not Intel);
     xDataPos:=scSwapDWord(DataPos,not Intel);
					sz:=vsz[xDataType]*xDataNum;
     if (xIdTag=273) or (xIdTag=324) then
     begin
      // we are reading StripOffsets or TileOffsets
      getmem(ia2,sz); wa2:=pwordarray(ia2);
      if sz>4 then
      begin
	      Stream.Position:=xDataPos;
	      Stream.Read(ia2^,sz);
      end
      else
      	CopyMemory(ia2,@DataPos,sz);
      // write data referenced by array
      for q:=0 to xDataNum-1 do begin
      if xDataType=3 then
      begin
       // SHORT
       Stream.Position:=scSwapWord(wa2^[q],not Intel);
       ww:=OutStream.Position;
       wa2^[q]:=scSwapWord(ww,not Intel);
      end
      else
      begin
       // LONG
       Stream.Position:=scSwapDWord(ia2^[q],not Intel);
       ia2^[q]:=scSwapDWord(OutStream.Position,not Intel);
      end;
      if lxDataType=3 then
       OutStream.CopyFrom(Stream, scSwapWord(wa1^[q],not Intel))	// SHORT
      else
       OutStream.CopyFrom(Stream, scSwapDWord(ia1^[q],not Intel));	// LONG
     end;
     // write array
     if sz > 4 then
     begin
	     DataPos:=scSwapDWord(OutStream.Position,not Intel);
	     OutStream.Write(ia2^,sz);
     end
     else
     	CopyMemory(@DataPos,ia2,sz);
    end
    else
     if (sz>4) (*or (xDataType=2)*) then
     begin
     	// DataPos now point to an area of the file (it can be ASCII, too)
      DataPos:=scSwapDWord(OutStream.Position,not Intel);
      Stream.Position:=xDataPos;
      OutStream.CopyFrom(Stream,sz);
     end;
	  end;
   freemem(ia2);
   freemem(ia1);
   // write IFD
   lp1:=OutStream.Position;	// save IFD position
   ww:=scSwapWord(nt,not Intel);
		 OutStream.Write(ww,2);	// write tags count
		 OutStream.Write(IFD^,nt*sizeof(TTIFFTAG));
   lp2:=OutStream.Position;	// save position of next reading
   // write IFD position
   OutStream.Position:=wp;
   ii:=scSwapDWord(lp1,not Intel);
   OutStream.Write(ii,4);
   OutStream.Position:=lp2;	// point to next byte to reading
   wp:=lp2;
		 PosIFD:=0; OutStream.Write(PosIFD,4);	// write blank space for IFD position
  end;
	 // free tags
  freemem(IFD);
  inc(numi);
  // point to the next byte to read
  Stream.Position:=lp3;
 until false;
 // write final IFD position (0)
 OutStream.Position:=wp;
	PosIFD:=0; OutStream.Write(PosIFD,4);
end;

function _InsertTIFFImStreamEx(Stream:TStream; ToInsert:TStream; idx:integer; OutStream:TStream; internal:boolean):integer;
const
	vsz:array [1..12] of integer=(1,1,2,4,8,1,1,2,4,8,4,8);	// size of tags
var
	TIFFHeader:TTIFFHeader;
   PosIFD,t,q:integer;
   numi,ii:integer;
   IFD:PIFD;
   nt,ww:word;
   wp,lp1,lp2,lp3,lp4:integer;
   sz:integer;
   ia1,ia2:pintegerarray;
   wa1,wa2:pwordarray;
   xIdTag:word;	// tag identifier
   xDataType,lxDataType:word;	// data type
   xDataNum:integer; // data count
   xDataPos:integer; // data position
   Intel:boolean;
begin
	Stream.Position:=0;
   // read header (minus IFD position)
   Stream.read(TIFFHeader,sizeof(TTIFFHeader)-4);	// doesn't read IFD position
   if (TIFFHeader.Id<>$4949) and (TIFFHeader.id<>$4D4D) then
      exit;
   Intel:=TIFFHeader.Id=$4949;
	if not Internal then begin
      // write header (minus IFD position)
      OutStream.Write(TIFFHeader,sizeof(TIFFHeader)-4);
   end;
   // IFD read loop
   numi:=0;
   wp:=OutStream.Position;
   PosIFD:=0; OutStream.Write(PosIFD,4);	// blank space for IFD position
   lp4:=0;	// watch-dog for auto-looping IFD
   repeat
		//
      if numi=idx then begin
      	// insert ToInsert here
         OutStream.Position:=OutStream.Position-4;
			wp:=_InsertTIFFImStreamEx(ToInsert,nil,-1,OutStream,true);
         inc(numi);
      end else begin
         Stream.Read(PosIFD,4);	// read IFD position
         if (PosIFD=0) or (lp4=PosIFD) then
            break;	// end of images
         lp4:=PosIFD;
         PosIFD:=scSwapDWord(PosIFD, not Intel);
         Stream.Position:=PosIFD; // go to the IFD
         Stream.read(nt,2);	// read tags count
         nt:=scSwapWord(nt,not Intel);
         // read tags
         getmem(IFD,nt*sizeof(TTIFFTAG));
         Stream.read(pbyte(IFD)^,sizeof(TTIFFTAG)*nt);
         lp3:=Stream.Position;	// save reading position
			// write tags
         ia1:=nil;
         ia2:=nil;
         wa1:=nil;
         lxDataType:=0;
         // search for StripByteCount or TileByteCount (we need them now)
         for t:=0 to nt-1 do
         	with IFD^[t] do begin
		      	xIdTag:=scSwapWord(IdTag,not Intel);
               if (xIdTag=279) or (xIdTag=325) then begin
                  xDataType:=scSwapWord(DataType,not Intel);
                  xDataNum:=scSwapDWord(DataNum,not Intel);
                  xDataPos:=scSwapDWord(DataPos,not Intel);
                  sz:=vsz[xDataType]*xDataNum;
                  lxDataType:=xDataType;
                  getmem(ia1,sz); wa1:=pwordarray(ia1);
                  if sz>4 then begin
	                  Stream.Position:=xDataPos;
	                  Stream.Read(ia1^,sz);
                  end else
                  	CopyMemory(ia1,@DataPos,sz);
               end;
            end;
         for t:=0 to nt-1 do
         	with IFD^[t] do begin
		      	xIdTag:=scSwapWord(IdTag,not Intel);
               xDataType:=scSwapWord(DataType,not Intel);
               xDataNum:=scSwapDWord(DataNum,not Intel);
               xDataPos:=scSwapDWord(DataPos,not Intel);
					sz:=vsz[xDataType]*xDataNum;
               if (xIdTag=273) or (xIdTag=324) then begin
                  // we are reading StripOffsets or TileOffsets
                  getmem(ia2,sz); wa2:=pwordarray(ia2);
                  if sz>4 then begin
	                  Stream.Position:=xDataPos;
	                  Stream.Read(ia2^,sz);
                  end else
                  	CopyMemory(ia2,@DataPos,sz);
                  // write data referenced by array
                  for q:=0 to xDataNum-1 do begin
                     if xDataType=3 then begin
                        // SHORT
                        Stream.Position:=scSwapWord(wa2^[q],not Intel);
                        ww:=OutStream.Position;
                        wa2^[q]:=scSwapWord(ww,not Intel);
                     end else begin
                        // LONG
                        Stream.Position:=scSwapDWord(ia2^[q],not Intel);
                        ia2^[q]:=scSwapDWord(OutStream.Position,not Intel);
                     end;
                     if lxDataType=3 then
                        OutStream.CopyFrom(Stream, scSwapWord(wa1^[q],not Intel))	// SHORT
                     else
                        OutStream.CopyFrom(Stream, scSwapDWord(ia1^[q],not Intel));	// LONG
                  end;
                  // write array
                  if sz>4 then begin
	                  DataPos:=scSwapDWord(OutStream.Position,not Intel);
	                  OutStream.Write(ia2^,sz);
                  end else
                  	CopyMemory(@DataPos,ia2,sz);
               end else if xIdTag=254 then begin
               	// correct NewSubfileType
                  DataPos:=scSwapDWord(xDataPos or 2,not Intel);	// 2 means this is a single page of a multipage image
               end else if (sz>4) then begin
               	// DataPos now point to an area of the file (it can be ASCII, too)
                  DataPos:=scSwapDWord(OutStream.Position,not Intel);
                  Stream.Position:=xDataPos;
                  OutStream.CopyFrom(Stream,sz);
               end;
	         end;
         freemem(ia2);
         freemem(ia1);
         // write IFD
         lp1:=OutStream.Position;	// save IFD position
         ww:=scSwapWord(nt,not Intel);
			OutStream.Write(ww,2);	// write tags count
			OutStream.Write(IFD^,nt*sizeof(TTIFFTAG));
         lp2:=OutStream.Position;	// save position of next reading
         // write IFD position
         OutStream.Position:=wp;
         ii:=scSwapDWord(lp1,not Intel);
         OutStream.Write(ii,4);
         OutStream.Position:=lp2;	// point to next byte to write
         wp:=lp2;
			PosIFD:=0; OutStream.Write(PosIFD,4);	// write blank space for IFD position
         // free tags
         freemem(IFD);
         inc(numi);
         // point to the next byte to read
         Stream.Position:=lp3;
      end;
   until false;
   if not Internal then begin
      // write final IFD position (0)
      OutStream.Position:=wp;
      PosIFD:=0; OutStream.Write(PosIFD,4);
   end;
   result:=wp;
end;

procedure _InsertTIFFImStream(Stream:TStream; ToInsert:TStream; idx:integer; OutStream:TStream);
begin
	_InsertTIFFImStreamEx(Stream,ToInsert,idx,OutStream,false);
end;

function GetNumDen(val:double; var den:integer):integer;
begin
	den:=RATMUL;
	while val*den>2147483640 do
   	den:=den div 10;
   result:=round(val*den);
end;

procedure WriteExifBlock(upimed:TList; Stream:TStream; var IOParams:TIOParamsVals; var Aborting:boolean);
var
	tg:PTIFFTAG;
   imed:TList;
   q,w:integer;
   tw:word;
   tmps:string;
   den:array [0..5] of integer;
begin
	// tags in upimed
   with IOParams do begin
      WriteString(upimed,Stream,270,EXIF_ImageDescription,Aborting);
      WriteSingleRational(upimed,Stream,282,trunc(EXIF_XResolution),1,Aborting);	// dpix
      WriteSingleRational(upimed,Stream,283,trunc(EXIF_YResolution),1,Aborting);	// dpiy
      WriteSingleShort(upimed,274,TIFF_Orientation);	// Orientation
      WriteSingleShort(upimed,296,2);	// inches units
      WriteString(upimed,Stream,305,EXIF_Software,Aborting);
		WriteString(upimed,Stream,271,EXIF_Make,Aborting);
	   WriteString(upimed,Stream,272,EXIF_Model,Aborting);
	   WriteString(upimed,Stream,306,EXIF_DateTime,Aborting);
		WriteMultiRational(upimed,Stream,318,[GetNumDen(EXIF_WhitePoint[0],den[0]),den[0],GetNumDen(EXIF_WhitePoint[1],den[1]),den[1]],Aborting);
      WriteSingleShort(upimed,531,EXIF_YCbCrPositioning);
      WriteMultiRational(upimed,Stream,319,[
      		GetNumDen(EXIF_PrimaryChromaticities[0],den[0]),den[0],
            GetNumDen(EXIF_PrimaryChromaticities[1],den[1]),den[1],
            GetNumDen(EXIF_PrimaryChromaticities[2],den[2]),den[2],
            GetNumDen(EXIF_PrimaryChromaticities[3],den[3]),den[3],
            GetNumDen(EXIF_PrimaryChromaticities[4],den[4]),den[4],
            GetNumDen(EXIF_PrimaryChromaticities[5],den[5]),den[5]],Aborting);
      WriteMultiRational(upimed,Stream,529,[
      		GetNumDen(EXIF_YCbCrCoefficients[0],den[0]),den[0],
            GetNumDen(EXIF_YCbCrCoefficients[1],den[1]),den[1],
            GetNumDen(EXIF_YCbCrCoefficients[2],den[2]),den[2]],Aborting);
      WriteMultiRational(upimed,Stream,532,[
      		GetNumDen(EXIF_ReferenceBlackWhite[0],den[0]),den[0],
            GetNumDen(EXIF_ReferenceBlackWhite[1],den[1]),den[1],
            GetNumDen(EXIF_ReferenceBlackWhite[2],den[2]),den[2],
            GetNumDen(EXIF_ReferenceBlackWhite[3],den[3]),den[3],
            GetNumDen(EXIF_ReferenceBlackWhite[4],den[4]),den[4],
            GetNumDen(EXIF_ReferenceBlackWhite[5],den[5]),den[5]],Aborting);
      WriteString(upimed,Stream,33432,EXIF_Copyright,Aborting);
   end;
	//
   imed:=nil;
   try
	imed:=TList.Create;
	// tags in imed
   with IOParams do begin
	   WriteSingleRational(imed,Stream,$829A,GetNumDen(EXIF_ExposureTime,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$829D,GetNumDen(EXIF_FNumber,den[0]),den[0],Aborting);
      WriteSingleShort(imed,$8822,EXIF_ExposureProgram);
      WriteMultiShort(imed,Stream,$8827,[EXIF_ISOSpeedRatings[0],EXIF_ISOSpeedRatings[1]],Aborting);
      WriteMiniString(imed,$9000,EXIF_ExifVersion);
      WriteString(imed,Stream,$9003,EXIF_DateTimeOriginal,Aborting);
      WriteString(imed,Stream,$9004,EXIF_DateTimeDigitized,Aborting);
      WriteSingleRational(imed,Stream,$9102,GetNumDen(EXIF_CompressedBitsPerPixel,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9201,GetNumDen(EXIF_ShutterSpeedValue,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9202,GetNumDen(EXIF_ApertureValue,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9203,GetNumDen(EXIF_BrightnessValue,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9204,GetNumDen(EXIF_ExposureBiasValue,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9205,GetNumDen(EXIF_MaxApertureValue,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$9206,GetNumDen(EXIF_SubjectDistance,den[0]),den[0],Aborting);
		WriteSingleShort(imed,$9207,EXIF_MeteringMode);
      WriteSingleShort(imed,$9208,EXIF_LightSource);
      WriteSingleShort(imed,$9209,EXIF_Flash);
      WriteSingleRational(imed,Stream,$920A,GetNumDen(EXIF_FocalLength,den[0]),den[0],Aborting);
		WriteString(imed,Stream,$9290,EXIF_SubsecTime,Aborting);
      WriteString(imed,Stream,$9291,EXIF_SubsecTimeOriginal,Aborting);
      WriteString(imed,Stream,$9292,EXIF_SubsecTimeDigitized,Aborting);
      WriteMiniString(imed,$A000,EXIF_FlashPixVersion);
      WriteSingleShort(imed,$A001,EXIF_ColorSpace);
      WriteSingleShort(imed,$A002,EXIF_ExifImageWidth);	// could be also LONG
      WriteSingleShort(imed,$A003,EXIF_ExifImageHeight);	// could be also LONG
      WriteString(imed,Stream,$A004,EXIF_RelatedSoundFile,Aborting);
      WriteSingleRational(imed,Stream,$A20E,GetNumDen(EXIF_FocalPlaneXResolution,den[0]),den[0],Aborting);
      WriteSingleRational(imed,Stream,$A20F,GetNumDen(EXIF_FocalPlaneYResolution,den[0]),den[0],Aborting);
      WriteSingleShort(imed,$A210,EXIF_FocalPlaneResolutionUnit);
      WriteSingleRational(imed,Stream,$A215,GetNumDen(EXIF_ExposureIndex,den[0]),den[0],Aborting);
      WriteSingleShort(imed,$A217,EXIF_SensingMethod);
      WriteSingleShort(imed,$A300,EXIF_FileSource);	// undefined?
      WriteSingleShort(imed,$A301,EXIF_SceneType);	// undefined?
      tmps:=EXIF_UserCommentCode+EXIF_UserComment;
		WriteString(imed,Stream,$9286,tmps,Aborting);
   end;
   //
   w:=Stream.Position;
   if (w and 1)<>0 then begin
      inc(w);	// align to word
      q:=0;
      SafeStreamWrite(Stream,Aborting,q,1);	// write an align byte
   end;
   // write IFD
   Stream.Position:=w;
   tw:=imed.Count;
   SafeStreamWrite(Stream,Aborting,tw,2);	// tags count
   ReorderTags(imed);
   for q:=0 to imed.count-1 do begin
      SafeStreamWrite(Stream,Aborting, PTIFFTAG(imed[q])^ , sizeof(TTIFFTAG) );
      dispose( PTIFFTAG(imed[q]) );
   end;
   q:=0;
   SafeStreamWrite(Stream,Aborting,q,4);	// next IFD (null)
   finally
      if imed<>nil then
         imed.free;
   end;
   // write EXIF tag (point to IFD)
	new(tg);
   tg^.IdTag:=34665;
   tg^.DataType:=4;
   tg^.DataNum:=1;
   tg^.DataPos:=w;
   upimed.add( tg );
   SafeStreamWrite(Stream,Aborting,w,sizeof(integer));
end;



end.
