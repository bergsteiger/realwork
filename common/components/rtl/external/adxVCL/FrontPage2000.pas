{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit FrontPage2000;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// PASTLWTR : $Revision: 1.1 $
// File generated on 13.01.2003 00:03:35 from Type Library described below.

// *************************************************************************//
// NOTE:
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties
// which return objects that may need to be explicitly created via a function
// call prior to any access via the property. These items have been disabled
// in order to prevent accidental use from within the object inspector. You
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively
// removing them from the $IFDEF blocks. However, such items must still be
// programmatically created via a method of the appropriate CoClass before
// they can be used.
// ************************************************************************ //
// Type Lib: F:\Program Files\Microsoft Office\Office\frontpg.exe (1)
// IID\LCID: {3824BCD5-7042-11CE-8E17-0020AF9F9648}\0
// Helpfile: F:\Program Files\Microsoft Office\Office\vbafp4.chm
// DepndLst:
//   (1) v2.0 stdole, (F:\WINDOWS\system32\stdole2.tlb)
//   (2) v2.0 FrontPageEditor, (F:\PROGRA~1\MICROS~2\Office\FPEDITAX.DLL)
//   (3) v2.1 Office, (F:\Program Files\Microsoft Office\Office\MSO9.DLL)
//   (4) v4.0 StdVCL, (F:\WINDOWS\System32\STDVCL40.DLL)
// Errors:
//   Hint: Symbol 'System' renamed to 'System_'
//   Hint: Member 'File' of 'PageWindow' changed to 'File_'
//   Hint: Member 'File' of 'NavigationNode' changed to 'File_'
//   Hint: Member 'Label' of 'NavigationNode' changed to 'Label_'
//   Hint: Member 'Label' of 'Theme' changed to 'Label_'
//   Hint: Parameter 'type' of IExplorerWebs.SetEditor changed to 'type_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.

{$I adxDefs.inc}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL,
  FrontPageEditor2000, Office2000;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FrontPageMajorVersion = 1;
  FrontPageMinorVersion = 0;

  LIBID_FrontPage: TGUID = '{3824BCD5-7042-11CE-8E17-0020AF9F9648}';

  IID__IBaseFPObj: TGUID = '{98241550-9C43-11D1-83CE-006097ABE675}';
  IID__Application: TGUID = '{04DF1014-7007-11D1-83BC-006097ABE675}';
  IID_PageWindow: TGUID = '{48FB4014-D3D0-11D1-83D7-006097ABE675}';
  IID_WebFile: TGUID = '{48FB4049-D3D0-11D1-83D7-006097ABE675}';
  IID_Properties: TGUID = '{E67C7ADC-F4F5-11D1-B0E0-00C04FA30A8B}';
  IID_MetaTags: TGUID = '{2FC94518-0413-11D2-B0E9-00C04FA30A8B}';
  IID_NavigationNode: TGUID = '{C8905FB0-E5F2-11D1-B0DE-00C04FA30A8B}';
  IID_NavigationNodes: TGUID = '{435789D4-E5DC-11D1-B0DE-00C04FA30A8B}';
  IID_Web: TGUID = '{95B21741-CA4A-11D1-83D5-006097ABE675}';
  IID_WebWindow: TGUID = '{6B735741-FA41-11D1-83DC-006097ABE675}';
  IID_PageWindows: TGUID = '{48FB4042-D3D0-11D1-83D7-006097ABE675}';
  IID_WebFolder: TGUID = '{48FB404D-D3D0-11D1-83D7-006097ABE675}';
  IID_WebFiles: TGUID = '{48FB404F-D3D0-11D1-83D7-006097ABE675}';
  IID_WebFolders: TGUID = '{48FB4015-D3D0-11D1-83D7-006097ABE675}';
  IID_Themes: TGUID = '{48FB4046-D3D0-11D1-83D7-006097ABE675}';
  IID_Theme: TGUID = '{48FB4044-D3D0-11D1-83D7-006097ABE675}';
  IID_WebWindows: TGUID = '{6B735742-FA41-11D1-83DC-006097ABE675}';
  IID_System: TGUID = '{731EC3E0-9CC2-11D1-83CE-006097ABE675}';
  IID_Webs: TGUID = '{AAAA22E0-C834-11D1-83D4-006097ABE675}';
  DIID__IApplicationEvents: TGUID = '{F5D15700-E9D8-11D1-B0DF-00C04FA30A8B}';
  CLASS_Application: TGUID = '{04DF1015-7007-11D1-83BC-006097ABE675}';
  DIID_IWebber: TGUID = '{8BBD4A72-661D-11CF-A3C4-00A024184692}';
  CLASS_CWebberAutomation: TGUID = '{31B45997-FFA3-11CF-B35E-00A0C90A9044}';
  DIID_IPageEditor: TGUID = '{8BBD4A7B-661D-11CF-A3C4-00A024184692}';
  CLASS_CAutoJack: TGUID = '{31B4599B-FFA3-11CF-B35E-00A0C90A9044}';
  IID_IExplorerWebs: TGUID = '{9B5D039F-8DDB-11D1-A220-00A0C9055E81}';
  CLASS_ExplorerWebs: TGUID = '{9B5D03A0-8DDB-11D1-A220-00A0C9055E81}';
  IID_IExplorerWeb: TGUID = '{9B5D03A1-8DDB-11D1-A220-00A0C9055E81}';
  CLASS_ExplorerWeb: TGUID = '{9B5D03A2-8DDB-11D1-A220-00A0C9055E81}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum FpThemeProperties
type
  FpThemeProperties = TOleEnum;
const
  fpThemeNormalColors = $00000000;
  fpThemeNormalGraphics = $00000000;
  fpThemeNoBackgroundImage = $00000000;
  fpThemeNoCSS = $00000000;
  fpThemeActiveGraphics = $00000010;
  fpThemeBackgroundImage = $00000001;
  fpThemeVividColors = $00000100;
  fpThemeCSS = $00001000;
  fpThemePropertiesAll = $00001111;
  fpThemePropertiesNone = $00000000;
  fpThemeDefaultSettings = $01000000;
  fpThemeName = $02000000;

// Constants for enum FpStructModType
type
  FpStructModType = TOleEnum;
const
  fpStructBaseOnSibling = $00000000;
  fpStructLeftmostChild = $00000001;
  fpStructRightmostChild = $00000002;

// Constants for enum FpPageViewMode
type
  FpPageViewMode = TOleEnum;
const
  fpPageViewDefault = $00000000;
  fpPageViewNormal = $00000001;
  fpPageViewHtml = $00000002;
  fpPageViewNoFrames = $00000004;
  fpPageViewPreview = $00000008;
  fpPageViewNoWindow = $00000080;

// Constants for enum FpWebViewMode
type
  FpWebViewMode = TOleEnum;
const
  fpWebViewLinks = $00000000;
  fpWebViewFolders = $00000001;
  fpWebViewStructure = $00000002;
  fpWebViewPage = $00000003;
  fpWebViewAllFiles = $00000004;
  fpWebViewTodo = $00000005;
  fpWebViewBrokenLinks = $00000006;
  fpWebViewSiteSummary = $00000007;

// Constants for enum FpSharedBorders
type
  FpSharedBorders = TOleEnum;
const
  fpBorderTop = $00000001;
  fpBorderLeft = $00000002;
  fpBorderRight = $00000004;
  fpBorderBottom = $00000008;
  fpBorderAll = $000000FF;
  _fpBorderNone = $00000000;

// Constants for enum FpWebDeleteFlags
type
  FpWebDeleteFlags = TOleEnum;
const
  fpDeleteEntireWeb = $00000000;
  fpDeleteFrontPageInfoFromWeb = $00000001;

// Constants for enum FpWebPublishFlags
type
  FpWebPublishFlags = TOleEnum;
const
  fpPublishNone = $00000000;
  fpPublishIncremental = $00000001;
  fpPublishAddToExistingWeb = $00000002;
  fpPublishCopySubwebs = $00000004;

// Constants for enum __MIDL___MIDL_itf_webber_0210_0001
type
  __MIDL___MIDL_itf_webber_0210_0001 = TOleEnum;
const
  eOpenInNewWindow = $00000000;
  eOpenInCurrentWindow = $00000001;
  eOpenNoWindow = $00000002;

// Constants for enum __MIDL___MIDL_itf_webber_0210_0002
type
  __MIDL___MIDL_itf_webber_0210_0002 = TOleEnum;
const
  eRequestGet = $00000000;
  eRequestForEdit = $00000001;
  eRequestFromFPSE = $00000002;
  eRequestFromFPSEIfWebOpen = $00000003;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  _IBaseFPObj = interface;
  _IBaseFPObjDisp = dispinterface;
  _Application = interface;
  _ApplicationDisp = dispinterface;
  PageWindow = interface;
  PageWindowDisp = dispinterface;
  WebFile = interface;
  WebFileDisp = dispinterface;
  Properties = interface;
  PropertiesDisp = dispinterface;
  MetaTags = interface;
  MetaTagsDisp = dispinterface;
  NavigationNode = interface;
  NavigationNodeDisp = dispinterface;
  NavigationNodes = interface;
  NavigationNodesDisp = dispinterface;
  Web = interface;
  WebDisp = dispinterface;
  WebWindow = interface;
  WebWindowDisp = dispinterface;
  PageWindows = interface;
  PageWindowsDisp = dispinterface;
  WebFolder = interface;
  WebFolderDisp = dispinterface;
  WebFiles = interface;
  WebFilesDisp = dispinterface;
  WebFolders = interface;
  WebFoldersDisp = dispinterface;
  Themes = interface;
  ThemesDisp = dispinterface;
  Theme = interface;
  ThemeDisp = dispinterface;
  WebWindows = interface;
  WebWindowsDisp = dispinterface;
  System = interface;
  SystemDisp = dispinterface;
  Webs = interface;
  WebsDisp = dispinterface;
  _IApplicationEvents = dispinterface;
  IWebber = dispinterface;
  IPageEditor = dispinterface;
  IExplorerWebs = interface;
  IExplorerWebsDisp = dispinterface;
  IExplorerWeb = interface;
  IExplorerWebDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Application = _Application;
  CWebberAutomation = IWebber;
  CAutoJack = IPageEditor;
  ExplorerWebs = IExplorerWebs;
  ExplorerWeb = IExplorerWeb;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PPSafeArray1 = ^PSafeArray; {*}
  PWordBool1 = ^WordBool; {*}
  PWideString1 = ^WideString; {*}
  PInteger1 = ^Integer; {*}

  WebOpenFlags = __MIDL___MIDL_itf_webber_0210_0001;
  RequestDocumentsFlags = __MIDL___MIDL_itf_webber_0210_0002;

// *********************************************************************//
// Interface: _IBaseFPObj
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {98241550-9C43-11D1-83CE-006097ABE675}
// *********************************************************************//
  _IBaseFPObj = interface(IDispatch)
    ['{98241550-9C43-11D1-83CE-006097ABE675}']
    function  Get_Application: _Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    property Application: _Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  _IBaseFPObjDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {98241550-9C43-11D1-83CE-006097ABE675}
// *********************************************************************//
  _IBaseFPObjDisp = dispinterface
    ['{98241550-9C43-11D1-83CE-006097ABE675}']
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: _Application
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {04DF1014-7007-11D1-83BC-006097ABE675}
// *********************************************************************//
  _Application = interface(IDispatch)
    ['{04DF1014-7007-11D1-83BC-006097ABE675}']
    function  Get_Application: _Application; safecall;
    function  Get_ActiveDocument: IHTMLDocument2; safecall;
    function  Get_ActivePageWindow: PageWindow; safecall;
    function  Get_ActiveWeb: Web; safecall;
    function  Get_ActiveWebWindow: WebWindow; safecall;
    function  Get_AnswerWizard: AnswerWizard; safecall;
    function  Get_Build: WideString; safecall;
    function  Get_COMAddIns: COMAddIns; safecall;
    function  Get_CommandBars: CommandBars; safecall;
    function  Get_FileSearch: FileSearch; safecall;
    function  Get_LanguageSettings: LanguageSettings; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_OrganizationName: WideString; safecall;
    function  Get_System_: System; safecall;
    function  Get_Themes: Themes; safecall;
    function  Get_UserName: WideString; safecall;
    procedure Set_UserName(const pVal: WideString); safecall;
    function  Get_Version: WideString; safecall;
    function  Get_Webs: Webs; safecall;
    function  Get_WebWindows: WebWindows; safecall;
    function  Get_ProductCode: WideString; safecall;
    function  LocatePage(const DocumentUrl: WideString; ViewMode: FpPageViewMode): PageWindow; safecall;
    function  MakeAbs(var UrlBase: OleVariant; const Url: WideString): WideString; safecall;
    function  MakeRel(var UrlBase: OleVariant; const Url: WideString): WideString; safecall;
    procedure Quit; safecall;
    function  Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant; safecall;
    property Application: _Application read Get_Application;
    property ActiveDocument: IHTMLDocument2 read Get_ActiveDocument;
    property ActivePageWindow: PageWindow read Get_ActivePageWindow;
    property ActiveWeb: Web read Get_ActiveWeb;
    property ActiveWebWindow: WebWindow read Get_ActiveWebWindow;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
    property Build: WideString read Get_Build;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property CommandBars: CommandBars read Get_CommandBars;
    property FileSearch: FileSearch read Get_FileSearch;
    property LanguageSettings: LanguageSettings read Get_LanguageSettings;
    property Name: WideString read Get_Name;
    property OrganizationName: WideString read Get_OrganizationName;
    property System_: System read Get_System_;
    property Themes: Themes read Get_Themes;
    property UserName: WideString read Get_UserName write Set_UserName;
    property Version: WideString read Get_Version;
    property Webs: Webs read Get_Webs;
    property WebWindows: WebWindows read Get_WebWindows;
    property ProductCode: WideString read Get_ProductCode;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {04DF1014-7007-11D1-83BC-006097ABE675}
// *********************************************************************//
  _ApplicationDisp = dispinterface
    ['{04DF1014-7007-11D1-83BC-006097ABE675}']
    property Application: _Application readonly dispid 1;
    property ActiveDocument: IHTMLDocument2 readonly dispid 2;
    property ActivePageWindow: PageWindow readonly dispid 3;
    property ActiveWeb: Web readonly dispid 4;
    property ActiveWebWindow: WebWindow readonly dispid 5;
    property AnswerWizard: AnswerWizard readonly dispid 6;
    property Build: WideString readonly dispid 7;
    property COMAddIns: COMAddIns readonly dispid 8;
    property CommandBars: CommandBars readonly dispid 9;
    property FileSearch: FileSearch readonly dispid 10;
    property LanguageSettings: LanguageSettings readonly dispid 11;
    property Name: WideString readonly dispid 0;
    property OrganizationName: WideString readonly dispid 12;
    property System_: System readonly dispid 13;
    property Themes: Themes readonly dispid 14;
    property UserName: WideString dispid 15;
    property Version: WideString readonly dispid 16;
    property Webs: Webs readonly dispid 17;
    property WebWindows: WebWindows readonly dispid 18;
    property ProductCode: WideString readonly dispid 20;
    function  LocatePage(const DocumentUrl: WideString; ViewMode: FpPageViewMode): PageWindow; dispid 21;
    function  MakeAbs(var UrlBase: OleVariant; const Url: WideString): WideString; dispid 22;
    function  MakeRel(var UrlBase: OleVariant; const Url: WideString): WideString; dispid 23;
    procedure Quit; dispid 24;
    function  Run(const MacroName: WideString; var safeArrayOfParams: {??PSafeArray} OleVariant): OleVariant; dispid 25;
  end;

// *********************************************************************//
// Interface: PageWindow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4014-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  PageWindow = interface(_IBaseFPObj)
    ['{48FB4014-D3D0-11D1-83D7-006097ABE675}']
    function  Get_ActiveDocument: IHTMLDocument2; safecall;
    function  Get_ActiveFrameWindow: IHTMLWindow2; safecall;
    function  Get_Caption: WideString; safecall;
    function  Get_Document: IHTMLDocument2; safecall;
    function  Get_File_: WebFile; safecall;
    function  Get_FrameWindow: IHTMLWindow2; safecall;
    function  Get_IsDirty: WordBool; safecall;
    function  Get_ThemeProperties(PropertyIndex: FpThemeProperties): OleVariant; safecall;
    function  Get_ViewMode: FpPageViewMode; safecall;
    procedure Set_ViewMode(pviewMode: FpPageViewMode); safecall;
    function  Get_Visible: WordBool; safecall;
    function  Get_Web: Web; safecall;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); safecall;
    procedure Close(ForceSave: WordBool); safecall;
    procedure Refresh(SaveChanges: WordBool); safecall;
    procedure Save(ForceOverwrite: WordBool); safecall;
    procedure SaveAs(const DestinationUrl: WideString; ForceOverwrite: WordBool); safecall;
    procedure Activate; safecall;
    property ActiveDocument: IHTMLDocument2 read Get_ActiveDocument;
    property ActiveFrameWindow: IHTMLWindow2 read Get_ActiveFrameWindow;
    property Caption: WideString read Get_Caption;
    property Document: IHTMLDocument2 read Get_Document;
    property File_: WebFile read Get_File_;
    property FrameWindow: IHTMLWindow2 read Get_FrameWindow;
    property IsDirty: WordBool read Get_IsDirty;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant read Get_ThemeProperties;
    property ViewMode: FpPageViewMode read Get_ViewMode write Set_ViewMode;
    property Visible: WordBool read Get_Visible;
    property Web: Web read Get_Web;
  end;

// *********************************************************************//
// DispIntf:  PageWindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4014-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  PageWindowDisp = dispinterface
    ['{48FB4014-D3D0-11D1-83D7-006097ABE675}']
    property ActiveDocument: IHTMLDocument2 readonly dispid 3;
    property ActiveFrameWindow: IHTMLWindow2 readonly dispid 4;
    property Caption: WideString readonly dispid 0;
    property Document: IHTMLDocument2 readonly dispid 6;
    property File_: WebFile readonly dispid 7;
    property FrameWindow: IHTMLWindow2 readonly dispid 8;
    property IsDirty: WordBool readonly dispid 9;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant readonly dispid 10;
    property ViewMode: FpPageViewMode dispid 11;
    property Visible: WordBool readonly dispid 12;
    property Web: Web readonly dispid 13;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); dispid 14;
    procedure Close(ForceSave: WordBool); dispid 15;
    procedure Refresh(SaveChanges: WordBool); dispid 16;
    procedure Save(ForceOverwrite: WordBool); dispid 17;
    procedure SaveAs(const DestinationUrl: WideString; ForceOverwrite: WordBool); dispid 18;
    procedure Activate; dispid 19;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebFile
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4049-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFile = interface(_IBaseFPObj)
    ['{48FB4049-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Creator: WideString; safecall;
    function  Get_CheckedoutBy: WideString; safecall;
    function  Get_Extension: WideString; safecall;
    function  Get_IsOpen: WordBool; safecall;
    function  Get_Properties: Properties; safecall;
    function  Get_MetaTags: MetaTags; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_NavigationNode: NavigationNode; safecall;
    function  Get_SharedBorders(BorderIndex: FpSharedBorders): OleVariant; safecall;
    procedure Set_SharedBorders(BorderIndex: FpSharedBorders; var ppv: OleVariant); safecall;
    function  Get_ThemeProperties(PropertyIndex: FpThemeProperties): OleVariant; safecall;
    function  Get_Title: WideString; safecall;
    procedure Set_Title(const pbzTitle: WideString); safecall;
    function  Get_Url: WideString; safecall;
    function  Get_Web: Web; safecall;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); safecall;
    procedure Checkin(const Comment: WideString; KeepCheckedout: WordBool); safecall;
    procedure Checkout(ForceCheckout: WordBool); safecall;
    procedure Copy(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); safecall;
    procedure Delete; safecall;
    function  Edit(ViewMode: FpPageViewMode): PageWindow; safecall;
    procedure Move(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); safecall;
    procedure Open; safecall;
    procedure UndoCheckout; safecall;
    property Creator: WideString read Get_Creator;
    property CheckedoutBy: WideString read Get_CheckedoutBy;
    property Extension: WideString read Get_Extension;
    property IsOpen: WordBool read Get_IsOpen;
    property Properties: Properties read Get_Properties;
    property MetaTags: MetaTags read Get_MetaTags;
    property Name: WideString read Get_Name;
    property NavigationNode: NavigationNode read Get_NavigationNode;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant read Get_ThemeProperties;
    property Title: WideString read Get_Title write Set_Title;
    property Url: WideString read Get_Url;
    property Web: Web read Get_Web;
  end;

// *********************************************************************//
// DispIntf:  WebFileDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4049-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFileDisp = dispinterface
    ['{48FB4049-D3D0-11D1-83D7-006097ABE675}']
    property Creator: WideString readonly dispid 3;
    property CheckedoutBy: WideString readonly dispid 4;
    property Extension: WideString readonly dispid 5;
    property IsOpen: WordBool readonly dispid 6;
    property Properties: Properties readonly dispid 7;
    property MetaTags: MetaTags readonly dispid 8;
    property Name: WideString readonly dispid 9;
    property NavigationNode: NavigationNode readonly dispid 10;
    function  SharedBorders(BorderIndex: FpSharedBorders): OleVariant; dispid 11;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant readonly dispid 12;
    property Title: WideString dispid 13;
    property Url: WideString readonly dispid 0;
    property Web: Web readonly dispid 15;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); dispid 16;
    procedure Checkin(const Comment: WideString; KeepCheckedout: WordBool); dispid 17;
    procedure Checkout(ForceCheckout: WordBool); dispid 18;
    procedure Copy(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); dispid 19;
    procedure Delete; dispid 20;
    function  Edit(ViewMode: FpPageViewMode): PageWindow; dispid 21;
    procedure Move(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); dispid 22;
    procedure Open; dispid 23;
    procedure UndoCheckout; dispid 24;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: Properties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E67C7ADC-F4F5-11D1-B0E0-00C04FA30A8B}
// *********************************************************************//
  Properties = interface(_IBaseFPObj)
    ['{E67C7ADC-F4F5-11D1-B0E0-00C04FA30A8B}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(const PropertyKey: WideString): OleVariant; safecall;
    procedure Set_Item(const PropertyKey: WideString; var ppvtVal: OleVariant); safecall;
    procedure Add(const PropertyKey: WideString; var PropertyValue: OleVariant); safecall;
    procedure Delete(const PropertyKey: WideString); safecall;
    procedure ApplyChanges; safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  PropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {E67C7ADC-F4F5-11D1-B0E0-00C04FA30A8B}
// *********************************************************************//
  PropertiesDisp = dispinterface
    ['{E67C7ADC-F4F5-11D1-B0E0-00C04FA30A8B}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(const PropertyKey: WideString): OleVariant; dispid 0;
    procedure Add(const PropertyKey: WideString; var PropertyValue: OleVariant); dispid 4;
    procedure Delete(const PropertyKey: WideString); dispid 5;
    procedure ApplyChanges; dispid 6;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: MetaTags
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FC94518-0413-11D2-B0E9-00C04FA30A8B}
// *********************************************************************//
  MetaTags = interface(_IBaseFPObj)
    ['{2FC94518-0413-11D2-B0E9-00C04FA30A8B}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(const PropertyKey: WideString): OleVariant; safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[const PropertyKey: WideString]: OleVariant read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  MetaTagsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {2FC94518-0413-11D2-B0E9-00C04FA30A8B}
// *********************************************************************//
  MetaTagsDisp = dispinterface
    ['{2FC94518-0413-11D2-B0E9-00C04FA30A8B}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[const PropertyKey: WideString]: OleVariant readonly dispid 0; default;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: NavigationNode
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C8905FB0-E5F2-11D1-B0DE-00C04FA30A8B}
// *********************************************************************//
  NavigationNode = interface(_IBaseFPObj)
    ['{C8905FB0-E5F2-11D1-B0DE-00C04FA30A8B}']
    function  Get_Children: NavigationNodes; safecall;
    function  Get_File_: WebFile; safecall;
    function  Get_Home: NavigationNode; safecall;
    function  Get_Label_: WideString; safecall;
    procedure Set_Label_(const pbzNavViewNodeLabel: WideString); safecall;
    function  Get_Url: WideString; safecall;
    function  Get_Next: NavigationNode; safecall;
    function  Get_Prev: NavigationNode; safecall;
    function  Get_Web: Web; safecall;
    function  Move(const NodeCollection: NavigationNodes; var NewLeftSibling: OleVariant): NavigationNode; safecall;
    property Children: NavigationNodes read Get_Children;
    property File_: WebFile read Get_File_;
    property Home: NavigationNode read Get_Home;
    property Label_: WideString read Get_Label_ write Set_Label_;
    property Url: WideString read Get_Url;
    property Next: NavigationNode read Get_Next;
    property Prev: NavigationNode read Get_Prev;
    property Web: Web read Get_Web;
  end;

// *********************************************************************//
// DispIntf:  NavigationNodeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C8905FB0-E5F2-11D1-B0DE-00C04FA30A8B}
// *********************************************************************//
  NavigationNodeDisp = dispinterface
    ['{C8905FB0-E5F2-11D1-B0DE-00C04FA30A8B}']
    property Children: NavigationNodes readonly dispid 3;
    property File_: WebFile readonly dispid 4;
    property Home: NavigationNode readonly dispid 5;
    property Label_: WideString dispid 6;
    property Url: WideString readonly dispid 0;
    property Next: NavigationNode readonly dispid 8;
    property Prev: NavigationNode readonly dispid 9;
    property Web: Web readonly dispid 10;
    function  Move(const NodeCollection: NavigationNodes; var NewLeftSibling: OleVariant): NavigationNode; dispid 11;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: NavigationNodes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {435789D4-E5DC-11D1-B0DE-00C04FA30A8B}
// *********************************************************************//
  NavigationNodes = interface(_IBaseFPObj)
    ['{435789D4-E5DC-11D1-B0DE-00C04FA30A8B}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): NavigationNode; safecall;
    function  Add(const Url: WideString; const NodeLabel: WideString;
                  ModificationType: FpStructModType; var LeftSibling: OleVariant): NavigationNode; safecall;
    procedure Delete(var Index: OleVariant); safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: NavigationNode read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  NavigationNodesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {435789D4-E5DC-11D1-B0DE-00C04FA30A8B}
// *********************************************************************//
  NavigationNodesDisp = dispinterface
    ['{435789D4-E5DC-11D1-B0DE-00C04FA30A8B}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: NavigationNode readonly dispid 0; default;
    function  Add(const Url: WideString; const NodeLabel: WideString;
                  ModificationType: FpStructModType; var LeftSibling: OleVariant): NavigationNode; dispid 4;
    procedure Delete(var Index: OleVariant); dispid 5;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: Web
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {95B21741-CA4A-11D1-83D5-006097ABE675}
// *********************************************************************//
  Web = interface(_IBaseFPObj)
    ['{95B21741-CA4A-11D1-83D5-006097ABE675}']
    function  Get_ActiveWebWindow: WebWindow; safecall;
    function  Get_AllowsLongFilenames: WordBool; safecall;
    function  Get_RootNavigationNode: NavigationNode; safecall;
    function  Get_HomeNavigationNode: NavigationNode; safecall;
    function  Get_IsUnderRevisionControl: WordBool; safecall;
    function  Get_Properties: Properties; safecall;
    function  Get_RevisionControlProject: WideString; safecall;
    procedure Set_RevisionControlProject(const pbzRCSProjectName: WideString); safecall;
    function  Get_RootFolder: WebFolder; safecall;
    function  Get_SharedBorders(BorderIndex: FpSharedBorders): OleVariant; safecall;
    procedure Set_SharedBorders(BorderIndex: FpSharedBorders; var ppv: OleVariant); safecall;
    function  Get_ThemeProperties(PropertyIndex: FpThemeProperties): OleVariant; safecall;
    function  Get_Themes: Themes; safecall;
    function  Get_Title: WideString; safecall;
    procedure Set_Title(const szWebTitle: WideString); safecall;
    function  Get_Url: WideString; safecall;
    function  Get_WebWindows: WebWindows; safecall;
    procedure Activate; safecall;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); safecall;
    procedure CancelRequests; safecall;
    procedure Close; safecall;
    procedure Delete(WebDeleteFlags: FpWebDeleteFlags); safecall;
    function  LocateFile(const FileUrl: WideString): WebFile; safecall;
    function  LocateFolder(const FolderUrl: WideString): WebFolder; safecall;
    function  LocatePage(const FileUrl: WideString; ViewMode: FpPageViewMode): PageWindow; safecall;
    procedure Publish(const DestinationUrl: WideString; PublishFlags: FpWebPublishFlags;
                      const UserName: WideString; const Password: WideString); safecall;
    procedure RecalcHyperlinks; safecall;
    procedure Refresh(FetchAll: WordBool); safecall;
    procedure ApplyNavigationStructure; safecall;
    property ActiveWebWindow: WebWindow read Get_ActiveWebWindow;
    property AllowsLongFilenames: WordBool read Get_AllowsLongFilenames;
    property RootNavigationNode: NavigationNode read Get_RootNavigationNode;
    property HomeNavigationNode: NavigationNode read Get_HomeNavigationNode;
    property IsUnderRevisionControl: WordBool read Get_IsUnderRevisionControl;
    property Properties: Properties read Get_Properties;
    property RevisionControlProject: WideString read Get_RevisionControlProject write Set_RevisionControlProject;
    property RootFolder: WebFolder read Get_RootFolder;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant read Get_ThemeProperties;
    property Themes: Themes read Get_Themes;
    property Title: WideString read Get_Title write Set_Title;
    property Url: WideString read Get_Url;
    property WebWindows: WebWindows read Get_WebWindows;
  end;

// *********************************************************************//
// DispIntf:  WebDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {95B21741-CA4A-11D1-83D5-006097ABE675}
// *********************************************************************//
  WebDisp = dispinterface
    ['{95B21741-CA4A-11D1-83D5-006097ABE675}']
    property ActiveWebWindow: WebWindow readonly dispid 3;
    property AllowsLongFilenames: WordBool readonly dispid 4;
    property RootNavigationNode: NavigationNode readonly dispid 5;
    property HomeNavigationNode: NavigationNode readonly dispid 6;
    property IsUnderRevisionControl: WordBool readonly dispid 7;
    property Properties: Properties readonly dispid 8;
    property RevisionControlProject: WideString dispid 9;
    property RootFolder: WebFolder readonly dispid 10;
    function  SharedBorders(BorderIndex: FpSharedBorders): OleVariant; dispid 11;
    property ThemeProperties[PropertyIndex: FpThemeProperties]: OleVariant readonly dispid 12;
    property Themes: Themes readonly dispid 13;
    property Title: WideString dispid 14;
    property Url: WideString readonly dispid 0;
    property WebWindows: WebWindows readonly dispid 16;
    procedure Activate; dispid 17;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); dispid 18;
    procedure CancelRequests; dispid 19;
    procedure Close; dispid 20;
    procedure Delete(WebDeleteFlags: FpWebDeleteFlags); dispid 21;
    function  LocateFile(const FileUrl: WideString): WebFile; dispid 22;
    function  LocateFolder(const FolderUrl: WideString): WebFolder; dispid 23;
    function  LocatePage(const FileUrl: WideString; ViewMode: FpPageViewMode): PageWindow; dispid 24;
    procedure Publish(const DestinationUrl: WideString; PublishFlags: FpWebPublishFlags;
                      const UserName: WideString; const Password: WideString); dispid 25;
    procedure RecalcHyperlinks; dispid 26;
    procedure Refresh(FetchAll: WordBool); dispid 27;
    procedure ApplyNavigationStructure; dispid 28;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebWindow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6B735741-FA41-11D1-83DC-006097ABE675}
// *********************************************************************//
  WebWindow = interface(_IBaseFPObj)
    ['{6B735741-FA41-11D1-83DC-006097ABE675}']
    function  Get_ActivePageWindow: PageWindow; safecall;
    function  Get_Caption: WideString; safecall;
    function  Get_Web: Web; safecall;
    function  Get_PageWindows: PageWindows; safecall;
    function  Get_ViewMode: FpWebViewMode; safecall;
    procedure Set_ViewMode(pviewMode: FpWebViewMode); safecall;
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(pfIsWindowVisible: WordBool); safecall;
    function  Get_SelectedFiles: PSafeArray; safecall;
    function  Get_SelectedFolders: PSafeArray; safecall;
    procedure Activate; safecall;
    procedure Close; safecall;
    property ActivePageWindow: PageWindow read Get_ActivePageWindow;
    property Caption: WideString read Get_Caption;
    property Web: Web read Get_Web;
    property PageWindows: PageWindows read Get_PageWindows;
    property ViewMode: FpWebViewMode read Get_ViewMode write Set_ViewMode;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property SelectedFiles: PSafeArray read Get_SelectedFiles;
    property SelectedFolders: PSafeArray read Get_SelectedFolders;
  end;

// *********************************************************************//
// DispIntf:  WebWindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6B735741-FA41-11D1-83DC-006097ABE675}
// *********************************************************************//
  WebWindowDisp = dispinterface
    ['{6B735741-FA41-11D1-83DC-006097ABE675}']
    property ActivePageWindow: PageWindow readonly dispid 3;
    property Caption: WideString readonly dispid 0;
    property Web: Web readonly dispid 5;
    property PageWindows: PageWindows readonly dispid 6;
    property ViewMode: FpWebViewMode dispid 7;
    property Visible: WordBool dispid 8;
    property SelectedFiles: {??PSafeArray} OleVariant readonly dispid 9;
    property SelectedFolders: {??PSafeArray} OleVariant readonly dispid 10;
    procedure Activate; dispid 11;
    procedure Close; dispid 12;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: PageWindows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4042-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  PageWindows = interface(_IBaseFPObj)
    ['{48FB4042-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): PageWindow; safecall;
    function  Add(const FileUrl: WideString): PageWindow; safecall;
    procedure Close(var Index: OleVariant; ForceSave: WordBool); safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: PageWindow read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  PageWindowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4042-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  PageWindowsDisp = dispinterface
    ['{48FB4042-D3D0-11D1-83D7-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: PageWindow readonly dispid 0; default;
    function  Add(const FileUrl: WideString): PageWindow; dispid 4;
    procedure Close(var Index: OleVariant; ForceSave: WordBool); dispid 5;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebFolder
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB404D-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFolder = interface(_IBaseFPObj)
    ['{48FB404D-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Files: WebFiles; safecall;
    function  Get_Folders: WebFolders; safecall;
    function  Get_IsExecutable: WordBool; safecall;
    procedure Set_IsExecutable(pfIsExecutable: WordBool); safecall;
    function  Get_IsReadable: WordBool; safecall;
    procedure Set_IsReadable(pfIsReadable: WordBool); safecall;
    function  Get_IsRoot: WordBool; safecall;
    function  Get_IsWeb: WordBool; safecall;
    function  Get_IsWritable: WordBool; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Properties: Properties; safecall;
    function  Get_Url: WideString; safecall;
    function  Get_Web: Web; safecall;
    procedure Copy(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); safecall;
    procedure Delete; safecall;
    procedure MakeWeb(const UserName: WideString; const Password: WideString); safecall;
    procedure RemoveWeb(const UserName: WideString; const Password: WideString); safecall;
    procedure Move(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); safecall;
    property Files: WebFiles read Get_Files;
    property Folders: WebFolders read Get_Folders;
    property IsExecutable: WordBool read Get_IsExecutable write Set_IsExecutable;
    property IsReadable: WordBool read Get_IsReadable write Set_IsReadable;
    property IsRoot: WordBool read Get_IsRoot;
    property IsWeb: WordBool read Get_IsWeb;
    property IsWritable: WordBool read Get_IsWritable;
    property Name: WideString read Get_Name;
    property Properties: Properties read Get_Properties;
    property Url: WideString read Get_Url;
    property Web: Web read Get_Web;
  end;

// *********************************************************************//
// DispIntf:  WebFolderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB404D-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFolderDisp = dispinterface
    ['{48FB404D-D3D0-11D1-83D7-006097ABE675}']
    property Files: WebFiles readonly dispid 3;
    property Folders: WebFolders readonly dispid 4;
    property IsExecutable: WordBool dispid 5;
    property IsReadable: WordBool dispid 6;
    property IsRoot: WordBool readonly dispid 7;
    property IsWeb: WordBool readonly dispid 8;
    property IsWritable: WordBool readonly dispid 9;
    property Name: WideString readonly dispid 10;
    property Properties: Properties readonly dispid 11;
    property Url: WideString readonly dispid 0;
    property Web: Web readonly dispid 13;
    procedure Copy(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); dispid 14;
    procedure Delete; dispid 15;
    procedure MakeWeb(const UserName: WideString; const Password: WideString); dispid 16;
    procedure RemoveWeb(const UserName: WideString; const Password: WideString); dispid 17;
    procedure Move(const DestinationUrl: WideString; UpdateLinks: WordBool; ForceOverwrite: WordBool); dispid 18;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebFiles
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB404F-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFiles = interface(_IBaseFPObj)
    ['{48FB404F-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): WebFile; safecall;
    function  Add(const FileUrl: WideString; ForceOverwrite: WordBool): WebFile; safecall;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); safecall;
    procedure Delete(var Index: OleVariant); safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: WebFile read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  WebFilesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB404F-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFilesDisp = dispinterface
    ['{48FB404F-D3D0-11D1-83D7-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: WebFile readonly dispid 0; default;
    function  Add(const FileUrl: WideString; ForceOverwrite: WordBool): WebFile; dispid 4;
    procedure ApplyTheme(const ThemeName: WideString; ThemeProperties: FpThemeProperties); dispid 5;
    procedure Delete(var Index: OleVariant); dispid 6;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebFolders
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4015-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFolders = interface(_IBaseFPObj)
    ['{48FB4015-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): WebFolder; safecall;
    function  Add(const FolderUrl: WideString): WebFolder; safecall;
    procedure Delete(var Index: OleVariant); safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: WebFolder read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  WebFoldersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4015-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  WebFoldersDisp = dispinterface
    ['{48FB4015-D3D0-11D1-83D7-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: WebFolder readonly dispid 0; default;
    function  Add(const FolderUrl: WideString): WebFolder; dispid 4;
    procedure Delete(var Index: OleVariant); dispid 5;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: Themes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4046-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  Themes = interface(_IBaseFPObj)
    ['{48FB4046-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): Theme; safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Theme read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  ThemesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4046-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  ThemesDisp = dispinterface
    ['{48FB4046-D3D0-11D1-83D7-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Theme readonly dispid 0; default;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: Theme
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4044-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  Theme = interface(_IBaseFPObj)
    ['{48FB4044-D3D0-11D1-83D7-006097ABE675}']
    function  Get_Format: WideString; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Label_: WideString; safecall;
    function  Get_Version: WideString; safecall;
    property Format: WideString read Get_Format;
    property Name: WideString read Get_Name;
    property Label_: WideString read Get_Label_;
    property Version: WideString read Get_Version;
  end;

// *********************************************************************//
// DispIntf:  ThemeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {48FB4044-D3D0-11D1-83D7-006097ABE675}
// *********************************************************************//
  ThemeDisp = dispinterface
    ['{48FB4044-D3D0-11D1-83D7-006097ABE675}']
    property Format: WideString readonly dispid 3;
    property Name: WideString readonly dispid 0;
    property Label_: WideString readonly dispid 5;
    property Version: WideString readonly dispid 6;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: WebWindows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6B735742-FA41-11D1-83DC-006097ABE675}
// *********************************************************************//
  WebWindows = interface(_IBaseFPObj)
    ['{6B735742-FA41-11D1-83DC-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): WebWindow; safecall;
    procedure Close(var Index: OleVariant); safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: WebWindow read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  WebWindowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {6B735742-FA41-11D1-83DC-006097ABE675}
// *********************************************************************//
  WebWindowsDisp = dispinterface
    ['{6B735742-FA41-11D1-83DC-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: WebWindow readonly dispid 0; default;
    procedure Close(var Index: OleVariant); dispid 4;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: System
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {731EC3E0-9CC2-11D1-83CE-006097ABE675}
// *********************************************************************//
  System = interface(_IBaseFPObj)
    ['{731EC3E0-9CC2-11D1-83CE-006097ABE675}']
    function  Get_Build: WideString; safecall;
    function  Get_Version: WideString; safecall;
    function  Get_OperatingSystem: WideString; safecall;
    function  Get_HorizontalResolution: Integer; safecall;
    function  Get_VerticalResolution: Integer; safecall;
    function  Get_LanguageDesignation: WideString; safecall;
    function  Get_ProfileString(const RegistrySection: WideString; const RegistryKey: WideString): WideString; safecall;
    procedure Set_ProfileString(const RegistrySection: WideString; const RegistryKey: WideString;
                                const pVal: WideString); safecall;
    property Build: WideString read Get_Build;
    property Version: WideString read Get_Version;
    property OperatingSystem: WideString read Get_OperatingSystem;
    property HorizontalResolution: Integer read Get_HorizontalResolution;
    property VerticalResolution: Integer read Get_VerticalResolution;
    property LanguageDesignation: WideString read Get_LanguageDesignation;
    property ProfileString[const RegistrySection: WideString; const RegistryKey: WideString]: WideString read Get_ProfileString write Set_ProfileString;
  end;

// *********************************************************************//
// DispIntf:  SystemDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {731EC3E0-9CC2-11D1-83CE-006097ABE675}
// *********************************************************************//
  SystemDisp = dispinterface
    ['{731EC3E0-9CC2-11D1-83CE-006097ABE675}']
    property Build: WideString readonly dispid 3;
    property Version: WideString readonly dispid 4;
    property OperatingSystem: WideString readonly dispid 0;
    property HorizontalResolution: Integer readonly dispid 6;
    property VerticalResolution: Integer readonly dispid 7;
    property LanguageDesignation: WideString readonly dispid 8;
    property ProfileString[const RegistrySection: WideString; const RegistryKey: WideString]: WideString dispid 9;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// Interface: Webs
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AAAA22E0-C834-11D1-83D4-006097ABE675}
// *********************************************************************//
  Webs = interface(_IBaseFPObj)
    ['{AAAA22E0-C834-11D1-83D4-006097ABE675}']
    function  Get_Count: OleVariant; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(var Index: OleVariant): Web; safecall;
    function  Add(const WebUrl: WideString; const UserName: WideString; const Password: WideString): Web; safecall;
    procedure Delete(var Index: OleVariant; WebDeleteFlags: FpWebDeleteFlags); safecall;
    function  Open(const szWebUrl: WideString; const UserName: WideString;
                   const Password: WideString): Web; safecall;
    property Count: OleVariant read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[var Index: OleVariant]: Web read Get_Item; default;
  end;

// *********************************************************************//
// DispIntf:  WebsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AAAA22E0-C834-11D1-83D4-006097ABE675}
// *********************************************************************//
  WebsDisp = dispinterface
    ['{AAAA22E0-C834-11D1-83D4-006097ABE675}']
    property Count: OleVariant readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[var Index: OleVariant]: Web readonly dispid 0; default;
    function  Add(const WebUrl: WideString; const UserName: WideString; const Password: WideString): Web; dispid 4;
    procedure Delete(var Index: OleVariant; WebDeleteFlags: FpWebDeleteFlags); dispid 7;
    function  Open(const szWebUrl: WideString; const UserName: WideString;
                   const Password: WideString): Web; dispid 8;
    property Application: _Application readonly dispid 1;
    property Parent: IDispatch readonly dispid -2147418104;
  end;

// *********************************************************************//
// DispIntf:  _IApplicationEvents
// Flags:     (4096) Dispatchable
// GUID:      {F5D15700-E9D8-11D1-B0DF-00C04FA30A8B}
// *********************************************************************//
  _IApplicationEvents = dispinterface
    ['{F5D15700-E9D8-11D1-B0DF-00C04FA30A8B}']
    procedure OnWebNew(const pWeb: Web); dispid 1;
    procedure OnWebOpen(const pWeb: Web); dispid 2;
    procedure OnWebClose(const pWeb: Web; var Cancel: WordBool); dispid 3;
    procedure OnBeforeWebPublish(const pWeb: Web; var Destination: WideString; var Cancel: WordBool); dispid 4;
    procedure OnAfterWebPublish(const pWeb: Web; var Success: WordBool); dispid 5;
    procedure OnPageNew(const pPage: PageWindow); dispid 6;
    procedure OnPageOpen(const pPage: PageWindow); dispid 7;
    procedure OnPageClose(const pPage: PageWindow; var Cancel: WordBool); dispid 8;
    procedure OnBeforePageSave(const pPage: PageWindow; var SaveAsUI: WordBool; var Cancel: WordBool); dispid 9;
    procedure OnAfterPageSave(const pPage: PageWindow; var Success: WordBool); dispid 10;
    procedure WindowActivate(const pWebWindow: WebWindow); dispid 11;
    procedure WindowDeactivate(const pWebWindow: WebWindow); dispid 12;
  end;

// *********************************************************************//
// DispIntf:  IWebber
// Flags:     (4112) Hidden Dispatchable
// GUID:      {8BBD4A72-661D-11CF-A3C4-00A024184692}
// *********************************************************************//
  IWebber = dispinterface
    ['{8BBD4A72-661D-11CF-A3C4-00A024184692}']
    function  vtiCreateWeb(const szServerURL: WideString; const szWebName: WideString): Integer; dispid 1;
    procedure vtiRefreshWebFromServer; dispid 2;
    function  vtiPutDocument(const szFileName: WideString; const szURL: WideString;
                             bBlockingRequest: Integer): Integer; dispid 3;
    function  vtiPutWebMetaInfo(const szNameValuePairs: WideString): Integer; dispid 4;
    procedure vtiSetWebRecalcDependencies(bRecalcOn: Integer); dispid 5;
    function  vtiGetWebPageMetaInfo(const szURL: WideString; const szKeyName: WideString): WideString; dispid 6;
    function  vtiRemoveWebPages(const pszPageList: WideString): Integer; dispid 7;
    function  vtiEditForToDoList(const szURL: WideString; const szCookie: WideString; lKey: Integer): Integer; dispid 8;
    procedure vtiBringToTop; dispid 9;
    function  vtiGetWebTitle: WideString; dispid 11;
    function  vtiGetWebURL: WideString; dispid 12;
    procedure vtiPromptOpenWeb; dispid 13;
    function  vtiRemoveWeb(const szWebName: WideString): Integer; dispid 14;
    function  vtiIsPageInWeb(const szURL: WideString): Integer; dispid 15;
    function  vtiGetWebMetaInfo(const szKey: WideString): WideString; dispid 17;
    function  vtiGetPageList(lType: Integer): WideString; dispid 18;
    function  vtiPutDocuments(const szFileList: WideString; const szUrlList: WideString): Integer; dispid 19;
    procedure vtiCancelRequests; dispid 20;
    function  vtiOpenWeb(const pszServer: WideString; const pszWebName: WideString;
                         const pszUser: WideString): Integer; dispid 21;
    function  vtiEditWebPage(const pszPageURL: WideString): Integer; dispid 22;
    function  vtiPutWebPageMetaInfo(const pszURL: WideString; const pszNameValuePairs: WideString): Integer; dispid 23;
    function  vtiGetDocToFile(const pszURL: WideString; const pszFilename: WideString): Integer; dispid 24;
    function  vtiGetBotsList(var bNewBotsList: Integer): WideString; dispid 25;
    function  vtiGetBotModule(const pszBotDir: WideString; const pszBotModule: WideString): WideString; dispid 26;
    function  vtiCreateFolder(const pszFolderUrl: WideString): Integer; dispid 27;
    function  vtiGetFoldersList(const pszParentFolderUrl: WideString): WideString; dispid 28;
    function  vtiGetPagesInFolder(const pszFolderUrl: WideString; lType: Integer): WideString; dispid 29;
    function  vtiEditNextPageWithAction(const prevURL: WideString): Integer; dispid 30;
    function  vtiEditImage(const szFileName: WideString; const szURL: WideString): Integer; dispid 31;
    function  vtiPutDocumentDTM(const szFileName: WideString; const szURL: WideString;
                                lDateTimeModified: Integer; bBlockingRequest: Integer): Integer; dispid 32;
    function  vtigetbotslistex(var bNewBotsList: Integer): WideString; dispid 33;
    function  vtiOpenWebWithPassword(const pszServer: WideString; const pszWebName: WideString;
                                     const pszUser: WideString; const pszPassword: WideString): Integer; dispid 34;
    function  vtiListWebs(const pszServer: WideString; const pszUser: WideString;
                          const pszPassword: WideString): WideString; dispid 35;
    procedure vtiDisableErrorDialogs(bYesNo: Integer); dispid 36;
    procedure vtiQuit; dispid 37;
    function  vtiPublishWeb(const pszServerUrl: WideString; const pszWebName: WideString;
                            dwFlags: Integer; const pszUser: WideString;
                            const pszPassword: WideString): Integer; dispid 38;
    function  vtiImportExternallyEditedFiles: Integer; dispid 39;
    function  vtiRenameDocument(const pszURL: WideString; const pszNewURL: WideString;
                                bUpdateBacklinks: Integer; bIsFolder: Integer; bCopy: Integer;
                                bForceOverwrite: Integer): Integer; dispid 40;
    function  vtiIsFeatureSupported(const pszFeature: WideString): Integer; dispid 41;
    function  vtiListThemes: WideString; dispid 42;
    function  vtiApplyTheme(const pszName: WideString; dParams: Integer; const fileList: WideString): Integer; dispid 43;
    function  vtiGetTheme(const pszThemeDirName: WideString; const pszLocThemesDir: WideString): WideString; dispid 44;
    function  vtiPutTheme(const pszThemeDirName: WideString; const pszThemeVersion: WideString;
                          const pszFileList: WideString; const pszLocThemesDir: WideString): Integer; dispid 45;
    function  vtiPutWebStructure(const pszModifications: WideString): Integer; dispid 55;
    function  vtiGetWebStructureRelations(const pszURL: WideString; lRelationType: Integer): WideString; dispid 56;
    function  vtiReturnDBWRoot(const pszFileURL: WideString): WideString; dispid 57;
    function  vtiMakeThemeFresh(const pszWebUrl: WideString; const pszThemeName: WideString;
                                bAllowUpload: Integer; bAllowDownload: Integer): Integer; dispid 58;
    function  vtiSetCurrentView(nViewID: Integer; bTransferSelection: Integer; nFlags: Integer): Integer; dispid 59;
    function  vtiIsFolderInWeb(const pszFolderUrl: WideString): Integer; dispid 60;
    function  vtiSetFolderOptions(const pszFolder: WideString; bExecutable: Integer;
                                  bReadable: Integer): Integer; dispid 61;
    function  vtiPutGlobalThemeDoc(const pszRemoteDir: WideString; const pszThemeFile: WideString;
                                   const pszWebRel: WideString; bRunListUrls: Integer): Integer; dispid 64;
    function  vtiRefreshThemeList: Integer; dispid 65;
    function  vtiSetEditor(const szType: WideString; const szName: WideString;
                           const szCommand: WideString): Integer; dispid 66;
    function  vtiListDataSources(lType: Integer; var pszSources: WideString;
                                 var pszAttrs: WideString): Integer; dispid 67;
    function  vtiGetDatabaseSchema(const pszConnStr: WideString; lFlags: Integer;
                                   var pszSchema: WideString): Integer; dispid 68;
    function  vtiListRecordSources(const pszConnStr: WideString; lType: Integer;
                                   var sources: WideString; var attrs: WideString): Integer; dispid 69;
    function  vtiGetRecordSourceSchema(const pszConnStr: WideString;
                                       const pszRecordSource: WideString; var pszSchema: WideString): Integer; dispid 70;
    function  vtiGetQuerySchema(const pszConnStr: WideString; const pszSQL: WideString;
                                lFlags: Integer; var pszSchema: WideString): Integer; dispid 71;
    function  vtiListDrivers(lType: Integer; var drivers: WideString; var attrs: WideString): Integer; dispid 72;
    function  vtiListDataConnections(var bstrNames: WideString; var bstrConnStrs: WideString): Integer; dispid 73;
    function  vtiSetDataConnections(const names: WideString; const attrs: WideString): Integer; dispid 74;
    function  vtiWebSettingsDlg(flags: Integer): Integer; dispid 75;
  end;

// *********************************************************************//
// DispIntf:  IPageEditor
// Flags:     (4112) Hidden Dispatchable
// GUID:      {8BBD4A7B-661D-11CF-A3C4-00A024184692}
// *********************************************************************//
  IPageEditor = dispinterface
    ['{8BBD4A7B-661D-11CF-A3C4-00A024184692}']
    function  vtiOpenWebPage(const szFileName: WideString; const szURL: WideString;
                             const szWebUrl: WideString; const szWebTitle: WideString): IDispatch; dispid 1;
    function  vtiQueryWebPage(const szURL: WideString; const szWebUrl: WideString): Integer; dispid 3;
    procedure vtiBringToTop; dispid 4;
    function  vtiNewWebPage(const szURL: WideString; const szWebUrl: WideString;
                            const szWebTitle: WideString): IDispatch; dispid 5;
    function  vtiBringPageToTop(const szURL: WideString; const szWebUrl: WideString;
                                const szCookie: WideString; toDoTaskId: Integer): Integer; dispid 6;
    function  vtiListOpenDocs: WideString; dispid 12;
    procedure vtiRefreshDocument(const szPageUrl: WideString; const szWebUrl: WideString); dispid 16;
    function  vtiGetBookmarkList(const pszPageURL: WideString; const pszWebUrl: WideString): WideString; dispid 17;
    function  vtiScrollToBookmark(const pszPageURL: WideString; const pszWebUrl: WideString;
                                  const pszBookmark: WideString): Integer; dispid 18;
    function  vtiInsertFile(const pszPageURL: WideString; const pszWebUrl: WideString;
                            const pszFile: WideString): Integer; dispid 19;
    function  vtiInsertImage(const pszPageURL: WideString; const pszWebUrl: WideString;
                             const pszFile: WideString): Integer; dispid 20;
    function  vtiGetTopPageUrl: WideString; dispid 21;
    function  vtiInsertHTML(const pszHTML: WideString): Integer; dispid 22;
    procedure vtiPaste; dispid 23;
    procedure vtiQuit; dispid 24;
    function  vtiSetMetaTag(const pszPageURL: WideString; const pszWebUrl: WideString;
                            const pszKey: WideString; const pszValue: WideString; lIndex: Integer;
                            flags: Integer): Integer; dispid 26;
    function  vtiListMetaTags(const pszPageURL: WideString; const pszWebUrl: WideString;
                              flags: Integer): WideString; dispid 27;
    function  vtiDeleteMetaTag(const pszPageURL: WideString; const pszWebUrl: WideString;
                               const pszKey: WideString; lIndex: Integer; flags: Integer): Integer; dispid 28;
    function  vtiGetMetaTag(const pszPageURL: WideString; const pszWebUrl: WideString;
                            const pszKey: WideString; lIndex: Integer; flags: Integer): WideString; dispid 29;
    function  vtiQueryWebPageEx(const szURL: WideString; const szWebUrl: WideString;
                                var bDirty: Integer; var bWritable: Integer): Integer; dispid 30;
  end;

// *********************************************************************//
// Interface: IExplorerWebs
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B5D039F-8DDB-11D1-A220-00A0C9055E81}
// *********************************************************************//
  IExplorerWebs = interface(IDispatch)
    ['{9B5D039F-8DDB-11D1-A220-00A0C9055E81}']
    function  CreateWeb(const serverUrl: WideString; const webName: WideString; oflag: WebOpenFlags): IExplorerWeb; safecall;
    function  OpenWeb(const serverUrl: WideString; const webName: WideString;
                      const user: WideString; oflag: WebOpenFlags): IExplorerWeb; safecall;
    function  OpenWebWithPassword(const server: WideString; const webName: WideString;
                                  const user: WideString; const Password: WideString;
                                  oflag: WebOpenFlags): IExplorerWeb; safecall;
    procedure BringToTop; safecall;
    function  PromptOpenWeb(inCurrentWindow: Integer): IExplorerWeb; safecall;
    procedure RemoveWeb(const serverUrl: WideString; const webName: WideString); safecall;
    procedure SetEditor(const type_: WideString; const Name: WideString; const command: WideString); safecall;
    procedure DisableErrorDialogs(bYesNo: Integer); safecall;
    procedure Quit; safecall;
    function  ListOpenWebs: WideString; safecall;
    function  GetOpenWeb(const WebUrl: WideString): IExplorerWeb; safecall;
    procedure EditWebPage(const Url: WideString); safecall;
    procedure GetThemePaths(out themePaths: WideString; out customThemePath: WideString); safecall;
    procedure ParseUrl(const Url: WideString; out serverUrl: WideString; out webName: WideString;
                       out pageUrl: WideString); safecall;
    function  CreateWebWithPassword(const serverUrl: WideString; const webName: WideString;
                                    const user: WideString; const Password: WideString;
                                    oflag: WebOpenFlags): IExplorerWeb; safecall;
    procedure GetThemePath(const ThemeName: WideString; out themePath: WideString); safecall;
    procedure NewWindow; safecall;
    procedure EditInFrontPage(const Url: WideString; flags: RequestDocumentsFlags); safecall;
  end;

// *********************************************************************//
// DispIntf:  IExplorerWebsDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B5D039F-8DDB-11D1-A220-00A0C9055E81}
// *********************************************************************//
  IExplorerWebsDisp = dispinterface
    ['{9B5D039F-8DDB-11D1-A220-00A0C9055E81}']
    function  CreateWeb(const serverUrl: WideString; const webName: WideString; oflag: WebOpenFlags): IExplorerWeb; dispid 1;
    function  OpenWeb(const serverUrl: WideString; const webName: WideString;
                      const user: WideString; oflag: WebOpenFlags): IExplorerWeb; dispid 2;
    function  OpenWebWithPassword(const server: WideString; const webName: WideString;
                                  const user: WideString; const Password: WideString;
                                  oflag: WebOpenFlags): IExplorerWeb; dispid 3;
    procedure BringToTop; dispid 4;
    function  PromptOpenWeb(inCurrentWindow: Integer): IExplorerWeb; dispid 5;
    procedure RemoveWeb(const serverUrl: WideString; const webName: WideString); dispid 6;
    procedure SetEditor(const type_: WideString; const Name: WideString; const command: WideString); dispid 7;
    procedure DisableErrorDialogs(bYesNo: Integer); dispid 8;
    procedure Quit; dispid 9;
    function  ListOpenWebs: WideString; dispid 10;
    function  GetOpenWeb(const WebUrl: WideString): IExplorerWeb; dispid 11;
    procedure EditWebPage(const Url: WideString); dispid 12;
    procedure GetThemePaths(out themePaths: WideString; out customThemePath: WideString); dispid 13;
    procedure ParseUrl(const Url: WideString; out serverUrl: WideString; out webName: WideString;
                       out pageUrl: WideString); dispid 14;
    function  CreateWebWithPassword(const serverUrl: WideString; const webName: WideString;
                                    const user: WideString; const Password: WideString;
                                    oflag: WebOpenFlags): IExplorerWeb; dispid 15;
    procedure GetThemePath(const ThemeName: WideString; out themePath: WideString); dispid 16;
    procedure NewWindow; dispid 17;
    procedure EditInFrontPage(const Url: WideString; flags: RequestDocumentsFlags); dispid 18;
  end;

// *********************************************************************//
// Interface: IExplorerWeb
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B5D03A1-8DDB-11D1-A220-00A0C9055E81}
// *********************************************************************//
  IExplorerWeb = interface(IDispatch)
    ['{9B5D03A1-8DDB-11D1-A220-00A0C9055E81}']
    procedure RefreshWebFromServer; safecall;
    procedure SetWebRecalcDependencies(bRecalcOn: Integer); safecall;
    function  GetWebTitle: WideString; safecall;
    function  GetWebURL: WideString; safecall;
    procedure PutWebMetaInfo(const nameValuePairs: WideString); safecall;
    function  GetWebMetaInfo(const key: WideString): WideString; safecall;
    procedure ImportExternallyEditedFiles; safecall;
    function  IsFeatureSupported(const feature: WideString): Integer; safecall;
    function  ReturnDBWRoot(const FileUrl: WideString): WideString; safecall;
    procedure CancelRequests; safecall;
    procedure BringToTop; safecall;
    procedure SetCurrentView(nViewID: Integer; bTransferSelection: Integer; nFlags: Integer); safecall;
    procedure PublishWeb(const serverUrl: WideString; const webName: WideString; dwFlags: Integer;
                         const user: WideString; const Password: WideString); safecall;
    procedure RemoveWeb(const webName: WideString); safecall;
    function  GetBotModule(const botDir: WideString; const botModule: WideString): WideString; safecall;
    function  GetBotsList(out bNewBotsList: Integer): WideString; safecall;
    function  GetBotsListEx(out bNewBotsList: Integer): WideString; safecall;
    function  ListThemes: WideString; safecall;
    procedure RefreshThemeList; safecall;
    procedure MakeThemeFresh(const ThemeName: WideString; bAllowUpload: Integer;
                             bAllowDownload: Integer); safecall;
    procedure ApplyTheme(const Name: WideString; lParams: Integer; const fileList: WideString); safecall;
    function  GetTheme(const themeDirName: WideString; const locThemesDir: WideString): WideString; safecall;
    procedure PutTheme(const themeDirName: WideString; const themeVersion: WideString;
                       const fileList: WideString; const locThemesDir: WideString); safecall;
    procedure PutGlobalThemeDoc(const themeFile: WideString; const webRelUrl: WideString); safecall;
    procedure PutWebStructure(const structureAdds: WideString); safecall;
    function  GetWebStructureRelations(const Url: WideString; lRelationType: Integer): WideString; safecall;
    procedure CreateFolder(const Url: WideString); safecall;
    function  GetFoldersList(const parentFolderUrl: WideString): WideString; safecall;
    function  GetPagesInFolder(const FolderUrl: WideString; lType: Integer): WideString; safecall;
    function  GetSubWebsInFolder(const FolderUrl: WideString): WideString; safecall;
    function  IsFolderInWeb(const FolderUrl: WideString): Integer; safecall;
    procedure SetFolderOptions(const folder: WideString; bExecutable: Integer; bReadable: Integer); safecall;
    function  IsPageInWeb(const szURL: WideString): Integer; safecall;
    procedure GetDocToFile(const Url: WideString; const filename: WideString); safecall;
    procedure PutDocuments(const fileList: WideString; const urlList: WideString;
                           bForceOverwrite: Integer); safecall;
    procedure PutDocument(const filename: WideString; const Url: WideString;
                          bBlockingRequest: Integer; bForceOverwrite: Integer); safecall;
    function  PutDocumentDTM(const filename: WideString; const Url: WideString;
                             lDateTimeModified: Integer; bBlockingRequest: Integer;
                             bForceOverwrite: Integer; const nameValuePairs: WideString): Integer; safecall;
    function  GetWebPageMetaInfo(const Url: WideString; const keyName: WideString): WideString; safecall;
    procedure PutWebPageMetaInfo(const Url: WideString; const nameValuePairs: WideString); safecall;
    procedure RemoveWebPages(const pageList: WideString); safecall;
    procedure EditForToDoList(const Url: WideString; const szCookie: WideString; lKey: Integer); safecall;
    procedure EditWebPage(const Url: WideString); safecall;
    function  EditNextPageWithAction(const prevURL: WideString): Integer; safecall;
    procedure EditImage(const filename: WideString; const Url: WideString); safecall;
    procedure RenameDocument(const Url: WideString; const newUrl: WideString;
                             bUpdateBacklinks: Integer; bIsFolder: Integer; bCopy: Integer;
                             bForceOverwrite: Integer); safecall;
    procedure NewPage(const Url: WideString; const templateFile: WideString); safecall;
    procedure EditInFrontPage(const Url: WideString); safecall;
    procedure AddTask(const taskName: WideString; priority: Smallint; const createdBy: WideString;
                      const Url: WideString; const cookie: WideString; const Comment: WideString); safecall;
    procedure AddTaskAskUser(const taskName: WideString; priority: Smallint;
                             const createdBy: WideString; const Url: WideString;
                             const cookie: WideString; const Comment: WideString); safecall;
    procedure CompletedTask(taskId: Integer); safecall;
    procedure CompletedTaskByUrl(const Url: WideString; const cookie: WideString); safecall;
    procedure WorkedOnTask(taskId: Integer); safecall;
    procedure WorkedOnTaskByUrl(const Url: WideString; const cookie: WideString); safecall;
    function  GetTaskName(taskId: Integer): WideString; safecall;
    function  GetActiveCount: Integer; safecall;
    procedure DisableErrorDialogs(bYesNo: Integer); safecall;
    procedure ListDataSources(lType: Integer; out sourceList: WideString; out attrList: WideString); safecall;
    procedure GetDatabaseSchema(const szConnStr: WideString; lFlags: Integer;
                                out pszSchema: WideString); safecall;
    procedure ListRecordSources(const szConnStr: WideString; lType: Integer;
                                out sources: WideString; out attrs: WideString); safecall;
    procedure GetRecordSourceSchema(const szConnStr: WideString; const szRecordSource: WideString;
                                    out pszSchema: WideString); safecall;
    procedure GetQuerySchema(const szConnStr: WideString; const szSQL: WideString; lFlags: Integer;
                             out pszSchema: WideString); safecall;
    procedure ListDrivers(lType: Integer; out drivers: WideString; out attrs: WideString); safecall;
    procedure ListDataConnections(out pszNames: WideString; out pszConnStrs: WideString); safecall;
    procedure SetDataConnections(const names: WideString; const attrs: WideString); safecall;
    function  WebSettingsDlg(flags: Integer): Integer; safecall;
    procedure ApplyBorder(const newBorders: WideString; bNavTop: Integer; bNavLeft: Integer;
                          topChanged: Integer; leftChanged: Integer); safecall;
    function  GetPageList(lType: Integer): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IExplorerWebDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B5D03A1-8DDB-11D1-A220-00A0C9055E81}
// *********************************************************************//
  IExplorerWebDisp = dispinterface
    ['{9B5D03A1-8DDB-11D1-A220-00A0C9055E81}']
    procedure RefreshWebFromServer; dispid 1;
    procedure SetWebRecalcDependencies(bRecalcOn: Integer); dispid 2;
    function  GetWebTitle: WideString; dispid 3;
    function  GetWebURL: WideString; dispid 4;
    procedure PutWebMetaInfo(const nameValuePairs: WideString); dispid 5;
    function  GetWebMetaInfo(const key: WideString): WideString; dispid 6;
    procedure ImportExternallyEditedFiles; dispid 7;
    function  IsFeatureSupported(const feature: WideString): Integer; dispid 8;
    function  ReturnDBWRoot(const FileUrl: WideString): WideString; dispid 9;
    procedure CancelRequests; dispid 10;
    procedure BringToTop; dispid 11;
    procedure SetCurrentView(nViewID: Integer; bTransferSelection: Integer; nFlags: Integer); dispid 12;
    procedure PublishWeb(const serverUrl: WideString; const webName: WideString; dwFlags: Integer;
                         const user: WideString; const Password: WideString); dispid 13;
    procedure RemoveWeb(const webName: WideString); dispid 14;
    function  GetBotModule(const botDir: WideString; const botModule: WideString): WideString; dispid 15;
    function  GetBotsList(out bNewBotsList: Integer): WideString; dispid 16;
    function  GetBotsListEx(out bNewBotsList: Integer): WideString; dispid 17;
    function  ListThemes: WideString; dispid 18;
    procedure RefreshThemeList; dispid 19;
    procedure MakeThemeFresh(const ThemeName: WideString; bAllowUpload: Integer;
                             bAllowDownload: Integer); dispid 20;
    procedure ApplyTheme(const Name: WideString; lParams: Integer; const fileList: WideString); dispid 21;
    function  GetTheme(const themeDirName: WideString; const locThemesDir: WideString): WideString; dispid 22;
    procedure PutTheme(const themeDirName: WideString; const themeVersion: WideString;
                       const fileList: WideString; const locThemesDir: WideString); dispid 23;
    procedure PutGlobalThemeDoc(const themeFile: WideString; const webRelUrl: WideString); dispid 24;
    procedure PutWebStructure(const structureAdds: WideString); dispid 25;
    function  GetWebStructureRelations(const Url: WideString; lRelationType: Integer): WideString; dispid 26;
    procedure CreateFolder(const Url: WideString); dispid 27;
    function  GetFoldersList(const parentFolderUrl: WideString): WideString; dispid 28;
    function  GetPagesInFolder(const FolderUrl: WideString; lType: Integer): WideString; dispid 29;
    function  GetSubWebsInFolder(const FolderUrl: WideString): WideString; dispid 30;
    function  IsFolderInWeb(const FolderUrl: WideString): Integer; dispid 31;
    procedure SetFolderOptions(const folder: WideString; bExecutable: Integer; bReadable: Integer); dispid 32;
    function  IsPageInWeb(const szURL: WideString): Integer; dispid 33;
    procedure GetDocToFile(const Url: WideString; const filename: WideString); dispid 36;
    procedure PutDocuments(const fileList: WideString; const urlList: WideString;
                           bForceOverwrite: Integer); dispid 37;
    procedure PutDocument(const filename: WideString; const Url: WideString;
                          bBlockingRequest: Integer; bForceOverwrite: Integer); dispid 38;
    function  PutDocumentDTM(const filename: WideString; const Url: WideString;
                             lDateTimeModified: Integer; bBlockingRequest: Integer;
                             bForceOverwrite: Integer; const nameValuePairs: WideString): Integer; dispid 39;
    function  GetWebPageMetaInfo(const Url: WideString; const keyName: WideString): WideString; dispid 40;
    procedure PutWebPageMetaInfo(const Url: WideString; const nameValuePairs: WideString); dispid 41;
    procedure RemoveWebPages(const pageList: WideString); dispid 42;
    procedure EditForToDoList(const Url: WideString; const szCookie: WideString; lKey: Integer); dispid 43;
    procedure EditWebPage(const Url: WideString); dispid 44;
    function  EditNextPageWithAction(const prevURL: WideString): Integer; dispid 45;
    procedure EditImage(const filename: WideString; const Url: WideString); dispid 46;
    procedure RenameDocument(const Url: WideString; const newUrl: WideString;
                             bUpdateBacklinks: Integer; bIsFolder: Integer; bCopy: Integer;
                             bForceOverwrite: Integer); dispid 47;
    procedure NewPage(const Url: WideString; const templateFile: WideString); dispid 48;
    procedure EditInFrontPage(const Url: WideString); dispid 49;
    procedure AddTask(const taskName: WideString; priority: Smallint; const createdBy: WideString;
                      const Url: WideString; const cookie: WideString; const Comment: WideString); dispid 50;
    procedure AddTaskAskUser(const taskName: WideString; priority: Smallint;
                             const createdBy: WideString; const Url: WideString;
                             const cookie: WideString; const Comment: WideString); dispid 51;
    procedure CompletedTask(taskId: Integer); dispid 52;
    procedure CompletedTaskByUrl(const Url: WideString; const cookie: WideString); dispid 53;
    procedure WorkedOnTask(taskId: Integer); dispid 54;
    procedure WorkedOnTaskByUrl(const Url: WideString; const cookie: WideString); dispid 55;
    function  GetTaskName(taskId: Integer): WideString; dispid 56;
    function  GetActiveCount: Integer; dispid 57;
    procedure DisableErrorDialogs(bYesNo: Integer); dispid 58;
    procedure ListDataSources(lType: Integer; out sourceList: WideString; out attrList: WideString); dispid 59;
    procedure GetDatabaseSchema(const szConnStr: WideString; lFlags: Integer;
                                out pszSchema: WideString); dispid 60;
    procedure ListRecordSources(const szConnStr: WideString; lType: Integer;
                                out sources: WideString; out attrs: WideString); dispid 61;
    procedure GetRecordSourceSchema(const szConnStr: WideString; const szRecordSource: WideString;
                                    out pszSchema: WideString); dispid 62;
    procedure GetQuerySchema(const szConnStr: WideString; const szSQL: WideString; lFlags: Integer;
                             out pszSchema: WideString); dispid 63;
    procedure ListDrivers(lType: Integer; out drivers: WideString; out attrs: WideString); dispid 64;
    procedure ListDataConnections(out pszNames: WideString; out pszConnStrs: WideString); dispid 65;
    procedure SetDataConnections(const names: WideString; const attrs: WideString); dispid 66;
    function  WebSettingsDlg(flags: Integer): Integer; dispid 67;
    procedure ApplyBorder(const newBorders: WideString; bNavTop: Integer; bNavLeft: Integer;
                          topChanged: Integer; leftChanged: Integer); dispid 68;
    function  GetPageList(lType: Integer): WideString; dispid 69;
  end;

// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to
// create instances of the default interface _Application exposed by
// the CoClass Application. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoApplication = class
    class function Create: _Application;
    class function CreateRemote(const MachineName: string): _Application;
  end;

  TFrontPageApplicationOnWebNew = procedure(Sender: TObject; var pWeb: OleVariant) of object;
  TFrontPageApplicationOnWebOpen = procedure(Sender: TObject; var pWeb: OleVariant) of object;
  TFrontPageApplicationOnWebClose = procedure(Sender: TObject; var pWeb: OleVariant;
                                                               var Cancel: OleVariant) of object;
  TFrontPageApplicationOnBeforeWebPublish = procedure(Sender: TObject; var pWeb: OleVariant;
                                                                       var Destination: OleVariant;
                                                                       var Cancel: OleVariant) of object;
  TFrontPageApplicationOnAfterWebPublish = procedure(Sender: TObject; var pWeb: OleVariant;
                                                                      var Success: OleVariant) of object;
  TFrontPageApplicationOnPageNew = procedure(Sender: TObject; var pPage: OleVariant) of object;
  TFrontPageApplicationOnPageOpen = procedure(Sender: TObject; var pPage: OleVariant) of object;
  TFrontPageApplicationOnPageClose = procedure(Sender: TObject; var pPage: OleVariant;
                                                                var Cancel: OleVariant) of object;
  TFrontPageApplicationOnBeforePageSave = procedure(Sender: TObject; var pPage: OleVariant;
                                                                     var SaveAsUI: OleVariant;
                                                                     var Cancel: OleVariant) of object;
  TFrontPageApplicationOnAfterPageSave = procedure(Sender: TObject; var pPage: OleVariant;
                                                                    var Success: OleVariant) of object;
  TFrontPageApplicationWindowActivate = procedure(Sender: TObject; var pWebWindow: OleVariant) of object;
  TFrontPageApplicationWindowDeactivate = procedure(Sender: TObject; var pWebWindow: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TFrontPageApplication
// Help String      : Microsoft FrontPage Application
// Default Interface: _Application
// Def. Intf. DISP? : No
// Event   Interface: _IApplicationEvents
// TypeFlags        : (11) AppObject CanCreate Predeclid
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TFrontPageApplicationProperties= class;
{$ENDIF}
  TFrontPageApplication = class(TOleServer)
  private
    FOnWebNew: TFrontPageApplicationOnWebNew;
    FOnWebOpen: TFrontPageApplicationOnWebOpen;
    FOnWebClose: TFrontPageApplicationOnWebClose;
    FOnBeforeWebPublish: TFrontPageApplicationOnBeforeWebPublish;
    FOnAfterWebPublish: TFrontPageApplicationOnAfterWebPublish;
    FOnPageNew: TFrontPageApplicationOnPageNew;
    FOnPageOpen: TFrontPageApplicationOnPageOpen;
    FOnPageClose: TFrontPageApplicationOnPageClose;
    FOnBeforePageSave: TFrontPageApplicationOnBeforePageSave;
    FOnAfterPageSave: TFrontPageApplicationOnAfterPageSave;
    FOnWindowActivate: TFrontPageApplicationWindowActivate;
    FOnWindowDeactivate: TFrontPageApplicationWindowDeactivate;
    FAutoQuit:    Boolean;
    FIntf:        _Application;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TFrontPageApplicationProperties;
    function      GetServerProperties: TFrontPageApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Application;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function  Get_Application: _Application;
    function  Get_ActiveDocument: IHTMLDocument2;
    function  Get_ActivePageWindow: PageWindow;
    function  Get_ActiveWeb: Web;
    function  Get_ActiveWebWindow: WebWindow;
    function  Get_AnswerWizard: AnswerWizard;
    function  Get_Build: WideString;
    function  Get_COMAddIns: COMAddIns;
    function  Get_CommandBars: CommandBars;
    function  Get_FileSearch: FileSearch;
    function  Get_LanguageSettings: LanguageSettings;
    function  Get_Name: WideString;
    function  Get_OrganizationName: WideString;
    function  Get_System_: System;
    function  Get_Themes: Themes;
    function  Get_UserName: WideString;
    procedure Set_UserName(const pVal: WideString);
    function  Get_Version: WideString;
    function  Get_Webs: Webs;
    function  Get_WebWindows: WebWindows;
    function  Get_ProductCode: WideString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Application);
    procedure Disconnect; override;
    function  LocatePage(const DocumentUrl: WideString; ViewMode: FpPageViewMode): PageWindow;
    function  MakeAbs(var UrlBase: OleVariant; const Url: WideString): WideString;
    function  MakeRel(var UrlBase: OleVariant; const Url: WideString): WideString;
    procedure Quit;
    function  Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant;
    property  DefaultInterface: _Application read GetDefaultInterface;
    property Application: _Application read Get_Application;
    property ActiveDocument: IHTMLDocument2 read Get_ActiveDocument;
    property ActivePageWindow: PageWindow read Get_ActivePageWindow;
    property ActiveWeb: Web read Get_ActiveWeb;
    property ActiveWebWindow: WebWindow read Get_ActiveWebWindow;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
    property Build: WideString read Get_Build;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property CommandBars: CommandBars read Get_CommandBars;
    property FileSearch: FileSearch read Get_FileSearch;
    property LanguageSettings: LanguageSettings read Get_LanguageSettings;
    property Name: WideString read Get_Name;
    property OrganizationName: WideString read Get_OrganizationName;
    property System_: System read Get_System_;
    property Themes: Themes read Get_Themes;
    property Version: WideString read Get_Version;
    property Webs: Webs read Get_Webs;
    property WebWindows: WebWindows read Get_WebWindows;
    property ProductCode: WideString read Get_ProductCode;
    property UserName: WideString read Get_UserName write Set_UserName;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TFrontPageApplicationProperties read GetServerProperties;
{$ENDIF}
    property OnWebNew: TFrontPageApplicationOnWebNew read FOnWebNew write FOnWebNew;
    property OnWebOpen: TFrontPageApplicationOnWebOpen read FOnWebOpen write FOnWebOpen;
    property OnWebClose: TFrontPageApplicationOnWebClose read FOnWebClose write FOnWebClose;
    property OnBeforeWebPublish: TFrontPageApplicationOnBeforeWebPublish read FOnBeforeWebPublish write FOnBeforeWebPublish;
    property OnAfterWebPublish: TFrontPageApplicationOnAfterWebPublish read FOnAfterWebPublish write FOnAfterWebPublish;
    property OnPageNew: TFrontPageApplicationOnPageNew read FOnPageNew write FOnPageNew;
    property OnPageOpen: TFrontPageApplicationOnPageOpen read FOnPageOpen write FOnPageOpen;
    property OnPageClose: TFrontPageApplicationOnPageClose read FOnPageClose write FOnPageClose;
    property OnBeforePageSave: TFrontPageApplicationOnBeforePageSave read FOnBeforePageSave write FOnBeforePageSave;
    property OnAfterPageSave: TFrontPageApplicationOnAfterPageSave read FOnAfterPageSave write FOnAfterPageSave;
    property OnWindowActivate: TFrontPageApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TFrontPageApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TFrontPageApplication
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TFrontPageApplicationProperties = class(TPersistent)
  private
    FServer:    TFrontPageApplication;
    function    GetDefaultInterface: _Application;
    constructor Create(AServer: TFrontPageApplication);
  protected
    function  Get_Application: _Application;
    function  Get_ActiveDocument: IHTMLDocument2;
    function  Get_ActivePageWindow: PageWindow;
    function  Get_ActiveWeb: Web;
    function  Get_ActiveWebWindow: WebWindow;
    function  Get_AnswerWizard: AnswerWizard;
    function  Get_Build: WideString;
    function  Get_COMAddIns: COMAddIns;
    function  Get_CommandBars: CommandBars;
    function  Get_FileSearch: FileSearch;
    function  Get_LanguageSettings: LanguageSettings;
    function  Get_Name: WideString;
    function  Get_OrganizationName: WideString;
    function  Get_System_: System;
    function  Get_Themes: Themes;
    function  Get_UserName: WideString;
    procedure Set_UserName(const pVal: WideString);
    function  Get_Version: WideString;
    function  Get_Webs: Webs;
    function  Get_WebWindows: WebWindows;
    function  Get_ProductCode: WideString;
  public
    property DefaultInterface: _Application read GetDefaultInterface;
  published
    property UserName: WideString read Get_UserName write Set_UserName;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCWebberAutomation provides a Create and CreateRemote method to
// create instances of the default interface IWebber exposed by
// the CoClass CWebberAutomation. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCWebberAutomation = class
    class function Create: IWebber;
    class function CreateRemote(const MachineName: string): IWebber;
  end;

// *********************************************************************//
// The Class CoCAutoJack provides a Create and CreateRemote method to
// create instances of the default interface IPageEditor exposed by
// the CoClass CAutoJack. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCAutoJack = class
    class function Create: IPageEditor;
    class function CreateRemote(const MachineName: string): IPageEditor;
  end;

// *********************************************************************//
// The Class CoExplorerWebs provides a Create and CreateRemote method to
// create instances of the default interface IExplorerWebs exposed by
// the CoClass ExplorerWebs. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoExplorerWebs = class
    class function Create: IExplorerWebs;
    class function CreateRemote(const MachineName: string): IExplorerWebs;
  end;

// *********************************************************************//
// The Class CoExplorerWeb provides a Create and CreateRemote method to
// create instances of the default interface IExplorerWeb exposed by
// the CoClass ExplorerWeb. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoExplorerWeb = class
    class function Create: IExplorerWeb;
    class function CreateRemote(const MachineName: string): IExplorerWeb;
  end;

implementation

uses ComObj;

class function CoApplication.Create: _Application;
begin
  Result := CreateComObject(CLASS_Application) as _Application;
end;

class function CoApplication.CreateRemote(const MachineName: string): _Application;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as _Application;
end;

procedure TFrontPageApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{04DF1015-7007-11D1-83BC-006097ABE675}';
    IntfIID:   '{04DF1014-7007-11D1-83BC-006097ABE675}';
    EventIID:  '{F5D15700-E9D8-11D1-B0DF-00C04FA30A8B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TFrontPageApplication.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Application;
  end;
end;

procedure TFrontPageApplication.ConnectTo(svrIntf: _Application);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TFrontPageApplication.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    if FAutoQuit then
      Quit();
    FIntf := nil;
  end;
end;

function TFrontPageApplication.GetDefaultInterface: _Application;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TFrontPageApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TFrontPageApplicationProperties.Create(Self);
{$ENDIF}
end;

destructor TFrontPageApplication.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TFrontPageApplication.GetServerProperties: TFrontPageApplicationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TFrontPageApplication.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnWebNew) then
            FOnWebNew(Self, Params[0] {const Web});
   2: if Assigned(FOnWebOpen) then
            FOnWebOpen(Self, Params[0] {const Web});
   3: if Assigned(FOnWebClose) then
            FOnWebClose(Self, Params[0] {const Web}, Params[1] {var WordBool});
   4: if Assigned(FOnBeforeWebPublish) then
            FOnBeforeWebPublish(Self, Params[0] {const Web}, Params[1] {var WideString}, Params[2] {var WordBool});
   5: if Assigned(FOnAfterWebPublish) then
            FOnAfterWebPublish(Self, Params[0] {const Web}, Params[1] {var WordBool});
   6: if Assigned(FOnPageNew) then
            FOnPageNew(Self, Params[0] {const PageWindow});
   7: if Assigned(FOnPageOpen) then
            FOnPageOpen(Self, Params[0] {const PageWindow});
   8: if Assigned(FOnPageClose) then
            FOnPageClose(Self, Params[0] {const PageWindow}, Params[1] {var WordBool});
   9: if Assigned(FOnBeforePageSave) then
            FOnBeforePageSave(Self, Params[0] {const PageWindow}, Params[1] {var WordBool}, Params[2] {var WordBool});
   10: if Assigned(FOnAfterPageSave) then
            FOnAfterPageSave(Self, Params[0] {const PageWindow}, Params[1] {var WordBool});
   11: if Assigned(FOnWindowActivate) then
            FOnWindowActivate(Self, Params[0] {const WebWindow});
   12: if Assigned(FOnWindowDeactivate) then
            FOnWindowDeactivate(Self, Params[0] {const WebWindow});
  end; {case DispID}
end;

function  TFrontPageApplication.Get_Application: _Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TFrontPageApplication.Get_ActiveDocument: IHTMLDocument2;
begin
  Result := DefaultInterface.Get_ActiveDocument;
end;

function  TFrontPageApplication.Get_ActivePageWindow: PageWindow;
begin
  Result := DefaultInterface.Get_ActivePageWindow;
end;

function  TFrontPageApplication.Get_ActiveWeb: Web;
begin
  Result := DefaultInterface.Get_ActiveWeb;
end;

function  TFrontPageApplication.Get_ActiveWebWindow: WebWindow;
begin
  Result := DefaultInterface.Get_ActiveWebWindow;
end;

function  TFrontPageApplication.Get_AnswerWizard: AnswerWizard;
begin
  Result := DefaultInterface.Get_AnswerWizard;
end;

function  TFrontPageApplication.Get_Build: WideString;
begin
  Result := DefaultInterface.Get_Build;
end;

function  TFrontPageApplication.Get_COMAddIns: COMAddIns;
begin
  Result := DefaultInterface.Get_COMAddIns;
end;

function  TFrontPageApplication.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.Get_CommandBars;
end;

function  TFrontPageApplication.Get_FileSearch: FileSearch;
begin
  Result := DefaultInterface.Get_FileSearch;
end;

function  TFrontPageApplication.Get_LanguageSettings: LanguageSettings;
begin
  Result := DefaultInterface.Get_LanguageSettings;
end;

function  TFrontPageApplication.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TFrontPageApplication.Get_OrganizationName: WideString;
begin
  Result := DefaultInterface.Get_OrganizationName;
end;

function  TFrontPageApplication.Get_System_: System;
begin
  Result := DefaultInterface.Get_System_;
end;

function  TFrontPageApplication.Get_Themes: Themes;
begin
  Result := DefaultInterface.Get_Themes;
end;

function  TFrontPageApplication.Get_UserName: WideString;
begin
  Result := DefaultInterface.Get_UserName;
end;

procedure TFrontPageApplication.Set_UserName(const pVal: WideString);
begin
  DefaultInterface.Set_UserName(pVal);
end;

function  TFrontPageApplication.Get_Version: WideString;
begin
  Result := DefaultInterface.Get_Version;
end;

function  TFrontPageApplication.Get_Webs: Webs;
begin
  Result := DefaultInterface.Get_Webs;
end;

function  TFrontPageApplication.Get_WebWindows: WebWindows;
begin
  Result := DefaultInterface.Get_WebWindows;
end;

function  TFrontPageApplication.Get_ProductCode: WideString;
begin
  Result := DefaultInterface.Get_ProductCode;
end;

function  TFrontPageApplication.LocatePage(const DocumentUrl: WideString; ViewMode: FpPageViewMode): PageWindow;
begin
  Result := DefaultInterface.LocatePage(DocumentUrl, ViewMode);
end;

function  TFrontPageApplication.MakeAbs(var UrlBase: OleVariant; const Url: WideString): WideString;
begin
  Result := DefaultInterface.MakeAbs(UrlBase, Url);
end;

function  TFrontPageApplication.MakeRel(var UrlBase: OleVariant; const Url: WideString): WideString;
begin
  Result := DefaultInterface.MakeRel(UrlBase, Url);
end;

procedure TFrontPageApplication.Quit;
begin
  DefaultInterface.Quit;
end;

function  TFrontPageApplication.Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant;
begin
  Result := DefaultInterface.Run(MacroName, safeArrayOfParams);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TFrontPageApplicationProperties.Create(AServer: TFrontPageApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TFrontPageApplicationProperties.GetDefaultInterface: _Application;
begin
  Result := FServer.DefaultInterface;
end;

function  TFrontPageApplicationProperties.Get_Application: _Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TFrontPageApplicationProperties.Get_ActiveDocument: IHTMLDocument2;
begin
  Result := DefaultInterface.Get_ActiveDocument;
end;

function  TFrontPageApplicationProperties.Get_ActivePageWindow: PageWindow;
begin
  Result := DefaultInterface.Get_ActivePageWindow;
end;

function  TFrontPageApplicationProperties.Get_ActiveWeb: Web;
begin
  Result := DefaultInterface.Get_ActiveWeb;
end;

function  TFrontPageApplicationProperties.Get_ActiveWebWindow: WebWindow;
begin
  Result := DefaultInterface.Get_ActiveWebWindow;
end;

function  TFrontPageApplicationProperties.Get_AnswerWizard: AnswerWizard;
begin
  Result := DefaultInterface.Get_AnswerWizard;
end;

function  TFrontPageApplicationProperties.Get_Build: WideString;
begin
  Result := DefaultInterface.Get_Build;
end;

function  TFrontPageApplicationProperties.Get_COMAddIns: COMAddIns;
begin
  Result := DefaultInterface.Get_COMAddIns;
end;

function  TFrontPageApplicationProperties.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.Get_CommandBars;
end;

function  TFrontPageApplicationProperties.Get_FileSearch: FileSearch;
begin
  Result := DefaultInterface.Get_FileSearch;
end;

function  TFrontPageApplicationProperties.Get_LanguageSettings: LanguageSettings;
begin
  Result := DefaultInterface.Get_LanguageSettings;
end;

function  TFrontPageApplicationProperties.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TFrontPageApplicationProperties.Get_OrganizationName: WideString;
begin
  Result := DefaultInterface.Get_OrganizationName;
end;

function  TFrontPageApplicationProperties.Get_System_: System;
begin
  Result := DefaultInterface.Get_System_;
end;

function  TFrontPageApplicationProperties.Get_Themes: Themes;
begin
  Result := DefaultInterface.Get_Themes;
end;

function  TFrontPageApplicationProperties.Get_UserName: WideString;
begin
  Result := DefaultInterface.Get_UserName;
end;

procedure TFrontPageApplicationProperties.Set_UserName(const pVal: WideString);
begin
  DefaultInterface.Set_UserName(pVal);
end;

function  TFrontPageApplicationProperties.Get_Version: WideString;
begin
  Result := DefaultInterface.Get_Version;
end;

function  TFrontPageApplicationProperties.Get_Webs: Webs;
begin
  Result := DefaultInterface.Get_Webs;
end;

function  TFrontPageApplicationProperties.Get_WebWindows: WebWindows;
begin
  Result := DefaultInterface.Get_WebWindows;
end;

function  TFrontPageApplicationProperties.Get_ProductCode: WideString;
begin
  Result := DefaultInterface.Get_ProductCode;
end;

{$ENDIF}

class function CoCWebberAutomation.Create: IWebber;
begin
  Result := CreateComObject(CLASS_CWebberAutomation) as IWebber;
end;

class function CoCWebberAutomation.CreateRemote(const MachineName: string): IWebber;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CWebberAutomation) as IWebber;
end;

class function CoCAutoJack.Create: IPageEditor;
begin
  Result := CreateComObject(CLASS_CAutoJack) as IPageEditor;
end;

class function CoCAutoJack.CreateRemote(const MachineName: string): IPageEditor;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CAutoJack) as IPageEditor;
end;

class function CoExplorerWebs.Create: IExplorerWebs;
begin
  Result := CreateComObject(CLASS_ExplorerWebs) as IExplorerWebs;
end;

class function CoExplorerWebs.CreateRemote(const MachineName: string): IExplorerWebs;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExplorerWebs) as IExplorerWebs;
end;

class function CoExplorerWeb.Create: IExplorerWeb;
begin
  Result := CreateComObject(CLASS_ExplorerWeb) as IExplorerWeb;
end;

class function CoExplorerWeb.CreateRemote(const MachineName: string): IExplorerWeb;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExplorerWeb) as IExplorerWeb;
end;

end.
