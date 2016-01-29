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

unit adxAddIn;

{$I adxDefs.inc}

interface

uses Windows, SysUtils, Classes, Controls, ActiveX, ComObj, ImgList,
  Graphics, Registry, Forms, Menus, {$IFNDEF ADX_VCL5}Variants,{$ENDIF}
  {$IFDEF ADX_VCL5}OleServer,{$ENDIF} AxCtrls, Consts, ExtCtrls,
  adxAddInDesignerObjects, adxOffice, Office2000, Access2000, Outlook2000,
  Excel2000, Word2000, Project2000, MSPPt2000, FrontPage2000, Visio2002,
  MapPoint2002, Publisher2003, InfoPath2007, adxMSFormsControls, adxHostAppEvents;

type
  { Supported MS Office Applications }
  TadxOfficeHostApp = (ohaExcel, ohaWord, ohaOutlook, ohaPowerPoint, ohaAccess,
    ohaProject, ohaFrontPage, ohaMapPoint, ohaVisio, ohaPublisher, ohaInfoPath);
  TadxHostAppSet = set of TadxOfficeHostApp;

  { Supported CommandBarControls }
  TadxControlType = (adxButton, adxEdit, adxDropdown, adxComboBox, adxPopup,
    adxControl, adxAdvancedControl);

  { MS Office CommandBar wrapper }
  TadxMsoBarPosition = (adxMsoBarLeft, adxMsoBarTop, adxMsoBarRight,
    adxMsoBarBottom, adxMsoBarFloating, adxMsoBarPopup, adxMsoBarMenuBar);

  TadxMsoBarProtection = (adxMsoBarNoProtection, adxMsoBarNoCustomize,
    adxMsoBarNoResize, adxMsoBarNoMove, adxMsoBarNoChangeVisible,
    adxMsoBarNoChangeDock, adxMsoBarNoVerticalDock, adxMsoBarNoHorizontalDock);

  TadxMsoBarType = (adxMsoBarTypeNormal, adxMsoBarTypeMenuBar, adxMsoBarTypePopup);

  TadxCOMAddInModule = class;
  TadxCommandBarControl = class;
  TadxCommandBarControls = class;

  TadxCustomCommandBar = class(TComponent)
  private
    FOwner: TadxCOMAddInModule;
    FContext: WideString;
    {$IFDEF DELPHI_15_UP}
    FEnabled: boolean;
    FVisible: boolean;
    {$ELSE}
    FEnabled: WordBool;
    FVisible: WordBool;
    {$ENDIF}
    FHeight: SYSINT;
    FLeftPosition: SYSINT;
    FCommandBarName: WideString;
    FCommandBarNameLocal: WideString;
    FPosition: TadxMsoBarPosition;
    FRowIndex: SYSINT;
    FProtection: TadxMsoBarProtection;
    FTopPosition: SYSINT;
    FWidth: SYSINT;
    FAdaptiveMenu: WordBool;
    FTemporary: boolean;
    FControlTypes: array of Integer;
    FControls: TadxCommandBarControls;
    FInterface: CommandBar;
    FChanged: Longword;
    FSupportedApps: TadxHostAppSet;
    FUseForRibbon: boolean;
    function GetContext: WideString;
    procedure SetContext(const Value: WideString);
    {$IFDEF DELPHI_15_UP}
    function GetEnabled: boolean;
    procedure SetEnabled(const Value: boolean);
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    {$ELSE}
    function GetEnabled: WordBool;
    procedure SetEnabled(const Value: WordBool);
    function GetVisible: WordBool;
    procedure SetVisible(const Value: WordBool);
    {$ENDIF}
    function GetHeight: SYSINT;
    procedure SetHeight(const Value: SYSINT);
    function GetLeftPosition: SYSINT;
    procedure SetLeftPosition(const Value: SYSINT);
    function GetCommandBarName: WideString;
    procedure SetCommandBarName(const Value: WideString);
    function GetCommandBarNameLocal: WideString;
    procedure SetCommandBarNameLocal(const Value: WideString);
    function GetPosition: TadxMsoBarPosition;
    procedure SetPosition(const Value: TadxMsoBarPosition);
    function GetRowIndex: SYSINT;
    procedure SetRowIndex(const Value: SYSINT);
    function GetProtection: TadxMsoBarProtection;
    procedure SetProtection(const Value: TadxMsoBarProtection);
    function GetTopPosition: SYSINT;
    procedure SetTopPosition(const Value: SYSINT);
    function GetWidth: SYSINT;
    procedure SetWidth(const Value: SYSINT);
    function GetAdaptiveMenu: WordBool;
    procedure SetAdaptiveMenu(const Value: WordBool);
    procedure SetTemporary(const Value: boolean);
    function GetBuiltIn: WordBool;
    function GetIndex: SYSINT;
    function GetParent: IDispatch;
    function GetType: TadxMsoBarType;

    procedure SetControls(const Value: TadxCommandBarControls);
    procedure WriteControlsTypes(Stream: TStream);
    procedure ReadControlsTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
    procedure WriteChanged(Writer: TWriter);
    procedure ReadChanged(Reader: TReader);
    procedure Changed;

    procedure SetSupportedApps(const Value: TadxHostAppSet); virtual;
  public // GARANT // hack: made public, need for "Outlook Explorer Close"
    procedure Uninstall;
  protected
    procedure Delete;
    procedure SetProperties;
  public // GARANT // hack: made public, need for "Context Menu"
    procedure ReconnectControls;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // public
    property CommandBarNameLocal: WideString read GetCommandBarNameLocal write SetCommandBarNameLocal;
    property BuiltIn: WordBool read GetBuiltIn;
    property Context: WideString read GetContext write SetContext;
    property Index: SYSINT read GetIndex;
    property Parent: IDispatch read GetParent;
    property Type_: TadxMsoBarType read GetType;
    property AdaptiveMenu: WordBool read GetAdaptiveMenu write SetAdaptiveMenu;
    property Height: SYSINT read GetHeight write SetHeight;
    property Width: SYSINT read GetWidth write SetWidth;
    property DefaultInterface: CommandBar read FInterface;
    property Owner: TadxCOMAddInModule read FOwner;
    // published
    property SupportedApps: TadxHostAppSet read FSupportedApps write SetSupportedApps;
    property Controls: TadxCommandBarControls read FControls write SetControls stored False;
    {$IFDEF DELPHI_15_UP}
    property Enabled: boolean read GetEnabled write SetEnabled default True;
    property Visible: boolean read GetVisible write SetVisible default True;
    {$ELSE}
    property Enabled: WordBool read GetEnabled write SetEnabled default True;
    property Visible: WordBool read GetVisible write SetVisible default True;
    {$ENDIF}
    property CommandBarLeft: SYSINT read GetLeftPosition write SetLeftPosition default -1;
    property CommandBarName: WideString read GetCommandBarName write SetCommandBarName;
    property Position: TadxMsoBarPosition read GetPosition write SetPosition default adxMsoBarTop;
    property RowIndex: SYSINT read GetRowIndex write SetRowIndex default -1;
    property Protection: TadxMsoBarProtection read GetProtection write SetProtection default adxMsoBarNoProtection;
    property CommandBarTop: SYSINT read GetTopPosition write SetTopPosition default -1;
    property Temporary: boolean read FTemporary write SetTemporary default False;
    property UseForRibbon: boolean read FUseForRibbon write FUseForRibbon default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ControlByCaption(const ACaption: WideString): TadxCommandBarControl;
    function ControlByTag(const ATag: Integer): TadxCommandBarControl;
    function ControlByOfficeTag(const AOfficeTag: WideString): TadxCommandBarControl;
  end;

  TadxCommandBar = class(TadxCustomCommandBar)
  public
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;
  published
    property SupportedApps;
    property Controls stored False;
    property Enabled default True;
    property CommandBarLeft default -1;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex default -1;
    property Protection default adxMsoBarNoProtection;
    property CommandBarTop default -1;
    property Visible default True;
    property Temporary default False;
    property UseForRibbon default False;
  end;

  TadxMainMenu = class(TadxCustomCommandBar)
  private
    FSupportedApp: TadxOfficeHostApp;
    procedure SetSupportedApp(Value: TadxOfficeHostApp);
  public
    constructor Create(AOwner: TComponent); override;
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;

    property Enabled default True;
    property CommandBarLeft default -1;
    property Position default adxMsoBarTop;
    property RowIndex default -1;
    property Protection default adxMsoBarNoProtection;
    property CommandBarTop default -1;
    property Visible default True;
    property UseForRibbon default False;
  published
    property CommandBarName;
    property Controls stored False;
    property SupportedApp: TadxOfficeHostApp read FSupportedApp write SetSupportedApp;
    property Temporary default False;
  end;

  TadxCommandBarButton = class;
  TadxCommandBarEdit = class;
  TadxCommandBarDropDownList = class;
  TadxCommandBarComboBox = class;
  TadxCommandBarAdvancedControl = class;
  TadxCommandBarPopup = class;

  TadxOLItemTypeAction = (adxOLActionNone, adxOLActionShow, adxOLActionEnable);

  TadxOLItemType = (adxOLMailItem, adxOLAppointmentItem, adxOLContactItem,
    adxOLTaskItem, adxOLJournalItem, adxOLNoteItem, adxOLPostItem,
    adxOLDistributionListItem);
  TadxOLItemTypes = set of TadxOLItemType;

  TadxOLItemClass = (adxOLAppointment, adxOLMeetingRequest,
    adxOLMeetingCancellation, adxOLMeetingResponseNegative,
    adxOLMeetingResponsePositive, adxOLMeetingResponseTentative,
    adxOLContact, adxOLJournal, adxOLMail, adxOLPost, adxOLTask,
    adxOLTaskRequest, adxOLTaskRequestUpdate, adxOLTaskRequestAccept,
    adxOLTaskRequestDecline, adxOLDistributionList, adxOLReport);
  TadxOLItemClasses = set of TadxOLItemClass;

  TadxCommandBarControl = class(TCollectionItem)
  private
    FTag: Integer;
    FChanged: Longword;
    FInterface: CommandBarControl;
    {$IFDEF DELPHI_15_UP}
    FBeginGroup: boolean;
    FVisible: boolean;
    FEnabled: boolean;
    {$ELSE}
    FBeginGroup: WordBool;
    FVisible: WordBool;
    FEnabled: WordBool;
    {$ENDIF}
    FCaption: WideString;
    FDescriptionText: WideString;
    FHeight: SYSINT;
    FHelpContextID: SYSINT;
    FHelpFile: WideString;
    FOnAction: WideString;
    FParameter: WideString;
    FPriority: SYSINT;
    FOfficeTag: WideString;
    FTooltipText: WideString;
    FWidth: SYSINT;
    FCommandBar: TadxCustomCommandBar;
    FTemporary: boolean;
    FAfterID: Integer;
    FBefore: Integer;
    FBeforeID: Integer;
    FOfficeID: SYSINT;
    FItemTypeAction: TadxOLItemTypeAction;
    FExplorerItemTypes: TadxOLItemTypes;
    FInspectorItemTypes: TadxOLItemClasses;
    procedure SetInterface(const Value: CommandBarControl); overload; virtual;
    procedure SetAfterID(const Value: Integer);
    procedure SetBefore(const Value: Integer);
    procedure SetBeforeID(const Value: Integer);
    {$IFDEF DELPHI_15_UP}
    function GetBeginGroup: boolean;
    procedure SetBeginGroup(const Value: boolean);
    function GetEnabled: boolean;
    procedure SetEnabled(const Value: boolean);
    function GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    {$ELSE}
    function GetBeginGroup: WordBool;
    procedure SetBeginGroup(const Value: WordBool);
    function GetEnabled: WordBool;
    procedure SetEnabled(const Value: WordBool);
    function GetVisible: WordBool;
    procedure SetVisible(const Value: WordBool);
    {$ENDIF}
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetDescriptionText: WideString;
    procedure SetDescriptionText(const Value: WideString);
    function GetHeight: SYSINT;
    procedure SetHeight(const Value: SYSINT);
    function GetHelpContextID: SYSINT;
    procedure SetHelpContextID(const Value: SYSINT);
    function GetHelpFile: WideString;
    procedure SetHelpFile(const Value: WideString);
    function GetOnAction: WideString;
    procedure SetOnAction(const Value: WideString);
    function GetParameter: WideString;
    procedure SetParameter(const Value: WideString);
    function GetPriority: SYSINT;
    procedure SetPriority(const Value: SYSINT);
    function GetOfficeTag: WideString;
    procedure SetOfficeTag(const Value: WideString);
    function GetTooltipText: WideString;
    procedure SetTooltipText(const Value: WideString);
    function GetWidth: SYSINT;
    procedure SetWidth(const Value: SYSINT);
    function GetOfficeID: SYSINT;
    procedure SetOfficeID(const Value: SYSINT);
    function GetBuiltIn: WordBool;
    function GetOfficeIndex: SYSINT;
    function GetLeft: SYSINT;
    function GetOLEUsage: MsoControlOLEUsage;
    procedure SetOLEUsage(const Value: MsoControlOLEUsage);
    procedure SetTemporary(const Value: boolean);
    function GetParent: CommandBar;
    function GetTop: SYSINT;
    function GetType_: MsoControlType;
    function GetIsPriorityDropped: WordBool;
    function GetType: TadxControlType; virtual;
    function SetProperties: boolean; virtual;
    procedure ReadChanged(Reader: TReader);
    procedure WriteChanged(Writer: TWriter);
    procedure Changed;
    function GetAsButton: TadxCommandBarButton;
    function GetAsEdit: TadxCommandBarEdit;
    function GetAsDropDownList: TadxCommandBarDropDownList;
    function GetAsComboBox: TadxCommandBarComboBox;
    function GetAsPopup: TadxCommandBarPopup;
    function GetAsAdvancedControl: TadxCommandBarAdvancedControl;
    procedure DoAction; virtual; abstract;
    procedure Delete(Temporary: boolean); virtual;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetIndex(Value: Integer); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property AsButton: TadxCommandBarButton read GetAsButton;
    property AsEdit: TadxCommandBarEdit read GetAsEdit;
    property AsDropdownList: TadxCommandBarDropDownList read GetAsDropDownList;
    property AsComboBox: TadxCommandBarComboBox read GetAsComboBox;
    property AsPopup: TadxCommandBarPopup read GetAsPopup;
    property AsAdvancedControl: TadxCommandBarAdvancedControl read GetAsAdvancedControl;
    property BuiltIn: WordBool read GetBuiltIn;
    property OfficeIndex: SYSINT read GetOfficeIndex;
    property Left: SYSINT read GetLeft;
    property OLEUsage: MsoControlOLEUsage read GetOLEUsage write SetOLEUsage;
    property Parent: CommandBar read GetParent;
    property Top: SYSINT read GetTop;
    property Type_: MsoControlType read GetType_;
    property IsPriorityDropped: WordBool read GetIsPriorityDropped;
    property OnAction: WideString read GetOnAction write SetOnAction;
    property CommandBar: TadxCustomCommandBar read FCommandBar;
    property DefaultInterface: CommandBarControl read FInterface;
  published
    {$IFDEF DELPHI_15_UP}
    property BeginGroup: boolean read GetBeginGroup write SetBeginGroup default False;
    property Enabled: boolean read GetEnabled write SetEnabled default True;
    property Visible: boolean read GetVisible write SetVisible default True;
    {$ELSE}
    property BeginGroup: WordBool read GetBeginGroup write SetBeginGroup default False;
    property Enabled: WordBool read GetEnabled write SetEnabled default True;
    property Visible: WordBool read GetVisible write SetVisible default True;
    {$ENDIF}
    property Caption: WideString read GetCaption write SetCaption;
    property DescriptionText: WideString read GetDescriptionText write SetDescriptionText;
    property Height: SYSINT read GetHeight write SetHeight default 0;
    property HelpContextID: SYSINT read GetHelpContextID write SetHelpContextID default 0;
    property HelpFile: WideString read GetHelpFile write SetHelpFile;
    property Parameter: WideString read GetParameter write SetParameter;
    property Priority: SYSINT read GetPriority write SetPriority default 0;
    property OfficeID: SYSINT read GetOfficeID write SetOfficeID default 1;
    property OfficeTag: WideString read GetOfficeTag write SetOfficeTag;
    property olExplorerItemTypes: TadxOLItemTypes read FExplorerItemTypes write FExplorerItemTypes;
    property olInspectorItemTypes: TadxOLItemClasses read FInspectorItemTypes write FInspectorItemTypes;
    property olItemTypeAction: TadxOLItemTypeAction read FItemTypeAction write FItemTypeAction default adxOLActionNone;
    property TooltipText: WideString read GetTooltipText write SetTooltipText;
    property Width: SYSINT read GetWidth write SetWidth default 0;
    property AfterID: Integer read FAfterID write SetAfterID default 0;
    property Before: Integer read FBefore write SetBefore default 0;
    property BeforeID: Integer read FBeforeID write SetBeforeID default 0;
    property Temporary: boolean read FTemporary write SetTemporary default False;
    property Tag: Integer read FTag write FTag default 0;
  end;

  TadxCommandBarControls = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxCommandBarControl;
    procedure SetItem(Index: Integer; Value: TadxCommandBarControl);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    procedure Assign(Source: TPersistent); override;
    function Add(AType: TadxControlType): TadxCommandBarControl; overload;
    function Add(AType: TadxControlType; const ATag: WideString;
      ABefore: Integer; ATemporary: boolean): TadxCommandBarControl; overload;
    procedure DeleteControl(Index: Integer; Temporary: boolean);
    function ItemByTag(const ATag: Integer): TadxCommandBarControl;
    property Items[Index: Integer]: TadxCommandBarControl read GetItem write SetItem; default;
  end;

  TadxAbstractControlAdapter = class(TObject)
  private
    FOwner: TadxCommandBarAdvancedControl;
  protected
    // Returns the active instance of TadxCommandBarAdvancedControl.Control
    function GetActiveInstance: TControl; virtual; abstract;
    function CreateInstance: CommandBarControl; virtual; abstract;
    // Outlook Event Handlers
    procedure DoNewExplorer(AIntf: IDispatch); virtual; abstract;
    procedure DoExplorerActivate(AIntf: IDispatch); virtual; abstract;
    procedure DoExplorerClose(AIntf: IDispatch); virtual; abstract;
    procedure DoNewInspector(AIntf: IDispatch); virtual; abstract;
    procedure DoInspectorActivate(AIntf: IDispatch); virtual; abstract;
    procedure DoInspectorClose(AIntf: IDispatch); virtual; abstract;

    property Owner: TadxCommandBarAdvancedControl read FOwner;
  public
    constructor Create(AOwner: TadxCommandBarAdvancedControl); virtual;
  end;

  TadxControlAdapterClass = class of TadxAbstractControlAdapter;

  TadxCommandBarAdvancedControl = class(TadxCommandBarControl)
  private
    FControlAdapter: TadxAbstractControlAdapter;
    FControl: TControl;
    function GetBuiltIn: WordBool;
    function GetOLEUsage: MsoControlOLEUsage;
    procedure SetOLEUsage(const Value: MsoControlOLEUsage);
    function GetType_: MsoControlType;
    function GetOnAction: WideString;
    procedure SetOnAction(const Value: WideString);
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHelpContextID: SYSINT;
    procedure SetHelpContextID(const Value: SYSINT);
    function GetHelpFile: WideString;
    procedure SetHelpFile(const Value: WideString);
    function GetOfficeID: SYSINT;
    procedure SetOfficeID(const Value: SYSINT);
    function GetTooltipText: WideString;
    procedure SetTooltipText(const Value: WideString);
    function GetActiveInstance: TControl;
    procedure SetControl(const Value: TControl);
    function GetType: TadxControlType; override;
    procedure Delete(Temporary: boolean); override;
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ActiveInstance: TControl read GetActiveInstance;
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn: WordBool read GetBuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage: MsoControlOLEUsage read GetOLEUsage write SetOLEUsage;
    property Parent;
    property Top;
    property Type_: MsoControlType read GetType_;
    property IsPriorityDropped;
    property OnAction: WideString read GetOnAction write SetOnAction;
    property CommandBar;
    property ControlAdapter: TadxAbstractControlAdapter read FControlAdapter;
  published
    property BeginGroup;
    property Caption: WideString read GetCaption write SetCaption;
    property Control: TControl read FControl write SetControl;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID: SYSINT read GetHelpContextID write SetHelpContextID default 0;
    property HelpFile: WideString read GetHelpFile write SetHelpFile;
    property Parameter;
    property Priority;
    property OfficeID: SYSINT read GetOfficeID write SetOfficeID default 1;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText: WideString read GetTooltipText write SetTooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
  end;

  TadxMsoButtonState = (adxMsoButtonUp, adxMsoButtonDown, adxMsoButtonMixed);

  TadxMsoButtonStyle = (adxMsoButtonAutomatic, adxMsoButtonIcon,
    adxMsoButtonCaption, adxMsoButtonIconAndCaption,
    adxMsoButtonIconAndWrapCaption, adxMsoButtonIconAndCaptionBelow,
    adxMsoButtonWrapCaption, adxMsoButtonIconAndWrapCaptionBelow);

  TadxMsoCommandBarButtonHyperlinkType = (adxMsoCommandBarButtonHyperlinkNone,
    adxMsoCommandBarButtonHyperlinkOpen, adxMsoCommandBarButtonHyperlinkInsertPicture);

  TadxCommandBarButton = class(TadxCommandBarControl)
  private
    FEventSink: Pointer;
    FBuiltInFace: WordBool;
    FFaceID: SYSINT;
    FShortcutText: WideString;
    FState: TadxMsoButtonState;
    FStyle: TadxMsoButtonStyle;
    FHyperlinkType: TadxMsoCommandBarButtonHyperlinkType;
    FInterface: CommandBarButton;
    FGlyph: TBitmap;
    FGlyphTransparentColor: TColor;
    FDisableStandardAction: boolean;
    FOnClick: TNotifyEvent;
    FButtonInUse: boolean;
    procedure SetInterface(const Value: CommandBarButton); reintroduce; overload;
    procedure SetGlyph(const Value: TBitmap);
    function GetBuiltInFace: WordBool;
    procedure SetBuiltInFace(const Value: WordBool);
    function GetFaceID: SYSINT;
    procedure SetFaceID(const Value: SYSINT);
    function GetShortcutText: WideString;
    procedure SetShortcutText(const Value: WideString);
    function GetState: TadxMsoButtonState;
    procedure SetState(const Value: TadxMsoButtonState);
    function GetStyle: TadxMsoButtonStyle;
    procedure SetStyle(const Value: TadxMsoButtonStyle);
    function GetHyperlinkType: TadxMsoCommandBarButtonHyperlinkType;
    procedure SetHyperlinkType(const Value: TadxMsoCommandBarButtonHyperlinkType);
    function GetType: TadxControlType; override;
    function SetProperties: boolean; override;
    procedure DoAction; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property BuiltInFace: WordBool read GetBuiltInFace write SetBuiltInFace default True;
    property DefaultInterface: CommandBarButton read FInterface;
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage;
    property Parent;
    property Top;
    property Type_;
    property IsPriorityDropped;
    property OnAction;
    property CommandBar;
  published
    property DisableStandardAction: boolean read FDisableStandardAction write FDisableStandardAction default False; 
    property FaceID: SYSINT read GetFaceID write SetFaceID default 0;
    property ShortcutText: WideString read GetShortcutText write SetShortcutText;
    property State: TadxMsoButtonState read GetState write SetState default adxMsoButtonUp;
    property Style: TadxMsoButtonStyle read GetStyle write SetStyle default adxMsoButtonAutomatic;
    property HyperlinkType: TadxMsoCommandBarButtonHyperlinkType read GetHyperlinkType write SetHyperlinkType default adxMsoCommandBarButtonHyperlinkNone;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphTransparentColor: TColor read FGlyphTransparentColor write FGlyphTransparentColor default clDefault;
    property BeginGroup;
    property Caption;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID;
    property HelpFile;
    property Parameter;
    property Priority;
    property OfficeID;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TadxMsoComboStyle = (adxMsoComboNormal, adxMsoComboLabel);

  TadxCustomCommandBarComboBox = class(TadxCommandBarControl)
  private
    FEventSink: Pointer;
    FOnChange: TNotifyEvent;
    FItems: TStrings;
    FDropdownLines: SYSINT;
    FDropdownWidth: SYSINT;
    FListHeaderCount: SYSINT;
    FListIndex: SYSINT;
    FStyle: TadxMsoComboStyle;
    FText: WideString;
    FInterface: CommandBarComboBox;
    procedure SetInterface(const Value: CommandBarComboBox); reintroduce; overload;
    function GetDropdownLines: SYSINT;
    procedure SetDropdownLines(const Value: SYSINT);
    function GetDropdownWidth: SYSINT;
    procedure SetDropdownWidth(const Value: SYSINT);
    function GetList(Index: SYSINT): WideString;
    procedure SetList(Index: SYSINT; const Value: WideString);
    function GetListCount: SYSINT;
    function GetListHeaderCount: SYSINT;
    procedure SetListHeaderCount(const Value: SYSINT);
    function GetListIndex: SYSINT;
    procedure SetListIndex(const Value: SYSINT);
    function GetStyle: TadxMsoComboStyle;
    procedure SetStyle(const Value: TadxMsoComboStyle);
    function GetText: WideString;
    procedure SetText(const Value: WideString);
    procedure SetItems(const Value: TStrings);
    function SetProperties: boolean; override;
    procedure DoItemsChange(Sender: TObject);
    procedure DoAction; override;
  protected
    property DropdownLines: SYSINT read GetDropdownLines write SetDropdownLines default 0;
    property DropdownWidth: SYSINT read GetDropdownWidth write SetDropdownWidth default 0;
    property List[Index: SYSINT]: WideString read GetList write SetList;
    property ListCount: SYSINT read GetListCount;
    property ListHeaderCount: SYSINT read GetListHeaderCount write SetListHeaderCount default -1;
    property ListIndex: SYSINT read GetListIndex write SetListIndex default 0;
    property Items: TStrings read FItems write SetItems;
    property Style: TadxMsoComboStyle read GetStyle write SetStyle default adxMsoComboNormal;
    property Text: WideString read GetText write SetText;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;
    property DefaultInterface: CommandBarComboBox read FInterface;
  end;

  TadxCommandBarDropdownList = class(TadxCustomCommandBarComboBox)
  private
    function GetType: TadxControlType; override;
  public
    procedure Assign(Source: TPersistent); override;
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage;
    property Parent;
    property Top;
    property Type_;
    property IsPriorityDropped;
    property OnAction;
    property CommandBar;
    property List;
    property ListCount;
  published
    property BeginGroup;
    property Caption;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID;
    property HelpFile;
    property Parameter;
    property Priority;
    property OfficeID;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
    property DropdownLines;
    property DropdownWidth;
    property ListIndex;
    property ListHeaderCount;
    property Style;
    property Text;
    property Items;
    property OnChange;
  end;

  TadxCommandBarComboBox = class(TadxCustomCommandBarComboBox)
  private
    function GetType: TadxControlType; override;
  public
    procedure Assign(Source: TPersistent); override;
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage;
    property Parent;
    property Top;
    property Type_;
    property IsPriorityDropped;
    property OnAction;
    property CommandBar;
    property List;
    property ListCount;
  published
    property BeginGroup;
    property Caption;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID;
    property HelpFile;
    property Parameter;
    property Priority;
    property OfficeID;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
    property DropdownLines;
    property DropdownWidth;
    property ListHeaderCount;
    property ListIndex;
    property Style;
    property Text;
    property Items;
    property OnChange;
  end;

  TadxCommandBarEdit = class(TadxCustomCommandBarComboBox)
  private
    function GetType: TadxControlType; override;
  public
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage;
    property Parent;
    property Top;
    property Type_;
    property IsPriorityDropped;
    property OnAction;
    property CommandBar;
  published
    property BeginGroup;
    property Caption;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID;
    property HelpFile;
    property Parameter;
    property Priority;
    property OfficeID;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
    property Style;
    property Text;
    property OnChange;
  end;

  TadxCommandBarPopup = class(TadxCommandBarControl)
  private
    FControls: TadxCommandBarControls;
    FControlTypes: array of Integer;
    FInterface: CommandBarPopup;
    procedure SetInterface(const Value: CommandBarPopup); reintroduce; overload;
    procedure SetControls(const Value: TadxCommandBarControls);
    procedure WriteControlsTypes(Stream: TStream);
    procedure ReadControlsTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
    function GetType: TadxControlType; override;
    function SetProperties: boolean; override;
    procedure ReconnectControls;
    procedure Delete(Temporary: boolean); override;
    procedure DoAction; override;
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ControlByCaption(const ACaption: WideString): TadxCommandBarControl;
    function ControlByTag(const ATag: Integer): TadxCommandBarControl;
    function ControlByOfficeTag(const AOfficeTag: WideString): TadxCommandBarControl;
    property DefaultInterface: CommandBarPopup read FInterface;
    property AsButton;
    property AsEdit;
    property AsDropdownList;
    property AsComboBox;
    property AsPopup;
    property AsAdvancedControl;
    property BuiltIn;
    property OfficeIndex;
    property Left;
    property OLEUsage;
    property Parent;
    property Top;
    property Type_;
    property IsPriorityDropped;
    property OnAction;
    property CommandBar;
  published
    property BeginGroup;
    property Caption;
    property DescriptionText;
    property Enabled;
    property Height;
    property HelpContextID;
    property HelpFile;
    property Parameter;
    property Priority;
    property OfficeID;
    property OfficeTag;
    property olExplorerItemTypes;
    property olInspectorItemTypes;
    property olItemTypeAction;
    property TooltipText;
    property Visible;
    property Width;
    property AfterID;
    property Before;
    property BeforeID;
    property Temporary;
    property Tag;
    property Controls: TadxCommandBarControls read FControls write SetControls stored False;
  end;

  TadxOlExplorerCustomCommandBar = class(TadxCustomCommandBar)
  private
    FFolderName: WideString;
    FFolderNames: TStrings;
    FItemTypes: TadxOLItemTypes;
    procedure SetSupportedApps(const Value: TadxHostAppSet); override;
  protected
    // public
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;
    // published
    property FolderName: WideString read FFolderName write FFolderName;
    property FolderNames: TStrings read FFolderNames write FFolderNames;
    property ItemTypes: TadxOLItemTypes read FItemTypes write FItemTypes default [adxOLMailItem];
    property Controls;
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property Temporary default True;
    property UseForRibbon default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TadxOlExplorerCommandBar = class(TadxOlExplorerCustomCommandBar)
  public
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;
  published
    property FolderName;
    property FolderNames;
    property ItemTypes default [adxOLMailItem];
    property Controls;
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property Temporary default True;
    property UseForRibbon default True;
  end;

  TadxOlExplorerMainMenu = class(TadxOlExplorerCustomCommandBar)
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;

    property ItemTypes default [adxOLMailItem, adxOLAppointmentItem, adxOLContactItem,
      adxOLTaskItem, adxOLJournalItem, adxOLNoteItem, adxOLPostItem,
      adxOLDistributionListItem];
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property UseForRibbon default True;
  published
    property Controls;
    property Temporary default True;
  end;

  TadxOlInspectorCommandBar = class;
  TadxInspectorCommandBarBeforeAdd = procedure (CmdBar: TadxOLInspectorCommandBar;
    Inspector: Outlook2000._Inspector; var Cancel: boolean) of object;

  TadxOlInspectorCustomCommandBar = class(TadxCustomCommandBar)
  private
    FFolderName: WideString;
    FFolderNames: TStrings;
    FItemClasses: TadxOLItemClasses;
    FOnBeforeAdd: TadxInspectorCommandBarBeforeAdd;
    procedure SetSupportedApps(const Value: TadxHostAppSet); override;
  protected
    // public
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;
    // published
    property FolderName: WideString read FFolderName write FFolderName;
    property FolderNames: TStrings read FFolderNames write FFolderNames;
    property ItemTypes: TadxOLItemClasses read FItemClasses write FItemClasses default [adxOLMail];
    property Controls;
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property Temporary default True;
    property UseForRibbon default False;
    property OnBeforeAdd: TadxInspectorCommandBarBeforeAdd read FOnBeforeAdd write FOnBeforeAdd;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TadxOlInspectorCommandBar = class(TadxOlInspectorCustomCommandBar)
  public
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;
  published
    property FolderName;
    property FolderNames;
    property ItemTypes default [adxOLMail];
    property Controls;
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property Temporary default True;
    property UseForRibbon default False;
    property OnBeforeAdd;
  end;

  TadxOlInspectorMainMenu = class(TadxOlInspectorCustomCommandBar)
  public
    constructor Create(AOwner: TComponent); override;
    property CommandBarNameLocal;
    property BuiltIn;
    property Context;
    property Index;
    property Parent;
    property Type_;
    property AdaptiveMenu;
    property Height;
    property Width;
    property DefaultInterface;
    property Owner;

    property ItemTypes default [adxOLAppointment, adxOLMeetingRequest,
      adxOLMeetingCancellation, adxOLMeetingResponseNegative,
      adxOLMeetingResponsePositive, adxOLMeetingResponseTentative,
      adxOLContact, adxOLJournal, adxOLMail, adxOLPost, adxOLTask,
      adxOLTaskRequest, adxOLTaskRequestUpdate, adxOLTaskRequestAccept,
      adxOLTaskRequestDecline, adxOLDistributionList, adxOLReport];
    property Enabled;
    property CommandBarLeft;
    property CommandBarName;
    property Position default adxMsoBarTop;
    property RowIndex;
    property Protection;
    property SupportedApps default [ohaOutlook];
    property CommandBarTop;
    property Visible;
    property UseForRibbon default False;
  published
    property Controls;
    property Temporary default True;
  end;

  TadxContextMenu = class(TadxCustomCommandBar)
  private
    FSupportedApp: TadxOfficeHostApp;
    FOnBeforeAddControls: TNotifyEvent;
    procedure SetSupportedApp(Value: TadxOfficeHostApp);
    procedure DoAddControls();
  protected
  public
    constructor Create(AOwner: TComponent); override;
    property UseForRibbon;
  published
    property CommandBarName;
    property Controls;
    property SupportedApp: TadxOfficeHostApp read FSupportedApp write SetSupportedApp;
    property Temporary default True;
    property OnBeforeAddControls: TNotifyEvent read FOnBeforeAddControls write FOnBeforeAddControls;
  end;

  TadxBuiltInControlActionEx = procedure(Sender: TObject; var Cancel: boolean) of object;

  TadxBuiltInControl = class(TComponent)
  private
    FEventSink: Pointer;
    FBuiltInID: Integer;
    FOfficeTag: WideString;
    FCommandBar: TadxCustomCommandBar;
    FDisableStandardAction: boolean;
    FInterface: CommandBarControl;
    FOnAction: TNotifyEvent;
    FOnActionEx: TadxBuiltInControlActionEx;
    FOwner: TadxCOMAddInModule;
    FControlInvoked: CommandBarControl;
    function GetOfficeTag: WideString;
    procedure SetOfficeTag(const Value: WideString);
    procedure SetInterface(const Value: CommandBarControl);
    procedure DoAction(var Cancel: boolean);
    procedure Uninstall;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Owner: TadxCOMAddInModule read FOwner;
    property DefaultInterface: CommandBarControl read FInterface;
    property ControlInvoked: CommandBarControl read FControlInvoked write FControlInvoked;

  published
    property BuiltInID: Integer read FBuiltInID write FBuiltInID default 1;
    property OfficeTag: WideString read GetOfficeTag write SetOfficeTag;
    property CommandBar: TadxCustomCommandBar read FCommandBar write FCommandBar;
    property DisableStandardAction: boolean read FDisableStandardAction write FDisableStandardAction default False;
    property OnAction: TNotifyEvent read FOnAction write FOnAction;
    property OnActionEx: TadxBuiltInControlActionEx read FOnActionEx write FOnActionEx;
  end;

  TadxAddin = class;
  TadxFactory = class;

  TadxStartMode = (smFirstStart, smNormal, smUninstall);
  TadxOnError = procedure (const E: SysUtils.Exception; var Handled: boolean) of object;

  TadxNewExplorer = procedure(ASender: TObject; const Explorer: _Explorer) of object;
  TadxNewInspector = procedure(ASender: TObject; const Inspector: _Inspector) of object;
  TadxExplorerBeforeFolderSwitch = procedure(ASender: TObject; const NewFolder: IDispatch;
    var Cancel: WordBool) of object;
  TadxExplorerBeforeViewSwitch = procedure(ASender: TObject; NewView: OleVariant;
    var Cancel: WordBool) of object;
  TadxOnCallBack = procedure (const key: string; const i1, i2, i3: Integer;
    const s1, s2, s3: string) of object;

  IRibbonUI = interface(IDispatch)
    ['{000C03A7-0000-0000-C000-000000000046}']
    // Office 2007
    procedure Invalidate; safecall;
    procedure InvalidateControl(const ControlID: WideString); safecall;
    // Office 2010
    procedure InvalidateControlMso(const ControlID: WideString); safecall;
    procedure ActivateTab(const ControlID: WideString); safecall;
    procedure ActivateTabMso(const ControlID: WideString); safecall;
    procedure ActivateTabQ(const ControlID: WideString; const Namespace: WideString); safecall;
  end;

  IRibbonUIDisp = dispinterface
    ['{000C03A7-0000-0000-C000-000000000046}']
    // Office 2007
    procedure Invalidate; dispid 1;
    procedure InvalidateControl(const ControlID: WideString); dispid 2;
    // Office 2010
    procedure InvalidateControlMso(const ControlID: WideString); dispid 3;
    procedure ActivateTab(const ControlID: WideString); dispid 4;
    procedure ActivateTabMso(const ControlID: WideString); dispid 5;
    procedure ActivateTabQ(const ControlID: WideString; const Namespace: WideString); dispid 6;
  end;

  IRibbonExtensibility = interface(IDispatch)
    ['{000C0396-0000-0000-C000-000000000046}']
    function GetCustomUI(const RibbonID: WideString): WideString; safecall;
  end;

  IRibbonExtensibilityDisp = dispinterface
    ['{000C0396-0000-0000-C000-000000000046}']
    function GetCustomUI(const RibbonID: WideString): WideString; dispid 1;
  end;

  _CustomTaskPane = interface(IDispatch)
    ['{000C033B-0000-0000-C000-000000000046}']
    function Get_Title: WideString; safecall;
    function Get_Application: IDispatch; safecall;
    function Get_Window: IDispatch; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(prop: WordBool); safecall;
    function Get_ContentControl: IDispatch; safecall;
    function Get_Height: SYSINT; safecall;
    procedure Set_Height(prop: SYSINT); safecall;
    function Get_Width: SYSINT; safecall;
    procedure Set_Width(prop: SYSINT); safecall;
    function Get_DockPosition: MsoCTPDockPosition; safecall;
    procedure Set_DockPosition(prop: MsoCTPDockPosition); safecall;
    function Get_DockPositionRestrict: MsoCTPDockPositionRestrict; safecall;
    procedure Set_DockPositionRestrict(prop: MsoCTPDockPositionRestrict); safecall;
    procedure Delete; safecall;
    property Title: WideString read Get_Title;
    property Application: IDispatch read Get_Application;
    property Window: IDispatch read Get_Window;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property ContentControl: IDispatch read Get_ContentControl;
    property Height: SYSINT read Get_Height write Set_Height;
    property Width: SYSINT read Get_Width write Set_Width;
    property DockPosition: MsoCTPDockPosition read Get_DockPosition write Set_DockPosition;
    property DockPositionRestrict: MsoCTPDockPositionRestrict read Get_DockPositionRestrict write Set_DockPositionRestrict;
  end;

  _CustomTaskPaneDisp = dispinterface
    ['{000C033B-0000-0000-C000-000000000046}']
    property Title: WideString readonly dispid 0;
    property Application: IDispatch readonly dispid 1;
    property Window: IDispatch readonly dispid 2;
    property Visible: WordBool dispid 3;
    property ContentControl: IDispatch readonly dispid 4;
    property Height: SYSINT dispid 5;
    property Width: SYSINT dispid 6;
    property DockPosition: MsoCTPDockPosition dispid 7;
    property DockPositionRestrict: MsoCTPDockPositionRestrict dispid 8;
    procedure Delete; dispid 9;
  end;

  _CustomTaskPaneEvents = dispinterface
    ['{000C033C-0000-0000-C000-000000000046}']
    procedure VisibleStateChange(const CustomTaskPaneInst: _CustomTaskPane); dispid 1;
    procedure DockPositionStateChange(const CustomTaskPaneInst: _CustomTaskPane); dispid 2;
  end;

  ICTPFactory = interface(IDispatch)
    ['{000C033D-0000-0000-C000-000000000046}']
    function CreateCTP(const CTPAxID: WideString; const CTPTitle: WideString;
                       CTPParentWindow: OleVariant): _CustomTaskPane; safecall;
  end;

  ICTPFactoryDisp = dispinterface
    ['{000C033D-0000-0000-C000-000000000046}']
    function CreateCTP(const CTPAxID: WideString; const CTPTitle: WideString;
                       CTPParentWindow: OleVariant): _CustomTaskPane; dispid 1;
  end;

  ICustomTaskPaneConsumer = interface(IDispatch)
    ['{000C033E-0000-0000-C000-000000000046}']
    procedure CTPFactoryAvailable(const CTPFactoryInst: ICTPFactory); safecall;
  end;

  ICustomTaskPaneConsumerDisp = dispinterface
    ['{000C033E-0000-0000-C000-000000000046}']
    procedure CTPFactoryAvailable(const CTPFactoryInst: ICTPFactory); dispid 1;
  end;

  IRibbonControl = interface(IDispatch)
    ['{000C0395-0000-0000-C000-000000000046}']
    function Get_Id: WideString; safecall;
    function Get_Context: IDispatch; safecall;
    function Get_Tag: WideString; safecall;
    property Id: WideString read Get_Id;
    property Context: IDispatch read Get_Context;
    property Tag: WideString read Get_Tag;
  end;

  IRibbonControlDisp = dispinterface
    ['{000C0395-0000-0000-C000-000000000046}']
    property Id: WideString readonly dispid 1;
    property Context: IDispatch readonly dispid 2;
    property Tag: WideString readonly dispid 3;
  end;

  TCTPFactoryAvailable = procedure(CTPFactory: ICTPFactory) of object;

  TadxCTPDockPosition = (adxCTPDockPositionLeft, adxCTPDockPositionTop,
    adxCTPDockPositionRight, adxCTPDockPositionBottom, adxCTPDockPositionFloating);
  TadxCTPDockPositionRestrict = (adxCTPDockPositionRestrictNone, adxCTPDockPositionRestrictNoChange,
    adxCTPDockPositionRestrictNoHorizontal, adxCTPDockPositionRestrictNoVertical);
  TadxCTPOutlookWindow = (olExplorers, olInspectors);
  TadxCTPOutlookWindows = set of TadxCTPOutlookWindow;

  TadxCustomTaskPane = class;

  TadxCustomTaskPaneInstance = class(TCollectionItem)
  private
    FModule: TadxCOMAddInModule;
    FWindow: IDispatch;
    FInternalVisible: boolean;
    FLocked: boolean;
    FInstance: Pointer;
    FDockPosition: TadxCTPDockPosition;
    FDockPositionRestrict: TadxCTPDockPositionRestrict;
    FHeight: Integer;
    FTitle: WideString;
    FVisible: boolean;
    FWidth: Integer;

    function  GetControl: IDispatch;
    function  GetDockPosition: TadxCTPDockPosition;
    procedure SetDockPosition(const Value: TadxCTPDockPosition);
    function  GetDockPositionRestrict: TadxCTPDockPositionRestrict;
    procedure SetDockPositionRestrict(const Value: TadxCTPDockPositionRestrict);
    function  GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    function  GetParent: TadxCustomTaskPane;
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    function  GetWidth: Integer;
    procedure SetWidth(const Value: Integer);
    function  GetWindow: IDispatch;

    procedure DoVisibleStateChange(const Pane: _CustomTaskPane);
    procedure DoDockPositionStateChange(const Pane: _CustomTaskPane);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Control: IDispatch read GetControl;
    property DockPosition: TadxCTPDockPosition read GetDockPosition write SetDockPosition default adxCTPDockPositionRight;
    property DockPositionRestrict: TadxCTPDockPositionRestrict read GetDockPositionRestrict write SetDockPositionRestrict default adxCTPDockPositionRestrictNone;
    property Height: Integer read GetHeight write SetHeight default -1;
    property Parent: TadxCustomTaskPane read GetParent;
    property Title: WideString read GetTitle;
    property Visible: boolean read GetVisible write SetVisible default True;
    property Width: Integer read GetWidth write SetWidth default -1;
    property Window: IDispatch read GetWindow;
  end;

  TadxCustomTaskPaneInstances = class(TOwnedCollection)
  private
    FOwner: TadxCustomTaskPane;
    function  GetItemByWindow(Index: IDispatch): TadxCustomTaskPaneInstance;
    function  ItemByIndex(Index: Integer): TadxCustomTaskPaneInstance;
    function  InternalAdd(Pane: _CustomTaskPane): TadxCustomTaskPaneInstance;
  protected
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function Add: TObject;
    property Items[Index: IDispatch]: TadxCustomTaskPaneInstance read GetItemByWindow; default;
  public
  end;

  TadxTaskPaneDockPositionStateChange = procedure(Sender: TObject; Instance: TadxCustomTaskPaneInstance) of object;
  TadxTaskPaneVisibleStateChange = procedure(Sender: TObject; Instance: TadxCustomTaskPaneInstance) of object;

  TadxCustomTaskPane = class(TCollectionItem)
  private
    FModule: TadxCOMAddinModule;
    FInstances: TadxCustomTaskPaneInstances;
    FIsLocked: boolean;
    FControlProgID: string;
    FDockPosition: TadxCTPDockPosition;
    FDockPositionRestrict: TadxCTPDockPositionRestrict;
    FHeight: Integer;
    FOutlookWindows: TadxCTPOutlookWindows;
    FSupportedApps: TadxHostAppSet;
    FTitle: WideString;
    FVisible: boolean;
    FWidth: Integer;
    FOnDockPositionChange: TadxTaskPaneDockPositionStateChange;
    FOnVisibleChange: TadxTaskPaneVisibleStateChange;
    function  GetDockPosition: TadxCTPDockPosition;
    procedure SetDockPosition(const Value: TadxCTPDockPosition);
    function  GetDockPositionRestrict: TadxCTPDockPositionRestrict;
    procedure SetDockPositionRestrict(const Value: TadxCTPDockPositionRestrict);
    function  GetHeight: Integer;
    procedure SetHeight(const Value: Integer);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(const Value: boolean);
    function  GetWidth: Integer;
    procedure SetWidth(const Value: Integer);

    procedure FixInfoPathPanes();
    procedure FixWordPanes();
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Instances: TadxCustomTaskPaneInstances read FInstances;
  published
    property ControlProgID: string read FControlProgID write FControlProgID;
    property DockPosition: TadxCTPDockPosition read GetDockPosition write SetDockPosition default adxCTPDockPositionRight;
    property DockPositionRestrict: TadxCTPDockPositionRestrict read GetDockPositionRestrict write SetDockPositionRestrict default adxCTPDockPositionRestrictNone;
    property Height: Integer read GetHeight write SetHeight default -1;
    property OutlookWindows: TadxCTPOutlookWindows read FOutlookWindows write FOutlookWindows default [olExplorers, olInspectors];
    property SupportedApps: TadxHostAppSet read FSupportedApps write FSupportedApps
      default [ohaExcel, ohaWord, ohaOutlook, ohaPowerPoint, ohaAccess, ohaInfoPath];
    property Title: WideString read GetTitle write FTitle;
    property Visible: boolean read GetVisible write SetVisible default True;
    property Width: Integer read GetWidth write SetWidth default -1;
    property OnDockPositionStateChange: TadxTaskPaneDockPositionStateChange read FOnDockPositionChange write FOnDockPositionChange;
    property OnVisibleStateChange: TadxTaskPaneVisibleStateChange read FOnVisibleChange write FOnVisibleChange;
  end;

  TadxCustomTaskPanes = class(TOwnedCollection)
  private
    FModule: TadxCOMAddInModule;
    FShowWindowsInTaskbar: boolean;
    function  GetItem(Index: Integer): TadxCustomTaskPane;
    procedure SetItem(Index: Integer; Value: TadxCustomTaskPane);
    procedure MakeCTP(const Window: IDispatch; HostType: Integer = 0);
    procedure RemoveCTP(const Window: IDispatch);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function Add: TadxCustomTaskPane;
    property Items[Index: Integer]: TadxCustomTaskPane read GetItem write SetItem; default;
  published
  end;

  TadxRibbonControlType = (
    rctCommand, rctTab, rctQAT, rctOfficeMenu,
    rctGroup, rctBox, rctButtonGroup,
    rctButton, rctSplitButton, rctLabel, rctCheckBox, rctEditBox, rctComboBox, rctDropDown,
    rctGallery, rctMenu, rctSeparator, rctMenuSeparator, rctDialogBoxLauncher, rctItem,
    rctContextMenu,
    // Backstage
    rctBackstageView,
    rctBackstageTab,
    rctBackstageFastCommandButton,

    rctBackstageTaskFormGroup,
    rctBackstageTaskFormGroupCategory,
    rctBackstageTaskFormGroupTask,
    rctBackstageGroup,
    rctBackstageTaskGroup,
    rctBackstageTaskGroupCategory,
    rctBackstageTaskGroupTask,

    rctBackstagePrimaryMenu,
    rctBackstageSubMenu,
    rctBackstageMenuGroup,
    rctBackstageMenuButton,
    rctBackstageMenuCheckBox,
    rctBackstageMenuToggleButton,

    rctBackstageRegularButton,
    rctBackstageCheckBox,
    rctBackstageGroupButton,
    rctBackstageEditBox,
    rctBackstageComboBox,
    rctBackstageDropDown,
    rctBackstageRadioGroup,
    rctBackstageHyperlink,
    rctBackstageLabelControl,
    rctBackstageImageControl,
    rctBackstageGroupBox,
    rctBackstageLayoutContainer,
    rctBackstageItem);

  TadxRibbon = (msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookMeetingRequestRead, msrOutlookMeetingRequestSend,
    msrOutlookAppointment, msrOutlookContact, msrOutlookJournal, msrOutlookTask, msrOutlookDistributionList,
    msrOutlookReport, msrOutlookResend, msrOutlookResponseRead, msrOutlookResponseCompose,
    msrOutlookResponseCounterPropose, msrOutlookRSS, msrOutlookPostRead, msrOutlookPostCompose,
    msrOutlookSharingRead, msrOutlookSharingCompose, msrOutlookExplorer);
  TadxRibbon2010 = (msrOutlookExplorer2010, msrOutlookSMSRead2010, msrOutlookSMSCompose2010,
    msrOutlookMMSRead2010, msrOutlookMMSCompose2010,
    msrInfoPathDesigner2010, msrInforPathFiller2010, msrInfoPathPrintPreview2010,
    msrPublisherPublication2010, msrProjectProject2010, msrVisioDrawing2010);
  TadxRibbons = set of TadxRibbon;
  TadxRibbons2010 = set of TadxRibbon2010;

  TadxOfficeColorScheme = (Unknown, Blue, Silver, Black);
  TadxOutlookShutdownBehavior = (osSlow, osFast);

  TadxRibbonBeforeCreate = procedure(Sender: TObject; const RibbonID: WideString) of object;
  TadxRibbonBeforeLoad = procedure(Sender: TObject; const RibbonID: WideString; var Xml: WideString) of object;
  TadxRibbonLoaded = procedure(Sender: TObject; const RibbonUI: IRibbonUI) of object;
  TadxTaskPaneBeforeCreate = procedure(Sender: TadxCustomTaskPane; Window: IDispatch;
    var Cancel: boolean) of object;
  TadxTaskPaneAfterCreate = procedure(Sender: TadxCustomTaskPane; Instance: TadxCustomTaskPaneInstance) of object;
  TadxTaskPaneBeforeShow = procedure(Sender: TadxCustomTaskPane; Instance: TadxCustomTaskPaneInstance;
    var Cancel: boolean) of object;
  TadxTaskPaneAfterShow = procedure(Sender: TadxCustomTaskPane; Instance: TadxCustomTaskPaneInstance) of object;
  TadxTaskPaneBeforeDestroy = procedure(Sender: TadxCustomTaskPane; Instance: TadxCustomTaskPaneInstance) of object;
  TadxOfficeColorSchemeChanged = procedure(Sender: TObject; ColorScheme: TadxOfficeColorScheme) of object;

  TadxRibbonControlPropertyType = (rcptVisible, rcptKeyTip, rcptCaption, rcptEnabled, rcptPressed, rcptGlyph,
    rcptScreenTip, rcptSuperTip, rcptShowCaption, rcptShowImage, rcptSize, rcptDescription, rcptText,
    rcptItemCount, rcptSelectedItemIndex, rcptSelectedItemID, rcptItemHeight, rcptItemWidth,
    rcptContent, rcptTitle,
    rcptItemID, rcptItemCaption, rcptItemScreenTip, rcptItemSuperTip, rcptItemGlyph, rcptShowItemImage,
    rcptTarget, rcptAltText, rcptHelperText, rcptGroupStyle);
  TadxRibbonPropertyChanging = procedure(Sender: TObject; PropertyType: TadxRibbonControlPropertyType;
    var Value: OleVariant; const Context: IDispatch) of object;
  TadxRibbonItemPropertyChanging = procedure(Sender: TObject; PropertyType: TadxRibbonControlPropertyType;
    var Value: OleVariant; const Context: IDispatch; Index: integer) of object;

  TadxKeyDownEventArgs = record
    Ctrl, Alt, Shift: boolean;
    Handled: boolean;
    KeyStrokeFlags: integer;
    VirtualKey: integer;
  end;

  TadxKeyDownEventHandler = procedure (Sender: TObject; var args: TadxKeyDownEventArgs) of object;

  TadxCOMAddInModule = class(TDataModule)
  private
    FSinkList: TList;
    FCommandBars: TList;
    FSupportedApps: TadxHostAppSet;
    FDescription: string;
    FAddInName: string;
    FLoadBehavior: Integer;
    FDisplayAlerts: boolean;
    FXLAutomationAddIn: boolean;
    FFastCommandBarSearch: boolean;
    FOnError: TadxOnError;
    FOnAddInFinalize: TNotifyEvent;
    FOnAddInInitialize: TNotifyEvent;
    FOnAddInStartupComplete: TNotifyEvent;
    FOnAddInBeginShutdown: TNotifyEvent;
    FOnAfterAddinRegister: TNotifyEvent;
    FOnBeforeAddinUnregister: TNotifyEvent;
    // Outlook events
    FExplFirstStart: boolean;
    FOnOLNewExplorer: TadxNewExplorer;
    FOnOLNewInspector: TadxNewInspector;
    FOnOLExplorerActivate: TNotifyEvent;
    FOnOLExplorerFolderSwitch: TNotifyEvent;
    FOnOLExplorerBeforeFolderSwitch: TadxExplorerBeforeFolderSwitch;
    FOnOLExplorerViewSwitch: TNotifyEvent;
    FOnOLExplorerBeforeViewSwitch: TadxExplorerBeforeViewSwitch;
    FOnOLExplorerDeactivate: TNotifyEvent;
    FOnOLExplorerSelectionChange: TNotifyEvent;
    FOnOLExplorerClose: TNotifyEvent;
    FOnOLInspectorActivate: TNotifyEvent;
    FOnOLInspectorDeactivate: TNotifyEvent;
    FOnOLInspectorClose: TNotifyEvent;
    FOnCTPFactoryAvailable: TCTPFactoryAvailable;

    // GARANT // { handling setting host application
    FOnHostAppSet : TNotifyEvent;
    // GARANT // } handling setting host application

    FIApp: OLEVariant;
    FHostType: TadxOfficeHostApp;
    FAddInInstance: COMAddIn;
    FCOMAddInClassInstance: TadxAddin;
    FCOMAddInClassFactory: TadxFactory;
    FStartMode: TadxStartMode;
    FICmdBars: CommandBars;
    FRegistry: TRegistry;
    FRegisterForAllUsers: boolean;

    FExcel: Excel2000.TExcelApplication;
    FWord: Word2000.TWordApplication;
    FOutlook: Outlook2000.TOutlookApplication;
    FPowerPoint: MSPPt2000.TPowerPointApplication;
    FAccess: Access2000.TAccessApplication;
    FProject: Project2000.TProjectApplication;
    FFrontPage: FrontPage2000.TFrontPageApplication;
    FMapPoint: MapPoint2002.TMapPointApplication;
    FVisio: Visio2002.TVisioApplication;
    FPublisher: Publisher2003.TApplication;
    FInfoPath: InfoPath2007.TApplication;

    FHandleShortcuts: boolean;
    FNativeWindow: TWinControl;
    FControlByShortcut: TStringList;

    FHostEvents: TadxCustomEvents;
    FOnCallBack: TadxOnCallBack;

    FNamespace_: WideString;
    FStartFromScratch: TadxRibbons;
    FStartFromScratch2010: TadxRibbons2010;
    FRibbonUI: IRibbonUI;
    FCTPFactory: ICTPFactory;
    FOnRibbonBeforeCreate: TadxRibbonBeforeCreate;
    FOnRibbonBeforeLoad: TadxRibbonBeforeLoad;
    FOnRibbonLoaded: TadxRibbonLoaded;
    FIsRibbon: boolean;
    FStartupCompleteCounter: Integer;

    FCommands: TList;
    FTabs: TList;
    FContextTabs: TList;

    FRibbonControls: TStringList;
    FTaskPanes: TadxCustomTaskPanes;
    FOnTaskPaneBeforeCreate: TadxTaskPaneBeforeCreate;
    FOnTaskPaneAfterCreate: TadxTaskPaneAfterCreate;
    FOnTaskPaneBeforeShow: TadxTaskPaneBeforeShow;
    FOnTaskPaneAfterShow: TadxTaskPaneAfterShow;
    FOnTaskPaneBeforeDestroy: TadxTaskPaneBeforeDestroy;

    FAccessTimer: TTimer;
    FTimerLocked: boolean;
    FdbLoaded: boolean;
    FdbFullName: string;

    FHostMajorVersion: Integer;
    FNativeColorWindow: TWinControl;
    FOfficeColorScheme: TadxOfficeColorScheme;
    FOnOfficeColorSchemeChanged: TadxOfficeColorSchemeChanged;

    FOutlook2007InternalWrapper: Pointer;
    FOnKeyDown: TadxKeyDownEventHandler;

    // office 2007/2010 namespace
    FOfficeXMLNS: string;
    procedure SetSupportedApps(const Value: TadxHostAppSet);
    procedure SetAddInName(const Value: string);
    function  GetRegistryKey: string;
    function  GetAppCommandBars: CommandBars;
    function  GetOutlookProfileName: WideString;

    procedure SetHostApplication;
    procedure FreeHostApplication;
    procedure Install;
    procedure InternalAddCmdBar(const ACmdBar: TadxCustomCommandBar);
    procedure InternalAddControl(const AControl: TadxCommandBarControl;
      const ACmdBar: TadxCustomCommandBar; APopup: TadxCommandBarPopup = nil);
    procedure InternalAddBuiltInControl(const AControl: TadxBuiltInControl);
    function  GetCommandBars(Index: Integer): TadxCustomCommandBar;
    function  GetCommandBarsCount: Integer;

    procedure SaveExplCommandBars;
    procedure LoadExplCommandBars;
    function  ControlByShortcut: TStringList;
    procedure SetHandleShortcuts(const Value: boolean);

    procedure InstallShortcuts;
    procedure UninstallShortcuts;

    procedure InstallSolutionModules;
    procedure DoCTPFactoryAvailable;
    procedure DoCallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
    procedure DoAccessTick(Sender: TObject);
    procedure ClearAccessCommandBarsInterfaces();

    procedure DoCommandBarsUpdate();
    procedure ConnectBuiltinControls();
    procedure DisconnectBuiltinControls();
    function  GetOutlookShutdownBehavior: TadxOutlookShutdownBehavior;
    procedure SetStartFromScratch(Value: TadxRibbons);
    procedure SetStartFromScratch2010(Value: TadxRibbons2010);
    function  GetHostVersion: WideString;
    // GARANT // { handling setting host application
    procedure SetIApp(Value: OleVariant);
    // GARANT // } handling setting host application
    property RibbonUI: IRibbonUI read FRibbonUI;
  protected
    procedure DoError(const E: SysUtils.Exception);
    // MapPoint
    procedure AddMapPointCommand(const DisplayName, MethodName: WideString);
    // Outlook
    procedure OptionsPagesAdd(ASender: TObject;
      const Pages: PropertyPages); virtual;
    procedure NameSpaceOptionsPagesAdd(ASender: TObject;
      const Pages: PropertyPages; const Folder: MAPIFolder); virtual;
    property FastCommandBarSearch: boolean read FFastCommandBarSearch
      write FFastCommandBarSearch default False;
    property CTPFactory: ICTPFactory read FCTPFactory;

    property OnCallBack: TadxOnCallBack read FOnCallBack write FOnCallBack;
    property OnCTPFactoryAvailable: TCTPFactoryAvailable read FOnCTPFactoryAvailable write FOnCTPFactoryAvailable;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    function FindCommandBar(const CmdBarName: WideString): CommandBar;
    function FindControl(ACommandBar: CommandBar; AType: MsoControlType;
      ID: Integer): CommandBarControl; overload;
    function FindControl(ACommandBar: CommandBar; AType: MsoControlType;
      Tag: WideString): CommandBarControl; overload;
    function FindControl(AType: MsoControlType; ID: Integer): CommandBarControl; overload;
    function FindControl(AType: MsoControlType; Tag: WideString): CommandBarControl; overload;
    function CommandBarIndexByName(const CommandBarName: WideString): TadxCustomCommandBar;
    function CommandBarIndexOf(const CmdBar: TadxCustomCommandBar): Integer;
    function GetOutlookWindowHandle(const OutlookWindow: IDispatch): HWND;
    // Ribbon
    function FindRibbonControl(ID: WideString): TObject; overload;
    function FindRibbonControl(Tag: Integer): TObject; overload;
    function GetRibbonControlEnabled(idMso: WideString): boolean;
    function GetRibbonControlImage(idMso: WideString; Width: Integer = 32; Height: Integer = 32): IPictureDisp;
    function GetRibbonControlCaption(idMso: WideString): WideString;
    function GetRibbonControlPressed(idMso: WideString): boolean;
    function GetRibbonControlScreentip(idMso: WideString): WideString;
    function GetRibbonControlSupertip(idMso: WideString): WideString;
    function GetRibbonControlVisible(idMso: WideString): boolean;
    procedure RibbonControlExecute(idMso: WideString);
    // Ribbon 2010
    procedure ActivateRibbonTabMso(const ControlID: WideString);
    procedure ActivateRibbonTabQ(const ControlID: WideString; const Namespace: WideString);

    property COMAddInClassInstance: TadxAddIn read FCOMAddInClassInstance;
    property COMAddInClassFactory: TadxFactory read FCOMAddInClassFactory;
    property RegistryKey: string read GetRegistryKey;
    property Registry: TRegistry read FRegistry;
    property HostApp: OLEVariant read FIApp;
    property HostType: TadxOfficeHostApp read FHostType;
    property AddInInstance: COMAddIn read FAddInInstance;
    property StartMode: TadxStartMode read FStartMode;
    property CommandBars[Index: Integer]: TadxCustomCommandBar read GetCommandBars;
    property CommandBarsCount: Integer read GetCommandBarsCount;
    property ExcelApp: Excel2000.TExcelApplication read FExcel;
    property WordApp: Word2000.TWordApplication read FWord;
    property OutlookApp: Outlook2000.TOutlookApplication read FOutlook;
    property OutlookProfileName: WideString read GetOutlookProfileName;
    property PowerPointApp: MSPPt2000.TPowerPointApplication read FPowerPoint;
    property AccessApp: Access2000.TAccessApplication read FAccess;
    property ProjectApp: Project2000.TProjectApplication read FProject;
    property FrontPageApp: FrontPage2000.TFrontPageApplication read FFrontPage;
    property MapPointApp: MapPoint2002.TMapPointApplication read FMapPoint;
    property VisioApp: Visio2002.TVisioApplication read FVisio;
    property PublisherApp: Publisher2003.TApplication read FPublisher;
    property InfoPathApp: InfoPath2007.TApplication read FInfoPath;
    // Color scheme
    property OfficeColorScheme: TadxOfficeColorScheme read FOfficeColorScheme;
    // Outlook 2010 shutdown mode
    property OutlookShutdownBehavior: TadxOutlookShutdownBehavior read GetOutlookShutdownBehavior;
    property HostVersion: WideString read GetHostVersion;
    property HostMajorVersion: Integer read FHostMajorVersion;
  published
    property AddInName: string read FAddInName write SetAddInName;
    property Description: string read FDescription write FDescription;
    property DisplayAlerts: boolean read FDisplayAlerts write FDisplayAlerts default False;
    property LoadBehavior: Integer read FLoadBehavior write FLoadBehavior default 3;
    property RegisterForAllUsers: boolean read FRegisterForAllUsers write FRegisterForAllUsers default False;
    property SupportedApps: TadxHostAppSet read FSupportedApps write SetSupportedApps default [ohaExcel];
    property XLAutomationAddIn: boolean read FXLAutomationAddIn write FXLAutomationAddIn default False;
    property HandleShortcuts: boolean read FHandleShortcuts write SetHandleShortcuts default False;
    property OnKeyDown: TadxKeyDownEventHandler read FOnKeyDown write FOnKeyDown;
    property OnError: TadxOnError read FOnError write FOnError;
    property OnAddInInitialize: TNotifyEvent read FOnAddInInitialize write FOnAddInInitialize;
    property OnAddInStartupComplete: TNotifyEvent read FOnAddInStartupComplete write FOnAddInStartupComplete;
    property OnAddInBeginShutdown: TNotifyEvent read FOnAddInBeginShutdown write FOnAddInBeginShutdown;
    property OnAddInFinalize: TNotifyEvent read FOnAddInFinalize write FOnAddInFinalize;
    property OnAfterAddinRegister: TNotifyEvent read FOnAfterAddinRegister write FOnAfterAddinRegister;
    property OnBeforeAddinUnregister: TNotifyEvent read FOnBeforeAddinUnregister write FOnBeforeAddinUnregister;
    // Outlook events
    property OnOLNewExplorer: TadxNewExplorer read FOnOLNewExplorer write FOnOLNewExplorer;
    property OnOLNewInspector: TadxNewInspector read FOnOLNewInspector write FOnOLNewInspector;
    property OnOLExplorerActivate: TNotifyEvent read FOnOLExplorerActivate write FOnOLExplorerActivate;
    property OnOLExplorerFolderSwitch: TNotifyEvent read FOnOLExplorerFolderSwitch write FOnOLExplorerFolderSwitch;
    property OnOLExplorerBeforeFolderSwitch: TadxExplorerBeforeFolderSwitch read FOnOLExplorerBeforeFolderSwitch write FOnOLExplorerBeforeFolderSwitch;
    property OnOLExplorerViewSwitch: TNotifyEvent read FOnOLExplorerViewSwitch write FOnOLExplorerViewSwitch;
    property OnOLExplorerBeforeViewSwitch: TadxExplorerBeforeViewSwitch read FOnOLExplorerBeforeViewSwitch write FOnOLExplorerBeforeViewSwitch;
    property OnOLExplorerDeactivate: TNotifyEvent read FOnOLExplorerDeactivate write FOnOLExplorerDeactivate;
    property OnOLExplorerSelectionChange: TNotifyEvent read FOnOLExplorerSelectionChange write FOnOLExplorerSelectionChange;
    property OnOLExplorerClose: TNotifyEvent read FOnOLExplorerClose write FOnOLExplorerClose;
    property OnOLInspectorActivate: TNotifyEvent read FOnOLInspectorActivate write FOnOLInspectorActivate;
    property OnOLInspectorDeactivate: TNotifyEvent read FOnOLInspectorDeactivate write FOnOLInspectorDeactivate;
    property OnOLInspectorClose: TNotifyEvent read FOnOLInspectorClose write FOnOLInspectorClose;
    // Ribbon
    property Namespace: WideString read FNamespace_ write FNamespace_;
    property StartFromScratch: TadxRibbons read FStartFromScratch write SetStartFromScratch default [];
    property StartFromScratch2010: TadxRibbons2010 read FStartFromScratch2010 write SetStartFromScratch2010 default [];
    property TaskPanes: TadxCustomTaskPanes read FTaskPanes write FTaskPanes;
    property OnTaskPaneBeforeCreate: TadxTaskPaneBeforeCreate read FOnTaskPaneBeforeCreate write FOnTaskPaneBeforeCreate;
    property OnTaskPaneAfterCreate: TadxTaskPaneAfterCreate read FOnTaskPaneAfterCreate write FOnTaskPaneAfterCreate;
    property OnTaskPaneBeforeShow: TadxTaskPaneBeforeShow read FOnTaskPaneBeforeShow write FOnTaskPaneBeforeShow;
    property OnTaskPaneAfterShow: TadxTaskPaneAfterShow read FOnTaskPaneAfterShow write FOnTaskPaneAfterShow;
    property OnTaskPaneBeforeDestroy: TadxTaskPaneBeforeDestroy read FOnTaskPaneBeforeDestroy write FOnTaskPaneBeforeDestroy;
    property OnRibbonBeforeCreate: TadxRibbonBeforeCreate read FOnRibbonBeforeCreate write FOnRibbonBeforeCreate;
    property OnRibbonBeforeLoad: TadxRibbonBeforeLoad read FOnRibbonBeforeLoad write FOnRibbonBeforeLoad;
    property OnRibbonLoaded: TadxRibbonLoaded read FOnRibbonLoaded write FOnRibbonLoaded;
    // Color scheme
    property OnOfficeColorSchemeChanged: TadxOfficeColorSchemeChanged read FOnOfficeColorSchemeChanged write FOnOfficeColorSchemeChanged;
    // GARANT // { handling setting host application
    property OnHostAppSet : TNotifyEvent read FOnHostAppSet write FOnHostAppSet;
    // GARANT // } handling setting host application
  end;

  TadxCustomDocumentModule = class(TadxCOMAddInModule)
  private
    FSinkList: TList;
    FControls: TList;
    FDocument: TFileName;
    FPropertyID: string;
    FPropertyValue: string;
    FOnConnect: TNotifyEvent;
    function GetControlsCount: Integer;
    function GetControls(Index: Integer): TadxMSFormsControl;
    function CheckDocumentProps(const IDsp: IDispatch): boolean;
    procedure DisconnectControls;
    procedure ReconnectControls;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;

    function ControlIndexByName(const ControlName: string): Integer;
    function ControlByName(const ControlName: string): TadxMSFormsControl;
    function ControlIndexOf(Control: TadxMSFormsControl): Integer;
    property ControlsCount: Integer read GetControlsCount;
    property Controls[Index: Integer]: TadxMSFormsControl read GetControls;
    property Document: TFileName read FDocument write FDocument;
    property PropertyID: string read FPropertyID write FPropertyID;
    property PropertyValue: string read FPropertyValue write FPropertyValue;
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
  published
  end;

  TadxExcelSheetModule = class(TadxCustomDocumentModule)
  private
    FWorkSheet: string;
  protected
  public
  published
    property Document;
    property PropertyID;
    property PropertyValue;
    property WorkSheet: string read FWorkSheet write FWorkSheet;
    property OnConnect;
  end;

  TadxWordDocumentModule = class(TadxCustomDocumentModule)
  private
  protected
  public
  published
    property Document;
    property PropertyID;
    property PropertyValue;
    property OnConnect;
  end;

  { Office Add-in class factory }
  TadxCOMAddInModuleClass = class of TadxCOMAddInModule;

  TadxFactory = class(TAutoObjectFactory)
  private
    FDeprecatedVersion: boolean;
    FOldAddIn: Pointer;
    FAddInName: string;
    FDescription: string;
    FSupportedApps: TadxHostAppSet;
    FLoadBehavior: Integer;
    FDisplayAlerts: boolean;
    FXLAutomationAddIn: boolean;
    FModuleClass: TadxCOMAddInModuleClass;
    FAddInPath: string;
    function GetAddInName: string; virtual;
    function GetSupportedApps: TadxHostAppSet; virtual;
    function GetRegKey(Index: TadxOfficeHostApp): string;
    function IsHostAppInstalled(AHostType: TadxOfficeHostApp): boolean;
    procedure RegisterAddIn;
    procedure UnRegisterAddIn;
    procedure UnRegisterControls;
    // Excel 2002 and higher
    procedure RegisterAutomationAddin(const Reg: TRegistry);
    procedure UnregisterAutomationAddin(const Reg: TRegistry);
  protected
    function GetHostVersion(const AHostApp: TadxOfficeHostApp): Integer;
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; AModuleClass: TadxCOMAddInModuleClass);
    procedure UpdateRegistry(Register: Boolean); override;
    property FilePath: string read FAddInPath;
    property RegistryKey[Index: TadxOfficeHostApp]: string read GetRegKey;
  end;

  IExtensionEvent = interface
    ['{7175D144-097E-4CB1-B3BD-9CA72BC05BD6}']
    procedure CallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
  end;

  TadxAddin = class(TAutoObject, IDTExtensibility2, IExtensionEvent,
    IRibbonExtensibility, ICustomTaskPaneConsumer)
  private
    FSink: Pointer;
    FAddInModule: TadxCOMAddInModule;
    // MS Word and MS Outlook tricks
    FExplorerList: TList;
    FInspectorList: TList;
    FConnectionSuccessful: boolean;
    FOnOptionsPagesAdd: TOutlookApplicationOptionsPagesAdd;
    FOnQuit: TNotifyEvent;
    FOnWordWindowActivate: TWordApplicationWindowActivate;
    FOnWordDocumentOpen: TWordApplicationDocumentOpen;
    FOnWordNewDocument: TWordApplicationNewDocument;
    FOnWordDocumentChange: TNotifyEvent;
    FOnWorkbookActivate: TExcelApplicationWorkbookActivate;
    FOnSheetActivate: TExcelApplicationSheetActivate;
    // InfoPath
    FOnInfoPathWindowActivate: InfoPath2007.TApplicationWindowActivate;
    FOnInfoPathNewXDocument: InfoPath2007.TApplicationNewXDocument;
    FOnInfoPathXDocumentOpen: InfoPath2007.TApplicationXDocumentOpen;
    // Visio
    FOnVisioWindowActivated: TVisioApplicationWindowActivated;
    // PowerPoint
    FOnPowerPointWindowActivate: TPowerPointApplicationWindowActivate;
    FDoNotRaiseShutdownEvents: boolean;
    {$IFDEF ADX_VCL5}
    FExplorers: Pointer;
    FInspectors: Pointer;
    FNameSpace: Pointer;
    {$ENDIF}
    {$IFDEF ADX_VCL6}
    FExplorers: TExplorers;
    FInspectors: TInspectors;
    FNameSpace: TNameSpace;
    {$ENDIF}
    {$IFDEF DELPHI_7_UP}
    FExplorers: TExplorers;
    FInspectors: TInspectors;
    FNameSpace: TNameSpace;
    procedure DoWordWindowActivate(ASender: TObject; const Doc: WordDocument; const Wn: Word2000.Window);
    procedure DoWordDocumentOpen(ASender: TObject; const Doc: WordDocument);
    procedure DoWordNewDocument(ASender: TObject; const Doc: WordDocument);
    procedure DoOptionsPagesAdd(ASender: TObject; const Pages: PropertyPages);
    procedure DoWorkbookActivate(ASender: TObject; const Wb: ExcelWorkbook);
    procedure DoSheetActivate(ASender: TObject; const Sh: IDispatch);
    procedure DoPowerPointWindowActivate(ASender: TObject; const Pres: PowerPointPresentation; const Wn: DocumentWindow);
    {$ELSE}
    procedure DoWordWindowActivate(ASender: TObject; var Doc: OleVariant; var Wn: OleVariant);
    procedure DoWordDocumentOpen(ASender: TObject; var Doc: OleVariant);
    procedure DoWordNewDocument(ASender: TObject; var Doc: OleVariant);
    procedure DoOptionsPagesAdd(Sender: TObject; var Pages: OleVariant);
    procedure DoWorkbookActivate(ASender: TObject; var Wb: OleVariant);
    procedure DoSheetActivate(ASender: TObject; var Sh: OleVariant);
    procedure DoPowerPointWindowActivate(ASender: TObject; var Pres: OleVariant; var Wn: OleVariant);
    {$ENDIF}
    {$IFDEF ADX_VCL6}
    procedure DoNewExplorer(ASender: TObject; var Explorer: OleVariant);
    procedure DoNewInspector(ASender: TObject; var Inspector: OleVariant);
    procedure DoExplorerBeforeFolderSwitch(ASender: TObject;
      var NewFolder: OleVariant; var Cancel: OleVariant);
    procedure DoExplorerBeforeViewSwitch(ASender: TObject;
      NewView: OleVariant; var Cancel: OleVariant);
    procedure DoNameSpaceOptionsPagesAdd(Sender: TObject; var Pages: OleVariant;
      var Folder: OleVariant);
    {$ELSE}
    procedure DoNewExplorer(ASender: TObject; const Explorer: _Explorer);
    procedure DoNewInspector(ASender: TObject; const Inspector: _Inspector);
    procedure DoExplorerBeforeFolderSwitch(ASender: TObject;
      const NewFolder: IDispatch; var Cancel: WordBool);
    procedure DoExplorerBeforeViewSwitch(ASender: TObject; NewView: OleVariant;
      var Cancel: WordBool);
    procedure DoNameSpaceOptionsPagesAdd(ASender: TObject;
      const Pages: PropertyPages; const Folder: MAPIFolder);
    {$ENDIF}
    procedure DoExplorerActivate(ASender: TObject);
    procedure DoExplorerFolderSwitch(ASender: TObject);
    procedure DoExplorerViewSwitch(ASender: TObject);
    procedure DoExplorerDeactivate(ASender: TObject);
    procedure DoExplorerSelectionChange(ASender: TObject);
    procedure DoExplorerClose(ASender: TObject);
    procedure DoInspectorActivate(ASender: TObject);
    procedure DoInspectorDeactivate(ASender: TObject);
    procedure DoInspectorClose(ASender: TObject);
    procedure DoOutlookQuit(ASender: TObject);

    procedure DoInfoPathWindowActivate(Sender: TObject; const pDocument: _XDocument; const pWindow: Window);
    procedure DoInfoPathNewXDocument(Sender: TObject; const pDocument: _XDocument);
    procedure DoInfoPathXDocumentOpen(Sender: TObject; const pDocument: _XDocument);
    procedure DoWordDocumentChange(ASender: TObject);

    procedure DoVisioWindowActivated(Sender: TObject; const Window: IVWindow);
    procedure DoVisioReconnect(Sender: TObject);

    function GetFactory: TadxFactory;
    { IDTExtensibility2 support }
    procedure OnConnection(const Application_: IDispatch;
      ConnectMode: ext_ConnectMode; const AddInInst: IDispatch;
      var custom: PSafeArray); safecall;
    procedure OnDisconnection(RemoveMode: ext_DisconnectMode;
      var custom: PSafeArray); safecall;
    procedure OnAddInsUpdate(var custom: PSafeArray); safecall;
    procedure OnStartupComplete(var custom: PSafeArray); safecall;
    procedure OnBeginShutdown(var custom: PSafeArray); safecall;
    { IExtensionEvent support }
    procedure CallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
    { IRibbonExtensibility }
    function GetCustomUI(const RibbonID: WideString): WideString; safecall;
    { ICustomTaskPaneConsumer }
    procedure CTPFactoryAvailable(const CTPFactoryInst: ICTPFactory); safecall;
    {  }
    procedure RibbonLoaded_Callback(const ribbon: IRibbonUI); safecall;
    function GetImages_Callback(AImageName: string): IPictureDisp; safecall;
    function GetVisible_Callback(const Ctrl: IRibbonControl): WordBool; safecall;
    function GetKeyTip_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetLabel_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetEnabled_Callback(const Ctrl: IRibbonControl): WordBool; safecall;
    function GetPressed_CallBack(const Ctrl: IRibbonControl): WordBool; safecall;
    function GetImage_Callback(const Ctrl: IRibbonControl): IPictureDisp; safecall;
    function GetItemImage_Callback(const Ctrl: IRibbonControl; Index: Integer): IPictureDisp; safecall;
    function GetScreenTip_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetSuperTip_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetShowLabel_Callback(const Ctrl: IRibbonControl): WordBool; safecall;
    function GetShowImage_Callback(const Ctrl: IRibbonControl): WordBool; safecall;
    function GetSize_Callback(const Ctrl: IRibbonControl): Integer; {TadxRibbonXControlSize;} safecall;
    function GetDescription_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetText_Callback(const Ctrl: IRibbonControl): OleVariant; safecall;
    function GetItemCount_Callback(const Ctrl: IRibbonControl): Integer; safecall;
    function GetItemID_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString; safecall;
    function GetItemLabel_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString; safecall;
    function GetItemScreenTip_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString; safecall;
    function GetItemSuperTip_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString; safecall;
    function GetShowItemImage_Callback(const Ctrl: IRibbonControl; Index: Integer): WordBool; safecall;
    function GetSelectedItemIndex_Callback(const Ctrl: IRibbonControl): Integer; safecall;
    function GetSelectedItemId_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetItemHeight_Callback(const Ctrl: IRibbonControl): Integer; safecall;
    function GetItemWidth_Callback(const Ctrl: IRibbonControl): Integer; safecall;
    function GetContent_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetTitle_Callback(const Ctrl: IRibbonControl): WideString; safecall;

    // events
    procedure OnActionCommon_Callback(const Ctrl: IRibbonControl); safecall;
    procedure OnActionState_Callback(const Ctrl: IRibbonControl; Pressed: WordBool); safecall;
    procedure OnActionSelected_Callback(const Ctrl: IRibbonControl; const SelectedID: WideString;
      SelectedIndex: Integer); safecall;
    procedure OnChange_Callback(const Ctrl: IRibbonControl; const Text: WideString); safecall;
    // repurposed controls (button, toggleButton, checkBox)
    procedure OnActionCommonRepurposed_Callback(const Ctrl: IRibbonControl; var Cancel: WordBool); safecall;
    procedure OnActionStateRepurposed_Callback(const Ctrl: IRibbonControl; Pressed: WordBool; var Cancel: WordBool); safecall;
    // Office 2010
    procedure OnBackstageShow_Callback(const Context: IDispatch); safecall;
    procedure OnBackstageHide_Callback(const Context: IDispatch); safecall;
    function GetTarget_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetAltText_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetHelperText_Callback(const Ctrl: IRibbonControl): WideString; safecall;
    function GetStyle_Callback(const Ctrl: IRibbonControl): WideString; safecall;
  protected
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; override; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; override; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; override; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; override; stdcall;
  public
    property COMAddInModule: TadxCOMAddInModule read FAddInModule;
    property Factory: TadxFactory read GetFactory;
  end;

  EADXException = EOLESysError;

const
  adxVersion: string = '6.4.758';
  adxLCID: Integer = LOCALE_USER_DEFAULT;
  adxOfficeAppNames: array [TadxOfficeHostApp] of string =
    ('Excel', 'Word', 'Outlook', 'PowerPoint', 'Access', 'MS Project',
     'FrontPage', 'MapPoint', 'Visio', 'Publisher', 'InfoPath');

  IID__IExtensionEvent: TGUID = '{7175D144-097E-4CB1-B3BD-9CA72BC05BD6}';

///////////////////////
//  1.x compatibility
///////////////////////

type
  TaxpOfficeHostApp = TadxOfficeHostApp;
  TaxpHostAppSet = TadxHostAppSet;

const
  axpVersion: string = '6.4.758';
  axpLCID: Integer = LOCALE_USER_DEFAULT;
  axpOfficeAppNames: array [TaxpOfficeHostApp] of string =
    ('Excel', 'Word', 'Outlook', 'PowerPoint', 'Access', 'MS Project',
     'FrontPage', 'MapPoint', 'Visio', 'Publisher', 'InfoPath');

// MsoBarProtection constants
type
  MsoBarProtection = adxOffice.MsoBarProtection;
const
  msoBarNoProtection = adxOffice.msoBarNoProtection;
  msoBarNoCustomize = adxOffice.msoBarNoCustomize;
  msoBarNoResize = adxOffice.msoBarNoResize;
  msoBarNoMove = adxOffice.msoBarNoMove;
  msoBarNoChangeVisible = adxOffice.msoBarNoChangeVisible;
  msoBarNoChangeDock = adxOffice.msoBarNoChangeDock;
  msoBarNoVerticalDock = adxOffice.msoBarNoVerticalDock;
  msoBarNoHorizontalDock = adxOffice.msoBarNoHorizontalDock;

// MsoBarPosition constants
type
  MsoBarPosition = adxOffice.MsoBarPosition;
const
  msoBarLeft = adxOffice.msoBarLeft;
  msoBarTop = adxOffice.msoBarTop;
  msoBarRight = adxOffice.msoBarRight;
  msoBarBottom = adxOffice.msoBarBottom;
  msoBarFloating = adxOffice.msoBarFloating;
  msoBarPopup = adxOffice.msoBarPopup;

// MsoButtonStyle constants
type
  MsoButtonStyle = adxOffice.MsoButtonStyle;
const
  msoButtonAutomatic = adxOffice.msoButtonAutomatic;
  msoButtonIcon = adxOffice.msoButtonIcon;
  msoButtonCaption = adxOffice.msoButtonCaption;
  msoButtonIconAndCaption = adxOffice.msoButtonIconAndCaption;
  msoButtonIconAndWrapCaption = adxOffice.msoButtonIconAndWrapCaption;
  msoButtonIconAndCaptionBelow = adxOffice.msoButtonIconAndCaptionBelow;
  msoButtonWrapCaption = adxOffice.msoButtonWrapCaption;
  msoButtonIconAndWrapCaptionBelow = adxOffice.msoButtonIconAndWrapCaptionBelow;

// MsoButtonState constants
type
  MsoButtonState = adxOffice.MsoButtonState;
const
  msoButtonUp = adxOffice.msoButtonUp;
  msoButtonDown = adxOffice.msoButtonDown;
  msoButtonMixed = adxOffice.msoButtonMixed;

// MsoComboStyle constants
type
  MsoComboStyle = adxOffice.MsoComboStyle;
const
  msoComboNormal = adxOffice.msoComboNormal;
  msoComboLabel = adxOffice.msoComboLabel;

type
  TaxpFactory = class(TadxFactory)
  private
    function GetAddInName: string; override;
    function GetSupportedApps: TaxpHostAppSet; override;
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; ASupportedApp: TaxpOfficeHostApp;
      const AAddInName, ADescription: string);
    constructor CreateEx(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; ASupportedApps: TaxpHostAppSet;
      const AAddInName, ADescription: string;
      const ALoadBehavior: Integer = 3; const ADisplayAlerts: boolean = False;
      const XLAutomationAddIn: boolean = False);
    property AddInName: string read GetAddInName;
    property SupportedApps: TaxpHostAppSet read GetSupportedApps;
  end;

  IaxpCmdBars = adxOffice.CommandBars;
  IaxpCmdBar = adxOffice.CommandBar;
  IaxpControl = adxOffice.CommandBarControl;
  IaxpButton = adxOffice.CommandBarButton;
  IaxpComboBox = adxOffice.CommandBarComboBox;
  IaxpEdit = IaxpComboBox;
  IaxpPopup = adxOffice.CommandBarPopupDisp;

  TaxpOnError = TadxOnError;
  TaxpStartMode = TadxStartMode;
  TaxpControlType = (axpButton, axpEdit, axpDropdown, axpCombobox, axpPopup);

  TaxpAddIn = class(TAutoObject, IDTExtensibility2)
  private
    FAddIn: TadxAddIn;
    FReg: TRegistry;
    FRefreshControls: boolean;
    FOnError: TaxpOnError;
    function GetHostApp: OleVariant;
    function GetHostType: TaxpOfficeHostApp;
    function GetAddInInstance: COMAddIn;
    function GetCmdBars: IaxpCmdBars;
    function GetFactory: TaxpFactory;
    function GetStartMode: TaxpStartMode;
    function GetRegistryKey: string;
    function GetExcel: Excel2000.TExcelApplication;
    function GetWord: Word2000.TWordApplication;
    function GetOutlook: Outlook2000.TOutlookApplication;
    function GetPowerPoint: MSPPt2000.TPowerPointApplication;
    function GetAccess: Access2000.TAccessApplication;
    function GetProject: Project2000.TProjectApplication;
    function GetFrontPage: FrontPage2000.TFrontPageApplication;
    function GetMapPoint: MapPoint2002.TMapPointApplication;
    function GetVisio: Visio2002.TVisioApplication;
    { IDTExtensibility2 support }
    procedure OnConnection(const Application_: IDispatch;
      ConnectMode: ext_ConnectMode; const AddInInst: IDispatch;
      var custom: PSafeArray); safecall;
    procedure OnDisconnection(RemoveMode: ext_DisconnectMode;
      var custom: PSafeArray); safecall;
    procedure OnAddInsUpdate(var custom: PSafeArray); safecall;
    procedure OnStartupComplete(var custom: PSafeArray); safecall;
    procedure OnBeginShutdown(var custom: PSafeArray); safecall;
  protected
    // Customize Add-in toolbars
    // * CommandBars
    function AddCmdBar(const Name: WideString; var NewControl: boolean;
      Position: MsoBarPosition = msoBarFloating;
      Temporary: boolean = false): IaxpCmdBar; overload; virtual;
    function AddCmdBar(AICmdBars: IaxpCmdBars; const Name: WideString; var NewControl: boolean;
      Position: MsoBarPosition = msoBarFloating;
      Temporary: boolean = false): IaxpCmdBar; overload; virtual;
    // * Find CommandBarControl
    function FindControl(const Tag: string; Type_: TaxpControlType): IaxpControl; overload; virtual;
    function FindControl(AICmdBars: IaxpCmdBars; const Tag: string;
      Type_: TaxpControlType): IaxpControl; overload; virtual;
    // * CommandBarControl
    function AddControl(const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Type_: TaxpControlType; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpControl; overload; virtual;
    function AddControl(AICmdBars: IaxpCmdBars; const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Type_: TaxpControlType; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpControl; overload; virtual;
    // * CommandBarButton
    function AddButton(const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString; const ImageIndex: string;
      const Style: MsoButtonStyle; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      TransparentColor: TColor = clDefault;
      Temporary: boolean = false): IaxpButton; overload; virtual;
    function AddButton(AICmdBars: IaxpCmdBars; const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString; const ImageIndex: string;
      const Style: MsoButtonStyle; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      TransparentColor: TColor = clDefault;
      Temporary: boolean = false): IaxpButton; overload; virtual;
    // * CommandBarEdit
    function AddEdit(const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Style: MsoComboStyle; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpEdit; overload; virtual;
    function AddEdit(AICmdBars: IaxpCmdBars; const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Style: MsoComboStyle; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpEdit; overload; virtual;
    // * CommandBarCombo
    function AddComboBox(const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Style: MsoComboStyle; DropDown: boolean; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpComboBox; overload; virtual;
    function AddComboBox(AICmdBars: IaxpCmdBars; const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString;
      Style: MsoComboStyle; DropDown: boolean; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpComboBox; overload; virtual;
    // * CommandBarPopup
    function AddPopup(const CmdBarName, Caption: WideString; const Tag: string;
      const Hint: WideString; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpPopup; overload; virtual;
    function AddPopup(AICmdBars: IaxpCmdBars; const CmdBarName, Caption: WideString;
      const Tag: string; const Hint: WideString; var NewControl: boolean;
      Before: integer = -1; Popup: IaxpPopup = nil;
      Temporary: boolean = false): IaxpPopup; overload; virtual;
    // * MapPoint Command
    procedure AddMapPointCommand(const DisplayName, MethodName: WideString);
    procedure AddIn_Initialize; virtual;
    procedure AddIn_Finalize; virtual;
    procedure AddIn_ControlEvent(const Tag: string; ICtrl: IaxpControl); virtual;
  public
    property HostApp: OleVariant read GetHostApp;
    property HostType: TaxpOfficeHostApp read GetHostType;
    property AddInInstance: COMAddIn read GetAddInInstance;
    property CmdBars: IaxpCmdBars read GetCmdBars;
    property Factory: TaxpFactory read GetFactory;
    property StartMode: TaxpStartMode read GetStartMode;
    property Registry: TRegistry read FReg;
    property RegistryKey: string read GetRegistryKey;
    property RefreshControls: boolean read FRefreshControls write FRefreshControls;
    // Host app wrappers
    property ExcelApp: Excel2000.TExcelApplication read GetExcel;
    property WordApp: Word2000.TWordApplication read GetWord;
    property OutlookApp: Outlook2000.TOutlookApplication read GetOutlook;
    property PowerPointApp: MSPPt2000.TPowerPointApplication read GetPowerPoint;
    property AccessApp: Access2000.TAccessApplication read GetAccess;
    property ProjectApp: Project2000.TProjectApplication read GetProject;
    property FrontPageApp: FrontPage2000.TFrontPageApplication read GetFrontPage;
    property MapPointApp: MapPoint2002.TMapPointApplication read GetMapPoint;
    property VisioApp: Visio2002.TVisioApplication read GetVisio;
    property OnError: TaxpOnError read FOnError write FOnError;
  end;

  TadxOLBarShortcut = class(TCollectionItem)
  private
    FIntf: OutlookBarShortcut;
    FIconFileName: string;
    FName: string;
    FTarget: string;
    procedure SetName(const Value: string);
    procedure ConnectTo(Intf: OutlookBarShortcut);
    procedure SetProperties;
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Delete;
    procedure SetIcon(const FileName: string);
  published
    property IconFileName: string read FIconFileName write SetIcon;
    property Name: string read FName write SetName;
    property Target: string read FTarget write FTarget;
  end;

  TadxOLBarShortcuts = class(TOwnedCollection)
  private
    FIntf: OutlookBarShortcuts;
    function GetItem(Index: Integer): TadxOLBarShortcut;
    procedure SetItem(Index: Integer; Value: TadxOLBarShortcut);
    procedure ConnectTo(Intf: OutlookBarShortcuts);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function Add: TadxOLBarShortcut; overload;
    function Add(const Target: OleVariant; const Name, IconFileName: string): TadxOLBarShortcut; overload;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TadxOLBarShortcut read GetItem write SetItem; default;
  published
  end;

  TadxOLBarViewType = (adxOLLargeIcon, adxOLSmallIcon);

  TadxOLBarGroup = class(TCollectionItem)
  private
    FIntf: OutlookBarGroup;
    FShortcuts: TadxOLBarShortcuts;
    FName: string;
    FViewType: TadxOLBarViewType;
    function GetName: string;
    procedure SetName(const Value: string);
    function GetViewType: TadxOLBarViewType;
    procedure SetViewType(const Value: TadxOLBarViewType);
    procedure ConnectTo(IGroup: OutlookBarGroup);
    procedure SetProperties;
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Delete;
  published
    property Shortcuts: TadxOLBarShortcuts read FShortcuts write FShortcuts;
    property Name: string read GetName write SetName;
    property ViewType: TadxOLBarViewType read GetViewType write SetViewType default adxOLSmallIcon;
  end;

  TadxOLBarGroups = class(TOwnedCollection)
  private
    FIntf: OutlookBarGroups;
    function GetItem(Index: Integer): TadxOLBarGroup;
    procedure SetItem(Index: Integer; Value: TadxOLBarGroup);
    procedure ConnectTo(Intf: OutlookBarGroups);
  protected
    function GetAttrCount: Integer; override;
    function GetAttr(Index: Integer): string; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function Add: TadxOLBarGroup; overload;
    function Add(const Name: string): TadxOLBarGroup; overload;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TadxOLBarGroup read GetItem write SetItem; default;
  published
  end;

  TadxOLBarShortcutManager = class(TComponent)
  private
    FGroups: TadxOLBarGroups;
    FOwner: TadxCOMAddInModule;
    procedure Install;
    procedure Uninstall(const AExpl: _Explorer);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Groups: TadxOLBarGroups read FGroups write FGroups;
  end;

  TadxKeyboardShortcut = class(TComponent)
  private
    FOnAction: TNotifyEvent;
    FEnabled: boolean;
    FShortcutText: string;
    FSupportedApps: TadxHostAppSet;
    FOwner: TadxCOMAddInModule;
    procedure DoAction;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: boolean read FEnabled write FEnabled default True;
    property ShortcutText: string read FShortcutText write FShortcutText;
    property SupportedApps: TadxHostAppSet read FSupportedApps write FSupportedApps;
    property OnAction: TNotifyEvent read FOnAction write FOnAction;
  end;

  TadxControlAdapterClasses = array[TadxOfficeHostApp] of TadxControlAdapterClass;

  // RIBBON
  TadxRibbonCustomControl = class;
  TadxRibbonControls = class;
  TadxRibbonSeparator = class;
  TadxRibbonMenuSeparator = class;
  TadxRibbonDialogBoxLauncher = class;
  TadxRibbonItem = class;
  TadxRibbonGroup = class;
  TadxRibbonLabel = class;
  TadxRibbonButton = class;
  TadxRibbonCheckBox = class;
  TadxRibbonEditBox = class;
  TadxRibbonComboBox = class;
  TadxRibbonDropDown = class;
  TadxRibbonGallery = class;
  TadxRibbonMenu = class;
  TadxRibbonSplitButton = class;
  TadxRibbonBox = class;
  TadxRibbonButtonGroup = class;

  TadxRibbonXBoxStyle = (bsHorizontal, bsVertical);
  TadxRibbonXControlSize = (csRegular, csLarge);
  TadxRibbonXItemSize = (Normal, Large);
  TadxRibbonKeyTip = string[3];

  TadxRibbonOnClick = procedure (Sender: TObject; const RibbonControl: IRibbonControl) of object;
  TadxRibbonOnChange = procedure (Sender: TObject; const RibbonControl: IRibbonControl) of object;

  TadxRibbonActionArguments = record
    Control: IRibbonControl;
    Pressed: boolean;
    SelectedID: WideString;
    SelectedIndex: Integer;
    Cancel: boolean;
    Text: WideString;
  end;

  IadxRibbonComponent = interface
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;
  end;

  TadxRibbonCommandTarget = (Button, ToggleButton, CheckBox);
  TadxRibbonCommandAction = procedure(Sender: TObject; const Pressed: boolean; var Cancel: Boolean) of object;

  TadxRibbonCommand = class(TComponent, IadxRibbonComponent)
  private
    FOwner: TadxCOMAddInModule;
    FControlType: TadxRibbonCommandTarget;
    FEnabled: Boolean;
    FID: WideString;
    FIDMso: WideString;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    FOnAction: TadxRibbonCommandAction;
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ControlType: TadxRibbonCommandTarget read FControlType write FControlType default Button;
    property Enabled: boolean read GetEnabled write SetEnabled default True;
    property Id: WideString read GetID write SetID;
    property IdMso: WideString read GetIDMso write SetIDMso;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
    property OnAction: TadxRibbonCommandAction read FOnAction write FOnAction;
  end;

  TadxRibbonTab = class(TComponent, IadxRibbonComponent)
  private
    FImages: TCustomImageList;
    FOwner: TadxCOMAddInModule;
    FCaption: WideString;
    FContext: string;
    FControls: TadxRibbonControls;
    FID: WideString;
    FIDMso: WideString;
    FInsertAfterIdMso: WideString;
    FInsertAfterId: WideString;
    FInsertBeforeIdMso: WideString;
    FInsertBeforeId: WideString;
    FKeyTip: TadxRibbonKeyTip;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    FVisible: boolean;
    FShared: boolean;
    FOnPropertyChanging: TadxRibbonPropertyChanging;
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetGlyph: TBitmap;
    function  GetTitle: WideString;
    function  GetContent: WideString;

    procedure SetImages(Value: TCustomImageList);
    procedure SetContext(Value: string);
    procedure SetControls(Value: TadxRibbonControls);
    procedure UpdateItems;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate;
    procedure Activate;
  published
    property Caption: WideString read GetCaption write SetCaption;
    property Context: string read FContext write SetContext;
    property Controls: TadxRibbonControls read FControls write SetControls;
    property Id: WideString read GetID write SetID;
    property IdMso: WideString read GetIDMso write SetIDMso;
    property Images: TCustomImageList read FImages write SetImages;
    property InsertAfterIdMso: WideString read GetInsertAfterIdMso write SetInsertAfterIdMso;
    property InsertAfterId: WideString read GetInsertAfterId write SetInsertAfterId;
    property InsertBeforeIdMso: WideString read GetInsertBeforeIdMso write SetInsertBeforeIdMso;
    property InsertBeforeId: WideString read GetInsertBeforeId write SetInsertBeforeId;
    property KeyTip: TadxRibbonKeyTip read GetKeyTip write SetKeyTip;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
    property Shared: boolean read FShared write FShared default False;
    property Visible: boolean read GetVisible write SetVisible default True;
    property OnPropertyChanging: TadxRibbonPropertyChanging read FOnPropertyChanging write FOnPropertyChanging;
  end;

  TadxRibbonQAT = class(TComponent, IadxRibbonComponent)
  private
    FID: WideString;
    FImages: TCustomImageList;
    FOwner: TadxCOMAddInModule;
    FControlTypes: array of Integer;
    FControls: TadxRibbonControls;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    FOnPropertyChanging: TadxRibbonPropertyChanging;
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString;

    procedure SetControls(Value: TadxRibbonControls);
    procedure SetImages(Value: TCustomImageList);
    procedure UpdateItems;

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);

    property Id: WideString read GetID write SetID;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Images: TCustomImageList read FImages write SetImages;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
    property OnPropertyChanging: TadxRibbonPropertyChanging read FOnPropertyChanging write FOnPropertyChanging;
  end;

  TadxRibbonOfficeMenu = class(TComponent, IadxRibbonComponent)
  private
    FID: WideString;
    FImages: TCustomImageList;
    FOwner: TadxCOMAddInModule;
    FControlTypes: array of Integer;
    FControls: TadxRibbonControls;
    FRibbons: TadxRibbons;
    FOnPropertyChanging: TadxRibbonPropertyChanging;
    FEnabled: boolean;
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString;

    procedure SetControls(Value: TadxRibbonControls);
    procedure SetImages(Value: TCustomImageList);
    procedure UpdateItems;

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);

    property Id: WideString read GetID write SetID;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Images: TCustomImageList read FImages write SetImages;
    property Enabled: boolean read FEnabled write FEnabled default True;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property OnPropertyChanging: TadxRibbonPropertyChanging read FOnPropertyChanging write FOnPropertyChanging;
  end;

  // BACKSTAGE
  TadxBackstageTab = class;
  TadxBackstageFastCommandButton = class;
  TadxBackstageTaskFormGroup = class;
  TadxBackstageTaskFormGroupCategory = class;
  TadxBackstageTaskFormGroupTask = class;
  TadxBackstageGroup = class;
  TadxBackstageTaskGroup = class;
  TadxBackstageTaskGroupCategory = class;
  TadxBackstageTaskGroupTask = class;
  TadxBackstagePrimaryMenu = class;
  TadxBackstageSubMenu = class;
  TadxBackstageMenuGroup = class;
  TadxBackstageMenuButton = class;
  TadxBackstageMenuCheckBox = class;
  TadxBackstageMenuToggleButton = class;
  TadxBackstageRegularButton = class;
  TadxBackstageCheckBox = class;
  TadxBackstageGroupButton = class;
  TadxBackstageEditBox = class;
  TadxBackstageComboBox = class;
  TadxBackstageDropDown = class;
  TadxBackstageRadioGroup = class;
  TadxBackstageHyperlink = class;
  TadxBackstageLabelControl = class;
  TadxBackstageImageControl = class;
  TadxBackstageGroupBox = class;
  TadxBackstageLayoutContainer = class;
  TadxBackstageItem = class;

  TadxRibbonCustomControl = class(TCollectionItem, IadxRibbonComponent)
  private
    FInUse: boolean;
    FCaption: WideString;
    FDescription: WideString;
    FEnabled: boolean;
    FID: WideString;
    FIDMso: WideString;
    FImageIndex: TImageIndex;
    FImageMso: WideString;
    FInsertAfterIdMso: WideString;
    FInsertAfterId: WideString;
    FInsertBeforeIdMso: WideString;
    FInsertBeforeId: WideString;
    FItemHeight: Integer;
    FItemWidth: Integer;
    FKeyTip: TadxRibbonKeyTip;
    FPressed: boolean;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    FSelectedItemId: WideString;
    FSelectedItemIndex: Integer;
    FScreenTip: WideString;
    FShowCaption: boolean;
    FSize: TadxRibbonXControlSize;
    FSuperTip: WideString;
    FText: WideString;
    FVisible: boolean;
    FGlyph: TBitmap;
    FTitle: WideString;
    FTag: Integer;
    FOnPropertyChanging: TadxRibbonPropertyChanging;
    // Office 2010
    FTarget: WideString;
    FAltText: WideString;
    FHelperText: WideString;

    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments); virtual;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); virtual;
    function  GetXmlType: string; virtual;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; virtual;
    function  GetControls: TadxRibbonControls; virtual;
    function  GetItems: TadxRibbonControls; virtual;
    function  GetType: TadxRibbonControlType; virtual;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString; virtual;
    procedure SetTitle(Value: WideString);
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString; virtual;

    procedure GlyphChanged(Sender: TObject);

    function GetRoot: TComponent;
    function GetParentIDMso: WideString;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls; virtual;
    function  GetSecondColumn: TadxRibbonControls; virtual;
    function  GetPrimaryItem: TadxRibbonControls; virtual;
    function  GetTopItems: TadxRibbonControls; virtual;
    function  GetBottomItems: TadxRibbonControls; virtual;
    function  GetTarget: WideString; virtual;
    function  GetAltText: WideString; virtual;
    function  GetHelperText: WideString; virtual;
    function  GetGroupStyle: WideString; virtual;

    property Caption: WideString read GetCaption write SetCaption stored False;
    property Description: WideString read GetDescription write SetDescription;
    property Enabled: boolean read GetEnabled write SetEnabled default True;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Id: WideString read GetID write SetID;
    property IdMso: WideString read GetIDMso write SetIDMso;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex default -1;
    property ImageMso: WideString read GetImageMso write SetImageMso;
    property InsertAfterIdMso: WideString read GetInsertAfterIdMso write SetInsertAfterIdMso;
    property InsertAfterId: WideString read GetInsertAfterId write SetInsertAfterId;
    property InsertBeforeIdMso: WideString read GetInsertBeforeIdMso write SetInsertBeforeIdMso;
    property InsertBeforeId: WideString read GetInsertBeforeId write SetInsertBeforeId;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight default -1;
    property ItemWidth: Integer read GetItemWidth write SetItemWidth default -1;
    property KeyTip: TadxRibbonKeyTip read GetKeyTip write SetKeyTip;
    property Pressed: boolean read GetPressed write SetPressed default False;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
    property SelectedItemId: WideString read GetSelectedItemId write SetSelectedItemId;
    property SelectedItemIndex: Integer read GetSelectedItemIndex write SetSelectedItemIndex default -1;
    property ScreenTip: WideString read GetScreenTip write SetScreenTip;
    property ShowCaption: boolean read GetShowCaption write SetShowCaption default True;
    property Size: TadxRibbonXControlSize read GetSize write SetSize default csRegular;
    property SuperTip: WideString read GetSuperTip write SetSuperTip;
    property Text: WideString read GetText write SetText;
    property Title: WideString read GetTitle write SetTitle;
    property Visible: boolean read GetVisible write SetVisible default True;
    // Office 2010
    //property Target: WideString read GetTarget write FTarget;
    property AltText: WideString read GetAltText write FAltText;
    property HelperText: WideString read GetHelperText write FHelperText;

    procedure WriteCaption(Writer: TWriter);
    procedure ReadCaption(Reader: TReader);

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    { IInterface }
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Invalidate;
    function AsRibbonSeparator: TadxRibbonSeparator;
    function AsRibbonMenuSeparator: TadxRibbonMenuSeparator;
    function AsRibbonDialogBoxLauncher: TadxRibbonDialogBoxLauncher;
    function AsRibbonItem: TadxRibbonItem;
    function AsRibbonGroup: TadxRibbonGroup;
    function AsRibbonLabel: TadxRibbonLabel;
    function AsRibbonButton: TadxRibbonButton;
    function AsRibbonCheckBox: TadxRibbonCheckBox;
    function AsRibbonEditBox: TadxRibbonEditBox;
    function AsRibbonComboBox: TadxRibbonComboBox;
    function AsRibbonDropDown: TadxRibbonDropDown;
    function AsRibbonGallery: TadxRibbonGallery;
    function AsRibbonMenu: TadxRibbonMenu;
    function AsRibbonSplitButton: TadxRibbonSplitButton;
    function AsRibbonBox: TadxRibbonBox;
    function AsRibbonButtonGroup: TadxRibbonButtonGroup;
    // Backstage
    function AsBackstageTab: TadxBackstageTab;
    function AsBackstageFastCommandButton: TadxBackstageFastCommandButton;

    function AsBackstageTaskFormGroup: TadxBackstageTaskFormGroup;
    function AsBackstageTaskFormGroupCategory: TadxBackstageTaskFormGroupCategory;
    function AsBackstageTaskFormGroupTask: TadxBackstageTaskFormGroupTask;
    function AsBackstageGroup: TadxBackstageGroup;
    function AsBackstageTaskGroup: TadxBackstageTaskGroup;
    function AsBackstageTaskGroupCategory: TadxBackstageTaskGroupCategory;
    function AsBackstageTaskGroupTask: TadxBackstageTaskGroupTask;

    function AsBackstagePrimaryMenu: TadxBackstagePrimaryMenu;
    function AsBackstageSubMenu: TadxBackstageSubMenu;
    function AsBackstageMenuGroup: TadxBackstageMenuGroup;
    function AsBackstageMenuButton: TadxBackstageMenuButton;
    function AsBackstageMenuCheckBox: TadxBackstageMenuCheckBox;
    function AsBackstageMenuToggleButton: TadxBackstageMenuToggleButton;

    function AsBackstageRegularButton: TadxBackstageRegularButton;
    function AsBackstageCheckBox: TadxBackstageCheckBox;
    function AsBackstageGroupButton: TadxBackstageGroupButton;
    function AsBackstageEditBox: TadxBackstageEditBox;
    function AsBackstageComboBox: TadxBackstageComboBox;
    function AsBackstageDropDown: TadxBackstageDropDown;
    function AsBackstageRadioGroup: TadxBackstageRadioGroup;
    function AsBackstageHyperlink: TadxBackstageHyperlink;
    function AsBackstageLabelControl: TadxBackstageLabelControl;
    function AsBackstageImageControl: TadxBackstageImageControl;
    function AsBackstageGroupBox: TadxBackstageGroupBox;
    function AsBackstageLayoutContainer: TadxBackstageLayoutContainer;
    function AsBackstageItem: TadxBackstageItem;
  published
    property Tag: Integer read FTag write FTag default 0;
    property OnPropertyChanging: TadxRibbonPropertyChanging read FOnPropertyChanging write FOnPropertyChanging;
  end;

  TadxRibbonControls = class(TOwnedCollection)
  private
    FMaxCount: Integer;
    function  GetItem(Index: Integer): TadxRibbonCustomControl;
    procedure SetItem(Index: Integer; Value: TadxRibbonCustomControl);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass; MaxCount: Integer); virtual;
    procedure Assign(Source: TPersistent); override;
    function Add: TadxRibbonCustomControl; overload; virtual;
    function Add(AType: TadxRibbonControlType): TadxRibbonCustomControl; overload; virtual;
    property Items[Index: Integer]: TadxRibbonCustomControl read GetItem write SetItem; default;
  published
  end;

  TadxRibbonItems = class(TadxRibbonControls)
  private
    function  GetItem(Index: Integer): TadxRibbonItem;
    procedure SetItem(Index: Integer; Value: TadxRibbonItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass; MaxCount: Integer); override;
    procedure Assign(Source: TPersistent); override;
    function Add: TadxRibbonItem; reintroduce; overload;
    function Add(AType: TadxRibbonControlType): TadxRibbonCustomControl; override;
    property Items[Index: Integer]: TadxRibbonItem read GetItem write SetItem; default;
  published
  end;

  TadxRibbonSeparator = class(TadxRibbonCustomControl)
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Id;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Ribbons;
    property Ribbons2010;
    //property Visible; // doesn't work
  end;

  TadxRibbonMenuSeparator = class(TadxRibbonCustomControl)
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetTitle: WideString; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Caption;
    property Id;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Ribbons;
    property Ribbons2010;
  end;

  TadxRibbonDialogBoxLauncher = class(TadxRibbonCustomControl)
  private
    FOnClick: TadxRibbonOnClick;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Enabled;
    property Id;
    property IdMso;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property SuperTip;
    property Visible;
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxRibbonItem = class(TadxRibbonCustomControl)
  private
    function  GetXmlType: string; override;
    function  GetType: TadxRibbonControlType; override;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Glyph;
    property Id;
    property ImageIndex;
    property ScreenTip;
    property SuperTip;
  end;

  TadxRibbonGroup = class(TadxRibbonCustomControl)
  private
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FShared: boolean;
    FAutoScale: boolean;
    FCenterVertically: boolean;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetType: TadxRibbonControlType; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Caption;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Glyph;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property Shared: boolean read FShared write FShared default False;
    property SuperTip;
    property Visible;
    // Ribbon 2010
    property AutoScale: boolean read FAutoScale write FAutoScale default False;
    property CenterVertically: boolean read FCenterVertically write FCenterVertically default False;
  end;

  TadxRibbonLabel = class(TadxRibbonCustomControl)
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Enabled;
    property Id;
    property IdMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property ScreenTip;
    property ShowCaption;
    property SuperTip;
    property Ribbons;
    property Ribbons2010;
    property Visible;
  end;

  TadxParseMsoXmlTypeAs = (pxtDefault, pxtControl);

  TadxRibbonButton = class(TadxRibbonCustomControl)
  private
    FOnClick: TadxRibbonOnClick;
    FToggleButton: boolean;
    FParseMsoXmlTypeAs: TadxParseMsoXmlTypeAs;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Description;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property KeyTip;
    property ParseMsoXmlTypeAs: TadxParseMsoXmlTypeAs read FParseMsoXmlTypeAs write FParseMsoXmlTypeAs default pxtDefault;
    property Pressed;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property ShowCaption;
    property Size;
    property SuperTip;
    property ToggleButton: boolean read FToggleButton write FToggleButton default False;
    property Visible;
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxRibbonCheckBox = class(TadxRibbonCustomControl)
  private
    FOnClick: TadxRibbonOnClick;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Description;
    property Enabled;
    property Id;
    property IdMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property KeyTip;
    property Pressed;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property SuperTip;
    property Visible;
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxRibbonEditBox = class(TadxRibbonCustomControl)
  private
    FOnChange: TadxRibbonOnChange;
    FMaxLength: Integer;
    FSizeString: WideString;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Caption;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property KeyTip;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property ShowCaption;
    property SizeString: WideString read FSizeString write FSizeString;
    property SuperTip;
    property Text;
    property Visible;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
  end;

  TadxRibbonComboBox = class(TadxRibbonCustomControl)
  private
    FOnChange: TadxRibbonOnChange;
    FItems: TadxRibbonItems;
    FMaxLength: Integer;
    FSizeString: WideString;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetItems(const Value: TadxRibbonItems);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Caption;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Items: TadxRibbonItems read FItems write SetItems;
    property KeyTip;
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property ShowCaption;
    property SizeString: WideString read FSizeString write FSizeString;
    property SuperTip;
    property Text;
    property Visible;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxRibbonDropDown = class(TadxRibbonCustomControl)
  private
    FOnChange: TadxRibbonOnChange;
    FControls: TadxRibbonControls;
    FItems: TadxRibbonItems;
    FShowItemCaption: boolean;
    FSizeString: WideString;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetItems(const Value: TadxRibbonItems);
    procedure SetControls(const Value: TadxRibbonControls);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls;
    property Caption;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Items: TadxRibbonItems read FItems write SetItems;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property SelectedItemId;
    property SelectedItemIndex;
    property ShowCaption;
    property ShowItemCaption: boolean read FShowItemCaption write FShowItemCaption default True;
    property SizeString: WideString read FSizeString write FSizeString;
    property SuperTip;
    property Visible;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxRibbonGallery = class(TadxRibbonCustomControl)
  private
    FOnChange: TadxRibbonOnChange;
    FColumns: Integer;
    FControls: TadxRibbonControls;
    FItems: TadxRibbonItems;
    FRows: Integer;
    FShowItemCaption: boolean;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure SetItems(const Value: TadxRibbonItems);
    procedure SetColumns(const Value: Integer);
    procedure SetRows(const Value: Integer);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls;
    property Caption;
    property Columns: Integer read FColumns write SetColumns default 1;
    property Description;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property ItemHeight;
    property Items: TadxRibbonItems read FItems write SetItems;
    property ItemWidth;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property Rows: Integer read FRows write SetRows default 1;
    property ScreenTip;
    property SelectedItemId;
    property SelectedItemIndex;
    property ShowCaption;
    property ShowItemCaption: boolean read FShowItemCaption write FShowItemCaption default True;
    property Size;
    property SuperTip;
    property Visible;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxRibbonMenu = class(TadxRibbonCustomControl)
  private
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FItemSize: TadxRibbonXItemSize;
    FDynamic: boolean;
    FOnCreate: TNotifyEvent;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetContent: WideString; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
    procedure SetDynamic(Value: boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Caption;
    property Description;
    property Dynamic: boolean read FDynamic write SetDynamic default False;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property ItemSize: TadxRibbonXItemSize read FItemSize write FItemSize default Normal;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property ShowCaption;
    property Size;
    property SuperTip;
    property Title;
    property Visible;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
  end;

  TadxRibbonSplitButton = class(TadxRibbonCustomControl)
  private
    FOnClick: TadxRibbonOnClick;
    FToggleButton: boolean;
    FControls: TadxRibbonControls;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetWrappedAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetTitle: WideString; override;
    procedure SetControls(const Value: TadxRibbonControls);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls;
    property Caption;
    property Description;
    property Enabled;
    property Glyph;
    property Id;
    property IdMso;
    property ImageIndex;
    property ImageMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property KeyTip;
    property Pressed;
    property Ribbons;
    property Ribbons2010;
    property ScreenTip;
    property ShowCaption;
    property Size;
    property ToggleButton: boolean read FToggleButton write FToggleButton default False;
    property SuperTip;
    property Visible;
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxRibbonBox = class(TadxRibbonCustomControl)
  private
    FBoxStyle: TadxRibbonXBoxStyle;
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FShared: boolean;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetType: TadxRibbonControlType; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
    procedure SetBoxStyle(const Value: TadxRibbonXBoxStyle);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property BoxStyle: TadxRibbonXBoxStyle read FBoxStyle write SetBoxStyle default bsHorizontal;
    property Id;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Ribbons;
    property Ribbons2010;
    property Shared: boolean read FShared write FShared default False;
    property Visible;
  end;

  TadxRibbonButtonGroup = class(TadxRibbonCustomControl)
  private
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FShared: boolean;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetControls: TadxRibbonControls; override;
    function  GetType: TadxRibbonControlType; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Id;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property Ribbons;
    property Ribbons2010;
    property Shared: boolean read FShared write FShared default False;
    property Visible;
  end;

  // Office 2010 components

  TadxRibbonContextMenu = class(TComponent, IadxRibbonComponent)
  private
    FEnabled: boolean;
    FID: WideString;
    FContextMenuNames: TStringList;
    FImages: TCustomImageList;
    FOwner: TadxCOMAddInModule;
    FControlTypes: array of Integer;
    FControls: TadxRibbonControls;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetGlyph: TBitmap;
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetTitle: WideString;
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetContent: WideString;

    procedure SetControls(Value: TadxRibbonControls);
    procedure SetImages(Value: TCustomImageList);
    procedure UpdateItems;

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);

    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure SetContextMenuNames(Value: TStringList);
    property Id: WideString read GetID write SetID;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: boolean read FEnabled write FEnabled default True;
    property ContextMenuNames: TStringList read FContextMenuNames write SetContextMenuNames;
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    property Images: TCustomImageList read FImages write SetImages;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
  end;

  // Office 2010 Backstage
  TadxBackstageEvent = procedure(Sender: TObject; const Context: IDispatch) of object;

  TadxBackstageView = class(TComponent, IadxRibbonComponent)
  private
    FEnabled: boolean;
    FImages: TCustomImageList;
    FOwner: TadxCOMAddInModule;
    FCaption: WideString;
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FID: WideString;
    FRibbons: TadxRibbons;
    FRibbons2010: TadxRibbons2010;
    FVisible: boolean;

    FOnShow: TadxBackstageEvent;
    FOnHide: TadxBackstageEvent;

    // common methods
    procedure DoAction(var Args: TadxRibbonActionArguments);
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
    function  GetXmlType: string;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
    function  GetControls: TadxRibbonControls;
    function  GetItems: TadxRibbonControls;
    function  GetType: TadxRibbonControlType;
    // common properties
    function  GetCaption: WideString;
    procedure SetCaption(Value: WideString);
    function  GetDescription: WideString;
    procedure SetDescription(Value: WideString);
    function  GetEnabled: boolean;
    procedure SetEnabled(Value: boolean);
    function  GetID: WideString;
    procedure SetID(Value: WideString);
    function  GetIDMso: WideString;
    procedure SetIDMso(Value: WideString);
    function  GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    function  GetImageMso: WideString;
    procedure SetImageMso(Value: WideString);
    function  GetInsertAfterIdMso: WideString;
    procedure SetInsertAfterIdMso(Value: WideString);
    function  GetInsertAfterId: WideString;
    procedure SetInsertAfterId(Value: WideString);
    function  GetInsertBeforeIdMso: WideString;
    procedure SetInsertBeforeIdMso(Value: WideString);
    function  GetInsertBeforeId: WideString;
    procedure SetInsertBeforeId(Value: WideString);
    function  GetItemHeight: Integer;
    procedure SetItemHeight(Value: Integer);
    function  GetItemWidth: Integer;
    procedure SetItemWidth(Value: Integer);
    function  GetKeyTip: TadxRibbonKeyTip;
    procedure SetKeyTip(Value: TadxRibbonKeyTip);
    function  GetPressed: boolean;
    procedure SetPressed(Value: boolean);
    function  GetRibbons: TadxRibbons;
    procedure SetRibbons(Value: TadxRibbons);
    function  GetSelectedItemId: WideString;
    procedure SetSelectedItemId(Value: WideString);
    function  GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
    function  GetScreenTip: WideString;
    procedure SetScreenTip(Value: WideString);
    function  GetShowCaption: boolean;
    procedure SetShowCaption(Value: boolean);
    function  GetSize: TadxRibbonXControlSize;
    procedure SetSize(Value: TadxRibbonXControlSize);
    function  GetSuperTip: WideString;
    procedure SetSuperTip(Value: WideString);
    function  GetText: WideString;
    procedure SetText(Value: WideString);
    function  GetVisible: boolean;
    procedure SetVisible(Value: boolean);
    function  GetGlyph: TBitmap;
    function  GetTitle: WideString;
    function  GetContent: WideString;

    procedure SetImages(Value: TCustomImageList);
    procedure SetControls(const Value: TadxRibbonControls);
    procedure UpdateItems;
    // Office 2010
    function  GetRibbons2010: TadxRibbons2010;
    procedure SetRibbons2010(Value: TadxRibbons2010);
    function  GetFirstColumn: TadxRibbonControls;
    function  GetSecondColumn: TadxRibbonControls;
    function  GetPrimaryItem: TadxRibbonControls;
    function  GetTopItems: TadxRibbonControls;
    function  GetBottomItems: TadxRibbonControls;
    function  GetTarget: WideString;
    function  GetAltText: WideString;
    function  GetHelperText: WideString;
    function  GetGroupStyle: WideString;

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);

    procedure DoShow(const Context: IDispatch);
    procedure DoHide(const Context: IDispatch);

    procedure WriteRibbons(Writer: TWriter);
    procedure ReadRibbons(Reader: TReader);
    procedure WriteRibbons2010(Writer: TWriter);
    procedure ReadRibbons2010(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Visible: boolean read GetVisible;
  published
    property Id: WideString read GetID write SetID;
    property Ribbons: TadxRibbons read GetRibbons write SetRibbons stored False default
      [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
       msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
    property Ribbons2010: TadxRibbons2010 read GetRibbons2010 write SetRibbons2010 stored False default [];
    property Enabled: boolean read FEnabled write FEnabled default True;
    property Controls: TadxRibbonControls read FControls write SetControls stored False;

    property Images: TCustomImageList read FImages write SetImages;

    property OnShow: TadxBackstageEvent read FOnShow write FOnShow;
    property OnHide: TadxBackstageEvent read FOnHide write FOnHide;
  end;

  TadxBackstageTab = class(TadxRibbonCustomControl)
  private
    FFirstControlTypes: array of Integer;
    FSecondControlTypes: array of Integer;
    FFirstColumn: TadxRibbonControls;
    FSecondColumn: TadxRibbonControls;
    // 1..99
    FColumnWidthPercent: Integer;
    // 1..10000
    FFirstColumnMinWidth: Integer;
    // 1..10000
    FFirstColumnMaxWidth: Integer;
    // 1..10000
    FSecondColumnMinWidth: Integer;
    // 1..10000
    FSecondColumnMaxWidth: Integer;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetFirstColumn: TadxRibbonControls; override;
    function  GetSecondColumn: TadxRibbonControls; override;

    procedure SetFirstColumn(const Value: TadxRibbonControls);
    procedure SetSecondColumn(const Value: TadxRibbonControls);

    procedure SetColumnWidthPercent(Value: Integer);
    procedure SetFirstColumnMinWidth(Value: Integer);
    procedure SetFirstColumnMaxWidth(Value: Integer);
    procedure SetSecondColumnMinWidth(Value: Integer);
    procedure SetSecondColumnMaxWidth(Value: Integer);

    procedure WriteFirstColumnTypes(Stream: TStream);
    procedure ReadFirstColumnTypes(Stream: TStream);
    procedure WriteSecondColumnTypes(Stream: TStream);
    procedure ReadSecondColumnTypes(Stream: TStream);
    procedure WriteFirstColumnControls(Writer: TWriter);
    procedure ReadFirstColumnControls(Reader: TReader);
    procedure WriteSecondColumnControls(Writer: TWriter);
    procedure ReadSecondColumnControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Caption;
    property Enabled;
    property Id;
    property IdMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    property KeyTip;
    property Ribbons;
    property Ribbons2010;
    property Title; 
    property Visible;

    // name="taskFormGroup" type="CT_TaskFormGroup" (1) or
    // name="group" type="CT_BackstageGroup" (1000)
    // name="taskGroup" type="CT_TaskGroup"  (1000)
    property FirstColumn: TadxRibbonControls read GetFirstColumn write SetFirstColumn stored False;

    // name="group" type="CT_BackstageGroup" (1000)
    // name="taskGroup" type="CT_TaskGroup"  (1000)
    property SecondColumn: TadxRibbonControls read GetSecondColumn write SetSecondColumn stored False;

    property ColumnWidthPercent: Integer read FColumnWidthPercent write SetColumnWidthPercent default 0;
    property FirstColumnMinWidth: Integer read FFirstColumnMinWidth write SetFirstColumnMinWidth default 0;
    property FirstColumnMaxWidth: Integer read FFirstColumnMaxWidth write SetFirstColumnMaxWidth default 0;
    property SecondColumnMinWidth: Integer read FSecondColumnMinWidth write SetSecondColumnMinWidth default 0;
    property SecondColumnMaxWidth: Integer read FSecondColumnMaxWidth write SetSecondColumnMaxWidth default 0;
  end;

  TadxBackstageItem = class(TadxRibbonCustomControl) // CT_BackstageItem
  private
    function  GetXmlType: string; override;
    function  GetType: TadxRibbonControlType; override;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    // xsd:attribute name="id" type="ST_UniqueID" use="optional"
    property Id;
    // AG_Label
    property Caption;
  end;

  TadxBackstageItems = class(TadxRibbonControls)
  private
    function  GetItem(Index: Integer): TadxBackstageItem;
    procedure SetItem(Index: Integer; Value: TadxBackstageItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    procedure Assign(Source: TPersistent); override;
    function Add: TadxBackstageItem; reintroduce; overload;
    function Add(AType: TadxRibbonControlType): TadxRibbonCustomControl; override;
    property Items[Index: Integer]: TadxBackstageItem read GetItem write SetItem; default;
  published
  end;

  // AG_AlignAttributes (Attributes that specify a control's alignment.)
  TadxBackstageContentAlignmentStyle = (caTopLeft, caTopCenter, caTopRight,
    caMiddleLeft, caMiddleCenter, caMiddleRight,
    caBottomLeft, caBottomCenter, caBottomRight);

  // AG_Expand (Specifies attributes that specify how a control expands within its container)
  TadxBackstageControlExpandStyle = (ceHorizontal, ceVertical, ceBoth, ceNeither);

  TadxBackstageChildrenAlignmentStyle = (bcHorizontal, bcVertical);

  TadxBackstageEditBox = class(TadxRibbonCustomControl) //CT_BackstageEditBox
  private
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FMaxLength: Integer;
    FSizeString: WideString;
    FOnChange: TadxRibbonOnChange;

    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Ribbons;
    property Ribbons2010;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
    // xsd:attribute name="getText" type="ST_Delegate" use="optional"
    property Text;
    // xsd:attribute name="maxLength" type="ST_StringLength" use="optional"
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    // xsd:attribute name="sizeString" type="ST_String" use="optional"
    property SizeString: WideString read FSizeString write FSizeString;
    // xsd:attribute name="onChange" type="ST_Delegate" use="optional"
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
  end;

  TadxBackstageDropDown = class(TadxRibbonCustomControl) // CT_BackstageDropDown
  private
    FItems: TadxBackstageItems;
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FSizeString: WideString;
    FOnChange: TadxRibbonOnChange;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;

    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetItems(const Value: TadxBackstageItems);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // element name="item" type="CT_BackstageItem" minOccurs="0" maxOccurs="1000"
    property Items: TadxBackstageItems read FItems write SetItems;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Screentip
    property ScreenTip;
    property SuperTip;
    // AG_Keytip
    property KeyTip;
		// xsd:attribute name="sizeString" type="ST_String" use="optional"
    property SizeString: WideString read FSizeString write FSizeString;
		// xsd:attribute name="getSelectedItemIndex" type="ST_Delegate" use="optional"
    property SelectedItemIndex;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxBackstageRadioGroup = class(TadxRibbonCustomControl) // CT_RadioGroup
  private
    FItems: TadxBackstageItems;
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FOnChange: TadxRibbonOnChange;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;

    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetItems(const Value: TadxBackstageItems);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // element name="radioButton" type="CT_BackstageItem" minOccurs="0" maxOccurs="1000"
    property Items: TadxBackstageItems read FItems write SetItems;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
		// xsd:attribute name="getSelectedItemIndex" type="ST_Delegate" use="optional"
    property SelectedItemIndex;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxBackstageComboBox = class(TadxRibbonCustomControl) // CT_BackstageComboBox
  private
    FItems: TadxBackstageItems;
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FSizeString: WideString;
    FOnChange: TadxRibbonOnChange;
    FOnItemPropertyChanging: TadxRibbonItemPropertyChanging;

    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    procedure DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetItems: TadxRibbonControls; override;
    procedure SetItems(const Value: TadxBackstageItems);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // element name="item" type="CT_BackstageItem" minOccurs="0" maxOccurs="1000"
    property Items: TadxBackstageItems read FItems write SetItems;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
    // xsd:attribute name="getText" type="ST_Delegate" use="optional"
    property Text;
		// xsd:attribute name="sizeString" type="ST_String" use="optional"
    property SizeString: WideString read FSizeString write FSizeString;
    property OnChange: TadxRibbonOnChange read FOnChange write FOnChange;
    property OnItemPropertyChanging: TadxRibbonItemPropertyChanging read FOnItemPropertyChanging write FOnItemPropertyChanging;
  end;

  TadxBackstageHyperlink = class(TadxRibbonCustomControl) // CT_Hyperlink
  private
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FOnClick: TadxRibbonOnClick;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Ribbons;
    property Ribbons2010;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_Screentip
    property ScreenTip;
    property SuperTip;
    //property Target;
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxBackstageLabelControl = class(TadxRibbonCustomControl) // CT_BackstageLabelControl
  private
    FTextAlign: TadxBackstageContentAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    FWordWrap: boolean;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Ribbons;
    property Ribbons2010;
    //AG_IDCustom
    property Id;
    //AG_AlignAttributes
    property TextAlign: TadxBackstageContentAlignmentStyle read FTextAlign write FTextAlign default caTopLeft;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // xsd:attribute name="noWrap" type="xsd:boolean" use="optional"
    property WordWrap: boolean read FWordWrap write FWordWrap default True;
  end;

  TadxBackstageImageControl = class(TadxRibbonCustomControl) // CT_ImageControl
  private
    FAltText: WideString;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Ribbons;
    property Ribbons2010;
    //AG_IDCustom
    property Id;
    // AG_Enabled
    property Enabled;
    // AG_Visible
    property Visible;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_AltText
    property AltText: WideString read FAltText write FAltText;
  end;

  TadxBackstageGroupBox = class(TadxRibbonCustomControl) // CT_GroupBox
  private
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FExpand: TadxBackstageControlExpandStyle;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // xsd:group ref="EG_GroupControls" minOccurs="0" maxOccurs="1000"
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    //AG_IDCustom
    property Id;
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Label
    property Caption;
  end;

  TadxBackstageLayoutContainer = class(TadxRibbonCustomControl) // CT_LayoutContainer
  private
    FControls: TadxRibbonControls;
    FControlTypes: array of Integer;
    FChildrenAlign: TadxBackstageContentAlignmentStyle;
    FChildrenLayout: TadxBackstageChildrenAlignmentStyle;
    FExpand: TadxBackstageControlExpandStyle;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // xsd:group ref="EG_GroupControls" minOccurs="0" maxOccurs="1000"
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    //AG_IDCustom
    property Id;
    // xsd:attribute name="align" use="optional"
    // Specifies side of the layoutContainer where the children controls will be aligned.
    property ChildrenAlign: TadxBackstageContentAlignmentStyle read FChildrenAlign write FChildrenAlign default caTopLeft;
    // xsd:attribute name="layoutChildren" use="optional"
    property ChildrenLayout: TadxBackstageChildrenAlignmentStyle read FChildrenLayout write FChildrenLayout default bcVertical;
    // xsd:attribute name="expand" use="optional"
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
  end;

  TadxBackstageMenuGroup = class(TadxRibbonCustomControl) // CT_BackstageMenuGroup
  private
    FControls: TadxRibbonControls; // EG_BackstageMenuControls
    FControlTypes: array of Integer;
    FItemSize: TadxRibbonXItemSize;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);

    procedure WriteControlTypes(Stream: TStream);
    procedure ReadControlTypes(Stream: TStream);
    procedure WriteControls(Writer: TWriter);
    procedure ReadControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // xsd:group ref="EG_BackstageMenuControls" minOccurs="0" maxOccurs="1000"
    property Controls: TadxRibbonControls read FControls write SetControls stored False;
    //AG_IDCustom
    property Id;
    // AG_Label
    property Caption;
    // xsd:attribute name="itemSize" type="ST_ItemSize" use="optional"
    property ItemSize: TadxRibbonXItemSize read FItemSize write FItemSize default Normal;
  end;

  TadxBackstageMenuBase = class(TadxRibbonCustomControl) // CT_BackstageMenuBase
  private
    FControls: TadxRibbonControls; // CT_BackstageMenuGroup
    FControlTypes: array of Integer;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // name="menuGroup" type="CT_BackstageMenuGroup" 0 1000
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDCustom
    property Id;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_Keytip
    property KeyTip;
  end;

  TadxBackstagePrimaryMenu = class(TadxBackstageMenuBase) // name="menu" type="CT_BackstagePrimaryMenu"
  private
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Screentip
    property ScreenTip;
    property SuperTip;
  end;

  TadxBackstageSubMenu = class(TadxBackstageMenuBase) // name="menu" type="CT_BackstageSubMenu"
  private
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Desciption
    property Description;
  end;

  TadxBackstageCheckBoxBase = class(TadxRibbonCustomControl) // CT_BackstageCheckBoxBase
  private
    FOnClick: TadxRibbonOnClick;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
  protected
  public
  published
    property Ribbons;
    property Ribbons2010;
    // AG_IDCustom
    property Id;
    // AG_Pressed
    property Pressed;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
    // AG_Action
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxBackstageCheckBox = class(TadxBackstageCheckBoxBase) // name="checkBox" type="CT_BackstageCheckBox"
  private
    FExpand: TadxBackstageControlExpandStyle;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Description
    property Description;
    //AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_Screentip
    property ScreenTip;
    property SuperTip;
  end;

  TadxBackstageMenuCheckBox = class(TadxBackstageCheckBoxBase) // name="checkBox" type="CT_BackstageMenuCheckBox"
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Description
    property Description;
  end;

  TadxBackstageMenuToggleButton = class(TadxBackstageMenuCheckBox) // name="toggleButton" type="CT_BackstageMenuToggleButton"
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
  end;

  TadxBackstageButtonBase = class(TadxRibbonCustomControl) // CT_BackstageButtonBase
  private
    FOnClick: TadxRibbonOnClick;
    FIsDefinitive: boolean;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
  protected
  public
  published
    property Ribbons;
    property Ribbons2010;
    // AG_IDCustom
    property Id;
    // AG_Definitive
    property IsDefinitive: boolean read FIsDefinitive write FIsDefinitive default False;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Keytip
    property KeyTip;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_Action
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  TadxBackstageFastCommandButton = class(TadxBackstageButtonBase) // name="button" type="CT_BackstageFastCommandButton"
  private
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property IdMso;
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
  end;

  TadxBackstageMenuButton = class(TadxBackstageButtonBase) // name="button" type="CT_BackstageMenuButton"
  private
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Description
    property Description;
  end;

  TadxBackstageRegularButton = class(TadxBackstageButtonBase) // name="button" type="CT_BackstageRegularButton"
  private
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Screentip
    property ScreenTip;
    property SuperTip;
  end;

  TadxBackstageGroupButtonStyle = (gbsNormal, gbsBorderless, gbsLarge);

  TadxBackstageGroupButton = class(TadxBackstageRegularButton) // name="button" type="CT_BackstageGroupButton"
  private
    FExpand: TadxBackstageControlExpandStyle;
    FStyle: TadxBackstageGroupButtonStyle;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    // AG_Expand
    property Expand: TadxBackstageControlExpandStyle read FExpand write FExpand default ceNeither;
    // AG_ButtonStyle
    property Style: TadxBackstageGroupButtonStyle read FStyle write FStyle default gbsNormal;
  end;

  TadxBackstageAllowedTaskSize = (tsSmall, tsMedium, tsLarge);
  TadxBackstageAllowedTaskSizes = set of TadxBackstageAllowedTaskSize;

  TadxBackstageTaskFormGroup = class(TadxRibbonCustomControl) // name="taskFormGroup" type="CT_TaskFormGroup"
  private
    FAllowedTaskSizes: TadxBackstageAllowedTaskSizes;
    FControls: TadxRibbonControls; // CT_TaskFormGroupCategory 100
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure SetAllowedTaskSizes(Value: TadxBackstageAllowedTaskSizes);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_HelperText
    property HelperText;
    // AG_ShowLabel
    property ShowCaption;
    // <xsd:attribute name="allowedTaskSizes" type="ST_TaskSizes" use="optional" />
    property AllowedTaskSizes: TadxBackstageAllowedTaskSizes read FAllowedTaskSizes write SetAllowedTaskSizes default [tsSmall, tsMedium, tsLarge];
  end;

  TadxBackstageTaskFormGroupCategory = class(TadxRibbonCustomControl) // name="category" type="CT_TaskFormGroupCategory"
  private
    FControls: TadxRibbonControls; // CT_TaskFormGroupTask 1000
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
  end;

  TadxBackstageTaskFormGroupTask = class(TadxRibbonCustomControl) // name="task" type="CT_TaskFormGroupTask"
  private
    FControls: TadxRibbonControls; // CT_BackstageGroup 1000
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Desciption
    property Description;
    // AG_Keytip
    property KeyTip;
  end;

  TadxBackstageTaskGroup = class(TadxRibbonCustomControl) // name="taskGroup" type="CT_TaskFormGroup"
  private
    FAllowedTaskSizes: TadxBackstageAllowedTaskSizes;
    FControls: TadxRibbonControls; // CT_TaskGroupCategory 100
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
    procedure SetAllowedTaskSizes(Value: TadxBackstageAllowedTaskSizes);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_HelperText
    property HelperText;
    // AG_ShowLabel
    property ShowCaption;
    // <xsd:attribute name="allowedTaskSizes" type="ST_TaskSizes" use="optional" />
    property AllowedTaskSizes: TadxBackstageAllowedTaskSizes read FAllowedTaskSizes write SetAllowedTaskSizes default [tsSmall, tsMedium, tsLarge];
  end;

  TadxBackstageTaskGroupCategory = class(TadxRibbonCustomControl) // name="category" type="CT_TaskGroupCategory"
  private
    FControls: TadxRibbonControls; // CT_TaskGroupTask 1000
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetControls: TadxRibbonControls; override;
    procedure SetControls(const Value: TadxRibbonControls);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    property Controls: TadxRibbonControls read FControls write SetControls;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
  end;

  TadxBackstageTaskGroupTask = class(TadxRibbonCustomControl) // name="task" type="CT_TaskGroupTask"
  private
    FOnClick: TadxRibbonOnClick;
    FIsDefinitive: boolean;
    procedure DoAction(var Args: TadxRibbonActionArguments); override;
    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
  protected
  public
    constructor Create(Collection: TCollection); override;
  published
    property Ribbons;
    property Ribbons2010;
    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Definitive
    property IsDefinitive: boolean read FIsDefinitive write FIsDefinitive default False;
    // AG_Image
    property Glyph;
    property ImageIndex;
    property ImageMso;
    // AG_Enabled
    property Enabled;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_Description
    property Description;
    // AG_Keytip
    property KeyTip;
    // AG_Action
    property OnClick: TadxRibbonOnClick read FOnClick write FOnClick;
  end;

  // AG_GroupStyle
  TadxBackstageGroupStyle = (gsNormal, gsWarning, gsError);

  TadxBackstageGroup = class(TadxRibbonCustomControl) // name="group" type="CT_BackstageGroup"
  private
    FPrimaryItem: TadxRibbonControls;
    FTopItems: TadxRibbonControls;
    FBottomItems: TadxRibbonControls;
    FPrimaryItemTypes: array of Integer;
    FTopItemsTypes: array of Integer;
    FBottomItemsTypes: array of Integer;

    FStyle: TadxBackstageGroupStyle;

    function  GetXmlType: string; override;
    function  GetAttributes(ContextMenuIndex: Integer = 0): TStringList; override;
    function  GetType: TadxRibbonControlType; override;
    function  GetPrimaryItem: TadxRibbonControls; override;
    function  GetTopItems: TadxRibbonControls; override;
    function  GetBottomItems: TadxRibbonControls; override;
    function  GetGroupStyle: WideString; override;

    procedure SetPrimaryItem(const Value: TadxRibbonControls);
    procedure SetTopItems(const Value: TadxRibbonControls);
    procedure SetBottomItems(const Value: TadxRibbonControls);
    procedure SetStyle(Value: TadxBackstageGroupStyle);

    procedure WritePrimaryItemTypes(Stream: TStream);
    procedure ReadPrimaryItemTypes(Stream: TStream);
    procedure WriteTopItemsTypes(Stream: TStream);
    procedure ReadTopItemsTypes(Stream: TStream);
    procedure WriteBottomItemsTypes(Stream: TStream);
    procedure ReadBottomItemsTypes(Stream: TStream);
    procedure WritePrimaryItemControls(Writer: TWriter);
    procedure ReadPrimaryItemControls(Reader: TReader);
    procedure WriteTopItemsControls(Writer: TWriter);
    procedure ReadTopItemsControls(Reader: TReader);
    procedure WriteBottomItemsControls(Writer: TWriter);
    procedure ReadBottomItemsControls(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Ribbons;
    property Ribbons2010;
    // <xsd:element name="primaryItem" type="CT_PrimaryItem" minOccurs="0" maxOccurs="1">
    property PrimaryItem: TadxRibbonControls read GetPrimaryItem write SetPrimaryItem stored False;

    //<xsd:element name="topItems" type="CT_GroupControls" minOccurs="0" maxOccurs="1">
    property TopItems: TadxRibbonControls read GetTopItems write SetTopItems stored False;

    //<xsd:element name="bottomItems" type="CT_GroupControls" minOccurs="0" maxOccurs="1">
    property BottomItems: TadxRibbonControls read GetBottomItems write SetBottomItems stored False;

    //AG_IDAttributes
    property Id;
    property IdMso;
    // AG_PositionAttributes
    property InsertAfterIdMso;
    property InsertAfterId;
    property InsertBeforeIdMso;
    property InsertBeforeId;
    // AG_Label
    property Caption;
    // AG_Visible
    property Visible;
    // AG_GroupStyle
    property Style: TadxBackstageGroupStyle read FStyle write SetStyle default gsNormal;
    // AG_HelperText
    property HelperText;
    // AG_ShowLabel
    property ShowCaption;
  end;

  // Outlook 2010 Solutions Module
  TadxOLSolutionFolders = class;

  TadxTadxOLSolutionModuleFolderType = (sftFolderInbox, sftFolderCalendar, sftFolderContacts,
    sftFolderJournal, sftFolderNotes, sftFolderTasks, sftFolderDrafts);

  TadxOLSolutionFolder = class(TCollectionItem)
  private
    FInterface: MAPIFolder;
    FGlyph: TBitmap;
    FGlyphTransparentColor: TColor;
    FFolderName: string;
    FFolders: TadxOLSolutionFolders;
    FFolderType: TadxTadxOLSolutionModuleFolderType;
    procedure SetGlyph(const Value: TBitmap);
    function GetDefaultInterface: MAPIFolder;
    procedure SetFolders(const Value: TadxOLSolutionFolders);
    procedure Install;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property DefaultInterface: MAPIFolder read GetDefaultInterface;
  published
    property FolderName: string read FFolderName write FFolderName;
    property Folders: TadxOLSolutionFolders read FFolders write SetFolders;
    property FolderType: TadxTadxOLSolutionModuleFolderType read FFolderType write FFolderType default sftFolderInbox;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphTransparentColor: TColor read FGlyphTransparentColor write FGlyphTransparentColor default clDefault;
  end;

  TadxOLSolutionFolders = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TadxOLSolutionFolder;
    procedure SetItem(Index: Integer; Value: TadxOLSolutionFolder);
  protected
    function GetOwner: TPersistent; override;
  public
    procedure Assign(Source: TPersistent); override;
    property Items[Index: Integer]: TadxOLSolutionFolder read GetItem write SetItem; default;
  end;

  TadxOLSolutionModuleParentFolderRequest = procedure(Sender: TObject;
    var ParentFolder: Outlook2000.MAPIFolder) of object;

  TadxOLSolutionModule = class(TComponent)
  private
    FOwner: TadxCOMAddInModule;
    FParentFolder: MAPIFolder;
    FFolders: TadxOLSolutionFolders;
    FNavigationPaneDisplayedModuleCount: Integer;
    FNavigationPanePosition: Integer;
    FVisible: boolean;
    FOnParentFolderRequest: TadxOLSolutionModuleParentFolderRequest;
    procedure SetFolders(const Value: TadxOLSolutionFolders);
    procedure Install;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Folders: TadxOLSolutionFolders read FFolders write SetFolders;
    property NavigationPaneDisplayedModuleCount: Integer read FNavigationPaneDisplayedModuleCount write FNavigationPaneDisplayedModuleCount default -1;
    property NavigationPanePosition: Integer read FNavigationPanePosition write FNavigationPanePosition default -1;
    property Visible: boolean read FVisible write FVisible default True;
    property OnParentFolderRequest: TadxOLSolutionModuleParentFolderRequest read FOnParentFolderRequest write FOnParentFolderRequest;
  end;

var
  adxControlAdapterClasses: TadxControlAdapterClasses =
    (nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil);
  RegisterToHKCU: boolean = False;

function CVErr(AError: TOleEnum): OleVariant;

function  CheckConfigSection(): boolean;
procedure UpdateFactory(Factory: TComObjectFactory; Register: boolean);

implementation

uses Messages, Clipbrd, {$IFNDEF ADX_VCL5}OleServer,{$ENDIF} Dialogs, IniFiles, TypInfo, adxSmartTag;

{$IFDEF ADX_TRIAL}
{$I Trial_adx_1.inc}
{$ENDIF}

{$I ex_mapi.inc}

type
  TRegOverridePredefKey = function(AKey, ANewKey: HKEY): longint; stdcall;

const
  TMsoControls: array [TadxControlType] of TOleEnum = (msoControlButton,
    msoControlEdit, msoControlDropdown, msoControlComboBox,
    msoControlPopup, msoControlCustom, msoControlButton);

  adxOfficeProgIDs: array [TadxOfficeHostApp] of string =
    ('Excel.Application', 'Word.Application', 'Outlook.Application',
     'PowerPoint.Application', 'Access.Application', 'MSProject.Application',
     'FrontPage.Application', 'MapPoint.Application', 'Visio.Application',
     'Publisher.Application', 'InfoPath.Application');

  adxStartModeNames: array [TadxStartMode] of string =
    ('FIRSTSTART', 'NORMAL', 'UNINSTALL');

  adxAddInRegKey = '\Software\Microsoft\Office\%s\AddIns\%s';
  adxMapPointAndVisioRegKey = '\Software\Microsoft\%s\AddIns\%s';
  adxExcelAutomationAddInRegKey = '\Software\Microsoft\Office\%d.0\Excel\Options';

  { Error messages }
  adxECode = 31100;
  adxECodeCantBeEmpty = adxECode + 1;
  adxErrorCantBeEmpty = 'The %s property cannot be empty.';
  adxECodeIllegalCharacter = adxECode + 2;
  adxErrorIllegalCharacter = 'Illegal character in the %s commandbar name.';
  adxECodeCantUnregisterControls = adxECode + 3;
  adxErrorCantUnregisterControls = 'Can'#39't unregister add-in controls.';
  adxECodeUnknownCommandBar = adxECode + 4;
  adxErrorUnknownCommandBar = 'Control %s initialization is failed. Cannot find ' +
    'the %s Command Bar.';
  adxErrorCanceled = 'The registration process has been canceled.';
  adxECodeCanceled = adxECode + 5;

  adxECodeDoesntSupport = adxECode + 10;
  adxErrorDoesntSupport = 'Cannot add a control to MS MapPoint.';
  adxECodeMapPointOnly = adxECode + 11;
  adxErrorMapPointOnly = 'Only MS MapPoint supports the feature.';

  adxECodeCantContain = adxECode + 12;
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
  adxECodeTagWarning = adxECode + 13;
  adxErrorTagWarning = 'The OfficeTag property is generated automatically and will be used by' + #13#10 +
    'Add-in Express when the command bar control is refreshed. Do you want to change it?';

  adxECodeACCmdBarPosition = adxECode + 14;
  adxErrorACCmdBarPosition = 'The command bar containing a TadxCommandBarAdvancedControl cannot' + #13#10 +
    'be adxMsoBarPopup and adxMsoBarMenuBar.';
  adxECodeACCmdBarProtection = adxECode + 15;
  adxErrorACCmdBarProtection = 'The command bar containing a TadxCommandBarAdvancedControl should' + #13#10 +
    'have the adxMsoBarNoChangeDock protection type.';
  adxECodeACCantPopup = adxECode + 16;
  adxErrorACCantPopup = 'The TadxCommandBarAdvancedControl cannot be placed into the TadxCommandBarPopup control.';
  adxECodeACControlSize = adxECode + 17;
  adxErrorACControlSize = 'The size of the control is more than 600x480. It may be displayed incorrectly.';
  adxECodeACBuiltInCmdBar = adxECode + 18;
  adxErrorACBuiltInCmdBar = 'The TadxCommandBarAdvancedControl cannot be placed into the built-in commandbar.';

  adxECodeOnlyOneInstance = adxECode + 19;
  adxErrorOnlyOneInstance = 'There can be only one instance of %s in the %s!';
  adxECodeMaxNumber = adxECode + 20;
  adxErrorMaxNumber = 'There cannot be more than %d items in this control!';

  adxDefaultNS: string = 'default';
  adxSharedNS: string = 'shared';

var
  WM_ADXKEYDOWN: Cardinal;
  EventSyncFlag: boolean;

{ Utilities }

{$IFDEF ADX_DEBUG}
procedure OutputDebugString(const S: string);
begin
  Windows.OutputDebugString(PChar(S));
end;
{$ENDIF}

function AdxFindWindow(HWNDParent: HWND; WindowName: string; WindowClass: string; detail: boolean): HWND;
var
  foundWindow, tempWindow: HWND;
  lpBuffer : PChar;
  FindName, FindClass: string;
begin
  {$IFDEF UNICODE}
  GetMem(lpBuffer, MAX_PATH * SizeOf(Char));
  {$ELSE}
  GetMem(lpBuffer, 255);
  {$ENDIF}
  FoundWindow:= 0;
  FindClass:= '';
  FindName:= '';
  tempWindow:= GetWindow(HWNDParent, GW_CHILD);
  while tempWindow > 0 do begin
    if WindowName <> '' then begin
      {$IFDEF UNICODE}
      if GetWindowText(tempWindow, lpBuffer, MAX_PATH) > 0 then begin
      {$ELSE}
      if GetWindowText(tempWindow, lpBuffer, 255) > 0 then begin
      {$ENDIF}
        FindName:= StrPas(lpBuffer);
      end;
    end;

    {$IFDEF UNICODE}
    if GetClassName(tempWindow, lpBuffer, MAX_PATH) > 0 then FindClass:= StrPas(lpBuffer);
    {$ELSE}
    if GetClassName(tempWindow, lpBuffer, 255) > 0 then FindClass:= StrPas(lpBuffer);
    {$ENDIF}
    if ((pos(WindowName, FindName) > 0) or (WindowName = '')) and ((pos(WindowClass, FindClass) > 0) or (WindowClass = '')) then begin
      Result:= tempWindow;
      FoundWindow:= Result;
      break;
    end
    else if detail then begin
      Result:= AdxFindWindow(tempWindow, WindowName, WindowClass, true);
      if Result > 0 then begin
        FoundWindow:= Result;
        break;
      end;
    end;
    tempWindow:= GetWindow(tempWindow, GW_HWNDNEXT);
  end;
  Result:= FoundWindow;
  FreeMem(lpBuffer);
end;

function CVErr(AError: TOleEnum): OleVariant;
  {$IFNDEF DELPHI_7_UP}
  procedure SetVarAsError(var V: TVarData; AResult: HRESULT);
  begin
    V.VType := varError;
    V.VError := AResult;
  end;

  function VarAsError(AResult: HRESULT): Variant;
  begin
    SetVarAsError(TVarData(Result), AResult);
  end;
  {$ENDIF}
begin
  Result := VarAsError(MakeLong(AError, $800A));
end;

{$IFDEF ADX_VCL5}
function _VarIsEmpty(const V: Variant): Boolean;
begin
  Result := VarIsEmpty(V);
end;
{$ELSE}
function _VarIsEmpty(const V: Variant): Boolean;
begin
  with TVarData(V) do
    Result := (VType = varEmpty) or ((VType = varDispatch) or
      (VType = varUnknown)) and (VDispatch = nil);
end;
{$ENDIF}

function adxCreateOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
begin
  ClassID := ProgIDToClassID(ClassName);
  CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
    CLSCTX_LOCAL_SERVER, IDispatch, Result);
end;

function adxGetActiveOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
  IUnk: IUnknown;
begin
  Result := nil;
  ClassID := ProgIDToClassID(ClassName);
  GetActiveObject(ClassID, nil, IUnk);
  if Assigned(IUnk) then
    IUnk.QueryInterface(IDispatch, Result);
end;

type
  IadxButtonEvents = interface(IDispatch)
    ['{000C0351-0000-0000-C000-000000000046}']
  end;

  IadxComboBoxEvents = interface(IDispatch)
    ['{000C0354-0000-0000-C000-000000000046}']
  end;

  TadxEventSink = class(TInterfacedObject, IadxButtonEvents, IadxComboBoxEvents)
  private
    FAddInModule: TadxCOMAddInModule;
    FIControl: TadxCommandBarControl;
    FIBuiltInControl: TadxBuiltInControl;
    FCookie: Longint;
    FLocked: boolean;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  protected
    procedure Disconnect;
  public
    constructor Create(AddInModule: TadxCOMAddInModule; AControl: TadxCommandBarControl); overload;
    constructor Create(AddInModule: TadxCOMAddInModule; AControl: TadxBuiltInControl); overload;
    destructor Destroy; override;
  end;

{ TadxEventSink }

constructor TadxEventSink.Create(AddInModule: TadxCOMAddInModule; AControl: TadxCommandBarControl);
begin
  inherited Create;
  FAddInModule := AddInModule;
  FIControl := AControl;
  FIBuiltInControl := nil;
  try
    if AControl.DefaultInterface.Type_ = msoControlButton then
      InterfaceConnect(AControl.DefaultInterface, DIID__CommandBarButtonEvents, Self, FCookie)
    else
      InterfaceConnect(AControl.DefaultInterface, DIID__CommandBarComboBoxEvents, Self, FCookie);
  except
    on E:SysUtils.Exception do begin
      {$IFDEF UNICODE}
      OutputDebugString(PWideChar('TadxEventSink.Create1 error: ' + E.Message));
      {$ELSE}
      OutputDebugString(PAnsiChar('TadxEventSink.Create1 error: ' + E.Message));
      {$ENDIF}
      raise E;
    end;
  end;
end;

constructor TadxEventSink.Create(AddInModule: TadxCOMAddInModule; AControl: TadxBuiltInControl);
begin
  inherited Create;
  FAddInModule := AddInModule;
  FIControl := nil;
  FIBuiltInControl := AControl;
  try
    if AControl.DefaultInterface.Type_ = msoControlButton then
      InterfaceConnect(AControl.DefaultInterface, DIID__CommandBarButtonEvents, Self, FCookie)
    else
      InterfaceConnect(AControl.DefaultInterface, DIID__CommandBarComboBoxEvents, Self, FCookie);
  except
      on E: SysUtils.Exception do begin
        {$IFDEF UNICODE}
        OutputDebugString(PWideChar('TadxEventSink.Create2 error: ' + E.Message));
        {$ELSE}
        OutputDebugString(PAnsiChar('TadxEventSink.Create2 error: ' + E.Message));
        {$ENDIF}
        raise E;
      end;
  end;
end;

destructor TadxEventSink.Destroy;
begin
  FIControl := nil;
  FIBuiltInControl := nil;
  FAddInModule := nil;
  inherited Destroy;
end;

procedure TadxEventSink.Disconnect;
begin
  try
    if Assigned(FIControl) then begin
      if FIControl.GetType = adxButton then
        InterfaceDisconnect(TadxCommandBarButton(FIControl).DefaultInterface, DIID__CommandBarButtonEvents, FCookie)
      else
        if FIControl.GetType = adxAdvancedControl then
          InterfaceDisconnect(TadxCommandBarAdvancedControl(FIControl).DefaultInterface, DIID__CommandBarButtonEvents, FCookie)
        else
          InterfaceDisconnect(TadxCustomCommandBarComboBox(FIControl).DefaultInterface, DIID__CommandBarComboBoxEvents, FCookie);
    end
    else
    if Assigned(FIBuiltInControl) then begin
      if FIBuiltInControl.DefaultInterface.Type_ = msoControlButton then
        InterfaceDisconnect(FIBuiltInControl.DefaultInterface, DIID__CommandBarButtonEvents, FCookie)
      else
        InterfaceDisconnect(FIBuiltInControl.DefaultInterface, DIID__CommandBarComboBoxEvents, FCookie);
    end;
  except
    // Outlook 2000 bug
    // Word 2000 bug
    try
      if Assigned(FIBuiltInControl) then begin
        InterfaceDisconnect(FIBuiltInControl.DefaultInterface, DIID__CommandBarButtonEvents, FCookie);
        if FCookie <> 0 then
          InterfaceDisconnect(FIBuiltInControl.DefaultInterface, DIID__CommandBarComboBoxEvents, FCookie);
      end;    
    except
      // Delphi 5 and Delphi 6 bug
      //FIControl := nil;
      //FIBuiltInControl := nil;
      //FAddInModule := nil;
    end;
  end;
end;

function TadxEventSink.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TadxEventSink.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_FAIL;
end;

function TadxEventSink.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  {$IFDEF UNICODE}
  s: AnsiString;
  {$ELSE}
  s: string;
  {$ENDIF}
  i: integer;
begin
  Result := S_OK;
  if DispIDs = nil then Result := E_POINTER;
  if (Result = S_OK) and (Names = nil) then Result := E_POINTER;
  if (Result = S_OK) and (NameCount <> 1) then Result := E_INVALIDARG;
  if Result = S_OK then begin
    i := 512;
    SetLength(s, i);
    try
      { -oSolomenko : DEBUG with Office 2007 !!! }
      {$IFDEF UNICODE}
      WideCharToMultiByte(CP_ACP, 0, Names, -1, PAnsiChar(s), i, nil, nil);
      case FIControl.DefaultInterface.Type_ of
        msoControlButton:
          i := lstrcmpA(PAnsiChar(s), 'Click');
        msoControlEdit, msoControlComboBox, msoControlDropdown:
          i := lstrcmpA(PAnsiChar(s), 'Change');
      {$ELSE}
      WideCharToMultiByte(CP_ACP, 0, Names, -1, PChar(s), i, nil, nil);
      case FIControl.DefaultInterface.Type_ of
        msoControlButton:
          i := lstrcmp(PChar(s), 'Click');
        msoControlEdit, msoControlComboBox, msoControlDropdown:
          i := lstrcmp(PChar(s), 'Change');
      {$ENDIF}
      end;
      if i <> 0 then Result := DISP_E_UNKNOWNNAME
      else PInteger(DispIDs)^ := $00000001;
    finally
      SetLength(s, 0);
    end;
  end;
end;

{$IFDEF ADX_VCL5}
function Supports(const Instance: IUnknown; const IID: TGUID): Boolean;
var
  Temp: IUnknown;
begin
  Result := SysUtils.Supports(Instance, IID, Temp);
end;
{$ENDIF}

function TadxEventSink.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
type
  TVariantArray = array of OleVariant;
var
  FTag: WideString;
  ParamPtr: ^Integer;
  ParamCount, i: Integer;
  VarArray: TVariantArray;
  IDsp: IDispatch;
  Ctrl: CommandBarControl;
  Cancel: boolean;
  VerifyTag: boolean;
  iParent: IDispatch;
  isParentFound: boolean;

  function IsTheSameCommandBar(const AnIDispatch: IDispatch; const ACommandBar: CommandBar): boolean;
  var
    bar: CommandBar;
  begin
    Result := false;
    if Assigned(AnIDispatch) and Assigned(ACommandBar) then begin
      AnIDispatch.QueryInterface(IID_CommandBar, bar);
      if Assigned(bar) then
        Result := bar.Name = ACommandBar.Name;
      bar := nil;
    end;
  end;

// GARANT { // WORD TEMPLATES SAVED STATUS
var
  Count: Integer;
  Saved: array of WordBool;
// } GARANT // WORD TEMPLATES SAVED STATUS
begin
  Result := S_OK;
  ParamPtr := @Params;
  if DispID <> $00000001 then Result := DISP_E_MEMBERNOTFOUND;
  if (Result = S_OK) and (ParamPtr = nil) then Result := E_POINTER;
  if Result = S_OK then
// GARANT { // WORD TEMPLATES SAVED STATUS
  begin
    try
      with FAddInModule do
        if HostType = ohaWord then begin
          Count := HostApp.Templates.Count;
          //
          SetLength(Saved, Count);
          for i := 1 to Count do
            try
              Saved[Pred(i)] := HostApp.Templates.Item(i).Saved;
            except
              Count := Pred(i);
              Break;
            end;
          SetLength(Saved, Count);
        end;
    except
    end;
    try
// } GARANT // WORD TEMPLATES SAVED STATUS
    try
      ParamCount := TDispParams(Params).cArgs;
      SetLength(VarArray, ParamCount);
      for i := Low(VarArray) to High(VarArray) do
        VarArray[High(VarArray) - i] := OleVariant(TDispParams(Params).rgvarg^[i]);
      IDsp := VarArray[0];
      IDsp.QueryInterface(CommandBarControl, Ctrl);
      FTag := '';
      if Assigned(FIControl) then FTag := FIControl.FOfficeTag
      else
        if Assigned(FIBuiltInControl) then FTag := FIBuiltInControl.FOfficeTag;

      try
        VerifyTag:= (Ctrl.Tag = FTag);
      except
        VerifyTag:= true;
      end;

      if VerifyTag or Assigned(FIBuiltInControl) then
        try
          try
            // trick
            if Assigned(FIControl) then
              FIControl.DefaultInterface.Set_HelpFile(FIControl.DefaultInterface.HelpFile);
          except
            if FIControl.GetType in [adxButton, adxAdvancedControl] then
              TadxCommandBarButton(FIControl).SetInterface(Ctrl as CommandBarButton)
            else
              TadxCustomCommandBarComboBox(FIControl).SetInterface(Ctrl as CommandBarComboBox);
          end;
          if not FLocked then
            try
              FLocked := True;
              if Assigned(FIControl) then begin
                if FAddInModule.COMAddInClassFactory.FDeprecatedVersion then
                  TaxpAddIn(FAddInModule.COMAddInClassFactory.FOldAddIn).AddIn_ControlEvent(FTag, Ctrl as adxOffice.CommandBarControl)
                else
                  FIControl.DoAction;
              end;

              isParentFound := false;
              if Assigned(FIBuiltInControl) then begin
                if Assigned(FIBuiltInControl.FCommandBar) then begin
                  iParent := ctrl.Parent;
                  while iParent <> nil do begin
                    isParentFound := IsTheSameCommandBar(iParent, FIBuiltInControl.FCommandBar.FInterface);
                    if isParentFound then
                      break
                    else begin
                      try
                        iParent := OleVariant(iParent).Parent;
                        if Supports(iParent, Word2000.IID__Application) then Break;
                      except
                        break;
                      end;
                    end;
                  end;
                  iParent := nil;
                end;

                if isParentFound or not Assigned(FIBuiltInControl.FCommandBar) then begin
                  Cancel := False;
                  FIBuiltInControl.ControlInvoked:= Ctrl;
                  try
                    FIBuiltInControl.DoAction(Cancel);
                    try
                      if ParamCount > 1 then
                        for i := Low(VarArray) to High(VarArray) do
                          if TVarData(TDispParams(Params).rgvarg^[i]).VType = (varBoolean + varByRef) then
                            WordBool(TVarData(TDispParams(Params).rgvarg^[i]).VPointer^) := Cancel;
                    except
                    end;
                  finally
                    FIBuiltInControl.ControlInvoked := nil;
                  end;
                end;
              end;
            finally
              FLocked := False;
            end;
        except
          on E: SysUtils.Exception do FAddInModule.DoError(E);
        end;
    finally
      Ctrl := nil;
      IDsp := nil;
      SetLength(VarArray, 0);
    end;
// GARANT { // WORD TEMPLATES SAVED STATUS
    finally
    try
      with FAddInModule do
        if HostType = ohaWord then
          for i := 1 to Count do
            try
              HostApp.Templates.Item(i).Saved := Saved[Pred(i)];
            except
            end;
    except
    end;
    end;
  end;
// } GARANT // WORD TEMPLATES SAVED STATUS
end;

type
  IadxCommandBarsEvents = interface(IDispatch)
    ['{000C0352-0000-0000-C000-000000000046}']
  end;

  TadxCommandBarsEventSink = class(TInterfacedObject, IadxCommandBarsEvents)
  private
    FAddInModule: TadxCOMAddInModule;
    FCookie: Longint;
    FCmdBars: CommandBars;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  protected
    procedure Disconnect;
  public
    constructor Create(AddInModule: TadxCOMAddInModule; CmdBars: CommandBars);
    destructor Destroy; override;
  end;

{ TadxCommandBarsEventSink }

constructor TadxCommandBarsEventSink.Create(AddInModule: TadxCOMAddInModule; CmdBars: CommandBars);
begin
  inherited Create;
  FAddInModule := AddInModule;
  FCmdBars := CmdBars;
  InterfaceConnect(FCmdBars, DIID__CommandBarsEvents, Self, FCookie);
end;

destructor TadxCommandBarsEventSink.Destroy;
begin
  FCmdBars := nil;
  FAddInModule := nil;
  inherited Destroy;
end;

procedure TadxCommandBarsEventSink.Disconnect;
begin
  try
    InterfaceDisconnect(FCmdBars, DIID__CommandBarsEvents, FCookie);
  except
    // Outlook 2000 bug
  end;
end;

function TadxCommandBarsEventSink.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TadxCommandBarsEventSink.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_FAIL;
end;

function TadxCommandBarsEventSink.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  {$IFDEF UNICODE}
  s: AnsiString;
  {$ELSE}
  s: string;
  {$ENDIF}
  i: integer;
begin
  Result := S_OK;
  if DispIDs = nil then Result := E_POINTER;
  if (Result = S_OK) and (Names = nil) then Result := E_POINTER;
  if (Result = S_OK) and (NameCount <> 1) then Result := E_INVALIDARG;
  if Result = S_OK then begin
    i := 512;
    SetLength(s, i);
    try
      { -oSolomenko : DEBUG with Office 2007 !!! }
      {$IFDEF UNICODE}
      WideCharToMultiByte(CP_ACP, 0, Names, -1, PAnsiChar(s), i, nil, nil);
      i := lstrcmpA(PAnsiChar(s), 'OnUpdate');
      {$ELSE}
      WideCharToMultiByte(CP_ACP, 0, Names, -1, PChar(s), i, nil, nil);
      i := lstrcmp(PChar(s), 'OnUpdate');
      {$ENDIF}
      if i <> 0 then Result := DISP_E_UNKNOWNNAME
      else PInteger(DispIDs)^ := $00000001;
    finally
      SetLength(s, 0);
    end;
  end;
end;

function TadxCommandBarsEventSink.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := S_OK;
  if DispID <> $00000001 then Result := DISP_E_MEMBERNOTFOUND;
  if Result = S_OK then
    try
      FAddInModule.DoCommandBarsUpdate();
    except
    end;
end;

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
    procedure Connect; override;
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
    function Get_Class_: OlObjectClass;
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
    property Class_: OlObjectClass read Get_Class_;
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
             FOnBeforeFolderSwitch(Self, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    61444: if Assigned(FOnViewSwitch) then FOnViewSwitch(Self);
    61445: if Assigned(FOnBeforeViewSwitch) then           
             FOnBeforeViewSwitch(Self, Params[0], WordBool(TVarData(Params[1]).VBoolean));
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

function TInspector.Get_Class_: OlObjectClass;
begin
  Result := DefaultInterface.Class_;
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

type
  TSaveClipboard = class(TObject)
  private
    CF_RTF: LongWord;
    FList: TStrings;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Save;
    procedure Restore;
  end;

{ TSaveClipboard }
  
constructor TSaveClipboard.Create;
begin
  inherited Create;
  FList := TStringList.Create;
  CF_RTF := RegisterClipboardFormat('Rich Text Format');
end;

destructor TSaveClipboard.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TryOpenClipboard: boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to 100 do
    try
      Clipboard.Open;
      Result := True;
      Break;
    except
      Sleep(10);
    end;
end;

procedure TSaveClipboard.Save;
var
  i: Integer;
  PData, PStore: Pointer;
  Format: Word;
  Size: DWORD;
  Data, Store: THandle;
begin
  if TryOpenClipboard then
    try
      for i := 0 to Clipboard.FormatCount - 1 do begin
        Format := Clipboard.Formats[i];
        if Format in [CF_METAFILEPICT, CF_ENHMETAFILE, CF_BITMAP] then Continue;
        Data := Clipboard.GetAsHandle(Format);
        if Data <> 0 then begin
          Size := GlobalSize(Data);
          if Size <> 0 then begin
            PData := GlobalLock(Data);
            if PData <> nil then
              try
                Store := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, Size);
                if Store <> 0 then begin
                  PStore := GlobalLock(Store);
                  if PStore <> nil then begin
                    Move(PData^, PStore^, Size);
                    FList.AddObject(IntToStr(Format), Pointer(Store));
                    GlobalUnlock(Store);
                  end;
                end;
              finally
                GlobalUnlock(Data);
              end;
          end;
        end;
      end;
    finally
      Clipboard.Close;
    end;
end;

procedure TSaveClipboard.Restore;
var
  i: Integer;
  Format: Word;
  Data: THandle;
  DataPtr: Pointer;
begin
  if FList.Count = 0 then Exit;
  if TryOpenClipboard then
    try
      Clipboard.Clear;
      for i := 0 to FList.Count - 1 do begin
        Format := StrToInt(FList[i]);
        Data := THandle(FList.Objects[i]);
        try
          DataPtr := GlobalLock(Data);
          if DataPtr <> nil then
            try
              SetClipboardData(Format, Data);
            finally
              GlobalUnlock(Data);
            end;
        finally
          //GlobalFree(Data);
        end;
      end;
    finally
      Clipboard.Close;
      FList.Clear;
    end;
end;

{ TadxCustomCommandBar }

constructor TadxCustomCommandBar.Create(AOwner: TComponent);
var
  i, Count: Integer;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := AOwner as TadxCOMAddInModule;
  FOwner.FCommandBars.Add(Self);
  if (csDesigning in ComponentState) and (FCommandBarName = '') then begin
    Count := 0;
    for i := 0 to FOwner.ComponentCount - 1 do
      if FOwner.Components[i] is TadxCustomCommandBar then Inc(Count);
    FCommandBarName := 'Custom ' + IntToStr(Count);
  end;
  FControls := TadxCommandBarControls.Create(Self, TadxCommandBarControl);
  SetLength(FControlTypes, 0);
  FChanged := 0;
  FInterface := nil;
  FEnabled := True;
  FLeftPosition := -1;
  FPosition := adxMsoBarTop;
  FProtection := adxMsoBarNoProtection;
  FRowIndex := -1;
  FTopPosition := -1;
  FVisible := True;
  FTemporary := False;
  FSupportedApps := FOwner.FSupportedApps;
  FUseForRibbon := False;
end;

destructor TadxCustomCommandBar.Destroy;
begin
  if Assigned(FOwner) then
    FOwner.FCommandBars.Remove(Self);
  FInterface := nil;
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then
    FreeAndNil(FControls);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxCustomCommandBar.SetSupportedApps(const Value: TadxHostAppSet);
begin
  FSupportedApps := Value;
end;

procedure TadxCustomCommandBar.Changed;
begin
  if csDesigning in ComponentState then Inc(FChanged);
end;

procedure TadxCustomCommandBar.Uninstall;
var
  i: Integer;
begin
  FInterface := Owner.FindCommandBar(FCommandBarName);
  for i := Controls.Count - 1 downto 0 do begin
    if Controls[i].GetType = adxPopup then begin
      if Controls[i].FOfficeID <> 1 then begin
        Controls[i].AsPopup.SetInterface(
          Owner.FindControl(DefaultInterface, TMsoControls[Controls[i].GetType], Controls[i].FOfficeID) as CommandBarPopup);
        if Controls[i].AsPopup.DefaultInterface = nil then
          Controls[i].AsPopup.SetInterface(
            Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeID) as CommandBarPopup);
      end
      else begin
        Controls[i].AsPopup.SetInterface(
          Owner.FindControl(DefaultInterface, TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag) as CommandBarPopup);
        if Controls[i].AsPopup.DefaultInterface = nil then
          Controls[i].AsPopup.SetInterface(
            Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag) as CommandBarPopup);
      end;
    end
    else begin
      if Controls[i].FOfficeID <> 1 then begin
        if Controls[i].GetType = adxControl then
          Controls[i].FInterface := DefaultInterface.FindControl(EmptyParam, Controls[i].FOfficeID, Controls[i].FOfficeTag, EmptyParam, True)
        else
          Controls[i].SetInterface(Owner.FindControl(DefaultInterface, TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag));
      end
      else begin
        Controls[i].SetInterface(Owner.FindControl(DefaultInterface, TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag));
        if Controls[i].DefaultInterface = nil then
          Controls[i].SetInterface(Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag));
      end;
    end;
    if Assigned(Controls[i].DefaultInterface) then
      Controls[i].Delete(False);
  end;
  // GARANT // { avoiding save normal.dot dialog when uninstalling
  if FOwner.HostType = ohaWord then
    try
      FOwner.WordApp.NormalTemplate.Saved := True;
    except
    end;
  // GARANT // } avoiding save normal.dot dialog when uninstalling
  Delete;
end;

procedure TadxCustomCommandBar.ReconnectControls;

  procedure ResetInterfaces(AControls: TadxCommandBarControls);
  var
    i: Integer;
    ICtrl: CommandBarControl;
  begin
    if AControls.Count > 0 then
      ICtrl := nil;
      try
        for i := 0 to AControls.Count - 1 do begin
          AControls[i].SetInterface(ICtrl);
          if AControls[i] is TadxCommandBarPopup then
            ResetInterfaces(TadxCommandBarPopup(AControls[i]).Controls);
        end;
      except
      end;
  end;

var
  i: Integer;
  IControl: CommandBarControl;
  AdvControl: TadxCommandBarAdvancedControl;
  ControlAdded: boolean;
  OldProtection: TOleEnum;
begin         
  // Case #953
  //if Owner.HostType <> ohaOutlook then
  if (not Self.UseForRibbon) and (FOwner.FIsRibbon) then Exit;

  if (Self is TadxContextMenu) and (Owner.HostType = ohaOutlook) then begin
    if not Owner.FIsRibbon then
      FInterface := Owner.FindCommandBar(FCommandBarName);
    if FInterface = nil then Exit;
    OldProtection := FInterface.Protection;
    FInterface.Set_Protection(msoBarNoProtection);
    // Case #908
    ResetInterfaces(TadxContextMenu(Self).Controls);
    TadxContextMenu(Self).DoAddControls();
  end
  else begin
    FInterface := Owner.FindCommandBar(FCommandBarName);
    OldProtection := 0;
  end;
  {$IFDEF ADX_TRIAL}
  if Controls.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to Controls.Count - 1 do begin
  {$ENDIF}
    ControlAdded := False;
    IControl := Owner.FindControl(DefaultInterface, TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag);
    if IControl = nil then
      IControl := Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag);
    if IControl = nil then begin
      Owner.InternalAddControl(Controls[i], Self);
      ControlAdded := True;
      IControl := Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag);
      // FIX 12-Sep-2 0 0 7
      if (IControl = nil) and (Controls[i].FOfficeID <> 1) then
        IControl := Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeID);
    end;
    if Controls[i].GetType = adxPopup then begin
      TadxCommandBarPopup(Controls[i]).SetInterface(IControl as CommandBarPopup);
      TadxCommandBarPopup(Controls[i]).ReconnectControls;
    end
    else begin
      if Controls[i].GetType = adxButton then
        TadxCommandBarButton(Controls[i]).SetInterface(IControl as CommandBarButton)
      else
        if Controls[i].GetType = adxControl then
          TadxCommandBarControl(Controls[i]).SetInterface(IControl)
        else
          if Controls[i].GetType = adxAdvancedControl then begin
            if not ControlAdded then begin
              AdvControl := TadxCommandBarAdvancedControl(Controls[i]);
              if Assigned(adxControlAdapterClasses[Owner.HostType]) and Assigned(AdvControl.Control) then begin
                if not Assigned(AdvControl.FControlAdapter) then
                  AdvControl.FControlAdapter := adxControlAdapterClasses[Owner.HostType].Create(AdvControl);
                if Assigned(AdvControl.FControlAdapter) then
                  AdvControl.FInterface := AdvControl.FControlAdapter.CreateInstance;
              end;
            end;
          end
          else
            TadxCustomCommandBarComboBox(Controls[i]).SetInterface(IControl as CommandBarComboBox);
    end;
  end;
  if OldProtection <> 0 then
    FInterface.Set_Protection(OldProtection);
end;

procedure TadxCustomCommandBar.Delete;
begin
  if Assigned(DefaultInterface) then
    try
      if not DefaultInterface.BuiltIn and
        (DefaultInterface.Controls.Count = 0) then
        DefaultInterface.Delete;
    finally
      FInterface := nil;
    end;
end;

function TadxCustomCommandBar.ControlByCaption(const ACaption: WideString): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FCaption = ACaption then begin
      Result := FControls[i];
      Break;
    end;
end;

function TadxCustomCommandBar.ControlByTag(const ATag: Integer): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FTag = ATag then begin
      Result := FControls[i];
      Break;
    end;
end;

function TadxCustomCommandBar.ControlByOfficeTag(const AOfficeTag: WideString): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FOfficeTag = AOfficeTag then begin
      Result := FControls[i];
      Break;
    end;
end;

procedure TadxCustomCommandBar.SetProperties;

  function IsChanged(const RegKey: string): boolean;
  begin
    Result := True;
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        if ValueExists(FCommandBarName) then
          Result := Longword(ReadInteger(FCommandBarName)) <> Self.FChanged;
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

  procedure ApplyChanges(const RegKey: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        WriteInteger(Self.FCommandBarName, Self.FChanged);
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

var
  RegKey: string;
begin
  RegKey := Owner.RegistryKey + '\CommandBars';
  if Assigned(DefaultInterface) and (Temporary or IsChanged(RegKey) or (Owner.HostType = ohaAccess)) then begin
    SetEnabled(FEnabled);
    if FEnabled then
      SetVisible(FVisible);
    SetProtection(FProtection);
    SetPosition(FPosition);
    if FLeftPosition <> -1 then SetLeftPosition(FLeftPosition);
    if FTopPosition <> -1 then SetTopPosition(FTopPosition);
    if FRowIndex <> -1 then SetRowIndex(FRowIndex);
    if not Temporary then ApplyChanges(RegKey);
  end;
  if ((Owner.HostType = ohaWord) and UseForRibbon and Owner.FIsRibbon) then
    if FEnabled then SetVisible(FVisible);
end;

procedure TadxCustomCommandBar.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if (not (csDestroying in ComponentState)) and (Operation = opRemove) and Assigned(FControls) then
    for i := 0 to Controls.Count - 1 do
      if Controls[i] is TadxCommandBarAdvancedControl then
        if (Controls[i] as TadxCommandBarAdvancedControl).Control = AComponent then
          (Controls[i] as TadxCommandBarAdvancedControl).Control := nil;
end;

procedure TadxCustomCommandBar.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ButtonTypes', ReadControlsTypes, WriteControlsTypes, True);
  Filer.DefineProperty('Buttons', ReadControls, WriteControls, True);
  Filer.DefineProperty('PropertyChanged', ReadChanged, WriteChanged, True);
end;

function TadxCustomCommandBar.GetContext: WideString;
begin
  Result := FContext;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.Context;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetContext(const Value: WideString);
begin
  if FContext <> Value then FContext := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Context <> Value then
        DefaultInterface.Set_Context(Value);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
function TadxCustomCommandBar.GetEnabled: boolean;
{$ELSE}
function TadxCustomCommandBar.GetEnabled: WordBool;
{$ENDIF}
begin
  Result := FEnabled;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.Enabled;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
procedure TadxCustomCommandBar.SetEnabled(const Value: boolean);
{$ELSE}
procedure TadxCustomCommandBar.SetEnabled(const Value: WordBool);
{$ENDIF}
begin
  if FEnabled <> Value then FEnabled := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Enabled <> Value then
        DefaultInterface.Set_Enabled(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetHeight: SYSINT;
begin
  Result := FHeight;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.Height;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetHeight(const Value: SYSINT);
begin
  if FHeight <> Value then FHeight := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Height <> Value then
        DefaultInterface.Set_Height(Value);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetLeftPosition: SYSINT;
begin
  Result := FLeftPosition;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.Left;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetLeftPosition(const Value: SYSINT);
begin
  if FLeftPosition <> Value then FLeftPosition := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Left <> Value then
        DefaultInterface.Set_Left(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetCommandBarName: WideString;
begin
  Result := FCommandBarName;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.Name;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetCommandBarName(const Value: WideString);
begin
  if Value = '' then
    raise EADXException.Create(Format(adxErrorCantBeEmpty, ['CommandBarName']), adxECodeCantBeEmpty, 0);
  if FCommandBarName <> Value then FCommandBarName := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Name <> Value then DefaultInterface.Set_Name(Value);
    if FCommandBarNameLocal = '' then SetCommandBarNameLocal(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetCommandBarNameLocal: WideString;
begin
  Result := FCommandBarNameLocal;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.NameLocal;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetCommandBarNameLocal(const Value: WideString);
begin
  if FCommandBarNameLocal <> Value then FCommandBarNameLocal := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.NameLocal <> Value then
        DefaultInterface.Set_NameLocal(Value);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetPosition: TadxMsoBarPosition;
begin
  Result := FPosition;
  try
    if Assigned(DefaultInterface) then
      Result := TadxMsoBarPosition(DefaultInterface.Position);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetPosition(const Value: TadxMsoBarPosition);

  function IsAdvancedControl: boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to Controls.Count - 1 do
      if Controls[i] is TadxCommandBarAdvancedControl then begin
        Result := True;
        Break;
      end;
  end;

begin
  try
    if IsAdvancedControl and
      (Value in [adxMsoBarPopup, adxMsoBarMenuBar]) then
      raise EADXException.Create(adxErrorACCmdBarPosition, adxECodeACCmdBarPosition, 0);
    if FPosition <> Value then FPosition := Value;
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.Position) <> Longword(Value) then
        DefaultInterface.Set_Position(Longword(Value));
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetRowIndex: SYSINT;
begin
  Result := FRowIndex;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.RowIndex;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetRowIndex(const Value: SYSINT);
begin
  if FRowIndex <> Value then FRowIndex := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.RowIndex <> Value then
        DefaultInterface.Set_RowIndex(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetProtection: TadxMsoBarProtection;
begin
  Result := FProtection;
  try
    if Assigned(DefaultInterface) then
      case Longword(DefaultInterface.Protection) of
        $00000000: Result := adxMsoBarNoProtection;
        $00000001: Result := adxMsoBarNoCustomize;
        $00000002: Result := adxMsoBarNoResize;
        $00000004: Result := adxMsoBarNoMove;
        $00000008: Result := adxMsoBarNoChangeVisible;
        $00000010: Result := adxMsoBarNoChangeDock;
        $00000020: Result := adxMsoBarNoVerticalDock;
        $00000040: Result := adxMsoBarNoHorizontalDock;
        else
          Result := adxMsoBarNoProtection;
      end;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetProtection(const Value: TadxMsoBarProtection);

  function IsAdvancedControl: boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to Controls.Count - 1 do
      if Controls[i] is TadxCommandBarAdvancedControl then begin
        Result := True;
        Break;
      end;
  end;

const
  MsoProtectionArray: array [TadxMsoBarProtection] of Longword =
    (msoBarNoProtection, msoBarNoCustomize, msoBarNoResize, msoBarNoMove,
     msoBarNoChangeVisible, msoBarNoChangeDock, msoBarNoVerticalDock,
     msoBarNoHorizontalDock);
begin
  try
    if IsAdvancedControl and (Value <> adxMsoBarNoChangeDock) then
      raise EADXException.Create(adxErrorACCmdBarProtection, adxECodeACCmdBarProtection, 0);
    if FProtection <> Value then FProtection := Value;
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.Protection) <> Longword(MsoProtectionArray[Value]) then
        DefaultInterface.Set_Protection(Longword(MsoProtectionArray[Value]));
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetTopPosition: SYSINT;
begin
  Result := FTopPosition;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Top;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetTopPosition(const Value: SYSINT);
begin
  if FTopPosition <> Value then FTopPosition := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Top <> Value then DefaultInterface.Set_Top(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
function TadxCustomCommandBar.GetVisible: boolean;
{$ELSE}
function TadxCustomCommandBar.GetVisible: WordBool;
{$ENDIF}
begin
  Result := FVisible;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Visible;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
procedure TadxCustomCommandBar.SetVisible(const Value: boolean);
{$ELSE}
procedure TadxCustomCommandBar.SetVisible(const Value: WordBool);
{$ENDIF}
begin
  if FVisible <> Value then FVisible := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Visible <> Value then
        DefaultInterface.Set_Visible(Value);
    Changed;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetTemporary(const Value: boolean);
begin
  if FTemporary <> Value then begin
    FTemporary := Value;
    Changed;
  end;
end;

function TadxCustomCommandBar.GetWidth: SYSINT;
begin
  Result := FWidth;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Width;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetWidth(const Value: SYSINT);
begin
  if FWidth <> Value then FWidth := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Width <> Value then
        DefaultInterface.Set_Width(Value);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetAdaptiveMenu: WordBool;
begin
  Result := FAdaptiveMenu;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.AdaptiveMenu;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetAdaptiveMenu(const Value: WordBool);
begin
  if FAdaptiveMenu <> Value then FAdaptiveMenu := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.AdaptiveMenu <> Value then
        DefaultInterface.Set_AdaptiveMenu(Value);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetBuiltIn: WordBool;
begin
  Result := False;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.BuiltIn;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetIndex: SYSINT;
begin
  Result := 0;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Index;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetParent: IDispatch;
begin
  Result := nil;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Parent;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

function TadxCustomCommandBar.GetType: TadxMsoBarType;
begin
  Result := adxMsoBarTypeNormal;
  try
    if Assigned(DefaultInterface) then
      Result := TadxMsoBarType(DefaultInterface.Type_);
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBar.SetControls(const Value: TadxCommandBarControls);
begin
  FControls.Assign(Value);
  Changed;
end;

procedure TadxCustomCommandBar.WriteControlsTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxCustomCommandBar.ReadControlsTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxCustomCommandBar.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

type
  TAccessReader = class(TReader); // used for protected method access
  TAccessWriter = class(TWriter);

procedure TadxCustomCommandBar.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxCustomCommandBar.WriteChanged(Writer: TWriter);
begin
  Writer.WriteInteger(FChanged);
end;

procedure TadxCustomCommandBar.ReadChanged(Reader: TReader);
begin
  FChanged := Reader.ReadInteger;
end;

{ TadxMainMenu }

constructor TadxMainMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if ohaWord in FSupportedApps then FSupportedApp := ohaWord
  else if ohaOutlook in FSupportedApps then FSupportedApp := ohaOutlook
  else if ohaPowerPoint in FSupportedApps then FSupportedApp := ohaPowerPoint
  else if ohaAccess in FSupportedApps then FSupportedApp := ohaAccess
  else if ohaProject in FSupportedApps then FSupportedApp := ohaProject
  else if ohaFrontPage in FSupportedApps then FSupportedApp := ohaFrontPage
  else if ohaMapPoint in FSupportedApps then FSupportedApp := ohaExcel
  else if ohaVisio in FSupportedApps then FSupportedApp := ohaVisio
  else if ohaPublisher in FSupportedApps then FSupportedApp := ohaPublisher
  else if ohaInfoPath in FSupportedApps then FSupportedApp := ohaInfoPath
  else FSupportedApp := ohaExcel;
  FSupportedApps := [FSupportedApp];
  if FSupportedApp = ohaExcel then
    FCommandBarName := 'Worksheet Menu Bar'
  else
    FCommandBarName := 'Menu Bar';

  // &File  30002
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&File';
    FOfficeID := 30002;
  end;
  // &Edit  30003
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Edit';
    FOfficeID := 30003;
  end;
  // &View  30004
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&View';
    FOfficeID := 30004;
  end;
  // &Tools 30007
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Tools';
    FOfficeID := 30007;
  end;
  // &Help  30010
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Help';
    FOfficeID := 30010;
  end;
end;

procedure TadxMainMenu.SetSupportedApp(Value: TadxOfficeHostApp);
begin
  if FSupportedApp <> Value then begin
    if Value = ohaMapPoint then Exit;
    FSupportedApp := Value;
    FSupportedApps := [Value];
    if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      case FSupportedApp of
        ohaExcel: FCommandBarName := 'Worksheet Menu Bar';
        ohaWord: FCommandBarName := 'Menu Bar';
        ohaOutlook: FCommandBarName := 'Menu Bar';
        ohaPowerPoint: FCommandBarName := 'Menu Bar';
        ohaAccess: FCommandBarName := 'Menu Bar';
        ohaProject: FCommandBarName := 'Menu Bar';
        ohaFrontPage: FCommandBarName := 'Menu Bar';
        ohaVisio: FCommandBarName := 'Menu Bar';
        ohaPublisher: FCommandBarName := 'Menu Bar';
        ohaInfoPath: FCommandBarName := 'Menu Bar';
      end;
  end;
end;

{ TadxCommandBarControl }

type
  TAccessPersistent = class(TPersistent); // used for protected method access

constructor TadxCommandBarControl.Create(Collection: TCollection);
var
  ControlTag: TGUID;
  Obj: TPersistent;
begin
  inherited Create(Collection);
  FChanged := 0;
  FInterface := nil;
  FOfficeID := 1;
  FBeginGroup := False;
  FEnabled := True;
  FHeight := 0;
  FHelpContextID := 0;
  FPriority := 0;
  FVisible := True;
  FWidth := 0;
  FAfterID := 0;
  FBefore := 0;
  FBeforeID := 0;
  FTemporary := False;
  FTag := 0;
  FItemTypeAction := adxOLActionNone;
  FExplorerItemTypes := [adxOLMailItem];
  FInspectorItemTypes := [adxOLMail];
  {$IFDEF ADX_VCL5}
  CoCreateGUID(ControlTag);
  {$ELSE}
  CreateGUID(ControlTag);
  {$ENDIF}
  FOfficeTag := GUIDToString(ControlTag);
  Obj := GetOwner;
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := TAccessPersistent(Obj).GetOwner;
  if Assigned(Obj) then begin
    FCommandBar := TadxCustomCommandBar(Obj);
    if FCommandBar is TadxOLExplorerCustomCommandBar then
      FExplorerItemTypes := TadxOLExplorerCustomCommandBar(FCommandBar).ItemTypes;
    if FCommandBar is TadxOLInspectorCustomCommandBar then
      FInspectorItemTypes := TadxOLInspectorCustomCommandBar(FCommandBar).ItemTypes;
    if (FCommandBar is TadxOlExplorerMainMenu) or (FCommandBar is TadxOlInspectorMainMenu) then
      FItemTypeAction := adxOLActionShow;
  end;
  FTemporary := FCommandBar.Temporary;
end;

destructor TadxCommandBarControl.Destroy;
begin
  FInterface := nil;
  inherited Destroy;
end;

function TadxCommandBarControl.GetDisplayName: string;
begin
  Result := '(' + ClassName + ')';
  if FCaption <> '' then Result := FCaption + ' ' + Result;
end;

function TadxCommandBarControl.GetType: TadxControlType;
begin
  Result := adxControl;
end;

procedure TadxCommandBarControl.Assign(Source: TPersistent);
begin
  if Source is TadxCommandBarControl then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      Tag := TadxCommandBarControl(Source).Tag;
      BeginGroup := TadxCommandBarControl(Source).BeginGroup;
      Caption := TadxCommandBarControl(Source).Caption;
      DescriptionText := TadxCommandBarControl(Source).DescriptionText;
      Enabled := TadxCommandBarControl(Source).Enabled;
      Height := TadxCommandBarControl(Source).Height;
      HelpContextID := TadxCommandBarControl(Source).HelpContextID;
      HelpFile := TadxCommandBarControl(Source).HelpFile;
      Parameter := TadxCommandBarControl(Source).Parameter;
      Priority := TadxCommandBarControl(Source).Priority;
      OfficeTag := TadxCommandBarControl(Source).OfficeTag;
      TooltipText := TadxCommandBarControl(Source).TooltipText;
      Visible := TadxCommandBarControl(Source).Visible;
      Width := TadxCommandBarControl(Source).Width;
      Temporary := TadxCommandBarControl(Source).Temporary;
      AfterID := TadxCommandBarControl(Source).AfterID;
      Before := TadxCommandBarControl(Source).Before;
      BeforeID := TadxCommandBarControl(Source).BeforeID;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxCommandBarControl.GetAsButton: TadxCommandBarButton;
begin
  Result := nil;
  if Self is TadxCommandBarButton then
    Result := Self as TadxCommandBarButton;
end;

function TadxCommandBarControl.GetAsEdit: TadxCommandBarEdit;
begin
  Result := nil;
  if Self is TadxCommandBarEdit then
    Result := Self as TadxCommandBarEdit;
end;

function TadxCommandBarControl.GetAsDropDownList: TadxCommandBarDropDownList;
begin
  Result := nil;
  if Self is TadxCommandBarDropdownList then
    Result := Self as TadxCommandBarDropdownList;
end;

function TadxCommandBarControl.GetAsComboBox: TadxCommandBarComboBox;
begin
  Result := nil;
  if Self is TadxCommandBarComboBox then
    Result := Self as TadxCommandBarComboBox;
end;

function TadxCommandBarControl.GetAsPopup: TadxCommandBarPopup;
begin
  Result := nil;
  if Self is TadxCommandBarPopup then
    Result := Self as TadxCommandBarPopup;
end;

function TadxCommandBarControl.GetAsAdvancedControl: TadxCommandBarAdvancedControl;
begin
  Result := nil;
  if Self is TadxCommandBarAdvancedControl then
    Result := Self as TadxCommandBarAdvancedControl;
end;

procedure TadxCommandBarControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('PropertyChanged', ReadChanged, WriteChanged, True);
end;

procedure TadxCommandBarControl.ReadChanged(Reader: TReader);
begin
  FChanged := Reader.ReadInteger;
end;

procedure TadxCommandBarControl.WriteChanged(Writer: TWriter);
begin
  Writer.WriteInteger(FChanged);
end;

procedure TadxCommandBarControl.Changed;
begin
  if csDesigning in CommandBar.ComponentState then Inc(FChanged);
end;

procedure TadxCommandBarControl.Delete(Temporary: boolean);
var
  IDsp: IDispatch;
begin
  if Assigned(DefaultInterface) then
    try
      DefaultInterface.Delete(Temporary);
    finally
      IDsp := nil;
      case Self.GetType of
        adxButton: Self.AsButton.SetInterface(CommandBarButton(IDsp));
        adxEdit, adxDropdown, adxComboBox: TadxCustomCommandBarComboBox(Self).SetInterface(CommandBarComboBox(IDsp));
        adxPopup: Self.AsPopup.SetInterface(CommandBarPopup(IDsp));
        else Self.SetInterface(CommandBarControl(IDsp));
      end;
    end;
end;

procedure TadxCommandBarControl.SetInterface(const Value: CommandBarControl);
begin
  FInterface := Value;
end;

function TadxCommandBarControl.SetProperties: boolean;

  function IsChanged(const RegKey: string): boolean;
  begin
    Result := True;
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        if ValueExists(FOfficeTag) then begin
          if (Self is TadxCommandBarPopup) and (CommandBar.Owner.COMAddInClassFactory.FDeprecatedVersion) then
            Result := Longword(ReadInteger(FOfficeTag)) <> 255
          else
            Result := Longword(ReadInteger(FOfficeTag)) <> Self.FChanged;
        end;
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

var
  RegKey: string;
  ICmdBar: Office2000.CommandBar;
  ICtrl: CommandBarControl;
  ControlIndex: integer;
begin
  RegKey := CommandBar.Owner.RegistryKey + '\Controls';
  Result := Temporary or IsChanged(RegKey) or (CommandBar.Owner.HostType = ohaAccess);
  if Assigned(DefaultInterface) and Result then begin
    if not Temporary and not CommandBar.Owner.COMAddInClassFactory.FDeprecatedVersion and
      (CommandBar.Owner.StartMode <> smFirstStart) then
    begin
      if (FBefore <> 0) and (FBefore <> Self.OfficeIndex) then
        DefaultInterface.Move(EmptyParam, FBefore);
      if not CommandBar.BuiltIn and (FBefore = 0) and (FBeforeID = 0) and (FAfterID = 0) and (Index + 1 <> OfficeIndex) then
      begin
        ControlIndex := Index + 1;
        if ControlIndex > OfficeIndex then Inc(ControlIndex);
        DefaultInterface.Move(EmptyParam, ControlIndex);
      end;
      if (FBeforeID <> 0) or (FAfterID <> 0) then begin
        if TadxCommandBarControls(GetOwner).GetOwner is TadxCustomCommandBar then
          ICmdBar := TadxCustomCommandBar(TadxCommandBarControls(GetOwner).GetOwner).DefaultInterface
        else
          if TadxCommandBarControls(GetOwner).GetOwner is TadxCommandBarPopup then
            ICmdBar := TadxCommandBarPopup(TadxCommandBarControls(GetOwner).GetOwner).DefaultInterface.CommandBar
          else
            ICmdBar := nil;
        if Assigned(ICmdBar) then
          try
            if FBeforeID <> 0 then
              ICtrl := ICmdBar.FindControl(EmptyParam, FBeforeID, EmptyParam, EmptyParam, True)
            else
              ICtrl := ICmdBar.FindControl(EmptyParam, FAfterID, EmptyParam, EmptyParam, True);
            if Assigned(ICtrl) then
              if FBeforeID <> 0 then begin
                if (ICtrl.Index - 1) <> DefaultInterface.Index then
                  DefaultInterface.Move(EmptyParam, ICtrl.Index);
              end
              else begin
                if (ICtrl.Index + 1) <> DefaultInterface.Index then
                  DefaultInterface.Move(EmptyParam, ICtrl.Index + 1);
              end;
          finally
            ICtrl := nil;
            ICmdBar := nil;
          end;
      end;
    end;
    SetBeginGroup(FBeginGroup);
    SetCaption(FCaption);
    SetDescriptionText(FDescriptionText);
    SetEnabled(FEnabled);
    if FHeight <> 0 then SetHeight(FHeight);
    SetHelpContextID(FHelpContextID);
    SetHelpFile(FHelpFile);
    SetParameter(FParameter);
    SetPriority(FPriority);
    SetOfficeTag(FOfficeTag);
    SetTooltipText(FTooltipText);
    SetVisible(FVisible);
    if FWidth <> 0 then SetWidth(FWidth);
  end;
end;

procedure TadxCommandBarControl.SetIndex(Value: Integer);
var
  i: Integer;
begin
  inherited SetIndex(Value);
  for i := 0 to Collection.Count - 1 do
    TadxCommandBarControl(Collection.Items[i]).Changed;
end;

procedure TadxCommandBarControl.SetAfterID(const Value: Integer);
begin
  FAfterID := Value;
  Changed;
end;

procedure TadxCommandBarControl.SetBefore(const Value: Integer);
begin
  FBefore := Value;
  Changed;
end;

procedure TadxCommandBarControl.SetBeforeID(const Value: Integer);
begin
  FBeforeID := Value;
  Changed;
end;
{$IFDEF DELPHI_15_UP}
function TadxCommandBarControl.GetBeginGroup: boolean;
{$ELSE}
function TadxCommandBarControl.GetBeginGroup: WordBool;
{$ENDIF}
begin
  Result := FBeginGroup;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.BeginGroup;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
procedure TadxCommandBarControl.SetBeginGroup(const Value: boolean);
{$ELSE}
procedure TadxCommandBarControl.SetBeginGroup(const Value: WordBool);
{$ENDIF}
begin
  if FBeginGroup <> Value then FBeginGroup := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.BeginGroup <> Value then
        DefaultInterface.Set_BeginGroup(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetCaption: WideString;
begin
  Result := FCaption;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Caption;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetCaption(const Value: WideString);
begin
  if FCaption <> Value then FCaption := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Caption <> Value then
        DefaultInterface.Set_Caption(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetDescriptionText: WideString;
begin
  Result := FDescriptionText;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.DescriptionText;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetDescriptionText(const Value: WideString);
begin
  if FDescriptionText <> Value then FDescriptionText := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.DescriptionText <> Value then
        DefaultInterface.Set_DescriptionText(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
function TadxCommandBarControl.GetEnabled: boolean;
{$ELSE}
function TadxCommandBarControl.GetEnabled: WordBool;
{$ENDIF}
begin
  Result := FEnabled;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Enabled;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
procedure TadxCommandBarControl.SetEnabled(const Value: boolean);
{$ELSE}
procedure TadxCommandBarControl.SetEnabled(const Value: WordBool);
{$ENDIF}
begin
  if FEnabled <> Value then FEnabled := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Enabled <> Value then begin
        DefaultInterface.Set_Enabled(Value);
        // Outlook command bar bug
        if (CommandBar.Owner.HostType = ohaOutlook) then begin
          DefaultInterface.Set_Width(DefaultInterface.Width + 1);
          DefaultInterface.Set_Width(DefaultInterface.Width - 1);
        end;
      end;
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetHeight: SYSINT;
begin
  Result := FHeight;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Height;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetHeight(const Value: SYSINT);
begin
  if FHeight <> Value then FHeight := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Height <> Value then
        DefaultInterface.Set_Height(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetHelpContextID: SYSINT;
begin
  Result := FHelpContextID;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.HelpContextId;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetHelpContextID(const Value: SYSINT);
begin
  if FHelpContextID <> Value then FHelpContextID := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.HelpContextId <> Value then
        DefaultInterface.Set_HelpContextId(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetHelpFile: WideString;
begin
  Result := FHelpFile;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.HelpFile;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetHelpFile(const Value: WideString);
begin
  if FHelpFile <> Value then FHelpFile := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.HelpFile <> Value then
        DefaultInterface.Set_HelpFile(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetOnAction: WideString;
begin
  Result := FOnAction;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.OnAction;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetOnAction(const Value: WideString);
begin
  if FOnAction <> Value then FOnAction := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.OnAction <> Value then
        DefaultInterface.Set_OnAction(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetParameter: WideString;
begin
  Result := FParameter;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Parameter;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetParameter(const Value: WideString);
begin
  if FParameter <> Value then FParameter := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Parameter <> Value then
        DefaultInterface.Set_Parameter(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetPriority: SYSINT;
begin
  Result := FPriority;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Priority;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetPriority(const Value: SYSINT);
begin
  if FPriority <> Value then FPriority := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Priority <> Value then
        DefaultInterface.Set_Priority(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetOfficeTag: WideString;
begin
  Result := FOfficeTag;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Tag;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetOfficeTag(const Value: WideString);
begin
  if (csDesigning in CommandBar.ComponentState) and not (csReading in CommandBar.ComponentState) then
    if MessageDlg(adxErrorTagWarning, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  if FOfficeTag <> Value then FOfficeTag := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Tag <> Value then DefaultInterface.Set_Tag(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetTooltipText: WideString;
begin
  Result := FTooltipText;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.TooltipText;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetTooltipText(const Value: WideString);
begin
  if FTooltipText <> Value then FTooltipText := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.TooltipText <> Value then
        DefaultInterface.Set_TooltipText(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
function TadxCommandBarControl.GetVisible: boolean;
{$ELSE}
function TadxCommandBarControl.GetVisible: WordBool;
{$ENDIF}
begin
  Result := FVisible;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Visible;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{$IFDEF DELPHI_15_UP}
procedure TadxCommandBarControl.SetVisible(const Value: boolean);
{$ELSE}
procedure TadxCommandBarControl.SetVisible(const Value: WordBool);
{$ENDIF}
begin
  if FVisible <> Value then FVisible := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Visible <> Value then
        DefaultInterface.Set_Visible(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetWidth: SYSINT;
begin
  Result := FWidth;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Width;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetWidth(const Value: SYSINT);
begin
  if FWidth <> Value then FWidth := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Width <> Value then
        DefaultInterface.Set_Width(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetBuiltIn: WordBool;
begin
  Result := False;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.BuiltIn;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetOfficeID: SYSINT;
begin
  Result := FOfficeID;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Id;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetOfficeID(const Value: SYSINT);
begin
  if (Self.FCommandBar <> nil) and
    (csDesigning in Self.FCommandBar.ComponentState) and
    not (csLoading in Self.FCommandBar.ComponentState) then
  begin
    if (Self.FCommandBar is TadxMainMenu) or
      (Self.FCommandBar is TadxOlExplorerMainMenu) or
      (Self.FCommandBar is TadxOlInspectorMainMenu) then
    begin
      case Value of
        30002: FCaption := '&File';
        30003: FCaption := '&Edit';
        30004: FCaption := '&View';
        30005: FCaption := '&Insert';
        30006: FCaption := 'F&ormat';
        30007: FCaption := '&Tools';
        30010: FCaption := '&Help';
      end;
    end;
  end;
  FOfficeID := Value;
  Changed;
end;

function TadxCommandBarControl.GetOfficeIndex: SYSINT;
begin
  Result := 1;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Index;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetLeft: SYSINT;
begin
  Result := -1;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Left;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetOLEUsage: MsoControlOLEUsage;
begin
  Result := msoControlOLEUsageNeither;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.OLEUsage;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetOLEUsage(const Value: MsoControlOLEUsage);
begin
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.OLEUsage <> Value then
        DefaultInterface.Set_OLEUsage(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarControl.SetTemporary(const Value: boolean);
begin
  if FTemporary <> Value then begin
    FTemporary := Value;
    Changed;
  end;
end;

function TadxCommandBarControl.GetParent: CommandBar;
begin
  Result := nil;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Parent;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetTop: SYSINT;
begin
  Result := -1;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Top;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetType_: MsoControlType;
begin
  Result := msoControlCustom;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Type_;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarControl.GetIsPriorityDropped: WordBool;
begin
  Result := False;
  try
    if Assigned(DefaultInterface) then
      Result := DefaultInterface.IsPriorityDropped;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{ TadxCommandBarControls }

procedure TadxCommandBarControls.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxCommandBarControls then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TadxCommandBarControls(Source).Count - 1 do
        Add(TadxCommandBarControls(Source)[i].GetType).Assign(TadxCommandBarControls(Source)[i]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxCommandBarControls.Add(AType: TadxControlType): TadxCommandBarControl;
const
  ClassTypes: array [TadxControlType] of TCollectionItemClass = (TadxCommandBarButton,
    TadxCommandBarEdit, TadxCommandBarDropdownList, TadxCommandBarCombobox,
    TadxCommandBarPopup, TadxCommandBarControl, TadxCommandBarAdvancedControl);
begin
  if AType = adxAdvancedControl then begin
    if GetOwner is TadxCommandBarPopup then
      raise EADXException.Create(adxErrorACCantPopup, adxECodeACCantPopup, 0);
    if (Self.GetOwner as TadxCustomCommandBar).Position in [adxMsoBarPopup, adxMsoBarMenuBar] then
      (Self.GetOwner as TadxCustomCommandBar).Position := adxMsoBarTop;
    if (Self.GetOwner as TadxCustomCommandBar).Protection <> adxMsoBarNoChangeDock then
      (Self.GetOwner as TadxCustomCommandBar).Protection := adxMsoBarNoChangeDock;
  end;
  Result := TadxCommandBarControl(ClassTypes[AType].Create(Self));
end;

function TadxCommandBarControls.Add(AType: TadxControlType; const ATag: WideString;
  ABefore: Integer; ATemporary: boolean): TadxCommandBarControl;

{$IFNDEF ADX_TRIAL}
  function IfThen(AValue: boolean; ATrue, AFalse: OleVariant): OleVariant;
  begin
    if AValue then Result := ATrue
    else Result := AFalse;
  end;

var
  IControls: CommandBarControls;
  Module: TadxCOMAddInModule;
{$ENDIF}
begin
{$IFDEF ADX_TRIAL}
  Result := nil;
{$ELSE}
  Module := nil;
  IControls := nil;
  // add-in express 1.x compatibility
  if ABefore = -1 then ABefore := 0;
  Result := Add(AType);
  Result.FOfficeTag := ATag;
  Result.Before := ABefore;
  Result.Temporary := ATemporary;
  if GetOwner is TadxCustomCommandBar then begin
    Module := TadxCustomCommandBar(GetOwner).Owner;
    if TadxCustomCommandBar(GetOwner).DefaultInterface = nil then
      TadxCustomCommandBar(GetOwner).FInterface := Module.FindCommandBar(TadxCustomCommandBar(GetOwner).CommandBarName);
    if Assigned(TadxCustomCommandBar(GetOwner).DefaultInterface) then
      IControls := TadxCustomCommandBar(GetOwner).DefaultInterface.Controls;
  end;
  if GetOwner is TadxCommandBarPopup then begin
    Module := TadxCommandBarPopup(GetOwner).CommandBar.Owner;
    if Assigned(TadxCommandBarPopup(GetOwner).DefaultInterface) then
      IControls := TadxCommandBarPopup(GetOwner).DefaultInterface.Controls;
  end;
  if Assigned(IControls) then
    try
      case AType of
        adxButton:
          begin
            TadxCommandBarButton(Result).SetInterface(Module.FindControl(msoControlButton, ATag) as CommandBarButton);
            if Result.DefaultInterface = nil then begin
              TadxCommandBarButton(Result).SetInterface(
                IControls.Add(msoControlButton, EmptyParam, EmptyParam, IfThen(ABefore = 0, EmptyParam, ABefore), ATemporary) as CommandBarButton);
              Result.OfficeTag := ATag;
              TadxCommandBarButton(Result).SetProperties;
            end;
          end;
        adxEdit:
          begin
            TadxCommandBarEdit(Result).SetInterface(Module.FindControl(msoControlEdit, ATag) as CommandBarComboBox);
            if Result.DefaultInterface = nil then begin
              TadxCommandBarEdit(Result).SetInterface(
                IControls.Add(msoControlEdit, EmptyParam, EmptyParam, IfThen(ABefore = 0, EmptyParam, ABefore), ATemporary) as CommandBarComboBox);
              Result.OfficeTag := ATag;
              TadxCommandBarEdit(Result).SetProperties;
            end;
          end;
        adxDropdown:
          begin
            TadxCommandBarDropdownList(Result).SetInterface(Module.FindControl(msoControlDropdown, ATag) as CommandBarComboBox);
            if Result.DefaultInterface = nil then begin
              TadxCommandBarDropdownList(Result).SetInterface(
                IControls.Add(msoControlDropdown, EmptyParam, EmptyParam, IfThen(ABefore = 0, EmptyParam, ABefore), ATemporary) as CommandBarComboBox);
              Result.OfficeTag := ATag;
              TadxCommandBarDropdownList(Result).SetProperties;
            end;
          end;
        adxComboBox:
          begin
            TadxCommandBarComboBox(Result).SetInterface(Module.FindControl(msoControlComboBox, ATag) as CommandBarComboBox);
            if Result.DefaultInterface = nil then begin
              TadxCommandBarComboBox(Result).SetInterface(
                IControls.Add(msoControlComboBox, EmptyParam, EmptyParam, IfThen(ABefore = 0, EmptyParam, ABefore), ATemporary) as CommandBarComboBox);
              Result.OfficeTag := ATag;
              TadxCommandBarComboBox(Result).SetProperties;
            end;
          end;
        adxPopup:
          begin
            TadxCommandBarPopup(Result).SetInterface(Module.FindControl(msoControlPopup, ATag) as CommandBarPopup);
            if Result.DefaultInterface = nil then begin
              TadxCommandBarPopup(Result).SetInterface(
                IControls.Add(msoControlPopup, EmptyParam, EmptyParam, IfThen(ABefore = 0, EmptyParam, ABefore), ATemporary) as CommandBarPopup);
              Result.OfficeTag := ATag;
              TadxCommandBarPopup(Result).SetProperties;
            end;
          end;
      else
        Result.OfficeTag := ATag;
      end;
    finally
      IControls := nil;
    end;
{$ENDIF}
end;

function TadxCommandBarControls.ItemByTag(const ATag: Integer): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].Tag = ATag then begin
      Result := Items[i];
      Break;
    end;
end;

procedure TadxCommandBarControls.DeleteControl(Index: Integer; Temporary: boolean);
begin
  Items[Index].Delete(Temporary);
  Delete(Index);
end;

function TadxCommandBarControls.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxCommandBarControls.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'Type';
    2: Result := 'Caption';
  else
    Result := '';
  end;
end;

function TadxCommandBarControls.GetItemAttr(Index, ItemIndex: Integer): string;
const
  StringControls: array [TadxControlType] of string = ('Button', 'Edit',
    'DropdownList', 'ComboBox', 'Popup', 'Control', 'Advanced Control');
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].GetDisplayName;
    1: Result := StringControls[Items[ItemIndex].GetType];
    2: Result := Items[ItemIndex].Caption;
  else
    Result := '';
  end;
end;

function TadxCommandBarControls.GetItem(Index: Integer): TadxCommandBarControl;
begin
  Result := TadxCommandBarControl(inherited Items[Index]);
end;

procedure TadxCommandBarControls.SetItem(Index: Integer; Value: TadxCommandBarControl);
begin
  inherited Items[Index] := Value;
end;

{ TadxAbstractControlController }

constructor TadxAbstractControlAdapter.Create(AOwner: TadxCommandBarAdvancedControl);
begin
  inherited Create;
  FOwner := AOwner;
end;

{ TadxCommandBarAdvancedControl }

constructor TadxCommandBarAdvancedControl.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if Assigned(adxControlAdapterClasses[CommandBar.Owner.HostType]) then
    FControlAdapter := adxControlAdapterClasses[CommandBar.Owner.HostType].Create(Self);
end;

destructor TadxCommandBarAdvancedControl.Destroy;
begin
  if Assigned(FControlAdapter) then
    FreeAndNil(FControlAdapter);
  inherited Destroy;
end;

procedure TadxCommandBarAdvancedControl.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCommandBarAdvancedControl then
    FControl := TadxCommandBarAdvancedControl(Source).Control;
end;

function TadxCommandBarAdvancedControl.GetBuiltIn: WordBool;
begin
  Result := False;
end;

function TadxCommandBarAdvancedControl.GetOLEUsage: MsoControlOLEUsage;
begin
  Result := msoControlOLEUsageNeither;
end;

procedure TadxCommandBarAdvancedControl.SetOLEUsage(const Value: MsoControlOLEUsage);
begin
end;

function TadxCommandBarAdvancedControl.GetType_: MsoControlType;
begin
  Result := msoControlCustom;
end;

function TadxCommandBarAdvancedControl.GetOnAction: WideString;
begin
  Result := '';
end;

procedure TadxCommandBarAdvancedControl.SetOnAction(const Value: WideString);
begin
end;

function TadxCommandBarAdvancedControl.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxCommandBarAdvancedControl.SetCaption(const Value: WideString);
begin
end;

function TadxCommandBarAdvancedControl.GetHelpContextID: SYSINT;
begin
  Result := 0;
end;

procedure TadxCommandBarAdvancedControl.SetHelpContextID(const Value: SYSINT);
begin
end;

function TadxCommandBarAdvancedControl.GetHelpFile: WideString;
begin
  Result := '';
end;

procedure TadxCommandBarAdvancedControl.SetHelpFile(const Value: WideString);
begin
end;

function TadxCommandBarAdvancedControl.GetOfficeID: SYSINT;
begin
  Result := 1;
end;

procedure TadxCommandBarAdvancedControl.SetOfficeID(const Value: SYSINT);
begin
end;

function TadxCommandBarAdvancedControl.GetTooltipText: WideString;
begin
  Result := '';
end;

procedure TadxCommandBarAdvancedControl.SetTooltipText(const Value: WideString);
begin
end;

procedure TadxCommandBarAdvancedControl.Delete(Temporary: boolean);
begin
  if Assigned(FControlAdapter) then
    FreeAndNil(FControlAdapter);
  inherited Delete(Temporary);
end;

function TadxCommandBarAdvancedControl.GetType: TadxControlType;
begin
  Result := adxAdvancedControl;
end;

function TadxCommandBarAdvancedControl.GetActiveInstance: TControl;
begin
  Result := nil;
  if Assigned(FControlAdapter) then
    Result := FControlAdapter.GetActiveInstance;
end;

procedure TadxCommandBarAdvancedControl.SetControl(const Value: TControl);
var
  NeedCreateInstance: boolean;
begin
  if (csDesigning in CommandBar.ComponentState) and Assigned(Value) then
    if (Value.Width > 600) or (Value.Height > 480) then
      MessageDlg(adxErrorACControlSize, mtInformation, [mbOK], 0);

  NeedCreateInstance := not (csDesigning in CommandBar.ComponentState) and
    (FControl = nil) and Assigned(Value) and Assigned(FControlAdapter);
  FControl := Value;
  if FControl <> nil then
    FControl.FreeNotification(Self.CommandBar);
  if NeedCreateInstance then begin
    FInterface := FControlAdapter.CreateInstance;
    FInterface.Set_Tag(FOfficeTag);
  end;
end;

{ TCommandBarButton }

constructor TadxCommandBarButton.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDisableStandardAction := False;
  FBuiltInFace := True;
  FInterface := nil;
  FGlyph := TBitmap.Create;
  FGlyphTransparentColor := clDefault;
  FFaceID := 0;
  FState := adxMsoButtonUp;
  FStyle := adxMsoButtonAutomatic;
  FHyperlinkType := adxMsoCommandBarButtonHyperlinkNone;
end;

destructor TadxCommandBarButton.Destroy;
begin
  if Assigned(FEventSink) then begin
    TadxEventSink(FEventSink).Disconnect;
    FEventSink := nil;
  end;
  FInterface := nil;
  FGlyph.Free;
  inherited Destroy;
end;

procedure TadxCommandBarButton.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCommandBarButton then begin
    FaceID := TadxCommandBarButton(Source).FaceID;
    ShortcutText := TadxCommandBarButton(Source).ShortcutText;
    State := TadxCommandBarButton(Source).State;
    Style := TadxCommandBarButton(Source).Style;
    HyperlinkType := TadxCommandBarButton(Source).HyperlinkType;
    Glyph := TadxCommandBarButton(Source).Glyph;
    GlyphTransparentColor := TadxCommandBarButton(Source).GlyphTransparentColor;
  end;
end;

function TadxCommandBarButton.GetType: TadxControlType;
begin
  Result := adxButton;
end;

procedure TadxCommandBarButton.SetInterface(const Value: CommandBarButton);
var
  Index: Integer;
begin
  inherited SetInterface(Value as CommandBarControl);
  if FInterface <> nil then begin
    Index := CommandBar.Owner.FSinkList.IndexOf(FEventSink);
    TadxEventSink(FEventSink).Disconnect;
    if Index > -1 then
      CommandBar.Owner.FSinkList.Delete(Index);
    FEventSink := nil;
  end;
  FInterface := Value;
  if FInterface <> nil then begin
    FEventSink := TadxEventSink.Create(CommandBar.Owner, Self);
    CommandBar.Owner.FSinkList.Add(FEventSink);
  end;
end;

procedure TadxCommandBarButton.DoAction;
begin
  if not FButtonInUse then begin
    FButtonInUse := True;
    try
      if Assigned(FOnClick) then FOnClick(Self);
    finally
      FButtonInUse := False;
    end;
  end;
end;

type
  _CommandBarButtonXP = interface(CommandBarControl)
    ['{000C030E-0000-0000-C000-000000000046}']
    function Get_BuiltInFace: WordBool; safecall;
    procedure Set_BuiltInFace(pvarfBuiltIn: WordBool); safecall;
    procedure CopyFace; safecall;
    function Get_FaceId: SYSINT; safecall;
    procedure Set_FaceId(pid: SYSINT); safecall;
    procedure PasteFace; safecall;
    function Get_ShortcutText: WideString; safecall;
    procedure Set_ShortcutText(const pbstrText: WideString); safecall;
    function Get_State: MsoButtonState; safecall;
    procedure Set_State(pstate: MsoButtonState); safecall;
    function Get_Style: MsoButtonStyle; safecall;
    procedure Set_Style(pstyle: MsoButtonStyle); safecall;
    function Get_HyperlinkType: MsoCommandBarButtonHyperlinkType; safecall;
    procedure Set_HyperlinkType(phlType: MsoCommandBarButtonHyperlinkType); safecall;
    function Get_Picture: IPictureDisp; safecall;
    procedure Set_Picture(const ppdispPicture: IPictureDisp); safecall;
    function Get_Mask: IPictureDisp; safecall;
    procedure Set_Mask(const ppipictdispMask: IPictureDisp); safecall;
    property BuiltInFace: WordBool read Get_BuiltInFace;
    property FaceId: SYSINT read Get_FaceId;
    property ShortcutText: WideString read Get_ShortcutText;
    property State: MsoButtonState read Get_State;
    property Style: MsoButtonStyle read Get_Style;
    property HyperlinkType: MsoCommandBarButtonHyperlinkType read Get_HyperlinkType;
    property Picture: IPictureDisp read Get_Picture;
    property Mask: IPictureDisp read Get_Mask;
  end;

function TadxCommandBarButton.SetProperties: boolean;

  procedure ApplyChanges(const RegKey: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        WriteInteger(Self.FOfficeTag, Self.FChanged);
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

var
  i: Integer;
  S: TSaveClipboard;
  Bmp: TBitmap;
  IsOffice2000: boolean;
  Button: _CommandBarButtonXP;
  Pict, Mask: IPictureDisp;
  PictureDesc: TPictDesc;
begin
  Result := inherited SetProperties;
  if Assigned(DefaultInterface) and Result then begin
    if FFaceID <> 0 then SetFaceID(FFaceID);
    SetShortcutText(FShortcutText);
    SetState(FState);
    SetStyle(FStyle);
    SetHyperlinkType(HyperlinkType);
    if not FGlyph.Empty then begin
      IsOffice2000 := False;
      try
        {$IFDEF UNICODE}
        IsOffice2000 := Pos(WideString('9.0'), Self.CommandBar.Owner.FIApp.Version) = 1;
        {$ELSE}
        IsOffice2000 := Pos('9.0', Self.CommandBar.Owner.FIApp.Version) = 1;
        {$ENDIF}
      except
      end;
      if not IsOffice2000 then
      try
        Button := DefaultInterface as _CommandBarButtonXP;
        try
          Pict := Button.Picture;
          Pict := nil;
          FGlyph.TransparentColor := GlyphTransparentColor;
          PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
          PictureDesc.picType := PICTYPE_BITMAP;
          PictureDesc.hbitmap := FGlyph.Handle;
          PictureDesc.hpal := FGlyph.Palette;
          OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, Pict);
          Button.Set_Picture(Pict);
          PictureDesc.hbitmap := FGlyph.MaskHandle;
          PictureDesc.hpal := FGlyph.Palette;
          OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, Mask);
          Button.Set_Mask(Mask);
        finally
          Pict := nil;
          Mask := nil;
          Button := nil;
        end;
      except
        IsOffice2000 := True;
      end;
      if IsOffice2000 then
        try
          S := TSaveClipboard.Create;
          S.Save;
          try
            Bmp := TBitmap.Create;
            try
              Bmp.Width := FGlyph.Width;
              Bmp.Height := FGlyph.Height;
              Bmp.Canvas.Brush.Color := clBtnFace;
              Bmp.Canvas.Lock;
              try
                if GlyphTransparentColor = clDefault then
                  Bmp.Canvas.BrushCopy(Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph,
                    Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph.Canvas.Pixels[0, FGlyph.Height - 1])
                else
                  Bmp.Canvas.BrushCopy(Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph,
                    Rect(0, 0, Bmp.Width, Bmp.Height), GlyphTransparentColor);
              finally
                Bmp.Canvas.Unlock;
              end;
              if TryOpenClipboard then begin
                try
                  Clipboard.Assign(Bmp);
                finally
                  Clipboard.Close;
                end;
                for i := 0 to 10 do
                  try
                    DefaultInterface.PasteFace;
                    Break;
                  except
                    Sleep(10);
                  end;
              end;
            finally
              Bmp.Free;
            end;
          finally
            S.Restore;
            S.Free;
          end;
        except
          on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
        end;
    end;
    if not Temporary then
      ApplyChanges(CommandBar.Owner.RegistryKey + '\Controls');
  end;
end;

procedure TadxCommandBarButton.SetGlyph(const Value: TBitmap);
var
  i: Integer;
  S: TSaveClipboard;
  Bmp: TBitmap;
  IsOffice2000: boolean;
  Button: _CommandBarButtonXP;
  Pict, Mask: IPictureDisp;
  PictureDesc: TPictDesc;
begin
  FGlyph.Assign(Value);
  Changed;
  if Assigned(DefaultInterface) then begin
    IsOffice2000 := False;
    try
      {$IFDEF UNICODE}
      IsOffice2000 := Pos(WideString('9.0'), Self.CommandBar.Owner.FIApp.Version) = 1;
      {$ELSE}
      IsOffice2000 := Pos('9.0', Self.CommandBar.Owner.FIApp.Version) = 1;
      {$ENDIF}
    except
    end;
    if not IsOffice2000 then
    try
      Button := DefaultInterface as _CommandBarButtonXP;
      try
        Pict := Button.Picture;
        Pict := nil;
        FGlyph.TransparentColor := GlyphTransparentColor;
        PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
        PictureDesc.picType := PICTYPE_BITMAP;
        PictureDesc.hbitmap := FGlyph.Handle;
        PictureDesc.hpal := FGlyph.Palette;
        OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, Pict);
        Button.Set_Picture(Pict);
        PictureDesc.hbitmap := FGlyph.MaskHandle;
        PictureDesc.hpal := FGlyph.Palette;
        OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, Mask);
        Button.Set_Mask(Mask);
      finally
        Pict := nil;
        Mask := nil;
        Button := nil;
      end;
    except
      IsOffice2000 := True;
    end;
    if IsOffice2000 then
      try
        S := TSaveClipboard.Create;
        S.Save;
        try
          Bmp := TBitmap.Create;
          try
            Bmp.Width := FGlyph.Width;
            Bmp.Height := FGlyph.Height;
            Bmp.Canvas.Brush.Color := clBtnFace;
            Bmp.Canvas.Lock;
            try
              if GlyphTransparentColor = clDefault then
                Bmp.Canvas.BrushCopy(Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph,
                  Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph.Canvas.Pixels[0, FGlyph.Height - 1])
              else
                Bmp.Canvas.BrushCopy(Rect(0, 0, Bmp.Width, Bmp.Height), FGlyph,
                  Rect(0, 0, Bmp.Width, Bmp.Height), GlyphTransparentColor);
            finally
              Bmp.Canvas.Unlock;
            end;
            if TryOpenClipboard then begin
              try
                Clipboard.Assign(Bmp);
              finally
                Clipboard.Close;
              end;
              for i := 0 to 10 do
                try
                  DefaultInterface.PasteFace;
                  Break;
                except
                  Sleep(10);
                end;
            end;
          finally
            Bmp.Free;
          end;
        finally
          S.Restore;
          S.Free;
        end;
      except
        on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
      end;
  end;
end;

function TadxCommandBarButton.GetBuiltInFace: WordBool;
begin
  Result := FBuiltInFace;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.BuiltInFace;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetBuiltInFace(const Value: WordBool);
begin
  if FBuiltInFace <> Value then FBuiltInFace := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.BuiltInFace <> Value then
        DefaultInterface.Set_BuiltInFace(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarButton.GetFaceID: SYSINT;
begin
  Result := FFaceID;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.FaceID;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetFaceID(const Value: SYSINT);
begin
  if FFaceID <> Value then FFaceID := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.FaceID <> Value then
        DefaultInterface.Set_FaceID(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarButton.GetShortcutText: WideString;
begin
  Result := FShortcutText;
  try
    if Assigned(DefaultInterface) then begin
      Result := DefaultInterface.ShortcutText;
      // built-in bug
      if (Result = '') and (FShortcutText <> '') then
        Result := FShortcutText;
    end;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetShortcutText(const Value: WideString);
begin
  if FShortcutText <> Value then FShortcutText := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.ShortcutText <> Value then
        try
          DefaultInterface.Set_ShortcutText(Value);
        except
          // built-in bug
        end;
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarButton.GetState: TadxMsoButtonState;
begin
  Result := FState;
  try
    if Assigned(DefaultInterface) then
      case Longword(DefaultInterface.State) of
        $00000000: Result := adxMsoButtonUp;
        $FFFFFFFF: Result := adxMsoButtonDown;
        $00000002: Result := adxMsoButtonMixed;
      end;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetState(const Value: TadxMsoButtonState);
const
  MsoButtonStateArray: array [TadxMsoButtonState] of Longword =
    ($00000000, $FFFFFFFF, $00000002);
begin
  if FState <> Value then FState := Value;
  try
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.State) <> MsoButtonStateArray[Value] then
        DefaultInterface.Set_State(MsoButtonStateArray[Value]);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarButton.GetStyle: TadxMsoButtonStyle;
begin
  Result := FStyle;
  try
    if Assigned(DefaultInterface) then
      case DefaultInterface.Style of
        $00000000: Result := adxMsoButtonAutomatic;
        $00000001: Result := adxMsoButtonIcon;
        $00000002: Result := adxMsoButtonCaption;
        $00000003: Result := adxMsoButtonIconAndCaption;
        $00000007: Result := adxMsoButtonIconAndWrapCaption;
        $0000000B: Result := adxMsoButtonIconAndCaptionBelow;
        $0000000E: Result := adxMsoButtonWrapCaption;
        $0000000F: Result := adxMsoButtonIconAndWrapCaptionBelow;
      end;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetStyle(const Value: TadxMsoButtonStyle);
const
  MsoButtonStyleArray: array [TadxMsoButtonStyle] of Longword = (
    $00000000, $00000001, $00000002, $00000003,
    $00000007, $0000000B, $0000000E, $0000000F);
begin
  if FStyle <> Value then FStyle := Value;
  try
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.Style) <> MsoButtonStyleArray[Value] then
        DefaultInterface.Set_Style(MsoButtonStyleArray[Value]);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCommandBarButton.GetHyperlinkType: TadxMsoCommandBarButtonHyperlinkType;
begin
  Result := FHyperlinkType;
  try
    if Assigned(DefaultInterface) then
      Result := TadxMsoCommandBarButtonHyperlinkType(DefaultInterface.HyperlinkType);
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCommandBarButton.SetHyperlinkType(const Value: TadxMsoCommandBarButtonHyperlinkType);
begin
  if FHyperlinkType <> Value then FHyperlinkType := Value;
  try
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.HyperlinkType) <> Longword(Value) then
        DefaultInterface.Set_HyperlinkType(Longword(Value));
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{ TCustomCommandBarComboBox }

constructor TadxCustomCommandBarComboBox.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FInterface := nil;
  FDropdownLines := 0;
  FDropdownWidth := 0;
  FListHeaderCount := -1;
  FStyle := adxMsoComboNormal;
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := DoItemsChange;
end;

destructor TadxCustomCommandBarComboBox.Destroy;
begin
  if Assigned(FEventSink) then begin
    TadxEventSink(FEventSink).Disconnect;
    FEventSink := nil;
  end;
  FInterface := nil;
  FItems.Free;
  inherited Destroy;
end;

procedure TadxCustomCommandBarComboBox.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCustomCommandBarComboBox then begin
    Style := TadxCustomCommandBarComboBox(Source).Style;
    Text := TadxCustomCommandBarComboBox(Source).Text;
  end;
end;

procedure TadxCustomCommandBarComboBox.Clear;
begin
  FItems.Clear;
  if Assigned(DefaultInterface) then DefaultInterface.Clear;
end;

procedure TadxCustomCommandBarComboBox.DoItemsChange(Sender: TObject);
var
  i: Integer;
  ReconnectNeeded: boolean;
begin
  if Assigned(DefaultInterface) then begin
    ReconnectNeeded := False;
    try
      DefaultInterface.Clear;
    except
      ReconnectNeeded := True;
    end;
    if ReconnectNeeded then begin
      Self.SetInterface(CommandBar.Owner.FindControl(TMsoControls[Self.GetType], FOfficeTag) as CommandBarComboBox);
      DefaultInterface.Clear;
    end;
    for i := 0 to FItems.Count - 1 do
      DefaultInterface.AddItem(FItems[i], EmptyParam);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetInterface(const Value: CommandBarComboBox);
var
  Index: Integer;
begin
  inherited SetInterface(Value as CommandBarControl);
  if FInterface <> nil then begin
    Index := CommandBar.Owner.FSinkList.IndexOf(FEventSink);
    TadxEventSink(FEventSink).Disconnect;
    if Index > -1 then
      CommandBar.Owner.FSinkList.Delete(Index);
    FEventSink := nil;
  end;
  FInterface := Value;
  if FInterface <> nil then begin
    FEventSink := TadxEventSink.Create(CommandBar.Owner, Self);
    CommandBar.Owner.FSinkList.Add(FEventSink);
  end;
end;

function TadxCustomCommandBarComboBox.SetProperties: boolean;

  procedure ApplyChanges(const RegKey: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        WriteInteger(Self.FOfficeTag, Self.FChanged);
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

var
  i: Integer;
begin
  Result := inherited SetProperties;
  if Assigned(DefaultInterface) and Result then begin
    SetStyle(FStyle);
    if FDropdownLines <> 0 then SetDropdownLines(FDropdownLines);
    if FDropdownWidth <> 0 then SetDropdownWidth(FDropdownWidth);
    DefaultInterface.Clear;
    // fixed 22-May-2008
    if not (Self is TadxCommandBarDropDownList) then begin
      if FEnabled then
        SetText(FText);
    end;
    for i := 0 to FItems.Count - 1 do
      DefaultInterface.AddItem(FItems[i], EmptyParam);
    if FListIndex <> 0 then SetListIndex(FListIndex);
    if FListHeaderCount <> -1 then SetListHeaderCount(FListHeaderCount);

    if not Temporary then
      ApplyChanges(CommandBar.Owner.RegistryKey + '\Controls');
  end;
end;

procedure TadxCustomCommandBarComboBox.DoAction;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TadxCustomCommandBarComboBox.SetItems(const Value: TStrings);
var
  i: Integer;
begin
  FItems.Assign(Value);
  if Assigned(DefaultInterface) then begin
    DefaultInterface.Clear;
    for i := 0 to FItems.Count - 1 do
      DefaultInterface.AddItem(FItems[i], EmptyParam);
  end;
  Changed;
end;

function TadxCustomCommandBarComboBox.GetDropdownLines: SYSINT;
begin
  Result := FDropdownLines;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.DropdownLines;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetDropdownLines(const Value: SYSINT);
begin
  if FDropdownLines <> Value then FDropdownLines := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.DropdownLines <> Value then
        DefaultInterface.Set_DropdownLines(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetDropdownWidth: SYSINT;
begin
  Result := FDropdownWidth;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.DropdownWidth;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetDropdownWidth(const Value: SYSINT);
begin
  if FDropdownWidth <> Value then FDropdownWidth := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.DropdownWidth <> Value then
        DefaultInterface.Set_DropdownWidth(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetList(Index: SYSINT): WideString;
begin
  Result := FItems[Index - 1];
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.List[Index];
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetList(Index: SYSINT; const Value: WideString);
begin
  if FItems[Index - 1] <> Value then FItems[Index - 1] := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.List[Index] <> Value then
        DefaultInterface.Set_List(Index, Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetListCount: SYSINT;
begin
  Result := FItems.Count;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.ListCount;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetListHeaderCount: SYSINT;
begin
  Result := FListHeaderCount;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.ListHeaderCount;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetListHeaderCount(const Value: SYSINT);
begin
  if FListHeaderCount <> Value then FListHeaderCount := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.ListHeaderCount <> Value then
        DefaultInterface.Set_ListHeaderCount(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetListIndex: SYSINT;
begin
  Result := FListIndex;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.ListIndex;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetListIndex(const Value: SYSINT);
begin
  if FListIndex <> Value then FListIndex := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.ListIndex <> Value then
        DefaultInterface.Set_ListIndex(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetStyle: TadxMsoComboStyle;
begin
  Result := FStyle;
  try
    if Assigned(DefaultInterface) then
      Result := TadxMsoComboStyle(DefaultInterface.Style);
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetStyle(const Value: TadxMsoComboStyle);
begin
  if FStyle <> Value then FStyle := Value;
  try
    if Assigned(DefaultInterface) then
      if Longword(DefaultInterface.Style) <> Longword(Value) then
        DefaultInterface.Set_Style(Longword(Value));
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

function TadxCustomCommandBarComboBox.GetText: WideString;
begin
  Result := FText;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Text;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

procedure TadxCustomCommandBarComboBox.SetText(const Value: WideString);
begin
  if FText <> Value then FText := Value;
  try
    if Assigned(DefaultInterface) then
      if DefaultInterface.Text <> Value then
        DefaultInterface.Set_Text(Value);
    Changed;
  except
    on E: SysUtils.Exception do CommandBar.Owner.DoError(E);
  end;
end;

{ TadxCommandBarDropdownList }

procedure TadxCommandBarDropdownList.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCommandBarDropdownList then begin
    DropdownLines := TadxCommandBarDropdownList(Source).DropdownLines;
    DropdownWidth := TadxCommandBarDropdownList(Source).DropdownWidth;
    Items := TadxCommandBarDropdownList(Source).Items;
  end;
end;

function TadxCommandBarDropdownList.GetType: TadxControlType;
begin
  Result := adxDropdown;
end;

{ TadxCommandBarComboBox }

procedure TadxCommandBarComboBox.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCommandBarComboBox then begin
    DropdownLines := TadxCommandBarComboBox(Source).DropdownLines;
    DropdownWidth := TadxCommandBarComboBox(Source).DropdownWidth;
    Items := TadxCommandBarComboBox(Source).Items;
  end;
end;

function TadxCommandBarComboBox.GetType: TadxControlType;
begin
  Result := adxComboBox;
end;

{ TadxCommandBarEdit }

function TadxCommandBarEdit.GetType: TadxControlType;
begin
  Result := adxEdit;
end;

{ TadxCommandBarPopup }

constructor TadxCommandBarPopup.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FInterface := nil;
  FControls := TadxCommandBarControls.Create(Self, TadxCommandBarControl);
  SetLength(FControlTypes, 0);
end;

destructor TadxCommandBarPopup.Destroy;
begin
  SetLength(FControlTypes, 0);
  FControls.Free;
  FInterface := nil;
  inherited Destroy;
end;

procedure TadxCommandBarPopup.DoAction;
begin
end;

procedure TadxCommandBarPopup.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TadxCommandBarPopup then begin
    OfficeID := TadxCommandBarPopup(Source).OfficeID;
    Controls := TadxCommandBarPopup(Source).Controls;
  end;
end;

procedure TadxCommandBarPopup.Delete(Temporary: boolean);
var
  i: Integer;
  Control: CommandBarPopup;
begin
  for i := Controls.Count - 1 downto 0 do begin
    Controls[i].SetInterface(CommandBar.Owner.FindControl(CommandBar.DefaultInterface,
      TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag));
    if Controls[i].DefaultInterface = nil then
      Controls[i].SetInterface(CommandBar.Owner.FindControl(
        TMsoControls[Controls[i].GetType], Controls[i].OfficeTag));
    if Assigned(Controls[i].DefaultInterface) then Controls[i].Delete(Temporary);
  end;
  if Assigned(DefaultInterface) then
    try
      if (DefaultInterface.Id = 1) and (DefaultInterface.Controls.Count = 0) then
        DefaultInterface.Delete(Temporary);
    finally
      Control := nil;
      SetInterface(Control);
    end;
end;

function TadxCommandBarPopup.ControlByCaption(const ACaption: WideString): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FCaption = ACaption then begin
      Result := FControls[i];
      Break;
    end;
end;

function TadxCommandBarPopup.ControlByTag(const ATag: Integer): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FTag = ATag then begin
      Result := FControls[i];
      Break;
    end;
end;

function TadxCommandBarPopup.ControlByOfficeTag(const AOfficeTag: WideString): TadxCommandBarControl;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FControls.Count - 1 do
    if FControls[i].FOfficeTag = AOfficeTag then begin
      Result := FControls[i];
      Break;
    end;
end;

procedure TadxCommandBarPopup.ReconnectControls;
var
  i: Integer;
  IControl: CommandBarControl;
begin
  {$IFDEF ADX_TRIAL}
  if Controls.Count > 0 then begin
    i := 0;
  {$ELSE}
  for i := 0 to Controls.Count - 1 do begin
  {$ENDIF}
    IControl := CommandBar.Owner.FindControl(CommandBar.DefaultInterface,
      TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag);
    if IControl = nil then
      IControl := CommandBar.Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeTag);
    // FIX 12-Sep-2 0 0 7
    if (IControl = nil) and (Controls[i].FOfficeID <> 1) then
      IControl := CommandBar.Owner.FindControl(TMsoControls[Controls[i].GetType], Controls[i].FOfficeID);
    if (IControl = nil) then
      Self.CommandBar.FOwner.InternalAddControl(Controls[i], Self.CommandBar, Self);
    if Controls[i].GetType = adxPopup then begin
      if Controls[i].FOfficeID <> 1 then begin
        IControl := CommandBar.Owner.FindControl(CommandBar.DefaultInterface,
          msoControlPopup, Controls[i].FOfficeID) as CommandBarPopup;
        if IControl = nil then
          IControl := CommandBar.Owner.FindControl(msoControlPopup, Controls[i].FOfficeID);
      end;
      TadxCommandBarPopup(Controls[i]).SetInterface(IControl as CommandBarPopup);
      TadxCommandBarPopup(Controls[i]).ReconnectControls;
    end
    else begin
      if Controls[i].GetType in [adxButton, adxAdvancedControl] then
        TadxCommandBarButton(Controls[i]).SetInterface(IControl as CommandBarButton)
      else
        TadxCustomCommandBarComboBox(Controls[i]).SetInterface(IControl as CommandBarComboBox);
    end;
  end;
end;

function TadxCommandBarPopup.GetType: TadxControlType;
begin
  Result := adxPopup;
end;

function TadxCommandBarPopup.SetProperties: boolean;

  procedure ApplyChanges(const RegKey: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(RegKey, True) then begin
        if CommandBar.Owner.COMAddInClassFactory.FDeprecatedVersion then
          WriteInteger(Self.FOfficeTag, 255)
        else
          WriteInteger(Self.FOfficeTag, Self.FChanged);
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

begin
  Result := inherited SetProperties;
  if Assigned(DefaultInterface) and Result and not Temporary then
    ApplyChanges(CommandBar.Owner.RegistryKey + '\Controls');
end;

procedure TadxCommandBarPopup.SetInterface(const Value: CommandBarPopup);
begin
  inherited SetInterface(Value as CommandBarControl);
  FInterface := Value;
end;

procedure TadxCommandBarPopup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ButtonTypes', ReadControlsTypes, WriteControlsTypes, True);
  Filer.DefineProperty('Buttons', ReadControls, WriteControls, True);
end;

procedure TadxCommandBarPopup.SetControls(const Value: TadxCommandBarControls);
begin
  FControls.Assign(Value);
end;

procedure TadxCommandBarPopup.WriteControlsTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxCommandBarPopup.ReadControlsTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxCommandBarPopup.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxCommandBarPopup.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

{ TadxOlExplorerCustomCommandBar }

constructor TadxOlExplorerCustomCommandBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFolderNames := TStringList.Create;
  FItemTypes := [adxOLMailItem];
  FTemporary := True;
  FPosition := adxMsoBarTop;
  FSupportedApps := [ohaOutlook];
  FUseForRibbon := True;
end;

destructor TadxOlExplorerCustomCommandBar.Destroy;
begin
  FFolderNames.Free;
  inherited Destroy;
end;

procedure TadxOlExplorerCustomCommandBar.SetSupportedApps(const Value: TadxHostAppSet);
begin
  inherited SetSupportedApps(Value);
  FSupportedApps := [ohaOutlook];
end;

{ TadxOlExplorerMainMenu }

constructor TadxOlExplorerMainMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItemTypes := [adxOLMailItem, adxOLAppointmentItem, adxOLContactItem,
    adxOLTaskItem, adxOLJournalItem, adxOLNoteItem, adxOLPostItem,
    adxOLDistributionListItem];
  FCommandBarName := 'Menu Bar';
  // &File  30002
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&File';
    FOfficeID := 30002;
  end;
  // &Edit  30003
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Edit';
    FOfficeID := 30003;
  end;
  // &View  30004
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&View';
    FOfficeID := 30004;
  end;
  // &Go    30328
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Go';
    FOfficeID := 30328;
  end;
  // &Tools 30007
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Tools';
    FOfficeID := 30007;
  end;
  // &Help  30010
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Help';
    FOfficeID := 30010;
  end;
end;

{ TadxOlInspectorCustomCommandBar }

constructor TadxOlInspectorCustomCommandBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFolderNames := TStringList.Create;
  FItemClasses := [adxOLMail];
  FTemporary := True;
  FPosition := adxMsoBarTop;
  FSupportedApps := [ohaOutlook];
end;

destructor TadxOlInspectorCustomCommandBar.Destroy;
begin
  FFolderNames.Free;
  inherited Destroy;
end;

procedure TadxOlInspectorCustomCommandbar.SetSupportedApps(const Value: TadxHostAppSet);
begin
  inherited SetSupportedApps(Value);
  FSupportedApps := [ohaOutlook];
end;

{ TadxOlInspectorMainMenu }

constructor TadxOlInspectorMainMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItemClasses := [adxOLAppointment, adxOLMeetingRequest,
    adxOLMeetingCancellation, adxOLMeetingResponseNegative,
    adxOLMeetingResponsePositive, adxOLMeetingResponseTentative,
    adxOLContact, adxOLJournal, adxOLMail, adxOLPost, adxOLTask,
    adxOLTaskRequest, adxOLTaskRequestUpdate, adxOLTaskRequestAccept,
    adxOLTaskRequestDecline, adxOLDistributionList, adxOLReport];
  FCommandBarName := 'Menu Bar';
  // &File  30002
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&File';
    FOfficeID := 30002;
  end;
  // &Edit  30003
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Edit';
    FOfficeID := 30003;
  end;
  // &View  30004
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&View';
    FOfficeID := 30004;
  end;
  // &Insert 30005
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Insert';
    FOfficeID := 30005;
  end;
  // F&ormat 30006
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := 'F&ormat';
    FOfficeID := 30006;
  end;
  // &Tools 30007
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Tools';
    FOfficeID := 30007;
  end;
  // &Help  30010
  with TadxCommandBarPopup.Create(Self.FControls).AsPopup do begin
    FCaption := '&Help';
    FOfficeID := 30010;
  end;
end;

{ TadxContextMenu }

constructor TadxContextMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTemporary := True;
  FUseForRibbon := True;
  if ohaWord in FSupportedApps then FSupportedApp := ohaWord
  else if ohaOutlook in FSupportedApps then FSupportedApp := ohaOutlook
  else if ohaPowerPoint in FSupportedApps then FSupportedApp := ohaPowerPoint
  else if ohaAccess in FSupportedApps then FSupportedApp := ohaAccess
  else if ohaProject in FSupportedApps then FSupportedApp := ohaProject
  else if ohaFrontPage in FSupportedApps then FSupportedApp := ohaFrontPage
  else if ohaMapPoint in FSupportedApps then FSupportedApp := ohaExcel
  else if ohaVisio in FSupportedApps then FSupportedApp := ohaVisio
  else if ohaPublisher in FSupportedApps then FSupportedApp := ohaPublisher
  else if ohaInfoPath in FSupportedApps then FSupportedApp := ohaInfoPath
  else FSupportedApp := ohaExcel;
  FSupportedApps := [FSupportedApp];
  case FSupportedApp of
    ohaExcel: FCommandBarName := 'Cell';
    ohaWord: FCommandBarName := 'Text';
    ohaOutlook: FCommandBarName := 'ItemContextMenu';
    ohaPowerPoint: FCommandBarName := 'ActiveX Control';
    ohaAccess: FCommandBarName := 'Actions';
    ohaFrontPage: FCommandBarName := '3-D Lighting';
    ohaVisio: FCommandBarName := 'Drawing Object Selected';
    ohaProject,
    ohaPublisher,
    ohaInfoPath: FCommandBarName := 'System';
  end;
end;

procedure TadxContextMenu.DoAddControls();
begin
  if Assigned(FOnBeforeAddControls) then
    try
      FOnBeforeAddControls(Self);
    except
      on E: SysUtils.Exception do FOwner.DoError(E);
    end;
end;

procedure TadxContextMenu.SetSupportedApp(Value: TadxOfficeHostApp);
begin
  if FSupportedApp <> Value then begin
    if Value = ohaMapPoint then Exit;
    FSupportedApp := Value;
    FSupportedApps := [Value];
    if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      case FSupportedApp of
        ohaExcel: FCommandBarName := 'Cell';
        ohaWord: FCommandBarName := 'Text';
        ohaOutlook: FCommandBarName := 'ItemContextMenu';
        ohaPowerPoint: FCommandBarName := 'ActiveX Control';
        ohaAccess: FCommandBarName := 'Actions';
        ohaFrontPage: FCommandBarName := '3-D Lighting';
        ohaVisio: FCommandBarName := 'Drawing Object Selected';
        ohaProject,
        ohaPublisher,
        ohaInfoPath: FCommandBarName := 'System';
      end;
  end;
end;

{ TadxBuiltInControl }

constructor TadxBuiltInControl.Create(AOwner: TComponent);
var
  ControlTag: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := AOwner as TadxCOMAddInModule;
  FInterface := nil;
  FBuiltInID := 1;
  FDisableStandardAction := False;
  {$IFDEF ADX_VCL5}
  CoCreateGUID(ControlTag);
  {$ELSE}
  CreateGUID(ControlTag);
  {$ENDIF}
  FOfficeTag := GUIDToString(ControlTag);
  FControlInvoked:= nil;
end;

destructor TadxBuiltInControl.Destroy;
begin
  if Assigned(FEventSink) then begin
    TadxEventSink(FEventSink).Disconnect;
    FEventSink := nil;
  end;
  FOwner := nil;
  FInterface := nil;
  inherited Destroy;
end;

procedure TadxBuiltInControl.DoAction(var Cancel: boolean);
begin
  if Assigned(FOnAction) then FOnAction(Self);
  // case #645
  Cancel := DisableStandardAction;
  if Assigned(FOnActionEx) then FOnActionEx(Self, Cancel);
end;

procedure TadxBuiltInControl.Uninstall;
var
  i: Integer;
  Ctrls: CommandBarControls;
  Control: CommandBarControl;
begin
  if BuiltInID = 1 then Exit;
  if Assigned(CommandBar) then begin
    if CommandBar.DefaultInterface = nil then
      CommandBar.FInterface := Owner.FindCommandBar(CommandBar.CommandBarName);
    if Assigned(CommandBar.DefaultInterface) then
      SetInterface(CommandBar.DefaultInterface.FindControl(EmptyParam,
        BuiltInID, EmptyParam, EmptyParam, True));
    CommandBar.FInterface := nil;
  end
  else begin
    if Owner.FICmdBars = nil then Owner.FICmdBars := Owner.GetAppCommandBars;
    if Assigned(Owner.FICmdBars) then begin
      Ctrls := Owner.FICmdBars.FindControls(EmptyParam, BuiltInID, EmptyParam, EmptyParam);
      if Assigned(Ctrls) and (Ctrls.Count > 1) then
      try
        SetInterface(Ctrls.Item[1]);
        for i := 2 to Ctrls.Count do Ctrls.Item[i].Reset;
      finally
        Ctrls := nil;
      end
      else
        SetInterface(Owner.FICmdBars.FindControl(EmptyParam, BuiltInID, EmptyParam, EmptyParam));
    end;
  end;
  if Assigned(DefaultInterface) then
    try
      DefaultInterface.Reset;
      Control := nil;
      SetInterface(Control);
    except
    end;
end;

procedure TadxBuiltInControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FCommandBar <> nil) and
    (AComponent = FCommandBar) then FCommandBar := nil;
end;

function TadxBuiltInControl.GetOfficeTag: WideString;
begin
  Result := FOfficeTag;
  try
    if Assigned(DefaultInterface) then Result := DefaultInterface.Tag;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxBuiltInControl.SetOfficeTag(const Value: WideString);
begin
  if (FOfficeTag <> Value) and (csDesigning in ComponentState) and
    not (csReading in ComponentState) then
    if MessageDlg(adxErrorTagWarning, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  if FOfficeTag <> Value then FOfficeTag := Value;
  try
    if Assigned(DefaultInterface) then begin
      try
        if DefaultInterface.Tag <> Value then
          DefaultInterface.Set_Tag(Value);
      except
      end;
    end;
  except
    on E: SysUtils.Exception do Owner.DoError(E);
  end;
end;

procedure TadxBuiltInControl.SetInterface(const Value: CommandBarControl);
var
  Index: Integer;
begin
  if FInterface <> Value then begin
    if FInterface <> nil then begin
      Index := Owner.FSinkList.IndexOf(FEventSink);
      TadxEventSink(FEventSink).Disconnect;
      if Index > -1 then
        Owner.FSinkList.Delete(Index);
      FEventSink := nil;
    end;
    FInterface := Value;
    if FInterface <> nil then begin
      FEventSink := TadxEventSink.Create(Owner, Self);
      Owner.FSinkList.Add(FEventSink);
    end;
  end;
end;

{ Outlook functions}

function GetFullFolderName(const AFolder: MAPIFolder): WideString;
var
  IDisp: IDispatch;
  Folder: MAPIFolder;
  EntryID: WideString;
begin
  Result := '';
  try
    Folder := AFolder;
    while Assigned(Folder) do begin
      Result := '\' + Folder.Name + Result;
      EntryID := Folder.EntryID;
      IDisp := Folder.Parent;
      if Assigned(IDisp) then
        IDisp.QueryInterface(IID_MAPIFolder, Folder)
      else
        Folder := nil;
      // Case #2236
      if Assigned(Folder) then
        if Folder.EntryID = EntryID then
          Folder := nil;
    end;
    if Result <> '' then Delete(Result, 1, 1);
  except
    // mailbox permissions
  end;
end;

function CheckItemClass(ItemClass: TOleEnum; SupportedItems: TadxOLItemTypes): boolean; overload;
var
  i: TadxOLItemType;
begin
  Result := False;
  for i := Low(TadxOLItemType) to High(TadxOLItemType) do
    if (i in SupportedItems) and (Integer(i) = Integer(ItemClass)) then begin
      Result := True;
      Break;
    end;
end;

function CheckItemClass(ItemClass: TOleEnum; SupportedItems: TadxOLItemClasses): boolean; overload;
const
  TItemTypesArray: array [TadxOLItemClass] of TOleEnum = (olAppointment,
    olMeetingRequest, olMeetingCancellation, olMeetingResponseNegative,
    olMeetingResponsePositive, olMeetingResponseTentative, olContact,
    olJournal, olMail, olPost, olTask, olTaskRequest, olTaskRequestUpdate,
    olTaskRequestAccept, olTaskRequestDecline, olDistributionList, olReport);
var
  i: TadxOLItemClass;
begin
  Result := False;
  for i := Low(TadxOLItemClass) to High(TadxOLItemClass) do
    if (i in SupportedItems) and (TItemTypesArray[i] = ItemClass) then begin
      Result := True;
      Break;
    end;
end;

procedure ScanExplControls(ItemClass: TOleEnum; AControls: TadxCommandBarControls);
var
  i: Integer;
begin
  for i := 0 to AControls.Count - 1 do
    if AControls[i].olExplorerItemTypes <> TadxOLExplorerCustomCommandBar(AControls[i].CommandBar).ItemTypes then
    begin
      if AControls[i].FOfficeID = 1 then begin
        if AControls[i].olItemTypeAction = adxOLActionShow then
          AControls[i].Visible := CheckItemClass(ItemClass, AControls[i].olExplorerItemTypes);
        if AControls[i].olItemTypeAction = adxOLActionEnable then
          AControls[i].Enabled := CheckItemClass(ItemClass, AControls[i].olExplorerItemTypes);
      end;
      if AControls[i] is TadxCommandBarPopup then
        ScanExplControls(ItemClass, AControls[i].AsPopup.Controls);
    end;
end;

procedure ScanInspControls(ItemClass: TOleEnum; AControls: TadxCommandBarControls);
var
  i: Integer;
begin
  for i := 0 to AControls.Count - 1 do
    if AControls[i].olInspectorItemTypes <> TadxOLInspectorCustomCommandBar(AControls[i].CommandBar).ItemTypes then
    begin
      if AControls[i].FOfficeID = 1 then begin
        if AControls[i].olItemTypeAction = adxOLActionShow then
          AControls[i].Visible := CheckItemClass(ItemClass, AControls[i].olInspectorItemTypes);
        if AControls[i].olItemTypeAction = adxOLActionEnable then
          AControls[i].Enabled := CheckItemClass(ItemClass, AControls[i].olInspectorItemTypes);
      end;
      if AControls[i] is TadxCommandBarPopup then
        ScanInspControls(ItemClass, AControls[i].AsPopup.Controls);
    end;
end;

{ TadxNativeWindow }

type
  TadxNativeWindow = class(TWinControl)
  private
    FWndProc: Pointer;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TadxCOMAddInModule; ACaption: string); reintroduce;
    destructor Destroy; override;
  end;

var
  FModule: TadxCOMAddInModule;
  FHostWndHook: HHOOK = 0;

procedure SendCallbackProc(hwnd: HWND; uMsg: UINT; dwData: DWORD; lREsult: LRESULT); stdcall;
begin
end;

function KeyboardProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT; stdcall;

  function TranslateToString(IsCtrl, IsShift, IsAlt: boolean; Key: Integer): string;
  begin
    if not IsCtrl and not IsShift and IsAlt then
      Result := 'Alt+' + ShortCutToText(Key)
    else begin
      Result := '';
      if IsCtrl then Result := Result + 'Ctrl+';
      if IsShift then Result := Result + 'Shift+';
      if IsAlt then Result := Result + 'Alt+';
      Result := Result + ShortCutToText(Key);
    end;
  end;

var
  PrevState, TransState: LongWord;
  IsCtrl, IsShift, IsAlt: boolean;
  ShortcutText: string;
  Index: Integer;
  keyArgs: TadxKeyDownEventArgs;
begin
  Result := 0;
  if code < 0 then Result := CallNextHookEx(FHostWndHook, code, wparam, lparam)
  else
    try
      if (code = HC_ACTION) and (wparam <> 0) and (lparam <> 0) then begin
        PrevState := (LongWord(lParam) and $40000000) shr 30;
        TransState := (LongWord(lParam) and $80000000) shr 31;
        if FModule <> nil then
          if (Assigned(FModule.FNativeWindow) and (FModule.FNativeWindow.Handle <> 0)) or Assigned(FModule.OnKeyDown) then begin
            if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then begin
              IsCtrl := ((GetKeyState(VK_CONTROL) and $0100) = $0100);
              IsShift := ((GetKeyState(VK_SHIFT) and $0100) = $0100);
              IsAlt := ((GetKeyState(VK_MENU) and $0100) = $0100);
            end
            else begin
              IsCtrl := ((GetKeyState(VK_LCONTROL) and $0100) = $0100) or ((GetKeyState(VK_RCONTROL) and $0100) = $0100);
              IsShift := ((GetKeyState(VK_LSHIFT) and $0100) = $0100) or ((GetKeyState(VK_RSHIFT) and $0100) = $0100);
              IsAlt := ((GetKeyState(VK_LMENU) and $0100) = $0100) or ((GetKeyState(VK_RMENU) and $0100) = $0100);
            end;

            if (not (wparam in [VK_SHIFT, VK_CONTROL, VK_MENU])) then
              if (PrevState = 0) and (TransState = 0) then begin
                ShortcutText := TranslateToString(IsCtrl, IsShift, IsAlt, wparam);
                Index := FModule.ControlByShortcut.IndexOf(UpperCase(ShortcutText));
                if Index <> -1 then begin
                  //SendMessageCallback(FModule.FNativeWindow.Handle, WM_KEYDOWN, Index, 0, @SendCallbackProc, 0);
                  PostMessage(FModule.FNativeWindow.Handle, WM_ADXKEYDOWN, Index, 0);
                  CallNextHookEx(FHostWndHook, code, wparam, lparam);
                  Result := 1;
                  Exit;
                end;
              end;

            if Assigned(FModule.OnKeyDown) and (PrevState = 0) and (TransState = 0) then begin
              keyArgs.Ctrl:= IsCtrl;
              keyArgs.Alt:= IsAlt;
              keyArgs.Shift:= IsShift;
              keyArgs.Handled:= false;
              keyArgs.KeyStrokeFlags:= lparam;
              keyArgs.VirtualKey:= wparam;
              FModule.OnKeyDown(nil, keyArgs);
              if keyArgs.Handled then begin
                CallNextHookEx(FHostWndHook, code, wparam, lparam);
                Result:= 1;
                exit;
              end;
            end
          end;
      end;
      Result := CallNextHookEx(FHostWndHook, code, wparam, lparam);
    except
    end;
end;

constructor TadxNativeWindow.Create(AOwner: TadxCOMAddInModule; ACaption: string);
var
  TempClass: TWndClass;
  S: string;
begin
  inherited Create(AOwner);
  FModule := AOwner;
  FWndProc := nil;
  S := Self.ClassName;
  FillChar(TempClass, SizeOf(TempClass), 0);
  if not GetClassInfo(HInstance, PChar(S), TempClass) then begin
    TempClass.hInstance := HInstance;
    TempClass.lpfnWndProc := @DefWindowProc;
    TempClass.lpszClassName := PChar(S);
    if Windows.RegisterClass(TempClass) = 0 then
      raise EOutOfResources.Create('Error creating window class');
  end;
  WindowHandle := CreateWindowEx(WS_EX_TOOLWINDOW, TempClass.lpszClassName, PChar(ACaption),
    WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);

  if WindowHandle <> 0 then begin
    {$IFDEF ADX_VCL5}
    FWndProc := Forms.MakeObjectInstance(WndProc);
    {$ELSE}
    FWndProc := Classes.MakeObjectInstance(WndProc);
    {$ENDIF}
    SetWindowLong(Self.WindowHandle, GWL_WNDPROC, Longint(FWndProc));
  end;
end;

destructor TadxNativeWindow.Destroy;
begin
  DestroyWindow(WindowHandle);
  WindowHandle := 0;
  if FWndProc <> nil then
    {$IFDEF ADX_VCL5}
    Forms.FreeObjectInstance(FWndProc);
    {$ELSE}
    Classes.FreeObjectInstance(FWndProc);
    {$ENDIF}
  FModule := nil;
  inherited Destroy;
end;

procedure TadxNativeWindow.WndProc(var Message: TMessage);
var
  Component: TObject;
  Ctrl: TadxCommandBarButton;
  AllowAction: boolean;
begin
  if Message.Msg = WM_QUERYENDSESSION then Message.Result := Integer(True)
  else
  try
    if (Message.Msg = WM_ADXKEYDOWN) and (Message.WParam >= 0) then
      try
        Component := FModule.FControlByShortcut.Objects[Message.WParam];
        if Component is TadxCommandBarButton then begin
          Ctrl := TadxCommandBarButton(Component);
          if Assigned(Ctrl) then begin
            // case #436
            try
              if Assigned(Ctrl.DefaultInterface) then
                Ctrl.DefaultInterface.Set_Enabled(Ctrl.DefaultInterface.Enabled);
            except
              Exit;
            end;
            if Assigned(Ctrl.DefaultInterface) and Ctrl.Enabled then begin
              AllowAction := True;
              if UpperCase(Ctrl.FShortcutText) <> FModule.FControlByShortcut[Message.WParam] then begin
                AllowAction := False;
                if Ctrl.Parent.type_ <> msoBarTypePopup then
                  AllowAction := Ctrl.Parent.Enabled and Ctrl.Parent.Visible and Ctrl.Visible;
              end;
              if AllowAction then
                try
                  Ctrl.DoAction;
                except
                  on E: SysUtils.Exception do FModule.DoError(E);
                end;
            end;
          end;
        end
        else
          if Component is TadxKeyboardShortcut then
            if TadxKeyboardShortcut(Component).Enabled then
              TadxKeyboardShortcut(Component).DoAction;
      except
      end;
  finally
    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      Message.Result := DefWindowProc(WindowHandle, Message.Msg, Message.WParam, Message.LParam)
    else
      inherited WndProc(Message);
  end;
end;

{ TadxNativeColorWindow }

type
  TadxNativeColorWindow = class(TWinControl)
  private
    FChange: Longword;
    FWndProc: Pointer;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TadxCOMAddInModule; ACaption: string); reintroduce;
    destructor Destroy; override;
  end;

constructor TadxNativeColorWindow.Create(AOwner: TadxCOMAddInModule; ACaption: string);
var
  TempClass: TWndClass;
  S: string;
begin
  inherited Create(AOwner);
  FModule := AOwner;
  FWndProc := nil;
  S := Self.ClassName;
  FillChar(TempClass, SizeOf(TempClass), 0);
  if not GetClassInfo(HInstance, PChar(S), TempClass) then begin
    TempClass.hInstance := HInstance;
    TempClass.lpfnWndProc := @DefWindowProc;
    TempClass.lpszClassName := PChar(S);
    if Windows.RegisterClass(TempClass) = 0 then
      raise EOutOfResources.Create('Error creating window class');
  end;
  WindowHandle := CreateWindowEx(WS_EX_TOOLWINDOW, TempClass.lpszClassName, PChar(ACaption),
    WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);

  if WindowHandle <> 0 then begin
    {$IFDEF ADX_VCL5}
    FWndProc := Forms.MakeObjectInstance(WndProc);
    {$ELSE}
    FWndProc := Classes.MakeObjectInstance(WndProc);
    {$ENDIF}
    SetWindowLong(Self.WindowHandle, GWL_WNDPROC, Longint(FWndProc));
    FChange := RegisterWindowMessage('WM_MSO_BROADCASTCHANGE');
  end;
end;

destructor TadxNativeColorWindow.Destroy;
begin
  DestroyWindow(WindowHandle);
  WindowHandle := 0;
  if FWndProc <> nil then
    {$IFDEF ADX_VCL5}
    Forms.FreeObjectInstance(FWndProc);
    {$ELSE}
    Classes.FreeObjectInstance(FWndProc);
    {$ENDIF}
  FModule := nil;
  inherited Destroy;
end;

procedure TadxNativeColorWindow.WndProc(var Message: TMessage);
var
  Scheme: TadxOfficeColorScheme;
begin
  if Message.Msg = WM_QUERYENDSESSION then Message.Result := Integer(True)
  else
  try
    if (Message.Msg = FChange) then begin
      with TRegistry.Create(KEY_READ) do
        try
          if OpenKey(Format('Software\\Microsoft\\Office\\%d.0\\Common', [FModule.FHostMajorVersion]), False) then
            try
              if ValueExists('Theme') then begin
                // Case #1635
                Scheme := TadxOfficeColorScheme(ReadInteger('Theme'));
                if (Scheme = FModule.FOfficeColorScheme) then Exit;
                FModule.FOfficeColorScheme := TadxOfficeColorScheme(ReadInteger('Theme'));
              end;
            finally
              CloseKey;
            end;
        finally
          Free;
        end;
      if Assigned(FModule.FOnOfficeColorSchemeChanged) then
        try
          FModule.FOnOfficeColorSchemeChanged(FModule, FModule.FOfficeColorScheme);
        except
          on E: SysUtils.Exception do FModule.DoError(E);
        end;
    end;
  finally
    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      Message.Result := DefWindowProc(WindowHandle, Message.Msg, Message.WParam, Message.LParam)
    else
      inherited WndProc(Message);
  end;
end;

type
  TadxOutlook2007Application = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Application;
    FModule: TadxCOMAddInModule;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  end;

{ TadxOutlook2007Application }

constructor TadxOutlook2007Application.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FModule := TadxCOMAddInModule(AOwner);
end;

destructor TadxOutlook2007Application.Destroy;
begin
  FModule := nil;
  inherited Destroy;
end;

procedure TadxOutlook2007Application.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0006F03A-0000-0000-C000-000000000046}';
    IntfIID:   '{00063001-0000-0000-C000-000000000046}';
    //EventIID:  '{0006304E-0000-0000-C000-000000000046}'; // 2000
    EventIID:  '{0006302C-0000-0000-C000-000000000046}'; // 2007
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxOutlook2007Application.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxOutlook2007Application.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxOutlook2007Application.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

type
  TadxOutlookAppEventsAccess = class(TadxOutlookAppEvents);

procedure TadxOutlook2007Application.InvokeEvent(DispID: TDispID; var Params: TVariantArray);

  procedure DisconnectControls(const AControls: TadxCommandBarControls);
  var
    i: Integer;
    Ctrl: CommandBarControl;
  begin
    Ctrl := nil;
    for i := 0 to AControls.Count - 1 do begin
      AControls[i].SetInterface(Ctrl);
      if AControls[i] is TadxCommandBarPopup then
        DisconnectControls(AControls[i].AsPopup.FControls);
    end;
  end;

//  procedure ConnectBuiltIn(const ContextMenu: TadxContextMenu);
//  var
//    j: Integer;
//    OldProtection: TOleEnum;
//  begin
//    for j := 0 to FModule.ComponentCount - 1 do
//      if (FModule.Components[j] is TadxBuiltInControl){ and
//        (TadxBuiltInControl(FModule.Components[j]).FCommandBar = ContextMenu)} then
//      begin
//        OldProtection := ContextMenu.DefaultInterface.Protection;
//        ContextMenu.DefaultInterface.Set_Protection(msoBarNoProtection);
//        FModule.InternalAddBuiltInControl(TadxBuiltInControl(FModule.Components[j]));
//        ContextMenu.DefaultInterface.Set_Protection(OldProtection);
//      end;
//  end;
//
//  procedure DisconnectBuiltIn(const ContextMenu: TadxContextMenu);
//  var
//    j: Integer;
//    OldProtection: TOleEnum;
//    Ctrl: CommandBarControl;
//  begin
//    Ctrl := nil;
//    for j := 0 to FModule.ComponentCount - 1 do
//      if (FModule.Components[j] is TadxBuiltInControl) {and
//        (TadxBuiltInControl(FModule.Components[j]).FCommandBar = ContextMenu)} then
//      begin
//        OldProtection := ContextMenu.DefaultInterface.Protection;
//        ContextMenu.DefaultInterface.Set_Protection(msoBarNoProtection);
//        TadxBuiltInControl(FModule.Components[j]).SetInterface(Ctrl);
//        ContextMenu.DefaultInterface.Set_Protection(OldProtection);
//      end;
//  end;

const
  olItemContextMenu = $00000000;
  olViewContextMenu = $00000001;
  olFolderContextMenu = $00000002;
  olAttachmentContextMenu = $00000003;
  olStoreContextMenu = $00000004;
  olShortcutContextMenu = $00000005;
var
  i: Integer;
  ContextMenu: TadxContextMenu;
begin
  try
    case DispID of
      -1: Exit;
      64318: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoAttachmentContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'AttachmentContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64320: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoViewContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'ViewContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64321: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoItemContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
            IUnknown(TVarData(Params[1]).VPointer) as Outlook2000.Selection);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'ItemContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64322: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoFolderContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
            IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'FolderContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64323: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoStoreContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'StoreContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64324: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoShortcutContextMenuDisplay(
            IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
            IUnknown(TVarData(Params[1]).VPointer) as OutlookBarShortcut);
        for i := 0 to FModule.ComponentCount - 1 do begin
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then
              if (ContextMenu.FCommandBarName = 'ShortcutContextMenu')then
              begin
                ContextMenu.FInterface := IUnknown(TVarData(Params[0]).VPointer) as CommandBar;
                ContextMenu.ReconnectControls();
              end;
          end;
        end;
        FModule.ConnectBuiltinControls;
      end;
      64422: begin
        if Assigned(FModule.FHostEvents) then
          TadxOutlookAppEventsAccess(FModule.FHostEvents).DoContextMenuClose(Params[0]);
        for i := 0 to FModule.ComponentCount - 1 do
          if FModule.Components[i] is TadxContextMenu then begin
            ContextMenu := TadxContextMenu(FModule.Components[i]);
            if (FModule.HostType in ContextMenu.SupportedApps) then begin
              if (ContextMenu.FCommandBarName = 'AttachmentContextMenu') and (Params[0] = olAttachmentContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
              if (ContextMenu.FCommandBarName = 'ViewContextMenu') and (Params[0] = olViewContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
              if (ContextMenu.FCommandBarName = 'ItemContextMenu') and (Params[0] = olItemContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
              if (ContextMenu.FCommandBarName = 'FolderContextMenu') and (Params[0] = olFolderContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
              if (ContextMenu.FCommandBarName = 'StoreContextMenu') and (Params[0] = olStoreContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
              if (ContextMenu.FCommandBarName = 'ShortcutContextMenu') and (Params[0] = olShortcutContextMenu) then
              begin
                ContextMenu.FInterface := nil;
                DisconnectControls(ContextMenu.FControls);
                FModule.DisconnectBuiltinControls;
              end;
            end;
          end;
      end;
    end;
  except
  end;
end;

{ TadxCOMAddInModule }

constructor TadxCOMAddInModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FICmdBars := nil;
  FCOMAddInClassInstance := nil;
  FCOMAddInClassFactory := nil;
  FAddInInstance := nil;
  FRibbonUI := nil;
  FCTPFactory := nil;
end;

constructor TadxCOMAddInModule.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner, Dummy);
  FRegisterForAllUsers := False;
  FRegistry := TRegistry.Create;
  FCommandBars := TList.Create;

  FCommands := TList.Create;
  FTabs := TList.Create;
  FContextTabs := TList.Create;
  FRibbonControls := TStringList.Create;

  FFastCommandBarSearch := False;
  FSupportedApps := [ohaExcel];
  FLoadBehavior := 3;
  FSinkList := TList.Create;
  FControlByShortcut := nil;

  FStartFromScratch := [];
  FStartFromScratch2010 := [];
  FTaskPanes := TadxCustomTaskPanes.Create(Self, TadxCustomTaskPane);
  FAccessTimer := TTimer.Create(nil);
  FAccessTimer.Enabled := False;
  FAccessTimer.Interval := 250;
  FAccessTimer.OnTimer := DoAccessTick;
  FOfficeColorScheme := Unknown;
end;

destructor TadxCOMAddInModule.Destroy;
begin
  FRegistry.Free;
  FreeHostApplication;
  FSinkList.Free;

  FreeAndNil(FRibbonControls);
  FreeAndNil(FContextTabs);
  FreeAndNil(FTabs);
  FreeAndNil(FCommands);
  if Assigned(FTaskPanes) then FreeAndNil(FTaskPanes);
  if Assigned(FAccessTimer) then FreeAndNil(FAccessTimer);
  FRibbonUI := nil;
  FCTPFactory := nil;

  FICmdBars := nil;
  FCOMAddInClassInstance := nil;
  FCOMAddInClassFactory := nil;
  FAddInInstance := nil;
  FIApp := Unassigned;
  if FHostWndHook <> 0 then begin
    UnhookWindowsHookEx(FHostWndHook);
    FHostWndHook := 0;
  end;
  if Assigned(FNativeColorWindow) then FreeAndNil(FNativeColorWindow);
  if Assigned(FNativeWindow) then FreeAndNil(FNativeWindow);
  if Assigned(FControlByShortcut) then FreeAndNil(FControlByShortcut);
  inherited Destroy;
  FCommandBars.Free;
end;

procedure TadxCOMAddInModule.DoError(const E: SysUtils.Exception);
var
  Handled: boolean;
begin
  Handled := False;
  if Assigned(FOnError) then FOnError(E, Handled);
  if not Handled then
    MessageDlg(Format('%s error: the add-in has fired an exception.'#13#10 +
     '%s', [AddInName, E.Message]), mtError, [mbOK], 0);
end;

procedure TadxCOMAddInModule.DoCallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
begin
  if Assigned(FOnCallBack) then
    FOnCallBack(key, i1, i2, i3, s1, s2, s3);
end;

procedure TadxCOMAddInModule.ConnectBuiltinControls();
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TadxBuiltInControl then begin
      InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
      {$IFDEF ADX_TRIAL}
      Break;
      {$ENDIF}
    end;
  end;
end;

procedure TadxCOMAddInModule.DisconnectBuiltinControls;
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TadxBuiltInControl then begin
      TadxBuiltInControl(Components[i]).SetInterface(nil);
      {$IFDEF ADX_TRIAL}
      Break;
      {$ENDIF}
    end;
  end;
end;

procedure TadxCOMAddInModule.DoCommandBarsUpdate();
var
  i: Integer;
begin
  if (HostType = ohaOutlook) then begin
    if not FIsRibbon then begin
      for i := 0 to ComponentCount - 1 do begin
        if (Components[i] is TadxContextMenu) and (HostType in TadxContextMenu(Components[i]).SupportedApps) then
          TadxContextMenu(Components[i]).ReconnectControls();
      end;
    end;
    ConnectBuiltinControls;
  end;
end;

procedure TadxCOMAddInModule.DoCTPFactoryAvailable;
begin
  try
    if Assigned(FOnCTPFactoryAvailable) then
      FOnCTPFactoryAvailable(FCTPFactory);
  except
    on E: SysUtils.Exception do DoError(E);
  end;
end;

procedure TadxCOMAddInModule.ClearAccessCommandBarsInterfaces();

  procedure ClearSilently(Ctrls: TadxCommandBarControls);
  var
    i: Integer;
    Ctrl: CommandBarControl;
  begin
    for i := 0 to Ctrls.Count - 1 do begin
      if Ctrls[i] is TadxCommandBarPopup then
        ClearSilently(TadxCommandBarPopup(Ctrls[i]).Controls);
      Ctrl := nil;
      Ctrls[i].SetInterface(Ctrl);
    end;
  end;

var
  i: Integer;
  Ctrl: CommandBarControl;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TadxOlInspectorCustomCommandBar then Continue
    else
      if (Components[i] is TadxOlExplorerCustomCommandBar) and (HostType = ohaOutlook) then Continue
      else
        if (Components[i] is TadxCustomCommandBar) and (HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then begin
          ClearSilently(TadxCustomCommandBar(Components[i]).Controls);
          TadxCustomCommandBar(Components[i]).FInterface := nil;
        end;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TadxBuiltInControl then begin
      Ctrl := nil;
      TadxBuiltInControl(Components[i]).SetInterface(Ctrl);
    end;
  FICmdBars := nil;
end;

procedure TadxCOMAddInModule.DoAccessTick(Sender: TObject);
var
  ICurrentProject: _CurrentProject;
  dbName: string;
  isConnected: boolean;
begin
  if not FTimerLocked then begin
    FTimerLocked := True;
    ICurrentProject := AccessApp.CurrentProject;
    if Assigned(ICurrentProject) then begin
      dbName := '';
      isConnected := false;
      try
        isConnected := ICurrentProject.IsConnected;
        dbName := ICurrentProject.FullName;
      except
      end;
      if isConnected then begin
        if (FdbLoaded and (FdbFullName <> dbName)) then ClearAccessCommandBarsInterfaces();
        if (not FdbLoaded or (FdbFullName <> dbName)) then begin
          FdbLoaded := True;
          FdbFullName := dbName;
          try
            Install();
          except
          end;
        end;
      end
      else
        if FdbLoaded then begin
          FdbLoaded := False;
          FdbFullName := dbName;
          ClearAccessCommandBarsInterfaces();
        end;
      ICurrentProject := nil;
    end;
    FTimerLocked := False;
  end;
end;

procedure TadxCOMAddInModule.SetHandleShortcuts(const Value: boolean);
var
  WindowCaption: TGUID;
begin
  if FHandleShortcuts <> Value then begin
    FHandleShortcuts := Value;
    if not (csDesigning in ComponentState) then begin
      if FHostWndHook <> 0 then begin
        UnhookWindowsHookEx(FHostWndHook);
        FHostWndHook := 0;
      end;
      if Assigned(FNativeWindow) then FreeAndNil(FNativeWindow);
      if FHandleShortcuts then begin
        CoCreateGUID(WindowCaption);
        FNativeWindow := TadxNativeWindow.Create(Self, GUIDToString(WindowCaption));
        FHostWndHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, 0, GetCurrentThreadID);
      end;
    end;
  end;
end;

function TadxCOMAddInModule.GetCommandBars(Index: Integer): TadxCustomCommandBar;
begin
  Result := nil;
  try
    Result := TadxCustomCommandBar(FCommandBars[Index]);
  except
    on E: SysUtils.Exception do DoError(E);
  end;
end;

function TadxCOMAddInModule.GetCommandBarsCount: Integer;
begin
  Result := FCommandBars.Count;
end;

function TadxCOMAddInModule.CommandBarIndexByName(const CommandBarName: WideString): TadxCustomCommandBar;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FCommandBars.Count - 1 do
    if TadxCustomCommandBar(FCommandBars[i]).CommandBarName = CommandBarName then begin
      Result := TadxCustomCommandBar(FCommandBars[i]);
      Break;
    end;
end;

function TadxCOMAddInModule.CommandBarIndexOf(const CmdBar: TadxCustomCommandBar): Integer;
begin
  for Result := 0 to FCommandBars.Count - 1 do
    if FCommandBars[Result] = CmdBar then Exit;
  Result := -1;
end;

function TadxCOMAddInModule.ControlByShortcut: TStringList;

  procedure EnumControls(const AControls: TadxCommandBarControls);
  var
    j, Index: Integer;
  begin
    for j := 0 to AControls.Count - 1 do begin
      if AControls[j].GetType = adxButton then begin
        if AControls[j].AsButton.FShortcutText <> '' then
          FControlByShortcut.AddObject(UpperCase(AControls[j].AsButton.FShortcutText), AControls[j]);
        {$IFDEF UNICODE}
        Index := Pos(WideString('&'), AControls[j].AsButton.FCaption);
        {$ELSE}
        Index := Pos('&', AControls[j].AsButton.FCaption);
        {$ENDIF}
        if (Index > 0) and (Index < Length(AControls[j].AsButton.FCaption)) then
          FControlByShortcut.AddObject('ALT+' + UpperCase(AControls[j].AsButton.FCaption[Index + 1]), AControls[j]);
      end;
      if AControls[j].GetType = adxPopup then
        EnumControls(AControls[j].AsPopup.Controls);
    end;
  end;

var
  i: Integer;
  IDsp: IDispatch;
  IExplorer: _Explorer;
  IInspector: _Inspector;
begin
  if FControlByShortcut = nil then
    FControlByShortcut := TStringList.Create;
  FControlByShortcut.Clear;
  if HostType = ohaOutlook then begin
    IDsp := OutlookApp.ActiveWindow;
    if Assigned(IDsp) then
      try
        IDsp.QueryInterface(IID__Explorer, IExplorer);
        if Assigned(IExplorer) then
          try
            for i := 0 to FCommandBars.Count - 1 do
              if HostType in TadxCustomCommandBar(FCommandBars[i]).FSupportedApps then
                if TObject(FCommandBars[i]) is TadxOLInspectorCustomCommandBar then Continue
                else begin
                  if TObject(FCommandBars[i]) is TadxOLExplorerCustomCommandBar then begin
                    try
                      if CheckItemClass(IExplorer.CurrentFolder.DefaultItemType, TadxOLExplorerCustomCommandBar(FCommandBars[i]).ItemTypes) then
                        if TadxOLExplorerCustomCommandBar(FCommandBars[i]).Enabled then
                          EnumControls(TadxOLExplorerCustomCommandBar(FCommandBars[i]).Controls);
                    except
                    end;
                  end
                  else
                    if TObject(FCommandBars[i]) is TadxCustomCommandBar then
                      if TadxCustomCommandBar(FCommandBars[i]).Enabled then
                        EnumControls(TadxCustomCommandBar(FCommandBars[i]).Controls);
                end;
          finally
            IExplorer := nil;
          end
        else begin
          IDsp.QueryInterface(IID__Inspector, IInspector);
          if Assigned(IInspector) then
            try
              for i := 0 to FCommandBars.Count - 1 do
                if HostType in TadxCustomCommandBar(FCommandBars[i]).FSupportedApps then
                  if TObject(FCommandBars[i]) is TadxOLInspectorCustomCommandBar then
                    try
                      if CheckItemClass(OleVariant(IInspector.CurrentItem).Class, TadxOLInspectorCustomCommandBar(FCommandBars[i]).ItemTypes) then
                        if TadxOLInspectorCustomCommandBar(FCommandBars[i]).Enabled then
                          EnumControls(TadxOLInspectorCustomCommandBar(FCommandBars[i]).Controls);
                    except
                    end;
            finally
              IInspector := nil;
            end;
        end;
      finally
        IDsp := nil;
      end;
  end
  else
    for i := 0 to FCommandBars.Count - 1 do
      if HostType in TadxCustomCommandBar(FCommandBars[i]).FSupportedApps then
        EnumControls(TadxCustomCommandBar(FCommandBars[i]).Controls);
  // global shortcuts
  for i := 0 to Self.ComponentCount - 1 do
    if Components[i] is TadxKeyboardShortcut then
      if (HostType in TadxKeyboardShortcut(Components[i]).FSupportedApps) and (TadxKeyboardShortcut(Components[i]).Enabled) then
        FControlByShortcut.AddObject(UpperCase(TadxKeyboardShortcut(Components[i]).FShortcutText), Components[i]);
  Result := FControlByShortcut;
end;

function TadxCOMAddInModule.GetOutlookProfileName: WideString;
type
  TMAPILogonEx = function (ulUIParam: ULONG; lpszProfileName: PChar; lpszPassword: PChar;
                           ulFlags: ULONG; out lppSession: IMAPISession): HResult; stdcall;
  TFreeProws = function (prows: PSRowSet): HResult; stdcall;
var
  MAPIDLLHandle: THandle;
  MAPILogonEx: TMAPILogonEx;
  FreeProws: TFreeProws;
  ISession: IMAPISession;
  ITable: IMAPITable;
  i, j, Count, RType: Cardinal;
  RowSet: PSRowSet; 
begin
  Result := '';
  if HostType = ohaOutlook then begin
    //
    // Call IMAPISession::GetStatusTable to access the status table
    // and find the row that has its PR_RESOURCE_TYPE column set to
    // MAPI_SUBSYSTEM. The PR_DISPLAY_NAME column for this row is the profile name.
    //
    // Do not use the status table during start up because it blocks an
    // application until the MAPI spooler has finished initializing all
    // of the transport providers. This can degrade your performance.
    //
    MAPIDLLHandle := LoadLibrary('mapi32.dll');
    if MAPIDLLHandle > 0 then
      try
        {$IFDEF UNICODE}
        MAPILogonEx := GetProcAddress(MAPIDLLHandle, PAnsiChar(AnsiString('MAPILogonEx')));
        FreeProws := GetProcAddress(MAPIDLLHandle, PAnsiChar(AnsiString('FreeProws@4')));
        {$ELSE}
        MAPILogonEx := GetProcAddress(MAPIDLLHandle, 'MAPILogonEx');
        FreeProws := GetProcAddress(MAPIDLLHandle, 'FreeProws@4');
        {$ENDIF}
        if Assigned(MAPILogonEx) and Assigned(FreeProws) then begin
          MAPILogonEx(0, nil, nil, MAPI_EXTENDED or MAPI_ALLOW_OTHERS, ISession);
          if Assigned(ISession) then
            try
              ISession.GetStatusTable(0, ITable);
              if Assigned(ITable) then
                try
                  if ITable.GetRowCount(0, Count) = S_OK then
                    if ITable.QueryRows(Count, 0, RowSet) = S_OK then
                      try
                        {$R-}
                        for i := 0 to RowSet^.cRows - 1 do begin
                          RType := 0;
                          Result := '';
                          for j := 0 to RowSet^.aRow[i].cValues - 1 do begin
                            if RowSet^.aRow[i].lpProps[j].ulPropTag = PR_DISPLAY_NAME then
                              {$IFDEF UNICODE}
                              Result := WideString(RowSet^.aRow[i].lpProps[j].Value.lpszA);
                              {$ELSE}
                              Result := RowSet^.aRow[i].lpProps[j].Value.lpszA;
                              {$ENDIF}
                            if RowSet^.aRow[i].lpProps[j].ulPropTag = PR_DISPLAY_NAME_W then
                              Result := string(RowSet^.aRow[i].lpProps[j].Value.lpszW);
                            if RowSet^.aRow[i].lpProps[j].ulPropTag = PR_RESOURCE_TYPE then
                              RType := RowSet^.aRow[i].lpProps[j].Value.ul;
                          end;
                          if (RType = MAPI_SUBSYSTEM) and (Result <> '') then
                            Break;
                        end;
                        {$R+}
                      finally
                        FreeProws(RowSet);
                      end;
                finally
                  ITable := nil;
                end;
            finally
              ISession := nil;
            end;
        end;
      finally
        if MAPIDLLHandle <> INVALID_HANDLE_VALUE then FreeLibrary(MAPIDLLHandle);
      end;
  end;
end;

function TadxCOMAddInModule.GetOutlookWindowHandle(const OutlookWindow: IDispatch): HWND;
const
  InspectorCaptionGuid: string = 'ADE6F0D5-0005-406d-B0BF-F9879F100001';
var
  IWindow: IOleWindow;
  OutlookOle, VWordEditor: OleVariant;
  IsVersion2002, IsVersion2003: boolean;
  Caption: WideString;

begin
  Result:= 0;
  try
    IsVersion2003:= pos('11.0', FIApp.Version) > 0;
    IsVersion2002:= pos('10.0', FIApp.Version) > 0;

    OutlookWindow.QueryInterface(IOleWindow, IWindow);
    if Assigned(IWindow) then begin
      IWindow.GetWindow(Result);
      exit;
    end
    else begin
      OutlookOle := OutlookWindow;
      if OutlookOle.Class = olInspector then begin
        if (OutlookOle.IsWordMail) and (IsVersion2002 or IsVersion2003) then begin
          VWordEditor := OutlookOle.WordEditor;
          if not VarIsEmpty(VWordEditor) then begin
            if not VarIsEmpty(VWordEditor.ActiveWindow) then begin
              Caption := VWordEditor.ActiveWindow.Caption;
              try
                VWordEditor.ActiveWindow.Caption := InspectorCaptionGuid;
                Result:= AdxFindWindow(GetDesktopWindow, InspectorCaptionGuid, 'OpusApp', false);
              finally
                VWordEditor.ActiveWindow.Caption := Caption;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    //on e: SysUtils.Exception do ShowMessage('!!! '+e.Message);
  end;
end;

function TadxCOMAddInModule.GetAppCommandBars: CommandBars;
var
  IUnk: IUnknown;
begin
  Result := nil;
  if HostType = ohaMapPoint then Exit;
  IUnk := nil;
  if HostType = ohaOutlook then begin
    if (HostApp.Inspectors.Count > 0) or (HostApp.Explorers.Count > 0) then
      try
        IUnk := HostApp.ActiveWindow.CommandBars;
      except
      end;
  end
  else
    if HostType = ohaInfoPath then
      try
        if IDispatch(HostApp.ActiveWindow) <> nil then
          IUnk := HostApp.ActiveWindow.CommandBars
        else
          if HostApp.Windows.Count > 0 then
            IUnk := HostApp.Windows.Item[0].CommandBars;
      except
      end
    else
      try
        IUnk := HostApp.CommandBars;
      except
      end;
  if Assigned(IUnk) then
    IUnk.QueryInterface(IID__CommandBars, Result);
end;

function TadxCOMAddInModule.FindCommandBar(const CmdBarName: WideString): CommandBar;
var
  i: Integer;
begin
  Result := nil;
  if FICmdBars = nil then FICmdBars := GetAppCommandBars;
  if Assigned(FICmdBars) then begin
    if FFastCommandBarSearch then
      try
        Result := FICmdBars.Get_Item(CmdBarName);
      except
        Result := nil;
      end
    else
      for i := 1 to FICmdBars.Count do begin
        if UpperCase(FICmdBars.Item[i].Name) = UpperCase(CmdBarName) then begin
          Result := FICmdBars.Item[i];
          Break;
        end;
        {$IFDEF ADX_VCL5}
        if UpperCase(FICmdBars.Item[i].NameLocal) = UpperCase(CmdBarName) then
        {$ELSE}
        if WideUpperCase(FICmdBars.Item[i].NameLocal) = WideUpperCase(CmdBarName) then
        {$ENDIF}
        begin
          Result := FICmdBars.Item[i];
          Break;
        end;
      end;
  end;
end;

function TadxCOMAddInModule.FindControl(ACommandBar: CommandBar; AType: MsoControlType;
  ID: Integer): CommandBarControl;
begin
  Result := nil;
  try
    if Assigned(ACommandBar) then begin
      Result := ACommandBar.FindControl(AType, ID, EmptyParam, EmptyParam, True);
      if (Result <> nil) then begin
        //Outlook WordInspector bug
        try
          //Checking IControl validation. WordMail Inspector may returns an invalid control.
          if (Result.Type_ = 999) then raise SysUtils.Exception.Create('This exception must not raise');
        except
          on E: SysUtils.Exception do begin
            Result := ACommandBar.FindControl(AType, ID, EmptyParam, EmptyParam, True);
          end;
        end;
      end;
    end;
  except
    // Outlook 2000 bug
    Result := nil;
  end;
end;

function TadxCOMAddInModule.FindControl(ACommandBar: CommandBar; AType: MsoControlType;
  Tag: WideString): CommandBarControl;
begin
  Result := nil;
  try
    if Assigned(ACommandBar) then begin
      Result := ACommandBar.FindControl(AType, EmptyParam, Tag, EmptyParam, True);
      if (Result <> nil) then begin
        //Outlook WordInspector bug
        try
          //Checking IControl validation. WordMail Inspector may returns an invalid control.
          if (Result.Type_ = 999) then raise SysUtils.Exception.Create('This exception must not raise');
        except
          on E: SysUtils.Exception do begin
            Result := ACommandBar.FindControl(AType, EmptyParam, Tag, EmptyParam, True);
          end;
        end;
      end;
    end;
  except
    // Outlook 2000 bug
    Result := nil;
  end;
end;

function TadxCOMAddInModule.FindControl(AType: MsoControlType; ID: Integer): CommandBarControl;
begin
  Result := nil;
  try
    if FICmdBars = nil then FICmdBars := GetAppCommandBars;
    if Assigned(FICmdBars) then begin
      Result := FICmdBars.FindControl(AType, ID, EmptyParam, EmptyParam);
      if (Result <> nil) then begin
        //Outlook WordInspector bug
        try
          //Checking IControl validation. WordMail Inspector may returns an invalid control.
          if (Result.Type_ = 999) then raise SysUtils.Exception.Create('This exception must not raise');
        except
          on E: SysUtils.Exception do begin
            Result := FICmdBars.FindControl(AType, ID, EmptyParam, EmptyParam);
          end;
        end;
      end;
    end;
  except
    // Outlook 2000 bug
    Result := nil;
  end;
end;

function TadxCOMAddInModule.FindControl(AType: MsoControlType; Tag: WideString): CommandBarControl;
begin
  Result := nil;
  try
    if FICmdBars = nil then FICmdBars := GetAppCommandBars;
    if Assigned(FICmdBars) then begin
      Result := FICmdBars.FindControl(AType, EmptyParam, Tag, EmptyParam);
      if (Result <> nil) then begin
        //Outlook WordInspector bug
        try
          //Checking IControl validation. WordMail Inspector may returns an invalid control.
          if (Result.Type_ = 999) then raise SysUtils.Exception.Create('This exception must n?t raise');
        except
          on E: SysUtils.Exception do begin
            Result := FICmdBars.FindControl(AType, EmptyParam, Tag, EmptyParam);
          end;
        end;
      end;
    end;
  except
    // Outlook 2000 bug
    Result := nil;
  end;
end;

function TadxCOMAddInModule.FindRibbonControl(ID: WideString): TObject;
var
  Index: Integer;
  AObject: TObject;
begin
  Result := nil;
  Index := FRibbonControls.IndexOf(ID);
  if Index >= 0 then
    Result := FRibbonControls.Objects[Index]
  else begin
    // msoID
    for Index := 0 to FRibbonControls.Count - 1 do begin
      AObject := FRibbonControls.Objects[Index];
      if AObject is TadxRibbonTab then begin
        if TadxRibbonTab(AObject).FID = ID then begin
          Result := AObject;
          Break;
        end;
      end
      else
      if AObject is TadxRibbonCommand then begin
        if TadxRibbonCommand(AObject).FID = ID then begin
          Result := AObject;
          Break;
        end;
      end
      else
      if AObject is TadxRibbonCustomControl then begin
        if TadxRibbonCustomControl(AObject).FID = ID then begin
          Result := AObject;
          Break;
        end;
      end;
    end;
  end;
end;

function TadxCOMAddInModule.FindRibbonControl(Tag: Integer): TObject;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FRibbonControls.Count - 1 do begin
    if TObject(FRibbonControls.Objects[i]) is TComponent then begin
      if TComponent(FRibbonControls.Objects[i]).Tag = Tag then begin
        Result := FRibbonControls.Objects[i];
        Break;
      end;
    end
    else begin
      if TadxRibbonCustomControl(TObject(FRibbonControls.Objects[i])).Tag = Tag then begin
        Result := FRibbonControls.Objects[i];
        Break;
      end;
    end;
  end;
end;

function TadxCOMAddInModule.GetRibbonControlEnabled(idMso: WideString): boolean;
var
  ICmdBars: _CommandBars;
begin
  Result := False;
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetEnabledMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlImage(idMso: WideString; Width: Integer = 32; Height: Integer = 32): IPictureDisp;
var
  ICmdBars: _CommandBars;
begin
  Result := nil;
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := IDispatch(OleVariant(ICmdBars).GetImageMso(idMso, Width, Height)) as IPictureDisp;
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlCaption(idMso: WideString): WideString;
var
  ICmdBars: _CommandBars;
begin
  Result := '';
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetLabelMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlPressed(idMso: WideString): boolean;
var
  ICmdBars: _CommandBars;
begin
  Result := False;
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetPressedMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlScreentip(idMso: WideString): WideString;
var
  ICmdBars: _CommandBars;
begin
  Result := '';
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetScreentipMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlSupertip(idMso: WideString): WideString;
var
  ICmdBars: _CommandBars;
begin
  Result := '';
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetSupertipMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

function TadxCOMAddInModule.GetRibbonControlVisible(idMso: WideString): boolean;
var
  ICmdBars: _CommandBars;
begin
  Result := False;
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      Result := OleVariant(ICmdBars).GetVisibleMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

procedure TadxCOMAddInModule.RibbonControlExecute(idMso: WideString);
var
  ICmdBars: _CommandBars;
begin
  ICmdBars := Self.GetAppCommandBars();
  if Assigned(ICmdBars) then
    try
      OleVariant(ICmdBars).ExecuteMso(idMso);
    finally
      ICmdBars := nil;
    end;
end;

procedure TadxCOMAddInModule.ActivateRibbonTabMso(const ControlID: WideString);
begin
  if Assigned(FRibbonUI) then
    if FHostMajorVersion >= 14 then
      try
        FRibbonUI.ActivateTabMso(ControlID);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
end;

procedure TadxCOMAddInModule.ActivateRibbonTabQ(const ControlID: WideString; const Namespace: WideString);
begin
  if Assigned(FRibbonUI) then
    if FHostMajorVersion >= 14 then
      try
        FRibbonUI.ActivateTabQ(ControlID, Namespace);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
end;

procedure TadxCOMAddInModule.SaveExplCommandBars;
var
  i: Integer;
  R: TRegistry;
  CmdBar: TadxOLExplorerCustomCommandBar;
begin
  R := TRegistry.Create;
  try
    try
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxOLExplorerCustomCommandBar then begin
          CmdBar := Components[i] as TadxOLExplorerCustomCommandBar;
          if (CmdBar.BuiltIn) or (not CmdBar.Temporary) then Continue;
          if R.OpenKey(RegistryKey + '\CommandBars\' + CmdBar.FCommandBarName, True) then begin
            R.WriteInteger('Position', Integer(CmdBar.Position));
            R.WriteInteger('Left', CmdBar.CommandBarLeft);
            R.WriteInteger('Top', CmdBar.CommandBarTop);
            R.WriteInteger('RowIndex', CmdBar.RowIndex);
            R.CloseKey;
          end;
        end;
    except
    end;
  finally
    R.Free;
  end;
end;

procedure TadxCOMAddInModule.LoadExplCommandBars;
var
  i: Integer;
  R: TRegistry;
  CmdBar: TadxOLExplorerCustomCommandBar;
  Value: Integer;
begin
  R := TRegistry.Create;
  try
    try
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxOLExplorerCustomCommandBar then begin
          CmdBar := Components[i] as TadxOLExplorerCustomCommandBar;
          if (CmdBar.BuiltIn) or (not CmdBar.Temporary) then Continue;
          if R.OpenKey(RegistryKey + '\CommandBars\' + CmdBar.FCommandBarName, False) then begin
            if R.ValueExists('Position') then begin
              Value := R.ReadInteger('Position');
              if CmdBar.Position <> TadxMsoBarPosition(Value) then
                CmdBar.Position := TadxMsoBarPosition(Value);
            end;
            if R.ValueExists('Left') then begin
              Value := R.ReadInteger('Left');
              if CmdBar.CommandBarLeft <> Value then
                CmdBar.CommandBarLeft := Value;
            end;
            if R.ValueExists('Top') then begin
              Value := R.ReadInteger('Top');
              if CmdBar.CommandBarTop <> Value then
                CmdBar.CommandBarTop := Value;
            end;
            if R.ValueExists('RowIndex') then begin
              Value := R.ReadInteger('RowIndex');
              if CmdBar.RowIndex <> Value then
                CmdBar.RowIndex := Value;
            end;
            R.CloseKey;
          end;
        end;
    except
    end;
  finally
    R.Free;
  end;
end;

procedure TadxCOMAddInModule.InstallShortcuts;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TadxOLBarShortcutManager then
      TadxOLBarShortcutManager(Components[i]).Install;
end;

procedure TadxCOMAddInModule.UninstallShortcuts;
var
  i: Integer;
  IExpl: _Explorer;
begin
  try
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxOLBarShortcutManager then begin
        if IExpl = nil then
          IExpl := IDispatch(FIApp.GetNamespace('MAPI').GetDefaultFolder(olFolderInbox).GetExplorer) as _Explorer;
        if Assigned(IExpl) then
          TadxOLBarShortcutManager(Components[i]).Uninstall(IExpl);
      end;
  finally
    if Assigned(IExpl) then begin
      IExpl.Close;
      IExpl := nil;
    end;
  end;
end;

procedure TadxCOMAddInModule.InstallSolutionModules();
var
  i: Integer;
begin
  if FHostMajorVersion >= 14 then
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxOLSolutionModule then
        TadxOLSolutionModule(Components[i]).Install;
end;

function GetMajorVersion(const Version: WideString): Integer;
begin
  Result := 9;
  try
    // Case #1621
    {$IFDEF UNICODE}
    if Pos(WideString('.'), Version) > 0 then
      Result := StrToInt(System.Copy(Version, 1, Pos(WideString('.'), Version) - 1))
    else
      if Pos(WideString(','), Version) > 0 then
        Result := StrToInt(System.Copy(Version, 1, Pos(WideString(','), Version) - 1))
    {$ELSE}
    if Pos('.', Version) > 0 then
      Result := StrToInt(System.Copy(Version, 1, Pos('.', Version) - 1))
    else
      if Pos(',', Version) > 0 then
        Result := StrToInt(System.Copy(Version, 1, Pos(',', Version) - 1))
    {$ENDIF}
  except
    Result := 9;
  end;
end;

procedure TadxCOMAddInModule.SetHostApplication;

  function FindHostEventsComponent(const AType: TadxCustomEventsClass): TadxCustomEvents;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to Self.ComponentCount - 1 do
      if Self.Components[i] is AType then begin
        Result := (Self.Components[i]) as AType;
        Break;
      end;
  end;

var
  Version: string;
  IDsp: IDispatch;
  IWord: Word2000._Application;
  IExcel: Excel2000._Application;
  IOutlook: Outlook2000._Application;
  IAccess: Access2000._Application;
  IProject: Project2000._MSProject;
  IPowerPoint: MSPPt2000._Application;
  IFrontPage: FrontPage2000._Application;
  IMapPoint: MapPoint2002._Application;
  IVisio: Visio2002.IVApplication;
  IPublisher: Publisher2003._Application;
  IInfoPath: InfoPath2007._Application3;
begin
  IDsp := FIApp;
  if IDsp.QueryInterface(Word2000._Application, IWord) = S_OK then begin
    FHostType := ohaWord;
    FWord := TWordApplication.Create(nil);
    FWord.ConnectTo(IWord);
    Self.FHostMajorVersion := GetMajorVersion(FWord.Version);
    if Self.FHostMajorVersion > 11 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxWordAppEvents);
    if Assigned(FHostEvents) then begin
      Version := IWord.Version;
      if Version <> '' then
        if Pos('.', Version) > 1 then
          Delete(Version, Pos('.', Version), Length(Version));
      TadxWordAppEvents(FHostEvents).ConnectTo(IWord, Version);
      if Assigned(TadxWordAppEvents(FHostEvents).OnStartup) then
        try
          TadxWordAppEvents(FHostEvents).OnStartup(FHostEvents);
        except
          on E: SysUtils.Exception do Self.DoError(E);
        end;
    end;
  end
  else if IDsp.QueryInterface(Excel2000._Application, IExcel) = S_OK then begin
    FHostType := ohaExcel;
    FExcel := TExcelApplication.Create(nil);
    FExcel.ConnectTo(IExcel);
    {$IFDEF ADX_VCL6}
    Self.FHostMajorVersion := GetMajorVersion(OleVariant(FExcel.DefaultInterface).Version);
    {$ELSE}
    Self.FHostMajorVersion := GetMajorVersion(FExcel.Version[adxLCID]);
    {$ENDIF}
    if Self.FHostMajorVersion > 11 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxExcelAppEvents);
    if Assigned(FHostEvents) then
      TadxExcelAppEvents(FHostEvents).ConnectTo(IExcel);
  end
  else if IDsp.QueryInterface(Outlook2000._Application, IOutlook) = S_OK then begin
    FHostType := ohaOutlook;
    FOutlook := TOutlookApplication.Create(nil);
    FOutlook.ConnectTo(IOutlook);
    Version := IOutlook.Version;
    Self.FHostMajorVersion := GetMajorVersion(Version);
    if Self.FHostMajorVersion > 11 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxOutlookAppEvents);
    if Assigned(FHostEvents) then begin
      if Version <> '' then
        if Pos('.', Version) > 1 then
          Delete(Version, Pos('.', Version), Length(Version));
      TadxOutlookAppEvents(FHostEvents).ConnectTo(IOutlook, Version);
    end;
    if FIsRibbon then begin
      FOutlook2007InternalWrapper := TadxOutlook2007Application.Create(Self);
      TadxOutlook2007Application(FOutlook2007InternalWrapper).ConnectTo(IOutlook);
    end;
  end
  else if IDsp.QueryInterface(Access2000._Application, IAccess) = S_OK then begin
    FHostType := ohaAccess;
    FAccess := TAccessApplication.Create(nil);
    FAccess.ConnectTo(IAccess);
    try
      Self.FHostMajorVersion := GetMajorVersion(OleVariant(FAccess.DefaultInterface).Version);
    except
      Self.FHostMajorVersion := 9;
    end;
    if Self.FHostMajorVersion > 11 then FIsRibbon := True;
  end
  else if IDsp.QueryInterface(Project2000._MSProject, IProject) = S_OK then begin
    FHostType := ohaProject;
    FProject := TProjectApplication.Create(nil);
    FProject.ConnectTo(IProject);
    Self.FHostMajorVersion := GetMajorVersion(IProject.Version);
    if Self.FHostMajorVersion > 12 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxProjectAppEvents);
    if Assigned(FHostEvents) then begin
      Version := IProject.Version;
      if Version <> '' then
        if Pos('.', Version) > 1 then
          Delete(Version, Pos('.', Version), Length(Version));
      TadxProjectAppEvents(FHostEvents).ConnectTo(IProject, Version);
    end;
  end
  else if IDsp.QueryInterface(MSPPt2000._Application, IPowerPoint) = S_OK then begin
    FHostType := ohaPowerPoint;
    FPowerPoint := TPowerPointApplication.Create(nil);
    FPowerPoint.ConnectTo(IPowerPoint);
    Self.FHostMajorVersion := GetMajorVersion(FPowerPoint.Version);
    if Self.FHostMajorVersion > 11 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxPowerPointAppEvents);
    if Assigned(FHostEvents) then
      TadxPowerPointAppEvents(FHostEvents).ConnectTo(IPowerPoint);
  end
  else if IDsp.QueryInterface(FrontPage2000._Application, IFrontPage) = S_OK then begin
    FHostType := ohaFrontPage;
    FFrontPage := TFrontPageApplication.Create(nil);
    FFrontPage.ConnectTo(IFrontPage);
    Self.FHostMajorVersion := GetMajorVersion(IFrontPage.Version);
    FHostEvents := FindHostEventsComponent(TadxFrontPageAppEvents);
    if Assigned(FHostEvents) then
      TadxFrontPageAppEvents(FHostEvents).ConnectTo(IFrontPage);
  end
  else if IDsp.QueryInterface(MapPoint2002._Application, IMapPoint) = S_OK then begin
    FHostType := ohaMapPoint;
    FMapPoint := TMapPointApplication.Create(nil);
    FMapPoint.ConnectTo(IMapPoint);
    Self.FHostMajorVersion := GetMajorVersion(IMapPoint.Version);
    FHostEvents := FindHostEventsComponent(TadxMapPointAppEvents);
    if Assigned(FHostEvents) then
      TadxMapPointAppEvents(FHostEvents).ConnectTo(IMapPoint);
  end
  else if IDsp.QueryInterface(Visio2002.IVApplication, IVisio) = S_OK then begin
    FHostType := ohaVisio;
    FVisio := TVisioApplication.Create(nil);
    FVisio.ConnectTo(IVisio);
    Self.FHostMajorVersion := GetMajorVersion(IVisio.Version);
    if Self.FHostMajorVersion > 12 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxVisioAppEvents);
    if Assigned(FHostEvents) then
      TadxVisioAppEvents(FHostEvents).ConnectTo(IVisio);
  end
  else if IDsp.QueryInterface(Publisher2003._Application, IPublisher) = S_OK then begin
    FHostType := ohaPublisher;
    FPublisher := Publisher2003.TApplication.Create(nil);
    FPublisher.ConnectTo(IPublisher);
    Self.FHostMajorVersion := GetMajorVersion(IPublisher.Version);
    if Self.FHostMajorVersion > 12 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxPublisherAppEvents);
    if Assigned(FHostEvents) then
      TadxPublisherAppEvents(FHostEvents).ConnectTo(IPublisher);
  end
  else if IDsp.QueryInterface(InfoPath2007._Application3, IInfoPath) = S_OK then begin
    FHostType := ohaInfoPath;
    FInfoPath := InfoPath2007.TApplication.Create(nil);
    FInfoPath.ConnectTo(IInfoPath);
    Self.FHostMajorVersion := GetMajorVersion(IInfoPath.Version);
    if Self.FHostMajorVersion > 12 then FIsRibbon := True;
    FHostEvents := FindHostEventsComponent(TadxInfoPathAppEvents);
    if Assigned(FHostEvents) then
      TadxInfoPathAppEvents(FHostEvents).ConnectTo(IInfoPath);
  end;
end;

procedure TadxCOMAddInModule.FreeHostApplication;
begin
  if Assigned(FHostEvents) then FHostEvents.Disconnect;
  case HostType of
    ohaWord: if Assigned(FWord) then FreeAndNil(FWord);
    ohaExcel: if Assigned(FExcel) then FreeAndNil(FExcel);
    ohaOutlook: begin
      if Assigned(FOutlook) then FreeAndNil(FOutlook);
      if Assigned(FOutlook2007InternalWrapper) then begin
        TadxOutlook2007Application(FOutlook2007InternalWrapper).Disconnect();
        TadxOutlook2007Application(FOutlook2007InternalWrapper) := nil;
      end;
    end;
    ohaAccess: begin
      FAccessTimer.Enabled := False;
      if Assigned(FAccess) then FreeAndNil(FAccess);
    end;
    ohaProject: if Assigned(FProject) then FreeAndNil(FProject);
    ohaPowerPoint: if Assigned(FPowerPoint) then FreeAndNil(FPowerPoint);
    ohaFrontPage: if Assigned(FFrontPage) then FreeAndNil(FFrontPage);
    ohaMapPoint: if Assigned(FMapPoint) then FreeAndNil(FMapPoint);
    ohaVisio: if Assigned(FVisio) then FreeAndNil(FVisio);
    ohaPublisher: if Assigned(FPublisher) then FreeAndNil(FPublisher);
    ohaInfoPath: if Assigned(FInfoPath) then FreeAndNil(FInfoPath);
  end;
end;

procedure TadxCOMAddInModule.AddMapPointCommand(const DisplayName,
  MethodName: WideString);
begin
  if HostType = ohaMapPoint then
    MapPointApp.AddCommand(DisplayName, MethodName, Self.FCOMAddInClassInstance)
  else
    raise EADXException.Create(adxErrorMapPointOnly, adxECodeMapPointOnly, 0);
end;

procedure TadxCOMAddInModule.SetSupportedApps(const Value: TadxHostAppSet);
begin
  if Value = [] then
    raise EADXException.Create(Format(adxErrorCantBeEmpty, ['SupportedApps']), adxECodeCantBeEmpty, 0);
  FSupportedApps := Value;
end;

procedure TadxCOMAddInModule.SetAddInName(const Value: string);
begin
  if Value = '' then
    raise EADXException.Create(Format(adxErrorCantBeEmpty, ['AddInName']), adxECodeCantBeEmpty, 0);
  FAddInName := Value;
end;

procedure TadxCOMAddInModule.Install;
var
  i: Integer;
  ItemClass: OlObjectClass;
  FullName: WideString;
  TempBar: TadxOlExplorerCustomCommandBar;
  IFolder: MAPIFolder;
begin
  for i := 0 to ComponentCount - 1 do
    // context menu
    if (Components[i] is TadxContextMenu) and (HostType in TadxContextMenu(Components[i]).SupportedApps) and (HostType = ohaOutlook) then begin
      if not FIsRibbon then begin
        if TadxContextMenu(Components[i]).CommandBarName = 'ItemContextMenu' then
          TadxContextMenu(Components[i]).FCommandBarName := 'Context Menu';
        if TadxContextMenu(Components[i]).CommandBarName = 'FolderContextMenu' then
          TadxContextMenu(Components[i]).FCommandBarName := 'Folder Context Menu';
      end;
      Continue;
    end
    else
    if Components[i] is TadxOlInspectorCustomCommandBar then Continue
    else
      if (Components[i] is TadxOlExplorerCustomCommandBar) and (HostType = ohaOutlook) then
      begin
        if OutlookApp.ActiveExplorer = nil then Break;
        TempBar := TadxOlExplorerCustomCommandBar(Components[i]);
        InternalAddCmdBar(TempBar);
        try
          IFolder := OutlookApp.ActiveExplorer.CurrentFolder;
        except
          // outlook 2000
          IFolder := nil;
        end;
        if Assigned(IFolder) then FullName := GetFullFolderName(IFolder)
        else FullName := '';
        if not TempBar.BuiltIn and (TempBar.FolderName <> '') then
          TempBar.Enabled := TempBar.FolderName = FullName
        else
          if not TempBar.BuiltIn and (TempBar.FolderNames.Text <> '') then
            TempBar.Enabled := TempBar.FolderNames.IndexOf(FullName) <> -1
          else
            if not TempBar.BuiltIn and Assigned(IFolder) then begin
              ItemClass := IFolder.DefaultItemType;
              TempBar.Enabled := CheckItemClass(ItemClass, TempBar.ItemTypes);
            end;
        TempBar.Visible := TempBar.Enabled;
        if Assigned(IFolder) and (TempBar.Enabled) then
          try
            ScanExplControls(IFolder.DefaultItemType, TempBar.Controls);
          finally
            IFolder := nil;
          end;
      end
      else
// GARANT { // FIX DUPLICATED COMMAND BARS
        if (Components[i] is TadxCustomCommandBar) and (HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
          if ((HostType <> ohaWord) or (Components[i] is TadxContextMenu)) then
            InternalAddCmdBar(TadxCustomCommandBar(Components[i]));
// GARANT } // FIX DUPLICATED COMMAND BARS
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TadxBuiltInControl then begin
      InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
      {$IFDEF ADX_TRIAL}
      Break;
      {$ENDIF}
    end;
end;

procedure TadxCOMAddInModule.InternalAddCmdBar(const ACmdBar: TadxCustomCommandBar);

  function ControlExist(AControls: TadxCommandBarControls; ATag: WideString): boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to AControls.Count - 1 do begin
      Result := AControls[i].FOfficeTag = ATag;
      if not Result and (AControls[i] is TadxCommandBarPopup) then
        Result := ControlExist(AControls[i].AsPopup.Controls, ATag);
      if Result then Exit;
    end;
  end;

  procedure CheckHungControls;
  var
    i, j: Integer;
    R: TRegistry;
    Tags: TStringList;
    IsDelete: boolean;
    IControl: CommandBarControl;
  begin
    Tags := TStringList.Create;
    R := TRegistry.Create;
    try
      if R.OpenKey(RegistryKey + '\Controls', False) then begin
        R.GetValueNames(Tags);
        for i := 0 to Tags.Count - 1 do begin
          IsDelete := True;
          for j := 0 to ComponentCount - 1 do
            if Components[j] is TadxCustomCommandBar then
              if ControlExist(TadxCustomCommandBar(Components[j]).Controls, Tags[i]) then begin
                IsDelete := False;
                Break;
              end;
          if IsDelete then begin
            IControl := ACmdBar.DefaultInterface.FindControl(EmptyParam, EmptyParam, Tags[i], EmptyParam, True);
            if IControl = nil then
              IControl := FICmdBars.FindControl(EmptyParam, EmptyParam, Tags[i], EmptyParam);
            if Assigned(IControl) then
              try
                IControl.Delete(False);
                R.DeleteValue(Tags[i]);
              finally
                IControl := nil;
              end;
          end;
        end;
        R.CloseKey;
      end;
    finally
      R.Free;
      Tags.Free;
    end;
  end;

var
  i: Integer;
// GARANT { // WORD TEMPLATES SAVED STATUS
  Count: Integer;
  Saved: array of WordBool;
// } GARANT // WORD TEMPLATES SAVED STATUS
begin
  if HostType = ohaMapPoint then
    raise EADXException.Create(adxErrorDoesntSupport, adxECodeDoesntSupport, 0);
  if (HostType = ohaOutlook) and (Pos(#39, Name) > 0) then
    raise EADXException.Create(Format(adxErrorIllegalCharacter, [ACmdBar.FCommandBarName]),
      adxECodeIllegalCharacter, 0);
  if not (HostType in ACmdBar.SupportedApps) then Exit;
// GARANT { // FIX SHOW COMMAND BARS IN OUTLOOK
  if not ACmdBar.UseForRibbon and Self.FIsRibbon and ((HostType <> ohaOutlook) or (HostMajorVersion > 12)) then Exit;
// } GARANT // FIX SHOW COMMAND BARS IN OUTLOOK
// GARANT { // WORD TEMPLATES SAVED STATUS
  try
    if HostType = ohaWord then begin
      Count := HostApp.Templates.Count;
      //
      SetLength(Saved, Count);
      for i := 1 to Count do
        try
          Saved[Pred(i)] := HostApp.Templates.Item(i).Saved;
        except
          Count := Pred(i);
          Break;
        end;
      SetLength(Saved, Count);
    end;
  except
  end;
  try
// } GARANT // WORD TEMPLATES SAVED STATUS
  try
    ACmdBar.FInterface := FindCommandBar(ACmdBar.FCommandBarName);
    // context menu
    if ACmdBar is TadxContextMenu then
      TadxContextMenu(ACmdBar).DoAddControls();
    if ACmdBar.DefaultInterface = nil then begin
      // temporary command bar (Outlook)
      if HostType = ohaOutlook then
        try
          ACmdBar.FInterface := FICmdBars.Add(ACmdBar.FCommandBarName, ACmdBar.FPosition, EmptyParam, ACmdBar.Temporary);
          ACmdBar.CommandBarNameLocal := ACmdBar.CommandBarName;
        except
          ACmdBar.FInterface := nil;
        end
      else begin
        // Case #1873
        try
          ACmdBar.FInterface := FICmdBars.Add(ACmdBar.FCommandBarName, ACmdBar.FPosition, EmptyParam, ACmdBar.Temporary);
          ACmdBar.CommandBarNameLocal := ACmdBar.CommandBarName;
        except
          ACmdBar.FInterface := nil;
        end
      end;
    end;
    if Assigned(ACmdBar.DefaultInterface) and not ACmdBar.BuiltIn then
      ACmdBar.SetProperties;
  except
    on E: SysUtils.Exception do DoError(E);
  end;
  if not COMAddInClassFactory.FDeprecatedVersion then CheckHungControls;
  if Assigned(ACmdBar.DefaultInterface) then
    {$IFDEF ADX_TRIAL}
    if ACmdBar.Controls.Count > 0 then begin
      i := 0;
      InternalAddControl(ACmdBar.Controls.Items[i], ACmdBar);
    end;
    {$ELSE}
    for i := 0 to ACmdBar.Controls.Count - 1 do
      InternalAddControl(ACmdBar.Controls.Items[i], ACmdBar);
    {$ENDIF}
// GARANT { // WORD TEMPLATES SAVED STATUS
  finally
  try
    if HostType = ohaWord then
      for i := 1 to Count do
        try
          HostApp.Templates.Item(i).Saved := Saved[Pred(i)];
        except
        end;
  except
  end;
  end;
// } GARANT // WORD TEMPLATES SAVED STATUS
end;

procedure TadxCOMAddInModule.InternalAddControl(const AControl: TadxCommandBarControl;
  const ACmdBar: TadxCustomCommandBar; APopup: TadxCommandBarPopup = nil);

  function GetChanged(OfficeTag: string): Longword;
  begin
    Result := High(Longword);
    with TRegistry.Create do
      try
        if OpenKey(RegistryKey + '\Controls', False) then begin
          if ValueExists(OfficeTag) then
            Result := ReadInteger(OfficeTag);
          CloseKey;
        end;
      finally
        Free;
      end;
  end;

  function CalcBefore(Before, BeforeID, AfterID: Integer; CmdBar: CommandBar): OleVariant;
  var
    ICtrl: CommandBarControl;
  begin
    Result := EmptyParam;
    if (Before <> 0) then Result := Before
    else
      try
        if (BeforeID <> 0) then begin
          ICtrl := CmdBar.FindControl(EmptyParam, BeforeID, EmptyParam, EmptyPAram, True);
          if Assigned(ICtrl) then Result := ICtrl.Index;
        end
        else
          if (AfterID <> 0) then begin
            ICtrl := CmdBar.FindControl(EmptyParam, AfterID, EmptyParam, EmptyPAram, True);
            if Assigned(ICtrl) then Result := ICtrl.Index + 1;
          end;
      finally
        ICtrl := nil;
      end;
  end;

var
  i: Integer;
  ICommandBar: CommandBar;
  IControl: CommandBarControl;
  IButton: CommandBarButton;
  IComboBox: CommandBarCombobox;
  IPopup: CommandBarPopup;
  Popup: TadxCommandBarPopup;
  TempControl: TadxCommandBarAdvancedControl;
begin
  if HostType = ohaMapPoint then
    raise EADXException.Create(adxErrorDoesntSupport, adxECodeDoesntSupport, 0);
  if not Assigned(ACmdBar) or not Assigned(ACmdBar.DefaultInterface) then Exit;
  ICommandBar := ACmdBar.DefaultInterface;
  try
    case AControl.GetType of
      adxAdvancedControl:
        if Assigned(adxControlAdapterClasses[Self.HostType]) and
          Assigned((AControl as TadxCommandBarAdvancedControl).Control) then
        begin
          if ICommandBar.BuiltIn then
            raise EADXException.Create(adxErrorACBuiltInCmdBar, adxECodeACBuiltInCmdBar, 0);
          try
            TempControl := AControl as TadxCommandBarAdvancedControl;
            if not Assigned(TempControl.FControlAdapter) then
              TempControl.FControlAdapter := adxControlAdapterClasses[HostType].Create(TempControl);
            if Assigned(TempControl.FControlAdapter) then
              AControl.FInterface := TempControl.FControlAdapter.CreateInstance;
            with AControl do begin
              SetBeginGroup(FBeginGroup);
              SetCaption(FCaption);
              SetDescriptionText(FDescriptionText);
              SetEnabled(FEnabled);
              SetHelpContextID(FHelpContextID);
              SetHelpFile(FHelpFile);
              SetParameter(FParameter);
              SetPriority(FPriority);
              SetOfficeTag(FOfficeTag);
              SetTooltipText(FTooltipText);
              SetVisible(FVisible);
            end;
          except
          end;
        end;
      adxControl:
        if AControl.FOfficeID <> 1 then
          try
            IControl := ICommandBar.FindControl(EmptyParam, AControl.FOfficeID,
              AControl.FOfficeTag, EmptyParam, True);
            if IControl = nil then begin
              // user delete control
              if not AControl.Temporary and
                (AControl.FChanged = GetChanged(AControl.FOfficeTag)) then
              begin
                ICommandBar := nil;
                Exit;
              end;
              if Assigned(APopup) then
                IControl := APopup.DefaultInterface.Controls.Add(
                  EmptyParam, AControl.FOfficeID, AControl.FParameter,
                  CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, APopup.DefaultInterface.CommandBar),
                  AControl.Temporary)
              else
                IControl := ICommandBar.Controls.Add(
                  EmptyParam, AControl.FOfficeID, AControl.FParameter,
                  CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, ICommandBar),
                  AControl.Temporary);
            end;
            AControl.FInterface := IControl;
            AControl.SetProperties;
          finally
            IControl := nil;
          end;
      adxButton, adxEdit, adxDropdown, adxComboBox:
        try
// GARANT { // FIX DUPLICATED COMMAND BARS
          if (AControl.FOfficeID = 1) and (HostType <> ohaWord) then
            IControl := FindControl(TMsoControls[AControl.GetType], AControl.FOfficeTag)
          else
// GARANT } // FIX DUPLICATED COMMAND BARS
            IControl := FindControl(ICommandBar, TMsoControls[AControl.GetType], AControl.FOfficeTag);
          if IControl = nil then begin
            // user delete control
            if not AControl.Temporary and
              (AControl.FChanged = GetChanged(AControl.FOfficeTag)) then
            begin
              if (Self.HostType <> ohaAccess) then begin
                ICommandBar := nil;
                Exit;
              end;
            end;
            if Assigned(APopup) then
              IControl := APopup.DefaultInterface.Controls.Add(
                TMsoControls[AControl.GetType], AControl.FOfficeID, AControl.FParameter,
                CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, APopup.DefaultInterface.CommandBar),
                AControl.Temporary)
            else
              IControl := ICommandBar.Controls.Add(
                TMsoControls[AControl.GetType], AControl.FOfficeID, AControl.FParameter,
                CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, ICommandBar),
                AControl.Temporary);
          end;
          if Assigned(IControl) then begin
            if AControl.GetType = adxButton then begin
              IControl.QueryInterface(IID__CommandBarButton, IButton);
              TadxCommandBarButton(AControl).SetInterface(IButton);
              if AControl.AsButton.OfficeID <> 1 then
                try
                  if AControl.AsButton.DisableStandardAction then
                    IControl.Set_OnAction('!<' + COMAddInClassFactory.ProgID + '>')
                  else
                    IControl.Set_OnAction('');
                except
                  // skip (PowerPoint2003, Visio2003)
                end;
              // Case #1118 Fast Start (LoadBehavior = 16)
              if (Self.LoadBehavior = 16) and
                (AControl.AsButton.OfficeID = 1) and
                (AControl.Temporary = False) then
              begin
                try
                  IControl.Set_OnAction('!<' + COMAddInClassFactory.ProgID + '>');
                except
                end;
              end;
            end
            else begin
              IControl.QueryInterface(IID__CommandBarComboBox, IComboBox);
              TadxCustomCommandBarComboBox(AControl).SetInterface(IComboBox);
            end;
            AControl.SetProperties;
          end;
        finally
          IButton := nil;
          IComboBox := nil;
          IControl := nil;
        end;
      adxPopup:
        begin
          Popup := AControl as TadxCommandBarPopup;
          if Popup.FOfficeID <> 1 then
            IPopup := FindControl(ICommandBar, msoControlPopup, Popup.FOfficeID) as CommandBarPopup
          else begin
            IPopup := FindControl(msoControlPopup, Popup.FOfficeTag) as CommandBarPopup;
            if IPopup = nil then begin
              // user delete control
              if not Popup.Temporary and
                (Popup.FChanged = GetChanged(Popup.FOfficeTag)) then
              begin
                ICommandBar := nil;
                Exit;
              end;
              if Assigned(APopup) then
                IPopup := APopup.DefaultInterface.Controls.Add(msoControlPopup,
                  EmptyParam, Popup.FParameter,
                  CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, APopup.DefaultInterface.CommandBar),
                  Popup.Temporary) as CommandBarPopup
              else
                IPopup := ICommandBar.Controls.Add(msoControlPopup,
                  EmptyParam, Popup.FParameter,
                  CalcBefore(AControl.Before, AControl.BeforeID, AControl.AfterID, ICommandBar),
                  Popup.Temporary) as CommandBarPopup
            end;
          end;
          if Assigned(IPopup) then begin
            Popup.SetInterface(IPopup);
            if Popup.FOfficeID = 1 then Popup.SetProperties;
            {$IFDEF ADX_TRIAL}
            if Popup.Controls.Count > 0 then begin
              i := 0;
              InternalAddControl(Popup.Controls.Items[i], ACmdBar, Popup);
            end;
            {$ELSE}
            for i := 0 to Popup.Controls.Count - 1 do
              InternalAddControl(Popup.Controls.Items[i], ACmdBar, Popup);
            {$ENDIF}
          end;
        end;
    end;
    ICommandBar := nil;
  except
    on E: SysUtils.Exception do DoError(E);
  end;
end;

procedure TadxCOMAddInModule.InternalAddBuiltInControl(const AControl: TadxBuiltInControl);
var
  i: Integer;
  Ctrls: CommandBarControls;                
begin
  try
    if FIsRibbon then begin
      // Outlook 2007 - partial ribbon
      if not ((FHostType = ohaOutlook) and (FHostMajorVersion = 12)) then begin
        if AControl.FCommandBar = nil then Exit;
        if not AControl.FCommandBar.UseForRibbon then Exit;
      end;
    end;

    // InfoPath 2 0 0 7 bug
    if HostType = ohaInfoPath then Exit;
    if FICmdBars = nil then FICmdBars := GetAppCommandBars;
    if Assigned(FICmdBars) and (AControl.BuiltInID <> 1) then begin
      // FindControl may return a control of a wrong type. See Id=568 in Outlook,
      // for instance: the Context menu for a contact contains a button
      // and a contact inspector contains a split button both having the same ID.

      // Use FindControls and check the control type.
      Ctrls := FICmdBars.FindControls(EmptyParam, AControl.BuiltInID, EmptyParam, EmptyParam);
      if Assigned(Ctrls) and (Ctrls.Count >= 1) then
      try
        for i := 1 to Ctrls.Count do begin
          if Ctrls.Item[i].type_ in [msoControlButton, msoControlComboBox] then begin
            // fixed: two print buttons in the Outlook 2003 Explorer
            if not Ctrls.Item[i].Visible then Continue;
            // Connect to the first control of a correct type.
            // All controls of the same ID trigger the same even sink
            AControl.SetInterface(Ctrls.Item[i]);
            // Don't use Tag because two addins may work with the same control
            //Ctrls.Item[i].Set_Tag(AControl.FOfficeTag);
            try
              // case #645
              //if AControl.DisableStandardAction then
              //  Ctrls.Item[i].Set_OnAction('!<' + COMAddInClassFactory.ProgID + '>')
              //else
              //  Ctrls.Item[i].Set_OnAction('');
            except
              // skip (PowerPoint2003, Visio2003)
            end;
            break;
          end;
        end;
      finally
        Ctrls := nil;
      end;

      if Assigned(AControl.DefaultInterface) then begin
        // Case #736
        //AControl.OfficeTag := AControl.FOfficeTag;
        try
          // case #645
          //if AControl.DisableStandardAction then
          //  AControl.DefaultInterface.Set_OnAction('!<' + COMAddInClassFactory.ProgID + '>')
          //else
          //  AControl.DefaultInterface.Set_OnAction('');
        except
          // skip (PowerPoint2003, Visio2003)
        end;
      end;
    end;
  except
  end;
end;

function TadxCOMAddInModule.GetRegistryKey: string;
begin
  Result := '';
  if Assigned(COMAddInClassFactory) then
    Result := COMAddInClassFactory.GetRegKey(HostType);
end;

procedure TadxCOMAddInModule.OptionsPagesAdd(ASender: TObject; const Pages: PropertyPages);
begin
end;

procedure TadxCOMAddInModule.NameSpaceOptionsPagesAdd(ASender: TObject;
  const Pages: PropertyPages; const Folder: MAPIFolder);
begin
end;

function TadxCOMAddInModule.GetOutlookShutdownBehavior: TadxOutlookShutdownBehavior;
var
  GlobalFlag, AddinFlag: Integer;
begin
  Result := osSlow;
  if (Self.HostType = ohaOutlook) then begin
    if Assigned(Self.OutlookApp) and Assigned(Self.OutlookApp.DefaultInterface) then begin
      if FHostMajorVersion >= 14 then begin
        Result := osFast;
        // check global settings
        with TRegistry.Create(KEY_READ) do
          try
            RootKey := HKEY_CURRENT_USER;
            if KeyExists(Format('Software\Microsoft\Office\%d.0\Outlook\Options\Shutdown', [FHostMajorVersion])) then
              if OpenKey(Format('Software\Microsoft\Office\%d.0\Outlook\Options\Shutdown', [FHostMajorVersion]), False) then
                try
                  if ValueExists('AddinFastShutdownBehavior') then begin
                    GlobalFlag := ReadInteger('AddinFastShutdownBehavior');
                    if GlobalFlag = 1 then begin
                      Result := osSlow;
                      Exit;
                    end;
                  end;
                finally
                  CloseKey();
                end;
          finally
            Free();
          end;
        end;
        // check add-in settings
        with TRegistry.Create(KEY_READ) do
          try
            if Self.RegisterForAllUsers then
              RootKey := HKEY_LOCAL_MACHINE
            else
              RootKey := HKEY_CURRENT_USER;
            if KeyExists(Self.RegistryKey) then
              if OpenKey(Self.RegistryKey, False) then
                try
                  if ValueExists('RequireShutdownNotification') then begin
                    AddinFlag := ReadInteger('RequireShutdownNotification');
                    if AddinFlag = 1 then Result := osSlow;
                  end;
                finally
                  CloseKey();
                end;
          finally
            Free();
          end;
      end;
  end;
end;

procedure TadxCOMAddInModule.SetStartFromScratch(Value: TadxRibbons);
begin
  FStartFromScratch := Value;
  if msrOutlookExplorer in Value then
    FStartFromScratch2010 := FStartFromScratch2010 + [msrOutlookExplorer2010]
  else
    FStartFromScratch2010 := FStartFromScratch2010 - [msrOutlookExplorer2010];
end;

procedure TadxCOMAddInModule.SetStartFromScratch2010(Value: TadxRibbons2010);
begin
  FStartFromScratch2010 := Value;
  if msrOutlookExplorer2010 in Value then
    FStartFromScratch := FStartFromScratch + [msrOutlookExplorer]
  else
    FStartFromScratch := FStartFromScratch - [msrOutlookExplorer];
end;

// Case #952
function TadxCOMAddInModule.GetHostVersion: WideString;
begin
  Result := '';
  try
    case FHostType of
      ohaWord: Result := FWord.Version;
      ohaExcel:
        {$IFDEF ADX_VCL6}
        Result := OleVariant(FExcel.DefaultInterface).Version;
        {$ELSE}
        Result := FExcel.Version[adxLCID];
       {$ENDIF}
      ohaOutlook: Result := FOutlook.Version;
      ohaAccess: Result := OleVariant(FAccess.DefaultInterface).Version;
      ohaProject: Result := FProject.Version;
      ohaPowerPoint: Result := FPowerPoint.Version;
      ohaFrontPage: Result := FFrontPage.Version;
      ohaMapPoint: Result := FMapPoint.Version;
      ohaVisio: Result := FVisio.Version;
      ohaPublisher: Result := FPublisher.Version;
      ohaInfoPath: Result := FInfoPath.Version;
    end;
  except
    Result := '9.0.0.0';
  end;
end;

// GARANT // { handling setting host application
procedure TadxCOMAddInModule.SetIApp(Value : OleVariant);
var
  l_IDisp: IDispatch;
  l_TabName: string;
  l_IWord: Word2000._Application;
  l_IExcel: Excel2000._Application;
  l_IOutlook: Outlook2000._Application;
  l_IAccess: Access2000._Application;
  l_IProject: Project2000._MSProject;
  l_IPowerPoint: MSPPt2000._Application;
  l_IFrontPage: FrontPage2000._Application;
  l_IMapPoint: MapPoint2002._Application;
  l_IVisio: Visio2002.IVApplication;
  l_IPublisher: Publisher2003._Application;
  l_IInfoPath: InfoPath2007._Application3;
begin
  FIApp := Value;
  l_IDisp := HostApp;

  if l_IDisp.QueryInterface(Word2000._Application, l_IWord) = S_OK then
    FHostType := ohaWord
  else if l_IDisp.QueryInterface(Excel2000._Application, l_IExcel) = S_OK then
    FHostType := ohaExcel
  else if l_IDisp.QueryInterface(Outlook2000._Application, l_IOutlook) = S_OK then
    FHostType := ohaOutlook
  else if l_IDisp.QueryInterface(Access2000._Application, l_IAccess) = S_OK then
    FHostType := ohaAccess
  else if l_IDisp.QueryInterface(Project2000._MSProject, l_IProject) = S_OK then
    FHostType := ohaProject
  else if l_IDisp.QueryInterface(MSPPt2000._Application, l_IPowerPoint) = S_OK then
    FHostType := ohaPowerPoint
  else if l_IDisp.QueryInterface(FrontPage2000._Application, l_IFrontPage) = S_OK then
    FHostType := ohaFrontPage
  else if l_IDisp.QueryInterface(MapPoint2002._Application, l_IMapPoint) = S_OK then
    FHostType := ohaMapPoint
  else if l_IDisp.QueryInterface(Visio2002.IVApplication, l_IVisio) = S_OK then
    FHostType := ohaVisio
  else if l_IDisp.QueryInterface(Publisher2003._Application, l_IPublisher) = S_OK then
    FHostType := ohaPublisher
  else if l_IDisp.QueryInterface(InfoPath2007._Application3, l_IInfoPath) = S_OK then
    FHostType := ohaInfoPath;

  if assigned(FOnHostAppSet) then
    FOnHostAppSet(Self);
end;
// GARANT // } handling setting host application

{ TadxCustomDocumentModule }

constructor TadxCustomDocumentModule.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited CreateNew(AOwner, Dummy);
  FControls := TList.Create;
  FSinkList := TList.Create;
end;

destructor TadxCustomDocumentModule.Destroy;
begin
  if Assigned(FSinkList) then FreeAndNil(FSinkList);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxCustomDocumentModule.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Assigned(FControls) then
    if AComponent is TadxMSFormsControl then begin
      if Operation = opInsert then FControls.Add(AComponent);
      if Operation = opRemove then FControls.Remove(AComponent);
    end;
end;

procedure TadxCustomDocumentModule.ReconnectControls;

  procedure ExcelReconnectControls;
  var
    i: Integer;
    ISheet: ExcelWorksheet;
  begin
    if ExcelApp.Workbooks.Count = 0 then Exit;
    // Case #2254
    try
      if Not Assigned(ExcelApp.ActiveWorkbook) then Exit;
    except
      Exit;
    end;
    if not CheckDocumentProps(ExcelApp.ActiveWorkbook.CustomDocumentProperties) then Exit;
    if OleVariant(ExcelApp.ActiveSheet).Name <> TadxExcelSheetModule(Self).WorkSheet then Exit;
    if Assigned(FOnConnect) then
      try
        FOnConnect(Self);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
    ExcelApp.ActiveSheet.QueryInterface(IID__Worksheet, ISheet);
    if Assigned(ISheet) then
      try
        for i := 0 to Self.ControlsCount - 1 do
          try
            if Controls[i].ControlName <> '' then
              Controls[i].ConnectTo(OleVariant(ISheet).OLEObjects(Controls[i].ControlName).Object);
          except
          end;
      finally
        ISheet := nil;
      end;
  end;

  procedure WordReconnectControls;
  var
    i: Integer;
    Shapes: Word2000.InlineShapes;
    Ctrl: TadxMSFormsControl;
  begin
    if WordApp.Documents.Count = 0 then Exit;
    // Case #2254
    try
      if Not Assigned(WordApp.ActiveDocument) then Exit;
    except
      Exit;
    end;
    if CheckDocumentProps(WordApp.ActiveDocument.CustomDocumentProperties) then begin
      if Assigned(FOnConnect) then
        try
          FOnConnect(Self);
        except
          on E: SysUtils.Exception do DoError(E);
        end;
      Shapes := WordApp.ActiveDocument.InlineShapes;
      try
        for i := 1 to Shapes.Count do
          if Assigned(Shapes.Item(i).OLEFormat) then begin
            Ctrl := ControlByName(OleVariant(Shapes.Item(i).OLEFormat.Object_).Name);
            if Assigned(Ctrl) then begin
              COMAddInClassInstance.FConnectionSuccessful := True;
              Ctrl.ConnectTo(Shapes.Item(i).OLEFormat.Object_);
            end;
          end;
      finally
        Shapes := nil;
      end;
    end;
  end;

  procedure PowerPointReconnectControls;
  begin
  end;

begin
  DisconnectControls;
  if HostType = ohaExcel then ExcelReconnectControls
  else
    if HostType = ohaWord then WordReconnectControls
    else
      if HostType = ohaPowerPoint then PowerPointReconnectControls;
end;

procedure TadxCustomDocumentModule.DisconnectControls;
var
  i: Integer;
begin
  for i := 0 to ControlsCount - 1 do
    Controls[i].Disconnect;
end;

function TadxCustomDocumentModule.CheckDocumentProps(const IDsp: IDispatch): boolean;
var
  i, Count: Integer;
  Props: OleVariant;
begin
  Result := False;
  if Assigned(IDsp) then begin
    Props := IDsp;
    try
      Count := Props.Count;
      for i := 1 to Count do
        if Props.Item[i].Name = Self.PropertyID then
          if Props.Item[i].Value = Self.PropertyValue then begin
            Result := True;
            Break;
          end;
    finally
      Props := Unassigned;
    end;
  end;
end;

function TadxCustomDocumentModule.ControlIndexByName(const ControlName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Assigned(FControls) and (ControlName <> '') then
    for i := 0 to FControls.Count - 1 do
      if TadxMSFormsControl(FControls[i]).ControlName = ControlName then begin
        Result := i;
        Break;
      end;
end;

function TadxCustomDocumentModule.ControlByName(const ControlName: string): TadxMSFormsControl;
var
  Index: Integer;
begin
  Result := nil;
  Index := ControlIndexByName(ControlName);
  if Index >= 0 then
    Result := FControls[Index];
end;

function TadxCustomDocumentModule.ControlIndexOf(Control: TadxMSFormsControl): Integer;
begin
  Result := -1;
  if Assigned(FControls) then
    Result := FControls.IndexOf(Control);
end;

function TadxCustomDocumentModule.GetControlsCount: Integer;
begin
  Result := 0;
  if Assigned(FControls) then
    Result := FControls.Count;
end;

function TadxCustomDocumentModule.GetControls(Index: Integer): TadxMSFormsControl;
begin
  Result := nil;
  if (Index >= 0) and (Index < ControlsCount) then
    Result := FControls[Index];
end;

{ TadxFactory }

constructor TadxFactory.Create(ComServer: TComServerObject; AutoClass: TAutoClass;
  const ClassID: TGUID; AModuleClass: TadxCOMAddInModuleClass);
var
  Buffer: array [0..MAX_PATH + 1] of Char;
begin
  inherited Create(ComServer, AutoClass, ClassID, ciMultiInstance, tmApartment);
  FModuleClass := AModuleClass;
  {$IFDEF UNICODE}
  SetString(FAddInPath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, Length(Buffer)));
  {$ELSE}
  SetString(FAddInPath, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  {$ENDIF}
  FAddInPath := ExtractFilePath(FAddInPath);
end;

procedure TadxFactory.UpdateRegistry(Register: Boolean);

  function MsgBox(const ACaption, Hosts: string): Integer;
  begin
    with CreateMessageDialog('Please close all running host application instances:' + #13#10 + Hosts,
      mtInformation, [mbRetry, mbIgnore, mbCancel]) do
      try
        Caption := ACaption;
        Position := poScreenCenter;
        Result := ShowModal;
      finally
        Free;
      end;
  end;

var
  s: string;
  MsgBoxResult: Integer;
  App: TadxOfficeHostApp;
  IDsp: IDispatch;
  LocalAddInName: string;
  LocalSupportedApps: TadxHostAppSet;
  LocalDisplayAlerts: boolean;
begin
  if FDeprecatedVersion then begin
    LocalAddInName := FAddInName;
    LocalSupportedApps := FSupportedApps;
    LocalDisplayAlerts := FDisplayAlerts;
  end
  else
    with FModuleClass.Create(nil) do
      try
        LocalAddInName := FAddInName;
        LocalSupportedApps := FSupportedApps;
        LocalDisplayAlerts := FDisplayAlerts;
      finally
        Free;
      end;
  if LocalDisplayAlerts then begin
    try
      repeat
        IDsp := nil;
        s := '';
        MsgBoxResult := 0;
        for App := Low(TadxOfficeHostApp) to High(TadxOfficeHostApp) do
          if (App in LocalSupportedApps) and IsHostAppInstalled(App) then begin
            IDsp := adxGetActiveOleObject(adxOfficeProgIDs[App]);
            if Assigned(IDsp) then begin
              s := s + adxOfficeAppNames[App] + ' ';
              IDsp := nil;
            end;
          end;
        if s <> '' then begin
          MsgBoxResult := MsgBox(LocalAddInName, s);
          if MsgBoxResult = mrCancel then
            raise EADXException.Create(adxErrorCanceled, adxECodeCanceled, 0);
        end;
      until (s = '') or (MsgBoxResult = mrIgnore);
    finally
    end;
  end;

  if Register then begin
    if not RegisterToHKCU then inherited UpdateRegistry(Register);
    RegisterAddIn;
  end
  else begin
    UnRegisterControls;
    UnRegisterAddIn;
    if not RegisterToHKCU then inherited UpdateRegistry(Register);
  end;
end;

procedure TadxFactory.RegisterAddIn;
var
  Reg: TRegistry;
  App: TadxOfficeHostApp;
  AModule: TadxCOMAddInModule;
begin
  Reg := TRegistry.Create;
  if FDeprecatedVersion then begin
    AModule := FModuleClass.CreateNew(nil);
    AModule.AddInName := FAddInName;
    AModule.Description := FDescription;
    AModule.SupportedApps := FSupportedApps;
    AModule.LoadBehavior := FLoadBehavior;
    AModule.DisplayAlerts := FDisplayAlerts;
    AModule.XLAutomationAddIn := FXLAutomationAddIn;
  end
  else
    AModule := FModuleClass.Create(nil);
  try
    for App := Low(TadxOfficeHostApp) to High(TadxOfficeHostApp) do
      if (App in AModule.SupportedApps) and IsHostAppInstalled(App) then begin

        if (AModule.RegisterForAllUsers) and (not RegisterToHKCU) then
          Reg.RootKey := HKEY_LOCAL_MACHINE;
        if Reg.OpenKey(RegistryKey[App], True) then begin
          Reg.WriteString('FriendlyName', AModule.FAddInName);
          Reg.WriteString('Description', AModule.FDescription);
          Reg.WriteInteger('LoadBehavior', AModule.FLoadBehavior);
          Reg.WriteInteger('CommandLineSafe', 0);
          Reg.CloseKey;
        end;
        Reg.RootKey := HKEY_CURRENT_USER;
        if (App = ohaExcel) and AModule.XLAutomationAddIn then
          RegisterAutomationAddin(Reg);

        Reg.RootKey := HKEY_CURRENT_USER;
        try
          if Assigned(AModule.FOnAfterAddinRegister) then begin
            AModule.FHostType := App;
            AModule.FCOMAddInClassFactory:= self;
            AModule.Registry.OpenKey(RegistryKey[App], True);
            AModule.FOnAfterAddinRegister(AModule);
            AModule.Registry.CloseKey;
          end;
        except
          on E: SysUtils.Exception do AModule.DoError(E);
        end;
      end;
  finally
    AModule.Free;
    Reg.Free;
  end;
end;

procedure TadxFactory.UnRegisterAddIn;
var
  R: TRegistry;
  App: TadxOfficeHostApp;
  AModule: TadxCOMAddInModule;
begin
  R := TRegistry.Create;
  if FDeprecatedVersion then begin
    AModule := FModuleClass.CreateNew(nil);
    AModule.AddInName := FAddInName;
    AModule.Description := FDescription;
    AModule.SupportedApps := FSupportedApps;
    AModule.LoadBehavior := FLoadBehavior;
    AModule.DisplayAlerts := FDisplayAlerts;
    AModule.XLAutomationAddIn := FXLAutomationAddIn;
  end
  else
    AModule := FModuleClass.Create(nil);
  try
    for App := Low(TadxOfficeHostApp) to High(TadxOfficeHostApp) do
      if (App in AModule.SupportedApps) and IsHostAppInstalled(App) then begin
        try
          if Assigned(AModule.FOnBeforeAddinUnregister) then begin
            AModule.FHostType := App;
            AModule.FCOMAddInClassFactory:= self;
            AModule.Registry.OpenKey(RegistryKey[App], False);
            AModule.FOnBeforeAddinUnregister(AModule);
            AModule.Registry.CloseKey;
          end;
        except
          on E: SysUtils.Exception do AModule.DoError(E);
        end;
        if (AModule.RegisterForAllUsers) and (not RegisterToHKCU) then begin
          R.RootKey := HKEY_LOCAL_MACHINE;
          if R.KeyExists(RegistryKey[App]) then R.DeleteKey(RegistryKey[App]);
        end;
        R.RootKey := HKEY_CURRENT_USER;
        if R.KeyExists(RegistryKey[App]) then R.DeleteKey(RegistryKey[App]);
        if (App = ohaExcel) and AModule.XLAutomationAddIn then
          UnregisterAutomationAddin(R);
      end;
  finally
    AModule.Free;
    R.Free;
  end;
end;

procedure TadxFactory.UnRegisterControls;

  function CheckShortcuts(AModule: TadxCOMAddInModule): boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to AModule.ComponentCount - 1 do
      if AModule.Components[i] is TadxOLBarShortcutManager then begin
        Result := True;
        Break;
      end;
  end;

  procedure DeleteControlsAndCommandBars(AModule: TadxCOMAddInModule;
    ICmdBars: CommandBars; ACtrlList, ACmdBarList: TStringList);
  var
    i: Integer;
    IBar: CommandBar;
    IControl: CommandBarControl;
  begin
    for i := 0 to ACtrlList.Count - 1 do begin
      if Integer(ACtrlList.Objects[i]) <> 255 then begin
        IControl := ICmdBars.FindControl(EmptyParam, EmptyParam, ACtrlList[i], EmptyParam);
        if Assigned(IControl) then begin
          if (IControl.type_ = msoControlPopup) then begin
            if (IControl as CommandBarPopup).Controls.Count > 0 then Continue;
          end;
          IControl.Delete(False);
          IControl := nil;
        end;
      end;
    end;
    for i := 0 to ACtrlList.Count - 1 do begin
      if Integer(ACtrlList.Objects[i]) = 255 then begin
        IControl := ICmdBars.FindControl(EmptyParam, EmptyParam, ACtrlList[i], EmptyParam);
        if Assigned(IControl) then begin
          IControl.Delete(False);
          IControl := nil;
        end;
      end;
    end;
    for i := 0 to ACmdBarList.Count - 1 do begin
      IBar := AModule.FindCommandBar(ACmdBarList[i]);
      if Assigned(IBar) then
        try
          if not IBar.BuiltIn and (IBar.Controls.Count = 0) then
            IBar.Delete;
        finally
          IBar := nil;
        end;
    end;
  end;

var
  i: Integer;
  Reg: TRegistry;
  IApp: OLEVariant;
  NeedClose: boolean;
  ICmdBars: CommandBars;
  App: TadxOfficeHostApp;
  AModule: TadxCOMAddInModule;
  CmdBarList: TStringList;
  CtrlList: TStringList;
begin
  CmdBarList := TStringList.Create;
  CtrlList := TStringList.Create;
  if FDeprecatedVersion then begin
    AModule := FModuleClass.CreateNew(nil);
    AModule.AddInName := FAddInName;
    AModule.Description := FDescription;
    AModule.SupportedApps := FSupportedApps;
    AModule.LoadBehavior := FLoadBehavior;
    AModule.DisplayAlerts := FDisplayAlerts;
    AModule.XLAutomationAddIn := FXLAutomationAddIn;
  end
  else
    AModule := FModuleClass.Create(nil);
  try
    for App := Low(TadxOfficeHostApp) to High(TadxOfficeHostApp) do
      if (App <> ohaMapPoint) and (App in AModule.SupportedApps) and IsHostAppInstalled(App) then
        try
          NeedClose := False;
          Reg := TRegistry.Create;
          try
            if Reg.OpenKey(RegistryKey[App] + '\CommandBars', False) then begin
              Reg.GetValueNames(CmdBarList);
              Reg.CloseKey;
            end;
            if Reg.OpenKey(RegistryKey[App] + '\Controls', False) then begin
              Reg.GetValueNames(CtrlList);
              for i := 0 to CtrlList.Count - 1 do
                try
                  CtrlList.Objects[i] := Pointer(Reg.ReadInteger(CtrlList[i]));
                except
                end;
              Reg.CloseKey;
            end;
            if Reg.OpenKey(RegistryKey[App], False) then begin
              Reg.WriteString('ADXStartMode', adxStartModeNames[smUninstall]);
              Reg.CloseKey;
            end;
            if AModule.RegisterForAllUsers then Reg.RootKey := HKEY_LOCAL_MACHINE;
            if Reg.OpenKey(RegistryKey[App], False) then begin
              Reg.WriteInteger('LoadBehavior', 0);
              Reg.CloseKey;
            end;
            if (App = ohaOutlook) and (CheckShortcuts(AModule) = False) then Continue;
          finally
            Reg.Free;
          end;
          IApp := adxGetActiveOLEObject(adxOfficeProgIDs[App]);
          if _VarIsEmpty(IApp) then begin
            if (App = ohaVisio) then
              IApp := adxCreateOLEObject('Visio.InvisibleApp')
            else
              IApp := adxCreateOLEObject(adxOfficeProgIDs[App]);
            NeedClose := True;
          end;
          if not _VarIsEmpty(IApp) then
            try
              AModule.FIApp := IApp;
              AModule.FHostType := App;
              AModule.FICmdBars := nil;
              if App = ohaOutlook then begin
                AModule.UninstallShortcuts;
              end
              else begin
                ICmdBars := AModule.GetAppCommandBars;
                if Assigned(ICmdBars) then begin
                  for i := 0 to AModule.ComponentCount - 1 do
                    if (AModule.Components[i] is TadxOlInspectorCustomCommandBar) or (AModule.Components[i] is TadxOlExplorerCustomCommandBar) then Continue
                    else
                      if (AModule.Components[i] is TadxCustomCommandBar) and (App in TadxCustomCommandBar(AModule.Components[i]).SupportedApps) then
                      begin
                        TadxCustomCommandBar(AModule.Components[i]).Uninstall;
                        // FIX: MS Word
                        if (AModule.HostType = ohaWord) and not AModule.FIsRibbon then
                          try
                            IApp.OrganizerDelete(IApp.NormalTemplate.FullName,
                              TadxCustomCommandBar(AModule.Components[i]).FCommandBarName, wdOrganizerObjectCommandBars);
                          except
                          end;
                      end;
                  // Case #736
                  for i := 0 to AModule.ComponentCount - 1 do
                    if AModule.Components[i] is TadxBuiltInControl then
                      TadxBuiltInControl(AModule.Components[i]).Uninstall;
                  DeleteControlsAndCommandBars(AModule, ICmdBars, CtrlList, CmdBarList);
                end;
              end;
              try
                // save Word templates
                if App = ohaWord then begin
                  for i := 1 to IApp.Templates.Count do
                    if not IApp.Templates.Item(i).Saved then
                      IApp.Templates.Item(i).Save;
                end;
              except
              end;
            finally
              ICmdBars := nil;
              if App in [ohaExcel, ohaPowerPoint] then
                sleep(500);  //avoid Excel crash during the add-in uninstallation
              if NeedClose then IApp.Quit;
              IApp := Unassigned;
            end;
        except
          raise EADXException.Create(adxErrorCantUnregisterControls,
            adxECodeCantUnregisterControls, 0);
        end;
  finally
    if Assigned(CmdBarList) then CmdBarList.Free;
    if Assigned(CtrlList) then CtrlList.Free;
    AModule.Free;
  end;
end;

procedure TadxFactory.RegisterAutomationAddin(const Reg: TRegistry);
var
  i, Index: Integer;
  Version: Integer;
  Values: TStringList;
  Exists: boolean;
begin
  Values := TStringList.Create;
  try
    for Version := 10 to 14 do
      if Reg.KeyExists(Format(adxExcelAutomationAddInRegKey, [Version])) then
        if Reg.OpenKey(Format(adxExcelAutomationAddInRegKey, [Version]), True) then begin
          Exists := False;
          Values.Clear();
          Reg.GetValueNames(Values);
          Values.Sort;
          Index := -1;
          for i := 0 to Values.Count - 1 do
            if Pos('OPEN', UpperCase(Values[i])) = 1 then begin
              Index := i;
              if Pos(ProgID, Reg.ReadString(Values[i])) > 0 then begin
                Reg.CloseKey;
                Exists := True;
                Break;
              end;
            end;
          if Exists then Continue;
          if Index = -1 then Reg.WriteString('OPEN', '/A "' + ProgID + '"')
          else begin
            if UpperCase(Values[Index]) = 'OPEN' then
              Reg.WriteString('OPEN1', '/A "' + ProgID + '"')
            else begin
              i := StrToInt(System.Copy(Values[Index], Length('OPEN') + 1, Length(Values[Index])));
              Reg.WriteString('OPEN' + IntToStr(i + 1), '/A "' + ProgID + '"');
            end;
          end;
          Reg.CloseKey;
        end;
  finally
    Values.Free;
  end;
end;

procedure TadxFactory.UnregisterAutomationAddin(const Reg: TRegistry);
var
  i: Integer;
  Version: Integer;
  Values: TStringList;
  Success: boolean;
begin
  Values := TStringList.Create;
  try
    for Version := 10 to 14 do
      if Reg.KeyExists(Format(adxExcelAutomationAddInRegKey, [Version])) then
        if Reg.OpenKey(Format(adxExcelAutomationAddInRegKey, [Version]), True) then begin
          Values.Clear();
          Reg.GetValueNames(Values);
          Values.Sort;
          Success := False;
          for i := 0 to Values.Count - 1 do
            if Pos('OPEN', UpperCase(Values[i])) = 1 then
              if Pos(ProgID, Reg.ReadString(Values[i])) > 0 then begin
                Reg.DeleteValue(Values[i]);
                Values.Delete(i);
                Success := True;
                Break;
              end;
          // resort OPENx
          if Success then begin
            for i := Values.Count - 1 downto 0 do begin
              if Pos('OPEN', UpperCase(Values[i])) = 1 then
                Values.Values[Values[i]] := Reg.ReadString(Values[i]);
              Values.Delete(i);
            end;
            if Values.Count > 0 then begin
              for i := 0 to Values.Count - 1 do begin
                Reg.DeleteValue(Values.Names[i]);
                if i = 0 then
                  Reg.WriteString('OPEN', Values.Values[Values.Names[i]])
                else
                  Reg.WriteString('OPEN' + IntToStr(i), Values.Values[Values.Names[i]]);
              end
            end;
          end;
          Reg.CloseKey;
        end;
  finally
    Values.Free;
  end;
end;

function TadxFactory.GetHostVersion(const AHostApp: TadxOfficeHostApp): Integer;
var
  S: string;
  R: TRegistry;
begin
  Result := 9;
  R := TRegistry.Create(KEY_READ);
  try
    R.RootKey := HKEY_CLASSES_ROOT;
    if R.OpenKey('\' + adxOfficeProgIDs[AHostApp] + '\CurVer', False) then begin
      if R.ValueExists('') then begin
        S := R.ReadString('');
        try
          Delete(S, 1, Length(adxOfficeProgIDs[AHostApp]) + 1);
          Result := StrToInt(S);
          if AHostApp = ohaFrontPage then Inc(Result, 5);
        except
        end;
      end;
      R.CloseKey;
    end;
  finally
    R.Free;
  end;
end;

function TadxFactory.IsHostAppInstalled(AHostType: TadxOfficeHostApp): boolean;
const
  EMPTYGUID: TGUID = '{00000000-0000-0000-0000-000000000000}';
var
  C: TGUID;
begin
  C := EMPTYGUID;
  Result := CLSIDFromProgID(PWideChar(WideString(adxOfficeProgIDs[AHostType])), C) = S_OK;
  Result := Result and (not IsEqualGUID(C, EMPTYGUID));
  // Case #1064 - Office 2010 Click To Run
  if not Result then
    try
      with TRegistry.Create(KEY_READ) do
        try
          RootKey := HKEY_LOCAL_MACHINE;
          if KeyExists('Software\Microsoft\Office\14.0\Common\InstallRoot\Virtual') then
            Result := True;
        finally
          Free;
        end;
    except
    end;
end;

function TadxFactory.GetRegKey(Index: TadxOfficeHostApp): string;
begin
  if Index in [ohaMapPoint, ohaVisio] then
    Result := Format(adxMapPointAndVisioRegKey, [adxOfficeAppNames[Index], ProgID])
  else Result := Format(adxAddInRegKey, [adxOfficeAppNames[Index], ProgID]);
end;

function TadxFactory.GetAddInName: string;
begin
  Result := FAddInName;
end;

function TadxFactory.GetSupportedApps: TadxHostAppSet;
begin
  Result := FSupportedApps;
end;

{ Get host application hWnd }
var
  adxHostType: TadxOfficeHostApp;
  adxHostAppHandle: HWND = 0;

const
  WndClassNames: array [TadxOfficeHostApp] of string =
   ('XLMAIN', '', '', '', '', '', '', '', 'VISIOA', '', '');

function adxDoEnumThreadWindowProc(Window: HWND; Data: Longint): Bool; stdcall;
var
  WndClass: string;
begin
  Result := True;
  SetLength(WndClass, 256);
  SetLength(WndClass, GetClassName(Window, PChar(WndClass), Length(WndClass)));
  if WndClass = WndClassNames[adxHostType] then begin
    adxHostAppHandle := Window;
    Result := False;
  end;
end;

{ TadxAddin }

procedure TadxAddin.OnConnection(const Application_: IDispatch;
  ConnectMode: ext_ConnectMode; const AddInInst: IDispatch;
  var custom: PSafeArray);
begin
  FConnectionSuccessful := False;
  if Factory.FDeprecatedVersion then
    FAddInModule := Factory.FModuleClass.CreateNew(nil)
  else
    FAddInModule := Factory.FModuleClass.Create(nil);
  with COMAddInModule do begin
    // GARANT // { handling setting host application
    SetIApp(Application_);
    // GARANT // } handling setting host application
    FCOMAddInClassInstance := Self;
    FCOMAddInClassFactory := Factory;
    if ConnectMode <> ext_cm_Startup then OnStartupComplete(custom);
    if Assigned(AddInInst) then begin
      AddInInst.QueryInterface(COMAddIn, FAddInInstance);
      if Assigned(FAddInInstance) then FAddInInstance.Object_ := Self;
    end;
  end;
end;

procedure TadxAddin.OnDisconnection(RemoveMode: ext_DisconnectMode;
  var custom: PSafeArray);
var
  i: integer;
begin
  try
    if RemoveMode <> ext_dm_HostShutdown then
      with COMAddInModule do begin
        OnBeginShutdown(custom);
        if HostType = ohaOutlook then
          try
            for i := 0 to ComponentCount - 1 do
              if Components[i] is TadxOLBarShortcutManager then
                TadxOLBarShortcutManager(Components[i]).Uninstall(OutlookApp.ActiveExplorer);
          except
          end;
        for i := 0 to ComponentCount - 1 do
          if Components[i] is TadxBuiltInControl then
            TadxBuiltInControl(Components[i]).Uninstall;
        if HostType = ohaWord then FICmdBars := GetAppCommandBars;
        for i := 0 to ComponentCount - 1 do
          if (Components[i] is TadxCustomCommandBar) and (HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
          begin
            TadxCustomCommandBar(Components[i]).Uninstall;
            // FIX: MS Word disconnect
            if (HostType = ohaWord) and not FIsRibbon then
              try
                WordApp.OrganizerDelete(WordApp.NormalTemplate.FullName,
                  TadxCustomCommandBar(Components[i]).FCommandBarName, wdOrganizerObjectCommandBars);
              except
              end;
          end;
        with TRegistry.Create do
          try
            if KeyExists(RegistryKey + '\CommandBars') then
              DeleteKey(RegistryKey + '\CommandBars');
            if KeyExists(RegistryKey + '\Controls') then
              DeleteKey(RegistryKey + '\Controls');
          finally
            Free;
          end;
      end;
    with COMAddInModule do begin
      if Assigned(FCTPFactory) then FTaskPanes.Clear;
      try
        if FDoNotRaiseShutdownEvents = False then
          if Assigned(FOnAddInFinalize) then
            FOnAddInFinalize(COMAddInModule);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
    end;
  finally
    // context menu
    if Assigned(FSink) then begin
      TadxCommandBarsEventSink(FSink).Disconnect();
      FSink := nil;
    end;
    COMAddInModule.FRegistry.CloseKey;
    if Assigned(FExplorerList) then begin
      for i := 0 to FExplorerList.Count - 1 do
        TExplorer(FExplorerList.Items[i]).Free;
      FreeAndNil(FExplorerList);
    end;
    if Assigned(FInspectorList) then begin
      for i := 0 to FInspectorList.Count - 1 do
        TInspector(FInspectorList.Items[i]).Free;
      FreeAndNil(FInspectorList);
    end;
    if Assigned(FNameSpace) then FreeAndNil(TNameSpace(FNameSpace));
    if Assigned(FExplorers) then FreeAndNil(TExplorers(FExplorers));
    if Assigned(FInspectors) then FreeAndNil(TInspectors(FInspectors));
    FreeAndNil(FAddInModule);
  end;
end;

procedure TadxAddin.OnAddInsUpdate(var custom: PSafeArray);
begin
end;

procedure TadxAddin.OnStartupComplete(var custom: PSafeArray);

  function adxStartMode(const S: string): TadxStartMode;
  begin
    for Result := High(TadxStartMode) downto Low(TadxStartMode) do
      if UpperCase(s) = adxStartModeNames[Result] then Break;
  end;

var
  i: Integer;
  Index: OleVariant;
  WindowCaption: TGUID;
{$IFDEF ADX_VCL6}
  V: OleVariant;
{$ENDIF}
begin
  {$IFDEF ADX_TRIAL}
  {$I Trial_adx_2.inc}
  {$ENDIF}
  with COMAddInModule do begin
    Inc(FStartupCompleteCounter);
    // fixed 29-May-2008 bug with PowerPoint
    if FStartupCompleteCounter > 1 then Exit;
    if Assigned(FExcel) then Exit;
    SetHostApplication;
    adxHostType := HostType;
    if WndClassNames[adxHostType] <> '' then begin
      EnumThreadWindows(GetCurrentThreadID, @adxDoEnumThreadWindowProc, 0);
      Forms.Application.Handle := adxHostAppHandle;
    end;
    FRegistry.OpenKey(Factory.RegistryKey[HostType], True);
    with TRegistry.Create do
    try
      if OpenKey(Factory.RegistryKey[HostType], True) then begin
        if ValueExists('ADXStartMode') then
          FStartMode := adxStartMode(ReadString('ADXStartMode'))
        else
          FStartMode := smFirstStart;
        CloseKey;
      end;
    finally
      Free;
    end;
    // color scheme
    with TRegistry.Create(KEY_READ) do
      try
        if OpenKey(Format('Software\\Microsoft\\Office\\%d.0\\Common', [FHostMajorVersion]), False) then begin
          if ValueExists('Theme') then
            FOfficeColorScheme := TadxOfficeColorScheme(ReadInteger('Theme'))
          else begin
            if FHostMajorVersion = 12 then FOfficeColorScheme := Blue
            else
              if FHostMajorVersion >= 14 then FOfficeColorScheme := Silver;
          end;
          CloseKey;
        end;
      finally
        Free;
      end;
    FICmdBars := GetAppCommandBars;
    // Main Menu
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxMainMenu then
        if adxHostType in TadxMainMenu(Components[i]).SupportedApps then begin
          if adxHostType = ohaExcel then
            TadxMainMenu(Components[i]).FCommandBarName := 'Worksheet Menu Bar'
          else
            TadxMainMenu(Components[i]).FCommandBarName := 'Menu Bar';
        end;
    try
      if Assigned(FOnAddInInitialize) then
        FOnAddInInitialize(COMAddInModule);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
    if HostType = ohaOutlook then begin
      LoadExplCommandBars;
      InstallShortcuts;
      InstallSolutionModules();
    end;
    if HostType = ohaAccess then begin
      FTimerLocked := False;
      FAccessTimer.Enabled := True;
    end
    else
      if HostType <> ohaMapPoint then Install;

    if Assigned(FCTPFactory) then
      case HostType of
        ohaExcel: FTaskPanes.MakeCTP(FExcel.ActiveWindow);
        ohaAccess: FTaskPanes.MakeCTP(nil);
        ohaWord:
          begin
            try
              FTaskPanes.FShowWindowsInTaskbar := HostApp.ShowWindowsInTaskbar;
              if (WordApp.ActiveDocument <> nil) and (WordApp.ActiveWindow <> nil) then
                for i := 1 to WordApp.Documents.Count do begin
                  Index := i;
                  FTaskPanes.MakeCTP(WordApp.Documents.Item(Index).ActiveWindow);
                end;
            except
              // OLE Automation
            end;
          end;
        ohaPowerPoint:
          begin
            if FPowerPoint.Windows.Count > 0 then
              FTaskPanes.MakeCTP(FPowerPoint.DefaultInterface.ActiveWindow)
            else begin
              if FHostMajorVersion < 14 then FTaskPanes.MakeCTP(nil);
            end;
          end;
        ohaInfoPath: if FInfoPath.Windows.Count > 0 then
          FTaskPanes.MakeCTP(FInfoPath.Windows.Item[0]);
        // Case #1617
        ohaProject:
          begin
            if FHostMajorVersion >= 14 then
              FTaskPanes.MakeCTP(FProject.ActiveWindow);
          end;
      end;
    if (HostType in [ohaExcel, ohaWord]) and (Self.COMAddInModule is TadxCustomDocumentModule) then
      TadxCustomDocumentModule(Self.FAddInModule).ReconnectControls;
    try
      if Assigned(FOnAddInStartupComplete) then
        FOnAddInStartupComplete(COMAddInModule);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
    if StartMode = smFirstStart then
      with TRegistry.Create do
      try
        if OpenKey(Factory.RegistryKey[HostType], True) then begin
          WriteString('ADXStartMode', adxStartModeNames[smNormal]);
          CloseKey;
        end;
      finally
        Free;
      end;
    if FHostType = ohaInfoPath then begin
      if Assigned(InfoPathApp.OnWindowActivate) then
        FOnInfoPathWindowActivate := InfoPathApp.OnWindowActivate;
      InfoPathApp.OnWindowActivate := DoInfoPathWindowActivate;
      if Assigned(InfoPathApp.OnNewXDocument) then
        FOnInfoPathNewXDocument := InfoPathApp.OnNewXDocument;
      InfoPathApp.OnNewXDocument := DoInfoPathNewXDocument;
      if Assigned(InfoPathApp.OnXDocumentOpen) then
        FOnInfoPathXDocumentOpen := InfoPathApp.OnXDocumentOpen;
      InfoPathApp.OnXDocumentOpen := DoInfoPathXDocumentOpen;
    end;
    if FHostType = ohaPowerPoint then begin
      if Assigned(PowerPointApp.OnWindowActivate) then
        FOnPowerPointWindowActivate := PowerPointApp.OnWindowActivate;
      PowerPointApp.OnWindowActivate := DoPowerPointWindowActivate;
    end;
    if FHostType = ohaExcel then begin
      if Assigned(ExcelApp.OnWorkbookActivate) then
        FOnWorkbookActivate := ExcelApp.OnWorkbookActivate;
      ExcelApp.OnWorkbookActivate := DoWorkbookActivate;
      if Assigned(ExcelApp.OnSheetActivate) then
        FOnSheetActivate := ExcelApp.OnSheetActivate;
      ExcelApp.OnSheetActivate := DoSheetActivate;
    end;
    if FHostType = ohaWord then begin
      if Assigned(WordApp.OnWindowActivate) then
        FOnWordWindowActivate := WordApp.OnWindowActivate;
      WordApp.OnWindowActivate := DoWordWindowActivate;
      if Assigned(WordApp.OnDocumentOpen) then
        FOnWordDocumentOpen := WordApp.OnDocumentOpen;
      WordApp.OnDocumentOpen := DoWordDocumentOpen;
      if Assigned(WordApp.OnNewDocument) then
        FOnWordNewDocument := WordApp.OnNewDocument;
      WordApp.OnNewDocument := DoWordNewDocument;
      if Assigned(WordApp.OnDocumentChange) then
        FOnWordDocumentChange := WordApp.OnDocumentChange;
      WordApp.OnDocumentChange := DoWordDocumentChange;
    end;
    if HostType = ohaVisio then begin
      if Assigned(VisioApp.OnWindowActivated) then
        FOnVisioWindowActivated := VisioApp.OnWindowActivated;
      VisioApp.OnWindowActivated := DoVisioWindowActivated;
    end;
    if HostType = ohaOutlook then begin
      FExplorerList := TList.Create;
      FInspectorList := TList.Create;
      // Explorers
      FExplorers := TExplorers.Create(nil);
      TExplorers(FExplorers).ConnectTo(FOutlook.Explorers);
      TExplorers(FExplorers).OnNewExplorer := DoNewExplorer;

      // fixed 14-May-2008
      // BCM with Outlook 2007
      for i := 1 to FOutlook.Explorers.Count do
      {$IFDEF ADX_VCL6}
      begin
        V := FOutlook.Explorers.Item(i);
        DoNewExplorer(nil, V);
      end;
      {$ELSE}
        DoNewExplorer(nil, FOutlook.Explorers.Item(i));
      {$ENDIF}
      // Inspectors
      FInspectors := TInspectors.Create(nil);
      TInspectors(FInspectors).ConnectTo(FOutlook.Inspectors);
      TInspectors(FInspectors).OnNewInspector := DoNewInspector;
      if FOutlook.ActiveInspector <> nil then
      {$IFDEF ADX_VCL6}
      begin
        V := FOutlook.ActiveInspector;
        DoNewInspector(nil, V);
      end;
      {$ELSE}
        DoNewInspector(nil, FOutlook.ActiveInspector);
      {$ENDIF}
      if Assigned(FOutlook.OnOptionsPagesAdd) then
        FOnOptionsPagesAdd := FOutlook.OnOptionsPagesAdd;
      FOutlook.OnOptionsPagesAdd := DoOptionsPagesAdd;
      TNameSpace(FNameSpace) := TNameSpace.Create(nil);
      TNameSpace(FNameSpace).ConnectTo(FOutlook.GetNamespace('MAPI'));
      TNameSpace(FNameSpace).OnOptionsPagesAdd := DoNameSpaceOptionsPagesAdd;
      // Outlook 2010
      if OutlookShutdownBehavior = osFast then begin
        if Assigned(FOutlook.OnQuit) then
          FOnQuit := FOutlook.OnQuit;
        FOutlook.OnQuit := DoOutlookQuit;
      end;
    end;
    if HandleShortcuts then begin
      if FHostWndHook <> 0 then begin
        UnhookWindowsHookEx(FHostWndHook);
        FHostWndHook := 0;
      end;
      if Assigned(FNativeWindow) then FreeAndNil(FNativeWindow);
      CoCreateGUID(WindowCaption);
      FNativeWindow := TadxNativeWindow.Create(COMAddInModule, GUIDToString(WindowCaption));
      FHostWndHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, 0, GetCurrentThreadID);
    end;
    // color scheme
    if Assigned(FNativeColorWindow) then FreeAndNil(FNativeColorWindow);
    CoCreateGUID(WindowCaption);
    FNativeColorWindow := TadxNativeColorWindow.Create(COMAddInModule, GUIDToString(WindowCaption));
  end;
end;

procedure TadxAddin.OnBeginShutdown(var custom: PSafeArray);
begin
  with COMAddInModule do begin
    try
      if FDoNotRaiseShutdownEvents = False then
        if Assigned(FOnAddInBeginShutdown) then
          FOnAddInBeginShutdown(COMAddInModule);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
    if WndClassNames[adxHostType] <> '' then Forms.Application.Handle := 0;
    if HostType = ohaMapPoint then FMapPoint.RemoveCommands(Self);
  end;
end;

procedure TadxAddin.CallBack(const key: string; const i1, i2, i3: Integer; const s1, s2, s3: string);
begin
  if Assigned(COMAddInModule) then
    COMAddInModule.DoCallBack(key, i1, i2, i3, s1, s2, s3);
end;

function TadxAddin.GetFactory: TadxFactory;
begin
  Result := (inherited Factory) as TadxFactory;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoWordWindowActivate(ASender: TObject;
  const Doc: WordDocument; const Wn: Word2000.Window);
var
  i: Integer;
{$ELSE}
procedure TadxAddin.DoWordWindowActivate(ASender: TObject; var Doc: OleVariant;
  var Wn: OleVariant);
var
  i: Integer;
{$ENDIF}
begin
  with FAddInModule do
  begin
    {$IFDEF ADX_VCL5}
    if True then
      WordApp.CommandBars.QueryInterface(IID__CommandBars, FICmdBars)
    (*
    // oops... a surprise from Borland
    if TVarData(Wn).VPointer <> nil then begin
      IDispatch(TVarData(Wn).VPointer).QueryInterface(IID__Document, WDoc);
      if Assigned(WDoc) then begin
        WDoc.CommandBars.QueryInterface(IID__CommandBars, FICmdBars);
        WDoc := nil;
      end;
    end
    *)
    {$ENDIF}
    {$IFDEF ADX_VCL6}
    if TVarData(Doc).VPointer <> nil then
      WordDocument(IDispatch(TVarData(Doc).VPointer)).CommandBars.QueryInterface(IID__CommandBars, FICmdBars)
    {$ENDIF}
    {$IFDEF DELPHI_7_UP}
    if Assigned(Doc) then
      Doc.CommandBars.QueryInterface(IID__CommandBars, FICmdBars)
    {$ENDIF}
    else
      WordApp.CommandBars.QueryInterface(IID__CommandBars, FICmdBars);
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TadxOlExplorerCustomCommandBar) or (Components[i] is TadxOlInspectorCustomCommandBar) then Continue
      else
        if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
        begin
          if FindCommandBar(TadxCustomCommandBar(Components[i]).FCommandBarName) = nil then
// GARANT { // FIX DUPLICATED COMMAND BARS
//          InternalAddCmdBar(TadxCustomCommandBar(Components[i]))
// GARANT } // FIX DUPLICATED COMMAND BARS
          else
            TadxCustomCommandBar(Components[i]).ReconnectControls;
        end;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxBuiltInControl then begin
        InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
        {$IFDEF ADX_TRIAL}
        Break;
        {$ENDIF}
      end;
    if (Self.FAddInModule is TadxCustomDocumentModule) and (FConnectionSuccessful) then
      TadxCustomDocumentModule(Self.FAddInModule).ReconnectControls;

    if Assigned(FCTPFactory) then FTaskPanes.MakeCTP(Wn);
  end;
  if Assigned(FOnWordWindowActivate) then
    try
      FOnWordWindowActivate(ASender, Doc, Wn);
    except
    end;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoWordDocumentOpen(ASender: TObject; const Doc: WordDocument);
{$ELSE}
procedure TadxAddin.DoWordDocumentOpen(ASender: TObject; var Doc: OleVariant);
{$ENDIF}
begin
  if COMAddInModule is TadxCustomDocumentModule then
    TadxCustomDocumentModule(COMAddInModule).ReconnectControls;
  if Assigned(COMAddInModule.FCTPFactory) then
    try
      { DONE : Office2007 Bag: When excel insert word document and close excel - word continue running.}
      if COMAddInModule.FTaskPanes.Count > 0 then
        COMAddInModule.FTaskPanes.MakeCTP(Doc.ActiveWindow);
    except
    end;
  if Assigned(FOnWordDocumentOpen) then
    try
      FOnWordDocumentOpen(ASender, Doc);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoWordNewDocument(ASender: TObject; const Doc: WordDocument);
{$ELSE}
procedure TadxAddin.DoWordNewDocument(ASender: TObject; var Doc: OleVariant);
{$ENDIF}
begin
  if COMAddInModule is TadxCustomDocumentModule then
    TadxCustomDocumentModule(COMAddInModule).ReconnectControls;
  with COMAddInModule do
    if Assigned(FCTPFactory) then
      try
        if COMAddInModule.FTaskPanes.Count > 0 then
          FTaskPanes.MakeCTP(Doc.ActiveWindow);
      except
      end;
  if Assigned(FOnWordNewDocument) then
    try
      FOnWordNewDocument(ASender, Doc);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

procedure TadxAddin.DoWordDocumentChange(ASender: TObject);
var
  i: Integer;
begin
  // 19-Feb-2008 Fix: OLE container
  with COMAddInModule do
  try
// GARANT { // FIX DUPLICATED COMMAND BARS
//  if WordApp.Documents.Count > 0 then
//    WordApp.ActiveDocument.CommandBars.QueryInterface(IID__CommandBars, FICmdBars);
// GARANT } // FIX DUPLICATED COMMAND BARS
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TadxOlExplorerCustomCommandBar) or (Components[i] is TadxOlInspectorCustomCommandBar) then Continue
      else
        if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
        begin
          if FindCommandBar(TadxCustomCommandBar(Components[i]).FCommandBarName) = nil then
            InternalAddCmdBar(TadxCustomCommandBar(Components[i]))
          else
            TadxCustomCommandBar(Components[i]).ReconnectControls;
        end;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxBuiltInControl then
        InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
  except
  end;
  with COMAddInModule do
    if Assigned(FCTPFactory) then
      try
        // changed: OLE Automation
        for i := 0 to FTaskPanes.Count - 1 do
          if ohaWord in FTaskPanes[i].SupportedApps then
            FTaskPanes[i].FixWordPanes();
      except
      end;
  if Assigned(FOnWordDocumentChange) then
    try
      FOnWordDocumentChange(ASender);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoWorkbookActivate(ASender: TObject; const Wb: ExcelWorkbook);
{$ELSE}
procedure TadxAddin.DoWorkbookActivate(ASender: TObject; var Wb: OleVariant);
{$ENDIF}
begin
  if COMAddInModule is TadxCustomDocumentModule then
    TadxCustomDocumentModule(COMAddInModule).ReconnectControls;
  if Assigned(FOnWorkbookActivate) then
    try
      FOnWorkbookActivate(ASender, Wb);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoSheetActivate(ASender: TObject; const Sh: IDispatch);
{$ELSE}
procedure TadxAddin.DoSheetActivate(ASender: TObject; var Sh: OleVariant);
{$ENDIF}
begin
  if COMAddInModule is TadxCustomDocumentModule then
    TadxCustomDocumentModule(COMAddInModule).ReconnectControls;
  if Assigned(FOnSheetActivate) then
    try
      FOnSheetActivate(ASender, Sh);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoOptionsPagesAdd(ASender: TObject; const Pages: PropertyPages);
{$ELSE}
procedure TadxAddin.DoOptionsPagesAdd(Sender: TObject; var Pages: OleVariant);
var
  IUnk: IUnknown;
  PropPages: PropertyPages;
{$ENDIF}
begin
  try
    {$IFDEF DELPHI_7_UP}
    if Assigned(FOnOptionsPagesAdd) then FOnOptionsPagesAdd(ASender, Pages);
    FAddInModule.OptionsPagesAdd(ASender, Pages);
    {$ELSE}
    IUnk := IUnknown(TVarData(Pages).VPointer);
    if Assigned(IUnk) then
      try
        IUnk.QueryInterface(IID_PropertyPages, PropPages);
        if Assigned(PropPages) then begin
          if Assigned(FOnOptionsPagesAdd) then FOnOptionsPagesAdd(Sender, Pages);
          FAddInModule.OptionsPagesAdd(Sender, PropPages);
        end;
      finally
        PropPages := nil;
        IUnk := nil;
      end;
    {$ENDIF}
  except
    on E: SysUtils.Exception do FAddInModule.DoError(E);
  end;
end;

{$IFDEF ADX_VCL6}
procedure TadxAddin.DoNameSpaceOptionsPagesAdd(Sender: TObject;
  var Pages: OleVariant; var Folder: OleVariant);
var
  IPages: PropertyPages;
  IFolder: MAPIFolder;
{$ELSE}
procedure TadxAddin.DoNameSpaceOptionsPagesAdd(ASender: TObject;
  const Pages: PropertyPages; const Folder: MAPIFolder);
{$ENDIF}
begin
  try
    {$IFDEF ADX_VCL6}
    IPages := IUnknown(TVarData(Pages).VPointer) as PropertyPages;
    IFolder := IUnknown(TVarData(Folder).VPointer) as MAPIFolder;
    try
      FAddInModule.NameSpaceOptionsPagesAdd(Sender, IPages, IFolder);
    finally
      IFolder := nil;
      IPages := nil;
    end;
    {$ELSE}
    FAddInModule.NameSpaceOptionsPagesAdd(ASender, Pages, Folder);
    {$ENDIF}
  except
    on E: SysUtils.Exception do FAddInModule.DoError(E);
  end;
end;

{$IFDEF ADX_VCL6}
procedure TadxAddin.DoNewExplorer(ASender: TObject; var Explorer: OleVariant);
{$ELSE}
procedure TadxAddin.DoNewExplorer(ASender: TObject; const Explorer: _Explorer);
{$ENDIF}

  function GetExplorerHandle(const Explorer: _Explorer): HWND;
  var
    IWindow: IOleWindow;
  begin
    Result := 0;
    Explorer.QueryInterface(IOleWindow, IWindow);
    if Assigned(IWindow) then
      try
        IWindow.GetWindow(Result);
      finally
        IWindow := nil;
      end;
  end;

var
  i, j: Integer;
  Expl: TExplorer;
  TempCmdBar: TadxCustomCommandBar;
  NewExplorerHandle: HWND;
begin
  {$IFDEF ADX_VCL6}
  if Assigned(IUnknown(TVarData(Explorer).VPointer)) then begin
  {$ELSE}
  if Assigned(Explorer) then begin
  {$ENDIF}
    // fixed 14-May-2008
    // BCM with Outlook 2007
    if FExplorerList.Count > 0 then begin
      {$IFDEF ADX_VCL6}
      NewExplorerHandle := GetExplorerHandle(IUnknown(TVarData(Explorer).VPointer) as _Explorer);
      {$ELSE}
      NewExplorerHandle := GetExplorerHandle(Explorer);
      {$ENDIF}
      if NewExplorerHandle <> 0 then
        for i := 0 to FExplorerList.Count - 1 do begin
          if GetExplorerHandle(TExplorer(FExplorerList[i]).DefaultInterface) = NewExplorerHandle then
            Exit;
        end;
    end;
    Expl := TExplorer.Create(nil);
    {$IFDEF ADX_VCL6}
    Expl.ConnectTo(IUnknown(TVarData(Explorer).VPointer) as _Explorer);
    {$ELSE}
    Expl.ConnectTo(Explorer);
    {$ENDIF}
    Expl.OnActivate := DoExplorerActivate;
    Expl.OnFolderSwitch := DoExplorerFolderSwitch;
    Expl.OnBeforeFolderSwitch := DoExplorerBeforeFolderSwitch;
    Expl.OnViewSwitch := DoExplorerViewSwitch;
    Expl.OnBeforeViewSwitch := DoExplorerBeforeViewSwitch;
    Expl.OnDeactivate := DoExplorerDeactivate;
    Expl.OnSelectionChange := DoExplorerSelectionChange;
    Expl.OnClose := DoExplorerClose;
    FExplorerList.Add(Expl);
    with FAddInModule do
      try
        for i := 0 to ComponentCount - 1 do
          if Components[i] is TadxOlInspectorCustomCommandBar then Continue
          else
            if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
            begin
              TempCmdBar := TadxCustomCommandBar(Components[i]);
              for j := 0 to TempCmdBar.Controls.Count - 1 do
                if TempCmdBar.Controls[j] is TadxCommandBarAdvancedControl then
                  TadxCommandBarAdvancedControl(TempCmdBar.Controls[j]).FControlAdapter.DoNewExplorer(Expl.DefaultInterface);
            end;
        if Assigned(FOnOLNewExplorer) then begin
          {$IFDEF ADX_VCL6}
          FOnOLNewExplorer(ASender, IUnknown(TVarData(Explorer).VPointer) as _Explorer);
          {$ELSE}
          FOnOLNewExplorer(ASender, Explorer);
          {$ENDIF}
        end;
      except
        on E: SysUtils.Exception do DoError(E);
      end;
    if ASender = nil then
      DoExplorerActivate(Expl)
    else begin
      FAddInModule.FExplFirstStart := True;
      // Outlook 12
      if FAddInModule.FHostMajorVersion = 12 then begin
        DoExplorerActivate(Expl);
        FAddInModule.FExplFirstStart := False;
        DoExplorerFolderSwitch(Expl);
      end;
    end;
  end;
end;

procedure TadxAddin.DoExplorerActivate(ASender: TObject);
var
  i, j: Integer;
  TempCmdBar: TadxCustomCommandBar;
  AdvControl: TadxCommandBarAdvancedControl;
begin
  if EventSyncFlag then begin
    exit;
  end;
  EventSyncFlag := true;
  try

  if Assigned(ASender) then
    with FAddInModule do begin
      // context menu
      if not (FHostMajorVersion in [9, 12, 14]) then
      begin
        if Assigned(FSink) then begin
          TadxCommandBarsEventSink(FSink).Disconnect();
          FSink := nil;
        end;
        FSink := TadxCommandBarsEventSink.Create(FAddInModule, TExplorer(ASender).CommandBars);
      end;
      try
        // Outlook 2010 exception
        TExplorer(ASender).CommandBars.QueryInterface(IID__CommandBars, FICmdBars);
      except
        Exit;
      end;
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxOlInspectorCustomCommandBar then Continue
        else
          if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
          begin
            TempCmdBar := TadxCustomCommandBar(Components[i]);
            if FindCommandBar(TempCmdBar.FCommandBarName) = nil then begin
              if not (TempCmdBar is TadxContextMenu) then
                InternalAddCmdBar(TempCmdBar);
            end
            else
              TempCmdBar.ReconnectControls;
            for j := 0 to TempCmdBar.Controls.Count - 1 do
              if TempCmdBar.Controls[j] is TadxCommandBarAdvancedControl then begin
                AdvControl := TempCmdBar.Controls[j] as TadxCommandBarAdvancedControl;
                AdvControl.FControlAdapter.DoExplorerActivate(TExplorer(ASender).DefaultInterface);
              end;
          end;
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxBuiltInControl then begin
          if Assigned(TadxBuiltInControl(Components[i]).FCommandBar) and
            (TadxBuiltInControl(Components[i]).FCommandBar is TadxContextMenu) and
            (HostType = ohaOutlook) and not FIsRibbon then Continue;
          InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
          {$IFDEF ADX_TRIAL}
          Break;
          {$ENDIF}
        end;
      try
        if Assigned(FOnOLExplorerActivate) then
          FOnOLExplorerActivate(ASender);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
      if Assigned(FCTPFactory) then
        FTaskPanes.MakeCTP(TExplorer(ASender).DefaultInterface, 1);
    end;
  finally
    EventSyncFlag := false;
  end;
end;

procedure TadxAddin.DoExplorerFolderSwitch(ASender: TObject);
var
  i: Integer;
  Flag: boolean;
  ItemClass: OlObjectClass;
  FullName: WideString;
  TempBar: TadxOlExplorerCustomCommandbar;
  IFolder: MAPIFolder;
begin
  with FAddInModule do begin
    if FExplFirstStart then
      try
        DoExplorerActivate(ASender);
      finally
        FExplFirstStart := False;
      end;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxOlExplorerCustomCommandbar then begin
        TempBar := TadxOlExplorerCustomCommandbar(Components[i]);
        try
          IFolder := OutlookApp.ActiveExplorer.CurrentFolder;
        except
          // outlook 2000
          IFolder := nil;
        end;
        Flag := TempBar.Enabled;
        if Assigned(IFolder) then FullName := GetFullFolderName(IFolder)
        else FullName := '';
        if not TempBar.BuiltIn and (TempBar.FolderName <> '') then
          TempBar.Enabled := TempBar.FolderName = FullName
        else
          if not TempBar.BuiltIn and (TempBar.FolderNames.Text <> '') then
            TempBar.Enabled := TempBar.FolderNames.IndexOf(FullName) <> -1
          else
            if not TempBar.BuiltIn and Assigned(IFolder) then begin
              ItemClass := IFolder.DefaultItemType;
              TempBar.Enabled := CheckItemClass(ItemClass, TempBar.ItemTypes);
            end;
        TempBar.Visible := TempBar.Enabled;
        if (Flag <> TempBar.Enabled) then begin
          TempBar.CommandBarLeft := TempBar.CommandBarLeft - 1;
          TempBar.CommandBarLeft := TempBar.CommandBarLeft + 1;
        end;
        if Assigned(IFolder) and TempBar.Enabled then
          try
            ScanExplControls(IFolder.DefaultItemType, TempBar.Controls);
          finally
            IFolder := nil;
          end;
      end;
    try
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxBuiltInControl then
          InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
    except
    end;
    try
      if Assigned(FOnOLExplorerFolderSwitch) then
        FOnOLExplorerFolderSwitch(ASender);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
  end;
end;

{$IFDEF ADX_VCL6}
procedure TadxAddin.DoExplorerBeforeFolderSwitch(ASender: TObject;
  var NewFolder: OleVariant; var Cancel: OleVariant);
{$ELSE}
procedure TadxAddin.DoExplorerBeforeFolderSwitch(ASender: TObject;
  const NewFolder: IDispatch; var Cancel: WordBool);
{$ENDIF}
begin
  if Assigned(FAddInModule.FOnOLExplorerBeforeFolderSwitch) then
    try
      {$IFDEF ADX_VCL6}
      FAddInModule.FOnOLExplorerBeforeFolderSwitch(ASender,
        IUnknown(TVarData(NewFolder).VPointer) as IDispatch,
        WordBool(TVarData(Cancel).VPointer^));
      {$ELSE}
      FAddInModule.FOnOLExplorerBeforeFolderSwitch(ASender, NewFolder, Cancel);
      {$ENDIF}
    except
      on E: SysUtils.Exception do FAddInModule.DoError(E);
    end;
end;

procedure TadxAddin.DoExplorerViewSwitch(ASender: TObject);
begin
  if Assigned(FAddInModule.FOnOLExplorerViewSwitch) then
    try
      FAddInModule.FOnOLExplorerViewSwitch(ASender);
    except
      on E: SysUtils.Exception do FAddInModule.DoError(E);
    end;
end;

{$IFDEF ADX_VCL6}
procedure TadxAddin.DoExplorerBeforeViewSwitch(ASender: TObject; NewView: OleVariant;
  var Cancel: OleVariant);
{$ELSE}
procedure TadxAddin.DoExplorerBeforeViewSwitch(ASender: TObject; NewView: OleVariant;
  var Cancel: WordBool);
{$ENDIF}
begin
  if Assigned(FAddInModule.FOnOLExplorerBeforeViewSwitch) then
    try
      {$IFDEF ADX_VCL6}
      FAddInModule.FOnOLExplorerBeforeViewSwitch(ASender, NewView, WordBool(TVarData(Cancel).VPointer^));
      {$ELSE}
      FAddInModule.FOnOLExplorerBeforeViewSwitch(ASender, NewView, Cancel);
      {$ENDIF}
    except
      on E: SysUtils.Exception do FAddInModule.DoError(E);
    end;
end;

procedure TadxAddin.DoExplorerDeactivate(ASender: TObject);
begin
  if Assigned(FAddInModule.FOnOLExplorerDeactivate) then
    try
      FAddInModule.FOnOLExplorerDeactivate(ASender);
    except
      on E: SysUtils.Exception do FAddInModule.DoError(E);
    end;
end;

procedure TadxAddin.DoExplorerSelectionChange(ASender: TObject);
begin
  if Assigned(FAddInModule.FOnOLExplorerSelectionChange) then
    try
      FAddInModule.FOnOLExplorerSelectionChange(ASender);
    except
      on E: SysUtils.Exception do FAddInModule.DoError(E);
    end;
end;

{ TadxInspector }

type
  TadxInspector = class(TInspector)
  private
    FFolderName: WideString;
    FInstalledCommandBars: TList;
    FMailItem: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearCommandBars(IsFullClear: boolean);
    property InstalledCommandBars: TList read FInstalledCommandBars write FInstalledCommandBars;
    property FolderName: WideString read FFolderName write FFolderName;
  end;

constructor TadxInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInstalledCommandBars := TList.Create;
  FMailItem := False;
end;

destructor TadxInspector.Destroy;
begin
  FInstalledCommandBars.Free;
  inherited Destroy;
end;

procedure TadxInspector.ClearCommandBars(IsFullClear: boolean);

  procedure ClearInterfaces(const Controls: TadxCommandBarControls);
  var
    i: Integer;
    Button: CommandBarButton;
    ComboBox: CommandBarComboBox;
    Popup: CommandBarPopup;
    AdvControl: TadxCommandBarAdvancedControl;
  begin
    Button := nil;
    ComboBox := nil;
    Popup := nil;
    for i := 0 to Controls.Count - 1 do begin
      if (Controls[i] is TadxCommandBarButton) and IsFullClear then
        TadxCommandBarButton(Controls[i]).SetInterface(Button)
      else
        if (Controls[i] is TadxCustomCommandBarComboBox) and IsFullClear  then
          TadxCustomCommandBarComboBox(Controls[i]).SetInterface(ComboBox)
        else
          if Controls[i] is TadxCommandBarAdvancedControl then begin
            AdvControl := TadxCommandBarAdvancedControl(Controls[i]);
            AdvControl.FControlAdapter.DoInspectorClose(Self.DefaultInterface);
            AdvControl.SetInterface(Button);
          end
          else
            if (Controls[i] is TadxCommandBarPopup) and IsFullClear then begin
              ClearInterfaces(TadxCommandBarPopup(Controls[i]).Controls);
              TadxCommandBarPopup(Controls[i]).SetInterface(ComboBox);
            end;
    end;
  end;

var
  i: Integer;
begin
  try
    for i := 0 to FInstalledCommandBars.Count - 1 do begin
      ClearInterfaces(TadxOlInspectorCustomCommandBar(FInstalledCommandBars.Items[i]).Controls);
      TadxCustomCommandBar(FInstalledCommandBars.Items[i]).FInterface := nil;
    end;
  except
  end;
end;

{$IFDEF ADX_VCL6}
procedure TadxAddin.DoNewInspector(ASender: TObject; var Inspector: OleVariant);
{$ELSE}
procedure TadxAddin.DoNewInspector(ASender: TObject; const Inspector: _Inspector);
{$ENDIF}
var
  i, j: Integer;
  Insp: TadxInspector;
  IFolder: MAPIFolder;
  ItemClass: OlObjectClass;
  TempCmdBar: TadxOlInspectorCustomCommandBar;
  AdvControl: TadxCommandBarAdvancedControl;
begin
  try
    if Assigned(FAddInModule.FOnOLNewInspector) then
      try
        {$IFDEF ADX_VCL6}
        FAddInModule.FOnOLNewInspector(ASender, IUnknown(TVarData(Inspector).VPointer) as _Inspector);
        {$ELSE}
        FAddInModule.FOnOLNewInspector(ASender, Inspector);
        {$ENDIF}
      except
        on E: SysUtils.Exception do FAddInModule.DoError(E);
      end;
    {$IFDEF ADX_VCL6}
    if (TVarData(Inspector).VPointer = nil) or (_Inspector(IUnknown(TVarData(Inspector).VPointer)).CommandBars = nil) or
      (_Inspector(IUnknown(TVarData(Inspector).VPointer)).CurrentItem = nil) then Exit;
    if Inspector.CurrentItem.Class = olNote then Exit;
    {$ELSE}
    if (Inspector = nil) or (Inspector.CommandBars = nil) or
      (Inspector.CurrentItem = nil) then Exit;
    if OleVariant(Inspector.CurrentItem).Class = olNote then Exit;
    {$ENDIF}
    Insp := TadxInspector.Create(nil);
    {$IFDEF ADX_VCL6}
    Insp.ConnectTo(IUnknown(TVarData(Inspector).VPointer) as _Inspector);
    Insp.FMailItem := (Inspector.CurrentItem.Class = olMail);
    {$ELSE}
    Insp.ConnectTo(Inspector);
    Insp.FMailItem := (OleVariant(Inspector.CurrentItem).Class = olMail);
    {$ENDIF}
    if Assigned(FAddInModule) and Assigned(FAddInModule.OutlookApp) and
      (FAddInModule.OutlookApp.ActiveExplorer <> nil) then
    begin
      try
        IFolder := Explorer(FAddInModule.OutlookApp.ActiveExplorer).CurrentFolder;
        Insp.FolderName := GetFullFolderName(IFolder);
      except
        IFolder := nil;
      end;
    end;
    Insp.OnActivate := DoInspectorActivate;
    Insp.OnDeactivate := DoInspectorDeactivate;
    Insp.OnClose := DoInspectorClose;
    FInspectorList.Add(Insp);
    with FAddInModule do begin
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxOlInspectorCustomCommandBar then begin
          TempCmdBar := TadxOlInspectorCustomCommandBar(Components[i]);
          if (TempCmdBar.FolderName <> '') and
            (TempCmdBar.FolderName <> Insp.FolderName) then Continue;
          if (TempCmdBar.FolderNames.Text <> '') and
            (TempCmdBar.FolderNames.IndexOf(Insp.FolderName) = -1) then Continue;
          try
            ItemClass := OleVariant(Insp.CurrentItem).Class;
            if not CheckItemClass(ItemClass, TempCmdBar.ItemTypes) then Continue;
          except
            Continue;
          end;
          for j := 0 to TempCmdBar.Controls.Count - 1 do
            if TempCmdBar.Controls[j] is TadxCommandBarAdvancedControl then begin
              AdvControl := TadxCommandBarAdvancedControl(TempCmdBar.Controls[j]);
              AdvControl.FControlAdapter.DoNewInspector(Insp.DefaultInterface);
            end;
        end;
    end;
    DoInspectorActivate(Insp);
  except
    // Outlook2000 + Word2000 bug
  end;
end;

procedure TadxAddin.DoInspectorActivate(ASender: TObject);
var
  i, j: Integer;
  ItemClass: OlObjectClass;
  FullName: WideString;
  TempCmdBar: TadxOlInspectorCustomCommandBar;
  Cancel: boolean;
  AdvControl: TadxCommandBarAdvancedControl;
begin
  if EventSyncFlag then begin
    exit;
  end;
  EventSyncFlag := true;
  try

  if Assigned(ASender) then
    with FAddInModule do begin
      TadxInspector(ASender).CommandBars.QueryInterface(IID__CommandBars, FICmdBars);
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxOlInspectorCustomCommandBar then begin
          TempCmdBar := TadxOlInspectorCustomCommandBar(Components[i]);
          if not TempCmdBar.FUseForRibbon and FIsRibbon then Continue;
          Cancel := False;
          if Assigned(TempCmdBar.FOnBeforeAdd) then
            try
              TempCmdBar.FOnBeforeAdd(TadxOlInspectorCommandBar(TempCmdBar),
                (ASender as TInspector).DefaultInterface, Cancel);
            except
              on E: SysUtils.Exception do DoError(E);
            end;
          if not Cancel then begin
            FullName := TadxInspector(ASender).FolderName;
            if (TempCmdBar.FolderName <> '') and
              (TempCmdBar.FolderName <> FullName) then Continue;
            if (TempCmdBar.FolderNames.Text <> '') and
              (TempCmdBar.FolderNames.IndexOf(FullName) = -1) then Continue;
            try
              ItemClass := OleVariant(TadxInspector(ASender).CurrentItem).Class;
              if not CheckItemClass(ItemClass, TempCmdBar.ItemTypes) then Continue;
            except
              Continue;
            end;

            if FindCommandBar(TempCmdBar.FCommandBarName) = nil then begin
              InternalAddCmdBar(TempCmdBar);
              TadxInspector(ASender).InstalledCommandBars.Add(TempCmdBar);
            end
            else begin
              TempCmdBar.ReconnectControls;
              if TadxInspector(ASender).InstalledCommandBars.IndexOf(TempCmdBar) = -1 then
                TadxInspector(ASender).InstalledCommandBars.Add(TempCmdBar);
            end;
            for j := 0 to TempCmdBar.Controls.Count - 1 do
              if TempCmdBar.Controls[j] is TadxCommandBarAdvancedControl then begin
                AdvControl := TempCmdBar.Controls[j] as TadxCommandBarAdvancedControl;
                AdvControl.FControlAdapter.DoInspectorActivate(TadxInspector(ASender).DefaultInterface);
              end;
            try
              ItemClass := OleVariant(TadxInspector(ASender).CurrentItem).Class;
              ScanInspControls(ItemClass, TempCmdBar.Controls);
            except
            end;
            // Case #692
            //for j := 0 to ComponentCount - 1 do
            //  if (Components[j] is TadxBuiltInControl) and
            //    (TadxBuiltInControl(Components[j]).CommandBar = TempCmdBar) then
            //  begin
            //    InternalAddBuiltInControl(TadxBuiltInControl(Components[j]));
            //    {$IFDEF ADX_TRIAL}
            //    Break;
            //    {$ENDIF}
            //  end;
          end;
        end;
        // Case #692
        ConnectBuiltinControls();
      try
        if Assigned(FOnOLInspectorActivate) then
          FOnOLInspectorActivate(ASender);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
      if Assigned(FCTPFactory) then
        FTaskPanes.MakeCTP(TInspector(ASender).DefaultInterface, 2);
    end;
  finally
    EventSyncFlag := false;
  end;
end;

procedure TadxAddin.DoInspectorDeactivate(ASender: TObject);
begin
  with FAddInModule do
    try
      if Assigned(FOnOLInspectorDeactivate) then
        FOnOLInspectorDeactivate(ASender);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
end;

procedure TadxAddin.DoInspectorClose(ASender: TObject);
var
  Index: Integer;
begin
  Index := FInspectorList.IndexOf(ASender);
  if Index >= 0 then begin
    with FAddInModule do
      try
        if Assigned(FOnOLInspectorClose) then
          FOnOLInspectorClose(ASender);
      except
        on E: SysUtils.Exception do DoError(E);
      end;
    FAddInModule.FTaskPanes.RemoveCTP(TadxInspector(FInspectorList.Items[Index]).DefaultInterface);
    TadxInspector(FInspectorList.Items[Index]).ClearCommandBars(FInspectorList.Count = 1);
    TadxInspector(FInspectorList.Items[Index]).Free;
    FInspectorList.Delete(Index);
  end;
end;

procedure TadxAddin.DoExplorerClose(ASender: TObject);
var
  i, j: Integer;
  Index: Integer;
  TempCmdBar: TadxCustomCommandBar;
  AdvControl: TadxCommandBarAdvancedControl;
  IsVersion2000: boolean;
begin
  FAddInModule.SaveExplCommandBars;
  try
    if Assigned(FAddInModule.FOnOLExplorerClose) then
      FAddInModule.FOnOLExplorerClose(ASender);
  except
    on E: SysUtils.Exception do FAddInModule.DoError(E);
  end;
  with FAddInModule do begin
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxOlInspectorCustomCommandBar then Continue
      else
        if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
        begin
          TempCmdBar := TadxCustomCommandBar(Components[i]);
          for j := 0 to TempCmdBar.Controls.Count - 1 do
            if TempCmdBar.Controls[j] is TadxCommandBarAdvancedControl then begin
              AdvControl := TadxCommandBarAdvancedControl(TempCmdBar.Controls[j]);
              AdvControl.FControlAdapter.DoExplorerClose(TExplorer(ASender).DefaultInterface);
            end;
        end;
    if Assigned(FCTPFactory) then
      FTaskPanes.RemoveCTP(TExplorer(ASender).DefaultInterface);
  end;

  IsVersion2000:= pos('9.0', COMAddinModule.FIApp.Version) > 0;

  Index := FExplorerList.IndexOf(ASender);
  if Index > -1 then begin
    TExplorer(FExplorerList.Items[Index]).Free;
    FExplorerList.Delete(Index);
    if FExplorerList.Count = 0 then
      for Index := FInspectorList.Count - 1 downto 0 do begin
        if not IsVersion2000 then
          DoInspectorClose(FInspectorList.Items[Index]);
      end;
  end;
end;

procedure TadxAddin.DoOutlookQuit(ASender: TObject);
var
  tmp: PSafeArray;
  params: TVariantArray;
begin
  try
    if Assigned(FOnQuit) then FOnQuit(ASender);
  except
    on E: SysUtils.Exception do FModule.DoError(E);
  end;
  if Assigned(FModule.FHostEvents) then
    try
      params := nil;
      TadxOutlookAppEventsAccess(FModule.FHostEvents).InvokeEvent(61447, params);
    except
      on E: SysUtils.Exception do FModule.DoError(E);
    end;
  tmp := nil;
  FDoNotRaiseShutdownEvents := True;
  Self.OnBeginShutdown(tmp);
  Self.OnDisconnection(ext_dm_HostShutdown, tmp);
end;

procedure TadxAddin.DoInfoPathWindowActivate(Sender: TObject; const pDocument: _XDocument; const pWindow: Window);
var
  i: Integer;
begin
  with COMAddInModule do begin
    FICmdBars := pWindow.CommandBars as Office2000.CommandBars;
    for i := 0 to ComponentCount - 1 do
      if (Components[i] is TadxOlExplorerCustomCommandBar) or (Components[i] is TadxOlInspectorCustomCommandBar) then Continue
      else
        if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
        begin
          if FindCommandBar(TadxCustomCommandBar(Components[i]).FCommandBarName) = nil then
            InternalAddCmdBar(TadxCustomCommandBar(Components[i]))
          else
            TadxCustomCommandBar(Components[i]).ReconnectControls;
        end;
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TadxBuiltInControl then begin
        InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
        {$IFDEF ADX_TRIAL}
        Break;
        {$ENDIF}
      end;

    try
      if Assigned(FOnInfoPathWindowActivate) then
        FOnInfoPathWindowActivate(Sender, pDocument, pWindow);
    except
      on E: SysUtils.Exception do DoError(E);
    end;
    if Assigned(FCTPFactory) then TaskPanes.MakeCTP(pWindow);
  end;
end;

procedure TadxAddin.DoInfoPathNewXDocument(Sender: TObject; const pDocument: _XDocument);
begin
  try
    if Assigned(FOnInfoPathNewXDocument) then
      FOnInfoPathNewXDocument(Sender, pDocument);
  except
    on E: SysUtils.Exception do COMAddInModule.DoError(E);
  end;
  with COMAddInModule do
    if Assigned(FCTPFactory) then TaskPanes.MakeCTP(InfoPathApp.ActiveWindow);
end;

procedure TadxAddin.DoInfoPathXDocumentOpen(Sender: TObject; const pDocument: _XDocument);
begin
  try
    if Assigned(FOnInfoPathXDocumentOpen) then
      FOnInfoPathXDocumentOpen(Sender, pDocument);
  except
    on E: SysUtils.Exception do COMAddInModule.DoError(E);
  end;
  with COMAddInModule do
    if Assigned(FCTPFactory) then TaskPanes.MakeCTP(InfoPathApp.ActiveWindow);
end;

{$IFDEF DELPHI_7_UP}
procedure TadxAddin.DoPowerPointWindowActivate(ASender: TObject; const Pres: PowerPointPresentation; const Wn: DocumentWindow);
{$ELSE}
procedure TadxAddin.DoPowerPointWindowActivate(ASender: TObject; var Pres: OleVariant; var Wn: OleVariant);
{$ENDIF}
begin
  try
    if Assigned(FOnPowerPointWindowActivate) then
      FOnPowerPointWindowActivate(ASender, Pres, Wn);
  except
    on E: SysUtils.Exception do COMAddInModule.DoError(E);
  end;
  with COMAddInModule do begin
    if Assigned(FCTPFactory) and (FHostMajorVersion >= 14) then
      TaskPanes.MakeCTP(Wn);
  end;
end;

procedure TadxAddin.DoVisioWindowActivated(Sender: TObject; const Window: IVWindow);
begin
  try
    if Assigned(FOnVisioWindowActivated) then
      FOnVisioWindowActivated(Sender, Window);
  except
    on E: SysUtils.Exception do COMAddInModule.DoError(E);
  end;
  with TTimer.Create(nil) do begin
    Enabled := False;
    Interval := 200;
    OnTimer := DoVisioReconnect;
    Enabled := True;
  end;
end;

procedure TadxAddin.DoVisioReconnect(Sender: TObject);
var
  i: Integer;
begin
  (Sender as TTimer).Enabled := False;
  try
    with COMAddInModule do begin
      FICmdBars := VisioApp.CommandBars as _CommandBars;
      for i := 0 to ComponentCount - 1 do
        if (Components[i] is TadxOlExplorerCustomCommandBar) or (Components[i] is TadxOlInspectorCustomCommandBar) then Continue
        else
          if (Components[i] is TadxCustomCommandBar) and (COMAddInModule.HostType in TadxCustomCommandBar(Components[i]).SupportedApps) then
          begin
            if FindCommandBar(TadxCustomCommandBar(Components[i]).FCommandBarName) = nil then
              InternalAddCmdBar(TadxCustomCommandBar(Components[i]))
            else
              TadxCustomCommandBar(Components[i]).ReconnectControls;
          end;
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TadxBuiltInControl then begin
          InternalAddBuiltInControl(TadxBuiltInControl(Components[i]));
          {$IFDEF ADX_TRIAL}
          Break;
          {$ENDIF}
        end;
    end;
  except
  end;
  (Sender as TTimer).Free();
end;

////////////////////////////////////////
// RIBBON
////////////////////////////////////////

type
  TadxXMLHelper = class
  private
    FNewLine: WideString;
    FIndent: Integer;
    FText: WideString;
  public
    constructor Create;
    procedure WriteStartElement(const AName: WideString);
    procedure WriteElementWithAttributeString(const AName: WideString; const AValue: TStringList);
    procedure WriteAttributeString(const AName, AValue: WideString); overload;
    procedure WriteAttributeString(const  AValue: TStringList); overload;
    procedure WriteEndElement(const AName: WideString);
    property Text: WideString read FText;
  end;

{ TadxXMLHelper }

constructor TadxXMLHelper.Create;
begin
  FText := '';
  FNewLine := '';
  FIndent := 0;
end;

procedure TadxXMLHelper.WriteElementWithAttributeString(const AName: WideString;
  const AValue: TStringList);
var
  i: Integer;
begin
  FText := FText + FNewLine + StringOfChar(#9, FIndent) +  '<' + AName;
  for i := 0 to AValue.Count - 1 do
    {$IFDEF DELPHI_7_UP}
    FText := FText + ' ' + AValue.Names[i] + '="' +  AValue.ValueFromIndex[i] + '"';
    {$ELSE}
    FText := FText + ' ' + AValue.Names[i] + '="' + System.Copy(AValue[i], Length(AValue.Names[i]) + 2, MaxInt) + '"';
    {$ENDIF}
  FText := FText + ' />';
end;

procedure TadxXMLHelper.WriteStartElement(const AName: WideString);
begin
  FText := FText + FNewLine + StringOfChar(#9, FIndent) +  '<' + AName + '>';
  FNewLine := #13#10;
  Inc(FIndent);
end;

procedure TadxXMLHelper.WriteAttributeString(const AName, AValue: WideString);
begin
  Insert(' ' + AName + '="' + AValue + '"', FText, Length(FText));
end;

procedure TadxXMLHelper.WriteAttributeString(const AValue: TStringList);
var
  i: Integer;
begin
  for i := 0 to AValue.Count - 1 do
    {$IFDEF DELPHI_7_UP}
    WriteAttributeString(AValue.Names[i], AValue.ValueFromIndex[i]);
    {$ELSE}
    WriteAttributeString(AValue.Names[i], System.Copy(AValue[i], Length(AValue.Names[i]) + 2, MaxInt));
    {$ENDIF}
end;

procedure TadxXMLHelper.WriteEndElement(const AName: WideString);
begin
  Dec(FIndent);
  FText := FText + FNewLine + StringOfChar(#9, FIndent) +  '</' + AName + '>';
end;

function IsItemTypeSupported(RibbonID: WideString; ItemType: TadxRibbons; ItemType2010: TadxRibbons2010): boolean;
const
  RibbonStrings: array [TadxRibbon] of WideString = (
    'Microsoft.Access.Database', 'Microsoft.Excel.Workbook', 'Microsoft.PowerPoint.Presentation',
    'Microsoft.Word.Document', 'Microsoft.Outlook.Mail.Read', 'Microsoft.Outlook.Mail.Compose',
    'Microsoft.Outlook.MeetingRequest.Read', 'Microsoft.Outlook.MeetingRequest.Send',
    'Microsoft.Outlook.Appointment', 'Microsoft.Outlook.Contact', 'Microsoft.Outlook.Journal',
    'Microsoft.Outlook.Task', 'Microsoft.Outlook.DistributionList', 'Microsoft.Outlook.Report',
    'Microsoft.Outlook.Resend', 'Microsoft.Outlook.Response.Read', 'Microsoft.Outlook.Response.Compose',
    'Microsoft.Outlook.Response.CounterPropose', 'Microsoft.Outlook.RSS', 'Microsoft.Outlook.Post.Read',
    'Microsoft.Outlook.Post.Compose', 'Microsoft.Outlook.Sharing.Read', 'Microsoft.Outlook.Sharing.Compose',
    'Microsoft.Outlook.Explorer');
  Ribbon2010Strings: array [TadxRibbon2010] of WideString = (
    'Microsoft.Outlook.Explorer',
    'Microsoft.OMS.SMS.Read', 'Microsoft.OMS.SMS.Compose', 'Microsoft.OMS.MMS.Read', 'Microsoft.OMS.MMS.Compose',
    'Microsoft.InfoPath.Designer', 'Microsoft.InfoPath.Editor', 'Microsoft.InfoPath.PrintPreview',
    'Microsoft.Publisher.Publication', 'Microsoft.Project.Project', 'Microsoft.Visio.Drawing');

var
  i: TadxRibbon;
  i2: TadxRibbon2010;
begin
  Result := False;
  if (ItemType = []) and (ItemType2010 = []) then Exit;
  if (RibbonID = 'DynamicMenu') then Result := True
  // #FIX: 01.18.2010 Office 2010
  else if (RibbonID = 'Microsoft.Mso.IMLayerUI') then Result := True
  else begin
    Result := False;
    for i := Low(TadxRibbon) to High(TadxRibbon) do
      if (i in ItemType) and (RibbonStrings[i] = RibbonID) then begin
        Result := True;
        Break;
      end;
    if not Result then
      for i2 := Low(TadxRibbon2010) to High(TadxRibbon2010) do begin
        if (i2 in ItemType2010) and (Ribbon2010Strings[i2] = RibbonID) then begin
          Result := True;
          Break;
        end;
        // Outlook 2007 SMS and MMS Ribbon IDs
        if (i2 in ItemType2010) and (i2 in [msrOutlookSMSRead2010, msrOutlookSMSCompose2010]) and (RibbonID = 'Microsoft.OMS.SMS') then begin
          Result := True;
          Break;
        end;
        if (i2 in ItemType2010) and (i2 in [msrOutlookMMSRead2010, msrOutlookMMSCompose2010]) and (RibbonID = 'Microsoft.OMS.MMS') then begin
          Result := True;
          Break;
        end;
      end;
  end;
end;

procedure ProcessChildren(AModule: TadxCOMAddInModule; xmlData: TObject;
  RibbonElement: IadxRibbonComponent; RibbonID: WideString; ContextMenuIndex: Integer = 0);
var
  i: Integer;
  tempAttr, wrappedAttr: TStringList;
  helper: TadxXMLHelper;
  type_: WideString;
  ctrls: TadxRibbonControls;
  Split: TadxRibbonSplitButton;
  Menu: TadxRibbonMenu;
  Separator: TadxRibbonSeparator;
begin
  if not IsItemTypeSupported(RibbonID, RibbonElement.GetRibbons, RibbonElement.GetRibbons2010) then Exit;
  wrappedAttr := nil;
  helper := TadxXMLHelper(xmlData);
  type_ := RibbonElement.GetXmlType;
  tempAttr := RibbonElement.GetAttributes(ContextMenuIndex);
  ctrls := RibbonElement.GetControls;
  try
    if ctrls <> nil then begin
      if (type_ = 'menu') and (RibbonElement.GetType = rctMenu) then begin
        Menu := TadxRibbonMenu(AModule.FindRibbonControl(RibbonElement.GetID));
        if Assigned(Menu.FOnCreate) then
          try
            Menu.FOnCreate(Menu);
          except
            on E: SysUtils.Exception do AModule.DoError(E);
          end;
      end;
      if ctrls.Count = 0 then
        helper.WriteElementWithAttributeString(type_, tempAttr)
      else begin
        if (type_ = 'dynamicMenu') then begin
          helper.WriteElementWithAttributeString(type_, tempAttr);
        end
        else begin
          helper.WriteStartElement(type_);
          helper.WriteAttributeString(tempAttr);
          if (type_ = 'splitButton') and (RibbonElement.GetIDMso = '') then begin
            // wrapped button or toggleButton
            Split := TadxRibbonSplitButton(AModule.FindRibbonControl(RibbonElement.GetID));
            if Assigned(Split) then begin
              wrappedAttr := Split.GetWrappedAttributes(ContextMenuIndex);
              if Split.ToggleButton then helper.WriteElementWithAttributeString('toggleButton', wrappedAttr)
              else helper.WriteElementWithAttributeString('button', wrappedAttr);
            end;
          end;
          {$IFDEF ADX_TRIAL}
          if IadxRibbonComponent(RibbonElement).GetControls.Count > 0 then begin
            i := 0;
          {$ELSE}
          for i := 0 to IadxRibbonComponent(RibbonElement).GetControls.Count - 1 do begin
          {$ENDIF}
            ProcessChildren(AModule, helper, IadxRibbonComponent(IadxRibbonComponent(RibbonElement).GetControls[i]), RibbonID, ContextMenuIndex);
          end;
          helper.WriteEndElement(type_);
        end;
      end;
    end else begin
      // backstage tab
      if (type_ = 'tab') and (RibbonElement.GetType = rctBackstageTab) then begin
        helper.WriteStartElement(type_);
        helper.WriteAttributeString(tempAttr);

        if IadxRibbonComponent(RibbonElement).GetFirstColumn.Count > 0 then begin
          helper.WriteStartElement('firstColumn');
          {$IFDEF ADX_TRIAL}
          i := 0;
          {$ELSE}
          for i := 0 to IadxRibbonComponent(RibbonElement).GetFirstColumn.Count - 1 do
          {$ENDIF}
            ProcessChildren(AModule, helper, IadxRibbonComponent(RibbonElement).GetFirstColumn[i], RibbonID, ContextMenuIndex);
          helper.WriteEndElement('firstColumn');
        end;

        if IadxRibbonComponent(RibbonElement).GetSecondColumn.Count > 0 then begin
          helper.WriteStartElement('secondColumn');
          {$IFDEF ADX_TRIAL}
          i := 0;
          {$ELSE}
          for i := 0 to IadxRibbonComponent(RibbonElement).GetSecondColumn.Count - 1 do
          {$ENDIF}
            ProcessChildren(AModule, helper, IadxRibbonComponent(RibbonElement).GetSecondColumn[i], RibbonID, ContextMenuIndex);
          helper.WriteEndElement('secondColumn');
        end;

        helper.WriteEndElement(type_);
      end
      else
      // backstage group
      if (type_ = 'group') and (RibbonElement.GetType = rctBackstageGroup) then begin
        helper.WriteStartElement(type_);
        helper.WriteAttributeString(tempAttr);

        if IadxRibbonComponent(RibbonElement).GetPrimaryItem.Count > 0 then begin
          helper.WriteStartElement('primaryItem');
          ProcessChildren(AModule, helper, IadxRibbonComponent(RibbonElement).GetPrimaryItem[0], RibbonID, ContextMenuIndex);
          helper.WriteEndElement('primaryItem');
        end;

        if IadxRibbonComponent(RibbonElement).GetTopItems.Count > 0 then begin
          helper.WriteStartElement('topItems');
          {$IFDEF ADX_TRIAL}
          i := 0;
          {$ELSE}
          for i := 0 to IadxRibbonComponent(RibbonElement).GetTopItems.Count - 1 do
          {$ENDIF}
            ProcessChildren(AModule, helper, IadxRibbonComponent(RibbonElement).GetTopItems[i], RibbonID, ContextMenuIndex);
          helper.WriteEndElement('topItems');
        end;

        if IadxRibbonComponent(RibbonElement).GetBottomItems.Count > 0 then begin
          helper.WriteStartElement('bottomItems');
          {$IFDEF ADX_TRIAL}
          i := 0;
          {$ELSE}
          for i := 0 to IadxRibbonComponent(RibbonElement).GetBottomItems.Count - 1 do
          {$ENDIF}
            ProcessChildren(AModule, helper, IadxRibbonComponent(RibbonElement).GetBottomItems[i], RibbonID, ContextMenuIndex);
          helper.WriteEndElement('bottomItems');
        end;

        helper.WriteEndElement(type_);
      end
      else
      if type_ = 'dialogBoxLauncher' then begin
        helper.WriteStartElement(type_);
        helper.WriteElementWithAttributeString('button', tempAttr);
        helper.WriteEndElement(type_);
      end
      else
      // Case #1126
      // Office 2010 CT_Separator (in ButtonGroup)
      if type_ = 'separator' then begin
        if AModule.FOfficeXMLNS = 'http://schemas.microsoft.com/office/2006/01/customui' then begin
          Separator := TadxRibbonSeparator(AModule.FindRibbonControl(RibbonElement.GetID));
          if not (TadxRibbonControls(Separator.GetOwner).GetOwner is TadxRibbonButtonGroup) then
            helper.WriteElementWithAttributeString(type_, tempAttr);
        end
        else
          helper.WriteElementWithAttributeString(type_, tempAttr);
      end
      else
        helper.WriteElementWithAttributeString(type_, tempAttr);
    end;
  finally
    if Assigned(wrappedAttr) then FreeAndNil(wrappedAttr);
    FreeAndNil(tempAttr);
  end;
end;

{$IFNDEF DELPHI_7_UP}
function GetFileVersion(const AFileName: string): Cardinal;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := Cardinal(-1);
  FileName := AFileName;
  UniqueString(FileName);
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
          Result:= FI.dwFileVersionMS;
    finally
      FreeMem(VerBuf);
    end;
  end;
end;
{$ENDIF}

function IsContextMenuSupported(RibbonID: WideString; ContextMenuNames: TStrings): TStringList;

  procedure AddNames(ContextMenuNamePrefix: string);
  var
    i: Integer;
    s: string;
  begin
    for i := 0 to ContextMenuNames.Count - 1 do
      if Pos(ContextMenuNamePrefix, ContextMenuNames[i]) = 1 then begin
        s := ContextMenuNames[i];
        Delete(s, 1, Length(ContextMenuNamePrefix));
        Result.Add(s);
      end;
  end;

var
  i: Integer;
begin
  Result := nil;
  if (ContextMenuNames.Count = 0) or
    (RibbonID = 'Microsoft.Access.Database') or
    (RibbonID = 'Microsoft.InfoPath.PrintPreview') or
    (RibbonID = 'Microsoft.Outlook.DistributionList') or
    (RibbonID = 'Microsoft.Outlook.Journal') or
    (RibbonID = 'Microsoft.Outlook.Mail.Compose') or
    (RibbonID = 'Microsoft.OMS.MMS.Compose') or
    (RibbonID = 'Microsoft.Outlook.Post.Compose') or
    (RibbonID = 'Microsoft.Outlook.Resend') or
    (RibbonID = 'Microsoft.OMS.SMS.Compose') or
    (RibbonID = 'Microsoft.OMS.SMS.Read') or
    (RibbonID = 'Microsoft.Outlook.MeetingRequest.Send') or
    (RibbonID = 'Microsoft.Outlook.Response.Compose') or
    (RibbonID = 'Microsoft.Outlook.Sharing.Read') or
    (RibbonID = 'Microsoft.Outlook.Sharing.Compose') or
    (RibbonID = 'Microsoft.Visio.Drawing') then Exit;

  Result := TStringList.Create();
  // custom IDs
  for i := 0 to ContextMenuNames.Count - 1 do
    if Pos('.', ContextMenuNames[i]) = 0 then
      Result.Add(ContextMenuNames[i]);
  // pre-defined IDs
  if RibbonID = 'Microsoft.Excel.Workbook' then AddNames('Excel.')
  else
  if RibbonID = 'Microsoft.PowerPoint.Presentation' then AddNames('PowerPoint.')
  else
  if RibbonID = 'Microsoft.Word.Document' then AddNames('Word.')
  else
  if RibbonID = 'Microsoft.InfoPath.Designer' then AddNames('InfoPath.Designer.')
  else
  if RibbonID = 'Microsoft.InfoPath.Editor' then AddNames('InfoPath.Filler.')
  else
  if RibbonID = 'Microsoft.Publisher.Publication' then AddNames('Publisher.')
  else
  if RibbonID = 'Microsoft.Project.Project' then AddNames('Project.')
  else
  if RibbonID = 'Microsoft.Outlook.Explorer' then AddNames('Outlook.Explorer.')
  else
  if RibbonID = 'Microsoft.Outlook.Appointment' then AddNames('Outlook.Appointment.')
  else
  if RibbonID = 'Microsoft.Outlook.Contact' then AddNames('Outlook.Contact.')
  else
  if RibbonID = 'Microsoft.Outlook.Mail.Read' then AddNames('Outlook.Mail.Read.')
  else
  if RibbonID = 'Microsoft.Outlook.MeetingRequest.Read' then AddNames('Outlook.MeetingRequest.Read.')
  else
  if RibbonID = 'Microsoft.Outlook.Response.CounterPropose' then AddNames('Outlook.MeetingResponse.Propose.')
  else
  if RibbonID = 'Microsoft.Outlook.Response.Read' then AddNames('Outlook.MeetingResponse.Read.')
  else
  if RibbonID = 'Microsoft.OMS.MMS.Read' then AddNames('Outlook.MultimediaMessage.Read.')
  else
  if RibbonID = 'Microsoft.Outlook.Post.Read' then AddNames('Outlook.Post.Read.')
  else
  if RibbonID = 'Microsoft.Outlook.Report' then AddNames('Outlook.Report.')
  else
  if RibbonID = 'Microsoft.Outlook.RSS' then AddNames('Outlook.RSS.')
  else
  if RibbonID = 'Microsoft.Outlook.Task' then AddNames('Outlook.Task.');
end;

function TadxAddin.GetCustomUI(const RibbonID: WideString): WideString;
var
  i, j: Integer;
  xmlData: TadxXMLHelper;
  IsStartFromScratch, Flag, FlagTabs, FlagContextMenus: boolean;
  ContextList: TList;
  ContextMSO: string;
  temp: TStringList;
  Ribbons: TadxRibbons;
  Ribbons2010: TadxRibbons2010;
  Buffer: array [0..MAX_PATH + 1] of Char;
  ExeFileName: string;
  FileVersion: Integer;
  cmIndex: Integer;
begin
  {$IFDEF UNICODE}
  SetString(ExeFileName, Buffer, Windows.GetModuleFileName(0, Buffer, Length(Buffer)));
  {$ELSE}
  SetString(ExeFileName, Buffer, Windows.GetModuleFileName(0, Buffer, SizeOf(Buffer)));
  {$ENDIF}
  // DllHost.exe
  if LowerCase(ExtractFileName(ExeFileName)) = 'dllhost.exe' then begin
    // DLLSurrogate -> 2010 x64
    COMAddInModule.FHostMajorVersion := 14;
  end else begin
    FileVersion := GetFileVersion(ExeFileName);
    if FileVersion <> -1 then
      COMAddInModule.FHostMajorVersion := FileVersion shr 16;
  end;

  if Pos('Microsoft.Access.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaAccess
  else
  if Pos('Microsoft.Excel.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaExcel
  else
  if Pos('Microsoft.PowerPoint.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaPowerPoint
  else
  if Pos('Microsoft.Word.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaWord
  else
  if Pos('Microsoft.InfoPath.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaInfoPath
  else
  if Pos('Microsoft.Publisher.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaPublisher
  else
  if Pos('Microsoft.Project.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaProject
  else
  if Pos('Microsoft.Visio.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaVisio
  else
  if Pos('Microsoft.Outlook.', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaOutlook
  else
  if Pos('Microsoft.OMS.MMS', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaOutlook
  else
  if Pos('Microsoft.OMS.SMS', string(RibbonID)) > 0 then
    COMAddInModule.FHostType := ohaOutlook;

  COMAddInModule.FIsRibbon := True;
  if Assigned(COMAddInModule.FOnRibbonBeforeCreate) then
    try
      COMAddInModule.FOnRibbonBeforeCreate(COMAddInModule, RibbonID);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
  // fix non-host controls
  for i := COMAddInModule.FRibbonControls.Count - 1 downto 0 do begin
    Ribbons := [];
    Ribbons2010 := [];
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonTab then begin
      Ribbons := TadxRibbonTab(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonTab(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonQAT then begin
      Ribbons := TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonOfficeMenu then begin
      Ribbons := TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonCommand then begin
      Ribbons := TadxRibbonCommand(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonCommand(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonCustomControl then begin
      Ribbons := TadxRibbonCustomControl(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonCustomControl(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonContextMenu then begin
      Ribbons := TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;
    if COMAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
      Ribbons := TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).FRibbons;
      Ribbons2010 := TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010;
    end;

    if COMAddInModule.FHostType = ohaOutlook then begin
      if ([msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer, msrOutlookMeetingRequestRead, msrOutlookMeetingRequestSend,
          msrOutlookAppointment, msrOutlookContact, msrOutlookJournal, msrOutlookTask, msrOutlookDistributionList,
          msrOutlookReport, msrOutlookResend, msrOutlookResponseRead, msrOutlookResponseCompose,
          msrOutlookResponseCounterPropose, msrOutlookRSS, msrOutlookPostRead, msrOutlookPostCompose,
          msrOutlookSharingRead, msrOutlookSharingCompose, msrOutlookExplorer] * Ribbons = []) and
         ([msrOutlookExplorer2010, msrOutlookSMSRead2010, msrOutlookSMSCompose2010,
           msrOutlookMMSRead2010, msrOutlookMMSCompose2010] * Ribbons2010 = [])  then
        COMAddInModule.FRibbonControls.Delete(i);
    end
    else
      if not IsItemTypeSupported(RibbonID, Ribbons, Ribbons2010) then
        COMAddInModule.FRibbonControls.Delete(i);
  end;

  xmlData := TadxXMLHelper.Create;
  xmlData.WriteStartElement('customUI');
  // Ribbon 2010
  if COMAddInModule.FHostMajorVersion = 12 then
    COMAddInModule.FOfficeXMLNS := 'http://schemas.microsoft.com/office/2006/01/customui'
  else begin
    if COMAddInModule.FHostMajorVersion >= 14 then begin
      // - для Office 2013 (который имеет версию 15)
      // http://mdp.garant.ru/pages/viewpage.action?pageId=566104714
      Flag := False;
      // check new components
      for i := 0 to COMAddInModule.FRibbonControls.Count - 1 do begin
        // Case #1126
        // Office 2010 CT_Separator (in ButtonGroup)
        if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonSeparator then begin
          if IsItemTypeSupported(RibbonID, TadxRibbonSeparator(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonSeparator(COMAddInModule.FRibbonControls.Objects[i]).Ribbons2010) then
          begin
            if TadxRibbonControls(TadxRibbonSeparator(COMAddInModule.FRibbonControls.Objects[i]).GetOwner).GetOwner is TadxRibbonButtonGroup then
            begin
              Flag := True;
              Break;
            end;
          end;
        end;
        if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonGroup then begin
          if IsItemTypeSupported(RibbonID, TadxRibbonGroup(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonGroup(COMAddInModule.FRibbonControls.Objects[i]).Ribbons2010) then
          begin             
            if TadxRibbonGroup(COMAddInModule.FRibbonControls.Objects[i]).FAutoScale or TadxRibbonGroup(COMAddInModule.FRibbonControls.Objects[i]).FCenterVertically then
            begin
              Flag := True;
              Break;
            end;
          end;
        end;
        if COMAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
          if TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Enabled and
            IsItemTypeSupported(RibbonID, TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
          begin
            Flag := True;
            Break;
          end;
        end;
        if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonContextMenu then begin
          if TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Enabled and
            IsItemTypeSupported(RibbonID, TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
          begin
            Flag := True;
            Break;
          end;
        end;
      end;
      if Flag then
        COMAddInModule.FOfficeXMLNS := 'http://schemas.microsoft.com/office/2009/07/customui'
      else
        COMAddInModule.FOfficeXMLNS := 'http://schemas.microsoft.com/office/2006/01/customui';
    end;
  end;
  xmlData.WriteAttributeString('xmlns', COMAddInModule.FOfficeXMLNS);
  if COMAddInModule.Namespace <> '' then begin
    xmlData.WriteAttributeString('xmlns:' + adxDefaultNS, COMAddInModule.FCOMAddInClassFactory.ProgID);
    xmlData.WriteAttributeString('xmlns:' + adxSharedNS, COMAddInModule.Namespace);
  end;
  xmlData.WriteAttributeString('onLoad', 'RibbonLoaded_Callback');
  xmlData.WriteAttributeString('loadImage', 'GetImages_Callback');
  Flag := False;
  for i := 0 to COMAddInModule.FCommands.Count - 1 do begin
    if not IsItemTypeSupported(RibbonID, TadxRibbonCommand(COMAddInModule.FCommands[i]).Ribbons, TadxRibbonCommand(COMAddInModule.FCommands[i]).GetRibbons2010) then
      Continue;
    if not Flag then begin
      xmlData.WriteStartElement('commands');
      Flag := True;
    end;
    temp := IadxRibbonComponent(TadxRibbonCommand(COMAddInModule.FCommands[i])).GetAttributes;
    if Assigned(temp) then
      try
        xmlData.WriteElementWithAttributeString(IadxRibbonComponent(TadxRibbonCommand(COMAddInModule.FCommands[i])).GetXmlType, temp);
      finally
        FreeAndNil(temp);
      end;
  end;
  if Flag then xmlData.WriteEndElement('commands');

  Flag := False;
  IsStartFromScratch := False;
  if (COMAddInModule.StartFromScratch <> []) or (COMAddInModule.StartFromScratch2010 <> []) then
    IsStartFromScratch := IsItemTypeSupported(RibbonID, COMAddInModule.StartFromScratch, COMAddInModule.StartFromScratch2010);
  // Office Menu - old namespace
  if COMAddInModule.FOfficeXMLNS = 'http://schemas.microsoft.com/office/2006/01/customui' then
    for i := 0 to COMAddInModule.FRibbonControls.Count - 1 do
      if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonOfficeMenu then
        if TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).Enabled and
          IsItemTypeSupported(RibbonID, TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
        begin
          if not Flag then begin
            xmlData.WriteStartElement('ribbon');
            if IsStartFromScratch then
              xmlData.WriteAttributeString('startFromScratch', 'true');
            Flag := True;
          end;
          xmlData.WriteStartElement('officeMenu');
          {$IFDEF ADX_TRIAL}
          if TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count > 0 then begin
            j := 0;
          {$ELSE}
          for j := 0 to TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count - 1 do begin
          {$ENDIF}
            ProcessChildren(COMAddInModule, xmlData,
              IadxRibbonComponent(TadxRibbonOfficeMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls[j]), RibbonID);
          end;
          xmlData.WriteEndElement('officeMenu');
          Break;
        end;

  // QAT
  for i := 0 to COMAddInModule.FRibbonControls.Count - 1 do
    if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonQAT then
      if IsItemTypeSupported(RibbonID, TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
      begin
        if not Flag then begin
          xmlData.WriteStartElement('ribbon');
          if IsStartFromScratch then
            xmlData.WriteAttributeString('startFromScratch', 'true');
          Flag := True;
        end;
        xmlData.WriteStartElement('qat');
        xmlData.WriteStartElement('sharedControls');
        {$IFDEF ADX_TRIAL}
        if TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count > 0 then begin
          j := 0;
        {$ELSE}
        for j := 0 to TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count - 1 do begin
        {$ENDIF}
          ProcessChildren(COMAddInModule, xmlData,
            IadxRibbonComponent(TadxRibbonQAT(COMAddInModule.FRibbonControls.Objects[i]).Controls[j]), RibbonID);
        end;
        xmlData.WriteEndElement('sharedControls');
        xmlData.WriteEndElement('qat');
      end;

  // Tabs
  if COMAddInModule.FTabs.Count > 0 then begin
    if not Flag then begin
      xmlData.WriteStartElement('ribbon');
      if IsStartFromScratch then
        xmlData.WriteAttributeString('startFromScratch', 'true');
      Flag := True;
    end;
    FlagTabs := False;
    for i := 0 to COMAddInModule.FTabs.Count - 1 do begin
      if not FlagTabs and IsItemTypeSupported(RibbonID, TadxRibbonTab(COMAddInModule.FTabs[i]).FRibbons, TadxRibbonTab(COMAddInModule.FTabs[i]).GetRibbons2010) then begin
        xmlData.WriteStartElement('tabs');
        FlagTabs := True;
      end;
      ProcessChildren(COMAddInModule, xmlData,
        IadxRibbonComponent(TadxRibbonTab(COMAddInModule.FTabs[i])), RibbonID);
    end;
    if FlagTabs then
      xmlData.WriteEndElement('tabs');
  end;

  // contextual Tabs
  if COMAddInModule.FContextTabs.Count > 0 then begin
    ContextList := TList.Create;
    if not Flag then begin
      xmlData.WriteStartElement('ribbon');
      if IsStartFromScratch then
        xmlData.WriteAttributeString('startFromScratch', 'true');
      Flag := True;
    end;

    FlagTabs := False;
    for i := 0 to COMAddInModule.FContextTabs.Count - 1 do begin
      if not FlagTabs and IsItemTypeSupported(RibbonID, TadxRibbonTab(COMAddInModule.FContextTabs[i]).FRibbons, TadxRibbonTab(COMAddInModule.FContextTabs[i]).GetRibbons2010) then begin
        FlagTabs := True;
        xmlData.WriteStartElement('contextualTabs');
      end;
      if not FlagTabs then Continue;
      if ContextList.IndexOf(COMAddInModule.FContextTabs[i]) = -1 then begin
        // Case #2165
        xmlData.WriteStartElement('tabSet');
        ContextMSO := TadxRibbonTab(COMAddInModule.FContextTabs[i]).Context;
        if Pos('.', ContextMSO) > 0 then Delete(ContextMSO, 1, Pos('.', ContextMSO));
        xmlData.WriteAttributeString('idMso', ContextMSO);
        ProcessChildren(COMAddInModule, xmlData,
          IadxRibbonComponent(TadxRibbonTab(COMAddInModule.FContextTabs[i])), RibbonID);
        for j := i + 1 to COMAddInModule.FContextTabs.Count - 1 do begin
          if TadxRibbonTab(COMAddInModule.FContextTabs[i]).Context =
            TadxRibbonTab(COMAddInModule.FContextTabs[j]).Context then
          begin
            if ContextList.IndexOf(COMAddInModule.FContextTabs[j]) = -1 then begin
              ProcessChildren(COMAddInModule, xmlData,
                IadxRibbonComponent(TadxRibbonTab(COMAddInModule.FContextTabs[j])), RibbonID);
              ContextList.Add(COMAddInModule.FContextTabs[j]);
            end;
          end;
        end;
        ContextList.Add(COMAddInModule.FContextTabs[i]);
        // Case #2165
        xmlData.WriteEndElement('tabSet');
      end;
    end;
    if FlagTabs then
      xmlData.WriteEndElement('contextualTabs');
    ContextList.Free;
  end;
  if Flag then
    xmlData.WriteEndElement('ribbon');
  // backstage
  if COMAddInModule.FHostMajorVersion >= 14 then
    for i := 0 to COMAddInModule.FRibbonControls.Count - 1 do
      if COMAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then
        if TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Enabled and
          IsItemTypeSupported(RibbonID, TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
        begin
          xmlData.WriteStartElement('backstage');
          xmlData.WriteAttributeString('onShow', 'OnBackstageShow_Callback');
          xmlData.WriteAttributeString('onHide', 'OnBackstageHide_Callback');
          {$IFDEF ADX_TRIAL}
          if TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count > 0 then begin
            j := 0;
          {$ELSE}
          for j := 0 to TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count - 1 do begin
          {$ENDIF}
            ProcessChildren(COMAddInModule, xmlData,
              IadxRibbonComponent(TadxBackstageView(COMAddInModule.FRibbonControls.Objects[i]).Controls[j]), RibbonID);
          end;
          xmlData.WriteEndElement('backstage');
          Break;
        end;
  // contextMenus
  if COMAddInModule.FHostMajorVersion >= 14 then begin
    FlagContextMenus := False;
    for i := 0 to COMAddInModule.FRibbonControls.Count - 1 do
      if COMAddInModule.FRibbonControls.Objects[i] is TadxRibbonContextMenu then
        if TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Enabled and
          IsItemTypeSupported(RibbonID, TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Ribbons, TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).GetRibbons2010) then
        begin
          temp := IsContextMenuSupported(RibbonID, TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).FContextMenuNames);
          if Assigned(temp) and (temp.Count > 0) then begin
            if not FlagContextMenus then begin
              xmlData.WriteStartElement('contextMenus');
              FlagContextMenus := True;
            end;
            for cmIndex := 0 to temp.Count - 1 do begin
              xmlData.WriteStartElement('contextMenu');
              xmlData.WriteAttributeString('idMso', temp[cmIndex]);
              {$IFDEF ADX_TRIAL}
              if TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count > 0 then begin
                j := 0;
              {$ELSE}
              for j := 0 to TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls.Count - 1 do begin
              {$ENDIF}
                ProcessChildren(COMAddInModule, xmlData,
                  IadxRibbonComponent(TadxRibbonContextMenu(COMAddInModule.FRibbonControls.Objects[i]).Controls[j]), RibbonID, cmIndex);
              end;
              xmlData.WriteEndElement('contextMenu');
            end;
          end;
          if Assigned(temp) then FreeAndNil(temp);
        end;
    if FlagContextMenus then
      xmlData.WriteEndElement('contextMenus');
  end;

  xmlData.WriteEndElement('customUI');
  Result := xmlData.Text;
  if Assigned(COMAddInModule.FOnRibbonBeforeLoad) then
    try
      {$IFNDEF ADX_TRIAL}
      COMAddInModule.FOnRibbonBeforeLoad(COMAddInModule, RibbonID, Result);
      {$ENDIF}
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
  xmlData.Free;
end;

procedure TadxAddin.CTPFactoryAvailable(const CTPFactoryInst: ICTPFactory);
var
  i: Integer;
  Index: OleVariant;
begin
  COMAddInModule.FCTPFactory := CTPFactoryInst;
  COMAddInModule.DoCTPFactoryAvailable;
  with FAddInModule do
    if FStartupCompleteCounter > 0 then
      case HostType of
        ohaExcel:
          FTaskPanes.MakeCTP(ExcelApp.ActiveWindow);
        ohaAccess:
          FTaskPanes.MakeCTP(nil);
        ohaPowerPoint:
          if PowerPointApp.Windows.Count > 0 then
            FTaskPanes.MakeCTP(PowerPointApp.ActiveWindow)
          else
            FTaskPanes.MakeCTP(nil);
        ohaWord:
          begin
            FTaskPanes.FShowWindowsInTaskbar := HostApp.ShowWindowsInTaskbar;
            for i := 1 to WordApp.Documents.Count do begin
              Index := i;
              FTaskPanes.MakeCTP(WordApp.Documents.Item(Index).ActiveWindow);
            end;
          end;
        ohaInfoPath:
          begin
            for i := 0 to InfoPathApp.Windows.Count - 1 do
              FTaskPanes.MakeCTP(InfoPathApp.Windows.Item[i]);
          end;
        ohaOutlook:
          begin
            for i := 1 to OutlookApp.Explorers.Count do
              FTaskPanes.MakeCTP(OutlookApp.Explorers.Item(i), 1);
            for i := 1 to OutlookApp.Inspectors.Count do
              FTaskPanes.MakeCTP(OutlookApp.Inspectors.Item(i), 2);
          end;
        // Case #1617
        ohaProject:
          begin
            if FHostMajorVersion >= 14 then
              FTaskPanes.MakeCTP(ProjectApp.ActiveWindow);
          end;
      end;
end;

function TadxAddin.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := inherited GetTypeInfo(Index, LocaleID, TypeInfo);
end;

function TadxAddin.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := inherited GetTypeInfoCount(Count);
end;

function TadxAddin.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;

  procedure WideCharToShortString(P: PWideChar; var S: ShortString);
  var
    I: Integer;
    W: WideChar;
  begin
    I := 0;
    repeat
      W := P[I];
      if W = #0 then Break;
      if W >= #256 then W := #0;
      Inc(I);
      {$IFDEF UNICODE}
      S[I] := AnsiChar(W);
      {$ELSE}
      S[I] := Char(W);
      {$ENDIF}
    until I = 255;
    {$IFDEF UNICODE}
    S[0] := AnsiChar(I);
    {$ELSE}
    S[0] := Char(I);
    {$ENDIF}
  end;

type
  PNames = ^TNames;
  TNames = array[0..100] of POleStr;
  PDispIDs = ^TDispIDs;
  TDispIDs = array[0..100] of Cardinal;
var
  Name: ShortString;
begin
  Result := inherited GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
  if Result <> S_OK then begin
    Result := S_OK;
    WideCharToShortString(PNames(Names)^[0], Name);
    FillChar(DispIDs^, SizeOf(PDispIds(DispIDs^)[0]) * NameCount, $FF);
    // reserved
    // 18, 39, 40
    if Name = 'RibbonLoaded_Callback' then PDispIds(DispIds)^[0] := 10
    else
    if Name = 'GetImages_Callback' then PDispIds(DispIds)^[0] := 11
    else
    if Name = 'GetVisible_Callback' then PDispIds(DispIds)^[0] := 12
    else
    if Name = 'GetKeyTip_Callback' then PDispIds(DispIds)^[0] := 13
    else
    if Name = 'GetLabel_Callback' then PDispIds(DispIds)^[0] := 14
    else
    if Name = 'GetEnabled_Callback' then PDispIds(DispIds)^[0] := 15
    else
    if Name = 'GetPressed_Callback' then PDispIds(DispIds)^[0] := 16
    else
    if Name = 'GetImage_Callback' then PDispIds(DispIds)^[0] := 17
    else
    if Name = 'GetSuperTip_Callback' then PDispIds(DispIds)^[0] := 19
    else
    if Name = 'GetScreenTip_Callback' then PDispIds(DispIds)^[0] := 20
    else
    if Name = 'GetSize_Callback' then PDispIds(DispIds)^[0] := 21
    else
    if Name = 'GetShowLabel_Callback' then PDispIds(DispIds)^[0] := 22
    else
    if Name = 'GetShowImage_Callback' then PDispIds(DispIds)^[0] := 23
    else
    if Name = 'GetDescription_Callback' then PDispIds(DispIds)^[0] := 24
    else
    if Name = 'GetText_Callback' then PDispIds(DispIds)^[0] := 25
    else
    if Name = 'GetItemCount_Callback' then PDispIds(DispIds)^[0] := 26
    else
    if Name = 'GetItemID_Callback' then PDispIds(DispIds)^[0] := 27
    else
    if Name = 'GetItemImage_Callback' then PDispIds(DispIds)^[0] := 28
    else
    if Name = 'GetItemLabel_Callback' then PDispIds(DispIds)^[0] := 29
    else
    if Name = 'GetItemScreenTip_Callback' then PDispIds(DispIds)^[0] := 30
    else
    if Name = 'GetItemSuperTip_Callback' then PDispIds(DispIds)^[0] := 31
    else
    if Name = 'GetShowItemImage_Callback' then PDispIds(DispIds)^[0] := 32
    else
    if Name = 'GetSelectedItemIndex_Callback' then PDispIds(DispIds)^[0] := 33
    else
    if Name = 'GetSelectedItemId_Callback' then PDispIds(DispIds)^[0] := 34
    else
    if Name = 'GetItemHeight_Callback' then PDispIds(DispIds)^[0] := 35
    else
    if Name = 'GetItemWidth_Callback' then PDispIds(DispIds)^[0] := 36
    else
    if Name = 'GetContent_Callback' then PDispIds(DispIds)^[0] := 37
    else
    if Name = 'GetTitle_Callback' then PDispIds(DispIds)^[0] := 38
    else
    // events
    if Name = 'OnActionCommon_Callback' then PDispIds(DispIds)^[0] := 50
    else
    if Name = 'OnActionCommonRepurposed_Callback' then PDispIds(DispIds)^[0] := 51
    else
    if Name = 'OnActionState_Callback' then PDispIds(DispIds)^[0] := 52
    else
    if Name = 'OnActionStateRepurposed_Callback' then PDispIds(DispIds)^[0] := 53
    else
    if Name = 'OnActionSelected_Callback' then PDispIds(DispIds)^[0] := 54
    else
    if Name = 'OnChange_Callback' then PDispIds(DispIds)^[0] := 55
    else
    // Office 2010
    if Name = 'OnBackstageShow_Callback' then PDispIds(DispIds)^[0] := 60
    else
    if Name = 'OnBackstageHide_Callback' then PDispIds(DispIds)^[0] := 61
    else
    if Name = 'GetTarget_Callback' then PDispIds(DispIds)^[0] := 62
    else
    if Name = 'GetAltText_Callback' then PDispIds(DispIds)^[0] := 63
    else
    if Name = 'GetHelperText_Callback' then PDispIds(DispIds)^[0] := 64
    else
    if Name = 'GetStyle_Callback' then PDispIds(DispIds)^[0] := 65
    else
      Result := inherited GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
  end;
end;

function TadxAddin.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  Parms: PDispParams;
  TempRet: OleVariant;
  Cancel: WordBool;
begin
  Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
  if Result <> S_OK then begin
    Result := S_OK;
    Parms := @Params;
    try
      if VarResult = nil then VarResult := @TempRet;
      case DispID of
        10: RibbonLoaded_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonUI);
        11: POleVariant(VarResult)^ := GetImages_Callback(Parms^.rgvarg^[0].bstrVal);
        12: POleVariant(VarResult)^ := GetVisible_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        13: POleVariant(VarResult)^ := GetKeyTip_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        14: POleVariant(VarResult)^ := GetLabel_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        15: POleVariant(VarResult)^ := GetEnabled_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        16: POleVariant(VarResult)^ := GetPressed_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        17: POleVariant(VarResult)^ := GetImage_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        19: POleVariant(VarResult)^ := GetSuperTip_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        20: POleVariant(VarResult)^ := GetScreenTip_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        21: POleVariant(VarResult)^ := GetSize_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        22: POleVariant(VarResult)^ := GetShowLabel_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        23: POleVariant(VarResult)^ := GetShowImage_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        24: POleVariant(VarResult)^ := GetDescription_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        25: POleVariant(VarResult)^ := GetText_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        26: POleVariant(VarResult)^ := GetItemCount_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        27: POleVariant(VarResult)^ := GetItemID_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        28: POleVariant(VarResult)^ := GetItemImage_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        29: POleVariant(VarResult)^ := GetItemLabel_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        30: POleVariant(VarResult)^ := GetItemScreenTip_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        31: POleVariant(VarResult)^ := GetItemSuperTip_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        32: POleVariant(VarResult)^ := GetShowItemImage_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].lVal);
        33: POleVariant(VarResult)^ := GetSelectedItemIndex_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        34: POleVariant(VarResult)^ := GetSelectedItemId_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        35: POleVariant(VarResult)^ := GetItemHeight_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        36: POleVariant(VarResult)^ := GetItemWidth_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        37: POleVariant(VarResult)^ := GetContent_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        38: POleVariant(VarResult)^ := GetTitle_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        //
        //18, 39, 40: ;
        //
        50: OnActionCommon_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        51: begin
              Cancel := Parms^.rgvarg^[0].pvarVal^;
              OnActionCommonRepurposed_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Cancel);
              Parms^.rgvarg^[0].pvarVal^ := Cancel;
            end;
        52: OnActionState_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl, Parms^.rgvarg^[0].vbool);
        53: begin
              Cancel := Parms^.rgvarg^[0].pvarVal^;
              OnActionStateRepurposed_Callback(IDispatch(Parms^.rgvarg^[2].dispVal) as IRibbonControl,
                Parms^.rgvarg^[1].vbool, Cancel);
              Parms^.rgvarg^[0].pvarVal^ := Cancel;
            end;
        54: OnActionSelected_Callback(IDispatch(Parms^.rgvarg^[2].dispVal) as IRibbonControl,
              Parms^.rgvarg^[1].bstrVal, Parms^.rgvarg^[0].lVal);
        55: OnChange_Callback(IDispatch(Parms^.rgvarg^[1].dispVal) as IRibbonControl,
              Parms^.rgvarg^[0].bstrVal);
        // Office 2010
        60: OnBackstageShow_Callback(IDispatch(Parms^.rgvarg^[0].dispVal));
        61: OnBackstageHide_Callback(IDispatch(Parms^.rgvarg^[0].dispVal));
        62: POleVariant(VarResult)^ := GetTarget_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        63: POleVariant(VarResult)^ := GetAltText_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        64: POleVariant(VarResult)^ := GetHelperText_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        65: POleVariant(VarResult)^ := GetStyle_Callback(IDispatch(Parms^.rgvarg^[0].dispVal) as IRibbonControl);
        else
          Result := inherited Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo, ArgErr);
      end;
    except
      Result := DISP_E_EXCEPTION;
    end;
  end;
end;

function GetRibbonControl(AModule: TadxCOMAddInModule; const AId: WideString): IadxRibbonComponent;
var
  id: WideString;
  Index: Integer;
  AObject: TObject;
begin
  id := AId;
  {$IFDEF UNICODE}
  Index := Pos(WideString('_adx_context_menu_'), id);
  {$ELSE}
  Index := Pos('_adx_context_menu_', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('_adx_context_menu_XXXX')); // 1000
  Result := nil;
  Index := AModule.FRibbonControls.IndexOf(id);
  if Index >= 0 then begin
    AObject := AModule.FRibbonControls.Objects[Index];
    if AObject is TadxRibbonTab then
      Result := IadxRibbonComponent(TadxRibbonTab(AObject))
    else
    if AObject is TadxRibbonOfficeMenu then
      Result := IadxRibbonComponent(TadxRibbonOfficeMenu(AObject))
    else
    if AObject is TadxRibbonQAT then
      Result := IadxRibbonComponent(TadxRibbonQAT(AObject))
    else
    if AObject is TadxRibbonCommand then
      Result := IadxRibbonComponent(TadxRibbonCommand(AObject))
    else
    if AObject is TadxRibbonContextMenu then
      Result := IadxRibbonComponent(TadxRibbonContextMenu(AObject))
    else
      Result := IadxRibbonComponent(TadxRibbonCustomControl(AObject));
  end;
end;

procedure CheckMsoControls(Module: TadxCOMAddInModule; MsoID: WideString;
  const Context: IDispatch; var ICtrl: IadxRibbonComponent);
var
  i, Count: Integer;
  IInspector: _Inspector;
  MsgClass: string;
  Ribbons: TadxRibbons;
  Ribbons2010: TadxRibbons2010;
begin
  if not Assigned(Context) then Exit;
  Count := 0;
  for i := 0 to Module.FRibbonControls.Count - 1 do begin
    if Module.FRibbonControls.Objects[i] is TadxRibbonCustomControl then begin
      if TadxRibbonCustomControl(Module.FRibbonControls.Objects[i]).IdMso = MsoID then Inc(Count);
    end
    else
    if Module.FRibbonControls.Objects[i] is TadxRibbonCommand then begin
      if TadxRibbonCommand(Module.FRibbonControls.Objects[i]).IdMso = MsoID then Inc(Count);
    end
    else
      if Module.FRibbonControls.Objects[i] is TadxRibbonTab then begin
        if TadxRibbonTab(Module.FRibbonControls.Objects[i]).IdMso = MsoID then Inc(Count);
     end;
    if Count > 1 then Break;
  end;
  // Context needed
  // Outlook only - Inspector
  if Count > 0 then begin // Case #2160
    Context.QueryInterface(IID__Inspector, IInspector);
    if Assigned(IInspector) then
      try
        try
          MsgClass := OleVariant(IInspector).CurrentItem.MessageClass;
        except
          MsgClass := '';
        end;
        if MsgClass <> '' then begin
          if Pos('ipm.note', LowerCase(MsgClass)) = 1 then begin
            Ribbons := [msrOutlookMailRead, msrOutlookMailCompose];
            if Pos('ipm.note.mobile.sms', LowerCase(MsgClass)) = 1 then
              Ribbons2010 := [msrOutlookSMSRead2010, msrOutlookSMSCompose2010]
            else
            if Pos('ipm.note.mobile.mms', LowerCase(MsgClass)) = 1 then
              Ribbons2010 := [msrOutlookMMSRead2010, msrOutlookMMSCompose2010];
          end
          else
          if Pos('ipm.schedule.meeting.resp', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookResponseRead, msrOutlookResponseCompose, msrOutlookResponseCounterPropose]
          else
          if Pos('ipm.schedule.meeting', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookMeetingRequestRead, msrOutlookMeetingRequestSend]
          else
          if (Pos('ipm.appointment', LowerCase(MsgClass)) = 1) or (Pos('ipm.ole.class', LowerCase(MsgClass)) = 1) then
            Ribbons := [msrOutlookAppointment]
          else
          if Pos('ipm.contact', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookContact]
          else
          if Pos('ipm.activity', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookJournal]
          else
          if Pos('ipm.task', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookTask]
          else
          if Pos('ipm.distlist', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookDistributionList]
          else
          if Pos('ipm.report', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookReport]
          else
          if Pos('ipm.resend', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookResend]
          else
          if Pos('ipm.post.rss', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookRSS]
          else
          if Pos('ipm.post', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookPostRead, msrOutlookPostCompose]
          else
          if Pos('ipm.sharing', LowerCase(MsgClass)) = 1 then
            Ribbons := [msrOutlookSharingRead, msrOutlookSharingCompose]
          else begin
            Ribbons := [];
            Ribbons2010 := [];
          end;

          if Ribbons <> [] then begin
            if (ICtrl <> nil) and (Ribbons * ICtrl.GetRibbons() <> []) then Exit;
            // scan and check Ribbons
            for i := 0 to Module.FRibbonControls.Count - 1 do
              if Module.FRibbonControls.Objects[i] is TadxRibbonCustomControl then begin
                if TadxRibbonCustomControl(Module.FRibbonControls.Objects[i]).IdMso = MsoID then
                  if (TadxRibbonCustomControl(Module.FRibbonControls.Objects[i]).Ribbons * Ribbons <> []) or
                    (TadxRibbonCustomControl(Module.FRibbonControls.Objects[i]).Ribbons2010 * Ribbons2010 <> []) then begin
                    ICtrl := IadxRibbonComponent(TadxRibbonCustomControl(Module.FRibbonControls.Objects[i]));
                    Break;
                  end;
              end
              else
              if Module.FRibbonControls.Objects[i] is TadxRibbonCommand then begin
                if TadxRibbonCommand(Module.FRibbonControls.Objects[i]).IdMso = MsoID then
                  if (TadxRibbonCommand(Module.FRibbonControls.Objects[i]).Ribbons * Ribbons <> []) or
                    (TadxRibbonCommand(Module.FRibbonControls.Objects[i]).Ribbons2010 * Ribbons2010 <> []) then begin
                    ICtrl := IadxRibbonComponent(TadxRibbonCommand(Module.FRibbonControls.Objects[i]));
                    Break;
                  end;
              end
              else
                if Module.FRibbonControls.Objects[i] is TadxRibbonTab then begin
                  if TadxRibbonTab(Module.FRibbonControls.Objects[i]).IdMso = MsoID then
                    if (TadxRibbonTab(Module.FRibbonControls.Objects[i]).Ribbons * Ribbons <> []) or
                      (TadxRibbonTab(Module.FRibbonControls.Objects[i]).Ribbons2010 * Ribbons2010 <> []) then begin
                      ICtrl := IadxRibbonComponent(TadxRibbonTab(Module.FRibbonControls.Objects[i]));
                      Break;
                    end;
               end;
          end;
        end;
      finally
        IInspector := nil;
      end;
  end;
end;

type
  TadxRibbonCustomControlAccess = class(TadxRibbonCustomControl);

function GetImageList(AModule: TadxCOMAddInModule; const AId: WideString): TCustomImageList;
var
  Index: Integer;
  AObject: TObject;
  ARoot: TComponent;
begin
  Result := nil;
  Index := AModule.FRibbonControls.IndexOf(AId);
  if Index >= 0 then begin
    AObject := AModule.FRibbonControls.Objects[Index];
    if AObject is TadxRibbonCustomControl then begin
      ARoot := TadxRibbonCustomControlAccess(AObject).GetRoot;
      if ARoot is TadxRibbonTab then
        Result := TadxRibbonTab(ARoot).Images
      else
        if ARoot is TadxRibbonOfficeMenu then
          Result := TadxRibbonOfficeMenu(ARoot).Images
        else
          Result := TadxRibbonQAT(ARoot).Images;
    end;
  end;
end;

procedure TadxAddin.RibbonLoaded_Callback(const ribbon: IRibbonUI);
begin
  COMAddInModule.FRibbonUI := ribbon;
  // Case #1118 Fast Start (LoadBehavior = 16)
  if COMAddInModule.FOfficeXMLNS = '' then begin
    if COMAddInModule.FHostMajorVersion = 12 then
      COMAddInModule.FOfficeXMLNS := 'http://schemas.microsoft.com/office/2006/01/customui'
    else
      COMAddInModule.FOfficeXMLNS := 'http://schemas.microsoft.com/office/2009/07/customui';
  end;
  if Assigned(COMAddInModule.OnRibbonLoaded) then
    try
      COMAddInModule.OnRibbonLoaded(COMAddInModule, ribbon);
    except
      on E: SysUtils.Exception do COMAddInModule.DoError(E);
    end;
end;

function TadxAddin.GetVisible_Callback(const Ctrl: IRibbonControl): WordBool;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := True;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetVisible;
      ICtrl.DoChangeProperty(rcptVisible, defaultValue, Ctrl.Context, -1);
      if (COMAddInModule.HostType = ohaOutlook) and (ICtrl.GetIDMso() = Ctrl.Id) then
        CheckMsoControls(COMAddInModule, Ctrl.Id, Ctrl.Context, ICtrl);
      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetKeyTip_Callback(const Ctrl: IRibbonControl): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
     {$IFDEF UNICODE}
      defaultValue := WideString(ICtrl.GetKeyTip);
     {$ELSE}
      defaultValue := ICtrl.GetKeyTip;
     {$ENDIF}
      ICtrl.DoChangeProperty(rcptKeyTip, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetLabel_Callback(const Ctrl: IRibbonControl): WideString;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetCaption;
      ICtrl.DoChangeProperty(rcptCaption, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetEnabled_Callback(const Ctrl: IRibbonControl): WordBool;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := True;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      if (COMAddInModule.HostType = ohaOutlook) and (ICtrl.GetIDMso() = Ctrl.Id) then
        CheckMsoControls(COMAddInModule, Ctrl.Id, Ctrl.Context, ICtrl);

      defaultValue := ICtrl.GetEnabled;
      ICtrl.DoChangeProperty(rcptEnabled, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetPressed_Callback(const Ctrl: IRibbonControl): WordBool;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := False;
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetPressed;
      ICtrl.DoChangeProperty(rcptPressed, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

type
  PColor32Alpha = ^TColor32Alpha;
  TColor32Alpha = type Cardinal;
  PColor32AlphaArray = ^TColor32AlphaArray;
  TColor32AlphaArray = array [0..0] of TColor32Alpha;

function Color32Alpha(WinColor: TColor): TColor32Alpha;
begin
  if WinColor < 0 then WinColor := GetSysColor(WinColor and $000000FF);
  asm
    MOV    EAX,WinColor
    BSWAP  EAX
    MOV    AL,$FF
    ROR    EAX,8
    MOV    Result,EAX
  end;
end;

function Create32BitWithAlpha(const Bmp: TBitmap): HBITMAP;

  procedure SetAlpha(const AlphaValue: Byte; Bits: PColor32AlphaArray);
  var
    i: Integer;
    P: PByte;
    NH, NL: Integer;
  begin
    P := Pointer(Bits);
    Inc(P, 3);
    i := Bmp.Width * Bmp.Height;
    NH := i shr 2;
    NL := i and 3;
    for i := 0 to NH - 1 do begin
      P^ := AlphaValue; Inc(P, 4);
      P^ := AlphaValue; Inc(P, 4);
      P^ := AlphaValue; Inc(P, 4);
      P^ := AlphaValue; Inc(P, 4);
    end;
    for i := 0 to NL - 1 do begin
      P^ := AlphaValue; Inc(P, 4);
    end;
  end;

var
  i: Integer;
  FHDC: HDC;
  FHandle: HBITMAP;
  FBitmapInfo: TBitmapInfo;
  Bits: PColor32AlphaArray;
  TransparentColor: TColor32Alpha;
  DstP: PColor32Alpha;
  DstColor: TColor32Alpha;
begin
  Result := 0;
  FillChar(FBitmapInfo, SizeOf(TBitmapInfo), 0);
  with FBitmapInfo.bmiHeader do begin
    biSize := SizeOf(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;

    biWidth := Bmp.Width;
    biHeight := -Bmp.Height;
  end;
  FHandle := CreateDIBSection(0, FBitmapInfo, DIB_RGB_COLORS, Pointer(Bits), 0, 0);
  if Bits = nil then Exit;
  FHDC := CreateCompatibleDC(0);
  if FHDC = 0 then begin
    DeleteObject(FHandle);
    Bits := nil;
    Exit;
  end;
  if SelectObject(FHDC, FHandle) = 0 then begin
    DeleteDC(FHDC);
    DeleteObject(FHandle);
    Bits := nil;
    Exit;
  end;
  Bmp.Canvas.Lock;
  try
    BitBlt(FHDC, 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    Bmp.Canvas.UnLock;
  end;
  if not ((Bmp.PixelFormat = pf32bit) or ((Bmp.PixelFormat = pfDevice) and (GetDeviceCaps(Bmp.Canvas.Handle, BITSPIXEL) >= 32))) then
    SetAlpha($FF, Bits);
  if Bmp.Transparent then begin
    TransparentColor := Color32Alpha(Bmp.TransparentColor) and $00FFFFFF;
    DstP := @Bits[0];
    for i := 0 to Bmp.Width * Bmp.Height - 1 do
    begin
      DstColor := DstP^ and $00FFFFFF;
      if DstColor = TransparentColor then
        DstP^ := DstColor;
      inc(DstP);
    end;
  end;
  Result := FHandle;
  DeleteDC(FHDC);
  Bits := nil;
end;

function GetImage(const ICtrl: IadxRibbonComponent; Module: TadxCOMAddInModule): IPictureDisp;
var
  ImgList: TCustomImageList;
  ImgIndex: TImageIndex;
  PictureDesc: TPictDesc;
  bmp: TBitmap;
begin
  Result := nil;
  if not ICtrl.GetGlyph().Empty then begin
    Bmp := TBitmap.Create;
    Bmp.Transparent:= true;
    try
      Bmp.Assign(ICtrl.GetGlyph());
      Bmp.Transparent := True;
      PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
      PictureDesc.picType := PICTYPE_BITMAP;
      PictureDesc.hbitmap := Create32BitWithAlpha(Bmp);   //16.02.2011 Case 2131
      PictureDesc.hpal := Bmp.ReleasePalette;
      OleCreatePictureIndirect(PictureDesc, ActiveX.IPictureDisp, True, Result);
    finally
      Bmp.Free;
    end;
  end else begin
    ImgIndex := ICtrl.GetImageIndex();
    ImgList := GetImageList(Module, ICtrl.GetID());
    if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
      Bmp := TBitmap.Create;
      Bmp.Transparent:= true;
      try
        ImgList.GetBitmap(ImgIndex, Bmp);
        PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
        PictureDesc.picType := PICTYPE_BITMAP;
        PictureDesc.hbitmap := Create32BitWithAlpha(Bmp);   //16.02.2011 Case 2131
        PictureDesc.hpal := Bmp.ReleasePalette;
        OleCreatePictureIndirect(PictureDesc, ActiveX.IPictureDisp, True, Result);
      finally
        Bmp.Free;
      end;
    end;
  end;
end;

function TadxAddin.GetImages_Callback(AImageName: string): IPictureDisp;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
begin
  Result := nil;
  id := AImageName;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      Result := GetImage(ICtrl, COMAddInModule);
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetImage_Callback(const Ctrl: IRibbonControl): IPictureDisp;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultImage: OleVariant;
begin
  Result := nil;
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      TVarData(defaultImage).VDispatch:= nil;
      ICtrl.DoChangeProperty(rcptGlyph, defaultImage, Ctrl.Context, -1);
      if TVarData(defaultImage).VDispatch <> nil then
        Result:= IPictureDisp(TVarData(defaultImage).VDispatch)
      else
        Result := GetImage(ICtrl, COMAddInModule);
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemImage_Callback(const Ctrl: IRibbonControl; Index: Integer): IPictureDisp;
var
  ICtrl: IadxRibbonComponent;
  ImgList: TCustomImageList;
  ImgIndex: TImageIndex;
  Icon: TIcon;
  PictureDesc: TPictDesc;
  tmp: TCustomImageList;
  defaultImage: OleVariant;
begin
  Result := nil;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      TVarData(defaultImage).VDispatch:= nil;
      ICtrl.DoChangeProperty(rcptItemGlyph, defaultImage, Ctrl.Context, Index);
      if TVarData(defaultImage).VDispatch <> nil then
        Result:= IPictureDisp(TVarData(defaultImage).VDispatch)
      else begin
        if not IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Empty then begin
          Icon := TIcon.Create;
          try
            tmp := TCustomImageList.CreateSize(IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Width, IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Height);
            try
              tmp.AddMasked(IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph(),
                IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Canvas.Pixels[0,
                IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Height - 1]);
              tmp.GetIcon(0, Icon);
              PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
              PictureDesc.picType := PICTYPE_ICON;
              PictureDesc.hIcon := Icon.ReleaseHandle;
              OleCreatePictureIndirect(PictureDesc, ActiveX.IPictureDisp, False, Result);
            finally
              tmp.Free;
            end;
          finally
            Icon.Free;
          end;
        end else begin
          ImgIndex := IadxRibbonComponent(ICtrl.GetItems[Index]).GetImageIndex();
          ImgList := GetImageList(COMAddInModule, Ctrl.Id);
          if Assigned(ImgList) and (ImgIndex >= 0) and (ImgList.Count > 0) and (ImgIndex < ImgList.Count) then begin
            Icon := TIcon.Create;
            try
              ImgList.GetIcon(ImgIndex, Icon);
              PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
              PictureDesc.picType := PICTYPE_ICON;
              PictureDesc.hIcon := Icon.ReleaseHandle;
              OleCreatePictureIndirect(PictureDesc, ActiveX.IPictureDisp, False, Result);
            finally
              Icon.Free;
            end;
          end;
        end;
      end;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetScreenTip_Callback(const Ctrl: IRibbonControl): WideString;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetScreenTip();
      ICtrl.DoChangeProperty(rcptScreenTip, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetSuperTip_Callback(const Ctrl: IRibbonControl): WideString;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetSuperTip();
      ICtrl.DoChangeProperty(rcptSuperTip, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetShowLabel_Callback(const Ctrl: IRibbonControl): WordBool;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := True;
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetShowCaption;
      ICtrl.DoChangeProperty(rcptShowCaption, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetShowImage_Callback(const Ctrl: IRibbonControl): WordBool;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := False;
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := (not ICtrl.GetGlyph().Empty) or (ICtrl.GetImageIndex() >= 0) or (ICtrl.GetImageMso() <> '');
      ICtrl.DoChangeProperty(rcptShowImage, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetSize_Callback(const Ctrl: IRibbonControl): Integer;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := Integer(csRegular);
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetSize();
      ICtrl.DoChangeProperty(rcptSize, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VInteger;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetDescription_Callback(const Ctrl: IRibbonControl): WideString;
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetDescription;
      ICtrl.DoChangeProperty(rcptDescription, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetText_Callback(const Ctrl: IRibbonControl): OleVariant;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetText;
      ICtrl.DoChangeProperty(rcptText, defaultValue, Ctrl.Context, -1);
      //Result := TVarData(defaultValue).VOleStr;
      Result := defaultValue;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemCount_Callback(const Ctrl: IRibbonControl): Integer;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := 0;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetItems.Count;
      ICtrl.DoChangeProperty(rcptItemCount, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VInteger;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemID_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := IadxRibbonComponent(ICtrl.GetItems[Index]).GetID;
      ICtrl.DoChangeProperty(rcptItemID, defaultValue, Ctrl.Context, Index);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemLabel_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := IadxRibbonComponent(ICtrl.GetItems[Index]).GetCaption();
      ICtrl.DoChangeProperty(rcptItemCaption, defaultValue, Ctrl.Context, Index);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemScreenTip_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := IadxRibbonComponent(ICtrl.GetItems[Index]).GetScreenTip();
      ICtrl.DoChangeProperty(rcptItemScreenTip, defaultValue, Ctrl.Context, Index);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemSuperTip_Callback(const Ctrl: IRibbonControl; Index: Integer): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := IadxRibbonComponent(ICtrl.GetItems[Index]).GetSuperTip();
      ICtrl.DoChangeProperty(rcptItemSuperTip, defaultValue, Ctrl.Context, Index);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetShowItemImage_Callback(const Ctrl: IRibbonControl; Index: Integer): WordBool;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := True;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := (not IadxRibbonComponent(ICtrl.GetItems[Index]).GetGlyph().Empty) or
        (IadxRibbonComponent(ICtrl.GetItems[Index]).GetImageIndex() >= 0) or
        (IadxRibbonComponent(ICtrl.GetItems[Index]).GetImageMso() <> '');
      ICtrl.DoChangeProperty(rcptShowItemImage, defaultValue, Ctrl.Context, Index);

      Result := TVarData(defaultValue).VBoolean;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetSelectedItemIndex_Callback(const Ctrl: IRibbonControl): Integer;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := 0;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetSelectedItemIndex();
      ICtrl.DoChangeProperty(rcptSelectedItemIndex, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VInteger;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetSelectedItemId_Callback(const Ctrl: IRibbonControl): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetSelectedItemID();
      ICtrl.DoChangeProperty(rcptSelectedItemID, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetItemHeight_Callback(const Ctrl: IRibbonControl): Integer;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := -1;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetItemHeight();
      ICtrl.DoChangeProperty(rcptItemHeight, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VInteger;
    finally
      ICtrl := nil;
    end;
  if Result = -1 then
    Result := 0;
end;

function TadxAddin.GetItemWidth_Callback(const Ctrl: IRibbonControl): Integer;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := -1;
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetItemWidth();
      ICtrl.DoChangeProperty(rcptItemWidth, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VInteger;
    finally
      ICtrl := nil;
    end;
  if Result = -1 then
    Result := 0;
end;

function TadxAddin.GetContent_Callback(const Ctrl: IRibbonControl): WideString;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetContent();
      ICtrl.DoChangeProperty(rcptContent, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetTitle_Callback(const Ctrl: IRibbonControl): WideString; safecall;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetTitle();
      ICtrl.DoChangeProperty(rcptTitle, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

// Events

procedure TadxAddin.OnActionCommon_Callback(const Ctrl: IRibbonControl);
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
begin
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      ICtrl.DoAction(Args);
    finally
      ICtrl := nil;
    end;
end;

procedure TadxAddin.OnActionCommonRepurposed_Callback(const Ctrl: IRibbonControl; var Cancel: WordBool);
var
  i: Integer;
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
  isInspector: boolean;
  window: OleVariant;
begin
  ICtrl := nil;

  isInspector:= false;
  if (Ctrl <> nil) and (COMAddInModule.OutlookApp <> nil) then begin
    //Ctrl.QueryInterface(IOleWindow, window);
    //isInspector:= (IInspector <> nil);
    //IInspector:= nil;
    window:= Ctrl.Context;
    isInspector:= (window.Class = olInspector);
  end;

  if isInspector then
    CheckMsoControls(COMAddInModule, Ctrl.Id, Ctrl.Context, ICtrl)
  else begin
    for i := 0 to COMAddInModule.FCommands.Count - 1 do
    if (TadxRibbonCommand(COMAddInModule.FCommands[i]).IdMso = Ctrl.Id) then begin
      ICtrl := IadxRibbonComponent(TadxRibbonCommand(COMAddInModule.FCommands[i]));
      Break;
    end;
  end;

  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      Args.Cancel := False; 
      Args.Pressed := True;
      ICtrl.DoAction(Args);
      Cancel := Args.Cancel;
    finally
      ICtrl := nil;
    end;
end;

procedure TadxAddin.OnActionStateRepurposed_Callback(const Ctrl: IRibbonControl; Pressed: WordBool; var Cancel: WordBool);
var
  i: Integer;
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
begin
  ICtrl := nil;
  for i := 0 to COMAddInModule.FCommands.Count - 1 do
    if (TadxRibbonCommand(COMAddInModule.FCommands[i]).IdMso = Ctrl.Id) then begin
      ICtrl := IadxRibbonComponent(TadxRibbonCommand(COMAddInModule.FCommands[i]));
      Break;
    end;
  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      Args.Cancel := False;
      Args.Pressed := Pressed;
      ICtrl.DoAction(Args);
      Cancel := Args.Cancel;
    finally
      ICtrl := nil;
    end;
end;

procedure TadxAddin.OnActionState_Callback(const Ctrl: IRibbonControl; Pressed: WordBool);
var
  Index: Integer;
  id: WideString;
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
begin
  id := Ctrl.Id;
  {$IFDEF UNICODE}
  Index := Pos(WideString('wrapped'), id);
  {$ELSE}
  Index := Pos('wrapped', id);
  {$ENDIF}
  if Index > 0 then
    Delete(id, Index, Length('wrapped'));
  ICtrl := GetRibbonControl(COMAddInModule, id);
  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      Args.Pressed := Pressed;
      ICtrl.DoAction(Args);
    finally
      ICtrl := nil;
    end;
end;

procedure TadxAddin.OnActionSelected_Callback(const Ctrl: IRibbonControl; const SelectedID: WideString;
  SelectedIndex: Integer);
var
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
begin
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      Args.SelectedID := SelectedID;
      Args.SelectedIndex := SelectedIndex;
      ICtrl.DoAction(Args);
    finally
      ICtrl := nil;
    end;
end;

procedure TadxAddin.OnChange_Callback(const Ctrl: IRibbonControl; const Text: WideString);
var
  ICtrl: IadxRibbonComponent;
  Args: TadxRibbonActionArguments;
begin
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      Args.Control := Ctrl;
      Args.Text := Text;
      ICtrl.DoAction(Args);
    finally
      ICtrl := nil;
    end;
end;

// Office 2010
procedure TadxAddin.OnBackstageShow_Callback(const Context: IDispatch);

  procedure RaiseShow(ribbons: TadxRibbons);
  var
    i: Integer;
    backstage: TadxBackstageView;
  begin
    for i := 0 to Self.FAddInModule.FRibbonControls.Count - 1 do
      if Self.FAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
        backstage := TadxBackstageView(Self.FAddInModule.FRibbonControls.Objects[i]);
        if backstage.Enabled and (backstage.Ribbons * ribbons <> []) then
          backstage.DoShow(Context);
      end;
  end;

  procedure RaiseShow2010(ribbons: TadxRibbons2010);
  var
    i: Integer;
    backstage: TadxBackstageView;
  begin
    for i := 0 to Self.FAddInModule.FRibbonControls.Count - 1 do
      if Self.FAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
        backstage := TadxBackstageView(Self.FAddInModule.FRibbonControls.Objects[i]);
        if backstage.Enabled and (backstage.Ribbons2010 * ribbons <> []) then
          backstage.DoShow(Context);
      end;
  end;

var
  IExpl: Outlook2000._Explorer;
begin
  case Self.FAddInModule.HostType of
    ohaExcel: RaiseShow([msrExcelWorkbook]);
    ohaWord: RaiseShow([msrWordDocument]);
    ohaOutlook: begin
      Context.QueryInterface(IID__Explorer, IExpl);
      if Assigned(IExpl) then
        try
          RaiseShow([msrOutlookExplorer])
        finally
          IExpl := nil;
        end
      else
        RaiseShow([msrOutlookMailRead, msrOutlookMailCompose,
          msrOutlookMeetingRequestRead, msrOutlookMeetingRequestSend,
          msrOutlookAppointment, msrOutlookContact, msrOutlookJournal,
          msrOutlookTask, msrOutlookDistributionList, msrOutlookReport,
          msrOutlookResend, msrOutlookResponseRead, msrOutlookResponseCompose,
          msrOutlookResponseCounterPropose, msrOutlookRSS, msrOutlookPostRead,
          msrOutlookPostCompose, msrOutlookSharingRead, msrOutlookSharingCompose]);
        RaiseShow2010([msrOutlookSMSRead2010, msrOutlookSMSCompose2010,
          msrOutlookMMSRead2010, msrOutlookMMSCompose2010]);
      end;
    ohaPowerPoint: RaiseShow([msrPowerPointPresentation]);
    ohaAccess: RaiseShow([msrAccessDatabase]);
    ohaProject: RaiseShow2010([msrProjectProject2010]);
    ohaFrontPage: ;
    ohaMapPoint: ;
    ohaVisio: RaiseShow2010([msrVisioDrawing2010]);
    ohaPublisher: RaiseShow2010([msrPublisherPublication2010]);
    ohaInfoPath: begin
      RaiseShow2010([msrInfoPathDesigner2010]);
      RaiseShow2010([msrInforPathFiller2010]);
    end;
  end;
end;

procedure TadxAddin.OnBackstageHide_Callback(const Context: IDispatch);

  procedure RaiseHide(ribbons: TadxRibbons);
  var
    i: Integer;
    backstage: TadxBackstageView;
  begin
    for i := 0 to Self.FAddInModule.FRibbonControls.Count - 1 do
      if Self.FAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
        backstage := TadxBackstageView(Self.FAddInModule.FRibbonControls.Objects[i]);
        if backstage.Enabled and (backstage.Ribbons * ribbons <> []) then
          backstage.DoHide(Context);
      end;
  end;

  procedure RaiseHide2010(ribbons: TadxRibbons2010);
  var
    i: Integer;
    backstage: TadxBackstageView;
  begin
    for i := 0 to Self.FAddInModule.FRibbonControls.Count - 1 do
      if Self.FAddInModule.FRibbonControls.Objects[i] is TadxBackstageView then begin
        backstage := TadxBackstageView(Self.FAddInModule.FRibbonControls.Objects[i]);
        if backstage.Enabled and (backstage.Ribbons2010 * ribbons <> []) then
          backstage.DoHide(Context);
      end;
  end;

var
  IExpl: Outlook2000._Explorer;
begin
  case Self.FAddInModule.HostType of
    ohaExcel: RaiseHide([msrExcelWorkbook]);
    ohaWord: RaiseHide([msrWordDocument]);
    ohaOutlook: begin
      Context.QueryInterface(IID__Explorer, IExpl);
      if Assigned(IExpl) then
        try
          RaiseHide([msrOutlookExplorer])
        finally
          IExpl := nil;
        end
      else
        RaiseHide([msrOutlookMailRead, msrOutlookMailCompose,
          msrOutlookMeetingRequestRead, msrOutlookMeetingRequestSend,
          msrOutlookAppointment, msrOutlookContact, msrOutlookJournal,
          msrOutlookTask, msrOutlookDistributionList, msrOutlookReport,
          msrOutlookResend, msrOutlookResponseRead, msrOutlookResponseCompose,
          msrOutlookResponseCounterPropose, msrOutlookRSS, msrOutlookPostRead,
          msrOutlookPostCompose, msrOutlookSharingRead, msrOutlookSharingCompose]);
        RaiseHide2010([msrOutlookSMSRead2010, msrOutlookSMSCompose2010,
          msrOutlookMMSRead2010, msrOutlookMMSCompose2010]);
      end;
    ohaPowerPoint: RaiseHide([msrPowerPointPresentation]);
    ohaAccess: RaiseHide([msrAccessDatabase]);
    ohaProject: RaiseHide2010([msrProjectProject2010]);
    ohaFrontPage: ;
    ohaMapPoint: ;
    ohaVisio: RaiseHide2010([msrVisioDrawing2010]);
    ohaPublisher: RaiseHide2010([msrPublisherPublication2010]);
    ohaInfoPath: begin
      RaiseHide2010([msrInfoPathDesigner2010]);
      RaiseHide2010([msrInforPathFiller2010]);
    end;
  end;
end;

function TadxAddin.GetTarget_Callback(const Ctrl: IRibbonControl): WideString; safecall;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetTarget();
      ICtrl.DoChangeProperty(rcptTarget, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetAltText_Callback(const Ctrl: IRibbonControl): WideString; safecall;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetAltText();
      ICtrl.DoChangeProperty(rcptAltText, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetHelperText_Callback(const Ctrl: IRibbonControl): WideString; safecall;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetHelperText();
      ICtrl.DoChangeProperty(rcptHelperText, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

function TadxAddin.GetStyle_Callback(const Ctrl: IRibbonControl): WideString; safecall;
var
  ICtrl: IadxRibbonComponent;
  defaultValue: OleVariant;
begin
  Result := '';
  ICtrl := GetRibbonControl(COMAddInModule, Ctrl.Id);
  if Assigned(ICtrl) then
    try
      defaultValue := ICtrl.GetGroupStyle();
      ICtrl.DoChangeProperty(rcptGroupStyle, defaultValue, Ctrl.Context, -1);
      Result := TVarData(defaultValue).VOleStr;
    finally
      ICtrl := nil;
    end;
end;

///////////////////////
//  1.x compatibility
///////////////////////

{ TaxpFactory }

constructor TaxpFactory.Create(ComServer: TComServerObject; AutoClass: TAutoClass;
  const ClassID: TGUID; ASupportedApp: TaxpOfficeHostApp;
  const AAddInName, ADescription: string);
begin
  CreateEx(ComServer, AutoClass, ClassID, [ASupportedApp], AAddInName, ADescription);
end;

constructor TaxpFactory.CreateEx(ComServer: TComServerObject; AutoClass: TAutoClass;
  const ClassID: TGUID; ASupportedApps: TaxpHostAppSet;
  const AAddInName, ADescription: string;
  const ALoadBehavior: Integer = 3; const ADisplayAlerts: boolean = False;
  const XLAutomationAddIn: boolean = False);
begin
  inherited Create(ComServer, AutoClass, ClassID, TadxCOMAddInModule);
  FDeprecatedVersion := True;
  FAddInName := AAddInName;
  FDescription := ADescription;
  FSupportedApps := ASupportedApps;
  FLoadBehavior := ALoadBehavior;
  FDisplayAlerts := ADisplayAlerts;
  FXLAutomationAddIn := XLAutomationAddIn;
end;

function TaxpFactory.GetAddInName: string;
begin
  Result := FAddInName;
end;

function TaxpFactory.GetSupportedApps: TaxpHostAppSet;
begin
  Result := FSupportedApps;
end;

{ TaxpAddIn }

procedure TaxpAddIn.OnConnection(const Application_: IDispatch;
  ConnectMode: ext_ConnectMode; const AddInInst: IDispatch; var custom: PSafeArray);
begin
  FAddIn := TadxAddIn.CreateFromFactory(Factory, Controller);
  FAddIn.OnConnection(Application_, ConnectMode, AddInInst, custom);
  Factory.FOldAddIn := Self;
  FReg := TRegistry.Create;
  FReg.OpenKey(Factory.RegistryKey[HostType], False);
  if ConnectMode <> ext_cm_Startup then OnStartupComplete(custom);
end;

procedure TaxpAddIn.OnStartupComplete(var custom: PSafeArray);
begin
  FAddIn.OnStartupComplete(custom);
  FReg.OpenKey(Factory.RegistryKey[HostType], False);
  try
    AddIn_Initialize;
    FAddIn.FAddInModule.OnError := OnError;
  except
    on E: SysUtils.Exception do begin
      FAddIn.FAddInModule.OnError := OnError;
      FAddIn.FAddInModule.DoError(E);
    end;
  end;
end;

procedure TaxpAddIn.OnDisconnection(RemoveMode: ext_DisconnectMode; var custom: PSafeArray);
begin
  Factory.FOldAddIn := nil;
  FAddIn.OnDisconnection(RemoveMode, custom);
  FAddIn := nil;
  FReg.Free;
end;

procedure TaxpAddIn.OnBeginShutdown(var custom: PSafeArray);
begin
  try
    AddIn_Finalize;
  except
    on E: SysUtils.Exception do FAddIn.FAddInModule.DoError(E);
  end;
  FAddIn.OnBeginShutdown(custom);
end;

procedure TaxpAddIn.OnAddInsUpdate(var custom: PSafeArray);
begin
  FAddIn.OnAddInsUpdate(custom);
end;

function TaxpAddIn.GetHostApp: OleVariant;
begin
  Result := FAddIn.COMAddInModule.HostApp;
end;

function TaxpAddIn.GetHostType: TaxpOfficeHostApp;
begin
  Result := FAddIn.COMAddInModule.HostType;
end;

function TaxpAddIn.GetAddInInstance: COMAddIn;
begin
  Result := FAddIn.COMAddInModule.AddInInstance;
end;

function TaxpAddIn.GetCmdBars: IaxpCmdBars;
begin
  Result := FAddIn.COMAddInModule.FICmdBars as adxOffice.CommandBars;
end;

function TaxpAddIn.GetFactory: TaxpFactory;
begin
  Result := (inherited Factory) as TaxpFactory;
end;

function TaxpAddIn.GetStartMode: TaxpStartMode;
begin
  Result := FAddIn.COMAddInModule.StartMode;
end;

function TaxpAddIn.GetRegistryKey: string;
begin
  Result := Factory.RegistryKey[HostType];
end;

function TaxpAddIn.GetExcel: Excel2000.TExcelApplication;
begin
  Result := FAddIn.COMAddInModule.ExcelApp;
end;

function TaxpAddIn.GetWord: Word2000.TWordApplication;
begin
  Result := FAddIn.COMAddInModule.WordApp;
end;

function TaxpAddIn.GetOutlook: Outlook2000.TOutlookApplication;
begin
  Result := FAddIn.COMAddInModule.OutlookApp;
end;

function TaxpAddIn.GetPowerPoint: MSPPt2000.TPowerPointApplication;
begin
  Result := FAddIn.COMAddInModule.PowerPointApp;
end;

function TaxpAddIn.GetAccess: Access2000.TAccessApplication;
begin
  Result := FAddIn.COMAddInModule.AccessApp;
end;

function TaxpAddIn.GetProject: Project2000.TProjectApplication;
begin
  Result := FAddIn.COMAddInModule.ProjectApp;
end;

function TaxpAddIn.GetFrontPage: FrontPage2000.TFrontPageApplication;
begin
  Result := FAddIn.COMAddInModule.FrontPageApp;
end;

function TaxpAddIn.GetMapPoint: MapPoint2002.TMapPointApplication;
begin
  Result := FAddIn.COMAddInModule.MapPointApp;
end;

function TaxpAddIn.GetVisio: Visio2002.TVisioApplication;
begin
  Result := FAddIn.COMAddInModule.VisioApp;
end;

function TaxpAddIn.AddCmdBar(const Name: WideString; var NewControl: boolean;
  Position: MsoBarPosition = msoBarFloating;
  Temporary: boolean = false): IaxpCmdBar;
begin
  Result := AddCmdBar(CmdBars, Name, NewControl, Position, Temporary);
end;

function TaxpAddIn.AddCmdBar(AICmdBars: IaxpCmdBars; const Name: WideString;
  var NewControl: boolean; Position: MsoBarPosition = msoBarFloating;
  Temporary: boolean = false): IaxpCmdBar;
var
  Bar: TadxCustomCommandBar;
begin
  Bar := TadxCustomCommandBar.Create(FAddIn.COMAddInModule);
  Bar.SupportedApps := [Self.FAddIn.COMAddInModule.HostType];
  Bar.CommandBarName := Name;
  Bar.Position := TadxMsoBarPosition(Position);
  Bar.Temporary := Temporary;
  NewControl := not Assigned(FAddIn.COMAddInModule.FindCommandBar(Name));
  FAddIn.COMAddInModule.InternalAddCmdBar(Bar);
  Result := Bar.DefaultInterface as IaxpCmdBar;
end;

function TaxpAddIn.FindControl(const Tag: string; Type_: TaxpControlType): IaxpControl;
const
  TMsoControls: array [TaxpControlType] of TOleEnum = (msoControlButton,
    msoControlEdit, msoControlDropdown, msoControlComboBox, msoControlPopup);
begin
  Result := FAddIn.COMAddInModule.FindControl(TMsoControls[Type_], Tag) as IaxpControl;
end;

function TaxpAddIn.FindControl(AICmdBars: IaxpCmdBars; const Tag: string;
  Type_: TaxpControlType): IaxpControl;
const
  TMsoControls: array [TaxpControlType] of TOleEnum = (msoControlButton,
    msoControlEdit, msoControlDropdown, msoControlComboBox, msoControlPopup);
begin
  Result := nil;
  if Assigned(AICmdBars) then
    Result := AICmdBars.FindControl(TMsoControls[Type_], EmptyParam, Tag, EmptyParam);
end;

function TaxpAddIn.AddControl(const CmdBarName, Caption: WideString;
  const Tag: string; const Hint: WideString;
  Type_: TaxpControlType; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil;
  Temporary: boolean = false): IaxpControl;
begin
  Result := AddControl(CmdBars, CmdBarName, Caption, Tag, Hint,
    Type_, NewControl, Before, Popup, Temporary);
end;

function TaxpAddIn.AddControl(AICmdBars: IaxpCmdBars;
  const CmdBarName, Caption: WideString; const Tag: string;
  const Hint: WideString; Type_: TaxpControlType; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil;
  Temporary: boolean = false): IaxpControl;
const
  TMsoControls: array [TaxpControlType] of TOleEnum = (msoControlButton,
    msoControlEdit, msoControlDropdown, msoControlComboBox, msoControlPopup);
var
  i: Integer;
  CmdBar: TadxCustomCommandBar;
  Control: TadxCommandBarControl;
  ParentCollection: TadxCommandBarControls;

  function FindParentCollection(Collection: TadxCommandBarControls;
    ATag: string): TadxCommandBarControls;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to Collection.Count - 1 do
      if Collection[i].GetType = adxPopup then begin
        if Collection[i].OfficeTag = ATag then begin
          Result := TadxCommandBarPopup(Collection[i]).Controls;
          Break;
        end
        else begin
          Result := FindParentCollection(TadxCommandBarPopup(Collection[i]).Controls, ATag);
          if Assigned(Result) then Break;
        end;
      end;
  end;

begin
  if HostType = ohaMapPoint then
    raise EADXException.Create(adxErrorDoesntSupport, adxECodeDoesntSupport, 0);
  if not Assigned(AICmdBars) then Exit;
  Result := AICmdBars.FindControl(TMsoControls[Type_], EmptyParam, Tag, EmptyParam);
  NewControl := not Assigned(Result);
  CmdBar := nil;
  for i := 0 to FAddIn.COMAddInModule.ComponentCount - 1 do
    if FAddIn.COMAddInModule.Components[i] is TadxCustomCommandBar then
      if TadxCustomCommandBar(FAddIn.COMAddInModule.Components[i]).CommandBarName = CmdBarName then
      begin
        CmdBar := TadxCustomCommandBar(FAddIn.COMAddInModule.Components[i]);
        Break;
      end;
  if not Assigned(CmdBar) then
    raise EADXException.Create(Format(adxErrorUnknownCommandBar, [Caption, CmdBarName]),
      adxECodeUnknownCommandBar, 0);
  if Assigned(Popup) then
    ParentCollection := FindParentCollection(CmdBar.Controls, Popup.Tag)
  else
    ParentCollection := CmdBar.Controls;
  if NewControl then begin
    Control := ParentCollection.Add(TadxControlType(Type_), Tag, Before, Temporary);
    Control.Caption := Caption;
    Control.TooltipText := Hint;
    Result := Control.DefaultInterface as IaxpControl;
  end
  else
    ParentCollection.Add(TadxControlType(Type_), Tag, Before, Temporary);
end;

function TaxpAddIn.AddButton(const CmdBarName, Caption: WideString;
  const Tag: string; const Hint: WideString; const ImageIndex: string;
  const Style: MsoButtonStyle; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil;
  TransparentColor: TColor = clDefault;
  Temporary: boolean = false): IaxpButton;
begin
  Result := AddButton(CmdBars, CmdBarName, Caption, Tag, Hint, ImageIndex,
    Style, NewControl, Before, Popup, TransparentColor, Temporary);
end;

function TaxpAddIn.AddButton(AICmdBars: IaxpCmdBars;
  const CmdBarName, Caption: WideString; const Tag: string;
  const Hint: WideString; const ImageIndex: string; const Style: MsoButtonStyle;
  var NewControl: boolean; Before: integer = -1; Popup: IaxpPopup = nil;
  TransparentColor: TColor = clDefault; Temporary: boolean = false): IaxpButton;

  function FindButton(AControls: TadxCommandBarControls; const ATag: WideString): TadxCommandBarButton;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to AControls.Count - 1 do begin
      if AControls[i].FOfficeTag = ATag then begin
        Result := TadxCommandBarButton(AControls[i]);
        Break;
      end;
      if AControls[i].GetType = adxPopup then begin
        Result := FindButton(TadxCommandBarPopup(AControls[i]).Controls, ATag);
        if Assigned(Result) then Break;
      end;
    end;
  end;

var
  i: Integer;
  Bmp: TBitmap;
  IControl: IaxpControl;
  CmdBar: TadxCustomCommandBar;
  Button: TadxCommandBarButton;
begin
  Result := nil;
  IControl := AddControl(AICmdBars, CmdBarName, Caption, Tag, Hint, axpButton,
    NewControl, Before, Popup, Temporary);
  if IControl = nil then Exit;
  OleCheck(IControl.QueryInterface(IaxpButton, Result));
  if NewControl then begin
    Result.Set_Style(Style);
    if ImageIndex <> '' then begin
      CmdBar := nil;
      for i := 0 to FAddIn.COMAddInModule.ComponentCount - 1 do
        if FAddIn.COMAddInModule.Components[i] is TadxCustomCommandBar then
          if TadxCustomCommandBar(FAddIn.COMAddInModule.Components[i]).CommandBarName = CmdBarName then
          begin
            CmdBar := TadxCustomCommandBar(FAddIn.COMAddInModule.Components[i]);
            Break;
          end;
      if Assigned(CmdBar) then begin
        Button := FindButton(CmdBar.Controls, Tag);
        if Assigned(Button) then begin
          Bmp := TBitmap.Create;
          try
            Bmp.LoadFromResourceName(SysInit.HInstance, ImageIndex);
            Button.GlyphTransparentColor := TransparentColor;
            Button.Glyph := Bmp;
          finally
            Bmp.Free;
          end;
        end;
      end;
    end;
  end;
end;

function TaxpAddIn.AddEdit(const CmdBarName, Caption: WideString;
  const Tag: string; const Hint: WideString; Style: MsoComboStyle;
  var NewControl: boolean; Before: integer = -1; Popup: IaxpPopup = nil;
  Temporary: boolean = false): IaxpEdit;
begin
  Result := AddEdit(CmdBars, CmdBarName, Caption, Tag, Hint, Style,
    NewControl, Before, Popup, Temporary);
end;

function TaxpAddIn.AddEdit(AICmdBars: IaxpCmdBars;
  const CmdBarName, Caption: WideString; const Tag: string;
  const Hint: WideString; Style: MsoComboStyle; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil; Temporary: boolean = false): IaxpEdit;
var
  IControl: IaxpControl;
begin
  Result := nil;
  IControl := AddControl(AICmdBars, CmdBarName, Caption, Tag, Hint, axpEdit,
    NewControl, Before, Popup, Temporary);
  if IControl = nil then Exit;
  OleCheck(IControl.QueryInterface(IaxpComboBox, Result));
  if NewControl then Result.Set_Style(Style);
end;

function TaxpAddIn.AddComboBox(const CmdBarName, Caption: WideString;
  const Tag: string; const Hint: WideString;
  Style: MsoComboStyle; DropDown: boolean; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil;
  Temporary: boolean = false): IaxpComboBox;
begin
  Result := AddComboBox(CmdBars, CmdBarName, Caption, Tag, Hint, Style, DropDown,
    NewControl, Before, Popup, Temporary);
end;

function TaxpAddIn.AddComboBox(AICmdBars: IaxpCmdBars;
  const CmdBarName, Caption: WideString; const Tag: string;
  const Hint: WideString; Style: MsoComboStyle; DropDown: boolean;
  var NewControl: boolean; Before: integer = -1; Popup: IaxpPopup = nil;
  Temporary: boolean = false): IaxpComboBox;
var
  IControl: IaxpControl;
begin
  Result := nil;
  if DropDown then
    IControl := AddControl(AICmdBars, CmdBarName, Caption, Tag, Hint, axpDropDown,
      NewControl, Before, Popup, Temporary)
  else
    IControl := AddControl(AICmdBars, CmdBarName, Caption, Tag, Hint, axpComboBox,
      NewControl, Before, Popup, Temporary);
  if IControl = nil then Exit;
  OleCheck(IControl.QueryInterface(IaxpComboBox, Result));
  if NewControl then Result.Set_Style(Style);
end;

function TaxpAddIn.AddPopup(const CmdBarName, Caption: WideString;
  const Tag: string; const Hint: WideString; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil; Temporary: boolean = false): IaxpPopup;
begin
  Result := AddPopup(CmdBars, CmdBarName, Caption, Tag, Hint, NewControl,
    Before, Popup, Temporary);
end;

function TaxpAddIn.AddPopup(AICmdBars: IaxpCmdBars;
  const CmdBarName, Caption: WideString; const Tag: string;
  const Hint: WideString; var NewControl: boolean;
  Before: integer = -1; Popup: IaxpPopup = nil; Temporary: boolean = false): IaxpPopup;
var
  IControl: IaxpControl;
begin
  Result := nil;
  IControl := AddControl(AICmdBars, CmdBarName, Caption, Tag, Hint, axpPopup,
    NewControl, Before, Popup, Temporary);
  if IControl = nil then Exit;
  OleCheck(IControl.QueryInterface(IaxpPopup, Result));
end;

procedure TaxpAddIn.AddMapPointCommand(const DisplayName, MethodName: WideString);
begin
  if HostType = ohaMapPoint then
    MapPointApp.AddCommand(DisplayName, MethodName, Self)
  else raise EADXException.Create(adxErrorMapPointOnly, adxECodeMapPointOnly, 0);
end;

procedure TaxpAddIn.AddIn_Initialize;
begin
end;

procedure TaxpAddIn.AddIn_Finalize;
begin
end;

procedure TaxpAddIn.AddIn_ControlEvent(const Tag: string; ICtrl: IaxpControl);
begin
end;

{ TadxOLBarShortcut }

type
  TAccessCollection = class(TOwnedCollection);

constructor TadxOLBarShortcut.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if (csDesigning in TadxOLBarShortcutManager(TAccessCollection(TadxOLBarGroup(TAccessCollection(Collection).GetOwner).Collection).GetOwner).ComponentState) and (FName = '') then
    FName := 'New Shortcut ' + IntToStr(Collection.Count);
  FIntf := nil;
end;

destructor TadxOLBarShortcut.Destroy;
begin
  FIntf := nil;
  inherited Destroy;
end;

procedure TadxOLBarShortcut.Delete;
begin
  TadxOLBarShortcuts(Collection).Delete(Self.Index);
end;

procedure TadxOLBarShortcut.ConnectTo(Intf: OutlookBarShortcut);
begin
  FIntf := Intf;
end;

procedure TadxOLBarShortcut.SetProperties;
begin
  if Assigned(FIntf) then begin
    SetName(FName);
    SetIcon(FIconFileName);
  end;
end;

procedure TadxOLBarShortcut.SetIcon(const FileName: string);
begin
  FIconFileName := FileName;
  try
    if Assigned(FIntf) and (FileName <> '') then
      OleVariant(FIntf).SetIcon(FileName);
  except
  end;
end;

procedure TadxOLBarShortcut.SetName(const Value: string);
begin
  FName := Value;
  if Assigned(FIntf) then FIntf.Name := Value;
end;

{ TadxOLBarShortcuts }

constructor TadxOLBarShortcuts.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FIntf := nil;
end;

destructor TadxOLBarShortcuts.Destroy;
begin
  FIntf := nil;
  inherited Destroy;
end;

function ScanNestedFolders(IFolders: _Folders; TargetFolder: string): MAPIFolder;
var
  i: Integer;
begin
  Result := nil;
  for i := 1 to IFolders.Count do begin
    if LowerCase(IFolders.Item(i).Name) = LowerCase(TargetFolder) then begin
      Result := IFolders.Item(i);
      Break;
    end;
    if Pos(LowerCase(IFolders.Item(i).Name), LowerCase(TargetFolder)) = 1 then begin
      if IFolders.Item(i).Folders.Count > 0 then begin
        System.Delete(TargetFolder, 1, Length(IFolders.Item(i).Name) + 1);
        Result := ScanNestedFolders(IFolders.Item(i).Folders, TargetFolder);
        if Assigned(Result) then Break;
      end;
    end;
  end;
end;
    
procedure TadxOLBarShortcuts.ConnectTo(Intf: OutlookBarShortcuts);
var
  i, j: Integer;
  IShortcut: OutlookBarShortcut;
  IDestFolder: MAPIFolder;
  Module: TadxCOMAddInModule;
  IFolders: _Folders;
  TargetFolder: string;
begin
  FIntf := Intf;
  if Assigned(FIntf) then begin
    for i := 0 to Count - 1 do begin
      IShortcut := nil;
      try
        IShortcut := FIntf.Item(Items[i].FName);
      except
      end;
      if IShortcut = nil then
        try
          Module := TadxOLBarShortcutManager(TadxOLBarGroups(TadxOLBarGroup(GetOwner).Collection).GetOwner).FOwner;
          IFolders := IDispatch(Module.FIApp.GetNamespace('MAPI').Folders) as _Folders;
          TargetFolder := Items[i].FTarget;
          for j := 1 to IFolders.Count do begin
            if LowerCase(IFolders.Item(j).Name) = LowerCase(TargetFolder) then begin
              IDestFolder := IFolders.Item(j);
              Break;
            end;
            if Pos(LowerCase(IFolders.Item(j).Name), LowerCase(TargetFolder)) = 1 then begin
              if IFolders.Item(j).Folders.Count > 0 then begin
                System.Delete(TargetFolder, 1, Length(IFolders.Item(j).Name) + 1);
                IDestFolder := ScanNestedFolders(IFolders.Item(j).Folders, TargetFolder);
              end;
            end;
          end;
          if Assigned(IDestFolder) then
            try
              IShortcut := FIntf.Add(IDestFolder, Items[i].FName, EmptyParam);
            finally
              IDestFolder := nil;
            end
          else
            IShortcut := FIntf.Add(Items[i].FTarget, Items[i].FName, EmptyParam);
        except
        end;
      Items[i].ConnectTo(IShortcut);
      Items[i].SetProperties;
    end;
  end;
end;

function TadxOLBarShortcuts.Add: TadxOLBarShortcut;
begin
  Result := TadxOLBarShortcut.Create(Self);
end;

function TadxOLBarShortcuts.Add(const Target: OleVariant;
  const Name, IconFileName: string): TadxOLBarShortcut;
begin
  Result := TadxOLBarShortcut.Create(Self);
  try
    if TVarData(Target).VType = varDispatch then
      Result.FTarget := GetFullFolderName(IDispatch(Target) as MAPIFolder)
    else
      Result.FTarget := Target;
    Result.FName := Name;
    Result.FIconFileName := IconFileName;
    if Assigned(FIntf) then begin
      Result.ConnectTo(FIntf.Add(Target, Name, EmptyParam));
      Result.SetProperties;
    end;
  except
    on E: SysUtils.Exception do
      TadxOLBarShortcutManager(TadxOLBarGroups(TadxOLBarGroup(GetOwner).Collection).GetOwner).FOwner.DoError(E);
  end;
end;

procedure TadxOLBarShortcuts.Delete(Index: Integer);
var
  i: Integer;
begin
  try
    if Assigned(FIntf) then begin
      for i := 1 to FIntf.Count do
        if FIntf.Item(i).Name = Items[Index].FName then begin
          FIntf.Remove(i);
          Break;
        end;
    end;
  except
  end;
  inherited Delete(Index);
end;

function TadxOLBarShortcuts.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxOLBarShortcuts.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Name';
    1: Result := 'Target';
    2: Result := 'IconFileName';
  else
    Result := '';
  end;
end;

function TadxOLBarShortcuts.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Items[ItemIndex].FName;
    1: Result := Items[ItemIndex].FTarget;
    2: Result := Items[ItemIndex].FIconFileName;
  else
    Result := '';
  end;
end;

function TadxOLBarShortcuts.GetItem(Index: Integer): TadxOLBarShortcut;
begin
  Result := TadxOLBarShortcut(inherited Items[Index]);
end;

procedure TadxOLBarShortcuts.SetItem(Index: Integer; Value: TadxOLBarShortcut);
begin
  inherited Items[Index] := Value;
end;

{ TadxOLBarGroup }

constructor TadxOLBarGroup.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if (csDesigning in TadxOLBarShortcutManager(TAccessCollection(Collection).GetOwner).ComponentState) and (FName = '') then
    FName := 'New Group ' + IntToStr(Collection.Count);
  FIntf := nil;
  FShortcuts := TadxOLBarShortcuts.Create(Self, TadxOLBarShortcut);
  FViewType := adxOLSmallIcon;
end;

destructor TadxOLBarGroup.Destroy;
begin
  FIntf := nil;
  FShortcuts.Free;
  inherited Destroy;
end;

procedure TadxOLBarGroup.Delete;
begin
  TadxOLBarGroups(Collection).Delete(Self.Index);
end;

procedure TadxOLBarGroup.ConnectTo(IGroup: OutlookBarGroup);
begin
  FIntf := IGroup;
  if Assigned(FIntf) then
    FShortcuts.ConnectTo(FIntf.Shortcuts);
end;

procedure TadxOLBarGroup.SetProperties;
begin
  if Assigned(FIntf) then begin
    SetName(FName);
    SetViewType(FViewType);
  end;
end;

function TadxOLBarGroup.GetName: string;
begin
  Result := FName;
  if Assigned(FIntf) then Result := FIntf.Name;
end;

procedure TadxOLBarGroup.SetName(const Value: string);
begin
  if FName <> Value then FName := Value;
  if Assigned(FIntf) then
    if FIntf.Name <> Value then FIntf.Name := Value;
end;

function TadxOLBarGroup.GetViewType: TadxOLBarViewType;
begin
  Result := FViewType;
  if Assigned(FIntf) then
    Result := TadxOLBarViewType(FIntf.ViewType);
end;

procedure TadxOLBarGroup.SetViewType(const Value: TadxOLBarViewType);
begin
  if FViewType <> Value then FViewType := Value;
  if Assigned(FIntf) then
    if FIntf.ViewType <> TOleEnum(Value) then
      FIntf.ViewType := TOleEnum(Value);
end;

{ TadxOLBarGroups }

constructor TadxOLBarGroups.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  FIntf := nil;
  inherited Create(AOwner, ItemClass);
end;

destructor TadxOLBarGroups.Destroy;
begin
  FIntf := nil;
  inherited Destroy;
end;

function TadxOLBarGroups.Add: TadxOLBarGroup;
begin
  Result := TadxOLBarGroup.Create(Self);
end;

function TadxOLBarGroups.Add(const Name: string): TadxOLBarGroup;
begin
  Result := TadxOLBarGroup.Create(Self);
  try
    Result.Name := Name;
    if Assigned(FIntf) then
      Result.ConnectTo(FIntf.Add(Name, EmptyParam));
  except
    on E: SysUtils.Exception do TadxOLBarShortcutManager(GetOwner).FOwner.DoError(E);
  end;
end;

procedure TadxOLBarGroups.Delete(Index: Integer);
var
  i, j: Integer;
begin
  try
    if Assigned(FIntf) then begin
      for i := 1 to FIntf.Count do
        if FIntf.Item(i).Name = Items[Index].FName then begin
          for j := Items[Index].FShortcuts.Count - 1 downto 0 do
            Items[Index].FShortcuts.Delete(j);
          FIntf.Remove(i);
          Break;
        end;
    end;
  except
    on E: SysUtils.Exception do TadxOLBarShortcutManager(GetOwner).FOwner.DoError(E);
  end;
  inherited Delete(Index);
end;

procedure TadxOLBarGroups.ConnectTo(Intf: OutlookBarGroups);
var
  i: Integer;
  IGroup: OutlookBarGroup;
begin
  FIntf := Intf;
  if Assigned(FIntf) then
    for i := 0 to Count - 1 do begin
      IGroup := nil;
      try
        IGroup := FIntf.Item(Items[i].FName);
      except
      end;
      if IGroup = nil then
        IGroup := FIntf.Add(Items[i].FName, EmptyParam);
      Items[i].ConnectTo(IGroup);
      Items[i].SetProperties;
    end;
end;

function TadxOLBarGroups.GetAttrCount: Integer;
begin
  Result := 2;
end;

function TadxOLBarGroups.GetAttr(Index: Integer): string;
begin
  if Index = 0 then Result := 'Name'
  else Result := 'ViewType';
end;

function TadxOLBarGroups.GetItemAttr(Index, ItemIndex: Integer): string;
const
  StringType: array [TadxOLBarViewType] of string = ('LargeIcon', 'SmallIcon');
begin
  if Index = 0 then
    Result := Items[ItemIndex].Name
  else
    Result := StringType[Items[ItemIndex].ViewType];
end;

function TadxOLBarGroups.GetItem(Index: Integer): TadxOLBarGroup;
begin
  Result := TadxOLBarGroup(inherited Items[Index]);
end;

procedure TadxOLBarGroups.SetItem(Index: Integer; Value: TadxOLBarGroup);
begin
  inherited Items[Index] := Value;
end;

{ TadxOLBarShortcutManager }

constructor TadxOLBarShortcutManager.Create(AOwner: TComponent);
begin
  FGroups := nil;
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := TadxCOMAddInModule(AOwner);
  FGroups := TadxOLBarGroups.Create(Self, TadxOLBarGroup);
end;

destructor TadxOLBarShortcutManager.Destroy;
begin
  if Assigned(FGroups) then FGroups.Free;
  inherited Destroy;
end;

procedure TadxOLBarShortcutManager.Install;
var
  i: Integer;
  IExpl: _Explorer;
  IPane: OutlookBarPane;
begin
  if FGroups.Count = 0 then Exit;
  IExpl := TadxCOMAddInModule(Self.Owner).OutlookApp.ActiveExplorer;
  if Assigned(IExpl) then
    try
      IPane := nil;
      for i := 1 to IExpl.Panes.Count do begin
        IExpl.Panes.Item(i).QueryInterface(IID__OutlookBarPane, IPane);
        if Assigned(IPane) then Break;
      end;
      if Assigned(IPane) then
        try
          FGroups.ConnectTo(IPane.Contents.Groups);
        finally
          IPane := nil;
        end;
    finally
      IExpl := nil;
    end;
end;

procedure TadxOLBarShortcutManager.Uninstall(const AExpl: _Explorer);
var
  i: Integer;
  IPane: OutlookBarPane;
begin
  if FGroups.Count = 0 then Exit;
  if Assigned(AExpl) then begin
    IPane := nil;
    for i := 1 to AExpl.Panes.Count do begin
      AExpl.Panes.Item(i).QueryInterface(IID__OutlookBarPane, IPane);
      if Assigned(IPane) then Break;
    end;
    if Assigned(IPane) then
      try
        FGroups.ConnectTo(IPane.Contents.Groups);
        for i := FGroups.Count - 1 downto 0 do
          FGroups.Delete(i);
      finally
        IPane := nil;
      end;
    end;
end;

{ TadxKeyboardShortcut }

constructor TadxKeyboardShortcut.Create(AOwner: TComponent);
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := TadxCOMAddInModule(AOwner);
  FEnabled := True;
  FSupportedApps := FOwner.SupportedApps;
  FOwner.HandleShortcuts := True;
end;

destructor TadxKeyboardShortcut.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxKeyboardShortcut.DoAction;
begin
  if Assigned(FOnAction) then
    try
      FOnAction(Self);
    except
      on E: SysUtils.Exception do FOwner.DoError(E);
    end;
end;

type
  TadxInternalCustomTaskPane = class(TOleServer)
  private
    FOwner: TadxCustomTaskPaneInstance;
    FIntf: _CustomTaskPane;
    function GetDefaultInterface: _CustomTaskPane;
    function Get_Title: WideString; safecall;
    function Get_Application: IDispatch; safecall;
    function Get_Window: IDispatch; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_ContentControl: IDispatch; safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(Value: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(Value: Integer); safecall;
    function Get_DockPosition: MsoCTPDockPosition; safecall;
    procedure Set_DockPosition(Value: MsoCTPDockPosition); safecall;
    function Get_DockPositionRestrict: MsoCTPDockPositionRestrict; safecall;
    procedure Set_DockPositionRestrict(Value: MsoCTPDockPositionRestrict); safecall;
    procedure DoVisibleStateChange(const Pane: _CustomTaskPane);
    procedure DockPositionStateChange(const Pane: _CustomTaskPane);
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function IsConnected: boolean;
  public
    constructor Create(AOwner: TPersistent); reintroduce;
    destructor Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _CustomTaskPane);
    procedure Disconnect; override;
    procedure Delete; safecall;
    property DefaultInterface: _CustomTaskPane read GetDefaultInterface;
    property Title: WideString read Get_Title;
    property Application: IDispatch read Get_Application;
    property Window: IDispatch read Get_Window;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property ContentControl: IDispatch read Get_ContentControl;
    property Height: SYSINT read Get_Height write Set_Height;
    property Width: SYSINT read Get_Width write Set_Width;
    property DockPosition: MsoCTPDockPosition read Get_DockPosition write Set_DockPosition;
    property DockPositionRestrict: MsoCTPDockPositionRestrict read Get_DockPositionRestrict write Set_DockPositionRestrict;
  end;

{ TadxInternalCustomTaskPane }

constructor TadxInternalCustomTaskPane.Create(AOwner: TPersistent);
begin
  inherited Create(nil);
  FOwner := TadxCustomTaskPaneInstance(AOwner);
end;

destructor TadxInternalCustomTaskPane.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxInternalCustomTaskPane.DoVisibleStateChange(const Pane: _CustomTaskPane);
begin
  if Assigned(FOwner) then
    FOwner.DoVisibleStateChange(Pane);
end;

procedure TadxInternalCustomTaskPane.DockPositionStateChange(const Pane: _CustomTaskPane);
begin
  if Assigned(FOwner) then
    FOwner.DoDockPositionStateChange(Pane);
end;

procedure TadxInternalCustomTaskPane.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then begin
    punk := GetServer;
    ConnectEvents(punk);
    FIntf := punk as _CustomTaskPane;
  end;
end;

procedure TadxInternalCustomTaskPane.ConnectTo(svrIntf: _CustomTaskPane);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TadxInternalCustomTaskPane.Disconnect;
begin
  if FIntf <> nil then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxInternalCustomTaskPane.GetDefaultInterface: _CustomTaskPane;
begin
  Result := FIntf;
end;

function TadxInternalCustomTaskPane.IsConnected: boolean;
begin
  Result := False;
  if Assigned(FIntf) then
    try
      FIntf.DockPositionRestrict := FIntf.DockPositionRestrict;
      Result := True;
    except
      FIntf := nil;
    end;
end;

procedure TadxInternalCustomTaskPane.Delete;
begin
  if IsConnected then
    DefaultInterface.Delete;
end;

function TadxInternalCustomTaskPane.Get_Title: WideString;
begin
  if IsConnected then
    Result := DefaultInterface.Title;
end;

function TadxInternalCustomTaskPane.Get_Application: IDispatch;
begin
  if IsConnected then
    Result := DefaultInterface.Application;
end;

function TadxInternalCustomTaskPane.Get_Window: IDispatch;
begin
  if IsConnected then
    Result := DefaultInterface.Window;
end;

function TadxInternalCustomTaskPane.Get_Visible: WordBool;
begin
  if IsConnected then
    Result := DefaultInterface.Visible;
end;

procedure TadxInternalCustomTaskPane.Set_Visible(Value: WordBool);
begin
  if IsConnected then
    DefaultInterface.Visible := Value;
end;

function TadxInternalCustomTaskPane.Get_ContentControl: IDispatch;
begin
  if IsConnected then
    Result := DefaultInterface.ContentControl;
end;

function TadxInternalCustomTaskPane.Get_Height: Integer;
begin
  if IsConnected then
    Result := DefaultInterface.Height;
end;

procedure TadxInternalCustomTaskPane.Set_Height(Value: Integer);
begin
  if IsConnected then
    DefaultInterface.Height := Value;
end;

function TadxInternalCustomTaskPane.Get_Width: Integer;
begin
  if IsConnected then
    Result := DefaultInterface.Width;
end;

procedure TadxInternalCustomTaskPane.Set_Width(Value: Integer);
begin
  if IsConnected then
    DefaultInterface.Width := Value;
end;

function TadxInternalCustomTaskPane.Get_DockPosition: MsoCTPDockPosition;
begin
  if IsConnected then
    Result := DefaultInterface.DockPosition;
end;

procedure TadxInternalCustomTaskPane.Set_DockPosition(Value: MsoCTPDockPosition);
begin
  if IsConnected then
    DefaultInterface.DockPosition := Value;
end;

function TadxInternalCustomTaskPane.Get_DockPositionRestrict: MsoCTPDockPositionRestrict;
begin
  if IsConnected then
    Result := DefaultInterface.DockPositionRestrict;
end;

procedure TadxInternalCustomTaskPane.Set_DockPositionRestrict(Value: MsoCTPDockPositionRestrict);
begin
  if IsConnected then
    DefaultInterface.DockPositionRestrict := Value;
end;

procedure TadxInternalCustomTaskPane.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{C5771BE5-A188-466B-AB31-00A6A32B1B1C}';
    IntfIID:   '{000C033B-0000-0000-C000-000000000046}';
    EventIID:  '{000C033C-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxInternalCustomTaskPane.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: DoVisibleStateChange(IUnknown(TVarData(Params[0]).VPointer) as _CustomTaskPane);
    2: DockPositionStateChange(IUnknown(TVarData(Params[0]).VPointer) as _CustomTaskPane);
  end; {case DispID}
end;

{ TadxCustomTaskPaneInstance }

constructor TadxCustomTaskPaneInstance.Create(Collection: TCollection);
var
  CTP: TadxCustomTaskPane;
begin
  inherited Create(Collection);
  FModule := TadxCustomTaskPaneInstances(Collection).FOwner.FModule;
  FInstance := TadxInternalCustomTaskPane.Create(Self);
  FWindow := nil;
  CTP := Getparent();
  FDockPosition := CTP.FDockPosition;
  FDockPositionRestrict := CTP.FDockPositionRestrict;
  FHeight := CTP.FHeight;
  FTitle := CTP.FTitle;
  FVisible := CTP.FVisible;
  FWidth := CTP.FWidth;
  FInternalVisible := True;
  FLocked := False;
end;

destructor TadxCustomTaskPaneInstance.Destroy;
begin
  if Assigned(FModule.FOnTaskPaneBeforeDestroy) then
    try
      FModule.FOnTaskPaneBeforeDestroy(GetParent(), Self);
    except
      on E: SysUtils.Exception do FModule.DoError(E);
    end;
  if Assigned(FInstance) then begin
    TadxInternalCustomTaskPane(FInstance).Delete();
    TadxInternalCustomTaskPane(FInstance).Free;
    FInstance := nil;
  end;
  FWindow := nil;
  FModule := nil;
  inherited Destroy;
end;

procedure TadxCustomTaskPaneInstance.DoVisibleStateChange(const Pane: _CustomTaskPane);
var
  CTP: TadxCustomTaskPane;
begin
  if not FLocked then
    FInternalVisible := Pane.Visible;
  CTP := GetParent();
  if Assigned(CTP.FOnVisibleChange) then
    try
      CTP.FOnVisibleChange(CTP, Self);
    except
      on E: SysUtils.Exception do FModule.DoError(E);
    end;
end;

procedure TadxCustomTaskPaneInstance.DoDockPositionStateChange(const Pane: _CustomTaskPane);
var
  CTP: TadxCustomTaskPane;
begin
  CTP := GetParent();
  if Assigned(CTP.FOnDockPositionChange) then
    try
      CTP.FOnDockPositionChange(CTP, Self);
    except
      on E: SysUtils.Exception do FModule.DoError(E);
    end;
end;

function TadxCustomTaskPaneInstance.GetControl: IDispatch;
begin
  Result := nil;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxInternalCustomTaskPane(FInstance).ContentControl;
end;

function TadxCustomTaskPaneInstance.GetDockPosition: TadxCTPDockPosition;
begin
  Result := FDockPosition;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxCTPDockPosition(TadxInternalCustomTaskPane(FInstance).DockPosition);
end;

procedure TadxCustomTaskPaneInstance.SetDockPosition(const Value: TadxCTPDockPosition);
begin
  FDockPosition := Value;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    TadxInternalCustomTaskPane(FInstance).DockPosition := Integer(Value);
end;

function TadxCustomTaskPaneInstance.GetDockPositionRestrict: TadxCTPDockPositionRestrict;
begin
  Result := FDockPositionRestrict;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxCTPDockPositionRestrict(TadxInternalCustomTaskPane(FInstance).DockPositionRestrict);
end;

procedure TadxCustomTaskPaneInstance.SetDockPositionRestrict(const Value: TadxCTPDockPositionRestrict);
begin
  FDockPositionRestrict := Value;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    TadxInternalCustomTaskPane(FInstance).DockPositionRestrict := Integer(Value);
end;

function TadxCustomTaskPaneInstance.GetHeight: Integer;
begin
  Result := FHeight;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxInternalCustomTaskPane(FInstance).Height;
end;

procedure TadxCustomTaskPaneInstance.SetHeight(const Value: Integer);
begin
  FHeight := Value;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then begin
    if TadxInternalCustomTaskPane(FInstance).DockPosition in
      [msoCTPDockPositionTop, msoCTPDockPositionBottom, msoCTPDockPositionFloating] then
      TadxInternalCustomTaskPane(FInstance).Height := Value;
  end;
end;

function TadxCustomTaskPaneInstance.GetParent: TadxCustomTaskPane;
begin
  Result := TadxCustomTaskPane(TAccessCollection(GetOwner).GetOwner);
end;

function TadxCustomTaskPaneInstance.GetTitle: WideString;
begin
  Result := FTitle;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxInternalCustomTaskPane(FInstance).Title;
end;

function TadxCustomTaskPaneInstance.GetVisible: boolean;
begin
  Result := FVisible;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxInternalCustomTaskPane(FInstance).Visible;
end;

procedure TadxCustomTaskPaneInstance.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    TadxInternalCustomTaskPane(FInstance).Visible := Value;
end;

function TadxCustomTaskPaneInstance.GetWidth: Integer;
begin
  Result := FWidth;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then
    Result := TadxInternalCustomTaskPane(FInstance).Width;
end;

procedure TadxCustomTaskPaneInstance.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then begin
    if TadxInternalCustomTaskPane(FInstance).DockPosition in
      [msoCTPDockPositionLeft, msoCTPDockPositionRight, msoCTPDockPositionFloating] then
      TadxInternalCustomTaskPane(FInstance).Width := Value;
  end;
end;

function TadxCustomTaskPaneInstance.GetWindow: IDispatch;
begin
  Result := nil;
  if TadxInternalCustomTaskPane(FInstance).IsConnected then begin
    if (Self.FModule.HostType = ohaWord) or
      ((Self.FModule.HostType = ohaPowerPoint) and (Self.FModule.FHostMajorVersion >= 14)) then
      Result := FWindow
    else
      Result := TadxInternalCustomTaskPane(FInstance).Window;
  end;
end;

{ TadxCustomTaskPaneInstances }

constructor TadxCustomTaskPaneInstances.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, TadxCustomTaskPaneInstance);
  FOwner := TadxCustomTaskPane(AOwner);
end;

destructor TadxCustomTaskPaneInstances.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

function TadxCustomTaskPaneInstances.Add: TObject;
begin
  Result := nil;
end;

function TadxCustomTaskPaneInstances.InternalAdd(Pane: _CustomTaskPane): TadxCustomTaskPaneInstance;
begin
  Result := TadxCustomTaskPaneInstance(inherited Add);
  TadxInternalCustomTaskPane(Result.FInstance).ConnectTo(Pane);
  if FOwner.FModule.HostType = ohaWord then
    Result.FWindow := Pane.Window;
  if (FOwner.FModule.HostType = ohaPowerPoint) and (FOwner.FModule.FHostMajorVersion >= 14) then
    Result.FWindow := Pane.Window;
end;

function TadxCustomTaskPaneInstances.GetItemByWindow(Index: IDispatch): TadxCustomTaskPaneInstance;
var
  i: Integer;
begin
  Result := nil;
  // Case #1617
  if FOwner.FModule.HostType in [ohaExcel, ohaAccess, ohaProject] then begin
    if Count > 0 then Result := ItemByIndex(0);
  end
  else
  if FOwner.FModule.HostType = ohaPowerPoint then begin
    // PowerPoint 2010
    if FOwner.FModule.FHostMajorVersion >= 14 then begin
      for i := 0 to Count - 1 do
        if ItemByIndex(i).Window = Index then begin
          Result := ItemByIndex(i);
          Break;
        end;
    end
    else
      if Count > 0 then Result := ItemByIndex(0);
  end
  else
    for i := 0 to Count - 1 do
      if ItemByIndex(i).Window = Index then begin
        Result := ItemByIndex(i);
        Break;
      end;
end;

function TadxCustomTaskPaneInstances.ItemByIndex(Index: Integer): TadxCustomTaskPaneInstance;
begin
  Result := TadxCustomTaskPaneInstance(inherited Items[Index]);
end;

{ TadxCustomTaskPane }

constructor TadxCustomTaskPane.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FModule := TadxCOMAddinModule(TAccessCollection(Collection).GetOwner);
  FInstances := TadxCustomTaskPaneInstances.Create(Self, TadxCustomTaskPaneInstance);
  FOutlookWindows := [olExplorers, olInspectors];
  FDockPosition := adxCTPDockPositionRight;
  FDockPositionRestrict := adxCTPDockPositionRestrictNone;
  FHeight := -1;
  FVisible := True;
  FWidth := -1;
  FSupportedApps := TadxCOMAddInModule(TAccessCollection(Collection).GetOwner).SupportedApps;
  FTitle := 'My Custom Pane ' + IntToStr(Collection.Count);
end;

destructor TadxCustomTaskPane.Destroy;
begin
  if Assigned(FInstances) then FreeAndNil(FInstances);
  FModule := nil;
  inherited Destroy;
end;

procedure TadxCustomTaskPane.FixInfoPathPanes();
var
  i, w: Integer;
  Found: boolean;
begin
  for i := Self.FInstances.Count - 1 downto 0 do begin
    Found := False;
    for w := 0 to Self.FModule.FInfoPath.Windows.Count - 1 do begin
      if Self.FModule.FInfoPath.Windows.Item[w] = Self.FInstances.ItemByIndex(i).Window then begin
        Found := True;
        Break;
      end;
    end;
    if not Found then
      Self.FInstances.Delete(i);
  end;
end;

procedure TadxCustomTaskPane.FixWordPanes();
var
  i, j: Integer;
  ind: OleVariant;
  Flag: boolean;
begin
  if FIsLocked then Exit;
  try
    FIsLocked := True;
    try
      for i := Self.FInstances.Count - 1 downto 0 do begin
        Flag := False;
        for j := 1 to Self.FModule.WordApp.Windows.Count do begin
          ind := j;
          if Self.FInstances.ItemByIndex(i).Window = Self.FModule.WordApp.Windows.Item(ind) then begin
            Flag := True;
            Break;
          end;
        end;
        if not Flag then
          Self.FInstances.Delete(i);
      end;

      Flag := FModule.HostApp.ShowWindowsInTaskbar;
      if Flag <> TadxCustomTaskPanes(Self.GetOwner).FShowWindowsInTaskbar then begin
        TadxCustomTaskPanes(Self.GetOwner).FShowWindowsInTaskbar := Flag;
        Flag := True;
      end
      else Flag := False;

      if TadxCustomTaskPanes(Self.GetOwner).FShowWindowsInTaskbar then begin
        if Flag then
        begin
          // just switched - remove
          for i := Self.FInstances.Count - 1 downto 0 do begin
            if TadxInternalCustomTaskPane(Self.FInstances.ItemByIndex(i).FInstance).Window <>
              Self.FInstances.ItemByIndex(i).Window then
              Self.FInstances.Delete(i);
          end;
          // turn on
          for i := 0 to Self.FInstances.Count - 1 do
            Self.FInstances.ItemByIndex(i).Visible := Self.Visible;
        end;
      end else begin
        for i := 0 to Self.FInstances.Count - 1 do begin
          FInstances.ItemByIndex(i).FLocked := True;
          try
            FInstances.ItemByIndex(i).Visible :=
              (FInstances.ItemByIndex(i).Window = FModule.WordApp.ActiveWindow) and
              (FInstances.ItemByIndex(i).FInternalVisible);
          finally
            FInstances.ItemByIndex(i).FLocked := False;
          end;
        end;
      end;
    except
      // skip: OLE Automation
    end;
  finally
    FIsLocked := False;
  end;
end;

function TadxCustomTaskPane.GetTitle: WideString;
begin
  Result := FTitle;
end;

function TadxCustomTaskPane.GetVisible: boolean;
begin
  Result := FVisible;
end;

procedure TadxCustomTaskPane.SetVisible(const Value: boolean);
var
  i: Integer;
begin
  FVisible := Value;
  for i := 0 to Instances.Count - 1 do
    Instances.ItemByIndex(i).Visible := Value;
end;

function TadxCustomTaskPane.GetHeight: Integer;
begin
  Result := FHeight;
end;

procedure TadxCustomTaskPane.SetHeight(const Value: Integer);
var
  i: Integer;
begin
  FHeight := Value;
  for i := 0 to Instances.Count - 1 do
    Instances.ItemByIndex(i).Height := Value;
end;

function TadxCustomTaskPane.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure TadxCustomTaskPane.SetWidth(const Value: Integer);
var
  i: Integer;
begin
  FWidth := Value;
  for i := 0 to Instances.Count - 1 do
    Instances.ItemByIndex(i).Width := Value;
end;

function TadxCustomTaskPane.GetDockPosition: TadxCTPDockPosition;
begin
  Result := FDockPosition;
end;

procedure TadxCustomTaskPane.SetDockPosition(const Value: TadxCTPDockPosition);
var
  i: Integer;
begin
  FDockPosition := Value;
  for i := 0 to Instances.Count - 1 do
    Instances.ItemByIndex(i).DockPosition := Value;
end;

function TadxCustomTaskPane.GetDockPositionRestrict: TadxCTPDockPositionRestrict;
begin
  Result := FDockPositionRestrict;
end;

procedure TadxCustomTaskPane.SetDockPositionRestrict(const Value: TadxCTPDockPositionRestrict);
var
  i: Integer;
begin
  FDockPositionRestrict := Value;
  for i := 0 to Instances.Count - 1 do
    Instances.ItemByIndex(i).DockPositionRestrict := Value;
end;

{ TadxCustomTaskPanes }

constructor TadxCustomTaskPanes.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
begin
  inherited Create(AOwner, TadxCustomTaskPane);
  FModule := TadxCOMAddInModule(AOwner);
  FShowWindowsInTaskbar := True;
end;

destructor TadxCustomTaskPanes.Destroy;
begin
  FModule := nil;
  inherited Destroy;
end;

function TadxCustomTaskPanes.Add: TadxCustomTaskPane;
begin
  Result := TadxCustomTaskPane(inherited Add);
end;

function TadxCustomTaskPanes.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TadxCustomTaskPanes.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := 'Type';
    1: Result := 'Title';
    2: Result := 'ControlProgID';
  end;
end;

function TadxCustomTaskPanes.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: Result := Format('%d - ', [ItemIndex]) + Items[ItemIndex].GetDisplayName;
    1: Result := Items[ItemIndex].Title;
    2: Result := Items[ItemIndex].ControlProgID;
  end;
end;

procedure TadxCustomTaskPanes.MakeCTP(const Window: IDispatch; HostType: Integer = 0);
var
  i: Integer;
  Cancel: Boolean;
  Pane: _CustomTaskPane;
  Inst: TadxCustomTaskPaneInstance;
begin
  if FModule.FCTPFactory = nil then Exit;
  try
    for i := 0 to Count - 1 do begin
      if (HostType = 1) and not (olExplorers in Items[i].FOutlookWindows) then Continue;
      if (HostType = 2) and not (olInspectors in Items[i].FOutlookWindows) then Continue;
      if (FModule.FHostType in Items[i].FSupportedApps) and
        (Items[i].FControlProgID <> '') and (Items[i].FTitle <> '') then
      begin
        if FModule.HostType = ohaInfoPath then
          Items[i].FixInfoPathPanes();
        if FModule.HostType = ohaWord then
          Items[i].FixWordPanes();

        if Items[i].Instances[Window] <> nil then Continue;
        if Assigned(FModule.FOnTaskPaneBeforeCreate) then
          try
            Cancel := False;
            FModule.FOnTaskPaneBeforeCreate(Items[i], Window, Cancel);
            if Cancel then Continue;
          except
            on E: SysUtils.Exception do FModule.DoError(E);
          end;
        try
          if Window = nil then
            Pane := FModule.FCTPFactory.CreateCTP(Items[i].FControlProgID, Items[i].FTitle, EmptyParam)
          else
            Pane := FModule.FCTPFactory.CreateCTP(Items[i].FControlProgID, Items[i].FTitle, Window);
          Pane.DockPosition := TOleEnum(Items[i].DockPosition);
          Pane.DockPositionRestrict := TOleEnum(Items[i].DockPositionRestrict);
          if Items[i].Height <> -1 then begin
            if Pane.DockPosition in [msoCTPDockPositionTop, msoCTPDockPositionBottom, msoCTPDockPositionFloating] then
              Pane.Height := Items[i].Height;
          end;
          if Items[i].Width <> -1 then begin
            if Pane.DockPosition in [msoCTPDockPositionLeft, msoCTPDockPositionRight, msoCTPDockPositionFloating] then
              Pane.Width := Items[i].Width;
          end;
        except
          on E: SysUtils.Exception do begin
              Pane := nil;
              FModule.DoError(E);
            end;
        end;
        if Pane = nil then Continue;
        Inst := Items[i].Instances.InternalAdd(Pane);
        if Assigned(FModule.FOnTaskPaneAfterCreate) then
          try
            FModule.FOnTaskPaneAfterCreate(Items[i], Inst);
          except
            on E: SysUtils.Exception do FModule.DoError(E);
          end;
        // Visible
        if Items[i].Visible then begin
          if Assigned(FModule.FOnTaskPaneBeforeShow) then
            try
              Cancel := False;
              FModule.FOnTaskPaneBeforeShow(Items[i], Inst, Cancel);
              if Cancel then begin
                if not Self.FShowWindowsInTaskbar then
                  Inst.FInternalVisible := False;
                Continue;
              end;
            except
              on E: SysUtils.Exception do FModule.DoError(E);
            end;
          Pane.Visible := Items[i].Visible;
          if not Self.FShowWindowsInTaskbar then
            Inst.FInternalVisible := Items[i].Visible;
          if Assigned(FModule.FOnTaskPaneAfterShow) then
            try
              FModule.FOnTaskPaneAfterShow(Items[i], Inst);
            except
              on E: SysUtils.Exception do FModule.DoError(E);
            end;
        end;
      end;
    end;
  finally
    Pane := nil;
  end;
end;

procedure TadxCustomTaskPanes.RemoveCTP(const Window: IDispatch);
var
  i: Integer;
begin
  if FModule.FCTPFactory = nil then Exit;
  for i := 0 to Count - 1 do begin
    if Items[i].Instances[Window] <> nil then
      Items[i].Instances.Delete(Items[i].Instances[Window].Index);
  end;
end;

function TadxCustomTaskPanes.GetItem(Index: Integer): TadxCustomTaskPane;
begin
  Result := TadxCustomTaskPane(inherited Items[Index]);
end;

procedure TadxCustomTaskPanes.SetItem(Index: Integer; Value: TadxCustomTaskPane);
begin
  inherited Items[Index] := Value;
end;

{$IFDEF ADX_VCL5}
function CreateGUID(out Guid: TGUID): HResult;
begin
  Result := CoCreateGuid(Guid);
end;
{$ENDIF}

{ TadxRibbonCommand }

constructor TadxRibbonCommand.Create(AOwner: TComponent);
var
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := AOwner as TadxCOMAddInModule;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
    Exclude(FRibbons2010, msrOutlookExplorer2010);
  end;
  FEnabled := True;
  if (csDesigning in ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonCommand' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  FOwner.FCommands.Add(Self);
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonCommand.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FCommands) then
      FOwner.FCommands.Remove(Self);
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxRibbonCommand.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxRibbonCommand.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonCommand.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonCommand.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonCommand.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonCommand.DoAction(var Args: TadxRibbonActionArguments);
begin
  if Assigned(FOnAction) then
    try
      FOnAction(Self, Args.Pressed, Args.Cancel);
    except
      on E: SysUtils.Exception do TadxCOMAddInModule(Owner).DoError(E);
    end;
end;

procedure TadxRibbonCommand.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
end;

function TadxRibbonCommand.GetXmlType: string;
begin
  Result := 'command'; 
end;

function TadxRibbonCommand.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
  if FIDMso = '' then Result.Values['idMso'] := FID
  else Result.Values['idMso'] := FIDMso;
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  case (ControlType) of
    Button:
      Result.Values['onAction'] := 'OnActionCommonRepurposed_Callback';
    ToggleButton,
    CheckBox:
      Result.Values['onAction'] := 'OnActionStateRepurposed_Callback';
  end;
end;

function TadxRibbonCommand.GetControls: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetType: TadxRibbonControlType;
begin
  Result := rctCommand;
end;

function TadxRibbonCommand.GetDescription: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetDescription(Value: WideString);
begin
end;

function TadxRibbonCommand.GetEnabled: boolean;
begin
  Result := FEnabled;
end;

procedure TadxRibbonCommand.SetEnabled(Value: boolean);
begin
  if FEnabled <> Value then begin
    FEnabled := Value;
    if Assigned(FOwner.RibbonUI) then FOwner.RibbonUI.Invalidate();
  end;
end;

function TadxRibbonCommand.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonCommand.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonCommand.GetIDMso: WideString;
begin
  Result := FIDMso;
end;

procedure TadxRibbonCommand.SetIDMso(Value: WideString);
var
  Index: Integer;
begin
  if FIDMso <> Value then begin
    FIDMso := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then begin
      if FIDMso <> '' then
        FOwner.FRibbonControls[Index] := FIDMso
      else
        FOwner.FRibbonControls[Index] := FID
    end;
  end;
end;

function TadxRibbonCommand.GetImageIndex: TImageIndex;
begin
  Result := -1;
end;

procedure TadxRibbonCommand.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxRibbonCommand.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetImageMso(Value: WideString);
begin
end;

function TadxRibbonCommand.GetInsertAfterIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetInsertAfterIdMso(Value: WideString);
begin
end;

function TadxRibbonCommand.GetInsertAfterId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetInsertAfterId(Value: WideString);
begin
end;

function TadxRibbonCommand.GetInsertBeforeIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetInsertBeforeIdMso(Value: WideString);
begin
end;

function TadxRibbonCommand.GetInsertBeforeId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetInsertBeforeId(Value: WideString);
begin
end;

function TadxRibbonCommand.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonCommand.SetItemHeight(Value: Integer);
begin
end;

function TadxRibbonCommand.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonCommand.SetItemWidth(Value: Integer);
begin
end;

function TadxRibbonCommand.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetKeyTip(Value: TadxRibbonKeyTip);
begin
end;

function TadxRibbonCommand.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetCaption(Value: WideString);
begin
end;

function TadxRibbonCommand.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxRibbonCommand.SetPressed(Value: boolean);
begin
end;

function TadxRibbonCommand.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetSelectedItemId(Value: WideString);
begin
end;

function TadxRibbonCommand.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonCommand.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxRibbonCommand.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetScreenTip(Value: WideString);
begin
end;

function TadxRibbonCommand.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxRibbonCommand.SetShowCaption(Value: boolean);
begin
end;

function TadxRibbonCommand.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxRibbonCommand.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxRibbonCommand.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetSuperTip(Value: WideString);
begin
end;

function TadxRibbonCommand.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonCommand.SetRibbons(Value: TadxRibbons);
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxRibbonCommand.GetText: WideString;
begin
  Result := '';
end;

procedure TadxRibbonCommand.SetText(Value: WideString);
begin
end;

function TadxRibbonCommand.GetTitle: WideString;
begin
  Result := '';
end;

function TadxRibbonCommand.GetVisible: boolean;
begin
  Result := True;
end;

procedure TadxRibbonCommand.SetVisible(Value: boolean);
begin
end;

function TadxRibbonCommand.GetContent: WideString;
begin
  Result := '';
end;

function TadxRibbonCommand.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxRibbonCommand.SetRibbons2010(Value: TadxRibbons2010);
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    if msrOutlookExplorer2010 in Value then
      FRibbons := FRibbons + [msrOutlookExplorer]
    else
      FRibbons := FRibbons - [msrOutlookExplorer];
  end;
end;

function TadxRibbonCommand.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCommand.GetTarget: WideString;
begin
  Result := '';
end;

function TadxRibbonCommand.GetAltText: WideString;
begin
  Result := '';
end;

function TadxRibbonCommand.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxRibbonCommand.GetGroupStyle: WideString;
begin
  Result := '';
end;

{ TadxRibbonTab }

constructor TadxRibbonTab.Create(AOwner: TComponent);
var
  i, Count: Integer;
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FOwner := AOwner as TadxCOMAddInModule;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
    Exclude(FRibbons2010, msrOutlookExplorer2010);
  end;
  FVisible := True;
  FControls := TadxRibbonControls.Create(Self, TadxRibbonGroup, 100);
  if (csDesigning in ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonTab' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to FOwner.FRibbonControls.Count - 1 do
      if FOwner.FRibbonControls.Objects[i] is TadxRibbonTab then Inc(Count);
    FCaption := 'adxRibbonTab' + IntToStr(Count);
  end;
  FOwner.FTabs.Add(Self);
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonTab.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FTabs) then FOwner.FTabs.Remove(Self);
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  if Assigned(FControls) then FreeAndNil(FControls);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxRibbonTab.Invalidate;
begin
  if Assigned(FOwner.RibbonUI) then
    if FIDMso <> '' then
      FOwner.RibbonUI.Invalidate
    else
      FOwner.RibbonUI.InvalidateControl(FID);
end;

procedure TadxRibbonTab.Activate;
begin
  if Assigned(FOwner.RibbonUI) then
    if FOwner.FHostMajorVersion >= 14 then
      try
        FOwner.FRibbonUI.ActivateTab(Self.FID);
      except
        on E: SysUtils.Exception do FOwner.DoError(E);
      end;
end;

procedure TadxRibbonTab.SetControls(Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonTab.UpdateItems;

  procedure CheckControls(const Ctrls: TadxRibbonControls);
  var
    i: Integer;
  begin
    if Ctrls <> nil then begin
      for i := 0 to Ctrls.Count - 1 do begin
        if Self.FImages = nil then
          Ctrls[i].FImageIndex := -1
        else begin
          if Ctrls[i].FImageIndex >= Self.FImages.Count then
            Ctrls[i].FImageIndex := -1;
        end;
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetControls());
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetItems());
      end;
    end;
  end;

begin
  CheckControls(Self.Controls);
end;

procedure TadxRibbonTab.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    FImages := Value;
end;

procedure TadxRibbonTab.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then begin
    Images := nil;
    UpdateItems();
  end;
end;

procedure TadxRibbonTab.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxRibbonTab.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonTab.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonTab.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonTab.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonTab.SetContext(Value: string);
begin
  if FContext <> Value then begin
    if FContext <> '' then FOwner.FContextTabs.Remove(Self)
    else FOwner.FTabs.Remove(Self);
    FContext := Value;
    if FContext <> '' then FOwner.FContextTabs.Add(Self)
    else FOwner.FTabs.Add(Self);
  end;
end;

procedure TadxRibbonTab.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxRibbonTab.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  if Assigned(FOnPropertyChanging) then
  try
    FOnPropertyChanging(Self, PropertyType, Value, Context);
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(Owner).DoError(E);
  end;
end;

function TadxRibbonTab.GetXmlType: string;
begin
  Result := 'tab';
end;

function TadxRibbonTab.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
  if FShared and (Self.FOwner.Namespace <> '') then begin
    Result.Values['idQ'] := adxSharedNS + ':' + FID;
    if Self.FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
    else
    if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
    else
    if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
    else
    if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
    Result.Values['keytip'] := string(Self.FKeyTip);
    Result.Values['label'] := string(Self.FCaption);
  end
  else begin
    Result.Values['getVisible'] := 'GetVisible_Callback';
    if FIdMso <> '' then
      Result.Values['idMso'] := FIdMso
    else begin
      if Self.FOwner.Namespace <> '' then
        Result.Values['idQ'] := adxDefaultNS + ':' + FID
      else
        Result.Values['id'] := FID;
      if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
      else
      if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
      else
      if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
      else
      if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
      Result.Values['getKeytip'] := 'GetKeyTip_Callback';
      Result.Values['getLabel'] := 'GetLabel_Callback';
    end;
  end;
end;

function TadxRibbonTab.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonTab.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetType: TadxRibbonControlType;
begin
  Result := rctTab;
end;

function TadxRibbonTab.GetDescription: WideString;
begin
end;

procedure TadxRibbonTab.SetDescription(Value: WideString);
begin
end;

function TadxRibbonTab.GetEnabled: boolean;
begin
  Result := True;
end;

procedure TadxRibbonTab.SetEnabled(Value: boolean);
begin
end;

function TadxRibbonTab.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonTab.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonTab.GetIDMso: WideString;
begin
  Result := FIDMso;
end;

procedure TadxRibbonTab.SetIDMso(Value: WideString);
var
  Index: Integer;
begin
  if FIDMso <> Value then begin
    FIDMso := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then begin
      if FIDMso <> '' then
        FOwner.FRibbonControls[Index] := FIDMso
      else
        FOwner.FRibbonControls[Index] := FID
    end;
  end;
end;

function TadxRibbonTab.GetImageIndex: TImageIndex;
begin
  Result := 0;
end;

procedure TadxRibbonTab.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxRibbonTab.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonTab.SetImageMso(Value: WideString);
begin
end;

function TadxRibbonTab.GetInsertAfterIdMso: WideString;
begin
  Result := FInsertAfterIdMso;
end;

procedure TadxRibbonTab.SetInsertAfterIdMso(Value: WideString);
begin
  FInsertAfterIdMso := Value;
end;

function TadxRibbonTab.GetInsertAfterId: WideString;
begin
  Result := FInsertAfterId;
end;

procedure TadxRibbonTab.SetInsertAfterId(Value: WideString);
begin
  FInsertAfterId := Value;
end;

function TadxRibbonTab.GetInsertBeforeIdMso: WideString;
begin
  Result := FInsertBeforeIdMso;
end;

procedure TadxRibbonTab.SetInsertBeforeIdMso(Value: WideString);
begin
  FInsertBeforeIdMso := Value;
end;

function TadxRibbonTab.GetInsertBeforeId: WideString;
begin
  Result := FInsertBeforeId;
end;

procedure TadxRibbonTab.SetInsertBeforeId(Value: WideString);
begin
  FInsertBeforeId := Value;
end;

function TadxRibbonTab.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonTab.SetItemHeight(Value: Integer);
begin
end;

function TadxRibbonTab.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonTab.SetItemWidth(Value: Integer);
begin
end;

function TadxRibbonTab.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := FKeyTip;
end;

procedure TadxRibbonTab.SetKeyTip(Value: TadxRibbonKeyTip);
begin
  if (FKeyTip <> Value) then begin
    FKeyTip := Value;
    Invalidate;
  end;
end;

function TadxRibbonTab.GetCaption: WideString;
begin
  Result := FCaption;
end;

procedure TadxRibbonTab.SetCaption(Value: WideString);
begin
  FCaption := Value;
end;

function TadxRibbonTab.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxRibbonTab.SetPressed(Value: boolean);
begin
end;

function TadxRibbonTab.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonTab.SetSelectedItemId(Value: WideString);
begin
end;

function TadxRibbonTab.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonTab.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxRibbonTab.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonTab.SetScreenTip(Value: WideString);
begin
end;

function TadxRibbonTab.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxRibbonTab.SetShowCaption(Value: boolean);
begin
end;

function TadxRibbonTab.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxRibbonTab.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxRibbonTab.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonTab.SetSuperTip(Value: WideString);
begin
end;

function TadxRibbonTab.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonTab.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons(Value);
    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxRibbonTab.GetText: WideString;
begin
  Result := '';
end;

procedure TadxRibbonTab.SetText(Value: WideString);
begin
end;

function TadxRibbonTab.GetVisible: boolean;
begin
  Result := FVisible;
end;

procedure TadxRibbonTab.SetVisible(Value: boolean);
begin
// GARANT { // ADX BUG #2109
  if FVisible <> Value then begin
    FVisible := Value;
    Invalidate;
  end;
// } GARANT // ADX BUG #2109
end;

function TadxRibbonTab.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxRibbonTab.GetTitle: WideString;
begin
  Result := '';
end;

function TadxRibbonTab.GetContent: WideString;
begin
  Result := '';
end;

function TadxRibbonTab.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxRibbonTab.SetRibbons2010(Value: TadxRibbons2010);
var
  i: Integer;
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons2010(Value);
    if msrOutlookExplorer2010 in Value then
      SetRibbons(FRibbons + [msrOutlookExplorer])
    else
      SetRibbons(FRibbons - [msrOutlookExplorer]);
  end;
end;

function TadxRibbonTab.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonTab.GetTarget: WideString;
begin
  Result := '';
end;

function TadxRibbonTab.GetAltText: WideString;
begin
  Result := '';
end;

function TadxRibbonTab.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxRibbonTab.GetGroupStyle: WideString;
begin
  Result := '';
end;

{ TadxRibbonQAT }

constructor TadxRibbonQAT.Create(AOwner: TComponent);
var
  i: Integer;
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  for i := 0 to TadxCOMAddInModule(AOwner).FRibbonControls.Count - 1 do
    if TadxCOMAddInModule(AOwner).FRibbonControls.Objects[i] is TadxRibbonQAT then
      raise EADXException.Create(Format(adxErrorOnlyOneInstance, [ClassName, 'module']), adxECodeOnlyOneInstance, 0);
  inherited Create(AOwner);
  FOwner := AOwner as TadxCOMAddInModule;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
    Exclude(FRibbons2010, msrOutlookExplorer2010);
  end;
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  if (csDesigning in ComponentState) and (Id = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonQAT' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonQAT.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxRibbonQAT.SetControls(Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonQAT.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonQAT.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonQAT.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonQAT.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonQAT.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxRibbonQAT.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonQAT.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonQAT.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonQAT.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonQAT.UpdateItems;

  procedure CheckControls(const Ctrls: TadxRibbonControls);
  var
    i: Integer;
  begin
    if Ctrls <> nil then begin
      for i := 0 to Ctrls.Count - 1 do begin
        if Self.FImages = nil then
          Ctrls[i].FImageIndex := -1
        else begin
          if Ctrls[i].FImageIndex >= Self.FImages.Count then
            Ctrls[i].FImageIndex := -1;
        end;
      end;
    end;
  end;

begin
  CheckControls(Self.Controls);
end;

procedure TadxRibbonQAT.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    FImages := Value;
end;

procedure TadxRibbonQAT.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then begin
    Images := nil;
    UpdateItems();
  end;
end;

procedure TadxRibbonQAT.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxRibbonQAT.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  if Assigned(FOnPropertyChanging) then
  try
    FOnPropertyChanging(Self, PropertyType, Value, Context);
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(Owner).DoError(E);
  end;
end;

function TadxRibbonQAT.GetXmlType: string;
begin
  Result := 'qat';
end;

function TadxRibbonQAT.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
end;

function TadxRibbonQAT.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonQAT.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetType: TadxRibbonControlType;
begin
  Result := rctQAT; 
end;

function TadxRibbonQAT.GetDescription: WideString;
begin
end;

procedure TadxRibbonQAT.SetDescription(Value: WideString);
begin
end;

function TadxRibbonQAT.GetEnabled: boolean;
begin
  Result := True;
end;

procedure TadxRibbonQAT.SetEnabled(Value: boolean);
begin
end;

function TadxRibbonQAT.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonQAT.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonQAT.GetIDMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetIDMso(Value: WideString);
begin
end;

function TadxRibbonQAT.GetImageIndex: TImageIndex;
begin
  Result := -1;
end;

procedure TadxRibbonQAT.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxRibbonQAT.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetImageMso(Value: WideString);
begin
end;

function TadxRibbonQAT.GetInsertAfterIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetInsertAfterIdMso(Value: WideString);
begin
end;

function TadxRibbonQAT.GetInsertAfterId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetInsertAfterId(Value: WideString);
begin
end;

function TadxRibbonQAT.GetInsertBeforeIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetInsertBeforeIdMso(Value: WideString);
begin
end;

function TadxRibbonQAT.GetInsertBeforeId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetInsertBeforeId(Value: WideString);
begin
end;

function TadxRibbonQAT.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonQAT.SetItemHeight(Value: Integer);
begin
end;

function TadxRibbonQAT.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonQAT.SetItemWidth(Value: Integer);
begin
end;

function TadxRibbonQAT.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetCaption(Value: WideString);
begin
end;

function TadxRibbonQAT.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxRibbonQAT.SetPressed(Value: boolean);
begin
end;

function TadxRibbonQAT.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetSelectedItemId(Value: WideString);
begin
end;

function TadxRibbonQAT.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonQAT.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxRibbonQAT.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetScreenTip(Value: WideString);
begin
end;

function TadxRibbonQAT.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxRibbonQAT.SetShowCaption(Value: boolean);
begin
end;

function TadxRibbonQAT.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxRibbonQAT.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxRibbonQAT.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetSuperTip(Value: WideString);
begin
end;

function TadxRibbonQAT.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonQAT.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons(Value);
    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxRibbonQAT.GetText: WideString;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetText(Value: WideString);
begin
end;

function TadxRibbonQAT.GetVisible: boolean;
begin
  Result := True;
end;

procedure TadxRibbonQAT.SetVisible(Value: boolean);
begin
end;

function TadxRibbonQAT.GetContent: WideString;
begin
  Result := '';
end;

function TadxRibbonQAT.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := '';
end;

procedure TadxRibbonQAT.SetKeyTip(Value: TadxRibbonKeyTip);
begin
end;

function TadxRibbonQAT.GetTitle: WideString;
begin
  Result := '';
end;

function TadxRibbonQAT.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxRibbonQAT.SetRibbons2010(Value: TadxRibbons2010);
var
  i: Integer;
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons2010(Value);
    if msrOutlookExplorer2010 in Value then
      SetRibbons(FRibbons + [msrOutlookExplorer])
    else
      SetRibbons(FRibbons - [msrOutlookExplorer]);
  end;
end;

function TadxRibbonQAT.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonQAT.GetTarget: WideString;
begin
  Result := '';
end;

function TadxRibbonQAT.GetAltText: WideString;
begin
  Result := '';
end;

function TadxRibbonQAT.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxRibbonQAT.GetGroupStyle: WideString;
begin
  Result := '';
end;

{ TadxRibbonOfficeMenu }

constructor TadxRibbonOfficeMenu.Create(AOwner: TComponent);
var
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FEnabled := True;
  FOwner := AOwner as TadxCOMAddInModule;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
  end;
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  if (csDesigning in ComponentState) and (Id = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonOfficeMenu' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonOfficeMenu.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxRibbonOfficeMenu.SetControls(Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonOfficeMenu.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonOfficeMenu.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonOfficeMenu.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonOfficeMenu.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonOfficeMenu.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
end;

procedure TadxRibbonOfficeMenu.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonOfficeMenu.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonOfficeMenu.UpdateItems;

  procedure CheckControls(const Ctrls: TadxRibbonControls);
  var
    i: Integer;
  begin
    if Ctrls <> nil then begin
      for i := 0 to Ctrls.Count - 1 do begin
        if Self.FImages = nil then
          Ctrls[i].FImageIndex := -1
        else begin
          if Ctrls[i].FImageIndex >= Self.FImages.Count then
            Ctrls[i].FImageIndex := -1;
        end;
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetControls());
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetItems());
      end;
    end;
  end;

begin
  CheckControls(Self.Controls);
end;

procedure TadxRibbonOfficeMenu.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    FImages := Value;
end;

procedure TadxRibbonOfficeMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then begin
    Images := nil;
    UpdateItems();
  end;
end;

procedure TadxRibbonOfficeMenu.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxRibbonOfficeMenu.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  if Assigned(FOnPropertyChanging) then
  try
    FOnPropertyChanging(Self, PropertyType, Value, Context);
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(Owner).DoError(E);
  end;
end;

function TadxRibbonOfficeMenu.GetXmlType: string;
begin
  Result := 'officeMenu';
end;

function TadxRibbonOfficeMenu.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
end;

function TadxRibbonOfficeMenu.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonOfficeMenu.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetType: TadxRibbonControlType;
begin
  Result := rctOfficeMenu;
end;

function TadxRibbonOfficeMenu.GetDescription: WideString;
begin
end;

procedure TadxRibbonOfficeMenu.SetDescription(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetEnabled: boolean;
begin
  Result := True;
end;

procedure TadxRibbonOfficeMenu.SetEnabled(Value: boolean);
begin
end;

function TadxRibbonOfficeMenu.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonOfficeMenu.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonOfficeMenu.GetIDMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetIDMso(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetImageIndex: TImageIndex;
begin
  Result := -1;
end;

procedure TadxRibbonOfficeMenu.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxRibbonOfficeMenu.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetImageMso(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetInsertAfterIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetInsertAfterIdMso(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetInsertAfterId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetInsertAfterId(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetInsertBeforeIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetInsertBeforeIdMso(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetInsertBeforeId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetInsertBeforeId(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonOfficeMenu.SetItemHeight(Value: Integer);
begin
end;

function TadxRibbonOfficeMenu.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonOfficeMenu.SetItemWidth(Value: Integer);
begin
end;

function TadxRibbonOfficeMenu.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetCaption(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxRibbonOfficeMenu.SetPressed(Value: boolean);
begin
end;

function TadxRibbonOfficeMenu.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetSelectedItemId(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonOfficeMenu.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxRibbonOfficeMenu.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetScreenTip(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxRibbonOfficeMenu.SetShowCaption(Value: boolean);
begin
end;

function TadxRibbonOfficeMenu.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxRibbonOfficeMenu.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxRibbonOfficeMenu.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetSuperTip(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonOfficeMenu.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons(Value);
  end;
end;

function TadxRibbonOfficeMenu.GetText: WideString;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetText(Value: WideString);
begin
end;

function TadxRibbonOfficeMenu.GetVisible: boolean;
begin
  Result := True;
end;

procedure TadxRibbonOfficeMenu.SetVisible(Value: boolean);
begin
end;

function TadxRibbonOfficeMenu.GetContent: WideString;
begin
  Result := '';
end;

function TadxRibbonOfficeMenu.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := '';
end;

procedure TadxRibbonOfficeMenu.SetKeyTip(Value: TadxRibbonKeyTip);
begin
end;

function TadxRibbonOfficeMenu.GetTitle: WideString;
begin
  Result := '';
end;

function TadxRibbonOfficeMenu.GetRibbons2010: TadxRibbons2010;
begin
  // Office 2010 does not have Office Menu
  Result := [];
end;

procedure TadxRibbonOfficeMenu.SetRibbons2010(Value: TadxRibbons2010);
begin
end;

function TadxRibbonOfficeMenu.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonOfficeMenu.GetTarget: WideString;
begin
  Result := '';
end;

function TadxRibbonOfficeMenu.GetAltText: WideString;
begin
  Result := '';
end;

function TadxRibbonOfficeMenu.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxRibbonOfficeMenu.GetGroupStyle: WideString;
begin
  Result := '';
end;

{ TadxRibbonCustomControl }

constructor TadxRibbonCustomControl.Create(Collection: TCollection);
var
  AOwner: TPersistent;
begin
  inherited Create(Collection);
  FGlyph := TBitmap.Create();
  FGlyph.OnChange := GlyphChanged;
  FEnabled := True;
  FImageIndex := -1;
  FSize := csRegular;
  FShowCaption := True;
  FVisible := True;
  FItemHeight := -1;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  FItemWidth := -1;
  FSelectedItemIndex := -1;
  AOwner := TAccessCollection(Collection).GetOwner;
  if AOwner is TadxRibbonTab then begin
    FRibbons := IadxRibbonComponent(TadxRibbonTab(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxRibbonTab(AOwner)).GetRibbons2010;
  end else
  if AOwner is TadxRibbonCustomControl then begin
    FRibbons := IadxRibbonComponent(TadxRibbonCustomControl(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxRibbonCustomControl(AOwner)).GetRibbons2010;
  end else
  if AOwner is TadxRibbonOfficeMenu then begin
    FRibbons := IadxRibbonComponent(TadxRibbonOfficeMenu(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxRibbonOfficeMenu(AOwner)).GetRibbons2010;
  end else
  if AOwner is TadxRibbonQAT then begin
    FRibbons := IadxRibbonComponent(TadxRibbonQAT(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxRibbonQAT(AOwner)).GetRibbons2010;
  end else
  if AOwner is TadxRibbonContextMenu then begin
    FRibbons := IadxRibbonComponent(TadxRibbonContextMenu(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxRibbonContextMenu(AOwner)).GetRibbons2010;
  end else
  if AOwner is TadxBackstageView then begin
    FRibbons := IadxRibbonComponent(TadxBackstageView(AOwner)).GetRibbons;
    FRibbons2010 := IadxRibbonComponent(TadxBackstageView(AOwner)).GetRibbons2010;
  end;
end;

destructor TadxRibbonCustomControl.Destroy;
var
  Index: Integer;
  ARoot: TComponent;
begin
  ARoot := GetRoot;
  if Assigned(ARoot) and Assigned(ARoot.Owner) then begin
    if Assigned(TadxCOMAddInModule(ARoot.Owner).FRibbonControls) then begin
      Index := TadxCOMAddInModule(ARoot.Owner).FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Delete(Index);
    end;
  end;
  if Assigned(FGlyph) then FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TadxRibbonCustomControl.Invalidate;
begin
  if Assigned(TadxCOMAddInModule(GetRoot.Owner).RibbonUI) then
    if FIDMso <> '' then
      TadxCOMAddInModule(GetRoot.Owner).RibbonUI.Invalidate
    else begin
      TadxCOMAddInModule(GetRoot.Owner).RibbonUI.InvalidateControl(FID);
      if Self is TadxRibbonSplitButton then
        TadxCOMAddInModule(GetRoot.Owner).RibbonUI.InvalidateControl(FID + 'wrapped');
    end;
end;

function TadxRibbonCustomControl.GetDisplayName: string;
begin
  Result := '(' + ClassName + ')';
  if FCaption <> '' then Result := FCaption + ' ' + Result;
end;

function TadxRibbonCustomControl.AsRibbonSeparator: TadxRibbonSeparator;
begin
  Result := nil;
  if Self is TadxRibbonSeparator then Result := TadxRibbonSeparator(Self);
end;

function TadxRibbonCustomControl.AsRibbonMenuSeparator: TadxRibbonMenuSeparator;
begin
  Result := nil;
  if Self is TadxRibbonMenuSeparator then Result := TadxRibbonMenuSeparator(Self);
end;

function TadxRibbonCustomControl.AsRibbonDialogBoxLauncher: TadxRibbonDialogBoxLauncher;
begin
  Result := nil;
  if Self is TadxRibbonDialogBoxLauncher then Result := TadxRibbonDialogBoxLauncher(Self);
end;

function TadxRibbonCustomControl.AsRibbonItem: TadxRibbonItem;
begin
  Result := nil;
  if Self is TadxRibbonItem then Result := TadxRibbonItem(Self);
end;

function TadxRibbonCustomControl.AsRibbonGroup: TadxRibbonGroup;
begin
  Result := nil;
  if Self is TadxRibbonGroup then Result := TadxRibbonGroup(Self);
end;

function TadxRibbonCustomControl.AsRibbonLabel: TadxRibbonLabel;
begin
  Result := nil;
  if Self is TadxRibbonLabel then Result := TadxRibbonLabel(Self);
end;

function TadxRibbonCustomControl.AsRibbonButton: TadxRibbonButton;
begin
  Result := nil;
  if Self is TadxRibbonButton then Result := TadxRibbonButton(Self);
end;

function TadxRibbonCustomControl.AsRibbonCheckBox: TadxRibbonCheckBox;
begin
  Result := nil;
  if Self is TadxRibbonCheckBox then Result := TadxRibbonCheckBox(Self);
end;

function TadxRibbonCustomControl.AsRibbonEditBox: TadxRibbonEditBox;
begin
  Result := nil;
  if Self is TadxRibbonEditBox then Result := TadxRibbonEditBox(Self);
end;

function TadxRibbonCustomControl.AsRibbonComboBox: TadxRibbonComboBox;
begin
  Result := nil;
  if Self is TadxRibbonComboBox then Result := TadxRibbonComboBox(Self);
end;

function TadxRibbonCustomControl.AsRibbonDropDown: TadxRibbonDropDown;
begin
  Result := nil;
  if Self is TadxRibbonDropDown then Result := TadxRibbonDropDown(Self);
end;

function TadxRibbonCustomControl.AsRibbonGallery: TadxRibbonGallery;
begin
  Result := nil;
  if Self is TadxRibbonGallery then Result := TadxRibbonGallery(Self);
end;

function TadxRibbonCustomControl.AsRibbonMenu: TadxRibbonMenu;
begin
  Result := nil;
  if Self is TadxRibbonMenu then Result := TadxRibbonMenu(Self);
end;

function TadxRibbonCustomControl.AsRibbonSplitButton: TadxRibbonSplitButton;
begin
  Result := nil;
  if Self is TadxRibbonSplitButton then Result := TadxRibbonSplitButton(Self);
end;

function TadxRibbonCustomControl.AsRibbonBox: TadxRibbonBox;
begin
  Result := nil;
  if Self is TadxRibbonBox then Result := TadxRibbonBox(Self);
end;

function TadxRibbonCustomControl.AsRibbonButtonGroup: TadxRibbonButtonGroup;
begin
  Result := nil;
  if Self is TadxRibbonButtonGroup then Result := TadxRibbonButtonGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageTab: TadxBackstageTab;
begin
  Result := nil;
  if Self is TadxBackstageTab then Result := TadxBackstageTab(Self);
end;

function TadxRibbonCustomControl.AsBackstageFastCommandButton: TadxBackstageFastCommandButton;
begin
  Result := nil;
  if Self is TadxBackstageFastCommandButton then Result := TadxBackstageFastCommandButton(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskFormGroup: TadxBackstageTaskFormGroup;
begin
  Result := nil;
  if Self is TadxBackstageTaskFormGroup then Result := TadxBackstageTaskFormGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskFormGroupCategory: TadxBackstageTaskFormGroupCategory;
begin
  Result := nil;
  if Self is TadxBackstageTaskFormGroupCategory then Result := TadxBackstageTaskFormGroupCategory(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskFormGroupTask: TadxBackstageTaskFormGroupTask;
begin
  Result := nil;
  if Self is TadxBackstageTaskFormGroupTask then Result := TadxBackstageTaskFormGroupTask(Self);
end;

function TadxRibbonCustomControl.AsBackstageGroup: TadxBackstageGroup;
begin
  Result := nil;
  if Self is TadxBackstageGroup then Result := TadxBackstageGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskGroup: TadxBackstageTaskGroup;
begin
  Result := nil;
  if Self is TadxBackstageTaskGroup then Result := TadxBackstageTaskGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskGroupCategory: TadxBackstageTaskGroupCategory;
begin
  Result := nil;
  if Self is TadxBackstageTaskGroupCategory then Result := TadxBackstageTaskGroupCategory(Self);
end;

function TadxRibbonCustomControl.AsBackstageTaskGroupTask: TadxBackstageTaskGroupTask;
begin
  Result := nil;
  if Self is TadxBackstageTaskGroupTask then Result := TadxBackstageTaskGroupTask(Self);
end;

function TadxRibbonCustomControl.AsBackstagePrimaryMenu: TadxBackstagePrimaryMenu;
begin
  Result := nil;
  if Self is TadxBackstagePrimaryMenu then Result := TadxBackstagePrimaryMenu(Self);
end;

function TadxRibbonCustomControl.AsBackstageSubMenu: TadxBackstageSubMenu;
begin
  Result := nil;
  if Self is TadxBackstageSubMenu then Result := TadxBackstageSubMenu(Self);
end;

function TadxRibbonCustomControl.AsBackstageMenuGroup: TadxBackstageMenuGroup;
begin
  Result := nil;
  if Self is TadxBackstageMenuGroup then Result := TadxBackstageMenuGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageMenuButton: TadxBackstageMenuButton;
begin
  Result := nil;
  if Self is TadxBackstageMenuButton then Result := TadxBackstageMenuButton(Self);
end;

function TadxRibbonCustomControl.AsBackstageMenuCheckBox: TadxBackstageMenuCheckBox;
begin
  Result := nil;
  if Self is TadxBackstageMenuCheckBox then Result := TadxBackstageMenuCheckBox(Self);
end;

function TadxRibbonCustomControl.AsBackstageMenuToggleButton: TadxBackstageMenuToggleButton;
begin
  Result := nil;
  if Self is TadxBackstageMenuToggleButton then Result := TadxBackstageMenuToggleButton(Self);
end;

function TadxRibbonCustomControl.AsBackstageRegularButton: TadxBackstageRegularButton;
begin
  Result := nil;
  if Self is TadxBackstageRegularButton then Result := TadxBackstageRegularButton(Self);
end;

function TadxRibbonCustomControl.AsBackstageCheckBox: TadxBackstageCheckBox;
begin
  Result := nil;
  if Self is TadxBackstageCheckBox then Result := TadxBackstageCheckBox(Self);
end;

function TadxRibbonCustomControl.AsBackstageGroupButton: TadxBackstageGroupButton;
begin
  Result := nil;
  if Self is TadxBackstageGroupButton then Result := TadxBackstageGroupButton(Self);
end;

function TadxRibbonCustomControl.AsBackstageEditBox: TadxBackstageEditBox;
begin
  Result := nil;
  if Self is TadxBackstageEditBox then Result := TadxBackstageEditBox(Self);
end;

function TadxRibbonCustomControl.AsBackstageComboBox: TadxBackstageComboBox;
begin
  Result := nil;
  if Self is TadxBackstageComboBox then Result := TadxBackstageComboBox(Self);
end;

function TadxRibbonCustomControl.AsBackstageDropDown: TadxBackstageDropDown;
begin
  Result := nil;
  if Self is TadxBackstageDropDown then Result := TadxBackstageDropDown(Self);
end;

function TadxRibbonCustomControl.AsBackstageRadioGroup: TadxBackstageRadioGroup;
begin
  Result := nil;
  if Self is TadxBackstageRadioGroup then Result := TadxBackstageRadioGroup(Self);
end;

function TadxRibbonCustomControl.AsBackstageHyperlink: TadxBackstageHyperlink;
begin
  Result := nil;
  if Self is TadxBackstageHyperlink then Result := TadxBackstageHyperlink(Self);
end;

function TadxRibbonCustomControl.AsBackstageLabelControl: TadxBackstageLabelControl;
begin
  Result := nil;
  if Self is TadxBackstageLabelControl then Result := TadxBackstageLabelControl(Self);
end;

function TadxRibbonCustomControl.AsBackstageImageControl: TadxBackstageImageControl;
begin
  Result := nil;
  if Self is TadxBackstageImageControl then Result := TadxBackstageImageControl(Self);
end;

function TadxRibbonCustomControl.AsBackstageGroupBox: TadxBackstageGroupBox;
begin
  Result := nil;
  if Self is TadxBackstageGroupBox then Result := TadxBackstageGroupBox(Self);
end;

function TadxRibbonCustomControl.AsBackstageLayoutContainer: TadxBackstageLayoutContainer;
begin
  Result := nil;
  if Self is TadxBackstageLayoutContainer then Result := TadxBackstageLayoutContainer(Self);
end;

function TadxRibbonCustomControl.AsBackstageItem: TadxBackstageItem;
begin
  Result := nil;
  if Self is TadxBackstageItem then Result := TadxBackstageItem(Self);
end;

procedure TadxRibbonCustomControl.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TadxRibbonCustomControl.WriteCaption(Writer: TWriter);
begin
  Writer.WriteString(FCaption);
end;

procedure TadxRibbonCustomControl.ReadCaption(Reader: TReader);
begin
  FCaption := Reader.ReadString;
end;

procedure TadxRibbonCustomControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Caption', ReadCaption, WriteCaption, True);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxRibbonCustomControl.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonCustomControl.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonCustomControl.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonCustomControl.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

function TadxRibbonCustomControl._AddRef: Integer;
begin
  Result := -1;
end;

function TadxRibbonCustomControl._Release: Integer;
begin
  Result := -1;
end;

function TadxRibbonCustomControl.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

procedure TadxRibbonCustomControl.Assign(Source: TPersistent);
begin
  if Source is TadxRibbonCustomControl then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      Caption := TadxRibbonCustomControl(Source).Caption;
      Description := TadxRibbonCustomControl(Source).Description;
      Enabled := TadxRibbonCustomControl(Source).Enabled;
      ImageIndex := TadxRibbonCustomControl(Source).ImageIndex;
      ImageMso := TadxRibbonCustomControl(Source).ImageMso;
      InsertAfterIdMso := TadxRibbonCustomControl(Source).InsertAfterIdMso;
      InsertAfterId := TadxRibbonCustomControl(Source).InsertAfterId;
      InsertBeforeIdMso := TadxRibbonCustomControl(Source).InsertBeforeIdMso;
      InsertBeforeId := TadxRibbonCustomControl(Source).InsertBeforeId;
      ItemHeight := TadxRibbonCustomControl(Source).ItemHeight;
      ItemWidth := TadxRibbonCustomControl(Source).ItemWidth;
      Pressed := TadxRibbonCustomControl(Source).Pressed;
      SelectedItemId := TadxRibbonCustomControl(Source).SelectedItemId;
      SelectedItemIndex := TadxRibbonCustomControl(Source).SelectedItemIndex;
      ShowCaption := TadxRibbonCustomControl(Source).ShowCaption;
      Size := TadxRibbonCustomControl(Source).Size;
      SuperTip := TadxRibbonCustomControl(Source).SuperTip;
      Ribbons := TadxRibbonCustomControl(Source).Ribbons;
      Text := TadxRibbonCustomControl(Source).Text;
      Visible := TadxRibbonCustomControl(Source).Visible;
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxRibbonCustomControl.GetRoot: TComponent;
var
  AOwner: TPersistent;
begin
  Result := nil;
  if Assigned(Collection) then begin
    AOwner := TAccessCollection(Collection).GetOwner;
    while (AOwner <> nil) and
      not (AOwner is TadxRibbonTab) and
      not (AOwner is TadxRibbonOfficeMenu) and
      not (AOwner is TadxRibbonQAT) and
      not (AOwner is TadxRibbonContextMenu) and
      not (AOwner is TadxBackstageView) do
      AOwner := TAccessCollection(TadxRibbonCustomControl(AOwner).Collection).GetOwner;
    Result := TComponent(AOwner);
  end;
end;

function TadxRibbonCustomControl.GetParentIDMso: WideString;
var
  AOwner: TPersistent;
begin
  Result := '';
  AOwner := TAccessCollection(Collection).GetOwner;
  if (AOwner is TadxRibbonOfficeMenu) or (AOwner is TadxRibbonQAT) then Exit;
  if AOwner is TadxRibbonTab then
    Result := TadxRibbonTab(AOwner).IdMso
  else
    Result := TadxRibbonCustomControl(AOwner).IdMso;
end;

function TadxRibbonCustomControl.GetType: TadxRibbonControlType;
begin
  Result := rctSeparator;
end;

procedure TadxRibbonCustomControl.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxRibbonCustomControl.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  if Assigned(FOnPropertyChanging) then
  try
    FOnPropertyChanging(Self, PropertyType, Value, Context);
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxRibbonCustomControl.GetXmlType: string;
begin
  Result := '';
end;

function TadxRibbonCustomControl.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
end;

function TadxRibbonCustomControl.GetControls: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetDescription: WideString;
begin
  Result := FDescription;
end;

procedure TadxRibbonCustomControl.SetDescription(Value: WideString);
begin
  if FDescription <> Value then begin
    FDescription := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetEnabled: boolean;
begin
  Result := FEnabled;
end;

procedure TadxRibbonCustomControl.SetEnabled(Value: boolean);
begin
  if FEnabled <> Value then begin
    FEnabled := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonCustomControl.SetID(Value: WideString);
var
  Index: Integer;
  ARoot: TComponent;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    ARoot := GetRoot;
    Index := TadxCOMAddInModule(ARoot.Owner).FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then TadxCOMAddInModule(ARoot.Owner).FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonCustomControl.GetIDMso: WideString;
begin
  Result := FIDMso;
end;

procedure TadxRibbonCustomControl.SetIDMso(Value: WideString);
var
  Index: Integer;
  Module: TadxCOMAddInModule;
begin
  if FIDMso <> Value then begin
    FIDMso := Value;
    Module := TadxCOMAddInModule(GetRoot.Owner);
    Index := Module.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then begin
      if FIDMso <> '' then
        Module.FRibbonControls[Index] := FIDMso
      else
        Module.FRibbonControls[Index] := FID
    end;
  end;
end;

function TadxRibbonCustomControl.GetImageIndex: TImageIndex;
begin
  Result := FImageIndex;
end;

procedure TadxRibbonCustomControl.SetImageIndex(Value: TImageIndex);
begin
  if FImageIndex <> Value then begin
    FImageIndex := Value;
    Invalidate;
    if Self is TadxRibbonItem then begin
      if TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown then
        TadxRibbonDropDown(TAccessCollection(Self.Collection).GetOwner).Invalidate;
    end;
  end;
end;

function TadxRibbonCustomControl.GetImageMso: WideString;
begin
  Result := FImageMso;
end;

procedure TadxRibbonCustomControl.SetImageMso(Value: WideString);
begin
  if FImageMso <> Value then begin
    FImageMso := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetInsertAfterIdMso: WideString;
begin
  Result := FInsertAfterIdMso;
end;

procedure TadxRibbonCustomControl.SetInsertAfterIdMso(Value: WideString);
begin
  if FInsertAfterIdMso <> Value then begin
    FInsertAfterIdMso := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetInsertAfterId: WideString;
begin
  Result := FInsertAfterId;
end;

procedure TadxRibbonCustomControl.SetInsertAfterId(Value: WideString);
begin
  if FInsertAfterId <> Value then begin
    FInsertAfterId := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetInsertBeforeIdMso: WideString;
begin
  Result := FInsertBeforeIdMso;
end;

procedure TadxRibbonCustomControl.SetInsertBeforeIdMso(Value: WideString);
begin
  if FInsertBeforeIdMso <> Value then begin
    FInsertBeforeIdMso := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetInsertBeforeId: WideString;
begin
  Result := FInsertBeforeId;
end;

procedure TadxRibbonCustomControl.SetInsertBeforeId(Value: WideString);
begin
  if FInsertBeforeId <> Value then begin
    FInsertBeforeId := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetItemHeight: Integer;
begin
  Result := FItemHeight;
end;

procedure TadxRibbonCustomControl.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value then begin
    FItemHeight := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetItemWidth: Integer;
begin
  Result := FItemWidth;
end;

procedure TadxRibbonCustomControl.SetItemWidth(Value: Integer);
begin
  if FItemWidth <> Value then begin
    FItemWidth := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetCaption: WideString;
begin
  Result := FCaption;
end;

procedure TadxRibbonCustomControl.SetCaption(Value: WideString);
begin
  if FCaption <> Value then begin
    FCaption := Value;
    Invalidate;
    if Self is TadxRibbonItem then begin
      if TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown then
        TadxRibbonDropDown(TAccessCollection(Self.Collection).GetOwner).Invalidate;
    end;
  end;
end;

function TadxRibbonCustomControl.GetPressed: boolean;
begin
  Result := FPressed;
end;

procedure TadxRibbonCustomControl.SetPressed(Value: boolean);
begin
  if FPressed <> Value then begin
    FPressed := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetSelectedItemId: WideString;
begin
  Result := FSelectedItemId;
end;

procedure TadxRibbonCustomControl.SetSelectedItemId(Value: WideString);
begin
  if FSelectedItemId <> Value then begin
    FSelectedItemId := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetSelectedItemIndex: Integer;
begin
  Result := FSelectedItemIndex;
end;

procedure TadxRibbonCustomControl.SetSelectedItemIndex(Value: Integer);
begin
  if FSelectedItemIndex <> Value then begin
    FSelectedItemIndex := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetScreenTip: WideString;
begin
  Result := FScreenTip;
end;

procedure TadxRibbonCustomControl.SetScreenTip(Value: WideString);
begin
  if FScreenTip <> Value then begin
    FScreenTip := Value;
    Invalidate;
    if Self is TadxRibbonItem then begin
      if TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown then
        TadxRibbonDropDown(TAccessCollection(Self.Collection).GetOwner).Invalidate;
    end;
  end;
end;

function TadxRibbonCustomControl.GetShowCaption: boolean;
begin
  Result := FShowCaption;
end;

procedure TadxRibbonCustomControl.SetShowCaption(Value: boolean);
begin
  if FShowCaption <> Value then begin
    FShowCaption := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetSize: TadxRibbonXControlSize;
begin
  Result := FSize;
end;

procedure TadxRibbonCustomControl.SetSize(Value: TadxRibbonXControlSize);
begin
  if FSize <> Value then begin
    FSize := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetSuperTip: WideString;
begin
  Result := FSuperTip;
end;

procedure TadxRibbonCustomControl.SetSuperTip(Value: WideString);
begin
  if FSuperTip <> Value then begin
    FSuperTip := Value;
    Invalidate;
    if Self is TadxRibbonItem then begin
      if TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown then
        TadxRibbonDropDown(TAccessCollection(Self.Collection).GetOwner).Invalidate;
    end;
  end;
end;

function TadxRibbonCustomControl.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonCustomControl.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
  Items: TadxRibbonControls;
  Controls: TadxRibbonControls;
  FirstColumn: TadxRibbonControls;
  SecondColumn: TadxRibbonControls;
  PrimaryItem: TadxRibbonControls;
  TopItems: TadxRibbonControls;
  BottomItems: TadxRibbonControls;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    Items := Self.GetItems;
    if Items <> nil then
      for i := 0 to Items.Count - 1 do
        TadxRibbonCustomControl(Items[i]).SetRibbons(Value);
    Controls := Self.GetControls;
    if Controls <> nil then
      for i := 0 to Controls.Count - 1 do
        TadxRibbonCustomControl(Controls[i]).SetRibbons(Value);

    // Case #1865
    FirstColumn := Self.GetFirstColumn();
    if FirstColumn <> nil then
      for i := 0 to FirstColumn.Count - 1 do
        TadxRibbonCustomControl(FirstColumn[i]).SetRibbons(Value);
    SecondColumn := Self.GetSecondColumn();
    if SecondColumn <> nil then
      for i := 0 to SecondColumn.Count - 1 do
        TadxRibbonCustomControl(SecondColumn[i]).SetRibbons(Value);
    PrimaryItem := Self.GetPrimaryItem();
    if PrimaryItem <> nil then
      for i := 0 to PrimaryItem.Count - 1 do
        TadxRibbonCustomControl(PrimaryItem[i]).SetRibbons(Value);
    TopItems := Self.GetTopItems();
    if TopItems <> nil then
      for i := 0 to TopItems.Count - 1 do
        TadxRibbonCustomControl(TopItems[i]).SetRibbons(Value);
    BottomItems := Self.GetBottomItems();
    if BottomItems <> nil then
      for i := 0 to BottomItems.Count - 1 do
        TadxRibbonCustomControl(BottomItems[i]).SetRibbons(Value);

    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxRibbonCustomControl.GetText: WideString;
begin
  Result := FText;
end;

procedure TadxRibbonCustomControl.SetText(Value: WideString);
begin
  if FText <> Value then begin
    FText := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetVisible: boolean;
begin
  Result := FVisible;
end;

procedure TadxRibbonCustomControl.SetVisible(Value: boolean);
begin
  if FVisible <> Value then begin
    FVisible := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetContent: WideString;
begin
  Result := '';
end;

function TadxRibbonCustomControl.GetGlyph: TBitmap;
begin
  Result := FGlyph;
end;

procedure TadxRibbonCustomControl.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Invalidate;
  if Self is TadxRibbonItem then begin
    if TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown then
      TadxRibbonDropDown(TAccessCollection(Self.Collection).GetOwner).Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := FKeyTip;
end;

procedure TadxRibbonCustomControl.SetKeyTip(Value: TadxRibbonKeyTip);
begin
  if FKeyTip <> Value then begin
    FKeyTip := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetTitle: WideString;
begin
  Result := FTitle;
end;

procedure TadxRibbonCustomControl.SetTitle(Value: WideString);
begin
  if FTitle <> Value then begin
    FTitle := Value;
    Invalidate;
  end;
end;

function TadxRibbonCustomControl.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxRibbonCustomControl.SetRibbons2010(Value: TadxRibbons2010);
var
  i: Integer;
  Items: TadxRibbonControls;
  Controls: TadxRibbonControls;
  FirstColumn: TadxRibbonControls;
  SecondColumn: TadxRibbonControls;
  PrimaryItem: TadxRibbonControls;
  TopItems: TadxRibbonControls;
  BottomItems: TadxRibbonControls;
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    Items := Self.GetItems;
    if Items <> nil then
      for i := 0 to Items.Count - 1 do
        TadxRibbonCustomControl(Items[i]).SetRibbons2010(Value);
    Controls := Self.GetControls;
    if Controls <> nil then
      for i := 0 to Controls.Count - 1 do
        TadxRibbonCustomControl(Controls[i]).SetRibbons2010(Value);

    // Case #1865
    FirstColumn := Self.GetFirstColumn();
    if FirstColumn <> nil then
      for i := 0 to FirstColumn.Count - 1 do
        TadxRibbonCustomControl(FirstColumn[i]).SetRibbons2010(Value);
    SecondColumn := Self.GetSecondColumn();
    if SecondColumn <> nil then
      for i := 0 to SecondColumn.Count - 1 do
        TadxRibbonCustomControl(SecondColumn[i]).SetRibbons2010(Value);
    PrimaryItem := Self.GetPrimaryItem();
    if PrimaryItem <> nil then
      for i := 0 to PrimaryItem.Count - 1 do
        TadxRibbonCustomControl(PrimaryItem[i]).SetRibbons2010(Value);
    TopItems := Self.GetTopItems();
    if TopItems <> nil then
      for i := 0 to TopItems.Count - 1 do
        TadxRibbonCustomControl(TopItems[i]).SetRibbons2010(Value);
    BottomItems := Self.GetBottomItems();
    if BottomItems <> nil then
      for i := 0 to BottomItems.Count - 1 do
        TadxRibbonCustomControl(BottomItems[i]).SetRibbons2010(Value);

    if msrOutlookExplorer2010 in Value then
      SetRibbons(FRibbons + [msrOutlookExplorer])
    else
      SetRibbons(FRibbons - [msrOutlookExplorer]);
  end;
end;

function TadxRibbonCustomControl.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonCustomControl.GetTarget: WideString;
begin
  Result := FTarget;
end;

function TadxRibbonCustomControl.GetAltText: WideString;
begin
  Result := FAltText;
end;

function TadxRibbonCustomControl.GetHelperText: WideString;
begin
  Result := FHelperText;
end;

function TadxRibbonCustomControl.GetGroupStyle: WideString;
begin
  Result := '';
end;

{ TadxRibbonControls }

constructor TadxRibbonControls.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass; MaxCount: Integer);
begin
  inherited Create(AOwner, ItemClass);
  FMaxCount := MaxCount;
end;

procedure TadxRibbonControls.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxRibbonControls then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TadxRibbonControls(Source).Count - 1 do
        Add(TadxRibbonControls(Source)[i].GetType).Assign(TadxRibbonControls(Source)[i]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxRibbonControls.Add: TadxRibbonCustomControl;
begin
  if Count >= FMaxCount then
    raise EADXException.Create(Format(adxErrorMaxNumber, [FMaxCount]), adxECodeMaxNumber, 0);
  Result := TadxRibbonCustomControl(inherited Add);
end;

function TadxRibbonControls.Add(AType: TadxRibbonControlType): TadxRibbonCustomControl;
const
  ClassTypes: array [TadxRibbonControlType] of TCollectionItemClass =
    (
    //TadxRibbonCommand, TadxRibbonTab, TadxRibbonQAT, TadxRibbonOfficeMenu,
    TadxRibbonCustomControl, TadxRibbonCustomControl, TadxRibbonCustomControl, TadxRibbonCustomControl,
    TadxRibbonGroup, TadxRibbonBox, TadxRibbonButtonGroup,
    TadxRibbonButton, TadxRibbonSplitButton, TadxRibbonLabel, TadxRibbonCheckBox,
    TadxRibbonEditBox, TadxRibbonComboBox, TadxRibbonDropDown, TadxRibbonGallery, TadxRibbonMenu,
    TadxRibbonSeparator, TadxRibbonMenuSeparator, TadxRibbonDialogBoxLauncher, TadxRibbonItem,
    // TadxRibbonContextMenu, TadxBackstageView
    TadxRibbonCustomControl, TadxRibbonCustomControl,

    TadxBackstageTab,
    TadxBackstageFastCommandButton,

    TadxBackstageTaskFormGroup,
    TadxBackstageTaskFormGroupCategory,
    TadxBackstageTaskFormGroupTask,
    TadxBackstageGroup,
    TadxBackstageTaskGroup,
    TadxBackstageTaskGroupCategory,
    TadxBackstageTaskGroupTask,

    TadxBackstagePrimaryMenu,
    TadxBackstageSubMenu,
    TadxBackstageMenuGroup,
    TadxBackstageMenuButton,
    TadxBackstageMenuCheckBox,
    TadxBackstageMenuToggleButton,

    TadxBackstageRegularButton,
    TadxBackstageCheckBox,
    TadxBackstageGroupButton,
    TadxBackstageEditBox,
    TadxBackstageComboBox,
    TadxBackstageDropDown,
    TadxBackstageRadioGroup,
    TadxBackstageHyperlink,
    TadxBackstageLabelControl,
    TadxBackstageImageControl,
    TadxBackstageGroupBox,
    TadxBackstageLayoutContainer,
    TadxBackstageItem);

begin
  if Count >= FMaxCount then
    raise EADXException.Create(Format(adxErrorMaxNumber, [FMaxCount]), adxECodeMaxNumber, 0);
  Result := TadxRibbonCustomControl(ClassTypes[AType].Create(Self));
end;

function TadxRibbonControls.GetOwner: TPersistent;
begin
  Result := inherited GetOwner;
end;

procedure TadxRibbonControls.Update(Item: TCollectionItem);
var
  i: Integer;
begin
  inherited Update(Item);
  for i := 0 to Self.Count - 1 do
    if Items[i] is TadxRibbonDialogBoxLauncher then begin
      Items[i].Index := Self.Count - 1;
      Break;
    end;
end;

function TadxRibbonControls.GetItem(Index: Integer): TadxRibbonCustomControl;
begin
  Result := TadxRibbonCustomControl(inherited Items[Index]);
end;

procedure TadxRibbonControls.SetItem(Index: Integer; Value: TadxRibbonCustomControl);
begin
  inherited Items[Index] := Value;
end;

{ TadxRibbonItems }

constructor TadxRibbonItems.Create(AOwner: TPersistent; ItemClass: TCollectionItemClass; MaxCount: Integer);
begin
  inherited Create(AOwner, ItemClass, MaxCount);
end;

procedure TadxRibbonItems.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxRibbonItems then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TadxRibbonItems(Source).Count - 1 do
        Add().Assign(TadxRibbonItems(Source)[i]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxRibbonItems.Add(): TadxRibbonItem;
begin
  Result := TadxRibbonItem(inherited Add());
end;

function TadxRibbonItems.Add(AType: TadxRibbonControlType): TadxRibbonCustomControl;
begin
  Result := nil;
end;

procedure TadxRibbonItems.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Self.GetOwner is TadxRibbonDropDown then
    TadxRibbonDropDown(Self.GetOwner).Invalidate;
end;

function TadxRibbonItems.GetItem(Index: Integer): TadxRibbonItem;
begin
  Result := TadxRibbonItem(inherited Items[Index]);
end;

procedure TadxRibbonItems.SetItem(Index: Integer; Value: TadxRibbonItem);
begin
  inherited Items[Index] := Value;
end;

{ TadxRibbonSeparator }

constructor TadxRibbonSeparator.Create(Collection: TCollection);
var
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonSeparator' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonSeparator.Destroy;
begin
  inherited Destroy;
end;

function TadxRibbonSeparator.GetXmlType: string;
begin
  Result := 'separator';
end;

function TadxRibbonSeparator.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
//  if not (GetRoot is TadxRibbonQAT) then
//    Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonSeparator.GetType: TadxRibbonControlType;
begin
  Result := rctSeparator;
end;

{ TadxRibbonMenuSeparator }

constructor TadxRibbonMenuSeparator.Create(Collection: TCollection);
var
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonMenuSeparator' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonMenuSeparator.Destroy;
begin
  inherited Destroy;
end;

function TadxRibbonMenuSeparator.GetTitle: WideString;
begin
  Result := FCaption;
end;

function TadxRibbonMenuSeparator.GetXmlType: string;
begin
  Result := 'menuSeparator';
end;

function TadxRibbonMenuSeparator.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
var
  Owner: TPersistent;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else begin
    if ContextMenuIndex <> 0 then
      Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
    else
      Result.Values['id'] := FID;
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if Assigned(Collection) then begin
    Owner := TAccessCollection(Collection).GetOwner;
    if Assigned(Owner) then
      if not (Owner is TadxRibbonContextMenu) then
        Result.Values['getTitle'] := 'GetTitle_Callback';
  end;
end;

function TadxRibbonMenuSeparator.GetType: TadxRibbonControlType;
begin
  Result := rctMenuSeparator;
end;

{ TadxRibbonDialogBoxLauncher }

constructor TadxRibbonDialogBoxLauncher.Create(Collection: TCollection);
var
  i: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  for i := 0 to Collection.Count - 1 do
    if Collection.Items[i] is TadxRibbonDialogBoxLauncher then
      raise EADXException.Create(Format(adxErrorOnlyOneInstance, [ClassName, 'Ribbon Group']), adxECodeOnlyOneInstance, 0);
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonDialogBoxLauncher' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonDialogBoxLauncher.Destroy;
begin
  inherited Destroy;
end;

procedure TadxRibbonDialogBoxLauncher.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxRibbonDialogBoxLauncher.GetXmlType: string;
begin
  Result := 'dialogBoxLauncher';
end;

function TadxRibbonDialogBoxLauncher.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso <> '' then Exit;
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['onAction'] := 'OnActionCommon_Callback';
  end;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonDialogBoxLauncher.GetType: TadxRibbonControlType;
begin
  Result := rctDialogBoxLauncher;
end;

{ TadxRibbonItem }

constructor TadxRibbonItem.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonItem' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonItem then Inc(Count);
    FCaption := 'adxRibbonItem' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxRibbonItem.GetDisplayName: string;
begin
  Result := ClassName;
end;

function TadxRibbonItem.GetXmlType: string;
begin
  Result := 'item';
end;

function TadxRibbonItem.GetType: TadxRibbonControlType;
begin
  Result := rctItem;
end;

{ TadxRibbonGroup }

constructor TadxRibbonGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonGroup then Inc(Count);
    FCaption := 'adxRibbonGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonGroup.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonGroup.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonGroup.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonGroup.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonGroup.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonGroup.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

function TadxRibbonGroup.GetXmlType: string;
begin
  Result := 'group';
end;

function TadxRibbonGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
var
  ARoot: TComponent;
begin
  Result := inherited GetAttributes;
  if FShared and (TadxCOMAddInModule(GetRoot.Owner).Namespace <> '') then begin
    Result.Values['idQ'] := adxSharedNS + ':' + FID;
    if Self.FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
    else
    if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
    else
    if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
    else
    if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
    Result.Values['keytip'] := string(Self.FKeyTip);
    Result.Values['label'] := Self.FCaption;
    Result.Values['screentip'] := Self.FScreenTip;
    Result.Values['supertip'] := Self.FSuperTip;
  end
  else begin
    Result.Values['getVisible'] := 'GetVisible_Callback';
    if FIDMso <> '' then Result.Values['idMso'] := FIDMso
    else begin
      if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
        Result.Values['idQ'] := adxDefaultNS + ':' + FID
      else
        Result.Values['id'] := FID;
      if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
      else
      if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
      else
      if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
      else
      if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
      if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
      if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
      Result.Values['getKeytip'] := 'GetKeyTip_Callback';
      Result.Values['getLabel'] := 'GetLabel_Callback';
      Result.Values['getSupertip'] := 'GetSuperTip_Callback';
      Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    end;
  end;
  // Ribbon 2010
  ARoot := GetRoot;
  if Assigned(ARoot) and Assigned(ARoot.Owner) then
    if (TadxCOMAddInModule(ARoot.Owner).FHostMajorVersion >= 14) and
      (TadxCOMAddInModule(ARoot.Owner).FOfficeXMLNS = 'http://schemas.microsoft.com/office/2009/07/customui') then
    begin
      if FAutoScale then
        Result.Values['autoScale'] := 'true';
      if FCenterVertically then
        Result.Values['centerVertically'] := 'true';
    end;
end;

function TadxRibbonGroup.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

function TadxRibbonGroup.GetType: TadxRibbonControlType;
begin
  Result := rctGroup;
end;

{ TadxRibbonLabel }

constructor TadxRibbonLabel.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonLabel' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonLabel then Inc(Count);
    FCaption := 'adxRibbonLabel' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxRibbonLabel.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'labelControl';
end;

function TadxRibbonLabel.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso <> '' then Exit;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonLabel.GetType: TadxRibbonControlType;
begin
  Result := rctLabel;
end;

{ TadxRibbonButton }

constructor TadxRibbonButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonButton then Inc(Count);
    FCaption := 'adxRibbonButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
  FParseMsoXmlTypeAs := pxtDefault;
end;

procedure TadxRibbonButton.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxRibbonButton.GetXmlType: string;
begin
  if (FIDMso <> '') and (FParseMsoXmlTypeAs = pxtControl) then Result := 'control'
  else begin
    if (GetRoot is TadxRibbonQAT) or
      (TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown) or
      (TAccessCollection(Self.Collection).GetOwner is TadxRibbonGallery) then
    begin
      Result := 'button';
    end
    else begin
      if FToggleButton then
        Result := 'toggleButton'
      else
        Result := 'button';
    end;
  end;
end;

function TadxRibbonButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso() <> '' then Exit;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else begin
      if ContextMenuIndex <> 0 then
        Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
      else
        Result.Values['id'] := FID;
    end;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';

    if (GetRoot is TadxRibbonQAT) or
      (TAccessCollection(Self.Collection).GetOwner is TadxRibbonDropDown) or
      (TAccessCollection(Self.Collection).GetOwner is TadxRibbonGallery) then
    begin
      Result.Values['onAction'] := 'OnActionCommon_Callback';
    end
    else begin
      if FToggleButton then begin
        Result.Values['getPressed'] := 'GetPressed_Callback';
        Result.Values['onAction'] := 'OnActionState_Callback';
      end
      else
        Result.Values['onAction'] := 'OnActionCommon_Callback';
    end;
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  if GetXmlType() <> 'control' then
    Result.Values['getDescription'] := 'GetDescription_Callback';
  if (not (TAccessCollection(Collection).GetOwner is TadxRibbonGallery) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonMenu) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonDropDown) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonSplitButton) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonButtonGroup) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonContextMenu) and
      not (GetRoot is TadxRibbonOfficeMenu) and
      not (GetRoot is TadxRibbonQAT)) then
    Result.Values['getSize'] := 'GetSize_Callback';
  if not (TAccessCollection(Collection).GetOwner is TadxRibbonSplitButton) then
    Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonButton.GetType: TadxRibbonControlType;
begin
  Result := rctButton;
end;

{ TadxRibbonCheckBox }

constructor TadxRibbonCheckBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonCheckBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonCheckBox then Inc(Count);
    FCaption := 'adxRibbonCheckBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

procedure TadxRibbonCheckBox.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxRibbonCheckBox.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'checkBox';
end;

function TadxRibbonCheckBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
    if FDescription <> '' then
      Result.Values['description'] := FDescription;
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else begin
      if ContextMenuIndex <> 0 then
        Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
      else
        Result.Values['id'] := FID;
    end;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getDescription'] := 'GetDescription_Callback';
    Result.Values['getPressed'] := 'GetPressed_Callback';
    Result.Values['onAction'] := 'OnActionState_Callback';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonCheckBox.GetType: TadxRibbonControlType;
begin
  Result := rctCheckBox;
end;

{ TadxRibbonEditBox }

constructor TadxRibbonEditBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonEditBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonEditBox then Inc(Count);
    FCaption := 'adxRibbonEditBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

procedure TadxRibbonEditBox.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FText := Args.Text;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxRibbonEditBox.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'editBox';
end;

function TadxRibbonEditBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso() <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else  Result.Values['enabled'] := 'false';
    if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    if FImageMso <> '' then
      Result.Values['showImage'] := 'true'
    else
      Result.Values['showImage'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    if (FMaxLength > 0) and (FMaxLength <= 1024) then
      Result.Values['maxLength'] := IntToStr(FMaxLength);
    Result.Values['sizeString'] := FSizeString;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getText'] := 'GetText_Callback';
    Result.Values['onChange'] := 'OnChange_Callback';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonEditBox.GetType: TadxRibbonControlType;
begin
  Result := rctEditBox;
end;

{ TadxRibbonComboBox }

constructor TadxRibbonComboBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FItems := TadxRibbonItems.Create(Self, TadxRibbonItem, 1000);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonComboBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonComboBox then Inc(Count);
    FCaption := 'adxRibbonComboBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonComboBox.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TadxRibbonComboBox.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FText := Args.Text;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxRibbonComboBox.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption, rcptItemScreenTip, rcptItemSuperTip, rcptItemGlyph] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxRibbonComboBox.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'comboBox';
end;

function TadxRibbonComboBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso() <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else  Result.Values['enabled'] := 'false';
    if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    if FImageMso <> '' then
      Result.Values['showImage'] := 'true'
    else
      Result.Values['showImage'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    if (FMaxLength > 0) and (FMaxLength <= 1024) then
      Result.Values['maxLength'] := IntToStr(FMaxLength);
    Result.Values['sizeString'] := FSizeString;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    if FImageMso <> '' then
      Result.Values['imageMso'] := FImageMso;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getText'] := 'GetText_Callback';
    Result.Values['onChange'] := 'OnChange_Callback';
    Result.Values['getItemCount'] := 'GetItemCount_Callback';
    Result.Values['getItemID'] := 'GetItemID_Callback';
    Result.Values['getItemImage'] := 'GetItemImage_Callback';
    Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
    Result.Values['getItemScreentip'] := 'GetItemScreenTip_Callback';
    Result.Values['getItemSupertip'] := 'GetItemSuperTip_Callback';
    Result.Values['invalidateContentOnDrop'] := 'true';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonComboBox.GetType: TadxRibbonControlType;
begin
  Result := rctComboBox;
end;

function TadxRibbonComboBox.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxRibbonComboBox.SetItems(const Value: TadxRibbonItems);
begin
  FItems.Assign(Value);
end;

{ TadxRibbonDropDown }

constructor TadxRibbonDropDown.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FShowItemCaption := True;
  FItems := TadxRibbonItems.Create(Self, TadxRibbonItem, 1000);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonButton, 16);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonDropDown' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonDropDown then Inc(Count);
    FCaption := 'adxRibbonDropDown' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonDropDown.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonDropDown.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FSelectedItemId := Args.SelectedID;
  FSelectedItemIndex := Args.SelectedIndex;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxRibbonDropDown.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption, rcptItemScreenTip, rcptItemSuperTip, rcptItemGlyph] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxRibbonDropDown.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'dropDown';
end;

function TadxRibbonDropDown.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso() <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
    if FImageMso <> '' then Result.Values['showImage'] := 'true'
    else Result.Values['showImage'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getItemCount'] := 'GetItemCount_Callback';
    Result.Values['getItemID'] := 'GetItemID_Callback';
    Result.Values['getItemImage'] := 'GetItemImage_Callback';
    Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
    Result.Values['getItemScreentip'] := 'GetItemScreenTip_Callback';
    Result.Values['getItemSupertip'] := 'GetItemSuperTip_Callback';
    if FSelectedItemIndex > -1 then
      Result.Values['getSelectedItemIndex'] := 'GetSelectedItemIndex_Callback'
    else
    if FSelectedItemId <> '' then
      Result.Values['getSelectedItemID'] := 'GetSelectedItemId_Callback';
    Result.Values['onAction'] := 'OnActionSelected_Callback';
    if FSizeString <> '' then Result.Values['sizeString'] := FSizeString;
    if FShowItemCaption then Result.Values['showItemLabel'] := 'true'
    else Result.Values['showItemLabel'] := 'false';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonDropDown.GetType: TadxRibbonControlType;
begin
  Result := rctDropDown;
end;

function TadxRibbonDropDown.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

function TadxRibbonDropDown.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxRibbonDropDown.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonDropDown.SetItems(const Value: TadxRibbonItems);
begin
  FItems.Assign(Value);
end;

{ TadxRibbonGallery }

constructor TadxRibbonGallery.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FColumns := 1;
  FRows := 1;
  FShowItemCaption := True;
  FItems := TadxRibbonItems.Create(Self, TadxRibbonItem, 1000);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonButton, 16);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonGallery' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonGallery then Inc(Count);
    FCaption := 'adxRibbonGallery' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonGallery.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonGallery.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FSelectedItemId := Args.SelectedId;
  FSelectedItemIndex := Args.SelectedIndex;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxRibbonGallery.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption, rcptItemScreenTip, rcptItemSuperTip, rcptItemGlyph] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxRibbonGallery.GetXmlType: string;
begin
  if FIDMso <> '' then
    Result := 'control'
  else
    Result := 'gallery';
end;

function TadxRibbonGallery.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso() <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
    if FImageMso <> '' then Result.Values['showImage'] := 'true'
    else Result.Values['showImage'] := 'false';
    // Case #1698
    (*
    if (not (TAccessCollection(Collection).GetOwner is TadxRibbonMenu) and
        not (TAccessCollection(Collection).GetOwner is TadxRibbonButtonGroup) and
        not (TAccessCollection(Collection).GetOwner is TadxRibbonContextMenu) and
        not (GetRoot is TadxRibbonOfficeMenu)) then
    begin
      if FSize = csRegular then Result.Values['size'] := 'normal';
      if FSize = csLarge then Result.Values['size'] := 'large';
    end;
    *)
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else begin
      if ContextMenuIndex <> 0 then
        Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
      else
        Result.Values['id'] := FID;
    end;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    if FShowItemCaption then
      Result.Values['showItemLabel'] := 'true'
    else
      Result.Values['showItemLabel'] := 'false';
    Result.Values['getItemCount'] := 'GetItemCount_Callback';
    Result.Values['getItemID'] := 'GetItemID_Callback';
    Result.Values['getItemImage'] := 'GetItemImage_Callback';
    Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
    Result.Values['getItemScreentip'] := 'GetItemScreenTip_Callback';
    Result.Values['getItemSupertip'] := 'GetItemSuperTip_Callback';
    if FSelectedItemIndex > -1 then
      Result.Values['getSelectedItemIndex'] := 'GetSelectedItemIndex_Callback'
    else
    if FSelectedItemId <> '' then
      Result.Values['getSelectedItemID'] := 'GetSelectedItemId_Callback';
    Result.Values['onAction'] := 'OnActionSelected_Callback';
    Result.Values['columns'] := IntToStr(FColumns);
    Result.Values['rows'] := IntToStr(FRows);
    Result.Values['getItemHeight'] := 'GetItemHeight_Callback';
    Result.Values['getItemWidth'] := 'GetItemWidth_Callback';
    Result.Values['invalidateContentOnDrop'] := 'true';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getVisible'] := 'GetVisible_Callback';
  if (not (TAccessCollection(Collection).GetOwner is TadxRibbonMenu) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonButtonGroup) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonContextMenu) and
      not (GetRoot is TadxRibbonOfficeMenu)) then
    Result.Values['getSize'] := 'GetSize_Callback';
end;

function TadxRibbonGallery.GetType: TadxRibbonControlType;
begin
  Result := rctGallery;
end;

function TadxRibbonGallery.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

function TadxRibbonGallery.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxRibbonGallery.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonGallery.SetItems(const Value: TadxRibbonItems);
begin
  FItems.Assign(Value);
end;

procedure TadxRibbonGallery.SetColumns(const Value: Integer);
begin
  if FColumns <> Value then
    if (Value >= 1) and (Value <= 1024) then begin
      FColumns := Value;
      Invalidate;
    end;
end;

procedure TadxRibbonGallery.SetRows(const Value: Integer);
begin
  if FRows <> Value then
    if (Value >= 1) and (Value <= 1024) then begin
      FRows := Value;
      Invalidate;
    end;
end;

{ TadxRibbonMenu }

constructor TadxRibbonMenu.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  FDynamic := False;
  SetLength(FControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonMenu' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonMenu then Inc(Count);
    FCaption := 'adxRibbonMenu' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonMenu.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonMenu.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonMenu.SetDynamic(Value: boolean);
begin
  if FDynamic <> Value then begin
    if TAccessCollection(Collection).GetOwner is TadxRibbonSplitButton then begin
      if Value and (csDesigning in GetRoot.ComponentState) then
        MessageDlg('The TadxRibbonSplitButton control cannot contain a dynamic menu!', mtInformation, [mbOK], 0);
    end
    else
      FDynamic := Value;
  end;
end;

procedure TadxRibbonMenu.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonMenu.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonMenu.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonMenu.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonMenu.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

function TadxRibbonMenu.GetXmlType: string;
begin
  if (FIDMso <> '') and (GetParentIDMso = '') then
    Result := 'control'
  else begin
    if FDynamic then Result := 'dynamicMenu'
    else Result := 'menu';
  end
end;

function TadxRibbonMenu.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso <> '' then Exit;

    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FSuperTip <> '' then Result.Values['supertip'] := FSuperTip;
    if FScreenTip <> '' then Result.Values['screentip'] := FScreenTip;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
    if FImageMso <> '' then Result.Values['showImage'] := 'true'
    else Result.Values['showImage'] := 'false';
    if not (GetRoot is TadxRibbonOfficeMenu) then
      if FDescription <> '' then Result.Values['description'] := FDescription;
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else begin
      if ContextMenuIndex <> 0 then
        Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
      else
        Result.Values['id'] := FID;
    end;
    if FDynamic then begin
      Result.Values['getContent'] := 'GetContent_Callback';
      Result.Values['invalidateContentOnDrop'] := 'true';
    end
    else begin
      if FItemSize = Normal then Result.Values['itemSize'] := 'normal'
      else Result.Values['itemSize'] := 'large';
    end;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getShowImage'] := 'GetShowImage_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    if not (GetRoot is TadxRibbonOfficeMenu) then
      Result.Values['getDescription'] := 'GetDescription_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    if (TAccessCollection(Collection).GetOwner is TadxRibbonSplitButton) then
      Result.Values['supertip'] := FSuperTip
    else
      Result.Values['getSupertip'] := 'GetSuperTip_Callback';
    Result.Values['getScreentip'] := 'GetScreenTip_Callback';
    if (GetRoot is TadxRibbonOfficeMenu) and not FDynamic then
      Result.Values['getTitle'] := 'GetTitle_Callback';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  if (not (TAccessCollection(Collection).GetOwner is TadxRibbonMenu) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonSplitButton) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonButtonGroup) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonContextMenu) and
      not (GetRoot is TadxRibbonOfficeMenu)) then
    Result.Values['getSize'] := 'GetSize_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonMenu.GetType: TadxRibbonControlType;
begin
  Result := rctMenu;
end;

function TadxRibbonMenu.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

function TadxRibbonMenu.GetContent: WideString;
var
  i: Integer;
  Module: TadxCOMAddInModule;
  xmlData: TadxXMLHelper;
begin
  if Assigned(FOnCreate) then
    try
      FOnCreate(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModule(Self.GetRoot.Owner).DoError(E);
    end;
  xmlData := TadxXMLHelper.Create;
  Module := TadxCOMAddInModule(Self.GetRoot.Owner);
  xmlData.WriteStartElement('menu');
  xmlData.WriteAttributeString('xmlns', Module.FOfficeXMLNS);
  if Module.Namespace <> '' then begin
    xmlData.WriteAttributeString('xmlns:' + adxDefaultNS, Module.FCOMAddInClassFactory.ProgID);
    xmlData.WriteAttributeString('xmlns:' + adxSharedNS, Module.Namespace);
  end;
  if Self.ItemSize = Large then
    xmlData.WriteAttributeString('itemSize', 'large');
  for i := 0 to Self.FControls.Count - 1 do
    ProcessChildren(TadxCOMAddInModule(Self.GetRoot.Owner), xmlData, Self.FControls[i], 'DynamicMenu');
  xmlData.WriteEndElement('menu');
  Result := xmlData.Text;
  xmlData.Free;
end;

{ TadxRibbonSplitButton }

constructor TadxRibbonSplitButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonMenu, 10);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonSplitButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxRibbonSplitButton then Inc(Count);
    FCaption := 'adxRibbonSplitButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
  FControls.Add;
  FPressed := False; 
  FToggleButton := False;
end;

destructor TadxRibbonSplitButton.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonSplitButton.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxRibbonSplitButton.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

function TadxRibbonSplitButton.GetTitle: WideString;
begin
  Result := inherited GetTitle;
end;

function TadxRibbonSplitButton.GetXmlType: string;
begin
  Result := 'splitButton';
end;

function TadxRibbonSplitButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;
    if GetParentIDMso <> '' then Exit;
                                                   
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    if FEnabled then Result.Values['enabled'] := 'true'
    else Result.Values['enabled'] := 'false';
    if FKeyTip <> '' then Result.Values['keytip'] := string(FKeyTip);
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else begin
      if ContextMenuIndex <> 0 then
        Result.Values['id'] := FID + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
      else
        Result.Values['id'] := FID;
    end;
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  end;

  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  if (not (TAccessCollection(Collection).GetOwner is TadxRibbonMenu) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonButtonGroup) and
      not (TAccessCollection(Collection).GetOwner is TadxRibbonContextMenu) and
      not (GetRoot is TadxRibbonOfficeMenu)) then
    Result.Values['getSize'] := 'GetSize_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxRibbonSplitButton.GetWrappedAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID + 'wrapped'
  else begin
    if ContextMenuIndex <> 0 then
      Result.Values['id'] := FID + 'wrapped' + '_adx_context_menu_' + IntToStr(ContextMenuIndex)
    else
      Result.Values['id'] := FID + 'wrapped';
  end;
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback';
  if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
  //Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
  Result.Values['getShowImage'] := 'GetShowImage_Callback';
  Result.Values['getDescription'] := 'GetDescription_Callback';

  if FToggleButton then begin
    Result.Values['getPressed'] := 'GetPressed_Callback';
    Result.Values['onAction'] := 'OnActionState_Callback';
  end
  else begin
    Result.Values['onAction'] := 'OnActionCommon_Callback';
  end;
end;

function TadxRibbonSplitButton.GetType: TadxRibbonControlType;
begin
  Result := rctSplitButton;
end;

function TadxRibbonSplitButton.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

{ TadxRibbonBox }

constructor TadxRibbonBox.Create(Collection: TCollection);
var
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonBox.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonBox.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonBox.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonBox.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonBox.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonBox.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonBox.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

function TadxRibbonBox.GetXmlType: string;
begin
  Result := 'box';
end;

function TadxRibbonBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FShared and (TadxCOMAddInModule(GetRoot.Owner).Namespace <> '') then begin
    Result.Values['idQ'] := adxSharedNS + ':' + FID;
    if Self.FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
    else
    if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
    else
    if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
    else
    if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
    if FBoxStyle = bsHorizontal then Result.Values['boxStyle'] := 'horizontal'
    else Result.Values['boxStyle'] := 'vertical';
  end
  else begin
    Result.Values['getVisible'] := 'GetVisible_Callback';
    if FIDMso <> '' then Result.Values['idMso'] := FIDMso
    else begin
      if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
        Result.Values['idQ'] := adxDefaultNS + ':' + FID
      else
        Result.Values['id'] := FID;
      if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
      else
      if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
      else
      if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
      else
      if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
      if FBoxStyle = bsHorizontal then Result.Values['boxStyle'] := 'horizontal'
      else Result.Values['boxStyle'] := 'vertical';
    end;
  end
end;

function TadxRibbonBox.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonBox.GetType: TadxRibbonControlType;
begin
  Result := rctBox;
end;

procedure TadxRibbonBox.SetBoxStyle(const Value: TadxRibbonXBoxStyle);
begin
  if FBoxStyle <> Value then begin
    FBoxStyle := Value;
    Invalidate;
  end;
end;

{ TadxRibbonButtonGroup }

constructor TadxRibbonButtonGroup.Create(Collection: TCollection);
var
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonButtonGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonButtonGroup.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

procedure TadxRibbonButtonGroup.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonButtonGroup.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonButtonGroup.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonButtonGroup.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonButtonGroup.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonButtonGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

function TadxRibbonButtonGroup.GetXmlType: string;
begin
  Result := 'buttonGroup';
end;

function TadxRibbonButtonGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FShared and (TadxCOMAddInModule(GetRoot.Owner).Namespace <> '') then begin
    Result.Values['idQ'] := adxSharedNS + ':' + FID;
    if Self.FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
    else
    if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
    else
    if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
    else
    if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
  end
  else begin
    Result.Values['getVisible'] := 'GetVisible_Callback';
    if FIDMso <> '' then Result.Values['idMso'] := FIDMso
    else begin
      if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
        Result.Values['idQ'] := adxDefaultNS + ':' + FID
      else
        Result.Values['id'] := FID;
      if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
      else
      if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
      else
      if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
      else
      if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
    end;
  end;
end;

function TadxRibbonButtonGroup.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonButtonGroup.GetType: TadxRibbonControlType;
begin
  Result := rctButtonGroup;
end;

// Office 2010 components

{ TadxRibbonContextMenu }

constructor TadxRibbonContextMenu.Create(AOwner: TComponent);
var
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FEnabled := True;
  FOwner := AOwner as TadxCOMAddInModule;
  FContextMenuNames := TStringList.Create();
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
    Exclude(FRibbons2010, msrOutlookExplorer2010);
  end;
  if ohaInfoPath in FOwner.SupportedApps then begin
    Include(FRibbons2010, msrInfoPathDesigner2010);
    Include(FRibbons2010, msrInforPathFiller2010);
    Include(FRibbons2010, msrInfoPathPrintPreview2010);
  end
  else
  if ohaPublisher in FOwner.SupportedApps then
    Include(FRibbons2010, msrPublisherPublication2010)
  else
  if ohaProject in FOwner.SupportedApps then
    Include(FRibbons2010, msrProjectProject2010)
  else
  if ohaVisio in FOwner.SupportedApps then
    Include(FRibbons2010, msrVisioDrawing2010);

  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  if (csDesigning in ComponentState) and (Id = '') then begin
    CreateGUID(guid);
    FID := 'adxRibbonContextMenu' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
  end;
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxRibbonContextMenu.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  if Assigned(FContextMenuNames) then FreeAndNil(FContextMenuNames);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxRibbonContextMenu.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxRibbonContextMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then begin
    Images := nil;
    UpdateItems();
  end;
end;

procedure TadxRibbonContextMenu.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxRibbonContextMenu.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
end;

function TadxRibbonContextMenu.GetXmlType: string;
begin
  Result := 'contextMenu';
end;

function TadxRibbonContextMenu.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
end;

function TadxRibbonContextMenu.GetControls: TadxRibbonControls;
begin
  Result := FControls; 
end;

function TadxRibbonContextMenu.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetType: TadxRibbonControlType;
begin
  Result := rctContextMenu;
end;

function TadxRibbonContextMenu.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetCaption(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetDescription: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetDescription(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetEnabled: boolean;
begin
  Result := True;
end;

procedure TadxRibbonContextMenu.SetEnabled(Value: boolean);
begin
end;

function TadxRibbonContextMenu.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxRibbonContextMenu.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxRibbonContextMenu.GetIDMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetIDMso(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetImageIndex: TImageIndex;
begin
  Result := -1;
end;

procedure TadxRibbonContextMenu.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxRibbonContextMenu.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetImageMso(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetInsertAfterIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetInsertAfterIdMso(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetInsertAfterId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetInsertAfterId(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetInsertBeforeIdMso: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetInsertBeforeIdMso(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetInsertBeforeId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetInsertBeforeId(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonContextMenu.SetItemHeight(Value: Integer);
begin
end;

function TadxRibbonContextMenu.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonContextMenu.SetItemWidth(Value: Integer);
begin
end;

function TadxRibbonContextMenu.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetKeyTip(Value: TadxRibbonKeyTip);
begin
end;

function TadxRibbonContextMenu.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxRibbonContextMenu.SetPressed(Value: boolean);
begin
end;

function TadxRibbonContextMenu.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxRibbonContextMenu.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons(Value);
    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxRibbonContextMenu.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetSelectedItemId(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxRibbonContextMenu.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxRibbonContextMenu.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetScreenTip(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxRibbonContextMenu.SetShowCaption(Value: boolean);
begin
end;

function TadxRibbonContextMenu.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxRibbonContextMenu.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxRibbonContextMenu.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetSuperTip(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetText: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetText(Value: WideString);
begin
end;

function TadxRibbonContextMenu.GetTitle: WideString;
begin
  Result := '';
end;

function TadxRibbonContextMenu.GetVisible: boolean;
begin
  Result := True;
end;

procedure TadxRibbonContextMenu.SetVisible(Value: boolean);
begin
end;

function TadxRibbonContextMenu.GetContent: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetControls(Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxRibbonContextMenu.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    FImages := Value;
end;

procedure TadxRibbonContextMenu.UpdateItems;

  procedure CheckControls(const Ctrls: TadxRibbonControls);
  var
    i: Integer;
  begin
    if Ctrls <> nil then begin
      for i := 0 to Ctrls.Count - 1 do begin
        if Self.FImages = nil then
          Ctrls[i].FImageIndex := -1
        else begin
          if Ctrls[i].FImageIndex >= Self.FImages.Count then
            Ctrls[i].FImageIndex := -1;
        end;
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetControls());
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetItems());
      end;
    end;
  end;

begin
  CheckControls(Self.Controls);
end;

procedure TadxRibbonContextMenu.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxRibbonContextMenu.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxRibbonContextMenu.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxRibbonContextMenu.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

procedure TadxRibbonContextMenu.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonContextMenu.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxRibbonContextMenu.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxRibbonContextMenu.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

function TadxRibbonContextMenu.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxRibbonContextMenu.SetRibbons2010(Value: TadxRibbons2010);
var
  i: Integer;
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons2010(Value);
    if msrOutlookExplorer2010 in Value then
      SetRibbons(FRibbons + [msrOutlookExplorer])
    else
      SetRibbons(FRibbons - [msrOutlookExplorer]);
  end;
end;

function TadxRibbonContextMenu.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxRibbonContextMenu.GetTarget: WideString;
begin
  Result := '';
end;

function TadxRibbonContextMenu.GetAltText: WideString;
begin
  Result := '';
end;

function TadxRibbonContextMenu.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxRibbonContextMenu.GetGroupStyle: WideString;
begin
  Result := '';
end;

procedure TadxRibbonContextMenu.SetContextMenuNames(Value: TStringList);
begin
  FContextMenuNames.Assign(Value);
end;

// Backstage

{ TadxBackstageView }

constructor TadxBackstageView.Create(AOwner: TComponent);
var
  i, Count: Integer;
  guid: TGUID;
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FEnabled := True;
  FOwner := AOwner as TadxCOMAddInModule;
  FRibbons := [msrAccessDatabase, msrExcelWorkbook, msrPowerPointPresentation, msrWordDocument,
    msrOutlookMailRead, msrOutlookMailCompose, msrOutlookExplorer];
  FRibbons2010 := [msrOutlookExplorer2010];
  if not (ohaAccess in FOwner.SupportedApps) then
    Exclude(FRibbons, msrAccessDatabase);
  if not (ohaExcel in FOwner.SupportedApps) then
    Exclude(FRibbons, msrExcelWorkbook);
  if not (ohaPowerPoint in FOwner.SupportedApps) then
    Exclude(FRibbons, msrPowerPointPresentation);
  if not (ohaWord in FOwner.SupportedApps) then
    Exclude(FRibbons, msrWordDocument);
  if not (ohaOutlook in FOwner.SupportedApps) then begin
    Exclude(FRibbons, msrOutlookMailRead);
    Exclude(FRibbons, msrOutlookMailCompose);
    Exclude(FRibbons, msrOutlookExplorer);
    Exclude(FRibbons2010, msrOutlookExplorer2010);
  end;
  FVisible := True;
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 255);
  SetLength(FControlTypes, 0);
  if (csDesigning in ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageView' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to FOwner.FRibbonControls.Count - 1 do
      if FOwner.FRibbonControls.Objects[i] is TadxBackstageView then Inc(Count);
    FCaption := 'adxBackstageView' + IntToStr(Count);
  end;
  FOwner.FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageView.Destroy;
var
  Index: Integer;
begin
  if Assigned(FOwner) then begin
    if Assigned(FOwner.FRibbonControls) then begin
      Index := FOwner.FRibbonControls.IndexOfObject(Self);
      if Index >= 0 then FOwner.FRibbonControls.Delete(Index);
    end;
  end;
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxBackstageView.DoAction(var Args: TadxRibbonActionArguments);
begin
end;

procedure TadxBackstageView.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
end;

function TadxBackstageView.GetXmlType: string;
begin
  Result := 'backstage';
end;

function TadxBackstageView.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
end;

function TadxBackstageView.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageView;
end;

function TadxBackstageView.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

function TadxBackstageView.GetItems: TadxRibbonControls;
begin
  Result := nil;
end;

procedure TadxBackstageView.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

function TadxBackstageView.GetCaption: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetCaption(Value: WideString);
begin
end;

function TadxBackstageView.GetDescription: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetDescription(Value: WideString);
begin
end;

function TadxBackstageView.GetEnabled: boolean;
begin
  Result := True;
end;

procedure TadxBackstageView.SetEnabled(Value: boolean);
begin
end;

function TadxBackstageView.GetID: WideString;
begin
  Result := FID;
end;

procedure TadxBackstageView.SetID(Value: WideString);
var
  Index: Integer;
begin
  if (Value <> '') and (FID <> Value) then begin
    FID := Value;
    Index := FOwner.FRibbonControls.IndexOfObject(Self);
    if Index >= 0 then FOwner.FRibbonControls[Index] := FID;
  end;
end;

function TadxBackstageView.GetIDMso: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetIDMso(Value: WideString);
begin
end;

function TadxBackstageView.GetImageIndex: TImageIndex;
begin
  Result := -1;
end;

procedure TadxBackstageView.SetImageIndex(Value: TImageIndex);
begin
end;

function TadxBackstageView.GetImageMso: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetImageMso(Value: WideString);
begin
end;

function TadxBackstageView.GetInsertAfterIdMso: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetInsertAfterIdMso(Value: WideString);
begin
end;

function TadxBackstageView.GetInsertAfterId: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetInsertAfterId(Value: WideString);
begin
end;

function TadxBackstageView.GetInsertBeforeIdMso: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetInsertBeforeIdMso(Value: WideString);
begin
end;

function TadxBackstageView.GetInsertBeforeId: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetInsertBeforeId(Value: WideString);
begin
end;

function TadxBackstageView.GetItemHeight: Integer;
begin
  Result := -1;
end;

procedure TadxBackstageView.SetItemHeight(Value: Integer);
begin
end;

function TadxBackstageView.GetItemWidth: Integer;
begin
  Result := -1;
end;

procedure TadxBackstageView.SetItemWidth(Value: Integer);
begin
end;

function TadxBackstageView.GetKeyTip: TadxRibbonKeyTip;
begin
  Result := '';
end;

procedure TadxBackstageView.SetKeyTip(Value: TadxRibbonKeyTip);
begin
end;

function TadxBackstageView.GetPressed: boolean;
begin
  Result := False;
end;

procedure TadxBackstageView.SetPressed(Value: boolean);
begin
end;

function TadxBackstageView.GetRibbons: TadxRibbons;
begin
  Result := FRibbons;
end;

procedure TadxBackstageView.SetRibbons(Value: TadxRibbons);
var
  i: Integer;
begin
  if FRibbons <> Value then begin
    FRibbons := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons(Value);
    if msrOutlookExplorer in Value then
      SetRibbons2010(FRibbons2010 + [msrOutlookExplorer2010])
    else
      SetRibbons2010(FRibbons2010 - [msrOutlookExplorer2010]);
  end;
end;

function TadxBackstageView.GetSelectedItemId: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetSelectedItemId(Value: WideString);
begin
end;

function TadxBackstageView.GetSelectedItemIndex: Integer;
begin
  Result := -1;
end;

procedure TadxBackstageView.SetSelectedItemIndex(Value: Integer);
begin
end;

function TadxBackstageView.GetScreenTip: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetScreenTip(Value: WideString);
begin
end;

function TadxBackstageView.GetShowCaption: boolean;
begin
  Result := False;
end;

procedure TadxBackstageView.SetShowCaption(Value: boolean);
begin
end;

function TadxBackstageView.GetSize: TadxRibbonXControlSize;
begin
  Result := csRegular;
end;

procedure TadxBackstageView.SetSize(Value: TadxRibbonXControlSize);
begin
end;

function TadxBackstageView.GetSuperTip: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetSuperTip(Value: WideString);
begin
end;

function TadxBackstageView.GetText: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetText(Value: WideString);
begin
end;

function TadxBackstageView.GetVisible: boolean;
begin
  Result := FVisible;
end;

procedure TadxBackstageView.SetVisible(Value: boolean);
begin
end;

function TadxBackstageView.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TadxBackstageView.GetTitle: WideString;
begin
  Result := '';
end;

function TadxBackstageView.GetContent: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
    FImages := Value;
end;

procedure TadxBackstageView.UpdateItems;
  procedure CheckControls(const Ctrls: TadxRibbonControls);
  var
    i: Integer;
  begin
    if Ctrls <> nil then begin
      for i := 0 to Ctrls.Count - 1 do begin
        if Self.FImages = nil then
          Ctrls[i].FImageIndex := -1
        else begin
          if Ctrls[i].FImageIndex >= Self.FImages.Count then
            Ctrls[i].FImageIndex := -1;
        end;
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetControls());
        CheckControls(IadxRibbonComponent(Ctrls[i]).GetItems());
      end;
    end;
  end;

begin
  CheckControls(Self.Controls);
end;

function TadxBackstageView.GetRibbons2010: TadxRibbons2010;
begin
  Result := FRibbons2010;
end;

procedure TadxBackstageView.SetRibbons2010(Value: TadxRibbons2010);
var
  i: Integer;
begin
  if FRibbons2010 <> Value then begin
    FRibbons2010 := Value;
    // Case #1990
    if csLoading in ComponentState then Exit;
    for i := 0 to Controls.Count - 1 do
      IadxRibbonComponent(TadxRibbonCustomControl(Controls[i])).SetRibbons2010(Value);
    if msrOutlookExplorer2010 in Value then
      SetRibbons(FRibbons + [msrOutlookExplorer])
    else
      SetRibbons(FRibbons - [msrOutlookExplorer]);
  end;
end;

function TadxBackstageView.GetFirstColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxBackstageView.GetSecondColumn: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxBackstageView.GetPrimaryItem: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxBackstageView.GetTopItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxBackstageView.GetBottomItems: TadxRibbonControls;
begin
  Result := nil;
end;

function TadxBackstageView.GetTarget: WideString;
begin
  Result := '';
end;

function TadxBackstageView.GetAltText: WideString;
begin
  Result := '';
end;

function TadxBackstageView.GetHelperText: WideString;
begin
  Result := '';
end;

function TadxBackstageView.GetGroupStyle: WideString;
begin
  Result := '';
end;

procedure TadxBackstageView.DoShow(const Context: IDispatch);
begin
  FVisible := True;
  if Assigned(FOnShow) then
    try
      FOnShow(Self, Context);
    except
      on E: SysUtils.Exception do FOwner.DoError(E);
    end;
end;

procedure TadxBackstageView.DoHide(const Context: IDispatch);
begin
  FVisible := False;
  if Assigned(FOnHide) then
    try
      FOnHide(Self, Context);
    except
      on E: SysUtils.Exception do FOwner.DoError(E);
    end;
end;

procedure TadxBackstageView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = Images) and (Operation = opRemove) then begin
    Images := nil;
    UpdateItems();
  end;
end;

procedure TadxBackstageView.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
  Filer.DefineProperty('Ribbons', ReadRibbons, WriteRibbons, True);
  Filer.DefineProperty('Ribbons2010', ReadRibbons2010, WriteRibbons2010, True);
end;

procedure TadxBackstageView.WriteRibbons(Writer: TWriter);
var
  I: TadxRibbon;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon) to High(TadxRibbon) do
    if I in FRibbons then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxBackstageView.ReadRibbons(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons, TadxRibbon(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxBackstageView.WriteRibbons2010(Writer: TWriter);
var
  I: TadxRibbon2010;
  BaseType: PTypeInfo;
begin
  BaseType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
  TAccessWriter(Writer).WriteValue(vaSet);
  for I := Low(TadxRibbon2010) to High(TadxRibbon2010) do
    if I in FRibbons2010 then
      {$IFDEF UNICODE}
      TAccessWriter(Writer).WriteUTF8Str(GetEnumName(BaseType, Integer(I)));
      {$ELSE}
      TAccessWriter(Writer).WriteStr(GetEnumName(BaseType, Integer(I)));
      {$ENDIF}
  TAccessWriter(Writer).WriteStr('');
end;

procedure TadxBackstageView.ReadRibbons2010(Reader: TReader);
var
  EnumType: PTypeInfo;
  EnumName: string;
begin
  if Reader.ReadValue = vaSet then begin
    EnumType := GetTypeData(TypeInfo(TadxRibbons2010))^.CompType^;
    while True do begin
      EnumName := Reader.ReadStr;
      if EnumName = '' then Break;
      Include(FRibbons2010, TadxRibbon2010(GetEnumValue(EnumType, EnumName)));
    end;
  end;
end;

procedure TadxBackstageView.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxBackstageView.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageView.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxBackstageView.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

{ TadxBackstageTab }

constructor TadxBackstageTab.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FFirstColumn := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  FSecondColumn := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FFirstControlTypes, 0);
  SetLength(FSecondControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTab' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTab then Inc(Count);
    FCaption := 'adxBackstageTab' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTab.Destroy;
begin
  if Assigned(FFirstColumn) then FreeAndNil(FFirstColumn);
  if Assigned(FSecondColumn) then FreeAndNil(FSecondColumn);
  SetLength(FFirstControlTypes, 0);
  SetLength(FSecondControlTypes, 0);
  inherited Destroy;
end;

function TadxBackstageTab.GetXmlType: string;
begin
  Result := 'tab';
end;

function TadxBackstageTab.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FTitle <> '' then Result.Values['title'] := FTitle;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getTitle'] := 'GetTitle_Callback';

    if FColumnWidthPercent <> 0 then
      Result.Values['columnWidthPercent'] := IntToStr(FColumnWidthPercent);
    if FFirstColumnMinWidth <> 0 then
      Result.Values['firstColumnMinWidth'] := IntToStr(FFirstColumnMinWidth);
    if FFirstColumnMaxWidth <> 0 then
      Result.Values['firstColumnMaxWidth'] := IntToStr(FFirstColumnMaxWidth);
    if FSecondColumnMinWidth <> 0 then
      Result.Values['secondColumnMinWidth'] := IntToStr(FSecondColumnMinWidth);
    if FSecondColumnMaxWidth <> 0 then
      Result.Values['secondColumnMaxWidth'] := IntToStr(FSecondColumnMaxWidth);
    Result.Values['getVisible'] := 'GetVisible_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTab.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTab;
end;

function TadxBackstageTab.GetFirstColumn: TadxRibbonControls;
begin
  Result := FFirstColumn;
end;

function TadxBackstageTab.GetSecondColumn: TadxRibbonControls;
begin
  Result := FSecondColumn;
end;

procedure TadxBackstageTab.SetFirstColumn(const Value: TadxRibbonControls);
begin
  FFirstColumn.Assign(Value);
end;

procedure TadxBackstageTab.SetSecondColumn(const Value: TadxRibbonControls);
begin
  FSecondColumn.Assign(Value);
end;

procedure TadxBackstageTab.SetColumnWidthPercent(Value: Integer);
begin
  if FColumnWidthPercent <> Value then
    if (Value >= 0) and (Value <= 99) then
      FColumnWidthPercent := Value;
end;

procedure TadxBackstageTab.SetFirstColumnMinWidth(Value: Integer);
begin
  if FFirstColumnMinWidth <> Value then
    if (Value >= 0) and (Value <= 10000) then
      FFirstColumnMinWidth := Value;
end;

procedure TadxBackstageTab.SetFirstColumnMaxWidth(Value: Integer);
begin
  if FFirstColumnMaxWidth <> Value then
    if (Value >= 0) and (Value <= 10000) then
      FFirstColumnMaxWidth := Value;
end;

procedure TadxBackstageTab.SetSecondColumnMinWidth(Value: Integer);
begin
  if FSecondColumnMinWidth <> Value then
    if (Value >= 0) and (Value <= 10000) then
      FSecondColumnMinWidth := Value;
end;

procedure TadxBackstageTab.SetSecondColumnMaxWidth(Value: Integer);
begin
  if FSecondColumnMaxWidth <> Value then
    if (Value >= 0) and (Value <= 10000) then
      FSecondColumnMaxWidth := Value;
end;

procedure TadxBackstageTab.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('FirstColumnTypes', ReadFirstColumnTypes, WriteFirstColumnTypes, True);
  Filer.DefineBinaryProperty('SecondColumnTypes', ReadSecondColumnTypes, WriteSecondColumnTypes, True);
  Filer.DefineProperty('FirstColumnControls', ReadFirstColumnControls, WriteFirstColumnControls, True);
  Filer.DefineProperty('SecondColumnControls', ReadSecondColumnControls, WriteSecondColumnControls, True);
end;

procedure TadxBackstageTab.WriteFirstColumnTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FFirstControlTypes, FirstColumn.Count);
  for i := 0 to FirstColumn.Count - 1 do
    FFirstControlTypes[i] := Integer(FirstColumn.Items[i].GetType);
  i := FirstColumn.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if FirstColumn.Count > 0 then
    Stream.WriteBuffer(FFirstControlTypes[0], FirstColumn.Count * SizeOf(Integer));
end;

procedure TadxBackstageTab.ReadFirstColumnTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FFirstControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FFirstControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageTab.WriteSecondColumnTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FSecondControlTypes, SecondColumn.Count);
  for i := 0 to SecondColumn.Count - 1 do
    FSecondControlTypes[i] := Integer(SecondColumn.Items[i].GetType);
  i := SecondColumn.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if SecondColumn.Count > 0 then
    Stream.WriteBuffer(FSecondControlTypes[0], SecondColumn.Count * SizeOf(Integer));
end;

procedure TadxBackstageTab.ReadSecondColumnTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FSecondControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FSecondControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageTab.WriteFirstColumnControls(Writer: TWriter);
begin
  Writer.WriteCollection(FirstColumn);
end;

procedure TadxBackstageTab.ReadFirstColumnControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  FirstColumn.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    FirstColumn.BeginUpdate;
    try
      if not EndOfList then FirstColumn.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := FirstColumn.Add(TadxRibbonControlType(FFirstControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      FirstColumn.EndUpdate;
    end;
  end;
end;

procedure TadxBackstageTab.WriteSecondColumnControls(Writer: TWriter);
begin
  Writer.WriteCollection(SecondColumn);
end;

procedure TadxBackstageTab.ReadSecondColumnControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  SecondColumn.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    SecondColumn.BeginUpdate;
    try
      if not EndOfList then SecondColumn.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := SecondColumn.Add(TadxRibbonControlType(FSecondControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      SecondColumn.EndUpdate;
    end;
  end;
end;

{ TadxBackstageItem }

constructor TadxBackstageItem.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageItem' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageItem then Inc(Count);
    FCaption := 'adxBackstageItem' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageItem.GetDisplayName: string;
begin
  Result := ClassName;
end;

function TadxBackstageItem.GetXmlType: string;
begin
  if TAccessCollection(Self.Collection).GetOwner is TadxBackstageRadioGroup then
    Result := 'radioButton'
  else
    Result := 'item';
end;

function TadxBackstageItem.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageItem;
end;

{ TadxBackstageItems }

procedure TadxBackstageItems.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxBackstageItems then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TadxBackstageItems(Source).Count - 1 do
        Add().Assign(TadxBackstageItems(Source)[i]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxBackstageItems.Add(): TadxBackstageItem;
begin
  Result := TadxBackstageItem(inherited Add());
end;

function TadxBackstageItems.Add(AType: TadxRibbonControlType): TadxRibbonCustomControl;
begin
  Result := nil;
end;

procedure TadxBackstageItems.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Self.GetOwner is TadxBackstageDropDown then
    TadxBackstageDropDown(Self.GetOwner).Invalidate;
  if Self.GetOwner is TadxBackstageComboBox then
    TadxBackstageComboBox(Self.GetOwner).Invalidate;
  if Self.GetOwner is TadxBackstageRadioGroup then
    TadxBackstageRadioGroup(Self.GetOwner).Invalidate;
end;

function TadxBackstageItems.GetItem(Index: Integer): TadxBackstageItem;
begin
  Result := TadxBackstageItem(inherited Items[Index]);
end;

procedure TadxBackstageItems.SetItem(Index: Integer; Value: TadxBackstageItem);
begin
  inherited Items[Index] := Value;
end;

const
  constAligns: array [TadxBackstageContentAlignmentStyle] of string =
    ('topLeft', 'top', 'topRight',
    'left', 'center', 'right',
    'bottomLeft', 'bottom', 'bottomRight');
  constExpands: array [TadxBackstageControlExpandStyle] of string =
    ('horizontal', 'vertical', 'both', 'neither');

{ TadxBackstageEditBox }

constructor TadxBackstageEditBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageEditBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageEditBox then Inc(Count);
    FCaption := 'adxBackstageEditBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

procedure TadxBackstageEditBox.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FText := Args.Text;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxBackstageEditBox.GetXmlType: string;
begin
  Result := 'editBox';
end;

function TadxBackstageEditBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  if (FMaxLength > 0) and (FMaxLength <= 1024) then
    Result.Values['maxLength'] := IntToStr(FMaxLength);
  if FSizeString <> '' then Result.Values['sizeString'] := FSizeString;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getText'] := 'GetText_Callback';
  Result.Values['onChange'] := 'OnChange_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxBackstageEditBox.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageEditBox;
end;

{ TadxBackstageDropDown }

constructor TadxBackstageDropDown.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FItems := TadxBackstageItems.Create(Self, TadxBackstageItem, 1000);
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageDropDown' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageDropDown then Inc(Count);
    FCaption := 'adxBackstageDropDown' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageDropDown.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TadxBackstageDropDown.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FSelectedItemId := Args.SelectedID;
  FSelectedItemIndex := Args.SelectedIndex;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxBackstageDropDown.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxBackstageDropDown.GetXmlType: string;
begin
  Result := 'dropDown';
end;

function TadxBackstageDropDown.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getSelectedItemIndex'] := 'GetSelectedItemIndex_Callback';

  Result.Values['getItemCount'] := 'GetItemCount_Callback';
  Result.Values['getItemID'] := 'GetItemID_Callback';
  Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
  Result.Values['onAction'] := 'OnActionSelected_Callback';
  if FSizeString <> '' then Result.Values['sizeString'] := FSizeString;
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxBackstageDropDown.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageDropDown;
end;

function TadxBackstageDropDown.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxBackstageDropDown.SetItems(const Value: TadxBackstageItems);
begin
  FItems.Assign(Value);
end;

{ TadxBackstageRadioGroup }

constructor TadxBackstageRadioGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FItems := TadxBackstageItems.Create(Self, TadxBackstageItem, 1000);
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageRadioGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageRadioGroup then Inc(Count);
    FCaption := 'adxBackstageRadioGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageRadioGroup.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TadxBackstageRadioGroup.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FSelectedItemId := Args.SelectedID;
  FSelectedItemIndex := Args.SelectedIndex;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxBackstageRadioGroup.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxBackstageRadioGroup.GetXmlType: string;
begin
  Result := 'radioGroup';
end;

function TadxBackstageRadioGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getSelectedItemIndex'] := 'GetSelectedItemIndex_Callback';

  Result.Values['getItemCount'] := 'GetItemCount_Callback';
  Result.Values['getItemID'] := 'GetItemID_Callback';
  Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
  Result.Values['onAction'] := 'OnActionSelected_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxBackstageRadioGroup.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageRadioGroup;
end;

function TadxBackstageRadioGroup.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxBackstageRadioGroup.SetItems(const Value: TadxBackstageItems);
begin
  FItems.Assign(Value);
end;

{ TadxBackstageComboBox }

constructor TadxBackstageComboBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FItems := TadxBackstageItems.Create(Self, TadxBackstageItem, 1000);
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageComboBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageComboBox then Inc(Count);
    FCaption := 'adxBackstageComboBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageComboBox.Destroy;
begin
  if Assigned(FItems) then FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TadxBackstageComboBox.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FText := Args.Text;
  if Assigned(FOnChange) and not FInUse then
    try
      FInUse := True;
      try
        FOnChange(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

procedure TadxBackstageComboBox.DoChangeProperty(PropertyType: TadxRibbonControlPropertyType; var Value: OleVariant; const Context: IDispatch; Index: integer);
begin
  try
    if PropertyType in [rcptItemID, rcptItemCaption] then begin
      if Assigned(FOnItemPropertyChanging) then
        FOnItemPropertyChanging(Self, PropertyType, Value, Context, Index);
    end
    else begin
      if Assigned(FOnPropertyChanging) then
        FOnPropertyChanging(Self, PropertyType, Value, Context);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
  end;
end;

function TadxBackstageComboBox.GetXmlType: string;
begin
  Result := 'comboBox';
end;

function TadxBackstageComboBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  if FSizeString <> '' then Result.Values['sizeString'] := FSizeString;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getText'] := 'GetText_Callback';
  Result.Values['getItemCount'] := 'GetItemCount_Callback';
  Result.Values['getItemID'] := 'GetItemID_Callback';
  Result.Values['getItemLabel'] := 'GetItemLabel_Callback';
  Result.Values['onChange'] := 'OnChange_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
end;

function TadxBackstageComboBox.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageComboBox;
end;

function TadxBackstageComboBox.GetItems: TadxRibbonControls;
begin
  Result := FItems;
end;

procedure TadxBackstageComboBox.SetItems(const Value: TadxBackstageItems);
begin
  FItems.Assign(Value);
end;

{ TadxBackstageHyperlink }

constructor TadxBackstageHyperlink.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageHyperlink' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageHyperlink then Inc(Count);
    FCaption := 'adxBackstageHyperlink' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

procedure TadxBackstageHyperlink.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxBackstageHyperlink.GetXmlType: string;
begin
  Result := 'hyperlink';
end;

function TadxBackstageHyperlink.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
  else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
  Result.Values['onAction'] := 'OnActionCommon_Callback';
  //Result.Values['getTarget'] := 'GetTarget_Callback';
end;

function TadxBackstageHyperlink.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageHyperlink;
end;

{ TadxBackstageLabelControl }

constructor TadxBackstageLabelControl.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FWordWrap := True;
  FTextAlign := caTopLeft;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageLabelControl' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageLabelControl then Inc(Count);
    FCaption := 'adxBackstageLabelControl' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageLabelControl.GetXmlType: string;
begin
  Result := 'labelControl';
end;

function TadxBackstageLabelControl.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['alignLabel'] := constAligns[FTextAlign];
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  if FWordWrap then Result.Values['noWrap'] := 'false'
  else Result.Values['noWrap'] := 'true';
end;

function TadxBackstageLabelControl.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageLabelControl;
end;

{ TadxBackstageImageControl }

constructor TadxBackstageImageControl.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageImageControl' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageImageControl then Inc(Count);
    FCaption := 'adxBackstageImageControl' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageImageControl.GetXmlType: string;
begin
  Result := 'imageControl';
end;

function TadxBackstageImageControl.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
  else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getAltText'] := 'GetAltText_Callback';
end;

function TadxBackstageImageControl.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageImageControl;
end;

{ TadxBackstageGroupBox }

constructor TadxBackstageGroupBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageGroupBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageGroupBox then Inc(Count);
    FCaption := 'adxBackstageGroupBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageGroupBox.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageGroupBox.GetXmlType: string;
begin
  Result := 'groupBox';
end;

function TadxBackstageGroupBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getLabel'] := 'GetLabel_Callback';
end;

function TadxBackstageGroupBox.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageGroupBox;
end;

function TadxBackstageGroupBox.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageGroupBox.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxBackstageGroupBox.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

procedure TadxBackstageGroupBox.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxBackstageGroupBox.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageGroupBox.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxBackstageGroupBox.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

{ TadxBackstageLayoutContainer }

constructor TadxBackstageLayoutContainer.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  FChildrenAlign := caTopLeft;
  FChildrenLayout := bcVertical;
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageLayoutContainer' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageLayoutContainer then Inc(Count);
    FCaption := 'adxBackstageLayoutContainer' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageLayoutContainer.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageLayoutContainer.GetXmlType: string;
begin
  Result := 'layoutContainer';
end;

function TadxBackstageLayoutContainer.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['align'] := constAligns[FChildrenAlign];
  Result.Values['expand'] := constExpands[FExpand];
  if FChildrenLayout = bcHorizontal then Result.Values['layoutChildren'] := 'horizontal'
  else Result.Values['layoutChildren'] := 'vertical';
end;

function TadxBackstageLayoutContainer.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageLayoutContainer;
end;

function TadxBackstageLayoutContainer.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageLayoutContainer.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxBackstageLayoutContainer.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

procedure TadxBackstageLayoutContainer.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxBackstageLayoutContainer.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageLayoutContainer.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxBackstageLayoutContainer.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

{ TadxBackstageMenuGroup }

constructor TadxBackstageMenuGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  SetLength(FControlTypes, 0);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageMenuGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageMenuGroup then Inc(Count);
    FCaption := 'adxBackstageMenuGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageMenuGroup.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageMenuGroup.GetXmlType: string;
begin
  Result := 'menuGroup';
end;

function TadxBackstageMenuGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['getLabel'] := 'GetLabel_Callback';
  if FItemSize = Normal then Result.Values['itemSize'] := 'normal'
  else Result.Values['itemSize'] := 'large';
end;

function TadxBackstageMenuGroup.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageMenuGroup;
end;

function TadxBackstageMenuGroup.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageMenuGroup.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxBackstageMenuGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ControlTypes', ReadControlTypes, WriteControlTypes, True);
  Filer.DefineProperty('Controls_', ReadControls, WriteControls, True);
end;

procedure TadxBackstageMenuGroup.WriteControlTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FControlTypes, Controls.Count);
  for i := 0 to Controls.Count - 1 do
    FControlTypes[i] := Integer(Controls.Items[i].GetType);
  i := Controls.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if Controls.Count > 0 then
    Stream.WriteBuffer(FControlTypes[0], Controls.Count * SizeOf(Integer));
end;

procedure TadxBackstageMenuGroup.ReadControlTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FControlTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FControlTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageMenuGroup.WriteControls(Writer: TWriter);
begin
  Writer.WriteCollection(Controls);
end;

procedure TadxBackstageMenuGroup.ReadControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  Controls.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    Controls.BeginUpdate;
    try
      if not EndOfList then Controls.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := Controls.Add(TadxRibbonControlType(FControlTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      Controls.EndUpdate;
    end;
  end;
end;

{ TadxBackstageMenuBase }

constructor TadxBackstageMenuBase.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxBackstageMenuGroup, 1000);
  SetLength(FControlTypes, 0);
end;

destructor TadxBackstageMenuBase.Destroy;
begin
  SetLength(FControlTypes, 0);
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageMenuBase.GetXmlType: string;
begin
  Result := 'menu';
end;

function TadxBackstageMenuBase.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
  else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
end;

function TadxBackstageMenuBase.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageMenuBase.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

{ TadxBackstagePrimaryMenu }

constructor TadxBackstagePrimaryMenu.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstagePrimaryMenu' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstagePrimaryMenu then Inc(Count);
    FCaption := 'adxBackstagePrimaryMenu' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstagePrimaryMenu.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
end;

function TadxBackstagePrimaryMenu.GetType: TadxRibbonControlType;
begin
  Result := rctBackstagePrimaryMenu;
end;

{ TadxBackstageSubMenu }

constructor TadxBackstageSubMenu.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageSubMenu' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageSubMenu then Inc(Count);
    FCaption := 'adxBackstageSubMenu' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageSubMenu.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  Result.Values['getDescription'] := 'GetDescription_Callback';
end;

function TadxBackstageSubMenu.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageSubMenu;
end;

{ TadxBackstageCheckBoxBase }

procedure TadxBackstageCheckBoxBase.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxBackstageCheckBoxBase.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  Result.Values['getPressed'] := 'GetPressed_Callback';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  Result.Values['onAction'] := 'OnActionState_Callback';
end;

{ TadxBackstageCheckBox }

constructor TadxBackstageCheckBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FExpand := ceNeither;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageCheckBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageCheckBox then Inc(Count);
    FCaption := 'adxBackstageCheckBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageCheckBox.GetXmlType: string;
begin
  Result := 'checkBox';
end;

function TadxBackstageCheckBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  Result.Values['getDescription'] := 'GetDescription_Callback';
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
end;

function TadxBackstageCheckBox.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageCheckBox;
end;

{ TadxBackstageMenuCheckBox }

constructor TadxBackstageMenuCheckBox.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageMenuCheckBox' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageMenuCheckBox then Inc(Count);
    FCaption := 'adxBackstageMenuCheckBox' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageMenuCheckBox.GetXmlType: string;
begin
  Result := 'checkBox';
end;

function TadxBackstageMenuCheckBox.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  Result.Values['getDescription'] := 'GetDescription_Callback';
end;

function TadxBackstageMenuCheckBox.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageMenuCheckBox;
end;

{ TadxBackstageMenuToggleButton }

constructor TadxBackstageMenuToggleButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID <> '') then begin
    if Assigned(TadxCOMAddInModule(ARoot.Owner).FRibbonControls) then begin
      i := TadxCOMAddInModule(ARoot.Owner).FRibbonControls.IndexOfObject(Self);
      if i >= 0 then begin
        TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Delete(i);
        FID := '';
      end;
    end;
  end;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageMenuToggleButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageMenuToggleButton then Inc(Count);
    FCaption := 'adxBackstageMenuToggleButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageMenuToggleButton.GetXmlType: string;
begin
  Result := 'toggleButton';
end;

function TadxBackstageMenuToggleButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
  else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
end;

function TadxBackstageMenuToggleButton.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageMenuToggleButton;
end;

{ TadxBackstageButtonBase }

procedure TadxBackstageButtonBase.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxBackstageButtonBase.GetXmlType: string;
begin
  Result := 'button'; 
end;

function TadxBackstageButtonBase.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
    Result.Values['idQ'] := adxDefaultNS + ':' + FID
  else
    Result.Values['id'] := FID;
  if FIsDefinitive then Result.Values['isDefinitive'] := 'true'
  else Result.Values['isDefinitive'] := 'false';
  Result.Values['getEnabled'] := 'GetEnabled_Callback';
  Result.Values['getLabel'] := 'GetLabel_Callback';
  Result.Values['getVisible'] := 'GetVisible_Callback';
  Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
  else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
  Result.Values['onAction'] := 'OnActionCommon_Callback';
end;

{ TadxBackstageFastCommandButton }

constructor TadxBackstageFastCommandButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageFastCommandButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageFastCommandButton then Inc(Count);
    FCaption := 'adxBackstageFastCommandButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageFastCommandButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := TStringList.Create;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
    else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getEnabled'] := 'GetEnabled_Callback';

    Result.Values['onAction'] := 'OnActionCommon_Callback';
    if FIsDefinitive then Result.Values['isDefinitive'] := 'true'
    else Result.Values['isDefinitive'] := 'false';
    Result.Values['getVisible'] := 'GetVisible_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageFastCommandButton.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageFastCommandButton;
end;

{ TadxBackstageMenuButton }

constructor TadxBackstageMenuButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageMenuButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageMenuButton then Inc(Count);
    FCaption := 'adxBackstageMenuButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageMenuButton.GetXmlType: string;
begin
  Result := 'button';
end;

function TadxBackstageMenuButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  Result.Values['getDescription'] := 'GetDescription_Callback';
end;

function TadxBackstageMenuButton.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageMenuButton;
end;

{ TadxBackstageRegularButton }

constructor TadxBackstageRegularButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageRegularButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageRegularButton then Inc(Count);
    FCaption := 'adxBackstageRegularButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageRegularButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  Result.Values['getSupertip'] := 'GetSuperTip_Callback';
  Result.Values['getScreentip'] := 'GetScreenTip_Callback';
end;

function TadxBackstageRegularButton.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageRegularButton;
end;

{ TadxBackstageGroupButton }

constructor TadxBackstageGroupButton.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FExpand := ceNeither;
  FStyle := gbsNormal;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID <> '') then begin
    if Assigned(TadxCOMAddInModule(ARoot.Owner).FRibbonControls) then begin
      i := TadxCOMAddInModule(ARoot.Owner).FRibbonControls.IndexOfObject(Self);
      if i >= 0 then begin
        TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Delete(i);
        FID := '';
      end;
    end;
  end;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageGroupButton' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageGroupButton then Inc(Count);
    FCaption := 'adxBackstageGroupButton' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

function TadxBackstageGroupButton.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
const
  constStyles: array [TadxBackstageGroupButtonStyle] of string =
    ('normal', 'borderless', 'large');
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  Result.Values['expand'] := constExpands[FExpand];
  Result.Values['style'] := constStyles[FStyle];
end;

function TadxBackstageGroupButton.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageGroupButton;
end;

{ TadxBackstageTaskFormGroup }

constructor TadxBackstageTaskFormGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FAllowedTaskSizes := [tsSmall, tsMedium, tsLarge];
  FControls := TadxRibbonControls.Create(Self, TadxBackstageTaskFormGroupCategory, 100);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskFormGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskFormGroup then Inc(Count);
    FCaption := 'adxBackstageTaskFormGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTaskFormGroup.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageTaskFormGroup.GetXmlType: string;
begin
  Result := 'taskFormGroup';
end;

function TadxBackstageTaskFormGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;

  function AllowedTaskSizeStr(Value: TadxBackstageAllowedTaskSizes): string;
  begin
    if Value = [tsSmall, tsMedium, tsLarge] then Result := 'largeMediumSmall'
    else
    if Value = [tsMedium, tsLarge] then Result := 'largeMedium'
    else
    if Value = [tsLarge] then Result := 'large'
    else
    if Value = [tsSmall, tsMedium] then Result := 'mediumSmall'
    else
    if Value = [tsMedium] then Result := 'medium'
    else
      Result := 'small';
  end;

begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FHelperText <> '' then Result.Values['helperText'] := FHelperText;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    Result.Values['allowedTaskSizes'] := AllowedTaskSizeStr(FAllowedTaskSizes);
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
    Result.Values['getHelperText'] := 'GetHelperText_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['allowedTaskSizes'] := AllowedTaskSizeStr(FAllowedTaskSizes);
  end;
end;

function TadxBackstageTaskFormGroup.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskFormGroup;
end;

function TadxBackstageTaskFormGroup.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageTaskFormGroup.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxBackstageTaskFormGroup.SetAllowedTaskSizes(Value: TadxBackstageAllowedTaskSizes);
begin
  if (Value <> []) and (Value <> [tsSmall, tsLarge]) then
    FAllowedTaskSizes := Value;
end;

{ TadxBackstageTaskFormGroupCategory }

constructor TadxBackstageTaskFormGroupCategory.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxBackstageTaskFormGroupTask, 1000);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskFormGroupCategory' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskFormGroupCategory then Inc(Count);
    FCaption := 'adxBackstageTaskFormGroupCategory' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTaskFormGroupCategory.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageTaskFormGroupCategory.GetXmlType: string;
begin
  Result := 'category';
end;

function TadxBackstageTaskFormGroupCategory.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTaskFormGroupCategory.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskFormGroupCategory;
end;

function TadxBackstageTaskFormGroupCategory.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageTaskFormGroupCategory.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

{ TadxBackstageTaskFormGroupTask }

constructor TadxBackstageTaskFormGroupTask.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxBackstageGroup, 1000);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskFormGroupTask' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskFormGroupTask then Inc(Count);
    FCaption := 'adxBackstageTaskFormGroupTask' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTaskFormGroupTask.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageTaskFormGroupTask.GetXmlType: string;
begin
  Result := 'task';
end;

function TadxBackstageTaskFormGroupTask.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FDescription <> '' then Result.Values['description'] := FDescription;
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;

    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
    else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
    Result.Values['getDescription'] := 'GetDescription_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTaskFormGroupTask.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskFormGroupTask;
end;

function TadxBackstageTaskFormGroupTask.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageTaskFormGroupTask.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

{ TadxBackstageTaskGroup }

constructor TadxBackstageTaskGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FAllowedTaskSizes := [tsSmall, tsMedium, tsLarge];
  FControls := TadxRibbonControls.Create(Self, TadxBackstageTaskGroupCategory, 100);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskGroup then Inc(Count);
    FCaption := 'adxBackstageTaskGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTaskGroup.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageTaskGroup.GetXmlType: string;
begin
  Result := 'taskGroup';
end;

function TadxBackstageTaskGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;

  function AllowedTaskSizeStr(Value: TadxBackstageAllowedTaskSizes): string;
  begin
    if Value = [tsSmall, tsMedium, tsLarge] then Result := 'largeMediumSmall'
    else
    if Value = [tsMedium, tsLarge] then Result := 'largeMedium'
    else
    if Value = [tsLarge] then Result := 'large'
    else
    if Value = [tsSmall, tsMedium] then Result := 'mediumSmall'
    else
    if Value = [tsMedium] then Result := 'medium'
    else
      Result := 'small';
  end;
  
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FHelperText <> '' then Result.Values['helperText'] := FHelperText;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
    Result.Values['allowedTaskSizes'] := AllowedTaskSizeStr(FAllowedTaskSizes);
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
    Result.Values['getHelperText'] := 'GetHelperText_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
    Result.Values['allowedTaskSizes'] := AllowedTaskSizeStr(FAllowedTaskSizes);
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTaskGroup.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskGroup;
end;

function TadxBackstageTaskGroup.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageTaskGroup.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

procedure TadxBackstageTaskGroup.SetAllowedTaskSizes(Value: TadxBackstageAllowedTaskSizes);
begin
  if (Value <> []) and (Value <> [tsSmall, tsLarge]) then
    FAllowedTaskSizes := Value;
end;

{ TadxBackstageTaskGroupCategory }

constructor TadxBackstageTaskGroupCategory.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FControls := TadxRibbonControls.Create(Self, TadxBackstageTaskGroupTask, 1000);
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskGroupCategory' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskGroupCategory then Inc(Count);
    FCaption := 'adxBackstageTaskGroupCategory' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageTaskGroupCategory.Destroy;
begin
  if Assigned(FControls) then FreeAndNil(FControls);
  inherited Destroy;
end;

function TadxBackstageTaskGroupCategory.GetXmlType: string;
begin
  Result := 'category';
end;

function TadxBackstageTaskGroupCategory.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTaskGroupCategory.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskGroupCategory;
end;

function TadxBackstageTaskGroupCategory.GetControls: TadxRibbonControls;
begin
  Result := FControls;
end;

procedure TadxBackstageTaskGroupCategory.SetControls(const Value: TadxRibbonControls);
begin
  FControls.Assign(Value);
end;

{ TadxBackstageTaskGroupTask }

constructor TadxBackstageTaskGroupTask.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  FIsDefinitive := False;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageTaskGroupTask' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageTaskGroupTask then Inc(Count);
    FCaption := 'adxBackstageTaskGroupTask' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

procedure TadxBackstageTaskGroupTask.DoAction(var Args: TadxRibbonActionArguments);
begin
  inherited DoAction(Args);
  FPressed := Args.Pressed;
  if Assigned(FOnClick) and not FInUse then
    try
      FInUse := True;
      try
        FOnClick(Self, Args.Control);
      except
        on E: SysUtils.Exception do TadxCOMAddInModule(GetRoot.Owner).DoError(E);
      end;
    finally
      FInUse := False;
    end;
end;

function TadxBackstageTaskGroupTask.GetXmlType: string;
begin
  Result := 'task';
end;

function TadxBackstageTaskGroupTask.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
begin
  Result := inherited GetAttributes;
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    if FDescription <> '' then Result.Values['description'] := FDescription;
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    if FIsDefinitive then Result.Values['isDefinitive'] := 'true'
    else Result.Values['isDefinitive'] := 'false';
    if (not Glyph.Empty) or (FImageIndex >= 0) then Result.Values['getImage'] := 'GetImage_Callback'
    else if FImageMso <> '' then Result.Values['imageMso'] := FImageMso;
    Result.Values['getEnabled'] := 'GetEnabled_Callback';
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
    Result.Values['getDescription'] := 'GetDescription_Callback';
    Result.Values['getKeytip'] := 'GetKeyTip_Callback';
    Result.Values['onAction'] := 'OnActionCommon_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageTaskGroupTask.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageTaskGroupTask;
end;

{ TadxBackstageGroup }

constructor TadxBackstageGroup.Create(Collection: TCollection);
var
  i, Count: Integer;
  guid: TGUID;
  ARoot: TComponent;
begin
  inherited Create(Collection);
  SetLength(FPrimaryItemTypes, 0);
  SetLength(FTopItemsTypes, 0);
  SetLength(FBottomItemsTypes, 0);
  FPrimaryItem := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1);
  FTopItems := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  FBottomItems := TadxRibbonControls.Create(Self, TadxRibbonCustomControl, 1000);
  FStyle := gsNormal;
  ARoot := GetRoot;
  if (csDesigning in ARoot.ComponentState) and (FID = '') then begin
    CreateGUID(guid);
    FID := 'adxBackstageGroup' + StringReplace(
      StringReplace(StringReplace(GUIDToString(guid), '{', '', []), '}', '', []), '-', '', [rfReplaceAll]);
    Count := 1;
    for i := 0 to TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Count - 1 do
      if TadxCOMAddInModule(ARoot.Owner).FRibbonControls.Objects[i] is TadxBackstageGroup then Inc(Count);
    FCaption := 'adxBackstageGroup' + IntToStr(Count);
  end;
  TadxCOMAddInModule(ARoot.Owner).FRibbonControls.AddObject(FID, Self);
end;

destructor TadxBackstageGroup.Destroy;
begin
  SetLength(FPrimaryItemTypes, 0);
  SetLength(FTopItemsTypes, 0);
  SetLength(FBottomItemsTypes, 0);
  if Assigned(FPrimaryItem) then FreeAndNil(FPrimaryItem);
  if Assigned(FTopItems) then FreeAndNil(FTopItems);
  if Assigned(FBottomItems) then FreeAndNil(FBottomItems);
  inherited Destroy;
end;

function TadxBackstageGroup.GetXmlType: string;
begin
  Result := 'group';
end;

function TadxBackstageGroup.GetAttributes(ContextMenuIndex: Integer = 0): TStringList;
const
  GroupStyleStr: array [TadxBackstageGroupStyle] of string = ('normal', 'warning', 'error');
begin
  Result := inherited GetAttributes(ContextMenuIndex);
  if FIDMso <> '' then begin
    Result.Values['idMso'] := FIDMso;

    if FCaption <> '' then Result.Values['label'] := FCaption;
    if FVisible then Result.Values['visible'] := 'true'
    else Result.Values['visible'] := 'false';
    Result.Values['style'] := GroupStyleStr[FStyle];
    if FHelperText <> '' then Result.Values['helperText'] := FHelperText;
    if FShowCaption then Result.Values['showLabel'] := 'true'
    else Result.Values['showLabel'] := 'false';
  end
  else begin
    if TadxCOMAddInModule(GetRoot.Owner).Namespace <> '' then
      Result.Values['idQ'] := adxDefaultNS + ':' + FID
    else
      Result.Values['id'] := FID;
    Result.Values['getLabel'] := 'GetLabel_Callback';
    Result.Values['getVisible'] := 'GetVisible_Callback';
    Result.Values['getStyle'] := 'GetStyle_Callback';
    Result.Values['getHelperText'] := 'GetHelperText_Callback';
    Result.Values['getShowLabel'] := 'GetShowLabel_Callback';
  end;
  if FInsertAfterIdMso <> '' then Result.Values['insertAfterMso'] := FInsertAfterIdMso
  else
  if FInsertBeforeIdMso <> '' then Result.Values['insertBeforeMso'] := FInsertBeforeIdMso
  else
  if FInsertAfterId <> '' then Result.Values['insertAfterQ'] := FInsertAfterId
  else
  if FInsertBeforeId <> '' then Result.Values['insertBeforeQ'] := FInsertBeforeId;
end;

function TadxBackstageGroup.GetType: TadxRibbonControlType;
begin
  Result := rctBackstageGroup;
end;

function TadxBackstageGroup.GetPrimaryItem: TadxRibbonControls;
begin
  Result := FPrimaryItem;
end;

function TadxBackstageGroup.GetTopItems: TadxRibbonControls;
begin
  Result := FTopItems;
end;

function TadxBackstageGroup.GetBottomItems: TadxRibbonControls;
begin
  Result := FBottomItems;
end;

function TadxBackstageGroup.GetGroupStyle: WideString;
begin
  Result := IntToStr(Integer(FStyle));
end;

procedure TadxBackstageGroup.SetPrimaryItem(const Value: TadxRibbonControls);
begin
  FPrimaryItem.Assign(Value);
end;

procedure TadxBackstageGroup.SetTopItems(const Value: TadxRibbonControls);
begin
  FTopItems.Assign(Value);
end;

procedure TadxBackstageGroup.SetBottomItems(const Value: TadxRibbonControls);
begin
  FBottomItems.Assign(Value);
end;

procedure TadxBackstageGroup.SetStyle(Value: TadxBackstageGroupStyle);
begin
  if FStyle <> Value then begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TadxBackstageGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('PrimaryItemTypes', ReadPrimaryItemTypes, WritePrimaryItemTypes, True);
  Filer.DefineBinaryProperty('TopItemsTypes', ReadTopItemsTypes, WriteTopItemsTypes, True);
  Filer.DefineBinaryProperty('BottomItemsTypes', ReadBottomItemsTypes, WriteBottomItemsTypes, True);
  Filer.DefineProperty('PrimaryItemControls', ReadPrimaryItemControls, WritePrimaryItemControls, True);
  Filer.DefineProperty('TopItemsControls', ReadTopItemsControls, WriteTopItemsControls, True);
  Filer.DefineProperty('BottomItemsControls', ReadBottomItemsControls, WriteBottomItemsControls, True);
end;

procedure TadxBackstageGroup.WritePrimaryItemTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FPrimaryItemTypes, PrimaryItem.Count);
  for i := 0 to PrimaryItem.Count - 1 do
    FPrimaryItemTypes[i] := Integer(PrimaryItem[i].GetType);
  i := PrimaryItem.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if PrimaryItem.Count > 0 then
    Stream.WriteBuffer(FPrimaryItemTypes[0], PrimaryItem.Count * SizeOf(Integer));
end;

procedure TadxBackstageGroup.ReadPrimaryItemTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FPrimaryItemTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FPrimaryItemTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageGroup.WriteTopItemsTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FTopItemsTypes, TopItems.Count);
  for i := 0 to TopItems.Count - 1 do
    FTopItemsTypes[i] := Integer(TopItems[i].GetType);
  i := TopItems.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if TopItems.Count > 0 then
    Stream.WriteBuffer(FTopItemsTypes[0], TopItems.Count * SizeOf(Integer));
end;

procedure TadxBackstageGroup.ReadTopItemsTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FTopItemsTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FTopItemsTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageGroup.WriteBottomItemsTypes(Stream: TStream);
var
  i: Integer;
begin
  SetLength(FBottomItemsTypes, BottomItems.Count);
  for i := 0 to BottomItems.Count - 1 do
    FBottomItemsTypes[i] := Integer(BottomItems[i].GetType);
  i := BottomItems.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  if BottomItems.Count > 0 then
    Stream.WriteBuffer(FBottomItemsTypes[0], BottomItems.Count * SizeOf(Integer));
end;

procedure TadxBackstageGroup.ReadBottomItemsTypes(Stream: TStream);
var
  i: Integer;
begin
  Stream.ReadBuffer(i, SizeOf(i));
  SetLength(FBottomItemsTypes, i);
  if i > 0 then
    Stream.ReadBuffer(FBottomItemsTypes[0], i * SizeOf(Integer));
end;

procedure TadxBackstageGroup.WritePrimaryItemControls(Writer: TWriter);
begin
  Writer.WriteCollection(PrimaryItem);
end;

procedure TadxBackstageGroup.ReadPrimaryItemControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  PrimaryItem.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    PrimaryItem.BeginUpdate;
    try
      if not EndOfList then PrimaryItem.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := PrimaryItem.Add(TadxRibbonControlType(FPrimaryItemTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      PrimaryItem.EndUpdate;
    end;
  end;
end;

procedure TadxBackstageGroup.WriteTopItemsControls(Writer: TWriter);
begin
  Writer.WriteCollection(TopItems);
end;

procedure TadxBackstageGroup.ReadTopItemsControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  TopItems.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    TopItems.BeginUpdate;
    try
      if not EndOfList then TopItems.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := TopItems.Add(TadxRibbonControlType(FTopItemsTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      TopItems.EndUpdate;
    end;
  end;
end;

procedure TadxBackstageGroup.WriteBottomItemsControls(Writer: TWriter);
begin
  Writer.WriteCollection(BottomItems);
end;

procedure TadxBackstageGroup.ReadBottomItemsControls(Reader: TReader);
var
  i: Integer;
  Item: TPersistent;
begin
  i := 0;
  BottomItems.Clear;
  with TAccessReader(TReader(Reader)) do begin
    ReadValue; // vaCollection sign
    BottomItems.BeginUpdate;
    try
      if not EndOfList then BottomItems.Clear;
      while not EndOfList do
      begin
        if NextValue in [vaInt8, vaInt16, vaInt32] then ReadInteger;
        Item := BottomItems.Add(TadxRibbonControlType(FBottomItemsTypes[i]));
        Inc(i);
        ReadListBegin;
        while not EndOfList do ReadProperty(Item);
        ReadListEnd;
      end;
      ReadListEnd;
    finally
      BottomItems.EndUpdate;
    end;
  end;
end;

// Outlook 2010 Solutions Module

{ TadxOLSolutionFolder }

constructor TadxOLSolutionFolder.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FInterface := nil;
  FGlyph := TBitmap.Create;
  FGlyphTransparentColor := clDefault;
  FFolders := TadxOLSolutionFolders.Create(Self, TadxOLSolutionFolder);
  if FFolderName = '' then
    FFolderName := 'Folder ' + IntToStr(Self.Index + 1);
end;

destructor TadxOLSolutionFolder.Destroy;
begin
  FFolders.Free;
  FInterface := nil;
  FGlyph.Free;
  inherited Destroy;
end;

procedure TadxOLSolutionFolder.Assign(Source: TPersistent);
begin
  if Source is TadxOLSolutionFolder then begin
    FolderName := TadxOLSolutionFolder(Source).FolderName;
    FolderType := TadxOLSolutionFolder(Source).FolderType;
    Folders := TadxOLSolutionFolder(Source).Folders;
    Glyph := TadxOLSolutionFolder(Source).Glyph;
    GlyphTransparentColor := TadxOLSolutionFolder(Source).GlyphTransparentColor;
  end
  else
    inherited Assign(Source);
end;

function TadxOLSolutionFolder.GetDisplayName: string;
begin
  Result := '(' + ClassName + ')';
  if FFolderName <> '' then Result := FFolderName + ' ' + Result;
end;

function TadxOLSolutionFolder.GetDefaultInterface: MAPIFolder;
var
  IParent: Outlook2000.MAPIFolder;
begin
  if not Assigned(FInterface) then begin
    try
      if TadxOLSolutionFolders(Self.Collection).GetOwner is TadxOLSolutionModule then
        IParent := TadxOLSolutionModule(TadxOLSolutionFolders(Self.Collection).GetOwner).FParentFolder
      else
        IParent := TadxOLSolutionFolder(TadxOLSolutionFolders(Self.Collection).GetOwner).DefaultInterface;
    except
      IParent := nil;
    end;
    if Assigned(IParent) then
      try
        FInterface := IParent.Folders.Item(Self.FFolderName);
      except
        FInterface := nil;
      end;
  end;
  Result := FInterface;
end;

procedure TadxOLSolutionFolder.Install;
const
  OutlookFolderType: array [TadxTadxOLSolutionModuleFolderType] of Integer =
    (olFolderInbox, olFolderCalendar, olFolderContacts, olFolderJournal,
     olFolderNotes, olFolderTasks, olFolderDrafts);

var
  i: Integer;
  IParent: Outlook2000.MAPIFolder;
  Pict: IPictureDisp;
  PictureDesc: TPictDesc;
begin
  try
    if TadxOLSolutionFolders(Self.Collection).GetOwner is TadxOLSolutionModule then
      IParent := TadxOLSolutionModule(TadxOLSolutionFolders(Self.Collection).GetOwner).FParentFolder
    else
      IParent := TadxOLSolutionFolder(TadxOLSolutionFolders(Self.Collection).GetOwner).DefaultInterface;
  except
    IParent := nil;
  end;
  if Assigned(IParent) then begin
    try
      FInterface := IParent.Folders.Item(Self.FFolderName);
    except
      FInterface := nil;
    end;
    if FInterface = nil then
      try
        FInterface := IParent.Folders.Add(Self.FFolderName, OutlookFolderType[Self.FFolderType]);
      except
        FInterface := nil;
      end;
    if Assigned(FInterface) then begin
      try
        if FInterface.Name <> FFolderName then
          FInterface.Name := FFolderName;
      except
      end;
      if not Self.Glyph.Empty then
        try
          FGlyph.TransparentColor := GlyphTransparentColor;
          PictureDesc.cbSizeofstruct := SizeOf(PictureDesc);
          PictureDesc.picType := PICTYPE_BITMAP;
          PictureDesc.hbitmap := FGlyph.Handle;
          PictureDesc.hpal := FGlyph.Palette;
          OleCreatePictureIndirect(PictureDesc, ActiveX.IPicture, False, Pict);
          OleVariant(FInterface).SetCustomIcon(Pict);
        finally
          Pict := nil;
        end;
      for i := 0 to Self.Folders.Count - 1 do
        Self.Folders[i].Install;
    end;
  end;
end;

procedure TadxOLSolutionFolder.SetFolders(const Value: TadxOLSolutionFolders);
begin
  FFolders.Assign(Value);
end;

procedure TadxOLSolutionFolder.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

{ TadxOLSolutionFolders }

procedure TadxOLSolutionFolders.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TadxOLSolutionFolders then begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TadxOLSolutionFolders(Source).Count - 1 do
        Add().Assign(TadxOLSolutionFolders(Source)[i]);
    finally
      EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

function TadxOLSolutionFolders.GetOwner: TPersistent;
begin
  Result := inherited GetOwner;
end;

function TadxOLSolutionFolders.GetItem(Index: Integer): TadxOLSolutionFolder;
begin
  Result := TadxOLSolutionFolder(inherited Items[Index]);
end;

procedure TadxOLSolutionFolders.SetItem(Index: Integer; Value: TadxOLSolutionFolder);
begin
  inherited Items[Index] := Value;
end;

{ TadxOLSolutionModule }

constructor TadxOLSolutionModule.Create(AOwner: TComponent);
begin
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCOMAddInModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  inherited Create(AOwner);
  FParentFolder := nil;
  FNavigationPaneDisplayedModuleCount := -1;
  FNavigationPanePosition := -1;
  FVisible := True;
  FOwner := AOwner as TadxCOMAddInModule;
  FFolders := TadxOLSolutionFolders.Create(Self, TadxOLSolutionFolder);
end;

destructor TadxOLSolutionModule.Destroy;
begin
  FParentFolder := nil;
  FFolders.Free;
  FOwner := nil;
  inherited Destroy;
end;

type
  _SolutionsModule = interface(IDispatch)
    ['{000630FF-0000-0000-C000-000000000046}']
    function Get_Application: _Application; safecall;
    function Get_Class_: OlObjectClass; safecall;
    function Get_Session: _NameSpace; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_NavigationModuleType: TOleEnum; safecall;
    function Get_Name: WideString; safecall;
    function Get_Position: Integer; safecall;
    procedure Set_Position(Position: Integer); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Visible: WordBool); safecall;
    procedure AddSolution(const Solution: MAPIFolder; Scope: TOleEnum); safecall;
    property Application: _Application read Get_Application;
    property Class_: OlObjectClass read Get_Class_;
    property Session: _NameSpace read Get_Session;
    property Parent: IDispatch read Get_Parent;
    property NavigationModuleType: TOleEnum read Get_NavigationModuleType;
    property Name: WideString read Get_Name;
    property Position: Integer read Get_Position write Set_Position;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

procedure TadxOLSolutionModule.Install;
var
  i: Integer;
  INameSpace: Outlook2000._NameSpace;
  IInbox: Outlook2000.MAPIFolder;
  IExplorer: Outlook2000._Explorer;
  NavPane: OLEVariant;
  SolutionsModule: _SolutionsModule;
begin
  if Assigned(FOnParentFolderRequest) then
    try
      FOnParentFolderRequest(Self, FParentFolder);
    except
      on E: SysUtils.Exception do FOwner.DoError(E);
    end;
  if FParentFolder = nil then begin
    INameSpace := FOwner.OutlookApp.GetNamespace('MAPI');
    if Assigned(INameSpace) then
      try
        IInbox := INameSpace.GetDefaultFolder(olFolderInbox);
        if Assigned(IInbox) then
          try
            try
              FParentFolder := IInbox.Parent as Outlook2000.MAPIFolder;
            except
              FParentFolder := nil;
            end;
          finally
            IInbox := nil;
          end;
      finally
        INameSpace := nil;
      end;
  end;
  if Assigned(FParentFolder) then begin
    // add folders, set Names and icons
    for i := 0 to Self.Folders.Count - 1 do
      Self.Folders[i].Install;
    // navigation pane
    try
      IExplorer := FOwner.OutlookApp.ActiveExplorer();
      if Assigned(IExplorer) then
        try
          NavPane := OleVariant(IExplorer).NavigationPane;
          SolutionsModule := IDispatch(NavPane.Modules.GetNavigationModule(8)) as _SolutionsModule; // olModuleSolutions = 8
          if Assigned(SolutionsModule) then
            try
              SolutionsModule.AddSolution(Self.Folders[0].DefaultInterface, 0); // olHideInDefaultModules = 0
              // set the visibility of the SolutionsModule
              SolutionsModule.Visible := FVisible;
              // set the position of the SolutionsModule
              if FNavigationPanePosition > -1 then
                SolutionsModule.Position := FNavigationPanePosition;
            finally
              SolutionsModule := nil;
            end;
          if FNavigationPaneDisplayedModuleCount > -1 then
            NavPane.DisplayedModuleCount := FNavigationPaneDisplayedModuleCount;
        finally
          IExplorer := nil;
        end;
    except
    end;
  end;
end;

procedure TadxOLSolutionModule.SetFolders(const Value: TadxOLSolutionFolders);
begin
  FFolders.Assign(Value);
end;

// register to HKCU\Software\Classes\

function CheckConfigSection(): boolean;
var
  Buffer: array [0..MAX_PATH + 1] of Char;
  FileName: string;
  IniFile: TIniFile;
begin
  Result := False;
  {$IFDEF UNICODE}
  SetString(FileName, Buffer, Windows.GetModuleFileName(HInstance, Buffer, Length(Buffer)));
  {$ELSE}
  SetString(FileName, Buffer, Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer)));
  {$ENDIF}
  FileName := ChangeFileExt(FileName, '.ini');
  if FileExists(FileName) then begin
    IniFile := TIniFile.Create(FileName);
    try
      if IniFile.SectionExists('CONFIG') then
        Result := UpperCase(IniFile.ReadString('CONFIG', 'PRIVILEGES', '')) = 'USER';
    finally
      IniFile.Free;
    end;
  end;
end;

{$IFDEF ADX_VCL5}

procedure CreateRegKey(const Key, ValueName, Value: string; RootKey: DWord = HKEY_CLASSES_ROOT);
var
  Handle: HKey;
  Status, Disposition: Integer;
begin
  Status := RegCreateKeyEx(RootKey, PChar(Key), 0, '',
    REG_OPTION_NON_VOLATILE, KEY_READ or KEY_WRITE, nil, Handle,
    @Disposition);
  if Status = 0 then
  begin
    Status := RegSetValueEx(Handle, PChar(ValueName), 0, REG_SZ,
      PChar(Value), Length(Value) + 1);
    RegCloseKey(Handle);
  end;
  if Status <> 0 then raise EOleRegistrationError.Create('Error creating system registry entry');
end;

procedure DeleteRegKey(const Key: string; RootKey: DWord = HKEY_CLASSES_ROOT);
begin
  RegDeleteKey(RootKey, PChar(Key));
end;

{$ENDIF}

procedure UpdateComObjectFactory(Factory: TComObjectFactory; Register: boolean);
const
  ThreadStrs: array[TThreadingModel] of string =
{$IFDEF ADX_VCL5}
    ('', 'Apartment', 'Free', 'Both');
{$ELSE}
    ('', 'Apartment', 'Free', 'Both', 'Neutral');
{$ENDIF}
var
  LocalClassID, ServerKeyName, ShortFileName: string;
begin
  if Register then begin
    LocalClassID := GUIDToString(Factory.ClassID);
    ServerKeyName := 'Software\Classes\' + 'CLSID\' + LocalClassID + '\' + Factory.ComServer.ServerKey;

    CreateRegKey('Software\Classes\' + 'CLSID\' + LocalClassID, '', Factory.Description, HKEY_CURRENT_USER);
    ShortFileName := Factory.ComServer.ServerFileName;
    if AnsiPos(' ', ShortFileName) <> 0 then
      ShortFileName := ExtractShortPathName(ShortFileName);
    CreateRegKey(ServerKeyName, '', ShortFileName, HKEY_CURRENT_USER);
    if (Factory.ThreadingModel <> tmSingle) and IsLibrary then
      CreateRegKey(ServerKeyName, 'ThreadingModel', ThreadStrs[Factory.ThreadingModel], HKEY_CURRENT_USER);
    if Factory.ProgID <> '' then begin
      CreateRegKey('Software\Classes\' + Factory.ProgID, '', Factory.Description, HKEY_CURRENT_USER);
      CreateRegKey('Software\Classes\' + Factory.ProgID + '\Clsid', '', LocalClassID, HKEY_CURRENT_USER);
      CreateRegKey('Software\Classes\' + 'CLSID\' + LocalClassID + '\ProgID', '', Factory.ProgID, HKEY_CURRENT_USER);
    end;
  end else begin
    LocalClassID := GUIDToString(Factory.ClassID);
    ServerKeyName := 'Software\Classes\' + 'CLSID\' + LocalClassID + '\' + Factory.ComServer.ServerKey;
    if Factory.ProgID <> '' then begin
      DeleteRegKey('Software\Classes\' + 'CLSID\' + LocalClassID + '\ProgID', HKEY_CURRENT_USER);
      DeleteRegKey('Software\Classes\' + Factory.ProgID + '\Clsid', HKEY_CURRENT_USER);
      DeleteRegKey('Software\Classes\' + Factory.ProgID, HKEY_CURRENT_USER);
    end;
    DeleteRegKey(ServerKeyName, HKEY_CURRENT_USER);
    DeleteRegKey('Software\Classes\' + 'CLSID\' + LocalClassID, HKEY_CURRENT_USER);
  end
end;

procedure UpdateTypedComObjectFactory(Factory: TTypedComObjectFactory; Register: boolean);
var
  ClassKey: string;
  TLibAttr: PTLibAttr;
begin
  ClassKey := 'CLSID\' + GUIDToString(Factory.ClassID);
  if Register then begin
    OleCheck(Factory.ComServer.TypeLib.GetLibAttr(TLibAttr));
    try
      CreateRegKey('Software\Classes\' + ClassKey + '\Version', '', Format('%d.%d', [TLibAttr.wMajorVerNum, TLibAttr.wMinorVerNum]), HKEY_CURRENT_USER);
      CreateRegKey('Software\Classes\' + ClassKey + '\TypeLib', '', GUIDToString(TLibAttr.guid), HKEY_CURRENT_USER);
    finally
      Factory.ComServer.TypeLib.ReleaseTLibAttr(TLibAttr);
    end;
  end else begin
    DeleteRegKey('Software\Classes\' + ClassKey + '\TypeLib', HKEY_CURRENT_USER);
    DeleteRegKey('Software\Classes\' + ClassKey + '\Version', HKEY_CURRENT_USER);
  end;
end;

procedure UpdateActiveXControlFactory(Factory: TActiveXControlFactory; Register: boolean);
var
  ClassKey: string;
begin
  ClassKey := 'Software\Classes\' + 'CLSID\' + GUIDToString(Factory.ClassID);
  if Register then begin
    CreateRegKey(ClassKey + '\MiscStatus', '', '0', HKEY_CURRENT_USER);
    CreateRegKey(ClassKey + '\MiscStatus\1', '', IntToStr(Factory.MiscStatus), HKEY_CURRENT_USER);
    CreateRegKey(ClassKey + '\ToolboxBitmap32', '',  Factory.ComServer.ServerFileName + ',' + IntToStr(Factory.ToolboxBitmapID), HKEY_CURRENT_USER);
    CreateRegKey(ClassKey + '\Control', '', '', HKEY_CURRENT_USER);
    CreateRegKey(ClassKey + '\Verb', '', '', HKEY_CURRENT_USER);
    CreateRegKey(ClassKey + '\Verb\' + IntToStr(OLEIVERB_PRIMARY), '', SPropertiesVerb + ',0,2', HKEY_CURRENT_USER);
  end else begin
    DeleteRegKey(ClassKey + '\Verb\' + IntToStr(OLEIVERB_PRIMARY), HKEY_CURRENT_USER);
    DeleteRegKey(ClassKey + '\Verb', HKEY_CURRENT_USER);
    DeleteRegKey(ClassKey + '\Control', HKEY_CURRENT_USER);
    DeleteRegKey(ClassKey + '\ToolboxBitmap32', HKEY_CURRENT_USER);
    DeleteRegKey(ClassKey + '\MiscStatus\1', HKEY_CURRENT_USER);
    DeleteRegKey(ClassKey + '\MiscStatus', HKEY_CURRENT_USER);
  end;
end;

procedure UpdateFactory(Factory: TComObjectFactory; Register: boolean);
begin
  if Factory.Instancing = ciInternal then Exit;
  if Register then begin
    UpdateComObjectFactory(Factory, Register);
    if Factory is TTypedComObjectFactory then
      UpdateTypedComObjectFactory(TTypedComObjectFactory(Factory), Register);
    if Factory is TActiveXControlFactory then
      UpdateActiveXControlFactory(TActiveXControlFactory(Factory), Register);
    if Factory is TadxFactory then TadxFactory(Factory).UpdateRegistry(Register);
    // Case #913
    if Factory is TadxRecognizerFactory then TadxRecognizerFactory(Factory).UpdateRegistry(Register);
  end else begin
    // Case #913
    if Factory is TadxRecognizerFactory then TadxRecognizerFactory(Factory).UpdateRegistry(Register);
    if Factory is TadxFactory then TadxFactory(Factory).UpdateRegistry(Register);
    if Factory is TActiveXControlFactory then
      UpdateActiveXControlFactory(TActiveXControlFactory(Factory), Register);
    if Factory is TTypedComObjectFactory then
      UpdateTypedComObjectFactory(TTypedComObjectFactory(Factory), Register);
    UpdateComObjectFactory(Factory, Register);
  end;
end;

initialization
  WM_ADXKEYDOWN := RegisterWindowMessage('WM_ADXKEYDOWN');
  EventSyncFlag := false;

end.
