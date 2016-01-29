{====================================================}
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

05/01/2002

  Fixed different problems in ElDBComboBox

*)

unit ElDBBoxes;

interface

uses
     DB,
     DBCtrls,

     HTMLLbx,

     Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
   {$ifdef VCL_6_USED}
     Types,
   {$endif}
     ElStrUtils,
   {$ifdef ELPACK_UNICODE}
     ElUnicodeStrings,
   {$endif}
     Classes,
     SysUtils,
     ElVCLUtils;

type

  TElDBListBox = class(TCustomElHTMLListBox)
  private
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    function GetReadOnly: Boolean;
    procedure SetItems(Value: TElFStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  protected
    procedure Click; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Items write SetItems;

    { Inherited properties }
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property TabWidth;
    property ItemIndex;
    property SelCount;
    property TopIndex;
    property ShowCheckBox;
    property UseXPThemes;

    property ActiveBorderType;
    property Background;
    property BorderSides;
    property Flat;
    property Ctl3D;
    property ParentCtl3D;
    property Font;
    property FlatFocusedScrollBars;
    property HighlightAlphaLevel;
    property HorizontalScroll;
    property Images;
    property AlphaForImages;
    property ImageForm;
    property InactiveBorderType;
    property InvertSelection;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property SelectedFont;
    property ShowLineHint;
    property Transparent;
    property TransparentSelection;
    property UseBackground;
    property UseSelectedFont;
    property TabStop;
    property ParentFont;

    property OnClick;
    property OnCheckStateChange;
    //@+ 2/5/03
    property OnCheckBoxChange;
    //@- 2/5/03
    {$IFDEF VCL_5_USED}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VCL_4_USED}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VCL_4_USED}
    property OnResize;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;


    property Align;
    {$IFDEF VCL_4_USED}
    property Anchors;
    property BiDiMode;
    {$ENDIF}
    property Color;
    {$IFDEF VCL_4_USED}
    property Constraints;
    {$ENDIF}
    property DragCursor;
    {$IFDEF VCL_4_USED}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    {$IFDEF VCL_4_USED}
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    {$ENDIF}
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property Style;
    property OnDrawItem;
    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  TElDBComboBox = class(TCustomElHTMLComboBox)
  private
    FDataLink: TFieldDataLink;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure EditingChange(Sender: TObject);
    procedure SetEditReadOnly;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message : TMessage); override;
    procedure Change; override;
    procedure SetItems(Value: TElFStrings);
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Items write SetItems;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    { Inherited properties }
    property OnLinkClick;
    property OnImageNeeded;
    property OnDrawItem;
    property OnMeasureItem;
    property IsHTML;
    property Style;
    property LinkColor;
    property LinkStyle;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property DropDownAlignment;

    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property Text;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
{$IFDEF VCL_4_USED}
    property OnEndDock;
{$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

implementation

function TElDBListBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBListBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBListBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBListBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBListBox.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDataLink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBListBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

constructor TElDBListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBListBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBListBox.Click;
begin
  if FDataLink.Edit then
  begin
    inherited Click;
    FDataLink.Modified;
  end;
end;

procedure TElDBListBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    ItemIndex := Items.IndexOf(FDataLink.Field.Text)
  else
    ItemIndex := -1;
end;

{$ifdef VCL_4_USED}
function TElDBListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBListBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
    if not FDataLink.Edit then Key := 0;
end;

procedure TElDBListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TElDBListBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{$ifdef ELPACK_UNICODE}
procedure TElDBListBox.SetItems(Value: TElWideStrings);
{$else}
procedure TElDBListBox.SetItems(Value: TStrings);
{$endif}
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBListBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{$ifdef VCL_4_USED}
function TElDBListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBListBox.UpdateData(Sender: TObject);
begin
  if ItemIndex >= 0 then
    FDataLink.Field.Text := Items[ItemIndex] else
    FDataLink.Field.Text := '';
end;

{$ifdef VCL_4_USED}
function TElDBListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBListBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FDataLink.Edit then inherited
  else
  begin
    SetFocus;
    with Message do
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  end;
end;

procedure TElDBListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Sorted', FakeBoolean, nil, false);
end;

constructor TElDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
end;

destructor TElDBComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBComboBox.Click;
begin
  if FDataLink.Edit then
  begin
    inherited Click;
    FDataLink.Modified;
  end;
end;

procedure TElDBComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBComboBox.DataChange(Sender: TObject);
begin
  if ((Style <> csSimple) or IsHTML) and FForm.Visible then
  else
  if FDataLink.Field <> nil then
  begin
    ItemIndex := Items.IndexOf(FDataLink.Field.Text);
    if (ItemIndex<0) and ( (Style = csDropDown) or IsHTML) then
      Text := FDataLink.Field.Text
  end
  else
    ItemIndex := -1;
end;

{$ifdef VCL_4_USED}
function TElDBComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBComboBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
    if not FDataLink.Edit then Key := 0;
end;

procedure TElDBComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TElDBComboBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBComboBox.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if (FDataLink.DataSource <> nil) and
     (not (csDestroying in FDatALink.DataSource.ComponentState)) then
    FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{$ifdef ELPACK_UNICODE}
procedure TElDBComboBox.SetItems(Value: TElWideStrings);
{$else}
procedure TElDBComboBox.SetItems(Value: TStrings);
{$endif}
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBComboBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{$ifdef VCL_4_USED}
function TElDBComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBComboBox.UpdateData(Sender: TObject);
begin
  if (Style in [csSimple, csDropDown]) and (not IsHTML) then
    FDataLink.Field.Text := Text
  else
  if ItemIndex >= 0 then
    FDataLink.Field.Text := Items[ItemIndex]
  else
    FDataLink.Field.Text := '';
end;

{$ifdef VCL_4_USED}
function TElDBComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBComboBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FDataLink.Edit then
    inherited
  else
  begin
    SetFocus;
    with Message do
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  end;
end;

procedure TElDBComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBComboBox.EditingChange(Sender: TObject);
begin
  SetEditReadOnly;
end;

procedure TElDBComboBox.SetEditReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    inherited ReadOnly := not FDataLink.Editing;
end;

procedure TElDBComboBox.CreateWnd;
begin
  inherited;
  if (Style in [csDropDown, csSimple]) and HandleAllocated and (not IsHTML) then
    inherited ReadOnly := not FDataLink.Editing;
end;

procedure TElDBComboBox.WndProc(var Message : TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
{
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
{}
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then FDataLink.Edit else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
    end;
  inherited;
end;

procedure TElDBComboBox.Change;
begin
  inherited;
  if FDataLink.Edit then
    FDataLink.Modified;
end;

procedure TElDBComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Sorted', FakeBoolean, nil, false);
end;

end.
