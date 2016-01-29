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

unit adxSmartTagTLB;

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

// PASTLWTR : 1.2
// File generated on 5/24/2004 3:11:07 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: F:\Program Files\Common Files\Microsoft Shared\Smart Tag\MSTAG.TLB (1)
// LIBID: {9B92EB61-CBC1-11D3-8C2D-00A0CC37B591}
// LCID: 0
// Helpfile: 
// HelpString: Microsoft Smart Tags 2.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (D:\WINDOWS\System32\STDOLE2.TLB)
// Errors:
//   Hint: Parameter 'Type' of ISmartDocument.ControlTypeFromID changed to 'Type_'
// ************************************************************************ //
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

{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.

{$I adxDefs.inc}

interface

uses ActiveX;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SmartTagLibMajorVersion = 1;
  SmartTagLibMinorVersion = 2;

  LIBID_SmartTagLib: TGUID = '{9B92EB61-CBC1-11D3-8C2D-00A0CC37B591}';

  IID_ISmartTagRecognizer: TGUID = '{3C6C0440-A27D-11D3-BD33-D80C46980A07}';
  IID_ISmartTagRecognizerSite: TGUID = '{9BF068D0-B735-11D3-B2CF-00500489D6A3}';
  IID_ISmartTagProperties: TGUID = '{54F37842-CDD7-11D3-B2D4-00500489D6A3}';
  IID_ISmartTagAction: TGUID = '{3B744D8F-B8A5-11D3-B2CF-00500489D6A3}';
  IID_ISmartTagRecognizer2: TGUID = '{D4C62D17-6162-41DE-BE24-5B1D3F529CC3}';
  IID_ISmartTagRecognizerSite2: TGUID = '{347958C0-E86F-4865-97C8-BED31E4C28E0}';
  IID_ISmartTagTokenList: TGUID = '{9BF068D0-B736-11D3-B2CF-00500489D6A4}';
  IID_ISmartTagToken: TGUID = '{9BF068D0-B736-11D3-B2CF-00500489D6A5}';
  IID_ISmartTagTokenProperties: TGUID = '{9BF068D0-B736-11D3-B2CF-00500489D6A6}';
  IID_ISmartTagAction2: TGUID = '{5073BDEB-E480-4024-887E-22923C004444}';
  IID_ISmartDocProperties: TGUID = '{FE6A04A8-6CE8-449F-87F1-1AFB705547AE}';
  IID_ISmartDocument: TGUID = '{9BF068D0-B736-11D3-B2CF-00500489D6D6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_mstag_0000_0001
type
  __MIDL___MIDL_itf_mstag_0000_0001 = TOleEnum;
const
  IF_TYPE_CHAR = $00000001;
  IF_TYPE_SINGLE_WD = $00000002;
  IF_TYPE_REGEXP = $00000004;
  IF_TYPE_PARA = $00000008;
  IF_TYPE_CELL = $00000010;
  IF_TYPE_RUN = $00000020;

// Constants for enum __MIDL___MIDL_itf_mstag_0000_0002
type
  __MIDL___MIDL_itf_mstag_0000_0002 = TOleEnum;
const
  C_TYPE_LINK = $00000002;
  C_TYPE_HELP = $00000003;
  C_TYPE_HELPURL = $00000004;
  C_TYPE_SEPARATOR = $00000005;
  C_TYPE_BUTTON = $00000006;
  C_TYPE_LABEL = $00000007;
  C_TYPE_IMAGE = $00000008;
  C_TYPE_CHECKBOX = $00000009;
  C_TYPE_TEXTBOX = $0000000A;
  C_TYPE_LISTBOX = $0000000B;
  C_TYPE_COMBO = $0000000C;
  C_TYPE_ACTIVEX = $0000000D;
  C_TYPE_DOCUMENTFRAGMENT = $0000000E;
  C_TYPE_DOCUMENTFRAGMENTURL = $0000000F;
  C_TYPE_RADIOGROUP = $00000010;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISmartTagRecognizer = interface;
  ISmartTagRecognizerDisp = dispinterface;
  ISmartTagRecognizerSite = interface;
  ISmartTagRecognizerSiteDisp = dispinterface;
  ISmartTagProperties = interface;
  ISmartTagPropertiesDisp = dispinterface;
  ISmartTagAction = interface;
  ISmartTagActionDisp = dispinterface;
  ISmartTagRecognizer2 = interface;
  ISmartTagRecognizer2Disp = dispinterface;
  ISmartTagRecognizerSite2 = interface;
  ISmartTagRecognizerSite2Disp = dispinterface;
  ISmartTagTokenList = interface;
  ISmartTagTokenListDisp = dispinterface;
  ISmartTagToken = interface;
  ISmartTagTokenDisp = dispinterface;
  ISmartTagTokenProperties = interface;
  ISmartTagTokenPropertiesDisp = dispinterface;
  ISmartTagAction2 = interface;
  ISmartTagAction2Disp = dispinterface;
  ISmartDocProperties = interface;
  ISmartDocPropertiesDisp = dispinterface;
  ISmartDocument = interface;
  ISmartDocumentDisp = dispinterface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//

  IF_TYPE = __MIDL___MIDL_itf_mstag_0000_0001; 
  C_TYPE = __MIDL___MIDL_itf_mstag_0000_0002; 

// *********************************************************************//
// Interface: ISmartTagRecognizer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3C6C0440-A27D-11D3-BD33-D80C46980A07}
// *********************************************************************//
  ISmartTagRecognizer = interface(IDispatch)
    ['{3C6C0440-A27D-11D3-BD33-D80C46980A07}']
    function Get_ProgId: WideString; safecall;
    function Get_Name(LocaleID: SYSINT): WideString; safecall;
    function Get_Desc(LocaleID: SYSINT): WideString; safecall;
    function Get_SmartTagCount: SYSINT; safecall;
    function Get_SmartTagName(SmartTagID: SYSINT): WideString; safecall;
    function Get_SmartTagDownloadURL(SmartTagID: SYSINT): WideString; safecall;
    procedure Recognize(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT; 
                        const RecognizerSite: ISmartTagRecognizerSite); safecall;
    property ProgId: WideString read Get_ProgId;
    property Name[LocaleID: SYSINT]: WideString read Get_Name;
    property Desc[LocaleID: SYSINT]: WideString read Get_Desc;
    property SmartTagCount: SYSINT read Get_SmartTagCount;
    property SmartTagName[SmartTagID: SYSINT]: WideString read Get_SmartTagName;
    property SmartTagDownloadURL[SmartTagID: SYSINT]: WideString read Get_SmartTagDownloadURL;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagRecognizerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3C6C0440-A27D-11D3-BD33-D80C46980A07}
// *********************************************************************//
  ISmartTagRecognizerDisp = dispinterface
    ['{3C6C0440-A27D-11D3-BD33-D80C46980A07}']
    property ProgId: WideString readonly dispid 1;
    property Name[LocaleID: SYSINT]: WideString readonly dispid 2;
    property Desc[LocaleID: SYSINT]: WideString readonly dispid 3;
    property SmartTagCount: SYSINT readonly dispid 4;
    property SmartTagName[SmartTagID: SYSINT]: WideString readonly dispid 5;
    property SmartTagDownloadURL[SmartTagID: SYSINT]: WideString readonly dispid 6;
    procedure Recognize(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT; 
                        const RecognizerSite: ISmartTagRecognizerSite); dispid 7;
  end;

// *********************************************************************//
// Interface: ISmartTagRecognizerSite
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B735-11D3-B2CF-00500489D6A3}
// *********************************************************************//
  ISmartTagRecognizerSite = interface(IDispatch)
    ['{9BF068D0-B735-11D3-B2CF-00500489D6A3}']
    function GetNewPropertyBag: ISmartTagProperties; safecall;
    procedure CommitSmartTag(const SmartTagName: WideString; Start: SYSINT; Length: SYSINT; 
                             const Properties: ISmartTagProperties); safecall;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagRecognizerSiteDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B735-11D3-B2CF-00500489D6A3}
// *********************************************************************//
  ISmartTagRecognizerSiteDisp = dispinterface
    ['{9BF068D0-B735-11D3-B2CF-00500489D6A3}']
    function GetNewPropertyBag: ISmartTagProperties; dispid 1;
    procedure CommitSmartTag(const SmartTagName: WideString; Start: SYSINT; Length: SYSINT; 
                             const Properties: ISmartTagProperties); dispid 2;
  end;

// *********************************************************************//
// Interface: ISmartTagProperties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {54F37842-CDD7-11D3-B2D4-00500489D6A3}
// *********************************************************************//
  ISmartTagProperties = interface(IDispatch)
    ['{54F37842-CDD7-11D3-B2D4-00500489D6A3}']
    function Get_Read(const Key: WideString): WideString; safecall;
    procedure Write(const Key: WideString; const Value: WideString); safecall;
    function Get_Count: SYSINT; safecall;
    function Get_KeyFromIndex(Index: SYSINT): WideString; safecall;
    function Get_ValueFromIndex(Index: SYSINT): WideString; safecall;
    property Read[const Key: WideString]: WideString read Get_Read;
    property Count: SYSINT read Get_Count;
    property KeyFromIndex[Index: SYSINT]: WideString read Get_KeyFromIndex;
    property ValueFromIndex[Index: SYSINT]: WideString read Get_ValueFromIndex;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagPropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {54F37842-CDD7-11D3-B2D4-00500489D6A3}
// *********************************************************************//
  ISmartTagPropertiesDisp = dispinterface
    ['{54F37842-CDD7-11D3-B2D4-00500489D6A3}']
    property Read[const Key: WideString]: WideString readonly dispid 1;
    procedure Write(const Key: WideString; const Value: WideString); dispid 2;
    property Count: SYSINT readonly dispid 3;
    property KeyFromIndex[Index: SYSINT]: WideString readonly dispid 4;
    property ValueFromIndex[Index: SYSINT]: WideString readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISmartTagAction
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B744D8F-B8A5-11D3-B2CF-00500489D6A3}
// *********************************************************************//
  ISmartTagAction = interface(IDispatch)
    ['{3B744D8F-B8A5-11D3-B2CF-00500489D6A3}']
    function Get_ProgId: WideString; safecall;
    function Get_Name(LocaleID: SYSINT): WideString; safecall;
    function Get_Desc(LocaleID: SYSINT): WideString; safecall;
    function Get_SmartTagCount: SYSINT; safecall;
    function Get_SmartTagName(SmartTagID: SYSINT): WideString; safecall;
    function Get_SmartTagCaption(SmartTagID: SYSINT; LocaleID: SYSINT): WideString; safecall;
    function Get_VerbCount(const SmartTagName: WideString): SYSINT; safecall;
    function Get_VerbID(const SmartTagName: WideString; VerbIndex: SYSINT): SYSINT; safecall;
    function Get_VerbCaptionFromID(VerbID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT): WideString; safecall;
    function Get_VerbNameFromID(VerbID: SYSINT): WideString; safecall;
    procedure InvokeVerb(VerbID: SYSINT; const ApplicationName: WideString; 
                         const Target: IDispatch; const Properties: ISmartTagProperties; 
                         const Text: WideString; const Xml: WideString); safecall;
    property ProgId: WideString read Get_ProgId;
    property Name[LocaleID: SYSINT]: WideString read Get_Name;
    property Desc[LocaleID: SYSINT]: WideString read Get_Desc;
    property SmartTagCount: SYSINT read Get_SmartTagCount;
    property SmartTagName[SmartTagID: SYSINT]: WideString read Get_SmartTagName;
    property SmartTagCaption[SmartTagID: SYSINT; LocaleID: SYSINT]: WideString read Get_SmartTagCaption;
    property VerbCount[const SmartTagName: WideString]: SYSINT read Get_VerbCount;
    property VerbID[const SmartTagName: WideString; VerbIndex: SYSINT]: SYSINT read Get_VerbID;
    property VerbCaptionFromID[VerbID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT]: WideString read Get_VerbCaptionFromID;
    property VerbNameFromID[VerbID: SYSINT]: WideString read Get_VerbNameFromID;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagActionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3B744D8F-B8A5-11D3-B2CF-00500489D6A3}
// *********************************************************************//
  ISmartTagActionDisp = dispinterface
    ['{3B744D8F-B8A5-11D3-B2CF-00500489D6A3}']
    property ProgId: WideString readonly dispid 1;
    property Name[LocaleID: SYSINT]: WideString readonly dispid 2;
    property Desc[LocaleID: SYSINT]: WideString readonly dispid 3;
    property SmartTagCount: SYSINT readonly dispid 4;
    property SmartTagName[SmartTagID: SYSINT]: WideString readonly dispid 5;
    property SmartTagCaption[SmartTagID: SYSINT; LocaleID: SYSINT]: WideString readonly dispid 6;
    property VerbCount[const SmartTagName: WideString]: SYSINT readonly dispid 7;
    property VerbID[const SmartTagName: WideString; VerbIndex: SYSINT]: SYSINT readonly dispid 8;
    property VerbCaptionFromID[VerbID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT]: WideString readonly dispid 9;
    property VerbNameFromID[VerbID: SYSINT]: WideString readonly dispid 10;
    procedure InvokeVerb(VerbID: SYSINT; const ApplicationName: WideString; 
                         const Target: IDispatch; const Properties: ISmartTagProperties; 
                         const Text: WideString; const Xml: WideString); dispid 11;
  end;

// *********************************************************************//
// Interface: ISmartTagRecognizer2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4C62D17-6162-41DE-BE24-5B1D3F529CC3}
// *********************************************************************//
  ISmartTagRecognizer2 = interface(IDispatch)
    ['{D4C62D17-6162-41DE-BE24-5B1D3F529CC3}']
    procedure Recognize2(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT; 
                         const RecognizerSite2: ISmartTagRecognizerSite2; 
                         const ApplicationName: WideString; const TokenList: ISmartTagTokenList); safecall;
    function Get_PropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT): WordBool; safecall;
    procedure DisplayPropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT); safecall;
    procedure SmartTagInitialize(const ApplicationName: WideString); safecall;
    property PropertyPage[SmartTagID: SYSINT; LocaleID: SYSINT]: WordBool read Get_PropertyPage;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagRecognizer2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {D4C62D17-6162-41DE-BE24-5B1D3F529CC3}
// *********************************************************************//
  ISmartTagRecognizer2Disp = dispinterface
    ['{D4C62D17-6162-41DE-BE24-5B1D3F529CC3}']
    procedure Recognize2(const Text: WideString; DataType: IF_TYPE; LocaleID: SYSINT; 
                         const RecognizerSite2: ISmartTagRecognizerSite2; 
                         const ApplicationName: WideString; const TokenList: ISmartTagTokenList); dispid 8;
    property PropertyPage[SmartTagID: SYSINT; LocaleID: SYSINT]: WordBool readonly dispid 9;
    procedure DisplayPropertyPage(SmartTagID: SYSINT; LocaleID: SYSINT); dispid 10;
    procedure SmartTagInitialize(const ApplicationName: WideString); dispid 16;
  end;

// *********************************************************************//
// Interface: ISmartTagRecognizerSite2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {347958C0-E86F-4865-97C8-BED31E4C28E0}
// *********************************************************************//
  ISmartTagRecognizerSite2 = interface(ISmartTagRecognizerSite)
    ['{347958C0-E86F-4865-97C8-BED31E4C28E0}']
    function CommitSmartTag2(const SmartTagName: WideString; Start: SYSINT; Length: SYSINT; 
                             const Properties: ISmartTagProperties): HResult; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagRecognizerSite2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {347958C0-E86F-4865-97C8-BED31E4C28E0}
// *********************************************************************//
  ISmartTagRecognizerSite2Disp = dispinterface
    ['{347958C0-E86F-4865-97C8-BED31E4C28E0}']
    function CommitSmartTag2(const SmartTagName: WideString; Start: SYSINT; Length: SYSINT; 
                             const Properties: ISmartTagProperties): HResult; dispid 3;
    function GetNewPropertyBag: ISmartTagProperties; dispid 1;
    procedure CommitSmartTag(const SmartTagName: WideString; Start: SYSINT; Length: SYSINT; 
                             const Properties: ISmartTagProperties); dispid 2;
  end;

// *********************************************************************//
// Interface: ISmartTagTokenList
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A4}
// *********************************************************************//
  ISmartTagTokenList = interface(IDispatch)
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A4}']
    function Get_Item(Index: Integer): ISmartTagToken; safecall;
    function Get_Count: Integer; safecall;
    property Item[Index: Integer]: ISmartTagToken read Get_Item;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagTokenListDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A4}
// *********************************************************************//
  ISmartTagTokenListDisp = dispinterface
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A4}']
    property Item[Index: Integer]: ISmartTagToken readonly dispid 1;
    property Count: Integer readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ISmartTagToken
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A5}
// *********************************************************************//
  ISmartTagToken = interface(IDispatch)
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A5}']
    function Get_Start: Integer; safecall;
    function Get_Length: Integer; safecall;
    function Get_Text: WideString; safecall;
    function Get_Properties: ISmartTagTokenProperties; safecall;
    property Start: Integer read Get_Start;
    property Length: Integer read Get_Length;
    property Text: WideString read Get_Text;
    property Properties: ISmartTagTokenProperties read Get_Properties;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagTokenDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A5}
// *********************************************************************//
  ISmartTagTokenDisp = dispinterface
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A5}']
    property Start: Integer readonly dispid 1;
    property Length: Integer readonly dispid 2;
    property Text: WideString readonly dispid 3;
    property Properties: ISmartTagTokenProperties readonly dispid 4;
  end;

// *********************************************************************//
// Interface: ISmartTagTokenProperties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A6}
// *********************************************************************//
  ISmartTagTokenProperties = interface(IDispatch)
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A6}']
    function Get_Read(const Key: WideString): WideString; safecall;
    function Get_Count: SYSINT; safecall;
    function Get_KeyFromIndex(Index: SYSINT): WideString; safecall;
    function Get_ValueFromIndex(Index: SYSINT): WideString; safecall;
    property Read[const Key: WideString]: WideString read Get_Read;
    property Count: SYSINT read Get_Count;
    property KeyFromIndex[Index: SYSINT]: WideString read Get_KeyFromIndex;
    property ValueFromIndex[Index: SYSINT]: WideString read Get_ValueFromIndex;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagTokenPropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6A6}
// *********************************************************************//
  ISmartTagTokenPropertiesDisp = dispinterface
    ['{9BF068D0-B736-11D3-B2CF-00500489D6A6}']
    property Read[const Key: WideString]: WideString readonly dispid 1;
    property Count: SYSINT readonly dispid 3;
    property KeyFromIndex[Index: SYSINT]: WideString readonly dispid 4;
    property ValueFromIndex[Index: SYSINT]: WideString readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISmartTagAction2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5073BDEB-E480-4024-887E-22923C004444}
// *********************************************************************//
  ISmartTagAction2 = interface(IDispatch)
    ['{5073BDEB-E480-4024-887E-22923C004444}']
    function Get_VerbCaptionFromID2(VerbID: SYSINT; const ApplicationName: WideString; 
                                    LocaleID: SYSINT; const Properties: ISmartTagProperties; 
                                    const Text: WideString; const Xml: WideString; 
                                    const Target: IDispatch): WideString; safecall;
    procedure InvokeVerb2(VerbID: SYSINT; const ApplicationName: WideString; 
                          const Target: IDispatch; const Properties: ISmartTagProperties; 
                          const Text: WideString; const Xml: WideString; LocaleID: SYSINT); safecall;
    function Get_IsCaptionDynamic(VerbID: SYSINT; const ApplicationName: WideString; 
                                  LocaleID: SYSINT): WordBool; safecall;
    function Get_ShowSmartTagIndicator(VerbID: SYSINT; const ApplicationName: WideString; 
                                       LocaleID: SYSINT): WordBool; safecall;
    procedure SmartTagInitialize(const ApplicationName: WideString); safecall;
    property VerbCaptionFromID2[VerbID: SYSINT; const ApplicationName: WideString; 
                                LocaleID: SYSINT; const Properties: ISmartTagProperties; 
                                const Text: WideString; const Xml: WideString; 
                                const Target: IDispatch]: WideString read Get_VerbCaptionFromID2;
    property IsCaptionDynamic[VerbID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT]: WordBool read Get_IsCaptionDynamic;
    property ShowSmartTagIndicator[VerbID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT]: WordBool read Get_ShowSmartTagIndicator;
  end;

// *********************************************************************//
// DispIntf:  ISmartTagAction2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {5073BDEB-E480-4024-887E-22923C004444}
// *********************************************************************//
  ISmartTagAction2Disp = dispinterface
    ['{5073BDEB-E480-4024-887E-22923C004444}']
    property VerbCaptionFromID2[VerbID: SYSINT; const ApplicationName: WideString; 
                                LocaleID: SYSINT; const Properties: ISmartTagProperties; 
                                const Text: WideString; const Xml: WideString; 
                                const Target: IDispatch]: WideString readonly dispid 12;
    procedure InvokeVerb2(VerbID: SYSINT; const ApplicationName: WideString; 
                          const Target: IDispatch; const Properties: ISmartTagProperties; 
                          const Text: WideString; const Xml: WideString; LocaleID: SYSINT); dispid 13;
    property IsCaptionDynamic[VerbID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT]: WordBool readonly dispid 14;
    property ShowSmartTagIndicator[VerbID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT]: WordBool readonly dispid 15;
    procedure SmartTagInitialize(const ApplicationName: WideString); dispid 16;
  end;

// *********************************************************************//
// Interface: ISmartDocProperties
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FE6A04A8-6CE8-449F-87F1-1AFB705547AE}
// *********************************************************************//
  ISmartDocProperties = interface(IDispatch)
    ['{FE6A04A8-6CE8-449F-87F1-1AFB705547AE}']
    function Get_Read(const Key: WideString): WideString; safecall;
    procedure Write(const Key: WideString; const Value: WideString); safecall;
    function Get_Count: SYSINT; safecall;
    function Get_KeyFromIndex(Index: SYSINT): WideString; safecall;
    function Get_ValueFromIndex(Index: SYSINT): WideString; safecall;
    property Read[const Key: WideString]: WideString read Get_Read;
    property Count: SYSINT read Get_Count;
    property KeyFromIndex[Index: SYSINT]: WideString read Get_KeyFromIndex;
    property ValueFromIndex[Index: SYSINT]: WideString read Get_ValueFromIndex;
  end;

// *********************************************************************//
// DispIntf:  ISmartDocPropertiesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FE6A04A8-6CE8-449F-87F1-1AFB705547AE}
// *********************************************************************//
  ISmartDocPropertiesDisp = dispinterface
    ['{FE6A04A8-6CE8-449F-87F1-1AFB705547AE}']
    property Read[const Key: WideString]: WideString readonly dispid 1;
    procedure Write(const Key: WideString; const Value: WideString); dispid 2;
    property Count: SYSINT readonly dispid 3;
    property KeyFromIndex[Index: SYSINT]: WideString readonly dispid 4;
    property ValueFromIndex[Index: SYSINT]: WideString readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ISmartDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6D6}
// *********************************************************************//
  ISmartDocument = interface(IDispatch)
    ['{9BF068D0-B736-11D3-B2CF-00500489D6D6}']
    procedure SmartDocInitialize(const ApplicationName: WideString; const Document: IDispatch; 
                                 const SolutionPath: WideString; 
                                 const SolutionRegKeyRoot: WideString); safecall;
    function Get_SmartDocXmlTypeCount: SYSINT; safecall;
    function Get_SmartDocXmlTypeName(SmartDocID: SYSINT): WideString; safecall;
    function Get_SmartDocXmlTypeCaption(SmartDocID: SYSINT; LocaleID: SYSINT): WideString; safecall;
    function Get_ControlCount(const SmartDocName: WideString): SYSINT; safecall;
    function Get_ControlID(const SmartDocName: WideString; ControlIndex: SYSINT): SYSINT; safecall;
    function Get_ControlNameFromID(ControlID: SYSINT): WideString; safecall;
    function Get_ControlTypeFromID(ControlID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT): C_TYPE; safecall;
    function Get_ControlCaptionFromID(ControlID: SYSINT; const ApplicationName: WideString; 
                                      LocaleID: SYSINT; const Text: WideString; 
                                      const Xml: WideString; const Target: IDispatch): WideString; safecall;
    procedure InvokeControl(ControlID: SYSINT; const ApplicationName: WideString; 
                            const Target: IDispatch; const Text: WideString; const Xml: WideString; 
                            LocaleID: SYSINT); safecall;
    procedure PopulateHelpContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                  LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                  const Target: IDispatch; const Props: ISmartDocProperties; 
                                  var Content: WideString); safecall;
    procedure PopulateCheckbox(ControlID: SYSINT; const ApplicationName: WideString; 
                               LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                               const Target: IDispatch; const Props: ISmartDocProperties; 
                               var Checked: WordBool); safecall;
    procedure PopulateTextboxContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                     LocaleID: SYSINT; const Text: WideString; 
                                     const Xml: WideString; const Target: IDispatch; 
                                     const Props: ISmartDocProperties; var Value: WideString); safecall;
    procedure PopulateListOrComboContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                         LocaleID: SYSINT; const Text: WideString; 
                                         const Xml: WideString; const Target: IDispatch; 
                                         const Props: ISmartDocProperties; var List: PSafeArray; 
                                         var Count: SYSINT; var InitialSelected: SYSINT); safecall;
    procedure OnCheckboxChange(ControlID: SYSINT; const Target: IDispatch; Checked: WordBool); safecall;
    procedure OnTextboxContentChange(ControlID: SYSINT; const Target: IDispatch; 
                                     const Value: WideString); safecall;
    procedure OnListOrComboSelectChange(ControlID: SYSINT; const Target: IDispatch; 
                                        Selected: SYSINT; const Value: WideString); safecall;
    procedure PopulateDocumentFragment(ControlID: SYSINT; const ApplicationName: WideString; 
                                       LocaleID: SYSINT; const Text: WideString; 
                                       const Xml: WideString; const Target: IDispatch; 
                                       const Props: ISmartDocProperties; 
                                       var DocumentFragment: WideString); safecall;
    procedure PopulateActiveXProps(ControlID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                   const Target: IDispatch; const Props: ISmartDocProperties; 
                                   const ActiveXPropBag: ISmartDocProperties); safecall;
    procedure PopulateImage(ControlID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT; 
                            const Text: WideString; const Xml: WideString; const Target: IDispatch; 
                            const Props: ISmartDocProperties; var ImageSrc: WideString); safecall;
    procedure ImageClick(ControlID: SYSINT; const ApplicationName: WideString; 
                         const Target: IDispatch; const Text: WideString; const Xml: WideString; 
                         LocaleID: SYSINT; XCoordinate: SYSINT; YCoordinate: SYSINT); safecall;
    procedure PopulateRadioGroup(ControlID: SYSINT; const ApplicationName: WideString; 
                                 LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                 const Target: IDispatch; const Props: ISmartDocProperties; 
                                 var List: PSafeArray; var Count: SYSINT; 
                                 var InitialSelected: SYSINT); safecall;
    procedure OnRadioGroupSelectChange(ControlID: SYSINT; const Target: IDispatch; 
                                       Selected: SYSINT; const Value: WideString); safecall;
    procedure OnPaneUpdateComplete(const Document: IDispatch); safecall;
    procedure PopulateOther(ControlID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT; 
                            const Text: WideString; const Xml: WideString; const Target: IDispatch; 
                            const Props: ISmartDocProperties); safecall;
    property SmartDocXmlTypeCount: SYSINT read Get_SmartDocXmlTypeCount;
    property SmartDocXmlTypeName[SmartDocID: SYSINT]: WideString read Get_SmartDocXmlTypeName;
    property SmartDocXmlTypeCaption[SmartDocID: SYSINT; LocaleID: SYSINT]: WideString read Get_SmartDocXmlTypeCaption;
    property ControlCount[const SmartDocName: WideString]: SYSINT read Get_ControlCount;
    property ControlID[const SmartDocName: WideString; ControlIndex: SYSINT]: SYSINT read Get_ControlID;
    property ControlNameFromID[ControlID: SYSINT]: WideString read Get_ControlNameFromID;
    property ControlTypeFromID[ControlID: SYSINT; const ApplicationName: WideString; 
                               LocaleID: SYSINT]: C_TYPE read Get_ControlTypeFromID;
    property ControlCaptionFromID[ControlID: SYSINT; const ApplicationName: WideString; 
                                  LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                  const Target: IDispatch]: WideString read Get_ControlCaptionFromID;
  end;

// *********************************************************************//
// DispIntf:  ISmartDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9BF068D0-B736-11D3-B2CF-00500489D6D6}
// *********************************************************************//
  ISmartDocumentDisp = dispinterface
    ['{9BF068D0-B736-11D3-B2CF-00500489D6D6}']
    procedure SmartDocInitialize(const ApplicationName: WideString; const Document: IDispatch; 
                                 const SolutionPath: WideString; 
                                 const SolutionRegKeyRoot: WideString); dispid 26;
    property SmartDocXmlTypeCount: SYSINT readonly dispid 4;
    property SmartDocXmlTypeName[SmartDocID: SYSINT]: WideString readonly dispid 5;
    property SmartDocXmlTypeCaption[SmartDocID: SYSINT; LocaleID: SYSINT]: WideString readonly dispid 6;
    property ControlCount[const SmartDocName: WideString]: SYSINT readonly dispid 7;
    property ControlID[const SmartDocName: WideString; ControlIndex: SYSINT]: SYSINT readonly dispid 8;
    property ControlNameFromID[ControlID: SYSINT]: WideString readonly dispid 10;
    property ControlTypeFromID[ControlID: SYSINT; const ApplicationName: WideString; 
                               LocaleID: SYSINT]: C_TYPE readonly dispid 16;
    property ControlCaptionFromID[ControlID: SYSINT; const ApplicationName: WideString; 
                                  LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                  const Target: IDispatch]: WideString readonly dispid 12;
    procedure InvokeControl(ControlID: SYSINT; const ApplicationName: WideString; 
                            const Target: IDispatch; const Text: WideString; const Xml: WideString; 
                            LocaleID: SYSINT); dispid 13;
    procedure PopulateHelpContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                  LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                  const Target: IDispatch; const Props: ISmartDocProperties; 
                                  var Content: WideString); dispid 17;
    procedure PopulateCheckbox(ControlID: SYSINT; const ApplicationName: WideString; 
                               LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                               const Target: IDispatch; const Props: ISmartDocProperties; 
                               var Checked: WordBool); dispid 18;
    procedure PopulateTextboxContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                     LocaleID: SYSINT; const Text: WideString; 
                                     const Xml: WideString; const Target: IDispatch; 
                                     const Props: ISmartDocProperties; var Value: WideString); dispid 19;
    procedure PopulateListOrComboContent(ControlID: SYSINT; const ApplicationName: WideString; 
                                         LocaleID: SYSINT; const Text: WideString; 
                                         const Xml: WideString; const Target: IDispatch; 
                                         const Props: ISmartDocProperties; 
                                         var List: {??PSafeArray}OleVariant; var Count: SYSINT; 
                                         var InitialSelected: SYSINT); dispid 20;
    procedure OnCheckboxChange(ControlID: SYSINT; const Target: IDispatch; Checked: WordBool); dispid 21;
    procedure OnTextboxContentChange(ControlID: SYSINT; const Target: IDispatch; 
                                     const Value: WideString); dispid 22;
    procedure OnListOrComboSelectChange(ControlID: SYSINT; const Target: IDispatch; 
                                        Selected: SYSINT; const Value: WideString); dispid 23;
    procedure PopulateDocumentFragment(ControlID: SYSINT; const ApplicationName: WideString; 
                                       LocaleID: SYSINT; const Text: WideString; 
                                       const Xml: WideString; const Target: IDispatch; 
                                       const Props: ISmartDocProperties; 
                                       var DocumentFragment: WideString); dispid 24;
    procedure PopulateActiveXProps(ControlID: SYSINT; const ApplicationName: WideString; 
                                   LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                   const Target: IDispatch; const Props: ISmartDocProperties; 
                                   const ActiveXPropBag: ISmartDocProperties); dispid 25;
    procedure PopulateImage(ControlID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT; 
                            const Text: WideString; const Xml: WideString; const Target: IDispatch; 
                            const Props: ISmartDocProperties; var ImageSrc: WideString); dispid 27;
    procedure ImageClick(ControlID: SYSINT; const ApplicationName: WideString; 
                         const Target: IDispatch; const Text: WideString; const Xml: WideString; 
                         LocaleID: SYSINT; XCoordinate: SYSINT; YCoordinate: SYSINT); dispid 28;
    procedure PopulateRadioGroup(ControlID: SYSINT; const ApplicationName: WideString; 
                                 LocaleID: SYSINT; const Text: WideString; const Xml: WideString; 
                                 const Target: IDispatch; const Props: ISmartDocProperties; 
                                 var List: {??PSafeArray}OleVariant; var Count: SYSINT; 
                                 var InitialSelected: SYSINT); dispid 29;
    procedure OnRadioGroupSelectChange(ControlID: SYSINT; const Target: IDispatch; 
                                       Selected: SYSINT; const Value: WideString); dispid 30;
    procedure OnPaneUpdateComplete(const Document: IDispatch); dispid 31;
    procedure PopulateOther(ControlID: SYSINT; const ApplicationName: WideString; LocaleID: SYSINT; 
                            const Text: WideString; const Xml: WideString; const Target: IDispatch; 
                            const Props: ISmartDocProperties); dispid 32;
  end;

implementation

uses ComObj;

end.
