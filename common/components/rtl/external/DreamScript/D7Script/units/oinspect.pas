{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit oinspect;
interface
{$I dc.inc}
uses
  dcsystem, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, typinfo,

  {$IFDEF D6}
  RTLConsts,
  {$ENDIF}

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  stdctrls, menus, extctrls, consts, dcconsts,
  dcedit, dcpedit, dcgen, dccommon, dcstrled, dchook, dcdreamlib, dccontrols,

  olectrls,
  olectnrs,
  {$IFDEF D3}
  activex, comobj, axctrls, stdvcl,
  {$ELSE}
  ole2, oleauto, olectl,
  {$ENDIF}
  glyphed
  {$IFDEF D6}, Variants{$ENDIF}
  ;

{$R *.res}

{$IFNDEF D3}
type
  WideString = TBStr;

  PLongintList = ^TLongintList;
  TLongintList = array[0..65535] of Longint;
  {$ENDIF}

type
  TSplitterNotifyProc = procedure(Sender: TObject; X: integer) of object;

  TEditClickProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty;
    var Processed: boolean) of object;
  TGetCellParamsProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty;
    Column: integer; Font: TFont) of object;
  TDrawCellProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty; Column: integer;
    ARect: TRect; var Processed: boolean) of object;

  TOIOption = (oiHorzLine, oiVertLine, oiJoinControls, oiSunkenEditor, oiVertLine3D,
    oiUseAliases, oiUseGroups, oiEditBorder, oiSmartPopup, oiUnSorted,
    oiEnterMoveDown, oiTabMoveDown, oiShowActiveX, oiShowAxHelp,
    oiGroupsDown);

  TExpandMode = (Default, AutoExpand, AlwaysExpand, AutoCollapse);

  TOIOptions = set of TOIOption;

  TLineStyle = (SolidLine, DottedLine);
  TInspectorStyle = (isDelphi, isVB, isCustom);
  TChangedProc = procedure(Sender: TObject) of object;

  TOnShowProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty; var show: boolean) of object;
  TOnEditProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty; var AllowEdit: boolean) of object;
  TGetDisplayNameProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty; const FullName: string; var PropName: string) of object;
  TChangeValueProc = procedure(Sender: TObject; const PropEdit: TDCDsgnProperty; var newval: string) of object;
  TOICompareEvent = procedure(Sender: TObject; const PropEdit1, PropEdit2: TDCDsgnProperty; var Compare: integer) of object;

  TOIColors = class(TPersistent)
  private
    fBackColor: TColor;
    fCol0Color: TColor;
    fCol1Color: TColor;
    fVertLineColor: TColor;
    fHorzLineColor: TColor;
    fHighlightColor: TColor;
    fHighlightBkgnd: TColor;

    fOnChange: TChangedProc;

    procedure SetBackColor(val: TColor);
    procedure SetCol0Color(val: TColor);
    procedure SetCol1Color(val: TColor);
    procedure SetVertLineColor(val: TColor);
    procedure SetHorzLineColor(val: TColor);
    procedure SetHighlightColor(val: TColor);
    procedure SetHighlightBkgnd(val: TColor);
    procedure Changed;
  public
    constructor Create;
    property OnChange: TChangedProc read fOnChange write fOnChange;
  published
    property BackColor: TColor read fBackColor write SetBackColor;
    property Col0Color: TColor read fCol0Color write SetCol0Color;
    property Col1Color: TColor read fCol1Color write SetCol1Color;
    property VertLineColor: TColor read fVertLineColor write SetVertLineColor;
    property HorzLineColor: TColor read fHorzLineColor write SetHorzLineColor;
    property HighlightColor: TColor read fHighlightColor write SetHighlightColor;
    property HighlightBkgnd: TColor read fHighlightBkgnd write SetHighlightBkgnd;
  end;

type
  TSubState = (ssNoSub, ssExpanded, ssCollapsed);

type
  TInfoRec = class
  public
    PropEdit: TDCDsgnProp;
    name: string;
    realname: string;
    sublevel: integer;
    parent: integer;

    group: integer;
    editclass: TControlClass;
    popupclass: TWinControlClass;

    substate: TSubState;

    AutoExpand: boolean;
    Alwaysexpand: boolean;
    NeverExpand: boolean;
    AutoCollapse : boolean;
    NeverShow: boolean;
    PReadOnly: boolean;
    groupname: boolean;
{
    NeedFree: boolean;
}
    destructor Destroy; override;
  end;

type
  TInplaceEditClass = class of TCustomDCEdit;

  TCustomObjectInspector = class(TCustomGrid)
  private
    ctrls: TList;
    flist: TStringList;
    rcount: integer;
    arow: integer;

    FDesigner: TFormDesigner;
    fdesign: TFormDesigner;

    HitPos: TPoint;
    CurSizePos: integer;
    feditrow: integer;
    fUpdateCount: integer;
    fOptions: TOIOptions;
    faliases: TStringList;
    fa2: TStringList;
    fSplitterSize: integer;
    fExpandMode: TExpandMode;
    fColors: TOIColors;
    fGroupFont: TFont;
    fOtherGroupName: string;
    fOtherGroup: integer;
    fInfos: TList;
    fStyle: TInspectorStyle;
    fDescs: TStrings;
    fDescNames: TStringList;

    {$IFDEF D6}
    fEditList:TDCInterfaceList;
    {$ELSE}
    fEditList:TList;
    {$ENDIF}

    fObjects: TList;
    fEditors: TList;
    fExpandList: TStringList;
    fCollapseList: TStringList;

    fgroups: TStringList;
    fOnShowProperty: TOnShowProc;
    fOnSplitterMoving: TSplitterNotifyProc;
    fOnSplitterMoved: TSplitterNotifyProc;
    fOnEditButtonClick: TEditClickProc;
    fOnGetCellParams: TGetCellParamsProc;
    fOnDrawCell: TDrawCellProc;
    fOnChangePropValue: TChangeValueProc;
    fOnChangedPropValue: TChangeValueProc;
    fOnGetDisplayName: TGetDisplayNameProc;
    plusglyph: TBitmap;
    minusglyph: TBitmap;
    fOnComponentChanged: TNotifyEvent;
    fOnActivePropertyChanged: TNotifyEvent;
    fOnEditProperty: TOnEditProc;
    fcedit: TDCDsgnComp;
    fmenu: TPopupMenu;
    fDesigner_: TFormDesigner;
    fPropOrder: TStrings;
    fReadOnlyProps: TStrings;
    fHiddenProps: TStrings;
    fDisplayedProps: TStrings;
    fHint: TDCHint;

    fWheelDelta: smallint;
    fFilter: TTypeKinds;
    fOldScrollBars: TScrollStyle;
    flinestyle: TLineStyle;
    ColSizing: boolean;
    EditActive: boolean;
    fDrawSelection: boolean;
    fUpdated: boolean;
    fReadOnly: boolean;
    fUseGlobalOptions: boolean;
    fDoubleClicked: boolean;
    NoInvalidateMode: boolean;
    fSmartRefresh: boolean;
    fTrackDestroy: boolean;
    fCustomSort: boolean;
    fShowHints: boolean;
    fUseOtherGroup: boolean;
    fAutoSizeNames: boolean;
    fInShowInfo: boolean;

    FVersion: TDCVersion;

    function EqualWithList(List: TObject): boolean;
    procedure showinfo;
    procedure Col0DblClick;
    procedure Col1DblClick;
    procedure KillEditor;
    procedure CreateInplaceEditor(arow: longint);
    {$IFDEF D6}
    procedure GetPropEdit(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure GetPropEdit(Prop: TDCDsgnProp);
    {$ENDIF}
    procedure UpdateEditor;
    procedure MoveEditor;
    procedure DoEdit(arow: integer);
    procedure ClientToScreenRect(var Rect: TRect);
    procedure DrawSizingLine;
    function FindAlias(const s: string): pointer;
    procedure SetFilter(val: TTypeKinds);
    procedure SetStyle(val: TInspectorStyle);
    procedure DrawLines;
    procedure DoPlusMinus(arow: integer);
    function isnear(x, y: integer): boolean;
    procedure DrawHorzLine(y: integer);
    procedure ScanAliases;
    function GetInfoRec(Index: Longint): TInfoRec;
    procedure ColorsChanged(sender: TObject);
    procedure CollapseRow(arow: integer);
    procedure ExpandGroup(arow: integer);
    procedure DrawVertLine;
    procedure UpdateScrollBar;
    procedure SetDelphiStyle;
    procedure SetVBStyle;
    procedure SetDescriptions(val: TStrings);
    procedure SetDesignerForm(control: TPersistent);
    function GetEditor(editclass: TControlClass): TControl;
    procedure AliasesChanged(Sender: TObject);
    procedure ShowPopup(X, Y: integer);
    function GetAliases: TStrings;
    function GetProperty(arow: integer): string;
    function GetRealProperty(arow: integer): string;
    function GetActiveProperty: string;
    procedure ProcessDblClick;
    procedure NotifyChange;
    procedure FreeInfoRecs;
    procedure DescsChanged(Sender: TObject);
    procedure ParamsChanged(Sender: TObject);
    procedure ShowAxHelp; virtual;

    procedure SetDesigner(val: TFormDesigner);
    procedure SetExpandMode(val: TExpandMode);
    procedure SetGridOptions(val: TOIOptions);
    procedure SetLineStyle(val: TLineStyle);
    procedure SetColors(val: TOIColors);
    procedure SetFixedColWidth(val: integer);
    procedure SetGroupFont(val: TFont);
    procedure SetOtherGroupName(const val: string);
    procedure SetReadOnly(val: boolean);
    procedure SetOnShowProperty(val: TOnShowProc);
    procedure SetOnGetCellParams(val: TGetCellParamsProc);
    procedure SetEditRow(val: integer);
    procedure SetAliases(val: TStrings);
    procedure SetTrackDestroy(val: boolean);
    procedure SetPropOrder(val: TStrings);
    procedure SetCustomSort(val: boolean);
    procedure SetReadOnlyProps(val: TStrings);
    procedure SetHiddenProps(val: TStrings);
    procedure SetDisplayedProps(val: TStrings);
    procedure SetUseOtherGroup(val: boolean);

    function GetFixedColWidth: integer;

    procedure SetUseGlobalOptions(val: boolean);
    function GetUseGlobalOptions: boolean;

    function FindPropDesc(const PropName: string): integer;
    procedure LoadGlobalOptions;
    procedure _SetFocusToProperty(PropName: string; UseRealNames: boolean);
    function _GetProperty(arow: integer; UseRealNames: boolean): string;
    procedure ScrollToTopRow(newrow: integer);
    procedure EditRowChanged;
    procedure DestroyNotification(Instance: TObject);
    procedure ClearControls;
    procedure AddFreeNotify(Instance: TPersistent);
    procedure RemoveFreeNotify(Instance: TPersistent);
    procedure DragRow(x, y: integer);
    function GetHint: TDCHint;
    function GetXTextOffset(arow: integer): integer;
    procedure DisplayHint;
    procedure HideHint;
    function IsOtherGroupNameStored: boolean;
    procedure AddToCtrlsList(Instance: TPersistent);
    function GetGroupRow(const AGroupName: string): integer;
    procedure DoGetDisplayName(irec: TInfoRec; arow: integer);

    property _Hint: TDCHint read GetHint;
  protected
    fEmptyList: boolean;
    Editor: TCustomDCEdit;

    procedure EditClick(Sender: TObject);
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHitTest;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure PropChanged(var Msg: TMessage); message CM_PROPCHANGED;
    //procedure SelectionChanged(var Msg : TMessage); message CM_SELECTIONCHANGED;
    procedure CMOBJDESTROYED(var Msg: TMessage); message CM_OBJDESTROYED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMInspectorRescan(var Message: TMessage); message CM_INSPECTORRESCAN;
    procedure WMMouseWheel(var Message: TMessage); message{$IFDEF D4}CM_MOUSEWHEEL{$ELSE}WM_MOUSEWHEEL{$ENDIF};
    procedure CMMOUSELEAVE(var Message: TMessage); message CM_MOUSELEAVE;
    procedure Loaded; override;
    procedure SetParent(AParent: TWinControl); override;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure SetControl(control: TPersistent);
    function GetControl: TPersistent;
    procedure TopLeftChanged; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure ExpandAuto;
    procedure CollapseAuto;
    function GetInplaceEditClass: TInplaceEditClass; virtual;

    procedure ChangeValue(const PropEdit: TDCDsgnProp; val: string); virtual;
    procedure UpdateEditorState(Editor: TCustomDCEdit; const PropEdit: TDCDsgnProp); virtual;
    function GetEditorClass(const PropEdit: TDCDsgnProp): TControlClass; virtual;
    function GetPopupClass(const PropEdit: TDCDsgnProp): TWinControlClass; virtual;
    function AllowEdit(const PropEdit: TDCDsgnProp): boolean;
    function AllowShowProp(const PropEdit: TDCDsgnProp): boolean;
    function GetRealName(const Prop: TDCDsgnProp): string; virtual;
    procedure AddEditorToEditorList(const PropEdit: TDCDsgnProp);

    procedure ComponentChanged; virtual;

    procedure GetAllPropertyEditors(Components: TComponentList;
      Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc); virtual;

    function IsEmpty: boolean; virtual;
    function CanHaveSubNodes: boolean; virtual;

    function IsInspectorKey(key: word; Shift: TShiftState): boolean; virtual;
    function GetGroupCount: integer;
    function GetActivePropDesc: string; virtual;
    function _getname(index: integer; UseRealNames: boolean): string;
    procedure GetMouseCell(var cell: TGridCoord);
    procedure UpdateEditorValue; virtual;

  public
    property InfoRec[Index: Longint]: TinfoRec read GetInfoRec;
    procedure Invalidate; override;
    procedure GetTabOrderList(List: TList); override;
    property Designer: TFormDesigner read fDesigner_ write SetDesigner;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateParams(var Params: TCreateParams); override;

    procedure SetControls(Controls: TList);

    procedure AddControls(Controls: TList);

    procedure DelControls(Controls: TList);

    procedure AddControl(Control: TPersistent);

    procedure DelControl(Control: TPersistent);

    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ExpandAll;
    procedure CollapseAll;
    procedure ReScan;
    procedure SetFocusToProperty(PropName: string);
    procedure SetFocusToRealProperty(PropName: string);
    procedure UpdateValues;

    procedure ExpandGroupByName(const GroupName: string);
    procedure CollapseGroupByName(const GroupName: string);
    procedure SetEditorToRow(newrow: integer);

    property CurrentControl: TPersistent read GetControl write SetControl;
    property CurrentControls: TList read ctrls write SetControls;
    property Canvas;
    property InternalDesigner: TFormDesigner read fDesigner;
    property ActiveProperty: string read GetActiveProperty write SetFocusToProperty;
    property ActivePropDesc: string read GetActivePropDesc;
    property Filter: TTypeKinds read fFilter write SetFilter default tkAny - [tkMethod];
    property ExpandMode: TExpandMode read fExpandMode write SetExpandMode default default;
    property Style: TInspectorStyle read fStyle write SetStyle;
    property Aliases: TStrings read GetAliases write SetAliases;
    property Descriptions: TStrings read fDescs write SetDescriptions;
    property Options: TOIOptions read fOptions write SetGridOptions;
    property SplitterSize: integer read fSplitterSize write fSplitterSize default 3;
    property OtherGroupName: string read fOtherGroupName write SetOtherGroupName stored IsOtherGroupNameStored;
    property GroupFont: TFont read fGroupFont write SetGroupFont;
    property ShowHints: boolean read fShowHints write fShowHints default False;

    property OnChangePropValue: TChangeValueProc read fOnChangePropValue write fOnChangePropValue;
    property OnChangedPropValue: TChangeValueProc read fOnChangedPropValue write fOnChangedPropValue;
    property OnShowProperty: TOnShowProc read fOnShowProperty write SetOnShowProperty;
    property OnSplitterMoving: TSplitterNotifyProc read fOnSplitterMoving write fOnSplitterMoving;
    property OnSplitterMoved: TSplitterNotifyProc read fOnSplitterMoved write fOnSplitterMoved;
    property OnEditButtonClick: TEditClickProc read fOnEditButtonClick write fOnEditButtonClick;
    property OnGetCellParams: TGetCellParamsProc read fOnGetCellParams write SetOnGetCellParams;
    property OnDrawCell: TDrawCellProc read fOnDrawCell write fOnDrawCell;
    property OnComponentChanged: TNotifyEvent read fOnComponentChanged write fOnComponentChanged;
    property OnEditProperty: TOnEditProc read fOnEditProperty write fOnEditProperty;
    property OnGetDisplayName: TGetDisplayNameProc read fOnGetDisplayName write fOnGetDisplayName;

    property Colors: TOIColors read fColors write SetColors;
    property CustomSort: boolean read fCustomSort write SetCustomSort default False;
    property FixedColWidth: integer read GetFixedColWidth write SetFixedColWidth;
    property LineStyle: TLineStyle read flinestyle write SetLineStyle default DottedLine;
    property ReadOnly: boolean read fReadOnly write SetReadOnly default False;
    property EditRow: integer read fEditRow write SetEditRow;
    property OnActivePropertyChanged: TNotifyEvent read fOnActivePropertyChanged write fOnActivePropertyChanged;
    property GroupCount: integer read GetGroupCount;
    property SmartRefresh: boolean read fSmartRefresh write fSmartRefresh default True;
    property TrackDestroy: boolean read fTrackDestroy write SetTrackDestroy;
    property PropOrder: TStrings read fPropOrder write SetPropOrder;
    property ReadOnlyProps: TStrings read fReadOnlyProps write SetReadOnlyProps;
    property HiddenProps: TStrings read fHiddenProps write SetHiddenProps;
    property DisplayedProps: TStrings read fDisplayedProps write SetDisplayedProps;
    property UseOtherGroup: boolean read fUseOtherGroup write SetUseOtherGroup default True;
    property UseGlobalOptions: boolean read GetUseGlobalOptions write SetUseGlobalOptions default False;
    property AutoSizeNames: boolean read fAutoSizeNames write fAutoSizeNames;
  published
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TCustomAxInspector = class;

  TAxPropEditor = class(TPropertyEditor {$IFDEF D6},IPSCGetInstance{$ENDIF})
  private
    fPropName: string;
    fdispid: TDispID;
    fpclsid: TCLSID;
    disp: IDispatch;
    fiti: ITypeInfo;
    fpropbrowse: IPerPropertyBrowsing;
    fcstr: TCAPOleStr;
    fccook: TCALongint;
    fenumdesc: TStringList;
    fiscolor: boolean;
    fIsEvent: boolean;
    fBindable: boolean;
    //    fImageList  : boolean;
    fDocString: WideString;
    fHelp: integer;
    fHelpFile: WideString;
    funcdesc: PFuncDesc;
    fmemid: TMemberID;

    fInspector: TCustomAxInspector;

    function IsIntfProperty(const aguid: TGUID): boolean;
    function IsFontProperty: boolean;
    function IsImageProperty: boolean;
    function IsStringListProperty: boolean;
    procedure EditFont;
    procedure EditImage;
    {$IFDEF D3}
    procedure EditStringList;
    {$ENDIF}
    procedure EditPropPage;
    procedure EditEvent;
    procedure FillTypeData(var tdata: TTypeData);
    procedure GetEvents(Proc: TGetStrProc);
    procedure SetEventValue(const Value: string);
    function GetEventValue: string;
    function GetFormMethodName: string;
    function GetTrimmedEventName: string;
    procedure _setVal(const varg: TVariantArg);
    function _GetPropType: PTypeInfo;
  protected
    {IPSCGetInstance}
    function GetIntfImplementer:TObject;
  public
    function GetName: string; override;
    function GetValue: string; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure Edit; override;
    destructor Destroy; override;
  end;

  TCustomAxInspector = class(TCustomObjectInspector)
  private
    fFake: TComponent;
    fFake2: TComponent;
    fFakeList: TComponentList;
    fFakeList2: TComponentList;

    fEdit: TDCDsgnProp;
    fedit2: TDCDsgnProp;
    fMultiEdit: TDCDsgnProp;

    fOleObject: IOleObject;
    fOleControl: TCustomDCOleControl;
    fOnCompare: TOICompareEvent;

    fiscontainer: boolean;
    fiswrapper: boolean;

    {$IFDEF D6}
    procedure GetPropEdit(const Prop: TDCDsgnProp);
    procedure GetPropEdit2(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure GetPropEdit(Prop: TDCDsgnProp);
    procedure GetPropEdit2(Prop: TDCDsgnProp);
    {$ENDIF}

    function IsColorProperty(memid: TMemberID; iti: ITypeInfo; TypeDesc: TTypeDesc): boolean;

    procedure GetProperties(AComp: TComponent; ShowEvents: boolean;
      idisp: IDispatch; iti: ITypeInfo; Proc: TGetPropEditProc);

    {$IFDEF D6}
    procedure _getpropedit(const propedit: TDCDsgnProp);
    procedure _GetMultiPropEdit(const Prop: TDCDsgnProp);
    {$ELSE}
    procedure _getpropedit(propedit: TDCDsgnProp);
    procedure _GetMultiPropEdit(Prop: TDCDsgnProp);
    {$ENDIF}

    procedure SortEditorsList;

    procedure GetPropertyEditors(AComponent: TComponent;
      Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc);

    procedure SetOnCompare(val: TOICompareEvent);

  protected
    function ComparePropEditorsByPropName(const Prop1, Prop2: TDCDsgnProp): integer;virtual;

    procedure GetAllPropertyEditors(Components: TComponentList;
      Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc); override;

    function GetInplaceEditClass: TInplaceEditClass; override;

    function GetEditorClass(const PropEdit: TDCDsgnProp): TControlClass; override;
    function GetPopupClass(const PropEdit: TDCDsgnProp): TWinControlClass; override;
    function ComparePropEditors(const Prop1, Prop2: TDCDsgnProp): integer; virtual;

    function GetActivePropDesc: string; override;
    function GetDisplayName: string;
    procedure ShowAxHelp; override;
    function IsOCX(Instance: TObject): boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property OnCompare: TOICompareEvent read fOnCompare write SetOnCompare;
  published
    { Published declarations }
  end;

  TObjectInspector = class(TCustomAxInspector)
    (*
    {$ELSE}
    TObjectInspector = class(TCustomObjectInspector)
    {$ENDIF}
    *)
  published
    property Aliases;
    property Align;
    property AutoSizeNames;
    property BorderStyle;
    {$IFDEF D4}
    property Anchors;
    property BiDiMode;
    {$ENDIF}

    property Colors;
    {$IFDEF D4}
    property Constraints;
    {$ENDIF}
    property Ctl3D;

    property CustomSort;
    property Descriptions;
    property DefaultRowHeight;
    property DragCursor;
    {$IFDEF D4}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;

    property ExpandMode;
    property Filter;
    property FixedColWidth;
    property Font;
    property GroupFont;

    property HiddenProps;
    property ReadOnlyProps;
    property DisplayedProps;

    property LineStyle;

    property Style;
    property Options;
    property OtherGroupName;
    property PropOrder;
    {$IFDEF D4}
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property ShowHints;
    property SmartRefresh;
    property SplitterSize;

    property TabOrder;
    property TabStop;
    property TrackDestroy;
    property UseOtherGroup;
    property UseGlobalOptions;
    property Visible;
    property OnActivePropertyChanged;
    property OnChangePropValue;
    property OnChangedPropValue;
    property OnClick;
    property OnCompare;
    property OnComponentChanged;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawCell;
    property OnEditButtonClick;
    {$IFDEF D4}
    property OnEndDock;
    {$ENDIF}

    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetCellParams;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF D4}
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    {$ENDIF}
    property OnEditProperty;
    property OnShowProperty;
    property OnSplitterMoving;
    property OnSplitterMoved;
    property OnGetDisplayName;
    {$IFDEF D4}
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;

type
  TOInplaceEdit = class(TDCCustomPropEditor)
  private
    Inspector: TCustomObjectInspector;
    needtorefresh: boolean;
    fTrackPropChange: boolean;

    procedure InternalMove(Loc: TRect; Redraw: Boolean);
    procedure SetInspector(Value: TCustomObjectInspector);
  protected
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure Paint; override;
    procedure DoTerm; override;
    procedure ValidateEditorClass(var c: TControlClass); override;
    procedure GetDropValue; override;
    procedure ResetAfterCreateHandle; override;
    procedure DoAutoUpdate; override;

    property TrackPropChange: boolean read fTrackPropChange write fTrackPropChange;
  public
    CreateTime: Longint;
    constructor Create(AOwner: TComponent); override;
    procedure Hide;
    procedure Invalidate; override;
    procedure Move(Loc: TRect);
  published
    property Flat;
  end;

type
  TPropHelpBorderStyle = (pbsNone, pbsSingle, pbsSunken);

  TPropertyHelp = class(TCustomControl)
  private
    fPropertyFont: TFont;
    fBorderStyle: TPropHelpBorderStyle;
    fInspector: TCustomObjectInspector;
    FVersion: TDCVersion;

    procedure SetPropertyFont(val: TFont);
    procedure SetBorderStyle(val: TPropHelpBorderStyle);
    procedure SetInspector(val: TCustomObjectInspector);
    procedure OnInvalidate(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure PropChanged(var Msg: TMessage); message CM_INSPECTOR_CHANGED;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_EraseBkgnd;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BorderStyle: TPropHelpBorderStyle read FBorderStyle write SetBorderStyle default pbsSunken;

    property Align;
    property ShowHint;
    property Visible;
    property Enabled;
    property Inspector: TCustomObjectInspector read fInspector write SetInspector;
    property Color;
    property DragCursor;
    property DragMode;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PropertyFont: TFont read fPropertyFont write SetPropertyFont;

    property Version: TDCVersion read FVersion write FVersion stored false;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;

    property Constraints;
    property DragKind;

    property ParentBiDiMode;

    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;

type
  TInspectorOptions = class(TOptionExt)
  private
    FAliases: TStrings;
    FHiddenprops: TStrings;
    FDisplayedProps: TStrings;
    FStyle: TInspectorStyle;
    FOptions: TOIOptions;
    fShowHints: boolean;

    procedure SetAliases(val: TStrings);
    procedure SetHiddenProps(val: TStrings);
    procedure SetDisplayedProps(val: TStrings);
    procedure SetStyle(val: TInspectorStyle);
    procedure SetOptions(const val: TOIOptions);
    procedure SetShowHints(val: boolean);

    procedure StringsChanged(Sender: TObject);
  protected
    procedure Update; override;
    function GetKey: string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure InitValues; override;
  published
    property Aliases: TStrings read FAliases write SetAliases;
    property HiddenProps: TStrings read FHiddenProps write SetHiddenProps;
    property DisplayedProps: TStrings read FDisplayedProps write SetDisplayedProps;
    property Options: TOIOptions read FOptions write SetOptions;
    property Style: TInspectorStyle read FStyle write SetStyle;
    property ShowHints: boolean read fShowHints write SetShowHints;
  end;

  TInspectorList = class(TList)
  private
    function GetInspector(index: integer): TCustomObjectInspector;
  public
    property Inspectors[index: Integer]: TCustomObjectInspector read GetInspector; default;
  end;

function InspectorList: TInspectorList;

function GlobalInspectorOptions: TInspectorOptions;

procedure AddNonInspectorEditClass(aclass: TControlClass);

{$IFDEF D6}
function TypeDescToString(Designer: IDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ELSE}
function TypeDescToString(Designer: TFormDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ENDIF}

{$IFDEF D6}
function PSCAxPropEditor(A:IUnknown):TAxPropEditor;
{$ELSE}
function PSCAxPropEditor(A:TPropertyEditor):TAxPropEditor;
{$ENDIF}

implementation

type
  TMComponentList=class(TComponentList)
  end;

const
  DefaultInspectorOptions = [oiHorzLine, oiVertLine, oiSunkenEditor, oiVertLine3D, oiUseAliases,
    oiUseGroups, oiSmartPopup, oiShowActiveX, oiShowAxHelp];
var
  _OleCreatePropertyFrameIndirect: function(const Params: TOCPFIParams): HResult; stdcall;
  _OleCreatePictureIndirect: function(const PictDesc: TPictDesc; const iid: TIID;
    fOwn: BOOL; var vObject): HResult; stdcall;

  {------------------------------------------------------------------}

function OleCreatePropertyFrameIndirect(const Params: TOCPFIParams): HResult; stdcall;
begin
  if Assigned(_OleCreatePropertyFrameIndirect) then
    Result := _OleCreatePropertyFrameIndirect(Params)
  else
    Result := E_UNEXPECTED;
end;

{------------------------------------------------------------------}

function OleCreatePictureIndirect(const PictDesc: TPictDesc; const iid: TIID;
  fOwn: BOOL; var vObject): HResult; stdcall;
begin
  if Assigned(_OleCreatePictureIndirect) then
    Result := _OleCreatePictureIndirect(PictDesc, iid, fOwn, vObject)
  else
    Result := E_UNEXPECTED;
end;

{------------------------------------------------------------------}

const
  VT_OLECOLOR = -1;

  {$IFNDEF D3}

  {------------------------------------------------------------------}

procedure GetOleFont(Font: TFont; var OleFont: IFontDisp);
var
  FontDesc: TFontDesc;
begin
  with FontDesc, Font do
  try
    cbSizeOfStruct := SizeOf(FontDesc);
    lpstrName := DCStringToOleSt(Name);
    cySize := Size * 10000;
    if fsBold in Style then
      sWeight := 700
    else
      sWeight := 400;

    sCharset := DEFAULT_CHARSET;
    fItalic := fsItalic in Style;
    fUnderline := fsUnderline in Style;
    fStrikethrough := fsStrikeout in Style;

    OleCheck(OleCreateFontIndirect(FontDesc, IID_IFont, OleFont));
  finally
    SysFreeString(lpstrName)
  end;
end;

{------------------------------------------------------------------}
{$ENDIF}
{$IFNDEF D3}
const
  PICTYPE_ENHMETAFILE = 4;
  {$ENDIF}

procedure GetOlePicture(Picture: TPicture; var OlePicture: IPictureDisp);
var
  PictureDesc: TPictDesc;
  OwnHandle: Boolean;
  TempM: TMetafile;
begin
  OwnHandle := False;
  with Picture, PictureDesc do
  begin
    if Graphic = nil then
    begin
      OlePicture := nil;
      exit;
    end;

    cbSizeOfStruct := SizeOf(PictureDesc);
    if Graphic is TBitmap then
    begin
      picType := PICTYPE_BITMAP;
      with TBitmap.Create do
      try
        Assign(Graphic);
        hbitmap := ReleaseHandle;
        hpal := ReleasePalette;
        OwnHandle := True;
      finally
        Free;
      end;
    end
    else if Graphic is TIcon then
    begin
      picType := PICTYPE_ICON;
      hicon := Icon.Handle;
    end
    else
    begin
      picType := PICTYPE_ENHMETAFILE;
      if not (Graphic is TMetafile) then
      begin
        TempM := TMetafile.Create;
        try
          TempM.Width := Width;
          TempM.Height := Height;
          with TMetafileCanvas.Create(TempM, 0) do
          try
            Draw(0, 0, Graphic);
          finally
            Free;
          end;
          hmeta := TempM.Handle;
          TempM.Handle := 0;
          OwnHandle := True; // IPicture destroys temp metafile when released
        finally
          TempM.Free;
        end;
      end
      else
        hmeta := Metafile.Handle;
    end;
  end;
  OleCheck(OleCreatePictureIndirect(PictureDesc, {$IFDEF D3}IPicture{$ELSE}IID_IPicture{$ENDIF}, OwnHandle, OlePicture));
end;

{------------------------------------------------------------------}

procedure SetOlePicture(Picture: TPicture; const OlePicture: IPicture);
var
  PicType: SmallInt;
  h: OLE_Handle;
begin
  if OlePicture = nil then
    exit;

  OlePicture.get_Type(PicType);
  if (PicType = PICTYPE_NONE) or (PicType = PICTYPE_UNINITIALIZED) then
    exit;

  OlePicture.get_Handle(h);
  with Picture do
    case PicType of
      PICTYPE_BITMAP:
        begin
          Graphic := TBitmap.Create;
          TBitmap(Graphic).Handle := h;
        end;
      PICTYPE_ICON:
        begin
          Graphic := TIcon.Create;
          TIcon(Graphic).Handle := h;
        end;
      PICTYPE_ENHMETAFILE:
        begin
          Graphic := TMetafile.Create;
          TMetafile(Graphic).Handle := h;
        end;
    end;
end;

{------------------------------------------------------------------}

function S2WS(const s: string): WideString;
begin
  {$IFDEF D3}
  result := s;
  {$ELSE}
  result := DCStringToOleSt(s);
  {$ENDIF}
end;
//const
//  ICursor: TGUID = (
//    D1:$9F6AA700;D2:$D188;D3:$11CD;D4:($AD,$48,$00,$AA,$00,$3C,$9C,$B6));

type
  TAxMultiSelectPropEdit = class(TMultiSelectPropEdit)
    function GetRealPropType: PTypeInfo; override;
  end;
  (*
  type
    IImageList = interface(IUnknown)
    ['{E6E17E80-DF38-11CF-8E74-00A0C90F26F8}']
    end;

    IDataSource = interface(IUnknown)
    ['{7C0FFAB3-CD84-11D0-949A-00A0C91110ED}']
    end;
  *)

var
  fBadEditorClasses: TList = nil;

type
  TPInfo = class
  public
    Alias: string;
    group: integer;
    AutoExpand: boolean;
    AutoCollapse : boolean;
    AlwaysExpand: boolean;
    NeverExpand: boolean;
    NeverShow: boolean;
    PReadOnly: boolean;
  end;

const
  MINWIDTH = 40;
  DeltaHeight = 3;
  PlusSize: integer = 9;

  {****************************************}
type
  TMControl = class(TControl)
  end;

  TMWinControl = class(TWinControl)
  end;

  {****************************************}

destructor TInfoRec.Destroy;
begin
  // PropEdit is stored in fEditList and is destroyed there
  inherited Destroy;
end;

{****************************************}

constructor TOIColors.Create;
begin
  inherited Create;
  fBackColor := clBtnFace;
  fCol0Color := clBlack;
  fCol1Color := clNavy;
  fVertLineColor := clBlack;
  fHorzLineColor := clBtnShadow;
end;

{------------------------------------------------------------------}

procedure TOIColors.Changed;
begin
  if Assigned(OnChange) then
    OnChange(self);
end;

{------------------------------------------------------------------}

procedure TOIColors.SetBackColor(val: TColor);
begin
  if fBackColor = val then
    exit;

  fBackColor := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetCol0Color(val: TColor);
begin
  if fCol0Color = val then
    exit;

  fCol0Color := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetCol1Color(val: TColor);
begin
  if fCol1Color = val then
    exit;

  fCol1Color := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetVertLineColor(val: TColor);
begin
  if fVertLineColor = val then
    exit;

  fVertLineColor := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetHorzLineColor(val: TColor);
begin
  if fHorzLineColor = val then
    exit;

  fHorzLineColor := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetHighlightColor(val: TColor);
begin
  if fHighLightColor = val then
    exit;

  fHighLightColor := val;
  Changed;
end;

{------------------------------------------------------------------}

procedure TOIColors.SetHighlightBkgnd(val: TColor);
begin
  if fHighLightBkgnd = val then
    exit;

  fHighLightBkgnd := val;
  Changed;
end;

{******************************************************************}

constructor TOInplaceEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fTrackPropChange := true;
  DropOnClick := false;
  UseDefaultEditor := false;
  EditOffset := 2;
  Parent := TWinControl(AOwner);
  Color := clWindow;
  Button1.Width := 0;
  Ctl3D := False;
  BorderStyle := bsNone;
  needtorefresh := true;
  TabStop := False;
  DisplayFocused := false;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.SetInspector(Value: TCustomObjectInspector);
begin
  Inspector := Value;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.ValidateEditorClass(var c: TControlClass);
var
  i: integer;
begin
  for i := 0 to fBadEditorClasses.Count - 1 do
    if c.InheritsFrom(TControlClass(fBadEditorClasses[i])) then
    begin
      c := TDCSimpleEdit;
      exit;
    end;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.ResetAfterCreateHandle;
begin

end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.DoAutoUpdate;
var
  s: string;
begin
  with Inspector do
    if Assigned(fOnChangedPropValue) then
    begin
      s := Text;
      fOnChangedPropValue(self, TDCDsgnProperty(PropEditor), s);
    end;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.GetDropValue;
var
  newval: array[0..1023] of char;
  s: string;
begin
  TPopupListBox(DropWindow).Perform(WM_GETTEXT, 1023, longint(@newval));
  s := StrPas(newval);

  if s = '' then
    exit;

  Inspector.ChangeValue(PropEditor, s);
  Text := PropEditor.GetValue;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.Paint;
begin
  inherited Paint;
  if (oiVertLine3D in Inspector.Options) then
    with Canvas do
    begin
      Pen.Color := clBtnHighlight;
      MoveTo(1, 1);
      LineTo(1, ClientHeight);
    end;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.DblClick;
begin
  Inspector.DblClick;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Inspector.ColSizing then
    exit;
  if not (ssDouble in Shift) and (DWORD(GetMessageTime - CreateTime) < GetDoubleClickTime) then
    DblClick
  else
    inherited MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.WMRButtonUp(var Message: TWMRButtonUp);
var
  pt: TPoint;
begin
  if Inspector.ColSizing then
    exit;

  with Message do
    pt := Inspector.ScreenToClient(ClientToScreen(Point(XPos, YPos)));

  Inspector.ShowPopup(pt.X, pt.Y);
  Message.Result := 1;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
var
  addmask: integer;
begin
  inherited;
  if oiTabMoveDown in Inspector.Options then
    addmask := DLGC_WANTARROWS or DLGC_WANTTAB
  else
    addmask := DLGC_WANTARROWS;

  with Message do
    Result := Result or addmask;
end;

{------------------------------------------------------------------}

type
  TSelection = record
    StartPos, EndPos: word;
  end;

procedure TOInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    Inspector.KeyDown(Key, Shift);
  end;

  procedure ParentEvent;
  var
    GridKeyDown: TKeyEvent;
  begin
    GridKeyDown := Inspector.OnKeyDown;
    if Assigned(GridKeyDown) then
      GridKeyDown(Inspector, Key, Shift);
  end;

var
  k: word;
begin
  try
    if not (ssAlt in Shift) then
      if Inspector.IsInspectorKey(key, shift) then
        SendToParent;

    try
      ParentEvent;
    except
      key := 0;
      raise;
    end;

    case Key of
      VK_RETURN:
        begin
          if Inspector.EditActive then
          begin
            needtorefresh := modified;
            if ssCtrl in Shift then
            begin
              Inspector.DoEdit(Inspector.editrow);
              modified := true;
            end
            else if modified then
              Inspector.ChangeValue(PropEditor, Text);

            modified := true;
            if PropEditor <> nil then
              Text := PropEditor.GetValue;

            Term;
            SelectAll;
            key := 0;
          end;
          with Inspector do
            if not (ssCtrl in Shift) and (oiEnterMoveDown in Inspector.Options) then
              if Row < RowCount - 1 then
              begin
                k := VK_DOWN;
                KeyDown(k, [])
              end
              else
                TMWinControl(GetParentForm(Inspector)).SelectNext(Inspector, true, true);
        end;
    end;
  except
    key := 0;
    raise;
  end;

  if Key <> 0 then
  begin
    inherited KeyDown(Key, Shift);
  end;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.KeyPress(var Key: Char);
var
  Selection: TSelection;
begin
  Inspector.KeyPress(Key);
  if (Key in [#32..#255]) and not Inspector.CanEditAcceptKey(Key) then
  begin
    Key := #0;
    MessageBeep(0);
  end;
  case Key of
    #9, #10, #27: Key := #0;
    #13:
      begin
        Longint(Selection) := SendMessage(Handle, EM_GETSEL, 0, 0);
        if (Selection.StartPos = 0) and (Selection.EndPos = GetTextLen) then
          Deselect
        else
          SelectAll;
        Key := #0;
      end;
    ^H, ^V, ^X, #32..#255:
      if not Inspector.CanEditModify then
        Key := #0;
  end;

  if Key <> #0 then
    inherited KeyPress(Key);
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Inspector.KeyUp(Key, Shift);
  Change;
  inherited KeyUp(Key, Shift);
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_TAB) and (oiTabMoveDown in Inspector.Options) then
    Message.Result := 1;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.Invalidate;
var
  Cur: TRect;
begin
  if not Assigned(Inspector) then
    exit;
  ValidateRect(Handle, nil);
  InvalidateRect(Handle, nil, True);
  Windows.GetClientRect(Handle, Cur);
  MapWindowPoints(Handle, Inspector.Handle, Cur, 2);
  ValidateRect(Inspector.Handle, @Cur);
  InvalidateRect(Inspector.Handle, @Cur, False);
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.Hide;
begin
  visible := false;
  ShowWindow(handle, SW_HIDE);
  SetWindowPos(Handle, 0, -200, -200, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
    SWP_NOREDRAW);

  if Focused then
    Windows.SetFocus(Inspector.Handle);
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.InternalMove(Loc: TRect; Redraw: Boolean);
begin
  if not HandleAllocated then
    exit;

  {  if IsRectEmpty(Loc) then
      Hide
    else}
  begin
    with Loc do
      SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left + 1,
        Bottom - Top - 1, SWP_SHOWWINDOW);

    Invalidate;

    if Inspector.Focused then
      SetFocus;
  end;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.Move(Loc: TRect);
begin
  if oiVertLine3D in Inspector.Options then
    inc(Loc.Left);
  InternalMove(Loc, True);
  SetEditRect;
end;

{------------------------------------------------------------------}

procedure TOInplaceEdit.DoTerm;
begin
  if (PropEditor = nil) or not modified or ReadOnly or Inspector.InfoRec[Inspector.EditRow].groupname then
    exit;

  if modified then
  begin
    needtorefresh := true;
    try
      Inspector.ChangeValue(PropEditor, Text);
    except
      Text := PropEditor.GetValue;
      SelectAll;
      SetFocus;
      raise;
    end;

    if fTrackPropChange then
    begin
      Text := PropEditor.GetValue;
      if needtorefresh then
      begin
        Inspector.UpdateValues;
        needtorefresh := false;
      end;
      Text := PropEditor.GetValue;
    end;

    modified := false;
  end;
end;

{******************************************************************}

function TCustomObjectInspector.isnear(x, y: integer): boolean;
begin
  result := (x > y - fSplitterSize) and (x < y + fSplitterSize);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.FindAlias(const s: string): pointer;
var
  index: integer;
begin
  result := nil;
  if [oiUseAliases, oiUseGroups] * Options = [] then
    exit;

  if not fa2.Find(s, index) then
    exit;

  result := fa2.Objects[index];
end;

{------------------------------------------------------------------}

constructor TCustomObjectInspector.Create(AOwner: TComponent);
begin
  CheckTrialVersion;
  inherited Create(AOwner);

  fUseOtherGroup := true;
  fSmartRefresh := true;
  fTrackDestroy := true;
  InspectorList.Add(self);
  fEmptyList := true;
  fMenu := TPopupMenu.Create(nil);
  EditActive := false;
  FDesigner := TFDesigner.Create;
  fColors := TOIColors.Create;
  fGroupFont := TFont.Create;
  {$IFDEF D6}
  fEditList := TDCInterfaceList.Create;
  {$ELSE}
  fEditList := TList.Create;
  {$ENDIF}
  finfos := TList.Create;
  ctrls := TList.Create;
  fEditors := TList.Create;
  faliases := TStringList.Create;
  fAliases.Text := DefaultInspectorAliases;
  
  fExpandList := TStringList.Create;
  fCollapseList := TStringList.Create;
  fDescNames := TStringList.Create;
  fPropOrder := TStringList.Create;
  fReadOnlyProps := TStringList.Create;
  fHiddenProps := TStringList.Create;
  fDisplayedProps := TStringList.Create;

  fDescNames.Sorted := true;
  fDescNames.Duplicates := dupIgnore;
  fDescs := TStringList.Create;

  TStringList(fDescs).OnChange := DescsChanged;
  TStringList(fPropOrder).OnChange := ParamsChanged;
  TStringList(fHiddenProps).OnChange := ParamsChanged;
  TStringList(fDisplayedProps).OnChange := ParamsChanged;

  fa2 := TStringList.Create;
  fgroups := TStringList.Create;
  faliases.OnChange := AliasesChanged;
  fa2.Sorted := true;
  fa2.duplicates := dupIgnore;
  //  fgroups.duplicates := dupError;
  fColors.OnChange := ColorsChanged;
  FObjects := TList.Create;
  GridLineWidth := 1;
  fDrawSelection := true;
  Color := clBtnFace;
  FixedColor := clBtnFace;
  ColCount := 2;
  FixedCols := 1;
  FixedRows := 0;
  NoInvalidateMode := false;
  fSplitterSize := 3;
  fOtherGroupName := SOtherGroupName;
  fLineStyle := SolidLine;
  {$IFDEF D3}
  fFilter := tkAny - [tkMethod, tkInterface];
  {$ELSE}
  fFilter := tkAny - [tkMethod];
  {$ENDIF}
  PlusGlyph := TBitmap.Create;
  PlusGlyph.LoadFromResourceName(HInstance, 'OBJECTINSPECTOR_PLUS'); //don't resource
  PlusGlyph.Dormant;
  MinusGlyph := TBitmap.Create;
  MinusGlyph.LoadFromResourceName(HInstance, 'OBJECTINSPECTOR_MINUS'); //don't resource
  MinusGlyph.Dormant;
  defaultdrawing := false;
  Options := DefaultInspectorOptions;

  inherited options := [goThumbTracking];

  editrow := 0;
  SetDelphiStyle;
  if csDesigning in ComponentState then
  begin
    Setcontrol(self);
    exit;
  end;
  RegisterNotifier(self);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.FreeInfoRecs;
//var
//  i : integer;
begin
  ClearList(fObjects);
  //  if not isempty then
  //    for i := 0 to min(rowcount, fObjects.Count) - 1 do
  //    for i := 0 to fObjects.Count - 1 do
  //      InfoRec[i].Free;
end;

{------------------------------------------------------------------}

destructor TCustomObjectInspector.Destroy;
var
  i: integer;
begin
  //  pointer(fDesigner_) := nil;
  //  pointer(fDesign) := nil;
  for i := 0 to ctrls.count - 1 do
    RemoveFreeNotify(TPersistent(ctrls[i]));

  InspectorList.Remove(self);
  UnRegisterNotifier(self);
  FreeInfoRecs;
  {$IFDEF D6}
  FreeInterfaceList(fEditList,fEditList);
  {$ELSE}
  FreeList(fEditList,fEditList);
  {$ENDIF}
  {$IFNDEF D6}
  fcedit.Free;
  {$ENDIF}
  Colors.Free;
  fAliases.Free;
  fGroupFont.Free;
  FreeStrings(fa2);
  FreeList(finfos,finfos);
  FObjects.Free;
  fPropOrder.Free;
  fReadOnlyProps.Free;
  fHiddenProps.Free;
  fDisplayedProps.Free;

  {$IFNDEF D4}
  FDesigner.Free;
  {$ENDIF}
  ctrls.Free;
  fDescs.Free;
  fDescNames.Free;
  MinusGlyph.Free;
  PlusGlyph.Free;
  fMenu.Free;
  fExpandList.Free;
  fCollapseList.Free;
  FreeStrings(fGroups);

  for i := 0 to fEditors.Count - 1 do
    TControl(fEditors[i]).Free;

  fEditors.Free;
  FreeObject(fHint,fHint);

  inherited Destroy;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetInplaceEditClass: TInplaceEditClass;
begin
  result := TOInplaceEdit;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetDesigner(val: TFormDesigner);
begin
  if fDesigner_ <> val then
  begin
    fDesigner_ := val;
    ReScan;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);

  if (Aparent <> nil) and (Editor = nil) then
  begin
    Editor := GetInplaceEditClass.Create(self);
    with TOInplaceEdit(Editor) do
    begin
      Parent := self;
      SetInspector(Self);
      EditActive := true;
      Hide;
    end;
    fOldScrollBars := inherited ScrollBars;
    inherited ScrollBars := ssHorizontal;
    ShowInfo;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    Style := (Style or WS_VSCROLL) and not WS_HSCROLL;
end;

{------------------------------------------------------------------}

type
  TMPersistent = class(TPersistent)
  end;

procedure TCustomObjectInspector.SetDesignerForm(control: TPersistent);
begin
  DCSetDesignerForm(fdesigner,GetPForm(control));
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.RemoveFreeNotify(Instance: TPersistent);
begin
  //  if not (Instance is TComponent) then
  {$IFDEF D5}
  if not (csDestroying in ComponentState) and (Instance is TComponent) then
    TComponent(Instance).RemoveFreeNotification(self);
  {$ENDIF}

  dcRemoveFreeNotification(Instance, DestroyNotification);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ClearControls;
var
  i: integer;
begin
  for i := 0 to ctrls.Count - 1 do
    RemoveFreeNotify(TPersistent(ctrls[i]));

  ctrls.clear;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AddFreeNotify(Instance: TPersistent);
begin
  if fTrackDestroy then
    if Instance is TComponent then
      TComponent(Instance).FreeNotification(self)
    else
      dcAddFreeNotification(Instance, DestroyNotification);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetControl(control: TPersistent);
begin
  if (ctrls.count = 1) and (control = ctrls[0]) then
  begin
    UpdateValues;
    exit;
  end;

  if (Editor <> nil) and not IsEmpty then
    Editor.Term;

  ClearControls;
  if control = nil then
  begin
    if fUpdateCount = 0 then
      rowcount := 1;
  end
  else
  begin
    ctrls.add(control);
    SetDesignerForm(control);
    AddFreeNotify(control);
  end;

  showinfo;
  if fUpdateCount = 0 then
    invalidate;

  ComponentChanged;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DelControl(control: TPersistent);
var
  i: integer;
begin
  if (control = nil) or (csDestroying in ComponentState) then
    exit;

  i := ctrls.IndexOf(Control);
  if i < 0 then
    exit;

  ctrls.Delete(i);
  RemoveFreeNotify(control);

  showinfo;
  if fUpdateCount = 0 then
    invalidate;

  ComponentChanged;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DelControls(controls: TList);
var
  i: integer;
begin
  BeginUpdate;

  for i := 0 to controls.count - 1 do
    DelControl(controls[i]);

  EndUpdate;
  ComponentChanged;
end;

{------------------------------------------------------------------}

function EqualListAndCompList(List: TList; CompList: TComponentList): Boolean;
var
  i: integer;
begin
  result := false;
  if List.Count <> TMComponentList(CompList).Count then
    exit;

  for i := 0 to TMComponentList(CompList).Count - 1 do
    if List.IndexOf(CompList[i]) < 0 then
      exit;
  result := true;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.EqualWithList(List: TObject): boolean;
begin
  if List is TList then
    Result := EqualList(Ctrls, TList(List))
  else
    Result := EqualListAndCompList(Ctrls, TComponentList(List));
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetControls(controls: TList);
begin
  if (controls = nil) or (controls.count = 0) then
    SetControl(nil)
  else if not EqualWithList(controls) then
  begin
    ClearControls;
    AddControls(controls);
  end
  else
    UpdateValues;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AddToCtrlsList(Instance: TPersistent);
begin
  if Instance <> nil then
  begin
    ctrls.Add(Instance);
    AddFreeNotify(Instance);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AddControls(controls: TList);
var
  i: integer;
begin
  if (controls = nil) then
    exit;

  if Controls.ClassType = TComponentList then
  begin
    if (TMComponentList(Controls).Count = 0) then
      exit;

    BeginUpdate;
    with TMComponentList(controls) do
    try
      SetDesignerForm(TPersistent(Items[0]));

      SetControl(Items[0]);

      for i := 1 to count - 1 do
        AddToCtrlsList(Items[i]);

    finally
      EndUpdate;
    end;
  end
  else
  begin
    if (Controls.Count = 0) then
      exit;

    BeginUpdate;
    try
      SetDesignerForm(TPersistent(controls.List[0]));

      SetControl(controls.List[0]);

      for i := 1 to controls.count - 1 do
        AddToCtrlsList(controls.List[i]);

    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AddControl(control: TPersistent);
begin
  if control = nil then
    exit;

  if ctrls.count = 0 then
  begin
    SetControl(control);
    invalidate;
    exit;
  end;

  ctrls.Add(control);
  AddFreeNotify(control);

  showinfo;
  invalidate;
  ComponentChanged;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetControl: TPersistent;
begin
  if ctrls.count = 0 then
    result := nil
  else
    result := ctrls.list[0];
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetEditor(editclass: TControlClass): TControl;
var
  i: integer;
  c: TControl;
begin
  for i := 0 to fEditors.Count - 1 do
    if TControl(fEditors[i]).ClassType = editclass then
    begin
      result := TControl(fEditors[i]);
      exit;
    end;

  c := editclass.Create(self);
  if c is TWinControl then
    c.Parent := self;
  c.Visible := false;
  fEditors.Add(c);
  result := c;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetXTextOffset(arow: integer): integer;
begin
  result := 5;
  if CanHaveSubNodes then
    inc(result, plussize * (InfoRec[ARow].sublevel + 1));
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  s: string;
  yofs: integer;
  xofs: integer;
  processed: boolean;
  c: TControl;
  painted: boolean;
  r: TRect;
  SunkEdit: boolean;

  procedure puttext(const st: string);
  var
    r: TRect;
    crect: TRect;
    y: integer;
  begin
    r := ARect;
    if sunkedit or not (((acol = 0) or (InfoRec[arow].groupname)) and (arow = editrow)) or ReadOnly then
      Dec(r.Bottom);
    {
       r.left := xofs;
        inc(r.Top);
       DrawText(Canvas.Handle, pchar(st), length(st), r, DT_SINGLELINE or DT_VCENTER);
    }
    DrawText(Canvas.Handle, pchar(st), length(st), crect, DT_CALCRECT or DT_SINGLELINE);
    y := r.top + (r.bottom - r.top - crect.Bottom + crect.Top) div 2;
    ExtTextOut(Canvas.Handle, xofs, y, ETO_CLIPPED or ETO_OPAQUE,
      @r, PChar(st), length(st), nil);
  end;

  procedure BRect(var R: TRect);
  begin
    with Canvas do
    begin
      Pen.Color := clBtnShadow;
      Pen.Width := 1;
      MoveTo(R.Left, R.Top);
      LineTo(R.Right, R.Top);

      Pen.Color := clBlack;
      MoveTo(R.Left, R.Top + 1);
      LineTo(R.Right, R.Top + 1);

      Pen.Width := 2;

      if ACol = 0 then
      begin
        MoveTo(R.Left, R.Top + 2);
        LineTo(R.Left, R.Bottom);
      end;

      Pen.Color := clBtnHighLight;
      Pen.Width := 1;

      MoveTo(R.Left, R.Bottom);
      LineTo(R.Right, R.Bottom);
    end;
  end;

  procedure Sunk;
  begin
    if (ARow = EditRow) and SunkEdit and fDrawSelection then
    begin
      Dec(Arect.Top);
      BRect(ARect);
    end;
  end;

  procedure SetHighLight;
  begin
    with Canvas, Colors do
    begin
      Font.Color := HighlightColor;
      Brush.Color := HighlightBkgnd;
    end;
  end;

  procedure DefaultEditorDraw;
  begin
    with InfoRec[arow] do
      if not groupname and ((ctrls.count = 1) or PropEdit.AllEqual) then
        s := PropEdit.GetValue
      else
        s := '';

    puttext(s);
  end;

begin
  if csDesigning in ComponentState then
    with Canvas do
      if (gdSelected in AState) and not (gdFocused in AState) then
      begin
        Brush.Color := Colors.BackColor;
        FillRect(ARect);
      end;

  if IsEmpty or (fObjects.Count <= aRow) then
    exit;

  Canvas.Font := Font;
  SunkEdit := ([oiSunkenEditor, oiEditBorder] * Options = [oiSunkenEditor]);
  if acol = 0 then
    dec(Arect.Right)
  else if (acol = 1) and (oiVertLine3D in Options) then
    inc(ARect.Left);

  if not InfoRec[arow].groupname and Assigned(fOnDrawCell) then
  begin
    processed := true;
    fOnDrawCell(self, TDCDsgnProperty(InfoRec[arow].PropEdit), ACol, ARect, processed);
    Canvas.Brush.Color := Colors.fBackColor;
    if processed then
    begin
      Sunk;
      exit;
    end;
  end;

  Canvas.Brush.Color := Colors.BackColor;

  if (ACol = 1) then
  begin
    Brush.Color := Colors.BackColor;
    if InfoRec[arow].groupname then
      Canvas.Font.Color := fColors.BackColor
    else
      Canvas.Font.Color := fColors.Col1Color;

    if Assigned(fOnGetCellParams) then
      fOnGetCellParams(Self, TDCDsgnProperty(InfoRec[arow].PropEdit), 1, Canvas.Font);

    if ((arow <> editrow) or (csDesigning in ComponentState) or InfoRec[arow].groupname or ReadOnly) or not fDrawSelection then
    begin
      painted := false;
      xofs := ARect.Left + 1;

      if Assigned(InfoRec[arow].PropEdit) and not (InfoRec[arow].groupname { or ReadOnly}) then
      begin
        if not IsTextEditClass(InfoRec[arow].editclass) then
        begin
          c := GetEditor(InfoRec[arow].editclass);
          r := ARect;
          dec(r.Bottom);
          if SunkEdit then
            inc(r.Top);

          with r do
            c.SetBounds(Left, Top, Right - Left, Bottom - Top);

          c.Perform(WM_SETTEXT, 0, Longint(PChar(InfoRec[arow].PropEdit.GetValue)));
          painted := c.Perform(CM_PAINTTO, Integer(Canvas), MAKELPARAM(ARect.Left, ARect.Top)) = 1;

          if painted and SunkEdit then
            with Canvas, r do
            begin
              Pen.Color := self.Color;
              MoveTo(Left, Bottom - 1);
              LineTo(Right, Bottom - 1);
            end;
        end;
      end;

      if ((editrow <> arow) or (csDesigning in ComponentState) or (InfoRec[arow].groupname or ReadOnly)) and not painted then
        DefaultEditorDraw;
    end;
  end
  else
  begin
    Canvas.Font.Color := fColors.Col0Color;

    if InfoRec[arow].groupname then
    begin
      if arow = row then
        SetHighLight;

      Canvas.Font := fGroupFont;
    end
    else if ReadOnly and (arow = row) then
      SetHighLight;

    if Assigned(fOnGetCellParams) then
      fOnGetCellParams(Self, TDCDsgnProperty(InfoRec[arow].PropEdit), 0, Canvas.Font);

    s := InfoRec[arow].name;
    xofs := ARect.Left + GetXTextOffset(arow);

    puttext(s);
    dec(xofs, plussize + 2);
    yofs := ARect.Top + (DefaultRowHeight - plussize) div 2;
    if not InfoRec[ARow].NeverExpand then
      case InfoRec[ARow].substate of
        ssExpanded: Canvas.Draw(xofs, yofs, MinusGlyph);
        ssCollapsed: Canvas.Draw(xofs, yofs, PlusGlyph);
      end;
  end;
  Sunk;

  if (acol = 1) and (arow = editrow) and not SunkEdit then
    with Canvas, ARect do
    begin
      Pen.Color := self.Color;
      MoveTo(Left, Top);
      LineTo(Right, Top);
    end;

  if (oiEditBorder in Options) and (arow = editrow) then
    with Canvas, ARect do
    begin
      Pen.Color := clBlack;
      MoveTo(Left, Top - 1);
      LineTo(Right, Top - 1);
      MoveTo(Left, Bottom - 1);
      LineTo(Right, Bottom - 1);
    end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetEditorClass(const PropEdit: TDCDsgnProp): TControlClass;
begin
  result := GetEditClass(PropEdit{$IFDEF D6},CurrentControl{$ENDIF});
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetPopupClass(const PropEdit: TDCDsgnProp): TWinControlClass;
begin
  result := dcpedit.GetPopupClass(PropEdit{$IFDEF D6},CurrentControl{$ENDIF});
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetRealName(const Prop: TDCDsgnProp): string;
begin
  result := Prop.GetName;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomObjectInspector.GetPropEdit(const Prop: TDCDsgnProp);
{$ELSE}
procedure TCustomObjectInspector.GetPropEdit(Prop: TDCDsgnProp);
{$ENDIF}
var
  info: TInfoRec;
  pinfo: pointer;
  pshow: boolean;
begin
  if Prop.ValueAvailable then
  begin
    if not AllowShowProp(Prop) then
      exit;

    pshow := true;

    if Assigned(fOnShowProperty) then
      OnShowProperty(self, TDCDsgnProperty(Prop), pshow);

    if not pshow then
      exit;

    fEmptyList := false;
    info := TInfoRec.Create;
    with info do
    begin
      PropEdit := Prop;
{
      NeedFree := true;
}
      editclass := GetEditorClass(PropEdit);
      popupclass := GetPopupClass(PropEdit);
      if arow = -1 then
      begin
        sublevel := 0;
        parent := 0;
        group := -1;
      end
      else
      begin
        sublevel := InfoRec[arow].sublevel + 1;
        parent := arow;
        group := InfoRec[arow].group;
      end;

      if paSubProperties in PropEdit.GetAttributes then
        substate := ssCollapsed
      else
        substate := ssNoSub;

      realname := Prop.GetName;
      pinfo := FindAlias(GetRealName(Prop));
      name := '';
      if pinfo <> nil then
      begin
        if TPInfo(pinfo).NeverShow then
        begin
          info.Free;
          exit;
        end;
        AutoExpand := TPInfo(pinfo).AutoExpand;
        AutoCollapse := TPInfo(pinfo).AutoCollapse;
        AlwaysExpand := TPInfo(pinfo).AlwaysExpand;
        NeverExpand := TPInfo(pinfo).NeverExpand;
        NeverShow := TPInfo(pinfo).NeverShow;
        PReadOnly := TPInfo(pinfo).PReadOnly;

        name := TPInfo(pinfo).Alias;
        group := TPInfo(pinfo).group;
      end
      else
      begin
        AutoExpand := false;
        AutoCollapse := false;
        AlwaysExpand := false;
        NeverShow := false;
        PReadOnly := false;
        NeverExpand := false;
      end;

      if (name = '') or not (oiUseAliases in Options) then
        name := realname;
    end;

    flist.AddObject(info.name, info);
    inc(rcount);
  end;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.IsEmpty: boolean;
begin
  result := (ctrls.count = 0) or fEmptyList or (fObjects.Count = 0);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.GetAllPropertyEditors(Components: TComponentList;
  Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc);
begin
  GetComponentProperties(Components, Filter, Designer, Proc);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.showinfo;
var
  i: integer;
  j: integer;
  neweditrow: integer;
  clist: TComponentList;
  oldproperty: string;
  info: TInfoRec;
  ntop: integer;
  groupscount: integer;
  curcontrol: integer;
  topcontrol: integer;
  firstgroup: TInfoRec;
  pinfo: TPInfo;
  groupempty: boolean;

  {---------------------------------------}

  function SetToPropName(const pname: string): boolean;
  var
    i: integer;
  begin
    for i := 0 to FObjects.Count - 1 do
      with InfoRec[i] do
        if not GroupName and (PropEdit <> nil) and (PropEdit.GetName = pname) then
        begin
          neweditrow := i;
          result := true;
          exit;
        end;

    result := false;
  end;

  {---------------------------------------}

begin
  if fInShowInfo then
    exit;

  if ([csReading, csLoading] * ComponentState <> []) or (Parent = nil) then
    exit;

  if fUpdateCount > 0 then
  begin
    fUpdated := true;
    exit;
  end;

  fInShowInfo := true;
  try
    fExpandList.Clear;
    fCollapseList.Clear;

    for i := 0 to min(fObjects.Count, rowcount) - 1 do
      case InfoRec[i].substate of
        ssExpanded: fExpandList.Add(GetProperty(i));
        ssCollapsed: fCollapseList.Add(GetProperty(i));
      end;

    if Visible then
      BeginControlUpdate(self);
    try
      flist := TStringList.Create;
      try
        flist.sorted := not (CustomSort or (oiUnSorted in fOptions));
        flist.duplicates := dupAccept;

        KillEditor;

        if (FObjects.Count > 0) and not (InfoRec[EditRow].GroupName) then
          oldproperty := InfoRec[EditRow].PropEdit.GetName
        else
          oldproperty := '';

        FreeInfoRecs;
        FObjects.Clear;
        ClearList(finfos);
        fdesign := nil;
        {$IFDEF D6}
        ClearInterfaceList(fEditList);
        {$ELSE}
        ClearList(fEditList);
        {$ENDIF}

        if ctrls.count = 0 then
        begin
          EditRowChanged;
          KillEditor;
          UpdateScrollBar;
          exit;
        end;

        rcount := 0;

        fEmptyList := true;
        //      pointer(fdesign) := nil;

        arow := -1;
        neweditrow := 0;
        groupscount := 0;
        curcontrol := 0;

        repeat
          clist := TComponentList.Create;
          if oiJoinControls in fOptions then
            topcontrol := curcontrol
          else
            topcontrol := ctrls.count - 1;

          for i := curcontrol to topcontrol do
            TMComponentList(clist).Add(ctrls[i]);

          if Assigned(fDesigner_) then
            fdesign := fDesigner_
          else
          begin
            fdesign := GetFormDesigner(ctrls[0]);

            if fDesign = nil then
              fdesign := FDesigner;
          end;

          try
{
procedure TCustomObjectInspector.GetAllPropertyEditors(Components: TComponentList;
  Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropProc);
}
            GetAllPropertyEditors(clist, fFilter, fDesign, GetPropEdit);
          except
            clist.Free;
            exit;
          end;

          inc(curcontrol);
          clist.Free;
        until topcontrol = ctrls.count - 1;

        if oiUseGroups in Options then
        begin
          for i := 0 to rcount - 1 do
          begin
            finfos.Add(flist.Objects[i]);
            fList.Objects[i] := nil;
          end;

          if (oiGroupsDown in Options) and not UseOtherGroup then
          begin
            i := 0;
            while i < finfos.count do
              with TInfoRec(finfos[i]) do
                if group = -1 then
                begin
                  FObjects.Add(fInfos[i]);
                  fInfos.Delete(i);
                end
                else
                  inc(i);
          end;

          firstgroup := nil;
          for i := 0 to fgroups.count - 1 do
          begin
            info := TInfoRec.Create;
            pinfo := TPInfo(fGroups.Objects[i]);
            with info do
            begin
              name := fgroups[i];
              realname := name;
              parent := 0;
              substate := ssExpanded;
              if pinfo <> nil then
              begin
                AutoExpand := pinfo.AutoExpand;
                AutoCollapse := pinfo.AutoCollapse;
                AlwaysExpand := pinfo.AlwaysExpand;
                NeverExpand := pinfo.NeverExpand;
                NeverShow := pinfo.NeverShow;
              end;
              PReadOnly := false;
              sublevel := 0;
              group := i;
              groupname := true;
            end;

            if groupscount = 0 then
              firstgroup := info;

            FObjects.Add(info);
            groupempty := true;

            for j := 0 to finfos.count - 1 do
              with TInfoRec(finfos[j]) do
                if (group = i) or ((group = -1) and (i = fothergroup)) then
                begin
                  if (i = fOtherGroup) and not UseOtherGroup then
                  begin
                    FObjects.Add(fInfos[j]);
                    fInfos[j] := nil;
                  end
                  else
                  begin
                    groupempty := false;
                    info := TInfoRec.Create;
                    info.PropEdit := PropEdit;
                    info.editclass := GetEditorClass(PropEdit);
                    info.popupclass := GetPopupClass(PropEdit);
                    info.name := name;
                    info.realname := realname;
                    info.sublevel := 1;
                    info.parent := i;
                    info.substate := substate;
                    info.AutoExpand := AutoExpand;
                    info.AutoCollapse := AutoCollapse;
                    info.Alwaysexpand := Alwaysexpand;
                    info.NeverExpand := NeverExpand;
                    info.NeverShow := NeverShow;
                    info.PReadOnly := PReadOnly;
                    info.group := group;
                    info.groupname := groupname;
                    FObjects.Add(info);
                  end;
                end;

            if groupempty then
            begin
              FObjects.Remove(info);
              info.free;
            end
            else
              inc(groupscount);
          end;

          if (groupscount = 1) and UseOtherGroup {and (firstgroup.group = fOtherGroup)} then
          begin
            FObjects.Remove(firstgroup);
            firstgroup.free;
            dec(groupscount);
          end;
        end
        else
          for i := 0 to rcount - 1 do
            FObjects.Add(flist.Objects[i]);

        if Assigned(fOnGetDisplayName) then
        begin
          for i := 0 to fObjects.Count - 1 do
            DoGetDisplayName(InfoRec[i], i);
        end;

      finally
        flist.Free;
      end;

      fUpdateCount := 0;
      noinvalidatemode := true;
      try
        rowcount := rcount + groupscount;

        if fExpandMode in [AutoExpand, AlwaysExpand] then
          ExpandAll
        else
          ExpandAuto;

        CollapseAuto;

        if ColWidths[0] + ColWidths[1] <> ClientWidth then
          ColWidths[1] := ClientWidth - ColWidths[0];

        if (oldproperty = '') or (CompareText('Name', oldproperty) = 0) then
          oldproperty := 'Caption'; //don't resource
        if not SetToPropName(oldproperty) then
          SetToPropName('Name'); //don't resource

        ntop := neweditrow - (clientheight div (defaultrowheight + 1)) + 1;

        if ntop < 0 then
          ntop := 0;

        toprow := ntop;
        row := neweditrow;
        editrow := row;
        fUpdateCount := 0;

        UpdateEditor;
      finally
        noinvalidatemode := false;
        UpdateScrollBar;
      end;

    finally
      if Visible then
        FinishControlUpdate(self);
    end;
  finally
    fInShowInfo := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DrawSizingLine;
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  with Canvas do
  begin
    OldPen.Assign(Pen);
    Pen.Style := psDot;
    Pen.Mode := pmXor;
    Pen.Width := 1;
    MoveTo(CurSizePos, 0);
    LineTo(CurSizePos, ClientHeight);
    Pen := OldPen;
  end;
  OldPen.Free;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  p: TPoint;
  coord: TGridCoord;
begin
  if IsEmpty then
    exit;

  GetCursorPos(p);
  p := ScreenToClient(p);
  GetMouseCell(coord);

  if (Button = mbLeft) and isnear(p.x, ColWidths[0]) and (coord.y < rowcount) then
  begin
    ColSizing := true;
    CurSizePos := ColWidths[0];
    DrawSizingLine;
    exit;
  end;

  if (csDesigning in ComponentState) or ColSizing then
    exit;

  if EditActive and Editor.Focused then
    Editor.Term;

  SetFocus;

  if not (Focused or Editor.Focused) then
  begin
    MouseCapture := False;
    Exit;
  end;

  Canvas.Font := fGroupFont;
  fdoubleclicked := false;
  if (Button = mbLeft) and (ssDouble in Shift) then
  begin
    fdoubleclicked := true;
    DblClick;
  end
  else if (Button = mbLeft) and ((coord.y >= 0) and (coord.y < rowcount) and (InfoRec[coord.y].substate <> ssNoSub)
    and (p.x < plussize * (InfoRec[coord.y].sublevel + 1) + 3)
    and (p.x >= plussize * InfoRec[coord.y].sublevel - 3)) then
  begin
    fdoubleclicked := true;
    ProcessDblClick
  end
  else if (coord.y < rowcount) and (coord.y <> -1) and (row <> coord.y) then
  begin
    TOInplaceEdit(Editor).Term;
    row := coord.y;
    UpdateEditor;

    if Button = mbLeft then
      TOInplaceEdit(Editor).Click;

    UpdateScrollBar;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DragRow(x, y: integer);
var
  p: TPoint;
  coord: TGridCoord;
  oldrow: integer;
begin
  oldrow := row;
  GetCursorPos(p);
  fDrawSelection := false;
  try
    p := ScreenToClient(p);
    coord := MouseCoord(5, p.y);
    if (row <> coord.y) then
    begin
      if (coord.y <> -1) or ((p.y < 0) and (row > 0)) or
        ((p.y > 0) and (row < rowcount - 1)) then
      begin
        Editor.Term;
        KillEditor;
      end;

      if (coord.y <> -1) then
        row := coord.Y
      else if (p.y < 0) and (row > 0) then
        row := row - 1
      else if (p.y > 0) and (row < rowcount - 1) then
        row := row + 1;
    end;
  finally
    fDrawSelection := true;
  end;

  if row <> oldrow then
  begin
    UpdateEditor;
    UpdateScrollBar;
  end;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.IsOtherGroupNameStored: boolean;
begin
  result := OtherGroupName <> SOtherGroupName;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetHint: TDCHint;
begin
  if fHint = nil then
  begin
    fHint := TDCHint.Create(nil);
    fHint.AutoHide := false;
  end;

  result := fHint;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.HideHint;
begin
  if fShowHints then
    _Hint.CancelHint;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DisplayHint;
var
  coord: TGridCoord;
  s: string;
  r: TRect;
  crect: TRect;
begin
  if (csDesigning in ComponentState) or not fShowHints then
    exit;

  GetMouseCell(coord);

  if IsEmpty or (fObjects.Count <= coord.y) then
    exit;

  if (coord.y >= 0) and (coord.y < RowCount) and (coord.y <> EditRow) then
  begin
    with InfoRec[coord.y] do
      if coord.x = 0 then
        s := name
      else if PropEdit <> nil then
        s := PropEdit.GetValue
      else
        s := '';

    if s <> '' then
    begin
      fillchar(r, sizeof(r), 0);

      DrawText(Canvas.Handle, pchar(s), length(s), r, DT_CALCRECT or DT_SINGLELINE);
      crect := CellRect(coord.x, coord.y);

      if coord.x = 0 then
        inc(crect.left, GetXTextOffset(coord.y))
      else
        dec(crect.left);

      if r.Right > (crect.right - crect.left) then
      begin
        _Hint.ActivateHintAtPos(ClientToScreen(Point(crect.left, crect.top)), s);
        exit;
      end;
    end;

    HideHint;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if ColSizing then
  begin
    if (X > MINWIDTH) and (Width - MINWIDTH > X) then
    begin
      DrawSizingLine;
      CurSizePos := X;
      DrawSizingLine;
      if Assigned(fOnSplitterMoving) then
        fOnSplitterMoving(Self, X);
      exit;
    end
  end
  else if IsEmpty or (csDesigning in ComponentState) then
    inherited
  else if (ssLeft in Shift) and not fDoubleClicked then
    DragRow(x, y);

  DisplayHint;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ShowPopup(X, Y: integer);
var
  pt: TPoint;
  fpopup: TPopupMenu;
begin
  {$IFNDEF D6}
  fcedit.Free;
  {$ELSE}
  fcedit:=nil;
  {$ENDIF}

  if (oiSmartPopup in Options) and
    (ctrls.count = 1) and (TPersistent(ctrls[0]) is TComponent)
    and (not IsFDesigner(Designer) or (Designer as IDCFDesigner).AllowEditList(ctrls, '')) then
    fcedit := GetComponentEditor(TComponent(ctrls[0]), fdesign)
  else
    fcedit := nil;

  fpopup := GetControlPopupMenu(self);
  if Assigned(FPopup) and Assigned(fPopup.OnPopup) then
    fPopup.OnPopup(FPopup);

  MakeComponentPopup(fpopup, fmenu, fcedit);
  if Assigned(fmenu) then
  begin
    fmenu.OnPopup := nil;
    fmenu.PopupComponent := Self;
    pt := ClientToScreen(Point(X, Y));
    fmenu.Popup(pt.X, pt.Y);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.MouseUp;
var
  fText: string;
begin
  if ColSizing then
  begin
    DrawSizingLine;
    if (MINWIDTH > X) then
      X := MINWIDTH;

    if (X > Width - MINWIDTH) then
      X := Width - MINWIDTH;

    ColWidths[0] := X;
    ColWidths[1] := Width - ColWidths[0];
    ColSizing := false;

    if not (csDesigning in ComponentState) then
      fText := Editor.Text;

    KillEditor;
    DrawLines;
    CreateInplaceEditor(EditRow);

    if not (csDesigning in ComponentState) then
      Editor.Text := fText;

    if Assigned(fOnSplitterMoved) then
      fOnSplitterMoved(Self, X);
  end
  else if csDesigning in ComponentState then
    inherited
  else if Button = mbRight then
    ShowPopup(X, Y);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CollapseRow(arow: integer);
var
  i: integer;
  j: integer;
begin
  if (InfoRec[arow].substate = ssExpanded) and
    (fExpandMode <> AlwaysExpand) and not InfoRec[arow].AlwaysExpand then
  begin

    i := arow + 1;
    {
          j := arow + 1;

          while (i < rowcount) and (InfoRec[j].sublevel > InfoRec[arow].sublevel) do
            begin
              if not InfoRec[arow].groupname then
                RemoveItem(fObjects, InfoRec[j])
              else
                inc(j);
              inc(i);
            end;

         rowcount := rowcount - (i - arow - 1);
    }
    while (i < rowcount) and (InfoRec[i].sublevel > InfoRec[arow].sublevel) do
    begin
      //if not InfoRec[arow].groupname then
      begin
        InfoRec[i].Free;
        fObjects[i] := nil;
      end;
      inc(i);
    end;

    j := arow + 1;
    if i <> j then
    begin
      while i < rowcount do
      begin
        FObjects[j] := FObjects[i];
        fObjects[i] := nil;
        inc(j);
        inc(i);
      end;
      rowcount := j;
    end;

    with fObjects do
      while Count > rowcount do
        Remove(Last);

    InfoRec[arow].substate := ssCollapsed;
    if not (ReadOnly or InfoRec[arow].groupname) then
      MoveEditor;
    Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ExpandGroup(arow: integer);
var
  curgroup: integer;
  i: integer;
  j: integer;
  info: TInfoRec;
begin
  rcount := 0;
  curgroup := InfoRec[arow].group;
  for j := 0 to finfos.count - 1 do
    if finfos[j] <> nil then
      with TInfoRec(finfos[j]) do
        if (group = curgroup) or ((group = -1) and (curgroup = fothergroup)) then
          inc(rcount);

  rowcount := rowcount + rcount;
  for i := 1 to rcount do
    FObjects.Add(nil);

  for i := rowcount - rcount - 1 downto arow + 1 do
    FObjects[i + rcount] := FObjects[i];

  i := 1;
  for j := 0 to finfos.count - 1 do
    if finfos[j] <> nil then
      with TInfoRec(finfos[j]) do
        if (group = curgroup) or ((group = -1) and (InfoRec[arow].group = fothergroup)) then
        begin
          info := TInfoRec.Create;
          info.groupname := false;
          info.parent := arow;
          info.sublevel := 1;
          info.PropEdit := PropEdit;
          info.editclass := GetEditorClass(PropEdit);
          info.popupclass := GetPopupClass(PropEdit);
          info.name := name;
          info.realname := realname;
          info.substate := substate;
          info.AutoExpand := AutoExpand;
          info.AutoCollapse := AutoCollapse;
          info.Alwaysexpand := Alwaysexpand;
          info.NeverExpand := NeverExpand;
          info.NeverShow := NeverShow;
          info.PReadOnly := PReadOnly;
          info.group := group;

          FObjects[arow + i] := info;
          inc(i);
        end;

  InfoRec[arow].substate := ssExpanded;

  i := arow + 1;
  if i < rowcount then
    repeat
      with InfoRec[i] do
        if ((substate = ssCollapsed) and (AutoExpand or AlwaysExpand)) or
           ((substate = ssExpanded) and AutoCollapse) then
          DoPlusMinus(i);
      inc(i);
    until (i = rowcount) or (InfoRec[i].groupname);

  Invalidate;
  UpdateScrollBar;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DoGetDisplayName(irec: TInfoRec; arow: integer);
var
  cx: integer;
begin
  if Assigned(fOnGetDisplayName) then
    fOnGetDisplayName(self, TDCDsgnProperty(irec.PropEdit), _GetProperty(arow, true), irec.name);

  if AutoSizeNames then
  begin
    if irec.groupname then
      Canvas.Font := fGroupFont
    else
      Canvas.Font := Font;

    cx := Canvas.TextWidth(irec.name) + GetXTextOffset(arow) + 3;
    if cx > ColWidths[0] then
      ColWidths[0] := cx;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DoPlusMinus(arow: integer);
var
  i: integer;
  PropEdit: TDCDsgnProp;
  irec: TInfoRec;
  //  flist    : TStringList;
begin
  PropEdit := InfoRec[arow].PropEdit;

  if (InfoRec[arow].substate = ssCollapsed) and not InfoRec[arow].NeverExpand then
  begin
    if InfoRec[arow].groupname then
    begin
      ExpandGroup(arow);
      exit;
    end;

    if PropEdit = nil then
      exit;

    flist := TStringList.Create;
    try
      rcount := 0;
      flist.sorted := not (CustomSort or (oiUnSorted in Options));
      flist.Duplicates := dupAccept;

      self.arow := arow;
      PropEdit.GetProperties(GetPropEdit);
      rowcount := rowcount + rcount;
      for i := 1 to rcount do
        FObjects.Add(nil);

      for i := rowcount - rcount - 1 downto arow + 1 do
        FObjects[i + rcount] := FObjects[i];

      for i := 1 to rcount do
      begin
        irec := TInfoRec(flist.Objects[i - 1]);
        AddEditorToEditorList(irec.PropEdit);
        FObjects[i + arow] := irec;
        DoGetDisplayName(irec, i + arow);
      end;

      InfoRec[arow].substate := ssExpanded;
      Invalidate;
    finally
      flist.Free;
    end;
  end
  else
    CollapseRow(arow);

  UpdateScrollBar;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Col0DblClick;
var
  coord: TGridCoord;
begin
  GetMouseCell(coord);
  DoPlusMinus(coord.y);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DoEdit(arow: integer);
var
  PropEditor: TDCDsgnProp;
  processed: boolean;
  s: string;
  //  pdesign    : TFormDesigner;
begin
  if readonly then
    exit;

  with InfoRec[arow] do
  begin
    if groupname then
      exit;

    PropEditor := InfoRec[arow].PropEdit;
  end;

  if not AllowEdit(PropEditor) then
    exit;

  processed := false;

  if Assigned(fOnEditButtonClick) then
    fOnEditButtonClick(Self, TDCDsgnProperty(PropEditor), processed);

  if processed then
    exit;

  //  pdesign := PropEditor.Designer;
  PropEditor.Edit;
  //  pdesign.Modified;

  if EditActive then
    with TOInplaceEdit(Editor) do
    begin
      s := PropEditor.GetValue;
      if Text <> s then
      begin
        if TrackPropChange then
          Text := s;

        BroadCastToNotifiers(self, CM_PROPCHANGED, integer(Ctrls), integer(PropEditor.GetName));
      end;

      if Assigned(fOnChangedPropValue) then
        fOnChangedPropValue(self, TDCDsgnProperty(PropEditor), s);

      SelectAll;
    end;

  UpdateValues;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Col1DblClick;
var
  coord: TGridCoord;
begin
  GetMouseCell(coord);
  arow := coord.y;
  DoEdit(arow);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.EditClick(Sender: TObject);
begin
  DoEdit(row);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.GetMouseCell(var cell: TGridCoord);
var
  p: TPoint;
begin
  GetCursorPos(p);
  p := ScreenToClient(p);
  cell := MouseCoord(p.x, p.y);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ProcessDblClick;
var
  coord: TGridCoord;
  oldrowcount: integer;
  oldrow: integer;
begin
  if IsEmpty then
    exit;

  GetMouseCell(coord);

  arow := coord.y;
  if arow = -1 then
    exit;

  oldrow := row;
  oldrowcount := rowcount;

  if coord.x = 0 then
    Col0DblClick
  else
    Col1DblClick;

  if (row <> oldrow) or (rowcount <> oldrowcount) then
    UpdateEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DblClick;
begin
  inherited;
  ProcessDblClick;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.KillEditor;
var
  isfocused: boolean;
  {$IFDEF D4}
  isactive: boolean;
  {$ENDIF}
begin
  if (csDesigning in ComponentState) or (Editor = nil) then
    exit;

  TOInplaceEdit(Editor).InternalMove(Rect(-200, -200, 0, 0), True);
  {$IFDEF D4}
  isactive := ContainsControl(GetParentForm(self).ActiveControl);
  {$ENDIF}
  isfocused := Editor.Focused;
  TOInplaceEdit(Editor).PropEditor := nil;
  if isfocused then
    Editor.SetFocus;
  EditActive := false;
  {$IFDEF D4}
  if isactive then
    GetParentForm(self).ActiveControl := self;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CreateInplaceEditor(arow: longint);
var
  PropEdit: TDCDsgnProp;
  attr: TPropertyAttributes;
  needfocus: boolean;
begin
  if (csDesigning in ComponentState) then
    exit;

  needfocus := Focused or Editor.Focused or Assigned(Editor.Edit) and
    (Editor.Edit is TWinControl) and (TWinControl(Editor.Edit).Focused);

  if (fObjects.Count <= aRow) or IsEmpty or readonly or InfoRec[arow].groupname then
  begin
    KillEditor;
    editrow := arow;
    EditActive := false;
    exit;
  end;

  PropEdit := InfoRec[arow].PropEdit;
  PropEdit.Activate;
  attr := PropEdit.GetAttributes;

  Editor.ReadOnly := not AllowEdit(PropEdit);

  with TOInplaceEdit(Editor) do
  begin
    PropEditor := PropEdit;

    if [paDialog, paValueList] * attr = [paDialog] then
      OnButton1Click := EditClick;

    Self.UpdateEditorState(Editor, PropEdit);
    MoveEditor;
    visible := true;
    ShowWindow(TWinControl(Edit).Handle, SW_SHOW);
    editrow := arow;
    EditActive := true;
    CreateTime := GetTickCount;
  end;

  if needfocus then
    Editor.SetFocus;

  Editor.SelectAll;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ClientToScreenRect(var Rect: TRect);
begin
  with Rect do
  begin
    ClientToScreen(Rect.TopLeft);
    ClientToScreen(Rect.BottomRight);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.UpdateEditor;
var
  Rect: TRect;
begin
  if IsEmpty or (fUpdateCount > 0) or not HandleAllocated then
    exit;

  Rect := CellRect(0, editrow);
  if [oiHorzLine, oiSunkenEditor] * Options <> [] then
  begin
    DrawHorzLine(Rect.Top);
    if not (oiHorzLine in Options) then
      DrawVertLine;
  end;
  ClientToScreenRect(Rect);
  Inc(Rect.Right, ColWidths[1]);
  Inc(Rect.Bottom);
  Windows.InvalidateRect(Handle, @Rect, true);
  CreateInplaceEditor(row);
  Rect := CellRect(0, row);
  Dec(Rect.Top);
  Inc(Rect.Bottom);
  Inc(Rect.Right, ColWidths[1]);
  ClientToScreenRect(Rect);
  Windows.InvalidateRect(Handle, @Rect, False);
  //  Update;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMMOUSELEAVE(var Message: TMessage);
begin
  HideHint;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMMouseWheel(var Message: TMessage);
var
  delta: integer;
begin
  inc(fWheelDelta, SmallInt(HIWORD(Message.wParam)));
  delta := fWheelDelta div WHEEL_DELTA;

  if delta <> 0 then
  begin
    ScrollToTopRow(toprow - delta);
    dec(fWheelDelta, delta * WHEEL_DELTA);
  end;

  Message.result := 1;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMSize(var Msg: TWMSize);
var
  loc: TRect;
  newloc: TRect;
  rheight: integer;
  delta: integer;
begin
  loc := CellRect(1, EditRow);

  Canvas.Font := Font;
  rheight := Canvas.TextHeight('QWERTYUIOPASDFGHJKLZXCVBNM') + DeltaHeight; //don't resource
  if rheight <> DefaultRowHeight then
    DefaultRowHeight := rheight;

  NoInvalidateMode := true;
  delta := Width - ColWidths[0] - ColWidths[1];
  ColWidths[1] := ColWidths[1] + delta;
  NoInvalidateMode := false;
  UpdateScrollBar;

  if (csDesigning in ComponentState) then
  begin
    inherited;
    exit;
  end;

  if EditActive then
  begin
    Editor.Width := Editor.Width + delta;
    newloc := CellRect(1, EditRow);
    MoveEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.KeyDown(var Key: Word; Shift: TShiftState);

  procedure ProcessTab;
  var
    curcontrol: TWinControl;
    form: TCustomForm;
  begin
    form := GetParentForm(self);
    if Assigned(Editor) and Assigned(Editor.Edit) and (form.ActiveControl = Editor.Edit) then
      curcontrol := TWinControl(Editor.Edit)
    else
      curcontrol := self;

    if oiTabMoveDown in Options then
      if (ssShift in Shift) then
        if row > 0 then
          key := VK_UP
        else
          TMWinControl(form).SelectNext(curcontrol, false, true)
      else if row < rowcount - 1 then
        key := VK_DOWN
      else
        TMWinControl(form).SelectNext(curcontrol, true, true);
  end;

  {------------------------------------------------------------------}

  procedure ProcessEsc;
  var
    pt: TPoint;
  begin
    if ColSizing then
    begin
      DrawSizingLine;
      SetCursor(Screen.Cursors[Cursor]);
      GetCursorPos(pt);
      SetCursorPos(pt.x, pt.y);
      ColSizing := false;
      key := 0;
    end;
  end;

  {------------------------------------------------------------------}

  procedure ProcessPlusMinusAsterisk;
  var
    i: integer;
  begin
    if ((ssCtrl in Shift) or Editor.ReadOnly or ReadOnly or
      InfoRec[editrow].groupname) and
      (((key = VK_PLUS) and (InfoRec[editrow].substate = ssCollapsed)) or
      ((key = VK_MINUS) and (InfoRec[editrow].substate = ssExpanded)) or
      (key = VK_MULTIPLY) and (InfoRec[editrow].substate = ssCollapsed)) then
    begin
      DoPlusMinus(editrow);
      if (key = VK_MULTIPLY) then
      begin
        i := editrow + 1;
        while (i < rowcount) and
          (InfoRec[i].sublevel > InfoRec[editrow].sublevel) do
        begin
          if InfoRec[i].substate = ssCollapsed then
            DoPlusMinus(i);
          inc(i);
        end;
      end;

      key := 0;
    end;
  end;

  {------------------------------------------------------------------}

begin
  if IsEmpty then
  begin
    inherited KeyDown(Key, Shift);
    exit;
  end;

  case key of
    VK_F1:
      if oiShowAxHelp in Options then
      begin
        ShowAxHelp;
        inherited;
        exit;
      end;

    VK_TAB: ProcessTab;
    VK_ESCAPE: ProcessEsc;
  end;

  ProcessPlusMinusAsterisk;

  if not (key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) or
    ((key in [VK_DOWN, VK_NEXT]) and (Row = RowCount - 1))
    or ((key in [VK_UP, VK_PRIOR]) and (Row = 0)) then
  begin
    key := 0;
    exit;
  end;

  if fReadOnly then
  begin
    inherited KeyDown(Key, Shift);
    editrow := row;
    invalidate;
    exit;
  end
  else
    Editor.Term;

  if (row = TopRow) or (row = TopRow + VisibleRowCount) then
    KillEditor;

  fDrawSelection := false;
  inherited KeyDown(Key, Shift);
  fDrawSelection := true;
  UpdateEditor;
  UpdateScrollBar;
  key := 0;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.MoveEditor;
var
  Loc: TRect;
begin
  if IsEmpty or (csDesigning in ComponentState) then
    exit;

  Loc := CellRect(Col, Row);

  Inc(Loc.Top);
  TOInplaceEdit(Editor).Move(Loc);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ScrollToTopRow(newrow: integer);
begin
  if newrow > rowcount - visiblerowcount then
    newrow := rowcount - visiblerowcount
  else if newrow < 0 then
    newrow := 0;

  toprow := newrow;
  UpdateScrollBar;
  if readonly or InfoRec[editrow].groupname or (csDesigning in componentstate) then
    exit;

  Editor.SetFocus;
  MoveEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMVScroll(var Msg: TWMVScroll);
var
  newrow: integer;
  scrollinfo: TScrollInfo;
begin
  case Msg.ScrollCode of
    SB_LINEDOWN: newrow := toprow + 1;
    SB_LINEUP: newrow := toprow - 1;
    SB_PAGEDOWN: newrow := toprow + visiblerowcount;
    SB_PAGEUP: newrow := toprow - visiblerowcount;
    SB_THUMBPOSITION,
      SB_THUMBTRACK:
      with scrollinfo do
      begin
        cbSize := sizeof(scrollinfo);
        fMask := SIF_ALL;
        GetScrollInfo(Self.Handle, SB_VERT, scrollinfo);
        Newrow := scrollinfo.nTrackPos;
      end;
    SB_TOP: newrow := 0;
    SB_BOTTOM: newrow := rowcount - visiblerowcount;
    else
      exit;
  end;

  ScrollToTopRow(newrow);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  HitPos := ScreenToClient(SmallPointToPoint(Msg.Pos));
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMSetCursor(var Msg: TWMSetCursor);
begin
  with Msg do
    if (HitTest = HTCLIENT) and
      (ColSizing or isnear(HitPos.X, Colwidths[0])) and
      (not IsEmpty) then
    begin
      SetCursor(Screen.Cursors[crHSplit]);
      exit;
    end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DrawHorzLine(y: integer);
var
  curx: integer;
  delta: integer;
  memdc: THandle;
  oldbitmap: THandle;
  nbitmap: THandle;
begin
  with Canvas do
    if (oiHorzLine in Options) and (fLineStyle = DottedLine) then
      begin
        memdc := CreateCompatibleDC(Handle);
        nbitmap := CreateCompatibleBitmap(Handle, Width, 1);
        oldbitmap := SelectObject(memdc, nbitmap);
        SetPixel(memdc, 0, 0, ColorToRGB(Colors.HorzLineColor));
        SetPixel(memdc, 1, 0, ColorToRGB(Colors.BackColor));
        delta := 2;
        curx := 2;
        while curx < Width do
        begin
          BitBlt(memdc, curx, 0, delta, 1, memdc, 0, 0, SRCCOPY);
          inc(curx, delta);
          delta := delta * 2;
        end;
        BitBlt(Handle, 0, y - 1, Width, 1, memdc, 0, 0, SRCCOPY);
        SelectObject(memdc, oldbitmap);
        DeleteObject(nbitmap);
        DeleteDC(memdc);
      end
    else
      begin
        if oiHorzLine in Options then
          Pen.Color := fColors.fHorzLineColor
        else
          Pen.Color := fColors.fBackColor;
        MoveTo(0, y - 1);
        LineTo(Width, y - 1);
      end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DrawVertLine;
var
  LastY: integer;
  EditY: integer;
  LastRect: TRect;
  EditRect: TRect;
  ColWidths0: integer;
begin
  EditRect := CellRect(0, EditRow);
  LastRect := CellRect(0, RowCount - 1);
  with Canvas do
  begin
    LastRect := CellRect(0, RowCount - 1);
    LastY := ClientHeight;
    EditY := EditRect.Top;
    if (LastRect.Bottom < LastY) and (LastRect.Bottom > 0) then
      LastY := LastRect.Bottom;

    if not (oiVertLine in Options) then
      Pen.Color := fColors.fBackColor
    else if oiVertLine3D in Options then
      Pen.Color := clBtnShadow
    else
      Pen.Color := fColors.fVertLineColor;

    ColWidths0 := ColWidths[0];
    if EditY < LastY then
    begin
      MoveTo(ColWidths0 - 1, 0);
      LineTo(ColWidths0 - 1, EditY);
      MoveTo(ColWidths0 - 1, EditY + 1);
      LineTo(ColWidths0 - 1, LastY);
    end
    else
    begin
      MoveTo(ColWidths0 - 1, 0);
      LineTo(ColWidths0 - 1, LastY);
    end;
    if (oiVertLine in Options) and (oiVertLine3D in Options) then
    begin
      Pen.Color := clBtnHighlight;
      if EditY < LastY then
      begin
        MoveTo(ColWidths0, 0);
        LineTo(ColWidths0, EditY);
        MoveTo(ColWidths0, EditY + 1);
        LineTo(ColWidths0, LastY);
      end
      else
      begin
        MoveTo(ColWidths0, 0);
        LineTo(ColWidths0, LastY);
      end;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DrawLines;
var
  LastRect: TRect;
  EditRect: TRect;
  LastY: integer;
  y: integer;
  startx: integer;
  starty: integer;
  drawsunk: boolean;
  my: integer;
begin
  with Canvas do
  begin
    startx := 0;
    starty := 0;
    Brush.Color := Color;
    LastRect := CellRect(0, RowCount - 1);
    LastY := ClientHeight;
    if (LastRect.Bottom < LastY) and (LastRect.Bottom > 0) then
      LastY := LastRect.Bottom;

    if not (oiVertLine in Options) then
      DrawVertLine;

    y := DefaultRowHeight;
    while y < starty do
      inc(y, DefaultRowHeight);

    EditRect := CellRect(1, EditRow);
    CopyMode := cmSrcCopy;
    repeat
      drawsunk := ([oiSunkenEditor, oiEditBorder] * fOptions <> []) and fDrawSelection;

      if (y = EditRect.Top) and drawsunk then
      begin
        if not (oiEditBorder in fOptions) then
        begin
          Pen.Color := clBlack;
          MoveTo(startx, y);
          LineTo(Width, y);
        end;
      end
      else if (y = EditRect.Bottom) and drawsunk then
      begin
        if (Color <> clBtnHighlight) then
          Pen.Color := clBtnHighlight
        else
          Pen.Color := clBlack;

        if oiEditBorder in fOptions then
          my := y
        else
          my := y - 1;

        MoveTo(startx, my);
        LineTo(Width, my);
      end
      else
        DrawHorzLine(y);

      inc(y, DefaultRowHeight);
    until y > LastY;

    if (oiVertLine in Options) then
      DrawVertLine;

    if (oiSunkenEditor in Options) and fDrawSelection then
    begin
      if oiEditBorder in fOptions then
        Pen.Color := clBlack
      else
        Pen.Color := fColors.fHorzLineColor;

      MoveTo(startx, EditRect.Top - 1);
      LineTo(Width, EditRect.Top - 1);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Paint;
begin
  with Canvas do
  begin
    Brush.Color := fColors.BackColor;

    if (IsEmpty) then
    begin
      FillRect(ClientRect);
      exit;
    end;

    Font := Self.Font;
    inherited;
    DrawLines;
  end;
end;

{------------------------------------------------------------------}

procedure ScanFlags(pinfo: TPInfo; st: string);
var
  j: integer;
begin
  j := pos(',', st);
  if j <> 0 then
    with pinfo do
    begin
      st := copy(st, j + 1, length(st) - j);
      st := UpperCase(trim(st));
      AutoExpand := pos(SAutoExpand, st) <> 0;
      AutoCollapse := pos(SAutoCollapse, st) <> 0;
      AlwaysExpand := pos(SAlwaysExpand, st) <> 0;
      NeverExpand := pos(SNeverExpand, st) <> 0;
      NeverShow := pos(SNeverShow, st) <> 0;
      PReadOnly := pos(SAlReadOnly, st) <> 0;
    end;
end;

procedure TCustomObjectInspector.ScanAliases;
var
  i: integer;
  eqpos: integer;
  info: TPInfo;
  j: integer;
  st: string;
  newst: string;
  CurGroup: integer;
begin
  if csLoading in ComponentState then
    exit;

  ClearStrings(fGroups);
  fGroups.Sorted := not (CustomSort or (oiUnSorted in Options));
  ClearStrings(fa2);
  for i := 0 to faliases.Count - 1 do
  begin
    st := trim(faliases.Strings[i]);
    j := pos(';', st);
    if j <> 0 then
      st := copy(st, 1, j - 1);

    if st = '' then
      continue;

    if st[1] = '[' then
    begin
      j := pos(']', st);
      if j = 0 then
        continue;

      info := TPInfo.Create;
      ScanFlags(info, st);
      st := copy(st, 2, j - 2);
      fGroups.AddObject(st, info);
    end;
  end;

  fothergroup := fGroups.AddObject(fOtherGroupName, nil);
  CurGroup := -1;
  for i := 0 to faliases.Count - 1 do
  begin
    st := trim(faliases.Strings[i]);
    j := pos(';', st);
    if j <> 0 then
      st := copy(st, 1, j - 1);

    if st = '' then
      continue;

    if st[1] = '[' then
    begin
      j := pos(']', st);
      if j = 0 then
        continue;

      st := copy(st, 2, j - 2);
      CurGroup := fGroups.IndexOf(st);
      continue;
    end;

    info := TPInfo.Create;
    eqpos := pos('=', st);
    j := pos(',', st);
    if ((j > eqpos) or (j = 0)) and (eqpos > 0) then
      j := eqpos;

    if j = 0 then
      j := length(faliases.Strings[i]) + 1;

    newst := UpperCase(trim(copy(faliases.Strings[i], 1, j - 1)));
    with info do
    begin
      AutoExpand := false;
      AutoCollapse := false;
      AlwaysExpand := false;
      NeverExpand := false;
      NeverShow := false;
      PReadOnly := false;
      group := curgroup;
      if eqpos = 0 then
        Alias := ''
      else
      begin
        Alias := copy(st, eqpos + 1, length(st) - eqpos);
        j := pos(',', Alias);
        if j <> 0 then
          Alias := copy(Alias, 1, j - 1);
      end;
      Alias := trim(Alias);
      ScanFlags(info, st);
    end;
    fa2.Objects[fa2.Add(newst)] := TObject(info);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DestroyNotification(Instance: TObject);
begin
  DelControl(TPersistent(Instance));
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetPropOrder(val: TStrings);
begin
  fPropOrder.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetReadOnlyProps(val: TStrings);
begin
  fReadOnlyProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetHiddenProps(val: TStrings);
begin
  fHiddenProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetDisplayedProps(val: TStrings);
begin
  fDisplayedProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetUseOtherGroup(val: boolean);
begin
  if val <> fUseOtherGroup then
  begin
    fUseOtherGroup := val;
    ShowInfo;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetCustomSort(val: boolean);
begin
  if val <> fCustomSort then
  begin
    fCustomSort := val;
    ShowInfo;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetTrackDestroy(val: boolean);
var
  i: integer;
begin
  if val <> fTrackDestroy then
  begin
    fTrackDestroy := val;
    for i := 0 to ctrls.Count - 1 do
      if val then
        AddFreeNotify(TPersistent(ctrls[i]))
      else
        RemoveFreeNotify(TPersistent(ctrls[i]));
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetAliases(val: TStrings);
begin
  faliases.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetFilter(val: TTypeKinds);
begin
  if fFilter = val then
    exit;

  fFilter := val;
  showinfo;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.TopLeftChanged;
begin
  DrawLines;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and fTrackDestroy then
    DelControl(AComponent);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Loaded;
begin
  inherited loaded;
  ScanAliases;
  if csDesigning in ComponentState then
    Setcontrol(self);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.SelectCell(ACol, ARow: Longint): Boolean;
begin
  result := true;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.Invalidate;
begin
  if NoInvalidateMode then
    exit;

  inherited Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.BeginUpdate;
begin
  if fUpdateCount = 0 then
    fUpdated := false;

  inc(fUpdateCount);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.EndUpdate;
begin
  if fUpdateCount > 0 then
  begin
    dec(fUpdateCount);
    if (fUpdateCount = 0) and fUpdated then
      showinfo;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ExpandAll;
var
  i: integer;
begin
  if IsEmpty then
    exit;

  i := 0;
  KillEditor;
  repeat
    if InfoRec[i].substate = ssCollapsed then
      DoPlusMinus(i);

    inc(i);
  until i = rowcount;
  UpdateEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ExpandAuto;
var
  i: integer;
begin
  if IsEmpty {or (fObjects.Count = 0)} then
    exit;

  i := 0;
  KillEditor;
  repeat
    with InfoRec[i] do
      if ((substate = ssCollapsed) and
        (AutoExpand or AlwaysExpand or (fExpandList.IndexOf(GetProperty(i)) >= 0))) or
        ((substate = ssExpanded) and (AutoCollapse or (fCollapseList.IndexOf(GetProperty(i)) >= 0))) then
        DoPlusMinus(i);

    inc(i);

  until i = rowcount;

  UpdateEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CollapseAuto;
var
  i: integer;
begin
  if IsEmpty then
    exit;

  i := rowcount - 1;
  repeat
    with InfoRec[i] do
      if (substate = ssExpanded) and NeverExpand then
        DoPlusMinus(i);

    dec(i);
  until i < 0;
  UpdateEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CollapseAll;
var
  i: integer;
begin
  if IsEmpty then
    exit;

  i := rowcount - 1;
  repeat
    if InfoRec[i].substate = ssExpanded then
      DoPlusMinus(i);

    dec(i);
  until i < 0;
  UpdateEditor;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetExpandMode(val: TExpandMode);
begin
  if val = fExpandMode then
    exit;

  fExpandMode := val;
  if val = AlwaysExpand then
    ExpandAll;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetGridOptions(val: TOIOptions);
var
  EditRect: TRect;
  needrescan: boolean;
  sunkchanged: boolean;

const
  constoptions = [oiJoinControls, oiUseAliases, oiUseGroups, oiSmartPopup,
    oiUnSorted, oiEnterMoveDown, oiTabMoveDown, oiShowActiveX,
    oiShowAxHelp, oiGroupsDown];

  rescanoptions = [oiJoinControls, oiUseAliases, oiUseGroups, oiUnSorted, oiGroupsDown];
begin
  if fStyle <> isCustom then
    val := (val * constoptions) + (foptions - constoptions);

  sunkchanged := (oiSunkenEditor in fOptions) and not (oiSunkenEditor in val) and
    not (csCreating in ControlState);
  needrescan := (val * rescanoptions) <> (fOptions * rescanoptions);
  fOptions := val;

  if sunkchanged then
  begin
    MoveEditor;
    with Canvas do
    begin
      EditRect := CellRect(1, EditRow);
      Pen.Color := Colors.BackColor;
      MoveTo(0, EditRect.Top);
      LineTo(Width, EditRect.Top);
    end;
  end;

  if needrescan then
  begin
    scanaliases;
    showinfo;
  end;
  invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetLineStyle(val: TLineStyle);
begin
  if (val = fLineStyle) or (fStyle <> isCustom) then
    exit;

  fLineStyle := val;
  DrawLines;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetColors(val: TOIColors);
begin
  if (fStyle <> isCustom) then
    exit;

  fColors.Assign(val);
  inherited Color := Colors.fBackColor;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetFixedColWidth(val: integer);
begin
  ColWidths[0] := val;
  ColWidths[1] := ClientWidth - val;
  UpdateEditor;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetFixedColWidth: integer;
begin
  result := ColWidths[0];
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetUseGlobalOptions(val: boolean);
begin
  if val <> fUseGlobalOptions then
  begin
    fUseGlobalOptions := val;
    if val then
      LoadGlobalOptions;
  end;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetUseGlobalOptions: boolean;
begin
  result := fUseGlobalOptions;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetDelphiStyle;
begin
  with Colors do
  begin
    fBackColor := clBtnFace;
    inherited Color := fBackColor;
    fCol0Color := clBlack;
    fCol1Color := clNavy;
    fOptions := fOptions + [oiSunkenEditor, oiVertLine3D, oiHorzLine, oiVertLine] - [oiEditBorder];
    fVertLineColor := clBtnShadow;
    fHorzLineColor := clBtnShadow;
    fLineStyle := DottedLine;
    fHighLightColor := clBlack;
    fHighLightBkgnd := clBtnFace;
    fGroupFont.Assign(Self.Font);
    fGroupFont.Style := fGroupFont.Style + [fsBold];
  end;

  if not (csCreating in ControlState) then
  begin
    UpdateEditor;
    Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetVBStyle;
var
  EditRect: TRect;
begin
  with Colors do
  begin
    fBackColor := clWindow;
    inherited color := clWindow;
    fCol0Color := clBlack;
    fCol1Color := clBlack;
    fVertLineColor := clSilver;
    fHorzLineColor := clSilver;
    fHighLightColor := clBlack;
    fHighLightBkgnd := clWindow;
    fLineStyle := SolidLine;

    if (oiSunkenEditor in fOptions) then
      with Canvas do
      begin
        EditRect := CellRect(1, EditRow);
        Pen.Color := Colors.BackColor;
        MoveTo(0, EditRect.Top);
        LineTo(Width, EditRect.Top);
      end;

    fOptions := fOptions - [oiSunkenEditor, oiVertLine3D] + [{oiSunkenEditor,} oiHorzLine, oiVertLine, oiEditBorder];
    UpdateEditor;
    with fGroupFont do
    begin
      Assign(Self.Font);
      Style := Style + [fsBold];
    end;
  end;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetGroupFont(val: TFont);
begin
  fGroupFont.Assign(val);
  Invalidate;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetInfoRec(Index: Longint): TInfoRec;
begin
  result := TInfoRec(FObjects[Index]);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetOtherGroupName(const val: string);
begin
  fOtherGroupName := val;
  ScanAliases;
  Showinfo;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ColorsChanged(sender: TObject);
begin
  Color := Colors.BackColor;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetReadOnly(val: boolean);
begin
  fReadOnly := val;

  if csDesigning in ComponentState then
    exit;

  if val then
    KillEditor
  else
    CreateInplaceEditor(row);

  Editor.ReadOnly := val;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetOnShowProperty(val: TOnShowProc);
begin
  fOnShowProperty := val;
  ShowInfo;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetOnGetCellParams(val: TGetCellParamsProc);
begin
  fOnGetCellParams := val;
  Invalidate;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.AllowShowProp(const PropEdit: TDCDsgnProp): boolean;
var
  isEmpty: boolean;
  i: integer;
begin
  isEmpty := True;

  for i := 0 to fDisplayedProps.Count - 1 do
  begin
    isEmpty := fDisplayedProps.Strings[i] = '';
    if not isEmpty then
      break;
  end;

  result := (isEmpty or (fDisplayedProps.IndexOf(PropEdit.GetName) >= 0)) and
    (fHiddenProps.IndexOf(PropEdit.GetName) < 0);

  if result then
    with PropEdit do
      if IsFDesigner(Designer) then
        result := (Designer as IDCFDesigner).AllowPropShowList(ctrls, GetName);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.AllowEdit(const PropEdit: TDCDsgnProp): boolean;
var
  pinfo: TPInfo;
  pname: string;
  clist: TList;
  {$IFNDEF D6}
  i: integer;
  {$ENDIF}
begin
  pname := PropEdit.GetName;

  result := fReadOnlyProps.IndexOf(pname) < 0;

  if not result then
    exit;

  pinfo := FindAlias(pname);

  if pinfo <> nil then
    result := not pinfo.PReadOnly;

  if result then
    with PropEdit do
    begin
      clist := TList.Create;
      try
        {$IFDEF D6}
        CList.Assign(ctrls);
        {$ELSE}
        clist.Count := PropCount;
        for i := 0 to PropCount - 1 do
          clist[i] := GetComponent(i);
        {$ENDIF}

        if IsFDesigner(Designer) then
          result := (Designer as IDCFDesigner).AllowEditList(clist, GetName);
      finally
        clist.Free;
      end;
    end;

  if result and Assigned(OnEditProperty) then
    OnEditProperty(self, TDCDsgnProperty(PropEdit), result);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ChangeValue(const PropEdit: TDCDsgnProp; val: string);

  function NoChanges: boolean;
  begin
    result := (PropEdit.GetValue = val) and (ctrls.Count < 2);
  end;

var
  fName: string;

begin
  if NoChanges or not AllowEdit(PropEdit) then
    exit;

  fName := PropEdit.GetName;

  if Assigned(fOnChangePropValue) then
    fOnChangePropValue(self, TDCDsgnProperty(PropEdit), val);

  if NoChanges then
    exit;

  try
    PropEdit.SetValue(val);
  finally
    BroadCastToNotifiers(self, CM_PROPCHANGED, integer(Ctrls), integer(fName));
  end;

  if Assigned(fOnChangedPropValue) then
    fOnChangedPropValue(self, TDCDsgnProperty(PropEdit), val);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector._getname(index: integer; UseRealNames: boolean): string;
begin
  with inforec[index] do
    if UseRealNames then
      result := RealName
    else
      result := Name;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector._SetFocusToProperty(PropName: string; UseRealNames: boolean);
var
  plevel: integer;
  pname: string;
  currow: integer;
  ppos: integer;
  found: boolean;
begin
  if IsEmpty then
    exit;

  plevel := -1;
  currow := 0;

  repeat
    ppos := pos('.', propname);
    if ppos <> 0 then
    begin
      pname := copy(propname, 1, ppos - 1);
      propname := copy(propname, ppos + 1, length(propname) - ppos);
    end
    else
      pname := propname;

    found := false;

    while (currow < rowcount) and (inforec[currow].sublevel > plevel) do
    begin
      if (UseRealNames and (inforec[currow].RealName = pname)) or
        (not UseRealNames and (inforec[currow].Name = pname)) then
      begin
        found := true;
        break;
      end;
      inc(currow);
    end;

    if not found then
      exit;

    if ppos = 0 then
    begin
      row := currow;
      UpdateEditor;
      exit;
    end;

    plevel := inforec[currow].sublevel;
    inc(currow);
  until false;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetFocusToProperty(PropName: string);
begin
  _setfocustoproperty(PropName, false);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetFocusToRealProperty(PropName: string);
begin
  _setfocustoproperty(PropName, true);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetGroupRow(const AGroupName: string): integer;
begin
  for result := 0 to rowcount - 1 do
    with InfoRec[result] do
      if groupname and (CompareText(name, AGroupName) = 0) then
        exit;

  result := -1;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ExpandGroupByName(const GroupName: string);
var
  i: integer;
begin
  i := GetGroupRow(GroupName);
  if (i >= 0) and (Inforec[i].SubState = ssCollapsed) then
  begin
    DoPlusMinus(i);
    UpdateEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetEditorToRow(newrow: integer);
begin
  Row := newrow;
  UpdateEditor;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CollapseGroupByName(const GroupName: string);
var
  i: integer;
begin
  i := GetGroupRow(GroupName);
  if (i >= 0) and (Inforec[i].SubState = ssExpanded) then
  begin
    DoPlusMinus(i);
    UpdateEditor;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetStyle(val: TInspectorStyle);
begin
  fstyle := val;
  if style = isDelphi then
    SetDelphiStyle
  else if style = isVB then
    SetVBStyle;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.UpdateScrollBar;

  procedure killscroller;
  begin
    if HandleAllocated then
    begin
      SetScrollRange(Handle, SB_VERT, 0, 0, True);
      ColWidths[1] := ClientWidth - ColWidths[0] - 1;
      UpdateEditor;
    end;
  end;

var
  CRect: TRect;
  i: integer;
  scrollinfo: TScrollInfo;

begin
  if noinvalidatemode then
    exit;

  if IsEmpty then
  begin
    killscroller;
    exit;
  end;

  i := 0;

  while (i < rowcount) do
  begin
    CRect := CellRect(0, i);
    if CRect.Bottom <> 0 then
      break;
    inc(i);
  end;

  if i = rowcount then
  begin
    killscroller;
    exit;
  end;

  while (i < rowcount) do
  begin
    CRect := CellRect(0, i);
    if CRect.Bottom = 0 then
      break;
    inc(i);
  end;

  with ScrollInfo do
  begin
    cbSize := sizeof(ScrollInfo);
    fMask := SIF_ALL;
    nMin := 0;
    nPage := Self.VisibleRowCount;
    nMax := RowCount - 1;
    nPos := TopRow;
  end;

  SetScrollInfo(Handle, SB_VERT, ScrollInfo, True);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  if isnear(Msg.XPos, ColWidths[0]) or ColSizing then
    Msg.result := 1;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AddEditorToEditorList(const PropEdit: TDCDsgnProp);
begin
  fEditList.Add(propedit);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ComponentChanged;
begin
  if Assigned(fOnComponentChanged) then
    fOnComponentChanged(self);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.UpdateEditorValue;
var
  ntext: string;
begin
  if (Editor <> nil) and (TOInplaceEdit(Editor).PropEditor <> nil) then
  begin
    ntext := TOInplaceEdit(Editor).PropEditor.GetValue;
    if Editor.Text <> ntext then
      Editor.Text := ntext;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.UpdateValues;
var
  edrect: TRect;

  procedure UpdateRect(top, bottom: integer);
  var
    r: TRect;
  begin
    r := Rect(ColWidths[0], top, ClientWidth, bottom);
    if oiVertLine3D in Options then
      inc(r.Left, 2);

    InvalidateRect(Handle, @r, false);
  end;

begin
  if IsEmpty or not HandleAllocated then
    exit;

  UpdateEditorValue;

  edrect := CellRect(1, editrow);

  UpdateRect(0, edrect.top);
  UpdateRect(edrect.bottom + 1, ClientHeight);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.AliasesChanged(Sender: TObject);
begin
  ScanAliases;
  ShowInfo;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetAliases: TStrings;
begin
  result := fAliases;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector._GetProperty(arow: integer; UseRealNames: boolean): string;
var
  slevel: integer;
begin
  result := '';
  if IsEmpty then
    exit;

  result := _getname(arow, UseRealNames);

  if inforec[arow].groupname then
  begin
    result := '::' + result;
    exit;
  end;

  while true do
  begin
    slevel := InfoRec[arow].sublevel;
    repeat
      dec(arow);
    until (arow = -1) or (InfoRec[arow].sublevel < slevel);

    if (arow = -1) or (inforec[arow].groupname) then
      exit;

    result := _getname(arow, UseRealNames) + '.' + result;
  end;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetRealProperty(arow: integer): string;
begin
  result := _GetProperty(arow, true);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetProperty(arow: integer): string;
begin
  result := _GetProperty(arow, false);
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetActiveProperty: string;
begin
  result := GetProperty(row);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetEditRow(val: integer);
begin
  fEditRow := val;
  EditRowChanged;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.EditRowChanged;
begin
  if ([csloading, csdestroying] * ComponentState = []) and
    not (csCreating in ControlState) then
  begin
    if Assigned(fOnActivePropertyChanged) then
      fOnActivePropertyChanged(self);
    NotifyChange;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if EditActive then
    Editor.SetFocus;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMRButtonUp(var Message: TWMRButtonUp);
begin
  if not ColSizing then
    ShowPopup(Message.XPos, Message.YPos);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ReScan;
begin
  ShowInfo;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.UpdateEditorState(Editor: TCustomDCEdit; const PropEdit: TDCDsgnProp);
begin
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_TAB) and (oiTabMoveDown in Options) then
    Message.Result := 1;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.IsInspectorKey(key: word; Shift: TShiftState): boolean;
begin
  case key of
    VK_ESCAPE: result := ColSizing;

    VK_F1: result := oiShowAxHelp in Options;

    VK_DOWN, VK_UP, VK_PRIOR, VK_NEXT, VK_TAB: result := true;

    VK_MULTIPLY, VK_PLUS, VK_MINUS:
      result := (ssCtrl in Shift) or ReadOnly or
        InfoRec[EditRow].groupname or Editor.ReadOnly;
    else
      result := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMOBJDESTROYED(var Msg: TMessage);
begin
  with Msg do
    if WParam <> 0 then
      DelControl(TPersistent(WParam))
    else if Lparam <> 0 then
      DelControls(TList(LParam));
end;

{------------------------------------------------------------------}

(*
procedure TCustomObjectInspector.SelectionChanged(var Msg : TMessage);
begin
  {if (fdesign = nil) or (Msg.lParam = integer(fdesign)) then
    SetControls(TList(Msg.wParam));}
end;

*)
{------------------------------------------------------------------}

procedure TCustomObjectInspector.PropChanged(var Msg: TMessage);
begin
  if ListsIntersect(TList(Msg.wParam), ctrls) then
    UpdateValues;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.CanHaveSubNodes: boolean;
var
  i: integer;
begin
  result := false;

  if isEmpty then
    exit;

  for i := 0 to fObjects.Count - 1 do
    if InfoRec[i].substate <> ssNoSub then
    begin
      result := true;
      exit;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.GetTabOrderList(List: TList);
var
  form: TCustomForm;
begin
  form := GetParentForm(self);
  if Assigned(form) and Assigned(Editor) and Assigned(Editor.Edit) and (form.ActiveControl = Editor.Edit) then
    with List do
    begin
      if Count > 0 then
        Remove(Last);

      Add(Editor.Edit);
    end
  else
    inherited GetTabOrderList(List);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if oiTabMoveDown in Options then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetGroupCount: integer;
begin
  result := fgroups.Count;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.LoadGlobalOptions;
begin
  with GlobalInspectorOptions do
  begin
    self.Options := Options;
    self.Style := Style;
    self.Aliases := Aliases;
    self.ShowHints := ShowHints;
    self.HiddenProps := HiddenProps;
  end;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.FindPropDesc(const PropName: string): integer;
var
  C: TClass;
  pname: string;
begin
  c := GetCommonClassesParent(ctrls);
  repeat
    pname := c.ClassName + '.' + PropName;

    if fDescNames.Find(pname, result) then
      exit;

    c := c.ClassParent;
  until c = TObject;

  if not fDescNames.Find(PropName, result) then
    result := -1;
end;

{------------------------------------------------------------------}

function TCustomObjectInspector.GetActivePropDesc: string;
var
  index: integer;
begin
  index := FindPropDesc(GetRealProperty(row));
  if index >= 0 then
  begin
    result := fDescs.Strings[integer(fDescNames.Objects[index])];
    index := pos('=', result);
    delete(result, 1, index);
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ParamsChanged(Sender: TObject);
begin
  ShowInfo;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.DescsChanged(Sender: TObject);
var
  i: integer;
begin
  fDescNames.Clear;
  for i := 0 to fDescs.Count - 1 do
    if fDescs.Names[i] <> '' then
      fDescNames.AddObject(Trim(fDescs.Names[i]), pointer(i));

  NotifyChange;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.SetDescriptions(val: TStrings);
begin
  fDescs.Assign(val);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.NotifyChange;
begin
  BroadCastToNotifiers(self, CM_INSPECTOR_CHANGED, integer(self), 0);
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.ShowAxHelp;
begin

end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMInspectorRescan(var Message: TMessage);
begin
  Rescan;
end;

{------------------------------------------------------------------}

procedure TCustomObjectInspector.CMFontChanged(var Message: TMessage);
begin
  inherited;
  UpdateEditor;
end;

{------------------------------------------------------------------}

type
  TAxInplaceEdit = class(TOInplaceEdit)
  protected
    function GetEditType: TControlClass; override;
    function GetPopupType: TWinControlClass; override;
  end;

type
  TFake = class(TComponent)
  private
    fA: TCustomAxInspector;
  published
    property A: TCustomAxInspector read fA;
  end;

  {------------------------------------------------------------------}

  TFake2 = class(TComponent)
  private
    fA: TCustomAxInspector;
  published
    property A: TCustomAxInspector read fA;
  end;

  {------------------------------------------------------------------}

  TFakeFont = class(TComponent)
  private
    fA: TFont;

    procedure SetFont(val: TFont);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property A: TFont read fA write SetFont;
  end;

  {------------------------------------------------------------------}

constructor TFakeFont.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fA := TFont.Create;
end;

{------------------------------------------------------------------}

destructor TFakeFont.Destroy;
begin
  fA.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TFakeFont.SetFont(val: TFont);
begin
  fA.Assign(val);
end;

{------------------------------------------------------------------}

type
  TMFontProperty = class(TFontProperty)
  private
    fFakeFont: TFakeFont;
    fPropName: string;
    fdisp: IDispatch;
    fdispid: TDispID;

    procedure FontChanged(Sender: TObject);
  public
    function GetName: string; override;
    destructor Destroy; override;
  end;

destructor TMFontProperty.Destroy;
begin
  fFakeFont.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TMFontProperty.GetName: string;
begin
  result := fPropName;
end;

{------------------------------------------------------------------}

procedure TMFontProperty.FontChanged(Sender: TObject);
var
  temp: IFontDisp;
  varg: TVariantArg;
begin
  GetOleFont(fFakeFont.fA, Temp);
  FillChar(varg, sizeof(varg), 0);
  varg.vt := VT_FONT;
  varg.dispVal := Pointer(Temp);
  SetPropByDispatch(fdisp, fdispid, OleVariant(varg));
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetIntfImplementer:TObject;
begin
  Result:=Self;
end;

{------------------------------------------------------------------}

destructor TAxPropEditor.Destroy;
var
  i: integer;
begin
  if Assigned(fIti) and Assigned(funcdesc) then
    fIti.ReleaseFuncDesc(funcdesc);
  CoTaskMemFree(fccook.pElems);
  for i := 0 to fcstr.cElems - 1 do
    CoTaskMemFree(fcstr.pElems[i]);

  CoTaskMemFree(fcstr.pElems);
  fenumdesc.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetName: string;
begin
  result := fPropName;
end;

{------------------------------------------------------------------}

function BoolToStr(v: boolean): string;
begin
  result := GetEnumName(TypeInfo(Boolean), integer(v));
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetEventValue: string;
begin
  if fInspector.fIsWrapper then
    result := fInspector.fOleControl.GetEvent(fdispid)
  else
    result := '';
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetValue: string;
var
  wres: WideString;
  res: OleVariant;
  index: integer;
begin
  if fIsEvent then
  begin
    Result := GetEventValue;
    exit;
  end;

  if IsImageProperty then
  begin
    result := '(Bitmap)'; //don't resource
    exit;
  end;

  if IsStringListProperty then
  begin
    result := '(Strings)'; //don't resource
    exit;
  end;

  {
    if fImageList then
      begin
        result := '';
        exit;
      end;
  }
  disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @res, nil, nil);
  result := '';

  if VarIsNull(res) or VarIsEmpty(res) then
    exit;

  if fcstr.cElems = 0 then
  begin
    if fIsColor then
      result := ColorToString(TVarData(res).vinteger)
    else if Assigned(fenumdesc) then
    begin
      index := fenumdesc.IndexOfObject(TObject(TVarData(res).VInteger));
      if index >= 0 then
        result := fenumdesc[index];
    end
    else if TVarData(res).vType = varBoolean then
      result := BoolToStr(res)
    else
      result := VarToStr(res);
  end
  else
  begin
    if fpropbrowse.GetDisplayString(fdispid, wres) = 0 then
      result := {$IFDEF D3}wres{$ELSE}WideCharToString(wres){$ENDIF}
    else if TVarData(res).vType in [varSmallInt, varInteger] then
    begin
      index := res;
      result := {$IFDEF D3}fcstr.pElems[index]{$ELSE}WideCharToString(fcstr.pElems[index]){$ENDIF};
    end
    else
      result := VarToStr(res);
  end
end;

{------------------------------------------------------------------}

function TAxPropEditor.IsIntfProperty(const aguid: TGUID): boolean;
var
  res: OleVariant;
  fi: IUnknown;
begin
  result := false;
  if fIsEvent or (disp = nil) then
    exit;

  if fcstr.cElems = 0 then
  begin
    disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @res, nil, nil);
    fi := nil;
    if TVarData(res).vtype = varDispatch then
      if TVarData(res).vDispatch <> nil then
        {$IFDEF D3}IDispatch(res){$ELSE}VarToInterface(res){$ENDIF}.QueryInterface(aguid, fi)
      else if IsEqualGUID({$IFDEF D3}IUnknown{$ELSE}IID_IUnknown{$ENDIF}, aguid) then
      begin
        result := true;
        exit;
      end;

    result := fi <> nil;
  end;
end;

{------------------------------------------------------------------}
{$IFNDEF D3}
const
  DISPID_PICTURE = -523;
  IID_PictureDisp: TGUID = (D1: $7BF80981; D2: $BF32; D3: $101A; D4: ($8B, $BB, $00, $AA, $00, $30, $0C, $AB));
  {$ENDIF}

function TAxPropEditor.IsImageProperty: boolean;
begin
  result := (fmemid = DISPID_PICTURE) or IsIntfProperty({$IFDEF D3}IPictureDisp{$ELSE}IID_PictureDisp{$ENDIF});
end;

{------------------------------------------------------------------}

function TAxPropEditor.IsFontProperty: boolean;
begin
  result := (fmemid = DISPID_FONT) or IsIntfProperty({$IFDEF D3}IFont{$ELSE}IID_IFont{$ENDIF});
end;

{------------------------------------------------------------------}

function TAxPropEditor.IsStringListProperty: boolean;
begin
  {$IFDEF D3}
  result := IsIntfProperty(IStrings);
  {$ELSE}
  result := false;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetAttributes: TPropertyAttributes;
begin
  if fIsEvent then
  begin
    result := [paMultiSelect, paValueList, paSortList, paRevertable];
    exit;
  end;

  result := [paMultiSelect];
  if IsFontProperty or IsImageProperty or IsStringListProperty or not IsEqualGUID(GUID_NULL, fpclsid) then
    result := result + [paDialog, paReadOnly]
  else if (fcstr.cElems <> 0) or (fenumdesc <> nil) or fIsColor or fBindable {or fImageList} then
    Include(result, paValueList);
end;

{------------------------------------------------------------------}

procedure TAxPropEditor._setVal(const varg: TVariantArg);
var
  id: integer;
begin
  id := fdispid;
  if id = 0 then
    id := fmemid;
  SetPropByDispatch(disp, id, OleVariant(varg));
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.SetEventValue(const Value: string);
var
  NewMethod: Boolean;
  CurValue: string;
begin
  if not fInspector.fIsWrapper then
    exit;

  CurValue := GetValue;
  if (CurValue <> '') and (Value <> '') and
    ((CompareText(CurValue, Value) = 0) or
    not Designer.MethodExists(Value)) then
    Designer.RenameMethod(CurValue, Value)
  else
  begin
    NewMethod := (Value <> '') and not Designer.MethodExists(Value);
    fInspector.fOleControl.SetEvent(fdispid, Value);
    if NewMethod then
      Designer.ShowMethod(Value);
  end;
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.SetValue(const Value: string);
var
  wvalue: WideString;
  i: integer;
  vvar: OleVariant;
  index: integer;
  //  refole  : TDCOleWrapper;
  //  iimlist : IImageList;
begin
  if fIsEvent then
  begin
    SetEventValue(Value);
    Modified;
    exit;
  end;

  {  if fImageList then
      begin
        refole := TDCOleWrapper(GetParentForm(TControl(fInspector.Ctrls[0])).FindComponent(Value));
        if refole = nil then
          exit;
        TVarData(vvar).vType := varDispatch;
        refole.OleObject.QueryInterface(IImageList, iimlist);
        TVarData(vvar).vDispatch := Pointer(iimlist);
      end
    else}
  {$IFNDEF D3}
  wValue := nil;
  try
    {$ENDIF}
    if fIsColor then
      vvar := ColorToRGB(StringToColor(Value))
    else if fenumdesc <> nil then
    begin
      index := fenumdesc.IndexOf(Value);
      if index >= 0 then
        vvar := integer(fenumdesc.Objects[index]);
    end
    else if fcstr.cElems = 0 then
    begin
      {$IFDEF D3}
      wvalue := value;
      vvar := wvalue;
      {$ELSE}
      wvalue := S2WS(value);
      with TVarData(vvar) do
      begin
        vType := varOleStr;
        VOleStr := wValue;
      end;
      {$ENDIF}
    end
    else
    begin
      for i := 0 to fcstr.cElems - 1 do
        if CompareText({$IFNDEF D3}WideCharToString(fcstr.pElems[i]){$ELSE}fcstr.pElems[i]{$ENDIF}, Value) = 0 then
        begin
          fpropbrowse.GetPredefinedValue(fdispid, fccook.pElems[i], vvar);
          break;
        end;
    end;

    _setval(TVariantArg(vvar));
    Designer.Modified;
    {$IFNDEF D3}
  finally
    if wvalue <> nil then
      SysFreeString(wvalue);
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.GetEvents(Proc: TGetStrProc);
var
  tdata: TTypeData;
begin
  FillTypeData(tdata);
  Designer.GetMethods(@tdata, Proc);
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.GetValues(Proc: TGetStrProc);
var
  i: integer;
  //  icur    : IUnknown;
  //  idisp   : IDispatch;
  //  icp     : IConnectionPointContainer;
  //  cpenum  : IEnumConnectionPoints;
  //  icpoint : IConnectionPoint;
  //  res     : integer;
  //  ciid    : TGUID;
  //  iunk    : IUnknown;
begin
  if fIsEvent then
  begin
    GetEvents(Proc);
    exit;
  end;

  if fIsColor then
    GetColorValues(Proc)

  else if fcstr.cElems <> 0 then
    for i := 0 to fcstr.cElems - 1 do
      Proc({$IFDEF D3}fcstr.pElems[i]{$ELSE}WideCharToString(fcstr.pElems[i]){$ENDIF})

  else if fenumdesc <> nil then
    StringsToProc(fenumdesc, Proc);

  {  else if fImageList then
      begin
        with GetParentForm(TControl(fInspector.ctrls[0])) do
          for i := 0 to ComponentCount - 1 do
            if (Components[i] is TDCOleWrapper) and (Components[i] <> fInspector.ctrls[0]) then
              with TDCOleWrapper(Components[i]) do
                begin
                  if OleObject.QueryInterface(IImageList, iunk) = S_OK then
                    Proc(Name);
                end;
      end};
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.EditImage;
var
  res: OleVariant;
  ipic: IPicture;
  varg: TVariantArg;
  temp: IPictureDisp;
  ppic: TPicture;
begin
  ppic := TPicture.Create;
  with TGlyphEditForm.Create(nil) do
  try
    Caption := fInspector.GetDisplayName + '.' + GetName;
    disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @res, nil, nil);
    if not VarIsEmpty(res) then
    begin
      {$IFDEF D3}IDispatch(res){$ELSE}VarToInterface(res){$ENDIF}.QueryInterface({$IFDEF D3}IPicture{$ELSE}IID_IPicture{$ENDIF}, ipic);
      SetOlePicture(Image.Picture, ipic);
    end;

    ppic.Assign(Image.Picture);
    FillChar(varg, sizeof(varg), 0);
    varg.vt := VT_PICTURE;

    if ShowModal = idOk then
      GetOlePicture(Image.Picture, temp)
    else
      GetOlePicture(ppic, temp);

    varg.dispVal := Pointer(Temp);
    _setval(varg);
  finally
    Free;
    ppic.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.EditFont;
var
  olefont: OleVariant;
  varg: TVariantArg;
  temp: IFontDisp;
begin
  with TFontDialog.Create(Application) do
  try
    OleCheck(disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @olefont, nil, nil));
    OleFontToFont(olefont, Font);
    Options := Options + [fdShowHelp, fdForceFontExist];
    if Execute then
    begin
      GetOleFont(Font, Temp);
      FillChar(varg, sizeof(varg), 0);
      varg.vt := VT_FONT;
      varg.dispVal := Pointer(Temp);
      _setval(varg);
    end;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}
{$IFDEF D3}

procedure TAxPropEditor.EditStringList;
var
  olestrings: OleVariant;
  varg: TVariantArg;
  temp: IStrings;
begin
  OleCheck(disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @olestrings, nil, nil));
  with TStringsEditForm.Create(Application) do
  try
    EditName := GetName;
    Caption := fInspector.GetDisplayName + '.' + GetName;
    SetOleStrings(memo1.Lines, IStrings(TVarData(OleStrings).vDispatch));
    ShowNumberOfLines;
    if (ShowModal = idOk) then
    begin
      GetOleStrings(memo1.Lines, Temp);
      FillChar(varg, sizeof(varg), 0);
      varg.vt := VT_DISPATCH;
      varg.dispVal := Pointer(Temp);
      _setval(varg);
    end;
  finally
    Free;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure TAxPropEditor.EditPropPage;
var
  ipp: ISpecifyPropertyPages;
  pages: TCAGUID;
  params: TOCPFIParams {TOCPFIParams};
  p: pointer;
  caption: WideString;
begin
  disp.QueryInterface({$IFDEF D3}ISpecifyPropertyPages{$ELSE}IID_ISpecifyPropertyPages{$ENDIF}, ipp);
  ipp.GetPages(pages);
  with params do
  begin
    cbStructSize := sizeof(params);
    hWndOwner := fInspector.Handle;
    caption := S2WS(TComponent(fInspector.ctrls[0]).Name);
    lpszCaption := PWideChar(caption);
    cobjects := 1;
    p := Pointer(disp);
    pobjects := @p;
    cpages := pages.cElems;
    ppages := pages.pElems;
    dispidInitialProperty := fdispid;
  end;
  //  function OleCreatePropertyFrameIndirect(var Params: TOCPFIParams): HResult; stdcall;
  OleCreatePropertyFrameIndirect(Params);
  {$IFNDEF D3}
  SysFreeString(params.lpszCaption);
  {$ENDIF}
end;

{------------------------------------------------------------------}

type
  TParamRecord = record
    Flags: TParamFlags;
    ParamName: ShortString;
    TypeName: ShortString;
  end;

  {------------------------------------------------------------------}

  // This function is here because D3 compiler has a bug

{$IFDEF D6}
function tdesctostring(Designer: IDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ELSE}
function tdesctostring(Designer: TFormDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ENDIF}
begin
  result := TypeDescToString(Designer, Iti, desc);
end;

{$IFDEF D6}
function TypeDescToString(Designer: IDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ELSE}
function TypeDescToString(Designer: TFormDesigner; iti: ITypeInfo; desc: TTypeDesc): string;
{$ENDIF}
var
  RefInfo: ITypeInfo;
  PAttr: PTypeAttr;

begin
  result := '';

  if desc.vt = VT_PTR then
  begin
    if desc.ptdesc <> nil then
      result := TypeDescToString(Designer, iti, desc.ptdesc^)
    else
      result := TypeToString(Designer, VT_PTR);
  end
  else if desc.vt = VT_USERDEFINED then
  begin
    iti.GetRefTypeInfo(desc.hreftype, RefInfo);
    RefInfo.GetTypeAttr(PAttr);
    if IsEqualGUID(PAttr.guid, GUID_OLE_COLOR) then
      result := TypeToString(Designer, VT_OLECOLOR)
    else if PAttr.typekind = TKIND_ALIAS then
      result := TypeDescToString(Designer, iti, PAttr.tdescAlias)
    else
      result := '';
  end
  else if desc.vt <= VT_LPWSTR then
    result := TypeToString(Designer, desc.vt);

  if result = '' then
    result := 'Variant'; //don't resource
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.FillTypeData(var tdata: TTypeData);
var
  s: TMemoryStream;
  mk: TMethodKind;
  restype: ShortString;
  paramcount: byte;
  paramrec: TParamRecord;
  i: integer;
  pnames: TBStrList;
  pcount: integer;
  {$IFDEF D3}
  vflags: integer;
  {$ENDIF}
  desc: TTypeDesc;

  procedure writestring(const st: ShortString);
  begin
    s.Write(st, length(st) + 1);
  end;

  procedure writeparam;
  begin
    with paramrec do
    begin
      s.Write(Flags, sizeof(Flags));
      WriteString(ParamName);
      WriteString(TypeName);
    end;
  end;

begin
  if funcdesc.elemdescFunc.idldesc.wIDLFlags = 0 then
    mk := mkProcedure
  else
  begin
    mk := mkFunction;
    restype := TypeDescToString(Designer, fIti, funcdesc.elemdescFunc.tdesc);
  end;

  ParamCount := funcdesc.cParams;
  fiti.GetNames(fdispid, @pNames, ParamCount + 1, pcount);

  s := TMemoryStream.Create;
  try
    s.WriteBuffer(mk, sizeof(mk));
    pcount := ParamCount + 1;
    s.Write(pCount, sizeof(byte));

    with paramrec do
    begin
      Flags := [pfAddress];
      ParamName := 'Sender'; //don't resource
      TypeName := 'TObject'; //don't resource
      writeparam;
    end;

    for i := 1 to ParamCount do
      with paramrec do
      begin
        {$IFDEF D3}
        vflags := funcdesc.lprgelemdescParam^[i - 1].idldesc.dwReserved;
        {$ENDIF}
        Flags := [];

        desc := funcdesc.lprgelemdescParam^[i - 1].tdesc;

        {$IFDEF D3}
        if (vflags and IDLFLAG_FOUT) <> 0 then
          Include(Flags, pfOut);
        {$ENDIF}
        if (desc.vt = VT_PTR) and (desc.ptdesc <> nil) then
          Include(Flags, pfVar);

        ParamName := WideCharToString(pnames[i]);

        if Assigned(TypeToString) then
          TypeName := tdesctostring(Designer, fiti, desc);

        WriteParam;
      end;

    WriteString(restype);
    Move(s.Memory^, tdata, s.Size);
  finally
    s.Free;
  end;
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetTrimmedEventName: string;
begin
  Result := GetName;
  if (Length(Result) >= 2) and
    (Result[1] in ['O', 'o']) and (Result[2] in ['N', 'n']) then
    Delete(Result, 1, 2);
end;

{------------------------------------------------------------------}

function TAxPropEditor.GetFormMethodName: string;
var
  i: Integer;
begin
  {$IFDEF D3}
  Result := Designer.GetObjectName(fInspector.ctrls[0]);
  {$ELSE}
  Result := TComponent(fInspector.ctrls[0]).Name;
  {$ENDIF}
  for I := Length(Result) downto 1 do
    if Result[I] in ['.', '[', ']'] then
      Delete(Result, I, 1);

  if Result = '' then
    {$IFDEF D3}
    raise EPropertyError.Create(SCannotCreateName);
    {$ELSE}
    raise EPropertyError.CreateRes(SCannotCreateName);
    {$ENDIF}
  Result := Result + GetTrimmedEventName;
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.EditEvent;
var
  typedata: TTypeData;
  FormMethodName: string;
begin
  FillTypeData(typedata);
  FormMethodName := GetValue;

  if (FormMethodName = '') or Designer.MethodFromAncestor(GetMethodValue) then
  begin
    if FormMethodName = '' then
      FormMethodName := GetFormMethodName;
    if FormMethodName = '' then
      {$IFDEF D3}
      raise EPropertyError.Create(SCannotCreateName);
    {$ELSE}
      raise EPropertyError.CreateRes(SCannotCreateName);
    {$ENDIF}
  end;

  Designer.CreateMethod(FormMethodName, @TypeData);
  SetValue(FormMethodName);
  Designer.ShowMethod(FormMethodName);
end;

{------------------------------------------------------------------}

procedure TAxPropEditor.Edit;
begin
  if fIsEvent then
    EditEvent
  else if IsFontProperty then
    EditFont
  else if IsImageProperty then
    EditImage
      {$IFDEF D3}
  else if IsStringListProperty then
    EditStringList
      {$ENDIF}
  else if not IsEqualGUID(GUID_NULL, fpclsid) then
    EditPropPage
  else
    inherited Edit;
end;

{------------------------------------------------------------------}

function TAxPropEditor._GetPropType;
var
  res: OleVariant;
begin
  if fIsColor then
    result := TypeInfo(TColor)
  else if IsFontProperty then
    result := TypeInfo(TFont)
  else if IsImageProperty then
    result := TypeInfo(TImage)
  else if IsStringListProperty then
    result := TypeInfo(TStrings)
  else
  begin
    result := nil;
    if fcstr.cElems = 0 then
    begin
      if disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @res, nil, nil) <> S_OK then
        exit;
      if TVarData(res).vType = VT_BOOL then
        result := TypeInfo(Boolean);
    end;
  end;
end;

{******************************************************************}
{$IFDEF D6}
function __GetEdit(const PropEditor: TDCDsgnProp;AComp:TPersistent): TControlClass;
{$ELSE}
function __GetEdit(const PropEditor: TDCDsgnProp): TControlClass;
{$ENDIF}
var
  ti: PTypeInfo;
  A:TObject;
begin
  result := GetEditClass(PropEditor{$IFDEF D6},AComp{$ENDIF});

  {$IFDEF D6}
  A:=PSCGetIntfInstance(PropEditor);
  {$ELSE}
  A:=PropEditor;
  {$ENDIF}

  if A is TAxPropEditor then
    with TAxPropEditor(A) do
    begin
      if fIsEvent then
        exit;

      ti := _GetPropType;
      if ti <> nil then
        result := _GetEditClass(ti, nil, '');
    end;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
function __GetPopup(const PropEdit: TDCDsgnProp;AComp:TPersistent): TWinControlClass;
{$ELSE}
function __GetPopup(const PropEdit: TDCDsgnProp): TWinControlClass;
{$ENDIF}
var
  A:TPropertyEditor;
begin
  A:=DCDsgnPropToPropEdit(PropEdit);
  if (A is TAxPropEditor) and TAxPropEditor(A).fIsColor then
    result := _GetPopupClass(TypeInfo(TColor), nil, '')
  else
    result := dcpedit.GetPopupClass(PropEdit{$IFDEF D6},AComp{$ENDIF});
end;

{******************************************************************}

function TAxInplaceEdit.GetEditType: TControlClass;
begin
  if TCustomAxInspector(Inspector).fIsContainer then
    result := __GetEdit(PropEditor{$IFDEF D6},GetComponent{$ENDIF})
  else
    result := inherited GetEditType;
end;

{------------------------------------------------------------------}

function TAxInplaceEdit.GetPopupType: TWinControlClass;
begin
  if TCustomAxInspector(Inspector).fIsContainer then
    result := __GetPopup(PropEditor{$IFDEF D6},GetComponent{$ENDIF})
  else
    result := inherited GetPopupType;
end;

{******************************************************************}

constructor TCustomAxInspector.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fFake := TFake.Create(nil);
  fFakeList := TComponentList.Create;
  TMComponentList(fFakeList).Add(fFake);

  fFake2 := TFake2.Create(nil);
  fFakeList2 := TComponentList.Create;
  TMComponentList(fFakeList2).Add(fFake2);
end;

{------------------------------------------------------------------}

destructor TCustomAxInspector.Destroy;
begin
  fFakeList.Free;
  fFake.Free;
  fFakeList2.Free;
  fFake2.Free;
  //  fEditList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomAxInspector.GetPropEdit(const Prop: TDCDsgnProp);
var
  A:TObject;
begin
  If PSCSupportsInstance(Prop,TAxPropEditor,A) then
    fEdit := Prop;
end;
{$ELSE}
procedure TCustomAxInspector.GetPropEdit(Prop: TDCDsgnProp);
begin
  if Prop is TAxPropEditor then
    fEdit := TAxPropEditor(Prop);
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomAxInspector.GetPropEdit2(const Prop: TDCDsgnProp);
var
  A:TObject;
begin
  If PSCSupportsInstance(Prop,TMFontProperty,A) then
    fEdit2 := Prop;
end;
{$ELSE}
procedure TCustomAxInspector.GetPropEdit2(Prop: TDCDsgnProp);
begin
  if Prop is TMFontProperty then
    fEdit2 := TMFontProperty(Prop);
end;
{$ENDIF}

{------------------------------------------------------------------}

function TCustomAxInspector.GetEditorClass(const PropEdit: TDCDsgnProp): TControlClass;
begin
  if fIsContainer then
    result := __GetEdit(PropEdit{$IFDEF D6},CurrentControl{$ENDIF})
  else
    result := inherited GetEditorClass(PropEdit);
end;

{------------------------------------------------------------------}

function TCustomAxInspector.GetPopupClass(const PropEdit: TDCDsgnProp): TWinControlClass;
begin
  if fIsContainer then
    result := __GetPopup(PropEdit{$IFDEF D6},CurrentControl{$ENDIF})
  else
    result := inherited GetPopupClass(PropEdit);
end;

{------------------------------------------------------------------}

function TCustomAxInspector.GetInplaceEditClass: TInplaceEditClass;
begin
  result := TAxInplaceEdit;
end;

{------------------------------------------------------------------}

const
  ColorIDsCount = 6;
  ColorIDs: array[1..ColorIDsCount] of TMemberID =
    (DISPID_BACKCOLOR, DISPID_BORDERCOLOR, DISPID_FILLCOLOR, DISPID_FORECOLOR,
    DISPID_AMBIENT_BACKCOLOR, DISPID_AMBIENT_FORECOLOR);

function IsColorID(id: TMemberID): boolean;
var
  i: integer;
begin
  result := false;
  for i := 1 to ColorIDsCount do
    if ColorIDs[i] = id then
    begin
      result := true;
      exit;
    end;
end;

{------------------------------------------------------------------}

function TCustomAxInspector.IsColorProperty(memid: TMemberID; iti: ITypeInfo; TypeDesc: TTypeDesc): boolean;
var
  RefInfo: ITypeInfo;
  RefAttr: PTypeAttr;
begin
  result := IsColorID(memid);

  if not result then
    case TypeDesc.vt of
      VT_USERDEFINED:
        begin
          OleCheck(iti.GetRefTypeInfo(TypeDesc.hreftype, RefInfo));
          OleCheck(RefInfo.GetTypeAttr(RefAttr));
          if IsEqualGUID(RefAttr.guid, GUID_OLE_COLOR) then
            result := true;
        end;
      VT_PTR:
        if TypeDesc.ptdesc <> nil then
          result := IsColorProperty(memid, iti, TypeDesc.ptdesc^);
    end;
end;

{------------------------------------------------------------------}
{$IFDEF D6}
procedure TCustomAxInspector._getpropedit(const propedit: TDCDsgnProp);
{$ELSE}
procedure TCustomAxInspector._getpropedit(propedit: TDCDsgnProp);
{$ENDIF}
begin
  AddEditorToEditorList(propedit);
end;

{------------------------------------------------------------------}

function TCustomAxInspector.ComparePropEditorsByPropName(const Prop1, Prop2: TDCDsgnProp): integer;
var
  name1: string;
  name2: string;
begin
  name1 := Prop1.GetName;
  name2 := Prop2.GetName;

  result := AnsiCompareStr(name1, name2);
end;

{------------------------------------------------------------------}

function TCustomAxInspector.ComparePropEditors(const Prop1, Prop2: TDCDsgnProp): integer;
var
  name1: string;
  name2: string;
  i1: integer;
  i2: integer;
begin
  name1 := Prop1.GetName;
  name2 := Prop2.GetName;

  result := CompareStr(name1, name2);

  if CustomSort then
  begin
    i1 := PropOrder.IndexOf(name1);
    i2 := PropOrder.IndexOf(name2);

    if (i1 >= 0) and (i2 >= 0) then
      result := i1 - i2
    else if (i1 >= 0) or (i2 >= 0) then
      result := i2 - i1;
  end;

  if Assigned(OnCompare) then
    OnCompare(self, TDCDsgnProperty(Prop1), TDCDsgnProperty(Prop2), result);
end;

{------------------------------------------------------------------}

threadvar
  _Inspector: TCustomAxInspector;

{$IFDEF D6}
function PCompare(Item1, Item2: IUnknown): Integer;
var
  Item1P, Item2P:TDCDsgnProp;
begin
  If Supports(Item1,TDCDsgnProp,Item1P) and Supports(Item2,TDCDsgnProp,Item2P) then
    result:=_Inspector.ComparePropEditors(Item1P, Item2P)
  else
    result:=0;
end;
{$ELSE}
function PCompare(Item1, Item2: Pointer): Integer;
begin
 result:=_Inspector.ComparePropEditors(Item1, Item2);
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF D6}
function PCompareNames(Item1, Item2: IUnknown): Integer;
var
  Item1P, Item2P:TDCDsgnProp;
begin
  If Supports(Item1,TDCDsgnProp,Item1P) and Supports(Item2,TDCDsgnProp,Item2P) then
    result:=_Inspector.ComparePropEditorsByPropName(Item1P, Item2P)
  else
    result:=0;
end;
{$ELSE}
{
function PCompareNames(Item1, Item2: Pointer): Integer;
begin
 result:=_Inspector.ComparePropEditorsByPropName(Item1, Item2);
end;
}
{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomAxInspector.SortEditorsList;
{$IFNDEF D6}
var
  l: TStringList;
  i: integer;
{$ENDIF}
begin
  if CustomSort then
  begin
    _Inspector := self;
    fEditList.Sort(PCompare);
  end
  else
  begin
    {$IFDEF D6}
    _Inspector := self;
    fEditList.Sort(PCompareNames);
    {$ELSE}
    l := TStringList.Create;
    try
      for i := 0 to fEditList.Count - 1 do
        l.AddObject(TDCDsgnProp(fEditList[i]).GetName, fEditList[i]);
      l.Sort;
      fEditList.Clear;
      for i := 0 to l.Count - 1 do
        fEditList.Add(l.Objects[i]);
    finally
      l.Free;
    end;
    {$ENDIF}
  end;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomAxInspector._GetMultiPropEdit(const Prop: TDCDsgnProp);
var
  A:TObject;
begin
  If PSCSupportsInstance(Prop,TAxMultiSelectPropEdit,A) then
    fMultiEdit := TAxMultiSelectPropEdit(A);
end;
{$ELSE}
procedure TCustomAxInspector._GetMultiPropEdit(Prop: TDCDsgnProp);
begin
  if Prop is TAxMultiSelectPropEdit then
    fMultiEdit := Prop;
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomAxInspector.GetAllPropertyEditors(Components: TComponentList;
  Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc);
var
  i: integer;
  j: integer;
  k: integer;
  clist: TComponentList;
  fList: TList;
  name: string;
  ccount: integer;
  fOldCount: integer;
begin
  fOldCount := fEditList.Count;
  //  fEditList.Clear;
  fList := TList.Create;
  clist := TComponentList.Create;

  try
    CompListToList(Components, fList);
    i := 0;
    ccount := 0;

    while i < fList.Count do
      if IsOCX(TObject(fList[i])) then
      begin
        GetPropertyEditors(TComponent(fList[i]), Filter, Designer, _getpropedit);
        fList.Delete(i);
        inc(ccount);
      end
      else
        inc(i);

    if ccount < TMComponentList(Components).Count then
      inc(ccount);

    ListToCompList(fList, clist);
    GetComponentProperties(clist, Filter, Designer, _getpropedit);

    SortEditorsList;

    i := fOldCount;
    while i < fEditList.Count do
    begin
      j := i;
      name := TDCDsgnProp(fEditList[i]).GetName;
      while (j < fEditList.Count - 1) and (TDCDsgnProp(fEditList[j + 1]).GetName = name) do
        inc(j);

      if j - i = CCount - 1 then
        if i = j then
          Proc(TDCDsgnProp(fEditlist[i]))
        else
        begin
          GetComponentProperties(fFakelist2, tkAny, fDesign, _GetMultiPropEdit);
          with TAxMultiSelectPropEdit(fMultiEdit) do
          begin

            {$IFDEF D6}
            PropEditList := TDCInterfaceList.Create;
            {$ELSE}
            PropEditList := TList.Create;
            {$ENDIF}

            for k := i to j do
              if paMultiSelect in TDCDsgnProp(fEditList[k]).GetAttributes then
                PropEditList.Add(fEditList[k]);

            if PropEditList.Count > 0 then
              Proc(fMultiEdit)
            else
              {$IFDEF D6}
              fMultiEdit:=nil;
              {$ELSE}
              fMultiEdit.Free;
              {$ENDIF}
          end;
        end;

      i := j + 1;
    end;

  finally
    clist.Free;
    flist.Free;
  end;
end;

{------------------------------------------------------------------}

function TCustomAxInspector.IsOCX(Instance: TObject): boolean;
begin
  result := (oiShowActiveX in Options) and
    (
    ((Instance is TOleContainer) and (TOleContainer(Instance).State <> osEmpty)) or
    (Instance is TCustomDCOleControl));
end;

{------------------------------------------------------------------}

procedure TCustomAxInspector.SetOnCompare(val: TOICompareEvent);
begin
  fOnCompare := val;
  ShowInfo;
end;

{------------------------------------------------------------------}

procedure TCustomAxInspector.GetPropertyEditors(AComponent: TComponent;
  Filter: TTypeKinds; Designer: TFormDesigner; Proc: TGetPropEditProc);
var
  iti: ITypeInfo;
  idisp: IDispatch;
  events: boolean;
  clist: TComponentList;
begin
  fIsContainer := IsOCX(AComponent);

  if not fIsContainer then
  begin
    inherited;
    exit;
  end;

  fiswrapper := AComponent is TCustomDCOleControl;
  if fiswrapper then
    fOleControl := TCustomDCOleControl(AComponent);

  try
    if (AComponent is TOleContainer) then
      fOleObject := IOleObject(TVarData(TOleContainer(AComponent).OleObject).vDispatch)
    else
      fOleObject := fOleControl.OleObject;

    OleCheck(fOleObject.QueryInterface({$IFDEF D3}IDispatch{$ELSE}IID_IDispatch{$ENDIF}, idisp));
  except
    fiscontainer := false;
  end;

  clist := TComponentList.Create;
  TMComponentList(clist).Add(AComponent);
  try
    GetComponentProperties(clist, Filter, Designer, Proc);
  finally
    clist.Free;
  end;

  if Filter = tkMethods then
  begin
    events := true;
    iti := GetEventDispatchTypeInfo(fOLEObject);
  end
  else
  begin
    OleCheck(idisp.GetTypeInfo(0, 0, iti));
    events := false;
  end;

  if Assigned(iti) then
    GetProperties(AComponent, events, idisp, iti, Proc);
end;

{------------------------------------------------------------------}

function TCustomAxInspector.GetActivePropDesc: string;
var
  propedit: TPropertyEditor;
begin
  if IsEmpty then
  begin
    result := '';
    exit;
  end;
  result := '';

  propedit := DCDsgnPropToPropEdit(InfoRec[editrow].PropEdit);

  if fisContainer and (propedit is TAxPropEditor) then
    with TAxPropEditor(propedit) do
      {$IFNDEF D3}
      if fDocString <> nil then
        {$ENDIF}
        result := WideCharToString(PWideChar(fDocString));

  if (result = '') or (result[1] = #0) then
    result := inherited GetActivePropDesc;
end;

{------------------------------------------------------------------}

type
  TFuncInfo = class
    memid: TMemberID;
    IsColor: boolean;
    IsBind: boolean;
    tdesc: TTypeDesc;
  end;

  {$IFNDEF D3}
const
  FUNCFLAG_FNONBROWSABLE = $0400;
  VARFLAG_FNONBROWSABLE = $0400;
  {$ENDIF}

procedure TCustomAxInspector.GetProperties(AComp: TComponent; ShowEvents: boolean; idisp: IDispatch; iti: ITypeInfo; Proc: TGetPropEditProc);
var
  i: integer;
  rNames: TBSTRList;
  attr: PTypeAttr;
  pvar: PVarDesc;
  pfunc: PFuncDesc;
  res: OleVariant;
  olefont: OleVariant;
  fFont: TFakeFont;
  fFList: TComponentList;
  count: integer;
  aName: WideString;

  procedure CreateEditor(memid: TMemberID; tdesc: TTypeDesc; isColor, isEvent, isBindable: boolean);

    procedure FillEnum;
    var
      RefInfo: ITypeInfo;
      RefAttr: PTypeAttr;
      i: integer;
      VarDesc: PVarDesc;
      Name: WideString;
    begin
      if tDesc.vt = VT_USERDEFINED then
      begin
        OleCheck(iti.GetRefTypeInfo(tDesc.hreftype, RefInfo));
        OleCheck(RefInfo.GetTypeAttr(RefAttr));
        try
          if RefAttr^.typekind = TKIND_ENUM then
          begin
            for i := 0 to RefAttr^.cVars - 1 do
            begin
              OleCheck(RefInfo.GetVarDesc(I, VarDesc));
              try
                OleCheck(RefInfo.GetDocumentation(VarDesc^.memid, @Name,
                  nil, nil, nil));
                with PSCAxPropEditor(fedit) do
                  fenumdesc.AddObject({$IFDEF D3}Name{$ELSE}WideCharToString(Name){$ENDIF}, TObject(TVarData(VarDesc^.lpVarValue^).VInteger))
              finally
                RefInfo.ReleaseVarDesc(VarDesc);
              end;
            end;

          end;
        finally
          RefInfo.ReleaseTypeAttr(RefAttr);
        end;
      end;
    end;

  begin
    GetComponentProperties(fFakelist, tkAny, fDesign, GetPropEdit);
    OleCheck(iti.GetNames(memid, @rNames, 1, count));
    with PSCAxPropEditor(fedit) do
    begin
      fBindable := isBindable;
      fInspector := self;
      fPropName := {$IFDEF D3}rnames[0]{$ELSE}WideCharToString(rnames[0]){$ENDIF};
      fMemID := memid;
      fIti := iti;
      iti.GetDocumentation(memid, @aname, @fDocString, @fHelp, @fHelpFile);

      disp := idisp;

      if isEvent then
      begin
        fIsEvent := true;
        fDispId := memid;
        exit;
      end;

      fenumdesc := TStringList.Create;
      FillEnum;
      if fenumdesc.Count = 0 then
        FreeObject(fenumdesc,fenumdesc);

      if pos('_', fPropName) = 1 then
      begin
        FreeObject(fedit,fedit);
        exit;
      end;

      OleCheck(idisp.GetIDsOfNames(GUID_NULL, @rnames, 1, 0, @fdispid));
      idisp.QueryInterface({$IFDEF D3}IPerPropertyBrowsing{$ELSE}IID_IPerPropertyBrowsing{$ENDIF}, fpropbrowse);

      if fpropbrowse <> nil then
        with fPropBrowse do
        begin
          GetPredefinedStrings(fdispid, fcstr, fccook);
          MapPropertyToPage(fdispid, fpclsid);
        end;

      PSCAxPropEditor(fEdit).fIsColor := isColor;

      if ((fcstr.cElems = 0) and
        (disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @res, nil, nil) <> S_OK)) then
      begin
        FreeObject(fedit,fedit);
        exit;
      end;

      if PSCAxPropEditor(fedit).IsFontProperty then
      begin
        fFList := TComponentList.Create;
        try
          fFont := TFakeFont.Create(nil);
          TMComponentList(fFlist).Add(fFont);
          with fedit do
            OleCheck(disp.Invoke(fdispid, GUID_NULL, 0, DISPATCH_PROPERTYGET, dispparamsNoArgs, @olefont, nil, nil));
          OleFontToFont(olefont, fFont.fA);

          {$IFDEF D6}
          fedit:=nil;
          {$ELSE}
          fedit.Free;
          {$ENDIF}

          GetComponentProperties(fFlist, tkAny, InternalDesigner, GetPropEdit2);
          with TMFontProperty(fedit2) do
          begin
            OleCheck(idisp.GetIDsOfNames(GUID_NULL, @rnames, 1, 0, @fdispid));
            fPropName := {$IFDEF D3}rnames[0]{$ELSE}WideCharToString(rnames[0]){$ENDIF};
            fDisp := idisp;
            fFont.fA.OnChange := FontChanged;
            fFakeFont := fFont;
          end;
          fedit := TAxPropEditor(fedit2);
        finally
          fFlist.Free;
        end;
        exit;
      end;

      //        fImageList := (fPropName = 'ImageList') and (IsIntfProperty(IUnknown));
      //        SendDebug(fPropName);
      if {fImageList and } not (IsImageProperty or IsStringListProperty) and
      IsIntfProperty({$IFDEF D3}IUnknown{$ELSE}IID_IUnknown{$ENDIF}) then
        FreeObject(fedit,fedit);
    end;
  end;

var
  pgetlist: TList;
  pputlist: TList;
  tdesc: TTypeDesc;
  finfo: TFuncInfo;
const
  BadVarFlags = VARFLAG_FREADONLY or VARFLAG_FHIDDEN or VARFLAG_FNONBROWSABLE;
  BadFuncFlags = FUNCFLAG_FHIDDEN or FUNCFLAG_FNONBROWSABLE;
begin
  if idisp = nil then
    exit;
  OleCheck(iti.GetTypeAttr(attr));

  pgetlist := TList.Create;
  pputlist := TList.Create;

  //  fOleObject.QueryInterface(IEnumConnectionPoints, ienum);

  try
    for i := 0 to attr.cVars - 1 do
    begin
      OleCheck(iti.GetVarDesc(i, pvar));
      try
        if pvar.wVarFlags and BadVarFlags = 0 then
        begin
          CreateEditor(pvar.memid, pvar.elemdescVar.tdesc, IsColorProperty(pvar.memid, iti, pvar.elemdescVar.tdesc), false, (pvar.wVarflags and VARFLAG_FDISPLAYBIND) <> 0);
          if fedit <> nil then
            Proc(fedit);
        end;
      finally
        iti.ReleaseVarDesc(pvar);
      end;
    end;

    for i := 0 to attr.cFuncs - 1 do
    begin
      OleCheck(iti.GetFuncDesc(i, pfunc));
      try
        if pfunc.wFuncFlags and BadFuncFlags = 0 then
          case pfunc.invkind of
            INVOKE_FUNC:
              if ShowEvents then
              begin
                CreateEditor(pfunc.memid, tdesc, false, true, false);
                if fedit <> nil then
                begin
                  PSCAxPropEditor(fedit).funcdesc := pfunc;
                  pfunc := nil;
                  Proc(fedit);
                end;
              end;

            INVOKE_PROPERTYGET:
              begin
                finfo := TFuncInfo.Create;
                with finfo do
                begin
                  memid := pfunc.memid;
                  tdesc := pfunc.elemdescFunc.tdesc;
                  IsColor := IsColorProperty(pfunc.memid, iti, tdesc);
                  if not IsColor and (tdesc.vt = VT_HRESULT) then
                    IsColor := IsColorProperty(pfunc.memid, iti, pfunc.lprgelemdescParam^[0].tdesc);
                  IsBind := (pfunc.wFuncflags and FUNCFLAG_FDISPLAYBIND) <> 0;
                end;
                pgetlist.Add(finfo);
              end;

            INVOKE_PROPERTYPUT: pputlist.Add(Pointer(pfunc.memid));
          end;
      finally
        if pfunc <> nil then
          iti.ReleaseFuncDesc(pfunc);
      end;
    end;

    for i := 0 to pgetlist.Count - 1 do
      if pputlist.IndexOf(Pointer(TFuncInfo(pgetlist[i]).memid)) >= 0 then
      begin
        with TFuncInfo(pgetlist[i]) do
          CreateEditor(memid, tdesc, IsColor, false, isbind);
        if fedit <> nil then
          Proc(fedit);
      end;

  finally
    iti.ReleaseTypeAttr(attr);
    FreeList(pgetlist,pgetlist);
    pputlist.Free;
  end;
end;

{------------------------------------------------------------------}

function TCustomAxInspector.GetDisplayName: string;
begin
  result := TComponent(ctrls[0]).name;
end;

{------------------------------------------------------------------}

procedure TCustomAxInspector.ShowAxHelp;
var
  s: string;
  APropEditor:TPropertyEditor;
begin
  If fIsContainer then
    begin
      APropEditor:=DCDsgnPropToPropEdit(InfoRec[editrow].PropEdit);

      if (APropEditor is TAxPropEditor) then
        with TAxPropEditor(APropEditor) do
        begin
          s := {$IFDEF D3}fHelpFile{$ELSE}WideCharToString(fHelpFile){$ENDIF};
          if s <> '' then
            WinHelp(Handle, PChar(s), HELP_CONTEXT, fHelp);
        end;
    end
  else
    inherited ShowAxHelp;
end;

{******************************************************************}

procedure TPropertyHelp.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FInspector) then
    Inspector := nil;
end;

{----------------------------------------------------------}

procedure TPropertyHelp.SetPropertyFont(val: TFont);
begin
  FPropertyFont.Assign(val);
end;

{----------------------------------------------------------}

procedure TPropertyHelp.OnInvalidate(Sender: TObject);
begin
  Invalidate;
end;

{--------------------------------------------}

procedure TPropertyHelp.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

{----------------------------------------------------------}

procedure TPropertyHelp.SetBorderStyle(val: TPropHelpBorderStyle);
begin
  if FBorderStyle <> val then
  begin
    fBorderStyle := val;
    RecreateWnd;
  end;
end;

{--------------------------------------------}

procedure TPropertyHelp.CreateParams(var Params: TCreateParams);
const
  Borders: array[TPropHelpBorderStyle] of DWORD = (0, WS_BORDER, SS_SUNKEN);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'STATIC'); //don't resource
  with Params do
    Style := Style or (SS_NOTIFY or SS_NOPREFIX) or Borders[fBorderStyle];
end;

{----------------------------------------------------------}

procedure TPropertyHelp.Paint;
var
  i: Integer;
  S: string;
  R: TRect;
begin
  with Canvas do
  begin
    Font := PropertyFont;
    with Brush do
    begin
      Color := Self.Color;
      Style := bsSolid;
      Windows.FillRect(Canvas.Handle, ClipRect, Handle);
    end;

    if Assigned(Inspector) then
    begin
      S := Inspector.ActivePropDesc;
      if S = '' then
        exit;
      TextOut(2, 0, Inspector.ActiveProperty);
      i := TextHeight('Wg') + 2; //don't resource
      Font := Self.Font;
      R := Rect(2, i, ClientWidth - 4, Clientheight);
      DrawText(Handle, PChar(S), Length(S), R, DT_WORDBREAK);
    end;
  end;
end;

{----------------------------------------------------------}

constructor TPropertyHelp.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption,
    csOpaque, csReplicatable, csDoubleClicks];
  Width := 185;
  Height := 89;
  fBorderStyle := pbsSunken;
  fPropertyFont := TFont.Create;
  with fPropertyFont do
  begin
    Assign(Font);
    Style := [fsBold];
    OnChange := OnInvalidate;
  end;
  Font.OnChange := OnInvalidate;
  RegisterNotifier(self);
end;

{----------------------------------------------------------}

destructor TPropertyHelp.Destroy;
begin
  UnregisterNotifier(self);
  FPropertyFont.Free;
  inherited;
end;

{----------------------------------------------------------}

procedure TPropertyHelp.SetInspector(val: TCustomObjectInspector);
begin
  fInspector := val;
  Invalidate;
end;

{----------------------------------------------------------}

procedure TPropertyHelp.PropChanged(var Msg: TMessage);
begin
  if Msg.wParam = integer(fInspector) then
    Invalidate;
end;

{-----------------}

function DCIsDsgnPropAxPropEditor(const Prop:TDCDsgnProp):boolean;
begin
  {$IFDEF D6}
  Result:=PSCAxPropEditor(Prop)<>nil;
  {$ELSE}
  Result:=Prop is TAxPropEditor;
  {$ENDIF}
end;

{-----------------}

function TAxMultiSelectPropEdit.GetRealPropType: PTypeInfo;
begin
  result := nil;
  if DCIsDsgnPropAxPropEditor(PropEdit[0]) then
    result := PSCAxPropEditor(PropEdit[0])._GetPropType;
  if result = nil then
    result := inherited GetRealPropType;
end;

{**********************************************************}

procedure AddNonInspectorEditClass(aclass: TControlClass);
begin
  fBadEditorClasses.Add(aclass);
end;

{------------------------------------------------------------------}

procedure RunRegister;
begin
  AddNonInspectorEditClass(TImageEdit);
  AddNonInspectorEditClass(dcpedit.TPictureEdit);

  RegisterOptionExt(TInspectorOptions);
  RegisterPropertyEditor(TypeInfo(TCustomAxInspector), TFake, '', TAxPropEditor);
  RegisterPropertyEditor(TypeInfo(TFont), TFakeFont, '', TMFontProperty);
  RegisterPropertyEditor(TypeInfo(TCustomAxInspector), TFake2, '', TAxMultiSelectPropEdit);
end;

{------------------------------------------------------------------}

var
  OlePro32DLL: THandle = 0;

procedure InitOlePro32;
var
  OldError: Longint;
begin
  OldError := SetErrorMode(SEM_NOOPENFILEERRORBOX);
  try
    if OlePro32DLL = 0 then
    begin
      OlePro32DLL := LoadLibrary('olepro32.dll'); //don't resource
      if OlePro32DLL <> 0 then
      begin
        @_OleCreatePropertyFrameIndirect := GetProcAddress(OlePro32DLL, 'OleCreatePropertyFrameIndirect'); //don't resource
        @_OleCreatePictureIndirect := GetProcAddress(OlePro32DLL, 'OleCreatePictureIndirect'); //don't resource
      end;
    end;
  finally
    SetErrorMode(OldError);
  end;
end;

{------------------------------------------------------------------}

function GlobalInspectorOptions: TInspectorOptions;
begin
  result := TInspectorOptions(GetOptionsByClass(TInspectorOptions));
end;

{******************************************************************}

procedure TInspectorOptions.Update;
var
  i: integer;
begin
  if UpdateDisabled then
    exit;

  with InspectorList do
    for i := 0 to Count - 1 do
      with Inspectors[i] do
        if UseGlobalOptions then
          LoadGlobalOptions;
end;

{----------------------------------------------------------}

procedure TInspectorOptions.SetAliases(val: TStrings);
begin
  fALiases.Assign(val);
end;

{----------------------------------------------------------}

procedure TInspectorOptions.SetHiddenProps(val: TStrings);
begin
  FHiddenProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TInspectorOptions.SetDisplayedProps(val: TStrings);
begin
  FDisplayedProps.Assign(val);
end;

{------------------------------------------------------------------}

procedure TInspectorOptions.SetStyle(val: TInspectorStyle);
begin
  if val <> fStyle then
  begin
    fStyle := val;
    Update;
  end;
end;

{----------------------------------------------------------}

procedure TInspectorOptions.SetOptions(const val: TOIOptions);
begin
  if val <> fOptions then
  begin
    fOptions := val;
    Update;
  end;
end;

{----------------------------------------------------------}

procedure TInspectorOptions.SetShowHints(val: boolean);
begin
  if val <> fShowHints then
  begin
    fShowHints := val;
    Update;
  end;
end;

{----------------------------------------------------------}

constructor TInspectorOptions.Create;
begin
  fAliases := TStringList.Create;
  FHiddenProps := TStringList.Create;
  fDisplayedProps := TStringList.Create;
  inherited;
end;

{----------------------------------------------------------}

procedure TInspectorOptions.StringsChanged(Sender: TObject);
begin
  Update;
end;

{----------------------------------------------------------}

destructor TInspectorOptions.Destroy;
begin
  FAliases.Free;
  FHiddenProps.Free;
  fDisplayedProps.Free;
  inherited;
end;

{----------------------------------------------------------}

function TInspectorOptions.GetKey: string;
begin
  result := 'Inspector\'; //don't resource
end;

{----------------------------------------------------------}

procedure TInspectorOptions.InitValues;
begin
  fOptions := DefaultInspectorOptions;
  Style := isDelphi;
  fAliases.Text := DefaultInspectorAliases;
  TStringList(fAliases).OnChange := StringsChanged;
  TStringList(FHiddenProps).OnChange := StringsChanged;
end;

{**********************************************************}

function TInspectorList.GetInspector(index: integer): TCustomObjectInspector;
begin
  result := TCustomObjectInspector(Items[index]);
end;

{**********************************************************}

var
  fInspectorList: TInspectorList;

function InspectorList: TInspectorList;
begin
  if fInspectorList = nil then
    fInspectorList := TInspectorList.Create;
  Result := fInspectorList;
end;

{----------------------------------------------------------}

{$IFDEF D6}
function PSCAxPropEditor(A:IUnknown):TAxPropEditor;
var
  Instance:TObject;
begin
  Instance:=PSCGetIntfInstance(A);
  If Instance is TAxPropEditor then
    Result:=TAxPropEditor(Instance)
  else
    Result:=nil;
end;
{$ELSE}
function PSCAxPropEditor(A:TPropertyEditor):TAxPropEditor;
begin
  Result:=TAxPropEditor(A);
end;
{$ENDIF}

{----------------------------------------------------------}

initialization

  fBadEditorClasses := TList.Create;
  RunRegister;
  InitOlePro32;

finalization
  fBadEditorClasses.Free;
  fInspectorList.Free;

  if OlePro32DLL <> 0 then
    FreeLibrary(OlePro32DLL);

end.
