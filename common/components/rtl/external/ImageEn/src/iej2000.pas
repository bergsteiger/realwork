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

unit iej2000;

{$R-}
{$Q-}
{$HINTS OFF}


{$I ie.inc}

{$ifdef IEINCLUDEJPEG2000}

interface

uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils, m0BCBRTL;

var
  __turboFloat: LongBool = False;

function J2KTryStreamJP2(Stream:TStream):boolean;
function J2KTryStreamJ2K(Stream:TStream):boolean;
procedure J2KReadStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean);
procedure J2KWriteStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; format:integer);

implementation

uses IEView;

{$RANGECHECKS OFF}

{$Z4}


type

pjas_stream_t=pointer;
pjas_image_t=pointer;
pjas_matrix_t=pointer;

jas_image_cmptparm_t=record
	tlx:dword; //* The x-coordinate of the top-left corner of the component. */
	tly:dword; //* The y-coordinate of the top-left corner of the component. */
	hstep:dword; //* The horizontal sampling period in units of the reference grid. */
	vstep:dword; //* The vertical sampling period in units of the reference grid. */
	width:dword; //* The width of the component in samples. */
	height:dword; //* The height of the component in samples. */
	prec:word; //* The precision of the component sample data. */
	sgnd:integer; //* The signedness of the component sample data. */
end;
pjas_image_cmptparm_t=^jas_image_cmptparm_t;
jas_image_cmptparm_t_array=array [0..8192] of jas_image_cmptparm_t;
pjas_image_cmptparm_t_array=^jas_image_cmptparm_t_array;


/////// from jas

// initialization
procedure jas_init; external;

// streams
function jas_stream_fopen(filename,omode:PAnsiChar):pjas_stream_t; external;
procedure jas_stream_close(jstream:pjas_stream_t); external;
procedure jas_stream_flush(jstream:pjas_stream_t); external;

// Get the format of image data in a stream.
function jas_image_getfmt(jstream:pjas_stream_t):integer; external;

// Create an image from a stream in some specified format.
function jas_image_decode(jstream:pjas_stream_t; infmt:integer; inopts:PAnsiChar):pjas_image_t; external;

// Write an image to a stream in a specified format.
function jas_image_encode(image:pjas_image_t; jstream:pjas_stream_t; fmt:integer; optstr:PAnsiChar):integer; external;


// Delete a component from an image.
procedure jas_image_delcmpt(image:pjas_image_t; i:word); external;

// Read a rectangular region of an image component.
// The position and size of the rectangular region to be read is specified
// relative to the component's coordinate system.
function jas_image_readcmpt(image:pjas_image_t; cmptno:word; x,y,width,height:integer;data:pjas_matrix_t):integer; external;

// matrix (components)
function jas_matrix_create(numrows,numcols:integer):pjas_matrix_t; external;
procedure jas_matrix_destroy(matrix:pjas_matrix_t); external;

// Deallocate any resources associated with an image.
procedure jas_image_destroy(image:pjas_image_t); external;

// Clear the table of image formats.
procedure jas_image_clearfmts; external;

// Get the ID for the image format with the specified name.
function jas_image_strtofmt(s:PAnsiChar):integer; external;

// Get the name of the image format with the specified ID.
function jas_image_fmttostr(fmt:integer):PAnsiChar; external;

// Create an image.
function jas_image_create(numcmpts:word; cmptparms:pjas_image_cmptparm_t_array; colormodel:integer):pjas_image_t; external;

function jas_image_create0:pjas_image_t; external;

function jas_image_addcmpt(image:pjas_image_t; cmptno:word; cmptparm:pjas_image_cmptparm_t):integer; external;


function JAS_IMAGE_CT_COLOR(n:integer):integer;
begin
	result:=((n) and $7fff);
end;

function jas_image_getcmptbytype(image:pjas_image_t; ctype:integer):integer; external;

function jas_getdbglevel:integer; external;

function jas_setdbglevel(dbglevel:integer):integer; external;


procedure jas_image_writecmptsample(image:pjas_image_t; cmptno:integer; x, y:integer; v:dword); external;

procedure iejas_image_setcmpttype(image:pjas_image_t; cmptno:integer; ctype:integer); external;


//// end from jas


//// from xlib

// [IMAGE] Get the number of image components.
function iejas_image_numcmpts(image:pjas_image_t):integer; external;

// [IMAGE] The x-coordinate of the top-left corner of the image bounding box.
function iejas_image_getleft(image:pjas_image_t):integer; external;

// [IMAGE] The y-coordinate of the top-left corner of the image bounding box.
function iejas_image_gettop(image:pjas_image_t):integer; external;

// [IMAGE] The x-coordinate of the bottom-right corner of the image bounding box (plus one).
function iejas_image_getright(image:pjas_image_t):integer; external;

// [IMAGE] The y-coordinate of the bottom-right corner of the image bounding box (plus one).
function iejas_image_getbottom(image:pjas_image_t):integer; external;

// [MATRIX] get i,j value of the
function iejas_matrix_get(matrix:pjas_matrix_t; i, j:integer):integer; external;

// [IMAGE] Get the width of a component.
function iejas_image_cmptwidth(image:pjas_image_t; compno:integer):integer; external;

// [IMAGE] Get the height of a component.
function iejas_image_cmptheight(image:pjas_image_t; compno:integer):integer; external;

// [IMAGE] Get the precision of the sample data for a component.
function iejas_image_cmptprec(image:pjas_image_t; compno:integer):integer; external;

// [IMAGE] Get the width of the image in units of the image reference grid.
function iejas_image_width(image:pjas_image_t):integer; external;

// [IMAGE] Get the height of the image in units of the image reference grid.
function iejas_image_height(image:pjas_image_t):integer; external;

// [IMAGE] Get the color model used by the image.
function iejas_image_colorspace(image:pjas_image_t):integer; external;

procedure iejas_image_setcolorspace(image:pjas_image_t; colorspace:integer); external;

// [IMAGE] Get the x-coordinate of the top-left corner of a component.
function iejas_image_cmpttlx(image:pjas_image_t; cmptno:integer):integer; external;

// [IMAGE] Get the y-coordinate of the top-left corner of a component.
function iejas_image_cmpttly(image:pjas_image_t; cmptno:integer):integer; external;

// [IMAGE] Get the horizontal subsampling factor for a component
function iejas_image_cmpthstep(image:pjas_image_t; cmptno:integer):integer; external;

// [IMAGE] Get the vertical subsampling factor for a component.
function iejas_image_cmptvstep(image:pjas_image_t; cmptno:integer):integer; external;

///// end xlib

// color spaces
const JAS_IMAGE_CS_UNKNOWN=0;	//
const JAS_IMAGE_CS_GRAY=1;		// Standard Gray
const JAS_IMAGE_CS_RGB=2;		// Standard RGB
const JAS_IMAGE_CS_YCBCR=3;	// Standard YCC

// color models
const JAS_IMAGE_CM_GRAY=1;	// No color model (i.e., grayscale).
const JAS_IMAGE_CM_RGB=2;	// RGB color model.
const JAS_IMAGE_CM_YCC=3;	// YCC color model.

// components
const JAS_IMAGE_CT_RGB_R=0;
const JAS_IMAGE_CT_RGB_G=1;
const JAS_IMAGE_CT_RGB_B=2;
const JAS_IMAGE_CT_YCBCR_Y=0;
const JAS_IMAGE_CT_YCBCR_CB=1;
const JAS_IMAGE_CT_YCBCR_CR=2;
const JAS_IMAGE_CT_GRAY_Y=0;

const JPC_NUMAGGCTXS	=1;
const JPC_NUMZCCTXS	=9;
const JPC_NUMMAGCTXS	=3;
const JPC_NUMSCCTXS	=5;
const JPC_NUMUCTXS	=1;
const JPC_AGGCTXNO	=0;
const JPC_ZCCTXNO		=(JPC_AGGCTXNO + JPC_NUMAGGCTXS);
const JPC_MAGCTXNO	=(JPC_ZCCTXNO + JPC_NUMZCCTXS);
const JPC_SCCTXNO		=(JPC_MAGCTXNO + JPC_NUMMAGCTXS);
const JPC_UCTXNO		=(JPC_SCCTXNO + JPC_NUMSCCTXS);
const JPC_NUMCTXS		=(JPC_UCTXNO + JPC_NUMUCTXS);
var
_jpc_zcctxnolut:array [0..4*256] of integer;
_jpc_spblut:array [0..256] of integer;
_jpc_scctxnolut:array [0..256] of integer;
_jpc_magctxnolut:array [0..4096] of integer;
_jpc_signmsedec:array [0..128] of integer;
_jpc_refnmsedec:array [0..128] of integer;
_jpc_signmsedec0:array [0..128] of integer;
_jpc_refnmsedec0:array [0..128] of integer;
_jpc_mqctxs:array [0..JPC_NUMCTXS] of integer;


function vctocc(i,co,cs:integer):integer;
begin
	result:=(i-co)div cs;
end;

procedure sdword(var v:dword);
var
   p1,p2:PAnsiChar;
   q:dword;
begin
   q:=v;
   p2:=PAnsiChar(pointer(@q));
   p1:=PAnsiChar(pointer(@v));
   p1[0]:=p2[3];
   p1[1]:=p2[2];
   p1[2]:=p2[1];
   p1[3]:=p2[0];
end;

procedure sword(var v:word);
var
   p1,p2:PAnsiChar;
   q:word;
begin
   q:=v;
   p2:=PAnsiChar(pointer(@q));
   p1:=PAnsiChar(pointer(@v));
   p1[0]:=p2[1];
   p1[1]:=p2[0];
end;

// return true if is a jp2 stream
function J2KTryStreamJP2(Stream:TStream):boolean;
var
   base:integer;
   dw1,dw2,dw3:dword;
begin
   base:=Stream.position;
   result:=false;
   // try jp2 - try jp2 signature
   Stream.read(dw1,4);  // LBox
   Stream.read(dw2,4);  // TBox
   Stream.read(dw3,4);  // DBox
   sdword(dw1);
   sdword(dw2);
   sdword(dw3);
   if (dw1=12) and (dw2=$6A502020) and (dw3=$0D0A870A) then
      result:=true;
   //
   Stream.position:=base;
end;

// return true if is a jpc or j2k stream
function J2KTryStreamJ2K(Stream:TStream):boolean;
var
   base:integer;
   dw1,dw2,dw3:dword;
   w1,w2:word;
begin
   base:=Stream.position;
   result:=false;
   // try j2k, jpc -SOC, SIZ
   Stream.read(w1,2);   // SOC
   Stream.read(w2,2);   // SIZ
   sword(w1);
   sword(w2);
   if (w1=$FF4F) and (w2=$FF51) then
      result:=true;
   //
   Stream.position:=base;
end;

(*
// note xml field must be freed
type TIEJ2PInfo = record
   // jP\32\32
   signature:dword;
   // jp2h->ihdr
   version_major:byte;
   version_minor:byte;
   components:word;
   height,width:dword;
   bpc:byte;   // can be 0 if components hasn't some bit depth
   compression:byte;
   UnkC:byte;
   IPR:byte;
   // jp2h->ihdr->resc
   VRc:double; // samples/meter
   HRc:double; // samples/meter
   // jp2h->ihdr->resd
   VRd:double; // samples/meter
   HRd:double; // samples/meter
   // XML boxes
   xml:TList;   // pointer list to zero terminated strings
end;

// create xml TList object (to free it and its elements)
// doesn't read 64 bits boxes
// save stream position
procedure IEJ2PReadInfo(stream:TStream; var info:TIEJ2PInfo);
   //
   function ReadBox(instream:TStream):boolean;
   var
      LBox:dword;
      TBox:dword;
      tmps:TMemoryStream;
      VRN:word;
      VRD:word;
      HRN:word;
      HRD:word;
      VRE:shortint;  // 8 bit signed
      HRE:shortint;  // 8 bit signed
      bb:byte;
      xmlitem:PAnsiChar;
      i:integer;
   begin
      result:=true;
      while instream.position<instream.size do begin
         instream.Read(LBox,4); // Box length
         sdword(LBox);
         instream.Read(TBox,4); // Box type
         sdword(TBox);
         if (LBox=1) then
            result:=false
         else begin
            if LBox=0 then
               LBox:=instream.size-instream.position;
            case TBox of
               // jP\32\32 : JP2 Signature box
               $6A502020: instream.read(info.signature,4);
               // jp2h : JP2 Header box (superbox)
               $6A703268:
                  begin
                     tmps:=TMemoryStream.Create;
                     tmps.CopyFrom(instream,LBox-8);
                     tmps.position:=0;
                     ReadBox(tmps);
                     tmps.free;
                  end;
               // jp2h->ihdr : Image header box
               $69686472:
                  begin
                     instream.read(info.height,4); sDWord(info.height);
                     instream.read(info.width,4); sDWord(info.width);
                     instream.read(info.components,2); sWord(info.components);
                     instream.read(info.bpc,1);
                     instream.read(info.compression,1);
                     instream.read(info.UnkC,1);
                     instream.read(info.IPR,1);
                  end;
               // jp2h->res : Resolution box (superbox)
               $72657320:
                  begin
                     tmps:=TMemoryStream.Create;
                     tmps.CopyFrom(instream,LBox-8);
                     tmps.position:=0;
                     ReadBox(tmps);
                     tmps.free;
                  end;
               // jp2h->res->resc : Capture resolution box
               $72657363:
                  begin
                     instream.read(VRN,16); sword(VRN);
                     instream.read(VRD,16); sword(VRD);
                     instream.read(HRN,16); sword(HRN);
                     instream.read(HRD,16); sword(HRD);
                     instream.read(bb,8); VRE:=not (bb-1);
                     instream.read(bb,8); HRE:=not (bb-1);
                     info.VRc:=(VRN/VRD)*IEPower(10,VRE);
                     info.HRc:=(HRN/HRD)*IEPower(10,HRE);
                  end;
               // jp2h->res->resd : Default Display resolution box
               $72657364:
                  begin
                     instream.read(VRN,16); sWord(VRN);
                     instream.read(VRD,16); sWord(VRD);
                     instream.read(HRN,16); sWord(HRN);
                     instream.read(HRD,16); sWord(HRD);
                     instream.read(VRE,8);
                     instream.read(HRE,8);
                     info.VRd:=(VRN/VRD)*IEPower(10,VRE);
                     info.HRd:=(HRN/HRD)*IEPower(10,HRE);
                  end;
               // xml\032 : XML boxes
               $786D6C20:
                  begin
                     i:=LBox-8+1;
                     getmem(xmlitem,i);
                     instream.read(xmlitem^,i-1);
                     xmlitem[i-1]:=#0;
                     info.xml.Add(xmlitem);
                  end;
               // unknown box
               else
                  instream.Seek(LBox-8,soFromCurrent);  // bypass
            end;  // end case
         end;
      end;  // end while
   end;
   //
var
   lpos:integer;
begin
   fillchar(info,sizeof(TIEJ2PInfo),0);
   info.xml:=TList.Create;
   lpos:=Stream.position;
   ReadBox(stream);
   Stream.position:=lpos;
end;
*)

var
    CrToRedTable, CbToBlueTable, CrToGreenTable, CbToGreenTable: array [0..255] of Integer;
    YCbCrCoefficients: array[0..2] of Single;

procedure CreateYCbCrLookup;
var
   F1, F2, F3, F4: Single;
   LumaRed,
   LumaGreen,
   LumaBlue: Single;
   I: Integer;
   Offset1: Integer;
begin
   YCbCrCoefficients[0] := 0.299;
   YCbCrCoefficients[1] := 0.587;
   YCbCrCoefficients[2] := 0.114;
   LumaRed := YCbCrCoefficients[0];
   LumaGreen := YCbCrCoefficients[1];
   LumaBlue := YCbCrCoefficients[2];
   F1 := 2 - 2 * LumaRed;
   F2 := LumaRed * F1 / LumaGreen;
   F3 := 2 - 2 * LumaBlue;
   F4 := LumaBlue * F3 / LumaGreen;
   Offset1 := -128;
   for I := 0 to 255 do begin
      CrToRedTable[I] := Round(F1 * Offset1);
      CbToBlueTable[I] := Round(F3 * Offset1);
      CrToGreenTable[I] := -Round(F2 * Offset1);
      CbToGreenTable[I] := -Round(F4 * Offset1);
      Inc(Offset1);
   end;
end;

procedure J2KReadStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean);
var
	js:pjas_stream_t;
   im:pjas_image_t;
   numcmpts,numc:integer;
   color:boolean;
   i,j,k,q,x,y:integer;
   prow:pbyte;
   depth:integer;
   colormodel:integer;
   image_width,image_height:integer;
   cmp:array [0..10] of integer;
   mt:array [0..10] of pjas_matrix_t;
   v:array [0..3] of integer;
   u:array [0..3] of double;
   arx0,ary0:pintegerarray;
	arx1,ary1:pintegerarray;
   arx2,ary2:pintegerarray;
begin
   //jas_setdbglevel(1000);
   if (not J2KTryStreamJP2(Stream)) and (not J2KTryStreamJ2K(Stream)) then begin
      xProgress.Aborting^:=true;
      exit;
   end;
	js:=jas_stream_fopen(pointer(Stream),'rb');
   im:=jas_image_decode(js,-1,nil);
   jas_stream_close(js);
   if im=nil then begin
      xProgress.Aborting^:=true;
      exit;
   end;
   image_width:=iejas_image_width(im);
   image_height:=iejas_image_height(im);
   color:=true;
   numc:=3;
   case iejas_image_colorspace(im) of
   	JAS_IMAGE_CS_RGB:
      	begin
         	cmp[0]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_R)); if cmp[0]>255 then cmp[0]:=0;
            cmp[1]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_G)); if cmp[1]>255 then cmp[1]:=1;
            cmp[2]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_B)); if cmp[2]>255 then cmp[2]:=2;
            IOParams.BitsPerSample:=iejas_image_cmptprec(im,cmp[0]);
            IOParams.SamplesPerPixel:=3;
         end;
      JAS_IMAGE_CS_YCBCR:
      	begin
         	cmp[0]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_Y));  if cmp[0]>255 then cmp[0]:=0;
            cmp[1]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_CB)); if cmp[1]>255 then cmp[1]:=0;
            cmp[2]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_CR)); if cmp[2]>255 then cmp[2]:=0;
            IOParams.BitsPerSample:=iejas_image_cmptprec(im,cmp[0]);
            IOParams.SamplesPerPixel:=3;
         end;
      JAS_IMAGE_CS_GRAY:
      	begin
         	cmp[0]:=jas_image_getcmptbytype(im,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_GRAY_Y));  if cmp[0]>255 then cmp[0]:=0;
            IOParams.BitsPerSample:=iejas_image_cmptprec(im,cmp[0]);
            IOParams.SamplesPerPixel:=1;
            numc:=1;
            color:=false;
         end;
      else begin
         // unsupported color space
         xProgress.Aborting^:=true;
         jas_image_destroy(im);
         exit;
      end;
   end;
   IOParams.DpiX:=gDefaultDPIX;
   IOParams.DpiY:=gDefaultDPIY;
   if IOParams.ColorMap<>nil then begin
   	freemem(IOParams.ColorMap);
      IOParams.fColorMap:=nil;
      IOParams.fColorMapCount:=0;
   end;
   IOParams.Width:=image_width;
   IOParams.Height:=image_height;
   if not Preview then begin
      numcmpts := iejas_image_numcmpts(im);	// samples per pixel
      for q:=0 to numcmpts-1 do begin
         mt[q]:=jas_matrix_create( iejas_image_cmptheight(im,q), iejas_image_cmptwidth(im,q) );
         jas_image_readcmpt( im,q,0,0,iejas_image_cmptwidth(im,q),iejas_image_cmptheight(im,q),mt[q] );
      end;
      Bitmap.Width:=1; Bitmap.Height:=1;
      if (IOParams.BitsPerSample=1) and (IOParams.SamplesPerPixel=1) then
         bitmap.pixelformat:=ie1g
      else
         bitmap.pixelformat:=ie24RGB;
      bitmap.height:=image_height;
      bitmap.width:=image_width;
      xProgress.per1:=100/image_height;
		//
      arx0:=nil;
      ary0:=nil;
      arx1:=nil;
      ary1:=nil;
      arx2:=nil;
      ary2:=nil;
		//
      if numc=3 then begin
         getmem(arx0,sizeof(integer)*image_width);
         getmem(ary0,sizeof(integer)*image_height);
         getmem(arx1,sizeof(integer)*image_width);
         getmem(ary1,sizeof(integer)*image_height);
         getmem(arx2,sizeof(integer)*image_width);
         getmem(ary2,sizeof(integer)*image_height);
         for i:=0 to image_height-1 do begin
            ary0[i]:=vctocc(i,iejas_image_cmpttly(im,cmp[0]),iejas_image_cmptvstep(im,cmp[0]));
            if (ary0[i]<0) or (ary0[i]>=iejas_image_cmptheight(im,cmp[0])) then
               ary0[i]:=0;
            ary1[i]:=vctocc(i,iejas_image_cmpttly(im,cmp[1]),iejas_image_cmptvstep(im,cmp[1]));
            if (ary1[i]<0) or (ary1[i]>=iejas_image_cmptheight(im,cmp[1])) then
               ary1[i]:=0;
            ary2[i]:=vctocc(i,iejas_image_cmpttly(im,cmp[2]),iejas_image_cmptvstep(im,cmp[2]));
            if (ary2[i]<0) or (ary2[i]>=iejas_image_cmptheight(im,cmp[2])) then
               ary0[i]:=0;
            for j:=0 to image_width-1 do begin
               arx0[j]:=vctocc(j,iejas_image_cmpttlx(im,cmp[0]),iejas_image_cmpthstep(im,cmp[0]));
               if (arx0[j]<0) or (arx0[j]>=iejas_image_cmptwidth(im,cmp[0])) then
                  arx0[j]:=0;
               arx1[j]:=vctocc(j,iejas_image_cmpttlx(im,cmp[1]),iejas_image_cmpthstep(im,cmp[1]));
               if (arx1[j]<0) or (arx1[j]>=iejas_image_cmptwidth(im,cmp[1])) then
                  arx1[j]:=0;
               arx2[j]:=vctocc(j,iejas_image_cmpttlx(im,cmp[2]),iejas_image_cmpthstep(im,cmp[2]));
               if (arx2[j]<0) or (arx2[j]>=iejas_image_cmptwidth(im,cmp[2])) then
                  arx2[j]:=0;
            end;
         end;
      end;
      if numc=1 then begin
         getmem(arx0,sizeof(integer)*image_width);
         getmem(ary0,sizeof(integer)*image_height);
         for i:=0 to image_height-1 do begin
            ary0[i]:=vctocc(i,iejas_image_cmpttly(im,cmp[0]),iejas_image_cmptvstep(im,cmp[0]));
            if (ary0[i]<0) or (ary0[i]>=iejas_image_cmptheight(im,cmp[0])) then
               ary0[i]:=0;
            for j:=0 to image_width-1 do begin
               arx0[j]:=vctocc(j,iejas_image_cmpttlx(im,cmp[0]),iejas_image_cmpthstep(im,cmp[0]));
               if (arx0[j]<0) or (arx0[j]>=iejas_image_cmptwidth(im,cmp[0])) then
                  arx0[j]:=0;
            end;
         end;
      end;
		//
      if color then begin
         for i:=0 to image_height-1 do begin
            prow:=bitmap.scanline[i];
            for j:=0 to image_width-1 do begin
               v[0]:= (iejas_matrix_get(mt[cmp[0]],ary0[i],arx0[j]) shl (32-iejas_image_cmptprec(im,cmp[0]))) shr 24;
               v[1]:= (iejas_matrix_get(mt[cmp[1]],ary1[i],arx1[j]) shl (32-iejas_image_cmptprec(im,cmp[1]))) shr 24;
               v[2]:= (iejas_matrix_get(mt[cmp[2]],ary2[i],arx2[j]) shl (32-iejas_image_cmptprec(im,cmp[2]))) shr 24;
               case iejas_image_colorspace(im) of
                  JAS_IMAGE_CS_RGB:
                  	begin
                        prow^:=v[2]; inc(prow);
                        prow^:=v[1]; inc(prow);
                        prow^:=v[0]; inc(prow);
                     end;
                  JAS_IMAGE_CS_YCBCR:
                     begin
                        u[0] := blimit(v[0] + CrToRedTable[v[2]]);
                        u[1] := blimit(v[0] + CbToGreenTable[v[1]] + CrToGreentable[v[2]]);
                        u[2] := blimit(v[0] + CbToBlueTable[v[1]]);
                        v[0]:=trunc(u[0]);
                        v[1]:=trunc(u[1]);
                        v[2]:=trunc(u[2]);
                        prow^:=blimit(v[2]); inc(prow);
                        prow^:=blimit(v[1]); inc(prow);
                        prow^:=blimit(v[0]); inc(prow);
                     end;
               end;
            end;
            // OnProgress
            with xProgress do
               if assigned(fOnProgress) then
                  fOnProgress(Sender,trunc(per1*(i)));
            if xProgress.Aborting^ then
               break;
         end;
      end else begin
         for i:=0 to image_height-1 do begin
            prow:=bitmap.scanline[i];
            for j:=0 to image_width-1 do begin
               v[0]:= (iejas_matrix_get(mt[cmp[0]],ary0[i],arx0[j]) shl (32-iejas_image_cmptprec(im,cmp[0]))) shr 24;
               v[1]:=v[0];
               v[2]:=v[0];
               if bitmap.pixelformat=ie24RGB then begin
                  // color or gray scale
                  prow^:=v[2]; inc(prow);
                  prow^:=v[1]; inc(prow);
                  prow^:=v[0]; inc(prow);
               end else begin
                  // black/white
                  _SetPixelbw(pbyte(prow),j,v[0]);
               end;
            end;
            // OnProgress
            with xProgress do
               if assigned(fOnProgress) then
                  fOnProgress(Sender,trunc(per1*(i)));
            if xProgress.Aborting^ then
               break;
         end;
      end;
      //
      for q:=0 to numcmpts-1 do
         jas_matrix_destroy(mt[q]);
      freemem(arx0);
      freemem(ary0);
      if numc=3 then begin
	      freemem(arx1);
   	   freemem(ary1);
      	freemem(arx2);
     		freemem(ary2);
      end;
   end;  // not preview
   jas_image_destroy(im);
end;

// fmt can be JAS_IMAGE_CM_GRAY(1), JAS_IMAGE_CM_RGB(2), JAS_IMAGE_CM_YCC(3)
// format: 0=jp2 1=j2k/jpc
procedure J2KWriteStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; format:integer);
var
   js:pjas_stream_t;
   im:pjas_image_t;
   cmptparams:jas_image_cmptparm_t;
   outopts:AnsiString;
   ww,hh,y,x,vv,colors:integer;
   row:PRGB;
   yy,cb,cr:integer;
   nullpr:TProgressRec;
begin
   with nullpr do begin
	   Aborting:=xProgress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
   //
   im:=nil;
	js:=jas_stream_fopen(pointer(Stream),'w+b');
   ww:=Bitmap.Width;
   hh:=Bitmap.Height;
   cmptparams.tlx:=0;
   cmptparams.tly:=0;
   cmptparams.hstep:=1;
   cmptparams.vstep:=1;
   cmptparams.width:=ww;
   cmptparams.height:=hh;
   if Bitmap.PixelFormat=ie1g then begin
      IOParams.BitsPerSample:=1;
      IOParams.J2000_ColorSpace:=ioJ2000_GRAYLEV;
   end;
   cmptparams.prec:=IOParams.BitsPerSample;
   colors:=(1 shl IOParams.BitsPerSample)-1;
   cmptparams.sgnd:=0;
	xProgress.per1:=100/hh;
   xProgress.val:=0;
   case IOParams.J2000_ColorSpace of
      ioJ2000_GRAYLEV:
         begin
            // gray scale or black/white
            im:=jas_image_create(1,@cmptparams,JAS_IMAGE_CM_GRAY);
            iejas_image_setcmpttype(im,0,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_GRAY_Y));
            if bitmap.pixelformat=ie24RGB then begin
               // gray scale
               for y:=0 to hh-1 do begin
                  row:=Bitmap.Scanline[y];
                  for x:=0 to ww-1 do begin
                     with row^ do begin
                        vv:=trunc((((r*21 + g*71 + b*8) div 100)/255)*colors);
                        jas_image_writecmptsample(im,0,x,y,vv);
                     end;
                     inc(row);
                  end;
                  // OnProgress
                  with xProgress do
                     if assigned(fOnProgress) then
                        fOnProgress(Sender,trunc(per1*y));
                  if xProgress.Aborting^ then
                     break;
               end;
            end else begin
               // black/white
               for y:=0 to hh-1 do begin
                  row:=Bitmap.Scanline[y];
                  for x:=0 to ww-1 do begin
                     if _GetPixelbw(pbyte(row),x)<>0 then
                        jas_image_writecmptsample(im,0,x,y,1)
                     else
                        jas_image_writecmptsample(im,0,x,y,0);
                  end;
                  // OnProgress
                  with xProgress do
                     if assigned(fOnProgress) then
                        fOnProgress(Sender,trunc(per1*y));
                  if xProgress.Aborting^ then
                     break;
               end;
            end;
         end;
      ioJ2000_YCbCr, // for now YCC=RGB
      ioJ2000_RGB:
         begin
            im:=jas_image_create0();
            iejas_image_setcolorspace(im,JAS_IMAGE_CS_RGB);
            jas_image_addcmpt(im,0,@cmptparams);
            jas_image_addcmpt(im,1,@cmptparams);
            jas_image_addcmpt(im,2,@cmptparams);
            iejas_image_setcmpttype(im,0,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_R));
            iejas_image_setcmpttype(im,1,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_G));
            iejas_image_setcmpttype(im,2,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_RGB_B));
            for y:=0 to hh-1 do begin
               row:=Bitmap.Scanline[y];
               for x:=0 to ww-1 do begin
                  with row^ do begin
                     jas_image_writecmptsample(im,0,x,y,trunc(r/255*colors));
                     jas_image_writecmptsample(im,1,x,y,trunc(g/255*colors));
                     jas_image_writecmptsample(im,2,x,y,trunc(b/255*colors));
                  end;
                  inc(row);
               end;
               // OnProgress
               with xProgress do
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per1*y));
               if xProgress.Aborting^ then
                  break;
            end;
         end;
      // Attention: YCbCr is not supported for writing. Unfortunately only Y channel is loaded.
      (*
      ioJ2000_YCbCr:
         begin
            im:=jas_image_create0();
            iejas_image_setcolorspace(im,JAS_IMAGE_CS_YCBCR);
            jas_image_addcmpt(im,0,@cmptparams);
            jas_image_addcmpt(im,1,@cmptparams);
            jas_image_addcmpt(im,2,@cmptparams);
            iejas_image_setcmpttype(im,0,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_Y));
            iejas_image_setcmpttype(im,1,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_CB));
            iejas_image_setcmpttype(im,2,JAS_IMAGE_CT_COLOR(JAS_IMAGE_CT_YCBCR_CR));
            for y:=0 to hh-1 do begin
               row:=Bitmap.Scanline[y];
               for x:=0 to ww-1 do begin
                  with row^ do begin
                     yy:=trunc(  0.29900 * R + 0.58700 * G + 0.11400 * B        );
                     cb:=trunc( -0.16874 * R - 0.33126 * G + 0.50000 * B  + 128 );
                     Cr:=trunc(  0.50000 * R - 0.41869 * G - 0.08131 * B  + 128 );
                     jas_image_writecmptsample(im,0,x,y,yy);
                     jas_image_writecmptsample(im,1,x,y,cb);
                     jas_image_writecmptsample(im,2,x,y,cr);
                  end;
                  inc(row);
               end;
               // OnProgress
               with xProgress do
                  if assigned(fOnProgress) then
                     fOnProgress(Sender,trunc(per1*y));
               if xProgress.Aborting^ then
                  break;
            end;
         end;
      //*)
   end;
   outopts:='rate='+floattostr(IOParams.J2000_Rate);
   if IOParams.J2000_ScalableBy=ioJ2000_Rate then
   	outopts:=outopts+' prg=lrcp'
	else if IOParams.J2000_ScalableBy=ioJ2000_Resolution then
   	outopts:=outopts+' prg=rlcp';
   jas_image_encode(im, js, format, PAnsiChar(outopts));
   jas_stream_flush(js);
   jas_stream_close(js);
   if im<>nil then
      jas_image_destroy(im);
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////



(*function _malloc(size: Integer): Pointer; cdecl;
begin
	result:=allocmem(size);
end;*)

(*procedure _free(P: Pointer); cdecl;
begin
	FreeMem(P);
end;*)

(*function _memset(P: Pointer; B: Byte; count: Integer):pointer; cdecl;
begin
	FillChar(P^, count, B);
   result:=P;
end;*)

(*function _memcpy(dest, source: Pointer; count: Integer):pointer; cdecl;
begin
	Move(source^, dest^, count);
   result:=dest;
end;*)

function __ftol: integer;
var
	f: double;
begin
	asm
   	lea    eax, f             //  BC++ passes floats on the FPU stack
    	fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  	end;
   if f>2147483647.0 then
   	f:=2147483647.0;
   if f<-2147483648.0 then
   	f:=2147483648.0;
  	result := integer(Trunc(f));
end;

procedure __assert(__cond:PAnsiChar; __file:PAnsiChar; __line:integer); cdecl;
begin
end;

(*procedure _abort; cdecl;
begin
end;*)

procedure _iejdebug(p:PAnsiChar); cdecl;
begin
   //
   //outputdebugstring(p);
end;


(*function _memmove(dest, source: Pointer; count: Integer):pointer; cdecl;
begin
	Move(source^, dest^, count);
   result:=dest;
end;*)


(*function _strlen(str:PAnsiChar):integer; cdecl;
begin
	result:=strlen(str);
end;*)

(*function _realloc(block:pointer;size:integer):pointer; cdecl;
begin
	reallocmem(block,size);
   result:=block;
end;*)

function _fscanf(f:pointer; format:PAnsiChar):integer; cdecl;
begin
   result:=0;
end;

// not used in Jasper
procedure _unlink; cdecl;
begin
end;

// not used in Jasper
procedure _setmode; cdecl;
begin
end;

// not used in Jasper
procedure _fputc; cdecl;
begin
end;

type
	(*
   TIETmpStream=class(TMemoryStream)
   	public
      	destructor Destroy; override;
      	constructor Create;
   end;

   constructor TIETmpStream.Create;
   begin
   	inherited;
   end;

   destructor TIETmpStream.Destroy;
   begin
      inherited;
   end;
   //*)


   //(*
   TIETmpStream=class(TFileStream)
      private
         fFileName:AnsiString;
      public
         constructor Create;
         destructor Destroy; override;
   end;

   constructor TIETmpStream.Create;
   var
    	temppath:array [0..MAX_PATH] of AnsiChar;
      tempfile:array [0..MAX_PATH] of AnsiChar;
   begin
      if DefTEMPPATH='' then begin
         GetTempPathA(250,temppath);
         IEForceDirectories(AnsiString(temppath));
         GetTempFileNameA(temppath,'imageen',0,tempfile);
      end else
         GetTempFileNameA(PAnsiChar(DefTEMPPATH),'imageen',0,tempfile);
      inherited Create(AnsiString(tempfile),fmCreate);
      fFileName:=AnsiString(tempfile);
   end;

   destructor TIETmpStream.Destroy;
   begin
      inherited;
      deletefile(fFileName);
   end;
   //*)


function _open(path:PAnsiChar; access,mode:integer):integer; cdecl;
var
   ss:TIETmpStream;
begin
   if path='TEMPSTREAM' then begin
      result:=integer( TIETmpStream.Create )
   end else
   	result:=integer(path);
end;

function _read(stream:integer; buf:pointer; len:integer):integer; cdecl;
var
	st:tstream;
begin
	st:=TStream(pointer(stream));
   result:=st.Read(pbyte(buf)^,len);
end;

function _close(stream:integer):integer; cdecl;
var
   st:tstream;
begin
   result:=0;
   st:=TStream(pointer(stream));
   if (st is TIETmpStream) then begin
      st.free;
   end;
end;

function _write(stream:integer; buf:pointer; len:integer):integer; cdecl;
var
   st:tstream;
begin
   st:=TStream(pointer(stream));
   result:=st.Write(pbyte(buf)^,len);
end;

function _lseek(stream:integer; offset:integer; fromwhere:integer):integer; cdecl;
var
   st:tstream;
begin
   st:=TStream(pointer(stream));
   case fromwhere of
      0: // SEEK_SET
      	result:=st.seek(offset,soFromBeginning);
   	1: // SEEK_CUR
      	result:=st.seek(offset,soFromCurrent);
      2: // SEEK_END
      	result:=st.seek(offset,soFromEnd);
      else result:=-1;
   end;
end;

// we suppose that s is not null
function _tmpnam(s:PAnsiChar):PAnsiChar; cdecl;
begin
   result:=s;
   strpcopy(s,'TEMPSTREAM');
end;

// used only for stdio io
procedure _fread; cdecl;
begin
end;

// used only for stdio io
function _fwrite(buf:PAnsiChar; size,n:integer; fil:pointer):integer; cdecl;
begin
   result:=size*n;
end;

// used only for stdio io
procedure _fseek; cdecl;
begin
end;

// used only for stdio io
procedure _fclose; cdecl;
begin
end;

function _isspace(c:integer):integer; cdecl;
begin
   result:=integer(c<=32);
end;

function _isalpha(c:integer):integer; cdecl;
begin
   result:=integer( ((c>=65) and (c<=90)) or ((c>=97) and (c<=122)) or (c=95));
end;

function _isdigit(c:integer):integer; cdecl;
begin
   result:=integer( (c>=48) and (c<=57) );
end;

function _atol(s:PAnsiChar):integer; cdecl;
begin
   result:=strtointdef(s,0);
end;

function _strchr(s:PAnsiChar; c:integer):PAnsiChar; cdecl;
begin
   result:=strscan(s,AnsiChar(c));
end;

function _atof(s:PAnsiChar):double; cdecl;
var
   q:AnsiString;
   p1:integer;
begin
   q:=AnsiString(s);
   p1:=pos(' ',q);
   if p1=0 then p1:=length(q)+1;
   setlength(q,p1-1);
   result:=IEStrToFloatDef(q,0);
end;

function _sqrt(x:double):double; cdecl;
begin
	result:=sqrt(x);
end;

function _strrchr(s:PAnsiChar; c:integer):PAnsiChar; cdecl;
begin
	result:=strrscan(s,AnsiChar(c));
end;

function _isprint(c:integer):integer; cdecl;
begin
   result:=integer(c>31);
end;

function _strncpy(dest,src:PAnsiChar; maxlen:integer):PAnsiChar; cdecl;
begin
   result:=strmove(dest,src,maxlen);
end;

procedure __llmul;
asm
		push	edx
		push	eax
		mov		eax, [esp+16]
		mul		dword ptr [esp]
		mov		ecx, eax
		mov		eax, [esp+4]
		mul		dword ptr [esp+12]
		add		ecx, eax
		mov		eax, [esp]
		mul		dword ptr [esp+12]
		add		edx, ecx
		pop		ecx
		pop		ecx
		ret		8
end;

procedure __lldiv;
asm
		push    ebp
		push    ebx
		push    esi
		push    edi
		xor		edi,edi
		mov     ebx,20[esp]
		mov     ecx,24[esp]
		or      ecx,ecx
		jnz     @__lldiv@slow_ldiv
		or      edx,edx
		jz      @__lldiv@quick_ldiv
		or      ebx,ebx
		jz      @__lldiv@quick_ldiv
@__lldiv@slow_ldiv:
		or      edx,edx
		jns     @__lldiv@onepos
		neg     edx
		neg     eax
		sbb     edx,0
		or      edi,1
@__lldiv@onepos:
		or      ecx,ecx
		jns     @__lldiv@positive
		neg     ecx
		neg     ebx
		sbb     ecx,0
		xor		edi,1
@__lldiv@positive:
		mov     ebp,ecx
		mov     ecx,64
		push    edi
		xor     edi,edi
		xor     esi,esi
@__lldiv@xloop:
		shl     eax,1
		rcl     edx,1
		rcl     esi,1
		rcl     edi,1
		cmp     edi,ebp
		jb      @__lldiv@nosub
		ja      @__lldiv@subtract
		cmp     esi,ebx
		jb      @__lldiv@nosub
@__lldiv@subtract:
		sub     esi,ebx
		sbb     edi,ebp
		inc     eax
@__lldiv@nosub:
		loop    @__lldiv@xloop
		pop     ebx
		test    ebx,1
		jz      @__lldiv@finish
		neg     edx
		neg     eax
		sbb     edx,0
@__lldiv@finish:
		pop     edi
		pop     esi
		pop     ebx
		pop     ebp
		ret     8
@__lldiv@quick_ldiv:
		div     ebx
		xor     edx,edx
		jmp     @__lldiv@finish
end;



procedure jpc_seglist_remove; external;
procedure jpc_seg_destroy; external;
procedure jpc_seglist_insert; external;
procedure jpc_decode; external;
procedure jp2_decode; external;
procedure jp2_encode; external;
procedure jp2_validate; external;
procedure jpc_seg_alloc; external;
procedure jas_stream_puts; external;

{$L jp2_enc.obj}
{$L jpc_enc.obj}
{$L jpc_dec.obj}
{$L jpc_t1dec.obj}
{$L jpc_t1enc.obj}
{$L jpc_t2enc.obj}
{$L jpc_t2dec.obj}
{$L jpc_t2cod.obj}
{$L jpc_t1cod.obj}
{$L jpc_tsfb.obj}
{$L jpc_qmfb.obj}
{$L jpc_mct.obj}
{$L jpc_bs.obj}
{$L jas_getopt.obj}
{$L jp2_dec.obj}
{$L jas_init.obj}
{$L jpc_mqdec.obj}
{$L jpc_mqenc.obj}
{$L jpc_mqcod.obj}
{$L jas_tvp.obj}
{$L jp2_cod.obj}
{$L jas_image.obj}
{$L jpc_cs.obj}
{$L jas_seq.obj}
{$L jas_malloc.obj}
{$L jas_stream.obj}
{$L jas_string.obj}
{$L jas_version.obj}
{$L jpc_math.obj}
{$L jpc_util.obj}
{$L jpc_tagtree.obj}
{$L jas_debug.obj}

{$L xlibcj2.obj}


initialization
   begin
      CreateYCbCrLookup;
     	jas_init;
   end;

finalization
   begin
      jas_image_clearfmts;
   end;

{$else}	// IEINCLUDEJPEG2000

interface

implementation

{$endif}

end.
