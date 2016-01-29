{====================================================s}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}


(*

Version History

05/30/2003

 Fixed SetExpandRoot
 Fixed GetItemForPIDL function
 OnItemAdding event was not fired. Fixed.

03/17/2003

 Fixed popup menu activation and invoking, added default menu activation
 Fixed - allow change soft type without columns
 Fixed popup menu activation
 Fixed shell autocompletion for ElShellComboBox.
 Fixed sorting in ComboBox
 Fixed ShellTree.GetItemForPIDL.
 Has been removed CheckForChildren for Folders witch attribute SFGAO_LINK. Since links can be
   on any demountable devices.
 Fixed sorting for TElShellList.DoCompareItems. Added default sorting like system explorer.
 Added shell PIDL handling (execution, copy, paste, cut, properties).
 Fixed filtering and increase in speed for filtering ( added filter class caching(TMask) ).
 Fixed memory leak in CheckWin32FindData
 Implemented alternative to calculation of system hint. System hint it is very slowly calculated
   when Root=fsoCustom. It is well visible by the example of big AVI files (for WinXP
   caltculating "Duration" column is very slowly ). It is bug WinXP.
 Added hint caching.
 Added navigation and run item in TElShellList on a double click of the mouse. It is adjusted
   by properties: AutoNavigate, AutoExecute.
 Added linking to other ElShell components.

12/11/2002

 Fixed calculation of image index
 Fixed FillItemWithData (disable painting while there is a filling)
 Fixed SetSelectionPIDL (no rebuild nodes)
 Added SetSelectionPath
       GetItemForPath
 Added PathType identification (FolderOrFile, Folder or File )
 Added
    procedure TElShellTree.BeginUpdate;
    procedure TElShellTree.EndUpdate;
 Increase in speed: added FullPIDL caching.

12/04/2002

  Fixed default columns in ElShellList

05/02/2002

  Fixed rebuilding of the tree and list when the component is loaded
  OnItemAdded is now correctly fired for all items
  Columns in list are now built correctly

04/04/2002

  Improved speed of list building
  Fixed the problem with images

02/14/2002

  Solved the problem with AV happening when the combo box is recreated
  (RecreateWnd is used).

12/24/2001

  Added ElShellList.BuildRootPIDL to access current root pidl
  Made ElShellListItem.BuildFullPIDL and ElShellTreeItem.BuildFullPIDL methods public
  Fixed calls to SetRootPIDL with Empty PIDL (with size of 2) as parameter

11/21/2001

  SystemMenu is shown when you press VK_APPS (AKA Context Menu) key.
  Fixed the problem with 32-bit icons in Windows XP.

11/20/2001

  Fixed GetFocusedDisplayName methods

11/15/2001

  Fixed system menus that worked incorrectly
  ExpandRoot property added. It defines whether the root item is expanded.

11/14/2001

  OnTryEdit property made published

*)

unit ElShellCtl;


interface

uses

  Controls,
  Menus,
  Classes,
  SysUtils,
  Messages,
  CommCtrl,
  Windows,
  ShellAPI,
  ShlObj,
  {$ifndef B_4}
  Masks,
  {$endif}
  ComObj,
  ActiveX,
  Forms,
  {$ifdef DEBUG}
  Dialogs,
  {$endif}
  Graphics,
  {$ifdef VCL_4_USED}
  ImgList,
  {$endif}
  {$ifdef VCL_6_USED}
  Variants,
  {$endif}
  StdCtrls,
  {$ifdef VCL_6_USED}
  Types,
  {$endif}

  ElACtrls,
  ElTreeStdEditors,
  ElShellUtils,
  ElStrUtils,
  ElTools,
  ElList,
  ElHeader,
  {$ifdef ELPACK_NO_ADV_EDITS}
  ElEdits,
  {$endif}
  ElCombos,
  ElTreeCombo,
  ElTree,
  ElVCLUtils;

type

  TShellAttr =
     {$ifdef VCL_4_USED}
         Cardinal
     {$else}
       {$ifdef B_4_UP}
         Cardinal
       {$else}
         Integer
       {$endif}
     {$endif}
  ;

  TElPathType = (ptFolderOrFile, ptFolder, ptFile );

  TElShellSortType = (sstCustom, sstName, sstDefault, sstSize, sstCreationDate, sstModifyDate,
    sstAccessDate, sstExt );

  TElShellSortModifier = (ssmFoldersFirst, ssmExecutablesFirst);
  TElShellSortModifiers = set of TElShellSortModifier;

  TElShellSizeFormat = (ssfAsIs, ssfKb, ssfAuto);

  EElShellError = class(Exception);

  TElShellList = class;
  TElShellComboBox = class;

  TElShellTreeItem = class(TElTreeItem)
  private
    FIsValidFile  :Boolean;
  protected
    FValid        :Boolean;
    FAttrAsString :String;
    FComment      :String;
    FSizeAsString :String;
    FDisplayName  :String;
    FTypeName     :String;
    FFileName     :String;
    FAttr         :Cardinal;
    FPIDL         :PItemIDList;
    FFullPIDL     :PItemIDList;
    Win32FindData :PWin32FindData;
    FEditName     :String;
    {$ifdef VCL_4_USED}
    FHint         :TElFString;
    {$endif}
    procedure GetAttributes(const iParentFolder: IShellFolder);
    function GetDisplayName: String;
    function GetFullName: String;
    function GetHasSubFolders: Boolean;
    function GetIsFolder: Boolean;
    function GetIsRemovable: Boolean;
    function GetParentFolder: IShellFolder;
    function GetSize: Cardinal;
    procedure SetDisplayName(const Value: String);
    function GetCreationTime: TDateTime;
    function GetModificationTime: TDateTime;
    function GetLastAccessTime: TDateTime;
    procedure GetWin32Data(const ParentFolder: IShellFolder);
    procedure CheckWin32FindData;
    function GetFileName: String;
    function GetSizeAsString: String;
    function GetTypeName: String;
    function GetIsFileObject: Boolean;
    function GetAttrAsString: String;
    function GetComment: String;
    procedure Invalidate;
    function FindItemByPIDL(APIDL: PItemIDList):TElShellTreeItem;
    function GetCanRename: Boolean;
    {$ifdef VCL_4_USED}
    function GetHintText(const ParentFolder: IShellFolder):TElFString;
    {$endif}
    function GetPicture(const ParentFolder: IShellFolder):Integer;
    function GetFullPIDL: PItemIDList;
    function GetEditName: String;
    procedure SetEditName(const Value: String);
    procedure ClearData(bRelease:Boolean);
  public
    constructor Create(AOwner: TCustomElTree); override;
    destructor Destroy; override;
    function IsExists:Boolean;
    function BuildFullPIDL: PItemIDList;

    property Attr: Cardinal read FAttr;
    property DisplayName: String read GetDisplayName write SetDisplayName;
    property FullName: String read GetFullName;
    property HasSubFolders: Boolean read GetHasSubFolders;
    property IsFolder: Boolean read GetIsFolder;
    property IsRemovable: Boolean read GetIsRemovable;
    property ParentFolder: IShellFolder read GetParentFolder;
    property PIDL: PItemIDList read FPIDL;
    property FullPIDL: PItemIDList read GetFullPIDL;
    property ModificationTime: TDateTime read GetModificationTime;
    property CreationTime: TDateTime read GetCreationTime;
    property LastAccessTime: TDateTime read GetLastAccessTime;
    property FileName: String read GetFileName;
    property SizeAsString: String read GetSizeAsString;
    property IsFileObject: Boolean read GetIsFileObject;
    property Comment: String read GetComment;
    property CanRename: Boolean read GetCanRename;
    property EditName: String read GetEditName write SetEditName;
  published
    property Size: Cardinal read GetSize;
    property TypeName: String read GetTypeName;
    property AttrAsString: String read GetAttrAsString;
  end;

  TShellTreeItemAddingEvent = procedure(Sender: TObject; ItemName: String;
                              ShellFolder: IShellFolder; RelPIDL: PItemIDList;
                              var Allowed: Boolean) of object;
  TShellTreeItemAddedEvent  = procedure(Sender: TObject; ItemName: String;
                              ShellFolder: IShellFolder; RelPIDL: PItemIDList;
                              Item: TElShellTreeItem) of object;

  TInvokeVerbCommand        = procedure(Sender:TObject; Verb:String; var Handled:Boolean) of object;

  TAddColumnEvent           = procedure(Sender:TObject; SectionIndex:Integer) of object;

  TElShellTree = class(TCustomElTree)
  protected
    FEditor               :TElTreeInplaceEdit;
    FRootFolder           :TShellFolders;
    FRootPIDL             :PItemIDList;
    FFocusedPIDL          :PItemIDList;
    FIFolder              :IShellFolder;
    FCustomRootFolder     :String;
    FUseSystemMenus       :Boolean;
    FClearOnCollapse      :Boolean;
    FCheckForChildren     :Boolean;
    FShowHidden           :Boolean;
    FShowFiles            :Boolean;
    FHighlightCompressed  :Boolean;
    FFileFilters          :TStringList;
    {$ifndef B_4}
    FFileMasks            :TList;
    {$endif}
    FFileFiltered         :Boolean;
    FOnFilterItem         :TShellTreeItemAddingEvent;
    FOnItemAdded          :TShellTreeItemAddedEvent;
    FFileSystemOnly       :Boolean;
    FSortType             :TElShellSortType;
    FSortModifiers        :TElShellSortModifiers;
    FSizeFormat           :TElShellSizeFormat;
    FDefaultColumns       :Boolean;
    FDefaultEditor        :Boolean;
    FMaxColumns           :Integer;
    FExpandRoot           :Boolean;
    FShellListView        :TElShellList;
    FShellComboBox        :TElShellComboBox;
    fIsSyncControls       :Boolean;
    FAutoNavigate         :Boolean;
    FAutoExecute          :Boolean;
    fOnInvokeVerbCommand  :TInvokeVerbCommand;
    fOnRootChanged        :TNotifyEvent;
    fOnAddColumn          :TAddColumnEvent;

    function _GetFocusedPIDL: PItemIDList;
    function GetFocusedPIDL: PItemIDList;
    function GetFocusedDisplayName: String;
    procedure BuildTree;
    procedure ReleaseFocusedPIDL;
    procedure DoItemFocused; override;
    procedure SetCustomRootFolder(const Value: String);
    function CreateView: TElTreeView; override;
    function CreateItems: TElTreeItems; override;
    function CheckChildren(Item: TElTreeItem; const AFolder: IShellFolder): Boolean;
    function FillItemWithData(Item: TElShellTreeItem; const AFolder: IShellFolder;
        Recursive: Integer): Boolean;
    procedure SetShowHidden(Value: Boolean);
    procedure SetShowFiles(Value: Boolean);
    procedure SetHighlightCompressed(Value: Boolean);
    function GetFileFilters: TStrings;
    procedure SetFileFiltered(const Value: Boolean);
    procedure SetFileFilters(const Value: TStrings);
    function NameFiltered(const S: String; const ShellFolder: IShellFolder;
      RelPIDL: PItemIDList): Boolean; virtual;
    procedure CreateHandle; override;
    procedure DoItemCollapse(Item: TElTreeItem); override;
    procedure DoItemExpand(Item: TElTreeItem); override;
    procedure DoItemExpanding(Item: TElTreeItem; var CanProcess: Boolean); override;
    function GetRootFolder: TShellFolders;
    procedure SetRootFolder(Value: TShellFolders);
    procedure DoItemAdded(const S: String; const ShellFolder: IShellFolder; RelPIDL :
        PItemIDList; Item: TElShellTreeItem); virtual;
    procedure SetFileSystemOnly(Value: Boolean);
    function GetItemFocused: TElShellTreeItem;
    procedure SetItemFocused(Value: TElShellTreeItem);
    procedure DoCompareItems(Item1, Item2: TElTreeItem; var res: Integer); override;
    procedure SetSortType(Value: TElShellSortType);
    procedure SetSortModifiers(Value: TElShellSortModifiers);
    procedure SetSizeFormat(Value: TElShellSizeFormat);
    procedure SetDefaultColumns(Value: Boolean);
    procedure AddDefaultColumns;
    function DeleteDefaultColumns: Integer;
    procedure TriggerVirtualTextNeeded(Item: TElTreeItem; SectionIndex: Integer;
        var Text : TElFString); override;
    procedure TriggerVirtualValueNeeded(Item: TElTreeItem; SectionIndex: Integer;
        VarType: Integer; var Value: Variant); override;
    procedure TriggerSortBegin; override;
    procedure TriggerTryEditEvent(Item: TElTreeItem; SectionIndex: Integer;
      var CellType: TElFieldType; var CanEdit: Boolean); override;
    procedure TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer;
        SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor); override;
    procedure FileFiltersChange(Sender: TObject);
    procedure OnBeforeOperation(Sender: TObject; var DefaultConversion: Boolean);
    procedure OnValidateEdit(Sender: TOBject; var InputValid: Boolean);
    procedure SetExpandRoot(Value: Boolean);
    {$ifdef VCL_4_USED}
    procedure TriggerVirtualHintNeeded(Item: TElTreeItem; var Hint: TElFString); override;
    {$endif}
    function DoGetPicture(Item: TElTreeItem): Integer; override;
    procedure SetShellListView(Value: TElShellList);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
        override;
    procedure SyncControls(Sender:TObject);
    procedure SetShellComboBox(Value: TElShellComboBox);

    procedure DefineProperties(Filer: TFiler); override;

    // extended navigation:
    procedure MouseLButtonDblClickExt(X, Y: Integer; Shift: TShiftState);
    procedure MouseLButtonDblClickItem(Item: TElShellTreeItem; Shift: TShiftState);
    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure KeyPressTransfer(Sender: TObject; var Key: Char); override;

    procedure Paint; override;

    property Items stored False;
  public
    function SetRootPIDL(PIDL: PItemIDList):Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure RefreshTree(Item: TElTreeItem; Recursive: Integer);
    function GetItemForPIDL(PIDL: PItemIDList):TElShellTreeItem;
    function SetSelectionPIDL(PIDL: PItemIDList):Boolean;
    function IsSelectionPIDL(PIDL: PItemIDList):Boolean;
    function GetItemForPath(const Path:String;
      PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif}):TElShellTreeItem;
    function SetSelectionPath(const Path:String;
      PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif}):Boolean;
    function BuildRootPIDL: PItemIDList;

    property FocusedPIDL: PItemIDList read GetFocusedPIDL;
    property FocusedDisplayName: String read GetFocusedDisplayName;
    property ItemFocused: TElShellTreeItem read GetItemFocused write SetItemFocused;

    property Images;
    property Images2;
    property AlphaForImages;
    property AlphaForImages2;

    property RootIShellFolder: IShellFolder read FIFolder;
    function  GetPIDLFromPath(const Path: String;
      PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif}): PItemIDList;
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure SynclShellComboBox(ShellComboBox: TElShellComboBox);
    procedure SynclShellTree(ShellTree: TElShellTree);
    procedure SyncShellList(ShellList: TElShellList);

    property RootPIDL: PItemIDList read FRootPIDL;
  published
    // Navigation and Linking properties:
    property AutoNavigate: Boolean read FAutoNavigate write FAutoNavigate default True;
    property AutoExecute: Boolean read FAutoExecute write FAutoExecute default False;
    property OnInvokeVerbCommand :TInvokeVerbCommand read fOnInvokeVerbCommand
      write fOnInvokeVerbCommand;
    property ShellListView: TElShellList read FShellListView write SetShellListView;
    property ShellComboBox: TElShellComboBox read FShellComboBox write SetShellComboBox;

    property RootFolder: TShellFolders read GetRootFolder write SetRootFolder default sfoDesktop;
    property CustomRootFolder: String read FCustomRootFolder write SetCustomRootFolder;
    property UseSystemMenus: Boolean read FUseSystemMenus write FUseSystemMenus default False;
    property ClearOnCollapse: Boolean read FClearOnCollapse write FClearOnCollapse default True;
    property CheckForChildren: Boolean read FCheckForChildren write
        FCheckForChildren default False;
    property ShowHidden: Boolean read FShowHidden write SetShowHidden default True;
    property ShowFiles: Boolean read FShowFiles write SetShowFiles default False;
    property HighlightCompressed: Boolean read FHighlightCompressed write
        SetHighlightCompressed default True;
    property FileFiltered:Boolean read FFileFiltered write SetFileFiltered default False;
    property FileFilters: TStrings read GetFileFilters write SetFileFilters;
    property OnItemAdding: TShellTreeItemAddingEvent read FOnFilterItem write
        FOnFilterItem;
    property OnItemAdded: TShellTreeItemAddedEvent read FOnItemAdded write
        FOnItemAdded;
    property FileSystemOnly: Boolean read FFileSystemOnly write SetFileSystemOnly default False;
    property SortType: TElShellSortType read FSortType write SetSortType default sstDefault;
    property SortModifiers: TElShellSortModifiers read FSortModifiers write
        SetSortModifiers default [ssmFoldersFirst, ssmExecutablesFirst];
    property SizeFormat: TElShellSizeFormat read FSizeFormat write SetSizeFormat default ssfAsIs;
    property DefaultColumns: Boolean read FDefaultColumns write SetDefaultColumns default False;
    property DefaultEditor: Boolean read FDefaultEditor write FDefaultEditor default True;
    property ExpandRoot: Boolean read FExpandRoot write SetExpandRoot default False;
    property OnRootChanged: TNotifyEvent read fOnRootChanged write fOnRootChanged;
    property OnAddColumn: TAddColumnEvent read fOnAddColumn write fOnAddColumn;

    // inherited properties
    property ActiveBorderType;
    property Align;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
    property AutoExpand;
    property AutoLineHeight;
    property AutoLookup;
    property AutoResizeColumns;

    property DefaultSectionWidth;
    property AdjustMultilineHeight;
    property Background;
    property BackgroundType;

    property BarStyle;
    property BarStyleVerticalLines;
    property BorderSides;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DeselectChildrenOnCollapse;

    property DblClickMode;
    property DoInplaceEdit;
    property DragAllowed;
    property DragCursor;
    property DragExpandDelay;
    property DraggableSections;
    property DrawFocusRect;
    property DragImageMode;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;

    property ExpandOnDragOver;
    property ExplorerEditMode default True;
    property Flat;
    property FlatFocusedScrollbars;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property ForcedScrollBars;
    property Font stored True;
    property FullRowSelect;
    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;

    property HeaderActiveFilterColor;
    property HeaderColor;
    property HeaderHeight;
    property HeaderHotTrack;
    property HeaderInvertSortArrows;
    property HeaderSections;
    property HeaderFilterColor;
    property HeaderFlat;
    property HeaderFont;
    property HeaderUseTreeFont;
    property HeaderImages;
    property AlphaForHeaderImages;
    property HeaderWrapCaptions;
    property HideFocusRect;
    property HideHintOnTimer;
    property HideHintOnMove;
    property HideSelectColor;
    property HideSelectTextColor;
    property HideSelection;
    property HorizontalLines;
    property HideHorzScrollBar;
    property HideVertScrollBar;
    property HintType;
    property HighlightAlphaLevel;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property HeaderImageForm;
    property ImageForm;
    {$endif}
    property InactiveBorderType;
    property IncrementalSearch;
    property IncrementalSearchTimeout;
    property IncrementalSearchScope;

    property InplaceEditorDelay;
    property ItemIndent;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property LineHeight;
    property LinesColor;
    property LinesStyle;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LockHeaderHeight;
    property MainTreeColumn;
    property MinusPicture;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MouseFrameSelect;
    property OwnerDrawByColumn default True;
    property OwnerDrawMask;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property QuickEditMode;

    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowHotTrack;
    property RowSelect;

    property ScrollbarOpposite;
    property HorzScrollTracking;
    property VertScrollTracking;
    property SelectColumn;
    property ShowButtons;
    property ShowColumns;
    property ShowCheckboxes;
    //property ShowEmptyImages; !!! do not publish it.
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines;
    property ShowRoot;
    property ShowRootButtons;
    property SelectionMode;
    property SortDir;
    property SortMode;
    property SortUseCase;
    property Storage;
    property StoragePath;
    property StickyHeaderSections;
    property StripedOddColor;
    property StripedEvenColor;
    property StripedItems;

    property Tracking;
    property TrackColor;
    property UnderlineTracked;
    property UseCustomScrollBars;

    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property UseSystemHintColors;
    property TextColor;
    property BkColor;

    property OnScroll;
    property OnHeaderColumnClick;
    property OnHeaderColumnDraw;
    property OnHeaderColumnResize;
    property OnHeaderColumnMove;
    property OnHeaderLookup;
    property OnHeaderLookupDone;
    property OnHeaderResize;
    property OnHeaderSectionExpand;
    property OnHeaderSectionCollapse;
    property OnHeaderSectionFilterCall;
    property OnHeaderSectionAutoSize;
    property OnHeaderSectionMeasure;
    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;

    property OnAfterSelectionChange;
    property OnChanging;
    property OnDragTargetChange;
    property OnItemChange;
    property OnItemPreDraw;
    property OnItemDraw;
    {$ifndef VER3_EDITORS}
    {$ifdef ELTREE_USE_INPLACE_EDITORS}
    property OnTryEdit;
    property OnEditRequest;
    property OnComboEditShow;
    property OnValidateCombo;
    property OnValidateInplaceEdit;
    property OnTuneUpInplaceEdit;
    property OnEditKeyDown;
    {$endif ifdef ELTREE_USE_INPLACE_EDITORS}
    {$else}
    property OnTryEdit;
    property OnInplaceEditorNeeded;
    {$endif ifndef VER3_EDITORS}
    property OnItemChecked;
    property OnItemExpand;
    property OnItemCollapse;
    property OnItemExpanding;
    property OnItemCollapsing;
    property OnItemDeletion;
    property OnItemFocused;
    property OnShowLineHint;
    property OnCompareItems;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnItemPostDraw;
    property OnHotTrack;
    property OnMeasureItemPart;
    property OnSortBegin;
    property OnSortEnd;
    property OnItemSave;
    property OnItemLoad;
    property OnItemSelectedChange;
    property OnCellStyleSave;
    property OnCellStyleLoad;
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;
    {$IFDEF HAS_HTML_RENDER}
    property OnHTMLImageNeeded;
    {$ENDIF}
    property OnVirtualTextNeeded;
    property OnVirtualHintNeeded;
    property OnVirtualValueNeeded;
    {$ifdef ELTREE_USE_STYLES}
    property OnVirtualStyleNeeded;
    {$endif}
    property OnHeaderMouseDown;

    {$ifdef ELTREE_USE_OLE_DRAGDROP}
    {$IFNDEF VER90}
    property OnOleTargetDrag;
    property OnOleTargetDrop;
    property OnOleDragStart;
    property OnOleDragFinish;
    {$ENDIF}
    {$endif}

    // VCL properties
    {$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    {$ENDIF}
    property BorderStyle;

    property Ctl3D;
    property Cursor;
    property Enabled;
    property Hint;

    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;

    property Visible;
    property TabOrder;
    property TabStop;

    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnResize;
    {$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
    {$ENDIF}
    {$IFDEF VCL_5_USED}
    property OnContextPopup;
    {$ENDIF}
  end;

  {$ifndef VCL_5_USED}
     TOwnerDrawState = StdCtrls.TOwnerDrawState;
  {$else}
     TOwnerDrawState = Windows.TOwnerDrawState;
  {$endif}

  TElShellComboBox = {class(TElTreeCombo)}class(TElAdvancedComboBox)
  protected
    FNoRebuild      :Boolean;
    FSelectionPIDL  :PItemIDList;
    FExplorerStyle  :Boolean;
    FShowHidden     :Boolean;
    FFileSystemOnly :Boolean;
    FDummyInt       :Integer;
    {$ifdef ELPACK_NO_ADV_EDITS}
    FEditor         :TCustomElEdit;
    {$else}
    FEditor         :TCustomEdit;
    {$endif}
    FCursor         :TCursor;
    FStyle          :TComboBoxStyle;
    FShellListView  :TElShellList;
    FShellTreeView  :TElShellTree;
    fIsSyncControls :Boolean;
    FAutoCompletion :Boolean;

    procedure SetExplorerStyle(Value: Boolean);
    procedure FillCombo(const BaseFolder: IShellFolder; BasePIDL: PItemIDList; Level: Integer);
    procedure CreateWnd; override;
    procedure SetShowHidden(Value: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
    function GetItemWidth(Index: Integer): Integer; override;
    procedure SetFileSystemOnly(Value: Boolean);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CNCommand(var Msg: TWMCommand); message CN_COMMAND;
    procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    function GetSelection: PItemIDList;
    procedure ShowEdit;
    procedure KeyPress(var Key: Char); override;
    procedure DropDown; override;
    procedure WMDeleteItem(var Message: TMessage); message WM_DELETEITEM;
    procedure AcceptEdit;
    procedure CancelEdit;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WMLButtonDown(var Message: TWMMouse); message WM_LBUTTONDOWN;
    procedure SetCursor(Value: TCursor);
    procedure FillItems;
    procedure SetStyle(Value: TComboBoxStyle); {$ifdef VCL_5_USED}reintroduce;{$endif}
    procedure DestroyWnd; override;
    procedure SyncControls(Sender:TObject);
    procedure SetShellListView(Value: TElShellList);
    procedure SetShellTreeView(Value: TElShellTree);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoCompletion(Value:Boolean);
    function GetEditorText:String;
    procedure DefineProperties(Filer: TFiler); override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure SetSelection(PIDL: PItemIDList);
    function SetSelectionPIDL(PIDL: PItemIDList):Boolean;
    property Selection: PItemIDList read GetSelection write SetSelection;

    procedure SynclShellComboBox(ShellComboBox: TElShellComboBox);
    procedure SynclShellTree(ShellTree: TElShellTree);
    procedure SyncShellList(ShellList: TElShellList);
    function SetSelectionPath(Path:String):Boolean;

    property EditorText:String read GetEditorText;
  published
    property Items : Integer read FDummyInt;
    property ItemHeight : Integer read FDummyInt;

    property ExplorerStyle: Boolean read FExplorerStyle write SetExplorerStyle default True;
    property ShowHidden: Boolean read FShowHidden write SetShowHidden default True;
    property FileSystemOnly: Boolean read FFileSystemOnly write SetFileSystemOnly default False;
    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property Style: TComboBoxStyle read FStyle write SetStyle stored False
      default csOwnerDrawVariable;
    property ShellListView: TElShellList read FShellListView write SetShellListView;
    property ShellTreeView: TElShellTree read FShellTreeView write SetShellTreeView;
    property AutoCompletion:Boolean read FAutoCompletion write SetAutoCompletion default False;
  end;

  TElShellListItem = class(TElTreeItem)
  private
    FIsValidFile   :Boolean;
    FValid         :Boolean;
  protected
    FAttr          :TShellAttr;
    FAttrAsString  :String;
    FComment       :String;
    FDisplayName   :String;
    FFileName      :String;
    FPIDL          :PItemIDList;
    FSizeAsString  :String;
    FTypeName      :String;
    Win32FindData  :PWin32FindData;
    FEditName      :String;
    {$ifdef VCL_4_USED}
    FHint          :TElFString;
    {$endif}
    function GetAttrAsString: String;
    function GetCanRename: Boolean;
    function GetComment: String;
    function GetCreationTime: TDateTime;
    function GetDisplayName: String;
    function GetFileName: String;
    function GetFullName: String;
    function GetIsFileObject: Boolean;
    function GetIsFolder: Boolean;
    function GetIsRemovable: Boolean;
    function GetLastAccessTime: TDateTime;
    function GetModificationTime: TDateTime;
    function GetSize: Cardinal;
    function GetSizeAsString: String;
    function GetTypeName: String;
    procedure SetDisplayName(const Value: String);
    procedure CheckWin32FindData;
    procedure GetWin32Data(const ParentFolder: IShellFolder);
    procedure Invalidate;
    procedure GetAttributes(const iParentFolder: IShellFolder);
    {$ifdef VCL_4_USED}
    function GetHintText(const ParentFolder: IShellFolder): TElFString;
    {$endif}
    function GetPicture(const ParentFolder: IShellFolder): Integer;
    function GetEditName: String;
    procedure SetEditName(const Value: String);
    procedure ClearData(bRelease:Boolean);
  public
    constructor Create(AOwner: TCustomElTree); override;
    destructor Destroy; override;
    function BuildFullPIDL: PItemIDList;
    function IsExists:Boolean;

    property Attr: TShellAttr read FAttr;
    property CanRename: Boolean read GetCanRename;
    property Comment: String read GetComment;
    property CreationTime: TDateTime read GetCreationTime;
    property DisplayName: String read GetDisplayName write SetDisplayName;
    property FileName: String read GetFileName;
    property FullName: String read GetFullName;
    property IsFileObject: Boolean read GetIsFileObject;
    property IsFolder: Boolean read GetIsFolder;
    property IsRemovable: Boolean read GetIsRemovable;
    property LastAccessTime: TDateTime read GetLastAccessTime;
    property ModificationTime: TDateTime read GetModificationTime;
    property PIDL: PItemIDList read FPIDL;
    property SizeAsString: String read GetSizeAsString;
    property EditName: String read GetEditName write SetEditName;
  published
    property AttrAsString: String read GetAttrAsString;
    property Size: Cardinal read GetSize;
    property TypeName: String read GetTypeName;
  end;

  TShellListItemAddingEvent = procedure(Sender: TObject; ItemName: String;
                              ShellFolder: IShellFolder; RelPIDL: PItemIDList;
                              var Allowed: Boolean) of object;
  TShellListItemAddedEvent  = procedure(Sender: TObject; ItemName: String;
                              ShellFolder: IShellFolder; RelPIDL: PItemIDList;
                              Item: TElShellListItem) of object;

  TElShellList = class(TCustomElTree)
  private
    FAttr                :TShellAttr;
    FAutoNavigate        :Boolean;
    FAutoExecute         :Boolean;
  protected
    FEditor              :TElTreeInplaceEdit;
    FCustomFolder        :String;
    FDefaultColumns      :Boolean;
    FFocusedPIDL         :PItemIDList;
    FHighlightCompressed :Boolean;
    FFolder              :TShellFolders;
    FShowHidden          :Boolean;
    FShowFolders         :Boolean;
    FSizeFormat          :TElShellSizeFormat;
    FSortModifiers       :TElShellSortModifiers;
    FSortType            :TElShellSortType;
    FUseSystemMenus      :Boolean;
    FIFolder             :IShellFolder;
    FMaxColumns          :Integer;
    FFileSystemOnly      :Boolean;
    FFileFilters         :TStringList;
    FShowFiles           :Boolean;
    {$ifndef B_4}
    FFileMasks           :TList;
    {$endif}
    FFileFiltered        :Boolean;
    FOnFilterItem        :TShellListItemAddingEvent;
    FOnItemAdded         :TShellListItemAddedEvent;
    FDefaultEditor       :Boolean;
    FRootPIDL            :PItemIDList;
    FSaveShowHeader      :Boolean;
    FShellTreeView       :TElShellTree;
    FShellComboBox       :TElShellComboBox;
    fIsSyncControls      :Boolean;
    fOnInvokeVerbCommand :TInvokeVerbCommand;
    fOnRootChanged       :TNotifyEvent;
    fOnAddColumn         :TAddColumnEvent;
    procedure SetShowHeader(value: Boolean); override;
    procedure SetCustomFolder(const Value: String);
    procedure SetDefaultColumns(Value: Boolean);
    function GetFocusedDisplayName: String;
    function GetFocusedPIDL: PItemIDList;
    function GetItemFocused: TElShellListItem;
    procedure SetHighlightCompressed(Value: Boolean);
    procedure SetItemFocused(const Value: TElShellListItem);
    procedure SetFolder(Value: TShellFolders);
    procedure SetShowFiles(Value: Boolean);
    // woland added
    procedure SetShowFolders(const Value: Boolean); // auto update on shell change notified
    procedure SetShowHidden(Value: Boolean);
    procedure SetSizeFormat(Value: TElShellSizeFormat);
    procedure SetSortModifiers(Value: TElShellSortModifiers);
    procedure SetSortType(Value: TElShellSortType);
    procedure SetPIDL(PIDL: PItemIDList);
    procedure AddDefaultColumns;
    function DeleteDefaultColumns: Integer;
    procedure TriggerSortBegin; override;
    procedure TriggerTryEditEvent(Item: TElTreeItem; SectionIndex: Integer; var
        CellType: TElFieldType; var CanEdit: Boolean); override;
    procedure TriggerVirtualTextNeeded(Item: TElTreeItem; SectionIndex: Integer;
        var Text: TElFString); override;
    procedure TriggerVirtualValueNeeded(Item: TElTreeItem; SectionIndex: Integer;
        VarType: Integer; var Value: Variant); override;
    procedure SetFileSystemOnly(Value: Boolean);
    function FindItemByPIDL(APIDL: PItemIDList): TElShellListItem;
    function NameFiltered(const S: String; const ShellFolder: IShellFolder;
      RelPIDL: PItemIDList): Boolean; virtual;
    function GetFileFilters: TStrings;
    procedure SetFileFiltered(const Value: Boolean);
    procedure SetFileFilters(const Value: TStrings);
    procedure FileFiltersChange(Sender: TObject);
    procedure CreateHandle; override;
    function CreateItems: TElTreeItems; override;
    function CreateView: TElTreeView; override;
    procedure DoCompareItems(Item1, Item2: TElTreeItem; var res: Integer); override;
    {$ifdef VCL_4_USED}
    procedure TriggerVirtualHintNeeded(Item: TElTreeItem; var Hint: TElFString); override;
    {$endif}
    function DoGetPicture(Item: TElTreeItem): Integer; override;
    procedure DoItemAdded(const S: String; const ShellFolder: IShellFolder;
      RelPIDL: PItemIDList; Item : TElShellListItem); virtual;
    procedure SetShellTreeView(Value: TElShellTree);
    procedure SetShellComboBox(Value: TElShellComboBox);
    procedure SyncControls(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnBeforeOperation(Sender: TObject; var DefaultConversion: Boolean);
    procedure OnValidateEdit(Sender: TOBject; var InputValid: Boolean);
    procedure TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer;
        SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor); override;
    property Items stored False;
    procedure DefineProperties(Filer: TFiler); override;

    procedure MouseLButtonDblClickExt(X, Y: Integer; Shift: TShiftState);
    procedure MouseLButtonDblClickItem(Item: TElShellListItem; Shift: TShiftState);
    procedure KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState); override;
    procedure KeyPressTransfer(Sender: TObject; var Key: Char); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function RefreshList(bReload:Boolean):Boolean;
    function SetRootPIDL(PIDL: PItemIDList):Boolean;
    function SetSelectionPIDL(PIDL: PItemIDList):Boolean;
    function BuildRootPIDL: PItemIDList;
    procedure BackToParentPIDL;
    procedure SynclShellComboBox(ShellComboBox: TElShellComboBox);
    procedure SynclShellTree(ShellTree: TElShellTree);
    procedure SyncShellList(ShellList: TElShellList);
    property FocusedDisplayName: String read GetFocusedDisplayName;
    property FocusedPIDL: PItemIDList read GetFocusedPIDL;
    property ItemFocused: TElShellListItem read GetItemFocused write SetItemFocused;
    property RootPIDL: PItemIDList read FRootPIDL;
  published
    // Navigation and Linking properties:
    property AutoNavigate: Boolean read FAutoNavigate write FAutoNavigate default True;
    property AutoExecute: Boolean read FAutoExecute write FAutoExecute default False;
    property OnInvokeVerbCommand :TInvokeVerbCommand read fOnInvokeVerbCommand
      write fOnInvokeVerbCommand;
    property ShellTreeView: TElShellTree read FShellTreeView write SetShellTreeView;
    property ShellComboBox: TElShellComboBox read FShellComboBox write SetShellComboBox;

    property CustomFolder: String read FCustomFolder write SetCustomFolder;
    property DefaultColumns: Boolean read FDefaultColumns write SetDefaultColumns default False;
    property HighlightCompressed: Boolean read FHighlightCompressed write
        SetHighlightCompressed default True;
    property Folder: TShellFolders read FFolder write SetFolder default sfoDesktop;
    property ShowHidden: Boolean read FShowHidden write SetShowHidden default True;
    property SizeFormat: TElShellSizeFormat read FSizeFormat write SetSizeFormat default ssfAsIs;
    property SortModifiers: TElShellSortModifiers read FSortModifiers write
        SetSortModifiers default [ssmFoldersFirst,ssmExecutablesFirst];
    property SortType: TElShellSortType read FSortType write SetSortType default sstDefault;

    property UseSystemMenus: Boolean read FUseSystemMenus write FUseSystemMenus default False;
    property ShowFiles: Boolean read FShowFiles write SetShowFiles default True;
    property ShowFolders: Boolean read FShowFolders write SetShowFolders default True;
    property FileSystemOnly: Boolean read FFileSystemOnly write SetFileSystemOnly default False;
    property FileFiltered:Boolean read FFileFiltered write SetFileFiltered default False;
    property FileFilters: TStrings read GetFileFilters write SetFileFilters;
    property OnItemAdded: TShellListItemAddedEvent read FOnItemAdded write
        FOnItemAdded;
    property OnItemAdding: TShellListItemAddingEvent read FOnFilterItem write
        FOnFilterItem;
    property DefaultEditor: Boolean read FDefaultEditor write FDefaultEditor default True;
    property OnRootChanged: TNotifyEvent read fOnRootChanged write fOnRootChanged;
    property OnAddColumn: TAddColumnEvent read fOnAddColumn write fOnAddColumn;
    // inherited properties:
    property ActiveBorderType;
    property Align;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
    //property AutoExpand; !!! do not publish it.
    property AutoLineHeight;
    property AutoLookup;
    property AutoResizeColumns;

    property DefaultSectionWidth;
    property AdjustMultilineHeight;
    property Background;
    property BackgroundType;

    property BarStyle;
    property BarStyleVerticalLines;
    property BorderSides;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DeselectChildrenOnCollapse;
    property DblClickMode;
    property DoInplaceEdit;
    property DragAllowed;
    property DragCursor;
    property DragExpandDelay;
    property DraggableSections;
    property DrawFocusRect;
    property DragImageMode;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;

    property ExpandOnDragOver;
    property ExplorerEditMode default True;
    property Flat;
    property FlatFocusedScrollbars;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property ForcedScrollBars;
    property Font stored True;
    property FullRowSelect;
    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;

    property HeaderActiveFilterColor;
    property HeaderColor;
    property HeaderHeight;
    property HeaderHotTrack;
    property HeaderInvertSortArrows;
    property HeaderSections;
    property HeaderFilterColor;
    property HeaderFlat;
    property HeaderFont;
    property HeaderUseTreeFont;
    property HeaderImages;
    property AlphaForHeaderImages;
    property HeaderWrapCaptions;
    property HideFocusRect;
    property HideHintOnTimer;
    property HideHintOnMove;
    property HideSelectColor;
    property HideSelectTextColor;
    property HideSelection;
    property HideHorzScrollBar;
    property HideVertScrollBar;
	property HighlightAlphaLevel;
    property HintType;
    property HorizontalLines;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property HeaderImageForm;
    property ImageForm;
    {$endif}
    property InactiveBorderType;
    property IncrementalSearch;
    property InplaceEditorDelay;
    property ItemIndent;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property LineHeight;
    property LinesColor;
    property LinesStyle;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LockHeaderHeight;
    property MainTreeColumn;
    property MinusPicture;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MouseFrameSelect;
    property MultiSelect;
    property MultiSelectLevel;
    property OwnerDrawByColumn default True;
    property OwnerDrawMask;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property QuickEditMode;

    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowHotTrack;
    property RowSelect;

    property ScrollbarOpposite;
    property HorzScrollTracking;
    property VertScrollTracking;
    property SelectColumn;
    property ShowButtons default True;
    property ShowColumns;
    property ShowCheckboxes;
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines default False;
    property ShowRoot default False;
    property ShowRootButtons default False;
    property SelectionMode;
    property SortDir;
    property SortMode;
    property Storage;
    property StoragePath;
    property StickyHeaderSections;
    property StripedOddColor;
    property StripedEvenColor;
    property StripedItems;

    property Tracking;
    property TrackColor;
    property UnderlineTracked;
    property UseCustomScrollBars;

    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property UseSystemHintColors;
    property TextColor;
    property BkColor;

    property OnScroll;
    property OnHeaderColumnClick;
    property OnHeaderColumnDraw;
    property OnHeaderColumnResize;
    property OnHeaderColumnMove;
    property OnHeaderLookup;
    property OnHeaderLookupDone;
    property OnHeaderResize;
    property OnHeaderSectionExpand;
    property OnHeaderSectionCollapse;
    property OnHeaderSectionFilterCall;
    property OnHeaderSectionAutoSize;
    property OnHeaderSectionMeasure;
    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;

    property OnAfterSelectionChange;
    property OnChanging;
    property OnDragTargetChange;
    property OnItemChange;
    property OnItemPreDraw;
    property OnItemDraw;
    {$ifndef VER3_EDITORS}
    {$ifdef ELTREE_USE_INPLACE_EDITORS}
    property OnTryEdit;
    property OnEditRequest;
    property OnComboEditShow;
    property OnValidateCombo;
    property OnValidateInplaceEdit;
    property OnTuneUpInplaceEdit;
    property OnEditKeyDown;
    {$endif ifdef ELTREE_USE_INPLACE_EDITORS}
    {$else}
    property OnInplaceEditorNeeded;
    {$endif ifndef VER3_EDITORS}
    property OnItemChecked;
    property OnItemExpand;
    property OnItemCollapse;
    property OnItemExpanding;
    property OnItemCollapsing;
    property OnItemDeletion;
    property OnItemFocused;
    property OnShowLineHint;
    property OnCompareItems;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnItemPostDraw;
    property OnHotTrack;
    property OnMeasureItemPart;
    property OnSortBegin;
    property OnSortEnd;
    property OnItemSave;
    property OnItemLoad;
    property OnItemSelectedChange;
    property OnCellStyleSave;
    property OnCellStyleLoad;
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;
    {$IFDEF HAS_HTML_RENDER}
    property OnHTMLImageNeeded;
    {$ENDIF}
    property OnVirtualTextNeeded;
    property OnVirtualHintNeeded;
    property OnVirtualValueNeeded;
    {$ifdef ELTREE_USE_STYLES}
    property OnVirtualStyleNeeded;
    {$endif}

    property OnHeaderMouseDown;

    {$ifdef ELTREE_USE_OLE_DRAGDROP}
    {$IFNDEF VER90}
    property OnOleTargetDrag;
    property OnOleTargetDrop;
    property OnOleDragStart;
    property OnOleDragFinish;
    {$ENDIF}
    {$endif}

    // VCL properties
    {$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    {$ENDIF}
    property BorderStyle;

    property Ctl3D;
    property Cursor;
    property Enabled;
    property Hint;

    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;

    property Visible;
    property TabOrder;
    property TabStop;

    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnResize;
    {$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
    {$ENDIF}
    {$IFDEF VCL_5_USED}
    property OnContextPopup;
    {$ENDIF}
  end;

const
  siBase      = 1458;
  siMin       = 0;
  siName      = 0;
  siSize      = 1;
  siType      = 2;
  siModified  = 3;
  siAttr      = 4;
  siComment   = 5;
  siCreated   = 6;
  siAccessed  = 7;
  siMax       = 7;

const
  DefaultColumnNames: array[siMin..siMax] of String = (
    'Name',
    'Size',
    'Type',
    'Modified',
    'Attributes',
    'Comment',
    'Created',
    'Accessed'
  );

  DefaultColumnAlignments: array[siMin..siMax] of Integer = (
    LVCFMT_LEFT,
    LVCFMT_RIGHT,
    LVCFMT_LEFT,
    LVCFMT_LEFT,
    LVCFMT_LEFT,
    LVCFMT_LEFT,
    LVCFMT_LEFT,
    LVCFMT_LEFT
  );

  ColumnSortTypes: array[siMin..siMax] of TElShellSortType = (
    sstName,
    sstSize,
    sstCustom,
    sstModifyDate,
    sstCustom,
    sstCustom,
    sstCreationDate,
    sstAccessDate
  );

  cExecutableExtensionsWin9X = '.EXE'#13'.DLL'#13'.BAT'{#13'.VBS'#13'.JS'};
  cExecutableExtensionsWinNTUp = cExecutableExtensionsWin9X+#13'.CMD';

var

  ExecutableExtensions :String;

{$IFDEF VCL_3_USED}
const
  {$IFDEF B_3}
  {$EXTERNALSYM SFGAO_BROWSABLE}
  {$ENDIF}
  SFGAO_BROWSABLE = $08000000;
{$ENDIF}

implementation

const
  cShellNullStr :String = '-';

type

  TElShellDefaultColumns = class(TInterfacedObject, IShellDetails)
    function GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var pDetails: TShellDetails): HResult; stdcall;
    function ColumnClick(iColumn: UINT): HResult; stdcall;
  end;

  TElShellTreeView = class(TElTreeView)
  private
    iCtxMenu     :iContextMenu;
    FBuiltinMenu :HMENU;
    FMenuWnd     :HWND;
    procedure MenuWndProc(var Message: TMessage);
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ShowSystemMenu(X, Y: Integer; Item: TElShellTreeItem);
    function GetPopupMenu: TPopupMenu; override;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TElShellListView = class(TElTreeView)
  private
    iCtxMenu     :iContextMenu;
    FBuiltinMenu :HMENU;
    FMenuWnd     :HWND;
    procedure MenuWndProc(var Message: TMessage);
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ShowSystemMenu(X, Y: Integer; Item: TElShellListItem);
    function GetPopupMenu: TPopupMenu; override;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TElShellComboEdit = class(TElAdvancedMemo)
  protected
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  end;

  PElShellComboData = ^TElShellComboData;
  TElShellComboData = record
    Level       :Integer;
    DisplayName :String;
    FileName    :String;
    PIDL        :PItemIDList;
    IconIdx     :Integer;
    OpenIconIdx :Integer;
    Attr        :Integer;
  end;

const

  SHGDN_FOREDITING  = $1000;     { for in-place editing text }

  cSFGAO_FLAGS      = SFGAO_FOLDER or SFGAO_HASSUBFOLDER or
                      SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR or
                      SFGAO_COMPRESSED or SFGAO_GHOSTED or
                      SFGAO_CANRENAME or SFGAO_REMOVABLE or
                      SFGAO_LINK;

{ TElShellComboEdit }

procedure TElShellComboEdit.DoExit;
begin
  inherited;
  TElShellComboBox(Parent).CancelEdit;
end;

procedure TElShellComboEdit.KeyPress(var Key: Char);
begin
  if Key = Char(VK_ESCAPE) then
  begin
    TElShellComboBox(Parent).CancelEdit;
    Key:= #0;
    exit;
  end;
  if Key = Char(VK_RETURN) then
  begin
    TElShellComboBox(Parent).AcceptEdit;
    Key:= #0;
    exit;
  end;

  if Key in [Char(VK_UP), Char(VK_DOWN), Char(VK_PRIOR), Char(VK_NEXT), #10] then
  begin
    Key := #0;
    exit;
  end
  else
  if Key = Char(VK_ESCAPE) then
  begin
    Key := #0;
  end;
  inherited;
end;

procedure TElShellComboEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    TElShellComboBox(Parent).AcceptEdit;
    Key:= 0;
  end;
  if Key = VK_ESCAPE then
  begin
  end;
  inherited;
end;

{ TElShellDefaultColumns }

function TElShellDefaultColumns.GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var pDetails: TShellDetails): HResult;
begin
  if (PIDL <> nil) or (not InRange(siMin, siMax, iColumn)) then
    Result := E_NOTIMPL
  else
  begin
    pDetails.fmt := DefaultColumnAlignments[iColumn];
    pDetails.str.uType := STRRET_CSTR;
    StrPCopy(pDetails.str.cStr, DefaultColumnNames[iColumn]);
    Result := S_OK;
  end;
end;

function TElShellDefaultColumns.ColumnClick(iColumn: UINT): HResult;
begin
  Result := E_NOTIMPL;
end;

{ TElShellTree }

function TElShellTree.GetRootFolder: TShellFolders;
begin
  Result:= FRootFolder;
end;

procedure TElShellTree.SetRootFolder(Value: TShellFolders);
  var
    PIDL :PItemIDList;
begin
  if FRootFolder <> Value then
  begin
    {if (FRootFolder = sfoCustom) and (Length(CustomRootFolder)=0) and
       (not (csLoading in ComponentState))
    then
      Value := sfoDesktop;{}
    PIDL := GetFolderPIDL(Value, CustomRootFolder);
    if SetRootPIDL(PIDL) then
    begin
      FRootFolder := Value;
      if ( (FRootFolder = sfoDesktopExpanded) or ExpandRoot ) and (Items.Count>0) then
        TElShellTreeItem(Items[0]).Expanded := True;
    end;
    FreeIDList(PIDL);
  end;
end;

function TElShellTree.GetFocusedPIDL: PItemIDList;
begin
  if ItemFocused <> nil then
    Result := TElShellTreeItem(ItemFocused).BuildFullPIDL
  else
    Result := nil;
end;

function TElShellTree._GetFocusedPIDL: PItemIDList;
begin
  if ItemFocused <> nil then
    Result := TElShellTreeItem(ItemFocused).FullPIDL
  else
    Result := nil;
end;

function TElShellTree.GetFocusedDisplayName: String;
  var
    PIDL :PItemIDList;
begin
  PIDL := _GetFocusedPIDL;
  if (PIDL <> nil) and (GetPathFromPIDL(PIDL, Result)) then
  else
    SetLength(Result,0);
end;

procedure TElShellTree.BuildTree;
  var
    sCursor        :TCursor;
    SaveIsUpdating :Boolean;
begin
  sCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  SaveIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  try
    Items.Clear;
    RefreshTree(nil, 0);
  finally
    if IsUpdating <> SaveIsUpdating then
      IsUpdating := SaveIsUpdating;

  if Screen.Cursor <> sCursor then
    Screen.Cursor := sCursor;
  end;
end;

function TElShellTree.SetRootPIDL(PIDL: PItemIDList):Boolean;
  var
    iFolder     :IShellFolder;
    hRes        :HRESULT;
    OLDRootPIDL :PItemIDList;
    OLDFolder   :TShellFolders;
begin
  Result := CompareIDLists(FRootPIDL, PIDL);
  if Result then
    exit;

  OLDRootPIDL := FRootPIDL;
  OLDFolder   := FRootFolder;

  if Assigned(PIDL) then
    FRootPIDL := ClonePIDL(PIDL)
  else
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      if Assigned(FRootPIDL) then
      begin
        FreeIDList(FRootPIDL);
        FIFolder  := nil;
      end;
    finally
      Items.EndUpdate;
    end;
    SyncControls(nil);
    if Assigned(OnRootChanged) then
      OnRootChanged(Self);
    Result := True;
    exit;
//    FRootPIDL := GetEmptyPIDL;
  end;

  ReleaseFocusedPIDL;

  iFolder := GetDesktopFolder;

  if (CalcPIDLSize(PIDL) <> 2) and
     ((FRootFolder = sfoDesktop)or(FRootFolder = sfoDesktopExpanded))
  then
    FRootFolder := sfoCustom
  else
  if (CalcPIDLSize(PIDL) = 2) and
     (FRootFolder <> sfoDesktop) and (FRootFolder <> sfoDesktopExpanded)
  then
    FRootFolder := sfoDesktop;

  try

    if (RootFolder <> sfoDesktop) and (RootFolder <> sfoDesktopExpanded) and
       (CalcPIDLSize(PIDL) <> 2)
    then
    begin
      FIFolder := nil;
      hRes := iFolder.BindToObject(FRootPIDL, nil, IID_IShellFolder, Pointer(FIFolder));
      if not SUCCEEDED(hRes) then
        raise Exception.Create('Failed to get IShellFolder for specified root');
    end
    else
      FIFolder := iFolder;

    BuildTree;

    if OLDRootPIDL <> nil then
      FreeIDList(OLDRootPIDL);

    SyncControls(nil);

    if Assigned(OnRootChanged) then
      OnRootChanged(Self);

    Result := True;

  except
    on E:EAbort do
    else
    begin
      FRootFolder := OLDFolder;
      try
        if OLDRootPIDL <> nil then
          try
            SetRootPIDL(OLDRootPIDL);
          except
          end;
      finally
        if OLDRootPIDL <> nil then
          FreeIDList(OLDRootPIDL);
      end;
    end;
  end;
end;

procedure TElShellTree.BeginUpdate;
begin
  items.BeginUpdate;
end;

procedure TElShellTree.EndUpdate;
begin
  items.EndUpdate;
end;

procedure TElShellTree.Paint;
begin
   if Assigned(FRootPIDL)and Assigned(Items)and(Items.Count=0) then
   begin
     BuildTree;
     SyncControls(nil);
//    if Assigned(OnRootChanged) then
//      OnRootChanged(Self);
   end;
  inherited Paint;
end;

constructor TElShellTree.Create(AOwner: TComponent);
begin
  inherited;
  FAutoNavigate := True;
  Images := ShellIconCache.SmallImages;
  VirtualityLevel := vlTextAndStyles;
  FHeader.InvertSortArrows := True;
  FRootFolder  := sfoDesktop;
  FShowHidden  := True;
  FFileFilters := TStringList.Create;
  FFileFilters.OnChange := FileFiltersChange;
  FSortType := sstDefault;
  FSortMode := smAddClick;
  FSortModifiers := [ssmFoldersFirst, ssmExecutablesFirst];
  FHighlightCompressed := True;
  FClearOnCollapse := True;
  FDefaultEditor := True;

  FEditor := TElTreeInplaceEdit.Create(nil);
  FEditor.OnBeforeOperation := OnBeforeOperation;
  FEditor.OnValidateResult := OnValidateEdit;
  ExplorerEditMode := True;
  ShowEmptyImages := True;
  inherited SortType := stCustom;
  MultiSelect := False;
end;

procedure TElShellTree.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ShowEmptyImages', FakeBoolean, nil, False);
    Filer.DefineProperty('FilteredVisibility', FakeBoolean, nil, False);
    Filer.DefineProperty('MultiSelect', FakeBoolean, nil, False);
    Filer.DefineProperty('MultiSelectLevel', FakeInteger, nil, False);
    Filer.DefineProperty('AutoUpdate', FakeBoolean, nil, False);
  end;
end;

procedure TElShellTree.MouseLButtonDblClickExt(X, Y: Integer; Shift: TShiftState);
  var
    Item     :TElShellTreeItem;
    ItemPart :TSTItemPart;
    HCol     :Integer;
begin
  if FAutoNavigate then
  begin
    HCol := 0;
    Item := TElShellTreeItem( GetItemAt(X, Y, ItemPart, HCol) );
    MouseLButtonDblClickItem(Item, Shift);
  end;
end;

procedure TElShellTree.MouseLButtonDblClickItem(Item: TElShellTreeItem; Shift : TShiftState);
  var
    SavePath :String;
begin
  if Assigned(Item) then
  with Item do
  begin
    if ssAlt in Shift then // <ALT> + [DblClick|RETURN]
      ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
        ParentFolder, 'properties')
    else
    if FAutoExecute then
    begin
      if (not IsFolder and (Shift=[])) or (isFolder and (ssCtrl in Shift)) then
      begin
        SetLength(SavePath, MAX_PATH);
        SetLength(SavePath, GetCurrentDirectory(MAX_PATH, PChar(SavePath)) );
        SetCurrentDirectory(PChar(GetPathFromPIDL2(FRootPIDL)));
        try
          ShellExecutePIDL(FullPIDL);
        finally
          SetCurrentDirectory(PChar(SavePath));
        end;
      end;
    end;
  end;
end;

procedure TElShellTree.KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited KeyDownTransfer(Sender, Key, Shift);

  if GetKeyState(VK_MENU) < 0 then
    Include(Shift, ssAlt);

  if FAutoNavigate then
    case Key of
      VK_DELETE: // todo: for all selected
        if not IsEditing then
        begin
         Key := 0;
         if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              TElShellTreeItem(ItemFocused.Parent).ParentFolder, 'delete');
        end;
      VK_F5:
        if not IsEditing then
        begin
          Key := 0;
          RefreshTree(nil, 1);
        end;
      VK_RETURN:
        if not IsEditing then
        begin
          Key := 0;
          MouseLButtonDblClickItem(ItemFocused, Shift);
        end;
      VK_BACK:
        if not IsEditing then
        begin
          Key := 0;
          if not (ssAlt in Shift) then
          begin
            if Assigned(ItemFocused) and Assigned(ItemFocused.Parent) then
            begin
              ItemFocused.Selected := False;
              SetSelectionPIDL( TElShellTreeItem(ItemFocused.Parent).FullPIDL);
            end;
          end;
        end;
    end;
end;

procedure TElShellTree.KeyPressTransfer(Sender: TObject; var Key: Char);
begin
  inherited KeyPress(Key);
  if FAutoNavigate then
    case Word(Key) of
      Word(^C):
        if not IsEditing then
        begin
         if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              TElShellTreeItem(ItemFocused.Parent).ParentFolder, 'copy');
          Key := #0;
        end;
      Word(^V):
        if not IsEditing then
        begin
          if Assigned(ItemFocused) and ((ItemFocused.FAttr and SFGAO_FOLDER)<>0) then
            // paste to current focused folder
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              TElShellTreeItem(ItemFocused.Parent).ParentFolder, 'paste');
          Key := #0;
        end;
      Word(^X):
        if not IsEditing then
        begin
         if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              TElShellTreeItem(ItemFocused.Parent).ParentFolder, 'cut');
          Key := #0;
        end;
    end;
end;

procedure TElShellTree.DoItemFocused;
begin
  inherited;
  SyncControls(nil);
end;

procedure TElShellTree.ReleaseFocusedPIDL;
begin
  if FFocusedPIDL <> nil then
    FreeIDList(FFocusedPIDL);
end;

procedure TElShellTree.SetCustomRootFolder(const Value: String);
  var
    PIDL                :PItemIDList;
begin
  if FCustomRootFolder <> Value then
  begin
    FCustomRootFolder := Value;
    if FRootFolder = sfoCustom then
    begin
      if Length(CustomRootFolder)=0 then
        SetRootFolder(sfoDesktop)
      else
      begin
        PIDL := GetFolderPIDL(sfoCustom, CustomRootFolder);
        SetRootPIDL(PIDL);
        FreeIDList(PIDL);
      end;
    end;
  end;
end;

function TElShellTree.CreateView: TElTreeView;
begin
  Result := TElShellTreeView.Create(Self);
end;  { CreateView }

function TElShellTree.CreateItems: TElTreeItems;
begin
  Result := inherited CreateItems;
  Result.ItemClass := TElShellTreeItem;
end;

destructor TElShellTree.Destroy;
  {$ifndef B_4}
  var
    i :Integer;
  {$endif}
begin
  FShellComboBox := nil;
  FShellListView := nil;

  FEditor.Free;
  FIFolder := nil;
  FFileFilters.Free;
  {$ifndef B_4}
  if Assigned(FFileMasks) then
  begin
    for i:=0 to FFileMasks.Count-1 do
      TMask(FFileMasks[i]).Free;
    FFileMasks.Free;
  end;
  {$endif}
  Items.Clear;
  if FFocusedPIDL <> nil then
    FreeIDList(FFocusedPIDL);
  if Assigned(FRootPIDL) then
    FreeIDList(FRootPIDL);

  inherited;
end;

procedure TElShellTree.RefreshTree(Item: TElTreeItem; Recursive: Integer);
  var
    RootItem       :TElShellTreeItem;
    AFolder        :IShellFolder;
    APIDL          :PItemIDList;
    chF            :IShellFolder;
    str            :TStrRet;
    S              :String;
    b              :Boolean;
    sCursor        :TCursor;
    SaveIsUpdating :Boolean;
begin
  if not HandleAllocated then
    exit;

  sCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  SaveIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  try
    if Item <> nil then
    begin
      // we are refreshing not from root, but from some intermediate item
      RootItem := TElShellTreeItem(Item);

      AFolder := GetDesktopFolder;
      if not IsDesktopPIDL(RootItem.PIDL) then
      begin
        APIDL := RootItem.FullPIDL;
        if not SUCCEEDED(AFolder.BindToObject(APIDL, nil, IID_IShellFolder, Pointer(chF))) then
        begin
          Items.DeleteItem(Item);
          exit;
        end;
        AFolder := nil;
        AFolder := chF;
      end;

      APIDL := ClonePIDL(RootItem.FPIDL);
      RootItem.Invalidate;
      FreeIDList(RootItem.FPIDL);
      RootItem.FPIDL := APIDL;
      RootItem.GetAttributes(AFolder);
    end
    else
    begin
      b := Items.Count = 0;
      // we are refreshing from root
      if Items.Count = 0 then
      begin
        RootItem := TElShellTreeItem(Items.AddItem(nil));
      end
      else
      begin
        RootItem := TElShellTreeItem(Items[0]);
        RootItem.Invalidate;
      end;

      if (FRootFolder <> sfoDesktop) and (FRootFolder <> sfoDesktopExpanded) then
      begin
        FreeIDList(RootItem.FPIDL);
        RootItem.FPIDL := ClonePIDL(GetOwnPIDL(FRootPIDL));
      end;
      AFolder := RootItem.GetParentFolder;

      RootItem.GetAttributes(AFolder);
      if (FRootFolder = sfoDesktopExpanded) or ExpandRoot then
        RootItem.Expanded := True;

      if b then
      begin
        ZeroMemory(@Str, SizeOf(Str));
        Str.uType := STRRET_CSTR;
        if SUCCEEDED(AFolder.GetDisplayNameOf(RootItem.PIDL, SHGDN_INFOLDER or SHGDN_FORADDRESSBAR,
          str)) then
        begin
          S := StrRetToPas(str, RootItem.PIDL);
          StrRetFree(str);
        end
        else
          SetLength(S, 0);
        DoItemAdded(S, AFolder, RootItem.FPIDL, TElShellTreeItem(RootItem));
      end;
    end;

    if RootItem.IsFolder then
    begin
      RootItem.ForceButtons := RootItem.HasSubFolders;
      if (CheckForChildren and (not RootItem.IsRemovable) and ((RootItem.FAttr and SFGAO_LINK)=0))
         or RootItem.Expanded
      then
      begin
        if SUCCEEDED(AFolder.BindToObject(RootItem.FPIDL, nil, IID_IShellFolder, Pointer(chF))) then
          CheckChildren(RootItem, chF);
      end
      else
        RootItem.ForceButtons := True;

      if RootItem.IsFolder and
           ((Recursive = 2) or ((Recursive = 1) and RootItem.Expanded)) then
        FillItemWithData(RootItem, AFolder, Max(Recursive, 1));
    end;
  finally
    if IsUpdating <> SaveIsUpdating then
      IsUpdating := SaveIsUpdating;
    if Screen.Cursor <> sCursor then
      Screen.Cursor := sCursor;
  end;
end;

function TElShellTree.CheckChildren(Item: TElTreeItem; const AFolder: IShellFolder): Boolean;
  var
    i     :TShellAttr;
    {$ifdef D_3}
    j     :Integer;
    {$else}
    j     :Cardinal;
    {$endif}
    FAttr :TShellAttr;
    List  :IEnumIDList;
    Flags :Cardinal;
    PIDL  :PItemIDList;
begin
  Flags := SHCONTF_FOLDERS;
  if ShowHidden then
    Flags := Flags or SHCONTF_INCLUDEHIDDEN;
  if ShowFiles then
    Flags := Flags or SHCONTF_NONFOLDERS;
  List := nil;

  if SUCCEEDED(AFolder.EnumObjects(0, Flags, List)) then
  begin
    j := 0;
    PIDL := nil;
    Result := False;

    while SUCCEEDED(List.Next(1, PIDL, j)) and (j > 0) do
    begin
      if FileSystemOnly then
      begin
        i := SFGAO_FOLDER or SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR;
        if SUCCEEDED(AFolder.GetAttributesOf(1, PIDL, i)) then
          FAttr := i
        else
          FAttr := 0;
        if ((FAttr and SFGAO_FOLDER)<>SFGAO_FOLDER) and // show all folders
           ((FAttr and SFGAO_FILESYSTEM) <> SFGAO_FILESYSTEM) and
           ((FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
        begin
          if PIDL <> nil then
            FreeIDList(PIDL);
          Continue;
        end;
      end;
      if PIDL <> nil then
        FreeIDList(PIDL);
      Result := True;
      break;
    end;
    Item.ForceButtons := Result;
  end
  else
    Result := False;
  List := nil;
end;

function TElShellTree.FillItemWithData(Item: TElShellTreeItem; const AFolder: IShellFolder;
  Recursive: Integer): Boolean;
  var
    i           :TShellAttr;
    {$ifdef D_3}
    j           :Integer;
    {$else}
    j           :Cardinal;
    {$endif}
    FAttr       :TShellAttr;
    List        :IEnumIDList;
    Flags       :TShellAttr;
    PIDL        :PItemIDList;
    Child       :TElShellTreeItem;
    S           :String;
    str         :TStrRet;
    chF         :IShellFolder;
    bObjVisible :Boolean;
    sCursor     :TCursor;
begin
  sCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  Flags := SHCONTF_FOLDERS;
  if ShowHidden then
    Flags := Flags or SHCONTF_INCLUDEHIDDEN;
  if ShowFiles then
    Flags := Flags or SHCONTF_NONFOLDERS;

  List := nil;
  // get enumerator to walk through object
  if SUCCEEDED(AFolder.EnumObjects(Handle, Flags, List)) then
  begin
    Result := True;
    Items.BeginUpdate; // Disable painting
    try

      j := 0;
      chF := nil;
      PIDL := nil;

      // invalidate all items. We will validate them as the shell provides right PIDLs
      // and then we'll remove all items, that will remain invalid
      i := 0;
      while i < TShellAttr(Item.Count) do
      begin
        TElShellTreeItem(Item.Children[i]).FValid := False;
        inc(i);
      end;

      // first grab all child PIDLs
      while SUCCEEDED(List.Next(1, PIDL, j)) and (j > 0) and (PIDL <> nil) do
      begin
        // Read some attributes for filtering:

        if FileSystemOnly then
          i := SFGAO_FOLDER or SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR
        else
          i := SFGAO_FOLDER or SFGAO_FILESYSTEM;

        if SUCCEEDED(AFolder.GetAttributesOf(1, PIDL, i)) then
          FAttr := i
        else
          FAttr := 0;

        if FileSystemOnly and
           ((FAttr and SFGAO_FOLDER)<>SFGAO_FOLDER) and // show all folders
           ((FAttr and SFGAO_FILESYSTEM) <> SFGAO_FILESYSTEM) and
           ((FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
        begin
          FreeIDList(PIDL);
          Continue;
        end;

        ZeroMemory(@Str, SizeOf(Str));
        Str.uType := STRRET_CSTR;
        if SUCCEEDED(AFolder.GetDisplayNameOf(PIDL, SHGDN_INFOLDER or SHGDN_FORADDRESSBAR,
          str)) then
        begin
          S := StrRetToPas(str, PIDL);
          StrRetFree(str);
        end
        else
          SetLength(S, 0);

        // Filtering of Enum Object:
        if ShowFiles then
        begin
          bObjVisible := ((FAttr and SFGAO_FOLDER)=SFGAO_FOLDER);// = ObjectIsFolder (show all folders)
          if (not bObjVisible) then // <=>: "if not ObjectIsFolder"
          begin
            if (FAttr and SFGAO_FILESYSTEM) <> 0 then // applyong FileSystem File Filter
            begin
              if ShowFiles and FileFiltered then
                bObjVisible := NameFiltered(S, AFolder, PIDL)
              else
                bObjVisible := True;
              end
            else
              bObjVisible := True;
          end;
        end
        else
          bObjVisible := True;

        if bObjVisible and FileFiltered and Assigned(OnItemAdding) then
          OnItemAdding(Self, S, AFolder, PIDL, bObjVisible);

        if bObjVisible then
        begin
          Child := Item.FindItemByPIDL(PIDL);
          if Child = nil then
          begin
            Child := TElShellTreeItem(Items.AddChild(Item, ''));
            FreeIDList(Child.FPIDL);
            Child.FPIDL := nil;
          end
          else
          begin
            Child.Invalidate;
            if Child.FPIDL <> nil then
              FreeIDList(Child.FPIDL);
          end;
          Child.FPIDL := PIDL;

          // Clear OLD FullPIDL.
          if Child.FFullPIDL <> nil then
            FreeIDList(Child.FFullPIDL);

          Child.GetAttributes(AFolder);

          if Child.IsFolder and
             ((Recursive = 2) or ((Recursive = 1) and Child.Expanded)) then
          begin
            if SUCCEEDED(AFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(chF))) then
              FillItemWithData(Child, chF, Max(Recursive, 1))
            else
              Child.Clear;
            chF := nil;
          end
          else
            Child.Clear;

          if Child.IsFolder then
          begin
            Child.ForceButtons := Child.HasSubFolders;
            if CheckForChildren and (not TElShellTreeItem(Child).IsRemovable)
               and ((TElShellTreeItem(Child).FAttr and SFGAO_LINK)=0)
            then
            begin
              if SUCCEEDED(AFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(chF))) then
                CheckChildren(Child, chF);
            end
            else
              Child.ForceButtons := True;
          end;
          Child.FValid := True;
          DoItemAdded(S, AFolder, PIDL, Child);
        end
        else
        begin
          Child := Item.FindItemByPIDL(PIDL);
          if Child <> nil then
            Items.DeleteItem(Child);
          FreeIDList(PIDL);
        end;
      end;

      // now check for invalid tree items and remove them
      i := 0;
      while i < TShellAttr(Item.Count) do
      begin
        if TElShellTreeItem(Item.Children[i]).FValid then
          inc(i)
        else
          Items.DeleteItem(Item.Children[i]);
      end;

      Item.Sort(False);

    finally
      Items.EndUpdate;
    end;
  end //of: if SUCCEEDED(AFolder.EnumObjects( ...
  else
    Result := False;

  List := nil;

  if Screen.Cursor <> sCursor then
    Screen.Cursor := sCursor;
end;

procedure TElShellTree.Loaded;
  var
    FRF :TShellFolders;
begin
  inherited;
  FRF := FRootFolder;
  FRootFolder := TShellFolders(Integer(FRF) - 1);
  SetRootFolder(FRF);
end;

procedure TElShellTree.SetShowHidden(Value: Boolean);
begin
  if FShowHidden <> Value then
  begin
    FShowHidden := Value;
    RefreshTree(nil, 1);
  end;
end;

procedure TElShellTree.SetShowFiles(Value: Boolean);
begin
  if FShowFiles <> Value then
  begin
    FShowFiles := Value;
    RefreshTree(nil, 1);
  end;
end;

procedure TElShellTree.SetHighlightCompressed(Value: Boolean);
begin
  if FHighlightCompressed <> Value then
  begin
    FHighlightCompressed := Value;
    RefreshTree(nil, 1);
  end;
end;

function TElShellTree.GetFileFilters: TStrings;
begin
  Result := FFileFilters;
end;

procedure TElShellTree.SetFileFiltered(const Value: Boolean);
begin
  if Value<>FFileFiltered then
  begin
    FFileFiltered := Value;
    if ShowFiles then
      RefreshTree(nil, 1);
  end;
end;

procedure TElShellTree.SetFileFilters(const Value: TStrings);
begin
  FFileFilters.Assign(Value);
end;

function TElShellTree.NameFiltered(const S: String; const ShellFolder: IShellFolder;
  RelPIDL: PItemIDList): Boolean;
  var
    i :Integer;
begin
  {$ifndef B_4}
  Result := (FFileMasks=nil);
  if not Result then
    for i:=0 to FFileMasks.Count-1 do
    begin
      if TMask(FFileMasks[i]).Matches(S) then
      begin
        Result := True;
        break;
      end;
    end;
  {$else}
    {$ifdef VCL_5_USED}
    Result := (FFileFilters.Count=0);
    if not Result then
      for i:=0 to FFileFilters.Count-1 do
      begin
        if FileNameLike( S, FFileFilters[i] ) then
        begin
          Result := True;
          break;
        end;
      end;
    {$else}
    Result := True;
    {$endif}
  {$endif}
end;

procedure TElShellTree.CreateHandle;
  var
    PIDL : PItemIDList;
begin
  inherited;
  PIDL := GetFolderPIDL(FRootFolder, CustomRootFolder);
  SetRootPIDL(PIDL);
  FreeIDList(PIDL);
end;

procedure TElShellTree.DoItemCollapse(Item: TElTreeItem);
begin
  inherited;
  if ClearOnCollapse then
  begin
    if Item.Count > 0 then
      Item.ForceButtons := True;
    if fIsSyncControls then
      Item.Clear
    else
    begin
      fIsSyncControls := True;
      Item.Clear;
      fIsSyncControls := False;
      SyncControls(nil);
    end;
  end;
end;

procedure TElShellTree.DoItemExpand(Item: TElTreeItem);
  var
    dFolder    :IShellFolder;
    iFolder    :IShellFolder;
    PIDL       :PItemIDList;
    SaveCursor :TCursor;
    b          :Boolean;
begin
  inherited;

  SaveCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  try
    dFolder := GetDesktopFolder;
    if Item.Count = 0 then
    begin
      PIDL := TElShellTreeItem(Item).PIDL;
      if IsDesktopPIDL(PIDL) then
      begin
        iFolder := dFolder;
        b := True;
      end
      else
      begin
        dFolder := TElShellTreeItem(Item).GetParentFolder;
        b := SUCCEEDED(dFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(IFolder)));
      end;
      if b then
        FillItemWithData(TElShellTreeItem(Item), iFolder, 0);
      iFolder := nil;
      dFolder := nil;
      Item.Sort(False);
    end;
  finally
    if Screen.Cursor <> SaveCursor then
      Screen.Cursor := SaveCursor;
  end;
end;

procedure TElShellTree.DoItemExpanding(Item: TElTreeItem; var CanProcess: Boolean);
  var
    dFolder :IShellFolder;
    iFolder :IShellFolder;
    PIDL    :PItemIDList;
    b       :Boolean;
begin
  inherited;
  if Item.Count = 0 then
  begin
    PIDL := TElShellTreeItem(Item).PIDL;
    dFolder := GetDesktopFolder;
    b := True;
    if IsDesktopPIDL(PIDL) then
      iFolder := dFolder
    else
    begin
      dFolder := TElShellTreeItem(Item).GetParentFolder;
      iFolder := nil;
      b := SUCCEEDED(dFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(iFolder)));
    end;
    CanProcess := False;
    Item.ForceButtons := False;

    if b and (TElShellTreeItem(Item).HasSubFolders or CheckChildren(Item, iFolder)) then
      CanProcess := True;

    iFolder := nil;
    dFolder := nil;
  end;
end;

procedure TElShellTree.DoItemAdded(const S: String; const ShellFolder: IShellFolder;
    RelPIDL: PItemIDList; Item: TElShellTreeItem);
begin
  if assigned(FOnItemAdded) then
    FOnItemAdded(Self, S, ShellFolder, RelPIDL, Item);
end;

procedure TElShellTree.SetFileSystemOnly(Value: Boolean);
begin
  if FFileSystemOnly <> Value then
  begin
    FFileSystemOnly := Value;
    if ShowFiles then
      RefreshTree(nil, 1);
  end;
end;

function TElShellTree.GetItemFocused: TElShellTreeItem;
begin
  Result := TElShellTreeItem(inherited ItemFocused);
end;

procedure TElShellTree.SetItemFocused(Value: TElShellTreeItem);
begin
  inherited ItemFocused := Value;
end;

procedure TElShellTree.DoCompareItems(Item1, Item2: TElTreeItem; var res: Integer);
  var
    S1, S2 :String;
    D1, D2 :TDateTime;
    B1, B2 :Boolean;
    I1, I2 :Cardinal;
    ShellItem1 :TElShellTreeItem absolute Item1;
    ShellItem2 :TElShellTreeItem absolute Item2;
begin
  if FSortType = sstCustom then
    inherited
  else
  begin

    if ssmFoldersFirst in SortModifiers then
    begin
      B1 := ShellItem1.IsFolder;
      B2 := ShellItem2.IsFolder;
      if B1 <> b2 then
      begin
        if b2 then
          res := 1
        else
          res := -1;
        exit;
      end
      else
      begin
        B1 := ShellItem1.IsFileObject;
        B2 := ShellItem2.IsFileObject;
        if B1 <> B2 then
        begin
          if b2 then
            res := 1
          else
            res := -1;
          exit;
        end;
      end;
    end;

    if ssmExecutablesFirst in SortModifiers then
    begin
      if (ShellItem1.IsFileObject and ShellItem2.IsFileObject) then
      begin
        B1 := ShellItem1.IsFolder;
        B2 := ShellItem2.IsFolder;
        if not (b1 or b2) then
        begin
          S1 := Uppercase(ExtractFileExt(ShellItem1.FileName));
          S2 := Uppercase(ExtractFileExt(ShellItem2.FileName));
          B1 := pos(S1, ExecutableExtensions)>0;
          B2 := pos(S2, ExecutableExtensions)>0;
          if B1 <> B2 then
          begin
            if B2 then
              res := 1
            else
              res := -1;
            exit;
          end;
        end;
      end;
    end;

    if FSortType = sstDefault then
    begin
      res := SmallInt(ShellItem1.ParentFolder.CompareIDs(0, ShellItem1.FPIDL, ShellItem2.FPIDL));
      exit;
    end;

    if ((ShellItem1.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) <>
       ((ShellItem2.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
    begin
      if (ShellItem1.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR then
        res := 1
      else
        res := -1;
      exit;
    end;

    case FSortType of
      sstName:
        begin
          S1 := ShellItem1.FileName;
          S2 := ShellItem2.FileName;
          res := AnsiStrIComp(PChar(S1), PChar(S2));
        end;
      sstSize:
        begin
          I1 := ShellItem1.Size;
          I2 := ShellItem2.Size;
          if I1 > I2 then
            res := 1
          else
          if I1 < I2 then
            res := -1
          else
          if I1 = I2 then
            res := 0;
        end;
      sstCreationDate,
      sstModifyDate,
      sstAccessDate:
        begin
          case FSortType of
            sstModifyDate:
              begin
                D1 := ShellItem1.ModificationTime;
                D2 := ShellItem2.ModificationTime;
              end;
            sstAccessDate:
              begin
                D1 := ShellItem1.LastAccessTime;
                D2 := ShellItem2.LastAccessTime;
              end;
            else
              begin
                D1 := ShellItem1.CreationTime;
                D2 := ShellItem2.CreationTime;
              end;
          end;
          if D1 > D2 then
            res := 1
          else
          if D1 < D2 then
            res := -1
          else
          if D1 = D2 then
            res := 0;
        end;
      sstExt:
        begin
          S1 := ExtractFileExt(ShellItem1.FileName);
          S2 := ExtractFileExt(ShellItem2.FileName);
          res := AnsiStrIComp(PChar(S1), PChar(S2));
        end;
    end;
  end;
end;

procedure TElShellTree.SetSortType(Value: TElShellSortType);
begin
  if FSortType <> Value then
  begin
    FSortType := Value;
    if SortMode in [smAdd, smAddClick] then
      Sort(True);
  end;
end;

procedure TElShellTree.SetSortModifiers(Value: TElShellSortModifiers);
begin
  if FSortModifiers <> Value then
  begin
    FSortModifiers := Value;
    if SortMode in [smAdd, smAddClick] then
      Sort(True);
  end;
end;

procedure TElShellTree.TriggerVirtualTextNeeded(Item: TElTreeItem; SectionIndex: Integer;
  var Text: TElFString);
  var
    Index :Integer;
begin
  if (SectionIndex <> -1) and (HeaderSections.Count > SectionIndex) then
    Index := HeaderSections[SectionIndex].Tag - siBase
  else
    Index := siName;

  begin
    SetLength(Text, 0);
    case Index of
      siName: Text := TElShellTreeItem(Item).DisplayName;
      siSize:
        if TElShellTreeItem(Item).IsFileObject and (not TElShellTreeItem(Item).IsFolder) then
          Text := TElShellTreeItem(Item).SizeAsString;
      siType:
        if TElShellTreeItem(Item).IsFileObject then
          Text := TElShellTreeItem(Item).TypeName;
      siModified:
        if TElShellTreeItem(Item).IsFileObject and TElShellTreeItem(Item).FIsValidFile then
          Text := DateTimeToStr(TElShellTreeItem(Item).ModificationTime);
      siAttr:
        if TElShellTreeItem(Item).IsFileObject and TElShellTreeItem(Item).FIsValidFile then
          Text := TElShellTreeItem(Item).AttrAsString;
      siComment:
        if not TElShellTreeItem(Item).IsFileObject then
          Text := TElShellTreeItem(Item).Comment;
      siCreated:
        if TElShellTreeItem(Item).IsFileObject and TElShellTreeItem(Item).FIsValidFile then
          Text := DateTimeToStr(TElShellTreeItem(Item).CreationTime);
      siAccessed:
        if TElShellTreeItem(Item).IsFileObject and TElShellTreeItem(Item).FIsValidFile then
          Text := DateTimeToStr(TElShellTreeItem(Item).LastAccessTime);
      else
        inherited;
    end;
  end;
end;

procedure TElShellTree.SetSizeFormat(Value: TElShellSizeFormat);
  var
    i :Integer;
begin
  if FSizeFormat <> Value then
  begin
    FSizeFormat := Value;
    for i := 0 to FALlList.Count - 1 do
      TElShellTreeItem(FAllList[i]).FSizeAsString := cShellNullStr;
    Invalidate;
  end;
end;

procedure TElShellTree.SetDefaultColumns(Value: Boolean);
  var
    MainTreeCol :Integer;
begin
  if FDefaultColumns <> Value then
  begin
    FDefaultColumns := Value;
    MainTreeCol := DeleteDefaultColumns;
    if FDefaultColumns then
    begin
      if not (ComponentState * [csLoading, csDesigning] = []) then
        AddDefaultColumns;
      FMainTreeCol := MainTreeCol;
    end;
  end;
end;

procedure TElShellTree.AddDefaultColumns;
  var
    i              :Integer;
    dFolder        :IShellFolder;
    IFolder        :IShellFolder;
    IFolder2       :IShellFolder2;
    IDetails       :IShellDetails;
    sd             :TShellDetails;
    PIDL           :PItemIDList;
    hres           :HResult;
    SaveIsUpdating :Boolean;
begin
  SaveIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  try

    dFolder := GetDesktopFolder;
    SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL);
    dFolder.BindToObject(PIDL, nil, IID_ISHELLFOLDER, Pointer(iFolder));

    if not SUCCEEDED(iFolder.CreateViewObject(Handle, IShellDetails, Pointer(IDetails))) then
    begin
      if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
      begin
        IDetails := TElShellDefaultColumns.Create as IShellDetails;
      end;
    end;

    i := 0;
    repeat
      if IFolder2 <> nil then
        hRes := IFolder2.GetDetailsOf(nil, i, SD)
      else
        hRes := IDetails.GetDetailsOf(nil, i, SD);
      if hRes = S_OK then
      begin
        with HeaderSections.InsertSection(i) do
        begin
          Text := StrRetToPas(SD.str, nil);
          StrRetFree(SD.str);
          AutoSize := False;
          FieldType := sftCustom;
          Editable := i = siName;
          Visible := InRange(siMin, siMax, i);
          Tag := siBase + i;
          if Assigned(fOnAddColumn) then
            fOnAddColumn(Self, i);
        end;
      end;
      inc(i);
    until hRes <> S_OK;
    FMaxColumns := i - 1;

    AutoSizeAllColumns;

  finally
    if IsUpdating <> SaveIsUpdating then
      IsUpdating := SaveIsUpdating;
  end;
end;

function TElShellTree.DeleteDefaultColumns: Integer;
  var
    j, m     :Integer;
    ASection :TElHeaderSection;
begin
  j := 0;
  m := HeaderSections.Count;
  while j <= HeaderSections.Count -1 do
  begin
    ASection := HeaderSections[j];
    if InRange(siBase, siBase + {FMaxColumns}m, ASection.Tag) then
      HeaderSections.DeleteSection(ASection)
    else
      inc(j);
  end;
  Result := j;
end;

procedure TElShellTree.TriggerVirtualValueNeeded(Item: TElTreeItem; SectionIndex: Integer;
  VarType: Integer; var Value: Variant);
begin
  Value := Unassigned;
end;

procedure TElShellTree.TriggerSortBegin;
begin
  if SortMode in [smClick, smAddClick] then
  begin
    if ShowColumns then
    begin
      if SortSection in [siMin..siMax] then
        SortType := ColumnSortTypes[SortSection]
      else
      if Sortsection = -1 then
        SortType := sstDefault
      else
        SortType := sstCustom;
    end
    else
    begin
      SortSection := -1;
      //SortType := sstDefault; - allow change soft type without columns
    end;
  end;
end;

procedure TElShellTree.TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer;
  SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
begin
  if DefaultEditor then
  begin
    if (SectionIndex = -1) or (HeaderSections[SectionIndex].Tag = siName) then
    begin
      Editor := FEditor;
      exit;
    end;
  end;
  inherited;
end;

procedure TElShellTree.TriggerTryEditEvent(Item: TElTreeItem; SectionIndex : Integer;
      var CellType: TElFieldType; var CanEdit: Boolean);
begin
  CanEdit := (SectionIndex = -1) or (HeaderSections[SectionIndex].Tag = siName);
  if CanEdit then
    CanEdit := TElShellTreeItem(Item).CanRename;
end;

procedure TElShellTree.FileFiltersChange(Sender: TObject);
  {$ifndef B_4}
  var
    i     :Integer;
    Mask  :TMask;
    sMask :String;
  {$endif}
begin
  {$ifndef B_4}
  if Assigned(FFileMasks) then
  begin
    for i:=0 to FFileMasks.Count-1 do
      TMask(FFileMasks[i]).Free;
  end;
  if FFileFilters.Count >0 then
  begin
    if FFileMasks=nil then
      FFileMasks := TList.Create;
    Mask:=nil; // for hide warning: Variable 'Mask' might not have been initialized
    for i:=0 to FFileFilters.Count-1 do
    begin
      sMask := FFileFilters[i];
      if Length(sMask)=0 then
        Continue;
      // check syntax mask (skip bad mask):
      try
        Mask := TMask.Create(sMask);
        Mask.Matches('test');
        FFileMasks.Add(Mask);
      except
        Mask.Free;
      end;
    end;
  end;

  if Assigned(FFileMasks) and (FFileMasks.Count=0) then
  begin
    FFileMasks.Free;
    FFileMasks := nil;
  end;
  {$endif}
  if ShowFiles and FileFiltered then
    RefreshTree(nil, 1);
end;

procedure TElShellTree.OnBeforeOperation(Sender: TObject; var DefaultConversion: Boolean);
begin
  FEditor.ValueAsText := TElShellTreeItem(FEditor.Item).EditName;
  DefaultConversion := True;
end;

procedure TElShellTree.OnValidateEdit(Sender: TOBject; var InputValid: Boolean);
  var
    i :Integer;
begin
  try
    TElShellTreeItem(FEditor.Item).SetEditName(FEditor.Editor.Text);
    i := 0;
    repeat
      Sleep(500);
      inc(i);
    until (i > 10) or (TElShellTreeItem(FEditor.Item).EditName = FEditor.Editor.Text);
    SetLength(TElShellTreeItem(FEditor.Item).FDisplayName, 0);
    FEditor.Item.RedrawItem(False);
  except
    InputValid := False;
  end;
end;

function TElShellTree.GetItemForPIDL(PIDL: PItemIDList):TElShellTreeItem;
  var
    OwnPIDL   :PItemIDList;
    APIDL     :PItemIDList;
    Item      :TElShellTreeItem;
    Item1     :TElShellTreeItem;
    dFolder   :IShellFolder;
    iFolder   :IShellFolder;
    bRepeated :Boolean;
begin
  Result := nil;

  if (FRootPIDL=nil) or (PIDL=nil) then
    exit;

  if (Items.Count = 0) then
    BuildTree;
  if (Items.Count = 0) then
    exit;

  APIDL := PIDL;

  while Assigned(APIDL) and (APIDL^.mkid.cb > 0) and
   (APIDL^.mkid.cb = FRootPIDL^.mkid.cb) and
   ( CompareMem(
       @APIDL^.mkid.abID, @FRootPIDL^.mkid.abID,
       APIDL^.mkid.cb - SizeOf(APIDL^.mkid.cb))
   )
  do
    APIDL := GetNextItemID(APIDL);

  if APIDL=nil then
    exit;

  // check whether PIDL is under root
  OwnPIDL := GetNextItemID(APIDL);
  if (OwnPIDL <> nil) and (OwnPIDL.mkid.cb = 0) then
    exit;

  Item := TElShellTreeItem(Items[0]);
  dFolder := GetDesktopFolder;

  OwnPIDL := Item.FullPIDL;
  if IsDesktopPIDL(OwnPIDL) then
    iFolder := dFolder
  else
    dFolder.BindToObject(OwnPIDL, nil, IID_IShellfolder, Pointer(iFolder));
  if iFolder=nil then
    exit;

  // fill root
  if (not Item.Expanded) and Item.IsFolder then
  begin
    if not Item.HasChildren then // If members no, we shall load
      FillItemWithData(Item, iFolder, 0)
  end;

  Items.BeginUpdate;
  try

    bRepeated := False;
    while Assigned(APIDL)and(APIDL^.mkid.cb > 0) do
    begin
      OwnPIDL := GetItemIDOnly(APIDL);
      Item1 := Item;
      //Searching of the same OwnPIDL in sub items (two variants):
      Item := Item1.FindItemByPIDL(OwnPIDL);
      FreeIDList(OwnPIDL);

      if (Item = nil) then       // If the Item is not retrieved, but Item is founded,
      begin                      // then subitems must be reloaded.
        if (not bRepeated) then  // Check of protection from cycling a repeated loading.
        begin
          // Item not found, but PIDL is founded. It is necessary to reload members:
          Item := Item1;
          OwnPIDL := Item.FullPIDL;
          if SUCCEEDED(dFolder.BindToObject(OwnPIDL, nil, IID_IShellfolder, Pointer(iFolder))) then
          begin
            // Reload SubItems
            FillItemWithData(Item, iFolder, 0);
            // To repeat a current cycle with recreated members:
            bRepeated := True;
            Continue;
          end
          else
            break;
        end
        else
          bRepeated := False;
      end;

      if (Item = nil) or CompareIDLists(PIDL, Item.FullPIDL) then
        break;// Not found
      if Item.IsFolder then
      begin
        if not Item.HasChildren then // If members no, we shall load:
        begin
          OwnPIDL := Item.FullPIDL;
          if SUCCEEDED(dFolder.BindToObject(OwnPIDL, nil, IID_IShellfolder, Pointer(iFolder))) then
          begin
            if not FillItemWithData(Item, iFolder, 0) then
           begin
              Item := nil;
              break;
            end;
            APIDL := GetNextItemID(APIDL);
            if APIDL = nil then
              break;
          end
          else
            break;
        end
        else
        begin
          APIDL := GetNextItemID(APIDL);
          if APIDL = nil then
            break;
        end;
      end
      else
        break;
    end;//of: while (APIDL^.mkid.cb > 0)

  finally
    Items.EndUpdate;
  end;
  Result := Item;
end;//of: function TElShellTree.GetItemForPIDL

function TElShellTree.IsSelectionPIDL(PIDL: PItemIDList):Boolean;
begin
  Result := Assigned(PIDL) and Assigned(ItemFocused) and
            CompareIDLists(ItemFocused.FullPIDL, PIDL);
end;

function TElShellTree.SetSelectionPIDL(PIDL : PItemIDList):Boolean;
  var
    Item: TElShellTreeItem;
begin
  Result := Assigned(PIDL) and Assigned(ItemFocused) and
            CompareIDLists(ItemFocused.FullPIDL, PIDL);
  if Result then
    exit;

  Item := GetItemForPIDL(PIDL);
  if Assigned(Item) then
  begin
    EnsureVisible(Item);
    ItemFocused := Item;
  end
  else
    ItemFocused := nil;

  Result := Assigned(ItemFocused);
end;

function TElShellTree.SetSelectionPath(const Path: String;
  PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif} ):Boolean;
  var
    APIDL :PItemIDList;
begin
  APIDL := GetPIDLFromPath(Path, PathType);
  if Assigned(APIDL) then
  begin
    Result := SetSelectionPIDL(APIDL);
    FreeIDList(APIDL);
  end
  else
    Result := False;
end;

function  TElShellTree.GetPIDLFromPath(const Path: String;
  PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif} ): PItemIDList;
  var
    APIDL     :PItemIDList;
    OwnPIDL   :PItemIDList;
    LPIDL     :PItemIDList;
    iFolder   :IShellFolder;
    vIsFolder :Boolean;
    function IsFolderPIDL(PIDL:PItemIDList):Boolean;
     var
       iCFolder: IShellFolder;
    begin
      Result :=  SUCCEEDED(iFolder.BindToObject(PIDL, nil, IID_IShellfolder, Pointer(iCFolder)));
    end;
begin
  // check path type and ShellTree filter options:
  if (PathType=ptFile) and (not ShowFiles) then
  begin
    Result := nil;
    exit;
  end;

  APIDL := SHGetPIDLFromPath( FIFolder, Path);

  if APIDL=nil then
  begin
    Result := nil;
    exit;
  end;

  // Check PIDL on conformity PathType:
  if (PathType <> ptFolderOrFile) then
  begin
    OwnPIDL := GetParentPIDL(APIDL);
    LPIDL := GetOwnPIDL(APIDL);
    if SUCCEEDED(FIFolder.BindToObject(OwnPIDL, nil, IID_IShellfolder, Pointer(iFolder))) then
    begin
      if (PathType <> ptFolderOrFile)  then
      begin
        vIsFolder := IsFolderPIDL(LPIDL);
        if (not vIsFolder and (PathType=ptFolder))
           or
           (vIsFolder and (PathType=ptFile))
        then
        begin
          FreeIDList(OwnPIDL);
          FreeIDList(APIDL);
          Result := nil;
          exit;
        end;
      end;

      FreeIDList(OwnPIDL);
      Result :=  APIDL;
    end
    else
    begin
      FreeIDList(OwnPIDL);
      FreeIDList(APIDL);
      Result := nil;
    end;
  end
  else
    Result :=  APIDL;
end;//of: function  TElShellTree.GetPIDLFromPath

function TElShellTree.GetItemForPath(const Path: String;
  PathType: TElPathType{$ifdef VCL_5_USED}=ptFolderOrFile{$endif} ):TElShellTreeItem;
  var
    PIDL : PItemIDList;
begin
   PIDL := GetPIDLFromPath(Path, PathType);
   Result := GetItemForPIDL(PIDL);
   if Assigned(PIDL) then
     FreeIDList(PIDL);
end;

procedure TElShellTree.SetExpandRoot(Value: Boolean);
begin
  if FExpandRoot <> Value then
  begin
    FExpandRoot := Value;
    if FExpandRoot and Assigned(Items) and (Items.Count>0) then
      Items[0].Expand(False);
  end;
end;

function TElShellTree.BuildRootPIDL: PItemIDList;
begin
  Result := ClonePIDL(FRootPIDL);
end;

{$ifdef VCL_4_USED}
procedure TElShellTree.TriggerVirtualHintNeeded(Item: TElTreeItem; var Hint: TElFString);
begin
  Hint := (Item as TElShellTreeItem).GetHintText(FIFolder);
  if Assigned(FOnVirtualHintNeeded) then
    OnVirtualHintNeeded(Self, Item, Hint);
end;
{$endif}

function TElShellTree.DoGetPicture(Item: TElTreeItem): Integer;
begin
  Result := (Item as TElShellTreeItem).GetPicture(FIFolder);
end;

procedure TElShellTree.SetShellListView(Value: TElShellList);
begin
  if FShellListView <> Value then
  begin
    if (FShellListView <> nil) then
      FShellListView.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellListView <> nil) and (not (csDestroying in FShellListView.ComponentState)) then
      FShellListView.RemoveFreeNotification(Self);
    {$endif}
    FShellListView := Value;
    if (FShellListView <> nil) then
    begin
      FShellListView.FreeNotification(Self);
      SyncControls(FShellListView);
    end;
  end;
end;

procedure TElShellTree.SetShellComboBox(Value: TElShellComboBox);
begin
  if FShellComboBox <> Value then
  begin
    if (FShellComboBox <> nil) then
      FShellComboBox.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellComboBox <> nil) and (not (csDestroying in FShellComboBox.ComponentState)) then
      FShellComboBox.RemoveFreeNotification(Self);
    {$endif}

    FShellComboBox := Value;

    if (FShellComboBox <> nil) then
    begin
      FShellComboBox.FreeNotification(Self);
      SyncControls(FShellComboBox);
    end;
  end;
end;

procedure TElShellTree.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = ShellListView) and (Operation = opRemove) then
    fShellListView := nil;
  if (AComponent = ShellComboBox) and (Operation = opRemove) then
    fShellComboBox := nil;
end;

procedure TElShellTree.SyncControls(Sender: TObject);
  var
    APIDL                       :PItemIDList;
    AnItem                      :TElShellTreeItem;
    STV_ItemFocused_Parent      :TElShellTreeItem;
    SaveListIsUpdating          :Boolean;
    SaveTreeIsUpdating          :Boolean;
    bList, bCombo               :Boolean;
begin
  if fIsSyncControls or (not HandleAllocated) or
     ((FShellListView=nil) and (FShellComboBox=nil))
  then
    exit;

  if Assigned(FRootPIDL) then
  begin
    AnItem := TElShellTreeItem(ItemFocused);
    if Assigned(AnItem) and (not AnItem.IsFolder) then
      AnItem := TElShellTreeItem(AnItem.Parent);
  end
  else
    AnItem := nil;

  bList := False;
  bCombo := False;
  SaveListIsUpdating:= False;
  SaveTreeIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  fIsSyncControls := True;
  try
    if AnItem = nil then
      APIDL := FRootPIDL
    else
      APIDL := anItem.FullPIDL;

    // ShellList:
    if Assigned(ShellListView) and (not ShellListView.fIsSyncControls) and
       (ShellListView.HandleAllocated) and ( (Sender=nil) or (Sender=ShellListView) )
    then
    begin
      bList := True;
      ShellListView.fIsSyncControls := True;
      SaveListIsUpdating := ShellListView.IsUpdating;
      if not ShellListView.IsUpdating then
        ShellListView.IsUpdating := True;
      //ShellListView.Items.BeginUpdate;
      ShellListView.DeselectAll;
      if (not ShellListView.SetRootPIDL(APIDL)) and Assigned(AnItem) then
      begin
        // Need Synchronize Shell List to Parent ShellTree
        STV_ItemFocused_Parent := TElShellTreeItem(AnItem.Parent);
        if Assigned(STV_ItemFocused_Parent) and
           ShellListView.SetRootPIDL(STV_ItemFocused_Parent.FullPIDL)
        then
          ShellListView.SetSelectionPIDL(AnItem.PIDL);
      end;
    end;

    // ShellComboBox:
    if Assigned(ShellComboBox) and (not ShellComboBox.fIsSyncControls) and
       (ShellComboBox.HandleAllocated) and ( (Sender=nil) or (Sender=ShellComboBox) )
    then
    begin
      bCombo := True;
      ShellComboBox.fIsSyncControls := True;
      ShellComboBox.SetSelection(APIDL);
    end;

  finally
    fIsSyncControls := False;
    if bList then
    begin
      ShellListView.fIsSyncControls := False;
      if ShellListView.IsUpdating <> SaveListIsUpdating then
        ShellListView.IsUpdating := SaveListIsUpdating;
      //ShellListView.Items.EndUpdate;
    end;
    if bCombo then
      ShellComboBox.fIsSyncControls := False;
    if IsUpdating <> SaveTreeIsUpdating then
      IsUpdating := SaveTreeIsUpdating;
    if Assigned(AnItem) then
    begin
      EnsureVisible(AnItem);
      Invalidate;     end;
  end;
end;

procedure TElShellTree.SynclShellComboBox(ShellComboBox: TElShellComboBox);
  var
    APIDL: PItemIDList;
    AnItem: TElShellTreeItem;
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellComboBox=nil) or (ShellComboBox.fIsSyncControls) or
     (not ShellComboBox.HandleAllocated)
  then
    exit;

  if Assigned(FRootPIDL) then
  begin
    AnItem := TElShellTreeItem(ItemFocused);
    if Assigned(AnItem) and (not AnItem.IsFolder) then
      AnItem := TElShellTreeItem(AnItem.Parent);
  end
  else
    AnItem := nil;

  if AnItem = nil then
    APIDL := FRootPIDL
  else
    APIDL := anItem.FullPIDL;

  ShellComboBox.SetSelection(APIDL);
end;

procedure TElShellTree.SynclShellTree(ShellTree: TElShellTree);
  var
    APIDL                   :PItemIDList;
    AnItem                  :TElShellTreeItem;
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellTree=nil) or (ShellTree.fIsSyncControls) or
     (not ShellTree.HandleAllocated) or (ShellTree=Self)
  then
    exit;

  if Assigned(FRootPIDL) then
  begin
    AnItem := TElShellTreeItem(ItemFocused);
    if Assigned(AnItem) and (not AnItem.IsFolder) then
      AnItem := TElShellTreeItem(AnItem.Parent);
  end
  else
    AnItem := nil;

  if AnItem = nil then
    APIDL := FRootPIDL
  else
    APIDL := anItem.FullPIDL;

  ShellTree.SetSelectionPIDL(APIDL);
end;

procedure TElShellTree.SyncShellList(ShellList: TElShellList);
  var
    APIDL: PItemIDList;
    AnItem: TElShellTreeItem;
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellList=nil) or (ShellList.fIsSyncControls) or
     (not ShellList.HandleAllocated)
  then
    exit;

  if Assigned(FRootPIDL) then
  begin
    AnItem := TElShellTreeItem(ItemFocused);
    if Assigned(AnItem) and (not AnItem.IsFolder) then
      AnItem := TElShellTreeItem(AnItem.Parent);
  end
  else
    AnItem := nil;

  if AnItem = nil then
    APIDL := FRootPIDL
  else
    APIDL := anItem.FullPIDL;

  ShellList.SetRootPIDL(APIDL);
end;

{ TElShellTreeItem }

function TElShellTreeItem.GetFullPIDL: PItemIDList;
  var
    PIDL :PItemIDList;
begin
  if FFullPIDL = nil then
  begin
    if Parent = nil then
      FFullPIDL := ClonePIDL(TElShellTree(FOwner).FRootPIDL)
    else
    begin
      PIDL := TElShellTreeItem(Parent).BuildFullPIDL;
      FFullPIDL := AppendPIDL(PIDL, FPIDL);
      FreeIDList(PIDL);
    end;
  end;
  Result := FFullPIDL;
end;

function TElShellTreeItem.BuildFullPIDL: PItemIDList;
begin
  Result := ClonePIDL(FullPIDL);
end;

function TElShellTreeItem.GetPicture(const ParentFolder: IShellFolder): Integer;
  var
    APIDL  : PItemIDList;
begin

  if (FPIDL = nil) then
  begin
    Result := -1;
    exit;
  end;

  if FAttr = 0 then // - if iShellFolder.Attribute not cached then ready it
    GetAttributes(ParentFolder);

  APIDL := FullPIDL;

  Result := ShellIconCache.AddFromPIDL(APIDL, GIL_FORSHELL, False);
  ImageIndex := Result;

  if ((FAttr and SFGAO_FOLDER) = SFGAO_FOLDER) then
    StateImageIndex := ShellIconCache.AddFromPIDL(APIDL, GIL_FORSHELL, True)
  else
    StateImageIndex := Result;
end;

procedure TElShellTreeItem.GetAttributes(const iParentFolder: IShellFolder);
  var
    i :TShellAttr;
begin
  if (FPIDL = nil) then
  begin
    FAttr := 0;
    exit;
  end;

  i := cSFGAO_FLAGS;

  if SUCCEEDED(IParentFolder.GetAttributesOf(1, FPIDL, i))
  then
    FAttr := i
  else
    FAttr := 0;
  if TElShellTree(FOwner).FHighlightCompressed then
  begin
    if (FAttr and SFGAO_COMPRESSED) = SFGAO_COMPRESSED then
    begin
      Color := GetCompressedColor;
      ParentColors := False;
      UseBkColor := False;
    end;
  end;
  if (FAttr and SFGAO_GHOSTED) = SFGAO_GHOSTED then
    Cut := True;
end;

function TElShellTreeItem.GetEditName: String;
  var
    iFolder : IShellFolder;
    str     : TStrRet;
begin
  iFolder := ParentFolder;
  ZeroMemory(@Str, SizeOf(Str));
  Str.uType := STRRET_CSTR;
  if SUCCEEDED(iFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER or SHGDN_FOREDITING, str)) then
  begin
    Result := StrRetToPas(Str, FPIDL);
    StrRetFree(str);
  end
  else
    SetLength(Result, 0);
  iFolder := nil;
  FEditName := Result;
end;

function TElShellTreeItem.GetDisplayName: String;
  var
    iFolder :IShellFolder;
    str     :TStrRet;
begin
  if Length(FDisplayName)=0 then
  begin
    iFolder := ParentFolder;
    ZeroMemory(@Str, SizeOf(Str));
    Str.uType := STRRET_CSTR;
    if SUCCEEDED(iFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER, str)) then
    begin
      FDisplayName := StrRetToPas(Str, FPIDL);
      StrRetFree(str);
    end;
    iFolder := nil;
  end;
  Result := FDisplayName;
end;

function TElShellTreeItem.IsExists:Boolean;
  var
    str     :TStrRet;
begin
    ZeroMemory(@Str, SizeOf(Str));
    Str.uType := STRRET_CSTR;
    Result := SUCCEEDED(ParentFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER, str));
    if Result then
      StrRetFree(str);
end;

function TElShellTreeItem.GetFullName: String;
  var
    StrRet : TStrRet;
begin
  if Parent = nil then
  begin
    if TElShellTree(FOwner).FRootFolder <> sfoCustom then
      GetPathFromPIDL(TElShellTree(FOwner).FRootPIDL, Result)
    else
      Result := TElShellTree(FOwner).CustomRootFolder;
  end
  else
  begin
    ZeroMemory(@StrRet, SizeOf(StrRet));
    StrRet.uType := STRRET_CSTR;
    if SUCCEEDED(ParentFolder.GetDisplayNameOf(FPIDL, SHGDN_NORMAL or
      SHGDN_FORPARSING {SHGDN_FORADDRESSBAR}, StrRet))
    then
    begin
      Result := StrRetToPas(StrRet, FPIDL);
      StrRetFree(StrRet);
    end
    else
      SetLength(Result, 0);
  end;
end;

function TElShellTreeItem.GetHasSubFolders: Boolean;
begin
  Result := (FAttr and SFGAO_HASSUBFOLDER) = SFGAO_HASSUBFOLDER;
end;

function TElShellTreeItem.GetIsFolder: Boolean;
begin
  Result := ((FAttr and SFGAO_FOLDER) = SFGAO_FOLDER);
end;

function TElShellTreeItem.GetIsRemovable: Boolean;
begin
  Result := (FAttr and SFGAO_REMOVABLE) = SFGAO_REMOVABLE;
end;

function TElShellTreeItem.GetParentFolder: IShellFolder;
  var
    PIDL    :PItemIDList;
begin
  if Parent <> nil then
    PIDL := TElShellTreeItem(Parent).FullPIDL
  else
    PIDL := GetParentPIDL(TElShellTree(FOwner).FRootPIDL);
  Result := nil;
  if IsDesktopPIDL(PIDL) then
    Result := GetDesktopFolder
  else
  if not SUCCEEDED(GetDesktopFolder.BindToObject(PIDL, nil, IID_IShellFolder,
    Pointer(Result)))
  then
    Result := nil;

  if Parent = nil then
    FreeIDList(PIDL);
end;


function TElShellTreeItem.GetSize: Cardinal;
begin
  CheckWin32FindData;
  if Assigned(Win32FindData) then
    Result := Win32FindData.nFileSizeLow
  else
    Result := 0;
end;

procedure TElShellTreeItem.SetDisplayName(const Value: String);
  var
    iFolder :IShellFolder;
    NewPIDL :PItemIDList;
begin
  if DisplayName=Value then
    exit;
  IFolder := GetParentFolder;
  if SUCCEEDED(IFolder.SetNameOf(FOwner.Handle, FPIDL, PWideChar(WideString(Value)),
    SHGDN_INFOLDER, NewPIDL)) then
  begin
    FDisplayName := Value;
    if NewPIDL <> nil then
    begin
      FreeIDList(FPIDL);
      FPIDL := ClonePIDL(GetOwnPIDL(NewPIDL));
      FreeIDList(NewPIDL);
    end;
  end
  else
    raise EElShellError.Create('Failed to rename ' + DisplayName);
end;

procedure TElShellTreeItem.SetEditName(const Value: String);
  var
    iFolder :IShellFolder;
    NewPIDL :PItemIDList;
begin
  if Value=EditName then
    exit;
  IFolder := GetParentFolder;
  if SUCCEEDED(IFolder.SetNameOf(FOwner.Handle, FPIDL, PWideChar(WideString(Value)),
    SHGDN_INFOLDER or SHGDN_FOREDITING, NewPIDL)) then
  begin
    FEditName := Value;
    if NewPIDL <> nil then
    begin
      FreeIDList(FPIDL);
      FPIDL := ClonePIDL(GetOwnPIDL(NewPIDL));
      FreeIDList(NewPIDL);
    end;
  end
  else
    raise EElShellError.Create('Failed to rename ' + EditName);
end;

constructor TElShellTreeItem.Create(AOwner: TCustomElTree);
begin
  inherited;
  ClearData(False);
end;

destructor TElShellTreeItem.Destroy;
begin
  ClearData(True);
  inherited;
end;

procedure TElShellTreeItem.ClearData(bRelease: Boolean);
begin
  if Assigned(FPIDL) then
    FreeIDList(FPIDL);
  if Win32FindData <> nil then
    Dispose(Win32FindData);
  if not bRelease then
  begin
    FPIDL         := GetEmptyPIDL;
    FAttrAsString := cShellNullStr;
    FComment      := cShellNullStr;
    FTypeName     := cShellNullStr;
    FSizeAsString := cShellNullStr;
    FFileName := cShellNullStr;
    Win32FindData := nil;
    {$ifdef VCL_4_USED}
    SetLength(FHint,0);
    {$endif}
    SetLength(FDisplayName, 0);
  end;
end;

function TElShellTreeItem.GetCreationTime: TDateTime;
  var
    SysTime :TSystemTime;
begin
  CheckWin32FindData;
  if Assigned(Win32FindData) then
  begin
    FileTimeToSystemTime(Win32FindData.ftCreationTime, SysTime);
    Result := SystemTimeToDateTime(SysTime);
  end
  else
    Result := 0;
end;

function TElShellTreeItem.GetModificationTime: TDateTime;
  var
    SysTime :TSystemTime;
begin
  CheckWin32FindData;
  if Assigned(Win32FindData) then
  begin
    FileTimeToSystemTime(Win32FindData.ftLastWriteTime, SysTime);
    Result := SystemTimeToDateTime(SysTime);
  end
  else
    Result := 0;
end;

function TElShellTreeItem.GetLastAccessTime: TDateTime;
  var
    SysTime :TSystemTime;
begin
  CheckWin32FindData;
  if Assigned(Win32FindData) then
  begin
    FileTimeToSystemTime(Win32FindData.ftLastAccessTime, SysTime);
    Result := SystemTimeToDateTime(SysTime);
  end
  else
    Result := 0;
end;

procedure TElShellTreeItem.GetWin32Data(const ParentFolder: IShellFolder);
  var
    HSRec  :THandle;
    FN     :String;
    S      :String;
begin
  FIsValidFile := False;
  if Win32FindData = nil then
    New(Win32FindData);
  FN := GetFullName;
  S  := ExtractFilePath(FN);
  System.Delete(S, 1, Length(ExtractFileDrive(S)));
  if S = '\' then
  begin
    S := ExtractFileDrive(FN);
    if Copy(S, 1, 2) = '\\' then
    begin
      ZeroMemory(Win32FindData, SizeOf(Win32FindData^));
      Win32FindData^.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY;
      FFileName := S;
      exit;
    end
    else
    begin
      if GetDriveType(PChar(S)) in [1, DRIVE_REMOVABLE, DRIVE_REMOTE] then
      begin
        ZeroMemory(Win32FindData, SizeOf(Win32FindData^));
        Win32FindData^.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY;
        FFileName := S;
        exit;
      end;
    end;
    FFileName := FN;
  end;
  HSRec := FindFirstFile(PChar(GetFullName), Win32FindData^);
  if HSRec = INVALID_HANDLE_VALUE then
    ZeroMemory(Win32FindData, SizeOf(Win32FindData^))
  else
  begin
    FIsValidFile := True;
    FindClose(HSRec);
  end;
end;

procedure TElShellTreeItem.CheckWin32FindData;
begin
  if (Win32FindData = nil) and
     ((FAttr and SFGAO_FILESYSTEM) = SFGAO_FILESYSTEM)
  then
    GetWin32Data(ParentFolder);
end;

function TElShellTreeItem.GetFileName: String;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := DisplayName
  else
  begin
    if FFileName <> cShellNullStr then
      Result := FFileName
    else
    begin
      Result := StrPas(Win32FindData.cFileName);
      FFileName := Result;
    end;
  end;
end;

function TElShellTreeItem.GetSizeAsString: String;
  var
    ASize :Integer;
begin
  if FSizeAsString = cShellNullStr then
  begin
    case TElShellTree(Owner).SizeFormat of
      ssfAsIs :
        begin
          Result := IntToStrFmt(Size) + ' b';
        end;
      ssfKb:
        begin
          ASize  := Round(Size / 1024);
          Result := IntToStrFmt(ASize) + ' Kb';
        end;
      ssfAuto:
        begin
          ASize := Size;
          if ASize < 1024 then
            Result := IntToStrFmt(ASize) + ' b'
          else
          if ASize < 1024*1024 * 10 then
            Result := IntToStrFmt(Round(Size / 1024)) + ' Kb'
          else
            Result := IntToStrFmt(Round(Size / (1024 * 1024))) + ' Mb';
        end;
    end;
    FSizeAsString := Result;
  end
  else
    Result := FSizeAsString;
end;

function TElShellTreeItem.GetTypeName: String;
  var
    SFI :TSHFileInfo;
begin
  if FTypeName = cShellNullStr then
  begin
    SHGetFileInfo(PChar(FullName), 0, SFI, SizeOf(SFI), SHGFI_TYPENAME or SHGFI_USEFILEATTRIBUTES);
    FTypeName := StrPas(SFI.szTypeName);
  end;
  Result := FTypeName;
end;

function TElShellTreeItem.GetIsFileObject: Boolean;
begin
  Result := ((FAttr and SFGAO_FILESYSTEM) = SFGAO_FILESYSTEM);
end;

function TElShellTreeItem.GetAttrAsString: String;
  var
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    sd       :TShellDetails;
begin
  if FAttrAsString <> cShellNullStr then
  begin
    Result := FAttrAsString;
    exit;
  end
  else
    SetLength(Result, 0);

  if IsDesktopPIDL(PIDL) then
  begin
    SetLength(FAttrAsString, 0);
    exit;
  end;
  if PIDL = nil then exit;

  IFolder := GetParentFolder;

  if not SUCCEEDED(IFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
  begin
    if SUCCEEDED(IFolder.QueryInterface(IID_IShellDetails, IDetails)) then
    begin
      if SUCCEEDED(IDetails.GetDetailsOf(PIDL, siAttr, sd)) then
      begin
        Result := StrRetToPas(sd.str, PIDL);
        StrRetFree(sd.str);
      end;
    end;
  end
  else
  begin
    if SUCCEEDED(IFolder2.GetDetailsOf(PIDL, siAttr, sd)) then
    begin
      Result := StrRetToPas(sd.str, PIDL);
      StrRetFree(sd.str);
    end;
  end;
  FAttrAsString := Result;
end;

function TElShellTreeItem.GetComment: String;
  var
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    sd       :TShellDetails;
    hres     :HResult;
begin
  if FComment <> cShellNullStr then
  begin
    Result := FComment;
    exit;
  end
  else
    SetLength(Result, 0);

  iFolder := ParentFolder;

  if not SUCCEEDED(iFolder.CreateViewObject(FOwner.Handle, IShellDetails, Pointer(IDetails))) then
  begin
    if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
    begin
      IDetails := TElShellDefaultColumns.Create as IShellDetails;
    end;
  end;

  if IFolder2 <> nil then
    hRes := IFolder2.GetDetailsOf(FPIDL, siComment, SD)
  else
    hRes := IDetails.GetDetailsOf(FPIDL, siComment, SD);
  if hRes = S_OK then
  begin
    Result := StrRetToPas(SD.str, nil); StrRetFree(SD.str);
    FComment := Result;
  end;
end;

procedure TElShellTreeItem.Invalidate;
begin
  ClearData(False);
end;

function TElShellTreeItem.FindItemByPIDL(APIDL: PItemIDList): TElShellTreeItem;
  var
    i :Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if CompareIDLists(APIDL, TElShellTreeItem(Children[i]).FPIDL) then
    begin
      Result := TElShellTreeItem(Children[i]);
      exit;
    end;
  end;
  Result := nil;
end;

function TElShellTreeItem.GetCanRename: Boolean;
begin
  Result := (FAttr and SFGAO_CANRENAME) = SFGAO_CANRENAME;
end;

{$ifdef VCL_4_USED}
procedure ShellFolderGetHintText(var Hint: TElFString; OwnerHandle: THandle; PIDL: PItemIDList;
  const ParentFolder: IShellFolder; Attr: Cardinal);
  var
    QInfo  :IQueryInfo;
    aWP    :PWideChar;
begin
  try
    if SUCCEEDED(ParentFolder.GetUIObjectOf(OwnerHandle, 1, PIDL, IQueryInfo, nil,
      Pointer(QInfo)))
    then
    begin
      aWP := nil;
      QInfo.GetInfoTip(0, aWP);
      Hint := aWP;
      if Length(Hint)=0 then
        Hint:=#1;
      if aWP <> nil then
        GetShellMalloc.Free(aWP);
    end
    else
      Hint := #1;
  except
    Hint := #1;
    //SetLength(Hint, 0);
  end;
end;

{
  Replacement of calculation system hint. System hint it is very slowly calculated
  when Root=fsoCustom. It is bug in Windows XP when Root PIDL = fsoCustom.
  (Only for multimedia windows. When calculation "Duration" detail column.)
}

const
  cHintRowCount = 3;

  cHintRowTypes :array[0..cHintRowCount-1] of Integer = (
    siType, siModified, siSize
  );

  sHintRowNames: array[0..cHintRowCount-1] of String = (
    #1,
    '',
    ''
  );

procedure InitHintRowNames(Handle: THandle; const ShellFolder : IShellFolder);
  var
    i        :Integer;
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    SD       :TShellDetails;
    hRes     :HResult;
begin
  iFolder := ShellFolder;
  if iFolder <> nil then
  begin
    if not SUCCEEDED(iFolder.CreateViewObject(Handle, IShellDetails, Pointer(IDetails))) then
    begin
      if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
      begin
        IDetails := TElShellDefaultColumns.Create as IShellDetails;
      end;
    end;
  end;

  SetLength(sHintRowNames[0], 0);
  for i:=0 to cHintRowCount-1 do
  begin
    if IFolder2 <> nil then
      hRes := IFolder2.GetDetailsOf(nil, cHintRowTypes[i], SD)
    else
    if IDetails <> nil then
      hRes := IDetails.GetDetailsOf(nil, cHintRowTypes[i], SD)
    else
      hRes := E_FAIL;

    if hRes = S_OK then
    begin
      sHintRowNames[i] := StrRetToPas(SD.str, nil);
      if Length(sHintRowNames[i])>0 then
        sHintRowNames[i] := sHintRowNames[i]+': ';
      StrRetFree(SD.str);
    end;
  end;//of: for i
end;

procedure ShellFolderGetHintText2(var Hint: TElFString; OwnerHandle: THandle; PIDL: PItemIDList;
  const ParentFolder: IShellFolder; Attr: Cardinal);
  var
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    SD       :TShellDetails;
  var
    iColumn   :UINT;
    cRetCount :UINT;
    sColumn   :String;
begin
  if PIDL = nil then
  begin
    SetLength(Hint, 0);
    exit;
  end;

  if // IsWinXPUp or IsWinME or // Only for multimedia windows. When calculation "Duration" detail column.
     IsDesktopPIDL(PIDL) or
     ((Attr and SFGAO_FOLDER)<>0) or
     ((Attr and SFGAO_FILESYSTEM)=0) or
     ((Attr and SFGAO_LINK)<>0) or
     ((Attr and SFGAO_HASSUBFOLDER)<>0) or
     ((Attr and SFGAO_REMOVABLE)<>0)
  then
  begin
    ShellFolderGetHintText(Hint, OwnerHandle, PIDL, ParentFolder, Attr);
    exit;
  end;

  try
    if not (
         (SUCCEEDED(ParentFolder.QueryInterface(IID_IShellFolder2, IFolder2)))
         or
         (SUCCEEDED(ParentFolder.QueryInterface(IID_IShellDetails, IDetails)))
       )
    then
    begin
      SetLength(Hint, 0);
      exit;
    end;


    if sHintRowNames[0]=#1 then
      InitHintRowNames(OwnerHandle, ParentFolder);

    cRetCount := 0;
    for iColumn:=0 to cHintRowCount-1 do
    begin
      if (not SUCCEEDED(IFolder2.GetDetailsOf(PIDL, cHintRowTypes[iColumn], sd))) then
        Continue;
      sColumn := StrRetToPas(sd.str, PIDL);
      StrRetFree(sd.str);

      { This is a hack bug fix to get around Windows Shell Controls returning
        spurious "?"s in date/time detail fields }
      if (cHintRowTypes[iColumn] = siModified{in [siModified, siCreated, siAccessed]}) then
        while ElStrUtils.replace(sColumn, '?', '') do;

      sColumn := Trim(sColumn);
      if Length(sColumn)>0 then
      begin
        inc(cRetCount);
        if Length(Hint)>0 then
          Hint := Hint+#13#10+sHintRowNames[iColumn]+sColumn
        else
          Hint := sHintRowNames[iColumn]+sColumn;
      end;

    end;//of: for iColumn

    if cRetCount=0 then
    begin
      ShellFolderGetHintText(Hint, OwnerHandle, PIDL, ParentFolder, Attr);
      exit;
    end;

    if Length(Hint)=0 then
      Hint:=#1;

  except
    SetLength(Hint, 0);
  end;
end;

function TElShellTreeItem.GetHintText(const ParentFolder: IShellFolder): TElFString;
begin
  if Length(FHint)=0 then
  begin
    if (TElShellTree(Owner).RootFolder<>sfoCustom) or IsDesktopPIDL(TElShellTree(Owner).FRootPIDL)
    then
      ShellFolderGetHintText(FHint, Owner.Handle, FPIDL, ParentFolder, FAttr)
    else
      ShellFolderGetHintText2(FHint, Owner.Handle, FPIDL, ParentFolder, FAttr);
  end;
  if FHint = #1 then
    SetLength(Result,0)
  else
    Result := FHint;
end;
{$endif ifdef VCL_4_USED}

{ TElShellTreeView }

procedure TElShellTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbRight) and (not Dragging) and TElShellTree(Parent).UseSystemMenus then
    ShowSystemMenu(X, Y, nil);
end;

procedure TElShellTreeView.MenuWndProc(var Message: TMessage);
  var
    {$IFDEF VCL_4_USED}
    ICI      :CMInvokeCommandInfo;
    {$ELSE}
    ICI      :TCMInvokeCommandInfo;
    {$ENDIF}
    idCmd    :Cardinal;
    VerbBuff :array[0..255] of Char;
    VerbStr  :String;
    bHandled :Boolean;
    ICM2     :IContextMenu2;
begin
  if Assigned(iCtxMenu) then
  case Message.Msg of
    WM_EXITMENULOOP:
      begin
        DestroyMenu(FBuiltinMenu);
        FBuiltinMenu := 0;
        inherited;
      end;
    WM_COMMAND:
      with TElShellTree(FOwner) do
      begin
        idCmd := LOWORD(Message.wParam);
        if idCmd = 0 then
          exit;
        FillMemory(@ICI, SizeOf(ICI), 0);
        ICI.cbSize := SizeOf(ICI);
        ICI.nShow  := SW_SHOWNORMAL;
        ICI.lpVerb := MakeIntResource(idCmd);
        if Integer(ICI.lpVerb) < 0 then
          exit;
        bHandled := False;
        VerbBuff[0] := #0;
        if iCtxMenu.GetCommandString(idCmd, GCS_VERB, nil, VerbBuff, SizeOf(VerbBuff)) = S_OK then
        begin
          VerbStr := VerbBuff;
          if Assigned(fOnInvokeVerbCommand) then
            fOnInvokeVerbCommand(FOwner, VerbStr, bHandled);
          if (not bHandled) and Assigned(ItemFocused) then
          begin
            if CompareText(VerbStr, 'rename')=0 then
            begin
              ItemFocused.EditText;
              bHandled := True;
            end;
          end;
        end
        else
          SetLength(VerbStr, 0);

        if not bHandled then
        begin
          if iCtxMenu.InvokeCommand(ICI) <> S_OK then
            exit;
          if (CompareText(VerbStr, 'delete')=0) then
          begin
            if Assigned(ItemFocused) and (not ItemFocused.IsExists) then
              ItemFocused.Delete;
          end;//of: VerbStr == 'delete'
        end;//of: if not bHandled
        inherited;
      end;//of: if (Message.Msg = WM_COMMAND)
    WM_INITMENUPOPUP,
    WM_DRAWITEM,
    WM_MENUCHAR,
    WM_MEASUREITEM:
      begin
        iCtxMenu.QueryInterface(IID_IContextMenu2, Pointer(ICM2));
        if Assigned(ICM2) then
        begin
          ICM2.HandleMenuMsg(Message.Msg, Message.WParam, Message.LParam);
          Message.Result := 0;
        end;
      end;
    else
      inherited;
  end// of case
  else
    inherited;
end;

constructor TElShellTreeView.Create(AOwner: TComponent);
begin
  inherited;
  {$warnings off}
  FMenuWnd := AllocateHWND(MenuWndProc);
  {$warnings on}
end;

destructor TElShellTreeView.Destroy;
begin
  if Assigned(iCtxMenu) then
  begin
    DestroyMenu(FBuiltinMenu);
    FBuiltinMenu := 0;
    iCtxMenu := nil;
  end;
  {$warnings off}
  DeallocateHWND(FMenuWnd);
  {$warnings on}
  inherited;
end;

procedure TElShellTreeView.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_APPS) and (Shift = []) and TElShellTree(FOwner).UseSystemMenus then
  begin
    Key := 0;
    ShowSystemMenu(-1, -1, TElShellTreeItem(FOwner.ItemFocused) );
  end;
  inherited;
end;

procedure TElShellTreeView.ShowSystemMenu(X, Y: Integer; Item: TElShellTreeItem);
  var
    HCol     :Integer;
    ItemPart :TSTItemPart;
    PIDL     :PItemIDList;
    P        :TPoint;
    uFlag    :UINT;
    ICM2     :IContextMenu2;
begin
  if (X>=0)and(Y>=0) and (Item=nil) then
  begin
    HCol := 0;
    Item := TElShellTreeItem( GetItemAt(X, Y, ItemPart, HCol) );
  end;

  if Assigned(Item) and (Item.Enabled) then
  with TElShellTree(FOwner) do
  begin
    if Item <> nil then
    begin
      PIDL := TElShellTreeItem(Item).PIDL;
      if PIDL <> nil then
      begin
        iCtxMenu := nil;
        if SUCCEEDED(TElShellTreeItem(Item).ParentFolder.GetUIObjectOf(Handle, 1, PIDL,
          IID_iContextMenu, nil, Pointer(iCtxMenu)))
        then
        begin
          FBuiltinMenu := CreatePopupMenu;
          uFlag := CMF_NORMAL;
          if DoInplaceEdit then
            uFlag := uFlag or CMF_CANRENAME;
          iCtxMenu.QueryContextMenu(FBuiltinMenu, 0, 0, $FFFFFFFF, uFlag);
          iCtxMenu.QueryInterface(IID_IContextMenu2, Pointer(ICM2));
          P := ClientToScreen(Point(X, Y));
          TrackPopupMenu(FBuiltinMenu, TPM_LEFTALIGN  or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
            P.X, P.Y, 0, FMenuWnd, nil);
        end;
      end;
    end;
  end;
end;

function TElShellTreeView.GetPopupMenu: TPopupMenu;
begin
  if TElShellTree(FOwner).UseSystemMenus then
    Result := nil
  else
    Result := inherited GetPopupMenu;
end;

procedure TElShellTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
  var
    Shift :TShiftState;
begin
  Shift := KeyDataToShiftState(Message.Keys);
  if GetKeyState(VK_MENU) < 0 then
    Include(Shift, ssAlt);
  TElShellTree(FOwner).MouseLButtonDblClickExt(Message.XPos, Message.YPos, Shift);
  if ([ssShift, ssAlt, ssCtrl]*Shift)=[] then
    inherited;
end;

{ TElShellComboBox }

constructor TElShellComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FExplorerStyle := True;
  FSelectionPIDL := GetEmptyPIDL;
  Style:= csOwnerDrawFixed;     //ssn   default csOwnerDrawVariable     ???
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2,
    Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

destructor TElShellComboBox.Destroy;
begin
  FShellTreeView := nil;
  FShellListView := nil;
  if FEditor <> nil then
  begin
    FEditor.Free;
    FEditor := nil;
  end;
  if FSelectionPIDL <> nil then
    FreeIDList(FSelectionPIDL);
  inherited;
end;

procedure TElShellComboBox.SetExplorerStyle(Value: Boolean);
begin
  if FExplorerStyle <> Value then
  begin
    FExplorerStyle := Value;
    RecreateWnd;
  end;
end;

procedure TElShellComboBox.FillCombo(const BaseFolder: IShellFolder; BasePIDL: PItemIDList;
  Level: Integer);
    function AddThisItem(iFolder: IShellFolder; PIDL: PItemIDList): PElShellComboData;
      var
        ComboData :PElShellComboData;
        Str       :TStrRet;
        {$ifdef B_3}
        j         : Integer;
        {$else}
        j         :TShellAttr;
        {$endif}
    begin
      ZeroMemory(@Str, SizeOf(Str));
      Str.uType := STRRET_CSTR;

      New(ComboData);
      ComboData.PIDL := AppendPIDL(BasePIDL, PIDL);
      if SUCCEEDED(BaseFolder.GetDisplayNameOf(PIDL, SHGDN_INFOLDER or SHGDN_FORADDRESSBAR,
        str)) then
      begin
        ComboData.DisplayName := StrRetToPas(str, PIDL);
        StrRetFree(str);
      end;
      if SUCCEEDED(BaseFolder.GetDisplayNameOf(PIDL, SHGDN_NORMAL or SHGDN_FORPARSING, str)) then
      begin
        ComboData.FileName := StrRetToPas(str, PIDL);
        StrRetFree(str);
      end;
      j := SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR or SFGAO_FOLDER;
      if SUCCEEDED(BaseFolder.GetAttributesOf(1, PIDL, j)) then
        ComboData.Attr := j
      else
        ComboData.Attr := 0;
      ComboData.IconIdx := ShellIconCache.AddFromPIDL(ComboData.PIDL, GIL_FORSHELL, False);
      ComboData.OpenIconIdx := ShellIconCache.AddFromPIDL(ComboData.PIDL, GIL_FORSHELL, True);
      ComboData.Level := Level;
      Result := ComboData;
    end;

    function CompareItems(Item1,
                          Item2: Pointer;
                          Cargo: Pointer): Integer;
      var
        ComboData1 :PElShellComboData absolute Item1;
        ComboData2 :PElShellComboData absolute Item2;
    begin
      Result := SmallInt(GetDesktopFolder.CompareIDs(0, ComboData1.PIDL, ComboData2.PIDL));
    end;

    procedure SortPIDLList(PIDLList: TElList);
    begin
      PIDLList.Sort(@CompareItems, Self);
    end;

  var
    PIDLList  :TElList;
    List      :IEnumIDList;
    PIDL      :PItemIDList;
    Flags     :Cardinal;
    i         :Integer;
    FAttr     :Cardinal;
    {$ifdef D_3}
    j     :Integer;
    {$else}
    j     :Cardinal;
    {$endif}
    k         :TShellAttr;
    MyComPIDL :PItemIDList;
    dFolder   :IShellFolder;
    iFolder   :IShellFolder;
    ComboData :PElShellComboData;
begin
  PIDLList := TElList.Create;
  try
    if Level = 0 then
    begin
      // level 0 is "desktop"
      ComboData := AddThisItem(BaseFolder, BasePIDL);
      inherited Items.AddObject(ComboData.DisplayName, TObject(ComboData));
      FillCombo(BaseFolder, BasePIDL, Level + 1);
    end
    else
    begin
      Flags := SHCONTF_FOLDERS;
      if ShowHidden then
        Flags := Flags or SHCONTF_INCLUDEHIDDEN;

      if SUCCEEDED(BaseFolder.EnumObjects(Handle, Flags, List)) then
      begin
        j := 0;
        while SUCCEEDED(List.Next(1, PIDL, j)) and (j > 0) and (PIDL <> nil) do
        begin
          if FileSystemOnly then
          begin
            k := SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR;
            if SUCCEEDED(BaseFolder.GetAttributesOf(1, PIDL, k)) then
              FAttr := k
            else
              FAttr := 0;
            if ((FAttr and SFGAO_FILESYSTEM) <> SFGAO_FILESYSTEM) and
               ((FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
              Continue;
          end;
          PIDLList.Add(AddThisItem(BaseFolder, PIDL));
        end;
      end;
      SortPIDLList(PIDLList);
      if Level in [1, 2] then
        SHGetSpecialFolderLocation(0, CSIDL_DRIVES, MyComPIDL);

      for i := 0 to PIDLList.Count - 1 do
      begin
        if PIDLContainsAt(FSelectionPIDL, GetOwnPIDL(PElShellComboData(PIDLList[i]).PIDL),
          Level)
        then
        begin
          ComboData := PIDLList[i];
          inherited Items.AddObject(ComboData.DisplayName, TObject(ComboData));
          dFolder := GetDesktopFolder;
          dFolder.BindToObject(PElShellComboData(PIDLList[i]).PIDL, nil, IShellFolder,
            Pointer(iFolder));
          FillCombo(iFolder, PElShellComboData(PIDLList[i]).PIDL, Level + 1);
        end
        else
        if (Level = 2) and CompareIDLists(BasePIDL, MyComPIDL) then
        begin
          ComboData := PIDLList[i];
          inherited Items.AddObject(ComboData.DisplayName, TObject(ComboData));
        end
        else
        if (Level = 1) and CompareIDLists(PElShellComboData(PIDLList[i]).PIDL, MyComPIDL) then
        begin
          ComboData := PIDLList[i];
          inherited Items.AddObject(ComboData.DisplayName, TObject(ComboData));
          dFolder := GetDesktopFolder;
          dFolder.BindToObject(MyComPIDL, nil, IShellFolder, Pointer(iFolder));
          FillCombo(iFolder, MyComPIDL, Level + 1);
        end
        else
        if (Level = 0) or (Level = 1) then
        begin
          ComboData := PIDLList[i];
          inherited Items.AddObject(ComboData.DisplayName, TObject(ComboData));
        end;
      end;
    end;
  finally
    PIDLList.Free;
  end;
end; { TElShellComboBox.FillCombo }

procedure TElShellComboBox.CreateWnd;
begin
  inherited;
  FillItems;
  ItemIndex := 0;
  //SyncControls(nil, True);
end;

procedure TElShellComboBox.SetShowHidden(Value: Boolean);
begin
  if FShowHidden <> Value then
  begin
    FShowHidden := Value;
    FillItems;
  end;
end;

procedure TElShellComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style  and (not CBS_DROPDOWN) or CBS_OWNERDRAWFIXED or
    CBS_DROPDOWNLIST and (not CBS_HASSTRINGS);
end;

function TElShellComboBox.GetItemWidth(Index: Integer): Integer;
  var
    S :String;
    C :PElShellComboData;
begin
  C := PElShellComboData(inherited Items.Objects[Index]);
  if Assigned(C) then
  begin
    S := C.DisplayName + 'W';
    Result := Canvas.TextWidth(S) + (C.Level + 1) * GetSystemMetrics(SM_CXSMICON);
  end
  else
    Result := GetSystemMetrics(SM_CXSMICON);
end;

procedure TElShellComboBox.SetFileSystemOnly(Value: Boolean);
begin
  if FFileSystemOnly <> Value then
  begin
    FFileSystemOnly := Value;
    FillItems;
  end;
end;

procedure TElShellComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  inherited ItemHeight := Max(Abs(Font.Height) + 2 + GetSystemMetrics(SM_CXEDGE) * 2,
    Max(ItemHeight, GetSystemMetrics(SM_CYSMICON)));
end;

procedure TElShellComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
  var
    S         :String;
    iw        :Integer;
    ih        :Integer;
    ComboData :PElShellComboData;
    Icon      :HICON;
    Flags     :Cardinal;
    Idx       :Cardinal;
    R         :TRect;
begin
  ComboData := PElShellComboData((inherited Items).Objects[Index]);
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect);

  if (WindowFromDC(Canvas.Handle) <> Handle) then
    inc(Rect.Left, ComboData.Level * GetSystemMetrics(SM_CXSMICON));

  iw := ShellIconCache.SmallImages.Width;
  ih := ShellIconCache.SmallImages.Height;

  if PIDLStartsWith(FSelectionPIDL, ComboData.PIDL) then
    Idx := ComboData.OpenIconIdx
  else
    Idx := ComboData.IconIdx;
  if odSelected in State then
  begin
    Flags := ILD_SELECTED;
    Canvas.Brush.Color := clHighlight;
    ShellIconCache.SmallImages.BlendColor := clHighlight;
  end
  else
  begin
    Flags := ILD_NORMAL;
  end;
  Icon := ImageList_GetIcon(ShellIconCache.SmallImages.Handle, Idx, Flags);
  DrawIconEx(Canvas.Handle, Rect.Left, Rect.Top + (Rect.Bottom - Rect.Top - ih) div 2, Icon,
    Min(ItemHeight, ih), Min(ItemHeight, iw), 0, 0, DI_NORMAL);
  DestroyIcon(Icon);
  Inc(Rect.Left, iw + 4);

  S := ComboData.DisplayName;
  Canvas.Brush.Color := clHighlight;
  R := Rect;
  DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_VCENTER or DT_NOPREFIX or DT_LEFT or
    DT_SINGLELINE or DT_CALCRECT);
  R.Top := Rect.Top;
  R.Bottom := Rect.Bottom;
  InflateRect(R, 2, 0);
  if ([odSelected, odFocused] * State <> []) then
    Canvas.FillRect(R)
  else
    Canvas.Brush.Style := bsClear;

  DrawText(Canvas.Handle, PChar(S), Length(S), Rect, DT_VCENTER or DT_NOPREFIX or DT_LEFT or
    DT_SINGLELINE);

  if odFocused in State then
    Canvas.DrawFocusRect(R);
end;

procedure TElShellComboBox.CNCommand(var Msg: TWMCommand);
begin
  if Msg.NotifyCode = CBN_SELENDOK then
  begin
    inherited;
    if ItemIndex < inherited Items.Count then
      SetSelection(PElShellComboData(inherited Items.Objects[ItemIndex]).PIDL);
  end
  else
    inherited;
end;

procedure TElShellComboBox.SetSelection(PIDL: PItemIDList);
begin
  SetSelectionPIDL(PIDL);
end;

function TElShellComboBox.SetSelectionPIDL(PIDL: PItemIDList):Boolean;
  var
    i           :Integer;
    MyComPIDL   :PItemIDList;
    ComboData   :PElShellComboData;
    SaveSelPIDL :PItemIDList;
    SaveIndex   :Integer;
begin
  if CompareIDLists(FSelectionPIDL, PIDL) then
  begin
    Result := True;
    exit;
  end
  else
    Result := False;

  SaveIndex   := ItemIndex;
  SaveSelPIDL := FSelectionPIDL;
  try
    FSelectionPIDL := ClonePIDL(PIDL);

    // Remove Big Level:
    i := 0;
    SHGetSpecialFolderLocation(0, CSIDL_DRIVES, MyComPIDL);
    while i < inherited Items.Count do
    begin
      ComboData := PElShellComboData(Inherited Items.Objects[i]);
      if not Result then
      begin
        if CompareIDLists(PIDL, ComboData.PIDL) then
        begin
          Result := True;
          ItemIndex := i;
        end;
        inc(i);
      end
      else
      begin
        if (ComboData.Level > 2) or
           (ComboData.Level = 2) and
           (not PIDLContainsAt(ComboData.PIDL, MyComPIDL, 1))
        then
          inherited Items.Delete(i)
        else
          inc(i);
      end;
    end;
    FreeIDList(MyComPIDL);

    // if not selected then fill now:
    if not Result then
    begin
      FillItems;
      // find selected:
      for i := 0 to inherited Items.Count - 1 do
      begin
        if CompareIDLists(PIDL, PElShellComboData(Inherited Items.Objects[i]).PIDL) then
        begin
          ItemIndex := i;
          Result := True;
          break;
        end;
      end;
      if not Result then
      begin
        if Assigned(FSelectionPIDL) then
          FreeIDList(FSelectionPIDL);
        if Assigned(SaveSelPIDL) and (not SetSelectionPIDL(SaveSelPIDL)) then
        begin
          ItemIndex := -1;
          if Assigned(FSelectionPIDL) then
            FreeIDList(FSelectionPIDL);
          FSelectionPIDL := GetEmptyPIDL;
        end;
      end;
    end;
  finally
    if Assigned(SaveSelPIDL) then
      FreeIDList(SaveSelPIDL);
  end;
  if Result or ((ItemIndex<0)and(SaveIndex<>ItemIndex)) then
    SyncControls(nil);
end;

function TElShellComboBox.GetEditorText:String;
begin
  if Assigned(FEditor) then
    Result := FEditor.Text
  else
    SetLength(Result,0);
end;

procedure TElShellComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  GetElReader.FakeDefineProperty(Filer);
end;

procedure TElShellComboBox.CNDrawItem(var Msg: TWMDrawItem);
  var
    State : {$ifndef VCL_5_USED}StdCtrls{$else}Windows{$endif}.TOwnerDrawState;
begin
  with Msg.DrawItemStruct^ do
  begin
    {$IFDEF VCL_5_USED}
    State := TOwnerDrawState(LongRec(itemState).Lo);
    {$ELSE}
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
    {$ENDIF}
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText
    end;
    if (Integer(itemID) >= 0) and (Integer(itemID) < inherited Items.Count) then
      DrawItem(itemID, rcItem, State)
    else
      Canvas.FillRect(rcItem);
    Canvas.Handle := 0;
  end;
end;

function TElShellComboBox.GetSelection: PItemIDList;
begin
  Result := FSelectionPIDL;
end;

procedure TElShellComboBox.SetAutoCompletion(Value:Boolean);
begin
  if FAutoCompletion<>Value then
  begin
    FAutoCompletion := Value;
    if Assigned(FEditor) then
      ElShellUtils.SetAutoComplete(FEditor.Handle, FAutoCompletion, False);
  end;
end;

procedure TElShellComboBox.ShowEdit;
  var
    R : TRect;
begin
  if FEditor = nil then
  begin
    FEditor := TElShellComboEdit.Create(nil);
    TElShellComboEdit(FEditor).BorderStyle := bsNone;
    TElShellComboEdit(FEditor).Font := Font;
    FEditor.Hide;
    FEditor.Parent := Self;
    if FAutoCompletion { [and|or] ExplorerStyle} then
      ElShellUtils.SetAutoComplete(FEditor.Handle, True, False);
  end
  else
    FEditor.Hide;

  FEditor.SetBounds(GetSystemMetrics(SM_CXEDGE) + GetSystemMetrics(SM_CXSMICON) + 3,
                    GetSystemMetrics(SM_CYEDGE),
                    Width - GetSystemMetrics(SM_CXVSCROLL) -
                            GetSystemMetrics(SM_CXSMICON) - 4 -
                            GetSystemMetrics(SM_CXEDGE) * 2 + 1,
                    Height - GetSystemMetrics(SM_CYEDGE) * 2);

  if (ItemIndex >= 0) and (ItemIndex < inherited Items.Count) then
  begin
    if PElShellComboData(inherited Items.Objects[ItemIndex]).Attr and SFGAO_FILESYSTEM <> 0 then
      FEditor.Text := PElShellComboData(inherited Items.Objects[ItemIndex]).FileName
    else
      FEditor.Text := PElShellComboData(inherited Items.Objects[ItemIndex]).DisplayName;
  end
  else
    FEditor.Text := '';

  R.Left := GetSystemMetrics(SM_CXEDGE) + 1;
  R.Top := (FEditor.Height - Abs(Font.Height) + 2) div 2 - 2;
  R.Bottom := R.Top + Abs(Font.Height) + 2;
  R.Right := FEditor.Width;
  FEditor.Perform(EM_SETRECT, 0, Integer(@R));
  FEditor.Show;
  FEditor.SetFocus;
  FEditor.SelectAll;
end;

procedure TElShellComboBox.KeyPress(var Key: Char);
begin
  if ExplorerStyle and (Key >= #32) then
  begin
    ShowEdit;
    FEditor.Text := Key;
    FEditor.SelStart := 1;
    FEditor.SelLength := 0;
    Key := #0;
  end
  else
    inherited;
end;

procedure TElShellComboBox.DropDown;
begin
  CancelEdit;
  inherited;
end;

procedure TElShellComboBox.CancelEdit;
begin
  if FEditor <> nil then
  begin
    SetFocus;
    FEditor.Hide;
  end;
end;

procedure TElShellComboBox.WMDeleteItem(var Message: TMessage);
  var
    St :PDeleteItemStruct;
begin
  St := PDeleteItemStruct(Message.LParam);
  if (St.itemData <> 0) then
    Dispose(PElShellComboData(St.ItemData));
  St.ItemData := 0;
  inherited;
end;

procedure TElShellComboBox.AcceptEdit;
  var
    PIDL        :PItemIDList;
    sEditorText :String;
begin
  if FEditor <> nil then
  begin
    sEditorText := FEditor.Text;
    CancelEdit;
    PIDL := GetPIDLFromPath(sEditorText);
    if PIDL <> nil then
    begin
      SetSelection(PIDL);
      FreeIDList(PIDL);
      //Change;
    end;
    Change;
  end;
end;

procedure TElShellComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if ExplorerStyle and
   (X < (Width - GetSystemMetrics(SM_CXEDGE) - GetSystemMetrics(SM_CXVSCROLL))) and
   (X > GetSystemMetrics(SM_CXEDGE)  + 4 + GetSystemMetrics(SM_CXSMICON)) then
    inherited Cursor := crIBeam
  else
    inherited Cursor := Cursor;
  inherited;
end;

procedure TElShellComboBox.WMLButtonDown(var Message: TWMMouse);
begin
  if ExplorerStyle and
     (Message.XPos < (Width - GetSystemMetrics(SM_CXEDGE) - GetSystemMetrics(SM_CXVSCROLL))) and
     (Message.XPos > GetSystemMetrics(SM_CXEDGE)  + 4 + GetSystemMetrics(SM_CXSMICON)) then
  begin
    ShowEdit;
    Exit;
  end;
  CancelEdit;
  inherited;
end;

procedure TElShellComboBox.SetCursor(Value: TCursor);
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
    inherited Cursor := Cursor;
  end;
end;

procedure TElShellComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if (FStyle <> Value) and (Value in [Low(TComboBoxStyle)..High(TComboBoxStyle)]) then
  begin
    FStyle := Value;
  end;
end;

procedure TElShellComboBox.DestroyWnd;
begin
  inherited Items.Clear;
  inherited;
end;

procedure TElShellComboBox.SyncControls(Sender: TObject);
  var
    APIDL                         :PItemIDList;
    bNeedSyncShellList            :Boolean;
    STV_ItemFocused_Parent        :TElShellTreeItem;
    SaveListIsUpdating            :Boolean;
    SaveTreeIsUpdating            :Boolean;
    bTree, bList                  :Boolean;
begin
  if fIsSyncControls or (not HandleAllocated) or
     ((FShellTreeView=nil)and(FShellListView=nil)) or
     (Assigned(inherited Items) and (inherited Items.Count=0))
  then
    exit;

  APIDL := Selection;
  bNeedSyncShellList := False;
  SaveTreeIsUpdating := False;
  SaveListIsUpdating := False;
  bTree := False;
  bList := False;
  fIsSyncControls := True;
  try

    // ShellListView:
    if Assigned(ShellListView) and (not ShellListView.fIsSyncControls) and
       (ShellListView.HandleAllocated) and ( (Sender=nil) or (Sender=ShellListView) )
    then
    begin
      bList := True;
      ShellListView.fIsSyncControls := True;
      SaveListIsUpdating := ShellListView.IsUpdating;
      if not ShellListView.IsUpdating then
        ShellListView.IsUpdating := True;
      //ShellListView.Items.BeginUpdate;
      ShellListView.DeselectAll;
      if not ShellListView.SetRootPIDL(APIDL) then
        // Need Synchronize Shell List to Parent ShellTree
        bNeedSyncShellList := True;
    end;

    // ShellTreeView:
    if Assigned(ShellTreeView) and (not ShellTreeView.fIsSyncControls) and
       (ShellTreeView.HandleAllocated) and ( (Sender=nil) or (Sender=ShellTreeView) ) and
       (not ShellTreeView.IsSelectionPIDL(APIDL))
    then
    begin
      bTree := True;
      ShellTreeView.fIsSyncControls := True;
      SaveTreeIsUpdating := ShellTreeView.IsUpdating;
      if not ShellTreeView.IsUpdating then
        ShellTreeView.IsUpdating := True;
      //ShellTreeView.Items.BeginUpdate;
      ShellTreeView.DeselectAll;
      if (ItemIndex=0)or(ItemIndex=-1) then
      begin
        ShellTreeView.RootFolder := sfoDesktop;
        ShellTreeView.SetSelectionPIDL(nil);
      end
      else
      begin
        if (not ShellTreeView.SetSelectionPIDL(APIDL)) and
           (ShellTreeView.RootFolder <> sfoDesktop)
        then
        begin
          ShellTreeView.RootFolder := sfoDesktop;
          bNeedSyncShellList := ShellTreeView.SetSelectionPIDL(APIDL) and bNeedSyncShellList;
        end;
        if bNeedSyncShellList and (Assigned(ShellTreeView.ItemFocused)) then
        begin
          // Need Synchronize Shell List to Parent ShellTree
          STV_ItemFocused_Parent := TElShellTreeItem(ShellTreeView.ItemFocused.Parent);
          if Assigned(STV_ItemFocused_Parent) and
             ShellListView.SetRootPIDL(STV_ItemFocused_Parent.FullPIDL)
          then
            ShellListView.SetSelectionPIDL(ShellTreeView.ItemFocused.PIDL);
        end;
      end;
    end;

  finally
    fIsSyncControls := False;
    if bList then
    begin
      ShellListView.fIsSyncControls := False;
      if ShellListView.IsUpdating <> SaveListIsUpdating then
        ShellListView.IsUpdating := SaveListIsUpdating;
      //ShellListView.Items.EndUpdate;
    end;
    if bTree then
    begin
      ShellTreeView.fIsSyncControls := False;
      if ShellTreeView.IsUpdating <> SaveTreeIsUpdating then
        ShellTreeView.IsUpdating := SaveTreeIsUpdating;
      //ShellTreeView.Items.EndUpdate;
      ShellTreeView.EnsureVisible(ShellTreeView.ItemFocused);
    end;
    Invalidate;   end;
end;

function TElShellComboBox.SetSelectionPath(Path:String):Boolean;
  var
    APIDL :PItemIDList;
begin
  if FileExists(Path) then
    Path := ExtractFilePath(Path);
  APIDL := SHGetPIDLFromPath( GetDesktopFolder, Path);
  if Assigned(APIDL) then
  begin
    Result := SetSelectionPIDL(APIDL);
    FreeIDList(APIDL);
  end
  else
    Result := False;
end;

procedure TElShellComboBox.SynclShellComboBox(ShellComboBox: TElShellComboBox);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellComboBox=nil) or (ShellComboBox.fIsSyncControls) or
     (not ShellComboBox.HandleAllocated) or (ShellComboBox=Self)
  then
    exit;
  ShellComboBox.SetSelection(Selection);
end;

procedure TElShellComboBox.SynclShellTree(ShellTree: TElShellTree);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellTree=nil) or (ShellTree.fIsSyncControls) or
     (not ShellTree.HandleAllocated)
  then
    exit;
  ShellTree.SetSelectionPIDL(Selection);
end;

procedure TElShellComboBox.SyncShellList(ShellList :TElShellList);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellList=nil) or (ShellList.fIsSyncControls) or
     (not ShellList.HandleAllocated)
  then
    exit;
  ShellList.SetRootPIDL(Selection);
end;

procedure TElShellComboBox.FillItems;
  var
    PIDL     :PItemIDList;
    sCursor  :TCursor;
begin
  sCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  inherited Items.BeginUpdate;
  try
    inherited Items.Clear;
    PIDL := GetEmptyPIDL;
    FillCombo(GetDesktopFolder, PIDL, 0);
    FreeIDList(PIDL);
  finally
    inherited Items.EndUpdate;
    if Screen.Cursor <> sCursor then
      Screen.Cursor := sCursor;
  end;
end;


procedure TElShellComboBox.SetShellListView(Value: TElShellList);
begin
  if FShellListView <> Value then
  begin
    if (FShellListView <> nil) then
      FShellListView.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellListView <> nil) and (not (csDestroying in FShellListView.ComponentState)) then
      FShellListView.RemoveFreeNotification(Self);
    {$endif}

    FShellListView := Value;
    if (FShellListView <> nil) then
    begin
      FShellListView.FreeNotification(Self);
      SyncControls(FShellListView);
    end;
  end;
end;

procedure TElShellComboBox.SetShellTreeView(Value: TElShellTree);
begin
  if FShellTreeView <> Value then
  begin
    if FShellTreeView <> nil then
      FShellTreeView.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellTreeView <> nil) and (not (csDestroying in FShellTreeView.ComponentState)) then
      FShellTreeView.RemoveFreeNotification(Self);
    {$endif}

    FShellTreeView := Value;
    if (FShellTreeView <> nil) then
    begin
      FShellTreeView.FreeNotification(Self);
      SyncControls(FShellTreeView);
    end;
  end;
end;

procedure TElShellComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = ShellListView) and (Operation = opRemove) then
    FShellListView := nil;
  if (AComponent = ShellTreeView) and (Operation = opRemove) then
    FShellTreeView := nil;
end;

{ TElShellList }

procedure TElShellList.SetShowHeader(Value: Boolean);
begin
  if (ComponentState * [csReading, csLoading] <> [])  then
    FSaveShowHeader := value;
  if (not Value) or (ComponentState * [csREading, csLoading] = []) then
    inherited;
end;

procedure TElShellList.SetCustomFolder(const Value: String);
begin
  if FCustomFolder <> Value then
  begin
    FCustomFolder := Value;
    if FFolder = sfoCustom then
    begin
      if Length(CustomFolder)=0 then
        SetFolder(sfoDesktop)
      else
        SetPIDL(GetFolderPIDL(sfoCustom, CustomFolder));
    end;
  end;
end;

procedure TElShellList.SetDefaultColumns(Value: Boolean);
  var
    MainTreeCol: Integer;
begin
  if FDefaultColumns <> Value then
  begin
    FDefaultColumns := Value;
    MainTreeCol := DeleteDefaultColumns;
    if FDefaultColumns then
    begin
      AddDefaultColumns;
      FMainTreeCol := MainTreeCol;
    end;
  end;
end;

function TElShellList.GetFocusedDisplayName: String;
  var
    PIDL :PItemIDList;
begin
  PIDL := GetFocusedPIDL;
  if (PIDL <> nil) and (GetPathFromPIDL(PIDL, Result)) then
  begin
    if (PIDL <> nil) then
      FreeIDList(PIDL);
  end
  else
    SetLength(Result, 0);
end;

function TElShellList.GetFocusedPIDL: PItemIDList;
begin
  if ItemFocused <> nil then
    Result := TElShellListItem(ItemFocused).BuildFullPIDL
  else
    Result := nil;
end;

function TElShellList.GetItemFocused: TElShellListItem;
begin
  Result := TElShellListItem(inherited ItemFocused);
end;

procedure TElShellList.SetHighlightCompressed(Value: Boolean);
begin
  if FHighlightCompressed <> Value then
  begin
    FHighlightCompressed := Value;
    RefreshList(False);
  end;
end;

procedure TElShellList.SetItemFocused(const Value: TElShellListItem);
begin
  inherited ItemFocused := Value;
end;

procedure TElShellList.SetFolder(Value: TShellFolders);
begin
  if FFolder <> Value then
  begin
    FFolder := Value;
    {if (FFolder = sfoCustom) and (Length(CustomFolder)=0) and (not (csLoading in ComponentState))
    then
      FFolder := sfoDesktop;{}
    SetPIDL(GetFolderPIDL(FFolder, CustomFolder));
  end;
end;

procedure TElShellList.SetShowHidden(Value: Boolean);
begin
  if FShowHidden <> Value then
  begin
    FShowHidden := Value;
    RefreshList(False);
  end;
end;

procedure TElShellList.SetSizeFormat(Value: TElShellSizeFormat);
  var
    i :Integer;
begin
  if FSizeFormat <> Value then
  begin
    FSizeFormat := Value;
    for i := 0 to FALlList.Count - 1 do
      TElShellListItem(FAllList[i]).FSizeAsString := cShellNullStr;
    Invalidate;
  end;
end;

procedure TElShellList.SetSortModifiers(Value: TElShellSortModifiers);
begin
  if FSortModifiers <> Value then
  begin
    FSortModifiers := Value;
    if SortMode in [smAdd, smAddClick] then
      Sort(True);
  end;
end;

procedure TElShellList.SetSortType(Value: TElShellSortType);
begin
  if FSortType <> Value then
  begin
    FSortType := Value;
    if SortMode in [smAdd, smAddClick] then
      Sort(True);
  end;
end;

procedure TElShellList.SetPIDL(PIDL: PItemIDList);
  var
    iFolder     :IShellFolder;
    hRes        :HRESULT;
    OLDRootPIDL :PItemIDList;
    OLDIFolder  :IShellFolder;
    OLDAttr     :TShellAttr;
    OLDFolder   :TShellFolders;
begin
  if PIDL=nil then
  begin
    if FRootPIDL=nil then
      exit;
    Items.BeginUpdate;
    try
      Items.Clear;
      if FRootPIDL <> nil then
      begin
        FreeIDList(FRootPIDL);
        FIFolder  := nil;
        FAttr     :=0;
      end;
    finally
      Items.EndUpdate;
    end;
    SyncControls(nil);
    if Assigned(OnRootChanged) then
      OnRootChanged(Self);
    exit;
  end;
  OLDRootPIDL := FRootPIDL;
  OLDIFolder  := FIFolder;
  OLDAttr     := FAttr;
  OLDFolder   := Folder;
  try
    FRootPIDL := PIDL;
    iFolder := GetDesktopFolder;
    if (Folder <> sfoDesktop) and (Folder <> sfoDesktopExpanded) then
    begin
      hRes := iFolder.BindToObject(FRootPIDL, nil, IID_IShellFolder, Pointer(FIFolder));
      if not SUCCEEDED(hRes) then
        raise Exception.Create('Failed to get IShellFolder for specified root');
      iFolder := nil;
    end
    else
      FIFolder := iFolder;

    FIFolder.GetAttributesOf(1, FRootPIDL, FAttr);

    RefreshList(True);

    if OLDRootPIDL <> nil then
      FreeIDList(OLDRootPIDL);

    SyncControls(nil);

    if Assigned(OnRootChanged) then
      OnRootChanged(Self);

  except
    if FRootPIDL <> nil then
    begin
      FreeIDList(FRootPIDL);
      FIFolder  := nil;
    end;
    if OLDRootPIDL<>nil then
    begin
      FRootPIDL := OLDRootPIDL;
      FIFolder  := OLDIFolder;
      FAttr     := OLDAttr;
      Folder    := OLDFolder;
      RefreshList(True);
      if OLDRootPIDL <> nil then
        FreeIDList(OLDRootPIDL);
    end;
  end;
end;

procedure TElShellList.AddDefaultColumns;
  var
    i              :Integer;
    IFolder        :IShellFolder;
    IFolder2       :IShellFolder2;
    IDetails       :IShellDetails;
    sd             :TShellDetails;
    hres           :HResult;
    ASection       :TElHeaderSection;
    SaveIsUpdating :Boolean;
begin
  SaveIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  try

    iFolder := FIFolder;
    if iFolder <> nil then
    begin
      if not SUCCEEDED(iFolder.CreateViewObject(Handle, IShellDetails, Pointer(IDetails))) then
      begin
        if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
        begin
          IDetails := TElShellDefaultColumns.Create as IShellDetails;
        end;
      end;
    end;
    i := 0;
    repeat
      if IFolder2 <> nil then
        hRes := IFolder2.GetDetailsOf(nil, i, SD)
      else
      if IDetails <> nil then
        hRes := IDetails.GetDetailsOf(nil, i, SD)
      else
        hRes := E_FAIL;

      if hRes = S_OK then
      begin
        ASection := HeaderSections.InsertSection(i);
        with ASection do
        begin
          Text := StrRetToPas(SD.str, nil);
          StrRetFree(SD.str);
          AutoSize := False;
          FieldType := sftCustom;
          Editable := i = siName;
          Visible := InRange(siMin, siMax, i);
          Tag := siBase + i;
        end;
        if Assigned(fOnAddColumn) then
          fOnAddColumn(Self, i);
      end;

      inc(i);
    until hRes <> S_OK;

    FMaxColumns := i - 1;

    AutoSizeAllColumns;

  finally
    if IsUpdating <> SaveIsUpdating then
      IsUpdating := SaveIsUpdating;
  end;
end;

procedure TElShellList.MouseLButtonDblClickExt(X, Y: Integer; Shift: TShiftState);
  var
    ItemPart :TSTItemPart;
    HCol     :Integer;
begin
  if FAutoNavigate then
  begin
    HCol := 0;
    MouseLButtonDblClickItem(
      TElShellListItem( GetItemAt(X, Y, ItemPart, HCol) ),
      Shift
    );
  end;
end;

procedure TElShellList.MouseLButtonDblClickItem(Item: TElShellListItem; Shift: TShiftState);
  var
    SavePath :String;
    vPIDL    :PItemIDList;
begin
  if Assigned(Item) then
  with Item do
  begin
    if ssAlt in Shift then // <ALT> + [DblClick|RETURN]
      ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
        FIFolder, 'properties')
    else
    begin
      if IsFolder and (Shift = []) then
      begin
        vPIDL := BuildFullPIDL;
        try
          SetRootPIDL(vPIDL);
        finally
          FreeIDList(vPIDL);
        end;
      end
      else
      if FAutoExecute and
      ( (not isFolder and (Shift=[])) or
        (isFolder and (ssCtrl in Shift))
      )
      then
      begin
        SetLength(SavePath, MAX_PATH);
        SetLength(SavePath, GetCurrentDirectory(MAX_PATH, PChar(SavePath)) );
        SetCurrentDirectory(PChar(GetPathFromPIDL2(FRootPIDL)));
        vPIDL := BuildFullPIDL;
        try
          ShellExecutePIDL(vPIDL);
        finally
          FreeIDList(vPIDL);
          SetCurrentDirectory(PChar(SavePath));
        end;
      end;
    end;
  end;
end;

procedure TElShellList.KeyDownTransfer(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited KeyDownTransfer(Sender, Key, Shift);

  if GetKeyState(VK_MENU) < 0 then
    Include(Shift, ssAlt);

  if FAutoNavigate then
    case Key of
      VK_DELETE: // todo: for all selected
        if not IsEditing then
        begin
          Key := 0;
          if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              FIFolder, 'delete');
        end;
      VK_F5:
        if not IsEditing then
        begin
          Key := 0;
          RefreshList(False);
        end;
      VK_RETURN:
        if not IsEditing then
        begin
          Key := 0;
          MouseLButtonDblClickItem(ItemFocused, Shift);
        end;
      VK_BACK:
        if (not IsEditing) then
        begin
          Key := 0;
          if not (ssAlt in Shift) then
            BackToParentPIDL;
        end;
    end;
end;

procedure TElShellList.KeyPressTransfer(Sender: TObject; var Key: Char);
begin
  inherited KeyPress(Key);
  if FAutoNavigate then
    case Word(Key) of
      Word(^C):
        if not IsEditing then
        begin
         if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              FIFolder, 'copy');
          Key := #0;
        end;
      Word(^V):
        if not IsEditing then
        begin
          if Assigned(ItemFocused) and ((ItemFocused.FAttr and SFGAO_FOLDER)<>0) then
            // paste to current focused folder
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              FIFolder, 'paste')
          else
            // paste to root folder
            ExecutePIDLContextMenuVerb(Handle, GetLastPIDL(FRootPIDL),
              GetParentFolder(FRootPIDL), 'paste');
          Key := #0;
        end;
      Word(^X):
        if not IsEditing then
        begin
         if Assigned(ItemFocused) then
            ExecutePIDLContextMenuVerb(Handle, ItemFocused.FPIDL,
              FIFolder, 'cut');
          Key := #0;
        end;
    end;
end;

function TElShellList.DeleteDefaultColumns: Integer;
  var
    j, m     :Integer;
    ASection :TElHeaderSection;
begin
  j := 0;
  m := HeaderSections.Count;
  while j <= HeaderSections.Count - 1 do
  begin
    ASection := HeaderSections[j];
    if InRange(siBase, siBase + {FMaxColumns}m, ASection.Tag) then
    {if siBase = ASection.Tag then}
      HeaderSections.DeleteSection(ASection)
    else
      inc(j);
  end;
  Result := j;
end;

procedure TElShellList.SetShowFiles(Value: Boolean);
begin
  if FShowFiles <> Value then
  begin
    FShowFiles := Value;
    RefreshList(False);
  end;
end;

procedure TElShellList.SetShowFolders(const Value: Boolean);
begin
  if FShowFolders <> Value then
  begin
    FShowFolders := Value;
    RefreshList(False);
  end;
end;

function TElShellList.RefreshList(bReload: Boolean):Boolean;
  var
    i              :TShellAttr;
    {$ifdef D_3}
    j              :Integer;
    {$else}
    j              :Cardinal;
    {$endif}
    FAttr          :Cardinal;
    List           :IEnumIDList;
    Flags          :Cardinal;
    PIDL           :PItemIDList;
    Child          :TElShellListItem;
    S              :String;
    str            :TStrRet;
    chF            :IShellFolder;
    b              :Boolean;
    MainTreeCol    :Integer;
    bObjVisible    :Boolean;
    sCursor        :TCursor;
    SaveIsUpdating :Boolean;
begin
  if (csLoading in ComponentState) then
  begin
    Result := True;
    exit;
  end;
  sCursor := Screen.Cursor;
  if Visible and HandleAllocated then
    Screen.Cursor := crHourGlass;

  SaveIsUpdating := IsUpdating;
  if not IsUpdating then
    IsUpdating := True;
  try
    Items.BeginUpdate;

    if bReload then
      Items.Clear;

    b := ShowColumns;
    if DefaultColumns then
    begin
      MainTreeCol := DeleteDefaultColumns;
      AddDefaultColumns;
      FMainTreeCol := MainTreeCol;
      ShowColumns := b;
    end;

    Flags := SHCONTF_FOLDERS;
    if ShowHidden then
      Flags := Flags or SHCONTF_INCLUDEHIDDEN;
    if ShowFiles then
      Flags := Flags or SHCONTF_NONFOLDERS;

    List := nil;
    // get enumerator to walk through object
    if SUCCEEDED(FIFolder.EnumObjects(Handle, Flags, List)) then
    begin
      j := 0;
      chF := nil;
      PIDL := nil;

      // invalidate all items. We will validate them as the shell provides right PIDLs
      // and then we'll remove all items, that will remain invalid
      i := 0;
      while i < Cardinal(Items.Count) do
      begin
        TElShellListItem(Items[i]).FValid := False;
        inc(i);
      end;
      // first grab all child PIDLs
      while SUCCEEDED(List.Next(1, PIDL, j)) and (j > 0) and (PIDL <> nil) do
      begin

        // Read some attributes for filtering:
        i := SFGAO_FOLDER or SFGAO_FILESYSTEM or SFGAO_FILESYSANCESTOR or SFGAO_BROWSABLE;
        if SUCCEEDED(FIFolder.GetAttributesOf(1, PIDL, i)) then
          FAttr := i
        else
          FAttr := 0;

        if FileSystemOnly and
           ((FAttr and SFGAO_FOLDER)<>SFGAO_FOLDER) and // show all folders
           ((FAttr and SFGAO_FILESYSTEM) <> SFGAO_FILESYSTEM) and
           ((FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
        begin
          FreeIDList(PIDL);
          Continue;
        end;

        ZeroMemory(@Str, SizeOf(Str));
        Str.uType := STRRET_CSTR;

        if SUCCEEDED(FIFolder.GetDisplayNameOf(PIDL, SHGDN_INFOLDER or SHGDN_FORADDRESSBAR,
          str)) then
        begin
          S := StrRetToPas(str, PIDL);
          StrRetFree(str);
        end
        else
          SetLength(S, 0);

        // Filtering of Enum Object:
        if ShowFiles then
        begin
          bObjVisible := ((FAttr and SFGAO_FOLDER)=SFGAO_FOLDER);// = ObjectIsFolder (show all folders)
          if (not bObjVisible) then // <=>: "if not ObjectIsFolder"
          begin
            if (FAttr and SFGAO_FILESYSTEM) <> 0 then // applyong FileSystem File Filter
            begin
              if ShowFiles and FileFiltered then
                bObjVisible := NameFiltered(S, FIFolder, PIDL)
              else
                bObjVisible := True;
              end
            else
              bObjVisible := True;
          end;
        end
        else
          bObjVisible := True;

       if bObjVisible and (not ShowFolders) and ((FAttr and SFGAO_FOLDER)=SFGAO_FOLDER) then
         bObjVisible :=
            ((FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) and // - Show Zip Files
            ((FAttr and SFGAO_BROWSABLE) = SFGAO_BROWSABLE);                 // - Skip 'Recycled' folder

        if bObjVisible and FileFiltered and Assigned(OnItemAdding) then
          OnItemAdding(Self, S, FIFolder, PIDL, bObjVisible);

        if bObjVisible then
        begin
          if bReload then
            Child := nil
          else
            Child := FindItemByPIDL(PIDL);

          if Child = nil then
          begin
            Child := TElShellListItem(Items.AddItem(nil));
            FreeIDList(Child.FPIDL);
          end
          else
          begin
            Child.Invalidate;
            if Child.FPIDL <> nil then
              FreeIDList(Child.FPIDL);
          end;
          Child.FPIDL := PIDL;
          Child.GetAttributes(FIFolder);

          Child.FValid := True;
          DoItemAdded(S, FIFolder, PIDL, Child);
        end
        else
        begin
          if not bReload then
          begin
            Child := FindItemByPIDL(PIDL);
            if Child <> nil then
              Items.DeleteItem(Child);
          end;
          FreeIDList(PIDL);
        end;
      end;

      // now check for invalid tree items and remove them
      i := 0;
      while i < Cardinal(Items.Count) do
      begin
        if TElShellListItem(Items[i]).FValid then
          inc(i)
        else
          Items.DeleteItem(Items[i]);
      end;
      Result := True;
    end
    else
    begin
      Items.Clear;
      Result := False;
    end;

    Sort(True);

    List := nil;

  finally
    Items.EndUpdate;
    if IsUpdating <> SaveIsUpdating then
      IsUpdating := SaveIsUpdating;
    if Screen.Cursor <> sCursor then
      Screen.Cursor := sCursor;
  end;
end;

procedure TElShellList.TriggerSortBegin;
begin
  if SortMode in [smClick, smAddClick] then
  begin
    if ShowColumns then
    begin
      if SortSection in [siMin..siMax] then
        SortType := ColumnSortTypes[SortSection]
      else
      if SortSection = -1 then
        SortType := sstDefault
      else
        SortType := sstCustom;
    end
    else
    begin
      SortSection := -1;
    end;
  end;
end;

procedure TElShellList.TriggerTryEditEvent(Item: TElTreeItem; SectionIndex :Integer;
  var CellType: TElFieldType; var CanEdit: Boolean);
begin
  if CanEdit then
  begin
    if ShowColumns then
    begin
      if SectionIndex = -1 then
        SectionIndex := MainTreeColumn;

      CanEdit := HeaderSections[SectionIndex].Tag = siName;
    end;
    if CanEdit then
      CanEdit := TElShellListItem(Item).CanRename;
  end
end;

procedure TElShellList.TriggerVirtualTextNeeded(Item: TElTreeItem; SectionIndex: Integer;
  var Text: TElFString);
  var
    Index    :Integer;
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    sd       :TShellDetails;
    hres     :HResult;
begin
  if (SectionIndex <> -1) and (HeaderSections.Count > SectionIndex) then
    Index := HeaderSections[SectionIndex].Tag
  else
    Index := siName;
  if (Index = siName) or InRange(siBase, siBase + FMaxColumns, Index) then
  begin
    if (Index = siName) or (Index = siName + siBase) then
      Text := TElShellListItem(Item).DisplayName
    else
    begin
      SetLength(Text, 0);
      iFolder := FIFolder;

      if not SUCCEEDED(iFolder.CreateViewObject(Handle, IShellDetails, Pointer(IDetails))) then
      begin
        if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
        begin
          IDetails := TElShellDefaultColumns.Create as IShellDetails;
        end;
      end;

      ZeroMemory(@SD, SizeOf(SD));
      SD.fmt := STRRET_CSTR;
      if IFolder2 <> nil then
        hRes := IFolder2.GetDetailsOf(TElShellListItem(Item).PIDL, Index - siBase, SD)
      else
        hRes := IDetails.GetDetailsOf(TElShellListItem(Item).PIDL, Index - siBase, SD);
      if hRes = S_OK then
      begin
        Text := StrRetToPas(SD.str, nil);
        StrRetFree(SD.str);
      end;
    end;
  end
  else
    inherited;
end;

procedure TElShellList.TriggerVirtualValueNeeded(Item: TElTreeItem; SectionIndex: Integer;
  VarType: Integer; var Value: Variant);
begin
  Value := Unassigned;
end;

procedure TElShellList.SetFileSystemOnly(Value: Boolean);
begin
  if FFileSystemOnly <> Value then
  begin
    FFileSystemOnly := Value;
    if ShowFiles then
      RefreshList(False);
  end;
end;

function TElShellList.FindItemByPIDL(APIDL : PItemIDList): TElShellListItem;
  var
    i :Integer;
begin
  for i := 0 to Items.Count - 1 do
  begin
    if CompareIDLists(APIDL, TElShellListItem(Items[i]).FPIDL) then
    begin
      Result := TElShellListItem(Items[i]);
      exit;
    end;
  end;
  Result := nil;
end;

function TElShellList.NameFiltered(const S: String; const ShellFolder: IShellFolder;
    RelPIDL: PItemIDList): Boolean;
  var
    i :Integer;
begin
  {$ifndef B_4}
  Result := (FFileMasks=nil);
  if not Result then
    for i:=0 to FFileMasks.Count-1 do
    begin
      if TMask(FFileMasks[i]).Matches(S) then
      begin
        Result := True;
        break;
      end;
    end;
  {$else}
    {$ifdef VCL_5_USED}
    Result := (FFileFilters.Count=0);
    if not Result then
      for i:=0 to FFileFilters.Count-1 do
      begin
        if FileNameLike( S, FFileFilters[i] ) then
        begin
          Result := True;
          break;
        end;
      end;
    {$else}
    Result := True;
    {$endif}
  {$endif}
end;

function TElShellList.GetFileFilters: TStrings;
begin
  Result := FFileFilters;
end;

procedure TElShellList.SetFileFilters(const Value: TStrings);
begin
  FFileFilters.Assign(Value);
end;

constructor TElShellList.Create(AOwner: TComponent);
begin
  inherited;
  FAutoNavigate := True;
  Images := ShellIconCache.SmallImages;
  VirtualityLevel := vlTextAndStyles;
  FHeader.InvertSortArrows := True;
  FFolder  := sfoDesktop;
  FShowHidden  := True;
  FShowFiles := True;
  FShowFolders := True;
  FFileFilters := TStringList.Create;
  FFileFilters.OnChange := FileFiltersChange;
  FSortType := sstDefault;
  FSortMode := smAddClick;
  FSortModifiers := [ssmFoldersFirst, ssmExecutablesFirst];
  FHighlightCompressed := True;
  FDefaultEditor := True;
  ShowRootButtons := False;
  ShowLines := False;
  ShowButtons := True;
  FEditor := TElTreeInplaceEdit.Create(nil);
  FEditor.OnBeforeOperation := OnBeforeOperation;
  FEditor.OnValidateResult := OnValidateEdit;
  ShowEmptyImages := True;
  inherited SortType := stCustom;
end;

procedure TElShellList.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('ShowEmptyImages', FakeBoolean, nil, False);
    Filer.DefineProperty('FilteredVisibility', FakeBoolean, nil, False);
    Filer.DefineProperty('AutoExpand', FakeBoolean, nil, False);
    Filer.DefineProperty('AutoUpdate', FakeBoolean, nil, False);
  end;
end;

destructor TElShellList.Destroy;
  {$ifndef B_4}
  var
    i:Integer;
  {$endif}
begin
  FShellComboBox := nil;
  FShellTreeView := nil;
  FEditor.Free;
  FIFolder := nil;
  FFileFilters.Free;
  {$ifndef B_4}
  if Assigned(FFileMasks) then
  begin
    for i:=0 to FFileMasks.Count-1 do
      TMask(FFileMasks[i]).Free;
    FFileMasks.Free;
  end;
  {$endif}
  Items.Clear;
  FreeIDList(FFocusedPIDL);
  FreeIDList(FRootPIDL);
  inherited;
end;


procedure TElShellList.CreateWnd;
begin
  inherited;
end;

procedure TElShellList.WMDestroy(var Message: TWMDestroy);
begin
  inherited;
end;

procedure TElShellList.WndProc(var Message: TMessage);
begin
    inherited WndProc(Message);
end;

procedure TElShellList.FileFiltersChange(Sender: TObject);
  {$ifndef B_4}
  var
    i     :Integer;
    Mask  :TMask;
    sMask :String;
  {$endif}
begin
  {$ifndef B_4}
  if Assigned(FFileMasks) then
  begin
    for i:=0 to FFileMasks.Count-1 do
      TMask(FFileMasks[i]).Free;
  end;
  if FFileFilters.Count >0 then
  begin
    if FFileMasks = nil then
      FFileMasks := TList.Create;
    Mask:=nil;
    for i:=0 to FFileFilters.Count-1 do
    begin
      sMask := FFileFilters[i];
      if Length(sMask)=0 then
        Continue;
      // check syntax mask (skip bad mask):
      try
        Mask := TMask.Create(sMask);
        Mask.Matches('test');
        FFileMasks.Add(Mask);
      except
        Mask.Free;
      end;
    end;
  end;

  if Assigned(FFileMasks) and (FFileMasks.Count=0) then
  begin
    FFileMasks.Free;
    FFileMasks := nil;
  end;
  {$endif}
  if ShowFiles and FileFiltered then
    RefreshList(False);
end;

procedure TElShellList.SetFileFiltered(const Value: Boolean);
begin
  if Value<>FFileFiltered then
  begin
    FFileFiltered := Value;
    if ShowFiles then
      RefreshList(False);
  end;
end;

procedure TElShellList.CreateHandle;
  var
    PIDL : PItemIDList;
begin
  inherited;
  PIDL := GetFolderPIDL(FFolder, CustomFolder);
  SetRootPIDL(PIDL);
  FreeIDList(PIDL);
end;

function TElShellList.CreateItems: TElTreeItems;
begin
  Result := inherited CreateItems;
  Result.ItemClass := TElShellListItem;
end;

function TElShellList.CreateView: TElTreeView;
begin
  Result := TElShellListView.Create(Self);
end;

function TElShellList.SetRootPIDL(PIDL: PItemIDList): Boolean;
  var
    iFolder      :IShellFolder;
    hRes         :HRESULT;
    SaveRootPIDL :PItemIDList;
    SaveIFolder  :IShellFolder;
    SaveFolder   :TShellFolders;
    SaveAttr     :TShellAttr;
begin
  Result := CompareIDLists(FRootPIDL, PIDL);
  if Result then
    exit;

  SaveRootPIDL := FRootPIDL;
  SaveIFolder  := FIFolder;
  SaveFolder   := Folder;
  SaveAttr     := FAttr;
  FreeIDList(FFocusedPIDL);

  try

    if Assigned(PIDL) then
      FRootPIDL := ClonePIDL(PIDL)
    else
    begin
      Items.BeginUpdate;
      try
        Items.Clear;
        if Assigned(FRootPIDL) then
        begin
          FreeIDList(FRootPIDL);
          FIFolder  := nil;
          FAttr     := 0;
        end;
      finally
        Items.EndUpdate;
      end;
      SyncControls(nil);
      if Assigned(OnRootChanged) then
        OnRootChanged(Self);
      Result := True;
      exit;
      //FRootPIDL := GetEmptyPIDL;
    end;

    iFolder := GetDesktopFolder;

    if (CalcPIDLSize(PIDL) <> 2) and ((Folder = sfoDesktop)or(Folder = sfoDesktopExpanded)) then
      FFolder := sfoCustom
    else
    if (CalcPIDLSize(PIDL) = 2) and (Folder <> sfoDesktop) and (Folder <> sfoDesktopExpanded) then
      FFolder := sfoDesktop;

    if (Folder <> sfoDesktop) and (Folder <> sfoDesktopExpanded) and (CalcPIDLSize(PIDL) <> 2) then
    begin
      FIFolder := nil;
      hRes := iFolder.BindToObject(FRootPIDL, nil, IID_IShellFolder, Pointer(FIFolder));
      if not SUCCEEDED(hRes) then
        raise Exception.Create('Failed to get IShellFolder for specified root');
    end
    else
      FIFolder := iFolder;

    FAttr := cSFGAO_FLAGS;

    FIFolder.GetAttributesOf(1, FRootPIDL, FAttr);

    Result := RefreshList(True);

    if not Result then
      Abort;

    FreeIDList(SaveRootPIDL);
    if Items.Count >0 then
      ItemFocused := TElShellListItem(Items[0])
    else
      FFocusedPIDL := ClonePIDL(FRootPIDL);

    SyncControls(nil);

    if Assigned(OnRootChanged) then
      OnRootChanged(Self);

  except
    if FRootPIDL <> nil then
    begin
      FreeIDList(FRootPIDL);
      if Assigned(SaveRootPIDL) then
      begin
        FRootPIDL := SaveRootPIDL;
        FIFolder  := SaveIFolder;
        Folder    := SaveFolder;
        FAttr     := SaveAttr;
        try
          RefreshList(True);
          if Assigned(OnRootChanged) then
            OnRootChanged(Self);
        except
          FreeIDList(FRootPIDL);
          FIFolder := nil;
          FAttr := 0;
        end;
      end;
    end;
    //raise;
  end;

  SyncControls(nil);
  Invalidate;
end;

procedure TElShellList.BackToParentPIDL;
  var
    ParentPIDL  :PItemIDList;
    OLDRootPIDL :PItemIDList;
begin
  if (FRootPIDL=nil) or (CalcPIDLSize(FRootPIDL) = 2) and
     ((Folder = sfoDesktop) or (Folder = sfoDesktopExpanded))
  then
    exit;
  OLDRootPIDL := nil;
  ParentPIDL := GetParentPIDL(FRootPIDL);
  if Assigned(ParentPIDL) then
  try
    OLDRootPIDL := ClonePIDL(GetLastPIDL(RootPIDL));
    if SetRootPIDL(ParentPIDL) and (Items.Count>0) then
    begin
      DeselectAll;
      if not SetSelectionPIDL(OLDRootPIDL) then
      begin
        ItemFocused := TElShellListItem(Items[0]);
      end
      else
        EnsureVisible(ItemFocused);
    end;
  finally
    FreeIDList(ParentPIDL);
    FreeIDList(OLDRootPIDL);
  end;
end;

procedure TElShellList.DoCompareItems(Item1, Item2: TElTreeItem; var res: Integer);
  var
    S1, S2 :String;
    D1, D2 :TDateTime;
    B1, B2 :Boolean;
    I1, I2 :Cardinal;
    ShellItem1 :TElShellListItem absolute Item1;
    ShellItem2 :TElShellListItem absolute Item2;
begin
  if FSortType = sstCustom then
    inherited
  else
  begin
    if ssmFoldersFirst in SortModifiers then
    begin
      B1 := ShellItem1.IsFolder;
      B2 := ShellItem2.IsFolder;
      if B1 <> b2 then
      begin
        if b2 then
          res := 1
        else
          res := -1;
        exit;
      end
      else
      begin
        B1 := ShellItem1.IsFileObject;
        B2 := ShellItem2.IsFileObject;
        if B1 <> B2 then
        begin
          if b2 then
            res := 1
          else
            res := -1;
          exit;
        end;
      end;
    end;

    if ssmExecutablesFirst in SortModifiers then
    begin
      if (ShellItem1.IsFileObject and ShellItem2.IsFileObject) then
      begin
        B1 := ShellItem1.IsFolder;
        B2 := ShellItem2.IsFolder;
        if not (b1 or b2) then
        begin
          S1 := Uppercase(ExtractFileExt(ShellItem1.FileName));
          S2 := Uppercase(ExtractFileExt(ShellItem2.FileName));
          B1 := pos(S1, ExecutableExtensions)>0;
          B2 := pos(S2, ExecutableExtensions)>0;
          if B1 <> B2 then
          begin
            if B2 then
              res := 1
            else
              res := -1;
            exit;
          end;
        end;
      end;
    end;

    if FSortType = sstDefault then
    begin
      res := SmallInt(FIFolder.CompareIDs(0, ShellItem1.FPIDL, ShellItem2.FPIDL));
      exit;
    end;

    if ((ShellItem1.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) <>
       ((ShellItem2.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR) then
    begin
      if (ShellItem1.FAttr and SFGAO_FILESYSANCESTOR) <> SFGAO_FILESYSANCESTOR then
        res := 1
      else
        res := -1;
      exit;
    end;

    case FSortType of
      sstName:
        begin
          S1 := ShellItem1.FileName;
          S2 := ShellItem2.FileName;
          res := AnsiStrIComp(PChar(S1), PChar(S2));
        end;
      sstSize:
        begin
          I1 := ShellItem1.Size;
          I2 := ShellItem2.Size;
          if I1 > I2 then
            res := 1
          else
          if I1 < I2 then
            res := -1
          else
          if I1 = I2 then
            res := 0;
        end;
      sstCreationDate,
      sstModifyDate,
      sstAccessDate:
        begin
          case FSortType of
            sstModifyDate:
              begin
                D1 := ShellItem1.ModificationTime;
                D2 := ShellItem2.ModificationTime;
              end;
            sstAccessDate:
              begin
                D1 := ShellItem1.LastAccessTime;
                D2 := ShellItem2.LastAccessTime;
              end;
            else
              begin
                D1 := ShellItem1.CreationTime;
                D2 := ShellItem2.CreationTime;
              end;
          end;
          if D1 > D2 then
            res := 1
          else
          if D1 < D2 then
            res := -1
          else
          if D1 = D2 then
            res := 0;
        end;
      sstExt:
        begin
          S1 := ExtractFileExt(ShellItem1.FileName);
          S2 := ExtractFileExt(ShellItem2.FileName);
          res := AnsiStrIComp(PChar(S1), PChar(S2));
        end;
    end;
  end;
end;

function TElShellList.SetSelectionPIDL(PIDL: PItemIDList):Boolean;
  var
    vPIDL :PItemIDList;
begin
  if Assigned(PIDL) and Assigned(ItemFocused) then
  begin
    vPIDL := ItemFocused.BuildFullPIDL;
    if CompareIDLists(vPIDL, PIDL) then
    begin
      Result := True;
      FreeIDList(vPIDL);
      exit;
    end
    else
      FreeIDList(vPIDL);
  end;
  ItemFocused := FindItemByPIDL(PIDL);
  Result := Assigned(ItemFocused);
end;

function TElShellList.BuildRootPIDL: PItemIDList;
begin
  Result := ClonePIDL(FRootPIDL);
end;

{$ifdef VCL_4_USED}
procedure TElShellList.TriggerVirtualHintNeeded(Item: TElTreeItem; var Hint: TElFString);
begin
  Hint := (Item as TElShellListItem).GetHintText(FIFolder);
  if Assigned(FOnVirtualHintNeeded) then
    OnVirtualHintNeeded(Self, Item, Hint);
end;
{$endif}

function TElShellList.DoGetPicture(Item: TElTreeItem): Integer;
begin
  Result := (Item as TElShellListItem).GetPicture(FIFolder);
end;

procedure TElShellList.Loaded;
  var
    F :TShellFolders;
begin
  inherited;
  F := FFolder;
  FFolder := TShellFolders(Integer(F) - 1);
  SetFolder(F);
  if DefaultColumns then
  begin
    fDefaultColumns := False;
    DefaultColumns := True;
  end;
  ShowColumns := FSaveShowHeader;
end;

procedure TElShellList.DoItemAdded(const S: String; const ShellFolder: IShellFolder;
    RelPIDL: PItemIDList; Item: TElShellListItem);
begin
  if assigned(FOnItemAdded) then
    FOnItemAdded(Self, S, ShellFolder, RelPIDL, Item);
end;

procedure TElShellList.SetShellTreeView(Value: TElShellTree);
begin
  if FShellTreeView <> Value then
  begin
    if FShellTreeView <> nil then
      FShellTreeView.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellTreeView <> nil) and (not (csDestroying in FShellTreeView.ComponentState)) then
      FShellTreeView.RemoveFreeNotification(Self);
    {$endif}

    FShellTreeView := Value;
    if (FShellTreeView <> nil) then
    begin
      FShellTreeView.FreeNotification(Self);
      SyncControls(FShellTreeView);
    end;
  end;
end;

procedure TElShellList.SetShellComboBox(Value: TElShellComboBox);
begin
  if FShellComboBox <> Value then
  begin
    if FShellComboBox <> nil then
      FShellComboBox.fIsSyncControls := False;
    {$ifdef VCL_5_USED}
    if (FShellComboBox <> nil) and (not (csDestroying in FShellComboBox.ComponentState)) then
      FShellComboBox.RemoveFreeNotification(Self);
    {$endif}

    FShellComboBox := Value;
    if (FShellComboBox <> nil) then
    begin
      FShellComboBox.FreeNotification(Self);
      SyncControls(FShellComboBox);
    end;
  end;
end;

procedure TElShellList.SyncControls(Sender: TObject);
  var
    SaveTreeIsUpdating: Boolean;
    bTree, bCombo: Boolean;
begin
  if (not fIsSyncControls) and HandleAllocated and Assigned(FRootPIDL) and
     ( Assigned(ShellComboBox) or Assigned(ShellTreeView) )
  then
  begin

    SaveTreeIsUpdating := False;
    bTree := False;
    bCombo := False;
    fIsSyncControls := True;

    try

      // ShellTreeView:
      if Assigned(ShellTreeView) and (not ShellTreeView.fIsSyncControls) and
         (ShellTreeView.HandleAllocated) and ( (Sender=nil) or (Sender=ShellTreeView) ) and
         (not ShellTreeView.IsSelectionPIDL(FRootPIDL))
      then
      begin
        bTree := True;
        ShellTreeView.fIsSyncControls := True;
        SaveTreeIsUpdating := ShellTreeView.IsUpdating;
        if not ShellTreeView.IsUpdating then
          ShellTreeView.IsUpdating := True;
        //ShellTreeView.Items.BeginUpdate;
        ShellTreeView.DeselectAll;
        if (not ShellTreeView.SetSelectionPIDL(FRootPIDL)) and
           (ShellTreeView.RootFolder <> sfoDesktop) then
        begin
          ShellTreeView.RootFolder := sfoDesktop;
          ShellTreeView.SetSelectionPIDL(FRootPIDL);
        end;
      end;

      // ShellComboBox:
      if Assigned(ShellComboBox) and (not ShellComboBox.fIsSyncControls) and
         (ShellComboBox.HandleAllocated) and ( (Sender=nil) or (Sender=ShellComboBox) )
      then
      begin
        bCombo := True;
        ShellComboBox.fIsSyncControls := True;
        ShellComboBox.SetSelection(FRootPIDL);
      end;

    finally
      fIsSyncControls := False;
      if bTree then
      begin
        ShellTreeView.fIsSyncControls := False;
        //ShellTreeView.Items.EndUpdate;
        if SaveTreeIsUpdating <> ShellTreeView.IsUpdating then
          ShellTreeView.IsUpdating := SaveTreeIsUpdating;
        ShellTreeView.EnsureVisible(ShellTreeView.ItemFocused);
      end;
      if bCombo then
        ShellComboBox.fIsSyncControls := False;
      //???
      Invalidate;     end;
  end;
end;

procedure TElShellList.SynclShellComboBox(ShellComboBox: TElShellComboBox);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellComboBox=nil) or (ShellComboBox.fIsSyncControls) or
     (not ShellComboBox.HandleAllocated)
  then
    exit;
  ShellComboBox.SetSelection(FRootPIDL);
end;

procedure TElShellList.SynclShellTree(ShellTree: TElShellTree);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellTree=nil) or (ShellTree.fIsSyncControls) or
     (not ShellTree.HandleAllocated)
  then
    exit;
  ShellTree.SetSelectionPIDL(FRootPIDL);
end;

procedure TElShellList.SyncShellList(ShellList: TElShellList);
begin
  if fIsSyncControls or (not HandleAllocated) or
     (ShellList=nil) or (ShellList.fIsSyncControls) or
     (not ShellList.HandleAllocated) or (ShellList=Self)
  then
    exit;
  ShellList.SetRootPIDL(FRootPIDL);
end;

procedure TElShellList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = ShellTreeView) and (Operation = opRemove) then
    FShellTreeView := nil;
  if (AComponent = ShellComboBox) and (Operation = opRemove) then
    FShellComboBox := nil;
end;

procedure TElShellList.OnBeforeOperation(Sender: TObject; var DefaultConversion: Boolean);
begin
  FEditor.ValueAsText := TElShellListItem(FEditor.Item).EditName;
  DefaultConversion := True;
end;

procedure TElShellList.OnValidateEdit(Sender: TOBject; var InputValid: Boolean);
  var
    i :Integer;
begin
  try
    TElShellListItem(FEditor.Item).SetEditName(FEditor.Editor.Text);
    i := 0;
    repeat
      Sleep(500);
      inc(i);
    until (i > 10) or (TElShellListItem(FEditor.Item).EditName = FEditor.Editor.Text);
    SetLength( TElShellListItem(FEditor.Item).FDisplayName , 0);
    FEditor.Item.RedrawItem(False);
  except
    InputValid := False;
  end;
end;

procedure TElShellList.TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer;
  SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor);
begin
  if DefaultEditor then
  begin
    if (SectionIndex = -1) or (HeaderSections[SectionIndex].Tag = siName) then
    begin
      Editor := FEditor;
      exit;
    end;
  end;
  inherited;
end;

{ TElShellListItem }

function TElShellListItem.GetAttrAsString: String;
  var
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    sd       :TShellDetails;
begin
  if FAttrAsString <> cShellNullStr then
  begin
    Result := FAttrAsString;
    exit;
  end
  else
    SetLength(Result, 0);

  if IsDesktopPIDL(PIDL) then
  begin
    SetLength(FAttrAsString, 0);
    exit;
  end;

  if PIDL = nil then
    exit;

  IFolder := TElShellList(FOwner).FIFolder;

  if not SUCCEEDED(IFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
  begin
    if SUCCEEDED(IFolder.QueryInterface(IID_IShellDetails, IDetails)) then
    begin
      if SUCCEEDED(IDetails.GetDetailsOf(PIDL, siAttr, sd)) then
      begin
        Result := StrRetToPas(sd.str, PIDL);
        StrRetFree(sd.str);
      end;
    end;
  end
  else
  begin
    if SUCCEEDED(IFolder2.GetDetailsOf(PIDL, siAttr, sd)) then
    begin
      Result := StrRetToPas(sd.str, PIDL);
      StrRetFree(sd.str);
    end;
  end;
  FAttrAsString := Result;
end;

function TElShellListItem.GetCanRename: Boolean;
begin
  Result := (FAttr and SFGAO_CANRENAME) = SFGAO_CANRENAME;
end;

function TElShellListItem.GetComment: String;
  var
    IFolder  :IShellFolder;
    IFolder2 :IShellFolder2;
    IDetails :IShellDetails;
    sd       :TShellDetails;
    hres     :HResult;
begin
  if FComment <> cShellNullStr then
  begin
    Result := FComment;
    exit;
  end
  else
    SetLength(Result, 0);

  iFolder := TElShellList(FOwner).FIFolder;

  if not SUCCEEDED(iFolder.CreateViewObject(FOwner.Handle, IShellDetails, Pointer(IDetails))) then
  begin
    if not SUCCEEDED(iFolder.QueryInterface(IID_IShellFolder2, IFolder2)) then
    begin
      IDetails := TElShellDefaultColumns.Create as IShellDetails;
    end;
  end;

  if IFolder2 <> nil then
    hRes := IFolder2.GetDetailsOf(FPIDL, siComment, SD)
  else
    hRes := IDetails.GetDetailsOf(FPIDL, siComment, SD);
  if hRes = S_OK then
  begin
    Result := StrRetToPas(SD.str, nil);
    StrRetFree(SD.str);
    FComment := Result;
  end;

end;

function TElShellListItem.GetCreationTime: TDateTime;
  var
    ST :TSystemTime;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := 0
  else
  begin
    FileTimeToSystemTime(Win32FindData.ftCreationTime, ST);
    Result := SystemTimeToDateTime(ST);
  end;
end;

function TElShellListItem.GetDisplayName: String;
  var
    iFolder :IShellFolder;
    str     :TStrRet;
begin
  if Length(FDisplayName)=0 then
  begin
    iFolder := TElShellList(FOwner).FIFolder;
    ZeroMemory(@Str, SizeOf(Str));
    Str.uType := STRRET_CSTR;

    if SUCCEEDED(iFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER, str)) then
    begin
      FDisplayName := StrRetToPas(Str, FPIDL);
      StrRetFree(str);
    end;
    iFolder := nil;
  end;
  Result := FDisplayName;
end;

function TElShellListItem.IsExists:Boolean;
  var
    str:TStrRet;
begin
  ZeroMemory(@Str, SizeOf(Str));
  Result := SUCCEEDED(TElShellList(FOwner).FIFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER, str));
  if Result then
    StrRetFree(str);
end;

function TElShellListItem.GetFileName: String;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := DisplayName
  else
  begin
    if FFileName <> cShellNullStr then
      Result := FFileName
    else
    begin
      Result := StrPas(Win32FindData.cFileName);
      FFileName := Result;
    end;
  end;
end;

function TElShellListItem.GetFullName: String;
  var
    StrRet :TStrRet;
begin
  ZeroMemory(@StrRet, SizeOf(StrRet));
  StrRet.uType := STRRET_CSTR;
  if SUCCEEDED(TElShellList(FOwner).FIFolder.GetDisplayNameOf(FPIDL, SHGDN_NORMAL or
    SHGDN_FORPARSING {SHGDN_FORADDRESSBAR}, StrRet))
  then
  begin
    Result := StrRetToPas(StrRet, FPIDL);
    StrRetFree(StrRet);
  end
  else
    SetLength(Result, 0);
end;

function TElShellListItem.GetIsFileObject: Boolean;
begin
  Result := ((FAttr and SFGAO_FILESYSTEM) = SFGAO_FILESYSTEM);
end;

function TElShellListItem.GetIsFolder: Boolean;
begin
  Result := ((FAttr and SFGAO_FOLDER) = SFGAO_FOLDER);
end;

function TElShellListItem.GetIsRemovable: Boolean;
begin
  Result := (FAttr and SFGAO_REMOVABLE) = SFGAO_REMOVABLE;
end;

function TElShellListItem.GetLastAccessTime: TDateTime;
  var
    ST :TSystemTime;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := 0
  else
  begin
    FileTimeToSystemTime(Win32FindData.ftLastAccessTime, ST);
    Result := SystemTimeToDateTime(ST);
  end;
end;

function TElShellListItem.GetModificationTime: TDateTime;
  var
    ST :TSystemTime;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := 0
  else
  begin
    FileTimeToSystemTime(Win32FindData.ftLastWriteTime, ST);
    Result := SystemTimeToDateTime(ST);
  end;
end;


function TElShellListItem.GetSize: Cardinal;
begin
  CheckWin32FindData;
  if Win32FindData = nil then
    Result := 0
  else
  begin
    Result := Win32FindData.nFileSizeLow;
  end;
end;

function TElShellListItem.GetSizeAsString: String;
  var
    ASize :Integer;
begin
  if FSizeAsString = cShellNullStr then
  begin
    case TElShellList(Owner).SizeFormat of
      ssfAsIs :
        begin
          Result := IntToStrFmt(Size) + ' b';
        end;
      ssfKb:
        begin
          ASize  := Round(Size / 1024);
          Result := IntToStrFmt(ASize) + ' Kb';
        end;
      ssfAuto:
        begin
          ASize := Size;
          if ASize < 1024 then
            Result := IntToStrFmt(ASize) + ' b'
          else
          if ASize < 1024*1024 * 10 then
            Result := IntToStrFmt(Round(Size / 1024)) + ' Kb'
          else
            Result := IntToStrFmt(Round(Size / (1024 * 1024))) + ' Mb';
        end;
    end;
    FSizeAsString := Result;
  end
  else
    Result := FSizeAsString;
end;

function TElShellListItem.GetTypeName: String;
  var
    SFI :TSHFileInfo;
begin
  if FTypeName = cShellNullStr then
  begin
    SHGetFileInfo(PChar(FullName), 0, SFI, SizeOf(SFI), SHGFI_TYPENAME or SHGFI_USEFILEATTRIBUTES);
    FTypeName := StrPas(SFI.szTypeName);
  end;
  Result := FTypeName;
end;

procedure TElShellListItem.SetDisplayName(const Value: String);
  var
    NewPIDL :PItemIDList;
begin
  if DisplayName=Value then
    exit;
  if SUCCEEDED(TElShellList(FOwner).FIFolder.SetNameOf(FOwner.Handle, FPIDL,
    PWideChar(WideString(Value)), SHGDN_INFOLDER, NewPIDL))
  then
  begin
    FDisplayName := Value;
    if NewPIDL <> nil then
    begin
      FreeIDList(FPIDL);
      FPIDL := ClonePIDL(GetOwnPIDL(NewPIDL));
      FreeIDList(NewPIDL);
    end;
  end
  else
    raise EElShellError.Create('Failed to rename ' + DisplayName);
end;

constructor TElShellListItem.Create(AOwner: TCustomElTree);
begin
  inherited;
  ClearData(False);
end;

destructor TElShellListItem.Destroy;
begin
  ClearData(True);
  inherited;
end;

procedure TElShellListItem.ClearData(bRelease:Boolean);
begin
  if FPIDL <> nil then
    FreeIDList(FPIDL);
  if Win32FindData <> nil then
    Dispose(Win32FindData);
  if not bRelease then
  begin
    FPIDL         := GetEmptyPIDL;
    FAttrAsString := cShellNullStr;
    FComment      := cShellNullStr;
    FTypeName     := cShellNullStr;
    FSizeAsString := cShellNullStr;
    FFileName     := cShellNullStr;
    Win32FindData := nil;
    {$ifdef VCL_4_USED}
    SetLength(FHint,0);
    {$endif}
    SetLength(FDisplayName, 0);
  end;
end;

function TElShellListItem.BuildFullPIDL: PItemIDList;
begin
  Result := AppendPIDL(TElShellList(FOwner).FRootPIDL, FPIDL);
end;

procedure TElShellListItem.CheckWin32FindData;
begin
  if Win32FindData = nil then
    if ((FAttr and SFGAO_FILESYSTEM) = SFGAO_FILESYSTEM)
       then
      GetWin32Data(TElShellList(FOwner).FIFolder);
end;

procedure TElShellListItem.GetWin32Data(const ParentFolder: IShellFolder);
  var
    HSRec  : THandle;
    FN     : String;
    S      : String;
begin
  FIsValidFile := False;
  if Win32FindData=nil then
    New(Win32FindData);
  FN := GetFullName;
  S  := ExtractFilePath(FN);
  System.Delete(S, 1, Length(ExtractFileDrive(S)));
  if S = '\' then
  begin
    S := ExtractFileDrive(FN);
    if Copy(S, 1, 2) = '\\' then
    begin
      ZeroMemory(Win32FindData, SizeOf(Win32FindData^));
      Win32FindData^.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY;
      FFileName := S;
      exit;
    end
    else
    begin
      if GetDriveType(PChar(S)) in [1, DRIVE_REMOVABLE, DRIVE_REMOTE] then
      begin
        ZeroMemory(Win32FindData, SizeOf(Win32FindData^));
        Win32FindData^.dwFileAttributes := FILE_ATTRIBUTE_DIRECTORY;
        FFileName := S;
        exit;
      end;
    end;
    FFileName := FN;
  end;
  HSRec := FindFirstFile(PChar(GetFullName), Win32FindData^);
  if HSRec = INVALID_HANDLE_VALUE then
    ZeroMemory(Win32FindData, SizeOf(Win32FindData^))
  else
  begin
    FIsValidFile := True;
    FindClose(HSRec);
  end;
end;

procedure TElShellListItem.Invalidate;
begin
  ClearData(False);
end;

function TElShellListItem.GetPicture(const ParentFolder: IShellFolder): Integer;
  var
    APIDL  : PItemIDList;
begin

  if FPIDL = nil then
  begin
    Result := -1;
    exit;
  end;

  if FAttr = 0 then // - if iShellFolder.Attribute not cached then ready it
    GetAttributes(ParentFolder);

  APIDL := BuildFullPIDL;


  Result := ShellIconCache.AddFromPIDL(APIDL, GIL_FORSHELL, False);
  ImageIndex := Result;

  if (FAttr and SFGAO_FOLDER) = SFGAO_FOLDER then
    StateImageIndex := ShellIconCache.AddFromPIDL(APIDL, GIL_FORSHELL, True)
  else
    StateImageIndex := Result;

  FreeIDList(APIDL);
end;

procedure TElShellListItem.GetAttributes(const iParentFolder: IShellFolder);
  var
    i :TShellAttr;
begin
  if FPIDL = nil then
  begin
    FAttr := 0;
    exit;
  end;

  i := cSFGAO_FLAGS;
  if SUCCEEDED(IParentFolder.GetAttributesOf(1, FPIDL, i)) then
    FAttr := i
  else
    FAttr := 0;

  if TElShellList(FOwner).FHighlightCompressed then
  begin
    if (FAttr and SFGAO_COMPRESSED) = SFGAO_COMPRESSED then
    begin
      Color := GetCompressedColor;
      ParentColors := False;
      UseBkColor := False;
    end;
  end;
  if (FAttr and SFGAO_GHOSTED) = SFGAO_GHOSTED then
    Cut := True;
end;

{$ifdef VCL_4_USED}
function TElShellListItem.GetHintText(const ParentFolder: IShellFolder): TElFString;
begin
  if Length(FHint)=0 then
  begin
    if (TElShellList(Owner).FFolder<>sfoCustom) or IsDesktopPIDL(TElShellList(Owner).FRootPIDL)
    then
      ShellFolderGetHintText(FHint, Owner.Handle, FPIDL, ParentFolder, FAttr)
    else
      ShellFolderGetHintText2(FHint, Owner.Handle, FPIDL, ParentFolder, FAttr);
  end;
  if FHint = #1 then
    SetLength(Result,0)
  else
    Result := FHint;
end;
{$endif}

function TElShellListItem.GetEditName: String;
  var
    iFolder :IShellFolder;
    str     :TStrRet;
begin
  if Length(FEditName)=0 then
  begin
    iFolder := TElShellList(FOwner).FIFolder;
    ZeroMemory(@Str, SizeOf(Str));
    Str.uType := STRRET_CSTR;

    if SUCCEEDED(iFolder.GetDisplayNameOf(FPIDL, SHGDN_INFOLDER or SHGDN_FOREDITING, str)) then
      FEditName := StrRetToPas(Str, FPIDL); StrRetFree(str);
    iFolder := nil;
  end;
  Result := FEditName;
end;

procedure TElShellListItem.SetEditName(const Value: String);
  var
    NewPIDL :PItemIDList;
begin
  if Value=EditName then
    exit;
  if SUCCEEDED(TElShellList(FOwner).FIFolder.SetNameOf(FOwner.Handle, FPIDL,
    PWideChar(WideString(Value)), SHGDN_INFOLDER or SHGDN_FOREDITING, NewPIDL))
  then
  begin
    FEditName := Value;
    if NewPIDL <> nil then
    begin
      FreeIDList(FPIDL);
      FPIDL := ClonePIDL(GetOwnPIDL(NewPIDL));
      FreeIDList(NewPIDL);
    end;
  end
  else
    raise EElShellError.Create('Failed to rename ' + EditName);
end;

{ TElShellListView }

procedure TElShellListView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button = mbRight) and (not Dragging) and TElShellList(Parent).UseSystemMenus then
    ShowSystemMenu(X, Y, nil);
end;

procedure TElShellListView.MenuWndProc(var Message: TMessage);
  var
    {$IFDEF VCL_4_USED}
    ICI      :CMInvokeCommandInfo;
    {$ELSE}
    ICI      :TCMInvokeCommandInfo;
    {$ENDIF}
    idCmd    :Cardinal;
    VerbBuff :array[0..255] of Char;
    VerbStr  :String;
    bHandled :Boolean;
    PIDL     :PItemIDList;
    i        :Integer;
    List     :TElList;
    ICM2     :IContextMenu2;
begin
  if Assigned(iCtxMenu) then
  case Message.Msg of
    WM_EXITMENULOOP:
      begin
        DestroyMenu(FBuiltinMenu);
        FBuiltinMenu := 0;
        inherited;
      end;
    WM_COMMAND:
      with TElShellList(FOwner) do
      begin
        idCmd := LOWORD(Message.wParam);
        if idCmd = 0 then
          exit;

        FillMemory(@ICI, SizeOf(ICI), 0);
        ICI.cbSize := SizeOf(ICI);
        ICI.nShow  := SW_SHOWNORMAL;
        ICI.lpVerb := MakeIntResource(idCmd);
        if Integer(ICI.lpVerb) < 0 then
          exit;
        bHandled := False;
        VerbBuff[0] := #0;
        if iCtxMenu.GetCommandString(idCmd, GCS_VERB, nil, VerbBuff, SizeOf(VerbBuff)) = S_OK then
        begin
          VerbStr := VerbBuff;
          if Assigned(fOnInvokeVerbCommand) then
            fOnInvokeVerbCommand(FOwner, VerbStr, bHandled);
          if (not bHandled) and Assigned(ItemFocused) then
          begin
            if CompareText(VerbStr, 'explore')=0 then
            begin
              if SelectedCount=1 then
              begin
                PIDL := ItemFocused.BuildFullPIDL;
                try
                  SetRootPIDL(PIDL);
                finally
                  FreeIDList(PIDL);
                end;
                bHandled := True;
              end;
            end
            else
            if CompareText(VerbStr, 'rename')=0 then
            begin
              ItemFocused.EditText;
              bHandled := True;
            end;
          end;
        end
        else
          SetLength(VerbStr, 0);

        if not bHandled then
        begin
          if iCtxMenu.InvokeCommand(ICI) <> S_OK then
            exit;
          if (CompareText(VerbStr, 'delete')=0) then
          begin
            if SelectedCount=1 then
            begin
              if Assigned(ItemFocused) and (not ItemFocused.IsExists) then
                ItemFocused.Delete;
            end
            else
            begin
              List := TElList.Create;
              try
                AllSelected(List);
                for i:=List.Count-1 downto 0 do
                begin
                  if not TElShellListItem(List[i]).IsExists then
                    TElShellListItem(List[i]).Delete;
                end;
              finally
                List.Free;
              end;
            end;
          end;//of: VerbStr == 'delete'
        end;//of: if not bHandled
        inherited;
      end;//of: if (Message.Msg = WM_COMMAND)
    WM_INITMENUPOPUP,
    WM_DRAWITEM,
    WM_MENUCHAR,
    WM_MEASUREITEM:
      begin
        iCtxMenu.QueryInterface(IID_IContextMenu2, Pointer(ICM2));
        if Assigned(ICM2) then
        begin
          ICM2.HandleMenuMsg(Message.Msg, Message.WParam, Message.LParam);
          Message.Result := 0;
        end;
      end;
    else
      inherited;
  end// of case
  else
    inherited;
end;

constructor TElShellListView.Create(AOwner: TComponent);
begin
  inherited;
  {$warnings off}
  FMenuWnd := AllocateHWND(MenuWndProc);
  {$warnings on}
end;

destructor TElShellListView.Destroy;
begin
  if Assigned(iCtxMenu) then
  begin
    DestroyMenu(FBuiltinMenu);
    FBuiltinMenu := 0;
    iCtxMenu := nil;
  end;
  {$warnings off}
  DeallocateHWND(FMenuWnd);
  {$warnings on}
  inherited;
end;

procedure TElShellListView.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_APPS) and (Shift = []) and TElShellList(FOwner).UseSystemMenus then
  begin
    Key := 0;
    ShowSystemMenu(0, 0, TElShellListItem(FOwner.ItemFocused));
  end;
  inherited;
end;

procedure TElShellListView.ShowSystemMenu(X, Y: Integer; Item: TElShellListItem);
  type
    PPItemIDList = ^PItemIDList;
  var
    ItemPart :TSTItemPart;
    HCol     :Integer;
    List     :TElList;
    i        :Integer;
    P        :TPoint;
    ICM2     :IContextMenu2;
    uFlag    :UINT;
begin

  with TElTree(FOwner) do
    if Assigned(PopupMenu) and (PopupMenu.AutoPopup) then
  exit;

  if (X>=0)and(Y>=0) and (Item=nil) then
  begin
    HCol := 0;
    Item := TElShellListItem( GetItemAt(X, Y, ItemPart, HCol) );
    if (Item=nil) or (HCol>0) or (not
      (ItemPart in [ipMainText, ipPicture, ipPicture2, ipCheckBox]))
    then
    begin
      if Assigned(TElTree(FOwner).PopupMenu) then
        with ClientToScreen(Point(X, Y)) do
        begin
          FOwner.DeselectAll;
          TElTree(FOwner).PopupMenu.Popup(X, Y);
        end;
      exit;
    end;
  end;

  if Item=nil then
    exit;

  List := TElList.Create;
  with TElShellList(FOwner) do
  try
    FOwner.AllSelected(List);
    if not Item.Selected then
      List.Add(Item);
    for i := 0 to List.Count - 1 do
      List[i] := TElShellListItem(List[i]).FPIDL;

    iCtxMenu := nil;

    iCtxMenu := nil;
    if SUCCEEDED(FIFolder.GetUIObjectOf(Handle, List.Count, PPItemIDList(List.List)^,
      IID_iContextMenu, nil, Pointer(iCtxMenu)))
    then
    begin
      FBuiltinMenu := CreatePopupMenu;
      uFlag := CMF_NORMAL;
      if (List.Count = 1) and DoInplaceEdit then
        uFlag := uFlag or CMF_CANRENAME;
      iCtxMenu.QueryContextMenu(FBuiltinMenu, 0, 0, $FFFFFFFF, uFlag);
      iCtxMenu.QueryInterface(IID_IContextMenu2, Pointer(ICM2)); // To handle submenus.
      P := ClientToScreen(Point(X, Y));
      TrackPopupMenu(FBuiltinMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
        P.X, P.Y, 0, FMenuWnd, nil);
    end;
  finally
    List.Free;
    ICM2 := nil;
  end;
end;

function TElShellListView.GetPopupMenu: TPopupMenu;
begin
  if TElShellList(FOwner).UseSystemMenus then
    Result := nil
  else
    Result := inherited GetPopupMenu;
end;

procedure TElShellListView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
  var
    Shift :TShiftState;
begin
  Shift := KeyDataToShiftState(Message.Keys);
  if GetKeyState(VK_MENU) < 0 then
    Include(Shift, ssAlt);
  TElShellList(FOwner).MouseLButtonDblClickExt(Message.XPos, Message.YPos, Shift);
  if ([ssShift, ssAlt, ssCtrl]*Shift)=[] then
    inherited;
end;

initialization
  if IsWinNTUp then
    ExecutableExtensions := cExecutableExtensionsWinNTUp
  else
    ExecutableExtensions := cExecutableExtensionsWin9X;

  OleInitialize(nil);

finalization
  OleUninitialize;

end.
