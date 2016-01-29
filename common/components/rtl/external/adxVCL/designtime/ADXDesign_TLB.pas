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

unit ADXDesign_TLB;

{$I adxDefs.inc}

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

// ************************************************************************  //
// LIBID: {32D9C568-7815-45BD-A4A1-9479EF48F241}
// LCID: 0
// Helpfile:
// HelpString: AdxDesign Library
// DepndLst:
//   (1) v2.0 stdole, (D:\WINDOWS\system32\stdole2.tlb)
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
{$WRITEABLECONST ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AdxVCLDesignMajorVersion = 1;
  AdxVCLDesignMinorVersion = 0;

  LIBID_AdxVCLDesign: TGUID = '{32D9C568-7815-45BD-A4A1-9479EF48F241}';

  IID_IAdxRibbon: TGUID = '{34F2ECCD-B871-4ACD-BF0C-137A3352A51E}';
  DIID_IAdxDesignEvents: TGUID = '{C788188B-F79B-4BCE-8384-974B3CD0A8A6}';
  IID_IAdxControlsRegion: TGUID = '{80714718-E5FF-4D48-AB8A-F4A744E3761C}';
  CLASS_AdxControlsRegion: TGUID = '{95E771FE-34F1-4051-BA57-55170C2FEA01}';
  IID_IAdxCommandBar: TGUID = '{7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}';
  CLASS_AdxCommandBar: TGUID = '{16F1CF37-E725-40EF-9C7F-5EDA04AB767B}';
  IID_IAdxContextMenu: TGUID = '{C893C869-85C2-4463-878D-8A9D1D6AD12D}';
  CLASS_AdxContextMenu: TGUID = '{34CAFE3A-B3E5-45E9-9021-A1153F8B2CFE}';
  CLASS_AdxRibbon: TGUID = '{30A92627-5F98-4DC4-8BA2-22C3B45E94FA}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum AdxControlType
type
  AdxControlType = TOleEnum;
const
  tc_Tab = $00000001;
  tc_Group = $00000004;
  tc_Box = $00000005;
  tc_Button = $00000007;
  tc_SplitButton = $00000008;
  tc_Label = $00000009;
  tc_CheckBox = $0000000A;
  tc_EditBox = $0000000B;
  tc_ComboBox = $0000000C;
  tc_DropDown = $0000000D;
  tc_Galery = $0000000E;
  tc_Menu = $0000000F;
  tc_Separator = $00000010;
  tc_MenuSeparator = $00000011;
  tc_DialogBox = $00000012;
  tc_ButtonGroup = $00000006;
  tc_Item = $00000013;
  tc_Items = $00000014;
  tc_SplitMenu = $00000015;
  tc_Control = $00000016;
  tc_MainMenu = $00000017;

// Constants for enum AdxControlPropertyType
type
  AdxControlPropertyType = TOleEnum;
const
  tp_Caption = $00000000;
  tp_Description = $00000001;
  tp_Enabled = $00000002;
  tp_ToggleButton = $00000003;
  tp_Pressed = $00000004;
  tp_Glyph = $00000005;
  tp_ID = $00000006;
  tp_ScreenTip = $00000007;
  tp_SuperTip = $00000008;
  tp_KeyTip = $00000009;
  tp_Size = $0000000A;
  tp_Title = $0000000B;
  tp_ShowCaption = $0000000C;
  tp_SizeString = $0000000D;
  tp_MaxLength = $0000000E;
  tp_Text = $0000000F;
  tp_Rows = $00000010;
  tp_Columns = $00000011;
  tp_SelectedItemID = $00000012;
  tp_SelectedItemIndex = $00000013;
  tp_Items = $00000014;
  tp_Visible = $00000015;
  tp_BoxStyle = $00000016;
  tp_WordWrap = $00000017;
  tp_Style = $00000018;
  tp_ToolTip = $00000019;
  tp_BeginGroup = $0000001A;
  tp_Width = $0000001B;
  tp_Height = $0000001C;
  tp_DropDownLines = $0000001D;
  tp_DropDownWidth = $0000001E;
  tp_ItemWidth = $0000001F;
  tp_ItemHeight = $00000020;
  tp_ShowItemCaption = $00000021;
  tp_TransparentColor = $00000022;

// Constants for enum AdxDockingStyle
type
  AdxDockingStyle = TOleEnum;
const
  ds_None = $00000000;
  ds_Left = $00000001;
  ds_Top = $00000002;
  ds_Right = $00000003;
  ds_Bottom = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IAdxRibbon = interface;
  IAdxRibbonDisp = dispinterface;
  IAdxDesignEvents = dispinterface;
  IAdxControlsRegion = interface;
  IAdxControlsRegionDisp = dispinterface;
  IAdxCommandBar = interface;
  IAdxCommandBarDisp = dispinterface;
  IAdxContextMenu = interface;
  IAdxContextMenuDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  AdxControlsRegion = IAdxControlsRegion;
  AdxCommandBar = IAdxCommandBar;
  AdxContextMenu = IAdxContextMenu;
  AdxRibbon = IAdxRibbon;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  ADXCreateParams = packed record
    WndParent: Integer;
    DockStyle: AdxDockingStyle;
    AreaSize: Integer;
  end;


// *********************************************************************//
// Interface: IAdxRibbon
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34F2ECCD-B871-4ACD-BF0C-137A3352A51E}
// *********************************************************************//
  IAdxRibbon = interface(IDispatch)
    ['{34F2ECCD-B871-4ACD-BF0C-137A3352A51E}']
    function CreateRibbon(HWNDparent: Integer): HResult; safecall;
    function DestroyRibbon: HResult; safecall;
    function Get_Tabs: IAdxControlsRegion; safecall;
    function Get_AppMenu: IAdxControlsRegion; safecall;
    function Get_QAT: IAdxControlsRegion; safecall;
    property Tabs: IAdxControlsRegion read Get_Tabs;
    property AppMenu: IAdxControlsRegion read Get_AppMenu;
    property QAT: IAdxControlsRegion read Get_QAT;
  end;

// *********************************************************************//
// DispIntf:  IAdxRibbonDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {34F2ECCD-B871-4ACD-BF0C-137A3352A51E}
// *********************************************************************//
  IAdxRibbonDisp = dispinterface
    ['{34F2ECCD-B871-4ACD-BF0C-137A3352A51E}']
    function CreateRibbon(HWNDparent: Integer): HResult; dispid 201;
    function DestroyRibbon: HResult; dispid 202;
    property Tabs: IAdxControlsRegion readonly dispid 203;
    property AppMenu: IAdxControlsRegion readonly dispid 204;
    property QAT: IAdxControlsRegion readonly dispid 205;
  end;

// *********************************************************************//
// DispIntf:  IAdxDesignEvents
// Flags:     (4096) Dispatchable
// GUID:      {C788188B-F79B-4BCE-8384-974B3CD0A8A6}
// *********************************************************************//
  IAdxDesignEvents = dispinterface
    ['{C788188B-F79B-4BCE-8384-974B3CD0A8A6}']
    procedure OnBarResize(Width: Integer; Height: Integer); dispid 201;
    procedure OnControlSelect(const ControlID: WideString); dispid 202;
  end;

// *********************************************************************//
// Interface: IAdxControlsRegion
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {80714718-E5FF-4D48-AB8A-F4A744E3761C}
// *********************************************************************//
  IAdxControlsRegion = interface(IDispatch)
    ['{80714718-E5FF-4D48-AB8A-F4A744E3761C}']
    function AddControl(TypeControl: AdxControlType; const ParentID: WideString; 
                        const ControlID: WideString; const Caption: WideString): WordBool; safecall;
    function DeleteControl(const ControlID: WideString): WordBool; safecall;
    function SetParent(const NewParentID: WideString; const ControlID: WideString; Index: Integer): WordBool; safecall;
    function UpdateProp(const ControlID: WideString; PropID: AdxControlPropertyType; 
                        Value: OleVariant): WordBool; safecall;
    procedure BeginUpdate(const ControlID: WideString); safecall;
    procedure EndUpdate(const ControlID: WideString); safecall;
    function UpdatePicture(const ControlID: WideString; PropID: AdxControlPropertyType; 
                           const Value: IPicture): WordBool; safecall;
    procedure SelectControl(const ControlID: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IAdxControlsRegionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {80714718-E5FF-4D48-AB8A-F4A744E3761C}
// *********************************************************************//
  IAdxControlsRegionDisp = dispinterface
    ['{80714718-E5FF-4D48-AB8A-F4A744E3761C}']
    function AddControl(TypeControl: AdxControlType; const ParentID: WideString; 
                        const ControlID: WideString; const Caption: WideString): WordBool; dispid 201;
    function DeleteControl(const ControlID: WideString): WordBool; dispid 202;
    function SetParent(const NewParentID: WideString; const ControlID: WideString; Index: Integer): WordBool; dispid 203;
    function UpdateProp(const ControlID: WideString; PropID: AdxControlPropertyType; 
                        Value: OleVariant): WordBool; dispid 204;
    procedure BeginUpdate(const ControlID: WideString); dispid 205;
    procedure EndUpdate(const ControlID: WideString); dispid 206;
    function UpdatePicture(const ControlID: WideString; PropID: AdxControlPropertyType; 
                           const Value: IPicture): WordBool; dispid 207;
    procedure SelectControl(const ControlID: WideString); dispid 208;
  end;

// *********************************************************************//
// Interface: IAdxCommandBar
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}
// *********************************************************************//
  IAdxCommandBar = interface(IDispatch)
    ['{7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}']
    function CreateCommandBar(HWNDparent: Integer): HResult; safecall;
    function DestroyCommandBar: HResult; safecall;
    function Get_ToolBar: IAdxControlsRegion; safecall;
    function CreateCommandbarEx(Params: ADXCreateParams): HResult; safecall;
    property ToolBar: IAdxControlsRegion read Get_ToolBar;
  end;

// *********************************************************************//
// DispIntf:  IAdxCommandBarDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}
// *********************************************************************//
  IAdxCommandBarDisp = dispinterface
    ['{7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}']
    function CreateCommandBar(HWNDparent: Integer): HResult; dispid 301;
    function DestroyCommandBar: HResult; dispid 302;
    property ToolBar: IAdxControlsRegion readonly dispid 201;
    function CreateCommandbarEx(Params: {??ADXCreateParams}OleVariant): HResult; dispid 203;
  end;

// *********************************************************************//
// Interface: IAdxContextMenu
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C893C869-85C2-4463-878D-8A9D1D6AD12D}
// *********************************************************************//
  IAdxContextMenu = interface(IDispatch)
    ['{C893C869-85C2-4463-878D-8A9D1D6AD12D}']
    function CreateMenu(HWNDparent: Integer): HResult; safecall;
    function DestroyMenu: HResult; safecall;
    function Get_Items: AdxControlsRegion; safecall;
    property Items: AdxControlsRegion read Get_Items;
  end;

// *********************************************************************//
// DispIntf:  IAdxContextMenuDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C893C869-85C2-4463-878D-8A9D1D6AD12D}
// *********************************************************************//
  IAdxContextMenuDisp = dispinterface
    ['{C893C869-85C2-4463-878D-8A9D1D6AD12D}']
    function CreateMenu(HWNDparent: Integer): HResult; dispid 201;
    function DestroyMenu: HResult; dispid 202;
    property Items: AdxControlsRegion readonly dispid 203;
  end;

// *********************************************************************//
// The Class CoAdxControlsRegion provides a Create and CreateRemote method to          
// create instances of the default interface IAdxControlsRegion exposed by              
// the CoClass AdxControlsRegion. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAdxControlsRegion = class
    class function Create: IAdxControlsRegion;
    class function CreateRemote(const MachineName: string): IAdxControlsRegion;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAdxControlsRegion
// Help String      : 
// Default Interface: IAdxControlsRegion
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAdxControlsRegionProperties= class;
{$ENDIF}
  TAdxControlsRegion = class(TOleServer)
  private
    FIntf:        IAdxControlsRegion;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAdxControlsRegionProperties;
    function      GetServerProperties: TAdxControlsRegionProperties;
{$ENDIF}
    function      GetDefaultInterface: IAdxControlsRegion;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAdxControlsRegion);
    procedure Disconnect; override;
    function AddControl(TypeControl: AdxControlType; const ParentID: WideString; 
                        const ControlID: WideString; const Caption: WideString): WordBool;
    function DeleteControl(const ControlID: WideString): WordBool;
    function SetParent(const NewParentID: WideString; const ControlID: WideString; Index: Integer): WordBool;
    function UpdateProp(const ControlID: WideString; PropID: AdxControlPropertyType; 
                        Value: OleVariant): WordBool;
    procedure BeginUpdate(const ControlID: WideString);
    procedure EndUpdate(const ControlID: WideString);
    function UpdatePicture(const ControlID: WideString; PropID: AdxControlPropertyType; 
                           const Value: IPicture): WordBool;
    procedure SelectControl(const ControlID: WideString);
    property DefaultInterface: IAdxControlsRegion read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAdxControlsRegionProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAdxControlsRegion
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAdxControlsRegionProperties = class(TPersistent)
  private
    FServer:    TAdxControlsRegion;
    function    GetDefaultInterface: IAdxControlsRegion;
    constructor Create(AServer: TAdxControlsRegion);
  protected
  public
    property DefaultInterface: IAdxControlsRegion read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAdxCommandBar provides a Create and CreateRemote method to          
// create instances of the default interface IAdxCommandBar exposed by              
// the CoClass AdxCommandBar. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAdxCommandBar = class
    class function Create: IAdxCommandBar;
    class function CreateRemote(const MachineName: string): IAdxCommandBar;
  end;

  TAdxCommandBarOnBarResize = procedure(ASender: TObject; Width: Integer; Height: Integer) of object;
  TAdxCommandBarOnControlSelect = procedure(ASender: TObject; const ControlID: WideString) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAdxCommandBar
// Help String      : 
// Default Interface: IAdxCommandBar
// Def. Intf. DISP? : No
// Event   Interface: IAdxDesignEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAdxCommandBarProperties= class;
{$ENDIF}
  TAdxCommandBar = class(TOleServer)
  private
    FOnBarResize: TAdxCommandBarOnBarResize;
    FOnControlSelect: TAdxCommandBarOnControlSelect;
    FIntf:        IAdxCommandBar;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAdxCommandBarProperties;
    function      GetServerProperties: TAdxCommandBarProperties;
{$ENDIF}
    function      GetDefaultInterface: IAdxCommandBar;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_ToolBar: IAdxControlsRegion;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAdxCommandBar);
    procedure Disconnect; override;
    function CreateCommandBar(HWNDparent: Integer): HResult;
    function DestroyCommandBar: HResult;
    function CreateCommandbarEx(Params: ADXCreateParams): HResult;
    property DefaultInterface: IAdxCommandBar read GetDefaultInterface;
    property ToolBar: IAdxControlsRegion read Get_ToolBar;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAdxCommandBarProperties read GetServerProperties;
{$ENDIF}
    property OnBarResize: TAdxCommandBarOnBarResize read FOnBarResize write FOnBarResize;
    property OnControlSelect: TAdxCommandBarOnControlSelect read FOnControlSelect write FOnControlSelect;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAdxCommandBar
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAdxCommandBarProperties = class(TPersistent)
  private
    FServer:    TAdxCommandBar;
    function    GetDefaultInterface: IAdxCommandBar;
    constructor Create(AServer: TAdxCommandBar);
  protected
    function Get_ToolBar: IAdxControlsRegion;
  public
    property DefaultInterface: IAdxCommandBar read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAdxContextMenu provides a Create and CreateRemote method to          
// create instances of the default interface IAdxContextMenu exposed by              
// the CoClass AdxContextMenu. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAdxContextMenu = class
    class function Create: IAdxContextMenu;
    class function CreateRemote(const MachineName: string): IAdxContextMenu;
  end;

  TAdxContextMenuOnBarResize = procedure(ASender: TObject; Width: Integer; Height: Integer) of object;
  TAdxContextMenuOnControlSelect = procedure(ASender: TObject; const ControlID: WideString) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAdxContextMenu
// Help String      : 
// Default Interface: IAdxContextMenu
// Def. Intf. DISP? : No
// Event   Interface: IAdxDesignEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAdxContextMenuProperties= class;
{$ENDIF}
  TAdxContextMenu = class(TOleServer)
  private
    FOnBarResize: TAdxContextMenuOnBarResize;
    FOnControlSelect: TAdxContextMenuOnControlSelect;
    FIntf:        IAdxContextMenu;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAdxContextMenuProperties;
    function      GetServerProperties: TAdxContextMenuProperties;
{$ENDIF}
    function      GetDefaultInterface: IAdxContextMenu;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Items: AdxControlsRegion;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAdxContextMenu);
    procedure Disconnect; override;
    function CreateMenu(HWNDparent: Integer): HResult;
    function DestroyMenu: HResult;
    property DefaultInterface: IAdxContextMenu read GetDefaultInterface;
    property Items: AdxControlsRegion read Get_Items;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAdxContextMenuProperties read GetServerProperties;
{$ENDIF}
    property OnBarResize: TAdxContextMenuOnBarResize read FOnBarResize write FOnBarResize;
    property OnControlSelect: TAdxContextMenuOnControlSelect read FOnControlSelect write FOnControlSelect;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAdxContextMenu
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAdxContextMenuProperties = class(TPersistent)
  private
    FServer:    TAdxContextMenu;
    function    GetDefaultInterface: IAdxContextMenu;
    constructor Create(AServer: TAdxContextMenu);
  protected
    function Get_Items: AdxControlsRegion;
  public
    property DefaultInterface: IAdxContextMenu read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoAdxRibbon provides a Create and CreateRemote method to          
// create instances of the default interface IAdxRibbon exposed by              
// the CoClass AdxRibbon. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAdxRibbon = class
    class function Create: IAdxRibbon;
    class function CreateRemote(const MachineName: string): IAdxRibbon;
  end;

  TAdxRibbonOnBarResize = procedure(ASender: TObject; Width: Integer; Height: Integer) of object;
  TAdxRibbonOnControlSelect = procedure(ASender: TObject; const ControlID: WideString) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TAdxRibbon
// Help String      : AdxRibbon Object
// Default Interface: IAdxRibbon
// Def. Intf. DISP? : No
// Event   Interface: IAdxDesignEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TAdxRibbonProperties= class;
{$ENDIF}
  TAdxRibbon = class(TOleServer)
  private
    FOnBarResize: TAdxRibbonOnBarResize;
    FOnControlSelect: TAdxRibbonOnControlSelect;
    FIntf:        IAdxRibbon;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TAdxRibbonProperties;
    function      GetServerProperties: TAdxRibbonProperties;
{$ENDIF}
    function      GetDefaultInterface: IAdxRibbon;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Tabs: IAdxControlsRegion;
    function Get_AppMenu: IAdxControlsRegion;
    function Get_QAT: IAdxControlsRegion;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IAdxRibbon);
    procedure Disconnect; override;
    function CreateRibbon(HWNDparent: Integer): HResult;
    function DestroyRibbon: HResult;
    property DefaultInterface: IAdxRibbon read GetDefaultInterface;
    property Tabs: IAdxControlsRegion read Get_Tabs;
    property AppMenu: IAdxControlsRegion read Get_AppMenu;
    property QAT: IAdxControlsRegion read Get_QAT;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TAdxRibbonProperties read GetServerProperties;
{$ENDIF}
    property OnBarResize: TAdxRibbonOnBarResize read FOnBarResize write FOnBarResize;
    property OnControlSelect: TAdxRibbonOnControlSelect read FOnControlSelect write FOnControlSelect;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TAdxRibbon
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TAdxRibbonProperties = class(TPersistent)
  private
    FServer:    TAdxRibbon;
    function    GetDefaultInterface: IAdxRibbon;
    constructor Create(AServer: TAdxRibbon);
  protected
    function Get_Tabs: IAdxControlsRegion;
    function Get_AppMenu: IAdxControlsRegion;
    function Get_QAT: IAdxControlsRegion;
  public
    property DefaultInterface: IAdxRibbon read GetDefaultInterface;
  published
  end;
{$ENDIF}

implementation

uses ComObj;

class function CoAdxControlsRegion.Create: IAdxControlsRegion;
begin
  Result := CreateComObject(CLASS_AdxControlsRegion) as IAdxControlsRegion;
end;

class function CoAdxControlsRegion.CreateRemote(const MachineName: string): IAdxControlsRegion;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AdxControlsRegion) as IAdxControlsRegion;
end;

procedure TAdxControlsRegion.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{95E771FE-34F1-4051-BA57-55170C2FEA01}';
    IntfIID:   '{80714718-E5FF-4D48-AB8A-F4A744E3761C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAdxControlsRegion.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IAdxControlsRegion;
  end;
end;

procedure TAdxControlsRegion.ConnectTo(svrIntf: IAdxControlsRegion);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TAdxControlsRegion.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TAdxControlsRegion.GetDefaultInterface: IAdxControlsRegion;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAdxControlsRegion.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAdxControlsRegionProperties.Create(Self);
{$ENDIF}
end;

destructor TAdxControlsRegion.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAdxControlsRegion.GetServerProperties: TAdxControlsRegionProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TAdxControlsRegion.AddControl(TypeControl: AdxControlType; const ParentID: WideString; 
                                       const ControlID: WideString; const Caption: WideString): WordBool;
begin
  Result := DefaultInterface.AddControl(TypeControl, ParentID, ControlID, Caption);
end;

function TAdxControlsRegion.DeleteControl(const ControlID: WideString): WordBool;
begin
  Result := DefaultInterface.DeleteControl(ControlID);
end;

function TAdxControlsRegion.SetParent(const NewParentID: WideString; const ControlID: WideString; 
                                      Index: Integer): WordBool;
begin
  Result := DefaultInterface.SetParent(NewParentID, ControlID, Index);
end;

function TAdxControlsRegion.UpdateProp(const ControlID: WideString; PropID: AdxControlPropertyType; 
                                       Value: OleVariant): WordBool;
begin
  Result := DefaultInterface.UpdateProp(ControlID, PropID, Value);
end;

procedure TAdxControlsRegion.BeginUpdate(const ControlID: WideString);
begin
  DefaultInterface.BeginUpdate(ControlID);
end;

procedure TAdxControlsRegion.EndUpdate(const ControlID: WideString);
begin
  DefaultInterface.EndUpdate(ControlID);
end;

function TAdxControlsRegion.UpdatePicture(const ControlID: WideString; 
                                          PropID: AdxControlPropertyType; const Value: IPicture): WordBool;
begin
  Result := DefaultInterface.UpdatePicture(ControlID, PropID, Value);
end;

procedure TAdxControlsRegion.SelectControl(const ControlID: WideString);
begin
  DefaultInterface.SelectControl(ControlID);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAdxControlsRegionProperties.Create(AServer: TAdxControlsRegion);
begin
  inherited Create;
  FServer := AServer;
end;

function TAdxControlsRegionProperties.GetDefaultInterface: IAdxControlsRegion;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoAdxCommandBar.Create: IAdxCommandBar;
begin
  Result := CreateComObject(CLASS_AdxCommandBar) as IAdxCommandBar;
end;

class function CoAdxCommandBar.CreateRemote(const MachineName: string): IAdxCommandBar;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AdxCommandBar) as IAdxCommandBar;
end;

procedure TAdxCommandBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{16F1CF37-E725-40EF-9C7F-5EDA04AB767B}';
    IntfIID:   '{7D1110A5-E98D-4BDA-8C92-BDD43ACD573E}';
    EventIID:  '{C788188B-F79B-4BCE-8384-974B3CD0A8A6}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAdxCommandBar.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IAdxCommandBar;
  end;
end;

procedure TAdxCommandBar.ConnectTo(svrIntf: IAdxCommandBar);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TAdxCommandBar.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TAdxCommandBar.GetDefaultInterface: IAdxCommandBar;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAdxCommandBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAdxCommandBarProperties.Create(Self);
{$ENDIF}
end;

destructor TAdxCommandBar.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAdxCommandBar.GetServerProperties: TAdxCommandBarProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAdxCommandBar.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    201: if Assigned(FOnBarResize) then
         FOnBarResize(Self,
                      Params[0] {Integer},
                      Params[1] {Integer});
    202: if Assigned(FOnControlSelect) then
         FOnControlSelect(Self, Params[0] {const WideString});
  end; {case DispID}
end;

function TAdxCommandBar.Get_ToolBar: IAdxControlsRegion;
begin
    Result := DefaultInterface.ToolBar;
end;

function TAdxCommandBar.CreateCommandBar(HWNDparent: Integer): HResult;
begin
  Result := DefaultInterface.CreateCommandBar(HWNDparent);
end;

function TAdxCommandBar.DestroyCommandBar: HResult;
begin
  Result := DefaultInterface.DestroyCommandBar;
end;

function TAdxCommandBar.CreateCommandbarEx(Params: ADXCreateParams): HResult;
begin
  Result := DefaultInterface.CreateCommandbarEx(Params);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAdxCommandBarProperties.Create(AServer: TAdxCommandBar);
begin
  inherited Create;
  FServer := AServer;
end;

function TAdxCommandBarProperties.GetDefaultInterface: IAdxCommandBar;
begin
  Result := FServer.DefaultInterface;
end;

function TAdxCommandBarProperties.Get_ToolBar: IAdxControlsRegion;
begin
    Result := DefaultInterface.ToolBar;
end;

{$ENDIF}

class function CoAdxContextMenu.Create: IAdxContextMenu;
begin
  Result := CreateComObject(CLASS_AdxContextMenu) as IAdxContextMenu;
end;

class function CoAdxContextMenu.CreateRemote(const MachineName: string): IAdxContextMenu;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AdxContextMenu) as IAdxContextMenu;
end;

procedure TAdxContextMenu.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{34CAFE3A-B3E5-45E9-9021-A1153F8B2CFE}';
    IntfIID:   '{C893C869-85C2-4463-878D-8A9D1D6AD12D}';
    EventIID:  '{C788188B-F79B-4BCE-8384-974B3CD0A8A6}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAdxContextMenu.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IAdxContextMenu;
  end;
end;

procedure TAdxContextMenu.ConnectTo(svrIntf: IAdxContextMenu);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TAdxContextMenu.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TAdxContextMenu.GetDefaultInterface: IAdxContextMenu;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAdxContextMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAdxContextMenuProperties.Create(Self);
{$ENDIF}
end;

destructor TAdxContextMenu.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAdxContextMenu.GetServerProperties: TAdxContextMenuProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAdxContextMenu.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    201: if Assigned(FOnBarResize) then
         FOnBarResize(Self,
                      Params[0] {Integer},
                      Params[1] {Integer});
    202: if Assigned(FOnControlSelect) then
         FOnControlSelect(Self, Params[0] {const WideString});
  end; {case DispID}
end;

function TAdxContextMenu.Get_Items: AdxControlsRegion;
begin
    Result := DefaultInterface.Items;
end;

function TAdxContextMenu.CreateMenu(HWNDparent: Integer): HResult;
begin
  Result := DefaultInterface.CreateMenu(HWNDparent);
end;

function TAdxContextMenu.DestroyMenu: HResult;
begin
  Result := DefaultInterface.DestroyMenu;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAdxContextMenuProperties.Create(AServer: TAdxContextMenu);
begin
  inherited Create;
  FServer := AServer;
end;

function TAdxContextMenuProperties.GetDefaultInterface: IAdxContextMenu;
begin
  Result := FServer.DefaultInterface;
end;

function TAdxContextMenuProperties.Get_Items: AdxControlsRegion;
begin
    Result := DefaultInterface.Items;
end;

{$ENDIF}

class function CoAdxRibbon.Create: IAdxRibbon;
begin
  Result := CreateComObject(CLASS_AdxRibbon) as IAdxRibbon;
end;

class function CoAdxRibbon.CreateRemote(const MachineName: string): IAdxRibbon;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AdxRibbon) as IAdxRibbon;
end;

procedure TAdxRibbon.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{30A92627-5F98-4DC4-8BA2-22C3B45E94FA}';
    IntfIID:   '{34F2ECCD-B871-4ACD-BF0C-137A3352A51E}';
    EventIID:  '{C788188B-F79B-4BCE-8384-974B3CD0A8A6}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TAdxRibbon.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IAdxRibbon;
  end;
end;

procedure TAdxRibbon.ConnectTo(svrIntf: IAdxRibbon);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TAdxRibbon.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TAdxRibbon.GetDefaultInterface: IAdxRibbon;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TAdxRibbon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TAdxRibbonProperties.Create(Self);
{$ENDIF}
end;

destructor TAdxRibbon.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TAdxRibbon.GetServerProperties: TAdxRibbonProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TAdxRibbon.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    201: if Assigned(FOnBarResize) then
         FOnBarResize(Self,
                      Params[0] {Integer},
                      Params[1] {Integer});
    202: if Assigned(FOnControlSelect) then
         FOnControlSelect(Self, Params[0] {const WideString});
  end; {case DispID}
end;

function TAdxRibbon.Get_Tabs: IAdxControlsRegion;
begin
    Result := DefaultInterface.Tabs;
end;

function TAdxRibbon.Get_AppMenu: IAdxControlsRegion;
begin
    Result := DefaultInterface.AppMenu;
end;

function TAdxRibbon.Get_QAT: IAdxControlsRegion;
begin
    Result := DefaultInterface.QAT;
end;

function TAdxRibbon.CreateRibbon(HWNDparent: Integer): HResult;
begin
  Result := DefaultInterface.CreateRibbon(HWNDparent);
end;

function TAdxRibbon.DestroyRibbon: HResult;
begin
  Result := DefaultInterface.DestroyRibbon;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TAdxRibbonProperties.Create(AServer: TAdxRibbon);
begin
  inherited Create;
  FServer := AServer;
end;

function TAdxRibbonProperties.GetDefaultInterface: IAdxRibbon;
begin
  Result := FServer.DefaultInterface;
end;

function TAdxRibbonProperties.Get_Tabs: IAdxControlsRegion;
begin
    Result := DefaultInterface.Tabs;
end;

function TAdxRibbonProperties.Get_AppMenu: IAdxControlsRegion;
begin
    Result := DefaultInterface.AppMenu;
end;

function TAdxRibbonProperties.Get_QAT: IAdxControlsRegion;
begin
    Result := DefaultInterface.QAT;
end;

{$ENDIF}

end.
