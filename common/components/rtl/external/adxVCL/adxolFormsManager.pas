{*********************************************************************}
{*                                                                   *}
{*             Add-In Express Component Library                      *}
{*                Add-in Express 2010 for VCL                        *}
{*                                                                   *}
{*             Copyright (C) Add-in Express Ltd.                     *}
{*             ALL RIGHTS RESERVED                                   *}
{*                                                                   *}
{*   The entire contents of this file is protected by U.S. and       *}
{*   International Copyright Laws. Unauthorized reproduction,        *}
{*   reverse-engine\ering, and distribution of all or any portion of *}
{*   the code contained in this file is strictly prohibited and may  *}
{*   result in severe civil and criminal penalties and will be       *}
{*   prosecuted to the maximum extent possible under the law.        *}
{*                                                                   *}
{*   RESTRICTIONS                                                    *}
{*                                                                   *}
{*   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE       *}
{*   CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS    *}
{*   LTD.                                                            *}
{*   THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE              *}
{*   THE ADX Extensions VCL for Microsoft Outlook                    *}
{*   AND ALL ACCOMPANYING VCL COMPONENTS AS PART OF                  *}
{*   AN EXECUTABLE PROGRAM ONLY.                                     *}
{*                                                                   *}
{*   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      *}
{*   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        *}
{*   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       *}
{*   AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT          *}
{*   AND PERMISSION FROM ADD-IN EXPRESS LTD.                         *}
{*                                                                   *}
{*   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       *}
{*   ADDITIONAL RESTRICTIONS.                                        *}
{*                                                                   *}
{*********************************************************************}

unit adxolFormsManager;

{$I adxolDefs.inc}

//{$DEFINE WITHOUT_OUTLOOK_EVENTS}
//{$DEFINE WITHOUT_OUTLOOK_EVENTS1}

//{$DEFINE WEBVIEWOFF}
//{$DEFINE APIHIDE}

//{$DEFINE LOHICA}
{$DEFINE CLIENTLAYOUTS}
//{$DEFINE READINGPANEHEADER}
{$DEFINE DOCKEXPLORERLAYOUTS}
{$DEFINE SupportAdjacentWindow}
{$DEFINE SUBSTINSPECTORREGION}

interface

uses
  SysUtils, Classes, Dialogs, ComObj, Forms,
  {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  {$IFDEF ADX_VCL5}OleServer, FileCtrl,{$ENDIF}
  Windows, Messages, Graphics, Controls, TypInfo,
  Office2000, Outlook2000,
  adxAddin, adxWSbcls, adxCore,
  ActiveX, StdVCL, richedit
{$IFDEF EUREKALOG}
  , ExceptionLog
{$ENDIF}
  ;

///////////// Start ITextDocument section

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  tomMajorVersion = 1;
  tomMinorVersion = 0;

  LIBID_tom: TGUID = '{8CC497C9-A1DF-11CE-8098-00AA0047BE5D}';

  IID_ITextDocument: TGUID = '{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextRange: TGUID = '{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextSelection: TGUID = '{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextFont: TGUID = '{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextPara: TGUID = '{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextStoryRanges: TGUID = '{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}';
  IID_ITextDocument2: TGUID = '{01C25500-4268-11D1-883A-3C8B00C10000}';
  IID_ITextMsgFilter: TGUID = '{A3787420-4267-11D1-883A-3C8B00C10000}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_tom_0000_0001
type
  __MIDL___MIDL_itf_tom_0000_0001 = TOleEnum;
const
  tomFalse = $00000000;
  tomTrue = $FFFFFFFF;
  tomUndefined = $FF676981;
  tomToggle = $FF676982;
  tomAutoColor = $FF676983;
  tomDefault = $FF676984;
  tomSuspend = $FF676985;
  tomResume = $FF676986;
  tomApplyNow = $00000000;
  tomApplyLater = $00000001;
  tomTrackParms = $00000002;
  tomCacheParms = $00000003;
  tomApplyTmp = $00000004;
  tomBackward = $C0000001;
  tomForward = $3FFFFFFF;
  tomMove = $00000000;
  tomExtend = $00000001;
  tomNoSelection = $00000000;
  tomSelectionIP = $00000001;
  tomSelectionNormal = $00000002;
  tomSelectionFrame = $00000003;
  tomSelectionColumn = $00000004;
  tomSelectionRow = $00000005;
  tomSelectionBlock = $00000006;
  tomSelectionInlineShape = $00000007;
  tomSelectionShape = $00000008;
  tomSelStartActive = $00000001;
  tomSelAtEOL = $00000002;
  tomSelOvertype = $00000004;
  tomSelActive = $00000008;
  tomSelReplace = $00000010;
  tomEnd = $00000000;
  tomStart = $00000020;
  tomCollapseEnd = $00000000;
  tomCollapseStart = $00000001;
  tomClientCoord = $00000100;
  tomAllowOffClient = $00000200;
  tomNone = $00000000;
  tomSingle = $00000001;
  tomWords = $00000002;
  tomDouble = $00000003;
  tomDotted = $00000004;
  tomDash = $00000005;
  tomDashDot = $00000006;
  tomDashDotDot = $00000007;
  tomWave = $00000008;
  tomThick = $00000009;
  tomHair = $0000000A;
  tomDoubleWave = $0000000B;
  tomHeavyWave = $0000000C;
  tomLongDash = $0000000D;
  tomThickDash = $0000000E;
  tomThickDashDot = $0000000F;
  tomThickDashDotDot = $00000010;
  tomThickDotted = $00000011;
  tomThickLongDash = $00000012;
  tomLineSpaceSingle = $00000000;
  tomLineSpace1pt5 = $00000001;
  tomLineSpaceDouble = $00000002;
  tomLineSpaceAtLeast = $00000003;
  tomLineSpaceExactly = $00000004;
  tomLineSpaceMultiple = $00000005;
  tomAlignLeft = $00000000;
  tomAlignCenter = $00000001;
  tomAlignRight = $00000002;
  tomAlignJustify = $00000003;
  tomAlignDecimal = $00000003;
  tomAlignBar = $00000004;
  tomAlignInterWord = $00000003;
  tomAlignInterLetter = $00000004;
  tomAlignScaled = $00000005;
  tomAlignGlyphs = $00000006;
  tomAlignSnapGrid = $00000007;
  tomSpaces = $00000000;
  tomDots = $00000001;
  tomDashes = $00000002;
  tomLines = $00000003;
  tomThickLines = $00000004;
  tomEquals = $00000005;
  tomTabBack = $FFFFFFFD;
  tomTabNext = $FFFFFFFE;
  tomTabHere = $FFFFFFFF;
  tomListNone = $00000000;
  tomListBullet = $00000001;
  tomListNumberAsArabic = $00000002;
  tomListNumberAsLCLetter = $00000003;
  tomListNumberAsUCLetter = $00000004;
  tomListNumberAsLCRoman = $00000005;
  tomListNumberAsUCRoman = $00000006;
  tomListNumberAsSequence = $00000007;
  tomListParentheses = $00010000;
  tomListPeriod = $00020000;
  tomListPlain = $00030000;
  tomCharacter = $00000001;
  tomWord = $00000002;
  tomSentence = $00000003;
  tomParagraph = $00000004;
  tomLine = $00000005;
  tomStory = $00000006;
  tomScreen = $00000007;
  tomSection = $00000008;
  tomColumn = $00000009;
  tomRow = $0000000A;
  tomWindow = $0000000B;
  tomCell = $0000000C;
  tomCharFormat = $0000000D;
  tomParaFormat = $0000000E;
  tomTable = $0000000F;
  tomObject = $00000010;
  tomPage = $00000011;
  tomMatchWord = $00000002;
  tomMatchCase = $00000004;
  tomMatchPattern = $00000008;
  tomUnknownStory = $00000000;
  tomMainTextStory = $00000001;
  tomFootnotesStory = $00000002;
  tomEndnotesStory = $00000003;
  tomCommentsStory = $00000004;
  tomTextFrameStory = $00000005;
  tomEvenPagesHeaderStory = $00000006;
  tomPrimaryHeaderStory = $00000007;
  tomEvenPagesFooterStory = $00000008;
  tomPrimaryFooterStory = $00000009;
  tomFirstPageHeaderStory = $0000000A;
  tomFirstPageFooterStory = $0000000B;
  tomNoAnimation = $00000000;
  tomLasVegasLights = $00000001;
  tomBlinkingBackground = $00000002;
  tomSparkleText = $00000003;
  tomMarchingBlackAnts = $00000004;
  tomMarchingRedAnts = $00000005;
  tomShimmer = $00000006;
  tomWipeDown = $00000007;
  tomWipeRight = $00000008;
  tomAnimationMax = $00000008;
  tomLowerCase = $00000000;
  tomUpperCase = $00000001;
  tomTitleCase = $00000002;
  tomSentenceCase = $00000004;
  tomToggleCase = $00000005;
  tomReadOnly = $00000100;
  tomShareDenyRead = $00000200;
  tomShareDenyWrite = $00000400;
  tomPasteFile = $00001000;
  tomCreateNew = $00000010;
  tomCreateAlways = $00000020;
  tomOpenExisting = $00000030;
  tomOpenAlways = $00000040;
  tomTruncateExisting = $00000050;
  tomRTF = $00000001;
  tomText = $00000002;
  tomHTML = $00000003;
  tomWordDocument = $00000004;
  tomBold = $80000001;
  tomItalic = $80000002;
  tomUnderline = $80000004;
  tomStrikeout = $80000008;
  tomProtected = $80000010;
  tomLink = $80000020;
  tomSmallCaps = $80000040;
  tomAllCaps = $80000080;
  tomHidden = $80000100;
  tomOutline = $80000200;
  tomShadow = $80000400;
  tomEmboss = $80000800;
  tomImprint = $80001000;
  tomDisabled = $80002000;
  tomRevised = $80004000;
  tomNormalCaret = $00000000;
  tomKoreanBlockCaret = $00000001;
  tomIncludeInset = $00000001;
  tomIgnoreCurrentFont = $00000000;
  tomMatchFontCharset = $00000001;
  tomMatchFontSignature = $00000002;
  tomCharset = $80000000;
  tomRE10Mode = $00000001;
  tomUseAtFont = $00000002;
  tomTextFlowMask = $0000000C;
  tomTextFlowES = $00000000;
  tomTextFlowSW = $00000004;
  tomTextFlowWN = $00000008;
  tomTextFlowNE = $0000000C;
  tomUsePassword = $00000010;
  tomNoIME = $00080000;
  tomSelfIME = $00040000;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  ITextDocument = interface;
  ITextDocumentDisp = dispinterface;
  ITextRange = interface;
  ITextRangeDisp = dispinterface;
  ITextSelection = interface;
  ITextSelectionDisp = dispinterface;
  ITextFont = interface;
  ITextFontDisp = dispinterface;
  ITextPara = interface;
  ITextParaDisp = dispinterface;
  ITextStoryRanges = interface;
  ITextStoryRangesDisp = dispinterface;
  ITextDocument2 = interface;
  ITextDocument2Disp = dispinterface;
  ITextMsgFilter = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  wireHWND = ^_RemotableHandle;
  POleVariant1 = ^OleVariant; {*}
  PInteger1 = ^Integer; {*}

  tomConstants = __MIDL___MIDL_itf_tom_0000_0001;

  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = packed record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;


// *********************************************************************//
// Interface: ITextDocument
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextDocument = interface(IDispatch)
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Name: WideString; safecall;
    function Get_Selection: ITextSelection; safecall;
    function Get_StoryCount: Integer; safecall;
    function Get_StoryRanges: ITextStoryRanges; safecall;
    function Get_Saved: Integer; safecall;
    procedure Set_Saved(pValue: Integer); safecall;
    function Get_DefaultTabStop: Single; safecall;
    procedure Set_DefaultTabStop(pValue: Single); safecall;
    procedure New; safecall;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); safecall;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); safecall;
    function Freeze: Integer; safecall;
    function Unfreeze: Integer; safecall;
    procedure BeginEditCollection; safecall;
    procedure EndEditCollection; safecall;
    function Undo(Count: Integer): Integer; safecall;
    function Redo(Count: Integer): Integer; safecall;
    function Range(cp1: Integer; cp2: Integer): ITextRange; safecall;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; safecall;
    property Name: WideString read Get_Name;
    property Selection: ITextSelection read Get_Selection;
    property StoryCount: Integer read Get_StoryCount;
    property StoryRanges: ITextStoryRanges read Get_StoryRanges;
    property Saved: Integer read Get_Saved write Set_Saved;
    property DefaultTabStop: Single read Get_DefaultTabStop write Set_DefaultTabStop;
  end;

// *********************************************************************//
// DispIntf:  ITextDocumentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C0-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextDocumentDisp = dispinterface
    ['{8CC497C0-A1DF-11CE-8098-00AA0047BE5D}']
    property Name: WideString readonly dispid 0;
    property Selection: ITextSelection readonly dispid 1;
    property StoryCount: Integer readonly dispid 2;
    property StoryRanges: ITextStoryRanges readonly dispid 3;
    property Saved: Integer dispid 4;
    property DefaultTabStop: Single dispid 5;
    procedure New; dispid 6;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 7;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 8;
    function Freeze: Integer; dispid 9;
    function Unfreeze: Integer; dispid 10;
    procedure BeginEditCollection; dispid 11;
    procedure EndEditCollection; dispid 12;
    function Undo(Count: Integer): Integer; dispid 13;
    function Redo(Count: Integer): Integer; dispid 14;
    function Range(cp1: Integer; cp2: Integer): ITextRange; dispid 15;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; dispid 16;
  end;

// *********************************************************************//
// Interface: ITextRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextRange = interface(IDispatch)
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Text: WideString; safecall;
    procedure Set_Text(const pbstr: WideString); safecall;
    function Get_Char: Integer; safecall;
    procedure Set_Char(pch: Integer); safecall;
    function Get_Duplicate: ITextRange; safecall;
    function Get_FormattedText: ITextRange; safecall;
    procedure Set_FormattedText(const ppRange: ITextRange); safecall;
    function Get_Start: Integer; safecall;
    procedure Set_Start(pcpFirst: Integer); safecall;
    function Get_End_: Integer; safecall;
    procedure Set_End_(pcpLim: Integer); safecall;
    function Get_Font: ITextFont; safecall;
    procedure Set_Font(const pFont: ITextFont); safecall;
    function Get_Para: ITextPara; safecall;
    procedure Set_Para(const pPara: ITextPara); safecall;
    function Get_StoryLength: Integer; safecall;
    function Get_StoryType: Integer; safecall;
    procedure Collapse(bStart: Integer); safecall;
    function Expand(Unit_: Integer): Integer; safecall;
    function GetIndex(Unit_: Integer): Integer; safecall;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); safecall;
    procedure SetRange(cpActive: Integer; cpOther: Integer); safecall;
    function InRange(const pRange: ITextRange): Integer; safecall;
    function InStory(const pRange: ITextRange): Integer; safecall;
    function IsEqual(const pRange: ITextRange): Integer; safecall;
    procedure Select; safecall;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; safecall;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; safecall;
    function Move(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; safecall;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; safecall;
    function FindText(const bstr: WideString; cch: Integer; Flags: Integer): Integer; safecall;
    function FindTextStart(const bstr: WideString; cch: Integer; Flags: Integer): Integer; safecall;
    function FindTextEnd(const bstr: WideString; cch: Integer; Flags: Integer): Integer; safecall;
    function Delete(Unit_: Integer; Count: Integer): Integer; safecall;
    procedure Cut(out pVar: OleVariant); safecall;
    procedure Copy(out pVar: OleVariant); safecall;
    procedure Paste(var pVar: OleVariant; Format: Integer); safecall;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; safecall;
    function CanEdit: Integer; safecall;
    procedure ChangeCase(Type_: Integer); safecall;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); safecall;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); safecall;
    procedure ScrollIntoView(Value: Integer); safecall;
    function GetEmbeddedObject: IUnknown; safecall;
    property Text: WideString read Get_Text write Set_Text;
    property Char: Integer read Get_Char write Set_Char;
    property Duplicate: ITextRange read Get_Duplicate;
    property FormattedText: ITextRange read Get_FormattedText write Set_FormattedText;
    property Start: Integer read Get_Start write Set_Start;
    property End_: Integer read Get_End_ write Set_End_;
    property Font: ITextFont read Get_Font write Set_Font;
    property Para: ITextPara read Get_Para write Set_Para;
    property StoryLength: Integer read Get_StoryLength;
    property StoryType: Integer read Get_StoryType;
  end;

// *********************************************************************//
// DispIntf:  ITextRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C2-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextRangeDisp = dispinterface
    ['{8CC497C2-A1DF-11CE-8098-00AA0047BE5D}']
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpActive: Integer; cpOther: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextSelection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextSelection = interface(ITextRange)
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Flags: Integer; safecall;
    procedure Set_Flags(pFlags: Integer); safecall;
    function Get_type_: Integer; safecall;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; safecall;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; safecall;
    procedure TypeText(const bstr: WideString); safecall;
    property Flags: Integer read Get_Flags write Set_Flags;
    property type_: Integer read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  ITextSelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C1-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextSelectionDisp = dispinterface
    ['{8CC497C1-A1DF-11CE-8098-00AA0047BE5D}']
    property Flags: Integer dispid 257;
    property type_: Integer readonly dispid 258;
    function MoveLeft(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 259;
    function MoveRight(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 260;
    function MoveUp(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 261;
    function MoveDown(Unit_: Integer; Count: Integer; Extend: Integer): Integer; dispid 262;
    function HomeKey(Unit_: Integer; Extend: Integer): Integer; dispid 263;
    function EndKey(Unit_: Integer; Extend: Integer): Integer; dispid 264;
    procedure TypeText(const bstr: WideString); dispid 265;
    property Text: WideString dispid 0;
    property Char: Integer dispid 513;
    property Duplicate: ITextRange readonly dispid 514;
    property FormattedText: ITextRange dispid 515;
    property Start: Integer dispid 516;
    property End_: Integer dispid 517;
    property Font: ITextFont dispid 518;
    property Para: ITextPara dispid 519;
    property StoryLength: Integer readonly dispid 520;
    property StoryType: Integer readonly dispid 521;
    procedure Collapse(bStart: Integer); dispid 528;
    function Expand(Unit_: Integer): Integer; dispid 529;
    function GetIndex(Unit_: Integer): Integer; dispid 530;
    procedure SetIndex(Unit_: Integer; Index: Integer; Extend: Integer); dispid 531;
    procedure SetRange(cpActive: Integer; cpOther: Integer); dispid 532;
    function InRange(const pRange: ITextRange): Integer; dispid 533;
    function InStory(const pRange: ITextRange): Integer; dispid 534;
    function IsEqual(const pRange: ITextRange): Integer; dispid 535;
    procedure Select; dispid 536;
    function StartOf(Unit_: Integer; Extend: Integer): Integer; dispid 537;
    function EndOf(Unit_: Integer; Extend: Integer): Integer; dispid 544;
    function Move(Unit_: Integer; Count: Integer): Integer; dispid 545;
    function MoveStart(Unit_: Integer; Count: Integer): Integer; dispid 546;
    function MoveEnd(Unit_: Integer; Count: Integer): Integer; dispid 547;
    function MoveWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 548;
    function MoveStartWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 549;
    function MoveEndWhile(var Cset: OleVariant; Count: Integer): Integer; dispid 550;
    function MoveUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 551;
    function MoveStartUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 552;
    function MoveEndUntil(var Cset: OleVariant; Count: Integer): Integer; dispid 553;
    function FindText(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 560;
    function FindTextStart(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 561;
    function FindTextEnd(const bstr: WideString; cch: Integer; Flags: Integer): Integer; dispid 562;
    function Delete(Unit_: Integer; Count: Integer): Integer; dispid 563;
    procedure Cut(out pVar: OleVariant); dispid 564;
    procedure Copy(out pVar: OleVariant); dispid 565;
    procedure Paste(var pVar: OleVariant; Format: Integer); dispid 566;
    function CanPaste(var pVar: OleVariant; Format: Integer): Integer; dispid 567;
    function CanEdit: Integer; dispid 568;
    procedure ChangeCase(Type_: Integer); dispid 569;
    procedure GetPoint(Type_: Integer; out px: Integer; out py: Integer); dispid 576;
    procedure SetPoint(x: Integer; y: Integer; Type_: Integer; Extend: Integer); dispid 577;
    procedure ScrollIntoView(Value: Integer); dispid 578;
    function GetEmbeddedObject: IUnknown; dispid 579;
  end;

// *********************************************************************//
// Interface: ITextFont
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextFont = interface(IDispatch)
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Duplicate: ITextFont; safecall;
    procedure Set_Duplicate(const ppFont: ITextFont); safecall;
    function CanChange: Integer; safecall;
    function IsEqual(const pFont: ITextFont): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function Get_AllCaps: Integer; safecall;
    procedure Set_AllCaps(pValue: Integer); safecall;
    function Get_Animation: Integer; safecall;
    procedure Set_Animation(pValue: Integer); safecall;
    function Get_BackColor: Integer; safecall;
    procedure Set_BackColor(pValue: Integer); safecall;
    function Get_Bold: Integer; safecall;
    procedure Set_Bold(pValue: Integer); safecall;
    function Get_Emboss: Integer; safecall;
    procedure Set_Emboss(pValue: Integer); safecall;
    function Get_ForeColor: Integer; safecall;
    procedure Set_ForeColor(pValue: Integer); safecall;
    function Get_Hidden: Integer; safecall;
    procedure Set_Hidden(pValue: Integer); safecall;
    function Get_Engrave: Integer; safecall;
    procedure Set_Engrave(pValue: Integer); safecall;
    function Get_Italic: Integer; safecall;
    procedure Set_Italic(pValue: Integer); safecall;
    function Get_Kerning: Single; safecall;
    procedure Set_Kerning(pValue: Single); safecall;
    function Get_LanguageID: Integer; safecall;
    procedure Set_LanguageID(pValue: Integer); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const pbstr: WideString); safecall;
    function Get_Outline: Integer; safecall;
    procedure Set_Outline(pValue: Integer); safecall;
    function Get_Position: Single; safecall;
    procedure Set_Position(pValue: Single); safecall;
    function Get_Protected_: Integer; safecall;
    procedure Set_Protected_(pValue: Integer); safecall;
    function Get_Shadow: Integer; safecall;
    procedure Set_Shadow(pValue: Integer); safecall;
    function Get_Size: Single; safecall;
    procedure Set_Size(pValue: Single); safecall;
    function Get_SmallCaps: Integer; safecall;
    procedure Set_SmallCaps(pValue: Integer); safecall;
    function Get_Spacing: Single; safecall;
    procedure Set_Spacing(pValue: Single); safecall;
    function Get_StrikeThrough: Integer; safecall;
    procedure Set_StrikeThrough(pValue: Integer); safecall;
    function Get_Subscript: Integer; safecall;
    procedure Set_Subscript(pValue: Integer); safecall;
    function Get_Superscript: Integer; safecall;
    procedure Set_Superscript(pValue: Integer); safecall;
    function Get_Underline: Integer; safecall;
    procedure Set_Underline(pValue: Integer); safecall;
    function Get_Weight: Integer; safecall;
    procedure Set_Weight(pValue: Integer); safecall;
    property Duplicate: ITextFont read Get_Duplicate write Set_Duplicate;
    property Style: Integer read Get_Style write Set_Style;
    property AllCaps: Integer read Get_AllCaps write Set_AllCaps;
    property Animation: Integer read Get_Animation write Set_Animation;
    property BackColor: Integer read Get_BackColor write Set_BackColor;
    property Bold: Integer read Get_Bold write Set_Bold;
    property Emboss: Integer read Get_Emboss write Set_Emboss;
    property ForeColor: Integer read Get_ForeColor write Set_ForeColor;
    property Hidden: Integer read Get_Hidden write Set_Hidden;
    property Engrave: Integer read Get_Engrave write Set_Engrave;
    property Italic: Integer read Get_Italic write Set_Italic;
    property Kerning: Single read Get_Kerning write Set_Kerning;
    property LanguageID: Integer read Get_LanguageID write Set_LanguageID;
    property Name: WideString read Get_Name write Set_Name;
    property Outline: Integer read Get_Outline write Set_Outline;
    property Position: Single read Get_Position write Set_Position;
    property Protected_: Integer read Get_Protected_ write Set_Protected_;
    property Shadow: Integer read Get_Shadow write Set_Shadow;
    property Size: Single read Get_Size write Set_Size;
    property SmallCaps: Integer read Get_SmallCaps write Set_SmallCaps;
    property Spacing: Single read Get_Spacing write Set_Spacing;
    property StrikeThrough: Integer read Get_StrikeThrough write Set_StrikeThrough;
    property Subscript: Integer read Get_Subscript write Set_Subscript;
    property Superscript: Integer read Get_Superscript write Set_Superscript;
    property Underline: Integer read Get_Underline write Set_Underline;
    property Weight: Integer read Get_Weight write Set_Weight;
  end;

// *********************************************************************//
// DispIntf:  ITextFontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C3-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextFontDisp = dispinterface
    ['{8CC497C3-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextFont dispid 0;
    function CanChange: Integer; dispid 769;
    function IsEqual(const pFont: ITextFont): Integer; dispid 770;
    procedure Reset(Value: Integer); dispid 771;
    property Style: Integer dispid 772;
    property AllCaps: Integer dispid 773;
    property Animation: Integer dispid 774;
    property BackColor: Integer dispid 775;
    property Bold: Integer dispid 776;
    property Emboss: Integer dispid 777;
    property ForeColor: Integer dispid 784;
    property Hidden: Integer dispid 785;
    property Engrave: Integer dispid 786;
    property Italic: Integer dispid 787;
    property Kerning: Single dispid 788;
    property LanguageID: Integer dispid 789;
    property Name: WideString dispid 790;
    property Outline: Integer dispid 791;
    property Position: Single dispid 792;
    property Protected_: Integer dispid 793;
    property Shadow: Integer dispid 800;
    property Size: Single dispid 801;
    property SmallCaps: Integer dispid 802;
    property Spacing: Single dispid 803;
    property StrikeThrough: Integer dispid 804;
    property Subscript: Integer dispid 805;
    property Superscript: Integer dispid 806;
    property Underline: Integer dispid 807;
    property Weight: Integer dispid 808;
  end;

// *********************************************************************//
// Interface: ITextPara
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextPara = interface(IDispatch)
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']
    function Get_Duplicate: ITextPara; safecall;
    procedure Set_Duplicate(const ppPara: ITextPara); safecall;
    function CanChange: Integer; safecall;
    function IsEqual(const pPara: ITextPara): Integer; safecall;
    procedure Reset(Value: Integer); safecall;
    function Get_Style: Integer; safecall;
    procedure Set_Style(pValue: Integer); safecall;
    function Get_Alignment: Integer; safecall;
    procedure Set_Alignment(pValue: Integer); safecall;
    function Get_Hyphenation: Integer; safecall;
    procedure Set_Hyphenation(pValue: Integer); safecall;
    function Get_FirstLineIndent: Single; safecall;
    function Get_KeepTogether: Integer; safecall;
    procedure Set_KeepTogether(pValue: Integer); safecall;
    function Get_KeepWithNext: Integer; safecall;
    procedure Set_KeepWithNext(pValue: Integer); safecall;
    function Get_LeftIndent: Single; safecall;
    function Get_LineSpacing: Single; safecall;
    function Get_LineSpacingRule: Integer; safecall;
    function Get_ListAlignment: Integer; safecall;
    procedure Set_ListAlignment(pValue: Integer); safecall;
    function Get_ListLevelIndex: Integer; safecall;
    procedure Set_ListLevelIndex(pValue: Integer); safecall;
    function Get_ListStart: Integer; safecall;
    procedure Set_ListStart(pValue: Integer); safecall;
    function Get_ListTab: Single; safecall;
    procedure Set_ListTab(pValue: Single); safecall;
    function Get_ListType: Integer; safecall;
    procedure Set_ListType(pValue: Integer); safecall;
    function Get_NoLineNumber: Integer; safecall;
    procedure Set_NoLineNumber(pValue: Integer); safecall;
    function Get_PageBreakBefore: Integer; safecall;
    procedure Set_PageBreakBefore(pValue: Integer); safecall;
    function Get_RightIndent: Single; safecall;
    procedure Set_RightIndent(pValue: Single); safecall;
    procedure SetIndents(StartIndent: Single; LeftIndent: Single; RightIndent: Single); safecall;
    procedure SetLineSpacing(LineSpacingRule: Integer; LineSpacing: Single); safecall;
    function Get_SpaceAfter: Single; safecall;
    procedure Set_SpaceAfter(pValue: Single); safecall;
    function Get_SpaceBefore: Single; safecall;
    procedure Set_SpaceBefore(pValue: Single); safecall;
    function Get_WidowControl: Integer; safecall;
    procedure Set_WidowControl(pValue: Integer); safecall;
    function Get_TabCount: Integer; safecall;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); safecall;
    procedure ClearAllTabs; safecall;
    procedure DeleteTab(tbPos: Single); safecall;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer;
                     out ptbLeader: Integer); safecall;
    property Duplicate: ITextPara read Get_Duplicate write Set_Duplicate;
    property Style: Integer read Get_Style write Set_Style;
    property Alignment: Integer read Get_Alignment write Set_Alignment;
    property Hyphenation: Integer read Get_Hyphenation write Set_Hyphenation;
    property FirstLineIndent: Single read Get_FirstLineIndent;
    property KeepTogether: Integer read Get_KeepTogether write Set_KeepTogether;
    property KeepWithNext: Integer read Get_KeepWithNext write Set_KeepWithNext;
    property LeftIndent: Single read Get_LeftIndent;
    property LineSpacing: Single read Get_LineSpacing;
    property LineSpacingRule: Integer read Get_LineSpacingRule;
    property ListAlignment: Integer read Get_ListAlignment write Set_ListAlignment;
    property ListLevelIndex: Integer read Get_ListLevelIndex write Set_ListLevelIndex;
    property ListStart: Integer read Get_ListStart write Set_ListStart;
    property ListTab: Single read Get_ListTab write Set_ListTab;
    property ListType: Integer read Get_ListType write Set_ListType;
    property NoLineNumber: Integer read Get_NoLineNumber write Set_NoLineNumber;
    property PageBreakBefore: Integer read Get_PageBreakBefore write Set_PageBreakBefore;
    property RightIndent: Single read Get_RightIndent write Set_RightIndent;
    property SpaceAfter: Single read Get_SpaceAfter write Set_SpaceAfter;
    property SpaceBefore: Single read Get_SpaceBefore write Set_SpaceBefore;
    property WidowControl: Integer read Get_WidowControl write Set_WidowControl;
    property TabCount: Integer read Get_TabCount;
  end;

// *********************************************************************//
// DispIntf:  ITextParaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C4-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextParaDisp = dispinterface
    ['{8CC497C4-A1DF-11CE-8098-00AA0047BE5D}']
    property Duplicate: ITextPara dispid 0;
    function CanChange: Integer; dispid 1025;
    function IsEqual(const pPara: ITextPara): Integer; dispid 1026;
    procedure Reset(Value: Integer); dispid 1027;
    property Style: Integer dispid 1028;
    property Alignment: Integer dispid 1029;
    property Hyphenation: Integer dispid 1030;
    property FirstLineIndent: Single readonly dispid 1031;
    property KeepTogether: Integer dispid 1032;
    property KeepWithNext: Integer dispid 1033;
    property LeftIndent: Single readonly dispid 1040;
    property LineSpacing: Single readonly dispid 1041;
    property LineSpacingRule: Integer readonly dispid 1042;
    property ListAlignment: Integer dispid 1043;
    property ListLevelIndex: Integer dispid 1044;
    property ListStart: Integer dispid 1045;
    property ListTab: Single dispid 1046;
    property ListType: Integer dispid 1047;
    property NoLineNumber: Integer dispid 1048;
    property PageBreakBefore: Integer dispid 1049;
    property RightIndent: Single dispid 1056;
    procedure SetIndents(StartIndent: Single; LeftIndent: Single; RightIndent: Single); dispid 1057;
    procedure SetLineSpacing(LineSpacingRule: Integer; LineSpacing: Single); dispid 1058;
    property SpaceAfter: Single dispid 1059;
    property SpaceBefore: Single dispid 1060;
    property WidowControl: Integer dispid 1061;
    property TabCount: Integer readonly dispid 1062;
    procedure AddTab(tbPos: Single; tbAlign: Integer; tbLeader: Integer); dispid 1063;
    procedure ClearAllTabs; dispid 1064;
    procedure DeleteTab(tbPos: Single); dispid 1065;
    procedure GetTab(iTab: Integer; out ptbPos: Single; out ptbAlign: Integer;
                     out ptbLeader: Integer); dispid 1072;
  end;

// *********************************************************************//
// Interface: ITextStoryRanges
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextStoryRanges = interface(IDispatch)
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']
    function _NewEnum: IUnknown; safecall;
    function Item(Index: Integer): ITextRange; safecall;
    function Get_Count: Integer; safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ITextStoryRangesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8CC497C5-A1DF-11CE-8098-00AA0047BE5D}
// *********************************************************************//
  ITextStoryRangesDisp = dispinterface
    ['{8CC497C5-A1DF-11CE-8098-00AA0047BE5D}']
    function _NewEnum: IUnknown; dispid -4;
    function Item(Index: Integer): ITextRange; dispid 0;
    property Count: Integer readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ITextDocument2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {01C25500-4268-11D1-883A-3C8B00C10000}
// *********************************************************************//
  ITextDocument2 = interface(ITextDocument)
    ['{01C25500-4268-11D1-883A-3C8B00C10000}']
    procedure AttachMsgFilter(const pFilter: IUnknown); safecall;
    procedure SetEffectColor(Index: Integer; cr: LongWord); safecall;
    procedure GetEffectColor(Index: Integer; out pcr: LongWord); safecall;
    function Get_CaretType: Integer; safecall;
    procedure Set_CaretType(pCaretType: Integer); safecall;
    function GetImmContext: Integer; safecall;
    procedure ReleaseImmContext(Context: Integer); safecall;
    procedure GetPreferredFont(cp: Integer; CodePage: Integer; Option: Integer;
                               curCodepage: Integer; curFontSize: Integer; out pbstr: WideString;
                               out pPitchAndFamily: Integer; out pNewFontSize: Integer); safecall;
    function Get_NotificationMode: Integer; safecall;
    procedure Set_NotificationMode(pMode: Integer); safecall;
    procedure GetClientRect(Type_: Integer; out pLeft: Integer; out pTop: Integer;
                            out pRight: Integer; out pBottom: Integer); safecall;
    function Get_SelectionEx: ITextSelection; safecall;
    procedure GetWindow(out phWnd: Integer); safecall;
    procedure GetFEFlags(out pFlags: Integer); safecall;
    procedure UpdateWindow; safecall;
    procedure CheckTextLimit(cch: Integer; var pcch: Integer); safecall;
    procedure IMEInProgress(Mode: Integer); safecall;
    procedure SysBeep; safecall;
    procedure Update(Mode: Integer); safecall;
    procedure Notify(Notify: Integer); safecall;
    function GetDocumentFont: ITextFont; safecall;
    function GetDocumentPara: ITextPara; safecall;
    function GetCallManager: IUnknown; safecall;
    procedure ReleaseCallManager(const pVoid: IUnknown); safecall;
    property CaretType: Integer read Get_CaretType write Set_CaretType;
    property NotificationMode: Integer read Get_NotificationMode write Set_NotificationMode;
    property SelectionEx: ITextSelection read Get_SelectionEx;
  end;

// *********************************************************************//
// DispIntf:  ITextDocument2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {01C25500-4268-11D1-883A-3C8B00C10000}
// *********************************************************************//
  ITextDocument2Disp = dispinterface
    ['{01C25500-4268-11D1-883A-3C8B00C10000}']
    procedure AttachMsgFilter(const pFilter: IUnknown); dispid 21;
    procedure SetEffectColor(Index: Integer; cr: LongWord); dispid 22;
    procedure GetEffectColor(Index: Integer; out pcr: LongWord); dispid 23;
    property CaretType: Integer dispid 24;
    function GetImmContext: Integer; dispid 25;
    procedure ReleaseImmContext(Context: Integer); dispid 26;
    procedure GetPreferredFont(cp: Integer; CodePage: Integer; Option: Integer;
                               curCodepage: Integer; curFontSize: Integer; out pbstr: WideString;
                               out pPitchAndFamily: Integer; out pNewFontSize: Integer); dispid 27;
    property NotificationMode: Integer dispid 28;
    procedure GetClientRect(Type_: Integer; out pLeft: Integer; out pTop: Integer;
                            out pRight: Integer; out pBottom: Integer); dispid 29;
    property SelectionEx: ITextSelection readonly dispid 30;
    procedure GetWindow(out phWnd: Integer); dispid 31;
    procedure GetFEFlags(out pFlags: Integer); dispid 32;
    procedure UpdateWindow; dispid 33;
    procedure CheckTextLimit(cch: Integer; var pcch: Integer); dispid 34;
    procedure IMEInProgress(Mode: Integer); dispid 35;
    procedure SysBeep; dispid 36;
    procedure Update(Mode: Integer); dispid 37;
    procedure Notify(Notify: Integer); dispid 38;
    function GetDocumentFont: ITextFont; dispid 39;
    function GetDocumentPara: ITextPara; dispid 40;
    function GetCallManager: IUnknown; dispid 41;
    procedure ReleaseCallManager(const pVoid: IUnknown); dispid 42;
    property Name: WideString readonly dispid 0;
    property Selection: ITextSelection readonly dispid 1;
    property StoryCount: Integer readonly dispid 2;
    property StoryRanges: ITextStoryRanges readonly dispid 3;
    property Saved: Integer dispid 4;
    property DefaultTabStop: Single dispid 5;
    procedure New; dispid 6;
    procedure Open(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 7;
    procedure Save(var pVar: OleVariant; Flags: Integer; CodePage: Integer); dispid 8;
    function Freeze: Integer; dispid 9;
    function Unfreeze: Integer; dispid 10;
    procedure BeginEditCollection; dispid 11;
    procedure EndEditCollection; dispid 12;
    function Undo(Count: Integer): Integer; dispid 13;
    function Redo(Count: Integer): Integer; dispid 14;
    function Range(cp1: Integer; cp2: Integer): ITextRange; dispid 15;
    function RangeFromPoint(x: Integer; y: Integer): ITextRange; dispid 16;
  end;

// *********************************************************************//
// Interface: ITextMsgFilter
// Flags:     (128) NonExtensible
// GUID:      {A3787420-4267-11D1-883A-3C8B00C10000}
// *********************************************************************//
  ITextMsgFilter = interface(IUnknown)
    ['{A3787420-4267-11D1-883A-3C8B00C10000}']
    function AttachDocument(var hwnd: _RemotableHandle; const pTextDoc: ITextDocument2;
                            const punk: IUnknown): HResult; stdcall;
    function HandleMessage(var pmsg: SYSUINT; var pwparam: SYSUINT; var plparam: Integer;
                           out plres: Integer): HResult; stdcall;
    function AttachMsgFilter(const pMsgFilter: ITextMsgFilter): HResult; stdcall;
  end;

///////////// End ITextDocument section

type


  TadxolOutlookVersion = integer;

  TadxolSplitterBehavior = (
    sbNone,
    sbStandard
  );

  TadxolExplorerLayout = (
    elUnknown,
    elTopSubpane,
    elBottomSubpane,
    elRightSubpane,
    elWebViewPane,
    elLeftSubpane,
    elBottomOutlookBar, //2000, 2002
    elBottomNavigationPane, //2003, 2007 - NavigationPane //2002, 2000 - FolderList
    elBottomTodoBar, //2007
		elTopReadingPane,
		elBottomReadingPane,
		elLeftReadingPane,
		elRightReadingPane
{$IFDEF CLIENTLAYOUTS}
    ,elReadingPane
    ,elFolderView
{$ENDIF}
{$IFDEF READINGPANEHEADER}
    ,elReadingPaneHeader
{$ENDIF}
{$IFDEF DOCKEXPLORERLAYOUTS}
    ,elDockTop
    ,elDockBottom
    ,elDockRight
    ,elDockLeft
{$ENDIF}
  );

  TadxolExplorerAllowedDropRegion = (
    erTopSubpane,
    erBottomSubpane,
    erRightSubpane,
    erLeftSubpane,
    erBottomOutlookBar,
    erBottomNavigationPane,
    erBottomTodoBar,
		erTopReadingPane,
		erBottomReadingPane,
		erLeftReadingPane,
		erRightReadingPane,
    erReadingPane,
    erFolderView
{$IFDEF DOCKEXPLORERLAYOUTS}
    ,erDockTop
    ,erDockBottom
    ,erDockRight
    ,erDockLeft
{$ENDIF}
  );

  TadxolExplorerAllowedDropRegions = set of TadxolExplorerAllowedDropRegion;

  TadxolExplorerItemType = (
    expMailItem,
    expAppointmentItem,
    expContactItem,
    expTaskItem,
    expJournalItem,
    expNoteItem,
    expPostItem,
    expDistributionListItem
  );

  TadxolExplorerItemTypes = set of TadxolExplorerItemType;

  TadxolCachingStrategy = (
    csNone,
    csNewInstanceForEachFolder,
    csOneInstanceForAllFolders
  );

  TadxolInspectorLayout = (
    ilUnknown,
    ilBottomSubpane,
    ilRightSubpane,
    ilLeftSubpane,
    ilTopSubpane
{$IFDEF CLIENTLAYOUTS}
    ,ilInspectorRegion
{$ENDIF}
{$IFDEF SUBSTINSPECTORREGION}
    ,ilCompleteReplacement
{$ENDIF}
  );

  TadxolInspectorItemType =
  (
    insRecipient,
    insAppointment,
    insMeetingRequest,
    insMeetingCancellation,
    insMeetingResponseNegative,
    insMeetingResponsePositive,
    insMeetingResponseTentative,
    insContact,
    insJournal,
    insMail,
    insPost,
    insTask,
    insTaskRequest,
    insTaskRequestUpdate,
    insTaskRequestAccept,
    insTaskRequestDecline,
    insDistributionList,
    insReport,
    insSharing,
    insMobile
  );

  TadxolInspectorItemTypes = set of TadxolInspectorItemType;

  TadxolInspectorAllowedDropRegion =
  (
    irBottomSubpane,
    irRightSubpane,
    irLeftSubpane,
    irTopSubpane,
    irInspectorRegion
  );

  TadxolInspectorAllowedDropRegions = set of TadxolInspectorAllowedDropRegion;


  TadxolInspectorMode =
  (
    imRead,
    imCompose
  );

  TadxolInspectorModes = set of TadxolInspectorMode;

const
  AllInspectorItemTypes =
    [insRecipient,
    insAppointment,
    insMeetingRequest,
    insMeetingCancellation,
    insMeetingResponseNegative,
    insMeetingResponsePositive,
    insMeetingResponseTentative,
    insContact,
    insJournal,
    insMail,
    insPost,
    insTask,
    insTaskRequest,
    insTaskRequestUpdate,
    insTaskRequestAccept,
    insTaskRequestDecline,
    insDistributionList,
    insReport,
    insSharing,
    insMobile];

type
{$IFDEF ADX_VCL5}
  TadxKeyFilterAction = integer;
const
  faSendToHostApplication = $03;
  faSendToAdxForm = $30;
{$ELSE}
  TadxKeyFilterAction = (faSendToHostApplication = $03, faSendToAdxForm = $30);
{$ENDIF}

type

  TadxOlFormsCollectionItem = class;

  TadxOlReadingPaneLayout = (rplRight, rplBottom, rplOff);

  TadxEmbeddedFormStates = (efsActive, efsVisible);


  TadxOlErrorEventArgs = class
  private
    FE: SysUtils.Exception;
    FHandled: boolean;
    procedure SetHandled(const Value: boolean);
  public
    constructor Create(AE: SysUtils.Exception);
    destructor Destroy; override;
    property E: SysUtils.Exception read FE;
    property Handled: boolean read FHandled write SetHandled;
  end;

  TadxOlCloseButtonClickEventArgs = class
  private
    FCloseForm: boolean;
    FDisableItem: boolean;
    procedure SetCloseForm(const Value: boolean);
    procedure SetDisableItem(const Value: boolean);
  public
    constructor Create;
    property CloseForm: boolean read FCloseForm write SetCloseForm;
    property DisableItem: boolean read FDisableItem write SetDisableItem;
  end;

  TadxOlKeyFilterEventArgs = class
  private
    FAdxKeyInfo: TadxKeyInfo;
    FAction: TadxKeyFilterAction;
    function GetKeyCode: byte;
    function GetKeyValue: Cardinal;
    function GetPressed: boolean;
    function GetShiftState: TShiftState;
  public
    constructor Create(AAdxKeyInfo: TadxKeyInfo);
    destructor Destroy; override;
    property ShiftState: TShiftState read GetShiftState;
    property Pressed: boolean read GetPressed;
    property KeyCode: byte read GetKeyCode;
    property KeyValue: Cardinal read GetKeyValue;
    property Action: TadxKeyFilterAction read FAction write FAction;
  end;

  TadxOlKeyFilterEventHandler = procedure(ASender: TObject; Args: TadxOlKeyFilterEventArgs) of object;

  TadxOlCloseButtonClickEventHandler = procedure(Sender: TObject; Args: TadxOlCloseButtonClickEventArgs) of object;

  TadxOlEnterEventArgs = class
  end;

  TadxOlExitEventArgs = class
  end;

  TadxOlAfterFormHideEventArgs = class
  end;

  TadxOlFormFolderSwitchEventArgs = class
  end;

  TadxOlFormInspectorActivateEventArgs = class
  end;

  TadxOlFormNewInspectorEventArgs = class
  end;

  TadxOlFormEnterEventHandler = procedure(Sender: TObject; Args: TadxOlEnterEventArgs) of object;
  TadxOlFormExitEventHandler = procedure(Sender: TObject; Args: TadxOlExitEventArgs) of object;
  TadxOlFormAfterFormHideEventHandler = procedure(Sender: TObject; Args: TadxOlAfterFormHideEventArgs) of object;
  TadxOlFormFolderSwitchEventHandler = procedure(Sender: TObject; Args: TadxOlFormFolderSwitchEventArgs) of object;
  TadxOlFormInspectorActivateEventHandler = procedure(Sender: TObject; Args: TadxOlFormInspectorActivateEventArgs) of object;
  TadxOlFormNewInspectorEventHandler = procedure(Sender: TObject; Args: TadxOlFormNewInspectorEventArgs) of object;


  TadxOlPostMessageReceivedEventArgs = class
  private
    FwParam: Cardinal;
    FlParam: Cardinal;
  public
    constructor Create(AwParam, AlParam: Cardinal);
    property wParam: Cardinal read FwParam;
    property lParam: Cardinal read FlParam;
  end;

  TadxOlPostMessageReceivedEventHandler = procedure(Args: TadxOlPostMessageReceivedEventArgs) of object;

  TadxOlReadingPaneMoveEventArgs = class
  private
    FReadingPaneLayout: TadxOlReadingPaneLayout;
  public
    constructor Create(AReadingPaneLayout: TadxOlReadingPaneLayout);
    property ReadingPaneLayout: TadxOlReadingPaneLayout read FReadingPaneLayout;
  end;

  TadxOlReadingPaneShowEventArgs = class
  private
    FReadingPaneLayout: TadxOlReadingPaneLayout;
  public
    constructor Create(AReadingPaneLayout: TadxOlReadingPaneLayout);
    property ReadingPaneLayout: TadxOlReadingPaneLayout read FReadingPaneLayout;
  end;

  TadxOlReadingPaneHideEventArgs = class
  end;

  TadxOlNavigationPaneHideEventArgs = class
  private
    FOutlookBar: boolean;
  public
    constructor Create(AOutlookBar: boolean);
    property OutlookBar: boolean read FOutlookBar;
  end;

  TadxOlNavigationPaneShowEventArgs = class
  private
    FOutlookBar: boolean;
  public
    constructor Create(AOutlookBar: boolean);
    property OutlookBar: boolean read FOutlookBar;
  end;

  TBeforeFormInstanceCreateEventArgs = class
  private
    FExplorerObj: Explorer;
    FInspectorObj: Inspector;
    FFolderObj: MAPIFolder;
    FItem: TADXOlFormsCollectionItem;
    FCancel: boolean;
  public
    constructor Create(AItem: TadxOlFormsCollectionItem; AExplorerObj: Explorer; AExplorerArgs: TObject); overload;
    constructor Create(AItem: TadxOlFormsCollectionItem; AInspectorObj: Inspector; AInspectorArgs: TObject); overload;
    destructor Destroy; override;
    property Item: TADXOlFormsCollectionItem read FItem;
    property InspectorObj: Inspector read FInspectorObj;
    property ExplorerObj: Explorer read FExplorerObj;
    property FolderObj: MAPIFolder read FFolderObj;
    property Cancel: boolean read FCancel write FCancel;
  end;

  TadxOlNavigationPaneMinimizeEventArgs = class
  end;

  TadxOlTodoBarHideEventArgs = class
  end;

  TadxOlTodoBarShowEventArgs = class
  end;

  TadxOlTodoBarMinimizeEventArgs = class
  end;

  TadxolFormsManagerError = procedure(ASender: TObject; Args: TadxOlErrorEventArgs) of object;

  TadxolFormsManagerReadingPaneHide = procedure(ASender: TObject; Args: TadxOlReadingPaneHideEventArgs) of object;
  TadxolFormsManagerReadingPaneShow = procedure(ASender: TObject; Args: TadxOlReadingPaneShowEventArgs) of object;
  TadxolFormsManagerReadingPaneMove = procedure(ASender: TObject; Args: TadxOlReadingPaneMoveEventArgs) of object;

  TadxolFormsManagerNavigationPaneHide = procedure(ASender: TObject; Args: TadxOlNavigationPaneHideEventArgs) of object;
  TadxolFormsManagerNavigationPaneShow = procedure(ASender: TObject; Args: TadxOlNavigationPaneShowEventArgs) of object;
  TadxolFormsManagerNavigationPaneMinimize = procedure(ASender: TObject; Args: TadxOlNavigationPaneMinimizeEventArgs) of object;

  TadxolFormsManagerTodoBarHide = procedure(ASender: TObject; Args: TadxOlTodoBarHideEventArgs) of object;
  TadxolFormsManagerTodoBarShow = procedure(ASender: TObject; Args: TadxOlTodoBarShowEventArgs) of object;
  TadxolFormsManagerTodoBarMinimize = procedure(ASender: TObject; Args: TadxOlTodoBarMinimizeEventArgs) of object;

  TadxOlForm = class;
  TadxOlFormsManager = class;

  TadxolFormClassName = string;


  TadxolFormsManagerNewInspector = procedure(ASender: TObject; Inspector: Inspector) of object;
  TadxolFormsManagerComponentInitialize = procedure(ASender: TObject) of object;
  TadxolFormsManagerFolderSwitch = procedure(ASender: TObject; var ShowForm: boolean;
    ExplorerObj: Explorer; DstItem: TadxOlFormsCollectionItem; DstFolder: MAPIFolder) of object;
  TadxolFormsManagerBeforeFolderSwitch = procedure(ASender: TObject; ExplorerObj: Explorer;
    SrcItem: TadxOlFormsCollectionItem; SrcFolder: MAPIFolder; DstItem: TadxOlFormsCollectionItem;
    DstFolder: MAPIFolder) of object;

  TadxolFormsManagerFolderSwitchEx = procedure(ASender: TObject; ExplorerObj: Explorer;
    Folder: MAPIFolder) of object;
  TadxolFormsManagerBeforeFolderSwitchEx = procedure(ASender: TObject; ExplorerObj: Explorer;
    SrcFolder: MAPIFolder; DstFolder: MAPIFolder) of object;
  TadxolFormsManagerBeforeFormInstanceCreate = procedure(ASender: TObject;
    Item: TadxOlFormsCollectionItem; var Cancel: boolean) of object;
  TadxolFormsManagerBeforeFormInstanceCreateEx = procedure(ASender: TObject;
    Args: TBeforeFormInstanceCreateEventArgs) of object;


  TadxOlFormsCollectionItem = class(TCollectionItem)
  private
    FCloseButton: boolean;
    FAlwaysShowHeader: boolean;
    FDefaultRegionState: TadxRegionState;
    FRestoreFromMinimizedState: boolean;
    FIsDragDropAllowed: boolean;
    FExplorerAllowedDropRegions: TadxolExplorerAllowedDropRegions;
    FInspectorAllowedDropRegions: TadxolInspectorAllowedDropRegions;
    FIsHiddenStateAllowed: boolean;
    FRegionBorder: TadxRegionBorderStyle;
    function GetFormsManager: TadxolFormsManager;

    function GetExplorerAdxLayout: TAdxWindowLayout;

    procedure HideFormsByEmbededWindowHandle(EmbededWindowHandle: HWND);
    procedure HideExplorerForms(AExplorerArgs: TObject);
    procedure HideActiveExplorerForms(AExplorerArgs: TObject);
    procedure HideNotActiveExplorerForms(AExplorerArgs: TObject);
    procedure HideNotCorrespondedExplorerForms(AExplorerArgs: TObject);
    procedure DeleteNotCachedExplorerForms(AExplorerArgs: TObject);
    procedure DeleteExplorerForms(ExplorerWindowHandle: HWND);
    procedure DeleteFormsForAbsentInspectors;
    function GetFirstVisibleExplorerForms(AExplorerArgs: TObject): TadxOlForm;
    function GetFirstVisibleInspectorForms(AInspectorArgs: TObject): TadxOlForm;
    function GetActiveInspectorForm(AInspectorArgs: TObject): TadxOlForm;

    procedure ExplorerFormsHideShow;
    procedure InspectorFormsHideShow(CauseInspectorFormShowing: integer); overload;

    procedure DeleteNotVisibleForms;
    procedure DeleteAllForms;
    procedure HideAllForms;
    procedure HideAllNotInjectedForms;

    procedure HideInspectorForms(AInspectorArgs: TObject);
    procedure DeleteInspectorForms(AInspectorArgs: TObject);
    procedure HideFormsByEmulateWindowHandle(EmulateWindowHandle: HWND);

    function GetInspectorAdxLayout: TAdxWindowLayout;
    function GetFormInstances(Index: Integer): TadxOlForm;
    function GetFormInstanceCount: integer;
    procedure SetAlwaysShowHeader(const Value: boolean);
    procedure SetCloseButton(const Value: boolean);
    function GetDefaultRegionState: TadxRegionState;
    procedure SetDefaultRegionState(const Value: TadxRegionState);
    procedure SetExplorerAllowedDropRegions(
      const Value: TadxolExplorerAllowedDropRegions);
    procedure SetInspectorAllowedDropRegions(
      const Value: TadxolInspectorAllowedDropRegions);
    procedure SetUseOfficeThemeForBackground(const Value: boolean);  

    function ItemRegistryKey: string;
    procedure SaveExplorerLayoutToRegistry;
    procedure SaveInspectorLayoutToRegistry;
    procedure LoadExplorerLayoutFromRegistry;
    procedure LoadInspectorLayoutFromRegistry;
    procedure SetIsDragDropAllowed(const Value: boolean);
    procedure AddExplorerLayoutToExplorerAllowedDropRegions;
    procedure AddInspectorLayoutToInspectorAllowedDropRegions;
    class function ConvertExplorerLayoutToDesignString(ExplorerLayout: TadxolExplorerLayout): string;
    class function ConvertInspectorLayoutToDesignString(InspectorLayout: TadxolInspectorLayout): string;
    procedure SetHideButtonVisible(const Value: boolean);
    function GetIs2010: boolean;
  private
    FTag: Longint;
    FOldFolderName: string;
    FCurrentFolderName: string;
    FNewFolderName: string;
    FFolderName: string;

    FOldFolderNames: TStrings;
    FCurrentFolderNames: TStrings;
    FNewFolderNames: TStrings;
    FFolderNames: TStrings;

    FOldExplorerItemTypes: TadxolExplorerItemTypes;
    FCurrentExplorerItemTypes: TadxolExplorerItemTypes;
    FNewExplorerItemTypes: TadxolExplorerItemTypes;
    FExplorerItemTypes: TadxolExplorerItemTypes;

    FOldExplorerLayout: TadxolExplorerLayout;
    FCurrentExplorerLayout: TadxolExplorerLayout;
    FNewExplorerLayout: TadxolExplorerLayout;
    FExplorerLayout: TadxolExplorerLayout;

    FOldExplorerMessageClass: string;
    FCurrentExplorerMessageClass: string;
    FNewExplorerMessageClass: string;
    FExplorerMessageClass: string;

    FOldExplorerMessageClasses: TStrings;
    FCurrentExplorerMessageClasses: TStrings;
    FNewExplorerMessageClasses: TStrings;
    FExplorerMessageClasses: TStrings;

    FOldInspectorMessageClass: string;
    FCurrentInspectorMessageClass: string;
    FNewInspectorMessageClass: string;
    FInspectorMessageClass: string;

    FOldInspectorMessageClasses: TStrings;
    FCurrentInspectorMessageClasses: TStrings;
    FNewInspectorMessageClasses: TStrings;
    FInspectorMessageClasses: TStrings;

    FOldInspectorItemTypes: TadxolInspectorItemTypes;
    FCurrentInspectorItemTypes: TadxolInspectorItemTypes;
    FNewInspectorItemTypes: TadxolInspectorItemTypes;
    FInspectorItemTypes: TadxolInspectorItemTypes;

    FOldInspectorMode: TadxolInspectorModes;
    FCurrentInspectorMode: TadxolInspectorModes;
    FNewInspectorMode: TadxolInspectorModes;
    FInspectorMode: TadxolInspectorModes;

    FOldInspectorLayout: TadxolInspectorLayout;
    FCurrentInspectorLayout: TadxolInspectorLayout;
    FNewInspectorLayout: TadxolInspectorLayout;
    FInspectorLayout: TadxolInspectorLayout;

    FOldEnabled: boolean;
    FCurrentEnabled: boolean;
    FNewEnabled: boolean;
    FEnabled: boolean;

    FOldCached: TadxolCachingStrategy;
    FCurrentCached: TadxolCachingStrategy;
    FNewCached: TadxolCachingStrategy;
    FCached: TadxolCachingStrategy;

    FOldSplitter: TadxolSplitterBehavior;
    FCurrentSplitter: TadxolSplitterBehavior;
    FNewSplitter: TadxolSplitterBehavior;
    FSplitter: TadxolSplitterBehavior;

    FOldFormClassName: TadxolFormClassName;
    FCurrentFormClassName: TadxolFormClassName;
    FNewFormClassName: TadxolFormClassName;
    FFormClassName: TadxolFormClassName;

    FChangedPropertySet: integer; //TChangedPropertySet;
    FLockMode: boolean;

    FFormInstances: TObject;//TadxOlFormsManagerList;
    FFolders: TStringList;
    FItemID: TGUID;
    FUseOfficeThemeForBackground: boolean;

    procedure HideCTP(AExplorerLayout: TadxOlExplorerLayout);

    procedure SetFolderName(const Value: string);
    procedure DoChangeFolderName;

    procedure SetFolderNames(const Value: TStrings);
    procedure DoChangeFolderNames;

    procedure SetExplorerItemTypes(const Value: TadxolExplorerItemTypes);
    procedure DoChangeExplorerItemTypes;

    procedure SetExplorerLayout(const Value: TadxolExplorerLayout);
    procedure DoChangeExplorerLayout;

    procedure SetExplorerMessageClass(const Value: string);
    procedure DoChangeExplorerMessageClass;

    procedure SetExplorerMessageClasses(const Value: TStrings);
    procedure DoChangeExplorerMessageClasses;

    procedure SetInspectorMessageClass(const Value: string);
    procedure DoChangeInspectorMessageClass;

    procedure SetInspectorMessageClasses(const Value: TStrings);
    procedure DoChangeInspectorMessageClasses;

    procedure SetInspectorItemTypes(const Value: TadxolInspectorItemTypes);
    procedure DoChangeInspectorItemTypes;

    procedure SetInspectorMode(const Value: TadxolInspectorModes);
    procedure DoChangeInspectorMode;

    procedure SetInspectorLayout(const Value: TadxolInspectorLayout);
    procedure DoChangeInspectorLayout;

    procedure SetEnabled(const Value: boolean);
    procedure DoChangeEnabled;

    procedure SetCached(const Value: TadxolCachingStrategy);
    procedure DoChangeCached;

    procedure SetSplitter(const Value: TadxolSplitterBehavior);
    procedure DoChangeSplitter;

    procedure SetFormClassName(const Value: TadxolFormClassName);
    procedure DoChangeFormClassName;

    procedure GenerateNewItemID;
    function OutlookVersion: integer;

  protected
    procedure ProvideDockTaskPane(AExplorerArgs: TObject);  { TODO : Must be private access }
  private
    function IsSuperGridLayout: boolean;
    function IsFolderViewClientLayout: boolean;
    function IsReadingPaneLayout: boolean;
    function IsReadingPaneClientLayout: boolean;
    function IsWebViewPaneLayout: boolean;
    function IsNavigationPaneLayout: boolean;
    function IsOutlookBarLayout: boolean;
    function IsTodoBarLayout: boolean;
    function IsDockLayout: boolean;
    function IsInspectorRegionClientLayout: boolean;

    function DefiniteExplorerProperties: boolean;
    function CorrespondExplorerContext(AExplorerArgs: TObject): boolean;

    function CorrespondInspectorContext(AInspectorArgs: TObject): boolean;

    function FindExplorerForm(AExplorerArgs: TObject): TadxOlForm;

    function CreateForm: TadxOlForm;
    function GetForm(Cancel: boolean): TadxOlForm;

    function FindInspectorForm(AInspectorArgs: TObject): TadxOlForm;

    procedure SetExplorerAppWindowProperty(AExplorerArgs: TObject; AAppWindowProperty: Pointer; WindowHandle: HWND);
    procedure SetInspectorAppWindowProperty(AInspectorArgs: TObject; AppWindowProperty: Pointer);
    procedure FindVerticalScrollbar(const OwnerWindow: HWND; const WindowHandle: HWND; var BreakProcess: boolean);


    procedure ChangeInspectorWindowHandle(OldHandle: HWND; NewHandle: HWND);

    property FormsManager: TadxolFormsManager read GetFormsManager;
    property InspectorAdxLayout: TAdxWindowLayout read GetInspectorAdxLayout;
    property Is2010: boolean read GetIs2010;
{$IFNDEF ADXXOL_TRIAL}
  private
{$ELSE}
  protected
{$ENDIF}
    function DefiniteInspectorProperties: boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ApplyTo(InspectorObj: Inspector); overload;
    procedure ApplyTo(ExplorerObj: Explorer); overload;
    function GetCurrentForm(EmbeddedFormState: TadxEmbeddedFormStates): TadxOlForm;
    property FormInstances[Index: Integer]: TadxOlForm read GetFormInstances;
    property FormInstanceCount: integer read GetFormInstanceCount;
  published
    property FolderName: string read FFolderName write SetFolderName;
    property FolderNames: TStrings read FFolderNames write SetFolderNames;
    property ExplorerItemTypes: TadxolExplorerItemTypes read
      FExplorerItemTypes write SetExplorerItemTypes;
    property ExplorerLayout: TadxolExplorerLayout read FExplorerLayout
      write SetExplorerLayout default elUnknown;
    property ExplorerMessageClass: string read FExplorerMessageClass write SetExplorerMessageClass;
    property ExplorerMessageClasses: TStrings
      read FExplorerMessageClasses write SetExplorerMessageClasses;

    property InspectorMessageClass: string
      read FInspectorMessageClass write SetInspectorMessageClass;
    property InspectorMessageClasses: TStrings
      read FInspectorMessageClasses write SetInspectorMessageClasses;

    property InspectorItemTypes: TadxolInspectorItemTypes
      read FInspectorItemTypes write SetInspectorItemTypes;
    property InspectorMode: TadxolInspectorModes
      read FInspectorMode write SetInspectorMode default [imRead, imCompose];

    property InspectorLayout: TadxolInspectorLayout
      read FInspectorLayout write SetInspectorLayout default ilUnknown;

    property InspectorAllowedDropRegions: TadxolInspectorAllowedDropRegions
      read FInspectorAllowedDropRegions write SetInspectorAllowedDropRegions default [];

    property ExplorerAllowedDropRegions: TadxolExplorerAllowedDropRegions
      read FExplorerAllowedDropRegions write SetExplorerAllowedDropRegions default [];

    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Cached: TadxolCachingStrategy read FCached write SetCached default csNewInstanceForEachFolder;
    property Splitter: TadxolSplitterBehavior read FSplitter write SetSplitter default sbStandard;
    property FormClassName: TadxolFormClassName read FFormClassName write SetFormClassName;
    property Tag: Longint read FTag write FTag default 0;
    property AlwaysShowHeader: boolean read FAlwaysShowHeader write SetAlwaysShowHeader default false;
    property CloseButton: boolean read FCloseButton write SetCloseButton default false;
    property IsHiddenStateAllowed: boolean read FIsHiddenStateAllowed write SetHideButtonVisible default true;
    property DefaultRegionState: TadxRegionState read GetDefaultRegionState write SetDefaultRegionState default rsNormal;
    property RestoreFromMinimizedState: boolean read FRestoreFromMinimizedState write FRestoreFromMinimizedState default false;
    property IsDragDropAllowed: boolean read FIsDragDropAllowed write SetIsDragDropAllowed default false;
    property RegionBorder: TadxRegionBorderStyle read FRegionBorder write FRegionBorder default rbsSingle;
    property UseOfficeThemeForBackground: boolean read FUseOfficeThemeForBackground write SetUseOfficeThemeForBackground default false;
  end;

  TadxOlFormsCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxOlFormsCollectionItem;
    procedure SetItem(Index: Integer; Value: TadxOlFormsCollectionItem);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    {$IFDEF ADX_VCL5}
    function Owner: TPersistent;
    {$ENDIF}
    function Add: TadxOlFormsCollectionItem; overload;
    property Items[Index: Integer]: TadxOlFormsCollectionItem read GetItem write SetItem; default;
  end;

  TadxOlForm = class(TadxOLCustomForm)
  private

  private
    FIsInspectorForm: boolean;
    FIsWordMailInspectorForm: boolean;
    FIsExplorerForm: boolean;
    FFormsManager: TadxolFormsManager;
    FItem: TadxOlFormsCollectionItem;
    FOutlookWindowHandle: HWND;
    FExplorerObj: Explorer;
    FInspectorObj: Inspector;
    FFolderItemsObj: Items;
    FFolderObj: MAPIFolder;
    FOnADXBeforeInspectorSubpaneClose: TNotifyEvent;
    FOnADXBeforeFormShow: TNotifyEvent;
    FOnADXAfterFormShow: TNotifyEvent;
    FOnADXSelectionChange: TNotifyEvent;
    FFolderEntryID: string;
    FisHidenByDeveloper: boolean;
    FWindowHandle: HWND;
    FEmulateWindowHandle: HWND;
    FAdxLayoutKey: string;
    FOnADXCloseButtonClick: TadxOlCloseButtonClickEventHandler;
    FOnADXEnter: TadxOlFormEnterEventHandler;
    FOnADXExit: TadxOlFormExitEventHandler;
    FOnADXPostMessage: TadxOlPostMessageReceivedEventHandler;
    FOnADXAfterFormHide: TadxOlFormAfterFormHideEventHandler;
    FOnADXFolderSwitch: TadxOlFormFolderSwitchEventHandler;
    FOnADXInspectorActivate: TadxOlFormInspectorActivateEventHandler;
    FOnADXNewInspector: TadxOlFormNewInspectorEventHandler;
    FOnADXKeyFilter: TadxOlKeyFilterEventHandler;

    DragContextExplorerItemType: TadxOlExplorerItemType;
    DragContextInspectorItemType: TadxOlInspectorItemType;
    DragContextReadingPaneLayout: TadxOlReadingPaneLayout;
    DragContextMailPostInspectorType: integer;

    function GetIsExplorerForm: boolean;
    function GetIsInspectorForm: boolean;
    function GetIsWordMailInspectorForm: boolean;
    function GetAddinModule: TObject;
    function GetOutlookAppObj: OutlookApplication;
    function CheckOutlookWindowHandle(Handle: HWND): boolean;
    procedure DisposeOutlookObjects;
    procedure ADXOlHide(raiseEvents: boolean);
    procedure ShowCTP(var CTPHandle: HWnd);
    procedure HideCTP(AExplorerlayout: TadxolExplorerLayout);


    property FolderEntryID: string read FFolderEntryID;
    procedure InitializeForm(AContextArgs: TObject; AAppWindowProperty: Pointer);
    procedure UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty: Pointer);
    procedure AdxOlShow(AAppWindowProperty: Pointer; raiseEvents: boolean);

    property IsExplorerForm: boolean read GetIsExplorerForm;
    property IsInspectorForm: boolean read GetIsInspectorForm;
    property IsWordMailInspectorForm: boolean read GetIsWordMailInspectorForm;
    function GetCurrentOutlookWindowHandle: HWND;
    procedure ChangeInspectorWindowHandle(newOutlookWindowHandle: HWND);
    procedure RaiseOnADXBeforeInspectorSubpaneClose(Sender: TObject);
    property IsHidenByDeveloper: boolean read FisHidenByDeveloper;

    procedure DoAdxEnter(args: TadxOlEnterEventArgs);
    procedure DoAdxExit(args: TadxOlExitEventArgs);
    procedure DoAdxPostMessage(args: TadxOlPostMessageReceivedEventArgs);
    procedure DoAdxAfterFormHide(args: TadxOlAfterFormHideEventArgs);
    procedure DoAdxFolderSwitch(args: TadxOlFormFolderSwitchEventArgs);
    procedure DoAdxInspectorActivate(args: TadxOlFormInspectorActivateEventArgs);
    procedure DoAdxNewInspector(args: TadxOlFormNewInspectorEventArgs);
    procedure DoADXKeyFilter(Args: TadxOlKeyFilterEventArgs);

    procedure CheckWordMailInspectorUnderExplorer;

    procedure DoReceiveAdxPostMessageCluster(msg: TMessage);
    procedure SetHTMLDocumentTitle();
    function  IsContextSupportDropRegions(AllowedDropRegion: TadxOlExplorerAllowedDropRegion): bool;
    procedure InternalSetDragItems(ADragItems: TList; dragWindowLayouts: TadxDragWindowLayout; AllowedDropRegion: TadxOlExplorerAllowedDropRegion); overload;
    procedure InternalSetDragItems(ADragItems: TList; dragWindowLayouts: TadxDragWindowLayout; AllowedDropRegion: TadxOlInspectorAllowedDropRegion); overload;
    function InClientLayout: boolean;

    class function GetInspectorLayoutKey(InspectorLayout: TadxOlInspectorLayout): string;
    class function GetExplorerLayoutKey(ExplorerLayout: TadxOlExplorerLayout;
      ExplorerItemType: TadxOlExplorerItemType;
      ReadingPaneLayout: TadxOlReadingPaneLayout): string;
  protected
    function  IsSubstInspectorRegion: boolean; override;
    procedure SetCaption(value: TCaption); override;
    procedure HideByManager(UsingVisibleProperty: boolean); override;
    procedure DoActivate; override;
    function  UseOfficeThemeBackColor: boolean; override;
    function  AdxRegistryKey: string; override;
    function  AdxLocalRegistryKey: string; override;
    function  GetDefaultRegionState: TadxInternalRegionState; override;
    procedure UpdateAdxLayoutKey(itemType: TadxItemType; explorerItemType: TadxolExplorerItemType);
    procedure UpdateCTPParam(uType: TadxCTPUpdateParamType; ASize: integer); override;
    function  AdxLayoutKey: string; override;
    function  RegistryKey: string; override;
    procedure DoInstanceFocused(focused: boolean); override;
    procedure WndProc(var Msg: TMessage); override;

    procedure SetDragItems(ADragItems: TList); overload; override;
    procedure GetDragLayoutParams(var lParams: TadxDragLayoutParams); override;
    procedure SetDragForm(AItemType: TAdxItemType; ALayout: TadxWindowLayout); override;
    function  IsDragDropAllowed: boolean; override;
    function  IsExpandFromMinimizedState: boolean; override;
    function  GetOSCConnected: boolean; override;

  public
    constructor CreateEx(AFormsManager: TadxolFormsManager;
      AItem: TadxOlFormsCollectionItem); virtual;
    destructor Destroy; override;
    procedure Hide; override;
    procedure Show; override;
    procedure ADXPostMessage(wParam, lParam: Cardinal);
    procedure ActivateStandardPane;
    property CurrentOutlookWindowHandle: HWND read GetCurrentOutlookWindowHandle;
    property AddinModule: TObject read GetAddinModule;
    property ExplorerObj: Explorer read FExplorerObj;
    property InspectorObj: Inspector read FInspectorObj;
    property FolderItemsObj: Items read FFolderItemsObj;
    property FolderObj: MAPIFolder read FFolderObj;
    property FormsManager: TadxolFormsManager read FFormsManager;
    property Item: TadxOlFormsCollectionItem read FItem;
    property OutlookAppObj: OutlookApplication read GetOutlookAppObj;

  published
    property OnADXBeforeFormShow: TNotifyEvent read FOnADXBeforeFormShow write FOnADXBeforeFormShow;
    property OnADXAfterFormShow: TNotifyEvent read FOnADXAfterFormShow write FOnADXAfterFormShow;
    property OnADXSelectionChange: TNotifyEvent
      read FOnADXSelectionChange write FOnADXSelectionChange;
    property OnADXBeforeInspectorSubpaneClose: TNotifyEvent
      read FOnADXBeforeInspectorSubpaneClose write FOnADXBeforeInspectorSubpaneClose;
    property OnADXCloseButtonClick: TadxOlCloseButtonClickEventHandler read FOnADXCloseButtonClick write FOnADXCloseButtonClick;

    property OnADXEnter: TadxOlFormEnterEventHandler read FOnADXEnter write FOnADXEnter;
    property OnADXExit: TadxOlFormExitEventHandler read FOnADXExit write FOnADXExit;
    property OnADXPostMessageReceived: TadxOlPostMessageReceivedEventHandler read FOnADXPostMessage write FOnADXPostMessage;
    property OnADXAfterFormHide: TadxOlFormAfterFormHideEventHandler read FOnADXAfterFormHide write FOnADXAfterFormHide;
    property OnADXFolderSwitch: TadxOlFormFolderSwitchEventHandler read FOnADXFolderSwitch write FOnADXFolderSwitch;
    property OnADXInspectorActivate: TadxOlFormInspectorActivateEventHandler  read FOnADXInspectorActivate write FOnADXInspectorActivate;
    property OnADXNewInspector: TadxOlFormNewInspectorEventHandler  read FOnADXNewInspector write FOnADXNewInspector;
    property OnADXKeyFilter: TadxOlKeyFilterEventHandler read FOnADXKeyFilter write FOnADXKeyFilter;
  end;

  TadxOlFormsManager = class(TComponent)
  private
    FHTMLFullFileName: string;
    FOutlookHook: TAdxOlHook;
    FctpFactory: ICTPFactory;
    FOnFolderSwitchEx: TADXOLFormsManagerFolderSwitchEx;
    FOnBeforeFormInstanceCreate: TadxolFormsManagerBeforeFormInstanceCreate;
    FOutlookHandleFinder: TObject;

    FOnNavigationPaneHide: TadxolFormsManagerNavigationPaneHide;
    FOnNavigationPaneShow: TadxolFormsManagerNavigationPaneShow;
    FOnNavigationPaneMinimize: TadxolFormsManagerNavigationPaneMinimize;

    FOnTodoBarHide: TadxolFormsManagerTodoBarHide;
    FOnTodoBarShow: TadxolFormsManagerTodoBarShow;
    FOnTodoBarMinimize: TadxolFormsManagerTodoBarMinimize;

    FOnReadingPaneHide: TadxolFormsManagerReadingPaneHide;
    FOnReadingPaneMove: TadxolFormsManagerReadingPaneMove;
    FOnReadingPaneShow: TadxolFormsManagerReadingPaneShow;
    FOnBeforeFormInstanceCreateEx: TadxolFormsManagerBeforeFormInstanceCreateEx;
    FReadingPaneLayout: TadxOlReadingPaneLayout;
    FOnError: TadxolFormsManagerError;
    FOnADXAfterAccessProtectedObject: TNotifyEvent;
    FOnADXBeforeAccessProtectedObject: TNotifyEvent;
    function GetOutlookVersion: TadxolOutlookVersion;
    function GetReceiverWindowHandle: HWND;
    procedure HideInspectorForms(AInspectorArgs: TObject);
    function GetHTMLFullFileName: string;
    function GetOutboxFolderEntryID: string;
    function GetPublicFoldersEntryID: string;
    function GetFolderSyncIssuesEntryID: string;
    function GetPublicFoldersAllPublicFoldersEntryID: string;
    procedure LoadDefaultFoldersEntryIDFromRegistry;
    function IsTemporaryEntryID(EntryID: string): boolean;
    function GetFolderSyncIssuesObj: MAPIFolder;
    function GetOutboxFolderObj: MAPIFolder;
    function GetPublicFoldersAllPublicFoldersObj: MAPIFolder;
    function GetPublicFoldersObj: MAPIFolder;
    function GetExplorerLayout(ItemType: TadxItemType; WindowLayout: TadxWindowLayout): TadxOlExplorerLayout;
    function GetInspectorLayout(ItemType: TadxItemType; WindowLayout: TadxWindowLayout): TadxOlInspectorLayout;
    function GetExplorerRegionSize(ExplorerLayout: TadxOlExplorerLayout; ExplorerItemType: TadxOlExplorerItemType; ReadingPaneLayout: TadxOlReadingPaneLayout; ItemType: TadxItemType): integer;
    function GetInspectorRegionSize(InspectorLayout: TadxOlInspectorLayout): integer;
    function GetDisableInCOMAddinsDialogWhenOutlookIsOpened: boolean;

  private
    FOutboxFolderEntryID: string;
    FPublicFoldersEntryID: string;
    FPublicFoldersAllPublicFoldersEntryID: string;
    FFolderSyncIssuesEntryID: string;
    property OutboxFolderEntryID: string read GetOutboxFolderEntryID;
    property PublicFoldersEntryID: string read GetPublicFoldersEntryID;
    property PublicFoldersAllPublicFoldersEntryID: string read GetPublicFoldersAllPublicFoldersEntryID;
    property FolderSyncIssuesEntryID: string read GetFolderSyncIssuesEntryID;
  private
    FSocialConnectorAddinConnected: boolean;
    InboxFullFolderName: string;
    FInboxFolderObj: MAPIFolder;
		FOutboxFolderObj: MAPIFolder;
    WasGettingPublicFoldersObj: boolean;
		FPublicFoldersObj: MAPIFolder;
    WasGettingPublicFoldersAllPublicFoldersObj: boolean;
		FPublicFoldersAllPublicFoldersObj: MAPIFolder;
 		FRefreshCurrentFolderObj: MAPIFolder;
 		FRefreshSecondaryFolderObj: MAPIFolder;
    WasGettingFolderSyncIssuesObj: boolean;
    FFolderSyncIssuesObj: MAPIFolder;
    procedure CheckSocialConnectorAddinConnection;
    property OutboxFolderObj: MAPIFolder read GetOutboxFolderObj;
    property PublicFoldersObj: MAPIFolder read GetPublicFoldersObj;
    property PublicFoldersAllPublicFoldersObj: MAPIFolder read GetPublicFoldersAllPublicFoldersObj;
    property FolderSyncIssuesObj: MAPIFolder read GetFolderSyncIssuesObj;
    property SocialConnectorAddinConnected: boolean read FSocialConnectorAddinConnected;

  private
    procedure ReleaseDefaultFolders;
{$IFDEF LOHICA}
    function RegisterInspectorsCount: integer;
{$ENDIF}
  private
    FHookTransaction: integer;
    FHookTransactionWindowHandle: HWND;
    hMessageMutex:  THandle;
    hClearWatchObjectsMutex:  THandle;
    hResizeEmulateWibdowMutex:  THandle;
    hADXOLWatchEngineSendMessageMutex: THandle;
    hADXOLOutlookEvent: THandle;
    FReceiverWindow: Pointer;
    FOnBeforeFolderSwitch: TadxolFormsManagerBeforeFolderSwitch;
    FOnBeforeFolderSwitchEx: TadxolFormsManagerBeforeFolderSwitchEx;

    FOnComponentInitialize: TadxolFormsManagerComponentInitialize;
    FOnFolderSwitch: TadxolFormsManagerFolderSwitch;
    FOnNewInspector: TadxolFormsManagerNewInspector;
    FItems: TadxOlFormsCollection;
    FState: pointer;
    FOutlookUtils: pointer;
    FRegisteredExplorerList: TObject; //TadxOlRegisterExplorerList;
    FRegisteredInspectorList: TObject; //TadxOlRegisterInspectorList;
    FOutlookVersion: TadxolOutlookVersion;
    FisLockUpdates: boolean;

    FOldAddInBeginShutdown: TNotifyEvent;
    FOldAddInFinalize: TNotifyEvent;
    FOldAddInInitialize: TNotifyEvent;
    FOldAddInStartupComplete: TNotifyEvent;

    FOldApplicationQuit: TNotifyEvent;

    FOldOLExplorerBeforeFolderSwitch: TadxExplorerBeforeFolderSwitch;
    FOldOLExplorerBeforeViewSwitch: TadxExplorerBeforeViewSwitch;
    FOldOLExplorerClose: TNotifyEvent;
    FOldOLExplorerFolderSwitch: TNotifyEvent;
    FOldOLExplorerSelectionChange: TNotifyEvent;
    FOldOLExplorerViewSwitch: TNotifyEvent;
    FOldOLInspectorClose: TNotifyEvent;
    FOldOLNewExplorer: TadxNewExplorer;
    FOldOLNewInspector: TadxNewInspector;
    FOldOLInspectorActivate: TNotifyEvent;
    FWatchEngine: TObject;
    FPriorExplorerWindowHandleForSearching: HWND;
    FRefreshInspectorTabTransactionWindowHandle: HWND;
    function IsContextSupport(ExplorerLayout: TadxolExplorerLayout; AExplorerArgs: TObject): boolean;
    function GetWasAddinInitialize: boolean;
{$IFDEF DOCKEXPLORERLAYOUTS}
    procedure TryInitCtpFactory;
{$ENDIF}
    procedure CreateMutexes;
    procedure DeleteMutexes;
    procedure HideAllServiceForm;
    procedure AddDestroyEmbededWindowMessageToReceiver();
    procedure AddInformToShowDockLayoutMessageToReceiver();
    procedure AddCloseServiceFormsMessagesToReceiver;
    procedure AddCloseButtonClickMessageToReceiver();
    procedure AddRemoveControlledResizeWindowMessageToReceiver();
    function GetCurrentForm: TadxOlForm;
    function GetItems: TadxOlFormsCollection;
    function GetOutlookAppObj: OutlookApplication;
    procedure SetItems(const Value: TadxOlFormsCollection);
    procedure SetState(const Value: pointer);
    procedure SetOutlookUtils(const Value: pointer);
    function GetCOMAddInModule: TadxCOMAddInModule;
    function GetHasWebViewPane: boolean;
    function HasWebViewPaneItemThatCorrespondExplorerContext(AExplorerArgs: TObject): boolean;

{$IFDEF DOCKEXPLORERLAYOUTS}
    procedure ShowCTP(window: IDispatch; CTPParam: TAdxCTPParams);
    procedure HideCTP(DockPosition: integer; window: IDispatch);
    procedure UpdateCTP(window: IDispatch; CTPParam: TAdxCTPParams);
    procedure HideAllCTP(AExplorerArgs: TObject);
{$ENDIF}
    procedure DoShowBackStage(ExplorerWindowHandle: HWND);
    procedure DoHideBackStage(ExplorerWindowHandle: HWND);

    procedure OnAddInBeginShutdown(Sender: TObject);
    procedure OnAddInFinalize(Sender: TObject);
    procedure OnAddInInitialize(Sender: TObject);
    procedure OnAddInStartupComplete(Sender: TObject);
    procedure OnCTPFactoryAvailable(CTPFactory: ICTPFactory);

    procedure OnApplicationQuit(Sender: TObject);

    procedure OnOLNewExplorer(ASender: TObject; const Explorer: _Explorer);
    procedure OnOLExplorerBeforeFolderSwitch(ASender: TObject; const NewFolder: IDispatch;
      var Cancel: WordBool);
    procedure OnOLExplorerBeforeViewSwitch(ASender: TObject; NewView: OleVariant;
      var Cancel: WordBool);
    procedure OnOLExplorerFolderSwitch(Sender: TObject);
    procedure OnOLExplorerSelectionChange(Sender: TObject);
    procedure OnOLExplorerViewSwitch(Sender: TObject);
    procedure OnOLExplorerClose(Sender: TObject);

    procedure OnOLNewInspector(ASender: TObject; const Inspector: _Inspector);
    procedure OnOLInspectorClose(Sender: TObject);
    procedure OnOLInspectorActivate(Sender: TObject);


    procedure OnCommonReceiverWindowShow(HostHandle: HWND; ItemType: TADXItemType);
    procedure OnCommonReceiverWindowHide(HostHandle: HWND; ItemType: TADXItemType);
    procedure OnCommonReceiverWindowMinimize(HostHandle: HWND; ItemType: TADXItemType);


    procedure OnCommonReceiverInspectorWindowHide(WindowHandle: HWND; ItemType: TADXItemType);

    procedure OnCommonInspectorWindowShow(HostHandle: HWND; ItemType: TADXItemType);
    procedure OnCommonInspectorWindowHide(HostHandle: HWND; ItemType: TADXItemType; CallingFromInspectorClose: boolean);

    procedure OnWordInspectorPreviewOn(HostHandle: HWND; ItemType: TADXItemType);
    procedure DoWordInspectorPreviewOn(AInspectorArgs: TObject);
    procedure OnWordInspectorPreviewOff(HostHandle: HWND; ItemType: TADXItemType);
    procedure DoWordInspectorPreviewOff(AInspectorArgs: TObject);

    procedure OnRemoveControlledResizeWindow(HostHandle: HWND; EmulateWindowHandle: HWND);
    procedure DoRemoveControlledResizeWindow(AInspectorArgs: TObject);

    procedure OnDeleteEmulateWindowEvent(HostHandle: HWND; EmulateWindowHandle: HWND);

    procedure DoProcessInformAddinsToShowDockLayouts(DockPosition: integer);

    procedure OnCommonExplorerWindowShow(HostHandle: HWND; ItemType: TADXItemType);
    procedure OnCommonExplorerWindowHide(HostHandle: HWND; ItemType: TADXItemType);
    procedure OnCommonExplorerWindowMinimize(HostHandle: HWND; ItemType: TADXItemType);

    procedure OnMoveReadingPaneWindow(HostHandle: HWND; ItemType: TADXItemType; ReadingPaneLayout: TadxOlReadingPaneLayout);

    procedure OnAsyncWordEditorHide(HostHandle: HWND; ItemType: TADXItemType);
    procedure ChangeInspectorWindowHandle(AInspector: TObject; CurrentWordInspectorHandle: HWND);
    procedure CheckAndRunRefreshInspectorTabWatchObject(AInspectorArgs: TObject);
    procedure DoInspectorWindowShow(AInspectorArgs: TObject; CauseInspectorFormShowing: integer);
    procedure DoInspectorWindowHide(AInspectorArgs: TObject);

    procedure DoOutlookBarShow(AExplorerArgs: TObject);
    procedure DoFolderListShow(AExplorerArgs: TObject);
    procedure DoNavigationPaneShow(AExplorerArgs: TObject);
    procedure RaiseTodoBarShowEvent;
    procedure DoTodoBarShow(AExplorerArgs: TObject);
    procedure DoReadingPaneShow(AExplorerArgs: TObject);
    procedure DoReadingPaneMove(AExplorerArgs: TObject; AReadingPaneLayout: TadxOlReadingPaneLayout);

    procedure DoDestroyEmbededWindow(HostHandle: HWND; EmbededWindowHandle: HWND);

    procedure DoCTPVisibleChanged(param: TadxCTPVisibleParams);
    procedure OnCloseServiceFormForNotWordInspector(InspectorWindowHandle: HWND; WindowHandle: HWND);
    procedure OnCloseFolderViewServiceForm(ExplorerWindowHandle: HWND; WindowHandle: HWND);
    procedure OnCloseReadingPaneServiceForm(ExplorerWindowHandle: HWND; WindowHandle: HWND);

    procedure DoOutlookBarHide(AExplorerArgs: TObject);
    procedure DoFolderListHide(AExplorerArgs: TObject);
    procedure DoNavigationPaneHide(AExplorerArgs: TObject);
    procedure RaiseTodoBarHideEvent();
    procedure DoTodoBarHide(AExplorerArgs: TObject);
    procedure DoReadingPaneHide(AExplorerArgs: TObject);

    procedure DoNavigationPaneMinimize(AExplorerArgs: TObject);
    procedure RaiseTodoBarMinimizeEvent;
    procedure DoTodoBarMinimize(AExplorerArgs: TObject);

    procedure DoBeforeAccessProtectedObject;
    procedure DoAfterAccessProtectedObject;


    procedure ReceiverAddMoveReadingPaneWindowMessage(AExplorerArgs: TObject);

    procedure DoShutdown(Sender: TObject);
    procedure DoFinalize(Sender: TObject);

    procedure DoAddInBeginShutdown(Sender: TObject);
    procedure DoAddInFinalize(Sender: TObject);
    procedure DoAddInInitialize(Sender: TObject);
    procedure DoAddInStartupComplete(Sender: TObject);
    procedure DoApplicationQuit(Sender: TObject);

    function DockLayoutIsSupported: boolean;
    procedure ProcessDockLayout(AExplorerArgs: TObject);
    procedure ProcessDockLayoutForAllExplorers;

    function GetSuperGridLayoutWindowHandle(AExplorerArgs: TObject): HWND;
    function GetWebViewPaneLayoutWindowHandle(AExplorerArgs: TObject): HWND;
    function GetReadingPaneLayoutWindowHandle(AExplorerArgs: TObject): HWND;
    function GetClientLayoutWindowHandle(AInspectorArgs: TObject): HWND;
    function GetNavigationPaneLayoutWindowHandle(AExplorerArgs: TObject): HWND;
    function GetTodoBarPaneLayoutWindowHandle(AExplorerArgs: TObject): HWND;
    procedure HideAllFormsInAllAddins(WindowHandle: HWND);

    procedure HideReadingPaneServiceForm(AExplorerArgs: TObject);
    procedure HideFolderViewServiceForm(AExplorerArgs: TObject);
    procedure HideClientSubpaneServiceForm(AInspectorArgs: TObject);

    procedure DoOLNewExplorer(AExplorerArgs: TObject);
    procedure OnRefreshFolder(ExplorerWindowHandle: HWND);
    procedure DoOLExplorerBeforeFolderSwitch(AExplorerArgs: TObject;
      ANewFolderExplorerArgs: TObject);
    procedure DoOLExplorerBeforeViewSwitch(AExplorerArgs: TObject; NewView: OleVariant;
      var Cancel: WordBool);
    procedure DoOLExplorerFolderSwitch(AExplorerArgs: TObject);
    procedure DoOLExplorerSelectionChange(AExplorerArgs: TObject);
    procedure DoOLExplorerViewSwitch(AExplorerArgs: TObject);
    procedure DoOLExplorerClose(AExplorerArgs: TObject);

    procedure DeleteExplorerWindowsForSearching(AExplorerArgs: TObject);
    procedure DoPreparationDisableAddinInCOMAddinsDialog();
    procedure DoCloseAllFormsInDockLayoutsWhenDisableAddinInCOMAddinsDialog();
    procedure DoInformAddinsToShowDockLayouts(DockPosition: integer);

    procedure DoOLNewInspector(AInspectorArgs: TObject);
    procedure DoOLInspectorClose(AInspectorArgs: TObject);
    procedure DoOLInspectorActivate(AInspectorArgs: TObject);
    function HasWebViewWindow(AExplorerArgs: TObject): boolean;

    procedure DoShowExplorerForm(Item: TadxOlFormsCollectionItem;  AExplorerArgs: TObject; WindowHandle: HWND);
    procedure DoShowInspectorForm(Item: TadxOlFormsCollectionItem; AInspectorArgs: TObject;
      WithoutFormCreating: boolean; CauseInspectorFormShowing: integer);
    procedure DoShowReadingPaneServiceForm(Item: TadxOlFormsCollectionItem; AExplorerArgs: TObject; WindowHandle: HWND);
    procedure DoShowFolderViewServiceForm(Item: TadxOlFormsCollectionItem; AExplorerArgs: TObject; WindowHandle: HWND);
    procedure DoShowInspectorServiceForm(Item: TadxOlFormsCollectionItem; AInspectorArgs: TObject; EmulateWindowHandle, WindowHandle: HWND);

    function ExistsServiceForm(WindowHandle: HWND): boolean;
    function GetExplorerServiceFormCaption(ExplorerLayout: TadxolExplorerLayout): string;
    function GetInspectorServiceFormCaption(InspectorItemTypeCaption: string; InspectorLayout: TadxolInspectorLayout): string;
    function GetFirstVisibleInspectorRegionLayoutForm(WindowHandle: HWND): TadxOlForm;
    function GetFirstVisibleFolderViewLayoutForm(WindowHandle: HWND): TadxOlForm;
    function GetFirstVisibleReadingPaneLayoutForm(WindowHandle: HWND): TadxOlForm;

    procedure DoRegionCloseButtonClick(AFormHandle: HWND); overload;
    procedure DoRegionCloseButtonClick(AForm: TadxOlForm); overload;
    function FindFormByHandle(AFormHandle: HWND): TadxOlForm;

    procedure TryShowInInspector(Form: TadxOlForm; InspectorObj: Inspector;
      InspectorWindowHandle: HWND; CauseInspectorFormShowing: integer);
    procedure TryShowInExplorer(Form: TadxOlForm; ExplorerObj: Explorer;
      ExplorerWindowHandle: HWND);
    procedure TryProcessTheADXOlFormShowMethod(Form: TadxOlForm);

    function GetisClosingOutlookOnExplorerClose: boolean;
    property OutlookVersion: TadxolOutlookVersion read GetOutlookVersion;

    procedure ConnectAddinModuleEvents;
    procedure ConnectOutlookEvents;
    procedure DisconnectAddinModuleEvents;
    procedure DisconnectOutlookEvents;

    procedure SetOutlookVersion;
    procedure AddinsToLog;
    procedure RestoreWebViewFolderSettings;
    procedure ProcessRootFoldersWebViewPane(ExplorerObj: Explorer);
    procedure ProcessFoldersWebViewPane(ExplorerObj: Explorer; FolderObj: MAPIFolder);
    procedure ProcessFolderWebViewPane(ExplorerObj: Explorer; FolderObj: MAPIFolder);
    procedure StoreFolderSettingsInRegistry(FolderObj: MAPIFolder);
    procedure RefreshCurrentFolder(AExplorerArgs: TObject);

    procedure RegisterMessages;
    procedure OnCallBack(const key: string; const i1, i2, i3: Integer;
      const s1, s2, s3: string);
    procedure DoWebViewLoad(AExplorerArgs: TObject; AContainerHandle: HWND; AWidth,
      AHeight: integer);
    procedure DoWebViewHide(AExplorerArgs: TObject; AContainerHandle: HWND);

    function GetInspectorAdxItemType(InspectorItemType: TadxOlInspectorItemType; MailInspectorType: integer): TAdxItemType;
    function GetExplorerAdxItemType(ExplorerLayout: TadxolExplorerLayout;
      AExplorerArgs: TObject): TAdxItemType;

    procedure RefreshCurrentFolderForAllExplorers;
    procedure FreeExistentInspectors;
    procedure FreeExistentExplorers;

    procedure RegisterExplorer(AExplorerObject: _Explorer; ExplorerWindowHandle: HWND); overload;
    procedure RegisterExplorer(AExplorerArgs: TObject); overload;
    function IsRegisterExplorer(ExplorerWindowHandle: HWND): boolean;
    procedure GetRegisterExplorer(ExplorerWindowHandle: HWND; var ExplorerObj: Explorer);
    procedure GetRegisterAdxOlExplorer(ExplorerWindowHandle: HWND; var AdxOlExplorer: Pointer);

    procedure UnregisterExplorer(ExplorerWindowHandle: HWND);
    procedure DeleteExplorerForms(ExplorerWindowHandle: HWND);
    procedure HideAllForms;
    procedure DeleteAllForms;
    procedure CancelIsHiddenByDeveloperFlagForExplorerForms(AExplorerArgs: TObject);

    procedure GetRegisterOutlookInspector(InspectorWindowHandle: HWND; var InspectorObj: Inspector);
    function ValidateInspector(AAdxOlInspector: TObject): boolean;
    procedure GetRegisterAdxOlInspector(InspectorWindowHandle: HWND; var AdxOlInspector: Pointer);
    procedure GetRegisterAdxOlInspectorByEmulateWindowHandle(EmulateWindowHandle: HWND; var AdxOlInspector: Pointer);
    procedure DeleteInspectorForms(AInspectorArgs: TObject);

    procedure AddExplorerWindowsForSearching(AExplorerArgs: TObject);

    procedure AddBackStageWatchObject(AHostHandle: HWND);



    procedure ApplyToInspector(Item: TADXOlFormsCollectionItem; InspectorObj: Inspector);
    procedure ApplyToExplorer(Item: TADXOlFormsCollectionItem; ExplorerObj: Explorer);
    procedure DoApplyItemToExplorer(Item: TADXOlFormsCollectionItem; AExplorerArgs: TObject);
    procedure DoApplyItemToInspector(Item: TADXOlFormsCollectionItem; AInspectorArgs: TObject);

    function  AdxRegistryKey: string;
    function  AdxLocalRegistryKey: string;
    procedure LoadLayoutsFromRegistry;

    function ConvertLayoutToAllowedDropRegion(Layout: TadxOlExplorerLayout): TadxOlExplorerAllowedDropRegion; overload;
    function ConvertLayoutToAllowedDropRegion(Layout: TadxOlInspectorLayout): TadxOlInspectorAllowedDropRegion; overload;

    function ConvertADXOlExplorerLayoutToAdxDockPosition(Layout: TadxOlExplorerLayout): integer;
    function ConvertAdxDockPositionToADXOlExplorerLayout(DockPosition: integer): TadxOlExplorerLayout;

    function CheckInspectorAllowedDropRegion(Item: TadxOlFormsCollectionItem;
      RegionItemType: TadxItemType;
      RegionWindowLayout: TadxWindowLayout;
      DragContextInspectorItemType: TadxOlInspectorItemType;
      DragContextMailInspectorType: integer): boolean;

    function CompareInspectorAllowedDropRegionsAndAdxItemType(
      Item: TadxOlFormsCollectionItem;
      ItemType: TadxItemType;
      InspectorItemType: TadxOlInspectorItemType;
      MailInspectorType: integer): boolean; overload;

    function CompareInspectorAllowedDropRegionsAndAdxItemType(
      Item: TadxOlFormsCollectionItem;
      ItemType: TadxItemType;
      InspectorItemType: TadxOlInspectorItemType;
      MailInspectorType: integer;
      AllowedDropRegion: TadxOlInspectorAllowedDropRegion): boolean; overload;

    function CompareInspectorAllowedDropRegionsAndWindowLayout(
      Item: TadxOlFormsCollectionItem;
      WindowLayout: TadxWindowLayout): boolean; overload;

    function CompareInspectorAllowedDropRegionsAndWindowLayout(
      Item: TadxOlFormsCollectionItem;
      WindowLayout: TadxWindowLayout;
      AllowedDropRegion: TadxOlInspectorAllowedDropRegion): boolean; overload;

    function CheckExplorerAllowedDropRegion(
      Item: TadxOlFormsCollectionItem;
      RegionItemType: TadxItemType;
      RegionWindowLayout: TadxWindowLayout;
      DragContextExplorerItemType: TadxOlExplorerItemType): boolean;

    function CompareExplorerAllowedDropRegionsAndAdxItemType(
      Item: TadxOlFormsCollectionItem;
      ItemType: TAdxItemType;
      ExplorerItemType: TadxOlExplorerItemType): boolean; overload;

    function CompareExplorerAllowedDropRegionsAndAdxItemType(
      Item: TadxOlFormsCollectionItem;
      ItemType: TadxItemType;
      ExplorerItemType: TadxOlExplorerItemType;
      AllowedDropRegion: TadxOlExplorerAllowedDropRegion): boolean; overload;

    function CompareExplorerAllowedDropRegionsAndWindowLayout(
      Item: TadxOlFormsCollectionItem;
      RegionItemType: TadxItemType;
      WindowLayout: TadxWindowLayout): boolean; overload;

    function CompareExplorerAllowedDropRegionsAndWindowLayout(
      Item: TadxOlFormsCollectionItem;
      WindowLayout: TadxWindowLayout;
      AllowedDropRegion: TadxOlExplorerAllowedDropRegion): boolean; overload;

    function GetExplorerAllowedDropAdxItemType(
      AllowedDropRegion: TadxOlExplorerAllowedDropRegion;
      ExplorerItemType: TadxOlExplorerItemType): TadxItemType; overload;

    function GetInspectorAllowedDropAdxItemType(
      InspectorItemType: TadxOlInspectorItemType;
      MailInspectorType: integer): TadxItemType; overload;

    function GetExplorerAdxLayout(ExplorerAllowedDropRegion: TadxOlExplorerAllowedDropRegion): TadxWindowLayout;
    function GetInspectorAdxLayout(InspectorAllowedDropRegion: TadxOlInspectorAllowedDropRegion): TadxWindowLayout;

    procedure SaveActiveInspectorForms(var ActiveInspectorForms: array of TadxOlForm; AInspectorArgs: TObject);
    procedure ShowActiveInspectorForms(var ActiveInspectorForms: array of TadxOlForm; AInspectorArgs: TObject);

    procedure OnStartHookTransaction(WindowHandle: HWND);
    procedure OnEndHookTransaction(WindowHandle: HWND);
    procedure StartHookTransaction(WindowHandle: HWND);
    procedure EndHookTransaction(WindowHandle: HWND);

    procedure OnStartRefreshInspectorTabTransaction(WindowHandle: HWND);
    procedure OnEndRefreshInspectorTabTransaction(WindowHandle: HWND);
    procedure StartRefreshInspectorTabTransaction(WindowHandle: HWND);
    procedure EndRefreshInspectorTabTransaction(WindowHandle: HWND);
    procedure OnRefreshInspectorTab(InspectorWindowHandle: HWND; OldWindowHandle: HWND; NewWindowHandle: HWND; ItemType: TadxItemType);

    property State: pointer read FState write SetState;
    property OutlookUtils: pointer read FOutlookUtils write SetOutlookUtils;
    property COMAddInModule: TadxCOMAddInModule read GetCOMAddInModule;
    property HasWebViewPane: boolean read GetHasWebViewPane;
    property isClosingOutlookOnExplorerClose: boolean read GetisClosingOutlookOnExplorerClose;
    property ReceiverWindowHandle: HWND read GetReceiverWindowHandle;
    property HTMLFullFileName: string read GetHTMLFullFileName;
    property ReadingPaneLayout: TadxOlReadingPaneLayout read FReadingPaneLayout;
    property WasAddinInitialize: boolean read GetWasAddinInitialize;
    property DisableInCOMAddinsDialogWhenOutlookIsOpened: boolean read GetDisableInCOMAddinsDialogWhenOutlookIsOpened;
{$IFDEF ADXXOL_TRIAL}
  protected
{$ELSE}
  private
{$ENDIF}
    procedure AddExplorerWindowForSearching(HostHandle: HWND; ItemType: TAdxItemType);
    function AddWindowForWordInspectorPreviewSearching(HostHandle: HWND): TObject;
    function AddWindowForResizeControlToWatchEngine(AHostHandle:HWND; AEmulateWindowHandle: HWND; AWindowHandle: HWND): TObject;
    procedure ReceiverAddHideReadingPaneWindowMessage;
    procedure DeleteInspectorWindowsForSearching(AInspectorArgs: TObject);
    procedure RegisterInspector(AInspectorArgs: TObject);
    function IsRegisterInspector(InspectorWindowHandle: HWND): boolean;
    procedure UnregisterInspector(AInspectorArgs: TObject);
    procedure DeleteInvalidInspectors();
    procedure DeleteFormsForAbsentInspectors;
    procedure AddInspectorWindowForSearching(AInspectorArgs: TObject);
  protected
    procedure SaveDefaultFoldersEntryIDToRegistry;
  published
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LockUpdates;
    procedure UnlockUpdates;
    function GetTextEditor(InspectorObj: Inspector): ITextDocument;
    property CurrentForm: TadxOlForm read GetCurrentForm;
    property OutlookAppObj: OutlookApplication read GetOutlookAppObj;
  published
    property Items: TadxOlFormsCollection read GetItems write SetItems;
    property OnADXNewInspector: TADXOLFormsManagerNewInspector
      read FOnNewInspector write FOnNewInspector;
    property OnInitialize: TADXOLFormsManagerComponentInitialize
      read FOnComponentInitialize write FOnComponentInitialize;
    property OnADXFolderSwitch: TADXOLFormsManagerFolderSwitch
      read FOnFolderSwitch write FOnFolderSwitch;
    property OnADXBeforeFolderSwitch: TADXOLFormsManagerBeforeFolderSwitch
      read FOnBeforeFolderSwitch write FOnBeforeFolderSwitch;

    property OnADXBeforeFolderSwitchEx: TADXOLFormsManagerBeforeFolderSwitchEx
      read FOnBeforeFolderSwitchEx write FOnBeforeFolderSwitchEx;
    property OnADXFolderSwitchEx: TADXOLFormsManagerFolderSwitchEx
      read FOnFolderSwitchEx write FOnFolderSwitchEx;
    property OnADXBeforeFormInstanceCreate: TadxolFormsManagerBeforeFormInstanceCreate
      read FOnBeforeFormInstanceCreate write FOnBeforeFormInstanceCreate;
    property OnADXBeforeFormInstanceCreateEx: TadxolFormsManagerBeforeFormInstanceCreateEx
      read FOnBeforeFormInstanceCreateEx write FOnBeforeFormInstanceCreateEx;


    property OnADXReadingPaneHide: TadxolFormsManagerReadingPaneHide
      read FOnReadingPaneHide write FOnReadingPaneHide;
    property OnADXReadingPaneShow: TadxolFormsManagerReadingPaneShow
      read FOnReadingPaneShow write FOnReadingPaneShow;
    property OnADXReadingPaneMove: TadxolFormsManagerReadingPaneMove
      read FOnReadingPaneMove write FOnReadingPaneMove;

    property OnADXNavigationPaneHide: TadxolFormsManagerNavigationPaneHide
      read FOnNavigationPaneHide write FOnNavigationPaneHide;
    property OnADXNavigationPaneShow: TadxolFormsManagerNavigationPaneShow
      read FOnNavigationPaneShow write FOnNavigationPaneShow;
    property OnADXNavigationPaneMinimize: TadxolFormsManagerNavigationPaneMinimize
      read FOnNavigationPaneMinimize write FOnNavigationPaneMinimize;

    property OnADXTodoBarHide: TadxolFormsManagerTodoBarHide
      read FOnTodoBarHide write FOnTodoBarHide;
    property OnADXTodoBarShow: TadxolFormsManagerTodoBarShow
      read FOnTodoBarShow write FOnTodoBarShow;
    property OnADXTodoBarMinimize: TadxolFormsManagerTodoBarMinimize
      read FOnTodoBarMinimize write FOnTodoBarMinimize;
    property OnADXBeforeAccessProtectedObject: TNotifyEvent
      read FOnADXBeforeAccessProtectedObject
      write FOnADXBeforeAccessProtectedObject;
    property OnADXAfterAccessProtectedObject: TNotifyEvent
      read FOnADXAfterAccessProtectedObject
      write FOnADXAfterAccessProtectedObject;
    property OnError: TadxolFormsManagerError
      read FOnError write FOnError;
  end;

  TADXOlFormClass = class of TadxOlForm;

var
  adxOlForm: TadxOlForm;

  function Log: ILog;

implementation


{$R adxolForm.dfm}

uses Math, ShlObj, Contnrs, Registry;

var
  FormsManagerSingleton: TadxOlFormsManager;
  TMoveReadingPaneWindowWatchObject_SetRedrawWindow: HWND;

const
  //AdxDockPosition
  dpDockLeft = 0;
  dpDockTop = 1;
  dpDockRight = 2;
  dpDockBottom = 3;



function AdxShowYesNoError(Mess: string; Caption: string): integer;
begin
  if FormsManagerSingleton.DisableInCOMAddinsDialogWhenOutlookIsOpened then begin
    //Dialog cannot be shown when another modal window is open
    Log.AddWarning('AdxShowYesNoError: Dialog cannot be shown when another modal window is open.');
    result := 0;
  end
  else begin
    result := MessageBox(0, PChar(Mess), PChar(Caption), MB_YESNO or MB_ICONERROR or MB_APPLMODAL);
  end;
end;

procedure AdxShowError(Mess: string; Caption: string);
begin
  MessageBox(0, PChar(Mess), PChar(Caption), MB_OK or MB_ICONERROR or MB_APPLMODAL);
end;

function ProductVersionAndPackage: string;
var
  r: TRegistry;
begin
  try
    result := 'Unknown';
    r := TRegistry.Create(KEY_READ);
    try
      r.RootKey := HKEY_LOCAL_MACHINE;
      if r.OpenKeyReadOnly('Software\Add-in Express\InstalledProducts\Add-in Express 2007 for VCL\Plugins\ADX Extensions VCL for Microsoft Outlook') then begin
        if r.ValueExists('Version') then begin
          result := r.ReadString('Version');
          {$IFDEF ADXXOL_TRIAL}
          result := result + ' Trial';
          {$ENDIF}
        end;
        r.CloseKey;
      end;
    finally
      r.Free;
    end;
  except
    result := EmptyStr;
  end;
end;

function Log: ILog;
begin
  result := adxWSbcls.Log;
end;

var
  WM_ADXDELETEEMULATEWINDOW,
  WM_ADXWMIPOSCHANGE,
  WM_ADXEXIST,
  WM_ADXHIDEALLREGIONFORMS,
  WM_ADXEXISTSERVICEFORM,
  WM_ADX_CLOSE_READINGPANE_SERVICE_FORM,
  //WM_ADX_REFRESH_INSPECTOR_TAB,
  WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM,
  WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR,
  WM_ADXGETAPPWINDOWPOS,
  WM_INFORMTOSHOWDOCKLAYOUT,
  WM_REFRESHFOLDER

  : dword;


type

  TInternalAdxCOMAddInModule = class(TadxCOMAddInModule);

  TDebug = class
  public
    class procedure WriteLine(s: string);
  end;

  TadxFormProtected = class(TadxForm)
  end;

  TadxOlCauseInspectorFormShowing = (
    ciNewInspector,
    ciChangingWordInspectorHandle,
    ciPreviewOff,
    ciInspectorActivate,
    ciItemApplyMethod,
    ciFormShowMethod,
    ciChangingItemLayout,
    ciRefreshInspectorTab
  );


const
  //TVisibleState
  vsUnknown   = -1;
  vsUnvisible =  0;
  vsVisible   =  1;
  vsMinimize  =  2;

type
  TChangedPropertySet = integer;
const
  chpFolderName = $0001;
  chpFolderNames = $0002;
  chpInspectorMessageClass = $0004;
  chpInspectorMessageClasses = $0008;
  chpExplorerMessageClass = $0010;
  chpExplorerMessageClasses = $0020;
  chpExplorerItemTypes = $0040;
  chpInspectorItemTypes = $0080;
  chpInspectorLayout = $0100;
  chpEnabled = $0200;
  chpCached = $0400;
  chpExplorerLayout = $0800;
  chpSplitter = $1000;
  chpFormClassName = $2000;
  chpInspectorMode = $4000;

const //Classes

  InspectorCaptionGuid: string = 'ADE6F0D5-0005-406d-B0BF-F9879F100001';
  SubPaneContainerExplorerCaption: string  = 'ADE6F0D5-0005-406d-B0BF-F9879F200001';
  SubPaneContainerInspectorCaption: string  = 'ADE6F0D5-0005-406d-B0BF-F9879F300001';
  SubPaneContainerReadingPaneCaption: string = '{ADE6F0D5-0005-406d-B0BF-F9879F400001}';

  WM_RESIZE_TAB: String  = 'WM_RESIZE_TAB';
  WM_DELETE_PROC_IN_HOOKS_CHAIN: String  = 'WM_DELETE_PROC_IN_HOOKS_CHAIN';

  DTT_GRAYED         = 1;

  HTTB_BACKGROUNDSEG = 0;
  HTTB_FIXEDBORDER   = 2;
  HTTB_CAPTION       = 4;

  HTTB_RESIZINGBORDER_LEFT   = $0010;
  HTTB_RESIZINGBORDER_TOP    = $0020;
  HTTB_RESIZINGBORDER_RIGHT  = $0040;
  HTTB_RESIZINGBORDER_BOTTOM = $0080;
  HTTB_RESIZINGBORDER        = $00F0; // all above constants OR'ed

  // Resizing border is specified as a template, not just window edges.
  HTTB_USESIZINGTEMPLATE     = $0100;

  DTL_LEFT   = 1;
  DTL_TOP    = 2;
  DTL_RIGHT  = 4;
  DTL_BOTTOM = 8;

  MAX_INTLIST_COUNT = 10;

  PO_STATE   = 0;       // property was found in the state section
  PO_PART    = 1;       // property was found in the part section
  PO_CLASS   = 2;       // property was found in the class section
  PO_GLOBAL  = 3;       // property was found in [globals] section
  PO_NOTFOUND= 4;       // property was not found

  STAP_ALLOW_NONCLIENT = 1;
  STAP_ALLOW_CONTROLS  = 2;
  STAP_ALLOW_WEBCONTENT= 4;

  SZ_THDOCPROP_DISPLAYNAME   = 'DisplayName';
  SZ_THDOCPROP_CANONICALNAME = 'ThemeName';
  SZ_THDOCPROP_TOOLTIP       = 'ToolTip';
  SZ_THDOCPROP_AUTHOR        = 'author';

  WM_THEMECHANGED = $031A; // this constant get by WinSight.

  TS_MIN = 0;
  TS_TRUE = 1;
  TS_DRAW = 2;

  themelib = 'uxtheme.dll';

const
  adxolErrorCantContain = 'The %s class cannot be contained in the %s class.';
  adxolErrorCantContainEmptyParam = 'The %s param cannot be nil.';
  adxolErrorSecondComponent = 'It isn''t possible to place second %s component!';

  ADXXOL = 'ADXXOL';
  WebView = 'WebView';
  EMPTY = 'EMPTY';
  extID = '{441D6D15-71C6-43f7-89AF-B56EA1516DAE}';
  DisconnectFlag = 'disconnect';
  WebViewLoadFlag = 'load';
  WebViewHideFlag = 'hide';
  RedirectFlag = 'redirect';

  { Error messages }
  adxolECode = 31100;
  adxolECodeCantContain = adxolECode + 1;

type

  TADXXOlExceptionManager = class(TadxExceptionManager)
    procedure InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string); override;
  end;

  TOutlookAppWindowBehaviour = class(TAppWindowBehaviour)
  protected
    //See TAppWindowBehaviour.GetSingleton.WM_DESTROY
  end;

  TFindOutlookWindowObject = class(TFindWindowObject)
  private
    FDependentOnSocialConnector: boolean;
    FSocialConnectorAddinConnected: boolean;
  protected
    property DependentOnSocialConnector: boolean read FDependentOnSocialConnector;
    property SocialConnectorAddinConnected: boolean read FSocialConnectorAddinConnected;
  public
    constructor Create(AHostVersion: TadxHostVersion; ASocialConnectorAddinConnected: boolean); overload;
    constructor Create(AHostVersion: TadxHostVersion); overload;
  end;

  TOfficeTaskPaneFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;

    function IsDockRight(Condition: TadxFindWindowConditions): boolean;
    function IsDockLeft(Condition: TadxFindWindowConditions): boolean;
    function IsDockTop(Condition: TadxFindWindowConditions): boolean;
    function IsDockBottom(Condition: TadxFindWindowConditions): boolean;
  public
    class function FindWindow(AHostVersion: TadxHostVersion; HostHandle: HWND; WindowLayout: TadxWindowLayout): HWND;


  end;


  TToDoBarFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindToDoBar2010(HostHandle: HWND; SetRedrawWindow: HWND; var Location: TToDoBar2010Location): HWND;
    class function WindowIsHorizontalStrip(WindowHandle: HWND): boolean;
    class function MinimizedToDoBar(WindowHandle: HWND): boolean;
    function FindNetUINativeHWNDHost(HostHandle: HWND): HWND;
    function InternalExistsChildWindow(Handle: HWND): boolean;
  end;

  TDefaultInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TMailInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TWordMailInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TEnvelopeCommandBarForWordInspectorPreviwControlFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TAppointmentInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TTaskInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TContactInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TJournalInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TReportInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TSharingInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TMobileInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TDistributionListInspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;


  TMeetingIspectorFinder = class(TFindOutlookWindowObject)
    function FindIn2000(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2002(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2003(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2007(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
    function FindIn2010(HostHandle: HWND; Condition: TadxFindWindowConditions): HWND; override;
  end;

  TFindOutlookWindowFactory = class(TFindWindowFactory)
  private
    function GetHostVersion: TadxHostVersion;
    function GetSocialConnectorAddinConnected: boolean;
  protected
    function CreateSpecificFindWindowObject(ItemType: TadxItemType): TFindWindowObject; override;
  public
    property HostVersion: TadxHostVersion read GetHostVersion;
    property SocialConnectorAddinConnected: boolean read GetSocialConnectorAddinConnected;
  end;

  TCustomWindowMessage = class;
  TMoveReadingPaneWindowMessage = class;

  TStoppingWatchObjectEventHandler = procedure(WatchObject: TWatchObject) of object;

{$IFDEF LOHICA}
  TFindNewNoRegisterInspectorWatchObject = class(TWatchObject)
  protected
    procedure DoExecute; override;
  public
    constructor Create(AInspectors: Inspectors; AFormsManager: TadxolFormsManager);
  end;
{$ENDIF}


  THostHandleWatchObject = class(TWatchObject)
  protected
    FHostHandle: HWND;
    function GetHostHandle: HWND; override;
    function GetWindowHandle: HWND; override;
  public
    procedure UpdateHostHandle(AHostHandle: HWND);
  end;

  TMoveReadingPaneWindowWatchObject = class(THostHandleWatchObject)
  private
    FHostVersion: integer;
    FMoveReadingPaneWindowMessage: TMoveReadingPaneWindowMessage;
    FReadingPaneWindowHandle: HWND;
    FMsoDockTopWindowHandle: HWND;
    RightLayout: integer; // = 7221;
    ButtonLayout: integer; // = 7222;
    ReadingPaneLayout: TadxOlReadingPaneLayout; // = 0;
    ReadingPaneLayoutInitialized: boolean;
    procedure SetLayout;
    function EmptySize(Handle: HWND): boolean;
  protected
    SetRedrawWindow: HWND;
    ReadingPaneHandleThatGetWMSETREDRAW: HWND;
    procedure DoExecute; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;

  public
    class function CurrentLayout(HostVersion: integer; ReadingPaneWindowHandle: HWND; MsoDockTopWindowHandle: HWND): TadxOlReadingPaneLayout;
    constructor Create(HostVersion: integer; ReceiverHandle: HWND;
            HostHandle: HWND;
            ReadingPaneWindowHandle: HWND;
            MsoDockTopWindowHandle: HWND);
    destructor Destroy; override;
    class procedure SetSetRedrawWindow(window: HWND);
    class function GetSetRedrawWindow: HWND;
  end;

  IHandleFinder = interface
    //['{680A30A3-625D-4963-8B4E-9A37303EA245}']
    function GetAppWindowHandle(HostVersion: integer; ItemType: integer; HostHandle: HWND): HWND;
  end;

  TOutlookHandleFinder =  class(TInterfacedObject, IHandleFinder)
  public
    function GetAppWindowHandle(HostVersion: integer; ItemType: integer; HostHandle: HWND): HWND;
    function GetMsoDockTopWindowHandle(HostVersion: integer; HostHandle: HWND): HWND;
  end;

  TWordInspectorPreviewOnMessage = class;
  TWordInspectorPreviewOffMessage = class;

  TWordInspectorPreviewWatchObject = class(THostHandleWatchObject)
  private
    FHandleFinder: TOutlookHandleFinder;
    FPreviewOnMessage: TWordInspectorPreviewOnMessage;
    FPreviewOffMessage: TWordInspectorPreviewOffMessage;
    WindowHandle: HWND;
    VisibleState: TVisibleState;
    ItemType: Integer;
    HostVersion: Integer;

    FEmulateWindowHandle: HWND;
    FResizeWindowHandle: HWND;
    function GetVisibleState(AWindowHandle: HWND; AHostHandle: HWND; AHostVersion: integer; AItemType: integer): TVisibleState;
    procedure SetEmulateData(AEmulateWindowHandle: HWND; AResizeWindowHandle: HWND);
    procedure ClearEmulateData;
  protected
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(
            AHandleFinder: TOutlookHandleFinder;
            APreviewOnMessage: TWordInspectorPreviewOnMessage;
            APreviewOffMessage: TWordInspectorPreviewOffMessage;
            AHostHandle: HWND;
            AHostVersion: integer);

    destructor Destroy; override;
    procedure DoExecute; override;
  end;

  TFormsManagerProcedure = procedure of object;

  TFormsManagerThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TControlResizeWindowWatchObject = class(THostHandleWatchObject)
  private
    FEmulateWindowHandle: HWND;
    FWindowHandle: HWND;
    FReceiverWindowHandle: HWND;
    FWasFoundWindowHandle: boolean;
    FPriorWindowRect: TRect;
  protected
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;

  public
    constructor Create(AHostHandle: HWND;
      AEmulateWindowHandle: HWND;
      AWindowHandle: HWND;
      AReceiverWindowHandle: HWND);

    procedure DoExecute; override;
    procedure SendSizeToEmulateWindow(APostMessage: boolean);
    procedure NotifyRemoveControlledResizeWindow;
    property WasFoundWindowHandle: boolean read FWasFoundWindowHandle;
    property EmulateWindowHandle: HWND read FEmulateWindowHandle;
    property WindowHandle: HWND read FWindowHandle;
    property ReceiverWindowHandle: HWND read FReceiverWindowHandle;
  end;

  TVisibleChangeWindowMessage = class;
  TVisibleChangeWindowWatchObject = class(THostHandleWatchObject)
  protected
    FHandleFinder: TOutlookHandleFinder;
    FShowWindowMessage: TVisibleChangeWindowMessage;
    FHideWindowMessage: TVisibleChangeWindowMessage;

    WindowHandle: HWND;
    VisibleState: TVisibleState;
    ItemType: Integer;
    HostVersion: Integer;
    FindCount: integer;
    SetRedrawWindow: HWND;

    function NeedFindHandle(AWindowHandle: HWND;
      AVisibleState: TVisibleState;
      AHostVersion: Integer): boolean; virtual;
    class function OutlookWindowEmptySize(AWindowHandle: HWND; AHostVersion: integer; AItemType: integer): boolean;
    class function SubclassedEmptySize(windowHandle: HWND; currentState: boolean): boolean;
    function EmptySize(AWindowHandle: HWND; AHostVersion: integer; AItemType: integer): boolean; virtual;
    function GetVisibleState(AWindowHandle, AHostHandle: HWND; AHostVersion: Integer; AItemType: integer): TVisibleState; virtual;
    procedure SetVisibleState(var CurrentVisibleState: TVisibleState; AWindowHandle, AHostHandle: HWND; AHostVersion: Integer; AItemType: integer); virtual;
    procedure DoExecute; override;
    function SendShowMessageSync(wParam, lParam: integer): integer; virtual;
    function SendHideMessageSync(wParam, lParam: integer): integer; virtual;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); override;//IProcessHookEvent
  public
    constructor Create(AHandleFinder: TOutlookHandleFinder;
      AShowWindowMessage, AHideWindowMessage: TVisibleChangeWindowMessage;
      AHostHandle: HWND; AItemType: Integer; AHostVersion: Integer); virtual;
    destructor Destroy; override;
  end;

  TNavigationPaneVisibleChangeWindowWatchObjectV2010 = class(TVisibleChangeWindowWatchObject)
  protected
    procedure DoExecute; override;
    function SendShowMessageSync(wParam, lParam: integer): integer; override;
    function SendHideMessageSync(wParam, lParam: integer): integer; override;

    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;

  end;

  TFolderListVisibleChangeWindowWatchObjectV2010 = class(TVisibleChangeWindowWatchObject)
  protected
    procedure DoExecute; override;
    function SendShowMessageSync(wParam, lParam: integer): integer; override;
    function SendHideMessageSync(wParam, lParam: integer): integer; override;

    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  end;

  TOutlookBarVisibleChangeWindowWatchObjectV2010 = class(TVisibleChangeWindowWatchObject)
  protected
    procedure DoExecute; override;
    function SendShowMessageSync(wParam, lParam: integer): integer; override;
    function SendHideMessageSync(wParam, lParam: integer): integer; override;

    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  end;

  TReadingPaneVisibleChangeWindowWatchObjectV2010 = class(TVisibleChangeWindowWatchObject)
  protected
    ReadingPaneHandleThatGetWMSETREDRAW: HWND;
    procedure DoExecute; override;
    function SendShowMessageSync(wParam, lParam: integer): integer; override;
    function SendHideMessageSync(wParam, lParam: integer): integer; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(AHandleFinder: TOutlookHandleFinder;
      AShowWindowMessage, AHideWindowMessage: TVisibleChangeWindowMessage;
      AHostHandle: HWND; AItemType: Integer; AHostVersion: Integer); override;

  end;

  TBackStageVisibleChangeWindowWatchObjectV2010 = class(THostHandleWatchObject)
  protected
    FHostVersion: integer;
    BackStageVisible: boolean;
    procedure DoExecute; override;
    procedure DoShowBackStage(ExplorerHandle: HWND);
    procedure DoHideBackStage(ExplorerHandle: HWND);
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); override;//IProcessHookEvent

  public
    constructor Create(AHostHandle: HWND; AHostVersion: Integer);

  end;

  THideWindowMessage = class;
  TWordEditorHideMessage= class;

  TControlHideWindowWatchObject = class(THostHandleWatchObject)
  private
    FWindowHandle: HWND;
    FItemType: integer;
    FReceiverWindowHandle: HWND;
    HideWindowMessage: THideWindowMessage;
    WordEditorHideMessage: TWordEditorHideMessage;
  protected
    procedure DoExecute; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(
      AHostHandle: HWND;
      AWindowHandle: HWND;
		  AItemType: integer;
		  AReceiverWindowHandle: HWND);
    destructor Destroy; override;

    property WindowHandle: HWND read FWindowHandle;
    property ItemType: integer read FItemType;
    property ReceiverWindowHandle: HWND read FReceiverWindowHandle;
  end;


  TRefreshInspectorTabWatchObject = class(THostHandleWatchObject)
  private
    FHostHandle: HWND;
    FItemType: Integer;
    function GetHostVersion: TadxHostVersion;
    function GetCurrentWindowHandle: HWND;
    procedure SetCurrentWindowHandle(const Value: HWND);
  protected
    Finder: TFindWindowObject;
    FCurrentWindowHandle: HWND;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); override;//IProcessHookEvent
    procedure DoExecute; override;
    property HostVersion: TadxHostVersion read GetHostVersion;
    property CurrentWindowHandle: HWND read GetCurrentWindowHandle write SetCurrentWindowHandle;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(ReceiverHandle: HWND; AHostHandle: HWND; AItemType: Integer);
    destructor Destroy; override;
  end;

  TTodoBarOutlook2010WatchObject = class(THostHandleWatchObject)
  private
    Finder: TToDoBarFinder;
    CurrentLocation: TToDoBar2010Location;
    PriorEvent: TToDoBar2010Location;
    CurrentWindowHandle: HWND;
    PriorWindowHandle: HWND;
    PriorLocation: TToDoBar2010Location;
    Host2010WasShowed: boolean;
    function ExistsHostHandle: boolean;

    function MinimizedToDoBar(Location: TToDoBar2010Location): boolean;
    function OffToDoBar(Location: TToDoBar2010Location): boolean;
    function NormalToDoBar(Location: TToDoBar2010Location): boolean;
    function NoWindowForSubclasiing(Location: TToDoBar2010Location): boolean;
    procedure UpdatePriorInformation();

    procedure PrintLocation(Location: TToDoBar2010Location; sufix: string);


    procedure Show;
    procedure Hide;
    procedure Minimize;
  protected
    SetRedrawWindow: HWND;
    procedure DoExecute; override;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); override;//IProcessHookEvent

    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(AHostHandle: HWND);
    destructor Destroy; override;
  end;

  TVisibleMinimizeUnvisibleChangeWatchObject = class(THostHandleWatchObject)
  protected
    FHost2010WasShowed: boolean;
    FHandleFinder: TOutlookHandleFinder;
    FShowWindowMessage: TVisibleChangeWindowMessage;
    FHideWindowMessage: TVisibleChangeWindowMessage;
    FMinimizeWindowMessage: TVisibleChangeWindowMessage;

    WindowHandle: HWND;
    VisibleState: TVisibleState;
    ItemType: Integer;
    HostVersion: Integer;
    FindCount: integer;
    SetRedrawWindow: HWND;
    function NeedFindHandle(AWindowHandle: HWND;
      AVisibleState: TVisibleState;
      AHostVersion: Integer): boolean; virtual;
    class function OutlookWindowEmptySize(AWindowHandle: HWND; AHostVersion: integer; AItemType: integer): boolean;
    class function OutlookWindowMinimizeSize(AWindowHandle: HWND; AHostVersion: integer; AItemType: integer): boolean;
    function GetVisibleState(AWindowHandle, AHostHandle: HWND; AHostVersion: Integer; AItemType: integer): TVisibleState; virtual;
    function ExistsHostHandle: boolean; virtual;
    procedure DoExecute; override;
    function SendShowMessage(wParam, lParam: integer): integer; virtual;
    function SendHideMessage(wParam, lParam: integer): integer; virtual;
    function SendMinimizeMessage(wParam, lParam: integer): integer; virtual;
    procedure ProcessHookEvent(hWnd: THandle; Msg: UINT; wParam, lParam: Longint); override;//IProcessHookEvent

    function SendHideMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; virtual;
    function SendShowMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; virtual;
    function SendMinimizeMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; virtual;

  public
    constructor Create(AHandleFinder: TOutlookHandleFinder;
      AShowWindowMessage, AHideWindowMessage, AMinimizeWindowMessage: TVisibleChangeWindowMessage;
      AHostHandle: HWND; AItemType: Integer; AHostVersion: Integer);
    destructor Destroy; override;
  end;

  TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010 = class(TVisibleMinimizeUnvisibleChangeWatchObject)
  protected
    procedure DoExecute; override;
    function SendHideMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    function SendShowMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    function SendMinimizeMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  end;

  TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010 = class(TVisibleMinimizeUnvisibleChangeWatchObject)
  protected
    procedure DoExecute; override;
    function SendHideMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    function SendShowMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    function SendMinimizeMessageSync(wParam, lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  end;

  TShowChildWindowMessage = class;

  TShowChildWindowWatchObject = class(TWatchObject)
  private
    FHandleFinder: TOutlookHandleFinder;
    FShowChildWindowMessage: TShowChildWindowMessage;
    FHostHandle: HWND;
    FHostVersion: integer;
    FItemType: integer;

    function EmptySize(Handle: HWND): boolean;
  protected
    FRequiredWindowHandle: HWND;
    FVisibleState: integer;
    FInitialVisibleState: integer;
    MakePostMessage: bool;
    procedure DoExecute; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;
  public
    constructor Create(HandleFinder: TOutlookHandleFinder;
            ReceiverHandle: HWND;
            HostHandle: HWND;
            HostVersion: integer;
            ItemType: integer;
            AMakePostMessage: boolean);
    destructor Destroy; override;
  end;

  TShowChildWindowWatchObjectInAnyMailInspector = class(TWatchObject)
  private
    FHandleFinder: TOutlookHandleFinder;
    FShowChildWindowMessage: TShowChildWindowMessage;
    FHostHandle: HWND;
    FHostVersion: integer;
    FItemType: integer;

    function EmptySize(Handle: HWND): boolean;
  protected
    FRequiredWindowHandle: HWND;
    FVisibleState: integer;
    FInitialVisibleState: integer;
    MakePostMessage: bool;
    procedure DoExecute; override;
    procedure START_WM_SETREDRAW(window: HWND); override;
    procedure END_WM_SETREDRAW(window: HWND); override;

  public
    constructor Create(HandleFinder: TOutlookHandleFinder;
            ReceiverHandle: HWND;
            HostHandle: HWND;
            HostVersion: integer);
    destructor Destroy; override;
  end;

  TadxOlFormsManagerList = class(TList)
  private
    FOwner: TObject;
  public
    function CountClasses(AClassType: TClass): integer;
    procedure Clear; override;
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    property Owner: TObject read FOwner;
  end;

  TadxOlRegisterInspectorList = class(TadxOlFormsManagerList)
  public
    procedure DeleteByInspectorWindowHandle(InspectorWindowHandle: HWND);
    procedure Delete(Index: Integer);
  end;

  TadxOlRegisterExplorerList = class(TadxOlFormsManagerList)
  public
    procedure DeleteByExplorerWindowHandle(ExplorerWindowHandle: HWND);
    procedure Delete(Index: Integer);
  end;


  TWindowEvent = procedure(HostHandle: HWND; ItemType: TAdxItemType) of object;
  TDeleteEmulateWindowEvent = procedure(HostHandle: HWND; EmulateWindowHandle: HWND) of object;


  TWatchEngine = class(TThread)
  private
    FWatchObjects: TList;
    FReceiverHandle: HWND;
    PrepareDeleteHandles: array of HWND;
    procedure InternalExecuteObjects;
    procedure InternalDeleteByHostHandle(HostHandle: HWND);
    procedure InternalDeleteStoppedObjects;
    procedure InternalProcessPrepareDeleteHandles;

  public
    procedure Add(WatchObject: TWatchObject);
    procedure DeleteByHostHandle(HostHandle: HWND);

    constructor CreateEx(AReceiverHandle: HWND);
    destructor Destroy; override;

  protected
    procedure Execute; override;
    procedure Run;
  end;

  TCustomWindowMessage = class
  private
    FReceiverHandle: HWND;
    FRegisterMessageName: string;
    FMessageID: cardinal;
    procedure RegisterMessage(AMessageName: string);
    function GetMessageID: cardinal;
    function GetRegisterMessageName: string;
    function GetSynchronize: boolean;
  protected
    FSynchronize: boolean;
    function GetMessageName: string; virtual; abstract;
    function ProcessMessage(wParam: integer; lParam: integer): integer; virtual; abstract;
  public
    StopProcess: boolean;
    constructor Create(ReceiverHandle: HWND);
    function SendMessage(wParam: integer; lParam: integer): integer;
    function SendMessageSync(wParam: integer; lParam: integer; hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer;
    procedure PostMessage(wParam: integer; lParam: integer);
    function DoProcessMessage(wParam: integer; lParam: integer): integer;
    property MessageName: string read GetRegisterMessageName;
    property MessageID: cardinal read GetMessageID;
    property Synchronize: boolean read GetSynchronize;
  end;

  TCloseServiceFormForNotWordInspectorMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TInformToShowDockLayoutMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TCloseFolderViewServiceFormMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TCloseReadingPaneServiceFormMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TDestroyEmbededWindowMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TRegionCloseButtonClickMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TStartTransactionMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TCTPVisibleChangedMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TRefreshFolderMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  TEndTransactionMessage = class(TCustomWindowMessage)
  private
    FFormsManager: TadxOlFormsManager;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
    destructor Destroy; override;
  end;

  THideReadingPaneWindow = procedure(HostHandle: HWND; ItemType: TADXItemType) of object;
  THideReadingPaneWindowFromSBCLSMessage = class(TCustomWindowMessage)
  private
    FHandler: THideReadingPaneWindow;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: THideReadingPaneWindow);
    destructor Destroy; override;
  end;

  TMoveReadingPaneWindow = procedure(HostHandle: HWND; ItemType: TADXItemType; ReadingPaneLayout: TadxOlReadingPaneLayout) of object;
  TMoveReadingPaneWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TMoveReadingPaneWindow;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TMoveReadingPaneWindow);
    destructor Destroy; override;
  end;

  TVisibleChangeWindow = procedure(HostHandle: HWND; ItemType: TADXItemType) of object;
  TVisibleChangeWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TVisibleChangeWindow;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TVisibleChangeWindow);
    destructor Destroy; override;
  end;

  TWordInspectorPreviewOnMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TWordEditorHideMessage = class(TCustomWindowMessage)
  private
    FHandler: TWindowEvent;
  protected
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TWindowEvent);
    function GetMessageName: string; override;
  end;

  TShowSearchWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TWindowEvent;
  protected
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TWindowEvent);
    function GetMessageName: string; override;
  end;

  THideSearchWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TWindowEvent;
  protected
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TWindowEvent);
    function GetMessageName: string; override;
  end;

  THideWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TWindowEvent;
  protected
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TWindowEvent);
    function GetMessageName: string; override;
  end;

  TDeleteEmulateWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TDeleteEmulateWindowEvent;
  protected
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; Handler: TDeleteEmulateWindowEvent);
    function GetMessageName: string; override;
  end;

  TWordInspectorPreviewOffMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowNavigationPaneMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  THideNavigationPaneMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TMinimizeNavigationPaneMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowReadingPaneMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  THideReadingPaneMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowOutlookBarMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  THideOutlookBarMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowTodoBarMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  THideTodoBarMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TMinimizeTodoBarMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowFolderListMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  THideFolderListMessage = class(TVisibleChangeWindowMessage)
  protected
    function GetMessageName: string; override;
  end;

  TShowChildWindow = procedure(HostHandle: HWND; ItemType: TADXItemType) of object;
  TShowChildWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TShowChildWindow;
    FHostHandle: HWND;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; HostHandle: HWND; Handler: TShowChildWindow);
    destructor Destroy; override;
  end;

  TRemoveControlledResizeWindow = procedure(HostHandle: HWND; EmulateWindowHandle: HWND) of object;
  TRemoveControlledResizeWindowMessage = class(TCustomWindowMessage)
  private
    FHandler: TRemoveControlledResizeWindow;
  protected
    function GetMessageName: string; override;
  public
    function ProcessMessage(wParam: integer; lParam: integer): integer; override;
    constructor Create(ReceiverHandle: HWND; AHandler: TRemoveControlledResizeWindow);
    destructor Destroy; override;
  end;

type

  TadxolCodeContext = (ccInitialize, ccNewInspector, ccChangingInspectorWindowHandle, ccInspectorClose, ccInspectorActivate, ccUnregisterInspector,
    ccNewExplorer, ccExplorerClose, ccFolderEvent, ccWebViewProcess, ccRefreshInspectorTab);

  TadxolMailPostInspectorType = (mitUnknown, mitStandard, mitWordEditor);

  TadxOlExplorerArguments = class
  private
    FFormsManager: TadxOlFormsManager;
    FExplorerObj: Explorer;
    FExplorerWindowHandle: HWND;
    FFolderObj: MAPIFolder;
    FFolderEntryID: string;
    FFullFolderName: string;
    FFolderDefaultItemType: TOleEnum;
    FExplorerItemType: TadxolExplorerItemType;
    FMessageClass: string;
    FAdxWebViewURLForFolder: boolean;
    FSuperGridServiceForm: TadxOlForm;
    FReadingPaneServiceForm: TadxOlForm;
    FWebViewOn: boolean;
    FReadingPaneLayout: TadxOlReadingPaneLayout;
    procedure InitFolderProperties(AFormsManager: TadxOlFormsManager);
    procedure InitializeServiceForms(AFormsManager: TadxOlFormsManager);
    procedure InitReadingPaneLayout(AFormsManager: TadxOlFormsManager);
    function GetReadingPaneLayout: TadxOlReadingPaneLayout;
  public
    constructor Create(AFormsManager: TadxOlFormsManager; const AExplorerObj: Explorer;
      CodeContext: TadxolCodeContext);
    constructor CreateWithFolder(AFormsManager: TadxOlFormsManager; const AExplorerObj: Explorer;
      AFolderObj: MAPIFolder; CodeContext: TadxolCodeContext);
    destructor Destroy; override;
    procedure RefreshServiceForms(AFormsManager: TadxOlFormsManager);
    function CheckCompatibilityWithSocialConnectorAddin: boolean;
    function GetServiceForm(ExplorerLayout: TadxolExplorerLayout): TadxForm;
    property ExplorerObj: Explorer read FExplorerObj;
    property ExplorerWindowHandle: HWND read FExplorerWindowHandle;
    property FolderObj: MAPIFolder read FFolderObj;
    property AdxWebViewURLForFolder: boolean read FAdxWebViewURLForFolder;
    property FolderEntryID: string read FFolderEntryID;
    property FullFolderName: string read FFullFolderName;
    property FolderDefaultItemType: TOleEnum read FFolderDefaultItemType;
    property ExplorerItemType: TadxolExplorerItemType read FExplorerItemType;
    property MessageClass: string read FMessageClass;

    property ReadingPaneServiceForm: TadxOlForm read FReadingPaneServiceForm;
    property FolderViewServiceForm: TadxOlForm read FSuperGridServiceForm;
    property WebViewOn: boolean read FWebViewOn;
    property ReadingPaneLayout: TadxOlReadingPaneLayout read GetReadingPaneLayout;
  end;

  TadxOlInspectorArguments = class
  private
    FWindowHandle: HWND;
    FCodeContext: TadxolCodeContext;
    FInspectorObj: Inspector;
    FInspectorWindowHandle: HWND;
    FParentFolderObj: MAPIFolder;
    FItemObj: IDispatch;
    FItemClass: integer;
    FMessageClass: string;
    FParentFullFolderName: string;
    FInspectorItemType: TadxolInspectorItemType;
    FInspectorMode: TadxolInspectorMode;
    FInspectorItemTypeCaption: string;
    FParentFolderEntryID: string;
    FChangingInspectorWindowHandle: boolean;
    FMailPostInspectorType: TadxolMailPostInspectorType;
    FIsMailPost: boolean;
    FClientSubpaneServiceForm: TadxOlForm;
    function GetIsWordMailInspector: boolean;
    procedure SetMailPostInspectorType(const Value: TadxolMailPostInspectorType);
    procedure InitMailPostInspectorType(AFormsManager: TadxOlFormsManager; AInspectorItemType: TadxolInspectorItemType);
    procedure InitializeServiceForms(AFormsManager: TadxOlFormsManager; InspectorWindowHandle: HWND);
    procedure SetItemObj(AFormsManager: TadxOlFormsManager);
    procedure SetParentFolderObject;
    procedure SetItemClass(AFormsManager: TadxOlFormsManager);
    class function GetInspectorMode(AInspectorObj: Inspector;
    InspectorWindowHandle: HWND; ItemObj: IDispatch;
    OutlookVersion: TadxolOutlookVersion): TadxolInspectorMode;
    procedure SetInspectorMode;
    function GetContextInspectorAdxItemType: TadxItemType;
    function GetWindowHandle: HWND;
    procedure SetWindowHandle(const Value: HWND);
  public
    constructor Create(AFormsManager: TadxOlFormsManager; AInspectorObj: Inspector;
      AInspectorWindowHandle: HWND; CodeContext: TadxolCodeContext);
    destructor Destroy; override;
    function GetServiceForm(InspectorLayout: TadxolInspectorLayout): TadxOlForm;
    property InspectorObj: Inspector read FInspectorObj;
    property InspectorWindowHandle: HWND read FInspectorWindowHandle;
    property ParentFolderObj: MAPIFolder read FParentFolderObj;
    property ParentFolderEntryID: string read FParentFolderEntryID;
    property ParentFullFolderName: string read FParentFullFolderName;
    property ItemObj: IDispatch read FItemObj;
    property ItemClass: integer read FItemClass;
    property MessageClass: string read FMessageClass;
    property InspectorItemType: TadxolInspectorItemType read FInspectorItemType;
    property InspectorMode: TadxolInspectorMode read FInspectorMode;
    property IsWordMailInspector: boolean read GetIsWordMailInspector;
    property ChangingInspectorWindowHandle: boolean read FChangingInspectorWindowHandle;
    property MailPostInspectorType: TadxolMailPostInspectorType read FMailPostInspectorType write SetMailPostInspectorType;
    property IsMailPost: boolean read FIsMailPost;
    property ClientSubpaneServiceForm: TadxOlForm read FClientSubpaneServiceForm;
    property InspectorItemTypeCaption: string read FInspectorItemTypeCaption;
    property ContextInspectorAdxItemType: TadxItemType read GetContextInspectorAdxItemType;

    property CodeContext: TadxolCodeContext read FCodeContext;
    property WindowHandle: HWND read GetWindowHandle write SetWindowHandle;
  end;

type
  TadxolPane = TOleEnum;
const
  olFolderList = 2;
  olNavigationPane = 4;
  olOutlookBar = 1;
  olPreview = 3;

type
  TadxolDefaultFolders = TOleEnum;

const
  olFolderDeletedItems = 3;
  olFolderOutbox = 4;
  olFolderSentMail = 5;
  olFolderInbox = 6;
  olFolderCalendar = 9;
  olFolderContacts = 10;
  olFolderJournal = 11;
  olFolderNotes = 12;
  olFolderTasks = 13;
  olFolderDrafts = 16;
  olPublicFoldersAllPublicFolders = 18;
  olFolderConflicts = 19;
  olFolderSyncIssues = 20;
  olFolderLocalFailures = 21;
  olFolderServerFailures = 22;
  olFolderJunk = 23;

  {$ifndef MSWINDOWS}
  type
    HTheme = Cardinal;
  {$else}
  type
    HTheme = THandle;
  {$endif}


type
  TadxolFormType = Integer;
const
  ftExplorer = 1;
  ftInspector = 2;

type

  //conform to unit adxForm
  TadxOlSubPaneType =
  (
    sptUnknown,
    sptExplorer,
    sptInspector,
    sptReadingPane
   );

  TadxOlServiceFormTypes =
  (
    sftSuperGrid,
    sftReadingPane,
    sftInspector
  );

  //conform to unit adxForm
  PADXOLFORMINFO = ^TADXOLFORMINFO;
  TADXOLFORMINFO  = record
    FormHandle: HWND;
    Top: integer;
    Left: integer;
    Width: integer;
    Height: integer;
    SplitterState: integer;
    FormLayout: integer;
    Visible: boolean;
    ClassName: PAnsiChar;
    Caption: PAnsiChar;
  end;

  ADXFINDWINDOW = record
    StartHandle: HWND;
    FindHandle: HWND;
    ClassName: PChar;
    Title: PChar;
  end;

  TFindWindow = class
    FindInfo: ADXFINDWINDOW;
    FHandles: TList;
    constructor Create(startHandle, findHandle:HWND; findClassName, findTitle:PChar); overload;
    destructor Destroy; override;
    procedure GetWindows(parentHwnd: HWND);
    property Handles: TList read FHandles write FHandles;
  end;




type

  TZOrderHelper = class
  private
    zIndex: integer;
    TopWindowHandle: HWND;
    BottomWindowHandle: HWND;
    zTopWindowIndex: integer;
    zBottomWindowIndex: integer;
    function InternalIsUnder(TopWindow: HWND; BottomWindow: HWND): boolean;
    function DoEnumWindowsProc( wnd: HWND; lparam: LParam):BOOL;
  public
    class function IsUnder(TopWindow: HWND; BottomWindow: HWND): boolean;
  end;

var
  msgAddForm: Cardinal = 0;
  msgResizeTab: Cardinal = 0;
  msgDeletedProcInHooksChain: Cardinal = 0;

  WorkingZOrderHelperInstance: TZOrderHelper;



{$IFDEF ADX_VCL5}

const
  InstanceCount = 313;

type

  PObjectInstance = ^TObjectInstance;
  TObjectInstance = packed record
    Code: Byte;
    Offset: Integer;
    case Integer of
      0: (Next: PObjectInstance);
      1: (Method: TWndMethod);
  end;

  PInstanceBlock = ^TInstanceBlock;
  TInstanceBlock = packed record
    Next: PInstanceBlock;
    Code: array[1..2] of Byte;
    WndProcPtr: Pointer;
    Instances: array[0..InstanceCount] of TObjectInstance;
  end;

var
  InstBlockList: PInstanceBlock;
  InstFreeList: PObjectInstance;


function StdWndProc(Window: HWND; Message, WParam: Longint;
  LParam: Longint): Longint; stdcall; assembler;
asm
        XOR     EAX,EAX
        PUSH    EAX
        PUSH    LParam
        PUSH    WParam
        PUSH    Message
        MOV     EDX,ESP
        MOV     EAX,[ECX].Longint[4]
        CALL    [ECX].Pointer
        ADD     ESP,12
        POP     EAX
end;


function CalcJmpOffset(Src, Dest: Pointer): Longint;
begin
  Result := Longint(Dest) - (Longint(Src) + 5);
end;


function MakeObjectInstance(Method: TWndMethod): Pointer;
const
  BlockCode: array[1..2] of Byte = (
    $59,       { POP ECX }
    $E9);      { JMP StdWndProc }
  PageSize = 4096;
var
  Block: PInstanceBlock;
  Instance: PObjectInstance;
begin
  if InstFreeList = nil then
  begin
    Block := VirtualAlloc(nil, PageSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    Block^.Next := InstBlockList;
    Move(BlockCode, Block^.Code, SizeOf(BlockCode));
    Block^.WndProcPtr := Pointer(CalcJmpOffset(@Block^.Code[2], @StdWndProc));
    Instance := @Block^.Instances;
    repeat
      Instance^.Code := $E8;  { CALL NEAR PTR Offset }
      Instance^.Offset := CalcJmpOffset(Instance, @Block^.Code);
      Instance^.Next := InstFreeList;
      InstFreeList := Instance;
      Inc(Longint(Instance), SizeOf(TObjectInstance));
    until Longint(Instance) - Longint(Block) >= SizeOf(TInstanceBlock);
    InstBlockList := Block;
  end;
  Result := InstFreeList;
  Instance := InstFreeList;
  InstFreeList := Instance^.Next;
  Instance^.Method := Method;
end;


procedure FreeObjectInstance(ObjectInstance: Pointer);
begin
  if ObjectInstance <> nil then
  begin
    PObjectInstance(ObjectInstance)^.Next := InstFreeList;
    InstFreeList := ObjectInstance;
  end;
end;

{$ENDIF} //{$IFDEF ADX_VCL5}

type
  TadxReceiverWindow = class(TWinControl)
  private
    FCustomMessages: TList;
    FExecute: boolean;
    FCountCustomMessages: integer;
    procedure SetExecute(const Value: boolean);
  public
    procedure WndProc(var Message: TMessage); override;
    constructor CreateEx(AOwner: TComponent; ACaption: string);
    destructor Destroy; override;
    function RegisterMessage(Msg: Cardinal): boolean;
    procedure AddReceiverCustomMessage(CustomWindowMessage: TCustomWindowMessage);
    function Exists(customWindowMessageType: TClass): boolean;
    property Execute: boolean read FExecute write SetExecute;
  end;


  TadxOlExplorer = class
  private
    FOwner: TadxOlFormsManager;
    FExplorerObj: Explorer;
    FExplorerWindowHandle: HWND;
    FFolderViewServiceForm: TadxOlForm;
    FReadingPaneServiceForm: TadxOlForm;
    procedure DoCloseReadingPaneServiceForm(WindowHandle: HWND);
    procedure DoCloseFolderViewServiceForm(WindowHandle: HWND);
  protected

  public
    constructor Create(AOwner: TadxOlFormsManager; AExplorerObj: Explorer;
      AExplorerWindowHandle: HWND);
    destructor Destroy; override;
    property ExplorerObj: Explorer read FExplorerObj;
    property ExplorerWindowHandle: HWND read FExplorerWindowHandle;
    property ReadingPaneServiceForm: TadxOlForm read FReadingPaneServiceForm;
    property FolderViewServiceForm: TadxOlForm read FFolderViewServiceForm;
  end;

  TadxOlInspector = class
  private
    FInspectorWindowHandle: HWND;
    FInspectorObj: Inspector;
    FOwner: TadxOlFormsManager;
    FEmulateWindow: TAdxWMIEmulateWindow;
    FWindowHandle: HWND; //Friend window
    FEmulateWindowHandle: HWND;
    FIsWordMail: boolean;
    FWordInspectorPreviewWatchObject: TWordInspectorPreviewWatchObject;
    FControlResizeWindowWatchObject: TControlResizeWindowWatchObject;
    FInspectorRegionServiceForm: TadxOlForm;
    FIsWordMailInspector: boolean;
    procedure StoppingWatchObject(watchObject: TWatchObject);
    procedure UpdateInspectorWindowHandle(AInspectorWindowHandle: HWND);
    function HasEmulateWindow: boolean;
    procedure SetControlResizeWindowWatchObjectPause(const Value: boolean);
  protected
    procedure SetWordMailInspectorFlag(value: boolean);
    procedure SetWindowHandle(Version: TadxolOutlookVersion);
    procedure CreateEmulateWindow(AWindowHandle: HWND);
    procedure SetExistsEmulateWindowHandleFromOtherAddin(AWindowHandle: HWND);
    procedure DeleteEmulateWindow;
    procedure ClearEmulateDataWordInspectorPreviewWatchObject();
    procedure CreateWordInspectorPreviewWatchObject;
    procedure CreateWindowForResizeControlToWatchEngine(AWindowHandle: HWND);
    procedure DoEmulateWindowHandle(AWindowHandle: HWND);
    procedure SetEmulateDataToWordInspectorPreviewWatchObject(AWindowHandle: HWND);
    procedure HideInspectorRegionServiceForm;
    procedure DoCloseInspectorRegionServiceFormForNotWordInspector(WindowHandle: HWND);

  public
    constructor Create(AOwner: TadxOlFormsManager; const AInspectorObj: Inspector;
      AInspectorWindowHandle: HWND; AIsWordMail: boolean);
    destructor Destroy; override;
    property InspectorObject: Inspector read FInspectorObj;
    property InspectorWindowHandle: HWND read FInspectorWindowHandle;
    property ControlResizeWindowWatchObjectPause: boolean write SetControlResizeWindowWatchObjectPause;
    property InspectorRegionServiceForm: TadxOlForm read FInspectorRegionServiceForm;
    property IsWordMailInspector: boolean read FIsWordMailInspector;
  end;

  TadxOlCompatibilityVersion1 = class
  public
    class function FindItemByFolder(FormsManager: TadxOlFormsManager;
      FolderObj: MAPIFolder): TadxOlFormsCollectionItem;
    class function IsEnableForExplorer(Item: TadxOlFormsCollectionItem): boolean;
    class function CurrentForm(FormsManager: TadxOlFormsManager): TadxOlForm;
    class function GetExplorerForm(FormsManager: TadxOlFormsManager): TadxOlForm;
    class function GetInspectorForm(FormsManager: TadxOlFormsManager): TadxOlForm;
  end;


type
  TadxOlOutlookUtils = class
  private
    FOutlookAppObj: OutlookApplication;
    FFolderGuid: TGUID;
    FOutlookVersion:  TadxolOutlookVersion;
    procedure SetOutlookAppObj(const Value: OutlookApplication);
    procedure SetFolderGuid(const Value: TGUID);
  protected
    property OutlookAppObj: OutlookApplication read FOutlookAppObj write SetOutlookAppObj;
  public
    constructor Create(AOutlookAppObj: OutlookApplication);
    destructor Destroy; override;
    function CompareFolders(FolderObj1: MAPIFolder; FolderObj2: MAPIFolder): boolean; overload;
    function CompareFolders(Folder1Obj: MAPIFolder; Folder2EntryID: string): boolean; overload;
    function ExplorersCount: integer;
    function InspectorsCount: integer;
    function GetExplorers: Explorers;
    function FolderFromEntryID(EntryID: string): MAPIFolder;
    function GetInboxFolder: MAPIFolder;
    function GetOutboxFolder: MAPIFolder;
    function GetPublicFolders: MAPIFolder;
    function GetPublicFoldersAllPublicFolders: MAPIFolder;
    function GetActiveExplorer: Explorer;
    function GetActiveInspector: Inspector;
    function GetCurrentFolder(ExplorerObj: Explorer): MAPIFolder;
    function GetDefaultFolder(DefaultFolder: TadxolDefaultFolders): MAPIFolder;
    function GetDefaultItemType(FolderObj: MAPIFolder): TOleEnum;
    function GetExplorerItemType(FolderObj: MAPIFolder): TadxolExplorerItemType;
    function GetEntryID(FolderObj: MAPIFolder): string;
    function GetEntryIDCurrentFolder(ExplorerObj: Explorer): string;
    function GetExplorerByHandle(ExplorerWindowHandle: integer): Explorer;
    function GetFolderItems(FolderObj: MAPIFolder): Items;
    function GetFolderName(FolderObj: MAPIFolder): string;
    function GetFullFolderName(FolderObj: MAPIFolder): string;
    function GetInspectorCurrentItem(InspectorObj: Inspector): IDispatch;
    function GetInspectorMessageClass(InspectorObj: Inspector): string;
    function GetFolderMessageClass(FolderObj: MAPIFolder): string;
    function GetInspectorWordEditor(InspectorObj: Inspector): IDispatch;
    function GetItemMessageClass(ItemObj: IDispatch): string;
    function GetParentFolder(FolderObj: MAPIFolder): MAPIFolder;
    function GetWebViewOn(FolderObj: MAPIFolder): boolean;
    function GetWebViewURL(FolderObj: MAPIFolder): string;
    function IsExplorerPaneVisible(ExplorerObj: Explorer; OLPane: TadxolPane): boolean;
    function IsOutboxFolder(FolderObj: MAPIFolder): boolean;
    function IsPublicFolders(FolderObj: MAPIFolder): boolean;
    function IsPublicFoldersAllPublicFolders(FolderObj: MAPIFolder): boolean;
    function IsUnderFolder(RootFolderObj: MAPIFolder; FolderObj: MAPIFolder): boolean;
    function IsUnderOutbox(FolderObj: MAPIFolder): boolean;
    function IsUnderPublicFolders(FolderObj: MAPIFolder): boolean;
    function IsWordMailInspector(InspectorObj: Inspector): boolean;
    function IsWordPostInspector(InspectorObj: Inspector): boolean;
    function CheckPossibilityOpenFolder(FolderObj: MAPIFolder): boolean;
    procedure SetExplorerFolder(ExplorerObj: Explorer; FolderObj: MAPIFolder;
      OutlookVersion: TadxolOutlookVersion);
    procedure SetWebView(FolderObj: MAPIFolder; WebViewURL: string; WebViewOn: boolean);
    property FolderGuid: TGUID read FFolderGuid write SetFolderGuid;
  end;

  TMargins = record
    cxLeftWidth,
    cxRightWidth,
    cyTopHeight,
    cyBottomHeight : integer
  end;

  PMargins = ^TMargins;

  TIntList = record
    iValueCount : integer;
    iValues : array [0..MAX_INTLIST_COUNT - 1] of integer;
  end;
  PIntList=  ^TIntList;

  TThemeErrorContext = record
    dwSize : DWORD;                                    // size of this structure
    hr     : HRESULT;                                  // error code from last error
    szMsgParam1 : array[0..MAX_PATH - 1] of WideChar;  // value of first param for msg
    szMsgParam2 : array[0..MAX_PATH - 1] of WideChar;  // value of second param for msg
    szFileName  : array[0..MAX_PATH - 1] of WideChar;  // associated source filename
    szSourceLine: array[0..MAX_PATH - 1] of WideChar;  // source line
    iLineNum    : integer;                             // source line number
  end;

  PThemeErrorContext = ^TThemeErrorContext;


{$IFDEF BUILDER_USED}
{$NODEFINE HIMAGELIST}
{$ENDIF}

  HIMAGELIST = THandle;

//---------------------------------------------------------------------------
  IsThemeActiveProc = function : boolean; stdcall;

  EnableThemingProc = function(fEnable : boolean) : HRESULT; stdcall;

  OpenThemeDataProc = function (hwnd : HWND; pszClassList : PWideChar) : HTheme; stdcall;

  CloseThemeDataProc= function (Theme : HTheme) : HRESULT; stdcall;


  DrawThemeParentBackgroundProc = function (hwnd : HWND; hdc : HDC; const Rect : TRect): HRESULT; stdcall;

  DrawThemeBackgroundProc = function (Theme : HTheme; hdc : HDC;
    iPartId : integer; iStateId : integer; const Rect : TRect; {OPTIONAL} pClipRect : PRect) : HRESULT; stdcall;

  GetThemeBackgroundContentRectProc = function(Theme : HTheme; {OPTIONAL} hdc : HDC;
    iPartId, iStateId : integer; const pBoundingRect : TRect; var pContentRect : TRect) : HResult; stdcall;

  GetThemeBackgroundExtentProc = function(Theme : HTheme; {OPTIONAL} hdc : HDC;
    iPartId, iStateId : integer; pBoundingRect : PRect; var pContentRect : TRect) : HResult; stdcall;

  GetThemePartSizeProc = function(Theme : HTheme; hdc : HDC;
    iPartId, iStateId : integer; {OPTIONAL} rect : PRect; eSize : integer; var psz : TSize) : HRESULT; stdcall;
  GetThemeBackgroundRegionProc = function(Theme : HTheme;
    iPartId, iStateId : Integer; pRect : PRect; var pRegion : HRGN) : HRESULT; stdcall;

  HitTestThemeBackgroundProc = function(Theme : HTheme; {OPTIONAL} hdc : HDC;
    iPartId, iStateId : Integer; dwOptions : DWORD; pRect : PRect; {OPTIONAL} hrgn : HRGN;
    ptTest : TPoint; var pwHitTestCode : word) : HRESULT; stdcall;

  DrawThemeEdgeProc = function(Theme : HTheme; hdc : HDC;
    iPartId, iStateId: Integer; const pDestRect: TRect; uEdge, uFlags: UINT;
    {OPTIONAL} pContentRect: PRect): HRESULT; stdcall;

  DrawThemeIconProc = function(Theme : HTheme; hdc : HDC;
    iPartId, iStateId: Integer; pRect : PRect;
    himl : HIMAGELIST; iImageIndex : integer) : HRESULT; stdcall;

  IsThemePartDefinedProc = function(Theme : HTheme;
    iPartId, iStateId: Integer) : boolean; stdcall;

  IsThemeBackgroundPartiallyTransparentProc = function(Theme : HTheme;
    iPartId, iStateId: Integer) : boolean; stdcall;

  GetThemeColorProc = function(Theme : HTheme; iPartId, iStateId,
    iPropId : Integer; var Color : COLORREF) : HRESULT; stdcall;

  GetThemeMetricProc = function(Theme : HTheme; iPartId, iStateId,
    iPropId : Integer; var piVal : integer) : HRESULT; stdcall;

  SetWindowThemeProc = function(hwnd : HWND; pszSubAppName, pszSubIdList : PWideChar) : HRESULT; stdcall;

  GetThemeFilenameProc = function(Theme : HTheme; iPartId, iStateId,
    iPropId : Integer; {OUT} pszThemeFileName : PWideChar; cchMaxBuffChars : integer) : HRESULT; stdcall;

  GetThemeSysColorProc = function(Theme : HTheme; iColorId : integer) : COLORREF; stdcall;

  GetThemeSysColorBrushProc = function(Theme : HTheme; iColorId : integer) : HBRUSH; stdcall;

  IsAppThemedProc = function : boolean; stdcall;

  GetWindowThemeProc = function(hwnd : HWND) : HTheme; stdcall;
  EnableThemeDialogTextureProc = function(hwnd : HWND; fEnable : BOOL) : HRESULT; stdcall;

  GetThemeAppPropertiesProc = function : DWORD; stdcall;

  SetThemeAppPropertiesProc = procedure(dwFlags : DWORD); stdcall;

  GetCurrentThemeNameProc = function(
    {OUT} pszThemeFileName : PWideChar; cchMaxNameChars : integer;
    {OUT} {OPTIONAL} pszColorBuff : PWideChar; cchMaxColorChars : integer;
    {OUT} {OPTIONAL} pszSizeBuff : PWideChar; cchMaxSizeChars : integer) : HRESULT; stdcall;

var //adxOlSubclassing
  ThemesAvailable : Boolean;
  QueryThemeData  : Boolean;
  OpenThemeData                 : OpenThemeDataProc;
  CloseThemeData                : CloseThemeDataProc;
  DrawThemeBackground           : DrawThemeBackgroundProc;
  GetCurrentThemeName           : GetCurrentThemeNameProc;

//--------------------------------ADX------------------------------------------
{$IFDEF ADX_VCL5}


type
  TExplorerBeforeFolderSwitch = procedure(ASender: TObject;
    const NewFolder: IDispatch; var Cancel: WordBool) of object;
  TExplorerBeforeViewSwitch = procedure(ASender: TObject; NewView: OleVariant;
    var Cancel: WordBool) of object;

  TExplorer = class(TOleServer)
  private
    FOnActivate: TNotifyEvent;
    FOnFolderSwitch: TNotifyEvent;
    FOnBeforeFolderSwitch: TExplorerBeforeFolderSwitch;
    FOnViewSwitch: TNotifyEvent;
    FOnBeforeViewSwitch: TExplorerBeforeViewSwitch;
    FOnDeactivate: TNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FIntf: _Explorer;
    function GetDefaultInterface: _Explorer;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_CommandBars: CommandBars;
  public
   {$HINTS OFF}
    procedure Connect; override;
   {$HINTS ON}
    procedure ConnectTo(svrIntf: _Explorer);
    procedure Disconnect; override;
    property DefaultInterface: _Explorer read GetDefaultInterface;
    property CommandBars: CommandBars read Get_CommandBars;
  published
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnFolderSwitch: TNotifyEvent read FOnFolderSwitch write FOnFolderSwitch;
    property OnBeforeFolderSwitch: TExplorerBeforeFolderSwitch read FOnBeforeFolderSwitch write FOnBeforeFolderSwitch;
    property OnViewSwitch: TNotifyEvent read FOnViewSwitch write FOnViewSwitch;
    property OnBeforeViewSwitch: TExplorerBeforeViewSwitch read FOnBeforeViewSwitch write FOnBeforeViewSwitch;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  TInspector = class(TOleServer)
  private
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FIntf: _Inspector;
    function GetDefaultInterface: _Inspector;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_CommandBars: CommandBars;
    function Get_CurrentItem: IDispatch;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Inspector);
    procedure Disconnect; override;
    property DefaultInterface: _Inspector read GetDefaultInterface;
    property CommandBars: CommandBars read Get_CommandBars;
    property CurrentItem: IDispatch read Get_CurrentItem;
  published
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  TExplorersNewExplorer = procedure(ASender: TObject; const Explorer: _Explorer) of object;

  TExplorers = class(TOleServer)
  private
    FOnNewExplorer: TExplorersNewExplorer;
    FIntf: _Explorers;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Explorers);
    procedure Disconnect; override;
  published
    property OnNewExplorer: TExplorersNewExplorer read FOnNewExplorer write FOnNewExplorer;
  end;

  TInspectorsNewInspector = procedure(ASender: TObject; const Inspector: _Inspector) of object;

  TInspectors = class(TOleServer)
  private
    FOnNewInspector: TInspectorsNewInspector;
    FIntf: _Inspectors;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Inspectors);
    procedure Disconnect; override;
  published
    property OnNewInspector: TInspectorsNewInspector read FOnNewInspector write FOnNewInspector;
  end;

  TNameSpaceOptionsPagesAdd = procedure(ASender: TObject;
    const Pages: PropertyPages; const Folder: MAPIFolder) of object;

  TNameSpace = class(TOleServer)
  private
    FOnOptionsPagesAdd: TNameSpaceOptionsPagesAdd;
    FIntf: _NameSpace;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _NameSpace);
    procedure Disconnect; override;
  published
    property OnOptionsPagesAdd: TNameSpaceOptionsPagesAdd read FOnOptionsPagesAdd write FOnOptionsPagesAdd;
  end;

{ TExplorer}

procedure TExplorer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00063050-0000-0000-C000-000000000046}';
    IntfIID:   '{00063003-0000-0000-C000-000000000046}';
    EventIID:  '{0006304F-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TExplorer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Explorer;
  end;
end;

procedure TExplorer.ConnectTo(svrIntf: _Explorer);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TExplorer.DisConnect;
begin
  if Fintf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TExplorer.GetDefaultInterface: _Explorer;
begin
  if FIntf = nil then Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

procedure TExplorer.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOnActivate) then FOnActivate(Self);
    61442: if Assigned(FOnFolderSwitch) then FOnFolderSwitch(Self);
    61443: if Assigned(FOnBeforeFolderSwitch) then
             FOnBeforeFolderSwitch(Self, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    61444: if Assigned(FOnViewSwitch) then FOnViewSwitch(Self);
    61445: if Assigned(FOnBeforeViewSwitch) then
             FOnBeforeViewSwitch(Self, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    61446: if Assigned(FOnDeactivate) then FOnDeactivate(Self);
    61447: if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
    61448: if Assigned(FOnClose) then FOnClose(Self);
  end;
end;

function TExplorer.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.CommandBars;
end;

{ TInspector }

procedure TInspector.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00063058-0000-0000-C000-000000000046}';
    IntfIID:   '{00063005-0000-0000-C000-000000000046}';
    EventIID:  '{0006307D-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TInspector.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Inspector;
  end;
end;

procedure TInspector.ConnectTo(svrIntf: _Inspector);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TInspector.DisConnect;
begin
  if Fintf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TInspector.GetDefaultInterface: _Inspector;
begin
  if FIntf = nil then Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

procedure TInspector.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOnActivate) then FOnActivate(Self);
    61446: if Assigned(FOnDeactivate) then FOnDeactivate(Self);
    61448: if Assigned(FOnClose) then FOnClose(Self);
  end;
end;

function TInspector.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.CommandBars;
end;

function TInspector.Get_CurrentItem: IDispatch;
begin
  Result := DefaultInterface.CurrentItem;
end;

{ TExplorers }

procedure TExplorers.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00063053-0000-0000-C000-000000000046}';
    IntfIID:   '{0006300A-0000-0000-C000-000000000046}';
    EventIID:  '{00063078-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TExplorers.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Explorers;
  end;
end;

procedure TExplorers.ConnectTo(svrIntf: _Explorers);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TExplorers.DisConnect;
begin
  if Fintf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TExplorers.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOnNewExplorer) then
             FOnNewExplorer(Self, IUnknown(TVarData(Params[0]).VPointer) as _Explorer);
  end;
end;

{ TInspectors }

procedure TInspectors.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00063054-0000-0000-C000-000000000046}';
    IntfIID:   '{00063008-0000-0000-C000-000000000046}';
    EventIID:  '{00063079-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TInspectors.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Inspectors;
  end;
end;

procedure TInspectors.ConnectTo(svrIntf: _Inspectors);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TInspectors.DisConnect;
begin
  if Fintf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TInspectors.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOnNewInspector) then
             FOnNewInspector(Self, IUnknown(TVarData(Params[0]).VPointer) as _Inspector);
  end;
end;

{ TNameSpace }

procedure TNameSpace.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0006308B-0000-0000-C000-000000000046}';
    IntfIID:   '{00063002-0000-0000-C000-000000000046}';
    EventIID:  '{0006308C-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TNameSpace.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _NameSpace;
  end;
end;

procedure TNameSpace.ConnectTo(svrIntf: _NameSpace);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TNameSpace.DisConnect;
begin
  if Fintf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TNameSpace.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61445: if Assigned(FOnOptionsPagesAdd) then
             FOnOptionsPagesAdd(Self, IUnknown(TVarData(Params[0]).VPointer) as PropertyPages,
               IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder);
  end;
end;

{$ENDIF}

//------------------------------------------------------------------------------

type

  TadxOlFormAccess = class(TADXOlForm)
  end;


  TadxCOMAddInModuleAccess = class(TadxCOMAddInModule)
  end;

  IExtensionEvent = interface
    ['{7175D144-097E-4CB1-B3BD-9CA72BC05BD6}']
    procedure CallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
  end;

  TextDocumentUtils = class
    class function GetTextEditor(InspectorObj: Inspector; OutlookVersion: TadxolOutlookVersion): ITextDocument;
    class function GetTextDocument(TextDocumentHandle: HWND): ITextDocument;
    class function GetTextDocumentWindowHandle(HostVersion: integer; EditorType: TOleEnum; InspectorHandle: HWND): HWND;
  end;

  GlobalsOl = class
    class function TemplateHTML: string;
    class procedure SaveHTMLFile(HTMLFileFullName: string);
    class function GeneralHTMLFileName: string;
    class function HTMLFullFileName(COMAddinModule: TadxCOMAddInModule): string;
    class function HTMLFileRootDir(COMAddinModule: TadxCOMAddInModule): string;
    class function CheckOlExplorerItemTypes(ExplorerItemTypes: TadxolExplorerItemTypes;
      ItemType: TOleEnum): boolean;
    class function CheckOlInspectorItemTypes(items: TADXOlInspectorItemTypes; item: integer): boolean;
    class function CheckSupportedOlInspectorItemTypes(items: TADXOlInspectorItemTypes; item: integer): boolean;
    class function ConvertItemTypeToOlExplorerItemType(ItemType: TOleEnum): TadxolExplorerItemType;
    class function ConvertItemClassToOlInspectorItemType(ItemClass: TOleEnum): TadxolInspectorItemType;
    class function ConvertItemClassToString(ItemClass: TOleEnum): string;
    class function WithoutBackSlash(s: string): string;
    class procedure DeleteHTMLFile(HTMLFileFullName: string);
    class procedure DeleteHTMLRootDir(COMAddinModule: TadxCOMAddInModule);
    class function GetAppDataFolder: string;
    class function GetTempDir: WideString;
    class function GetLongFileName(Path: string): string;

    class function WM_ADD_ALIEN_FORM: string;
    class function WM_RESIZE_TAB: string;
    class function WM_DELETE_PROC_IN_HOOKS_CHAIN: string;

    class function WM_ADX_SEARCH_WINDOW_ENGINE_SHOW: string;
    class function WM_ADX_SEARCH_WINDOW_ENGINE_HIDE: string;
    class function WM_ADX_WINDOW_ENGINE_HIDE: string;
    class function WM_ADXCLOSEAPPWINDOW: string;
    class function WM_ADXDELETEEMULATEWINDOW: string;
    class function WM_ADXWMIPOSCHANGE: string;
    class function WM_ADXREMOVECONTROLLEDRESIZEWINDOW: string;
    class function WM_ADX_WORDEDITOR_HIDE: string;
    class function AdxWMIEmulateWindowCaption: string;
    class function WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR: string;
    class function WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM: string;
    class function WM_ADX_CLOSE_READINGPANE_SERVICE_FORM: string;
    class function WM_ADX_REFRESH_INSPECTOR_TAB: string;
    class function WM_INFORMTOSHOWDOCKLAYOUT: string;
    class function WM_REFRESHFOLDER: string;





    class function FoldersForExcludingFromUseWebViewPaneLayout: string;

    class function PublicFolders: string;
    class function PublicFoldersAllPublicFolders: string;
    class function FolderSyncIssues: string;

    class function ADXOlReceiverWindowCaption: string;
    class function DefaultMutexName: string;
    class function DefaultClearWatchObjectsMutex: string;
  end;

  TadxOlFormsManagerState = class
  protected
    isRefreshingFolder: boolean;
    isProcessAllFolders: boolean;
    isShutdown: boolean;
    WasWebViewLoad: boolean;
    isNewExplorerRunning: boolean;
    OutlookNewExplorerJustNowOccured: boolean;
    WasAddinInitialize: boolean;
    isAddinInitialize: boolean;
    BeforeViewSwitchJustNowOccured: boolean;
    isNotifyAddin: boolean;
    isExplorerCloseRunning: boolean;
    isAsyncWordEditorHideRunning: boolean;
    BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch: boolean;
    DisableInCOMAddinsDialogWhenOutlookIsOpened: boolean;
    ClosedInspector: HWND;
    isFolderSwitchExecuting: boolean;
    WasShutdownInApplicationQuit: boolean;
    isRefreshInspectorTabTransaction: boolean;
    procedure Restore;
  public
    constructor Create;
  end;

var
  hThemeLib: HINST;

{$IFDEF ADX_VCL5}
  function GetEnvironmentVariable(const Name: string): string;
  const
    BufSize = 1024;
  var
    Len: Integer;
    Buffer: array[0..BufSize - 1] of Char;
  begin
    Result := '';
    Len := Windows.GetEnvironmentVariable(PChar(Name), @Buffer, BufSize);
    if Len < BufSize then
      SetString(Result, PChar(@Buffer), Len)
    else
    begin
      SetLength(Result, Len - 1);
      Windows.GetEnvironmentVariable(PChar(Name), PChar(Result), Len);
    end;
  end;
{$ENDIF}



function GetAppHandle(cmdBarHandle: HWND): HWND;
var
  parentHWND: HWND;
begin
  if cmdBarHandle = 0 then begin
    Result := 0;
    exit;
  end;
  parentHWND := GetParent(cmdBarHandle);
  while (parentHWND <> 0) do begin
    if (GetParent(parentHWND) = 0) then begin
      Result := parentHWND;
      exit;
    end;
    parentHWND := GetParent(parentHWND);
  end;
  Result := 0;
end;


function GetExplorerWindowHandle(explorer: IDispatch):HWND;
var
  IWindow: IOleWindow;
begin
  Result := 0;
  if explorer = nil then exit;
  explorer.QueryInterface(IOleWindow, IWindow);
  if Assigned(IWindow) then IWindow.GetWindow(Result)
end;

function GetNotWordIncpectorWindowHandle(inspector: IDispatch):HWND;
var
  IWindow: IOleWindow;
begin
  Result := 0;
  if inspector = nil then exit;
  inspector.QueryInterface(IOleWindow, IWindow);
  if Assigned(IWindow) then IWindow.GetWindow(Result)
end;

function GetNewInspectorWindowHandle(inspector:IDispatch; Version:
  TadxolOutlookVersion; Visibility: boolean):HWND;
var
  IWindow: IOleWindow;
  VInspector, VWordEditor, VActiveWindow: OleVariant;
  Caption: WideString;
  DocName: WideString;
  i: integer;
  fwins: TFindWindow;
  fWin: HWND;
  title: array [0..259] of char;
  ChCaption: PAnsiChar;
begin
  Log.AddMessage('GetNewInspectorWindowHandle');
  Log.AddIndent;
  result := 0;
  try
    {$IFDEF UNICODE}
    FillChar(title, SizeOf(title), 0);
    {$ELSE}
    FillChar(title, 260, 0);
    {$ENDIF}
    Result := 0;
    if inspector = nil then exit;
    inspector.QueryInterface(IOleWindow, IWindow);
    if Assigned(IWindow) then begin
      IWindow.GetWindow(Result);
      exit;
    end
    else begin
      VInspector := inspector;
      if VInspector.IsWordMail then begin
      case version of
        v2003: begin
          try
            FormsManagerSingleton.DoBeforeAccessProtectedObject;
            try
              VWordEditor := VInspector.WordEditor;
            finally
              FormsManagerSingleton.DoAfterAccessProtectedObject; 
            end;

            if not VarIsEmpty(VWordEditor) then begin
              VActiveWindow := VWordEditor.ActiveWindow;
              if not VarIsEmpty(VActiveWindow) then begin
                Caption := VActiveWindow.Caption;
                Log.AddMessage('ActiveWindowCaption: ' + Caption);
                VActiveWindow.Caption := InspectorCaptionGuid;
                {$IFDEF UNICODE}
                ChCaption := PAnsiChar(PChar(InspectorCaptionGuid));
                {$ELSE}
                ChCaption := PAnsiChar(InspectorCaptionGuid);
                {$ENDIF}
                fwins := TFindWindow.Create(GetDesktopWindow, 0, PChar('_WwB'), PChar(ChCaption));
                try
                  for i := 0 to fwins.Handles.Count - 1 do begin
                    fWin := HWND(fwins.Handles.Items[i]);
                    if (Windows.IsWindowVisible(fWin) = Visibility) then begin

                      Result := GetAppHandle(fWin);
                      break;
                    end;
                  end;
                finally
                  if Assigned(fwins) then fwins.Free;
                end;
                if Caption = '' then begin
                  DocName := VWordEditor.Name;
                  Log.AddMessage('DocName: ' + DocName);
                  Caption := DocName;
                end;
                VActiveWindow.Caption := Caption;
              end;
            end;
          except
          end;
        end;
        v2002: begin
          fwins := TFindWindow.Create(0 ,0, PChar('_WwB'), PChar(''));
          try
            for i := 0 to fwins.Handles.Count - 1 do begin

              fWin := HWND(fwins.Handles.Items[i]);
              if (not Windows.IsWindowVisible(fWin)) then begin
                Result := GetAppHandle(fWin);
                {$IFDEF UNICODE}
                GetWindowText(Result, title, Length(title));
                {$ELSE}
                GetWindowText(Result, title, 260);
                {$ENDIF}
                if title <> '' then begin

                  break;
                end;
              end;
            end;
          finally
            if Assigned(fwins) then fwins.Free;
          end;
        end;
        else begin
          TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('The Outlook version has not define. GetNewInspectorWindowHandle'), 'GetNewInspectorWindowHandle');
        end;
      end;
    end;
    end;
  finally
    Log.RemoveIndent;
    IWindow := nil;
    VInspector := Unassigned;
    VWordEditor := Unassigned;
    VActiveWindow := Unassigned;
  end;
end;


procedure SetExWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or Prop);
end;

procedure SetWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or Prop);
end;

procedure UnSetWinAPIProperty(Handle :HWND; Prop: integer);
begin
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not Prop);
end;

{$IFDEF UNICODE}
function GetWindowText_(Handle: HWND): PChar;
var
  text: array [0..MAX_PATH - 1] of Char;
begin
  FillChar(text, SizeOf(text), 0);                  // <<-- Specify buffer size in bytes
  Windows.GetWindowText(Handle, text, Length(text));// <<-- Count should be chars not bytes
  Result := text;
end;
{$ELSE}
function GetWindowText_(Handle: HWND): PChar;
var
  text: array [0..259] of AnsiChar;
begin
  FillChar(text, 260, 0);
  Windows.GetWindowText(Handle, text, 260);
  Result := text;
end;
{$ENDIF}

{$IFDEF UNICODE}
function GetWindowClassName(Handle: HWND): PChar;
var
  clName: array [0..MAX_PATH - 1] of Char;
begin
  FillChar(clName, SizeOf(clName), 0);
  GetClassName(Handle, clName, Length(clName));
  Result := clName;
end;
{$ELSE}
function GetWindowClassName(Handle: HWND): PChar;
var
  clName: array [0..259] of AnsiChar;
begin
  FillChar(clName, 260, 0);
  GetClassName(Handle, clName, 260);
  Result := clName;
end;
{$ENDIF}

procedure RegistryReadStrings(const valueName: string; aStrings: TStrings; oReg:TRegistry);
var
  valueType : DWORD ;
  valueLen  : DWORD ;
  p, buffer : PChar ;
begin
  aStrings.Clear ;
  SetLastError(RegQueryValueEx(oReg.CurrentKey, PChar(valueName),nil, @valueType,nil, @valueLen)) ;
  if GetLastError = ERROR_SUCCESS then begin
    if valueType = REG_MULTI_SZ then
    begin
      GetMem(buffer, valueLen) ;
      try
        RegQueryValueEx(oReg.CurrentKey, PChar(valueName), nil, nil, PBYTE(buffer), @valueLen) ;
        p := buffer ;
        while p^ <> #0 do
        begin
          aStrings.Add(p) ;
          Inc(p, lstrlen(p) + 1)
        end
      finally
        FreeMem(buffer)
      end
    end
    else begin
      raise ERegistryException.Create('String list expected');
    end;
  end
  else begin
    raise SysUtils.Exception.Create('Unable read MULTI_SZ value')
  end;
end;

var
  IsExists: boolean = false;

function ChildExists(hwnd,lParam: integer):BOOL; stdcall;
begin
  IsExists := true;
  Result := true;
end;

function ExistsChildWindow(WindowHandle: HWND): boolean;
begin
  IsExists := false;
  EnumChildWindows(WindowHandle,@ChildExists, 0);
  result := IsExists;
end;


procedure RegistryWriteStrings(const valueName: string; aStrings: TStrings; oReg:TRegistry) ;
var
  p, buffer : PChar ;
  i         : Integer ;
  size      : DWORD ;
begin
  size := 0 ;
  for i := 0 to aStrings.Count - 1 do
    Inc(size, (Length(aStrings [i]) + 1) * sizeof(char)) ;
  Inc (size) ;
  GetMem(buffer, size) ;
  try
    p := buffer ;
    for i := 0 to aStrings.count - 1 do
    begin
      lstrcpy(p, PChar(aStrings [i])) ;
      Inc(p, lstrlen (p) + 1)
    end;
    p^ := #0 ;
    SetLastError(RegSetValueEx(oReg.CurrentKey, PChar(valueName), 0, REG_MULTI_SZ, buffer, size)) ;
    if GetLastError <> ERROR_SUCCESS then begin
      raise SysUtils.Exception.Create('Unable to write MULTI_SZ value') ;
    end;
  finally
    FreeMem(buffer)
  end
end;

function GetNotWordInspectorWindowHandle(inspector: IDispatch):HWND;
var
  IWindow: IOleWindow;
begin
  Result := 0;
  if inspector = nil then exit;
  inspector.QueryInterface(IOleWindow, IWindow);
  if Assigned(IWindow) then IWindow.GetWindow(Result)
end;

function DrawThemeBackgroundTo(pszClassList: LPCWSTR; hdc: HDC; iPartId, iStateId: Integer;
  const pRect: TRect; pClipRect: PRect): HRESULT;
var
  ATheme: HTheme;
begin
  Result := E_NOTIMPL;
  ATheme := OpenThemeData(0, pszClassList);
  if ATheme <> 0 then
  try
    Result := DrawThemeBackground(ATheme, hdc, iPartId, iStateId, pRect, pClipRect);
  finally
    CloseThemeData(ATheme);
  end;
end;

function GetThemedBorderColor: TColor;
var
//  ATheme: HTheme;
  themeName, schemeName: array [0..260] of WideChar;
begin
  Result := RGB(128, 128, 128);
  if ThemesAvailable then begin
    GetCurrentThemeName(themeName, 255, schemeName, 255, nil, 0);
    if Pos('LUNA.MSSTYLES', UpperCase(themeName)) <> 0 then begin
      if UpperCase(schemeName) = 'HOMESTEAD' then Result := RGB(96, 128, 88);
      if UpperCase(schemeName) = 'METALLIC' then Result := RGB(124, 124, 148);
      if UpperCase(schemeName) = 'NORMALCOLOR' then Result := RGB(0, 45, 150);
    end
    else begin
      Result := RGB(128, 128, 128);
    end;
  end;
end;

procedure NewAppWindowProperty(var AppWindowProperty: PAppWindowProperty);
begin
  PAppWindowProperty(AppWindowProperty)^.Offset:= 0;
  PAppWindowProperty(AppWindowProperty)^.EmulateWindowHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.WindowHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.Layout := -1;
  PAppWindowProperty(AppWindowProperty)^.ItemType := -1;
  PAppWindowProperty(AppWindowProperty)^.HostHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.ContainerType := -1;
  PAppWindowProperty(AppWindowProperty)^.HostVersion := -1;
  PAppWindowProperty(AppWindowProperty)^.Splitter := 0;
  PAppWindowProperty(AppWindowProperty)^.Caption := '';
  PAppWindowProperty(AppWindowProperty)^.ReceiverHandle := 0;
  PAppWindowProperty(AppWindowProperty)^.VerticalScrollbarHandle  := 0;
end;

{ TadxOlFormsManager }

procedure TadxOlFormsManager.ConnectAddinModuleEvents;
begin

    FOldAddInInitialize := nil;
    FOldAddInStartupComplete := nil;
    FOldAddInBeginShutdown := nil;
    FOldAddInFinalize := nil;

    if Assigned(COMAddInModule) then begin
      if Assigned(COMAddInModule.OnAddInInitialize) then
        FOldAddInInitialize := COMAddInModule.OnAddInInitialize;
      if Assigned(COMAddInModule.OnAddInStartupComplete) then
        FOldAddInStartupComplete := COMAddInModule.OnAddInStartupComplete;
      if Assigned(COMAddInModule.OnAddInBeginShutdown) then
        FOldAddInBeginShutdown := COMAddInModule.OnAddInBeginShutdown;
      if Assigned(COMAddInModule.OnAddInFinalize) then
        FOldAddInFinalize := COMAddInModule.OnAddInFinalize;

      COMAddInModule.OnAddInInitialize := Self.OnAddInInitialize;
      COMAddInModule.OnAddInStartupComplete := Self.OnAddInStartupComplete;
      COMAddInModule.OnAddInBeginShutdown := Self.OnAddInBeginShutdown;
      COMAddInModule.OnAddInFinalize := Self.OnAddInFinalize;
      TadxCOMAddInModuleAccess(COMAddInModule).OnCallBack := Self.OnCallBack;
      TadxCOMAddInModuleAccess(COMAddInModule).OnCTPFactoryAvailable := Self.OnCTPFactoryAvailable;

    end;
end;

procedure TadxOlFormsManager.ConnectOutlookEvents;
begin
    Log.AddMessage('ConnectOutlookEvents');

    FOldOLExplorerBeforeFolderSwitch := nil;
    FOldOLExplorerBeforeViewSwitch := nil;
    FOldOLExplorerClose := nil;
    FOldOLExplorerFolderSwitch := nil;
    FOldOLExplorerSelectionChange := nil;
    FOldOLExplorerViewSwitch := nil;
    FOldOLInspectorClose := nil;
    FOldOLNewExplorer := nil;
    FOldOLNewInspector := nil;
    FOldOLInspectorActivate := nil;

    if Assigned(COMAddInModule) then begin

      if Assigned(COMAddInModule.OnOLExplorerBeforeFolderSwitch) then
        FOldOLExplorerBeforeFolderSwitch := COMAddInModule.OnOLExplorerBeforeFolderSwitch;
      if Assigned(COMAddInModule.OnOLExplorerBeforeViewSwitch) then
        FOldOLExplorerBeforeViewSwitch := COMAddInModule.OnOLExplorerBeforeViewSwitch;
      if Assigned(COMAddInModule.OnOLExplorerClose) then
        FOldOLExplorerClose := COMAddInModule.OnOLExplorerClose;
      if Assigned(COMAddInModule.OnOLExplorerFolderSwitch) then
        FOldOLExplorerFolderSwitch := COMAddInModule.OnOLExplorerFolderSwitch;
      if Assigned(COMAddInModule.OnOLExplorerSelectionChange) then
        FOldOLExplorerSelectionChange := COMAddInModule.OnOLExplorerSelectionChange;
      if Assigned(COMAddInModule.OnOLExplorerViewSwitch) then
        FOldOLExplorerViewSwitch := COMAddInModule.OnOLExplorerViewSwitch;
      if Assigned(COMAddInModule.OnOLInspectorClose) then
        FOldOLInspectorClose := COMAddInModule.OnOLInspectorClose;
      if Assigned(COMAddInModule.OnOLNewExplorer) then
        FOldOLNewExplorer := COMAddInModule.OnOLNewExplorer;
      if Assigned(COMAddInModule.OnOLNewInspector) then
        FOldOLNewInspector := COMAddInModule.OnOLNewInspector;
      if Assigned(COMAddInModule.OnOLInspectorActivate) then
        FOldOLInspectorActivate := COMAddInModule.OnOLInspectorActivate;

      COMAddInModule.OnOLExplorerBeforeFolderSwitch := Self.OnOLExplorerBeforeFolderSwitch;
      COMAddInModule.OnOLExplorerBeforeViewSwitch := Self.OnOLExplorerBeforeViewSwitch;
      COMAddInModule.OnOLExplorerClose := Self.OnOLExplorerClose;
      COMAddInModule.OnOLExplorerFolderSwitch := Self.OnOLExplorerFolderSwitch;
      COMAddInModule.OnOLExplorerSelectionChange := Self.OnOLExplorerSelectionChange;
      COMAddInModule.OnOLExplorerViewSwitch := Self.OnOLExplorerViewSwitch;
      COMAddInModule.OnOLInspectorClose := Self.OnOLInspectorClose;
      COMAddInModule.OnOLNewExplorer := Self.OnOLNewExplorer;
      COMAddInModule.OnOLNewInspector := Self.OnOLNewInspector;
      COMAddInModule.OnOLInspectorActivate := Self.OnOLInspectorActivate;

      //Application Quit
      if Assigned(COMAddInModule.OutlookApp) then begin
        if Assigned(COMAddInModule.OutlookApp.OnQuit) then begin
          FOldApplicationQuit := COMAddInModule.OutlookApp.OnQuit;
        end;
        COMAddInModule.OutlookApp.OnQuit := Self.OnApplicationQuit;
      end;

    end;
end;

constructor TadxOlFormsManager.Create(AOwner: TComponent);
var
  i: integer;
begin
  try
    FctpFactory := nil;
    FState := nil;
    FHookTransactionWindowHandle := 0;
    FReadingPaneLayout := rplOff;
    FOutboxFolderEntryID := EmptyStr;
    FPublicFoldersEntryID := EmptyStr;
    FPublicFoldersAllPublicFoldersEntryID := EmptyStr;
    FFolderSyncIssuesEntryID := EmptyStr;

    FRefreshCurrentFolderObj := nil;
    FRefreshSecondaryFolderObj := nil;

    InboxFullFolderName := EmptyStr;
    FInboxFolderObj := nil;
		FOutboxFolderObj := nil;
    WasGettingPublicFoldersObj := false;
		FPublicFoldersObj := nil;
    WasGettingPublicFoldersAllPublicFoldersObj := false;
		FPublicFoldersAllPublicFoldersObj := nil;
    WasGettingFolderSyncIssuesObj := false;
    FFolderSyncIssuesObj := nil;

    FPriorExplorerWindowHandleForSearching := 0;

    Log.AddSystemInfo('Time: ' + DateTimeToStr(Now));
    Log.AddSystemInfo('Package: ' + ProductVersionAndPackage);
    Log.AddSystemInfo('ADX Version:' + adxVersion);
    Log.AddSystemInfo('ADX Extensions Version 6.1.754');
{$IFDEF DOCKEXPLORERLAYOUTS}
    Log.AddSystemInfo('Define DOCKEXPLORERLAYOUTS');
{$ELSE}
    Log.AddSystemInfo('Define NOT DOCKEXPLORERLAYOUTS');
{$ENDIF}
{$IFDEF SupportAdjacentWindow}
    Log.AddSystemInfo('Define SupportAdjacentWindow');
{$ELSE}
    Log.AddSystemInfo('Define NOT SupportAdjacentWindow');
{$ENDIF}

    Log.AddMessage('TadxOlFormsManager.Create');
    FHTMLFullFileName := EmptyStr;
    if AOwner = nil then
      raise EADXException.Create(Format(adxolErrorCantContain, [ClassName, 'nil']), adxolECodeCantContain, 0);
    if not (AOwner is TadxCOMAddInModule) then
      raise EADXException.Create(Format(adxolErrorCantContain, [ClassName, AOwner.ClassName]), adxolECodeCantContain, 0);
    for i := 0 to AOwner.ComponentCount - 1 do begin
      if (AOwner.Components[i] is TadxOlFormsManager) then
        raise EADXException.Create(Format(adxolErrorSecondComponent, [ClassName]), adxolECodeCantContain, 0);
    end;
    inherited Create(AOwner);

    FItems := TadxOlFormsCollection.Create(Self, TadxOlFormsCollectionItem);

    FisLockUpdates := false;
    FWatchEngine := nil;
    if not (csDesigning in self.ComponentState) then begin
      CreateMutexes;
      Log.AddMessage('CREATE MUTEX ' + IntToHex(hMessageMutex, 8));

      ConnectAddinModuleEvents;
      //v2.0
      //FadxHook := TAdxLocalHook.Create;
    end;
    FormsManagerSingleton := self;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlFormsManager.Create: ' + E.Message), 'TadxOlFormsManager.Create');
    end;
  end;
end;

procedure TadxOlFormsManager.UnregisterInspector(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('UnregisterInspector');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  //if Assigned(FWatchEngine) then
  //  FWatchEngine.DeleteByHostHandle(InspectorArgs.InspectorWindowHandle);
  TadxOlRegisterInspectorList(FRegisteredInspectorList).DeleteByInspectorWindowHandle(InspectorArgs.InspectorWindowHandle);
end;


procedure TadxOlFormsManager.UpdateCTP(window: IDispatch; CTPParam: TAdxCTPParams);
var
  Param: TAdxCTPParams;
begin
  Param:= CTPParam;
  FOutlookHook.UpdateCTP(window, @Param);
end;

destructor TadxOlFormsManager.Destroy;
begin
  Log.AddMessage('TadxOlFormsManager.Destroy');
  if not (csDesigning in self.ComponentState) then begin

    if Assigned(FOutlookHandleFinder) then begin
      TOutlookHandleFinder(FOutlookHandleFinder).Free;
      FOutlookHandleFinder := nil;
    end;

    if Assigned(FWatchEngine) then begin
      TWatchEngine(FWatchEngine).Free;
      FWatchEngine := nil;
    end;

    if Assigned(FOutlookHook) then begin
      FOutlookHook.Free;
      FOutlookHook:= nil;
    end;

    if Assigned(FReceiverWindow) then begin
      TadxReceiverWindow(FReceiverWindow).Free;
    end;

    if Assigned(FState) then begin
      TadxOlFormsManagerState(FState).Free;
    end;
    if Assigned(FOutlookUtils) then begin
      TadxOlOutlookUtils(FOutlookUtils).Free;
      FOutlookUtils := nil;
    end;
    if Assigned(FRegisteredExplorerList) then begin
      TadxOlRegisterExplorerList(FRegisteredExplorerList).Clear;
      TadxOlRegisterExplorerList(FRegisteredExplorerList).Free;
    end;
    if Assigned(FRegisteredInspectorList) then begin
      TadxOlRegisterInspectorList(FRegisteredInspectorList).Clear;
      TadxOlRegisterInspectorList(FRegisteredInspectorList).Free;
    end;
    {if Assigned(FCachedFormList) then begin
      FCachedFormList.Clear;
      FCachedFormList.Free;
    end;}

    DisconnectOutlookEvents;
    DisconnectAddinModuleEvents;

    DeleteMutexes;
    Log.AddMessage('CLOSE MUTEX');
    //v2.0
    //if Assigned(FadxHook) then FadxHook.Destroy;

  end;

  if Assigned(FItems) then begin
    FItems.Clear;
    FItems.Free;
    FItems := nil;
  end;

  inherited Destroy;
  Log.AddMessage('TadxOlFormsManager.inherited Destroy');
  if (ExceptionManager <> nil) then begin
    ExceptionManager.Free;
    ExceptionManager := nil;
  end;

  //Log.Save('C:\ADXVCL_destroy.txt');
  ILogSingleton := nil;
end;

//DoNewExplorer()
//begin
//  if (FOld <> nil) then FOld(Sender);
//  asdfasdf
//end;

procedure TadxOlFormsManager.DisconnectAddinModuleEvents;
begin
  Log.AddMessage('DisconnectAddinModuleEvents');
  if Assigned(COMAddInModule) then begin
    if Assigned(FOldAddInInitialize) then
      COMAddInModule.OnAddInInitialize := FOldAddInInitialize;
    if Assigned(FOldAddInStartupComplete) then
      COMAddInModule.OnAddInStartupComplete := FOldAddInStartupComplete;
    if Assigned(FOldAddInBeginShutdown) then
      COMAddInModule.OnAddInBeginShutdown := FOldAddInBeginShutdown;
    if Assigned(FOldAddInFinalize) then
      COMAddInModule.OnAddInFinalize := FOldAddInFinalize;
  end;
end;

procedure TadxOlFormsManager.DisconnectOutlookEvents;
begin
  Log.AddMessage('DisconnectOutlookEvents');
  if Assigned(COMAddInModule) then begin
    if Assigned(FOldOLExplorerBeforeFolderSwitch) then
      COMAddInModule.OnOLExplorerBeforeFolderSwitch := FOldOLExplorerBeforeFolderSwitch;
    if Assigned(FOldOLExplorerBeforeViewSwitch) then
      COMAddInModule.OnOLExplorerBeforeViewSwitch := FOldOLExplorerBeforeViewSwitch;
    if Assigned(FOldOLExplorerClose) then
      COMAddInModule.OnOLExplorerClose := FOldOLExplorerClose;
    if Assigned(FOldOLExplorerFolderSwitch) then
      COMAddInModule.OnOLExplorerFolderSwitch := FOldOLExplorerFolderSwitch;
    if Assigned(FOldOLExplorerSelectionChange) then
      COMAddInModule.OnOLExplorerSelectionChange := FOldOLExplorerSelectionChange;
    if Assigned(FOldOLExplorerViewSwitch) then
      COMAddInModule.OnOLExplorerViewSwitch := FOldOLExplorerViewSwitch;
    if Assigned(FOldOLInspectorClose) then
      COMAddInModule.OnOLInspectorClose := FOldOLInspectorClose;
    if Assigned(FOldOLNewExplorer) then
      COMAddInModule.OnOLNewExplorer := FOldOLNewExplorer;
    if Assigned(FOldOLNewInspector) then
      COMAddInModule.OnOLNewInspector := FOldOLNewInspector;
    if Assigned(FOldOLInspectorActivate) then
      COMAddInModule.OnOLInspectorActivate := FOldOLInspectorActivate;

    //Application Quit
    if Assigned(COMAddInModule.OutlookApp) then begin
      if Assigned(FOldApplicationQuit) then begin
        COMAddInModule.OutlookApp.OnQuit := FOldApplicationQuit;
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnAddInBeginShutdown(Sender: TObject);
begin
  try
    if Assigned(FOldAddInBeginShutdown) then begin
      FOldAddInBeginShutdown(Sender);
    end;
  finally
    try
      Log.AddMessage('');
      Log.AddMessage('Event: OnAddInBeginShutdown');
      Log.AddIndent();
      try
        DoAddInBeginShutdown(Sender);
      finally
        Log.RemoveIndent;
        Log.AddMessage('');
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInBeginShutdown')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnAddInFinalize(Sender: TObject);
begin
  try
    if Assigned(FOldAddInFinalize) then begin
      FOldAddInFinalize(Sender);
    end;
  finally
    try
      Log.AddMessage('Event: OnAddInFinalize');
      DoAddInFinalize(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInFinalize')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnAddInInitialize(Sender: TObject);
begin
  try
    if Assigned(FOldAddinInitialize) then begin
      FOldAddinInitialize(Sender);
    end;
  finally
    try
      Log.AddMessage('Event: OnAddInInitialize');
      DoAddInInitialize(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInInitialize')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnAddInStartupComplete(Sender: TObject);
begin
  try
    if Assigned(FOldAddInStartupComplete) then
      FOldAddInStartupComplete(Sender);
  finally
    try
      Log.AddMessage('Event: OnAddInStartupComplete');
      DoAddInStartupComplete(Sender);
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnAddInStartupComplete')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerBeforeFolderSwitch(
  ASender: TObject; const NewFolder: IDispatch; var Cancel: WordBool);
var
  ExplorerArgs: TadxOlExplorerArguments;
  NewFolderObj: MAPIFolder;
  NewFolderExplorerArgs: TadxOlExplorerArguments;
  BreakProcessing: boolean;
begin
  try
    if Assigned(FOldOLExplorerBeforeFolderSwitch) then
      FOldOLExplorerBeforeFolderSwitch(ASender, NewFolder, Cancel);
  finally
    try
      Log.AddMessage('Event: OnOLExplorerBeforeFolderSwitch');
      {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
      if (not Cancel) then begin

        NewFolderObj := NewFolder as MAPIFolder;

        ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(ASender).DefaultInterface, ccFolderEvent);
        NewFolderExplorerArgs := TadxOlExplorerArguments.CreateWithFolder(Self, TExplorer(ASender).DefaultInterface, NewFolderObj, ccFolderEvent);
        try

          BreakProcessing := TadxOlFormsManagerState(State).isShutdown
            or TadxOlFormsManagerState(State).isRefreshingFolder
            or (not IsRegisterExplorer(ExplorerArgs.ExplorerWindowHandle));

          if not BreakProcessing then begin
            DoOLExplorerBeforeFolderSwitch(ExplorerArgs, NewFolderExplorerArgs);
          end;

        finally
          Log.AddMessage('Finally');
          ExplorerArgs.Free;
          NewFolderExplorerArgs.Free;
          NewFolderObj := nil;
        end;
        TadxOlFormsManagerState(State).BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch := true;
      end;
      {$ENDIF}
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerBeforeFolderSwitch')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerBeforeViewSwitch(ASender: TObject;
  NewView: OleVariant; var Cancel: WordBool);
var
  ExplorerArgs: TadxOlExplorerArguments;
  BreakProcessing: boolean;
begin
  try
    if Assigned(FOldOLExplorerBeforeViewSwitch) then
      FOldOLExplorerBeforeViewSwitch(ASender, NewView, Cancel);
  finally
    try
      Log.AddMessage('Event: OnOLExplorerBeforeViewSwitch');
      if (not Cancel) then begin
        {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
        ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(ASender).DefaultInterface, ccFolderEvent);
        try
          BreakProcessing := TadxOlFormsManagerState(State).isShutdown
            or TadxOlFormsManagerState(State).isRefreshingFolder
            or (not IsRegisterExplorer(ExplorerArgs.ExplorerWindowHandle));

          if not BreakProcessing then begin
            DoOLExplorerBeforeViewSwitch(ExplorerArgs, NewView, Cancel);
          end;

        finally
          TadxOlFormsManagerState(State).BeforeViewSwitchJustNowOccured := true;
          ExplorerArgs.Free;
        end;
        {$ENDIF}
        end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerBeforeViewSwitch')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerClose(Sender: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  try
    if Assigned(FOldOLExplorerClose) then begin
      FOldOLExplorerClose(Sender);
    end;
  finally
    Log.AddMessage('Event: OnOLExplorerClose');
    try
      {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
      ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(Sender).DefaultInterface, ccExplorerClose);
      try
        TadxOlFormsManagerState(State).isExplorerCloseRunning := true;
        DoOLExplorerClose(ExplorerArgs);
        DeleteExplorerWindowsForSearching(ExplorerArgs);
      finally
        ExplorerArgs.Free;
        TadxOlFormsManagerState(State).isExplorerCloseRunning := false;
      end;
      {$ENDIF}
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerClose')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerFolderSwitch(Sender: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  BreakProcessing: boolean;
begin
  try
    if Assigned(FOldOLExplorerFolderSwitch) then
      FOldOLExplorerFolderSwitch(Sender);
  finally
    try
      Log.AddMessage('Event: OnOLExplorerFolderSwitch');

      {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
      ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(Sender).DefaultInterface, ccFolderEvent);
      try

        //Refresh logica for Outlook 2007
        if (
             (OutlookVersion = v2007)
             or (OutlookVersion = v2010)
           )
           and
          ((FRefreshCurrentFolderObj <> nil) or (FRefreshSecondaryFolderObj <> nil)) then begin

          if (FRefreshSecondaryFolderObj <> nil) then begin
            if (FRefreshCurrentFolderObj = nil) then begin
              Log.AddWarning('OnOLExplorerFolderSwitch: FRefreshCurrentFolderObj = nil');
            end;
            FRefreshSecondaryFolderObj := nil;
            TadxOlOutlookUtils(OutlookUtils).SetExplorerFolder(ExplorerArgs.ExplorerObj, FRefreshCurrentFolderObj, OutlookVersion);
          end
          else begin
            if (FRefreshCurrentFolderObj <> nil) then begin
              FRefreshCurrentFolderObj := nil;
              TadxOlFormsManagerState(State).isRefreshingFolder := false;
              adxextUnlockWindowUpdate(ExplorerArgs.ExplorerWindowHandle);
            end;
          end;
        end;

        //See DoNavigationPaneShow, DoTodoBarShow, DoReadingPaneShow
        TadxOlFormsManagerState(State).isFolderSwitchExecuting := true;

        BreakProcessing := TadxOlFormsManagerState(State).isShutdown
          or TadxOlFormsManagerState(State).isRefreshingFolder
          or (not IsRegisterExplorer(ExplorerArgs.ExplorerWindowHandle));

        if not BreakProcessing then begin
          DoOLExplorerFolderSwitch(ExplorerArgs);
        end;

      finally
        TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured := false;
        TadxOlFormsManagerState(State).isFolderSwitchExecuting := false;
        //Quick search problem
        ExplorerArgs.Free;
      end;

      TadxOlFormsManagerState(State).BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch := false;

      {$ENDIF}
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerFolderSwitch')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerSelectionChange(Sender: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  try
    if Assigned(FOldOLExplorerSelectionChange) then
      FOldOLExplorerSelectionChange(Sender);
  finally
    try
      Log.AddMessage('Event: OnOLExplorerSelectionChange');
      {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
      ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(Sender).DefaultInterface, ccFolderEvent);
      try
        DoOLExplorerSelectionChange(ExplorerArgs);
      finally
        ExplorerArgs.Free;
      end;
      {$ENDIF}
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerSelectionChange')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLExplorerViewSwitch(Sender: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  BreakProcessing: boolean;
begin
  try
    if Assigned(FOldOLExplorerViewSwitch) then
      FOldOLExplorerViewSwitch(Sender);
  finally
    try
      Log.AddMessage('Event: OnOLExplorerViewSwitch');
      {$IFNDEF WITHOUT_OUTLOOK_EVENTS1}
      ExplorerArgs := TadxOlExplorerArguments.Create(Self, TExplorer(Sender).DefaultInterface, ccFolderEvent);
      try
        BreakProcessing := (not TadxOlFormsManagerState(State).BeforeViewSwitchJustNowOccured)
          or (not IsRegisterExplorer(ExplorerArgs.ExplorerWindowHandle));

        if not BreakProcessing then begin
          DoOLExplorerViewSwitch(ExplorerArgs);
        end;

      finally
        TadxOlFormsManagerState(State).BeforeViewSwitchJustNowOccured := false;
        ExplorerArgs.Free;
      end;
      {$ENDIF}
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLExplorerViewSwitch')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLInspectorClose(Sender: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  InspectorWindowHandle: HWND;
  index: integer;
begin
  try
    if Assigned(FOldOLInspectorClose) then
      FOldOLInspectorClose(Sender);
  finally
    Log.AddMessage('Event: OnOLInspectorClose');
    try
      InspectorWindowHandle := 0;
      for index := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
        if (TInspector(Sender).DefaultInterface = TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[index]).FInspectorObj)  then
          InspectorWindowHandle := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[index]).FInspectorWindowHandle;
      end;
      InspectorArgs := TadxOlInspectorArguments.Create(Self, TInspector(Sender).DefaultInterface, InspectorWindowHandle, ccInspectorClose);
      try
        DoOLInspectorClose(InspectorArgs);
      finally
        InspectorArgs.Free;
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLInspectorClose')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLNewExplorer(ASender: TObject;
  const Explorer: _Explorer);
var
  ExplorerArgs: TadxOlExplorerArguments;
  BreakProcessing: boolean;

begin
  try
    if Assigned(FOldOLNewExplorer) then
      FOldOLNewExplorer(ASender, Explorer);
  finally
    try
      Log.AddMessage('Event: OnOLNewExplorer');
      ExplorerArgs := TadxOlExplorerArguments.Create(self, Explorer, ccNewExplorer);
      try

        BreakProcessing := false;
        TadxOlFormsManagerState(State).isNewExplorerRunning := true;

        if not BreakProcessing then begin
          DoOLNewExplorer(ExplorerArgs);
        end;

      finally
        TadxOlFormsManagerState(State).isNewExplorerRunning := false;
        ExplorerArgs.Free;
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLNewExplorer')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.OnOLNewInspector(ASender: TObject;
  const Inspector: _Inspector);
var
  InspectorArgs: TadxOlInspectorArguments;
  InspectorWindowHandle: HWND;
begin
  try
    if Assigned(FOldOLNewInspector) then
      FOldOLNewInspector(ASender, Inspector);
  finally
    Log.AddMessage('Event: OnOLNewInspector');
    try
      InspectorWindowHandle := GetNewInspectorWindowHandle(Inspector, OutlookVersion, false);

      //mailto:?subject=Test issue
      if (InspectorWindowHandle = 0) and (TadxOlOutlookUtils(OutlookUtils).ExplorersCount = 0) then begin
        InspectorWindowHandle := GetNewInspectorWindowHandle(Inspector, OutlookVersion, true);
      end;

      Log.AddMessage('OnOLNewInspector: ' + Format('%x', [InspectorWindowHandle]));
      InspectorArgs := TadxOlInspectorArguments.Create(self, Inspector, InspectorWindowHandle, ccNewInspector);
      try
        TDebug.WriteLine('Before DoOLNewInspector');

        if GlobalsOl.CheckSupportedOlInspectorItemTypes(AllInspectorItemTypes, InspectorArgs.ItemClass) then begin
          DoOLNewInspector(InspectorArgs);
        end;
        TDebug.WriteLine('After DoOLNewInspector');
      finally
        InspectorArgs.Free;
        TDebug.WriteLine('After DoOLNewInspector InspectorArgs.Free');
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLNewInspector')
      end;
    end;
  end;
end;

function TadxOlFormsManager.IsRegisterInspector(
  InspectorWindowHandle: HWND): boolean;
var
  i: integer;
begin
  Log.AddMessage('IsRegisterInspector');
  result := false;
  i := 0;
  while (i < TadxOlRegisterInspectorList(FRegisteredInspectorList).Count) do begin
    if (TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).FInspectorWindowHandle =  InspectorWindowHandle) then begin
      result := true;
      break;
    end;
    Inc(i);
  end;
end;

function TadxOlFormsManager.GetClientLayoutWindowHandle(
  AInspectorArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetClientLayoutWindowHandle');
  result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsInspectorRegionClientLayout then begin
        form := Items[index].GetFirstVisibleInspectorForms(AInspectorArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetClientLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetClientLayoutWindowHandle ' + E.Message), 'DoOLExplorerBeforeViewSwitch');
  end;
end;

function TadxOlFormsManager.GetCOMAddInModule: TadxCOMAddInModule;
begin
  result := nil;
  try
    result := Owner as TadxCOMAddInModule
  except
    on E: SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetCOMAddInModule: ' + E.Message), 'GetCOMAddInModule');
  end;
end;

function TadxOlFormsManager.GetCurrentForm: TadxOlForm;
begin
  result := TadxOlCompatibilityVersion1.CurrentForm(self);
end;

function TadxOlFormsManager.GetHasWebViewPane: boolean;
var
  i: integer;
begin
  result := false;
  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  for i := 0 to Items.Count - 1 do begin
    if (Items[i].DefiniteExplorerProperties and Items[i].IsWebViewPaneLayout) then begin
       result := true;
       exit;
    end;
  end;
end;

function TadxOlFormsManager.GetisClosingOutlookOnExplorerClose: boolean;
var
  explorersCount: integer;
begin
  Log.AddMessage('GetisClosingOutlookOnExplorerClose');

  explorersCount := 0;
  try
    explorersCount := TadxOlOutlookUtils(OutlookUtils).ExplorersCount;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetisClosingOutlookOnExplorerClose ' + E.Message), 'GetisClosingOutlookOnExplorerClose');
  end;

  case FOutlookVersion of
    v2000: result := (explorersCount <= 1);
    v2002: result := (explorersCount = 0);
    v2003: result := (explorersCount = 0);
    v2007,
    v2010: result := (explorersCount = 0);
    else raise EAbort.Create('Outlook version is not defined. GetisClosingOutlookOnExplorerClose.')
  end;
end;

function TadxOlFormsManager.GetItems: TadxOlFormsCollection;
begin
  result := FItems;
end;

function TadxOlFormsManager.GetOutlookAppObj: OutlookApplication;
begin
  result := nil;
  if Assigned(COMAddInModule) and Assigned(COMAddInModule.OutlookApp) then
    Result := COMAddInModule.OutlookApp.DefaultInterface;
end;



procedure TadxOlFormsManager.DoAddInBeginShutdown(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;
  Log.AddMessage('TadxOlFormsManager.DoAddInBeginShutdown');
  if not TadxOlFormsManagerState(State).WasShutdownInApplicationQuit then begin
    DoShutdown(Sender);
  end;
end;

procedure TadxOlFormsManager.DoAddInFinalize(Sender: TObject);
begin
  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;
  Log.AddMessage('TadxOlFormsManager.DoAddInFinalize');
  if not TadxOlFormsManagerState(State).WasShutdownInApplicationQuit then begin
    DoFinalize(Sender);
  end;
end;

procedure TadxOlFormsManager.DoAddInInitialize(Sender: TObject);
var
  CallThroughOle: boolean;
  ExplorerArgs: TadxOlExplorerArguments;
  ExplorersObj: Explorers;
  ExplorerObj: Explorer;
  ExplorerIndex, ExplorersCount, ItemIndex: integer;
  WasLoadOtherAddinWithWebViewItem: boolean;
  event: TadxEventRaising;

  FolderObj: MAPIFolder;
  Index: Integer;
begin
  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;
  Log.AddMessage('TadxOlFormsManager.DoAddInInitialize');

  adxWSbcls.APIInitialize;

  ExceptionManager := TADXXOlExceptionManager.Create;
  TAppWindowBehaviour.SetSingleton(TOutlookAppWindowBehaviour.Create);
  TFindWindowFactory.SetSingleton(TFindOutlookWindowFactory.Create);

  ExplorerArgs := nil;
  if not Assigned(COMAddInModule) then exit;
  try
    FState := TadxOlFormsManagerState.Create;

    CheckSocialConnectorAddinConnection();

    TadxOlFormsManagerState(State).Restore;

    try

      FOutlookHandleFinder := TOutlookHandleFinder.Create();

      FReceiverWindow := TadxReceiverWindow.CreateEx(
        Self, GlobalsOl.ADXOlReceiverWindowCaption);


      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TRefreshFolderMessage.Create(ReceiverWindowHandle, self));

      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TShowSearchWindowMessage.Create(ReceiverWindowHandle, OnCommonReceiverWindowShow));
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(THideSearchWindowMessage.Create(ReceiverWindowHandle, OnCommonReceiverWindowHide));
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TDeleteEmulateWindowMessage.Create(ReceiverWindowHandle, OnDeleteEmulateWindowEvent));
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(THideWindowMessage.Create(ReceiverWindowHandle, OnCommonReceiverInspectorWindowHide));
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TWordEditorHideMessage.Create(ReceiverWindowHandle, OnAsyncWordEditorHide));


      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TStartTransactionMessage.Create(ReceiverWindowHandle, self));
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TEndTransactionMessage.Create(ReceiverWindowHandle, self));

      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(TCTPVisibleChangedMessage.Create(ReceiverWindowHandle, self));



      RegisterMessages;

      FRegisteredExplorerList := TadxOlRegisterExplorerList.Create(Self);
      FRegisteredInspectorList := TadxOlRegisterInspectorList.Create(Self);

      FOutlookUtils := TadxOlOutlookUtils.Create(COMAddInModule.OutlookApp.DefaultInterface);
      SetOutlookVersion;

      FOutlookHook:= TAdxOlHook.CreateEx(FOutlookVersion);
      TadxOlFormsManagerState(State).isAddinInitialize := true;

      CallThroughOle := TadxOlOutlookUtils(OutlookUtils).ExplorersCount = 0;

      if CallThroughOle then begin
        //exit;
      end;

      LoadLayoutsFromRegistry;

      if Assigned(OnInitialize) then begin
        try
          event := TadxEventRaising.Create('OnInitialize', [eoLockRegionState]);
          try
            OnInitialize(Self);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'Raise OnInitialize');
          end;
        end;
      end;

      FWatchEngine := TWatchEngine.CreateEx(ReceiverWindowHandle);

{$IFDEF WithADXHTMLFile}
      Globals.SaveHTMLFile(Self.HTMLFileFullName(COMAddInModule));
{$ELSE}
      if not FileExists(Self.HTMLFullFileName) then begin
        GlobalsOl.SaveHTMLFile(Self.HTMLFullFileName);
      end;
{$ENDIF}

      ConnectOutlookEvents;

      LoadDefaultFoldersEntryIDFromRegistry();

      {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}

      AddInformToShowDockLayoutMessageToReceiver();

{$IFDEF CLIENTLAYOUTS}
      AddCloseServiceFormsMessagesToReceiver();
{$ENDIF}

      AddDestroyEmbededWindowMessageToReceiver();
      AddRemoveControlledResizeWindowMessageToReceiver();
      AddCloseButtonClickMessageToReceiver();

      RestoreWebViewFolderSettings();

      if (HasWebViewPane) then begin
        Log.AddMessage('HasWebViewPane.PublicFoldersEntryID: ' + PublicFoldersEntryID);
        Log.AddMessage('HasWebViewPane.PublicFoldersAllPublicFoldersEntryID: ' + PublicFoldersAllPublicFoldersEntryID);
        Log.AddMessage('HasWebViewPane.FolderSyncIssuesEntryID: ' + FolderSyncIssuesEntryID);
        ExplorerArgs := nil;
        ExplorerObj := TadxOlOutlookUtils(OutlookUtils).GetActiveExplorer;
        try
          if (ExplorerObj <> nil) then begin
            //DK 14-March-10
            if Self.FOutlookVersion < v2003 then
              ProcessRootFoldersWebViewPane(ExplorerObj)
            else begin
              // set webview for the current folder
              FolderObj := ExplorerObj.CurrentFolder;
              if Assigned(FolderObj) then
                try
                  ExplorerArgs := TadxOlExplorerArguments.CreateWithFolder(self, ExplorerObj, FolderObj, ccWebViewProcess);
                  for index := 0 to Items.Count - 1 do begin
                    if Items[index].IsWebViewPaneLayout and Items[index].CorrespondExplorerContext(ExplorerArgs) then begin
                      if (not ExplorerArgs.AdxWebViewURLForFolder) then begin
                        StoreFolderSettingsInRegistry(FolderObj);
                        TadxOlOutlookUtils(OutlookUtils).SetWebView(FolderObj, Self.HTMLFullFileName, true);
                        Break;
                      end;
                    end;
                  end;
                  FreeAndNil(ExplorerArgs);
                finally
                  FolderObj := nil;
                end;
            end;
            ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccInitialize);
            //prevent superfluous RefreshCurrentFolder
            WasLoadOtherAddinWithWebViewItem := TadxOlFormsManagerState(State).WasWebViewLoad;
            if (not WasLoadOtherAddinWithWebViewItem) then begin

              if (ExplorerArgs.AdxWebViewURLForFolder and (not HasWebViewWindow(ExplorerArgs))
                or (not ExplorerArgs.AdxWebViewURLForFolder and HasWebViewPaneItemThatCorrespondExplorerContext(ExplorerArgs))
                ) then begin
                //Update WebView contents for current colder
                RefreshCurrentFolder(ExplorerArgs);
                if FOutlookVersion = v2010 then
                  RefreshWindowThroughDistortion(ExplorerArgs.ExplorerWindowHandle);
              end;
            end;
          end
          else begin
            Log.AddWarning('ExplorerObj == nil');
          end;
        finally
          if (ExplorerArgs <> nil) then begin
            ExplorerArgs.Free;
          end;
          ExplorerObj := nil;
        end;
      end;

      try
        Log.AddWarning('GetExplorers');
        ExplorersObj := TadxOlOutlookUtils(OutlookUtils).GetExplorers;
        ExplorersCount := ExplorersObj.Count;
        for ExplorerIndex := 1 to ExplorersCount do begin
          try
            ExplorerObj := ExplorersObj.Item(ExplorerIndex);
            ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccInitialize);

            FReadingPaneLayout := ExplorerArgs.ReadingPaneLayout;

            RegisterExplorer(ExplorerArgs);
            ExplorerArgs.RefreshServiceForms(Self);


            for ItemIndex := 0 to Items.Count - 1 do begin
              if Items[ItemIndex].CorrespondExplorerContext(ExplorerArgs) then begin

                if (Items[ItemIndex].IsSuperGridLayout and not ExplorerArgs.WebViewOn)
                  or Items[ItemIndex].IsNavigationPaneLayout
                  or (Items[ItemIndex].IsReadingPaneLayout and ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin)
                  or Items[ItemIndex].IsOutlookBarLayout
                  or Items[ItemIndex].IsTodoBarLayout
{$IFNDEF WithADXHTMLFile}
                  or Items[ItemIndex].IsWebViewPaneLayout
{$ENDIF}
                then begin
                  DoShowExplorerForm(Items[ItemIndex], ExplorerArgs, 0);
                end;

              end;
            end;

            AddExplorerWindowsForSearching(ExplorerArgs);

          finally
            if (ExplorerArgs <> nil) then begin
              ExplorerArgs.Free;
            end;
            ExplorerObj := nil;
          end;
        end;
      finally
        ExplorersObj := nil;
      end;

      Log.AddMessage('Start WatchEngine');
      //Start WatchEngine
      TWatchEngine(FWatchEngine).Resume;

    finally
      TadxOlFormsManagerState(State).isAddinInitialize := false;
      TadxOlFormsManagerState(State).WasAddinInitialize := true;
      //Need afrer WasAddinInitialize

    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoAddInInitialize: ' + E.Message), 'DoAddInInitialize');
    end;
  end;
end;

procedure TadxOlFormsManager.DoAddInStartupComplete(Sender: TObject);
begin
  Log.AddMessage('TadxOlFormsManager.DoAddInStartupComplete');

  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;

  AddinsToLog();
  CheckSocialConnectorAddinConnection();

{$IFDEF DOCKEXPLORERLAYOUTS}
    TryInitCtpFactory;
    ProcessDockLayoutForAllExplorers;
{$ENDIF}

end;

procedure TadxOlFormsManager.DoOLExplorerBeforeFolderSwitch(AExplorerArgs: TObject;
  ANewFolderExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  NewFolderExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  NewItem: TadxOlFormsCollectionItem;
  CurrentItem: TadxOlFormsCollectionItem;
  event: TadxEventRaising;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}

  Log.AddMessage('DoOLExplorerBeforeFolderSwitch');
  try

    if (TadxOlFormsManagerState(State).isShutdown) then exit;
    if (TadxOlFormsManagerState(State).isRefreshingFolder) then exit;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
    NewFolderExplorerArgs := TadxOlExplorerArguments(ANewFolderExplorerArgs);

    if (not TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured) then begin

      try
        LockWindowUpdate(ExplorerArgs.FExplorerWindowHandle);
{$IFDEF CLIENTLAYOUTS}
        HideAllFormsInAllAddins(GetSuperGridLayoutWindowHandle(ExplorerArgs));
        HideAllFormsInAllAddins(GetWebViewPaneLayoutWindowHandle(ExplorerArgs));
        HideAllFormsInAllAddins(GetReadingPaneLayoutWindowHandle(ExplorerArgs));
{$ENDIF}
        //Hide not Active
        for index := 0 to Items.Count - 1 do begin
          //Hide but not delete! Delete will in the FolderSwitch event

          if Items[index].IsSuperGridLayout
            or Items[index].IsWebViewPaneLayout
            or Items[index].IsReadingPaneLayout then
          begin
            Items[index].HideNotActiveExplorerForms(ExplorerArgs);
          end;

          if Items[index].IsNavigationPaneLayout
            or Items[index].IsReadingPaneLayout
            or Items[index].IsOutlookBarLayout
            or Items[index].IsTodoBarLayout
            or Items[index].IsDockLayout
          then begin

            //Hide forms that will not show for NewFolder
            if not Items[index].CorrespondExplorerContext(NewFolderExplorerArgs) then begin
              TDebug.WriteLine('DoOLExplorerBeforeFolderSwitch not CorrespondExplorerContext');
              Items[index].HideNotActiveExplorerForms(NewFolderExplorerArgs);
            end
            else begin
              TDebug.WriteLine('DoOLExplorerBeforeFolderSwitch CorrespondExplorerContext');
            end;

          end;
        end;

        //Hide Active
        for index := 0 to Items.Count - 1 do begin
          //Hide but not delete! Delete will in the FolderSwitch event

          if Items[index].IsSuperGridLayout
            or Items[index].IsWebViewPaneLayout
            or Items[index].IsReadingPaneLayout then
          begin
            Items[index].HideActiveExplorerForms(ExplorerArgs);
          end;

          if Items[index].IsNavigationPaneLayout
            or Items[index].IsReadingPaneLayout
            or Items[index].IsOutlookBarLayout
            or Items[index].IsTodoBarLayout
            or Items[index].IsDockLayout
          then begin

            //Hide forms that will not show for NewFolder
            if not Items[index].CorrespondExplorerContext(NewFolderExplorerArgs) then begin
              TDebug.WriteLine('DoOLExplorerBeforeFolderSwitch not CorrespondExplorerContext');
              Items[index].HideActiveExplorerForms(NewFolderExplorerArgs);
            end
            else begin
              TDebug.WriteLine('DoOLExplorerBeforeFolderSwitch CorrespondExplorerContext');
            end;

          end;
        end;
{$IFDEF DOCKEXPLORERLAYOUTS}
        HideAllCTP(AExplorerArgs);
{$ENDIF}

{$IFDEF CLIENTLAYOUTS}
        HideReadingPaneServiceForm(ExplorerArgs);
        HideFolderViewServiceForm(ExplorerArgs);
{$ENDIF}


      finally
        LockWindowUpdate(0);
      end;

      //ADXOlFormsManager event

      //CompatibilityVersion1
      if Assigned(OnADXBeforeFolderSwitch) then begin
        NewItem := TadxOlCompatibilityVersion1.FindItemByFolder(Self, NewFolderExplorerArgs.FolderObj);
        CurrentItem := TadxOlCompatibilityVersion1.FindItemByFolder(Self, ExplorerArgs.FolderObj);
        try
          event := TadxEventRaising.Create('OnADXBeforeFolderSwitch', [eoLockRegionState]);
          try
            OnADXBeforeFolderSwitch(Self, ExplorerArgs.ExplorerObj, CurrentItem, ExplorerArgs.FolderObj, NewItem, NewFolderExplorerArgs.FolderObj);
          finally
            event.Free;
          end;
      except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(E, 'DoOLExplorerBeforeFolderSwitch');
        end;
      end;

      if Assigned(OnADXBeforeFolderSwitchEx) then begin
        try
          event := TadxEventRaising.Create('OnADXBeforeFolderSwitchEx', [eoLockRegionState]);
          try
            OnADXBeforeFolderSwitchEx(Self, ExplorerArgs.ExplorerObj, ExplorerArgs.FolderObj, NewFolderExplorerArgs.FolderObj);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(E, 'DoOLExplorerBeforeFolderSwitch');
        end;
      end;

      ProcessFolderWebViewPane(NewFolderExplorerArgs.ExplorerObj, NewFolderExplorerArgs.FolderObj);
    end
    else begin
      //Case 2679
      if (OutlookVersion = v2003) then begin
        ProcessFolderWebViewPane(NewFolderExplorerArgs.ExplorerObj, NewFolderExplorerArgs.FolderObj);
      end;
      TDebug.WriteLine('*** *** *** TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured');
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerBeforeFolderSwitch ' + E.Message), 'DoOLExplorerBeforeFolderSwitch');
  end;

end;

procedure TadxOlFormsManager.DoOLExplorerBeforeViewSwitch(
  AExplorerArgs: TObject; NewView: OleVariant; var Cancel: WordBool);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLExplorerBeforeViewSwitch');
  try
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsSuperGridLayout then begin
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;
{$IFDEF CLIENTLAYOUTS}
    HideFolderViewServiceForm(ExplorerArgs);
{$ENDIF}

  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerBeforeViewSwitch ' + E.Message), 'DoOLExplorerBeforeViewSwitch');
  end;
end;

procedure TadxOlFormsManager.DoOLExplorerClose(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  isClosingOutlook: boolean;
  inspectorsCount: integer;
begin
  Log.AddMessage('DoOLExplorerClose');
  Log.AddIndent;
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  try

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
    //TDebug.WriteLine('@@@ DoOLExplorerClose ' + IntToHex(ExplorerArgs.FExplorerWindowHandle, 8) + ' start' + IntToStr(Cardinal(self)));

    isClosingOutlook := isClosingOutlookOnExplorerClose;

    //AddinModule fires InspectorClose when last explorer is closed
    if (isClosingOutlook) then begin

      inspectorsCount := 0;
      try
        inspectorsCount := TadxOlOutlookUtils(OutlookUtils).InspectorsCount;
      except
        on E:SysUtils.Exception do
          TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerClose.inspectorsCount ' + E.Message), 'DoOLExplorerClose.inspectorsCount');
      end;
      if (inspectorsCount > 0) then begin
        isClosingOutlook := false;
      end;
    end;

    if isClosingOutlook then begin

      Log.AddMessage('isClosingOutlook');
      case FOutlookVersion of
        v2000, v2002, v2003: begin
          if Assigned(FWatchEngine) then begin
            //TWatchEngine(FWatchEngine).Terminate;
            //TWatchEngine(FWatchEngine).WaitFor;
          end;
        end;
      end;

          HideAllForms;

          DeleteAllForms;

//{$IFDEF CLIENTLAYOUTS}
          HideAllServiceForm();
//{$ENDIF}


          //For fast exit mus be here
          RestoreWebViewFolderSettings;

          //Need free opened inspectors, else Shutdown does not fire
          FreeExistentInspectors;
          FreeExistentExplorers;

    end
    else begin
      DeleteExplorerForms(ExplorerArgs.ExplorerWindowHandle);

//{$IFDEF CLIENTLAYOUTS}
      HideFolderViewServiceForm(ExplorerArgs);
      HideReadingPaneServiceForm(ExplorerArgs);
//{$ENDIF}

      UnregisterExplorer(ExplorerArgs.ExplorerWindowHandle);

    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerClose ' + E.Message), 'DoOLExplorerClose');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.DoOLExplorerFolderSwitch(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index, FormIndex: integer;
  ShowForm: boolean;
  FolderWebViewOn: boolean;
  Item: TadxOlFormsCollectionItem;
  form: TadxOlForm;
  NeedToCallEvent: boolean;
  FolderSwitchArgs: TadxOlFormFolderSwitchEventArgs;
  event: TadxEventRaising;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLExplorerFolderSwitch');
  try
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
    CancelIsHiddenByDeveloperFlagForExplorerForms(AExplorerArgs);

    if (TadxOlFormsManagerState(State).isRefreshingFolder) then exit;

    try
      FolderWebViewOn := (TadxOlOutlookUtils(OutlookUtils).GetWebViewOn(ExplorerArgs.FolderObj));
    except
      TDebug.WriteLine('Exception try get FolderWebViewOn');
      //Outlook 2000 fires exception if WebViewOn
      FolderWebViewOn := true;
    end;

    if FolderWebViewOn then begin
      TDebug.WriteLine('Exit');
      //exit;
    end;

    if (not TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured) then begin
      TDebug.WriteLine('HideExplorerForms 1');

      try
        LockWindowUpdate(ExplorerArgs.FExplorerWindowHandle);
        //Delete/Hide forms
        for index := 0 to Items.Count - 1 do begin
          Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);

          if Items[index].IsSuperGridLayout
            or Items[index].IsWebViewPaneLayout then
          begin
            Items[index].HideExplorerForms(ExplorerArgs);
          end;

          TDebug.WriteLine('HideExplorerForms 2');
          if Items[index].IsNavigationPaneLayout
            or (Items[index].IsReadingPaneLayout and ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin)
            or Items[index].IsOutlookBarLayout
            or Items[index].IsTodoBarLayout
            or Items[index].IsDockLayout
          then begin

            //Hide forms that will not show for NewFolder
            Items[index].HideNotCorrespondedExplorerForms(ExplorerArgs);
          end;
        end;

{$IFDEF CLIENTLAYOUTS}
        HideFolderViewServiceForm(ExplorerArgs);
{$ENDIF}

{$IFDEF DOCKEXPLORERLAYOUTS}
        HideAllCTP(ExplorerArgs);
{$ENDIF}

      finally
        LockWindowUpdate(0);
        Invalidate(ExplorerArgs.ExplorerWindowHandle);
      end;
    end;

    ShowForm := true;
    if Assigned(OnADXFolderSwitch) then begin
      Item := TadxOlCompatibilityVersion1.FindItemByFolder(self, ExplorerArgs.FolderObj);
      try
        event := TadxEventRaising.Create('OnADXFolderSwitch', [eoLockRegionState]);
        try
          OnADXFolderSwitch(Self, ShowForm, ExplorerArgs.ExplorerObj, Item, ExplorerArgs.FolderObj);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoOLExplorerFolderSwitch');
        end;
      end;
    end;

    //if FolderWebViewOn then exit;

    if ShowForm then begin
      try
        LockWindowUpdate(ExplorerArgs.FExplorerWindowHandle);
          for Index := 0 to Items.Count - 1 do begin
            if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin
              if (Items[Index].IsSuperGridLayout and not FolderWebViewOn)
                or Items[Index].IsNavigationPaneLayout
                or Items[Index].IsReadingPaneLayout
                or Items[Index].IsOutlookBarLayout
                or Items[Index].IsTodoBarLayout
                or Items[Index].IsWebViewPaneLayout
                or Items[Index].IsDockLayout
              then begin
                DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
              end;
            end;
          end;
        finally
          LockWindowUpdate(0);
          Invalidate(ExplorerArgs.ExplorerWindowHandle);
        end;
    end;


    //TadxOlForm.DoAdxFolderSwitch
    for index := 0 to Items.Count - 1 do begin
      for FormIndex := 0 to Items[Index].FormInstanceCount - 1  do begin
        form := Items[Index].FormInstances[FormIndex];
        if (form <> nil) then begin
          NeedToCallEvent := ((form.FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle)
                        and form.Visible);
          if (NeedToCallEvent) then begin
            FolderSwitchArgs := TadxOlFormFolderSwitchEventArgs.Create;
            try
              form.DoAdxFolderSwitch(FolderSwitchArgs);
            finally
              if FolderSwitchArgs <> nil then begin
                FolderSwitchArgs.Free;
              end;
            end;
          end;
        end;
      end;
    end;


    if Assigned(OnADXFolderSwitchEx) then begin
      try
        event := TadxEventRaising.Create('OnADXFolderSwitchEx', [eoLockRegionState]);
        try
          OnADXFolderSwitchEx(Self, ExplorerArgs.ExplorerObj, ExplorerArgs.FolderObj);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoOLExplorerFolderSwitch');
        end;
      end;
    end;

  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerFolderSwitch: ' + E.Message), 'DoOLExplorerFolderSwitch')
    end;
  end;

end;

procedure TadxOlFormsManager.DoOLExplorerSelectionChange(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  Form: TadxOlForm;
  ItemIndex, FormIndex: integer;
  NeedToCallSelectionChange: boolean;
  startTime, endTime: TDateTime;
  h, m, s, ms: word;
  event: TadxEventRaising;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLExplorerSelectionChange');
  startTime := Now;
  try
    if (TadxOlFormsManagerState(State).isRefreshingFolder) then exit;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    for ItemIndex := 0 to Items.Count - 1 do begin
      for FormIndex := 0 to TadxOlFormsManagerList(Items[ItemIndex].FFormInstances).Count - 1 do begin
        if TadxOlFormsManagerList(Items[ItemIndex].FFormInstances)[FormIndex] <> nil then begin
          Form := TadxOlForm(TadxOlFormsManagerList(Items[ItemIndex].FFormInstances)[FormIndex]);
          NeedToCallSelectionChange :=
          ((Form.FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle) and Form.Visible)
            or (Form.FIsInspectorForm and Form.Visible); 
          if NeedToCallSelectionChange then begin
            if Assigned(Form.OnADXSelectionChange) then begin
              try
                event := TadxEventRaising.Create('OnADXSelectionChange', [eoAvailableRegionState]);
                try
                  Form.OnADXSelectionChange(Self);
                finally
                  event.Free;
                end;
              except
                on E:SysUtils.Exception do begin
                  TadxExceptionManager.ProcessADXXError(E, 'DoOLExplorerSelectionChange');
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerSelectionChange: ' + E.Message), 'DoOLExplorerSelectionChange');
  end;

  endTime := Now;
  DecodeTime(endTime - startTime, h, m, s, ms);
  Log.AddMessage(Format('@@@-@@@ Getting DoExplorerSelectionChange VCL interval: h:%d m:%d s:%d ms:%d', [h, m, s, ms]));

end;

procedure TadxOlFormsManager.DoOLExplorerViewSwitch(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLExplorerViewSwitch');
  try
    //Quick search problem
    if (TadxOlFormsManagerState(State).BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch) then begin
      TadxOlFormsManagerState(State).BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch := false;
      exit;
    end;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsSuperGridLayout then
      begin
        Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;

{$IFDEF CLIENTLAYOUTS}
    HideFolderViewServiceForm(ExplorerArgs);
{$ENDIF}
    
    for Index := 0 to Items.Count - 1 do begin
      if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin

        if Items[Index].IsSuperGridLayout then begin
          DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
        end;

      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerViewSwitch: ' + E.Message), 'DoOLExplorerViewSwitch');
  end;
end;

procedure TadxOlFormsManager.DoOLInspectorClose(AInspectorArgs: TObject);
{$IFNDEF ADXXOL_TRIAL}
var
  InspectorArgs: TadxOlInspectorArguments;
  res: integer;
  counter: integer;
{$ENDIF}
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLInspectorClose');
  try
    {$IFNDEF ADXXOL_TRIAL}
    if TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning = true then begin
      Log.AddMessage('isAsyncWordEditorHideRunning');
      //Thread defined window close
      exit;
    end;

    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning := true;
    TadxOlFormsManagerState(State).ClosedInspector := InspectorArgs.FInspectorWindowHandle;
    try


    counter := 0;
    repeat
      if counter > 0 then begin
        Log.AddMessage(' * repeat DoOLInspectorClose step=' + IntToStr(counter));
      end;
      Inc(counter);

      res := 0;

      while (TadxReceiverWindow(FReceiverWindow).Execute) and (counter < 10) do begin
        Inc(counter);
      end;

      if (not TadxReceiverWindow(FReceiverWindow).Execute) then begin
        //Alternative HideSearchWindowMessage := THideSearchWindowMessage.Create(ReceiverWindowHandle, nil);
        OnCommonInspectorWindowHide(InspectorArgs.InspectorWindowHandle, stOlMailInspector, true);
      end;

      if (res = 0) then begin
        DeleteInspectorWindowsForSearching(InspectorArgs);
      end;

      if (counter > 10) then begin
        //ProcessADXXError('DoOLInspectorClose Break cycle');
        res := 0;
      end;
    until res = 0;

    DeleteFormsForAbsentInspectors;

    UnregisterInspector(AInspectorArgs);

    TDebug.WriteLine('DoOLInspectorClose END');
    {$ELSE}
    {$ENDIF}
    finally
      TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning := false;
      TadxOlFormsManagerState(State).ClosedInspector := 0;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLInspectorClose: ' + E.Message), 'DoOLInspectorClose');
  end;
end;

procedure TadxOlFormsManager.DoOLNewExplorer(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  ItemIndex: integer;
  WasSettedAdxWebViewURLForFolder: boolean;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLNewExplorer');
  try

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    TadxOlFormsManagerState(State).isNewExplorerRunning := true;
    try
      if (not IsRegisterExplorer(ExplorerArgs.ExplorerWindowHandle)) then begin
        RegisterExplorer(AExplorerArgs);
        ExplorerArgs.RefreshServiceForms(Self);
        //Flag that will reset in FolderSwitch
        TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured :=
          (OutlookVersion <> v2007)
          and (OutlookVersion <> v2010);

        if (OutlookVersion = v2007)
          or (OutlookVersion = v2010) then begin
          for ItemIndex := 0 to Items.Count - 1 do begin
            if Items[ItemIndex].CorrespondExplorerContext(ExplorerArgs) then begin

              if Items[ItemIndex].IsSuperGridLayout      
                or Items[ItemIndex].IsNavigationPaneLayout
                or (Items[ItemIndex].IsReadingPaneLayout and ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin)
                or Items[ItemIndex].IsOutlookBarLayout
                or Items[ItemIndex].IsTodoBarLayout
                or Items[ItemIndex].IsDockLayout
              then begin
                DoShowExplorerForm(Items[ItemIndex], ExplorerArgs, 0);
              end;

            end;
          end;
        end;

      end
      else begin
        //See BeforeFolderSwitch, NewWxplorer don't have CurrentFolder
        //DoShowExplorerForm();
      end;

      //Must be after DoShowExplorerForm
      AddExplorerWindowsForSearching(AExplorerArgs);

      if (TadxOlFormsManagerState(State).WasAddinInitialize) then begin
        //Case 2679
        if FOutlookVersion >= v2007 then begin
             WasSettedAdxWebViewURLForFolder := ExplorerArgs.AdxWebViewURLForFolder;
             ProcessFolderWebViewPane(ExplorerArgs.ExplorerObj, ExplorerArgs.FolderObj);

              if ((not WasSettedAdxWebViewURLForFolder) and HasWebViewPaneItemThatCorrespondExplorerContext(ExplorerArgs))
                 then begin
                //Update WebView contents for current colder
                if (FOutlookVersion = v2007) then begin
                  //Case 2679
                  TDebug.WriteLine('@@@@ WM_REFRESHFOLDER');
                  PostMessage(ReceiverWindowHandle, WM_REFRESHFOLDER, ExplorerArgs.ExplorerWindowHandle, 0);
                end
                else begin
                  RefreshCurrentFolder(ExplorerArgs);
                end;

                //There were no problems that would make calling the RefreshWindowThroughDistortion method necessary.
                //if FOutlookVersion = v2010 then
                //  RefreshWindowThroughDistortion(ExplorerArgs.ExplorerWindowHandle);
              end;
        end;
      end;

    finally
      TadxOlFormsManagerState(State).isNewExplorerRunning := false;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLNewExplorer: ' + E.Message), 'DoOLNewExplorer');
  end;
end;

procedure TadxOlFormsManager.DoOLNewInspector(AInspectorArgs: TObject);
{$IFNDEF ADXXOL_TRIAL}
var
  InspectorArgs: TadxOlInspectorArguments;
  event: TadxEventRaising;
{$ENDIF}
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoOLNewInspector');
  Log.AddIndent;
  TDebug.WriteLine('TadxOlFormsManager.DoOLNewInspector');
  try
    {$IFNDEF ADXXOL_TRIAL}
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    DeleteInvalidInspectors();

    if not IsRegisterInspector(InspectorArgs.InspectorWindowHandle) then begin
      RegisterInspector(InspectorArgs);
    end else begin
      Log.AddMessage('Inspector is registered');
    end;

    DeleteInspectorForms(InspectorArgs);
    DeleteFormsForAbsentInspectors;

    if Assigned(OnADXNewInspector) then begin
      try
        event := TadxEventRaising.Create('OnADXNewInspector', [eoLockRegionState]);
        try
          OnADXNewInspector(Self, InspectorArgs.InspectorObj);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoOLNewInspector');
        end;
      end;
    end;

    //RegisterInspector(InspectorArgs);
    AddInspectorWindowForSearching(InspectorArgs);
    //DeleteInspectorWindowForSearching must be automatically

    //See DoInspectorWindowShow

    {$ELSE}
    {$ENDIF}
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLNewInspector: ' + E.Message), 'DoOLNewInspector');
  end;
  Log.RemoveIndent;
end;

function TadxOlFormsManager.IsRegisterExplorer(ExplorerWindowHandle: HWND): boolean;
var
  i: integer;
begin
  result := false;
  for i := 0 to TadxOlRegisterExplorerList(FRegisteredExplorerList).Count - 1 do begin
    if (TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).ExplorerWindowHandle = ExplorerWindowHandle) then begin
      result := true;
      exit;
    end;
  end;
end;

procedure TadxOlFormsManager.LockUpdates;
begin
  FisLockUpdates := true;
end;

procedure TadxOlFormsManager.ProcessFoldersWebViewPane(ExplorerObj: Explorer;
  FolderObj: MAPIFolder);
var
  FoldersObj: Folders;
  FolderItemObj: MAPIFolder;
  i: integer;
begin
  if (HasWebViewPane) then begin
    {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
    Log.AddMessage('ProcessFoldersWebViewPane');
    Log.AddIndent;
    if (FolderObj = nil) then exit;
    //Skip root
    //ProcessFolder(FolderObj);

    try
      FoldersObj := nil;
      FolderItemObj := nil;
      try
        FoldersObj := FolderObj.Folders;
        if (FoldersObj = nil) then exit;

        for i := 1 to FoldersObj.Count do begin
          try
            FolderItemObj := FoldersObj.Item(i);
            if (FolderItemObj = nil) then exit;

            //Recursive exclude Outbox
            if (not TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderItemObj, OutboxFolderEntryID)
              and not TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderItemObj, PublicFoldersAllPublicFoldersEntryID)
              and not TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderItemObj, PublicFoldersEntryID)
              and not TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderItemObj, FolderSyncIssuesEntryID)
              ) then begin

              ProcessFolderWebViewPane(ExplorerObj, FolderItemObj);
              ProcessFoldersWebViewPane(ExplorerObj, FolderItemObj);

            end;

          finally
            FolderItemObj := nil;
          end;
        end;

      finally
        FoldersObj := nil;
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddWarning(E.Message);
      end;
      //Stub
    end;
    Log.RemoveIndent;
  end;
end;

procedure TadxOlFormsManager.ProcessFolderWebViewPane(ExplorerObj: Explorer;
  FolderObj: MAPIFolder);
var
  index: integer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  if (HasWebViewPane) then begin

    {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
    Log.AddMessage('ProcessFolderWebViewPane');
    try
      if (FolderObj = nil) then exit;
      if (TadxOlFormsManagerState(State).isRefreshingFolder
          or (not TadxOlFormsManagerState(State).isProcessAllFolders)
              and (TadxOlOutlookUtils(OutlookUtils).IsUnderOutbox(FolderObj)

                   or TadxOlOutlookUtils(OutlookUtils).IsUnderFolder(PublicFoldersObj, FolderObj)
                   or TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderObj, PublicFoldersEntryID)

                   or TadxOlOutlookUtils(OutlookUtils).IsUnderFolder(FolderSyncIssuesObj, FolderObj)
                   or TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderObj, FolderSyncIssuesEntryID)

                   )
         ) then begin

         //Skip
         Log.AddMessage('Skip folder');

      end else begin

        ExplorerArgs := nil;
        if (ExplorerObj <> nil) then begin
          try
            ExplorerArgs := TadxOlExplorerArguments.CreateWithFolder(self, ExplorerObj, FolderObj, ccWebViewProcess);
            for index := 0 to Items.Count - 1 do begin
              if Items[index].IsWebViewPaneLayout and  Items[index].CorrespondExplorerContext(ExplorerArgs) then begin
                if (not ExplorerArgs.AdxWebViewURLForFolder) then begin
                  StoreFolderSettingsInRegistry(FolderObj);
                  TadxOlOutlookUtils(OutlookUtils).SetWebView(FolderObj, Self.HTMLFullFileName, true);
                end;
              end;
            end;
          finally
            if (ExplorerArgs <> nil) then begin
              ExplorerArgs.Free;
            end;
          end;
        end;

      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddWarning('ProcessFolderWebViewPane: ' + E.Message);
      end;
    end;
  end;
end;


procedure TadxOlFormsManager.DeleteInspectorForms(
  AInspectorArgs: TObject);
var
  index: integer;
begin
  Log.AddMessage('DeleteInspectorForms');
  TDebug.WriteLine('DeleteInspectorForms: ItemsCount' + IntToStr(Items.Count));
  for index := 0 to Items.Count - 1 do begin
    Items[index].DeleteInspectorForms(AInspectorArgs);
  end;
end;

procedure TadxOlFormsManager.HideInspectorForms(
  AInspectorArgs: TObject);
var
  index: integer;
begin
  Log.AddMessage('HideInspectorForms');
  try
    for index := 0 to Items.Count - 1 do begin
      Log.AddMessage('HideInspectorForms ' + IntToStr(index));
      Items[index].HideInspectorForms(AInspectorArgs);
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('HideInspectorForms ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxOlFormsManager.HideReadingPaneServiceForm(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  if (ExplorerArgs.ReadingPaneServiceForm <> nil) then begin
    ExplorerArgs.ReadingPaneServiceForm.HideByManager;
  end;
end;

procedure TadxOlFormsManager.HideFolderViewServiceForm(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  if (ExplorerArgs.FolderViewServiceForm <> nil) then begin
    ExplorerArgs.FolderViewServiceForm.HideByManager;
  end;
end;

procedure TadxOlFormsManager.DoShowInspectorForm(Item: TadxOlFormsCollectionItem;
  AInspectorArgs: TObject; WithoutFormCreating: boolean; CauseInspectorFormShowing: integer);
var
  InspectorArgs: TadxOlInspectorArguments;
  Form: TADXOlForm;
  AppWindowProperty: PAppWindowProperty;
  FindWindow: boolean;
  AdxOlInspector: TadxOlInspector;
  MessageResult: integer;
  args: TBeforeFormInstanceCreateEventArgs;
  Cancel: boolean;
  RaiseEvents: boolean;
  event: TadxEventRaising;
  finder: TFindWindowObject;
begin
  Log.AddMessage('DoShowInspectorForm');
  Log.AddIndent;
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  GetMem(AppWindowProperty, sizeof(TAppWindowProperty));
  NewAppWindowProperty(AppWindowProperty);
  try
    Item.SetInspectorAppWindowProperty(InspectorArgs, AppWindowProperty);
    AppWindowProperty.ReceiverHandle := ReceiverWindowHandle;

    //Case 769
    if ((not IsWindowVisible(appWindowProperty.WindowHandle)) and (CauseInspectorFormShowing = ord(ciChangingItemLayout))) then begin
      finder := TFindWindowFactory.CreateFindWindowObject(InspectorArgs.ContextInspectorAdxItemType);
      try
        appWindowProperty.WindowHandle := finder.Find(InspectorArgs.InspectorWindowHandle, [fwcWindowMustVisibleAndMorePixel]);
      finally
        finder.Free;
      end;
    end;


    if (appWindowProperty.WindowHandle > 0) then begin
      MessageResult := SendMessage(appWindowProperty.WindowHandle, WM_ADXGETTYPESUBCLASS, 0, 0);
      if (MessageResult = adxMessage_IsNET_Subclass) then begin
        //ProcessADXXError('ADX Extensions for Outlook: The current version does not support work with .NET add-ins.');
        //exit;
      end;

      FindWindow := (AppWindowProperty.WindowHandle > 0);
      if FindWindow then begin
        Form := Item.FindInspectorForm(InspectorArgs);

        if (Form = nil) and (not WithoutFormCreating) then begin
            Cancel := false;
            if Assigned(OnADXBeforeFormInstanceCreate) then begin
              try
                event := TadxEventRaising.Create('OnADXBeforeFormInstanceCreate', [eoLockRegionState]);
                try
                  OnADXBeforeFormInstanceCreate(self, Item, Cancel);
                finally
                  event.Free;
                end;
              except
                on E:SysUtils.Exception do begin
                  TadxExceptionManager.ProcessADXXError(E, 'DoShowInspectorForm');
                end;
              end;
            end;

            if Assigned(OnADXBeforeFormInstanceCreateEx) then begin
              args := TBeforeFormInstanceCreateEventArgs.Create(Item, InspectorArgs.InspectorObj, InspectorArgs);
              try
                try
                  event := TadxEventRaising.Create('OnADXBeforeFormInstanceCreateEx', [eoLockRegionState]);
                  try
                    OnADXBeforeFormInstanceCreateEx(self, args);
                  finally
                    event.Free;
                  end;
                except
                  on E:SysUtils.Exception do begin
                    TadxExceptionManager.ProcessADXXError(E, 'DoShowInspectorForm');
                  end;
                end;
                if (args.Cancel) then begin
                  Cancel := args.Cancel;
                end;
              finally
                args.Free;
              end;
            end;

            Form := Item.GetForm(Cancel);
        end;

        if (Form <> nil) and (not Form.Visible) and (not Form.IsHidenByDeveloper) and (not Form.Injected) then begin

          if InspectorArgs.IsWordMailInspector then begin
            if (PAppWindowProperty(AppWindowProperty)^.WindowHandle = 0) then begin
              TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlFormsManager.DoShowInspectorForm: WindowHandle = 0'), 'DoShowInspectorForm');
            end;

            GetRegisterAdxOlInspector(InspectorArgs.InspectorWindowHandle, Pointer(AdxOlInspector));
            if (AdxOlInspector = nil) then begin
              TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlFormsManager.DoShowInspectorForm: Inspector = nil'), 'DoShowInspectorForm');
            end;


            AdxOlInspector.DoEmulateWindowHandle(appWindowProperty.WindowHandle);
            PAppWindowProperty(AppWindowProperty)^.EmulateWindowHandle := AdxOlInspector.FEmulateWindowHandle;
          end;

{$IFDEF CLIENTLAYOUTS}
          DoShowInspectorServiceForm(Item, InspectorArgs, AppWindowProperty.EmulateWindowHandle, AppWindowProperty.WindowHandle);
{$ENDIF}
          Form.InitializeForm(InspectorArgs, AppWindowProperty);
          RaiseEvents := not InspectorArgs.ChangingInspectorWindowHandle;
          Form.AdxOlShow(AppWindowProperty, RaiseEvents);
        end;
      end
      else begin
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoShowInspectorForm: ' + ' Window not found. '
          + Format('Handle: %x', [InspectorArgs.InspectorWindowHandle])
          + ' ItemType = ' + IntToStr(AppWindowProperty.ItemType)), 'DoShowInspectorForm');
      end;
    end;
  finally
      FreeMem(AppWindowProperty);
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.DoShowInspectorServiceForm(
  Item: TadxOlFormsCollectionItem; AInspectorArgs: TObject; EmulateWindowHandle, WindowHandle: HWND);
var
  InspectorArgs: TadxOlInspectorArguments;
  serviceFormCaption: TadxCaption;
  ServiceFormAppWindowProperty: PAppWindowProperty;
  serviceForm: TadxForm;
  NeedShowServiceForm: boolean;
begin
  Log.AddMessage('DoShowInspectorServiceForm');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  if (Item.IsInspectorRegionClientLayout) then begin
    NeedShowServiceForm := (InspectorArgs.IsWordMailInspector and not ExistsServiceForm(EmulateWindowHandle))
    or (not InspectorArgs.IsWordMailInspector and not ExistsServiceForm(WindowHandle));

    if NeedShowServiceForm then begin
      GetMem(ServiceformAppWindowProperty, sizeof(TAppWindowProperty));
      try
        NewAppWindowProperty(ServiceFormAppWindowProperty);
        Item.SetInspectorAppWindowProperty(InspectorArgs, ServiceFormAppWindowProperty);
        serviceformAppWindowProperty^.Splitter := Ord(sbNone);
        StrPCopy(serviceFormCaption, GetInspectorServiceFormCaption(InspectorArgs.InspectorItemTypeCaption, Item.InspectorLayout));
        serviceformAppWindowProperty^.Caption := serviceFormCaption;
        serviceformAppWindowProperty^.CloseButton := false;
        serviceformAppWindowProperty^.SplitterButton := false;
        serviceformAppWindowProperty^.RegionBorder := rbsSingle;

        serviceformAppWindowProperty^.AlwaysShowHeader := false;
        serviceformAppWindowProperty^.EmulateWindowHandle := EmulateWindowHandle;
        serviceformAppWindowProperty^.ReceiverHandle := ReceiverWindowHandle;

        serviceForm := InspectorArgs.GetServiceForm(Item.InspectorLayout);
        if (serviceForm <> nil) then begin
          TadxFormProtected(serviceForm).InitProperties(serviceformAppWindowProperty);
          TadxFormProtected(serviceForm).ShowInternal;
        end
        else begin
          Log.AddWarning('serviceForm == null');
        end;
      finally
        FreeMem(ServiceFormAppWindowProperty);
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.DoShowReadingPaneServiceForm(
  Item: TadxOlFormsCollectionItem; AExplorerArgs: TObject;
  WindowHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  serviceFormCaption: TadxCaption;
  ServiceformAppWindowProperty: PAppWindowProperty;
  serviceForm: TadxForm;
begin
  Log.AddMessage('DoShowReadingPaneServiceForm');
  if (Item.IsReadingPaneClientLayout) then begin
    if (not ExistsServiceForm(WindowHandle)) then begin
      ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
      GetMem(ServiceformAppWindowProperty, sizeof(TAppWindowProperty));
      try
        NewAppWindowProperty(ServiceformAppWindowProperty);
        Item.SetExplorerAppWindowProperty(ExplorerArgs, ServiceformAppWindowProperty, 0);
        serviceformAppWindowProperty^.Splitter := Ord(sbNone);
        StrPCopy(serviceFormCaption, GetExplorerServiceFormCaption(Item.ExplorerLayout));
        serviceformAppWindowProperty^.Caption := serviceFormCaption;
        serviceformAppWindowProperty^.CloseButton := false;
        serviceformAppWindowProperty^.SplitterButton := false;
        serviceformAppWindowProperty^.RegionBorder := rbsSingle;
        serviceformAppWindowProperty^.AlwaysShowHeader := false;
        serviceformAppWindowProperty^.ReceiverHandle := ReceiverWindowHandle;

        serviceForm := ExplorerArgs.GetServiceForm(Item.ExplorerLayout);
        if (serviceForm <> nil) then begin
          TadxFormProtected(serviceForm).InitProperties(serviceformAppWindowProperty);
          TadxFormProtected(serviceForm).ShowInternal;
        end
        else begin
          Log.AddWarning('serviceForm == null');
        end;
      finally
        FreeMem(ServiceformAppWindowProperty);
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.DoWebViewHide(AExplorerArgs: TObject;
  AContainerHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  Log.AddMessage('DoWebViewHide');
  try
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
      Items[index].HideExplorerForms(ExplorerArgs);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoWebViewHide: ' + E.Message), 'DoWebViewHide');
  end;
end;

procedure TadxOlFormsManager.DoWebViewLoad(AExplorerArgs: TObject;
  AContainerHandle: HWND; AWidth, AHeight: integer);
{$IFDEF WithADXHTMLFile}
var
  ExplorerArgs: TadxOlExplorerArguments;
  Index: integer;
{$ENDIF}
begin
{$IFDEF WithADXHTMLFile}
//See VSS
{$ENDIF}
end;

procedure TadxOlFormsManager.ProcessRootFoldersWebViewPane(ExplorerObj: Explorer);
var
  OutlookNameSpaceObj: NameSpace;
  FoldersObj: Folders;
  FolderItemObj: MAPIFolder;
  i: integer;

begin
  if (HasWebViewPane) then begin
    Log.AddMessage('ProcessRootFoldersWebViewPane');
    Log.AddIndent;
    {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
    OutlookNameSpaceObj := nil;
    FoldersObj := nil;

    TadxOlFormsManagerState(State).isProcessAllFolders := true;
    try
      OutlookNameSpaceObj := OutlookAppObj.GetNamespace('MAPI');
      if (OutlookNameSpaceObj <> nil) then begin
        FoldersObj := OutlookNameSpaceObj.Folders;
        if (FoldersObj <> nil) then begin
          for i := 1 to FoldersObj.Count do begin
            FolderItemObj := FoldersObj.Item(i);
            Log.AddMessage('NameSpace folder: ' + FolderItemObj.Name);
            try
              if (not TadxOlOutlookUtils(OutlookUtils).CompareFolders(FolderItemObj, PublicFoldersEntryID)) then begin
                ProcessFoldersWebViewPane(ExplorerObj, FolderItemObj);
              end
              else begin
                Log.AddMessage('Skip PublicFolders');
              end;

            finally
              FolderItemObj := nil;
            end;
          end;
        end;
      end;
    finally
      TadxOlFormsManagerState(State).isProcessAllFolders := false;
      OutlookNameSpaceObj := nil;
      FoldersObj := nil;
    end;
    Log.RemoveIndent;
  end;
end;

procedure TadxOlFormsManager.RefreshCurrentFolder(AExplorerArgs: TObject);
var
  OutboxFolderObj: MAPIFolder;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  Log.AddMessage(COMAddInModule.AddInName + '.RefreshCurrentFolder');

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  if (OutlookVersion = v2007)
    or (OutlookVersion = v2010) then begin
    //Refresh logica for Outlook 2007
    FRefreshCurrentFolderObj := ExplorerArgs.FolderObj;
    FRefreshSecondaryFolderObj := TadxOlOutlookUtils(OutlookUtils).GetDefaultFolder(olFolderOutbox);
    TadxOlFormsManagerState(State).isRefreshingFolder := true;
    adxextLockWindowUpdate(ExplorerArgs.ExplorerWindowHandle);
    TadxOlOutlookUtils(OutlookUtils).SetExplorerFolder(ExplorerArgs.ExplorerObj, FRefreshSecondaryFolderObj, OutlookVersion);
  end
  else begin

    OutboxFolderObj := nil;

    try
      TadxOlFormsManagerState(State).isRefreshingFolder := true;

      try
          OutboxFolderObj := TadxOlOutlookUtils(OutlookUtils).GetDefaultFolder(olFolderOutbox);
      except
          OutboxFolderObj := nil;
      end;

      if (OutboxFolderObj <> nil) then begin

        try
          adxextLockWindowUpdate(ExplorerArgs.ExplorerWindowHandle);

          TadxOlOutlookUtils(OutlookUtils).SetExplorerFolder(ExplorerArgs.ExplorerObj, OutboxFolderObj, OutlookVersion);
          Application.ProcessMessages;
          TadxOlOutlookUtils(OutlookUtils).SetExplorerFolder(ExplorerArgs.ExplorerObj, ExplorerArgs.FolderObj, OutlookVersion);

        finally
          //For VCL only
          TadxOlFormsManagerState(State).OutlookNewExplorerJustNowOccured := false;
          adxextUnlockWindowUpdate(ExplorerArgs.ExplorerWindowHandle);
        end;

      end;

    finally
      TadxOlFormsManagerState(State).isRefreshingFolder := false;
      OutboxFolderObj := nil;
    end;
  end;

end;


procedure TadxOlFormsManager.RefreshCurrentFolderForAllExplorers;
var
  ExplorersObj: Explorers;
  ExplorerObj: Explorer;
  ExplorersCount, i: Integer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('RefreshCurrentFolderForAllExplorers');

  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  try
    ExplorersObj := OutlookAppObj.Explorers;
    if (ExplorersObj <> nil) then begin
      ExplorersCount := ExplorersObj.Count;
      for i := 1 to ExplorersCount do begin
        try
          ExplorerObj := ExplorersObj.Item(i);
          if (ExplorerObj <> nil) then begin
            ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccFolderEvent);
            try
              RefreshCurrentFolder(ExplorerArgs);
            finally
              ExplorerArgs.Free;
            end;
          end;
        finally
          ExplorerObj := nil;
        end;
      end;
    end;
  finally
    ExplorersObj := nil;
  end;
end;

procedure TadxOlFormsManager.RegisterExplorer(AExplorerObject: _Explorer; ExplorerWindowHandle: HWND);
begin
  Log.AddMessage('RegisterExplorer 1');
  TadxOlRegisterExplorerList(FRegisteredExplorerList).Add(TadxOlExplorer.Create(Self, AExplorerObject, ExplorerWindowHandle));
end;

procedure TadxOlFormsManager.RegisterMessages;
begin
  Log.AddMessage('RegisterMessages');
  {$IFDEF UNICODE}
  msgAddForm := RegisterWindowMessage(PChar(Globals.WM_ADD_ALIEN_FORM));
  msgResizeTab := RegisterWindowMessage(PChar(Globals.WM_RESIZE_TAB));;
  msgDeletedProcInHooksChain := RegisterWindowMessage(PChar(Globals.WM_DELETE_PROC_IN_HOOKS_CHAIN));;
  {$ELSE}
  msgAddForm := RegisterWindowMessage(PansiChar(Globals.WM_ADD_ALIEN_FORM));
  msgResizeTab := RegisterWindowMessage(PansiChar(Globals.WM_RESIZE_TAB));;
  msgDeletedProcInHooksChain := RegisterWindowMessage(PansiChar(Globals.WM_DELETE_PROC_IN_HOOKS_CHAIN));;
  {$ENDIF}
end;


procedure TadxOlFormsManager.DeleteFormsForAbsentInspectors;
var
  index: integer;
begin
  Log.AddMessage('DeleteFormsForAbsentInspectors');
  TDebug.WriteLine('DeleteFormsForAbsentInspectors');
  index := 0;
  while index < Items.Count do begin
    Items[index].DeleteFormsForAbsentInspectors;
    Inc(index);
  end;
end;

procedure TadxOlFormsManager.FreeExistentInspectors;
var
  InspectorArgs: TadxOlInspectorArguments;
  index: integer;
begin
  Log.AddMessage('FreeExistingInspectors');
  Log.AddIndent;

  try
    InspectorArgs := nil;
    while TadxOlRegisterInspectorList(FRegisteredInspectorList).Count > 0 do begin
      try
        try
          InspectorArgs := TadxOlInspectorArguments.Create(self,
            TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[0]).InspectorObject,
            TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[0]).InspectorWindowHandle, ccUnregisterInspector);
        except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentInspectors (InspectorArgs) ' + #13#10 + E.Message), 'FreeExistentInspectors');
        end;

        try
          for index := 0 to Items.Count - 1 do begin
            Items[index].DeleteInspectorForms(InspectorArgs);
          end;
        except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentInspectors (DeleteInspectorForms) ' + #13#10 + E.Message), 'FreeExistentInspectors');
        end;

        try
          if Assigned(FWatchEngine) then begin
            TDebug.WriteLine('Access to TWatchEngine');
            TWatchEngine(FWatchEngine).DeleteByHostHandle(InspectorArgs.InspectorWindowHandle);
          end;
        except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentInspectors (DeleteByHostHandle) ' + #13#10 + E.Message), 'FreeExistentInspectors');
        end;

        try
          TadxOlRegisterInspectorList(FRegisteredInspectorList).Delete(0);
        except
          on E:SysUtils.Exception do
            TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentInspectors (FRegisteredInspectorList) ' + #13#10 + E.Message), 'FreeExistentInspectors');
        end;

        TDebug.WriteLine('FreeExistentInspectors ' + IntToStr(TadxOlRegisterInspectorList(FRegisteredInspectorList).Count));
      finally
        if Assigned(InspectorArgs) then begin
          InspectorArgs.Free;
          InspectorArgs := nil;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentInspectors ' + E.Message), 'FreeExistentInspectors');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.RestoreWebViewFolderSettings;
var
  Reg: TRegistry;
  names: TStringList;
  values: TStringList;
  i: integer;
  FolderObj: MAPIFolder;
begin
  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  Log.AddMessage('RestoreWebViewFolderSettings');
  Log.AddIndent;
  try
    if not Assigned(COMAddInModule) then exit;
    Reg := TRegistry.Create;
    names := TStringList.Create;
    values := TStringList.Create;
    try
      Reg.OpenKey(COMAddInModule.RegistryKey + '\' + ADXXOL + '\' + WebView, true);

      Reg.GetValueNames(names);
      for i := 0 to names.Count - 1 do begin
        FolderObj := nil;
        try
          try
            RegistryReadStrings(names[i], values, Reg);
            if (values.Count = 2) then begin
              FolderObj := TadxOlOutlookUtils(OutlookUtils).FolderFromEntryID(names[i]);
              if (FolderObj <> nil) then begin
                if (Globals.CompareADXStrings(values[0], EMPTY)) then
                    values[0] := EmptyStr;
                if values[1] = 'true' then begin
                  TadxOlOutlookUtils(OutlookUtils).SetWebView(FolderObj, values[0], true);
                  TDebug.WriteLine('RestoreWebViewFolderSettings SetWebView true');

                end else begin
                  TadxOlOutlookUtils(OutlookUtils).SetWebView(FolderObj, values[0], false);
                  TDebug.WriteLine('RestoreWebViewFolderSettings SetWebView false');
                end;

              end;
            end;
          except
            //Stub
          end;
        finally
          FolderObj := nil;
          Reg.DeleteValue(names[i]);
        end;
      end;
    finally
      values.Free;
      names.Free;
      Reg.Free;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('RestoreWebViewFolderSettings ' + E.Message), 'RestoreWebViewFolderSettings');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.SetItems(const Value: TadxOlFormsCollection);
begin
  FItems := Value;
end;

procedure TadxOlFormsManager.SetOutlookUtils(
  const Value: pointer);
begin
  FOutlookUtils := Value;
end;

procedure TadxOlFormsManager.SetOutlookVersion;
var
  hostVersion: string;
  OutlookApp: OutlookApplication;
begin
  if not Assigned(COMAddinModule) then exit;

  FOutlookVersion := vUnknown;

  OutlookApp := COMAddInModule.OutlookApp.DefaultInterface;
  try
    hostVersion := OutlookApp.Version;
    Log.AddSystemInfo('Outlook version: ' + hostVersion);

    if (Pos('9.0', hostVersion) > 0) then
        FOutlookVersion := v2000;

    if (Pos('10.0', hostVersion) > 0) then
        FOutlookVersion := v2002;

    if (Pos('11.0', hostVersion) > 0) then
        FOutlookVersion := v2003;

    if (Pos('12.0', hostVersion) > 0) then
        FOutlookVersion := v2007;

    if (Pos('14.0', hostVersion) > 0) then
        FOutlookVersion := v2010;

    if FOutlookVersion = vUnknown then
      raise EAbort.Create('Outlook version is not defined. SetOutlookVersion.');

    TadxOlOutlookUtils(FOutlookUtils).FOutlookVersion := FOutlookVersion;
  finally
    OutlookApp := nil;
  end;
end;

procedure TadxOlFormsManager.SetState(
  const Value: pointer);
begin
  FState := Value;
end;

procedure TadxOlFormsManager.StoreFolderSettingsInRegistry(
  FolderObj: MAPIFolder);
var
  WebViewURL: string;
  WebViewOn: boolean;
  EntryID: string;
  Reg: TRegistry;
  values: TStringList;
begin
  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  if not Assigned(COMAddinModule) then exit;
  EntryID := EmptyStr;

  EntryID := TadxOlOutlookUtils(OutlookUtils).GetEntryID(FolderObj);
  WebViewURL := TadxOlOutlookUtils(OutlookUtils).GetWebViewURL(FolderObj);
  WebViewOn := TadxOlOutlookUtils(OutlookUtils).GetWebViewOn(FolderObj);

  if (EntryID <> EmptyStr) then begin
     Reg := TRegistry.Create;
     try
       if Reg.OpenKey(COMAddInModule.RegistryKey + '\' + ADXXOL + '\' + WebView, true) then begin
         if (not Reg.ValueExists(EntryID)) then begin
           if (WebViewURL = EmptyStr) then WebViewURL := EMPTY;
           values := TStringList.Create;
           try
             values.Add(WebViewURL);
             if (WebViewOn) then
               values.Add('true')
             else
               values.Add('false');

             RegistryWriteStrings(EntryID, values, Reg);
           finally
             values.Free;
           end;
         end;
       end;
     finally
       Reg.CloseKey;
       Reg.Free;
     end;
  end;
end;

procedure TadxOlFormsManager.OnCallBack(const key: string; const i1, i2,
  i3: Integer; const s1, s2, s3: string);
var
  ContainerHandle: Integer;
  Width, Height: Integer;
  ExplorerArgs: TadxOlExplorerArguments;
  ExplorerObj: Explorer;
begin
  Log.AddMessage('Event: OnCallBack');

  if (TadxOlFormsManagerState(State).isNotifyAddin) then exit;

  if (Globals.CompareADXStrings(key, WebViewLoadFlag)) then begin
      ContainerHandle := i1;
      Width := i2;
      Height := i3;
      ExplorerObj := TadxOlOutlookUtils(OutlookUtils).GetActiveExplorer;
      ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccFolderEvent);
      try
        DoWebViewLoad(ExplorerArgs, ContainerHandle, Width, Height);
      finally
        ExplorerArgs.Free;
        ExplorerObj := nil;
      end;
  end;

  if (Globals.CompareADXStrings(key, WebViewHideFlag)) then begin
      ExplorerObj := TadxOlOutlookUtils(OutlookUtils).GetActiveExplorer;
      ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccExplorerClose);
      ContainerHandle := i1;
      try
        DoWebViewHide(ExplorerArgs, ContainerHandle);
      finally
        ExplorerArgs.Free;
        ExplorerObj := nil;
      end;
  end;
end;

procedure TadxOlFormsManager.UnlockUpdates;
begin
  FisLockUpdates := false;
end;

procedure TadxOlFormsManager.UnregisterExplorer(ExplorerWindowHandle: HWND);
begin
  Log.AddMessage('UnregisterExplorer');
  try
    TadxOlRegisterExplorerList(FRegisteredExplorerList).DeleteByExplorerWindowHandle(ExplorerWindowHandle);
    if Assigned(FWatchEngine) then begin
      TDebug.WriteLine('Access to TWatchEngine');
      TWatchEngine(FWatchEngine).DeleteByHostHandle(ExplorerWindowHandle);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('UnregisterExplorer ' + E.Message), 'UnregisterExplorer');
  end;
end;

procedure TadxOlFormsManager.RegisterInspector(AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  adxOlInspector: TadxOlInspector;
begin
  Log.AddMessage('RegisterInspector');
  Log.AddIndent;
  try
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
    adxOlInspector := TadxOlInspector.Create(Self, InspectorArgs.InspectorObj, InspectorArgs.InspectorWindowHandle, InspectorArgs.IsWordMailInspector);
    //ValidateInspector(adxOlInspector);
    TadxOlRegisterInspectorList(FRegisteredInspectorList).Add(adxOlInspector);
  finally
    Log.RemoveIndent;
  end;
end;

function TadxOlFormsManager.GetOutlookVersion: TadxolOutlookVersion;
begin
  if FOutlookVersion = vUnknown then begin
    raise EAbort.Create('Outlook version is not defined. GetOutlookVersion.')
  end;
  result := FOutlookVersion;
end;

procedure TadxOlFormsManager.OnOLInspectorActivate(Sender: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  InspectorWindowHandle: HWND;
  index: integer;
begin
  try
    if Assigned(FOldOLInspectorActivate) then
      FOldOLInspectorActivate(Sender);
  finally
    Log.AddMessage('Event: OnOLInspectorActivate');
    try
      InspectorWindowHandle := 0;
      for index := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
        if (TInspector(Sender).DefaultInterface = TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[index]).FInspectorObj)  then
          InspectorWindowHandle := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[index]).FInspectorWindowHandle;
      end;
      if (IsWindowVisible(InspectorWindowHandle)) then begin //meeting request -> accept
        InspectorArgs := TadxOlInspectorArguments.Create(Self, TInspector(Sender).DefaultInterface, InspectorWindowHandle, ccInspectorActivate);
        try
          DoOLInspectorActivate(InspectorArgs);
        finally
          InspectorArgs.Free;
        end;
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnOLInspectorActivate')
      end;
    end;
  end;
end;


function TadxOlFormsManager.GetInspectorAdxItemType(InspectorItemType: TadxOlInspectorItemType; MailInspectorType: integer): TAdxItemType;
begin
  case InspectorItemType of
      insRecipient:
          result := stOlDefaultInspector;
      insAppointment:
          result := stOlAppointmentInspector;
      insMeetingRequest:
          result := stOlMeetingInspector;
      insMeetingCancellation:
          result := stOlMeetingInspector;
      insMeetingResponseNegative:
          result := stOlMeetingInspector;
      insMeetingResponsePositive:
          result := stOlMeetingInspector;
      insMeetingResponseTentative:
          result := stOlMeetingInspector;
      insContact:
          result := stOlContactInspector;
      insJournal:
          result := stOlJournalInspector;
      insMail, insPost:
        case TadxolMailPostInspectorType(MailInspectorType) of
          mitStandard:
            result := stOlMailInspector;
          mitWordEditor:
            result := stOlWordMailInspector;
          else
            result := stOlDefaultInspector;
        end;
      insTask:
          result := stOlTaskInspector;
      insTaskRequest:
          result := stOlTaskInspector;
      insTaskRequestUpdate:
          result := stOlTaskInspector;
      insTaskRequestAccept:
          result := stOlTaskInspector;
      insTaskRequestDecline:
          result := stOlTaskInspector;
      insDistributionList:
          result := stOlDistributionListInspector;
      insReport:
          result := stOlReportInspector;
      insSharing:
          result := stOlSharingInspector;
      insMobile:
          result := stOlMobileInspector;
      else
          Log.AddWarning('GetInspectorAdxItemType : ' + IntToStr(ord(InspectorItemType)) + ' -> stOlUnknown');
          result := stOlUnknown;
  end;
end;

function TadxOlFormsManager.GetInspectorServiceFormCaption(
  InspectorItemTypeCaption: string;
  InspectorLayout: TadxolInspectorLayout): string;
begin
  case InspectorLayout of
    ilInspectorRegion: result := InspectorItemTypeCaption;
{$IFDEF SUBSTINSPECTORREGION}
    ilCompleteReplacement: result := InspectorItemTypeCaption;
{$ENDIF}
    else result := InspectorItemTypeCaption + ' [unknown]';
  end;
end;

procedure TadxOlFormsManager.AddExplorerWindowForSearching(HostHandle: HWND; ItemType: TAdxItemType);
var
  watchObject: THostHandleWatchObject;
begin
  if (ItemType = stOlTodoBar) then begin
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TShowTodoBarMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TShowTodoBarMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowShow));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(THideTodoBarMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (THideTodoBarMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowHide));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TMinimizeTodoBarMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TMinimizeTodoBarMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowMinimize));

    if (self.FOutlookVersion = v2007) then begin
      //Outlook 2010 ToDoBar events are not supported Case 687 (self.FOutlookVersion = v2010)
      watchObject :=
        //TVisibleMinimizeUnvisibleChangeWatchObject.Create(
        TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.Create(
        FOutlookHandleFinder as TOutlookHandleFinder,
        TShowTodoBarMessage.Create(self.ReceiverWindowHandle, nil),
        THideTodoBarMessage.Create(self.ReceiverWindowHandle, nil),
        TMinimizeTodoBarMessage.Create(self.ReceiverWindowHandle, nil),
        HostHandle,
        ItemType,
        OutlookVersion);
      //TWatchEngine(FWatchEngine).Add(watchObject);
      FOutlookHook.AddHandleHookWatchObject(watchObject);
    end;

    if (self.FOutlookVersion = v2010) then begin
       watchObject := TTodoBarOutlook2010WatchObject.Create(HostHandle);
       FOutlookHook.AddHandleHookWatchObject(watchObject);
    end;

  end;

  if (ItemType = stOlNavigationPane) then begin

    if (not TadxReceiverWindow(FReceiverWindow).Exists(TShowNavigationPaneMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TShowNavigationPaneMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowShow));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(THideNavigationPaneMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (THideNavigationPaneMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowHide));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TMinimizeNavigationPaneMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TMinimizeNavigationPaneMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowMinimize));


    if (self.FOutlookVersion = v2007)
      or (self.FOutlookVersion = v2010) then begin
      watchObject :=
        //TVisibleMinimizeUnvisibleChangeWatchObject.Create(
        TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.Create(
        FOutlookHandleFinder as TOutlookHandleFinder,
        TShowNavigationPaneMessage.Create(self.ReceiverWindowHandle, nil),
        THideNavigationPaneMessage.Create(self.ReceiverWindowHandle, nil),
        TMinimizeNavigationPaneMessage.Create(self.ReceiverWindowHandle, nil),
        HostHandle,
        ItemType,
        OutlookVersion);
      //TWatchEngine(FWatchEngine).Add(watchObject);
      FOutlookHook.AddHandleHookWatchObject(watchObject);
    end
    else begin
      watchObject :=
        //TVisibleChangeWindowWatchObjectV2010.Create(
        TNavigationPaneVisibleChangeWindowWatchObjectV2010.Create(
        FOutlookHandleFinder as TOutlookHandleFinder,
        TShowNavigationPaneMessage.Create(self.ReceiverWindowHandle, nil),
        THideNavigationPaneMessage.Create(self.ReceiverWindowHandle, nil),
        HostHandle,
        ItemType,
        OutlookVersion);
      //TWatchEngine(FWatchEngine).Add(watchObject);
      FOutlookHook.AddHandleHookWatchObject(watchObject);
    end;
  end;


  if (ItemType = stOlReadingPane) then begin
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TShowReadingPaneMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TShowReadingPaneMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowShow));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(THideReadingPaneMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (THideReadingPaneMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowHide));

    watchObject :=
      TReadingPaneVisibleChangeWindowWatchObjectV2010.Create(
      FOutlookHandleFinder as TOutlookHandleFinder,
      TShowReadingPaneMessage.Create(self.ReceiverWindowHandle, nil),
      THideReadingPaneMessage.Create(self.ReceiverWindowHandle, nil),
      HostHandle,
      ItemType,
      OutlookVersion);

    //TWatchEngine(FWatchEngine).Add(watchObject);
    FOutlookHook.AddHandleHookWatchObject(watchObject);

  end;

  if (ItemType = stOlFolderList) then begin
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TShowFolderListMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TShowFolderListMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowShow));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(THideFolderListMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (THideFolderListMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowHide));

    watchObject :=
      //TVisibleChangeWindowWatchObject.Create(
      TFolderListVisibleChangeWindowWatchObjectV2010.Create(
      FOutlookHandleFinder as TOutlookHandleFinder,
      TShowFolderListMessage.Create(self.ReceiverWindowHandle, nil),
      THideFolderListMessage.Create(self.ReceiverWindowHandle, nil),
      HostHandle,
      ItemType,
      OutlookVersion);
    //TWatchEngine(FWatchEngine).Add(watchObject);
    FOutlookHook.AddHandleHookWatchObject(watchObject);
  end;

  if (ItemType = stOlOutlookBar) then begin
    if (not TadxReceiverWindow(FReceiverWindow).Exists(TShowOutlookBarMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TShowOutlookBarMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowShow));
    if (not TadxReceiverWindow(FReceiverWindow).Exists(THideOutlookBarMessage)) then
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (THideOutlookBarMessage.Create(self.ReceiverWindowHandle, OnCommonReceiverWindowHide));

    watchObject :=
      //TVisibleChangeWindowWatchObject.Create(
      TOutlookBarVisibleChangeWindowWatchObjectV2010.Create(
      FOutlookHandleFinder as TOutlookHandleFinder,
      TShowOutlookBarMessage.Create(self.ReceiverWindowHandle, nil),
      THideOutlookBarMessage.Create(self.ReceiverWindowHandle, nil),
      HostHandle,
      ItemType,
      OutlookVersion);
    //TWatchEngine(FWatchEngine).Add(watchObject);
    FOutlookHook.AddHandleHookWatchObject(watchObject);
  end;
end;

procedure TadxOlFormsManager.OnCommonExplorerWindowHide(HostHandle: HWND; ItemType: TADXItemType);
var
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('Event OnCommonExplorerWindowHide');
  TDebug.WriteLine('OnCommonExplorerWindowHide');
  if TadxOlFormsManagerState(State).isExplorerCloseRunning then begin
    exit;
  end;
  ExplorerArgs := nil;

  try

  GetRegisterExplorer(HostHandle, ExplorerObj);

  if ExplorerObj <> nil then begin
    ExplorerArgs := nil;
    ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccExplorerClose);

    case ItemType of
      stOlOutlookBar: begin
        DoOutlookBarHide(ExplorerArgs);
      end;
      stOlFolderList: begin
        DoFolderListHide(ExplorerArgs);
      end;
      stOlNavigationPane: begin
        DoNavigationPaneHide(ExplorerArgs);
      end;
      stOlTodoBar: begin
        DoTodoBarHide(ExplorerArgs);
      end;
      stOlReadingPane: begin
        DoReadingPaneHide(ExplorerArgs);
      end;
    end;
  end;
  finally
    if Assigned(ExplorerArgs) then
      ExplorerArgs.Free;

    ExplorerObj := nil
  end;
end;

procedure TadxOlFormsManager.OnCommonExplorerWindowShow(HostHandle: HWND; ItemType: TADXItemType);
var
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('Event OnCommonExplorerWindowShow');
  ExplorerArgs := nil;
  try
    GetRegisterExplorer(HostHandle, ExplorerObj);
    if (ExplorerObj <> nil) then begin
      ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccNewExplorer);
      case ItemType of
        stOlOutlookBar: begin
          DoOutlookBarShow(ExplorerArgs);
        end;
        stOlFolderList: begin
          DoFolderListShow(ExplorerArgs);
        end;
        stOlNavigationPane: begin
          DoNavigationPaneShow(ExplorerArgs);
        end;
        stOlTodoBar: begin
          DoTodoBarShow(ExplorerArgs);
        end;
        stOlReadingPane: begin
          DoReadingPaneShow(ExplorerArgs);
        end;
      end;
    end;
  finally
    if Assigned(ExplorerArgs) then begin
      ExplorerArgs.Free;
    end;
    ExplorerObj := nil
  end;
end;

procedure TadxOlFormsManager.GetRegisterExplorer(
  ExplorerWindowHandle: HWND; var ExplorerObj: Explorer);
var
  i: integer;
begin
  ExplorerObj := nil;
  for i := 0 to TadxOlRegisterExplorerList(FRegisteredExplorerList).Count - 1 do begin
    if (TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).ExplorerWindowHandle = ExplorerWindowHandle) then begin
      ExplorerObj := TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).ExplorerObj;
      exit;
    end;
  end;
end;

procedure TadxOlFormsManager.DoFolderListHide(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneHideEventArgs;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoFolderListHide');
  try
    {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsNavigationPaneLayout then begin
        Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;

    if Assigned(OnADXNavigationPaneHide) then begin
      args := TadxOlNavigationPaneHideEventArgs.Create(false);
      try
        try
          event := TadxEventRaising.Create('OnADXNavigationPaneHide', [eoLockRegionState]);
          try
            OnADXNavigationPaneHide(Self, args);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'DoFolderListHide');
          end;
        end;
      finally
        args.Free;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoFolderListHide' + E.Message), 'DoFolderListHide');
  end;
end;

procedure TadxOlFormsManager.DoFolderListShow(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneShowEventArgs;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoFolderListShow');
  try
    {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
    if not TadxOlFormsManagerState(State).WasAddinInitialize then
      exit;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    if Assigned(OnADXNavigationPaneShow) then begin
      args := TadxOlNavigationPaneShowEventArgs.Create(false);
      try
        try
          event := TadxEventRaising.Create('OnADXNavigationPaneShow', [eoLockRegionState]);
          try
            OnADXNavigationPaneShow(Self, args);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'DoFolderListShow');
          end;
        end;
      finally
        args.Free;
      end;
    end;

    for Index := 0 to Items.Count - 1 do begin
      if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin
        if Items[Index].IsNavigationPaneLayout then begin
          DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoFolderListShow: ' + E.Message), 'DoFolderListShow');
  end;
end;

procedure TadxOlFormsManager.DoNavigationPaneHide(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneHideEventArgs;
  event: TadxEventRaising;
  indent: TLogIndent;
begin
  try
    indent := TLogIndent.Create('@@@ @@@ DoNavigationPaneHide');

    try
      {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
      ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

      //TODO !!!
      HideAllFormsInAllAddins(GetNavigationPaneLayoutWindowHandle(ExplorerArgs));

      for index := 0 to Items.Count - 1 do begin
        if Items[index].IsNavigationPaneLayout then begin
          Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
          Items[index].HideExplorerForms(ExplorerArgs);
        end;
      end;

      if Assigned(OnADXNavigationPaneHide) then begin
        args := TadxOlNavigationPaneHideEventArgs.Create(false);
        try
          event := TadxEventRaising.Create('OnADXNavigationPaneHide', [eoLockRegionState]);
          try
            OnADXNavigationPaneHide(Self, args);
          finally
            event.Free;
          end;
        finally
          args.Free;
        end;
      end;
    finally
      indent.Free;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoNavigationPaneHide: ' + E.Message), 'DoNavigationPaneHide');
  end;
end;

procedure TadxOlFormsManager.DoNavigationPaneShow(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneShowEventArgs;
  event: TadxEventRaising;
  indent: TLogIndent;
begin
  try
    indent := TLogIndent.Create('@@@ @@@ DoNavigationPaneShow');
    try
      {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
      if not TadxOlFormsManagerState(State).WasAddinInitialize then
        exit;
      ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

      if Assigned(OnADXNavigationPaneShow) then begin
        args := TadxOlNavigationPaneShowEventArgs.Create(false);
        try
          event := TadxEventRaising.Create('OnADXNavigationPaneShow', [eoLockRegionState]);
          try
            OnADXNavigationPaneShow(Self, args);
          finally
            event.Free;
          end;
        finally
          args.Free;
        end;
      end;

      if not TadxOlFormsManagerState(State).isFolderSwitchExecuting then begin
        for Index := 0 to Items.Count - 1 do begin
          if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin
            if Items[Index].IsNavigationPaneLayout then begin
              DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
            end;
          end;
        end;
      end
      else begin
        Log.AddMessage('Prevent showing forms in DoNavigationPaneShow when isFolderSwitchExecuting');
      end;
    finally
      indent.Free;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoNavigationPaneShow: ' + E.Message), 'DoNavigationPaneShow');
  end;
end;

procedure TadxOlFormsManager.DoOutlookBarHide(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneHideEventArgs;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoOutlookBarHide');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  try
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsOutlookBarLayout then begin
        Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;

    if Assigned(OnADXNavigationPaneHide) then begin
      args := TadxOlNavigationPaneHideEventArgs.Create(true);
      try
        event := TadxEventRaising.Create('OnADXNavigationPaneHide', [eoLockRegionState]);
        try
          OnADXNavigationPaneHide(Self, args);
        finally
          event.Free;
        end;
      finally
        args.Free;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOutlookBarHide: ' + E.Message), 'DoOutlookBarHide');
  end;
end;

procedure TadxOlFormsManager.DoOutlookBarShow(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneShowEventArgs;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoOutlookBarShow');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  if not TadxOlFormsManagerState(State).WasAddinInitialize then
    exit;

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  if Assigned(OnADXNavigationPaneShow) then begin
    args := TadxOlNavigationPaneShowEventArgs.Create(true);
    try
      event := TadxEventRaising.Create('OnADXNavigationPaneShow', [eoLockRegionState]);
      try
        OnADXNavigationPaneShow(Self, args);
      finally
        event.Free;
      end;
    finally
      args.Free;
    end;
  end;

  for Index := 0 to Items.Count - 1 do begin
    if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin
      if Items[Index].IsOutlookBarLayout then begin
        DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.DoTodoBarHide(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  Log.AddMessage('DoTodoBarHide');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  HideAllFormsInAllAddins(GetTodoBarPaneLayoutWindowHandle(ExplorerArgs));

  for index := 0 to Items.Count - 1 do begin
    if Items[index].IsTodoBarLayout then begin
      Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
      Items[index].HideExplorerForms(ExplorerArgs);
    end;
  end;

  if (FOutlookVersion < v2010) then begin
    RaiseTodoBarHideEvent;
  end;
  //else see TTodoBarOutlook2010WatchObject
end;

procedure TadxOlFormsManager.DoTodoBarShow(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  Log.AddMessage('DoTodoBarShow');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  try
    if not TadxOlFormsManagerState(State).WasAddinInitialize then
      exit;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    if (FOutlookVersion < v2010) then begin
      RaiseTodoBarShowEvent;
    end;
    //else see TodoBarOutlook2010WatchObject

  if not TadxOlFormsManagerState(State).isFolderSwitchExecuting then begin
    for Index := 0 to Items.Count - 1 do begin
      if Items[Index].CorrespondExplorerContext(ExplorerArgs) then begin
        if Items[Index].IsTodoBarLayout then begin
          DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
        end;
      end;
    end;
  end
  else begin
    Log.AddMessage('Prevent showing forms in DoTodoBarShow when isFolderSwitchExecuting');
  end;

  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoTodoBarShow ' + E.Message), 'DoTodoBarShow');
  end;
end;

procedure TadxOlFormsManager.DoShowExplorerForm(
  Item: TadxOlFormsCollectionItem; AExplorerArgs: TObject; WindowHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  Form: TADXOlForm;
  AppWindowProperty: PAppWindowProperty;
  FindWindow: boolean;
  MessageResult: integer;
  args: TBeforeFormInstanceCreateEventArgs;
  Cancel: boolean;
  event: TadxEventRaising;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoShowExplorerForm');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  if (not IsContextSupport(Item.ExplorerLayout, ExplorerArgs)) then begin
      Log.AddMessage('Context is not supported.');
      exit;
  end;

  if (Item.IsDockLayout) then begin
    if (not DockLayoutIsSupported) then begin
      exit;
    end;

    if (FctpFactory = nil) then begin
      exit;
    end;
  end;

  GetMem(AppWindowProperty, sizeof(TAppWindowProperty));

  try
    NewAppWindowProperty(AppWindowProperty);

    Item.SetExplorerAppWindowProperty(ExplorerArgs, AppWindowProperty, WindowHandle);
    AppWindowProperty.ReceiverHandle := ReceiverWindowHandle;

    //Case 1488/1489
    if ((Item.IsReadingPaneLayout)
       and (FOutlookVersion = v2010)
       and (not IsWindowVisible(AppWindowProperty.WindowHandle))) then begin
      AppWindowProperty.WindowHandle := 0;
    end;

    if (appWindowProperty.WindowHandle > 0) or (Item.IsDockLayout) then begin
      if appWindowProperty.WindowHandle > 0 then begin
        MessageResult := SendMessage(appWindowProperty.WindowHandle, WM_ADXGETTYPESUBCLASS, 0, 0);
        if (MessageResult = adxMessage_IsNET_Subclass) then begin
          //ProcessADXXError('ADX Extensions for Outlook: The cuurent version does not support work with .NET add-ins.');
          //exit;
        end;
      end;

      FindWindow := (AppWindowProperty.WindowHandle > 0);
      if FindWindow or Item.IsDockLayout then begin

{$IFDEF CLIENTLAYOUTS}
        if Item.IsReadingPaneClientLayout then begin
          DoShowReadingPaneServiceForm(Item, AExplorerArgs, AppWindowProperty.WindowHandle);
        end;

        if Item.IsFolderViewClientLayout then begin
          DoShowFolderViewServiceForm(Item, AExplorerArgs, AppWindowProperty.WindowHandle);
        end;
{$ENDIF}

        Form := Item.FindExplorerForm(ExplorerArgs);

        if Form = nil then begin

            Cancel := false;
            if Assigned(OnADXBeforeFormInstanceCreate) then begin
              event := TadxEventRaising.Create('OnADXBeforeFormInstanceCreate', [eoLockRegionState]);
              try
                OnADXBeforeFormInstanceCreate(self, Item, Cancel);
              finally
                event.Free;
              end;
            end;

            if Assigned(OnADXBeforeFormInstanceCreateEx) then begin
              args := TBeforeFormInstanceCreateEventArgs.Create(Item, ExplorerArgs.ExplorerObj, ExplorerArgs);
              try
                event := TadxEventRaising.Create('OnADXBeforeFormInstanceCreateEx', [eoLockRegionState]);
                try
                  OnADXBeforeFormInstanceCreateEx(self, args);
                finally
                  event.Free;
                end;
                if (args.Cancel) then begin
                  Cancel := args.Cancel;
                end;
              finally
                args.Free;
              end;
            end;

            Form := Item.GetForm(Cancel);
        end;

        if (Form <> nil) and (not Form.Visible) and (not Form.IsHidenByDeveloper) and (not Form.Injected) then begin
          Form.InitializeForm(AExplorerArgs, AppWindowProperty);
          Form.AdxOlShow(AppWindowProperty, true);
        end;
      end else
      begin
        TDebug.WriteLine('DoShowExplorerForm: ' + ' Window not found. '
          + Format('Handle: %x', [ExplorerArgs.ExplorerWindowHandle])
          + ' ItemType = ' + IntToStr(AppWindowProperty.ItemType));
      end;
    end;
  finally
    FreeMem(AppWindowProperty);
  end;
end;

procedure TadxOlFormsManager.DoShowFolderViewServiceForm(
  Item: TadxOlFormsCollectionItem; AExplorerArgs: TObject;
  WindowHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  serviceFormCaption: TadxCaption;
  ServiceformAppWindowProperty: PAppWindowProperty;
  serviceForm: TadxForm;
begin
  Log.AddMessage('DoShowFolderViewServiceForm');
  if (Item.IsFolderViewClientLayout) then begin
    if (not ExistsServiceForm(WindowHandle)) then begin
      ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
      GetMem(ServiceformAppWindowProperty, sizeof(TAppWindowProperty));
      try
        NewAppWindowProperty(ServiceformAppWindowProperty);
        Item.SetExplorerAppWindowProperty(ExplorerArgs, ServiceformAppWindowProperty, 0);
        serviceformAppWindowProperty^.Splitter := Ord(sbNone);
        StrPCopy(serviceFormCaption, GetExplorerServiceFormCaption(Item.ExplorerLayout));
        serviceformAppWindowProperty^.Caption := serviceFormCaption;
        serviceformAppWindowProperty^.CloseButton := false;
        serviceformAppWindowProperty^.SplitterButton := false;
        serviceformAppWindowProperty^.RegionBorder := rbsSingle;
        serviceformAppWindowProperty^.AlwaysShowHeader := false;
        serviceForm := ExplorerArgs.GetServiceForm(Item.ExplorerLayout);
        serviceformAppWindowProperty^.ReceiverHandle := ReceiverWindowHandle;
        
        if (serviceForm <> nil) then begin
          TadxFormProtected(serviceForm).InitProperties(serviceformAppWindowProperty);
          TadxFormProtected(serviceForm).ShowInternal;
        end
        else begin
          Log.AddWarning('serviceForm == null');
        end;
      finally
        FreeMem(ServiceformAppWindowProperty);
      end;
    end;
  end;
end;

function TadxOlFormsManager.GetExplorerAdxItemType(
  ExplorerLayout: TadxolExplorerLayout; AExplorerArgs: TObject): TAdxItemType;
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  result := stOlUnknown;
  case ExplorerLayout of
{$IFDEF DOCKEXPLORERLAYOUTS}
    elDockTop,
    elDockBottom,
    elDockRight,
    elDockLeft:
    begin
      result := stOfficeTaskPane;
    end;
{$ENDIF}

{$IFDEF CLIENTLAYOUTS}
    elFolderView,
{$ENDIF}
    elTopSubpane,
    elBottomSubpane,
    elRightSubpane,
    elLeftSubpane:
    begin
      case ExplorerArgs.ExplorerItemType of
        expMailItem: result := stOlMail;
        expAppointmentItem: result := stOlAppointment;
        expContactItem: result := stOlContact;
        expTaskItem: result := stOlTask;
        expJournalItem: result := stOlJournal;
        expNoteItem: result := stOlNote;
        expPostItem: result := stOlMail; //SysUtils.Exception.Create('GetExplorerAdxItemType: Stub for expPostItem.');
        expDistributionListItem: result := stOlMail; //SysUtils.Exception.Create('GetExplorerAdxItemType: Stub for expDistributionListItem.');
        else begin
          TDebug.WriteLine('GetExplorerAdxItemType: The accordance not found. See ExplorerItemTypes - ' + IntToStr(ord(ExplorerArgs.ExplorerItemType)));
          //raise SysUtils.EAbort.Create('GetExplorerAdxItemType: The accordance not found. See ExplorerItemTypes');
        end;
      end;

    end;
    elWebViewPane:
    begin
      result := stOlWebViewPane;
    end;

    elBottomOutlookBar: begin
      if (OutlookVersion = v2000) or (OutlookVersion = v2002) then
        result := stOlOutlookBar;
    end;
    elBottomNavigationPane: begin
      if (OutlookVersion = v2000) or (OutlookVersion = v2002) then
        result := stOlFolderList;
      if (OutlookVersion = v2003)
        or (OutlookVersion = v2007)
        or (OutlookVersion = v2010) then
        result := stOlNavigationPane;
    end;

    elBottomTodoBar: result := stOlTodoBar;

{$IFDEF CLIENTLAYOUTS}
    elReadingPane,
{$ENDIF}
    elTopReadingPane,
    elBottomReadingPane,
    elRightReadingPane,
    elLeftReadingPane:
    begin
      result := stOlReadingPane;
    end;
    {$IFDEF READINGPANEHEADER}
      elReadingPaneHeader: result:= stOlReadingPaneHeader;
    {$ENDIF}

    else begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetExplorerAdxItemType: The accordance not found. See ExplorerLayout'), 'GetExplorerAdxItemType');
    end;
  end;
end;

function TadxOlFormsManager.GetExplorerServiceFormCaption(
  ExplorerLayout: TadxolExplorerLayout): string;
begin
  case (ExplorerLayout) of
    elFolderView: result := 'Folder View';
    elReadingPane: result := 'Reading Pane';
    else result := 'unknown service caption';
  end;
end;

procedure TadxOlFormsManager.OnCommonInspectorWindowHide(HostHandle: HWND; ItemType: TADXItemType; CallingFromInspectorClose: boolean);
var
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
  HostVisible: boolean;
begin
  Log.AddMessage('Event OnCommonInspectorWindowHide  ItemType = ' + IntToStr(ItemType) + ', HostHandle = ' + IntToHex(HostHandle, 8));

  if (not CallingFromInspectorClose) then begin
    if (TadxOlFormsManagerState(State).ClosedInspector = HostHandle) then begin
      Log.AddMessage('TadxOlFormsManagerState(State).ClosedInspector = ' + IntToHex(HostHandle, 8));
      exit;
    end;
  end;

  try
    Log.AddIndent;
    InspectorArgs := nil;
    try

      GetRegisterOutlookInspector(HostHandle, InspectorObj);
      if InspectorObj <> nil then begin
        InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, HostHandle, ccInspectorClose);

        HostVisible := IsWindowVisible(HostHandle);
        if HostVisible then begin
          //When Internal Inspector change items
          DoInspectorWindowHide(InspectorArgs);
        end
        else begin
          DoInspectorWindowHide(InspectorArgs);
        end;
      end;

      TDebug.WriteLine('End OnCommonInspectorWindowHide');
    finally
      if Assigned(InspectorArgs) then
        InspectorArgs.Free;

      InspectorObj := nil;
      Log.RemoveIndent;
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('OnCommonInspectorWindowHide: ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxOlFormsManager.OnCommonInspectorWindowShow(HostHandle: HWND; ItemType: TADXItemType);
var
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
  WatchObject: TControlHideWindowWatchObject;
begin
  Log.AddMessage('Event OnCommonInspectorWindowShow  ItemType = ' + IntToStr(ItemType) + ', HostHandle = ' + IntToHex(HostHandle, 8));
  Log.AddIndent;


  if (FWatchEngine <> nil) then begin

    //Add handle for control Hide
    WatchObject :=
        TControlHideWindowWatchObject.Create(
        HostHandle,
        HostHandle,
        ItemType,
        TadxReceiverWindow(FReceiverWindow).Handle);
    TWatchEngine(FWatchEngine).Add(watchObject);
  end;

  InspectorArgs := nil;
  try
    GetRegisterOutlookInspector(HostHandle, InspectorObj);

    TDebug.WriteLine('OnInspectorWindowShow InspectorAddress: ' + IntToStr(cardinal(InspectorObj)));
    if InspectorObj = nil then begin
      Log.AddWarning(Format('%s error: the add-in has fired an exception.'#13#10 +
       '%s', ['TadxOlFormsManager.OnCommonInspectorWindowShow',
       'Cannot get registered Inspector']));
    end;

    TDebug.WriteLine('Before DoInspectorWindowShow');
    InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, HostHandle, ccNewInspector);

    if (InspectorArgs.IsMailPost) then begin
      case (ItemType) of
        stOlMailInspector: InspectorArgs.MailPostInspectorType := mitStandard;
        stOlWordMailInspector: InspectorArgs.MailPostInspectorType := mitWordEditor;
      end;
    end;


    //if (OutlookVersion = v2000)
    //  or (OutlookVersion = v2002)
    //  or (OutlookVersion = v2003) then begin
      //See OnNewInspector
    //end;

      DoInspectorWindowShow(InspectorArgs, ord(ciNewInspector));

  finally
    if Assigned(InspectorArgs) then
      InspectorArgs.Free;

    InspectorObj := nil;
    TDebug.WriteLine('After DoInspectorWindowShow');
  end;
  Log.RemoveIndent;
end;


procedure TadxOlFormsManager.OnCommonReceiverWindowHide(HostHandle: HWND; ItemType: TADXItemType);
begin
  Log.AddMessage('Event OnCommonReceiverWindowHide');
  try
    Log.AddIndent;
    case ItemType of
      stOlOutlookBar,
      stOlFolderList,
      stOlNavigationPane,
      stOlTodoBar,
      stOlReadingPane: begin
        OnCommonExplorerWindowHide(HostHandle, ItemType);
      end;

      stOlDefaultInspector,
      stOlWordMailInspector,
      stOlMailInspector,
      stOlAppointmentInspector,
      stOlTaskInspector,
      stOlContactInspector,
      stOlDistributionListInspector,
      stOlJournalInspector,
      stOlReportInspector,
      stOlMeetingInspector,
      stOlSharingInspector,
      stOlMobileInspector: begin
        OnCommonInspectorWindowHide(HostHandle, ItemType, false);
      end;
      else begin
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('OnCommonReceiverWindowHide: ItemType not found'), 'OnCommonReceiverWindowHide');
      end;
    end;
    Log.RemoveIndent;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'OnCommonReceiverWindowHide')
    end;
  end;
end;

procedure TadxOlFormsManager.OnCommonReceiverWindowShow(HostHandle: HWND; ItemType: TADXItemType);
begin
  Log.AddMessage('Event OnCommonReceiverWindowShow ItemType = ' + IntToStr(ItemType) + ', HostHandle = ' + IntToHex(HostHandle, 8));
  if not IsWindowVisible(HostHandle) then begin
    Log.AddWarning('OnCommonReceiverWindowShow: ' + 'HostHandle is unvisible.');
    exit;
  end;

  try
    case ItemType of
      stOlOutlookBar,
      stOlFolderList,
      stOlNavigationPane,
      stOlTodoBar,
      stOlReadingPane: begin
        OnCommonExplorerWindowShow(HostHandle, ItemType);
      end;

      stOlDefaultInspector,
      stOlMailInspector,
      stOlWordMailInspector,
      stOlAppointmentInspector,
      stOlTaskInspector,
      stOlContactInspector,
      stOlDistributionListInspector,
      stOlJournalInspector,
      stOlReportInspector,
      stOlMeetingInspector,
      stOlSharingInspector,
      stOlMobileInspector: begin
        OnCommonInspectorWindowShow(HostHandle, ItemType);
      end;
      else
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('OnCommonReceiverWindowShow: ItemType not found: ' + IntToStr(ItemType)), 'OnCommonReceiverWindowShow');
    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'OnCommonReceiverWindowShow')
    end;
  end;
end;

procedure TadxOlFormsManager.GetRegisterOutlookInspector(
  InspectorWindowHandle: HWND; var InspectorObj: Inspector);
var
  i: integer;
  count: integer;
begin
  Log.AddMessage('GetRegisterOutlookInspector FRegisteredInspectorList.Count = ' + IntToStr(TadxOlRegisterInspectorList(FRegisteredInspectorList).Count));
  Log.AddIndent;
  InspectorObj := nil;
  count := 0;
  for i := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
    if (TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).InspectorWindowHandle = InspectorWindowHandle) then begin
      if (count > 0) then begin
        Log.AddWarning('Inspector was being found');
      end;
      InspectorObj := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).FInspectorObj;
      count := count + 1;
      //ValidateInspector(TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]));
      //exit;
    end;
  end;
  Log.RemoveIndent;
end;

function TadxOlFormsManager.GetSuperGridLayoutWindowHandle(
  AExplorerArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetSuperGridLayoutWindowHandle');
  result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsSuperGridLayout then begin
        form := Items[index].GetFirstVisibleExplorerForms(AExplorerArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetSuperGridLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetSuperGridLayoutWindowHandle ' + E.Message), 'DoOLExplorerBeforeViewSwitch');
  end;
end;

function TadxOlFormsManager.GetTextEditor(
  InspectorObj: Inspector): ITextDocument;
begin
  result := TextDocumentUtils.GetTextEditor(InspectorObj, OutlookVersion);
end;

function TadxOlFormsManager.GetWasAddinInitialize: boolean;
begin
  if (State = nil) then begin
    result := false;
    exit;
  end;
  result :=  TadxOlFormsManagerState(State).WasAddinInitialize;
end;

function TadxOlFormsManager.GetWebViewPaneLayoutWindowHandle(
  AExplorerArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetWebViewPaneLayoutWindowHandle');
  result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsSuperGridLayout then begin
        form := Items[index].GetFirstVisibleExplorerForms(AExplorerArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetWebViewPaneLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetWebViewPaneLayoutWindowHandle ' + E.Message), 'DoOLExplorerBeforeViewSwitch');
  end;
end;

procedure TadxOlFormsManager.DoInspectorWindowHide(
  AInspectorArgs: TObject);
var
  WatchEngineNeedSuspend: boolean;
  InspectorArgs: TadxOlInspectorArguments;
  AdxOlInspector: TadxOlInspector;
begin
  Log.AddMessage('DoInspectorWindowHide');
  Log.AddMessage('@@@ ************* DoInspectorWindowHide');
  try
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
    WatchEngineNeedSuspend := (not TWatchEngine(FWatchEngine).Suspended)
      and (not TWatchEngine(FWatchEngine).Terminated);

    if WatchEngineNeedSuspend then begin
      TWatchEngine(FWatchEngine).Suspend;
    end;

    TDebug.WriteLine('*** DoInspectorWindowHide BEGIN');
{$IFDEF CLIENTLAYOUTS}
    HideAllFormsInAllAddins(GetClientLayoutWindowHandle(AInspectorArgs));
{$ENDIF}
    if (InspectorArgs.IsWordMailInspector) then begin
      HideInspectorForms(AInspectorArgs);
    end
    else begin
      HideInspectorForms(AInspectorArgs);
      //Preview Issue DeleteInspectorForms(AInspectorArgs);
    end;
{$IFDEF CLIENTLAYOUTS}
    HideClientSubpaneServiceForm(AInspectorArgs);
{$ENDIF}

    AdxOlInspector := nil;
    GetRegisterAdxOlInspector(InspectorArgs.InspectorWindowHandle, Pointer(AdxOlInspector));
    if (AdxOlInspector <> nil) then begin
      AdxOlInspector.DeleteEmulateWindow;
    end;
    //UnregisterInspector(AInspectorArgs);

    if WatchEngineNeedSuspend then begin
      TDebug.WriteLine('FWatchEngine.Resume');
      TWatchEngine(FWatchEngine).Resume;
    end;
    TDebug.WriteLine('*** DoInspectorWindowHide END');
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoInspectorWindowHide: ' + E.Message), 'DoInspectorWindowHide');
  end;

end;

procedure TadxOlFormsManager.DoInspectorWindowShow(
  AInspectorArgs: TObject; CauseInspectorFormShowing: integer);
var
  index, FormIndex: integer;
  Cause: TadxOlCauseInspectorFormShowing;
  NeedToCallEvent: boolean;
  form: TadxOlForm;
  NewInspectorArgs: TadxOlFormNewInspectorEventArgs;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('DoInspectorWindowShow');
  Log.AddIndent;
  try
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
    Cause := TadxOlCauseInspectorFormShowing(CauseInspectorFormShowing);
    for index := 0 to Items.Count - 1 do begin
      if Items[Index].CorrespondInspectorContext(AInspectorArgs) then begin
        DoShowInspectorForm(Items[Index], AInspectorArgs, false, CauseInspectorFormShowing);
      end;
    end;

    if (Cause = ciNewInspector) then begin
      //TadxOlForm.DoAdxNewInspector
      for index := 0 to Items.Count - 1 do begin
        for FormIndex := 0 to Items[Index].FormInstanceCount - 1  do begin
          form := Items[Index].FormInstances[FormIndex];
          if (form <> nil) then begin
            NeedToCallEvent := ((form.FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle)
                          and form.Visible);
            if (NeedToCallEvent) then begin
              NewInspectorArgs := TadxOlFormNewInspectorEventArgs.Create;
              try
                form.DoAdxNewInspector(NewInspectorArgs);
              finally
                if NewInspectorArgs <> nil then begin
                  NewInspectorArgs.Free;
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    CheckAndRunRefreshInspectorTabWatchObject(InspectorArgs);
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoInspectorWindowShow: ' + E.Message), 'DoInspectorWindowShow');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.TryShowInInspector(Form: TadxOlForm; InspectorObj: Inspector;
  InspectorWindowHandle: HWND; CauseInspectorFormShowing: integer);
var
  InspectorArgs: TadxOlInspectorArguments;
  ContextForm: TadxOlForm;
begin
  InspectorArgs := nil;
  if not Form.Visible then begin
    if Form.IsInspectorForm then begin
      try
        InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, InspectorWindowHandle, ccNewInspector);
        ContextForm := Form.Item.FindInspectorForm(InspectorArgs);
        if (ContextForm = Form) then begin
          if Form.Item.CorrespondInspectorContext(InspectorArgs) then begin
            DoShowInspectorForm(Form.Item, InspectorArgs, false, CauseInspectorFormShowing);
          end;
        end;
      finally
        if Assigned(InspectorArgs) then begin
          InspectorArgs.Free;
        end;
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.TryShowInExplorer(Form: TadxOlForm;
  ExplorerObj: Explorer; ExplorerWindowHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  ContextForm: TadxOlForm;
begin
  ExplorerArgs := nil;
  if not Form.Visible then begin
    if Form.IsExplorerForm then begin
      try
        ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccNewExplorer);
        ContextForm := Form.Item.FindExplorerForm(ExplorerArgs);
        if (ContextForm = Form) then begin
          if Form.Item.CorrespondExplorerContext(ExplorerArgs) then begin
            DoShowExplorerForm(Form.Item, ExplorerArgs, 0);
          end;
        end;
      finally
        if Assigned(ExplorerArgs) then begin
          ExplorerArgs.Free;
        end;
      end;
    end;
  end;
end;


procedure TadxOlFormsManager.AddInspectorWindowForSearching(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
{$IFDEF OldWatchEngineModel}
  SearchWindow: PSearchWindow;
  ItemType: TAdxItemType;
{$ELSE}
  showChildWindowMessage: TShowChildWindowMessage;
  watchObject: TShowChildWindowWatchObject;
  watchObjectForAnyMailInspector: TShowChildWindowWatchObjectInAnyMailInspector;
{$ENDIF}

begin
  Log.AddMessage('ReceiverAddInspectorWindowForSearching');
  Log.AddIndent;
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  if (InspectorArgs.IsMailPost) then begin
    showChildWindowMessage := TShowChildWindowMessage.Create(self.ReceiverWindowHandle, InspectorArgs.InspectorWindowHandle, self.OnCommonReceiverWindowShow);
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(showChildWindowMessage);

    watchObjectForAnyMailInspector :=
        TShowChildWindowWatchObjectInAnyMailInspector.Create(
        FOutlookHandleFinder as TOutlookHandleFinder,
        self.ReceiverWindowHandle,
        InspectorArgs.InspectorWindowHandle,
        OutlookVersion);
    TWatchEngine(FWatchEngine).Add(watchObjectForAnyMailInspector);
  end
  else begin
    showChildWindowMessage := TShowChildWindowMessage.Create(self.ReceiverWindowHandle, InspectorArgs.InspectorWindowHandle, self.OnCommonReceiverWindowShow);
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(showChildWindowMessage);

    watchObject :=
        TShowChildWindowWatchObject.Create(
        FOutlookHandleFinder as TOutlookHandleFinder,
        self.ReceiverWindowHandle,
        InspectorArgs.InspectorWindowHandle,
        OutlookVersion,
        GetInspectorAdxItemType(InspectorArgs.InspectorItemType, ord(InspectorArgs.MailPostInspectorType)),
        InspectorArgs.IsWordMailInspector);
    TWatchEngine(FWatchEngine).Add(watchObject);
  end;
  Log.RemoveIndent;
end;


procedure TadxOlFormsManager.DoPreparationDisableAddinInCOMAddinsDialog;
begin
  Log.AddMessage('DoPreparationDisableAddinInCOMAddinsDialog');
  if (HasWebViewPane) then begin
    RestoreWebViewFolderSettings;
    RefreshCurrentFolderForAllExplorers;
  end;

  DoCloseAllFormsInDockLayoutsWhenDisableAddinInCOMAddinsDialog;
end;

procedure TadxOlFormsManager.FreeExistentExplorers;
begin
  Log.AddMessage('FreeExistingExplorers');
  try
    while TadxOlRegisterExplorerList(FRegisteredExplorerList).Count > 0 do begin
      UnregisterExplorer(TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[0]).ExplorerWindowHandle);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('FreeExistentExplorers: ' + E.Message), 'FreeExistentExplorers');
  end;
end;

procedure TadxOlFormsManager.AddExplorerWindowsForSearching(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  WasCallingForThisHandle: boolean;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  //WasCallingForThisHandle is VCL realisation only
  WasCallingForThisHandle := (ExplorerArgs.ExplorerWindowHandle = FPriorExplorerWindowHandleForSearching);
  if (WasCallingForThisHandle) then begin
    exit;
  end;
  FPriorExplorerWindowHandleForSearching := ExplorerArgs.ExplorerWindowHandle;

  ReceiverAddHideReadingPaneWindowMessage();

  case OutlookVersion of
    v2000: begin
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlOutlookBar);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlFolderList);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlReadingPane);
    end;
    v2002: begin
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlOutlookBar);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlFolderList);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlReadingPane);
    end;
    v2003: begin
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlNavigationPane);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlReadingPane);
    end;
    v2007,
    v2010: begin
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlNavigationPane);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlTodoBar);
      AddExplorerWindowForSearching(ExplorerArgs.ExplorerWindowHandle, stOlReadingPane);
      AddBackStageWatchObject(ExplorerArgs.ExplorerWindowHandle);
    end;
  end;
end;

procedure TadxOlFormsManager.DeleteExplorerForms(ExplorerWindowHandle: HWND);
var
  index: integer;
begin
  Log.AddMessage('DeleteExplorerForms');
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteExplorerForms(ExplorerWindowHandle);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DeleteExplorerForms: ' + E.Message), 'DeleteExplorerForms');
  end;
end;

procedure TadxOlFormsManager.GetRegisterAdxOlExplorer(
  ExplorerWindowHandle: HWND; var AdxOlExplorer: Pointer);
var
  i: integer;
begin
  Log.AddMessage('GetRegisterAdxOlExplorer');
  AdxOlExplorer := nil;
  for i := 0 to TadxOlRegisterExplorerList(FRegisteredExplorerList).Count - 1 do begin
    if TadxOlRegisterExplorerList(FRegisteredExplorerList)[i] <> nil then begin
      if (TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).ExplorerWindowHandle = ExplorerWindowHandle) then begin
        AdxOlExplorer := TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]);
        exit;
      end;
    end
    else begin
     Log.AddWarning('TadxOlRegisterExplorerList(FRegisteredExplorerList)[i] = nil');
    end;
  end;
end;

procedure TadxOlFormsManager.GetRegisterAdxOlInspector(
  InspectorWindowHandle: HWND; var AdxOlInspector: Pointer);
var
  i: integer;
begin
  Log.AddMessage('GetRegisterAdxOlInspector');
  AdxOlInspector := nil;
  for i := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
    if TadxOlRegisterInspectorList(FRegisteredInspectorList)[i] <> nil then begin
      if (TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).InspectorWindowHandle = InspectorWindowHandle) then begin
        AdxOlInspector := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]);
        exit;
      end;
    end
    else begin
     Log.AddWarning('TadxOlRegisterInspectorList(FRegisteredInspectorList)[i] = nil');
    end;
  end;
end;

procedure TadxOlFormsManager.DeleteAllForms;
var
  index: integer;
begin
  Log.AddMessage('DeleteAllForms');
  HideAllForms; 
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].DeleteAllForms;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DeleteAllForms: ' + E.Message), 'DeleteAllForms');
  end;
end;

procedure TadxOlFormsManager.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('HideAllForms');
  try
    for index := 0 to Items.Count - 1 do begin
      Items[index].HideAllNotInjectedForms;
    end;
    for index := 0 to Items.Count - 1 do begin
      Items[index].HideAllForms;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('HideAllForms: ' + E.Message), 'HideAllForms');
  end;
end;

procedure TadxOlFormsManager.HideAllFormsInAllAddins(WindowHandle: HWND);
var
  resMessage: integer;
begin
  Log.AddMessage('@@@ VCL HideAllFormsInAllAddins');
  if (WindowHandle <> 0) then begin
    SendMessage(WindowHandle, WM_ADXHIDEALLREGIONFORMS, 0, 0);
    resMessage := SendMessage(WindowHandle, WM_ADXEXIST, 0, 0);
    if (resMessage = Globals.adxMessageResultValue) then begin
      Log.AddWarning('HideAllFormsInAllAddins: CheckADXMessageResult Error');
    end;
  end;
  Log.AddMessage('@@@ VCL HideAllFormsInAllAddins');
end;

procedure TadxOlFormsManager.TryProcessTheADXOlFormShowMethod(Form: TadxOlForm);
var
  ExplorerObj: Explorer;
  InspectorObj: Inspector;
begin
  if Form.IsExplorerForm then begin
    GetRegisterExplorer(Form.FOutlookWindowHandle, ExplorerObj);
    if (ExplorerObj <> nil) then begin
      TryShowInExplorer(Form, ExplorerObj, Form.FOutlookWindowHandle);
    end;
    ExplorerObj := nil;
  end;
  if Form.IsInspectorForm then begin
    GetRegisterOutlookInspector(Form.FOutlookWindowHandle, InspectorObj);
    if (InspectorObj <> nil) then begin
      TryShowInInspector(Form, InspectorObj, Form.FOutlookWindowHandle, ord(ciFormShowMethod));
    end;
    InspectorObj := nil;
  end;
end;

procedure TadxOlFormsManager.OnCommonReceiverInspectorWindowHide(
  WindowHandle: HWND; ItemType: TADXItemType);
begin
  Log.AddMessage('Event OnCommonReceiverInspectorWindowHide ItemType = ' + IntToStr(ItemType) + ', WindowHandle = ' + IntToHex(WindowHandle, 8));
  case ItemType of
    stOlDefaultInspector,
    stOlWordMailInspector,
    stOlMailInspector,
    stOlAppointmentInspector,
    stOlTaskInspector,
    stOlContactInspector,
    stOlDistributionListInspector,
    stOlJournalInspector,
    stOlReportInspector,
    stOlMeetingInspector,
    stOlSharingInspector,
    stOlMobileInspector: begin
      OnCommonInspectorWindowHide(WindowHandle, ItemType, false);
    end;
    else
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('OnCommonReceiverInspectorWindowHide: ItemType not found'), 'OnCommonReceiverInspectorWindowHide');
  end;
end;

function TadxOlFormsManager.GetReadingPaneLayoutWindowHandle(
  AExplorerArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetReadingPaneLayoutWindowHandle');
  result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsReadingPaneLayout then begin
        form := Items[index].GetFirstVisibleExplorerForms(AExplorerArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetReadingPaneLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetReadingPaneLayoutWindowHandle ' + E.Message), 'DoOLExplorerBeforeViewSwitch');
  end;
end;

function TadxOlFormsManager.GetReceiverWindowHandle: HWND;
begin
  if (FReceiverWindow <> nil) then begin
    result := TadxReceiverWindow(FReceiverWindow).Handle;
  end else begin
    result := 0;
  end;
end;

procedure TadxOlFormsManager.OnAsyncWordEditorHide(HostHandle: HWND;
  ItemType: TADXItemType);
var
  index: integer;
  IsWordMailInspector: boolean;
  CurrentWordInspectorHandle: HWND;
  inspector: TadxOlInspector;
  InspectorArgs: TadxOlInspectorArguments;
  WatchObject: TControlHideWindowWatchObject;
begin
  Log.AddMessage('Event OnAsyncWordEditorHide');

  if TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning = true then begin
    Log.AddMessage('isAsyncWordEditorHideRunning');
    exit;
  end;

  Log.AddIndent;
  TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning := true;
  TadxOlFormsManagerState(State).ClosedInspector := HostHandle;
  try
    try
      for index := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
          inspector := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[index]);
          Log.AddMessage('Check inspector ' + IntToStr(index));

          IsWordMailInspector := (HostHandle = inspector.InspectorWindowHandle);
          //Also may bool IsWordMailInspector = OutlookUtils.IsWordMailInspector(inspectorEvents.inspectorObj)

          if (IsWordMailInspector) then begin
              Log.AddMessage('It is IsWordMailInspector');

              CurrentWordInspectorHandle := 0;
              try
                CurrentWordInspectorHandle := GetNewInspectorWindowHandle(inspector.InspectorObject, OutlookVersion, true);

                //try once with visibility param = false
                if (CurrentWordInspectorHandle = 0) then begin
                    CurrentWordInspectorHandle := GetNewInspectorWindowHandle(inspector.InspectorObject, OutlookVersion, false);
                end;
              except
                on E:SysUtils.Exception do begin
                  //When InspectorClose is raised before OnAsyncWordEditorHide
                  Log.AddWarning('GetNewInspectorWindowHandle: ' + E.Message);
                end;
              end;

              //Email body has been changed
              if ((CurrentWordInspectorHandle <> 0)
                  and (CurrentWordInspectorHandle <> HostHandle))
              then begin

                  ChangeInspectorWindowHandle(inspector, CurrentWordInspectorHandle);


                  InspectorArgs := TadxOlInspectorArguments.Create(
                    self,
                    inspector.InspectorObject,
                    inspector.InspectorWindowHandle,
                    ccChangingInspectorWindowHandle);
                    InspectorArgs.MailPostInspectorType := mitWordEditor;
                  try

                      DoInspectorWindowShow(InspectorArgs, ord(ciChangingWordInspectorHandle));

                      if (FWatchEngine <> nil) then begin


                          WatchObject :=
                              TControlHideWindowWatchObject.Create(
                              InspectorArgs.InspectorWindowHandle,
                              InspectorArgs.InspectorWindowHandle,
                              ItemType,
                              TadxReceiverWindow(FReceiverWindow).Handle);
                          TWatchEngine(FWatchEngine).Add(WatchObject);


                      end;
                  finally
                    InspectorArgs.Free;
                  end;

              end;
              //must be only one inspector
              break;
          end;
      end;
      TDebug.WriteLine('OnAsyncWordEditorHide end');
    finally
      TadxOlFormsManagerState(State).isAsyncWordEditorHideRunning := false;
      TadxOlFormsManagerState(State).ClosedInspector := 0;

      Log.RemoveIndent;
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('OnAsyncWordEditorHide: ' + E.Message);
      raise E; 
    end;
  end;
end;

procedure TadxOlFormsManager.ChangeInspectorWindowHandle(
  AInspector: TObject; CurrentWordInspectorHandle: HWND);
var
  OldInspectorWindowHandle: HWND;
  Inspector: TadxOlInspector;
  ItemIndex: integer;
begin
  Log.AddMessage('ChangeInspectorWindowHandle');
  Inspector := TadxOlInspector(AInspector);

  OldInspectorWindowHandle := Inspector.InspectorWindowHandle;
  Inspector.UpdateInspectorWindowHandle(CurrentWordInspectorHandle);

  for ItemIndex := 0 to Items.Count - 1 do begin
    Items[ItemIndex].ChangeInspectorWindowHandle(OldInspectorWindowHandle, CurrentWordInspectorHandle);
  end;
end;

procedure TadxOlFormsManager.DeleteExplorerWindowsForSearching(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
	if (TWatchEngine(FWatchEngine) <> nil) then begin
    TDebug.WriteLine('Access to TWatchEngine');
		TWatchEngine(FWatchEngine).DeleteByHostHandle(ExplorerArgs.ExplorerWindowHandle);
  end;
end;

procedure TadxOlFormsManager.DeleteInspectorWindowsForSearching(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
begin
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
	if (TWatchEngine(FWatchEngine) <> nil) then begin
    TDebug.WriteLine('Access to TWatchEngine');
		TWatchEngine(FWatchEngine).DeleteByHostHandle(InspectorArgs.InspectorWindowHandle);
  end;
end;


procedure TadxOlFormsManager.ReceiverAddHideReadingPaneWindowMessage;
var
  hideReadingPaneWindowFromSBCLSMessage: THideReadingPaneWindowFromSBCLSMessage;
begin
  if (not TadxReceiverWindow(FReceiverWindow).Exists(THideReadingPaneWindowFromSBCLSMessage)) then begin
    hideReadingPaneWindowFromSBCLSMessage := THideReadingPaneWindowFromSBCLSMessage.Create(self.ReceiverWindowHandle, self.OnCommonReceiverWindowHide);
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(hideReadingPaneWindowFromSBCLSMessage);
  end;
end;

procedure TadxOlFormsManager.DoReadingPaneShow(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlReadingPaneShowEventArgs;
  ReadingPaneHandle: HWND;
  MsoDockTopWindowHandle: HWND;
  AReadingPaneLayout: TadxOlReadingPaneLayout;
  //explorer: TadxOlExplorer;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoReadingPaneShow');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  if not TadxOlFormsManagerState(State).WasAddinInitialize then
    exit;

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  ReadingPaneHandle := (self.FOutlookHandleFinder as TOutlookHandleFinder).GetAppWindowHandle(OutlookVersion, stOlReadingPane, ExplorerArgs.ExplorerWindowHandle);
  if (OutlookVersion = v2010) then begin
    MsoDockTopWindowHandle := (self.FOutlookHandleFinder as TOutlookHandleFinder).GetMsoDockTopWindowHandle(OutlookVersion,  ExplorerArgs.ExplorerWindowHandle);
  end
  else begin
    MsoDockTopWindowHandle := 0;
  end;

  AReadingPaneLayout := TMoveReadingPaneWindowWatchObject.CurrentLayout(OutlookVersion,  ReadingPaneHandle, MsoDockTopWindowHandle);
  FReadingPaneLayout := AReadingPaneLayout;
  
  if Assigned(OnADXReadingPaneShow) then begin
    args := TadxOlReadingPaneShowEventArgs.Create(AReadingPaneLayout);
    try
      try
        event := TadxEventRaising.Create('OnADXReadingPaneShow', [eoLockRegionState]);
        try
          OnADXReadingPaneShow(Self, args);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoReadingPaneShow');
        end;
      end;
    finally
      args.Free;
    end;
  end;

  if (ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin()) then begin

    if not TadxOlFormsManagerState(State).isFolderSwitchExecuting then begin
      for Index := 0 to Items.Count - 1 do begin
        if ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin
           and Items[Index].CorrespondExplorerContext(ExplorerArgs)
           and Items[Index].IsReadingPaneLayout then begin
           DoShowExplorerForm(Items[Index], ExplorerArgs, 0);
        end;
      end;
    end
    else begin
      Log.AddMessage('Prevent showing forms in DoReadingPaneShow when isFolderSwitchExecuting');
    end;

  end;

  ReceiverAddMoveReadingPaneWindowMessage(ExplorerArgs);
end;

procedure TadxOlFormsManager.DoReadingPaneHide(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlReadingPaneHideEventArgs;
  //explorer: TadxolExplorer;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoReadingPaneHide');
  //TDebug.WriteLine('@@@ DoReadingPaneHide ' + IntToStr(Cardinal(self)) + ' start');
  FReadingPaneLayout := rplOff;
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
{$IFDEF CLIENTLAYOUTS}
  //It causes other add-ins forms hidding when reading pane refreshes
  //HideAllFormsInAllAddins(GetReadingPaneLayoutWindowHandle(AExplorerArgs));
{$ENDIF}
  for index := 0 to Items.Count - 1 do begin
    if Items[index].IsReadingPaneLayout then begin
      Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
      Items[index].HideExplorerForms(ExplorerArgs);
    end;
  end;
  //TODO Delete MoveReadingPaneWindowMessages from watchObject
{$IFDEF CLIENTLAYOUTS}
  HideReadingPaneServiceForm(AExplorerArgs);
{$ENDIF}

  if Assigned(OnADXReadingPaneHide) then begin
    args := TadxOlReadingPaneHideEventArgs.Create();
    try
      try
        event := TadxEventRaising.Create('OnADXReadingPaneHide', [eoLockRegionState]);
        try
          OnADXReadingPaneHide(Self, args);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoReadingPaneHide');
        end;
      end;
    finally
      args.Free;
    end;
  end;
  //TDebug.WriteLine('@@@ DoReadingPaneHide ' + IntToStr(Cardinal(self)) + ' end');
end;

procedure TadxOlFormsManager.ReceiverAddMoveReadingPaneWindowMessage(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  readingPaneWindowHandle: HWND;
  MsoDockTopWindowHandle: HWND;
  watchObject: TMoveReadingPaneWindowWatchObject;
begin
  if (OutlookVersion = v2000)
    or (OutlookVersion = v2002) then begin
    //Always bottom layout
    exit;
  end;

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  readingPaneWindowHandle := (FOutlookHandleFinder as TOutlookHandleFinder).GetAppWindowHandle(OutlookVersion, stOlReadingPane, ExplorerArgs.ExplorerWindowHandle);
  if (OutlookVersion = v2010) then begin
    MsoDockTopWindowHandle := (FOutlookHandleFinder as TOutlookHandleFinder).GetMsoDockTopWindowHandle(OutlookVersion, ExplorerArgs.ExplorerWindowHandle);
  end
  else begin
    MsoDockTopWindowHandle := 0;
  end;

  if (readingPaneWindowHandle <> 0) then begin
      if (not TadxReceiverWindow(FReceiverWindow).Exists(TMoveReadingPaneWindowMessage)) then begin
          TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(
            TMoveReadingPaneWindowMessage.Create(self.ReceiverWindowHandle, OnMoveReadingPaneWindow));
      end;
      watchObject := TMoveReadingPaneWindowWatchObject.Create(OutlookVersion,
          self.ReceiverWindowHandle,
          ExplorerArgs.ExplorerWindowHandle,
          readingPaneWindowHandle,
          MsoDockTopWindowHandle);

      if (FWatchEngine <> nil) then begin
        TWatchEngine(FWatchEngine).Add(watchObject);
      end;

      //An Outlook window is not fully updated if OutlookHook is used for the ReadingPane move event.
  end;
end;

procedure TadxOlFormsManager.OnMoveReadingPaneWindow(HostHandle: HWND;
  ItemType: TADXItemType; ReadingPaneLayout: TadxOlReadingPaneLayout);
var
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('Event OnMoveReadingPaneWindow');
  if TadxOlFormsManagerState(State).isExplorerCloseRunning then begin
    exit;
  end;
  ExplorerArgs := nil;

  try

  GetRegisterExplorer(HostHandle, ExplorerObj);

  if ExplorerObj <> nil then begin
    ExplorerArgs := nil;
    ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccNewExplorer);

    DoReadingPaneMove(ExplorerArgs, ReadingPaneLayout);
  end;
  finally
    if Assigned(ExplorerArgs) then
      ExplorerArgs.Free;

    ExplorerObj := nil
  end;
end;

procedure TadxOlFormsManager.DoReadingPaneMove(AExplorerArgs: TObject; AReadingPaneLayout: TadxOlReadingPaneLayout);
var
  args: TadxOlReadingPaneMoveEventArgs;
  ExplorerArgs: TADXOlExplorerArguments;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoReadingPaneMove');
  ExplorerArgs :=  TADXOlExplorerArguments(AExplorerArgs);
  FReadingPaneLayout := ExplorerArgs.ReadingPaneLayout;
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  if not TadxOlFormsManagerState(State).WasAddinInitialize then
    exit;

  if Assigned(OnADXReadingPaneMove) then begin
    args := TadxOlReadingPaneMoveEventArgs
      .Create(AReadingPaneLayout);
    try
      try
        event := TadxEventRaising.Create('OnADXReadingPaneMove', [eoLockRegionState]);
        try
          OnADXReadingPaneMove(Self, args);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoReadingPaneMove');
        end;
      end;
    finally
      args.Free;
    end;
  end;
end;


procedure TadxOlFormsManager.ReleaseDefaultFolders;
begin
  Log.AddMessage('ReleaseDefaultFolders');
	FInboxFolderObj := nil;
	FOutboxFolderObj := nil;
	FPublicFoldersObj := nil;
	FPublicFoldersAllPublicFoldersObj := nil;
end;

procedure TadxOlFormsManager.OnCommonReceiverWindowMinimize(
  HostHandle: HWND; ItemType: TADXItemType);
begin
  Log.AddMessage('Event OnCommonReceiverWindowMinimize');
  try
    case ItemType of
      stOlNavigationPane,
      stOlTodoBar: begin
        OnCommonExplorerWindowMinimize(HostHandle, ItemType);
      end;
      else begin
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('OnCommonReceiverWindowMinmize: ItemType not found'), 'OnCommonReceiverWindowMinimize');
      end;
    end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'OnCommonReceiverWindowMinimize')
    end;
  end;
end;

procedure TadxOlFormsManager.OnCommonExplorerWindowMinimize(
  HostHandle: HWND; ItemType: TADXItemType);
var
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('Event OnCommonExplorerWindowMinimize');
  TDebug.WriteLine('OnCommonExplorerWindowHide');
  if TadxOlFormsManagerState(State).isExplorerCloseRunning then begin
    exit;
  end;
  ExplorerArgs := nil;

  try

  GetRegisterExplorer(HostHandle, ExplorerObj);

  if ExplorerObj <> nil then begin
    ExplorerArgs := nil;
    ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccExplorerClose);

    case ItemType of
      stOlNavigationPane: begin
        DoNavigationPaneMinimize(ExplorerArgs);
      end;
      stOlTodoBar: begin
        DoTodoBarMinimize(ExplorerArgs);
      end;
    end;
  end;
  finally
    if Assigned(ExplorerArgs) then
      ExplorerArgs.Free;

    ExplorerObj := nil
  end;
end;

procedure TadxOlFormsManager.DoNavigationPaneMinimize(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  args: TadxOlNavigationPaneMinimizeEventArgs;
  event: TadxEventRaising;
begin
  Log.AddMessage('DoNavigationPaneMinimize');
  try
    {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}


    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    HideAllFormsInAllAddins(GetNavigationPaneLayoutWindowHandle(ExplorerArgs));

    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsNavigationPaneLayout then begin
        Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;

    if Assigned(OnADXNavigationPaneMinimize) then begin
      args := TadxOlNavigationPaneMinimizeEventArgs.Create();
      try
        try
          event := TadxEventRaising.Create('OnADXNavigationPaneMinimize', [eoLockRegionState]);
          try
            OnADXNavigationPaneMinimize(Self, args);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'DoNavigationPaneMinimize');
          end;
        end;
      finally
        args.Free;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoNavigationPaneMinimize: ' + E.Message), 'DoNavigationPaneMinimize');
  end;
end;

procedure TadxOlFormsManager.DoTodoBarMinimize(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  Log.AddMessage('DoTodoBarMinimize');
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  try
    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    HideAllFormsInAllAddins(GetTodoBarPaneLayoutWindowHandle(ExplorerArgs));

    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsTodoBarLayout then begin
        Items[index].DeleteNotCachedExplorerForms(ExplorerArgs);
        Items[index].HideExplorerForms(ExplorerArgs);
      end;
    end;

    if (FOutlookVersion < v2010) then begin
      RaiseTodoBarMinimizeEvent;
    end;
    //else see TTodoBarOutlook2010WatchObject
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoTodoBarMinimize: ' + E.Message), 'DoTodoBarMinimize');
  end;
end;

function TadxOlFormsManager.GetHTMLFullFileName: string;
begin
  if FHTMLFullFileName = EmptyStr then begin
    FHTMLFullFileName := GlobalsOl.HTMLFullFileName(self.COMAddInModule);
  end;
  result := FHTMLFullFileName;
end;

{$IFDEF LOHICA}
function TadxOlFormsManager.RegisterInspectorsCount: integer;
begin
  TadxOlRegisterInspectorList(FRegisteredInspectorList).Count;
end;
{$ENDIF}

procedure TadxOlFormsManager.AddCloseServiceFormsMessagesToReceiver;
begin
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TCloseServiceFormForNotWordInspectorMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TCloseServiceFormForNotWordInspectorMessage.Create(self.ReceiverWindowHandle, self));

  if (not TadxReceiverWindow(FReceiverWindow).Exists(TCloseReadingPaneServiceFormMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TCloseReadingPaneServiceFormMessage.Create(self.ReceiverWindowHandle, self));

  if (not TadxReceiverWindow(FReceiverWindow).Exists(TCloseFolderViewServiceFormMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TCloseFolderViewServiceFormMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxOlFormsManager.AddDestroyEmbededWindowMessageToReceiver;
begin
  Log.AddMessage('AddDestroyEmbededWindowMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TDestroyEmbededWindowMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TDestroyEmbededWindowMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxOlFormsManager.DoDestroyEmbededWindow(HostHandle,
  EmbededWindowHandle: HWND);
var
  index: integer;
begin
  Log.AddMessage('DoDestroyEmbededWindow');
  try
    HideAllFormsInAllAddins(EmbededWindowHandle);
    //During set WebViewUrl
    for index := 0 to Items.Count - 1 do begin
      Items[index].HideFormsByEmbededWindowHandle(EmbededWindowHandle);
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoDestroyEmbededWindow: ' + E.Message), 'DoDestroyEmbededWindow');
  end;
end;

procedure TadxOlFormsManager.ApplyToExplorer(
  Item: TADXOlFormsCollectionItem; ExplorerObj: Explorer);
var
  ExplorerArgs: TadxOlExplorerArguments;
  Form: TadxOlForm;
begin
  ExplorerArgs := TadxOlExplorerArguments.Create(Self, ExplorerObj, ccFolderEvent);
  try
    //It is need for ApplyTo after Hide method
    Form := Item.FindExplorerForm(ExplorerArgs);
    if (Form <> nil) then begin
      Form.FIsHidenByDeveloper := false;
    end;

    self.DoApplyItemToExplorer(Item, ExplorerArgs);
  finally
    ExplorerArgs.Free;
  end;
end;

procedure TadxOlFormsManager.ApplyToInspector(
  Item: TADXOlFormsCollectionItem; InspectorObj: Inspector);
var
  InspectorWindowHandle: HWND;
  InspectorArguments: TADXOlInspectorArguments;
  Form: TadxOlForm;
begin
  InspectorWindowHandle := GetNewInspectorWindowHandle(InspectorObj, OutlookVersion, true);
  InspectorArguments := TadxOlInspectorArguments.Create(self, InspectorObj, InspectorWindowHandle, ccNewInspector);
  try
    //It is need for ApplyTo after Hide method
    Form := Item.FindInspectorForm(InspectorArguments);
    if (Form <> nil) then begin
      Form.FIsHidenByDeveloper := false;
    end;

    DoApplyItemToInspector(Item, InspectorArguments);
  finally
    InspectorArguments.Free;
  end;
end;

procedure TadxOlFormsManager.DoApplyItemToExplorer(
  Item: TADXOlFormsCollectionItem; AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  FolderWebViewOn: boolean;
begin
  {$IFDEF WITHOUT_OUTLOOK_EVENTS}Exit;{$ENDIF}
  Log.AddMessage('DoApplyItemToExplorer');
  try
    if (TadxOlFormsManagerState(State).isRefreshingFolder) then exit;

    ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

    try
      FolderWebViewOn := (TadxOlOutlookUtils(OutlookUtils).GetWebViewOn(ExplorerArgs.FolderObj));
    except
      TDebug.WriteLine('Exception try get FolderWebViewOn');
      //Outlook 2000 fires exception if WebViewOn
      FolderWebViewOn := true;
    end;

    if Item.CorrespondExplorerContext(ExplorerArgs) then begin
      if (Item.IsSuperGridLayout and not FolderWebViewOn)
        or Item.IsNavigationPaneLayout
        or Item.IsReadingPaneLayout
        or Item.IsOutlookBarLayout
        or Item.IsTodoBarLayout
        or Item.IsWebViewPaneLayout
        or Item.IsDockLayout
      then begin
        DoShowExplorerForm(Item, ExplorerArgs, 0);
      end;
    end;

  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLExplorerFolderSwitch: ' + E.Message), 'DoApplyItemToExplorer')
    end;
  end;
end;

procedure TadxOlFormsManager.DoApplyItemToInspector(
  Item: TADXOlFormsCollectionItem; AInspectorArgs: TObject);
begin
  Log.AddMessage('DoApplyItemToInspector');
  try
    if (Item.CorrespondInspectorContext(AInspectorArgs)) then begin
      DoShowInspectorForm(Item, AInspectorArgs, false, ord(ciItemApplyMethod));
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoApplyItemToInspector: ' + E.Message), 'DoApplyItemToInspector');
  end;
end;

procedure TadxOlFormsManager.OnCloseFolderViewServiceForm(ExplorerWindowHandle,
  WindowHandle: HWND);
var
  explorer: TadxOlExplorer;
  anyVisibleClientLayoutFormInExplorer: TadxOlForm;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('OnCloseFolderViewServiceForm');
  GetRegisterAdxOlExplorer(ExplorerWindowHandle, Pointer(explorer));
  if (explorer <> nil) then begin
      anyVisibleClientLayoutFormInExplorer := GetFirstVisibleFolderViewLayoutForm(WindowHandle);
      if (anyVisibleClientLayoutFormInExplorer <> nil) then begin
          if (not ExistsServiceForm(WindowHandle)) then begin
              if (IsWindowVisible(ExplorerWindowHandle)) then begin
                ExplorerArgs := TadxOlExplorerArguments.Create(self, explorer.FExplorerObj, ccFolderEvent);
                DoShowFolderViewServiceForm(anyVisibleClientLayoutFormInExplorer.Item, ExplorerArgs, WindowHandle);
              end else
              begin
                Log.AddMessage('Skip ServiceForm showing');
              end;
          end;
      end;
  end;
end;

procedure TadxOlFormsManager.OnCloseReadingPaneServiceForm(ExplorerWindowHandle,
  WindowHandle: HWND);
var
  explorer: TadxOlExplorer;
  anyVisibleClientLayoutFormInExplorer: TadxOlForm;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('OnCloseReadingPaneServiceForm');
  GetRegisterAdxOlExplorer(ExplorerWindowHandle, Pointer(explorer));
  if (explorer <> nil) then begin
      anyVisibleClientLayoutFormInExplorer := GetFirstVisibleReadingPaneLayoutForm(WindowHandle);
      if (anyVisibleClientLayoutFormInExplorer <> nil) then begin
          if (not ExistsServiceForm(WindowHandle)) then begin
              if (IsWindowVisible(ExplorerWindowHandle)) then begin
                ExplorerArgs := TadxOlExplorerArguments.Create(self, explorer.FExplorerObj, ccFolderEvent);
                DoShowFolderViewServiceForm(anyVisibleClientLayoutFormInExplorer.Item, ExplorerArgs, WindowHandle);
              end else
              begin
                Log.AddMessage('Skip ServiceForm showing');
              end;
          end;
      end;
  end;
end;

procedure TadxOlFormsManager.OnCloseServiceFormForNotWordInspector(
  InspectorWindowHandle, WindowHandle: HWND);
var
  inspector: TadxOlInspector;
  anyVisibleClientLayoutFormInInspector: TadxOlForm;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('OnCloseServiceFormForNotWordInspector');
  GetRegisterAdxOlInspector(InspectorWindowHandle, Pointer(inspector));
  if ((inspector <> nil) and (not inspector.IsWordMailInspector)) then begin
      anyVisibleClientLayoutFormInInspector := GetFirstVisibleInspectorRegionLayoutForm(WindowHandle);
      if (anyVisibleClientLayoutFormInInspector <> nil) then begin
          if (not ExistsServiceForm(WindowHandle)) then begin
              if (IsWindowVisible(InspectorWindowHandle)) then begin
                InspectorArgs := TadxOlInspectorArguments.Create(self, inspector.FInspectorObj, InspectorWindowHandle, ccInspectorActivate);
                DoShowInspectorServiceForm(anyVisibleClientLayoutFormInInspector.Item, InspectorArgs, 0, WindowHandle);
              end else
              begin
                Log.AddMessage('Skip ServiceForm showing');
              end;
          end;
      end;
  end;
end;

procedure TadxOlFormsManager.AddinsToLog;
var
  objAddins, objAddin: IDispatch;
  i, n: integer;
  connect: boolean;
  progID, description, connectMarker: string;
begin
  objAddins := OutlookAppObj.COMAddIns;
  n := OleVariant(objAddins).Count;
  try
    for i := 1 to n do begin
      objAddin := OleVariant(objAddins).Item(i);
      connect := OleVariant(objAddin).Connect;
      progID := OleVariant(objAddin).ProgID;
      description := OleVariant(objAddin).Description;
      if (connect) then begin
        connectMarker := '* ';
      end
      else begin
        connectMarker := '  ';
      end;
      Log.AddSystemInfo(connectMarker + 'Addin ' + IntToStr(i) + ':' + IntToStr(n) + ' ' + progID + ', ' + description);

    end;
  finally
    objAddins := nil;
    objAddin := nil;
  end;

end;

function TadxOlFormsManager.HasWebViewWindow(AExplorerArgs: TObject): boolean;
var
  WindowHandle: HWND;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  WindowHandle := GetInternetExplorerServerWindow(self.OutlookVersion, ExplorerArgs.ExplorerWindowHandle);
  result := WindowHandle <> 0;
end;

function TadxOlFormsManager.GetOutboxFolderEntryID: string;
begin
  if (FOutboxFolderEntryID = EmptyStr) then begin
    if (OutboxFolderObj <> nil) then begin
      FOutboxFolderEntryID := TadxOlOutlookUtils(FOutlookUtils).GetEntryID(OutboxFolderObj);
    end;
  end;
  result :=  FOutboxFolderEntryID;
end;

function TadxOlFormsManager.GetPublicFoldersEntryID: string;
begin
  if (FPublicFoldersEntryID = EmptyStr) then begin
    if (PublicFoldersObj <> nil) then begin
      FPublicFoldersEntryID := TadxOlOutlookUtils(FOutlookUtils).GetEntryID(PublicFoldersObj);
    end;
  end;
  result :=  FPublicFoldersEntryID;
end;

function TadxOlFormsManager.GetFirstVisibleFolderViewLayoutForm(
  WindowHandle: HWND): TadxOlForm;
var
  index, formIndex: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  result := nil;
  for index := 0 to Items.Count - 1 do begin
    if (Items[index].IsFolderViewClientLayout) then begin
      for formIndex := 0 to Items[index].FormInstanceCount - 1 do begin
        form := Items[index].FormInstances[formIndex];
        awp := form.GetAppWindowProperty;
        if ((form.Visible) and (awp.WindowHandle = WindowHandle)) then begin
          result := form;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsManager.GetFirstVisibleInspectorRegionLayoutForm(
  WindowHandle: HWND): TadxOlForm;
var
  index, formIndex: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  result := nil;
  for index := 0 to Items.Count - 1 do begin
    if (Items[index].IsInspectorRegionClientLayout) then begin
      for formIndex := 0 to Items[index].FormInstanceCount - 1 do begin
        form := Items[index].FormInstances[formIndex];
        awp := form.GetAppWindowProperty;
        if ((form.Visible) and (awp.WindowHandle = WindowHandle)) then begin
          result := form;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsManager.GetFirstVisibleReadingPaneLayoutForm(
  WindowHandle: HWND): TadxOlForm;
var
  index, formIndex: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  result := nil;
  for index := 0 to Items.Count - 1 do begin
    if (Items[index].IsReadingPaneClientLayout) then begin
      for formIndex := 0 to Items[index].FormInstanceCount - 1 do begin
        form := Items[index].FormInstances[formIndex];
        awp := form.GetAppWindowProperty;
        if ((form.Visible) and (awp.WindowHandle = WindowHandle)) then begin
          result := form;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsManager.GetFolderSyncIssuesEntryID: string;
begin
  if (FFolderSyncIssuesEntryID = EmptyStr) then begin
    if (FolderSyncIssuesObj <> nil) then begin
      FFolderSyncIssuesEntryID := TadxOlOutlookUtils(FOutlookUtils).GetEntryID(FolderSyncIssuesObj);
    end;
  end;
  result :=  FFolderSyncIssuesEntryID;
end;

function TadxOlFormsManager.GetPublicFoldersAllPublicFoldersEntryID: string;
begin
  if (FPublicFoldersAllPublicFoldersEntryID = EmptyStr) then begin
    if (PublicFoldersAllPublicFoldersObj <> nil) then begin
      FPublicFoldersAllPublicFoldersEntryID := TadxOlOutlookUtils(FOutlookUtils).GetEntryID(PublicFoldersAllPublicFoldersObj);
    end;
  end;
  result :=  FPublicFoldersAllPublicFoldersEntryID;
end;

procedure TadxOlFormsManager.LoadDefaultFoldersEntryIDFromRegistry;
var
  Reg: TRegistry;
  values: TStringList;
  EntryID: string;
  i: integer;
begin
  Log.AddMessage('LoadDefaultFoldersEntryIDFromRegistry');
  TDebug.WriteLine('LoadDefaultFoldersEntryIDFromRegistry');
  if not Assigned(COMAddinModule) then exit;
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey(COMAddInModule.RegistryKey + '\' + ADXXOL + '\' + GlobalsOl.FoldersForExcludingFromUseWebViewPaneLayout, true) then begin
      values := TStringList.Create;
      try
        Reg.GetValueNames(values);
        for i := 0 to values.Count - 1 do begin

          if (Globals.CompareADXStrings(values[i], GlobalsOl.PublicFolders)) then begin
            entryID := Reg.ReadString(values[i]);
            if (not IsTemporaryEntryID(EntryID)) then begin
              FPublicFoldersEntryID := EntryID;
              WasGettingPublicFoldersObj := true;
              Log.AddMessage('PublicFoldersEntryID from registry: ' + FPublicFoldersEntryID);
            end
            else begin
               Log.AddWarning('PublicFoldersEntryID from Registry is Temporary: ' + entryID);
            end;
          end;

          if (Globals.CompareADXStrings(values[i], GlobalsOl.PublicFoldersAllPublicFolders)) then begin
            entryID := Reg.ReadString(values[i]);
            if (not IsTemporaryEntryID(EntryID)) then begin
              FPublicFoldersAllPublicFoldersEntryID := EntryID;
              WasGettingPublicFoldersAllPublicFoldersObj := true;
              Log.AddMessage('PublicFoldersAllPublicFoldersEntryID from registry: ' + FPublicFoldersAllPublicFoldersEntryID);
            end
            else begin
               Log.AddWarning('PublicFoldersAllPublicFoldersEntryID from Registry is Temporary: ' + entryID);
            end;
          end;

          if (Globals.CompareADXStrings(values[i], GlobalsOl.FolderSyncIssues)) then begin
            entryID := Reg.ReadString(values[i]);
            if (not IsTemporaryEntryID(EntryID)) then begin
              FFolderSyncIssuesEntryID := EntryID;
              WasGettingFolderSyncIssuesObj := true;
              Log.AddMessage('FolderSyncIssuesEntryID from registry: ' + FFolderSyncIssuesEntryID);
            end
            else begin
               Log.AddWarning('FolderSyncIssuesEntryID from Registry is Temporary: ' + entryID);
            end;
          end;

        end;
      finally
        values.Free;
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxOlFormsManager.IsTemporaryEntryID(EntryID: string): boolean;
begin
  result := false;
end;

procedure TadxOlFormsManager.SaveDefaultFoldersEntryIDToRegistry;
var
  Reg: TRegistry;
begin
  Log.AddMessage('SaveDefaultFoldersEntryIDToRegistry');
  if not Assigned(COMAddinModule) then exit;
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey(COMAddInModule.RegistryKey + '\' + ADXXOL + '\' + GlobalsOl.FoldersForExcludingFromUseWebViewPaneLayout, true) then begin
      if (FPublicFoldersEntryID <> EmptyStr) then begin
        Reg.WriteString(GlobalsOl.PublicFolders, FPublicFoldersEntryID);
      end;
      if (FPublicFoldersAllPublicFoldersEntryID <> EmptyStr) then begin
        Reg.WriteString(GlobalsOl.PublicFoldersAllPublicFolders, FPublicFoldersAllPublicFoldersEntryID);
      end;
      if (FFolderSyncIssuesEntryID <> EmptyStr) then begin
        Reg.WriteString(GlobalsOl.FolderSyncIssues, FFolderSyncIssuesEntryID);
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxOlFormsManager.DoOLInspectorActivate(
  AInspectorArgs: TObject);
var
  index, FormIndex: integer;
  SkipFormCreating: boolean;
  InspectorArgs: TadxOlInspectorArguments;
  EnvelopeCommandBarHandle: HWND;
  SkipPreviewMode: boolean;
  form: TadxOlForm;
  NeedToCallEvent: boolean;
  InspectorActivateArgs: TadxOlFormInspectorActivateEventArgs;
begin
  if TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction then begin
    Log.AddMessage('Skip DoInspectorActivate');
    exit;
  end;

  Log.AddMessage('DoOLInspectorActivate');
  Log.AddIndent;
  try

    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    if ((OutlookVersion = v2002)
        or (OutlookVersion = v2003)) then begin

        if (InspectorArgs.MailPostInspectorType = mitWordEditor) then begin
          EnvelopeCommandBarHandle := GetAppWindowHandle(OutlookVersion, stOlEnvelopeCommandBarForWordInspectorPreviwControl, InspectorArgs.InspectorWindowHandle);
          SkipPreviewMode := (
            (EnvelopeCommandBarHandle = 0)
            or (
                 (EnvelopeCommandBarHandle <> 0)
                 and (not IsWindowVisible(EnvelopeCommandBarHandle))
               )
            );
          if SkipPreviewMode then begin
              Log.AddMessage('Skip preview mode');
              exit;
          end
        end;

    end;

    //ADXOlForm did not show up after Preview
    SkipFormCreating := true;
    try
      for index := 0 to Items.Count - 1 do begin
        if Items[Index].CorrespondInspectorContext(AInspectorArgs) then begin
          DoShowInspectorForm(Items[Index], AInspectorArgs, SkipFormCreating, ord(ciInspectorActivate));
        end;
      end;
    except
      on E:SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoOLInspectorActivate: ' + E.Message), 'DoOLInspectorActivate');
    end;

    //TadxOlForm.DoAdxInspectorActivate
    for index := 0 to Items.Count - 1 do begin
      for FormIndex := 0 to Items[Index].FormInstanceCount - 1  do begin
        form := Items[Index].FormInstances[FormIndex];
        if (form <> nil) then begin
          NeedToCallEvent := ((form.FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle)
                        and form.Visible);
          if (NeedToCallEvent) then begin
            InspectorActivateArgs := TadxOlFormInspectorActivateEventArgs.Create;
            try
              form.DoAdxInspectorActivate(InspectorActivateArgs);
            finally
              if InspectorActivateArgs <> nil then begin
                InspectorActivateArgs.Free;
              end;
            end;
          end;
        end;
      end;
    end;

  finally
    Log.RemoveIndent;
  end;
end;

function TadxOlFormsManager.AddWindowForWordInspectorPreviewSearching(
  HostHandle: HWND): TObject;
var
  WatchObject: TWatchObject;
begin
  Log.AddMessage('AddWindowForWordInspectorPreviewSearching');
  if (FWatchEngine = nil) then begin
    Log.AddWarning('FWatchEngine = nil');
    result := nil;
    exit;
  end;

  if (FReceiverWindow = nil) then begin
    Log.AddWarning('FReceiverWindow = nil');
    result := nil;
    exit;
  end;

  if (not TadxReceiverWindow(FReceiverWindow).Exists(TWordInspectorPreviewOnMessage)) then begin
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TWordInspectorPreviewOnMessage.Create(self.ReceiverWindowHandle, OnWordInspectorPreviewOn));
  end;

  if (not TadxReceiverWindow(FReceiverWindow).Exists(TWordInspectorPreviewOffMessage)) then begin
      TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
        (TWordInspectorPreviewOffMessage.Create(self.ReceiverWindowHandle, OnWordInspectorPreviewOff));
  end;

  WatchObject := TWordInspectorPreviewWatchObject.Create(
      FOutlookHandleFinder as TOutlookHandleFinder,
      TWordInspectorPreviewOnMessage.Create(self.ReceiverWindowHandle, nil),
      TWordInspectorPreviewOffMessage.Create(self.ReceiverWindowHandle, nil),
      HostHandle,
      OutlookVersion);

  TWatchEngine(FWatchEngine).Add(WatchObject);

  result := WatchObject;
end;

procedure TadxOlFormsManager.OnWordInspectorPreviewOff(HostHandle: HWND;
  ItemType: TADXItemType);
var
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('Event OnWordInspectorPreviewOff  ItemType = ' + IntToStr(ItemType) + ', HostHandle = ' + IntToHex(HostHandle, 8));
  Log.AddIndent;

  InspectorArgs := nil;
  try
    GetRegisterOutlookInspector(HostHandle, InspectorObj);

    if InspectorObj = nil then begin
      Log.AddWarning('TadxOlFormsManager.OnWordInspectorPreviewOff: Cannot get registered Inspector');
      exit;
    end;

    InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, HostHandle, ccInspectorActivate);

    DoWordInspectorPreviewOff(InspectorArgs);

  finally
    if Assigned(InspectorArgs) then
      InspectorArgs.Free;

    InspectorObj := nil;
    TDebug.WriteLine('After DoWordInspectorPreviewOff');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.OnWordInspectorPreviewOn(HostHandle: HWND;
  ItemType: TADXItemType);
var
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('Event OnWordInspectorPreviewOn  ItemType = ' + IntToStr(ItemType) + ', HostHandle = ' + IntToHex(HostHandle, 8));
  Log.AddIndent;

  InspectorArgs := nil;
  try
    GetRegisterOutlookInspector(HostHandle, InspectorObj);

    if InspectorObj = nil then begin
      Log.AddWarning('TadxOlFormsManager.OnWordInspectorPreviewOn: Cannot get registered Inspector');
      exit;
    end;

    InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, HostHandle, ccInspectorActivate);

    DoWordInspectorPreviewOn(InspectorArgs);

  finally
    if Assigned(InspectorArgs) then
      InspectorArgs.Free;

    InspectorObj := nil;
    TDebug.WriteLine('After DoWordInspectorPreviewOn');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.DoWordInspectorPreviewOff(
  AInspectorArgs: TObject);
var
  index: integer;
begin
  Log.AddMessage('DoWordInspectorPreviewOff');
  Log.AddIndent;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[Index].CorrespondInspectorContext(AInspectorArgs) then begin
        DoShowInspectorForm(Items[Index], AInspectorArgs, true, ord(ciPreviewOff) );
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoWordInspectorPreviewOff: ' + E.Message), 'DoWordInspectorPreviewOff');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.DoWordInspectorPreviewOn(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  AdxOlInspector: TadxOlInspector;
  index: integer;
begin
  Log.AddMessage('DoWordInspectorPreviewOn');
  try
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    AdxOlInspector := nil;
    GetRegisterAdxOlInspector(InspectorArgs.InspectorWindowHandle, Pointer(AdxOlInspector));
    if (AdxOlInspector <> nil) then begin
      AdxOlInspector.ControlResizeWindowWatchObjectPause := true;

      try
        if (AdxOlInspector.FControlResizeWindowWatchObject <> nil) then begin
          //TO restore size in preview window
          AdxOlInspector.FControlResizeWindowWatchObject.SendSizeToEmulateWindow(false);
        end;

        for index := 0 to Items.Count - 1 do begin
          if (Items[index].CorrespondInspectorContext(AInspectorArgs)) then begin
            Items[index].HideInspectorForms(AInspectorArgs);
          end;
        end;

      finally
        AdxOlInspector.ControlResizeWindowWatchObjectPause := false;
      end;

    end;

  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoWordInspectorPreviewOn: ' + E.Message), 'DoWordInspectorPreviewOn');
  end;

end;

function TadxOlFormsManager.ExistsServiceForm(WindowHandle: HWND): boolean;
begin
  result := Globals.CheckADXMessageResult(WindowHandle, WM_ADXEXISTSERVICEFORM, 0, 0);
end;

procedure TadxOlFormsManager.AddRemoveControlledResizeWindowMessageToReceiver;
begin
  Log.AddMessage('AddRemoveControlledResizeWindowMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TRemoveControlledResizeWindowMessage)) then begin
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage(
      TRemoveControlledResizeWindowMessage.Create(self.ReceiverWindowHandle, OnRemoveControlledResizeWindow));
  end;
end;

procedure TadxOlFormsManager.OnRemoveControlledResizeWindow(HostHandle,
  EmulateWindowHandle: HWND);
var
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('Event OnRemoveControlledResizeWindow');
  Log.AddIndent;
  try

    InspectorArgs := nil;
    try
      GetRegisterOutlookInspector(HostHandle, InspectorObj);

      if InspectorObj = nil then begin
        Log.AddWarning('TadxOlFormsManager.OnRemoveControlledResizeWindow: Cannot get registered Inspector');
        exit;
      end;

      InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, HostHandle, ccInspectorActivate);

      DoRemoveControlledResizeWindow(InspectorArgs);

    finally
      if Assigned(InspectorArgs) then
        InspectorArgs.Free;

      InspectorObj := nil;
      TDebug.WriteLine('After DoRemoveControlledResizeWindow');
    end;

  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxOlFormsManager.DoRemoveControlledResizeWindow(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  AdxOlInspector: TadxOlInspector;
  index: integer;
begin
  Log.AddMessage('DoWordInspectorPreviewOn');
  try

    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    for index := 0 to Items.Count - 1 do begin
      if (Items[index].CorrespondInspectorContext(AInspectorArgs)) then begin
        Items[index].HideInspectorForms(AInspectorArgs);
      end;
    end;

    AdxOlInspector := nil;
    GetRegisterAdxOlInspector(InspectorArgs.InspectorWindowHandle, Pointer(AdxOlInspector));
    if (AdxOlInspector <> nil) then begin
{$IFDEF PREVIEWDELEMULATEWINDOW}
      AdxOlInspector.DeleteEmulateWindow;
{$ENDIF}
    end;

  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoWordInspectorPreviewOn: ' + E.Message), 'DoRemoveControlledResizeWindow');
  end;

end;

procedure TadxOlFormsManager.OnDeleteEmulateWindowEvent(HostHandle,
  EmulateWindowHandle: HWND);
var
  index: integer;
   AdxOlInspector: TadxOlInspector;

begin
  //This event sould be initialized by other add-in only
  Log.AddMessage('OnDeleteEmulateWindowEvent');
  for index := 0 to Items.Count - 1 do begin
    Items[index].HideFormsByEmulateWindowHandle(EmulateWindowHandle);
  end;
  GetRegisterAdxOlInspectorByEmulateWindowHandle(EmulateWindowHandle, Pointer(AdxOlInspector));
  if (AdxOlInspector <> nil) then begin
{$IFDEF CLIENTLAYOUTS}
    AdxOlInspector.HideInspectorRegionServiceForm();
{$ENDIF}
    AdxOlInspector.DeleteEmulateWindow;
  end;
end;


function TadxOlFormsManager.AddWindowForResizeControlToWatchEngine(
  AHostHandle, AEmulateWindowHandle, AWindowHandle: HWND): TObject;
var
  controlResizeWindowWatchObject: TControlResizeWindowWatchObject;
begin
  controlResizeWindowWatchObject :=
                TControlResizeWindowWatchObject.Create(AHostHandle, AEmulateWindowHandle, AWindowHandle, TadxReceiverWindow(FReceiverWindow).Handle);
  TWatchEngine(FWatchEngine).Add(controlResizeWindowWatchObject);
  result := controlResizeWindowWatchObject;
end;

procedure TadxOlFormsManager.CreateMutexes;
begin
  hMessageMutex := CreateMutex(nil, False, nil);
  hClearWatchObjectsMutex := CreateMutex(nil, False, nil);
  hResizeEmulateWibdowMutex := CreateMutex(nil, False, nil);
  hResizeEmulateWibdowMutexSbcls := hResizeEmulateWibdowMutex;
  hADXOLWatchEngineSendMessageMutex := CreateMutex(nil, False, 'ADXOLWatchEngineSendMessageMutex');
  hADXOLOutlookEvent := CreateMutex(nil, False, 'ADXVCLOLOutlookEvent');
end;

procedure TadxOlFormsManager.DeleteMutexes;
begin
  CloseHandle(hMessageMutex);
  CloseHandle(hClearWatchObjectsMutex);
  CloseHandle(hResizeEmulateWibdowMutex);
  CloseHandle(hADXOLWatchEngineSendMessageMutex);
  hResizeEmulateWibdowMutexSbcls := 0;
end;

procedure TadxOlFormsManager.GetRegisterAdxOlInspectorByEmulateWindowHandle(
  EmulateWindowHandle: HWND; var AdxOlInspector: Pointer);
var
  i: integer;
begin
  Log.AddMessage('GetRegisterAdxOlInspectorByEmulateWindowHandle');
  AdxOlInspector := nil;
  for i := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
    if TadxOlRegisterInspectorList(FRegisteredInspectorList)[i] <> nil then begin
      if (TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).FEmulateWindowHandle = EmulateWindowHandle) then begin
        AdxOlInspector := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]);
        exit;
      end;
    end
    else begin
     Log.AddWarning('TadxOlRegisterInspectorList(FRegisteredInspectorList)[i] = nil');
    end;
  end;
end;

procedure TadxOlFormsManager.DoRegionCloseButtonClick(AFormHandle: HWND);
var
  Form: TadxOlForm;
begin
  Form := FindFormByHandle(AFormHandle);
  DoRegionCloseButtonClick(Form);
end;

procedure TadxOlFormsManager.DoRegionCloseButtonClick(AForm: TadxOlForm);
var
  Args: TadxOlCloseButtonClickEventArgs;
  event: TadxEventRaising;
begin
  Args := nil;
  if Assigned(AForm) and Assigned(AForm.OnAdxCloseButtonClick) then begin
    try
      Args := TadxOlCloseButtonClickEventArgs.Create;
      try
        event := TadxEventRaising.Create('OnAdxCloseButtonClick', [eoLockRegionState]);
        try
          AForm.OnAdxCloseButtonClick(AForm, Args);
        finally
          event.Free;
        end;
        if (Args.CloseForm) then begin
          AForm.Hide;
        end;
        if (Args.DisableItem) then begin
          AForm.Item.Enabled := false;
        end;
      except
        on E: SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoAdxCloseButtonClick');
        end;
      end;
    finally
      if Assigned(Args) then begin
        Args.Free;
      end;
    end;
  end
  else begin
    if Assigned(AForm) then begin
      AForm.Hide;
    end;
  end;

end;


procedure TadxOlFormsManager.AddCloseButtonClickMessageToReceiver;
begin
  Log.AddMessage('AddCloseButtonClickMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TRegionCloseButtonClickMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TRegionCloseButtonClickMessage.Create(self.ReceiverWindowHandle, self));
end;

function TadxOlFormsManager.FindFormByHandle(
  AFormHandle: HWND): TadxOlForm;
var
  itemIndex: integer;
  formIndex: integer;
begin
  result := nil;
  for itemIndex := 0 to Items.Count - 1 do begin
    for formIndex := 0 to Items[itemIndex].FormInstanceCount - 1 do begin
      if Items[itemIndex].FormInstances[formIndex].Handle = AFormHandle then begin
        result := Items[itemIndex].FormInstances[formIndex];
        exit;
      end;
    end;
  end;
end;

function TadxOlFormsManager.HasWebViewPaneItemThatCorrespondExplorerContext(
  AExplorerArgs: TObject): boolean;
var
  ItemIndex: integer;
begin
  result := false;
  for ItemIndex := 0 to Items.Count - 1 do begin
    if Items[ItemIndex].IsWebViewPaneLayout and  Items[ItemIndex].CorrespondExplorerContext(AExplorerArgs) then begin
      result := true;
      exit;
    end;
  end;
end;

procedure TadxOlFormsManager.RegisterExplorer(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('RegisterExplorer 2');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  TadxOlRegisterExplorerList(FRegisteredExplorerList).Add(TadxOlExplorer.Create(Self, ExplorerArgs.ExplorerObj, ExplorerArgs.ExplorerWindowHandle));
end;

procedure TadxOlFormsManager.HideClientSubpaneServiceForm(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
begin
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  if (InspectorArgs.ClientSubpaneServiceForm <> nil) then begin
    InspectorArgs.ClientSubpaneServiceForm.Hide;
  end;
end;

procedure TadxOlFormsManager.HideAllServiceForm;
var
  i: integer;
  Form: TadxOlForm;
begin
  for i := 0 to TadxOlRegisterInspectorList(FRegisteredInspectorList).Count - 1 do begin
    Form := TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).InspectorRegionServiceForm;
    if (Form <> nil) then begin
      Form.HideByManager;
    end;
  end;

  for i := 0 to TadxOlRegisterExplorerList(FRegisteredExplorerList).Count - 1 do begin
    Form := TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).ReadingPaneServiceForm;
    if (Form <> nil) then begin
      Form.HideByManager;
    end;
    Form := TadxOlExplorer(TadxOlRegisterExplorerList(FRegisteredExplorerList)[i]).FolderViewServiceForm;
    if (Form <> nil) then begin
      Form.HideByManager;
    end;
  end;
end;

function TadxOlFormsManager.ValidateInspector(
  AAdxOlInspector: TObject): boolean;
var
  AdxOlInspector: TadxOlInspector;
begin
  Log.AddIndent;
  try
    AdxOlInspector := TadxOlInspector(AAdxOlInspector);
    try
      Log.AddMessage('ValidateInspector [' + IntToHex(AdxOlInspector.InspectorWindowHandle, 8) + '] ' + AdxOlInspector.FInspectorObj.Caption);
      result := true;
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('Inspertor is not valid: [' + IntToHex(AdxOlInspector.InspectorWindowHandle, 8) + '] ' + E.Message);
        result := false;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxOlFormsManager.DeleteInvalidInspectors;
var
  i: integer;
begin
  Log.AddMessage('DeleteInvalidInspectors');
  i := 0;
  while (i < TadxOlRegisterInspectorList(FRegisteredInspectorList).Count) do begin
    if not ValidateInspector(TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i])) then begin
      Log.AddMessage('DeleteInvalidInspectors: ' + IntToHex(TadxOlInspector(TadxOlRegisterInspectorList(FRegisteredInspectorList)[i]).FInspectorWindowHandle, 8));
      TadxOlRegisterInspectorList(FRegisteredInspectorList).Delete(i);
      Dec(i);
    end;
    Inc(i);
  end;
end;

function TadxOlFormsManager.GetFolderSyncIssuesObj: MAPIFolder;
begin
  case FOutlookVersion of
    v2003,
    v2007,
    v2010:
    begin
      if (not WasGettingFolderSyncIssuesObj) and (FFolderSyncIssuesObj = nil) then begin
        WasGettingFolderSyncIssuesObj := true;
        try
          FFolderSyncIssuesObj := TadxOlOutlookUtils(FOutlookUtils).GetDefaultFolder(olFolderSyncIssues);
        except
          on E: SysUtils.Exception do begin
            Log.AddWarning('The exception when getting the SyncIssues folder:' + E.Message);
          end;
        end;
      end;
    end;
  end;
  result := FFolderSyncIssuesObj;
end;


function TadxOlFormsManager.GetOutboxFolderObj: MAPIFolder;
begin
  if (FOutboxFolderObj = nil) then begin
    try
  	  FOutboxFolderObj := TadxOlOutlookUtils(FOutlookUtils).GetOutboxFolder();
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('The exception when getting the Outbox folder:' + E.Message);
      end;
    end;
  end;
  result := FOutboxFolderObj;
end;


function TadxOlFormsManager.GetPublicFoldersAllPublicFoldersObj: MAPIFolder;
begin
  if (not WasGettingPublicFoldersAllPublicFoldersObj) and (FPublicFoldersAllPublicFoldersObj = nil) then begin
    WasGettingPublicFoldersAllPublicFoldersObj := true;
    try
      FPublicFoldersAllPublicFoldersObj := TadxOlOutlookUtils(FOutlookUtils).GetPublicFoldersAllPublicFolders();
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('The exception when getting the PublicFoldersAllPublicFolders folder:' + E.Message);
      end;
    end;
  end;
  result := FPublicFoldersAllPublicFoldersObj;
end;

function TadxOlFormsManager.GetPublicFoldersObj: MAPIFolder;
begin
  if ((not WasGettingPublicFoldersObj) and (FPublicFoldersObj = nil)) then begin
    WasGettingPublicFoldersObj := true;
    try
    	FPublicFoldersObj := TadxOlOutlookUtils(FOutlookUtils).GetPublicFolders();
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('The exception when getting the PublicFolders folder:' + E.Message);
      end;
    end;
  end;
  result := FPublicFoldersObj;
end;

function TadxOlFormsManager.AdxLocalRegistryKey: string;
begin
  if (Owner <> nil) then begin
    result := (Owner as TadxCOMAddInModule).RegistryKey + '\' + Globals.ADXOLForm(false);
  end
  else begin
    result := '';
  end;
end;

function TadxOlFormsManager.AdxRegistryKey: string;
var Reg: TRegistry;
begin
  Result:= '\Software\Microsoft\Office\Outlook\AddIns\' + Globals.ADXOLForm(true) + '\';
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey(Result, true);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxOlFormsManager.LoadLayoutsFromRegistry;
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do begin
    Items[i].LoadExplorerLayoutFromRegistry;
    Items[i].LoadInspectorLayoutFromRegistry;     
  end;
end;

function TadxOlFormsManager.ConvertLayoutToAllowedDropRegion(
  Layout: TadxOlExplorerLayout): TadxOlExplorerAllowedDropRegion;
begin
  case Layout of
    elTopSubpane: result := erTopSubpane;
    elBottomSubpane: result := erBottomSubpane;
    elRightSubpane: result := erRightSubpane;
    elLeftSubpane: result := erLeftSubpane;
    elBottomOutlookBar: result := erBottomOutlookBar;
    elBottomNavigationPane: result := erBottomNavigationPane;
    elBottomTodoBar: result := erBottomTodoBar;
		elTopReadingPane: result := erTopReadingPane;
		elBottomReadingPane: result := erBottomReadingPane;
		elLeftReadingPane: result := erLeftReadingPane;
		elRightReadingPane: result := erRightReadingPane;
    elReadingPane: result := erReadingPane;
    elFolderView: result := erFolderView;

{$IFDEF DOCKEXPLORERLAYOUTS}
    elDockTop: result := erDockTop;
    elDockBottom: result := erDockBottom;
    elDockRight: result := erDockRight;
    elDockLeft: result := erDockLeft;
{$ENDIF}

    else raise SysUtils.Exception.Create('ConvertLayoutToAllowedDropRegion: Illegal layout');
  end;
end;

function TadxOlFormsManager.ConvertLayoutToAllowedDropRegion(
  Layout: TadxOlInspectorLayout): TadxOlInspectorAllowedDropRegion;
begin
  case Layout of
    ilBottomSubpane:        result := irBottomSubpane;
    ilLeftSubpane:          result := irLeftSubpane;
    ilRightSubpane:         result := irRightSubpane;
    ilTopSubpane:           result := irTopSubpane;
    ilInspectorRegion:      result := irInspectorRegion;
{$IFDEF SUBSTINSPECTORREGION}
    ilCompleteReplacement: raise SysUtils.Exception.Create('ConvertLayoutToAllowedDropRegion: Illegal the ilCompleteReplacement layout');
{$ENDIF}
    else
      //result := TadxOlInspectorAllowedDropRegion(0);
      raise SysUtils.Exception.Create('ConvertLayoutToAllowedDropRegion: Illegal Layout');
  end;
end;

function TadxOlFormsManager.CheckInspectorAllowedDropRegion(
  Item: TadxOlFormsCollectionItem; RegionItemType: TadxItemType;
  RegionWindowLayout: TadxWindowLayout;
  DragContextInspectorItemType: TadxOlInspectorItemType;
  DragContextMailInspectorType: integer): boolean;
var
  CorrespondItemType: boolean;
  IsAvailableWindowLayout: boolean;
begin

  CorrespondItemType := CompareInspectorAllowedDropRegionsAndAdxItemType(Item, RegionItemType, DragContextInspectorItemType, DragContextMailInspectorType);
  IsAvailableWindowLayout := CompareInspectorAllowedDropRegionsAndWindowLayout(Item, RegionWindowLayout);

  result := (CorrespondItemType and IsAvailableWindowLayout);

end;

function TadxOlFormsManager.CompareInspectorAllowedDropRegionsAndAdxItemType(
  Item: TadxOlFormsCollectionItem; ItemType: TadxItemType;
  InspectorItemType: TadxOlInspectorItemType;
  MailInspectorType: integer): boolean;
begin
  result := false;
  if (not result) and (CompareInspectorAllowedDropRegionsAndAdxItemType(Item, ItemType, InspectorItemType, MailInspectorType, irInspectorRegion)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndAdxItemType(Item, ItemType, InspectorItemType, MailInspectorType, irBottomSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndAdxItemType(Item, ItemType, InspectorItemType, MailInspectorType, irLeftSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndAdxItemType(Item, ItemType, InspectorItemType, MailInspectorType, irRightSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndAdxItemType(Item, ItemType, InspectorItemType, MailInspectorType, irTopSubpane)) then result := true;
end;

function TadxOlFormsManager.CompareInspectorAllowedDropRegionsAndAdxItemType(
  Item: TadxOlFormsCollectionItem; ItemType: TadxItemType;
  InspectorItemType: TadxOlInspectorItemType; MailInspectorType: integer;
  AllowedDropRegion: TadxOlInspectorAllowedDropRegion): boolean;
var
  allowedItemType: TadxItemType;
begin
  if ((Item.InspectorAllowedDropRegions * [AllowedDropRegion]) = [AllowedDropRegion]) then begin
    allowedItemType := GetInspectorAllowedDropAdxItemType(InspectorItemType, MailInspectorType);
    if (allowedItemType = ItemType) then begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;

function TadxOlFormsManager.CompareInspectorAllowedDropRegionsAndWindowLayout(
  Item: TadxOlFormsCollectionItem;
  WindowLayout: TadxWindowLayout): boolean;
begin
  result := false;
  if (not result) and (CompareInspectorAllowedDropRegionsAndWindowLayout(Item, WindowLayout, irBottomSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndWindowLayout(Item, WindowLayout, irInspectorRegion)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndWindowLayout(Item, WindowLayout, irLeftSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndWindowLayout(Item, WindowLayout, irRightSubpane)) then result := true;
  if (not result) and (CompareInspectorAllowedDropRegionsAndWindowLayout(Item, WindowLayout, irTopSubpane)) then result := true;
end;

function TadxOlFormsManager.CompareInspectorAllowedDropRegionsAndWindowLayout(
  Item: TadxOlFormsCollectionItem; WindowLayout: TadxWindowLayout;
  AllowedDropRegion: TadxOlInspectorAllowedDropRegion): boolean;
var
  allowedWindowLayout: TadxWindowLayout;
begin
  if ((Item.InspectorAllowedDropRegions * [AllowedDropRegion]) = [AllowedDropRegion]) then begin

      allowedWindowLayout := GetInspectorAdxLayout(AllowedDropRegion);
      if (allowedWindowLayout = WindowLayout) then begin
        result := true;
        exit;
      end;
  end;
  result := false;
end;

function TadxOlFormsManager.CheckExplorerAllowedDropRegion(
  Item: TadxOlFormsCollectionItem; RegionItemType: TadxItemType;
  RegionWindowLayout: TadxWindowLayout;
  DragContextExplorerItemType: TadxOlExplorerItemType): boolean;
var
  CorrespondItemType: boolean;
  IsAvailableWindowLayout: boolean;
begin
  CorrespondItemType := CompareExplorerAllowedDropRegionsAndAdxItemType(Item, RegionItemType, DragContextExplorerItemType);
  IsAvailableWindowLayout := CompareExplorerAllowedDropRegionsAndWindowLayout(Item, RegionItemType, RegionWindowLayout);
  result := (CorrespondItemType and IsAvailableWindowLayout);
end;

function TadxOlFormsManager.CompareExplorerAllowedDropRegionsAndAdxItemType(
  Item: TadxOlFormsCollectionItem; ItemType: TAdxItemType;
  ExplorerItemType: TadxOlExplorerItemType): boolean;
begin
  result := false;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erBottomNavigationPane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erBottomOutlookBar)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erBottomTodoBar)) then result := true;

  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erFolderView)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erBottomSubpane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erLeftSubpane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erRightSubpane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erTopSubpane)) then result := true;

  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erReadingPane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erLeftReadingPane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erRightReadingPane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erTopReadingPane)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erBottomReadingPane)) then result := true;

{$IFDEF DOCKEXPLORERLAYOUTS}
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erDockBottom)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erDockLeft)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erDockRight)) then result := true;
  if (not result) and (CompareExplorerAllowedDropRegionsAndAdxItemType(Item, ItemType, ExplorerItemType, erDockTop)) then result := true;
{$ENDIF}

end;

function TadxOlFormsManager.CompareExplorerAllowedDropRegionsAndAdxItemType(
  Item: TadxOlFormsCollectionItem; ItemType: TadxItemType;
  ExplorerItemType: TadxOlExplorerItemType;
  AllowedDropRegion: TadxOlExplorerAllowedDropRegion): boolean;
var
  allowedItemType: TAdxItemType;
begin
  if ([AllowedDropRegion] = (Item.ExplorerAllowedDropRegions * [AllowedDropRegion])) then begin
    allowedItemType := GetExplorerAllowedDropAdxItemType(AllowedDropRegion, ExplorerItemType);
    if (allowedItemType = ItemType) then begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;

function TadxOlFormsManager.CompareExplorerAllowedDropRegionsAndWindowLayout(
  Item: TadxOlFormsCollectionItem; RegionItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): boolean;
begin
  result := false;
  case RegionItemType of
    stOlMail,
    stOlAppointment,
    stOlContact,
    stOlJournal,
    stOlTask,
    stOlNote:
      begin
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erFolderView)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erBottomSubpane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erLeftSubpane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erRightSubpane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erTopSubpane)) then result := true;
      end;
    stOlNavigationPane,
    stOlFolderList:
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erBottomNavigationPane)) then result := true;
    stOlReadingPane:
      begin
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erReadingPane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erLeftReadingPane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erRightReadingPane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erTopReadingPane)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erBottomReadingPane)) then result := true;
      end;
    stOlTodoBar:
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erBottomTodoBar)) then result := true;
    stOlOutlookBar:
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erBottomOutlookBar)) then result := true;
{$IFDEF DOCKEXPLORERLAYOUTS}
    stOfficeTaskPane:
      begin
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erDockBottom)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erDockLeft)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erDockRight)) then result := true;
        if (not result) and (CompareExplorerAllowedDropRegionsAndWindowLayout(Item, WindowLayout, erDockTop)) then result := true;
      end;
{$ENDIF}
  end;
end;

function TadxOlFormsManager.CompareExplorerAllowedDropRegionsAndWindowLayout(
  Item: TadxOlFormsCollectionItem; WindowLayout: TadxWindowLayout;
  AllowedDropRegion: TadxOlExplorerAllowedDropRegion): boolean;
var
  allowedWindowLayout:  TadxWindowLayout;
begin
  if ((Item.ExplorerAllowedDropRegions * [AllowedDropRegion]) = [AllowedDropRegion]) then begin
      allowedWindowLayout := GetExplorerAdxLayout(AllowedDropRegion);
      if (allowedWindowLayout = WindowLayout) then begin
        result := true;
        exit;
      end;
  end;
  result := false;
end;

function TadxOlFormsManager.GetExplorerAllowedDropAdxItemType(
  AllowedDropRegion: TadxOlExplorerAllowedDropRegion;
  ExplorerItemType: TadxOlExplorerItemType): TadxItemType;
begin
  result := stOlUnknown;
  case AllowedDropRegion of
    erTopSubpane,
    erBottomSubpane,
    erRightSubpane,
    erLeftSubpane,
    erFolderView:
    case ExplorerItemType of
      expMailItem: result := stOlMail;
      expAppointmentItem: result := stOlAppointment;
      expContactItem: result := stOlContact;
      expTaskItem: result := stOlTask;
      expJournalItem: result := stOlJournal;
      expNoteItem: result := stOlNote;
      expPostItem: result := stOlMail;
      expDistributionListItem: result := stOlMail;
      else
        SysUtils.Exception.Create('GetExplorerAllowedDropAdxItemType: ExplorerItemType is not found.')
    end;

    erBottomOutlookBar:
      if (FOutlookVersion = v2000) or (FOutlookVersion = v2002) then begin
        result := stOlOutlookBar;
      end;
    erBottomNavigationPane: begin
        if (FOutlookVersion = v2000) or (FOutlookVersion = v2002) then begin
          result := stOlFolderList;
        end;
        if (FOutlookVersion = v2003)
          or (FOutlookVersion = v2007)
          or (FOutlookVersion = v2010) then begin
          result := stOlNavigationPane;
        end;
      end;
    erBottomTodoBar: result := stOlTodoBar;
		erTopReadingPane,
		erBottomReadingPane,
		erLeftReadingPane,
		erRightReadingPane,
    erReadingPane:
      result := stOlReadingPane;
{$IFDEF DOCKEXPLORERLAYOUTS}
    erDockLeft,
    erDockRight,
    erDockTop,
    erDockBottom:
      result:= stOfficeTaskPane;
{$ENDIF}
  end;
end;

function TadxOlFormsManager.GetInspectorAllowedDropAdxItemType(
  InspectorItemType: TadxOlInspectorItemType;
  MailInspectorType: integer): TadxItemType;
begin
  result := GetInspectorAdxItemType(InspectorItemType, MailInspectorType);
end;

function TadxOlFormsManager.GetExplorerAdxLayout(
  ExplorerAllowedDropRegion: TadxOlExplorerAllowedDropRegion): TadxWindowLayout;
begin
  case ExplorerAllowedDropRegion of
{$IFDEF DOCKEXPLORERLAYOUTS}
    erDockLeft:             result := wlDockLeft;
    erDockRight:            result := wlDockRight;
    erDockTop:              result := wlDockTop;
    erDockBottom:           result := wlDockBottom;
{$ENDIF}
    erTopSubpane:           result := wlTop;
    erBottomSubpane:        result := wlBottom;
    erRightSubpane:         result := wlRight;
    erLeftSubpane:          result := wlLeft;
    erFolderView:           result := wlClient;

    erBottomOutlookBar:     result := wlBottom;
    erBottomNavigationPane: result := wlBottom;
    erBottomTodoBar:        result := wlBottom;

    erBottomReadingPane:    result := wlBottom;
    erTopReadingPane:       result := wlTop;
    erRightReadingPane:     result := wlRight;
    erLeftReadingPane:      result := wlLeft;
    erReadingPane:          result := wlClient;
    else
        raise SysUtils.Exception.Create('GetExplorerAdxLayout: The ExplorerLayout is not found.');
  end;
end;

function TadxOlFormsManager.GetInspectorAdxLayout(
  InspectorAllowedDropRegion: TadxOlInspectorAllowedDropRegion): TadxWindowLayout;
begin
  case InspectorAllowedDropRegion of
    irTopSubpane:      result := wlTop;
    irBottomSubpane:   result := wlBottom;
    irRightSubpane:    result := wlRight;
    irLeftSubpane:     result := wlLeft;
    irInspectorRegion: result := wlClient;
    else
      raise SysUtils.Exception.Create('GetInspectorAdxLayout: The InspectorAdxLayout is not found.');
  end;
end;

function TadxOlFormsManager.GetExplorerLayout(ItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): TadxOlExplorerLayout;
begin
  case ItemType of
    stOlFolderList:
      case WindowLayout of
        wlClient: result := elUnknown;
        wlBottom: result := elBottomNavigationPane;
        wlLeft: result := elUnknown;
        wlRight: result := elUnknown;
        wlTop: result := elUnknown;
        else
          result := elUnknown;
      end;
    stOlOutlookBar:
      case WindowLayout of
        wlClient: result := elUnknown;
        wlBottom: result := elBottomOutlookBar;
        wlLeft: result := elUnknown;
        wlRight: result := elUnknown;
        wlTop: result := elUnknown;
        else
          result := elUnknown;
      end;
    stOlNavigationPane:
      case WindowLayout of
        wlClient: result := elUnknown;
        wlBottom: result := elBottomNavigationPane;
        wlLeft: result := elUnknown;
        wlRight: result := elUnknown;
        wlTop: result := elUnknown;
        else
          result := elUnknown;
      end;
    stOlTodoBar:
      case WindowLayout of
        wlClient: result := elUnknown;
        wlBottom: result := elBottomTodoBar;
        wlLeft: result := elUnknown;
        wlRight: result := elUnknown;
        wlTop: result := elUnknown;
        else
          result := elUnknown;
      end;
    stOlMail,
    stOlAppointment,
    stOlContact,
    stOlJournal,
    stOlTask,
    stOlNote:
      case WindowLayout of
        wlClient: result := elFolderView;
        wlBottom: result := elBottomSubpane;
        wlLeft: result := elLeftSubpane;
        wlRight: result := elRightSubpane;
        wlTop: result := elTopSubpane;
        else
          result := elUnknown;
      end;
    stOlReadingPane:
      case WindowLayout of
        wlClient: result := elReadingPane;
        wlBottom: result := elBottomReadingPane;
        wlLeft: result := elLeftReadingPane;
        wlRight: result := elRightReadingPane;
        wlTop: result := elTopReadingPane;
        else
          result := elUnknown;
      end;
{$IFDEF DOCKEXPLORERLAYOUTS}
    stOfficeTaskPane:
      case WindowLayout of
        wlDockBottom: result := elDockBottom;
        wlDockLeft: result := elDockLeft;
        wlDockRight: result := elDockRight;
        wlDockTop: result := elDockTop;
        else
          result := elUnknown;
      end;
{$ENDIF}
    else
      raise SysUtils.Exception.Create('GetExplorerLayout: The ExplorerLayout is not found.');
  end;
end;

function TadxOlFormsManager.GetInspectorLayout(ItemType: TadxItemType;
  WindowLayout: TadxWindowLayout): TadxOlInspectorLayout;
begin
  case ItemType of
    stOlMailInspector,
    stOlWordMailInspector,
    stOlAppointmentInspector,
    stOlTaskInspector,
    stOlContactInspector,
    stOlDistributionListInspector,
    stOlJournalInspector,
    stOlReportInspector,
    stOlMeetingInspector,
    stOlDefaultInspector,
    stOlSharingInspector,
    stOlMobileInspector:
      case WindowLayout of
        wlClient: result := ilInspectorRegion;
        wlBottom: result := ilBottomSubpane;
        wlLeft: result := ilLeftSubpane;
        wlRight: result := ilRightSubpane;
        wlTop: result := ilTopSubpane;
        else
          result := ilUnknown;
      end;
    else
      raise SysUtils.Exception.Create('GetInspectorLayout: The InspectorLayout is not found.');
  end;
end;

function TadxOlFormsManager.GetExplorerRegionSize(
  ExplorerLayout: TadxOlExplorerLayout;
  ExplorerItemType: TadxOlExplorerItemType;
  ReadingPaneLayout: TadxOlReadingPaneLayout;
  ItemType: TadxItemType): integer;
var
  Reg: TRegistry;
  keyValue: string;
begin
  result := 0;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(AdxRegistryKey) then begin
      Reg.OpenKey(AdxRegistryKey, false);
      keyValue := TadxOlForm.GetExplorerLayoutKey(ExplorerLayout, ExplorerItemType, ReadingPaneLayout);
      if Reg.ValueExists(KeyValue + '_Size') then begin
        result := Reg.ReadInteger(KeyValue + '_Size');
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

function TadxOlFormsManager.GetInspectorRegionSize(
  InspectorLayout: TadxOlInspectorLayout): integer;
var
  Reg: TRegistry;
  keyValue: string;
begin
  result := 0;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.KeyExists(AdxRegistryKey) then begin
      Reg.OpenKey(AdxRegistryKey, false);
      keyValue := TadxOlForm.GetInspectorLayoutKey(InspectorLayout);
      if Reg.ValueExists(KeyValue + '_Size') then begin
        result := Reg.ReadInteger(KeyValue + '_Size');
      end;
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure TadxOlFormsManager.DoAfterAccessProtectedObject;
var
  event: TadxEventRaising;
begin
  Log.AddMessage('DoAfterAccessProtectedObject');
  try
    if Assigned(OnADXAfterAccessProtectedObject) then begin
      try
        event := TadxEventRaising.Create('OnADXAfterAccessProtectedObject', [eoLockRegionState]);
        try
          OnADXAfterAccessProtectedObject(Self);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoAfterAccessProtectedObject');
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoAfterAccessProtectedObject: ' + E.Message), 'DoAfterAccessProtectedObject');
  end;
end;

procedure TadxOlFormsManager.DoBeforeAccessProtectedObject;
var
  event: TadxEventRaising;
begin
  Log.AddMessage('DoBeforeAccessProtectedObject');
  try
    if Assigned(OnADXBeforeAccessProtectedObject) then begin
      try
        event := TadxEventRaising.Create('OnADXBeforeAccessProtectedObject', [eoLockRegionState]);
        try
          OnADXBeforeAccessProtectedObject(Self);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoBeforeAccessProtectedObject');
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoBeforeAccessProtectedObject: ' + E.Message), 'DoBeforeAccessProtectedObject');
  end;
end;

procedure TadxOlFormsManager.OnApplicationQuit(Sender: TObject);
begin
  try
    if Assigned(FOldApplicationQuit) then begin
      FOldApplicationQuit(Sender);
    end;
  finally
    try
      Log.AddMessage('');
      Log.AddMessage('Event: OnApplicationQuit');
      Log.AddIndent();
      try
        DoApplicationQuit(Sender);
      finally
        Log.RemoveIndent;
        Log.AddMessage('');
      end;
    except
      on E:SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'OnApplicationQuit')
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.DoApplicationQuit(Sender: TObject);
begin
  Log.AddMessage('TadxOlFormsManager.DoApplicationQuit');
  //The sbFast value is supposed to be for Outlook 2010(14) and higher.
  if (COMAddInModule.OutlookShutdownBehavior  = osFast) then begin
    DoShutdown(nil);
    DoFinalize(nil);
    TadxOlFormsManagerState(State).WasShutdownInApplicationQuit := true;
  end;
end;

procedure TadxOlFormsManager.DoShutdown(Sender: TObject);
var
  DisableInCOMAddinsDialogWhenOutlookIsOpened: boolean;
begin
  Log.AddMessage('TadxOlFormsManager.DoAddInBeginShutdown');

  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;

  Log.AddIndent;

  try

    TadxOlFormsManagerState(State).isShutdown := true;
    FOutlookHook.EnableProcessWatchObjects := false;
    try
      Log.AddMessage('TadxOlOutlookUtils(OutlookUtils).ExplorersCount');
      DisableInCOMAddinsDialogWhenOutlookIsOpened := (TadxOlOutlookUtils(OutlookUtils).ExplorersCount > 0);

      if DisableInCOMAddinsDialogWhenOutlookIsOpened then begin
        TadxOlFormsManagerState(State).DisableInCOMAddinsDialogWhenOutlookIsOpened := true;
        DoPreparationDisableAddinInCOMAddinsDialog;
      end;
      //else see ExplorerClose

      if Assigned(FWatchEngine) then begin
        Log.AddMessage('TWatchEngine stop');
        TWatchEngine(FWatchEngine).Terminate;
        TWatchEngine(FWatchEngine).WaitFor;
        TWatchEngine(FWatchEngine).Free;
        FWatchEngine := nil;
      end;
      DeleteAllForms;

      FreeExistentInspectors;
      FreeExistentExplorers;

      ReleaseDefaultFolders();

  {$IFDEF WithADXHTMLFile}
      Globals.DeleteHTMLFile(Self.HTMLFileFullName(COMAddinModule));
      Globals.DeleteHTMLRootDir(COMAddinModule);
  {$ENDIF}

      DisconnectOutlookEvents();
      DisconnectAddinModuleEvents();

      TAppWindowBehaviour.SingletonFree;
      TFindWindowFactory.SingletonFree;
    finally
      TadxOlFormsManagerState(State).DisableInCOMAddinsDialogWhenOutlookIsOpened := false;
      TadxOlFormsManagerState(State).isShutdown := false;
    end;
    TDebug.WriteLine('DoAddInBeginShutdown');
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoAddInBeginShutdown' + E.Message), 'DoAddInBeginShutdown');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlFormsManager.DoFinalize(Sender: TObject);
begin
  Log.AddMessage('TadxOlFormsManager.DoFinalize');

  if (COMAddInModule.HostType <> ohaOutlook) then begin
    exit;
  end;

  adxWSbcls.APIFinalize;
end;

function TadxOlFormsManager.IsContextSupport(
  ExplorerLayout: TadxolExplorerLayout; AExplorerArgs: TObject): boolean;
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  //Also see ADXOlForm.IsContextSupportDropRegions
  Log.AddMessage('IsContextSupport');

{$IFDEF DOCKEXPLORERLAYOUTS}
  if (OutlookVersion < v2007) then begin
      case ExplorerLayout of
          elDockLeft,
          elDockRight,
          elDockTop,
          elDockBottom: begin
            Log.AddMessage('Skip Dock layouts.');
            result := false;
            exit;
          end;
      end;
  end;
{$ENDIF}

  if (OutlookVersion = v2003)
    or (OutlookVersion = v2007) then begin
      case ExplorerLayout of
          elReadingPane,
          elLeftReadingPane,
          elRightReadingPane,
          elTopReadingPane,
          elBottomReadingPane: begin
            if (not ExplorerArgs.CheckCompatibilityWithSocialConnectorAddin()) then begin
              Log.AddMessage('Skip ReadingPane layouts when SocialConnectorAddin.');
              result := false;
              exit;
            end;
          end;
      end;
  end;


  if (OutlookVersion = v2010) then begin
      case ExplorerLayout of
          elBottomTodoBar: begin
          end;
          elFolderView,
          elLeftSubpane,
          elRightSubpane,
          elTopSubpane,
          elBottomSubpane:
              if (ExplorerArgs.ExplorerItemType = expAppointmentItem) then begin
                  Log.AddMessage('Skip Explorer layouts for the Outlook 2010: ' + IntToStr(ord(ExplorerArgs.ExplorerItemType)));
                  result := false;
                  exit;
              end;

          elReadingPane,
          elLeftReadingPane,
          elRightReadingPane,
          elTopReadingPane,
          elBottomReadingPane: begin
{$IFDEF SupportAdjacentWindow}
            ;
{$ELSE}
            if (SocialConnectorAddinConnected) then begin
              Log.AddMessage('Skip Explorer layouts for the Outlook 2010: ReadingPane layouts.');
              result := false;
              exit;
            end;
{$ENDIF}
          end;
      end;
  end;
  result := true;

end;

procedure TadxOlFormsManager.CheckSocialConnectorAddinConnection;
var
  objAddins, objAddin: IDispatch;
  indent: TLogIndent;
begin
  indent := TLogIndent.Create('CheckSocialConnectorAddinConnection');
  FSocialConnectorAddinConnected := false;
  try
    try
      objAddins := OutlookAppObj.COMAddIns;
      objAddin := OleVariant(objAddins).Item('OscAddin.Connect');
      if (objAddin <> nil) then begin
        FSocialConnectorAddinConnected := OleVariant(objAddin).Connect;
      end;
    except
      on E: SysUtils.Exception do begin
        Log.AddMessage(E.Message);
      end;
    end;

  finally
    objAddins := nil;
    objAddin := nil;
    indent.Free;
  end;
end;

procedure TadxOlFormsManager.SaveActiveInspectorForms(
  var ActiveInspectorForms: array of TadxOlForm; AInspectorArgs: TObject);
//implement Case693
var
  index: integer;
  activeForm: TadxOlForm;
begin
  for index := 0 to Length(ActiveInspectorForms) - 1 do begin
    ActiveInspectorForms[index] := nil;
  end;

  for index := 0 to Items.Count - 1 do begin
    activeForm := Items[index].GetActiveInspectorForm(AInspectorArgs);
    if (activeForm <> nil) then begin
      case (activeForm.Item.InspectorLayout) of
        ilBottomSubpane:
          ActiveInspectorForms[0] := activeForm;
        ilInspectorRegion:
          ActiveInspectorForms[1] := activeForm;
{$IFDEF SUBSTINSPECTORREGION}
        ilCompleteReplacement:
          ActiveInspectorForms[1] := activeForm;
{$ENDIF}
        ilLeftSubpane:
          ActiveInspectorForms[2] := activeForm;
        ilRightSubpane:
          ActiveInspectorForms[3] := activeForm;
        ilTopSubpane:
          ActiveInspectorForms[4] := activeForm;
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.ShowActiveInspectorForms(
  var ActiveInspectorForms: array of TadxOlForm; AInspectorArgs: TObject);
//implement Case693
var
  index: integer;
begin
  if Length(ActiveInspectorForms) < 5 then begin
    raise SysUtils.Exception.Create('The length of the ActiveInspectorForms array size should be 5');
  end;

  for index := 0 to Length(ActiveInspectorForms) - 1 do begin
    if ActiveInspectorForms[index] <> nil then begin
      DoShowInspectorForm(ActiveInspectorForms[index].Item, AInspectorArgs, false, ord(ciRefreshInspectorTab));
    end;
  end;


end;

procedure TadxOlFormsManager.OnRefreshInspectorTab(
  InspectorWindowHandle: HWND; OldWindowHandle: HWND; NewWindowHandle: HWND; ItemType: TadxItemType);
var
  LogEvent: TLogEvent;
  InspectorObj: Inspector;
  InspectorArgs: TadxOlInspectorArguments;
  activeInspectorForms: array [0..4] of TadxOlForm;
begin
  TDebug.WriteLine(Log.AddinName + '.@@@ OnRefreshInspectorTab-');
  if (TadxRefreshInspectorTabStateGuard.Instance.IsLock) then begin
    Log.AddWarning('Skip OnRefreshInspectorTab: RefreshInspectorTabStateGuard is Locked');
    exit;
  end;

  LogEvent := TLogEvent.Create('OnRefreshInspectorTab');
  LockWindowUpdate(InspectorWindowHandle);
  StartRefreshInspectorTabTransaction(OldWindowHandle);
  try
    try
      GetRegisterOutlookInspector(InspectorWindowHandle, InspectorObj);
      InspectorArgs := TadxOlInspectorArguments.Create(self, InspectorObj, InspectorWindowHandle, ccRefreshInspectorTab);
      InspectorArgs.WindowHandle := NewWindowHandle;
      try
        SaveActiveInspectorForms(activeInspectorForms, InspectorArgs);
        HideAllFormsInAllAddins(OldWindowHandle);
        DoInspectorWindowHide(InspectorArgs);
        ShowActiveInspectorForms(activeInspectorForms, InspectorArgs);
        DoInspectorWindowShow(InspectorArgs, ord(ciRefreshInspectorTab));

      finally
        if (InspectorArgs <> nil) then begin
          InspectorArgs.Free;
        end;
      end;
    except
      on E:SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('OnRefreshInspectorTab: ' + E.Message), 'OnRefreshInspectorTab');
    end;
  finally
    EndRefreshInspectorTabTransaction(OldWindowHandle);
    LockWindowUpdate(0);
    LogEvent.Free;
  end;
  TDebug.WriteLine(Log.AddinName + '.@@@ OnRefreshInspectorTab+');

end;

procedure TadxOlFormsManager.CheckAndRunRefreshInspectorTabWatchObject(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  watchObject: TWatchObject;
begin
  TDebug.WriteLine(Log.AddinName + '. @@@ CheckAndRunRefreshInspectorTabWatchObject');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

    if (OutlookVersion = v2010) then begin
      case InspectorArgs.FInspectorItemType of
          insContact,
          insMail,
          insPost,
          insTask,
          insTaskRequest,
          insTaskRequestAccept,
          insTaskRequestDecline,
          insTaskRequestUpdate,
          insAppointment,
          insJournal,
          insDistributionList,
          insReport,
          insMeetingRequest,
          insMeetingResponseNegative,
          insMeetingResponsePositive,
          insMeetingResponseTentative,
          insSharing,
          insMobile: begin
              watchObject :=
                    TRefreshInspectorTabWatchObject.Create(self.ReceiverWindowHandle, InspectorArgs.InspectorWindowHandle, InspectorArgs.ContextInspectorAdxItemType);
              FOutlookHook.AddHandleHookWatchObject(watchObject);
          end;
          else begin
              Log.AddWarning('DoInspectorWindowShow: unsupported InspectorItemTypes for RefreshInspectorTabWatchObject');
          end;
      end;
    end;

    if ((OutlookVersion = v2007)
        and (self.SocialConnectorAddinConnected)) then begin

      case (InspectorArgs.InspectorItemType) of
        insMail,
        insPost,
        insContact,
        insAppointment,
        insMeetingRequest,
        insMeetingResponseNegative,
        insMeetingResponsePositive,
        insMeetingResponseTentative: begin
          watchObject := TRefreshInspectorTabWatchObject.Create(
            self.ReceiverWindowHandle,
            InspectorArgs.InspectorWindowHandle,
            InspectorArgs.ContextInspectorAdxItemType);
            FOutlookHook.AddHandleHookWatchObject(watchObject);
        end;


        insDistributionList,
        insJournal,
        insTask,
        insTaskRequest,
        insTaskRequestAccept,
        insTaskRequestDecline,
        insTaskRequestUpdate,
        insReport,
        insSharing,
        insMobile: begin
              //There is no the Social Connector Window
        end;

        else begin
          Log.AddWarning('DoInspectorWindowShow: unsupported InspectorItemTypes for RefreshInspectorTabWatchObject');
        end;
      end;
    end;

    if ((OutlookVersion = v2003)
        and (self.SocialConnectorAddinConnected)
        and (not InspectorArgs.IsWordMailInspector)) then begin
      case InspectorArgs.InspectorItemType of
        insMail,
        insPost,
        insContact,
        insAppointment,
        insMeetingRequest,
        insMeetingResponseNegative,
        insMeetingResponsePositive,
        insMeetingResponseTentative: begin
          watchObject := TRefreshInspectorTabWatchObject.Create(
            self.ReceiverWindowHandle,
            InspectorArgs.InspectorWindowHandle,
            InspectorArgs.ContextInspectorAdxItemType);
            FOutlookHook.AddHandleHookWatchObject(watchObject);
        end;

        insDistributionList,
        insJournal,
        insTask,
        insTaskRequest,
        insTaskRequestAccept,
        insTaskRequestDecline,
        insTaskRequestUpdate,
        insReport,
        insSharing,
        insMobile: begin
          //There is no the Social Connector Window
        end;

        else begin
          Log.AddWarning('DoInspectorWindowShow: unsupported InspectorItemTypes for RefreshInspectorTabWatchObject');
        end;
      end;
    end;

end;

procedure TadxOlFormsManager.OnEndRefreshInspectorTabTransaction(
  WindowHandle: HWND);
begin
  if (FRefreshInspectorTabTransactionWindowHandle <> WindowHandle) then begin
    Log.AddWarning('FRefreshInspectorTabTransactionWindowHandle <> WindowHandle');
  end;
  if (TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction <> true) then begin
    Log.AddWarning('TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction <> true');
  end;
  TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction := False;
  FRefreshInspectorTabTransactionWindowHandle := 0;
  TDebug.WriteLine(Log.AddinName + '.@@@ OnStartRefreshInspectorTabTransaction+');
end;

procedure TadxOlFormsManager.OnStartRefreshInspectorTabTransaction(
  WindowHandle: HWND);
begin
  TDebug.WriteLine(Log.AddinName + '.@@@ OnStartRefreshInspectorTabTransaction-');
  TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction := true;
  FRefreshInspectorTabTransactionWindowHandle := WindowHandle;
end;

procedure TadxOlFormsManager.EndRefreshInspectorTabTransaction(
  WindowHandle: HWND);
begin
  SendMessageFindWindows(GetDesktopWindow,
    ReceiverWindowHandle,
    GlobalsOl.ADXOlReceiverWindowCaption,
    '',
    WM_ADXENDTRANSACTION,
    trRefreshInspectorTab,
    WindowHandle,
    false);
  TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction := false;
  TDebug.WriteLine(Log.AddinName + '.@@@ StartRefreshInspectorTabTransaction+');
end;

procedure TadxOlFormsManager.StartRefreshInspectorTabTransaction(
  WindowHandle: HWND);
begin
  TDebug.WriteLine(Log.AddinName + '.@@@ StartRefreshInspectorTabTransaction-');
  TadxOlFormsManagerState(State).isRefreshInspectorTabTransaction := true;

  SendMessageFindWindows(GetDesktopWindow,
    ReceiverWindowHandle,
    GlobalsOl.ADXOlReceiverWindowCaption,
    '',
    WM_ADXSTARTTRANSACTION,
    trRefreshInspectorTab,
    WindowHandle,
    false);

end;

function TadxOlFormsManager.GetNavigationPaneLayoutWindowHandle(
  AExplorerArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetNavigationPaneLayoutWindowHandle');
  Result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsNavigationPaneLayout then begin
        form := Items[index].GetFirstVisibleExplorerForms(AExplorerArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetNavigationPaneLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          TDebug.WriteLine('@@@ @@@ GetNavigationPaneLayoutWindowHandle VCL ' + IntToHex(result, 8));
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetNavigationPaneLayoutWindowHandle ' + E.Message), 'GetNavigationPaneLayoutWindowHandle');
  end;
end;

procedure TadxOlFormsManager.EndHookTransaction(WindowHandle: HWND);
begin
  if (WindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName + '.@@@ EndHookTransaction-');
    SendMessageFindWindows(GetDesktopWindow,
      ReceiverWindowHandle,
      GlobalsOl.ADXOlReceiverWindowCaption,
      '',
      WM_ADXENDTRANSACTION,
      trHookTransaction,
      WindowHandle,
      false);
    FHookTransactionWindowHandle := 0;
    TDebug.WriteLine(Log.AddinName + '.@@@ EndHookTransaction-');
  end
  else begin
    Log.AddMessage('@@@ SKIP EndHookTransaction');
  end;
end;

procedure TadxOlFormsManager.OnEndHookTransaction(WindowHandle: HWND);
begin
  if (FHookTransactionWindowHandle <> WindowHandle) then begin
    Log.AddWarning('@@@ FRefreshInspectorTabTransactionWindowHandle <> WindowHandle');
  end;
  FHookTransactionWindowHandle := 0;
  TDebug.WriteLine(Log.AddinName + '.@@@ OnEndHookTransaction-');
end;

procedure TadxOlFormsManager.OnStartHookTransaction(WindowHandle: HWND);
begin
  TDebug.WriteLine(Log.AddinName + '.@@@ OnStartHookTransaction+');
  FHookTransaction := trHookTransaction;
  FHookTransactionWindowHandle := WindowHandle;
end;

procedure TadxOlFormsManager.StartHookTransaction(WindowHandle: HWND);
begin
  if (WindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName + '.@@@ StartHookTransaction+');
    FHookTransactionWindowHandle := WindowHandle;
    SendMessageFindWindows(GetDesktopWindow,
      ReceiverWindowHandle,
      GlobalsOl.ADXOlReceiverWindowCaption,
      '',
      WM_ADXSTARTTRANSACTION,
      trHookTransaction,
      WindowHandle,
      false);
    TDebug.WriteLine(Log.AddinName + '.@@@ StartHookTransaction+');
  end
  else begin
    Log.AddMessage('@@@ SKIP StartHookTransaction');
  end;
end;

function TadxOlFormsManager.GetTodoBarPaneLayoutWindowHandle(
  AExplorerArgs: TObject): HWND;
var
  index: integer;
  form: TadxOlForm;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('GetTodoBarPaneLayoutWindowHandle');
  Result := 0;
  try
    for index := 0 to Items.Count - 1 do begin
      if Items[index].IsTodoBarLayout then begin
        form := Items[index].GetFirstVisibleExplorerForms(AExplorerArgs);
        if (form <> nil) then begin
          awp := form.GetAppWindowProperty();
          Log.AddMessage('GetTodoBarPaneLayoutWindowHandle ' + IntToStr(awp^.WindowHandle));
          result := awp^.WindowHandle;
          TDebug.WriteLine('@@@ @@@ GetTodoBarPaneLayoutWindowHandle VCL ' + IntToHex(result, 8));
          exit;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('GetTodoBarPaneLayoutWindowHandle ' + E.Message), 'GetTodoBarPaneLayoutWindowHandle');
  end;
end;

procedure TadxOlFormsManager.RaiseTodoBarHideEvent;
var
  args: TadxOlTodoBarHideEventArgs;
  event: TadxEventRaising;
begin
  if Assigned(OnADXTodoBarHide) then begin
    args := TadxOlTodoBarHideEventArgs.Create();
    try
      try
        event := TadxEventRaising.Create('OnADXTodoBarHide', [eoLockRegionState]);
        try
          OnADXTodoBarHide(Self, args);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'DoTodoBarHide');
        end;
      end;
    finally
      args.Free;
    end;
  end;
end;

procedure TadxOlFormsManager.RaiseTodoBarMinimizeEvent;
var
  args: TadxOlTodoBarMinimizeEventArgs;
  event: TadxEventRaising;
begin
    if Assigned(OnADXtodoBarMinimize) then begin
      args := TadxOlTodoBarMinimizeEventArgs.Create();
      try
        try
          event := TadxEventRaising.Create('OnADXTodoBarMinimize', [eoLockRegionState]);
          try
            OnADXTodoBarMinimize(Self, args);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'DoTodoBarMinimize');
          end;
        end;
      finally
        args.Free;
      end;
    end;
end;

procedure TadxOlFormsManager.RaiseTodoBarShowEvent;
var
  args: TadxOlTodoBarShowEventArgs;
  event: TadxEventRaising;
begin
    if Assigned(OnADXTodoBarShow) then begin
      args := TadxOlTodoBarShowEventArgs.Create();
      try
        try
          event := TadxEventRaising.Create('OnADXTodoBarShow', [eoLockRegionState]);
          try
            OnADXTodoBarShow(Self, args);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'DoTodoBarShow');
          end;
        end;
      finally
        args.Free;
      end;
    end;
end;

{$IFDEF DOCKEXPLORERLAYOUTS}
procedure TadxOlFormsManager.TryInitCtpFactory;
var
  addinModule: TInternalAdxCOMAddInModule;
begin
  if (DockLayoutIsSupported) then begin
    addinModule := TInternalAdxCOMAddInModule(COMAddInModule);
    if (FCTPFactory = nil) then begin
      FCTPFactory := addinModule.CTPFactory;
    end;
  end;
end;
{$ENDIF}

{$IFDEF DOCKEXPLORERLAYOUTS}
procedure TadxOlFormsManager.ShowCTP(window: IDispatch; CTPParam: TAdxCTPParams);
var
  Param: TAdxCTPParams;
begin
  Param:= CTPParam;
  FOutlookHook.AddCTP(FctpFactory, window, @Param);
end;
{$ENDIF}

{$IFDEF DOCKEXPLORERLAYOUTS}
procedure TadxOlFormsManager.HideAllCTP(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('TadxOlFormsManager.HideAllCTP');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  HideCTP(dpDockBottom, ExplorerArgs.ExplorerObj);
  HideCTP(dpDockLeft, ExplorerArgs.ExplorerObj);
  HideCTP(dpDockRight, ExplorerArgs.ExplorerObj);
  HideCTP(dpDockTop, ExplorerArgs.ExplorerObj);
end;
{$ENDIF}

{$IFDEF DOCKEXPLORERLAYOUTS}
procedure TadxOlFormsManager.HideCTP(DockPosition: integer;
  window: IDispatch);
begin
  Log.AddMessage('TadxOlFormsManager.HideCTP before');
  FOutlookHook.DeleteCTP(DockPosition, window);
  Log.AddMessage('TadxOlFormsManager.HideCTP after');
end;
{$ENDIF}

procedure TadxOlFormsManager.OnCTPFactoryAvailable(
  CTPFactory: ICTPFactory);
var
  LogEvent: TLogEvent;
begin
  LogEvent := TLogEvent.Create('OnCTPFactoryAvailable');
  try
    if (State <> nil) and (TadxOlFormsManagerState(State).WasAddinInitialize) then begin
{$IFDEF DOCKEXPLORERLAYOUTS}
      TryInitCtpFactory();
{$ENDIF}
      ProcessDockLayoutForAllExplorers();
    end;
  finally
    LogEvent.Free;
  end;
end;

procedure TadxOlFormsManager.ProcessDockLayoutForAllExplorers;
var
  ExplorerArgs: TadxOlExplorerArguments;
  ExplorersObj: Explorers;
  ExplorerObj: Explorer;
  ExplorerIndex, ExplorersCount: integer;
begin
  if FctpFactory = nil then begin
    exit;
  end;
  ExplorerArgs := nil;
  try
    ExplorersObj := TadxOlOutlookUtils(OutlookUtils).GetExplorers;
    ExplorersCount := ExplorersObj.Count;
    for ExplorerIndex := 1 to ExplorersCount do begin
      try
        ExplorerObj := ExplorersObj.Item(ExplorerIndex);
        ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccInitialize);
        ProcessDockLayout(ExplorerArgs);
      finally
        if (ExplorerArgs <> nil) then begin
          ExplorerArgs.Free;
        end;
        ExplorerObj := nil;
      end;
    end;
  finally
    ExplorersObj := nil;
  end;
end;

procedure TadxOlFormsManager.ProcessDockLayout(AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  ItemIndex: integer;
begin
  if (FctpFactory = nil) then begin
    exit;
  end;

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  for ItemIndex := 0 to Items.Count - 1 do begin
    if Items[ItemIndex].CorrespondExplorerContext(ExplorerArgs) then begin
      if (Items[ItemIndex].IsDockLayout) then begin
        DoShowExplorerForm(Items[ItemIndex], ExplorerArgs, 0);
      end;
    end;
  end;
end;

function TadxOlFormsManager.DockLayoutIsSupported: boolean;
begin
  result := (FOutlookVersion >= v2007);
end;

procedure TadxOlFormsManager.DoCTPVisibleChanged(param: TadxCTPVisibleParams);
var
  ExplorerWindowHandle: HWND;
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  if (FOutlookVersion >= v2010) then begin
    if (param.Visible) then begin
      ExplorerWindowHandle := GetAppHandle(param.appHandle);
      if (ExplorerWindowHandle <> 0) then begin

          GetRegisterExplorer(ExplorerWindowHandle, ExplorerObj);
          if (ExplorerObj <> nil) then begin
              ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccNewExplorer);
              ProcessDockLayout(ExplorerArgs);
          end;
      end;
    end
    else begin
      if (not IsWindowVisible(param.AppHandle)) then begin
        HideAllFormsInAllAddins(param.AppHandle);
      end;
    end;
  end;
end;

procedure TadxOlFormsManager.CancelIsHiddenByDeveloperFlagForExplorerForms(AExplorerArgs: TObject);
var
  itemIndex, formIndex: integer;
  form: TadxOlForm;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('CancelIsHiddenByDeveloperFlagForExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  try
    for itemIndex := 0 to Items.Count - 1 do begin
      for formIndex := 0 to Items[itemIndex].FormInstanceCount - 1 do begin
        form := Items[itemIndex].FormInstances[formIndex];
        if (form.IsExplorerForm)
          and (form.FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle)
          and form.IsHidenByDeveloper then begin
          form.FIsHidenByDeveloper := false;
        end;
      end;
    end;
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('CancelIsHiddenByDeveloperFlagForExplorerForms: ' + E.Message), 'CancelIsHiddenByDeveloperFlagForExplorerForms');
  end;
end;

function TadxOlFormsManager.GetDisableInCOMAddinsDialogWhenOutlookIsOpened: boolean;
begin
  result := TadxOlFormsManagerState(State).DisableInCOMAddinsDialogWhenOutlookIsOpened;
end;

procedure TadxOlFormsManager.DoHideBackStage(ExplorerWindowHandle: HWND);
var
  ExplorerObj: Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
TDebug.WriteLine('@@@@ DoHideBackStage + ' + Log.AddinName);
  if (FOutlookVersion >= v2010) then begin
    if (ExplorerWindowHandle <> 0) then begin
      GetRegisterExplorer(ExplorerWindowHandle, ExplorerObj);
      if (ExplorerObj <> nil) then begin
        ExplorerArgs := TadxOlExplorerArguments.Create(self, ExplorerObj, ccNewExplorer);
        ProcessDockLayout(ExplorerArgs);
      end;
    end;
  end;
TDebug.WriteLine('@@@@ DoHideBackStage - ' + Log.AddinName);
end;

procedure TadxOlFormsManager.DoShowBackStage(ExplorerWindowHandle: HWND);
begin
  //stub
end;

procedure TadxOlFormsManager.AddBackStageWatchObject(AHostHandle: HWND);
var
  watchObject: THostHandleWatchObject;
begin
  watchObject := TBackStageVisibleChangeWindowWatchObjectV2010.Create(AHostHandle, OutlookVersion);
  FOutlookHook.AddHandleHookWatchObject(watchObject);
end;

procedure TadxOlFormsManager.DoProcessInformAddinsToShowDockLayouts(
  DockPosition: integer);
var
  index, formIndex: integer;
  LogIndent: TLogIndent;
  item: TadxOlFormsCollectionItem;
  form: TadxOlForm;
  dockLayout: TadxOlExplorerLayout;
begin
  LogIndent := TLogIndent.Create('DoProcessInformAddinsToShowDockLayouts');
  try
    dockLayout := ConvertAdxDockPositionToADXOlExplorerLayout(DockPosition);
    try
      for index := 0 to Items.Count - 1 do begin
        item := Items[index];
        if (item.ExplorerLayout = dockLayout) then begin
          for formIndex := 0 to item.FormInstanceCount - 1 do begin
            form := item.FormInstances[formIndex];
            if ((form.IsExplorerForm) and (not form.Visible)) then begin
              form.Show;
            end;
          end;
        end;
      end;
    except
      on E:SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoProcessInformAddinsToShowDockLayouts: ' + E.Message), '');
    end;
  finally
    LogIndent.Free;
  end;
end;

procedure TadxOlFormsManager.AddInformToShowDockLayoutMessageToReceiver;
begin
  Log.AddMessage('AddInformToShowDockLayoutMessageToReceiver');
  if (not TadxReceiverWindow(FReceiverWindow).Exists(TInformToShowDockLayoutMessage)) then
    TadxReceiverWindow(FReceiverWindow).AddReceiverCustomMessage
      (TInformToShowDockLayoutMessage.Create(self.ReceiverWindowHandle, self));
end;

procedure TadxOlFormsManager.DoCloseAllFormsInDockLayoutsWhenDisableAddinInCOMAddinsDialog;
var
  index, formIndex: integer;
  LogIndent: TLogIndent;
  item: TadxOlFormsCollectionItem;
  form: TadxOlForm;
  windowHandle: HWND;
begin
  LogIndent := TLogIndent.Create('DoCloseAllFormsInDockLayoutsWhenDisableAddinInCOMAddinsDialog');
  try
    try
      for index := 0 to Items.Count - 1 do begin
        item := Items[index];
        if (item.IsDockLayout) then begin
          for formIndex := 0 to item.FormInstanceCount - 1 do begin
            form := item.FormInstances[formIndex];
            if ((form.IsExplorerForm) and (form.Visible)) then begin

              windowHandle := PAppWindowProperty(form.FAppWindowProperty)^.WindowHandle;
              form.HideByManager();
              HideAllFormsInAllAddins(windowHandle);

              DoInformAddinsToShowDockLayouts(ConvertADXOlExplorerLayoutToAdxDockPosition(item.ExplorerLayout));
            end;
          end;
        end;
      end;
    except
      on E:SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('DoCloseAllFormsInDockLayoutsWhenDisableAddinInCOMAddinsDialog: ' + E.Message), '');
    end;
  finally
    LogIndent.Free;
  end;
end;


function TadxOlFormsManager.ConvertADXOlExplorerLayoutToAdxDockPosition(
  Layout: TadxOlExplorerLayout): integer;
begin
  case Layout of
{$IFDEF DOCKEXPLORERLAYOUTS}
    elDockTop: result := dpDockTop;
    elDockBottom: result := dpDockBottom;
    elDockRight: result := dpDockRight;
    elDockLeft: result := dpDockLeft;
{$ENDIF}
    else raise SysUtils.Exception.Create('ConvertADXOlExplorerLayoutToAdxDockPosition: Illegal layout');
  end;
end;

procedure TadxOlFormsManager.DoInformAddinsToShowDockLayouts(
  DockPosition: integer);
begin
  Log.AddMessage('DoInformAddinsToShowDockLayouts');
  SendMessageFindWindows(GetDesktopWindow,
    ReceiverWindowHandle,
    GlobalsOl.ADXOlReceiverWindowCaption,
    '',
    WM_INFORMTOSHOWDOCKLAYOUT,
    DockPosition,
    0,
    false);
end;

function TadxOlFormsManager.ConvertAdxDockPositionToADXOlExplorerLayout(
  DockPosition: integer): TadxOlExplorerLayout;
begin
  case DockPosition of
{$IFDEF DOCKEXPLORERLAYOUTS}
    dpDockTop: result := elDockTop;
    dpDockBottom: result := elDockBottom;
    dpDockRight: result := elDockRight;
    dpDockLeft: result := elDockLeft;
{$ENDIF}
    else raise SysUtils.Exception.Create('ConvertAdxDockPositionToADXOlExplorerLayout: Illegal layout');
  end;

end;

procedure TadxOlFormsManager.OnRefreshFolder(ExplorerWindowHandle: HWND);
var
  Explorer: _Explorer;
  ExplorerArgs: TadxOlExplorerArguments;
begin
  GetRegisterExplorer(ExplorerWindowHandle, Explorer);
  if (Explorer <> nil) then begin
    ExplorerArgs := TadxOlExplorerArguments.Create(self, Explorer, ccFolderEvent);
    RefreshCurrentFolder(ExplorerArgs);
  end
  else begin
    Log.AddWarning('OnRefreshFolder: Explorer = nil');
  end;
end;

{ TadxOlFormsManagerState }

constructor TadxOlFormsManagerState.Create;
begin
  inherited;
  Restore;
end;

procedure TadxOlFormsManagerState.Restore;
begin
  isRefreshingFolder := false;
  isProcessAllFolders := false;
  isShutdown := false;
  WasWebViewLoad := false;
  isNewExplorerRunning := false;
  WasAddinInitialize := false;
  isAddinInitialize := false;
  BeforeViewSwitchJustNowOccured := false;
  isNotifyAddin := false;
  OutlookNewExplorerJustNowOccured := false;
  isExplorerCloseRunning := false;
  isAsyncWordEditorHideRunning := false;
  BeforeFolderSwitchJustNowOccuredAndNeedSkipViewSwitch := false;
  DisableInCOMAddinsDialogWhenOutlookIsOpened := false;
  isFolderSwitchExecuting := false;
  WasShutdownInApplicationQuit := false;
  isRefreshInspectorTabTransaction := false;
end;

{ TadxOlFormsCollectionItem }

constructor TadxOlFormsCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FRegionBorder := rbsSingle;
  FInspectorMode := [imRead, imCompose];
  FIsDragDropAllowed := false;
  FRestoreFromMinimizedState := false;
  FLockMode := false;
  FChangedPropertySet := 0;

  FOldExplorerMessageClasses := TStringList.Create;
  FNewExplorerMessageClasses := TStringList.Create;
  FCurrentExplorerMessageClasses := TStringList.Create;
  FExplorerMessageClasses := TStringList.Create;

  FOldInspectorMessageClasses := TStringList.Create;
  FNewInspectorMessageClasses := TStringList.Create;
  FCurrentInspectorMessageClasses := TStringList.Create;
  FInspectorMessageClasses := TStringList.Create;

  FOldFolderNames := TStringList.Create;
  FNewFolderNames := TStringList.Create;
  FCurrentFolderNames := TStringList.Create;
  FFolderNames := TStringList.Create;

  FFolders := TStringList.Create;

  FIsHiddenStateAllowed := true;
  FEnabled := true;
  FCached := csNewInstanceForEachFolder;
  FSplitter := sbStandard;
  GenerateNewItemID;
  FFormInstances := TadxOlFormsManagerList.Create(Self);
  //FInspectorItemTypes2 := [iitMailRead, iitMailCompose];
  FUseOfficeThemeForBackground:= false;
end;

destructor TadxOlFormsCollectionItem.Destroy;
begin
  FFolders.Free;

  FOldInspectorMessageClasses.Free;
  FNewInspectorMessageClasses.Free;
  FCurrentInspectorMessageClasses.Free;
  FInspectorMessageClasses.Free;

  FOldExplorerMessageClasses.Free;
  FNewExplorerMessageClasses.Free;
  FCurrentExplorerMessageClasses.Free;
  FExplorerMessageClasses.Free;

  FOldFolderNames.Free;
  FNewFolderNames.Free;
  FCurrentFolderNames.Free;
  FFolderNames.Free;

  if Assigned(FFormInstances) then
    TadxOlFormsManagerList(FFormInstances).Free;
  inherited;
end;

function TadxOlFormsCollectionItem.CorrespondExplorerContext(
  AExplorerArgs: TObject): boolean;
var
  ExplorerArgs: TadxOlExplorerArguments;
{$IFNDEF ADXXOL_TRIAL}
  FolderNamesIndex: integer;
  CorrespondFolder: boolean;
  CorrespondFolderDefaultItemType: boolean;
  CorrespondMessageClass: boolean;
  MessageClassesIndex: integer;
{$ENDIF}
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  result := false;
{$IFNDEF ADXXOL_TRIAL}
  CorrespondFolder := false;
  CorrespondFolderDefaultItemType := false;
  CorrespondMessageClass := false;

  if DefiniteExplorerProperties then begin

    if Globals.CompareADXStrings(FolderName, '*') then begin
      CorrespondFolder := true;
    end;

    if Globals.CompareADXStrings(Globals.WithoutBackSlash(Self.FolderName), ExplorerArgs.FullFolderName) then begin
      CorrespondFolder := true;
    end;

    if (FolderNames.Count > 0) then begin
      for FolderNamesIndex := 0 to FolderNames.Count - 1 do begin
        if Globals.CompareADXStrings(Globals.WithoutBackSlash(FolderNames[FolderNamesIndex]), ExplorerArgs.FullFolderName) then begin
          CorrespondFolder := true;
          break;
        end;
      end;
    end;

    if GlobalsOl.CheckOlExplorerItemTypes(ExplorerItemTypes, ExplorerArgs.FolderDefaultItemType) then begin
      CorrespondFolderDefaultItemType := true;
    end;

    if (ExplorerArgs.MessageClass <> EmptyStr) then begin

      if (Globals.CompareADXStrings(ExplorerMessageClass, ExplorerArgs.MessageClass)) then begin
        CorrespondMessageClass := true;
      end;

      if (ExplorerMessageClasses.Count > 0) then begin
        for MessageClassesIndex := 0  to ExplorerMessageClasses.Count - 1 do begin
          if (Globals.CompareADXStrings(ExplorerMessageClasses[MessageClassesIndex], ExplorerArgs.MessageClass)) then begin
            CorrespondMessageClass := true;
          end;
        end;
      end;

    end;


    result := CorrespondFolder or CorrespondFolderDefaultItemType or CorrespondMessageClass;
  end;
{$ELSE}
  result := false;
  if DefiniteExplorerProperties then begin
    result := Globals.CompareADXStrings(Globals.WithoutBackSlash(FormsManager.InboxFullFolderName), ExplorerArgs.FullFolderName);
  end;
{$ENDIF}
end;

procedure TadxOlFormsCollectionItem.GenerateNewItemID;
begin
  FItemID := StringToGUID(CreateClassID);
end;

function TadxOlFormsCollectionItem.DefiniteExplorerProperties: boolean;
var
  DefiniteFormClassNameProperty: boolean;
  DefiniteFolderNameProperties: boolean;
  DefiniteExplorerLayout: boolean;
  DefiniteExplorerItemTypes: boolean;
  DefiniteMessageClassProperties: boolean;
begin
  DefiniteFormClassNameProperty := (Trim(Self.FormClassName) <> EmptyStr);

  DefiniteFolderNameProperties :=
    (Self.FolderName <> EmptyStr) or (Self.FolderNames.Count > 0);
  DefiniteExplorerLayout := (FExplorerLayout <> elUnknown);
  DefiniteExplorerItemTypes := (Self.ExplorerItemTypes <> []);
  DefiniteMessageClassProperties :=
    (Self.ExplorerMessageClass <> EmptyStr)
    or (Self.ExplorerMessageClasses.Count > 0);

  result := Enabled
      and DefiniteFormClassNameProperty
      and DefiniteExplorerLayout
      and (DefiniteFolderNameProperties
        or DefiniteExplorerItemTypes
        or DefiniteMessageClassProperties);
end;

function TadxOlFormsCollectionItem.DefiniteInspectorProperties: boolean;
var
  DefiniteFormClassNameProperty: boolean;
  DefiniteInspectorLayout: boolean;
  DefiniteInspectorItemTypes: boolean;
  DefiniteMessageClassProperties: boolean;
  DefiniteFolderNameProperties: boolean;
begin
  DefiniteFormClassNameProperty := (Trim(Self.FormClassName) <> EmptyStr);
  DefiniteInspectorLayout := (Self.InspectorLayout <> ilUnknown);
  DefiniteInspectorItemTypes := (Self.InspectorItemTypes <> []);
  DefiniteFolderNameProperties :=
    (Self.FolderName <> EmptyStr) or (Self.FolderNames.Count > 0);
  DefiniteMessageClassProperties :=
    (Self.InspectorMessageClass <> EmptyStr)
    or (Self.InspectorMessageClasses.Count > 0);

  result := Enabled
      and DefiniteFormClassNameProperty
      and DefiniteInspectorLayout
      and (DefiniteInspectorItemTypes
           or DefiniteMessageClassProperties
           or DefiniteFolderNameProperties);
end;


function TadxOlFormsCollectionItem.IsWebViewPaneLayout: boolean;
begin
  result := (Self.FExplorerLayout = elWebViewPane);
end;

procedure TadxOlFormsCollectionItem.SetCached(
  const Value: TadxolCachingStrategy);
begin
  if (FCached <> Value) then begin
    FOldCached := FCached;
    FCurrentCached := Value;
    FNewCached := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpCached;
    end
    else begin
      DoChangeCached;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetEnabled(const Value: boolean);
begin
  if (FEnabled <> Value) then begin
    FOldEnabled := FEnabled;
    FCurrentEnabled := Value;
    FNewEnabled := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpEnabled;
    end
    else begin
      DoChangeEnabled;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetExplorerItemTypes(
  const Value: TadxolExplorerItemTypes);
begin
  if (FExplorerItemTypes <> Value) then begin
    FOldExplorerItemTypes := FExplorerItemTypes;
    FCurrentExplorerItemTypes := Value;
    FNewExplorerItemTypes := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpExplorerItemTypes;
    end
    else begin
      DoChangeExplorerItemTypes;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetExplorerLayout(
  const Value: TadxolExplorerLayout);
begin
  if (FExplorerLayout <> Value) then begin
    FOldExplorerLayout := FExplorerLayout;
    FCurrentExplorerLayout := Value;
    FNewExplorerLayout := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpExplorerLayout;
    end
    else begin
      DoChangeExplorerLayout;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetFolderName(const Value: string);
begin
  if (FFolderName <> Value) then begin
    FOldFolderName := FFolderName;
    FCurrentFolderName := Value;
    FNewFolderName := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpFolderName;
    end
    else begin
      DoChangeFolderName;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetFolderNames(const Value: TStrings);
begin
  if (FFolderNames.Text <> Value.Text) then begin
    FOldFolderNames.Assign(FFolderNames);
    FCurrentFolderNames.Assign(Value);
    FNewFolderNames.Assign(Value);
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpFolderNames;
    end
    else begin
      DoChangeFolderNames;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetFormClassName(
  const Value: TadxolFormClassName);
begin
  if (FFormClassName <> Value) then begin
    FOldFormClassName := FFormClassName;
    FCurrentFormClassName := Value;
    FNewFormClassName := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpFormClassName;
    end
    else begin
      DoChangeFormClassName;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetInspectorItemTypes(
  const Value: TadxolInspectorItemTypes);
begin
  if (FInspectorItemTypes <> Value) then begin
    FOldInspectorItemTypes := FInspectorItemTypes;
    FCurrentInspectorItemTypes := Value;
    FNewInspectorItemTypes := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorItemTypes;
    end
    else begin
      DoChangeInspectorItemTypes;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetInspectorLayout(
  const Value: TadxolInspectorLayout);
begin
  if (FInspectorLayout <> Value) then begin
    FOldInspectorLayout := FInspectorLayout;
    FCurrentInspectorLayout := Value;
    FNewInspectorLayout := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorLayout;
    end
    else begin
      DoChangeInspectorLayout;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetInspectorMessageClass(
  const Value: string);
begin
  if (FInspectorMessageClass <> Value) then begin
    FOldInspectorMessageClass := FInspectorMessageClass;
    FCurrentInspectorMessageClass := Value;
    FNewInspectorMessageClass := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorMessageClass;
    end
    else begin
      DoChangeInspectorMessageClass;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetInspectorMessageClasses(
  const Value: TStrings);
begin
  if (FInspectorMessageClasses.Text <> Value.Text) then begin
    FOldInspectorMessageClasses.Assign(FInspectorMessageClasses);
    FCurrentInspectorMessageClasses.Assign(Value);
    FNewInspectorMessageClasses.Assign(Value);
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorMessageClasses;
    end
    else begin
      DoChangeInspectorMessageClasses;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetInspectorMode(
  const Value: TadxolInspectorModes);
begin
  if (FInspectorMode <> Value) then begin
    FOldInspectorMode := FInspectorMode;
    FCurrentInspectorMode := Value;
    FNewInspectorMode := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorMode;
    end
    else begin
      DoChangeInspectorMode;
    end;
  end;

end;

procedure TadxOlFormsCollectionItem.SetSplitter(
  const Value: TadxolSplitterBehavior);
begin
  if (FSplitter <> Value) then begin
    FOldSplitter := FSplitter;
    FCurrentSplitter := Value;
    FNewSplitter := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpSplitter;
    end
    else begin
      DoChangeSplitter;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetUseOfficeThemeForBackground(const Value: boolean);
var
  form: TadxOlForm;
  i: integer;
begin
  if FUseOfficeThemeForBackground <> Value then begin
    FUseOfficeThemeForBackground := Value;
    for i:= 0 to FormInstanceCount- 1 do begin
      form:= FormInstances[i];
      if Assigned(form) then begin
        if FUseOfficeThemeForBackground then
          form.Color := form.GetBackColor()
        else
          form.Color := form.OldColor;
      end;
    end;
  end;
end;

function TadxOlFormsCollectionItem.CorrespondInspectorContext(
  AInspectorArgs: TObject): boolean;
{$IFNDEF ADXXOL_TRIAL}
var
  InspectorArgs: TadxOlInspectorArguments;
  MessageClassesIndex, FolderNamesIndex: integer;
  CorrespondInspectorItemType: boolean;
  CorrespondInspectorMode: boolean;
  CorrespondMessageClass: boolean;
  CorrespondFolderName: boolean;
{$ENDIF}
begin
{$IFNDEF ADXXOL_TRIAL}
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  result := false;
  CorrespondInspectorItemType := false;
  CorrespondMessageClass := false;
  CorrespondFolderName := false;

  if DefiniteInspectorProperties then begin

    if (InspectorArgs.ItemClass = -1) then begin
      result := false;
      exit;
    end;

    if GlobalsOl.CheckOlInspectorItemTypes(InspectorItemTypes, InspectorArgs.ItemClass) then begin
      CorrespondInspectorItemType := true;
    end;

    CorrespondInspectorMode := ((self.InspectorMode * [InspectorArgs.InspectorMode]) <> []);

    if (InspectorArgs.MessageClass <> EmptyStr) then begin

      if (Globals.CompareADXStrings(InspectorMessageClass, InspectorArgs.MessageClass)) then begin
        CorrespondMessageClass := true;
      end;

      if (InspectorMessageClasses.Count > 0) then begin
        for MessageClassesIndex := 0  to InspectorMessageClasses.Count - 1 do begin
          if (Globals.CompareADXStrings(InspectorMessageClasses[MessageClassesIndex], InspectorArgs.MessageClass)) then begin
            CorrespondMessageClass := true;
          end;
        end;
      end;

    end;

    if Globals.CompareADXStrings(FolderName, '*') then begin
      CorrespondFolderName := true;
    end;

    if (InspectorArgs.ParentFullFolderName <> '') then begin //O2007 Appointment open this occurrence
      if Globals.CompareADXStrings(Globals.WithoutBackSlash(Self.FolderName), InspectorArgs.ParentFullFolderName) then begin
        CorrespondFolderName := true;
      end;

      if (FolderNames.Count > 0) then begin
        for FolderNamesIndex := 0 to FolderNames.Count - 1 do begin
          if Globals.CompareADXStrings(Globals.WithoutBackSlash(FolderNames[FolderNamesIndex]), InspectorArgs.ParentFullFolderName) then begin
            CorrespondFolderName := true;
          end;
        end;
      end;
    end;


    result := (CorrespondInspectorItemType or CorrespondMessageClass or CorrespondFolderName) and CorrespondInspectorMode;
  end;
{$ELSE}
  result := false;
{$ENDIF}
end;

function TadxOlFormsCollectionItem.CreateForm: TadxOlForm;
var
  p: TPersistentClass;
begin
  try
    p := GetClass(FormClassName);
    result := TADXOlFormClass(p).CreateEx(FormsManager, self);
    if (result <> nil) then begin
      TadxOlFormsManagerList(FFormInstances).Add(result);
      result.UpdateColor(FormsManager.OutlookVersion);
    end;
  except
    on Ex:SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxOlFormsCollectionItem.CreateForm: ' + Ex.Message);
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetFirstVisibleExplorerForms(
  AExplorerArgs: TObject): TadxOlForm;
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
begin
  result := nil;
  Log.AddMessage('TadxOlFormsCollectionItem.GetFirstVisibleExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
          result := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]);
          exit;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetFirstVisibleInspectorForms(
  AInspectorArgs: TObject): TadxOlForm;
var
  InspectorArgs: TadxOlInspectorArguments;
  index: integer;
begin
  result := nil;
  Log.AddMessage('TadxOlFormsCollectionItem.GetFirstVisibleExplorerForms');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
          result := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]);
          exit;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetForm(Cancel: boolean): TadxOlForm;
begin
  Log.AddMessage('GetForm');
  result := nil;
  if not Cancel then begin
    result := CreateForm;
    if (result = nil) then begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlFormsCollectionItem.GetForm: A form has not been created.'), 'GetForm')
    end;
  end;
end;

function TadxOlFormsCollectionItem.FindExplorerForm(
  AExplorerArgs: TObject): TadxOlForm;
var
  ExplorerArgs: TadxOlExplorerArguments;
  FormIndex: integer;
  ItemFolderForm: TadxOlForm;
begin
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  result := nil;

  for FormIndex := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      ItemFolderForm := TADXOlForm(TadxOlFormsManagerList(FFormInstances)[FormIndex]);
      case Self.Cached of
        csNone: begin
          if ItemFolderForm.CheckOutlookWindowHandle(ExplorerArgs.ExplorerWindowHandle) then begin
              result := ItemFolderForm;
              exit;
          end;
        end;
        csNewInstanceForEachFolder: begin
          if Globals.CompareADXStrings(ItemFolderForm.FolderEntryID, ExplorerArgs.FolderEntryID)
              and ItemFolderForm.CheckOutlookWindowHandle(ExplorerArgs.ExplorerWindowHandle) then begin
              result := ItemFolderForm;
              exit;
          end;
        end;
        csOneInstanceForAllFolders: begin
          if ItemFolderForm.CheckOutlookWindowHandle(ExplorerArgs.ExplorerWindowHandle) then begin
              result := ItemFolderForm;
              exit;
          end;
        end;
      end;
    end;
  end;
end;

function TadxOlFormsCollectionItem.FindInspectorForm(
  AInspectorArgs: TObject): TadxOlForm;
var
  InspectorArgs: TadxOlInspectorArguments;
  FormIndex: integer;
  ItemFolderForm: TadxOlForm;
begin
  Log.AddMessage('FindInspectorForm');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

  result := nil;
  for FormIndex := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      ItemFolderForm := TADXOlForm(TadxOlFormsManagerList(FFormInstances)[FormIndex]);
      if ItemFolderForm.CheckOutlookWindowHandle(InspectorArgs.InspectorWindowHandle) then begin
        result := ItemFolderForm;
        exit;
      end;
    end;
  end;
end;


function TadxOlFormsCollectionItem.GetFormsManager: TadxolFormsManager;
begin
  try
  {$IFDEF ADX_VCL5}
      result := TadxOlFormsManager(TadxOlFormsCollection(Collection).GetOwner)
  {$ELSE}
      result := TadxOlFormsManager(Collection.Owner);
  {$ENDIF}
  except
    on Ex: SysUtils.Exception do begin
      raise SysUtils.Exception.Create('TadxOlFormsCollectionItem.FormsManager: ' + Ex.Message);
    end;
  end;
end;



function TadxOlFormsCollectionItem.GetExplorerAdxLayout: TAdxWindowLayout;
begin
  case ExplorerLayout of
{$IFDEF DOCKEXPLORERLAYOUTS}
    elDockTop: result := wlDockTop;
    elDockBottom: result := wlDockBottom;
    elDockRight: result := wlDockRight;
    elDockLeft: result := wlDockLeft;
{$ENDIF}
    elTopSubpane: result := wlTop;
    elBottomSubpane: result := wlBottom;
    elRightSubpane: result := wlRight;
    elLeftSubpane: result := wlLeft;
    elWebViewPane: result := wlClient;
    elBottomOutlookBar: result := wlBottom;
    elBottomNavigationPane: result := wlBottom;
    elBottomTodoBar: result := wlBottom;
    elTopReadingPane: result := wlTop;
    elBottomReadingPane: result := wlBottom;
    elLeftReadingPane: result := wlLeft;
    elRightReadingPane: result := wlRight;
{$IFDEF CLIENTLAYOUTS}
    elFolderView: result := wlClient;
    elReadingPane: result := wlClient;
{$ENDIF}
{$IFDEF READINGPANEHEADER}
    elReadingPaneHeader: result := wlRight;
{$ENDIF}
    else begin
      //ProcessADXXError('GetExplorerAdxLayout: The accordance not found.');
      raise SysUtils.Exception.Create('GetExplorerAdxLayout: The accordance not found.');
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetInspectorAdxLayout: TAdxWindowLayout;
begin
  case Self.InspectorLayout of
    ilLeftSubpane: result := wlLeft;
    ilRightSubpane: result := wlRight;
    ilTopSubpane: result := wlTop;
    ilBottomSubpane: result := wlBottom;
{$IFDEF CLIENTLAYOUTS}
    ilInspectorRegion: result := wlClient;
{$ENDIF}
{$IFDEF SUBSTINSPECTORREGION}
    ilCompleteReplacement: result := wlClient;
{$ENDIF}
    else begin
      //ProcessADXXError('GetInspectorAdxLayout: The accordance not found.');
      raise SysUtils.Exception.Create('GetInspectorAdxLayout: The accordance not found.');
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetExplorerAppWindowProperty(AExplorerArgs: TObject; AAppWindowProperty: Pointer; WindowHandle: HWND);
var
  ExplorerArgs: TadxOlExplorerArguments;
  ContextExplorerAdxItemType: TAdxItemType;
  AppWindowProperty :PAppWindowProperty;
  IsWebViewPane, IsEmptyWindow, ImpossibleEmbed: boolean;
  LastProcessedWindow: HWND;
begin
  Log.AddMessage('SetExplorerAppWindowProperty');
  AppWindowProperty := PAppWindowProperty(AAppWindowProperty);

  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  ContextExplorerAdxItemType := FormsManager.GetExplorerAdxItemType(self.ExplorerLayout,  AExplorerArgs);

  AppWindowProperty^.HostHandle := ExplorerArgs.ExplorerWindowHandle;
  AppWindowProperty^.ItemType := ContextExplorerAdxItemType;
  AppWindowProperty^.Layout := Self.GetExplorerAdxLayout();


  if (WindowHandle = 0) then begin
    if (IsDockLayout) then begin
      AppWindowProperty^.WindowHandle := TOfficeTaskPaneFinder.FindWindow(ord(FormsManager.OutlookVersion), ExplorerArgs.ExplorerWindowHandle, ord(appWindowProperty.Layout));
    end
    else begin
      AppWindowProperty^.WindowHandle := GetAppWindowHandle(Ord(FormsManager.OutlookVersion), ContextExplorerAdxItemType, ExplorerArgs.ExplorerWindowHandle);
    end;
  end
  else begin
    AppWindowProperty^.WindowHandle := WindowHandle;
  end;

  if Is2010 then begin  //v#99
    FindScrollbarWindow(ExplorerArgs.ExplorerWindowHandle, 0, '', 'NUIScrollbar', AppWindowProperty^.WindowHandle, self.FindVerticalScrollbar, LastProcessedWindow);
    if (LastProcessedWindow <> 0) then begin
      AppWindowProperty^.VerticalScrollbarHandle := LastProcessedWindow;
    end;
  end;

  if (AppWindowProperty^.WindowHandle <> 0) then begin
    IsWebViewPane := (ContextExplorerAdxItemType = stOlWebViewPane);
    IsEmptyWindow := TVisibleChangeWindowWatchObject.OutlookWindowEmptySize(
      AppWindowProperty^.WindowHandle, Ord(FormsManager.OutlookVersion), ContextExplorerAdxItemType);

    ImpossibleEmbed := ((not IsWebViewPane and IsEmptyWindow)
                        or (IsWebViewPane and not ExplorerArgs.AdxWebViewURLForFolder));

    if ImpossibleEmbed then begin
      AppWindowProperty^.WindowHandle := 0;
    end;
  end;

  AppWindowProperty^.Offset := GetOffset(Ord(FormsManager.OutlookVersion), ContextExplorerAdxItemType);
  AppWindowProperty^.ContainerType := 0;

  AppWindowProperty^.HostVersion  := OutlookVersion;
  AppWindowProperty^.Splitter := Ord(Self.Splitter);

  AppWindowProperty^.AlwaysShowHeader:= AlwaysShowHeader;
  AppWindowProperty^.CloseButton:= CloseButton;
  AppWindowProperty^.SplitterButton := IsHiddenStateAllowed;
  AppWindowProperty^.RegionBorder := self.RegionBorder;

end;

procedure TadxOlFormsCollectionItem.SetInspectorAppWindowProperty(
  AInspectorArgs: TObject; AppWindowProperty: Pointer);
var
  InspectorArgs: TadxOlInspectorArguments;
  ContextInspectorAdxItemType: TAdxItemType;
  adxCaption: TAdxCaption;
begin
  Log.AddMessage('SetInspectorAppWindowProperty');

  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);

  ContextInspectorAdxItemType := FormsManager.GetInspectorAdxItemType(InspectorArgs.InspectorItemType, ord(InspectorArgs.MailPostInspectorType));

  PAppWindowProperty(AppWindowProperty).HostHandle := InspectorArgs.InspectorWindowHandle;
  PAppWindowProperty(AppWindowProperty).ItemType := ContextInspectorAdxItemType;

  StrPCopy(adxCaption,  Self.ClassName + IntToStr(Self.Index));
  PAppWindowProperty(AppWindowProperty).Caption := adxCaption;
  PAppWindowProperty(AppWindowProperty).HostVersion  := OutlookVersion;
  PAppWindowProperty(AppWindowProperty).Splitter := Ord(Self.Splitter);
  if InspectorArgs.CodeContext = ccRefreshInspectorTab then begin
     PAppWindowProperty(AppWindowProperty)^.WindowHandle := InspectorArgs.WindowHandle;
  end
  else begin
    PAppWindowProperty(AppWindowProperty)^.WindowHandle := GetAppWindowHandle(Ord(FormsManager.OutlookVersion),
      ContextInspectorAdxItemType, InspectorArgs.InspectorWindowHandle);
  end;

  PAppWindowProperty(AppWindowProperty)^.Offset := GetOffset(Ord(FormsManager.OutlookVersion),
    ContextInspectorAdxItemType);
  PAppWindowProperty(AppWindowProperty)^.ContainerType := 0;
  PAppWindowProperty(AppWindowProperty)^.Layout := Self.InspectorAdxLayout;

  PAppWindowProperty(AppWindowProperty)^.AlwaysShowHeader := AlwaysShowHeader;
  PAppWindowProperty(AppWindowProperty)^.CloseButton := CloseButton;
  PAppWindowProperty(AppWindowProperty)^.SplitterButton := IsHiddenStateAllowed;
  PAppWindowProperty(AppWindowProperty)^.RegionBorder := Self.RegionBorder;
end;


function TadxOlFormsCollectionItem.OutlookVersion: integer;
begin
  result := Ord(FormsManager.OutlookVersion);
end;


procedure TadxOlFormsCollectionItem.DoChangeCached;
begin
  FCached := FNewCached;
  DeleteAllForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeEnabled;
begin
  FEnabled := FNewEnabled;
  DeleteAllForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeExplorerItemTypes;
begin
  FExplorerItemTypes := FNewExplorerItemTypes;
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeExplorerLayout;
var
  PriorExplorerLayout: TadxolExplorerLayout;
begin
  PriorExplorerLayout := FExplorerLayout;
  FExplorerLayout := FNewExplorerLayout;
  AddExplorerLayoutToExplorerAllowedDropRegions;
  if not (csDesigning in self.FormsManager.ComponentState) then begin
    ExplorerFormsHideShow;
    if (FormsManager.WasAddinInitialize) then begin
      SaveExplorerLayoutToRegistry();
    end;
    HideCTP(PriorExplorerLayout);
  end;
end;

procedure TadxOlFormsCollectionItem.DoChangeFolderName;
begin
  FFolderName := FNewFolderName;
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeFolderNames;
begin
  FFolderNames.Assign(FNewFolderNames);
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeFormClassName;
begin
  FFormClassName := FNewFormClassName;
  DeleteAllForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeInspectorItemTypes;
begin
  FInspectorItemTypes := FNewInspectorItemTypes;
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeInspectorLayout;
begin
  FInspectorLayout := FNewInspectorLayout;
  AddInspectorLayoutToInspectorAllowedDropRegions;
  if not (csDesigning in self.FormsManager.ComponentState) then begin
    InspectorFormsHideShow(ord(ciChangingItemLayout));
    if (FormsManager.WasAddinInitialize) then begin
      SaveInspectorLayoutToRegistry();
    end;
  end;

end;

procedure TadxOlFormsCollectionItem.DoChangeInspectorMessageClass;
begin
  FInspectorMessageClass := FNewInspectorMessageClass;
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeInspectorMessageClasses;
begin
  FInspectorMessageClasses.Assign(FNewInspectorMessageClasses);
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeInspectorMode;
begin
  FInspectorMode := FNewInspectorMode; 
end;

procedure TadxOlFormsCollectionItem.DoChangeSplitter;
begin
  FSplitter:= FNewSplitter;
end;

function TadxOlFormsCollectionItem.GetFormInstances(
  Index: Integer): TadxOlForm;
begin
  Result := TadxOlFormsManagerList(FFormInstances)[Index];
end;

function TadxOlFormsCollectionItem.GetFormInstanceCount: integer;
begin
  result := TadxOlFormsManagerList(FFormInstances).Count;
end;

procedure TadxOlFormsCollectionItem.HideExplorerForms(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  counter := 0;
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          inc(counter);
        end;
      end;
    end;
  end;
  if counter > 1 then begin
    //ProcessADXXError('HideExplorerForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(ExplorerArgs.ExplorerWindowHandle, 8) );
  end;
end;

procedure TadxOlFormsCollectionItem.HideInspectorForms(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideInspectorForms');
  try
    InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
    counter := 0;
    for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
      if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle then begin
          if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
            TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
            inc(counter);
          end;
        end;
      end;
    end;
    if counter > 1 then begin
      //ProcessADXXError('HideInspectorForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(InspectorArgs.InspectorWindowHandle, 8) );
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOlFormsCollectionItem.HideInspectorForms ' + E.Message);
      raise E;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.DeleteNotCachedExplorerForms(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteNotCachedExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);

  if (Self.Cached = csNone) then begin
    DeleteExplorerForms(ExplorerArgs.ExplorerWindowHandle);
  end;
end;

procedure TadxOlFormsCollectionItem.DeleteExplorerForms(
  ExplorerWindowHandle: HWND);
var
  Form: TADXOlForm;
  FormIndex: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteExplorerForms');
  Log.AddIndent();
  FormIndex := 0;
  while FormIndex < TadxOlFormsManagerList(FFormInstances).Count do begin
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      Form := TadxOlFormsManagerList(FFormInstances)[FormIndex];
      if (Form.FOutlookWindowHandle = ExplorerWindowHandle) then begin
        Log.AddMessage('Free');
        Form.Free;
        Log.AddMessage('Delete');
        TadxOlFormsManagerList(FFormInstances).Delete(FormIndex);
        Log.AddMessage('Dec');
        Dec(FormIndex);
      end;
    end;
    Inc(FormIndex);
  end;
  Log.RemoveIndent();
end;

procedure TadxOlFormsCollectionItem.DeleteInspectorForms(
  AInspectorArgs: TObject);
var
  InspectorArgs: TadxOlInspectorArguments;
  Form: TADXOlForm;
  FormIndex: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteInspectorForms');
  Log.AddIndent();
  try
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  FormIndex := 0;
  while FormIndex < TadxOlFormsManagerList(FFormInstances).Count do begin
    Log.AddMessage('FormIndex' + IntToStr(FormIndex) + ':' +IntToStr(TadxOlFormsManagerList(FFormInstances).Count));
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      Form := TadxOlFormsManagerList(FFormInstances)[FormIndex];
      Log.AddMessage('Compare Handles');
      if (Form.FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle) then begin


        Form.RaiseOnADXBeforeInspectorSubpaneClose(self.FormsManager);
        Log.AddMessage('Form Free');
        Form.Free;
        Log.AddMessage('Delete' + IntToStr(FormIndex));
        TadxOlFormsManagerList(FFormInstances).Delete(FormIndex);
        Dec(FormIndex);
        Log.AddMessage('After Delete');
      end;

    end;
    Inc(FormIndex);
  end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'DeleteInspectorForms')
    end;
  end;
  Log.RemoveIndent();
end;

procedure TadxOlFormsCollectionItem.DeleteNotVisibleForms;
var
  Form: TADXOlForm;
  FormIndex: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteNotVisibleForms');
  Log.AddIndent();
  FormIndex := 0;
  while FormIndex < TadxOlFormsManagerList(FFormInstances).Count do begin
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      Form := TadxOlFormsManagerList(FFormInstances)[FormIndex];
      if (not Form.Visible) then begin
        Log.AddMessage('Free');
        if (Form.IsInspectorForm) then begin
          Form.RaiseOnADXBeforeInspectorSubpaneClose(GetFormsManager);
        end;
        Form.Free;
        Log.AddMessage('Delete');
        TadxOlFormsManagerList(FFormInstances).Delete(FormIndex);
        Log.AddMessage('Dec');
        Dec(FormIndex);
      end;
    end;
    Inc(FormIndex);
  end;
  Log.RemoveIndent();
end;

procedure TadxOlFormsCollectionItem.DeleteAllForms;
var
  Form: TADXOlForm;
  FormIndex: integer;
  step: string;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteAllForms ' + IntToStr(TadxOlFormsManagerList(FFormInstances).Count));
  try
    Log.AddIndent();
    try
      FormIndex := 0;
      while FormIndex < TadxOlFormsManagerList(FFormInstances).Count do begin
        if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
          Form := TadxOlFormsManagerList(FFormInstances)[FormIndex];
          if (Form.IsInspectorForm) then begin
            Form.RaiseOnADXBeforeInspectorSubpaneClose(GetFormsManager);
          end;
          step := 'Free';
          Form.Free;
          Sleep(0);
          step := 'Delete';
          TadxOlFormsManagerList(FFormInstances).Delete(FormIndex);
          Dec(FormIndex);
          step := 'FormIndex = ' + IntToStr(FormIndex);
        end;
        Inc(FormIndex);
      end;
    finally
      Log.RemoveIndent();
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxOlFormsCollectionItem.DeleteAllForms: ' + step + ' ' + E.Message);
      raise E;
    end;
  end;
end;

function TadxOlFormsCollectionItem.IsSuperGridLayout: boolean;
begin
  result := (Self.ExplorerLayout = elTopSubpane)
    or (Self.ExplorerLayout = elBottomSubpane)
    or (Self.ExplorerLayout = elRightSubpane)
    or (Self.ExplorerLayout = elLeftSubpane)
{$IFDEF CLIENTLAYOUTS}
    or (Self.ExplorerLayout = elFolderView)
{$ENDIF}
    ;

end;

function TadxOlFormsCollectionItem.IsFolderViewClientLayout: boolean;
begin
  result := self.ExplorerLayout = elFolderView;
end;

function TadxOlFormsCollectionItem.IsInspectorRegionClientLayout: boolean;
begin
  result := (Self.InspectorLayout = ilInspectorRegion)
{$IFDEF SUBSTINSPECTORREGION}
  or (Self.InspectorLayout = ilCompleteReplacement)
{$ENDIF}
  ;
end;

function TadxOlFormsCollectionItem.IsNavigationPaneLayout: boolean;
begin
  result := (Self.ExplorerLayout = elBottomNavigationPane);
end;

function TadxOlFormsCollectionItem.IsOutlookBarLayout: boolean;
begin
  result := (Self.ExplorerLayout = elBottomOutlookBar);
end;

function TadxOlFormsCollectionItem.IsTodoBarLayout: boolean;
begin
  result := (Self.ExplorerLayout = elBottomTodoBar);
end;

procedure TadxOlFormsCollectionItem.ExplorerFormsHideShow;
var
  index: integer;
  ExplorerObj: Explorer;
  OutlookWindowHandle: HWND;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.ExplorerFormsHideShow');
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).IsExplorerForm
        and TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
        try
          ExplorerObj := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).ExplorerObj;
          OutlookWindowHandle := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle;
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          FormsManager.TryShowInExplorer(TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]), ExplorerObj, OutlookWindowHandle);
        finally
          ExplorerObj := nil;
        end;
      end;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.InspectorFormsHideShow(CauseInspectorFormShowing: integer);
var
  index: integer;
  InspectorObj: Inspector;
  OutlookWindowHandle: HWND;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.InspectorFormsHideShow');
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).IsInspectorForm
        and TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
        try
          InspectorObj := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).InspectorObj;
          OutlookWindowHandle := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle;
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          FormsManager.TryShowInInspector(TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]),
            InspectorObj, OutlookWindowHandle, CauseInspectorFormShowing);
        finally
          InspectorObj := nil;
        end;
      end;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.DeleteFormsForAbsentInspectors;
var
  Form: TADXOlForm;
  FormIndex: integer;
  DeleteForm: boolean;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.DeleteFormsForAbsentInspectors');
  Log.AddIndent();
  FormIndex := 0;
  while FormIndex < TadxOlFormsManagerList(FFormInstances).Count do begin
    if TadxOlFormsManagerList(FFormInstances)[FormIndex] <> nil then begin
      Form := TadxOlFormsManagerList(FFormInstances)[FormIndex];
      //Note, When not wordinspector is closed Window is Visible
      DeleteForm := (not IsWindowVisible(Form.FOutlookWindowHandle))
      and Form.IsInspectorForm;

      if DeleteForm then begin
        if (Form.IsInspectorForm) then begin
          Form.RaiseOnADXBeforeInspectorSubpaneClose(GetFormsManager);
        end;
        Log.AddMessage('Free');
        Form.Free;
        Log.AddMessage('Delete');
        TadxOlFormsManagerList(FFormInstances).Delete(FormIndex);
      end
      else begin
        Inc(FormIndex);
      end;
    end;
  end;
  Log.RemoveIndent();
end;

procedure TadxOlFormsCollectionItem.SetExplorerMessageClass(
  const Value: string);
begin
  if (FExplorerMessageClass <> Value) then begin
    FOldExplorerMessageClass := FExplorerMessageClass;
    FCurrentExplorerMessageClass := Value;
    FNewExplorerMessageClass := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpExplorerMessageClass;
    end
    else begin
      DoChangeExplorerMessageClass;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetExplorerMessageClasses(
  const Value: TStrings);
begin
  if (FExplorerMessageClasses.Text <> Value.Text) then begin
    FOldExplorerMessageClasses.Assign(FExplorerMessageClasses);
    FCurrentExplorerMessageClasses.Assign(Value);
    FNewExplorerMessageClasses.Assign(Value);
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpExplorerMessageClasses;
    end
    else begin
      DoChangeExplorerMessageClasses;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.DoChangeExplorerMessageClass;
begin
  FExplorerMessageClass := FNewExplorerMessageClass;
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.DoChangeExplorerMessageClasses;
begin
  FExplorerMessageClasses.Assign(FNewExplorerMessageClasses);
  DeleteNotVisibleForms;
end;

procedure TadxOlFormsCollectionItem.HideAllForms;
var
  index: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideAllForms');
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
        TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
      end;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.ChangeInspectorWindowHandle(OldHandle,
  NewHandle: HWND);
var
  counter: integer;
  index: integer;
begin
  counter := 0;
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if (formInstances[index] <> nil) then begin
      if (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = OldHandle) then begin
        TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).ChangeInspectorWindowHandle(NewHandle);
      end;
    end;
  end;

  if (counter > 1) then begin
    //ProcessADXXError('ChangeOutlookWindowHandle: Exists more one visible form for a TadxOlFormsCollectionItem');
  end;
end;

procedure TadxOlFormsCollectionItem.HideNotCorrespondedExplorerForms(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  counter: integer;
  form: TadxOlForm;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideNotCorrespondedExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  counter := 0;
  form := FindExplorerForm(AExplorerArgs);
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle then begin
        if (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible)
          and (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]) <> form) then begin
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          inc(counter);
        end;
      end;
    end;
  end;
  if counter > 1 then begin
    //ProcessADXXError('HideNotCorrespondedExplorerForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(ExplorerArgs.ExplorerWindowHandle, 8) );
  end;
end;

function TadxOlFormsCollectionItem.IsReadingPaneClientLayout: boolean;
begin
  result := self.ExplorerLayout = elReadingPane;
end;

function TadxOlFormsCollectionItem.IsReadingPaneLayout: boolean;
begin
  result := (Self.ExplorerLayout = elTopReadingPane)
    or (Self.ExplorerLayout = elBottomReadingPane)
    or (Self.ExplorerLayout = elRightReadingPane)
    or (Self.ExplorerLayout = elLeftReadingPane)
{$IFDEF CLIENTLAYOUTS}
    or (Self.ExplorerLayout = elReadingPane)
{$ENDIF}
    ;
end;

procedure TadxOlFormsCollectionItem.HideActiveExplorerForms(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideActiveExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  counter := 0;
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle then begin
        if (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible) and (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Active) then begin
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          inc(counter);
        end;
      end;
    end;
  end;
  if counter > 1 then begin
    //ProcessADXXError('HideExplorerForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(ExplorerArgs.ExplorerWindowHandle, 8) );
  end;
end;

procedure TadxOlFormsCollectionItem.HideNotActiveExplorerForms(
  AExplorerArgs: TObject);
var
  ExplorerArgs: TadxOlExplorerArguments;
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideNotActiveExplorerForms');
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  counter := 0;
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = ExplorerArgs.ExplorerWindowHandle then begin
        if (TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible) and (not TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Active) then begin
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          inc(counter);
        end;
      end;
    end;
  end;
  if counter > 1 then begin
    //ProcessADXXError('HideExplorerForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(ExplorerArgs.ExplorerWindowHandle, 8) );
  end;
end;

procedure TadxOlFormsCollectionItem.HideFormsByEmbededWindowHandle(
  EmbededWindowHandle: HWND);
var
  index: integer;
  awp: PAppWindowProperty;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideFormsByEmbededWindowHandle');
  Log.AddIndent;
  try
    for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
      if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
        awp := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).GetAppWindowProperty();
        if awp^.WindowHandle = EmbededWindowHandle then begin
          try
            if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
              TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
            end;
          except
            on E:SysUtils.Exception do begin
              Log.AddException(E.Message);
            end;
          end;
        end;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxOlFormsCollectionItem.ApplyTo(InspectorObj: Inspector);
begin
  FormsManager.ApplyToInspector(self, InspectorObj);
end;

procedure TadxOlFormsCollectionItem.ApplyTo(ExplorerObj: Explorer);
begin
  FormsManager.ApplyToExplorer(self, ExplorerObj);
end;

procedure TadxOlFormsCollectionItem.HideFormsByEmulateWindowHandle(
  EmulateWindowHandle: HWND);
var
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideFormsByEmulateWindowHandle');
  counter := 0;
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FEmulateWindowHandle = EmulateWindowHandle then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible then begin
          TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
          inc(counter);
        end;
      end;
    end;
  end;
  if counter > 1 then begin
    //ProcessADXXError('HideInspectorForms: Exists more one visible form for a TadxOlFormsCollectionItem' + IntToHex(InspectorArgs.InspectorWindowHandle, 8) );
  end;
end;

function TadxOlFormsCollectionItem.GetCurrentForm(
  EmbeddedFormState: TadxEmbeddedFormStates): TadxOlForm;
var
  ActiveWindowHandle: HWND;
  i: integer;
begin
  result := nil;
  ActiveWindowHandle := GetActiveWindow();
  for i := 0 to FormInstanceCount - 1 do begin
    if ((EmbeddedFormState = efsVisible) and FormInstances[i].Visible)
      or ((EmbeddedFormState = efsActive) and FormInstances[i].Active) then begin
      if ((ActiveWindowHandle = FormInstances[i].Handle)
        or (ActiveWindowHandle = FormInstances[i].CurrentOutlookWindowHandle)) then begin
        result := FormInstances[i];
        break;
      end;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SetAlwaysShowHeader(
  const Value: boolean);
begin
  FAlwaysShowHeader := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
  end;
  if (FDefaultRegionState = rsMinimized) then begin
    FAlwaysShowHeader := true;
  end;
  if (FCloseButton) then begin
    FAlwaysShowHeader := true;
  end;
end;

procedure TadxOlFormsCollectionItem.SetCloseButton(const Value: boolean);
begin
  if FCloseButton <> Value then begin
    FCloseButton := Value;
    if (FCloseButton) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.HideAllNotInjectedForms;
var
  index: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideAllNotInjectedForms');

  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Visible
        and (not TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Injected)  then begin
        TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideByManager;
      end;
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetDefaultRegionState: TadxRegionState;
begin
  if IsDockLayout then
    result := rsNormal
  else
    result := FDefaultRegionState;
end;

procedure TadxOlFormsCollectionItem.SetDefaultRegionState(
  const Value: TadxRegionState);
begin
  if (FDefaultRegionState <> value) then begin
    FDefaultRegionState := value;
    if (not IsHiddenStateAllowed) and (FDefaultRegionState = rsHidden) then begin
      self.FDefaultRegionState := rsMinimized;
    end;
    if (FDefaultRegionState = rsMinimized) then begin
      self.AlwaysShowHeader := true;
    end;
  end;
end;

(*
procedure TadxOlFormsCollectionItem.SetInspectorItemTypes2(
  const Value: TadxolInspectorItemTypes2);
begin
  if (FInspectorItemTypes2 <> Value) then begin
    FOldInspectorItemTypes2 := FInspectorItemTypes2;
    FCurrentInspectorItemTypes2 := Value;
    FNewInspectorItemTypes2 := Value;
    if FLockMode then begin
      FChangedPropertySet := FChangedPropertySet and chpInspectorItemTypes2;
    end
    else begin
      DoChangeInspectorItemTypes2;
    end;
  end;
end;
*)
(*
procedure TadxOlFormsCollectionItem.DoChangeInspectorItemTypes2;
begin
  FInspectorItemTypes2 := FNewInspectorItemTypes2;
  DeleteNotVisibleForms;
end;
*)
procedure TadxOlFormsCollectionItem.SetExplorerAllowedDropRegions(
  const Value: TadxolExplorerAllowedDropRegions);
begin
  FExplorerAllowedDropRegions := Value;
  AddExplorerLayoutToExplorerAllowedDropRegions();
end;

procedure TadxOlFormsCollectionItem.SetInspectorAllowedDropRegions(
  const Value: TadxolInspectorAllowedDropRegions);
begin
  FInspectorAllowedDropRegions := Value;
  AddInspectorLayoutToInspectorAllowedDropRegions(); 
end;

procedure TadxOlFormsCollectionItem.LoadExplorerLayoutFromRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.KeyExists(ItemRegistryKey) then begin
        Reg.OpenKey(ItemRegistryKey, false);
        if Reg.ValueExists('ExplorerLayout') then begin
          self.ExplorerLayout := TadxolExplorerLayout(Reg.ReadInteger('ExplorerLayout'));
        end;
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.LoadInspectorLayoutFromRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.KeyExists(ItemRegistryKey) then begin
        Reg.OpenKey(ItemRegistryKey, false);
        if Reg.ValueExists('InspectorLayout') then begin
          self.InspectorLayout := TadxolInspectorLayout(Reg.ReadInteger('InspectorLayout'));
        end;
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SaveExplorerLayoutToRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) and (self.ExplorerLayout <> elUnknown) then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if (Reg.OpenKey(ItemRegistryKey, true)) then begin
        Reg.WriteInteger('ExplorerLayout', ord(self.ExplorerLayout));
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.SaveInspectorLayoutToRegistry;
var
  Reg: TRegistry;
begin
  if (IsDragDropAllowed) and (self.InspectorLayout <> ilUnknown)  then begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if (Reg.OpenKey(ItemRegistryKey, true)) then begin
        Reg.WriteInteger('InspectorLayout', ord(self.InspectorLayout));
      end;
    finally
      Reg.CloseKey;
      Reg.Free;
    end;
  end;
end;

function TadxOlFormsCollectionItem.ItemRegistryKey: string;
begin
  result := FormsManager.AdxLocalRegistryKey + '\' + self.ClassName + IntToStr(self.Index);
end;

procedure TadxOlFormsCollectionItem.SetIsDragDropAllowed(
  const Value: boolean);
begin
  FIsDragDropAllowed := Value;
  if (FIsDragDropAllowed) then begin
    FAlwaysShowHeader := true;
    AddExplorerLayoutToExplorerAllowedDropRegions;
    AddInspectorLayoutToInspectorAllowedDropRegions;
  end;
end;

procedure TadxOlFormsCollectionItem.AddExplorerLayoutToExplorerAllowedDropRegions;
begin
  if (IsDragDropAllowed) then begin
     if (self.ExplorerLayout <> elUnknown) and (self.ExplorerLayout <> elWebViewPane) then begin
       self.FExplorerAllowedDropRegions := self.FExplorerAllowedDropRegions + [FormsManager.ConvertLayoutToAllowedDropRegion(self.ExplorerLayout)];
     end;
  end;
end;

procedure TadxOlFormsCollectionItem.AddInspectorLayoutToInspectorAllowedDropRegions;
begin
  if (IsDragDropAllowed) then begin
     if (self.InspectorLayout <> ilUnknown) then begin
       if (self.InspectorLayout <> ilCompleteReplacement) then begin
         self.FInspectorAllowedDropRegions := self.FInspectorAllowedDropRegions + [FormsManager.ConvertLayoutToAllowedDropRegion(self.InspectorLayout)];
       end;
     end;
  end;
end;

class function TadxOlFormsCollectionItem.ConvertExplorerLayoutToDesignString(
  ExplorerLayout: TadxolExplorerLayout): string;
begin
  case ExplorerLayout of
      elUnknown:              result := 'elUnknown';
      elTopSubpane:           result := 'elTopSubpane';
      elBottomSubpane:        result := 'elBottomSubpane';
      elRightSubpane:         result := 'elRightSubpane';
      elWebViewPane:          result := 'elWebViewPane';
      elLeftSubpane:          result := 'elLeftSubpane';
      elBottomOutlookBar:     result := 'elBottomOutlookBar';
      elBottomNavigationPane: result := 'elBottomNavigationPane';
      elBottomTodoBar:        result := 'elBottomTodoBar';
  		elTopReadingPane:       result := 'elTopReadingPane';
	  	elBottomReadingPane:    result := 'elBottomReadingPane';
		  elLeftReadingPane:      result := 'elLeftReadingPane';
		  elRightReadingPane:     result := 'elRightReadingPane';
      elFolderView:           result := 'elFolderView';
      elReadingPane:          result := 'elReadingPane';
{$IFDEF DOCKEXPLORERLAYOUTS}
      elDockTop:              result := 'elDockTop';
      elDockBottom:           result := 'elDockBottom';
      elDockRight:            result := 'elDockRight';
      elDockLeft:             result := 'elDockLeft';
{$ENDIF}
  end;
end;

class function TadxOlFormsCollectionItem.ConvertInspectorLayoutToDesignString(
  InspectorLayout: TadxolInspectorLayout): string;
begin
  case InspectorLayout of
      ilUnknown:             result := 'ilUnknown';
      ilBottomSubpane:       result := 'ilBottomSubpane';
      ilRightSubpane:        result := 'ilRightSubpane';
      ilLeftSubpane:         result := 'ilLeftSubpane';
      ilTopSubpane:          result := 'ilTopSubpane';
      ilInspectorRegion:     result := 'ilInspectorRegion';
  end;
end;

procedure TadxOlFormsCollectionItem.SetHideButtonVisible(const Value: boolean);
begin
  FIsHiddenStateAllowed := Value;
  if (not FIsHiddenStateAllowed) and (self.DefaultRegionState = rsHidden) then begin
    self.DefaultRegionState := rsMinimized;
  end;
end;

function TadxOlFormsCollectionItem.GetIs2010: boolean;
begin
  result := OutlookVersion = v2010;
end;

procedure TadxOlFormsCollectionItem.FindVerticalScrollbar(
  const OwnerWindow: HWND; const WindowHandle: HWND; var BreakProcess: boolean);
var
  OwnerWindowRect: TRect;
  WindowRect: TRect;
  IsSubclassedByAdx: boolean;
begin
  BreakProcess := false;
  if IsWindow(OwnerWindow) then begin
    GetWindowRect(OwnerWindow, OwnerWindowRect);
  end;
  if IsWindow(WindowHandle) then begin
    GetWindowRect(WindowHandle, WindowRect);
  end;

  IsSubclassedByAdx := SendMessage(WindowHandle, WM_ADXEXIST, 0, 0) = Globals.adxMessageResultValue;

  if IsSubclassedByAdx then begin

  end
  else begin
    if (OwnerWindowRect.Right = WindowRect.Left)
      and (OwnerWindowRect.Top = WindowRect.Top) then begin
      BreakProcess := true;
    end;
  end;
end;

function TadxOlFormsCollectionItem.GetActiveInspectorForm(
  AInspectorArgs: TObject): TadxOlForm;
var
  InspectorArgs: TadxOlInspectorArguments;
  index: integer;
begin
  result := nil;
  Log.AddMessage('TadxOlFormsCollectionItem.GetActiveInspectorForm');
  InspectorArgs := TadxOlInspectorArguments(AInspectorArgs);
  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).FOutlookWindowHandle = InspectorArgs.InspectorWindowHandle then begin
        if TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).Active then begin
          result := TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]);
          exit;
        end;
      end;
    end;
  end;
end;

procedure TadxOlFormsCollectionItem.ProvideDockTaskPane(AExplorerArgs: TObject);
{$IFDEF DOCKEXPLORERLAYOUTS}
var
  ExplorerArgs: TadxOlExplorerArguments;
  param: TAdxCTPParams;
{$ENDIF}
begin
  Log.AddMessage('TadxOlFormsCollectionItem.ProvideDockTaskPane');
{$IFDEF DOCKEXPLORERLAYOUTS}
  ExplorerArgs := TadxOlExplorerArguments(AExplorerArgs);
  param.pType:= 0;
  param.Size:= 0;
  param.Splitter:= Cardinal(self.Splitter);

  case ExplorerLayout of
    elDockBottom: param.Position:= dpDockBottom;
    elDockLeft: param.Position:= dpDockLeft;
    elDockRight: param.Position:= dpDockRight;
    elDockTop: param.Position:= dpDockTop;
  end;
  FormsManager.ShowCTP(ExplorerArgs.ExplorerObj, param);
{$ENDIF}
end;

function TadxOlFormsCollectionItem.IsDockLayout: boolean;
begin
{$IFDEF DOCKEXPLORERLAYOUTS}
  result := (Self.ExplorerLayout = elDockTop)
    or (Self.ExplorerLayout = elDockBottom)
    or (Self.ExplorerLayout = elDockRight)
    or (Self.ExplorerLayout = elDockLeft);
{$ELSE}
  result := false;
{$ENDIF}
end;

procedure TadxOlFormsCollectionItem.HideCTP(
  AExplorerLayout: TadxOlExplorerLayout);
var
  index: integer;
begin
  Log.AddMessage('TadxOlFormsCollectionItem.HideCTP');

  for index := 0 to TadxOlFormsManagerList(FFormInstances).Count - 1 do begin
    if TadxOlFormsManagerList(FFormInstances)[index] <> nil then begin
      TadxOlForm(TadxOlFormsManagerList(FFormInstances)[index]).HideCTP(AExplorerLayout);
    end;
  end;
end;

{ TadxOlFormsCollection }

function TadxOlFormsCollection.Add: TadxOlFormsCollectionItem;
begin
  Result := TadxOlFormsCollectionItem.Create(Self);
  if (csDesigning in TadxOlFormsManager(Owner).ComponentState) then begin
    Result.UseOfficeThemeForBackground := true;
  end;
end;

function TadxOlFormsCollection.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'FromClassName';
    2: Result := 'ExplorerLayout';
    3: Result := 'InspectorLayout';
  else
    Result := '';
  end;
end;

function TadxOlFormsCollection.GetAttrCount: Integer;
begin
  Result := 4;
end;

function TadxOlFormsCollection.GetItem(
  Index: Integer): TadxOlFormsCollectionItem;
begin
  Result := TadxOlFormsCollectionItem(inherited Items[Index]);
end;

function TadxOlFormsCollection.GetItemAttr(Index,
  ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].ClassName;
    1: Result := Items[ItemIndex].FormClassName;
    2: Result := TadxOlFormsCollectionItem.ConvertExplorerLayoutToDesignString(Items[ItemIndex].ExplorerLayout);
    3: Result := TadxOlFormsCollectionItem.ConvertInspectorLayoutToDesignString(Items[ItemIndex].InspectorLayout);
  else
    Result := '';
  end;
end;

{$IFDEF ADX_VCL5}
function TadxOlFormsCollection.Owner: TPersistent;
begin
  Result := GetOwner;
end;
{$ENDIF}

procedure TadxOlFormsCollection.SetItem(Index: Integer;
  Value: TadxOlFormsCollectionItem);
begin
  inherited Items[Index] := Value;
end;

{ TadxOlOutlookUtils }

function TadxOlOutlookUtils.CompareFolders(FolderObj1,
  FolderObj2: MAPIFolder): boolean;
var
  FolderEntryID1, FolderEntryID2: string;
begin
  if ((FolderObj1 = nil) or (FolderObj2 = nil)) then begin
   result := false;
   Exit;
  end;

  try
    FolderEntryID1 := FolderObj1.EntryID;
    FolderEntryID2 := FolderObj2.EntryID;
    if ((FolderEntryID1 = EmptyStr) or (FolderEntryID2 = EmptyStr)) then begin
      result := false;
      Exit;
    end;
  except
    result := false;
    exit;
  end;
  result := Globals.CompareADXStrings(FolderEntryID1, FolderEntryID2);
end;

constructor TadxOlOutlookUtils.Create(AOutlookAppObj: OutlookApplication);
begin
  Log.AddMessage('TadxOlOutlookUtils.Create');
  FOutlookVersion := vUnknown;
  FFolderGuid := StringToGUID('{00063006-0000-0000-C000-000000000046}');
  FOutlookAppObj := AOutlookAppObj;
end;

destructor TadxOlOutlookUtils.Destroy;
begin
  FOutlookAppObj := nil;
  inherited;
end;

function TadxOlOutlookUtils.GetExplorers: Explorers;
begin
  result := OutlookAppObj.Explorers;
end;

function TadxOlOutlookUtils.ExplorersCount: integer;
var
  expls: Explorers;
begin
  try
    try
      expls := OutlookAppObj.Explorers;
      result := expls.Count;
    finally
      expls := nil;
    end;
  except
    result := -1;
  end;
end;

function TadxOlOutlookUtils.FolderFromEntryID(EntryID: string): MAPIFolder;
var
  mapi: NameSpace;
begin
  try
    mapi := OutlookAppObj.GetNamespace('MAPI');
    result := mapi.GetFolderFromID(EntryID, EmptyParam);
  finally
    mapi := nil;
  end;
end;

function TadxOlOutlookUtils.GetActiveExplorer: Explorer;
begin
  result := OutlookAppObj.ActiveExplorer;
end;

function TadxOlOutlookUtils.GetActiveInspector: Inspector;
begin
        result := OutlookAppObj.ActiveInspector;
end;

function TadxOlOutlookUtils.GetCurrentFolder(
  ExplorerObj: Explorer): MAPIFolder;
begin
  result := ExplorerObj.CurrentFolder;
end;

function TadxOlOutlookUtils.GetDefaultFolder(
  DefaultFolder: TadxolDefaultFolders): MAPIFolder;
var
  mapi: NameSpace;
begin
  try
    try
      mapi := OutlookAppObj.GetNamespace('MAPI');
            result := mapi.GetDefaultFolder(DefaultFolder); //frequent exception
    finally
      mapi := nil;
    end;
  except
    result := nil;
  end;
end;

function TadxOlOutlookUtils.GetDefaultItemType(
  FolderObj: MAPIFolder): TOleEnum;
begin
  try
    result := FolderObj.DefaultItemType;
  except
    on E: SysUtils.Exception do begin
      result := 0;
    end;
  end;
end;

function TadxOlOutlookUtils.GetEntryID(FolderObj: MAPIFolder): string;
begin
  try
    result := FolderObj.EntryID;
  except
    on E: SysUtils.Exception do begin
      result := EmptyStr;
    end;
  end;
end;

function TadxOlOutlookUtils.GetEntryIDCurrentFolder(
  ExplorerObj: Explorer): string;
var
  CurrentFolder: MAPIFolder;
begin
  try
    CurrentFolder := Self.GetCurrentFolder(ExplorerObj);
    result := Self.GetEntryID(CurrentFolder);
  finally
    CurrentFolder := nil;
  end;
end;

function TadxOlOutlookUtils.GetExplorerByHandle(
  ExplorerWindowHandle: integer): Explorer;
var
  exps: Explorers;
  exp: Explorer;
  expsCount: integer;
  i, handle: integer;
begin
  try
    exps := OutlookAppObj.Explorers;
    expsCount := exps.Count;
    for i := 1 to expsCount do begin
      exp := exps.Item(i);
      if (exp <> nil) then begin
        handle := GetExplorerWindowHandle(exp);
        if (handle = ExplorerWindowHandle) then begin
          result := exp;
          exit;
        end else begin
          exp := nil;
        end;
      end;
    end;
  finally
    exps := nil;
  end;
end;

function TadxOlOutlookUtils.GetExplorerItemType(
  FolderObj: MAPIFolder): TadxolExplorerItemType;
var
  DefaultItemType: TOleEnum;
begin
  DefaultItemType := self.GetDefaultItemType(FolderObj);
  result := GlobalsOl.ConvertItemTypeToOlExplorerItemType(DefaultItemType);
end;

function TadxOlOutlookUtils.GetFolderItems(FolderObj: MAPIFolder): Items;
begin
  result := FolderObj.Items;
end;

function TadxOlOutlookUtils.GetFolderName(FolderObj: MAPIFolder): string;
begin
  result := FolderObj.Name;
end;

function TadxOlOutlookUtils.GetFullFolderName(
  FolderObj: MAPIFolder): string;
var
  folder: MAPIFolder;
  parent: IDispatch;
  entryID: WideString;
begin
  if (FolderObj = nil) then begin
    result := '';
    Exit;
  end;
  try
  try
    folder := nil;
    try
      FolderObj.QueryInterface(FolderGuid, folder);
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('GetFullFolderName FolderObj.QueryInterface: ' + E.Message);
        folder := nil;
        result := EmptyStr;
        exit;
      end;
    end;
    result := EmptyStr;
    while (folder <> nil) do begin

      entryID := folder.EntryID;
      result := folder.Name + '\' + result;
      try
        parent := folder.Parent;
      except
        parent := nil;
      end;

      folder := nil;
      if (parent <> nil) then begin
        parent.QueryInterface(FolderGuid, folder);
        parent := nil;
      end;
      if (folder <> nil) then begin
        if (folder.EntryID = entryID) then begin
          folder := nil;
        end;
      end;
    end;

    if (result <> EmptyStr) then
      Delete(result, Length(result), 1);
  finally
    folder := nil;
    parent := nil;
  end;
  except
    on E: SysUtils.Exception do begin
      Log.AddWarning('GetFullFolderName error: ' + E.Message);
      result := '';
    end;
  end;
end;

function TadxOlOutlookUtils.GetInspectorCurrentItem(
  InspectorObj: Inspector): IDispatch;
begin
  result := InspectorObj.CurrentItem;
end;

function TadxOlOutlookUtils.GetInspectorMessageClass(
  InspectorObj: Inspector): string;
var
  item: IDispatch;
begin
  try
    item := GetInspectorCurrentItem(InspectorObj);
    if (item <> nil) then begin
      result := GetItemMessageClass(item);
    end
    else begin
      Log.AddWarning('TadxOlOutlookUtils.GetInspectorMessageClass item = nil');
    end;
  finally
    item := nil;
  end;
end;

function TadxOlOutlookUtils.GetInspectorWordEditor(
  InspectorObj: Inspector): IDispatch;
begin
  FormsManagerSingleton.DoBeforeAccessProtectedObject;
  try
    result := InspectorObj.WordEditor;
  finally
    FormsManagerSingleton.DoAfterAccessProtectedObject; 
  end;
end;

function TadxOlOutlookUtils.GetItemMessageClass(
  ItemObj: IDispatch): string;
begin
  try
    result := OleVariant(ItemObj).MessageClass;
  except
    on E:SysUtils.Exception do begin
      Log.AddWarning('TadxOlOutlookUtils.GetItemMessageClass ' + E.Message);
    end;
  end;
end;

function TadxOlOutlookUtils.GetParentFolder(
  FolderObj: MAPIFolder): MAPIFolder;
var
  parent: IDispatch;
  //folderGuid: TGUID;
begin
  result := nil;
  try
    try
      parent := FolderObj.Parent;
    except
      parent := nil;
    end;
    if parent <> nil then begin
      parent.QueryInterface(FolderGuid, result);
    end
    else begin
      Log.AddMessage('GetParentFolder: parent = nil');
    end;
  finally
    parent := nil;
  end;
end;

function TadxOlOutlookUtils.GetWebViewOn(FolderObj: MAPIFolder): boolean;
begin
  try
    result := FolderObj.WebViewOn;
  except
    on E:SysUtils.Exception do begin
      result := false;
    end;
  end;
end;

function TadxOlOutlookUtils.GetWebViewURL(FolderObj: MAPIFolder): string;
begin

  try
    result := FolderObj.WebViewURL;
  except
    on E:SysUtils.Exception do begin
      result := EmptyStr;
    end;
  end;

end;

function TadxOlOutlookUtils.IsExplorerPaneVisible(ExplorerObj: Explorer;
  OLPane: TadxolPane): boolean;
begin
  result := ExplorerObj.IsPaneVisible(OLPane);
end;

function TadxOlOutlookUtils.IsOutboxFolder(FolderObj: MAPIFolder): boolean;
var
  OutboxFolderObj: MAPIFolder;
begin
  try
    result := false;
    if (FolderObj = nil) then exit;

    OutboxFolderObj := GetDefaultFolder(olFolderOutbox);
    if OutboxFolderObj = nil then exit;

    result := CompareFolders(FolderObj, OutboxFolderObj);
  finally
    OutboxFolderObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsPublicFolders(
  FolderObj: MAPIFolder): boolean;
var
  PublicFoldersAllPublicFoldersObj: MAPIFolder;
  PublicFoldersObj: MAPIFolder;
begin
  Log.AddMessage('IsPublicFolders');
  Log.AddIndent;
  try
    result := false;
    if (FolderObj = nil) then begin
      Log.AddWarning('FolderObj = nil');
      exit;
    end;

    PublicFoldersAllPublicFoldersObj := GetDefaultFolder(olPublicFoldersAllPublicFolders);
    if PublicFoldersAllPublicFoldersObj = nil then begin
      Log.AddWarning('PublicFoldersAllPublicFoldersObj = nil');
      exit;
    end;

    PublicFoldersObj := GetParentFolder(PublicFoldersAllPublicFoldersObj);
    if PublicFoldersObj = nil then begin
      Log.AddWarning('PublicFoldersObj = nil');
      exit;
    end;

    result := CompareFolders(FolderObj, PublicFoldersObj);
  finally
    Log.RemoveIndent;
    PublicFoldersAllPublicFoldersObj := nil;
    PublicFoldersObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsPublicFoldersAllPublicFolders(
  FolderObj: MAPIFolder): boolean;
var
  PublicFoldersAllPublicFoldersObj: MAPIFolder;
begin
  try
    result := false;
    if (FolderObj = nil) then exit;

    PublicFoldersAllPublicFoldersObj := GetDefaultFolder(olPublicFoldersAllPublicFolders);
    if PublicFoldersAllPublicFoldersObj = nil then exit;

    result := CompareFolders(FolderObj, PublicFoldersAllPublicFoldersObj);
  finally
    PublicFoldersAllPublicFoldersObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsUnderFolder(RootFolderObj,
  FolderObj: MAPIFolder): boolean;
var
  ParentFolderObj: MAPIFolder;
begin
  try
    result := false;
    if ((RootFolderObj = nil) or (FolderObj = nil)) then exit;

    if CompareFolders(FolderObj, RootFolderObj) then begin
      result := true;
      exit;
    end else begin
      ParentFolderObj := GetParentFolder(FolderObj);
      result := IsUnderFolder(RootFolderObj, ParentFolderObj);
      exit;
    end;
  finally
    ParentFolderObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsUnderOutbox(FolderObj: MAPIFolder): boolean;
var
  OutboxFolderObj: MAPIFolder;
begin
  try
    OutboxFolderObj := GetDefaultFolder(olFolderOutbox);
    result := IsUnderFolder(OutboxFolderObj, FolderObj);
  finally
    OutboxFolderObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsUnderPublicFolders(
  FolderObj: MAPIFolder): boolean;
var
  PublicFoldersAllPublicFoldersObj: MAPIFolder;
  PublicFoldersObj: MAPIFolder;
begin
  try
    result := false;
    PublicFoldersAllPublicFoldersObj := GetDefaultFolder(olPublicFoldersAllPublicFolders);
    if (PublicFoldersAllPublicFoldersObj = nil) then exit;
    PublicFoldersObj := GetParentFolder(PublicFoldersAllPublicFoldersObj);
    if (PublicFoldersObj = nil) then exit;
    result := IsUnderFolder(PublicFoldersObj, FolderObj);
  finally
    PublicFoldersAllPublicFoldersObj := nil;
    PublicFoldersObj := nil;
  end;
end;

function TadxOlOutlookUtils.IsWordMailInspector(
  InspectorObj: Inspector): boolean;
begin
  result := InspectorObj.IsWordMail;
end;

procedure TadxOlOutlookUtils.SetExplorerFolder(ExplorerObj: Explorer;
  FolderObj: MAPIFolder; OutlookVersion: TadxolOutlookVersion);
begin
  try
    if (OutlookVersion = v2000) then
      ExplorerObj.CurrentFolder := FolderObj;
    if (OutlookVersion = v2002) then
      ExplorerObj.CurrentFolder := FolderObj;
    if (OutlookVersion = v2003) then
      OleVariant(ExplorerObj).SelectFolder(FolderObj);
    if (OutlookVersion = v2007) then
      OleVariant(ExplorerObj).SelectFolder(FolderObj);
    if (OutlookVersion = v2010) then
      OleVariant(ExplorerObj).SelectFolder(FolderObj);
  except
    on E: SysUtils.Exception do begin
      Log.AddWarning('TadxOlOutlookUtils.SetExplorerFolder ' + E.Message);
    end;
  end;
end;

procedure TadxOlOutlookUtils.SetFolderGuid(const Value: TGUID);
begin
  FFolderGuid := Value;
end;

procedure TadxOlOutlookUtils.SetOutlookAppObj(
  const Value: OutlookApplication);
begin

end;

procedure TadxOlOutlookUtils.SetWebView(FolderObj: MAPIFolder;
  WebViewURL: string; WebViewOn: boolean);
var
  s: WideString;
  WebViewURLBeforeSetting: WideString;
  WebViewOnBeforeSetting: bool;
  WebViewURLAfterSetting: WideString;
  FolderName: WideString;

begin
  WebViewURLBeforeSetting := FolderObj.WebViewURL;
  WebViewOnBeforeSetting := FolderObj.WebViewOn;

  try
    s := '';
    Log.AddMessage('SetWebView');
    if (self.FOutlookVersion = v2000) and (WebViewURL = '') then begin
      Log.AddMessage('set WebViewUrl to the empty WideString');
      OleVariant(FolderObj).WebViewOn := WebViewOn;
      OleVariant(FolderObj).WebViewURL := s;
    end
    else begin
      FolderObj.WebViewURL := WebViewURL;
      FolderObj.WebViewOn := WebViewOn;
    end;

    WebViewURLAfterSetting := FolderObj.WebViewURL;

    if (WebViewURLAfterSetting <> WebViewURL) then begin
      if (self.FOutlookVersion = v2000) and (WebViewURL = '') then begin
        Log.AddMessage('set WebViewUrl to the empty WideString');
        OleVariant(FolderObj).WebViewOn := WebViewOnBeforeSetting;
        OleVariant(FolderObj).WebViewURL := WebViewURLBeforeSetting;
      end
      else begin
        FolderObj.WebViewURL := WebViewURLBeforeSetting;
        FolderObj.WebViewOn := WebViewOnBeforeSetting;
      end;
      FolderName := FolderObj.Name;
      Log.AddWarning('Impossible to set the WebViewURL property for the ''' + FolderName + ''' folder.');
    end;

    Log.AddMessage('WebViewURL: ' + WebViewURL);
    if (WebViewOn) then begin
      Log.AddMessage('WebViewOn: true');
    end
    else begin
      Log.AddMessage('WebViewOn: false');
    end;

  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxOlOutlookUtils.SetWebView: ' + E.Message);
    end;
  end;
end;

function TadxOlOutlookUtils.GetFolderMessageClass(
  FolderObj: MAPIFolder): string;
begin
  try
    result := FolderObj.DefaultMessageClass;
  except
    on E: SysUtils.Exception do begin
      result := EmptyStr;
    end;
  end;
end;

function TadxOlOutlookUtils.GetOutboxFolder: MAPIFolder;
begin
  result := self.GetDefaultFolder(olFolderOutbox);
end;

function TadxOlOutlookUtils.GetPublicFolders: MAPIFolder;
var
  PublicFoldersAllPublicFolders: MAPIFolder;
begin
  PublicFoldersAllPublicFolders := self.GetDefaultFolder(olPublicFoldersAllPublicFolders);
  try
    if (PublicFoldersAllPublicFolders <> nil) then begin
      result := self.GetParentFolder(PublicFoldersAllPublicFolders);
    end;
  finally
    PublicFoldersAllPublicFolders := nil;
  end;
end;

function TadxOlOutlookUtils.GetPublicFoldersAllPublicFolders: MAPIFolder;
begin
  result := self.GetDefaultFolder(olPublicFoldersAllPublicFolders);
end;

function TadxOlOutlookUtils.GetInboxFolder: MAPIFolder;
begin
  result := self.GetDefaultFolder(olFolderInbox);
end;

function TadxOlOutlookUtils.CheckPossibilityOpenFolder(
  FolderObj: MAPIFolder): boolean;
var
  EntryID: string;
begin
  Log.AddMessage('CheckPossibilityOpenFolder');
  Log.AddIndent;
  try
    EntryID := FolderObj.EntryID;
  except
    on E:SysUtils.Exception do begin
      Log.AddWarning(E.Message);
      EntryID := EmptyStr;
    end;
  end;
  result := EntryID <> EmptyStr;
  if not result then begin
    Log.AddWarning('Is not possible to open the folder.');
  end;
  Log.RemoveIndent;
end;

function TadxOlOutlookUtils.CompareFolders(Folder1Obj: MAPIFolder;
  Folder2EntryID: string): boolean;
var
  FolderEntryID1, FolderEntryID2: string;

begin
  if ((Folder1Obj = nil) or (Folder2EntryID = EmptyStr)) then begin
    result := false;
    exit;
  end;

  try
    FolderEntryID1 := Folder1Obj.EntryID;
    FolderEntryID2 := Folder2EntryID;
    if ((FolderEntryID1 = EmptyStr) or (FolderEntryID2 = EmptyStr)) then begin
      result := false;
      Exit;
    end;
  except
    result := false;
    exit;
  end;
  result := Globals.CompareADXStrings(FolderEntryID1, FolderEntryID2);
end;

{ Globals }


class function GlobalsOl.CheckOlExplorerItemTypes(
  ExplorerItemTypes: TadxolExplorerItemTypes; ItemType: TOleEnum): boolean;
begin
  result := false;
  if ItemType = 0 then result := expMailItem in ExplorerItemTypes;
  if ItemType = 1 then result := expAppointmentItem in ExplorerItemTypes;
  if ItemType = 2 then result := expContactItem in ExplorerItemTypes;
  if ItemType = 3 then result := expTaskItem in ExplorerItemTypes;
  if ItemType = 4 then result := expJournalItem in ExplorerItemTypes;
  if ItemType = 5 then result := expNoteItem in ExplorerItemTypes;
  if ItemType = 6 then result := expPostItem in ExplorerItemTypes;
  if ItemType = 7 then result := expDistributionListItem in ExplorerItemTypes;
end;

class function GlobalsOl.CheckOlInspectorItemTypes(
  items: TADXOlInspectorItemTypes; item: integer): boolean;
begin
  result := false;
  case item of
    $00000000: begin result := false; exit; end;
    $00000004: begin result := insRecipient in items; exit; end;
    $0000001A: begin result := insAppointment in items; exit; end;
    $00000035: begin result := insMeetingRequest in items; exit; end;
    $00000036: begin result := insMeetingCancellation in items; exit; end;
    $00000037: begin result := insMeetingResponseNegative in items; exit; end;
    $00000038: begin result := insMeetingResponsePositive in items; exit; end;
    $00000039: begin result := insMeetingResponseTentative in items; exit; end;
    $00000028: begin result := insContact in items; exit; end;
    $0000002A: begin result := insJournal in items; exit; end;
    $0000002B: begin result := insMail in items; exit; end;
    $0000002D: begin result := insPost in items; exit; end;
    $00000030: begin result := insTask in items; exit; end;
    $00000031: begin result := insTaskRequest in items; exit; end;
    $00000032: begin result := insTaskRequestUpdate in items; exit; end;
    $00000033: begin result := insTaskRequestAccept in items; exit; end;
    $00000034: begin result := insTaskRequestDecline in items; exit; end;
    $00000045: begin result := insDistributionList in items; exit; end;
    $0000002E: begin result := insReport in items; exit; end;
    $00000068: begin result := insSharing in items; exit; end;
    $000000B0: begin result := insMobile in items; exit; end;
  end;
end;

class function GlobalsOl.CheckSupportedOlInspectorItemTypes(
  items: TADXOlInspectorItemTypes; item: integer): boolean;
begin
  result := false;
  if (item = $00000000) then result := false;
  if (item = $00000004) then result := insRecipient in items;
  if (item = $0000001A) then result := insAppointment in items;
  if (item = $00000035) then result := insMeetingRequest in items;
  if (item = $00000036) then result := insMeetingCancellation in items;
  if (item = $00000037) then result := insMeetingResponseNegative in items;
  if (item = $00000038) then result := insMeetingResponsePositive in items;
  if (item = $00000039) then result := insMeetingResponseTentative in items;
  if (item = $00000028) then result := insContact in items;
  if (item = $0000002A) then result := insJournal in items;
  if (item = $0000002B) then result := insMail in items;
  if (item = $0000002D) then result := insPost in items;
  if (item = $00000030) then result := insTask in items;
  if (item = $00000031) then result := insTaskRequest in items;
  if (item = $00000032) then result := insTaskRequestUpdate in items;
  if (item = $00000033) then result := insTaskRequestAccept in items;
  if (item = $00000034) then result := insTaskRequestDecline in items;
  if (item = $00000045) then result := insDistributionList in items;
  if (item = $0000002E) then result := insReport in items;
  if (item = $00000068) then result := insSharing in items;
  if (item = $000000B0) then result := insMobile in items;
end;



class function GlobalsOl.ConvertItemClassToOlInspectorItemType(
  ItemClass: TOleEnum): TadxolInspectorItemType;
begin
  //if (ItemClass and $00000000) = $00000000 then raise SysUtils.Exception.Create('Globals.ConvertItemClassToOlInspectorItemType: ItemClass not found (1).');
  if ItemClass = $00000004 then begin result := insRecipient               ; exit; end;
  if ItemClass = $0000001A then begin result := insAppointment             ; exit; end;
  if ItemClass = $00000035 then begin result := insMeetingRequest          ; exit; end;
  if ItemClass = $00000036 then begin result := insMeetingCancellation     ; exit; end;
  if ItemClass = $00000037 then begin result := insMeetingResponseNegative ; exit; end;
  if ItemClass = $00000038 then begin result := insMeetingResponsePositive ; exit; end;
  if ItemClass = $00000039 then begin result := insMeetingResponseTentative; exit; end;
  if ItemClass = $00000028 then begin result := insContact                 ; exit; end;
  if ItemClass = $0000002A then begin result := insJournal                 ; exit; end;
  if ItemClass = $0000002B then begin result := insMail                    ; exit; end;
  if ItemClass = $0000002D then begin result := insPost                    ; exit; end;
  if ItemClass = $00000030 then begin result := insTask                    ; exit; end;
  if ItemClass = $00000031 then begin result := insTaskRequest             ; exit; end;
  if ItemClass = $00000032 then begin result := insTaskRequestUpdate       ; exit; end;
  if ItemClass = $00000033 then begin result := insTaskRequestAccept       ; exit; end;
  if ItemClass = $00000034 then begin result := insTaskRequestDecline      ; exit; end;
  if ItemClass = $00000045 then begin result := insDistributionList        ; exit; end;
  if ItemClass = $0000002E then begin result := insReport                  ; exit; end;
  if ItemClass = $00000068 then begin result := insSharing                 ; exit; end;
  if ItemClass = $000000B0 then begin result := insMobile                  ; exit; end;


  Log.AddWarning('ConvertItemClassToOlInspectorItemTypes: unknown result');
  result := TadxolInspectorItemType(-1);
end;

class function GlobalsOl.ConvertItemClassToString(ItemClass: TOleEnum): string;
begin
  if ItemClass = $00000004 then begin result := 'Recipient'; exit; end;
  if ItemClass = $0000001A then begin result := 'Appointment'; exit; end;
  if ItemClass = $00000035 then begin result := 'Meeting Request'; exit; end;
  if ItemClass = $00000036 then begin result := 'Meeting Cancellation'; exit; end;
  if ItemClass = $00000037 then begin result := 'Meeting Response'; exit; end;
  if ItemClass = $00000038 then begin result := 'Meeting Response'; exit; end;
  if ItemClass = $00000039 then begin result := 'Meeting Response'; exit; end;
  if ItemClass = $00000028 then begin result := 'Contact'; exit; end;
  if ItemClass = $0000002A then begin result := 'Journal'; exit; end;
  if ItemClass = $0000002B then begin result := 'Mail'; exit; end;
  if ItemClass = $0000002D then begin result := 'Post'; exit; end;
  if ItemClass = $00000030 then begin result := 'Task'; exit; end;
  if ItemClass = $00000031 then begin result := 'Task Request'; exit; end;
  if ItemClass = $00000032 then begin result := 'Task Request'; exit; end;
  if ItemClass = $00000033 then begin result := 'Task Request'; exit; end;
  if ItemClass = $00000034 then begin result := 'Task Request'; exit; end;
  if ItemClass = $00000045 then begin result := 'Distribution List'; exit; end;
  if ItemClass = $0000002E then begin result := 'Report'; exit; end;
  if ItemClass = $00000068 then begin result := 'Sharing'; exit; end;
  if ItemClass = $000000B0 then begin result := 'Mobile'; exit; end;

  Log.AddWarning('ConvertItemClassToString: unknown result');

end;

class function GlobalsOl.ConvertItemTypeToOlExplorerItemType(
  ItemType: TOleEnum): TadxolExplorerItemType;
begin
  if ItemType = 0 then begin
    result := expMailItem;
    exit;
  end;
  if ItemType = 1 then begin
    result := expAppointmentItem;
    exit;
  end;
  if ItemType = 2 then begin
    result := expContactItem;
    exit;
  end;
  if ItemType = 3 then begin
    result := expTaskItem;
    exit;
  end;
  if ItemType = 4 then begin
    result := expJournalItem;
    exit;
  end;
  if ItemType = 5 then begin
    result := expNoteItem;
    exit;
  end;
  if ItemType = 6 then begin
    result := expPostItem;
    exit;
  end;
  if ItemType = 7 then begin
    result := expDistributionListItem;
    exit;
  end;
  raise SysUtils.Exception.Create('ConvertItemTypeToOlExplorerItemType: ItemType has not defined.');
end;

class procedure GlobalsOl.DeleteHTMLFile(HTMLFileFullName: string);
begin
  if (FileExists(HTMLFileFullName)) then
    {$IFDEF UNICODE}
    DeleteFile(PChar(HTMLFileFullName));
    {$ELSE}
    DeleteFile(PAnsiChar(HTMLFileFullName));
    {$ENDIF}
end;

class procedure GlobalsOl.DeleteHTMLRootDir(COMAddinModule: TadxCOMAddInModule);
var
  dir: string;
begin
  if not Assigned(COMAddinModule) then exit;
  dir := GlobalsOl.HTMLFileRootDir(COMAddinModule);
  if DirectoryExists(dir) then begin
    try
      RmDir(dir);
    except
      on E: SysUtils.Exception do
        TDebug.WriteLine('DeleteHTMLRootDir:' + E.Message);
    end;
  end;
end;

class function GlobalsOl.GeneralHTMLFileName: string;
begin
  result := 'ADXOlFormGeneral.html';
end;

class function GlobalsOl.GetAppDataFolder: string;
var
  P: array[0..MAX_PATH-1] of Char;
  Res: Bool;
begin
  res := SHGetSpecialFolderPath{SHGetFolderPath}(0, P, CSIDL_APPDATA {CSIDL_LOCAL_APPDATA}, false);
  if (res) then
    result := P
  else
    result := Globals.GetTempDir;
end;


class function GlobalsOl.GetLongFileName(Path: string): string;
var
  I : Integer;
  SearchHandle : THandle;
  FindData : TWin32FindData;
  IsBackSlash : Boolean;
begin
  Path := ExpandFileName(Path);
  Result := ExtractFileDrive(Path);
  I := Length(Result);
  if Length(Path) <= I then  // only drive
    Exit;
  if Path[I + 1] = '\' then
  begin
    Result := Result + '\';
    Inc(I);
  end;
  Delete(Path, 1, I);
  repeat
    I := Pos('\', Path);
    IsBackSlash := I > 0;
    if not IsBackSlash then
      I := Length(Path) + 1;
    SearchHandle := FindFirstFile(PChar(Result + Copy(Path, 1,
      I - 1)), FindData);
    if SearchHandle <> INVALID_HANDLE_VALUE then
    begin
      try
        Result := Result + FindData.cFileName;
        if IsBackSlash then
          Result := Result + '\';
      finally
        Windows.FindClose(SearchHandle);
      end;
    end
    else
    begin
      Result := Result + Path;
      Break;
    end;
    Delete(Path, 1, I);
  until Length(Path) = 0;
end;



class function GlobalsOl.GetTempDir: WideString;
var
  Buffer: array[0..1023] of Char;
begin
  {$IFDEF UNICODE}
  SetString(Result, Buffer, GetTempPath(Length(Buffer) - 1, Buffer));
  {$ELSE}
  SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
  {$ENDIF}
end;


class function GlobalsOl.HTMLFullFileName(
  COMAddinModule: TadxCOMAddInModule): string;
{$IFDEF WithADXHTMLFile}
var
  AddinName: string;
{$ENDIF}
begin
{$IFDEF WithADXHTMLFile}
 result := EmptyStr;
 if not Assigned(COMAddinModule) then exit;
  AddinName := COMAddinModule.AddinName;

  result := Globals.GetAppDataFolder + '\' + AddinName +  '\' + AddinName + 'D' + '.html';
{$ELSE}
  result := Globals.GetTempDir + 'AddinExpress\' + GlobalsOl.GeneralHTMLFileName;
  result := GetLongFileName(result);
{$ENDIF}
end;


class function GlobalsOl.HTMLFileRootDir(
  COMAddinModule: TadxCOMAddInModule): string;
var
  AddinName: string;
begin
  result := '';
  if not Assigned(COMAddinModule) then exit;
  AddinName := COMAddinModule.AddinName;

  result := Globals.GetAppDataFolder + '\' + AddinName;
end;


class procedure GlobalsOl.SaveHTMLFile(HTMLFileFullName: string);
begin
  {$IFDEF WEBVIEWOFF}exit;{$ENDIF}
  Globals.WriteStringsToFile(HTMLFileFullName, GlobalsOl.TemplateHTML);
end;

class function GlobalsOl.TemplateHTML: string;
begin
{$IFDEF WithADXHTMLFile}
  result :=
    '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN"> ' +
    '<html><head>' +
    '</head><body marginwidth=0 marginheight=0 style="margin: 0px;">' +
    '<object classid="clsid:' +
    '82CBCD87-D77A-4D45-AADC-3B0723DB8504' +
    '" id="Container" width="100%" height="100%" VIEWASTEXT>' +
    '"</object></body></html>';
{$ELSE}
  result :=
    '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN"> ' +
    '<html><head>' +
    '</head><body marginwidth=0 marginheight=0 style="margin: 0px;">' +
    '</body></html>';
{$ENDIF}
end;

class function GlobalsOl.WithoutBackSlash(s: string): string;
begin
  result := s;
  if result = EmptyStr then
    exit;
  if result[Length(result)] = '\' then begin
    Delete(result, Length(result), 1);
  end;
  if result[1] = '\' then begin
    Delete(result, 1, 1);
  end;
end;


class function GlobalsOl.WM_ADD_ALIEN_FORM: string;
begin
  result := 'WM_ADD_ALIEN_FORM';
end;

class function GlobalsOl.WM_DELETE_PROC_IN_HOOKS_CHAIN: string;
begin
  result := 'WM_DELETE_PROC_IN_HOOKS_CHAIN';
end;

class function GlobalsOl.WM_RESIZE_TAB: string;
begin
  result := 'WM_RESIZE_TAB';
end;

class function GlobalsOl.WM_ADX_CLOSE_READINGPANE_SERVICE_FORM: string;
begin
  result := 'WM_ADX_CLOSE_READINGPANE_SERVICE_FORM';
end;

class function GlobalsOl.WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR: string;
begin
  result := 'WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR';
end;

class function GlobalsOl.WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM: string;
begin
  result := 'WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM';
end;

class function GlobalsOl.WM_ADX_SEARCH_WINDOW_ENGINE_HIDE: string;
begin
  result := 'WM_ADX_SEARCH_WINDOW_ENGINE_HIDE';
end;

class function GlobalsOl.WM_ADX_SEARCH_WINDOW_ENGINE_SHOW: string;
begin
  result := 'WM_ADX_SEARCH_WINDOW_ENGINE_SHOW';
end;

class function GlobalsOl.WM_ADX_WINDOW_ENGINE_HIDE: string;
begin
  result := 'WM_ADX_WINDOW_ENGINE_HIDE';
end;

class function GlobalsOl.WM_ADX_WORDEDITOR_HIDE: string;
begin
  result := 'WM_ADX_WORDEDITOR_HIDE';
end;

class function GlobalsOl.WM_ADXCLOSEAPPWINDOW: string;
begin
  result := 'WM_ADXCLOSEAPPWINDOW';
end;

class function GlobalsOl.WM_ADXDELETEEMULATEWINDOW: string;
begin
  result := 'WM_ADXDELETEEMULATEWINDOW';
end;


class function GlobalsOl.WM_ADXWMIPOSCHANGE: string;
begin
  result := 'WM_ADXWMIPOSCHANGE';
end;

class function GlobalsOl.AdxWMIEmulateWindowCaption: string;
begin
  result := 'AdxWMIEmulateWindow';
end;

class function GlobalsOl.FoldersForExcludingFromUseWebViewPaneLayout: string;
begin
  result := 'FoldersForExcludingFromUseWebViewPaneLayout';
end;

class function GlobalsOl.FolderSyncIssues: string;
begin
  result := 'FolderSyncIssues';
end;

class function GlobalsOl.PublicFolders: string;
begin
  result := 'PublicFolders';
end;

class function GlobalsOl.PublicFoldersAllPublicFolders: string;
begin
  result := 'PublicFoldersAllPublicFolders';
end;

class function GlobalsOl.WM_ADXREMOVECONTROLLEDRESIZEWINDOW: string;
begin
  result := 'WM_REMOVECONTROLLEDRESIZEWINDOW';
end;

class function GlobalsOl.ADXOlReceiverWindowCaption: string;
begin
  result := 'ADXOlReceiverWindowCaption';
end;


class function GlobalsOl.DefaultMutexName: string;
begin
  result := 'ADXVCLMessageMutex';
end;

class function GlobalsOl.DefaultClearWatchObjectsMutex: string;
begin
  result := 'ADXVCLClearWatchObjectsMutex';
end;

function TadxOlOutlookUtils.InspectorsCount: integer;
var
  insps: Inspectors;
begin
  try
    try
      insps := OutlookAppObj.Inspectors;
      result := insps.Count;
    finally
      insps := nil;
    end;
  except
    result := -1;
  end;
end;

function TadxOlOutlookUtils.IsWordPostInspector(
  InspectorObj: Inspector): boolean;
begin
  result := (InspectorObj.EditorType = olEditorWord);
end;

{ TadxOlInspector }

constructor TadxOlInspector.Create(AOwner: TadxOlFormsManager; const AInspectorObj: Inspector; AInspectorWindowHandle: HWND; AIsWordMail: boolean);
begin
  Log.AddMessage('TadxOlInspector.Create ' + IntToHex(AInspectorWindowHandle, 8));
  try

  FWordInspectorPreviewWatchObject := nil;
  FControlResizeWindowWatchObject := nil;

  FIsWordMail := AIsWordMail;
  FEmulateWindow := nil;
  FEmulateWindowHandle := 0;
  FWindowHandle := 0;
  FOwner := AOwner;
  FInspectorWindowHandle := AInspectorWindowHandle;
  TDebug.WriteLine('TadxOlInspector.Create: AInspectorObjAddress ' + intToStr(cardinal(AInspectorObj)));

  FInspectorObj := AInspectorObj;
  TDebug.WriteLine('TadxOlInspector.Create: FInspectorObjAddress ' + intToStr(cardinal(FInspectorObj)));

  if (AInspectorWindowHandle = 0) then begin
    SetWindowHandle(FOwner.OutlookVersion);
  end;

{$IFDEF CLIENTLAYOUTS}
  FInspectorRegionServiceForm := TadxOlForm.CreateInstanceForClientLayout;
  FInspectorRegionServiceForm.FFormsManager := AOwner;
  SetWordMailInspectorFlag(AIsWordMail);
{$ENDIF}
  except
    on E: SysUtils.Exception do begin
      Log.AddException(E.Message);
      raise E;
    end;
  end;
end;

procedure TadxOlInspector.CreateEmulateWindow(AWindowHandle: HWND);
begin
  TDebug.WriteLine('VCL CreateEmulateWindow');

  if (FEmulateWindow = nil) then begin
    TDebug.WriteLine('@@@ *** *** Creating AdxWMIEmulateWindow VCL');
    Log.AddMessage('Creating AdxWMIEmulateWindow');
    FEmulateWindow := TAdxWMIEmulateWindow.CreateEx(AWindowHandle);

    CreateWindowForResizeControlToWatchEngine(AWindowHandle);

    FEmulateWindowHandle := FEmulateWindow.Handle;
  end
  else begin
    FEmulateWindowHandle := FEmulateWindow.Handle; 
  end;
end;


destructor TadxOlInspector.Destroy;
var
  awp: PAppWindowProperty;
  WindowHandle: HWND;
begin
{$IFDEF CLIENTLAYOUTS}
  if (FInspectorRegionServiceForm <> nil) then begin
    awp := FInspectorRegionServiceForm.GetAppWindowProperty;
    //Don't use this condition. See the Container.HideAllForms
    //if (FInspectorRegionServiceForm.Injected) then begin
      WindowHandle := awp.WindowHandle;
      FInspectorRegionServiceForm.HideByManager;
      if (not FIsWordMail) then begin
        if (TadxOlFormsManagerState(FOwner.State).DisableInCOMAddinsDialogWhenOutlookIsOpened) then begin
          DoCloseInspectorRegionServiceFormForNotWordInspector(WindowHandle);
        end
        else begin
          Log.AddMessage('Skip DoCloseInspectorRegionServiceFormForNotWordInspector');
        end;
      end;
    //end;
    FInspectorRegionServiceForm.Free;
    FInspectorRegionServiceForm := nil;
  end;
{$ENDIF}
  DeleteEmulateWindow;
  FInspectorObj := nil;
  inherited;
end;

procedure TadxOlInspector.SetWindowHandle(Version: TadxolOutlookVersion);
begin
  Log.AddMessage('SetWindowHandle');
  if (FInspectorObj <> nil) then begin
    FInspectorWindowHandle := GetNewInspectorWindowHandle(FInspectorObj, Version, false);
  end;
end;

procedure TadxOlInspector.SetWordMailInspectorFlag(value: boolean);
begin
  FIsWordMailInspector := value;
end;

procedure TadxOlInspector.DeleteEmulateWindow;
var
  DesktopWindow: HWND;
begin
  Log.AddMessage('TadxOlInspector.DeleteEmulateWindow');
  Log.AddIndent;
  try
    ClearEmulateDataWordInspectorPreviewWatchObject();

    if ((FControlResizeWindowWatchObject <> nil)
        and (not FControlResizeWindowWatchObject.StopWatch)) then begin
        Log.AddMessage('FControlResizeWindowWatchObject.StopWatch := true');
        FControlResizeWindowWatchObject.StopWatch := true;
        FControlResizeWindowWatchObject := nil;
    end;

    FEmulateWindowHandle := 0;
    FWindowHandle := 0;

    if (HasEmulateWindow) then begin
      Log.AddMessage('HasEmulateWindow');
      FEmulateWindow.FResponse := false;
      Log.AddMessage('Before GetDesktopWindow');
      DesktopWindow := GetDesktopWindow();
      Log.AddMessage('GetDesktopWindow' + IntToHex(DesktopWindow, 8));
      Log.AddMessage('ReceiverWindowHandle' + IntToHex(FOwner.ReceiverWindowHandle, 8));
      try
        Log.AddMessage('FEmulateWindow.Handle' + IntToHex(FEmulateWindow.Handle, 8));
        SendMessageFindWindows(DesktopWindow, FOwner.ReceiverWindowHandle, GlobalsOl.ADXOlReceiverWindowCaption, '', WM_ADXDELETEEMULATEWINDOW, FEmulateWindow.Handle, 0, false);
        { TODO : This line raises an exception in some cases when working with WordMailInspector. Case 1021}
      except
        on e: SysUtils.Exception do Log.AddException('Try access FEmulateWindow.Handle: ' + e.Message);
      end;
      try
        FEmulateWindow.Free;
      except
        on e: SysUtils.Exception do Log.AddException('Call FEmulateWindow.Free: ' + e.Message);
      end;
      FEmulateWindow := nil;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxOlInspector.ClearEmulateDataWordInspectorPreviewWatchObject;
begin
  Log.AddMessage('TadxOlInspector.ClearEmulateDataWordInspectorPreviewWatchObject');
  if (FWordInspectorPreviewWatchObject <> nil) then begin
    FWordInspectorPreviewWatchObject.ClearEmulateData();
  end;
end;

procedure TadxOlInspector.StoppingWatchObject(watchObject: TWatchObject);
begin
  if (FWordInspectorPreviewWatchObject = watchObject) then begin
    FWordInspectorPreviewWatchObject := nil;
  end;
  if (FControlResizeWindowWatchObject = watchObject) then begin
    FControlResizeWindowWatchObject := nil;
  end;
end;

procedure TadxOlInspector.UpdateInspectorWindowHandle(
  AInspectorWindowHandle: HWND);
begin
  FInspectorWindowHandle := AInspectorWindowHandle;

  if (FWordInspectorPreviewWatchObject <> nil) then begin
      FWordInspectorPreviewWatchObject.UpdateHostHandle(inspectorWindowHandle);
  end
  else begin
      CreateWordInspectorPreviewWatchObject();
  end;


  if (FControlResizeWindowWatchObject <> nil) then begin
    FControlResizeWindowWatchObject.UpdateHostHandle(inspectorWindowHandle);
  end;

end;

function TadxOlInspector.HasEmulateWindow: boolean;
begin
  Log.AddMessage('HasEmulateWindow');
  result := (FEmulateWindow <> nil);
end;

procedure TadxOlInspector.HideInspectorRegionServiceForm;
begin
  if (InspectorRegionServiceForm <> nil) then begin
    InspectorRegionServiceForm.HideByManager;
  end;
end;

procedure TadxOlInspector.CreateWordInspectorPreviewWatchObject;
var
  WordInspectorPreviewWatchObject: TObject;
begin
  if (FWordInspectorPreviewWatchObject = nil) then begin
    try
      WordInspectorPreviewWatchObject := FOwner.AddWindowForWordInspectorPreviewSearching(FInspectorWindowHandle);
      if (WordInspectorPreviewWatchObject <> nil) then begin
        FWordInspectorPreviewWatchObject := WordInspectorPreviewWatchObject as TWordInspectorPreviewWatchObject;
        FWordInspectorPreviewWatchObject.StoppingWatchObject := StoppingWatchObject;
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddException('CreateWordInspectorPreviewWatchObject: ' + E.Message);
      end;
    end;
  end;
end;

procedure TadxOlInspector.SetExistsEmulateWindowHandleFromOtherAddin(
  AWindowHandle: HWND);
begin
  FEmulateWindowHandle := FindEmulateWindow(FInspectorWindowHandle,
    GlobalsOl.AdxWMIEmulateWindowCaption,  EmptyStr, FWindowHandle);
end;

procedure TadxOlInspector.DoEmulateWindowHandle(AWindowHandle: HWND);
begin
  try
    if (FEmulateWindowHandle = 0) then begin
        FWindowHandle := AWindowHandle;
        SetExistsEmulateWindowHandleFromOtherAddin(AWindowHandle);

        if (FEmulateWindowHandle = 0) then begin
            CreateEmulateWindow(AWindowHandle);
        end;

        if ((FOwner.OutlookVersion = v2002)
          or (FOwner.OutlookVersion = v2003)) then begin
            if (FWordInspectorPreviewWatchObject = nil) then begin
                CreateWordInspectorPreviewWatchObject();
            end;
            SetEmulateDataToWordInspectorPreviewWatchObject(AWindowHandle);
        end;
    end;

{$IFNDEF PREVIEWDELEMULATEWINDOW}
    CreateWindowForResizeControlToWatchEngine(AWindowHandle);
{$ENDIF}


  except
    on E: SysUtils.Exception do begin
      Log.AddException('TadxOlInspector.DoEmulateWindowHandle ' + E.Message);
    end;
  end;
end;

procedure TadxOlInspector.SetControlResizeWindowWatchObjectPause(
  const Value: boolean);
begin
  if (FControlResizeWindowWatchObject <> nil) then begin
    FControlResizeWindowWatchObject.Pause := value;
  end;
end;

procedure TadxOlInspector.CreateWindowForResizeControlToWatchEngine(
  AWindowHandle: HWND);
var
  ControlResizeWindowWatchObject: TObject;
begin
  if (FControlResizeWindowWatchObject = nil) and (FEmulateWindow <> nil) then begin
    try
      ControlResizeWindowWatchObject := FOwner.AddWindowForResizeControlToWatchEngine(InspectorWindowHandle, FEmulateWindow.Handle, AWindowHandle);
      if (ControlResizeWindowWatchObject <> nil) then begin
        FControlResizeWindowWatchObject := ControlResizeWindowWatchObject as TControlResizeWindowWatchObject;
        FControlResizeWindowWatchObject.StoppingWatchObject := StoppingWatchObject;
      end;
    except
      on E:SysUtils.Exception do begin
        Log.AddException('CreateWindowForResizeControlToWatchEngine: ' + E.Message);
      end;
    end;
  end;
end;

procedure TadxOlInspector.SetEmulateDataToWordInspectorPreviewWatchObject(
  AWindowHandle: HWND);
begin
  if (FWordInspectorPreviewWatchObject <> nil) then begin
    FWordInspectorPreviewWatchObject.SetEmulateData(FEmulateWindowHandle, AWindowHandle);
  end;
end;

procedure TadxOlInspector.DoCloseInspectorRegionServiceFormForNotWordInspector(
  WindowHandle: HWND);
begin
  if (FOwner <> nil) then begin
    SendMessageFindWindows(GetDesktopWindow,
      FOwner.ReceiverWindowHandle,
      GlobalsOl.ADXOlReceiverWindowCaption,
      '',
      WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR,
      InspectorWindowHandle,
      WindowHandle,
      false);
  end
  else begin
    Log.AddWarning('DoCloseInspectorRegionServiceFormForNotWordInspector: FormsManager == null');
  end;
end;

{ TadxOlExplorer }

constructor TadxOlExplorer.Create(AOwner: TadxOlFormsManager; AExplorerObj: Explorer; AExplorerWindowHandle: HWND);
begin
  FOwner := AOwner;
  FExplorerObj := AExplorerObj;
  FExplorerWindowHandle := AExplorerWindowHandle;
{$IFDEF CLIENTLAYOUTS}
  FFolderViewServiceForm := TadxOlForm.CreateInstanceForClientLayout;
  FFolderViewServiceForm.FFormsManager := AOwner;
  FFolderViewServiceForm.Caption := 'FolderViewServiceForm';
  FReadingPaneServiceForm := TadxOlForm.CreateInstanceForClientLayout;
  FReadingPaneServiceForm.FFormsManager := AOwner;
  FReadingPaneServiceForm.Caption := 'ReadingPaneServiceForm';
{$ENDIF}
end;


destructor TadxOlExplorer.Destroy;
var
  WindowHandle: HWND;
  awp: PAppWindowProperty;
begin
{$IFDEF CLIENTLAYOUTS}
  if (FFolderViewServiceForm <> nil) then begin
    if (FFolderViewServiceForm.Visible) then begin
      awp := FFolderViewServiceForm.GetAppWindowProperty;
      WindowHandle := awp.WindowHandle;
      FFolderViewServiceForm.HideByManager;
      DoCloseFolderViewServiceForm(WindowHandle);
    end;

    FFolderViewServiceForm.Free;
    FFolderViewServiceForm := nil;
  end;
  if (FReadingPaneServiceForm <> nil) then begin
    if (FReadingPaneServiceForm.Visible) then begin
      awp := FReadingPaneServiceForm.GetAppWindowProperty;
      WindowHandle := awp.WindowHandle;
      FReadingPaneServiceForm.HideByManager;
      DoCloseReadingPaneServiceForm(WindowHandle);
    end;

    FReadingPaneServiceForm.Free;
    FReadingPaneServiceForm := nil;

  end;
{$ENDIF}
  FExplorerObj := nil;
  inherited;
end;


procedure TadxOlExplorer.DoCloseFolderViewServiceForm(WindowHandle: HWND);
begin
  if (FOwner <> nil) then begin
    SendMessageFindWindows(GetDesktopWindow,
      FOwner.ReceiverWindowHandle,
      GlobalsOl.ADXOlReceiverWindowCaption,
      '',
      WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM,
      ExplorerWindowHandle,
      WindowHandle,
      false);
  end
  else begin
    Log.AddWarning('DoCloseFolderViewServiceForm: FormsManager == null');
  end;
end;

procedure TadxOlExplorer.DoCloseReadingPaneServiceForm(WindowHandle: HWND);
begin
  if (FOwner <> nil) then begin
    SendMessageFindWindows(GetDesktopWindow,
      FOwner.ReceiverWindowHandle,
      GlobalsOl.ADXOlReceiverWindowCaption,
      '',
      WM_ADX_CLOSE_READINGPANE_SERVICE_FORM,
      ExplorerWindowHandle,
      WindowHandle,
      false);
  end
  else begin
    Log.AddWarning('DoCloseReadingPaneServiceForm: FormsManager == null');
  end;
end;

{ TadxOlFormsManagerList }

procedure TadxOlFormsManagerList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TObject(Items[i]).Free;
  inherited;
end;

function TadxOlFormsManagerList.CountClasses(AClassType: TClass): integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Count - 1 do begin
    if TObject(Items[i]) is AClassType then
      Inc(result);
  end;
end;

constructor TadxOlFormsManagerList.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TadxOlFormsManagerList.Destroy;
begin
  FOwner := nil;
  inherited;
end;

{ TDebug }

class procedure TDebug.WriteLine(s: string);
begin
  //{$IFDEF UNICODE}
  //OutputDebugString(PWideChar(s)); { TODO : !!! TDebug.WriteLine }
  //{$ELSE}
  //OutputDebugString(PAnsiChar(s));
  //{$ENDIF}
end;

{ TFindWindow }

constructor TFindWindow.Create(startHandle, findHandle: HWND;
  findClassName, findTitle: PChar);
begin
  inherited Create;
  FHandles := TList.Create;
  FHandles.Clear;
  FindInfo.StartHandle := startHandle;
  FindInfo.FindHandle := findHandle;
  FindInfo.ClassName := findClassName;
  FindInfo.Title := findTitle;
  GetWindows(startHandle);
end;

var
  A: TFindWindow;

  function OnWindowEnum(handle, PFindInfo:HWND):BOOL; stdcall;
  var
    fInfo: ^ADXFINDWINDOW;
    wClassName, wTitle: widestring;
  begin
    Result := true;
    fInfo := Pointer(PFindInfo);
    if handle = fInfo^.FindHandle then begin
      A.FHandles.Add(Pointer(handle));
      Result := false;
    end
    else begin
      if ((fInfo^.ClassName <> nil) and (fInfo^.Title <> nil)) then begin
        wClassName := GetWindowClassName(handle);
        wTitle := GetWindowText_(handle);
        if ((fInfo^.ClassName = wClassName) and (fInfo^.Title = wTitle)) then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
      if ((fInfo^.ClassName <> nil) and (fInfo^.Title = nil)) then begin
        wClassName := GetWindowClassName(handle);
        if fInfo^.ClassName = wClassName then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
      if ((fInfo^.ClassName = nil) and (fInfo^.Title <> nil)) then begin
        wTitle := GetWindowText_(handle);
        if fInfo^.Title = wTitle then begin
          A.FHandles.Add(Pointer(handle));
        end;
      end;
    end;
    if Result then begin
      if fInfo^.StartHandle = 0 then begin
        EnumChildWindows(handle, @OnWindowEnum, Longint(PFindInfo));
        if (fInfo^.FindHandle <> 0) then Result := false;
      end;
    end;
  end;

  function WindowsEnumProc( wnd: HWND; lparam: LParam):BOOL; stdcall;
  begin
    if OnWindowEnum(wnd, lparam) then Result := true
    else Result := false;
  end;

  function TZOrderHelper_EnumWindowsProc( wnd: HWND; lparam: LParam):BOOL; stdcall;
  begin
    result := false;
    if (WorkingZOrderHelperInstance <> nil) then begin
      result := WorkingZOrderHelperInstance.DoEnumWindowsProc(wnd, lparam);
    end;
  end;


destructor TFindWindow.Destroy;
begin
  if Assigned(FHandles) then begin
    FHandles.Free;
    FHandles := nil;
  end;
  inherited;
end;

procedure TFindWindow.GetWindows(parentHwnd:HWND);
  begin
    A := self;
    if parentHwnd = 0 then begin
      EnumWindows(@WindowsEnumProc, Longint(@FindInfo));
    end
    else begin
      EnumChildWindows(parentHwnd, @WindowsEnumProc, Longint(@FindInfo));
    end;
    A := nil;
end;

var
  ChildHandle: HWND;

function SetChildHandle(handle, lParam:HWND):BOOL; stdcall;
begin
  ChildHandle := handle;
  Result := false;
end;

{$ifdef D_2}
var
  Win32Platform: Integer = 0;
  Win32MajorVersion: Integer = 0;
  Win32MinorVersion: Integer = 0;
  Win32BuildNumber: Integer = 0;

procedure InitPlatformId;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
    with OSVersionInfo do
    begin
      Win32Platform := dwPlatformId;
      Win32MajorVersion := dwMajorVersion;
      Win32MinorVersion := dwMinorVersion;
      Win32BuildNumber := dwBuildNumber;
    end;
end;
{$endif}

{$IFDEF MSWINDOWS}
var
  hTestTheme: HTheme;
{$ENDIF}


{ v2.0 }
var
  MsgHook, KeyboardHook: HHOOK;
  LastMsg: Cardinal = 0;

function AdxKeybHook(Code: Integer; wParam, lParam: Longint): Longint; stdcall;
var
  KeyIsDown: boolean;
  AltIsPressed: boolean;
  VirtualKey: word;
  KeyState: TKeyboardState;

  CharBuf: array[0..1] of char;
  convResult: integer;
const
  arrKeyDownMessage: array[boolean] of cardinal = (WM_KEYDOWN, WM_SYSKEYDOWN);
  arrKeyUpMessage: array[boolean] of cardinal = (WM_KEYUP, WM_SYSKEYUP);
begin
  Result:= 0;
  if code < 0 then
  begin
    Result:= CallNextHookEx(KeyboardHook, Code, wParam, lParam);
    Exit;
  end;
  if code = HC_ACTION then begin
    VirtualKey := wParam;

    if VirtualKey in [VK_PRIOR..VK_DOWN,
      VK_TAB, VK_BACK, VK_RETURN, VK_ESCAPE,
      VK_DELETE, VK_INSERT,
      VK_DIVIDE, VK_SUBTRACT,
      VK_MENU, VK_APPS, VK_F1..VK_F24] then
    begin
      KeyIsDown := (HiWord(lParam) and KF_UP) = 0;
      AltIsPressed := (GetKeyState(VK_MENU) and 128) = 128; //AltIsPressed := (HiWord(lParam) and KF_ALTDOWN) = 1;

      if KeyIsDown then
      begin
        SendMessage(Windows.GetFocus(), arrKeyDownMessage[AltIsPressed], wParam, lParam);

        GetKeyboardState(KeyState);
        convResult := Windows.ToAscii(VirtualKey, (lParam shr 16), KeyState, CharBuf, 0);
        if (convResult <> 0) then
          SendMessage(Windows.GetFocus(), WM_CHAR, integer(CharBuf[0]),lParam);
{
        if Key in [VK_TAB, VK_BACK, VK_RETURN, VK_ESCAPE, VK_DIVIDE, VK_SUBTRACT] then
          SendMessage(Windows.GetFocus(),WM_CHAR,wParam,lParam);
}
      end
      else
      begin
        SendMessage(Windows.GetFocus(),arrKeyUpMessage[AltIsPressed],wParam,lParam)
      end;
      result := 1;
      Exit;
    end
    else
    begin
      result := CallNextHookEx(KeyboardHook, Code, wParam, lParam);
    end;

  end

  else if Code = HC_NOREMOVE then
   begin
     result := 0;
     Exit;
   end;
end;

function AdxGetMsgHook(nCode: Integer; wParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
//  if nCode < 0 then
//  begin
//    Result:= CallNextHookEx(MsgHook, nCode, wParam, Longint(@Msg));;
//    Exit;
//  end;

  if (LastMsg = WM_KEYUP) and (Msg.message <> WM_KEYUP) then begin
    //If Excel6HWND <> 0 then  Windows.EnableWindow(Excel6HWND, true);
    //If ExcelFBarHWND <> 0 then Windows.EnableWindow(ExcelFBarHWND, true);
  end;
  case Msg.message of
    WM_KEYDOWN: begin
    if (LastMsg <> WM_KEYDOWN) then begin
       //If Excel6HWND <> 0 then Windows.EnableWindow(Excel6HWND, false);
       //If ExcelFBarHWND <> 0 then Windows.EnableWindow(ExcelFBarHWND, false);
    end;
    TDebug.WriteLine(' #### HookProc for Handle= '+IntToHex(Msg.hwnd, 8) +' '+WndMesssageToString(Msg.message));
    end;
    WM_MOUSEMOVE, WM_NCMOUSEMOVE: begin
    end;
    WM_ACTIVATE, WM_NCACTIVATE, WM_PARENTNOTIFY, WM_SETFOCUS, WM_KILLFOCUS: begin
          TDebug.WriteLine(' !!!! AdxGetMsgHook ' + WndMesssageToString(Msg.Message) + ' Msg.WParam = '+IntToHex(Msg.wParam, 4)
         + ' Msg.LParam = '+IntToHex(Msg.LParam, 8));

    end;
    else begin
//      TDebug.WriteLine(' #### HookProc for Handle= '+IntToHex(Msg.hwnd, 8) +' '+WndMesssageToString(Msg.message));
    end;
  end;
  LastMsg := Msg.message;
  Result := CallNextHookEx(MsgHook, nCode, wParam, Longint(@Msg));

end;

{ TadxOlExplorerArguments }

function TadxOlExplorerArguments.CheckCompatibilityWithSocialConnectorAddin: boolean;
var
  indent: TLogIndent;
begin
  indent := TLogIndent.Create('CheckCompatibilityWithSocialConnectorAddin');
  try
    case (FormsManagerSingleton.OutlookVersion) of
      v2000,
      v2002: begin
        Log.AddMessage('No SocialConnectorAddin');
        result := true;
        exit;
      end;
      v2003,
      v2007,
      v2010: begin
{$IFDEF SupportAdjacentWindow}
        result := true;
        exit;
{$ELSE}

        if (FFormsManager.SocialConnectorAddinConnected) then begin
          Log.AddMessage('No CompatibilityWithSocialConnectorAddin');
          result := false;
          exit;
        end
        else begin
          Log.AddMessage('CompatibilityWithSocialConnectorAddin');
          result := true;
          exit;
        end;
{$ENDIF}
      end;
    end;
    result := true;
  finally
    indent.Free;
  end;

end;

constructor TadxOlExplorerArguments.Create(AFormsManager: TadxOlFormsManager;
  const AExplorerObj: Explorer; CodeContext: TadxolCodeContext);
begin
  Log.AddMessage('TadxOlExplorerArguments.Create 1');
  Log.AddIndent;
  if AExplorerObj = nil then begin
    Log.AddWarning('ExplorerObj = nil');
  end;

  try
    FFormsManager := AFormsManager;
    FMessageClass := EmptyStr;
    FFolderEntryID := EmptyStr;
    FExplorerObj := AExplorerObj;
    FExplorerWindowHandle := GetExplorerWindowHandle(FExplorerObj);
    Log.AddMessage('Handle: ' + IntToHex(FExplorerWindowHandle, 8));

    if CodeContext <> ccExplorerClose then begin
      FFolderObj := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetCurrentFolder(FExplorerObj);
    end else begin
      FFolderObj := nil;
      Log.AddMessage('FFolderObj := nil;');
    end;
    InitFolderProperties(AFormsManager);
{$IFDEF CLIENTLAYOUTS}
    InitializeServiceForms(AFormsManager);
{$ENDIF}
    InitReadingPaneLayout(AFormsManager);
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlExplorerArguments.Create: ' + E.Message), 'TadxOlExplorerArguments.Create');
  end;
  Log.RemoveIndent;
end;

constructor TadxOlExplorerArguments.CreateWithFolder(
  AFormsManager: TadxOlFormsManager; const AExplorerObj: Explorer;
  AFolderObj: MAPIFolder; CodeContext: TadxolCodeContext);
begin
  Log.AddMessage('TadxOlExplorerArguments.CreateWithFolder');
  Log.AddIndent;

  if AExplorerObj = nil then begin
    Log.AddWarning('ExplorerObj = nil');
  end;

  if AFolderObj = nil then begin
    Log.AddWarning('AFolderObj = nil');
  end;

  try
    FFormsManager := AFormsManager;
    FAdxWebViewURLForFolder := false;
    FMessageClass := EmptyStr;
    FFolderEntryID := EmptyStr;
    FExplorerObj := AExplorerObj;
    FExplorerWindowHandle := GetExplorerWindowHandle(FExplorerObj);
    Log.AddMessage('Handle: ' + IntToHex(FExplorerWindowHandle, 8));
    FFolderObj := AFolderObj;
    InitFolderProperties(AFormsManager);
{$IFDEF CLIENTLAYOUTS}
    InitializeServiceForms(AFormsManager);
{$ENDIF}
    InitReadingPaneLayout(AFormsManager);
  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlExplorerArguments.CreateWithFolder: ' + E.Message), 'TadxOlExplorerArguments.CreateWithFolder');
  end;
  Log.RemoveIndent;
end;

destructor TadxOlExplorerArguments.Destroy;
begin
  FFormsManager := nil;
{$IFDEF CLIENTLAYOUTS}
  FReadingPaneServiceForm := nil;
  FSuperGridServiceForm := nil;
{$ENDIF}
  FExplorerObj := nil;
  FFolderObj := nil;
  inherited;
end;

function TadxOlExplorerArguments.GetReadingPaneLayout: TadxOlReadingPaneLayout;
begin
  result := FReadingPaneLayout; 
end;

function TadxOlExplorerArguments.GetServiceForm(
  ExplorerLayout: TadxolExplorerLayout): TadxForm;
begin
  result := nil;
  case ExplorerLayout of
    elFolderView: begin
      result := FolderViewServiceForm;
      exit;
    end;
    elReadingPane: begin
      result := ReadingPaneServiceForm;
      exit;
    end;
  end;
end;

procedure TadxOlExplorerArguments.InitFolderProperties(AFormsManager: TadxOlFormsManager);
var
  WebViewURL: string;
begin
  Log.AddMessage('TadxOlExplorerArguments.InitFolderProperties');
  Log.AddIndent;
  if (FFolderObj <> nil) then begin
      if TADXOlOutlookUtils(AFormsManager.OutlookUtils).CheckPossibilityOpenFolder(FFolderObj) then begin
        FFolderEntryID := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetEntryID(FFolderObj);
        Log.AddMessage('FFolderEntryID: ' + FFolderEntryID);
        FFullFolderName := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetFullFolderName(FFolderObj);
        Log.AddMessage('FFullFolderName: ' + FFullFolderName);
        FFolderDefaultItemType := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetDefaultItemType(FFolderObj);
        Log.AddMessage('FFolderDefaultItemType: ' + IntToStr(FFolderDefaultItemType));
        FExplorerItemType := TadxOlOutlookUtils(AFormsManager.OutlookUtils).GetExplorerItemType(FFolderObj);

        FMessageClass := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetFolderMessageClass(FFolderObj);
        Log.AddMessage('FMessageClass: ' + FMessageClass);

        FWebViewOn := TadxOlOutlookUtils(AFormsManager.OutlookUtils).GetWebViewOn(FFolderObj);
        WebViewURL := TadxOlOutlookUtils(AFormsManager.OutlookUtils).GetWebViewURL(FFolderObj);
        Log.AddMessage('WebViewURL: ' + WebViewURL);

        FAdxWebViewURLForFolder := (FWebViewOn
          and Globals.ContainsADXStrings(WebViewURL, GlobalsOl.GeneralHTMLFileName));
      end;
  end
  else begin
    Log.AddWarning('FFolderObj = nil');
  end;
  Log.RemoveIndent;
end;

procedure TadxOlExplorerArguments.InitializeServiceForms(
  AFormsManager: TadxOlFormsManager);
var
  i: integer;
begin
  for i := 0 to TadxOlRegisterExplorerList(AFormsManager.FRegisteredExplorerList).Count - 1 do begin
    if (TadxOlExplorer(TadxOlRegisterExplorerList(AFormsManager.FRegisteredExplorerList)[i]).ExplorerWindowHandle = FExplorerWindowHandle) then begin
      FSuperGridServiceForm := TadxOlExplorer(TadxOlRegisterExplorerList(AFormsManager.FRegisteredExplorerList)[i]).FolderViewServiceForm;
      FReadingPaneServiceForm := TadxOlExplorer(TadxOlRegisterExplorerList(AFormsManager.FRegisteredExplorerList)[i]).ReadingPaneServiceForm;
      exit;
    end;
  end;
end;

procedure TadxOlExplorerArguments.InitReadingPaneLayout(AFormsManager: TadxOlFormsManager);
var
  ReadingPaneHandle: HWND;
  MsoDockTopWindowHandle: HWND;
begin
  ReadingPaneHandle := TOutlookHandleFinder(AFormsManager.FOutlookHandleFinder).GetAppWindowHandle(AFormsManager.FOutlookVersion, stOlReadingPane, self.ExplorerWindowHandle);
  if (AFormsManager.FOutlookVersion = v2010) then begin
    MsoDockTopWindowHandle := TOutlookHandleFinder(AFormsManager.FOutlookHandleFinder).GetMsoDockTopWindowHandle(AFormsManager.FOutlookVersion, self.ExplorerWindowHandle);
  end
  else begin
    MsoDockTopWindowHandle := 0;
  end;
  self.FReadingPaneLayout := TMoveReadingPaneWindowWatchObject.CurrentLayout(AFormsManager.OutlookVersion, ReadingPaneHandle, MsoDockTopWindowHandle);
end;

procedure TadxOlExplorerArguments.RefreshServiceForms(
  AFormsManager: TadxOlFormsManager);
begin
  InitializeServiceForms(AFormsManager);
end;

{ TadxOlInspectorArguments }

constructor TadxOlInspectorArguments.Create(
  AFormsManager: TadxOlFormsManager; AInspectorObj: Inspector;
  AInspectorWindowHandle: HWND;
  CodeContext: TadxolCodeContext);
{$IFNDEF ADXXOL_TRIAL}
  //TestMailItem: MailItem;
{$ENDIF}
begin
  {$IFNDEF ADXXOL_TRIAL}
  Log.AddMessage('TadxOlInspectorArguments.Create Handle = ' + IntToHex(AInspectorWindowHandle, 8) + ', CodeContext = ' + IntToStr(ord(CodeContext)));
  Log.AddIndent;
  TDebug.WriteLine('TadxOlInspectorArguments.Create');
  MailPostInspectorType := mitUnknown;
  FWindowHandle := 0;
  try
    FChangingInspectorWindowHandle := (CodeContext = ccChangingInspectorWindowHandle);

    FInspectorWindowHandle := AInspectorWindowHandle;

    FInspectorObj := AInspectorObj;

    if (FInspectorObj = nil) then begin
      Log.AddWarning('FInspectorObj = nil');
    end;

    //TODO: !!! Invalid inspetor 
    //Inspertor is not valid: The operation failed due to network or other communication problems.
    //Check your connections and try again
    //Check Inspertor validing
    try
      Log.AddMessage('Check Inspertor validing:' + FInspectorObj.Caption);
    except
      on E: SysUtils.Exception do begin
        Log.AddWarning('Inspertor is not valid: ' + E.Message);
      end;
    end;

    FParentFolderObj := nil;
    FItemObj := nil;

    SetItemObj(AFormsManager);

    FCodeContext := CodeContext;
    if (CodeContext <> ccInspectorClose) and (CodeContext <> ccUnregisterInspector) then begin

      SetItemClass(AFormsManager);

      if (FItemClass > 0) then begin
        FInspectorItemType := GlobalsOl.ConvertItemClassToOlInspectorItemType(FItemClass);
        FInspectorItemTypeCaption := GlobalsOl.ConvertItemClassToString(FItemClass);
        FIsMailPost := (insMail = FInspectorItemType) or (insPost = FInspectorItemType);
        if (FIsMailPost) then begin
          InitMailPostInspectorType(AFormsManager, FInspectorItemType);
        end;
      end;

      if (FInspectorObj <> nil) then begin
        try
          FMessageClass := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetInspectorMessageClass(FInspectorObj);
          Log.AddMessage('FMessageClass: ' + FMessageClass);
        except
          on E: SysUtils.Exception do begin
            Log.AddWarning('GetInspectorMessageClass raises the exception. ' + E.Message);
            //ProcessADXXError('TadxOlInspectorArguments.Create (Get Item.Class) : ' + E.Message);
          end;
        end;
      end;

      SetInspectorMode;

      SetParentFolderObject;

    end;

    if (FParentFolderObj <> nil) then begin
      FParentFullFolderName := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetFullFolderName(FParentFolderObj);
      Log.AddMessage('FParentFullFolderName: ' + FParentFullFolderName);
      FParentFolderEntryID := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetEntryID(FParentFolderObj);
      Log.AddMessage('FParentFolderEntryID: ' + FParentFolderEntryID);
    end;
    {$ELSE}
    {$ENDIF}

{$IFDEF CLIENTLAYOUTS}
    InitializeServiceForms(AFormsManager, FInspectorWindowHandle);
{$ENDIF}

  except
    on E:SysUtils.Exception do
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlInspectorArguments.Create ' + E.Message), 'TadxOlInspectorArguments.Create');
  end;
  Log.RemoveIndent;
end;

destructor TadxOlInspectorArguments.Destroy;
begin
{$IFDEF CLIENTLAYOUTS}
  FClientSubpaneServiceForm := nil;
{$ENDIF}

  FInspectorObj := nil;
  FItemObj := nil;
  FParentFolderObj := nil;
  inherited;
end;

function TadxOlInspectorArguments.GetContextInspectorAdxItemType: TadxItemType;
begin
  result := FormsManagerSingleton.GetInspectorAdxItemType(self.InspectorItemType, ord(MailPostInspectorType));
end;

class function TadxOlInspectorArguments.GetInspectorMode(AInspectorObj: Inspector;
  InspectorWindowHandle: HWND;
  ItemObj: IDispatch; OutlookVersion: TadxolOutlookVersion): TadxolInspectorMode;
var
  ItemClass: integer;
  InspectorItemType: TadxolInspectorItemType;
  EditorType: TOleEnum;
  meetingItem_: MeetingItem;
  mailItem_: MailItem;
  VWordEditor, VHTMLEditor: OleVariant;
  TextDocumentHandle: HWND;
  WindowStyle: integer;
begin
  if (ItemObj = nil) then begin
    raise SysUtils.Exception.Create('GetInspectorMode: Argument ItemObj is null.');
  end;
    try
      ItemClass := OLEVariant(ItemObj).Class;
    except
      //MeetingRequest -> Accept
      on E: SysUtils.Exception do begin
        ItemClass := 0;
        Log.AddWarning('GetInspectorMode: OLEVariant(ItemObj).Class raises the exception. ' + E.Message);
      end;
    end;

    InspectorItemType := GlobalsOl.ConvertItemClassToOlInspectorItemType(ItemClass);
    case InspectorItemType of
      insRecipient: begin
          result := imCompose;
          exit;
      end;
      insAppointment: begin
          result := imCompose;
          exit;
      end;
      insMeetingRequest,
      insMeetingCancellation,
      insMeetingResponseNegative,
      insMeetingResponsePositive,
      insMeetingResponseTentative: begin
          meetingItem_ := ItemObj as MeetingItem;
          if meetingItem_.Sent then begin
            result := imRead;
          end
          else begin
            result := imCompose;
          end;
          meetingItem_ := nil;
          exit;
      end;
      insContact: begin
          result := imCompose;
          exit;
      end;
      insJournal: begin
          result := imCompose;
          exit;
      end;
      insMail: begin
          mailItem_ := ItemObj as MailItem;
          if (mailItem_.Sent) then begin
            result := imRead;
          end
          else begin
            result := imCompose;
          end;
          mailItem_ := nil;
          exit;
      end;
      insPost: begin
          case OutlookVersion of
            v2000,
            v2002,
            v2003:
              EditorType := AInspectorObj.EditorType;
            v2007,
            v2010:
              EditorType := olEditorWord;
            else raise SysUtils.Exception.Create('GetInspectorMode: Unknown OutlookVersion.');
          end;

          case EditorType of

            olEditorWord: begin
              VWordEditor := null;
              FormsManagerSingleton.DoBeforeAccessProtectedObject;
              try
                VWordEditor := AInspectorObj.WordEditor;
              finally
                FormsManagerSingleton.DoAfterAccessProtectedObject; 
              end;
              if VarIsNull(VWordEditor) then begin
                Log.AddWarning('AInspectorObj.WordEditor is nil');
                raise SysUtils.Exception.Create('GetInspectorMode: AInspectorObj.WordEditor is nil.');
              end;

              if (VWordEditor.ProtectionType = -1) then begin
                //wdNoProtection = -1
                //wdAllowOnlyRevisions = 0
                //wdAllowOnlyComments = 1
                //wdAllowOnlyFormFields = 2
                result := imCompose;
                exit;
              end
              else begin
                result := imRead;
                exit;
              end;
            end;//olEditorWord

            olEditorHTML: begin
              VHTMLEditor := null;
              VHTMLEditor := AInspectorObj.HTMLEditor;
              if VarIsNull(VHTMLEditor) then begin
                Log.AddWarning('AInspectorObj.HTMLEditor is nil');
                raise SysUtils.Exception.Create('GetInspectorMode: AInspectorObj.HTMLEditor is nil.');
              end;
              if Globals.CompareADXStrings(VHTMLEditor.designMode, 'on') then begin
                result := imCompose;
                exit;
              end
              else begin
                result := imRead;
                exit;
              end;

            end;//olEditorHTML

            olEditorRTF, olEditorText: begin
              TextDocumentHandle := TextDocumentUtils.GetTextDocumentWindowHandle(OutlookVersion, EditorType, InspectorWindowHandle);
              if (TextDocumentHandle = 0) then begin
                Log.AddWarning('GetInspectorMode: TextDocumentHandle = 0.');
                raise SysUtils.Exception.Create('GetInspectorMode: TextDocumentHandle = 0.');
              end;

              WindowStyle := GetWindowLongCheckUnicode(TextDocumentHandle, GWL_STYLE);
              if ((ES_READONLY and WindowStyle) = ES_READONLY) then begin
                result := imRead;
                exit;
              end
              else begin
                result := imCompose;
                exit;
              end;
            end; //olEditorRTF, olEditorText
            else raise SysUtils.Exception.Create('GetInspectorMode: Unknown EditorType');
          end;
      end;
      insTask: begin
        result := imCompose;
        exit;
      end;
      insTaskRequest,
      insTaskRequestUpdate,
      insTaskRequestAccept,
      insTaskRequestDecline: begin
        result := imCompose;
        exit;
      end;
      insDistributionList: begin
        result := imCompose;
        exit;
      end;
      insReport: begin
        result := imRead;
        exit;
      end;
      insSharing: begin
        if (OLEVariant(ItemObj).Sent) then begin
          result := imRead;
        end
        else begin
          result := imCompose;
        end;
      end;
      insMobile: begin
        if (OLEVariant(ItemObj).Sent) then begin
          result := imRead;
        end
        else begin
          result := imCompose;
        end;
      end;
      else begin
          raise SysUtils.Exception.Create('GetInspectorMode: Unknown inspectorItemType');
      end;
    end;
end;

function TadxOlInspectorArguments.GetIsWordMailInspector: boolean;
begin
  result := (MailPostInspectorType = mitWordEditor);
end;

function TadxOlInspectorArguments.GetServiceForm(InspectorLayout: TadxolInspectorLayout): TadxOlForm;
begin
  case InspectorLayout of
    ilInspectorRegion: result := FClientSubpaneServiceForm;
{$IFDEF SUBSTINSPECTORREGION}
    ilCompleteReplacement: result := FClientSubpaneServiceForm;
{$ENDIF}
    else result := nil;
  end;
end;

function TadxOlInspectorArguments.GetWindowHandle: HWND;
begin
  if (CodeContext <> ccRefreshInspectorTab) then begin
    raise SysUtils.Exception.Create('Illegal using.');
  end;
  result := FWindowHandle;
end;

procedure TadxOlInspectorArguments.InitializeServiceForms(
  AFormsManager: TadxOlFormsManager; InspectorWindowHandle: HWND);
var
  i: integer;
begin
  for i := 0 to TadxOlRegisterInspectorList(AFormsManager.FRegisteredInspectorList).Count - 1 do begin
    if (TadxOlInspector(TadxOlRegisterInspectorList(AFormsManager.FRegisteredInspectorList)[i]).InspectorWindowHandle = InspectorWindowHandle) then begin
      FClientSubpaneServiceForm := TadxOlInspector(TadxOlRegisterInspectorList(AFormsManager.FRegisteredInspectorList)[i]).InspectorRegionServiceForm;
      exit;
    end;
  end;
end;

procedure TadxOlInspectorArguments.InitMailPostInspectorType(
  AFormsManager: TadxOlFormsManager; AInspectorItemType: TadxolInspectorItemType);
begin
  if ((AFormsManager.OutlookVersion = v2007)
    or (AFormsManager.OutlookVersion = v2010)) then begin
    FMailPostInspectorType := mitStandard;
  end;

  if (AFormsManager.OutlookVersion = v2000)
    or (AFormsManager.OutlookVersion = v2002)
    or (AFormsManager.OutlookVersion = v2003) then begin

    case AInspectorItemType of
      insMail: begin
        if TADXOlOutlookUtils(AFormsManager.OutlookUtils).IsWordMailInspector(FInspectorObj) then begin
          self.FMailPostInspectorType := mitWordEditor;
        end
        else begin
          self.FMailPostInspectorType := mitStandard;
        end;
      end;
      insPost: begin
        if TADXOlOutlookUtils(AFormsManager.OutlookUtils).IsWordPostInspector(FInspectorObj) then begin
          self.FMailPostInspectorType := mitWordEditor;
        end
        else begin
          self.FMailPostInspectorType := mitStandard;
        end;
      end;
    end;
  end;
end;

procedure TadxOlInspectorArguments.SetInspectorMode;
begin
  Log.AddMessage('SetInspectorMode');
  if (FItemObj <> nil) then begin
    try
    self.FInspectorMode := GetInspectorMode(self.InspectorObj, self.FInspectorWindowHandle, self.FItemObj, FormsManagerSingleton.FOutlookVersion);
    except
      self.FInspectorMode := TadxolInspectorMode(0);
    end;
  end;
end;

procedure TadxOlInspectorArguments.SetItemClass(AFormsManager: TadxOlFormsManager);
begin
  if (FItemObj <> nil) then begin
    try
      FItemClass := 0;
      Log.AddMessage('Getting FItemClass');
      FItemClass := OLEVariant(FItemObj).Class;
    except
      //MeetingRequest -> Accept
      on E: SysUtils.Exception do begin
        Log.AddWarning('OLEVariant(FItemObj).Class raises the exception. ' + E.Message);
        //ProcessADXXError('TadxOlInspectorArguments.Create (Get Item.Class) : ' + E.Message);
      end;
    end;
    Log.AddMessage('FItemClass: ' + IntToStr(FItemClass));
  end;
end;

procedure TadxOlInspectorArguments.SetItemObj(
  AFormsManager: TadxOlFormsManager);
begin
  Log.AddMessage('SetItemObj');
  if FInspectorObj <> nil then begin
    FItemObj := TADXOlOutlookUtils(AFormsManager.OutlookUtils).GetInspectorCurrentItem(FInspectorObj);
    if (FItemObj <> nil) then begin
      Log.AddMessage('FItemObj <> nil');
    end;
  end else begin
    Log.AddWarning('FInspectorObj = nil');
  end;
end;

procedure TadxOlInspectorArguments.SetMailPostInspectorType(
  const Value: TadxolMailPostInspectorType);
begin
  FMailPostInspectorType := Value;
end;

procedure TadxOlInspectorArguments.SetParentFolderObject;
var
  Parent: IDispatch;
begin
  if FItemObj <> nil then begin
    try
      Parent := nil;
      Parent := OLEVariant(FItemObj).Parent;
    except
      on E: SysUtils.Exception do begin
        Parent := nil; //Outside Inspector
        Log.AddWarning('OLEVariant(FItemObj).Parent raises the exception. ' + E.Message);
      end;
    end;
  end
  else begin
    Log.AddWarning('FItemObj = nil');
  end;

  if Parent <> nil then begin
    try
      FParentFolderObj := nil;
      Parent.QueryInterface(StringToGUID('{00063006-0000-0000-C000-000000000046}'), FParentFolderObj);
    finally
      Parent := nil;
    end;
  end;
end;

procedure TadxOlInspectorArguments.SetWindowHandle(const Value: HWND);
begin
  if (CodeContext <> ccRefreshInspectorTab) then begin
    raise SysUtils.Exception.Create('Illegal using.');
  end;
  FWindowHandle := Value;
end;

{ TadxOlForm }

procedure TadxOlForm.AdxOlShow(AAppWindowProperty: Pointer; raiseEvents: boolean);
var
  adxCaption: TadxCaption;
  WishfulVisible: boolean;
  event: TadxEventRaising;
  explorerItemType: TadxolExplorerItemType;
  WindowHandle: HWND;
begin
  Log.AddMessage('TadxOlForm.AdxOlShow');

  TDebug.WriteLine('*** TadxOlForm.AdxOlShow');
  WishfulVisible := True;
  try
  StrPCopy(adxCaption,  Self.Caption);
  FEmulateWindowHandle := PAppWindowProperty(AAppWindowProperty)^.EmulateWindowHandle;
  FWindowHandle := PAppWindowProperty(AAppWindowProperty)^.WindowHandle;

  explorerItemType := expMailItem;
  if Assigned(FormsManager) and Assigned(FFolderObj) then begin
    explorerItemType := TadxOlOutlookUtils(FormsManager.OutlookUtils).GetExplorerItemType(FFolderObj);
  end;
  UpdateAdxLayoutKey(PAppWindowProperty(AAppWindowProperty)^.ItemType, explorerItemType);

  PAppWindowProperty(AAppWindowProperty)^.Caption := adxCaption;
  if Assigned(Self.OnADXBeforeFormShow) then begin
    Self.LockVisible := true;
    Visible := true;
    if raiseEvents then begin
      try
        event := TadxEventRaising.Create('OnADXBeforeFormShow', [eoAvailableRegionState]);
        try
          Self.OnADXBeforeFormShow(Self);
        finally
          event.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.AdxOlShow');
        end;
      end;
    end;

    UpdateAppWindowPropertyAfterBeforeFormShowEvent(AAppWindowProperty);

    WishfulVisible := Visible;
    Self.LockVisible := false;
  end;

  if WishfulVisible then begin

    //Update Item properties
    if (self.IsExplorerForm) then begin
      PAppWindowProperty(AAppWindowProperty)^.Layout := Item.GetExplorerAdxLayout();
    end;

    if (self.IsInspectorForm) then begin
      PAppWindowProperty(AAppWindowProperty)^.Layout := Item.GetInspectorAdxLayout();
    end;

    Self.InitProperties(AAppWindowProperty);
    LockWindowUpdate(self.HostHandle);
    try
      if (self.IsExplorerForm and Item.IsDockLayout) then begin
        ShowCTP(WindowHandle);
        if (WindowHandle = 0) then begin
          exit;
        end;
      end;
      Self.ShowInternal;
    finally
      LockWindowUpdate(0);
    end;

    CheckWordMailInspectorUnderExplorer();

    if Assigned(Self.OnADXAfterFormShow) then begin
      if (raiseEvents) then begin
        try
          event := TadxEventRaising.Create('OnADXAfterFormShow', [eoAvailableRegionState]);
          try
            Self.OnADXAfterFormShow(Self);
          finally
            event.Free;
          end;
        except
          on E:SysUtils.Exception do begin
            TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.AdxOlShow');
          end;
        end;
      end;
    end;

    if (FIsInspectorForm and (Item.InspectorLayout = ilCompleteReplacement)) then begin
      PostMessage(Handle, WM_ADXCOMMAND, adxActivateCompleteReplacement, 0);
    end;

  end;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('AdxOlShow: ' + E.Message), 'TadxOlForm.AdxOlShow');
    end;
  end;
end;

function TadxOlForm.CheckOutlookWindowHandle(Handle: HWND): boolean;
begin
  result := (Self.FOutlookWindowHandle = Handle);
end;

procedure TadxOlForm.DisposeOutlookObjects;
begin
  FInspectorObj := nil;
  FFolderObj := nil;
  FExplorerObj := nil;
  FFolderItemsObj := nil;
end;

constructor TadxOlForm.CreateEx(AFormsManager: TadxolFormsManager; AItem: TadxOlFormsCollectionItem);
begin
  Log.AddMessage('adxOlForm.CreateEx ' + FormID);
  try
    self.FisHidenByDeveloper := false;
    inherited Create(AFormsManager);
    if not (csDesigning in self.ComponentState) then begin
      FFormsManager := AFormsManager as TadxOlFormsManager;
      FItem := AItem as TadxOlFormsCollectionItem;
      FIsInspectorForm := false;
      FIsExplorerForm := false;
      FExplorerObj := nil;
      FInspectorObj := nil;
      FFolderObj := nil;
    end;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.CreateEx');
      raise E;
    end;
  end;
end;

destructor TadxOlForm.Destroy;
var
  index: integer;
begin
  Log.AddMessage('TadxOlForm.Destroy ' + FormID);
  if not (csDesigning in self.ComponentState) then begin
    if self.Visible then begin
      self.HideByManager;
    end;
    if (FItem <> nil) then begin
      index := TadxOlFormsManagerList(FItem.FFormInstances).IndexOf(self);
      TadxOlFormsManagerList(FItem.FFormInstances)[index] := nil;
    end;
    //
    FFolderObj := nil;
    FExplorerObj := nil;
    FFolderItemsObj := nil;
    FInspectorObj := nil;
    FItem := nil;
    FFormsManager := nil;
  end;
  Log.AddMessage('TadxOlForm.Destroy.inherited ' + FormID);
  inherited Destroy;
end;

function TadxOlForm.GetAddinModule: TObject;
begin
  result:= nil;
  if Assigned(FormsManager) then
    result := (FormsManager as TADXOLFormsManager).Owner;
end;

function TadxOlForm.GetIsExplorerForm: boolean;
begin
  result := FIsExplorerForm;
end;

function TadxOlForm.GetIsInspectorForm: boolean;
begin
  result := FIsInspectorForm;
end;

function TadxOlForm.GetOSCConnected: boolean;
begin
  Result:= false;
  if Assigned(FormsManager) then
    Result:= FormsManager.SocialConnectorAddinConnected;
end;

function TadxOlForm.GetOutlookAppObj: OutlookApplication;
begin
  result := TadxOlFormsManager(FFormsManager).OutlookAppObj;
end;

procedure TadxOlForm.Hide;
begin
  if not (csDesigning in self.ComponentState) then begin
    FisHidenByDeveloper := true;
    AdxOlHide(true);
    end
  else begin
    inherited Hide;
  end;
end;

procedure TadxOlForm.InitializeForm(AContextArgs: TObject; AAppWindowProperty: Pointer);
var
  ExplorerArgs: TadxOlExplorerArguments;
  InspectorArgs: TadxOlInspectorArguments;
begin
  Log.AddMessage('InitializeForm');
  Log.AddIndent;

  if AContextArgs = nil then exit;

  Self.DisposeOutlookObjects;

  ExplorerArgs := nil;
  if (AContextArgs is TadxOlExplorerArguments) then
    ExplorerArgs := AContextArgs as TadxOlExplorerArguments;
  if (ExplorerArgs <> nil) then begin
    FIsExplorerForm := true;
    Self.FOutlookWindowHandle := ExplorerArgs.ExplorerWindowHandle;
    if (ExplorerArgs.FolderObj <> nil) then begin //IMAP Folder
    ExplorerArgs.FolderObj.QueryInterface(StringToGUID('{00063006-0000-0000-C000-000000000046}'),
      Self.FFolderObj);
    end;
    ExplorerArgs.ExplorerObj.QueryInterface(StringToGUID('{00063003-0000-0000-C000-000000000046}'),
      Self.FExplorerObj);

    Self.FFolderEntryID := ExplorerArgs.FolderEntryID;
    if ExplorerArgs.FolderObj <> nil then begin
      Self.FFolderItemsObj := ExplorerArgs.FolderObj.Items;
    end
    else begin
      Log.AddWarning('ExplorerArgs.FolderObj = nil');
    end;

  end;

  InspectorArgs := nil;
  if (AContextArgs is TadxOlInspectorArguments) then
    InspectorArgs := AContextArgs as TadxOlInspectorArguments;
  if (InspectorArgs <> nil) then begin
    FIsInspectorForm := true;
    FIsWordMailInspectorForm := InspectorArgs.IsWordMailInspector;
    if InspectorArgs.ParentFolderObj <> nil then begin //O2007 Appointment open this Occurrence
      InspectorArgs.ParentFolderObj.QueryInterface(StringToGUID('{00063006-0000-0000-C000-000000000046}'),
        Self.FFolderObj);

      Self.FFolderItemsObj := InspectorArgs.ParentFolderObj.Items;
    end;

    Self.FFolderEntryID := InspectorArgs.FParentFolderEntryID;
    Self.FOutlookWindowHandle := InspectorArgs.InspectorWindowHandle;
    InspectorArgs.InspectorObj.QueryInterface(StringToGUID('{00063005-0000-0000-C000-000000000046}'), Self.FInspectorObj);
  end;
  CopyAppWindowProperty(FAppWindowProperty, AAppWindowProperty);
  Log.RemoveIndent;
end;

function TadxOlForm.RegistryKey: string;
begin
  if (FormsManager <> nil) then begin
    if (Owner = nil) then begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlForm.RegistryKey: Cannot return a RegistryKey. Owner is nil.'), 'RegistryKey');
    end;
    if not (Owner is TadxOlFormsManager) then begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlForm.RegistryKey: Cannot return a RegistryKey. Owner is not TadxOlFormsManager.'), 'RegistryKey');
    end;

    result := TadxOlFormsManager(Owner).COMAddInModule.RegistryKey;
  end
  else begin
    result := inherited RegistryKey;
  end;
end;

procedure TadxOlForm.UpdateAdxLayoutKey(itemType: TadxItemType; explorerItemType: TadxolExplorerItemType);
begin
  FAdxLayoutKey:= 'Unknown';
  if (FormsManager <> nil) and Assigned(Item) then begin
    if Assigned(FExplorerObj) then begin
      FAdxLayoutKey := GetExplorerLayoutKey(Item.ExplorerLayout, explorerItemType, FormsManager.ReadingPaneLayout);
    end;
    if Assigned(InspectorObj) then begin
      FAdxLayoutKey := GetInspectorLayoutKey(Item.InspectorLayout);
    end;
  end;
end;

function TadxOlForm.AdxLayoutKey: string;
begin
  Result:= FAdxLayoutKey;
end;

function TadxOlForm.AdxRegistryKey: string;
begin
  Result := FormsManager.AdxRegistryKey;
end;

procedure TadxOlForm.Show;
begin
  if not (csDesigning in self.ComponentState) then begin
    self.FisHidenByDeveloper := false;

    if LockVisible then begin
      Visible := true;
    end
    else begin
      FormsManager.TryProcessTheADXOlFormShowMethod(self);
    end;
  end  
  else begin
    inherited Show;
  end;
end;

procedure TadxOlForm.ShowCTP(var CTPHandle: HWnd);
{$IFDEF DOCKEXPLORERLAYOUTS}
var
  param: TAdxCTPParams;
{$ENDIF}
begin
{$IFDEF DOCKEXPLORERLAYOUTS}
  Log.AddMessage('TadxOlForm.ShowCTP');
  param.pType:= 0;
  param.Size := GetCTPSize;
  param.Splitter := Cardinal(Item.Splitter);
  try
    case (Item.ExplorerLayout) of
      elDockLeft: param.Position:= dpDockLeft;
      elDockRight: param.Position:= dpDockRight;
      elDockTop: param.Position:= dpDockTop;
      elDockBottom: param.Position:= dpDockBottom;
    end;
    FormsManager.ShowCTP(self.ExplorerObj, param);
    CTPHandle := TOfficeTaskPaneFinder.FindWindow(FormsManager.OutlookVersion, FOutlookWindowHandle, Layout);

    if (CTPHandle <> 0) and (IsWindowVisible(CTPHandle)) then begin
      if Assigned(AppWindow) then
          AppWindow.Handle := CTPHandle;
       PAppWindowProperty(FAppWindowProperty)^.WindowHandle := CTPHandle;
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOlForm.ShowCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlForm.ShowCTP. ' + E.Message), 'ShowCTP');
    end;
  end;
{$ENDIF}
end;

procedure TadxOlForm.UpdateCTPParam(uType: TadxCTPUpdateParamType; ASize: integer);
{$IFDEF DOCKEXPLORERLAYOUTS}
var
  param: TAdxCTPParams;
{$ENDIF}
begin
{$IFDEF DOCKEXPLORERLAYOUTS}
  Log.AddMessage('TadxOlForm.UpdateCTP');
  param.pType:= byte(uType);
  param.Size := ASize;
  param.Splitter := Cardinal(Item.Splitter);
  try
    case (Item.ExplorerLayout) of
      elDockLeft: param.Position:= dpDockLeft;
      elDockRight: param.Position:= dpDockRight;
      elDockTop: param.Position:= dpDockTop;
      elDockBottom: param.Position:= dpDockBottom;
    end;
    FormsManager.UpdateCTP(self.ExplorerObj, param);
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOlForm.UpdateCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlForm.UpdateCTP. ' + E.Message), 'UpdateCTP');
    end;
  end;
{$ENDIF}
end;

function TadxOlForm.GetCurrentOutlookWindowHandle: HWND;
begin
  result := FOutlookWindowHandle;
end;

procedure TadxOlForm.ChangeInspectorWindowHandle(
  newOutlookWindowHandle: HWND);
begin
  if (self.FOutlookWindowHandle <> newOutlookWindowHandle) then begin
    self.FOutlookWindowHandle := newOutlookWindowHandle;
  end;
end;

procedure TadxOlForm.RaiseOnADXBeforeInspectorSubpaneClose(Sender: TObject);
var
  event: TadxEventRaising;
begin
  if Assigned(self.OnADXBeforeInspectorSubpaneClose) then begin
    try
      event := TadxEventRaising.Create('OnADXBeforeInspectorSubpaneClose', [eoLockRegionState]);
      try
        self.OnADXBeforeInspectorSubpaneClose(Sender);
      finally
        event.Free;
      end;
    except
      on E:SysUtils.Exception do
        TadxExceptionManager.ProcessADXXError(E, 'RaiseOnADXBeforeInspectorSubpaneClose');
    end;
  end;
end;

procedure TadxOlForm.ADXOlHide(raiseEvents: boolean);
var
  AfterFormHideEventArgs: TadxOlAfterFormHideEventArgs;
  NeedToRaiseAfterFormHideEvent: boolean; 
begin
  if LockVisible then begin
    Visible := false;
  end
  else begin
    //TDebug.WriteLine('@@@ TadxOlForm.ADXOlHide ' + IntToStr(Cardinal(FormsManager)));
    NeedToRaiseAfterFormHideEvent := self.Visible and self.Injected;

    Windows.LockWindowUpdate(HostHandle);
    try
      inherited Hide;
      if (self.IsExplorerForm) then begin
        if Assigned(Item) then
          HideCTP(Item.ExplorerLayout);
      end;
    finally
      Windows.LockWindowUpdate(0);
    end;

    DisposeOutlookObjects;
    if (raiseEvents and NeedToRaiseAfterFormHideEvent) then begin
      try
        Log.AddMessage('raise event OnADXAfterFormHide');
        AfterFormHideEventArgs := TadxOlAfterFormHideEventArgs.Create;
        try
          Self.DoAdxAfterFormHide(AfterFormHideEventArgs);
          Log.AddMessage('after raise event OnADXAfterFormHide');
        finally
          AfterFormHideEventArgs.Free;
        end;
      except
        on E:SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.ADXOlHide');
        end;
      end;
    end;
  end;

end;

procedure TadxOlForm.HideByManager(UsingVisibleProperty: boolean);
begin
  ADXOlHide(true);
end;


procedure TadxOlForm.DoActivate;
begin
  if (FormsManager <> nil) then begin
    if FormsManager.OutlookVersion > v2000 then begin
      SetHTMLDocumentTitle;
    end;
  end;
  inherited DoActivate;//must be after set HTMLDocument.Title
end;

procedure TadxOlForm.DoAdxAfterFormHide(args: TadxOlAfterFormHideEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXAfterFormHide) then begin
    try
      event := TadxEventRaising.Create('DoAdxAfterFormHide', [eoLockRegionState]);
      try
        OnADXAfterFormHide(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxAfterFormHide');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoAdxEnter(args: TadxOlEnterEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnAdxEnter) then begin
    try
      event := TadxEventRaising.Create('OnADXEnter', [eoLockRegionState]);
      try
        OnADXEnter(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxEnter');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoAdxExit(args: TadxOlExitEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnAdxExit) then begin
    try
      event := TadxEventRaising.Create('OnADXExit', [eoLockRegionState]);
      try
        OnADXExit(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxExit');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoAdxFolderSwitch(args: TadxOlFormFolderSwitchEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXFolderSwitch) then begin
    try
      event := TadxEventRaising.Create('OnADXFolderSwitch', [eoLockRegionState]);
      try
        OnADXFolderSwitch(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxFolderSwitch');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoAdxInspectorActivate(
  args: TadxOlFormInspectorActivateEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXInspectorActivate) then begin
    try
      event := TadxEventRaising.Create('OnADXInspectorActivate', [eoLockRegionState]);
      try
        OnADXInspectorActivate(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxInspectorActivate');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoADXKeyFilter(Args: TadxOlKeyFilterEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXKeyFilter) then begin
    try
      event := TadxEventRaising.Create('OnADXKeyFilter', [eoLockRegionState]);
      try
        OnADXKeyFilter(self, Args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoADXKeyFilter');
      end;
    end;
  end;
end;

procedure TadxOlForm.DoAdxPostMessage(args: TadxOlPostMessageReceivedEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXPostMessageReceived) then begin
    try
      event := TadxEventRaising.Create('OnADXPostMessageReceived', [eoLockRegionState]);
      try
        OnADXPostMessageReceived(args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxPostMessage');
      end;
    end;
  end;
end;

procedure TadxOlForm.ADXPostMessage(wParam, lParam: Cardinal);
begin
  SendMessageCluster(Handle, wParam, lParam);
end;

procedure TadxOlForm.DoInstanceFocused(focused: boolean);
var
  argsEnter: TadxOlEnterEventArgs;
  argsExit: TadxOlExitEventArgs;
begin
  try
    if focused then begin
      argsEnter:= TadxOlEnterEventArgs.Create;
      try
        DoAdxEnter(argsEnter)
      finally
        if Assigned(argsEnter) then begin
          FreeAndNil(argsEnter);
        end;
      end;
    end
    else begin
      argsExit:= TadxOlExitEventArgs.Create;
      try
        DoAdxExit(argsExit);
      finally
        if Assigned(argsExit) then begin
          FreeAndNil(argsExit);
        end;
      end;
    end;
  except
    on e: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.DoInstanceFocused: ' + e.Message);
    end;
  end;
end;

procedure TadxOlForm.DoReceiveAdxPostMessageCluster(msg: TMessage);
var
  wParam, lParam: Cardinal;
  postMessageArgs: TadxOlPostMessageReceivedEventArgs;
begin
  wParam := 0;
  lParam := 0;
  ReceiveMessageCluster(msg, wParam, lParam);
  postMessageArgs:= TadxOlPostMessageReceivedEventArgs.Create(wParam, lParam);
  try
    Log.AddMessage(ClassName+'.DoReceiveAdxPostMessageCluster');
    DoAdxPostMessage(postMessageArgs);
  finally
    if Assigned(postMessageArgs) then
      FreeAndNil(postMessageArgs);
  end;
end;

procedure TadxOlForm.WndProc(var Msg: TMessage);
var
  keyInfo: TadxKeyInfo;
  adxKeyFilterEventArgs: TadxOlKeyFilterEventArgs;
  
begin
  if not (csDesigning in self.ComponentState) then begin
    if msg.Msg = WM_ADXCOMMAND then begin
      try
        case msg.WParam of
          adxKeyFilter: begin
            msg.Result:= ord(faSendToHostApplication);

            keyInfo := PadxKeyInfo(Pointer(msg.LParam))^;
            adxKeyFilterEventArgs:= TadxOlKeyFilterEventArgs.Create(keyInfo);
            DoADXKeyFilter(adxKeyFilterEventArgs);
            msg.Result:= ord(adxKeyFilterEventArgs.Action);
            adxKeyFilterEventArgs.Destroy;
          end;
          adxActivateCompleteReplacement: begin
            Activate();
          end;
          adxPostMessageCmd: begin
            DoReceiveAdxPostMessageCluster(msg);
          end
          else
            inherited WndProc(Msg);
        end;
      except
        on e: SysUtils.Exception do begin
          TadxExceptionManager.ProcessADXXError(E, format('TadxOlForm.WndProc: Msg= WM_ADXCOMMAND wParam= %x lParam= %x : %s', [Msg.WParam, Msg.LParam, e.Message]));
        end;
      end;
    end
    else inherited WndProc(Msg);
  end
  else begin
    inherited WndProc(Msg);
  end;
end;

procedure TadxOlForm.UpdateAppWindowPropertyAfterBeforeFormShowEvent(
  AAppWindowProperty: Pointer);
var
  adxCaption: TadxCaption;
  {$IFDEF UNICODE}
  i: integer;
  {$ENDIF}
begin
  PAppWindowProperty(AAppWindowProperty)^.Splitter := ord(Item.Splitter);
  {$IFDEF UNICODE}
  for i := 0 to min(Length(Self.Caption), ADXCAPTION_SIZE) - 1   do begin
    adxCaption[i] := Self.Caption[i+1];
  end;
  adxCaption[min(Length(Self.Caption), ADXCAPTION_SIZE)] := #0;
  {$ELSE}
    StrPCopy(adxCaption,  Self.Caption);
  {$ENDIF}
  PAppWindowProperty(AAppWindowProperty)^.Caption := adxCaption;
end;

function TadxOlForm.UseOfficeThemeBackColor: boolean;
begin
  if Assigned(self.Item) then
    result:= self.Item.UseOfficeThemeForBackground
  else
    result:= false;
end;

procedure TadxOlForm.DoAdxNewInspector(
  args: TadxOlFormNewInspectorEventArgs);
var
  event: TadxEventRaising;
begin
  if Assigned(OnADXNewInspector) then begin
    try
      event := TadxEventRaising.Create('OnADXNewInspector', [eoLockRegionState]);
      try
        OnADXNewInspector(self, args);
      finally
        event.Free;
      end;
    except
      on E: SysUtils.Exception do begin
        TadxExceptionManager.ProcessADXXError(E, 'DoAdxNewInspector');
      end;
    end;
  end;
end;

procedure TadxOlForm.SetCaption(value: TCaption);
begin
  inherited SetCaption(value);
  if not (csDesigning in self.ComponentState) then begin
    SetHTMLDocumentTitle;
  end;
end;

procedure TadxOlForm.SetHTMLDocumentTitle;
begin
  if (self.Item <> nil) and (self.Item.ExplorerLayout = elWebViewPane)
    and (ExplorerObj <> nil) then begin
      try
        if IsWindowVisible(self.CurrentOutlookWindowHandle) then begin
          OLEVariant(ExplorerObj).HTMLDocument.Title := self.Caption;
        end;
      except
        on E: SysUtils.Exception do begin
          Log.AddWarning('TadxOlForm.SetHTMLDocumentTitle error:' + E.Message)
        end;
      end;
  end;
end;

function TadxOlForm.AdxLocalRegistryKey: string;
begin
  if (FormsManager <> nil) then begin
    result := FormsManager.AdxLocalRegistryKey;
  end
  else begin
    result := '';
  end;
end;

function TadxOlForm.GetDefaultRegionState: TadxInternalRegionState;
begin
  result:= irsNormal;
  if (not IsClientLayout) and Assigned(Item) then
    result := TadxInternalRegionState(ord(Item.DefaultRegionState) + 1);
end;

procedure TadxOlForm.SetDragForm(AItemType: TAdxItemType;
  ALayout: TadxWindowLayout);
var
  ExplorerLayout: TadxOlExplorerLayout;
  InspectorLayout: TadxOlInspectorLayout;
begin

  try
    if (self.ExplorerObj <> nil) then begin
      if (self.FormsManager.CheckExplorerAllowedDropRegion(self.Item, AItemType, ALayout, DragContextExplorerItemType)) then begin
        ExplorerLayout := FormsManager.GetExplorerLayout(AItemType, ALayout);
        if (self.Item.ExplorerLayout <> ExplorerLayout) then begin
          AdxLockWindowUpdate(self.CurrentOutlookWindowHandle);
          try
            self.Item.ExplorerLayout := ExplorerLayout;
            Self.Activate();
          finally
            AdxLockWindowUpdate(0);
          end;
        end;
      end;
    end;

    if (self.InspectorObj <> nil) then begin
      if (self.FormsManager.CheckInspectorAllowedDropRegion(self.Item, AItemType, ALayout, DragContextInspectorItemType, DragContextMailPostInspectorType)) then begin
        InspectorLayout := FormsManager.GetInspectorLayout(AItemType, ALayout);
{$IFDEF SUBSTINSPECTORREGION}
        if (IsSubstInspectorRegion()) then begin
          InspectorLayout := ilCompleteReplacement;
        end;
{$ENDIF}
        if (self.Item.InspectorLayout <> InspectorLayout) then begin
          LockWindowUpdate(self.CurrentOutlookWindowHandle);
          try
            self.Item.InspectorLayout := InspectorLayout;
            Self.Activate();
          finally
            LockWindowUpdate(0);
          end;
        end;
      end;
    end;

  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.GetDefaultRegionState');
    end;
  end;


end;

procedure TadxOlForm.SetDragItems(ADragItems: TList);
var
  ExplorerArguments: TadxOlExplorerArguments;
  InspectorArguments: TadxOlInspectorArguments;
begin
  try

    if not self.Visible then begin
      exit;
    end;
    if not self.Item.IsDragDropAllowed then begin
      exit;
    end;


    if (self.ExplorerObj <> nil) then begin
      if self.Item.ExplorerLayout = elWebViewPane then begin
        exit;
      end;

      ExplorerArguments := TadxOlExplorerArguments.Create(self.FormsManager, self.ExplorerObj, ccFolderEvent);
      try
        DragContextExplorerItemType := ExplorerArguments.ExplorerItemType;
        DragContextReadingPaneLayout := ExplorerArguments.ReadingPaneLayout;

        InternalSetDragItems(ADragItems, dwlBottom, erBottomNavigationPane);
        InternalSetDragItems(ADragItems, dwlBottom, erBottomOutlookBar);
        InternalSetDragItems(ADragItems, dwlBottom, erBottomTodoBar);

        if (FormsManager.IsContextSupport(elReadingPane,  ExplorerArguments)) then begin
          InternalSetDragItems(ADragItems, dwlAll, erReadingPane);
          InternalSetDragItems(ADragItems, dwlAll, erTopReadingPane);
          InternalSetDragItems(ADragItems, dwlAll, erBottomReadingPane);
          InternalSetDragItems(ADragItems, dwlAll, erLeftReadingPane);
          InternalSetDragItems(ADragItems, dwlAll, erRightReadingPane);
        end;

        InternalSetDragItems(ADragItems, dwlAll, erFolderView);
        InternalSetDragItems(ADragItems, dwlAll, erLeftSubpane);
        InternalSetDragItems(ADragItems, dwlAll, erRightSubpane);
        InternalSetDragItems(ADragItems, dwlAll, erTopSubpane);
        InternalSetDragItems(ADragItems, dwlAll, erBottomSubpane);

{$IFDEF DOCKEXPLORERLAYOUTS}
        if (FormsManager.IsContextSupport(elDockTop,  ExplorerArguments)) then begin
          InternalSetDragItems(ADragItems, dwlTop, erDockTop);
          InternalSetDragItems(ADragItems, dwlBottom, erDockBottom);
          InternalSetDragItems(ADragItems, dwlLeft, erDockLeft);
          InternalSetDragItems(ADragItems, dwlRight, erDockRight);
        end;
{$ENDIF}

      finally
        if (ExplorerArguments <> nil ) then begin
          ExplorerArguments.Free;
        end;
      end;
    end;

    if (self.InspectorObj <> nil) then begin
      InspectorArguments := TadxOlInspectorArguments.Create(self.FormsManager, self.InspectorObj, self.CurrentOutlookWindowHandle, ccNewInspector);
      try
        DragContextInspectorItemType := InspectorArguments.InspectorItemType;
        DragContextMailPostInspectorType := ord(InspectorArguments.MailPostInspectorType);
      finally
        if (InspectorArguments <> nil) then begin
          InspectorArguments.Free;
        end;
      end;

      InternalSetDragItems(ADragItems, dwlAll, irInspectorRegion);
      InternalSetDragItems(ADragItems, dwlAll, irBottomSubpane);
      InternalSetDragItems(ADragItems, dwlAll, irTopSubpane);
      InternalSetDragItems(ADragItems, dwlAll, irLeftSubpane);
      InternalSetDragItems(ADragItems, dwlAll, irRightSubpane);
    end;

  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.SetDragItems');
    end;
  end;


end;

procedure TadxOlForm.GetDragLayoutParams(var lParams: TadxDragLayoutParams);
var
  explorerLayout: TadxOlExplorerLayout;
  inspectorLayout: TadxOlInspectorLayout;
  injectedTaskPaneSize: integer;
begin
  try
    if (not self.Visible) then exit;

    if (self.ExplorerObj <> nil) then begin
      lParams.Disabled := not self.FormsManager.CheckExplorerAllowedDropRegion(self.Item, lParams.ItemType, lParams.Layout, DragContextExplorerItemType);
      explorerLayout := self.FormsManager.GetExplorerLayout(lParams.ItemType, lParams.Layout);
      injectedTaskPaneSize := GetSize(lParams.AppHandle, lParams.Layout);
      if (injectedTaskPaneSize > 0) then begin
        lParams.LayoutSize := injectedTaskPaneSize;
      end
      else begin
        lParams.LayoutSize := FormsManager.GetExplorerRegionSize(explorerLayout, DragContextExplorerItemType, DragContextReadingPaneLayout, lParams.ItemType);
      end;
    end;

    if (self.InspectorObj <> nil) then begin
      lParams.Disabled := not self.FormsManager.CheckInspectorAllowedDropRegion(self.Item, lParams.ItemType, lParams.Layout, DragContextInspectorItemType, DragContextMailPostInspectorType);
      inspectorLayout := FormsManager.GetInspectorLayout(lParams.ItemType, lParams.Layout);
{$IFDEF SUBSTINSPECTORREGION}
      if (IsSubstInspectorRegion()) then begin
          inspectorLayout := ilCompleteReplacement;
      end;
{$ENDIF}
      injectedTaskPaneSize := GetSize(lParams.AppHandle, lParams.Layout);
      if (injectedTaskPaneSize > 0) then begin
        lParams.LayoutSize := injectedTaskPaneSize;
      end
      else begin
        lParams.LayoutSize := FormsManager.GetInspectorRegionSize(inspectorLayout);
      end;

    end;

  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.GetDragLayoutParams');
    end;
  end;

end;

procedure TadxOlForm.InternalSetDragItems(ADragItems: TList;
  dragWindowLayouts: TadxDragWindowLayout;
  AllowedDropRegion: TadxOlExplorerAllowedDropRegion);
var
  itemType: TadxItemType;
  i: integer;
  ItemHandle: HWND;
  dragItem: PadxDragItemParams;
begin
  if (not IsContextSupportDropRegions(AllowedDropRegion)) then begin
    exit;
  end;

  if ((Item.ExplorerAllowedDropRegions * [AllowedDropRegion]) = [AllowedDropRegion]) then begin
    itemType := FormsManager.GetExplorerAllowedDropAdxItemType(AllowedDropRegion, DragContextExplorerItemType);
    for i := 0 to ADragItems.Count - 1 do begin
{$IFDEF DOCKEXPLORERLAYOUTS}
      case AllowedDropRegion of
        erDockTop,
        erDockBottom,
        erDockRight,
        erDockLeft:
        //Nothing
        ;
        else
          if PadxDragItemParams(ADragItems[i]).ItemType = itemType then begin
            exit;
          end;
      end;
{$ELSE}
          if PadxDragItemParams(ADragItems[i]).ItemType = itemType then begin
            exit;
          end;
{$ENDIF}

    end;

{$IFDEF DOCKEXPLORERLAYOUTS}
    case(AllowedDropRegion) of
        erDockTop,
        erDockBottom,
        erDockRight,
        erDockLeft:
          ItemHandle := FOutlookWindowHandle;
        else begin
          ItemHandle := (self.FormsManager.FOutlookHandleFinder as TOutlookHandleFinder)
            .GetAppWindowHandle(self.FormsManager.FOutlookVersion, itemType, self.CurrentOutlookWindowHandle);
        end;
    end;
{$ELSE}
          ItemHandle := (self.FormsManager.FOutlookHandleFinder as TOutlookHandleFinder)
            .GetAppWindowHandle(self.FormsManager.FOutlookVersion, itemType, self.CurrentOutlookWindowHandle);
{$ENDIF}


    if (ItemHandle > 0) then begin
      if (itemType = stOlTodoBar)
        or (itemType = stOlNavigationPane) then begin
          if (TVisibleMinimizeUnvisibleChangeWatchObject.OutlookWindowMinimizeSize(ItemHandle, FormsManager.FOutlookVersion, itemType)
          or (not IsWindowVisible(ItemHandle))) then begin
            Log.AddMessage('SetDragItems: OutlookWindowMinimizeSize');
            ItemHandle := 0;
          end;
      end;

      //Case 1453
      if (itemType = stOlReadingPane)
          and (not IsWindowVisible(ItemHandle)) then begin
            Log.AddMessage('SetDragItems: invisible stOlReadingPane');
            ItemHandle := 0;
      end;

      if (ItemHandle > 0) then begin
        GetMem(dragItem, sizeof(TadxDragItemParams));
        dragItem.Disabled := false;
        dragItem.DragLayout := dragWindowLayouts;
        dragItem.ItemType := itemType;
        dragItem.ItemHandle := ItemHandle;
        dragItem.Reserved := 0;
        ADragItems.Add(dragItem);
      end;
    end;
  end;
end;

procedure TadxOlForm.InternalSetDragItems(ADragItems: TList;
  dragWindowLayouts: TadxDragWindowLayout;
  AllowedDropRegion: TadxOlInspectorAllowedDropRegion);
var
  itemType: TadxItemType;
  i: integer;
  ItemHandle: HWND;
  dragItem: PadxDragItemParams;
begin
  if ((Item.InspectorAllowedDropRegions * [AllowedDropRegion]) = [AllowedDropRegion]) then begin
    itemType := FormsManager.GetInspectorAllowedDropAdxItemType(DragContextInspectorItemType, DragContextMailPostInspectorType);
    for i := 0 to ADragItems.Count - 1 do begin
      if PadxDragItemParams(ADragItems[i]).ItemType = itemType then begin
        exit;
      end;
    end;

    ItemHandle := self.FWindowHandle;
    if (self.FEmulateWindowHandle > 0) then begin
      ItemHandle := self.FEmulateWindowHandle;
    end;

    if (ItemHandle > 0) then begin
      GetMem(dragItem, sizeof(TadxDragItemParams));
      dragItem.Disabled := false;
      dragItem.DragLayout := dragWindowLayouts;
      dragItem.ItemType := itemType;
      dragItem.ItemHandle := ItemHandle;
      dragItem.Reserved := 0;
      ADragItems.Add(dragItem);
    end;
  end;
end;

class function TadxOlForm.GetExplorerLayoutKey(
  ExplorerLayout: TadxOlExplorerLayout;
  ExplorerItemType: TadxOlExplorerItemType;
  ReadingPaneLayout: TadxOlReadingPaneLayout): string;
var
  sExplorerItemType: string;
begin
  result := 'Explorer';

  sExplorerItemType := 'olUnknownItem'; //NET equivalent
  case ExplorerItemType of
    expMailItem: sExplorerItemType := 'olMailItem';
    expAppointmentItem: sExplorerItemType := 'olAppointmentItem';
    expTaskItem: sExplorerItemType := 'olTaskItem';
    expJournalItem: sExplorerItemType := 'olJournalItem';
    expNoteItem: sExplorerItemType := 'olNoteItem';
    expPostItem: sExplorerItemType := 'olPostItem';
    expDistributionListItem: sExplorerItemType := 'olDistributionListItem';
  end;

  result := result + sExplorerItemType;

  case ExplorerLayout of
      elUnknown:              result:= result + 'Unknown';
      elTopSubpane:           result:= result + 'TopSubpane';
      elBottomSubpane:        result:= result + 'BottomSubpane';
      elRightSubpane:         result:= result + 'RightSubpane';
      elWebViewPane:          result:= result + 'WebViewPane';
      elLeftSubpane:          result:= result + 'LeftSubpane';
      elBottomOutlookBar:     result:= result + 'BottomOutlookBar';
      elBottomNavigationPane: result:= result + 'BottomNavigationPane';
      elBottomTodoBar:        result:= result + 'BottomTodoBar';
  		elTopReadingPane:       result:= result + 'TopReadingPane';
	  	elBottomReadingPane:    result:= result + 'BottomReadingPane';
		  elLeftReadingPane:      result:= result + 'LeftReadingPane';
		  elRightReadingPane:     result:= result + 'RightReadingPane';
      elFolderView:           result:= result + 'FolderView';
      elReadingPane:          result:= result + 'ReadingPane';

{$IFDEF DOCKEXPLORERLAYOUTS}
      elDockTop:              result:= result + 'DockTop';
      elDockBottom:           result:= result + 'DockBottom';
      elDockRight:            result:= result + 'DockRight';
      elDockLeft:             result:= result + 'DockLeft';
{$ENDIF}
  end;

  if (
      ((ExplorerLayout = elRightSubpane)
      or (ExplorerLayout = elLeftSubpane))
      and (ReadingPaneLayout = rplRight)
      ) then begin
    result := result + 'WithReadingPane';
  end;

  if (
      ((ExplorerLayout = elTopSubpane)
      or (ExplorerLayout = elBottomSubpane))
      and (ReadingPaneLayout = rplBottom)
      ) then begin
    result := result + 'WithReadingPane';
  end;

end;

class function TadxOlForm.GetInspectorLayoutKey(
  InspectorLayout: TadxOlInspectorLayout): string;
begin
  case InspectorLayout of
      ilUnknown:             result:= 'InspectorUnknown';
      ilBottomSubpane:       result:= 'InspectorBottomSubpane';
      ilRightSubpane:        result:= 'InspectorRightSubpane';
      ilLeftSubpane:         result:= 'InspectorLeftSubpane';
      ilTopSubpane:          result:= 'InspectorTopSubpane';
      ilInspectorRegion:     result:= 'InspectorRegion';
  end;
end;

function TadxOlForm.IsDragDropAllowed: boolean;
begin
  try
   result := self.Item.IsDragDropAllowed;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.IsDragDropAllowed');
      result := false;
    end;
  end;

end;

function TadxOlForm.IsExpandFromMinimizedState: boolean;
begin
  try
    result := Item.RestoreFromMinimizedState;
  except
    on E: SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(E, 'TadxOlForm.IsExpandFromMinimizedState');
      result := false;
    end;
  end;
end;

procedure TadxOlForm.CheckWordMailInspectorUnderExplorer;
var
  activeExplorer: Explorer;
  ExplorerWindowHandle: HWND;
  currentForegroundWindow: HWND;
  InspectorUnderExplorer: boolean;
begin
  if (IsInspectorForm and IsWordMailInspectorForm) then begin
    activeExplorer := self.OutlookAppObj.ActiveExplorer();
    if (activeExplorer <> nil) then begin
      try
        ExplorerWindowHandle := GetExplorerWindowHandle(activeExplorer);
        currentForegroundWindow := GetForegroundWindow();
        if (self.CurrentOutlookWindowHandle = currentForegroundWindow) then begin
          InspectorUnderExplorer := TZOrderHelper.IsUnder(ExplorerWindowHandle, self.CurrentOutlookWindowHandle);
          if (InspectorUnderExplorer) then begin
            BringWindowToTop(self.CurrentOutlookWindowHandle);
          end;
        end;
      finally
        activeExplorer := nil;
      end;
    end;
  end;
end;

function TadxOlForm.GetIsWordMailInspectorForm: boolean;
begin
  result := FIsWordMailInspectorForm;
end;

function TadxOlForm.IsContextSupportDropRegions(
  AllowedDropRegion: TadxOlExplorerAllowedDropRegion): bool;
begin
  Log.AddMessage('IsContextSupportDropRegions');
  //Also see FormsManager.IsContextSupport

  if (FormsManager.OutlookVersion = v2010) then begin

      case AllowedDropRegion of
        erReadingPane,
        erLeftReadingPane,
        erRightReadingPane,
        erTopReadingPane,
        erBottomReadingPane: begin
{$IFDEF SupportAdjacentWindow}
          ;
{$ELSE}
          if (FormsManager.SocialConnectorAddinConnected) then begin
            result := false;
            exit;
          end;
{$ENDIF}
        end;
      end;

      if (expAppointmentItem = DragContextExplorerItemType) then begin
          case AllowedDropRegion of
            erFolderView,
            erLeftSubpane,
            erRightSubpane,
            erTopSubpane,
            erBottomSubpane: begin
              result := false;
              exit;
            end;
          end;
      end;
  end;
  result := true;
end;

procedure TadxOlForm.ActivateStandardPane;
//var
//  ServiceForm: TadxOlForm;
begin
  if (self.InClientLayout) then begin
    ActivateClientLayout;
//    if (self.InspectorObj <> nil) then begin
//      ServiceForm := FormsManager.GetInspectorServiceForm(self.CurrentOutlookWindowHandle);
//      if (ServiceForm <> nil) then begin
//        ServiceForm.Activate;
//      end;
//    end;
//
//    if (self.ExplorerObj <> nil) then begin
//      if (self.Item.ExplorerLayout = elFolderView) then begin
//        ServiceForm := FormsManager.GetSuperGridServiceForm(self.CurrentOutlookWindowHandle);
//        if (ServiceForm <> nil) then begin
//          ServiceForm.Activate;
//        end;
//      end;
//
//      if (self.Item.ExplorerLayout = elReadingPane) then begin
//        ServiceForm := FormsManager.GetReadingPaneServiceForm(self.CurrentOutlookWindowHandle);
//        if (ServiceForm <> nil) then begin
//          ServiceForm.Activate;
//        end;
//      end;
//    end;
  end;
end;

function TadxOlForm.InClientLayout: boolean;
begin
  result := false;
  if (self.Visible) then begin
    if (self.InspectorObj <> nil) and
      ((self.Item.InspectorLayout = ilInspectorRegion)
{$IFDEF SUBSTINSPECTORREGION}
      or (self.Item.InspectorLayout = ilCompleteReplacement)
{$ENDIF}
    )
    then begin
      result := true;
    end;
    if (self.ExplorerObj <> nil)
       and ((self.Item.ExplorerLayout = elReadingPane)
       or (self.Item.ExplorerLayout = elFolderView)) then begin
      result := true;
    end;
  end;
end;

procedure TadxOlForm.HideCTP(AExplorerlayout: TadxolExplorerLayout);
begin
{$IFDEF DOCKEXPLORERLAYOUTS}
  Log.AddMessage('TadxOlForm.HideCTP');
  try
    if Assigned(Item) then begin
      case (AExplorerLayout) of
        elDockBottom:
          FormsManager.HideCTP(dpDockBottom, self.ExplorerObj);
        elDockLeft:
          FormsManager.HideCTP(dpDockLeft, self.ExplorerObj);
        elDockRight:
          FormsManager.HideCTP(dpDockRight, self.ExplorerObj);
        elDockTop:
          FormsManager.HideCTP(dpDockTop, self.ExplorerObj);
      end;
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TadxOlForm.HideCTP ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TadxOlForm.HideCTP. ' + E.Message), 'HideCTP');
    end;
  end;
{$ENDIF}
end;

function TadxOlForm.IsSubstInspectorRegion: boolean;
begin
{$IFDEF SUBSTINSPECTORREGION}
  if Assigned(self.Item) and Assigned(self.InspectorObj) then
    result := (self.Item.InspectorLayout = ilCompleteReplacement)
  else
    result:= false;
{$ELSE}
  result := false;
{$ENDIF}
end;

{ TadxOlCompatibilityVersion1 }

class function TadxOlCompatibilityVersion1.CurrentForm(FormsManager: TadxOlFormsManager): TadxOlForm;
var
  ExplorerForm: TadxOlForm;
  InspectorForm: TadxOlForm;
begin
  result := nil;
  InspectorForm := GetInspectorForm(FormsManager) as TadxOlForm;
  if (InspectorForm <> nil) then begin
    result := InspectorForm;
    exit;
  end;

  ExplorerForm := GetExplorerForm(FormsManager) as TadxOlForm;
  if (ExplorerForm <> nil) then begin
    result := ExplorerForm;
    exit;
  end;
end;

class function TadxOlCompatibilityVersion1.FindItemByFolder(
  FormsManager: TadxOlFormsManager;
  FolderObj: MAPIFolder): TadxOlFormsCollectionItem;
var
  DefaultItemType: TOleEnum;
  FullFolderName: string;
  i, j: integer;
begin
  result := nil;
  try
    if (FolderObj = nil) then exit;

    DefaultItemType := TadxOlOutlookUtils(FormsManager.OutlookUtils).GetDefaultItemType(FolderObj);
    FullFolderName := EmptyStr;

    FullFolderName := TadxOlOutlookUtils(FormsManager.OutlookUtils).GetFullFolderName(FolderObj);

    if (FullFolderName <> EmptyStr) then begin
      for i := 0 to FormsManager.Items.Count - 1 do begin
        if (TadxOlCompatibilityVersion1.IsEnableForExplorer(FormsManager.Items[i])) then begin
          if Globals.CompareADXStrings(FormsManager.Items[i].FolderName, '*') then begin
            result := FormsManager.Items[i];
            break;
          end;
        end;
      end;

      for i := 0 to FormsManager.Items.Count - 1 do begin
        if (TadxOlCompatibilityVersion1.IsEnableForExplorer(FormsManager.Items[i])) then begin
          if GlobalsOl.CheckOlExplorerItemTypes(FormsManager.Items[i].ExplorerItemTypes, DefaultItemType) then begin
            result := FormsManager.Items[i];
            break;
          end;
        end;
      end;

      for i := 0 to FormsManager.Items.Count - 1 do begin
        if (TadxOlCompatibilityVersion1.IsEnableForExplorer(FormsManager.Items[i])) then begin
          if (FormsManager.Items[i].FolderNames.Count > 0) then
            for j := 0 to FormsManager.Items[i].FolderNames.Count - 1 do begin
              if Globals.CompareADXStrings(Globals.WithoutBackSlash(FormsManager.Items[i].FolderNames[j]), FullFolderName) then begin
                result := FormsManager.Items[i];
                break;
              end;
            end;
        end;
      end;

      for i := 0 to FormsManager.Items.Count - 1 do begin
        if (TadxOlCompatibilityVersion1.IsEnableForExplorer(FormsManager.Items[i])) then begin
          if Globals.CompareADXStrings(Globals.WithoutBackSlash(FormsManager.Items[i].FolderName), FullFolderName) then begin
            result := FormsManager.Items[i];
            break;
          end;
        end;
      end;

    end;
  finally
    //
  end;
end;

class function TadxOlCompatibilityVersion1.GetExplorerForm(
  FormsManager: TadxOlFormsManager): TadxOlForm;
var
  ItemFolderForm: TadxOlForm;
  ItemIndex, FormIndex: integer;
begin
  result := nil;
  for ItemIndex := 0 to FormsManager.Items.Count - 1 do begin
    for FormIndex := 0 to TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances).Count - 1 do begin
      if TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances)[FormIndex] <> nil then begin
        ItemFolderForm := TadxOlForm(TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances)[FormIndex]);
        if (ItemFolderForm.IsExplorerForm) and (ItemFolderForm.Visible) then begin
          result := ItemFolderForm;
          exit;
        end;
      end;
    end;
  end;
end;

class function TadxOlCompatibilityVersion1.GetInspectorForm(
  FormsManager: TadxOlFormsManager): TadxOlForm;
var
  ItemFolderForm: TadxOlForm;
  ItemIndex, FormIndex: integer;
begin
  result := nil;
  for ItemIndex := 0 to FormsManager.Items.Count - 1 do begin
    for FormIndex := 0 to TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances).Count - 1 do begin
      if TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances)[FormIndex] <> nil then begin
        ItemFolderForm := TadxOlForm(TadxOlFormsManagerList(FormsManager.Items[ItemIndex].FFormInstances)[FormIndex]);
        if (ItemFolderForm.IsInspectorForm) and (ItemFolderForm.Visible) then begin
          result := ItemFolderForm;
          exit;
        end;
      end;
    end;
  end;
end;

class function TadxOlCompatibilityVersion1.IsEnableForExplorer(
  Item: TadxOlFormsCollectionItem): boolean;
begin
  result := (Item.Enabled)
      and (Trim(Item.FormClassName) <> EmptyStr)
      and (Item.ExplorerLayout <> elUnknown)
      and (
          (Item.FolderName <> EmptyStr)
          or (Item.FolderNames.Count > 0)
          or (Item.ExplorerItemTypes <> [])
      );
end;

{ TWindowEventThread }

constructor TWatchEngine.CreateEx(AReceiverHandle: HWND);
begin
  Log.AddMessage('TWatchEngine.CreateEx');
  if Self.ThreadID > 0 then exit;

  FReceiverHandle := AReceiverHandle;

  FWatchObjects := TList.Create;

  Create(true);

  FreeOnTerminate:= false;
  Priority:=tpNormal;
end;


procedure TWatchEngine.DeleteByHostHandle(HostHandle: HWND);
begin
  Log.AddMessage('TWatchEngine.DeleteByHostHandle ' + IntToHex(HostHandle, 8));
  try
    if (WaitForSingleObject(FormsManagerSingleton.hClearWatchObjectsMutex, mutexWaiting) = WAIT_OBJECT_0) then begin
      Log.AddMessage('TWatchEngine.DeleteByHostHandle - begin');
      try
        SetLength(PrepareDeleteHandles, Length(PrepareDeleteHandles) + 1);
        PrepareDeleteHandles[Length(PrepareDeleteHandles) - 1] := HostHandle;
        Log.AddMessage('TWatchEngine.DeleteByHostHandle - end');
      finally
        ReleaseMutex(FormsManagerSingleton.hClearWatchObjectsMutex);
      end;
    end;
  except
    on E:SysUtils.Exception do begin
      Log.AddException('TWatchEngine.DeleteByHostHandle ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine.DeleteByHostHandle. ' + E.Message), 'InternalExecuteObjects');
    end;
  end;
end;

destructor TWatchEngine.Destroy;
var i: word;
begin
  if (FWatchObjects <> nil) then begin
    if FWatchObjects.Count > 0 then begin
      for i := 0 to FWatchObjects.Count-1 do begin
        TWatchObject(FWatchObjects.Items[i]).Free;
      end;
    end;

    if Assigned(FWatchObjects) then begin
      FWatchObjects.Free;
      FWatchObjects := nil;
    end;

  end;

  inherited Destroy;
end;

procedure TWatchEngine.Execute;
begin
  try
    while not Terminated do begin
      Run;
      Sleep(100);
    end;
    TDebug.WriteLine('TWatchEngine.Execute End Execute');
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine.Execute: ' + E.Message), 'TWatchEngine.Execute');
    end;
  end;
end;

{ TadxReceiverWindow }

procedure TadxReceiverWindow.AddReceiverCustomMessage(
  CustomWindowMessage: TCustomWindowMessage);
begin
  if (CustomWindowMessage <> nil) then begin
    inc(FCountCustomMessages);
    Log.AddMessage('TadxReceiverWindow.AddReceiverCustomMessage(' + CustomWindowMessage.ClassName + ')' + IntToStr(FCountCustomMessages));
    FCustomMessages.Add(CustomWindowMessage);
  end;
end;

constructor TadxReceiverWindow.CreateEx(AOwner: TComponent; ACaption: string);
begin
  FExecute := False;
  inherited CreateParented(GetDesktopWindow);

  FCountCustomMessages := 0;
  FCustomMessages := TList.Create;

  Caption := ACaption;

  TDebug.WriteLine('================ TadxReceiverWindow.CreateEx ' + Format('%x', [Handle]));
end;

destructor TadxReceiverWindow.Destroy;
begin
  TDebug.WriteLine('*** *** *** TadxReceiverWindow.Destroy');

  while FCustomMessages.Count > 0 do begin
    Log.AddMessage('TadxReceiverWindow.Destroy.FCustomMessages.Delete(' + TCustomWindowMessage(FCustomMessages.Items[0]).ClassName + ')' + IntToStr(FCountCustomMessages));
    dec(FCountCustomMessages);
    TCustomWindowMessage(FCustomMessages.Items[0]).Free;
    FCustomMessages.Items[0] := nil;
    FCustomMessages.Delete(0);
  end;

  if Assigned(FCustomMessages) then begin
    FCustomMessages.Free;
    FCustomMessages := nil;
  end;

  //FCustomMessages.Free;

  inherited;
end;


function TadxReceiverWindow.Exists(
  customWindowMessageType: TClass): boolean;
var
  i: integer;
begin
  for i := 0 to FCustomMessages.Count - 1 do begin
    if (TCustomWindowMessage(FCustomMessages[i]).ClassType = customWindowMessageType) then begin
      result := true;
      exit;
    end;
  end;
  result := false;
end;

function TadxReceiverWindow.RegisterMessage(Msg: Cardinal): boolean;
var
  index: integer;
begin
  result := false;

  if (FCustomMessages <> nil) then begin
    for index := 0 to FCustomMessages.Count - 1 do begin
      if (TCustomWindowMessage(FCustomMessages[index]).MessageID = Msg) then begin
        result := true;
        exit;
      end;
    end;
  end;
end;

procedure TadxReceiverWindow.SetExecute(const Value: boolean);
begin
  if Value then
    TDebug.WriteLine('*** TadxReceiverWindow.MainWndProc Execute BEGIN')
  else
    TDebug.WriteLine('*** TadxReceiverWindow.MainWndProc Execute END');

  FExecute := Value;
end;

procedure TadxReceiverWindow.WndProc(var Message: TMessage);
var
  index: integer;
begin
  if self.RegisterMessage(Message.Msg) then begin
    if Execute then begin
      Log.AddWarning('TadxReceiverWindow.WndProc Executing');
      Message.Result := 10;
      ReleaseMutex(FormsManagerSingleton.hMessageMutex);
      Log.AddMessage('<<<<<<<<<<<<<<<< SKIP');
      exit;
    end;

    index := 0;
    while (0 <= index) and (index < FCustomMessages.Count) do begin
      TDebug.WriteLine('*** *** *** TCustomWindowMessage(FCustomMessages.Items[index]).ClassName ' + IntToStr(index) + '/' + IntToStr(FCustomMessages.Count) );
      if (TCustomWindowMessage(FCustomMessages.Items[index]).MessageID = Message.Msg) then begin
        try
          Execute := true;
          TDebug.WriteLine('*** *** *** ' + TCustomWindowMessage(FCustomMessages.Items[index]).ClassName + '.' + 'PocessMessage');
          TCustomWindowMessage(FCustomMessages.Items[index]).DoProcessMessage(Message.WParam, Message.LParam);
        finally
          Execute := false;
        end;
      end;

      try
        //TDebug.WriteLine('*** *** *** Get TCustomWindowMessage(FCustomMessages.Items[index]).ClassName ' + IntToStr(index) + '/' + IntToStr(FCustomMessages.Count) );
        //CustomWindowMessageClass := TCustomWindowMessage(FCustomMessages.Items[index]).ClassName;
        //TDebug.WriteLine('*** *** *** ' + CustomWindowMessageClass);
        if TCustomWindowMessage(FCustomMessages.Items[index]).StopProcess then begin
          TDebug.WriteLine('*** *** *** StopProcess');
          TCustomWindowMessage(FCustomMessages[index]).Free;
          FCustomMessages[index] := nil;
          FCustomMessages.Delete(index);
        end
        else begin
          inc(index);
        end;
      except
        on E:SysUtils.Exception do begin
          ShowMessage('TadxReceiverWindow ' + E.Message);
        end;
      end;

    end;

  end
  else begin
      TDebug.WriteLine('Recieve > ANY ' + WndMesssageToString(Message.Msg) + '/' +  Format('%x', [Message.Msg]));
      inherited WndProc(Message);
      TDebug.WriteLine('Recieve < ANY ' + WndMesssageToString(Message.Msg) + '/' +  Format('%x', [Message.Msg]));
  end;
  TDebug.WriteLine('TadxReceiverWindow <<<<<<<<<<<<<');
end;

{ TadxOlRegisterInspectorList }

procedure TadxOlRegisterInspectorList.Delete(Index: Integer);
begin
  Log.AddMessage('TadxOlRegisterInspectorList.Delete');
  TadxOlInspector(self[index]).Free;
  inherited Delete(index);
end;


procedure TadxOlRegisterInspectorList.DeleteByInspectorWindowHandle(
  InspectorWindowHandle: HWND);
var
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlRegisterInspectorList.DeleteByInspectorWindowHandle');
  index := 0;
  counter := 0;
  while (0 <= index) and (index < Count) do begin
    if (TadxOlInspector(self[index]).FInspectorWindowHandle =  InspectorWindowHandle) then begin
      TDebug.WriteLine(' - Delete AdxOlInspector');
      Delete(index);
      Dec(index);
      Inc(counter);
    end;
    Inc(index);
  end;
  if (counter > 1) then begin
    Log.AddWarning('DeleteByInspectorWindowHandle: Unregister more one inspector');
    //TadxXExceptionManager.ProcessADXXError(SysUtils.Exception.Create('Unregister more one inspector'), 'DeleteByInspectorWindowHandle');
  end;
end;

{ TadxOlRegisterExplorerList }

procedure TadxOlRegisterExplorerList.Delete(Index: Integer);
var
  step: string;
begin
  Log.AddMessage('TadxOlRegisterExplorerList.Delete');
  Log.AddIndent;
  try
    try
      if (self[index] <> nil) then begin
        step := 'TadxOlExplorer(self[index]).Free';
        TadxOlExplorer(self[index]).Free;
        self[index] := nil;
      end;
      step := 'Delete(index)';
      inherited Delete(index);
    except
      on E:SysUtils.Exception do begin
        Log.AddException('TadxOlRegisterExplorerList.Delete ' + E.Message);
        raise E;
      end;
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TadxOlRegisterExplorerList.DeleteByExplorerWindowHandle(
  ExplorerWindowHandle: HWND);
var
  index: integer;
  counter: integer;
begin
  Log.AddMessage('TadxOlRegisterExplorerList.DeleteByExplorerWindowHandle: ' + IntToHex(ExplorerWindowHandle, 8) + ', count=' + IntToStr(Count) );
  Log.AddIndent;
  try
    index := 0;
    counter := 0;
    while (0 <= index) and (index < Count) do begin
      if (TadxOlExplorer(self[index]).FExplorerWindowHandle = ExplorerWindowHandle) then begin
        Delete(index);
        Dec(index);
        Inc(counter);
      end;
      Inc(index);
    end;
    if (counter > 1) then begin
      Log.AddWarning('Unregister more one explorer');
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('Unregister more one explorer'), 'DeleteByExplorerWindowHandle');
    end;
  finally
    Log.RemoveIndent;
  end;
end;

procedure TWatchEngine.Run;
begin
  try
    InternalExecuteObjects;
    InternalDeleteStoppedObjects;
    InternalProcessPrepareDeleteHandles;
  except
    on E:SysUtils.Exception do begin
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine.Run ' + E.Message), ' TWatchEngine.Run');
    end;
  end;
end;


{ TCustomWindowMessage }

constructor TCustomWindowMessage.Create(ReceiverHandle: HWND);
begin
  FSynchronize := true;
  FReceiverHandle := ReceiverHandle;
  StopProcess := false;
  RegisterMessage(GetMessageName());
end;

function TCustomWindowMessage.DoProcessMessage(wParam,
  lParam: integer): integer;
begin
  result := 0;
  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    try
      result := ProcessMessage(wParam, lParam);
      Log.AddMessage(self.ClassName + '.DoProcessMessage ' + IntToHex(wParam, 8) + ', ' + IntToHex(lParam, 8));
    finally
      ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    end;
    Log.AddMessage('<<<<<<<<<<<<<<<< Synchronize ' + self.ClassName);
    Log.AddMessage('');
  end
  else begin
    ProcessMessage(wParam, lParam);
    Log.AddMessage('<<<<<<<<<<<<<<<< ' + self.ClassName);
    Log.AddMessage('');
  end;
end;

function TCustomWindowMessage.GetMessageID: cardinal;
begin
  result := FMessageID;
end;

function TCustomWindowMessage.GetRegisterMessageName: string;
begin
  result := FRegisterMessageName;
end;

function TCustomWindowMessage.GetSynchronize: boolean;
begin
  result := FSynchronize and (FormsManagerSingleton.hMessageMutex <> 0);
end;

procedure TCustomWindowMessage.PostMessage(wParam, lParam: integer);
begin
  if FReceiverHandle = 0 then
    raise SysUtils.Exception.Create(self.ClassName +  '. ReceiverHandle shoud be define.');
  TDebug.WriteLine(self.ClassName + '.PostMessage(' + IntToHex(FReceiverHandle, 8)
  + ', ' + IntTostr(FMessageID)
  + ', ' + IntToHex(wParam, 8)
  + ', ' + IntTostr(lParam) + ')');

  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    Log.AddMessage('>>>>>>>>>>>>>>>> POST Synchronize ' + self.ClassName);
  end
  else begin
    Log.AddMessage('>>>>>>>>>>>>>>>> POST ' + self.ClassName);
  end;

  Windows.PostMessage(FReceiverHandle, FMessageID, wParam, lParam);
end;

procedure TCustomWindowMessage.RegisterMessage(AMessageName: string);
begin
  FRegisterMessageName := AMessageName;
  {$IFDEF UNICODE}
  FMessageID := Windows.RegisterWindowMessage(PChar(FRegisterMessageName));
  {$ELSE}
  FMessageID := Windows.RegisterWindowMessage(PAnsiChar(FRegisterMessageName));
  {$ENDIF}
end;

function TCustomWindowMessage.SendMessage(wParam,
  lParam: integer): integer;
begin
  if FReceiverHandle = 0 then
    raise SysUtils.Exception.Create(self.ClassName +  '. ReceiverHandle shoud be define.');
  TDebug.WriteLine(self.ClassName + '.SendMessage(' + IntToHex(FReceiverHandle, 8)
  + ', ' + IntTostr(FMessageID)
  + ', ' + IntToHex(wParam, 8)
  + ', ' + IntTostr(lParam) + ')');

  if (Synchronize) then begin
    WaitForSingleObject(FormsManagerSingleton.hMessageMutex, mutexWaiting);
    ReleaseMutex(FormsManagerSingleton.hMessageMutex);
    Log.AddMessage('>>>>>>>>>>>>>>>> SEND Synchronize ' + self.ClassName);
  end
  else begin
    Log.AddMessage('>>>>>>>>>>>>>>>> SEND ' + self.ClassName);
  end;

  result := Windows.SendMessage(FReceiverHandle, FMessageID, wParam, lParam);
end;

{ THideReadingPaneWindowMessage }

constructor THideReadingPaneWindowFromSBCLSMessage.Create(ReceiverHandle: HWND;
  Handler: THideReadingPaneWindow);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

destructor THideReadingPaneWindowFromSBCLSMessage.Destroy;
begin
  TDebug.WriteLine('*** THideReadingPaneWindowMessage.Destroy');
  FHandler := nil;
  inherited;
end;

function THideReadingPaneWindowFromSBCLSMessage.GetMessageName: string;
begin
  result := 'WM_ADX_READING_PANE_HIDE_FROM_SBCLS';//See adxWSbcls
end;

function THideReadingPaneWindowFromSBCLSMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage >>>');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create('THideReadingPaneWindowMessage: handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
  TDebug.WriteLine(self.ClassName + '.ProcessMessage <<<');
end;

function TCustomWindowMessage.SendMessageSync(wParam, lParam: integer;
  hSynchronizationMutex: THandle; WatchEngineIsHook: boolean): integer;
var
  waitRes: integer;
begin
  if (WatchEngineIsHook) then begin
    result := self.SendMessage(wParam, lParam);
    exit;
  end;

  if (hSynchronizationMutex = 0) then begin
    raise SysUtils.Exception.Create('hMutex is null');
  end
  else begin
    Log.AddMessage('{+' +self.ClassName + '.SendMessageSync');
    Log.AddIndent;
    try
      //Synchronization between WatchEngines
      waitRes := WaitForSingleObject(hSynchronizationMutex, 10000); //TODO !!! TimeOut
      if (waitRes = WAIT_OBJECT_0) then begin
        try
          result := SendMessage(wParam, lParam);
          exit;
        finally
          ReleaseMutex(hSynchronizationMutex);
        end;
      end
      else begin
        Log.AddWarning(self.ClassName + '.SendMessageSync.WaitForSingleObject <> WAIT_OBJECT_0');
        result := 0;
        exit;
      end;
    finally
      Log.RemoveIndent;
      Log.AddMessage('{-' +self.ClassName + '.SendMessageSync');
    end;
  end;

end;

{ TMoveReadingPaneWindowMessage }

constructor TMoveReadingPaneWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TMoveReadingPaneWindow);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

destructor TMoveReadingPaneWindowMessage.Destroy;
begin
  TDebug.WriteLine('*** TMoveReadingPaneWindowMessage.Destroy');
  FHandler := nil;
  inherited;
end;

function TMoveReadingPaneWindowMessage.GetMessageName: string;
begin
  result := 'WM_VCL_MoveReadingPaneWindowMessage';
end;

function TMoveReadingPaneWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ReadingPaneLayout: TadxOlReadingPaneLayout;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;

  ReadingPaneLayout := rplOff;
  if lParam = ord(rplRight) then ReadingPaneLayout := rplRight;
  if lParam = ord(rplBottom) then ReadingPaneLayout := rplBottom;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, stOlReadingPane, ReadingPaneLayout);
  end
  else begin
    raise SysUtils.Exception.Create('TMoveReadingPaneWindowMessage: handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;


{ TMoveReadingPaneWindowWatchObject }

constructor TMoveReadingPaneWindowWatchObject.Create(HostVersion: integer;
  ReceiverHandle: HWND; HostHandle,
  ReadingPaneWindowHandle: HWND;
  MsoDockTopWindowHandle: HWND);
begin
  inherited Create;
  FHostVersion := HostVersion;
  RightLayout := 7221;
  ButtonLayout := 7222;
  ReadingPaneLayout :=  rplOff;
  ReadingPaneLayoutInitialized := false;

  FMoveReadingPaneWindowMessage :=
    TMoveReadingPaneWindowMessage.Create(ReceiverHandle, nil);
  FHostHandle := HostHandle;
  FReadingPaneWindowHandle := ReadingPaneWindowHandle;
  FMsoDockTopWindowHandle := MsoDockTopWindowHandle;
  SetRedrawWindow := 0;
  ReadingPaneHandleThatGetWMSETREDRAW := 0;
end;

class function TMoveReadingPaneWindowWatchObject.CurrentLayout(HostVersion: integer; ReadingPaneWindowHandle: HWND; MsoDockTopWindowHandle: HWND): TadxOlReadingPaneLayout;
var
  readingPaneRect: TRect;
  MsoDockTopRect: TRect;
  parentWindow: integer;
  parentRect: TRect;
  HeightSubclassedADXOlForm: integer;
begin

  GetWindowRect(ReadingPaneWindowHandle, readingPaneRect);

  if (HostVersion < v2010) then begin
    parentWindow := GetParent(ReadingPaneWindowHandle);

    GetWindowRect(parentWindow, parentRect);

    if (parentWindow = 0) then begin
      result := rplOff;
      exit;
    end;

    if (Abs(readingPaneRect.Top - parentRect.Top) < 50) then begin
      result := rplRight;
      exit;
    end else begin
      result := rplBottom;
      exit;
    end;
  end
  else begin
    if (MsoDockTopWindowHandle = 0) then begin
      result := rplOff;
      exit;
    end;

    GetWindowRect(MsoDockTopWindowHandle, MsoDockTopRect);

    if not IsWindowVisibleSetRedraw(ReadingPaneWindowHandle, TMoveReadingPaneWindowWatchObject.GetSetRedrawWindow) then begin
      result := rplOff;
      exit;
    end;

    HeightSubclassedADXOlForm := GetSize(ReadingPaneWindowHandle, wlTop);
    if (HeightSubclassedADXOlForm < 0) then begin
      HeightSubclassedADXOlForm := 0;
    end;

    if ((Abs(readingPaneRect.Top - MsoDockTopRect.Bottom) - HeightSubclassedADXOlForm) < 20) then begin
      result := rplRight;
      exit;
    end else begin
      result := rplBottom;
      exit;
    end;

  end;
end;

destructor TMoveReadingPaneWindowWatchObject.Destroy;
begin
  if Assigned(FMoveReadingPaneWindowMessage) then begin
    FMoveReadingPaneWindowMessage.Free;
  end;
  inherited;
end;

procedure TMoveReadingPaneWindowWatchObject.DoExecute;
var
  CurrLayout: TadxOlReadingPaneLayout;
begin
  if ((not IsWindow(FReadingPaneWindowHandle))
      or (not IsWindowVisibleSetRedraw(FReadingPaneWindowHandle, TMoveReadingPaneWindowWatchObject.GetSetRedrawWindow))
      or EmptySize(FReadingPaneWindowHandle)) then begin
      StopWatch := true;
      exit;
  end;

  if (not ReadingPaneLayoutInitialized) then begin
    SetLayout();
    exit;
  end else begin
    CurrLayout := CurrentLayout(FHostVersion, FReadingPaneWindowHandle, FMsoDockTopWindowHandle);
    if (readingPaneLayout <> CurrLayout) and (CurrLayout <> rplOff) then begin
      FMoveReadingPaneWindowMessage.SendMessageSync(FHostHandle,  ord(CurrLayout), FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
      SetLayout();
    end;
  end;
end;

function TMoveReadingPaneWindowWatchObject.EmptySize(
  Handle: HWND): boolean;
var
  R: TRect;
begin
  if IsWindow(handle) then begin
    GetWindowRect(handle, R);
    result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
  end else begin
    result := true;
  end;
end;

procedure TMoveReadingPaneWindowWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = ReadingPaneHandleThatGetWMSETREDRAW) then begin
        ReadingPaneHandleThatGetWMSETREDRAW := 0;
        SetRedrawWindow := 0;
        Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

class function TMoveReadingPaneWindowWatchObject.GetSetRedrawWindow: HWND;
begin
  result := TMoveReadingPaneWindowWatchObject_SetRedrawWindow;
end;

procedure TMoveReadingPaneWindowWatchObject.SetLayout;
begin
  readingPaneLayout := CurrentLayout(FHostVersion, FReadingPaneWindowHandle, FMsoDockTopWindowHandle);
  ReadingPaneLayoutInitialized := true;
end;

class procedure TMoveReadingPaneWindowWatchObject.SetSetRedrawWindow(
  window: HWND);
begin
 TMoveReadingPaneWindowWatchObject_SetRedrawWindow := window;
end;

procedure TMoveReadingPaneWindowWatchObject.START_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    //Related to Utils.GetAppWindowHandle
    //{
    //    Result = FindWindowFromPath(FHostHandle, @"rctrl_renwnd32\AfxWndW\", ref FW, true);
    //}
    if (SetRedrawWindow = 0) then begin
        ReadingPaneHandleThatGetWMSETREDRAW := GetParent(self.WindowHandle);
        if (window = ReadingPaneHandleThatGetWMSETREDRAW) then begin
          SetRedrawWindow := self.FReadingPaneWindowHandle;
          Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
        end;

    end;
  end;
end;

{ TShowChildWindowMessage }

constructor TShowChildWindowMessage.Create(ReceiverHandle: HWND;
  HostHandle: HWND;
  Handler: TShowChildWindow);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
  self.FHostHandle := HostHandle;
end;

destructor TShowChildWindowMessage.Destroy;
begin
  FHandler := nil;
  inherited;
end;

function TShowChildWindowMessage.GetMessageName: string;
begin
  result := 'WM_VCL_ShowChildWindowMessage';
end;

function TShowChildWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
  ThisMessageForThisObject: boolean;
begin
  HostHandle := wParam;
  ItemType := lParam;
  ThisMessageForThisObject := (FHostHandle = HostHandle);

  if (ThisMessageForThisObject) then begin
    if Assigned(FHandler) then begin
      FHandler(HostHandle, ItemType);
    end
    else begin
      raise SysUtils.Exception.Create('TShowChildWindowMessage: handler does not set');
    end;
    StopProcess := true;
  end;
  result := 0;
end;

{ TShowChildWindowWatchObject }

constructor TShowChildWindowWatchObject.Create(HandleFinder: TOutlookHandleFinder;
  ReceiverHandle: HWND; HostHandle: HWND;
  HostVersion, ItemType: integer;
  AMakePostMessage: boolean);
begin
  FHandleFinder := HandleFinder;
  FShowChildWindowMessage := TShowChildWindowMessage.Create(ReceiverHandle, HostHandle, nil);
  FHostHandle := HostHandle;
  FHostVersion := HostVersion;
  FItemType := ItemType;

  FRequiredWindowHandle := 0 ;
  FVisibleState := vsUnknown;
  FInitialVisibleState := vsUnknown;
  MakePostMessage := AMakePostMessage;
end;

destructor TShowChildWindowWatchObject.Destroy;
begin
  if Assigned(FShowChildWindowMessage) then begin
    FShowChildWindowMessage.Free;
  end;
  FHandleFinder := nil;
  inherited;
end;

procedure TShowChildWindowWatchObject.DoExecute;
var
  res: integer;
begin
  FRequiredWindowHandle := FHandleFinder.GetAppWindowHandle(FHostVersion,
    FItemType, FHostHandle);

  if (FRequiredWindowHandle <> 0) then begin
      if ((not EmptySize(FRequiredWindowHandle))
          and IsWindowVisible(FRequiredWindowHandle)
          and IsWindowVisible(FHostHandle)) then begin
          FVisibleState := vsVisible;
      end else begin
          FVisibleState := vsUnvisible;
      end;

      if (FVisibleState = vsVisible) then begin
        if MakePostMessage then begin
          Log.AddMessage('TShowChildWindowWatchObject.DoExecute.PostMessage');
          FShowChildWindowMessage.PostMessage(FHostHandle, FItemType);
          res := 0;
        end else begin
          Log.AddMessage('TShowChildWindowWatchObject.DoExecute.SendMessage');
          res := FShowChildWindowMessage.SendMessageSync(FHostHandle, FItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
        end;

        if (res = 0) then begin
            StopWatch := true;
        end else begin
            FVisibleState := vsUnvisible;
        end;
      end;
  end;
end;

function TShowChildWindowWatchObject.EmptySize(Handle: HWND): boolean;
var
  R: TRect;
begin
  if IsWindow(handle) then begin
    GetWindowRect(handle, R);
    result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
  end else begin
    result := true;
  end;
end;

procedure TShowChildWindowWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //
end;

procedure TShowChildWindowWatchObject.START_WM_SETREDRAW(window: HWND);
begin
  //
end;

{ TOutlookHandleFinder }

function TOutlookHandleFinder.GetAppWindowHandle(HostVersion,
  ItemType: integer; HostHandle: HWND): HWND;
begin
  result := adxWSbcls.GetAppWindowHandle(HostVersion, ItemType, HostHandle);
end;

procedure TWatchEngine.Add(WatchObject: TWatchObject);
begin
  try
    if (WatchObject <> nil) then begin
      if (WaitForSingleObject(FormsManagerSingleton.hClearWatchObjectsMutex, mutexWaiting) = WAIT_OBJECT_0) then begin
        Log.AddMessage('TWatchEngine.Add - begin ' + WatchObject.ClassName);
        try
          FWatchObjects.Add(watchObject);
          Log.AddMessage('TWatchEngine.Add - end');
        finally
          ReleaseMutex(FormsManagerSingleton.hClearWatchObjectsMutex);
        end;
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TWatchEngine.Add: ' + E.Message);
      raise E;
    end;
  end;
end;

function TOutlookHandleFinder.GetMsoDockTopWindowHandle(
  HostVersion: integer; HostHandle: HWND): HWND;
begin
  result := adxWSbcls.FindChildWindow(HostHandle, 'MsoDockTop', 'MsoCommandBarDock', '', false);
end;

{ TadxOlReadingPaneMoveEventArgs }

constructor TadxOlReadingPaneMoveEventArgs.Create(
  AReadingPaneLayout: TadxOlReadingPaneLayout);
begin
  FReadingPaneLayout := AReadingPaneLayout;
end;


{ TadxOlReadingPaneShowEventArgs }

constructor TadxOlReadingPaneShowEventArgs.Create(
  AReadingPaneLayout: TadxOlReadingPaneLayout);
begin
  FReadingPaneLayout := AReadingPaneLayout;
end;

{ TShowNavigationPaneMessage }

function TShowNavigationPaneMessage.GetMessageName: string;
begin
  result := 'WM_ADX_NAVIGATION_PANE_SHOW';
end;

{ THideNavigationPaneMessage }

function THideNavigationPaneMessage.GetMessageName: string;
begin
  result := 'WM_ADX_NAVIGATION_PANE_HIDE';
end;

{ TVisibleChangeWindowMessage }

constructor TVisibleChangeWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TVisibleChangeWindow);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

destructor TVisibleChangeWindowMessage.Destroy;
begin
  TDebug.WriteLine(self.ClassName + '.Destroy');
  FHandler := nil;
  inherited;
end;

function TVisibleChangeWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;

{ TVisibleChangeWindowWatchObject }

constructor TVisibleChangeWindowWatchObject.Create(AHandleFinder: TOutlookHandleFinder;
  AShowWindowMessage, AHideWindowMessage: TVisibleChangeWindowMessage;
  AHostHandle: HWND; AItemType: Integer; AHostVersion: Integer);
begin
  inherited Create;
  FHandleFinder := AHandleFinder;
  FShowWindowMessage := AShowWindowMessage;
  FHideWindowMessage := AHideWindowMessage;
  FHostHandle := AHostHandle;
  ItemType := AItemType;
  HostVersion := AHostVersion;

  WindowHandle := 0;
  FindCount := 0;
  VisibleState := vsUnknown;
  SetRedrawWindow := 0;
end;

destructor TVisibleChangeWindowWatchObject.Destroy;
begin
  FHandleFinder := nil;
  FShowWindowMessage.Free;
  FShowWindowMessage := nil;
  FHideWindowMessage.Free;
  FHideWindowMessage := nil;
  inherited;
end;

procedure TVisibleChangeWindowWatchObject.DoExecute;
var
  VisibleStateChanged: boolean;
  ExistsHostHandle: boolean;
  InitialVisibleState: TVisibleState;
  CurrentVisibleState: TVisibleState;
  res: integer;
begin
  //TDebug.WriteLine(self.ClassName + '.DoExecute');
  ExistsHostHandle := IsWindow(HostHandle);
  //and IsWindowVisible(HostHandle)); //- Outlook minimize

  if (not ExistsHostHandle) then begin
    StopWatch := true;
    exit;
  end;

  InitialVisibleState := VisibleState;

  if NeedFindHandle(WindowHandle, VisibleState, HostVersion) then begin
    WindowHandle := FHandleFinder.GetAppWindowHandle(HostVersion,
      ItemType, HostHandle);
    if (VisibleState = vsVisible) and (WindowHandle = 0) then begin
      SendHideMessageSync(HostHandle, ItemType);
    end;
    VisibleState := vsUnknown;
  end;

  if (WindowHandle > 0) then begin

    SetVisibleState(CurrentVisibleState, WindowHandle, HostHandle, HostVersion, ItemType);
    VisibleStateChanged := (VisibleState <> CurrentVisibleState);

    if VisibleStateChanged then begin
      case CurrentVisibleState of
        vsVisible: begin
          res := SendShowMessageSync(HostHandle, ItemType);
          if res = 0 then begin
            VisibleState := CurrentVisibleState;
          end;
        end;
        vsUnvisible: begin
          if InitialVisibleState = vsVisible then begin
            res := SendHideMessageSync(HostHandle, ItemType);
            if res = 0 then begin
              VisibleState := CurrentVisibleState;
            end;
          end;
        end;
      end;
    end
  end;
end;

function TVisibleChangeWindowWatchObject.EmptySize(AWindowHandle: HWND;
  AHostVersion: integer; AItemType: integer): boolean;
begin
  result := OutlookWindowEmptySize(AWindowHandle, AHostVersion, AItemType);
end;

function TVisibleChangeWindowWatchObject.NeedFindHandle(
  AWindowHandle: HWND;
  AVisibleState: TVisibleState;
  AHostVersion: Integer): boolean;
begin
  result := ((AVisibleState = vsUnknown)
  or ((AHostVersion = v2000) and (AVisibleState = vsUnvisible)))
  or (not IsWindow(AWindowHandle));
end;

function TVisibleChangeWindowWatchObject.GetVisibleState(AWindowHandle,
  AHostHandle: HWND; AHostVersion: Integer; AItemType: integer): TVisibleState;
begin
  if (not EmptySize(AWindowHandle, AHostVersion, AItemType))
    and IsWindowVisibleSetRedraw(AWindowHandle, SetRedrawWindow)
    and IsWindowVisible(AHostHandle)  then begin
    result := vsVisible;
  end
  else begin
    result := vsUnvisible;
  end;
end;

class function TVisibleChangeWindowWatchObject.OutlookWindowEmptySize(
  AWindowHandle: HWND; AHostVersion, AItemType: integer): boolean;
var
  HideState: boolean;
  R: TRect;
begin
  if IsWindow(AWindowHandle) then begin
    GetWindowRect(AWindowHandle, R);
    //result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
    result := ((R.Right - R.Left) <= 0) or ((R.Bottom - R.Top) <= 0);
    if (AHostVersion = v2007)
      or (AHostVersion = v2010) then begin
      case AItemType of
        stOlTodoBar,
        stOlNavigationPane: begin
          HideState := (R.Right - R.Left <= 50);
          result := result or HideState;
        end;
      end;
    end;
  end
  else begin
    result := true;
  end;

  if (result) then begin
    result := result and TVisibleChangeWindowWatchObject.SubclassedEmptySize(AWindowHandle, result);
  end;

end;

procedure TVisibleChangeWindowWatchObject.SetVisibleState(
  var CurrentVisibleState: TVisibleState; AWindowHandle, AHostHandle: HWND;
  AHostVersion, AItemType: integer);
begin
  CurrentVisibleState := GetVisibleState(AWindowHandle, AHostHandle, AHostVersion, AItemType);
end;

function TVisibleChangeWindowWatchObject.SendHideMessageSync(
  wParam, lParam: integer): integer;
begin
  if (IsWindowVisible(HostHandle)) then begin
    result := FHideWindowMessage.SendMessageSync(wParam, lParam, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
  end
  else begin
    result := FHideWindowMessage.SendMessage(wParam, lParam);
  end;
end;

function TVisibleChangeWindowWatchObject.SendShowMessageSync(
  wParam, lParam: integer): integer;
begin
  result := FShowWindowMessage.SendMessageSync(wParam, lParam, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
end;

class function TVisibleChangeWindowWatchObject.SubclassedEmptySize(
  windowHandle: HWND; currentState: boolean): boolean;
var
  Pos: TWindowPos;
begin
  if Globals.adxMessageResultValue = SendMessage(windowHandle, WM_ADXGETAPPWINDOWPOS, 0, Cardinal(@Pos)) then begin
    result := (Pos.cx = 0) or (Pos.cy = 0);
  end
  else begin
    result := currentState;
  end;
end;

procedure TVisibleChangeWindowWatchObject.ProcessHookEvent(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer);
begin
  case Msg of
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED,
    WM_EXITSIZEMOVE:
    //WM_SETREDRAW: This is necessary if we want to hide/show a form when a Outlook 2010 window is resized.
    DoExecute;
  end;
end;


{ TShowOutlookBarMessage }

function TShowOutlookBarMessage.GetMessageName: string;
begin
  result := 'WM_ADX_OUTLOOK_BAR_SHOW';
end;

{ THideOutlookBarMessage }

function THideOutlookBarMessage.GetMessageName: string;
begin
  result := 'WM_ADX_OUTLOOK_BAR_HIDE';
end;

{ TShowFolderListMessage }

function TShowFolderListMessage.GetMessageName: string;
begin
  result := 'WM_ADX_FOLDER_LIST_SHOW';
end;

{ THideFolderListMessage }

function THideFolderListMessage.GetMessageName: string;
begin
  result := 'WM_ADX_FOLDER_LIST_HIDE';
end;

{ TShowReadingPaneMessage }

function TShowReadingPaneMessage.GetMessageName: string;
begin
  result := 'WM_ADX_READING_PANE_SHOW';
end;

{ THideReadingPaneMessage }

function THideReadingPaneMessage.GetMessageName: string;
begin
  result := 'WM_ADX_READING_PANE_HIDE';
end;

{ TadxOlNavigationPaneHideEventArgs }

constructor TadxOlNavigationPaneHideEventArgs.Create(AOutlookBar: boolean);
begin
  inherited Create;
  FOutlookBar := AOutlookBar;
end;


{ TadxOlNavigationPaneShowEventArgs }

constructor TadxOlNavigationPaneShowEventArgs.Create(AOutlookBar: boolean);
begin
  inherited Create;
  FOutlookBar := AOutlookBar;
end;

{ TShowTodoBarMessage }

function TShowTodoBarMessage.GetMessageName: string;
begin
  result := 'WM_ADX_TODO_BAR_SHOW';
end;

{ THideTodoBarMessage }

function THideTodoBarMessage.GetMessageName: string;
begin
  result := 'WM_ADX_TODO_BAR_HIDE';
end;

{ TVisibleMinimizeUnvisibleChangeWatchObject }

constructor TVisibleMinimizeUnvisibleChangeWatchObject.Create(
  AHandleFinder: TOutlookHandleFinder; AShowWindowMessage, AHideWindowMessage,
  AMinimizeWindowMessage: TVisibleChangeWindowMessage; AHostHandle: HWND;
  AItemType, AHostVersion: Integer);
begin
  inherited Create;
  SetRedrawWindow := 0;
  FHost2010WasShowed := false;
  FHandleFinder := AHandleFinder;
  FShowWindowMessage := AShowWindowMessage;
  FHideWindowMessage := AHideWindowMessage;
  FMinimizeWindowMessage := AMinimizeWindowMessage;
  FHostHandle := AHostHandle;
  ItemType := AItemType;
  HostVersion := AHostVersion;

  WindowHandle := 0;
  FindCount := 0;
  VisibleState := vsUnknown;
end;

destructor TVisibleMinimizeUnvisibleChangeWatchObject.Destroy;
begin
  FHandleFinder := nil;
  FShowWindowMessage.Free;
  FShowWindowMessage := nil;
  FHideWindowMessage.Free;
  FHideWindowMessage := nil;
  FMinimizeWindowMessage.Free;
  FMinimizeWindowMessage := nil;
  inherited;
end;

procedure TVisibleMinimizeUnvisibleChangeWatchObject.DoExecute;
var
  VisibleStateChanged: boolean;
  InitialVisibleState: TVisibleState;
  CurrentVisibleState: TVisibleState;
  res: integer;
begin
  //TDebug.WriteLine(self.ClassName + '.DoExecute');

  if (not ExistsHostHandle) then begin
    StopWatch := true;
    exit;
  end;

  InitialVisibleState := VisibleState;

  if NeedFindHandle(WindowHandle, VisibleState, HostVersion) then begin
    WindowHandle := FHandleFinder.GetAppWindowHandle(HostVersion,
      ItemType, HostHandle);
    if (VisibleState = vsVisible) and (WindowHandle = 0) then begin
      SendHideMessageSync(HostHandle, ItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
    end;
    VisibleState := vsUnknown;
  end;

  if (WindowHandle > 0) then begin

    CurrentVisibleState := GetVisibleState(WindowHandle, HostHandle, HostVersion, ItemType);
    VisibleStateChanged := (VisibleState <> CurrentVisibleState);

    if VisibleStateChanged then begin
      case CurrentVisibleState of
        vsMinimize: begin
          res := SendMinimizeMessageSync(HostHandle, ItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
          if res = 0 then begin
            VisibleState := CurrentVisibleState;
          end;
        end;
        vsVisible: begin
          TDebug.WriteLine(Log.AddinName + '@@@ FShowWindowMessage.' + self.ClassName);
          res := SendShowMessageSync(HostHandle, ItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
          if res = 0 then begin
            VisibleState := CurrentVisibleState;
          end;
        end;
        vsUnvisible: begin
          if (InitialVisibleState = vsVisible) or (InitialVisibleState = vsMinimize) then begin
            res := SendHideMessageSync(HostHandle, ItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
            if res = 0 then begin
              VisibleState := CurrentVisibleState;
            end;
          end;
        end;
      end;
    end
  end;
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.ExistsHostHandle: boolean;
begin
  if (not FHost2010WasShowed) then begin
    FHost2010WasShowed := IsWindow(HostHandle) and IsWindowVisible(HostHandle);
  end;

  case (HostVersion) of
    v2000,
    v2002,
    v2003,
    v2007: begin
      result := (IsWindow(HostHandle) and IsWindowVisible(HostHandle));
    end;
    v2010: begin
      result := (IsWindow(HostHandle) and (not FHost2010WasShowed or IsWindowVisible(HostHandle)));
    end;
    else raise SysUtils.Exception.Create('Unknown Host Version');
  end;
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.GetVisibleState(
  AWindowHandle, AHostHandle: HWND; AHostVersion,
  AItemType: integer): TVisibleState;
begin
  if (not OutlookWindowEmptySize(AWindowHandle, AHostVersion, AItemType))
    and IsWindowVisibleSetRedraw(AWindowHandle, SetRedrawWindow)
    and IsWindowVisible(AHostHandle)  then begin

    if OutlookWindowMinimizeSize(AWindowHandle, AHostVersion, AItemType) then begin
      result := vsMinimize;
    end
    else begin
      result := vsVisible;
    end;
  end
  else begin
    result := vsUnvisible;
  end;
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.NeedFindHandle(
  AWindowHandle: HWND; AVisibleState: TVisibleState;
  AHostVersion: Integer): boolean;
begin
  result := ((AVisibleState = vsUnknown)
  or ((AHostVersion = v2000) and (AVisibleState = vsUnvisible)))
  or (not IsWindow(AWindowHandle));
end;

class function TVisibleMinimizeUnvisibleChangeWatchObject.OutlookWindowEmptySize(
  AWindowHandle: HWND; AHostVersion, AItemType: integer): boolean;
var
  R: TRect;
begin
  if IsWindow(AWindowHandle) then begin
    GetWindowRect(AWindowHandle, R);
    result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
  end
  else begin
    result := true;
  end;
end;

class function TVisibleMinimizeUnvisibleChangeWatchObject.OutlookWindowMinimizeSize(
  AWindowHandle: HWND; AHostVersion, AItemType: integer): boolean;
var
  VerticalHideState: boolean;
  R: TRect;
begin
  if (AHostVersion <> v2007)
   and (AHostVersion <> v2010) then begin
    result := false;
    exit;
  end;

  if IsWindow(AWindowHandle) then begin
    GetWindowRect(AWindowHandle, R);
    VerticalHideState := ((0 < (R.Right - R.Left)) and ((R.Right - R.Left) <= 50));
    result := VerticalHideState;
  end
  else begin
    result := false;
  end;
end;

procedure TVisibleMinimizeUnvisibleChangeWatchObject.ProcessHookEvent(
  hWnd: THandle; Msg: UINT; wParam, lParam: Integer);
begin
  case Msg of
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED,
    WM_EXITSIZEMOVE:
    //WM_SETREDRAW: This is necessary if we want to hide/show a form when a Outlook 2010 window is resized.
    DoExecute;
  end;
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendHideMessage(wParam,
  lParam: integer): integer;
begin
  if (IsWindowVisible(HostHandle)) then begin
    result := FShowWindowMessage.SendMessageSync(wParam, lParam, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
  end
  else begin
    result := FShowWindowMessage.SendMessage(wParam, lParam);
  end;
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendHideMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
begin
  result := FHideWindowMessage.SendMessageSync(wParam, lParam, hSynchronizationMutex, WatchEngineIsHook);
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendMinimizeMessage(
  wParam, lParam: integer): integer;
begin
  result := FMinimizeWindowMessage.SendMessageSync(wParam, lParam, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendMinimizeMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
begin
  result := FMinimizeWindowMessage.SendMessageSync(wParam, lParam, hSynchronizationMutex, WatchEngineIsHook);
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendShowMessage(wParam,
  lParam: integer): integer;
begin
  result := FShowWindowMessage.SendMessageSync(wParam, lParam, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
end;

function TVisibleMinimizeUnvisibleChangeWatchObject.SendShowMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
begin
  result := FShowWindowMessage.SendMessageSync(wParam, lParam, hSynchronizationMutex, WatchEngineIsHook);
end;


{ TMinimizeTodoBarMessage }

function TMinimizeTodoBarMessage.GetMessageName: string;
begin
  result := 'WM_ADX_TODO_BAR_MINIMIZE';
end;

{ TMinimizeNavigationPaneMessage }

function TMinimizeNavigationPaneMessage.GetMessageName: string;
begin
  result := 'WM_ADX_NAVIGATION_PANE_MINIMIZE';
end;


{ TBeforeFormInstanceCreateEventArgs }

constructor TBeforeFormInstanceCreateEventArgs.Create(
  AItem: TadxOlFormsCollectionItem; AExplorerObj: Explorer;
  AExplorerArgs: TObject);
begin
  Log.AddMessage('TBeforeFormInstanceCreateEventArgs.Create 1');
  self.Cancel := False;
	self.FItem := AItem;
  self.FInspectorObj := nil;
  self.FExplorerObj := AExplorerObj;
  self.FFolderObj := TADXOlExplorerArguments(AExplorerArgs).FolderObj;
end;

constructor TBeforeFormInstanceCreateEventArgs.Create(
  AItem: TadxOlFormsCollectionItem; AInspectorObj: Inspector;
  AInspectorArgs: TObject);
begin
  Log.AddMessage('TBeforeFormInstanceCreateEventArgs.Create 2');
  self.Cancel := False;
	self.FItem := AItem;
  self.FInspectorObj := AInspectorObj;
  self.FExplorerObj := nil;
  self.FFolderObj := nil;
end;

destructor TBeforeFormInstanceCreateEventArgs.Destroy;
begin
  self.FInspectorObj := nil;
  self.FExplorerObj := nil;
  self.FFolderObj := nil;
end;

{ TDestroyEmbededWindowMessage }

constructor TDestroyEmbededWindowMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TDestroyEmbededWindowMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TDestroyEmbededWindowMessage.GetMessageName: string;
begin
  result := 'WM_ADX_DESTROY_EMBEDED_WINDOW';
end;

function TDestroyEmbededWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
begin
  if (FFormsManager <> nil) then begin
    FFormsManager.DoDestroyEmbededWindow(wParam, lParam);
    result := 0;
  end else begin
    result := 0;
  end;
end;


{ TadxOlErrorEventArgs }

constructor TadxOlErrorEventArgs.Create(AE: SySUtils.Exception);
begin
  FE := AE;
  FHandled := false;
end;


destructor TadxOlErrorEventArgs.Destroy;
begin
  FE := nil;
  inherited;
end;

procedure TadxOlErrorEventArgs.SetHandled(const Value: boolean);
begin
  FHandled := Value;
end;

{ TShowChildWindowWatchObjectInAnyMailInspector }

constructor TShowChildWindowWatchObjectInAnyMailInspector.Create(
  HandleFinder: TOutlookHandleFinder; ReceiverHandle, HostHandle: HWND;
  HostVersion: integer);
begin
  FHandleFinder := HandleFinder;
  FShowChildWindowMessage := TShowChildWindowMessage.Create(ReceiverHandle, HostHandle, nil);
  FHostHandle := HostHandle;
  FHostVersion := HostVersion;
  FItemType := 0;

  FRequiredWindowHandle := 0 ;
  FVisibleState := vsUnknown;
  FInitialVisibleState := vsUnknown;
  MakePostMessage := false;
end;

destructor TShowChildWindowWatchObjectInAnyMailInspector.Destroy;
begin
  if Assigned(FShowChildWindowMessage) then begin
    FShowChildWindowMessage.Free;
  end;
  FHandleFinder := nil;
  inherited;
end;

procedure TShowChildWindowWatchObjectInAnyMailInspector.DoExecute;
var
  res: integer;
begin
  FRequiredWindowHandle := 0;

  if (FRequiredWindowHandle = 0) then begin
    FRequiredWindowHandle := FHandleFinder.GetAppWindowHandle(FHostVersion,
      stOlMailInspector, FHostHandle);
    if (FRequiredWindowHandle <> 0) then begin
      FItemType := stOlMailInspector;
      Self.MakePostMessage := false;
    end;
  end;

  if (FRequiredWindowHandle = 0) and
  ((FHostVersion = v2000)
  or (FHostVersion = v2002)
  or (FHostVersion = v2003)
  )then begin
    FRequiredWindowHandle := FHandleFinder.GetAppWindowHandle(FHostVersion,
      stOlWordMailInspector, FHostHandle);
    if (FRequiredWindowHandle <> 0) then begin
      FItemType := stOlWordMailInspector;
      Self.MakePostMessage := true;
    end;
  end;

  if (FRequiredWindowHandle <> 0) then begin
      if ((not EmptySize(FRequiredWindowHandle))
          and IsWindowVisible(FRequiredWindowHandle)
          and IsWindowVisible(FHostHandle)) then begin
          FVisibleState := vsVisible;
      end else begin
          FVisibleState := vsUnvisible;
      end;

      if (FVisibleState = vsVisible) then begin
        if MakePostMessage then begin
          Log.AddMessage('TShowChildWindowWatchObject.DoExecute.PostMessage');
          FShowChildWindowMessage.PostMessage(FHostHandle, FItemType);
          res := 0;
        end else begin
          Log.AddMessage('TShowChildWindowWatchObject.DoExecute.SendMessage');
          res := FShowChildWindowMessage.SendMessageSync(FHostHandle, FItemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
        end;

        if (res = 0) then begin
            StopWatch := true;
        end else begin
            FVisibleState := vsUnvisible;
        end;
      end;
  end;
end;

function TShowChildWindowWatchObjectInAnyMailInspector.EmptySize(
  Handle: HWND): boolean;
var
  R: TRect;
begin
  if IsWindow(handle) then begin
    GetWindowRect(handle, R);
    result := (R.Right - R.Left + R.Bottom - R.Top <= 0);
  end else begin
    result := true;
  end;
end;

procedure TShowChildWindowWatchObjectInAnyMailInspector.END_WM_SETREDRAW(
  window: HWND);
begin
  //
end;

procedure TShowChildWindowWatchObjectInAnyMailInspector.START_WM_SETREDRAW(
  window: HWND);
begin
  //
end;

{ THostHandleWatchObject }

function THostHandleWatchObject.GetHostHandle: HWND;
begin
  result := FHostHandle;
end;

function THostHandleWatchObject.GetWindowHandle: HWND;
begin
  //if is not zero then ProcessHookEvent will not raised
  result := 0;
end;

procedure THostHandleWatchObject.UpdateHostHandle(AHostHandle: HWND);
begin
  self.FHostHandle := AHostHandle;
end;

{ TWordInspectorPreviewWatchObject }

procedure TWordInspectorPreviewWatchObject.ClearEmulateData;
begin
  Log.AddMessage('TadxOlInspector.ClearEmulateData');
  FEmulateWindowHandle := 0;
  FResizeWindowHandle := 0;
end;

constructor TWordInspectorPreviewWatchObject.Create(
  AHandleFinder: TOutlookHandleFinder;
  APreviewOnMessage: TWordInspectorPreviewOnMessage;
  APreviewOffMessage: TWordInspectorPreviewOffMessage; AHostHandle: HWND;
  AHostVersion: integer);
begin
  inherited Create;
  FHostHandle := AHostHandle;

  FHandleFinder := AHandleFinder;
  FPreviewOnMessage := APreviewOnMessage;
  FPreviewOffMessage := APreviewOffMessage;
  ItemType := stOlEnvelopeCommandBarForWordInspectorPreviwControl;
  HostVersion := AHostVersion;

  WindowHandle := 0;
  VisibleState := vsUnknown;
  FEmulateWindowHandle := 0;
  FResizeWindowHandle := 0;
end;

destructor TWordInspectorPreviewWatchObject.Destroy;
begin
  FHandleFinder := nil;

  if Assigned(FPreviewOnMessage) then begin
    FPreviewOnMessage.Free;
    FPreviewOnMessage := nil;
  end;

  if Assigned(FPreviewOffMessage) then begin
    FPreviewOffMessage.Free;
    FPreviewOffMessage := nil;
  end;

  inherited;
end;

procedure TWordInspectorPreviewWatchObject.DoExecute;
var
  ExistsHostHandle: boolean;
  InitialVisibleState: TVisibleState;
  CurrentVisibleState: TVisibleState;
  VisibleStateChanged: boolean;
  res: integer;
  caption: array [0..259] of char;
begin
            ExistsHostHandle := ((IsWindow(FHostHandle))
              and IsWindowVisible(FHostHandle));

            if (not ExistsHostHandle) then begin
              Log.AddMessage('WordInspectorPreviewWatchObject.!ExistsHostHandle');
              StopWatch := true;
              exit;
            end;

            InitialVisibleState := visibleState;

            if (visibleState = vsUnknown) then begin
              WindowHandle := FHandleFinder.GetAppWindowHandle(HostVersion,
                ItemType, HostHandle);
            end;

            {$IFDEF UNICODE}
            GetWindowText(windowHandle, caption, Length(caption));
            {$ELSE}
            GetWindowText(windowHandle, caption, 260);
            {$ENDIF}

            if (not Globals.CompareADXStrings(caption, 'Envelope')) then begin
              WindowHandle := FHandleFinder.GetAppWindowHandle(HostVersion,
                ItemType, HostHandle);
            end;


            if ((windowHandle <> 0)
              or ((InitialVisibleState = vsVisible) and (windowHandle = 0))) then begin

              CurrentVisibleState := GetVisibleState(WindowHandle, FHostHandle, HostVersion, ItemType);
              VisibleStateChanged := (visibleState <> CurrentVisibleState);

              if (VisibleStateChanged) then begin
                case (CurrentVisibleState) of
                  vsVisible: begin
                    //FPreviewOffMessage.PostMessage(hostHandle, itemType); res := 0;
                    //The operation failed due to network or other communication problems.  Check your connections and try again
                    res := FPreviewOffMessage.SendMessageSync(hostHandle, itemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
                    if (res = 0) then begin
                      visibleState := CurrentVisibleState;
                    end;
                  end;

                  vsUnvisible: begin
                    if (InitialVisibleState = vsVisible) then begin
                        //FPreviewOnMessage.PostMessage(hostHandle, itemType); res := 0;
                        //The operation failed due to network or other communication problems.  Check your connections and try again
                        res := FPreviewOnMessage.SendMessageSync(hostHandle, itemType, FormsManagerSingleton.hADXOLWatchEngineSendMessageMutex, self.WatchEngineIsHook);
                        if (res = 0) then begin
                            visibleState := CurrentVisibleState;
                        end;

                    end;
                  end;
                end;
              end;
            end;



(*





            if ((windowHandle != IntPtr.Zero)
                || ((InitialVisibleState == VisibleState.Visible) && (windowHandle == IntPtr.Zero)))
            {

                VisibleState CurrentVisibleState = GetVisibleState(windowHandle, hostHandle, hostVersion, itemType);
                bool VisibleStateChanged = (visibleState != CurrentVisibleState);

                if (VisibleStateChanged)
                {
                    switch (CurrentVisibleState)
                    {
                        case VisibleState.Visible:
                            {
                                Log.AddMessage("WordInspectorPreviewWatchObject.showWindowMessage.SendMessage");


                                int res = (int)previewOffMessage.SendMessage(hostHandle, (IntPtr)itemType);
                                if (res == 0)
                                {
                                    visibleState = CurrentVisibleState;
                                }
                            }
                            break;

                        case VisibleState.Unvisible:
                            if (InitialVisibleState == VisibleState.Visible)
                            {
                                Log.AddMessage("WordInspectorPreviewWatchObject.hideWindowMessage.SendMessage");

                                //For update preview window. Empty part is left in below of window
                                if (
                                    (this.resizeWindowHandle != IntPtr.Zero)
                                  && WindowsAPI.IsWindow(this.resizeWindowHandle)
                                  && (this.emulateWindowHandle != IntPtr.Zero)
                                  && WindowsAPI.IsWindow(this.emulateWindowHandle))
                                {
                                    /*WindowsAPI.RECT R = new WindowsAPI.RECT();
                                    WindowsAPI.GetWindowRect(this.resizeWindowHandle, out R);
                                    int LeftTop = R.Left << 16 + R.Top;
                                    int RightBottom = R.Right << 16 + R.Bottom;
                                    WindowsAPI.PostMessage(this.emulateWindowHandle, Globals.msgWMIPosChange, (IntPtr)LeftTop, (IntPtr)RightBottom);
                                    Debug.WriteLine("*!* RESIZE PREVIEW"); */
                                    //TODO !!!
                                }

                                int res = (int)previewOnMessage.SendMessage(hostHandle, (IntPtr)itemType);
                                if (res == 0)
                                {
                                    visibleState = CurrentVisibleState;
                                }
                            }
                            break;
                    }
                }
            }
        }
        *)
end;

procedure TWordInspectorPreviewWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //
end;

function TWordInspectorPreviewWatchObject.GetVisibleState(AWindowHandle,
  AHostHandle: HWND; AHostVersion, AItemType: integer): TVisibleState;
begin
  if (IsWindowVisible(AWindowHandle)
    and IsWindowVisible(AHostHandle)) then begin
    result := vsVisible;
  end
  else begin
    result := vsUnvisible;
  end;
end;

procedure TWordInspectorPreviewWatchObject.SetEmulateData(
  AEmulateWindowHandle, AResizeWindowHandle: HWND);
begin
  FEmulateWindowHandle := AEmulateWindowHandle;
  FResizeWindowHandle := AResizeWindowHandle;
end;

procedure TWordInspectorPreviewWatchObject.START_WM_SETREDRAW(
  window: HWND);
begin
  //
end;

{ TWordInspectorPreviewOffMessage }

function TWordInspectorPreviewOffMessage.GetMessageName: string;
begin
  result := 'WM_ADX_WORDINSPPREVIEW_OFF';
end;

{ TWordInspectorPreviewOnMessage }

function TWordInspectorPreviewOnMessage.GetMessageName: string;
begin
  result := 'WM_ADX_WORDINSPPREVIEW_ON';
end;

{ TControlResizeWindowWatchObject }

constructor TControlResizeWindowWatchObject.Create(AHostHandle,
  AEmulateWindowHandle, AWindowHandle, AReceiverWindowHandle: HWND);
begin
  inherited Create;
  FHostHandle := AHostHandle;
  FEmulateWindowHandle := AEmulateWindowHandle;
  FWindowHandle := AWindowHandle;
  FReceiverWindowHandle := AReceiverWindowHandle;
end;

procedure TControlResizeWindowWatchObject.DoExecute;
var
  ExistsWindowHandle: boolean;
  EndResize: boolean;
begin

{$IFNDEF PREVIEWDELEMULATEWINDOW}
  ExistsWindowHandle := IsWindow(FWindowHandle);
{$ELSE}
  ExistsWindowHandle := IsWindow(FWindowHandle) and IsWindowVisible(this.WindowHandle);
{$ENDIF}

  if (ExistsWindowHandle) then begin

      //To prevent delete before form showing
      FWasFoundWindowHandle := true;
      SendSizeToEmulateWindow(true);

  end;

  EndResize := (not ExistsWindowHandle and WasFoundWindowHandle);
  if (EndResize) then begin
    NotifyRemoveControlledResizeWindow();
    StopWatch := true;
  end;
end;

procedure TControlResizeWindowWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //
end;

procedure TControlResizeWindowWatchObject.NotifyRemoveControlledResizeWindow;
var
  mes: TCustomWindowMessage;
begin
  mes := TRemoveControlledResizeWindowMessage.Create(ReceiverWindowHandle, nil);
  try
    mes.SendMessage(FHostHandle, FEmulateWindowHandle)
  finally
    if Assigned(mes) then begin
      mes.Free;
    end;
  end;
end;

procedure TControlResizeWindowWatchObject.SendSizeToEmulateWindow(
  APostMessage: boolean);
var
  R: TRect;
begin
  if (IsWindow(FWindowHandle)
      and IsWindow(FEmulateWindowHandle)) then begin
    GetClientRect(FWindowHandle, R);
    if (((R.Right - R.Left) <> (FPriorWindowRect.Right - FPriorWindowRect.Left))
        or ((R.Bottom - R.Top) <> (FPriorWindowRect.Bottom - FPriorWindowRect.Top))) then begin



      if (WaitForSingleObject(FormsManagerSingleton.hResizeEmulateWibdowMutex, mutexWaiting) = WAIT_OBJECT_0) then begin
        ReleaseMutex(FormsManagerSingleton.hResizeEmulateWibdowMutex);
        if (APostMessage) then begin
          FPriorWindowRect := R;
          PostMessage(FEmulateWindowHandle, WM_ADXWMIPOSCHANGE, (R.Left shl 16) + R.Top, (R.Right shl 16) + R.Bottom);
        end
        else begin
          FPriorWindowRect := R;
          SendMessage(FEmulateWindowHandle, WM_ADXWMIPOSCHANGE, (R.Left shl 16) + R.Top, (R.Right shl 16) + R.Bottom);
        end;
      end;

    end;
  end;
end;

procedure TControlResizeWindowWatchObject.START_WM_SETREDRAW(window: HWND);
begin
  //
end;

{ TRemoveControlledResizeWindowMessage }

constructor TRemoveControlledResizeWindowMessage.Create(
  ReceiverHandle: HWND; AHandler: TRemoveControlledResizeWindow);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := AHandler;
end;

destructor TRemoveControlledResizeWindowMessage.Destroy;
begin
  FHandler := nil;
  inherited;
end;

function TRemoveControlledResizeWindowMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXREMOVECONTROLLEDRESIZEWINDOW;
end;

function TRemoveControlledResizeWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  EmulateWindowHandle: HWND;
begin
  HostHandle := wParam;
  EmulateWindowHandle := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, EmulateWindowHandle);
  end
  else begin
    raise SysUtils.Exception.Create('TRemoveControlledResizeWindowMessage: handler does not set');
  end;

  result := 0;
end;

{ TControlHideWindowWatchObject }

constructor TControlHideWindowWatchObject.Create(AHostHandle,
  AWindowHandle: HWND; AItemType: integer; AReceiverWindowHandle: HWND);
begin
  inherited Create();
  HideWindowMessage := THideWindowMessage.Create(AReceiverWindowHandle, nil);
  WordEditorHideMessage := TWordEditorHideMessage.Create(AReceiverWindowHandle, nil);
  FHostHandle := AHostHandle;
  FWindowHandle := AWindowHandle;
  FItemType := AItemType;
  FReceiverWindowHandle := AReceiverWindowHandle;
end;

destructor TControlHideWindowWatchObject.Destroy;
begin
  HideWindowMessage.Free;
  WordEditorHideMessage.Free;
  inherited;
end;

procedure TControlHideWindowWatchObject.DoExecute;
var
  DeleteItem: boolean;
  ExistsWindowHandle: boolean;
  res: integer;
begin

  DeleteItem := false;

  ExistsWindowHandle := (IsWindow(WindowHandle)
    and IsWindowVisible(WindowHandle));

  if (not ExistsWindowHandle) then begin

    res := HideWindowMessage.SendMessage(WindowHandle, ItemType);
    if (res = 0) then begin
      DeleteItem := true;
    end;
  end;

  if (DeleteItem) then begin
    if (ItemType = stOlWordMailInspector) then begin
      WordEditorHideMessage.PostMessage(WindowHandle, ItemType);
    end;
    StopWatch := true;
  end;

end;


procedure TControlHideWindowWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //
end;

procedure TControlHideWindowWatchObject.START_WM_SETREDRAW(window: HWND);
begin
  //
end;

{ TWordEditorHideMessage }

constructor TWordEditorHideMessage.Create(ReceiverHandle: HWND;
  Handler: TWindowEvent);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

function TWordEditorHideMessage.GetMessageName: string;
begin
  result := Globals.WM_ADX_WORDEDITOR_HIDE;
end;

function TWordEditorHideMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;

{ TShowSearchWindowMessage }

constructor TShowSearchWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TWindowEvent);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

function TShowSearchWindowMessage.GetMessageName: string;
begin
  result := Globals.WM_ADX_SEARCH_WINDOW_ENGINE_SHOW;
end;

function TShowSearchWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;

{ THideSearchWindowMessage }

constructor THideSearchWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TWindowEvent);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

function THideSearchWindowMessage.GetMessageName: string;
begin
  result := Globals.WM_ADX_SEARCH_WINDOW_ENGINE_HIDE;
end;

function THideSearchWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;

{ TDeleteEmulateWindowMessage }

constructor TDeleteEmulateWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TDeleteEmulateWindowEvent);
begin
  inherited Create(ReceiverHandle);
  FSynchronize := false;
  self.FHandler := Handler;
end;

function TDeleteEmulateWindowMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXDELETEEMULATEWINDOW;
end;

function TDeleteEmulateWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  EmulateWindowHandle: HWND;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');

  HostHandle := lParam;
  EmulateWindowHandle := wParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, EmulateWindowHandle);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;

{ THideWindowMessage }

constructor THideWindowMessage.Create(ReceiverHandle: HWND;
  Handler: TWindowEvent);
begin
  inherited Create(ReceiverHandle);
  self.FHandler := Handler;
end;

function THideWindowMessage.GetMessageName: string;
begin
  result := Globals.WM_ADX_WINDOW_ENGINE_HIDE;
end;

function THideWindowMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  HostHandle: HWND;
  ItemType: integer;
begin
  TDebug.WriteLine(self.ClassName + '.ProcessMessage');
  HostHandle := wParam;
  ItemType := lParam;

  if Assigned(FHandler) then begin
    FHandler(HostHandle, ItemType);
  end
  else begin
    raise SysUtils.Exception.Create(self.ClassName + ': handler does not set');
  end;

  //StopProcess := true; Does not stop process
  result := 0;
end;




procedure TFormsManagerThread.Execute;
begin
  (*Log.AddMessage('TFormsManagerThread.Execute begin');
  FreeOnTerminate := true;

  case (WaitForSingleObject(FormsManagerSingleton.hMessageMutex, INFINITE)) of
    WAIT_OBJECT_0: begin
          FormsManagerSingleton.DeleteAllForms;
          Log.AddMessage('TFormsManagerThread.Execute end');
        end;
    WAIT_ABANDONED: begin
          Log.AddMessage('TFormsManagerThread.Execute WAIT_ABANDONED');
    end;
    WAIT_TIMEOUT: begin
          Log.AddMessage('TFormsManagerThread.Execute WAIT_TIMEOUT');
    end;

  end;*)
end;

procedure TWatchEngine.InternalDeleteByHostHandle(HostHandle: HWND);
var
  index: integer;
begin
  Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle count = ' + IntToStr(FWatchObjects.Count));
  try
    if (FWatchObjects <> nil) then begin
      index := 0;
      while (0 <= index) and (index < FWatchObjects.Count) do begin
        Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle: index = ' + IntToStr(index));
        if (index < 0) then begin
          Log.AddWarning('TWatchEngine.InternalDeleteByHostHandle.Exception: index < 0');
        end;
        if (TWatchObject(FWatchObjects.Items[index]) is THostHandleWatchObject)
          and (THostHandleWatchObject(FWatchObjects.Items[index]).HostHandle = HostHandle) then begin
          Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle before free - ' + IntToStr(index));
          TWatchObject(FWatchObjects.Items[index]).Free;
          FWatchObjects.Items[index] := nil;
          Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle before delete - ' + IntToStr(index));
          FWatchObjects.Delete(index);
          Dec(index);
        end
        else begin
          Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle inc - ' + IntToStr(index));
          Inc(index);
        end;
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TWatchEngine.InternalDeleteByHostHandle: ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine('+IntToStr(FWatchObjects.Count)+').InternalDeleteByHostHandle ' + E.Message), 'InternalDeleteByHostHandle');
    end;
  end;
end;

procedure TWatchEngine.InternalProcessPrepareDeleteHandles;
var
  i: integer;
begin
  try
    if (Length(PrepareDeleteHandles) > 0) then begin
      if (WaitForSingleObject(FormsManagerSingleton.hClearWatchObjectsMutex, INFINITE) = WAIT_OBJECT_0) then begin
        Log.AddMessage('TWatchEngine.ProcessPrepareDeleteHandles - begin ' + IntToStr(Length(PrepareDeleteHandles)));
        try
          for i := 0 to Length(PrepareDeleteHandles) - 1 do begin
            Log.AddMessage('TWatchEngine.InternalDeleteByHostHandle - before ' + IntToStr(i) + '/' + IntToStr(Length(PrepareDeleteHandles)));
            InternalDeleteByHostHandle(PrepareDeleteHandles[i]);
          end;
          SetLength(PrepareDeleteHandles, 0);
          Log.AddMessage('TWatchEngine.ProcessPrepareDeleteHandles - end');
        finally
          ReleaseMutex(FormsManagerSingleton.hClearWatchObjectsMutex);
        end;
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TWatchEngine.InternalProcessPrepareDeleteHandles: ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine.InternalProcessPrepareDeleteHandles ' + E.Message), 'InternalProcessPrepareDeleteHandles');
    end;
  end;
end;

procedure TWatchEngine.InternalDeleteStoppedObjects;
var
  index: integer;
  WatchObject: TWatchObject;
begin
  try
    if (WaitForSingleObject(FormsManagerSingleton.hClearWatchObjectsMutex, INFINITE) = WAIT_OBJECT_0) then begin
      try
        index := 0;
        while (0 <= index) and (index < FWatchObjects.Count) do begin
          if (index >= FWatchObjects.Count) then begin
            break;
          end;
          WatchObject := TWatchObject(FWatchObjects[index]);
          if (WatchObject.StopWatch) then begin
            if (index < FWatchObjects.Count) then begin
              Log.AddMessage('TWatchEngine.DeleteStoppedObjects - begin');
              Log.AddMessage(WatchObject.ClassName + ' ' +  IntToStr(index));
              WatchObject.Free;
              FWatchObjects.Delete(index);
              Log.AddMessage('TWatchEngine.DeleteStoppedObjects - end');
            end;
          end else begin
            Inc(index);
          end;
        end;
      finally
        ReleaseMutex(FormsManagerSingleton.hClearWatchObjectsMutex);
      end;
    end;
  except
    on E: SysUtils.Exception do begin
      Log.AddException('TWatchEngine.InternalDeleteStoppedObjects: ' + E.Message);
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine.InternalDeleteStoppedObjects ' + E.Message), 'InternalDeleteStoppedObjects');
    end;
  end;
end;

procedure TWatchEngine.InternalExecuteObjects;
var
  index: integer;
  WatchObject: TWatchObject;
begin
  WatchObject := nil;
  try
    index := 0;
    while (0 <= index) and (index < FWatchObjects.Count) do begin
      if (index >= FWatchObjects.Count) then begin
        break;
      end;
      try
        WatchObject := TWatchObject(FWatchObjects[index]);
      except
        on E:SysUtils.Exception do begin
          WatchObject := nil;
          Log.AddException('TWatchEngine.InternalExecuteObjects 1 ' + E.Message);
        end;
      end;
      if (WatchObject <> nil)
        and (not WatchObject.Pause) then begin
        WatchObject.Execute();
      end;
      Inc(index);
    end;
  except
    on E:SysUtils.Exception do begin
      if (WatchObject <> nil) then begin
        Log.AddException('TWatchEngine.InternalExecuteObjects 2 (not nil)' + E.Message);
      end
      else begin
        Log.AddException('TWatchEngine.InternalExecuteObjects 2 (nil)' + E.Message);
      end;
      TadxExceptionManager.ProcessADXXError(SysUtils.Exception.Create('TWatchEngine('+IntToStr(FWatchObjects.Count)+').InternalExecuteObjects. ' + E.Message), 'InternalExecuteObjects');
    end;
  end;
end;

{ TADXXOlExceptionManager }

procedure TADXXOlExceptionManager.InternalProcessADXXError(err: SysUtils.Exception; whereHappened: string);
var
  args: TadxOlErrorEventArgs;
  event: TadxEventRaising;
begin
  try
{$IFDEF EUREKALOG}
        ExceptionLog.ShowLastExceptionData;
{$ENDIF}
    if (err <> nil) then begin
      Log.AddException(Format('%s error (%s): the add-in has fired an exception.'#13#10 +
        '%s', ['ADX Extensions', whereHappened, err.Message]));
    end;
    args := TadxOlErrorEventArgs.Create(err);
    try
      if (FormsManagerSingleton <> nil) then begin
        if Assigned(FormsManagerSingleton.OnError) then begin
          event := TadxEventRaising.Create('OnError', [eoLockRegionState]);
          try
            FormsManagerSingleton.OnError(FormsManagerSingleton, args);
          finally
            event.Free;
          end;
        end;
      end;
      if (not args.Handled) then begin
        if (err <> nil) then begin
          if (AdxShowYesNoError(Format('%s error (%s): the add-in has fired an exception.'#13#10 +
           '%s ' + #13#10 + '%s', ['ADX Extensions', whereHappened, err.Message, 'Do you want to look at the Log?']), 'Add-in Express Extensions error') = IDYES) then begin
            Log.ShowMessages('ADX Extensions Log');
          end;
        end
        else begin
          if (AdxShowYesNoError(Format('%s error (%s): the add-in has fired an exception.'#13#10 +
           '%s ' + #13#10 + '%s', ['ADX Extensions', whereHappened, 'UNKNOWN EXCEPTION (err = nil)', 'Do you want to look at the Log?']), 'Add-in Express Extensions error') = IDYES) then begin
            Log.ShowMessages('ADX Extensions Log');
          end;
        end;
      end;
    finally
      args.Free;
    end;
  except
    on MethodErr:SysUtils.Exception do begin
      Windows.MessageBox(GetDesktopWindow, PChar('ADX Extensions ProcessADXXError (' + whereHappened + ', '  + err.Message + #13#10 + MethodErr.Message), 'ProcessADXXError', 0);
    end;
  end;
end;


{ TadxOlPostMessageEventArgs }

constructor TadxOlPostMessageReceivedEventArgs.Create(AwParam, AlParam: Cardinal);
begin
  inherited Create;
  FwParam := AwParam;
  FlParam := AlParam; 
end;


{ TRegionCloseButtonClickMessage }

constructor TRegionCloseButtonClickMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TRegionCloseButtonClickMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TRegionCloseButtonClickMessage.GetMessageName: string;
begin
  result := 'WM_ADXCLOSEBUTTONCLICK';
end;

function TRegionCloseButtonClickMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  formHandle: HWND;
begin
  formHandle := wParam;
  if (FFormsManager <> nil) then begin
    FFormsManager.DoRegionCloseButtonClick(formHandle);
    result := 0;
  end else begin
    result := 0;
  end;
end;

{ TadxOlCloseButtonClickEventArgs }

constructor TadxOlCloseButtonClickEventArgs.Create;
begin
  inherited;
  FCloseForm := true;
  FDisableItem := false;
end;

procedure TadxOlCloseButtonClickEventArgs.SetCloseForm(
  const Value: boolean);
begin
  FCloseForm := Value;
end;

procedure TadxOlCloseButtonClickEventArgs.SetDisableItem(
  const Value: boolean);
begin
  FDisableItem := Value;
end;

{ TextDocumentUtils }

class function TextDocumentUtils.GetTextDocument(
  TextDocumentHandle: HWND): ITextDocument;
var
  {$IFDEF ADX_VCL5}
  REOle: IUnknown;
  {$ELSE}
  REOle: IInterface;
  {$ENDIF}
begin
  result := nil;
  if SendMessage(TextDocumentHandle, EM_GETOLEINTERFACE, 0, Longint(@REOle) ) <> 0 then begin
    REOle.QueryInterface(ITextDocument, result);
    //result := REOle as ITextDocument;
  end;
end;

class function TextDocumentUtils.GetTextDocumentWindowHandle(
  HostVersion: integer; EditorType: TOleEnum; InspectorHandle: HWND): HWND;
begin
  result := GetTextDocumentHandle(HostVersion, EditorType, InspectorHandle);
end;

class function TextDocumentUtils.GetTextEditor(InspectorObj: Inspector;
  OutlookVersion: TadxolOutlookVersion): ITextDocument;
var
  EditorType: TOleEnum;
  ItIsNecessaryToUseWordEditor: boolean;
  ItIsNecessaryToUseHtmlEditor: boolean;
  InspectorWindowHandle: HWND;
  propertySupportThisEditorType: boolean;
  TextDocumentHandle: HWND;
begin
  result := nil;
  try
    if (InspectorObj <> nil) then begin
      EditorType := InspectorObj.EditorType;

      ItIsNecessaryToUseWordEditor :=
        InspectorObj.IsWordMail
        and (OutlookVersion <> v2007)
        and (OutlookVersion <> v2010);

      ItIsNecessaryToUseHtmlEditor := EditorType = olEditorHTML;

      if (ItIsNecessaryToUseWordEditor) then begin
          Log.AddWarning('It Is Necessary To Use WordEditor');
          exit;
      end;

      if (ItIsNecessaryToUseHtmlEditor) then begin
          Log.AddWarning('It Is Necessary To Use HtmlEditor');
          exit;
      end;

      InspectorWindowHandle := GetNotWordIncpectorWindowHandle(InspectorObj);

      propertySupportThisEditorType :=
        ((EditorType = olEditorText) or (EditorType = olEditorRTF));

      if (propertySupportThisEditorType) then begin

          TextDocumentHandle := TextDocumentUtils.GetTextDocumentWindowHandle(OutlookVersion, EditorType, InspectorWindowHandle);
          if (TextDocumentHandle <> 0) then begin
              result := TextDocumentUtils.GetTextDocument(TextDocumentHandle);
              exit;
          end;

      end;


    end;


  except
    on E: SysUtils.Exception do begin
      Log.AddWarning('TextDocumentUtils.GetTextEditor error: ' + E.Message);
    end;
  end;
end;

{ TCloseServiceFormForNotWordInspectorMessage }

constructor TCloseServiceFormForNotWordInspectorMessage.Create(
  ReceiverHandle: HWND; AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TCloseServiceFormForNotWordInspectorMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TCloseServiceFormForNotWordInspectorMessage.GetMessageName: string;
begin
  result := GlobalsOL.WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR;
end;

function TCloseServiceFormForNotWordInspectorMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  InspectorWindowHandle: HWND;
  appWindowHandle: HWND;
begin
  InspectorWindowHandle := wParam;
  appWindowHandle := lParam;
  if (FFormsManager <> nil) then begin
    FFormsManager.OnCloseServiceFormForNotWordInspector(InspectorWindowHandle, appWindowHandle);
  end
  else begin
    Log.AddMessage('TCloseServiceFormForNotWordInspectorMessage.ProcessMessage.FFormsManager = nil');
  end;

  result := 0;
end;

{ TCloseFolderViewServiceFormMessage }

constructor TCloseFolderViewServiceFormMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TCloseFolderViewServiceFormMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TCloseFolderViewServiceFormMessage.GetMessageName: string;
begin
  result := GlobalsOL.WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM;
end;

function TCloseFolderViewServiceFormMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  ExplorerWindowHandle: HWND;
  appWindowHandle: HWND;
begin
   ExplorerWindowHandle := wParam;
   appWindowHandle := lParam;
   if (FFormsManager <> nil) then begin
     FFormsManager.OnCloseFolderViewServiceForm(ExplorerWindowHandle, appWindowHandle);
   end;
   result := 0;
end;

{ TCloseReadingPaneServiceFormMessage }

constructor TCloseReadingPaneServiceFormMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TCloseReadingPaneServiceFormMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TCloseReadingPaneServiceFormMessage.GetMessageName: string;
begin
  result := GlobalsOL.WM_ADX_CLOSE_READINGPANE_SERVICE_FORM;
end;

function TCloseReadingPaneServiceFormMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  ExplorerWindowHandle: HWND;
  appWindowHandle: HWND;
begin
  ExplorerWindowHandle := wParam;
  appWindowHandle := lParam;
  if (FFormsManager <> nil) then begin
    FFormsManager.OnCloseReadingPaneServiceForm(ExplorerWindowHandle, appWindowHandle);
  end;
  result := 0;
end;

{ TZOrderHelper }

function TZOrderHelper.DoEnumWindowsProc(wnd: HWND; lparam: LParam): BOOL;
begin
  result := true;
  inc(zIndex);
  if (wnd = TopWindowHandle) then begin
      zTopWindowIndex := zIndex;
  end;
  if (wnd = BottomWindowHandle) then begin
      zBottomWindowIndex := zIndex;
  end;
  if (zTopWindowIndex >0) and (zBottomWindowIndex > 0) then begin
    result := false;
  end;
end;

function TZOrderHelper.InternalIsUnder(TopWindow, BottomWindow: HWND): boolean;
begin
  result := false;
  if (WorkingZOrderHelperInstance <> nil) then begin
    zIndex := 0;
    TopWindowHandle := TopWindow;
    BottomWindowHandle := BottomWindow;
    zTopWindowIndex := 0;
    zBottomWindowIndex := 0;
    EnumWindows(@TZOrderHelper_EnumWindowsProc, 0);
    result := zTopWindowIndex < zBottomWindowIndex;
  end;
end;


class function TZOrderHelper.IsUnder(TopWindow,
  BottomWindow: HWND): boolean;
begin
  if (WorkingZOrderHelperInstance = nil) then begin
    WorkingZOrderHelperInstance := TZOrderHelper.Create;
    try
      result := WorkingZOrderHelperInstance.InternalIsUnder(TopWindow, BottomWindow);
    finally
      WorkingZOrderHelperInstance.Free;
      WorkingZOrderHelperInstance := nil;
    end;
  end
  else begin
    result := false;
    Log.AddWarning('TZOrderHelper.IsUnder: WorkingZOrderHelperInstance <> nil');
  end;
end;

class function GlobalsOl.WM_ADX_REFRESH_INSPECTOR_TAB: string;
begin
  result := 'WM_ADX_REFRESH_INSPECTOR_TAB';
end;

{ TRefreshInspectorTabWatchObject }

constructor TRefreshInspectorTabWatchObject.Create(ReceiverHandle,
  AHostHandle: HWND; AItemType: Integer);
begin
  inherited Create();
  TDebug.WriteLine(Log.AddinName +  '.@@@ TRefreshInspectorTabWatchObject.Create');
  Log.AddMessage('TRefreshInspectorTabWatchObject.Create');
  FHostHandle := AHostHandle;
  FItemType := AItemType;
  Finder := TFindOutlookWindowFactory.CreateFindWindowObject(AItemType);
  CurrentWindowHandle := Finder.Find(FHostHandle, [fwcWindowMustVisibleAndMorePixel]);
  if (CurrentWindowHandle = 0) then begin
    Log.AddWarning('TRefreshInspectorTabWatchObject.Create.CurrentWindowHandle = 0');
  end;
end;

destructor TRefreshInspectorTabWatchObject.Destroy;
begin
  if (Finder <> nil) then begin
    Finder.Free;
  end;
  inherited;
end;

procedure TRefreshInspectorTabWatchObject.DoExecute;
var
  ExistsHostHandle: boolean;
  VisibleTabHandle: HWND;
  OldWindowHandle: HWND;
begin

  if TadxOlFormsManagerState(FormsManagerSingleton.State).isRefreshInspectorTabTransaction then begin
    TDebug.WriteLine(Log.AddinName + '.@@@ SKIP TRefreshInspectorTabWatchObject.DoExecute' );
    exit;
  end;

  if (StopWatch) then begin
    Log.AddWarning('RefreshInspectorTabWatchObject.DoExecute.StopWatch');
    exit;
  end;
  ExistsHostHandle := (IsWindow(FHostHandle) and IsWindowVisible(FHostHandle));

  if (not ExistsHostHandle) then begin
    StopWatch := true;
    exit;
  end;

  //VisibleTabHandle will not find when BackStage is showed
  if (not IsWindowVisible(CurrentWindowHandle)) then begin
    VisibleTabHandle := finder.Find(FHostHandle, [fwcWindowMustVisibleAndMorePixel]);

    if ((VisibleTabHandle <> 0) and (VisibleTabHandle <> CurrentWindowHandle)) then begin
      if TadxOlFormsManagerState(FormsManagerSingleton.State).isRefreshInspectorTabTransaction then begin
        TDebug.WriteLine(Log.AddinName + '@@@ @@@ RefreshInspectorTabWatchObject.SKIP OnRefreshInspectorTab ****');
      end
      else begin
        OldWindowHandle := CurrentWindowHandle;
        CurrentWindowHandle := VisibleTabHandle;
        StopWatch := true;
        FormsManagerSingleton.OnRefreshInspectorTab(FHostHandle, OldWindowHandle, CurrentWindowHandle, FItemType);
      end;
    end;
  end;
end;

procedure TRefreshInspectorTabWatchObject.END_WM_SETREDRAW(window: HWND);
begin
  //Nothing
end;

function TRefreshInspectorTabWatchObject.GetCurrentWindowHandle: HWND;
begin
  result := FCurrentWindowHandle;
end;

function TRefreshInspectorTabWatchObject.GetHostVersion: TadxHostVersion;
begin
  result := FormsManagerSingleton.OutlookVersion;
end;

procedure TRefreshInspectorTabWatchObject.ProcessHookEvent(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer);
begin
  case Msg of
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED:
      DoExecute;
  end;
end;

procedure TRefreshInspectorTabWatchObject.SetCurrentWindowHandle(
  const Value: HWND);
begin
  if (Value <> FCurrentWindowHandle) then begin
    FCurrentWindowHandle := Value;
  end;
end;

procedure TRefreshInspectorTabWatchObject.START_WM_SETREDRAW(window: HWND);
begin
  //Nothing
end;

{ TFindOutlookWindowFactory }

function TFindOutlookWindowFactory.CreateSpecificFindWindowObject(
  ItemType: TadxItemType): TFindWindowObject;
begin
  case(ItemType) of
    stOlTodoBar:
        case HostVersion of
            v2000,
            v2002,
            v2003:
                result := nil; //raise SysUtils.Exception.Create('Is not supported.');
            v2007,
            v2010:
                result := TToDoBarFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlDefaultInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010: begin
              result := TDefaultInspectorFinder.Create(HostVersion);
            end;
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlContactInspector:
        case HostVersion of
            v2000,
            v2002:
                result := TContactInspectorFinder.Create(HostVersion);
            v2003,
            v2007:
                result := TContactInspectorFinder.Create(HostVersion, SocialConnectorAddinConnected);
            v2010:
                result := TContactInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlDistributionListInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TDistributionListInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlMailInspector:
        case HostVersion of

            v2000,
            v2002:
                result := TMailInspectorFinder.Create(HostVersion);
            v2003,
            v2007:
                result := TMailInspectorFinder.Create(HostVersion, SocialConnectorAddinConnected);
            v2010:
                result := TMailInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');

        end;
    stOlWordMailInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003:
                result := TWordMailInspectorFinder.Create(HostVersion);
            v2007,
            v2010:
                result := nil; //raise SysUtils.Exception.Create('Is not supported.');
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlEnvelopeCommandBarForWordInspectorPreviwControl:
        case HostVersion of
            v2000:
                result := nil; //raise SysUtils.Exception.Create('Is not supported.');
            v2002,
            v2003:
                result := TEnvelopeCommandBarForWordInspectorPreviwControlFinder.Create(HostVersion);
            v2007,
            v2010:
                raise SysUtils.Exception.Create('Is not supported.');
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlTaskInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TTaskInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlAppointmentInspector:
        case HostVersion of
            v2000,
            v2002:
                result := TAppointmentInspectorFinder.Create(HostVersion);
            v2003,
            v2007:
                result := TAppointmentInspectorFinder.Create(HostVersion, SocialConnectorAddinConnected);
            v2010:
                result := TAppointmentInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlJournalInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TJournalInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;
    stOlReportInspector:
        case HostVersion of

            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TReportInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');

        end;
    stOlMeetingInspector:
        case HostVersion of

            v2000,
            v2002:
                result := TMeetingIspectorFinder.Create(HostVersion);
            v2003,
            v2007:
                result := TMeetingIspectorFinder.Create(HostVersion, SocialConnectorAddinConnected);
            v2010:
                result := TMeetingIspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');

        end;
        
    stOlSharingInspector:
        case HostVersion of

            v2000,
            v2002,
            v2003,             
            v2007,
            v2010:
                result := TSharingInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;

    stOlMobileInspector:
        case HostVersion of
            v2000,
            v2002,
            v2003,
            v2007,
            v2010:
                result := TMobileInspectorFinder.Create(HostVersion);
            else raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown HostVersion');
        end;

    else  raise SysUtils.Exception.Create('FindOutlookWindowFactory.GetFindWindowObject: Unknown AdxItemType');
  end;
end;

function TFindOutlookWindowFactory.GetHostVersion: TadxHostVersion;
begin
  result := TadxHostVersion(FormsManagerSingleton.OutlookVersion);
end;

function TFindOutlookWindowFactory.GetSocialConnectorAddinConnected: boolean;
begin
  result := FormsManagerSingleton.SocialConnectorAddinConnected;
end;

{ TFindOutlookWindowObject }

constructor TFindOutlookWindowObject.Create(AHostVersion: TadxHostVersion;
  ASocialConnectorAddinConnected: boolean);
begin
  inherited Create(AHostVersion);
  FDependentOnSocialConnector := true;
  FSocialConnectorAddinConnected := ASocialConnectorAddinConnected;
end;

constructor TFindOutlookWindowObject.Create(AHostVersion: TadxHostVersion);
begin
  inherited Create(AHostVersion);
end;

{ TDefaultInspectorFinder }

function TDefaultInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := Self.FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
    Result:= self.FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result := FindChildWindowV(H, '', 'AfxWnd', '', true, true);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
    Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result := InternalFindChildWindow(H, '', 'AfxWnd', '', true, Condition);
  end;
end;

function TDefaultInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
    Result := FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result:= FindChildWindowV(H, '', 'AfxWndA', '', true, true);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
    Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result:= InternalFindChildWindow(H, '', 'AfxWndA', '', true, Condition);
  end;
end;

function TDefaultInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TDefaultInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TDefaultInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    Result:= InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TMailInspectorFinder }

function TMailInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
    Result := FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result := FindChildWindowV(H, '', 'AfxWnd', '', true, true);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
    Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result := InternalFindChildWindow(H, '', 'AfxWnd', '', true, Condition);
  end;
end;

function TMailInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
    Result := FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result := FindChildWindowV(H, '', 'AfxWndA', '', true, true);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
    Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result := InternalFindChildWindow(H, '', 'AfxWndA', '', true, Condition);
  end;
end;

function TMailInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', '#32770', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
      Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TMailInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
      Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TMailInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    //Related with TRefreshInspectorTabWatchObject
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TWordMailInspectorFinder }

function TWordMailInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', '_WwB', '', true, true);
  end
  else begin
    Log.AddWarning('TWordMailInspectorFinder.FindIn2000 is not tested');
    Result := 0;
  end;
end;

function TWordMailInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', '_WwF', '', false, true);
    Result := FindChildWindowV(H, '', '_WwB', '', true, true);
  end
  else begin
    Log.AddWarning('TWordMailInspectorFinder.FindIn2002 is not tested');
    Result := 0;
  end;
end;

function TWordMailInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', '_WwF', '', false, true);
    Result := FindChildWindowV(H, '', '_WwB', '', true, true);
  end
  else begin
    Log.AddWarning('TWordMailInspectorFinder.FindIn2003 is not tested');
    Result := 0;
  end;
end;

function TWordMailInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  Log.AddWarning('Outlook 2007 has not WordEditor.');
  result := 0;
end;

function TWordMailInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  Log.AddWarning('Outlook 2010 has not WordEditor.');
  result := 0;
end;

{ TEnvelopeCommandBarForWordInspectorPreviwControlFinder }

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2000(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2002(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, 'Envelope', 'MsoCommandBar', '', true, true);
  end
  else begin
    Log.AddWarning('TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2002 is not tested');
    Result := 0;
  end;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2003(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, 'Envelope', 'MsoCommandBar', '', true, true);
  end
  else begin
    Log.AddWarning('TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2003 is not tested');
    Result := 0;
  end;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2007(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

function TEnvelopeCommandBarForWordInspectorPreviwControlFinder.FindIn2010(
  HostHandle: HWND; Condition: TadxFindWindowConditions): HWND;
begin
  Result := 0;
end;

{ TAppointmentInspectorFinder }

function TAppointmentInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
  end
  else begin
    Log.AddWarning('TAppointmentInspectorFinder.FindIn2000 is not tested');
    Result := 0;
  end;
end;

function TAppointmentInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
  end
  else begin
    Log.AddWarning('TAppointmentInspectorFinder.FindIn2002 is not tested');
    Result := 0;
  end;
end;

function TAppointmentInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if Self.SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', '#32770', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
      Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TAppointmentInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if Self.SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
      Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TAppointmentInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TTaskInspectorFinder }

function TTaskInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
  end;
end;

function TTaskInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
  end;
end;

function TTaskInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TTaskInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TTaskInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TContactInspectorFinder }

function TContactInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
  end;
end;

function TContactInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
  end;
end;

function TContactInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if Self.SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', '#32770', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
      Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TContactInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if Self.SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
      Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TContactInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TJournalInspectorFinder }

function TJournalInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
  end;
end;

function TJournalInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
  end;
end;

function TJournalInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
   Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
   Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TJournalInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TJournalInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TReportInspectorFinder }

function TReportInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H:= FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
    Result:= FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result:= FindChildWindowV(H, '', 'AfxWnd', '', true, true);
  end
  else begin
    H:= InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, [fwcAnyVisibleState]);
    Result:= InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result:= InternalFindChildWindow(H, '', 'AfxWnd', '', true, [fwcWindowMustVisible]);
  end;
end;

function TReportInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H:= FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
    Result:= FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result:= FindChildWindowV(H, '', 'AfxWndA', '', true, true);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result:= InternalFindChildWindow(H, '', 'AfxWndA', '', true, [fwcWindowMustVisible]);
  end;
end;

function TReportInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TReportInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TReportInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TDistributionListInspectorFinder }

function TDistributionListInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result:= FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
  end
  else begin
    Result:= InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, Condition);
  end;
end;

function TDistributionListInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, Condition);
  end;
end;

function TDistributionListInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TDistributionListInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  if (Condition = [fwcDefault]) then begin
    //There is no SocialConnector window in Outlook 2007 DestributionList Inspector
    Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
  end
  else begin
    //There is no SocialConnector window in Outlook 2007 DestributionList Inspector
    Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
  end;
end;

function TDistributionListInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TMeetingIspectorFinder }

function TMeetingIspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H:= FindChildWindowV(HostHandle, '', 'AfxWnd', '', false, false);
    Result:= FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result:= FindChildWindowV(H, '', 'AfxWnd', '', true, true);
  end
  else begin
    H:= InternalFindChildWindow(HostHandle, '', 'AfxWnd', '', false, [fwcAnyVisibleState]);
    Result:= InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result:= InternalFindChildWindow(H, '', 'AfxWnd', '', true, [fwcWindowMustVisible]);
  end;
end;

function TMeetingIspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndA', '', false, false);
    Result:= FindChildWindowV(H, '', '#32770', '', false, false);
    if Result = 0 then Result:= FindChildWindowV(H, '', 'AfxWndA', '', true, true);
  end
  else begin
    H:= InternalFindChildWindow(HostHandle, '', 'AfxWndA', '', false, [fwcAnyVisibleState]);
    Result:= InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    if Result = 0 then Result:= InternalFindChildWindow(H, '', 'AfxWndA', '', true, [fwcWindowMustVisible]);
  end;
end;

function TMeetingIspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;  
begin
  if (Self.SocialConnectorAddinConnected) then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', '#32770', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
      Result := InternalFindChildWindow(H, '', '#32770', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result:= FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result:= InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TMeetingIspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if Self.SocialConnectorAddinConnected then begin
    if (Condition = [fwcDefault]) then begin
      H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
      Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
    end
    else begin
      H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
      Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
    end;
  end
  else begin
    if (Condition = [fwcDefault]) then begin
      Result := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    end
    else begin
      Result := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, Condition);
    end;
  end;
end;

function TMeetingIspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;


{ TStartTransactionMessage }

constructor TStartTransactionMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TStartTransactionMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TStartTransactionMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXSTARTTRANSACTION;
end;

function TStartTransactionMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  WindowHandle: HWND;
  transaction: integer;
begin
  transaction := wParam;
  if (FFormsManager <> nil) then begin
    case transaction of
      trRefreshInspectorTab: begin
        WindowHandle := lParam;
        FFormsManager.OnStartRefreshInspectorTabTransaction(WindowHandle);
      end;
      trHookTransaction: begin
        WindowHandle := lParam;
        FFormsManager.OnStartHookTransaction(WindowHandle);
      end;
    end;
    result := 0;
  end else begin
    result := 0;
  end;
end;

{ TEndTransactionMessage }

constructor TEndTransactionMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TEndTransactionMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TEndTransactionMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXENDTRANSACTION;
end;

function TEndTransactionMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  WindowHandle: HWND;
  transaction: integer;
begin
  transaction := wParam;
  if (FFormsManager <> nil) then begin
    case transaction of
      trRefreshInspectorTab: begin
        WindowHandle := lParam;
        FFormsManager.OnEndRefreshInspectorTabTransaction(WindowHandle);
      end;
      trHookTransaction: begin
        WindowHandle := lParam;
        FFormsManager.OnEndHookTransaction(WindowHandle);
      end;
    end;
    result := 0;
  end else begin
    result := 0;
  end;
end;

{ TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObject }

procedure TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObject.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = SetRedrawWindow) then begin
        SetRedrawWindow := 0;
        Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

function TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendMinimizeMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendMinimizeWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowMinimize');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowMinimize(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

{ TNavigationPaneVisibleChangeWindowWatchObject }

procedure TNavigationPaneVisibleChangeWindowWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TNavigationPaneVisibleChangeWindowWatchObjectV2010.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TNavigationPaneVisibleChangeWindowWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = SetRedrawWindow) then begin
        SetRedrawWindow := 0;
        Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

function TNavigationPaneVisibleChangeWindowWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TNavigationPaneVisibleChangeWindowWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

{ TFolderListVisibleChangeWindowWatchObjectV2010 }

procedure TFolderListVisibleChangeWindowWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TFolderListVisibleChangeWindowWatchObjectV2010.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TFolderListVisibleChangeWindowWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  //Nothing. This method is actual for Outlook 2010
end;

function TFolderListVisibleChangeWindowWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TFolderListVisibleChangeWindowWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

procedure TFolderListVisibleChangeWindowWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  //Nothing. This method is actual for Outlook 2010
end;

{ TOutlookBarVisibleChangeWindowWatchObjectV2010 }

procedure TOutlookBarVisibleChangeWindowWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TOutlookBarVisibleChangeWindowWatchObjectV2010.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TOutlookBarVisibleChangeWindowWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  //Nothing. This method is actual for Outlook 2010
end;

function TOutlookBarVisibleChangeWindowWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TOutlookBarVisibleChangeWindowWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

procedure TOutlookBarVisibleChangeWindowWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  //Nothing. This method is actual for Outlook 2010
end;

{ TToDoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010 }

procedure TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TToDoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = SetRedrawWindow) then begin
        SetRedrawWindow := 0;
        Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

function TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendMinimizeMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendMinimizeWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowMinimize');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowMinimize(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer; hSynchronizationMutex: THandle;
  WatchEngineIsHook: boolean): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

procedure TTodoBarVisibleMinimizeUnvisibleChangeWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = self.WindowHandle) then begin
        SetRedrawWindow := window;
        Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

{ TReadingPaneVisibleChangeWindowWatchObjectV2010 }

constructor TReadingPaneVisibleChangeWindowWatchObjectV2010.Create(
  AHandleFinder: TOutlookHandleFinder; AShowWindowMessage,
  AHideWindowMessage: TVisibleChangeWindowMessage; AHostHandle: HWND;
  AItemType, AHostVersion: Integer);
begin
  inherited Create(AHandleFinder, AShowWindowMessage,
  AHideWindowMessage, AHostHandle, AItemType, AHostVersion);
  ReadingPaneHandleThatGetWMSETREDRAW := 0;
end;

procedure TReadingPaneVisibleChangeWindowWatchObjectV2010.DoExecute;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TReadingPaneVisibleChangeWindowWatchObjectV2010.DoExecute');
    Exit;
  end;
  inherited DoExecute;
end;

procedure TReadingPaneVisibleChangeWindowWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = ReadingPaneHandleThatGetWMSETREDRAW) then begin
      ReadingPaneHandleThatGetWMSETREDRAW := 0;
      SetRedrawWindow := 0;
      TMoveReadingPaneWindowWatchObject.SetSetRedrawWindow(0);
      Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

function TReadingPaneVisibleChangeWindowWatchObjectV2010.SendHideMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendHideWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

function TReadingPaneVisibleChangeWindowWatchObjectV2010.SendShowMessageSync(
  wParam, lParam: integer): integer;
var
  event: TLogEvent;
begin
  result := 0;
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP SendShowWindowMessageSync');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(WindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(wParam, lParam);
  finally
    FormsManagerSingleton.EndHookTransaction(WindowHandle);
    event.Free;
  end;
end;

procedure TReadingPaneVisibleChangeWindowWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (SetRedrawWindow = 0) then begin
        ReadingPaneHandleThatGetWMSETREDRAW := GetParent(self.WindowHandle);
        if (window = ReadingPaneHandleThatGetWMSETREDRAW) then begin
          SetRedrawWindow := self.WindowHandle;
          TMoveReadingPaneWindowWatchObject.SetSetRedrawWindow(self.WindowHandle);
          Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
        end;

    end;
  end;
end;

{ TSharingInspectorFinder }

function TSharingInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TSharingInspectorFinder: Not supported version');
end;

function TSharingInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TSharingInspectorFinder: Not supported version');
end;

function TSharingInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TSharingInspectorFinder: Not supported version');
end;

function TSharingInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TSharingInspectorFinder: Not supported version');
end;

function TSharingInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TMobileInspectorFinder }

function TMobileInspectorFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TMobileInspectorFinder: Not supported version');
end;

function TMobileInspectorFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TMobileInspectorFinder: Not supported version');
end;

function TMobileInspectorFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TMobileInspectorFinder: Not supported version');
end;

function TMobileInspectorFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  result := 0;
  //Case 2045 raise SysUtils.Exception.Create('TMobileInspectorFinder: Not supported version');
end;

function TMobileInspectorFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  if (Condition = [fwcDefault]) then begin
    H := FindChildWindowV(HostHandle, '', 'AfxWndW', '', false, false);
    Result := FindChildWindowV(H, '', 'AfxWndW', '', false, false);
  end
  else begin
    H := InternalFindChildWindow(HostHandle, '', 'AfxWndW', '', false, [fwcAnyVisibleState]);
    Result := InternalFindChildWindow(H, '', 'AfxWndW', '', false, Condition);
  end;
end;

{ TTodoBarOutlook2010WatchObject }

constructor TTodoBarOutlook2010WatchObject.Create(AHostHandle: HWND);
begin
  inherited Create();
  self.FHostHandle := AHostHandle;
  Finder := TToDoBarFinder.Create(v2010);
  CurrentLocation := [tlUnknown];
  CurrentWindowHandle := 0;
  PriorWindowHandle := 0;
  PriorLocation := [tlUnknown];
  PriorEvent := [tlUnknown];
  Host2010WasShowed := false;
  SetRedrawWindow := 0;
end;

destructor TTodoBarOutlook2010WatchObject.Destroy;
begin
  if Assigned(Finder) then begin
    Finder.Free;
    Finder := nil;
  end;
  inherited;
end;

procedure TTodoBarOutlook2010WatchObject.DoExecute;
var
  LocationChanged: boolean;
  flagWindow: HWND;
  TaskListOrAppointmentsItemWasEnabled: boolean;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TTodoBarOutlook2010WatchObject.DoExecute');
    Exit;
  end;

  if (not ExistsHostHandle()) then begin
    StopWatch := true;
    exit;
  end;

  CurrentWindowHandle := Finder.FindToDoBar2010(HostHandle, SetRedrawWindow, CurrentLocation);

  LocationChanged := (PriorLocation <> CurrentLocation);

  if (LocationChanged) then begin
    PrintLocation(PriorLocation, 'prior');
    PrintLocation(CurrentLocation, 'current');
    flagWindow := Finder.FindNetUINativeHWNDHost(HostHandle);  //Utils.GetAppWindowHandle((int)ADXHostVersion.v2010, AdxItemType.OlMail, HostHandle);
    if (MinimizedToDoBar(CurrentLocation)) then begin
      UpdatePriorInformation();
      PrintLocation(CurrentLocation, '+');
      Minimize();
      if (PriorEvent <> [tlMinimizedToDoBar]) then begin
        FormsManagerSingleton.RaiseTodoBarMinimizeEvent;
        PriorEvent := [tlMinimizedToDoBar];
      end;

      PrintLocation(CurrentLocation, '-');
      exit;
    end;
    if (OffToDoBar(CurrentLocation)) then begin
      UpdatePriorInformation();
      PrintLocation(CurrentLocation, '+');
      Hide();
      if (PriorEvent <> [tlOffToDoBar]) then begin
        FormsManagerSingleton.RaiseTodoBarHideEvent;
        PriorEvent := [tlOffToDoBar];
      end;

      PrintLocation(CurrentLocation, '-');
      exit;
    end;

    if (NormalToDoBar(CurrentLocation)) then begin

      if (PriorEvent <> [tlNormalToDoBar]) then begin
        FormsManagerSingleton.RaiseTodoBarShowEvent;
        PriorEvent := [tlNormalToDoBar];
      end;

      if (NoWindowForSubclasiing(CurrentLocation)) then begin
        UpdatePriorInformation();
        PrintLocation(CurrentLocation, '+');
        Hide();
        PrintLocation(CurrentLocation, '-');
      end
      else begin
          if ((flagWindow <> 0) and (not IsWindowVisible(flagWindow))) then begin
             exit;
          end;

          PrintLocation(CurrentLocation, '+');
          TaskListOrAppointmentsItemWasEnabled := NormalToDoBar(PriorLocation) and (CurrentWindowHandle <> PriorWindowHandle);
          if (TaskListOrAppointmentsItemWasEnabled) then begin
            Hide();
          end;
          UpdatePriorInformation();
          Show();
          PrintLocation(CurrentLocation, '-');
      end;
      exit;
    end;
  end;
end;

function TTodoBarOutlook2010WatchObject.ExistsHostHandle: boolean;
begin
  if (not Host2010WasShowed) then begin
    Host2010WasShowed := IsWindow(HostHandle) and IsWindowVisible(HostHandle);
  end;

  result := (IsWindow(HostHandle) and (not Host2010WasShowed or IsWindowVisible(HostHandle)));
end;

procedure TTodoBarOutlook2010WatchObject.Hide;
var
  event: TLogEvent;
  transactionHandle: HWND;
begin
  transactionHandle := PriorWindowHandle;
  if (PriorWindowHandle = 0) then begin
    transactionHandle := HostHandle;
  end;

  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP TTodoBarOutlook2010WatchObject.Hide');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(transactionHandle);
    FormsManagerSingleton.OnCommonExplorerWindowHide(HostHandle, stOlTodoBar);
  finally
    FormsManagerSingleton.EndHookTransaction(transactionHandle);
    event.Free;
  end;
end;

procedure TTodoBarOutlook2010WatchObject.Minimize;
var
  event: TLogEvent;
  transactionHandle: HWND;
begin
  transactionHandle := PriorWindowHandle;
  if (PriorWindowHandle = 0) then begin
    transactionHandle := HostHandle;
  end;

  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP TTodoBarOutlook2010WatchObject.Minimize');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowHide');
  try
    FormsManagerSingleton.StartHookTransaction(transactionHandle);
    FormsManagerSingleton.OnCommonExplorerWindowMinimize(HostHandle, stOlTodoBar);
  finally
    FormsManagerSingleton.EndHookTransaction(transactionHandle);
    event.Free;
  end;
end;

function TTodoBarOutlook2010WatchObject.MinimizedToDoBar(
  Location: TToDoBar2010Location): boolean;
begin
  result := tlMinimizedToDoBar in Location;
end;

function TTodoBarOutlook2010WatchObject.NoWindowForSubclasiing(
  Location: TToDoBar2010Location): boolean;
begin
  result := tlNoWindowForSubclasing in Location;
end;

function TTodoBarOutlook2010WatchObject.NormalToDoBar(
  Location: TToDoBar2010Location): boolean;
begin
  result := tlNormalToDoBar in Location;
end;

function TTodoBarOutlook2010WatchObject.OffToDoBar(
  Location: TToDoBar2010Location): boolean;
begin
  result := tlOffToDoBar in Location;
end;

procedure TTodoBarOutlook2010WatchObject.PrintLocation(Location: TToDoBar2010Location;
  sufix: string);
var
  s: string;
begin
  s := '';
  if tlNormalToDoBar in Location then s := s + 'tlNormalToDoBar, ';
  if tlOffToDoBar  in Location then s := s + 'tlOffToDoBar, ';
  if tlMinimizedToDoBar  in Location then s := s + 'tlMinimizedToDoBar, ';
  if tlNoWindowForSubclasing  in Location then s := s + 'tlNoWindowForSubclasing, ';
  if tlTaskList  in Location then s := s + 'tlTaskList, ';
  if tlAppointments  in Location then s := s + 'tlAppointments, ';

  TDebug.WriteLine('@@@@ Location: ' + s + ' - ' + IntToHex(CurrentWindowHandle, 8) + ', ' + sufix);
end;

procedure TTodoBarOutlook2010WatchObject.ProcessHookEvent(hWnd: THandle;
  Msg: UINT; wParam, lParam: Integer);
begin
  case Msg of
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED:
    //WM_SETREDRAW: This is necessary if we want to hide/show a form when a Outlook 2010 window is resized.
    DoExecute;
  end;
end;

procedure TTodoBarOutlook2010WatchObject.Show;
var
  event: TLogEvent;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    Log.AddMessage(Log.AddinName + ' @@@ SKIP TTodoBarOutlook2010WatchObject.Show');
    Exit;
  end;
  event := TLogEvent.Create(Log.AddinName + ' @@@ OnCommonExplorerWindowShow');
  try
    FormsManagerSingleton.StartHookTransaction(CurrentWindowHandle);
    FormsManagerSingleton.OnCommonExplorerWindowShow(HostHandle, stOlTodoBar);
  finally
    FormsManagerSingleton.EndHookTransaction(CurrentWindowHandle);
    event.Free;
  end;
end;

procedure TTodoBarOutlook2010WatchObject.UpdatePriorInformation;
begin
  PriorLocation := CurrentLocation;
  PriorWindowHandle := CurrentWindowHandle;
end;

procedure TTodoBarOutlook2010WatchObject.END_WM_SETREDRAW(window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = SetRedrawWindow) then begin
        SetRedrawWindow := 0;
        Log.AddMessage(self.ClassName + '.END_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
    DoExecute; //Case 1435
  end;
end;

procedure TTodoBarOutlook2010WatchObject.START_WM_SETREDRAW(window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = self.CurrentWindowHandle) then begin
        SetRedrawWindow := window;
        Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

{ TToDoBarFinder }

function TToDoBarFinder.InternalExistsChildWindow(Handle: HWND): boolean;
var
  NoteIconView: boolean;
begin
  result := ExistsChildWindow(Handle);
  if (result) then begin
    NoteIconView := (InternalFindChildWindow(Handle, 'Icon View', 'SysListView32', '', false, [fwcAnyVisibleState]) > 0);
    if (NoteIconView) then begin
      result := false;
    end;
  end;
end;

function TToDoBarFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TToDoBarFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TToDoBarFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TToDoBarFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
  FW: WideString;
begin
  FW:= '';
  H := FindChildWindowWithControlID(HostHandle, '', 'AfxWndW', '', false, $0068);
  Result := FindWindowFromPath(H, 'WUNDERBAR\NetUINativeHWNDHost\NetUIHWND\NetUICtrlNotifySink\', FW, true);
  if Result > 0 then Result:= GetParent(Result);
  if Result > 0 then Result:= GetParent(Result);
end;

function TToDoBarFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  Location: TToDoBar2010Location;
begin
  Result := FindToDoBar2010(HostHandle, 0, Location);
end;

function TToDoBarFinder.FindNetUINativeHWNDHost(HostHandle: HWND): HWND;
  var H: HWND;
begin
  H := InternalFindChildWindowWithControlID(HostHandle, '', 'NetUINativeHWNDHost', '', false, $68, true);
  Result := InternalFindChildWindow(H, '', 'NetUIHWND', '', false, [fwcAnyVisibleState]);
end;

function TToDoBarFinder.FindToDoBar2010(HostHandle: HWND; SetRedrawWindow: HWND;
  var Location: TToDoBar2010Location): HWND;
begin

  //Check Task List
  Result := InternalFindChildWindowWithControlID(HostHandle, '', 'SUPERGRID', '', false, $1265, true);
  if (IsWindowVisibleSetRedraw(result, SetRedrawWindow) and (not WindowIsHorizontalStrip(result))) then begin
    Location := [tlNormalToDoBar, tlTaskList];
    exit;
  end;

  //Check Appointments
  Result := InternalFindChildWindowWithControlID(HostHandle, '', 'AfxWndW', '', false, $6D, true, InternalExistsChildWindow);
  if (IsWindowVisibleSetRedraw(result, SetRedrawWindow) and (not WindowIsHorizontalStrip(result))) then begin
    Location := [tlNormalToDoBar, tlAppointments];
    exit;
  end;


  //All Items (Date Navigator, Appointments, Task List) are disabled
  Result := FindNetUINativeHWNDHost(HostHandle);


  if (IsWindowVisibleSetRedraw(Result, SetRedrawWindow)) then begin

    if (MinimizedToDoBar(Result)) then begin
      Location := [tlMinimizedToDoBar];
      result := 0;
      exit;
    end;

    Location := [tlNormalToDoBar, tlNoWindowForSubclasing];
    result := 0;
    exit;;
  end
  else begin
    Location := [tlOffToDoBar];
    result := 0;
    exit;
  end;

end;

class function TToDoBarFinder.MinimizedToDoBar(
  WindowHandle: HWND): boolean;
var
  R: TRect;
begin
  if (IsWindow(WindowHandle)) then begin
    GetWindowRect(windowHandle, R);
    result := (10 <= (R.Right - R.Left)) and((R.Right - R.Left) <= 34);  //Width = 28
  end
  else begin
    raise SysUtils.Exception.Create('WindowIsHorizontalStrip: Is Not Window');
  end;
end;

class function TToDoBarFinder.WindowIsHorizontalStrip(
  WindowHandle: HWND): boolean;
var
  R: TRect;
begin
  if (IsWindow(WindowHandle)) then begin
    GetWindowRect(windowHandle, R);
    result := ((R.Bottom - R.Top) <= 1);
  end
  else begin
    raise SysUtils.Exception.Create('WindowIsHorizontalStrip: Is Not Window');
  end;
end;

{ TOfficeTaskPaneFinder }

class function TOfficeTaskPaneFinder.FindWindow(AHostVersion: TadxHostVersion;
  HostHandle: HWND; WindowLayout: TadxWindowLayout): HWND;
var
  finder: TOfficeTaskPaneFinder;
begin
  Result:= 0;
  finder := TOfficeTaskPaneFinder.Create(AHostVersion);
  try
    case WindowLayout of
      wlDockBottom: begin
        result := finder.Find(HostHandle, [fwcAnyVisibleState, fwcDockBottom]);
        exit;
      end;
      wlDockTop: begin
        result := finder.Find(HostHandle, [fwcAnyVisibleState, fwcDockTop]);
        exit;
      end;
      wlDockRight: begin
        result := finder.Find(HostHandle, [fwcAnyVisibleState, fwcDockRight]);
        exit;
      end;
      wlDockLeft: begin
        result := finder.Find(HostHandle, [fwcAnyVisibleState, fwcDockLeft]);
        exit;
      end;
    end;
  finally
    finder.Free;
  end;
end;

function TOfficeTaskPaneFinder.FindIn2000(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TOfficeTaskPaneFinder.FindIn2002(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TOfficeTaskPaneFinder.FindIn2003(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
begin
  raise SysUtils.Exception.Create('Not supported version');
end;

function TOfficeTaskPaneFinder.FindIn2007(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  H:= 0; Result:= 0;
  if (IsDockRight(Condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockRight', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockLeft(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockLeft', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockTop(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockTop', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockBottom(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockBottom', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;

  if (H > 0) then begin
    // Result = InternalFindChildWindow(H, 'AdxServiceTP', 'MsoWorkPane', '', true, fwcAnyVisibleState);
    Result := InternalFindChildWindow(H, 'AdxServiceTP', 'MsoCommandBar', '', false, [fwcAnyVisibleState]);
  end;
end;

function TOfficeTaskPaneFinder.FindIn2010(HostHandle: HWND;
  Condition: TadxFindWindowConditions): HWND;
var
  H: HWND;
begin
  H:= 0; Result:= 0;
  if (IsDockRight(Condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockRight', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockLeft(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockLeft', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockTop(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockTop', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;
  if (IsDockBottom(condition)) then begin
    H := InternalFindChildWindow(HostHandle, 'MsoDockBottom', 'MsoCommandBarDock', '', false, [fwcAnyVisibleState]);
  end;

  if (H > 0) then begin
    Result := InternalFindChildWindow(H, 'AdxServiceTP', 'MsoCommandBar', '', false, [fwcAnyVisibleState]);
  end;
end;

function TOfficeTaskPaneFinder.IsDockBottom(
  Condition: TadxFindWindowConditions): boolean;
begin
  result :=  fwcDockBottom in Condition;
end;

function TOfficeTaskPaneFinder.IsDockLeft(
  Condition: TadxFindWindowConditions): boolean;
begin
  result :=  fwcDockLeft in Condition;
end;

function TOfficeTaskPaneFinder.IsDockRight(
  Condition: TadxFindWindowConditions): boolean;
begin
  result :=  fwcDockRight in Condition;
end;

function TOfficeTaskPaneFinder.IsDockTop(
  Condition: TadxFindWindowConditions): boolean;
begin
  result :=  fwcDockTop in Condition;
end;

{ TCTPVisibleChangedMessage }

constructor TCTPVisibleChangedMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TCTPVisibleChangedMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TCTPVisibleChangedMessage.GetMessageName: string;
begin
  result := Globals.WM_ADXCTP_VISIBLECHANGED;
end;

function TCTPVisibleChangedMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  CTPParams: TadxCTPVisibleParams;
begin
  if (FFormsManager <> nil) then begin
    CTPParams := PadxCTPVisibleParams(lParam)^;
    FFormsManager.DoCTPVisibleChanged(CTPParams);
  end;
  result := 0;
end;

procedure TNavigationPaneVisibleChangeWindowWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = self.WindowHandle) then begin
        SetRedrawWindow := window;
        Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

procedure TNavigationPaneVisibleMinimizeUnvisibleChangeWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  if (FormsManagerSingleton.FOutlookVersion = v2010) then begin
    if (window = self.WindowHandle) then begin
        SetRedrawWindow := window;
        Log.AddMessage(self.ClassName + '.START_WM_SETREDRAW ' + IntToHex(window, 8));
    end;
  end;
end;

{ TBackStageVisibleChangeWindowWatchObjectV2010 }

constructor TBackStageVisibleChangeWindowWatchObjectV2010.Create(
  AHostHandle: HWND; AHostVersion: Integer);
begin
  inherited Create();
  FHostHandle := AHostHandle;
  FHostVersion := AHostVersion;
  BackStageVisible := false;
end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.DoExecute;
var
  ExistsHostHandle: boolean;
  FullpageUIHost: HWND;
  MsoCommandBarDock: HWND;
  Ribbon: HWND;
  VisibleRibbon: boolean;
  event: TLogEvent;
begin
  if (FormsManagerSingleton.FHookTransactionWindowHandle > 0) then begin
    TDebug.WriteLine(Log.AddinName  + '@@@ SKIP TBackStageVisibleChangeWindowWatchObjectV2010.DoExecute');
    Exit;
  end;

  ExistsHostHandle := IsWindow(HostHandle);

  if (not ExistsHostHandle) then begin
    StopWatch := true;
    exit;
  end;

  FullpageUIHost := FindChildWindow(FHostHandle, '', 'FullpageUIHost', true, true);

  if (BackStageVisible) then begin
    if ((FullpageUIHost = 0)) then begin
      MsoCommandBarDock := FindChildWindow(FHostHandle, '', 'MsoCommandBarDock', true, true);
      Ribbon := 0;
      if (MsoCommandBarDock <> 0) then begin
        Ribbon := FindChildWindow(MsoCommandBarDock, 'Ribbon', 'MsoCommandBar', true, true);
      end;

      VisibleRibbon := (Ribbon <> 0) and (IsWindowVisible(Ribbon));
      if (VisibleRibbon) then begin
        BackStageVisible := false;

      event := TLogEvent.Create(Log.AddinName + ' @@@ DoHideBackStage');
      try
        FormsManagerSingleton.StartHookTransaction(FHostHandle);
        DoHideBackStage(FHostHandle);
      finally
        FormsManagerSingleton.EndHookTransaction(FHostHandle);
        event.Free;
      end;

      end;
    end;
  end
  else begin
    if ((FullpageUIHost <> 0)) then begin
      BackStageVisible := true;

      event := TLogEvent.Create(Log.AddinName + ' @@@ DoShowBackStage');
      try
        FormsManagerSingleton.StartHookTransaction(FHostHandle);
        DoShowBackStage(FHostHandle);
      finally
        FormsManagerSingleton.EndHookTransaction(FHostHandle);
        event.Free;
      end;

    end;
  end;

end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.DoHideBackStage(
  ExplorerHandle: HWND);
var
  LogEvent: TLogEvent;
begin
  LogEvent := TLogEvent.Create('HideBackStage');
  try
    FormsManagerSingleton.DoHideBackStage(ExplorerHandle);
  finally
    LogEvent.Free;
  end;
end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.DoShowBackStage(
  ExplorerHandle: HWND);
var
  LogEvent: TLogEvent;
begin
  LogEvent := TLogEvent.Create('ShowBackStage');
  try
    FormsManagerSingleton.DoShowBackStage(ExplorerHandle);
  finally
    LogEvent.Free;
  end;
end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.END_WM_SETREDRAW(
  window: HWND);
begin
  //
end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.ProcessHookEvent(
  hWnd: THandle; Msg: UINT; wParam, lParam: Integer);
begin
  case Msg of
    WM_SHOWWINDOW,
    WM_WINDOWPOSCHANGED:
    DoExecute;
  end;
end;

procedure TBackStageVisibleChangeWindowWatchObjectV2010.START_WM_SETREDRAW(
  window: HWND);
begin
  //
end;

{ TInformToShowDockLayoutMessage }

constructor TInformToShowDockLayoutMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TInformToShowDockLayoutMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TInformToShowDockLayoutMessage.GetMessageName: string;
begin
  result := GlobalsOL.WM_INFORMTOSHOWDOCKLAYOUT;
end;

function TInformToShowDockLayoutMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  DockPosition: integer;
begin
  DockPosition := wParam;
  if (FFormsManager <> nil) then begin
    FFormsManager.DoProcessInformAddinsToShowDockLayouts(DockPosition);
  end;
  result := 0;
end;

class function GlobalsOl.WM_INFORMTOSHOWDOCKLAYOUT: string;
begin
  result := 'WM_INFORMTOSHOWDOCKLAYOUT';
end;

{ TadxOlKeyFilterEventArgs }

constructor TadxOlKeyFilterEventArgs.Create(AAdxKeyInfo: TadxKeyInfo);
begin
  FAdxKeyInfo:= AAdxKeyInfo;
  FAction:= faSendToHostApplication;
end;

destructor TadxOlKeyFilterEventArgs.Destroy;
begin
  inherited;
end;

function TadxOlKeyFilterEventArgs.GetKeyCode: byte;
begin
  result:= FAdxKeyInfo.KeyCode
end;

function TadxOlKeyFilterEventArgs.GetKeyValue: Cardinal;
begin
  result:= FAdxKeyInfo.KeyValue;
end;

function TadxOlKeyFilterEventArgs.GetPressed: boolean;
begin
  result:= false;
  if FAdxKeyInfo.State = csPressed then
    result:= true;
end;

function TadxOlKeyFilterEventArgs.GetShiftState: TShiftState;
begin
  result:= [];
  if FAdxKeyInfo.Alt then Include(result, ssAlt);
  if FAdxKeyInfo.Control then Include(result, ssCtrl);
  if FAdxKeyInfo.Shift then Include(result, ssShift);
end;


{ TRefreshFolderMessage }

constructor TRefreshFolderMessage.Create(ReceiverHandle: HWND;
  AFormsManager: TadxOlFormsManager);
begin
  inherited Create(ReceiverHandle);
  FFormsManager := AFormsManager;
end;

destructor TRefreshFolderMessage.Destroy;
begin
  FFormsManager := nil;
  inherited;
end;

function TRefreshFolderMessage.GetMessageName: string;
begin
  result := GlobalsOL.WM_REFRESHFOLDER;
end;

function TRefreshFolderMessage.ProcessMessage(wParam,
  lParam: integer): integer;
var
  ExplorerWindowHandle: HWND;
begin
  ExplorerWindowHandle := wParam;
  FFormsManager.OnRefreshFolder(ExplorerWindowHandle);
  result := 0;
end;

class function GlobalsOl.WM_REFRESHFOLDER: string;
begin
  result := 'WM_REFRESHFOLDER';
end;

initialization
  TMoveReadingPaneWindowWatchObject_SetRedrawWindow := 0;
  FormsManagerSingleton := nil;
  {$IFDEF UNICODE}
  WM_REFRESHFOLDER := RegisterWindowMessage(PChar(GlobalsOL.WM_REFRESHFOLDER));
  WM_ADXDELETEEMULATEWINDOW := RegisterWindowMessage(PChar(Globals.WM_ADXDELETEEMULATEWINDOW));
  WM_ADXWMIPOSCHANGE := RegisterWindowMessage(PChar(Globals.WM_ADXWMIPOSCHANGE));
  WM_ADXEXIST := RegisterWindowMessage(PChar(Globals.WM_ADXEXIST));
  WM_ADXHIDEALLREGIONFORMS := RegisterWindowMessage(PChar(Globals.WM_ADXHIDEALLREGIONFORMS));
  WM_ADXEXISTSERVICEFORM := RegisterWindowMessage(PChar(Globals.WM_ADXEXISTSERVICEFORM));
  WM_ADX_CLOSE_READINGPANE_SERVICE_FORM := RegisterWindowMessage(PChar(GlobalsOL.WM_ADX_CLOSE_READINGPANE_SERVICE_FORM));
  WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM := RegisterWindowMessage(PChar(GlobalsOL.WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM));
  WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR := RegisterWindowMessage(PChar(GlobalsOL.WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR));
  WM_INFORMTOSHOWDOCKLAYOUT :=  RegisterWindowMessage(PChar(GlobalsOL.WM_INFORMTOSHOWDOCKLAYOUT));
  {$ELSE}
  WM_REFRESHFOLDER := RegisterWindowMessage(PansiChar(GlobalsOL.WM_REFRESHFOLDER));
  WM_ADXDELETEEMULATEWINDOW := RegisterWindowMessage(PansiChar(Globals.WM_ADXDELETEEMULATEWINDOW));
  WM_ADXWMIPOSCHANGE := RegisterWindowMessage(PansiChar(Globals.WM_ADXWMIPOSCHANGE));
  WM_ADXEXIST := RegisterWindowMessage(PansiChar(Globals.WM_ADXEXIST));
  WM_ADXHIDEALLREGIONFORMS := RegisterWindowMessage(PansiChar(Globals.WM_ADXHIDEALLREGIONFORMS));
  WM_ADXEXISTSERVICEFORM := RegisterWindowMessage(PansiChar(Globals.WM_ADXEXISTSERVICEFORM));
  WM_ADX_CLOSE_READINGPANE_SERVICE_FORM := RegisterWindowMessage(PansiChar(GlobalsOL.WM_ADX_CLOSE_READINGPANE_SERVICE_FORM));
  //WM_ADX_REFRESH_INSPECTOR_TAB := RegisterWindowMessage(PansiChar(GlobalsOL.WM_ADX_REFRESH_INSPECTOR_TAB));
  WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM := RegisterWindowMessage(PansiChar(GlobalsOL.WM_ADX_CLOSE_SUPERGRID_SERVICE_FORM));
  WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR := RegisterWindowMessage(PansiChar(GlobalsOL.WM_ADX_CLOSE_SERVICE_FORM_FOR_NOT_WORD_INSPECTOR));
  WM_INFORMTOSHOWDOCKLAYOUT :=  RegisterWindowMessage(PansiChar(GlobalsOL.WM_INFORMTOSHOWDOCKLAYOUT));
  {$ENDIF}
  WM_ADXGETAPPWINDOWPOS :=  RegisterWindowMessage('WM_ADXGETAPPWINDOWPOS');

{$ifdef MSWINDOWS}
  {$ifdef D_2}
  InitPlatformId;
  {$endif}
  if (Win32Platform  = VER_PLATFORM_WIN32_NT) and
     (((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) or
      (Win32MajorVersion > 5)) then
  begin
    hThemeLib := LoadLibrary(themelib);
    if hThemeLib <> 0 then
    begin
      {$IFDEF UNICODE}
      OpenThemeData := GetProcAddress(hThemeLib, PAnsiChar(AnsiString('OpenThemeData')));
      CloseThemeData := GetProcAddress(hThemeLib, PAnsiChar(AnsiString('CloseThemeData')));
      DrawThemeBackground := GetProcAddress(hThemeLib, PAnsiChar(AnsiString('DrawThemeBackground')));
      GetCurrentThemeName  := GetProcAddress(hThemeLib, PAnsiChar(AnsiString('GetCurrentThemeName')));
      {$ELSE}
      OpenThemeData := GetProcAddress(hThemeLib, 'OpenThemeData');
      CloseThemeData := GetProcAddress(hThemeLib, 'CloseThemeData');
      DrawThemeBackground := GetProcAddress(hThemeLib, 'DrawThemeBackground');
      GetCurrentThemeName  := GetProcAddress(hThemeLib, 'GetCurrentThemeName');
      {$ENDIF}

      ThemesAvailable := True;
      QueryThemeData := false;
      hTestTheme := OpenThemeData(0, 'WINDOW');
      if hTestTheme <> 0 then
      begin
        QueryThemeData := true;
        ClosethemeData(hTestTheme);
      end;
    end;
  end;
{$endif}

finalization
  ThemesAvailable := false;
  QueryThemeData := false;
  FreeLibrary(hThemeLib);
end.
