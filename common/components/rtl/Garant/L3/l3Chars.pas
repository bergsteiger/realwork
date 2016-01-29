unit l3Chars;
{* ��������� ��� ������ � ��������� � �����������. }

{$IfDef DesignTimeLibrary}
{$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3Chars -                   }
{ �����: 01.12.1995 16:28             }
{ $Id: l3Chars.pas,v 1.99 2015/10/21 06:16:10 dinishev Exp $ }

// $Log: l3Chars.pas,v $
// Revision 1.99  2015/10/21 06:16:10  dinishev
// Cleanup
//
// Revision 1.98  2015/09/10 13:25:33  dinishev
// {Requestlink:606808862}
//
// Revision 1.97  2015/05/13 05:51:52  dinishev
// ������� ������� �� ���������.
//
// Revision 1.96  2014/12/17 15:53:12  lulin
// {RequestLink:585129079}.
//
// Revision 1.95  2013/12/16 16:46:56  lulin
// {RequestLink:509088042}
//
// Revision 1.94  2013/10/29 11:21:24  dinishev
// {Requestlink:496995054}
//
// Revision 1.93  2013/06/28 10:37:11  lulin
// - ������ ��������� ������ ��� XE.
//
// Revision 1.92  2013/04/04 11:22:01  lulin
// - ���������.
//
// Revision 1.91  2013/03/28 14:03:17  lulin
// - ���������.
//
// Revision 1.90  2012/11/07 09:49:05  narry
// ������ � �������� ������� "&" (407754492)
//
// Revision 1.89  2012/11/07 09:43:48  voba
// - add const cc_WhiteSpaceExt
//
// Revision 1.88  2012/03/02 09:16:25  voba
// -k:310676394
//
// Revision 1.87  2012/02/15 10:51:32  narry
// ��������� ������������ HTML (336662745)
//
// Revision 1.86  2010/09/16 11:36:42  lulin
// {RequestLink:235048829}.
//
// Revision 1.85  2010/06/23 08:17:22  voba
// - add const cc_Quotes
//
// Revision 1.84  2009/12/14 16:53:39  lulin
// {RequestLink:168230991}.
//
// Revision 1.83  2009/11/16 15:52:05  voba
// - add CharSets cc_LQuotes, cc_RQuotes
//
// Revision 1.82  2009/04/28 06:49:30  voba
// - �������� ������ WordDelim
//
// Revision 1.81  2009/03/06 12:18:37  voba
// - ������� � cc_WordDelimANSISet ���� ������������� �������
//
// Revision 1.80  2008/12/18 14:42:50  lulin
// - <K>: 132222370.
//
// Revision 1.79  2008/12/18 12:39:02  lulin
// - <K>: 132222370. ������������ ������ � ���������� TatarOEM.
//
// Revision 1.78  2008/10/21 12:06:08  oman
// - fix: ������������ ��������� ������� (�-121157521)
//
// Revision 1.77  2008/08/01 14:43:47  dinishev
// <K> : 77235623
//
// Revision 1.76  2008/01/22 14:17:20  lulin
// - ��������� ��������� ��� ��������� ���������.
//
// Revision 1.75  2007/08/07 11:18:27  oman
// - new: ��� ������ ��� ����� ������� ��� �������������� ������ (cq25836)
//
// Revision 1.74  2007/08/02 10:37:10  lulin
// - ��������� ��������� ��� ����������� �������� �����.
//
// Revision 1.73  2007/07/11 12:54:47  oman
// - new: ������� ��������� ������������� ������ ������� (cq25909)
//
// Revision 1.72  2007/04/04 11:29:42  lulin
// - ��������� ��������� ��������� ������.
//
// Revision 1.71  2007/03/20 09:10:17  oman
// - new: ������� ��������� ��� BackSpace
//
// Revision 1.70  2007/02/09 13:08:24  lulin
// - bug fix: ����� ��� ����� �.
// - ������� ����� "�������+�����".
//
// Revision 1.69  2007/02/02 13:35:31  lulin
// - bug fix: ����������� ���������� - ������ �������� ��� ���.
//
// Revision 1.68  2007/01/12 13:48:16  lulin
// - cleanup.
//
// Revision 1.67  2006/11/27 08:43:26  lulin
// - cleanup.
//
// Revision 1.66  2006/09/21 12:25:41  dinishev
// new interface: Il3StringFormatter
//
// Revision 1.65  2006/05/04 11:01:26  lulin
// - ��������� ��� ����� ������.
// - �������� "������" ������ ������ � ������� � ��������.
//
// Revision 1.64  2006/03/24 09:28:07  lulin
// - �������� ���������.
//
// Revision 1.63  2005/11/07 12:23:33  fireton
// - bug fix: ������ �������� - ���� �����������
//
// Revision 1.62  2005/09/07 14:16:20  fireton
// - ��������� ������������ ���� ���������� � l3Chars
//
// Revision 1.61  2005/05/19 13:49:49  lulin
// - ����� TevFont ������� � ��������� ������.
//
// Revision 1.60  2005/04/06 12:25:38  lulin
// - bug fix: ��������� �� ����������� ��� �������������.
//
// Revision 1.59  2005/04/04 14:02:45  mmorozov
// new: const CS_Ansi;
//
// Revision 1.58  2005/04/01 14:14:08  mmorozov
// new: ����� ������ �������� { Language locale identifiers };
//
// Revision 1.57  2005/01/28 14:49:12  lulin
// - new behavior: ��� ������ ������� �������� ���������� ������� " New".
//
// Revision 1.56  2005/01/28 13:41:32  lulin
// - new consts: cc_OEMRussian., cc_OEMEnglish, cc_OEMLetter.
//
// Revision 1.55  2004/12/08 13:51:31  lulin
// - ����� ��������������� ���� ������������� ������.
//
// Revision 1.53  2004/08/06 08:56:20  voba
// - add cc_NonReadable {* - "����������" �������.}
//
// Revision 1.52  2004/06/08 09:27:41  voba
// - add cc_UnAssignedStr
//
// Revision 1.51  2004/05/20 12:06:27  law
// - bug fix: ����������� ������������ ����� ����� � cp_UnicodeText � cp_Text.
//
// Revision 1.50  2004/05/12 11:44:12  law
// - new behavior: ��������� ����������� ��������� Unicode-����� � ���������.
//
// Revision 1.49  2004/04/29 14:38:54  fireton
// - add: ��������� ��������� cc_EnDash � cc_EmDash
//
// Revision 1.48  2004/04/29 12:59:34  law
// - bug fix: ����� ������� ����������� ������ �� cc_CodePagesDiff.
//
// Revision 1.47  2004/04/26 12:42:42  law
// - bug fix: ������� ����� ��������, ��������� ��� ������ ������� �������.
//
// Revision 1.46  2004/04/20 13:36:14  law
// - bug fix: �������� Unicode ��� ������� ������� � ���������� ����.
//
// Revision 1.45  2004/04/19 16:08:23  law
// - new type: _Tl3PCharLenConst.
//
// Revision 1.44  2004/04/14 14:49:59  law
// - new const: CP_CentralEuropeWin.
//
// Revision 1.43  2003/12/01 16:20:39  law
// - change: ��������� �� ������� ������� �������� � ������� ����������/��������� ��������.
//
// Revision 1.42  2003/09/15 09:20:16  law
// - new const: l3Chars.cc_EmptyStr.
//
// Revision 1.41  2003/05/16 14:42:23  law
// - new behavior: ������� ��������� �������� ��������� � ����������� �� ����� ������������.
//
// Revision 1.40  2003/05/12 12:57:06  law
// - new behavior: � ������� ������ ����������� ������� ��������� ��������� � ���� �������.
//
// Revision 1.39  2003/05/12 12:51:27  law
// - new behavior: � ������ ����������� ������������ ������� ��������� ��������� � ���� ���������.
//
// Revision 1.38  2003/05/12 09:20:24  law
// - rename proc: ev_plIsNil -> l3IsNil.
//
// Revision 1.37  2002/10/30 13:33:37  law
// - new const: cc_DotVar.
//
// Revision 1.36  2002/06/10 12:36:05  law
// - new const: cc_OEMHardSpaceSymbol.
//
// Revision 1.35  2002/06/03 12:31:34  law
// - new const: cc_AllChars.
//
// Revision 1.34  2002/05/16 08:25:15  law
// - new const: cc_CtrlBackspace.
//
// Revision 1.33  2002/04/15 12:18:44  law
// - new const: cc_ANSILetter.
//
// Revision 1.32  2002/03/22 14:52:25  law
// - new const.
//
// Revision 1.31  2002/03/21 12:10:35  law
// - new const.
//
// Revision 1.30  2002/02/28 14:20:46  law
// - change type: cc_NullVar: _Char -> WideChar.
//
// Revision 1.29  2001/12/27 16:16:52  law
// - new const: l3Types.CP_Unicode.
//
// Revision 1.28  2001/12/27 16:06:34  law
// - change: ������� ������� ����� Tl3PCharLen.
//
// Revision 1.27  2001/10/17 14:22:29  narry
// - bug fix: ������������ ��������� ��������� ������ - cp_OEMLite � cp_KOI8
//
// Revision 1.26  2001/10/17 12:06:06  law
// - new behavior: ��������� ��������� CP_KOI8.
//
// Revision 1.25  2001/09/11 17:46:36  law
// - some new features.
//
// Revision 1.24  2001/07/27 15:46:04  law
// - comments: xHelpGen.
//
// Revision 1.23  2001/06/21 07:08:26  law
// - new behavior: ����������� ����� ���������� ��������� � ������ ������� � ���� ������� �����.
//
// Revision 1.22  2001/04/10 16:30:18  law
// - comments: ��������� ����������� ��� xHelpGen.
//
// Revision 1.21  2001/03/21 16:49:52  voba
// no message
//
// Revision 1.20  2001/02/26 09:06:50  law
// - ������� ��������� �������� ���� �� ������.
//
// Revision 1.19  2000/12/15 15:18:59  law
// - ��������� ��������� Log.
//

{$Include l3Define.inc}

{$WriteableConst Off}

interface

uses
  l3Interfaces
  ;

const
  l3_csANSI       = 0;
    {-������� ��������� ANSII}
  l3_csOEM        = 255;
    {-������� ��������� OEM}

  cc_Null      = #0;
  cc_Austerisk = '*';
  cc_Slash     = '\';
  cc_BackSlash = '/';
  cc_NullVar : WideChar = cc_Null;

const
  cc_AllChars = [#0..#255];
   {* - ��� �������. } 
  cc_Digits    = ['0'..'9'];
   {* - ���������� �����. }
  cc_RomeDigits = ['I','V','X','L','C','D','M'];
   {* - ������� �����. }
  cc_HexDigits = cc_Digits + ['A'..'F', 'a'..'f'];
   {* - ����������������� �����. }
  cc_Frames    = [#176..#223];
   {* - ������� ������������� ��� �����. }

  cc_UpRussian = ['�'..'�', '�'];
   {-}
  cc_LoRussian = ['�'..'�', '�'];
   {-}
  cc_ANSIRussian = cc_UpRussian + cc_LoRussian;
   {* - ������� �����. }
  cc_OEMRussian = [#$80..#$AF, #$E0..#$F1];
   {* - ������� �����. }
  cc_UpEnglish = ['A'..'Z'];
   {-}
  cc_LoEnglish = ['a'..'z'];
   {-}  
  cc_ANSIEnglish = cc_UpEnglish + cc_LoEnglish;
   {* - ���������� �����. }
  cc_OEMEnglish = cc_ANSIEnglish; 
   {* - ���������� �����. }
  cc_ANSILetter = cc_ANSIRussian + cc_ANSIEnglish;
   {* - ������� � ���������� �����. } 
  cc_OEMLetter = cc_OEMRussian + cc_OEMEnglish;
   {* - ������� � ���������� �����. } 
  cc_RusVowels = ['�','�','�','�','�','�','�','�','�','�',
                  '�','�','�','�','�','�','�','�','�','�'];
   {* - ������� ������� �����. }
  cc_RusConsonants = cc_ANSIRussian - cc_RusVowels;
   {* - ������� ���������. }
  cc_EngVowels = ['A', 'E', 'I', 'O', 'U', 'Y',
                  'a', 'e', 'i', 'o', 'u', 'y'];
   {* - ���������� �������. }                
  cc_EngConsonants = cc_ANSIEnglish - cc_EngVowels;
   {* - ���������� ���������. }
  cc_Znaks =
    ['�','�','�','�','�','�','�','�'];
   {* - "�����". }
  cc_HighASCII = [#128..#255];
   {* - ������� �������� ������� ASCII.}

  cc_NonReadable = [#0..#8,#10..#20,#22..#31,'�'];
   {* - "����������" �������.}

  cc_OEM_Criteria  = [#128..#175];
   {* - �������� ��� ����������� ��������� CP_OEM. }
  cc_ANSI_Criteria = [#192..#223] + [#240..#255];
   {* - �������� ��� ����������� ��������� CP_ANSI. }

  cc_AlphaNum = cc_ANSILetter + cc_Digits;
   {-}  

type
  cc_Graph_CriteriaRange  = #176 .. #223;
   {* - �������� ��� ����������� �������������. }
  TChars = TCharSet;
   {* ��������� ��������. }

const
  cc_TriUp = #30;
  cc_TriDown = #31;
  cc_TriLeft = #17;
  cc_TriRight = #16;

  cc_OEM_CriteriaEx  = [#128..#175] + [#224..#239];
  cc_ANSI_CriteriaEx = [#192..#255];
  cc_Graph_CriteriaPrim  = [Low(cc_Graph_CriteriaRange)..High(cc_Graph_CriteriaRange)];
  cc_Graph_Criteria = cc_Graph_CriteriaPrim + [cc_TriUp, cc_TriDown, cc_TriLeft, cc_TriRight];

type
  T_cc_GraphCounts = array [cc_Graph_CriteriaRange] of Longint;
  Tl3CharPair = array [Boolean] of AnsiChar;
  Tl3StrPair = array [Boolean] of Tl3PCharLenPrim;

const
  cc_HyperLinkChar = #4;
  {* - ������ ����������� �����������. }
  cc_BackSpace    = #8;
   {* - ����� aka backspace }
  cc_Tab          = #9;
   {* - ���������. }
  cc_SoftEnter    = #10;
   {* - ����� ������. }
  cc_EOP          = #12;
   {* - ����� ��������. }
  cc_HardEnter    = #13;
   {* - ����� ������. }
  cc_LF           = cc_HardEnter;
  cc_CR           = cc_SoftEnter;
  cc_HardSpace    = #32;
   {* - ������� ������. }
  cc_HardSpaceVar : AnsiChar = cc_HardSpace;
  cc_Ampersand    = #38; // html &amp;
  cc_DoubleQuote  = #34;
   {* - ������� �������. }
  cc_SingleQuote  = #39;
   {* - ��������� �������. }
  cc_Underline    = '_';
   {* - ������ �������������. }
  cc_Hyphen       = '-';
   {* - ������ ��������. }
  cc_Minus        = '-';
   {* - ������ ������. }
  cc_Plus         = '+';
   {* - ������ �����. }
  cc_Equal        = '=';
   {* - ������ �����. }
  cc_Dot          = '.';
   {* - �����. }
  cc_DotVar : AnsiChar = cc_Dot;
   {-}
  cc_Comma        = ',';
   {* - �������. }
  cc_PercentSign  = '%';
   {* - ���� ��������. }
  cc_Tilda        = '~';
   {* - ������. }
  cc_Number       = '#';
   {* - �����. }
  cc_Colon        = ':';
   {* - ���������. }
  cc_SemiColon    = ';';
   {* - ����� � �������. }
  cc_DollarSign   = '$';
   {* - ���� �������. }
  cc_RightBracket = #41;
  cc_OpenBrace = '{';
  cc_CloseBrace = '}';
  cc_More = '>';
  cc_Less = '<';
  cc_Multyply = '*';

  cc_CtrlBackspace = #127;
   {-}
  cc_DoubleLowQuote = #132;
   {* - ������� ������ �������. }
  cc_Ellipsis      = #133;
   {* - ���������. }
  cc_LTSingleQuote = #139;
   {* - ������������� ��������� ����������� �������. }
  cc_LSingleQuote  = #145;
   {* - ������������� ��������� �������. }
  cc_RSingleQuote  = #146;
   {* - ������������� ��������� �������. }
  cc_LDoubleQuote  = #147;
   {* - ������������� ������� �������. }
  cc_RDoubleQuote  = #148;
   {* - ������������� ������� �������. }
  cc_LargeDash     = #150;
   {* - ������� ����. }
  cc_RTSingleQuote = #155;
   {* - ������������� ��������� ����������� �������. }
  cc_SoftSpace     = #160;
   {* - ����������� ������. }
  cc_IExclMark     = #161; // html &iexcl; - inverted exclamation mark
  cc_CentSign      = #162; // html &cent; - cent
  cc_PoundSing     = #163; // html &pound; - pound

  cc_CurrencySign = #164;
   {* - ���� �����. }
  cc_YenSign      = #165; // html &yen
  cc_BrokenBar    = #166;
   {* - ������������ ����� � �������. }
  cc_ParagraphSign = #167;
   {* - ���� ���������. }
  cc_Section       = #167; // html &sect; - section
  cc_Uml           = #168; // html &uml; - spacing diaeresis
  cc_Copyright     = #169; // html &copy;
  cc_OrdF          = #170; // html &ordf; - feminine ordinal indicator
  cc_LTDoubleQuote = #171;
   {* - ������������� ������� ����������� �������. }
  cc_NotSign       = #172; // html &not;
  cc_SoftHyphen    = #173; // html &shy;
  cc_Registered    = #174; // html &reg
  cc_Macron        = #175; // html &macr - spacing macron
  cc_Degree        = #176; // html &deg;
  cc_PlusMinus     = #177; // html &plusmn;
  cc_Sup2          = #178; // html &sup2; -  superscript 2
  cc_Sup3          = #179; // html &sup3; -  superscript 3
  cc_Acute         = #180; // html &acute; -  spacing acute
  cc_Micro         = #181; // html &micro;
  cc_Para          = #182; // html &para;
  cc_Middot        = #183; // html &middot;
  cc_Cedil         = #184; // html &cedil;  spacing cedilla
  cc_Sup1          = #185; // html &sup1;  superscript 1
  cc_Ordm          = #186; // html &ordm;  masculine ordinal indicator
  cc_RTDoubleQuote = #187;
   {* - ������������� ������� ����������� �������. }
  cc_Frac14        = #188; // html &frac14;  fraction 1/4
  cc_Frac12        = #189; // html &frac12;  fraction 1/2
  cc_Frac34        = #190; // html &frac34;  fraction 3/4
  cc_IQuest        = #191; // html &iquest;  inverted question mark
  cc_Divide        = #247; // html &divide;  division

  cc_OEMSoftSpace = #255;
   {* - ����������� ������ OEM. }
  cc_EnDash       = #$96;
   {* - �������� ���� }
  cc_EmDash       = #$97;
   {* - ������� ���� }

  cc_SingleQuotes : Tl3CharPair = (cc_RSingleQuote, cc_LSingleQuote);
  cc_DoubleQuotes : Tl3CharPair = (cc_RDoubleQuote, cc_LDoubleQuote);
  cc_TSingleQuotes : Tl3CharPair = (cc_RTSingleQuote, cc_LTSingleQuote);

  cc_TDoubleQuotes : Tl3CharPair = (cc_RTDoubleQuote, cc_LTDoubleQuote);

  cc_PairDoubleQuotes = [cc_LDoubleQuote, cc_RDoubleQuote];
  cc_PairSingleQuotes = [cc_RSingleQuote, cc_LSingleQuote];

  cc_LQuotes = [cc_SingleQuote, cc_DoubleQuote, cc_DoubleLowQuote, cc_LSingleQuote, cc_LDoubleQuote, cc_LTSingleQuote, cc_LTDoubleQuote];
  cc_RQuotes = [cc_SingleQuote, cc_DoubleQuote, cc_RSingleQuote, cc_RDoubleQuote, cc_RTSingleQuote, cc_RTDoubleQuote];
  cc_Quotes = cc_LQuotes + cc_RQuotes;

  cc_OpenQuotePrev : array [Boolean] of TChars =
                     ([cc_SoftEnter, cc_HardSpace, cc_SoftSpace, cc_Tab],
                      [cc_SoftEnter, cc_HardSpace, cc_OEMSoftSpace, cc_Tab]);

  cc_WhiteSpace = [cc_HardSpace, cc_Tab];
  cc_WhiteSpaceExt = cc_WhiteSpace + [cc_SoftSpace];

  cc_OEMParagraphSign = #21;
   {* - ���� ��������� ��� ��������� CP_OEM. }




  cc_CodePagesDiff = cc_HighASCII -
                     [cc_LSingleQuote, cc_RSingleQuote,
                      cc_LDoubleQuote, cc_RDoubleQuote,
                      cc_LTDoubleQuote, cc_RTDoubleQuote,
                      cc_ParagraphSign, cc_SoftSpace];
   {* - �������, ������, ��� ��������� ���������. }


const
  cc_EOL      = AnsiString(#13) + AnsiString(#10);
   {* - ����� ������ � ��������� ������. }
  cc_EOL_Len  = 2;
  cc_EOLW      = WideString(#13) + WideString(#10);
   {* - ����� ������ � ��������� ������. }
  cc_EOLW_Size = 4;
  cc_HardEnterSymbol = #182#0;
   {* - ������ ��� ����������� ����� ������. }
  cc_HardEnterSymbol_Len = 1;
  cc_SoftEnterSymbol = #191#0;
   {* - ������ ��� ����������� ����� ������. }
  cc_SoftEnterSymbol_Len = 1;
  cc_SoftSpaceSymbol = #176;
   {* - ������ ��� ����������� ������������ �������. }
  cc_HardSpaceSymbol = #183;
   {* - ������ ��� ����������� �������� �������. }
  cc_TabSymbol       = #172;
   {* - ������ ��� ����������� ���������. }
  cc_OEMHardSpaceSymbol = #250;
   {* - ������ ��� ����������� �������� ������� � OEM. }
  cc_OEMSoftSpaceSymbol = #248;
   {* - ������ ��� ����������� ������������ ������� � OEM. }

const
  { Language locale identifiers }
  LCID_RUSSIAN = $0419;
    {* - ��������� ������������ ������������� �������� �����. }

const
  { Code Pages }
  CP_Unicode      = l3Interfaces.CP_Unicode;
   {* - ��������� �������������� ��������� Unicode. }
  CP_DefaultValue = -2;
   {* - ��������� �������������� ��������� �� ���������. }
  CP_KOI8         = -4;
   {* - ��������� �������������� ��������� KOI-8. }
  CP_ANSI         = l3Interfaces.CP_ANSI;
   {* - ��������� �������������� ��������� ANSI. }
  CP_OEM          = l3Interfaces.CP_OEM;
   {* - ��������� �������������� ��������� OEM. }
  {$IfDef l3Requires_m0}
  CP_OEMLite      = -3;
   {* - ��������� �������������� ��������� OEM (� ������ ��������� ��������). }
  {$Else  l3Requires_m0}
  CP_OEMLite      = CP_OEM;
  {$EndIf l3Requires_m0}
  CP_Symbol       = 42;
  CP_RussianDOS   = 866;
   {* - ��������� �������������� ��������� �������� ����� ��� DOS. }
  CP_Thai         = 874;
  CP_Shift_JIS    = 932;
  CP_EastEurope   = 1250;
  CP_RussianWin   = 1251;
   {* - ��������� �������������� ��������� �������� ����� ��� Windows. }
  CP_WesternWin   = 1252;
   {-}
  CP_Greek        = 1253;
  CP_Turkish      = 1254;
  CP_Hebrew       = 1255;
  CP_Arabic       = 1256;
  CP_Baltic       = 1257;

  CP_Tatar        = -5;
   {* - ��������� ���������. }
  CP_TatarOEM     = -6;
   {* - ��������� ��������� OEM. }
  CP_KeepExisting = -7;
   {* - �������� � ��� ���������, � ������� ������ ����������. } 
  CS_Ansi      = l3Interfaces.CS_Ansi;
   {-}
  CS_OEM       = l3Interfaces.CS_OEM;
   {-}
  CS_Default   = l3Interfaces.CS_Default;
   {-}
  CS_Effective = l3Interfaces.CS_Effective;
   {-}
  CS_Russian   = l3Interfaces.CS_Russian;
   {-}
  fs_Cyr = ' CYR';
   {-} 
  fs_New = ' New';
   {-} 

const
  cc_UnAssignedStr  : Tl3PCharLenPrim = (S         : nil;
                                          SLen      : 1;
                                          SCodePage : CP_ANSI
                                          );
  cc_EmptyStr       : Tl3PCharLenPrim = (S         : '';
                                          SLen      : 0;
                                          SCodePage : CP_ANSI);
  cc_SoftEnterStr   : Tl3PCharLenPrim = (S         : cc_SoftEnterSymbol;
                                         SLen      : cc_SoftEnterSymbol_Len;
                                          SCodePage : CP_ANSI
                                          );
  cc_HardEnterStr   : Tl3PCharLenPrim = (S         : cc_HardEnterSymbol;
                                         SLen      : cc_HardEnterSymbol_Len;
                                          SCodePage : CP_ANSI);
  cc_CurrencyStr    : Tl3PCharLenPrim = (S         : cc_CurrencySign;
                                         SLen      : 1;
                                          SCodePage : CP_ANSI);
  cc_HyphenStr      : Tl3PCharLenPrim = (S         : cc_Hyphen; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_EOLStr         : Tl3PCharLenPrim = (S         : cc_EOL; SLen      : cc_EOL_Len;
                                          SCodePage : CP_ANSI;
                                          );
  cc_EOPStr         : Tl3PCharLenPrim = (S         : cc_EOP; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_LeftTabSymbol  : Tl3PCharLenPrim = (S         : #$E8; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_RightTabSymbol : Tl3PCharLenPrim = (S         : #$E7; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_EmptyTabSymbol : Tl3PCharLenPrim = (S         : cc_HardSpace; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_TabStr : Tl3PCharLenPrim = (S         : cc_Tab; SLen      : 1;
                                          SCodePage : CP_ANSI;
                                          );
  cc_SoftEnterNativeStr   : Tl3PCharLenPrim = (S         : cc_SoftEnter;
                                         SLen      : 1;
                                          SCodePage : CP_ANSI
                                          );
  cc_HardEnterNativeStr   : Tl3PCharLenPrim = (S         : cc_HardEnter;
                                         SLen      : 1;
                                          SCodePage : CP_ANSI);

const
  cc_LeftCross    = #195; { |- }
  cc_RightCross   = #180; { -| }
  cc_Cross        = #197; { +  }
  cc_HLine        = #196; { -  }
  cc_VLine        = #179; { |  }
  cc_UpCross      = #194; { T  }
  cc_BottomLeft   = #192; { L  }
  cc_BottomRight  = #217; { J  }
  cc_DownCross    = #193; { |  }
                          { -  }
  cc_TopLeft      = #218; { �  }
  cc_TopRight     = #191;

  cc_HCrosses = [cc_Cross, cc_UpCross, cc_DownCross];
  cc_VCrosses = [cc_Cross, cc_LeftCross, cc_RightCross];

  cc_LeftFrames = [cc_LeftCross, cc_HLine, cc_TopLeft, cc_BottomLeft] +
                   cc_HCrosses;

  cc_RightFrames = [cc_RightCross, cc_HLine, cc_TopRight, cc_BottomRight] +
                    cc_HCrosses;

  cc_UpFrames = [cc_UpCross, cc_VLine, cc_TopLeft, cc_TopRight] +
                 cc_VCrosses;

  cc_DownFrames = [cc_DownCross, cc_VLine, cc_BottomLeft, cc_BottomRight] +
                   cc_VCrosses;

  sp_Cross      : Tl3StrPair = ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_Cross; SLen: 1; SCodePage: CP_OEM;));

  sp_HardSpace  : Tl3StrPair = (( S: cc_HardSpace; SLen: 1; SCodePage: CP_ANSI;),
                                (  S: cc_HardSpace; SLen: 1; SCodePage: CP_OEM;));

  sp_HLine      : Tl3StrPair = (( S: #151; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_HLine; SLen: 1; SCodePage: CP_OEM;  ));

  sp_LeftCross  : Tl3StrPair = ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_LeftCross; SLen: 1; SCodePage: CP_OEM;  ));

  sp_RightCross : Tl3StrPair = ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_RightCross; SLen: 1; SCodePage: CP_OEM;  ));

  sp_VLine      : Tl3StrPair = ((S: '|'; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_VLine; SLen: 1; SCodePage: CP_OEM;  ));

  sp_UpCross    : Tl3StrPair = ((S: 'T'; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_UpCross; SLen: 1; SCodePage: CP_OEM;  ));

  sp_TopLeft    : Tl3StrPair = ((S: '�'; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_TopLeft; SLen: 1; SCodePage: CP_OEM;  ));

  sp_TopRight   : Tl3StrPair = ((S: #172; SLen: 1; SCodePage: CP_ANSI; ),
                                (S: cc_TopRight; SLen: 1; SCodePage: CP_OEM;  ));

const
 l3_bCodePage : array [Boolean] of Integer = (CP_ANSI, CP_OEM);

 cc_WordDelimANSISet = [#9,#13,#10,#32,'!','&','(',')','*','+',',','-','.','/',':',';','<','=','>',
                        '?','@','[','\',']','^','`','{','|','}','~','''',
                        cc_Ellipsis, cc_ParagraphSign, cc_BrokenBar, cc_LargeDash,
                        cc_SingleQuote, cc_DoubleQuote, cc_RSingleQuote, cc_LSingleQuote,
                        cc_LDoubleQuote, cc_RDoubleQuote, cc_DoubleLowQuote,
                        cc_LTSingleQuote, cc_RTSingleQuote,
                        cc_LTDoubleQuote, cc_RTDoubleQuote,
                        cc_SoftSpace];

 cc_WordDelimOEMSet  = [#9,#13,#10,#32,'!','&','(',')','*','+',',','-','.','/',':',';','<','=','>',
                        '?','@','[','\',']','^','`','{','|','}','~','''',#179,
                        cc_SingleQuote, cc_DoubleQuote,
                        cc_OEMSoftSpace,
                        cc_OEMParagraphSign] + cc_Graph_Criteria;

implementation

end.
