/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#if !defined(__ANDROID__)
#include <iconv.h>
#endif
#include <errno.h>
#include <stdio.h>
#include <string.h>
#if defined(LINUX) && defined(__BORLANDC__) && !defined(__ANDROID__)
#include <wchar.h>
#endif
#include <locale.h>
#if !defined(__ANDROID__)
#include <langinfo.h>
#endif
#include "ossrv.h"

/* Primary Language Identifiers */
#define LANG_NEUTRAL 0x00
#define LANG_ARABIC 0x01
#define LANG_BULGARIAN 0x02
#define LANG_CATALAN 0x03
#define LANG_CHINESE 0x04
#define LANG_CZECH 0x05
#define LANG_DANISH 0x06
#define LANG_GERMAN 0x07
#define LANG_GREEK 0x08
#define LANG_ENGLISH 0x09
#define LANG_SPANISH 0x0a
#define LANG_FINNISH 0x0b
#define LANG_FRENCH 0x0c
#define LANG_HEBREW 0x0d
#define LANG_HUNGARIAN 0x0e
#define LANG_ICELANDIC 0x0f
#define LANG_ITALIAN 0x10
#define LANG_JAPANESE 0x11
#define LANG_KOREAN 0x12
#define LANG_DUTCH 0x13
#define LANG_NORWEGIAN 0x14
#define LANG_POLISH 0x15
#define LANG_PORTUGUESE 0x16
#define LANG_ROMANIAN 0x18
#define LANG_RUSSIAN 0x19
#define LANG_CROATIAN 0x1a
#define LANG_SERBIAN 0x1a
#define LANG_SLOVAK 0x1b
#define LANG_ALBANIAN 0x1c
#define LANG_SWEDISH 0x1d
#define LANG_THAI 0x1e
#define LANG_TURKISH 0x1f
#define LANG_URDU 0x20
#define LANG_INDONESIAN 0x21
#define LANG_UKRAINIAN 0x22
#define LANG_BELARUSIAN 0x23
#define LANG_SLOVENIAN 0x24
#define LANG_ESTONIAN 0x25
#define LANG_LATVIAN 0x26
#define LANG_LITHUANIAN 0x27
#define LANG_FARSI 0x29
#define LANG_VIETNAMESE 0x2a
#define LANG_ARMENIAN 0x2b
#define LANG_AZERI 0x2c
#define LANG_BASQUE 0x2d
#define LANG_MACEDONIAN 0x2f
#define LANG_AFRIKAANS 0x36
#define LANG_GEORGIAN 0x37
#define LANG_FAEROESE 0x38
#define LANG_HINDI 0x39
#define LANG_MALAY 0x3e
#define LANG_KAZAK 0x3f
#define LANG_SWAHILI 0x41
#define LANG_UZBEK 0x43
#define LANG_TATAR 0x44
#define LANG_BENGALI 0x45
#define LANG_PUNJABI 0x46
#define LANG_GUJARATI 0x47
#define LANG_ORIYA 0x48
#define LANG_TAMIL 0x49
#define LANG_TELUGU 0x4a
#define LANG_KANNADA 0x4b
#define LANG_MALAYALAM 0x4c
#define LANG_ASSAMESE 0x4d
#define LANG_MARATHI 0x4e
#define LANG_SANSKRIT 0x4f
#define LANG_KONKANI 0x57
#define LANG_MANIPURI 0x58
#define LANG_SINDHI 0x59
#define LANG_KASHMIRI 0x60
#define LANG_NEPALI 0x61

/* SubLanguage Identifiers */
#define SUBLANG_NEUTRAL 0x00
#define SUBLANG_DEFAULT 0x01
#define SUBLANG_SYS_DEFAULT 0x02
#define SUBLANG_ARABIC_SAUDI_ARABIA 0x01
#define SUBLANG_ARABIC_IRAQ 0x02
#define SUBLANG_ARABIC_EGYPT 0x03
#define SUBLANG_ARABIC_LIBYA 0x04
#define SUBLANG_ARABIC_ALGERIA 0x05
#define SUBLANG_ARABIC_MOROCCO 0x06
#define SUBLANG_ARABIC_TUNISIA 0x07
#define SUBLANG_ARABIC_OMAN 0x08
#define SUBLANG_ARABIC_YEMEN 0x09
#define SUBLANG_ARABIC_SYRIA 0x10
#define SUBLANG_ARABIC_JORDAN 0x11
#define SUBLANG_ARABIC_LEBANON 0x12
#define SUBLANG_ARABIC_KUWAIT 0x13
#define SUBLANG_ARABIC_UAE 0x14
#define SUBLANG_ARABIC_BAHRAIN 0x15
#define SUBLANG_ARABIC_QATAR 0x16
#define SUBLANG_AZERI_CYRILLIC 0x01
#define SUBLANG_AZERI_LATIN 0x02
#define SUBLANG_CHINESE_TRADITIONAL 0x01
#define SUBLANG_CHINESE_SIMPLIFIED 0x02
#define SUBLANG_CHINESE_HONGKONG 0x03
#define SUBLANG_CHINESE_SINGAPORE 0x04
#define SUBLANG_CHINESE_MACAU 0x05
#define SUBLANG_DUTCH 0x01
#define SUBLANG_DUTCH_BELGIAN 0x02
#define SUBLANG_ENGLISH_US 0x01
#define SUBLANG_ENGLISH_UK 0x02
#define SUBLANG_ENGLISH_AUS 0x03
#define SUBLANG_ENGLISH_CAN 0x04
#define SUBLANG_ENGLISH_NZ 0x05
#define SUBLANG_ENGLISH_EIRE 0x06
#define SUBLANG_ENGLISH_SOUTH_AFRICA 0x07
#define SUBLANG_ENGLISH_JAMAICA 0x08
#define SUBLANG_ENGLISH_CARIBBEAN 0x09
#define SUBLANG_ENGLISH_BELIZE 0x0a
#define SUBLANG_ENGLISH_TRINIDAD 0x0b
#define SUBLANG_ENGLISH_PHILIPPINES 0x0c
#define SUBLANG_ENGLISH_ZIMBABWE 0x0d
#define SUBLANG_FRENCH 0x01
#define SUBLANG_FRENCH_BELGIAN 0x02
#define SUBLANG_FRENCH_CANADIAN 0x03
#define SUBLANG_FRENCH_SWISS 0x04
#define SUBLANG_FRENCH_LUXEMBOURG 0x05
#define SUBLANG_FRENCH_MONACO 0x06
#define SUBLANG_GERMAN 0x01
#define SUBLANG_GERMAN_SWISS 0x02
#define SUBLANG_GERMAN_AUSTRIAN 0x03
#define SUBLANG_GERMAN_LUXEMBOURG 0x04
#define SUBLANG_GERMAN_LIECHTENSTEIN 0x05
#define SUBLANG_ITALIAN 0x01
#define SUBLANG_ITALIAN_SWISS 0x02
#define SUBLANG_KASHMIRI_INDIA 0x02
#define SUBLANG_KOREAN 0x01
#define SUBLANG_LITHUANIAN 0x01
#define SUBLANG_MALAY_MALAYSIA 0x01
#define SUBLANG_MALAY_BRUNEI_DARUSSALAM 0x02
#define SUBLANG_NEPALI_INDIA 0x02
#define SUBLANG_NORWEGIAN_BOKMAL 0x01
#define SUBLANG_NORWEGIAN_NYNORSK 0x02
#define SUBLANG_PORTUGUESE 0x01
#define SUBLANG_PORTUGUESE_BRAZILIAN 0x02
#define SUBLANG_SERBIAN_LATIN 0x02
#define SUBLANG_SERBIAN_CYRILLIC 0x03
#define SUBLANG_SPANISH 0x01
#define SUBLANG_SPANISH_MEXICAN 0x02
#define SUBLANG_SPANISH_MODERN 0x03
#define SUBLANG_SPANISH_GUATEMALA 0x04
#define SUBLANG_SPANISH_COSTA_RICA 0x05
#define SUBLANG_SPANISH_PANAMA 0x06
#define SUBLANG_SPANISH_DOMINICAN_REPUBLIC 0x07
#define SUBLANG_SPANISH_VENEZUELA 0x08
#define SUBLANG_SPANISH_COLOMBIA 0x09
#define SUBLANG_SPANISH_PERU 0x0a
#define SUBLANG_SPANISH_ARGENTINA 0x0b
#define SUBLANG_SPANISH_ECUADOR 0x0c
#define SUBLANG_SPANISH_CHILE 0x0d
#define SUBLANG_SPANISH_URUGUAY 0x0e
#define SUBLANG_SPANISH_PARAGUAY 0x0f
#define SUBLANG_SPANISH_BOLIVIA 0x10
#define SUBLANG_SPANISH_EL_SALVADOR 0x11
#define SUBLANG_SPANISH_HONDURAS 0x12
#define SUBLANG_SPANISH_NICARAGUA 0x13
#define SUBLANG_SPANISH_PUERTO_RICO 0x14
#define SUBLANG_SWEDISH 0x01
#define SUBLANG_SWEDISH_FINLAND 0x02
#define SUBLANG_URDU_PAKISTAN 0x01
#define SUBLANG_URDU_INDIA 0x02
#define SUBLANG_UZBEK_LATIN 0x01
#define SUBLANG_UZBEK_CYRILLIC 0x02

/* Sort Identifier */
#define SORT_DEFAULT 0x01
#define SORT_JAPANESE_XJIS 0x00
#define SORT_JAPANESE_UNICODE 0x01
#define SORT_CHINESE_BIG5 0x00
#define SORT_CHINESE_PRCP 0x00
#define SORT_CHINESE_UNICODE 0x01
#define SORT_CHINESE_PRC 0x02
#define SORT_CHINESE_BOPOMOFO 0x03
#define SORT_KOREAN_KSC 0x00
#define SORT_KOREAN_UNICODE 0x01
#define SORT_GERMAN_PHONE_BOOK 0x01
#define SORT_HUNGARIAN_DEFAULT 0x00
#define SORT_HUNGARIAN_TECHNICAL 0x01
#define SORT_GEORGIAN_TRADITIONAL 0x00
#define SORT_GEORGIAN_MODERN 0x01

#define MAKELANGID(p, s)         ((((unsigned short) (s)) << 10) | (unsigned short) (p))
#define MAKELCID(lgid, srtid)    ((unsigned int)((((unsigned int)((unsigned short)(srtid))) << 16) | ((unsigned int)((unsigned short)(lgid)))))
#define RETURN_LCID(p, s, srtid) MAKELCID(MAKELANGID((p), (s)), (srtid))
#define DEFAULT_LCID             RETURN_LCID((LANG_NEUTRAL), (SUBLANG_DEFAULT), (0))

#define LANG_SYSTEM_DEFAULT    (MAKELANGID(LANG_NEUTRAL, SUBLANG_SYS_DEFAULT))
#define LOCALE_SYSTEM_DEFAULT  (MAKELCID(LANG_SYSTEM_DEFAULT, SORT_DEFAULT))

typedef void*          Pointer;
typedef void*          Var;
typedef const void*    Const;
typedef unsigned short ucs2char_t;
typedef ucs2char_t*    pUCS2Char;
typedef char**         iconvdest_t;
#if ((__GLIBC__ >= 2) && (__GLIBC_MINOR__ >= 2))
  //#define UnicodeId "UCS-4LE"
  typedef char**  iconvsrc_t;
#else
  //#define UnicodeId "UCS-4"
  typedef const char**  iconvsrc_t;
#endif

#define UnicodeId "UNICODELITTLE"

// Locale conversions
unsigned short Hash(const unsigned char *name);
int XLocaleToLCID(char *XLocale);
char *DefaultXLocale();
bool SavePrevXLocale(void);
void RestorePrevXLocale(void);
void RewindXLocale(void);
const char *CurrentXLocale(void);
const char *NextXLocale(void);
bool IsValidLocale(LCID lcid, DWORD dwFlags);
int LcidToXLocale(int Lcid);
pCCHAR GetCodePage();

// String conversions
int MaxSize( int iSize1, int iSize2 );
#if !defined(__ANDROID__)
int ConvertBuffer( iconv_t Context, Const Source, int SrcBytes, Var Dest, int DestBytes );
#endif
int WCharToChar( const pUCS2Char WCharSource, int SrcChars, INT32 CP, pCHAR CharDest, int DestBytes );
int CharToWChar( INT32 CP, pCHAR CharSource, int SrcBytes, const pUCS2Char WCharDest, int DestChars );

pUCS2Char StringToWString( LCID lcid, const char *pszStr, int iSize );

// Wide String Comp
int LibcWideStrComp( int iCmpFlags, pCUCS2Char pVal1, size_t iSize1, pCUCS2Char pVal2, size_t iSize2 );
int WideStrComp_l( LCID lcid, int iCmpFlags, pCUCS2Char pVal1, size_t iSize1, pCUCS2Char pVal2, size_t iSize2 );

// Ansi-like functions
int LibcStrComp( int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
int AnsiStrLComp( pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
int AnsiStrIComp( LCID lcid, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
int AnsiStrLIComp( LCID lcid, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
int AnsiStrComp_l( LCID lcid, int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );

// Windows-like function wrappers
int CompareString( LCID lcid, int iCmpFlags, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
int CompareStringW( LCID lcid, int iCmpFlags, pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2 );
