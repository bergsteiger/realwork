{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdbctl;

interface
{$I dc.inc}

uses
  dcconsts,dcsystem,Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, dcedit, grids, db, dbctrls, dbgrids,
  typinfo, comctrls,dcdreamlib {$IFDEF USEBDE},dbtables{$ENDIF}
  {$IFDEF D6} ,Variants {$ENDIF}
  ;

type
  TDCSimpleDBEdit = class(TDBEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key : Char); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property CharCase;
    property Color;
    property Font;
    property MaxLength;
    property OEMConvert;
  end;

  TFieldDataSource = class;

  TDataSourceLink = class(TDataLink)
  private
    fSource : TFieldDataSource;
  protected
    procedure RecordChanged(Field: TField); override;
  end;

  TFieldDataSource = class(TEditSource)
  private
    fDataLink : TFieldDataLink;
    fDataSourceLink : TDataSourceLink;

    procedure DataChange(Sender : TObject); virtual;
  protected
    procedure SetDataField(const val : string);
    function  GetDataField : string;

    procedure SetDataSource(val : TDataSource);
    function  GetDataSource : TDataSource;

    function GetValue : string; override;
    procedure SetValue(const val : string); override;

    procedure Notification(AComponent : TComponent;
                           Operation : TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
    procedure StartEdit; override;
  published
    property DataField  : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;

{------------------------------------------------------------------}

  TLookupFieldDataSource = class(TFieldDataSource)
  private
    fLookupLink  : TFieldDataLink;
    fKeyField    : string;
    fIsEmpty     : boolean;

    function  LookupMode : boolean;

    procedure DataChange(Sender : TObject); override;
  protected
    function  GetValue : string; override;
    procedure SetValue(const val : string); override;

    procedure SetLookupField (const val : string);
    function  GetLookupField : string;
    procedure SetLookupSource(val : TDataSource);
    function  GetLookupSource : TDataSource;
    procedure Notification(AComponent : TComponent;
                           Operation : TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  published
    property KeyField : string read fKeyField write fKeyField;
    property LookupField : string read GetLookupField write SetLookupField;
    property LookupSource : TDataSource read GetLookupSource write SetLookupSource;
  end;

  TPopupDBGrid = class(TCustomDBGrid)
  private
    fDisplayField : string;
    fMoveDisabled : boolean;
  protected
    function  GetFieldSource : TDataSource;
    procedure SetFieldSource(val : TDataSource);
    procedure SetDisplayField(const val : string);
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

    procedure GetText(var Msg : TMessage); message WM_GETTEXT;
    procedure SetText(var Msg : TMessage); message WM_SETTEXT;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
//    procedure WMVScroll(var Msg: TWMVScroll); message WM_VSCROLL;
    procedure MouseUp(Button: TMouseButton;
                      Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner : TComponent); override;
  published
    property FieldSource : TDataSource read GetFieldSource write SetFieldSource;
    property DisplayField : string read fDisplayField write SetDisplayField;
    property Columns stored {$IFNDEF D3}StoreColumns{$ELSE}false{$ENDIF};
  end;

  TCustomDCDBEdit = class(TCustomDCEdit)
  private
    procedure SetDataSource(Value : TDataSource);
    procedure SetDataField(Value : string);
    function GetDataSource : TDataSource;
    function GetDataField : string;
  protected
    procedure CheckReadOnly; override;
  public
    property DataField : string read GetDataField write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
  end;

  TDCDBEdit = class(TCustomDCDBEdit)
  public
    constructor Create(AOwner:TComponent); override;
  published
    property Align;
    {$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property BorderStyle;
    property Button1;
    property Button2;
    property Caption;
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property DreamBorderStyle;
    property Edit;
    property Enabled;
    property Flat;
    property Font;
    property LineColor;
    property NumButtons;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PopupWindow;
    property PopupWindowClass;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    //prooperty Text;
    property UseDreamBorder;
    property Visible;

    property OnButton1Click;
    property OnButton2Click;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$IFDEF D4}
    property OnEndDock;
    property OnStartDock;
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
    property OnStartDrag;
  end;

  TDCDBLookup = class(TCustomDCDBEdit)
  private
    procedure SetKeyField(Value : string);
    procedure SetLookupField(Value : string);
    procedure SetLookupSource(Value : TDataSource);
    //procedure SetPopupColumns(Value : TDBGridColumns );
    function  GetKeyField : string;
    function  GetLookupField : string;
    function  GetLookupSource : TDataSource;
    //function  GetPopupColumns : TDBGridColumns;
  protected
    function  GetDefaultPopupClass : TWinControlClass; override;
    procedure SetDropValue; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner:TComponent); override;
    //property PopupColumns : TDBGridColumns read GetPopupColumns write SetPopupColumns;
  published
    property KeyField : string read GetKeyField write SetKeyField;
    property LookupField : string read GetLookupField write SetLookupField;
    property LookupSource : TDataSource read GetLookupSource write SetLookupSource;
    property DropOnClick;
    property Align;
    {$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property BorderStyle;
    property Button1;
    property Button2;
    property Caption;
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property DreamBorderStyle;
    property Edit;
    property Enabled;
    property Flat;
    property Font;
    property HideCaret default true;
    property LineColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    // property Text;
    property UseDreamBorder;
    property Visible;

    property OnButton2Click;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$IFDEF D4}
    property OnEndDock;
    property OnStartDock;
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
    property OnStartDrag;
  end;

  {$IFDEF D3}
  TCustomDBDateEdit = class(TCustomDCEdit)
  private
    function  GetDataSource : TDataSource;
    function  GetDataField : string;
    procedure SetDataSource(val : TDataSource);
    procedure SetDataField(const val : string);
  protected
    function  GetDefaultEditorClass : TControlClass; override;
  public
    constructor Create(AOwner : TComponent); override;

    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property DataField  : string read GetDataField write SetDataField;
  end;

  TDCDBDateEdit = class (TCustomDBDateEdit)
  published
    property DataSource;
    property DataField;

    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property DreamBorderStyle;
    property Enabled;
    property Font;
    property LineColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property UseDreamBorder;
 end;
 {$ENDIF}

Procedure Register;

implementation

procedure TDataSourceLink.RecordChanged(Field: TField);
begin
  if fSource <> nil then
    fSource.DataChange(self);
end;

{------------------------------------------------------------------}

constructor TDCSimpleDBEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Ctl3D := false;
  BorderStyle := bsNone;
end;

{------------------------------------------------------------------}

procedure TDCSimpleDBEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style {or ES_MULTILINE }or WS_CLIPCHILDREN;
end;

{------------------------------------------------------------------}

procedure TDCSimpleDBEdit.KeyPress(var Key : Char);
begin
  if Key in [#10, #13] then
    Key := #0;

  inherited KeyPress(Key);
end;

{******************************************************************}

constructor TFieldDataSource.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  fDataSourceLink := TDataSourceLink.Create;
  fDataSourceLink.fSource := self;
  fDataLink := TFieldDataLink.Create;
  with fDataLink do
    begin
      {$IFDEF D3}
      Control := Self;
      {$ENDIF}
      OnDataChange := DataChange;
    end;
end;

{------------------------------------------------------------------}

destructor TFieldDataSource.Destroy;
begin
  FreeObject(fDataLink,fDataLink);
  fDataSourceLink.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.DataChange(Sender : TObject);
begin
  if {Assigned(fDataLink.Field) and} Assigned(Owner) then
    TDCEdit(Owner).Text := GetValue;
end;

{------------------------------------------------------------------}

function TFieldDataSource.GetDataField : string;
begin
  Result := fDataLink.FieldName;
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.SetDataField(const val : string);
begin
  fDataLink.FieldName := val;
end;

{------------------------------------------------------------------}

function TFieldDataSource.GetDataSource : TDataSource;
begin
  Result := fDataLink.DataSource;
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.SetDataSource(val : TDataSource);
begin
  fDataLink.DataSource := val;
  fDataSourceLink.DataSource := val;
  if val <> nil then
    val.FreeNotification(Self);
end;

{------------------------------------------------------------------}

function TFieldDataSource.GetValue : string;
var
  f : TField;
begin
  if Assigned(DataSource) and Assigned(DataSource.DataSet) then
    f := DataSource.DataSet.FindField(DataField)
  else
    f := nil;

  if Assigned(f) then
    result := f.DisplayText
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.SetValue(const val : string);
begin
  with FDataLink do
    if (Field <> nil) and (Field.Text <> val) then
      if Edit then
        Field.Text := val;
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.StartEdit;
begin
  fDataLink.Edit;
end;

{------------------------------------------------------------------}

procedure TFieldDataSource.Notification(AComponent : TComponent;
                                        Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (fDataLink <> nil) and (AComponent = DataSource) then
    DataSource := nil;
end;

{******************************************************************}

constructor TLookupFieldDataSource.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  fLookupLink := TFieldDataLink.Create;
  with fLookupLink do
    begin
      {$IFDEF D3}
      Control := Self;
      {$ENDIF}
      OnActiveChange := DataChange;
    end;
end;

{------------------------------------------------------------------}

destructor TLookupFieldDataSource.Destroy;
begin
  FreeObject(fLookupLink,fLookupLink);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TLookupFieldDataSource.Notification(AComponent : TComponent;
                                        Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (fLookupLink <> nil) and (AComponent = LookupSource) then
     LookupSource := nil;
end;

{------------------------------------------------------------------}

procedure TLookupFieldDataSource.SetLookupField(const val : string);
begin
  fLookupLink.FieldName := val;
  if Assigned(Owner) and not (csReading in ComponentState) then
    TDCEdit(Owner).Text := GetValue;
end;

{------------------------------------------------------------------}

procedure TLookupFieldDataSource.DataChange(Sender : TObject);
var
  fVal : variant;
begin
  if (fDataLink.Field <> nil) and LookupMode then
    try
      fVal := fDataLink.Field.Value;
      fIsEmpty := true;
      if not VarIsNull(fVal) then
        fIsEmpty := not FLookupLink.DataSet.Locate(fKeyField, fVal, []);
    except
    end;

  inherited;
end;

{------------------------------------------------------------------}

function  TLookupFieldDataSource.GetLookupField : string;
begin
  Result := fLookupLink.FieldName;
end;

{------------------------------------------------------------------}

procedure TLookupFieldDataSource.SetLookupSource(val : TDataSource);
begin
  fLookupLink.DataSource := val;
  if val <> nil then
    val.FreeNotification(Self);

  if Assigned(Owner) and not (csReading in ComponentState) then
    TDCEdit(Owner).Text := GetValue;
end;

{------------------------------------------------------------------}

function TLookupFieldDataSource.GetLookupSource : TDataSource;
begin
  Result := fLookupLink.DataSource;
end;

{------------------------------------------------------------------}

function TLookupFieldDataSource.LookupMode : boolean;
begin
  result := Assigned(fLookupLink.Field) and Assigned(LookupSource) and
            Assigned(LookupSource.DataSet) and LookupSource.DataSet.active;
end;

{------------------------------------------------------------------}

function TLookupFieldDataSource.GetValue : string;
begin
  result := '';
  if fIsEmpty then
    exit;
    
  if LookupMode then
    begin
      result := fLookupLink.Field.DisplayText;
    end
  else
    if Assigned(fDataLink) and Assigned(fDataLink.Field) then
      result := fDataLink.Field.Text;
end;

{------------------------------------------------------------------}

procedure TLookupFieldDataSource.SetValue(const val : string);
var
  lval : Variant;
  inlookup : boolean;
begin
  inlookup := LookupMode;

  if inlookup then
    lval := fLookupLink.DataSet.FieldByName(KeyField).Value;

  if fDataLink.Edit then
    if inlookup then
      fDataLink.Field.Value := lval
    else
      if Assigned(fDataLink) and assigned(fDataLink.Field) then
        fDataLink.Field.Text := val;
end;

{******************************************************************}

constructor TPopupDBGrid.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  visible := false;
  Options := [dgAlwaysShowSelection];
  BorderStyle := bsSingle;
  ReadOnly := true;
  DefaultRowHeight := TDCEdit(Owner).ClientHeight - 3;
end;

{------------------------------------------------------------------}

function TPopupDBGrid.GetFieldSource : TDataSource;
begin
  result := inherited DataSource;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.SetFieldSource(val : TDataSource);
begin
  inherited DataSource := val;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.GetText(var Msg : TMessage);
begin
  with Msg do
    StrPCopy(pchar(LParam), GetFieldValue(0));
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      Style := WS_CHILD or WS_BORDER or WS_VSCROLL;
      ExStyle := WS_EX_TOPMOST or WS_EX_TOOLWINDOW;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    end;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.MouseUp(Button: TMouseButton;
                               Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
    TDCEdit(Owner).CloseDropped(PtInRect(ClientRect, Point(X, Y)));
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.WMLButtonDown(var Message: TWMLButtonDown);
var
  Item : TGridCoord;
begin
  if fMoveDisabled then
    exit;
    
  if DataLink.Active then
    with Message do
      begin
        Item := MouseCoord(XPos, YPos);
        DataLink.DataSet.MoveBy(Item.Y - Row);
      end;

  inherited;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.WMMouseMove(var Message: TWMMouseMove);
var
  Item    : TGridCoord;
  pt      : TPoint;
  delta   : integer;
begin
  if fMoveDisabled then
    exit;

  with Message do
    if ((word(GetAsyncKeyState(VK_LBUTTON)) and $8000) <> 0) and DataLink.Active then
      begin
        pt := SmallPointToPoint(Message.Pos);
        Item := MouseCoord(XPos, YPos);
        delta := 0;
        if Item.Y <> -1 then
          delta := Item.Y - Row
        else
          if pt.Y > ClientHeight then
            delta := 1
          else
            if pt.Y < 0 then
              delta := -1;

          DataLink.DataSet.MoveBy(delta);
      end;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key in [VK_RETURN, VK_ESCAPE]) and (Shift = []) then
    begin
      TDCEdit(Owner).CloseDropped(key <> VK_ESCAPE);
      key := 0;
      exit;
    end;

  if not fMoveDisabled then
    inherited KeyDown(Key, Shift)
  else
    key := 0;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.SetDisplayField(const val : string);
begin
  fDisplayField := val;
  Columns.Clear;
  Columns.Add.FieldName := val;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.SetText(var Msg : TMessage);
Var
  I     : Integer;
  Field : TField;
begin
  width := TDCEdit(Owner).Width;
  Columns[0].width := ClientWidth;
  i := RowCount;
  if i > 7 then
    i := 7;

  if i < 1 then
    i := 1;

  ClientHeight := DefaultRowHeight * i;

  try
    If ( DataSource <> Nil ) And ( DataSource.DataSet <> Nil ) Then
    begin
      Field := GetColField(0);
      If Field <> Nil Then
        DataSource.DataSet.Locate( Field.FieldName, String( pChar( Msg.lParam ) ), [] );
    end;
  except
  end;
end;

{------------------------------------------------------------------}

procedure TPopupDBGrid.WMVScroll(var Message: TWMVScroll);
{$IFDEF D3}
var
  SI: TScrollInfo;
{$ENDIF}
begin
  if not fMoveDisabled and Datalink.Active then
    with Message, DataLink.DataSet do
      case ScrollCode of
        SB_LINEUP: MoveBy(-Datalink.ActiveRecord - 1);
        SB_LINEDOWN: MoveBy(Datalink.RecordCount - Datalink.ActiveRecord);
        SB_PAGEUP: MoveBy(-VisibleRowCount);
        SB_PAGEDOWN: MoveBy(VisibleRowCount);
        SB_THUMBPOSITION:
          begin
            {$IFDEF D3}
            if IsSequenced then
            begin
              SI.cbSize := sizeof(SI);
              SI.fMask := SIF_ALL;
              GetScrollInfo(Self.Handle, SB_VERT, SI);
              if SI.nTrackPos <= 1 then First
              else if SI.nTrackPos >= RecordCount then Last
              else RecNo := SI.nTrackPos;
            end
            else
            {$ENDIF}
              case Pos of
                0: First;
                1: MoveBy(-VisibleRowCount);
                2: Exit;
                3: MoveBy(VisibleRowCount);
                4: Last;
              end;
          end;
        SB_BOTTOM: Last;
        SB_TOP: First;
      end;
end;

{******************************************************************}

{$IFDEF D3}
constructor TCustomDBDateEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  EditSourceClass := 'TFieldDataSource'; //don't resource
  NumButtons := 0;
end;

{------------------------------------------------------------------}

function  TCustomDBDateEdit.GetDataSource : TDataSource;
begin
  result := TFieldDataSource(EditSource).DataSource;
end;

{------------------------------------------------------------------}

function  TCustomDBDateEdit.GetDataField : string;
begin
  result := TFieldDataSource(EditSource).DataField;
end;

{------------------------------------------------------------------}

procedure TCustomDBDateEdit.SetDataSource(val : TDataSource);
begin
  TFieldDataSource(EditSource).DataSource := val;
end;

{------------------------------------------------------------------}

procedure TCustomDBDateEdit.SetDataField(const val : string);
begin
  TFieldDataSource(EditSource).DataField := val;
end;

{------------------------------------------------------------------}

function  TCustomDBDateEdit.GetDefaultEditorClass : TControlClass;
begin
  result := TDCDateEdit;
end;
{$ENDIF}

{----------TCustomDCDBEdit----------------------------------}

procedure TCustomDCDBEdit.CheckReadOnly;
begin
  inherited;
  if EditSource is TFieldDataSource then
    with TFieldDataSource(EditSource) do
      fDataSourceLink.ReadOnly := ReadOnly;
end;

{-----------------------------------------------------------}

procedure TCustomDCDBEdit.SetDataSource(Value : TDataSource);
begin
  if EditSource is TFieldDataSource then
    TFieldDataSource(EditSource).DataSource := Value;
end;

{-----------------------------------------------------------}

procedure TCustomDCDBEdit.SetDataField(Value : string);
begin
  if EditSource is TFieldDataSource then
    TFieldDataSource(EditSource).DataField := Value;
end;

{-----------------------------------------------------------}

function TCustomDCDBEdit.GetDataSource : TDataSource;
begin
  if EditSource is TFieldDataSource then
    result := TFieldDataSource(EditSource).DataSource
  else
    result := nil;
end;

{-----------------------------------------------------------}

function TCustomDCDBEdit.GetDataField : string;
begin
  if EditSource is TFieldDataSource then
    result := TFieldDataSource(EditSource).DataField
  else
    result := '';
end;

{-----------TDCDBEdit----------------------------------------}

constructor TDCDBEdit.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  EditSourceClass := 'TFieldDataSource'; //don't resource
  Button1.Visible := false;
end;


{-----------TDCDBLookup---------------------------------------}

constructor TDCDBLookup.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  EditSourceClass := 'TLookupFieldDataSource'; //don't resource
  HideCaret := true;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.Loaded;
begin
  inherited;
//  Text := EditSource.Value;
end;

{-----------------------------------------------------------}

function  TDCDBLookup.GetDefaultPopupClass : TWinControlClass;
begin
  result := TPopupDBGrid;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.SetDropValue;
begin
  inherited;
  TPopupDBGrid(PopupWindow).fMoveDisabled := ReadOnly;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.SetKeyField(Value : string);
begin
  if EditSource is TLookupFieldDataSource then
    TLookupFieldDataSource(EditSource).KeyField := Value;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.SetLookupField(Value : string);
begin
  if EditSource is TLookupFieldDataSource then
    TLookupFieldDataSource(EditSource).LookupField := Value;
  if PopupWindow is TPopupDBGrid then
    TPopupDBGrid(PopupWindow).DisplayField := LookupField;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.SetLookupSource(Value : TDataSource);
begin
  if EditSource is TLookupFieldDataSource then
    TLookupFieldDataSource(EditSource).LookupSource := Value;
  if PopupWindow is TPopupDBGrid then
    TPopupDBGrid(PopupWindow).FieldSource  := LookupSource;
end;

{-----------------------------------------------------------}

function TDCDBLookup.GetKeyField : string;
begin
  if EditSource is TLookupFieldDataSource then
    result := TLookupFieldDataSource(EditSource).KeyField
  else
    result := '';
end;

{-----------------------------------------------------------}

function TDCDBLookup.GetLookupField : string;
begin
  if EditSource is TLookupFieldDataSource then
    result := TLookupFieldDataSource(EditSource).LookupField
  else
    result := '';
end;

{-----------------------------------------------------------}

function TDCDBLookup.GetLookupSource : TDataSource;
begin
  if EditSource is TLookupFieldDataSource then
    result := TLookupFieldDataSource(EditSource).LookupSource
  else
    result := nil;
end;

{-----------------------------------------------------------}
(*
function  TDCDBLookup.GetPopupColumns : TDBGridColumns;
begin
  if PopupWindow is TPopupDBGrid then
    result := TPopupDBGrid(PopupWindow).Columns
  else
    result := nil;
end;

{-----------------------------------------------------------}

procedure TDCDBLookup.SetPopupColumns (Value: TDBGridColumns);
begin
  if PopupWindow is TPopupDBGrid then
    TPopupDBGrid(PopupWindow).Columns := Value;
end;
*)

Procedure Register;
Begin
  RegisterComponents(SPalDreamEdit, [TDCDBEdit, TDCDBLookup]);
End;

initialization
  RegisterPopupClass(TypeInfo(string),nil,'aaaaaaaa',TPopupDBGrid);
  RegisterEditSource(TFieldDataSource);
  RegisterEditSource(TLookupFieldDataSource);
  RegisterTextEditClass(TypeInfo(TField), nil, '', TDCSimpleDBEdit);
end.
