{ *************************************************************************** }
{                                                                             }
{ Delphi and Kylix Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 2000-2002 Borland Software Corporation                        }
{                                                                             }
{ This file may be distributed and/or modified under the terms of the GNU     }
{ General Public License (GPL) version 2 as published by the Free Software    }
{ Foundation and appearing at http://www.borland.com/kylix/gpl.html.          }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit QFileCtrls;

interface

uses
{$IFDEF MSWINDOWS}
  Windows, ShellAPI, Registry,
{$ENDIF}
  Types, SysUtils, Classes, QTypes, QControls, QGraphics, QStdCtrls, QComCtrls,
  Qt, QImgList, IniFiles
{$IFDEF LINUX}
  , Libc
{$ENDIF}
;

const
  RESULT_OK             =  0;
  RESULT_ACCESS_DENIED  = -1;
  RESULT_DIR_NOT_EMPTY  = -2;
  RESULT_FILE_NOT_FOUND = -3;
  RESULT_ALREADY_EXISTS = -4;

type
  TDirectoryTreeView = class;
  TFileHistoryComboBox = class;
  TFileEdit = class;

  TIconSize = (isSmall, isLarge, isVeryLarge);

  TFileIconProvider = class(TCustomImageList)
  private
    FIndexes: TStringHash;
    FIconSize: TIconSize;
  protected
    function DoGetImageIndex(Info: PFileInfo; const CurDir: string = ''): Integer; virtual;
    procedure DrawLinkOverlay(Canvas: TCanvas; X, Y: Integer; Info: PFileInfo); virtual;
    procedure Init; virtual;
  public
    constructor Create(Size: TIconSize); reintroduce; virtual;
    destructor Destroy; override;
    procedure Clear;
    property IconSize: TIconSize read FIconSize;
    property Indexes: TStringHash read FIndexes;
  end;

  TFileIconProviderClass = class of TFileIconProvider;

  TSortDirection = (sdAscending, sdDescending);
  TSortMode = (smNone, smName, smSize, smType, smDate, smAttributes, smOwner, smGroup);

  TFileAttr = (ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory,
    ftArchive, ftNormal);
  TFileType = set of TFileAttr;

  TDirectoryChangeEvent = procedure(Sender: TObject; const NewDir: WideString) of object;
  TFileFoundEvent = procedure(Sender: TObject; const AFile: TSearchRec;
    var CanAdd: Boolean) of object;
  TMaskChangeEvent = procedure(Sender: TObject; const NewMask: WideString) of object;

  IDirectoryClient = interface
    ['{9EF96257-2736-D611-9E48-00B0D006527D}']
    function FileFound(const SearchRec: TSearchRec): Boolean;
    procedure ListEnd;
    function ListStart: Boolean;
    procedure DirectoryChanged(const NewDir: WideString);
    procedure MaskChange(const NewMask: WideString);
  end;

{$IFDEF MSWINDOWS}
  TShellChangeThread = class(TThread)
  private
    FMutex: Integer;
    FWaitHandle: Integer;
    FChangeEvent: TThreadMethod;
    FDirectory: string;
  protected
    procedure Execute; override;
  public
    constructor Create(ChangeEvent: TThreadMethod; Directory: string); virtual;
    destructor Destroy; override;
  end;
{$ENDIF}

  TDirectory = class(TPersistent)
  private
    FAutoUpdate: Boolean;
    FIncludeParentDir: Boolean;
    FSortMode: TSortMode;
    FFileType: TFileType;
    FSuspendEvents: Boolean;
    FDirChanging: Boolean;
    FClient: IDirectoryClient;
    FFiles: TList;
    FDir: WideString;
    FDirHandle: Integer;
    FMask: WideString;
    FSortDirection: TSortDirection;
    FUpdateCount: Integer;
{$IFDEF MSWINDOWS}
    FChangeThread: TShellChangeThread;
    procedure ChangeNotification;
{$ENDIF}
    procedure ClearList;
    procedure RemoveChangeNotification;
    procedure SetChangeNotification(const Dir: string);
    procedure SetIncludeParentDir(const Value: Boolean);
    procedure SetAutoUpdate(const Value: Boolean);
    procedure SetSortMode(const Value: TSortMode);
    procedure SetSortDirection(const Value: TSortDirection);
    function GetDir: WideString;
    procedure ListDrives;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DoFileFound(const SearchRec: TSearchRec); dynamic;
    procedure DoListEnd; dynamic;
    function DoListStart: Boolean; dynamic;
    procedure DoDirChange(const NewDir: WideString); dynamic;
    procedure DoMaskChange(const NewMask: WideString); dynamic;
    procedure SetDir(const Value: WideString); virtual;
    procedure SetMask(const Value: WideString); virtual;
    procedure SetFileType(const Value: TFileType); virtual;
    function UniqueName(const Name: WideString): WideString;
  public
    constructor Create(AClient: IDirectoryClient); reintroduce; virtual;
    destructor Destroy; override;
    procedure BeginUpdate;
    function Count: Integer;
    function CreateDirectory(const DirName: WideString): PFileInfo;
    function Delete(const Filename: WideString): Integer; overload;
    function Delete(AFile: PFileInfo): Integer; overload;
    procedure EndUpdate;
    function IndexOf(const Filename: WideString): Integer;
    procedure ListFiles(Reread: Boolean = True); virtual;
    procedure Sort;
{$IFDEF LINUX}
    function LinkName(Index: Integer): WideString;
{$ENDIF}
    function Files(Index: Integer): PFileInfo;
    function Rename(const Filename, NewName: WideString): Integer; overload;
    function Rename(AFile: PFileInfo; const NewName: WideString): Integer; overload;
    function Caption(Index: Integer): WideString;
    function Attributes(Index: Integer): Integer;
    function Size(Index: Integer): Cardinal;
    function Date(Index: Integer): Integer;
{$IFDEF LINUX}
    function GroupName(Index: Integer): WideString;
    function OwnerName(Index: Integer): WideString;
{$ENDIF}
  published
    property AutoUpdate: Boolean read FAutoUpdate write SetAutoUpdate
      default False;
    property IncludeParentDir: Boolean read FIncludeParentDir
      write SetIncludeParentDir default True;
    property Location: WideString read GetDir write SetDir;
    property FileType: TFileType read FFileType write SetFileType
      default [ftNormal, ftSystem, ftDirectory];
    property FileMask: WideString read FMask write SetMask;
    property SortMode: TSortMode read FSortMode write SetSortMode default smName;
    property SortDirection: TSortDirection read FSortDirection
      write SetSortDirection default sdAscending;
  end;

  TFileListColumn = (flcName, flcSize, flcType, flcDate, flcAttributes
  {$IFDEF LINUX}
  , flcOwner, flcGroup
  {$ENDIF});

{ TODO 2 : TreeView: Handle setting directory when user doesn't have read access. }
  TFileListView = class(TCustomListView, IDirectoryClient)
  private
    FSaveCursor: TCursor;
    FCreatingDir: Boolean;
    FCreatedDir: Boolean;
{$IFDEF MSWINDOWS}
    FDrivesListed: Boolean;
{$ENDIF}
    FDirectory: TDirectory;
    FOnDirChange: TDirectoryChangeEvent;
    FOnFileFound: TFileFoundEvent;
    FIconProvider: TFileIconProvider;
    FOnMaskChange: TMaskChangeEvent;
    function GetSelections: TFileInfos;
    procedure SetDirectory(const Value: TDirectory);
    procedure ImageChange;
  protected
    procedure ColumnClicked(Column: TListColumn); override;
    function CreateEditor: TItemEditor; override;
    procedure DblClick; override;
    procedure DoGetImageIndex(item: TCustomViewItem); override;
    function DoCustomDrawViewItem(Item: TCustomViewItem; Canvas: TCanvas; const Rect: TRect;
      State: TCustomDrawState; Stage: TCustomDrawStage): Boolean; override;
    function DoCustomDrawViewSubItem(Item: TCustomViewItem; SubItem: Integer; Canvas: TCanvas;
      const Rect: TRect; State: TCustomDrawState; Stage: TCustomDrawStage): Boolean; override;
    function DoCustomHint(var HintInfo: THintInfo): Boolean; override;
    procedure DoEdited(AItem: TCustomViewItem; var S: WideString); override;
    procedure DoEditing(AItem: TCustomViewItem; var AllowEdit: Boolean); override;
    procedure ImageListChanged; override;
    procedure InitWidget; override;
    function IsCustomDrawn: Boolean; override;
    function IsOwnerDrawn: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function NeedKey(Key: Integer; Shift: TShiftState; const KeyText: WideString): Boolean; override;
    procedure PositionEditor(var NewLeft, NewTop: Integer); override;
    { IDirectoryClient }
    function FileFound(const SearchRec: TSearchRec): Boolean; dynamic;
    procedure ListEnd; dynamic;
    function ListStart: Boolean; dynamic;
    procedure DirectoryChanged(const NewDir: WideString); dynamic;
    procedure MaskChange(const NewMask: WideString); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateDirectory(const DefaultName: WideString);
    function DeleteFile(const Filename: WideString): Integer;
    procedure GoDown;
    procedure GoUp;
    procedure Refresh;
    function RenameFile(Item: TListItem; const NewName: WideString): Integer;
    property Canvas;
    property Columns;
    property Items;
    property SelCount;
    property Selections: TFileInfos read GetSelections;
  published
    property Align;
    property Anchors;
    property BorderStyle default bsSunken3d;
    property Color;
    property ColumnClick default True;
    property ColumnResize default True;
    property Constraints;
    property Directory: TDirectory read FDirectory write SetDirectory;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property Hint;
    property Images;
    property MultiSelect default False;
    property ReadOnly default True;
    property RowSelect default False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property ViewStyle;
    property Visible;
    property Width;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnResize;
    property OnContextPopup;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnDblClick;
    property OnDeletion;
    property OnDirectoryChanged: TDirectoryChangeEvent read FOnDirChange
      write FOnDirChange;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFileFound: TFileFoundEvent read FOnFileFound write FOnFileFound;
    property OnGetImageIndex;
    property OnInsert;
    property OnItemClick;
    property OnItemDoubleClick;
    property OnItemEnter;
    property OnItemExitViewportEnter;
    property OnItemMouseDown;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnMaskChange: TMaskChangeEvent read FOnMaskChange write FOnMaskChange;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDrag;
    property OnViewPortMouseDown;
  end;

  TFileIconView = class(TCustomIconView, IDirectoryClient)
  private
    FSaveCursor: TCursor;
    FCreatingDir: Boolean;
    FCreatedDir: Boolean;
{$IFDEF MSWINDOWS}
    FDrivesListed: Boolean;
{$ENDIF}
    FIconSize: TIconSize;
    FDirectory: TDirectory;
    FOnDirChange: TDirectoryChangeEvent;
    FOnFileFound: TFileFoundEvent;
    FIconProvider: TFileIconProvider;
    FOnMaskChange: TMaskChangeEvent;
    function GetSelections: TFileInfos;
    procedure SetIconSize(const Value: TIconSize);
    procedure ImageChange;
    procedure SetDirectory(const Value: TDirectory);
  protected
    function CreateEditor: TItemEditor; override;
    procedure DblClick; override;
    procedure DoGetImageIndex(item: TIconViewItem); override;
    function DoCustomDrawIconItem(Item: TIconViewItem; Canvas: TCanvas; const Rect: TRect;
      State: TCustomDrawState; Stage: TCustomDrawStage): Boolean; override;
    function DoCustomHint(var HintInfo: THintInfo): Boolean; override;
    procedure DoEdited(AItem: TIconViewItem; var S: WideString); override;
    procedure DoEditing(AItem: TIconViewItem; var AllowEdit: Boolean); override;
    procedure DoGetIconSize(Item: TIconViewItem; var Width, Height: Integer); override;
    procedure ImageListChanged; override;
    procedure InitWidget; override;
    function IsCustomDrawn: Boolean; override;
    function IsOwnerDrawn: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    function NeedKey(Key: Integer; Shift: TShiftState; const KeyText: WideString): Boolean; override;
    procedure PositionEditor(var NewLeft, NewTop: Integer); override;
    { IDirectoryClient }
    function FileFound(const SearchRec: TSearchRec): Boolean; dynamic;
    procedure ListEnd; dynamic;
    function ListStart: Boolean; dynamic;
    procedure DirectoryChanged(const NewDir: WideString); dynamic;
    procedure MaskChange(const NewMask: WideString); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateDirectory(const DefaultName: WideString);
    function DeleteFile(const Filename: WideString): Integer;
    procedure GoDown;
    procedure GoUp;
    procedure Refresh;
    function RenameFile(Item: TIconViewItem; const NewName: WideString): Integer;
    property Items;
    property SelCount;
    property Selected;
    property Selections: TFileInfos read GetSelections;
  published
    property Align;
    property Anchors;
    property BorderStyle default bsSunken3d;
    property Color;
    property Constraints;
    property Directory: TDirectory read FDirectory write SetDirectory;
    property DragMode;
    property Enabled;
    property Font;
    property Height;
    property Hint;
    property IconOptions;
    property IconSize: TIconSize read FIconSize write SetIconSize default isLarge;
    property Images;
    property MultiSelect;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TextPosition;
    property Visible;
    property Width;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnContextPopup;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDirectoryChange: TDirectoryChangeEvent read FOnDirChange
      write FOnDirChange;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFileFound: TFileFoundEvent read FOnFileFound write FOnFileFound;
    property OnGetImageIndex;
    property OnItemClicked;
    property OnItemDoubleClick;
    property OnItemEnter;
    property OnItemExitViewportEnter;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnMaskChange: TMaskChangeEvent read FOnMaskChange write FOnMaskChange;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnStartDrag;
  end;

  TDirectoryNode = class(TTreeNode)
  private
    FDirClient: IDirectoryClient;
    FDirectory: TDirectory;
  protected
    procedure UpdateImages; override;
  public
    constructor Create(AOwner: TCustomViewItems; AParent:
      TCustomViewItem = nil; After: TCustomViewItem = nil); override;
    destructor Destroy; override;
    procedure Populate;
    { IDirectoryClient proxy }
    function FileFound(const SearchRec: TSearchRec): Boolean; virtual;
    procedure ListEnd; virtual;
    function ListStart: Boolean; virtual;
    procedure DirectoryChanged(const NewDir: WideString); virtual;
    procedure MaskChange(const NewMask: WideString); virtual;
  end;

  EDirectoryError = class(Exception);
  ESetDirectoryError = class(EDirectoryError);
  ECreateDirectoryError = class(EDirectoryError);

  TDirectoryTreeView = class(TCustomTreeView)
  private
    FChanging: Boolean;
    FFileType: TFileType;
    FIconSize: TIconSize;
    FRootDir: WideString;
    FDir: WideString;
    FIconProvider: TFileIconProvider;
    FakePix: QPixmapH;
    procedure SetDir(const Value: WideString);
    function GetAbsolutePath(Node: TTreeNode): string;
    procedure SetRootDir(const Value: WideString);
    function GetDir: WideString;
    procedure SetFileType(const Value: TFileType);
  protected
    procedure AddDirectories(Node: TTreeNode);
    function CanExpand(Node: TTreeNode): Boolean; override;
    procedure Change(Node: TTreeNode); override;
    function DoCustomDrawViewItem(Item: TCustomViewItem; Canvas: TCanvas;
      const Rect: TRect; State: TCustomDrawState;
      Stage: TCustomDrawStage): Boolean; override;
    function DoCustomHint(var HintInfo: THintInfo): Boolean; override;
    procedure DoGetImageIndex(item: TCustomViewItem); override;
    procedure ImageListChanged; override;
    procedure InitWidget; override;
    function IsCustomDrawn: Boolean; override;
    function IsOwnerDrawn: Boolean; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property RootDirectory: WideString read FRootDir write SetRootDir;
    property Directory: WideString read GetDir write SetDir;
    property Align;
    property Anchors;
    property BorderStyle default bsSunken3d;
    property Color;
    property Constraints;
    property DragMode;
    property Enabled;
    property FileType: TFileType read FFileType write SetFileType default [ftDirectory, ftSystem];
    property Font;
    property Height;
    property Hint;
    property Images;
    property ItemMargin;
    property Indent;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly default True;
    property ShowButtons;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Width;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnContextPopup;
    property OnCustomDrawBranch;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnInsert;
    property OnItemClick;
    property OnItemDoubleClick;
    property OnItemEnter;
    property OnItemExitViewportEnter;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnItemMouseDown;
    property OnViewPortMouseDown;
  end;

  TFilterComboBox = class(TCustomComboBox)
  private
    FFilter: string;
    MaskList: TStringList;
    FEditable: Boolean;
    function IsFilterStored: Boolean;
    function GetMask: WideString;
    procedure SetFilter(const NewFilter: string);
    procedure SetEditable(const Value: Boolean);
  protected
    procedure BuildList;
    procedure InitWidget; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ListMasks(List: TStrings);
    property Mask: WideString read GetMask;
    property Text;
  published
    property Anchors;
    property AutoComplete;
    property Color;
    property Constraints;
    property DragMode;
    property Editable: Boolean read FEditable write SetEditable default False;
    property Enabled;
    property Filter: string read FFilter write SetFilter stored IsFilterStored;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHighlighted;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnSelect;
    property OnStartDrag;
  end;

  TFileHistoryComboBox = class(TCustomComboBox)
  private
    FChanging: Boolean;
    FHistList: TStrings;
    FHistIndex: Integer;
    FIconProvider: TFileIconProvider;
    function GetFile(Index: Integer): PFileInfo;
    procedure UpdateItems;
    procedure CMKeyDown(var Msg: TCMKeyDown); message CM_KEYDOWN;
  protected
    procedure Click; override;
    procedure RemoveItem(Index: Integer);
    function DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState): Boolean; override;
    procedure InitWidget; override;
    procedure Loaded; override;
    procedure SaveWidgetState; override;
    procedure RestoreWidgetState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add(const Filename: string): Boolean;
    function CanGoBack: Boolean;
    function CanGoForward: Boolean;
    procedure Clear;
    procedure GoBack;
    procedure GoForward;
    property Files[Index: Integer]: PFileInfo read GetFile;
    property ItemIndex;
  published
    property Anchors;
    property AutoComplete;
    property Color default clBase;
    property Constraints;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property MaxItems;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint default False;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHighlighted;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnSelect;
    property OnStartDrag;
  end;

  TResizeType = (rtNone, rtHorz, rtVert, rtBoth);
  TPopupListBox = class(TCustomListBox)
  private
    FResizeType: TResizeType;
    FResized: Boolean;
    FDroppedUp: Boolean;
    function GetResizeType(P: TPoint): TResizeType;
  protected
    procedure InitWidget; override;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function WidgetFlags: Integer; override;
  public
    constructor CreateParented(ParentWidget: QWidgetH);
  end;

  TFileEditMode = (emDropDownList, emAutoComplete);
  TFileEdit = class(TCustomEdit, IDirectoryClient)
  private
    FDroppedDown: Boolean;
    FEditMode: TFileEditMode;
    FDirectory: TDirectory;
    FListedDir: WideString;
    FCurrentDir: WideString;
    FMatchCount: Integer;
    FDropDownCount: Integer;
    FListBox: TPopupListBox;
    FOriginalText: WideString;
    FPrefix: WideString;
    FOnDirChange: TDirectoryChangeEvent;
    FOnFileFound: TFileFoundEvent;
    FOnMaskChange: TMaskChangeEvent;
    function CheckNewDirectory(const Text: WideString): Boolean;
    procedure CMKeyDown(var Msg: TCMKeyDown); message CM_KEYDOWN;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    function MatchText: WideString;
    function PartialMatch(const Str: WideString): Integer;
    procedure ResizeListBox(ItemCount: Integer);
    procedure SetListIndex(Value: Integer);
    function GetCurrentDir: WideString;
    procedure SetDirectory(const Value: TDirectory);
  protected
    procedure CloseUp;
    procedure DropDown;
    procedure InitWidget; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PopulateList(const Directory: WideString; Prefix: WideString = ''); virtual;
    procedure ReturnPressed(var Suppress: Boolean); override;
    { IDirectoryClient }
    function FileFound(const SearchRec: TSearchRec): Boolean; dynamic;
    procedure Loaded; override;
    procedure ListEnd; dynamic;
    function ListStart: Boolean; dynamic;
    procedure DirectoryChanged(const NewDir: WideString); dynamic;
    procedure MaskChange(const NewMask: WideString); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CurrentDir: WideString read GetCurrentDir;
    property DroppedDown: Boolean read FDroppedDown;
  published
    property Anchors;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Constraints;
    property Directory: TDirectory read FDirectory write SetDirectory;
    property DragMode;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount
      default 10;
    property EditMode: TFileEditMode read FEditMode write FEditMode
      default emDropDownList;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint default False;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDirectoryChange: TDirectoryChangeEvent read FOnDirChange
      write FOnDirChange;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnFileFound: TFileFoundEvent read FOnFileFound write FOnFileFound;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyString;
    property OnKeyUp;
    property OnMaskChange: TMaskChangeEvent read FOnMaskChange write FOnMaskChange;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnReturnPressed;
    property OnStartDrag;
  end;

  TGetFileTypeProc = function(FileInfo: PFileInfo): string;

function IconProvider16: TFileIconProvider;
function IconProvider32: TFileIconProvider;
function IconProvider48: TFileIconProvider;
function ExpandDirectoryName(Directory: string): string;
function IconPixels(const Size: TIconSize): Integer;
function AllocFileInfo(SearchRec: TSearchRec): PFileInfo;
function HasSubDirs(const Directory: WideString;
  IncludeHidden: Boolean = False): Boolean;
function IsRelativePath(const Filename: string): Boolean;
function IsDriveRoot(Text: string): Boolean;
function GetFileType(Info: PFileInfo): string;

var
  GetFileTypeProc: TGetFileTypeProc = GetFileType;
  FileIconProviderClass: TFileIconProviderClass = nil;

const
  ThisDir = '.';
  UpDir = '..';
{$IFDEF LINUX}
  AllMask = '*';
{$ENDIF}
{$IFDEF MSWINDOWS}
  AllMask = '*.*';
{$ENDIF}

implementation

uses QForms, QMenus, QConsts, QDialogs;

{$R *.res}

{$IFDEF MSWINDOWS}

function HasDrivePrefix(const Text: string): Boolean;
begin
  Result := (Length(Text) > 1) and (Text[1] in ['a'..'z', 'A'..'Z']) and
    (Text[2] = DriveDelim);
end;

function GetDrive(const Text: string): string;
begin
  if HasDrivePrefix(Text) then
    Result := Copy(Text, 1, 2);
end;

function AttributeString(Attr: Integer): string;
begin
  Result := '';
  if Attr and faReadOnly <> 0 then
    Result := Result + 'R'; { Do not localize }
  if Attr and faHidden <> 0 then
    Result := Result + 'H'; { Do not localize }
  if Attr and faSysFile <> 0 then
    Result := Result + 'S'; { Do not localize }
  if Attr and faArchive <> 0 then
    Result := Result + 'A'; { Do not localize }
end;

procedure CreateDriveInfo(Drive: string; var SR: TSearchRec);
var
  shinf: SHFILEINFO;
  FreeSpace,
  TotalSize: Int64;
  OldErrorMode: Integer;
begin
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    Drive := IncludeTrailingPathDelimiter(Drive);
    FillChar(SR, SizeOf(SR), 0);
    SR.Name := Drive;
    if SHGetFileInfo(PChar(Drive), 0, shinf, SizeOf(shinf),
      SHGFI_DISPLAYNAME) <> 0 then
    begin
      SR.Name := shinf.szDisplayName;
      SR.Attr := faVolumeID;
      if GetDiskFreeSpaceEx(PChar(Drive),
         FreeSpace, TotalSize, nil) then
      begin
        SR.Size := TotalSize div 1000000;
        SR.Time := FreeSpace div 1000000;
      end;
    end;
    StrLCopy(SR.FindData.cFileName, PChar(Drive), MAX_PATH);
  finally
    SetErrorMode(OldErrorMode);
  end;
end;

type
  TWindowsFileIconProvider = class(TFileIconProvider)
  private
    Reg: TRegistry;
    function AddIcon(IconFile: string; Index: Integer): Integer;
  protected
    function GetIconDataFromRegistry(const Key: string; var IconFile: string;
      var Index: Integer): Boolean;
    function DoGetImageIndex(Info: PFileInfo; const CurDir: string = ''): Integer; override;
    procedure Init; override;
  public
    constructor Create(Size: TIconSize); override;
    destructor Destroy; override;
  end;
{$ENDIF}

type
  PSearchRec = ^TSearchRec;

const
{$IFDEF MSWINDOWS}
  iiUnknownIcon = -1;
  iiNoIcon = -2;
{$ENDIF}

  iiClosedFolder = 0;
  iiOpenFolder = 1;
  iiHiddenClosedFolder = 2;
  iiHiddenOpenFolder = 3;
  iiDefaultFile = 4;
  iiHiddenDefaultFile = 5;
  iiLinkOverlay = 6;

  LVLeftMargin = 3;

  ResourceNames: array[iiClosedFolder..iiLinkOverlay] of string = (
    'QFC_FLDCLOSED', 'QFC_FLDOPEN', 'QFC_HIDDENFLDCLOSED', 'QFC_HIDDENFLDOPEN',
    'QFC_DEFFILE', 'QFC_HIDDENDEFFILE', 'QFC_LINK');

  AttrWords: array[TFileAttr] of Word = (faReadOnly, faHidden, faSysFile,
    faVolumeID, faDirectory, faArchive, 0);


var
  DirChangeList: TList = nil;
  GIconProvider16: TFileIconProvider = nil;
  GIconProvider32: TFileIconProvider = nil;
  GIconProvider48: TFileIconProvider = nil;
  IVSelectBmp: TBitmap = nil;

procedure Error(const Msg: WideString);
begin
  MessageDlg(SMsgDlgError, Msg, mtError, [mbOk], 0);
end;

function IconPixels(const Size: TIconSize): Integer;
begin
{$IFDEF LINUX}
   case Size of
     isSmall: Result := 16;
     isLarge: Result := 32;
     isVeryLarge: Result := 48;
{$ENDIF}
{$IFDEF MSWINDOWS}
   case Size of
     isSmall: Result := GetSystemMetrics(SM_CXSMICON);
     isLarge: Result := GetSystemMetrics(SM_CXICON);
     isVeryLarge: Result := GetSystemMetrics(SM_CXICON);
{$ENDIF}
   else
     Result := 0;
   end;
end;

function IconProvider16: TFileIconProvider;
begin
  if GIconProvider16 = nil then
  begin
    if not Assigned(FileIconProviderClass) then
{$IFDEF MSWINDOWS}
      FileIconProviderClass := TWindowsFileIconProvider;
{$ELSE}
      FileIconProviderClass := TFileIconProvider;
{$ENDIF}
    GIconProvider16 := FileIconProviderClass.Create(isSmall);
  end;
  Result := GIconProvider16;
end;

function IconProvider32: TFileIconProvider;
begin
  if GIconProvider32 = nil then
  begin
    if not Assigned(FileIconProviderClass) then
{$IFDEF MSWINDOWS}
      FileIconProviderClass := TWindowsFileIconProvider;
{$ELSE}
      FileIconProviderClass := TFileIconProvider;
{$ENDIF}
    GIconProvider32 := FileIconProviderClass.Create(isLarge);
  end;
  Result := GIconProvider32;
end;

function IconProvider48: TFileIconProvider;
begin
  if GIconProvider48 = nil then
  begin
    if not Assigned(FileIconProviderClass) then
{$IFDEF MSWINDOWS}
      FileIconProviderClass := TWindowsFileIconProvider;
{$ELSE}
      FileIconProviderClass := TFileIconProvider;
{$ENDIF}
    GIconProvider48 := FileIconProviderClass.Create(isVeryLarge);
  end;
  Result := GIconProvider48;
end;

procedure AllocSelectBmp;
begin
  if Assigned(IVSelectBmp) then Exit;
  IVSelectBmp := AllocPatternBitmap(clMask, clHighlight, 2, 2);
  IVSelectBmp.Mask(clMask);
end;

{$IFDEF LINUX}
procedure DirChanged(SigNum : Integer; context: TSigContext); cdecl; export;
var
  I: Integer;
begin
  if SigNum = SIGIO then
    for I := 0 to DirChangeList.Count - 1 do
    begin
      if TDirectory(DirChangeList[I]).FDirHandle = context.ds then
        TDirectory(DirChangeList[I]).ListFiles;
    end;
end;
{$ENDIF}

function AllocFileInfo(SearchRec: TSearchRec): PFileInfo;
{$IFDEF LINUX}
var
  statbuf: TStatBuf;
  FName: string;
  Ret: Integer;
  Buffer: array[0.._POSIX_PATH_MAX - 1] of Char;
{$ENDIF}
begin
  New(Result);
  FillChar(Result^, SizeOf(Result^), 0);
  Result^.SR := SearchRec;
{$IFDEF LINUX}
  FName := SearchRec.PathOnly + SearchRec.Name;
  if stat(PChar(FName), statbuf) = 0 then
    Result^.stat := statbuf;
  if SearchRec.Attr and faSymLink <> 0 then
  begin
    Ret := readlink(PChar(FName), Buffer, SizeOf(Buffer));
    if Ret > 0 then
    begin
      SetString(Result^.LinkTarget, Buffer, Ret);
      if IsRelativePath(Result^.LinkTarget) then
        Result^.LinkTarget := SearchRec.PathOnly + Result^.LinkTarget;
      Result^.LinkTarget := ExpandFileName(Result^.LinkTarget);
    end;
  end;
{$ENDIF}
  Result^.ImageIndex := iiNoIcon;
end;

procedure DrawTruncatedText(Canvas: TCanvas; R: TRect; const Text: string;
  LeftJustify: Boolean = True; Wrap: Boolean = False);
const
  Ellipsis = '...';
var
  Tmp: string;
  Width: Integer;
  I, L: Integer;
  Flags: Integer;
  TextRect: TRect;
begin
  Flags := Integer(AlignmentFlags_AlignVCenter);
  TextRect := R;
  Width := TextRect.Right - TextRect.Left;

  if LeftJustify then
    Flags := Flags or Integer(AlignmentFlags_AlignLeft)
  else
    Flags := Flags or Integer(AlignmentFlags_AlignRight);

  if Wrap then
    Flags := Flags or Integer(AlignmentFlags_WordBreak);

  if not Wrap and (Canvas.TextWidth(Text) > Width) then
  begin
    I := 1;
    while Canvas.TextWidth(Tmp + Ellipsis) <= Width do
    begin
      if Text[I] in LeadBytes then
      begin
        L := StrCharLength(@Text[I]);
        Tmp := Tmp + Copy(Text, I, L);
        Inc(I, L);
      end
      else
      begin
        Tmp := Tmp + Text[I];
        Inc(I);
      end;
    end;
    L := Length(Tmp);
    I := AnsiLastChar(Tmp) - PChar(Tmp);
    Delete(Tmp, I + 1, L - I);
    Tmp := Tmp + Ellipsis;
  end else
    Tmp := Text;
  Canvas.TextRect(R, R.Left, R.Top, Tmp, Flags);
end;

function IsRelativePath(const Filename: string): Boolean;
begin
  Result := (Length(Filename) > 0) and not (Filename[1] in [PathDelim,
    '~', '$'])
{$IFDEF MSWINDOWS}
    and (Length(Filename) > 1) and (Filename[2] <> DriveDelim);
{$ENDIF}
end;

function ExpandDirectoryName(Directory: string): string;
{$IFDEF LINUX}
var
  wet: wordexp_t;
  PP: PPChar;
  I: Integer;
{$ENDIF}
begin
{$IFDEF LINUX}
  if wordexp(PChar(Directory), wet, WRDE_NOCMD) = 0 then
  try
    PP := wet.we_wordv;
    Directory := '';
    for I := 0 to wet.we_wordc - 1 do
    begin
      Directory := Directory + PP^;
      Inc(PP);
      if I < wet.we_wordc - 1 then
        Directory := Directory + ' ';
    end;
  finally
    wordfree(wet);
  end;
{$ENDIF}
  if not IsDriveRoot(Directory) then
    Directory := ExpandFileName(Directory);
  { work around bug in ExpandFileName where /home/.. = '' instead of '/' }
  if Directory = '' then
  {$IFDEF LINUX}
    Directory := PathDelim;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    { Take whatever directory we are on }
    Directory := ExtractFileDrive(GetCurrentDir);
  {$ENDIF}
  Result := Directory;
end;

function HasSubDirs(const Directory: WideString; IncludeHidden: Boolean = False): Boolean;
var
  Info: TSearchRec;
  DirAttr: Integer;
begin
  Result := True;
  Exit;
  //This doesn't work due to a bug in FindFirst/FindNext which returns normal
  //files even though Attr = faDirectory only!
  Result := False;
  if Directory <> '' then
  begin
    DirAttr := faDirectory;
    if IncludeHidden then
      DirAttr := DirAttr + faHidden;
    if FindFirst(IncludeTrailingPathDelimiter(Directory) + '*', DirAttr, Info) = 0 then
    begin
      repeat { exclude normal files if ftNormal not set }
  //        if (SearchRec.Attr and faDirectory <> 0)
        Result := (Info.Name <> '.') and (Info.Name <> '..');
      until (FindNext(Info) <> 0) or Result;
      FindClose(Info);
    end;
  end;
end;

function GetFileType(Info: PFileInfo): string;
begin
  Result := Info.Desc;
  if Result = '' then
  with Info.SR do
  begin
{$IFDEF MSWINDOWS}
    if Attr and faVolumeID <> 0 then
    begin
      Result := SVolume;
      Exit;
    end;
{$ENDIF}

 {$IFDEF LINUX}
    if Attr and faSymLink <> 0 then
      Result := SLinkTo;
 {$ENDIF}
    if Attr and faDirectory <> 0 then
      Result := Result + SDirectory
    else Result := Result + SFile;
  end;
  Info.Desc := Result;
end;

{$IFDEF LINUX}
function PermissionString(Mode: __mode_t): string;

  function TestBit(Bit: Cardinal): Char;
  begin
    Result := '-';
    if Mode and Bit = Bit then
      case Bit of
        S_IRUSR, S_IRGRP, S_IROTH:
          Result := 'r';
        S_IWUSR, S_IWGRP, S_IWOTH:
          Result := 'w';
        S_IXUSR, S_IXGRP, S_IXOTH:
          Result := 'x';
      end;
  end;

begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '???';
    Exit;
  end
  else begin
    Result := Result + TestBit(S_IRUSR);
    Result := Result + TestBit(S_IWUSR);
    Result := Result + TestBit(S_IXUSR);

    Result := Result + TestBit(S_IRGRP);
    Result := Result + TestBit(S_IWGRP);
    Result := Result + TestBit(S_IXGRP);

    Result := Result + TestBit(S_IROTH);
    Result := Result + TestBit(S_IWOTH);
    Result := Result + TestBit(S_IXOTH);
  end;
end;

function UserName(uid: __uid_t): WideString;
var
  PwdRec: PPasswordRecord;
begin
  Result := '???';
  PwdRec := getpwuid(uid);
  if Assigned(PwdRec) then
    Result := PwdRec^.pw_name;
end;

function GroupName(gid: __gid_t): WideString;
var
  Group: PGroup;
begin
  Result := '???';
  Group := getgrgid(gid);
  if Assigned(Group) then
    Result := Group.gr_name;
end;

{$ENDIF}

function IsDriveRoot(Text: string): Boolean;
begin
  Text := IncludeTrailingPathDelimiter(Text);
{$IFDEF LINUX}
  Result := Text = PathDelim;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := HasDrivePrefix(Text) and (Length(Text) = 3);
{$ENDIF}
end;

// obviously this isn't threadsafe but neither is CLX.
var
  GSortDirection: TSortDirection = sdAscending;
  GSortMode: TSortMode = smName;

function FileSort(Item1, Item2: Pointer): Integer;
var
  FI1, FI2: PFileInfo;
{$IFDEF MSWINDOWS}
  N1, N2: string;
{$ENDIF}
begin
  FI1 := PFileInfo(Item1);
  FI2 := PFileInfo(Item2);
  //directories always precede files.
  Result := (FI2.SR.Attr and faDirectory) - (FI1.SR.Attr and faDirectory);
  if Result = 0 then
  begin
    case GSortMode of
      smName:
{$IFDEF MSWINDOWS}
        begin
          if FI1.SR.Attr and faVolumeID <> 0 then
            N1 := FI1.SR.FindData.cFileName
          else
            N1 := FI1.SR.Name;
          if FI2.SR.Attr and faVolumeID <> 0 then
            N2 := FI2.SR.FindData.cFileName
          else
            N2 := FI2.SR.Name;
          Result := AnsiCompareFileName(N1, N2);
        end;
{$ENDIF}
{$IFDEF LINUX}
          Result := AnsiCompareFileName(FI1.SR.Name, FI2.SR.Name);
{$ENDIF}
      smSize:
        Result := FI2.SR.Size - FI1.SR.Size;
      smType:
        Result := AnsiCompareText(GetFileType(FI1), GetFileType(FI2));
      smDate:
        Result := FI1.SR.Time - FI2.SR.Time;
      smAttributes:
        Result :=
{$IFDEF MSWINDOWS}
          FI2.SR.Attr - FI1.SR.Attr;
{$ENDIF}
{$IFDEF LINUX}
          FI2.stat.st_mode - FI1.stat.st_mode;
      smOwner:
        Result := AnsiCompareStr(UserName(FI1.stat.st_uid),
          UserName(FI2.stat.st_uid));
      smGroup:
        Result := AnsiCompareStr(GroupName(FI1.stat.st_gid),
          GroupName(FI2.stat.st_gid));
{$ENDIF}
    end;
    if GSortDirection = sdDescending then
      Result := - Result;
    if (Result = 0) and (GSortMode <> smName) then
        Result := AnsiCompareFileName(FI1.SR.Name, FI2.SR.Name);
  end;
end;

function SortAscending(Files: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := AnsiCompareFileName(Files[Index1], Files[Index2]);
end;

function SortDescending(Files: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := -AnsiCompareFileName(Files[Index1], Files[Index2]);
end;

type
  TDirectoryNodeClient = class(TInterfacedObject, IDirectoryClient)
  private
    FNode: TDirectoryNode;
  protected
    { IDirectoryClient }
    function FileFound(const SearchRec: TSearchRec): Boolean;
    procedure ListEnd;
    function ListStart: Boolean;
    procedure DirectoryChanged(const NewDir: WideString);
    procedure MaskChange(const NewMask: WideString);
  public
    constructor Create(ANode: TTreeNode);
  end;

{ TDirectoryNodeClient }

constructor TDirectoryNodeClient.Create(ANode: TTreeNode);
begin
  inherited Create;
  FNode := TDirectoryNode(ANode);
end;

procedure TDirectoryNodeClient.DirectoryChanged(const NewDir: WideString);
begin
  FNode.DirectoryChanged(NewDir);
end;

function TDirectoryNodeClient.FileFound(const SearchRec: TSearchRec): Boolean;
begin
  Result := FNode.FileFound(SearchRec);
end;

procedure TDirectoryNodeClient.ListEnd;
begin
  FNode.ListEnd;
end;

function TDirectoryNodeClient.ListStart: Boolean;
begin
  Result := FNode.ListStart;
end;

procedure TDirectoryNodeClient.MaskChange(const NewMask: WideString);
begin
  FNode.MaskChange(NewMask);
end;


{ TDirectoryNode }

constructor TDirectoryNode.Create(AOwner: TCustomViewItems; AParent:
      TCustomViewItem = nil; After: TCustomViewItem = nil);
begin
  inherited Create(AOwner, AParent, After);
  FDirClient := TDirectoryNodeClient.Create(Self);
  FDirectory := TDirectory.Create(FDirClient);
  FDirectory.FIncludeParentDir := False;
  FDirectory.FFileType := TDirectoryTreeView(TTreeNodes(AOwner).Owner).FileType;
end;

destructor TDirectoryNode.Destroy;
begin
  FDirectory.Free;
  inherited Destroy;
end;

procedure TDirectoryNode.DirectoryChanged(const NewDir: WideString);
begin
  { stubbed }
end;

function TDirectoryNode.FileFound(const SearchRec: TSearchRec): Boolean;
begin
  Result := True;
end;

procedure TDirectoryNode.ListEnd;
var
  NewItem: TTreeNode;
  I: Integer;
begin
  HasChildren := FDirectory.Count > 0;
  for I := 0 to FDirectory.Count - 1 do
  begin
    HasChildren := True;
    NewItem := Owner.AddChild(Self, FDirectory.Caption(I));
    NewItem.Data := FDirectory.Files(I);
    NewItem.ImageIndex := 0;
    if (PFileInfo(NewItem.Data).SR.Attr and faDirectory <> 0) then
      NewItem.HasChildren := HasSubDirs(FDirectory.Location + FDirectory.Caption(I),
        ftHidden in FDirectory.FileType);
    QListViewItem_setPixmap(NewItem.Handle, NewItem.Index, TDirectoryTreeView(TreeView).FakePix);
  end;
  Owner.EndUpdate;
end;

function TDirectoryNode.ListStart: Boolean;
begin
  Result := TreeView.HandleAllocated and not (csLoading in TreeView.ComponentState);
  if not Result then
    Exit;
  Owner.BeginUpdate;
end;

procedure TDirectoryNode.MaskChange(const NewMask: WideString);
begin
  { stubbed }
end;

procedure TDirectoryNode.Populate;
begin
  FDirectory.ListFiles;
end;

procedure TDirectoryNode.UpdateImages;
begin
  if not Assigned(TDirectoryTreeView(TreeView).Images) then
    QListViewItem_setPixmap(Handle, Index, TDirectoryTreeView(TreeView).FakePix)
  else
    inherited UpdateImages;
end;

{ TDirectoryTreeView }

constructor TDirectoryTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Items.SetNodeClass(TDirectoryNode);
  ReadOnly := True;
  FFileType := [ftDirectory, ftSystem];
  FIconSize := isSmall;
  FakePix := QPixmap_create;
  QPixmap_resize(FakePix, IconPixels(FIconSize), IconPixels(FIconSize));
end;

destructor TDirectoryTreeView.Destroy;
begin
  QPixmap_destroy(FakePix);
  if (Items.Count > 0) and (Items[0].Data <> nil) then
    Dispose(PFileInfo(Items[0].Data));
  inherited Destroy;
end;

procedure TDirectoryTreeView.DoGetImageIndex(item: TCustomViewItem);
begin
  if not Assigned(Images) then
    with TTreeNode(Item) do
      ImageIndex := FIconProvider.DoGetImageIndex(PFileInfo(Data))
  else
    inherited DoGetImageIndex(Item);
end;

function TDirectoryTreeView.IsOwnerDrawn: Boolean;
begin
  Result := False;
end;

function TDirectoryTreeView.IsCustomDrawn: Boolean;
begin
  Result := True;
end;

function TDirectoryTreeView.DoCustomDrawViewItem(Item: TCustomViewItem;
  Canvas: TCanvas; const Rect: TRect; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
var
  R: TRect;
  IL: TCustomImageList;
  Node: TDirectoryNode;
begin
  Result := False;
  if Stage = cdPostPaint then
    Result := inherited DoCustomDrawViewItem(Item, Canvas, Rect, State, cdPrePaint);

  if Result then
  begin

    R := Rect;
    Canvas.FillRect(R);
    Node := TDirectoryNode(Item);
    with Node do
    begin
      if Assigned(Images) then
        IL := Images
      else
        IL := FIconProvider;

      Inc(R.Top, (R.Bottom - R.Top - Canvas.TextHeight('Pq')) div 2);
      IL.Draw(Canvas, R.Left, R.Top, ImageIndex);
  {$IFDEF LINUX}
      if (PFileInfo(Data).SR.Attr and faSymLink <> 0)
      and (IL = FIconProvider) then
        FIconProvider.DrawLinkOverlay(Canvas, R.Left, R.Top, PFileInfo(Data));
  {$ENDIF}
      Inc(R.Left, IL.Width + 2);
      Inc(R.Right);
      DrawTruncatedText(Canvas, R, Text);
    end;
  end;

  if Stage = cdPostPaint then
  begin
    inherited DoCustomDrawViewItem(Item, Canvas, Rect, State, Stage);
    Result := False;
  end;
end;

procedure TDirectoryTreeView.AddDirectories(Node: TTreeNode);
begin
  with TDirectoryNode(Node), PFileInfo(Node.Data)^ do
  begin
{$IFDEF LINUX}
    FDirectory.Location := IncludeTrailingPathDelimiter(SR.PathOnly) + SR.Name;
{$ENDIF}
{$IFDEF MSWINDOWS}
    FDirectory.Location := GetAbsolutePath(Node);
{$ENDIF}
  end;
end;

procedure TDirectoryTreeView.Change(Node: TTreeNode);
begin
  if not FChanging and Assigned(Node) and not (csLoading in ComponentState) then
  begin
    FChanging := True;
    try
      if (Node <> nil) and (Node.Data <> nil)
      and (PFileInfo(Node.Data)^.SR.Attr and faDirectory = faDirectory) then
        FDir := GetAbsolutePath(Node);
      inherited Change(Node);
    finally
      FChanging := False;
    end;
  end;
end;

procedure TDirectoryTreeView.SetRootDir(const Value: WideString);
var
  RootNode: TTreeNode;
  SR: TSearchRec;
  Tmp: string;
  DirAttr: Integer;
  FreeSR: Boolean;
  IsRootDir: Boolean;
{$IFDEF MSWINDOWS}
  DriveBits: set of 0..25;
  DriveNum: Integer;
{$ENDIF}
begin
{$IFDEF LINUX}
  if Value <> '' then
{$ENDIF}
  begin
    Tmp := Value;
    FreeSR := False;
    if not (csLoading in ComponentState) then
    begin
      { Special case of root dir on Linux, and a base file system on windows }
      IsRootDir := IsDriveRoot(Tmp);
      if not IsRootDir and (Tmp <> '') then
        Tmp := ExcludeTrailingPathDelimiter(ExpandDirectoryName(Tmp));
      DirAttr := faDirectory;
      if ftHidden in FFileType then
        DirAttr := DirAttr or faHidden;

{$IFDEF MSWINDOWS}
      if Tmp <> '' then
        if IsRootDir then
          CreateDriveInfo(Tmp, SR)
        else
{$ENDIF}
      if FindFirst(Tmp, DirAttr, SR) <> 0 then
        raise ESetDirectoryError.CreateFmt(SCannotReadDirectory, [Value])
      else
        FreeSR := True;

      Items.BeginUpdate;
      FChanging := True;
      try
        Items.Clear;
{$IFDEF MSWINDOWS}
        if Tmp <> '' then
        begin
          if IsRootDir then
            RootNode := Items.Add(nil, SR.Name)
          else
{$ENDIF}
            RootNode := Items.Add(nil, Tmp);
          RootNode.Data := AllocFileInfo(SR);
{$IFDEF MSWINDOWS}
          if not IsRootDir then
{$ENDIF}
          RootNode.ImageIndex := 0;

          AddDirectories(RootNode);
          Selected := RootNode;
{$IFDEF MSWINDOWS}
       end
       else begin
         Integer(DriveBits) := GetLogicalDrives;
         for DriveNum := 0 to 25 do
         begin
           if not (DriveNum in DriveBits) then Continue;
           CreateDriveInfo(Char(DriveNum + Ord('A')) + DriveDelim + PathDelim, SR);
           RootNode := Items.Add(nil, SR.Name);
           RootNode.Data := AllocFileInfo(SR);
           RootNode.HasChildren := True;
         end;
       end;
{$ENDIF}
      finally
        FChanging := False;
        Items.EndUpdate;
        if FreeSR then
          FindClose(SR);
      end;
    end;
    FRootDir := Tmp;
  end;
end;

function TDirectoryTreeView.GetAbsolutePath(Node: TTreeNode): string;
var
  Dir: WideString;
begin
  Result := '';
  if Assigned(Node) and Assigned(Node.Data) then
  with PFileInfo(Node.Data)^ do
{$IFDEF LINUX}
    if SR.Name = PathDelim then
      Result := SR.Name
    else
      Result := IncludeTrailingPathDelimiter(SR.PathOnly) + SR.Name;
{$ENDIF}
{$IFDEF MSWINDOWS}
  while Node <> nil do
    with PFileInfo(Node.Data)^ do
    begin
      if SR.Attr and faVolumeID <> 0 then
        Dir := SR.FindData.cFileName
      else
        Dir := Node.Text;
      Result := IncludeTrailingPathDelimiter(Dir) + Result;
      Node := Node.Parent;
    end;
{$ENDIF}
end;

procedure TDirectoryTreeView.SetDir(const Value: WideString);
var
  StartDir,
  Tmp: string;
  Node,
  ParentNode: TTreeNode;
  I: Integer;
  IsSubDir: Boolean;
  SubDir: PChar;
begin
  FChanging := True;
  IsSubDir := False;
  try
    if csLoading in ComponentState then
      FDir := Value
    else
    begin
      if Value <> '' then
      begin
        StartDir := Value;
        if Items.Count > 0 then
        begin
          Node := Items[0];
          while Node <> nil do
          begin
{$IFDEF MSWINDOWS}
            if PFileInfo(Node.Data).SR.Attr and faVolumeID <> 0 then
              Tmp := PFileInfo(Node.Data).SR.FindData.cFileName
            else
{$ENDIF}
              Tmp := FRootDir;
            IsSubDir := SameFileName(Tmp, Copy(StartDir, 1, Length(Tmp)));
            if IsSubDir then
            begin
              System.Delete(StartDir, 1, Length(Tmp));
              Break;
            end;
            Node := Node.GetNextSibling;
          end;
          if not IsSubDir then
          begin
{$IFDEF MSWINDOWS}
            if FRootDir = '' then
              Tmp := SAnyKnownDrive;
{$ENDIF}
            raise ESetDirectoryError.CreateFmt(SNotASubDir, [Value, Tmp]);
          end;

          for I := 1 to Length(StartDir) do
            if (StartDir[I] = PathDelim) then
              StartDir[I] := #0;

          StartDir := StartDir + #0;
          SubDir := PChar(StartDir);
          if (SubDir[0] = #0) and (Length(StartDir) > 0) then
            SubDir := @SubDir[1];
          ParentNode := Node;
          while SubDir[0] <> #0 do
          begin
            Node := ParentNode.GetFirstChild;
            if Node = nil then
            begin
              AddDirectories(ParentNode);
              Node := ParentNode.GetFirstChild;
            end;
            while (Node <> nil) and (AnsiCompareFileName(Node.Text, SubDir) <> 0) do
              Node := Node.GetNextSibling;
            if Node = nil then
              Break
            else begin
              ParentNode.Expand(False);
              ParentNode := Node;
            end;
            SubDir := SubDir + StrLen(SubDir) + 1;
          end;
          Selected := ParentNode;
          Selected.MakeVisible;
        end;
      end
      else
        Selected := nil;
    end;
  finally
    FChanging := False;
  end;
end;

function TDirectoryTreeView.CanExpand(Node: TTreeNode): Boolean;
begin
  Result := inherited CanExpand(Node);
  if Result and (Node.Count = 0) then
    AddDirectories(Node);
end;

function TDirectoryTreeView.GetDir: WideString;
begin
  if Selected <> nil then
    Result := GetAbsolutePath(Selected)
  else
    Result := '';
end;

procedure TDirectoryTreeView.Loaded;
begin
  inherited Loaded;
  SetRootDir(FRootDir);
  SetDir(FDir);
  SetFileType(FFileType);
end;

procedure TDirectoryTreeView.SetFileType(const Value: TFileType);
var
  CurDir: WideString;
begin
  FFileType := Value;
  if not (csLoading in ComponentState) then
  begin
    CurDir := GetDir;
    SetRootDir(FRootDir);
    SetDir(CurDir);
  end;
end;

procedure TDirectoryTreeView.ImageListChanged;
begin
  if Images <> nil then
    QPixmap_resize(FakePix, Images.Width, Images.Height);
  inherited ImageListChanged;
end;

procedure TDirectoryTreeView.InitWidget;
begin
  inherited InitWidget;
  FIconProvider := IconProvider16;
{$IFDEF LINUX}
  RootDirectory := '$HOME';
{$ELSE}
  RootDirectory := FRootDir; 
{$ENDIF}
end;

type
  TFileListItemEditor = class(TViewItemEditor)
    procedure EditFinished(Accepted: Boolean); override;
  end;

  TViewItemCracker = class(TCustomViewItem);

function TDirectoryTreeView.DoCustomHint(var HintInfo: THintInfo): Boolean;
var
  Node: TTreeNode;
  Pos: TPoint;
  TextRect, BRect: TRect;
begin
  Pos := ScreenToClient(Mouse.CursorPos);
  Node := GetNodeAt(Pos.X, Pos.Y);
  Result := Node <> nil;
  if Result then
  begin
    TextRect := Node.TextRect;
    BRect := TextRect;
    Canvas.TextExtent(Node.Text, BRect,
        Integer(AlignmentFlags_AlignLeft) or Integer(AlignmentFlags_SingleLine));
    if Assigned(FIconProvider) then
      OffsetRect(BRect, FIconProvider.Width, 0);
    Result := (BRect.Right > ClientWidth) or (BRect.Left < 0);
    if Result then
      HintInfo.HintStr := Node.Text;
  end;
end;

{ TFileListItemEditor }

procedure TFileListItemEditor.EditFinished(Accepted: Boolean);
begin
  Accepted := Accepted and (Text <> '');
  inherited EditFinished(Accepted);
  if TFileListView(ViewControl).FCreatingDir 
  and not TFileListView(ViewControl).FCreatedDir then
  begin
    if Accepted then
      Error(Format(SCannotCreateDirName, [TViewItemCracker(Item).Caption]));
    Item.Free;
  end;
  TFileListView(ViewControl).FCreatingDir := False;
  ViewControl.Repaint;
end;

{ TFileListView }

constructor TFileListView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ReadOnly := True;
  FDirectory := TDirectory.Create(Self);
  FIconProvider := IconProvider16;
{$IFDEF LINUX}
  FDirectory.Location := GetCurrentDir;
{$ENDIF}
{$IFDEF MSWINDOWS}
  FDrivesListed := False;
{$ENDIF}
end;

procedure TFileListView.DoEditing(AItem: TCustomViewItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := ((TListItem(AItem).Data <> nil)
    and (PFileInfo(TListItem(AItem).Data).SR.Name <> UpDir)) or FCreatingDir;
  inherited DoEditing(AItem, AllowEdit);
end;

procedure TFileListView.DoGetImageIndex(item: TCustomViewItem);
begin
  if not Assigned(Images) then
    with TListItem(Item) do
      ImageIndex := FIconProvider.DoGetImageIndex(TListItem(Item).Data)
  else
    inherited DoGetImageIndex(Item);
end;

procedure TFileListView.ListEnd;
var
  I: Integer;
  MaxW, ThisW, ImageW: Integer;
  NewItem: TListItem;
begin
  try
 {$IFDEF MSWINDOWS}
    FDrivesListed := Directory.Location = '';
 {$ENDIF}
    MaxW := 0;
    for I := 0 to FDirectory.Count - 1 do
    begin
      NewItem := Items.Add;
      NewItem.Data := FDirectory.Files(I);
      NewItem.Caption := FDirectory.Caption(I);
      NewItem.ImageIndex := 0;
      if ViewStyle = vsList then
      begin
        ThisW := Canvas.TextWidth(NewItem.Caption);
        if ThisW > MaxW then
          MaxW := ThisW;
      end;
    end;
    if ViewStyle = vsList then
    begin
      {TODO: investigate listview problem where vsList still pays
             attention to first column's width}
      if not Assigned(Images) then
        ImageW := FIconProvider.Width
      else
        ImageW := Images.Width;
      QListView_setColumnWidth(Handle,
        QHeader_mapToIndex(QListView_header(Handle), 0),
        MaxW + ImageW + 3);
    end;
{$IFDEF MSWINDOWS}
    if ViewStyle = vsReport then
      for I := 0 to Columns.Count - 1 do
        if Columns[I].Tag = Integer(flcDate) then
          if FDrivesListed then
            Columns[I].Caption := SFreeSpace
          else
            Columns[I].Caption := SDate;
{$ENDIF}
  finally  
    Screen.Cursor := FSaveCursor;
    Items.EndUpdate;
  end;
end;

function TFileListView.ListStart: Boolean;
begin
{$IFDEF MSWINDOWS}
  FDrivesListed := Directory.Location = '';
{$ENDIF}
  Result := HandleAllocated and not (csLoading in ComponentState);
  if Result then
  begin
    Items.BeginUpdate;
    Application.CancelHint;
    FSaveCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    Items.Clear;
  end;
end;

procedure TFileListView.ImageChange;
begin
  FDirectory.ListFiles(False);
  UpdateControl;
end;

const
  FLVColTitles: array[TFileListColumn] of string = (
    SName, SSize, SType, SDate, SAttributes {$IFDEF LINUX}, SOwner, SGroup {$ENDIF});

procedure TFileListView.InitWidget;
var
  CType: TFileListColumn;
  Column: TListColumn;
begin
  inherited InitWidget;
  FIconProvider := IconProvider16;
  if (Columns.Count = 0) then
  begin
    for CType := Low(TFileListColumn) to High(TFileListColumn) do
    begin
      Column := Columns.Add;
      Column.Tag := Ord(CType);
      Column.Caption := FLVColTitles[CType];
      if CType = flcSize then
        Column.Alignment := taRightJustify;
      case CType of
        flcName: Column.Width := 150;
        flcSize: Column.Width := Canvas.TextWidth('0000000');
        flcType: Column.Width := Canvas.TextWidth(SDirectory);
        flcDate: Column.Width := Canvas.TextWidth(DateTimeToStr(Now));
        flcAttributes: Column.Width := Canvas.TextWidth(SAttributes);
{$IFDEF LINUX}
        flcOwner: Column.Width := Canvas.TextWidth(SOwner);
        flcGroup: Column.Width := Canvas.TextWidth(SGroup);
{$ENDIF}
      end;
      Column.Width := Column.Width + Canvas.TextWidth('A');
    end;
  end;
  Sorted := False;
  Refresh; 
end;

procedure TFileListView.Loaded;
begin
  inherited Loaded;
  Refresh;
end;

function TFileListView.DoCustomDrawViewItem(Item: TCustomViewItem;
  Canvas: TCanvas; const Rect: TRect; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
var
  R: TRect;
  IL: TCustomImageList;
  ListItem: TListItem;
begin
  Result := False;
  if Stage = cdPostPaint then
    Result := inherited DoCustomDrawViewItem(Item, Canvas, Rect, State, cdPrePaint);

  if Result then
  begin
    R := Rect;
    Canvas.FillRect(R);
    ListItem := TListItem(Item);
    with ListItem do
    begin
      if Assigned(Images) then
        IL := Images
      else
        IL := FIconProvider;
      Inc(R.Top, (R.Bottom - R.Top - IL.Height) div 2);
      IL.Draw(Canvas, R.Left, R.Top, ImageIndex);
  {$IFDEF LINUX}
      if (Data <> nil) and (PFileInfo(Data).SR.Attr and faSymLink <> 0)
      and (IL = FIconProvider) then
        FIconProvider.DrawLinkOverlay(Canvas, R.Left, R.Top, PFileInfo(Data));
  {$ENDIF}
      Inc(R.Left, IL.Width + 2);
      if (Data <> nil) and (EditingItem <> Item) then
        DrawTruncatedText(Canvas, R, PFileInfo(Data).SR.Name)
      else
        Result := True;
    end;
  end;

  if Stage = cdPostPaint then
  begin
    inherited DoCustomDrawViewItem(Item, Canvas, Rect, State, Stage);
    Result := False;
  end;
end;

function TFileListView.DoCustomDrawViewSubItem(Item: TCustomViewItem;
  SubItem: Integer; Canvas: TCanvas; const Rect: TRect;
  State: TCustomDrawState; Stage: TCustomDrawStage): Boolean;
var
  R: TRect;
  Txt: string;
  FileInfo: PFileInfo;
  Col: TFileListColumn;
begin
  Result := False;
  if Stage = cdPostPaint then
    Result := inherited DoCustomDrawViewSubItem(Item, SubItem, Canvas, Rect,
      State, cdPrePaint);

  if Result then
  begin
    R := Rect;
    if not RowSelect then
    begin
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := clWindowText;
    end;
    InflateRect(R, -3, 0);
    if TListItem(Item).Data = nil then Exit;
    FileInfo := PFileInfo(TListItem(Item).Data);
    Col := TFileListColumn(SubItem);
    if FileInfo <> nil then
    begin
      case Col of
        flcSize:
{$IFDEF MSWINDOWS}
          if FDrivesListed then
            Txt := Format(SMegs, [FileInfo.SR.Time])
          else
{$ENDIF}
            Txt := IntToStr(FileInfo.SR.Size);
        flcDate:
{$IFDEF MSWINDOWS}
          if FDrivesListed then
            Txt := Format(SMegs, [FileInfo.SR.Size])
          else
{$ENDIF}
            Txt := DateTimeToStr(FileDateToDateTime(FileInfo.SR.Time));
        flcType:
          Txt := GetFileTypeProc(FileInfo);
        flcAttributes:
{$IFDEF MSWINDOWS}
          Txt := AttributeString(FileInfo.SR.Attr);
{$ENDIF}
{$IFDEF LINUX}
          Txt := PermissionString(FileInfo.stat.st_mode);
        flcOwner:
          Txt := UserName(FileInfo.stat.st_uid);
        flcGroup:
          Txt := GroupName(FileInfo.stat.st_gid);
{$ENDIF}
      else
        Txt := '???'; // do not localize
      end;
    end
    else
      Txt := '';
    Canvas.FillRect(Rect);
    DrawTruncatedText(Canvas, R, Txt, Col <> flcSize);
  end;
  if Stage = cdPostPaint then
  begin
    inherited DoCustomDrawViewSubItem(Item, SubItem, Canvas, Rect, State, Stage);
    Result := False;
  end;
end;

function TFileListView.IsOwnerDrawn: Boolean;
begin
  Result := False;
end;

function TFileListView.IsCustomDrawn: Boolean;
begin
  Result := True;
end;

procedure TFileListView.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if not IsEditing then
    case Key of
      #8: GoUp;
      #13: GoDown;
    end;
end;

procedure TFileListView.GoUp;
var
  NewDir: WideString;
begin
{$IFDEF MSWINDOWS}
  if Directory.Location = '' then
    Exit;
  if IsDriveRoot(Directory.Location) then
    NewDir := ''
  else
{$ENDIF}
  NewDir := ExpandDirectoryName(IncludeTrailingPathDelimiter(Directory.Location)
    + '..');
  if NewDir <> Directory.Location then
    Directory.Location := NewDir;
end;

procedure TFileListView.DblClick;
begin
  inherited DblClick;
  if (Selected <> nil) and (FDirectory.Files(Selected.Index).SR.Attr and faDirectory <> 0)
  and (Selected.Caption = '..') then
    GoUp
  else
    GoDown;
end;

procedure TFileListView.GoDown;
begin
  if (Selected <> nil) then
  begin
    if (PFileInfo(Selected.Data)^.SR.Attr and faDirectory <> 0) then
{$IFDEF LINUX}
      Directory.Location := FDirectory.LinkName(Selected.Index);
{$ENDIF}
{$IFDEF MSWINDOWS}
      Directory.Location := Directory.Location + PathDelim + Selected.Caption
    else if PFileInfo(Selected.Data)^.SR.Attr and faVolumeID <> 0 then
      Directory.Location := PFileInfo(Selected.Data)^.SR.FindData.cFileName;
{$ENDIF};
  end;
end;

function TFileListView.GetSelections: TFileInfos;
var
  I: Integer;
begin
  { Do NOT free the returned pointers - they're live. }
  for I := 0 to Items.Count - 1 do
    if Items[I].Selected then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result)-1] := FDirectory.Files(I);
    end;
end;

destructor TFileListView.Destroy;
begin
  FDirectory.Free;
  inherited Destroy;
end;

function TFileListView.NeedKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;

  function IsNavKey: Boolean;
  begin
    Result := (Key = Key_Left) or (Key = Key_Right) or
      (Key = Key_Down) or (Key = Key_Up) or
      (Key = Key_Home) or (Key = Key_End) or
      (Key = Key_PageUp) or (Key = Key_PageDown);
  end;

begin
  Result := inherited NeedKey(Key, Shift, KeyText);
  if not Result then
    Result := (isNavKey and (ssShift in Shift)) or (((Key = Key_Enter) or
      (Key = Key_Return)) and ((Selected <> nil)
      and (PFileInfo(Selected.Data).SR.Attr and faDirectory <> 0)));
end;

//TODO: issue - TListItems.FindItem is protected.

procedure TFileListView.ColumnClicked(Column: TListColumn);
begin
  if FDirectory.SortMode = TSortMode(Column.Tag + 1) then
  begin
    if FDirectory.SortDirection = sdAscending then
      FDirectory.SortDirection := sdDescending
    else
      FDirectory.SortDirection := sdAscending;
  end
  else
    FDirectory.SortMode := TSortMode(Column.Tag + 1);
  inherited ColumnClicked(Column);
end;

procedure TFileListView.CreateDirectory(const DefaultName: WideString);
begin
  if ReadOnly then Exit;
  FCreatingDir := True;
  FCreatedDir := False;
  SetFocus;
  with Items.Add do
  begin
    Caption := FDirectory.UniqueName(DefaultName);
    Selected := True;
    EditText;
  end;
end;

procedure TFileListView.DoEdited(AItem: TCustomViewItem;
  var S: WideString);
var
  NewDir: PFileInfo;
begin
  if FCreatingDir then
  begin
    NewDir := FDirectory.CreateDirectory(S);
    FCreatedDir := NewDir <> nil;
    if FCreatedDir then
      TListItem(AItem).Data := NewDir;
  end
  else if RenameFile(TListItem(AItem), S) < 0 then
    S := PFileInfo(TListItem(AItem).Data).SR.Name;
  inherited DoEdited(AItem, S);
end;

function TFileListView.DeleteFile(const Filename: WideString): Integer;
begin
  Result := FDirectory.Delete(Filename);
  if Result = RESULT_OK then
    Refresh;
end;

function TFileListView.RenameFile(Item: TListItem; const NewName: WideString): Integer;
begin
  Result := 0;
  if (NewName = '') or (AnsiCompareFileName(Item.Caption, NewName) = 0)
   then Exit;
  Result := FDirectory.Rename(Item.Data, NewName);
  case Result of
    RESULT_ACCESS_DENIED:
      Error(Format(SAccessDeniedTo, [Item.Caption]));
    RESULT_FILE_NOT_FOUND:
      Error(Format(SFileNameNotFound, [Item.Caption]));
    RESULT_ALREADY_EXISTS:
      Error(SAlreadyExists);
  else
    if (PFileInfo(Result).SR.Attr and faHidden <> 0)
    and not (ftHidden in FDirectory.FileType) then
      Item.Delete
    else begin
      Item.Data := Pointer(Result);
      Item.Caption := NewName;
      InvalidateRect(Item.DisplayRect, True);
    end;
  end;
end;

procedure TFileListView.PositionEditor(var NewLeft, NewTop: Integer);
begin
  if Assigned(Images) then
    NewLeft := NewLeft + Images.Width
  else
    NewLeft := NewLeft + IconPixels(isSmall);
end;

procedure TFileListView.DirectoryChanged(const NewDir: WideString);
begin
  if Items.Count > 0 then
    TopItem := Items[0];
  if Assigned(FOnDirChange) then
    FOnDirChange(Self, NewDir);
end;

function TFileListView.FileFound(const SearchRec: TSearchRec): Boolean;
begin
  Result := True;
  if Assigned(FOnFileFound) then
    FOnFileFound(Self, SearchRec, Result);
end;

procedure TFileListView.MaskChange(const NewMask: WideString);
begin
  if Assigned(FOnMaskChange) then
    FOnMaskChange(Self, NewMask);
end;

procedure TFileListView.SetDirectory(const Value: TDirectory);
begin
  FDirectory.Assign(Value);
end;

function TFileListView.CreateEditor: TItemEditor;
begin
  Result := TFileListItemEditor.Create(Self);
end;

procedure TFileListView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = Key_F5 then
    Refresh;
end;

procedure TFileListView.Refresh;
begin
  FDirectory.ListFiles(True);
end;

function TFileListView.DoCustomHint(var HintInfo: THintInfo): Boolean;
var
  Info: PFileInfo;
  TextRect: TRect;
  BRect: TRect;
  IL: TCustomImageList;
  Item: TListItem;
  Pos: TPoint;
begin
  Pos := ScreenToClient(Mouse.CursorPos);
  Item := GetItemAt(Pos.X, Pos.Y);
  Result := Item <> nil;
  if Result then
  begin
    Info := PFileInfo(Item.Data);
    if Info <> nil then
    begin
      TextRect := Item.DisplayRect;
      if Assigned(Images) then
        IL := Images
      else
        IL := FIconProvider;
      Dec(TextRect.Right, IL.Width);
      BRect := TextRect;
      Canvas.TextExtent(Item.Caption, BRect,
          Integer(AlignmentFlags_AlignHCenter) or Integer(AlignmentFlags_WordBreak));
      if ((BRect.Right - BRect.Left) > (TextRect.Right - TextRect.Left)) or
        ((BRect.Bottom - BRect.Top) > (TextRect.Bottom - TextRect.Top)) then
        begin
{$IFDEF MSWINDOWS}
          if FDrivesListed then
            HintInfo.HintStr := Format('%s'#10'%s: %s'#10'%s: %s'#10'%s: %s', [Item.Caption,
              SType, GetFileTypeProc(Info), SFreeSpace, Format(SMegs, [Info.SR.Time]),
              SSize, Format(SMegs, [Info.SR.Size])])
          else
{$ENDIF}
            HintInfo.HintStr := Format('%s'#10'%s: %s'#10'%s: %s'#10'%s: %d', [Item.Caption,
              SType, GetFileTypeProc(Info), SDate, DateTimeToStr(FileDateToDateTime(Info.SR.Time)),
              SSize, Info.SR.Size])
        end
      else begin
{$IFDEF MSWINDOWS}
        if FDrivesListed then
          HintInfo.HintStr := Format('%s: %s'#10'%s: %s'#10'%s: %s', [SType,
            GetFileTypeProc(Info), SFreeSpace, Format(SMegs, [Info.SR.Time]),
            SSize, Format(SMegs, [Info.SR.Size])])
        else
{$ENDIF}
          HintInfo.HintStr := Format('%s: %s'#10'%s: %s'#10'%s: %d', [SType,
            GetFileTypeProc(Info), SDate, DateTimeToStr(FileDateToDateTime(Info.SR.Time)),
            SSize, Info.SR.Size]);
      end;
      HintInfo.ReshowTimeout := MaxInt;
    end;
  end;
end;

procedure TFileListView.ImageListChanged;
begin
  Items.BeginUpdate;
  try
    ImageChange;
  finally
    Items.EndUpdate;
  end;
end;

{ TFileIconProvider }

constructor TFileIconProvider.Create(Size: TIconSize);
begin
  FIconSize := Size;
  FIndexes := TStringHash.Create(512);
  CreateSize(IconPixels(FIconSize), IconPixels(FIconSize));
  Init;
end;

destructor TFileIconProvider.Destroy;
begin
  FIndexes.Free;
  inherited;
end;

procedure TFileIconProvider.Clear;
begin
  inherited Clear;
  FIndexes.Clear;
  Init;
end;

function TFileIconProvider.DoGetImageIndex(Info: PFileInfo;
  const CurDir: string = ''): Integer;
begin
  if Info <> nil then
  begin
    with Info.SR do
    begin
      if (Attr and faDirectory) <> 0 then
      begin
        if (Attr and faHidden) <> 0 then
          Result := iiHiddenClosedFolder
        else
          Result := iiClosedFolder;
      end
      else begin
        if (Attr and faHidden) <> 0 then
          Result := iiHiddenDefaultFile
        else
          Result := iiDefaultFile;
      end;
    end
  end
  else
    Result := iiClosedFolder;
end;

procedure TFileIconProvider.DrawLinkOverlay(Canvas: TCanvas; X, Y: Integer;
  Info: PFileInfo);
begin
  Draw(Canvas, X, Y, iiLinkOverlay, itImage);
end;

procedure TFileIconProvider.Init;
var
  B: TBitmap;
  I: Integer;
begin
  B := TBitmap.Create;
  try
    for I := iiClosedFolder to iiHiddenDefaultFile do
    begin
      B.LoadFromResourceName(hInstance, ResourceNames[I]+IntToStr(IconPixels(FIconSize)));
      AddMasked(B, clDefault);
    end;
    B.LoadFromResourceName(hInstance, ResourceNames[iiLinkOverlay]+IntToStr(IconPixels(FIconSize)));
    AddMasked(B, clBlack);
  finally
    B.Free;
  end;
end;

{$IFDEF MSWINDOWS}
// -1 => no icon available
// -2 => not tried yet
// 0 and above = index of image in imagelist

constructor TWindowsFileIconProvider.Create(Size: TIconSize);
begin
  inherited Create(Size);
  Reg := TRegistry.Create;
end;

destructor TWindowsFileIconProvider.Destroy;
begin
  Reg.Free;
  inherited Destroy;
end;

function TWindowsFileIconProvider.AddIcon(IconFile: string; Index: Integer): Integer;
var
  Large, Small: HICON;
  nIcons: Integer;
  B: TBitmap;
begin
  Result := iiUnknownIcon;
  nIcons := ExtractIconEx(PChar(IconFile), Index, Large, Small, 1);
  if nIcons > 0 then
  begin
    B := TBitmap.Create;
    try
      B.Width := Width;
      B.Height := Height;
      B.Canvas.Start;
      case FIconSize of
        isSmall:
          DrawIconEx(QPainter_handle(B.Canvas.Handle), 0, 0, Small,
            B.Width, B.Height, 0, 0, DI_NORMAL);
        isLarge, isVeryLarge:
          DrawIconEx(QPainter_handle(B.Canvas.Handle), 0, 0, Large,
            B.Width, B.Height, 0, 0, DI_NORMAL);
      end;
      B.Canvas.Stop;
      Result := AddMasked(B, clDefault);
    finally
      B.Free;
    end;
  end;
end;

function TWindowsFileIconProvider.DoGetImageIndex(Info: PFileInfo;
  const CurDir: string = ''): Integer;
var
  Key: string;
  Dir: string;
  IconFile: string;
  IconIndex: Integer;
  shinf: SHFILEINFO;
begin
  Result := iiUnknownIcon;
  if Info = nil then Exit;
  if Info.ImageIndex = iiNoIcon then
  begin
    if Info.SR.Attr and faVolumeID <> 0 then
    begin
      Key := Info.SR.FindData.cFileName;
      Info.ImageIndex := FIndexes.ValueOf(Key);
      if Info.ImageIndex > -1 then
        Exit
      else
        if (Info.ImageIndex = iiUnknownIcon)
        and (SHGetFileInfo(PChar(Key), 0, shinf, SizeOf(shinf), SHGFI_ICONLOCATION) <> 0) then
        begin
          Info.ImageIndex := AddIcon(shinf.szDisplayName, shinf.iIcon);
          FIndexes.Add(Key, Info.ImageIndex);
          Exit;
        end;
    end;
    if Info.SR.Attr and faDirectory <> 0 then
    begin
      Info.ImageIndex := iiClosedFolder;
    end
    else
    begin
      Key := ExtractFileExt(Info.SR.Name);
      if (Key = '') or (AnsiLowerCase(Key) = '.exe') then
        Key := IncludeTrailingPathDelimiter(CurDir) + Info.SR.Name;
      Info.ImageIndex := FIndexes.ValueOf(Key);
      if Info.ImageIndex = iiUnknownIcon then
      begin
        if GetIconDataFromRegistry(Key, IconFile, IconIndex) then
        begin
          Info.ImageIndex := AddIcon(IconFile, IconIndex);
          FIndexes.Add(Key, Info.ImageIndex);
        end
        else begin
          Info.ImageIndex := AddIcon(Key, 0);
          if Info.ImageIndex >= 0 then
            FIndexes.Add(Key, Info.ImageIndex)
          else
            Info.ImageIndex := inherited DoGetImageIndex(Info, Dir);
        end;
      end;
    end;
  end;
  Result := Info.ImageIndex;
end;

procedure TWindowsFileIconProvider.Init;
const
  ShellIndexMap: array[iiClosedFolder..iiHiddenDefaultFile] of Integer = (
    3, 4, 3, 4, 0, 0);
var
  I: Integer;
begin
  for I := iiClosedFolder to iiHiddenDefaultFile do
    AddIcon('shell32.dll', ShellIndexMap[I]);
end;

function TWindowsFileIconProvider.GetIconDataFromRegistry(const Key: string;
  var IconFile: string; var Index: Integer): Boolean;
var
  S: string;
  P: Integer;
begin
  Reg.RootKey := HKEY_CLASSES_ROOT;
  Result := Reg.OpenKeyReadOnly(Key);
  if Result then
  try
    S := Reg.ReadString('');
    Reg.CloseKey;
    Reg.RootKey := HKEY_CLASSES_ROOT;
    Result := Reg.OpenKeyReadOnly(s + '\DefaultIcon');
    if Result then
    begin
      S := Reg.ReadString('');
      P := Pos(',', S);
      if P > 0 then
      begin
        IconFile := Copy(S, 1, P-1);
        Index := StrToInt(Copy(S, P+1, Length(S)));
      end
      else
        Result := False;
    end;
  finally
    Reg.CloseKey;
  end;
end;

{$ENDIF}

{ TFilterComboBox }

constructor TFilterComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
  FFilter := SDefaultFilter;
  MaskList := TStringList.Create;
  FEditable := False;
end;

destructor TFilterComboBox.Destroy;
begin
  MaskList.Free;
  inherited Destroy;
end;

function TFilterComboBox.IsFilterStored: Boolean;
begin
  Result := SDefaultFilter <> FFilter;
end;

procedure TFilterComboBox.SetFilter(const NewFilter: string);
begin
  if AnsiCompareFileName(NewFilter, FFilter) <> 0 then
  begin
    FFilter := NewFilter;
    if HandleAllocated then BuildList;
    Change;
  end;
end;

procedure TFilterComboBox.ListMasks(List: TStrings);
var
  SaveDelim: Char;
begin
  List.Clear;
  SaveDelim := List.Delimiter;
  try
    List.Delimiter := ';';
    List.DelimitedText := MaskList.Text;
  finally
    List.Delimiter := SaveDelim;
  end;
end;

function TFilterComboBox.GetMask: WideString;
begin
  if ItemIndex < 0 then
    ItemIndex := Items.Count - 1;

  if (ItemIndex >= 0) and (MaskList.Count > 0) then
  begin
    Result := MaskList[ItemIndex];
  end
  else
    Result := AllMask;
end;

procedure TFilterComboBox.BuildList;
var
  AFilter, MaskName, Mask: string;
  BarPos: Integer;
begin
  Clear;
  MaskList.Clear;
  AFilter := Filter;
  BarPos := AnsiPos('|', AFilter);
  while BarPos <> 0 do
  begin
    MaskName := Copy(AFilter, 1, BarPos - 1);
    Delete(AFilter, 1, BarPos);
    BarPos := AnsiPos('|', AFilter);
    if BarPos > 0 then
    begin
      Mask := Copy(AFilter, 1, BarPos - 1);
      Delete(AFilter, 1, BarPos);
    end
    else
    begin
      Mask := AFilter;
      AFilter := '';
    end;
    Items.Add(MaskName);
    MaskList.Add(Mask);
    BarPos := AnsiPos('|', AFilter);
  end;
  ItemIndex := 0;
end;

procedure TFilterComboBox.Loaded;
begin
  inherited Loaded;
  BuildList;
end;

procedure TFilterComboBox.SetEditable(const Value: Boolean);
const
  Styles: array[Boolean] of TComboBoxStyle = (csDropDownList, csDropDown);
begin
  if FEditable <> Value then
  begin
    FEditable := Value;
    Style := Styles[FEditable];
  end;
end;

procedure TFilterComboBox.InitWidget;
begin
  inherited InitWidget;
  BuildList;
end;

{ TFileHistoryComboBox }

function TFileHistoryComboBox.Add(const Filename: string): Boolean;
var
  Info: PFileInfo;
  SR: TSearchRec;
  Error: Integer;
  NewItem: string;
  I: Integer;
begin
  Result := False;
  if FChanging or (csLoading in ComponentState) then Exit;
  if Filename <> PathDelim then
    NewItem := ExcludeTrailingPathDelimiter(ExpandDirectoryName(Filename))
  else
    NewItem := Filename;
  for I := FHistIndex - 1 downto 0 do
  begin
     if FHistList.Objects[I] <> nil then
       Dispose(PFileInfo(FHistList.Objects[I]));
     FHistList.Delete(I);
  end;

  if IsDriveRoot(FileName) then
  begin
    FillChar(SR, SizeOf(SR), 0);
    SR.Name := PathDelim;
    SR.Attr := faDirectory;
    Info := AllocFileInfo(SR);
  end
  else
  begin
    Error := FindFirst(NewItem, faAnyFile, SR);
    try
      if Error = 0 then
        Info := AllocFileInfo(SR)
      else begin
        Info := nil;
        raise EInOutError.CreateFmt(SFilenameNotFound, [Filename]);
      end;
    finally
      FindClose(SR);
    end;
  end;

  if Info <> nil then
  begin
    Result := True;
    I := FHistList.IndexOf(NewItem);
    FHistList.InsertObject(0, NewItem, TObject(Info));
    if I >= 0 then
      FHistList.Delete(I+1);
    Text := NewItem;
    FHistIndex := 0;
    UpdateItems;
  end;
end;

function TFileHistoryComboBox.CanGoBack: Boolean;
begin
  Result := FHistIndex < FHistList.Count - 1;
end;

function TFileHistoryComboBox.CanGoForward: Boolean;
begin
  Result := FHistIndex > 0;
end;

procedure TFileHistoryComboBox.Clear;
var
  I: Integer;
begin
  Items.Clear;
  for I := 0 to FHistList.Count - 1 do
    Dispose(PFileInfo(FHistList.Objects[I]));
  FHistList.Clear;
  FHistIndex := -1;
  Text := '';
end;

procedure TFileHistoryComboBox.Click;
begin
  FChanging := True;
  try
    if (ItemIndex >= 0) and (ItemIndex < Items.Count) then
    begin
      FHistIndex := ItemIndex;
  //    FileInfo := PFileInfo(Items.Objects[ItemIndex]);
  //    if FileInfo = nil then
  //     raise Exception.CreateFmt('"%s" cannot be read.', [Items[ItemIndex]]);
      inherited Click;
    end;
  finally
    FChanging := False;
  end;
end;

procedure TFileHistoryComboBox.CMKeyDown(var Msg: TCMKeyDown);
begin
  Msg.Handled := (Msg.Key = Key_Return) or (Msg.Key = Key_Enter);
  if Msg.Handled then
  try
    Add(Text);
    Click;
  except on EInOutError do
  begin
    if Items.Count > 0 then
      Text := Items[0];
    raise;
  end;
  end
  else inherited;
end;

procedure TFileHistoryComboBox.UpdateItems;
var
  I: Integer;
begin
  Items.Clear;
  for I := 0 to FHistList.Count - 1 do
    Items.AddObject(FHistList[I], FHistList.Objects[I]);
  ItemIndex := FHistIndex;
  if ItemIndex >= 0 then
    Text := Items[FHistIndex];
end;

constructor TFileHistoryComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHistList := TStringList.Create;
  FHistIndex := -1;
end;

destructor TFileHistoryComboBox.Destroy;
begin
  Clear;
  FHistList.Free;
  inherited Destroy;
end;

function TFileHistoryComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState): Boolean;
var
  FileInfo: PFileInfo;
  ImageIndex: Integer;
  R: TRect;
begin
  Result := True;
  R := Rect;
  if odSelected in State then
  begin
    Canvas.Font.Color := clHighlightText;
    Canvas.Brush.Color := clHighlight;
  end
  else begin
    Canvas.Font.Color := Font.Color;
    Canvas.Brush.Color := Color;
  end;
  Rect.Right := Width;
  Canvas.FillRect(R);
  if (Index > -1) and (Index < Items.Count) then
  begin
    Inc(R.Top, (R.Bottom - R.Top - Canvas.TextHeight('Pq')) div 2);
    FileInfo := PFileInfo(Items.Objects[Index]);
    if FileInfo <> nil then
    begin
      ImageIndex := FIconProvider.DoGetImageIndex(FileInfo);
      Inc(R.Left, 2);
      FIconProvider.Draw(Canvas, R.Left, R.Top, ImageIndex);
{$IFDEF LINUX}
      if FileInfo.SR.Attr and faSymLink <> 0 then
        FIconProvider.DrawLinkOverlay(Canvas, R.Left, R.Top, FileInfo);
{$ENDIF}
      Inc(R.Left, FIconProvider.Width + 2);
    end;
    Canvas.TextRect(R, R.Left, R.Top, Items[Index]);
  end;
  inherited DrawItem(Index, Rect, State);
end; 

function TFileHistoryComboBox.GetFile(Index: Integer): PFileInfo;
begin
  Result := PFileInfo(Items.Objects[Index]);
end;

procedure TFileHistoryComboBox.GoBack;
begin
  if CanGoBack then
  begin
    Inc(FHistIndex);
    UpdateItems;
    //ItemIndex := ItemIndex + 1;
    Click;
  end;
end;

procedure TFileHistoryComboBox.GoForward;
begin
  if CanGoForward then
  begin
    Dec(FHistIndex);
//    ItemIndex := ItemIndex - 1;
    UpdateItems;
    Click;
  end;
end;

procedure TFileHistoryComboBox.InitWidget;
begin
  inherited InitWidget;
  MaxItems := 16;
  InsertMode := ciNone;
end;

procedure TFileHistoryComboBox.Loaded;
begin
  inherited Loaded;
  FIconProvider := IconProvider16;
end;

procedure TFileHistoryComboBox.RemoveItem(Index: Integer);
begin
  Dispose(PFileInfo(Items.Objects[Index]));
  Items.Delete(Index);
end;

procedure TFileHistoryComboBox.RestoreWidgetState;
begin
  inherited RestoreWidgetState;
  UpdateItems;
end;

procedure TFileHistoryComboBox.SaveWidgetState;
begin
  inherited SaveWidgetState;
end;


function FileEditSort(List: TStringList; Item1, Item2: Integer): Integer;
var
  FI1, FI2: PFileInfo;
begin
  FI1 := PFileInfo(List.Objects[Item1]);
  FI2 := PFileInfo(List.Objects[Item2]);
  //directories always precede files.
  Result := (FI2.SR.Attr and faDirectory) - (FI1.SR.Attr and faDirectory);
  if Result = 0 then
     Result := AnsiCompareFileName(FI1.SR.Name, FI2.SR.Name);
end;

type
  TFileEditDirectory = class(TDirectory)
  private
    FEdit: TFileEdit;
  protected
    procedure DoDirChange(const NewDir: WideString); override;
  public
    constructor Create(AOwner: TFileEdit); reintroduce; virtual;
  end;

constructor TFileEditDirectory.Create(AOwner: TFileEdit);
begin
  inherited Create(AOwner);
  FEdit := AOwner;
end;

procedure TFileEditDirectory.DoDirChange(const NewDir: WideString);
begin
  if not FSuspendEvents then
    FEdit.FCurrentDir := NewDir;
  inherited DoDirChange(NewDir);
end;

{ TFileEdit }

function TFileEdit.CheckNewDirectory(const Text: WideString): Boolean;
var
  NewDir: WideString;
  Prefix: WideString;
{$IFDEF MSWINDOWS}
  Tmp: WideString;
{$ENDIF}
begin
  Result := False;
  if Text = '' then Exit;
  if Text[1] = PathDelim then
  begin
{$IFDEF LINUX}
     NewDir := IncludeTrailingPathDelimiter(ExpandDirectoryName(ExtractFilePath(Text)));
     if (Text[Length(Text)] = PathDelim) then
       Prefix := Text;
{$ENDIF}
{$IFDEF MSWINDOWS}
    Tmp := GetDrive(FCurrentDir);
    NewDir := Tmp + Text;
    Prefix := Text;
{$ENDIF}
  end
  else
    if (Length(Text) > 1) and
{$IFDEF LINUX}
     ((Text[1] = '$') or (Text[1] = '~'))
{$ENDIF}
{$IFDEF MSWINDOWS}
     HasDrivePrefix(Text)
{$ENDIF}
    and (Text[Length(Text)] = PathDelim) then
    begin
      NewDir := ExpandDirectoryName(Text);
      Prefix := Text;
    end
  else begin
    NewDir := IncludeTrailingPathDelimiter(ExpandDirectoryName(
      IncludeTrailingPathDelimiter(FCurrentDir) + ExtractFilePath(Text)));
    Prefix := ExtractFilePath(Text);
  end;
  Result := (DirectoryExists(NewDir) and (NewDir <> FListedDir))
{$IFDEF LINUX}
    or (Text = PathDelim)
{$ENDIF}
    or (Text = '');
  if Result then
  begin
    FDirectory.FSuspendEvents := True;
    try
{$IFDEF LINUX}
      if access(PChar(AnsiString(NewDir)), R_OK) = 0 then
{$ENDIF}
        PopulateList(NewDir, Prefix);
    finally
      FDirectory.FSuspendEvents := False;
    end;
  end;
end;

constructor TFileEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDirectory := TFileEditDirectory.Create(Self);
  FDirectory.IncludeParentDir := False;
  FDropDownCount := 10;
  if not (csDesigning in ComponentState) then
  begin
    FListBox := TPopupListBox.CreateParented(QApplication_Desktop);
    FListBox.Height := DropDownCount * 16;//change this to reflect font size;
    FListBox.OnMouseUp := ListMouseUp;
    FListBox.OnMouseMove := ListMouseMove;
  end;
  InputKeys := InputKeys + [ikReturns];
  FPrefix := '';
  FEditMode := emDropDownList;
end;

destructor TFileEdit.Destroy;
begin
  FListBox.Free;
  FDirectory.Free;
  inherited Destroy;
end;

procedure TFileEdit.ResizeListBox(ItemCount: Integer);
var
  I: Integer;
  P: TPoint;
begin
  if (EditMode = emDropDownList) and not FListBox.FResized then
  begin
    if ItemCount > DropDownCount then
      I := DropDownCount
    else
      I := ItemCount;

    if I <> 0 then
    begin
      FListBox.Width := Width;
      FListBox.Height := I * FListBox.ItemHeight
        + (QFrame_frameWidth(FListBox.Handle) * 2);

      P := ClientToScreen(Point(0, 0));
      FListBox.Left := P.X;
      if P.Y + FListBox.Height > Screen.Height then
      begin
        P.Y := P.Y - FListBox.Height;
        FListBox.FDroppedUp := True;
      end
      else begin
        P.Y := P.Y + Height;
        FListBox.FDroppedUp := False;
      end;
      FListBox.Top := P.Y;
    end else
      FListBox.Height := 0;
  end;
end;

procedure TFileEdit.DropDown;
var
  Tmp: Boolean;
begin
  if not ((csDesigning in ComponentState) or (EditMode <> emDropDownList)) then
  begin
    FDroppedDown := True;
    FOriginalText := Text;
    SetMouseGrabControl(Self);
    Tmp := AutoSelect;
    AutoSelect := False;
    FListBox.Visible := True;
    QWidget_setFocus(Handle);
    AutoSelect := Tmp;
  end;
end;

procedure TFileEdit.KeyPress(var Key: Char);
var
  Tmp: WideString;
begin
  inherited KeyPress(Key);
  if EditMode = emAutoComplete then
  begin
    if (Key = PathDelim) and (SelLength > 0) and (FListBox.Items.Count > 0)
    and (Text = FListBox.Items[0])
    and (PFileInfo(FListBox.Items.Objects[0]).SR.Attr and faDirectory <> 0) then
      //if there's a selection, the first item in the listbox is the suggested
      //completion.
    begin
      SelStart := Length(Text);
      SelLength := 0;
      CursorPos := Length(Text);
    end;
    case Key of
       #8, #127:
         begin
           Tmp := MatchText;
           Delete(Tmp, Length(Tmp), 1);
           CheckNewDirectory(Tmp);
         end;
       #32..#126, #128..#255:
         begin
           CheckNewDirectory(MatchText + Key);
           FMatchCount := PartialMatch(MatchText + Key);
           if FMatchCount = 0 then
             CloseUp
           else if not DroppedDown then
             DropDown;
        end;
    end;
    if (FMatchCount <> 0) and (EditMode = emAutoComplete) and not (Key in [#8, #127])
    and (Text <> '') then
      Key := #0;
  end;
end;

procedure TFileEdit.KeyUp(var Key: Word; Shift: TShiftState);
var
  CurIndex: Integer;
begin
  inherited KeyUp(Key, Shift);

  if (csDesigning in ComponentState) or (EditMode = emAutoComplete) then Exit;
  case Key of
    32..126, 128..255:
       begin
         CheckNewDirectory(MatchText);
         FMatchCount := PartialMatch(MatchText);
         if FMatchCount = 0 then
           CloseUp
         else if not DroppedDown then
           DropDown;
      end;
    Key_Down, Key_Up, Key_PageDown, Key_PageUp, Key_Home, Key_End:
      begin
        if DroppedDown then
        begin
          CurIndex := FListBox.ItemIndex;
          case Key of
            Key_Down: if CurIndex < FListBox.Items.Count - 1 then Inc(CurIndex);
            Key_Up: if CurIndex > 0 then Dec(CurIndex);
            Key_PageDown:
              begin
                if CurIndex < 0 then CurIndex := 0;
                if CurIndex = FListBox.TopIndex + FListBox.VisibleItemCount - 1 then
                  Inc(CurIndex, FListBox.VisibleItemCount - 1)
                else
                  CurIndex := FListBox.TopIndex + FListBox.VisibleItemCount - 1;
                if CurIndex >= FListBox.Items.Count then
                  CurIndex := FListBox.Items.Count - 1;
              end;
            Key_PageUp:
              begin
                if CurIndex < 0 then CurIndex := 0;
                if CurIndex = FListBox.TopIndex then
                  Dec(CurIndex, FListBox.VisibleItemCount - 1)
                else
                  CurIndex := FListBox.TopIndex;
                if CurIndex < 0 then
                  CurIndex := 0;
              end;
            Key_Home: CurIndex := 0;
            Key_End: CurIndex := FListBox.Items.Count - 1;
          end;
          SetListIndex(CurIndex);
        end
        else if (Key = Key_Down) and (ssAlt in Shift)
        and (EditMode = emDropDownList) then
        begin
          FMatchCount := PartialMatch(Text);
          if (FMatchCount > 0) and not DroppedDown then
            DropDown;
        end;
        Key := 0;
      end;
    Key_Backspace, Key_Delete:
      begin
        CheckNewDirectory(MatchText);
        if EditMode <> emAutoComplete then
          FMatchCount := PartialMatch(MatchText);
        if Text = '' then
          CloseUp
        else if (FMatchCount > 0) and not DroppedDown then
          DropDown;
      end;
  end;
end;

function TFileEdit.PartialMatch(const Str: WideString): Integer;
var
  I, P: Integer;
  AFile: WideString;
  PartialText: WideString;
begin
  Result := 0;
  if not Assigned(FListBox) then Exit;
  //prevent matching when last character is the path delimiter
  if (EditMode = emAutoComplete) and (((Length(Str) > 0)
  and (Str[Length(Str)] = PathDelim)) or (CursorPos < Length(Text))) then
    Exit;
  FListBox.Items.Clear;
  PartialText := Str;
  for I := 0 to FDirectory.Count - 1 do
  begin
    AFile := FPrefix + FDirectory.Caption(I);
{$IFDEF MSWINDOWS}
    P := Pos(AnsiLowerCaseFileName(PartialText), AnsiLowerCaseFileName(AFile));
{$ENDIF}
{$IFDEF LINUX}
    P := Pos(PartialText, AFile);
{$ENDIF}
    if (P = 1) or ((P = 0) and (PartialText = '')) then
    begin
      FListBox.Items.AddObject(AFile, TObject(FDirectory.Files(I)));
      Inc(Result);
    end;
  end;
  if EditMode = emDropDownList then
    ResizeListBox(Result)
  else if (EditMode = emAutoComplete) and (Result > 0) then
  begin
    if Text <> FListBox.Items[0] then
      Text := FListBox.Items[0];
    SelStart := Length(PartialText);
    CursorPos := SelStart;
    SelLength := Length(Text) - SelStart;
  end;
end;

procedure TFileEdit.PopulateList(const Directory: WideString;
  Prefix: WideString = '');
begin
  if not (csDesigning in ComponentState) then
  begin
    FListedDir := IncludeTrailingPathDelimiter(Directory);
    FPrefix := Prefix;
    FDirectory.Location := ExpandDirectoryName(Directory);
  end;
end;

procedure TFileEdit.CloseUp;
begin
  if not (csDesigning in ComponentState) then
  begin
    FListBox.Visible := False;
    FDroppedDown := False;
    FListBox.FDroppedUp := False;
    SetMouseGrabControl(nil);
  end;
end;

procedure TFileEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if DroppedDown then
    CloseUp;
end;

procedure TFileEdit.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if PtInRect(FListBox.ClientRect, Point(X, Y)) and (FListBox.ItemIndex > -1) then
    Text := FListBox.Items[FListBox.ItemIndex];
  if FListBox.FResizeType = rtNone then
    CloseUp;
end;

procedure TFileEdit.ListMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  Index: Integer;
begin
  Index := FListBox.ItemAtPos(Point(X, Y), True);
  if Index > -1 then
    FListBox.ItemIndex := Index;
end;

procedure TFileEdit.ListEnd;
var
  I: Integer;
begin
  for I := 0 to FDirectory.Count - 1 do
    FListBox.Items.Add(FPrefix + FDirectory.Caption(I));
  FListBox.Items.EndUpdate;
end;

function TFileEdit.ListStart: Boolean;
begin
  Result := Assigned(FListBox) and not (csLoading in ComponentState);
  if Result then
  begin
    FListBox.Items.BeginUpdate;
    FListBox.Clear;
  end;
end;

function TFileEdit.MatchText: WideString;
begin
  if EditMode = emDropDownList then
    Result := Text
  else
    Result := Copy(Text, 1, SelStart);
end;

procedure TFileEdit.SetListIndex(Value: Integer);
begin
  if (Value < 0) or (Value >= FListBox.Items.Count) or not DroppedDown then
    Exit;
  FListBox.ItemIndex := Value;
  FListBox.MakeCurrentVisible;
  Text := FListBox.Items[Value];
end;

procedure TFileEdit.ReturnPressed(var Suppress: Boolean);
var
  NewDir: string;
{$IFDEF MSWINDOWS}
  Tmp: string;
{$ENDIF}
begin
  CloseUp;
  if Length(Text) > 0 then
  begin
    // check for absolute directory path first.
{$IFDEF LINUX}
    if Char(Text[1]) in [PathDelim, '~', '$'] then
      NewDir := ExpandDirectoryName(Text)
{$ENDIF}
{$IFDEF MSWINDOWS}
    if (Char(Text[1]) = PathDelim) or HasDrivePrefix(Text) then
    begin
      Tmp := Text;
      if Char(Text[1]) = PathDelim then
        Tmp := GetDrive(FCurrentDir) + Tmp;

      NewDir := ExpandDirectoryName(Tmp);
      if not DirectoryExists(IncludeTrailingPathDelimiter(NewDir)) then
        Exit;
    end
{$ENDIF}
    else
      NewDir := IncludeTrailingPathDelimiter(FCurrentDir) + Text;
    Suppress := Suppress or DirectoryExists(NewDir);
    if Suppress then
    begin
      Text := '';
      PopulateList(NewDir);
      Exit;
    end;
  end;
  // check for a wildcard filter
  Suppress := (Pos('*', Text) <> 0) or (Pos('?', Text) <> 0);
  if Suppress then
  begin
    FDirectory.FileMask := Text;
    MaskChange(Text);
    SelectAll;
    Exit;
  end;
  inherited ReturnPressed(Suppress);
end;

procedure TFileEdit.CMKeyDown(var Msg: TCMKeyDown);
begin
  if (Msg.Key = Key_Escape) and DroppedDown then
  begin
    CloseUp;
    Text := FOriginalText;
    Msg.Handled := True;
  end
  else inherited;
end;

function TFileEdit.GetCurrentDir: WideString;
begin
  Result := IncludeTrailingPathDelimiter(FCurrentDir);
end;

procedure TFileEdit.DirectoryChanged(const NewDir: WideString);
begin
  if Assigned(FOnDirChange) then
    FOnDirChange(Self, NewDir);
end;

function TFileEdit.FileFound(const SearchRec: TSearchRec): Boolean;
begin
  Result := True;
  if Assigned(FOnFileFound) then
    FOnFileFound(Self, SearchRec, Result);
end;

procedure TFileEdit.MaskChange(const NewMask: WideString);
begin
  if Assigned(FOnMaskChange) then
    FOnMaskChange(Self, NewMask);
end;

procedure TFileEdit.SetDirectory(const Value: TDirectory);
begin
  FDirectory.Assign(Value);
end;

procedure TFileEdit.InitWidget;
begin
  inherited InitWidget;
  if csDesigning in ComponentState then
    FDirectory.Location := SysUtils.GetCurrentDir;
end;

procedure TFileEdit.Loaded;
begin
  inherited Loaded;
  FDirectory.ListFiles(True);
end;

{ TPopupListBox }

constructor TPopupListBox.CreateParented(ParentWidget: QWidgetH);
begin
  inherited CreateParented(ParentWidget);
  ControlStyle := ControlStyle + [csNoDesignVisible, csCaptureMouse, csReplicatable];
end;

type
  TOpenWidget = class(TWidgetControl);

function TPopupListBox.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
var
  EventType: QEventType;
begin
  Result := False;
  EventType := QEvent_type(Event);
  case EventType of
    QEventType_FocusIn:
      Result := True;
  end;
  if not Result then
    Result := inherited EventFilter(Sender, Event);
end;

function TPopupListBox.GetResizeType(P: TPoint): TResizeType;
const
  Border = 4;
var
  Horz, Vert, Both: TRect;
begin
  if FDroppedUp then
  begin
    Vert := Rect(0, 0, Width - Border, Border);
    Horz := Rect(Width - Border, Border, Width, Height);
    Both := Rect(Width - Border, 0, Width, Border);
  end
  else begin
    Vert := Rect(0, Height - Border, Width - Border, Height);
    Horz := Rect(Width - Border, 0, Width, Height - Border);
    Both := Rect(Width - Border, Height - Border, Width, Height);
  end;
  if PtInRect(Horz, P) then
    Result := rtHorz
  else if PtInRect(Vert, P) then
    Result := rtVert
  else if PtInRect(Both, P) then
    Result := rtBoth
  else Result := rtNone;
end;

procedure TPopupListBox.InitWidget;
begin
  inherited InitWidget;
  BorderStyle := bsSingle;
  QWidget_setFocusPolicy(Handle, QWidgetFocusPolicy_NoFocus);
  Visible := False;
end;

procedure TPopupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
    FResizeType := GetResizeType(Point(X, Y))
  else
    FResizeType := rtNone;
  if FResizeType = rtNone then
    inherited MouseDown(Button, Shift, X, Y);
end;

procedure TPopupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewWidth,
  NewHeight,
  NewTop: Integer;
begin
  NewTop := Top;
  NewWidth := Width;
  NewHeight := Height;
  case FResizeType of
    rtNone:
      begin
        case GetResizeType(Point(X, Y)) of
          rtVert: Cursor := crSizeNS;
          rtHorz: Cursor := crSizeWE;
          rtBoth:
            if FDroppedUp then
              Cursor := crSizeNESW
            else
              Cursor := crSizeNWSE;
          rtNone: Cursor := crDefault;
        end;
      end;
    rtVert:
      if FDroppedUp then
      begin
        NewTop := Mouse.CursorPos.Y;
        NewHeight := Top - NewTop + Height;
      end
      else
        NewHeight := Y;
    rtHorz:
      NewWidth := X;
    rtBoth:
      begin
        if FDroppedUp then
        begin
          NewTop := Mouse.CursorPos.Y;
          NewHeight := Top - NewTop + Height;
        end
        else
          NewHeight := Y;
        NewWidth := X;
      end;
    end;
  if FResizeType <> rtNone then
  begin
    FResized := True;
    SetBounds(Left, NewTop, NewWidth, NewHeight);
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TPopupListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FResizeType := rtNone;
end;

function TPopupListBox.WidgetFlags: Integer;
begin
  Result :=  inherited WidgetFlags
              or Integer(WidgetFlags_WType_Popup)
              or Integer(WidgetFlags_WStyle_Tool)
              or Integer(WidgetFlags_WNorthWestGravity);
end;

{$IFDEF MSWINDOWS}

constructor TShellChangeThread.Create(ChangeEvent: TThreadMethod; Directory: string);
begin
  FDirectory := Directory;
  FreeOnTerminate := True;
  FChangeEvent := ChangeEvent;
  FMutex := CreateMutex(nil, True, nil);
  inherited Create(False);
end;

destructor TShellChangeThread.Destroy;
begin
  if FWaitHandle <> ERROR_INVALID_HANDLE then
    FindCloseChangeNotification(FWaitHandle);
  CloseHandle(FMutex);
  inherited Destroy;
end;

procedure TShellChangeThread.Execute;
var
  Obj: DWORD;
  Handles: array[0..1] of DWORD;
begin
  FWaitHandle := FindFirstChangeNotification(PChar(FDirectory),
     False, FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_DIR_NAME or
     FILE_NOTIFY_CHANGE_ATTRIBUTES or FILE_NOTIFY_CHANGE_SIZE);
  if FWaitHandle = ERROR_INVALID_HANDLE then Exit;
  while not Terminated do
  begin
    Handles[0] := FWaitHandle;
    Handles[1] := FMutex;
    Obj := WaitForMultipleObjects(2, @Handles, False, INFINITE);
    case Obj of
      WAIT_OBJECT_0:
        begin
          Synchronize(FChangeEvent);
          FindNextChangeNotification(FWaitHandle);
        end;
      WAIT_OBJECT_0 + 1:
        ReleaseMutex(FMutex);
      WAIT_FAILED:
        Exit;
    end;
  end;
end;
{$ENDIF}

{ TDirectory }

procedure TDirectory.AssignTo(Dest: TPersistent);
var
  I: Integer;
begin
  if not (Dest is TDirectory) then
    inherited AssignTo(Dest)
  else with TDirectory(Dest) do
  begin
    FSuspendEvents := True;
    try
      ClearList;
      FDir := Self.Location;
      FMask := Self.FileMask;
      FFileType := Self.FileType;
      FSortMode := Self.SortMode;
      FSortDirection := Self.SortDirection;
      AutoUpdate := Self.AutoUpdate;
      FIncludeParentDir := Self.IncludeParentDir;
      for I := 0 to Self.FFiles.Count - 1 do
        FFiles.Add(AllocFileInfo(PFileInfo(Self.FFiles[I]).SR));
    finally
      FSuspendEvents := False;
      ListFiles(False);
    end;
  end;
end;

function TDirectory.Attributes(Index: Integer): Integer;
begin
{$IFDEF LINUX}
  Result := Files(Index).stat.st_mode;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Result := Files(Index).SR.Attr;
{$ENDIF}
end;

procedure TDirectory.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

function TDirectory.Caption(Index: Integer): WideString;
begin
  Result := Files(Index).SR.Name;
end;

{$IFDEF MSWINDOWS}
procedure TDirectory.ChangeNotification;
begin
  ListFiles(True);
end;
{$ENDIF}

procedure TDirectory.ClearList;
var
  I: Integer;
begin
  for I := 0 to FFiles.Count - 1 do
    Dispose(PFileInfo(FFiles[I]));
  FFiles.Clear;
end;

function TDirectory.Count: Integer;
begin
  Result := FFiles.Count;
end;

constructor TDirectory.Create(AClient: IDirectoryClient);
begin
  inherited Create;
  FClient := AClient;
  FFiles := TList.Create;
  FMask := AllMask;
  FDirHandle := -1;
  FAutoUpdate := False;
  FFileType := [ftNormal, ftDirectory, ftSystem];
  FAutoUpdate := False;
  FIncludeParentDir := True;
  FSortMode := smName;
  FSortDirection := sdAscending;
  DirChangeList.Add(Self);
end;

function TDirectory.CreateDirectory(const DirName: WideString): PFileInfo;
var
  Created: Boolean;
  SR: TSearchRec;
  AnsiDir: string;
  DirAttr: Integer;
begin
  Result := nil;
  AnsiDir := FDir;
  Created :=
{$IFDEF LINUX}
  (access(PChar(AnsiDir), W_OK) = 0) and
{$ENDIF}
  CreateDir(IncludeTrailingPathDelimiter(FDir) + DirName);
  if Created then
  begin
    DirAttr := faDirectory;
    if ftHidden in FileType then
      DirAttr := DirAttr + faHidden;
    if FindFirst(IncludeTrailingPathDelimiter(FDir) + DirName, DirAttr, SR) = 0 then
    try
      DoFileFound(SR);
      Result := FFiles[FFiles.Count-1];
    finally
      FindClose(SR);
    end;
  end;
end;

function TDirectory.Date(Index: Integer): Integer;
begin
  Result := Files(Index).SR.Time;
end;

function TDirectory.Delete(const Filename: WideString): Integer;
var
  I: Integer;
begin
  I := FFiles.Count - 1;
  while (I > 0) and
    (AnsiCompareFileName(PFileInfo(FFiles[I]).SR.Name, Filename) <> 0)
  do Dec(I);
  if I > -1 then
    Result := Delete(FFiles[I])
  else
    Result := RESULT_FILE_NOT_FOUND;
end;

function TDirectory.Delete(AFile: PFileInfo): Integer;
var
  Filename: string;
begin
  Filename := IncludeTrailingPathDelimiter(FDir) + AFile.SR.Name;
  Result :=
{$IFDEF LINUX}
    access(PChar(Filename), W_OK);
{$ENDIF}
{$IFDEF MSWINDOWS}
    RESULT_OK;
{$ENDIF}
  if Result = RESULT_OK then
  begin
    if AFile.SR.Attr and faDirectory <> 0 then
    begin
      if not RemoveDir(Filename) then
        Result := RESULT_DIR_NOT_EMPTY;
    end
    else
      if not DeleteFile(Filename) then
        Result := RESULT_ACCESS_DENIED;
    if Result = RESULT_OK then
    begin
      FFiles.Remove(AFile);
      Dispose(AFile);
    end;
  end;
end;

destructor TDirectory.Destroy;
begin
  ClearList;
  DirChangeList.Remove(Self);
  FFiles.Free;
  inherited Destroy;
end;

procedure TDirectory.DoDirChange(const NewDir: WideString);
begin
  if Assigned(FClient) and not FSuspendEvents then
    FClient.DirectoryChanged(NewDir);
end;

procedure TDirectory.DoFileFound(const SearchRec: TSearchRec);
var
  CanAdd: Boolean;
begin
  CanAdd := True;
  if Assigned(FClient) then
    CanAdd := FClient.FileFound(SearchRec);
  if CanAdd then
    FFiles.Add(AllocFileInfo(SearchRec));
end;

procedure TDirectory.DoListEnd;
begin
  if Assigned(FClient) then
    FClient.ListEnd;
end;

function TDirectory.DoListStart: Boolean;
begin
  Result := not Assigned(FClient) or FClient.ListStart;
end;

procedure TDirectory.DoMaskChange(const NewMask: WideString);
begin
  if Assigned(FClient) and not FSuspendEvents then
    FClient.MaskChange(NewMask);
end;

procedure TDirectory.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    ListFiles;
end;

{$IFDEF LINUX}
function TDirectory.LinkName(Index: Integer): WideString;
var
  Info: PFileInfo;
begin
  Info := Files(Index);
  if Info.SR.Attr and faSymLink <> 0 then
    Result := Info.LinkTarget
  else
    Result := Info.SR.PathOnly + Info.SR.Name;
end;
{$ENDIF}

function TDirectory.Files(Index: Integer): PFileInfo;
begin
  Result := PFileInfo(FFiles[Index]);
end;

function TDirectory.GetDir: WideString;
begin
{$IFDEF MSWINDOWS}
  if FDir = '' then
    Result := FDir
  else
{$ENDIF}
    Result := IncludeTrailingPathDelimiter(FDir);
end;

{$IFDEF LINUX}
function TDirectory.GroupName(Index: Integer): WideString;
begin
  Result := UserName(Files(Index).stat.st_gid);
end;
{$ENDIF}

function TDirectory.IndexOf(const Filename: WideString): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := FFiles.Count - 1 downto 0 do
  begin
    if AnsiCompareFileName(Caption(I), Filename) = 0 then
    begin
      Result := I;
      Break;
    end;
  end;
end;

{$IFDEF MSWINDOWS}
procedure TDirectory.ListDrives;
var
  DriveBits: set of 0..25;
  DriveNum: Integer;
  SR: TSearchRec;
begin
  { fill list }
  Integer(DriveBits) := GetLogicalDrives;
  for DriveNum := 0 to 25 do
  begin
    if not (DriveNum in DriveBits) then Continue;
    CreateDriveInfo(Char(DriveNum + Ord('A')) + DriveDelim + PathDelim, SR);
    DoFileFound(SR);
  end;
end;
{$ENDIF}

procedure TDirectory.ListFiles(Reread: Boolean = True);
var
  AttrIndex: TFileAttr;
  AttrWord: Word;
  DirAttr: Word;
  MaskPtr, Ptr: PChar;
  SearchRec: TSearchRec;
  AMask: string;
{$IFDEF MSWINDOWS}
  ExtLen: Integer;
  OldErrorMode: Integer;
{$ENDIF}
begin
  if not DoListStart then Exit;
{$IFDEF MSWINDOWS}
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
{$ENDIF}
  try
    if Reread then
    begin
      AMask := FMask;
      ClearList;
{$IFDEF MSWINDOWS}
      if FDir = '' then
        ListDrives
      else begin
{$ENDIF}
        DirAttr := faDirectory;
        if ftSystem in FileType then
          DirAttr := DirAttr + faSysFile;
        if ftHidden in FileType then
          DirAttr := DirAttr + faHidden;
        if ftDirectory in FFileType then
        begin
          if FindFirst(IncludeTrailingPathDelimiter(FDir) + '*', DirAttr, SearchRec) = 0 then
          begin
            repeat { exclude normal files if ftNormal not set }
              if (SearchRec.Attr and faDirectory <> 0)
              and (SearchRec.Name <> '.') then
              begin
                if (SearchRec.Name = '..') then
                begin
                  if not FIncludeParentDir then
                    Continue
                  else
                    DoFileFound(SearchRec);
                end else
                  DoFileFound(SearchRec);
              end;
            until FindNext(SearchRec) <> 0;
            FindClose(SearchRec);
          end;
        end;

        if FFileType * [ftNormal, ftArchive] <> [] then
        begin
          AttrWord := 0;
          for AttrIndex := ftReadOnly to ftArchive do
            if (AttrIndex in FFileType) and (AttrIndex <> ftDirectory) then
              AttrWord := AttrWord or AttrWords[AttrIndex];
          MaskPtr := PChar(AMask);
          while MaskPtr <> nil do
          begin
            Ptr := StrScan(MaskPtr, ';');
            if Ptr <> nil then
              Ptr^ := #0;
            if FindFirst(FDir + PathDelim + MaskPtr, AttrWord, SearchRec) = 0 then
            begin
  {$IFDEF MSWINDOWS}
              ExtLen := Length(ExtractFileExt(MaskPtr));
  {$ENDIF}
              repeat { exclude normal files if ftNormal not set }
                if ((ftNormal in FFileType) or (SearchRec.Attr and AttrWord <> 0))
  {$IFDEF MSWINDOWS}
              // work around FindFirstFile() bug in Windows where, for example,
              // a mask of "*.abc" will match "foo.abcd"
              and (ExtLen <> 4) or (ExtLen = Length(ExtractFileExt(SearchRec.Name)))
  {$ENDIF}
                then
                  DoFileFound(SearchRec);
              until FindNext(SearchRec) <> 0;
              FindClose(SearchRec);
            end;
            if Ptr <> nil then
            begin
              Ptr^ := ';';
              Inc (Ptr);
            end;
            MaskPtr := Ptr;
          end;
        end;
      end;
{$IFDEF MSWINDOWS}
    end;
{$ENDIF}

    if FSortMode <> smNone then
    begin
      GSortMode := FSortMode;
      GSortDirection := FSortDirection;
      FFiles.Sort(FileSort);
    end;
  finally
    DoListEnd;
{$IFDEF MSWINDOWS}
    SetErrorMode(OldErrorMode);
{$ENDIF}
  end;
end;

{$IFDEF LINUX}
function TDirectory.OwnerName(Index: Integer): WideString;
begin
  Result := UserName(Files(Index).stat.st_uid);
end;
{$ENDIF}

procedure TDirectory.RemoveChangeNotification;
begin
{$IFDEF LINUX}
  if FDirHandle > 0 then
  begin
    fcntl(FDirHandle, 0, 0);
    FileClose(FDirHandle);
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if Assigned(FChangeThread) then
  begin
    FChangeThread.Terminate;
    ReleaseMutex(FChangeThread.FMutex);
  end;
{$ENDIF}
end;

function TDirectory.Rename(const Filename, NewName: WideString): Integer;
var
  I, J: Integer;
begin
  I := IndexOf(Filename);
  J := IndexOf(NewName);
  if I > -1 then
    if J < 0 then
      Result := Rename(FFiles[I], NewName)
    else
      Result := RESULT_ALREADY_EXISTS
  else
    Result := RESULT_FILE_NOT_FOUND;
end;

function TDirectory.Rename(AFile: PFileInfo; const NewName: WideString): Integer;
var
  Filename: string;
  NewFilename: string;
  Attr: Integer;
  AttrIndex: TFileAttr;
  Index: Integer;
  SR: TSearchRec;
begin
  Filename := IncludeTrailingPathDelimiter(FDir) + AFile.SR.Name;
  NewFilename := ExcludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(FDir)
    + NewName);
  if FileExists(NewFilename) then
  begin
    Result := RESULT_ALREADY_EXISTS;
    Exit;
  end;
  Result :=
{$IFDEF LINUX}
  access(PChar(Filename), W_OK);
{$ENDIF}
{$IFDEF MSWINDOWS}
  RESULT_OK;//TODO 1: check write access on Windows. Result should be RESULT_OK.
{$ENDIF}
  Attr := 0;
  if Result = RESULT_OK then
  begin
    if not RenameFile(Filename, NewFilename) then
      Result := RESULT_ACCESS_DENIED;
    if Result = RESULT_OK then
    begin
      Index := FFiles.IndexOf(AFile);
      for AttrIndex := ftReadOnly to ftArchive do
        Attr := Attr or AttrWords[AttrIndex];
      if FindFirst(NewFilename, Attr, SR) = 0 then
      try
        Result := Integer(AllocFileInfo(SR));
        Dispose(AFile);
        FFiles[Index] := Pointer(Result);
      finally
        FindClose(SR);
      end
      else begin
        Result := Integer(AFile);
        AFile.SR.Name := NewName;
{$IFDEF LINUX}
        if Pos('.', NewName) = 1 then
          AFile.SR.Attr := AFile.SR.Attr or faHidden;
{$ENDIF}
      end;
    end;
  end;
end;

procedure TDirectory.SetAutoUpdate(const Value: Boolean);
begin
  if FAutoUpdate <> Value then
  begin
    FAutoUpdate := Value;
    if FAutoUpdate then
      SetChangeNotification(FDir)
    else
      SetChangeNotification('');
  end;
end;

procedure TDirectory.SetChangeNotification(const Dir: string);
{$IFDEF LINUX}
var
  dh: Integer;
  Flags: Cardinal;
  action: TSigAction;
{$ENDIF}
begin
  RemoveChangeNotification;
  if Dir = '' then Exit;
{$IFDEF LINUX}
  dh := FileOpen(Dir, fmOpenRead or fmShareDenyNone);
  if dh > 0 then
  begin
    try
      Flags := DN_MODIFY or DN_CREATE or DN_DELETE or DN_RENAME or DN_ATTRIB
        or DN_MULTISHOT;
      if (fcntl(dh, F_SETSIG, SIGIO) = 0)
      and (fcntl(dh, F_NOTIFY, Flags) = 0) then
      begin
        FDirHandle := dh;
        FillChar(action, SizeOf(action), 0);
        with action do
        begin
          __sigaction_handler := @DirChanged;
          sa_flags := SA_SIGINFO;
        end;
        sigaction(SIGIO, @action, nil);
      end;
    finally
      FileClose(dh);
    end;
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  FChangeThread := TShellChangeThread.Create(ChangeNotification, FDir);
{$ENDIF}
end;

procedure TDirectory.SetDir(const Value: WideString);
var
  FName: string;
begin
  if Value <> '' then
    FName := ExpandDirectoryName(Value);
  if not FDirChanging {and (FDir <> FName)} then
  begin
{$IFDEF LINUX}
    if access(PChar(FName), R_OK) <> 0 then
{$ENDIF}
{$IFDEF MSWINDOWS}
  //TODO: Check for directory access on windows.
    if False then
{$ENDIF}
      raise EDirectoryError.CreateFmt(SCannotReadDirectory, [Value]);
    FDir := FName;
    FDirChanging := True;
    try
      if FAutoUpdate then
        SetChangeNotification(FDir);
      if FUpdateCount = 0 then
        ListFiles;
      DoDirChange(FDir);
    finally
      FDirChanging := False;
    end;
  end;
end;

procedure TDirectory.SetFileType(const Value: TFileType);
begin
  if FFileType <> Value then
  begin
    FFileType := Value;
    if FUpdateCount = 0 then
      ListFiles;
  end;
end;

procedure TDirectory.SetIncludeParentDir(const Value: Boolean);
begin
  if FIncludeParentDir <> Value then
  begin
    FIncludeParentDir := Value;
    if FUpdateCount = 0 then
      ListFiles;
  end;
end;

procedure TDirectory.SetMask(const Value: WideString);
begin
  if FMask <> Value then
  begin
    FMask := Value;
    if FUpdateCount = 0 then
      ListFiles;
    DoMaskChange(FMask);
  end;
end;

procedure TDirectory.SetSortDirection(const Value: TSortDirection);
begin
  if FSortDirection <> Value then
  begin
    FSortDirection := Value;
    Sort;
  end;
end;

procedure TDirectory.SetSortMode(const Value: TSortMode);
begin
  if FSortMode <> Value then
  begin
    FSortMode := Value;
    Sort;
  end;
end;

function TDirectory.Size(Index: Integer): Cardinal;
begin
  Result := Files(Index).SR.Size;
end;

procedure TDirectory.Sort;
begin
  ListFiles(False);
end;

type
  TFileIconItemEditor = class(TIconItemEditor)
    procedure EditFinished(Accepted: Boolean); override;
  end;

function TDirectory.UniqueName(const Name: WideString): WideString;
var
  I, J: Integer;
begin
  Result := Name;
  J := 1;
  repeat
    I := IndexOf(Result);
    if I > -1 then
    begin
      Result := Format('%s %d', [Name, J]);
      Inc(J);
    end;
  until I = -1;
end;

{ TFileIconItemEditor }

procedure TFileIconItemEditor.EditFinished(Accepted: Boolean);
begin
  Accepted := Accepted and (Text <> '');
  inherited EditFinished(Accepted);
  if TFileIconView(IconView).FCreatingDir and
  not TFileIconView(IconView).FCreatedDir then
  begin
    if Accepted then
      MessageDlg(SMsgDlgError, Format(SCannotCreateDirName, [Item.Caption]), mtError,
        [mbOk], 0);
    Item.Free;
  end;
  TFileIconView(IconView).FCreatingDir := False;
  IconView.UpdateControl;
end;

{ TFileIconView }

constructor TFileIconView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ReadOnly := True;
  FDirectory := TDirectory.Create(Self);
  InputKeys := InputKeys - [ikReturns];
  FIconProvider := IconProvider32;
  FIconSize := isLarge;
{$IFDEF LINUX}
  FDirectory.Location := GetCurrentDir;
{$ENDIF}
{$IFDEF MSWINDOWS}
  FDrivesListed := False;
{$ENDIF}
end;

procedure TFileIconView.CreateDirectory(const DefaultName: WideString);
var
  InsIndex: Integer;
begin
  if ReadOnly then Exit;
  FCreatingDir := True;
  FCreatedDir := False;
  SetFocus;
  InsIndex := Items.Count;
  if InsIndex > 0 then
    Items[InsIndex-1].MakeVisible;
  with Items.Add do
  begin
    Caption := FDirectory.UniqueName(DefaultName);
    Selected := True;
    UpdateControl;
    EditText;
  end;
end;

function TFileIconView.CreateEditor: TItemEditor;
begin
  Result := TFileIconItemEditor.Create(Self);
end;

procedure TFileIconView.DblClick;
begin
  inherited DblClick;
  if (Selected <> nil) and (FDirectory.Files(Selected.Index).SR.Attr and faDirectory <> 0)
  and (Selected.Caption = '..') then
    GoUp
  else
    GoDown;
end;

function TFileIconView.DeleteFile(const Filename: WideString): Integer;
begin
  Result := FDirectory.Delete(Filename);
  if Result = RESULT_OK then
    Refresh;
end;

destructor TFileIconView.Destroy;
begin
  FDirectory.Free;
  inherited Destroy;
end;

procedure TFileIconView.DirectoryChanged(const NewDir: WideString);
begin
  if Items.Count > 0 then
    EnsureItemVisible(Items[0]);
  if Assigned(FOnDirChange) then
    FOnDirChange(Self, NewDir);
end;

function TFileIconView.DoCustomDrawIconItem(Item: TIconViewItem;
  Canvas: TCanvas; const Rect: TRect; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
var
  R: TRect;
  IL: TCustomImageList;
  II: Integer;
  B: TBitmap;
  Mask: QBitmapH;
begin
  Result := False;
  if Stage = cdPostPaint then
    Result := inherited DoCustomDrawIconItem(Item, Canvas, Rect, State, cdPrePaint);

  if Result then
  begin
    if Assigned(Images) then
      IL := Images
    else
      IL := FIconProvider;

    if cdsSelected in State then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end
    else begin
      Canvas.Brush.Color := Color;
      Canvas.Font.Color := clWindowText;
    end;
    with Item do
    begin
      if IL = Images then
      begin
        DoGetImageIndex(Item);
        II := Item.ImageIndex;
      end
      else
        II := FIconProvider.DoGetImageIndex(Item.Data);
      Canvas.FillRect(TextRect);
      R := IconRect;
      Inc(R.Top, (R.Bottom - R.Top - IL.Height) div 2);
      Inc(R.Left, (R.Right - R.Left - IL.Width) div 2);
      if (Data <> nil) and (EditingItem <> Item) then
      begin
        DrawTruncatedText(Canvas, TextRect, PFileInfo(Item.Data).SR.Name, True,
          IconOptions.WrapText);
      end;
      if Assigned(Images) then
        IL := Images
      else
        IL := FIconProvider;
      if not (cdsSelected in State) then
      begin
        IL.Draw(Canvas, R.Left, R.Top, II);
  {$IFDEF LINUX}
        if (Data <> nil) and (PFileInfo(Item.Data).SR.Attr and faSymLink <> 0)
        and (IL = FIconProvider) then
          FIconProvider.DrawLinkOverlay(Canvas, R.Left, R.Top, PFileInfo(Item.Data));
  {$ENDIF}
      end
      else begin
        B := TBitmap.Create;
        try
          B.Width := IL.Width;
          B.Height := IL.Height;
          Mask := IL.GetMask(II);
          if Mask <> nil then
          begin
            QPixmap_setMask(B.Handle, Mask);
            IL.Draw(B.Canvas, 0, 0, II, itImage);
            B.Canvas.TiledDraw(Types.Rect(0, 0, B.Width, B.Height), IVSelectBmp);
            Canvas.Draw(R.Left, R.Top, B);
  {$IFDEF LINUX}
            if (Data <> nil) and (PFileInfo(Data).SR.Attr and faSymLink <> 0)
            and (IL = FIconProvider) then
              FIconProvider.DrawLinkOverlay(Canvas, R.Left, R.Top, PFileInfo(Data));
  {$ENDIF}
          end;
        finally
          B.Free;
        end;
      end;
    end;
  end;
  if Stage = cdPostPaint then
  begin
    inherited DoCustomDrawIconItem(Item, Canvas, Rect, State, Stage);
    Result := False;
  end;
end;

function TFileIconView.DoCustomHint(var HintInfo: THintInfo): Boolean;
var
  Info: PFileInfo;
  Item: TIconViewItem;
  Pos: TPoint;
  TextRect,
  BRect: TRect;
begin
  Pos := ScreenToClient(Mouse.CursorPos);
  Item := FindItemByPoint(Pos);
  Result := Item <> nil;
  if Result then
  begin
    Info := PFileInfo(Item.Data);
    if Info <> nil then
    begin
      TextRect := Item.TextRect;
      BRect := TextRect;
      Canvas.TextExtent(Item.Caption, BRect,
          Integer(AlignmentFlags_AlignHCenter) or Integer(AlignmentFlags_WordBreak));
      if ((BRect.Right - BRect.Left) > (TextRect.Right - TextRect.Left)) or
        ((BRect.Bottom - BRect.Top) > (TextRect.Bottom - TextRect.Top)) then
        begin
{$IFDEF MSWINDOWS}
          if FDrivesListed then
            HintInfo.HintStr := Format('%s'#10'%s: %s'#10'%s: %s'#10'%s: %s', [Item.Caption,
              SType, GetFileTypeProc(Info), SFreeSpace, Format(SMegs, [Info.SR.Time]),
              SSize, Format(SMegs, [Info.SR.Size])])
          else
{$ENDIF}
            HintInfo.HintStr := Format('%s'#10'%s: %s'#10'%s: %s'#10'%s: %d', [Item.Caption,
              SType, GetFileTypeProc(Info), SDate, DateTimeToStr(FileDateToDateTime(Info.SR.Time)),
              SSize, Info.SR.Size])
        end
      else begin
{$IFDEF MSWINDOWS}
        if FDrivesListed then
          HintInfo.HintStr := Format('%s: %s'#10'%s: %s'#10'%s: %s', [SType,
            GetFileTypeProc(Info), SFreeSpace, Format(SMegs, [Info.SR.Time]),
            SSize, Format(SMegs, [Info.SR.Size])])
        else
{$ENDIF}
          HintInfo.HintStr := Format('%s: %s'#10'%s: %s'#10'%s: %d', [SType,
            GetFileTypeProc(Info), SDate, DateTimeToStr(FileDateToDateTime(Info.SR.Time)),
            SSize, Info.SR.Size]);
      end;
      HintInfo.ReshowTimeout := MaxInt;
    end;
  end;
end;

procedure TFileIconView.DoEdited(AItem: TIconViewItem;
  var S: WideString);
var
  NewDir: PFileInfo;
begin
  if FCreatingDir then
  begin
    NewDir := FDirectory.CreateDirectory(S);
    FCreatedDir := NewDir <> nil;
    if FCreatedDir then
      TIconViewItem(AItem).Data := NewDir;
  end else
    if RenameFile(AItem, S) < 0 then
      S := PFileInfo(TIconViewItem(AItem).Data).SR.Name;
  inherited DoEdited(AItem, S);
end;

procedure TFileIconView.DoEditing(AItem: TIconViewItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := (AItem <> nil) and (((AItem.Data <> nil) and (PFileInfo(AItem.Data).SR.Name <> UpDir))
    or FCreatingDir);
  inherited DoEditing(AItem, AllowEdit);
end;

procedure TFileIconView.DoGetIconSize(Item: TIconViewItem; var Width,
  Height: Integer);
begin
  if Assigned(Images) then
  begin
    Width := Images.Width;
    Height := Images.Height;
  end else
  begin
    Width := FIconProvider.Width;
    Height := FIconProvider.Height;
  end;
end;

procedure TFileIconView.DoGetImageIndex(item: TIconViewItem);
begin
  if not Assigned(Images) then
    with Item do
      ImageIndex := FIconProvider.DoGetImageIndex(Item.Data)
  else
    inherited DoGetImageIndex(Item);
end;

function TFileIconView.FileFound(const SearchRec: TSearchRec): Boolean;
begin
  Result := True;
  if Assigned(FOnFileFound) then
    FOnFileFound(Self, SearchRec, Result);
end;

function TFileIconView.GetSelections: TFileInfos;
var
  I: Integer;
begin
  { Do NOT free the returned pointers - they're live. }
  for I := 0 to Items.Count - 1 do
    if Items[I].Selected then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result)-1] := FDirectory.Files(I);
    end;
end;

procedure TFileIconView.GoDown;
begin
  if (Selected <> nil) then
  begin
    if (PFileInfo(Selected.Data)^.SR.Attr and faDirectory <> 0) then
{$IFDEF LINUX}
      Directory.Location := Directory.LinkName(Selected.Index);
{$ENDIF}
{$IFDEF MSWINDOWS}
      Directory.Location := Directory.Location + PathDelim + Selected.Caption
    else if PFileInfo(Selected.Data)^.SR.Attr and faVolumeID <> 0 then
      Directory.Location := PFileInfo(Selected.Data)^.SR.FindData.cFileName;
{$ENDIF};
  end;
end;

procedure TFileIconView.GoUp;
var
  NewDir: WideString;
begin
{$IFDEF MSWINDOWS}
  if Directory.Location = '' then
    Exit;
  if IsDriveRoot(Directory.Location) then
    NewDir := ''
  else
{$ENDIF}
{$IFDEF LINUX}
  if Directory.Location = PathDelim then Exit;
{$ENDIF}
    NewDir := ExpandDirectoryName(IncludeTrailingPathDelimiter(Directory.Location) + '..');
  if NewDir <> Directory.Location then
    Directory.Location := NewDir;
end;

procedure TFileIconView.ImageChange;
begin
  FDirectory.ListFiles(False);
  UpdateControl;
end;

procedure TFileIconView.ImageListChanged;
begin
  Items.BeginUpdate;
  try
    ImageChange;
  finally
    Items.EndUpdate;
  end;
end;

procedure TFileIconView.InitWidget;
begin
  inherited InitWidget;
  Spacing := 2;
  Sort := False;
  AllocSelectBmp;
  IconOptions.AutoArrange := True;
  Refresh;
end;

function TFileIconView.IsCustomDrawn: Boolean;
begin
  Result := True;
end;

function TFileIconView.IsOwnerDrawn: Boolean;
begin
  Result := False;
end;

procedure TFileIconView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = Key_F5 then
    Refresh;
end;

procedure TFileIconView.KeyPress(var Key: Char);
begin
  //TODO: F2 editing
  inherited KeyPress(Key);
  if not IsEditing then
    case Key of
      #8: GoUp;
      #13: GoDown;
    end;
end;

procedure TFileIconView.ListEnd;
var
  I: Integer;
  NewItem: TIconViewItem;
begin
  for I := 0 to FDirectory.Count - 1 do
  begin
    NewItem := Items.Add;
    NewItem.Data := FDirectory.Files(I);
    NewItem.Caption := FDirectory.Caption(I);
    NewItem.ImageIndex := 0;
  end;
  Screen.Cursor := FSaveCursor;
  Items.EndUpdate;
end;

function TFileIconView.ListStart: Boolean;
begin
  Result := HandleAllocated and not (csLoading in ComponentState);
  if not Result then
    Exit;
{$IFDEF MSWINDOWS}
  FDrivesListed := Directory.Location = '';
{$ENDIF}
  Application.CancelHint;
  Items.BeginUpdate;
  FSaveCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;
  Items.Clear;
end;

procedure TFileIconView.Loaded;
begin
  inherited Loaded;
  HandleNeeded;
  Refresh;
end;

procedure TFileIconView.MaskChange(const NewMask: WideString);
begin
  if Assigned(FOnMaskChange) then
    FOnMaskChange(Self, NewMask);
end;

function TFileIconView.NeedKey(Key: Integer; Shift: TShiftState;
  const KeyText: WideString): Boolean;

  function IsNavKey: Boolean;
  begin
    Result := (Key = Key_Left) or (Key = Key_Right) or
      (Key = Key_Down) or (Key = Key_Up) or
      (Key = Key_Home) or (Key = Key_End) or
      (Key = Key_PageUp) or (Key = Key_PageDown);
  end;

begin
  Result := inherited NeedKey(Key, Shift, KeyText);
  if not Result then
    Result := (isNavKey and (ssShift in Shift)) or (((Key = Key_Enter) or
      (Key = Key_Return)) and ((Selected <> nil)
      and (PFileInfo(Selected.Data).SR.Attr = faDirectory)));
end;

procedure TFileIconView.PositionEditor(var NewLeft, NewTop: Integer);
begin
  if TextPosition = itpRight then
    Inc(NewLeft, IconPixels(IconSize))
  else
    inherited PositionEditor(NewTop, NewLeft);
end;

procedure TFileIconView.Refresh;
begin
  FDirectory.ListFiles(True);
end;

function TFileIconView.RenameFile(Item: TIconViewItem;
  const NewName: WideString): Integer;
begin
  Result := 0;
  if (NewName = '') or (AnsiCompareFileName(Item.Caption, NewName) = 0) then
    Exit;
    
  Result := FDirectory.Rename(Item.Caption, NewName);
  case Result of
    RESULT_ACCESS_DENIED:
      Error(Format(SAccessDeniedTo, [Item.Caption]));
    RESULT_FILE_NOT_FOUND:
      Error(Format(SFileNameNotFound, [Item.Caption]));
    RESULT_ALREADY_EXISTS:
      Error(SAlreadyExists);
  else
    if (PFileInfo(Result).SR.Attr and faHidden <> 0)
    and not (ftHidden in FDirectory.FileType) then
      Item.Delete
    else begin
      Item.Data := Pointer(Result);
      Item.Caption := NewName;
      InvalidateRect(Item.BoundingRect, True);
    end;
  end;
end;

procedure TFileIconView.SetDirectory(const Value: TDirectory);
begin
  FDirectory.Assign(Value);
end;

procedure TFileIconView.SetIconSize(const Value: TIconSize);
begin
  if FIconSize <> Value then
  begin
    FIconSize := Value;
    case Value of
      isSmall:
        FIconProvider := IconProvider16;
      isLarge:
        FIconProvider := IconProvider32;
      isVeryLarge:
        FIconProvider := IconProvider48;
    end;
    ImageChange;
  end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QFileCtrls.pas initialization enter'); {$EndIf}
  DirChangeList := TList.Create;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Clx\QFileCtrls.pas initialization leave'); {$EndIf}
finalization
  DirChangeList.Free;
  if Assigned(GIconProvider16) then
    FreeAndNil(GIconProvider16);
  if Assigned(GIconProvider32) then
    FreeAndNil(GIconProvider32);
end.
