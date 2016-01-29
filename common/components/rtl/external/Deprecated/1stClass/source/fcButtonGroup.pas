unit fcButtonGroup;
{
//
// Components : TfcButtonGroup
//
// Copyright (c) 1999 by Woll2Woll Software
//
// 5/13/99 - RSW - When transparent, paint should also paint the button area
}

interface

{$i fcIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, TypInfo, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Math, fcChangeLink, 
  fcButton, fcClearPanel, fcCommon, fcShapeBtn, fcImgBtn, fcCollection;

type
  TfcButtonGroupItem = class;
  TfcButtonGroupItems = class;
  TfcCustomButtonGroup = class;
  TfcButtonGroupItemClass = class of TfcButtonGroupItem;
  TfcButtonGroupItemsClass = class of TfcButtonGroupItems;
{
// - TfcButtonGroupItem
//
// Properties:
// - GroupIndex: Wrapper to GroupIndex property of the Item's control.
//               This property is dependent on the GroupIndexPropName
//               property of TfcButtonGroupItems.
//
// - Selected:   Wrapper to the property of the the Item's property that
//               signifies selection.  This is usually the "Down" property.
//
// - PointerTag: The pointer equivalent to the Tag property.  (Yes, the
//               Tag property can be used for this purpose also, but that
//               looks really ugly in code.
//
// - Tag:        The standard Tag property.
//
// - Control:    The "Control" of the control group.  The type of this
//               component is determined by the ControlClass property of
//               the control group.  This property can NOT be published
//               or Delphi's IDE will mistake the ButtonGroup for a form
//               and generate errors.
}

  TfcButtonGroupItem = class(TfcCollectionItem)
  private
    // Property storage variables
    FButton: TfcCustomBitBtn;

    // Property access methods
    function GetButtonGroup: TfcCustomButtonGroup; virtual;
    function GetGroupIndex: Integer; virtual;
    function GetSelected: Boolean; virtual;
    procedure SetGroupIndex(Value: Integer); virtual;
    procedure SetSelected(Value: Boolean); virtual;
  protected
    // Virtual Methods
    function GetDisplayName: string; override;
    procedure Loaded; virtual;
    procedure SetIndex(Value: Integer); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function GetInstance(const PropertyName: string): TPersistent; override;

    property Button: TfcCustomBitBtn read FButton;
    property ButtonGroup: TfcCustomButtonGroup read GetButtonGroup;
    property GroupIndex: Integer read GetGroupIndex write SetGroupIndex;
    property Selected: Boolean read GetSelected write SetSelected;
  end;

{
// - TfcButtonGroupItems
// Properties:
// - Items:       The indexed array property that returns the
//                TfcButtonGroupItem corresponding to the Index
//                parameter.
//
// - Selected:    Returns the control that currently has its "Selected"
//                property set to true.  If none, then returns nil.
//
// Methods:
// - Add:         Adds a new item to the control group and returns the newly
//                created item.
//
// - Clear:       Deletes all of the items in the TfcButtonGroupItems array
//                and each of the associated Controls.
//
// - FindControl: Searches through the array of TfcButtonGroupItems and
//                returns the item that has its Control property pointing
//                to the AControl parameter.
//
// - FindPointerTag: Searches through the array of TfcButtonGroupItems
//                and returns the item that has its PointerTag property
//                pointing to the APointerTag parameter.
}

  TfcButtonGroupItems = class(TfcCollection)
  private
    FButtonGroup: TfcCustomButtonGroup;
  protected
    // Overriden methods
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;

    // Property access methods
    function GetButtonGroup: TfcCustomButtonGroup; virtual;
    function GetItems(Index: Integer): TfcButtonGroupItem;
    function GetVisibleCount: Integer;
    function GetVisibleItems(Index: Integer): TfcButtonGroupItem;
  public
    ArrangingControls: Boolean;
    AddingControls: Boolean;
    DeletingControl: Boolean;

    constructor Create(AButtonGroup: TfcCustomButtonGroup; ACollectionItemClass: TfcButtonGroupItemClass); virtual;

    function Add: TfcButtonGroupItem;
//    function AddInLoading: TfcButtonGroupItem; { RSW - Don't check loading state }
    function AddItem: TfcCollectionItem; override;
    procedure ArrangeControls; virtual;
    function FindButton(AButton: TfcCustomBitBtn): TfcButtonGroupItem; virtual;
    function FindPointerTag(APointerTag: Pointer): TfcButtonGroupItem; virtual;

    procedure Clear; virtual;

    property ButtonGroup: TfcCustomButtonGroup read GetButtonGroup;
    property Items[Index: Integer]: TfcButtonGroupItem read GetItems {stored False}; default;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleItems[Index: Integer]: TfcButtonGroupItem read GetVisibleItems;
  end;

  TfcButtonGroupChangeEvent = procedure(ButtonGroup: TfcCustomButtonGroup;
    OldSelected, Selected: TfcButtonGroupItem) of object;

{
// - TfcCustomButtonGroup
// Properties:
// - ControlSpacing: The spacing between each of the controls.  This does
//                   not include spacing on the outer edge; for that use
//                   the standard BorderWidth property.
//
// - Columns:        This effect of this property is dependent on the
//                   Layout property.  If Layout is vertical (the default),
//                   then this property specifies the number of columns;
//                   otherwise it specifies the number of rows.
//
// - Items:          The TfcButtonGroupItems array property.
//
// - Layout:         Determines the orientation of the controls -- how they
//                   are arranged.  If this property is set to cglVertical,
//                   then controls arranged in a top-down, left-to-right
//                   fashion.  Otherwise, they are arranged in a left-to-
//                   right, top-down fashion.
//
// - MaxControlSize: Normally, controls are sized to take the maximum amount
//                   of space available given the size of the control group.
//                   This property allows the user to specify the maximum size
//                   of a button. (For example, the buttons on the Win95 Task
//                   Bar can only be a maximum of ~150 pixels.
//
// Events:
// - OnChange:             Occurs immediately after the currently selected
//                         control has changed.
//
// - OnChanging:           Occurs immediately before the currently
//                         selected control changes.
}

  TfcButtonGroupClickStyle = (bcsCheckList, bcsRadioGroup, bcsClick);

  TfcCustomButtonGroup = class(TfcCustomTransparentPanel)
  private
    // Property storage variables
    FAutoBold: Boolean;
    FClickStyle: TfcButtonGroupClickStyle;
    FControlSpacing: Integer;
    FColumns: Integer;
    FLayout: TfcLayout;
    FMaxControlSize: Integer;
    FOldSelected: TfcButtonGroupItem;
    FOnChange: TfcButtonGroupChangeEvent;
    FOnChanging: TfcButtonGroupChangeEvent;

    FButtonClass: TfcCustomBitBtnClass;
    FLastButtonRect: TRect;
    FChangeLink: TfcChangeLink;

    // Property Access Methods
    function GetButton(Name: string): TfcCustomBitBtn;
    function GetSelected: TfcButtonGroupItem; virtual;
    procedure SetAutoBold(Value: Boolean);
    procedure SetClickStyle(Value: TfcButtonGroupClickStyle);
    procedure SetControlSpacing(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetItems(Value: TfcButtonGroupItems);
    procedure SetLastButtonRect(Value: TRect);
    procedure SetLayout(Value: TfcLayout);
    procedure SetSelected(Value: TfcButtonGroupItem);

    // Message Handlers
    {$ifdef fcDelphi4Up}
    procedure CMBorderChanged(var Message: TMessage); message CM_BORDERCHANGED;
    {$endif}
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    SuspendNotification: Boolean;  // Flag to prevent access violations on notification method
    FItems: TfcButtonGroupItems;

    function GetCollectionClass: TfcButtonGroupItemsClass; virtual;
    function ResizeToControl(Control: TControl; DoResize: Boolean): TSize; virtual;
    procedure ButtonPressed(Sender: TObject); virtual;
    procedure ButtonPressing(Sender: TObject); virtual;
    procedure MouseMoveInLoop(Sender: TObject); virtual;
    procedure DoChanging(OldSelected, Selected: TfcButtonGroupItem); virtual;
    procedure DoChange(OldSelected, Selected: TfcButtonGroupItem); virtual;

    // Overridden methods
    function GetChildOwner: TComponent; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure WriteState(Writer: TWriter); override;

    // Virtual Property access methods
    procedure SetName(const NewName: TComponentName); override;

    function GetButtonClassName: string; virtual;
    procedure SetButtonClass(Value: TfcCustomBitBtnClass); virtual;
    procedure SetButtonClassName(Value: string); virtual;
    procedure SetMaxControlSize(Value: Integer); virtual;
    procedure UpdateBold(AAutoBold: Boolean); virtual;
    procedure DefineProperties(Filer: TFiler);override;
    function IsTransparent: boolean; override;
    procedure WndProc(var Message: TMessage); override;

    property ButtonClass: TfcCustomBitBtnClass read FButtonClass write SetButtonClass;
    property OldSelected: TfcButtonGroupItem read FOldSelected;
  public
    ButtonGroupPatch: Variant;
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

//    function ControlSelected: Boolean; virtual;

    property AutoBold: Boolean read FAutoBold write SetAutoBold;
    property Buttons[Name: string]: TfcCustomBitBtn read GetButton;
    property ClickStyle: TfcButtonGroupClickStyle read FClickStyle write SetClickStyle;
    property ControlSpacing: Integer read FControlSpacing write SetControlSpacing;
    property Columns: Integer read FColumns write SetColumns;
    property ButtonItems: TfcButtonGroupItems read FItems write SetItems stored False;
    property Layout: TfcLayout read FLayout write SetLayout;
    property MaxControlSize: Integer read FMaxControlSize write SetMaxControlSize;
    property Selected: TfcButtonGroupItem read GetSelected write SetSelected;
    property OnChange: TfcButtonGroupChangeEvent read FOnChange write FOnChange;
    property OnChanging: TfcButtonGroupChangeEvent read FOnChanging write FOnChanging;

    property ButtonClassName: string read GetButtonClassName write SetButtonClassName;
    property LastButtonRect: TRect write SetLastButtonRect;
  end;

  TfcButtonGroup = class(TfcCustomButtonGroup)
  published
    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    {$endif}

    property Align;
    property AutoBold;
    property BevelInner;
    property BevelOuter;
    property BorderStyle;
    property BorderWidth;
    property ButtonClassName;
    property ClickStyle;
    property ControlSpacing;
    property Columns;
    property Color;
    property Font;
    property ParentFont;
    property ButtonItems;
    property Layout;
    property MaxControlSize;
    property PopupMenu;
    property TabOrder;
    property TabStop default True;
    property Transparent;
    property Visible;

    property OnChange;
    property OnChanging;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
  end;

implementation

//{$ifdef fcDelphi4Up}
//type TFormDesigner = IFormDesigner;
//{$endif}

// TfcButtonGroupItem

constructor TfcButtonGroupItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);

  if not (csLoading in ButtonGroup.ComponentState) then
  begin
    ButtonGroup.FItems.ArrangingControls := True;
    FButton := ButtonGroup.ButtonClass.Create(ButtonGroup.Owner);
    FButton.Top := ButtonGroup.Height;
    FButton.Parent := ButtonGroup;
    SetGroupIndex(1);
    ButtonGroup.FItems.ArrangingControls := False;
  end;
end;

destructor TfcButtonGroupItem.Destroy;
begin
  ButtonGroup.SuspendNotification := True;
  ButtonGroup.FItems.DeletingControl := True;
  FButton.Free;
  ButtonGroup.FItems.DeletingControl := False;
  ButtonGroup.SuspendNotification := False;
  inherited;
end;

function TfcButtonGroupItem.GetButtonGroup: TfcCustomButtonGroup;
begin
  result := TfcButtonGroupItems(Collection).ButtonGroup;
end;

function TfcButtonGroupItem.GetGroupIndex: Integer;
begin
  result := Button.GroupIndex;
end;

function TfcButtonGroupItem.GetSelected: Boolean;
begin
  if Button=nil then result:= false  { Delphi 5 calls GetActivePage before button is initialized }
  else result := Button.Selected;
end;

procedure TfcButtonGroupItem.SetGroupIndex(Value: Integer);
begin
  Button.GroupIndex := Value;
end;

procedure TfcButtonGroupItem.SetSelected(Value: Boolean);
//var ParForm: TCustomForm;
begin
  Button.Down := Value;
  ButtonGroup.FItems.ArrangeControls;
{  if csDesigning in ButtonGroup.ComponentState then
  begin
    ParForm := GetParentForm(ButtonGroup);
    if (ParForm <> nil) and (ParForm.Designer <> nil) then
      ParForm.Designer.Modified;
  end;}
end;

procedure TfcButtonGroupItem.Loaded;
begin
  FButton.OnSetName := SetButtonName;
end;

procedure TfcButtonGroupItem.SetIndex(Value: Integer);
begin
  inherited;
//  ShowMessage(Button.Name + '|' + InttoStr(Value));
  if not (csLoading in ButtonGroup.ComponentState) then ButtonGroup.SetChildOrder(Button, Value);
end;

function TfcButtonGroupItem.GetDisplayName: string;
begin
  if Button <> nil then result := Button.Name;
end;

function TfcButtonGroupItem.GetInstance(const PropertyName: string): TPersistent;
begin
  result := Button;
end;

// TfcButtonGroupItems

constructor TfcButtonGroupItems.Create(AButtonGroup: TfcCustomButtonGroup; ACollectionItemClass: TfcButtonGroupItemClass);
begin
  inherited Create(ACollectionItemClass);
  FButtonGroup := AButtonGroup;
end;

function TfcButtonGroupItems.GetOwner: TPersistent;
begin
  result := FButtonGroup;
end;

procedure TfcButtonGroupItems.Update(Item: TCollectionItem);
begin
  inherited;
  ArrangeControls;
end;

function TfcButtonGroupItems.GetButtonGroup: TfcCustomButtonGroup;
begin
  result := FButtonGroup;
end;

function TfcButtonGroupItems.GetItems(Index: Integer): TfcButtonGroupItem;
begin
  result := TfcButtonGroupItem(inherited Items[Index]);
end;

function TfcButtonGroupItems.GetVisibleCount: Integer;
var i: Integer;
begin
  result := 0;
  for i := 0 to Count - 1 do if Items[i].Button.Visible or (csDesigning in ButtonGroup.ComponentState) then inc(result);
end;

function TfcButtonGroupItems.GetVisibleItems(Index: Integer): TfcButtonGroupItem;
var i: Integer;
    CurIndex: Integer;
begin
  result := nil;
  CurIndex := 0;
  for i := 0 to Count - 1 do if Items[i].Button.Visible or (csDesigning in ButtonGroup.ComponentState) then
  begin
    if Index = CurIndex then
    begin
      result := Items[i];
      Break;
    end;
    inc(CurIndex);
  end;
end;

function TfcButtonGroupItems.Add: TfcButtonGroupItem;
  function GetHighestGroupIndex: Integer;
  var i: Integer;
  begin
    result := 0;
    for i := 0 to Count - 1 do
      if Items[i].GroupIndex > result then result := Items[i].GroupIndex;
  end;
begin
  AddingControls := True;
  result := TfcButtonGroupItem(inherited Add);
  if (result.Button <> nil) then
  begin
    if (csDesigning in ButtonGroup.ComponentState) then
      result.Button.Name := fcGenerateName(result.Button.Owner, ButtonGroup.Name + Copy(ButtonGroup.ButtonClassName, 2, Length(ButtonGroup.ButtonClassName)));
    if Count > 1 then result.Button.Assign(Items[0].Button);
    if ButtonGroup.ClickStyle = bcsCheckList then
    begin
      result.Button.GroupIndex := GetHighestGroupIndex + 1;
      result.Button.AllowAllUp := True;
    end;
  end;
  AddingControls := False;
  ArrangeControls;
end;

function TfcButtonGroupItems.AddItem: TfcCollectionItem;
begin
  result := Add;
end;

procedure TfcButtonGroupItems.Clear;
var i: Integer;
begin
  for i := Count - 1 downto 0 do
    Items[i].Free;
end;

procedure TfcButtonGroupItems.ArrangeControls;
var i: Integer;
    Rows, Cols: Integer;
    BtnWidth, BtnHeight: Integer;
    RemainHeight, RemainWidth, PadHeight, PadWidth: Integer;
    ExtraRows, ExtraCols: Integer;
    ButtonGroupWidth, ButtonGroupHeight: Integer;
    NewLeft, NewTop, NewWidth, NewHeight: Integer;
    BtnSpacing: Integer;
    OldTransparent: Boolean;
  function Coord: TPoint;
  begin
    if ButtonGroup.Layout = loVertical then
    begin
      // Caculate Column
      if i <= ExtraRows * (Rows + 1) then
        result.x := (i - 1) div (Rows + 1)
      else
        result.x := ExtraRows +
          (((i - 1) - (ExtraRows * (Rows + 1))) div Rows);
      // Calculate Row
      if i <= ExtraRows * (Rows + 1) then
        result.y := (i - 1) mod (Rows + 1)
      else
        result.y := ((i - 1) - (ExtraRows * (Rows + 1))) mod Rows;
    end else begin
      result := Point(
        (i - 1) div Rows,
        (i - 1) mod Rows)
    end;
  end;
  function ControlAtCoord(x, y: Integer): TControl;
  var Index: Integer;
  begin
    if ButtonGroup.Layout = loVertical then
    begin
      if x < ExtraRows then
        Index := (x * (Rows + 1)) + (y mod (Rows + 1))
      else
        Index := ((ExtraRows * (Rows + 1)) + ((x - ExtraRows) * Rows)) + (y mod Rows);
      result := Items[Index].Button;
    end else begin
      result := Items[x * Rows + y].Button;
    end;
  end;
  function GetRows: Integer;
  begin
    result := Rows + ord(ExtraRows > 0);
  end;
  function GetCols: Integer;
  begin
    result := Cols + ord(ExtraCols > 0);
  end;
begin
  if (Count = 0) or (ArrangingControls) or AddingControls then Exit;
  ArrangingControls := True;
  OldTransparent := ButtonGroup.FTransparent;
  ButtonGroup.FTransparent := False;

  BtnSpacing := ButtonGroup.ControlSpacing;

  PadHeight := 0; RemainHeight := 0;
  PadWidth := 0; RemainWidth := 0;

  Rows := Count div ButtonGroup.Columns;
  Cols := ButtonGroup.Columns;
  ExtraRows := Count mod ButtonGroup.Columns;
  ExtraCols := 0;
  if ButtonGroup.Layout <> loVertical then
    with Rect(Rows, Cols, ExtraRows, ExtraCols) do
    begin
      Rows := Top;
      Cols := Left;
      ExtraRows := Bottom;
      ExtraCols := Right;
    end;

  ButtonGroupWidth := fcRectWidth(ButtonGroup.ClientRect) - 2 * ButtonGroup.BorderWidth;
  ButtonGroupHeight := fcRectHeight(ButtonGroup.ClientRect) - 2 * ButtonGroup.BorderWidth;

  BtnWidth := (ButtonGroupWidth - (BtnSpacing * (GetCols - 1))) div GetCols;
  BtnHeight := (ButtonGroupHeight - (BtnSpacing * (GetRows - 1))) div GetRows;
  if ButtonGroup.MaxControlSize > 0 then
  begin
    if ButtonGroup.Layout = loVertical then
      BtnHeight := fcMin(BtnHeight, ButtonGroup.MaxControlSize)
    else BtnWidth := fcMin(BtnWidth, ButtonGroup.MaxControlSize);
  end;
  if BtnWidth <> ButtonGroup.MaxControlSize then begin
    RemainHeight := ButtonGroupHeight - ((GetRows * BtnHeight) + ((GetRows - 1) * BtnSpacing));
    PadHeight := Ceil(RemainHeight / GetRows);
    RemainWidth := ButtonGroupWidth - ((GetCols * BtnWidth) + ((GetCols - 1) * BtnSpacing));
    PadWidth := Ceil(RemainWidth / GetCols);
  end;

  for i := 1 to VisibleCount do with VisibleItems[i - 1].Button do
  begin
    with Coord do
    begin
      // Calc Left
      if (x = 0) and (y = 0) then NewLeft := ButtonGroup.BorderWidth
      else if y = 0 then NewLeft := ControlAtCoord(x - 1, y).BoundsRect.Right + BtnSpacing
      else NewLeft := ControlAtCoord(x, y - 1).Left;

      // Calc Top
      if y = 0 then NewTop := ButtonGroup.BorderWidth
      else NewTop := ControlAtCoord(x, y - 1).BoundsRect.Bottom + BtnSpacing;

      // Calc Width
      if y = 0 then
      begin
        NewWidth := BtnWidth + fcMin(PadWidth, RemainWidth);
        dec(RemainWidth, PadWidth);
        if RemainWidth < 0 then RemainWidth := 0;
      end else NewWidth := ControlAtCoord(x, y - 1).Width;

      // Calc Height
      if x = 0 then
      begin
        NewHeight := BtnHeight + fcMin(PadHeight, RemainHeight);
        dec(RemainHeight, PadHeight);
        if RemainHeight < 0 then RemainHeight := 0;
      end else NewHeight := ControlAtCoord(x - 1, y).Height;

      SetBounds(NewLeft, NewTop, NewWidth, NewHeight)
//      SetWindowPos(Handle, 0, NewLeft, NewTop, NewWidth, NewHeight, SWP_NOREDRAW or SWP_NOZORDER);
    end;
  end;
//  ButtonGroup.Invalidate;
  ButtonGroup.FTransparent := OldTransparent;
  ArrangingControls := False;
end;

function TfcButtonGroupItems.FindButton(AButton: TfcCustomBitBtn): TfcButtonGroupItem;
var i: Integer;
begin
  result := nil;
  for i := 0 to Count - 1 do
    if Items[i].Button = AButton then
    begin
      result := Items[i];
      Break;
    end;
end;

function TfcButtonGroupItems.FindPointerTag(APointerTag: Pointer): TfcButtonGroupItem;
var i: Integer;
begin
  result := nil;
  for i := 0 to Count - 1 do
    if Items[i].PointerTag = APointerTag then
    begin
      result := Items[i];
      Break;
    end;
end;

// TfcCustomButtonGroup

constructor TfcCustomButtonGroup.Create(Owner: TComponent);
begin
  inherited;

  FButtonClass := TfcShapeBtn;

  FAutoBold := True;
  FItems := GetCollectionClass.Create(self, TfcButtonGroupItem);
  FItems.ArrangingControls := True;
  FClickStyle := bcsRadioGroup;
  FColumns := 1;
  FControlSpacing := 1;

  FChangeLink := TfcChangeLink.Create;
  FChangeLink.OnChange := ButtonPressed;
  FChangeLink.OnChanging := ButtonPressing;

  BevelInner := bvNone;
  BevelOuter := bvNone;
  ControlStyle := ControlStyle - [csSetCaption{, csAcceptsControls}];
  Height := 100;
  TabStop := True;
  Transparent := False;
  Width := 75;
end;

destructor TfcCustomButtonGroup.Destroy;
begin
  FItems.ArrangingControls := True;
  FChangeLink.Free;
  FItems.Free;
  FItems := nil;
  inherited;
end;

{function TfcCustomButtonGroup.ControlSelected: Boolean;
var i: Integer;
    Selections: TComponentList;
begin
  result := False;
  Selections := TComponentList.Create;
  TFormDesigner(GetParentForm(self).Designer).GetSelections(Selections);
  for i := 0 to Selections.Count - 1 do
    if (Selections[i] is ButtonClass) and
       ((Selections[i] as ButtonClass).Parent = self) then
    begin
      result := True;
      Exit;
    end;
end;
}

procedure TfcCustomButtonGroup.UpdateBold(AAutoBold: Boolean);
var i: Integer;
begin
  if not AAutoBold then Exit;
  for i := 0 to FItems.Count - 1 do with FItems[i].Button.Font do
    Style := Style - [fsBold];
  if (Selected <> nil) and AutoBold and (ClickStyle = bcsRadioGroup) then with Selected.Button.Font do
    Style := Style + [fsBold];
end;

{$ifdef fcDelphi4Up}
procedure TfcCustomButtonGroup.CMBorderChanged(var Message: TMessage);
begin
  inherited;
  FItems.ArrangeControls;
end;
{$endif}

procedure TfcCustomButtonGroup.CMControlListChange(var Message: TCMControlListChange);
var i: Integer;
begin
  if (Message.Control is TfcCustomBitBtn) then with (Message.Control as TfcCustomBitBtn) do
  begin
    if Message.Inserting then RegisterChanges(FChangeLink)
    else UnRegisterChanges(FChangeLink);
  end;

  if (FItems <> nil) and not SuspendNotification and not (Message.Inserting) then
    for i := 0 to FItems.Count - 1 do
      if FItems[i].Button = Message.Control then
      begin
        FItems.DeletingControl := True;
        FItems[i].FButton := nil;  // Prevent access violations, otherwise random memory would be attempted to be freed in the destructor of the item
        FItems[i].Free;
        FItems.DeletingControl := False;
        Invalidate;
        Break;
      end;

  inherited;
end;

procedure TfcCustomButtonGroup.CMControlChange(var Message: TCMControlChange);
var curItem: TfcButtonGroupItem;
begin
  inherited;
  if Message.Inserting and (Message.Control is TfcCustomBitBtn) and
     (csLoading in ComponentState) and not FItems.AddingControls then
  begin
     curItem:= ButtonItems.Add;

     with curItem do begin
       FItems.AddingControls := True;
       FButton := Message.Control as TfcCustomBitBtn;
       FItems.AddingControls := False;
     end
  end;
end;

procedure TfcCustomButtonGroup.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.result := DLGC_WANTARROWS;
end;

function TfcCustomButtonGroup.GetCollectionClass: TfcButtonGroupItemsClass;
begin
  result := TfcButtonGroupItems;
end;

procedure TfcCustomButtonGroup.ButtonPressing(Sender: TObject);
  function CalcSelected: TfcButtonGroupItem;
  var i: Integer;
  begin
    result := FOldSelected;
    for i := 0 to FItems.Count - 1 do
      if FItems[i].Selected then
      begin
        result := FItems[i];
        Break;
      end;
  end;
begin
  if not (csLoading in ComponentState) then
  begin
    FOldSelected := CalcSelected;
    DoChanging(FOldSelected, FItems.FindButton(Sender as TfcCustomBitBtn));
  end;
end;

procedure TfcCustomButtonGroup.MouseMoveInLoop(Sender: TObject);
var i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    if FItems[i].Button <> Sender then Perform(CM_MOUSELEAVE, 0, 0);
end;

procedure TfcCustomButtonGroup.ButtonPressed(Sender: TObject);
var NewSelected: TfcButtonGroupItem;
begin
  if not (csLoading in ComponentState) then
  begin
    NewSelected := FItems.FindButton(Sender as TfcCustomBitBtn);
    if (Sender as TfcCustombitBtn).Selected then
    begin
      FItems.ArrangeControls;
      UpdateBold(AutoBold);
      if FOldSelected <> NewSelected then DoChange(FOldSelected, NewSelected);
    end;
  end;
end;

procedure TfcCustomButtonGroup.DoChanging(OldSelected, Selected: TfcButtonGroupItem);
begin
  if Assigned(FOnChanging) then FOnChanging(self, OldSelected, Selected);
end;

procedure TfcCustomButtonGroup.DoChange(OldSelected, Selected: TfcButtonGroupItem);
begin
  if Assigned(FOnChange) then FOnChange(self, OldSelected, Selected);
end;

function TfcCustomButtonGroup.ResizeToControl(Control: TControl; DoResize: Boolean): TSize;
begin
  if FItems.Count = 0 then Exit;
  if Control = nil then Control := FItems[0].Button;
  if Control = nil then Exit;

  if Layout = loVertical then
  begin
    result.cx := ((Control.Width + ControlSpacing) * Columns);
    result.cy := (Control.Height + ControlSpacing) * Ceil(FItems.Count div Columns);
  end else begin
    result.cx := (Control.Width + ControlSpacing) * Ceil(FItems.Count div Columns);
    result.cy := ((Control.Height + ControlSpacing) * Columns);
  end;
  dec(result.cx, ControlSpacing);
  dec(result.cy, ControlSpacing);
  if DoResize then
  begin
    Width := result.cx;
    Height := result.cy;
  end;
end;

function TfcCustomButtonGroup.GetButtonClassName: string;
begin
  result := ButtonClass.ClassName;
end;

function TfcCustomButtonGroup.GetSelected: TfcButtonGroupItem;
var i: Integer;
begin
  result := nil;
  for i := 0 to FItems.Count - 1 do
    if FItems[i].Selected then
    begin
      result := FItems[i];
      break;
    end;
end;

procedure TfcCustomButtonGroup.SetButtonClass(Value: TfcCustomBitBtnClass);
begin
  if FButtonClass <> Value then
  begin
    FButtonClass := Value;
    if not (csLoading in ComponentState) then
    begin
      FItems.BeginUpdate;
      FItems.Clear;
      FItems.EndUpdate;
    end;
    if FItems.Designer <> nil then FItems.Designer.Update;
  end;
end;

procedure TfcCustomButtonGroup.SetButtonClassName(Value: string);
begin
  if (csLoading in ComponentState) or not (csDesigning in ComponentState) or
     (FItems.Count = 0) or
     ((FItems.Count > 0) and (MessageDlg('Setting this property will clear your items. Continue?',
     mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then
    ButtonClass := TfcCustomBitBtnClass(FindClass(Value));
end;

procedure TfcCustomButtonGroup.SetMaxControlSize(Value: Integer);
begin
  if FMaxControlSize <> Value then
  begin
    FMaxControlSize := Value;
    FItems.ArrangeControls;
  end;
end;

procedure TfcCustomButtonGroup.SetLastButtonRect(Value: TRect);
begin
  if not IsRectEmpty(FLastButtonRect) and (Parent <> nil) then
  begin
    OffsetRect(FLastButtonRect, Left, Top);
    InflateRect(FLastButtonRect, 3, 3);
    InvalidateRect(Parent.Handle, @FLastButtonRect, True);
  end;
  FLastButtonRect := Value;
end;

procedure TfcCustomButtonGroup.SetItems(Value: TfcButtonGroupItems);
begin
  FItems.Assign(Value);
end;

procedure TfcCustomButtonGroup.SetLayout(Value: TfcLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    if not (csLoading in ComponentState) then
      FItems.ArrangeControls;
  end;
end;

procedure TfcCustomButtonGroup.SetSelected(Value: TfcButtonGroupItem);
begin
  if Value <> nil then Value.Selected := True;
end;

function TfcCustomButtonGroup.GetButton(Name: string): TfcCustomBitBtn;
begin
            //8/5/99- PYW- Check the owner for the button control.
  result := Owner.FindComponent(Name) as TfcCustomBitBtn;
end;

procedure TfcCustomButtonGroup.SetAutoBold(Value: Boolean);
begin
  if FAutoBold <> Value then
  begin
    FAutoBold := Value;
    UpdateBold(True);
  end;
end;

procedure TfcCustomButtonGroup.SetClickStyle(Value: TfcButtonGroupClickStyle);
var i: Integer;
begin
  if FClickStyle <> Value then
  begin
    FClickStyle := Value;
    for i := 0 to FItems.Count - 1 do with FItems[i].Button do
    begin
      case FClickStyle of
        bcsCheckList: begin
          GroupIndex := i + 1;
          AllowAllUp := True;
        end;
        bcsRadioGroup: begin
          GroupIndex := 1;
          AllowAllUp := False;
        end;
        bcsClick: begin
          GroupIndex := 0;
          AllowAllUp := False;
        end;
      end;
    end;
//    if (Items.Count > 0) and (FClickStyle = bcsRadioGroup) then Items[0].Selected := True;
  end;
end;

procedure TfcCustomButtonGroup.SetControlSpacing(Value: Integer);
begin
  if FControlSpacing <> Value then
  begin
    FControlSpacing := Value;
    FItems.ArrangeControls;
  end;
end;

procedure TfcCustomButtonGroup.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
  begin
    if Value < 0 then Exit;
    FColumns := Value;
    if not (csLoading in ComponentState) then
      FItems.ArrangeControls;
  end;
end;

procedure TfcCustomButtonGroup.SetName(const NewName: TComponentName);
var i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    if (Copy(FItems[i].Button.Name, 1, Length(Name)) = Name) and (Name <> '') and (csDesigning in ComponentState) then
      FItems[i].Button.Name := NewName + fcSubstring(FItems[i].Button.Name, Length(Name) + 1, 0);
  end;
  inherited;
end;

function TfcCustomButtonGroup.GetChildOwner: TComponent;
begin
  result := inherited GetChildOwner;
end;

procedure TfcCustomButtonGroup.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if FItems.DeletingControl then Exit;
  if (not FItems.AddingControls) and (not FItems.ArrangingControls) and
     not (csLoading in ComponentState) then
    if (AControl <> nil) and (AControl is ButtonClass) then ResizeToControl(AControl, True);
  if (not FItems.ArrangingControls) and not FItems.DeletingControl and (AControl is TfcCustomBitBtn) then
    FItems.ArrangeControls;
end;

procedure TfcCustomButtonGroup.KeyDown(var Key: Word; Shift: TShiftState);
var NextIndex: Integer;
begin
  inherited;
  if Key in [VK_RIGHT, VK_DOWN, VK_LEFT, VK_UP, VK_HOME, VK_END] then
  begin
    NextIndex := 0;
    if Selected <> nil then
      case Key of
        VK_RIGHT, VK_DOWN: NextIndex := Selected.Index + 1;
        VK_LEFT, VK_UP: NextIndex := Selected.Index - 1;
        VK_HOME: NextIndex := 0;
        VK_END: NextIndex := FItems.Count - 1;
      end;
    if NextIndex < 0 then NextIndex := FItems.Count - 1
    else if NextIndex >= FItems.Count then NextIndex := 0;
    FItems[NextIndex].Selected := True;
  end;
end;

procedure TfcCustomButtonGroup.Loaded;
var i, j: Integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do if Controls[i] is TWinControl then
    if Controls[i] is ButtonClass then
      for j := 0 to FItems.Count - 1 do
        if FItems[j].Button = nil then
        begin
          FItems[j].FButton := Controls[i] as TfcCustomBitBtn;
          Break;
        end;

  FItems.ArrangingControls := False;
  for i := 0 to FItems.Count - 1 do FItems[i].Loaded;
end;

procedure TfcCustomButtonGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
end;

procedure TfcCustomButtonGroup.Paint;
var i: integer;
begin
  inherited;
  { 5/13/99 - RSW - When transparent, paint should also paint the button area }
  if IsTransparent then
     for i:= 0 to ButtonItems.Count-1 do
     begin
        ButtonItems[i].Button.invalidate;
     end;

  if (csDesigning in ComponentState) and
     (BorderStyle = bsNone) and (BevelInner = bvNone) and
     (BevelOuter = bvNone) and (FItems.Count = 0) then with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Style := psDash;
    if IsTransparent then Brush.Style := bsClear;
    Rectangle(0, 0, Width, Height);
  end;
end;

procedure TfcCustomButtonGroup.Resize;
begin
  inherited;
  if not (csDestroying in ComponentState) then FItems.ArrangeControls;
end;

procedure TfcCustomButtonGroup.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
//  Filer.DefineProperty('Item', nil, nil, True);
end;

procedure TfcCustomButtonGroup.WriteState(Writer: TWriter);
var i: Integer;
begin
  for i := FItems.Count - 1 downto 0 do SetChildOrder(FItems[i].Button, 0);
  inherited;
end;

Function TfcCustomButtonGroup.IsTransparent: boolean;
begin
   result:= (inherited IsTransparent)  and not (csDesigning in ComponentState);
end;

procedure TfcCustomButtonGroup.WndProc(var Message: TMessage);
begin
  inherited;
end;

initialization
  RegisterClasses([TfcShapeBtn, TfcImageBtn]);
end.
