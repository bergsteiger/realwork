{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFStringEncodingExt.h                  }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFSTRINGENCODINGEXT__)}

{$DEFINE __COREFOUNDATION_CFSTRINGENCODINGEXT__}

{$I CFBase.inc}

const
  kCFStringEncodingMacJapanese             = 1;
  {$EXTERNALSYM kCFStringEncodingMacJapanese}
  kCFStringEncodingMacChineseTrad          = 2;
  {$EXTERNALSYM kCFStringEncodingMacChineseTrad}
  kCFStringEncodingMacKorean               = 3;
  {$EXTERNALSYM kCFStringEncodingMacKorean}
  kCFStringEncodingMacArabic               = 4;
  {$EXTERNALSYM kCFStringEncodingMacArabic}
  kCFStringEncodingMacHebrew               = 5;
  {$EXTERNALSYM kCFStringEncodingMacHebrew}
  kCFStringEncodingMacGreek                = 6;
  {$EXTERNALSYM kCFStringEncodingMacGreek}
  kCFStringEncodingMacCyrillic             = 7;
  {$EXTERNALSYM kCFStringEncodingMacCyrillic}
  kCFStringEncodingMacDevanagari           = 9;
  {$EXTERNALSYM kCFStringEncodingMacDevanagari}
  kCFStringEncodingMacGurmukhi             = 10;
  {$EXTERNALSYM kCFStringEncodingMacGurmukhi}
  kCFStringEncodingMacGujarati             = 11;
  {$EXTERNALSYM kCFStringEncodingMacGujarati}
  kCFStringEncodingMacOriya                = 12;
  {$EXTERNALSYM kCFStringEncodingMacOriya}
  kCFStringEncodingMacBengali              = 13;
  {$EXTERNALSYM kCFStringEncodingMacBengali}
  kCFStringEncodingMacTamil                = 14;
  {$EXTERNALSYM kCFStringEncodingMacTamil}
  kCFStringEncodingMacTelugu               = 15;
  {$EXTERNALSYM kCFStringEncodingMacTelugu}
  kCFStringEncodingMacKannada              = 16;
  {$EXTERNALSYM kCFStringEncodingMacKannada}
  kCFStringEncodingMacMalayalam            = 17;
  {$EXTERNALSYM kCFStringEncodingMacMalayalam}
  kCFStringEncodingMacSinhalese            = 18;
  {$EXTERNALSYM kCFStringEncodingMacSinhalese}
  kCFStringEncodingMacBurmese              = 19;
  {$EXTERNALSYM kCFStringEncodingMacBurmese}
  kCFStringEncodingMacKhmer                = 20;
  {$EXTERNALSYM kCFStringEncodingMacKhmer}
  kCFStringEncodingMacThai                 = 21;
  {$EXTERNALSYM kCFStringEncodingMacThai}
  kCFStringEncodingMacLaotian              = 22;
  {$EXTERNALSYM kCFStringEncodingMacLaotian}
  kCFStringEncodingMacGeorgian             = 23;
  {$EXTERNALSYM kCFStringEncodingMacGeorgian}
  kCFStringEncodingMacArmenian             = 24;
  {$EXTERNALSYM kCFStringEncodingMacArmenian}
  kCFStringEncodingMacChineseSimp          = 25;
  {$EXTERNALSYM kCFStringEncodingMacChineseSimp}
  kCFStringEncodingMacTibetan              = 26;
  {$EXTERNALSYM kCFStringEncodingMacTibetan}
  kCFStringEncodingMacMongolian            = 27;
  {$EXTERNALSYM kCFStringEncodingMacMongolian}
  kCFStringEncodingMacEthiopic             = 28;
  {$EXTERNALSYM kCFStringEncodingMacEthiopic}
  kCFStringEncodingMacCentralEurRoman      = 29;
  {$EXTERNALSYM kCFStringEncodingMacCentralEurRoman}
  kCFStringEncodingMacVietnamese           = 30;
  {$EXTERNALSYM kCFStringEncodingMacVietnamese}
  kCFStringEncodingMacExtArabic            = 31;
  {$EXTERNALSYM kCFStringEncodingMacExtArabic}
{ The following use script code 0, smRoman }
  kCFStringEncodingMacSymbol               = 33;
  {$EXTERNALSYM kCFStringEncodingMacSymbol}
  kCFStringEncodingMacDingbats             = 34;
  {$EXTERNALSYM kCFStringEncodingMacDingbats}
  kCFStringEncodingMacTurkish              = 35;
  {$EXTERNALSYM kCFStringEncodingMacTurkish}
  kCFStringEncodingMacCroatian             = 36;
  {$EXTERNALSYM kCFStringEncodingMacCroatian}
  kCFStringEncodingMacIcelandic            = 37;
  {$EXTERNALSYM kCFStringEncodingMacIcelandic}
  kCFStringEncodingMacRomanian             = 38;
  {$EXTERNALSYM kCFStringEncodingMacRomanian}
  kCFStringEncodingMacCeltic               = 39;
  {$EXTERNALSYM kCFStringEncodingMacCeltic}
  kCFStringEncodingMacGaelic               = 40;
  {$EXTERNALSYM kCFStringEncodingMacGaelic}
{ The following use script code 4, smArabic }
  kCFStringEncodingMacFarsi                = $8C; { Like MacArabic but uses Farsi digits }
  {$EXTERNALSYM kCFStringEncodingMacFarsi}
{ The following use script code 7, smCyrillic }
  kCFStringEncodingMacUkrainian            = $98;
  {$EXTERNALSYM kCFStringEncodingMacUkrainian}
{ The following use script code 32, smUnimplemented }
  kCFStringEncodingMacInuit                = $EC;
  {$EXTERNALSYM kCFStringEncodingMacInuit}
  kCFStringEncodingMacVT100                = $FC; { VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc }
  {$EXTERNALSYM kCFStringEncodingMacVT100}
{ Special Mac OS encodings }
  kCFStringEncodingMacHFS                  = $FF; { Meta-value, should never appear in a table }
  {$EXTERNALSYM kCFStringEncodingMacHFS}

{ Unicode & ISO UCS encodings begin at 0x100 }
{ We don't use Unicode variations defined in TextEncoding; use the ones in CFString.h, instead. }

{ ISO 8-bit and 7-bit encodings begin at 0x200 }
{  kCFStringEncodingISOLatin1 = 0x0201, defined in CoreFoundation/CFString.h }
  kCFStringEncodingISOLatin2               = $0202; { ISO 8859-2 }
  {$EXTERNALSYM kCFStringEncodingISOLatin2}
  kCFStringEncodingISOLatin3               = $0203; { ISO 8859-3 }
  {$EXTERNALSYM kCFStringEncodingISOLatin3}
  kCFStringEncodingISOLatin4               = $0204; { ISO 8859-4 }
  {$EXTERNALSYM kCFStringEncodingISOLatin4}
  kCFStringEncodingISOLatinCyrillic        = $0205; { ISO 8859-5 }
  {$EXTERNALSYM kCFStringEncodingISOLatinCyrillic}
  kCFStringEncodingISOLatinArabic          = $0206; { ISO 8859-6, =ASMO 708, =DOS CP 708 }
  {$EXTERNALSYM kCFStringEncodingISOLatinArabic}
  kCFStringEncodingISOLatinGreek           = $0207; { ISO 8859-7 }
  {$EXTERNALSYM kCFStringEncodingISOLatinGreek}
  kCFStringEncodingISOLatinHebrew          = $0208; { ISO 8859-8 }
  {$EXTERNALSYM kCFStringEncodingISOLatinHebrew}
  kCFStringEncodingISOLatin5               = $0209; { ISO 8859-9 }
  {$EXTERNALSYM kCFStringEncodingISOLatin5}
  kCFStringEncodingISOLatin6               = $020A; { ISO 8859-10 }
  {$EXTERNALSYM kCFStringEncodingISOLatin6}
  kCFStringEncodingISOLatinThai            = $020B; { ISO 8859-11 }
  {$EXTERNALSYM kCFStringEncodingISOLatinThai}
  kCFStringEncodingISOLatin7               = $020D; { ISO 8859-13 }
  {$EXTERNALSYM kCFStringEncodingISOLatin7}
  kCFStringEncodingISOLatin8               = $020E; { ISO 8859-14 }
  {$EXTERNALSYM kCFStringEncodingISOLatin8}
  kCFStringEncodingISOLatin9               = $020F; { ISO 8859-15 }
  {$EXTERNALSYM kCFStringEncodingISOLatin9}
  kCFStringEncodingISOLatin10              = $0210; { ISO 8859-16 }
  {$EXTERNALSYM kCFStringEncodingISOLatin10}

{ MS-DOS & Windows encodings begin at 0x400 }
  kCFStringEncodingDOSLatinUS              = $0400; { code page 437 }
  {$EXTERNALSYM kCFStringEncodingDOSLatinUS}
  kCFStringEncodingDOSGreek                = $0405; { code page 737 (formerly code page 437G) }
  {$EXTERNALSYM kCFStringEncodingDOSGreek}
  kCFStringEncodingDOSBalticRim            = $0406; { code page 775 }
  {$EXTERNALSYM kCFStringEncodingDOSBalticRim}
  kCFStringEncodingDOSLatin1               = $0410; { code page 850, "Multilingual" }
  {$EXTERNALSYM kCFStringEncodingDOSLatin1}
  kCFStringEncodingDOSGreek1               = $0411; { code page 851 }
  {$EXTERNALSYM kCFStringEncodingDOSGreek1}
  kCFStringEncodingDOSLatin2               = $0412; { code page 852, Slavic }
  {$EXTERNALSYM kCFStringEncodingDOSLatin2}
  kCFStringEncodingDOSCyrillic             = $0413; { code page 855, IBM Cyrillic }
  {$EXTERNALSYM kCFStringEncodingDOSCyrillic}
  kCFStringEncodingDOSTurkish              = $0414; { code page 857, IBM Turkish }
  {$EXTERNALSYM kCFStringEncodingDOSTurkish}
  kCFStringEncodingDOSPortuguese           = $0415; { code page 860 }
  {$EXTERNALSYM kCFStringEncodingDOSPortuguese}
  kCFStringEncodingDOSIcelandic            = $0416; { code page 861 }
  {$EXTERNALSYM kCFStringEncodingDOSIcelandic}
  kCFStringEncodingDOSHebrew               = $0417; { code page 862 }
  {$EXTERNALSYM kCFStringEncodingDOSHebrew}
  kCFStringEncodingDOSCanadianFrench       = $0418; { code page 863 }
  {$EXTERNALSYM kCFStringEncodingDOSCanadianFrench}
  kCFStringEncodingDOSArabic               = $0419; { code page 864 }
  {$EXTERNALSYM kCFStringEncodingDOSArabic}
  kCFStringEncodingDOSNordic               = $041A; { code page 865 }
  {$EXTERNALSYM kCFStringEncodingDOSNordic}
  kCFStringEncodingDOSRussian              = $041B; { code page 866 }
  {$EXTERNALSYM kCFStringEncodingDOSRussian}
  kCFStringEncodingDOSGreek2               = $041C; { code page 869, IBM Modern Greek }
  {$EXTERNALSYM kCFStringEncodingDOSGreek2}
  kCFStringEncodingDOSThai                 = $041D; { code page 874, also for Windows }
  {$EXTERNALSYM kCFStringEncodingDOSThai}
  kCFStringEncodingDOSJapanese             = $0420; { code page 932, also for Windows }
  {$EXTERNALSYM kCFStringEncodingDOSJapanese}
  kCFStringEncodingDOSChineseSimplif       = $0421; { code page 936, also for Windows }
  {$EXTERNALSYM kCFStringEncodingDOSChineseSimplif}
  kCFStringEncodingDOSKorean               = $0422; { code page 949, also for Windows; Unified Hangul Code }
  {$EXTERNALSYM kCFStringEncodingDOSKorean}
  kCFStringEncodingDOSChineseTrad          = $0423; { code page 950, also for Windows }
  {$EXTERNALSYM kCFStringEncodingDOSChineseTrad}
{  kCFStringEncodingWindowsLatin1 = 0x0500, defined in CoreFoundation/CFString.h }
  kCFStringEncodingWindowsLatin2           = $0501; { code page 1250, Central Europe }
  {$EXTERNALSYM kCFStringEncodingWindowsLatin2}
  kCFStringEncodingWindowsCyrillic         = $0502; { code page 1251, Slavic Cyrillic }
  {$EXTERNALSYM kCFStringEncodingWindowsCyrillic}
  kCFStringEncodingWindowsGreek            = $0503; { code page 1253 }
  {$EXTERNALSYM kCFStringEncodingWindowsGreek}
  kCFStringEncodingWindowsLatin5           = $0504; { code page 1254, Turkish }
  {$EXTERNALSYM kCFStringEncodingWindowsLatin5}
  kCFStringEncodingWindowsHebrew           = $0505; { code page 1255 }
  {$EXTERNALSYM kCFStringEncodingWindowsHebrew}
  kCFStringEncodingWindowsArabic           = $0506; { code page 1256 }
  {$EXTERNALSYM kCFStringEncodingWindowsArabic}
  kCFStringEncodingWindowsBalticRim        = $0507; { code page 1257 }
  {$EXTERNALSYM kCFStringEncodingWindowsBalticRim}
  kCFStringEncodingWindowsVietnamese       = $0508; { code page 1258 }
  {$EXTERNALSYM kCFStringEncodingWindowsVietnamese}
  kCFStringEncodingWindowsKoreanJohab      = $0510; { code page 1361, for Windows NT }
  {$EXTERNALSYM kCFStringEncodingWindowsKoreanJohab}

{ Various national standards begin at 0x600 }
{  kCFStringEncodingASCII = 0x0600, defined in CoreFoundation/CFString.h }
  kCFStringEncodingANSEL                   = $0601; { ANSEL (ANSI Z39.47) }
  {$EXTERNALSYM kCFStringEncodingANSEL}
  kCFStringEncodingJIS_X0201_76            = $0620;
  {$EXTERNALSYM kCFStringEncodingJIS_X0201_76}
  kCFStringEncodingJIS_X0208_83            = $0621;
  {$EXTERNALSYM kCFStringEncodingJIS_X0208_83}
  kCFStringEncodingJIS_X0208_90            = $0622;
  {$EXTERNALSYM kCFStringEncodingJIS_X0208_90}
  kCFStringEncodingJIS_X0212_90            = $0623;
  {$EXTERNALSYM kCFStringEncodingJIS_X0212_90}
  kCFStringEncodingJIS_C6226_78            = $0624;
  {$EXTERNALSYM kCFStringEncodingJIS_C6226_78}
  kCFStringEncodingShiftJIS_X0213          = $0628; { Shift-JIS format encoding of JIS X0213 planes 1 and 2 }
  {$EXTERNALSYM kCFStringEncodingShiftJIS_X0213}
  kCFStringEncodingShiftJIS_X0213_MenKuTen = $0629;    { JIS X0213 in plane-row-column notation }
  {$EXTERNALSYM kCFStringEncodingShiftJIS_X0213_MenKuTen}
  kCFStringEncodingGB_2312_80              = $0630;
  {$EXTERNALSYM kCFStringEncodingGB_2312_80}
  kCFStringEncodingGBK_95                  = $0631; { annex to GB 13000-93; for Windows 95 }
  {$EXTERNALSYM kCFStringEncodingGBK_95}
  kCFStringEncodingGB_18030_2000           = $0632;
  {$EXTERNALSYM kCFStringEncodingGB_18030_2000}
  kCFStringEncodingKSC_5601_87             = $0640; { same as KSC 5601-92 without Johab annex }
  {$EXTERNALSYM kCFStringEncodingKSC_5601_87}
  kCFStringEncodingKSC_5601_92_Johab       = $0641; { KSC 5601-92 Johab annex }
  {$EXTERNALSYM kCFStringEncodingKSC_5601_92_Johab}
  kCFStringEncodingCNS_11643_92_P1         = $0651; { CNS 11643-1992 plane 1 }
  {$EXTERNALSYM kCFStringEncodingCNS_11643_92_P1}
  kCFStringEncodingCNS_11643_92_P2         = $0652; { CNS 11643-1992 plane 2 }
  {$EXTERNALSYM kCFStringEncodingCNS_11643_92_P2}
  kCFStringEncodingCNS_11643_92_P3         = $0653; { CNS 11643-1992 plane 3 (was plane 14 in 1986 version) }
  {$EXTERNALSYM kCFStringEncodingCNS_11643_92_P3}

{ ISO 2022 collections begin at 0x800 }
  kCFStringEncodingISO_2022_JP             = $0820;
  {$EXTERNALSYM kCFStringEncodingISO_2022_JP}
  kCFStringEncodingISO_2022_JP_2           = $0821;
  {$EXTERNALSYM kCFStringEncodingISO_2022_JP_2}
  kCFStringEncodingISO_2022_JP_1           = $0822; { RFC 2237 }
  {$EXTERNALSYM kCFStringEncodingISO_2022_JP_1}
  kCFStringEncodingISO_2022_JP_3           = $0823; { JIS X0213 }
  {$EXTERNALSYM kCFStringEncodingISO_2022_JP_3}
  kCFStringEncodingISO_2022_CN             = $0830;
  {$EXTERNALSYM kCFStringEncodingISO_2022_CN}
  kCFStringEncodingISO_2022_CN_EXT         = $0831;
  {$EXTERNALSYM kCFStringEncodingISO_2022_CN_EXT}
  kCFStringEncodingISO_2022_KR             = $0840;
  {$EXTERNALSYM kCFStringEncodingISO_2022_KR}

{ EUC collections begin at 0x900 }
  kCFStringEncodingEUC_JP                  = $0920; { ISO 646, 1-byte katakana, JIS 208, JIS 212 }
  {$EXTERNALSYM kCFStringEncodingEUC_JP}
  kCFStringEncodingEUC_CN                  = $0930; { ISO 646, GB 2312-80 }
  {$EXTERNALSYM kCFStringEncodingEUC_CN}
  kCFStringEncodingEUC_TW                  = $0931; { ISO 646, CNS 11643-1992 Planes 1-16 }
  {$EXTERNALSYM kCFStringEncodingEUC_TW}
  kCFStringEncodingEUC_KR                  = $0940; { ISO 646, KS C 5601-1987 }
  {$EXTERNALSYM kCFStringEncodingEUC_KR}

{ Misc standards begin at 0xA00 }
  kCFStringEncodingShiftJIS                = $0A01; { plain Shift-JIS }
  {$EXTERNALSYM kCFStringEncodingShiftJIS}
  kCFStringEncodingKOI8_R                  = $0A02; { Russian internet standard }
  {$EXTERNALSYM kCFStringEncodingKOI8_R}
  kCFStringEncodingBig5                    = $0A03; { Big-5 (has variants) }
  {$EXTERNALSYM kCFStringEncodingBig5}
  kCFStringEncodingMacRomanLatin1          = $0A04; { Mac OS Roman permuted to align with ISO Latin-1 }
  {$EXTERNALSYM kCFStringEncodingMacRomanLatin1}
  kCFStringEncodingHZ_GB_2312              = $0A05; { HZ (RFC 1842, for Chinese mail & news) }
  {$EXTERNALSYM kCFStringEncodingHZ_GB_2312}
  kCFStringEncodingBig5_HKSCS_1999         = $0A06; { Big-5 with Hong Kong special char set supplement }
  {$EXTERNALSYM kCFStringEncodingBig5_HKSCS_1999}
  kCFStringEncodingVISCII                  = $0A07; { RFC 1456, Vietnamese }
  {$EXTERNALSYM kCFStringEncodingVISCII}
  kCFStringEncodingKOI8_U                  = $0A08; { RFC 2319, Ukrainian }
  {$EXTERNALSYM kCFStringEncodingKOI8_U}
  kCFStringEncodingBig5_E                  = $0A09; { Taiwan Big-5E standard }
  {$EXTERNALSYM kCFStringEncodingBig5_E}

{ Other platform encodings }
{  kCFStringEncodingNextStepLatin = 0x0B01, defined in CoreFoundation/CFString.h }
  kCFStringEncodingNextStepJapanese        = $0B02; { NextStep Japanese encoding }
  {$EXTERNALSYM kCFStringEncodingNextStepJapanese}

{ EBCDIC & IBM host encodings begin at 0xC00 }
  kCFStringEncodingEBCDIC_US               = $0C01; { basic EBCDIC-US }
  {$EXTERNALSYM kCFStringEncodingEBCDIC_US}
  kCFStringEncodingEBCDIC_CP037            = $0C02; { code page 037, extended EBCDIC (Latin-1 set) for US,Canada... }
  {$EXTERNALSYM kCFStringEncodingEBCDIC_CP037}

  kCFStringEncodingUTF7                    = $04000100; { kTextEncodingUnicodeDefault + kUnicodeUTF7Format RFC2152 }
  {$EXTERNALSYM kCFStringEncodingUTF7}
  kCFStringEncodingUTF7_IMAP               = $0A10; { UTF-7 (IMAP folder variant) RFC3501 }
  {$EXTERNALSYM kCFStringEncodingUTF7_IMAP}

{ Deprecated constants }
  kCFStringEncodingShiftJIS_X0213_00       = $0628; { Shift-JIS format encoding of JIS X0213 planes 1 and 2 (DEPRECATED) }
  {$EXTERNALSYM kCFStringEncodingShiftJIS_X0213_00}
type
  CFStringEncodings = CFIndex;
  {$EXTERNALSYM CFStringEncodings}

{$ENDIF !__COREFOUNDATION_CFSTRINGENCODINGEXT__}


