{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcfdes;

interface
{.$I dc.inc}
{$I dcprod.inc}
//{$D-,L-,Y-}
uses
  dcfdeshook,
  dcsystem, Windows, Messages, SysUtils, Classes, Graphics, Controls, forms,
  dccompchanges,
  Dialogs, 

  clipbrd, menus,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcapp,
  dcgen, dccommon, typinfo, dcconsts,dcdreamlib, dccontrols,
{$IFDEF D3}ActiveX, {$ELSE} ole2, olectl, oleauto, {$ENDIF}
  dalign, dsize, aligunit, dcpalfrm, dcpalet, dcpalette, DCPLoad, dccbut, dchook,
  {$IFDEF DCEDIT}dcedit, dcinpfrm, {$ENDIF}
  {$IFDEF DREAMTREE} treemod, {$ENDIF}
// OLE
  olectrls;

const
  CM_ALLLOADED = WM_USER;

{$IFDEF D3}
type
  TDCChangesStore = class(TComponent)
  private
    fChanges      : TDCCompChanges;
    fHandleObject : TDCHandleObject;
    fChangesKey   : string;
    FVersion      : TDCVersion;
    fOnLoadChanges       : TProcessChangesProc;
    fOnSaveChanges       : TProcessChangesProc;

    fLoaded       : boolean;

    procedure AllLoaded(var Message : TMessage); message CM_ALLLOADED;
    procedure HookProc(var Msg : TMessage); message CM_HOOKPROC;
    procedure _AppTerminate;

  protected
    procedure Loaded; override;
    procedure SaveChanges; virtual;
    procedure LoadChanges; virtual;
    function  GetChangesKey : string;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property Changes : TDCCompChanges read fChanges;
    property Key : string read fChangesKey write fChangesKey;

    property OnSaveChanges : TProcessChangesProc read fOnSaveChanges write fOnSaveChanges;
    property OnLoadChanges : TProcessChangesProc read fOnLoadChanges write fOnLoadChanges;

    property Version : TDCVersion read FVersion write FVersion stored false;
  end;
{$ENDIF}

type
  TCNotifyProc = procedure (Sender : TObject; AControl : TComponent) of object;
  TGetComponentGlyphProc = procedure(Sender : TObject; AClass :TClass; AGlyph : TBitmap) of object;
  TProcessMenuItemProc = procedure (Sender : TObject; MenuItem : TMenuItem; var AllowCommand : boolean) of object;

const
  HandleSize    = 4;

  hpNone        = 0;
  hpFirst       = 1;
  hpTopLeft     = 1;
  hpTop         = 2;
  hpTopRight    = 3;
  hpLeft        = 4;
  hpRight       = 5;
  hpBottomLeft  = 6;
  hpBottom      = 7;
  hpBottomRight = 8;
  hpLast        = 8;

type
  TDCFormDesigner = class;
  TDCFormDesignerClass = class of TDCFormDesigner;
  THandlePosition   = hpNone .. hpLast;
  TCHShowMode = (smActive, smInActive, smGrayed, smInvisible);

  TCHMouseDown = procedure(Sender: TObject; Button: TMouseButton;
                           Shift: TShiftState; CHandle : THandlePosition) of object;

  TStartSizeChangeProc = procedure (Sender : TObject) of object;
  TSizeChangeProc = procedure (Sender : TObject; NewWidth, NewHeight : integer) of object;
  TValidateRectProc = procedure (Sender : TObject; var r : TRect) of object;

  TEditPropertyProc = procedure (Sender : TObject; Instance : TObject;
                                 const PropName : string; var AllowEdit : boolean) of object;

  TShowPropertyProc = procedure (Sender : TObject; Instance : TObject;
                                 const PropName : string; var AllowShow : boolean) of object;

  TActiveChangingEvent = procedure (Sender : TObject; var AllowChange : boolean) of object;

  TSizeChangedEvent = procedure (Sender : TObject; ChangedControl : TControl) of object;
  TAllowPopupEvent = procedure (Sender : TObject; Shift: TShiftState; X, Y: Integer; var AllowPopup : boolean) of object;
  TGetEventsListEvent = procedure (Sender : TObject; TypeData : PTypeData; EventsList : TStrings) of object;
  TGetAncestorEvent = procedure(Sender: TObject; var Ancestor: TComponent) of object;

  TFDOption = (fdAllowDelete, fdAllowInsert);
  TFDoptions = set of TFDOption;

  TGridStep = 2..128;

  TActionType = (atSelect, atDelete, atInsertInto, atMove, atResize, atShow, atEdit);
  TAllowedActions = set of TActionType;

  TLimitInfoItem = class(TDCNamedItem)
  private
    fComponent : TComponent;
    fAllowedActions : TAllowedActions;
    fReadOnlyProps : TStrings;
    fHiddenProps : TStrings;
    fNotifier : TDCLinkedComponent;

    procedure SetComponent(val : TComponent);
    procedure SetReadOnlyProps(val : TStrings);
    procedure SetHiddenProps(val : TStrings);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
  public
    constructor Create(Collection: TCollection); override;
    destructor  Destroy; override;
  published
    property Component : TComponent read fComponent write SetComponent;
    property AllowedActions : TAllowedActions read fAllowedActions write fAllowedActions;
    property ReadOnlyProps : TStrings read fReadOnlyProps write SetReadOnlyProps;
    property HiddenProps : TStrings read fHiddenProps write SetHiddenProps;
  end;

  TLimitInfos = class(TDCNamedItems)
  private
    function GetItem(index : integer) : TLimitInfoItem;
  public
    property Items[index : integer] : TLimitInfoItem read GetItem; default;
  end;

  TActionEvent = procedure (Sender : TObject; Instance : TPersistent;
                            Action : TActionType; var Allow : boolean) of object;

  TComponentContainer = class;
  TControlHandles = class;

  TDesignerOptions = class(TOptionExt)
  private
    FGridStepX:TGridStep;
    FGridStepY:TGridStep;

    FShowGrid     : boolean;
    FSnaptoGrid   : boolean;
    FShowCaptions : boolean;
    fShowHints    : boolean;

//    FPopupMenu : TPopupMenu;
    procedure SetSnapToGrid(V:Boolean);
    procedure SetShowGrid(Value:Boolean);
    procedure SetShowCaptions(Value:Boolean);
    procedure SetGridStepX(Value:TGridStep);
    procedure SetGridStepY(Value:TGridStep);
    procedure SetShowHints(val : boolean);
  public
    procedure Update; override;
    function  GetKey : string; override;
    procedure InitValues; override;
  published
    property ShowGrid:boolean Read FShowGrid Write SetShowGrid;
    property SnaptoGrid:Boolean Read FSnapToGrid Write SetSnapToGrid;
    property ShowCaptions:boolean Read FShowCaptions Write SetShowCaptions;
    property GridSizeX:TGridStep Read FGridStepX Write SetGridStepX;
    property GridSizeY:TGridStep Read FGridStepY Write SetGridStepY;
    property ShowHints : boolean read fShowHints write SetShowHints;
//    property PopupMenu:TPopupMenu Read FPopupMenu Write FPopupMenu;
  end;

  TDesignerOperation = (dopChangePos, dopDelete, dopInsert);

  TUndoInfo = class
  private
    fCompContent : TMemoryStream;
  public
    Operation : TDesignerOperation;
    Name      : string;
    UndoLevel : integer;
    OldPos    : TRect;  // doChangePos

    constructor Create;
    destructor  Destroy; override;
    function    CompContent : TStream;
  end;

  TGetCompNamesEvent = procedure (Sender:TObject;TypeData: PTypeData; Proc: TGetStrProc) of object;

{$IFDEF D4}
  IDCFormDesigner = interface(IDCFDesigner)
  ['{CE824D00-0D95-11D2-B4CC-0000E8DC209E}']  //don't resource
    function  GetActive : boolean;
    procedure SetActive(val : boolean);
    function  GetOptions : TFDOptions;
    procedure SetOptions(val : TFDOptions);
    function  GetRedoAvailable : boolean;
    function  GetSelectedComponents : TList;
    procedure SetSelectedComponents(val : TList);
    function  GetUndoAvailable : boolean;
    procedure SetUndoAvailable(val : boolean);
    function  GetCodeDesigner : TCodeDesigner;
    procedure SetCodeDesigner(val : TCodeDesigner);
    function  GetGridStepX : TGridStep;
    procedure SetGridStepX(val : TGridStep);
    function  GetGridStepY : TGridStep;
    procedure SetGridStepY(val : TGridStep);
    function  GetHideOnClose : boolean;
    procedure SetHideOnClose(val : boolean);
    function  GetLockControls : boolean;
    procedure SetLockControls(val : boolean);
    function  GetPopupMenu : TPopupMenu;
    procedure SetPopupMenu(val : TPopupMenu);
    function  GetShowInspector : boolean;
    procedure SetShowInspector(val : boolean);
    function  GetCompFiler : TCompFiler;
    function  GetShowGrid : boolean;
    procedure SetShowGrid(val : boolean);
    function  GetShowCaptions : boolean;
    procedure SetShowCaptions(val : boolean);
    function  GetSnapToGrid : boolean;
    procedure SetSnapToGrid(val : boolean);
    function  GetUndoLimit : integer;
    procedure SetUndoLimit(val : integer);
    function  GetWasChanged : boolean;
    procedure SetWasChanged(val : boolean);
    function  GetOnCloseForm : TNotifyEvent;
    procedure SetOnCloseForm(val : TNotifyEvent);
    function  GetOnChange : TNotifyEvent;
    procedure SetOnChange(val : TNotifyEvent);
    function  GetOnSelectionChanged : TNotifyEvent;
    procedure SetOnSelectionChanged(val : TNotifyEvent);
    function  GetOnDeleteComponent : TCNotifyProc;
    procedure SetOnDeleteComponent(val : TCNotifyProc);
    function  GetOnInsertComponent : TCNotifyProc;
    procedure SetOnInsertComponent(val : TCNotifyProc);
    function  GetOnGetComponentGlyph : TGetComponentGlyphProc;
    procedure SetOnGetComponentGlyph(val : TGetComponentGlyphProc);
    function  GetOnKeyDown : TKeyEvent;
    procedure SetOnKeyDown(val : TKeyEvent);
    function  GetOnMouseDown : TMouseEvent;
    procedure SetOnMouseDown(val : TMouseEvent);
    function  GetOnMouseUp : TMouseEvent;
    procedure SetOnMouseUp(val : TMouseEvent);
    function  GetOnMouseMove : TMouseMoveEvent;
    procedure SetOnMouseMove(val : TMouseMoveEvent);
    function  GetOnGetCompNames : TGetCompNamesEvent;
    procedure SetOnGetCompNames(val : TGetCompNamesEvent);
    function  GetOnAction : TActionEvent;
    procedure SetOnAction(val : TActionEvent);
    procedure SetLimitInfos(val : TLimitInfos);
    function  GetLimitInfos : TLimitInfos;
    procedure SetUseDefaultMenu(val : boolean);
    function  GetUseDefaultMenu : boolean;
    procedure SetUseGlobalOptions(val : boolean);
    function  GetUseGlobalOptions : boolean;
    function  GetShowComponents : boolean;
    procedure SetShowComponents(val : boolean);
    function  GetAllowedActions : TAllowedActions;
    procedure SetAllowedActions(val : TAllowedActions);
    function  GetReadOnlyProps : TStrings;
    procedure SetReadOnlyProps(val : TStrings);
    function  GetHiddenProps : TStrings;
    procedure SetHiddenProps(val : TStrings);

    function  GetOwnerComp : TComponent;

    procedure AlignSelected (XAlign, YAlign : TAlignControls);
    procedure ClipboardCut;
    procedure ClipboardCopy;
    procedure ClipboardPaste;

    procedure ClearSelectedComponents;
    procedure DeleteSelectedComponents;
    procedure FilterSelectedComponents(Comp : TComponent);
    procedure FilterSelection;

    procedure InsertComponent(AClassName : string);
    function  InstantInsertComponent(AClassName : string) : TComponent;

    procedure SizeSelected  (XSize,  YSize  : integer);
    procedure AlignToGrid;
    procedure BringToFront;
    procedure SendToBack;
    procedure Undo;
    procedure Redo;
    procedure Scale(const Factor : extended);
    procedure SelectAll;

    function  DeleteEmptyEvents : boolean;
    procedure SaveFormToStream(Stream:TStream;WriteAsRes:Boolean);
    procedure SaveFormToFile(const FileName : TFileName);

    procedure SaveComponentToStream(Instance : TComponent; S : TStream);

    function  GetTabOrderControl : TWInControl;

    procedure AddUsedModule(Module : TComponent);
    procedure RemoveUsedModule(Module : TComponent);

    function  GetAllowUndo : boolean;
    procedure SetAllowUndo(val : boolean);

    function  GetUseAncestor : boolean;
    procedure SetUseAncestor(val : boolean);

    procedure BeforeSave;
    procedure AfterSave;

    function  GetOnActivate : TNotifyEvent;
    procedure SetOnActivate(val : TNotifyEvent);

    property Active  : boolean read GetActive write SetActive;
    property Options : TFDOptions read GetOptions write SetOptions;
    property RedoAvailable : boolean read GetRedoAvailable;
    property SelectedComponents : TList read GetSelectedComponents write SetSelectedComponents;
    property UndoAvailable : boolean read GetUndoAvailable write SetUndoAvailable;
    property CodeDesigner : TCodeDesigner read GetCodeDesigner write SetCodeDesigner;
    property GridStepX : TGridStep read GetGridStepX write SetGridStepX;
    property GridStepY : TGridStep read GetGridStepY write SetGridStepY;
    property HideOnClose : boolean read GetHideOnClose write SetHideOnClose;
    property LockControls : boolean read GetLockControls write SetLockControls;
    property LimitInfos : TLimitInfos read GetLimitInfos write SetLimitInfos;
    property PopupMenu : TPopupMenu read GetPopupMenu write SetPopupMenu;
    property ShowInspector : boolean read GetShowInspector write SetShowInspector;
    property CompFiler : TCompFiler Read GetCompFiler;
    property ShowGrid : boolean read GetShowGrid write SetShowGrid;
    property ShowCaptions : boolean read GetShowCaptions write SetShowCaptions;
    property SnapToGrid : boolean read GetSnapToGrid write SetSnapToGrid;
    property UndoLimit : integer read GetUndoLimit write SetUndoLimit;
    property UseDefaultMenu : boolean read GetUseDefaultMenu write SetUseDefaultMenu;
    property UseGlobalOptions : boolean read GetUseGlobalOptions write SetUseGlobalOptions;
    property WasChanged : boolean read GetWasChanged write SetWasChanged;
    property AllowedActions : TAllowedActions read GetAllowedActions write SetAllowedActions;
    property ReadOnlyProps : TStrings read GetReadOnlyProps write SetReadOnlyProps;
    property HiddenProps : TStrings read GetHiddenProps write SetHiddenProps;
    property AllowUndo : boolean read GetAllowUndo write SetAllowUndo;
    property UseAncestor : boolean read GetUseAncestor write SetUseAncestor;

    property OnAction : TActionEvent read GetOnAction write SetOnAction;
    property OnChange : TNotifyEvent read GetOnChange write SetOnChange;
    property OnCloseForm : TNotifyEvent read GetOnCloseForm write SetOnCloseForm;
    property OnDeleteComponent : TCNotifyProc read GetOnDeleteComponent write SetOnDeleteComponent;
    property OnGetComponentGlyph : TGetComponentGlyphProc read GetOnGetComponentGlyph write SetOnGetComponentGlyph;
    property OnInsertComponent : TCNotifyProc read GetOnInsertComponent write SetOnInsertComponent;
    property OnKeyDown : TKeyEvent read GetOnKeyDown write SetOnKeyDown;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read GetOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read GetOnMouseUp write SetOnMouseUp;
    property OnGetCompNames : TGetCompNamesEvent read GetOnGetCompNames write SetOnGetCompNames;
    property OnSelectionChanged : TNotifyEvent read GetOnSelectionChanged write SetOnSelectionChanged;
    property OnActivate : TNotifyEvent read GetOnActivate write SetOnActivate;
  end;
{$ENDIF}

  TDCDragDropEvent = procedure(Sender, Source, Target: TObject; X, Y: Integer) of object;
  TDCDragOverEvent = procedure(Sender, Source, Target: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean) of object;

  TDCFormDesigner = class(TFDesigner{$IFDEF D4},TFormDesigner, IDCDesignerFormAccess,IDCFDesigner, IDCFormDesigner{$ENDIF}{$IFDEF D6},IDesignerHook,IDesignerNotify{$ENDIF})
  private
    FOnGetCompNames     : TGetCompNamesEvent;
    FCodeDesigner       : TCodeDesigner;
    FOptions            : TFDOptions;
    FNewPasteName       : String;
    FUpdateCount        : Integer;
    fSelectedComponents : TList;
    fOldSelected        : TList;
    fSelRect            : TRect;
    fSelParent          : TWinControl;
    fClipRect           : TRect;
    fSelRects           : TList;
    foldx               : integer;
    foldy               : integer;
    fGridStepX          : TGridStep;
    fGridStepY          : TGridStep;
    fUndoLimit          : integer;
    fUndoList           : TList;
    fRedoList           : TList;
    fControlHandles     : TControlHandles;
    fPopup              : TPopupMenu;
    fmenu               : TPopupMenu;
    fcedit              : TDCDsgnComp;
    fshiftcount         : integer;
    flastpastename      : string;
    fContainers         : TList;
    fLimitInfos         : TLimitInfos;
    fParentControlColor : TColor;
    fDrawDC             : THandle;
    fTempDC             : THandle;
    fControl            : TControl;
    fSendControl        : TComponent;
    fselections         : TList;
    fOldSelections      : TList;
    fDefaultPopup       : TPopupMenu;
    fAllowedActions     : TAllowedActions;
    fReadOnlyProps      : TStrings;
    fHiddenProps        : TStrings;
    fGridColor          : TColor;

    FOnActiveChanged    : TNotifyEvent;
    FOnDragDrop         : TDCDragDropEvent;
    FOnDragOver         : TDCDragOverEvent;
    fOnGetComponentGlyph: TGetComponentGlyphProc;
    fOnSelectionChanged : TNotifyEvent;
    fOnInsertComponent  : TCNotifyProc;
    fOnChange           : TNotifyEvent;
    fOnDeleteComponent  : TCNotifyProc;
    fOnMouseDown        : TMouseEvent;
    fOnMouseMove        : TMouseMoveEvent;
    fOnMouseUp          : TMouseEvent;
    fOnCloseForm        : TNotifyEvent;
    fOnKeyDown          : TKeyEvent;
    fOnAction           : TActionEvent;
    fOnAfterInsertComponent : TCNotifyProc;
    FCompFiler          : TCompFiler;
    fDeletionList       : TList;

    _NewMethodValue     : TMethod;
    _OldMethodName      : string;

    fMenuHolder         : TComponent;
    fScripter           : TDCSimpleScripter;
    fMethodTypeData     : PTypeData;
    fCreatedMethodName  : string;

    fOnEditProperty     : TEditPropertyProc;
    fOnShowProperty     : TShowPropertyProc;
    fOnSizeChanged      : TSizeChangedEvent;
    fUsedModules        : TList;
    fOpCount            : integer;
    fOldCompRect        : TRect;
    fHint               : TDCHint;
    fLastHintComp       : TComponent;
    fGetCompNamesProc   : TGetStrProc;
    fOnAllowPopup       : TAllowPopupEvent;
    fOnActivate         : TNotifyEvent;
    fOnStoreProp        : TStorePropertyProc;
    fOnProcessMenuItem  : TProcessMenuItemProc;
    fOnGetEventsList    : TGetEventsListEvent;
    FGetAncestorEvent   : TGetAncestorEvent;
    fPastedComps        : TStringList;
    fHookIsStoredCount  : integer;

    flock               : boolean;
    fSelectChanged      : boolean;
    fActive             : boolean;
    fSelecting          : boolean;
    FNeedRecreateWnd    : boolean;
    FShowInspector      : boolean;
    fShowGrid           : boolean;
    fHideOnClose        : boolean;
    fSnapToGrid         : boolean;
    fLockControls       : boolean;
    fShowHandles        : boolean;
    fMoving             : boolean;
    fMultipleSelect     : boolean;
    firstmove           : boolean;
    fneedhandles        : boolean;
    fShowCaptions       : boolean;
    fSkipMessage        : boolean;
    fWasChanged         : boolean;
    fHandleDraw         : boolean;
    fInMenuLoop         : boolean;
    fUseDefaultMenu     : boolean;
    fUseGlobalOptions   : boolean;
    fShowComponents     : boolean;
    fSkipNotification   : boolean;
    firsthandles        : boolean;
    ffirstPaste         : boolean;
    fNameIsReadOnly     : boolean;
    fMethodCreated      : boolean;
    fMethodDeleted      : boolean;
    fShowHints          : boolean;
    fInUndo             : boolean;
    fAllowUndo          : boolean;
    fInSave             : boolean;
    fUseAncestor        : boolean;

    saveisstored        : array[1..5] of byte;    

    procedure ReaderOnSetName(Reader: TReader; Component: TComponent;
                var Name: string);
    {IDCFormDesigner}
    function  GetActive : boolean;
    procedure SetActive(val : boolean);

    function  GetOptions : TFDOptions;
    procedure SetOptions(val : TFDOptions);

    function  GetRedoAvailable : boolean;

    function  GetSelectedComponents : TList;
    procedure SetSelectedComponents(val : TList);

    function  GetUndoAvailable : boolean;
    procedure SetUndoAvailable(val : boolean);

    function GetCodeDesigner : TCodeDesigner;
    procedure SetCodeDesigner(val : TCodeDesigner);

    function  GetGridStepX : TGridStep;
    procedure SetGridStepX(val : TGridStep);

    function  GetGridStepY : TGridStep;
    procedure SetGridStepY(val : TGridStep);

    function  GetHideOnClose : boolean;
    procedure SetHideOnClose(val : boolean);

    function  GetLockControls : boolean;
    procedure SetLockControls(val : boolean);

    function  GetPopupMenu : TPopupMenu;
    procedure SetPopupMenu(val : TPopupMenu);

    function  GetShowInspector : boolean;
    procedure SetShowInspector(val : boolean);

    function  GetCompFiler : TCompFiler;

    function  GetShowGrid : boolean;
    procedure SetShowGrid(val : boolean);

    function  GetShowCaptions : boolean;
    procedure SetShowCaptions(val : boolean);

    function  GetSnapToGrid : boolean;
    procedure SetSnapToGrid(val : boolean);

    function  GetUndoLimit : integer;
    procedure SetUndoLimit(val : integer);

    function  GetAllowedActions : TAllowedActions;
    procedure SetAllowedActions(val : TAllowedActions);

    function  GetReadOnlyProps : TStrings;
    procedure SetReadOnlyProps(val : TStrings);

    function  GetHiddenProps : TStrings;
    procedure SetHiddenProps(val : TStrings);

    function  GetUseAncestor : boolean;
    procedure SetUseAncestor(val : boolean);

    function  GetOnCloseForm : TNotifyEvent;
    procedure SetOnCloseForm(val : TNotifyEvent);
    function  GetOnChange : TNotifyEvent;
    procedure SetOnChange(val : TNotifyEvent);
    function  GetOnSelectionChanged : TNotifyEvent;
    procedure SetOnSelectionChanged(val : TNotifyEvent);
    function  GetOnDeleteComponent : TCNotifyProc;
    procedure SetOnDeleteComponent(val : TCNotifyProc);
    function  GetOnInsertComponent : TCNotifyProc;
    procedure SetOnInsertComponent(val : TCNotifyProc);
    function  GetOnGetComponentGlyph : TGetComponentGlyphProc;
    procedure SetOnGetComponentGlyph(val : TGetComponentGlyphProc);
    function  GetOnKeyDown : TKeyEvent;
    procedure SetOnKeyDown(val : TKeyEvent);
    function  GetOnMouseDown : TMouseEvent;
    procedure SetOnMouseDown(val : TMouseEvent);
    function  GetOnMouseUp : TMouseEvent;
    procedure SetOnMouseUp(val : TMouseEvent);
    function  GetOnMouseMove : TMouseMoveEvent;
    procedure SetOnMouseMove(val : TMouseMoveEvent);
    function  GetOnGetCompNames : TGetCompNamesEvent;
    procedure SetOnGetCompNames(val : TGetCompNamesEvent);
    function  GetOnAction : TActionEvent;
    procedure SetOnAction(val : TActionEvent);
    function  GetOnActivate : TNotifyEvent;
    procedure SetOnActivate(val : TNotifyEvent);
    procedure SetLimitInfos(val : TLimitInfos);
    function  GetLimitInfos : TLimitInfos;
    procedure SetUseDefaultMenu(val : boolean);
    function  GetUseDefaultMenu : boolean;
    procedure SetUseGlobalOptions(val : boolean);
    function  GetUseGlobalOptions : boolean;
    function  GetShowComponents : boolean;
    procedure SetShowComponents(val : boolean);
    function  GetAllowUndo : boolean;
    procedure SetAllowUndo(val : boolean);


    procedure AssignSelParent;
    function  FindParent(c : TComponent) : TWinControl;
    procedure DrawControlHandles (Component : TComponent; Visible : Boolean);
    procedure MakeSelRect;
    procedure DrawSelRect;
    procedure MoveSelection(X, Y : integer);
    procedure MoveControls (X, Y : integer);
    procedure FinishSelecting;
    procedure FinishMoving;
    procedure MarkSelected;
    procedure DoInsert;
    procedure DrawComponentHandles;
    procedure CancelMovingSelecting;
    procedure ControlSizeChanged(Sender : TObject; NewWidth, NewHeight : integer);
    procedure CreateControlHandles(aParent : TComponent);
    procedure ShowPopup(X, Y : integer);
    procedure CreateContainer(comp : TComponent; left, top : integer);
    function  GetContainer(comp : TComponent) : TComponentContainer;
    procedure ProcessNonControls;
    procedure ProcessKeyEscape(Shift : TShiftState);
    procedure ProcessKeyInsert(Shift : TShiftState);
    procedure ProcessKeyDelete(Shift : TShiftState);
    procedure ProcessKeyUp    (Shift : TShiftState);
    procedure ProcessKeyDown  (Shift : TShiftState);
    procedure ProcessKeyLeft  (Shift : TShiftState);
    procedure ProcessKeyRight (Shift : TShiftState);
    procedure ProcessKeyBack (Shift : TShiftState);

    procedure MoveSelectionUp;
    procedure MoveSelectionDown;
    procedure MoveSelectionLeft;
    procedure MoveSelectionRight;
    procedure DrawGridInRect(ARect : TRect);
    procedure PaintRect(ARect : TRect; index : integer);

    procedure FreeControlHandles;
    procedure ParentControlColorChanged;
    function  RealDoInsert(center : boolean) : TComponent;
    procedure Select;
    procedure DrawGridToDC(dc : THandle; updaterect : TRect);
    procedure MenuItemSelected(code : integer);
    function  CreateInsComponent : TComponent;
    procedure SnapRect(var r : TRect; SnapLeft, SnapTop, SnapRight, SnapBottom : boolean);
    procedure ValidateHandlesRect(Sender : TObject; var r : TRect);
    procedure AddTofSelections(c : TPersistent);
    procedure RemoveFromfSelections(c : TPersistent);
    procedure GetActionList(l : TList; Action : TActionType; Allowed : boolean);
    function  ActionAllowed(instance : TPersistent; Action : TActionType) : boolean;
    function  ActionsAllowed(Instance : TPersistent; Actions : TAllowedActions) : boolean;
    procedure PasteComponent(c : TComponent);
    procedure UpdateHandles;
    procedure SetReadOnly(val : Boolean);
    procedure SetWasChanged(val : Boolean);
    function  GetReadOnly : Boolean;
    function  GetWasChanged : Boolean;
    procedure DestroyContainer(container : TComponentContainer);
    procedure RenameEventsForComp(AComponent:TComponent;Const CurName,NewName:String);
    procedure FillWithEvents(TypeData: PTypeData; S : TStrings);
    procedure FillDefaultPopup(IsForm : boolean);

    procedure AlignToGridClick(Sender : TObject);
    procedure BringToFrontClick(Sender : TObject);
    procedure SendToBackClick(Sender : TObject);
    procedure AlignClick(Sender : TObject);
    procedure SizeClick(Sender : TObject);
{$IFDEF DCEDIT}
    procedure ScaleClick(Sender : TObject);
{$ENDIF}
{$IFDEF DREAMTREE}
    procedure TabOrderClick(Sender : TObject);
    procedure CreationOrderClick(Sender : TObject);
{$ENDIF}
    procedure LoadGlobalOptions;
    function  GetMethodByName(const Name : string) : TMethod;
    procedure RenameEvent(Instance : TPersistent; PropInfo : PPropInfo; UserData : integer);
    procedure RenameEvents(Comp : TComponent);
    function  InLimit(AComp : TPersistent) : boolean;
    function  GetLimitInfo(Instance : TComponent) : TLimitInfoItem;
    function  EditPropAllowed(Instance : TComponent; const PropName : string) : boolean;
    procedure CreateHandles;
    procedure FreeHandles;
    procedure UndoOperation(list : TList);
    procedure UndoDelete(CompStream : TStream);
    procedure RestorePos(c : TComponent; OldPos : TRect);
    procedure ReadComponentsFromStream(Stream : TStream);
    function  GetComponentPosition(comp : TComponent) : TRect;
    procedure StartControlSizeChanging(Sender : TObject);
    function  GetHint : TDCHint;
    procedure ShowMoveHint;
    procedure ShowSizeHint(const R : TRect);
    procedure ShowCompHint(c : TComponent);
    procedure HideHint;
    procedure AddUndoInfo(info : TUndoInfo);
    procedure CompLoaded(Sender : TObject);
    procedure DeleteCompList(l : TList);
    function  GetParentControl : TWinControl;
    procedure GetComponentNameProc(const ComponentName : string);

    procedure HookIsStored;
    procedure UnHookIsStored;
    procedure NeedStoreProp(Instance : TObject; PropInfo : PPropInfo; var Store : boolean);
    procedure ReaderOnReferenceName(Reader: TReader; var Name: string);
    
    property  Hint : TDCHint read GetHint;
  protected
    procedure CMPALETTECLICK(Var M:TMessage);message CM_PALETTECLICK;
    function  AnswerMessage:boolean; virtual;

    procedure ResizeSelectedComponents(deltax, deltay : integer);
    procedure MoveSelectedComponents(deltax, deltay : integer);

    procedure MouseDown(Button: TMouseButton;
                        Shift: TShiftState; X, Y: Integer); virtual;

    procedure MouseUp  (Button: TMouseButton;
                        Shift: TShiftState; X, Y: Integer); virtual;

    procedure MouseMove  (Shift: TShiftState; X, Y: Integer); virtual;

    procedure KeyDown    (var Key: Word; Shift: TShiftState); virtual;

    procedure GetComponentGlyph(AClass : TClass; ABitmap : TBitmap); virtual;
    procedure CloseForm; virtual;

    procedure BeginUpdate;virtual;
    procedure EndUpdate;virtual;
    procedure ValidateContainer(CompClass : TComponentClass);

    function  CreateUndoInfo : TUndoInfo;
    procedure AddUndoPosition(comp : TComponent; Rect : TRect);
    procedure AddUndoNewComp(comp : TComponent);
    procedure AddUndoDelete(comp : TComponent);

    procedure SavePosition(comp : TComponent);
    procedure SaveListPosition(l : TList);
    procedure ClearUndo;
  public
    DataObject : pointer;

    function InUpdate : boolean;override;
    procedure BringContainersToFront;
    procedure Activate; virtual;
    function  IsComponentLinkable(Component: TComponent): Boolean; {$IFNDEF D4}override;{$ENDIF}
    procedure MakeComponentLinkable(Component: TComponent); {$IFNDEF D4}override;{$ENDIF}
    procedure RenameMethod(const CurName, NewName: string);{$IFNDEF D4}override;{$ENDIF}
    procedure ShowMethod(const AName: string); {$IFNDEF D4}override;{$ENDIF}
    procedure Modified;{$IFNDEF D4}override;{$ENDIF}
    {$IFNDEF D4}
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    {$ELSE}
    procedure Notification(AnObject: TPersistent; Operation: TOperation);
    {$ENDIF}
    procedure ValidateRename(AComponent: TComponent; const CurName, NewName: string); {$IFNDEF D4}override;{$ENDIF}
    function  IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;  {$IFNDEF D4}override;{$ENDIF}
    function  GetMethodName(const Method : TMethod): string; {$IFNDEF D4}override;{$ENDIF}
    procedure GetMethods(TypeData: PTypeData; Proc: TGetStrProc); {$IFNDEF D4}override;{$ENDIF}
    function  MethodExists(const Name: string): Boolean; {$IFNDEF D4}override;{$ENDIF}
    procedure GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc); {$IFNDEF D4}override;{$ENDIF}
    function  CreateMethod(const Name: string; TypeData: PTypeData): TMethod; {$IFNDEF D4}override;{$ENDIF}

    function  GetOwnerControl : TComponent; override;
    {$IFDEF D4}
    function  IDCFormDesigner.GetOwnerComp = GetOwnerControl;
    {$ENDIF}

    function  GetTabOrderControl:TWInControl;
    function  DeleteEmptyEvents : boolean;
    procedure SaveFormToStream(Stream:TStream;WriteAsRes:Boolean);
    procedure SaveFormToFile(Const FileName : TFileName);
    procedure SaveComponentToStream(Instance : TComponent; S : TStream);
    procedure BeforeSave; virtual;
    procedure AfterSave;  virtual;
{$IFDEF D3}
    procedure SelectComponent(Instance: TPersistent); {$IFNDEF D4}override;{$ENDIF}
{$ELSE}
    procedure SelectComponent(Instance: TComponent); override;
{$ENDIF}
    constructor Create ;
    destructor  Destroy; override;
    procedure PaintGrid; {$IFNDEF D4}override;{$ENDIF}
    procedure ClearSelectedComponents;
    procedure DeleteSelectedComponents;
    procedure FilterSelectedComponents(Comp : TComponent);
    procedure FilterSelection;
    procedure InsertComponent(AClassName : string);
    function  InstantInsertComponent(AClassName : string) : TComponent;
    procedure AlignSelected (XAlign, YAlign : TAlignControls);
    procedure SizeSelected  (XSize,  YSize  : integer);
    {$IFNDEF D4}
    procedure SetSelections(List: TComponentList); override;
    {$ELSE}
    procedure SetSelections(const List: IDesignerSelections);
    {$ENDIF}

    procedure Scale(const Factor : extended);
    procedure SelectAll;
    procedure AlignToGrid;
    procedure BringToFront;
    procedure SendToBack;

    procedure Undo;virtual;
    procedure Redo;virtual;

    procedure UndoAll;

    procedure ClipboardCut;
    procedure ClipboardCopy;
    procedure ClipboardPaste;

    procedure ShowHandles;
    procedure HideHandles;

    function  AllowEdit(Instance : TComponent; const PropName : string) : boolean; override;
    function  CanBeSelected(Instance : TPersistent) : boolean; override;
    function  AllowPropShow(Instance : TComponent; const PropName : string) : boolean; override;

    procedure AddUsedModule(Module : TComponent);
    procedure RemoveUsedModule(Module : TComponent);

    function  CreateComponent(ComponentClass: TComponentClass; Parent: TComponent;
                              Left, Top, Width, Height: Integer): TComponent; override;

    {$IFDEF D5}
    procedure CopySelection; override;
    procedure CutSelection; override;
    procedure PasteSelection; override;

    {$IFDEF D6}
    procedure DeleteSelection(ADoAll: Boolean = False);override;
    {$ELSE}
    procedure DeleteSelection; override;
    {$ENDIF}

    procedure ClearSelection; override;
    {$ENDIF}

    procedure AddSelectedComponent  (val : TComponent);
    procedure DeselectComponent (val : TPersistent);

    property ReadOnly : boolean read GetReadOnly write SetReadOnly;
    property WasChanged:Boolean read GetWasChanged write SetWasChanged;
    property Active : boolean read GetActive write SetActive;
    property Options: TFDOptions read GetOptions write SetOptions;
    property RedoAvailable : boolean read GetRedoAvailable;
    property SelectedComponents : TList read GetSelectedComponents write SetSelectedComponents;
    property UndoAvailable : boolean read GetUndoAvailable write SetUndoAvailable;
    property CodeDesigner:TCodeDesigner read GetCodeDesigner write SetCodeDesigner;
    property GridStepX : TGridStep read GetGridStepX write SetGridStepX default 8;
    property GridStepY : TGridStep read GetGridStepY write SetGridStepY default 8;
    property HideOnClose : boolean read GetHideOnClose write SetHideOnClose default true;
    property LimitInfos : TLimitInfos read GetLimitInfos write SetLimitInfos;
    property LockControls : boolean read GetLockControls write SetLockControls;
    property NameIsReadOnly : boolean read fNameIsReadOnly write fNameIsReadOnly;
    property NeedRecreateWnd:boolean Read FNeedRecreateWnd Write FNeedRecreateWnd;
    property PopupMenu : TPopupMenu read GetPopupMenu write SetPopupMenu;
    property ShowInspector:boolean read GetShowInspector write SetShowInspector;
    property CompFiler : TCompFiler read GetCompFiler;
    property ShowGrid : boolean read GetShowGrid write SetShowGrid default true;
    property ShowCaptions : boolean read GetShowCaptions write SetShowCaptions;
    property ShowComponents : boolean read GetShowComponents write SetShowComponents;
    property SnapToGrid : boolean read GetSnapToGrid write SetSnapToGrid;
    property UndoLimit : integer read GetUndoLimit write SetUndoLimit default 32;
    property UseDefaultMenu : boolean read GetUseDefaultMenu write SetUseDefaultMenu;
    property UseGlobalOptions : boolean read GetUseGlobalOptions write SetUseGlobalOptions;

    property Scripter : TDCSimpleScripter read fScripter write fScripter;
    property AllowedActions : TAllowedActions read GetAllowedActions write SetAllowedActions;
    property ReadOnlyProps : TStrings read GetReadOnlyProps write SetReadOnlyProps;
    property HiddenProps : TStrings read GetHiddenProps write SetHiddenProps;
    property ShowHints : boolean read fShowHints write fShowHints;
    property AllowUndo : boolean read GetAllowUndo write SetAllowUndo;
    property UseAncestor : boolean read GetUseAncestor write SetUseAncestor default True;

    property GridColor : TColor read fGridColor write fGridColor;

    property OnAction : TActionEvent read GetOnAction write SetOnAction;
    property OnActiveChanged : TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnChange : TNotifyEvent read GetOnChange write SetOnChange;
    property OnCloseForm : TNotifyEvent read GetOnCloseForm write SetOnCloseForm;
    property OnDeleteComponent : TCNotifyProc read GetOnDeleteComponent write SetOnDeleteComponent;
    property OnDragDrop:TDCDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnDragOver:TDCDragOverEvent read FOnDragOver write FOnDragOver;
    property OnGetComponentGlyph : TGetComponentGlyphProc read GetOnGetComponentGlyph write SetOnGetComponentGlyph;
    property OnAfterInsertComponent : TCNotifyProc read fOnAfterInsertComponent write fOnAfterInsertComponent;
    property OnInsertComponent : TCNotifyProc read GetOnInsertComponent write SetOnInsertComponent;
    property OnKeyDown : TKeyEvent read GetOnKeyDown write SetOnKeyDown;
    property OnMouseDown: TMouseEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read GetOnMouseMove write SetOnMouseMove;
    property OnMouseUp: TMouseEvent read GetOnMouseUp write SetOnMouseUp;
    property OnGetCompNames : TGetCompNamesEvent Read GetOnGetCompNames Write SetOnGetCompNames;
    property OnSelectionChanged : TNotifyEvent read GetOnSelectionChanged write SetOnSelectionChanged;
    property OnEditProperty : TEditPropertyProc read fOnEditProperty write fOnEditProperty;
    property OnShowProperty : TShowPropertyProc read fOnShowProperty write fOnShowProperty;
    property OnSizeChanged : TSizeChangedEvent read fOnSizeChanged write fOnSizeChanged;
    property OnActivate : TNotifyEvent read GetOnActivate write SetOnActivate;
    property OnAllowPopup : TAllowPopupEvent read fOnAllowPopup write fOnAllowPopup;
    property OnStoreProp : TStorePropertyProc read fOnStoreProp write fOnStoreProp;
    property OnProcessMenuItem : TProcessMenuItemProc read fOnProcessMenuItem write fOnProcessMenuItem;
    property OnGetEventsList : TGetEventsListEvent read fOnGetEventsList write fOnGetEventsList;
    property OnGetAncestor: TGetAncestorEvent read FGetAncestorEvent write FGetAncestorEvent;
  end;

{$IFNDEF D4}
  IDCFormDesigner = TDCFormDesigner;
{$ENDIF}

  TComponentContainerSpeedButton = class(TDCSpeedButton)
  public
    Container : TComponentContainer;
    property Canvas;
  end;

{*******************************************************}

  TComponentContainerCaption = class (TObject)
  private
    fwnd       : THandle;
    fText      : string;
    fColor     : TColor;
    fContainer : TComponentContainer;
    procedure SetText(const val : string);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure Paint; virtual;
    function GetWidth: integer;
    function GetHeight: integer;
  public
    constructor Create;
    destructor  Destroy; override;
    property Text : string read fText write SetText;
    property Color : TColor read fColor write fColor;
    property Handle : THandle read fWnd;
    property Height: integer read GetHeight;
    property Width : integer read GetWidth;
  end;

{*******************************************************}

  TComponentContainer = class(TObject)
  private
    fWnd       : THandle;
    fContained : TComponent;
    fParent    : TWinControl;
    fCanvas    : TCanvas;
    fbut       : TComponentContainerSpeedButton;
    fHandles   : TControlHandles;
    fCaption   : TComponentContainerCaption;

    fshowhandles : boolean;
    fGrayHandles : boolean;
    fShowCaption : boolean;

    procedure WndProc(var Msg: TMessage);
    procedure SetPosition;
    procedure SetCaption(const val : string);
    function  GetHeight : integer;
    function  GetWidth : integer;
    function  DesignerMessage(var Msg : TMessage) : boolean;
  protected
    procedure Paint; virtual;
    procedure SetContained(val : TComponent); virtual;
    procedure SetParent(val : TWinControl); virtual;
    procedure SetShowCaption(val : boolean);
    procedure SetGlyph (val : TBitmap);
    procedure SetLeft  (val : integer);
    procedure SetTop   (val : integer);
    procedure SetTopLeft(val : TPoint);
    function  GetTopLeft : TPoint;
    function  GetLeft : integer;
    function  GetTop  : integer;
    function  GetGlyph : TBitmap;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure DrawHandles(visible : boolean);
    procedure ShowHandles;
    procedure HideHandles;
    function  GetCaptionColor : TColor;
    procedure SetCaptionColor(val : TColor);
    procedure Show;

    property Caption      : string write SetCaption;
    property CaptionColor : TColor read GetCaptionColor write SetCaptionColor;
    property Contained   : TComponent read fContained write SetContained;
    property Glyph       : TBitmap read GetGlyph write SetGlyph;
    property Handle      : THandle read fwnd;
    property Left        : integer read GetLeft write SetLeft;
    property Top         : integer read GetTop write SetTop;
    property Height      : integer read GetHeight;
    property Width       : integer read GetWidth;
    property Parent      : TWinControl read fParent write SetParent;
    property TopLeft     : TPoint read GetTopLeft write SetTopLeft;
    property ShowCaption : boolean read fShowCaption write SetShowCaption;
  published
  end;

  TControlHandles = class(TComponent)
  private
    fChandles : array[hpFirst .. hpLast] of TObject;
    fParentControl : TControl;
    fOnMouseDown   : TCHMouseDown;
    fOnStartSizeChanging : TStartSizeChangeProc;
    fOnSizeChanging : TSizeChangeProc;
    fOnSizeChanged  : TSizeChangeProc;
    fOnValidateRect : TValidateRectProc;
    fCurRect        : TRect;
    fsaveShowMode   : TCHShowMode;
    fShowMode       : TCHShowMode;
    fClipRect       : TRect;
    fParentLeft     : integer;
    fParentTop      : integer;
    fParentRect     : TRect;
    fDesigner       : TDCFormDesigner;

    fSizingHandle   : THandlePosition;
    fActive         : boolean;
    fVisible        : boolean;
    fSizing         : boolean;
    fCanBeSized     : boolean;

    procedure UpdateAll;
  protected
{
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
}
    procedure SetActive  (val : boolean);
    procedure SetShowMode (val : TCHShowMode);
    procedure SetVisible (val : boolean);
    procedure SetCanBeSized(val : boolean);
    procedure SetParentControl (val : TControl);
    procedure OnCHandleMouseDown (Sender: TObject; Button: TMouseButton;
                                  Shift: TShiftState; X, Y: Integer);
    procedure OnCHandleSizeChanging(Sender : TObject; X, Y : integer);
    procedure OnCHandleSizeChanged(Sender : TObject; X, Y : integer);
    procedure OnCHandleStartSizeChanging(Sender : TObject);
    procedure OnCHandleCancelSizing(Sender : TObject);

  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ResetPosition;
    function  IsHandleWindow(wnd : HWND) : boolean;
    procedure Update;
    procedure Show;
    procedure FinishSizing;

    property ParentControl : TControl read fParentControl write SetParentControl;
    property Active  : boolean read fActive write SetActive;
    property CanBeSized : boolean read fCanBeSized write SetCanBeSized;
    property Visible : boolean read fVisible write SetVisible;

  published
    property ShowMode : TCHShowMode read fShowMode write SetShowMode;

    property OnStartSizeChanging : TStartSizeChangeProc read fOnStartSizeChanging write fOnStartSizeChanging;
    property OnSizeChanging : TSizeChangeProc read fOnSizeChanging write fOnSizeChanging;
    property OnSizeChanged  : TSizeChangeProc read fOnSizeChanged write fOnSizeChanged;
    property OnValidateRect : TValidateRectProc read fOnValidateRect write fOnValidateRect;
    property OnMouseDown    : TCHMouseDown read fOnMouseDown write fOnMouseDown;
  end;

  {
  TDCOleControlEditor = class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;
  }
const
  ContainerSize = 28;

var
  { Instance of this class will be created when user select form object in
    New dialog }
  DefaultNewFormClassType:TComponentClass=TForm;

  { Instance of this class will be created when user selects DataModule object in
    New dialog }
  DefaultNewDMClassType:TComponentClass=TDataModule;

{------------------------------------}

procedure AddDataModuleWrapper(DataModule : TDataModule; Wrapper : TCustomForm);
procedure RemoveDataModuleWrapper(DataModule : TDataModule);

procedure AlignControls (Controls : TList; XAlign, YAlign : TAlignControls);
procedure SizeControls  (Controls : TList; XSize,  YSize  : integer);
procedure DrawSelection (Rect : TRect);
procedure SmartDrawSelection (Rect : TRect);
procedure CheckRect (var Rect : TRect);
function  SetClipping(c : TWinControl) : TRect;
procedure RemoveClipping;
procedure CopyControls(FromList,ToList:TList);

{------------------------------------}

procedure CenterDesignedForm(F:TCustomForm;const ACaption:String);
procedure DesignerGetVerbState(Var VerbStates:TVerbStates);
function GetActiveDesigner : IDCFormDesigner;


type
  TDataModuleWrapper = class(TForm)
  private
    fNotifier : TControl;
    fDataModule : TDataModule;
    fSkipComp   : TComponent;

    procedure SetDataModule(val : TDataModule);
    procedure SetDataModulePosition;
    procedure CreateNotifier;
  protected
    procedure WMSize (var Msg : TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure CMPROPCHANGED(Var M : TMessage); message CM_PROPCHANGED;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure UpdateScrollbars;

    property DataModule : TDataModule read fDataModule write SetDataModule;
  end;

type
  TOleControl_FocusChanged = procedure(Sender : TObject; GotFocus : boolean) of object;

type
  TDCOleControl_ = class(TOleControl{, IOleControlSite}(*{$IFDEF D3}, IUnknown{$ENDIF}*))
  private
    fguid : TGUID;
    cdata : TControlData;
    fOnFocusChanged : TOleControl_FocusChanged;

    fNeedFreeLic : boolean;

    procedure CMUIDeactivate(var Message: TMessage); message CM_UIDEACTIVATE;
 public
    constructor CreateGUID(AOwner : TComponent; AGUID : TGUID);
    constructor CreateControlData(AOwner : TComponent; AControlData : PControlData);

    destructor Destroy; override;

    procedure   InitControlData; override;

    property  OnFocusChanged : TOleControl_FocusChanged read fOnFocusChanged write fOnFocusChanged;
  end;

  TDCOLEControl = class;

  TOLEEventDispatch = class({$IFNDEF D3}IDispatch{$ELSE}TObject, IUnknown, IDispatch {$ENDIF})
  private
    fWrapper : TDCOLEControl;
    fEventIID : TGUID;
{$IFDEF D3}
    { IUnknown }
    function QueryInterface(const IID: TGUID; {$IFDEF D3}out{$ELSE}var{$ENDIF} Obj): HRESULT; {$IFNDEF D3} override; {$ENDIF}stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IDispatch }
    function GetTypeInfoCount({$IFDEF D3}out{$ELSE}var{$ENDIF}Count: Integer): HResult; {$IFNDEF D3} override; {$ENDIF}stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; {$IFDEF D3}out{$ELSE}var{$ENDIF}TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
{$ENDIF}
  public
    constructor Create(AOwner : TDCOleControl);
    {$IFNDEF D3}
    function QueryInterface(const iid: TIID; var obj): HResult; override;
    function AddRef: Longint; override;
    function Release: Longint; override;
    function GetTypeInfoCount(var ctinfo: Integer): HResult; override;
    function GetTypeInfo(itinfo: Integer; lcid: TLCID;
      var tinfo: ITypeInfo): HResult; override;
    function GetIDsOfNames(const iid: TIID; rgszNames: POleStrList;
      cNames: Integer; lcid: TLCID; rgdispid: PDispIDList): HResult; override;
    function Invoke(dispIDMember: TDispID; const iid: TIID; lcid: TLCID;
      flags: Word; var dispParams: TDispParams; varResult: PVariant;
      excepInfo: PExcepInfo; argErr: PInteger): HResult; override;
    {$ENDIF}
  end;

  TEventInfo = class
  public
    EventID : integer;
    Handler : string;
  end;

  TDCOleControl = class(TCustomDCOleControl)
  private
    fguid : TGUID;
    fControlData : PControlData;
    fOleControl : TDCOleControl_;
    fOleInPlaceObject : IOleInplaceObject;
    fOlename : string;
    fHint    : string;
    fCursor  : TCursor;
    fOleEventDispatch : TOLEEventDispatch;
    fEventsConnection : integer;
    fEvents  : TList;
    flicence : string;
    fInSetBounds : boolean;

    function  GetGUID : string;
    procedure SetGUID(const val : string);

    procedure SetClassID(const val : TGUID);
    procedure SetControlData(AControlData : PControlData);

    procedure CreateOLEControl;
    procedure LoadFromStream(Stream: TStream);
    procedure WriteToStream(Stream: TStream);
    procedure LoadEvents(Stream: TStream);
    procedure WriteEvents(Stream: TStream);

    procedure LoadLicence(Stream: TStream);
    procedure WriteLicence(Stream: TStream);

    procedure LoadGUID(Reader : TReader);
    procedure WriteGUID(Writer : TWriter);
    procedure FocusChanged(Sender : TObject; GotFocus : boolean);
  protected
    function  GetOleObject : IOleObject; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure CreateHandle; override;
    function  GetOleName : string; override;
{$IFDEF D3}
    function  GetWideStringProp(Index: Integer): WideString;
    procedure SetWideStringProp(Index: Integer; const Value: WideString);

    function  GetWordBoolProp(Index: Integer): WordBool;
    procedure SetWordBoolProp(Index: Integer; Value: WordBool);
    function  GetTOleEnumProp(Index: Integer): TOleEnum;
    procedure SetTOleEnumProp(Index: Integer; Value: TOleEnum);
{$ENDIF}
    function  GetIntegerProp(Index: Integer): Integer;
    procedure SetIntegerProp(Index: Integer; Value: Integer);
    procedure Init;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    constructor CreateControlData(AOwner : TComponent; AControlData : PControlData);
    constructor CreateGUID(AOwner : TComponent; AGUID : TGUID);

    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    function    FindEvent(ID : integer) : integer;
    procedure   SetEvent(ID : integer; const HandlerName : string); override;
    function    GetEvent(ID : integer) : string; override;

    property    OleControl : TDCOleControl_ read fOleControl;
    property    OleObject : IOleObject read GetOleObject;
    property    ControlGUID : string read GetGUID write SetGUID;
    property    ControlClassID : TGUID read fguid write SetClassID;
    property    OleControlData : PControlData read fControlData write SetControlData;
  published
    property Hint : string read fHint;
    property Cursor : TCursor read fCursor;
    property Align;
  end;

const
  AllActionsAllowed = [atSelect .. atEdit];

function GlobalDesignerOptions : TDesignerOptions;

type
  TInspOptions = class(TPersistent)
  private
    FHideEvents   : boolean;
    procedure SetHideEvents(Value : boolean);
  published
    property HideEvents : boolean read FHideEvents write SetHideEvents default false;
  end;

  TCustomLiteDesigner = Class(TComponent)
  private
    FDesigner            : TDCFormDesigner;
    FStartHotKey         : TShortCut;
    FStopHotKey          : TShortCut;
    FDesignedComponent   : TComponent;
    fWrapper             : TCustomForm;
    fdform               : TCustomForm;
    fdcomponent          : TComponent;

    FOnAction            : TActionEvent;
    FOnActiveChanged     : TNotifyEvent;
    FOnActiveChanging    : TActiveChangingEvent;
    FOnChange            : TNotifyEvent;
    FOnCloseForm         : TNotifyEvent;
    FOnDeleteComponent   : TCNotifyProc;
    FOnDragDrop          : TDCDragDropEvent;
    FOnDragOver          : TDCDragOverEvent;
    fOnAfterInsertComponent : TCNotifyProc;
    FOnGetComponentGlyph : TGetComponentGlyphProc;
    FOnInsertComponent   : TCNotifyProc;
    FOnKeyDown           : TKeyEvent;
    FOnMouseDown         : TMouseEvent;
    FOnMouseMove         : TMouseMoveEvent;
    FOnMouseUp           : TMouseEvent;
    FOnGetCompNames      : TGetCompNamesEvent;
    FOnSelectionChanged  : TNotifyEvent;
    fOnEditProperty      : TEditPropertyProc;
    fOnShowProperty      : TShowPropertyProc;
    fChangesKey          : string;
    fChanges             : TDCCompChanges;
    fHandleObject        : TDCHandleObject;
    fOnLoadChanges       : TProcessChangesProc;
    fOnSaveChanges       : TProcessChangesProc;
    fPaletteOptions      : TCompPaletteOptions;
    FInspectorOptions    : TInspOptions;
    fOnStoreProp         : TStorePropertyProc;
    fOnProcessMenuItem : TProcessMenuItemProc;
    fOnSizeChanged       : TSizeChangedEvent;
    fOnAllowPopup        : TAllowPopupEvent;
    fOnGetEventsList     : TGetEventsListEvent;
    FOnGetAncestor       : TGetAncestorEvent;

    fCaptionGlyph        : TBitmap;
    fCBut                : TDCCaptionButton;
    FVersion             : TDCVersion;

    fToolsOnTop          : boolean;
    FShowPalette         : boolean;
    FShowAlignPalette    : boolean;
    fFirstKeyDown        : boolean;
    fStoreChanges        : boolean;
    fLoaded              : boolean;
    fUseCaptionButton    : boolean;
    fCaptionGlyphChanged : boolean;
    fShowSelf            : boolean;
    fIsStored            : boolean;

    function  GetNeedRecreateWnd:boolean;
    procedure SetNeedRecreateWnd(V:Boolean);
    function  GetReadOnly :boolean;
    procedure SetReadOnly(val : boolean);
    function  GetActive : boolean;
    function  GetOptions : TFDOptions;
    procedure SetOptions(val : TFDOptions);
    function  GetGridStepX : TGridStep;
    procedure SetGridStepX(val : TGridStep);
    function  GetGridStepY : TGridStep;
    procedure SetGridStepY(val : TGridStep);
    function  GetLockControls : boolean;
    procedure SetLockControls(val : boolean);
    function  GetPopupMenu : TPopupMenu;
    procedure SetPopupMenu(val : TPopupMenu);
    function  GetShowInspector : boolean;
    procedure SetShowInspector(val : boolean);
    function  GetShowGrid : boolean;
    procedure SetShowGrid(val : boolean);
    function  GetShowCaptions : boolean;
    procedure SetShowCaptions(val : boolean);
    function  GetSnapToGrid : boolean;
    procedure SetSnapToGrid(val : boolean);
    function  GetNameIsReadOnly : boolean;
    procedure SetNameIsReadOnly(val : boolean);
    function  GetLimitInfos : TLimitInfos;
    procedure SetLimitInfos(val : TLimitInfos);
    function  GetUseDefaultMenu : boolean;
    procedure SetUseDefaultMenu(val : boolean);
    procedure SetUseGlobalOptions(val : boolean);
    function  GetUseGlobalOptions : boolean;
    procedure SetLimitControl(Value : TWinControl);
    function  GetLimitControl : TWinControl;
    function  GetShowComponents : boolean;
    procedure SetShowComponents(val : boolean);
    function  GetCodeDesigner : TCodeDesigner;
    procedure SetCodeDesigner(Value : TCodeDesigner);
    procedure SetScripter(val : TDCSimpleScripter);
    function  GetScripter : TDCSimpleScripter;
    function  GetAllowedActions : TAllowedActions;
    procedure SetAllowedActions(val : TAllowedActions);
    function  GetReadOnlyProps : TStrings;
    procedure SetReadOnlyProps(val : TStrings);
    function  GetHiddenProps : TStrings;
    procedure SetHiddenProps(val : TStrings);
    procedure SetPaletteOptions(val : TCompPaletteOptions);
    procedure SetInspectorOptions(Value : TInspOptions);
    procedure SetToolsOnTop(val : boolean);
    function  GetShowHints : boolean;
    procedure SetShowHints(val : boolean);
    procedure SetUseCaptionButton(val : boolean);
    procedure SetCaptionGlyph(val : TBitmap);
    function  GetAllowUndo : boolean;
    procedure SetAllowUndo(val : boolean);
    function  GetOnGetButtonHint : TOnGetHintEvent;
    procedure SetOnGetButtonHint(Value : TOnGetHintEvent);

    function  GetGridColor : TColor;
    procedure SetGridColor(val : TColor);

    function  GetUseAncestor : boolean;
    procedure SetUseAncestor(val : boolean);

    procedure LoadGlobalOptions;
    procedure SetDesignedComponent(val : TComponent);
    procedure AfterInsertComponent(Sender : TObject; AControl : TComponent);

    procedure DeleteComponent(Sender : TObject; AControl : TComponent);
    procedure Action(Sender : TObject; Instance : TPersistent;Action : TActionType; var Allow : boolean);
    procedure Change(Sender: TObject);
    procedure CloseForm(Sender: TObject);
    procedure DragDrop(Sender,Source,Target:TObject;X,Y:Integer);
    procedure DragOver(Sender,Source,Target:TObject;X,Y:Integer;State:TDragState;var Accept:Boolean);
    procedure InsertComponent (Sender : TObject; AControl : TComponent);
    procedure GetComponentGlyph(Sender : TObject; AClass : TClass ;  AGlyph : TBitmap);
    procedure KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
    procedure MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GetCompNames(Sender:TObject;TypeData: PTypeData; Proc: TGetStrProc);
    procedure EditProperty(Sender : TObject; Instance : TObject; const PropName : string; var AllowEdit : boolean);
    procedure ShowProperty(Sender : TObject; Instance : TObject; const PropName : string; var AllowShow : boolean);
    procedure ProcessMenuItemProc(Sender : TObject; MenuItem : TMenuItem; var AllowCommand : boolean);
    procedure HookProc(var Msg : TMessage); message CM_HOOKPROC;
    procedure CButtonClick(Sender : TObject);
    function  GetChangesKey : string;
    function  CButton : TDCCaptionButton;
    function  IsPaletteOptionsStored : boolean;
    procedure CaptionGlyphChanged(Sender : TObject);
    procedure IsPropStored(Sender : TObject; Instance : TObject; const PropName : string; var Store : boolean);
    procedure SizeChanged(Sender : TObject; ChangedControl : TControl);
    procedure AllowPopup (Sender : TObject; Shift: TShiftState; X, Y: Integer; var AllowPopup : boolean);
    procedure GetEventsList(Sender : TObject; TypeData : PTypeData; EventsList : TStrings);
    procedure GetAncestor(Sender: TObject; var Ancestor: TComponent);
  protected
    procedure SelectionChanged(Sender: TObject); virtual;
    
    procedure SetActive(val : boolean);virtual;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    function  GetRealDesignedComponent : TComponent;

    procedure SaveChanges; virtual;
    procedure LoadChanges; virtual;

    procedure Loaded; override;

    procedure AllLoaded(var Message : TMessage); message CM_ALLLOADED;
    procedure ActiveChanged(Sender: TObject); virtual;

    procedure DisplayPalette;
    procedure HidePalette;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy ; override;

    function  CreateFromFile(const FileName : TFileName; ModuleClass : TComponentClass) : TComponent;
    function  CreateFromStream(S : TStream; ModuleClass : TComponentClass) : TComponent;

    procedure LoadFromFile(Instance : TComponent; const FileName : TFileName);
    procedure LoadFromStream(Instance : TComponent; S : TStream);
    function  LoadFromStrings(Instance : TComponent; Strings : TStrings) : string;

    procedure SaveToFile(const FileName : TFileName);
    procedure SaveToStream(S : TStream);
    procedure SaveToStrings(Strings : TStrings);

    procedure SaveComponentToStream(Instance : TComponent; S : TStream);
    procedure LoadComponentFromStream(Instance : TComponent; S : TStream);

    function  CreateComponentFromStream(S : TStream; AParent : TComponent) : TComponent;
    function  CreateComponentFromFile(const FileName : TFileName; AParent : TComponent) : TComponent;

    procedure SaveComponentToFile(Instance : TComponent; const FileName : TFileName);
    procedure LoadComponentFromFile(Instance : TComponent; const FileName : TFileName);

    procedure AddUsedModule(Module : TComponent);
    procedure RemoveUsedModule(Module : TComponent);

    function  CanPaste : boolean;
    function  CanCut   : boolean;
    function  CanCopy  : boolean;

    procedure ClearChanges; virtual;

    procedure CancelChanges;

    function  HasParent : boolean; override;

    property Active   : boolean read GetActive write SetActive;
    property AllowUndo : boolean read GetAllowUndo write SetAllowUndo default False;
    property DataModuleWrapper: TCustomForm read fWrapper;
    property Designer : TDCFormDesigner read FDesigner;
    property UseCaptionButton : boolean read fUseCaptionButton write SetUseCaptionButton default False;
    property CaptionGlyph : TBitmap read fCaptionGlyph write SetCaptionGlyph stored fCaptionGlyphChanged;
    property Changes  : TDCCompChanges read fChanges;
    property AllowedActions : TAllowedActions read GetAllowedActions write SetAllowedActions default AllActionsAllowed;
    property DesignedComponent : TComponent read FDesignedComponent write SetDesignedComponent;
    property HiddenProps : TStrings read GetHiddenProps write SetHiddenProps;
    property ReadOnly : boolean read GetReadOnly write SetReadOnly default False;
    property ReadOnlyProps : TStrings read GetReadOnlyProps write SetReadOnlyProps;
    property Options: TFDOptions read GetOptions write SetOptions default [fdAllowDelete, fdAllowInsert];
    property GridStepX : TGridStep read GetGridStepX write SetGridStepX default 8;
    property GridStepY : TGridStep read GetGridStepY write SetGridStepY default 8;
    property LockControls : boolean read GetLockControls write SetLockControls default False;
    property LimitControl : TWinControl read GetLimitControl write SetLimitControl;
    property LimitInfos : TLimitInfos read GetLimitInfos write SetLimitInfos;
    property PaletteOptions : TCompPaletteOptions read fPaletteOptions write SetPaletteOptions stored IsPaletteOptionsStored;
    property InspectorOptions  : TInspOptions read FInspectorOptions write SetInspectorOptions;
    property PopupMenu : TPopupMenu read GetPopupMenu write SetPopupMenu;
    property ShowInspector:boolean read GetShowInspector write SetShowInspector;
    property ShowComponents : boolean read GetShowComponents write SetShowComponents default True;
    property ShowGrid : boolean read GetShowGrid write SetShowGrid default true;
    property ShowCaptions : boolean read GetShowCaptions write SetShowCaptions;
    property ShowHints : boolean read GetShowHints write SetShowHints;
    property SnapToGrid : boolean read GetSnapToGrid write SetSnapToGrid;
    property NameIsReadOnly : boolean read GetNameIsReadOnly write SetNameIsReadOnly default False;
    property NeedRecreateWnd:boolean Read GetNeedRecreateWnd Write SetNeedRecreateWnd default True;
//    property UndoLimit : integer read GetUndoLimit write SetUndoLimit default 32;
    property CodeDesigner : TCodeDesigner read GetCodeDesigner write SetCodeDesigner;
    property Scripter : TDCSimpleScripter read GetScripter write SetScripter;
    property StartHotKey: TShortCut read FStartHotKey write FStartHotKey;
    property StopHotKey: TShortCut read FStopHotKey write FStopHotKey;
    property ShowPalette : boolean read FShowPalette write FShowPalette default True;
    property ShowSelf : boolean read fShowSelf write fShowSelf default False;
    property ShowAlignPalette : boolean read FShowAlignPalette write FShowAlignPalette;
    property ToolsOnTop : boolean read fToolsOnTop write SetToolsOnTop default False;
    property UseDefaultMenu : boolean read GetUseDefaultMenu write SetUseDefaultMenu default True;
    property IsStored : boolean read fIsStored write fIsStored;
    property UseAncestor : boolean read GetUseAncestor write SetUseAncestor default True;
    property GridColor : TColor read GetGridColor write SetGridColor default clBlack;
    property UseGlobalOptions : boolean read GetUseGlobalOptions write SetUseGlobalOptions default true;

    property ChangesKey : string read fChangesKey write fChangesKey;
    property StoreChanges : boolean read fStoreChanges write fStoreChanges default False;

    property OnAction : TActionEvent read FOnAction write FOnAction;
    property OnActiveChanged : TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnActiveChanging : TActiveChangingEvent read fOnActiveChanging write fOnActiveChanging;
    property OnAfterInsertComponent : TCNotifyProc read fOnAfterInsertComponent write fOnAfterInsertComponent;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property OnCloseForm : TNotifyEvent read FOnCloseForm write FOnCloseForm;
    property OnDeleteComponent : TCNotifyProc read FOnDeleteComponent write FOnDeleteComponent;
    property OnDragDrop : TDCDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnDragOver : TDCDragOverEvent read FOnDragOver write FOnDragOver;
    property OnGetComponentGlyph : TGetComponentGlyphProc read FOnGetComponentGlyph write FOnGetComponentGlyph;
    property OnInsertComponent : TCNotifyProc read FOnInsertComponent write FOnInsertComponent;
    property OnKeyDown : TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnAllowPopup : TAllowPopupEvent read fOnAllowPopup write fOnAllowPopup;
    property OnGetCompNames : TGetCompNamesEvent Read FOnGetCompNames Write FOnGetCompNames;
    property OnSelectionChanged : TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
    property OnEditProperty : TEditPropertyProc read fOnEditProperty write fOnEditProperty;
    property OnShowProperty : TShowPropertyProc read fOnShowProperty write fOnShowProperty;
    property OnSaveChanges : TProcessChangesProc read fOnSaveChanges write fOnSaveChanges;
    property OnLoadChanges : TProcessChangesProc read fOnLoadChanges write fOnLoadChanges;
    property OnStoreProp : TStorePropertyProc read fOnStoreProp write fOnStoreProp;
    property OnProcessMenuItem : TProcessMenuItemProc read fOnProcessMenuItem write fOnProcessMenuItem;
    property OnSizeChanged : TSizeChangedEvent read fOnSizeChanged write fOnSizeChanged;
    property OnGetButtonHint : TOnGetHintEvent read GetOnGetButtonHint write SetOnGetButtonHint;
    property OnGetEventsList : TGetEventsListEvent read fOnGetEventsList write fOnGetEventsList;
    property OnGetAncestor: TGetAncestorEvent read FOnGetAncestor write FOnGetAncestor;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TDCLiteDesigner = Class(TCustomLiteDesigner)
    property AllowedActions;
    property AllowUndo;
    property DesignedComponent;
    property HiddenProps;
    property ReadOnly;
    property ReadOnlyProps;
    property Options;
    property GridStepX;
    property GridStepY;
    property LockControls;
    property LimitControl;
    property LimitInfos;
    property PopupMenu;
    property ShowInspector;
    property ShowComponents;
    property ShowGrid;
    property ShowCaptions;
    property SnapToGrid;
    property NameIsReadOnly;
    property NeedRecreateWnd;
    property PaletteOptions;
    property InspectorOptions;
    property CodeDesigner;
    property Scripter;
    property StartHotKey;
    property ShowHints;
    property StopHotKey;
    property ShowPalette;
    property ShowSelf;
    property ShowAlignPalette;
    property UseDefaultMenu;
    property IsStored;
    property UseAncestor;
    property GridColor;
    property UseGlobalOptions;

    property ChangesKey;
    property StoreChanges;
    property ToolsOnTop;
    property CaptionGlyph;
    property UseCaptionButton;

    property OnAction;
    property OnActiveChanged;
    property OnActiveChanging;
    property OnAfterInsertComponent;
    property OnChange;
    property OnCloseForm;
    property OnDeleteComponent;
    property OnDragDrop;
    property OnDragOver;
    property OnGetComponentGlyph;
    property OnInsertComponent;
    property OnKeyDown;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnGetCompNames;
    property OnSelectionChanged;
    property OnEditProperty;
    property OnShowProperty;
    property OnSaveChanges;
    property OnLoadChanges;
    property OnStoreProp;
    property OnSizeChanged;
    property OnGetButtonHint;
    property OnAllowPopup;
    property OnProcessMenuItem;
    property OnGetEventsList;
    property OnGetAncestor;
  end;

  TDCLiteDesignerOptions = class(TOptionExt)
  private
    fStartHotKey : TShortCut;
    fStopHotKey  : TShortCut;

    procedure SetStartHotKey(val : TShortCut);
    procedure SetStopHotKey(val : TShortCut);
  protected
    procedure Update; override;
  public
    function  GetKey : string; override;
    procedure InitValues; override;
  published
    property StartHotKey : TShortCut read fStartHotKey write SetStartHotKey;
    property StopHotKey : TShortCut read fStartHotKey write SetStopHotKey;
  end;

function GlobalDreamDesignerOptions : TDCLiteDesignerOptions;

type
  TGetActiveDesignerProc = function : IDCformDesigner;
var
  GetActiveDesignerProc : TGetActiveDesignerProc = nil;

function ParametersListMatchTypeData(Parameters : array of string; TypeData : PTypeData) : boolean;

var
  SaveDesignedFormsAsText : boolean = True;
implementation

{$R *.DCR}

constructor TUndoInfo.Create;
begin
  inherited;
end;

{------------------------------------------------------------------}

destructor  TUndoInfo.Destroy;
begin
  fCompContent.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TUndoInfo.CompContent : TStream;
begin
  if fCompContent = nil then
    fCompContent := TMemoryStream.Create;

  result := fCompContent;
end;

{******************************************************************}

function GetRealParentForm(c : TControl) : TCustomForm;
begin
  while not ((c = nil) or (c is TCustomForm)) do
    c := c.Parent;

  result := TCustomForm(c);   
end;

{------------------------------------------------------------------}

function TLimitInfos.GetItem(index : integer) : TLimitInfoItem;
begin
  result := TLimitInfoItem(inherited Items[index]);
end;

{******************************************************************}

{$IFDEF D3}

var
  fChangesStoreList : TList;

function ChangesStoreList : TList; forward;

{------------------------------------------------------------------}

function _AppTerminate : boolean;
var
  i : integer;
begin
  try
    with ChangesStoreList do
      for i := 0 to Count - 1 do
        begin
          TDCChangesStore(Items[i])._AppTerminate;
        end;
  except
  end;

  result := true;
end;

{------------------------------------------------------------------}

function ChangesStoreList : TList;
begin
  if fChangesStoreList = nil then
    begin
      fChangesStoreList := TList.Create;
      AddTerminateProc(_AppTerminate);
    end;

  result := fChangesStoreList;
end;

{------------------------------------------------------------------}
{$ENDIF}
type
  PCWPStruct = ^TCWPStruct;

type
  TDCLiteDesignerList = class(TList)
  private
    function GetDesigner (index : integer) : TCustomLiteDesigner;
  public
    property Designers[index : Integer]: TCustomLiteDesigner read GetDesigner; default;
  end;


type
  TAssignedEventInfo = class
    Instance : TComponent;
    Code     : pointer;
    Event    : string;
  end;

{******************************************************************}

type
  TDataModuleNotifier = class(TCustomDataModuleNotifier)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    wrapper : TDataModuleWrapper;
    destructor Destroy; override;
  end;

{------------------------------------------------------------------}

destructor TDataModuleNotifier.Destroy;
begin
  wrapper.fNotifier := nil;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDataModuleNotifier.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (wrapper <> nil) then
    with wrapper do
      begin
        if Operation = opRemove then
          begin
            fSkipComp := AComponent;
            UpdateScrollBars;
          end;

        if (Designer <> nil) then
          Designer.Notification(AComponent, Operation);
      end;
end;

{******************************************************************}


type
  TMWinControl = class(TWinControl);

{******************************************************************}

procedure DesignerAlignControls; forward;
procedure DesignerSizeControls;  forward;

{$IFDEF DCEDIT}
procedure DesignerScaleControls; forward;
{$ENDIF}

{$IFDEF DREAMTREE}
procedure DesignerChangeCreationOrder; forward;
procedure DesignerChangeTabOrder; forward;
{$ENDIF}

{******************************************************************}

function IsPosChangedMessage(const Msg : TMessage) : boolean;
begin
  with Msg do
    IsPosChangedMessage := (Msg = WM_SIZE) or (Msg = WM_MOVE) or (Msg = WM_WINDOWPOSCHANGED);
end;

{------------------------------------------------------------------}

function IsPosChangeMessage (const Msg : TMessage; Sender : TControl) : boolean;
begin
  result := ((Sender = nil) or (Sender.ComponentState * [csReading, csDestroying] = [])) and
            (Msg.Msg = WM_SIZING) or (Msg.Msg = WM_MOVING);
end;

{------------------------------------------------------------------}

{$IFNDEF D3}
procedure InterfaceConnect(Source: IUnknown; const IID: TIID;
  Sink: IUnknown; var Connection: integer); forward;
procedure InterfaceDisconnect(Source: IUnknown; const IID: TIID;
  var Connection: integer); forward;
{$ELSE}
procedure InterfaceDisconnect(const Source: IUnknown; const IID: TIID;
  var Connection: integer);forward;
procedure InterfaceConnect(const Source: IUnknown; const IID: TIID;
  const Sink: IUnknown; var Connection: integer);forward;
{$endif}

{******************************************************************}

function GetCLeft(c : TComponent) : integer;
begin
  result := LongRec(c.DesignInfo).Lo;
end;

{------------------------------------------------------------------}

function GetCTop(c : TComponent) : integer;
begin
  result := LongRec(c.DesignInfo).Hi;
end;

{------------------------------------------------------------------}

constructor TDataModuleWrapper.Create(AOwner : TComponent);
begin
{$IFDEF VER93}
  CreateNew(nil, 0);
{$ELSE}
  CreateNew(nil);
{$ENDIF}
  Color := clWindow;
  visible := false;
  AutoScroll := false;
  RegisterNotifier(self);
end;

{------------------------------------------------------------------}

destructor TDataModuleWrapper.Destroy;
begin
  DataModule := nil;
  UnRegisterNotifier(self);
  fNotifier.Free;
  RemoveDataModuleWrapper(fDataModule);
  
{
  if fDataModule <> nil then
    RemoveComponent(fDataModule);
}

  inherited;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) then
    if (AComponent = fDataModule) then
      begin
        fNotifier := nil;
        DataModule := nil;
      end;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.CreateNotifier;
begin
  fNotifier := TDataModuleNotifier.Create(DataModule);
  TDataModuleNotifier(fNotifier).Wrapper := self;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.UpdateScrollbars;
var
  maxx : integer;
  maxy : integer;
  i    : integer;
  c    : TComponent;
begin
  if DataModule = nil then
    exit;
    
  maxx := 0;
  maxy := 0;

  with DataModule do
    for i := 0 to ComponentCount - 1 do
      begin
        c := Components[i];
        if c <> fSkipComp then
          begin
            maxx := max(maxx, GetCLeft(c));
            maxy := max(maxy, GetCTop(c));
          end;
      end;

  HorzScrollBar.Range := maxx + ContainerSize;
  VertScrollBar.Range := maxy + ContainerSize;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.CMPROPCHANGED(var M:TMessage);
begin
  if fDataModule = nil then
    exit;

  with TList(M.wParam) do
    if (Count = 1) and (Items[0] = fDataModule) then
      Caption := fDataModule.Name;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.SetDataModule(val : TDataModule);
var
  oldval : TDataModule;
begin
  if val <> fDataModule then
    begin
      RemoveDataModuleWrapper(fDataModule);
      oldval := fDataModule;

      fDataModule := val;
      FreeObject(fNotifier,fNotifier);
      if oldval  <> nil then
        RemoveComponent(oldval);

      if val <> nil then
        begin
          CreateNotifier;
          AddDataModuleWrapper(fDataModule, self);
          fDataModule.FreeNotification(self);
          if fDataModule.Owner <> nil then
            fDataModule.Owner.RemoveComponent(fDataModule);
          InsertComponent(fDataModule);
        end;
    end;

  if fDataModule <> nil then
    with fDataModule do
      begin
        Caption := Name;
        SetBounds(LongRec(DesignInfo).Lo, LongRec(DesignInfo).Hi, DesignSize.X, DesignSize.Y);
      end;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.SetDataModulePosition;
var
  l : integer;
begin
  if fDataModule <> nil then
    with fDataModule do
      begin
        LongRec(l).Lo := left;
        LongRec(l).Hi := top;
        DesignInfo := l;
        DesignSize := Point(Width, Height);
      end;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.WMMove(var Message: TWMMove);
begin
  inherited;
  SetDataModulePosition;
end;

{------------------------------------------------------------------}

procedure TDataModuleWrapper.WMSize (var Msg : TWMSize);
begin
  inherited;
  SetDataModulePosition;
end;

{******************************************************************}

procedure TDesignerOptions.InitValues;
begin
  fShowGrid := true;
  fSnapToGrid := true;
  fShowCaptions := true;
  fGridStepX := 8;
  fGridStepY := 8;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetShowGrid(Value:Boolean);
begin
  If FShowGrid<>Value then
  begin
    FShowGrid:=Value;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetSnapToGrid(V:Boolean);
begin
  If FSnapToGrid<>V then
  begin
    FSnapToGrid:=V;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetShowCaptions(Value:Boolean);
begin
  If FShowCaptions<>Value then
  begin
    FShowCaptions:=Value;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetGridStepX(Value:TGridStep);
begin
  If FGridStepX<>Value then
  begin
    FGridStepX:=Value;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetGridStepY(Value:TGridStep);
begin
  If FGridStepY<>Value then
  begin
    FGridStepY:=Value;
    Update;
  end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.SetShowHints(val : boolean);
begin
  if val <> fShowHints then
    begin
      fShowHints := val;
      Update;
    end;
end;

{------------------------------------------------------------------}

procedure TDesignerOptions.Update;
var
  i : integer;
  D : TFDesigner;
begin
  if UpdateDisabled then
    exit;

  with DesignerList do
    for i := 0 to Count - 1 do
      begin
        D := Designers[i];
        if D is TDCFormDesigner then
          with TDCFormDesigner(D) do
            if UseGlobalOptions then
              LoadGlobalOptions;
      end;
end;

{------------------------------------------------------------------}

function TDesignerOptions.GetKey : string;
begin
  result := 'Designer\'; //don't resource
end;

{------------------------------------------------------------------}

procedure DrawClippedSelection (Rect, ClipRect : TRect);forward;
function GetClippingRectangle(c : TControl) : TRect; forward;

{******************************************************************}

var
  fDCFormDesigners : TList;

function DCFormDesigners : TList;
begin
  if fDCFormDesigners = nil then
    fDCFormDesigners := TList.Create;

  Result := fDCFormDesigners;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Activate;
begin
  if Form <> nil then
    Form.BringToFront;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.DeleteEmptyEvents:boolean;

  function DeleteNotPresent(const EventName : string) : integer;
  begin
    result := MessageDlg(Format(SErrMethodReferenced, [EventName]),
                         mtError, [mbYes, mbNo, mbCancel], 0);
  end;

var
  i:Integer;
  AModified:boolean;
begin
  result := true;
  AModified := false;

  If not Assigned(FCodeDesigner) then
    exit;

  FCodeDesigner.Strings.BeginUpdate;
  try
    With FCodeDesigner, FCompFiler.EventNames do
      for i := Count - 1 downto 0 do
        case GetMethodState(Strings[i]) of
          msEmpty :
            begin
              DeleteMethod(Strings[i]);
              Delete(i);
              AModified := true;
            end;
          msNotPresent:
            case DeleteNotPresent(Strings[i]) of
              mrYes :
                begin
                  Delete(i);
                  AModified := true;
                end;
              mrCancel :
                begin
                  Result := false;
                  exit;
                end;
            end;
        end;
  finally
    FCodeDesigner.Strings.EndUpdate;
    if AModified then
      Modified;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowMethod(const AName: string);
begin
  If Assigned(FCodeDesigner) then
    FCodeDesigner.ShowMethod(AName);
end;

{-------------------------------------------------------------------------}

procedure TDCFormDesigner.RenameEvent(Instance : TPersistent; PropInfo : PPropInfo; UserData : integer);
begin
  if CompareText(GetMethodName(GetMethodProp(Instance, PropInfo)), _OldMethodName) = 0 then
    SetMethodProp(Instance, PropInfo, _NewMethodValue);
end;

{-------------------------------------------------------------------------}

procedure TDCFormDesigner.RenameEvents(Comp : TComponent);
var
  i : integer;
begin
  IterateProps(Comp, tkMethods, RenameEvent, false, 0);
  with Comp do
    for i := 0 to ComponentCount - 1 do
      RenameEvents(Components[i]);
end;

{-------------------------------------------------------------------------}

procedure TDCFormDesigner.RenameMethod(const CurName, NewName: string);
Var
  i:Integer;
  FCurName,FNewName:String;
begin
  FCurName:=Trim(CurName);
  FNewName:=Trim(NewName);
  If CompareText(FCurName,FNewName)=0 then
    exit;

  inherited;

  WIth FCompFiler.EventNames do
    for i:=0 to Count-1 do
      If CompareText(Strings[i],FCurName)=0 then
        begin
          Strings[i]:=FNewName;
          break;
        end;

  If Assigned(FCodeDesigner) then
    FCodeDesigner.RenameMethod(FCurName, FNewName)
  else
    begin
      _NewMethodValue := GetMethodByName(fNewName);
      _OldMethodName  := CurName;
      RenameEvents(OwnerControl);
    end;

  if Assigned(Scripter) then
    Scripter.RenameEvent(fCurName, fNewName);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.AnswerMessage:boolean;
begin
  Result:=(Active and FormIsActive(Form));
end;

{------------------------------------------------------------------}

function IsParent(AChild, AParent : TComponent) : boolean;
var
  c : TControl;
begin
  result := true;

  if AChild is TControl then
    begin
      c := TControl(AChild);
      while (c <> nil) do
        if c = AParent then
          exit
        else
          c := c.Parent;

      result := false;
    end;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetTabOrderControl:TWInControl;
var
  c : TComponent;
  i : integer;
  AllHaveOneParent : boolean;
begin
  i := 0;
  c := nil;

  while not ((i = SelectedComponents.Count) or (c is TControl)) do
    begin
      c := SelectedComponents[i];
      inc(i);
    end;

  if not (c is TControl)  then
    c := Form;

  repeat
    while (c <> nil) and (c <> form) and not (csAcceptsControls in TCOntrol(c).ControlStyle) do
      c := TControl(c).Parent;

    AllHaveOneParent := true;
    if c = nil then
      begin
        result := form;
        break;
      end
    else
      result := TWInControl(c);

    for i := 1 to SelectedComponents.Count - 1 do
      if not IsParent(TComponent(SelectedComponents[i]), result) then
        begin
          AllHaveOneParent := false;
          break;
        end;

    c := TControl(c).Parent;
  until AllHaveOneParent;

  if (result = form) and (LimitControl <> nil) then
    result := LimitControl;
end;

{------------------------------------------------------------------}

type
  TRectClass = class
  public
    rect : TRect;
    comp : TComponent;
  end;

procedure RoundToNearest (var value : integer; step : integer );
begin
  value := round(value / step) * step;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.BeginUpdate;
begin
  If fUpdateCount = 0 then
    begin
      CopyList(fSelectedComponents, fOldSelected);
      CopyList(inherited Selection, fSelections);
      CopyList(fSelections, fOldSelections);
      fSelectChanged := false;
    end;
  inc(fUpdateCount);
  inc(fOpCount);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.EndUpdate;
var
  clist : TComponentList;
begin
  if fUpdateCount > 0 then
    begin
      dec(fUpdateCount);
      if (fUpdateCount = 0) and fActive then
        begin
          if not EqualList(fSelectedComponents, fOldSelected) and Assigned(fOnSelectionChanged) then
            fOnSelectionChanged(self);

          if fSelectChanged then
            begin
              clist := TComponentList.Create;
              try
                ListToCompList(fSelections, clist);
                inherited SetSelections(clist);
              finally
                clist.Free;
              end;
            end;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetReadOnly(val : boolean);
begin
  if val then
    FOptions:=FOptions-[fdAllowDelete,fdAllowInsert]
  else
    FOptions:=FOptions+[fdAllowDelete,fdAllowInsert];
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetReadOnly:Boolean;
begin
  Result:=[fdAllowDelete,fdAllowInsert]*FOptions=[];
end;

{------------------------------------------------------------------}

{$IFDEF D4}
procedure TDCFormDesigner.Notification(AnObject: TPersistent; Operation: TOperation);
{$ELSE}
procedure TDCFormDesigner.Notification(AComponent: TComponent; Operation: TOperation);
{$ENDIF}

  procedure iDeleteComponent(AComponent: TComponent);
  begin
    DeselectComponent(AComponent);
    DestroyContainer(GetContainer(AComponent));
    if fDeletionList <> nil then
      fDeletionList.Remove(AComponent);
{    if Assigned(CodeDesigner) then
      CodeDesigner.DeleteComponent(AComponent);}
  end;

  procedure iInsertComponent(AComponent: TComponent);
  begin
    if not (fSkipNotification or (AComponent is TControl)) then
      CreateContainer(AComponent, -1, -1);
  end;

{$IFDEF D4}
var
  AComponent : TComponent;
{$ENDIF}

begin
  inherited;
{$IFDEF D4}
  if not (AnObject is TComponent) then
    exit
  else
    AComponent := TComponent(AnObject);
{$ENDIF}

  if (not FActive) or (AComponent = nil) then
    exit;

  case Operation of
    opInsert: if Assigned(fOnInsertComponent) then
                fOnInsertComponent(self, AComponent);

    opRemove: if Assigned(fOnDeleteComponent) then
                fOnDeleteComponent(self, AComponent);
  end;

  if GetTopOwner(AComponent) <> OwnerControl then
    exit;

  case Operation of
    opInsert: iInsertComponent(AComponent);
    opRemove: iDeleteComponent(AComponent);
  end;

  if not fLock then
    Modified;
end;

{------------------------------------------------------------------}

function GetCompModule(Instance : TComponent) : TComponent;
begin
  if ((Instance is TCustomForm) or (Instance is TDataModule)) then
    result := Instance
  else
    result := GetTopOwner(Instance);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddUsedModule(Module : TComponent);
begin
  Module := GetCompModule(Module);

  if fUsedModules.IndexOf(Module) < 0 then
    fUsedModules.Add(Module);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.RemoveUsedModule(Module : TComponent);
begin
  fUsedModules.Remove(GetTopOwner(Module));
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.AllowPropShow(Instance : TComponent; const PropName : string) : boolean;
var
  li : TLimitInfoItem;
begin
  result := HiddenProps.IndexOf(PropName) < 0;
  if result then
    begin
      li := GetLimitInfo(Instance);
      result := (li = nil) or (li.HiddenProps.IndexOf(PropName) < 0);
    end;
    
  if Assigned(fOnShowProperty) then
    fOnShowProperty(self, Instance, PropName, result);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.AllowEdit(Instance : TComponent; const PropName : string) : boolean;
begin
  result := not (NameIsReadOnly and (CompareText(PropName, 'Name') = 0) and (TPersistent(Instance) is TComponent)) and  //don't resource
           not (Instance = LimitControl) and
           ActionAllowed(Instance, atEdit) and
           EditPropAllowed(Instance, PropName);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.CanBeSelected(Instance : TPersistent) : boolean;
begin
  result := (Instance is TComponent) and
            (ShowComponents or (Instance is TControl)) and
            (SelectedComponents.IndexOf(Instance) < 0) and
            (TComponent(Instance).Owner = OwnerControl) and
            (Instance <> LimitControl) and
            InLimit(Instance) and
            (((Instance is TControl) and ActionsAllowed(Instance, [atSelect]))
             or ActionsAllowed(Instance, [atSelect, atShow])) and
            IsIconClass(TComponentClass(Instance.ClassType)) and
            not (Instance is TDataModuleNotifier);
end;

{------------------------------------------------------------------}

{$IFDEF D3}
procedure TDCFormDesigner.SelectComponent(Instance: TPersistent);
{$ELSE}
procedure TDCFormDesigner.SelectComponent(Instance: TComponent);
{$ENDIF}
begin  // don't need to call inherited here as in EndUpdate inherited SetSelections is called
  BeginUpdate;
  try
    ClearSelectedComponents;

    if Instance is TControl then
      TControl(Instance).Show;

    AddSelectedComponent(TComponent(Instance));
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}
{$IFNDEF D4}
procedure TDCFormDesigner.SetSelections(List: TComponentList);
var
  L : TList;
begin
  L := TList.Create;
  try
    CompListToList(list, l);
    SetSelectedComponents(L);
  finally
    L.Free;
  end;
end;
{$ELSE}
procedure TDCFormDesigner.SetSelections(const List: IDesignerSelections);
var
  L : TList;
begin
  L := TList.Create;
  try
    IDesignerSelectionsToList(list, l);
    SetSelectedComponents(L);
  finally
    L.Free;
  end;
end;
{$ENDIF D4}

{******************************************************************}

constructor TDCFormDesigner.Create;
begin
  inherited Create;
  CheckTrialVersion;

  fAllowedActions := AllActionsAllowed;
  fReadOnlyProps := TStringList.Create;
  fHiddenProps := TStringList.Create;
  fUsedModules := TList.Create;

  FCompFiler:=TCompFiler.Create;
  fCompFiler.OnAfterLoad := CompLoaded;
  fmenu := TPopupMenu.Create(nil);

  fMenuHolder := TComponent.Create(nil);
  fDefaultPopup := TPopupMenu.Create(fMenuHolder);

  fLimitInfos := TLimitInfos.Create(Application, TLimitInfoItem);
  fSelections := TList.Create;
  fOldSelections := TList.Create;

  fSelectedComponents := TList.Create;
  fOldSelected := TList.Create;
  fSelRects := TList.Create;
  fContainers := TList.Create;

  fSelecting := false;
  fShowHandles := false;
  fMultipleSelect := false;

  fShowGrid := true;
  fShowComponents := true;
  firsthandles := true;
  FShowInspector := true;
  fUseAncestor := true;
  fHideOnClose := true;

  fGridStepX := 8;
  fGridStepY := 8;
  fUndoLimit := 32;
  fUndoList := TList.Create;
  fRedoList := TList.Create;
  FOptions:=[fdAllowDelete,fdAllowInsert];
  RegisterNotifier(Self);
  DCFormDesigners.Add(self);
end;

{------------------------------------------------------------------}

destructor TDCFormDesigner.Destroy;
var
  i : integer;
begin
  if fDCFormDesigners <> nil then
    fDCFormDesigners.Remove(self);
    
  UnRegisterNotifier(Self);
  SetActive(false);

  fHint.Free;
  FCompFiler.Free;
  fSelectedComponents.Free;
  fOldSelected.Free;
  FreeList(fSelRects,fSelRects);
  fselections.Free;
  fOldSelections.Free;
  FreeHandles;
  fLimitInfos.Free;
  fMenuHolder.Free;
  fMenu.Free;
  fReadOnlyProps.Free;
  fHiddenProps.Free;
  fUsedModules.Free;

  for i := 0 to fContainers.Count - 1 do
    TComponentContainer(fContainers[i]).Free;

  fContainers.Free;

  {$IFNDEF D6}
  fcedit.Free;
  {$ENDIF}

  FreeList(fUndoList,fUndoList);
  FreeList(fRedoList,fRedoList);

  SimpleBroadCast(CM_SELECTIONCHANGED);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClearUndo;
begin
  ClearList(fUndoList);
  ClearList(fRedoList);
end;                   

{------------------------------------------------------------------}

procedure TDCFormDesigner.CompLoaded(Sender : TObject);
begin
  ClearUndo;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetHint;
begin
  if fHint = nil then
    begin
      fHint := TDCHint.Create(nil);
      fHint.AutoHide := false;
    end;

  result := fHint;  
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CreateHandles;
begin
  fControlHandles := TControlHandles.Create(nil);
  fControlHandles.fDesigner := self;
  fControlHandles.OnValidateRect := ValidateHandlesRect;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FreeHandles;
begin
  FreeObject(fControlHandles,fControlHandles);
end;

{------------------------------------------------------------------}

type
  TMenuItemInfo = record
    Caption : string;
    Handler : pointer;
    InDataModule : boolean;
  end;

const
{$IFDEF DCEDIT}
{$IFDEF DREAMTREE}
  DefaultMenuItemsCount = 9;
{$ELSE}
  DefaultMenuItemsCount = 7;
{$ENDIF}
{$ELSE}
{$IFDEF DREAMTREE}
  DefaultMenuItemsCount = 8;
{$ELSE}
  DefaultMenuItemsCount = 6;
{$ENDIF}
{$ENDIF}

  DefaultMenuItems : array[1 .. DefaultMenuItemsCount] of TMenuItemInfo =
  (
    (Caption : SAligntoGrid     ; Handler : @TDCFormDesigner.AlignToGridClick  ; InDataModule : true),
    (Caption : SBringToFront    ; Handler : @TDCFormDesigner.BringToFrontClick ; InDataModule : false),
    (Caption : SSendToBack      ; Handler : @TDCFormDesigner.SendToBackClick   ; InDataModule : false),
    (Caption : '-'              ; Handler : nil                                ; InDataModule : false),
    (Caption : SDesAlign        ; Handler : @TDCFormDesigner.AlignClick        ; InDataModule : true),
    (Caption : SDesSize         ; Handler : @TDCFormDesigner.SizeClick         ; InDataModule : false)
{$IFDEF DCEDIT}
    ,(Caption : SDesScale        ; Handler : @TDCFormDesigner.ScaleClick        ; InDataModule : false)
{$ENDIF}
{$IFDEF DREAMTREE}
    ,(Caption : SDesTabOrder     ; Handler : @TDCFormDesigner.TabOrderClick     ; InDataModule : false)
    ,(Caption : SDesCreationOrder; Handler : @TDCFormDesigner.CreationOrderClick; InDataModule : true)
{$ENDIF}
  );


procedure TDCFormDesigner.AlignToGridClick(Sender : TObject);
begin
  AlignToGrid;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.BringToFrontClick(Sender : TObject);
begin
  BringToFront;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SendToBackClick(Sender : TObject);
begin
  SendToBack;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AlignClick(Sender : TObject);
begin
  DesignerAlignControls;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SizeClick(Sender : TObject);
begin
  DesignerSizeControls;
end;

{------------------------------------------------------------------}

{$IFDEF DCEDIT}
procedure TDCFormDesigner.ScaleClick(Sender : TObject);
begin
  DesignerScaleControls;
end;
{$ENDIF}
{------------------------------------------------------------------}

{$IFDEF DREAMTREE}
procedure TDCFormDesigner.TabOrderClick(Sender : TObject);
begin
  DesignerChangeTabOrder;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CreationOrderClick(Sender : TObject);
begin
  DesignerChangeCreationOrder;
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TDCFormDesigner.FillDefaultPopup(IsForm : boolean);
var
  i : integer;
  m : TMethod;
  item : TMenuItem;
begin
  m.data := self;
  for i := 1 to DefaultMenuItemsCount do
    with DefaultMenuItems[i] do
      begin
        m.Code := handler;
        item := NewItem(Caption,0, false, true, TNotifyEvent(m), 0, '');
        item.Visible := IsForm or InDataModule;
        fDefaultPopup.Items.Add(item);
      end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.LoadGlobalOptions;
begin
  with GlobalDesignerOptions do
    begin
      Self.ShowGrid     := ShowGrid;
      Self.SnaptoGrid   := SnaptoGrid;
      Self.ShowCaptions := ShowCaptions;
      Self.GridStepX    := GridSizeX;
      Self.GridStepY    := GridSizeY;
      Self.ShowHints    := ShowHints;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DestroyContainer(container : TComponentContainer);
begin
  if Assigned(container) then
    begin
      fContainers.Remove(container);
      container.hidehandles;
      container.Free;
   end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessNonControls;
var
  i : integer;
begin
  ClearList(fContainers);

  if not ShowComponents then
    exit;

  with OwnerControl do
    for i := 0 to ComponentCount - 1 do
      if not (Components[i] is TControl) then
        CreateContainer(Components[i], -1, -1);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetActive : boolean;
begin
  result := fActive;
end;

{------------------------------------------------------------------}

type
  TDCustomForm = class(TCustomForm)
  end;

procedure RemoveActiveControl(form : TCustomForm);
begin
  form.ActiveControl := nil;
  windows.SetFocus(form.Handle);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetParentControl : TWinControl;
begin
  result := LimitControl;

  if result = nil then
    result := Form;
end;

{------------------------------------------------------------------}


procedure TDCFormDesigner.SetActive (val : boolean);

  function NeedRecreate : boolean;
  begin
    result := NeedRecreateWnd and not (Form is TDataModuleWrapper);
  end;
var
  savevisible : boolean;
begin
  if (val = fActive) or (Form = nil) then
    exit;

  BeginUpdate;
  try
    fActive := val;

    ClearUndo;

    if val then
      begin
        CreateHandles;
        form.Designer := {$IFDEF D6}Self{$ELSE}TFormDesigner(self){$ENDIF};
        RemoveActiveControl(form);

        if Assigned(Scripter) then
          Scripter.BeginDesign;

        SetDesign(form, true);

        if NeedRecreate then
          begin
            TDCustomForm(Form).RecreateWnd;
            ShowFormEx(Form, SW_RESTORE);
          end
        else
          UpdateDisabledControls(Form);

        ProcessNonControls;

        if fShowInspector then
          ShowObjectInspector;

        SelectComponent(GetParentControl);
      end
    else
      begin
        If FShowInspector then
          HideObjectInspector;

        ClearSelectedComponents;
        Selection.Clear;

        while fContainers.Count > 0 do
          DestroyContainer(fContainers[0]);

        SetDesign(form, false);
        if Assigned(Scripter) then
          Scripter.EndDesign;

        FreeHandles;

        if not (csDestroying in Form.ComponentState) then
          if NeedRecreate then
            begin
              savevisible := TDCustomForm(Form).Visible;
              TDCustomForm(Form).Visible := true;
              TDCustomForm(Form).RecreateWnd;
              TDCustomForm(Form).Visible := savevisible;
            end
          else
            UpdateDisabledControls(Form);

        if (form <> nil) and
            {$IFDEF D6}
            (form.Designer = self as IDesignerHook)
            {$ELSE}
            (form.Designer = TFormDesigner(self))
            {$ENDIF}
        then
          form.Designer := nil;
     end;

    if Assigned(FOnActiveChanged) then
      FOnActiveChanged(Self);

  finally
    EndUpdate;

    if not (csDestroying in form.ComponentState) then
      form.Invalidate;

    if not fActive then
      FreeObject(fcEdit,fcEdit);
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetShowCaptions(val : boolean);
var
  i : integer;
begin
  if val = fShowCaptions then
    exit;

  fShowCaptions := val;
  for i := 0 to fContainers.Count - 1 do
    TComponentContainer(fContainers[i]).ShowCaption := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetSelectedComponents : TList;
begin
  result := fSelectedComponents;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetSelectedComponents (val : TList);
var
   i : integer;
begin
  BeginUpdate;
  try
    ClearSelectedComponents;
    for i := 0 to val.Count - 1 do
      AddSelectedComponent(val[i]);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetContainer(comp : TComponent) : TComponentContainer;
var
  i : integer;
begin
  for i := 0 to fContainers.Count - 1 do
    if TComponentContainer(fContainers[i]).contained = comp then
      begin
        result := TComponentContainer(fContainers[i]);
        exit;
      end;

  result := nil;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DrawControlHandles (Component : TComponent; Visible : Boolean);
var
  DrawControl : TWinControl;
  DrawRect    : TRect;
  Width       : Integer;
  Height      : Integer;
  DC          : THandle;
  Control     : TControl;
  container   : TComponentContainer;

  procedure DrawHandle (X, Y : Integer);
  var
    Rect : tRect;
  begin
    if Visible
      then PatBlt (DC, DrawRect.Left + X, DrawRect.Top + Y,
                    HandleSize, HandleSize, PATCOPY)
    else
      begin
        Rect := Bounds (DrawRect.Left + X, DrawRect.Top + Y, HandleSize, HandleSize);
        InValidateRect (DrawControl.Handle, @Rect, True);
      end;
  end;

begin
  if not (Component is TControl) then
    begin
      container := GetContainer(Component);
      if Assigned(Container) then
        Container.DrawHandles(visible);

      exit;
    end;

  control := TControl(Component);
  if not Control.Visible then
    exit;

  if Control is TWinControl then
    begin
      DrawControl := TWinControl(Control);

      if not DrawControl.HandleAllocated then
        exit;

      DrawRect    := DrawControl.ClientRect;
    end
  else
    begin
      DrawControl := Control.Parent;
      DrawRect    := Control.ClientRect;
      OffsetRect (DrawRect, Control.Left, Control.Top);
    end;

  DrawControl.Update;
  Width  := DrawRect.Right - DrawRect.Left;
  Height := DrawRect.Bottom - DrawRect.Top;

  if Visible then
    begin
      DC := GetDC (DrawControl.Handle);
      SelectObject (DC, GetStockObject(GRAY_BRUSH));
    end;

  DrawHandle(0, 0);
  DrawHandle((Width - HandleSize) div 2, 0);
  DrawHandle( Width - HandleSize, 0);

  DrawHandle (0, (Height - HandleSize) div 2);
  DrawHandle (Width - HandleSize, (Height - HandleSize) div 2);

  DrawHandle (0, Height - HandleSize);
  DrawHandle ((Width - HandleSize) div 2, Height - HandleSize);
  DrawHandle (Width - HandleSize, Height - HandleSize);

  if visible then
    ReleaseDC (DrawControl.Handle, DC);

  DrawControl.Update;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ParentControlColorChanged;
var
  i : integer;
begin
  for i := 0 to fContainers.Count - 1 do
    TComponentContainer(fContainers[i]).CaptionColor := TMWinControl(form).Color;

  fParentControlColor := form.Color;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CloseForm;
begin
  if fHideOnClose then
    ShowWindow(form.Handle, SW_HIDE);
  if Assigned(fOnCloseForm) then
    fOnCloseForm(self);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DrawComponentHandles;
var
  i : integer;
begin
  if fSelectedComponents.Count > 1 then
    for i := 0 to fSelectedComponents.Count - 1 do
      DrawControlHandles(TComponent(fSelectedComponents[i]), true);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MenuItemSelected(code : integer);
var
  Item : TMenuItem;
  AllowCommand : boolean;
begin
  Item := form.Menu.FindItem(code, fkCommand);

  if (Item <> nil) and ((Item.Parent <> Form.Menu.Items) or (Item.Count = 0)) then
    begin
      AllowCommand := false;
      if Assigned(OnProcessMenuItem) then
        OnProcessMenuItem(self, Item, AllowCommand);

      if AllowCommand then
        begin
          if Assigned(Item.OnClick) then
            Item.OnClick(Item);
        end
      else
        begin
          {$IFNDEF D6}
          fcedit.Free;
          {$ENDIF}
          fcedit := GetComponentEditor(Item, self);
          if (fcedit <> nil) then
            fcedit.Edit;
        end;
    end;
end;

{------------------------------------------------------------------}

type
  T_DragControlObject = class(TDragControlObject)
  end;

function  TDCFormDesigner.IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
var
  key               : word;
  hitmsg            : TCMDesignHitTest;
  ControlWantsMouse : boolean;
  pt                : TPoint;
  shift             : TShiftState;
  processed         : boolean;
  poschanged        : boolean;
  Accepts           : boolean;
  S                 : TObject;

  procedure ProcessMessage;
  begin
    fSkipMessage := true;
    try
      with Message do
        Sender.Perform(Msg, wParam, lParam);
    finally
      fSkipMessage := false;
    end;
  end;

begin
  result := false;

  fSendControl := Sender;

  if not fActive then
    exit;

  if fSkipMessage then
    exit;

  if csDestroying in Sender.ComponentState then
    exit;

  if fInMenuLoop and (Message.Msg = WM_RBUTTONDOWN) then
    ClearSelectedComponents;

  try
    poschanged := IsPosChangedMessage(Message);

    if fSendControl is TControl then
      begin
        if poschanged or IsPosChangeMessage(Message, Sender) then
          begin
            ProcessMessage;
            if not poschanged and (fSendControl = Form) then
              Modified;

            if Assigned(fControlHandles) then
              fControlHandles.ResetPosition;

            if ((Message.Msg = WM_SIZE) or (Message.Msg = WM_WINDOWPOSCHANGED)) and
               Assigned(OnSizeChanged) then
              OnSizeChanged(self, TControl(Sender));
          end;
      end;

    result := true;
    fControl := Sender;

    pt.x := LOWORD(GetMessagePos);
    pt.y := HIWORD(GetMessagePos);

    with Message do
      if (Msg >= WM_MOUSEFIRST) and (Msg <= WM_MOUSELAST) and (fSendControl is TControl) then
        begin
          with hitmsg do
            Pos  := PointToSmallPoint(Sender.ScreenToClient(pt));

          fskipmessage := true;
          try
            ControlWantsMouse := Sender.Perform(CM_DesignHitTest, wParam, longint(hitmsg.pos)) <> 0;
          finally
            fskipmessage := false;
          end;
        end
      else
        ControlWantsMouse := false;

    if fmoving or fselecting or fControlHandles.fSizing then
      ControlWantsMouse := false;

    shift := KeysToShiftState(Message.wParam);

    if Sender = Form then
      begin
        processed := true;

        case Message.Msg of
          WM_COMMAND : with TWMCommand(Message) do
                          if (Form.Menu <> nil) then
                            MenuItemSelected(ItemID);

          WM_KILLFOCUS : CancelMovingSelecting;

          WM_SETFOCUS : begin
                          SelectionChanged;
                          if Assigned(self.OnActivate) then
                            self.OnActivate(self);
                        end;

          WM_ENTERMENULOOP : fInMenuLoop := true;

          WM_EXITMENULOOP  : fInMenuLoop := false;

          WM_PAINT : begin
                       if fShowGrid then
 //                        if fSelecting or fMoving then
 //                          exit
 //                        else
                           begin
                             if form.Color <> fParentControlColor then
                               ParentControlColorChanged;
                           end;

                       ProcessMessage;

                       if Assigned(fControlHandles) then
                         fControlHandles.ResetPosition;

                       if fHandleDraw then
                         DrawComponentHandles;

                       result := true;
                     end;

          WM_LBUTTONUP: MouseUp(mbLeft, [], 0, 0);

          WM_CLOSE : begin
                       CloseForm;
                       Result:=True;
                       exit;
                     end;
          else
            processed := false;
        end;

        if processed then
          exit;
      end;

    case message.msg of
      WM_WINDOWPOSCHANGED : begin
                              if (fSendControl <> form) and
                                 (fSendControl is TControl) and
                                 not (fSendControl is TComponentContainerSpeedButton) then
                                   begin
                                     ProcessMessage;
                                     BringContainersToFront;
                                   end;
                            end;

      WM_SETCURSOR : if (fselecting or fmoving) then
                       begin
                         SetCursor(Screen.Cursors[crDefault]);
                         result := true;
                         exit;
                       end
                     else
                       result := false;

      WM_LBUTTONDBLCLK : MouseDown(mbLeft,  shift + [ssDouble], pt.X, pt.Y);

      WM_LBUTTONDOWN : begin
                         MouseDown(mbLeft, shift , pt.X, pt.Y);
                         if ControlWantsMouse then
                            begin
                              result := false;
                              if fneedhandles then
                                begin
                                  CreateControlHandles(TComponent(SelectedComponents[0]));
                                  fneedhandles := false;
                                end;
                              CancelMovingSelecting;
                            end;
                       end;

      WM_RBUTTONDOWN : MouseDown(mbRight, shift, pt.X, pt.Y);

      WM_LBUTTONUP   : if ControlWantsMouse then
                         result := false
                       else
                         MouseUp  (mbLeft,  shift, pt.X, pt.Y);

      WM_RBUTTONUP   : MouseUp  (mbRight, shift, pt.X, pt.Y);

      WM_MOUSEMOVE   : if ControlWantsMouse then
                         result := false
                       else
                         MouseMove(shift, pt.X, pt.Y);

      WM_KEYDOWN,
      WM_SYSKEYDOWN  :
                       begin
                         if Assigned(fControlHandles) and (Message.wParam = VK_ESCAPE) and fControlHandles.fSizing then
                           begin
                             fControlHandles.FinishSizing;
                             result := true;
                             exit;
                           end;

                         key := word(Message.wParam);
                         KeyDown (key, KeyDataToShiftState(Message.lParam));
                         result := key = 0;
                       end;

      CM_Drag        :
                       begin
                         with TCMDrag(Message), DragRec^ do
                         Begin
                           S := T_DragControlObject(Source).Control;
                           case DragMessage of
                             dmDragEnter, dmDragLeave, dmDragMove, dmDragDrop:
                               if Target <> nil then
                                 with Sender.ScreenToClient(Pos) do
                                   case DragMessage of
                                     dmDragEnter, dmDragLeave, dmDragMove:
                                       begin
                                         Accepts := Assigned(OnDragOver);
                                         if Accepts then
                                           OnDragOver(Self, S, Target,X, Y, TDragState(DragMessage), Accepts);
                                         Result := Ord(Accepts);
                                       end;
                                     dmDragDrop:
                                         if Assigned(OnDragDrop) then
                                           OnDragDrop(Self, S, Target, X, Y);
                                   end;
                             dmFindTarget:
                               begin
                                 If Sender Is TWinControl Then
                                   Result := Longint(TWinControl(Sender).ControlAtPos(Sender.ScreenToClient(Pos), False))
                                 Else
                                   Result := LongInt(Sender);
                                 if Result = 0 then Result := Longint(Sender);
                               end;
                           end;
                         End;
                       end;

    else
      result := false;
    end;
  except
    result := false;
    Application.HandleException(self);
  end;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.FindParent(c : TComponent) : TWinControl;
begin
  result := nil;
  repeat
    if not (c is TControl) then
      result := form
    else if ((c is TWinControl) and (csAcceptsControls in TControl(c).ControlStyle)) or
             (c is TDCOleControl_) then
      result := TWinControl(c)
    else
      c := TControl(c).Parent;
  until result <> nil;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.RemoveFromfSelections(c : TPersistent);
begin
  fSelections.Remove(c);
  fSelectChanged := true;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddTofSelections(c : TPersistent);
begin
  if fSelections.IndexOf(c) < 0 then
    fSelections.Add(c);

  fSelectChanged := true;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MarkSelected;
var
  rect : TRect;
  i    : integer;
  c    : TComponent;
begin
  BeginUpdate;
  try
    FreeControlHandles;
    for i := 0 to fSelParent.ControlCount - 1 do
      with fSelParent.Controls[i] do
        begin
          c := fSelParent.Controls[i];
          if not (csNoDesignVisible in TControl(c).ControlStyle) and ActionAllowed(c, atSelect) then
            begin
              rect.TopLeft := ClientToScreen(Point(0, 0));
              rect.BottomRight := ClientToScreen(Point(ClientWidth, ClientHeight));
              if InterSectRect(rect, rect, fSelRect) and
                (SelectedComponents.IndexOf(c) < 0) then
                begin
                 AddTofSelections(c);
                 SelectedComponents.Add(c);
                end;
            end;
        end;

    if fSelParent = form then
      for i := 0 to fContainers.Count - 1 do
        with TComponentContainer(fContainers[i]) do
          begin
            if not ActionAllowed(Contained, atSelect) then
              continue;

            rect.TopLeft := form.ClientToScreen(Point(Left, Top));
            rect.BottomRight := form.ClientToScreen(Point(Left + ContainerSize, Top + ContainerSize));
            if InterSectRect(rect, rect, fSelRect) then
              begin
                SelectedComponents.Add (Contained);
                AddTofSelections(Contained);
              end;
          end;

    if SelectedComponents.Count = 1 then
      CreateControlHandles(SelectedComponents[0]);

    if fSelections.Count > 1 then
      fSelections.Remove(OwnerControl);
    ShowHandles;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOwnerControl : TComponent;
begin
  result := nil;
  if form is TDataModuleWrapper then
    result := TDataModuleWrapper(form).DataModule;
  if result = nil then
    result := inherited GetOwnerControl;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.GetComponentGlyph(AClass : TClass; ABitmap : TBitmap);
begin
  if Assigned(fOnGetComponentGlyph) then
    fOnGetComponentGlyph(self, AClass, ABitmap)
  else
    LoadBitmapForClass(ABitmap,AClass);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CreateContainer(comp : TComponent; left, top : integer);
var
  container : TComponentContainer;
begin
  if not ShowComponents then
    exit;
    
  if GetContainer(comp) <> nil then
    exit;

  if not IsIconClass(TComponentClass(comp.ClassType)) then
    exit;

  if not ActionAllowed(comp, atShow) then
    exit;

  container := TComponentContainer.Create;
  with container do
    begin
      Parent := form;
      Contained := comp;
      ShowCaption := fShowCaptions;
    end;

  if left >= 0 then
    container.Left := left;

  if top >= 0 then
    container.Top  := top;

  GetComponentGlyph(comp.ClassType, container.Glyph);

  fContainers.Add(container);
end;

{------------------------------------------------------------------}

function UniTypeToString(Designer : TFormDesigner; TypeCode : integer) : string;
{$IFDEF D6}
var
  D:TObject;
begin
  If PSCSupportsInstance(Designer,TDCFormDesigner,D) and
     (TDCFormDesigner(D).CodeDesigner <> nil)
  then
    Result := TDCFormDesigner(D).CodeDesigner.TypeToString(TypeCode)
  else
    Result := DelphiTypeToString(Designer, TypeCode);
end;
{$ELSE}
begin
  if (TDCFormDesigner(Designer).CodeDesigner <> nil) then
    Result := TDCFormDesigner(Designer).CodeDesigner.TypeToString(TypeCode)
  else
    Result := DelphiTypeToString(Designer, TypeCode);
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TDCFormDesigner.ValidateContainer(CompClass : TComponentClass);
begin
  if (OwnerControl is TDataModule) and (CompClass.InheritsFrom(TControl)) then
    raise Exception.Create(SErrControlsInData);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.CreateUndoInfo : TUndoInfo;
begin
  result := TUndoInfo.Create;
  result.UndoLevel := fOpCount;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddUndoInfo(info : TUndoInfo);
begin
  fUndoList.Add(info);
  if not fInUndo then
    fRedoList.Clear;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddUndoNewComp(comp : TComponent);
var
  uinfo : TUndoInfo;
begin
  if (comp = nil) or (comp.Name = '') then
    exit;

  uinfo := CreateUndoInfo;
  uinfo.Operation := dopInsert;
  uinfo.Name := comp.Name;

  AddUndoInfo(uinfo);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddUndoDelete(comp : TComponent);
var
  uinfo : TUndoInfo;
  stream : TStream;
begin
  if (comp = nil) or (comp.Name = '') then
    exit;

  uinfo := CreateUndoInfo;
  uinfo.Operation := dopDelete;
  stream := uinfo.CompContent;
  with TWriter.Create(stream, 16) do
    try
      WriteSignature;
    finally
      Free;
    end;
    
  SaveComponentToStream(comp, uinfo.CompContent);

  AddUndoInfo(uinfo);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.StartControlSizeChanging(Sender : TObject);
begin
  fOldCompRect := GetComponentPosition(fControlHandles.ParentControl);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetComponentPosition(comp : TComponent) : TRect;
var
  container : TComponentContainer;
begin
  if comp is TControl then
    with TControl(comp) do
      result := Rect(left, top, left + width, top + height)
  else
    begin
      container := GetContainer(comp);
      if container <> nil then
        result.TopLeft := container.TopLeft;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddUndoPosition(comp : TComponent; Rect : TRect);
var
  uinfo : TUndoInfo;
begin
  if (comp = nil) or (comp.Name = '') then
    exit;

  uinfo := CreateUndoInfo;
  with uinfo do
    begin
      Name := comp.Name;
      operation := dopChangePos;
      OldPos := Rect;
    end;

  AddUndoInfo(uinfo);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SavePosition(comp : TComponent);
begin
  AddUndoPosition(comp, GetComponentPosition(comp));
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SaveListPosition(l : TList);
var
  i : integer;
begin
  for i := 0 to l.Count - 1 do
    SavePosition(l.list[i]);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.CreateInsComponent : TComponent;
var
  iclass     : string;
  cclass     : TComponentClass;
  isole      : boolean;
begin
  iclass := DesignerInsertClass;
  isole := iclass[1] = '{';
  if isole then
    cclass := TWinControl
  else
    cclass := TComponentClass(GetClass(iclass));

  ValidateContainer(cclass);

  if isole then
    result := TDCOleControl.CreateGUID(OwnerControl, StringToGUID(iclass))
  else
    result := cclass.Create(OwnerControl);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.RealDoInsert(center : boolean) : TComponent;
var
  aname       : string;
  pt          : TPoint;
  FInsControl : TControl;
  {$IFDEF D3}
  needrecreate : boolean;
  {$ENDIF}
begin
  result := nil;

  if not ((fdAllowInsert in fOptions) and ActionAllowed(fSelParent, atInsertInto)) then
    begin
//      DesignerInsertClass:='';
      exit;
    end;

  if not (Assigned(GetClass(DesignerInsertClass)) or ((DesignerInsertClass <> '') and
          (DesignerInsertClass[1] = '{'))) then
    exit;

  BeginUpdate;

  {$IFDEF D3}
  needrecreate := firsthandles;
  {$ENDIF}
  try
    with fSelRect do
      begin
        if fSelParent is TControl then
          begin
            TopLeft := fSelParent.ScreenToClient(TopLeft);
            BottomRight := fSelParent.ScreenToClient(BottomRight);
          end;
        AName := DesignerInsertClass;
        fSkipNotification := true;
        result := CreateInsComponent;
        try
          if AName[1] = '{' then
            Aname := TDCOleControl(result).OleName;

          result.Name := UniqueName(copy(AName, 2, MaxInt));

          ClearSelectedComponents;

          if result is TControl then
            begin
              fInsControl := TControl(result);
              if (right - left > 10) and (bottom - top > 10) then
                fInsControl.SetBounds(left, top, right - left, bottom - top)
              else
                fInsControl.SetBounds(left, top, fInsControl.Width, fInsControl.Height);

              if center and (fSelParent is TControl) then
                begin
                  fInsControl.Left := max(0, (fSelParent.ClientWidth - fInsControl.Width) div 2);
                  fInsControl.Top  := max(0, (fSelParent.ClientHeight - fInsControl.Height) div 2);
                end;

              fskipmessage := true;
              try
                fInsControl.Parent := fSelParent;
              finally
                fskipmessage := false;
              end;

              fInsControl.BringToFront;
            end
          else
            begin
              if fSelParent is TControl then
                pt := form.ScreenToClient(fSelParent.ClientToScreen(Point(left, top)))
              else
                pt := Point(0, 0);

              CreateContainer(result, pt.x, pt.y);
            end;
          AddSelectedComponent(result);
        except
          result.Free;
          result := nil;
          raise;
        end;
      end;
  finally
    fSkipNotification := false;
    {$IFDEF D3}
    if needrecreate and (result <> nil) and (result.ClassName = 'TDateTimePicker') then //don't resource
      try
        fskipmessage := true;
        TMWinControl(result).RecreateWnd;
      finally
        fskipmessage := false;
      end;
    {$ENDIF}
    EndUpdate;
    BringContainersToFront;
    if (result <> nil) and Assigned(fOnAfterInsertComponent) then
      fOnAfterInsertComponent(self, result);
  end;

  AddUndoNewComp(result);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DoInsert;
begin
  RealDoInsert(false);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.CreateComponent(ComponentClass: TComponentClass; Parent: TComponent;
                          Left, Top, Width, Height: Integer): TComponent;
var
  SaveDesignerInsertClass : string;
  SaveSelParent : TWinControl;
  SaveSelRect : TRect;
begin
  if ComponentClass = nil then
    begin
      result := nil;
      exit;
    end;

  SaveDesignerInsertClass := DesignerInsertClass;
  SaveSelParent := fSelParent;
  SaveSelRect := fSelRect;
  try
    DesignerInsertClass := ComponentClass.ClassName;

    fSelParent := TWinControl(Parent);
    if Parent <> nil then
      begin
        fSelRect := Rect(Left, Top, Left + Width, Top + Height);
        with fSelRect do
          begin
            TopLeft := TControl(Parent).ClientToScreen(TopLeft);
            BottomRight := TControl(Parent).ClientToScreen(BottomRight);
          end;
      end;

    result := RealDoInsert(false);

  finally
    DesignerInsertClass := SaveDesignerInsertClass;
    fSelParent := SaveSelParent;
    fSelRect := SaveSelRect;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AssignSelParent;
begin
  if fSelectedComponents.Count > 0 then
    fSelParent := FindParent(TComponent(fSelectedComponents[0]))
  else
    fSelParent := GetParentControl;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.InstantInsertComponent(AClassName : string) : TComponent;
var
  f : TCustomForm;
begin
  InsertComponent(AClassName);
  with fSelRect do
    begin
      f := form;
      TopLeft := f.ClientToScreen(Point((f.ClientWidth - ContainerSize) div 2,
                                        (f.ClientHeight- ContainerSize) div 2));
      BottomRight := TopLeft;
    end;
  AssignSelParent;
  result := RealDoInsert(true);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MakeSelRect;
var
  rect      : TRectClass;
  i         : integer;
  container : TComponentContainer;
  comp      : TComponent;
  l         : TList;
begin
  ClearList(fSelRects);

  l := TList.Create;
  try
    GetActionList(l, atMove, true);
    if l.Count = 0 then
      exit;

    for i := 0 to l.Count - 1 do
      begin
        rect := TRectClass.Create;
        comp := TComponent(l[i]);
        if (comp is TControl) then
          with TControl(comp), rect.rect do
            begin
              TopLeft := ClientToScreen(Point(0, 0));
              BottomRight := ClientToScreen(Point(width, height));
            end
        else
          begin
            container := GetContainer(comp);
            if Assigned(Container) then
              with Container do
                begin
                  rect.rect.TopLeft := form.ClientToScreen(Point(Left, Top));
                  rect.rect.BottomRight := form.ClientToScreen(Point(Left + ContainerSize, Top + ContainerSize));
                end;
          end;
        rect.comp := comp;  
        fSelRects.Add(rect);
      end;
  finally
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DrawSelRect;
var
  i : integer;
begin
  for i := 0 to fSelRects.Count - 1 do
    DrawClippedSelection(TRectClass(fSelRects[i]).rect, fClipRect);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FinishSelecting;
begin
  fSelecting := false;
  HideHint;
  SmartDrawSelection(fSelRect);
  RemoveClipping;
  CheckRect(fSelRect);
  if DesignerInsertClass <> '' then
    DoInsert
  else
    MarkSelected;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FinishMoving;
var
  p         : TPoint;
  i         : integer;
  deltax    : integer;
  deltay    : integer;
  moved     : boolean;
  container : TComponentContainer;
begin
  RemoveClipping;
  if not firstmove then
    DrawSelRect;

  HideHint;  

  if fSelRects.Count > 0 then
    begin
      with TRectClass(fSelRects[0]), rect do
        begin
          if comp is TControl then
            p := TControl(comp).ClientToScreen(Point(0, 0))
          else
            begin
              container := GetContainer(comp);
              p := form.ClientToScreen(Point(Container.Left, Container.Top));
            end;

          deltax := Left - p.x;
          deltay := Top - p.y;
        end;
    end
  else
    begin
      deltax := 0;
      deltay := 0;
    end;

  if (deltax <> 0) or (deltay <> 0) then
    begin
      for i := 0 to fSelRects.Count - 1 do
        with TRectClass(fSelRects[i]),rect do
          begin
            SavePosition(comp);
            if comp is TControl then
              begin
                p := TControl(comp).ClientToScreen(Point(0, 0));
                deltax := Left - p.x;
                deltay := Top - p.y;
                with TControl(comp) do
                  SetBounds(Left + deltax, Top + deltay, Width, Height);
              end
            else
              begin
                Container := GetContainer(comp);
                p := form.ClientToScreen(Point(Container.Left, Container.Top));
                deltax := Left - p.x;
                deltay := Top - p.y;
                container.TopLeft := (Point(container.Left + deltax, container.Top + deltay));
              end;
          end;
      moved := true;
    end
   else
     moved := false;

  ClearList(fSelRects);
  fMoving := false;

  if SelectedComponents.Count = 1 then
    begin
      if fneedhandles then
        begin
          CreateControlHandles(TComponent(SelectedComponents[0]));
          fneedhandles := false;
        end
      else
        fControlHandles.ShowMode := smActive;

      Container := GetContainer(TComponent(SelectedComponents[0]));
      if Container <> nil then
        with Container.fHandles do
          begin
            Visible := true;
            ResetPosition;
          end;

      if fLockControls then
        fControlHandles.ShowMode := smInActive
      else
        fControlHandles.ShowMode := smActive
    end
  else
    ShowHandles;

  if moved then
    Modified;
end;

{------------------------------------------------------------------}

function IsVCLChild(AParent : TWinControl; Child : TControl) : boolean;
begin
   repeat
     result := Child = AParent;

     if result or (Child = nil) then
       exit;

     Child := Child.Parent;
   until false;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.InLimit(AComp : TPersistent) : boolean;
begin
  result := not (AComp is TControl) or IsVCLChild(LimitControl, TControl(AComp));
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MouseDown(Button : TMouseButton;
                                     Shift : TShiftState; X, Y : Integer);
var
  c        : TComponent;
  p        : TPoint;
  selected : boolean;
  locked   : boolean;
  SelectAllowed : boolean;
  DoubleClick : boolean;

  procedure GetRealSelectionControl;
  var
    cOwner   : TComponent;
  begin
    cOwner := OwnerControl;
    while (c is TControl) and (c <> form) and
          (c.Owner <> GetRealParentForm(TControl(c))) and (c.Owner <> cOwner) do
      begin
        {$IFDEF D5}
        if (c.Owner is TCustomFrame) and (c.Owner.Owner = cOwner) then
          break;
        {$ENDIF}
        c := c.owner;
      end;
  end;
begin
  if Assigned(fOnMouseDown) then
    fOnMouseDown(Self, Button, Shift, X, Y);

  if not InLimit(fSendControl) then
    exit;

  BeginUpdate;
  try
    c := fSendControl;
    if SelectedComponents.Count = 0 then
      Exclude(Shift, ssShift);

    if Button = mbRight then
      begin
        CancelMovingSelecting;
        GetRealSelectionControl;
        if SelectedComponents.Count <= 1 then
          SelectComponent(c)
        else
          FilterSelectedComponents(c);
        exit;
      end;

    fSelParent := FindParent(c);
    if (DesignerInsertClass <> '') and not InLimit(fSelParent) then
      exit;

    GetRealSelectionControl;
    selected := SelectedComponents.IndexOf (c) >= 0;
    SelectAllowed := ActionAllowed(c, atSelect);

    DoubleClick := [ssDouble, ssShift] * Shift = [ssDouble];

    if not DoubleClick and SelectAllowed and not
       ((ssShift in Shift) or selected) or (ssCtrl in shift) then
      ClearSelectedComponents;

    if DoubleClick then
      begin
        if c = LimitControl then
          exit;

        if c is TDataModuleWrapper then
          c := TDataModuleWrapper(c).fDataModule;

        if c = nil then
          c := form;

        if AllowEdit(c, '') then
          begin
            {$IFNDEF D6}
            fcedit.Free;
            {$ENDIF}
            fcedit := GetComponentEditor(c, self);

            if (fcedit <> nil) then
              fcedit.Edit;
          end;
        exit;
    end;

    if (c = form) or (c = LimitControl) and (Shift * [ssCtrl, ssShift] = []) then
      if LimitControl = nil then
        AddTofSelections(OwnerControl)
      else
        AddTofSelections(LimitControl)
    else
      if Assigned(c) and not (ssCtrl in Shift) and SelectAllowed and (c <> form) and (DesignerInsertClass = '') then
        begin
          locked := fLockControls or ReadOnly or not ActionAllowed(c, atMove);
          if selected and (ssShift in Shift) then
            DeselectComponent(c)
          else
            begin
              if SelectAllowed then
                if SelectedComponents.Count > 0 then
                  begin
                    AddSelectedComponent(c);
                    fneedhandles := false;
                    if (SelectedComponents.Count = 1) then
                      fControlHandles.ShowMode := smInvisible;

                    ShowHandles;  
                  end
                else
                  begin
                    AddTofSelections(c);
                    SelectedComponents.Add(c);
                    if locked then
                      CreateControlHandles(c)
                    else
                      fneedhandles := true;
                  end;

              if SelectedComponents.Count = 0 then
                exit;

              fSelParent := FindParent(c);
            end;

          if (fSelParent = c) and (fSelParent <> form) then
              fSelParent := fSelParent.Parent;

          if locked or (ssShift in Shift) then
            exit;

          fMoving := true;
          fClipRect := SetClipping (fSelParent);

          MakeSelRect;
          firstmove := true;
          foldx := x;
          foldy := y;
          exit;
        end;

    fClipRect := SetClipping(fSelParent);

    p := Point(X, Y);

    fSelRect.TopLeft := p;
    fSelRect.BottomRight := p;
    fSelecting := true;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowPopup(X, Y : integer);
var
  c : TComponent;
  _popup : TPopupMenu;
begin
  c := fSendControl;
  FreeObject(fcedit,fcedit);

  if (fSelectedComponents.Count < 2) and (c <> nil) then
    begin
      if c.ClassNameIs('TGroupButton') then
        c := TControl(c).Parent;

      if AllowEdit(c, '') then
        fcedit := GetComponentEditor(c, self)
    end
  else
    fcedit := nil;

  if UseDefaultMenu then
    begin
      ClearMenuSubItems(fDefaultPopup.Items, false);
      CopyPopupMenu(PopupMenu, fDefaultPopup);
      FillDefaultPopup(OwnerControl is TCustomForm);

      _popup := fDefaultPopup;
    end
  else
    _popup := PopupMenu;

  if Assigned(_popup) and Assigned(_popup.OnPopup) then
    _popup.OnPopup(_popup);

  MakeComponentPopup(_popup, fmenu, fcedit);

  if Assigned(fmenu) then
    begin
      fmenu.PopupComponent := c;
      fmenu.Popup(X, Y);
    end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.IsComponentLinkable(Component: TComponent): Boolean;
begin
(*
  If Assigned(FCodeDesigner) then
    Result:=FCodeDesigner.IsComponentLinkable(Component)
  else
*)
    Result:=False;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MakeComponentLinkable(Component: TComponent);
begin
(*
  If Assigned(FCodeDesigner) then
    FCodeDesigner.MakeComponentLinkable(Component);
*)
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MouseUp(Button: TMouseButton;
                                   Shift: TShiftState; X, Y: Integer);
var
  AllowPopup : boolean;
begin
  BeginUpdate;
  try
    if Assigned(fOnMouseUp) then
      fOnMouseUp(Self, Button, Shift, X, Y);

    if fSnapToGrid then
      begin
        RoundToNearest(X, fGridStepX);
        RoundToNearest(Y, fGridStepY);
      end;

    if fSelecting then
      FinishSelecting
    else
      if fMoving then
        FinishMoving;

    if Button = mbRight then
      begin
        if Assigned(OnAllowPopup) then
          begin
            AllowPopup := true;
            OnAllowPopup(self, Shift, X, Y, AllowPopup);
            if not AllowPopup then
              exit;
          end;
        ShowPopup(X, Y);
      end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ValidateHandlesRect(Sender : TObject; var r : TRect);
begin
  with fControlHandles do
    SnapRect(r, fSizingHandle in [hpTopLeft,     hpLeft,   hpBottomLeft],
                fSizingHandle in [hpTopLeft,     hpTop,    hpTopRight],
                fSizingHandle in [hpTopRight,    hpRight,  hpBottomRight],
                fSizingHandle in [hpBottomRight, hpBottom, hpBottomLeft]);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SnapRect(var r : TRect; SnapLeft, SnapTop, SnapRight, SnapBottom : boolean);
begin
  if fSnapToGrid then
    with form, r do
      begin
        TopLeft := ScreenToClient(TopLeft);
        BottomRight := ScreenToClient(BottomRight);

        if SnapLeft then
          RoundToNearest(Left, fGridStepX);

        if SnapTop then
          RoundToNearest(Top, fGridStepY);

        if SnapRight then
          RoundToNearest(Right, fGridStepX);

        if SnapBottom then
          RoundToNearest(Bottom, fGridStepY);

        TopLeft := ClientToScreen(TopLeft);
        BottomRight := ClientToScreen(BottomRight);
      end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelection(X, Y : integer);
var
  r : TRect;
begin
  r := fSelRect;
  r.BottomRight := Point(X, Y);

  if DesignerInsertClass <> '' then
    SnapRect(r, true, true, true, true);

  if not EqualRect(FSelRect, R) then
    begin
      HideHint;
      SmartDrawSelection(FSelRect);
      SmartDrawSelection(R);
      fSelRect := r;
      ShowSizeHint(r);
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.HideHint;
begin
  if fShowHints then
    Hint.CancelHint;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowSizeHint(const R : TRect);
begin
  if not fShowHints or (fSelecting and (DesignerInsertClass = '')) then
    exit;

  with R do
    Hint.ActivateHint(IntToStr(Abs(Right - Left)) + ' x ' + IntToStr(Abs(Bottom - Top)));  //don't resource
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowCompHint(c : TComponent);
begin
  if (c <> nil) and fShowHints and (fLastHintComp <> c) then
    begin
//      Hint.Immediate := false;
//      Hint.ActivateHint(c.Name + ':' + c.ClassName);
//      fLastHintComp := c;
//      Hint.Immediate := true;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowMoveHint;
var
  i : integer;
  c : TComponent;
  pcontrol : TWinControl;
  pt       : TPoint;
begin
  if fShowHints and (fSelRects.Count > 0) then
    begin
      with TRectClass(fSelRects[0]).rect do
        begin
          pt.x := left;
          pt.y := top;
        end;

      for i := 1 to fSelRects.Count - 1 do
        with TRectClass(fSelRects[i]).rect do
          begin
            pt.x := min(pt.x, left);
            pt.y := min(pt.y, top);
          end;

      c := TRectClass(fSelRects[0]).comp;

      if c is TControl then
        pcontrol := TControl(c).Parent
      else
        pcontrol := Form;

      pt := pcontrol.ScreenToClient(pt);

      Hint.ActivateHint(IntToStr(pt.x) + ', ' + IntToStr(pt.y));
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveControls(X, Y : integer);
var
  deltax : integer;
  deltay : integer;
  i      : integer;
begin
  deltax := x - foldx;
  deltay := y - foldy;

  if fSnapToGrid then
    begin
      RoundToNearest(deltax, fGridStepX);
      RoundToNearest(deltay, fGridStepY);
    end;

  if (deltax = 0) and (deltay = 0) then
    exit;

  HideHint;

  if firstmove then
    firstmove := false
  else
    DrawSelRect;

  x := foldx + deltax;
  y := foldy + deltay;

  for i := 0 to fSelRects.Count - 1 do
    OffsetRect(TRectClass(fSelRects[i]).rect, deltax, deltay);

  DrawSelRect;

  ShowMoveHint;

  foldx := x;
  foldy := y;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  BeginUpdate;
  try
    if Assigned(fOnMouseMove) then
      fOnMouseMove(Self, Shift, X, Y);

    if fSelecting then
      MoveSelection(X, Y)
    else if fMoving then
      MoveControls(X, Y)
    else if fSendControl <> form then
      ShowCompHint(fSendControl);

  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ResizeSelectedComponents (deltax, deltay : integer);
var
  i : integer;
  l : TList;
begin
  if fLockControls then
    exit;

  l := TList.Create;
  try
    GetActionList(l, atResize, true);
    if l.Count = 0 then
      exit;

    SaveListPosition(l);
    
    for i := 0 to l.Count - 1 do
      if TComponent(l[i]) is TControl then
        with TControl(l[i]) do
          SetBounds(Left, Top, max(1, Width + deltax), max(1, Height + deltay));

    if SelectedComponents.Count > 1 then
      ShowHandles;

    Modified;
  finally
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelectedComponents (deltax, deltay : integer);
var
  i : integer;
  comp : TComponent;
  container : TComponentContainer;
  l : TList;
begin
  if fLockControls then
    exit;

  l := TList.Create;
  try
    GetActionList(l, atMove, true);
    if l.Count = 0 then
      exit;

    SaveListPosition(l);

    for i := 0 to l.Count - 1 do
      begin
        comp := l[i];
        if comp is TControl then
          with TControl(comp) do
            SetBounds(Left + deltax, Top + deltay, Width, Height)
        else
          begin
            container := GetContainer(comp);
            if assigned(container) then
              with container do
                 begin
                   Top := Top + deltay;
                   Left := Left + deltax;
                 end;
          end;
      end;
    if SelectedComponents.Count > 1 then
      ShowHandles;

    Modified;
  finally
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CancelMovingSelecting;
begin
  if fMoving then
    begin
      if not firstmove then
        DrawSelRect;

      if fneedhandles then
        begin
          CreateControlHandles(TComponent(SelectedComponents[0]));
          fneedhandles := false;
        end;

      with fControlHandles do
        if fLockControls then
          ShowMode := smInActive
        else
          ShowMode := smActive;

      ShowHandles;
    end
  else if fSelecting then
    SmartDrawSelection(fSelRect);

  fSelecting := false;
  fMoving := false;
  RemoveClipping;
  HideHint;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyEscape(Shift : TShiftState);
var
  C : TComponent;
begin
  BeginUpdate;
  try
    if not fMoving then
      if (SelectedComponents.Count > 0) then
        begin
          C := SelectedComponents[0];
          if C is TControl then
            begin
              repeat
                c := TControl(c).Parent;
              until (c = nil) or (c = Form) or (c = LimitControl) or CanBeSelected(C);

              if c <> nil then
                SelectComponent(C);
            end
          else
            ClearSelectedComponents;
        end;
  finally
    CancelMovingSelecting;
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyInsert(Shift : TShiftState);
begin
  if ssShift in Shift then
      ClipboardPaste
  else
    if ssCtrl in Shift then
      ClipboardCopy;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Select;
var
  c : TComponent;
  i : integer;
  wc : TWinControl;
begin
  c := nil;

  if (OwnerControl is TWinControl) then
    begin
      wc := LimitControl;
      if wc = nil then
        wc := TWinControl(OwnerControl);
      with wc do
        begin
          i := ControlCount - 1;
          while i >= 0 do
            begin
              c := Controls[i];
              if CanBeSelected(c) then
                break
              else
                begin
                  c := nil;
                  dec(i);
                end;
            end;
        end;
    end;

  if (c = nil) {and (LimitControl <> nil)} then
    with OwnerControl do
      begin
        i := ComponentCount - 1;
        while i >= 0 do
          begin
            c := Components[i];
            if CanBeSelected(c) then
              break
            else
              begin
                c := nil;
                dec(i);
              end;
          end;

        if c = nil then
          begin
            c := LimitControl;
            if c = nil then
              c := OwnerControl;
          end;    
      end;

  BeginUpdate;
  try
    AddSelectedComponent(c);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyDelete(Shift : TShiftState);
begin
  if SelectedComponents.Count = 0 then
    exit;

  if ssShift in Shift then
    ClipboardCut
  else
    DeleteSelectedComponents;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyUp    (Shift : TShiftState);
begin
  if ssShift in Shift then
    if ssCtrl in Shift then
      MoveSelectedComponents (0, -GridStepY)
    else
      ResizeSelectedComponents (0, -1)
  else
    if ssCtrl in Shift then
      MoveSelectedComponents (0, -1)
    else
      MoveSelectionUp;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyDown  (Shift : TShiftState);
begin
  if ssShift in Shift then
    if ssCtrl in Shift then
      MoveSelectedComponents (0, GridStepY)
    else
      ResizeSelectedComponents (0, 1)
  else
    if ssCtrl in Shift then
      MoveSelectedComponents (0, 1)
    else
      MoveSelectionDown;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyLeft  (Shift : TShiftState);
begin
  if ssShift in Shift then
    if ssCtrl in Shift then
      MoveSelectedComponents (-GridStepX, 0)
    else
      ResizeSelectedComponents (-1, 0)
  else
    if ssCtrl in Shift then
      MoveSelectedComponents (-1, 0)
    else
      MoveSelectionLeft;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyRight (Shift : TShiftState);
begin
  if ssShift in Shift then
    if ssCtrl in Shift then
      MoveSelectedComponents (GridStepX, 0)
    else
      ResizeSelectedComponents (1, 0)
  else
    if ssCtrl in Shift then
      MoveSelectedComponents (1, 0)
    else
      MoveSelectionRight;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ProcessKeyBack (Shift : TShiftState);
begin
  if ssAlt in Shift then
    if ssShift in Shift then
      Redo
    else
      Undo;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.KeyDown (var Key: Word; Shift: TShiftState);
begin
  if fUpdateCount > 0 then
    exit;

  if Assigned(fOnKeyDown) then
    fOnKeyDown(Self, Key, Shift);

  if (fMoving or fSelecting or
  ((fControlHandles<> nil) and fControlHandles.fSizing)) and (key <> VK_ESCAPE) then
    exit;

  if ssCtrl in Shift then
    case Key of
      word('C') : ClipboardCopy;
      word('V') : ClipboardPaste;
      word('X') : ClipboardCut;
      word('Z') : if ssShift in Shift then
                    Redo
                  else
                    Undo;
    end;

  case Key of
    VK_ESCAPE : ProcessKeyEscape(Shift);
    VK_INSERT : ProcessKeyInsert(Shift);
    VK_DELETE : ProcessKeyDelete(Shift);
    VK_UP     : ProcessKeyUp    (Shift);
    VK_DOWN   : ProcessKeyDown  (Shift);
    VK_LEFT   : ProcessKeyLeft  (Shift);
    VK_RIGHT  : ProcessKeyRight (Shift);
    VK_BACK   : ProcessKeyBack  (Shift);
    VK_RETURN : if fShowInspector then
                  dcsystem.ShowInspector;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FreeControlHandles;
var
  comp      : TComponent;
  container : TComponentContainer;
begin
  if (SelectedComponents.Count = 1) and not fneedhandles then
   begin
     comp := SelectedComponents[0];
     if not (comp is TControl) then
       begin
         container := GetContainer(comp);
         if assigned(container) then
           container.hidehandles;
       end
     else
       with fControlHandles do
         begin
           Visible := false;
           ParentControl := nil;
         end;
   end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CreateControlHandles(aParent : TComponent);
var
  container : TComponentContainer;
begin
  if not (aParent is TControl) then
    begin
      container := GetContainer(aParent);
      if Assigned(container) then
        Container.ShowHandles;

      exit;
    end;

  if (fControlHandles <> nil) and (TControl(aParent).Parent <> nil) and TControl(aParent).Parent.HandleAllocated then
    with fControlHandles do
      begin
        ParentControl := TControl(aParent);
        Visible := true;
        firsthandles := false;

        if fLockControls then
          ShowMode := smInActive
        else
          ShowMode := smActive;

        CanBeSized := not ReadOnly and ActionAllowed(aParent, atResize);
        OnSizeChanged := ControlSizeChanged;
        OnStartSizeChanging := StartControlSizeChanging;
      end;

  fHandleDraw := true;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.UpdateHandles;
begin
  if SelectedComponents.Count = 1 then
    begin
      DrawControlHandles(SelectedComponents[0], false);
      CreateControlHandles(SelectedComponents[0]);
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DeselectComponent (val : TPersistent);
begin
  inherited;
  
  RemoveFromfSelections(val);

  if SelectedComponents.IndexOf(val) < 0 then
    exit;

  BeginUpdate;
  try
    FreeControlHandles;
    if SelectedComponents.Count = 1 then
      SelectedComponents.Clear
    else
      begin
        SelectedComponents.Delete(SelectedComponents.IndexOf(val));
        if val is TComponent then
          DrawControlHandles(TComponent(val), false);
        UpdateHandles;
      end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AddSelectedComponent (val : TComponent);
begin
  AddTofSelections(val);
  if not CanBeSelected(val) then
    exit;

  BeginUpdate;
  try
    if SelectedComponents.Count = 0 then
      CreateControlHandles(val)
    else
      begin
        FreeControlHandles;
        if SelectedComponents.Count = 1 then
            DrawControlHandles(SelectedComponents[0], true);
        DrawControlHandles(val, true);
      end;
    SelectedComponents.Add (val);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClearSelectedComponents;
var
  i    : integer;
  comp : TComponent;
begin
  fSelections.Clear;
  fSelectChanged := true;
  If SelectedComponents.Count = 0 then
    exit;

  BeginUpdate;
  try
    FreeControlHandles;
    fHandleDraw := false;

    if (SelectedComponents.Count = 1) then
      begin
        comp := TComponent(SelectedComponents[0]);
        if (comp is TControl) then
          TControl(comp).Parent.Update;
      end;

    if SelectedComponents.Count > 1 then
      for i := 0 to SelectedComponents.Count - 1 do
        DrawControlHandles(SelectedComponents[i], false);

    SelectedComponents.Clear;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ReaderOnSetName(Reader: TReader; Component: TComponent;
            var Name: string);
begin
  FNewPasteName := Name;
  if (Component.Owner = nil) or (Component.Owner.FindComponent(Name) <> nil) then
    Name := UniqueName(copy(Component.ClassName, 2, MaxInt));
  fPastedComps.Add(fNewPasteName + '=' + Name);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.BringContainersToFront;
var
  i : integer;
begin
  for i := 0 to fContainers.Count - 1 do
    TComponentContainer(fContainers[i]).Show;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.PasteComponent(c : TComponent);
var
  oname    : string;
begin
  try
    ValidateContainer(TComponentClass(c.ClassType));
  except
    Application.HandleException(Form);
    raise;
  end;

  Modified;
  if fFirstPaste then
    ClearSelectedComponents;

  if c is TDCOleControl then
    begin
      oname := TDCOleControl(c).OleName;
      delete(oname, 1, 1);
      c.Name := UniqueName(oname);
    end;

  if not fInUndo and (FNewPasteName = FLastPasteName) then
    inc(fshiftcount)
  else
    begin
      fshiftcount := 0;
      FLastPasteName := FNewPasteName;
    end;

  if (c is TControl) then
    with TControl(c) do
      begin
        if Active and (csNoDesignVisible in ControlStyle) then
          begin
            c.Free;
            exit;
          end;

        if fSelParent = nil then
          begin
            fSelParent := Form;
            if (fSelParent = nil) and (GetOwnerControl is TWinControl) then
              fSelParent := TWinControl(GetOwnerControl);
          end;

        if fSelParent <> nil then
          begin
            if {(R.Position = Mem2.Size) and }fFirstPaste then
              SetBounds(
                   min(FSelParent.ClientWidth - Width, Left + fGridStepX * fShiftCount),
                   min(FSelParent.ClientHeight - Height, Top + fGridStepY * fShiftCount),
                   Width, Height)
            else
              SetBounds(min(FSelParent.ClientWidth - Width,Left),
                        min(FSelParent.ClientHeight - Height,Top),
                        Width, Height);

            Parent := fSelParent;
          end;  
      end
    else if Active then
      CreateContainer(c,
               min(FSelParent.ClientWidth - ContainerSize, GetCLeft(c) + fGridStepX * fShiftCount),
               min(FSelParent.ClientHeight - ContainerSize, GetCTop(c) + fGridStepY * fShiftCount));

  fFirstPaste := false;
  if Active then
    AddSelectedComponent(c);

  if Assigned(OnAfterInsertComponent) then
    OnAfterInsertComponent(self, c);

  if Active then
    AddUndoNewComp(c);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ReaderOnReferenceName(Reader: TReader; var Name: string);
begin
  with fPastedComps do
    if IndexOfName(Name) >= 0 then
      Name := Values[Name];
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ReadComponentsFromStream(Stream : TStream);
var
  ffakeparent : TCustomForm;
begin
  with TWriter.Create(Stream, 16) do
    try
      WriteListEnd;
    finally
      Free;
    end;

  Stream.Seek(0,0);

  ffakeparent := CreateFormWithClass(TCustomForm);
  BeginUpdate;
  with TReader.Create(Stream, 4096) do
    try
      fPastedComps := TStringList.Create;
      fSkipNotification := true;
      fskipmessage := true;
      OnFindMethod := FCompFiler.ReaderOnMethod;
      OnSetName := ReaderOnSetName;
      OnReferenceName := ReaderOnReferenceName;
      ReadComponents(OwnerControl, fFakeParent, PasteComponent);
    finally
      fPastedComps.Free;
      ffakeparent.free;
      Free;
      FSkipNotification := false;
      fSkipMessage := false;
      EndUpdate;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClipboardPaste;
var
  container : TComponentContainer;
  Mem1      : TMemoryStream;
  Mem2      : TMemoryStream;
  ALength   : integer;
begin
  if flock or not (fdAllowInsert in fOptions) then
    exit;

  ALength := Length(ClipBoard.AsText);
  if ALength = 0 then
    exit;

  AssignSelParent;
  flock := true;

  Mem1 := TMemoryStream.Create;
  Mem2 := TMemoryStream.Create;
  BeginUpdate;
  try
    try
      Mem1.SetSize (Alength);
      StrLCopy(Mem1.Memory, PChar(ClipBoard.AsText), Mem1.Size);

      fFirstPaste := true;

      while Mem1.Position < Mem1.Size do
        ObjectTextToBinary(Mem1, Mem2);

      ReadComponentsFromStream(Mem2);
    finally
      flock := false;
      Mem1.Free;
      Mem2.Free;
      EndUpdate;
      if Active then
        begin
          BringContainersToFront;
          if SelectedComponents.Count = 1 then
            begin
              container := GetContainer(SelectedComponents[0]);
              if Assigned(container) then
                container.fHandles.ResetPosition;
            end;
        end;
    end;
  except
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClipboardCopy;
var
  Mem1  : TMemoryStream;
  Mem2  : TMemoryStream;
  i     : integer;
  j     : integer;

  procedure WriteToClipboard (comp : TComponent);
  var
    w : TWriter;
  begin
     Mem1.Seek(0, 0);
     w := TWriter.Create(Mem1, 4096);
     fSkipMessage := true;
     with w do
       try
         Root := OwnerControl;
         WriteSignature;
         WriteComponent(comp);
       finally
         fSkipMessage := false;
         Free;
       end;
     Mem1.Seek(0, 0);
     ObjectBinaryToText(Mem1, Mem2);
     FLastPasteName:=TComponent(SelectedComponents[i]).Name;
     FShiftCount:=0;
  end;

begin
  if SelectedComponents.Count > 0 then
    begin
      BeforeSave;
      Mem1 := TMemoryStream.Create;
      Mem2 := TMemoryStream.Create;
      try
        for i := 0 to SelectedComponents.Count - 1 do
          if (not(TObject(SelectedComponents[i]) is TControl)) or
             (SelectedComponents.IndexOf (TControl(
                SelectedComponents[i]).Parent) = - 1)
          then
            WriteToClipboard(SelectedComponents[i]);

        j := 0;
        Mem2.WriteBuffer(j, 1);
        Mem2.Seek(0, 0);
        ClipBoard.SetTextBuf(Mem2.Memory);
      finally
        Mem1.Free;
        Mem2.Free;
        AfterSave;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.InsertComponent(AClassName : string);
begin
  if (length(AClassName) = 0) or (AClassName[1] = '{') or (FindClass(AClassName) <> nil) then
    DesignerInsertClass := AClassName;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DrawGridInRect(ARect : TRect);
var
  x         : integer;
  xstart    : integer;
  xwidth    : integer;
begin

  x := ARect.left;

  repeat
    xstart := x mod fGridStepX;
    xwidth := min(ARect.Right - x, fGridStepX - xstart);
    with ARect do
      BitBlt (fDrawDC, x, top, xwidth, bottom - top, fTempDC, xstart, top, SRCCOPY);
    inc(x, xwidth);
  until (x >= ARect.Right);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.PaintRect(ARect : TRect; index : integer);
var
  r : TRect;
begin
  if index = form.ControlCount then
    begin
      DrawGridInRect(Arect);
      exit;
    end;

  if form.Controls[index] is TWinControl then
    PaintRect(ARect, index + 1)
  else
    with form.Controls[index] do
      begin
        r := Rect(Left, Top, Left + Width, Top + Height);
        if (csNoDesignVisible in ControlStyle) or not (csOpaque in ControlStyle) or
          not InterSectRect(r, ARect, r) then
          PaintRect(ARect, index + 1)
        else
          begin
            inc(index);
            PaintRect(Rect(ARect.Left, ARect.Top, r.Left, ARect.Bottom), index);
            PaintRect(Rect(r.Left, ARect.Top, ARect.Right, r.Top), index);
            PaintRect(Rect(r.Right, r.Top, ARect.Right, ARect.Bottom), index);
            PaintRect(Rect(r.Left, r.Bottom, r.Right, ARect.Bottom), index);
          end;
      end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DrawGridToDC(dc : THandle; updaterect : TRect);
var
  bitmap     : THandle;
  oldbitmap  : THandle;
  y          : integer;
  gcolor     : integer;
begin
  fDrawDC := dc;
  fTempDC := CreateCompatibleDC(DC);
  bitmap := CreateCompatibleBitmap(DC, fGridStepX, form.ClientHeight);
  oldbitmap := SelectObject(fTempDC, bitmap);
  windows.FillRect(fTempDC, Rect(0, 0, fGridStepX, form.ClientHeight), form.Brush.Handle);

  y := 0;
  gcolor := ColorToRGB(GridColor);

  repeat
    SetPixel (fTempDC, 0, y, gcolor);
    inc(y, fGridStepY);
  until (y > form.ClientHeight);

  try
    PaintRect(updaterect, 0);
  finally
    SelectObject(fTempDC, oldbitmap);
    DeleteObject(bitmap);
    DeleteDC(fTempDC);
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.PaintGrid;
begin
  if not (fShowGrid and fActive) or (OwnerControl is TDataModule) or (LimitControl <> nil) then
    exit;

  with form do
    DrawGridToDC(Canvas.Handle, Canvas.ClipRect);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetUndoLimit(val : integer);
var
  i : integer;
begin
  if fUndoLimit = val then
    exit;

  fUndoLimit := val;

  if fUndoList.Count > val then
    for i := 0 to fUndoList.Count - val do
      begin
        TObject(fUndoList[0]).Free;
        fUndoList.Delete(0);
      end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnCloseForm : TNotifyEvent;
begin
  result := fOnCloseForm;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnCloseForm(val : TNotifyEvent);
begin
  fOnCloseForm := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnChange : TNotifyEvent;
begin
  result := fOnChange;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnChange(val : TNotifyEvent);
begin
  fOnChange := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnSelectionChanged : TNotifyEvent;
begin
  result := fOnSelectionChanged;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnSelectionChanged(val : TNotifyEvent);
begin
  fOnSelectionChanged := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnDeleteComponent : TCNotifyProc;
begin
  result := fOnDeleteComponent
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnDeleteComponent(val : TCNotifyProc);
begin
  fOnDeleteComponent := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnInsertComponent : TCNotifyProc;
begin
  result := fOnInsertComponent;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnInsertComponent(val : TCNotifyProc);
begin
  fOnInsertComponent := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnGetComponentGlyph : TGetComponentGlyphProc;
begin
  result := fOnGetComponentGlyph
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnGetComponentGlyph(val : TGetComponentGlyphProc);
begin
  fOnGetComponentGlyph := val
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnKeyDown : TKeyEvent;
begin
  result := fOnKeyDown;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnKeyDown(val : TKeyEvent);
begin
  fOnKeyDown := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnMouseDown : TMouseEvent;
begin
  result := fOnMouseDown;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnMouseDown(val : TMouseEvent);
begin
  fOnMouseDown := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnMouseUp : TMouseEvent;
begin
  result := fOnMouseUp;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnMouseUp(val : TMouseEvent);
begin
  fOnMouseUp := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnMouseMove : TMouseMoveEvent;
begin
  result := fOnMouseMove;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnMouseMove(val : TMouseMoveEvent);
begin
  fOnMouseMove := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnGetCompNames : TGetCompNamesEvent;
begin
  result := fOnGetCompNames;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnGetCompNames(val : TGetCompNamesEvent);
begin
  fOnGetCompNames := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnAction : TActionEvent;
begin
  result := fOnAction;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOnActivate : TNotifyEvent;
begin
  result := fOnActivate;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnActivate(val : TNotifyEvent);
begin
  fOnActivate := val;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOnAction(val : TActionEvent);
begin
  fOnAction := val;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetLimitInfos(val : TLimitInfos);
begin
  fLimitInfos.Assign(val);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetLimitInfos : TLimitInfos;
begin
  result := fLimitInfos;
end;

{------------------------------------------------------------------}


procedure TDCFormDesigner.SetUseDefaultMenu(val : boolean);
begin
  fUseDefaultMenu := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetUseDefaultMenu : boolean;
begin
  result := fUseDefaultMenu;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetUseGlobalOptions(val : boolean);
begin
  if val <> fUseGlobalOptions then
    begin
      fUseGlobalOptions := val;
      if val then
        LoadGlobalOptions;
    end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetUseGlobalOptions : boolean;
begin
  result := fUseGlobalOptions;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetShowComponents : boolean;
begin
  result := fShowComponents;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetShowComponents(val : boolean);
begin
  fShowComponents := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetAllowUndo : boolean;
begin
  result := fAllowUndo;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetAllowUndo(val : boolean);
begin
  fAllowUndo := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetUseAncestor : boolean;
begin
  result := fUseAncestor;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetUseAncestor(val : boolean);
begin
  fUseAncestor := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetShowInspector : boolean;
begin
  result := fShowInspector;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetShowInspector(val : boolean);
begin
  fShowInspector := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetCompFiler : TCompFiler;
begin
  result := fCompFiler;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetPopupMenu : TPopupMenu;
begin
  result := fPopup;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetPopupMenu(val : TPopupMenu);
begin
  fPopup := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetShowCaptions : boolean;
begin
  result := fShowCaptions;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetSnapToGrid : boolean;
begin
  result := fSnapToGrid;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetSnapToGrid(val : boolean);
begin
  fSnapToGrid := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetUndoLimit : integer;
begin
  result := fUndoLimit;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetAllowedActions : TAllowedActions;
begin
  result := fAllowedActions;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetAllowedActions(val : TAllowedActions);
begin
  fAllowedActions := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetReadOnlyProps : TStrings;
begin
  result := fReadOnlyProps;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetReadOnlyProps(val : TStrings);
begin
  fReadOnlyProps.Assign(val);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetHiddenProps : TStrings;
begin
  result := fHiddenProps;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetHiddenProps(val : TStrings);
begin
  fHiddenProps.Assign(val);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetShowGrid : boolean;
begin
  result := fShowGrid;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetShowGrid(val : boolean);
begin
  if fShowGrid <> val then
    begin
      fShowGrid := val;
      if Assigned(form) then
        form.Invalidate;
    end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetGridStepX : TGridStep;
begin
  result := fGridStepX;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetGridStepY : TGridStep;
begin
  result := fGridStepY;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetGridStepX(val : TGridStep);
begin
  if val < 2 then
    val := 2;

  if fGridStepX <> val then
    begin
      fGridStepX := val;
      if Assigned(form) then
        form.Invalidate;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetGridStepY(val : TGridStep);
begin
  if val < 2 then
    val := 2;

  if fGridStepY <> val then
    begin
      fGridStepY := val;
      if Assigned(form) then
        form.Invalidate;
    end;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetHideOnClose : boolean;
begin
  result := fHideOnClose;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetHideOnClose(val : boolean);
begin
  fHideOnClose := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetLockControls : boolean;
begin
  result := fLockControls;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetLockControls(val : boolean);
begin
  if fLockControls <> val then
    begin
      fLockControls := val;
      if SelectedComponents.Count = 1 then
        if val then
          fControlHandles.ShowMode := smInactive
        else
          fControlHandles.ShowMode := smActive;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ShowHandles;
var
  i : integer;
  scount : integer;
begin
  scount := SelectedComponents.Count;
  if scount = 0 then
    exit;

  if scount = 1 then
    fControlHandles.Visible := true
  else
    for i := 0 to scount - 1 do
      DrawControlHandles(SelectedComponents[i], true);

  fShowHandles := true;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.HideHandles;
var
  i : integer;
begin
  if SelectedComponents.Count = 1 then
    fControlHandles.Visible := false
  else
    for i := 0 to SelectedComponents.Count - 1 do
      DrawControlHandles(SelectedComponents[i], false);

  fShowHandles := true;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FilterSelectedComponents(Comp : TComponent);
var
  CParent : TControl;
  i : integer;

  function GetParent(c : TComponent) : TWinControl;
  var
    p : TComponent;
  begin
    p  := c.GetParentComponent;
    if (p is TWinControl) then
      result := TWinControl(p)
    else
      result := form;
  end;

var
  c : TComponent;
begin
  if SelectedComponents.Count < 2 then
    exit;
  BeginUpdate;
  try
    CParent := GetParent(Comp);
    i := 0;

    while i < SelectedComponents.Count do
      begin
        c := SelectedComponents[i];
        if GetParent(c) <> CParent then
          begin
            DrawControlHandles(c, false);
            SelectedComponents.Delete(i);
            RemoveFromfSelections(c);
          end
        else
          inc(i);
      end;

     if SelectedComponents.Count = 1 then
       begin
         DrawControlHandles(SelectedComponents[0], false);
         CreateControlHandles(SelectedComponents[0]);
       end;

  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FilterSelection;
begin
  if SelectedComponents.Count > 0 then
    FilterSelectedComponents(SelectedComponents[0]);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AlignToGrid;
var
  i         : integer;
  NewLeft   : integer;
  NewTop    : integer;
  container : TComponentContainer;
  l         : TList;
begin
  l := TList.Create;
  try
    GetActionList(l, atMove, true);
    SaveListPosition(l);

    HideHandles;

    for i := 0 to l.Count - 1 do
      if TObject(l.List[i]) is TControl then
        with TControl(l.List[i]) do
          begin
            NewLeft := Left;
            NewTop  := Top;
            RoundToNearest(NewLeft, fGridStepX);
            RoundToNearest(NewTop, fGridStepY);
            SetBounds(NewLeft, NewTop, Width, Height);
          end
      else
        begin
          container := GetContainer(l.List[i]);
          NewLeft := container.Left;
          NewTop  := container.Top;
          RoundToNearest(NewLeft, fGridStepX);
          RoundToNearest(NewTop, fGridStepY);
          container.TopLeft := Point(NewLeft, NewTop);
        end;

    ShowHandles;

    if l.Count > 0 then
      Modified;

  finally
    l.Free;
  end;
end;

{------------------------------------------------------------------}
type
  TXControl = class(TControl)
  public
    container : TComponentContainer;
  end;

procedure TDCFormDesigner.AlignSelected (XAlign, YAlign : TAlignControls);
var
  T : TList;
  l : TList;
  i : integer;
  tx : TXControl;
begin
  if LockControls then
    exit;

  T := TList.Create;
  l := TList.Create;
  try
    HideHandles;
    FilterSelection;
    GetActionList(l, atMove, true);
    SaveListPosition(l);

    for i := 0 to l.Count - 1 do
      if TObject(l[i]) is TControl then
        T.Add(l[i])
      else
        begin
          tx := TXControl.Create(nil);
          with tx do
            begin
              container := GetContainer(l[i]);
              left := container.Left;
              top  := container.Top;
              width := ContainerSize;
              height := ContainerSize;
              visible := false;
              parent := GetPForm(l[i]);
            end;
          T.Add(tx);
        end;

    AlignControls (T, XAlign, YAlign);
    for i := 0 to T.Count - 1 do
      if TObject(T[i]) is TXControl then
        with TXControl(T[i]) do
          begin
            Container.Left := Left;
            Container.Top := Top;
            Free;
          end;

    ShowHandles;
    Modified;
  finally
    T.Free;
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure CopyControls(FromList,ToList:TList);
Var
  i:Integer;
begin
  ToList.Clear;
  for i := 0 to Fromlist.Count - 1 do
    if TObject(FromList[i]) is TControl then
      ToList.Add(Fromlist[i]);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SizeSelected (XSize,  YSize  : integer);
var
  T : TList;
  l : TList;
begin
  if LockControls then
    exit;

  T := TList.Create;
  l := TList.Create;
  try
    HideHandles;
    GetActionList(l, atResize, true);
    SaveListPosition(l);
    CopyControls(l, T);
    SizeControls (T, XSize, YSize);
    ShowHandles;
    Modified;
  finally
    T.Free;
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.BringToFront;
var
  i : integer;
  l : TList;
begin
  l := SelectedComponents;

  for i := 0 to l.Count - 1 do
    if TComponent(l.List[i]) is TControl then
      TControl(l.List[i]).BringToFront;

  if SelectedComponents.Count > 1 then
    ShowHandles;

  Modified;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SendToBack;
var
  i : integer;
  l : TList;
begin
  l := SelectedComponents;

  for i := 0 to l.Count - 1 do
    if TComponent(l.List[i]) is TControl then
      TControl(l.List[i]).SendToBack;

  if l.Count > 1 then
    ShowHandles;

  Modified;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.RestorePos(c : TComponent; OldPos : TRect);
var
  container : TComponentContainer;
begin
  if c <> nil then
    begin
      SavePosition(c);

      if c is TControl then
        with OldPos do
          TControl(c).SetBounds(Left, Top, Right - Left, Bottom - Top)
      else
        begin
          container := GetContainer(c);
          if container <> nil then
            container.TopLeft := OldPos.TopLeft;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.UndoDelete(CompStream : TStream);
begin
  fFirstPaste := true;
  ReadComponentsFromStream(CompStream);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.UndoOperation(list : TList);
var
  lcount  : integer;
  comp    : TComponent;
  ulevel  : integer;
  uop     : TDesignerOperation;
  mstream : TMemoryStream;
  l       : TList;
begin
  if not AllowUndo then
    exit;

  lcount := list.count;
  if lcount = 0 then
    exit;

  dec(lcount);
  ulevel := TUndoInfo(list.list[lcount]).UndoLevel;
  uop    := TUndoInfo(list.list[lcount]).Operation;

  if uop <> dopChangePos then
    ClearSelectedComponents;

  mstream := TMemoryStream.Create;
  l := TList.Create;

  fInUndo := true;
  try
    repeat
      with TUndoInfo(list[lcount]) do
        begin
          comp := OwnerControl.FindComponent(Name);

          case Operation of
            dopChangePos : RestorePos(comp, OldPos);
            dopDelete    : mstream.CopyFrom(CompContent, 0);
            dopInsert    : l.Add(comp);
          end;
        end;

      TObject(list.list[lcount]).Free;
      list.Delete(lcount);
      dec(lcount);

    until (lcount < 0) or (TUndoInfo(list.list[lcount]).UndoLevel <> ulevel) or (TUndoInfo(list.list[lcount]).Operation <> uop);

    case uop of
      dopChangePos : ;
      dopDelete    : UndoDelete(mstream);
      dopInsert    : DeleteCompList(l);
    end;

  finally
    mstream.Free;
    l.Free;
    fInUndo := false;
    ShowHandles;
    Modified;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Undo;
begin
  try
    SwapInt(integer(fUndoList), integer(fRedoList));
    UndoOperation(fRedoList);
  finally
    SwapInt(integer(fUndoList), integer(fRedoList));
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.UndoAll;
var
  pcontrol : TWinControl;
begin
  pcontrol := GetParentControl;
  LockWindowUpdate(pcontrol.Handle);
  try
    while UndoAvailable do
      Undo;
  finally
    LockWindowUpdate(0);
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Redo;
begin
  UndoOperation(fRedoList);
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetOptions : TFDOptions;
begin
   result := fOptions;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetOptions(val : TFDOptions);
begin
  fOptions := val;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetCodeDesigner : TCodeDesigner;
begin
  result := fCodeDesigner;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetCodeDesigner(val : TCodeDesigner);
begin
  fCodeDesigner := val;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetUndoAvailable : boolean;
begin
  result := fUndoList.Count > 0;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetUndoAvailable(val : boolean);
begin
  if val or not UndoAvailable then
    exit;

  ClearList(fUndoList);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SetWasChanged(Val:Boolean);
begin
  fWasChanged := Val;
  if not Val then
    UndoAvailable := false;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetWasChanged : boolean;
begin
  Result := fWasChanged or UndoAvailable;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetRedoAvailable : boolean;
begin
  result := fRedoList.Count > 0;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetLimitInfo(Instance : TComponent) : TLimitInfoItem;
var
  i : integer;
begin
  with LimitInfos do
    for i := 0 to Count - 1 do
      with TLimitInfoItem(Items[i]) do
        if Component = Instance then
          begin
            result := TLimitInfoItem(Items[i]);
            exit;
          end;

  result := nil;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.EditPropAllowed(Instance : TComponent; const PropName : string) : boolean;
var
  li : TLimitInfoItem;
begin
  result := not ReadOnly;
  if PropName = '' then
    exit;

  if Assigned(fOnEditProperty) then
    fOnEditProperty(self, Instance, PropName, result);

  if result then
    begin
      result := ReadOnlyProps.IndexOf(PropName) < 0;
      if result then
        begin
          li := GetLimitInfo(Instance);
          if li <> nil then
            result := li.ReadOnlyProps.IndexOf(PropName) < 0;
        end;
      end;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.ActionsAllowed(Instance : TPersistent; Actions : TAllowedActions) : boolean;
var
  li : TLimitInfoItem;
  ac : TActionType;
begin
  result := true;

  if Assigned(fOnAction) then
    for ac := Low(TActionType) to High(TActionType) do
      if ac in Actions then
        begin
          fOnAction(self, instance, ac, result);
          if not result then
            exit;
        end;

  if instance = form then
    exit;

  li := GetLimitInfo(TComponent(Instance));

  if li <> nil then
    result := Actions * li.AllowedActions = Actions;

  result := result and (Actions * AllowedActions = Actions);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.ActionAllowed(Instance : TPersistent; Action : TActionType) : boolean;
begin
  result := ActionsAllowed(Instance, [Action]);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.GetActionList(l : TList; Action : TActionType; Allowed : boolean);
var
  i : integer;
begin
  for i := 0 to SelectedComponents.Count - 1 do
    if ActionAllowed(SelectedComponents[i], Action) then
      l.Add(SelectedComponents[i]);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DeleteCompList(l : TList);
var
  i    : integer;
  comp : TComponent;
  llast : integer;
begin
  flock := true;
  try
    fDeletionList := l;
    FreeControlHandles;
    fskipmessage := true;
    BeginUpdate;

    llast := l.Count - 1;

    for i := llast downto 0 do
      AddUndoDelete(TComponent(l[i]));

    while l.Count > 0 do
      begin
        comp := TComponent(l.Last);
        DestroyContainer(GetContainer(comp));
        SelectedComponents.Remove(comp);
        RemoveFromfSelections(comp);
        if comp is TWinControl then
          TMWinControl(comp).DestroyWnd;
        comp.Free;
        if (l.Count > 0) and (l.Last = comp) then
          l.Delete(l.Count - 1);
      end;

   fneedhandles := false;
  finally
    fDeletionList := nil;
    try
      if SelectedComponents.Count = 0 then
        begin
          Select;
        end
      else
        UpdateHandles;
    finally
      fskipmessage := false;
      EndUpdate;
      flock := false;
      Modified;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.DeleteSelectedComponents;
var
  l    : TList;
begin
  l := TList.Create;
  try
    GetActionList(l, atDelete, true);
    if flock or (not (fdAllowDelete in FOptions)) or (l.Count = 0) then
      exit;

    DeleteCompList(l);
  finally
    l.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClipboardCut;
begin
  if SelectedComponents.Count = 0 then
    exit;

  ClipboardCopy;
  DeleteSelectedComponents;
  FLastPasteName:='';
  FShiftCount:=0;
end;

{------------------------------------------------------------------}
{$IFDEF D5}
procedure TDCFormDesigner.CopySelection;
begin
  ClipboardCopy;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CutSelection;
begin
  ClipboardCut;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.PasteSelection;
begin
  ClipboardPaste;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TDCFormDesigner.DeleteSelection(ADoAll: Boolean = False);
{$ELSE}
procedure TDCFormDesigner.DeleteSelection;
{$ENDIF}
begin
  DeleteSelectedComponents;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ClearSelection;
begin
  ClearSelectedComponents
end;

{------------------------------------------------------------------}
{$ENDIF}

procedure TDCFormDesigner.SelectAll;
var
  i : integer;
  pcontrol : TWinControl;
begin
  BeginUpdate;
  try
    ClearSelectedComponents;
    pcontrol := LimitControl;
    if pcontrol = nil then
      pcontrol := form;

    with pcontrol do
      for i := 0 to ControlCount - 1 do
        if not (Controls[i] is TComponentContainerSpeedButton) then
          AddSelectedComponent(Controls[i]);

    for i := 0 to fContainers.Count - 1 do
      AddSelectedComponent(TComponentContainer(fContainers[i]).Contained);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Scale(const factor : extended);

  procedure _scale(c : TControl);
  var
    i : integer;
  begin
    if c is TComponentContainerSpeedButton then
      exit;

    SavePosition(c);

    if c is TWinControl then
      with TWinControl(c) do
        for i := 0 to ControlCount - 1 do
          _scale(Controls[i]);

    with c do
      begin
        Width  := system.round(Width  * factor);
        Height := system.round(Height * factor);
      end;
  end;

var
  i : integer;
begin
  for i := 0 to form.ControlCount - 1 do
    _scale(form.Controls[i]);

  if SelectedComponents.Count > 1 then
    ShowHandles;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.Modified;
var
  s : TStrings;
  i : integer;
begin
  WasChanged := true;
  inherited;

  if fMethodCreated then
    begin
      fMethodCreated := false;
      if Scripter <> nil then
        begin
          s := TStringList.Create;
          try
            FillWithEvents(fMethodTypeData, s);
            with s do
              for i := 0 to Count - 1 do
                with TAssignedEventInfo(Objects[i]) do
                  if CompareText(Strings[i], fCreatedMethodName) = 0 then
                    Scripter.CreateEvent(Instance, Event, Strings[i], false);
          finally
            FreeStrings(s);
          end;
        end;
    end;

  if fMethodDeleted then
    begin
      fMethodDeleted := false;
      if Assigned(Scripter) then
        Scripter.EventDeleted;
    end;

  if Assigned(fOnChange) then
    fOnChange(self);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ControlSizeChanged(Sender : TObject; NewWidth, NewHeight : integer);
begin
  AddUndoPosition(fControlHandles.ParentControl, fOldCompRect);
  Modified;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelectionUp;
var
  c         : TComponent;
  max       : integer;
  newc      : TComponent;
  i         : integer;
  pcontrol  : TWinControl;
  cy        : integer;
  container : TComponentContainer;
begin
  if SelectedComponents.Count = 0 then
    exit;

  c := SelectedComponents[0];
  if c is TControl then
    with TControl(c) do
      begin
        cy := Top;
        pcontrol := Parent;
      end
  else
    begin
      container := GetContainer(c);
      if container = nil then
        exit;
      cy := container.Top;
      pcontrol := form;
    end;

  max := 0;
  newc := nil;

  with pcontrol do
    begin
      for i := 0 to ControlCount - 1 do
        with Controls[i] do
          if Top + Height  < cy then
            if Top + Height > max then
              begin
                newc := Controls[i];
                max  := Top + Height;
              end;

      for i := 0 to fContainers.Count - 1 do
        with TComponentContainer(fContainers[i]) do
          if Top + Height  < cy then
            if Top + Height > max then
              begin
                newc := fContained;
                max  := Top + Height;
              end;

    end;

  if (newc <> nil) and CanBeSelected(newc) then
    SelectComponent(newc);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelectionDown;
var
  c    : TComponent;
  min  : integer;
  newc : TComponent;
  i    : integer;
  bottom : integer;
  pcontrol  : TWinControl;
  cy        : integer;
  container : TComponentContainer;

begin
  if SelectedComponents.Count = 0 then
    exit;

  c := SelectedComponents[0];
  if c is TControl then
    with TControl(c) do
      begin
        pcontrol := Parent;
        bottom := Top + Height;
      end
  else
    begin
      container := GetContainer(c);
      if container = nil then
        exit;
      cy := container.Top;
      pcontrol := form;
      bottom := cy + ContainerSize;
    end;


  min := 100000;
  newc := nil;

  with pcontrol do
    begin
      for i := 0 to ControlCount - 1 do
        with Controls[i] do
          if Top > bottom then
            if Top < min then
              begin
                newc := Controls[i];
                min  := Top;
              end;

      for i := 0 to fContainers.Count - 1 do
        with TComponentContainer(fContainers[i]) do
          if Top > bottom then
            if Top < min then
              begin
                newc := fContained;
                min  := Top;
              end;
    end;


  if (newc <> nil) and CanBeSelected(newc) then
    SelectComponent(newc);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelectionLeft;
var
  c    : TComponent;
  max  : integer;
  newc : TComponent;
  i    : integer;
  pcontrol  : TWinControl;
  cx        : integer;
  container : TComponentContainer;

begin
  if SelectedComponents.Count = 0 then
    exit;

  c := SelectedComponents[0];
  if c is TControl then
    with TControl(c) do
      begin
        cx := Left;
        pcontrol := Parent;
      end
  else
    begin
      container := GetContainer(c);
      if container = nil then
        exit;
      cx := container.Left;
      pcontrol := form;
    end;


  max := 0;
  newc := nil;

  with pcontrol do
    begin
      for i := 0 to ControlCount - 1 do
        begin
          with Controls[i] do
            if Left + Width  < cx then
              if Left + Width > max then
                begin
                  newc := Controls[i];
                  max  := Left + Width;
                end;
        end;

      for i := 0 to fContainers.Count - 1 do
        with TComponentContainer(fContainers[i]) do
          if Left + Width  < cx then
            if Left + Width > max then
              begin
                newc := fContained;
                max  := Left + Width;
              end;
    end;

  if (newc <> nil) and CanBeSelected(newc) then
    SelectComponent(newc);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.MoveSelectionRight;
var
  c     : TComponent;
  min   : integer;
  newc  : TComponent;
  i     : integer;
  right : integer;
  pcontrol  : TWinControl;
  cx        : integer;
  container : TComponentContainer;

begin
  if SelectedComponents.Count = 0 then
    exit;

  c := SelectedComponents[0];
  if c is TControl then
    with TControl(c) do
      begin
        pcontrol := Parent;
        right := Left + Width;
      end
  else
    begin
      container := GetContainer(c);
      if container = nil then
        exit;
      cx := container.Left;
      pcontrol := form;
      right := cx + ContainerSize;
    end;

  min := 100000;
  newc := nil;

  with pcontrol do
    begin
      for i := 0 to ControlCount - 1 do
        begin
          with Controls[i] do
            if Left  > right then
              if left < min then
                begin
                  newc := Controls[i];
                  min  := left;
                end;

        end;

        for i := 0 to fContainers.Count - 1 do
          with TComponentContainer(fContainers[i]) do
          if Left  > right then
            if left < min then
              begin
                newc := fContained;
                min  := left;
              end;
    end;

  if (newc <> nil) and CanBeSelected(newc) then
    SelectComponent(newc);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.ValidateRename(AComponent: TComponent; const CurName, NewName: string);
var
  container : TComponentContainer;
  NotEmpty  : boolean;
begin
  if OwnerControl.ComponentState * [csLoading, csReading, csDestroying] <> [] then
    exit;

  if (CurName = '') and (NewName = '') then
    exit;

  NotEmpty := (CurName <> '') and (NewName <> '');

  if (CodeDesigner <> nil) and not (AComponent is TDataModuleNotifier) then
    with CodeDesigner do
      begin
        If (NewName <> '') and not ValidIdentifier(NewName) then
          ErrorFmt(SNotValidIdent,[NewName]);

        if AComponent = nil then
          begin
            if NewName='' then
              dcdreamLib.Error(SErrFormNameEmpty);
              
            RenameComponent(OwnerControl, NewName);
          end
        else
          begin
            if NotEmpty then
              RenameComponent(AComponent, NewName)
            else if CurName = '' then
              InsertComponent(AComponent, NewName)
            else
              DeleteComponent(AComponent)
          end;
      end;

  RenameEventsForComp(AComponent, CurName,NewName);

  inherited;

  container := GetContainer(AComponent);
  if Assigned(Container) then
    container.Caption := NewName;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.GetMethodByName(const Name : string) : TMethod;
var
  s : TStringList;
  i : integer;
begin
  s := TStringList.Create;
  with s, Result do
    try
      FillWithEvents(nil, S);
      i := IndexOf(Name);
      if i >= 0 then
        begin
          Code := TAssignedEventInfo(Objects[i]).Code;
          Data := OwnerControl;
        end;
    finally
      FreeStrings(s);
    end;
end;

{------------------------------------------------------------------}

function TDCFormDesigner.CreateMethod(const Name: string; TypeData: PTypeData): TMethod;
var
  EvName : string;
  i      : integer;
begin
  Result.Code := nil;
  Result.Data := nil;
  EvName := Trim(Name);

  if EvName = '' then
    begin
      fMethodDeleted := true;
      exit;
    end;

  fMethodCreated := true;
  fMethodTypeData := TypeData;
  fCreatedMethodName := EvName;

  with FCompFiler.EventNames, Result do
    begin
      i := IndexOf(EvName);
      if i >= 0 then
        begin
          Code := Pointer(Integer(Objects[i]));
          Data := OwnerControl;
          exit;
        end;
    end;

  if Assigned(FCodeDesigner) then
    begin
      if not FCodeDesigner.MethodExists(EvName) then
        FCodeDesigner.CreateMethod(EvName, TypeData);

      Result.Code := Pointer(FCompFiler.AddEvent(EvName));
      Result.Data := OwnerControl;
    end
  else
    result := GetMethodByName(EvName);
end;

{------------------------------------------------------------------}

function TDCFormDesigner.MethodExists(const Name: string): Boolean;
begin
  if Assigned(FCodeDesigner) then
    Result := FCodeDesigner.MethodExists(Name)
  else
    result := FCompFiler.EventNames.IndexOf(Trim(Name)) >= 0;
end;

{------------------------------------------------------------------}

function  TDCFormDesigner.GetMethodName(const Method : TMethod): string;
begin
  result := inherited GetMethodName(Method);
  if result = '' then
    result := FCompFiler.EventNameByID(integer(Method.Code));
end;

{------------------------------------------------------------------}

{function TDCFormDesigner.AddEvent(Const EvName:String):Integer;
var
  i : integer;
begin
  for i := 0 to FEventNames.Count - 1 do
    if CompareText(FEventNames[i], EvName) = 0 then
    begin
      result:=integer(FEventNames.Objects[i]);
      exit;
    end;
  FEventNames.AddObject(EvName, pointer(fEventID));
  result := fEventID;
  inc(fEventID);
end;}

{------------------------------------------------------------------}

function ParametersListMatchTypeData(Parameters : array of string; TypeData : PTypeData) : boolean;
var
  pcount : integer;
  p      : pchar;
  i      : integer;
  TypeName : string;
begin
  result := true;
  if TypeData = nil then
    exit;

  pcount := High(Parameters) - Low(Parameters) + 1;

  if TypeData.ParamCount <> pcount then
    begin
      result := false;
      exit;
    end;

  p := @TypeData^.ParamList;

  for i := 0 to pcount - 1 do
    begin
      // TParamFlags(p1^);
      inc(p);

      PReadShortStr(p); // ParamName
      TypeName := PReadShortStr(p);

      if CompareText(TypeName, Parameters[Low(Parameters) + i]) <> 0 then
        begin
          result := false;
          exit;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.FillWithEvents(TypeData : PTypeData; S : TStrings);

  procedure AddComponentEvents(C : TComponent);
  var
    P       : PPropList;
    NCount  : integer;
    PCount  : integer;
    i       : integer;
    TempStr : string;
    MProp   : TMethod;
    info    : TAssignedEventInfo;

  begin
    PCount := GetTypeData(C.ClassInfo).PropCount;
    GetMem(P, PCount * SizeOf(PPropInfo));
    try
      NCount := GetPropList(C.ClassInfo, tkmethods, P);
      for i := 0 to NCount - 1 do
        if (TypeData = nil) or EqualMethodTypeData(GetTypeData(GetPTypeInfo(P[i])), TypeData) then
          begin
            MProp := GetMethodProp(C, P[i]);
            TempStr := GetMethodName(MProp);
            if TempStr <> '' then
              begin
                info := TAssignedEventInfo.Create;
                info.Code := MProp.Code;
                info.Instance := c;
                info.Event := p[i]^.Name;
                S.AddObject(TempStr, info);
              end;
          end;
    finally
      FreeMem(P);
    end;
  end;

var
  i : integer;
  SUser : TStringList;
  info  : TAssignedEventInfo;
begin
  AddComponentEvents(OwnerControl);

  with OwnerControl do
    for i := 0 to ComponentCount - 1 do
      AddComponentEvents(Components[i]);

  if Assigned(OnGetEventsList) then
    begin
      SUser := TStringList.Create;
      try
        OnGetEventsList(self, TypeData, SUser);
        for i := 0 to SUser.Count - 1 do
          begin
            info := TAssignedEventInfo.Create;
            info.Code := SUser.Objects[i];
            info.Instance := nil;
            info.Event := SUser[i];
            SUser.Objects[i] := info;
          end;

        S.AddStrings(SUser);
      finally
        SUser.Free;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.GetMethods(TypeData: PTypeData; Proc: TGetStrProc);
var
  S : TStringList;
begin
  S := TStringList.Create;
  with S do
    try
      Sorted := true;
      Duplicates := dupIgnore;

      if Assigned(fCodeDesigner) then
        fCodeDesigner.GetMethods(TypeData, S)
      else
        FillWithEvents(TypeData, S);

      StringsToProc(S, Proc);
    finally
      FreeStrings(S);
    end;
end;

{------------------------------------------------------------------}

var
  _designer : TDCFormDesigner;

function _IsStoredPropDes(Instance: TObject; PropInfo: PPropInfo) : Boolean;
begin
  _designer.UnHookIsStored;
  try
    result := IsStoredProp(Instance, PropInfo);
  finally
    _designer.HookIsStored;
  end;

  _designer.NeedStoreProp(Instance, PropInfo, result);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.NeedStoreProp(Instance : TObject; PropInfo : PPropInfo; var Store : boolean);
begin
  if Assigned(OnStoreProp) then
    OnStoreProp(self, Instance, PropInfo.Name, Store);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.HookIsStored;
var
  p : pchar;
  newcode : array[0..4] of byte;
  i : DWORD;
begin
  if fHookIsStoredCount = 0 then
    begin
      p := IsStoredPropAddr;
      move(p^, saveisstored, 5);
      newcode[0] := $E9;
      PInteger(@newcode[1])^ := integer(@_IsStoredPropDes) - integer(IsStoredPropAddr) - 5;
      WriteProcessMemory(GetCurrentProcess, IsStoredPropAddr, @(newcode[0]), 5, i);
    end;
  inc(fHookIsStoredCount);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.UnHookIsStored;
var
  i : DWORD;
begin
  dec(fHookIsStoredCount);
  if fHookIsStoredCount = 0 then
    WriteProcessMemory(GetCurrentProcess, IsStoredPropAddr, @(saveisstored[1]), 5, i);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.BeforeSave;
begin
  if form is TDataModuleWrapper then
    FreeObject(TDataModuleWrapper(form).fNotifier,TDataModuleWrapper(form).fNotifier);

  if Assigned(Scripter) then
    Scripter.BeginDesign;

  FCompFiler.BeginTrick(OwnerControl, false);
  HookIsStored;
  _designer := self;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.AfterSave;
begin
  UnHookIsStored;

  if form is TDataModuleWrapper then
    TDataModuleWrapper(form).CreateNotifier;

  FCompFiler.EndTrick(OwnerControl);

  if Assigned(Scripter) then
    Scripter.EndDesign;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SaveFormToStream(Stream : TStream; WriteAsRes : boolean);
Var
  Ancestor : TComponent;
  cowner   : TComponent;

  procedure _SaveToStream(S : TStream);
  begin
    with S do
      if WriteAsRes then
        WriteDescendentRes(ClassPrefix + cOwner.Name, cOwner, Ancestor)
      else
        WriteDescendent(cOwner, Ancestor);
  end;
var
  TempStream : TStream;
begin
  Ancestor := nil;
  cowner := OwnerControl;

  if UseAncestor then
    if Assigned(FGetAncestorEvent) then
      FGetAncestorEvent(Self, Ancestor)
    else if GetFormResourceHandler(cOwner.ClassType) <> 0 then
      Ancestor := TComponentClass(cOwner.ClassType).Create(nil);

  BeforeSave;
  try
    fInSave := true;
    if SaveDesignedFormsAsText then
      begin
        WriteAsRes := False;
        Ancestor := nil;
        TempStream := TMemoryStream.Create;
        try
          _SaveToStream(TempStream);
          TempStream.Seek(0, 0);
          ObjectBinaryToText(TempStream, Stream);
        finally
          TempStream.Free;
        end
      end
    else
      _SaveToStream(Stream);

  finally
    Ancestor.Free;
    AfterSave;
    fInSave := false;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.CMPALETTECLICK(Var M:TMessage);
begin
  If not AnswerMessage then
    exit;
  If ssDouble in TShiftState(Byte(M.lParam)) then
  begin
    InstantInsertComponent(String(M.wParam));
    DesignerInsertClass:='';
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SaveFormToFile(Const FileName : TFileName);
Var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveFormToStream(Stream,True);
  finally
    Stream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.SaveComponentToStream(Instance : TComponent; S : TStream);
var
  cowner : TComponent;
begin
  with CompFiler do
    begin
      cowner := OwnerControl;
      with TWriter.Create(S, 4096) do
        try
          BeforeSave;
          Root := cowner;
          WriteComponent(Instance);
        finally
          Free;
          AfterSave;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.GetComponentNameProc(const ComponentName : string);
var
  comp : TComponent;
begin
  comp := OwnerControl.FindComponent(ComponentName);
  if ActionAllowed(comp, atShow) then
    fGetCompNamesProc(ComponentName);
end;

{------------------------------------------------------------------}

procedure TDCFormDesigner.GetComponentNames(TypeData: PTypeData; Proc: TGetStrProc);

  procedure GetAutoNames;
  Var
    TempList:TList;
  begin
    TempList:=TList.Create;
    try
      GetUsedModules(GetOwnerControl,TempList);
      CompListNamesToProc(TempList,GetOwnerControl, TypeData, GetComponentNameProc);
    finally
      TempList.Free;
    end;
  end;

begin
  fGetCompNamesProc := Proc;
  CompNamesToProc(GetOwnerControl, GetOwnerControl, TypeData, GetComponentNameProc);

  GetAutoNames;

  CompListNamesToProc(fUsedModules,GetOwnerControl, TypeData, GetComponentNameProc);

  If Assigned(FOnGetCompNames) then
    FOnGetCompNames(Self, TypeData, Proc);
end;

{******************************************************************}

type
  TMForm = class(TCustomForm);

procedure CenterDesignedForm(F:TCustomForm;const ACaption:String);
begin
  With TMForm(F) do
  begin
    Caption := ACaption;
    Position:=poScreenCenter;
    Width:=cFormWidth;
    Height:=cFormHeight;
    Show;
    Position:=poDesigned;
    SetDesign(F, true);
    Visible:=False;
  end;
end;

{--------------------------------------------}

procedure AlignControls (Controls : TList; XAlign, YAlign : TAlignControls);
var
  i       : integer;
  xcenter : integer;
  ycenter : integer;
  deltax  : integer;
  deltay  : integer;
  spacex  : integer;
  spacey  : integer;
  start   : integer;
  cparent : TControl;
  xctrls  : TStringList;
  yctrls  : TStringList;
  minx    : integer;
  maxx    : integer;
  miny    : integer;
  maxy    : integer;

  function mIntToStr (Num : integer) : string;
    begin
      Str (Num : 5, Result);
    end;

begin
  if (Controls.Count = 0) then
    exit;

  deltax  := 0;
  deltay  := 0;
  spacex  := 0;
  spacey  := 0;
  cParent := TControl(Controls[0]).Parent;

  if (XAlign = acCenterInWindow) or (YAlign = acCenterInWindow) then
    begin
      with TControl(Controls[0]) do
        begin
          minx := Left;
          maxx := Left + Width;
          miny := Top;
          maxy := Top + Height;
        end;

      for i := 1 to Controls.Count - 1 do
        with TControl(Controls[i]) do
          begin
            if minx > Left then
              minx := Left;

            if maxx < Left + Width then
              maxx := Left + Width;

            if miny > Top then
              miny := Top;

            if maxy < Top + Height then
              maxy := Top + Height;
          end;

      deltax := ((CParent.ClientWidth - (maxx - minx)) div 2) - minx;
      deltay := ((CParent.ClientHeight - (maxy - miny)) div 2) - miny;
    end;

  if (XAlign = acSpaceEqually) or (YAlign = acSpaceEqually) then
    begin
      xcenter := 0;
      ycenter := 0;

      for i := 0 to Controls.Count - 1 do
        with TControl(Controls[i]) do
          begin
            if Parent <> CParent then
              exit;
            inc(xcenter, Left + (Width div 2));
            inc(ycenter, Top + (Height div 2));
            inc(spacex, width);
            inc(spacey, height);
          end;

      xcenter := xcenter div Controls.Count;
      ycenter := ycenter div Controls.Count;
      deltax  := (CParent.ClientWidth div 2)  - xcenter;
      deltay  := (CParent.ClientHeight div 2) - ycenter;
    end;

  if (XAlign = acSpaceEqually) or (YAlign = acSpaceEqually) then
    begin
      xctrls := TStringList.Create;
      yctrls := TStringList.Create;
      for i := 0 to Controls.Count - 1 do
        with TControl(Controls[i]) do
          begin
            xctrls.AddObject(mIntToStr(Left), Controls[i]);
            yctrls.AddObject(mIntToStr(Top) , Controls[i]);
          end;
      xctrls.Sort;
      yctrls.Sort;

    if Controls.Count > 1 then
      begin
        if XAlign = acSpaceEqually then
          try
            dec(spacex, TControl(xctrls.Objects[xctrls.Count - 1]).width);
            dec(spacex, TControl(xctrls.Objects[0]).width);
            deltax := TControl(xctrls.Objects[xctrls.Count - 1]).left - TControl(xctrls.Objects[0]).left -
                      TControl(xctrls.Objects[0]).width;
            deltax := (deltax - spacex) div (xctrls.Count - 1);
            start := TControl(xctrls.Objects[0]).left;
            for i := 0 to xctrls.Count - 1 do
              with TControl(xCtrls.Objects[i]) do
                begin
                  left := start;
                  inc(start, width + deltax);
                end;
          finally
            xCtrls.Free;
          end;

        if YAlign = acSpaceEqually then
          try
            dec(spacey, TControl(yctrls.Objects[yctrls.Count - 1]).height);
            dec(spacey, TControl(yctrls.Objects[0]).height);
            deltay := TControl(yctrls.Objects[yctrls.Count - 1]).top - TControl(yctrls.Objects[0]).top -
                      TControl(yctrls.Objects[0]).height;
            deltay := (deltay - spacey) div (yctrls.Count - 1);
            start := TControl(yctrls.Objects[0]).Top;
            for i := 0 to yctrls.Count - 1 do
              with TControl(yCtrls.Objects[i]) do
                begin
                  top := start;
                  inc(start, height + deltay);
                end;
          finally
            yCtrls.Free;
          end;
        end;
      end;

  for i := 0 to Controls.Count - 1 do
    with TControl(Controls[i]) do
      begin
        case XAlign of
          acLefts   : Left := TControl(Controls[0]).Left;
          acCenters : Left := TControl(Controls[0]).Left + (TControl(Controls[0]).width - width) div 2;
          acRights  : Left := TControl(Controls[0]).Left + TControl(Controls[0]).width - width;
          acCenterInWindow : Left := Left + deltax;
        end;

        case YAlign of
          acTops    : Top  := TControl(Controls[0]).Top;
          acCenters : Top  := TControl(Controls[0]).Top  + (TControl(Controls[0]).height - height) div 2;
          acBottoms : Top  := TControl(Controls[0]).Top  + TControl(Controls[0]).height - height;
          acCenterInWindow : Top := Top + deltay;
        end;
      end;
end;

{------------------------------------------------------------------}

procedure SizeControls  (Controls : TList; XSize, YSize  : integer);

  procedure _updatesize(var nsize : integer; asize : integer; SizeMode : integer);
  begin
    if ((asize > nsize) and (SizeMode = scGrowToLargest)) or
       ((asize < nsize) and (SizeMode = scShrinkToSmallest)) then
      nsize := asize;
  end;

var
  i : integer;
  newsizex : integer;
  newsizey : integer;
begin
  if Controls.Count = 0 then
    exit;

  if (Controls.Count < 2) then
    begin
      if (XSize > 0) then
        TControl(Controls[0]).Width := XSize;

      if (YSize > 0) then
        TControl(Controls[0]).Height := YSize;

      exit;
    end;

  if (XSize > 0) then
    newsizex := XSize
  else
    newsizex := TControl(Controls[0]).Width;

  if (YSize > 0) then
    newsizey := YSize
  else
    newsizey := TControl(Controls[0]).Height;

  for i := 0 to Controls.Count - 1 do
    begin
      if (XSize < 0) then
        _updatesize(newsizex, TControl(Controls[i]).Width, XSize);

      if (YSize < 0) then
        _updatesize(newsizey, TControl(Controls[i]).Height, YSize);
    end;

  for i := 0 to Controls.Count - 1 do
    with TControl(Controls[i]) do
      begin
        if XSize <> scNoChange then
          Width := newsizex;

        if YSize <> scNoChange then
          Height := newsizey;
      end;
end;

{------------------------------------------------------------------}

var
  CaptionWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'ComponentCaption');//don't resource

procedure CreateCaptionWnd (WndProc: TWndMethod; var wnd : THandle);
var
  TempClass       : TWndClass;
  ClassRegistered : Boolean;
begin
  CaptionWindowClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo (HInstance, CaptionWindowClass.lpszClassName,
    TempClass);
  if not ClassRegistered then
    Windows.RegisterClass(CaptionWindowClass);

  wnd := CreateWindowEx(WS_EX_TOPMOST, CaptionWindowClass.lpszClassName,
                          '', WS_POPUP, 0, 0, 1, 1, 0, 0, HInstance, nil);

  SetWindowLong(wnd, GWL_WNDPROC, Longint(
    {$IFDEF D6}
    Classes.MakeObjectInstance(WndProc)
    {$ELSE}
    MakeObjectInstance(WndProc)
    {$ENDIF}
  ));
  SetWindowLong(wnd, GWL_STYLE, WS_CHILD);
end;

{------------------------------------------------------------------}

constructor TComponentContainerCaption.Create;
begin
  inherited Create;
  CreateCaptionWnd (WndProc, fwnd);
end;

{------------------------------------------------------------------}

destructor  TComponentContainerCaption.Destroy;
begin
  Forms.DeallocateHWnd(fWnd);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TComponentContainerCaption.WndProc(var Msg: TMessage);
begin
  if Assigned(fContainer) then
    if fContainer.DesignerMessage(Msg) then
      exit;

  with Msg do
    begin
      result := 0;

      if Msg = WM_ERASEBKGND then
        result := 0
      else
        Result := CallWindowProc(@DefWindowProc, fWnd, Msg, WParam, LParam);

      if Msg = WM_PAINT then
        Paint;
    end;
end;

{------------------------------------------------------------------}

procedure TComponentContainerCaption.Paint;
var
  ARect : TRect;
  dc    : THandle;
  savefont : THandle;
begin
   dc := GetDC(fWnd);
   GetClientRect(fwnd, ARect);
   SetBkColor(dc, ColorToRGB(fColor));
   savefont := SelectObject(dc, GetStockObject(ANSI_VAR_FONT));
   ExtTextOut(dc, 0, 2, ETO_CLIPPED or ETO_OPAQUE, @ARect,
              PChar(fText), length(fText), nil);
   SelectObject(dc, savefont);
   ReleaseDC(fWnd, dc);

end;

{------------------------------------------------------------------}

function TComponentContainerCaption.GetWidth: Integer;
var
  dc       : THandle;
  size     : TSize;
  savefont : THandle;
begin
  dc := GetDC(fWnd);
  savefont := SelectObject(dc, GetStockObject(ANSI_VAR_FONT));
  GetTextExtentPoint32(dc, @(fText[1]), length(fText), Size);
  SelectObject(dc, savefont);
  ReleaseDC(fWnd, DC);
  Result := size.cx;
end;

{------------------------------------------------------------------}

function TComponentContainerCaption.GetHeight: Integer;
var
  dc       : THandle;
  size     : TSize;
  savefont : THandle;
begin
  dc := GetDC(fWnd);
  savefont := SelectObject(dc, GetStockObject(ANSI_VAR_FONT));
  GetTextExtentPoint32(dc, @(fText[1]), length(fText), Size);
  SelectObject(dc, savefont);
  ReleaseDC(fWnd, DC);
  Result := size.cy + 4;
end;

{------------------------------------------------------------------}

procedure TComponentContainerCaption.SetText(const val : string);
begin
  fText := val;
end;

{******************************************************************}

var
  ContainWindowClass: TWndClass = (
    style: CS_DBLCLKS;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'ComponentContainer');//don't resource

{------------------------------------------------------------------}

procedure CreateContainWnd (WndProc: TWndMethod; var wnd : THandle);
var
  TempClass       : TWndClass;
  ClassRegistered : Boolean;
begin
  ContainWindowClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo(HInstance, ContainWindowClass.lpszClassName,
    TempClass);
  if not ClassRegistered then
    Windows.RegisterClass(ContainWindowClass);

  wnd := CreateWindowEx(WS_EX_TOPMOST, ContainWindowClass.lpszClassName,
                          '', WS_POPUP, 0, 0, 1, 1, 0, 0, HInstance, nil);

  SetWindowLong(wnd, GWL_WNDPROC, Longint(
    {$IFDEF D6}
    Classes.MakeObjectInstance(WndProc)
    {$ELSE}
    MakeObjectInstance(WndProc)
    {$ENDIF}
  ));
  SetWindowLong(wnd, GWL_STYLE, WS_CHILD);
end;

{------------------------------------------------------------------}

procedure TComponentContainer.Show;
var
  delta : integer;
begin
  SetWindowPos(fWnd, HWND_TOP, Left, Top,
               ContainerSize, ContainerSize, SWP_SHOWWINDOW);
  if fShowCaption then
    begin
      delta := (fCaption.Width - ContainerSize) div 2;
      SetWindowPos(fCaption.Handle, HWND_TOP, Left - delta, Top + ContainerSize + 2,
                   fCaption.width, fCaption.height, SWP_SHOWWINDOW);
    end
  else
    ShowWindow(fCaption.Handle, SW_HIDE);

  if fShowHandles then
    fHandles.ResetPosition;
end;

{------------------------------------------------------------------}

function TComponentContainer.DesignerMessage(var Msg : TMessage) : boolean;
var
  Form : TCustomForm;
begin
  if Assigned(fParent) and Assigned(fContained) then
    begin
      Form := GetRealParentForm(fParent);
      if (Form <> nil) and (Form.Designer <> nil) and
         not (IsPosChangeMessage(Msg, nil) or IsPosChangedMessage(Msg)) and
        Form.Designer.IsDesignMsg(TControl(fContained), Msg) then
          begin
            result := true;
            exit;
          end;
    end;

  result := false;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.WndProc(var Msg: TMessage);
begin
  if DesignerMessage(Msg) then
    exit;

  with Msg do
    begin
      result := 0;

      if Msg = WM_ERASEBKGND then
        result := 0
      else
        Result := CallWindowProc(@DefWindowProc, fWnd, Msg, WParam, LParam);

      if Msg = WM_PAINT then
        Paint;

      if (Msg = WM_MOVE) and Assigned(fContained) then
        fContained.DesignInfo := lParam;
    end;
end;

{------------------------------------------------------------------}

constructor TComponentContainer.Create;
begin
  inherited Create;
  CreateContainWnd (WndProc, fwnd);
  fCanvas:= TCanvas.Create;
  fbut   := TComponentContainerSpeedButton.Create(nil);
  with fbut do
    begin
      Container := self;
      Width   := ContainerSize;
      Height  := ContainerSize;
      visible := false;
    end;
  fshowhandles := false;
  fGrayHandles := false;
  fCaption := TComponentContainerCaption.Create;
  fCaption.fContainer := self;
end;

{------------------------------------------------------------------}

destructor TComponentContainer.Destroy;
begin
  if fshowhandles then
    fHandles.Free;
  fCanvas.Free;
  fCaption.Free;
  fBut.Free;
  Forms.DeallocateHWnd(fWnd);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetParent(val : TWinControl);
begin
  fParent := val;
  windows.SetParent(fWnd, val.Handle);
  windows.SetParent(fCaption.Handle, val.Handle);
  fCaption.Color := TMWinControl(val).Color;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetPosition;
var
  Wrapper : TComponent;
begin
  fbut.left := left;
  fbut.top  := top;

  if fContained.Owner is TDataModule then
    begin
      Wrapper := GetDataModuleWrapper(TDataModule(fContained.Owner));
      if Wrapper is TDataModuleWrapper then
        TDataModuleWrapper(Wrapper).UpdateScrollBars;
    end;

  Show;
  if fShowHandles then
    fHandles.ResetPosition;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetContained(val : TComponent);
begin
  fcontained := val;
  fCaption.Text := val.Name;
  SetPosition;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetGlyph(val : TBitmap);
begin
  fbut.Glyph := val;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.Paint;
var
  dc : THandle;
begin
  dc := GetDC(fWnd);
  fCanvas.Handle := dc;
  if Glyph.Handle = 0 then
    begin
      SelectObject (dc, GetStockObject(GRAY_BRUSH));
      PatBlt (dc, 0, 0, ContainerSize, ContainerSize, PATCOPY);
    end
  else
    begin
      fbut.Canvas.Handle := dc;
      fbut.Paint;
    end;

  ReleaseDC(fWnd, dc);
{  if fShowHandles then
    fHandles.Update;}
  if fGrayHandles then
    DrawHandles(true);
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetLeft  (val : integer);
var
  l : longint;
begin
  l := fContained.DesignInfo;
  LongRec(l).Lo := val;
  fContained.DesignInfo := l;
  SetPosition;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetTop   (val : integer);
var
  l : longint;
begin
  l := fContained.DesignInfo;
  LongRec(l).Hi := val;
  fContained.DesignInfo := l;
  SetPosition;
end;

{------------------------------------------------------------------}

function TComponentContainer.GetLeft : integer;
begin
  result := SmallInt(LongRec(fContained.DesignInfo).Lo);
end;

{------------------------------------------------------------------}

function TComponentContainer.GetTop : integer;
begin
  result := SmallInt(LongRec(fContained.DesignInfo).Hi);
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetTopLeft(val : TPoint);
var
  l : longint;
begin
  l := fContained.DesignInfo;
  LongRec(l).Lo := val.X;
  LongRec(l).Hi := val.Y;
  fContained.DesignInfo := l;
  SetPosition;
end;

{------------------------------------------------------------------}

function  TComponentContainer.GetTopLeft : TPoint;
begin
  result := Point(Left, Top);
end;

{------------------------------------------------------------------}

function TComponentContainer.GetGlyph : TBitmap;
begin
  result := fbut.Glyph;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.DrawHandles(visible : boolean);
var
  dc : THandle;

  procedure DrawHandle (X, Y : Integer);
  var
    Rect : tRect;
  begin
    if Visible then
      PatBlt (DC, X, Y, HandleSize, HandleSize, PATCOPY)
    else
      begin
        Rect := Bounds (X, Y, HandleSize, HandleSize);
        InValidateRect (fwnd, @Rect, True);
      end;
  end;

begin
  dc := GetDC(fwnd);
  if visible then
    SelectObject (dc, GetStockObject(GRAY_BRUSH));

  DrawHandle(0, 0);
  DrawHandle((ContainerSize - HandleSize) div 2, 0);
  DrawHandle( ContainerSize - HandleSize, 0);

  DrawHandle (0, (ContainerSize - HandleSize) div 2);
  DrawHandle (ContainerSize - HandleSize, (ContainerSize - HandleSize) div 2);

  DrawHandle (0, ContainerSize - HandleSize);
  DrawHandle ((ContainerSize - HandleSize) div 2, ContainerSize - HandleSize);
  DrawHandle (ContainerSize - HandleSize, ContainerSize - HandleSize);

  ReleaseDC(fwnd, dc);
  fGrayHandles := visible;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.ShowHandles;
begin
  if fShowHandles then
    exit;

  fbut.Parent := Parent;
  fHandles := TControlHandles.Create(nil);
  fHandles.ParentControl := fbut;
  fHandles.Visible := true;
  fHandles.CanBeSized := false;
  fShowHandles := true;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.HideHandles;
begin
  if not fShowHandles then
    exit;

  fHandles.Free;
  fShowHandles := false;
  fbut.Parent := nil;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetShowCaption(val : boolean);
begin
  if val = fShowCaption then
    exit;

  fShowCaption := val;
  SetPosition;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetCaption(const val : string);
begin
  if val = fCaption.Text then
    exit;

  fCaption.Text := val;
  SetPosition;
  InvalidateRect(fCaption.Handle, nil, true);
end;

{------------------------------------------------------------------}

function  TComponentContainer.GetCaptionColor : TColor;
begin
  result := fCaption.Color;
end;

{------------------------------------------------------------------}

procedure TComponentContainer.SetCaptionColor(val : TColor);
begin
  fCaption.color := val;
  if fShowCaption then
    InvalidateRect(fCaption.Handle, nil, true);
end;

{------------------------------------------------------------------}

function TComponentContainer.GetHeight : integer;
begin
  result := ContainerSize;
end;

{------------------------------------------------------------------}

function TComponentContainer.GetWidth : integer;
begin
  result := ContainerSize;
end;

{------------------------------------------------------------------}

type
  TCHandle = class(TObject)
  private
    fPosition  : THandlePosition;
    fActive    : boolean;
    fParentControl : TControl;
    fShowMode  : TCHShowMode;
    fCanBeSized : boolean;
    fsizing : boolean;
    fWnd  : THandle;
    fCursor : TCursor;
    parent : TWinControl;

    fOnStartSizeChanging : TStartSizeChangeProc;
    fOnSizeChanging : TSizeChangeProc;
    fOnSizeChanged : TSizeChangeProc;
    fOnCancelSizing : TNotifyEvent;

    procedure Paint;
    procedure ResetPosition;
  protected
    procedure WndProc(var Msg: TMessage);
    procedure SetPosition (val : THandlePosition);
    procedure SetActive (val : boolean);
    procedure SetParentControl (val : TControl);
    procedure SetShowMode (val : TCHShowMode);
    procedure MouseDown (Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
    procedure MouseUp   (Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
    procedure MouseMove (Shift: TShiftState; X, Y: Integer);

  public
    constructor Create;
    destructor  Destroy; override;
    procedure   Hide;
    procedure   Show;
    procedure   Update;

    property Position : THandlePosition read fPosition write SetPosition;
    property Active : boolean read fActive write setActive;
    property ParentControl : TControl read fParentControl write SetParentControl;
    property ShowMode : TCHShowMode read fShowMode write SetShowMode;
    property CanBeSized : boolean read fCanBeSized write fCanBeSized;
    property OnStartSizeChanging : TStartSizeChangeProc read fOnStartSizeChanging write fOnStartSizeChanging;
    property OnSizeChanging : TSizeChangeProc read fOnSizeChanging write fOnSizeChanging;
    property OnSizeChanged : TSizeChangeProc read fOnSizeChanged write fOnSizeChanged;
    property OnCancelSizing : TNotifyEvent read fOnCancelSizing write fOnCancelSizing;
  end;


const cursors : array [hpFirst .. hpLast] of TCursor =
            (crSizeNWSE, crSizeNS, crSizeNESW,
             crSizeWE,             crSizeWE,
             crSizeNESW, crSizeNS, crSizeNWSE);

{******************************************************************}
var
  HandleWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TCHandle');//don't resource

procedure CreateHandleWnd (WndProc: TWndMethod; var wnd : THandle);
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
begin
  HandleWindowClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo(HInstance, HandleWindowClass.lpszClassName,
    TempClass);

  if not ClassRegistered then
    Windows.RegisterClass(HandleWindowClass);

  wnd := CreateWindowEx(WS_EX_TOPMOST, HandleWindowClass.lpszClassName,
                          '', WS_POPUP, 0, 0, 1, 1, 0, 0, HInstance, nil);

  SetWindowLong(wnd, GWL_WNDPROC, Longint(
    {$IFDEF D6}
    Classes.MakeObjectInstance(WndProc)
    {$ELSE}
    MakeObjectInstance(WndProc)
    {$ENDIF}
  ));
  SetWindowLong(wnd, GWL_STYLE, WS_CHILD);
end;


{------------------------------------------------------------------}

procedure TCHandle.WndProc(var Msg: TMessage);
var
  Form : TCustomForm;
begin
  if Assigned(fParentControl) and not fsizing and not (Msg.Msg = WM_LBUTTONDOWN) then
    begin
      Form := GetRealParentForm(fParentControl);
      if (Form <> nil) and (Form.Designer <> nil) and
         not (IsPosChangeMessage(Msg, nil) or IsPosChangedMessage(Msg)) then
        if Form.Designer.IsDesignMsg(fParentControl, Msg) then
          exit;
    end;

  with Msg do
    begin
      result := 0;
      case Msg of
        WM_LBUTTONDOWN : MouseDown(mbLeft,  KeysToShiftState(wParam), SMALLINT(LOWORD(lPAram)), SMALLINT(HIWORD(lPAram)));
        WM_RBUTTONDOWN : MouseDown(mbRight, KeysToShiftState(wParam), SMALLINT(LOWORD(lPAram)), SMALLINT(HIWORD(lPAram)));
        WM_LBUTTONUP   : MouseUp  (mbLeft,  KeysToShiftState(wParam), SMALLINT(LOWORD(lPAram)), SMALLINT(HIWORD(lPAram)));
        WM_RBUTTONUP   : MouseUp  (mbRight, KeysToShiftState(wParam), SMALLINT(LOWORD(lPAram)), SMALLINT(HIWORD(lPAram)));
        WM_MOUSEMOVE   : MouseMove(KeysToShiftState(wParam), SMALLINT(LOWORD(lPAram)), SMALLINT(HIWORD(lPAram)));
        WM_SETCURSOR   : if CanBeSized and (ShowMode <> smInvisible) then
                           SetCursor(Screen.Cursors[fCursor]);
        WM_ERASEBKGND  : Result := 0;
        WM_PAINT       : Paint;
        else
          Result := CallWindowProc(@DefWindowProc, fWnd, Msg, WParam, LParam);
      end;
    end;
end;

{------------------------------------------------------------------}

constructor TCHandle.Create;
begin
  inherited Create;
  fCanBeSized := true;
  fShowMode := smInvisible;
  fActive := true;
  CreateHandleWnd (WndProc, fwnd);
end;

{------------------------------------------------------------------}

destructor  TCHandle.Destroy;
begin
  Forms.DeallocateHWnd(fWnd);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TCHandle.Paint;
var
  Handle : THandle;
  PS     : TPaintStruct;
begin
  Handle := BeginPaint(fWnd, PS);
    case fShowMode of
     smActive : begin
                  SelectObject (Handle, GetStockObject(BLACK_BRUSH));
                  PatBlt (Handle, 0, 0, HandleSize, HandleSize, PATCOPY);
                end;

     smGrayed : begin
                  SelectObject (Handle, GetStockObject(GRAY_BRUSH));
                  PatBlt (Handle, 0, 0, HandleSize, HandleSize, PATCOPY);
                end;

     smInActive : begin
                    SelectObject (Handle, GetStockObject(GRAY_BRUSH));
                    SelectObject (Handle, GetStockObject(BLACK_PEN));
                    windows.Rectangle(Handle, 0, 0, HandleSize, HandleSize);
                  end;
     smInvisible :
    end;
  EndPaint(fWnd, PS);
end;

{------------------------------------------------------------------}

procedure TCHandle.SetPosition (val : THandlePosition);
begin
  if val <> fPosition then
    begin
      fPosition := val;
      fCursor := cursors[val];
    end;
end;

{------------------------------------------------------------------}

procedure TCHandle.Hide;
begin
  if IsWindow(fWnd) then
    ShowWindow(fWnd, SW_HIDE);
end;

{------------------------------------------------------------------}

procedure TChandle.Show;
begin
  ShowWindow(fWnd, SW_SHOW);
end;

{------------------------------------------------------------------}

procedure TCHandle.SetActive (val : boolean);
begin
  if val <> fActive then
    begin
      fActive := val;
    end;
end;

{------------------------------------------------------------------}

procedure TCHandle.SetShowMode (val : TCHShowMode);
var
  r     : TRect;
begin
  if (fParentControl = nil) or (fParentControl.Parent = nil) then
    exit;

  if val <> fShowMode then
    begin
      fShowMode := val;
      r := Rect(0, 0, HandleSize, HandleSize);
      InValidateRect(fwnd, @r,  true);
      fparentControl.Update;
      fParentControl.Parent.Update;

      if val in [smInActive, smInvisible] then
        begin
          canbesized := false;
          fCursor    := crDefault;
        end
      else
        begin
          canbesized := true;
          fCursor    := Cursors[fPosition];
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TCHandle.SetParentControl (val : TControl);
begin
  if val <> fParentControl then
   begin
     fParentControl := val;
     if val = nil then
       exit;

     Parent := GetRealParentForm(fParentControl);
     if windows.GetParent(fwnd) <> Parent.Handle then
       windows.SetParent(fWnd, Parent.Handle);

     ResetPosition;
   end;
end;

{------------------------------------------------------------------}

procedure TCHandle.ResetPosition;
var
  Center : TPoint;
  p      : TPoint;
  deltay : integer;
  deltax : integer;
  screenparentrect : TRect;
  wcontrol : TControl;
begin
  wcontrol := fParentControl;
  if wcontrol = nil then
    exit;

  if not (wcontrol is TWinControl) then
    wcontrol := wcontrol.Parent;

  if (wcontrol = nil) or not TWinControl(wcontrol).HandleAllocated then
    exit;

  if not isWindowVisible(TWinControl(wcontrol).Handle) then
    begin
      Hide;
      exit;
    end;
    
  with fParentControl do
    begin
      if ClientHeight <> Height then
        deltay := HandleSize div 2
      else
        deltay := 0;

      if ClientWidth <> Width then
        deltax := HandleSize div 2
      else
        deltax := 0;

      case Position of
        hpTopLeft     : Center := Point (0             , 0);
        hpTop         : Center := Point (Width div 2   , 0);
        hpTopRight    : Center := Point (Width - deltax, 0);
        hpLeft        : Center := Point (0             , Height div 2);
        hpRight       : Center := Point (Width - deltax, Height div 2);
        hpBottomLeft  : Center := Point (0             , Height - deltay);
        hpBottom      : Center := Point (Width div 2   , Height - deltay);
        hpBottomRight : Center := Point (Width - deltax, Height - deltay);
      end;
    end;


  screenparentrect := GetClippingRectangle(fParentControl.Parent);
  InflateRect(screenparentrect, 1, 1);
  if not PtInRect(screenparentrect, fParentControl.ClientToScreen(Center)) then
    Center := Point(-10000, -10000);

  p := Parent.ScreenToClient(fParentControl.ClientToScreen(Point(0, 0)));

  Inc(Center.X, p.x);
  Inc(Center.Y, p.y);

  Dec(Center.X, HandleSize div 2);
  Dec(Center.Y, HandleSize div 2);
//  SetWindowPos(fWnd, HWND_TOP, Center.X, Center.Y, HandleSize, HandleSize, {SWP_NOSIZE + SWP_NOZORDER + SWP_NOACTIVATE +} SWP_SHOWWINDOW);
//  SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW
    SetWindowPos(fWnd, HWND_TOP, Center.X, Center.Y, HandleSize, HandleSize, SWP_SHOWWINDOW);
end;

{------------------------------------------------------------------}

procedure TCHandle.MouseDown(Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
begin
  if CanBeSized then
    begin
      if Assigned(fOnStartSizeChanging) then
        fOnStartSizeChanging(self);

      fsizing := true;
      SetCapture(fWnd);
    end;
end;

{------------------------------------------------------------------}

procedure TCHandle.MouseUp   (Button: TMouseButton;
                                Shift: TShiftState; X, Y: Integer);
begin
  if fSizing then
    begin
      if Assigned(fOnSizeChanged) then
        fOnSizeChanged(self, X, Y);
      fSizing := false;
      ReleaseCapture;
    end;
end;

{------------------------------------------------------------------}

procedure TCHandle.MouseMove (Shift: TShiftState; X, Y: Integer);
var
  pt : TPoint;
begin
  if fSizing then
    if Assigned(fOnSizeChanging) then
      begin
        pt := Point(X, Y);
        windows.ClientToScreen(fWnd, pt);
        fOnSizeChanging(self, pt.X, pt.Y);
      end;
end;

{------------------------------------------------------------------}

procedure TCHandle.Update;
begin
  InvalidateRect(fwnd, nil, true);
  UpdateWindow(fWnd);
end;

{******************************************************************}

constructor TControlHandles.Create (AOwner : TComponent);
var
  hpos : integer;
begin
  inherited Create(AOwner);
  if csDesigning in ComponentState then
    exit;

  for hpos := hpFirst to hpLast do
    begin
      fCHandles[hpos] := TCHandle.Create;
      with TCHandle(fCHandles[hpos]) do
        begin
          Position := hpos;
          OnSizeChanging := OnCHandleSizeChanging;
          OnSizeChanged  := OnCHandleSizeChanged;
          OnStartSizeChanging := OnCHandleStartSizeChanging;
          OnCancelSizing := OnCHandleCancelSizing;
        end;
    end;
  fVisible := false;
  fActive := true;
  fSizing := false;
end;

{------------------------------------------------------------------}
{
procedure TControlHandles.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  If (Operation=opRemove) and (AComponent=FParentControl) then
  begin
    ParentControl:=nil;
  end;
end;
}
{------------------------------------------------------------------}

destructor TControlHandles.Destroy;
var
  hpos : THandlePosition;
begin
  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).Free;

  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TControlHandles.UpdateAll;
begin
  with fParentControl do
    begin
      Parent.Update;
      Update;
    end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.FinishSizing;
var
  hpos : THandlePosition;
begin
  if (self = nil) or not fSizing then
    exit;

  fSizing := false;
  for hpos := hpFirst to hpLast do
    with TCHandle(fCHandles[hpos]) do
      begin
        fsizing := false;
        ReleaseCapture;
      end;

  fDesigner.HideHint;
  DrawClippedSelection(fCurRect, fClipRect);
  RemoveClipping;
  ShowMode := fsaveShowMode;
  UpdateAll;
end;

{------------------------------------------------------------------}

procedure TControlHandles.ResetPosition;
var
  hpos : THandlePosition;
begin
  if (self = nil) or (fParentControl = nil) or not fVisible then
    exit;

  if csDestroying in fParentControl.ComponentState then
    exit;

  with fParentControl do
{  if (Left <> fParentLeft) or
     (Top <> fParentTop) or
     not EqualRect(fParentControl.ClientRect, fParentRect) then
}
   begin
     for hpos := hpFirst to hpLast do
       TCHandle(fCHandles[hpos]).ResetPosition;

   with fParentControl do
     begin
       fParentLeft := Left;
       fParentTop := Top;
       fParentRect := ClientRect;
     end;
   end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.SetActive;
var
  hpos : THandlePosition;
begin
  if val <> fActive then
    begin
      fActive := val;
      for hpos := hpFirst to hpLast do
        TCHandle(fCHandles[hpos]).Active := val;
    end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.SetVisible;
var
  hpos : THandlePosition;
begin
  if val <> fVisible then
    begin
      fVisible := val;
      if assigned(fParentControl) then
        begin
          for hpos := hpFirst to hpLast do
            with TChandle(fCHandles[hpos]) do
              if val then
                Show
              else
                Hide;

            if val then
              ResetPosition;
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.SetParentControl (val : TControl);
var
  hpos : THandlePosition;
begin
  if val <> fParentControl then
   begin
     fParentControl := val;
{
     If FParentControl<>nil then               //  Added in V4.1
       FParentControl.FreeNotification(Self);  //
}
     for hpos := hpFirst to hpLast do
       with TCHandle(fCHandles[hpos]) do
         begin
           ParentControl := val;
{
           If FParentControl<>nil then  //
}
             ShowMode := smActive
{
           else                         //
             ShowMode := smInvisible;   //
}
         end;
{
     If FParentControl=nil then   // Added in V4.1
       SetVisible(False);         //
}
   end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.SetShowMode (val : TCHShowMode);
var
  hpos : THandlePosition;
begin
  if not Assigned(fParentControl) then
    exit;

  fShowMode := val;
  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).ShowMode := val;
  UpdateAll;
end;

{------------------------------------------------------------------}

procedure TControlHandles.OnCHandleCancelSizing;
begin
  fDesigner.HideHint;
  DrawClippedSelection(fCurRect, fClipRect);
  RemoveClipping;
  ShowMode := fsaveShowMode;
  UpdateAll;
end;

{------------------------------------------------------------------}

procedure TControlHandles.OnCHandleMouseDown (Sender: TObject; Button: TMouseButton;
                                  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(fOnMouseDown) then
    fOnMouseDown(self, Button, Shift, TCHandle(Sender).Position);
end;

{------------------------------------------------------------------}

procedure TControlHandles.OnCHandleSizeChanging(Sender : TObject; X, Y : integer);
var
  oldrect : TRect;
begin
  oldrect := fCurRect;
  with fCurRect do
    case TCHandle(Sender).Position of
      hpTopLeft : begin
                    Top := Y;
                    Left := X;
                  end;
      hpTop     : Top := Y;
      hpTopRight : begin
                     Top := Y;
                     Right := X;
                   end;
      hpLeft : Left := X;
      hpRight : Right := X;
      hpBottomLeft : begin
                       Bottom := Y;
                       Left := X;
                     end;
      hpBottom : Bottom := Y;
      hpBottomRight : begin
                        Bottom := Y;
                        Right := X;
                      end;
    end;

  if Assigned(fOnValidateRect) then
    fOnValidateRect(self, fCurRect);

  if not EqualRect(oldRect, fCurRect) then
    begin
      fDesigner.HideHint;

      DrawClippedSelection(oldRect, fClipRect);
      DrawClippedSelection(fCurRect, fClipRect);

      fDesigner.ShowSizeHint(fCurRect);

      if Assigned(fOnSizeChanging) then
        with fCurrect do
          fOnSizeChanging(self, Right - Left, Bottom - Top);
    end;
end;

{------------------------------------------------------------------}

procedure TControlHandles.OnCHandleSizeChanged(Sender : TObject; X, Y : integer);
var
  hpos : THandlePosition;
begin
  fDesigner.HideHint;
  fSizing := false;
  DrawClippedSelection(fCurRect, fClipRect);
  RemoveClipping;
  CheckRect(fCurRect);
  with fParentControl, fCurRect do
    begin
      TopLeft := Parent.ScreenToClient(TopLeft);
      BottomRight := Parent.ScreenToClient(BottomRight);
      SetBounds(Left, Top, Right - Left, Bottom - Top);
    end;

  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).ResetPosition;

  ShowMode := fsaveShowMode;
  UpdateAll;

  if Assigned(fOnSizeChanged) then
    with fCurrect do
      fOnSizeChanged(self, Right - Left, Bottom - Top);
end;

{------------------------------------------------------------------}

procedure TControlHandles.OnCHandleStartSizeChanging(Sender : TObject);
begin
  fSizingHandle := TCHandle(Sender).Position;
  fsaveShowMode := fShowMode;
  ShowMode := smInvisible;
  GetRealParentForm(fParentControl).Invalidate;
  fClipRect := SetClipping(fParentControl.Parent);
  with fParentControl do
    begin
      fCurRect.TopLeft := Parent.ClientToScreen(Point(left, top));
      fCurRect.BottomRight := Parent.ClientToScreen(Point(left + width, top + height));
    end;

  fSizing := true;
  UpdateAll;

  DrawClippedSelection(fCurRect, fClipRect);
  fDesigner.ShowSizeHint(fCurRect);
  
  if Assigned(fOnStartSizeChanging) then
    fOnStartSizeChanging(self);
end;

{------------------------------------------------------------------}

function  TControlHandles.IsHandleWindow(wnd : HWND) : boolean;
var
  hpos : THandlePosition;
begin
  for hpos := hpFirst to hpLast do
    if TCHandle(fCHandles[hpos]).fWnd = wnd then
      begin
        result := true;
        exit;
      end;
  result := false;
end;

{------------------------------------------------------------------}

procedure TControlHandles.SetCanBeSized(val : boolean);
var
  hpos : THandlePosition;
begin
  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).CanBeSized := val;
end;

{------------------------------------------------------------------}

procedure TControlHandles.Update;
var
  hpos : THandlePosition;
begin
  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).Update;
end;

{------------------------------------------------------------------}

procedure TControlHandles.Show;
var
  hpos : THandlePosition;
begin
  for hpos := hpFirst to hpLast do
    TCHandle(fCHandles[hpos]).Show;
end;

{******************************************************************}

procedure _drawsel (dc : THandle; rect : TRect; boldline : boolean);
var
  OldBrush    : THandle;
  OldPen      : THandle;
  newpen      : THandle;
begin
  CheckRect(rect);
  if IsRectEmpty(rect) then
    exit;

  if boldline then
    NewPen := CreatePen(PS_SOLID, 2, clWhite)
  else
    NewPen := CreatePen(PS_DOT, 1, clBlack);

  SetROP2 (DC, R2_XORPEN);
  OldPen   := SelectObject (DC, NewPen);
  OldBrush := SelectObject (DC, GetStockObject (HOLLOW_BRUSH));
  inc(rect.Bottom);
  inc(rect.Right);
  with rect do
    Rectangle (DC, Left, Top, Right, Bottom);

  SelectObject (DC, OldBrush);
  SelectObject (DC, OldPen);
  DeleteObject (NewPen);
  GdiFlush;
end;

{------------------------------------------------------------------}

procedure _DrawClippedSelection (Rect, ClipRect : TRect; boldline : boolean);
var
  rgn : THandle;
  DC  : THandle;
  oldrgn : THandle;
begin
  DC := GetDC(0);

  with ClipRect do
    rgn := CreateRectRgn(left, top, right, bottom);

  oldrgn := SelectObject(dc, rgn);
  SelectClipRgn(dc, rgn);
  _drawsel(dc, rect, boldline);
  SelectObject(dc, oldrgn);
  DeleteObject(rgn);
  ReleaseDC (0, DC);
end;

{------------------------------------------------------------------}

procedure DrawClippedSelection (Rect, ClipRect : TRect);
begin
  _DrawClippedSelection(Rect, ClipRect, true);
end;

{------------------------------------------------------------------}

procedure _DrawSelection(Rect : TRect; boldline : boolean);
var
  DC  : THandle;
begin
  DC := GetDC(0);
  _drawsel(dc, rect, boldline);
  ReleaseDC (0, DC);
end;

{------------------------------------------------------------------}

procedure SmartDrawSelection(Rect : TRect);
begin
  _DrawSelection(Rect, DesignerInsertClass <> '');
end;

{------------------------------------------------------------------}

procedure DrawSelection (Rect : TRect);
begin
  _DrawSelection(Rect, false);
end;

{------------------------------------------------------------------}

procedure CheckRect (var Rect : TRect);
begin
  with Rect do
    begin
      if Top  > Bottom then
        SwapInt(Top, Bottom);

      if Left > Right  then
        SwapInt(Left, Right);
    end;
end;

{------------------------------------------------------------------}

function GetClippingRectangle(c : TControl) : TRect;
var
  wnd : THandle;
  crect : TRect;

begin
  result := Rect(0, 0, 10000, 10000);
  while c <> nil do
    begin
      if c is TWinControl then
        begin
          wnd := TWinControl(c).handle;
          GetClientRect(wnd, crect);
          with crect do
            begin
              windows.ClientToScreen(wnd, TopLeft);
              windows.ClientToScreen(wnd, BottomRight);
            end;

         IntersectRect(result, crect, result);

         if c is TCustomForm then
           break;
        end;

      c := c.Parent;
    end;
end;

{------------------------------------------------------------------}

function SetClipping(c : TWinControl) : TRect;
begin
  result := GetClippingRectangle(c);
  ClipCursor(@result);
  SetCapture(c.Handle);
end;

{------------------------------------------------------------------}

procedure RemoveClipping;
begin
  ReleaseCapture;
  ClipCursor(nil);
end;

{-----------------------------------------------------------}

procedure TDCFormDesigner.RenameEventsForComp(AComponent:TComponent;Const CurName,NewName:String);
Var
  TypeInfo:Pointer;
  PropCount:Integer;
  PropList:PPropList;
  MaxProp,i:Integer;
  TStr,TempStr:String;
  CompName:String;
  Method:TMethod;
begin
  If (NewName='') or (AComponent=nil) or (CurName='') then
    exit;
  TypeInfo:=AComponent.ClassInfo;
  PropCount:=GetTypeData(TypeInfo)^.PropCount;
  GetMem(PropList,PropCount*SizeOF(PPropInfo));
  try
    MaxProp:=GetPropList(TypeInfo,tkmethods,PropList);
    CompName:=AnsiUpperCase(CurName);
    For i:=0 to MaxProp-1 do
    begin
      Method:=GetMethodProp(AComponent,PropList[i]);
      TStr:=GetMethodName(Method);
      TempStr:=AnsiUpperCase(TStr);

      If Pos(CompName,TempStr)=1 then
        RenameMethod(TStr,NewName+Copy(TStr,Length(CompName)+1,MaxInt));
    end;
  finally
    FreeMem(PropList);
  end;
end;

{******************************************************************}

constructor TOLEEventDispatch.Create(AOwner : TDCOleControl);
begin
  fWrapper := AOwner;
end;

{------------------------------------------------------------------}

function TOLEEventDispatch.QueryInterface(const IID: TGUID; {$IFDEF D3}out{$ELSE}var{$ENDIF}Obj): HResult;
begin
{$IFDEF D3}
  if GetInterface(IID, Obj) then
    begin
      Result := S_OK;
      Exit;
    end;

  if IsEqualIID(IID, fEventIID) then
    begin
      GetInterface(IDispatch, Obj);
      Result := S_OK;
    end
  else
    Result := E_NOINTERFACE;
{$ELSE}

  if IsEqualIID(IID, fEventIID) then
    begin
      Pointer(obj) := self;
      Result := S_OK;
    end
  else
    result := fWrapper.OleObject.QueryInterface(IID, Obj);
{$ENDIF}
end;

{------------------------------------------------------------------}

{$IFDEF D3}
function TOLEEventDispatch._AddRef: longint;
{$ELSE}
function TOLEEventDispatch.AddRef: longint;
{$ENDIF}
begin
  result := S_OK;
end;

{------------------------------------------------------------------}

{$IFDEF D3}
function TOLEEventDispatch._Release: longint;
{$ELSE}
function TOLEEventDispatch.Release: longint;
{$ENDIF}
begin
  result := S_OK;
end;

{------------------------------------------------------------------}

{$IFNDEF D3}
function TOLEEventDispatch.GetTypeInfoCount(var ctinfo: Integer): HResult;
begin
  ctinfo := 0;
{$ELSE}
function TOLEEventDispatch.GetTypeInfoCount({$IFDEF D3}out{$ELSE}var{$ENDIF}Count: Integer): HResult;
begin
  Count := 0;
{$ENDIF}
  Result := S_OK;
end;

{------------------------------------------------------------------}

{$IFNDEF D3}
function TOLEEventDispatch.GetTypeInfo(itinfo: Integer; lcid: TLCID; var tinfo: ITypeInfo): HResult;
begin
  pointer(tinfo) := nil;
{$ELSE}
function TOLEEventDispatch.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
{$ENDIF}
  Result := E_NOTIMPL;
end;

{------------------------------------------------------------------}
{$IFNDEF D3}
function TOLEEventDispatch.GetIDsOfNames(const iid: TIID; rgszNames: POleStrList;
      cNames: Integer; lcid: TLCID; rgdispid: PDispIDList): HResult;
{$ELSE}
function TOLEEventDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
{$ENDIF}
begin
  Result := E_NOTIMPL;
end;
{------------------------------------------------------------------}

{$IFNDEF D3}
function TOLEEventDispatch.Invoke(dispIDMember: TDispID; const iid: TIID; lcid: TLCID;
      flags: Word; var dispParams: TDispParams; varResult: PVariant;
      excepInfo: PExcepInfo; argErr: PInteger): HResult;
{$ELSE}

function TOLEEventDispatch.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
{$ENDIF}
var
  evname : string;
  npargs : pointer;
  msize  : integer;
begin
  if not (csDesigning in fWrapper.ComponentState) then

    with {$IFDEF D3}TDispParams(Params){$ELSE}dispParams{$ENDIF}  do
      begin
        evname := fWrapper.GetEvent({$IFDEF D3}DispID{$ELSE}dispIDMember{$ENDIF});
        if evname <> '' then
          begin
            msize := (cArgs + 1) * sizeof(OleVariant);
            GetMem(npargs, msize);
            move(rgvarg^, npargs^, msize - sizeof(OleVariant));
            with TVarData(POleVariant(integer(npargs) + msize - sizeof(OleVariant))^) do
              begin
                vType := varDispatch;
                vDispatch := pointer(fWrapper.OleObject);
              end;
            try
              if Assigned(fWrapper.OnEvent) then
                fWrapper.OnEvent(PChar(EvName), cArgs + 1, npargs);
            finally
              FreeMem(npargs);
            end;
          end;
      end;

  Result := S_OK;
end;

{******************************************************************}

function TDCOleControl.FindEvent(ID : integer) : integer;
var
  i : integer;
begin
  for i := 0 to fEvents.Count - 1 do
    if TEventInfo(fEvents[i]).EventID = ID then
      begin
        result := i;
        exit;
      end;

  result := -1;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetEvent(ID : integer; const HandlerName : string);
var
  i : integer;
  info : TEventInfo;
begin
  i := FindEvent(ID);
  if i < 0 then
    begin
      info := TEventInfo.Create;
      i := fEvents.Add(info);
      info.EventID := ID;
    end;

  if HandlerName = '' then
    fEvents.Delete(i)
  else
    TEventInfo(fEvents[i]).Handler := HandlerName;
end;

{------------------------------------------------------------------}

function TDCOleControl.GetEvent(ID : integer) : string;
var
  i : integer;
begin
  i := FindEvent(ID);
  if i >= 0 then
    result := TEventInfo(fEvents[i]).Handler
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TDCOleControl.LoadEvents(Stream : TStream);
var
  r : TReader;
  info : TEventInfo;
  count : integer;
  i     : integer;
begin
  r := TReader.Create(Stream, 1024);
  try
    count := r.ReadInteger;
    for i := 0 to count - 1 do
      begin
        info := TEventInfo.Create;
        info.EventID := r.ReadInteger;
        info.Handler := r.ReadString;
        fEvents.Add(info);
      end;
  finally
    r.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.WriteEvents(Stream : TStream);
var
  w : TWriter;
  i : integer;
begin
  w := TWriter.Create(Stream, 1024);
  try
    w.WriteInteger(fEvents.Count);
    for i := 0 to fEvents.Count - 1 do
      with TEventInfo(fEvents[i]) do
        begin
          w.WriteInteger(EventID);
          w.WriteString(Handler);
        end;
  finally
    w.Free;
  end;
end;

{------------------------------------------------------------------}

function  TDCOleControl.GetGUID : string;
begin
  result := GUIDToString(fguid);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetGUID(const val : string);
begin
  SetClassID(StringToGUID(val));
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetControlData(AControlData : PControlData);
begin
  fControlData := AControlData;
  CreateOleControl;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetClassID(const val : TGUID);
begin
  fguid := val;
  CreateOleControl;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.LoadFromStream(Stream: TStream);
var
  iPerStream : IPersistStreamInit;
  iStre      : IStream;
  fData      : HGLOBAL;
  Buffer     : pointer;

begin
  if OleObject.QueryInterface({$IFDEF D3}IPersistStreamInit{$ELSE}IID_IPersistStreamInit{$ENDIF}, iPerStream) <> S_OK then
    exit;
  FData := GlobalAlloc(GMEM_MOVEABLE, Stream.Size);
  try
    Buffer := GlobalLock(FData);
    Stream.Read(Buffer^, Stream.Size);
    if CreateStreamOnHGlobal(FData, False, iStre) = S_OK then
      iPerStream.Load(iStre);
  finally
    GlobalFree(FData);
  end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.WriteToStream(Stream: TStream);
var
  fData : HGLOBAL;
  iStr  : IStream;
  iPerStream : IPersistStreamInit;
  buffer     : pointer;
begin
  if OleObject.QueryInterface({$IFDEF D3}IPersistStreamInit{$ELSE}IID_IPersistStreamInit{$ENDIF}, iPerStream) <> S_OK then
    exit;
  FData := GlobalAlloc(GMEM_MOVEABLE, 0);
  try
    if CreateStreamOnHGlobal(FData, False, iStr) <> S_OK then
      exit;

    if iPerStream.Save(iStr, True) <> S_OK then
      exit;
    Buffer := GlobalLock(FData);
    Stream.Write(Buffer^, GlobalSize(FData));
  finally
    GlobalFree(FData);
  end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.LoadGUID(Reader : TReader);
begin
  ControlGUID := Reader.ReadString;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.WriteGUID(Writer : TWriter);
begin
  Writer.WriteString(ControlGUID);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.LoadLicence(Stream: TStream);
var
  len : integer;
begin
  with TReader.Create(Stream, 4096) do
    try
      len := ReadInteger;
      if len > 0 then
        begin
          fLicence := ReadString;
          len := length(fLicence);
          if (len < 2) or (fLicence[len] <> #0) or (fLicence[len - 1] <> #0) then
            fLicence := fLicence + #0;
        end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.WriteLicence(Stream: TStream);
var
  len : integer;
  lkey : pwidechar;
  s    : string;
  w    : TWriter;
begin
  w := TWriter.Create(Stream, 4096);
  try
    len := 0;

    if Assigned(fOleControl) then
      begin
        lkey := fOleControl.cdata.LicenseKey;
        if lkey <> nil then
          while lkey[len] <> #0 do
            inc(len);

        len := len * 2;
        if len > 0 then
          SetString(s, pchar(lkey), len);
      end
    else
      begin
        len := length(fLicence);
        if len > 0 then
          s := fLicence;
      end;

    w.WriteInteger(len);
    if len > 0 then
      w.WriteString(s);

  finally
    w.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Licence', LoadLicence, WriteLicence, true);//don't resource
  Filer.DefineProperty('CGUID', LoadGUID, WriteGUID, true);//don't resource
  Filer.DefineBinaryProperty('Events', LoadEvents, WriteEvents, fEvents.Count > 0);//don't resource
  Filer.DefineBinaryProperty('ControlData', LoadFromStream, WriteToStream, OleObject <> nil);//don't resource
end;

{------------------------------------------------------------------}

procedure TDCOleControl.CreateHandle;
begin
  inherited CreateHandle;
  if (fOleControl <> nil) then
    begin
      fOleControl.Parent := self;
      SetBounds(left, top, width, height);
    end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.FocusChanged(Sender : TObject; GotFocus : boolean);
begin
{  if GotFocus then
    Perform(CM_ENTER, 0, 0)
  else
    Perform(CM_EXIT, 0, 0);}
end;

{------------------------------------------------------------------}

procedure TDCOleControl.CreateOLEControl;
var
  iti : ITypeInfo;
  pattr : PTypeAttr;
  pwname : PWideChar;
begin
  if not IsEqualGUID(fguid, GUID_NULL) or (fControlData <> nil) then
    begin
      if (fControlData <> nil) then
        fOleControl := TDCOleControl_.CreateControlData(self, fControlData)
      else
        fOleControl := TDCOleControl_.CreateGUID(self, fguid);
      fOleControl.OnFocusChanged := FocusChanged;
      with fOleControl do
        ControlStyle := ControlStyle - [csAcceptsControls];
      SetBounds(left, top, width, height);
      OleObject.QueryInterface({$IFDEF D3}IOleInplaceObject{$ELSE}IID_IOleInplaceObject{$ENDIF}, fOleInPlaceObject);

      iti := GetEventDispatchTypeInfo(OleObject);
      if iti <> nil then
        begin
          iti.GetTypeAttr(pattr);
          fOLEEventDispatch.fEventIID := pattr.guid;
          InterfaceConnect(OleObject, fOLEEventDispatch.fEventIID, fOLEEventDispatch, fEventsConnection);
          iti.ReleaseTypeAttr(pattr);
        end;
      ProgIDFromCLSID(fguid, pwname);
      fOleName := ClassPrefix + ExtractControlName({$IFDEF D3}pwname{$ELSE}WideCharToString(pwname){$ENDIF});
      if not IsValidIdent(fOleName) then
        fOleName := 'TDCOleControl'; //don't resource

    end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if fInSetBounds then
    exit;
  fInSetBounds := true;
  try
    if (fOleControl <> nil) and (Parent <> nil) then
      begin
        fOleControl.SetBounds(0, 0, AWidth, AHeight);
        AWidth := fOleControl.Width;
        AHeight := fOleControl.Height;
      end;

    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  finally
    fInSetBounds := false;
  end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl.Init;
begin
  Width := 121;
  Height := 121;
  fEvents := TList.Create;
  fOleEventDispatch := TOLEEventDispatch.Create(self);
end;

{------------------------------------------------------------------}

constructor TDCOleControl.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Init;
end;

{------------------------------------------------------------------}

destructor  TDCOleControl.Destroy;
var
  form : TForm;
begin
  form := TForm(GetParentForm(self));
  if (form <> nil) and (form.ActiveOleControl = OleControl) then
    form.ActiveOleControl := nil;

  InterfaceDisconnect(OleObject, fOLEEventDispatch.fEventIID, fEventsConnection);
  SetDesign(self, false);
//  fOLEEventDispatch.Free;
  fEvents.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

constructor TDCOleControl.CreateGUID(AOwner : TComponent; AGUID : TGUID);
begin
  inherited Create(AOwner);
  Init;
  fguid := AGUID;
  CreateOLEControl;
end;

{------------------------------------------------------------------}

constructor TDCOleControl.CreateControlData(AOwner : TComponent; AControlData : PControlData);
begin
  inherited Create(AOwner);
  fControlData := AControlData;
  CreateOLEControl;
end;

{------------------------------------------------------------------}

function TDCOleControl.GetOleObject : IOleObject;
begin
  result := nil;
  if Assigned(fOleControl) then
    result := IOleObject(TVarData(fOleControl.OleObject).vDispatch);
end;

{------------------------------------------------------------------}

function  TDCOleControl.GetOleName : string;
begin
  result := fOleName;
end;

{------------------------------------------------------------------}
{$IFDEF D3}
function TDCOleControl.GetWideStringProp(Index: Integer): WideString;
begin
  result := OleControl.GetWideStringProp(Index);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetWideStringProp(Index: Integer; const Value: WideString);
begin
  OleControl.SetWideStringProp(Index, Value);
end;

{------------------------------------------------------------------}

function TDCOleControl.GetWordBoolProp(Index: Integer): WordBool;
begin
  result := OleControl.GetWordBoolProp(Index);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetWordBoolProp(Index: Integer; Value: WordBool);
begin
  OleControl.SetWordBoolProp(Index, Value);
end;

{------------------------------------------------------------------}

function  TDCOleControl.GetTOleEnumProp(Index: Integer): TOleEnum;
begin
  result := OleControl.GetTOleEnumProp(Index);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetTOleEnumProp(Index: Integer; Value: TOleEnum);
begin
  OleControl.SetTOleEnumProp(Index, Value);
end;
{$ENDIF}
{------------------------------------------------------------------}

function  TDCOleControl.GetIntegerProp(Index: Integer): Integer;
begin
  result := OleControl.GetIntegerProp(Index);
end;

{------------------------------------------------------------------}

procedure TDCOleControl.SetIntegerProp(Index: Integer; Value: Integer);
begin
  OleControl.SetIntegerProp(Index, Value);
end;

{***************************************************************}

constructor TDCOleControl_.CreateGUID(AOwner : TComponent; AGUID : TGUID);
begin
  fguid := AGUID;
  cdata.LicenseKey := pointer(TDCOleControl(AOwner).fLicence);

  inherited Create(AOwner);
end;

{------------------------------------------------------------------}

constructor TDCOleControl_.CreateControlData(AOwner : TComponent; AControlData : PControlData);
begin
  ControlData := AControlData;
  inherited Create(AOwner);
end;

{------------------------------------------------------------------}

destructor TDCOleControl_.Destroy;
begin
  if fNeedFreeLic then
    SysFreeString(cdata.LicenseKey);

  inherited;
end;

{------------------------------------------------------------------}

procedure TDCOleControl_.InitControlData;
var
  icf2 : IClassFactory2;
begin
  if not IsEqualGUID(fguid, GUID_NULL) then
    begin
      cdata.ClassID := fguid;
      if cdata.LicenseKey = nil then
        if CoGetClassObject(fguid, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, nil, {$IFDEF D3}IClassFactory2{$ELSE}IID_IClassFactory2{$ENDIF}, icf2) = S_OK then
          if icf2.RequestLicKey(0, {$IFDEF D3}widestring(cdata.LicenseKey){$ELSE}TBStr(cdata.LicenseKey){$ENDIF}) = S_OK then
            fNeedFreeLic := true;

      ControlData := @cdata;
    end;
end;

{------------------------------------------------------------------}

procedure TDCOleControl_.CMUIDeactivate(var Message: TMessage);
begin
  if Assigned(OnFocusChanged) then
    OnFocusChanged(self, false);

  inherited;
end;

{******************************************************************}

{$IFNDEF D3}
procedure InterfaceConnect(Source: IUnknown; const IID: TIID;
  Sink: IUnknown; var Connection: integer);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  Connection := 0;
  if Source.QueryInterface(IID_IConnectionPointContainer, CPC) >= 0 then
  begin
    if CPC.FindConnectionPoint(IID, CP) >= 0 then
    begin
      CP.Advise(Sink, longint(Connection));
      CP.Release;
    end;
    CPC.Release;
  end;
end;

{------------------------------------------------------------------}

procedure InterfaceDisconnect(Source: IUnknown; const IID: TIID;
  var Connection: integer);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  if Connection <> 0 then
    if Source.QueryInterface(IID_IConnectionPointContainer, CPC) >= 0 then
    begin
      if CPC.FindConnectionPoint(IID, CP) >= 0 then
      begin
        if CP.Unadvise(longint(Connection)) >= 0 then Connection := 0;
        CP.Release;
      end;
      CPC.Release;
    end;
end;

{------------------------------------------------------------------}

{$ELSE}
procedure InterfaceConnect(const Source: IUnknown; const IID: TIID;
  const Sink: IUnknown; var Connection: integer);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  Connection := 0;
  if Source.QueryInterface(IConnectionPointContainer, CPC) = S_OK then
    if CPC.FindConnectionPoint(IID, CP) = S_OK then
      CP.Advise(Sink, longint(Connection));
end;

{------------------------------------------------------------------}

procedure InterfaceDisconnect(const Source: IUnknown; const IID: TIID;
  var Connection: integer);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  if Connection <> 0 then
    if Source.QueryInterface(IConnectionPointContainer, CPC) = S_OK then
      if CPC.FindConnectionPoint(IID, CP) = S_OK then
        if CP.Unadvise(longint(Connection)) = S_OK then
          Connection := 0;
end;

{$ENDIF}

{------------------------------------------------------------------}


function GetActiveDesigner : IDCFormDesigner;
var
  i : integer;
{
  D:TFormDesigner;
  f : TCustomForm;
}
begin
  if Assigned(GetActiveDesignerProc) then
    begin
      result := GetActiveDesignerProc;
      exit;
    end;

  with DCFormDesigners do
    for i := 0 to Count - 1 do
      with TDCFormDesigner(Items[i]) do
        if Active and (Form <> nil) and (FormIsActive(Form) or FormIsActive(GetParentForm(Form))) then
          begin
            result := TDCFormDesigner(Items[i]);
            exit;
          end;

  result := nil;
{
  for i:=0 to ScreenFormCount-1 do
    begin
      f := ScreenForms(i);
      if FormIsActive(f) then
        begin
          D := TFormDesigner(f.Designer);
          if IsDCFormDesigner(D) then
            begin
              result := D as IDCFormDesigner;
              if result.Active then
                exit;
            end;
        end;
    end;
  result := nil;
}
end;

{------------------------------------------------------------------}

procedure DesignerGetVerbState(Var VerbStates:TVerbStates);
Var
  D : IDCFormDesigner;
begin
  D := GetActiveDesigner;
  if (D = nil) then
    Exclude(VerbStates,vsEnabled);
end;

{------------------------------------------------------------------}

procedure DesignerAlignLeftEdges;
begin
  GetActiveDesigner.AlignSelected(acLefts,acNoChange);
end;

{------------------------------------------------------------------}

procedure DesignerAlignHorzCenters;
begin
  GetActiveDesigner.AlignSelected(acCenters,acNoChange);
end;

{------------------------------------------------------------------}

procedure DesignerCenterHorz;
begin
  GetActiveDesigner.AlignSelected(acCenterInWindow,acNoChange);
end;

{------------------------------------------------------------------}

procedure DesignerSpaceEquallyHorz;
begin
  GetActiveDesigner.AlignSelected(acSpaceEqually,acNoChange);
end;

{------------------------------------------------------------------}

procedure DesignerAlignRightEdges;
begin
  GetActiveDesigner.AlignSelected(acRights,acNoChange);
end;

{------------------------------------------------------------------}

procedure DesignerAlignTops;
begin
  GetActiveDesigner.AlignSelected(acNoChange,acTops);
end;

{------------------------------------------------------------------}

procedure DesignerAlignVertCenters;
begin
  GetActiveDesigner.AlignSelected(acNoChange,acCenters);
end;

{------------------------------------------------------------------}

procedure DesignerCenterVert;
begin
  GetActiveDesigner.AlignSelected(acNoChange,acCenterInWindow);
end;

{------------------------------------------------------------------}

procedure DesignerSpaceEquallyVert;
begin
  GetActiveDesigner.AlignSelected(acNoChange,acSpaceEqually);
end;

{------------------------------------------------------------------}

procedure DesignerAlignBottoms;
begin
  GetActiveDesigner.AlignSelected(acNoChange,acBottoms);
end;

{------------------------------------------------------------------}

procedure DesignerAlignToGrid;
begin
  GetActiveDesigner.AlignToGrid;
end;

{------------------------------------------------------------------}

procedure DesignerBringToFront;
begin
  GetActiveDesigner.BringToFront;
end;

{------------------------------------------------------------------}

procedure DesignerSendToBack;
begin
  GetActiveDesigner.SendToBack;
end;

{------------------------------------------------------------------}

procedure DesignerAlignControls;
Var
  HorAlign,VertAlign:TAlignControls;
begin
   If AlignWasChanged(HorAlign,VertAlign) then
     GetActiveDesigner.AlignSelected(HorAlign,VertAlign);
end;

{------------------------------------------------------------------}

procedure DesignerSizeControls;
Var
  xsizechange, ysizechange:Integer;
begin
  If SizeWasChanged(xsizechange, ysizechange) then
    GetActiveDesigner.SizeSelected(xsizechange, ysizechange);
end;

{------------------------------------------------------------------}

procedure DesignerChangeLockControls;
begin
  with GetActiveDesigner do
    LockControls:= not LockControls;
end;

{------------------------------------------------------------------}

procedure GetLockVerbState(Var VerbStates:TVerbStates);
var
  D : IDCFormDesigner;
begin
  D := GetActiveDesigner;
  if (D = nil) then
    Exclude(VerbStates,vsEnabled)
  else
    if D.LockControls then
      include(VerbStates,vsChecked);
end;

{------------------------------------------------------------------}

procedure AddDataModuleWrapper(DataModule : TDataModule; Wrapper : TCustomForm);
var
  info : TWrapperInfo;
begin
  if GetDataModuleWrapper(DataModule) <> nil then
    exit;

  info := TWrapperInfo.Create;
  info.data := DataModule;
  info.form := Wrapper;
  DataModuleWrappers.Add(info);
end;

{------------------------------------------------------------------}

procedure RemoveDataModuleWrapper(DataModule : TDataModule);
var
  i : integer;
begin
  with DataModuleWrappers do
    for i := Count - 1 downto 0 do
      with TWrapperInfo(Items[i]) do
        if data = DataModule then
          begin
            Delete(i);
            Free;
          end;
end;

{------------------------------------------------------------------}
(*
procedure TDCOleControlEditor.ExecuteVerb(Index: Integer);
begin
  TDCOleControl_(Component).DoObjectVerb(index);
end;

{------------------------------------------------------------------}

function TDCOleControlEditor.GetVerb(Index: Integer): string;
var
  verblist : TStringList;
begin
  verblist := TStringList.Create;
  try
    TDCOleControl_(Component).GetObjectVerbs(verblist);
    result := verblist[index];
  finally
    verblist.Free;
  end;
end;

{------------------------------------------------------------------}

function TDCOleControlEditor.GetVerbCount: Integer;
var
  verblist : TStringList;
begin
  verblist := TStringList.Create;
  try
    TDCOleControl_(Component).GetObjectVerbs(verblist);
    result := verblist.Count;
  finally
    verblist.Free;
  end;
end;
 *)

{******************************************************************}

constructor TLimitInfoItem.Create(Collection: TCollection);
begin
  inherited;
  fAllowedActions := AllActionsAllowed;
  fReadOnlyProps := TStringList.Create;
  fHiddenProps := TStringList.Create;

  fNotifier := TDCLinkedComponent.Create(nil);
  fNotifier.NotifyProc := Notification;
end;

{------------------------------------------------------------------}

destructor  TLimitInfoItem.Destroy;
begin
  fNotifier.Free;
  fReadOnlyProps.Free;
  fHiddenProps.Free;

  inherited;
end;

{------------------------------------------------------------------}

procedure TLimitInfoItem.SetComponent(val : TComponent);
begin
  if val <> fComponent then
    begin
      fComponent := val;
      fNotifier.Link := val;
    end;
end;

{------------------------------------------------------------------}

procedure TLimitInfoItem.Notification(AComponent : TComponent; Operation : TOperation);
begin
  if (Operation = opRemove) and (AComponent = fComponent) then
    fComponent := nil;
end;

{------------------------------------------------------------------}

procedure TLimitInfoItem.SetReadOnlyProps(val : TStrings);
begin
  fReadOnlyProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TLimitInfoItem.SetHiddenProps(val : TStrings);
begin
  fHiddenProps.Assign(val);
end;

{******************************************************************}
(*
type
  TDCLiteDesignerEdit = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{------------------------------------------------------------------}

procedure TDCLiteDesignerEdit.ExecuteVerb(Index : Integer);
begin
  CallPropertyEdit(Component, 'LimitInfos');
end;

{------------------------------------------------------------------}

function TDCLiteDesignerEdit.GetVerb(Index: Integer): string;
begin
  result := 'Edit restrictions...';
end;

{------------------------------------------------------------------}

function TDCLiteDesignerEdit.GetVerbCount: Integer;
begin
  result := 1;
end;
*)
{------------------------------------------------------------------}

{$IFDEF DCEDIT}

procedure DesignerScaleControls;
Var
  Factor:Extended;
begin
  If ReadScaleFactor(Factor) then
    GetActiveDesigner.Scale(Factor);
end;
{$ENDIF}

{------------------------------------------------------------------}
{$IFDEF DREAMTREE}
procedure DesignerChangeCreationOrder;
begin
  ChangeCreationOrder(GetActiveDesigner.OwnerControl);
end;

{------------------------------------------------------------------}

procedure DesignerChangeTabOrder;
begin
  ChangeTabOrder(GetActiveDesigner.GetTabOrderControl);
end;
{$ENDIF}
{------------------------------------------------------------------}

//BeginSkipConst

const
  VerbArray:Array[0..15] of TVerbData=(
    (Name:'Designer.AlignLeftEdges'     ; GetState:DesignerGetVerbState;Execute:DesignerAlignLeftEdges),
    (Name:'Designer.AlignHorzCenters'   ; GetState:DesignerGetVerbState;Execute:DesignerAlignHorzCenters),
    (Name:'Designer.CenterHorz'         ; GetState:DesignerGetVerbState;Execute:DesignerCenterHorz),
    (Name:'Designer.SpaceEquallyHorz'   ; GetState:DesignerGetVerbState;Execute:DesignerSpaceEquallyHorz),
    (Name:'Designer.AlignRightEdges'    ; GetState:DesignerGetVerbState;Execute:DesignerAlignRightEdges),
    (Name:'Designer.AlignTops'          ; GetState:DesignerGetVerbState;Execute:DesignerAlignTops),
    (Name:'Designer.AlignVertCenters'   ; GetState:DesignerGetVerbState;Execute:DesignerAlignVertCenters),
    (Name:'Designer.CenterVert'         ; GetState:DesignerGetVerbState;Execute:DesignerCenterVert),
    (Name:'Designer.SpaceEquallyVert'   ; GetState:DesignerGetVerbState;Execute:DesignerSpaceEquallyVert),
    (Name:'Designer.AlignBottoms'       ; GetState:DesignerGetVerbState;Execute:DesignerAlignBottoms),
    (Name:'Designer.AlignToGrid'        ; GetState:DesignerGetVerbState;Execute:DesignerAlignToGrid),
    (Name:'Designer.BringToFront'       ; GetState:DesignerGetVerbState;Execute:DesignerBringToFront),
    (Name:'Designer.SendToBack'         ; GetState:DesignerGetVerbState;Execute:DesignerSendToBack),
    (Name:'Designer.AlignControls'      ; GetState:DesignerGetVerbState;Execute:DesignerAlignControls),
    (Name:'Designer.SizeControls'       ; GetState:DesignerGetVerbState;Execute:DesignerSizeControls),
    (Name:'Designer.ChangeLockControls' ; GetState:GetLockVerbState;Execute:DesignerChangeLockControls)
);

{$IFDEF DREAMTREE}
const
  VerbArray1:Array[0..1] of TVerbData=(
    (Name:'Designer.ChangeTabOrder'     ; GetState:DesignerGetVerbState;Execute:DesignerChangeTabOrder),
    (Name:'Designer.ChangeCreationOrder'; GetState:DesignerGetVerbState;Execute:DesignerChangeCreationOrder));
{$ENDIF}

{------------------------------------------------------------------}

procedure _Register;
begin
  RegisterOptionExt(TDesignerOptions);
  RegisterOptionExt(TDCLiteDesignerOptions);
  RegisterVerbArray(VerbArray);
end;
//EndSkipConst
{------------------------------------------------------------------}

procedure RunRegister;
begin
  RegisterForDelphi(_Register);
//  RegisterComponentEditor(TDCLiteDesigner, TDCLiteDesignerEdit);
end;

{------------------------------------------------------------------}

function GlobalDesignerOptions : TDesignerOptions;
begin
  result := TDesignerOptions(GetOptionsByClass(TDesignerOptions));
end;

{------------------------------------------------------------------}
var
  fDDesignerList : TDCLiteDesignerList;

function DreamDesignerList : TDCLiteDesignerList;
begin
  If fDDesignerList = nil then
    fDDesignerList := TDCLiteDesignerList.Create;

  Result := fDDesignerList;
end;

{-------------------------------------------------------------------------}

function TDCLiteDesignerList.GetDesigner (index : integer) : TCustomLiteDesigner;
begin
  result := TCustomLiteDesigner(Items[index]);
end;

{*************************************************************************}

procedure TDCLiteDesignerOptions.Update;
var
  i : integer;
begin
  if UpdateDisabled then
    exit;

  with DreamDesignerList do
    for i := 0 to Count - 1 do
      with Designers[i] do
        if UseGlobalOptions then
          LoadGlobalOptions;
end;

{------------------------------------------------------------------}

function  TDCLiteDesignerOptions.GetKey : string;
begin
  result := 'Designer\'; //don't resource
end;

{------------------------------------------------------------------}

procedure TDCLiteDesignerOptions.InitValues;
begin
  fStartHotKey := ShortCut(VK_F12, [ssCtrl]);
  fStopHotKey := fStartHotKey;
end;

{------------------------------------------------------------------}

procedure TDCLiteDesignerOptions.SetStartHotKey(val : TShortCut);
begin
  if fStartHotKey <> val then
    begin
      fStartHotKey := val;
      Update;
    end;
end;

{------------------------------------------------------------------}

procedure TDCLiteDesignerOptions.SetStopHotKey(val : TShortCut);
begin
  if fStopHotKey <> val then
    begin
      fStopHotKey := val;
      Update;
    end;
end;

{******************************************************************}

procedure TCustomLiteDesigner.CancelChanges;
begin
  if fDesigner <> nil then
    fDesigner.UndoAll;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.Loaded;
begin
  inherited;
  if not (fLoaded or (csDesigning in ComponentState)) then
    fHandleObject.PostMsg(CM_ALLLOADED, 0, 0);

  fLoaded := true;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.AllLoaded;
var
  dcomp : TComponent;
begin
  dcomp := GetRealDesignedComponent;
  if fStoreChanges then
    begin
      if dcomp is TWinControl then
        TWinControl(dcomp).HandleNeeded;

      fChanges.Start(dcomp);
      LoadChanges;
    end;

  if (fCBut <> nil) then
    begin
      if dcomp is TCustomForm then
        fCBut.Form := TCustomForm(dcomp);
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveChanges;
var
  processed : boolean;
begin
  try
    Designer.BeforeSave;

    processed := false;

    if Assigned(OnSaveChanges) then
      OnSaveChanges(self, processed);

    if not processed then
      fChanges.SaveToRegistry(GetChangesKey);

  finally
    Designer.AfterSave;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadChanges;
var
  processed : boolean;
begin
  processed := false;

  if Assigned(OnLoadChanges) then
    OnLoadChanges(self, processed);

  if not processed then
    fChanges.LoadFromRegistry(GetRealDesignedComponent, GetChangesKey);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.ClearChanges;
var
  s : TRegistryStream;
begin
  s := TRegistryStream.Create(GetChangesKey, fmOpenWrite);
  try
    s.Clear;
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadGlobalOptions;
begin
  with GlobalDreamDesignerOptions do
    begin
      Self.StartHotKey := StartHotKey;
      Self.StopHotKey  := StopHotKey;
    end;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetNeedRecreateWnd:boolean;
begin
  Result:=FDesigner.NeedRecreateWnd;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetNeedRecreateWnd(V:Boolean);
begin
  FDesigner.NeedRecreateWnd:=V;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.HookProc(var Msg : TMessage);
var
  c : TWinControl;
  form : TCustomForm;
  _msg : PCWPStruct;
begin
  _msg := PCWPStruct(Msg.wParam);
  if not ((_Msg^.message = CN_KEYDOWN) or (_Msg^.message = CN_SYSKEYDOWN)) then
    exit;

  if ShortCut(_Msg^.wParam , KeyDataToShiftState(_Msg^.lParam)) <> fStartHotKey then
    exit;

  if Owner is TCustomForm then
    form := TCustomForm(Owner)
  else
    exit;

  form := GetParentForm(form);
    
  with Msg do
    begin
      c := GetVCLControlFromHWND(_Msg^.hwnd);
      if (c <> nil) and {not Active and} ((c = Form) or IsChild(form.Handle, c.Handle)) then
        begin
          fFirstKeyDown := true;
          self.Active := not self.Active;
          result := 1;
        end;
    end;
end;

{--------------------------------------------}
{$IFDEF D4}
type
  TMInterfacedObject = class(TInterfacedObject);
{$ENDIF}

constructor TCustomLiteDesigner.Create(AOwner : TComponent);
begin
  inherited;

  fHandleObject := TDCHandleObject.Create(self);
  fPaletteOptions := TCompPaletteOptions.Create;
  FInspectorOptions := TInspOptions.Create;
  fCaptionGlyph := TBitmap.Create;
  fCaptionGlyph.LoadFromResourceName(HInstance, 'DESIGNERCAPTION'); //don't resource
  fCaptionGlyph.OnChange := CaptionGlyphChanged;

  FDesigner := TDCFormDesigner.Create;
  {$IFDEF D4}
  TMInterfacedObject(fDesigner)._AddRef;
  {$ENDIF}

  fChanges := TDCCompChanges.Create;
  fChanges.OnError := fDesigner.CompFiler.ReaderError;
  fChanges.OnFindMethod := fDesigner.CompFiler.ReaderOnMethod;
  fChanges.OnStoreProp := IsPropStored;

  FStartHotKey := ShortCut(VK_F12,[ssCtrl]);
  FStopHotKey  := FStartHotKey;
  FShowPalette := true;
  fWrapper := TDataModuleWrapper.Create(nil);
  fIsStored := true;

  with fDesigner do
    begin
      OnAction            := Self.Action;
      OnActiveChanged     := Self.ActiveChanged;
      OnAfterInsertComponent := AfterInsertComponent;
      OnChange            := Self.Change;
      OnCloseForm         := Self.CloseForm;
      OnDeleteComponent   := Self.DeleteComponent;
      OnDragDrop          := Self.DragDrop;
      OnDragOver          := Self.DragOver;
      OnGetComponentGlyph := Self.GetComponentGlyph;
      OnInsertComponent   := Self.InsertComponent;
      OnKeyDown           := Self.KeyDown;
      OnMouseDown         := Self.MouseDown;
      OnMouseMove         := Self.MouseMove;
      OnMouseUp           := Self.MouseUp;
      OnGetCompNames      := Self.GetCompNames;
      OnSelectionChanged  := Self.SelectionChanged;
      OnEditProperty      := Self.EditProperty;
      OnShowProperty      := Self.ShowProperty;
      OnSizeChanged       := Self.SizeChanged;
      OnAllowPopup        := Self.AllowPopup;
      OnStoreProp         := IsPropStored;
      OnProcessMenuItem   := self.ProcessMenuItemProc;
      OnGetEventsList     := self.GetEventsList;
      OnGetAncestor       := self.GetAncestor;

      HideOnClose := false;
      UseGlobalOptions := true;
      OwnerControl := GetRealDesignedComponent;
      ShowHints := true;
      NeedRecreateWnd := true;
    end;

  UseDefaultMenu := true;

  if not (csDesigning in ComponentState) {and not (Owner is TActiveForm)} then
    AddWndHook(self);

  DreamDesignerList.Add(self);
end;

{------------------------------------------------------------------}

destructor  TCustomLiteDesigner.Destroy;
{$IFDEF D4}
var
  rcount : integer;
{$ENDIF}
begin
  RemoveWndHook(self);
  DreamDesignerList.Remove(self);
  Active := false;

  fCaptionGlyph.Free;
  fCBut.Free;
  fWrapper.Free;
{$IFDEF D4}
  rcount := fDesigner.RefCount;
  TMInterfacedObject(fDesigner)._Release;
  if rcount = 1 then
    pointer(fDesigner) := nil;
{$ELSE}
  fDesigner.Free;
{$ENDIF}
  fChanges.Free;
  fHandleObject.Free;
  fPaletteOptions.Free;
  FInspectorOptions.Free;

  Destroying;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.CaptionGlyphChanged(Sender : TObject);
begin
  fCaptionGlyphChanged := true;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveToFile(const FileName : TFileName);
begin
  fDesigner.SaveFormToFile(FileName);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveToStream(S : TStream);
begin
  fDesigner.SaveFormToStream(S, true);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveToStrings(Strings : TStrings);
var
  s : TMemoryStream;
  savemode : boolean;
begin
  s := TMemoryStream.Create;
  savemode := SaveDesignedFormsAsText;
  try
    SaveDesignedFormsAsText := true;
    SaveToStream(s);
    s.Seek(0, 0);
    Strings.LoadFromStream(s);
  finally
    SaveDesignedFormsAsText := savemode;
    s.Free;
  end;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.CreateFromFile(const FileName : TFileName; ModuleClass : TComponentClass) : TComponent;
begin
  result := Designer.CompFiler.CreateFromFile(FileName, ModuleClass, false);
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.CreateFromStream(S : TStream; ModuleClass : TComponentClass) : TComponent;
begin
  result := Designer.CompFiler.CreateFromStream(S, ModuleClass, false);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadFromFile(Instance : TComponent; const FileName : TFileName);
begin
  Designer.CompFiler.LoadFromFile(FileName, Instance);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadFromStream(Instance : TComponent; S : TStream);
begin
  Designer.CompFiler.LoadFromStream(S, Instance);
end;

{------------------------------------------------------------------}

function TCustomLiteDesigner.LoadFromStrings(Instance : TComponent; Strings : TStrings) : string;
var
  s : TStream;
begin
  s := TMemoryStream.Create;
  try
    Strings.SaveToStream(s);
    s.Seek(0, 0);
    result := Designer.CompFiler.LoadFromStream(S, Instance);
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveComponentToStream(Instance : TComponent; S : TStream);
begin
  Designer.SaveComponentToStream(Instance, S);
end;

{------------------------------------------------------------------}

function TCustomLiteDesigner.CreateComponentFromFile(const FileName : TFileName; AParent : TComponent) : TComponent;
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    result := CreateComponentFromStream(FileStream, AParent);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

function TCustomLiteDesigner.CreateComponentFromStream(S : TStream; AParent : TComponent) : TComponent;
var
  cowner : TComponent;
begin
  with Designer, CompFiler do
    begin
      cowner := GetRealDesignedComponent;
      BeginTrick(cowner, false);
      with TReader.Create(S, 4096) do
        try
          Parent := AParent;
          Root := cowner;
          BeginReferences;
          OnError := ReaderError;
          OnFindMethod := ReaderOnMethod;

          result := ReadComponent(nil);
          FixupReferences;
        finally
          EndReferences;
          Free;
          EndTrick(cowner);
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadComponentFromStream(Instance : TComponent; S : TStream);
var
  cowner : TComponent;
begin
  with Designer, CompFiler do
    begin
      {$IFDEF DCEDIT}
      if not (Instance is TCustomDCEdit) then
      {$ENDIF}
        ClearComponent(Instance);

      cowner := GetRealDesignedComponent;
      BeginTrick(cowner, false);
      with TReader.Create(S, 4096) do
        try
          Root := cowner;
          Parent := cowner;
          BeginReferences;
          OnError := ReaderError;
          OnFindMethod := ReaderOnMethod;

          ReadComponent(Instance);
          FixupReferences;
        finally
          EndReferences;
          Free;
          EndTrick(cowner);
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SaveComponentToFile(Instance : TComponent; const FileName : TFileName);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    SaveComponentToStream(Instance, FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.LoadComponentFromFile(Instance : TComponent; const FileName : TFileName);
var
  FileStream : TFileStream;
begin
  FileStream := TFileStream.Create(FileName, DefaultOpenMode);
  try
    LoadComponentFromStream(Instance, FileStream);
  finally
    FileStream.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.AddUsedModule(Module : TComponent);
begin
  Module := GetCompModule(Module);
  if Module <> nil then
    begin
      fDesigner.AddUsedModule(Module);
      Module.FreeNotification(self);
    end;  
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.RemoveUsedModule(Module : TComponent);
begin
  fDesigner.RemoveUsedModule(Module);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.Action(Sender : TObject; Instance : TPersistent; Action : TActionType; var Allow : boolean);
begin
  if Instance = self then
    Allow := Allow and ShowSelf;

  if Assigned(FOnAction) then
    FOnAction(Self, Instance, Action, Allow);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.ActiveChanged(Sender: TObject);
begin
  if Assigned(FOnActiveChanged) then
    FOnActiveChanged(Self);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.Change(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.CloseForm(Sender: TObject);
begin
  if Assigned(FOnCloseForm) then
    FOnCloseForm(Self);
  Active := false;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.DragDrop(Sender,Source,Target:TObject;X,Y:Integer);
Begin
  if Assigned(fOnDragDrop) then
    fOnDragDrop(self,Source,Target,X,Y);
End;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.DragOver(Sender,Source,Target:TObject;X,Y:Integer;State:TDragState;var Accept:Boolean);
Begin
  if Assigned(fOnDragOver) then
    fOnDragOver(self,Source,Target,X,Y,State,Accept);
End;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.DeleteComponent(Sender : TObject; AControl : TComponent);
begin
  if Assigned(FOnDeleteComponent) then
    FOnDeleteComponent(Self,AControl);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.GetComponentGlyph(Sender : TObject;  AClass :TClass; AGlyph : TBitmap);
begin
  if Assigned(FOnGetComponentGlyph) then
    FOnGetComponentGlyph(Self,AClass,AGlyph)
  else
    LoadBitmapForClass(AGlyph,AClass);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.AfterInsertComponent(Sender : TObject; AControl : TComponent);
begin
  if Assigned(OnAfterInsertComponent) then
    OnAfterInsertComponent(self, AControl);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.InsertComponent(Sender : TObject; AControl : TComponent);
begin
  if Assigned(FOnInsertComponent) then
    FOnInsertComponent(Self,AControl);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if not NeedRecreateWnd and fFirstKeyDown then
    begin
      fFirstKeyDown := false;
      exit;
    end;

{  if ShortCut(Key,Shift) = FStopHotKey then
    Active := false
  else }if Assigned(FOnKeyDown) then
    FOnKeyDown(Sender,Key,Shift)
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self , Button , Shift , X , Y);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.MouseMove(Sender: TObject; Shift: TShiftState;X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self , Shift , X , Y);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self , Button , Shift , X , Y);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.GetCompNames(Sender:TObject;TypeData: PTypeData; Proc: TGetStrProc);
begin
  if Assigned(FOnGetCompNames) then
    FOnGetCompNames(Self , TypeData , Proc);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SelectionChanged(Sender: TObject);
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.EditProperty(Sender : TObject; Instance : TObject; const PropName : string; var AllowEdit : boolean);
begin
  if fStoreChanges and (CompareText(PropName, 'Name') = 0) then
     AllowEdit := not Changes.StartList.CompExists(TComponent(Instance));

  if Assigned(OnEditProperty) then
    OnEditProperty(self, Instance, PropName, AllowEdit);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.ShowProperty(Sender : TObject; Instance : TObject; const PropName : string; var AllowShow : boolean);
begin
  if Assigned(OnShowProperty) then
    OnShowProperty(self, Instance, PropName, AllowShow);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.ProcessMenuItemProc(Sender : TObject; MenuItem : TMenuItem; var AllowCommand : boolean);
begin
  if Assigned(OnProcessMenuItem) then
    OnProcessMenuItem(self, MenuItem, AllowCommand);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SizeChanged(Sender : TObject; ChangedControl : TControl);
begin
  if Assigned(OnSizeChanged) then
    OnSizeChanged(Self, ChangedControl);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.AllowPopup (Sender : TObject; Shift: TShiftState; X, Y: Integer; var AllowPopup : boolean);
begin
  if Assigned(OnAllowPopup) then
    OnAllowPopup(self, Shift, X, Y, AllowPopup);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.GetEventsList(Sender : TObject; TypeData : PTypeData; EventsList : TStrings);
begin
  if Assigned(OnGetEventsList) then
    OnGetEventsList(self, TypeData, EventsList);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.GetAncestor(Sender: TObject; var Ancestor: TComponent);
begin
  if Assigned(FOnGetAncestor) then
    FOnGetAncestor(self, Ancestor);
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetReadOnly :boolean;
begin
  result := FDesigner.ReadOnly;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetReadOnly(val : boolean);
begin
  FDesigner.ReadOnly := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetActive : boolean;
begin
  result := FDesigner.Active;
end;

{------------------------------------------------------------------}

function TCustomLiteDesigner.GetRealDesignedComponent : TComponent;
begin
  result := DesignedComponent;

  if result = nil then
    result := self;

  if not ((result is TCustomForm) or (result is TDataModule)) then
    result := GetTopOwner(result);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.DisplayPalette;
var
  pal : TDCCompPalette;
begin
  ShowComponentPalette;
  if fPaletteOptions.CustomizePalette then
    begin
      pal := GetPalette;
      if pal <> nil then
        with fPaletteOptions do
          begin
            pal.PredefinedPages := PredefinedPages;
            pal.OnlyDefinedItems := OnlyDefinedItems;
            pal.OnGetButtonHint := OnGetButtonHint;
            //!!! pal.UpdateHints;
            GetPalForm.UseActiveX := UseActiveX;
          end;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.HidePalette;
begin
  HideComponentPalette;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.HasParent : boolean;
begin
  if (Designer <> nil) and Designer.fInSave and not IsStored then
    result := true
  else
    result := inherited HasParent;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetActive(val : boolean);
var
  allowchange : boolean;
begin
  if val = active then
    exit;

  if Assigned(OnActiveChanging) then
    begin
      allowchange := true;
      OnActiveChanging(self, allowchange);
      if not allowchange then
        exit;
    end;

  if not (csDesigning in ComponentState) or Active then
    begin
      if Val then
        begin
          if FShowPalette then
            DisplayPalette;

          if FShowAlignPalette then
            dcgen.ShowAlignPalette;

          fdcomponent := GetRealDesignedComponent;

          if fdcomponent is TDataModule then
            begin
              fdform := fWrapper;
              with TDataModuleWrapper(fWrapper) do
                begin
                  DataModule := TDataModule(fdcomponent);
                  visible := true;
                end;
            end
          else
            fdform := TCustomForm(fdcomponent);

          fDesigner.Form := fdform;

          {with fDesigner do
            NameIsReadOnly := NameIsReadOnly or self.fStoreChanges;}

          if fdComponent is TDataModule then
            SetDesign(fdcomponent, true);

          if fUseCaptionButton then
            CButton.Visible := true;
        end
      else
        begin
          if FShowPalette then
            HidePalette;

          if FShowAlignPalette then
            HideAlignPalette;

          if fStoreChanges then
            begin
              fChanges.Finish;
              SaveChanges;
            end;

          if fdComponent is TDataModule then
            SetDesign(fdcomponent, false);
        end;

      FDesigner.Active := Val;

      if not val and (fdcomponent is TDataModule) then
        fWrapper.visible := false;

      if val and (fdComponent <> nil) then
        fDComponent.FreeNotification(self);
    end;
end;

{------------------------------------------------------------------}

function ObtainChangesKey(const DefaultKey : string; AComponent : TComponent) : string;
begin
  result := DefaultKey;
  if result = '' then
    with AComponent do
      begin
        if Owner <> nil then
          result := GetOriginalComponentName(Owner.Name);

        result := result + GetOriginalComponentName(Name);
      end;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetChangesKey : string;
begin
  result := ObtainChangesKey(fChangesKey, Owner);
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetOptions : TFDOptions;
begin
  result := FDesigner.Options;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetOptions(val : TFDOptions);
begin
  FDesigner.Options := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetGridStepX : TGridStep;
begin
  result := FDesigner.GridStepX;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetGridStepX(val : TGridStep);
begin
  FDesigner.GridStepX := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetGridStepY : TGridStep;
begin
  result := FDesigner.GridStepY;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetGridStepY(val : TGridStep);
begin
  FDesigner.GridStepY := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetLockControls : boolean;
begin
  result := FDesigner.LockControls;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetLockControls(val : boolean);
begin
  FDesigner.LockControls := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetPopupMenu : TPopupMenu;
begin
  result := fDesigner.PopupMenu;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetPopupMenu(val : TPopupMenu);
begin
  FDesigner.PopupMenu := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetShowInspector : boolean;
begin
  result := FDesigner.ShowInspector;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetShowInspector(val : boolean);
begin
  FDesigner.ShowInspector := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetShowGrid : boolean;
begin
  result := FDesigner.ShowGrid;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetShowGrid(val : boolean);
begin
  FDesigner.ShowGrid := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetShowCaptions : boolean;
begin
  result := FDesigner.ShowCaptions;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetShowCaptions(val : boolean);
begin
  FDesigner.ShowCaptions  := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetSnapToGrid : boolean;
begin
  result := FDesigner.SnapToGrid;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetSnapToGrid(val : boolean);
begin
  FDesigner.SnapToGrid  := Val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetNameIsReadOnly : boolean;
begin
  result := FDesigner.NameIsReadOnly;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetNameIsReadOnly(val : boolean);
begin
  FDesigner.NameIsReadOnly := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetLimitInfos : TLimitInfos;
begin
  result := fDesigner.LimitInfos;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetLimitInfos(val : TLimitInfos);
begin
  fDesigner.LimitInfos := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetUseDefaultMenu : boolean;
begin
  result := fDesigner.UseDefaultMenu;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetUseDefaultMenu(val : boolean);
begin
  fDesigner.UseDefaultMenu := val;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetUseGlobalOptions(val : boolean);
begin
  fDesigner.UseGlobalOptions := val;
  if val then
    LoadGlobalOptions;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetUseGlobalOptions : boolean;
begin
  result := fDesigner.UseGlobalOptions;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetLimitControl(Value : TWinControl);
begin
  fDesigner.LimitControl := Value;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetLimitControl : TWinControl;
begin
  result := fDesigner.LimitControl;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetCodeDesigner : TCodeDesigner;
begin
  result := fDesigner.CodeDesigner;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetCodeDesigner(Value : TCodeDesigner);
begin
  fDesigner.CodeDesigner := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetShowComponents : boolean;
begin
  result := fDesigner.ShowComponents;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetShowComponents(val : boolean);
begin
  fDesigner.ShowComponents := val;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetScripter(val : TDCSimpleScripter);
begin
  fDesigner.Scripter := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetScripter : TDCSimpleScripter;
begin
  result := fDesigner.Scripter;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetAllowedActions : TAllowedActions;
begin
  result := fDesigner.AllowedActions;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetAllowedActions(val : TAllowedActions);
begin
  fDesigner.AllowedActions := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetOnGetButtonHint : TOnGetHintEvent;
begin
  result := FPaletteOptions.OnGetButtonHint;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetOnGetButtonHint(Value : TOnGetHintEvent);
begin
  FPaletteOptions.OnGetButtonHint := Value;
end;


{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetReadOnlyProps : TStrings;
begin
  result := fDesigner.ReadOnlyProps;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetReadOnlyProps(val : TStrings);
begin
  fDesigner.ReadOnlyProps := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetHiddenProps : TStrings;
begin
  result := fDesigner.HiddenProps;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetHiddenProps(val : TStrings);
begin
  fDesigner.HiddenProps := val;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetDesignedComponent(val : TComponent);
var
  dcomp : TComponent;
begin
  if val <> fDesignedComponent then
    begin
      fDesignedComponent := val;
      dcomp := GetRealDesignedComponent;
      Designer.OwnerControl := dcomp;
      if fStoreChanges and not (csLoading in ComponentState) then
        fChanges.Start(GetRealDesignedComponent);

      if val <> nil then
        val.FreeNotification(self);
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetPaletteOptions(val : TCompPaletteOptions);
begin
  fPaletteOptions.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetInspectorOptions(Value : TInspOptions);
begin
  FInspectorOptions.Assign(Value); 
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetShowHints : boolean;
begin
  result := fDesigner.ShowHints;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetShowHints(val : boolean);
begin
  fDesigner.ShowHints := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetGridColor : TColor;
begin
  result := fDesigner.GridColor;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetGridColor(val : TColor);
begin
  fDesigner.GridColor := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetAllowUndo : boolean;
begin
  result := fDesigner.AllowUndo;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetAllowUndo(val : boolean);
begin
  fDesigner.AllowUndo := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.GetUseAncestor : boolean;
begin
  result := fDesigner.UseAncestor;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetUseAncestor(val : boolean);
begin
  fDesigner.UseAncestor := val;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.IsPaletteOptionsStored : boolean;
begin
  with PaletteOptions do
    result := CustomizePalette or UseActiveX or OnlyDefinedItems;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.CButtonClick(Sender : TObject);
begin
  Active := not Active;
end;

{------------------------------------------------------------------}

function TCustomLiteDesigner.CButton : TDCCaptionButton;
begin
  if fCBut = nil then
    begin
      fCBut := TDCCaptionButton.Create(nil);
      fCBut.OnClick := CButtonClick;
    end;

  result := fCBut;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetUseCaptionButton(val : boolean);
var
  dcomp : TComponent;
begin
  if val <> fUseCaptionButton then
    begin
      fUseCaptionButton := val;
      if not (csDesigning in ComponentState) then
        begin
          CButton.Glyph.Assign(fCaptionGlyph);
          CButton.Visible := val;
        end;

      if not (csLoading in ComponentState) and (fCBut <> nil) then
        begin
          dcomp := GetRealDesignedComponent;
          if dcomp is TCustomForm then
            fCBut.Form := TCustomForm(dcomp);
        end;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetCaptionGlyph(val : TBitmap);
begin
  fCaptionGlyph.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.SetToolsOnTop(val : boolean);
begin
  if val <> fToolsOnTop then
    begin
      fToolsOnTop := val;
      ToolFormsOnTop := val;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if (Operation <> opRemove) then
    exit;

  if (AComponent = fDComponent) and (csDestroying in AComponent.ComponentState) then
    begin
      Active := false;
      fdComponent := nil;
    end;

  if (csDestroying in ComponentState) then
    exit;

  if fDesigner.fUsedModules.IndexOf(AComponent) >= 0 then
    RemoveUsedModule(AComponent);

  if AComponent = PopupMenu then
    PopupMenu := nil;

  if (AComponent = fDesignedComponent) then
    DesignedComponent := nil;

  if (AComponent = CodeDesigner) then
    CodeDesigner := nil;

  if (AComponent = Scripter) then
    Scripter := nil;

  if not (csDestroying in ComponentState) and (AComponent = LimitControl) then
    LimitControl := nil;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.CanPaste : boolean;
begin
  result := DesignerCanPaste;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.CanCut   : boolean;
begin
  result := Designer.SelectedComponents.Count > 0;
end;

{------------------------------------------------------------------}

function  TCustomLiteDesigner.CanCopy  : boolean;
begin
  result := Designer.SelectedComponents.Count > 0;
end;

{------------------------------------------------------------------}

procedure TCustomLiteDesigner.IsPropStored(Sender : TObject; Instance : TObject; const PropName : string; var Store : boolean);
begin
  if Assigned(OnStoreProp) then
    OnStoreProp(self, Instance, PropName, Store);
end;

{------------------------------------------------------------------}

procedure TInspOptions.SetHideEvents(Value : boolean);
begin
  if FHideEvents <> Value then
  begin
    FHideEvents := Value;
    HideEventsInInspector := Value;
  end;
end;

{******************************************************************}

function GlobalDreamDesignerOptions : TDCLiteDesignerOptions;
begin
  result := TDCLiteDesignerOptions(GetOptionsByClass(TDCLiteDesignerOptions));
end;

{******************************************************************}
{$IFDEF D3}
constructor TDCChangesStore.Create(AOwner : TComponent);
begin
  inherited;
  fChanges := TDCCompChanges.Create;
  fHandleObject := TDCHandleObject.Create(self);
  if not (csDesigning in ComponentState) then
    AddWndHook(self);
  ChangesStoreList.Add(self);
end;

{------------------------------------------------------------------}

destructor TDCChangesStore.Destroy;
begin
  RemoveWndHook(self);
  ChangesStoreList.Remove(self);
  fChanges.Free;
  fHandleObject.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TDCChangesStore.Loaded;
begin
  inherited;
  if not (fLoaded or (csDesigning in ComponentState)) then
    begin
      fHandleObject.PostMsg(CM_ALLLOADED, 0, 0);
      fLoaded := true;
    end;
end;

{------------------------------------------------------------------}

procedure TDCChangesStore.SaveChanges;
var
  processed : boolean;
begin
  processed := false;

  if Assigned(OnSaveChanges) then
    OnSaveChanges(self, processed);

  if not processed then
    fChanges.SaveToRegistry(GetChangesKey);
end;

{------------------------------------------------------------------}

procedure TDCChangesStore.LoadChanges;
var
  processed : boolean;
begin
  processed := false;

  if Assigned(OnLoadChanges) then
    OnLoadChanges(self, processed);

  if not processed then
    fChanges.LoadFromRegistry(GetTopOwner(self), GetChangesKey);
end;

{------------------------------------------------------------------}

procedure TDCChangesStore.AllLoaded(var Message : TMessage);
begin
  fChanges.Start(GetTopOwner(self));
  LoadChanges;
end;

{------------------------------------------------------------------}

function  TDCChangesStore.GetChangesKey : string;
begin
  result := ObtainChangesKey(fChangesKey, Owner);
end;

{------------------------------------------------------------------}

procedure TDCChangesStore.HookProc(var Msg : TMessage);
var
  f : TComponent;
begin
  with PCWPStruct(Msg.wParam)^ do
    if message = CM_RELEASE then
      begin
        f := GetTopOwner(self);
        if f is TCustomForm then
          if hWnd = TCustomForm(f).Handle then
            SaveChanges;
      end;
end;

{------------------------------------------------------------------}

procedure TDCChangesStore._AppTerminate;
begin
  fChanges.Finish;
  SaveChanges;
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF D4}
{$IFNDEF D6}

type
  TPersistentIntfWrapper = class(TInterfacedObject, IImplementation, IPersistent)
  private
    fObject : TPersistent;
  public
    constructor Create(AnObject : TPersistent);

    {IImplementation}
    function GetInstance: TObject;

    {IPersistent}
    procedure DestroyObject;
    function Equals(const Other: IPersistent): Boolean;
    function GetClassname: string;
    function GetEventInfos: IEventInfos;
    function GetNamePath: string;
    function GetOwner: IPersistent;
    function InheritsFrom(const Classname: string): Boolean;
    function IsComponent: Boolean;
    function IsControl: Boolean;
    function IsWinControl: Boolean;
    {function GetInstanceAsPersistent:TPersistent;}
  end;

  TComponentIntfWrapper = class(TPersistentIntfWrapper, IComponent)
  private
    function  GetComponent : TComponent;
    function  _GetOwner : IComponent;
  public
    function FindComponent(const Name: string): IComponent;
    function GetComponentCount: Integer;
    function GetComponents(Index: Integer): IComponent;
    function GetComponentState: TComponentState;
    function GetComponentStyle: TComponentStyle;
    function GetDesignInfo: TSmallPoint;
    function GetDesignOffset: TPoint;
    function GetDesignSize: TPoint;
    function GetName: string;
    function IComponent.GetOwner = _GetOwner;
    function GetParent: IComponent;
    procedure SetDesignInfo(const Point: TSmallPoint);
    procedure SetDesignOffset(const Point: TPoint);
    procedure SetDesignSize(const Point: TPoint);
    procedure SetName(const Value: string);
    property  Comp : TComponent read GetComponent;
  end;

{------------------------------------------------------------------}
{
function TPersistentIntfWrapper.GetInstanceAsPersistent:TPersistent;
begin
  Result:=FObject;
end;
}
{------------------------------------------------------------------}

function DCMakeIPersistentProc(Instance: TPersistent): IPersistent;
begin
  result := TPersistentIntfWrapper.Create(Instance);
end;

{------------------------------------------------------------------}

constructor TPersistentIntfWrapper.Create(AnObject : TPersistent);
begin
  inherited Create;
  fObject := AnObject;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.GetInstance: TObject;
begin
  result := fObject;
end;

{------------------------------------------------------------------}

procedure TPersistentIntfWrapper.DestroyObject;
begin

end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.Equals(const Other: IPersistent): Boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.GetClassname: string;
begin
  if fObject <> nil then
    result := fObject.ClassName;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.GetEventInfos: IEventInfos;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.GetNamePath: string;
begin
  if fObject <> nil then
    result := fObject.GetNamePath;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.GetOwner: IPersistent;
begin
  result := nil;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.InheritsFrom(const Classname: string): Boolean;
begin
  result := fObject.InheritsFrom(GetClass(ClassName));
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.IsComponent: Boolean;
begin
  result := fObject is TComponent;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.IsControl: Boolean;
begin
  If Assigned(DCObjectIsControl) then
    Result:=DCObjectIsControl(FObject)
  else
    Result:=False;
end;

{------------------------------------------------------------------}

function TPersistentIntfWrapper.IsWinControl: Boolean;
begin
  If Assigned(DCObjectIsWinControl) then
    Result:=DCObjectIsWinControl(FObject)
  else
    Result:=False;
end;

{------------------------------------------------------------------}

function DCMakeIComponentProc(Instance: TComponent) : IComponent;
begin
  result := TComponentIntfWrapper.Create(Instance);
end;


{------------------------------------------------------------------}

function TComponentIntfWrapper.GetComponent : TComponent;
begin
  result := TComponent(GetInstance);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.FindComponent(const Name: string): IComponent;
begin
  Result:=DCMakeIComponentProc(Comp.FindComponent(Name));
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetComponentCount: Integer;
begin
  result := Comp.ComponentCount
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetComponents(Index: Integer): IComponent;
begin
  result := DCMakeIComponentProc(Comp.Components[Index]);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetComponentState: TComponentState;
begin
  result := Comp.ComponentState;
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetComponentStyle: TComponentStyle;
begin
  result := Comp.ComponentStyle;
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetDesignInfo: TSmallPoint;
begin
  with Comp do
    result := SmallPoint(LongRec(DesignInfo).Lo, LongRec(DesignInfo).Hi);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetDesignOffset: TPoint;
begin
  if Comp is TDataModule then
    result := TDataModule(Comp).DesignOffset
  else
    result := Point(0, 0);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetDesignSize: TPoint;
begin
  if Comp is TDataModule then
    result := TDataModule(Comp).DesignSize
  else
    result := Point(0, 0);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetName: string;
begin
 result := Comp.Name;
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper._GetOwner: IComponent;
begin
 result := DCMakeIComponentProc(Comp.Owner);
end;

{------------------------------------------------------------------}

function TComponentIntfWrapper.GetParent: IComponent;
begin
 result := DCMakeIComponentProc(Comp.GetParentComponent);
end;

{------------------------------------------------------------------}

procedure TComponentIntfWrapper.SetDesignInfo(const Point: TSmallPoint);
begin
end;

{------------------------------------------------------------------}

procedure TComponentIntfWrapper.SetDesignOffset(const Point: TPoint);
begin
end;

{------------------------------------------------------------------}

procedure TComponentIntfWrapper.SetDesignSize(const Point: TPoint);
begin
end;

{------------------------------------------------------------------}

procedure TComponentIntfWrapper.SetName(const Value: string);
begin
end;

{$ENDIF}
{$ENDIF}

{----------------}

function  TDCFormDesigner.InUpdate;
begin
  result := fUpdateCount > 0;
end;

{----------------}

initialization
  TypeToString := UniTypeToString;
  RunRegister;

  {$IFDEF D4}
  {$IFNDEF D6}
  if @MakeIPersistentProc = nil then
    MakeIPersistentProc := DCMakeIPersistentProc;

  if @MakeIComponentProc = nil then
    MakeIComponentProc  := DCMakeIComponentProc;
  {$ENDIF}
  {$ENDIF}


finalization
  FreeObject(fDDesignerList,fDDesignerList);
  FreeObject(fDCFormDesigners,fDCFormDesigners);
  {$IFDEF D4}
  {$IFNDEF D6}
  if @MakeIPersistentProc = @DCMakeIPersistentProc then
    MakeIPersistentProc := nil;
  if @MakeIComponentProc = @DCMakeIComponentProc then
    MakeIComponentProc  := nil;
  {$ENDIF}  
  {$ENDIF}
end.

