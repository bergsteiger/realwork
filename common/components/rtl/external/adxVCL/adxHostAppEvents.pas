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

unit adxHostAppEvents;

{$I adxDefs.inc}

interface

uses Windows, SysUtils, Classes, ActiveX, ComObj, OleServer,
  Office2000, Outlook2000, Excel2000, Word2000, Project2000, MSPPt2000,
  FrontPage2000, Visio2002, MapPoint2002, Publisher2003, InfoPath2007;

type
  TadxCustomEvents = class;

  TadxEventDispatch = class(TObject, IUnknown, IDispatch)
  private
    FServer: TadxCustomEvents;
    InternalRefCount: Integer;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    function ServerDisconnect: boolean;
  protected
  public
    constructor Create(Server: TadxCustomEvents);
  end;

  TadxCustomEvents = class(TComponent, IUnknown)
  private
    FServerData: PServerData;
    FRefCount: Longint;
    FEventDispatch: TadxEventDispatch;
    FEventsConnection: Longint;
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure InitServerData; virtual; abstract;
    procedure ConnectEvents(const Obj: IUnknown);
    procedure DisconnectEvents(const Obj: Iunknown);
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); virtual;
    property ServerData: PServerData read FServerData write FServerData;
    property EventDispatch: TadxEventDispatch read FEventDispatch write FEventDispatch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(AIntf: IDispatch); overload; virtual; abstract;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); overload; virtual; abstract;
    procedure Disconnect; virtual; abstract;
  published
  end;

  TadxCustomEventsClass = class of TadxCustomEvents;

  TadxOutlookApplicationItemSend = procedure(ASender: TObject; const Item: IDispatch;
    var Cancel: WordBool) of object;
  TadxOutlookApplicationReminder = procedure(ASender: TObject; const Item: IDispatch) of object;
  TadxOutlookApplicationOptionsPagesAdd = procedure(ASender: TObject; const Pages: PropertyPages) of object;
  TadxOutlookApplicationAdvancedSearchComplete = procedure(ASender: TObject; const SearchObject: IDispatch) of object;
  TadxOutlookApplicationAdvancedSearchStopped = procedure(ASender: TObject; const SearchObject: IDispatch) of object;
  TadxOutlookApplicationNewMailEx = procedure(ASender: TObject; const EntryIDCollection: WideString) of object;
  TadxOutlookNameSpaceOptionsPagesAdd = procedure(ASender: TObject; const Pages: PropertyPages;
    const Folder: MAPIFolder) of object;
  TadxOutlookInspectorsNewExplorer = procedure(ASender: TObject; const Explorer: _Explorer) of object;
  TadxOutlookInspectorsNewInspector = procedure(ASender: TObject; const Inspector: _Inspector) of object;
  TadxOutlookRemindersBeforeReminderShow = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookRemindersReminderAdd = procedure(ASender: TObject; const ReminderObject: IDispatch) of object;
  TadxOutlookRemindersReminderChange = procedure(ASender: TObject; const ReminderObject: IDispatch) of object;
  TadxOutlookRemindersReminderFire = procedure(ASender: TObject; const ReminderObject: IDispatch) of object;
  TadxOutlookRemindersSnooze = procedure(ASender: TObject; const ReminderObject: IDispatch) of object;
  TadxOutlookExplorerBeforeFolderSwitch = procedure(ASender: TObject; const NewFolder: IDispatch;
    var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeViewSwitch = procedure(ASender: TObject; NewView: OleVariant; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeMaximize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeMinimize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeMove = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeSize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeItemCopy = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeItemCut = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookExplorerBeforeItemPaste = procedure(ASender: TObject; var ClipboardContent: OleVariant;
    const Target: MAPIFolder; var Cancel: WordBool) of object;
  TadxOutlookInspectorBeforeMaximize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookInspectorBeforeMinimize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookInspectorBeforeMove = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookInspectorBeforeSize = procedure(ASender: TObject; var Cancel: WordBool) of object;
  TadxOutlookInspectorPageChange = procedure(ASender: TObject; var ActivePageName: WideString) of object;

  TadxOutlookApplicationAttachmentContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const Attachments: IDispatch) of object;
  TadxOutlookApplicationViewContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const View: IDispatch) of object;
  TadxOutlookApplicationItemContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const Selection: Outlook2000.Selection) of object;
  TadxOutlookApplicationFolderContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const Folder: MAPIFolder) of object;
  TadxOutlookApplicationStoreContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const Store: IDispatch) of object;
  TadxOutlookApplicationShortcutContextMenuDisplay = procedure(ASender: TObject;
    const CommandBar: CommandBar; const Shortcut: OutlookBarShortcut) of object;
  TadxOutlookApplicationContextMenuClose = procedure(ASender: TObject;
    ContextMenu: Integer{OlContextMenu}) of object;
  TadxOutlookApplicationItemLoad = procedure(ASender: TObject;
    const Item: IDispatch) of object;
  TadxOutlookApplicationBeforeFolderSharingDialog = procedure(ASender: TObject;
    const FolderToShare: MAPIFolder; var Cancel: WordBool) of object;

  TadxOutlookAppEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Application;
    FVersion: string;
    FNameSpaceEvents: TadxCustomEvents;
    FExplorersEvents: TadxCustomEvents;
    FInspectorsEvents: TadxCustomEvents;
    FRemindersEvents: TadxCustomEvents;
    FExplorerEvents: TList;
    FInspectorEvents: TList;
    FOnItemSend: TadxOutlookApplicationItemSend;
    FOnNewMail: TNotifyEvent;
    FOnReminder: TadxOutlookApplicationReminder;
    FOnOptionsPagesAdd: TadxOutlookApplicationOptionsPagesAdd;
    FOnStartup: TNotifyEvent;
    FOnQuit: TNotifyEvent;
    FOnAdvancedSearchComplete: TadxOutlookApplicationAdvancedSearchComplete;
    FOnAdvancedSearchStopped: TadxOutlookApplicationAdvancedSearchStopped;
    FOnMAPILogonComplete: TNotifyEvent;
    FOnNewMailEx: TadxOutlookApplicationNewMailEx;

    FOnAttachmentContextMenuDisplay: TadxOutlookApplicationAttachmentContextMenuDisplay;
    FOnViewContextMenuDisplay: TadxOutlookApplicationViewContextMenuDisplay;
    FOnItemContextMenuDisplay: TadxOutlookApplicationItemContextMenuDisplay;
    FOnFolderContextMenuDisplay: TadxOutlookApplicationFolderContextMenuDisplay;
    FOnStoreContextMenuDisplay: TadxOutlookApplicationStoreContextMenuDisplay;
    FOnShortcutContextMenuDisplay: TadxOutlookApplicationShortcutContextMenuDisplay;
    FOnContextMenuClose: TadxOutlookApplicationContextMenuClose;
    FOnItemLoad: TadxOutlookApplicationItemLoad;
    FOnBeforeFolderSharingDialog: TadxOutlookApplicationBeforeFolderSharingDialog;

    // NameSpace
    FOnNameSpaceOptionsPagesAdd: TadxOutlookNameSpaceOptionsPagesAdd;
    FOnNameSpaceAutoDiscoverComplete: TNotifyEvent;
    // Explorers
    FOnNewExplorer: TadxOutlookInspectorsNewExplorer;
    // Inspectors
    FOnNewInspector: TadxOutlookInspectorsNewInspector;
    // Reminders
    FOnBeforeReminderShow: TadxOutlookRemindersBeforeReminderShow;
    FOnReminderAdd: TadxOutlookRemindersReminderAdd;
    FOnReminderChange: TadxOutlookRemindersReminderChange;
    FOnReminderFire: TadxOutlookRemindersReminderFire;
    FOnReminderRemove: TNotifyEvent;
    FOnSnooze: TadxOutlookRemindersSnooze;
    // Explorer
    FOnExplorerActivate: TNotifyEvent;
    FOnExplorerFolderSwitch: TNotifyEvent;
    FOnExplorerBeforeFolderSwitch: TadxOutlookExplorerBeforeFolderSwitch;
    FOnExplorerViewSwitch: TNotifyEvent;
    FOnExplorerBeforeViewSwitch: TadxOutlookExplorerBeforeViewSwitch;
    FOnExplorerDeactivate: TNotifyEvent;
    FOnExplorerSelectionChange: TNotifyEvent;
    FOnExplorerClose: TNotifyEvent;
    FOnExplorerBeforeMaximize: TadxOutlookExplorerBeforeMaximize;
    FOnExplorerBeforeMinimize: TadxOutlookExplorerBeforeMinimize;
    FOnExplorerBeforeMove: TadxOutlookExplorerBeforeMove;
    FOnExplorerBeforeSize: TadxOutlookExplorerBeforeSize;
    FOnExplorerBeforeItemCopy: TadxOutlookExplorerBeforeItemCopy;
    FOnExplorerBeforeItemCut: TadxOutlookExplorerBeforeItemCut;
    FOnExplorerBeforeItemPaste: TadxOutlookExplorerBeforeItemPaste;
    // Inspector
    FOnInspectorActivate: TNotifyEvent;
    FOnInspectorDeactivate: TNotifyEvent;
    FOnInspectorClose: TNotifyEvent;
    FOnInspectorBeforeMaximize: TadxOutlookInspectorBeforeMaximize;
    FOnInspectorBeforeMinimize: TadxOutlookInspectorBeforeMinimize;
    FOnInspectorBeforeMove: TadxOutlookInspectorBeforeMove;
    FOnInspectorBeforeSize: TadxOutlookInspectorBeforeSize;
    FOnInspectorPageChange: TadxOutlookInspectorPageChange;
    // 2 0 1 0
    FOnExplorerAttachmentSelectionChange: TNotifyEvent; // 64633
    FOnInspectorAttachmentSelectionChange: TNotifyEvent; // 64633
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure DoAttachmentContextMenuDisplay(const CommandBar: CommandBar; const Attachments: IDispatch);
    procedure DoViewContextMenuDisplay(const CommandBar: CommandBar; const View: IDispatch);
    procedure DoItemContextMenuDisplay(const CommandBar: CommandBar; const Selection: Outlook2000.Selection);
    procedure DoFolderContextMenuDisplay(const CommandBar: CommandBar; const Folder: MAPIFolder);
    procedure DoStoreContextMenuDisplay(const CommandBar: CommandBar; const Store: IDispatch);
    procedure DoShortcutContextMenuDisplay(const CommandBar: CommandBar; const Shortcut: OutlookBarShortcut);
    procedure DoContextMenuClose(ContextMenu: Integer{OlContextMenu});
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnItemSend: TadxOutlookApplicationItemSend read FOnItemSend write FOnItemSend;
    property OnNewMail: TNotifyEvent read FOnNewMail write FOnNewMail;
    property OnReminder: TadxOutlookApplicationReminder read FOnReminder write FOnReminder;
    property OnOptionsPagesAdd: TadxOutlookApplicationOptionsPagesAdd read FOnOptionsPagesAdd write FOnOptionsPagesAdd;
    property OnStartup: TNotifyEvent read FOnStartup write FOnStartup;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnAdvancedSearchComplete: TadxOutlookApplicationAdvancedSearchComplete read FOnAdvancedSearchComplete write FOnAdvancedSearchComplete;
    property OnAdvancedSearchStopped: TadxOutlookApplicationAdvancedSearchStopped read FOnAdvancedSearchStopped write FOnAdvancedSearchStopped;
    property OnMAPILogonComplete: TNotifyEvent read FOnMAPILogonComplete write FOnMAPILogonComplete;
    property OnNewMailEx: TadxOutlookApplicationNewMailEx read FOnNewMailEx write FOnNewMailEx;
    property OnNameSpaceOptionsPagesAdd: TadxOutlookNameSpaceOptionsPagesAdd read FOnNameSpaceOptionsPagesAdd write FOnNameSpaceOptionsPagesAdd;
    property OnNewExplorer: TadxOutlookInspectorsNewExplorer read FOnNewExplorer write FOnNewExplorer;
    property OnNewInspector: TadxOutlookInspectorsNewInspector read FOnNewInspector write FOnNewInspector;
    property OnBeforeReminderShow: TadxOutlookRemindersBeforeReminderShow read FOnBeforeReminderShow write FOnBeforeReminderShow;
    property OnReminderAdd: TadxOutlookRemindersReminderAdd read FOnReminderAdd write FOnReminderAdd;
    property OnReminderChange: TadxOutlookRemindersReminderChange read FOnReminderChange write FOnReminderChange;
    property OnReminderFire: TadxOutlookRemindersReminderFire read FOnReminderFire write FOnReminderFire;
    property OnReminderRemove: TNotifyEvent read FOnReminderRemove write FOnReminderRemove;
    property OnSnooze: TadxOutlookRemindersSnooze read FOnSnooze write FOnSnooze;
    property OnExplorerActivate: TNotifyEvent read FOnExplorerActivate write FOnExplorerActivate;
    property OnExplorerFolderSwitch: TNotifyEvent read FOnExplorerFolderSwitch write FOnExplorerFolderSwitch;
    property OnExplorerBeforeFolderSwitch: TadxOutlookExplorerBeforeFolderSwitch read FOnExplorerBeforeFolderSwitch write FOnExplorerBeforeFolderSwitch;
    property OnExplorerViewSwitch: TNotifyEvent read FOnExplorerViewSwitch write FOnExplorerViewSwitch;
    property OnExplorerBeforeViewSwitch: TadxOutlookExplorerBeforeViewSwitch read FOnExplorerBeforeViewSwitch write FOnExplorerBeforeViewSwitch;
    property OnExplorerDeactivate: TNotifyEvent read FOnExplorerDeactivate write FOnExplorerDeactivate;
    property OnExplorerSelectionChange: TNotifyEvent read FOnExplorerSelectionChange write FOnExplorerSelectionChange;
    property OnExplorerClose: TNotifyEvent read FOnExplorerClose write FOnExplorerClose;
    property OnExplorerBeforeMaximize: TadxOutlookExplorerBeforeMaximize read FOnExplorerBeforeMaximize write FOnExplorerBeforeMaximize;
    property OnExplorerBeforeMinimize: TadxOutlookExplorerBeforeMinimize read FOnExplorerBeforeMinimize write FOnExplorerBeforeMinimize;
    property OnExplorerBeforeMove: TadxOutlookExplorerBeforeMove read FOnExplorerBeforeMove write FOnExplorerBeforeMove;
    property OnExplorerBeforeSize: TadxOutlookExplorerBeforeSize read FOnExplorerBeforeSize write FOnExplorerBeforeSize;
    property OnExplorerBeforeItemCopy: TadxOutlookExplorerBeforeItemCopy read FOnExplorerBeforeItemCopy write FOnExplorerBeforeItemCopy;
    property OnExplorerBeforeItemCut: TadxOutlookExplorerBeforeItemCut read FOnExplorerBeforeItemCut write FOnExplorerBeforeItemCut;
    property OnExplorerBeforeItemPaste: TadxOutlookExplorerBeforeItemPaste read FOnExplorerBeforeItemPaste write FOnExplorerBeforeItemPaste;
    property OnInspectorActivate: TNotifyEvent read FOnInspectorActivate write FOnInspectorActivate;
    property OnInspectorDeactivate: TNotifyEvent read FOnInspectorDeactivate write FOnInspectorDeactivate;
    property OnInspectorClose: TNotifyEvent read FOnInspectorClose write FOnInspectorClose;
    property OnInspectorBeforeMaximize: TadxOutlookInspectorBeforeMaximize read FOnInspectorBeforeMaximize write FOnInspectorBeforeMaximize;
    property OnInspectorBeforeMinimize: TadxOutlookInspectorBeforeMinimize read FOnInspectorBeforeMinimize write FOnInspectorBeforeMinimize;
    property OnInspectorBeforeMove: TadxOutlookInspectorBeforeMove read FOnInspectorBeforeMove write FOnInspectorBeforeMove;
    property OnInspectorBeforeSize: TadxOutlookInspectorBeforeSize read FOnInspectorBeforeSize write FOnInspectorBeforeSize;
    // 2 0 0 7
    property OnAttachmentContextMenuDisplay: TadxOutlookApplicationAttachmentContextMenuDisplay read FOnAttachmentContextMenuDisplay write FOnAttachmentContextMenuDisplay;
    property OnViewContextMenuDisplay: TadxOutlookApplicationViewContextMenuDisplay read FOnViewContextMenuDisplay write FOnViewContextMenuDisplay;
    property OnItemContextMenuDisplay: TadxOutlookApplicationItemContextMenuDisplay read FOnItemContextMenuDisplay write FOnItemContextMenuDisplay;
    property OnFolderContextMenuDisplay: TadxOutlookApplicationFolderContextMenuDisplay read FOnFolderContextMenuDisplay write FOnFolderContextMenuDisplay;
    property OnStoreContextMenuDisplay: TadxOutlookApplicationStoreContextMenuDisplay read FOnStoreContextMenuDisplay write FOnStoreContextMenuDisplay;
    property OnShortcutContextMenuDisplay: TadxOutlookApplicationShortcutContextMenuDisplay read FOnShortcutContextMenuDisplay write FOnShortcutContextMenuDisplay;
    property OnContextMenuClose: TadxOutlookApplicationContextMenuClose read FOnContextMenuClose write FOnContextMenuClose;
    property OnItemLoad: TadxOutlookApplicationItemLoad read FOnItemLoad write FOnItemLoad;
    property OnBeforeFolderSharingDialog: TadxOutlookApplicationBeforeFolderSharingDialog read FOnBeforeFolderSharingDialog write FOnBeforeFolderSharingDialog;
    property OnNameSpaceAutoDiscoverComplete: TNotifyEvent read FOnNameSpaceAutoDiscoverComplete write FOnNameSpaceAutoDiscoverComplete;
    property OnInspectorPageChange: TadxOutlookInspectorPageChange read FOnInspectorPageChange write FOnInspectorPageChange;
    // 2 0 1 0
    property OnExplorerAttachmentSelectionChange: TNotifyEvent read FOnExplorerAttachmentSelectionChange write FOnExplorerAttachmentSelectionChange;
    property OnInspectorAttachmentSelectionChange: TNotifyEvent read FOnInspectorAttachmentSelectionChange write FOnInspectorAttachmentSelectionChange;
  end;

  {$IFNDEF DELPHI_7_UP}
  ExcelRange = Excel2000.Range;
  WordSelection = Word2000.Selection;
  {$ENDIF}

  TadxExcelApplicationNewWorkbook = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationSheetSelectionChange = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: ExcelRange) of object;
  TadxExcelApplicationSheetBeforeDoubleClick = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: ExcelRange; var Cancel: WordBool) of object;
  TadxExcelApplicationSheetBeforeRightClick = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: ExcelRange; var Cancel: WordBool) of object;
  TadxExcelApplicationSheetActivate = procedure(ASender: TObject; const Sh: IDispatch) of object;
  TadxExcelApplicationSheetDeactivate = procedure(ASender: TObject; const Sh: IDispatch) of object;
  TadxExcelApplicationSheetCalculate = procedure(ASender: TObject; const Sh: IDispatch) of object;
  TadxExcelApplicationSheetChange = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: ExcelRange) of object;
  TadxExcelApplicationWorkbookOpen = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationWorkbookActivate = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationWorkbookDeactivate = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationWorkbookBeforeClose = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    var Cancel: WordBool) of object;
  TadxExcelApplicationWorkbookBeforeSave = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    SaveAsUI: WordBool; var Cancel: WordBool) of object;
  TadxExcelApplicationWorkbookBeforePrint = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    var Cancel: WordBool) of object;
  TadxExcelApplicationWorkbookNewSheet = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Sh: IDispatch) of object;
  TadxExcelApplicationWorkbookAddinInstall = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationWorkbookAddinUninstall = procedure(ASender: TObject; const Wb: ExcelWorkbook) of object;
  TadxExcelApplicationWindowResize = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Wn: Excel2000.Window) of object;
  TadxExcelApplicationWindowActivate = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Wn: Excel2000.Window) of object;
  TadxExcelApplicationWindowDeactivate = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Wn: Excel2000.Window) of object;
  TadxExcelApplicationSheetFollowHyperlink = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: Excel2000.Hyperlink) of object;
  TadxExcelApplicationSheetPivotTableUpdate = procedure(ASender: TObject; const Sh: IDispatch;
    const Target: PivotTable) of object;
  TadxExcelApplicationWorkbookPivotTableCloseConnection = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Target: PivotTable) of object;
  TadxExcelApplicationWorkbookPivotTableOpenConnection = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Target: PivotTable) of object;
  TadxExcelApplicationWorkbookSync = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    SyncEventType: TOleEnum) of object;
  TadxExcelApplicationWorkbookBeforeXmlImport = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Map: IDispatch; const Url: WideString; IsRefresh: WordBool; var Cancel: WordBool) of object;
  TadxExcelApplicationWorkbookAfterXmlImport = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Map: IDispatch; IsRefresh: WordBool; Result: TOleEnum) of object;
  TadxExcelApplicationWorkbookBeforeXmlExport = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Map: IDispatch; const Url: WideString; var Cancel: WordBool) of object;
  TadxExcelApplicationWorkbookAfterXmlExport = procedure(ASender: TObject; const Wb: ExcelWorkbook;
    const Map: IDispatch; const Url: WideString; Result: TOleEnum) of object;
  TadxExcelApplicationWorkbookRowsetComplete = procedure(ASender: TObject;
    const Wb: ExcelWorkbook; const Description: WideString; const Sheet: WideString; Success: WordBool) of object;
  TadxExcelApplicationSheetPivotTableAfterValueChange = procedure(ASender: TObject;
    const Sh: IDispatch; const TargetPivotTable: PivotTable; const TargetRange: ExcelRange) of object;
  TadxExcelApplicationSheetPivotTableBeforeAllocateChanges = procedure(ASender: TObject;
    const Sh: IDispatch; const TargetPivotTable: PivotTable; ValueChangeStart: Integer;
    ValueChangeEnd: Integer; var Cancel: WordBool) of object;
  TadxExcelApplicationSheetPivotTableBeforeCommitChanges = procedure(ASender: TObject;
    const Sh: IDispatch; const TargetPivotTable: PivotTable; ValueChangeStart: Integer;
    ValueChangeEnd: Integer; var Cancel: WordBool) of object;
  TadxExcelApplicationSheetPivotTableBeforeDiscardChanges = procedure(ASender: TObject;
    const Sh: IDispatch; const TargetPivotTable: PivotTable; ValueChangeStart: Integer; ValueChangeEnd: Integer) of object;
  TadxExcelApplicationProtectedViewWindowOpen = procedure(ASender: TObject;
    const Pvw: IDispatch) of object;
  TadxExcelApplicationProtectedViewWindowBeforeEdit = procedure(ASender: TObject;
    const Pvw: IDispatch; var Cancel: WordBool) of object;
  TadxExcelApplicationProtectedViewWindowBeforeClose = procedure(ASender: TObject;
    const Pvw: IDispatch; Reason: TOleEnum; var Cancel: WordBool) of object;
  TadxExcelApplicationProtectedViewWindowResize = procedure(ASender: TObject;
    const Pvw: IDispatch) of object;
  TadxExcelApplicationProtectedViewWindowActivate = procedure(ASender: TObject;
    const Pvw: IDispatch) of object;
  TadxExcelApplicationProtectedViewWindowDeactivate = procedure(ASender: TObject;
    const Pvw: IDispatch) of object;
  TadxExcelApplicationWorkbookAfterSave = procedure(ASender: TObject;
    const Wb: ExcelWorkbook; Success: WordBool) of object;
  TadxExcelApplicationWorkbookNewChart = procedure(ASender: TObject;
    const Wb: ExcelWorkbook; const Ch: ExcelChart) of object;

  TadxExcelAppEvents = class(TadxCustomEvents)
  private
    FIntf: Excel2000._Application;
    FOnNewWorkbook: TadxExcelApplicationNewWorkbook;
    FOnSheetSelectionChange: TadxExcelApplicationSheetSelectionChange;
    FOnSheetBeforeDoubleClick: TadxExcelApplicationSheetBeforeDoubleClick;
    FOnSheetBeforeRightClick: TadxExcelApplicationSheetBeforeRightClick;
    FOnSheetActivate: TadxExcelApplicationSheetActivate;
    FOnSheetDeactivate: TadxExcelApplicationSheetDeactivate;
    FOnSheetCalculate: TadxExcelApplicationSheetCalculate;
    FOnSheetChange: TadxExcelApplicationSheetChange;
    FOnWorkbookOpen: TadxExcelApplicationWorkbookOpen;
    FOnWorkbookActivate: TadxExcelApplicationWorkbookActivate;
    FOnWorkbookDeactivate: TadxExcelApplicationWorkbookDeactivate;
    FOnWorkbookBeforeClose: TadxExcelApplicationWorkbookBeforeClose;
    FOnWorkbookBeforeSave: TadxExcelApplicationWorkbookBeforeSave;
    FOnWorkbookBeforePrint: TadxExcelApplicationWorkbookBeforePrint;
    FOnWorkbookNewSheet: TadxExcelApplicationWorkbookNewSheet;
    FOnWorkbookAddinInstall: TadxExcelApplicationWorkbookAddinInstall;
    FOnWorkbookAddinUninstall: TadxExcelApplicationWorkbookAddinUninstall;
    FOnWindowResize: TadxExcelApplicationWindowResize;
    FOnWindowActivate: TadxExcelApplicationWindowActivate;
    FOnWindowDeactivate: TadxExcelApplicationWindowDeactivate;
    FOnSheetFollowHyperlink: TadxExcelApplicationSheetFollowHyperlink;
    FOnSheetPivotTableUpdate: TadxExcelApplicationSheetPivotTableUpdate;
    FOnWorkbookPivotTableCloseConnection: TadxExcelApplicationWorkbookPivotTableCloseConnection;
    FOnWorkbookPivotTableOpenConnection: TadxExcelApplicationWorkbookPivotTableOpenConnection;
    FOnWorkbookSync: TadxExcelApplicationWorkbookSync;
    FOnWorkbookBeforeXmlImport: TadxExcelApplicationWorkbookBeforeXmlImport;
    FOnWorkbookAfterXmlImport: TadxExcelApplicationWorkbookAfterXmlImport;
    FOnWorkbookBeforeXmlExport: TadxExcelApplicationWorkbookBeforeXmlExport;
    FOnWorkbookAfterXmlExport: TadxExcelApplicationWorkbookAfterXmlExport;
    // 2 0 0 7
    FOnWorkbookRowsetComplete: TadxExcelApplicationWorkbookRowsetComplete;
    FOnAfterCalculate: TNotifyEvent;
    // 2 0 1 0
    FOnSheetPivotTableAfterValueChange: TadxExcelApplicationSheetPivotTableAfterValueChange;
    FOnSheetPivotTableBeforeAllocateChanges: TadxExcelApplicationSheetPivotTableBeforeAllocateChanges;
    FOnSheetPivotTableBeforeCommitChanges: TadxExcelApplicationSheetPivotTableBeforeCommitChanges;
    FOnSheetPivotTableBeforeDiscardChanges: TadxExcelApplicationSheetPivotTableBeforeDiscardChanges;
    FOnProtectedViewWindowOpen: TadxExcelApplicationProtectedViewWindowOpen;
    FOnProtectedViewWindowBeforeEdit: TadxExcelApplicationProtectedViewWindowBeforeEdit;
    FOnProtectedViewWindowBeforeClose: TadxExcelApplicationProtectedViewWindowBeforeClose;
    FOnProtectedViewWindowResize: TadxExcelApplicationProtectedViewWindowResize;
    FOnProtectedViewWindowActivate: TadxExcelApplicationProtectedViewWindowActivate;
    FOnProtectedViewWindowDeactivate: TadxExcelApplicationProtectedViewWindowDeactivate;
    FOnWorkbookAfterSave: TadxExcelApplicationWorkbookAfterSave;
    FOnWorkbookNewChart: TadxExcelApplicationWorkbookNewChart;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnNewWorkbook: TadxExcelApplicationNewWorkbook read FOnNewWorkbook write FOnNewWorkbook;
    property OnSheetSelectionChange: TadxExcelApplicationSheetSelectionChange read FOnSheetSelectionChange write FOnSheetSelectionChange;
    property OnSheetBeforeDoubleClick: TadxExcelApplicationSheetBeforeDoubleClick read FOnSheetBeforeDoubleClick write FOnSheetBeforeDoubleClick;
    property OnSheetBeforeRightClick: TadxExcelApplicationSheetBeforeRightClick read FOnSheetBeforeRightClick write FOnSheetBeforeRightClick;
    property OnSheetActivate: TadxExcelApplicationSheetActivate read FOnSheetActivate write FOnSheetActivate;
    property OnSheetDeactivate: TadxExcelApplicationSheetDeactivate read FOnSheetDeactivate write FOnSheetDeactivate;
    property OnSheetCalculate: TadxExcelApplicationSheetCalculate read FOnSheetCalculate write FOnSheetCalculate;
    property OnSheetChange: TadxExcelApplicationSheetChange read FOnSheetChange write FOnSheetChange;
    property OnWorkbookOpen: TadxExcelApplicationWorkbookOpen read FOnWorkbookOpen write FOnWorkbookOpen;
    property OnWorkbookActivate: TadxExcelApplicationWorkbookActivate read FOnWorkbookActivate write FOnWorkbookActivate;
    property OnWorkbookDeactivate: TadxExcelApplicationWorkbookDeactivate read FOnWorkbookDeactivate write FOnWorkbookDeactivate;
    property OnWorkbookBeforeClose: TadxExcelApplicationWorkbookBeforeClose read FOnWorkbookBeforeClose write FOnWorkbookBeforeClose;
    property OnWorkbookBeforeSave: TadxExcelApplicationWorkbookBeforeSave read FOnWorkbookBeforeSave write FOnWorkbookBeforeSave;
    property OnWorkbookBeforePrint: TadxExcelApplicationWorkbookBeforePrint read FOnWorkbookBeforePrint write FOnWorkbookBeforePrint;
    property OnWorkbookNewSheet: TadxExcelApplicationWorkbookNewSheet read FOnWorkbookNewSheet write FOnWorkbookNewSheet;
    property OnWorkbookAddinInstall: TadxExcelApplicationWorkbookAddinInstall read FOnWorkbookAddinInstall write FOnWorkbookAddinInstall;
    property OnWorkbookAddinUninstall: TadxExcelApplicationWorkbookAddinUninstall read FOnWorkbookAddinUninstall write FOnWorkbookAddinUninstall;
    property OnWindowResize: TadxExcelApplicationWindowResize read FOnWindowResize write FOnWindowResize;
    property OnWindowActivate: TadxExcelApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxExcelApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnSheetFollowHyperlink: TadxExcelApplicationSheetFollowHyperlink read FOnSheetFollowHyperlink write FOnSheetFollowHyperlink;
    property OnSheetPivotTableUpdate: TadxExcelApplicationSheetPivotTableUpdate read FOnSheetPivotTableUpdate write FOnSheetPivotTableUpdate;
    property OnWorkbookPivotTableCloseConnection: TadxExcelApplicationWorkbookPivotTableCloseConnection read FOnWorkbookPivotTableCloseConnection write FOnWorkbookPivotTableCloseConnection;
    property OnWorkbookPivotTableOpenConnection: TadxExcelApplicationWorkbookPivotTableOpenConnection read FOnWorkbookPivotTableOpenConnection write FOnWorkbookPivotTableOpenConnection;
    property OnWorkbookSync: TadxExcelApplicationWorkbookSync read FOnWorkbookSync write FOnWorkbookSync;
    property OnWorkbookBeforeXmlImport: TadxExcelApplicationWorkbookBeforeXmlImport read FOnWorkbookBeforeXmlImport write FOnWorkbookBeforeXmlImport;
    property OnWorkbookAfterXmlImport: TadxExcelApplicationWorkbookAfterXmlImport read FOnWorkbookAfterXmlImport write FOnWorkbookAfterXmlImport;
    property OnWorkbookBeforeXmlExport: TadxExcelApplicationWorkbookBeforeXmlExport read FOnWorkbookBeforeXmlExport write FOnWorkbookBeforeXmlExport;
    property OnWorkbookAfterXmlExport: TadxExcelApplicationWorkbookAfterXmlExport read FOnWorkbookAfterXmlExport write FOnWorkbookAfterXmlExport;
    // 2 0 0 7
    property OnWorkbookRowsetComplete: TadxExcelApplicationWorkbookRowsetComplete read FOnWorkbookRowsetComplete write FOnWorkbookRowsetComplete;
    property OnAfterCalculate: TNotifyEvent read FOnAfterCalculate write FOnAfterCalculate;
    // 2 0 1 0
    property OnSheetPivotTableAfterValueChange: TadxExcelApplicationSheetPivotTableAfterValueChange read FOnSheetPivotTableAfterValueChange write FOnSheetPivotTableAfterValueChange;
    property OnSheetPivotTableBeforeAllocateChanges: TadxExcelApplicationSheetPivotTableBeforeAllocateChanges read FOnSheetPivotTableBeforeAllocateChanges write FOnSheetPivotTableBeforeAllocateChanges;
    property OnSheetPivotTableBeforeCommitChanges: TadxExcelApplicationSheetPivotTableBeforeCommitChanges read FOnSheetPivotTableBeforeCommitChanges write FOnSheetPivotTableBeforeCommitChanges;
    property OnSheetPivotTableBeforeDiscardChanges: TadxExcelApplicationSheetPivotTableBeforeDiscardChanges read FOnSheetPivotTableBeforeDiscardChanges write FOnSheetPivotTableBeforeDiscardChanges;
    property OnProtectedViewWindowOpen: TadxExcelApplicationProtectedViewWindowOpen read FOnProtectedViewWindowOpen write FOnProtectedViewWindowOpen;
    property OnProtectedViewWindowBeforeEdit: TadxExcelApplicationProtectedViewWindowBeforeEdit read FOnProtectedViewWindowBeforeEdit write FOnProtectedViewWindowBeforeEdit;
    property OnProtectedViewWindowBeforeClose: TadxExcelApplicationProtectedViewWindowBeforeClose read FOnProtectedViewWindowBeforeClose write FOnProtectedViewWindowBeforeClose;
    property OnProtectedViewWindowResize: TadxExcelApplicationProtectedViewWindowResize read FOnProtectedViewWindowResize write FOnProtectedViewWindowResize;
    property OnProtectedViewWindowActivate: TadxExcelApplicationProtectedViewWindowActivate read FOnProtectedViewWindowActivate write FOnProtectedViewWindowActivate;
    property OnProtectedViewWindowDeactivate: TadxExcelApplicationProtectedViewWindowDeactivate read FOnProtectedViewWindowDeactivate write FOnProtectedViewWindowDeactivate;
    property OnWorkbookAfterSave: TadxExcelApplicationWorkbookAfterSave read FOnWorkbookAfterSave write FOnWorkbookAfterSave;
    property OnWorkbookNewChart: TadxExcelApplicationWorkbookNewChart read FOnWorkbookNewChart write FOnWorkbookNewChart;
  end;

  TadxWordApplicationDocumentOpen = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationDocumentBeforeClose = procedure(ASender: TObject; const Doc: WordDocument; var Cancel: WordBool) of object;
  TadxWordApplicationDocumentBeforePrint = procedure(ASender: TObject; const Doc: WordDocument; var Cancel: WordBool) of object;
  TadxWordApplicationDocumentBeforeSave = procedure(ASender: TObject; const Doc: WordDocument;
    var SaveAsUI: WordBool; var Cancel: WordBool) of object;
  TadxWordApplicationNewDocument = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationWindowActivate = procedure(ASender: TObject; const Doc: WordDocument; const Wn: Word2000.Window) of object;
  TadxWordApplicationWindowDeactivate = procedure(ASender: TObject; const Doc: WordDocument; const Wn: Word2000.Window) of object;
  TadxWordApplicationWindowSelectionChange = procedure(ASender: TObject; const Sel: WordSelection) of object;
  TadxWordApplicationWindowBeforeRightClick = procedure(ASender: TObject; const Sel: WordSelection; var Cancel: WordBool) of object;
  TadxWordApplicationWindowBeforeDoubleClick = procedure(ASender: TObject; const Sel: WordSelection; var Cancel: WordBool) of object;
  TadxWordApplicationEPostagePropertyDialog = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationEPostageInsert = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationMailMergeAfterMerge = procedure(ASender: TObject; const Doc: WordDocument;
    const DocResult: WordDocument) of object;
  TadxWordApplicationMailMergeAfterRecordMerge = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationMailMergeBeforeMerge = procedure(ASender: TObject; const Doc: WordDocument;
    StartRecord: Integer; EndRecord: Integer; var Cancel: WordBool) of object;
  TadxWordApplicationMailMergeBeforeRecordMerge = procedure(ASender: TObject; const Doc: WordDocument;
    var Cancel: WordBool) of object;
  TadxWordApplicationMailMergeDataSourceLoad = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationMailMergeDataSourceValidate = procedure(ASender: TObject; const Doc: WordDocument;
    var Handled: WordBool) of object;
  TadxWordApplicationMailMergeWizardSendToCustom = procedure(ASender: TObject; const Doc: WordDocument) of object;
  TadxWordApplicationMailMergeWizardStateChange = procedure(ASender: TObject; const Doc: WordDocument;
    var FromState: SYSINT; var ToState: SYSINT; var Handled: WordBool) of object;
  TadxWordApplicationWindowSize = procedure(ASender: TObject; const Doc: WordDocument; const Wn: Word2000.Window) of object;
  TadxWordApplicationXMLSelectionChange = procedure(ASender: TObject; const Sel: WordSelection;
    const OldXMLNode: IDispatch; const NewXMLNode: IDispatch; var Reason: Integer) of object;
  TadxWordApplicationXMLValidationError = procedure(ASender: TObject; const XMLNode: IDispatch) of object;
  TadxWordApplicationDocumentSync = procedure(ASender: TObject; const Doc: WordDocument;
    SyncEventType: TOleEnum) of object;
  TadxWordApplicationEPostageInsertEx = procedure(ASender: TObject; const Doc: WordDocument;
    cpDeliveryAddrStart: SYSINT; cpDeliveryAddrEnd: SYSINT; cpReturnAddrStart: SYSINT;
    cpReturnAddrEnd: SYSINT; xaWidth: SYSINT; yaHeight: SYSINT; const bstrPrinterName: WideString;
    const bstrPaperFeed: WideString; fPrint: WordBool; var fCancel: WordBool) of object;
  TadxWordApplicationMailMergeDataSourceValidate2 = procedure(ASender: TObject;
    const Doc: WordDocument; var Handled: WordBool) of object;
  TadxWordApplicationProtectedViewWindowOpen = procedure(ASender: TObject; const PvWindow: IDispatch) of object;
  TadxWordApplicationProtectedViewWindowBeforeEdit = procedure(ASender: TObject;
    const PvWindow: IDispatch; var Cancel: WordBool) of object;
  TadxWordApplicationProtectedViewWindowBeforeClose = procedure(ASender: TObject;
    const PvWindow: IDispatch; CloseReason: SYSINT; var Cancel: WordBool) of object;
  TadxWordApplicationProtectedViewWindowSize = procedure(ASender: TObject; const PvWindow: IDispatch) of object;
  TadxWordApplicationProtectedViewWindowActivate = procedure(ASender: TObject; const PvWindow: IDispatch) of object;
  TadxWordApplicationProtectedViewWindowDeactivate = procedure(ASender: TObject; const PvWindow: IDispatch) of object;

  TadxWordAppEvents = class(TadxCustomEvents)
  private
    FIntf: Word2000._Application;
    FOnStartup: TNotifyEvent;
    FOnQuit: TNotifyEvent;
    FOnDocumentChange: TNotifyEvent;
    FOnDocumentOpen: TadxWordApplicationDocumentOpen;
    FOnDocumentBeforeClose: TadxWordApplicationDocumentBeforeClose;
    FOnDocumentBeforePrint: TadxWordApplicationDocumentBeforePrint;
    FOnDocumentBeforeSave: TadxWordApplicationDocumentBeforeSave;
    FOnNewDocument: TadxWordApplicationNewDocument;
    FOnWindowActivate: TadxWordApplicationWindowActivate;
    FOnWindowDeactivate: TadxWordApplicationWindowDeactivate;
    FOnWindowSelectionChange: TadxWordApplicationWindowSelectionChange;
    FOnWindowBeforeRightClick: TadxWordApplicationWindowBeforeRightClick;
    FOnWindowBeforeDoubleClick: TadxWordApplicationWindowBeforeDoubleClick;
    FOnEPostagePropertyDialog: TadxWordApplicationEPostagePropertyDialog;
    FOnEPostageInsert: TadxWordApplicationEPostageInsert;
    FOnMailMergeAfterMerge: TadxWordApplicationMailMergeAfterMerge;
    FOnMailMergeAfterRecordMerge: TadxWordApplicationMailMergeAfterRecordMerge;
    FOnMailMergeBeforeMerge: TadxWordApplicationMailMergeBeforeMerge;
    FOnMailMergeBeforeRecordMerge: TadxWordApplicationMailMergeBeforeRecordMerge;
    FOnMailMergeDataSourceLoad: TadxWordApplicationMailMergeDataSourceLoad;
    FOnMailMergeDataSourceValidate: TadxWordApplicationMailMergeDataSourceValidate;
    FOnMailMergeWizardSendToCustom: TadxWordApplicationMailMergeWizardSendToCustom;
    FOnMailMergeWizardStateChange: TadxWordApplicationMailMergeWizardStateChange;
    FOnWindowSize: TadxWordApplicationWindowSize;
    FOnXMLSelectionChange: TadxWordApplicationXMLSelectionChange;
    FOnXMLValidationError: TadxWordApplicationXMLValidationError;
    FOnDocumentSync: TadxWordApplicationDocumentSync;
    FOnEPostageInsertEx: TadxWordApplicationEPostageInsertEx;
    FOnMailMergeDataSourceValidate2: TadxWordApplicationMailMergeDataSourceValidate2;
    // 2 0 1 0
    FOnProtectedViewWindowOpen: TadxWordApplicationProtectedViewWindowOpen;
    FOnProtectedViewWindowBeforeEdit: TadxWordApplicationProtectedViewWindowBeforeEdit;
    FOnProtectedViewWindowBeforeClose: TadxWordApplicationProtectedViewWindowBeforeClose;
    FOnProtectedViewWindowSize: TadxWordApplicationProtectedViewWindowSize;
    FOnProtectedViewWindowActivate: TadxWordApplicationProtectedViewWindowActivate;
    FOnProtectedViewWindowDeactivate: TadxWordApplicationProtectedViewWindowDeactivate;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnStartup: TNotifyEvent read FOnStartup write FOnStartup;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnDocumentChange: TNotifyEvent read FOnDocumentChange write FOnDocumentChange;
    property OnDocumentOpen: TadxWordApplicationDocumentOpen read FOnDocumentOpen write FOnDocumentOpen;
    property OnDocumentBeforeClose: TadxWordApplicationDocumentBeforeClose read FOnDocumentBeforeClose write FOnDocumentBeforeClose;
    property OnDocumentBeforePrint: TadxWordApplicationDocumentBeforePrint read FOnDocumentBeforePrint write FOnDocumentBeforePrint;
    property OnDocumentBeforeSave: TadxWordApplicationDocumentBeforeSave read FOnDocumentBeforeSave write FOnDocumentBeforeSave;
    property OnNewDocument: TadxWordApplicationNewDocument read FOnNewDocument write FOnNewDocument;
    property OnWindowActivate: TadxWordApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxWordApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowSelectionChange: TadxWordApplicationWindowSelectionChange read FOnWindowSelectionChange write FOnWindowSelectionChange;
    property OnWindowBeforeRightClick: TadxWordApplicationWindowBeforeRightClick read FOnWindowBeforeRightClick write FOnWindowBeforeRightClick;
    property OnWindowBeforeDoubleClick: TadxWordApplicationWindowBeforeDoubleClick read FOnWindowBeforeDoubleClick write FOnWindowBeforeDoubleClick;
    property OnEPostagePropertyDialog: TadxWordApplicationEPostagePropertyDialog read FOnEPostagePropertyDialog write FOnEPostagePropertyDialog;
    property OnEPostageInsert: TadxWordApplicationEPostageInsert read FOnEPostageInsert write FOnEPostageInsert;
    property OnMailMergeAfterMerge: TadxWordApplicationMailMergeAfterMerge read FOnMailMergeAfterMerge write FOnMailMergeAfterMerge;
    property OnMailMergeAfterRecordMerge: TadxWordApplicationMailMergeAfterRecordMerge read FOnMailMergeAfterRecordMerge write FOnMailMergeAfterRecordMerge;
    property OnMailMergeBeforeMerge: TadxWordApplicationMailMergeBeforeMerge read FOnMailMergeBeforeMerge write FOnMailMergeBeforeMerge;
    property OnMailMergeBeforeRecordMerge: TadxWordApplicationMailMergeBeforeRecordMerge read FOnMailMergeBeforeRecordMerge write FOnMailMergeBeforeRecordMerge;
    property OnMailMergeDataSourceLoad: TadxWordApplicationMailMergeDataSourceLoad read FOnMailMergeDataSourceLoad write FOnMailMergeDataSourceLoad;
    property OnMailMergeDataSourceValidate: TadxWordApplicationMailMergeDataSourceValidate read FOnMailMergeDataSourceValidate write FOnMailMergeDataSourceValidate;
    property OnMailMergeWizardSendToCustom: TadxWordApplicationMailMergeWizardSendToCustom read FOnMailMergeWizardSendToCustom write FOnMailMergeWizardSendToCustom;
    property OnMailMergeWizardStateChange: TadxWordApplicationMailMergeWizardStateChange read FOnMailMergeWizardStateChange write FOnMailMergeWizardStateChange;
    property OnWindowSize: TadxWordApplicationWindowSize read FOnWindowSize write FOnWindowSize;
    property OnXMLSelectionChange: TadxWordApplicationXMLSelectionChange read FOnXMLSelectionChange write FOnXMLSelectionChange;
    property OnXMLValidationError: TadxWordApplicationXMLValidationError read FOnXMLValidationError write FOnXMLValidationError;
    property OnDocumentSync: TadxWordApplicationDocumentSync read FOnDocumentSync write FOnDocumentSync;
    property OnEPostageInsertEx: TadxWordApplicationEPostageInsertEx read FOnEPostageInsertEx write FOnEPostageInsertEx;
    // 2 0 0 7
    property OnMailMergeDataSourceValidate2: TadxWordApplicationMailMergeDataSourceValidate2 read FOnMailMergeDataSourceValidate2 write FOnMailMergeDataSourceValidate2;
    // 2 0 1 0
    property OnProtectedViewWindowOpen: TadxWordApplicationProtectedViewWindowOpen read FOnProtectedViewWindowOpen write FOnProtectedViewWindowOpen;
    property OnProtectedViewWindowBeforeEdit: TadxWordApplicationProtectedViewWindowBeforeEdit read FOnProtectedViewWindowBeforeEdit write FOnProtectedViewWindowBeforeEdit;
    property OnProtectedViewWindowBeforeClose: TadxWordApplicationProtectedViewWindowBeforeClose read FOnProtectedViewWindowBeforeClose write FOnProtectedViewWindowBeforeClose;
    property OnProtectedViewWindowSize: TadxWordApplicationProtectedViewWindowSize read FOnProtectedViewWindowSize write FOnProtectedViewWindowSize;
    property OnProtectedViewWindowActivate: TadxWordApplicationProtectedViewWindowActivate read FOnProtectedViewWindowActivate write FOnProtectedViewWindowActivate;
    property OnProtectedViewWindowDeactivate: TadxWordApplicationProtectedViewWindowDeactivate read FOnProtectedViewWindowDeactivate write FOnProtectedViewWindowDeactivate;
  end;

  Project_ = Project2000._IProjectDoc;

  TadxProjectApplicationNewProject = procedure(ASender: TObject; const pj: Project_) of object;
  TadxProjectApplicationProjectBeforeTaskDelete = procedure(ASender: TObject;
    const tsk: Task; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeResourceDelete = procedure(ASender: TObject;
    const res: Resource; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeAssignmentDelete = procedure(ASender: TObject;
    const asg: Assignment; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeTaskChange = procedure(ASender: TObject; const tsk: Task;
    Field: PjField; NewVal: OleVariant; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeResourceChange = procedure(ASender: TObject; const res: Resource;
    Field: PjField; NewVal: OleVariant; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeAssignmentChange = procedure(ASender: TObject; const asg: Assignment;
    Field: PjAssignmentField; NewVal: OleVariant; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeTaskNew = procedure(ASender: TObject; const pj: Project_;
    var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeResourceNew = procedure(ASender: TObject; const pj: Project_;
    var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeAssignmentNew = procedure(ASender: TObject; const pj: Project_;
    var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeClose = procedure(ASender: TObject; const pj: Project_;
    var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforePrint = procedure(ASender: TObject; const pj: Project_;
    var Cancel: WordBool) of object;
  TadxProjectApplicationProjectBeforeSave = procedure(ASender: TObject; const pj: Project_;
    SaveAsUi: WordBool; var Cancel: WordBool) of object;
  TadxProjectApplicationProjectCalculate = procedure(ASender: TObject; const pj: Project_) of object;
  TadxProjectApplicationWindowGoalAreaChange = procedure(ASender: TObject; const Window: Project2000.Window;
    goalArea: Integer) of object;
  TadxProjectApplicationWindowSelectionChange = procedure(ASender: TObject; const Window: Project2000.Window;
    const sel: Project2000.Selection; selType: OleVariant) of object;
  TadxProjectApplicationWindowBeforeViewChange = procedure(ASender: TObject; const Window: Project2000.Window;
    const prevView: IDispatch; const newView: IDispatch; projectHasViewWindow: WordBool; const Info: IDispatch) of object;
  TadxProjectApplicationWindowViewChange = procedure(ASender: TObject; const Window: Project2000.Window;
    const prevView: IDispatch; const newView: IDispatch; success: WordBool) of object;
  TadxProjectApplicationWindowActivate = procedure(ASender: TObject; const activatedWindow: Project2000.Window) of object;
  TadxProjectApplicationWindowDeactivate = procedure(ASender: TObject; const deactivatedWindow: Project2000.Window) of object;
  TadxProjectApplicationWindowSidepaneDisplayChange = procedure(ASender: TObject; const Window: Project2000.Window;
    Close: WordBool) of object;
  TadxProjectApplicationWindowSidepaneTaskChange = procedure(ASender: TObject; const Window: Project2000.Window; 
    ID: Integer; IsGoalArea: WordBool) of object;
  TadxProjectApplicationWorkpaneDisplayChange = procedure(ASender: TObject; DisplayState: WordBool) of object;
  TadxProjectApplicationLoadWebPage = procedure(ASender: TObject; const Window: Project2000.Window;
    var TargetPage: WideString) of object;
  TadxProjectApplicationProjectTaskNew = procedure(ASender: TObject; const pj: Project_; ID: Integer) of object;
  TadxProjectApplicationProjectResourceNew = procedure(ASender: TObject; const pj: Project_;
    ID: Integer) of object;
  TadxProjectApplicationProjectAssignmentNew = procedure(ASender: TObject; const pj: Project_; 
    ID: Integer) of object;
  TadxProjectApplicationProjectBeforeSaveBaseline = procedure(ASender: TObject; const pj: Project_;
    Interim: WordBool; bl: TOleEnum; InterimCopy: PjSaveBaselineFrom; InterimInto: PjSaveBaselineTo;
    AllTasks: WordBool; RollupToSummaryTasks: WordBool; RollupFromSubtasks: WordBool; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeClearBaseline = procedure(ASender: TObject; const pj: Project_; 
    Interim: WordBool; bl: TOleEnum; InterimFrom: PjSaveBaselineTo; AllTasks: WordBool; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeClose2 = procedure(ASender: TObject; const pj: Project_; 
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforePrint2 = procedure(ASender: TObject; const pj: Project_;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeSave2 = procedure(ASender: TObject; const pj: Project_;
    SaveAsUi: WordBool; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeTaskDelete2 = procedure(ASender: TObject; const tsk: Task;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeResourceDelete2 = procedure(ASender: TObject; const res: Resource;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeAssignmentDelete2 = procedure(ASender: TObject; const asg: Assignment;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeTaskChange2 = procedure(ASender: TObject; const tsk: Task;
    Field: PjField; NewVal: OleVariant; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeResourceChange2 = procedure(ASender: TObject; const res: Resource;
    Field: PjField; NewVal: OleVariant; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeAssignmentChange2 = procedure(ASender: TObject; const asg: Assignment;
    Field: PjAssignmentField; NewVal: OleVariant; const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeTaskNew2 = procedure(ASender: TObject; const pj: Project_;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeResourceNew2 = procedure(ASender: TObject; const pj: Project_;
    const Info: IDispatch) of object;
  TadxProjectApplicationProjectBeforeAssignmentNew2 = procedure(ASender: TObject; const pj: Project_;
    const Info: IDispatch) of object;
  TadxProjectApplicationApplicationBeforeClose = procedure(ASender: TObject; const Info: IDispatch) of object;
  TadxProjectApplicationOnUndoOrRedo = procedure(ASender: TObject;
    const bstrLabel: WideString; const bstrGUID: WideString; fUndo: WordBool) of object;
  TadxProjectApplicationAfterCubeBuilt = procedure(ASender: TObject; var CubeFileName: WideString) of object;
  TadxProjectApplicationLoadWebPane = procedure(ASender: TObject;
    const Window: Window; var TargetPage: WideString) of object;
  TadxProjectApplicationJobStart = procedure(ASender: TObject;
    const bstrName: WideString; const bstrprojGuid: WideString; const bstrjobGuid: WideString;
    jobType: Integer; lResult: Integer) of object;
  TadxProjectApplicationJobCompleted = procedure(ASender: TObject;
    const bstrName: WideString; const bstrprojGuid: WideString; const bstrjobGuid: WideString;
    jobType: Integer; lResult: Integer) of object;
  TadxProjectApplicationSaveStartingToServer = procedure(ASender: TObject;
    const bstrName: WideString; const bstrprojGuid: WideString) of object;
  TadxProjectApplicationSaveCompletedToServer = procedure(ASender: TObject;
    const bstrName: WideString; const bstrprojGuid: WideString) of object;
  TadxProjectApplicationProjectBeforePublish = procedure(ASender: TObject;
    const pj: Project_; var Cancel: WordBool) of object;
  TadxProjectApplicationSecondaryViewChange = procedure(ASender: TObject;
    const Window: Window; const prevView: View; const newView: View; success: WordBool) of object;
  TadxProjectApplicationIsFunctionalitySupported = procedure(ASender: TObject;
    const bstrFunctionality: WideString; const Info: IDispatch) of object;
  TadxProjectApplicationConnectionStatusChanged = procedure(ASender: TObject; online: WordBool) of object;

  TadxProjectAppEvents = class(TadxCustomEvents)
  private
    FIntf: Project2000._MSProject;
    FOnNewProject: TadxProjectApplicationNewProject;
    FOnProjectBeforeTaskDelete: TadxProjectApplicationProjectBeforeTaskDelete;
    FOnProjectBeforeResourceDelete: TadxProjectApplicationProjectBeforeResourceDelete;
    FOnProjectBeforeAssignmentDelete: TadxProjectApplicationProjectBeforeAssignmentDelete;
    FOnProjectBeforeTaskChange: TadxProjectApplicationProjectBeforeTaskChange;
    FOnProjectBeforeResourceChange: TadxProjectApplicationProjectBeforeResourceChange;
    FOnProjectBeforeAssignmentChange: TadxProjectApplicationProjectBeforeAssignmentChange;
    FOnProjectBeforeTaskNew: TadxProjectApplicationProjectBeforeTaskNew;
    FOnProjectBeforeResourceNew: TadxProjectApplicationProjectBeforeResourceNew;
    FOnProjectBeforeAssignmentNew: TadxProjectApplicationProjectBeforeAssignmentNew;
    FOnProjectBeforeClose: TadxProjectApplicationProjectBeforeClose;
    FOnProjectBeforePrint: TadxProjectApplicationProjectBeforePrint;
    FOnProjectBeforeSave: TadxProjectApplicationProjectBeforeSave;
    FOnProjectCalculate: TadxProjectApplicationProjectCalculate;
    FOnWindowGoalAreaChange: TadxProjectApplicationWindowGoalAreaChange;
    FOnWindowSelectionChange: TadxProjectApplicationWindowSelectionChange;
    FOnWindowBeforeViewChange: TadxProjectApplicationWindowBeforeViewChange;
    FOnWindowViewChange: TadxProjectApplicationWindowViewChange;
    FOnWindowActivate: TadxProjectApplicationWindowActivate;
    FOnWindowDeactivate: TadxProjectApplicationWindowDeactivate;
    FOnWindowSidepaneDisplayChange: TadxProjectApplicationWindowSidepaneDisplayChange;
    FOnWindowSidepaneTaskChange: TadxProjectApplicationWindowSidepaneTaskChange;
    FOnWorkpaneDisplayChange: TadxProjectApplicationWorkpaneDisplayChange;
    FOnLoadWebPage: TadxProjectApplicationLoadWebPage;
    FOnProjectAfterSave: TNotifyEvent;
    FOnProjectTaskNew: TadxProjectApplicationProjectTaskNew;
    FOnProjectResourceNew: TadxProjectApplicationProjectResourceNew;
    FOnProjectAssignmentNew: TadxProjectApplicationProjectAssignmentNew;
    FOnProjectBeforeSaveBaseline: TadxProjectApplicationProjectBeforeSaveBaseline;
    FOnProjectBeforeClearBaseline: TadxProjectApplicationProjectBeforeClearBaseline;
    FOnProjectBeforeClose2: TadxProjectApplicationProjectBeforeClose2;
    FOnProjectBeforePrint2: TadxProjectApplicationProjectBeforePrint2;
    FOnProjectBeforeSave2: TadxProjectApplicationProjectBeforeSave2;
    FOnProjectBeforeTaskDelete2: TadxProjectApplicationProjectBeforeTaskDelete2;
    FOnProjectBeforeResourceDelete2: TadxProjectApplicationProjectBeforeResourceDelete2;
    FOnProjectBeforeAssignmentDelete2: TadxProjectApplicationProjectBeforeAssignmentDelete2;
    FOnProjectBeforeTaskChange2: TadxProjectApplicationProjectBeforeTaskChange2;
    FOnProjectBeforeResourceChange2: TadxProjectApplicationProjectBeforeResourceChange2;
    FOnProjectBeforeAssignmentChange2: TadxProjectApplicationProjectBeforeAssignmentChange2;
    FOnProjectBeforeTaskNew2: TadxProjectApplicationProjectBeforeTaskNew2;
    FOnProjectBeforeResourceNew2: TadxProjectApplicationProjectBeforeResourceNew2;
    FOnProjectBeforeAssignmentNew2: TadxProjectApplicationProjectBeforeAssignmentNew2;
    FOnApplicationBeforeClose: TadxProjectApplicationApplicationBeforeClose;
    // 2 0 1 0
    FOnUndoOrRedo: TadxProjectApplicationOnUndoOrRedo;
    FOnAfterCubeBuilt: TadxProjectApplicationAfterCubeBuilt;
    FOnLoadWebPane: TadxProjectApplicationLoadWebPane;
    FOnJobStart: TadxProjectApplicationJobStart;
    FOnJobCompleted: TadxProjectApplicationJobCompleted;
    FOnSaveStartingToServer: TadxProjectApplicationSaveStartingToServer;
    FOnSaveCompletedToServer: TadxProjectApplicationSaveCompletedToServer;
    FOnProjectBeforePublish: TadxProjectApplicationProjectBeforePublish;
    FOnPaneActivate: TNotifyEvent;
    FOnSecondaryViewChange: TadxProjectApplicationSecondaryViewChange;
    FOnIsFunctionalitySupported: TadxProjectApplicationIsFunctionalitySupported;
    FOnConnectionStatusChanged: TadxProjectApplicationConnectionStatusChanged;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnNewProject: TadxProjectApplicationNewProject read FOnNewProject write FOnNewProject;
    property OnProjectBeforeTaskDelete: TadxProjectApplicationProjectBeforeTaskDelete read FOnProjectBeforeTaskDelete write FOnProjectBeforeTaskDelete;
    property OnProjectBeforeResourceDelete: TadxProjectApplicationProjectBeforeResourceDelete read FOnProjectBeforeResourceDelete write FOnProjectBeforeResourceDelete;
    property OnProjectBeforeAssignmentDelete: TadxProjectApplicationProjectBeforeAssignmentDelete read FOnProjectBeforeAssignmentDelete write FOnProjectBeforeAssignmentDelete;
    property OnProjectBeforeTaskChange: TadxProjectApplicationProjectBeforeTaskChange read FOnProjectBeforeTaskChange write FOnProjectBeforeTaskChange;
    property OnProjectBeforeResourceChange: TadxProjectApplicationProjectBeforeResourceChange read FOnProjectBeforeResourceChange write FOnProjectBeforeResourceChange;
    property OnProjectBeforeAssignmentChange: TadxProjectApplicationProjectBeforeAssignmentChange read FOnProjectBeforeAssignmentChange write FOnProjectBeforeAssignmentChange;
    property OnProjectBeforeTaskNew: TadxProjectApplicationProjectBeforeTaskNew read FOnProjectBeforeTaskNew write FOnProjectBeforeTaskNew;
    property OnProjectBeforeResourceNew: TadxProjectApplicationProjectBeforeResourceNew read FOnProjectBeforeResourceNew write FOnProjectBeforeResourceNew;
    property OnProjectBeforeAssignmentNew: TadxProjectApplicationProjectBeforeAssignmentNew read FOnProjectBeforeAssignmentNew write FOnProjectBeforeAssignmentNew;
    property OnProjectBeforeClose: TadxProjectApplicationProjectBeforeClose read FOnProjectBeforeClose write FOnProjectBeforeClose;
    property OnProjectBeforePrint: TadxProjectApplicationProjectBeforePrint read FOnProjectBeforePrint write FOnProjectBeforePrint;
    property OnProjectBeforeSave: TadxProjectApplicationProjectBeforeSave read FOnProjectBeforeSave write FOnProjectBeforeSave;
    property OnProjectCalculate: TadxProjectApplicationProjectCalculate read FOnProjectCalculate write FOnProjectCalculate;
    property OnWindowGoalAreaChange: TadxProjectApplicationWindowGoalAreaChange read FOnWindowGoalAreaChange write FOnWindowGoalAreaChange;
    property OnWindowSelectionChange: TadxProjectApplicationWindowSelectionChange read FOnWindowSelectionChange write FOnWindowSelectionChange;
    property OnWindowBeforeViewChange: TadxProjectApplicationWindowBeforeViewChange read FOnWindowBeforeViewChange write FOnWindowBeforeViewChange;
    property OnWindowViewChange: TadxProjectApplicationWindowViewChange read FOnWindowViewChange write FOnWindowViewChange;
    property OnWindowActivate: TadxProjectApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxProjectApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowSidepaneDisplayChange: TadxProjectApplicationWindowSidepaneDisplayChange read FOnWindowSidepaneDisplayChange write FOnWindowSidepaneDisplayChange;
    property OnWindowSidepaneTaskChange: TadxProjectApplicationWindowSidepaneTaskChange read FOnWindowSidepaneTaskChange write FOnWindowSidepaneTaskChange;
    property OnWorkpaneDisplayChange: TadxProjectApplicationWorkpaneDisplayChange read FOnWorkpaneDisplayChange write FOnWorkpaneDisplayChange;
    property OnLoadWebPage: TadxProjectApplicationLoadWebPage read FOnLoadWebPage write FOnLoadWebPage;
    property OnProjectAfterSave: TNotifyEvent read FOnProjectAfterSave write FOnProjectAfterSave;
    property OnProjectTaskNew: TadxProjectApplicationProjectTaskNew read FOnProjectTaskNew write FOnProjectTaskNew;
    property OnProjectResourceNew: TadxProjectApplicationProjectResourceNew read FOnProjectResourceNew write FOnProjectResourceNew;
    property OnProjectAssignmentNew: TadxProjectApplicationProjectAssignmentNew read FOnProjectAssignmentNew write FOnProjectAssignmentNew;
    property OnProjectBeforeSaveBaseline: TadxProjectApplicationProjectBeforeSaveBaseline read FOnProjectBeforeSaveBaseline write FOnProjectBeforeSaveBaseline;
    property OnProjectBeforeClearBaseline: TadxProjectApplicationProjectBeforeClearBaseline read FOnProjectBeforeClearBaseline write FOnProjectBeforeClearBaseline;
    property OnProjectBeforeClose2: TadxProjectApplicationProjectBeforeClose2 read FOnProjectBeforeClose2 write FOnProjectBeforeClose2;
    property OnProjectBeforePrint2: TadxProjectApplicationProjectBeforePrint2 read FOnProjectBeforePrint2 write FOnProjectBeforePrint2;
    property OnProjectBeforeSave2: TadxProjectApplicationProjectBeforeSave2 read FOnProjectBeforeSave2 write FOnProjectBeforeSave2;
    property OnProjectBeforeTaskDelete2: TadxProjectApplicationProjectBeforeTaskDelete2 read FOnProjectBeforeTaskDelete2 write FOnProjectBeforeTaskDelete2;
    property OnProjectBeforeResourceDelete2: TadxProjectApplicationProjectBeforeResourceDelete2 read FOnProjectBeforeResourceDelete2 write FOnProjectBeforeResourceDelete2;
    property OnProjectBeforeAssignmentDelete2: TadxProjectApplicationProjectBeforeAssignmentDelete2 read FOnProjectBeforeAssignmentDelete2 write FOnProjectBeforeAssignmentDelete2;
    property OnProjectBeforeTaskChange2: TadxProjectApplicationProjectBeforeTaskChange2 read FOnProjectBeforeTaskChange2 write FOnProjectBeforeTaskChange2;
    property OnProjectBeforeResourceChange2: TadxProjectApplicationProjectBeforeResourceChange2 read FOnProjectBeforeResourceChange2 write FOnProjectBeforeResourceChange2;
    property OnProjectBeforeAssignmentChange2: TadxProjectApplicationProjectBeforeAssignmentChange2 read FOnProjectBeforeAssignmentChange2 write FOnProjectBeforeAssignmentChange2;
    property OnProjectBeforeTaskNew2: TadxProjectApplicationProjectBeforeTaskNew2 read FOnProjectBeforeTaskNew2 write FOnProjectBeforeTaskNew2;
    property OnProjectBeforeResourceNew2: TadxProjectApplicationProjectBeforeResourceNew2 read FOnProjectBeforeResourceNew2 write FOnProjectBeforeResourceNew2;
    property OnProjectBeforeAssignmentNew2: TadxProjectApplicationProjectBeforeAssignmentNew2 read FOnProjectBeforeAssignmentNew2 write FOnProjectBeforeAssignmentNew2;
    property OnApplicationBeforeClose: TadxProjectApplicationApplicationBeforeClose read FOnApplicationBeforeClose write FOnApplicationBeforeClose;
    // 2 0 1 0
    property OnUndoOrRedo: TadxProjectApplicationOnUndoOrRedo read FOnUndoOrRedo write FOnUndoOrRedo;
    property OnAfterCubeBuilt: TadxProjectApplicationAfterCubeBuilt read FOnAfterCubeBuilt write FOnAfterCubeBuilt;
    property OnLoadWebPane: TadxProjectApplicationLoadWebPane read FOnLoadWebPane write FOnLoadWebPane;
    property OnJobStart: TadxProjectApplicationJobStart read FOnJobStart write FOnJobStart;
    property OnJobCompleted: TadxProjectApplicationJobCompleted read FOnJobCompleted write FOnJobCompleted;
    property OnSaveStartingToServer: TadxProjectApplicationSaveStartingToServer read FOnSaveStartingToServer write FOnSaveStartingToServer;
    property OnSaveCompletedToServer: TadxProjectApplicationSaveCompletedToServer read FOnSaveCompletedToServer write FOnSaveCompletedToServer;
    property OnProjectBeforePublish: TadxProjectApplicationProjectBeforePublish read FOnProjectBeforePublish write FOnProjectBeforePublish;
    property OnPaneActivate: TNotifyEvent read FOnPaneActivate write FOnPaneActivate;
    property OnSecondaryViewChange: TadxProjectApplicationSecondaryViewChange read FOnSecondaryViewChange write FOnSecondaryViewChange;
    property OnIsFunctionalitySupported: TadxProjectApplicationIsFunctionalitySupported read FOnIsFunctionalitySupported write FOnIsFunctionalitySupported;
    property OnConnectionStatusChanged: TadxProjectApplicationConnectionStatusChanged read FOnConnectionStatusChanged write FOnConnectionStatusChanged;
  end;

  TadxPowerPointApplicationWindowSelectionChange = procedure(ASender: TObject; const Sel: MSPPt2000.Selection) of object;
  TadxPowerPointApplicationWindowBeforeRightClick = procedure(ASender: TObject; const Sel: MSPPt2000.Selection;
    var Cancel: WordBool) of object;
  TadxPowerPointApplicationWindowBeforeDoubleClick = procedure(ASender: TObject; const Sel: MSPPt2000.Selection;
    var Cancel: WordBool) of object;
  TadxPowerPointApplicationPresentationClose = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationPresentationSave = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationPresentationOpen = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationNewPresentation = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationPresentationNewSlide = procedure(ASender: TObject; const Sld: PowerPointSlide) of object;
  TadxPowerPointApplicationWindowActivate = procedure(ASender: TObject; const Pres: PowerPointPresentation;
    const Wn: DocumentWindow) of object;
  TadxPowerPointApplicationWindowDeactivate = procedure(ASender: TObject; const Pres: PowerPointPresentation;
    const Wn: DocumentWindow) of object;
  TadxPowerPointApplicationSlideShowBegin = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TadxPowerPointApplicationSlideShowNextBuild = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TadxPowerPointApplicationSlideShowNextSlide = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TadxPowerPointApplicationSlideShowEnd = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationPresentationPrint = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationSlideSelectionChanged = procedure(ASender: TObject; const SldRange: IDispatch) of object;
  TadxPowerPointApplicationColorSchemeChanged = procedure(ASender: TObject; const SldRange: IDispatch) of object;
  TadxPowerPointApplicationPresentationBeforeSave = procedure(ASender: TObject; const Pres: PowerPointPresentation;
    var Cancel: WordBool) of object;
  TadxPowerPointApplicationSlideShowNextClick = procedure(ASender: TObject; const Wn: SlideShowWindow;
    const nEffect: IDispatch) of object;
  TadxPowerPointApplicationAfterNewPresentation = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationAfterPresentationOpen = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TadxPowerPointApplicationPresentationSync = procedure(ASender: TObject; const Pres: PowerPointPresentation;
    SyncEventType: TOleEnum) of object;
  TadxPowerPointApplicationSlideShowOnNext = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TadxPowerPointApplicationSlideShowOnPrevious = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TadxPowerPointApplicationPresentationBeforeClose = procedure(ASender: TObject;
    const Pres: PowerPointPresentation; var Cancel: WordBool) of object;
  TadxPowerPointApplicationProtectedViewWindowOpen = procedure(ASender: TObject;
    const ProtViewWindow: IDispatch) of object;
  TadxPowerPointApplicationProtectedViewWindowBeforeEdit = procedure(ASender: TObject;
    const ProtViewWindow: IDispatch; var Cancel: WordBool) of object;
  TadxPowerPointApplicationProtectedViewWindowBeforeClose = procedure(ASender: TObject;
    const ProtViewWindow: IDispatch;
    ProtectedViewCloseReason: TOleEnum; var Cancel: WordBool) of object;
  TadxPowerPointApplicationProtectedViewWindowActivate = procedure(ASender: TObject;
    const ProtViewWindow: IDispatch) of object;
  TadxPowerPointApplicationProtectedViewWindowDeactivate = procedure(ASender: TObject;
    const ProtViewWindow: IDispatch) of object;
  TadxPowerPointApplicationPresentationCloseFinal = procedure(ASender: TObject;
    const Pres: PowerPointPresentation) of object;

  TadxPowerPointAppEvents = class(TadxCustomEvents)
  private
    FIntf: MSPPt2000._Application;
    FOnWindowSelectionChange: TadxPowerPointApplicationWindowSelectionChange;
    FOnWindowBeforeRightClick: TadxPowerPointApplicationWindowBeforeRightClick;
    FOnWindowBeforeDoubleClick: TadxPowerPointApplicationWindowBeforeDoubleClick;
    FOnPresentationClose: TadxPowerPointApplicationPresentationClose;
    FOnPresentationSave: TadxPowerPointApplicationPresentationSave;
    FOnPresentationOpen: TadxPowerPointApplicationPresentationOpen;
    FOnNewPresentation: TadxPowerPointApplicationNewPresentation;
    FOnPresentationNewSlide: TadxPowerPointApplicationPresentationNewSlide;
    FOnWindowActivate: TadxPowerPointApplicationWindowActivate;
    FOnWindowDeactivate: TadxPowerPointApplicationWindowDeactivate;
    FOnSlideShowBegin: TadxPowerPointApplicationSlideShowBegin;
    FOnSlideShowNextBuild: TadxPowerPointApplicationSlideShowNextBuild;
    FOnSlideShowNextSlide: TadxPowerPointApplicationSlideShowNextSlide;
    FOnSlideShowEnd: TadxPowerPointApplicationSlideShowEnd;
    FOnPresentationPrint: TadxPowerPointApplicationPresentationPrint;
    FOnSlideSelectionChanged: TadxPowerPointApplicationSlideSelectionChanged;
    FOnColorSchemeChanged: TadxPowerPointApplicationColorSchemeChanged;
    FOnPresentationBeforeSave: TadxPowerPointApplicationPresentationBeforeSave;
    FOnSlideShowNextClick: TadxPowerPointApplicationSlideShowNextClick;
    FOnAfterNewPresentation: TadxPowerPointApplicationAfterNewPresentation;
    FOnAfterPresentationOpen: TadxPowerPointApplicationAfterPresentationOpen;
    FOnPresentationSync: TadxPowerPointApplicationPresentationSync;
    FOnSlideShowOnNext: TadxPowerPointApplicationSlideShowOnNext;
    FOnSlideShowOnPrevious: TadxPowerPointApplicationSlideShowOnPrevious;
    // 2 0 1 0
    FOnPresentationBeforeClose: TadxPowerPointApplicationPresentationBeforeClose;
    FOnProtectedViewWindowOpen: TadxPowerPointApplicationProtectedViewWindowOpen;
    FOnProtectedViewWindowBeforeEdit: TadxPowerPointApplicationProtectedViewWindowBeforeEdit;
    FOnProtectedViewWindowBeforeClose: TadxPowerPointApplicationProtectedViewWindowBeforeClose;
    FOnProtectedViewWindowActivate: TadxPowerPointApplicationProtectedViewWindowActivate;
    FOnProtectedViewWindowDeactivate: TadxPowerPointApplicationProtectedViewWindowDeactivate;
    FOnPresentationCloseFinal: TadxPowerPointApplicationPresentationCloseFinal;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnWindowSelectionChange: TadxPowerPointApplicationWindowSelectionChange read FOnWindowSelectionChange write FOnWindowSelectionChange;
    property OnWindowBeforeRightClick: TadxPowerPointApplicationWindowBeforeRightClick read FOnWindowBeforeRightClick write FOnWindowBeforeRightClick;
    property OnWindowBeforeDoubleClick: TadxPowerPointApplicationWindowBeforeDoubleClick read FOnWindowBeforeDoubleClick write FOnWindowBeforeDoubleClick;
    property OnPresentationClose: TadxPowerPointApplicationPresentationClose read FOnPresentationClose write FOnPresentationClose;
    property OnPresentationSave: TadxPowerPointApplicationPresentationSave read FOnPresentationSave write FOnPresentationSave;
    property OnPresentationOpen: TadxPowerPointApplicationPresentationOpen read FOnPresentationOpen write FOnPresentationOpen;
    property OnNewPresentation: TadxPowerPointApplicationNewPresentation read FOnNewPresentation write FOnNewPresentation;
    property OnPresentationNewSlide: TadxPowerPointApplicationPresentationNewSlide read FOnPresentationNewSlide write FOnPresentationNewSlide;
    property OnWindowActivate: TadxPowerPointApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxPowerPointApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnSlideShowBegin: TadxPowerPointApplicationSlideShowBegin read FOnSlideShowBegin write FOnSlideShowBegin;
    property OnSlideShowNextBuild: TadxPowerPointApplicationSlideShowNextBuild read FOnSlideShowNextBuild write FOnSlideShowNextBuild;
    property OnSlideShowNextSlide: TadxPowerPointApplicationSlideShowNextSlide read FOnSlideShowNextSlide write FOnSlideShowNextSlide;
    property OnSlideShowEnd: TadxPowerPointApplicationSlideShowEnd read FOnSlideShowEnd write FOnSlideShowEnd;
    property OnPresentationPrint: TadxPowerPointApplicationPresentationPrint read FOnPresentationPrint write FOnPresentationPrint;
    property OnSlideSelectionChanged: TadxPowerPointApplicationSlideSelectionChanged read FOnSlideSelectionChanged write FOnSlideSelectionChanged;
    property OnColorSchemeChanged: TadxPowerPointApplicationColorSchemeChanged read FOnColorSchemeChanged write FOnColorSchemeChanged;
    property OnPresentationBeforeSave: TadxPowerPointApplicationPresentationBeforeSave read FOnPresentationBeforeSave write FOnPresentationBeforeSave;
    property OnSlideShowNextClick: TadxPowerPointApplicationSlideShowNextClick read FOnSlideShowNextClick write FOnSlideShowNextClick;
    property OnAfterNewPresentation: TadxPowerPointApplicationAfterNewPresentation read FOnAfterNewPresentation write FOnAfterNewPresentation;
    property OnAfterPresentationOpen: TadxPowerPointApplicationAfterPresentationOpen read FOnAfterPresentationOpen write FOnAfterPresentationOpen;
    property OnPresentationSync: TadxPowerPointApplicationPresentationSync read FOnPresentationSync write FOnPresentationSync;
    // 2 0 0 7
    property OnSlideShowOnNext: TadxPowerPointApplicationSlideShowOnNext read FOnSlideShowOnNext write FOnSlideShowOnNext;
    property OnSlideShowOnPrevious: TadxPowerPointApplicationSlideShowOnPrevious read FOnSlideShowOnPrevious write FOnSlideShowOnPrevious;
    // 2 0 1 0
    property OnPresentationBeforeClose: TadxPowerPointApplicationPresentationBeforeClose read FOnPresentationBeforeClose write FOnPresentationBeforeClose;
    property OnProtectedViewWindowOpen: TadxPowerPointApplicationProtectedViewWindowOpen read FOnProtectedViewWindowOpen write FOnProtectedViewWindowOpen;
    property OnProtectedViewWindowBeforeEdit: TadxPowerPointApplicationProtectedViewWindowBeforeEdit read FOnProtectedViewWindowBeforeEdit write FOnProtectedViewWindowBeforeEdit;
    property OnProtectedViewWindowBeforeClose: TadxPowerPointApplicationProtectedViewWindowBeforeClose read FOnProtectedViewWindowBeforeClose write FOnProtectedViewWindowBeforeClose;
    property OnProtectedViewWindowActivate: TadxPowerPointApplicationProtectedViewWindowActivate read FOnProtectedViewWindowActivate write FOnProtectedViewWindowActivate;
    property OnProtectedViewWindowDeactivate: TadxPowerPointApplicationProtectedViewWindowDeactivate read FOnProtectedViewWindowDeactivate write FOnProtectedViewWindowDeactivate;
    property OnPresentationCloseFinal: TadxPowerPointApplicationPresentationCloseFinal read FOnPresentationCloseFinal write FOnPresentationCloseFinal;
  end;

  TadxFrontPageApplicationOnWebNew = procedure(Sender: TObject; const pWeb: Web) of object;
  TadxFrontPageApplicationOnWebOpen = procedure(Sender: TObject; const pWeb: Web) of object;
  TadxFrontPageApplicationOnWebClose = procedure(Sender: TObject; const pWeb: Web;
    var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnBeforeWebPublish = procedure(Sender: TObject; const pWeb: Web;
    var Destination: WideString; var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnAfterWebPublish = procedure(Sender: TObject; const pWeb: Web;
    var Success: WordBool) of object;
  TadxFrontPageApplicationOnPageNew = procedure(Sender: TObject; const pPage: PageWindow) of object;
  TadxFrontPageApplicationOnPageOpen = procedure(Sender: TObject; const pPage: PageWindow) of object;
  TadxFrontPageApplicationOnPageClose = procedure(Sender: TObject; const pPage: PageWindow;
    var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnBeforePageSave = procedure(Sender: TObject; const pPage: PageWindow;
    var SaveAsUI: WordBool; var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnAfterPageSave = procedure(Sender: TObject; const pPage: PageWindow;
    var Success: WordBool) of object;
  TadxFrontPageApplicationWindowActivate = procedure(Sender: TObject; const pWebWindow: WebWindow) of object;
  TadxFrontPageApplicationWindowDeactivate = procedure(Sender: TObject; const pWebWindow: WebWindow) of object;

  TadxFrontPageApplicationOnBeforeWebWindowViewChange = procedure(Sender: TObject;
    const pWebWindow: WebWindow; TargetView: TOleEnum; var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnAfterWebWindowViewChange = procedure(Sender: TObject;
    const pWebWindow: WebWindow) of object;
  TadxFrontPageApplicationOnRecalculateHyperlinks = procedure(Sender: TObject; const pWeb: Web;
    var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnBeforePageWindowViewChange = procedure(Sender: TObject; const pPage: PageWindow;
    TargetView: FpPageViewMode; var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnAfterPageWindowViewChange = procedure(Sender: TObject; const pPage: PageWindow) of object;
  TadxFrontPageApplicationOnPageWindowActivate = procedure(Sender: TObject; const pPage: PageWindow) of object;
  TadxFrontPageApplicationOnWebFileCheckOut = procedure(Sender: TObject; const pWeb: Web;
    const pFile: WebFile; var CheckedOut: WordBool; var pCheckOutOption: TOleEnum) of object;
  TadxFrontPageApplicationOnBeforeWebWindowSubViewChange = procedure(Sender: TObject; const pWebWindow: WebWindow;
    TargetSubView: TOleEnum; var Cancel: WordBool) of object;
  TadxFrontPageApplicationOnAfterWebWindowSubViewChange = procedure(Sender: TObject; const pWebWindow: WebWindow) of object;

  TadxFrontPageAppEvents = class(TadxCustomEvents)
  private
    FIntf: FrontPage2000._Application;
    FOnWebNew: TadxFrontPageApplicationOnWebNew;
    FOnWebOpen: TadxFrontPageApplicationOnWebOpen;
    FOnWebClose: TadxFrontPageApplicationOnWebClose;
    FOnBeforeWebPublish: TadxFrontPageApplicationOnBeforeWebPublish;
    FOnAfterWebPublish: TadxFrontPageApplicationOnAfterWebPublish;
    FOnPageNew: TadxFrontPageApplicationOnPageNew;
    FOnPageOpen: TadxFrontPageApplicationOnPageOpen;
    FOnPageClose: TadxFrontPageApplicationOnPageClose;
    FOnBeforePageSave: TadxFrontPageApplicationOnBeforePageSave;
    FOnAfterPageSave: TadxFrontPageApplicationOnAfterPageSave;
    FOnWindowActivate: TadxFrontPageApplicationWindowActivate;
    FOnWindowDeactivate: TadxFrontPageApplicationWindowDeactivate;
    FOnBeforeWebWindowViewChange: TadxFrontPageApplicationOnBeforeWebWindowViewChange;
    FOnAfterWebWindowViewChange: TadxFrontPageApplicationOnAfterWebWindowViewChange;
    FOnRecalculateHyperlinks: TadxFrontPageApplicationOnRecalculateHyperlinks;
    FOnBeforePageWindowViewChange: TadxFrontPageApplicationOnBeforePageWindowViewChange;
    FOnAfterPageWindowViewChange: TadxFrontPageApplicationOnAfterPageWindowViewChange;
    FOnPageWindowActivate: TadxFrontPageApplicationOnPageWindowActivate;
    FOnWebFileCheckOut: TadxFrontPageApplicationOnWebFileCheckOut;
    FOnBeforeWebWindowSubViewChange: TadxFrontPageApplicationOnBeforeWebWindowSubViewChange;
    FOnAfterWebWindowSubViewChange: TadxFrontPageApplicationOnAfterWebWindowSubViewChange;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnWebNew: TadxFrontPageApplicationOnWebNew read FOnWebNew write FOnWebNew;
    property OnWebOpen: TadxFrontPageApplicationOnWebOpen read FOnWebOpen write FOnWebOpen;
    property OnWebClose: TadxFrontPageApplicationOnWebClose read FOnWebClose write FOnWebClose;
    property OnBeforeWebPublish: TadxFrontPageApplicationOnBeforeWebPublish read FOnBeforeWebPublish write FOnBeforeWebPublish;
    property OnAfterWebPublish: TadxFrontPageApplicationOnAfterWebPublish read FOnAfterWebPublish write FOnAfterWebPublish;
    property OnPageNew: TadxFrontPageApplicationOnPageNew read FOnPageNew write FOnPageNew;
    property OnPageOpen: TadxFrontPageApplicationOnPageOpen read FOnPageOpen write FOnPageOpen;
    property OnPageClose: TadxFrontPageApplicationOnPageClose read FOnPageClose write FOnPageClose;
    property OnBeforePageSave: TadxFrontPageApplicationOnBeforePageSave read FOnBeforePageSave write FOnBeforePageSave;
    property OnAfterPageSave: TadxFrontPageApplicationOnAfterPageSave read FOnAfterPageSave write FOnAfterPageSave;
    property OnWindowActivate: TadxFrontPageApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxFrontPageApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnBeforeWebWindowViewChange: TadxFrontPageApplicationOnBeforeWebWindowViewChange read FOnBeforeWebWindowViewChange write FOnBeforeWebWindowViewChange;
    property OnAfterWebWindowViewChange: TadxFrontPageApplicationOnAfterWebWindowViewChange read FOnAfterWebWindowViewChange write FOnAfterWebWindowViewChange;
    property OnRecalculateHyperlinks: TadxFrontPageApplicationOnRecalculateHyperlinks read FOnRecalculateHyperlinks write FOnRecalculateHyperlinks;
    property OnBeforePageWindowViewChange: TadxFrontPageApplicationOnBeforePageWindowViewChange read FOnBeforePageWindowViewChange write FOnBeforePageWindowViewChange;
    property OnAfterPageWindowViewChange: TadxFrontPageApplicationOnAfterPageWindowViewChange read FOnAfterPageWindowViewChange write FOnAfterPageWindowViewChange;
    property OnPageWindowActivate: TadxFrontPageApplicationOnPageWindowActivate read FOnPageWindowActivate write FOnPageWindowActivate;
    property OnWebFileCheckOut: TadxFrontPageApplicationOnWebFileCheckOut read FOnWebFileCheckOut write FOnWebFileCheckOut;
    property OnBeforeWebWindowSubViewChange: TadxFrontPageApplicationOnBeforeWebWindowSubViewChange read FOnBeforeWebWindowSubViewChange write FOnBeforeWebWindowSubViewChange;
    property OnAfterWebWindowSubViewChange: TadxFrontPageApplicationOnAfterWebWindowSubViewChange read FOnAfterWebWindowSubViewChange write FOnAfterWebWindowSubViewChange;
  end;

  TadxVisioApplicationAppActivated = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAppDeactivated = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAppObjActivated = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAppObjDeactivated = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationBeforeQuit = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationBeforeModal = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAfterModal = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationWindowOpened = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationSelectionChanged = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationBeforeWindowClosed = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationWindowActivated = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationBeforeWindowSelDelete = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationBeforeWindowPageTurn = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationWindowTurnedToPage = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationDocumentOpened = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDocumentCreated = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDocumentSaved = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDocumentSavedAs = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDocumentChanged = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationBeforeDocumentClose = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationStyleAdded = procedure(ASender: TObject; const Style: IVStyle) of object;
  TadxVisioApplicationStyleChanged = procedure(ASender: TObject; const Style: IVStyle) of object;
  TadxVisioApplicationBeforeStyleDelete = procedure(ASender: TObject; const Style: IVStyle) of object;
  TadxVisioApplicationMasterAdded = procedure(ASender: TObject; const Master: IVMaster) of object;
  TadxVisioApplicationMasterChanged = procedure(ASender: TObject; const Master: IVMaster) of object;
  TadxVisioApplicationBeforeMasterDelete = procedure(ASender: TObject; const Master: IVMaster) of object;
  TadxVisioApplicationPageAdded = procedure(ASender: TObject; const Page: IVPage) of object;
  TadxVisioApplicationPageChanged = procedure(ASender: TObject; const Page: IVPage) of object;
  TadxVisioApplicationBeforePageDelete = procedure(ASender: TObject; const Page: IVPage) of object;
  TadxVisioApplicationShapeAdded = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationBeforeSelectionDelete = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationShapeChanged = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationSelectionAdded = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationBeforeShapeDelete = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationTextChanged = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationCellChanged = procedure(ASender: TObject; const Cell: IVCell) of object;
  TadxVisioApplicationMarkerEvent = procedure(ASender: TObject; const app: IVApplication;
    SequenceNum: Integer; const ContextString: WideString) of object;
  TadxVisioApplicationNoEventsPending = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationVisioIsIdle = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationMustFlushScopeBeginning = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationMustFlushScopeEnded = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationRunModeEntered = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDesignModeEntered = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationBeforeDocumentSave = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationBeforeDocumentSaveAs = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationFormulaChanged = procedure(ASender: TObject; const Cell: IVCell) of object;
  TadxVisioApplicationConnectionsAdded = procedure(ASender: TObject; const Connects: IVConnects) of object;
  TadxVisioApplicationConnectionsDeleted = procedure(ASender: TObject; const Connects: IVConnects) of object;
  TadxVisioApplicationEnterScope = procedure(ASender: TObject; const app: IVApplication;
    nScopeID: Integer; const bstrDescription: WideString) of object;
  TadxVisioApplicationExitScope = procedure(ASender: TObject; const app: IVApplication;
    nScopeID: Integer; const bstrDescription: WideString; bErrOrCancelled: WordBool) of object;
  TadxVisioApplicationQueryCancelQuit = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationQuitCanceled = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationWindowChanged = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationViewChanged = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationQueryCancelWindowClose = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationWindowCloseCanceled = procedure(ASender: TObject; const Window: IVWindow) of object;
  TadxVisioApplicationQueryCancelDocumentClose = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationDocumentCloseCanceled = procedure(ASender: TObject; const doc: IVDocument) of object;
  TadxVisioApplicationQueryCancelStyleDelete = procedure(ASender: TObject; const Style: IVStyle) of object;
  TadxVisioApplicationStyleDeleteCanceled = procedure(ASender: TObject; const Style: IVStyle) of object;
  TadxVisioApplicationQueryCancelMasterDelete = procedure(ASender: TObject; const Master: IVMaster) of object;
  TadxVisioApplicationMasterDeleteCanceled = procedure(ASender: TObject; const Master: IVMaster) of object;
  TadxVisioApplicationQueryCancelPageDelete = procedure(ASender: TObject; const Page: IVPage) of object;
  TadxVisioApplicationPageDeleteCanceled = procedure(ASender: TObject; const Page: IVPage) of object;
  TadxVisioApplicationShapeParentChanged = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationBeforeShapeTextEdit = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationShapeExitedTextEdit = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationQueryCancelSelectionDelete = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationSelectionDeleteCanceled = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationQueryCancelUngroup = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationUngroupCanceled = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationQueryCancelConvertToGroup = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationConvertToGroupCanceled = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationQueryCancelSuspend = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationSuspendCanceled = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationBeforeSuspend = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAfterResume = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationOnKeystrokeMessageForAddon = procedure(ASender: TObject; const MSG: IVMSGWrap) of object;
  TadxVisioApplicationMouseDown = procedure(ASender: TObject; Button: Integer;
    KeyButtonState: Integer; x: Double; y: Double; var CancelDefault: WordBool) of object;
  TadxVisioApplicationMouseMove = procedure(ASender: TObject; Button: Integer;
    KeyButtonState: Integer; x: Double; y: Double; var CancelDefault: WordBool) of object;
  TadxVisioApplicationMouseUp = procedure(ASender: TObject; Button: Integer; KeyButtonState: Integer;
    x: Double; y: Double; var CancelDefault: WordBool) of object;
  TadxVisioApplicationKeyDown = procedure(ASender: TObject; KeyCode: Integer; KeyButtonState: Integer;
    var CancelDefault: WordBool) of object;
  TadxVisioApplicationKeyPress = procedure(ASender: TObject; KeyAscii: Integer;
    var CancelDefault: WordBool) of object;
  TadxVisioApplicationKeyUp = procedure(ASender: TObject; KeyCode: Integer; KeyButtonState: Integer;
    var CancelDefault: WordBool) of object;
  TadxVisioApplicationQueryCancelSuspendEvents = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationSuspendEventsCanceled = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationBeforeSuspendEvents = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationAfterResumeEvents = procedure(ASender: TObject; const app: IVApplication) of object;
  TadxVisioApplicationQueryCancelGroup = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationGroupCanceled = procedure(ASender: TObject; const Selection: IVSelection) of object;
  TadxVisioApplicationShapeDataGraphicChanged = procedure(ASender: TObject; const Shape: IVShape) of object;
  TadxVisioApplicationBeforeDataRecordsetDelete = procedure(ASender: TObject; const DataRecordset: IDispatch) of object;
  TadxVisioApplicationDataRecordsetChanged = procedure(ASender: TObject; const DataRecordsetChanged: IDispatch) of object;
  TadxVisioApplicationDataRecordsetAdded = procedure(ASender: TObject; const DataRecordset: IDispatch) of object;
  TadxVisioApplicationShapeLinkAdded = procedure(ASender: TObject;
    const Shape: IVShape; DataRecordsetID: Integer; DataRowID: Integer) of object;
  TadxVisioApplicationShapeLinkDeleted = procedure(ASender: TObject;
    const Shape: IVShape; DataRecordsetID: Integer; DataRowID: Integer) of object;
  TadxVisioApplicationAfterRemoveHiddenInformation = procedure(ASender: TObject; const Doc: IVDocument) of object;
  TadxVisioApplicationContainerRelationshipAdded = procedure(ASender: TObject; const ShapePair: IDispatch) of object;
  TadxVisioApplicationContainerRelationshipDeleted = procedure(ASender: TObject; const ShapePair: IDispatch) of object;
  TadxVisioApplicationCalloutRelationshipAdded = procedure(ASender: TObject; const ShapePair: IDispatch) of object;
  TadxVisioApplicationCalloutRelationshipDeleted = procedure(ASender: TObject; const ShapePair: IDispatch) of object;
  TadxVisioApplicationRuleSetValidated = procedure(ASender: TObject; const RuleSet: IDispatch) of object;

  TadxVisioAppEvents = class(TadxCustomEvents)
  private
    FIntf: Visio2002.VisioApplication;
    FOnAppActivated: TadxVisioApplicationAppActivated;
    FOnAppDeactivated: TadxVisioApplicationAppDeactivated;
    FOnAppObjActivated: TadxVisioApplicationAppObjActivated;
    FOnAppObjDeactivated: TadxVisioApplicationAppObjDeactivated;
    FOnBeforeQuit: TadxVisioApplicationBeforeQuit;
    FOnBeforeModal: TadxVisioApplicationBeforeModal;
    FOnAfterModal: TadxVisioApplicationAfterModal;
    FOnWindowOpened: TadxVisioApplicationWindowOpened;
    FOnSelectionChanged: TadxVisioApplicationSelectionChanged;
    FOnBeforeWindowClosed: TadxVisioApplicationBeforeWindowClosed;
    FOnWindowActivated: TadxVisioApplicationWindowActivated;
    FOnBeforeWindowSelDelete: TadxVisioApplicationBeforeWindowSelDelete;
    FOnBeforeWindowPageTurn: TadxVisioApplicationBeforeWindowPageTurn;
    FOnWindowTurnedToPage: TadxVisioApplicationWindowTurnedToPage;
    FOnDocumentOpened: TadxVisioApplicationDocumentOpened;
    FOnDocumentCreated: TadxVisioApplicationDocumentCreated;
    FOnDocumentSaved: TadxVisioApplicationDocumentSaved;
    FOnDocumentSavedAs: TadxVisioApplicationDocumentSavedAs;
    FOnDocumentChanged: TadxVisioApplicationDocumentChanged;
    FOnBeforeDocumentClose: TadxVisioApplicationBeforeDocumentClose;
    FOnStyleAdded: TadxVisioApplicationStyleAdded;
    FOnStyleChanged: TadxVisioApplicationStyleChanged;
    FOnBeforeStyleDelete: TadxVisioApplicationBeforeStyleDelete;
    FOnMasterAdded: TadxVisioApplicationMasterAdded;
    FOnMasterChanged: TadxVisioApplicationMasterChanged;
    FOnBeforeMasterDelete: TadxVisioApplicationBeforeMasterDelete;
    FOnPageAdded: TadxVisioApplicationPageAdded;
    FOnPageChanged: TadxVisioApplicationPageChanged;
    FOnBeforePageDelete: TadxVisioApplicationBeforePageDelete;
    FOnShapeAdded: TadxVisioApplicationShapeAdded;
    FOnBeforeSelectionDelete: TadxVisioApplicationBeforeSelectionDelete;
    FOnShapeChanged: TadxVisioApplicationShapeChanged;
    FOnSelectionAdded: TadxVisioApplicationSelectionAdded;
    FOnBeforeShapeDelete: TadxVisioApplicationBeforeShapeDelete;
    FOnTextChanged: TadxVisioApplicationTextChanged;
    FOnCellChanged: TadxVisioApplicationCellChanged;
    FOnMarkerEvent: TadxVisioApplicationMarkerEvent;
    FOnNoEventsPending: TadxVisioApplicationNoEventsPending;
    FOnVisioIsIdle: TadxVisioApplicationVisioIsIdle;
    FOnMustFlushScopeBeginning: TadxVisioApplicationMustFlushScopeBeginning;
    FOnMustFlushScopeEnded: TadxVisioApplicationMustFlushScopeEnded;
    FOnRunModeEntered: TadxVisioApplicationRunModeEntered;
    FOnDesignModeEntered: TadxVisioApplicationDesignModeEntered;
    FOnBeforeDocumentSave: TadxVisioApplicationBeforeDocumentSave;
    FOnBeforeDocumentSaveAs: TadxVisioApplicationBeforeDocumentSaveAs;
    FOnFormulaChanged: TadxVisioApplicationFormulaChanged;
    FOnConnectionsAdded: TadxVisioApplicationConnectionsAdded;
    FOnConnectionsDeleted: TadxVisioApplicationConnectionsDeleted;
    FOnEnterScope: TadxVisioApplicationEnterScope;
    FOnExitScope: TadxVisioApplicationExitScope;
    FOnQueryCancelQuit: TadxVisioApplicationQueryCancelQuit;
    FOnQuitCanceled: TadxVisioApplicationQuitCanceled;
    FOnWindowChanged: TadxVisioApplicationWindowChanged;
    FOnViewChanged: TadxVisioApplicationViewChanged;
    FOnQueryCancelWindowClose: TadxVisioApplicationQueryCancelWindowClose;
    FOnWindowCloseCanceled: TadxVisioApplicationWindowCloseCanceled;
    FOnQueryCancelDocumentClose: TadxVisioApplicationQueryCancelDocumentClose;
    FOnDocumentCloseCanceled: TadxVisioApplicationDocumentCloseCanceled;
    FOnQueryCancelStyleDelete: TadxVisioApplicationQueryCancelStyleDelete;
    FOnStyleDeleteCanceled: TadxVisioApplicationStyleDeleteCanceled;
    FOnQueryCancelMasterDelete: TadxVisioApplicationQueryCancelMasterDelete;
    FOnMasterDeleteCanceled: TadxVisioApplicationMasterDeleteCanceled;
    FOnQueryCancelPageDelete: TadxVisioApplicationQueryCancelPageDelete;
    FOnPageDeleteCanceled: TadxVisioApplicationPageDeleteCanceled;
    FOnShapeParentChanged: TadxVisioApplicationShapeParentChanged;
    FOnBeforeShapeTextEdit: TadxVisioApplicationBeforeShapeTextEdit;
    FOnShapeExitedTextEdit: TadxVisioApplicationShapeExitedTextEdit;
    FOnQueryCancelSelectionDelete: TadxVisioApplicationQueryCancelSelectionDelete;
    FOnSelectionDeleteCanceled: TadxVisioApplicationSelectionDeleteCanceled;
    FOnQueryCancelUngroup: TadxVisioApplicationQueryCancelUngroup;
    FOnUngroupCanceled: TadxVisioApplicationUngroupCanceled;
    FOnQueryCancelConvertToGroup: TadxVisioApplicationQueryCancelConvertToGroup;
    FOnConvertToGroupCanceled: TadxVisioApplicationConvertToGroupCanceled;
    FOnQueryCancelSuspend: TadxVisioApplicationQueryCancelSuspend;
    FOnSuspendCanceled: TadxVisioApplicationSuspendCanceled;
    FOnBeforeSuspend: TadxVisioApplicationBeforeSuspend;
    FOnAfterResume: TadxVisioApplicationAfterResume;
    FOnKeystrokeMessageForAddon: TadxVisioApplicationOnKeystrokeMessageForAddon;
    FOnMouseDown: TadxVisioApplicationMouseDown;
    FOnMouseMove: TadxVisioApplicationMouseMove;
    FOnMouseUp: TadxVisioApplicationMouseUp;
    FOnKeyDown: TadxVisioApplicationKeyDown;
    FOnKeyPress: TadxVisioApplicationKeyPress;
    FOnKeyUp: TadxVisioApplicationKeyUp;
    // 2 0 1 0
    FOnQueryCancelSuspendEvents: TadxVisioApplicationQueryCancelSuspendEvents;
    FOnSuspendEventsCanceled: TadxVisioApplicationSuspendEventsCanceled;
    FOnBeforeSuspendEvents: TadxVisioApplicationBeforeSuspendEvents;
    FOnAfterResumeEvents: TadxVisioApplicationAfterResumeEvents;
    FOnQueryCancelGroup: TadxVisioApplicationQueryCancelGroup;
    FOnGroupCanceled: TadxVisioApplicationGroupCanceled;
    FOnShapeDataGraphicChanged: TadxVisioApplicationShapeDataGraphicChanged;
    FOnBeforeDataRecordsetDelete: TadxVisioApplicationBeforeDataRecordsetDelete;
    FOnDataRecordsetChanged: TadxVisioApplicationDataRecordsetChanged;
    FOnDataRecordsetAdded: TadxVisioApplicationDataRecordsetAdded;
    FOnShapeLinkAdded: TadxVisioApplicationShapeLinkAdded;
    FOnShapeLinkDeleted: TadxVisioApplicationShapeLinkDeleted;
    FOnAfterRemoveHiddenInformation: TadxVisioApplicationAfterRemoveHiddenInformation;
    FOnContainerRelationshipAdded: TadxVisioApplicationContainerRelationshipAdded;
    FOnContainerRelationshipDeleted: TadxVisioApplicationContainerRelationshipDeleted;
    FOnCalloutRelationshipAdded: TadxVisioApplicationCalloutRelationshipAdded;
    FOnCalloutRelationshipDeleted: TadxVisioApplicationCalloutRelationshipDeleted;
    FOnRuleSetValidated: TadxVisioApplicationRuleSetValidated;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnAppActivated: TadxVisioApplicationAppActivated read FOnAppActivated write FOnAppActivated;
    property OnAppDeactivated: TadxVisioApplicationAppDeactivated read FOnAppDeactivated write FOnAppDeactivated;
    property OnAppObjActivated: TadxVisioApplicationAppObjActivated read FOnAppObjActivated write FOnAppObjActivated;
    property OnAppObjDeactivated: TadxVisioApplicationAppObjDeactivated read FOnAppObjDeactivated write FOnAppObjDeactivated;
    property OnBeforeQuit: TadxVisioApplicationBeforeQuit read FOnBeforeQuit write FOnBeforeQuit;
    property OnBeforeModal: TadxVisioApplicationBeforeModal read FOnBeforeModal write FOnBeforeModal;
    property OnAfterModal: TadxVisioApplicationAfterModal read FOnAfterModal write FOnAfterModal;
    property OnWindowOpened: TadxVisioApplicationWindowOpened read FOnWindowOpened write FOnWindowOpened;
    property OnSelectionChanged: TadxVisioApplicationSelectionChanged read FOnSelectionChanged write FOnSelectionChanged;
    property OnBeforeWindowClosed: TadxVisioApplicationBeforeWindowClosed read FOnBeforeWindowClosed write FOnBeforeWindowClosed;
    property OnWindowActivated: TadxVisioApplicationWindowActivated read FOnWindowActivated write FOnWindowActivated;
    property OnBeforeWindowSelDelete: TadxVisioApplicationBeforeWindowSelDelete read FOnBeforeWindowSelDelete write FOnBeforeWindowSelDelete;
    property OnBeforeWindowPageTurn: TadxVisioApplicationBeforeWindowPageTurn read FOnBeforeWindowPageTurn write FOnBeforeWindowPageTurn;
    property OnWindowTurnedToPage: TadxVisioApplicationWindowTurnedToPage read FOnWindowTurnedToPage write FOnWindowTurnedToPage;
    property OnDocumentOpened: TadxVisioApplicationDocumentOpened read FOnDocumentOpened write FOnDocumentOpened;
    property OnDocumentCreated: TadxVisioApplicationDocumentCreated read FOnDocumentCreated write FOnDocumentCreated;
    property OnDocumentSaved: TadxVisioApplicationDocumentSaved read FOnDocumentSaved write FOnDocumentSaved;
    property OnDocumentSavedAs: TadxVisioApplicationDocumentSavedAs read FOnDocumentSavedAs write FOnDocumentSavedAs;
    property OnDocumentChanged: TadxVisioApplicationDocumentChanged read FOnDocumentChanged write FOnDocumentChanged;
    property OnBeforeDocumentClose: TadxVisioApplicationBeforeDocumentClose read FOnBeforeDocumentClose write FOnBeforeDocumentClose;
    property OnStyleAdded: TadxVisioApplicationStyleAdded read FOnStyleAdded write FOnStyleAdded;
    property OnStyleChanged: TadxVisioApplicationStyleChanged read FOnStyleChanged write FOnStyleChanged;
    property OnBeforeStyleDelete: TadxVisioApplicationBeforeStyleDelete read FOnBeforeStyleDelete write FOnBeforeStyleDelete;
    property OnMasterAdded: TadxVisioApplicationMasterAdded read FOnMasterAdded write FOnMasterAdded;
    property OnMasterChanged: TadxVisioApplicationMasterChanged read FOnMasterChanged write FOnMasterChanged;
    property OnBeforeMasterDelete: TadxVisioApplicationBeforeMasterDelete read FOnBeforeMasterDelete write FOnBeforeMasterDelete;
    property OnPageAdded: TadxVisioApplicationPageAdded read FOnPageAdded write FOnPageAdded;
    property OnPageChanged: TadxVisioApplicationPageChanged read FOnPageChanged write FOnPageChanged;
    property OnBeforePageDelete: TadxVisioApplicationBeforePageDelete read FOnBeforePageDelete write FOnBeforePageDelete;
    property OnShapeAdded: TadxVisioApplicationShapeAdded read FOnShapeAdded write FOnShapeAdded;
    property OnBeforeSelectionDelete: TadxVisioApplicationBeforeSelectionDelete read FOnBeforeSelectionDelete write FOnBeforeSelectionDelete;
    property OnShapeChanged: TadxVisioApplicationShapeChanged read FOnShapeChanged write FOnShapeChanged;
    property OnSelectionAdded: TadxVisioApplicationSelectionAdded read FOnSelectionAdded write FOnSelectionAdded;
    property OnBeforeShapeDelete: TadxVisioApplicationBeforeShapeDelete read FOnBeforeShapeDelete write FOnBeforeShapeDelete;
    property OnTextChanged: TadxVisioApplicationTextChanged read FOnTextChanged write FOnTextChanged;
    property OnCellChanged: TadxVisioApplicationCellChanged read FOnCellChanged write FOnCellChanged;
    property OnMarkerEvent: TadxVisioApplicationMarkerEvent read FOnMarkerEvent write FOnMarkerEvent;
    property OnNoEventsPending: TadxVisioApplicationNoEventsPending read FOnNoEventsPending write FOnNoEventsPending;
    property OnVisioIsIdle: TadxVisioApplicationVisioIsIdle read FOnVisioIsIdle write FOnVisioIsIdle;
    property OnMustFlushScopeBeginning: TadxVisioApplicationMustFlushScopeBeginning read FOnMustFlushScopeBeginning write FOnMustFlushScopeBeginning;
    property OnMustFlushScopeEnded: TadxVisioApplicationMustFlushScopeEnded read FOnMustFlushScopeEnded write FOnMustFlushScopeEnded;
    property OnRunModeEntered: TadxVisioApplicationRunModeEntered read FOnRunModeEntered write FOnRunModeEntered;
    property OnDesignModeEntered: TadxVisioApplicationDesignModeEntered read FOnDesignModeEntered write FOnDesignModeEntered;
    property OnBeforeDocumentSave: TadxVisioApplicationBeforeDocumentSave read FOnBeforeDocumentSave write FOnBeforeDocumentSave;
    property OnBeforeDocumentSaveAs: TadxVisioApplicationBeforeDocumentSaveAs read FOnBeforeDocumentSaveAs write FOnBeforeDocumentSaveAs;
    property OnFormulaChanged: TadxVisioApplicationFormulaChanged read FOnFormulaChanged write FOnFormulaChanged;
    property OnConnectionsAdded: TadxVisioApplicationConnectionsAdded read FOnConnectionsAdded write FOnConnectionsAdded;
    property OnConnectionsDeleted: TadxVisioApplicationConnectionsDeleted read FOnConnectionsDeleted write FOnConnectionsDeleted;
    property OnEnterScope: TadxVisioApplicationEnterScope read FOnEnterScope write FOnEnterScope;
    property OnExitScope: TadxVisioApplicationExitScope read FOnExitScope write FOnExitScope;
    property OnQueryCancelQuit: TadxVisioApplicationQueryCancelQuit read FOnQueryCancelQuit write FOnQueryCancelQuit;
    property OnQuitCanceled: TadxVisioApplicationQuitCanceled read FOnQuitCanceled write FOnQuitCanceled;
    property OnWindowChanged: TadxVisioApplicationWindowChanged read FOnWindowChanged write FOnWindowChanged;
    property OnViewChanged: TadxVisioApplicationViewChanged read FOnViewChanged write FOnViewChanged;
    property OnQueryCancelWindowClose: TadxVisioApplicationQueryCancelWindowClose read FOnQueryCancelWindowClose write FOnQueryCancelWindowClose;
    property OnWindowCloseCanceled: TadxVisioApplicationWindowCloseCanceled read FOnWindowCloseCanceled write FOnWindowCloseCanceled;
    property OnQueryCancelDocumentClose: TadxVisioApplicationQueryCancelDocumentClose read FOnQueryCancelDocumentClose write FOnQueryCancelDocumentClose;
    property OnDocumentCloseCanceled: TadxVisioApplicationDocumentCloseCanceled read FOnDocumentCloseCanceled write FOnDocumentCloseCanceled;
    property OnQueryCancelStyleDelete: TadxVisioApplicationQueryCancelStyleDelete read FOnQueryCancelStyleDelete write FOnQueryCancelStyleDelete;
    property OnStyleDeleteCanceled: TadxVisioApplicationStyleDeleteCanceled read FOnStyleDeleteCanceled write FOnStyleDeleteCanceled;
    property OnQueryCancelMasterDelete: TadxVisioApplicationQueryCancelMasterDelete read FOnQueryCancelMasterDelete write FOnQueryCancelMasterDelete;
    property OnMasterDeleteCanceled: TadxVisioApplicationMasterDeleteCanceled read FOnMasterDeleteCanceled write FOnMasterDeleteCanceled;
    property OnQueryCancelPageDelete: TadxVisioApplicationQueryCancelPageDelete read FOnQueryCancelPageDelete write FOnQueryCancelPageDelete;
    property OnPageDeleteCanceled: TadxVisioApplicationPageDeleteCanceled read FOnPageDeleteCanceled write FOnPageDeleteCanceled;
    property OnShapeParentChanged: TadxVisioApplicationShapeParentChanged read FOnShapeParentChanged write FOnShapeParentChanged;
    property OnBeforeShapeTextEdit: TadxVisioApplicationBeforeShapeTextEdit read FOnBeforeShapeTextEdit write FOnBeforeShapeTextEdit;
    property OnShapeExitedTextEdit: TadxVisioApplicationShapeExitedTextEdit read FOnShapeExitedTextEdit write FOnShapeExitedTextEdit;
    property OnQueryCancelSelectionDelete: TadxVisioApplicationQueryCancelSelectionDelete read FOnQueryCancelSelectionDelete write FOnQueryCancelSelectionDelete;
    property OnSelectionDeleteCanceled: TadxVisioApplicationSelectionDeleteCanceled read FOnSelectionDeleteCanceled write FOnSelectionDeleteCanceled;
    property OnQueryCancelUngroup: TadxVisioApplicationQueryCancelUngroup read FOnQueryCancelUngroup write FOnQueryCancelUngroup;
    property OnUngroupCanceled: TadxVisioApplicationUngroupCanceled read FOnUngroupCanceled write FOnUngroupCanceled;
    property OnQueryCancelConvertToGroup: TadxVisioApplicationQueryCancelConvertToGroup read FOnQueryCancelConvertToGroup write FOnQueryCancelConvertToGroup;
    property OnConvertToGroupCanceled: TadxVisioApplicationConvertToGroupCanceled read FOnConvertToGroupCanceled write FOnConvertToGroupCanceled;
    property OnQueryCancelSuspend: TadxVisioApplicationQueryCancelSuspend read FOnQueryCancelSuspend write FOnQueryCancelSuspend;
    property OnSuspendCanceled: TadxVisioApplicationSuspendCanceled read FOnSuspendCanceled write FOnSuspendCanceled;
    property OnBeforeSuspend: TadxVisioApplicationBeforeSuspend read FOnBeforeSuspend write FOnBeforeSuspend;
    property OnAfterResume: TadxVisioApplicationAfterResume read FOnAfterResume write FOnAfterResume;
    property OnKeystrokeMessageForAddon: TadxVisioApplicationOnKeystrokeMessageForAddon read FOnKeystrokeMessageForAddon write FOnKeystrokeMessageForAddon;
    property OnMouseDown: TadxVisioApplicationMouseDown read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TadxVisioApplicationMouseMove read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TadxVisioApplicationMouseUp read FOnMouseUp write FOnMouseUp;
    property OnKeyDown: TadxVisioApplicationKeyDown read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TadxVisioApplicationKeyPress read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TadxVisioApplicationKeyUp read FOnKeyUp write FOnKeyUp;
    // 2 0 1 0
    property OnQueryCancelSuspendEvents: TadxVisioApplicationQueryCancelSuspendEvents read FOnQueryCancelSuspendEvents write FOnQueryCancelSuspendEvents;
    property OnSuspendEventsCanceled: TadxVisioApplicationSuspendEventsCanceled read FOnSuspendEventsCanceled write FOnSuspendEventsCanceled;
    property OnBeforeSuspendEvents: TadxVisioApplicationBeforeSuspendEvents read FOnBeforeSuspendEvents write FOnBeforeSuspendEvents;
    property OnAfterResumeEvents: TadxVisioApplicationAfterResumeEvents read FOnAfterResumeEvents write FOnAfterResumeEvents;
    property OnQueryCancelGroup: TadxVisioApplicationQueryCancelGroup read FOnQueryCancelGroup write FOnQueryCancelGroup;
    property OnGroupCanceled: TadxVisioApplicationGroupCanceled read FOnGroupCanceled write FOnGroupCanceled;
    property OnShapeDataGraphicChanged: TadxVisioApplicationShapeDataGraphicChanged read FOnShapeDataGraphicChanged write FOnShapeDataGraphicChanged;
    property OnBeforeDataRecordsetDelete: TadxVisioApplicationBeforeDataRecordsetDelete read FOnBeforeDataRecordsetDelete write FOnBeforeDataRecordsetDelete;
    property OnDataRecordsetChanged: TadxVisioApplicationDataRecordsetChanged read FOnDataRecordsetChanged write FOnDataRecordsetChanged;
    property OnDataRecordsetAdded: TadxVisioApplicationDataRecordsetAdded read FOnDataRecordsetAdded write FOnDataRecordsetAdded;
    property OnShapeLinkAdded: TadxVisioApplicationShapeLinkAdded read FOnShapeLinkAdded write FOnShapeLinkAdded;
    property OnShapeLinkDeleted: TadxVisioApplicationShapeLinkDeleted read FOnShapeLinkDeleted write FOnShapeLinkDeleted;
    property OnAfterRemoveHiddenInformation: TadxVisioApplicationAfterRemoveHiddenInformation read FOnAfterRemoveHiddenInformation write FOnAfterRemoveHiddenInformation;
    property OnContainerRelationshipAdded: TadxVisioApplicationContainerRelationshipAdded read FOnContainerRelationshipAdded write FOnContainerRelationshipAdded;
    property OnContainerRelationshipDeleted: TadxVisioApplicationContainerRelationshipDeleted read FOnContainerRelationshipDeleted write FOnContainerRelationshipDeleted;
    property OnCalloutRelationshipAdded: TadxVisioApplicationCalloutRelationshipAdded read FOnCalloutRelationshipAdded write FOnCalloutRelationshipAdded;
    property OnCalloutRelationshipDeleted: TadxVisioApplicationCalloutRelationshipDeleted read FOnCalloutRelationshipDeleted write FOnCalloutRelationshipDeleted;
    property OnRuleSetValidated: TadxVisioApplicationRuleSetValidated read FOnRuleSetValidated write FOnRuleSetValidated;
  end;

  TadxMapPointApplicationBeforeSave = procedure(ASender: TObject; SaveAsUI: WordBool; out Cancel: WordBool) of object;
  TadxMapPointApplicationBeforeClose = procedure(ASender: TObject; out Cancel: WordBool) of object;

  TadxMapPointAppEvents = class(TadxCustomEvents)
  private
    FIntf: MapPoint2002._Application;
    FOnNew: TNotifyEvent;
    FOnOpen: TNotifyEvent;
    FOnQuit: TNotifyEvent;
    FOnBeforeSave: TadxMapPointApplicationBeforeSave;
    FOnBeforeClose: TadxMapPointApplicationBeforeClose;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnNew: TNotifyEvent read FOnNew write FOnNew;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnBeforeSave: TadxMapPointApplicationBeforeSave read FOnBeforeSave write FOnBeforeSave;
    property OnBeforeClose: TadxMapPointApplicationBeforeClose read FOnBeforeClose write FOnBeforeClose;
  end;

  TadxPublisherApplicationWindowActivate = procedure(Sender: TObject; const Wn: Publisher2003.Window) of object;
  TadxPublisherApplicationWindowDeactivate = procedure(Sender: TObject; const Wn: Publisher2003.Window) of object;
  TadxPublisherApplicationWindowPageChange = procedure(Sender: TObject; const Vw: Publisher2003.View) of object;
  TadxPublisherApplicationNewDocument = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationDocumentOpen = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationDocumentBeforeClose = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    var Cancel: WordBool) of object;
  TadxPublisherApplicationMailMergeAfterMerge = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationMailMergeAfterRecordMerge = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationMailMergeBeforeMerge = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    StartRecord: Integer; EndRecord: Integer; var Cancel: WordBool) of object;
  TadxPublisherApplicationMailMergeBeforeRecordMerge = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    var Cancel: WordBool) of object;
  TadxPublisherApplicationMailMergeDataSourceLoad = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationMailMergeWizardSendToCustom = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationMailMergeWizardStateChange = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    FromState: SYSINT) of object;
  TadxPublisherApplicationMailMergeDataSourceValidate = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    var Handled: WordBool) of object;
  TadxPublisherApplicationMailMergeInsertBarcode = procedure(Sender: TObject; const Doc: Publisher2003._Document;
    var OkToInsert: WordBool) of object;
  TadxPublisherApplicationMailMergeRecipientListClose = procedure(Sender: TObject;
    const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationMailMergeGenerateBarcode = procedure(Sender: TObject;
    const Doc: Publisher2003._Document; var bstrString: WideString) of object;
  TadxPublisherApplicationMailMergeWizardFollowUpCustom = procedure(Sender: TObject;
    const Doc: Publisher2003._Document) of object;
  TadxPublisherApplicationBeforePrint = procedure(Sender: TObject;
    const Doc: Publisher2003._Document; var Cancel: WordBool) of object;
  TadxPublisherApplicationAfterPrint = procedure(Sender: TObject; const Doc: Publisher2003._Document) of object;

  TadxPublisherAppEvents = class(TadxCustomEvents)
  private
    FIntf: Publisher2003._Application;
    FOnWindowActivate: TadxPublisherApplicationWindowActivate;
    FOnWindowDeactivate: TadxPublisherApplicationWindowDeactivate;
    FOnWindowPageChange: TadxPublisherApplicationWindowPageChange;
    FOnQuit: TNotifyEvent;
    FOnNewDocument: TadxPublisherApplicationNewDocument;
    FOnDocumentOpen: TadxPublisherApplicationDocumentOpen;
    FOnDocumentBeforeClose: TadxPublisherApplicationDocumentBeforeClose;
    FOnMailMergeAfterMerge: TadxPublisherApplicationMailMergeAfterMerge;
    FOnMailMergeAfterRecordMerge: TadxPublisherApplicationMailMergeAfterRecordMerge;
    FOnMailMergeBeforeMerge: TadxPublisherApplicationMailMergeBeforeMerge;
    FOnMailMergeBeforeRecordMerge: TadxPublisherApplicationMailMergeBeforeRecordMerge;
    FOnMailMergeDataSourceLoad: TadxPublisherApplicationMailMergeDataSourceLoad;
    FOnMailMergeWizardSendToCustom: TadxPublisherApplicationMailMergeWizardSendToCustom;
    FOnMailMergeWizardStateChange: TadxPublisherApplicationMailMergeWizardStateChange;
    FOnMailMergeDataSourceValidate: TadxPublisherApplicationMailMergeDataSourceValidate;

    FOnMailMergeInsertBarcode: TadxPublisherApplicationMailMergeInsertBarcode;
    FOnMailMergeRecipientListClose: TadxPublisherApplicationMailMergeRecipientListClose;
    FOnMailMergeGenerateBarcode: TadxPublisherApplicationMailMergeGenerateBarcode;
    FOnMailMergeWizardFollowUpCustom: TadxPublisherApplicationMailMergeWizardFollowUpCustom;
    FOnBeforePrint: TadxPublisherApplicationBeforePrint;
    FOnAfterPrint: TadxPublisherApplicationAfterPrint;
    FOnShowCatalogUI: TNotifyEvent;
    FOnHideCatalogUI: TNotifyEvent;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnWindowActivate: TadxPublisherApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxPublisherApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowPageChange: TadxPublisherApplicationWindowPageChange read FOnWindowPageChange write FOnWindowPageChange;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnNewDocument: TadxPublisherApplicationNewDocument read FOnNewDocument write FOnNewDocument;
    property OnDocumentOpen: TadxPublisherApplicationDocumentOpen read FOnDocumentOpen write FOnDocumentOpen;
    property OnDocumentBeforeClose: TadxPublisherApplicationDocumentBeforeClose read FOnDocumentBeforeClose write FOnDocumentBeforeClose;
    property OnMailMergeAfterMerge: TadxPublisherApplicationMailMergeAfterMerge read FOnMailMergeAfterMerge write FOnMailMergeAfterMerge;
    property OnMailMergeAfterRecordMerge: TadxPublisherApplicationMailMergeAfterRecordMerge read FOnMailMergeAfterRecordMerge write FOnMailMergeAfterRecordMerge;
    property OnMailMergeBeforeMerge: TadxPublisherApplicationMailMergeBeforeMerge read FOnMailMergeBeforeMerge write FOnMailMergeBeforeMerge;
    property OnMailMergeBeforeRecordMerge: TadxPublisherApplicationMailMergeBeforeRecordMerge read FOnMailMergeBeforeRecordMerge write FOnMailMergeBeforeRecordMerge;
    property OnMailMergeDataSourceLoad: TadxPublisherApplicationMailMergeDataSourceLoad read FOnMailMergeDataSourceLoad write FOnMailMergeDataSourceLoad;
    property OnMailMergeWizardSendToCustom: TadxPublisherApplicationMailMergeWizardSendToCustom read FOnMailMergeWizardSendToCustom write FOnMailMergeWizardSendToCustom;
    property OnMailMergeWizardStateChange: TadxPublisherApplicationMailMergeWizardStateChange read FOnMailMergeWizardStateChange write FOnMailMergeWizardStateChange;
    property OnMailMergeDataSourceValidate: TadxPublisherApplicationMailMergeDataSourceValidate read FOnMailMergeDataSourceValidate write FOnMailMergeDataSourceValidate;
    // 2 0 0 7
    property OnMailMergeInsertBarcode: TadxPublisherApplicationMailMergeInsertBarcode read FOnMailMergeInsertBarcode write FOnMailMergeInsertBarcode;
    property OnMailMergeRecipientListClose: TadxPublisherApplicationMailMergeRecipientListClose read FOnMailMergeRecipientListClose write FOnMailMergeRecipientListClose;
    property OnMailMergeGenerateBarcode: TadxPublisherApplicationMailMergeGenerateBarcode read FOnMailMergeGenerateBarcode write FOnMailMergeGenerateBarcode;
    property OnMailMergeWizardFollowUpCustom: TadxPublisherApplicationMailMergeWizardFollowUpCustom read FOnMailMergeWizardFollowUpCustom write FOnMailMergeWizardFollowUpCustom;
    property OnBeforePrint: TadxPublisherApplicationBeforePrint read FOnBeforePrint write FOnBeforePrint;
    property OnAfterPrint: TadxPublisherApplicationAfterPrint read FOnAfterPrint write FOnAfterPrint;
    property OnShowCatalogUI: TNotifyEvent read FOnShowCatalogUI write FOnShowCatalogUI;
    property OnHideCatalogUI: TNotifyEvent read FOnHideCatalogUI write FOnHideCatalogUI;
  end;

  TadxInfoPathApplicationWindowActivate = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TadxInfoPathApplicationWindowDeactivate = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TadxInfoPathApplicationWindowSize = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TadxInfoPathApplicationXDocumentBeforeClose = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TadxInfoPathApplicationXDocumentBeforePrint = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TadxInfoPathApplicationXDocumentBeforeSave = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TadxInfoPathApplicationNewXDocument = procedure(Sender: TObject; const pDocument: _XDocument) of object;
  TadxInfoPathApplicationXDocumentOpen = procedure(Sender: TObject; const pDocument: _XDocument) of object;

  TadxInfoPathAppEvents = class(TadxCustomEvents)
  private
    FIntf: InfoPath2007._Application3;
    FOnWindowActivate: TadxInfoPathApplicationWindowActivate;
    FOnWindowDeactivate: TadxInfoPathApplicationWindowDeactivate;
    FOnWindowSize: TadxInfoPathApplicationWindowSize;
    FOnXDocumentBeforeClose: TadxInfoPathApplicationXDocumentBeforeClose;
    FOnXDocumentBeforePrint: TadxInfoPathApplicationXDocumentBeforePrint;
    FOnXDocumentBeforeSave: TadxInfoPathApplicationXDocumentBeforeSave;
    FOnNewXDocument: TadxInfoPathApplicationNewXDocument;
    FOnXDocumentOpen: TadxInfoPathApplicationXDocumentOpen;
    FOnQuit: TNotifyEvent;
    FOnXDocumentChange: TNotifyEvent;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  published
    property OnWindowActivate: TadxInfoPathApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TadxInfoPathApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowSize: TadxInfoPathApplicationWindowSize read FOnWindowSize write FOnWindowSize;
    property OnXDocumentBeforeClose: TadxInfoPathApplicationXDocumentBeforeClose read FOnXDocumentBeforeClose write FOnXDocumentBeforeClose;
    property OnXDocumentBeforePrint: TadxInfoPathApplicationXDocumentBeforePrint read FOnXDocumentBeforePrint write FOnXDocumentBeforePrint;
    property OnXDocumentBeforeSave: TadxInfoPathApplicationXDocumentBeforeSave read FOnXDocumentBeforeSave write FOnXDocumentBeforeSave;
    property OnNewXDocument: TadxInfoPathApplicationNewXDocument read FOnNewXDocument write FOnNewXDocument;
    property OnXDocumentOpen: TadxInfoPathApplicationXDocumentOpen read FOnXDocumentOpen write FOnXDocumentOpen;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnXDocumentChange: TNotifyEvent read FOnXDocumentChange write FOnXDocumentChange;
  end;

implementation

uses adxAddIn;

{ TadxEventDispatch }

constructor TadxEventDispatch.Create(Server: TadxCustomEvents);
begin
  inherited Create;
  FServer := Server;
  InternalRefCount := 1;
end;

function TadxEventDispatch.ServerDisconnect: boolean;
begin
  FServer := nil;
  if FServer <> nil then Result := False
  else Result := True;
end;

{ IUnknown }

function TadxEventDispatch.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then begin
    Result := S_OK;
    Exit;
  end;
  if IsEqualIID(IID, FServer.FServerData^.EventIID) then begin
    GetInterface(IDispatch, Obj);
    Result := S_OK;
    Exit;
  end;
  Result := E_NOINTERFACE;
end;

function TadxEventDispatch._AddRef: Integer;
begin
  if FServer <> nil then FServer._AddRef;
  InternalRefCount := InternalRefCount + 1;
  Result := InternalRefCount;
end;

function TadxEventDispatch._Release: Integer;
begin
  if FServer <> nil then FServer._Release;
  InternalRefCount := InternalRefCount -1;
  Result := InternalRefCount;
end;

{ IDispatch }

function TadxEventDispatch.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result:= S_OK;
end;

function TadxEventDispatch.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TadxEventDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

type
  TadxCOMAddInModuleAccess = class(TadxCOMAddInModule);

function TadxEventDispatch.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  i: integer;
  vVarArray : TVariantArray;
  vPVarArgIn: PVariantArg;
  vPDispParams: PDispParams;
  vFistArrItem, vLastArrItem: integer;
begin
  vPDispParams := PDispParams(@Params);
  SetLength(vVarArray, vPDispParams.cArgs);
  vFistArrItem := Low(vVarArray); vLastArrItem := High(vVarArray);
  if vPDispParams.cNamedArgs > 0 then
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      vVarArray[vPDispParams.rgdispidNamedArgs[i]] := POleVariant(vPVarArgIn)^;
    end
  else
    for i := vFistArrItem to vLastArrItem do begin
      vPVarArgIn := @vPDispParams.rgvarg[i];
      vVarArray[vLastArrItem - i] := POleVariant(vPVarArgIn)^;
    end;
  if FServer <> nil then
    try
      FServer.InvokeEvent(DispID, vVarArray);
    except
      on E: SysUtils.Exception do
        TadxCOMAddInModuleAccess(Self.FServer.Owner).DoError(E);
    end;
  if vPDispParams.cNamedArgs > 0 then
    for i := vFistArrItem to vLastArrItem do begin
      {$IFDEF ADX_VCL5}
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if ((vPVarArgIn^.vt and varByRef) = varByRef) and ((vPVarArgIn^.vt and varBoolean) = varBoolean) then
      begin
        vPDispParams.rgvarg[i].pbool^ := vVarArray[vPDispParams.rgdispidNamedArgs[i]];
      end;
      {$ELSE}
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
      POleVariant(vPVarArgIn)^ := vVarArray[vPDispParams.rgdispidNamedArgs[i]];
      {$ENDIF}
    end
  else
    for i := vFistArrItem to vLastArrItem do begin
      {$IFDEF ADX_VCL5}
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if ((vPVarArgIn^.vt and varByRef) = varByRef) and ((vPVarArgIn^.vt and varBoolean) = varBoolean) then
      begin
        vPDispParams.rgvarg[i].pbool^ := vVarArray[vLastArrItem - i];
      end;
      {$ELSE}
      vPVarArgIn := @vPDispParams.rgvarg[i];
      if (vPVarArgIn.vt and varByRef) <> varByRef then Continue;
      POleVariant(vPVarArgIn)^ := vVarArray[vLastArrItem - i];
      {$ENDIF}
    end;
  SetLength(vVarArray, 0);
  Result := S_OK;
end;

{ TadxCustomEvents }

constructor TadxCustomEvents.Create(AOwner: TComponent);
const
  adxECode = 31100;
  adxECodeCantContain = adxECode + 13;
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
begin
  inherited Create(AOwner);
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxOutlookAppEvents) then
    if not (AOwner is TadxCOMAddInModule) then
      raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
  InitServerData;
  Inc(FServerData^.InstanceCount);
  FEventDispatch := TadxEventDispatch.Create(Self);
end;

destructor TadxCustomEvents.Destroy;
begin
  Disconnect;
  if Assigned(FEventDispatch) then begin
    FEventDispatch.ServerDisconnect;
    if (FEventDispatch._Release = 0) then FEventDispatch.Free;
    Dec(FServerData^.InstanceCount);
  end;
  inherited Destroy;
end;

{ IUnknown }

function TadxCustomEvents.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

function TadxCustomEvents._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TadxCustomEvents._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

procedure TadxCustomEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
end;

procedure TadxCustomEvents.ConnectEvents(const Obj: IUnknown);
begin
  ComObj.InterfaceConnect(Obj, FServerData^.EventIID, FEventDispatch, FEventsConnection);
end;

procedure TadxCustomEvents.DisconnectEvents(const Obj: Iunknown);
begin
  ComObj.InterfaceDisconnect(Obj, FServerData^.EventIID, FEventsConnection);
end;

type
  TadxOutlookNameSpaceEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._NameSpace;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  end;

{ TadxOutlookNameSpaceEvents }

constructor TadxOutlookNameSpaceEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookNameSpaceEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookNameSpaceEvents.InitServerData;
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

procedure TadxOutlookNameSpaceEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._NameSpace;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookNameSpaceEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxOutlookNameSpaceEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookNameSpaceEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61445: if Assigned(FOwner.FOnNameSpaceOptionsPagesAdd) then
             FOwner.FOnNameSpaceOptionsPagesAdd(FOwner, IUnknown(TVarData(Params[0]).VPointer) as PropertyPages,
               IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder);
    // 2 0 0 7
    64557: if Assigned(FOwner.FOnNameSpaceAutoDiscoverComplete) then
             FOwner.FOnNameSpaceAutoDiscoverComplete(FOwner);
  end;
end;

type
  TadxOutlookRemindersEvents = class(TadxCustomEvents)
  private
    FIntf: IDispatch;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TadxOutlookRemindersEvents }

constructor TadxOutlookRemindersEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookRemindersEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookRemindersEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0006F029-0000-0000-C000-000000000046}';
    IntfIID:   '{000630B1-0000-0000-C000-000000000046}';
    EventIID:  '{000630B2-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxOutlookRemindersEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookRemindersEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxOutlookRemindersEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookRemindersEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    64147: if Assigned(FOwner.FOnBeforeReminderShow) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnBeforeReminderShow(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnBeforeReminderShow(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64148: if Assigned(FOwner.FOnReminderAdd) then FOwner.FOnReminderAdd(FOwner, Params[0]);
    64149: if Assigned(FOwner.FOnReminderChange) then FOwner.FOnReminderChange(FOwner, Params[0]);
    64150: if Assigned(FOwner.FOnReminderFire) then FOwner.FOnReminderFire(FOwner, Params[0]);
    64151: if Assigned(FOwner.FOnReminderRemove) then FOwner.FOnReminderRemove(FOwner);
    64152: if Assigned(FOwner.FOnSnooze) then FOwner.FOnSnooze(FOwner, Params[0]);
  end;
end;

type
  TadxOutlookExplorerEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Explorer;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TadxOutlookExplorerEvents }

constructor TadxOutlookExplorerEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookExplorerEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookExplorerEvents.InitServerData;
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

procedure TadxOutlookExplorerEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Explorer;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookExplorerEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
const
  EventIID2000: TGUID = '{0006304F-0000-0000-C000-000000000046}';
  EventIID2002: TGUID = '{0006300F-0000-0000-C000-000000000046}';
  EventIID2003: TGUID = '{0006300F-0000-0000-C000-000000000046}';
begin
  if AVersion = '9' then
    ServerData^.EventIID := EventIID2000
  else
    if AVersion = '10' then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

procedure TadxOutlookExplorerEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookExplorerEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  i: Integer;
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOwner.FOnExplorerActivate) then FOwner.FOnExplorerActivate(FOwner);
    61442: if Assigned(FOwner.FOnExplorerFolderSwitch) then FOwner.FOnExplorerFolderSwitch(FOwner);
    61443: if Assigned(FOwner.FOnExplorerBeforeFolderSwitch) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeFolderSwitch(FOwner, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeFolderSwitch(FOwner, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    61444: if Assigned(FOwner.FOnExplorerViewSwitch) then FOwner.FOnExplorerViewSwitch(FOwner);
    61445: if Assigned(FOwner.FOnExplorerBeforeViewSwitch) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeViewSwitch(FOwner, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeViewSwitch(FOwner, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    61446: if Assigned(FOwner.FOnExplorerDeactivate) then FOwner.FOnExplorerDeactivate(FOwner);
    61447: if Assigned(FOwner.FOnExplorerSelectionChange) then FOwner.FOnExplorerSelectionChange(FOwner);
    61448: try
             if Assigned(FOwner.FOnExplorerClose) then FOwner.FOnExplorerClose(FOwner);
           finally
             FOwner.FExplorerEvents.Remove(Self);
             if FOwner.FExplorerEvents.Count = 0 then
               for i := FOwner.FInspectorEvents.Count - 1 downto 0 do begin
                 TadxCustomEvents(FOwner.FInspectorEvents[i]).Free;
                 FOwner.FInspectorEvents.Delete(i);
               end;
             Self.Free;
           end;
    64017: if Assigned(FOwner.FOnExplorerBeforeMaximize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeMaximize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeMaximize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64018: if Assigned(FOwner.FOnExplorerBeforeMinimize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeMinimize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeMinimize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64019: if Assigned(FOwner.FOnExplorerBeforeMove) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeMove(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeMove(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64020: if Assigned(FOwner.FOnExplorerBeforeSize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeSize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeSize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64014: if Assigned(FOwner.FOnExplorerBeforeItemCopy) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeItemCopy(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeItemCopy(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64015: if Assigned(FOwner.FOnExplorerBeforeItemCut) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeItemCut(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeItemCut(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64016: if Assigned(FOwner.FOnExplorerBeforeItemPaste) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnExplorerBeforeItemPaste(FOwner, OleVariant((TVarData(Params[0]).VPointer)^),
               IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder, WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
             FOwner.FOnExplorerBeforeItemPaste(FOwner, OleVariant((TVarData(Params[0]).VPointer)^),
               IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder, WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    64633: if Assigned(FOwner.FOnExplorerAttachmentSelectionChange) then
             FOwner.FOnExplorerAttachmentSelectionChange(FOwner);
  end;
end;

type
  TadxOutlookInspectorEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Inspector;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TadxOutlookInspectorEvents }

constructor TadxOutlookInspectorEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookInspectorEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookInspectorEvents.InitServerData;
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

procedure TadxOutlookInspectorEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Inspector;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookInspectorEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
const
  EventIID2000: TGUID = '{0006307D-0000-0000-C000-000000000046}';
  EventIID2002: TGUID = '{0006302A-0000-0000-C000-000000000046}';
  EventIID2003: TGUID = '{0006302A-0000-0000-C000-000000000046}';
begin
  if AVersion = '9' then
    ServerData^.EventIID := EventIID2000
  else
    if AVersion = '10' then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

procedure TadxOutlookInspectorEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookInspectorEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  Str: WideString;
begin
  case DispID of
    -1: Exit;
    61441: if Assigned(FOwner.FOnInspectorActivate) then FOwner.FOnInspectorActivate(FOwner);
    61446: if Assigned(FOwner.FOnInspectorDeactivate) then FOwner.FOnInspectorDeactivate(FOwner);
    61448: begin
             try
               if Assigned(FOwner.FOnInspectorClose) then FOwner.FOnInspectorClose(FOwner);
             finally
               FOwner.FInspectorEvents.Remove(Self);
               Self.Free;
             end;
           end;
    64017: if Assigned(FOwner.FOnInspectorBeforeMaximize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnInspectorBeforeMaximize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnInspectorBeforeMaximize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64018: if Assigned(FOwner.FOnInspectorBeforeMinimize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnInspectorBeforeMinimize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnInspectorBeforeMinimize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64019: if Assigned(FOwner.FOnInspectorBeforeMove) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnInspectorBeforeMove(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnInspectorBeforeMove(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    64020: if Assigned(FOwner.FOnInspectorBeforeSize) then
    {$IFDEF ADX_VCL5}
             FOwner.FOnInspectorBeforeSize(FOwner, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
             FOwner.FOnInspectorBeforeSize(FOwner, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    // 2 0 0 7
    64500: if Assigned(FOwner.FOnInspectorPageChange) then begin
             Str := TVarData(Params[0]).VOleStr;
             FOwner.FOnInspectorPageChange(FOwner, Str);
             TVarData(Params[0]).VOleStr := PWideChar(Str);
           end;
    // 2 0 1 0
    64633: if Assigned(FOwner.FOnInspectorAttachmentSelectionChange) then
             FOwner.FOnInspectorAttachmentSelectionChange(FOwner);
  end;
end;

type
  TadxOutlookExplorersEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Explorers;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TadxOutlookExplorersEvents }

constructor TadxOutlookExplorersEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookExplorersEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookExplorersEvents.InitServerData;
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

procedure TadxOutlookExplorersEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Explorers;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookExplorersEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxOutlookExplorersEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookExplorersEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  Expl: TadxOutlookExplorerEvents;
begin
  case DispID of
    -1: Exit;
    61441: try
             if Assigned(FOwner.FOnNewExplorer) then
               FOwner.FOnNewExplorer(FOwner, IUnknown(TVarData(Params[0]).VPointer) as _Explorer);
           finally
             Expl := TadxOutlookExplorerEvents.Create(FOwner);
             Expl.ConnectTo(Params[0], FOwner.FVersion);
             FOwner.FExplorerEvents.Add(Expl);
           end;
  end;
end;

type
  TadxOutlookInspectorsEvents = class(TadxCustomEvents)
  private
    FIntf: Outlook2000._Inspectors;
    FOwner: TadxOutlookAppEvents;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    procedure ConnectTo(AIntf: IDispatch); override;
    procedure ConnectTo(AIntf: IDispatch; AVersion: string); override;
    procedure Disconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TadxOutlookInspectorsEvents }

constructor TadxOutlookInspectorsEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := TadxOutlookAppEvents(AOwner);
end;

destructor TadxOutlookInspectorsEvents.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

procedure TadxOutlookInspectorsEvents.InitServerData;
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

procedure TadxOutlookInspectorsEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Inspectors;
  ConnectEvents(FIntf);
end;

procedure TadxOutlookInspectorsEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxOutlookInspectorsEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxOutlookInspectorsEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  Insp: TadxOutlookInspectorEvents;
begin
  case DispID of
    -1: Exit;
    61441: try
             if Assigned(FOwner.FOnNewInspector) then
               FOwner.FOnNewInspector(FOwner, IUnknown(TVarData(Params[0]).VPointer) as _Inspector);
           finally
             if OleVariant((IUnknown(TVarData(Params[0]).VPointer) as _Inspector).CurrentItem).Class <> olNote then begin
               Insp := TadxOutlookInspectorEvents.Create(FOwner);
               Insp.ConnectTo(Params[0], FOwner.FVersion);
               FOwner.FInspectorEvents.Add(Insp);
             end;
           end;
  end;
end;

{ TadxOutlookAppEvents }

constructor TadxOutlookAppEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVersion := '9';
  FNameSpaceEvents := TadxOutlookNameSpaceEvents.Create(Self);
  FExplorersEvents := TadxOutlookExplorersEvents.Create(Self);
  FInspectorsEvents := TadxOutlookInspectorsEvents.Create(Self);
  FRemindersEvents := TadxOutlookRemindersEvents.Create(Self);
  FExplorerEvents := TList.Create;
  FInspectorEvents := TList.Create;
end;

destructor TadxOutlookAppEvents.Destroy;
var
  i: Integer;
begin
  if Assigned(FNameSpaceEvents) then
    TadxOutlookNameSpaceEvents(FNameSpaceEvents).Free;
  if Assigned(FExplorersEvents) then
    TadxOutlookExplorersEvents(FExplorersEvents).Free;
  if Assigned(FInspectorsEvents) then
    TadxOutlookInspectorsEvents(FInspectorsEvents).Free;
  if Assigned(FRemindersEvents) then
    TadxOutlookRemindersEvents(FRemindersEvents).Free;
  if Assigned(FExplorerEvents) then begin
    for i := 0 to FExplorerEvents.Count - 1 do
      TadxOutlookExplorerEvents(FExplorerEvents[i]).Free;
    FExplorerEvents.Free;
  end;
  if Assigned(FInspectorEvents) then begin
    for i := 0 to FInspectorEvents.Count - 1 do
      TadxOutlookInspectorEvents(FInspectorEvents[i]).Free;
    FInspectorEvents.Free;
  end;
  inherited Destroy;
end;

procedure TadxOutlookAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0006F03A-0000-0000-C000-000000000046}';
    IntfIID:   '{00063001-0000-0000-C000-000000000046}';
    EventIID:  '{0006304E-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxOutlookAppEvents.ConnectTo(AIntf: IDispatch);
var
  i: Integer;
  Expl: TadxOutlookExplorerEvents;
  Insp: TadxOutlookInspectorEvents;
begin
  Disconnect;
  FIntf := AIntf as Outlook2000._Application;
  ConnectEvents(FIntf);
  if Assigned(FIntf) then begin
    TadxOutlookNameSpaceEvents(FNameSpaceEvents).ConnectTo(FIntf.GetNamespace('MAPI'));
    TadxOutlookExplorersEvents(FExplorersEvents).ConnectTo(FIntf.Explorers);
    TadxOutlookInspectorsEvents(FInspectorsEvents).ConnectTo(FIntf.Inspectors);
    if FVersion <> '9' then
      try
        TadxOutlookRemindersEvents(FRemindersEvents).ConnectTo(OleVariant(FIntf).Reminders);
      except
      end;
    for i := 1 to FIntf.Explorers.Count do begin
      Expl := TadxOutlookExplorerEvents.Create(Self);
      Expl.ConnectTo(FIntf.Explorers.Item(i), FVersion);
      FExplorerEvents.Add(Expl);
    end;
    for i := 1 to FIntf.Inspectors.Count do begin
      if OleVariant(FIntf.Inspectors.Item(i).CurrentItem).Class = olNote then Continue;
      Insp := TadxOutlookInspectorEvents.Create(Self);
      Insp.ConnectTo(FIntf.Inspectors.Item(i), FVersion);
      FInspectorEvents.Add(Insp);
    end;
  end;
end;

procedure TadxOutlookAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
const
  EventIID2000: TGUID = '{0006304E-0000-0000-C000-000000000046}';
  EventIID2002: TGUID = '{0006300E-0000-0000-C000-000000000046}';
  EventIID2003: TGUID = '{0006302C-0000-0000-C000-000000000046}';
begin
  FVersion := AVersion;
  if FVersion = '9' then
    ServerData^.EventIID := EventIID2000
  else
    if FVersion = '10' then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

procedure TadxOutlookAppEvents.Disconnect;
var
  i: Integer;
begin
  if Assigned(FIntf) then begin
    TadxOutlookNameSpaceEvents(FNameSpaceEvents).Disconnect;
    TadxOutlookExplorersEvents(FExplorersEvents).Disconnect;
    TadxOutlookInspectorsEvents(FInspectorsEvents).Disconnect;
    TadxOutlookRemindersEvents(FRemindersEvents).Disconnect;
    for i := FExplorerEvents.Count - 1 downto 0 do begin
      TadxOutlookExplorerEvents(FExplorerEvents[i]).Disconnect;
      FExplorerEvents.Delete(i);
    end;
    for i := FInspectorEvents.Count - 1 downto 0 do begin
      TadxOutlookInspectorEvents(FInspectorEvents[i]).Disconnect;
      FInspectorEvents.Delete(i);
    end;
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

var
  isQuitRaised: boolean = False;

procedure TadxOutlookAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    61442: if Assigned(FOnItemSend) then
    {$IFDEF ADX_VCL5}
             FOnItemSend(Self, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
             FOnItemSend(Self, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    61443: if Assigned(FOnNewMail) then FOnNewMail(Self);
    61444: if Assigned(FOnReminder) then FOnReminder(Self, Params[0]);
    61445: if Assigned(FOnOptionsPagesAdd) then
             FOnOptionsPagesAdd(Self, IUnknown(TVarData(Params[0]).VPointer) as PropertyPages);
    61446: if Assigned(FOnStartup) then FOnStartup(Self);
    61447: if Assigned(FOnQuit) then begin
             if not isQuitRaised then FOnQuit(Self);
             isQuitRaised := True;
           end;
    // 2002
    64106: if Assigned(FOnAdvancedSearchComplete) then FOnAdvancedSearchComplete(Self, Params[0]);
    64107: if Assigned(FOnAdvancedSearchStopped) then FOnAdvancedSearchStopped(Self, Params[0]);
    64144: if Assigned(FOnMAPILogonComplete) then FOnMAPILogonComplete(Self);
    // 2003
    64181: if Assigned(FOnNewMailEx) then FOnNewMailEx(Self, Params[0]);
    // 2 0 0 7
    (* moved to the TadxAddin class
    64318: if Assigned(FOnAttachmentContextMenuDisplay) then
             FOnAttachmentContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
    64320: if Assigned(FOnViewContextMenuDisplay) then
             FOnViewContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
    64321: if Assigned(FOnItemContextMenuDisplay) then
             FOnItemContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
               IUnknown(TVarData(Params[1]).VPointer) as Outlook2000.Selection);
    64322: if Assigned(FOnFolderContextMenuDisplay) then
             FOnFolderContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
               IUnknown(TVarData(Params[1]).VPointer) as MAPIFolder);
    64323: if Assigned(FOnStoreContextMenuDisplay) then
             FOnStoreContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar, Params[1]);
    64324: if Assigned(FOnShortcutContextMenuDisplay) then
             FOnShortcutContextMenuDisplay(Self, IUnknown(TVarData(Params[0]).VPointer) as CommandBar,
               IUnknown(TVarData(Params[1]).VPointer) as OutlookBarShortcut);
    64422: if Assigned(FOnContextMenuClose) then
             FOnContextMenuClose(Self, Params[0]);
    *)
    64423: if Assigned(FOnItemLoad) then
             FOnItemLoad(Self, Params[0]);
    64513: if Assigned(FOnBeforeFolderSharingDialog) then
    {$IFDEF ADX_VCL5}
             FOnBeforeFolderSharingDialog(Self, IUnknown(TVarData(Params[0]).VPointer) as MAPIFolder,
               WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
             FOnBeforeFolderSharingDialog(Self, IUnknown(TVarData(Params[0]).VPointer) as MAPIFolder,
               WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
  end;
end;

procedure TadxOutlookAppEvents.DoAttachmentContextMenuDisplay(const CommandBar: CommandBar; const Attachments: IDispatch);
begin
  try
    if Assigned(FOnAttachmentContextMenuDisplay) then
      FOnAttachmentContextMenuDisplay(Self, CommandBar, Attachments);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoViewContextMenuDisplay(const CommandBar: CommandBar; const View: IDispatch);
begin
  try
    if Assigned(FOnViewContextMenuDisplay) then
      FOnViewContextMenuDisplay(Self, CommandBar, View);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoItemContextMenuDisplay(const CommandBar: CommandBar; const Selection: Outlook2000.Selection);
begin
  try
    if Assigned(FOnItemContextMenuDisplay) then
      FOnItemContextMenuDisplay(Self, CommandBar, Selection);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoFolderContextMenuDisplay(const CommandBar: CommandBar; const Folder: MAPIFolder);
begin
  try
    if Assigned(FOnFolderContextMenuDisplay) then
      FOnFolderContextMenuDisplay(Self, CommandBar, Folder);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoStoreContextMenuDisplay(const CommandBar: CommandBar; const Store: IDispatch);
begin
  try
    if Assigned(FOnStoreContextMenuDisplay) then
      FOnStoreContextMenuDisplay(Self, CommandBar, Store);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoShortcutContextMenuDisplay(const CommandBar: CommandBar; const Shortcut: OutlookBarShortcut);
begin
  try
    if Assigned(FOnShortcutContextMenuDisplay) then
      FOnShortcutContextMenuDisplay(Self, CommandBar, Shortcut);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxOutlookAppEvents.DoContextMenuClose(ContextMenu: Integer{OlContextMenu});
begin
  try
    if Assigned(FOnContextMenuClose) then
      FOnContextMenuClose(Self, ContextMenu);
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

{ TadxExcelAppEvents }

procedure TadxExcelAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00024500-0000-0000-C000-000000000046}';
    IntfIID:   '{000208D5-0000-0000-C000-000000000046}';
    EventIID:  '{00024413-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxExcelAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Excel2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxExcelAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxExcelAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxExcelAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit; 
    1565: if Assigned(FOnNewWorkbook) then
            FOnNewWorkbook(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1558: if Assigned(FOnSheetSelectionChange) then
            FOnSheetSelectionChange(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange);
    1559: if Assigned(FOnSheetBeforeDoubleClick) then
    {$IFDEF ADX_VCL5}
            FOnSheetBeforeDoubleClick(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange,
              WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnSheetBeforeDoubleClick(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange,
              WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    1560: if Assigned(FOnSheetBeforeRightClick) then
    {$IFDEF ADX_VCL5}
            FOnSheetBeforeRightClick(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange,
              WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnSheetBeforeRightClick(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange,
              WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    1561: if Assigned(FOnSheetActivate) then FOnSheetActivate(Self, Params[0]);
    1562: if Assigned(FOnSheetDeactivate) then FOnSheetDeactivate(Self, Params[0]);
    1563: if Assigned(FOnSheetCalculate) then FOnSheetCalculate(Self, Params[0]);
    1564: if Assigned(FOnSheetChange) then
            FOnSheetChange(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ExcelRange);
    1567: if Assigned(FOnWorkbookOpen) then
            FOnWorkbookOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1568: if Assigned(FOnWorkbookActivate) then
            FOnWorkbookActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1569: if Assigned(FOnWorkbookDeactivate) then
            FOnWorkbookDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1570: if Assigned(FOnWorkbookBeforeClose) then
    {$IFDEF ADX_VCL5}
            FOnWorkbookBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnWorkbookBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    1571: if Assigned(FOnWorkbookBeforeSave) then
    {$IFDEF ADX_VCL5}
            FOnWorkbookBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnWorkbookBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    1572: if Assigned(FOnWorkbookBeforePrint) then
    {$IFDEF ADX_VCL5}
            FOnWorkbookBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnWorkbookBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    1573: if Assigned(FOnWorkbookNewSheet) then
            FOnWorkbookNewSheet(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook, Params[1]);
    1574: if Assigned(FOnWorkbookAddinInstall) then
            FOnWorkbookAddinInstall(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1575: if Assigned(FOnWorkbookAddinUninstall) then
            FOnWorkbookAddinUninstall(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook);
    1554: if Assigned(FOnWindowResize) then
            FOnWindowResize(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as Excel2000.Window);
    1556: if Assigned(FOnWindowActivate) then
            FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as Excel2000.Window);
    1557: if Assigned(FOnWindowDeactivate) then
            FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as Excel2000.Window);
    1854: if Assigned(FOnSheetFollowHyperlink) then
            FOnSheetFollowHyperlink(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as Excel2000.Hyperlink);
    // Excel 2002
    2157: if Assigned(FOnSheetPivotTableUpdate) then
            FOnSheetPivotTableUpdate(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as PivotTable);
    2160: if Assigned(FOnWorkbookPivotTableCloseConnection) then
            FOnWorkbookPivotTableCloseConnection(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable);
    2161: if Assigned(FOnWorkbookPivotTableOpenConnection) then
            FOnWorkbookPivotTableOpenConnection(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable);
    // Excel 2003
    2289: if Assigned(FOnWorkbookSync) then
            FOnWorkbookSync(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook, Params[1]);
    2290: if Assigned(FOnWorkbookBeforeXmlImport) then
    {$IFDEF ADX_VCL5}
            FOnWorkbookBeforeXmlImport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnWorkbookBeforeXmlImport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    2291: if Assigned(FOnWorkbookAfterXmlImport) then
            FOnWorkbookAfterXmlImport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], Params[2], Params[3]);
    2292: if Assigned(FOnWorkbookBeforeXmlExport) then
    {$IFDEF ADX_VCL5}
            FOnWorkbookBeforeXmlExport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
            FOnWorkbookBeforeXmlExport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    2293: if Assigned(FOnWorkbookAfterXmlExport) then
            FOnWorkbookAfterXmlExport(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], Params[2], Params[3]);
    // Excel 2 0 0 7
    2611: if Assigned(FOnWorkbookRowsetComplete) then
            FOnWorkbookRowsetComplete(Self, IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              Params[1], Params[2],Params[3]);
    2612: if Assigned(FOnAfterCalculate) then FOnAfterCalculate(Self);
    // Excel 2 0 1 0
    2895: if Assigned(FOnSheetPivotTableAfterValueChange) then
            FOnSheetPivotTableAfterValueChange(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable,
              IUnknown(TVarData(Params[2]).VPointer) as ExcelRange);
    2896: if Assigned(FOnSheetPivotTableBeforeAllocateChanges) then
    {$IFDEF ADX_VCL5}
            FOnSheetPivotTableBeforeAllocateChanges(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable,
              Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnSheetPivotTableBeforeAllocateChanges(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable,
              Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    2897: if Assigned(FOnSheetPivotTableBeforeCommitChanges) then
    {$IFDEF ADX_VCL5}
            FOnSheetPivotTableBeforeCommitChanges(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable,
              Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnSheetPivotTableBeforeCommitChanges(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable,
              Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    2898: if Assigned(FOnSheetPivotTableBeforeDiscardChanges) then
            FOnSheetPivotTableBeforeDiscardChanges(Self, Params[0],
              IUnknown(TVarData(Params[1]).VPointer) as PivotTable, Params[2], Params[3]);
    2903: if Assigned(FOnProtectedViewWindowOpen) then
            FOnProtectedViewWindowOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2905: if Assigned(FOnProtectedViewWindowBeforeEdit) then
    {$IFDEF ADX_VCL5}
            FOnProtectedViewWindowBeforeEdit(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnProtectedViewWindowBeforeEdit(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2906: if Assigned(FOnProtectedViewWindowBeforeClose) then
    {$IFDEF ADX_VCL5}
            FOnProtectedViewWindowBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnProtectedViewWindowBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    2908: if Assigned(FOnProtectedViewWindowResize) then
            FOnProtectedViewWindowResize(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2909: if Assigned(FOnProtectedViewWindowActivate) then
            FOnProtectedViewWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2910: if Assigned(FOnProtectedViewWindowDeactivate) then
            FOnProtectedViewWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2911: if Assigned(FOnWorkbookAfterSave) then
            FOnWorkbookAfterSave(Self,
              IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook, Params[1]);
    2912: if Assigned(FOnWorkbookNewChart) then
            FOnWorkbookNewChart(Self,
              IUnknown(TVarData(Params[0]).VPointer) as ExcelWorkbook,
              IUnknown(TVarData(Params[1]).VPointer) as ExcelChart);

  end;
end;

{ TadxWordAppEvents }

procedure TadxWordAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00024500-0000-0000-C000-000000000046}';
    IntfIID:   '{000208D5-0000-0000-C000-000000000046}';
    EventIID:  '{000209FE-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxWordAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Word2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxWordAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
const
  EventIID2000: TGUID = '{000209FE-0000-0000-C000-000000000046}';
  EventIID2002: TGUID = '{00020A00-0000-0000-C000-000000000046}';
  EventIID2003: TGUID = '{00020A01-0000-0000-C000-000000000046}';
begin
  if AVersion = '9' then
    ServerData^.EventIID := EventIID2000
  else
    if AVersion = '10' then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

procedure TadxWordAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxWordAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    1 : if Assigned(FOnStartup) then FOnStartup(Self);
    2 : if Assigned(FOnQuit) then FOnQuit(Self);
    3 : if Assigned(FOnDocumentChange) then FOnDocumentChange(Self);
    4 : if Assigned(FOnDocumentOpen) then
          FOnDocumentOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    6 : if Assigned(FOnDocumentBeforeClose) then
    {$IFDEF ADX_VCL5}
          FOnDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    7 : if Assigned(FOnDocumentBeforePrint) then
    {$IFDEF ADX_VCL5}
          FOnDocumentBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnDocumentBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    8 : if Assigned(FOnDocumentBeforeSave) then
    {$IFDEF ADX_VCL5}
          FOnDocumentBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean), WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnDocumentBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^), WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    9 : if Assigned(FOnNewDocument) then
          FOnNewDocument(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    10: if Assigned(FOnWindowActivate) then
          FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            IUnknown(TVarData(Params[1]).VPointer) as Word2000.Window);
    11: if Assigned(FOnWindowDeactivate) then
          FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            IUnknown(TVarData(Params[1]).VPointer) as Word2000.Window);
    12: if Assigned(FOnWindowSelectionChange) then
          FOnWindowSelectionChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection);
    13: if Assigned(FOnWindowBeforeRightClick) then
    {$IFDEF ADX_VCL5}
          FOnWindowBeforeRightClick(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnWindowBeforeRightClick(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    14: if Assigned(FOnWindowBeforeDoubleClick) then
    {$IFDEF ADX_VCL5}
          FOnWindowBeforeDoubleClick(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnWindowBeforeDoubleClick(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    // Word 2002
    15: if Assigned(FOnEPostagePropertyDialog) then
          FOnEPostagePropertyDialog(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    16: if Assigned(FOnEPostageInsert) then
          FOnEPostageInsert(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    17: if Assigned(FOnMailMergeAfterMerge) then begin
          if TVarData(Params[1]).VType = varEmpty then
            FOnMailMergeAfterMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument, nil)
          else
            FOnMailMergeAfterMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
              IUnknown(TVarData(Params[1]).VPointer) as WordDocument);
        end;
    18: if Assigned(FOnMailMergeAfterRecordMerge) then
          FOnMailMergeAfterRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    19: if Assigned(FOnMailMergeBeforeMerge) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeBeforeMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnMailMergeBeforeMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    20: if Assigned(FOnMailMergeBeforeRecordMerge) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeBeforeRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeBeforeRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    21: if Assigned(FOnMailMergeDataSourceLoad) then
          FOnMailMergeDataSourceLoad(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    22: if Assigned(FOnMailMergeDataSourceValidate) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeDataSourceValidate(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeDataSourceValidate(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    23: if Assigned(FOnMailMergeWizardSendToCustom) then
          FOnMailMergeWizardSendToCustom(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument);
    24: if Assigned(FOnMailMergeWizardStateChange) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeWizardStateChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            SYSINT((TVarData(Params[1]).VPointer)^), SYSINT((TVarData(Params[2]).VPointer)^), WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnMailMergeWizardStateChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            SYSINT((TVarData(Params[1]).VPointer)^), SYSINT((TVarData(Params[2]).VPointer)^), WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    25: if Assigned(FOnWindowSize) then
          FOnWindowSize(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            IUnknown(TVarData(Params[1]).VPointer) as Word2000.Window);
    // Word 2003
    26: if Assigned(FOnXMLSelectionChange) then
          FOnXMLSelectionChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WordSelection,
            IUnknown(TVarData(Params[1]).VPointer) as IDispatch, IUnknown(TVarData(Params[2]).VPointer) as IDispatch,
            Integer((TVarData(Params[3]).VPointer)^));
    27: if Assigned(FOnXMLValidationError) then FOnXMLValidationError(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    28: if Assigned(FOnDocumentSync) then
          FOnDocumentSync(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument, Params[1]);
    29: if Assigned(FOnEPostageInsertEx) then
    {$IFDEF ADX_VCL5}
          FOnEPostageInsertEx(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            Params[1], Params[2], Params[3], Params[4], Params[5], Params[6], Params[7], Params[8],
            Params[9], WordBool(TVarData(Params[10]).VBoolean));
    {$ELSE}
          FOnEPostageInsertEx(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            Params[1], Params[2], Params[3], Params[4], Params[5], Params[6], Params[7], Params[8],
            Params[9], WordBool((TVarData(Params[10]).VPointer)^));
    {$ENDIF}
    // Word 2 0 0 7
    30: if Assigned(FOnMailMergeDataSourceValidate2) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeDataSourceValidate2(Self,
            IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeDataSourceValidate2(Self, IUnknown(TVarData(Params[0]).VPointer) as WordDocument,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    // Word 2 0 1 0
    31: if Assigned(FOnProtectedViewWindowOpen) then
          FOnProtectedViewWindowOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    32: if Assigned(FOnProtectedViewWindowBeforeEdit) then
    {$IFDEF ADX_VCL5}
          FOnProtectedViewWindowBeforeEdit(Self,
            IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProtectedViewWindowBeforeEdit(Self,
            IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    33: if Assigned(FOnProtectedViewWindowBeforeClose) then
    {$IFDEF ADX_VCL5}
          FOnProtectedViewWindowBeforeClose(Self,
            IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
            Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnProtectedViewWindowBeforeClose(Self,
            IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
            Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    34: if Assigned(FOnProtectedViewWindowSize) then
          FOnProtectedViewWindowSize(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    35: if Assigned(FOnProtectedViewWindowActivate) then
          FOnProtectedViewWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    36: if Assigned(FOnProtectedViewWindowDeactivate) then
          FOnProtectedViewWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
  end;
end;

{ TadxProjectAppEvents }

procedure TadxProjectAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{36D27C48-A1E8-11D3-BA55-00C04F72F325}';
    IntfIID:   '{00020AFF-0000-0000-C000-000000000046}';
    EventIID:  '{7B7597D0-0C9F-11D0-8C43-00A0C904DCD4}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxProjectAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Project2000._MSProject;
  ConnectEvents(FIntf);
end;

procedure TadxProjectAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
const
  EventIID2000: TGUID = '{7B7597D0-0C9F-11D0-8C43-00A0C904DCD4}';
  EventIID2002: TGUID = '{5066D7C4-1ED7-48C4-ACE7-299E109D368C}';
  EventIID2003: TGUID = '{5066D7C4-1ED7-48C4-ACE7-299E109D368C}';
begin
  if AVersion = '9' then
    ServerData^.EventIID := EventIID2000
  else
    if AVersion = '10' then
      ServerData^.EventIID := EventIID2002
    else
      ServerData^.EventIID := EventIID2003;
  ConnectTo(AIntf);
end;

procedure TadxProjectAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxProjectAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    1 : if Assigned(FOnNewProject) then
          FOnNewProject(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_);
    6 : if Assigned(FOnProjectBeforeTaskDelete) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeTaskDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Task,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeTaskDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Task,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    7 : if Assigned(FOnProjectBeforeResourceDelete) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeResourceDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeResourceDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    8 : if Assigned(FOnProjectBeforeAssignmentDelete) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeAssignmentDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeAssignmentDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    9 : if Assigned(FOnProjectBeforeTaskChange) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeTaskChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Task,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnProjectBeforeTaskChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Task,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    10: if Assigned(FOnProjectBeforeResourceChange) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeResourceChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnProjectBeforeResourceChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    11: if Assigned(FOnProjectBeforeAssignmentChange) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeAssignmentChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnProjectBeforeAssignmentChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    12: if Assigned(FOnProjectBeforeTaskNew) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeTaskNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeTaskNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    13: if Assigned(FOnProjectBeforeResourceNew) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeResourceNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeResourceNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    14: if Assigned(FOnProjectBeforeAssignmentNew) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeAssignmentNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeAssignmentNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2 : if Assigned(FOnProjectBeforeClose) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    4 : if Assigned(FOnProjectBeforePrint) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    3 : if Assigned(FOnProjectBeforeSave) then begin
    {$IFDEF ADX_VCL5}
          if TVarData(Params[0]).VType = varEmpty then
            FOnProjectBeforeSave(Self, nil, Params[1], WordBool(TVarData(Params[2]).VBoolean))
          else
            FOnProjectBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1], WordBool(TVarData(Params[2]).VBoolean));
        end;
    {$ELSE}
          if TVarData(Params[0]).VType = varEmpty then
            FOnProjectBeforeSave(Self, nil, Params[1], WordBool((TVarData(Params[2]).VPointer)^))
          else
            FOnProjectBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1], WordBool((TVarData(Params[2]).VPointer)^));
        end;
    {$ENDIF}
    5 : if Assigned(FOnProjectCalculate) then
          FOnProjectCalculate(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_);
    15: if Assigned(FOnWindowGoalAreaChange) then
          FOnWindowGoalAreaChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window, Params[1]);
    16: if Assigned(FOnWindowSelectionChange) then
          FOnWindowSelectionChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window,
            IUnknown(TVarData(Params[1]).VPointer) as Project2000.Selection, Params[2]);
    17: if Assigned(FOnWindowBeforeViewChange) then
          FOnWindowBeforeViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window,
            Params[1], Params[2], Params[3], Params[4]);
    18: if Assigned(FOnWindowViewChange) then
          FOnWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window,
            Params[1], Params[2], Params[3]);
    19: if Assigned(FOnWindowActivate) then
          FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window);
    20: if Assigned(FOnWindowDeactivate) then
          FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window);
    21: if Assigned(FOnWindowSidepaneDisplayChange) then
          FOnWindowSidepaneDisplayChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window, Params[1]);
    22: if Assigned(FOnWindowSidepaneTaskChange) then
          FOnWindowSidepaneTaskChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window,
            Params[1], Params[2]);
    23: if Assigned(FOnWorkpaneDisplayChange) then FOnWorkpaneDisplayChange(Self, Params[0]);
    24: if Assigned(FOnLoadWebPage) then
          FOnLoadWebPage(Self, IUnknown(TVarData(Params[0]).VPointer) as Project2000.Window,
            WideString((TVarData(Params[1]).VPointer)^));
    25: if Assigned(FOnProjectAfterSave) then FOnProjectAfterSave(Self);
    26: if Assigned(FOnProjectTaskNew) then
          FOnProjectTaskNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    27: if Assigned(FOnProjectResourceNew) then
          FOnProjectResourceNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    28: if Assigned(FOnProjectAssignmentNew) then
          FOnProjectAssignmentNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    29: if Assigned(FOnProjectBeforeSaveBaseline) then
          FOnProjectBeforeSaveBaseline(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            Params[1], Params[2], Params[3], Params[4], Params[5], Params[6], Params[7], Params[8]);
    30: if Assigned(FOnProjectBeforeClearBaseline) then
          FOnProjectBeforeClearBaseline(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_,
            Params[1], Params[2], Params[3], Params[4], Params[5]);
    1073741826:
        if Assigned(FOnProjectBeforeClose2) then
          FOnProjectBeforeClose2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    1073741828:
        if Assigned(FOnProjectBeforePrint2) then
          FOnProjectBeforePrint2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    1073741827:
        if Assigned(FOnProjectBeforeSave2) then begin
          if TVarData(Params[0]).VType = varEmpty then
            FOnProjectBeforeSave2(Self, nil, Params[1], Params[2])
          else
            FOnProjectBeforeSave2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1], Params[2]);
        end;
    1073741830:
        if Assigned(FOnProjectBeforeTaskDelete2) then
          FOnProjectBeforeTaskDelete2(Self, IUnknown(TVarData(Params[0]).VPointer) as Task, Params[1]);
    1073741831:
        if Assigned(FOnProjectBeforeResourceDelete2) then
          FOnProjectBeforeResourceDelete2(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource, Params[1]);
    1073741832:
        if Assigned(FOnProjectBeforeAssignmentDelete2) then
          FOnProjectBeforeAssignmentDelete2(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment, Params[1]);
    1073741833:
        if Assigned(FOnProjectBeforeTaskChange2) then
          FOnProjectBeforeTaskChange2(Self, IUnknown(TVarData(Params[0]).VPointer) as Task,
            Params[1], Params[2], Params[3]);
    1073741834:
        if Assigned(FOnProjectBeforeResourceChange2) then
          FOnProjectBeforeResourceChange2(Self, IUnknown(TVarData(Params[0]).VPointer) as Resource,
            Params[1], Params[2], Params[3]);
    1073741835:
        if Assigned(FOnProjectBeforeAssignmentChange2) then
          FOnProjectBeforeAssignmentChange2(Self, IUnknown(TVarData(Params[0]).VPointer) as Assignment,
            Params[1], Params[2], Params[3]);
    1073741836:
        if Assigned(FOnProjectBeforeTaskNew2) then
          FOnProjectBeforeTaskNew2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    1073741837:
        if Assigned(FOnProjectBeforeResourceNew2) then
          FOnProjectBeforeResourceNew2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    1073741838:
        if Assigned(FOnProjectBeforeAssignmentNew2) then
          FOnProjectBeforeAssignmentNew2(Self, IUnknown(TVarData(Params[0]).VPointer) as Project_, Params[1]);
    31: if Assigned(FOnApplicationBeforeClose) then FOnApplicationBeforeClose(Self, Params[0]);
    // 2 0 1 0
    32: if Assigned(FOnUndoOrRedo) then
          FOnUndoOrRedo(Self, Params[0], Params[1], Params[2]);
    33: if Assigned(FOnAfterCubeBuilt) then
          FOnAfterCubeBuilt(Self, WideString((TVarData(Params[0]).VPointer)^));
    34: if Assigned(FOnLoadWebPane) then
          FOnLoadWebPane(Self,
            IUnknown(TVarData(Params[0]).VPointer) as Window,
            WideString((TVarData(Params[1]).VPointer)^));
    35: if Assigned(FOnJobStart) then
          FOnJobStart(Self, Params[0], Params[1], Params[2], Params[3], Params[4]);
    36: if Assigned(FOnJobCompleted) then
          FOnJobCompleted(Self, Params[0], Params[1], Params[2], Params[3], Params[4]);
    37: if Assigned(FOnSaveStartingToServer) then
          FOnSaveStartingToServer(Self, Params[0], Params[1]);
    38: if Assigned(FOnSaveCompletedToServer) then
          FOnSaveCompletedToServer(Self, Params[0], Params[1]);
    39: if Assigned(FOnProjectBeforePublish) then
    {$IFDEF ADX_VCL5}
          FOnProjectBeforePublish(Self,
            IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnProjectBeforePublish(Self,
            IUnknown(TVarData(Params[0]).VPointer) as Project_,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    40: if Assigned(FOnPaneActivate) then FOnPaneActivate(Self);
    41: if Assigned(FOnSecondaryViewChange) then
          FOnSecondaryViewChange(Self,
            IUnknown(TVarData(Params[0]).VPointer) as Window,
            IUnknown(TVarData(Params[1]).VPointer) as View,
           IUnknown(TVarData(Params[2]).VPointer) as View, Params[3]);
    42: if Assigned(FOnIsFunctionalitySupported) then
          FOnIsFunctionalitySupported(Self, Params[0],
            IUnknown(TVarData(Params[1]).VPointer) as IDispatch);
    43: if Assigned(FOnConnectionStatusChanged) then
          FOnConnectionStatusChanged(Self, Params[0]);
  end;
end;

{ TadxPowerPointAppEvents }

procedure TadxPowerPointAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493441-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{91493442-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{914934C2-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxPowerPointAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as MSPPt2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxPowerPointAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxPowerPointAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxPowerPointAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    2001: if Assigned(FOnWindowSelectionChange) then
            FOnWindowSelectionChange(Self, IUnknown(TVarData(Params[0]).VPointer) as MSPPt2000.Selection);
    2002: if Assigned(FOnWindowBeforeRightClick) then
    {$IFDEF ADX_VCL5}
            FOnWindowBeforeRightClick(Self, IUnknown(TVarData(Params[0]).VPointer) as MSPPt2000.Selection,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnWindowBeforeRightClick(Self, IUnknown(TVarData(Params[0]).VPointer) as MSPPt2000.Selection,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2003: if Assigned(FOnWindowBeforeDoubleClick) then
    {$IFDEF ADX_VCL5}
            FOnWindowBeforeDoubleClick(Self, IUnknown(TVarData(Params[0]).VPointer) as MSPPt2000.Selection,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnWindowBeforeDoubleClick(Self, IUnknown(TVarData(Params[0]).VPointer) as MSPPt2000.Selection,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2004: if Assigned(FOnPresentationClose) then
            FOnPresentationClose(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2005: if Assigned(FOnPresentationSave) then
            FOnPresentationSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2006: if Assigned(FOnPresentationOpen) then
            FOnPresentationOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2007: if Assigned(FOnNewPresentation) then
            FOnNewPresentation(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2008: if Assigned(FOnPresentationNewSlide) then
            FOnPresentationNewSlide(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointSlide);
    2009: if Assigned(FOnWindowActivate) then
            FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              IUnknown(TVarData(Params[1]).VPointer) as DocumentWindow);
    2010: if Assigned(FOnWindowDeactivate) then
            FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              IUnknown(TVarData(Params[1]).VPointer) as DocumentWindow);
    2011: if Assigned(FOnSlideShowBegin) then
            FOnSlideShowBegin(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow);
    2012: if Assigned(FOnSlideShowNextBuild) then
            FOnSlideShowNextBuild(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow);
    2013: if Assigned(FOnSlideShowNextSlide) then
            FOnSlideShowNextSlide(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow);
    2014: if Assigned(FOnSlideShowEnd) then
            FOnSlideShowEnd(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2015: if Assigned(FOnPresentationPrint) then
            FOnPresentationPrint(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2016: if Assigned(FOnSlideSelectionChanged) then
            FOnSlideSelectionChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2017: if Assigned(FOnColorSchemeChanged) then
            FOnColorSchemeChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2018: if Assigned(FOnPresentationBeforeSave) then
    {$IFDEF ADX_VCL5}
            FOnPresentationBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnPresentationBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2019: if Assigned(FOnSlideShowNextClick) then
            FOnSlideShowNextClick(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow, Params[1]);
    2020: if Assigned(FOnAfterNewPresentation) then
            FOnAfterNewPresentation(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2021: if Assigned(FOnAfterPresentationOpen) then
            FOnAfterPresentationOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
    2022: if Assigned(FOnPresentationSync) then
            FOnPresentationSync(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation, Params[1]);
    // 2 0 0 7
    2023: if Assigned(FOnSlideShowOnNext) then
         FOnSlideShowOnNext(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow);
    2024: if Assigned(FOnSlideShowOnPrevious) then
         FOnSlideShowOnPrevious(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow);
    // 2 0 1 0
    2025: if Assigned(FOnPresentationBeforeClose) then
    {$IFDEF ADX_VCL5}
            FOnPresentationBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnPresentationBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2026: if Assigned(FOnProtectedViewWindowOpen) then
            FOnProtectedViewWindowOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2027: if Assigned(FOnProtectedViewWindowBeforeEdit) then
    {$IFDEF ADX_VCL5}
            FOnProtectedViewWindowBeforeEdit(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnProtectedViewWindowBeforeEdit(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    2028: if Assigned(FOnProtectedViewWindowBeforeClose) then
    {$IFDEF ADX_VCL5}
            FOnProtectedViewWindowBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnProtectedViewWindowBeforeClose(Self,
              IUnknown(TVarData(Params[0]).VPointer) as IDispatch,
              Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    2029: if Assigned(FOnProtectedViewWindowActivate) then
            FOnProtectedViewWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2030: if Assigned(FOnProtectedViewWindowDeactivate) then
            FOnProtectedViewWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    2031: if Assigned(FOnPresentationCloseFinal) then
            FOnPresentationCloseFinal(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation);
  end;
end;

{ TadxFrontPageAppEvents }

procedure TadxFrontPageAppEvents.InitServerData;
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

procedure TadxFrontPageAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as FrontPage2000._Application;
  ConnectEvents(FIntf);
end;

procedure TadxFrontPageAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxFrontPageAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxFrontPageAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    1 : if Assigned(FOnWebNew) then FOnWebNew(Self, IUnknown(TVarData(Params[0]).VPointer) as Web);
    2 : if Assigned(FOnWebOpen) then FOnWebOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as Web);
    3 : if Assigned(FOnWebClose) then
    {$IFDEF ADX_VCL5}
          FOnWebClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Web, WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnWebClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Web, WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    4 : if Assigned(FOnBeforeWebPublish) then
    {$IFDEF ADX_VCL5}
          FOnBeforeWebPublish(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WideString((TVarData(Params[1]).VPointer)^), WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnBeforeWebPublish(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WideString((TVarData(Params[1]).VPointer)^), WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    5 : if Assigned(FOnAfterWebPublish) then
    {$IFDEF ADX_VCL5}
          FOnAfterWebPublish(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnAfterWebPublish(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    6 : if Assigned(FOnPageNew) then
          FOnPageNew(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow);
    7 : if Assigned(FOnPageOpen) then
          FOnPageOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow);
    8 : if Assigned(FOnPageClose) then
    {$IFDEF ADX_VCL5}
          FOnPageClose(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnPageClose(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    9 : if Assigned(FOnBeforePageSave) then
    {$IFDEF ADX_VCL5}
          FOnBeforePageSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool(TVarData(Params[1]).VBoolean), WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnBeforePageSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool((TVarData(Params[1]).VPointer)^), WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    10: if Assigned(FOnAfterPageSave) then
    {$IFDEF ADX_VCL5}
          FOnAfterPageSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnAfterPageSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    11: if Assigned(FOnWindowActivate) then
            FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow);
    12: if Assigned(FOnWindowDeactivate) then
            FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow);
    13: if Assigned(FOnBeforeWebWindowViewChange) then
    {$IFDEF ADX_VCL5}
          FOnBeforeWebWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow,
            Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnBeforeWebWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow,
            Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    14: if Assigned(FOnAfterWebWindowViewChange) then
          FOnAfterWebWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow);
    15: if Assigned(FOnRecalculateHyperlinks) then
    {$IFDEF ADX_VCL5}
          FOnRecalculateHyperlinks(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnRecalculateHyperlinks(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    16: if Assigned(FOnBeforePageWindowViewChange) then
    {$IFDEF ADX_VCL5}
          FOnBeforePageWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnBeforePageWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow,
            Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    17: if Assigned(FOnAfterPageWindowViewChange) then
          FOnAfterPageWindowViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow);
    18: if Assigned(FOnPageWindowActivate) then
          FOnPageWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as PageWindow);
    19: if Assigned(FOnWebFileCheckOut) then
    {$IFDEF ADX_VCL5}
          FOnWebFileCheckOut(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            IUnknown(TVarData(Params[1]).VPointer) as WebFile, WordBool(TVarData(Params[2]).VBoolean),
            TOleEnum((TVarData(Params[3]).VPointer)^));
    {$ELSE}
          FOnWebFileCheckOut(Self, IUnknown(TVarData(Params[0]).VPointer) as Web,
            IUnknown(TVarData(Params[1]).VPointer) as WebFile, WordBool((TVarData(Params[2]).VPointer)^),
            TOleEnum((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    20: if Assigned(FOnBeforeWebWindowSubViewChange) then
    {$IFDEF ADX_VCL5}
          FOnBeforeWebWindowSubViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow,
            Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
          FOnBeforeWebWindowSubViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow,
            Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    21: if Assigned(FOnAfterWebWindowSubViewChange) then
          FOnAfterWebWindowSubViewChange(Self, IUnknown(TVarData(Params[0]).VPointer) as WebWindow);
  end;
end;

{ TadxVisioAppEvents }

procedure TadxVisioAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{00021A20-0000-0000-C000-000000000046}';
    IntfIID:   '{000D0700-0000-0000-C000-000000000046}';
    EventIID:  '{000D0B00-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxVisioAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Visio2002.VisioApplication;
  ConnectEvents(FIntf);
end;

procedure TadxVisioAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxVisioAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxVisioAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    4097: if Assigned(FOnAppActivated) then
            FOnAppActivated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4098: if Assigned(FOnAppDeactivated) then
            FOnAppDeactivated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4100: if Assigned(FOnAppObjActivated) then
            FOnAppObjActivated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4104: if Assigned(FOnAppObjDeactivated) then
            FOnAppObjDeactivated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4112: if Assigned(FOnBeforeQuit) then
            FOnBeforeQuit(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4128: if Assigned(FOnBeforeModal) then
            FOnBeforeModal(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    4160: if Assigned(FOnAfterModal) then
            FOnAfterModal(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    32769:if Assigned(FOnWindowOpened) then
            FOnWindowOpened(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    701: if Assigned(FOnSelectionChanged) then
            FOnSelectionChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    16385:if Assigned(FOnBeforeWindowClosed) then
            FOnBeforeWindowClosed(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    4224: if Assigned(FOnWindowActivated) then
            FOnWindowActivated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    702: if Assigned(FOnBeforeWindowSelDelete) then
            FOnBeforeWindowSelDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    703: if Assigned(FOnBeforeWindowPageTurn) then
            FOnBeforeWindowPageTurn(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    704: if Assigned(FOnWindowTurnedToPage) then
            FOnWindowTurnedToPage(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    2: if Assigned(FOnDocumentOpened) then
            FOnDocumentOpened(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    1: if Assigned(FOnDocumentCreated) then
            FOnDocumentCreated(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    3: if Assigned(FOnDocumentSaved) then
            FOnDocumentSaved(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    4: if Assigned(FOnDocumentSavedAs) then
            FOnDocumentSavedAs(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    8194: if Assigned(FOnDocumentChanged) then
            FOnDocumentChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    16386: if Assigned(FOnBeforeDocumentClose) then
            FOnBeforeDocumentClose(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    32772: if Assigned(FOnStyleAdded) then
            FOnStyleAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVStyle);
    8196: if Assigned(FOnStyleChanged) then
            FOnStyleChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVStyle);
    16388: if Assigned(FOnBeforeStyleDelete) then
            FOnBeforeStyleDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVStyle);
    32776: if Assigned(FOnMasterAdded) then
            FOnMasterAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMaster);
    8200: if Assigned(FOnMasterChanged) then
            FOnMasterChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMaster);
    16392: if Assigned(FOnBeforeMasterDelete) then
            FOnBeforeMasterDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMaster);
    32784: if Assigned(FOnPageAdded) then
            FOnPageAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVPage);
    8208: if Assigned(FOnPageChanged) then
            FOnPageChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVPage);
    16400: if Assigned(FOnBeforePageDelete) then
            FOnBeforePageDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVPage);
    32832: if Assigned(FOnShapeAdded) then
            FOnShapeAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    901: if Assigned(FOnBeforeSelectionDelete) then
            FOnBeforeSelectionDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    8256: if Assigned(FOnShapeChanged) then
            FOnShapeChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    902: if Assigned(FOnSelectionAdded) then
            FOnSelectionAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    16448: if Assigned(FOnBeforeShapeDelete) then
            FOnBeforeShapeDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    8320: if Assigned(FOnTextChanged) then
            FOnTextChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    10240: if Assigned(FOnCellChanged) then
            FOnCellChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVCell);
    4352: if Assigned(FOnMarkerEvent) then
            FOnMarkerEvent(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication, Params[1], Params[2]);
    4608: if Assigned(FOnNoEventsPending) then
            FOnNoEventsPending(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    5120: if Assigned(FOnVisioIsIdle) then
            FOnVisioIsIdle(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    200: if Assigned(FOnMustFlushScopeBeginning) then
            FOnMustFlushScopeBeginning(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    201: if Assigned(FOnMustFlushScopeEnded) then
            FOnMustFlushScopeEnded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    5: if Assigned(FOnRunModeEntered) then
            FOnRunModeEntered(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    6: if Assigned(FOnDesignModeEntered) then
            FOnDesignModeEntered(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    7: if Assigned(FOnBeforeDocumentSave) then
            FOnBeforeDocumentSave(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    8: if Assigned(FOnBeforeDocumentSaveAs) then
            FOnBeforeDocumentSaveAs(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    12288: if Assigned(FOnFormulaChanged) then
            FOnFormulaChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVCell);
    33024: if Assigned(FOnConnectionsAdded) then
            FOnConnectionsAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IVConnects);
    16640: if Assigned(FOnConnectionsDeleted) then
            FOnConnectionsDeleted(Self, IUnknown(TVarData(Params[0]).VPointer) as IVConnects);
    202: if Assigned(FOnEnterScope) then
            FOnEnterScope(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication, Params[1], Params[2]);
    203: if Assigned(FOnExitScope) then
            FOnExitScope(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication, Params[1], Params[2], Params[3]);
    204: if Assigned(FOnQueryCancelQuit) then
            FOnQueryCancelQuit(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    205: if Assigned(FOnQuitCanceled) then
            FOnQuitCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    8193: if Assigned(FOnWindowChanged) then
            FOnWindowChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    705: if Assigned(FOnViewChanged) then
            FOnViewChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    706: if Assigned(FOnQueryCancelWindowClose) then
            FOnQueryCancelWindowClose(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    707: if Assigned(FOnWindowCloseCanceled) then
            FOnWindowCloseCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVWindow);
    9: if Assigned(FOnQueryCancelDocumentClose) then
            FOnQueryCancelDocumentClose(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    10: if Assigned(FOnDocumentCloseCanceled) then
            FOnDocumentCloseCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    300: if Assigned(FOnQueryCancelStyleDelete) then
            FOnQueryCancelStyleDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVStyle);
    301: if Assigned(FOnStyleDeleteCanceled) then
            FOnStyleDeleteCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVStyle);
    400: if Assigned(FOnQueryCancelMasterDelete) then
            FOnQueryCancelMasterDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMaster);
    401: if Assigned(FOnMasterDeleteCanceled) then
            FOnMasterDeleteCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMaster);
    500: if Assigned(FOnQueryCancelPageDelete) then
            FOnQueryCancelPageDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVPage);
    501: if Assigned(FOnPageDeleteCanceled) then
            FOnPageDeleteCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVPage);
    802: if Assigned(FOnShapeParentChanged) then
            FOnShapeParentChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    803: if Assigned(FOnBeforeShapeTextEdit) then
            FOnBeforeShapeTextEdit(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    804: if Assigned(FOnShapeExitedTextEdit) then
            FOnShapeExitedTextEdit(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape);
    903: if Assigned(FOnQueryCancelSelectionDelete) then
            FOnQueryCancelSelectionDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    904: if Assigned(FOnSelectionDeleteCanceled) then
            FOnSelectionDeleteCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    905: if Assigned(FOnQueryCancelUngroup) then
            FOnQueryCancelUngroup(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    906: if Assigned(FOnUngroupCanceled) then
            FOnUngroupCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    907: if Assigned(FOnQueryCancelConvertToGroup) then
            FOnQueryCancelConvertToGroup(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    908: if Assigned(FOnConvertToGroupCanceled) then
            FOnConvertToGroupCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    206: if Assigned(FOnQueryCancelSuspend) then
            FOnQueryCancelSuspend(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    207: if Assigned(FOnSuspendCanceled) then
            FOnSuspendCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    208: if Assigned(FOnBeforeSuspend) then
            FOnBeforeSuspend(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    209: if Assigned(FOnAfterResume) then
            FOnAfterResume(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    708: if Assigned(FOnKeystrokeMessageForAddon) then
            FOnKeystrokeMessageForAddon(Self, IUnknown(TVarData(Params[0]).VPointer) as IVMSGWrap);
    709: if Assigned(FOnMouseDown) then
    {$IFDEF ADX_VCL5}
            FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    710: if Assigned(FOnMouseMove) then
    {$IFDEF ADX_VCL5}
            FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    711: if Assigned(FOnMouseUp) then
    {$IFDEF ADX_VCL5}
            FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3], WordBool(TVarData(Params[4]).VBoolean));
    {$ELSE}
            FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3], WordBool((TVarData(Params[4]).VPointer)^));
    {$ENDIF}
    712: if Assigned(FOnKeyDown) then
    {$IFDEF ADX_VCL5}
            FOnKeyDown(Self, Params[0], Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnKeyDown(Self, Params[0], Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    713: if Assigned(FOnKeyPress) then
    {$IFDEF ADX_VCL5}
            FOnKeyPress(Self, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
            FOnKeyPress(Self, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    714: if Assigned(FOnKeyUp) then
    {$IFDEF ADX_VCL5}
            FOnKeyUp(Self, Params[0], Params[1], WordBool(TVarData(Params[2]).VBoolean));
    {$ELSE}
            FOnKeyUp(Self, Params[0], Params[1], WordBool((TVarData(Params[2]).VPointer)^));
    {$ENDIF}
    // 2 0 1 0
    210: if Assigned(FOnQueryCancelSuspendEvents) then
           FOnQueryCancelSuspendEvents(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    211: if Assigned(FOnSuspendEventsCanceled) then
           FOnSuspendEventsCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    212: if Assigned(FOnBeforeSuspendEvents) then
           FOnBeforeSuspendEvents(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    213: if Assigned(FOnAfterResumeEvents) then
           FOnAfterResumeEvents(Self, IUnknown(TVarData(Params[0]).VPointer) as IVApplication);
    909: if Assigned(FOnQueryCancelGroup) then
           FOnQueryCancelGroup(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    910: if Assigned(FOnGroupCanceled) then
           FOnGroupCanceled(Self, IUnknown(TVarData(Params[0]).VPointer) as IVSelection);
    807: if Assigned(FOnShapeDataGraphicChanged) then
           FOnShapeDataGraphicChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IVShape );
    16416: if Assigned(FOnBeforeDataRecordsetDelete) then
           FOnBeforeDataRecordsetDelete(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    8224: if Assigned(FOnDataRecordsetChanged) then
            FOnDataRecordsetChanged(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    32800: if Assigned(FOnDataRecordsetAdded) then
             FOnDataRecordsetAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    805: if Assigned(FOnShapeLinkAdded) then
           FOnShapeLinkAdded(Self,
             IUnknown(TVarData(Params[0]).VPointer) as IVShape, Params[1], Params[2]);
    806: if Assigned(FOnShapeLinkDeleted) then
           FOnShapeLinkDeleted(Self,
             IUnknown(TVarData(Params[0]).VPointer) as IVShape, Params[1], Params[2]);
    11: if Assigned(FOnAfterRemoveHiddenInformation) then
          FOnAfterRemoveHiddenInformation(Self, IUnknown(TVarData(Params[0]).VPointer) as IVDocument);
    502: if Assigned(FOnContainerRelationshipAdded) then
           FOnContainerRelationshipAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    503: if Assigned(FOnContainerRelationshipDeleted) then
           FOnContainerRelationshipDeleted(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    504: if Assigned(FOnCalloutRelationshipAdded) then
           FOnCalloutRelationshipAdded(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    505: if Assigned(FOnCalloutRelationshipDeleted) then
           FOnCalloutRelationshipDeleted(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
    13: if Assigned(FOnRuleSetValidated) then
          FOnRuleSetValidated(Self, IUnknown(TVarData(Params[0]).VPointer) as IDispatch);
  end;
end;

{ TadxMapPointAppEvents }

procedure TadxMapPointAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{31851F82-AFE6-11D2-A3C9-00C04F72F340}';
    IntfIID:   '{D6D389CE-1781-47A0-8984-4349687F65D6}';
    EventIID:  '{91848759-5033-4956-8E9C-B840F11C6045}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMapPointAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as MapPoint2002._Application;
  ConnectEvents(FIntf);
end;

procedure TadxMapPointAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxMapPointAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxMapPointAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;
    100930817: if Assigned(FOnNew) then FOnNew(Self);
    100930818: if Assigned(FOnOpen) then FOnOpen(Self);
    100930819: if Assigned(FOnQuit) then FOnQuit(Self);
    100930820: if Assigned(FOnBeforeSave) then
    {$IFDEF ADX_VCL5}
                 FOnBeforeSave(Self, Params[0], WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
                 FOnBeforeSave(Self, Params[0], WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    100930821: if Assigned(FOnBeforeClose) then
    {$IFDEF ADX_VCL5}
                 FOnBeforeClose(Self, WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
                 FOnBeforeClose(Self, WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
  end;
end;

{ TadxPublisherAppEvents }

procedure TadxPublisherAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0002123D-0000-0000-C000-000000000046}';
    IntfIID:   '{0002123E-0000-0000-C000-000000000046}';
    EventIID:  '{00021240-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxPublisherAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as Publisher2003._Application;
  ConnectEvents(FIntf);
end;

procedure TadxPublisherAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxPublisherAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

procedure TadxPublisherAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
var
  Str: WideString;
begin
  case DispID of
    -1: Exit;
    1 : if Assigned(FOnWindowActivate) then
          FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003.Window);
    2 : if Assigned(FOnWindowDeactivate) then
          FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003.Window);
    4 : if Assigned(FOnWindowPageChange) then
          FOnWindowPageChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003.View);
    5 : if Assigned(FOnQuit) then FOnQuit(Self);
    6 : if Assigned(FOnNewDocument) then
          FOnNewDocument(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    7 : if Assigned(FOnDocumentOpen) then
          FOnDocumentOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    8 : if Assigned(FOnDocumentBeforeClose) then
    {$IFDEF ADX_VCL5}
          FOnDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003. _Document,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003. _Document,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    9 : if Assigned(FOnMailMergeAfterMerge) then
          FOnMailMergeAfterMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    10: if Assigned(FOnMailMergeAfterRecordMerge) then
          FOnMailMergeAfterRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    11: if Assigned(FOnMailMergeBeforeMerge) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeBeforeMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            Params[1], Params[2], WordBool(TVarData(Params[3]).VBoolean));
    {$ELSE}
          FOnMailMergeBeforeMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            Params[1], Params[2], WordBool((TVarData(Params[3]).VPointer)^));
    {$ENDIF}
    12: if Assigned(FOnMailMergeBeforeRecordMerge) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeBeforeRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeBeforeRecordMerge(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    13: if Assigned(FOnMailMergeDataSourceLoad) then
          FOnMailMergeDataSourceLoad(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    16: if Assigned(FOnMailMergeWizardSendToCustom) then
          FOnMailMergeWizardSendToCustom(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    17: if Assigned(FOnMailMergeWizardStateChange) then
          FOnMailMergeWizardStateChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document, Params[1]);
    18: if Assigned(FOnMailMergeDataSourceValidate) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeDataSourceValidate(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeDataSourceValidate(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    // 2 0 0 7
    19: if Assigned(FOnMailMergeInsertBarcode) then
    {$IFDEF ADX_VCL5}
          FOnMailMergeInsertBarcode(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnMailMergeInsertBarcode(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    20: if Assigned(FOnMailMergeRecipientListClose) then
          FOnMailMergeRecipientListClose(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    21: if Assigned(FOnMailMergeGenerateBarcode) then begin
          Str := TVarData(Params[1]).VOleStr;
          FOnMailMergeGenerateBarcode(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document, Str);
          TVarData(Params[1]).VOleStr := PWideChar(Str);
        end;
    22: if Assigned(FOnMailMergeWizardFollowUpCustom) then
          FOnMailMergeWizardFollowUpCustom(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    23: if Assigned(FOnBeforePrint) then
    {$IFDEF ADX_VCL5}
          FOnBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool(TVarData(Params[1]).VBoolean));
    {$ELSE}
          FOnBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document,
            WordBool((TVarData(Params[1]).VPointer)^));
    {$ENDIF}
    24: if Assigned(FOnAfterPrint) then
          FOnAfterPrint(Self, IUnknown(TVarData(Params[0]).VPointer) as Publisher2003._Document);
    25: if Assigned(FOnShowCatalogUI) then FOnShowCatalogUI(Self);
    26: if Assigned(FOnHideCatalogUI) then FOnHideCatalogUI(Self);
  end;
end;

{ TadxInfoPathAppEvents }

procedure TadxInfoPathAppEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8075635F-5146-11D5-A672-00B0D022E945}';
    IntfIID:   '{096CD72E-0786-11D1-95FA-0080C78EE3BB}';
    EventIID:  '{096CD72D-0786-11D1-95FA-0080C78EE3BB}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxInfoPathAppEvents.ConnectTo(AIntf: IDispatch);
begin
  Disconnect;
  FIntf := AIntf as InfoPath2007._Application3;
  ConnectEvents(FIntf.Events);
end;

procedure TadxInfoPathAppEvents.ConnectTo(AIntf: IDispatch; AVersion: string);
begin
  ConnectTo(AIntf);
end;

procedure TadxInfoPathAppEvents.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf.Events);
    FIntf := nil;
  end;
end;

procedure TadxInfoPathAppEvents.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnWindowActivate) then
         FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           IUnknown(TVarData(Params[1]).VPointer) as Window);
    2: if Assigned(FOnWindowDeactivate) then
         FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           IUnknown(TVarData(Params[1]).VPointer) as Window);
    3: if Assigned(FOnWindowSize) then
         FOnWindowSize(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           IUnknown(TVarData(Params[1]).VPointer) as Window);
    4: if Assigned(FOnXDocumentBeforeClose) then
    {$IFDEF ADX_VCL5}
         FOnXDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
         FOnXDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    5: if Assigned(FOnXDocumentBeforePrint) then
    {$IFDEF ADX_VCL5}
         FOnXDocumentBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
         FOnXDocumentBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    6: if Assigned(FOnXDocumentBeforeSave) then
    {$IFDEF ADX_VCL5}
         FOnXDocumentBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool(TVarData(Params[0]).VBoolean));
    {$ELSE}
         FOnXDocumentBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument,
           WordBool((TVarData(Params[0]).VPointer)^));
    {$ENDIF}
    7: if Assigned(FOnNewXDocument) then
         FOnNewXDocument(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument);
    8: if Assigned(FOnXDocumentOpen) then
         FOnXDocumentOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument);
    9: if Assigned(FOnQuit) then FOnQuit(Self);
    10: if Assigned(FOnXDocumentChange) then FOnXDocumentChange(Self);
  end;
end;

end.


