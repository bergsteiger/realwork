{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2015-2016 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Grid.iOS;

interface

{$SCOPEDENUMS ON}
{$IFDEF IOS}
{$HPPEMIT LINKUNIT}
uses
  System.TypInfo, System.UITypes, System.SysConst, System.Math, System.Messaging, System.Types, System.Classes,
  System.Rtti, System.Generics.Defaults, System.Generics.Collections, Macapi.ObjectiveC, iOSapi.CocoaTypes,
  iOSapi.Foundation, iOSapi.CoreGraphics, iOSapi.UIKit, iOSapi.CoreImage, FMX.Presentation.iOS, FMX.ScrollBox.iOS,
  Macapi.Helpers, FMX.Controls.Model, FMX.Controls.Presentation, FMX.Presentation.Messages, FMX.Controls, FMX.Graphics,
  FMX.Types, FMX.ActnList, FMX.Pickers, FMX.MediaLibrary, FMX.Grid;

type
  TiOSGrid = class;
  TColumnItem = class;
  TiOSCellControlClass = class of TiOSCellControl;

  TImageKind = (Empty, False, True);

  IiOSLineView = interface(UIView)
    ['{2DD824DE-1D0E-42A3-9F9F-B6A2A840EB0C}']
  end;

  /// <summary> This graphics object is used for drawing cell borders </summary>
  TiOSLineView = class(TOCLocal)
  strict private
    [Weak] FParentView: UIView;
    [Weak] FFromView: UIView;
    FThickness: CGFloat;
    FHorizontal: Boolean;
    FLeading: Boolean;
    FInitialized: Boolean;
  private
    FOffset: NSPoint;
    procedure SetThickness(const Value: CGFloat);
    procedure SetHorizontal(const Value: Boolean);
    procedure SetLeading(const Value: Boolean);
    function GetVisible: Boolean; inline;
    procedure SetVisible(const Value: Boolean); inline;
    function GetView: UIView; inline;
    procedure SetOffset(const Value: NSPoint);
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AHorizontal, ALeading: Boolean;
      const AFromView: UIView = nil);
    destructor Destroy; override;
    procedure Update;
    property Horizontal: Boolean read FHorizontal write SetHorizontal;
    property Leading: Boolean read FLeading write SetLeading;
    property Thickness: CGFloat read FThickness write SetThickness;
    property Visible: Boolean read GetVisible write SetVisible;
    property Offset: NSPoint read FOffset write SetOffset;
    property View: UIView read GetView;
  end;

  /// <summary> The base class of cell controls. It is used for painting and editing cells.
  /// See <see cref="FMX.Grid.iOS|TiOSGrid.GetCellClass">TiOSGrid.GetCellClass</see>,
  /// <see cref="FMX.Grid.iOS|TColumnItem.CreateInternalCell">TColumnItem.CreateInternalCell</see>
  /// </summary>
  TiOSCellControl = class(TOCLocal)
  strict private
    [Weak] FOwner: TColumnItem;
  private
    function GetColumn: TColumn; inline;
    function GetView: UIView; inline;
    function GetAbsoluteRect: TRectF;
  protected
    function GetData: TValue; virtual; abstract;
    procedure SetData(const Value: TValue); virtual; abstract;
    procedure DoUpdate; virtual; abstract;
    function GetFrame: NSRect; virtual;
    procedure Activate; virtual;
    procedure Deactivate; virtual;
  public
    constructor Create(const AOwner: TColumnItem); virtual;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Update;
    procedure EditorClick; virtual;
    property Column: TColumn read GetColumn;
    property Owner: TColumnItem read FOwner;
    property Data: TValue read GetData write SetData;
    property View: UIView read GetView;
    property AbsoluteRect: TRectF read GetAbsoluteRect;
  end;

  IiOSCellLabel = interface(UILabel)
    ['{28363B27-5F26-4731-8A1F-D190BBA47F5D}']
  end;

  /// <summary> The plain text cell. This class used by default if
  /// <see cref="FMX.Grid.iOS|TiOSGrid.GetCellClass">GetCellClass</see> returns <c>nil</c> </summary>
  TiOSCellLabel = class(TiOSCellControl)
  strict private
    FText: string;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  end;

  IiOSCellHeader = interface(UILabel)
    ['{2836337A-F1D1-4184-8B64-0E500FF65546}']
  end;

  /// <summary> The plain text header of column. This class used by default in
  /// <see cref="FMX.Grid.iOS|TFMXHeaderItem.CreateInternalCell">TFMXHeaderItem.CreateInternalCell</see></summary>
  TiOSCellHeader = class(TiOSCellControl)
  strict private
    FText: string;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  end;

  IiOSCellDefaultEditor = interface(UITextField)
    ['{28363F82-B7C8-479C-A1A0-9417B944488A}']
  end;

  /// <summary> The plain cell editor. This class used by default if
  /// <see cref="FMX.Grid.iOS|TiOSGrid.GetEditorClass">GetEditorClass</see> returns <c>nil</c> </summary>
  TiOSCellDefaultEditor = class(TiOSCellControl)
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  end;

  IiOSCurrencyLabel = interface(UILabel)
    ['{28363387-55A6-4CC7-88C3-1FD3B102F007}']
  end;

  TiOSCurrencyLabel = class(TiOSCellLabel)
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    procedure SetData(const Value: TValue); override;
  end;

  IiOSCurrencyEditor = interface(UITextField)
    ['{2836389D-CE65-446E-AD40-382199969377}']
  end;

  TiOSCurrencyEditor = class(TiOSCellDefaultEditor)
  strict private
    FValue: CGFloat;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  end;

  IiOSCellProgressBar = interface(UIView)
    ['{2DD82E1E-116D-411F-BD54-DC78612B6012}']
  end;

  TiOSCellProgressBar = class(TiOSCellControl)
  private
    FValue: CGFloat;
    FForeground: UIView;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
    function GetFrame: NSRect; override;
  public
    procedure AfterConstruction; override;
  end;

  IiOSCellDatePicker = interface(UIView)
    ['{283634C8-F120-4304-92A1-E0CEBC5DFD00}']
  end;

  TiOSCellDatePicker = class(TiOSCellControl)
  strict private
    FDateTime: TDateTime;
    FInitialized: Boolean;
    FPicker: TCustomDateTimePicker;
    procedure DoPopup(Sender: TObject);
    procedure DoClosePopup(Sender: TObject);
    procedure DoApply(Sender: TObject; const ADateTime: TDateTime);
    procedure SetDateTime(const DateTime: TDateTime);
  private
    FTextField: UITextField;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
    procedure DoUpdateField(const AField: UITextField; const ADateTime: TDateTime); virtual;
    function GetPickerShowMode: TDatePickerShowMode; virtual;
    function ValueToDateTime(const Value: TValue): TDateTime; virtual;
    procedure Activate; override;
    procedure Deactivate; override;
  public
    procedure BeforeDestruction; override;
    destructor Destroy; override;
    procedure UpdateField;
    property DateTime: TDateTime read FDateTime write SetDateTime;
  end;

  IiOSCellTimePicker = interface(UIView)
    ['{28363A6E-AFA3-4992-94EB-E2B800F97E3C}']
  end;

  TiOSCellTimePicker = class(TiOSCellDatePicker)
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    procedure DoUpdateField(const AField: UITextField; const ADateTime: TDateTime); override;
    function GetPickerShowMode: TDatePickerShowMode; override;
    function ValueToDateTime(const Value: TValue): TDateTime; override;
  end;

  IiOSCellPopupLabel = interface(UILabel)
    ['{28363849-100C-4675-8502-EB36DCA7CBF7}']
  end;

  TiOSCellPopupLabel = class(TiOSCellLabel)
  strict private
    FValue: TValue;
    FUsingIndex: Boolean;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    property UsingIndex: Boolean read FUsingIndex;
  end;

  IiOSCellPopupPicker = interface(UILabel)
    ['{283637AB-6EA6-4515-8C77-98729DBF649B}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
  end;

  TiOSCellPopupPicker = class(TiOSCellPopupLabel)
  strict private
    FPicker: TCustomListPicker;
  private
    procedure DoApply(Sender: TObject; const AValueIndex: Integer);
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    destructor Destroy; override;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure EditorClick; override;
  end;

  IiOSCellGlyph = interface(UIImageView)
    ['{2836336D-9724-4BC7-8F74-1ACCD612AF76}']
  end;

  TiOSCellGlyph = class(TiOSCellControl)
  strict private
    FImageIndex: TImageIndex;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  public
    constructor Create(const AOwner: TColumnItem); override;
  end;

  IiOSCellImage = interface(UIImageView)
    ['{28363839-4327-48EC-8E8E-A1CA4FA3CA27}']
  end;

  TiOSCellImage = class(TiOSCellControl)
  strict private
    FImage: UIImage;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function GetFrame: NSRect; override;
    procedure DoUpdate; override;
  end;

  IiOSCellImageEditor = interface(UIView)
    ['{283635BC-685C-4619-B6B9-2C0F355CB48D}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
  end;

  TiOSCellImageEditor = class(TiOSCellControl)
  private
    FBitmap: TBitmap;
    FBitmapLoaded: Boolean;
    FImageControl: TiOSCellImage;
    FTakenImageService: IFMXTakenImageService;
    procedure DidReceiveBitmap(const Sender: TObject; const M: TMessage);
  protected
    procedure DoApply(AImage: TBitmap); virtual;
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  public
    constructor Create(const AOwner: TColumnItem); override;
    destructor Destroy; override;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure EditorClick; override;
  end;

  IiOSCellCheck = interface(UIImageView)
    ['{2836383A-0872-4626-ABC1-4734E7CEB3A0}']
  end;

  TiOSCellCheck = class(TiOSCellControl)
  strict private
    FValue: TImageKind;
    FInitialized: Boolean;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
    function GetFrame: NSRect; override;
  end;

  IiOSCellCheckEditor = interface(UIView)
    ['{283634F2-8791-49EB-9EEA-2C3E5B41366C}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
  end;

  TiOSCellCheckEditor = class(TiOSCellControl)
  private
    FCheckControl: TiOSCellCheck;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    procedure DoUpdate; override;
  public
    constructor Create(const AOwner: TColumnItem); override;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure EditorClick; override;
  end;

  IFMXColumnItem = interface(UIView)
    ['{283638CF-3A80-4238-A5C1-311CFB381D79}']
  end;

  TColumnItem = class(TOCLocal)
  private type
    TColumnLink = class(TInterfacedObject, IFreeNotification, ICellControl)
    private
      [Weak] FColumn: TColumn;
      FChanged: Boolean;
      FClassChanged: Boolean;
      procedure FreeNotification(AObject: TObject);
      function GetColumn: TColumn;
      procedure SetColumn(const Value: TColumn);
    public
      destructor Destroy; override;
      property Column: TColumn read FColumn write SetColumn;
      property Changed: Boolean read FChanged write FChanged;
      property ClassChanged: Boolean read FClassChanged write FClassChanged;
    end;
  strict private
    [Weak] FiOSGrid: TiOSGrid;
    [Weak] FModel: TGridModel;
    FColumnLink: TColumnLink;
    FInternalCell: TiOSCellControl;
  private
    FDefaultThickness: CGFloat;
    FFrame: NSRect;
    FHiddenFound: Boolean;
    FSizeChanged: Boolean;
    FPosChanged: Boolean;
    FColLines: Boolean;
    procedure SetFrame(const Value: NSRect); inline;
    procedure SetHiddenFound(const Value: Boolean);
    procedure SetColLines(const Value: Boolean);
    function GetColumn: TColumn; inline;
    procedure SetColumn(const Value: TColumn); inline;
    function GetView: UIView; inline;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    function CreateInternalCell: TiOSCellControl; virtual; abstract;
    procedure DoUpdate; virtual; abstract;
  public
    constructor Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn); virtual;
    destructor Destroy; override;
    procedure Update;
    function ClientRect: NSRect;
    property iOSGrid: TiOSGrid read FiOSGrid;
    property Model: TGridModel read FModel;
    property Column: TColumn read GetColumn write SetColumn;
    property View: UIView read GetView;
    property InternalCell: TiOSCellControl read FInternalCell;

    property Frame: NSRect read FFrame write SetFrame;
    property ColLines: Boolean read FColLines write SetColLines;
    property HiddenFound: Boolean read FHiddenFound write SetHiddenFound;
  end;

  TBaseColumnItemList = class(TList<TColumnItem>);

  TColumnItemList = class(TBaseColumnItemList)
  private type
    TComparer = class(TInterfacedObject, IComparer<TColumnItem>)
    public
      function Compare(const Left, Right: TColumnItem): Integer;
    end;
  private
    class var FComparer: TComparer;
  public
    constructor Create; reintroduce;
    function Find(const Column: TColumn): Integer;
    function TryGetValue(const Column: TColumn; var Item: TColumnItem): Boolean;
    procedure Assign(const Source: TColumnItemList; const Top, Height: CGFloat);
    function RemoveUselessItems(const ExceptTiny: Boolean = True): Boolean;
  end;

  TFMXHeaderItem = class(TColumnItem)
  strict private
    FFirstBorder: TiOSLineView;
    FLeftBorder: TiOSLineView;
    FRightBorder: TiOSLineView;
    FLeftColumnLine: TiOSLineView;
    FRightColumnLine: TiOSLineView;
  private
    FFirst: Boolean;
    procedure UpdateVerticalBorders;
    procedure SetFirst(const Value: Boolean);
  protected
    function CreateInternalCell: TiOSCellControl; override;
    procedure DoUpdate; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn); override;
    destructor Destroy; override;
    property First: Boolean read FFirst write SetFirst;
  end;

  IiOSHeader = interface(UIView)
    ['{2DD8288D-F976-4FE2-89B2-F7C469EAC5BF}']
  end;

  TiOSHeader = class(TOCLocal)
  strict private
    [Weak] FiOSGrid: TiOSGrid;
    [Weak] FModel: TGridModel;
    FHeaderItems: TColumnItemList;
  private
    FLineHeader: TiOSLineView;
    FWidth: CGFloat;
    FHeight: CGFloat;
    function GetView: UIView; inline;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid); virtual;
    destructor Destroy; override;
    /// <summary> The updating of all column headers and coordinates also updating positions of vertical lines</summary>
    /// <remarks> See also <b>HeaderItems</b></remarks>
    procedure Update; virtual;
    property iOSGrid: TiOSGrid read FiOSGrid;
    property Model: TGridModel read FModel;
    /// <summary> The list contains instances of <b>TFMXHeaderItem</b>. This list sorted by the column indexes
    /// </summary>
    property HeaderItems: TColumnItemList read FHeaderItems;
    property Width: CGFloat read FWidth;
    property Height: CGFloat read FHeight;
    property View: UIView read GetView;
  end;

  IiOSInplaceEditor = interface(UIView)
    ['{2DD823A5-A4FA-490E-A4EA-76DEE3C2F0D3}']
  end;

  TiOSInplaceEditor = class(TColumnItem)
  public const
    BorderWidth = 1;
  private
    FBackground: UIView;
    FInitialized: Boolean;
    FActive: Boolean;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    procedure DoUpdate; override;
    function CreateInternalCell: TiOSCellControl; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn); override;
    destructor Destroy; override;
    procedure Activate;
    procedure Deactivate;
    procedure EditorClick;
  end;

  IiOSCell = interface(IFMXColumnItem)
    ['{28363863-9876-470C-A415-E4DABD9D1DED}']
  end;

  TiOSCell = class(TColumnItem)
  private
    FRow: Integer;
    procedure SetRow(const Value: Integer);
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    procedure DoUpdate; override;
    procedure DoUpdateValue(const ACell: TiOSCellControl); virtual;
    function CreateInternalCell: TiOSCellControl; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn); override;
    procedure UpdateValue;
    property Row: Integer read FRow write SetRow;
  end;

  IUITableViewRow = interface(UIView)
    ['{6DB65D8D-E8B3-4953-8A4F-DA7BFB87BAD8}']
  end;

  TUITableViewRow = class(TOCLocal)
  private
    [Weak] FiOSGrid: TiOSGrid;
    [Weak] FModel: TGridModel;
    FLineDown: TiOSLineView;
    FCells: TColumnItemList;
    function GetIndex: Integer; inline;
    procedure InitView;
    function GetView: UIView; inline;
    function GetCells(const Index: Integer): TiOSCell;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    procedure PrepareForReuse;
  public
    constructor Create(const AiOSGrid: TiOSGrid);
    destructor Destroy; override;
    procedure Update;
    property Index: Integer read GetIndex;
    property Cells[const Index: Integer]: TiOSCell read GetCells;
    property iOSGrid: TiOSGrid read FiOSGrid;
    property Model: TGridModel read FModel;
    property View: UIView read GetView;
  end;

  IiOSTable = interface(UIScrollView)
    ['{0403CF5C-1E87-4F57-ACCA-969E36310372}']
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
  end;

  TiOSTable = class(TOCLocal)
  strict private
    FLeftLine: TiOSLineView;
    FTopLine: TiOSLineView;
    [Weak] FiOSGrid: TiOSGrid;
    [Weak] FModel: TGridModel;
    FVKOffset: CGFloat;
    FTableOffset: CGFloat;
    FDisappearedRows: TStack<TUITableViewRow>;
    FRows: TDictionary<Integer, TUITableViewRow>;
    FRowHeight: CGFloat;
    FRowCount: Integer;
  private type
    TRowComparer = class(TInterfacedObject, IComparer<TUITableViewRow>)
    public
      function Compare(const Left, Right: TUITableViewRow): Integer;
    end;
  private
    class var FComparer: TRowComparer;
    function GetView: UIScrollView; inline;
    function GetTouchCoord(const touches: NSSet; var x, y: single): Boolean;
    procedure SetVKOffset(const Value: CGFloat);
    procedure UpdateFrame;
    function GetRows(const Index: Integer): TUITableViewRow;
    procedure RowsAppeared(const MinRow, MaxRow: Integer);
    procedure RowsDisappeared(const MinRow, MaxRow: Integer);
  protected
    function GetObjectiveCClass: PTypeInfo; override;
    property VKOffset: CGFloat read FVKOffset write SetVKOffset;
  public
    constructor Create(const AiOSGrid: TiOSGrid); virtual;
    destructor Destroy; override;
    procedure Update; virtual;
    property iOSGrid: TiOSGrid read FiOSGrid;
    property Model: TGridModel read FModel;
    property View: UIScrollView read GetView;

    property Rows[const Index: Integer]: TUITableViewRow read GetRows;
    procedure DidScroll(const ScrollView: UIScrollView); virtual;
    procedure UpdateVisibleRows;

    property RowHeight: CGFloat read FRowHeight;
    property RowCount: Integer read FRowCount;
    procedure ScrollToSelectedCell(const Animated: Boolean = True);
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
  end;

  TiOSGrid = class(TiOSScrollBox)
  public type
    TEditorResult = (Success, Error, Cancel);
    TContentState = (Changed, Updating, Updated);
  strict private
    FDefaultThickness: CGFloat;
    FDefaultRowHeight: CGFloat;
    FiOSHeader: TiOSHeader;
    FiOSTable: TiOSTable;
    FiOSTableDelegate: TOCLocal;
    FiOSQueue: TOCLocal;
    FImages: array [TImageKind] of UIImage;
    FVirtualKeayboardOffset: CGFloat;
  private
    FiOSEditDelegate: TOCLocal;
    FInplaceEditor: TiOSInplaceEditor;
    FContentState: TContentState;
    FTintColor: UIColor;
    FOddColor: UIColor;
    FBkColor: UIColor;
    FHighlightColor: UIColor;
    FFocusColor: UIColor;
    FOldCoord: TGridModel.TCoord;
    FEditorMode: Boolean;
    FEditorResult: TEditorResult;
    FImagesCreated: Boolean;
    FVKOffsetChanging: Boolean;
    function GetModel: TGridModel;
    procedure MMInvalidateCell(var Message: TDispatchMessageWithValue<TGridModel.TCoord>); message MM_INVALIDATE_CELL;
    procedure MMInvalidateContentSize(var Message: TDispatchMessage); message MM_INVALIDATE_CONTENT_SIZE;
    procedure MMContentChanged(var Message: TDispatchMessage); message MM_CONTENT_CHANGED;
    procedure MMColumnChanged(var Message: TDispatchMessageWithValue<Integer>); message MM_COLUMN_CHANGED;
    procedure MMSelChanged(var Message: TDispatchMessage); message MM_SEL_CHANGED;
    procedure PMScrollToSelect(var Message: TDispatchMessage); message PM_SCROLL_TO_SELECT;
    procedure MMEditorMode(var Message: TDispatchMessageWithValue<Boolean>); message MM_EDITOR_MODE;
    procedure MMShowEditor(var Message: TDispatchMessage); message MM_SHOW_EDITOR;
    procedure MMHideEditor(var Message: TDispatchMessageWithValue<Boolean>); message MM_HIDE_EDITOR;
    procedure PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>); message PM_SET_SIZE;
    procedure PMVKDisplacement(var Message: TDispatchMessageWithValue<TGridModel.TVKInfo>); message PM_VKDISPLACEMENT;

    function GetRowThickness: CGFloat;
    function GetColumnThickness: CGFloat;

    function EditingDone(const Accept: Boolean): Boolean;
    function RefreshEditor(const RefreshAppearance, RefreshValue: Boolean): Boolean;
    function GetImages(const Index: TImageKind): UIImage;
    procedure CreateImages;
    procedure FreeImages;
    procedure SetVirtualKeayboardOffset(const Value: CGFloat);
  protected
    function DefineModelClass: TDataModelClass; override;

    procedure UpdateContent;
    procedure UpdateSelection;
    /// <summary> Define the class of cell by the column</summary>
    /// <returns> If <c>nil</c> then the default class will be used </returns>
    function GetCellClass(const Column: TColumn): TiOSCellControlClass; virtual;
    /// <summary> Define the class of cell editor by the column. The editor is created in the method <b>ShowEditor</b>.
    /// This method is called after <b>DoCreateCustomEditor</b> in case it return <c>nil</c> (by default) </summary>
    function GetEditorClass(const Column: TColumn): TiOSCellControlClass; virtual;

    /// <summary> Creates the header of table. You can override this method in case you want to use your class of header
    /// </summary>
    function CreateHeader: TiOSHeader; virtual;
    /// <summary> Creates the main part of table. You can override this method in case you want to use your class of
    /// table </summary>
    function CreateTable: TiOSTable;
    function CanEdit: Boolean; virtual;
    function GetEditorRect: NSRect; virtual;
    procedure InplaceEditorActivate; virtual;
    procedure EditorReturnDown; virtual;
    procedure TableScrolled(const ViewPortPosition: CGPoint); virtual;

    property iOSQueue: TOCLocal read FiOSQueue;
    function PerformSelector(const Name: string; const Delay: CGFloat = 0): Boolean;
    property VirtualKeayboardOffset: CGFloat read FVirtualKeayboardOffset write SetVirtualKeayboardOffset;
  public
    constructor Create(const AModel: TDataModel; const AControl: TControl); overload; override;
    destructor Destroy; override;
    /// <summary> Returns the data model which was cast to the type</summary>
    property Model: TGridModel read GetModel;

    function CellRect(const ACol, ARow: Integer): NSRect;
    function PaddingRect(const ARect: NSRect; const Column: TColumn): NSRect;

    property DefaultThickness: CGFloat read FDefaultThickness;
    property DefaultRowHeight: CGFloat read FDefaultRowHeight;
    property RowThickness: CGFloat read GetRowThickness;
    property ColumnThickness: CGFloat read GetColumnThickness;

    property iOSHeader: TiOSHeader read FiOSHeader;
    property iOSTable: TiOSTable read FiOSTable;
    property EditorMode: Boolean read FEditorMode;
    procedure ShowEditor;
    property EditorResult: TEditorResult read FEditorResult;
    /// <summary> Close cell editor and set <see cref="FMX.Grid.iOS|TiOSGrid.EditorMode">EditorMode</see> to
    /// <c>False</c>. </summary>
    /// <param name="Accept"> If <c>True</c>, the value from cell editor will be used in
    /// <see cref="FMX.Grid|TCustomGrid">Grid</see>, otherwise the old value will remain in grid </param>
    procedure HideEditor(const Accept: Boolean);
    property Images[const Index: TImageKind]: UIImage read GetImages;
  end;

implementation

uses
  System.SysUtils, System.RTLConsts, System.Math.Vectors, Macapi.ObjCRuntime, FMX.Helpers.iOS,
  FMX.Consts, FMX.Forms, FMX.Presentation.Factory, FMX.Utils, FMX.Platform, FMX.MediaLibrary.Actions, FMX.ImgList;

{$REGION 'Utilites'}

function UpdateViewText(const View: UIView; const Model: TGridModel; const Column: TColumn): Boolean;
var
  LLabel: UILabel;
  LTextView: UITextView;
  LTextField: UITextField;
  Alignment: UITextAlignment;
begin
  Result := False;
  if (Column <> nil) and (Model <> nil) then
  begin
    Alignment := -1;
    if Column is TCurrencyColumn then
      Alignment := UITextAlignmentRight
    else if TStyledSetting.Other in Model.StyledSettings then
      Alignment := UITextAlignmentLeft
    else
      case Model.TextSettings.HorzAlign of
        TTextAlign.Center:
          Alignment := UITextAlignmentCenter;
        TTextAlign.Leading:
          Alignment := UITextAlignmentLeft;
        TTextAlign.Trailing:
          Alignment := UITextAlignmentRight;
      end;
    if Alignment >= 0 then
    begin
      if Supports(View, UILabel, LLabel) then
      begin
        LLabel.setTextAlignment(Alignment);
        Result := True;
      end
      else if Supports(View, UITextView, LTextView) then
      begin
        LTextView.setTextAlignment(Alignment);
        Result := True;
      end
      else if Supports(View, UITextField, LTextField) then
      begin
        LTextField.setTextAlignment(Alignment);
        Result := True;
      end;
    end;
  end;
end;

procedure SelectAll(Field: UITextField);
var
  I1, I2: UITextPosition;
  Range: UITextRange;
begin
  Field.setSelected(True);
  Field.becomeFirstResponder;
  I1 := Field.beginningOfDocument;
  I2 := Field.endOfDocument;
  Range := Field.textRangeFromPosition(I1, I2);
  Field.setSelectedTextRange(Range);
end;

function ValueToFloat(const Value: TValue): CGFloat;
var
  S: string;
begin
  Result := NAN;
  if not Value.IsEmpty and not Value.IsObject then
  begin
    if Value.IsOrdinal then
      Result := Value.AsOrdinal
    else if not Value.TryAsType<CGFloat>(Result) and Value.TryAsType<string>(S) then
    begin
      S := Trim(S);
      S := S.Replace('.', FormatSettings.DecimalSeparator);
      S := S.Replace(',', FormatSettings.DecimalSeparator);
      if not TryStrToFloat(S, Result) then
        Result := NAN;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'Hidden types'}
type
  UITextFieldDelegate = interface(IObjectiveC)
    ['{B76C7D96-EFBB-482C-9E5C-0C8D083052FC}']
    function textFieldShouldReturn(textField: UITextField): Boolean; cdecl;
    function textField(textField: UITextField; shouldChangeCharactersInRange: NSRange; replacementString: NSString): Boolean; cdecl;
  end;

  TiOSEditDelegate = class(TOCLocal, UITextFieldDelegate)
  strict private
    [Weak] FiOSGrid: TiOSGrid;
  public
    constructor Create(const AiOSGrid: TiOSGrid);
    property iOSGrid: TiOSGrid read FiOSGrid;
    function textFieldShouldReturn(textField: UITextField): Boolean; cdecl;
    function textField(textField: UITextField; shouldChangeCharactersInRange: NSRange; replacementString: NSString): Boolean; cdecl;
  end;

  IiOSQueue = interface(NSObject)
    ['{D5FBE51E-0E69-4219-B035-1497B6008644}']
    procedure EditorReturnDown; cdecl;
    procedure InplaceEditorActivate; cdecl;
    procedure UpdateContent; cdecl;
    procedure EditorClick; cdecl;
    procedure VKOffsetChanged; cdecl;
  end;

  TiOSQueue = class(TOCLocal)
  strict private
    [Weak] FiOSGrid: TiOSGrid;
  protected
    function GetObjectiveCClass: PTypeInfo; override;
  public
    constructor Create(const AiOSGrid: TiOSGrid);
    property iOSGrid: TiOSGrid read FiOSGrid;
    procedure EditorReturnDown; cdecl;
    procedure InplaceEditorActivate; cdecl;
    procedure UpdateContent; cdecl;
    procedure EditorClick; cdecl;
    procedure VKOffsetChanged; cdecl;
  end;
{$ENDREGION}

{$REGION 'TFMXLineView'}

constructor TiOSLineView.Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AHorizontal, ALeading: Boolean;
  const AFromView: UIView = nil);
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) or (AParent = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FThickness := AiOSGrid.DefaultThickness;
  FParentView := AParent;
  FHorizontal := AHorizontal;
  FLeading := ALeading;
  FFromView := AFromView;
  Update;
  View.setBackgroundColor(TUIColor.Wrap(TUIColor.OCClass.underPageBackgroundColor));
  FParentView.addSubview(View);
end;

destructor TiOSLineView.Destroy;
begin
  View.removeFromSuperview;
  inherited;
end;

procedure TiOSLineView.Update;
var
  R: NSRect;
  V: Pointer;
  Size: NSSize;
  ScrollView: UIScrollView;
begin
  if FFromView <> nil then
    R := FFromView.Frame
  else
    R := FParentView.Frame;
  if Supports(FParentView, UIScrollView, ScrollView) then
  begin
    Size := ScrollView.contentSize;
    if Horizontal then
      R.Size.Width := Size.Width + FThickness
    else
      R.Size.Height := Size.Height;
  end;
  if Horizontal then
  begin
    R.origin.x := Offset.x;
    R.Size.Width := R.Size.Width - Offset.x;
    if Leading then
    begin
      R.origin.y := Offset.y;
      R.Size.Height := FThickness;
    end
    else
    begin
      R.origin.y := Offset.y + R.Size.Height - FThickness;
      R.Size.Height := FThickness;
    end;
  end
  else
  begin
    R.origin.y := Offset.y;
    R.Size.Height := R.Size.Height - Offset.y;
    if Leading then
    begin
      R.origin.x := Offset.x;
      R.Size.Width := FThickness;
    end
    else
    begin
      R.origin.x := Offset.x + R.Size.Width - FThickness;
      R.Size.Width := FThickness;
    end;
  end;

  if FFromView <> nil then
    R := TUIView.Wrap(FFromView.superview).convertRect(R, FFromView);

  if FInitialized then
    View.SetFrame(R)
  else
  begin
    FInitialized := True;
    V := View.initWithFrame(R);
    if GetObjectID <> V then
      UpdateObjectID(V);
  end;
end;

function TiOSLineView.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSLineView);
end;

procedure TiOSLineView.SetHorizontal(const Value: Boolean);
begin
  if FHorizontal <> Value then
  begin
    FHorizontal := Value;
    Update;
  end;
end;

procedure TiOSLineView.SetLeading(const Value: Boolean);
begin
  if FLeading <> Value then
  begin
    FLeading := Value;
    Update;
  end;
end;

procedure TiOSLineView.SetOffset(const Value: NSPoint);
begin
  if not SameValue(FOffset.x, Value.x, TEpsilon.FontSize) or not SameValue(FOffset.y, Value.y, TEpsilon.FontSize) then
  begin
    FOffset := Value;
    Update;
  end;
end;

procedure TiOSLineView.SetThickness(const Value: CGFloat);
begin
  if not SameValue(FThickness, Value, TEpsilon.FontSize) then
  begin
    FThickness := Value;
    Update;
  end;
end;

function TiOSLineView.GetView: UIView;
begin
  Result := UIView(Super);
end;

function TiOSLineView.GetVisible: Boolean;
begin
  Result := not View.isHidden;
end;

procedure TiOSLineView.SetVisible(const Value: Boolean);
begin
  View.setHidden(not Value);
end;

{$ENDREGION}
{$REGION 'TiOSCellControl'}

constructor TiOSCellControl.Create(const AOwner: TColumnItem);
var
  V: Pointer;
begin
  if AOwner = nil then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FOwner := AOwner;
  V := View.init;
  if GetObjectID <> V then
    UpdateObjectID(V);
  View.SetTag(NSInteger(FOwner));
end;

procedure TiOSCellControl.AfterConstruction;
begin
  inherited;
  Owner.View.addSubview(View);
end;

destructor TiOSCellControl.Destroy;
var
  TextField: UITextField;
begin
  View.SetTag(0);
  if Supports(View, UITextField, TextField) then
    TextField.setDelegate(nil);
  View.removeFromSuperview;
  inherited;
end;

procedure TiOSCellControl.Activate;
var
  TextField: UITextField;
begin
  if Supports(View, UITextField, TextField) then
    SelectAll(TextField);
end;

procedure TiOSCellControl.Deactivate;
begin

end;

procedure TiOSCellControl.EditorClick;
begin

end;

function TiOSCellControl.GetView: UIView;
begin
  Result := UIView(Super);
end;

function TiOSCellControl.GetAbsoluteRect: TRectF;
begin
  Result := Owner.iOSGrid.View.convertRect(Owner.View.Bounds, Owner.View).ToRectF;
  Result.Location := Owner.iOSGrid.Control.LocalToAbsolute(Result.TopLeft);
end;

function TiOSCellControl.GetColumn: TColumn;
begin
  Result := FOwner.Column;
end;

function TiOSCellControl.GetFrame: NSRect;
begin
  Result := Owner.ClientRect;
end;

procedure TiOSCellControl.Update;
var
  R: NSRect;
begin
  R := GetFrame;
  if (R.Size.Width <= 1) or (R.Size.Height <= 1) then
    View.setHidden(True)
  else
  begin
    View.SetFrame(R);
    DoUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TiOSCellLabel'}

function TiOSCellLabel.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellLabel);
end;

procedure TiOSCellLabel.DoUpdate;
begin
  UpdateViewText(View, Owner.iOSGrid.Model, Column);
  View.setHidden(False);
end;

function TiOSCellLabel.GetData: TValue;
begin
  Result := FText;
end;

procedure TiOSCellLabel.SetData(const Value: TValue);
var
  NewText: string;
begin
  if Column <> nil then
    NewText := Column.ValueToString(Value)
  else
    NewText := string.Empty;
  NewText := NewText;
  if FText <> NewText then
  begin
    FText := NewText;
    if FText.IsEmpty then
      UILabel(View).setText(nil)
    else
      UILabel(View).setText(StrToNSStr(FText));
  end;
end;

{$ENDREGION}
{$REGION 'TiOSCellHeader'}

function TiOSCellHeader.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellHeader);
end;

procedure TiOSCellHeader.DoUpdate;
var
  LLabel: UILabel;
  NewText: string;
begin
  if Supports(View, UILabel, LLabel) then
  begin
    LLabel.setTextAlignment(UITextAlignmentCenter);
    if Column <> nil then
      NewText := Column.Header
    else
      NewText := string.Empty;
    if FText <> NewText then
    begin
      FText := NewText;
      if FText.IsEmpty then
        LLabel.setText(nil)
      else
        LLabel.setText(StrToNSStr(FText));
    end;
    View.setHidden(False);
  end
  else
    View.setHidden(True);
end;

function TiOSCellHeader.GetData: TValue;
begin
  Result := TValue.Empty;
end;

procedure TiOSCellHeader.SetData(const Value: TValue);
begin
  // none
end;

{$ENDREGION}
{$REGION 'TiOSCellDefaultEditor'}

function TiOSCellDefaultEditor.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellDefaultEditor);
end;

procedure TiOSCellDefaultEditor.DoUpdate;
begin
  UpdateViewText(View, Owner.iOSGrid.Model, Column);
  View.setHidden(False);
end;

function TiOSCellDefaultEditor.GetData: TValue;
begin
  Result := NSStrToStr(TNSString.Wrap(UITextField(View).text));
end;

procedure TiOSCellDefaultEditor.SetData(const Value: TValue);
var
  LText: string;
begin
  if Column <> nil then
    LText := Column.ValueToString(Value)
  else
    LText := string.Empty;
  if LText.IsEmpty then
    UITextField(View).setText(nil)
  else
    UITextField(View).setText(StrToNSStr(LText));
end;

{$ENDREGION}
{$REGION 'TiOSCurrencyLabel'}

function TiOSCurrencyLabel.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCurrencyLabel);
end;

procedure TiOSCurrencyLabel.SetData(const Value: TValue);
begin
  if Value.IsEmpty then
    inherited SetData(TValue.Empty)
  else if Column is TCurrencyColumn then
    inherited SetData(TCurrencyColumn(Column).ValueToString(ValueToFloat(Value)))
  else
    inherited SetData(Value);
end;
{$ENDREGION}
{$REGION 'TiOSCurrencyEditor'}

function TiOSCurrencyEditor.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCurrencyEditor);
end;

procedure TiOSCurrencyEditor.DoUpdate;
begin
  inherited;
  UITextField(View).setEnablesReturnKeyAutomatically(False);
  UITextField(View).setKeyboardType(UIKeyboardTypeNumberPad);
end;

function TiOSCurrencyEditor.GetData: TValue;
var
  LValue: CGFloat;
  S: string;
begin
  S := Trim(UpperCase(NSStrToStr(TNSString.Wrap(UITextField(View).text))));
  if S.IsEmpty or (S = UpperCase(FloatToStr(NAN))) then
    Result := TValue.Empty
  else
  begin
    LValue := ValueToFloat(S);
    if LValue.IsNan then
      raise EConvertError.CreateFmt(SInvalidFloat, [S]);
    Result := LValue;
  end;
end;

procedure TiOSCurrencyEditor.SetData(const Value: TValue);
var
  LText: string;
begin
  FValue := ValueToFloat(Value);
  if (Column <> nil) and not IsNan(FValue) then
    LText := Column.ValueToString(FValue)
  else
    LText := string.Empty;
  if LText.IsEmpty then
    UITextField(View).setText(nil)
  else
    UITextField(View).setText(StrToNSStr(LText));
end;

{$ENDREGION}
{$REGION 'TiOSCellProgressBar'}

function TiOSCellProgressBar.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellProgressBar);
end;

procedure TiOSCellProgressBar.AfterConstruction;
var
  LColor: UIColor;
begin
  inherited;
  LColor := TUIColor.Wrap(TUIColor.OCClass.underPageBackgroundColor);
  LColor := LColor.colorWithAlphaComponent(0.5);
  View.setBackgroundColor(LColor);
  FForeground := TUIView.Wrap(TUIView.Alloc.initWithFrame(View.bounds));
  FForeground.setBackgroundColor(Owner.iOSGrid.FTintColor);
  View.addSubview(FForeground);
end;

procedure TiOSCellProgressBar.DoUpdate;
var
  R: NSRect;
  ClampValue: CGFloat;
  LColumn: TProgressColumn;
begin
  inherited;
  if IsNan(FValue) or not (Column is TProgressColumn) then
    View.setHidden(True)
  else
  begin
    LColumn := TProgressColumn(Column);
    if LColumn.Max > LColumn.Min then
    begin
      ClampValue := EnsureRange(FValue, LColumn.Min, LColumn.Max);
      R := View.bounds;
      R.Size.Width := ((ClampValue - LColumn.Min) / (LColumn.Max - LColumn.Min)) * R.Size.Width;
      FForeground.SetFrame(R);
      View.setHidden(False)
    end
    else
      View.setHidden(True);
  end;
end;

function TiOSCellProgressBar.GetFrame: NSRect;
var
  H: CGFloat;
begin
  Result := inherited GetFrame;
  H := Max(TColumn.VertTextMargin, Result.Size.Height / 2);
  Result.origin.y := Result.origin.y + (Result.Size.Height - H) / 2;
  Result.Size.Height := H;
end;

function TiOSCellProgressBar.GetData: TValue;
begin
  if IsNan(FValue) then
    Result := TValue.Empty
  else
    Result := FValue;
end;

procedure TiOSCellProgressBar.SetData(const Value: TValue);
var
  LValue: CGFloat;
begin
  LValue := ValueToFloat(Value);
  if (IsNan(LValue) <> IsNan(FValue)) or (FValue <> LValue) then
  begin
    FValue := LValue;
    Update;
  end;
end;
{$ENDREGION}
{$REGION 'TiOSCellDatePicker'}

destructor TiOSCellDatePicker.Destroy;
begin
  FPicker.Free;
  FTextField := nil;
  inherited;
end;

function TiOSCellDatePicker.GetData: TValue;
var
  S, ErrorMessage: string;
  LDateTime: TDateTime;
begin
  S := Trim(NSStrToStr(TNSString.Wrap(FTextField.text)));
  if S.IsEmpty then
    Result := TValue.Empty
  else
  begin
    LDateTime := ValueToDateTime(S);
    if not IsNan(LDateTime) then
    begin
      DateTime := LDateTime;
      case GetPickerShowMode of
        TDatePickerShowMode.Date:
          Result := TValue.From<TDate>(Trunc(LDateTime));
        TDatePickerShowMode.Time:
          Result := TValue.From<TTime>(Frac(LDateTime));
        TDatePickerShowMode.DateTime:
          Result := TValue.From<TDateTime>(LDateTime);
      end;
      Result := TValue.From<TDate>(LDateTime);
    end
    else
    begin
      case GetPickerShowMode of
        TDatePickerShowMode.Date:
          ErrorMessage := System.SysConst.SInvalidDate;
        TDatePickerShowMode.Time:
          ErrorMessage := System.SysConst.SInvalidTime;
        TDatePickerShowMode.DateTime:
          ErrorMessage := System.SysConst.SInvalidDateTime
      end;
      raise EConvertError.CreateFmt(ErrorMessage, [S]);
    end;
  end;
end;

procedure TiOSCellDatePicker.SetData(const Value: TValue);
var
  LDate: TDateTime;
begin
  LDate := ValueToDateTime(Value);
  if not FInitialized or (IsNan(LDate) <> IsNan(FDateTime)) or (FDateTime <> LDate) then
  begin
    SetDateTime(LDate);
    Update;
  end;
end;

function TiOSCellDatePicker.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellDatePicker);
end;

function TiOSCellDatePicker.ValueToDateTime(const Value: TValue): TDateTime;
var
  S: string;
  CustomFormatSettings: TFormatSettings;
begin
  Result := NAN;
  if not Value.IsEmpty and not Value.IsObject then
  begin
    if Value.IsOrdinal then
      Result := Value.AsOrdinal
    else if not Value.TryAsType<TDateTime>(Result) and Value.TryAsType<string>(S) then
    begin
      if not (Column is TDateColumn) or TDateColumn(Column).Format.IsEmpty then
      begin
        if not TryStrToDate(S, Result) then
          Result := NAN;
      end
      else
      begin
        CustomFormatSettings := FormatSettings;
        CustomFormatSettings.ShortDateFormat := TDateColumn(Column).Format;
        CustomFormatSettings.LongDateFormat := TDateColumn(Column).Format;
        if not TryStrToDate(S, Result, CustomFormatSettings) then
          Result := NAN;
      end;
    end;
  end;
end;

procedure TiOSCellDatePicker.BeforeDestruction;
begin
  if FPicker <> nil then
    FPicker.Hide;
  inherited;
end;

procedure TiOSCellDatePicker.Activate;
var
  PickerService: IFMXPickerService;
begin
  FreeAndNil(FPicker);
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
  begin
    ValidateInheritance(Owner.Model.Owner, TControl, False);
    FPicker := PickerService.CreateDateTimePicker;
    FPicker.ShowMode := GetPickerShowMode;
    FPicker.Parent := TControl(Owner.Model.Owner);
    FPicker.AbsoluteTargetRect := AbsoluteRect;
    FPicker.OnHide := DoClosePopup;
    FPicker.OnShow := DoPopup;
    FPicker.OnDateChanged := DoApply;
  end
  else
    raise EUnsupportedPlatformService.CreateFmt(SUnsupportedPlatformService, ['IFMXPickerService']);
  if IsNan(FDateTime) then
    FPicker.Date := Now
  else
    FPicker.Date := FDateTime;
  FPicker.Show;
end;

procedure TiOSCellDatePicker.Deactivate;
begin
  if FTextField <> nil then
    FTextField.resignFirstResponder;
  if FPicker <> nil then
  begin
    FPicker.Hide;
    FreeAndNil(FPicker);
  end;
end;

procedure TiOSCellDatePicker.DoApply(Sender: TObject; const ADateTime: TDateTime);
begin
  SetDateTime(ADateTime);
  Column.EditorModified;
  Owner.iOSGrid.EditorReturnDown;
end;

procedure TiOSCellDatePicker.DoClosePopup(Sender: TObject);
begin
  if FTextField <> nil then
  begin
    SelectAll(FTextField);
  end;
end;

procedure TiOSCellDatePicker.DoPopup(Sender: TObject);
begin
  Owner.iOSGrid.iOSTable.View.scrollRectToVisible(Owner.View.Frame, False);
end;

procedure TiOSCellDatePicker.DoUpdateField(const AField: UITextField; const ADateTime: TDateTime);
begin
  if IsNan(ADateTime) then
    AField.setText(nil)
  else
  begin
    if Column is TDateColumn then
      AField.setText(StrToNSStr(TDateColumn(Column).ValueToString(ADateTime)))
    else
      AField.setText(StrToNSStr(DateToStr(ADateTime)));
  end;
end;

procedure TiOSCellDatePicker.UpdateField;
begin
  if FTextField <> nil then
    DoUpdateField(FTextField, FDateTime);
end;

function TiOSCellDatePicker.GetPickerShowMode: TDatePickerShowMode;
begin
  Result := TDatePickerShowMode.Date;
end;

procedure TiOSCellDatePicker.DoUpdate;
begin
  View.setHidden(False);
  if FInitialized then
  begin
    if FTextField = nil then
    begin
      FTextField := TUITextField.Wrap(TUITextField.Alloc.initWithFrame(View.bounds));
      if (Column is TDateColumn) and TDateColumn(Column).ShowClearButton then
        FTextField.setClearButtonMode(UITextFieldViewModeWhileEditing)
      else
        FTextField.setClearButtonMode(UITextFieldViewModeNever);
      FTextField.setEnablesReturnKeyAutomatically(False);
      FTextField.setKeyboardType(UIKeyboardTypeNumberPad);
      FTextField.setDelegate(TiOSEditDelegate(Owner.iOSGrid.FiOSEditDelegate).GetObjectID);
      View.addSubview(FTextField);
      UpdateViewText(FTextField, Owner.Model, Owner.Column);
    end;
    UpdateField;
  end;
end;

procedure TiOSCellDatePicker.SetDateTime(const DateTime: TDateTime);
begin
  FDateTime := DateTime;
  FInitialized := True;
  UpdateField;
end;

{$ENDREGION}
{$REGION 'TiOSCellGlyph'}

constructor TiOSCellGlyph.Create(const AOwner: TColumnItem);
begin
  inherited;
  FImageIndex := -1;
end;

function TiOSCellGlyph.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellGlyph);
end;

procedure TiOSCellGlyph.DoUpdate;
var
  LBitmap: TBitmap;
  ImgRect: TRectF;
  bounds: NSRect;
  Scale: CGFloat;
  Size: TSizeF;
  Images: TCustomImageList;
  LImage: UIImage;
begin
  LImage := nil;
  LBitmap := nil;
  FillChar(ImgRect, SizeOf(ImgRect), 0);

  Scale := MainScreen.Scale;
  if (Column is TGlyphColumn) and (FImageIndex >= 0) then
  begin
    bounds := Owner.iOSGrid.PaddingRect(TUIView.Wrap(View.superview).bounds, Owner.Column);
    ImgRect := bounds.ToRectF;
    ImgRect := TGlyphColumn(Column).GlyphPlaceIntoBounds(FImageIndex, ImgRect, Scale);
    if (ImgRect.Width > 0) and (ImgRect.Height > 0) then
    begin
      Images := TCustomImageList(TGlyphColumn(Column).GlyphInterface.Images);
      Size := TSizeF.Create(ImgRect.Width * Scale, ImgRect.Height * Scale);
      LBitmap := Images.Bitmap(Size, FImageIndex);
      if LBitmap <> nil then
        LImage := BitmapToUIImage(LBitmap);
    end;
  end;
  UIImageView(View).setImage(LImage);
  if (LImage <> nil) and (ImgRect.Size.Width > 1) and (ImgRect.Size.Height > 1) then
  begin
    UIImageView(View).setHidden(False);
    bounds.origin.x := Round(ImgRect.Left * Scale) / Scale;
    bounds.origin.y := Round(ImgRect.Top * Scale) / Scale;
    bounds.Size.Width := ImgRect.Width;
    bounds.Size.Height := ImgRect.Height;
    UIImageView(View).SetFrame(bounds);
  end
  else
    UIImageView(View).setHidden(True);
end;

function TiOSCellGlyph.GetData: TValue;
begin
  Result := FImageIndex;
end;

procedure TiOSCellGlyph.SetData(const Value: TValue);
var
  LImageIndex: TImageIndex;
begin
  if Owner.Column is TGlyphColumn then
    LImageIndex := TGlyphColumn(Owner.Column).GetImageIndex(Value)
  else
    LImageIndex := -1;
  if FImageIndex <> LImageIndex then
  begin
    FImageIndex := LImageIndex;
    Update;
  end;
end;

{$ENDREGION}
{$REGION 'TiOSCellImage'}

function TiOSCellImage.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellImage);
end;

function TiOSCellImage.GetFrame: NSRect;
var
  ImgRect: TRectF;
  Scale: CGFloat;
begin
  Result := inherited GetFrame;
  if (Column is TImageColumn) and (FImage <> nil) then
  begin
    Scale := MainScreen.Scale;
    ImgRect := TRectF.Create(TPointF.Zero, FImage.Size.ToSizeF).PlaceInto(Result.ToRectF).SnapToPixel(Scale, False);
    Result := NSRect.Create(ImgRect);
  end;
end;

procedure TiOSCellImage.DoUpdate;
var
  bounds: CGRect;
begin
  if (Column is TImageColumn) and (FImage <> nil) then
  begin
    bounds := Owner.iOSGrid.PaddingRect(TUIView.Wrap(View.superview).bounds, Owner.Column);
    if (bounds.Size.Width > 1) and (bounds.Size.Height >= 1) then
    begin
      UIImageView(View).setHidden(False);
      UIImageView(View).setImage(FImage);
    end
    else
      UIImageView(View).setImage(nil);
  end
  else
    UIImageView(View).setHidden(True);
end;

function TiOSCellImage.GetData: TValue;
begin
  if FImage = nil then
    Result := TValue.Empty
  else
    Result := UIImageToBitmap(FImage, 0, FImage.Size.ToSizeF.Round);
end;

procedure TiOSCellImage.SetData(const Value: TValue);
begin
  if not Value.IsEmpty and (Value.IsObject) and (Value.AsObject is TBitmap) and not TBitmap(Value.AsObject).IsEmpty then
  begin
    FImage := BitmapToUIImage(TBitmap(Value.AsObject));
    Update;
  end
  else if FImage <> nil then
  begin
    FImage := nil;
    Update;
  end;
end;

{$ENDREGION}
{$REGION 'TiOSCellImageEditor'}

constructor TiOSCellImageEditor.Create(const AOwner: TColumnItem);
begin
  inherited;
  TPlatformServices.Current.SupportsPlatformService(IFMXTakenImageService, FTakenImageService);
  TMessageManager.DefaultManager.SubscribeToMessage(TMessageDidFinishTakingImageFromLibrary, DidReceiveBitmap);
  FImageControl := TiOSCellImage.Create(AOwner);
  UIImageView(FImageControl.View).setUserInteractionEnabled(False);
end;

destructor TiOSCellImageEditor.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TMessageDidFinishTakingImageFromLibrary, DidReceiveBitmap);
  FTakenImageService := nil;
  FImageControl := nil;
  FreeAndNil(FBitmap);
  inherited;
end;

function TiOSCellImageEditor.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellImageEditor);
end;

procedure TiOSCellImageEditor.DoUpdate;
begin
  Owner.View.bringSubviewToFront(FImageControl.View);
  View.setHidden(False);
  View.setUserInteractionEnabled(True);
  View.resignFirstResponder;
  FImageControl.Update;
end;

procedure TiOSCellImageEditor.DoApply(AImage: TBitmap);
begin
  try
    if AImage <> nil then
    begin
      if FBitmap = nil then
        FBitmap := TBitmap.Create;
      FBitmap.Assign(AImage);
      FImageControl.Data := FBitmap;
    end
    else
    begin
      FreeAndNil(FBitmap);
      FImageControl.Data := TValue.Empty;
    end;
    FBitmapLoaded := True;
    Column.EditorModified;
  except
    Application.HandleException(Owner.iOSGrid);
  end;
  Owner.iOSGrid.PerformSelector('EditorReturnDown');
end;

procedure TiOSCellImageEditor.DidReceiveBitmap(const Sender: TObject; const M: TMessage);
begin
  if M is TMessageDidFinishTakingImageFromLibrary then
    DoApply(TMessageDidFinishTakingImageFromLibrary(M).Value);
end;

procedure TiOSCellImageEditor.EditorClick;
var
  Params: TParamsPhotoQuery;
begin
  if FTakenImageService <> nil then
  begin
    FillChar(Params, SizeOf(Params), 0);
    Params.RequiredResolution := TSize.Create(TCustomTakePhotoAction.DefaultMaxWidth,
      TCustomTakePhotoAction.DefaultMaxHeight);
    Params.Editable := TCustomTakePhotoAction.DefaultEditable;
    Params.NeedSaveToAlbum := TCustomTakePhotoAction.DefaultNeedSaveToAlbum;
    Params.OnDidFinishTaking := DoApply;
    FTakenImageService.TakeImageFromLibrary(Owner.Column, Params);
  end;
end;

function TiOSCellImageEditor.GetData: TValue;
begin
  if (FBitmap <> nil) and not FBitmap.IsEmpty then
    Result := FBitmap
  else
    Result := TValue.Empty;
end;

procedure TiOSCellImageEditor.SetData(const Value: TValue);
begin
  FBitmapLoaded := False;
  if (not Value.IsEmpty) and (Value.IsObject) and (Value.AsObject is TBitmap) and
    not TBitmap(Value.AsObject).IsEmpty then
  begin
    if FBitmap = nil then
      FBitmap := TBitmap.Create;
    FBitmap.Assign(TBitmap(Value.AsObject));
    FImageControl.Data := FBitmap;
  end
  else
  begin
    FreeAndNil(FBitmap);
    FImageControl.Data := TValue.Empty;
  end;
end;

procedure TiOSCellImageEditor.touchesBegan(touches: NSSet; withEvent: UIEvent);
begin

end;

procedure TiOSCellImageEditor.touchesEnded(touches: NSSet; withEvent: UIEvent);
begin
  EditorClick;
end;
{$ENDREGION}
{$REGION 'TiOSCellCheck'}

function TiOSCellCheck.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellCheck);
end;

procedure TiOSCellCheck.DoUpdate;
begin
  inherited;
  if not FInitialized then
  begin
    UIImageView(View).initWithImage(Owner.iOSGrid.Images[TImageKind.False], Owner.iOSGrid.Images[TImageKind.True]);
    FInitialized := True;
  end;
  View.setHidden(Owner.iOSGrid.Images[FValue] = nil);
  UIImageView(View).setHighlighted(FValue = TImageKind.True);
end;

function TiOSCellCheck.GetData: TValue;
begin
  case FValue of
    TImageKind.Empty:
      Result := TValue.Empty;
    TImageKind.False:
      Result := False;
    TImageKind.True:
      Result := True;
  end;
end;

function TiOSCellCheck.GetFrame: NSRect;
var
  R, DesignatedArea: TRectF;
begin
  Result := inherited GetFrame;
  if (Owner.iOSGrid.Images[TImageKind.True] <> nil) and (Owner.Column <> nil) then
  begin
    R := TRectF.Create(0, 0, Owner.iOSGrid.Images[TImageKind.True].Size.Width,
      Owner.iOSGrid.Images[TImageKind.True].Size.Height);
    DesignatedArea := Result.ToRectF;
    R := Owner.Column.RectPlaceIntoBounds(R, DesignatedArea);
    Result := NSRect.Create(R);
  end;
end;

procedure TiOSCellCheck.SetData(const Value: TValue);
var
  B: Boolean;
begin
  if not (Owner.Column is TCheckColumn) or not TCheckColumn(Owner.Column).TryGetAsBoolean(Value, B) then
    FValue := TImageKind.Empty
  else if B then
    FValue := TImageKind.True
  else
    FValue := TImageKind.False;
  Update;
end;

{$ENDREGION}
{$REGION 'TiOSCellCheckEditor'}

constructor TiOSCellCheckEditor.Create(const AOwner: TColumnItem);
begin
  inherited;
  FCheckControl := TiOSCellCheck.Create(AOwner);
  UIImageView(FCheckControl.View).setUserInteractionEnabled(False);
end;

function TiOSCellCheckEditor.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellCheckEditor);
end;

procedure TiOSCellCheckEditor.DoUpdate;
begin
  inherited;
  Owner.View.bringSubviewToFront(FCheckControl.View);
  View.setHidden(False);
  View.setUserInteractionEnabled(True);
  View.resignFirstResponder;
  FCheckControl.Update;
end;

function TiOSCellCheckEditor.GetData: TValue;
begin
  Result := FCheckControl.Data;
end;

procedure TiOSCellCheckEditor.SetData(const Value: TValue);
begin
  FCheckControl.Data := Value;
end;

procedure TiOSCellCheckEditor.EditorClick;
begin
  inherited;
  try
    SetData(not GetData.AsBoolean);
    Owner.iOSGrid.EditingDone(True);
  except
    Application.HandleException(Owner.iOSGrid);
  end;
  try
    Owner.iOSGrid.RefreshEditor(True, True);
  except
    Application.HandleException(Owner.iOSGrid);
  end;
end;

procedure TiOSCellCheckEditor.touchesBegan(touches: NSSet; withEvent: UIEvent);
begin

end;

procedure TiOSCellCheckEditor.touchesEnded(touches: NSSet; withEvent: UIEvent);
begin
  Column.EditorModified;
  EditorClick;
end;
{$ENDREGION}
{$REGION 'TiOSCellTimePicker'}

procedure TiOSCellTimePicker.DoUpdateField(const AField: UITextField; const ADateTime: TDateTime);
begin
  if IsNan(ADateTime) then
    AField.setText(nil)
  else
  begin
    if Column is TTimeColumn then
      AField.setText(StrToNSStr(TTimeColumn(Column).ValueToString(ADateTime)))
    else
      AField.setText(StrToNSStr(TimeToStr(ADateTime)));
  end;
end;

function TiOSCellTimePicker.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellTimePicker);
end;

function TiOSCellTimePicker.GetPickerShowMode: TDatePickerShowMode;
begin
  Result := TDatePickerShowMode.Time;
end;

function TiOSCellTimePicker.ValueToDateTime(const Value: TValue): TDateTime;
var
  S: string;
  CustomFormatSettings: TFormatSettings;
begin
  Result := NAN;
  if not Value.IsEmpty and not Value.IsObject and not Value.TryAsType<TDateTime>(Result) and Value.TryAsType<string>(S)
  then
  begin
    if not (Column is TTimeColumn) or TTimeColumn(Column).Format.IsEmpty then
    begin
      if not TryStrToTime(S, Result) then
        Result := NAN;
    end
    else
    begin
      CustomFormatSettings := FormatSettings;
      CustomFormatSettings.ShortTimeFormat := TTimeColumn(Column).Format;
      CustomFormatSettings.LongTimeFormat := TTimeColumn(Column).Format;
      if not TryStrToTime(S, Result, CustomFormatSettings) then
        Result := NAN;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'TiOSCellPopupLabel'}

function TiOSCellPopupLabel.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellPopupLabel);
end;

function TiOSCellPopupLabel.GetData: TValue;
begin
  if FUsingIndex then
    if FValue.IsEmpty then
      Result := -1
    else
      Result := FValue.AsInteger
  else
    Result := FValue.AsString;
end;

procedure TiOSCellPopupLabel.SetData(const Value: TValue);
var
  S: string;
  I: Integer;
begin
  S := string.Empty;
  FUsingIndex := Value.IsOrdinal and not Value.IsEmpty;
  if FUsingIndex then
    if Value.IsEmpty then
      FValue := TValue.Empty
    else
    begin
      I := Value.AsInteger;
      FValue := I;
      if (Column is TPopupColumn) and (I >= 0) and (I < TPopupColumn(Column).Items.Count) then
        S := TPopupColumn(Column).Items[I];
    end
  else if Value.TryAsType<string>(S) then
    FValue := S
  else
    FValue := TValue.Empty;
  inherited SetData(S);
end;
{$ENDREGION}
{$REGION 'TiOSCellPopupPicker'}

destructor TiOSCellPopupPicker.Destroy;
begin
  FreeAndNil(FPicker);
  inherited;
end;

function TiOSCellPopupPicker.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCellPopupPicker);
end;

procedure TiOSCellPopupPicker.touchesBegan(touches: NSSet; withEvent: UIEvent);
begin

end;

procedure TiOSCellPopupPicker.touchesEnded(touches: NSSet; withEvent: UIEvent);
begin
  EditorClick;
end;

procedure TiOSCellPopupPicker.EditorClick;
var
  PickerService: IFMXPickerService;
  S: string;
  I: Integer;
begin
  inherited;
  FreeAndNil(FPicker);
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, PickerService) then
  begin
    ValidateInheritance(Owner.Model.Owner, TControl, False);
    FPicker := PickerService.CreateListPicker;
    FPicker.Parent := TControl(Owner.Model.Owner);
    FPicker.AbsoluteTargetRect := AbsoluteRect;
    FPicker.OnValueChanged := DoApply;
    if Column is TPopupColumn then
    begin
      FPicker.Values := TPopupColumn(Column).Items;
      if UsingIndex then
        FPicker.ItemIndex := GetData.AsInteger
      else
      begin
        S := GetData.AsString;
        for I := 0 to TPopupColumn(Column).Items.Count - 1 do
          if S = TPopupColumn(Column).Items[I] then
          begin
            FPicker.ItemIndex := I;
            Break;
          end;
      end;
    end;
    FPicker.Show;
  end
  else
    raise EUnsupportedPlatformService.CreateFmt(SUnsupportedPlatformService, ['IFMXPickerService']);
end;

procedure TiOSCellPopupPicker.DoApply(Sender: TObject; const AValueIndex: Integer);
var
  S: string;
begin
  if UsingIndex then
    Data := AValueIndex
  else if Column is TPopupColumn then
  begin
    S := TPopupColumn(Column).Items[AValueIndex];
    Data := S;
  end;
  Column.EditorModified;
  Owner.iOSGrid.EditorReturnDown;
end;

{$ENDREGION}
{$REGION 'TColumnItemList'}

function TColumnItemList.TComparer.Compare(const Left, Right: TColumnItem): Integer;
var
  IntLeft, IntRight: Integer;
begin
  if Left <> nil then
    if (Left.Column <> nil) and Left.Column.Visible then
      IntLeft := Left.Column.Index
    else
      IntLeft := MaxInt - 1
  else
    IntLeft := MaxInt;
  if Right <> nil then
    if (Right.Column <> nil) and Right.Column.Visible then
      IntRight := Right.Column.Index
    else
      IntRight := MaxInt - 1
  else
    IntRight := MaxInt;
  Result := CompareValue(IntLeft, IntRight);
end;

procedure TColumnItemList.Assign(const Source: TColumnItemList; const Top, Height: CGFloat);
var
  I: Integer;
  Src, Dst: TColumnItem;
  CellFrame: CGRect;
begin
  for I := 0 to Count - 1 do
  begin
    Dst := Items[I];
    Src := Source.Items[I];
    if Dst.Column <> Src.Column then
      if not Source.TryGetValue(Dst.Column, Src) then
        raise EArgumentNilException.Create(sArgumentInvalid);
    CellFrame := Src.Frame;
    CellFrame.origin.y := Top;
    CellFrame.Size.Height := Height;
    Dst.Frame := CellFrame;
    Dst.HiddenFound := Src.HiddenFound;
    Dst.ColLines := Src.ColLines;
    Dst.Update;
  end;
end;

constructor TColumnItemList.Create;
begin
  if FComparer = nil then
    FComparer := TComparer.Create;
  inherited Create(FComparer);
end;

function TColumnItemList.Find(const Column: TColumn): Integer;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if (Items[I] <> nil) and (Items[I].Column = Column) then
      Exit(I);
  Result := -1;
end;

function TColumnItemList.RemoveUselessItems(const ExceptTiny: Boolean = True): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Count - 1 downto 0 do
    if (Items[I] = nil) or (Items[I].Column = nil) or not Items[I].Column.Visible or
      (not ExceptTiny and (Items[I].Column.Width < 1)) then
    begin
      if Items[I] <> nil then
        Items[I].Column := nil;
      Delete(I);
      Result := True;
    end;
end;

function TColumnItemList.TryGetValue(const Column: TColumn; var Item: TColumnItem): Boolean;
var
  I: Integer;
begin
  Item := nil;
  I := Find(Column);
  Result := I >= 0;
  if Result then
    Item := Items[I]
  else
    for I := Count - 1 downto 0 do
      if (Items[I] <> nil) and ((Items[I].Column = nil) or not Items[I].Column.Visible) then
      begin
        Item := Items[I];
        Exit;
      end;
end;

{$ENDREGION}
{$REGION 'TFMXColumnItem'}

destructor TColumnItem.TColumnLink.Destroy;
begin
  Column := nil;
  inherited;
end;

procedure TColumnItem.TColumnLink.FreeNotification(AObject: TObject);
begin
  if AObject = FColumn then
  begin
    FColumn := nil;
    FChanged := True;
    FClassChanged := True;
  end;
end;

function TColumnItem.TColumnLink.GetColumn: TColumn;
begin
  Result := FColumn;
end;

procedure TColumnItem.TColumnLink.SetColumn(const Value: TColumn);
var
  OldClass, NewClass: TColumnClass;
begin
  if FColumn <> Value then
  begin
    if FColumn <> nil then
    begin
      FColumn.RemoveFreeNotify(Self);
      OldClass := TColumnClass(FColumn.ClassType);
    end
    else
      OldClass := nil;
    FColumn := Value;
    FChanged := True;
    if FColumn <> nil then
    begin
      FColumn.AddFreeNotify(Self);
      NewClass := TColumnClass(FColumn.ClassType);
    end
    else
      NewClass := nil;
    FClassChanged := OldClass <> NewClass;
  end;
end;

constructor TColumnItem.Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn);
var
  V: Pointer;
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) or (AParent = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FColumnLink := TColumnLink.Create;
  FiOSGrid := AiOSGrid;
  FModel := AiOSGrid.Model;
  Column := AColumn;

  V := View.initWithFrame(RectToNSRect(TRect.Create(0, 0, Round(AColumn.Width), Round(FiOSGrid.DefaultRowHeight))));
  if GetObjectID <> V then
    UpdateObjectID(V);
  View.setHidden(True);

  AParent.addSubview(View);
  FDefaultThickness := AiOSGrid.DefaultThickness;
end;

destructor TColumnItem.Destroy;
begin
  FInternalCell := nil;
  View.removeFromSuperview;
  FColumnLink.DisposeOf;
  inherited;
end;

function TColumnItem.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IFMXColumnItem);
end;

function TColumnItem.GetView: UIView;
begin
  Result := UIView(Super);
end;

procedure TColumnItem.SetColLines(const Value: Boolean);
begin
  if FColLines <> Value then
  begin
    FColLines := Value;
    FSizeChanged := True;
  end;
end;

function TColumnItem.GetColumn: TColumn;
begin
  Result := FColumnLink.Column;
end;

procedure TColumnItem.SetColumn(const Value: TColumn);
begin
  FColumnLink.Column := Value;
end;

procedure TColumnItem.SetFrame(const Value: NSRect);
begin
  if not SameValue(FFrame.origin.x, Value.origin.x, TEpsilon.FontSize) or not SameValue(FFrame.origin.y, Value.origin.y,
    TEpsilon.FontSize) then
    FPosChanged := True;

  if not SameValue(FFrame.Size.Width, Value.Size.Width, TEpsilon.FontSize) or
    not SameValue(FFrame.Size.Height, Value.Size.Height, TEpsilon.FontSize) then
    FSizeChanged := True;

  if FSizeChanged or FPosChanged then
    FFrame := Value;
end;

procedure TColumnItem.SetHiddenFound(const Value: Boolean);
begin
  if FHiddenFound <> Value then
  begin
    FHiddenFound := Value;
    FSizeChanged := True;
  end;
end;

function TColumnItem.ClientRect: NSRect;
begin
  Result := View.bounds;
  Result := iOSGrid.PaddingRect(Result, Column);
end;

procedure TColumnItem.Update;
var
  LatestItem: TColumnItem;
begin
  try
    LatestItem := iOSGrid.iOSHeader.HeaderItems[iOSGrid.iOSHeader.HeaderItems.Count - 1];
    if FSizeChanged or FPosChanged then
      View.SetFrame(FFrame);
    View.setHidden((Column <> nil) and (not Column.Visible or ((Column.Width < 1) and (Self <> LatestItem))));
    if not View.isHidden then
    begin
      if FColumnLink.ClassChanged then
      begin
        FInternalCell := nil;
        FInternalCell := CreateInternalCell;
        FSizeChanged := True;
        FColumnLink.ClassChanged := False;
      end;
      if FInternalCell <> nil then
        FInternalCell.Update;
    end;
    DoUpdate;
    FSizeChanged := False;
    FPosChanged := False;
  except
    Application.HandleException(iOSGrid);
  end;
end;

{$ENDREGION}
{$REGION 'TFMXHeaderItem'}

constructor TFMXHeaderItem.Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn);
begin
  inherited;
  FRightBorder := TiOSLineView.Create(iOSGrid, View, False, False);
end;

destructor TFMXHeaderItem.Destroy;
begin
  FRightBorder := nil;
  if FRightColumnLine <> nil then
  begin
    UIView(FRightColumnLine.Super).removeFromSuperview;
    FRightColumnLine := nil;
  end;
  if FLeftColumnLine <> nil then
  begin
    UIView(FLeftColumnLine.Super).removeFromSuperview;
    FLeftColumnLine := nil;
  end;
  inherited;
end;

procedure TFMXHeaderItem.DoUpdate;
var
  RightHidden: Boolean;
begin
  inherited;
  UpdateVerticalBorders;
  if FFirstBorder <> nil then
    FFirstBorder.Update;
  FRightBorder.Update;
  if HiddenFound then
    if FLeftBorder = nil then
      FLeftBorder := TiOSLineView.Create(iOSGrid, View, False, True)
    else
      FLeftBorder.Update
  else
    FLeftBorder := nil;
  if FLeftColumnLine <> nil then
    FLeftColumnLine.Visible := not View.isHidden;
  if FRightColumnLine <> nil then
    FRightColumnLine.Visible := not View.isHidden;
  RightHidden := (Column = nil) or (Column.Width < 1) or not Column.Visible;
  if FRightBorder <> nil then
    FRightBorder.View.setHidden(RightHidden);
  if FLeftColumnLine <> nil then
    FLeftColumnLine.View.setHidden(View.isHidden);
  if FRightColumnLine <> nil then
    FRightColumnLine.View.setHidden(View.isHidden or RightHidden);
end;

function TFMXHeaderItem.CreateInternalCell: TiOSCellControl;
begin
  Result := TiOSCellHeader.Create(Self);
end;

procedure TFMXHeaderItem.SetFirst(const Value: Boolean);
var
  LOffset: NSPoint;
begin
  if FFirst <> Value then
  begin
    FFirst := Value;
    if FFirst then
    begin
      if FFirstBorder = nil then
      begin
        FFirstBorder := TiOSLineView.Create(iOSGrid, View, False, True);
        LOffset.y := -iOSGrid.DefaultThickness;
        LOffset.x := -iOSGrid.DefaultThickness;
        FFirstBorder.Offset := LOffset;
      end;
    end
    else
    begin
      if FFirstBorder <> nil then
      begin
        FFirstBorder.View.removeFromSuperview;
        FFirstBorder := nil;
      end;
    end;
  end;
end;

procedure TFMXHeaderItem.UpdateVerticalBorders;
begin
  if FColLines then
  begin
    if FRightColumnLine = nil then
      FRightColumnLine := TiOSLineView.Create(iOSGrid, iOSGrid.iOSTable.View, False, False, View)
  end
  else
  begin
    if FRightColumnLine <> nil then
    begin
      FRightColumnLine.DisposeOf;
      FRightColumnLine := nil;
    end;
    if FLeftColumnLine <> nil then
    begin
      FLeftColumnLine.DisposeOf;
      FLeftColumnLine := nil;
    end;
  end;
  if FRightColumnLine <> nil then
  begin
    if FHiddenFound then
    begin
      if FLeftColumnLine = nil then
        FLeftColumnLine := TiOSLineView.Create(iOSGrid, iOSGrid.iOSTable.View, False, True, View);
    end
    else
    begin
      if FLeftColumnLine <> nil then
      begin
        FLeftColumnLine.DisposeOf;
        FLeftColumnLine := nil;
      end;
    end;
    if FLeftColumnLine <> nil then
      FLeftColumnLine.Update;
    FRightColumnLine.Update;
  end;
end;

{$ENDREGION}
{$REGION 'TiOSInplaceEditor'}

constructor TiOSInplaceEditor.Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn);
begin
  inherited;
  Update;
  iOSGrid.iOSTable.View.addSubview(View);
end;

destructor TiOSInplaceEditor.Destroy;
begin
  if FBackground <> nil then
  begin
    FBackground.removeFromSuperview;
    FBackground := nil;
  end;
  View.removeFromSuperview;
  inherited;
end;

procedure TiOSInplaceEditor.Activate;
begin
  if not FActive then
  begin
    FActive := True;
    View.setBackgroundColor(iOSGrid.FTintColor);
    FBackground.setBackgroundColor(iOSGrid.FBkColor);
    if InternalCell <> nil then
      InternalCell.Activate;
  end;
end;

procedure TiOSInplaceEditor.Deactivate;
begin
  if FActive then
  begin
    FActive := False;
    View.setBackgroundColor(iOSGrid.FHighlightColor);
    if InternalCell <> nil then
      InternalCell.Deactivate;
  end;
end;

function TiOSInplaceEditor.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSInplaceEditor);
end;

procedure TiOSInplaceEditor.DoUpdate;
var
  R: NSRect;
begin
  R := iOSGrid.GetEditorRect;
  if not FInitialized then
  begin
    View.initWithFrame(R);
    FInitialized := True;
  end
  else
    View.SetFrame(R);
  R := View.bounds;
  R.origin.x := BorderWidth;
  R.origin.y := BorderWidth;
  R.Size.Width := R.Size.Width - 2 * BorderWidth;
  R.Size.Height := R.Size.Height - 2 * BorderWidth;
  if FBackground = nil then
  begin
    FBackground := TUIView.Wrap(TUIView.Alloc.initWithFrame(R));
    View.addSubview(FBackground);
    View.sendSubviewToBack(FBackground);
  end
  else
    FBackground.SetFrame(R);
end;

procedure TiOSInplaceEditor.EditorClick;
begin
  if InternalCell <> nil then
    InternalCell.EditorClick;
end;

function TiOSInplaceEditor.CreateInternalCell: TiOSCellControl;
var
  CellType: TiOSCellControlClass;
  textField: UITextField;
begin
  if Column = nil then
    raise EArgumentNilException.Create(SArgumentNil);
  CellType := iOSGrid.GetEditorClass(Column);
  if CellType = nil then
    CellType := TiOSCellDefaultEditor;
  Result := CellType.Create(Self);
  if Supports(Result.View, UITextField, textField) then
    textField.setDelegate(TiOSEditDelegate(iOSGrid.FiOSEditDelegate).GetObjectID);
end;

{$ENDREGION}
{$REGION 'TiOSHeader'}

constructor TiOSHeader.Create(const AiOSGrid: TiOSGrid);
var
  LOffset: NSPoint;
  V: Pointer;
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
  FModel := AiOSGrid.Model;
  FHeight := Round(iOSGrid.DefaultRowHeight);
  FWidth := FHeight;
  V := View.initWithFrame(RectToNSRect(TRect.Create(0, 0, Round(FWidth), Round(iOSGrid.DefaultRowHeight))));
  if GetObjectID <> V then
    UpdateObjectID(V);
  View.setBackgroundColor(TUIColor.Wrap(TUIColor.OCClass.groupTableViewBackgroundColor));
  FLineHeader := TiOSLineView.Create(iOSGrid, View, True, False);
  LOffset.x := -iOSGrid.DefaultThickness;
  LOffset.y := 0;
  FLineHeader.Offset := LOffset;
  FHeaderItems := TColumnItemList.Create;
  iOSGrid.View.addSubview(View);
end;

destructor TiOSHeader.Destroy;
begin
  FHeaderItems.Clear;
  FHeaderItems := nil;
  inherited;
end;

function TiOSHeader.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSHeader);
end;

function TiOSHeader.GetView: UIView;
begin
  Result := UIView(Super);
end;

procedure TiOSHeader.Update;
var
  LSorted, LHiddenFound, LFirst: Boolean;
  I: Integer;
  LItem: TFMXHeaderItem;
  x: CGFloat;
  R, ParentRect: NSRect;
begin
  { Recreate header items }
  FHeaderItems.Sort;
  LSorted := True;
  for I := 0 to Model.ColumnCount - 1 do
    if Model.Columns[I].Visible then
    begin
      if not FHeaderItems.TryGetValue(Model.Columns[I], TColumnItem(LItem)) then
      begin
        LSorted := False;
        if LItem = nil then
        begin
          LItem := TFMXHeaderItem.Create(iOSGrid, View, Model.Columns[I]);
          LItem.ColLines := TGridOption.ColLines in iOSGrid.Model.Options;
          FHeaderItems.Add(LItem);
        end
        else
          LItem.Column := Model.Columns[I];
      end;
    end;
  { Remove unused items }
  if FHeaderItems.RemoveUselessItems then
    LSorted := False;
  if not LSorted then
    FHeaderItems.Sort;
  { Update of every coordinates }
  LHiddenFound := False;
  LFirst := True;
  x := 0;
  R.origin.y := 0;
  R.Size.Height := View.Frame.Size.Height - iOSGrid.DefaultThickness;
  for I := 0 to FHeaderItems.Count - 1 do
    if FHeaderItems[I].Column.Visible then
    begin
      LItem := TFMXHeaderItem(FHeaderItems[I]);
      R.origin.x := x;
      R.Size.Width := 0;
      if LItem.Column.Width < 1 then
      begin
        LHiddenFound := True;
        R.Size.Width := 0;
        LItem.First := False;
      end
      else
      begin
        LItem.HiddenFound := LHiddenFound;
        LItem.First := LFirst;
        LFirst := False;
        if LHiddenFound then
        begin
          R.Size.Width := LItem.Column.Width + iOSGrid.DefaultThickness + iOSGrid.ColumnThickness;
          LHiddenFound := False;
        end
        else
          R.Size.Width := LItem.Column.Width + iOSGrid.ColumnThickness;
        x := x + R.Size.Width;
      end;
      LItem.Frame := R;
    end;
  { The last dummy column }
  if LHiddenFound then
  begin
    R.origin.x := x;
    R.Size.Width := R.Size.Height;
    LItem.Frame := R;
    LItem.HiddenFound := LHiddenFound;
    x := x + iOSGrid.DefaultThickness;
  end;
  { Updating of other properties }
  FWidth := x - iOSGrid.ColumnThickness;
  if TGridOption.Header in Model.Options then
  begin
    View.setHidden(False);
    ParentRect := iOSGrid.View.Frame;
    R.origin.x := -iOSGrid.iOSTable.View.contentOffset.x;
    R.origin.y := 0;
    R.Size.Width := Max(FWidth, ParentRect.Size.Width);
    R.Size.Height := FHeight;
    View.SetFrame(R);
  end
  else
    View.setHidden(True);
  for I := 0 to FHeaderItems.Count - 1 do
  begin
    LItem := TFMXHeaderItem(FHeaderItems[I]);
    LItem.ColLines := TGridOption.ColLines in Model.Options;
    LItem.Update;
  end;
  FLineHeader.Update;
end;

{$ENDREGION}
{$REGION 'TFMXCell'}

constructor TiOSCell.Create(const AiOSGrid: TiOSGrid; const AParent: UIView; const AColumn: TColumn);
begin
  inherited;
end;

function TiOSCell.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSCell);
end;

procedure TiOSCell.SetRow(const Value: Integer);
begin
  if FRow <> Value then
  begin
    if (Row < 0) and (Value >= 0) then
    begin
      if (Model.Row = Value) and (Model.Col = Column.Index) then
        View.setBackgroundColor(iOSGrid.FFocusColor)
      else
        View.setBackgroundColor(nil);
    end;
    FRow := Value;
    if (FRow < 0) and (InternalCell <> nil) then
      InternalCell.Data := TValue.Empty;
  end;
end;

function TiOSCell.CreateInternalCell: TiOSCellControl;
var
  CellType: TiOSCellControlClass;
begin
  Result := nil;
  if Column <> nil then
  begin
    CellType := iOSGrid.GetCellClass(Column);
    if CellType = nil then
      CellType := TiOSCellLabel;
    Result := CellType.Create(Self);
  end
end;

procedure TiOSCell.DoUpdate;
begin
  if Column <> nil then
  begin
    if (Row >= 0) and (Model.Row = Row) and (Model.Col = Column.Index) then
      View.setBackgroundColor(iOSGrid.FFocusColor)
    else
      View.setBackgroundColor(nil);
  end;
end;

procedure TiOSCell.DoUpdateValue(const ACell: TiOSCellControl);
begin
  if (ACell <> nil) then
  begin
    if (Column <> nil) and (Row >= 0) and (Row < Model.RowCount) then
      ACell.Data := Model.GetValue(Column.Index, Row, True)
    else
      ACell.Data := TValue.Empty
  end;
end;

procedure TiOSCell.UpdateValue;
begin
  try
    if not View.isHidden and (InternalCell <> nil) and Column.Visible and (Column.Width >= 1) then
      DoUpdateValue(InternalCell);
  except
    Application.HandleException(iOSGrid);
  end;
end;

{$ENDREGION}
{$REGION 'TFMXUITableCell'}

constructor TUITableViewRow.Create(const AiOSGrid: TiOSGrid);
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
  FModel := AiOSGrid.Model;
  InitView;
  FLineDown := TiOSLineView.Create(FiOSGrid, View, True, False);
  FCells := TColumnItemList.Create;
  FiOSGrid.iOSTable.View.addSubview(View);
end;

destructor TUITableViewRow.Destroy;
begin
  FCells.Clear;
  FCells.Free;
  FLineDown := nil;
  inherited;
end;

procedure TUITableViewRow.InitView;
var
  V: Pointer;
begin
  V := View.init;
  if GetObjectID <> V then
    UpdateObjectID(V);
end;

function TUITableViewRow.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IUITableViewRow);
end;

function TUITableViewRow.GetCells(const Index: Integer): TiOSCell;
var
  Item: TColumnItem;
begin
  if (FCells <> nil) and (Index >= 0) and (Index < FModel.ColumnCount) and
    FCells.TryGetValue(FModel.Columns[Index], Item) then
    Result := TiOSCell(Item)
  else
    Result := nil;
end;

function TUITableViewRow.GetIndex: Integer;
begin
  Result := View.tag;
end;

function TUITableViewRow.GetView: UIView;
begin
  Result := IUITableViewRow(Super);
end;

procedure TUITableViewRow.PrepareForReuse;
var
  I: Integer;
begin
  if not Model.DataStored or Model.IsUsedInBinding then
    FModel.ClearRowInCache(GetIndex);
  for I := 0 to FCells.Count - 1 do
    TiOSCell(FCells[I]).Row := -1;
  View.setTag(-1);
end;

procedure TUITableViewRow.Update;
var
  LHeader, LCell: TColumnItem;
  R, OldFrame: NSRect;
  I: Integer;
begin
  IiOSLineView(FLineDown.Super).setHidden(not (TGridOption.RowLines in iOSGrid.Model.Options));
  if (iOSGrid <> nil) and (iOSGrid.iOSHeader.HeaderItems <> nil) and
    (iOSGrid.FContentState <> TiOSGrid.TContentState.Changed) then
  begin
    for I := 0 to iOSGrid.iOSHeader.HeaderItems.Count - 1 do
    begin
      LHeader := iOSGrid.iOSHeader.HeaderItems[I];
      if not FCells.TryGetValue(LHeader.Column, LCell) and (LHeader.Column.Width >= 1) then
      begin
        if LCell = nil then
        begin
          LCell := TiOSCell.Create(iOSGrid, View, LHeader.Column);
          FCells.Add(LCell);
        end
        else
          LCell.Column := LHeader.Column;
      end;
    end;
    FCells.RemoveUselessItems(False);
    FCells.Sort;
    if FLineDown <> nil then
    begin
      FLineDown.Visible := TGridOption.RowLines in iOSGrid.Model.Options;
      R.origin.x := 0;
      R.origin.y := iOSGrid.iOSTable.RowHeight * Index;
      R.Size.Width := iOSGrid.iOSHeader.Width;
      R.Size.Height := iOSGrid.iOSTable.RowHeight;
      OldFrame := View.Frame;
      View.SetFrame(R);
      if not (SameValue(OldFrame.Size.Width, R.Size.Width, TEpsilon.FontSize) and SameValue(OldFrame.Size.Height,
        R.Size.Height, TEpsilon.FontSize)) then
      begin
        FCells.Assign(FiOSGrid.iOSHeader.HeaderItems, 0, R.Size.Height - iOSGrid.RowThickness);
        if (FLineDown <> nil) and FLineDown.Visible then
          FLineDown.Update;
      end;
    end;
    for I := 0 to FCells.Count - 1 do
    begin
      TiOSCell(FCells[I]).Row := Index;
      TiOSCell(FCells[I]).UpdateValue;
    end;
    if (Model.Row = Index) and (TGridOption.RowSelect in Model.Options) then
      View.setBackgroundColor(iOSGrid.FHighlightColor)
    else if Odd(Index) and (TGridOption.AlternatingRowBackground in Model.Options) then
      View.setBackgroundColor(iOSGrid.FOddColor)
    else
      View.setBackgroundColor(nil);
  end;
end;

{$ENDREGION}
{$REGION 'TiOSTable'}

{ TiOSTable.TRowComparer }

function TiOSTable.TRowComparer.Compare(const Left, Right: TUITableViewRow): Integer;
begin
  Result := CompareValue(Left.Index, Right.Index);
end;

constructor TiOSTable.Create(const AiOSGrid: TiOSGrid);
var
  V: Pointer;
  LOffset: NSPoint;
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
  FModel := AiOSGrid.Model;

  V := View.initWithFrame(FiOSGrid.GetViewFrame);
  if GetObjectID <> V then
    UpdateObjectID(V);

  LOffset.x := -iOSGrid.DefaultThickness;
  LOffset.y := -iOSGrid.DefaultThickness;
  FTopLine := TiOSLineView.Create(iOSGrid, View, True, True);
  FTopLine.Offset := LOffset;
  FLeftLine := TiOSLineView.Create(iOSGrid, View, False, True);
  FLeftLine.Offset := LOffset;

  View.setAlwaysBounceHorizontal(False);
  View.setAlwaysBounceVertical(False);
  View.setAutoresizesSubviews(False);
  View.setClipsToBounds(False);
  iOSGrid.View.addSubview(View);
end;

destructor TiOSTable.Destroy;
begin
  if FDisappearedRows <> nil then
  begin
    FDisappearedRows.Clear;
    FDisappearedRows.Free;
  end;
  if FRows <> nil then
  begin
    FRows.Clear;
    FRows.Free;
  end;
  FLeftLine := nil;
  FTopLine := nil;
  inherited;
end;

function TiOSTable.GetView: UIScrollView;
begin
  Result := UIScrollView(Super);
end;

function TiOSTable.GetRows(const Index: Integer): TUITableViewRow;
begin
  if not ((FRows <> nil) and FRows.TryGetValue(Index, Result)) then
    Result := nil;
end;

procedure TiOSTable.RowsAppeared(const MinRow, MaxRow: Integer);
var
  LRow: TUITableViewRow;
  I: Integer;
begin
  for I := Max(0, MinRow) to Min(RowCount - 1, MaxRow) do
  if (FRows = nil) or not FRows.ContainsKey(I) then
  begin
    if (FDisappearedRows <> nil) and (FDisappearedRows.Count > 0) then
      LRow := FDisappearedRows.Pop
    else
      LRow := TUITableViewRow.Create(iOSGrid);
    try
      if FRows = nil then
        FRows := TDictionary<Integer, TUITableViewRow>.Create;
      FRows.Add(I, LRow);
      try
        LRow.View.setTag(I);
        LRow.Update;
      except
        FRows.Remove(I);
        raise;
      end;
    finally
      LRow := nil;
    end;
  end;
end;

procedure TiOSTable.RowsDisappeared(const MinRow, MaxRow: Integer);
var
  I: Integer;
  RowIndexes: TArray<Integer>;
  LRow: TUITableViewRow;
begin
  if FRows <> nil then
  begin
    RowIndexes := FRows.Keys.ToArray;
    for I in RowIndexes do
      if (I < MinRow) or (I > MaxRow) then
      begin
        LRow := FRows[I];
        if FDisappearedRows = nil then
          FDisappearedRows := TStack<TUITableViewRow>.Create;
        FDisappearedRows.Push(LRow);
        FRows.Remove(I);
        LRow.PrepareForReuse;
      end;
  end;
end;

procedure TiOSTable.UpdateVisibleRows;
var
  I: Integer;
  List: TList<TUITableViewRow>;
begin
  if (FRows <> nil) and (FRows.Count > 0) and not Model.IsUpdating then
  begin
    List := TList<TUITableViewRow>.Create;
    try
      List.AddRange(FRows.Values);
      if List.Count > 0 then
      begin
        if FComparer = nil then
          FComparer := TRowComparer.Create;
        List.Sort(FComparer);
        Model.ReduceCache(0, List[0].Index, Model.ColumnCount - 1, List[List.Count - 1].Index);
        for I := 0 to List.Count - 1 do
          List[I].Update;
      end;
    finally
      List.Free;
    end;
  end;
end;

procedure TiOSTable.DidScroll(const ScrollView: UIScrollView);
var
  LBounds: NSRect;
  LOffset: CGFloat;
  TopRow, BottomRow: Integer;
begin
  LOffset := ScrollView.contentOffset.y;
  if RowHeight > 0 then
  begin
    LBounds := View.Bounds;
    TopRow := Trunc(LOffset / RowHeight);
    BottomRow := Min(RowCount - 1, Ceil((LOffset + LBounds.Size.Height) / RowHeight));
    RowsDisappeared(TopRow, BottomRow);
    RowsAppeared(TopRow, BottomRow);
  end;
end;

function TiOSTable.GetTouchCoord(const touches: NSSet; var x, y: single): Boolean;
var
  Touch: UITouch;
  P: CGPoint;
begin
  Result := (touches <> nil) and (touches.Count > 0);
  if Result then
  begin
    Touch := TUITouch.Wrap(touches.anyObject);
    P := Touch.locationInView(View);
    x := P.x;
    y := P.y;
  end;
end;

procedure TiOSTable.ScrollToSelectedCell(const Animated: Boolean = True);
var
  Rect: NSRect;
begin
  Rect := iOSGrid.CellRect(Model.Col, Model.Row);
  Rect.origin.x := Rect.origin.x - iOSGrid.ColumnThickness;
  Rect.origin.y := Rect.origin.y - iOSGrid.RowThickness;
  Rect.Size.Width := Min(View.Frame.Size.Width, Rect.Size.Width + 5 * iOSGrid.ColumnThickness);
  Rect.Size.Height := Rect.Size.Height + 5 * iOSGrid.RowThickness;
  View.scrollRectToVisible(Rect, Animated);
end;

procedure TiOSTable.SetVKOffset(const Value: CGFloat);
begin
  FVKOffset := Value;
  if FVKOffset > 0 then
    ScrollToSelectedCell(False);
  UpdateFrame;
  if FVKOffset > 0 then
    ScrollToSelectedCell(True);
end;

procedure TiOSTable.touchesBegan(touches: NSSet; withEvent: UIEvent);
begin
  { none }
end;

procedure TiOSTable.touchesCancelled(touches: NSSet; withEvent: UIEvent);
begin
  View.touchesCancelled(touches, withEvent);
end;

procedure TiOSTable.touchesEnded(touches: NSSet; withEvent: UIEvent);
var
  X, Y: Single;
  I: Integer;
  LFrame: CGRect;
  LCoord: TGridModel.TCoord;
begin
  try
    if Model.Enabled then
    begin
      if GetTouchCoord(touches, X, Y) then
      begin
        LCoord.Row := -1;
        LCoord.Col := -1;
        if (Y >= 0) and (Y < RowHeight * RowCount) then
          LCoord.Row := Trunc(Y / RowHeight);
        for I := 0 to iOSGrid.iOSHeader.HeaderItems.Count - 1 do
        begin
          LFrame := iOSGrid.iOSHeader.HeaderItems[I].Frame;
          if (X >= LFrame.origin.x) and (X <= LFrame.origin.x + LFrame.Size.Width) then
          begin
            LCoord.Col := iOSGrid.iOSHeader.HeaderItems[I].Column.Index;
            Break;
          end;
        end;
        if (LCoord.Row >= 0) and (LCoord.Col >= 0) then
        begin
          if (Model.Col = LCoord.Col) and (Model.Row = LCoord.Row) then
            Model.ShowEditor
          else
            Model.SelectCell(LCoord.Col, LCoord.Row);
          iOSGrid.PerformSelector('EditorClick');
        end;
      end;
    end;
  except
    Application.HandleException(iOSGrid);
  end;
end;

procedure TiOSTable.touchesMoved(touches: NSSet; withEvent: UIEvent);
begin
  View.touchesMoved(touches, withEvent);
end;

function TiOSTable.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSTable);
end;

procedure TiOSTable.UpdateFrame;
var
  R, RowRect: NSRect;
  LSize, LOldSize: NSSize;
  LOffset: CGPoint;
  LVKOffset, LContentOffset: CGFloat;
  ContentSizeChanged: Boolean;
  Row: TUITableViewRow;
begin
  FRowCount := Model.RowCount;
  if Model.RowHeight <= 0 then
    FRowHeight := iOSGrid.RowThickness + iOSGrid.DefaultRowHeight
  else
    FRowHeight := Model.RowHeight;
  LSize.height := Max(0, RowHeight) * Max(0, RowCount);
  LSize.width := iOSGrid.iOSHeader.Width;

  R := iOSGrid.View.Bounds;
  R.origin.y := iOSGrid.iOSHeader.Height;
  R.Size.Height := R.Size.Height - iOSGrid.iOSHeader.Height;
  LOffset := View.contentOffset;
  if (FVKOffset > iOSGrid.ColumnThickness) and (FVKOffset < R.Size.Height) then
  begin
    Row := Rows[Model.Row];
    if Row <> nil then
    begin
      RowRect := iOSGrid.View.convertRect(Row.View.Bounds, Row.View);
      RowRect.origin.y := RowRect.origin.y + FTableOffset;
      FTableOffset := 0;
      LVKOffset := (RowRect.origin.y + RowRect.Size.Height) - (R.origin.y + R.Size.Height - FVKOffset);
      if LVKOffset > 0 then
      begin
        LContentOffset := LSize.height - (LOffset.y + R.Size.Height);
        if LContentOffset >= LVKOffset then
        begin
          LOffset.y := LOffset.y + LVKOffset;
          View.setContentOffset(LOffset);
        end
        else
        begin
          LOffset.y := LOffset.y + LSize.Height - R.Size.Height - LOffset.y;
          View.setContentOffset(LOffset);
          RowRect := Row.View.Frame;
          LVKOffset := LSize.Height - (RowRect.origin.y + RowRect.Size.Height);
          FTableOffset := FVKOffset - LVKOffset;
          R.Origin.y := R.Origin.y - Max(0, FTableOffset);
        end;
      end;
    end
    else
      FTableOffset := 0;
  end
  else
    FTableOffset := 0;
  View.SetFrame(R);
  LOldSize := View.contentSize;
  ContentSizeChanged := not SameValue(LOldSize.Width, LSize.Width, TEpsilon.FontSize) or
    not SameValue(LOldSize.Height, LSize.Height, TEpsilon.FontSize);
  if ContentSizeChanged then
    View.setContentSize(LSize);
  View.setScrollEnabled(True);
  LOffset.Y := View.contentOffset.Y;
  View.setContentOffset(LOffset);
  if ContentSizeChanged then
    DidScroll(View);
end;

procedure TiOSTable.Update;
begin
  UpdateFrame;
  if (iOSGrid.iOSHeader.HeaderItems.Count > 0) and (Model.RowCount > 0) then
  begin
    FTopLine.Visible := TGridOption.RowLines in Model.Options;
    if FTopLine.Visible then
      FTopLine.Update;
    FLeftLine.Visible := TGridOption.ColLines in Model.Options;
    if FLeftLine.Visible then
      FLeftLine.Update;
  end
  else
  begin
    FTopLine.Visible := False;
    FLeftLine.Visible := False;
  end;
end;

{$ENDREGION}

{$REGION 'TiOSGridDelegate'}

type
  UIScrollViewDelegate = interface(IObjectiveC)
    ['{8C118307-D2EF-4D90-8B3D-149A0D6AEC12}']
    procedure scrollViewDidScroll(ScrollView: UIScrollView); cdecl;
  end;

  TiOSTableDelegate = class(TOCLocal, UIScrollViewDelegate)
  strict private
    [Weak] FiOSGrid: TiOSGrid;
  public
    constructor Create(const AiOSGrid: TiOSGrid);
    property iOSGrid: TiOSGrid read FiOSGrid;
    procedure scrollViewDidScroll(ScrollView: UIScrollView); cdecl;
  end;

constructor TiOSTableDelegate.Create(const AiOSGrid: TiOSGrid);
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
end;

procedure TiOSTableDelegate.scrollViewDidScroll(ScrollView: UIScrollView);
var
  LFrame: NSRect;
  ViewPortPosition: CGPoint;
begin
  ViewPortPosition.x := -ScrollView.contentOffset.x;
  ViewPortPosition.y := -ScrollView.contentOffset.y;
  iOSGrid.iOSTable.DidScroll(ScrollView);
  if (iOSGrid.iOSHeader <> nil) and not iOSGrid.iOSHeader.View.isHidden then
  begin
    LFrame := iOSGrid.iOSHeader.View.Frame;
    LFrame.origin.x := ViewPortPosition.x;
    iOSGrid.iOSHeader.View.SetFrame(LFrame);
  end;
  iOSGrid.TableScrolled(ViewPortPosition);
end;

{$ENDREGION}
{$REGION 'TiOSEditorDelegate'}
constructor TiOSEditDelegate.Create(const AiOSGrid: TiOSGrid);
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
end;

function TiOSEditDelegate.textField(textField: UITextField; shouldChangeCharactersInRange: NSRange;
  replacementString: NSString): Boolean;
var
  LColumn: TColumn;
begin
  Result := True;
  try
    if (textField.Tag <> 0) and (TObject(Pointer(textField.Tag)) is TColumnItem) then
    begin
      LColumn := TColumnItem(Pointer(textField.Tag)).Column;
      if (LColumn <> nil) and (not LColumn.Released) then
        LColumn.EditorModified
      else
        Result := False;
    end;
  except
    Application.HandleException(FiOSGrid);
  end;
end;

function TiOSEditDelegate.textFieldShouldReturn(textField: UITextField): Boolean;
begin
  Result := not iOSGrid.PerformSelector('EditorReturnDown');
end;

{$ENDREGION}
{$REGION 'TiOSQueue'}

constructor TiOSQueue.Create(const AiOSGrid: TiOSGrid);
begin
  if (AiOSGrid = nil) or (AiOSGrid.Model = nil) then
    raise EArgumentNilException.Create(SArgumentNil);
  inherited Create;
  FiOSGrid := AiOSGrid;
end;

function TiOSQueue.GetObjectiveCClass: PTypeInfo;
begin
  Result := TypeInfo(IiOSQueue);
end;

procedure TiOSQueue.InplaceEditorActivate;
begin
  try
    iOSGrid.InplaceEditorActivate;
  except
    Application.HandleException(iOSGrid);
  end;
end;

procedure TiOSQueue.UpdateContent;
begin
  if (iOSGrid.FContentState = TiOSGrid.TContentState.Changed) then
    try
      iOSGrid.UpdateContent;
    except
      Application.HandleException(iOSGrid);
    end;
end;

procedure TiOSQueue.VKOffsetChanged;
begin
  iOSGrid.FVKOffsetChanging := False;
  iOSGrid.iOSTable.VKOffset := iOSGrid.VirtualKeayboardOffset
end;

procedure TiOSQueue.EditorClick;
begin
  try
    if (iOSGrid <> nil) and (iOSGrid.FInplaceEditor <> nil) then
      iOSGrid.FInplaceEditor.EditorClick;
  except
    Application.HandleException(iOSGrid);
  end;
end;

procedure TiOSQueue.EditorReturnDown;
begin
  if iOSGrid <> nil then
    iOSGrid.EditorReturnDown;
end;

{$ENDREGION}
{$REGION 'TiOSGrid'}

constructor TiOSGrid.Create(const AModel: TDataModel; const AControl: TControl);
var
  Scale: CGFloat;
  LLabel: UILabel;
  TmpTable: UITableView;
begin
  ValidateInheritance(AModel, TGridModel, False);
  inherited Create(AModel, AControl);
  FOldCoord.Clear;
  Scale := MainScreen.Scale;
  if Scale > 0 then
    FDefaultThickness := 1 / Scale
  else
    FDefaultThickness := 1;

  LLabel := TUILabel.Wrap(TUILabel.Alloc.initWithFrame(RectToNSRect(TRect.Create(0, 0, 100, 13))));
  LLabel.setText(StrToNSStr('p|bl'));
  LLabel.sizeToFit;
  FDefaultRowHeight := 2 * TColumn.HorzTextMargin + Ceil(LLabel.bounds.Size.Height);
  LLabel.release;

  FiOSTable := CreateTable;
  FiOSHeader := CreateHeader;

  FiOSEditDelegate := TiOSEditDelegate.Create(Self);
  FiOSQueue := TiOSQueue.Create(Self);
  FiOSTableDelegate := TiOSTableDelegate.Create(Self);
  FiOSTable.View.setDelegate(TiOSTableDelegate(FiOSTableDelegate).GetObjectID);
  View.bringSubviewToFront(FiOSHeader.View);

  TmpTable := TUITableView.Wrap(TUITableView.Create.initWithFrame(View.Frame, UITableViewStylePlain));
  try
    FTintColor := TUIColor.Wrap(TUIColor.OCClass.colorWithCGColor(TmpTable.tintColor.CGColor));
    FTintColor.retain;
    FBkColor := TUIColor.Wrap(TUIColor.OCClass.colorWithCGColor(TmpTable.backgroundColor.CGColor));
    FBkColor.retain;
    FOddColor := TUIColor.Wrap(TUIColor.OCClass.groupTableViewBackgroundColor);
    FOddColor := FOddColor.colorWithAlphaComponent(0.5);
    FOddColor.retain;
    FHighlightColor := TUIColor.Wrap(TUIColor.OCClass.underPageBackgroundColor);
    FHighlightColor := FHighlightColor.colorWithAlphaComponent(0.25);
    FHighlightColor.retain;
    FFocusColor := TUIColor.Wrap(TUIColor.OCClass.underPageBackgroundColor);
    FFocusColor := FFocusColor.colorWithAlphaComponent(0.5);
    FFocusColor.retain;
  finally
    UIView(Super).setBackgroundColor(FBkColor);
    TmpTable := nil;
  end;
  PerformSelector('UpdateContent');
end;

destructor TiOSGrid.Destroy;
begin
  FInplaceEditor := nil;
  if FTintColor <> nil then
    FTintColor.release;
  if FBkColor <> nil then
    FBkColor.release;
  if FOddColor <> nil then
    FOddColor.release;
  if FHighlightColor <> nil then
    FHighlightColor.release;
  if FFocusColor <> nil then
    FFocusColor.release;
  FiOSTable.View.setDelegate(nil);
  FiOSQueue := nil;
  FiOSEditDelegate := nil;
  FiOSTableDelegate := nil;
  FiOSTable := nil;
  FiOSHeader := nil;
  FreeImages;
  inherited;
end;

function TiOSGrid.CreateHeader: TiOSHeader;
begin
  Result := TiOSHeader.Create(Self)
end;

function TiOSGrid.DefineModelClass: TDataModelClass;
begin
  Result := TGridModel;
end;

function TiOSGrid.GetModel: TGridModel;
begin
  Result := inherited GetModel<TGridModel>;
end;

function TiOSGrid.CreateTable: TiOSTable;
begin
  Result := TiOSTable.Create(Self);
end;

function TiOSGrid.GetRowThickness: CGFloat;
begin
  if TGridOption.RowLines in Model.Options then
    Result := FDefaultThickness
  else
    Result := 0;
end;

function TiOSGrid.GetCellClass(const Column: TColumn): TiOSCellControlClass;
begin
  Result := nil;
  if Column is TProgressColumn then
    Result := TiOSCellProgressBar
  else if Column is TCurrencyColumn then
    Result := TiOSCurrencyLabel
  else if Column is TGlyphColumn then
    Result := TiOSCellGlyph
  else if Column is TCheckColumn then
    Result := TiOSCellCheck
  else if Column is TPopupColumn then
    Result := TiOSCellPopupLabel
  else if Column is TImageColumn then
    Result := TiOSCellImage;
end;

function TiOSGrid.GetEditorClass(const Column: TColumn): TiOSCellControlClass;
begin
  Result := nil;
  if Column is TTimeColumn then
    Result := TiOSCellTimePicker
  else if Column is TDateColumn then
    Result := TiOSCellDatePicker
  else if (Column is TCurrencyColumn) or (Column is TProgressColumn) then
    Result := TiOSCurrencyEditor
  else if Column is TCheckColumn then
    Result := TiOSCellCheckEditor
  else if Column is TPopupColumn then
    Result := TiOSCellPopupPicker
  else if Column is TImageColumn then
    Result := TiOSCellImageEditor;
end;

procedure TiOSGrid.CreateImages;
var
  I: TImageKind;
  Bitmap: TBitmap;
begin
  inherited;
  for I := Low(TImageKind) to High(TImageKind) do
    if (FImages[I] = nil) and (I <> TImageKind.Empty) then
    begin
      Bitmap := TCheckColumn.CreateBitmap(Model, I = TImageKind.True, False);
      try
        if Bitmap <> nil then
          FImages[I] := BitmapToUIImage(Bitmap);
      finally
        Bitmap.Free;
      end;
    end;
  FImagesCreated := True;
end;

procedure TiOSGrid.FreeImages;
var
  I: TImageKind;
begin
  for I := Low(TImageKind) to High(TImageKind) do
    if FImages[I] <> nil then
      FImages[I] := nil;
  FImagesCreated := False;
end;

function TiOSGrid.GetImages(const Index: TImageKind): UIImage;
begin
  if not FImagesCreated then
    CreateImages;
  Result := FImages[Index];
end;

function TiOSGrid.GetColumnThickness: CGFloat;
begin
  if TGridOption.ColLines in Model.Options then
    Result := FDefaultThickness
  else
    Result := 0;
end;

function TiOSGrid.CellRect(const ACol, ARow: Integer): NSRect;
var
  LCol: Integer;
  LHeight: CGFloat;
  Item: TColumnItem;
begin
  if (ACol < 0) or (ACol > Model.ColumnCount) then
    raise EArgumentOutOfRangeException.CreateResFmt(@SInvalidColumnIndex, [ACol]);
  if (ARow < 0) or (ARow > Model.RowCount) then
    raise EArgumentOutOfRangeException.CreateResFmt(@SInvalidRowIndex, [ARow]);
  LCol := ACol;
  while (LCol >= 0) and not iOSHeader.HeaderItems.TryGetValue(Model.Columns[LCol], Item) do
    Dec(LCol);
  if LCol >= 0 then
  begin
    Result := Item.Frame;
    if LCol < ACol then
    begin
      Result.origin.x := Result.origin.x + Result.Size.Width;
      Result.Size.Width := 0;
    end
    else
    begin
      if TGridOption.ColLines in Model.Options then
      begin
        Result.Size.Width := Result.Size.Width - DefaultThickness;
        if Item.HiddenFound then
        begin
          Result.Size.Width := Result.Size.Width - DefaultThickness;
          Result.origin.x := Result.origin.x + DefaultThickness;
        end;
      end;
      Result.Size.Width := Max(Result.Size.Width, 0);
    end;
  end
  else
  begin
    Result.Size.Width := 0;
    Result.origin.x := 0;
  end;
  LHeight := iOSTable.RowHeight;
  Result.origin.y := ARow * LHeight;
  Result.Size.Height := Max(0, LHeight - RowThickness);
end;

function TiOSGrid.PaddingRect(const ARect: NSRect; const Column: TColumn): NSRect;
begin
  Result := ARect;
  if Column <> nil then
  begin
    Result.Size.Width := Max(0, Result.Size.Width - Column.Padding.Left - Column.Padding.Right);
    Result.Size.Height := Max(0, Result.Size.Height - Column.Padding.Top - Column.Padding.Bottom);
    Result.origin.x := Result.origin.x + Min(ARect.Size.Width, Column.Padding.Left);
    Result.origin.y := Result.origin.y + Min(ARect.Size.Height, Column.Padding.Top);
  end;
end;

function TiOSGrid.PerformSelector(const Name: string; const Delay: CGFloat): Boolean;
var
  LNSObject: NSObject;
  Chars: packed array [0 .. 255] of Byte;
  I: Integer;
begin
  Result := False;
  if Supports(TiOSQueue(FiOSQueue).Super, NSObject, LNSObject) then
  begin
    FillChar(Chars, SizeOf(Chars), 0);
    for I := 0 to System.Math.Min(Length(Chars) - 1, Length(Name)) do
      Chars[I] := Lo(Word(Name.Chars[I]));
    try
      LNSObject.PerformSelector(sel_getUid(@Chars), GetObjectID, Delay);
      Result := True;
    except
      Application.HandleException(Self);
    end;
  end;
end;

function TiOSGrid.GetEditorRect: NSRect;
begin
  Result := CellRect(Model.Col, Model.Row);
end;

procedure TiOSGrid.MMColumnChanged(var Message: TDispatchMessageWithValue<Integer>);
begin
  if FContentState <> TContentState.Updating then
  begin
    if FContentState = TContentState.Updated then
    begin
      FContentState := TContentState.Changed;
      PerformSelector('UpdateContent');
    end;
    iOSHeader.Update;
    TColumnItem(FiOSHeader.HeaderItems[Message.Value]).Update;
  end;
end;

procedure TiOSGrid.MMContentChanged(var Message: TDispatchMessage);
begin
  if FContentState <> TContentState.Updating then
  begin
    FContentState := TContentState.Changed;
    PerformSelector('UpdateContent');
  end;
end;

procedure TiOSGrid.MMInvalidateCell(var Message: TDispatchMessageWithValue<TGridModel.TCoord>);
var
  LRow: TUITableViewRow;
  LCell: TiOSCell;
begin
  if (iOSTable <> nil) then
  begin
    LRow := iOSTable.Rows[Message.Value.Row];
    if LRow <> nil then
    begin
      LCell := LRow.Cells[Message.Value.Col];
      if LCell <> nil then
        LCell.UpdateValue;
    end;
  end;
end;

procedure TiOSGrid.MMInvalidateContentSize(var Message: TDispatchMessage);
begin
  if FContentState <> TContentState.Updating then
  begin
    FContentState := TContentState.Changed;
    PerformSelector('UpdateContent');
  end;
end;

procedure TiOSGrid.MMSelChanged(var Message: TDispatchMessage);
begin
  try
    if not EditorMode and (TGridOption.AlwaysShowEditor in Model.Options) and CanEdit then
      ShowEditor;
  finally
    UpdateSelection;
  end;
end;

procedure TiOSGrid.PMSetSize(var AMessage: TDispatchMessageWithValue<TSizeF>);
begin
  inherited;
  if FContentState <> TContentState.Updated then
    iOSTable.Update;
end;

procedure TiOSGrid.PMVKDisplacement(var Message: TDispatchMessageWithValue<TGridModel.TVKInfo>);
var
  R: NSRect;
begin
  if (iOSTable <> nil) and (Model <> nil) and (Model.Owner is TControl) then
  begin
    if Message.Value.Shown then
    begin
      R := View.Bounds;
      VirtualKeayboardOffset := R.origin.y + R.Size.Height - Message.Value.AbsoluteRect.Height;
    end
    else
      VirtualKeayboardOffset := 0;
  end;
end;

procedure TiOSGrid.PMScrollToSelect(var Message: TDispatchMessage);
begin
  iOSTable.ScrollToSelectedCell;
end;

procedure TiOSGrid.MMEditorMode(var Message: TDispatchMessageWithValue<Boolean>);
begin
  Message.Value := EditorMode;
end;

procedure TiOSGrid.MMShowEditor(var Message: TDispatchMessage);
begin
  ShowEditor;
end;

procedure TiOSGrid.MMHideEditor(var Message: TDispatchMessageWithValue<Boolean>);
begin
  HideEditor(Message.Value);
end;

function TiOSGrid.CanEdit: Boolean;
var
  ColVisible, RowVisible: Boolean;
begin
  Result := Visible and Model.Enabled and (TGridOption.Editing in Model.Options);
  if Result then
  begin
    ColVisible := (Model.Col >= 0) and (Model.Col < Model.ColumnCount) and Model.Columns[Model.Col].Visible and
      (Model.Columns[Model.Col].Width > 0);
    RowVisible := (Model.Row >= 0) and (Model.Row < Model.RowCount);
    Result := ColVisible and RowVisible and Model.Columns[Model.Col].Enabled and Model.Columns[Model.Col].CanEdit;
  end;
end;

function TiOSGrid.RefreshEditor(const RefreshAppearance, RefreshValue: Boolean): Boolean;
var
  LValue: TValue;
begin
  Result := False;
  if (FInplaceEditor <> nil) and (Model.Row >= 0) and (Model.Row < Model.RowCount) and (Model.Col >= 0) and
    (Model.Col < Model.ColumnCount) then
  begin
    if RefreshAppearance then
    begin
      FInplaceEditor.Update;
      Result := True;
    end;
    if RefreshValue then
    begin
      LValue := Model.GetValue(Model.Col, Model.Row, False);
      FInplaceEditor.InternalCell.Data := LValue;
      Result := Model.Columns[Model.Col].RefreshEditor(nil, LValue);
    end;
  end;
end;

procedure TiOSGrid.SetVirtualKeayboardOffset(const Value: CGFloat);
begin
  if not SameValue(FVirtualKeayboardOffset, Value, TEpsilon.FontSize) then
  begin
    FVirtualKeayboardOffset := Value;
    if not FVKOffsetChanging then
    begin
      FVKOffsetChanging := True;
      PerformSelector('VKOffsetChanged');
    end;
  end;
end;

procedure TiOSGrid.ShowEditor;
begin
  if not FEditorMode and (iOSTable <> nil) and (Model <> nil) and (Model.Owner is TControl) and CanEdit and
    not TControl(Model.Owner).Released then
  begin
    try
      FEditorResult := TEditorResult.Success;
      FInplaceEditor := TiOSInplaceEditor.Create(Self, iOSTable.View, Model.Columns[Model.Col]);
      FEditorMode := RefreshEditor(True, True);
      if FEditorMode then
        InplaceEditorActivate
      else
        FInplaceEditor := nil;
    except
      FInplaceEditor := nil;
      FEditorMode := False;
      raise;
    end;
  end;
end;

procedure TiOSGrid.TableScrolled(const ViewPortPosition: CGPoint);
begin

end;

function TiOSGrid.EditingDone(const Accept: Boolean): Boolean;
var
  Editing: Boolean;
  LValue: TValue;
  DialogSvc: IFMXDialogService;
begin
  Result := False;
  FEditorResult := TEditorResult.Success;
  LValue := TValue.Empty;
  Editing := (TGridOption.Editing in Model.Options) and not Model.Columns[Model.Col].ReadOnly;
  try
    if Accept and Editing then
      LValue := FInplaceEditor.InternalCell.Data;
  except
    on E: EAbort do
    begin
      Editing := False;
      FEditorResult := TEditorResult.Cancel;
    end;
    on E: Exception do
    begin
      Editing := False;
      FEditorResult := TEditorResult.Error;
      if FEditorResult = TEditorResult.Error then
      begin
        if TPlatformServices.Current.SupportsPlatformService(IFMXDialogService, DialogSvc) then
        begin
          if DialogSvc.MessageDialog(Translate(E.Message), TMsgDlgType.mtError, [TMsgDlgBtn.mbOk, TMsgDlgBtn.mbCancel],
            TMsgDlgBtn.mbOk, 0, 0, 0, '') = mrCancel then
            FEditorResult := TEditorResult.Cancel;
        end
        else
          Application.ShowException(E);
      end;
    end;
  end;
  try
    Result := Model.Columns[Model.Col].EditingDone(nil, LValue, Accept and Editing);
  except
    FEditorResult := TEditorResult.Error;
    Application.HandleException(Self);
  end;
end;

procedure TiOSGrid.EditorReturnDown;
  procedure SelectNextCell(const ACol, ARow: Integer; const AEditorMode: Boolean);
  begin
    Model.SelectCell(ACol, ARow);
    iOSTable.ScrollToSelectedCell(False);
    if AEditorMode then
      ShowEditor;
  end;

var
  LCol, LRow: Integer;
  LEditorMode: Boolean;
begin
  LCol := Model.Col;
  LRow := Model.Row;
  LEditorMode := EditorMode;
  try
    if EditorMode then
    begin
      HideEditor(True);
      if EditorMode then
        Exit;
    end;
    if EditorResult = TEditorResult.Error then
      SelectNextCell(LCol, LRow, LEditorMode)
    else if Model.CellReturnAction = TCellReturnAction.None then
      SelectNextCell(LCol, LRow, (TGridOption.AlwaysShowEditor in Model.Options))
    else
    begin
      LEditorMode := LEditorMode or (TGridOption.AlwaysShowEditor in Model.Options);
      if Model.FindNextCell(False, Model.CellReturnAction = TCellReturnAction.GotoNextRow, LEditorMode, LCol, LRow) then
        SelectNextCell(LCol, LRow, LEditorMode);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TiOSGrid.HideEditor(const Accept: Boolean);
var
  LRow: TUITableViewRow;
  LCell: TiOSCell;
  R, C: Integer;
begin
  LCell := nil;
  LRow := nil;
  try
    if FEditorMode and (FInplaceEditor <> nil) then
    begin
      R := Model.Row;
      C := Model.Col;
      FInplaceEditor.Deactivate;
      EditingDone(Accept);
      LRow := iOSTable.Rows[R];
      if LRow <> nil then
        LCell := LRow.Cells[C];
    end;
  finally
    if FEditorResult <> TEditorResult.Error then
    begin
      FEditorMode := False;
      FInplaceEditor := nil;
      if LCell <> nil then
        LCell.UpdateValue;
    end
    else
    begin
      if FInplaceEditor <> nil then
        PerformSelector('InplaceEditorActivate', 0.5);
    end;
  end;
end;

procedure TiOSGrid.InplaceEditorActivate;
begin
  iOSTable.ScrollToSelectedCell;
  if FInplaceEditor <> nil then
    FInplaceEditor.Activate;
end;

procedure TiOSGrid.UpdateContent;
var
  R: NSRect;
begin
  if FContentState <> TContentState.Updating then
  begin
    FContentState := TContentState.Updating;
    try
      R := View.Frame;
      if (R.Size.Width > 0) and (R.Size.Height > 0) and (iOSTable <> nil) and (iOSHeader <> nil) then
      begin
        iOSHeader.Update;
        iOSTable.Update;
        iOSTable.UpdateVisibleRows;
        UpdateSelection;
      end;
    finally
      FContentState := TContentState.Updated;
    end;
  end;
end;

procedure TiOSGrid.UpdateSelection;
  procedure UpdateCell(const Coord: TGridModel.TCoord);
  var
    LRow: TUITableViewRow;
    LCell: TiOSCell;
  begin
    LRow := iOSTable.Rows[Coord.Row];
    if LRow <> nil then
    begin
      if TGridOption.RowSelect in Model.Options then
        LRow.Update;
      LCell := LRow.Cells[Coord.Col];
      if LCell <> nil then
        LCell.Update;
    end;
  end;

begin
  UpdateCell(FOldCoord);
  FOldCoord.Col := Model.Col;
  FOldCoord.Row := Model.Row;
  UpdateCell(FOldCoord);
end;

{$ENDREGION}

initialization

TPresentationProxyFactory.Current.Register(TCustomGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);
TPresentationProxyFactory.Current.Register(TGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);
TPresentationProxyFactory.Current.Register(TStringGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);

finalization

TPresentationProxyFactory.Current.Unregister(TStringGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);
TPresentationProxyFactory.Current.Unregister(TGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);
TPresentationProxyFactory.Current.Unregister(TCustomGrid, TControlType.Platform, TiOSPresentationProxy<TiOSGrid>);
{$ELSE}
  implementation
{$ENDIF}

end.