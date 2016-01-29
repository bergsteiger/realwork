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

unit tifccitt;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses iekdef, Types, QGraphics, Classes, hyiedefs, SysUtils;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, sysutils,classes,hyiedefs;
(*$endif*)

function CCITTHuffmanGetLine(dstbuf,srcbuf:pbyte; Width:integer; FillOrder:integer):integer;
function _CCITTHuffmanGetLine(dstbuf,srcbuf:pbyte; Width:integer; posb:integer; FillOrder:integer):integer;
function CCITT3_2D_GetLine(dstbuf,srcbuf:pbyte; srcbuflen:integer; Width:integer; predbuf:pbyte; posb:integer; FillOrder:integer; AlignEOL:boolean):integer;
procedure CCITTHuffmanPutLine(rdata:pbyte; wb:integer; fs:TStream; var Aborting:boolean);
procedure CCITTHuffmanPutLineG3(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var Aborting:boolean);
procedure CCITTHuffmanPutLineG32D(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var predline:pbyte; var Aborting:boolean);
procedure _CCITTHuffmanPutLine(rdata:pbyte; wb:integer; wbuf:pbyte; var wpos:integer);
procedure CCITTHuffmanPutLineG4(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var predline:pbyte; var Aborting:boolean);


implementation

uses hyieutils,ImageEnProc;

{$R-}

type

ppbyte=^pbyte;

TT4Entry = record
	dim:integer;	// numero di bit del codice
   code:word;		// codice (max 14 bit)
   rl:integer;		// run length
end;
PT4Entry=^TT4Entry;

const G3CODE_INVALID=-1;
const G3CODE_INCOMP=-2;
const G3CODE_EOL=-3;
const G3CODE_EOF=-4;

const
	bitmask:array [0..7] of byte=($80, $40, $20, $10, $08, $04, $02, $01);

   (*
   ibitmask32:array [0..31] of dword=(     $01,     $02,     $04,     $08,      $10,      $20,      $40,      $80,
   											      $100,    $200,    $400,    $800,    $1000,    $2000,    $4000,    $8000,
                                        $10000,  $20000,  $40000,  $80000,  $100000,  $200000,  $400000,  $800000,
                                      $1000000,$2000000,$4000000,$8000000,$10000000,$20000000,$40000000,$80000000);
	*)

   (*
	bitmask32:array [0..31] of dword=(
   $80000000, $40000000, $20000000, $10000000, $08000000, $04000000, $02000000, $01000000,
   $800000,   $400000,   $200000,   $100000,   $080000,   $040000,   $020000,   $010000,
   $8000,     $4000,     $2000,     $1000,     $0800,     $0400,     $0200,     $0100,
   $80,       $40,       $20,       $10,       $08,       $04,       $02,       $01
   );
   *)


const T4_2DC: array [0..12] of TT4Entry= (
	( dim:12; code:0), // 000000000000 (12 zeri)   - 0:INVALID
	( dim:4; code:1),	 // 0001		 - 1:pass
   ( dim:3; code:1),  // 001 		 - 2:horizzontal
   ( dim:7; code:2),  // 0000010 	 - 3:vertical Vl(3)
   ( dim:6; code:2),  // 000010 	 - 4:vertical Vl(2)
   ( dim:3; code:2),  // 010 		 - 5:vertical Vl(1)
   ( dim:1; code:1),  // 1 			 - 6:vertical V(0)
   ( dim:3; code:3),  // 011 		 - 7:vertical Vr(1)
   ( dim:6; code:3),  // 000011 	 - 8:vertical Vr(2)
   ( dim:7; code:3),  // 0000011 	 - 9:vertical Vr(3)
   ( dim:10; code:15),// 0000001111   - 10:extension 2-D (entrata in modo non compresso)
   ( dim:12; code:15),// 000000001111 - 11:extension 1-D (entrata in modo non compresso)
   ( dim:12; code:1)  // 0000 00000001 - 12:EOL
   );

type
   PT4Tree=^TT4Tree;
	TT4Tree=record
      code:integer;
      childs:array [0..1] of PT4Tree;	// if 0 and 1 is nil this is a terminal node
   end;

var T4Tree:array [0..1] of TT4Tree;


const NUMCODES=116+12;
const T4Codes: array [0..1,0..NUMCODES-1] of TT4Entry= ( (
	// WHITE CODES
    ( dim:8;code:$35; rl:0 ),	// 0011 0101
    ( dim:6;code:$7;rl:1 ),	// 0001 11
    ( dim:4;code:$7;rl:2 ),	// 0111
    ( dim:4;code:$8;rl:3 ),	// 1000
    ( dim:4;code:$B;rl:4 ),	// 1011
    ( dim:4;code:$C;rl:5 ),	// 1100
    ( dim:4;code:$E;rl:6 ),	// 1110
    ( dim:4;code:$F;rl:7 ),	// 1111
    ( dim:5;code:$13;rl:8 ),	// 1001 1
    ( dim:5;code:$14;rl:9 ),	// 1010 0
    ( dim:5;code:$7;rl:10 ),	// 0011 1
    ( dim:5;code:$8;rl:11 ),	// 0100 0
    ( dim:6;code:$8;rl:12 ),	// 0010 00
    ( dim:6;code:$3;rl:13 ),	// 0000 11
    ( dim:6;code:$34;rl:14 ),	// 1101 00
    ( dim:6;code:$35;rl:15 ),	// 1101 01
    ( dim:6;code:$2A;rl:16 ),	// 1010 10
    ( dim:6;code:$2B;rl:17 ),	// 1010 11
    ( dim:7;code:$27;rl:18 ),	// 0100 111
    ( dim:7;code:$C;rl:19 ),	// 0001 100
    ( dim:7;code:$8;rl:20 ),	// 0001 000
    ( dim:7;code:$17;rl:21 ),	// 0010 111
    ( dim:7;code:$3;rl:22 ),	// 0000 011
    ( dim:7;code:$4;rl:23 ),	// 0000 100
    ( dim:7;code:$28;rl:24 ),	// 0101 000
    ( dim:7;code:$2B;rl:25 ),	// 0101 011
    ( dim:7;code:$13;rl:26 ),	// 0010 011
    ( dim:7;code:$24;rl:27 ),	// 0100 100
    ( dim:7;code:$18;rl:28 ),	// 0011 000
    ( dim:8;code:$2;rl:29 ),	// 0000 0010
    ( dim:8;code:$3;rl:30 ),	// 0000 0011
    ( dim:8;code:$1A;rl:31 ),	// 0001 1010
    ( dim:8;code:$1B;rl:32 ),	// 0001 1011
    ( dim:8;code:$12;rl:33 ),	// 0001 0010
    ( dim:8;code:$13;rl:34 ),	// 0001 0011
    ( dim:8;code:$14;rl:35 ),	// 0001 0100
    ( dim:8;code:$15;rl:36 ),	// 0001 0101
    ( dim:8;code:$16;rl:37 ),	// 0001 0110
    ( dim:8;code:$17;rl:38 ),	// 0001 0111
    ( dim:8;code:$28;rl:39 ),	// 0010 1000
    ( dim:8;code:$29;rl:40 ),	// 0010 1001
    ( dim:8;code:$2A;rl:41 ),	// 0010 1010
    ( dim:8;code:$2B;rl:42 ),	// 0010 1011
    ( dim:8;code:$2C;rl:43 ),	// 0010 1100
    ( dim:8;code:$2D;rl:44 ),	// 0010 1101
    ( dim:8;code:$4;rl:45 ),	// 0000 0100
    ( dim:8;code:$5;rl:46 ),	// 0000 0101
    ( dim:8;code:$A;rl:47 ),	// 0000 1010
    ( dim:8;code:$B;rl:48 ),	// 0000 1011
    ( dim:8;code:$52;rl:49 ),	// 0101 0010
    ( dim:8;code:$53;rl:50 ),	// 0101 0011
    ( dim:8;code:$54;rl:51 ),	// 0101 0100
    ( dim:8;code:$55;rl:52 ),	// 0101 0101
    ( dim:8;code:$24;rl:53 ),	// 0010 0100
    ( dim:8;code:$25;rl:54 ),	// 0010 0101
    ( dim:8;code:$58;rl:55 ),	// 0101 1000
    ( dim:8;code:$59;rl:56 ),	// 0101 1001
    ( dim:8;code:$5A;rl:57 ),	// 0101 1010
    ( dim:8;code:$5B;rl:58 ),	// 0101 1011
    ( dim:8;code:$4A;rl:59 ),	// 0100 1010
    ( dim:8;code:$4B;rl:60 ),	// 0100 1011
    ( dim:8;code:$32;rl:61 ),	// 0011 0010
    ( dim:8;code:$33;rl:62 ),	// 0011 0011
    ( dim:8;code:$34;rl:63 ),	// 0011 0100
    ( dim:5;code:$1B;rl:64 ),	// 1101 1
    ( dim:5;code:$12;rl:128 ),	// 1001 0
    ( dim:6;code:$17;rl:192 ),	// 0101 11
    ( dim:7;code:$37;rl:256 ),	// 0110 111
    ( dim:8;code:$36;rl:320 ),	// 0011 0110
    ( dim:8;code:$37;rl:384 ),	// 0011 0111
    ( dim:8;code:$64;rl:448 ),	// 0110 0100
    ( dim:8;code:$65;rl:512 ),	// 0110 0101
    ( dim:8;code:$68;rl:576 ),	// 0110 1000
    ( dim:8;code:$67;rl:640 ),	// 0110 0111
    ( dim:9;code:$CC;rl:704 ),	// 0110 0110 0
    ( dim:9;code:$CD;rl:768 ),	// 0110 0110 1
    ( dim:9;code:$D2;rl:832 ),	// 0110 1001 0
    ( dim:9;code:$D3;rl:896 ),	// 0110 1001 1
    ( dim:9;code:$D4;rl:960 ),	// 0110 1010 0
    ( dim:9;code:$D5;rl:1024 ),	// 0110 1010 1
    ( dim:9;code:$D6;rl:1088 ),	// 0110 1011 0
    ( dim:9;code:$D7;rl:1152 ),	// 0110 1011 1
    ( dim:9;code:$D8;rl:1216 ),	// 0110 1100 0
    ( dim:9;code:$D9;rl:1280 ),	// 0110 1100 1
    ( dim:9;code:$DA;rl:1344 ),	// 0110 1101 0
    ( dim:9;code:$DB;rl:1408 ),	// 0110 1101 1
    ( dim:9;code:$98;rl:1472 ),	// 0100 1100 0
    ( dim:9;code:$99;rl:1536 ),	// 0100 1100 1
    ( dim:9;code:$9A;rl:1600 ),	// 0100 1101 0
    ( dim:6;code:$18;rl:1664 ),	// 0110 00
    ( dim:9;code:$9B;rl:1728 ),	// 0100 1101 1
    ( dim:11;code:$8;rl:1792 ),	// 0000 0001 000
    ( dim:11;code:$C;rl:1856 ),	// 0000 0001 100
    ( dim:11;code:$D;rl:1920 ),	// 0000 0001 101
    ( dim:12;code:$12;rl:1984 ),	// 0000 0001 0010
    ( dim:12;code:$13;rl:2048 ),	// 0000 0001 0011
    ( dim:12;code:$14;rl:2112 ),	// 0000 0001 0100
    ( dim:12;code:$15;rl:2176 ),	// 0000 0001 0101
    ( dim:12;code:$16;rl:2240 ),	// 0000 0001 0110
    ( dim:12;code:$17;rl:2304 ),	// 0000 0001 0111
    ( dim:12;code:$1C;rl:2368 ),	// 0000 0001 1100
    ( dim:12;code:$1D;rl:2432 ),	// 0000 0001 1101
    ( dim:12;code:$1E;rl:2496 ),	// 0000 0001 1110
    ( dim:12;code:$1F;rl:2560 ),	// 0000 0001 1111
    ( dim:12;code:$1;rl:G3CODE_EOL ),	// 0000 0000 0001
    ( dim:9;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 1
    ( dim:10;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 01
    ( dim:11;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 001
    ( dim:13;code:$1;rl:G3CODE_EOL ),	// 0000000000001
    ( dim:14;code:$1;rl:G3CODE_EOL ),	// 00000000000001
    ( dim:15;code:$1;rl:G3CODE_EOL ),	// 000000000000001
    ( dim:16;code:$1;rl:G3CODE_EOL ),	// 0000000000000001
    ( dim:17;code:$1;rl:G3CODE_EOL ),	// 00000000000000001
    ( dim:18;code:$1;rl:G3CODE_EOL ),	// 000000000000000001
    ( dim:19;code:$1;rl:G3CODE_EOL ),	// 0000000000000000001
    ( dim:20;code:$1;rl:G3CODE_EOL ),	// 00000000000000000001
	 //
	 ( dim:21;code:$1;rl:G3CODE_EOL ),	// 000000000000000000001
    ( dim:22;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000001
    ( dim:23;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000001
    ( dim:24;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000001
    ( dim:25;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000001
    ( dim:26;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000000001
    ( dim:27;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000000001
    ( dim:28;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000000001
    ( dim:29;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000000000001
    ( dim:30;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000000000001
    ( dim:31;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000000000001
    ( dim:32;code:$1;rl:G3CODE_EOL )	// 00000000000000000000000000000001
	),(

   // BLACK CODES
    ( dim:10;code:$37;rl:0 ),	// 0000 1101 11
    ( dim:3;code:$2;rl:1 ),	// 010
    ( dim:2;code:$3;rl:2 ),	// 11
    ( dim:2;code:$2;rl:3 ),	// 10
    ( dim:3;code:$3;rl:4 ),	// 011
    ( dim:4;code:$3;rl:5 ),	// 0011
    ( dim:4;code:$2;rl:6 ),	// 0010
    ( dim:5;code:$3;rl:7 ),	// 0001 1
    ( dim:6;code:$5;rl:8 ),	// 0001 01
    ( dim:6;code:$4;rl:9 ),	// 0001 00
    ( dim:7;code:$4;rl:10 ),	// 0000 100
    ( dim:7;code:$5;rl:11 ),	// 0000 101
    ( dim:7;code:$7;rl:12 ),	// 0000 111
    ( dim:8;code:$4;rl:13 ),	// 0000 0100
    ( dim:8;code:$7;rl:14 ),	// 0000 0111
    ( dim:9;code:$18;rl:15 ),	// 0000 1100 0
    ( dim:10;code:$17;rl:16 ),	// 0000 0101 11
    ( dim:10;code:$18;rl:17 ),	// 0000 0110 00
    ( dim:10;code:$8;rl:18 ),		// 0000 0010 00
    ( dim:11;code:$67;rl:19 ),	// 0000 1100 111
    ( dim:11;code:$68;rl:20 ),	// 0000 1101 000
    ( dim:11;code:$6C;rl:21 ),	// 0000 1101 100 
    ( dim:11;code:$37;rl:22 ),	// 0000 0110 111 
    ( dim:11;code:$28;rl:23 ),	// 0000 0101 000
    ( dim:11;code:$17;rl:24 ),	// 0000 0010 111 
    ( dim:11;code:$18;rl:25 ),	// 0000 0011 000
    ( dim:12;code:$CA;rl:26 ),	// 0000 1100 1010 
    ( dim:12;code:$CB;rl:27 ),	// 0000 1100 1011 
    ( dim:12;code:$CC;rl:28 ),	// 0000 1100 1100 
    ( dim:12;code:$CD;rl:29 ),	// 0000 1100 1101
    ( dim:12;code:$68;rl:30 ),	// 0000 0110 1000
    ( dim:12;code:$69;rl:31 ),	// 0000 0110 1001
    ( dim:12;code:$6A;rl:32 ),	// 0000 0110 1010
    ( dim:12;code:$6B;rl:33 ),	// 0000 0110 1011
    ( dim:12;code:$D2;rl:34 ),	// 0000 1101 0010
    ( dim:12;code:$D3;rl:35 ),	// 0000 1101 0011 
    ( dim:12;code:$D4;rl:36 ),	// 0000 1101 0100
    ( dim:12;code:$D5;rl:37 ),	// 0000 1101 0101
    ( dim:12;code:$D6;rl:38 ),	// 0000 1101 0110
    ( dim:12;code:$D7;rl:39 ),	// 0000 1101 0111
    ( dim:12;code:$6C;rl:40 ),	// 0000 0110 1100 
    ( dim:12;code:$6D;rl:41 ),	// 0000 0110 1101 
    ( dim:12;code:$DA;rl:42 ),	// 0000 1101 1010
    ( dim:12;code:$DB;rl:43 ),	// 0000 1101 1011
    ( dim:12;code:$54;rl:44 ),	// 0000 0101 0100
    ( dim:12;code:$55;rl:45 ),	// 0000 0101 0101 
    ( dim:12;code:$56;rl:46 ),	// 0000 0101 0110
    ( dim:12;code:$57;rl:47 ),	// 0000 0101 0111
    ( dim:12;code:$64;rl:48 ),	// 0000 0110 0100
    ( dim:12;code:$65;rl:49 ),	// 0000 0110 0101
    ( dim:12;code:$52;rl:50 ),	// 0000 0101 0010
    ( dim:12;code:$53;rl:51 ),	// 0000 0101 0011
    ( dim:12;code:$24;rl:52 ),	// 0000 0010 0100
    ( dim:12;code:$37;rl:53 ),	// 0000 0011 0111
    ( dim:12;code:$38;rl:54 ),	// 0000 0011 1000
    ( dim:12;code:$27;rl:55 ),	// 0000 0010 0111
    ( dim:12;code:$28;rl:56 ),	// 0000 0010 1000
    ( dim:12;code:$58;rl:57 ),	// 0000 0101 1000
    ( dim:12;code:$59;rl:58 ),	// 0000 0101 1001
    ( dim:12;code:$2B;rl:59 ),	// 0000 0010 1011
    ( dim:12;code:$2C;rl:60 ),	// 0000 0010 1100
    ( dim:12;code:$5A;rl:61 ),	// 0000 0101 1010
    ( dim:12;code:$66;rl:62 ),	// 0000 0110 0110
    ( dim:12;code:$67;rl:63 ),	// 0000 0110 0111
    ( dim:10;code:$F;rl:64 ),		// 0000 0011 11
    ( dim:12;code:$C8;rl:128 ),	// 0000 1100 1000
    ( dim:12;code:$C9;rl:192 ),	// 0000 1100 1001
    ( dim:12;code:$5B;rl:256 ),	// 0000 0101 1011
    ( dim:12;code:$33;rl:320 ),	// 0000 0011 0011 
    ( dim:12;code:$34;rl:384 ),	// 0000 0011 0100 
    ( dim:12;code:$35;rl:448 ),	// 0000 0011 0101
    ( dim:13;code:$6C;rl:512 ),	// 0000 0011 0110 0
    ( dim:13;code:$6D;rl:576 ),	// 0000 0011 0110 1
    ( dim:13;code:$4A;rl:640 ),	// 0000 0010 0101 0 
    ( dim:13;code:$4B;rl:704 ),	// 0000 0010 0101 1 
    ( dim:13;code:$4C;rl:768 ),	// 0000 0010 0110 0
    ( dim:13;code:$4D;rl:832 ),	// 0000 0010 0110 1
    ( dim:13;code:$72;rl:896 ),	// 0000 0011 1001 0 
    ( dim:13;code:$73;rl:960 ),	// 0000 0011 1001 1
    ( dim:13;code:$74;rl:1024 ),	// 0000 0011 1010 0
    ( dim:13;code:$75;rl:1088 ),	// 0000 0011 1010 1
    ( dim:13;code:$76;rl:1152 ),	// 0000 0011 1011 0
    ( dim:13;code:$77;rl:1216 ),	// 0000 0011 1011 1
    ( dim:13;code:$52;rl:1280 ),	// 0000 0010 1001 0
    ( dim:13;code:$53;rl:1344 ),	// 0000 0010 1001 1 
    ( dim:13;code:$54;rl:1408 ),	// 0000 0010 1010 0
    ( dim:13;code:$55;rl:1472 ),	// 0000 0010 1010 1
    ( dim:13;code:$5A;rl:1536 ),	// 0000 0010 1101 0
    ( dim:13;code:$5B;rl:1600 ),	// 0000 0010 1101 1
    ( dim:13;code:$64;rl:1664 ),	// 0000 0011 0010 0
    ( dim:13;code:$65;rl:1728 ),	// 0000 0011 0010 1 
    ( dim:11;code:$8;rl:1792 ),	// 0000 0001 000 
    ( dim:11;code:$C;rl:1856 ),	// 0000 0001 100 
    ( dim:11;code:$D;rl:1920 ),	// 0000 0001 101
    ( dim:12;code:$12;rl:1984 ),	// 0000 0001 0010
    ( dim:12;code:$13;rl:2048 ),	// 0000 0001 0011
    ( dim:12;code:$14;rl:2112 ),	// 0000 0001 0100
    ( dim:12;code:$15;rl:2176 ),	// 0000 0001 0101
    ( dim:12;code:$16;rl:2240 ),	// 0000 0001 0110
    ( dim:12;code:$17;rl:2304 ),	// 0000 0001 0111
    ( dim:12;code:$1C;rl:2368 ),	// 0000 0001 1100
    ( dim:12;code:$1D;rl:2432 ),	// 0000 0001 1101
    ( dim:12;code:$1E;rl:2496 ),	// 0000 0001 1110
    ( dim:12;code:$1F;rl:2560 ),	// 0000 0001 1111
    ( dim:12;code:$1;rl:G3CODE_EOL ),	// 0000 0000 0001
    ( dim:9;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 1
    ( dim:10;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 01
    ( dim:11;code:$1;rl:G3CODE_INVALID ),	// 0000 0000 001
    ( dim:13;code:$1;rl:G3CODE_EOL ),	// 0000000000001
    ( dim:14;code:$1;rl:G3CODE_EOL ),	// 00000000000001
    ( dim:15;code:$1;rl:G3CODE_EOL ),	// 000000000000001
    ( dim:16;code:$1;rl:G3CODE_EOL ),	// 0000000000000001
    ( dim:17;code:$1;rl:G3CODE_EOL ),	// 00000000000000001
    ( dim:18;code:$1;rl:G3CODE_EOL ),	// 000000000000000001
    ( dim:19;code:$1;rl:G3CODE_EOL ),	// 0000000000000000001
    ( dim:20;code:$1;rl:G3CODE_EOL ),	// 00000000000000000001
	 //
	 ( dim:21;code:$1;rl:G3CODE_EOL ),	// 000000000000000000001
    ( dim:22;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000001
    ( dim:23;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000001
    ( dim:24;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000001
    ( dim:25;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000001
    ( dim:26;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000000001
    ( dim:27;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000000001
    ( dim:28;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000000001
    ( dim:29;code:$1;rl:G3CODE_EOL ),	// 00000000000000000000000000001
    ( dim:30;code:$1;rl:G3CODE_EOL ),	// 000000000000000000000000000001
    ( dim:31;code:$1;rl:G3CODE_EOL ),	// 0000000000000000000000000000001
    ( dim:32;code:$1;rl:G3CODE_EOL )	// 00000000000000000000000000000001
) );

const horizcode:TT4Entry = ( dim:3; code:$1 );	// 001
const passcode:TT4Entry = ( dim:4; code:$1 );	// 0001
const vcodes:array [0..6] of TT4Entry= ( (dim:7; code:$3 ),	// 0000 011
                                         ( dim:6; code:$3 ),	// 0000 11
                                         ( dim:3; code:$3 ),	// 011
                                         ( dim:1; code:$1 ),	// 1
                                         ( dim:3; code:$2 ),	// 010
                                         ( dim:6; code:$2 ),	// 0000 10
                                         ( dim:7; code:$2 ) );// 0000 010


///////////////////////////////////////////////////////////////////////////////////////////
// converte 0 in 1 e 1 in 0
(*
function LNot(v:integer):integer;
begin
	//if v=0 then result:=1 else result:=0;
   result:= (not v) and $1;
end;
*)

function AdjustWithFillOrder(dwo:dword; posb:integer; FillOrder:integer):dword;
begin
   if FillOrder=1 then begin
		// inverte byte della dword dwo
		asm
	   	mov EAX,dwo
	   	bswap EAX
	      mov dwo,EAX
	   end;
      dwo:=(dwo shl (posb and 7));
   end else begin
   	dwo:=(dwo shr (posb and 7));
      ReverseBits(dwo);
   end;
 	result:=dwo;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// trova il codice corrispondente a quello puntato da posb
// srcbuf: puntatore di inizio bits
// posb: bit all'interno di srcbuf da leggere (inizio codice)
// WB: 0=usa white code     1=usa black code
function FindCode(srcbuf:pbyte; posb,WB:integer; FillOrder:integer):integer;
var
	ibi:integer;
   dwo:dword;
   q:integer;
   curtree:PT4Tree;
begin
	result:=NUMCODES;	// codice invalido
	ibi:=posb shr 3;	// divide per 8 (trova byte corrispondente)
   dwo:=pinteger(@pbytearray(srcbuf)^[ibi])^;
   dwo:=AdjustWithFillOrder(dwo,posb,FillOrder);
   // cerca codice
   curtree:=@(T4Tree[WB]);
   q:=31;
	repeat
      if curtree^.code<>NUMCODES then begin
      	result:=curtree^.code;
         break;
      end;
		curtree:=curtree^.childs[ ord((dwo and (1 shl q))<>0) ];
      dec(q);
   until q<0;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// trova il MODO corrispondente a quello puntato da posb
// srcbuf: puntatore di inizio bits
// posb: bit all'interno di srcbuf da leggere (inizio codice)
function FindMode(srcbuf:pbyte; posb:integer; FillOrder:integer):integer;
var
	ibi:integer;
   dwo,tdwo:dword;
   q:integer;
begin
	result:=0;	// codice invalido
	ibi:=posb shr 3;	// divide per 8 (trova byte corrispondente)
   dwo:=pinteger(@pbytearray(srcbuf)^[ibi])^;
	dwo:=AdjustWithFillOrder(dwo,posb,FillOrder);
   // cerca modo
	for q:=0 to 12 do begin
		tdwo:=dwo shr (32-T4_2DC[q].dim);
      if tdwo=T4_2DC[q].code then begin
      	result:=q;
         break;
      end;
	end;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// restituisce una parola formata dal numero di bit specificati (max 32)
function getpels(srcbuf:pbyte; posb:integer; nbit:integer; FillOrder:integer):integer;
var
	ibi:integer;
   dwo:dword;
begin
	ibi:=posb shr 3;	// divide per 8 (trova byte corrispondente)
   dwo:=pinteger(@pbytearray(srcbuf)^[ibi])^;
   dwo:=AdjustWithFillOrder(dwo,posb,FillOrder);
   //
   result:=dwo shr (32-nbit);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// decodifica codice non compresso dal buffer srcbuf, posizione (in bit) posb
// la lunghezza del codice restituito corrisponde al valore stesso del codice
function decode_uncomp_code(srcbuf:pbyte; posb:integer; FillOrder:integer):integer;
var
	ibi:integer;
   dwo,tdwo:dword;
   q:integer;
begin
	result:=0;	// codice invalido (i codici validi cominciano da 1..)
	ibi:=posb shr 3;	// divide per 8 (trova byte corrispondente)
   dwo:=pinteger(@pbytearray(srcbuf)^[ibi])^;
	dwo:=AdjustWithFillOrder(dwo,posb,FillOrder);
   //
	for q:=1 to 11 do begin
		tdwo:=dwo shr (32-q);
      if tdwo=1 then begin
      	result:=q;
         break;
      end;
	end;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// replica "1"(0) per "rl" volte
// destbuf = buffer di destinazione
// posw = bit all'interno di dstbuf (inizio scrittura)
// rl = numero di bit da replicare
// WB = bit da replicare invertito (0 o 1)
// Width = dimensione riga
procedure PutCode(dstbuf:pbyte; posw:integer; rl:integer; Width:integer);
var
	q:integer;
   ibi,abi:integer;
begin
   rl:=imin( Width-posw , rl );
   q:=0;
   while q<rl do begin
      ibi:=posw shr 3;
      abi:=(rl-q)and $FFF8;
      if ((posw and $7)=0) and (abi>0) then begin
         fillchar(pbyte(integer(dstbuf)+ibi)^,(rl-q) shr 3,0);
         inc(posw,abi);
         inc(q,abi);
      end else begin
         pbytearray(dstbuf)^[ibi]:=pbytearray(dstbuf)^[ibi] and (not bitmask[posw and 7]);
         inc(posw);
         inc(q);
      end;
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// decomprime riga HUFFMAN
// dstbuf = buffer destinazione (deve essere già allocato)
// srcbuf = buffer sorgente
// Width = dimensione riga in pixel
// posb = bit iniziale da leggere da srcbuf
// rest. prossimo bit da leggere (posb)
function _CCITTHuffmanGetLine(dstbuf,srcbuf:pbyte; Width:integer; posb:integer; FillOrder:integer):integer;
var
   c:integer;
   WB:integer;	// 0=white  1=black
   posw:integer;	// prossimo bit da scrivere
   lposb:integer;	// valore originale di posb
   tc:boolean;	// se true manca il terminating-code
begin
	if (Width and $7)<>0 then c:=1 else c:=0;
   fillmemory(dstbuf,(Width shr 3)+c,255);
	WB:=0;	// inizia con WHITE
   posw:=0;
   lposb:=posb;	// salva posb
   tc:=false;
   while (posw<Width) or tc do begin
		c:=FindCode(srcbuf,posb,WB,FillOrder);
      if c=NUMCODES then begin
         inc(posb);
         inc(lposb);
      end else begin
         with T4Codes[WB][C] do begin
            inc(posb,dim);
            if (rl=G3CODE_EOL) or (rl=G3CODE_EOF) then begin
               if (posb-dim)=lposb then begin
                  continue;	// EOL all'inizio riga, ignora
               end;
               // termina riga
               if WB<>0 then PutCode(dstbuf,posw,Width-posw+1,Width);
               inc(posw,Width-posw+1);
               c:=0;	// makes true c<64 (and tc=false), then exit loop
            end else if rl<>G3CODE_INVALID then begin
               if WB<>0 then PutCode(dstbuf,posw,rl,Width);
               inc(posw,rl);
            end;
         end;
         if c<64 then begin
            tc:=false;
            if WB=0 then WB:=1 else	WB:=0;
         end else
            tc:=true;
      end;
   end;	// loop w..Width-1
   result:=posb;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// decomprime riga HUFFMAN
// dstbuf = buffer destinazione (deve essere già allocato)
// srcbuf = buffer sorgente
// Width = dimensione riga in pixel
// rest. numero BYTE letti da srcbuf
// note: l'unica differenza tra G3FAX1D e HUFFMAN è che in quest'ultimo ogni riga
// ha una dimensione arrotondata al byte
function CCITTHuffmanGetLine(dstbuf,srcbuf:pbyte; Width:integer; FillOrder:integer):integer;
var
	posb:integer;
begin
	posb:=_CCITTHuffmanGetLine(dstbuf,srcbuf,Width,0,FillOrder);
   result:=posb shr 3;	// posb div 8
   if (posb mod 8)>0 then
   	inc(result);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// trova il primo pixel che è diverso da CL (0=black <>0=white)
// considera che i bit all'interno di buf sono invertiti (0=white 1=black)
// ipos=posizione iniziale (bit)
// Width=dimensione in pixel riga
// rest. posizione pixel (da 0..)
function finddiff(buf:pbyte; ipos:integer; Width:integer; CL:integer):integer;
var
	ibi,ibb:integer;
   by:integer;
   dw:pbyte;
begin
	while ipos<Width do begin
		// calcolare il bit "ipos"
		ibi:=ipos shr 3;	// byte corrispondente
      ibb:=ipos and 7;	// bit corrispondente
      if ibb=0 then begin
       	dw:=pointer(integer(buf)+ibi);
      	if CL=0 then
         	while (ipos<Width) and (dw^=$ff) do begin
               inc(ipos,8);
               inc(dw);
            end
         else
         	while (ipos<Width) and (dw^=0) do begin
               inc(ipos,8);
               inc(dw);
            end;
         if ipos>=Width then begin
         	ipos:=Width;
         	break;
         end;
         ibb:=0;
         while ipos<Width do begin
            by:=dw^ and (1 shl (7-ibb));
            if (cl=by) or ((cl<>0) and (by<>0)) then
               break;
            inc(ipos);
            inc(ibb);
         end;
         break;
      end;
      if ipos>=0 then
			by:=pbytearray(buf)^[ibi] and (1 shl (7-ibb))
      else
      	by:=1;
      if (cl=by) or ((cl<>0) and (by<>0)) then
      	break;
      inc(ipos);
   end;
   result:=ipos;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// decomprime riga CCITT 3 - 2D
// predbuf: linea precedente (è gestito automaticamente)
// posb = bit iniziale da leggere da srcbuf
// rest. prossimo bit da leggere (posb)
// NOTA: dstbuf deve essere inzializzato a ZERO.
function CCITT3_2D_GetLine(dstbuf,srcbuf:pbyte; srcbuflen:integer; Width:integer; predbuf:pbyte; posb:integer; FillOrder:integer; AlignEOL:boolean):integer;
var
   c,v,q:integer;
   WB:integer;	// 0=white  1=black
   CL:integer;	// colore corrente 0=black 1=white
   lposb:integer;	// valore originale di posb
   a0,b1,b2:integer;	// a0=era posw
   run1,run2:integer;
   maxlen:integer;
   dim:integer;
begin
	if (Width and $7)<>0 then dim:=1 else dim:=0;
   fillmemory(dstbuf,(Width shr 3)+dim,255);
	a0:=-1;
	CL:=1;	// inizia con WHITE
   lposb:=posb;	// salva posb
   maxlen:=srcbuflen shl 3;
   while (a0<Width) and (posb<maxlen) do begin
		c:=FindMode(srcbuf,posb,FillOrder);
      dim:=T4_2DC[c].dim;
  	   inc(posb,dim);
      if AlignEOL and (c=0) then begin
         repeat
            v:=getpels(srcbuf,posb,1,FillOrder);
            inc(posb);
            inc(dim);
         until v<>0;
         c:=12;
      end;
		case c of
         12:	// EOF
         	begin
               if lposb<>(posb-dim) then begin
               	// fine prematura della riga
                  if CL=0 then PutCode(dstbuf,a0,Width-a0,Width);
                  dec(posb,dim);
                  a0:=Width;
               end else begin
	            	v:=getpels(srcbuf,posb,1,FillOrder);
	              	inc(posb);	// salta prossimo bit
	            	if v=1 then begin	// decodifica ad una dimensione
		            	if a0<0 then a0:=0;
							posb:=_CCITTHuffmanGetLine(dstbuf,srcbuf,Width,posb,FillOrder);
		               inc(a0,Width);
	               end;
               end;
            end;
         1:		// PASS
         	begin
					b2:=finddiff(predbuf,a0,Width,(CL));
               b1:=finddiff(predbuf,b2,Width,(not CL) and $1);
               b2:=finddiff(predbuf,b1,Width,(CL));
               if a0<0 then a0:=0;
               if CL=0 then PutCode(dstbuf,a0,b2-a0,Width);
               a0:=b2;
            end;
         2:		// HORIZONTAL
         	begin
            	// run1
               WB:=(not CL) and $1;
               run1:=0;
               repeat
	               v:=FindCode(srcbuf,posb,WB,FillOrder);
	               inc(posb,T4Codes[WB][v].dim);
   	            inc(run1,T4Codes[WB][v].rl);
               until v<64;
               // run2
               WB:=CL;
               run2:=0;
               repeat
	               v:=FindCode(srcbuf,posb,WB,FillOrder);
	               inc(posb,T4Codes[WB][v].dim);
	               inc(run2,T4Codes[WB][v].rl);
               until v<64;
               if (run1>=0) and (run2>=0) then begin
               	if a0<0 then a0:=0;
						if a0+run1 > Width then
                  	run1:=Width-a0;
                  if CL=0 then PutCode(dstbuf,a0,run1,Width);
                  inc(a0,run1);
                  if a0+run2 > Width then
                  	run2:=Width-a0;
                  if CL<>0 then PutCode(dstbuf,a0,run2,Width);
                  inc(a0,run2);
               end;
            end;
         3..9:		// VERTICAL
         	begin
					b2:=finddiff(predbuf,a0,Width,(CL));
               b1:=finddiff(predbuf,b2,Width,(not CL) and $1);
               inc(b1, c-6);
               if a0<0 then a0:=0;
              	if CL=0 then begin
               	PutCode(dstbuf,a0,b1-a0,Width);
                  CL:=1;
               end else
               	CL:=0;
               a0:=b1;
            end;
         10..11: // MODO NON COMPRESSO (ATTENZIONE! NON TESTATA)
         	begin
					if a0<0 then a0:=0;
               repeat
               	v:=decode_uncomp_code(srcbuf,posb,FillOrder);
                  if v=0 then
                  	break;
                  inc(posb,v);
                  case v of
                  	1..5:
                     	begin
                        	run1:=v;
                           //PutCode(dstbuf,a0+run1-1,1,0,Width);	// not necessary
                           inc(a0,run1);
                        end;
                     6:
                     	begin
									inc(a0,5);
                        end;
                     7..11:
                     	begin
									run1:=v-7;
                           inc(a0,run1);
                           CL:=getpels(srcbuf,posb,1,FillOrder);
                           inc(posb);
                        end;
                  end;
               until (v>6) or (posb>=maxlen) or (a0>=Width);
            end;
      end;
   end;	// loop w..Width-1
   result:=posb;
   //
   q:=Width shr 3;
   if (Width and 7)>0 then
   	inc(q);
   copymemory(predbuf,dstbuf,q);	// copia nuova riga nella precedente
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Rest. bit rposb all'interno del buffer rdata
// 0=false (black) 1=true (white)
function _GetRowBit(rdata:pbyte; rposb:integer):boolean;
begin
   inc(rdata,rposb shr 3);
	result:=(rdata^ and bitmask[rposb and 7])=0;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Scrive "bl" bits di wo, nella posizione wposb di wbuf
// wposb viene incrementato di bl
procedure _PutBits(wbuf:pbyte; var wposb:integer; bl:integer; wo:integer);
begin
   if bl>8 then begin
      bswap( pbytearray(@wo)^[0], pbytearray(@wo)^[1]);
      _CopyBits(wbuf,pbyte(@wo),wposb,(16-bl)mod 8,bl,2147483647);
   end else
		_CopyBits(wbuf,pbyte(@wo),wposb,8-bl,bl,2147483647);
   inc(wposb,bl);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Scrive il codice Huffman "rt" di tipo bw (false=black, true=white) nel
// buffer wbuf alla posizione wposb.
// All'uscita aggiorna wposb perchè punti al prossimo bit da scrivere
// rt può essere qualsiasi valore (anche maggiore dei codici rl di Huffman).
procedure _PutRLCode(wbuf:pbyte; var wposb:integer; rt:integer; bwb:boolean);
var
	bw:integer;
   q:integer;
begin
	bw:=ord(not bwb);	// 1=false (black)  0=true (white)
   // scrive Make-up code
   while rt>63 do begin
		if rt>2560 then begin
      	_PutBits(wbuf,wposb,T4Codes[bw,103].dim,T4Codes[bw,103].code);
         dec(rt,2560);
      end else begin
         q:=63+(rt shr 6);
         _PutBits(wbuf,wposb,T4Codes[bw,q].dim,T4Codes[bw,q].code);
         dec(rt,T4Codes[bw,q].rl);
      end;
   end;
   // scrive term code
	_PutBits(wbuf,wposb,T4Codes[bw,rt].dim,T4Codes[bw,rt].code);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Comprime rdata (di dimensione wb bits) e lo salva in fs
// usato per CCITT 1D (Huffman)
procedure CCITTHuffmanPutLine(rdata:pbyte; wb:integer; fs:TStream; var Aborting:boolean);
var
   bwr:byte;
   bwrl:integer;
begin
	bwrl:=0;
	CCITTHuffmanPutLineG3(rdata,wb,fs,bwr,bwrl,Aborting);
   if bwrl>0 then
	   SafeStreamWrite(fs,Aborting,bwr,1);	// write remain byte
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Comprime rdata (di dimensione wb bits) e lo salva in fs
// bwr: byte rimanente da scrivere
// bwrl:nr. bit rimanenti in bwr da scrivere
// usato per G3FAX1D
procedure CCITTHuffmanPutLineG3(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var Aborting:boolean);
var
   wposb:integer;	// posizione corrente scrittura (in bit)
   rt:integer;
   wbuf:pbyte;	// buffer scrittura
begin
	getmem(wbuf, (wb shr 3)*12+1 );	// 12 volte una riga (+1 di un eventuale bwr)
   wposb:=0;
   if bwrl>0 then begin
   	// ci sono bits da scrivere da prima
      wbuf^:=bwr;
      wposb:=bwrl;
   end;
   _CCITTHuffmanPutLine(rdata,wb,wbuf,wposb);
   // scrive buffer
   rt:=wposb shr 3;
   if (wposb and 7)<>0 then begin
   	bwrl:=wposb-rt*8;	// nr. bits da scrivere alla prossima
      bwr:=pbyte(integer(wbuf)+rt)^;	// bits da scrivere alla prossima
   end else
   	bwrl:=0;
   SafeStreamWrite(fs,Aborting,wbuf^,rt);
	//
   freemem(wbuf);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Comprime rdata (di dimensione wb bits) in wbuf
// "sposta" wpos (input/output)
procedure _CCITTHuffmanPutLine(rdata:pbyte; wb:integer; wbuf:pbyte; var wpos:integer);
var
	rposb:integer;	// posizione corrente lettura (in bit)
   rt:integer;
   bw:boolean;	// true=white  false=black : prossimo colore da processare
begin
	bw:=true;	// iniziamo con white
	rposb:=0;
   while rposb<wb do begin
      rt:=0;
      while (rposb<wb) and (_GetRowBit(rdata,rposb)=bw) do begin
      	inc(rt);
         inc(rposb);
      end;
      _PutRLCode(wbuf,wpos,rt,bw);	// modifica wposb
      bw:= not bw;
   end;
end;

// #define	PIXEL(buf,ix)	((((buf)[(ix)>>3]) >> (7-((ix)&7))) & 1)
function _PIXEL(buf:pbytearray; ix:integer):integer;
begin
	result:=((buf[ix shr 3]) shr (7-(ix and 7))) and 1;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// bp: buffer linea da comprimere (input)
// rp: buffer linea precedente (input)
// wbuf: buffer linea compressa (output)
// wpos: posizione prossimo bit da scrivere
// bits: lunghezza linea bp (in bit)
// nota bwr e bwrl sono solo in input
// rest. posizione prossimo bit da scrivere (alias nr. bit scritti)
procedure Fax3Encode2DRow(bp:pbytearray; rp:pbytearray; wbuf:pbyte; var wpos:integer; bits:integer);
var
	white:integer;
	a0:integer;
	a1:integer;
	b1:integer;
	a2, b2:integer;
   d,r:integer;
begin
	white:=0;
	a0:=0;
   if _PIXEL(bp, 0) <> white then
   	a1:=0
   else
   	a1:=finddiff(pbyte(bp), 0, bits, (not white) and $1);
   if _PIXEL(rp, 0) <> white then
   	b1:=0
   else
   	b1:=finddiff(pbyte(rp), 0, bits, (not white) and $1);
   repeat
   	if b1<bits then
			r:=((rp[b1 shr 3]) shr (7-(b1 and 7))) and 1
      else
      	r:=0;
		b2 := finddiff(pbyte(rp), b1, bits, (not r) and $1);
 		if (b2 >= a1) then begin
			d := b1 - a1;
			if not ((-3 <= d) and (d <= 3)) then begin	// horizontal mode
				a2 := finddiff(pbyte(bp), a1, bits, (not _PIXEL(bp,a1)) and $1 );
            _PutBits(wbuf,wpos,horizcode.dim,horizcode.code);
				if (a0+a1 = 0) or (_PIXEL(bp, a0) = white) then begin
            	_PutRLCode(wbuf,wpos,a1-a0,true);
               _PutRLCode(wbuf,wpos,a2-a1,false);
				end else begin
            	_PutRLCode(wbuf,wpos,a1-a0,false);
               _PutRLCode(wbuf,wpos,a2-a1,true);
				end;
				a0 := a2;
			end else begin			// vertical mode
         	_PutBits(wbuf,wpos,vcodes[d+3].dim,vcodes[d+3].code);
				a0 := a1;
			end;
		end else begin				// pass mode
      	_PutBits(wbuf,wpos,passcode.dim,passcode.code);
			a0 := b2;
		end;
		if (a0 >= bits) then
			break;
		a1 := finddiff(pbyte(bp), a0, bits, (not _PIXEL(bp,a0)) and $1  );
		b1 := finddiff(pbyte(rp), a0, bits, _PIXEL(bp,a0));
		b1 := finddiff(pbyte(rp), b1, bits, (not _PIXEL(bp,a0)) and $1  );
	until false;
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Comprime rdata (di dimensione wb bits) e lo salva in fs
// bwr: byte rimanente da scrivere
// bwrl:nr. bit rimanenti in bwr da scrivere
// predline: puntatore alla linea precedente. Allocato in questa funzione. E' nil per la
//           prima riga. Se rdata=nil si sta finalizzando (liberare predline).
// usato per G3FAX2D
procedure CCITTHuffmanPutLineG32D(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var predline:pbyte; var Aborting:boolean);
var
	wbuf:pbyte;
   wpos,rt,rowlen:integer;
begin
	getmem(wbuf, (wb shr 3)*12+1);	// 12 volte una riga (+1 di un eventuale bwr)
   wpos:=0;
   if bwrl>0 then begin
   	// ci sono bits da scrivere da prima
      wbuf^:=bwr;
      wpos:=bwrl;
      bwrl:=0;
   end;
   rowlen:=(((wb+31) shr 5) shl 2);
	if predline=nil then begin
   	// PRIMA RIGA
		// invia EOL+1 (prima riga 1D)
      _PutBits(wbuf,wpos,12,$1);	// scrive EOF
      _PutBits(wbuf,wpos,1,$1);	// mark codifica 1D
		_CCITTHuffmanPutLine(rdata,wb,wbuf,wpos);	// codifica 1D
      getmem(predline,rowlen);
      copymemory(predline,rdata,rowlen);
   end else if rdata<>nil then begin
   	// ALTRE RIGHE
		// invia EOL+0
      _PutBits(wbuf,wpos,12,$1);	// scrive EOF
      _PutBits(wbuf,wpos,1,$0);	// mark codifica 2D
		Fax3Encode2DRow(pbytearray(rdata),pbytearray(predline),wbuf,wpos,wb);
      copymemory(predline,rdata,rowlen);
   end;
   if rdata=nil then begin
   	// finalization
      _PutBits(wbuf,wpos,12,$1);	// scrive EOF
      freemem(predline);
      predline:=nil;
   end;
   // scrive buffer
   rt:=wpos shr 3;
   if (wpos and 7)<>0 then begin
      bwrl:=wpos-rt*8;	// nr. bits da scrivere alla prossima
      bwr:=pbyte(integer(wbuf)+rt)^;	// bits da scrivere alla prossima
   end;
   SafeStreamWrite(fs,Aborting,wbuf^,rt);
	//
   freemem(wbuf);
end;

///////////////////////////////////////////////////////////////////////////////////////////
// Comprime rdata (di dimensione wb bits) e lo salva in fs
// bwr: byte rimanente da scrivere
// bwrl:nr. bit rimanenti in bwr da scrivere
// predline: puntatore alla linea precedente. Allocato in questa funzione. E' nil per la
//           prima riga. Se rdata=nil si sta finalizzando (liberare predline).
// usato per G4FAX
procedure CCITTHuffmanPutLineG4(rdata:pbyte; wb:integer; fs:TStream; var bwr:byte; var bwrl:integer; var predline:pbyte; var Aborting:boolean);
var
	wbuf:pbyte;
   wpos,rt,rowlen:integer;
begin
	getmem(wbuf, (wb shr 3)*12+1 );	// 12 volte una riga (+1 di un eventuale bwr)
   wpos:=0;
   if bwrl>0 then begin
   	// ci sono bits da scrivere da prima
      wbuf^:=bwr;
      wpos:=bwrl;
      bwrl:=0;
   end;
	rowlen:=(((wb+31) shr 5) shl 2);
	if predline=nil then begin
   	// PREPARA PRIMA RIGA
      getmem(predline,rowlen);
      fillchar(predline^,rowlen,0);	// tutta bianca
   end;
   if rdata<>nil then begin
   	// ALTRE RIGHE
		Fax3Encode2DRow(pbytearray(rdata),pbytearray(predline),wbuf,wpos,wb);
      copymemory(predline,rdata,rowlen);
   end;
   if rdata=nil then begin
   	// per seguire perfettamente lo standard, scrive BEOF e arrotonda a 8 bit
      _PutBits(wbuf,wpos,12,$1);
      _PutBits(wbuf,wpos,12,$1);
      if (wpos and 7)<>0 then
	      _PutBits(wbuf,wpos,8-(wpos and 7),$0);
      freemem(predline);
      predline:=nil;
   end;
   // scrive buffer
   rt:=wpos shr 3;
   if (wpos and 7)<>0 then begin
      bwrl:=wpos-rt*8;	// nr. bits da scrivere alla prossima
      bwr:=pbyte(integer(wbuf)+rt)^;	// bits da scrivere alla prossima
   end;
   SafeStreamWrite(fs,Aborting,wbuf^,rt);
	//
   freemem(wbuf);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// T4 tree builder

procedure AddT4Child(var baseitem:TT4Tree; const code:TT4Entry; codenum:integer);
var
	bb:integer;
   q:integer;
   curitem:PT4Tree;
begin
	curitem:=@baseitem;
	for q:=code.dim-1 downto 0 do begin
   	bb:=ord((code.code and (1 shl q))<>0);	// extract next bit of the code
		if curitem^.childs[bb]=nil then begin
      	new( curitem^.childs[bb] );
         curitem^.code:=NUMCODES;
			curitem^.childs[bb]^.childs[0]:=nil;
         curitem^.childs[bb]^.childs[1]:=nil;
      end;
      curitem:=curitem^.childs[bb];
   end;
   curitem^.code:=codenum;
end;

procedure InitT4Tree;
var
	q,w:integer;
begin
	for w:=0 to 1 do begin
   	T4Tree[w].childs[0]:=nil;
		T4Tree[w].childs[1]:=nil;
		for q:=0 to NUMCODES-1 do
      	AddT4Child(T4Tree[w],T4Codes[w,q],q);
   end;
end;

procedure FreeT4Tree(item:PT4Tree);
begin
	if item<>nil then begin
		FreeT4Tree(item^.childs[0]);
      FreeT4Tree(item^.childs[1]);
      dispose(item);
   end;
end;


// end of T4 tree builder
//////////////////////////////////////////////////////////////////////////////////////////////////////////

initialization
	InitT4Tree;

finalization
	FreeT4Tree(T4Tree[0].childs[0]);
   FreeT4Tree(T4Tree[0].childs[1]);
   FreeT4Tree(T4Tree[1].childs[0]);
   FreeT4Tree(T4Tree[1].childs[1]);



end.
