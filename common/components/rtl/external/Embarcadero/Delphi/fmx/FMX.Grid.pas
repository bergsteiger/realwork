{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Grid;

interface

uses
  System.Classes, System.Types, System.UITypes, System.Rtti, System.SysUtils,
  FMX.Types, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.Menus, FMX.Header,
  FMX.ExtCtrls, FMX.Controls;

type

  TCustomGrid = class;

{ Cell Classes }

  TTextCell = class(TEdit)
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
  end;

  TCheckCell = class(TCheckBox)
  protected
    function GetObservers: TObservers; override;
  end;

  TProgressCell = class(TProgressBar)
  end;

  TPopupCell = class(TPopupBox)
  end;

  TImageCell = class(TImageControl)
  end;

{ TColumn }

  TColumn = class(TStyledControl)
  private
    FReadOnly: Boolean;
    FEditMode: Integer;
    FApplyImmediately: boolean;
    FLastRow: integer;
    FLastStartPos: integer;
    FLastSelLength: integer;
    FLastPos: integer;
    procedure SetHeader(const Value: string);
    procedure TextChangeProc(Sender: TObject);
    procedure TextTypingProc(Sender: TObject);
  protected
    FCellControls: array of TStyledControl;
    FUpdateColumn: Boolean;
    FHeader: string;
    FSaveData: TValue;
    FDisableChange: Boolean;
    function Grid: TCustomGrid;
    procedure UpdateColumn; virtual;
    procedure UpdateSelected;
    procedure ClearColumn;
    function CreateCellControl: TStyledControl; virtual;
    procedure SetVisible(const Value: Boolean); override;
    procedure DoTextChanged(Sender: TObject);
    procedure DoTextExit(Sender: TObject);
    procedure DoCanFocus(Sender: TObject; var ACanFocus: Boolean);
    procedure DoEnter(Sender: TObject); reintroduce;
    procedure DoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: System.WideChar; Shift: TShiftState);

    procedure UpdateRowCount(const RowCount: integer); virtual;
    function GetCells(ARow: Integer): TValue; virtual;
    procedure SetCells(ARow: Integer; const Value: TValue); virtual;
    function CellControlByRow(Row: Integer): TStyledControl;
    function CellControlByPoint(X, Y: Single): TStyledControl;
  public
    constructor Create(AOwner: TComponent); override;
    property InEditMode: Integer read FEditMode;
    property ApplyImmediately: boolean read FApplyImmediately write FApplyImmediately default True;
    procedure UpdateCell(ARow: Integer);
  published
    property Align;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Header: string read FHeader write SetHeader;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
//    property Hint;
    property HitTest default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property RotationAngle;
    property RotationCenter;
    property Scale;
//    property ShowHint default False;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible: Boolean read FVisible write SetVisible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TCheckColumn }

  TCheckColumn = class(TColumn)
  private
    FObserversProxy: TObject;
    procedure DoCheckChanged(Sender: TObject);
  protected
    function CreateCellControl: TStyledControl; override;
    function GetObserversProxy: TObservers;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TProgressColumn }

  TProgressColumn = class(TColumn)
  private
    FMin: Single;
    FMax: Single;
  protected
    function CreateCellControl: TStyledControl; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Max: Single read FMax write FMax;
    property Min: Single read FMin write FMin;
  end;

{ TPopupColumn }

  TPopupColumn = class(TColumn)
  private
    FItems: TStrings;
    procedure SetItems(const Value: TStrings);
  protected
    function CreateCellControl: TStyledControl; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Items: TStrings read FItems write SetItems;
  end;

{ TImageColumn }

  TImageColumn = class(TColumn)
  protected
    function CreateCellControl: TStyledControl; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TCustomGrid }

  TOnGetValue = procedure(Sender: TObject; const Col, Row: Integer;
    var Value: System.Rtti.TValue) of object;
  TOnSetValue = procedure(Sender: TObject; const Col, Row: Integer;
    const Value: System.Rtti.TValue) of object;
  TOnEditingDone = procedure(Sender: TObject; const Col, Row: Integer)
    of object;
  TOnCallbackGetValue = procedure(Sender: TObject; const Col, Row: Integer;
    ACallback: TProc<System.Rtti.TValue>) of object;

  TCustomGrid = class(TScrollBox, IItemsContainer)
  private
    FItemHeight: Single;
    FSelection: TControl;
    FFocus: TControl;
    FRowCount: Integer;
    FOnCallbackGetValue: TOnCallbackGetValue;
    FOnGetValue: TOnGetValue;
    FOnSetValue: TOnSetValue;
    FSelections: TControlList;
    FAlternatingRowBackground: Boolean;
    FOddFill: TBrush;
    FLineFill: TBrush;
    FShowHorzLines: Boolean;
    FShowVertLines: Boolean;
    FReadOnly: Boolean;
    FColumnIndex: Integer;
    FHeader: THeader;
    FShowHeader: Boolean;
    FShowSelectedCell: Boolean;
    FOnEditingDone: TOnEditingDone;
    FOnSelChanged: TNotifyEvent;
    FSelected: Integer;
    FRowHeight: Single;
    function GetColumnCount: Integer;
    function GetVisibleColumnCount: Integer;
    function GetColumn(Index: Integer): TColumn;
    procedure SetRowCount(const Value: Integer);
    procedure SetRowHeight(const Value: Single);
    function GetVisibleRows: Integer;
    procedure SetAlternatingRowBackground(const Value: Boolean);
    procedure SetShowHorzLines(const Value: Boolean);
    procedure SetShowVertLines(const Value: Boolean);
    procedure SetColumnIndex(const Value: Integer);
    procedure SetShowHeader(const Value: Boolean);
    procedure SetShowSelectedCell(const Value: Boolean);
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure MouseToCell(const X, Y: Single; var Col, Row: Integer);
    procedure SelCell(Col, Row: Integer);
    function GetBottomRow: Integer;
    procedure InternalClick(X, Y: Single);
  protected
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); override;
    function IsOpaque: Boolean; override;
    function DoCalcContentBounds: TRectF; override;
    procedure UpdateHeader;
    procedure UpdateSelection;
    procedure Reset; virtual;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure DoContentPaint2(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure ContentRemoveObject(const AObject: TFmxObject); override;
    { observers }
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    function ObserverCurrent: TVarRec;
    { data }
    function GetTopRow: Integer; virtual;
    procedure SetTopRow(const Value: Integer); virtual;
    function GetValue(Col, Row: Integer): TValue; virtual;
    procedure CallbackGetValue(Col, Row: Integer; ACallback: TProc<TValue>); virtual;
    procedure SetValue(Col, Row: Integer; const Value: TValue); virtual;
    function IsSelected(Row: Integer): Boolean;
    procedure SetSelected(const Value: Integer); virtual;
    function CanEditAcceptKey(Key: System.WideChar): Boolean; virtual;
    function CanEditModify: Boolean; virtual;
    { header }
    procedure DoRealignItem(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure DoResizeItem(Sender: TObject; var NewSize: Single);
    procedure DoSelChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ColumnByIndex(const Idx: Integer): TColumn;
    function ColumnByPoint(const X, Y: Single): TColumn;
    function RowByPoint(const X, Y: Single): Integer;
    property TopRow: Integer read GetTopRow write SetTopRow;
    property BottomRow: Integer read GetBottomRow;
    property VisibleRows: Integer read GetVisibleRows;
    property ColumnCount: Integer read GetColumnCount;
    property ColumnIndex: Integer read FColumnIndex write SetColumnIndex;
    property Columns[Index: Integer]: TColumn read GetColumn;
    procedure UpdateColumns; virtual;
    property RowCount: Integer read FRowCount write SetRowCount;
    property Selected: Integer read FSelected write SetSelected;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    property OnGetValue: TOnGetValue read FOnGetValue write FOnGetValue;
    property OnCallbackGetValue: TOnCallbackGetValue read FOnCallbackGetValue write FOnCallbackGetValue;
    property OnSetValue: TOnSetValue read FOnSetValue write FOnSetValue;
    property AlternatingRowBackground: Boolean read FAlternatingRowBackground
      write SetAlternatingRowBackground default False;
    property RowHeight: Single read FRowHeight write SetRowHeight;
    property ShowSelectedCell: Boolean read FShowSelectedCell write SetShowSelectedCell default True;
    property ShowVertLines: Boolean read FShowVertLines write SetShowVertLines default True;
    property ShowHorzLines: Boolean read FShowHorzLines write SetShowHorzLines default True;
    property ShowHeader: Boolean read FShowHeader write SetShowHeader default True;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property OnEditingDone: TOnEditingDone read FOnEditingDone write FOnEditingDone;
    property OnSelChanged: TNotifyEvent read FOnSelChanged write FOnSelChanged;
  end;

{ TGrid }

  TGrid = class(TCustomGrid)
  published
    property Align;
    property AlternatingRowBackground;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;

    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
//    property Hint;
    property HitTest default True;
    property Locked default False;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property ReadOnly;
    property RotationAngle;
    property RotationCenter;
    property RowCount;
    property RowHeight;
    property Scale;
//    property ShowHint default False;
    property ShowHeader;
    property ShowHorzLines;
    property ShowSelectedCell;
    property ShowVertLines;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnEditingDone;
    property OnGetValue;
    property OnSelChanged;
    property OnSetValue;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

{ TStringColumn }

  TStringColumn = class(TColumn)
  private
    FRowCount: integer;
    FCells: array of string;
  protected
    procedure UpdateRowCount(const RowCount: integer); override;
    function GetCells(ARow: Integer): TValue; override;
    procedure SetCells(ARow: Integer; const Value: TValue); override;
  end;

{ TStringGrid }

  TStringGrid = class(TCustomGrid)
  private
    function GetCells(ACol, ARow: Integer): string;
    procedure SetCells(ACol, ARow: Integer; const Value: string);
  protected
    function GetValue(Col, Row: Integer): TValue; override;
    procedure SetValue(Col, Row: Integer; const Value: TValue); override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Cells[ACol, ARow: Integer]: string read GetCells write SetCells;
  published
    property Align;
    property AlternatingRowBackground;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
//    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property ReadOnly;
    property RotationAngle;
    property RotationCenter;
    property RowCount;
    property RowHeight;
    property Scale;
//    property ShowHint default False;
    property ShowHeader;
    property ShowHorzLines;
    property ShowSelectedCell;
    property ShowVertLines;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnEditingDone;
    property OnSelChanged;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

implementation

uses FMX.Ani, System.Math, System.Variants;

type
  TOpenControl = class(TControl);
  TOpenHeader = class (THeader);

  TObserversProxy = class(TObservers)
  private
    FGrid: TCustomGrid;
    FEditLink: IEditLinkObserver;
  public
    constructor Create(const AGrid: TCustomGrid; ATrack: Boolean = False);
    function CanObserve(const ID: Integer): Boolean; overload; override;
    procedure AddObserver(const ID: Integer; const AIntf: IInterface); overload; override;
    procedure AddObserver(const IDs: Array of Integer; const AIntf: IInterface); overload; override;
    procedure RemoveObserver(const ID: Integer; const AIntf: IInterface); overload; override;
    procedure RemoveObserver(const IDs: Array of Integer; const AIntf: IInterface); overload; override;
    function IsObserving(const ID: Integer): Boolean; overload; override;
    function TryIsObserving(const ID: Integer; out AIntf: IInterface): Boolean; override;
    function GetSingleCastObserver(const ID: Integer): IInterface; override;
    function GetMultiCastObserver(const ID: Integer): IInterfaceList; override;
  end;

  TEditLinkProxy = class(TInterfacedObject, IEditLinkObserver, IObserver, IObserverTrack)
  private
    FGrid: TCustomGrid;
    FTrack: Boolean;
  protected
    procedure Removed;
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
    function GetOnObserverToggle: TObserverToggleEvent;
    procedure SetOnObserverToggle(AEvent: TObserverToggleEvent);
    property OnObserverToggle: TObserverToggleEvent read GetOnObserverToggle write SetOnObserverToggle;
    procedure Update;

    function Edit: Boolean;
    procedure Reset;
    procedure Modified;
    function IsModified: Boolean;
    function IsValidChar(AKey: Char): Boolean;
    function IsRequired: Boolean;
    function GetIsReadOnly: Boolean;
    procedure SetIsReadOnly(Value: Boolean);
    function GetIsEditing: Boolean;
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetUpdating: Boolean;
    function GetTrack: Boolean;
  public
    constructor Create(const AGrid: TCustomGrid);
    property Track: Boolean read GetTrack write FTrack;
  end;

{ TColumn }

constructor TColumn.Create(AOwner: TComponent);
begin
  inherited;
  FLastRow := -1;
  AutoTranslate := True;
  Width := 100;
  HitTest := False;
  CanFocus := False;
  FEditMode := -1;
  FApplyImmediately := True;
end;

procedure TColumn.TextTypingProc(Sender: TObject);
begin
  if ApplyImmediately then
    DoTextChanged(Sender);
end;

procedure TColumn.TextChangeProc(Sender: TObject);
begin
  if not ApplyImmediately then
    DoTextChanged(Sender);
end;

function TColumn.CreateCellControl: TStyledControl;
begin
  Result := TTextCell.Create(Self);
  //TTextCell(Result).OnTyping := DoTextChanged;
  TTextCell(Result).OnTyping := TextTypingProc;
  TTextCell(Result).OnChange := TextChangeProc;
  TTextCell(Result).OnExit := DoTextExit;
end;

procedure TColumn.DoTextExit(Sender: TObject);
var
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if Assigned(LGrid) and LGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    if TLinkObservers.EditGridLinkIsEditing(LGrid.Observers) then
      TLinkObservers.EditGridLinkUpdate(LGrid.Observers);
end;

procedure TColumn.DoTextChanged(Sender: TObject);
var
  P: TPointF;
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;
  if FUpdateColumn then
    Exit;
  if FDisableChange then
    Exit;
  P := StringToPoint(TFmxObject(Sender).TagString);
  LGrid.SetValue(Trunc(P.X), Trunc(P.Y), TStyledControl(Sender).Data);
  if Assigned(LGrid.FOnEditingDone) then
    LGrid.FOnEditingDone(Grid, Trunc(P.X), Trunc(P.Y));
end;

procedure TColumn.DoCanFocus(Sender: TObject; var ACanFocus: Boolean);
var
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;
  ACanFocus := LGrid.CanEditModify;
  if ACanFocus and ReadOnly then
    ACanFocus := False;
end;

procedure TColumn.DoEnter(Sender: TObject);
var
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;
  LGrid.ColumnIndex := Index;
  FSaveData := TFmxObject(Sender).Data;
  FEditMode := 1;
end;

procedure TColumn.DoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: System.WideChar; Shift: TShiftState);
var
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if Assigned(LGrid) and (FEditMode = -1) then
    DoEnter(Sender);

  if Assigned(LGrid) and LGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
  begin
    if LGrid.ReadOnly then
    begin
      Key := 0;
      KeyChar := #0;
      Exit;
    end;

    if (Key = vkUp) or (Key = vkDown) or (Key = vkRight) or (Key = vkLeft) then
      if TLinkObservers.EditGridLinkIsEditing(LGrid.Observers) then
      begin
        try
          TLinkObservers.EditGridLinkUpdate(LGrid.Observers);
        except
          TLinkObservers.EditGridLinkReset(LGrid.Observers);
          LGrid.Reset;
          SetFocus;
          raise;
        end;
      end;
  end;

  if (KeyChar <> #0) and Assigned(LGrid) and not LGrid.CanEditAcceptKey(KeyChar) then
    KeyChar := #0;

  if Assigned(LGrid) and (FEditMode = 1) then
  begin
    FEditMode := 0;
  end
  else
    if (KeyChar = #13) and Assigned(LGrid) and (FEditMode = 0) then
    begin
      LGrid.Reset;
      FEditMode := -1;
      LGrid.SetFocus;
    end
    else
      if (Key = vkReturn) and Assigned(LGrid) then
        LGrid.SetFocus;

  if (Key = vkEscape) and Assigned(LGrid) then
  begin
    try
      if LGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
        TLinkObservers.EditGridLinkReset(LGrid.Observers);
    finally
      FDisableChange := True;
      try
        TFmxObject(Sender).Data := FSaveData;
      finally
        FDisableChange := False;
      end;
      LGrid.Reset;
    end;
  end;
  if (Key = vkUp) or (Key = vkDown) and Assigned(LGrid) then
  begin
    LGrid.SetFocus;
    LGrid.KeyDown(Key, KeyChar, Shift);
  end;
  if Assigned(LGrid) and LGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
  begin
    if (Key = vkBack) or (Key = vkDelete) or ((Key = vkInsert) and (ssShift in Shift)) then
    begin
      if TLinkObservers.EditGridLinkEdit(LGrid.Observers) then
        TLinkObservers.EditGridLinkModified(LGrid.Observers)
      else
      begin
        Key := 0;
        KeyChar := #0;
        TLinkObservers.EditGridLinkReset(LGrid.Observers);
        Exit;
      end;
    end;

    if (KeyChar >= #32) and
      not TLinkObservers.EditGridLinkIsValidChar(LGrid.Observers, KeyChar) then
    begin
      KeyChar := #0;
      Exit;
    end;
    case KeyChar of
      ^H, ^V, ^X, #32..High(Char):
        if not TLinkObservers.EditGridLinkEdit(LGrid.Observers) then
        begin
          Key := 0;
          KeyChar := #0;
          TLinkObservers.EditGridLinkReset(LGrid.Observers);
          Exit;
        end
        else
          TLinkObservers.EditGridLinkModified(LGrid.Observers);
    end;

    if Key = vkReturn then
    begin
      try
        TLinkObservers.EditGridLinkUpdate(LGrid.Observers);
      except
        TLinkObservers.EditGridLinkReset(LGrid.Observers);
        LGrid.Reset;
        LGrid.SetFocus;
        raise;
      end;
    end;
  end;
end;

procedure TColumn.UpdateRowCount(const RowCount: integer);
begin
end;

function TColumn.GetCells(ARow: Integer): TValue;
begin
  Result := TValue.Empty;
end;

procedure TColumn.SetCells(ARow: Integer; const Value: TValue);
begin
end;

function TColumn.Grid: TCustomGrid;
var
  P: TFmxObject;
begin
  Result := nil;
  P := Parent;
  while Assigned(P) do
  begin
    if P is TCustomGrid then
    begin
      Result := TCustomGrid(P);
      Exit;
    end;
    P := P.Parent;
  end;
end;

procedure TColumn.ClearColumn;
var
  i: Integer;
begin
  for i := 0 to High(FCellControls) do
    FCellControls[i].Free;
  SetLength(FCellControls, 0);
end;

function TColumn.CellControlByPoint(X, Y: Single): TStyledControl;
var
  i: Integer;
  P: TPointF;
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  Result := nil;
  if not Assigned(LGrid) then
    Exit;

  P := LGrid.LocalToAbsolute(PointF(X, Y));
  for i := 0 to High(FCellControls) do
    if FCellControls[i].Visible and (FCellControls[i].PointInObject(P.X, P.Y))
    then
    begin
      Result := FCellControls[i];
      Exit;
    end;
end;

function TColumn.CellControlByRow(Row: Integer): TStyledControl;
var
  i: Integer;
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  Result := nil;
  if not Assigned(LGrid) then
    Exit;

  for i := 0 to High(FCellControls) do
    if (FCellControls[i].Visible) and
      (Trunc(StringToPoint(FCellControls[i].TagString).Y) = Row) then
    begin
      Result := FCellControls[i];
      Exit;
    end;
end;

procedure TColumn.UpdateCell(ARow: Integer);
var
  i: Integer;
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;

  FUpdateColumn := True;
  try
    { Create controls }
    for i := 0 to LGrid.VisibleRows - 1 do
    begin
      if LGrid.TopRow + i >= LGrid.RowCount then
        Break;
      if LGrid.TopRow + i = ARow then
      begin
        LGrid.CallbackGetValue(Index, LGrid.TopRow + i,
          procedure(AValue: TValue)
          begin
            FCellControls[i].Data := AValue;
          end);
        break;
      end;
    end;
  finally
    FUpdateColumn := False;
  end;
end;

procedure TColumn.UpdateColumn;
var
  i, C, X: Integer;
  LGrid : TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;

  FUpdateColumn := True;
  try
    { Create controls }
    if Length(FCellControls) < LGrid.VisibleRows then
    begin
      C := High(FCellControls);
      SetLength(FCellControls, LGrid.VisibleRows);
      for i := C + 1 to LGrid.VisibleRows - 1 do
      begin
        FCellControls[i] := CreateCellControl;
        FCellControls[i].Parent := Self;
        FCellControls[i].HitTest := False;
        FCellControls[i].Visible := False;
        FCellControls[i].Locked := True;
        FCellControls[i].Stored := False;
        FCellControls[i].OnCanFocus := DoCanFocus;
        FCellControls[i].OnEnter := DoEnter;
        FCellControls[i].OnKeyDown := DoKeyDown;
      end;
    end;
    { Hide if need }
    if Length(FCellControls) > LGrid.VisibleRows then
    begin
      for i := LGrid.VisibleRows to High(FCellControls) do
        FCellControls[i].Visible := False;
    end;
    { Update Data }
    if Position.X < 1 then
      X := 0
    else
      X := 1;
    for i := 0 to LGrid.VisibleRows - 1 do
    begin
      if LGrid.TopRow + i >= LGrid.RowCount then
        Break;

      LGrid.CallbackGetValue(Index, LGrid.TopRow + i,
        procedure(V: TValue)
        begin
          FCellControls[i].Visible := True;
          FCellControls[i].SetBounds(X, i * LGrid.RowHeight, Width - X, LGrid.RowHeight);
          FCellControls[i].TagString :=
            String(PointToString(PointF(Index, LGrid.TopRow + i)));
          FCellControls[i].Data := V;
        end);
    end;
    UpdateSelected;
  finally
    FUpdateColumn := False;
  end;
end;

procedure TColumn.UpdateSelected;
var
  i, N: Integer;
  EnableFocus: boolean;
  lGrid: TCustomGrid;
begin
  lGrid := Grid;
  if not assigned(lGrid) then
    Exit;

  EnableFocus := (not ReadOnly) and
                 (Enabled) and
                 (not lGrid.ReadOnly) and
                 (lGrid.Enabled) and
                 (lGrid.ColumnIndex = Index) and
                 (lGrid.IsFocused or lGrid.IsChildFocused);

  N := High(FCellControls);

  if EnableFocus then
    for i := 0 to N do
      if lGrid.IsSelected(lGrid.TopRow + i) then
      begin
        SetFocus;
        FCellControls[i].CanFocus := True;
        FCellControls[i].HitTest := True;
        FCellControls[i].SetFocus;
        FCellControls[i].BringToFront;
      end
      else
      begin
        FCellControls[i].CanFocus := False;
        FCellControls[i].HitTest := False;
        if FCellControls[i] is TEdit then
          TEdit(FCellControls[i]).SelLength := 0;
      end;

  for i := 0 to N do
    if not lGrid.IsSelected(lGrid.TopRow + i) then
    begin
      FCellControls[i].CanFocus := False;
      FCellControls[i].HitTest := False;
      if FCellControls[i].IsFocused then
        lGrid.Root.SetActiveControl(nil);
    end;
end;

procedure TColumn.SetHeader(const Value: string);
var
  LGrid: TCustomGrid;
begin
  if FHeader <> Value then
  begin
    FHeader := Value;
    LGrid := Grid;
    if Assigned(LGrid) then
      if Assigned(LGrid.FHeader) then
        LGrid.FHeader.Items[Index].Text := FHeader;
  end;
end;

procedure TColumn.SetVisible(const Value: Boolean);
var
  LGrid: TCustomGrid;
begin
  inherited SetVisible(Value);
  LGrid := Grid;
  if Assigned(LGrid) then
  begin
    if Assigned(LGrid.FHeader) then
      LGrid.FHeader.Items[Index].Visible := Value;
    LGrid.RealignContent;
  end;
end;

{ TCheckColumn }

constructor TCheckColumn.Create(AOwner: TComponent);
begin
  inherited;
end;

function TCheckColumn.CreateCellControl: TStyledControl;
begin
  Result := TCheckCell.Create(Self);
  TCheckCell(Result).OnChange := DoCheckChanged;
end;

destructor TCheckColumn.Destroy;
begin
  inherited;
  FObserversProxy.Free;
end;

procedure TCheckColumn.DoCheckChanged(Sender: TObject);
var
  P: TPointF;
  LGrid: TCustomGrid;
begin
  LGrid := Grid;
  if not Assigned(LGrid) then
    Exit;
  if FUpdateColumn then
    Exit;
  P := StringToPoint(TFmxObject(Sender).TagString);
  LGrid.SetValue(Trunc(P.X), Trunc(P.Y), TStyledControl(Sender).Data);
  if Assigned(LGrid.FOnEditingDone) then
    LGrid.FOnEditingDone(LGrid, Trunc(P.X), Trunc(P.Y));
end;

function TCheckColumn.GetObserversProxy: TObservers;
begin
  if FObserversProxy = nil then
    FObserversProxy := TObserversProxy.Create(Grid, True); // Tracking on
  Result := FObserversProxy as TObservers
end;

{ TProgressColumn }

constructor TProgressColumn.Create(AOwner: TComponent);
begin
  inherited;
  FMax := 100;
end;

function TProgressColumn.CreateCellControl: TStyledControl;
begin
  Result := TProgressCell.Create(Self);
  TProgressCell(Result).Min := FMin;
  TProgressCell(Result).Max := FMax;
end;

{ TPopupColumn }

constructor TPopupColumn.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TStringList.Create;
end;

destructor TPopupColumn.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TPopupColumn.CreateCellControl: TStyledControl;
begin
  Result := TPopupCell.Create(Self);
  TPopupCell(Result).Items.Assign(FItems);
end;

procedure TPopupColumn.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

{ TImageColumn }

constructor TImageColumn.Create(AOwner: TComponent);
begin
  inherited;
end;

function TImageColumn.CreateCellControl: TStyledControl;
begin
  Result := TImageCell.Create(Self);
  TImageCell(Result).EnableOpenDialog := False;
end;

{ TCustomGrid }

constructor TCustomGrid.Create(AOwner: TComponent);
begin
  inherited;
  FOddFill := TBrush.Create(TBrushKind.bkSolid, $20000000);
  FLineFill := TBrush.Create(TBrushKind.bkSolid, $FF202020);
  FShowSelectedCell := True;
  FShowVertLines := True;
  FShowHorzLines := True;
  FShowHeader := True;
  FRowHeight := 21;
  FRowCount := 100;
  DisableFocusEffect := True;
  CanFocus := True;
  AutoCapture := True;
  Width := 100;
  Height := 100;
  FItemHeight := 0;
  SetAcceptsControls(False);
end;

destructor TCustomGrid.Destroy;
begin
  if Assigned(FSelections) then
    FreeAndNil(FSelections);
  if Assigned(FLineFill) then
    FreeAndNil(FLineFill);
  if Assigned(FOddFill) then
    FreeAndNil(FOddFill);
  inherited;
end;

procedure TCustomGrid.FreeStyle;
var
  I: Integer;
  C: TControl;
begin
  inherited;
  if Assigned(FSelections) then
  begin
    for i := 0 to FSelections.Count - 1 do
    begin
      C := FSelections[i];
      FreeAndNil(C);
    end;
    FSelections.Clear;
  end;
  FSelection := nil;
  FFocus := nil;
  FHeader := nil;
end;

procedure TCustomGrid.ApplyStyle;
var
  T: TFmxObject;
  TR: Integer;
begin
  inherited;
  if Assigned(ContentLayout) then
  begin
    ContentLayout.OnPainting := DoContentPaint;
    ContentLayout.OnPaint := DoContentPaint2;
  end;
  T := FindStyleResource('header');
  if Assigned(T) and (T is THeader) then
  begin
    FHeader := THeader(T);
    FHeader.OnRealignItem := DoRealignItem;
    FHeader.OnResizeItem := DoResizeItem;
    FHeader.Visible := FShowHeader;
  end;
  T := FindStyleResource('focus');
  if Assigned(T) and (T is TControl) then
  begin
    FFocus := TControl(T);
    FFocus.Visible := False;
  end;
  T := FindStyleResource('selection');
  if Assigned(T) and (T is TControl) then
  begin
    FSelection := TControl(T);
    FSelection.Visible := False;
  end;
  T := FindStyleResource('AlternatingRowBackground');
  if Assigned(T) and (T is TBrushObject) then
  begin
    FOddFill.Assign(TBrushObject(T).Brush);
  end;
  T := FindStyleResource('LineFill');
  if Assigned(T) and (T is TBrushObject) then
  begin
    FLineFill.Assign(TBrushObject(T).Brush);
  end;
  UpdateColumns;
  UpdateHeader;
  if Assigned(FHeader) and (not FHeader.Visible) then
  begin
    TR := TopRow;
    SetTopRow(TR + 1);
    SetTopRow(TR);
  end;
  UpdateSelection;
  Realign;
end;

procedure TCustomGrid.UpdateSelection;
var
  i: Integer;
  P: TPointF;
  R: TRectF;
  SelRects: array of TRectF;
  Clone: TControl;

  procedure UpdateFocusRect;
  var
    FocusVisible: boolean;
    I: integer;
    P: TPointF;
    FocusCellControl: TStyledControl;
    W, H: Single;
  begin
    if Assigned(FFocus) then
    begin
      FocusVisible := (FShowSelectedCell and Visible and Enabled) and
                      (ColumnIndex < ColumnCount) and
                      (ColumnIndex >= 0) and
                      (Columns[ColumnIndex].Visible) and
                      (Columns[ColumnIndex].Enabled){ and
                      (IsFocused or Columns[ColumnIndex].IsFocused)};
      if FocusVisible then
      begin
        I := Selected - TopRow;
        FocusVisible := (I >= 0) and
                   (I < VisibleRows) and
                   (Selected < RowCount) and
                   (I < Length(Columns[ColumnIndex].FCellControls));
        if FocusVisible then
        begin
          FocusCellControl := Columns[ColumnIndex].FCellControls[I];
          FocusVisible := Assigned(FocusCellControl) and
                          Assigned(Content) and
                          (FocusCellControl.Parent is TControl) and
                          (FFocus.Parent is TControl);
          if FocusVisible then
          begin
            P := TControl(FocusCellControl.Parent).LocalToAbsolute(FocusCellControl.Position.Point);
            P := TControl(Content).AbsoluteToLocal(P);
            P.Y := Selected * RowHeight;
            P.X := P.X + FFocus.Margins.Left;
            P.Y := P.Y + FFocus.Margins.Top;
            P := Content.LocalToAbsolute(P);
            P := TControl(FFocus.Parent).AbsoluteToLocal(P);
            W := FocusCellControl.Width - FFocus.Margins.Left - FFocus.Margins.Right;
            H := FocusCellControl.Height - FFocus.Margins.Top - FFocus.Margins.Bottom;
            FocusVisible := (W > 1) and (H > 1);
            if FocusVisible then
            begin
              FFocus.SetBounds(P.X, P.Y, W, H);
              FFocus.Opacity := 0.4;
              FFocus.Visible := True;
              FFocus.BringToFront;
            end;
          end;
        end;
      end;
      if not FocusVisible then
        FFocus.Visible := False;
    end;
  end;
begin
  try
    if not Assigned(FSelection) then
      Exit;
    if (ColumnCount = 0) and (RowCount = 0) then
    begin
      if Assigned(FSelections) then
        for i := 0 to FSelections.Count - 1 do
          FSelections[i].Visible := False;
      Exit;
    end;
    // calc rects
    SetLength(SelRects, 0);
    for i := TopRow to TopRow + VisibleRows - 1 do
    begin
      if IsSelected(i) then
      begin
        P := PointF(0, i * FRowHeight);
        P := Content.LocalToAbsolute(P);
        if Assigned(FSelection.Parent) and (FSelection.Parent is TControl) then
          P := TControl(FSelection.Parent).AbsoluteToLocal(P);
        if Content.Width < ClientWidth then
          R := RectF(P.X, P.Y, P.X + ClientWidth, P.Y + FRowHeight)
        else
          R := RectF(P.X, P.Y, P.X + Content.Width, P.Y + FRowHeight);
        if (Length(SelRects) > 0) and (i > 0) and (IsSelected(i - 1)) then
          SelRects[High(SelRects)] := UnionRect(R, SelRects[High(SelRects)])
        else
        begin
          SetLength(SelRects, Length(SelRects) + 1);
          SelRects[High(SelRects)] := R;
        end;
      end;
    end;
    // Create selection list
    if not Assigned(FSelections) then
      FSelections := TControlList.Create;
    // create selections
    if FSelections.Count < Length(SelRects) then
      for i := FSelections.Count to Length(SelRects) - 1 do
      begin
        Clone := TControl(FSelection.Clone(Self));
        Clone.StyleName := '';
        FSelections.Add(Clone);
        Clone.Parent := FSelection.Parent;
        Clone.Stored := False;
      end;
    // hide if not need
    if Length(SelRects) < FSelections.Count then
      for i := Length(SelRects) to FSelections.Count - 1 do
      begin
        FSelections[i].Visible := False;
      end;
    // align selections
    for i := 0 to High(SelRects) do
    begin
      FSelections[i].Visible := True;
      FSelections[i].BringToFront;
      R := SelRects[i];
      FSelections[i].SetBounds(R.Left, R.Top, R.Right - R.Left,
        R.Bottom - R.Top);
    end;
  finally
    for i := 0 to ColumnCount - 1 do
      Columns[i].UpdateSelected;
    UpdateFocusRect;
  end;
end;

procedure TCustomGrid.DoRealignItem(Sender: TObject;
  OldIndex, NewIndex: Integer);
begin
  if ColumnIndex = Columns[OldIndex].Index then
    ColumnIndex := NewIndex;
  Columns[OldIndex].Index := NewIndex;
end;

procedure TCustomGrid.DoResizeItem(Sender: TObject; var NewSize: Single);
begin
  if NewSize < 10 then
    NewSize := 10;
  if Columns[THeaderItem(Sender).Index].Width <> NewSize then
  begin
    Columns[THeaderItem(Sender).Index].Width := NewSize;
    RealignContent;
  end;
end;

procedure TCustomGrid.DoSelChanged;
begin
  if Assigned(FOnSelChanged) then
    FOnSelChanged(Self);
end;

procedure TCustomGrid.UpdateHeader;
var
  i: Integer;
  Item: THeaderItem;
  C: TFmxObject;
  LHeader: TOpenHeader;
begin
  if not Assigned(FHeader) then
    Exit;
  LHeader := TOpenHeader(FHeader);

  LHeader.Offset := -ViewportPosition.X;
  LHeader.RemoveObject(LHeader.LastItem);
  if LHeader.ChildrenCount < ColumnCount then
  begin
    for i := LHeader.ChildrenCount to ColumnCount - 1 do
    begin
      Item := THeaderItem.Create(Self);
      Item.Parent := LHeader;
      Item.Locked := True;
      Item.Stored := False;
      Item.Visible := Columns[i].Visible;
    end;
  end
  else
    for i := LHeader.ChildrenCount - 1 downto ColumnCount do
    begin
      C := LHeader.Children[i];
      C.DisposeOf;
    end;
  LHeader.AddObject(LHeader.LastItem);
  LHeader.LastItem.Index := LHeader.ChildrenCount - 1;

  for i := 0 to ColumnCount - 1 do
  begin
    THeaderItem(LHeader.Children[i]).Text := Columns[i].Header;
    THeaderItem(LHeader.Children[i]).Width := Columns[i].Width;
    THeaderItem(LHeader.Children[i]).Visible := Columns[i].Visible;
  end;
  LHeader.Realign;
end;

procedure TCustomGrid.UpdateColumns;
var
  I: Integer;
  R: TRectF;
begin
  R.Top := TopRow * FRowHeight;
  R.Bottom := R.Top + VisibleRows * FRowHeight;
  R.Left := 0;
  for I := 0 to ColumnCount - 1 do
  if Columns[i].Visible then
  begin
    R.Right := R.Left + Columns[I].Width;
    Columns[i].SetBoundsRect(R);
    R.Left := R.Right;
    Columns[i].UpdateColumn;
  end;
end;

procedure TCustomGrid.DoContentPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  i: Integer;
  P: TPointF;
begin
  if Assigned(Content) and Assigned(ContentLayout) then
  begin
    if FAlternatingRowBackground then
    begin
      for i := 0 to VisibleRows - 1 do
      begin
        if Odd(TopRow + i) then
        begin
          P := Content.LocalToAbsolute(PointF(0, (TopRow + i) * FRowHeight));
          P := TControl(Sender).AbsoluteToLocal(P);
          Canvas.FillRect(RectF(P.X, P.Y, P.X + Content.Width,
            P.Y + FRowHeight), 0, 0, [], AbsoluteOpacity, FOddFill);
        end;
      end;
    end;
  end;
end;

procedure TCustomGrid.DoContentPaint2(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
var
  i: Integer;
  P: TPointF;
  State: TCanvasSaveState;
  LAbsoluteOpacity, W: Single;
  function ColumnToCanvas(I: integer; P: TPointF): TPointF;
  begin
    P := Columns[I].LocalToAbsolute(P);
    Result := TControl(Sender).AbsoluteToLocal(P);
  end;
  procedure DrawVertLine(P: TPointF);
  begin
    if (P.X >= 0) then
    begin
      P.Offset(0.5, -0.5);
      Canvas.DrawLine(P,
                      PointF(P.X, P.Y + VisibleRows * FRowHeight),
                      LAbsoluteOpacity);
    end;
  end;
begin
  if Assigned(Content) and Assigned(ContentLayout) and
    (FShowVertLines or FShowHorzLines) then
  begin
    State := Canvas.SaveState;
    try
      Canvas.IntersectClipRect(ARect);
      Canvas.Stroke.Assign(FLineFill);
      LAbsoluteOpacity := AbsoluteOpacity;
      if FShowHorzLines then
      begin
        P := Content.LocalToAbsolute(PointF(0, (TopRow) * FRowHeight));
        P := TControl(Sender).AbsoluteToLocal(P);
        P.Offset(0.5, -0.5);
        W := Content.Width - 1;
        for i := 0 to VisibleRows do  // no -1
        begin
          Canvas.DrawLine(P,
                          PointF(P.X + W, P.Y),
                          LAbsoluteOpacity);
          P.Offset(0, FRowHeight);
        end;
      end;
      if FShowVertLines then
      begin
        if ColumnCount > 0 then
        begin
          P := ColumnToCanvas(0, PointF(0, 0));
          DrawVertLine(P);
        end;
        for i := 0 to ColumnCount - 1 do
        if Columns[i].Visible then
        begin
          P := ColumnToCanvas(i, PointF(Columns[i].Width, 0));
          if P.X < ContentLayout.Width + 1 then
            DrawVertLine(P)
          else
            Break;
        end;
      end;
    finally
      Canvas.RestoreState(State);
    end;
  end;
end;

function TCustomGrid.DoCalcContentBounds: TRectF;
var
  i: Integer;
begin
  Result.Create(0, 0, 0, 0);
  if (FUpdating > 0) or (not Assigned(ContentLayout)) then
    Exit;
  if (ColumnCount > 0) and (GetVisibleColumnCount > 0) then
  begin
    for i := 0 to ColumnCount - 1 do
    if Columns[i].Visible then
      Result.Right := Result.Right + Columns[i].Width;

    if ShowHorzLines and (not ShowHeader) then
      Result.Top := Result.Top - 1;
    if ShowVertLines then
      Result.Right := Result.Right + 1;
    Result.Bottom := Result.Top + (FRowCount * FRowHeight);
  end;
end;

function TCustomGrid.GetReadOnly: Boolean;
begin
  // Code to use observers removed.  Observers
  // do not affect ReadOnly property of a grid.
  Result := FReadOnly;
end;

procedure TCustomGrid.SetReadOnly(const Value: Boolean);
begin
  // Code to use observers removed.  Observers
  // do not affect ReadOnly property of a grid.
  FReadOnly := Value;
end;

function TCustomGrid.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := Columns[AIndex];
end;

function TCustomGrid.GetItemsCount: Integer;
begin
  Result := ColumnCount;
end;

procedure TCustomGrid.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                             const ContentSizeChanged: boolean);
begin
  inherited;
  UpdateColumns;
  UpdateHeader;
  UpdateSelection;
end;

function TCustomGrid.GetColumnCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  if Assigned(Content) and (Content.ChildrenCount > 0) then
    for i := 0 to Content.ChildrenCount - 1 do
      if Content.Children[i] is TColumn then
      begin
        Inc(Result);
      end;
end;

function TCustomGrid.RowByPoint(const X, Y: Single): Integer;
var
  P: TPointF;
begin
  P := LocalToAbsolute(PointF(X, Y));
  if Assigned(Content) then
  begin
    P := Content.AbsoluteToLocal(P);
    Result := trunc(P.Y / FRowHeight);
    Exit;
  end;
  Result := -1;
end;

function TCustomGrid.ColumnByIndex(const Idx: Integer): TColumn;
var
  C, i: Integer;
begin
  C := 0;
  if Assigned(Content) and (Content.ChildrenCount > 0) then
    for i := 0 to Content.ChildrenCount - 1 do
      if Content.Children[i] is TColumn then
      begin
        if C = Idx then
        begin
          Result := TColumn(Content.Children[i]);
          Exit;
        end;
        Inc(C);
      end;
  Result := nil;
end;

function TCustomGrid.ColumnByPoint(const X, Y: Single): TColumn;
var
  i: Integer;
  P, P1: TPointF;
begin
  P := LocalToAbsolute(PointF(X, Y));
  if Assigned(Content) then
  for i := 0 to Content.ChildrenCount - 1 do
    if Content.Children[i] is TColumn then
    begin
      Result := TColumn(Content.Children[i]);
      if (not Result.Visible) or
         (not IntersectRect(Result.UpdateRect, UpdateRect)) then
          Continue;
      P1 := Result.AbsoluteToLocal(P);
      if (Round(P1.X) >= 0) and (Round(P1.X) <= Result.Width) then
      begin
        Result := TColumn(Content.Children[i]);
        Exit;
      end;
    end;
  Result := nil;
end;

procedure TCustomGrid.ContentRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TColumn then
  begin
    if FUpdating = 0 then
    begin
      Realign;
    end;
  end;
end;

function TCustomGrid.CanEditModify: Boolean;
begin
  Result := not ReadOnly;
end;

function TCustomGrid.CanEditAcceptKey(Key: System.WideChar): Boolean;
begin
  Result := True;
end;

procedure TCustomGrid.KeyDown(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
var
  LSelected: Integer;
  LColumnIndex: Integer;
  LChangeRow: Boolean;
begin
  inherited;
  LSelected := Selected;
  LColumnIndex := ColumnIndex;
  if (ColumnCount > 0) and (RowCount > 0) then
  begin
    if (KeyChar <> #0) and not(ReadOnly) and not(Columns[LColumnIndex].ReadOnly)
    then
    begin
      if Assigned(Columns[LColumnIndex])
      and Assigned(Columns[LColumnIndex].CellControlByRow(LSelected)) then
      begin
        if (Key = 0) and (Columns[LColumnIndex].InEditMode = -1) then
        Columns[LColumnIndex].CellControlByRow(LSelected).SetFocus;
        TOpenControl(Columns[LColumnIndex].CellControlByRow(LSelected))
          .KeyDown(Key, KeyChar, Shift);
      end;
    end;
    case Key of
      vkF2:
        begin
          if Assigned(Columns[LColumnIndex])
          and Assigned(Columns[LColumnIndex].CellControlByRow(LSelected)) then
            Columns[LColumnIndex].CellControlByRow(LSelected).SetFocus;
        end;
      vkUp:
        if FSelected > 0 then
          LSelected := LSelected - 1;
      vkDown:
        if FSelected < FRowCount - 1 then
          LSelected := LSelected + 1;
      vkHome:
        if ssCtrl in Shift then
          LSelected := 0
        else
          LColumnIndex := 0;
      vkEnd:
        if ssCtrl in Shift then
          LSelected := RowCount - 1
        else
          LColumnIndex := ColumnCount - 1;
      vkPrior:
        if FSelected > 0 then
          LSelected := LSelected - VisibleRows;
      vkNext:
        if FSelected < FRowCount - 1 then
          LSelected := LSelected + VisibleRows;
      vkLeft:
        if LColumnIndex > 0 then
          LColumnIndex := LColumnIndex - 1;
      vkRight:
        if LColumnIndex < ColumnCount - 1 then
          LColumnIndex := LColumnIndex + 1;
    else
      Exit;
    end;
    // Observers
    LChangeRow := LSelected <> Selected;
    if LChangeRow then
    begin
      if LSelected < 0 then
        LSelected := 0;
      if LSelected >= FRowCount then
        LSelected := FRowCount - 1;
      LChangeRow := LSelected <> Selected;
    end;
    if LChangeRow then
    begin
      try
        TLinkObservers.PositionLinkPosChanging(Observers);
      except
        ReleaseCapture;
        FPressed := False;
        raise;
      end;
    end;
    // Change selection
    Selected := LSelected;
    ColumnIndex := LColumnIndex;
    // Observers
    if LChangeRow then
      TLinkObservers.PositionLinkPosChanged(Observers);
    Key := 0;
  end;
end;

procedure TCustomGrid.MouseToCell(const X, Y: Single; var Col, Row: Integer);
var
  Column: TColumn;
begin
  Column := ColumnByPoint(X, Y);
  if Column <> nil then
    Col := Column.Index
  else
    Col := ColumnIndex;
  Row := RowByPoint(X, Y);
  if (Row < 0) then
    Row := Selected;
end;

procedure TCustomGrid.SelCell(Col, Row: Integer);
begin
  if (Col <> ColumnIndex) or (Row <> Selected) then
  begin
    if (FFocus <> nil) then
      FFocus.Visible := False;
    BeginUpdate;
    try
      Root.SetActiveControl(nil);
      if (ColumnIndex > 0) and (ColumnIndex < ColumnCount) then
      begin
        Columns[ColumnIndex].FEditMode := -1;
      end;
    finally
      EndUpdate;
    end;
    Selected := Row;
    ColumnIndex := Col;
  end;
end;

procedure TCustomGrid.InternalClick(X, Y: Single);
var
  Column: TColumn;
  NewCol, NewRow: Integer;
  ChangeRow: Boolean;
begin
  MouseToCell(X, Y, NewCol, NewRow);
  if (NewRow >= 0) and (NewCol >= 0) then
  begin
    Column := Columns[NewCol];
    if Assigned(Column) and
     ((ColumnIndex <> Column.Index) or (Selected <> NewRow)) then
    begin
      if Observers.IsObserving(TObserverMapping.EditGridLinkID) and
         TLinkObservers.EditGridLinkIsEditing(Observers) then
      begin
        try
          TLinkObservers.EditGridLinkUpdate(Observers);
        except
          TLinkObservers.EditGridLinkReset(Observers);
          Reset;
          Column.SetFocus;
          raise;
        end;
      end;
      // Observers
      ChangeRow := NewRow <> Selected;
      if ChangeRow then
      begin
        try
          TLinkObservers.PositionLinkPosChanging(Observers);
        except
          ReleaseCapture;
          FPressed := False;
          raise;
        end;
      end;
      // Change selection
      SelCell(NewCol, NewRow);
      // Observers
      if ChangeRow then
        TLinkObservers.PositionLinkPosChanged(Observers);

    end;
  end;
end;

procedure TCustomGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (AniCalculations.TouchTracking = []) and
     (Button = TMouseButton.mbLeft) then
  begin
    InternalClick(X, Y);
  end;
end;

procedure TCustomGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (not AniCalculations.Moved) and
     (AniCalculations.TouchTracking <> []) and
     (Button = TMouseButton.mbLeft) then
  begin
    InternalClick(X, Y);
  end;
end;

procedure TCustomGrid.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if (AniCalculations.TouchTracking = []) and
     FPressed then
  begin
    InternalClick(X, Y);
  end;
end;

procedure TCustomGrid.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(Content) and ((AObject is TColumn)) then
  begin
    Content.AddObject(AObject);
    if FUpdating = 0 then
      Realign;
  end
  else
    inherited;
end;

procedure TCustomGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
end;

function TCustomGrid.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditGridLinkID then
    Result := True
  else if ID = TObserverMapping.PositionLinkID then
    Result := True;
end;

procedure TCustomGrid.ObserverAdded(const ID: Integer;
  const Observer: IObserver);
var
  LGridLinkObserver: IEditGridLinkObserver;
begin
  if ID = TObserverMapping.EditGridLinkID then
    Observer.OnObserverToggle := ObserverToggle;
  if Supports(Observer, IEditGridLinkObserver, LGridLinkObserver) then
    LGridLinkObserver.OnObserverCurrent := ObserverCurrent;
end;

function TCustomGrid.ObserverCurrent: TVarRec;
begin
  Result.VType := vtInteger;
  Result.VInteger := ColumnIndex;
end;

procedure TCustomGrid.ObserverToggle(const AObserver: IObserver;
  const Value: Boolean);
begin
  // Code to use observers removed.  Observers
  // do not affect ReadOnly property of a grid.
end;

function TCustomGrid.GetColumn(Index: Integer): TColumn;
begin
  Result := ColumnByIndex(Index);
end;

procedure TCustomGrid.SetRowCount(const Value: Integer);
begin
  if FRowCount <> Value then
  begin
    FRowCount := Value;
    RealignContent;
    if (FSelected >= FRowCount) and (FRowCount > 0) then
      Selected := FRowCount - 1;
  end;
end;

procedure TCustomGrid.SetRowHeight(const Value: Single);
begin
  if FRowHeight <> Value then
  begin
    FRowHeight := Value;
    if FRowHeight < 5 then
      FRowHeight := 5;
    Realign;
  end;
end;

function TCustomGrid.GetTopRow: Integer;
begin
  Result := Min(RowCount, Max(0, Trunc(ViewportPosition.Y / FRowHeight)));
end;

function TCustomGrid.GetBottomRow: Integer;
var
  I: Integer;
begin
  I := Trunc((ViewportPosition.Y + ClientHeight) / FRowHeight);
  Result := Min(RowCount - 1, I);
end;

function TCustomGrid.GetVisibleColumnCount: Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 0 to ColumnCount - 1 do
  if Columns[i].Visible then
    Inc(Result);
end;

function TCustomGrid.GetVisibleRows: Integer;
begin
  Result := GetBottomRow - GetTopRow + 1;
end;

function TCustomGrid.GetValue(Col, Row: Integer): TValue;
begin
  Result := TValue.Empty;
  if Assigned(FOnGetValue) then
    FOnGetValue(Self, Col, Row, Result);
end;

procedure TCustomGrid.CallbackGetValue(Col, Row: Integer; ACallback: TProc<TValue>);
var
  LHaveValue: Boolean;
begin
  if Assigned(FOnCallbackGetValue) then
  begin
    LHaveValue := False;
    FOnCallbackGetValue(Self, Col, Row,
     procedure(AValue: TValue)
     begin
       LHaveValue := True;
       ACallback(AValue);
     end);
    if not LHaveValue then
      ACallback(TValue.Empty);
  end
  else
    ACallback(GetValue(Col, Row));
end;

procedure TCustomGrid.SetValue(Col, Row: Integer; const Value: TValue);
begin
  if Assigned(FOnSetValue) then
    FOnSetValue(Self, Col, Row, Value);
end;

procedure TCustomGrid.SetSelected(const Value: Integer);
var
  LSelected: Integer;
  lScroled: boolean;
  Pos: TPointF;
begin
  try
    LSelected := Value;
    if LSelected < 0 then
      LSelected := 0;
    if LSelected >= FRowCount then
      LSelected := FRowCount - 1;
    if LSelected <> FSelected then
    begin
      FSelected := LSelected;
      lScroled := False;
      Pos := ViewportPosition;
      if (FSelected * FRowHeight) < Pos.Y then
      begin
        Pos.Y := FSelected * FRowHeight;
        lScroled := True;
      end;
      if (FSelected * FRowHeight > Pos.Y + ClientHeight - FRowHeight) then
      begin
        Pos.Y := FSelected * FRowHeight - ClientHeight + FRowHeight;
        lScroled := True;
      end;
      if lScroled then
        ViewportPosition := Pos
      else
      begin
        UpdateHeader;
        UpdateSelection;
      end;
      DoSelChanged;
    end;
  except
    on e : Exception do
      ApplicationHandleException(e);
  end;
end;

procedure TCustomGrid.SetColumnIndex(const Value: Integer);
var
  lColumnIndex: integer;
  Pos: TPointF;
  Col: TColumn;
begin
  lColumnIndex := Value;
  if lColumnIndex < 0 then
    lColumnIndex := 0;
  if lColumnIndex >= ColumnCount then
    lColumnIndex := ColumnCount - 1;
  if FColumnIndex <> lColumnIndex then
  begin
    Pos := ViewportPosition;
    FColumnIndex := lColumnIndex;
    if FUpdating = 0 then
      UpdateSelection;
    if (FColumnIndex >= 0)  then
    begin
      Col := Columns[FColumnIndex];
      Pos.X := Min(Col.Position.X, Pos.X);
      Pos.X := Max(Col.Position.X + Col.Width - ClientWidth, Pos.X);
      {if Col.Position.X < Pos.X then
        Pos.X := Col.Position.X;
      if Col.Position.X + Col.Width - ClientWidth > Pos.X then
        Pos.X := Col.Position.X + Col.Width - ClientWidth; }
    end;
    DoSelChanged;
  end;
end;

function TCustomGrid.IsOpaque: Boolean;
begin
  Result := True;
end;

function TCustomGrid.IsSelected(Row: Integer): Boolean;
begin
  Result := Row = FSelected;
end;

procedure TCustomGrid.SetAlternatingRowBackground(const Value: Boolean);
begin
  if FAlternatingRowBackground <> Value then
  begin
    FAlternatingRowBackground := Value;
    Repaint;
  end;
end;

procedure TCustomGrid.SetShowHorzLines(const Value: Boolean);
begin
  if FShowHorzLines <> Value then
  begin
    FShowHorzLines := Value;
    RealignContent;
  end;
end;

procedure TCustomGrid.SetShowVertLines(const Value: Boolean);
begin
  if FShowVertLines <> Value then
  begin
    FShowVertLines := Value;
    RealignContent;
  end;
end;

procedure TCustomGrid.SetTopRow(const Value: Integer);
var
  Point: TPointF;
  I: Integer;
begin
  I := Max(0, Min(RowCount - 1, Value));
  if I <> TopRow then
  begin
    Point := ViewportPosition;
    Point.Y := FRowHeight * I;
    ViewportPosition := Point;
  end;
end;

procedure TCustomGrid.SetShowHeader(const Value: Boolean);
begin
  if FShowHeader <> Value then
  begin
    FShowHeader := Value;
    if Assigned(FHeader) then
    begin
      FHeader.Visible := FShowHeader;
      RealignContent;
    end;
  end;
end;

procedure TCustomGrid.Reset;
begin
  SetFocus;
end;

{ TStringColumn }

procedure TStringColumn.UpdateRowCount(const RowCount: integer);
const PageSize = 16;
var lRowCount, N: integer;
begin
  lRowCount := RowCount;
  lRowCount := ((lRowCount + PageSize - 1) div (PageSize));
  N := ((Length(FCells) + PageSize - 1) div (PageSize));
  if (N <> lRowCount) then
    SetLength(FCells, lRowCount * PageSize);

  FRowCount := RowCount;
end;

function TStringColumn.GetCells(ARow: Integer): TValue;
begin
  if (ARow >= 0) and (ARow < Length(FCells)) then
    Result := FCells[ARow]
  else
    Result := inherited GetCells(ARow);
end;

procedure TStringColumn.SetCells(ARow: Integer; const Value: TValue);
var
  S: string;
  LGrid : TCustomGrid;
begin
  if (ARow >= 0) and (ARow < Length(FCells)) then
  begin
    S := Value.ToString;
    if FCells[ARow] <> S then
    begin
      FCells[ARow] := S;
      LGrid := Grid;
      if Assigned(LGrid) then
        UpdateColumn;
    end;
  end
  else
    inherited SetCells(ARow, Value);
end;

{ TStringGrid }

constructor TStringGrid.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TStringGrid.Destroy;
begin
  inherited;
end;

function TStringGrid.GetValue(Col, Row: Integer): TValue;
var
  C: TColumn;
begin
  C := Columns[Col];
  if Assigned(C) then
  begin
    C.UpdateRowCount(RowCount);
    Result := C.GetCells(Row);
  end
  else
    Result := TValue.Empty;
end;

procedure TStringGrid.SetValue(Col, Row: Integer; const Value: TValue);
var
  C: TColumn;
begin
  C := Columns[Col];
  if Assigned(C) then
  begin
    C.UpdateRowCount(RowCount);
    C.SetCells(Row, Value);
  end;
end;

function TStringGrid.GetCells(ACol, ARow: Integer): string;
begin
  Result := GetValue(ACol, ARow).ToString;
end;

function TStringGrid.GetDefaultStyleLookupName: string;
begin
  Result := 'gridstyle';
end;

procedure TStringGrid.SetCells(ACol, ARow: Integer; const Value: string);
begin
  SetValue(ACol, ARow, Value)
end;

procedure TCustomGrid.SetShowSelectedCell(const Value: Boolean);
begin
  if FShowSelectedCell <> Value then
  begin
    FShowSelectedCell := Value;
    UpdateSelection;
  end;
end;

{ TTextCell }

procedure TTextCell.DoEnter;
var
  LColumn: TColumn;
  LGrid: TCustomGrid;
  LHidden: boolean;
begin
  inherited;
 if Owner is TColumn then
  begin
    LColumn := TColumn(Owner);
    LGrid := LColumn.Grid;
    if (LGrid.Selected = LColumn.FLastRow) and
       (LGrid.Selected >= LGrid.TopRow) and
       (LGrid.Selected <= LGrid.BottomRow) then
    begin
      LHidden:= Caret.TemporarilyHidden;
      try
        Caret.TemporarilyHidden := True;
        SelStart := LColumn.FLastStartPos;
        SelLength := LColumn.FLastSelLength;
      finally
        Caret.TemporarilyHidden := LHidden;
      end;
    end;
  end;
end;

procedure TTextCell.DoExit;
var
  LColumn: TColumn;
  LGrid: TCustomGrid;
begin
  if (Owner is TColumn) then
  begin
    LColumn := TColumn(Owner);
    LGrid := LColumn.Grid;
    if (LGrid.Selected >= LGrid.TopRow) and
       (LGrid.Selected <= LGrid.BottomRow) then
    begin
      if (SelStart > 0) or
         (SelLength < Length(Text)) or
         (CaretPosition < Length(Text)) then
      begin
          LColumn.FLastRow := LGrid.Selected;
          LColumn.FLastStartPos := SelStart;
          LColumn.FLastSelLength := SelLength;
          LColumn.FLastPos := CaretPosition;
          SelLength := 0;
      end;
    end;
  end;
  inherited;
end;

{ TCheckCell }

function TCheckCell.GetObservers: TObservers;
var
  LColumn: TColumn;
begin
  Result := nil;
  if Owner is TColumn then
  begin
    LColumn := TColumn(Owner);
    if LColumn is TCheckColumn then
      Result := TCheckColumn(LColumn).GetObserversProxy;
  end;
end;

{ TObserversProxy }

procedure TObserversProxy.AddObserver(const IDs: array of Integer;
  const AIntf: IInterface);
begin
  Assert(False);
end;

procedure TObserversProxy.AddObserver(const ID: Integer;
  const AIntf: IInterface);
begin
  Assert(False);
end;

function TObserversProxy.CanObserve(const ID: Integer): Boolean;
begin
  Assert(False);
  Result := False;
end;

constructor TObserversProxy.Create(const AGrid: TCustomGrid; ATrack: Boolean);
begin
  FGrid := AGrid;
  FEditLink := TEditLinkProxy.Create(AGrid);
  TEditLinkProxy(FEditLink).Track := ATrack;
end;

function TObserversProxy.GetMultiCastObserver(
  const ID: Integer): IInterfaceList;
begin
  Assert(False);
  Result := nil;
end;

function TObserversProxy.GetSingleCastObserver(const ID: Integer): IInterface;
begin
  if ID = TObserverMapping.EditLinkID then
    Result := Self.FEditLink
  else
    Result := nil;
end;

function TObserversProxy.IsObserving(const ID: Integer): Boolean;
begin
  Result := (ID = TObserverMapping.EditLinkID)
     and FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID);
end;

procedure TObserversProxy.RemoveObserver(const ID: Integer;
  const AIntf: IInterface);
begin
  Assert(False);
end;

procedure TObserversProxy.RemoveObserver(const IDs: array of Integer;
  const AIntf: IInterface);
begin
  Assert(False);
end;

function TObserversProxy.TryIsObserving(const ID: Integer;
  out AIntf: IInterface): Boolean;
begin
  if IsObserving(ID) then
  begin
    AIntf := FEditLink;
  end;
  Result := AIntf <> nil;
end;

{ TEditLinkProxy }

procedure TEditLinkProxy.BeginUpdate;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).BeginUpdate
end;

constructor TEditLinkProxy.Create(const AGrid: TCustomGrid);
begin
  FGrid := AGrid;
end;

function TEditLinkProxy.Edit: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).Edit
  else
    Result := False;
end;

procedure TEditLinkProxy.EndUpdate;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).EndUpdate
end;

function TEditLinkProxy.GetActive: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).GetActive
  else
    Result := False;
end;

function TEditLinkProxy.GetIsEditing: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).GetIsEditing
  else
    Result := False;
end;

function TEditLinkProxy.GetIsReadOnly: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).GetIsReadOnly
  else
    Result := False;
end;

function TEditLinkProxy.GetOnObserverToggle: TObserverToggleEvent;
begin

end;

function TEditLinkProxy.GetTrack: Boolean;
begin
  Result := True;
end;

function TEditLinkProxy.GetUpdating: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).GetUpdating
  else
    Result := False;
end;

function TEditLinkProxy.IsModified: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).IsModified
  else
    Result := False;
end;

function TEditLinkProxy.IsRequired: Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).IsRequired
  else
    Result := False;
end;

function TEditLinkProxy.IsValidChar(AKey: Char): Boolean;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    Result := TLinkObservers.GetEditGridLink(FGrid.Observers).IsValidChar(AKey)
  else
    Result := False;
end;

procedure TEditLinkProxy.Modified;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).Modified
end;

procedure TEditLinkProxy.Removed;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).Removed
end;

procedure TEditLinkProxy.Reset;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).Reset
end;

procedure TEditLinkProxy.SetActive(Value: Boolean);
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).SetActive(Value)
end;

procedure TEditLinkProxy.SetIsReadOnly(Value: Boolean);
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).SetIsReadOnly(Value)
end;

procedure TEditLinkProxy.SetOnObserverToggle(AEvent: TObserverToggleEvent);
begin
end;

procedure TEditLinkProxy.Update;
begin
  if FGrid.Observers.IsObserving(TObserverMapping.EditGridLinkID) then
    TLinkObservers.GetEditGridLink(FGrid.Observers).Update
end;

initialization
  RegisterFmxClasses([TTextCell, TCheckCell, TProgressCell, TPopupCell, TStringColumn,
    TGrid, TStringGrid, TColumn, TCheckColumn, TProgressColumn,
    TPopupColumn, TImageColumn]);
end.

