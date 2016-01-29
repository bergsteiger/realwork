unit l3LingLib;

{ ���������� "L3 (Low Level Library)" }
{ �����: ������� �.�.                 }
{ ������: l3LingLib - ��������� � ��������������� ���������� ��������� mlma32ru.dll }
{ �����: 01.04.2009 }
{ $Id: l3LingLib.pas,v 1.22 2013/06/19 10:04:58 fireton Exp $ }

// $Log: l3LingLib.pas,v $
// Revision 1.22  2013/06/19 10:04:58  fireton
// - char -> AnsiChar (K 460261935)
//
// Revision 1.21  2013/04/12 16:25:07  lulin
// - ���������� ��� XE3.
//
// Revision 1.20  2013/04/10 13:59:30  lulin
// - ���������.
//
// Revision 1.19  2013/04/05 12:03:00  lulin
// - ���������.
//
// Revision 1.18  2012/11/01 09:42:57  lulin
// - ����� ����� � �������.
//
// Revision 1.17  2012/11/01 07:45:08  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.16  2010/10/20 14:00:08  voba
// no message
//
// Revision 1.15  2010/10/04 14:08:28  fireton
// - const ����� Tl3WString � Il3CString
//
// Revision 1.14  2010/10/01 07:54:54  voba
// - k:235865115
//
// Revision 1.13  2010/08/20 11:46:01  voba
// - k:233016367
//
// Revision 1.12  2010/05/05 11:42:21  voba
// - enh. procedure ApplayCapsScheme ����� � ��������� (bug fix)
//
// Revision 1.11  2010/05/05 10:28:07  voba
// - enh. procedure ApplayCapsScheme ����� � ���������
//
// Revision 1.10  2010/03/11 13:29:37  voba
// - add ���������� ������������� ������
//
// Revision 1.9  2009/12/21 08:46:51  voba
// no message
//
// Revision 1.8  2009/10/07 06:49:44  voba
// - add overload function mlmaLemmatize
// - add function mlmaRusIsVerb
// - add function mlmaRusIsconjunction
//
// Revision 1.7  2009/09/25 10:30:46  voba
// - add function mlmaLemmatize
//
// Revision 1.6  2009/06/09 08:29:22  voba
// - add function mlmaRusPartOfSpeechStr  (��� �������)
// - bug fix function mlmaRusDeclensionStr
//
// Revision 1.5  2009/05/14 13:04:10  voba
// - add function mlmaRusIsNoun
// - tune function mlmaRusDeclensionStr �������� �� ������� ���������������� � ������������ ������
//
// Revision 1.4  2009/05/04 13:46:59  voba
// - bug fix function mlmaRusDeclensionStr
//
// Revision 1.3  2009/04/29 09:06:01  voba
// - ������������ �������� DLL
//
// Revision 1.2  2009/04/28 06:48:18  voba
// - ������� ��������� �������� ���������
//
// Revision 1.1  2009/04/14 14:13:30  voba
// no message
//

interface
uses
 SysUtils,
 l3Interfaces;

const
 //��������� �����������
 maStopAfterFirst = $0001; // ����������� ������� �� ������� ��������������
 maIgnoreCapitals = $0002; // ������������ ������������ ����� �������������
 maHardForms      = $0004; // ��������� ������������ ����� ����
 maAdjVerbs       = $0100; // ������������� ���������, ��� ��������������

type
 TLexID = Cardinal;

 PSGramInfo = ^TSGramInfo;
 TSGramInfo = packed record
  rWInfo : Byte;
  rIForm : Byte;
  rGInfo : Word;
  rOther : Byte;
 end;

  PSGramInfoBox = ^TSGramInfoBox;
  TSGramInfoBox = packed record
   rCount    : Byte;
   rGramInfo : array [0..64] of TSGramInfo;
  end;

const
 cLexIDBufSize  = 32;
 cLemmBufSize   = 256;

type
 TLexIDBuf  = Array[0 .. Pred(cLexIDBufSize)] of TLexID;
 TLemmBuf   = Array[0 .. Pred(cLemmBufSize)] of AnsiChar;

//**************************************************************************/
//*            �������������� ���������� �� ������ ���������               */
//*                                                                        */
//*                                *******                                 */
//*                                                                        */
//* ������������ �����, ������� 2 �����. �������������� ����������.        */
//*                                                                        */
//* @+++++++ ++++++++ - ���������� ����� (������� � ��������������)        */
//* +@@@++++ ++++++++ - �����                                              */
//* ++++@+++ ++++++++ - �����                                              */
//* +++++@@+ ++++++++ - ���                                                */
//* +++++++@ ++++++++ - ������� ����� (��� ����. � ����.)                  */
//* ++++++++ @+++++++ - ������������� �������                              */
//* ++++++++ +@@+++++ - ���������, ������������, ������������� ���������   */
//* ++++++++ +++@@+++ - ���� (��� �������� � �� ����)                      */
//* ++++++++ +++++@@@ - �������'�� �������������� ���������� �����         */
//*                                                                        */
//* ���� �������������� �������������� "��������������" ����, ���������-   */
//* ���� ������� �������� ������ ���������:                                */
//*                                                                        */
//*          +++++++@ - ��������� ��� ������������� �����                  */
//*          ++++++@+ - ��������� ��� ��������������� �����                */
//**************************************************************************/

const
 cwfMultiple   =  $40;    //  ������������� �����

 cafAnimated   =  $01;    //
 cafNotAlive   =  $02;    //
 cafHardForm   =  $04;    //  ������������ �����
 cafJoiningC   =  $08;    //  ����. �������

 cgfRetForms   =  $8000;  //  ���������� �����
 cgfFormMask   =  $7000;  //  ����� ��� �������
 cgfMultiple   =  $0800;  //  ������������� �����
 cgfGendMask   =  $0600;  //  ���
 cgfShortOne   =  $0100;  //  ������� �����
 cgfCompared   =  $0080;  //  ������������� �������
 cgfVerbForm   =  $0060;  //  ���������� ����������
 cgfAdverb     =  $0040;  //  ������� �� ����.
 cgfVerbFace   =  $0018;  //  ����
 cgfVerbTime   =  $0007;  //  �����

 cvtInfinitiv =   $0001;  //  ���������
 cvtImperativ =   $0002;  //  �������. ����������
 cvtFuture    =   $0003;  //  ������� �����
 cvtPresent   =   $0004;  //  ��������� �����
 cvtPast      =   $0005;  //  ��������� �����

 cvbFirstFace  =  $0008;  //  ������ ����
 cvbSecondFace =  $0010;  //  ������ ����
 cvbThirdFace  =  $0018;  //  ������ ����

 cvfVerb       =  $0000;  //  ���������� �����
 cvfVerbActive =  $0020;  //  ��������. ���������
 cvfVerbPassiv =  $0040;  //  �����. ���������
 cvfVerbDoing  =  $0060;  //  ������������

type
 TLingException = class(Exception);

type
 TllAddStrProc = procedure(aWord : PAnsiChar; aWordLen : integer);


 function mlmaruCheckWord(aWord    : PAnsiChar;
                          aOptions : Word): Smallint;
{* -
  ������� ��������� �������� ������������ ����� �� ������� � ����������
    * 1, ���� ����� ��������;
    * 0, ���� ����� �� ��������;
    * �������� ������ ���� � ������ ������ (���� ������ ��. ����).
  ���������:
    * aWord - ��������� �� ������ � ��������� 1251 Windows Cyrillic;
    * aOptions - ��������� ���������������� ����������� (��. ����).
}

 function mlmaruLemmatize(aWord    : PAnsiChar;
                          aOptions : Word;
                          aBuff    : PAnsiChar;
                          aLids    : Pointer;
                          aInfo    : PAnsiChar;
                          aBuffLen : Word;
                          aLidsLen : Word;
                          aInfoLen : Word): Smallint;
{* -
  ������� ��������� �������������� �������� ������ �� ���������������� ������� � ����������
    * ���������� ������, � ������� ������� ��������� ��������������;
    * 0, ���� ����� �� ��������;
    * �������� ������ ���� � ������ ������ (���� ������ ��. ����).
  ���������:
    * aWord    - ��������� �� ������ � ��������� 1251 Windows Cyrillic;
    * aOptions - ��������� ���������������� ����������� (��. ����);
    * aBuff    - ��������� �� ������, � ������� ���������� �������� ����������� ������� �������� ���������� ����� ����,
                 � �������� ��������� �������������� (���� �������� ������� ��������, ���������� ����� �� ��������);
    * aLids    - ��������� �� ������, � ������� ���������� ������ �������������� ������,
                 ��������������� ���������� ������ ���� (���� �������� ������� ��������, �������������� ������ �� ��������);
    * aInfo    - ��������� �� ������, � ������� ���������� ������ �������������� �������� (SGramInfo) ��� ����,
                 � �������� ��������� �������������� (���� �������� ������� ��������, �������������� �������� �� ��������);
    * aBuffLen - ������ ������� lpLemm ��� 0, ���� lpLemm == NULL;
    * aLidsLen - ����������� ������� lpLids ��� 0, ���� lpLids == NULL;
    * aInfoLen - ������ ������� lpGram ��� 0, ���� lpGram == NULL.

    ������ ������������ ������� �������������� ��������:
      ������ ������ ����� ���������� �������������� �������� ���������������� ���� ��� ��������� �������.
      ������ �� ��� ����� ��������� ���������� �������� SGramInfo, ������ �� ������� ��������� ��������������
      � ���������� �������������� ������. ����� �� � lpGram ����������������� ������� ������ ��������� ���������,
      � ������� �������� ������ ��������� ��������������.
      ��������, ��� ������������ ����� "����������" ������� mlmaruLemmatize ���������� 1.
      ��� ��������, ��� �������������� ��������� � ������� ����� �������, � lpLemm ����� ������������� ����� "����������",
      � lpLids - ������������� �������, � � lpGram ����� ������� ���� ���� �������������� ��������
      (���������� �������������� - 3, �.��., �.��., �.��.).
}

 function  mlmaruBuildForm(aWord    : PAnsiChar;
                           aLxID    : Longint;
                           aOptions : Word;
                           aFormID  : Byte;
                           aBuff    : PAnsiChar;
                           aBuffLen : Word): Smallint;
{* -
  ������� ������ ����� ���������� �����, ��������������� ��������������, � ����������
    * ���������� ����������� ���� (�������� ������ ����);
    * 0, ���� ������ ����� ��� � ������� ��� � ����� ��� ����� �����;
    * �������� ������ ���� � ������ ������ (���� ������ ��. ����).
   ���������:
    * aWord    - ��������� �� ������ � ��������� 1251 Windows Cyrillic (����� ���� 0, � ���� ������ ����������� ������ ���� ����� ������������� �������);
    * aLxID    - ������������� ������� (���� ������ ������, �� ��� ����� �� ���������, ������ ���������� �������, ����� �� ���� ��������� ������� �����, ����������� ��� �������������� ���������� ������ � ������� ���������� ������);
    * aOptions - ��������� ���������������� ����������� (��. ����);
    * aFormID  - ������������� �������������� ����� �����;
    * aBuff    - ��������� �� ������, � ������� ���������� �������� ����������� ������� �������� ����� �����;
    * aBuffLen - ������ ������� aBuff
}

 function mlmaruBuildFormGI(aWord    : PAnsiChar;
                            aLxID    : Longint;
                            aOptions : Word;
                            aGrInfo  : Word;
                            aFlags   : Byte;
                            aBuff    : PAnsiChar;
                            aBuffLen : Word): Smallint;
{* -
  ������� ������ ����� ���������� �����, ��������������� ����������� ��������������� ��������, � ����������
    * ���������� ����������� ���� (�������� ������ ����);
    * 0, ���� ������ ����� ��� � ������� ��� � ����� ��� ����� �����;
    * �������� ������ ���� � ������ ������ (���� ������ ��. ����).
  ���������:
    * aWord    - ��������� �� ������ � ��������� 1251 Windows Cyrillic (����� ���� 0, � ���� ������ ����������� ������ ���� ����� ������������� �������);
    * aLxID    - ������������� ������� (���� ������ ������, �� ��� ����� �� ���������, ������ ���������� �������, ����� �� ���� ��������� ������� �����, ����������� ��� �������������� ���������� ������ � ������� ���������� ������);
    * aOptions - ��������� ���������������� ����������� (��. ����);
    * aGrInfo  - ���������� �������������� �������� ����� ����� (��. ����);
    * aFlags   - ����� ��������������/����������������;
    * aBuff    - ��������� �� ������, � ������� ���������� �������� ����������� ������� �������� ����� �����;
    * aBuffLen - ������ ������� aBuff
}

 function mlmaruCheckHelp(aWord       : PAnsiChar;
                          aSubstChars : PAnsiChar): Smallint;
{* -
  ������� ��������������� ������������ ��������� ��� �������� ���������� � �������� ����.
  � ����� �� ������-������, ���������� ���� ������ ? ��� * ������ ������ ��������, ������� ����� �� ������ �� ��� �����.
  ��� ���� * ������ ��� �������� ������, � ? ���������� ���� ������. ����������:
    * ���������� ����������� �������� � ������ ��������� ���������� ��������;
    * 0 � ������, ���� ������� ������� �� ������������� �� ���� ����������;
    * �������� ������ ���� � ������ ������ (���� ������ ��. ����).
  ���������:
    * aWord       - ��������� �� ������-������ � ��������� 1251 Windows Cyrillic;
    * aSubstChars - ����� ������� �������� �� ����� 35 ��������, � ������� ����� �������� �������-�����������.
}

function  L2llAddStrProc(Action: Pointer): TllAddStrProc; register;
procedure FreellAddStrProc(var Stub: TllAddStrProc); register;

procedure mlmaSpellCheck(aWord : PAnsiChar; aWordLen : Word; {aCodePage: Longint;} aAddFunc : TllAddStrProc);

function mlmaCheckErr(aCode : Smallint) : Smallint;

function mlmaRusPartOfSpeechStr(aWInfo : Byte): AnsiString;

function mlmaLemmatize(aWord : PAnsiChar; aWordLen : word; aOptions : Word; aAddFunc : TllAddStrProc) : boolean;
 overload;

function mlmaLemmatize(const aWord : Tl3WString; aOptions : Word; aAddFunc : TllAddStrProc) : boolean;
 overload;
{}

const
//RusDeclension
// ������

 rdIment  = $0000;  //������������  ���? ���?
 rdRodit  = $1000;  //�����������   ����? ����?
 rdDatel  = $2000;  //���������     ����? ����?
 rdVinit  = $3000;  //�����������   ����? ���?
 rdTvorit = $4000;  //������������  ���? ���?
 rdPredl  = $5000;  //����������    � ���? � ���?

type
 TRusDeclension = Word;

function mlmaRusDeclension(aWord : PAnsiChar; aWordLen : Word; aDeclension : TRusDeclension) : AnsiString;
function mlmaRusDeclensionStr(const aString: AnsiString; aDeclension : TRusDeclension): AnsiString;

//����� ����
//��������! ����� ���� ���� (SGramInfo.wInfo & 0x3f) 	��������
// 1 	 ������ �������������� ����
// 2 	 ������������ ������ �������������� ����
// 3 	 ������ ������������ ����
// 4 	 ������������ ������ ������������ ����
// 5 	 ���������� ������
// 6 	 ������������ ���������� ������

// 7 	 ������. ��������������� �������� ����
// 8 	 ����. ��������������� �������� ����
// 9 	 ����.-������. ��������������� �������� ����
// 10 	 ������. ��������������� �������� ����, ������������ �� ����� ��������
// 11 	 ����. ��������������� �������� ����, ������������ �� ����� ��������
// 12 	 ����. ��������������� �������� ����, ������������ �� ����� ��������
// 13 	 ������. ��������������� �������� ����
// 14 	 ����. ��������������� �������� ����
// 15 	 ����.-������. ��������������� �������� ����
// 16 	 ������. ��������������� �������� ����
// 17 	 ����. ��������������� �������� ����
// 18 	 ����.-������. ��������������� �������� ����
// 19 	 ������. ��������������� ������ ����
// 20 	 ����. ��������������� ������ ����
// 21 	 ������. ��������������� ��������/�������� ����
// 22 	 ����. ��������������� ��������/�������� ����
// 23 	 ������. ��������������� ��������/�������� ����
// 24 	 ������. ��������������� �������������� �����

// 25 	 ��������������
// 26 	 ��������������, ������������ �� ��������������� ��������
// 27 	 �������������� �����������
// 28 	 ������������ ��������������
// 29 	 ����������� �������������� �����
// 30 	 ����������� �������� ����
// 31 	 ����������� �������� ����
// 32 	 ����������� �������� ����
// 33 	 ������������
// 34 	 ������������ "���"
// 35 	 ������������� ������������
// 36 	 ���������� ������������
// 37 	 ��� �����������
// 38 	 ��� �������� ����
// 39 	 ��� �������� ����
// 40 	 �������� �������� ����
// 41 	 �������� �������� ����
// 42 	 �������
// 43 	 ������������ �������������� ��������
// 44 	 �������������� �������� �������� ����
// 45 	 �������������� �������� �������� ����
// 46 	 �������������� �������� �������� ����
// 47 	 �������������� �������� �������������� �����
// 48 	 ������� �����
// 49 	 ����������
// 50 	 ����������
// 51 	 �������
// 52 	 ����
// 53 	 �������
// 54 	 �������
// 59 	 ������������, ��������� ���������� �������
// 60 	 ������������, ��������� ��������� �������

function mlmaRusIsNoun(aGramInfo : TSGramInfo): Boolean; //���������������
function mlmaRusIsAdjective(aGramInfo : TSGramInfo): Boolean; //��������������
function mlmaRusIsWideAdjective(aGramInfo : TSGramInfo): Boolean; //�������������� "� ������� ������" (+ ���������� ������������)
function mlmaRusIsVerb(aGramInfo : TSGramInfo): Boolean; //������
function mlmaRusIsconjunction(aGramInfo : TSGramInfo): Boolean; //����

type
 TCapScheme = Set Of byte;

function GetCapsScheme(aWord : PAnsiChar; aWordLen : Word) : TCapScheme;
// �������� ����� �������������
procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aScheme : TCapScheme); overload;
// ��������� ����� �������������
procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aSrcWord : PAnsiChar; aSrcWordLen : Word); overload;
// ����������� ����� ������������� � aSrcWord

implementation
uses
 Windows,
 l3Base,
 l3Bits,
 l3MinMax,
 l3String;

type
 TmlmaCheckWord = function(aWord: PAnsiChar;
                           aOptions: Word): SmallInt; stdcall;

 TmlmaLemmatize = function(aWord: PAnsiChar;
                           aOptions: Word;
                           aBuff: PAnsiChar;
                           aLids: Pointer;
                           aInfo: PAnsiChar;
                           aBuffLen: Word;
                           aLidsLen: Word;
                           aInfoLen: Word): SmallInt; stdcall;

 TmlmaBuildForm = function(aWord    : PAnsiChar;
                           aLxID    : Longint;
                           aOptions : Word;
                           aFormID  : Byte;
                           aBuff    : PAnsiChar;
                           aBuffLen : Word): SmallInt; stdcall;

 TmlmaBuildFormGI = function(aWord    : PAnsiChar;
                             aLxID    : Longint;
                             aOptions : Word;
                             aGrInfo  : Word;
                             aFlags   : Byte;
                             aBuff    : PAnsiChar;
                             aBuffLen : Word): SmallInt; stdcall;

 TmlmaCheckHelp = function(aWord       : PAnsiChar;
                           aSubstChars : PAnsiChar): SmallInt; stdcall;


resourcestring
  rcCannonLoadLibrary = '���������� ��������� ����������: ';
  rcLingDllName = 'mlma32ru.dll';

var
  gLingDLL : hModule = 0;

 // ������� �� mlma32ru.dll:
 gfCheckWord   : TmlmaCheckWord   = nil;
 gfLemmatize   : TmlmaLemmatize   = nil;
 gfBuildForm   : TmlmaBuildForm   = nil;
 gfBuildFormGI : TmlmaBuildFormGI = nil;
 gfCheckHelp   : TmlmaCheckHelp   = nil;

procedure CheckLingDLL;
begin
 if (gLingDLL <> 0) then Exit;

 gLingDLL := LoadLibrary(PChar(rcLingDllName));
 if (gLingDLL = 0) then
  raise Exception.Create(rcCannonLoadLibrary + rcLingDllName);

 @gfCheckWord   := GetProcAddress(gLingDLL, 'mlmaruCheckWord');
 @gfLemmatize   := GetProcAddress(gLingDLL, 'mlmaruLemmatize');
 @gfBuildForm   := GetProcAddress(gLingDLL, 'mlmaruBuildForm');
 @gfBuildFormGI := GetProcAddress(gLingDLL, 'mlmaruBuildFormGI');
 @gfCheckHelp   := GetProcAddress(gLingDLL, 'mlmaruCheckHelp');
end;

function mlmaruCheckWord(aWord: PAnsiChar;
                         aOptions: Word): SmallInt;
begin
 CheckLingDLL;
 Result := gfCheckWord(aWord, aOptions);
end;

function mlmaruLemmatize(aWord: PAnsiChar;
                         aOptions: Word;
                         aBuff: PAnsiChar;
                         aLids: Pointer;
                         aInfo: PAnsiChar;
                         aBuffLen: Word;
                         aLidsLen: Word;
                         aInfoLen: Word): SmallInt;
begin
 CheckLingDLL;
 Result := gfLemmatize(aWord, aOptions, aBuff, aLids, aInfo, aBuffLen, aLidsLen, aInfoLen);
end;

function  mlmaruBuildForm(aWord    : PAnsiChar;
                          aLxID    : Longint;
                          aOptions : Word;
                          aFormID  : Byte;
                          aBuff    : PAnsiChar;
                          aBuffLen : Word): SmallInt;
begin
 CheckLingDLL;
 Result := gfBuildForm(aWord, aLxID, aOptions, aFormID, aBuff, aBuffLen);
end;

function mlmaruBuildFormGI(aWord    : PAnsiChar;
                           aLxID    : Longint;
                           aOptions : Word;
                           aGrInfo  : Word;
                           aFlags   : Byte;
                           aBuff    : PAnsiChar;
                           aBuffLen : Word): SmallInt;
begin
 CheckLingDLL;
 Result := gfBuildFormGI(aWord, aLxID, aOptions, aGrInfo, aFlags, aBuff, aBuffLen);
end;

function mlmaruCheckHelp(aWord       : PAnsiChar;
                         aSubstChars : PAnsiChar): SmallInt;
begin
 CheckLingDLL;
 Result := gfCheckHelp(aWord, aSubstChars);
end;

procedure helpRegisterStr(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
var
 lLexIDBuf  : TLexIDBuf;
 lSGInfoBuf : TSGramInfoBox;
 lLemmBuf   : TLemmBuf;
begin
 if gfCheckWord(aWord, 0) = 1 then
  // ������� ����������
  aAddFunc(aWord, aWordLen)
 else
  if gfLemmatize(aWord, maIgnoreCapitals,
                     nil, @lLexIDBuf, @lSGInfoBuf,
                     0, SizeOf(lLexIDBuf), SizeOf(lSGInfoBuf)) = 1 then

   if gfBuildForm(nil, lLexIDBuf[0], 0, lSGInfoBuf.rGramInfo[0].rIForm,
                      @lLemmBuf, Pred(cLemmBufSize)) = 1 then
    aAddFunc(@lLemmBuf, StrLen(PAnsiChar(@lLemmBuf)))
end;

procedure helpCheckVariant(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
begin
 if gfCheckWord(aWord, maIgnoreCapitals) = 1 then
  helpRegisterStr(aWord, aWordLen, aAddFunc);
end;

procedure helpFindMistype(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
// ������������ �����
var
 lSaveChar   : AnsiChar;
 lSubstChars : array[0..34] of AnsiChar;
 lSCharsCnt  : Integer;
 lPos        : Integer;
begin
 for lPos := Pred(aWordLen) downto 0 do
 begin
  lSaveChar := aWord[lPos];
  aWord[lPos] := '?';
  try
   lSCharsCnt := gfCheckHelp(aWord, lSubstChars);

   while lSCharsCnt > 0 do
   begin
    aWord[lPos] := lSubstChars[Pred(lSCharsCnt)];
    helpCheckVariant(aWord, aWordLen, aAddFunc);
    Dec(lSCharsCnt);
   end;
  finally
   aWord[lPos] := lSaveChar;
  end;
 end;
end;

procedure helpFindSkipped(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
// ����������� �����
var
 lSubstChars : array[0..34] of AnsiChar;
 lWordCopy   : array[0..255] of AnsiChar;
 lSCharsCnt  : Integer;
 lPos        : Integer;
begin
 //make copy
 StrMove(@lWordCopy[0], aWord, aWordLen);
 lWordCopy[aWordLen] := #0;

 for lPos := aWordLen downto 1 do
 begin
  lWordCopy[lPos + 1] := lWordCopy[lPos];
  lWordCopy[lPos] := '?';
  lSCharsCnt := gfCheckHelp(lWordCopy, lSubstChars);
  while lSCharsCnt > 0 do
  begin
   lWordCopy[lPos] := lSubstChars[Pred(lSCharsCnt)];
   helpCheckVariant(lWordCopy, aWordLen + 1, aAddFunc);
   Dec(lSCharsCnt);
  end;
 end;
end;

procedure helpFindNoSpace(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
// ��������� �����
var
 lSubstChars : array[0..34] of AnsiChar;
 lWordCopy   : array[0..255] of AnsiChar;
 lSCharsCnt  : Integer;
 lPos        : Integer;
begin
 //make copy
 StrMove(@lWordCopy[0], aWord, aWordLen);
 lWordCopy[aWordLen + 1] := #0;

 for lPos := pred(aWordLen) downto 1 do
 begin
  lWordCopy[lPos + 1] := lWordCopy[lPos];
  lWordCopy[lPos] := #0;

  if (gfCheckWord(lWordCopy, 0) = 1) and
     (gfCheckWord(lWordCopy + lPos + 1, 0) = 1) then
  begin
   lWordCopy[lPos] := ' ';
   aAddFunc(lWordCopy, aWordLen + 1);
  end;
 end;
end;

procedure helpFindRandoms(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
// ������ �����
var
 lSaveChar : AnsiChar;
 lSaveChar2 : AnsiChar;
 lCharPtr  : Integer;
begin
 if aWordLen <= 1 then Exit;

 lCharPtr := 0;
 lSaveChar := aWord[0];

 while true do
 begin
  helpCheckVariant(aWord + 1, aWordLen - 1, aAddFunc);
  Inc(lCharPtr);
  if lCharPtr = aWordLen then
   break;
  lSaveChar2 := aWord[lCharPtr];
  aWord[lCharPtr] := lSaveChar;
  lSaveChar := lSaveChar2;
 end;

 // ����������� ������
 if lCharPtr > 0 then
 begin
  StrMove(aWord + 1, aWord + 2, aWordLen - 2);
  aWord[aWordLen - 1] := lSaveChar;
 end;
end;

procedure helpFindSwapped(aWord : PAnsiChar; aWordLen : Word; aAddFunc : TllAddStrProc);
// ��������� �����
var
 lSaveChar : AnsiChar;
 I : Integer;
begin
 if aWordLen <= 1 then Exit;

 for I := 0 to aWordLen - 2 do
 begin
  {swap}
  lSaveChar := aWord[I];
  aWord[I] := aWord[I+1];
  aWord[I+1] := lSaveChar;

  helpCheckVariant(aWord, aWordLen, aAddFunc);

  {revert swap}
  lSaveChar := aWord[I];
  aWord[I] := aWord[I+1];
  aWord[I+1] := lSaveChar;
 end;
end;

procedure mlmaSpellCheck(aWord : PAnsiChar; aWordLen : Word; {aCodePage: Long;} aAddFunc : TllAddStrProc);
var
 lWordCopy : array[0..255] of AnsiChar;
begin
 CheckLingDLL; //��� ��������� ������� ��� ���������
 if aWordLen > 255 then Exit; // � ����� �� ������ !! ������������ �������� ��� ��������� ������������� ���
 //make copy
 StrMove(@lWordCopy[0], aWord, aWordLen);
 lWordCopy[aWordLen] := #0;

 //if aCodePage <> CP_ANSI then
 // {�����������};

 helpFindMistype(lWordCopy, aWordLen, aAddFunc);
 helpFindRandoms(lWordCopy, aWordLen, aAddFunc);
 helpFindSwapped(lWordCopy, aWordLen, aAddFunc);
 helpFindSkipped(lWordCopy, aWordLen, aAddFunc);
 helpFindNoSpace(lWordCopy, aWordLen, aAddFunc);
end;

function mlmaLemmatize(aWord : PAnsiChar; aWordLen : word; aOptions : Word; aAddFunc : TllAddStrProc) : boolean;
begin
 Result := mlmaLemmatize(l3PCharLen(aWord, aWordLen), aOptions, aAddFunc);
end;

function mlmaLemmatize(const aWord : Tl3WString; aOptions : Word; aAddFunc : TllAddStrProc) : boolean;


var
 lWordCopy : array[0..255] of AnsiChar;
 lCount    : Smallint;
 lLemmBuf  : TLemmBuf;
 I         : Smallint;
 lLen      : Integer;
 lNormWord : PAnsiChar;
begin
 CheckLingDLL;
 if aWord.SLen > 255 then Exit; // � ����� �� ������
 //make copy
 StrMove(@lWordCopy[0], aWord.S, aWord.SLen);
 lWordCopy[aWord.SLen] := #0;

 //if l3IsANSI(aWord.SCodePage) then
 // {�����������};

 lCount := gfLemmatize(@lWordCopy[0], aOptions,
                       @lLemmBuf, nil {aLids}, nil {aInfo},
                       Pred(cLemmBufSize), 0 {aLidsLen}, 0 {aInfoLen});

 Result := lCount > 0;

 lNormWord := @lLemmBuf;
 for I := 0 to Pred(lCount) do
 begin
  lLen := StrLen(lNormWord);
  aAddFunc(lNormWord, lLen);
  Inc(lNormWord, lLen + 1);
 end;
end;

function mlmaRusDeclensionEx(aWord : PAnsiChar; aWordLen : Word; aDeclension : TRusDeclension; var aGramInfo : TSGramInfo) : AnsiString;
 type
  TWordFormEntry = record
   //rPtr     : PAnsiChar;
   rGInfo   : TSGramInfo;
   rFormInd : Integer;
  end;

 var
  lFormsCount : SmallInt;
  lFormIndex  : Integer;
  lIndex      : Byte;

  lLexIDBuf   : TLexIDBuf;
  lSGInfoBuf  : array[0..$fff{4kb}] of char;
  lSGInfoBufPtr : PAnsiChar;

  lOutWord    : TLemmBuf;

  lWordCopy : array[0..255] of AnsiChar;

  lNounEntry : TWordFormEntry;  //��������� ���������������
  lAdjEntry : TWordFormEntry;   //��������� ��������������

 const
  cUndefIndex = -1;

begin
 CheckLingDLL;
 if aWordLen > 255 then Exit; // � ����� �� ������ !!

 lNounEntry.rFormInd := cUndefIndex;
 lAdjEntry .rFormInd := cUndefIndex;

 //make copy
 StrMove(@lWordCopy[0], aWord, aWordLen);
 lWordCopy[aWordLen] := #0;
 if ({not (m0STRAnsiIsUpper(lWordCopy)) and} (gfCheckWord(lWordCopy, maIgnoreCapitals) = 1)) then
 begin
  lSGInfoBufPtr := @lSGInfoBuf;
  lFormsCount := gfLemmatize(lWordCopy, maIgnoreCapitals,
                 nil, @lLexIDBuf, @lSGInfoBuf,
                 0, SizeOf(lLexIDBuf), SizeOf(lSGInfoBuf));

 // ������ ����� ��������� ��������� ��������������� � �������������� � ������������ ������
 // �������� �����, �������� "���������" ���� ���� ��� ��������������� � �������������� ������������
 // ������ ����� �������� ����� ��� "���������������", ���� ��� ��������, � � �� ��������������� ��������� ����� ������������
  for lFormIndex := 0 to Pred(lFormsCount) do
  begin
   with PSGramInfoBox(lSGInfoBufPtr)^ do
    begin
     for lIndex := 0 to Pred(rCount) do
      with rGramInfo[lIndex] do
      begin
       if ((rGInfo and cgfFormMask) = 0) then // ������������ �����
       begin

        if (lAdjEntry.rFormInd = cUndefIndex) and mlmaRusIsWideAdjective(rGramInfo[lIndex]) then
        begin
         with lAdjEntry do
         begin
          rGInfo := rGramInfo[lIndex];
          rFormInd := lFormIndex;
         end;
         Break;
        end;

        if (lNounEntry.rFormInd = cUndefIndex) and mlmaRusIsNoun(rGramInfo[lIndex]) then
        begin
         with lNounEntry do
         begin
          rGInfo := rGramInfo[lIndex];
          rFormInd := lFormIndex;
         end;
        end;

       end;
      end;
     Inc(lSGInfoBufPtr, SizeOf(rCount) + rCount * SizeOf(TSGramInfo));
   end; //with PSGramInfoBox(lSGInfoBufPtr)^ do
  end;

  // ���� ����� �������������� ������� ���
  if (lAdjEntry.rFormInd <> cUndefIndex) then
  begin
   with lAdjEntry.rGInfo do
   if (mlmaCheckErr(gfBuildFormGI(nil, lLexIDBuf[lAdjEntry.rFormInd], maIgnoreCapitals, rGInfo and not cgfFormMask or aDeclension, rOther, @lOutWord, SizeOf(lOutWord))) > 0) then
   begin
    aGramInfo := lAdjEntry.rGInfo;
    Result := StrPas(lOutWord);
    Exit;
   end;
  end;

  // ���� ����� ��������������� �� ���
  if (lNounEntry.rFormInd <> cUndefIndex) then
  begin
   with lNounEntry.rGInfo do
   if (mlmaCheckErr(gfBuildFormGI(nil, lLexIDBuf[lNounEntry.rFormInd], maIgnoreCapitals, rGInfo and not cgfFormMask or aDeclension, rOther, @lOutWord, SizeOf(lOutWord))) > 0) then
   begin
    aGramInfo := lNounEntry.rGInfo;
    Result := StrPas(lOutWord);
    Exit;
   end;
  end;

 end;
 Result := ''; //StrPas(lWordCopy);
end;

function mlmaRusDeclension(aWord : PAnsiChar; aWordLen : Word; aDeclension : TRusDeclension) : AnsiString;
var
 lGrInfo   : TSGramInfo;
begin
 Result := mlmaRusDeclensionEx(aWord, aWordLen, aDeclension, lGrInfo);
end;

function GetCapsScheme(aWord : PAnsiChar; aWordLen : Word) : TCapScheme;
// �������� ����� �������������
var
 lHasLow : boolean;
 I : Byte;
begin
 Result := [];
 lHasLow := False;
 aWordLen := Min(aWordLen, High(Byte));
 for I := 0 to Pred(aWordLen) do
  if l3IsUpper(aWord[I]) then
   Include(Result, I)
  else
   lHasLow := True;
 if not lHasLow then
  Result := [Low(Byte) .. High(Byte)];
end;

procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aScheme : TCapScheme); overload;
// ��������� ����� �������������
var
 I : Byte;
begin
 if aScheme = [] then exit; // ��������� ��� � ������
 if aScheme = [Low(Byte) .. High(Byte)] then
  CharUpperBuffA(aWord, aWordLen);
 aWordLen := Min(aWordLen, High(Byte));
 for I := 0 to Pred(aWordLen) do
  if I in aScheme then
   CharUpperBuffA(@aWord[I], 1);
end;

procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aSrcWord : PAnsiChar; aSrcWordLen : Word); overload;
// ����������� ����� ������������� � aSrcWord
begin
 ApplayCapsScheme(aWord, aWordLen, GetCapsScheme(aSrcWord, aSrcWordLen));
end;

function mlmaRusDeclensionStr(const aString: AnsiString; aDeclension : TRusDeclension): AnsiString;
var
 lWStart   : Longint;
 lWEnd     : Longint;

 lStrLen   : Integer;

 lDeclWord : AnsiString;
 lDelta    : Integer;
 lBeFound  :  Boolean;

 lGrInfo   : TSGramInfo;
 lCapsScheme : TCapScheme;

begin
 lBeFound := false;
 Result := aString;
 lWStart := 1;
 lStrLen := Length(Result);

 while (lWStart < lStrLen) do
 begin
  while (lWStart <= lStrLen) and
        (l3IsWordDelim(Result[lWStart])) do
   Inc(lWStart);

  lWEnd := lWStart;
  while (lWEnd <= lStrLen) AND
        not (l3IsWordDelim(Result[lWEnd])) do
   Inc(lWEnd);

  if (lWEnd > lWStart) then
  begin
   lCapsScheme := GetCapsScheme(@Result[lWStart], lWEnd - lWStart);
   lDeclWord := mlmaRusDeclensionEx(@Result[lWStart], lWEnd - lWStart, aDeclension, lGrInfo);

   if lDeclWord <> '' then
   begin
    ApplayCapsScheme(PAnsiChar(lDeclWord), Length(lDeclWord), lCapsScheme);
    Delete(Result, lWStart, lWEnd - lWStart);
    Insert(lDeclWord, Result, lWStart);
    lDelta := Length(lDeclWord) - (lWEnd - lWStart); // ���������� �� ������� � ������ ����
    lWStart := lWEnd + lDelta;
    lStrLen := lStrLen + lDelta;
    lBeFound := true;

    if mlmaRusIsNoun(lGrInfo) then // ���� ��������������� - ������ �� ��������, � �� "������������� �������������" ������������ � "� ������������� ������������"
     lWStart := Succ(lStrLen); // end of process
   end
   else
    if lBeFound then
     lWStart := Succ(lStrLen) // end of process
    else
     lWStart := lWEnd;
  end;//l_WordFinish > l_Offset
 end;//not l3IsNil(aStr)
end;

function mlmaRusPartOfSpeechStr(aWInfo : Byte): AnsiString;
begin
 Case (aWInfo and $3f) of
  1  : Result := '������ �������������� ����';
  2  : Result := '������������ ������ �������������� ����';
  3  : Result := '������ ������������ ����';
  4  : Result := '������������ ������ ������������ ����';
  5  : Result := '���������� ������';
  6  : Result := '������������ ���������� ������';

  7  : Result := '������. ��������������� �������� ����';
  8  : Result := '����. ��������������� �������� ����';
  9  : Result := '����.-������. ��������������� �������� ����';
  10 : Result := '������. ��������������� �������� ����, ������������ �� ����� ��������';
  11 : Result := '����. ��������������� �������� ����, ������������ �� ����� ��������';
  12 : Result := '����. ��������������� �������� ����, ������������ �� ����� ��������';
  13 : Result := '������. ��������������� �������� ����';
  14 : Result := '����. ��������������� �������� ����';
  15 : Result := '����.-������. ��������������� �������� ����';
  16 : Result := '������. ��������������� �������� ����';
  17 : Result := '����. ��������������� �������� ����';
  18 : Result := '����.-������. ��������������� �������� ����';
  19 : Result := '������. ��������������� ������ ����';
  20 : Result := '����. ��������������� ������ ����';
  21 : Result := '������. ��������������� ��������/�������� ����';
  22 : Result := '����. ��������������� ��������/�������� ����';
  23 : Result := '������. ��������������� ��������/�������� ����';
  24 : Result := '������. ��������������� �������������� �����';

  25 : Result := '��������������';
  26 : Result := '��������������, ������������ �� ��������������� ��������';
  27 : Result := '�������������� �����������';
  28 : Result := '������������ ��������������';
  29 : Result := '����������� �������������� �����';
  30 : Result := '����������� �������� ����';
  31 : Result := '����������� �������� ����';
  32 : Result := '����������� �������� ����';
  33 : Result := '������������';
  34 : Result := '������������ "���"';
  35 : Result := '������������� ������������';
  36 : Result := '���������� ������������';
  37 : Result := '��� �����������';
  38 : Result := '��� �������� ����';
  39 : Result := '��� �������� ����';
  40 : Result := '�������� �������� ����';
  41 : Result := '�������� �������� ����';
  42 : Result := '�������';
  43 : Result := '������������ �������������� ��������';
  44 : Result := '�������������� �������� �������� ����';
  45 : Result := '�������������� �������� �������� ����';
  46 : Result := '�������������� �������� �������� ����';
  47 : Result := '�������������� �������� �������������� �����';
  48 : Result := '������� �����';
  49 : Result := '����������';
  50 : Result := '����������';
  51 : Result := '�������';
  52 : Result := '����';
  53 : Result := '�������';
  54 : Result := '�������';
  59 : Result := '������������, ��������� ���������� �������';
  60 : Result := '������������, ��������� ��������� �������'
  else
       Result := format('Unknown = %d', [(aWInfo and $3f)]);

 end;
end;

function mlmaRusIsNoun(aGramInfo : TSGramInfo): Boolean; //���������������
begin
 Result := (aGramInfo.rWInfo and $3f) in [7..24];
end;

function mlmaRusIsAdjective(aGramInfo : TSGramInfo): Boolean; //��������������
begin
 Result := (aGramInfo.rWInfo and $3f) in [25];
end;

function mlmaRusIsWideAdjective(aGramInfo : TSGramInfo): Boolean; //�������������� "� ������� ������" (+ ���������� ������������)
begin
 Result := (aGramInfo.rWInfo and $3f) in [25, 36];
end;

function mlmaRusIsVerb(aGramInfo : TSGramInfo): Boolean; //������
begin
 Result := ((aGramInfo.rWInfo and $3f) in [1..6]) and
           ((aGramInfo.rGInfo and (cvfVerbActive or cvfVerbPassiv or cvfVerbDoing)) = 0);
end;

function mlmaRusIsconjunction(aGramInfo : TSGramInfo): Boolean; //����
begin
 Result := (aGramInfo.rWInfo and $3f) in [52];
end;


//����� ����
//��������! ����� ���� ���� (SGramInfo.wInfo & 0x3f) 	��������
// 1 	 ������ �������������� ����
// 2 	 ������������ ������ �������������� ����
// 3 	 ������ ������������ ����
// 4 	 ������������ ������ ������������ ����
// 5 	 ���������� ������
// 6 	 ������������ ���������� ������

// 7 	 ������. ��������������� �������� ����
// 8 	 ����. ��������������� �������� ����
// 9 	 ����.-������. ��������������� �������� ����
// 10 	 ������. ��������������� �������� ����, ������������ �� ����� ��������
// 11 	 ����. ��������������� �������� ����, ������������ �� ����� ��������
// 12 	 ����. ��������������� �������� ����, ������������ �� ����� ��������
// 13 	 ������. ��������������� �������� ����
// 14 	 ����. ��������������� �������� ����
// 15 	 ����.-������. ��������������� �������� ����
// 16 	 ������. ��������������� �������� ����
// 17 	 ����. ��������������� �������� ����
// 18 	 ����.-������. ��������������� �������� ����
// 19 	 ������. ��������������� ������ ����
// 20 	 ����. ��������������� ������ ����
// 21 	 ������. ��������������� ��������/�������� ����
// 22 	 ����. ��������������� ��������/�������� ����
// 23 	 ������. ��������������� ��������/�������� ����
// 24 	 ������. ��������������� �������������� �����

// 25 	 ��������������
// 26 	 ��������������, ������������ �� ��������������� ��������
// 27 	 �������������� �����������
// 28 	 ������������ ��������������
// 29 	 ����������� �������������� �����
// 30 	 ����������� �������� ����
// 31 	 ����������� �������� ����
// 32 	 ����������� �������� ����
// 33 	 ������������
// 34 	 ������������ "���"
// 35 	 ������������� ������������
// 36 	 ���������� ������������
// 37 	 ��� �����������
// 38 	 ��� �������� ����
// 39 	 ��� �������� ����
// 40 	 �������� �������� ����
// 41 	 �������� �������� ����
// 42 	 �������
// 43 	 ������������ �������������� ��������
// 44 	 �������������� �������� �������� ����
// 45 	 �������������� �������� �������� ����
// 46 	 �������������� �������� �������� ����
// 47 	 �������������� �������� �������������� �����
// 48 	 ������� �����
// 49 	 ����������
// 50 	 ����������
// 51 	 �������
// 52 	 ����
// 53 	 �������
// 54 	 �������
// 59 	 ������������, ��������� ���������� �������
// 60 	 ������������, ��������� ��������� �������



function mlmaCheckErr(aCode : Smallint) : Smallint;
begin
 Result := aCode;
 if aCode < 0 then
 case aCode of
  -1 : raise TLingException.Create('������������ ����� � ������� ���������� ����');
  -2 : raise TLingException.Create('������������ ����� � ������� ������');
  -3 : raise TLingException.Create('������������ ����� ��� �������������� ��������');
  -4 : raise TLingException.Create('������� ������� ����� ��� ������ ���������');
  -5 : raise TLingException.Create('�� ������� ����� �������� �������');
  -6 : raise TLingException.Create('�� ������� ��������� �������� �������');
 end;
end;

function L2llAddStrProc(Action: Pointer): TllAddStrProc; register;
asm
 jmp  l3LocalStub
end;{asm}

procedure FreellAddStrProc(var Stub: TllAddStrProc); register;
asm
 jmp  l3FreeLocalStub
end;{asm}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3LingLib.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3LingLib.pas initialization leave'); {$EndIf}
finalization
 if (gLingDLL <> 0) then FreeLibrary(gLingDLL);
end.
