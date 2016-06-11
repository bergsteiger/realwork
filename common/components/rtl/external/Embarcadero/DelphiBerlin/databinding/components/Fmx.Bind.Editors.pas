{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Fmx.Bind.Editors;

interface

uses
  System.Classes, System.Bindings.EvalProtocol, Data.Bind.Components, Data.Bind.Editors, System.Bindings.ObjEval,
    FMX.ListBox, FMX.ListView, FMX.ListView.Adapters.Base, FMX.ListView.Appearances, FMX.Grid, FMX.Controls, FMX.Types,
    FMX.Memo, FMX.StdCtrls, System.RTTI, FMX.Graphics, Generics.Collections, System.SysUtils, Data.Bind.ObjectScope,
    System.UITypes, FMX.DateTimeCtrls, FMX.ComboEdit;

type
  TBindStateCheckBoxEditor = class(TBindCheckBoxEditor)
  private
    FCheckBox: TCheckBox;
  public
    constructor Create(ACheckBox: TCheckBox);
    function GetState: TBindCheckBoxState; override;
    procedure SetState(Value: TBindCheckBoxState); override;
    function GetAllowGrayed: Boolean; override;
    procedure SetAllowGrayed(Value: Boolean); override;
  end;

  TBindEmptyDateTimeEditEditor = class (TBindDateTimeEditEditor)
  private
    FCustomDateTimeEdit: TCustomDateTimeEdit;
  public
    constructor Create(ADateTimeEdit: TCustomDateTimeEdit);
    function GetIsEmpty: Boolean; override;
    procedure SetIsEmpty(Value: Boolean); override;
    function GetDateTime: TDateTime; override;
    procedure SetDateTime(ADateTime: TDateTime); override;
  end;

  TBindListLookupEditorImpl = class(TBindListLookupEditor)
  strict private
    FLookupDictionary: TDictionary<TListBoxItem, TValue>;
    function FindLookupValue(const AValue: TValue): TListBoxItem;
    function SameValue(const AValue1, AValue2: TValue): Boolean;
  protected
    procedure ListCleared;
    procedure ItemRemoved(AListItem: TListBoxItem);

    // List accessors
    function GetSelected: TListBoxItem; virtual; abstract;
    function ListCount: Integer; virtual; abstract;
    function GetListItem(I: Integer): TListBoxItem; virtual; abstract;
    procedure SetSelected(AListItem: TListBoxItem); virtual; abstract;
    { IBindListLookup }
    function GetLookupValue(const AScope: IScope): TValue; override;
    procedure SetLookupValue(const AScope: IScope; const AValue: TValue); override;
    function GetSelectedLookupValue: TValue; override;
    procedure SetSelectedLookupValue(const AValue: TValue); override;
  public
    destructor Destroy; override;
  end;


  TFmxObjectEditorObject = class
  private
    function GetData: TValue;
    function GetIndex: Integer;
    function GetParent: TFmxObject;
    function GetTagFloat: Single;
    function GetTagObject: TObject;
    function GetTagString: string;
    procedure SetData(const Value: TValue);
    procedure SetIndex(const Value: Integer);
    procedure SetParent(const Value: TFmxObject);
    procedure SetTagFloat(const Value: Single);
    procedure SetTagObject(const Value: TObject);
    procedure SetTagString(const Value: string);
  protected
    function CheckRange: Boolean; virtual; abstract;
    function CurrentFmxObject: TFmxObject; virtual; abstract;
  public
    function FindStyleResource(const AStyleLookup: string): TFmxObject;
    property TagObject: TObject read GetTagObject write SetTagObject;
    property TagFloat: Single read GetTagFloat write SetTagFloat;
    property TagString: string read GetTagString write SetTagString;
    property Data: TValue read GetData write SetData;
    property Parent: TFmxObject read GetParent write SetParent;
    property Index: Integer read GetIndex write SetIndex;
  end;

  TControlEditorObject = class(TFmxObjectEditorObject)
  private
    function GetAlign: TAlignLayout;
    function GetClipChildren: Boolean;
    function GetClipParent: Boolean;
    function GetDragMode: TDragMode;
    function GetEnabled: Boolean;
    function GetEnableDragHighlight: Boolean;
    function GetHeight: Single;
    function GetHitTest: Boolean;
    function GetLocked: Boolean;
    function GetMargins: TBounds;
    function GetOpacity: Single;
    function GetPadding: TBounds;
    function GetPopupMenu: TCustomPopupMenu;
    function GetPosition: TPosition;
    function GetRotationAngle: Single;
    function GetRotationCenter: TPosition;
    function GetScale: TPosition;
    function GetTabOrder: TTabOrder;
    function GetVisible: Boolean;
    function GetWidth: Single;
    procedure SetAlign(const Value: TAlignLayout);
    procedure SetClipChildren(const Value: Boolean);
    procedure SetClipParent(const Value: Boolean);
    procedure SetDragMode(const Value: TDragMode);
    procedure SetEnabled(const Value: Boolean);
    procedure SetEnableDragHighlight(const Value: Boolean);
    procedure SetHeight(const Value: Single);
    procedure SetHitTest(const Value: Boolean);
    procedure SetLocked(const Value: Boolean);
    procedure SetMargins(const Value: TBounds);
    procedure SetOpacity(const Value: Single);
    procedure SetPadding(const Value: TBounds);
    procedure SetPopupMenu(const Value: TCustomPopupMenu);
    procedure SetPosition(const Value: TPosition);
    procedure SetRotationAngle(const Value: Single);
    procedure SetScale(const Value: TPosition);
    procedure SetTabOrder(const Value: TTabOrder);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Single);
    procedure SetRotationCenter(const Value: TPosition);
  protected
    function CurrentControl: TControl; virtual; abstract;
    function CurrentFmxObject: TFmxObject; override;
  public
    property Align: TAlignLayout read GetAlign write SetAlign;
    property DragMode: TDragMode read GetDragMode write SetDragMode;
    property EnableDragHighlight: Boolean read GetEnableDragHighlight write SetEnableDragHighlight;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Position: TPosition read GetPosition write SetPosition;
    property RotationAngle: Single read GetRotationAngle write SetRotationAngle;
    property RotationCenter: TPosition read GetRotationCenter write SetRotationCenter;
    property Locked: Boolean read GetLocked write SetLocked;
    property Width: Single read GetWidth write SetWidth;
    property Height: Single read GetHeight write SetHeight;
    property Margins: TBounds read GetMargins write SetMargins;
    property Padding: TBounds read GetPadding write SetPadding;
    property Opacity: Single read GetOpacity write SetOpacity;
    property ClipChildren: Boolean read GetClipChildren write SetClipChildren;
    property ClipParent: Boolean read GetClipParent write SetClipParent;
    property HitTest: Boolean read GetHitTest write SetHitTest default True;
    property PopupMenu: TCustomPopupMenu read GetPopupMenu write SetPopupMenu;
    property Scale: TPosition read GetScale write SetScale;
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder;
    property Visible: Boolean read GetVisible write SetVisible;
  end;

  TStyledControlEditorObject = class(TControlEditorObject)
  private
    function GetAutoTranslate: Boolean;
    function GetHelpContext: THelpContext;
    function GetHelpKeyword: string;
    function GetHelpType: THelpType;
    function GetStyleLookup: string;
    function GetStyleData(const Index: string): TValue;
    procedure SetHelpContext(const Value: THelpContext);
    procedure SetHelpKeyword(const Value: string);
    procedure SetHelpType(const Value: THelpType);
    procedure SetStyleLookup(const Value: string);
    procedure SetStyleData(const Index: string; const Value: TValue);
    procedure SetAutoTranslate(const Value: Boolean);
  protected
    function CurrentStyledControl: TStyledControl; virtual; abstract;
    function CurrentControl: TControl; override;
  public
    property AutoTranslate: Boolean read GetAutoTranslate write SetAutoTranslate;
    property HelpType: THelpType read GetHelpType write SetHelpType;
    property HelpKeyword: string read GetHelpKeyword write SetHelpKeyword;
    property HelpContext: THelpContext read GetHelpContext write SetHelpContext;
    property StyleLookup: string read GetStyleLookup write SetStyleLookup;
    property StylesData[const Index: string]: TValue read GetStyleData write SetStyleData;
  end;

  TTextControlEditorObject = class(TStyledControlEditorObject)
  private
    function GetFont: TFont;
    function GetFontColor: TAlphaColor;
    function GetText: string; virtual;
    function GetTextAlign: TTextAlign;
    function GetVertTextAlign: TTextAlign;
    function GetWordWrap: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetFontColor(const Value: TAlphaColor);
    procedure SetText(const Value: string); virtual;
    procedure SetTextAlign(const Value: TTextAlign);
    procedure SetVertTextAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
  protected
    function CurrentTextControl: TTextControl; virtual; abstract;
    function CurrentStyledControl: TStyledControl; override;
  public
    property Font: TFont read GetFont write SetFont;
    property FontColor: TAlphaColor read GetFontColor write SetFontColor;
    property Text: string read GetText write SetText;
    property VertTextAlign: TTextAlign read GetVertTextAlign write SetVertTextAlign;
    property TextAlign: TTextAlign read GetTextAlign write SetTextAlign;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap;
  end;

  TBindListListItemEditorObject = class;

  TBindListBoxItemData = class
  private
    FEditorObject: TBindListListItemEditorObject;
    function GetAccessory: TValue;
    function GetBitmap: TBitmap;
    function GetDetail: string;
    function GetText: string;
    procedure SetAccessory(const Value: TValue);
    procedure SetBitmap(const Value: TBitmap);
    procedure SetDetail(const Value: string);
    procedure SetText(const Value: string);
  public
    constructor Create(AEditorObject: TBindListListItemEditorObject);
    property Text: string read GetText write SetText;
    property Detail: string read GetDetail write SetDetail;
    property Accessory: TValue read GetAccessory write SetAccessory;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
  end;

  TBindListListItemEditorObject = class(TTextControlEditorObject)
  private
    FItemIndex: Integer;
    FListBoxItemData: TBindListBoxItemData;
    function GetIsChecked: Boolean;
    function GetIsSelected: Boolean;
    procedure SetIsChecked(const Value: Boolean);
    procedure SetIsSelected(const Value: Boolean);
    function GetData: TObject;
    procedure SetData(const Value: TObject);
    function GetItemData: TBindListBoxItemData;
    function GetImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);
  protected
    function CurrentTextControl: TTextControl; override;
    function CurrentItem: TListBoxItem; virtual; abstract;
  public
    destructor Destroy; override;
    property Data: TObject read GetData write SetData;
    property IsChecked: Boolean read GetIsChecked write SetIsChecked;
    property IsSelected: Boolean read GetIsSelected write SetIsSelected;
    /// <summary>Bind to the imageindex of the current list box item</summary>
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property ItemData: TBindListBoxItemData read GetItemData;
  end;

  TBindListListBoxEditorObject = class(TBindListListItemEditorObject)
  private
    FListBox: TCustomListBox;
  protected
    function CurrentItem: TListBoxItem; override;
    function CheckRange: Boolean; override;
  end;


  TBindListViewLookupEditorImpl = class(TBindListLookupEditor)
  protected type
    TLookupKey = Integer;
  strict private
    FCurrentKey: TLookupKey;
    FLookupDictionary: TDictionary<TLookupKey, TValue>;
    function FindLookupValue(const AValue: TValue): TLookupKey;
    function SameValue(const AValue1, AValue2: TValue): Boolean;
  protected
    function NextKey: Integer;
    procedure ListCleared;
    procedure ItemRemoved(AListItem: TLookupKey);

    // List accessors
    function GetLookupKey(AListItemObject: TObject): TLookupKey; virtual; abstract;
    function GetSelected: TLookupKey; virtual; abstract;
    function ListCount: Integer; virtual; abstract;
    function GetListItem(I: Integer): TLookupKey; virtual; abstract;
    procedure SetSelected(ALookupKey: TLookupKey); virtual; abstract;
    { IBindListLookup }
    function GetLookupValue(const AScope: IScope): TValue; override;
    procedure SetLookupValue(const AScope: IScope; const AValue: TValue); override;
    function GetSelectedLookupValue: TValue; override;
    procedure SetSelectedLookupValue(const AValue: TValue); override;

  public
    destructor Destroy; override;
  end;

  TListViewItemEditorObject = class;

  TBindListViewEditor = class(TBindListViewLookupEditorImpl, IBindFillControlMembers,
    IBindListGroupEditor, IBindListSynchEditor, IBindListEditorEvalShortcut)
  private type
    TLookupKey = TBindListViewLookupEditorImpl.TLookupKey;
  private
    FUpdateCounter: Integer;
    FEditorObject: TListViewItemEditorObject;
    FApplyFilter: Boolean;
    function IsFiltered: Boolean;
    function IsGrouped: Boolean;
    { IBindListEditorEvalShortcut }
    procedure SetCurrentValue(const AMemberName: string; const AValue: TValue; AType: TScopeMemberType);
    function CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
  protected
    function RefreshNeeded(ARecordEnumerator: IScopeRecordEnumerator): Boolean; override;
    // List accessors
    function GetLookupKey(
      AListItemObject: TObject): TLookupKey; override;
    function GetSelected: TLookupKey; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TLookupKey; override;
    procedure SetSelected(ALookupKey: TLookupKey); override;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;
    procedure GetHeaderMemberNames(ANames: TStrings); override;
    function GetHeaderMemberNameExpression(const AName: string): string; override;
    function CurrentHeaderItem: IScope; override;
    function CurrentIndex: Integer; override;
    function CurrentObject: TObject; override;
    { IBindListSynchEditor }
    function GetSynchIndex: Integer;
    procedure SetSynchIndex(AIndex: Integer);
    procedure ApplyFilter;
    { IBindListItemIndexEditor }
    function GetItemIndex: Integer; override;
    procedure SetItemIndex(AIndex: Integer); override;

    function GetPositionGetter(var AGetter: string;
      var ABase: Integer): Boolean; override;
    function GetPositionSetter(var ASetter: string;
      var ABase: Integer): Boolean; override;
  public
    constructor Create(AListView: TCustomListView);
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddItem(Select: Boolean): IScope; override;
    function AddHeader: IScope; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function CurrentItem: IScope; override;
    function GetRowCount: Integer; override;
    function MoveNext: Boolean; override;
    procedure DeleteToEnd; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
  end;

  TItemIndexType = (Active, Unfiltered);

  TListViewItemEditorObject = class
  strict private
    FItemIndex: Integer;
    FIndexType: TItemIndexType;
  private
    FListView: TCustomListView;
    function GetOwner: TCustomListView;
    procedure SetText(const Value: string);
    function GetText: string;
    function CurrentItem: TListViewItem;
    function GetTag: NativeInt;
    procedure SetTag(Value: NativeInt);
    function CheckRange: Boolean;
    function GetBitmap: TBitmap;
    function GetDetail: string;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetDetail(const Value: string);
    function GetButtonText: string;
    procedure SetButtonText(const Value: string);
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    function GetData(const AIndex: string): TValue;
    procedure SetData(const AIndex: string; const Value: TValue);
    procedure SetItemIndex(AIndex: Integer; AIndexType: TItemIndexType = TItemIndexType.Active);
    function GetItemIndex: Integer;
    function GetImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);
  public
    property Text: string read GetText write SetText;
    property Detail: string read GetDetail write SetDetail;
    property ButtonText: string read GetButtonText write SetButtonText;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property Owner: TCustomListView read GetOwner;
    property Checked: Boolean read GetChecked write SetChecked;
    property Item: TListViewItem read CurrentItem;
    /// <summary>Bind to the imageindex of the current list view item</summary>
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property Data[const AIndex: string]: TValue read GetData write SetData;
    property Tag: NativeInt read GetTag write SetTag;
  end;

  TBindListMetroListBoxEditorObject = class(TBindListListBoxEditorObject)
  private
    function GetDescription: String;
    function GetIcon: TBitmap;
    function GetIconSize: Integer;
    function GetSubTitle: String;
    function GetTitle: String;
    procedure SetDescription(const Value: String);
    procedure SetIcon(const Value: TBitmap);
    procedure SetIconSize(const Value: Integer);
    procedure SetSubTitle(const Value: String);
    procedure SetTitle(const Value: String);
    function GetText: string; override;          // Provide value Text property for binding
    procedure SetText(const Value: string); override;  // Provide value Text property for binding
  protected
    function CurrentItem: TMetropolisUIListBoxItem; reintroduce;
  public
    property Title: String read GetTitle write SetTitle;
    property SubTitle: String read GetSubTitle write SetSubTitle;
    property Description: String read GetDescription write SetDescription;
    property Icon: TBitmap read GetIcon write SetIcon;
    property IconSize: Integer read GetIconSize write SetIconSize;

  end;

  TBindListComboBoxEditorObject = class(TBindListListItemEditorObject)
  private
    FComboBox: TCustomComboBox;
  protected
    function CurrentItem: TListBoxItem; override;
    function CheckRange: Boolean; override;
  end;


  TBindListMetroComboBoxEditorObject = class(TBindListComboBoxEditorObject)
  private
    function GetDescription: String;
    function GetIcon: TBitmap;
    function GetIconSize: Integer;
    function GetSubTitle: String;
    function GetTitle: String;
    procedure SetDescription(const Value: String);
    procedure SetIcon(const Value: TBitmap);
    procedure SetIconSize(const Value: Integer);
    procedure SetSubTitle(const Value: String);
    procedure SetTitle(const Value: String);
  protected
    function CurrentItem: TMetropolisUIListBoxItem; reintroduce;
  public
    property Title: String read GetTitle write SetTitle;
    property SubTitle: String read GetSubTitle write SetSubTitle;
    property Description: String read GetDescription write SetDescription;
    property Icon: TBitmap read GetIcon write SetIcon;
    property IconSize: Integer read GetIconSize write SetIconSize;
  end;



  TBindListListBoxEditor = class(TBindListLookupEditorImpl, IBindFillControlMembers,
    IBindListGroupEditor, IBindListEditorEvalShortcut)
  private
    FEditorObject: TBindListListBoxEditorObject;
    FUpdateCounter: Integer;
    { IBindListEditorEvalShortcut }
    procedure SetCurrentValue(const AMemberName: string; const AValue: TValue; AType: TScopeMemberType);
    function CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
  protected
    function GetSelected: TListBoxItem; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TListBoxItem; override;
    procedure SetSelected(AListItem: TListBoxItem); override;
    function CreateItem: TListBoxItem; virtual;
    function CreateEditorObject: TBindListListBoxEditorObject; virtual;
    { IBindListItemIndexEditor }
    function GetItemIndex: Integer; override;
    procedure SetItemIndex(AIndex: Integer); override;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;
    procedure GetHeaderMemberNames(ANames: TStrings); override;
    function GetHeaderMemberNameExpression(const AName: string): string; override;
    function CurrentHeaderItem: IScope; override;
  public
    constructor Create(AListBox: TCustomListBox);
    destructor Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure DeleteToEnd; override;
    function AddItem(Select: Boolean): IScope; override;
    function AddHeader: IScope; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function MoveNext: Boolean; override;
    function GetRowCount: Integer; override;
    function CurrentItem: IScope; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
    function GetSelectedItem: TObject; override;

    function CurrentObject: TObject; override;
    function CurrentIndex: Integer; override;
  end;

  TBindListMetroListBoxEditor = class(TBindListListBoxEditor)
  protected
    function CreateItem: TListBoxItem; override;
    function CreateEditorObject: TBindListListBoxEditorObject; override;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;
  end;

  TBindListItemDataListBoxEditor = class(TBindListListBoxEditor)
  private
  protected
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
  end;

  TBindListComboBoxEditor = class(TBindListLookupEditorImpl, IBindFillControlMembers, IBindListEditorEvalShortcut)
  private
    FEditorObject: TBindListComboBoxEditorObject;
    FUpdateCounter: Integer;
    { IBindListEditorEvalShortcut }
    procedure SetCurrentValue(const AMemberName: string; const AValue: TValue; AType: TScopeMemberType);
    function CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
  protected
    function CreateItem: TListBoxItem; virtual;
    function CreateEditorObject: TBindListComboBoxEditorObject; virtual;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure DeleteToEnd; override;
    function AddItem(Select: Boolean): IScope; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function MoveNext: Boolean; override;
    function GetRowCount: Integer; override;
    function CurrentItem: IScope; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    function GetSelectedItem: TObject; override;
    procedure SetSelectedText(const AValue: string); override;
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;
    { IBindListItemIndexEditor }
    function GetItemIndex: Integer; override;
    procedure SetItemIndex(AIndex: Integer); override;

    function CurrentObject: TObject; override;
    function CurrentIndex: Integer; override;

  protected
    function GetSelected: TListBoxItem; override;
    function ListCount: Integer; override;
    function GetListItem(I: Integer): TListBoxItem; override;
    procedure SetSelected(AListItem: TListBoxItem); override;
  public
    constructor Create(AComboBox: TCustomComboBox);
    destructor Destroy; override;
  end;

  TBindListMetroComboBoxEditor = class(TBindListComboBoxEditor)
  protected
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
    function GetItemMemberNameExpression(const AName: string): string; override;

    function CreateItem: TListBoxItem; override;
    function CreateEditorObject: TBindListComboBoxEditorObject; override;
  end;

  TBindListItemDataComboBoxEditor = class(TBindListComboBoxEditor)
  protected
    { IBindFillControlMembers }
    procedure GetItemMemberNames(ANames: TStrings); override;
  end;

  TBaseListBoxItemEditorObject = class
  protected
    FIndex: Integer;
    function GetControlItems: TStrings; virtual; abstract;
    function GetControlItemIndex: Integer; virtual; abstract;
    procedure SetControlItemIndex(AIndex: Integer); virtual; abstract;
    procedure ControlClear; virtual; abstract;
  public
    property ControlItems: TStrings read GetControlItems;
    property ControlItemIndex: Integer read GetControlItemIndex write SetControlItemIndex;
  end;


  TStringGridItemEditorObject = class
  private
    FStringGrid: TStringGrid;
    FIndex: Integer;
    function GetOwner: TStringGrid;
    function GetCells(ACol: Integer): string;
    procedure SetCells(ACol: Integer; const Value: string);
  public
    property Owner: TStringGrid read GetOwner;
    property Cells[ACol: Integer]: string read GetCells write SetCells;
  end;

  TGridItemEditorObject = class
  private
    [Weak] FGrid: TCustomGrid;
    function GetOwner: TCustomGrid;
  public
    property Owner: TCustomGrid read GetOwner;
  end;

  TBindListStringGridEditor = class(TBindGridEditor, IBindListEditorEvalShortcut)
  private
    FUpdateCounter: Integer;
    FEditorObject: TStringGridItemEditorObject;
    function GetRowIndex: Integer; inline;
    function GetColumnIndex: Integer; inline;
    { IBindListEditorEvalShortcut }
    procedure SetCurrentValue(const AMemberName: string; const AValue: TValue; AType: TScopeMemberType);
    function CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
  protected
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function AddItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CurrentItem: IScope; override;
    function GetRowCount: Integer; override;
    function MoveNext: Boolean; override;
    procedure DeleteToEnd; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
    procedure GetColumnIndices(ANames: TStrings); override;
    procedure GetColumnNames(ANames: TStrings); override;
    function GetPositionGetter(var AGetter: string;
      var ABase: Integer): Boolean; override;
    function GetPositionSetter(var ASetter: string;
      var ABase: Integer): Boolean; override;
    { IBindListItemIndexEditor }
    function GetItemIndex: Integer; override;
    procedure SetItemIndex(AIndex: Integer); override;

    function CurrentObject: TObject; override;
    function CurrentIndex: Integer; override;

  public
    constructor Create(AGrid: TStringGrid);
    destructor Destroy; override;
  end;

  TValueCache = class
  private
    FRow: Integer;
    FValues: TDictionary<Integer, TValue>;
  public
    constructor Create;
    procedure Clear; overload;
    procedure Clear(AColumn: Integer); overload;
    procedure Add(AColumn, ARow: Integer; const AValue: TValue);
    function TryGet(AColumn, ARow: Integer; out AValue: TValue): Boolean;
    function Get(AColumn: Integer): TValue;
    destructor Destroy; override;
  end;

  TBindListGridEditor = class(TBindListEditorCommon, IBindListVirtualEditor, IBindGridEditor,
    IBindListVirtualEditorScope)
  private
    FValues: TValueCache;
    FEditorObject: TGridItemEditorObject;
    FBindGridCallbackEvaluateFormat: TBindGridOnCallbackEvaluateFormat;
    FColumnDataObjects: TDictionary<Integer, TObject>;
    function GetRowIndex: Integer; inline;
    function GetColumnIndex: Integer; inline;
    procedure GridOnCallbackGetValue(Sender: TObject; const Col, Row: Integer;
      ACallback: TProc<TValue>);
    procedure GridOnSetValue(Sender: TObject; const Col, Row: Integer;
      const Value: TValue);
  protected
    function GetPositionGetter(var AGetter: string;
      var ABase: Integer): Boolean; override;
    function GetPositionSetter(var ASetter: string;
      var ABase: Integer): Boolean; override;
    { IBindListVirtualEditor }
    procedure SetRowCount(AValue: Integer);
    procedure SetOnCallbackEvaluateFormat(AOnCallbackEvaluateFormat: TBindGridOnCallbackEvaluateFormat);
    procedure UpdateCell(Col: Integer);
    { IBindListVirtualEditorScope }
    function CanCache: Boolean;

    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function GetRowCount: Integer; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure GetColumnNames(ANames: TStrings);
    procedure GetColumnIndices(ANames: TStrings);
  public
    constructor Create(AGrid: TCustomGrid);
    destructor Destroy; override;
  end;


implementation

uses System.Math, FMX.Edit, System.Types, FMX.Utils,
  FMX.ListView.Types, FMX.Calendar, FMX.CalendarEdit,
  FMX.Consts, // expand inline
  FMX.Colors, // to register properties
  FMX.Objects, FMX.ExtCtrls, // to register properties
  FMX.SpinBox, FMX.NumberBox // to register properties
  ;


type
  TBindCheckBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindListBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindMetroListBoxEditorFactory = class(TBindListBoxEditorFactory)
  public
    function HasNamedEditor(const AName: string): Boolean; override;
    function GetNames: TArray<string>; override;
    function CreateNamedEditor(AIntf: TGuid; const AName: string;
      AObject: TObject): IInterface; override;
  end;

  TBindComboBoxEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindListViewEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindMetroComboBoxEditorFactory = class(TBindComboBoxEditorFactory)
  public
    function HasNamedEditor(const AName: string): Boolean; override;
    function GetNames: TArray<string>; override;
    function CreateNamedEditor(AIntf: TGuid; const AName: string;
      AObject: TObject): IInterface; override;
  end;


  TBindComboEditEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindStringGridEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

  TBindGridEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
    function ReleaseEditor(const AEditor: IInterface): Boolean; override;
  end;

  TComboEditItemEditorObject = class(TBaseListBoxItemEditorObject)
  private
    FListBox: TComboEdit;
    function GetOwner: TComboEdit;
    procedure SetText(const Value: string);
    function GetText: string;
  protected
    function GetControlItems: TStrings; override;
    function GetControlItemIndex: Integer; override;
    procedure SetControlItemIndex(AIndex: Integer); override;
    procedure ControlClear; override;
  public
    constructor Create(AListBox: TComboEdit);
    property Text: string read GetText write SetText;
    property Owner: TComboEdit read GetOwner;
  end;

  TBindListComboEditEditor = class(TBindListEditor)
  private
    FUpdateCounter: Integer;
    FEditorObject: TBaseListBoxItemEditorObject;
  protected
    function CreateItemsEditor(
      AControl: TControl): TBaseListBoxItemEditorObject; virtual;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure DeleteToEnd; override;
    function AddItem(Select: Boolean): IScope; override;
    function InsertItem(Select: Boolean): IScope; override;
    function CanInsertItem: Boolean; override;
    function MoveNext: Boolean; override;
    function GetRowCount: Integer; override;
    function CurrentItem: IScope; override;
    procedure ClearList; override;
    function GetSelectedText: string; override;
    procedure SetSelectedText(const AValue: string); override;
    { IBindListItemIndexEditor }
    function GetItemIndex: Integer; override;
    procedure SetItemIndex(AIndex: Integer); override;

    //function CurrentObject: TObject; override;
    function CurrentIndex: Integer; override;
    //function CurrentValue: TValue; override;
  public
    constructor Create(AComboBox: TComboEdit);
    destructor Destroy; override;
  end;

  TBindDateTimeEditEditorFactory = class(TBindEditorFactory)
  public
    constructor Create; override;
    function Supports(AIntf: TGuid; AObject: TObject): Boolean; override;
    function CreateEditor(AIntf: TGuid;
      AObject: TObject): IInterface; override;
  end;

var
  GEditors: TEditors; // TDictionary<TObject, TObject>;


const
  sMetroEditor = 'MetropolisUI';
  sItemDataEditor = 'ItemDataEditor';


{ TBindListLookupEditorImpl }

function TBindListLookupEditorImpl.GetLookupValue(const AScope: IScope): TValue;
var
  LItem: TListBoxItem;
  LPlaceHolder: IPlaceHolder;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LItem := LPlaceHolder.Attachment as TListBoxItem
  else
    LItem := nil;
  Assert(LItem <> nil);
  Result := TValue.Empty;
  if (LItem <> nil) and Assigned(FLookupDictionary) then
    FLookupDictionary.TryGetValue(LItem, Result);
end;

procedure TBindListLookupEditorImpl.ListCleared;
begin
  FreeAndNil(FLookupDictionary);
end;

function TBindListLookupEditorImpl.GetSelectedLookupValue: TValue;
var
  LItem: TListBoxItem;
begin
  LItem := GetSelected; // FListBox.Selected;
  if (LItem <> nil) and (FLookupDictionary <> nil) then
  begin
    if not FLookupDictionary.TryGetValue(LItem, Result) then
      Result := TValue.Empty;
  end
  else
    Result := TValue.Empty;
end;

procedure TBindListLookupEditorImpl.ItemRemoved(AListItem: TListBoxItem);
begin
  if Assigned(FLookupDictionary) then
    if FLookupDictionary.ContainsKey(AListItem) then
      FLookupDictionary.Remove(AListItem);
end;

destructor TBindListLookupEditorImpl.Destroy;
begin
  FLookupDictionary.Free;
  inherited;
end;

procedure TBindListLookupEditorImpl.SetLookupValue(const AScope: IScope;
  const AValue: TValue);
var
  LItemEditorObject: TBindListListItemEditorObject;
  LPlaceHolder: IPlaceHolder;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LItemEditorObject := LPlaceHolder.Attachment as TBindListListItemEditorObject
  else
    LItemEditorObject := nil;
  Assert(LItemEditorObject <> nil);
  if (LItemEditorObject <> nil) then
  begin
    if FLookupDictionary = nil then
      FLookupDictionary := TDictionary<TListBoxItem,TValue>.Create;
    FLookupDictionary.AddOrSetValue(LItemEditorObject.CurrentItem, AValue);
  end;
end;

function TBindListLookupEditorImpl.SameValue(const AValue1, AValue2: TValue): Boolean;
begin
  Assert(not AValue1.IsArray);  // not supported
  Assert(not AValue2.IsArray);  // not supported
  if (AValue1.IsEmpty) or (AValue2.IsEmpty) then
    Result := AValue2.IsEmpty
  else if (AValue1.IsObject) or (AValue2.IsObject) then
    Result := AValue2.IsObject and (AValue1.AsObject = AValue2.AsObject)
  else
    Result := AValue1.ToString = AValue2.ToString;
end;

function TBindListLookupEditorImpl.FindLookupValue(const AValue: TValue): TListBoxItem;
var
  I: Integer;
  LItem: TListBoxItem;
  LValue: TValue;
begin
  Result := nil;
  if FLookupDictionary <> nil then
    for I := 0 to ListCount - 1 do //FListBox.Count - 1 do
    begin
      LItem := GetListItem(I); // FListBox.ListItems[I];
      if FLookupDictionary.TryGetValue(LItem, LValue) then
        if SameValue(LValue, AValue) then
          Exit(LItem);
    end;
end;

procedure TBindListLookupEditorImpl.SetSelectedLookupValue(const AValue: TValue);
var
  LItem: TListBoxItem;
begin
  LItem := FindLookupValue(AValue);
  SetSelected(LItem);
end;

function GetMetroListBoxItemMemberNames: TArray<string>;
begin
  Result := TArray<string>.Create('Title', 'SubTitle', 'Icon', 'Description'); // Do not localize
end;

type
  TListViewNames = record
  const
    Text = 'Text';
    Detail = 'Detail';
    Bitmap = 'Bitmap';
    Accessory = 'Accessory';
    ImageIndex = 'ImageIndex';
    ButtonText = 'ButtonText';
    Tag = 'Tag';
    Checked = 'Checked';
    Data = 'Data';
  end;

  TListBoxNames = record
  const
    Text = 'Text';
    ItemDataText = 'ItemData.Text';
    ItemDataDetail = 'ItemData.Detail';
    ItemDataBitmap = 'ItemData.Bitmap';
    ItemDataAccessory = 'ItemData.Accessory';
    ImageIndex = 'ImageIndex';
    IsChecked = 'IsChecked';
    IsSelected = 'IsChecked';
  end;

function GetListBoxItemDataMemberNames: TArray<string>;
begin
  // 'Text' should be first because it is default member
  Result := TArray<string>.Create('Text', 'Detail', 'Bitmap', 'Accessory');   // do not localize
end;

function GetBaseListBoxItemMemberNames: TArray<string>;
begin
  // 'Text' should be first because it is default
  Result := TArray<string>.Create('Text', 'ImageIndex');   // do not localize
end;

procedure AddListBoxItemDataMemberNames(ANames: TStrings);
var
  s: string;
begin
  ANames.Clear;
  for s in GetListBoxItemDataMemberNames do
    ANames.Add(s)
end;

function GetListBoxItemDataMemberNameExpression(
  const AName: string): string;
var
  s: string;
begin
  for s in GetListBoxItemDataMemberNames do
    if SameText(s, AName) then
      Exit('ItemData.' + AName);
  Result := AName;
end;

function CreateListBoxItem(const AClass: TComponentClass): TListBoxItem;
begin
  Result := AClass.Create(nil) as TListBoxItem;
  Result.Stored := False;  // Don't persist at design time
  Result.Locked := True;   // Don't select at design time
end;

{ TBindListListBoxEditor }

function TBindListListBoxEditor.AddHeader: IScope;
var
  LListBoxItem: TListBoxItem;
begin
  LListBoxItem := CreateListBoxItem(TListBoxGroupHeader);
  LListBoxItem.Parent := FEditorObject.FListBox;
  FEditorObject.FItemIndex := LListBoxItem.Index;
//  if Select then
//    FEditorObject.FListBox.ItemIndex := LListBoxItem.Index;
  Result := WrapObject(FEditorObject);
end;

function TBindListListBoxEditor.AddItem(Select: Boolean): IScope;
var
  LListBoxItem: TListBoxItem;
begin
  LListBoxItem := CreateItem; // TListBoxItem.Create(nil);
  LListBoxItem.Parent := FEditorObject.FListBox;
  FEditorObject.FItemIndex := LListBoxItem.Index;
  if Select then
    FEditorObject.FListBox.ItemIndex := LListBoxItem.Index;
  Result := WrapObject(FEditorObject);
end;

function TBindListListBoxEditor.CreateItem: TListBoxItem;
begin
  Result := CreateListBoxItem(TListBoxItem);
end;

function TBindListListBoxEditor.MoveNext: Boolean;
begin
  // Must surround with BeginUpdate, EndUpdate
  Assert(FUpdateCounter > 0);
  if FEditorObject.FListBox.Count = 0 then
    Exit(False);
  if FEditorObject.FItemIndex = -1 then
  begin
    FEditorObject.FItemIndex := FEditorObject.FListBox.ItemIndex;
    if FEditorObject.FItemIndex < 0 then
      FEditorObject.FItemIndex := 0;
  end
  else
    FEditorObject.FItemIndex := FEditorObject.FItemIndex + 1;
  Result := (FEditorObject.FItemIndex >= 0) and (FEditorObject.FItemIndex < FEditorObject.FListBox.Count);

end;

function TBindListListBoxEditor.GetListItem(I: Integer): TListBoxItem;
begin
  Result := FEditorObject.FListBox.ListItems[I];
end;

function TBindListListBoxEditor.GetItemIndex: Integer;
begin
  Result := FEditorObject.FListBox.ItemIndex;
end;

function TBindListListBoxEditor.GetItemMemberNameExpression(
  const AName: string): string;
begin
  // Always support ItemData members
  Result := GetListBoxItemDataMemberNameExpression(AName);
end;

procedure TBindListListBoxEditor.GetItemMemberNames(ANames: TStrings);
var
  s: string;
begin
  ANames.Clear;
  for s in GetBaseListBoxItemMemberNames do
    ANames.Add(s);
end;

function TBindListListBoxEditor.GetHeaderMemberNameExpression(
  const AName: string): string;
begin
  // Always support ItemData members
  Result := GetListBoxItemDataMemberNameExpression(AName);
end;

procedure TBindListListBoxEditor.GetHeaderMemberNames(ANames: TStrings);
var
  s: string;
begin
  ANames.Clear;
  for s in GetBaseListBoxItemMemberNames do
    ANames.Add(s);
end;

function TBindListListBoxEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FListBox.Count;
end;


function TBindListListBoxEditor.CurrentHeaderItem: IScope;
begin
  Result := CurrentItem;
end;

function TBindListListBoxEditor.CurrentItem: IScope;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListBox.ItemIndex;
  Result := WrapObject(FEditorObject)
end;

function TBindListListBoxEditor.CurrentObject: TObject;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListBox.ItemIndex;
  Result := FEditorObject.CurrentItem
end;

function TBindListListBoxEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListBox.ItemIndex;
  Result := FEditorObject.FItemIndex
end;

procedure TBindListListBoxEditor.BeginUpdate;
begin
  // BeginUpdate prevents resources from being applied
  FEditorObject.FListBox.BeginUpdate;
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FItemIndex := -1;


end;

function TBindListListBoxEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.FListBox.ItemIndex <> -1;
end;

procedure TBindListListBoxEditor.ClearList;
begin
//  if Assigned(FLookupDictionary) then
//    FLookupDictionary.Clear;
  ListCleared;
  FEditorObject.FListBox.Clear;

end;

constructor TBindListListBoxEditor.Create(AListBox: TCustomListBox);
begin
  FEditorObject := CreateEditorObject; // TBindListListBoxEditorObject.Create;
  FEditorObject.FListBox := AListBox;
  FEditorObject.FItemIndex := -1;
  if not (csDesigning in AListBox.ComponentState) then
    GEditors.Add(AListBox, Self);
end;

destructor TBindListListBoxEditor.Destroy;
begin
  if GEditors <> nil then
    GEditors.Remove(FEditorObject.FListBox);
  FEditorObject.Free;
  //FLookupDictionary.Free;
  inherited;
end;

function TBindListListBoxEditor.CreateEditorObject: TBindListListBoxEditorObject;
begin
  Result := TBindListListBoxEditorObject.Create;
end;

procedure TBindListListBoxEditor.EndUpdate;
begin
  FEditorObject.FListBox.EndUpdate;
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FItemIndex := -1;

end;

function TBindListListBoxEditor.GetSelectedText: string;
begin
  //Result := FEditorObject.Text;
  Result := '';
  if FEditorObject.FListBox.ItemIndex <> -1 then
    if FEditorObject.FListBox.ItemIndex < FEditorObject.FListBox.Count then
      Result :=  FEditorObject.FListBox.ListItems[FEditorObject.FListBox.ItemIndex].Text;
end;

function TBindListListBoxEditor.InsertItem(Select: Boolean): IScope;
var
  LListBoxItem: TListBoxItem;
begin
  LListBoxItem := CreateItem; // TListBoxItem.Create(nil);
  if FEditorObject.FItemIndex <> -1 then
    FEditorObject.FListBox.InsertObject(FEditorObject.FItemIndex, LListBoxItem)
  else if FEditorObject.FListBox.ItemIndex <> -1 then
    FEditorObject.FListBox.InsertObject(FEditorObject.FListBox.ItemIndex, LListBoxItem)
  else
    LListBoxItem.Parent := FEditorObject.FListBox;

  FEditorObject.FItemIndex := LListBoxItem.Index;
  if Select then
    FEditorObject.FListBox.ItemIndex := FEditorObject.FItemIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListListBoxEditor.GetSelected: TListBoxItem;
begin
  Result := FEditorObject.FListBox.Selected;
end;

function TBindListListBoxEditor.ListCount: Integer;
begin
  Result := FEditorObject.FListBox.Count;
end;

function TBindListListBoxEditor.GetSelectedItem: TObject;
begin
  Result := nil;
  if FEditorObject.FListBox.ItemIndex <> -1 then
    if FEditorObject.FListBox.ItemIndex < FEditorObject.FListBox.Count then
      Result :=  FEditorObject.FListBox.ListItems[FEditorObject.FListBox.ItemIndex];
end;

procedure TBindListListBoxEditor.SetItemIndex(AIndex: Integer);
begin
  FEditorObject.FListBox.ItemIndex := AIndex;
end;

procedure TBindListListBoxEditor.SetSelected(AListItem: TListBoxItem);
begin
  if AListItem = nil then
    FEditorObject.FListBox.ItemIndex := -1
  else
    FEditorObject.FListBox.ItemIndex := AListItem.Index;
end;

procedure TBindListListBoxEditor.SetSelectedText(const AValue: string);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FListBox.Count - 1 do
    if SameText(FEditorObject.FListBox.ListItems[I].Text, AValue) then
    begin
      FEditorObject.FListBox.ItemIndex := I;
      Exit;
    end;
   FEditorObject.FListBox.ItemIndex := -1;
end;

procedure TBindListListBoxEditor.DeleteToEnd;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FListBox.ItemIndex;
  while FEditorObject.FListBox.Count > Max(0, FEditorObject.FItemIndex) do
  begin
    ItemRemoved(FEditorObject.FListBox.ListItems[FEditorObject.FListBox.Count-1]);
    FEditorObject.FListBox.RemoveObject(
      FEditorObject.FListBox.ListItems[FEditorObject.FListBox.Count-1]);
  end;
  FEditorObject.FItemIndex := FEditorObject.FListBox.Count - 1;
end;

procedure SetCurrentListBoxEditorValue(const AEditor: TBindListListItemEditorObject; const AMemberName: string;
  const AValue: TValue; AType: TScopeMemberType);
begin
  if AMemberName = TListBoxNames.ItemDataText then
    AEditor.ItemData.Text := AValue.ToString
  else if AMemberName = TListBoxNames.Text then
    AEditor.ItemData.Text := AValue.ToString
  else if AMemberName = TListBoxNames.ItemDataDetail then
    AEditor.ItemData.Detail := AValue.ToString
  else if AMemberName = TListBoxNames.ImageIndex then
    AEditor.ImageIndex := AValue.AsInteger
  else if AMemberName = TListBoxNames.ItemDataAccessory then
    AEditor.ItemData.Accessory := AValue.AsInteger
  else if AMemberName = TListBoxNames.ImageIndex then
    AEditor.ImageIndex := AValue.AsInteger
  else if AMemberName = TListBoxNames.IsChecked then
    AEditor.IsChecked := AValue.AsBoolean
  else if AMemberName = TListBoxNames.IsSelected then
    AEditor.IsSelected := AValue.AsBoolean
  else if AMemberName = TListBoxNames.ItemDataBitmap then
    if AValue.IsObject and (AValue.AsObject is TPersistent) then
      AEditor.ItemData.Bitmap.Assign(TPersistent(AValue.AsObject))
    else
      AEditor.ItemData.Bitmap.Assign(nil)                                 
  else
    Assert(False);  // Unexpected
end;

function CanSetCurrentListBoxEditorValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
begin
  AType := mtUnknown;
  if AMemberName = TListBoxNames.ItemDataText then
    AType := mtText
  else if AMemberName = TListBoxNames.Text then
    AType := mtText
  else if AMemberName = TListBoxNames.ItemDataDetail then
    AType := mtText
  else if AMemberName = TListBoxNames.ImageIndex then
    AType := mtInteger
  else if AMemberName = TListBoxNames.ItemDataAccessory then
    AType := mtInteger
  else if AMemberName = TListBoxNames.ItemDataBitmap then
    AType := mtBitmap
  else if AMemberName = TListBoxNames.IsChecked then
    AType := mtBoolean
  else if AMemberName = TListBoxNames.IsSelected then
    AType := mtBoolean;
  Result := AType <> mtUnknown;
end;

function TBindListListBoxEditor.CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
begin
  Result := CanSetCurrentListBoxEditorValue(AMemberName, AType);
end;

procedure TBindListListBoxEditor.SetCurrentValue(const AMemberName: string;
  const AValue: TValue; AType: TScopeMemberType);
var
  LIndex: Integer;
begin
  if FEditorObject.GetIndex = -1 then
  begin
    LIndex := FEditorObject.FListBox.ItemIndex;
    // ignore headers and footers
    if (LIndex >= 0) and (LIndex < FEditorObject.FListBox.Items.Count) then
      if not ((LIndex < FEditorObject.FListBox.ChildrenCount) and (FEditorObject.FListBox.Children[LIndex] is TListBoxGroupHeader)) then
        FEditorObject.SetIndex(LIndex);
  end;
  SetCurrentListBoxEditorValue(FEditorObject, AMemberName, AValue, AType);
end;

{ TBindListComboBoxEditor }

function TBindListComboBoxEditor.AddItem(Select: Boolean): IScope;
var
  LListBoxItem: TListBoxItem;
begin
  LListBoxItem := CreateItem; // TListBoxItem.Create(nil);
  LListBoxItem.Parent := FEditorObject.FComboBox;
  FEditorObject.FItemIndex := LListBoxItem.Index;
  if Select then
    FEditorObject.FComboBox.ItemIndex := FEditorObject.FItemIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListComboBoxEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.FComboBox.Count = 0 then
    Exit(False);
  if FEditorObject.FItemIndex = -1 then
  begin
    FEditorObject.FItemIndex := FEditorObject.FComboBox.ItemIndex;
    if FEditorObject.FItemIndex < 0 then
      FEditorObject.FItemIndex := 0;
  end
  else
    FEditorObject.FItemIndex := FEditorObject.FItemIndex + 1;
  Result := (FEditorObject.FItemIndex >= 0) and (FEditorObject.FItemIndex < FEditorObject.FComboBox.Count);

end;

function TBindListComboBoxEditor.GetListItem(I: Integer): TListBoxItem;
begin
  Result := FEditorObject.FComboBox.ListBox.ListItems[I]
end;

function TBindListComboBoxEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FComboBox.Count;
end;

function TBindListComboBoxEditor.GetItemIndex: Integer;
begin
  Result := FEditorObject.FComboBox.ItemIndex;
end;

function TBindListComboBoxEditor.GetItemMemberNameExpression(
  const AName: string): string;
begin
  // Always support ItemData members
  Result := GetListBoxItemDataMemberNameExpression(AName);
end;

procedure TBindListComboBoxEditor.GetItemMemberNames(ANames: TStrings);
var
  s: string;
begin
  ANames.Clear;
  for s in GetBaseListBoxItemMemberNames do
    ANames.Add(s);
end;


function TBindListComboBoxEditor.CurrentItem: IScope;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FComboBox.ItemIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListComboBoxEditor.CurrentObject: TObject;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FComboBox.ItemIndex;
  Result := FEditorObject.CurrentItem
end;

function TBindListComboBoxEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FComboBox.ItemIndex;
  Result := FEditorObject.FItemIndex
end;

procedure TBindListComboBoxEditor.BeginUpdate;
begin
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FItemIndex := -1;
  FEditorObject.FComboBox.BeginUpdate;
end;

function TBindListComboBoxEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.FComboBox.ItemIndex <> -1;
end;

procedure TBindListComboBoxEditor.ClearList;
begin
  ListCleared;
  FEditorObject.FComboBox.Clear;

end;

constructor TBindListComboBoxEditor.Create(AComboBox: TCustomComboBox);
begin
  if not (csDesigning in AComboBox.ComponentState) then
    GEditors.Add(AComboBox, Self);
  FEditorObject := CreateEditorObject; // TBindListComboBoxEditorObject.Create;
  FEditorObject.FComboBox := AComboBox;
  FEditorObject.FItemIndex := -1;
end;

function TBindListComboBoxEditor.CreateEditorObject: TBindListComboBoxEditorObject;
begin
  Result := TBindListComboBoxEditorObject.Create;
end;

function TBindListComboBoxEditor.CreateItem: TListBoxItem;
begin
  Result := CreateListBoxItem(TListBoxItem);
end;

destructor TBindListComboBoxEditor.Destroy;
begin
  if GEditors <> nil then
    GEditors.Remove(FEditorObject.FComboBox);
  FEditorObject.Free;
  inherited;
end;

procedure TBindListComboBoxEditor.EndUpdate;
begin
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FItemIndex := -1;
  FEditorObject.FComboBox.EndUpdate;

end;

function TBindListComboBoxEditor.GetSelectedText: string;
begin
  Result := '';
  if FEditorObject.FComboBox.ItemIndex <> -1 then
    if FEditorObject.FComboBox.ListBox.ItemIndex < FEditorObject.FComboBox.ListBox.Count then
      Result :=  FEditorObject.FComboBox.ListBox.ListItems[FEditorObject.FComboBox.ListBox.ItemIndex].Text;
end;

function TBindListComboBoxEditor.InsertItem(Select: Boolean): IScope;
var
  LListBoxItem: TListBoxItem;
begin
  LListBoxItem := CreateItem; // TListBoxItem.Create(nil);
  LListBoxItem.Parent := FEditorObject.FComboBox;
  FEditorObject.FItemIndex := LListBoxItem.Index;
  if Select then
    FEditorObject.FComboBox.ItemIndex := FEditorObject.FItemIndex;
  //Result := WrapObject(FEditorObject);
  Result := WrapObject(FEditorObject);
end;

function TBindListComboBoxEditor.GetSelected: TListBoxItem;
begin
  Result := nil;
  if FEditorObject.FComboBox.ItemIndex <> -1 then
    if FEditorObject.FComboBox.ListBox.ItemIndex < FEditorObject.FComboBox.ListBox.Count then
      Result :=  FEditorObject.FComboBox.ListBox.ListItems[FEditorObject.FComboBox.ListBox.ItemIndex];
end;

function TBindListComboBoxEditor.ListCount: Integer;
begin
  Result := FEditorObject.FComboBox.Count;
end;

function TBindListComboBoxEditor.GetSelectedItem: TObject;
begin
  Result := GetSelected;
end;

procedure TBindListComboBoxEditor.SetItemIndex(AIndex: Integer);
begin
  FEditorObject.FComboBox.ItemIndex := AIndex;
end;

procedure TBindListComboBoxEditor.SetSelected(AListItem: TListBoxItem);
begin
  if AListItem = nil then
    FEditorObject.FComboBox.ItemIndex := -1
  else
    FEditorObject.FComboBox.ItemIndex := AListItem.Index;
end;

procedure TBindListComboBoxEditor.SetSelectedText(const AValue: string);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FComboBox.Count - 1 do
    if SameText(FEditorObject.FComboBox.ListBox.ListItems[I].Text, AValue) then
    begin
      FEditorObject.FComboBox.ItemIndex := I;
      Exit;
    end;
   FEditorObject.FComboBox.ItemIndex := -1;
end;

procedure TBindListComboBoxEditor.DeleteToEnd;
begin
  if FEditorObject.FItemIndex = -1 then
    FEditorObject.FItemIndex := FEditorObject.FComboBox.ItemIndex;
  while FEditorObject.FComboBox.Count > Max(0, FEditorObject.FItemIndex) do
  begin
    ItemRemoved(FEditorObject.FComboBox.ListBox.ListItems[FEditorObject.FComboBox.Count-1]);
    FEditorObject.FComboBox.ListBox.RemoveObject(
      FEditorObject.FComboBox.ListBox.ListItems[FEditorObject.FComboBox.Count-1]);
  end;
  FEditorObject.FItemIndex := FEditorObject.FComboBox.Count - 1;
end;


function TBindListComboBoxEditor.CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
begin
  Result := CanSetCurrentListBoxEditorValue(AMemberName, AType);
end;

procedure TBindListComboBoxEditor.SetCurrentValue(const AMemberName: string;
  const AValue: TValue; AType: TScopeMemberType);
var
  LIndex: Integer;
begin
  if FEditorObject.GetIndex = -1 then
  begin
    LIndex := FEditorObject.FComboBox.ItemIndex;
    // ignore headers and footers
    if (LIndex >= 0) and (LIndex < FEditorObject.FComboBox.Items.Count) then
      if not ((LIndex < FEditorObject.FComboBox.ChildrenCount) and (FEditorObject.FComboBox.Children[LIndex] is TListBoxGroupHeader)) then
        FEditorObject.SetIndex(LIndex);
  end;
  SetCurrentListBoxEditorValue(FEditorObject, AMemberName, AValue, AType);
end;

{ TBindListComboEditEditor }

function TBindListComboEditEditor.AddItem(Select: Boolean): IScope;
begin
  FEditorObject.FIndex := FEditorObject.ControlItems.Add('');
  if Select then
    FEditorObject.ControlItemIndex := FEditorObject.FIndex;
  Result := WrapObject(FEditorObject);

end;

function TBindListComboEditEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.ControlItems.Count = 0 then
    Exit(False);
  if FEditorObject.FIndex = -1 then
  begin
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
    if FEditorObject.FIndex < 0 then
      FEditorObject.FIndex := 0;
  end
  else
    FEditorObject.FIndex := FEditorObject.FIndex + 1;
  Result := (FEditorObject.FIndex >= 0) and (FEditorObject.FIndex < FEditorObject.ControlItems.Count);
end;

function TBindListComboEditEditor.GetItemIndex: Integer;
begin
  Result := FEditorObject.ControlItemIndex
end;

function TBindListComboEditEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.ControlItems.Count;
end;


function TBindListComboEditEditor.CurrentItem: IScope;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListComboEditEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  Result := FEditorObject.FIndex
end;

procedure TBindListComboEditEditor.BeginUpdate;
begin
  FEditorObject.ControlItems.BeginUpdate;
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FIndex := -1;
end;

function TBindListComboEditEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.ControlItemIndex <> -1;
end;

procedure TBindListComboEditEditor.ClearList;
begin
  FEditorObject.ControlClear;
  FEditorObject.FIndex := -1;

end;

constructor TBindListComboEditEditor.Create(AComboBox: TComboEdit);
begin
  FEditorObject := CreateItemsEditor(AComboBox);
  FEditorObject.FIndex := -1;
end;

destructor TBindListComboEditEditor.Destroy;
begin
  FEditorObject.Free;
  inherited;
end;

procedure TBindListComboEditEditor.EndUpdate;
begin
  FEditorObject.ControlItems.EndUpdate;
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.FIndex := -1;

end;

function TBindListComboEditEditor.GetSelectedText: string;
begin
  Result := '';
  if FEditorObject.ControlItemIndex <> -1 then
    Result :=  FEditorObject.ControlItems[FEditorObject.ControlItemIndex];
end;

function TBindListComboEditEditor.InsertItem(Select: Boolean): IScope;
begin
  if not CanInsertItem then
    Result := nil
  else
  begin
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
    FEditorObject.ControlItems.Insert(FEditorObject.FIndex, '');
    if Select then
      FEditorObject.ControlItemIndex := FEditorObject.FIndex;
    Result := WrapObject(FEditorObject);
  end;

end;

procedure TBindListComboEditEditor.SetItemIndex(AIndex: Integer);
begin
  FEditorObject.ControlItemIndex := AIndex;
end;

procedure TBindListComboEditEditor.SetSelectedText(const AValue: string);
var
  I: Integer;
begin
  I := FEditorObject.ControlItems.IndexOf(AValue);
  FEditorObject.ControlItemIndex := I;
end;

procedure TBindListComboEditEditor.DeleteToEnd;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := FEditorObject.ControlItemIndex;
  while FEditorObject.ControlItems.Count > Max(0, FEditorObject.FIndex) do
    FEditorObject.ControlItems.Delete(FEditorObject.ControlItems.Count-1);
  FEditorObject.FIndex := FEditorObject.ControlItems.Count - 1;

end;

function TBindListComboEditEditor.CreateItemsEditor(
  AControl: TControl): TBaseListBoxItemEditorObject;
begin
  Result := TComboEditItemEditorObject.Create(AControl as TComboEdit);
end;



{ TBindListBoxEditorFactory }

constructor TBindListBoxEditorFactory.Create;
begin
  inherited;

end;

function TBindListBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    // Get existing editor
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      if (AObject is TCustomListBox) then
        if (TCustomListBox(AObject).DefaultItemStyles.ItemStyle <> '') then
          Result := TBindListItemDataListBoxEditor.Create(TCustomListBox(AObject))
        else
          Result := TBindListListBoxEditor.Create(TCustomListBox(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListListBoxEditor);
      Result := LEditor as TBindListListBoxEditor;
    end;
end;

function TBindListBoxEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomListBox) and
      (not AObject.InheritsFrom(TColorListBox)) then
      Result := True;
end;

{ TBindListViewEditorFactory }

constructor TBindListViewEditorFactory.Create;
begin
  inherited;

end;

function TBindListViewEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    // Get existing editor
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      if (AObject is TCustomListView) then
        Result := TBindListViewEditor.Create(TCustomListView(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListViewEditor);
      Result := LEditor as TBindListViewEditor;
    end;
end;

function TBindListViewEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomListView) then
      Result := True;
end;


{ TBindComboBoxEditorFactory }

constructor TBindComboBoxEditorFactory.Create;
begin
  inherited;

end;

function TBindComboBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      Result := TBindListComboBoxEditor.Create(TCustomComboBox(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListComboBoxEditor);
      Result := LEditor as TBindListComboBoxEditor;
    end;
end;

function TBindComboBoxEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomComboBox) and
      (not AObject.InheritsFrom(TColorComboBox)) then
      Result := True;
end;

{ TBindComboEditEditorFactory }

constructor TBindComboEditEditorFactory.Create;
begin
  inherited;

end;

function TBindComboEditEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  Result := TBindListComboEditEditor.Create(TComboEdit(AObject));
end;

function TBindComboEditEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TComboEdit) then
      Result := True;
end;


{ TBindStringGridEditorFactory }

constructor TBindStringGridEditorFactory.Create;
begin
  inherited;

end;

function TBindStringGridEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  // Get existing editor
  if not GEditors.TryGetValue(TComponent(AObject), Result) then
    Result := TBindListStringGridEditor.Create(TStringGrid(AObject));
end;

function TBindStringGridEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TStringGrid) then
      Result := True;
end;

{ TBindGridEditorFactory }

constructor TBindGridEditorFactory.Create;
begin
  inherited;

end;

function TBindGridEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    // Get existing editor
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      if AObject is TCustomGrid then
        Result := TBindListGridEditor.Create(TCustomGrid(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListGridEditor);
      Result := LEditor as TBindListGridEditor;
    end;
end;

function TBindGridEditorFactory.ReleaseEditor(const AEditor: IInterface): Boolean;
begin
  Result := GEditors.ReleaseEditor(AEditor);
end;

function TBindGridEditorFactory.Supports(AIntf: TGuid; AObject:
  TObject): Boolean;
begin
  Result := False;
  if (AIntf = IBindListEditorCommon) or (AIntf = IBindListVirtualEditor) then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomGrid) then
      Result := True;
end;

{ TBindListStringGridEditor }

function TBindListStringGridEditor.AddItem(Select: Boolean): IScope;
begin
  FEditorObject.FStringGrid.RowCount := FEditorObject.FStringGrid.RowCount + 1;
  FEditorObject.FIndex := FEditorObject.FStringGrid.RowCount - 1;
  if Select then
    FEditorObject.FStringGrid.Selected := FEditorObject.FIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListStringGridEditor.GetItemIndex: Integer;
begin
  Result := FEditorObject.FStringGrid.Selected;
end;

const
  sSelected = 'Selected';


function TBindListStringGridEditor.GetPositionGetter(var AGetter: string;
  var ABase: Integer): Boolean;
begin
  ABase := 0;
  AGetter := sSelected;
  Result := True;
end;

function TBindListStringGridEditor.GetPositionSetter(var ASetter: string;
  var ABase: Integer): Boolean;
begin
  ABase := 0;
  ASetter := sSelected;
  Result := True;
end;

function TBindListStringGridEditor.GetRowIndex: Integer;
begin
  if FEditorObject.FStringGrid.Selected >= FEditorObject.FStringGrid.RowCount then
    Result := FEditorObject.FStringGrid.RowCount - 1
  else
    Result := FEditorObject.FStringGrid.Selected;
end;

function TBindListStringGridEditor.GetColumnIndex: Integer;
begin
  Result := FEditorObject.FStringGrid.ColumnIndex;
end;

procedure TBindListStringGridEditor.GetColumnIndices(ANames: TStrings);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FStringGrid.ColumnCount - 1 do
    ANames.Add(IntToStr(I));
end;

procedure TBindListStringGridEditor.GetColumnNames(ANames: TStrings);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FStringGrid.ColumnCount - 1 do
    ANames.Add(FEditorObject.FStringGrid.Columns[I].Name);
end;

function TBindListStringGridEditor.CurrentItem: IScope;
begin
  //FEditorObject.FIndex := FEditorObject.FStringGrid.Row;
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := GetRowIndex;
  Result := WrapObject(FEditorObject);
end;

function TBindListStringGridEditor.CurrentObject: TObject;
begin
  Result := nil
end;

function TBindListStringGridEditor.CurrentIndex: Integer;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := GetRowIndex;
  Result := FEditorObject.FIndex;
end;

procedure TBindListStringGridEditor.BeginUpdate;
begin
  FEditorObject.FStringGrid.BeginUpdate;
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
    FEditorObject.FIndex := -1
end;

function TBindListStringGridEditor.CanInsertItem: Boolean;
begin
  Result := False; // Not supported
end;

procedure TBindListStringGridEditor.ClearList;
begin
  FEditorObject.FIndex := -1;
  FEditorObject.FStringGrid.RowCount := 0;
end;

constructor TBindListStringGridEditor.Create(AGrid: TStringGrid);
begin
  FEditorObject := TStringGridItemEditorObject.Create;
  FEditorObject.FStringGrid := AGrid;
  FEditorObject.FIndex := -1;
end;

procedure TBindListStringGridEditor.DeleteToEnd;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := GetRowIndex;
  if FEditorObject.FIndex = -1 then
    ClearList
  else
    FEditorObject.FStringGrid.RowCount := FEditorObject.FIndex;
end;

destructor TBindListStringGridEditor.Destroy;
begin
  FEditorObject.Free;
  inherited;
end;

procedure TBindListStringGridEditor.EndUpdate;
begin
  FEditorObject.FStringGrid.EndUpdate;
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
  begin
    FEditorObject.FIndex := -1;
    if FEditorObject.FStringGrid.EditorMode then
      // TStringGrid doesn't update editor when set cells while updating, so update now
      FEditorObject.FStringGrid.Model.RefreshEditorValue;
  end;
end;

function TBindListStringGridEditor.InsertItem(Select: Boolean): IScope;
begin
  Result := nil;
end;

function TBindListStringGridEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FStringGrid.RowCount;
end;

function TBindListStringGridEditor.GetSelectedText: string;
var
  LRowIndex: Integer;
  LColumnIndex: Integer;
begin
  LRowIndex := GetRowIndex;
  LColumnIndex := GetColumnIndex;
  if (LRowIndex >= 0) and (LColumnIndex >= 0) then
  begin
    // Force editor value to be saved to cache
    FEditorObject.FStringGrid.Model.PostEditorValue;
    Result := FEditorObject.FStringGrid.Cells[LColumnIndex, LRowIndex]
  end;
end;

function TBindListStringGridEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.FStringGrid.RowCount = 0 then
    Exit(False);
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex :=  GetRowIndex
  else
    FEditorObject.FIndex :=  FEditorObject.FIndex + 1;
  Result := FEditorObject.FIndex < FEditorObject.FStringGrid.RowCount;
end;

function TryParseCellExpression(const AMemberName: string; out AIndex: Integer): Boolean;
var
  S: string;
  Col: Integer;
  C: Char;
begin
  Result := AMemberName.StartsWith('Cells[');
  if Result then
  begin
    S := AMemberName.Substring(6);
    Col := 0;
    for C in S do
    begin
      if (C >= '0') and (C <= '9') then
        Col := Col * 10 + Ord(C) - Ord('0')
      else
      begin
        Result := C = ']';
        break;
      end;
    end;
    if Result then
      AIndex := Col;
  end;
end;


procedure TBindListStringGridEditor.SetCurrentValue(const AMemberName: string;
  const AValue: TValue;  AType: TScopeMemberType);
var
  Col: Integer;
begin
  if FEditorObject.FIndex = -1 then
    FEditorObject.FIndex := GetRowIndex;
  if TryParseCellExpression(AMemberName, Col) then
  begin
    if Col < FEditorObject.FStringGrid.ColumnCount then
      FEditorObject.Cells[Col] := AValue.ToString
    else
      raise Exception.Create('Column out of range');
  end;

end;

function TBindListStringGridEditor.CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
var
  Col: Integer;
begin
  AType := mtText;
  Result := TryParseCellExpression(AMemberName, Col);
end;

procedure TBindListStringGridEditor.SetItemIndex(AIndex: Integer);
begin
  FEditorObject.FStringGrid.Selected := AIndex;
end;

procedure TBindListStringGridEditor.SetSelectedText(const AValue: string);
var
  LRowIndex: Integer;
  LColumnIndex: Integer;
begin
  LRowIndex := GetRowIndex;
  LColumnIndex := GetColumnIndex;
  if (LRowIndex >= 0) and (LColumnIndex >= 0) then
    FEditorObject.FStringGrid.Cells[LColumnIndex, LRowIndex] := AValue;
end;

{ TStringGridItemEditorObject }

function TStringGridItemEditorObject.GetCells(ACol: Integer): string;
begin
  Result := Self.FStringGrid.Cells[ACol, FIndex];
end;

function TStringGridItemEditorObject.GetOwner: TStringGrid;
begin
  Result := FStringGrid;
end;

procedure TStringGridItemEditorObject.SetCells(ACol: Integer;
  const Value: string);
begin
  if FIndex > -1 then
    if FIndex <= Self.FStringGrid.RowCount then
      Self.FStringGrid.Cells[ACol, FIndex] := Value;
end;

{ TBindListGridEditor }

function TBindListGridEditor.GetRowIndex: Integer;
begin
  Result := FEditorObject.FGrid.Selected;
end;

function TBindListGridEditor.GetColumnIndex: Integer;
begin
  Result := FEditorObject.FGrid.ColumnIndex;
end;

procedure TBindListGridEditor.GetColumnIndices(ANames: TStrings);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FGrid.ColumnCount - 1 do
    ANames.Add(IntToStr(I));
end;

procedure TBindListGridEditor.GetColumnNames(ANames: TStrings);
var
  I: Integer;
begin
  for I := 0 to FEditorObject.FGrid.ColumnCount - 1 do
    ANames.Add(FEditorObject.FGrid.Columns[I].Name);
end;

function TBindListGridEditor.GetPositionGetter(var AGetter: string;
  var ABase: Integer): Boolean;
begin
  AGetter := sSelected; 
  ABase := 0;
  Result := True;
end;

function TBindListGridEditor.GetPositionSetter(var ASetter: string;
  var ABase: Integer): Boolean;
begin
  ASetter := sSelected;
  ABase := 0;
  Result := True;
end;

procedure TBindListGridEditor.BeginUpdate;
begin
  FEditorObject.FGrid.BeginUpdate;
end;

function TBindListGridEditor.CanCache: Boolean;
begin
  // Scope works for any row, so OK to cache in TBindingExpression.
  Result := True;
end;

procedure TBindListGridEditor.ClearList;
begin
  FEditorObject.FGrid.RowCount := 0;
end;

constructor TBindListGridEditor.Create(AGrid: TCustomGrid);
begin
  ValidateInheritance(AGrid, TCustomGrid, False);
  FColumnDataObjects := TObjectDictionary<Integer, TObject>.Create([doOwnsValues]);
  FValues := TValueCache.Create;
  FEditorObject := TGridItemEditorObject.Create;
  FEditorObject.FGrid := AGrid;
  FEditorObject.FGrid.OnCallbackGetValue := GridOnCallbackGetValue;
  FEditorObject.FGrid.OnSetValue := GridOnSetValue;
  FEditorObject.FGrid.IsUsedInBinding := True;
  GEditors.Add(AGrid, Self);
end;

type
  TGridDataObject = class
  private
    FColumn: Integer;
    [Weak] FOwner: TCustomGrid;
    FCallback: TProc<TValue>;
    procedure SetData(const AValue: TValue);
    function GetData: TValue;
  public
    constructor Create(AOwner: TCustomGrid; AColumn: Integer);
    property Owner: TCustomGrid read FOwner;
    property Column: Integer read FColumn;
    // Expression engine requires properties to be readable
    property Data: TValue read GetData write SetData;
  end;

constructor TGridDataObject.Create(AOwner: TCustomGrid; AColumn: Integer);
begin
  FColumn := AColumn;
  FOwner := AOwner;
end;

function TGridDataObject.GetData: TValue;
begin
  Result := TValue.Empty;
end;

procedure TGridDataObject.SetData(const AValue: TValue);
begin
  if Assigned(FCallback) then
    FCallback(AValue);
end;

procedure TBindListGridEditor.GridOnCallbackGetValue(Sender: TObject; const Col, Row: Integer;
  ACallback: TProc<TValue>);
var
  LDataObject: TObject;
  LValue: TValue;
begin
  if FValues.TryGet(Col, Row, LValue) then
    ACallback(LValue)
  else
  if Assigned(FBindGridCallbackEvaluateFormat) then
  begin
    if not FColumnDataObjects.TryGetValue(Col, LDataObject) then
    begin
      // Support cached expressions by reusing the same object
      // for a particular column
      LDataObject :=  TGridDataObject.Create(FEditorObject.FGrid, Col);
      FColumnDataObjects.Add(Col, LDataObject);
    end;

    TGridDataObject(LDataObject).FCallback := ACallback;
    try
      FBindGridCallbackEvaluateFormat(Col, Row,
        WrapObject(LDataObject));
     finally
       TGridDataObject(LDataObject).FCallback := nil;
     end;
  end
end;

procedure TBindListGridEditor.GridOnSetValue(Sender: TObject; const Col, Row: Integer;
  const Value: TValue);
begin
  FValues.Add(Col, Row, Value);
end;

destructor TBindListGridEditor.Destroy;
begin
  if GEditors <> nil then
    GEditors.Remove(FEditorObject.FGrid);
  // The method may be executed as a result of FreeNotification from Grid.
  // Best practice is to not access members of a component that is being destroyed.
  if not (csDestroying in FEditorObject.FGrid.ComponentState) then
  begin
    FEditorObject.FGrid.IsUsedInBinding := False;
    FEditorObject.FGrid.OnSetValue := nil;
    FEditorObject.FGrid.OnCallbackGetValue := nil;
  end;
  FEditorObject.Free;
  FValues.Free;
  FColumnDataObjects.Free;
  inherited;
end;

procedure TBindListGridEditor.EndUpdate;
begin
  FEditorObject.FGrid.EndUpdate;
end;


function TBindListGridEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FGrid.RowCount;
end;

function TBindListGridEditor.GetSelectedText: string;
var
  LValue: TValue;
  LColumnIndex: Integer;
begin
  LColumnIndex := GetColumnIndex;
  if (GetRowIndex >= 0) and (LColumnIndex >= 0) then
  begin
    // Force editor value to be saved to cache (e.g.; FValues)
    FEditorObject.FGrid.Model.PostEditorValue;
    LValue := FValues.Get(LColumnIndex);
    if not LValue.IsEmpty then
      Result := LValue.ToString;
  end;
end;

procedure TBindListGridEditor.SetOnCallbackEvaluateFormat(AOnCallbackEvaluateFormat: TBindGridOnCallbackEvaluateFormat);
begin
  FBindGridCallbackEvaluateFormat := AOnCallbackEvaluateFormat;
end;

procedure TBindListGridEditor.SetRowCount(AValue: Integer);
begin
  FEditorObject.FGrid.RowCount := AValue;
end;

procedure TBindListGridEditor.UpdateCell(Col: Integer);
var
  LColumn: TColumn;
begin
  if (FEditorObject.FGrid.Selected >= 0) then
    begin
      LColumn := FEditorObject.FGrid.Columns[Col];
      FValues.Clear(Col);
      LColumn.UpdateCell(FEditorObject.FGrid.Selected);
    end;
end;

{ TGridItemEditorObject }

function TGridItemEditorObject.GetOwner: TCustomGrid;
begin
  Result := FGrid;
end;

type
  TOpenColumn = class (TColumn)

  end;


{ TBindCheckBoxEditorFactory }

constructor TBindCheckBoxEditorFactory.Create;
begin
  inherited;
end;

function TBindCheckBoxEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  Result := TBindStateCheckBoxEditor.Create(TCheckBox(AObject));
end;

function TBindCheckBoxEditorFactory.Supports(AIntf: TGuid;
  AObject: TObject): Boolean;
begin
  Result := False;
  if AIntf = IBindCheckBoxEditor then
    if (AObject <> nil) and AObject.InheritsFrom(TCheckBox) then
      Result := True;
end;

{ TBindStateCheckBoxEditor }

constructor TBindStateCheckBoxEditor.Create(ACheckBox: TCheckBox);
begin
  FCheckBox := ACheckBox;
end;

function TBindStateCheckBoxEditor.GetAllowGrayed: Boolean;
begin
  Result := False;                                                                              
end;

function TBindStateCheckBoxEditor.GetState: TBindCheckBoxState;
begin
                                                          
//  if GetAllowGrayed and FCheckBox.IsGrayed then
//    Result := cbGrayed
//  else
  begin
    if FCheckBox.IsChecked then
      Result := cbChecked
    else
      Result := cbUnchecked;
  end;
end;

procedure TBindStateCheckBoxEditor.SetAllowGrayed(Value: Boolean);
begin
  //Note: FMX CheckBox does not allow Grayed state
  assert(False);
end;

procedure TBindStateCheckBoxEditor.SetState(Value: TBindCheckBoxState);
begin
//  if (Value = cbGrayed) and GetAllowedGrayed then
//    FCheckBox.IsGrayed := cbGrayed
//  else
  begin
    FCheckBox.IsChecked := Value = cbChecked;
  end;
end;

{ TComboEditItemEditorObject }

procedure TComboEditItemEditorObject.ControlClear;
begin
  FListBox.Items.Clear;
end;

constructor TComboEditItemEditorObject.Create(AListBox: TComboEdit);
begin
  FListBox := AListBox;
end;

function TComboEditItemEditorObject.GetControlItemIndex: Integer;
begin
  Result := FListBox.ItemIndex;
end;

function TComboEditItemEditorObject.GetControlItems: TStrings;
begin
  Result := FListBox.Items;
end;

function TComboEditItemEditorObject.GetOwner: TComboEdit;
begin
  Result := FListBox;
end;

function TComboEditItemEditorObject.GetText: string;
begin
  Result := FListBox.Items[FIndex];

end;

procedure TComboEditItemEditorObject.SetControlItemIndex(AIndex: Integer);
begin
  FListBox.ItemIndex := AIndex;
end;

procedure TComboEditItemEditorObject.SetText(const Value: string);
begin
  FListBox.Items[FIndex] := Value;
end;


{ TValueCache }

procedure TValueCache.Add(AColumn, ARow: Integer; const AValue: TValue);
begin
  if FRow <> ARow then
  begin
    Clear;
    FRow := ARow;
  end;
  FValues.AddOrSetValue(AColumn, AValue);
end;

procedure TValueCache.Clear;
begin
  FValues.Clear;
  FRow := -1;
end;

procedure TValueCache.Clear(AColumn: Integer);
begin
  FValues.Remove(AColumn);
end;

constructor TValueCache.Create;
begin
  FRow := -1;
  FValues := TDictionary<Integer, TValue>.Create;
end;

destructor TValueCache.Destroy;
begin
  FValues.Free;
  inherited;
end;

function TValueCache.Get(AColumn: Integer): TValue;
begin
  if not FValues.TryGetValue(AColumn, Result) then
    Result := TValue.Empty;

end;

function TValueCache.TryGet(AColumn, ARow: Integer; out AValue: TValue): Boolean;
begin
  Result := (ARow = FRow) and FValues.TryGetValue(AColumn, AValue);
end;

const
  sFmx = 'FMX';

{ TBindListListItemEditorObject }

function TBindListListItemEditorObject.CurrentTextControl: TTextControl;
begin
  Result := CurrentItem;
end;

destructor TBindListListItemEditorObject.Destroy;
begin
  FListBoxItemData.Free;
  inherited;
end;

function TBindListListItemEditorObject.GetData: TObject;
begin
  if CheckRange then
    Result := CurrentItem.Data
  else
    Result := nil;
end;

function TBindListListItemEditorObject.GetItemData: TBindListBoxItemData;
begin
  if FListBoxItemData = nil then
    FListBoxItemData := TBindListBoxItemData.Create(Self);
  if CheckRange then
    Result := FListBoxItemData // CurrentItem.ItemData
  else
    Result := nil;
end;

function TBindListListItemEditorObject.GetIsChecked: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.IsChecked
  else
    Result := False;

end;

function TBindListListItemEditorObject.GetImageIndex: Integer;
begin
  if CheckRange then
    Result := CurrentItem.ImageIndex
  else
    Result := -1;
end;

function TBindListListItemEditorObject.GetIsSelected: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.IsSelected
  else
    Result := False;
end;

procedure TBindListListItemEditorObject.SetData(const Value: TObject);
begin
  if CheckRange then
    CurrentItem.Data := Value;

end;

procedure TBindListListItemEditorObject.SetIsChecked(const Value: Boolean);
begin
  if CheckRange then
    CurrentItem.IsChecked := Value;
end;

procedure TBindListListItemEditorObject.SetImageIndex(Value: Integer);
begin
  if CheckRange then
    CurrentItem.ImageIndex := Value;
end;

procedure TBindListListItemEditorObject.SetIsSelected(const Value: Boolean);
begin
  if CheckRange then
    CurrentItem.IsSelected := Value;
end;

{ TBindListListBoxEditorObject }

function TBindListListBoxEditorObject.CheckRange: Boolean;
begin
  Result := (FItemIndex >= 0) and (FItemIndex < FListBox.Items.Count);

end;

function TBindListListBoxEditorObject.CurrentItem: TListBoxItem;
begin
  Assert(CheckRange);
  if CheckRange then
    Result := FListBox.ListItems[FItemIndex]
  else
    Result := nil;

end;

{ TBindListComboBoxEditorObject }

function TBindListComboBoxEditorObject.CheckRange: Boolean;
begin
  Result := (FItemIndex >= 0) and (FItemIndex < FComboBox.Items.Count);

end;

function TBindListComboBoxEditorObject.CurrentItem: TListBoxItem;
begin
  Assert(CheckRange);
  if CheckRange then
    Result := FComboBox.ListItems[FItemIndex]
  else
    Result := nil;

end;

{ TFmxObjectEditorObject }

function TFmxObjectEditorObject.FindStyleResource(
  const AStyleLookup: string): TFmxObject;
begin
  if CheckRange then
    Result := CurrentFmxObject.FindStyleResource(AStyleLookup)
  else
    Result := nil;
end;

function TFmxObjectEditorObject.GetData: TValue;
begin
  if CheckRange then
    Result := CurrentFmxObject.Data
  else
    Result := TValue.Empty;
end;

function TFmxObjectEditorObject.GetIndex: Integer;
begin
  if CheckRange then
    Result := CurrentFmxObject.Index
  else
    Result := 0;
end;

function TFmxObjectEditorObject.GetParent: TFmxObject;
begin
  if CheckRange then
    Result := CurrentFmxObject.Parent
  else
    Result := nil;
end;

function TFmxObjectEditorObject.GetTagFloat: Single;
begin
  if CheckRange then
    Result := CurrentFmxObject.TagFloat
  else
    Result := 0;
end;

function TFmxObjectEditorObject.GetTagObject: TObject;
begin
  if CheckRange then
    Result := CurrentFmxObject.TagObject
  else
    Result := nil;
end;

function TFmxObjectEditorObject.GetTagString: string;
begin
  if CheckRange then
    Result := CurrentFmxObject.TagString
  else
    Result := '';
end;

procedure TFmxObjectEditorObject.SetData(const Value: TValue);
begin
  if CheckRange then
    CurrentFmxObject.Data := Value;
end;

procedure TFmxObjectEditorObject.SetIndex(const Value: Integer);
begin
  if CheckRange then
    CurrentFmxObject.Index := Value;
end;


procedure TFmxObjectEditorObject.SetParent(const Value: TFmxObject);
begin

end;

type
  // Temporary
  TControlCracker = class(TControl)

  end;

procedure TFmxObjectEditorObject.SetTagFloat(const Value: Single);
begin
  if CheckRange then
    CurrentFmxObject.TagFloat := Value;
end;

procedure TFmxObjectEditorObject.SetTagObject(const Value: TObject);
begin
  if CheckRange then
    CurrentFmxObject.TagObject := Value;
end;

procedure TFmxObjectEditorObject.SetTagString(const Value: string);
begin
  if CheckRange then
    CurrentFmxObject.TagString := Value;
end;

{ TControlEditorObject }

function TControlEditorObject.CurrentFmxObject: TFmxObject;
begin
  Result := CurrentControl;
end;

function TControlEditorObject.GetAlign: TAlignLayout;
begin
  if CheckRange then
    Result := CurrentControl.Align
  else
    Result := TAlignLayout.None

end;

function TControlEditorObject.GetClipChildren: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.ClipChildren
  else
    Result := False;
end;

function TControlEditorObject.GetClipParent: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.ClipParent
  else
    Result := False;
end;

function TControlEditorObject.GetDragMode: TDragMode;
begin
  if CheckRange then
    Result := CurrentControl.DragMode
  else
    Result := TDragMode.dmManual;
end;

function TControlEditorObject.GetEnabled: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.Enabled
  else
    Result := False;
end;

function TControlEditorObject.GetEnableDragHighlight: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.EnableDragHighlight
  else
    Result := False;
end;

function TControlEditorObject.GetHeight: Single;
begin
  if CheckRange then
    Result := CurrentControl.Height
  else
    Result := 0;
end;

function TControlEditorObject.GetHitTest: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.HitTest
  else
    Result := False;
end;

function TControlEditorObject.GetLocked: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.Locked
  else
    Result := False;
end;

function TControlEditorObject.GetMargins: TBounds;
begin
  if CheckRange then
    Result := CurrentControl.Margins
  else
    Result := nil; //TBounds.Create(TRectF.Create(0,0));
end;

function TControlEditorObject.GetOpacity: Single;
begin
  if CheckRange then
    Result := CurrentControl.Opacity
  else
    Result := 0;
end;

function TControlEditorObject.GetPadding: TBounds;
begin
  if CheckRange then
    Result := CurrentControl.Padding
  else
    Result := nil;
end;

function TControlEditorObject.GetPopupMenu: TCustomPopupMenu;
begin
  if CheckRange then
    Result := CurrentControl.PopupMenu
  else
    Result := nil;
end;

function TControlEditorObject.GetPosition: TPosition;
begin
  if CheckRange then
    Result := CurrentControl.Position
  else
    Result := nil
end;

function TControlEditorObject.GetRotationAngle: Single;
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    Result := LRotatedControl.RotationAngle
  else
    Result := 0;
end;

function TControlEditorObject.GetRotationCenter: TPosition;
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    Result := LRotatedControl.RotationCenter
  else
    Result := nil
end;

function TControlEditorObject.GetScale: TPosition;
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    Result := LRotatedControl.Scale
  else
    Result := nil
end;

function TControlEditorObject.GetTabOrder: TTabOrder;
begin
  if CheckRange then
    Result := CurrentControl.TabOrder
  else
    Result := 0;
end;

function TControlEditorObject.GetVisible: Boolean;
begin
  if CheckRange then
    Result := CurrentControl.Visible
  else
    Result := False;
end;

function TControlEditorObject.GetWidth: Single;
begin
  if CheckRange then
    Result := CurrentControl.Width
  else
    Result := 0;
end;

procedure TControlEditorObject.SetAlign(const Value: TAlignLayout);
begin
  if CheckRange then
    CurrentControl.Align := Value;
end;

procedure TControlEditorObject.SetClipChildren(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.ClipChildren := Value;
end;

procedure TControlEditorObject.SetClipParent(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.ClipParent := Value;
end;

procedure TControlEditorObject.SetDragMode(const Value: TDragMode);
begin
  if CheckRange then
    CurrentControl.DragMode := Value;
end;

procedure TControlEditorObject.SetEnabled(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.Enabled := Value;
end;

procedure TControlEditorObject.SetEnableDragHighlight(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.EnableDragHighlight := Value;
end;

procedure TControlEditorObject.SetHeight(const Value: Single);
begin
  if CheckRange then
    CurrentControl.Height := Value;
end;

procedure TControlEditorObject.SetHitTest(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.HitTest := Value;
end;

procedure TControlEditorObject.SetLocked(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.Locked := Value;
end;

procedure TControlEditorObject.SetMargins(const Value: TBounds);
begin
  if CheckRange then
    CurrentControl.Margins := Value;
end;

procedure TControlEditorObject.SetOpacity(const Value: Single);
begin
  if CheckRange then
    CurrentControl.Opacity := Value;
end;

procedure TControlEditorObject.SetPadding(const Value: TBounds);
begin
  if CheckRange then
    CurrentControl.Padding := Value;
end;

procedure TControlEditorObject.SetPopupMenu(const Value: TCustomPopupMenu);
begin
  if CheckRange then
    CurrentControl.PopupMenu := Value;
end;

procedure TControlEditorObject.SetPosition(const Value: TPosition);
begin
  if CheckRange then
    CurrentControl.Position := Value;
end;

procedure TControlEditorObject.SetRotationAngle(const Value: Single);
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    LRotatedControl.RotationAngle := Value;
end;

procedure TControlEditorObject.SetRotationCenter(const Value: TPosition);
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    LRotatedControl.RotationCenter := Value;
end;

procedure TControlEditorObject.SetScale(const Value: TPosition);
var
  LRotatedControl: IRotatedControl;
begin
  if CheckRange and Supports(CurrentControl, IRotatedControl, LRotatedControl) then
    LRotatedControl.Scale := Value;
end;

procedure TControlEditorObject.SetTabOrder(const Value: TTabOrder);
begin
  if CheckRange then
    CurrentControl.TabOrder := Value;
end;

procedure TControlEditorObject.SetVisible(const Value: Boolean);
begin
  if CheckRange then
    CurrentControl.Visible := Value;
end;

procedure TControlEditorObject.SetWidth(const Value: Single);
begin
  if CheckRange then
    CurrentControl.Width := Value;
end;

{ TStyledControlEditorObject }

function TStyledControlEditorObject.CurrentControl: TControl;
begin
  Result := CurrentStyledControl;
end;

function TStyledControlEditorObject.GetAutoTranslate: Boolean;
begin
  if CheckRange then
    Result := CurrentStyledControl.AutoTranslate
  else
    Result := False;
end;

function TStyledControlEditorObject.GetHelpContext: THelpContext;
begin
  if CheckRange then
    Result := CurrentStyledControl.HelpContext
  else
    Result := 0;
end;

function TStyledControlEditorObject.GetHelpKeyword: string;
begin
  if CheckRange then
    Result := CurrentStyledControl.HelpKeyword
  else
    Result := '';
end;

function TStyledControlEditorObject.GetHelpType: THelpType;
begin
  if CheckRange then
    Result := CurrentStyledControl.HelpType
  else
    Result := THelpType.htKeyword;
end;

function TStyledControlEditorObject.GetStyleLookup: string;
begin
 if CheckRange then
   Result := CurrentStyledControl.StyleLookup
 else
   Result := '';
end;

function TStyledControlEditorObject.GetStyleData(const Index: string): TValue;
begin
  if CheckRange then
    Result := CurrentStyledControl.StylesData[Index]
  else
    Result := TValue.Empty;
end;

procedure TStyledControlEditorObject.SetAutoTranslate(const Value: Boolean);
begin
 if CheckRange then
   CurrentStyledControl.AutoTranslate := Value;
end;

procedure TStyledControlEditorObject.SetHelpContext(const Value: THelpContext);
begin
 if CheckRange then
   CurrentStyledControl.HelpContext := Value;
end;

procedure TStyledControlEditorObject.SetHelpKeyword(const Value: string);
begin
 if CheckRange then
   CurrentStyledControl.HelpKeyword := Value;
end;

procedure TStyledControlEditorObject.SetHelpType(const Value: THelpType);
begin
  if CheckRange then
    CurrentStyledControl.HelpType := Value;
end;

procedure TStyledControlEditorObject.SetStyleLookup(const Value: string);
begin
  if CheckRange then
    CurrentStyledControl.StyleLookup := Value;
end;

procedure TStyledControlEditorObject.SetStyleData(const Index: string;
  const Value: TValue);
begin
  if CheckRange then
    CurrentStyledControl.StylesData[Index] := Value;
end;

{ TTextControlEditorObject }

function TTextControlEditorObject.CurrentStyledControl: TStyledControl;
begin
  Result := CurrentTextControl;
end;

function TTextControlEditorObject.GetFont: TFont;
begin
  if CheckRange then
    Result := CurrentTextControl.Font
  else
    Result := nil;

end;

function TTextControlEditorObject.GetFontColor: TAlphaColor;
begin
  if CheckRange then
    Result := CurrentTextControl.FontColor
  else
    Result := 0;
end;

function TTextControlEditorObject.GetText: string;
begin
  if CheckRange then
    Result := CurrentTextControl.Text
  else
    Result := '';
end;

function TTextControlEditorObject.GetTextAlign: TTextAlign;
begin
  if CheckRange then
    Result := CurrentTextControl.TextAlign
  else
    Result := TTextAlign.Center;
end;

function TTextControlEditorObject.GetVertTextAlign: TTextAlign;
begin
  if CheckRange then
    Result := CurrentTextControl.VertTextAlign
  else
    Result := TTextAlign.Center;
end;

function TTextControlEditorObject.GetWordWrap: Boolean;
begin
  if CheckRange then
    Result := CurrentTextControl.WordWrap
  else
    Result := False;
end;

procedure TTextControlEditorObject.SetFont(const Value: TFont);
begin
  if CheckRange then
    CurrentTextControl.Font := Value;
end;

procedure TTextControlEditorObject.SetFontColor(const Value: TAlphaColor);
begin
  if CheckRange then
    CurrentTextControl.FontColor := Value;
end;

procedure TTextControlEditorObject.SetText(const Value: string);
begin
  Assert(CurrentTextControl.IsUpdating);
  if CheckRange then
    CurrentTextControl.Text := Value;
end;

procedure TTextControlEditorObject.SetTextAlign(const Value: TTextAlign);
begin
  if CheckRange then
    CurrentTextControl.TextAlign := Value;
end;

procedure TTextControlEditorObject.SetVertTextAlign(const Value: TTextAlign);
begin
  if CheckRange then
    CurrentTextControl.VertTextAlign := Value;
end;

procedure TTextControlEditorObject.SetWordWrap(const Value: Boolean);
begin
  if CheckRange then
    CurrentTextControl.WordWrap := Value;
end;

{ TBindMetroListBoxEditorFactory }

function TBindMetroListBoxEditorFactory.CreateNamedEditor(AIntf: TGuid;
  const AName: string; AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    // Get existing editor
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      if AObject is TCustomListBox then
        if SameText(AName, sItemDataEditor) then
          Result := TBindListItemDataListBoxEditor.Create(TCustomListBox(AObject))
        else
          Result := TBindListMetroListBoxEditor.Create(TCustomListBox(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListListBoxEditor);
      Result := LEditor as TBindListListBoxEditor;
    end;
end;

function TBindMetroListBoxEditorFactory.GetNames: TArray<string>;
begin
  Result := TArray<string>.Create(sMetroEditor, sItemDataEditor);
end;

function TBindMetroListBoxEditorFactory.HasNamedEditor(
  const AName: string): Boolean;
var
  s: string;
begin
  Result := False;
  for s in GetNames do
    if SameText(AName, s) then
      Exit(True);
end;

{ TBindMetroListBoxEditorFactory }

function TBindMetroComboBoxEditorFactory.CreateNamedEditor(AIntf: TGuid;
  const AName: string; AObject: TObject): IInterface;
var
  LEditor: IInterface;
begin
  if AObject is TComponent then
    // Get existing editor
    if not GEditors.TryGetValue(TComponent(AObject), LEditor) then
    begin
      if AObject is TCustomComboBox then
        if SameText(AName, sItemDataEditor) then
          Result := TBindListItemDataComboBoxEditor.Create(TCustomComboBox(AObject))
       else
          Result := TBindListMetroComboBoxEditor.Create(TCustomComboBox(AObject))
    end
    else
    begin
      Assert(LEditor is TBindListComboBoxEditor);
      Result := LEditor as TBindListComboBoxEditor;
    end;
end;

function TBindMetroComboBoxEditorFactory.GetNames: TArray<string>;
begin
  Result := TArray<string>.Create(sMetroEditor, sItemDataEditor);
end;

function TBindMetroComboBoxEditorFactory.HasNamedEditor(
  const AName: string): Boolean;
var
  s: string;
begin
  Result := False;
  for s in GetNames do
    if SameText(AName, s) then
      Exit(True);
end;

{ TBindListMetroListBoxEditorObject }

function TBindListMetroListBoxEditorObject.CurrentItem: TMetropolisUIListBoxItem;
begin
  Assert((inherited CurrentItem = nil) or (inherited CurrentItem is TMetropolisUIListBoxItem));
  Result := inherited CurrentItem as TMetropolisUIListBoxItem;

end;

function TBindListMetroListBoxEditorObject.GetDescription: String;
begin
  if CheckRange then
    Result := CurrentItem.Description
  else
    Result := '';

end;

function TBindListMetroListBoxEditorObject.GetIcon: TBitmap;
begin
  if CheckRange then
    Result := CurrentItem.Icon
  else
    Result := nil;
end;

function TBindListMetroListBoxEditorObject.GetIconSize: Integer;
begin
  if CheckRange then
    Result := CurrentItem.IconSize
  else
    Result := 0;
end;

function TBindListMetroListBoxEditorObject.GetSubTitle: String;
begin
  if CheckRange then
    Result := CurrentItem.SubTitle
  else
    Result := '';
end;

function TBindListMetroListBoxEditorObject.GetText: string;
begin
  Result := Title;
end;

function TBindListMetroListBoxEditorObject.GetTitle: String;
begin
  if CheckRange then
    Result := CurrentItem.Title
  else
    Result := '';
end;

procedure TBindListMetroListBoxEditorObject.SetDescription(const Value: String);
begin
  if CheckRange then
    CurrentItem.Description := Value;
end;

procedure TBindListMetroListBoxEditorObject.SetIcon(const Value: TBitmap);
begin
  if CheckRange then
    CurrentItem.Icon := Value;
end;

procedure TBindListMetroListBoxEditorObject.SetIconSize(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.IconSize := Value;
end;

procedure TBindListMetroListBoxEditorObject.SetSubTitle(const Value: String);
begin
  if CheckRange then
    CurrentItem.SubTitle := Value;
end;

procedure TBindListMetroListBoxEditorObject.SetText(const Value: string);
begin
  Title := Value;

end;

procedure TBindListMetroListBoxEditorObject.SetTitle(const Value: String);
begin
  if CheckRange then
    CurrentItem.Title := Value;
end;

{ TBindListMetroComboBoxEditorObject }

function TBindListMetroComboBoxEditorObject.CurrentItem: TMetropolisUIListBoxItem;
begin
  Assert((CurrentItem = nil) or (CurrentItem is TMetropolisUIListBoxItem));
  Result := CurrentItem as TMetropolisUIListBoxItem;

end;


function TBindListMetroComboBoxEditorObject.GetDescription: String;
begin
  if CheckRange then
    Result := CurrentItem.Description
  else
    Result := '';

end;

function TBindListMetroComboBoxEditorObject.GetIcon: TBitmap;
begin
  if CheckRange then
    Result := CurrentItem.Icon
  else
    Result := nil;
end;

function TBindListMetroComboBoxEditorObject.GetIconSize: Integer;
begin
  if CheckRange then
    Result := CurrentItem.IconSize
  else
    Result := 0;
end;

function TBindListMetroComboBoxEditorObject.GetSubTitle: String;
begin
  if CheckRange then
    Result := CurrentItem.SubTitle
  else
    Result := '';
end;

function TBindListMetroComboBoxEditorObject.GetTitle: String;
begin
  if CheckRange then
    Result := CurrentItem.Title
  else
    Result := '';
end;

procedure TBindListMetroComboBoxEditorObject.SetDescription(const Value: String);
begin
  if CheckRange then
    CurrentItem.Description := Value;
end;

procedure TBindListMetroComboBoxEditorObject.SetIcon(const Value: TBitmap);
begin
  if CheckRange then
    CurrentItem.Icon := Value;
end;

procedure TBindListMetroComboBoxEditorObject.SetIconSize(const Value: Integer);
begin
  if CheckRange then
    CurrentItem.IconSize := Value;
end;

procedure TBindListMetroComboBoxEditorObject.SetSubTitle(const Value: String);
begin
  if CheckRange then
    CurrentItem.SubTitle := Value;
end;

procedure TBindListMetroComboBoxEditorObject.SetTitle(const Value: String);
begin
  if CheckRange then
    CurrentItem.Title := Value;
end;
{ TBindListMetroListBoxEditor }

function TBindListMetroListBoxEditor.CreateEditorObject: TBindListListBoxEditorObject;
begin
  Result := TBindListMetroListBoxEditorObject.Create;
end;

function TBindListMetroListBoxEditor.CreateItem: TListBoxItem;
begin
  Result := CreateListBoxItem(TMetropolisUIListBoxItem);
end;

procedure AddMetroMemberNames(ANames: TStrings);
var
  s: string;
begin
  ANames.Clear;
  for s in  GetMetroListBoxItemMemberNames do
    ANames.Add(s);
end;

function TBindListMetroListBoxEditor.GetItemMemberNameExpression(
  const AName: string): string;
var
  s: string;
begin
  for s in  GetMetroListBoxItemMemberNames do
    if SameText(s, AName) then
      Exit(AName);
  Result := inherited;
end;

procedure TBindListMetroListBoxEditor.GetItemMemberNames(ANames: TStrings);
begin
  AddMetroMemberNames(ANames);
end;

{ TBindListItemDataListBoxEditor }


procedure TBindListItemDataListBoxEditor.GetItemMemberNames(ANames: TStrings);
begin
  AddListBoxItemDataMemberNames(ANames);
end;

{ TBindListMetroComboBoxEditor }

function TBindListMetroComboBoxEditor.CreateEditorObject: TBindListComboBoxEditorObject;
begin
  Result := TBindListMetroComboBoxEditorObject.Create;
end;

function TBindListMetroComboBoxEditor.CreateItem: TListBoxItem;
begin
  Result := CreateListBoxItem(TMetropolisUIListBoxItem);
end;

function TBindListMetroComboBoxEditor.GetItemMemberNameExpression(
  const AName: string): string;
var
  s: string;
begin
  for s in  GetMetroListBoxItemMemberNames do
    if SameText(s, AName) then
      Exit(AName);
  Result := inherited;
end;

procedure TBindListMetroComboBoxEditor.GetItemMemberNames(ANames: TStrings);
begin
  AddMetroMemberNames(ANames);
end;

{ TBindListItemDataComboBoxEditor }

procedure TBindListItemDataComboBoxEditor.GetItemMemberNames(ANames: TStrings);
begin
  AddListBoxItemDataMemberNames(ANames);
end;

{ TBindListBoxItemData }

constructor TBindListBoxItemData.Create(
  AEditorObject: TBindListListItemEditorObject);
begin
  FEditorObject := AEditorObject;
end;

function TBindListBoxItemData.GetAccessory: TValue;
begin
  Assert(FEditorObject.CheckRange);
  Result := Integer(FEditorObject.CurrentItem.ItemData.Accessory);

end;

function TBindListBoxItemData.GetBitmap: TBitmap;
begin
  Assert(FEditorObject.CheckRange);
  Result := FEditorObject.CurrentItem.ItemData.Bitmap;
end;

function TBindListBoxItemData.GetDetail: string;
begin
  Assert(FEditorObject.CheckRange);
  Result := FEditorObject.CurrentItem.ItemData.Detail;
end;

function TBindListBoxItemData.GetText: string;
begin
  Assert(FEditorObject.CheckRange);
  Result := FEditorObject.CurrentItem.ItemData.Text;
end;

procedure TBindListBoxItemData.SetAccessory(const Value: TValue);
var
  LInteger: Integer;
  LValue: TListBoxItemData.TAccessory;
  LHaveValue: Boolean;
begin
  Assert(FEditorObject.CheckRange);
  LHaveValue := Value.TryAsType<Integer>(LInteger);
  if not LHaveValue then
    LHaveValue := TryStrToInt(Value.ToString, LInteger);
  if LHaveValue then
  begin
    case LInteger of
      Integer(TListBoxItemData.TAccessory.aNone),
      Integer(TListBoxItemData.TAccessory.aMore),
      Integer(TListBoxItemData.TAccessory.aDetail),
      Integer(TListBoxItemData.TAccessory.aCheckmark):
      begin
        LValue := TListBoxItemData.TAccessory(LInteger);
        FEditorObject.CurrentItem.ItemData.Accessory := LValue;
      end;
    end;
  end;
end;

procedure TBindListBoxItemData.SetBitmap(const Value: TBitmap);
begin
  Assert(FEditorObject.CheckRange);
  FEditorObject.CurrentItem.ItemData.Bitmap := Value;
end;

procedure TBindListBoxItemData.SetDetail(const Value: string);
begin
  Assert(FEditorObject.CheckRange);
  FEditorObject.CurrentItem.ItemData.Detail := Value;
end;

procedure TBindListBoxItemData.SetText(const Value: string);
begin
  Assert(FEditorObject.CurrentItem.IsUpdating);
  Assert(FEditorObject.CheckRange);
  FEditorObject.CurrentItem.ItemData.Text := Value;
end;

{ TListViewItemEditorObject }

function TListViewItemEditorObject.CurrentItem: TListViewItem;
var
  Filterable: IListViewFilterable;
begin
  Assert(CheckRange);
  if CheckRange then
    if (FIndexType = TItemIndexType.Unfiltered) and Supports(FListView.Items, IListViewFilterable, Filterable) then
      Result := TListViewItem(Filterable.UnfilteredItems[FItemIndex])
    else
      Result := FListView.Items[FItemIndex]
  else
    Result := nil;
end;


function TListViewItemEditorObject.CheckRange: Boolean;
var
  Filterable: IListViewFilterable;
begin
  if (FIndexType = TItemIndexType.Unfiltered) and Supports(FListView.Items, IListViewFilterable, Filterable) then
    Result := (FItemIndex >= 0) and (FItemIndex < Filterable.UnfilteredItems.Count)
  else
    Result := (FItemIndex >= 0) and (FItemIndex < FListView.Items.Count);
end;

function TListViewItemEditorObject.GetTag: NativeInt;
begin
  if CheckRange then
    Result := CurrentItem.Tag
  else
    Result := 0;
end;

function TListViewItemEditorObject.GetText: string;
begin
  if CheckRange then
    Result := CurrentItem.Text
  else
    Result := ''

end;

function TListViewItemEditorObject.GetData(const AIndex: string): TValue;
begin
  if CheckRange then
    Result := CurrentItem.Data[AIndex]
  else
    Result := ''
end;

function TListViewItemEditorObject.GetDetail: string;
begin
  if CheckRange then
    Result := CurrentItem.Detail
  else
    Result := ''

end;

function TListViewItemEditorObject.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

function TListViewItemEditorObject.GetButtonText: string;
begin
  if CheckRange then
    Result := CurrentItem.ButtonText
  else
    Result := ''

end;

function TListViewItemEditorObject.GetImageIndex: Integer;
begin
  if CheckRange then
    Result := CurrentItem.ImageIndex
  else
    Result := -1
end;

function TListViewItemEditorObject.GetChecked: Boolean;
begin
  if CheckRange then
    Result := CurrentItem.Checked
  else
    Result := False
end;

function TListViewItemEditorObject.GetBitmap: TBitmap;
begin
  if CheckRange then
    Result := CurrentItem.Bitmap
  else
    Result := nil

end;

function TListViewItemEditorObject.GetOwner: TCustomListView;
begin
  Result := FListView;
end;

procedure TListViewItemEditorObject.SetTag(Value: NativeInt);
begin
  if CheckRange then
    CurrentItem.Tag := Value;
end;

procedure TListViewItemEditorObject.SetText(const Value: string);
begin
  if CheckRange then
  begin
    CurrentItem.Text := Value;
    Assert(CurrentItem.Text = Value);
  end;
end;

procedure TListViewItemEditorObject.SetData(const AIndex: string;
  const Value: TValue);
begin
  if CheckRange then
    CurrentItem.Data[AIndex] := Value;
end;

procedure TListViewItemEditorObject.SetDetail(const Value: string);
begin
  if CheckRange then
  begin
    CurrentItem.Detail := Value;
    Assert(CurrentItem.Detail = Value);
  end;
end;

procedure TListViewItemEditorObject.SetItemIndex(AIndex: Integer;
  AIndexType: TItemIndexType);
begin
  FItemIndex := AIndex;
  FIndexType := AIndexType;
end;

procedure TListViewItemEditorObject.SetBitmap(const Value: TBitmap);
begin
  if CheckRange then
    CurrentItem.Bitmap := Value;
end;

procedure TListViewItemEditorObject.SetButtonText(const Value: string);
begin
  if CheckRange then
  begin
    CurrentItem.ButtonText := Value;
    Assert(CurrentItem.ButtonText = Value);
  end;
end;

procedure TListViewItemEditorObject.SetImageIndex(Value: Integer);
begin
  if CheckRange then
    CurrentItem.ImageIndex := Value;
end;

procedure TListViewItemEditorObject.SetChecked(const Value: Boolean);
begin
  if CheckRange then
  begin
    CurrentItem.Checked := Value;
    Assert(CurrentItem.Checked = Value);
  end;
end;

{ TBindListListViewEditor }

type
  TCustomListViewHack = class(TCustomListView);

function TBindListViewEditor.AddItem(Select: Boolean): IScope;
var
  LListItem: TListViewItem;
  LUnfilteredItems: TListItemsList;
  LIndex: Integer;
  Filterable: IListViewFilterable;
begin
  FApplyFilter := True;
  LListItem := FEditorObject.FListView.Items.Add;
  LListItem.Tag := NextKey;
  if IsFiltered and Supports(FEditorObject.FListView.Items, IListViewFilterable, Filterable) then
  begin
    LUnfilteredItems := Filterable.UnfilteredItems;
    LIndex := LUnfilteredItems.Count - 1;
  end
  else
    LIndex := LListItem.Index;
  // When filtering, TListView adds to unfiltered list
  FEditorObject.SetItemIndex(LIndex, TItemIndexType.Unfiltered);
  if Select and not IsFiltered then
  begin
    FEditorObject.FListView.ItemIndex := LIndex;
  end;
  Result := WrapObject(FEditorObject);
end;

procedure TBindListViewEditor.ApplyFilter;
begin
  if FApplyFilter then
  begin
    FApplyFilter := False;
    if FEditorObject.FListView.Items.Filtered then
      // Reapply filter
      FEditorObject.FListView.Items.AsFilterable.Filter := FEditorObject.FListView.Items.AsFilterable.Filter;
  end;
end;

function TBindListViewEditor.AddHeader: IScope;
var
  LListItem: TListViewItem;
  LUnfilteredItems: TListItemsList;
  LIndex: Integer;
begin
  FApplyFilter := True;
  LListItem := FEditorObject.FListView.Items.Add;
  LListItem.Purpose := TListItemPurpose.Header;
  if IsFiltered then
  begin
    LUnfilteredItems := FEditorObject.FListView.Items.AsFilterable.UnfilteredItems;
    LIndex := LUnfilteredItems.Count - 1;
  end
  else
    LIndex := LListItem.Index;
  // When filtering, TListView adds to unfiltered list
  FEditorObject.SetItemIndex(LIndex, TItemIndexType.Unfiltered);
  Result := WrapObject(FEditorObject);
end;


function TBindListViewEditor.CanInsertItem: Boolean;
begin
  Result := FEditorObject.FListView.ItemIndex <> -1;
end;

function TBindListViewEditor.InsertItem(Select: Boolean): IScope;
var
  LListItem: TListViewItem;
begin
  if FEditorObject.FListView.ItemIndex = -1 then
    Exit(nil);
  FApplyFilter := True;
  LListItem := FEditorObject.FListView.Items.Insert(FEditorObject.FListView.ItemIndex);
  LListItem.Tag := NextKey;
  // When filtering, TListView adds to unfiltered list
  FEditorObject.SetItemIndex(LListItem.Index, TItemIndexType.Unfiltered);
  if Select and not IsFiltered then
  begin
    FEditorObject.FListView.ItemIndex := FEditorObject.GetItemIndex;
  end;

  Result := WrapObject(FEditorObject);
end;

function TBindListViewEditor.CurrentItem: IScope;
var
  LIndex: Integer;
begin
  if FEditorObject.GetItemIndex = -1 then
  begin
    LIndex := FEditorObject.FListView.ItemIndex;
    // ignore headers and footers
    if (LIndex >= 0) and (LIndex < FEditorObject.FListView.Items.Count) then
      if FEditorObject.FListView.Items[LIndex].Purpose = TListItemPurpose.None then
         FEditorObject.SetItemIndex(LIndex);
  end;
  Result := WrapObject(FEditorObject);
end;

function TBindListViewEditor.CurrentIndex: Integer;
begin
  if FEditorObject.GetItemIndex = -1 then
    FEditorObject.SetItemIndex(FEditorObject.FListView.ItemIndex);
   Result := FEditorObject.GetItemIndex;
end;

function TBindListViewEditor.CurrentObject: TObject;
begin
  if FEditorObject.GetItemIndex = -1 then
    FEditorObject.SetItemIndex(FEditorObject.FListView.ItemIndex);
   Result := FEditorObject.CurrentItem;
end;

function TBindListViewEditor.CurrentHeaderItem: IScope;
begin
  Result := CurrentItem;
end;

procedure TBindListViewEditor.BeginUpdate;
begin
  Inc(FUpdateCounter);
  if FUpdateCounter = 1 then
  begin
    FApplyFilter := False;
    FEditorObject.SetItemIndex(-1);
  end;
  FEditorObject.FListView.BeginUpdate;

end;

procedure TBindListViewEditor.ClearList;
begin
  FEditorObject.FListView.Items.Clear;
  FEditorObject.SetItemIndex(-1);
end;

constructor TBindListViewEditor.Create(AListView: TCustomListView);
begin
  FEditorObject := TListViewItemEditorObject.Create;
  FEditorObject.FListView := AListView;
  FEditorObject.SetItemIndex(-1);
  GEditors.Add(AListView, Self);
end;

procedure TBindListViewEditor.DeleteToEnd;
begin
  if FEditorObject.GetItemIndex = -1 then
    FEditorObject.SetItemIndex(FEditorObject.FListView.ItemIndex);
  while FEditorObject.FListView.Items.Count > Max(0, FEditorObject.GetItemIndex) do
  begin
    FEditorObject.FListView.Items.Delete(FEditorObject.FListView.Items.Count-1);
  end;
  FEditorObject.SetItemIndex(FEditorObject.FListView.Items.Count);
end;

destructor TBindListViewEditor.Destroy;
begin
  if GEditors <> nil then
    GEditors.Remove(FEditorObject.FListView);
  FEditorObject.Free;
  inherited;
end;

procedure TBindListViewEditor.EndUpdate;
begin
  Dec(FUpdateCounter);
  Assert(FUpdateCounter >= 0);
  if FUpdateCounter = 0 then
    FEditorObject.SetItemIndex(-1);
  FEditorObject.FListView.EndUpdate;
end;

function TBindListViewEditor.GetRowCount: Integer;
begin
  Result := FEditorObject.FListView.Items.Count;
end;

function TBindListViewEditor.GetSelectedText: string;
begin
  if FEditorObject.FListView.ItemIndex <> -1 then
    Result := FEditorObject.FListView.Items[FEditorObject.FListView.ItemIndex].Text;
end;

function TBindListViewEditor.MoveNext: Boolean;
begin
  Assert(FUpdateCounter > 0);
  if FEditorObject.GetItemIndex = -1 then
  begin
    FEditorObject.SetItemIndex(FEditorObject.FListView.ItemIndex);
    if FEditorObject.GetItemIndex < 0 then
      FEditorObject.SetItemIndex(0);
  end
  else
    FEditorObject.SetItemIndex(FEditorObject.GetItemIndex + 1);
  Result := (FEditorObject.GetItemIndex >= 0) and (FEditorObject.GetItemIndex < FEditorObject.FListView.Items.Count);
end;

function TBindListViewEditor.IsFiltered: Boolean;
begin
  Result := FEditorObject.FListView.Items.Filtered;
end;

function TBindListViewEditor.IsGrouped: Boolean;
begin
  // Check second item in case item is inserted without header
  Result := ((FEditorObject.FListView.Items.Count > 0) and
  (FEditorObject.FListView.Items[0].Purpose <> TListItemPurpose.None)) or
  ((FEditorObject.FListView.Items.Count > 1) and
  (FEditorObject.FListView.Items[1].Purpose <> TListItemPurpose.None))
end;

function TBindListViewEditor.RefreshNeeded(
  ARecordEnumerator: IScopeRecordEnumerator): Boolean;
begin
  Result := inherited;
  if not Result then
  begin
    Result := IsFiltered or IsGrouped;
  end;
end;

procedure TBindListViewEditor.SetSynchIndex(AIndex: Integer);

  function SynchOffsetToIndex(AOffset: Integer; AItems: TListItemsList): Integer;
  var
    I: Integer;
    LItem: TListItem;
    LCounter: Integer;
  begin
    Result := -1;
    LCounter := -1;
    for I := 0 to AItems.Count - 1 do
    begin
      LItem := AItems[I];
      if LItem.Purpose = TListItemPurpose.None then
      begin
        Inc(LCounter);
        if LCounter = AOffset then
        begin
          Result := I;
          break;
        end;
      end;
    end;
  end;

var
  I: Integer;
  LUnfilteredItem: TListItem;
  LSynchIndex: Integer;
  LUnfilteredItems:  TListItemsList;
  LIsFiltered: Boolean;
  LIsGrouped: Boolean;
begin
  LIsFiltered := IsFiltered;
  LIsGrouped := IsGrouped;
  if (AIndex >= 0) and (LIsFiltered or LIsGrouped) then
  begin
    LUnfilteredItems := FEditorObject.FListView.Items.AsFilterable.UnfilteredItems;
    LSynchIndex := SynchOffsetToIndex(AIndex, LUnfilteredItems);
    if LIsFiltered and (LSynchIndex >= 0) then
    begin
      LUnfilteredItem := LUnfilteredItems[LSynchIndex];
      LSynchIndex := -1;
      // Find index of filtered items
      for I := 0 to FEditorObject.FListView.Items.Count - 1 do
        if FEditorObject.FListView.Items[I] = LUnfilteredItem then
        begin
          LSynchIndex := I;
          break;
        end;
    end;
  end
  else
    LSynchIndex := AIndex;
  FEditorObject.FListView.ItemIndex := LSynchIndex;
end;

// Get the index of the selected item, relative to all items with TListItemPurpose.None.
function TBindListViewEditor.GetSynchIndex: Integer;

  function GetIndexAndOffset(const AItem: TListItem; AItems: TListItemsList; out AItemIndex: Integer): Integer;
  var
    I: Integer;
    LItem: TListItem;
    LSynchOffset: Integer;
  begin
    Assert(AItem <> nil);
    Assert(AItem.Purpose = TListItemPurpose.None);
    AItemIndex := -1;
    LSynchOffset := 0;
    LItem := nil;
    for I := 0 to AItems.Count - 1 do
    begin
      LItem := AItems[I];
      if LItem.Purpose <> TListItemPurpose.None then
        Inc(LSynchOffset)
      else if LItem = AItem then
      begin
        AItemIndex := I;
        break;
      end;
    end;
    Assert((AItems.Count = 0) or (LItem = AItem));
    Result := LSynchOffset;
  end;

var
  LItemIndex: Integer;
  LItem: TListItem;
  LUnfilteredItems: TListItemsList;
  LOffset: Integer;
  LIsFiltered: Boolean;
  LIsGrouped: Boolean;
begin
  Result := -1;
  LIsFiltered := IsFiltered;
  LIsGrouped := IsGrouped;
  if LIsFiltered or LIsGrouped then
  begin
    LItem := FEditorObject.FListView.Selected;
    if (LItem <> nil) and (LItem.Purpose = TListItemPurpose.None) then
    begin
      LUnfilteredItems := FEditorObject.FListView.Items.AsFilterable.UnfilteredItems;
      LItem := FEditorObject.FListView.Selected;
      if (LItem <> nil) and (LItem.Purpose = TListItemPurpose.None) then
      begin
        // Find item in list and
        LOffset := GetIndexAndOffset(LItem, LUnfilteredItems, LItemIndex);
        Assert(LItemIndex <> -1);
        Result := LItemIndex - LOffset;
        Assert(Result >= 0);
      end;
    end;
  end
  else
    Result := FEditorObject.FListView.ItemIndex
end;

procedure TBindListViewEditor.SetSelectedText(const AValue: string);
var
  I: Integer;
  LItem: TListViewItem;
begin
  for I := 0 to FEditorObject.FListView.Items.Count - 1 do
  begin
    LItem := FEditorObject.FListView.Items[I];
    case LItem.Purpose of
      TListItemPurpose.Header,
      TListItemPurpose.Footer:
        ;
      TListItemPurpose.None:
        if SameText(LItem.Text, AValue) then
        begin
          FEditorObject.FListView.ItemIndex := I;
          break;        
        end;
    else
      Assert(False);
    end
  end;
end;

procedure TBindListViewEditor.SetCurrentValue(const AMemberName: string;
  const AValue: TValue; AType: TScopeMemberType);
var
  LIndex: Integer;
  LMemberName: string;
begin
  if FEditorObject.GetItemIndex = -1 then
  begin
    LIndex := FEditorObject.FListView.ItemIndex;
    // ignore headers and footers
    if (LIndex >= 0) and (LIndex < FEditorObject.FListView.Items.Count) then
      if FEditorObject.FListView.Items[LIndex].Purpose = TListItemPurpose.None then
         FEditorObject.SetItemIndex(LIndex);
  end;
  if AMemberName = TListViewNames.Text then
    FEditorObject.Text := AValue.ToString
  else if AMemberName = TListViewNames.Detail then
    FEditorObject.Detail := AValue.ToString
  else if AMemberName = TListViewNames.ButtonText then
    FEditorObject.ButtonText := AValue.ToString
  else if AMemberName = TListViewNames.ImageIndex then
    FEditorObject.ImageIndex := AValue.AsInteger
  else if AMemberName = TListViewNames.Checked then
    FEditorObject.Checked := AValue.AsBoolean
  else if AMemberName = TListViewNames.Tag then
    FEditorObject.Tag := AValue.AsInteger
  else if AMemberName = TListViewNames.Bitmap then
    if AValue.IsObject and (AValue.AsObject is TPersistent) then
      FEditorObject.Bitmap.Assign(TPersistent(AValue.AsObject))
    else
      FEditorObject.Bitmap.Assign(nil)                                 
  else if AMemberName.StartsWith(TListViewNames.Data + '[') then
  begin
    // Copy index value from something like data['xyz'] or data["xyz"].
    LMemberName := AMemberName.Substring(6, AMemberName.Length - 8);
    FEditorObject.Data[LMemberName] := AValue;
  end
  else
    Assert(False);  // Unexpected
end;

function TBindListViewEditor.CanSetCurrentValue(const AMemberName: string; out AType: TScopeMemberType): Boolean;
begin
  AType := mtUnknown;
  if AMemberName = TListViewNames.Text then
    AType := mtText
  else if AMemberName = TListViewNames.Detail then
    AType := mtText
  else if AMemberName = TListViewNames.ButtonText then
    AType := mtText
  else if AMemberName = TListViewNames.Accessory then
    AType := mtInteger
  else if AMemberName = TListViewNames.ImageIndex then
    AType := mtInteger
  else if AMemberName = TListViewNames.Bitmap then
    AType := mtBitmap
  else if AMemberName = TListViewNames.Checked then
    AType := mtBoolean
  else if AMemberName = TListViewNames.Tag then
    AType := mtInteger
  else if AMemberName.StartsWith(TListViewNames.Data + '[') then
    AType := mtTValue;
  Result := AType <> mtUnknown;
end;

procedure TBindListViewEditor.SetItemIndex(AIndex: Integer);
begin
  FEditorObject.FListView.ItemIndex := AIndex;
end;

procedure TBindListViewEditor.SetSelected(
  ALookupKey: TLookupKey);
var
  I: Integer;
begin
  if ALookupKey = 0 then
    FEditorObject.FListView.ItemIndex := -1
  else
  begin
    for I := 0 to FEditorObject.FListView.Items.Count do
      if FEditorObject.FListView.Items[I].Tag = ALookupKey then
      begin
        FEditorObject.FListView.ItemIndex := I;
        Exit;
      end;
    FEditorObject.FListView.ItemIndex := -1;
  end;
end;

function TBindListViewEditor.GetSelected: TLookupKey;
begin
  if FEditorObject.FListView.ItemIndex <> -1 then
    Result := FEditorObject.FListView.Items[ FEditorObject.FListView.ItemIndex].Tag
  else
  Result := 0;
end;

function TBindListViewEditor.GetListItem(
  I: Integer): TLookupKey;
begin
  if I < FEditorObject.FListView.Items.Count then
    Result := FEditorObject.FListView.Items[I].Tag
  else
  Result := 0;
end;

function TBindListViewEditor.GetLookupKey(
  AListItemObject: TObject): TLookupKey;
begin
  if AListItemObject is TListViewItemEditorObject then
    Result := TListViewItemEditorObject(AListItemObject).Tag
  else
  begin
    Assert(False);
    Result := 0;
  end;
end;

function TBindListViewEditor.GetPositionGetter(var AGetter: string;
  var ABase: Integer): Boolean;
begin
  Result := inherited;
  AGetter := 'SynchIndex(Self)';
end;

function TBindListViewEditor.GetPositionSetter(var ASetter: string;
  var ABase: Integer): Boolean;
begin
  Result := inherited;
  ASetter := 'SynchIndex(Self)';
end;

procedure GetAppearanceMemberNames(const AObjects: TItemAppearanceObjects; const ANames: TStrings);
var
  LObject: TObjectAppearance;
  LDataMember: TObjectAppearance.TDataMember;
begin
  ANames.Clear;
  ANames.Add(TListViewItem.TMemberNames.Text); // Always include
  if AObjects <> nil then
    for LObject in AObjects.PublishedObjects do
    begin
      if LObject.Name = TListViewItem.TMemberNames.Text then
        continue;
      for LDataMember in  LObject.DataMembers do
        if LDataMember.Key <> '' then
          ANames.Add(LDataMember.Key);
    end;
end;


function FindAppearanceMember(const AObjects: TItemAppearanceObjects; const AName: string; var AMember: TObjectAppearance.TDataMember): Boolean;
var
  LObject: TObjectAppearance;
  LDataMember: TObjectAppearance.TDataMember;
begin
  Result := False;
  if AObjects <> nil then
    for LObject in AObjects.PublishedObjects do
      for LDataMember in LObject.DataMembers do
        if LDataMember.Key = AName then
        begin
          AMember := LDataMember;
          Exit(True);
        end;
end;

function GetAppearanceMemberNameExpression(const AObjects: TItemAppearanceObjects;
  const AName: string): string;
var
  LDataMember: TObjectAppearance.TDataMember;
begin
  Result := '';
  if FindAppearanceMember(AObjects, AName, LDataMember) then
    Result := LDataMember.Value;
end;

type
  TOpenListView = class(TCustomListView);

function TBindListViewEditor.GetItemIndex: Integer;
begin
  Result := FEditorObject.FListView.ItemIndex;
end;

function TBindListViewEditor.GetItemMemberNameExpression(
  const AName: string): string;
begin
  Result := GetAppearanceMemberNameExpression(TOpenListView(FEditorObject.FListView).
    ItemAppearanceObjects.ItemObjects, AName);
end;

procedure TBindListViewEditor.GetItemMemberNames(ANames: TStrings);
begin
  GetAppearanceMemberNames(TOpenListView(FEditorObject.FListView).
    ItemAppearanceObjects.ItemObjects, ANames);
end;

function TBindListViewEditor.GetHeaderMemberNameExpression(
  const AName: string): string;
begin
  Result := GetAppearanceMemberNameExpression(TOpenListView(FEditorObject.FListView).
    ItemAppearanceObjects.HeaderObjects, AName);
end;

procedure TBindListViewEditor.GetHeaderMemberNames(ANames: TStrings);
begin
  GetAppearanceMemberNames(TOpenListView(FEditorObject.FListView).
    ItemAppearanceObjects.HeaderObjects, ANames);
end;

function TBindListViewEditor.ListCount: Integer;
begin
  Result := FEditorObject.FListView.Items.Count;
end;


{ TBindListViewLookupEditorImpl }

function TBindListViewLookupEditorImpl.GetLookupValue(const AScope: IScope): TValue;
var
  LPlaceHolder: IPlaceHolder;
  LKey: TLookupKey;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LKey := GetLookupKey(LPlaceHolder.Attachment)
  else
  begin
    Assert(False);
    LKey := 0;
  end;
  if LKey <> 0 then
    FLookupDictionary.TryGetValue(LKey, Result);
end;

procedure TBindListViewLookupEditorImpl.ListCleared;
begin
  if Assigned(FLookupDictionary) then
    FLookupDictionary.Clear;
end;

function TBindListViewLookupEditorImpl.NextKey: Integer;
begin
  FCurrentKey := FCurrentKey + 1;
  Result := FCurrentKey;
  Assert(Result <> 0); // Invalid key
end;

function TBindListViewLookupEditorImpl.GetSelectedLookupValue: TValue;
var
  LItem: TLookupKey;
begin
  LItem := GetSelected; // FListBox.Selected;
  if (LItem <> 0) and (FLookupDictionary <> nil) then
  begin
    if not FLookupDictionary.TryGetValue(LItem, Result) then
      Result := TValue.Empty;
  end
  else
    Result := TValue.Empty;
end;

procedure TBindListViewLookupEditorImpl.ItemRemoved(AListItem: TLookupKey);
begin
  if Assigned(FLookupDictionary) then
    if FLookupDictionary.ContainsKey(AListItem) then
      FLookupDictionary.Remove(AListItem);
end;

destructor TBindListViewLookupEditorImpl.Destroy;
begin
  FLookupDictionary.Free;
  inherited;
end;

procedure TBindListViewLookupEditorImpl.SetLookupValue(const AScope: IScope;
  const AValue: TValue);
var
  LPlaceHolder: IPlaceHolder;
  LKey: TLookupKey;
begin
  if Supports(AScope, IPlaceholder, LPlaceHolder) then
    LKey := GetLookupKey(LPlaceHolder.Attachment)
  else
  begin
    LKey := 0;
    Assert(False);
  end;
  if LKey <> 0 then
  begin
    if FLookupDictionary = nil then
      FLookupDictionary := TDictionary<TLookupKey,TValue>.Create;
    FLookupDictionary.AddOrSetValue(LKey, AValue);
  end;
end;

function TBindListViewLookupEditorImpl.SameValue(const AValue1, AValue2: TValue): Boolean;
begin
  Assert(not AValue1.IsArray);  // not supported
  Assert(not AValue2.IsArray);  // not supported
  if (AValue1.IsEmpty) or (AValue2.IsEmpty) then
    Result := AValue2.IsEmpty
  else if (AValue1.IsObject) or (AValue2.IsObject) then
    Result := AValue2.IsObject and (AValue1.AsObject = AValue2.AsObject)
  else
    Result := AValue1.ToString = AValue2.ToString;
end;

function TBindListViewLookupEditorImpl.FindLookupValue(const AValue: TValue): TLookupKey;
var
  I: Integer;
  LItem: TLookupKey;
  LValue: TValue;
begin
  Result := 0;
  if FLookupDictionary <> nil then
    for I := 0 to ListCount - 1 do //FListBox.Count - 1 do
    begin
      LItem := GetListItem(I); // FListBox.ListItems[I];
      if FLookupDictionary.TryGetValue(LItem, LValue) then
        if SameValue(LValue, AValue) then
          Exit(LItem);
    end;
end;

procedure TBindListViewLookupEditorImpl.SetSelectedLookupValue(const AValue: TValue);
var
  LItem: TLookupKey;
begin
  LItem := FindLookupValue(AValue);
  SetSelected(LItem);
end;



{ TBindDateTimeEditEditorFactory }

constructor TBindDateTimeEditEditorFactory.Create;
begin
  inherited;
end;

function TBindDateTimeEditEditorFactory.CreateEditor(AIntf: TGuid;
  AObject: TObject): IInterface;
begin
  Result := TBindEmptyDateTimeEditEditor.Create(TCustomDateTimeEdit(AObject));
end;

function TBindDateTimeEditEditorFactory.Supports(AIntf: TGuid;
  AObject: TObject): Boolean;
begin
  Result := False;
  if AIntf = IBindDateTimeEditEditor then
    if (AObject <> nil) and AObject.InheritsFrom(TCustomDateTimeEdit) then
      Result := True;
end;

{ TBindEmptyDateTimeEditEditor }

constructor TBindEmptyDateTimeEditEditor.Create(
  ADateTimeEdit: TCustomDateTimeEdit);
begin
  FCustomDateTimeEdit := ADateTimeEdit;
end;

function TBindEmptyDateTimeEditEditor.GetDateTime: TDateTime;
begin
  Result := FCustomDateTimeEdit.DateTime;
end;

function TBindEmptyDateTimeEditEditor.GetIsEmpty: Boolean;
begin
  Result := FCustomDateTimeEdit.IsEmpty;
end;

procedure TBindEmptyDateTimeEditEditor.SetDateTime(ADateTime: TDateTime);
begin
  FCustomDateTimeEdit.DateTime := ADateTime;
end;

procedure TBindEmptyDateTimeEditEditor.SetIsEmpty(Value: Boolean);
begin
  FCustomDateTimeEdit.IsEmpty := Value;
end;

initialization
  GEditors := TEditors.Create(nil);
  RegisterBindEditorFactory([TBindListBoxEditorFactory, TBindMetroListBoxEditorFactory, TBindComboBoxEditorFactory,
    TBindMetroComboBoxEditorFactory,
    TBindStringGridEditorFactory, TBindGridEditorFactory, TBindCheckBoxEditorFactory,
    TBindComboEditEditorFactory, TBindListViewEditorFactory, TBindDateTimeEditEditorFactory]);

  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TEdit,
    TComboEdit
    ), 'Text', sFmx);
{$WARNINGS OFF}
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TClearingEdit
    ), 'Text', sFmx);
{$WARNINGS ON}
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TTrackBar,
    TArcDial,
    TSpinBox,
    TNumberBox
    ),
    'Value', sFmx);
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TCheckBox,
    TSwitch
    ), 'IsChecked', sFmx);
  Data.Bind.Components.RegisterObservableMember(
    TArray<TClass>.Create(
    TImageControl
    ), 'Bitmap', sFmx);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    THueTrackBar,
    TAlphaTrackBar,
    TBWTrackBar
    ),
    'Value', sFmx);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TComboColorBox,
    TColorComboBox,
    TColorListBox,
    TColorPanel
    ), // observable
    'Color', sFmx);
{$WARNINGS OFF}
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TCalendarEdit
    ),
    'Date', sFmx);
{$WARNINGS ON}
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TTimeEdit,
    TDateEdit
    ),
    'SelectedDateTime(Self)', sFmx);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TListBox,
    TComboBox
    ),
    'SelectedValue(Self)', sFmx);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TListView
    ),
    'SelectedValue(Self)', sFmx);
  Data.Bind.Components.RegisterObservableMember(TArray<TClass>.Create(
    TMemo
    ),
    'Text', sFmx);


  Data.Bind.Components.RegisterListItemValueExpression(TArray<TClass>.Create(
    TListBox,
    TListView,
    TComboBox,
    TComboEdit
    ),
    'Text', 'Text');

  Data.Bind.Components.RegisterObservableMemberOptions(TArray<TClass>.Create(
    TCheckBox,
    TSwitch,
    TListBox,
    TListView,
    TComboBox,
    TColorListBox,
    TColorComboBox,
    TComboColorBox,
    TColorBox,
    TCustomDateTimeEdit
    ), [moTrack]);


  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
     TImage
     ),
     'Bitmap', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
     TColorBox, TColorPicker
     ),
     'Color', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
     TImageViewer
     ),
     'Bitmap', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
    TGroupBox, TLabel,
    TExpander, TText,
    TButton, TSpeedButton
     ),
     'Text', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
    TPathLabel
     ),
     'Data.Data', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
    TProgressBar
     ),
     'Value', sFmx);

  Data.Bind.Components.RegisterValuePropertyName(TArray<TClass>.Create(
    TCustomPath
     ),
     'Data.Data', sFmx);

finalization
  // Free the editors dictionary.
  // The individual editors may be destroyed later.
  FreeAndNil(GEditors);
{$WARNINGS OFF}
  Data.Bind.Components.UnRegisterObservableMember(
    TArray<TClass>.Create(
    TClearingEdit,
    TCalendarEdit
    ));
{$WARNINGS ON}
  Data.Bind.Components.UnRegisterObservableMember(
    TArray<TClass>.Create(
    TEdit,
    TComboEdit,
    TTrackBar,
    TArcDial,
    TCheckBox,
    TSwitch,
    TImageControl,
    THueTrackBar,
    TAlphaTrackBar,
    TBWTrackBar,
    TComboColorBox,
    TColorComboBox,
    TColorListBox,
    TColorPanel,
    TCalendar,
    TListBox,
    TListView,
    TComboBox,
    TMemo,
    TCustomDateTimeEdit,
    TSpinBox,
    TNumberBox
    ));
  UnregisterBindEditorFactory([TBindListBoxEditorFactory, TBindComboBoxEditorFactory,
    TBindStringGridEditorFactory, TBindGridEditorFactory, TBindCheckBoxEditorFactory,
    TBindComboEditEditorFactory, TBindListViewEditorFactory, TBindDateTimeEditEditorFactory]);
  Data.Bind.Components.UnRegisterListItemValueExpression(TArray<TClass>.Create(
    TListBox,
    TComboBox,
    TComboEdit));
  Data.Bind.Components.UnRegisterObservableMemberOptions(TArray<TClass>.Create(
    TCheckBox,
    TListBox,
    TListView,
    TComboBox,
    TColorListBox,
    TColorComboBox,
    TComboColorBox,
    TColorBox
    ));

  Data.Bind.Components.UnRegisterValuePropertyName(TArray<TClass>.Create(
     TImage,
     TColorBox, TColorPicker,
     TImageViewer,
     TGroupBox, TLabel, TPathLabel,
    TExpander, TText,
    TStatusBar, TButton, TSpeedButton,
    TProgressBar,
    TCustomPath
     ));

end.
