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

04/17/2003
 fixed painted UTF8
 fixed edited with ReadOnly=True
 fixed calculate unicode text width

03/19/2003

 fixed painting of TElWideDBLookupListBox when ListField contains one field
 fixed comparision of variants

08/11/2002

  TElWideDBLookupListBox - now works via virtual list. Works only for Style in [lbVirtual, lbVirtualOwnerDraw]
  Delphi 6/7 only.
*)

{$IFDEF MSWINDOWS}
  {$IFDEF VCL_6_USED}
    //comment: TElListBoxStrings didn't support virtual items
    // {$define _VIRTUAL_LIST_SUPPORTED_} // not supported in CLX and less then Delphi 6
  {$ENDIF VCL_6_USED}
{$ENDIF MSWINDOWS}

unit ElDBWideLookupControls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF VCL_6_USED}
  Variants,
  {$ENDIF}
  StdCtrls,
  db,
  dbctrls,
  ElListBox,
  ElCombos,
  ElDBConst,
  ElStrUtils,
  {$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
  {$ENDIF}
  ElVCLUtils;

{$IFDEF ELPACK_UNICODE}

type
  TElWideDBLookupListBox = class;
  TElWideDBLookupComboBox = class;

  { TElWideDBLookupListControl }
  TElWideDBLookupListControl = class(TDBLookupControl)
  private
    { Private declarations }
    FElDBWideLookupListBox: TElWideDBLookupListBox;
    FUpdate: Boolean;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    fOLDListState :TDataSetState;
  protected
    { Protected declarations }
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure UpdateBuffer;
    procedure SelectCurrent;
    procedure Select(Value: Integer);
    procedure UpdateData(Sender: TObject);
    procedure ListLinkDataChanged; override;
  public
    { Public declarations }
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
  published
    { Published declarations }
  end;

  { TElWideDBLookUpComboControl }
  TElWideDBLookUpComboControl = class(TDBLookupControl)
  private
    { Private declarations }
    FElDBWideLookupComboBox: TElWideDBLookupComboBox;
    FSavedOnUpdateDataEvent: TNotifyEvent;
    FUpdate: Boolean;
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure KeyValueChanged; override;
    procedure UpdateListFields; override;
    procedure SelectCurrent;
    function Select(Value: Integer):Boolean;
    procedure UpdateData(Sender: TObject);
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
  public
    { Public declarations }
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode
        default umFieldType;
  published
    { Published declarations }
  end;

  TOwnerDrawState =
    {$IFNDEF VCL_5_USED}StdCtrls{$ELSE}Windows{$ENDIF}.TOwnerDrawState;

  { TElWideDBLookupListBox }
  TElWideDBLookupListBox = class(TCustomElListBox)
  private
    { Private declarations }
    FOnChange : TNotifyEvent;
    FElDBWideLookupControl: TElWideDBLookupListControl;
    FReadOnly: Boolean;
    FFieldCount: integer;
    FFieldWidth: array of integer;
    procedure SetDataSource(Value: TDataSource);
    procedure SetListSource(Value: TDataSource);
    procedure SetDataFieldName(const Value: string);
    procedure SetListFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldIndex(Value: integer);
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: WideString;
    function GetSelected(Index: Integer): Boolean;
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure SetHorizontalExtent; override;
    procedure DrawItem(Index: Integer; R: TRect; State: TOwnerDrawState); override;
    procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; const ACaption: TElFString;
      var Rect: TRect; Flags: LongInt); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetFieldCount(Value: integer);
    procedure ClearFields;
    function GetStyle:TListBoxStyle;
    procedure SetStyle(Value:TListBoxStyle);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    procedure DefineProperties(Filer: TFiler); override;
    property Selected[Index: Integer]: Boolean read GetSelected;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: WideString read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Items;
    property ItemIndex;
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property Style:TListBoxStyle read GetStyle write SetStyle stored false;// emulate as read Only for reading from old dfm resource
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
    property HideSelection default False;
    // inherited properties:
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property TabWidth;
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
    property OnDrawItem;
    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  { TElWideDBLookupComboBox }
  TElWideDBLookupComboBox = class(TCustomElComboBox)
  private
    { Private declarations }
    FElDBWideLookupControl: TElWideDBLookUpComboControl;
    FFieldCount: integer;
    FFields: array of TElFStrings;
    FKeyIndex :Integer;
    FFieldWidth: array of integer;
    fNeedUpdate:Boolean;
    fSaveItemIndex :Integer;
    fListFieldNames :String;
    FReadOnly :Boolean;
    procedure SetDataSource(Value: TDataSource);
    procedure SetListSource(Value: TDataSource);
    procedure SetDataFieldName(const Value: string);
    procedure SetListFieldName(const Value: string);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldIndex(Value: integer);
    procedure SetSelected(index: integer; Value: Boolean);
    procedure SetHScrollBarWidth;
    function GetSelected(index: integer): Boolean;
    function GetField: TField;
    function GetListFieldIndex: integer;
    function GetDataSource: TDataSource;
    function GetListSource: TDataSource;
    function GetListFieldName: string;
    function GetDataFieldName: string;
    function GetKeyFieldName: string;
    function GetKeyValue: Variant;
    function GetSelectedString: WideString;
    function GetFields(Index: integer): TElFStrings;
    function GetStyle:TComboBoxStyle;
    function GetMultiSelectLookup:Boolean;
    procedure SetMultiSelectLookup(const Value:Boolean);
  protected
    { Protected declarations }
    FUnicodeMode: TElDBUnicodeMode;
    procedure SetFieldCount(Value: integer);
    procedure ClearFields;
    procedure AddItem(const Value: TElFString; Field: integer);
    procedure DoDropDown; override;
    procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMKeyDown( var Message: TWMKeyDown ); message WM_KEYDOWN;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    procedure SetStyle(Value:TComboBoxStyle); {$IFDEF VCL_5_USED}reintroduce;{$ENDIF}
    procedure SetUnicodeMode(Value: TElDBUnicodeMode);
    procedure PaintText(Canvas : TCanvas); override;
    procedure DefineProperties(Filer: TFiler); override;
    property Fields[Index: Integer]:TElFStrings read GetFields;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DropDown; override;
    procedure CloseUp(AcceptValue: boolean); override;
    procedure UpdateData;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    procedure DoDrawText(Sender : TObject; ACanvas: TCanvas; Index: integer; var Rect: TRect;
      Flags: LongInt);
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
    property SelectedItem: WideString read GetSelectedString;
    property ListFieldIndex: integer read GetListFieldIndex write SetListFieldIndex;
    property Field: TField read GetField;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property Items;
    property ItemIndex;
  published
    { Published declarations }
    property Style:TComboBoxStyle read GetStyle write SetStyle default csDropDown;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property DataField: string read GetDataFieldName write SetDataFieldName;
    property ListField: string read GetListFieldName write SetListFieldName;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write SetUnicodeMode
      default umFieldType;
    property MultiSelect:Boolean read GetMultiSelectLookup write SetMultiSelectLookup
      default True;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    // inherited properties:
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
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property OnDrawItem;
    property OnMeasureItem;
    property DropDownAlignment;
    property ShowGripper;

    {< ELSCROLLBAR}
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;
    property RightAlignedView;
    {> ELSCROLLBAR}

    property OnSelect;
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
    property IncrementalSearchTimeout;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;
    property OnKeyPressEx;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
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
    property AutoSelect default true;

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
    property ButtonOldStyled;
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
    property AltButtonOldStyled;
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

{$ENDIF ELPACK_UNICODE}

implementation

{$B-}

{$IFDEF ELPACK_UNICODE}

function VarEquals(const V1, V2: Variant): Boolean;
begin
  try
    if ( VarIsNull(V1) and (not VarIsNull(V2)) ) or
       ( (not VarIsNull(V1)) and VarIsNull(V2) )
    then
      Result := False
    else
      Result := VarToStr(V1) = VarToStr(V2);
  except
    Result := False;
  end;
end;

function Canvas_TextWidthW(Canvas:TCanvas; const Text:WideString; uFormat: UINT):Integer;
{$IFDEF ELPACK_UNICODE}
  var R:Trect;
{$ENDIF}
begin
  {$IFDEF ELPACK_UNICODE}
  R := Rect(0,0,0,0);
  if ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), R,
    {uFormat or} DT_CALCRECT) <> 0 then
    Result := R.Right - R.Left +1
  else
  {$ENDIF}
    Result := Canvas.TextWidth(Text);
end;

{ TElWideDBLookupListControl }

procedure TElWideDBLookupListControl.KeyValueChanged;
var
  vItemIndex: Integer;
begin
  vItemIndex := FElDBWideLookupListBox.ItemIndex;
  inherited KeyValueChanged;
  if ListLink.Active then
  begin
    try
      if VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue) then
        ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
    except
      ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
    end;
    if VarToStr(ListLink.DataSet.FieldValues[KeyField])=VarToStr(KeyValue) then
    begin
      if Field = nil then
      begin
        FElDBWideLookupListBox.ItemIndex := ListLink.ActiveRecord;
        if Assigned(FElDBWideLookupListBox.OnChange) then
          FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
      end
      else
        SelectCurrent;
    end
    else
    begin
      FElDBWideLookupListBox.ItemIndex := -1;
      if Assigned(FElDBWideLookupListBox.OnChange) then
        FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
      if vItemIndex <> FElDBWideLookupListBox.ItemIndex then
        FElDBWideLookupListBox.Invalidate;
    end;
  end;
end;

procedure TElWideDBLookupListControl.UpdateData( Sender: TObject);
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then
    FSavedOnUpdateDataEvent(Sender);
  FUpdate := True;
  UpdateListFields;
end;

procedure TElWideDBLookupListControl.UpdateBuffer;
var
  i, RecCount, FieldCount: integer;
  // variables for calculate items text width:
  FListField: TField;
  j, ActiveRec, vFieldWidth: integer;
  W : WideString;
begin
  if (
       not(
          Assigned(ListSource.DataSet) and
          Assigned(ListSource.DataSet.FindField(KeyField))
       )
     ) or (ListFields.Count=0)
  then
  begin
    {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
    if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin
      if FElDBWideLookupListBox.Count >0 then
        FElDBWideLookupListBox.Count := 0; //!!!
    end
    else
    {$ENDIF}
    begin
      if FElDBWideLookupListBox.Items.Count>0 then
        FElDBWideLookupListBox.Items.Clear;
    end;
    FElDBWideLookupListBox.ItemIndex := -1;
    ListLink.BufferCount := 0;
    exit;
  end;
  ListLink.BufferCount := ListSource.DataSet.RecordCount;
  RecCount := ListLink.RecordCount;
  FieldCount := ListFields.Count;
  FElDBWideLookupListBox.SetFieldCount( FieldCount );
  {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
  if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    begin
        if FElDBWideLookupListBox.Count <> RecCount then
          FElDBWideLookupListBox.Count := RecCount; //!!!
    end
  else     {$ENDIF}
  begin
    if FElDBWideLookupListBox.Items.Count<>RecCount then
    begin
      FElDBWideLookupListBox.Items.BeginUpdate;
      try
        if FElDBWideLookupListBox.Items.Count>RecCount then
        begin
           i := (FElDBWideLookupListBox.Items.Count-RecCount);            if i=FElDBWideLookupListBox.Items.Count then
             FElDBWideLookupListBox.Items.Clear
           else
           if (i/100*(RecCount)) > 25 then            begin
             FElDBWideLookupListBox.Items.Clear;
             for i:= 1 to RecCount do
               FElDBWideLookupListBox.Items.Add('');
           end
           else
             for i:= 1 to i do
               FElDBWideLookupListBox.Items.Delete(FElDBWideLookupListBox.Items.Count-1)
        end
        else
        for i:= 1 to RecCount-FElDBWideLookupListBox.Items.Count do
          FElDBWideLookupListBox.Items.Add('');
      finally
        FElDBWideLookupListBox.Items.EndUpdate;
      end;
    end;
  end;
  // update items text width ->
  ListLink.DataSet.DisableControls;
  ActiveRec := ListLink.ActiveRecord;
  for i := 0 to FieldCount-1 do
      FElDBWideLookupListBox.FFieldWidth[i] := 0;
  i:=0;
  repeat
    ListLink.ActiveRecord := i;
    for j := 0 to FieldCount-1 do
    begin
      FListField := TField(ListFields.Items[j]);
      if FListField.IsNULL then
        W := ''
      else
      if (FElDBWideLookupListBox.UnicodeMode = umForceUTF8) and
         (ConvertUTF8toUTF16(FListField.DisplayText, W, strictConversion, false) <> sourceIllegal)
      then
      else
      begin
        if (FListField.DataType = ftWideString) then
          W := FListField.Value
        else
          W := FListField.DisplayText;
      end;
     // set ListBox items width (calc max width):
      vFieldWidth := Canvas_TextWidthW(FElDBWideLookupListBox.Canvas, W, 0);
      if vFieldWidth > FElDBWideLookupListBox.FFieldWidth[j] then
        FElDBWideLookupListBox.FFieldWidth[j] := vFieldWidth;
    end;
    inc(i);
  until i>=RecCount;
  // restore data state:
  ListLink.ActiveRecord := ActiveRec;
  ListLink.DataSet.EnableControls;
  for i := 0 to FieldCount-1 do
    inc(FElDBWideLookupListBox.FFieldWidth[i], 7);
  // update horizontal scrollbar:
  if FElDBWideLookupListBox.HorizontalScroll then
    FElDBWideLookupListBox.SetHorizontalExtent;
  // <- update items text width
  if FElDBWideLookupListBox.ItemIndex <> ListLink.ActiveRecord then
    KeyValueChanged;
end;

procedure TElWideDBLookupListControl.UpdateListFields;
begin
  try
    inherited UpdateListFields;
  except
    begin
      FElDBWideLookupListBox.Update;
      UpdateBuffer;
      FElDBWideLookupListBox.Updated;
      FUpdate := false;
      if csDesigning in FElDBWideLookupListBox.ComponentState then
        raise
      else
        exit;
    end;
  end;
  FElDBWideLookupListBox.Update;
  try
    if ListLink.Active and ( (KeyField<>'') or
      ( (Field<>nil) and (Field.FieldKind=fkLookup) ))
    then
    begin
      fOLDListState := ListLink.DataSet.State;
      UpdateBuffer;
    end
    else
    begin
      fOLDListState := dsInactive;
      if FElDBWideLookupListBox.Items.Count>0 then
      begin
        {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
        if FElDBWideLookupListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
          FElDBWideLookupListBox.Count := 0
        else
        {$ENDIF}
          FElDBWideLookupListBox.Items.Clear;
        FElDBWideLookupListBox.ItemIndex := -1;
        ListLink.BufferCount := 0;
      end;
    end;
  finally
    FElDBWideLookupListBox.Updated;
    FUpdate := false;
  end;
end;

procedure TElWideDBLookupListControl.ListLinkDataChanged;
begin
  if (not FUpdate)
      and
     (
       (ListLink.DataSet.State <> dsBrowse) or
       (ListLink.BufferCount <> ListLink.DataSet.RecordCount) or
       ( (fOLDListState = dsInsert) and (ListLink.DataSet.State = dsBrowse) )
     )
  then
  begin
    if (ListLink.DataSet.State = dsInsert) then//Insert not post
    begin
       {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Count := FElDBWideLookupListBox.Count +1;
       {$ELSE}
       FElDBWideLookupListBox.Items.BeginUpdate;
       FElDBWideLookupListBox.Items.Add('');
       {$ENDIF}
       ListLink.BufferCount := ListLink.BufferCount+1;
       {$IFNDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Items.EndUpdate;
       {$ENDIF}
    end
    else
    if (fOLDListState = dsInsert) and // Cancel
       (ListLink.BufferCount <> ListLink.DataSet.RecordCount)
    then
    begin
       {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Count := FElDBWideLookupListBox.Count -1;
       {$ELSE}
       FElDBWideLookupListBox.Items.BeginUpdate;
       FElDBWideLookupListBox.Items.Delete(FElDBWideLookupListBox.Items.Count-1);
       {$ENDIF}
       ListLink.BufferCount := ListLink.BufferCount-1;
       {$IFNDEF _VIRTUAL_LIST_SUPPORTED_}
       FElDBWideLookupListBox.Items.EndUpdate;
       {$ENDIF}
    end
    else
    begin
      if (ListLink.BufferCount <> ListLink.DataSet.RecordCount) then
        UpdateBuffer;
      FElDBWideLookupListBox.Invalidate;
    end;
  end;
  fOLDListState := ListLink.DataSet.State;
end;

procedure TElWideDBLookupListControl.SelectCurrent;
var
  CurRec: integer;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    CurRec := ListLink.ActiveRecord;
    if FElDBWideLookupListBox.ItemIndex <> CurRec then
    begin
      FElDBWideLookupListBox.ItemIndex := CurRec;
      FElDBWideLookupListBox.Invalidate;
      if Assigned(FElDBWideLookupListBox.OnChange) then
        FElDBWideLookupListBox.OnChange(FElDBWideLookupListBox);
    end;
  end
  else
    FElDBWideLookupListBox.ItemIndex := -1;
end;

procedure TElWideDBLookupListControl.Select(Value: Integer);
begin
  if (Value>=0) and ListLink.Active and (ListLink.ActiveRecord <> Value) then
  begin
    ListLink.ActiveRecord := Value;
    SelectKeyValue(ListSource.DataSet.FieldValues[KeyField]);
  end;
end;

function TElWideDBLookupListControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataSource<>nil) and
    (DataSource.ExecuteAction(Action));
end;

function TElWideDBLookupListControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataSource<>nil)
    and (DataSource.UpdateAction(Action));
end;

{ TElWideDBLookupComboControl }

procedure TElWideDBLookupComboControl.KeyValueChanged;
var
  vItemIndex: Integer;
begin
  vItemIndex := FElDBWideLookupComboBox.ItemIndex;
  inherited KeyValueChanged;
  if ListLink.Active then
  begin
    try
      if (ListLink.ActiveRecord>=0) and
         (
          (VarToStr(ListLink.DataSet.FieldValues[KeyField]) <> VarToStr(KeyValue))
          or           (VarToStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToStr(KeyValue))
         )
      then
      begin
        ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
        if (VarToStr(FElDBWideLookupComboBox.Fields[0][ListLink.ActiveRecord])<>VarToStr(KeyValue))
           and
           (not FUpdate)
        then         begin
          FUpdate := true;
          UpdateListFields;
          ListLink.DataSet.Locate( KeyField, KeyValue, [loCaseInsensitive] );
        end;
      end
      else
        ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
    except
      ListLink.DataSet.Locate(KeyField, KeyValue, [loCaseInsensitive]);
    end;
    if (VarToStr(ListLink.DataSet.FieldValues[KeyField]) = VarToStr(KeyValue)) then
    begin
      if Field = nil then
      begin
        FElDBWideLookupComboBox.ItemIndex := ListLink.ActiveRecord;
        FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
        if Assigned(FElDBWideLookupComboBox.OnChange) then
          FElDBWideLookupComboBox.OnChange(FElDBWideLookupComboBox);
      end
      else
         SelectCurrent;
      if (not ReadOnly) and (FElDBWideLookupComboBox.Text <>
        FElDBWideLookupComboBox.Items[FElDBWideLookupComboBox.ItemIndex])
      then
        FElDBWideLookupComboBox.Text :=
          FElDBWideLookupComboBox.Items[FElDBWideLookupComboBox.ItemIndex];
    end
    else
    begin
      FElDBWideLookupComboBox.ItemIndex := -1;
      if Assigned(FElDBWideLookupComboBox.OnChange) then
        FElDBWideLookupComboBox.OnChange(FElDBWideLookupComboBox);
      if vItemIndex <> FElDBWideLookupComboBox.ItemIndex then
        FElDBWideLookupComboBox.Invalidate;
    end;
  end;
end;

procedure TElWideDBLookupComboControl.UpdateData( Sender: TObject );
begin
  if FUpdate then
    exit;
  if Assigned(FSavedOnUpdateDataEvent) then
    FSavedOnUpdateDataEvent(Sender);
  if (ListLink.DataSet.FieldValues[KeyField]=KeyValue) then
  begin
    if FElDBWideLookupComboBox.ItemIndex = -1 then
    begin
      FUpdate := true;
      UpdateListFields
    end
  end
  else
    FElDBWideLookupComboBox.fNeedUpdate := True;
end;

procedure TElWideDBLookupComboControl.UpdateListFields;
var
  FListField: TField;
  i, j, RecCount, ActiveRec, FieldCount, vFieldWidth: integer;
  W : WideString;
begin
  FElDBWideLookupComboBox.fNeedUpdate := False;
  inherited UpdateListFields;
  FElDBWideLookupComboBox.ClearFields;
  if ListLink.Active and( (KeyField<>'') or
    ( (Field<>nil) and (Field.FieldKind=fkLookup) )) then
  begin
    ListLink.BufferCount := ListSource.DataSet.RecordCount;
    ListLink.DataSet.DisableControls;
    ActiveRec := ListLink.ActiveRecord;
    RecCount := ListLink.RecordCount;
    FieldCount := ListFields.Count;
    FElDBWideLookupComboBox.SetFieldCount( FieldCount );
    // Search KeyField index
    FElDBWideLookupComboBox.FKeyIndex := -1;
    if KeyField<>'' then
      for i:=0 to ListFields.Count-1 do
      begin
        if CompareText(TField(ListFields[i]).FieldName, KeyField)=0 then
          FElDBWideLookupComboBox.FKeyIndex := i;
      end;
    // set ListBox items width (clear):
    for j := 0 to FieldCount-1 do
      FElDBWideLookupComboBox.FFieldWidth[j] := 0;
    i:=0;
    repeat
      ListLink.ActiveRecord := i;
      for j := 0 to FieldCount-1 do
      begin
        FListField := TField(ListFields.Items[j]);
        if FListField.IsNULL then
          W := ''
        else
        if (UnicodeMode = umForceUTF8) and
           (ConvertUTF8toUTF16(FListField.DisplayText, W, strictConversion, false) <> sourceIllegal)
        then
        else
        begin
          if (FListField.DataType = ftWideString) then
            W := FListField.Value
          else
            W := FListField.DisplayText;
        end;
        FElDBWideLookupComboBox.AddItem(W, j);
       // set ListBox items width (calc max width):
        vFieldWidth := Canvas_TextWidthW(FElDBWideLookupComboBox.FListBox.Canvas, W, 0);
        if vFieldWidth > FElDBWideLookupComboBox.FFieldWidth[j] then
          FElDBWideLookupComboBox.FFieldWidth[j] := vFieldWidth;
      end;
      inc(i);
    until i>=RecCount;
    // set ListBox items width (correct max width):
    for j := 0 to FieldCount-1 do
      inc(FElDBWideLookupComboBox.FFieldWidth[j], 7);
    // Hiden undefined KeyField in ListField:
    if (FElDBWideLookupComboBox.FFieldCount > 1 ) and
      (FElDBWideLookupComboBox.fListFieldNames <> ListField) then
      FElDBWideLookupComboBox.FFieldWidth[FElDBWideLookupComboBox.FFieldCount-1] := 0;
    // set scrollbar width:
    FElDBWideLookupComboBox.SetHScrollBarWidth;
    // restore data state:
    ListLink.ActiveRecord := ActiveRec;
    ListLink.DataSet.EnableControls;
    // check ItemIndex:
    if (FElDBWideLookupComboBox.ItemIndex <> ListLink.ActiveRecord)
       or
       (VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue))
    then
    begin
      FElDBWideLookupComboBox.ItemIndex := ListLink.ActiveRecord;
      FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
      if VarToStr(ListLink.DataSet.FieldValues[KeyField])<>VarToStr(KeyValue) then
        FElDBWideLookupComboBox.ItemIndex := -1;
      // ???
      if Assigned(FElDBWideLookupComboBox.OnChange) then
        FElDBWideLookupComboBox.OnChange(FElDBWideLookupComboBox);
    end;
  end;
  FUpdate := false;
end;

procedure TElWideDBLookupComboControl.SelectCurrent;
var
  i, RecCount, CurRec, index: integer;
  FKeyField: TField;
  bSelected:Boolean;
begin
  if ListLink.Active and (Field<>nil) then
  begin
    i := 0;
    CurRec := ListLink.ActiveRecord;
    RecCount := ListLink.RecordCount;
    FKeyField := GetFieldProperty(ListLink.DataSet, Self, KeyField);
    index := -1;
    if FElDBWideLookupComboBox.FListBox.MultiSelect then
    begin
      ListLink.DataSet.DisableControls;
      repeat
        ListLink.ActiveRecord := i;
        bSelected := VarEquals(FKeyField.Value, KeyValue);
        if (index<0)and(bSelected) then
          index := i;
        FElDBWideLookupComboBox.Selected[i] := bSelected;
        inc(i);
      until (i>=RecCount);
      ListLink.ActiveRecord := CurRec;
      ListSource.DataSet.EnableControls;
    end
    else
    if VarEquals(FKeyField.Value, Field.Value) then
      index := CurRec;
    if FElDBWideLookupComboBox.ItemIndex <> index then
    begin
      FElDBWideLookupComboBox.ItemIndex := index;
      if FElDBWideLookupComboBox.FListBox.MultiSelect then
        FElDBWideLookupComboBox.Selected[FElDBWideLookupComboBox.ItemIndex] := True;
      if Assigned(FElDBWideLookupComboBox.OnChange) then
        FElDBWideLookupComboBox.OnChange(FElDBWideLookupComboBox);
    end;
    if (index<0) and (not VarEquals(FKeyField.Value, KeyValue)) then
      FElDBWideLookupComboBox.ItemIndex := -1;
    if (FElDBWideLookupComboBox.ItemIndex = -1) and
      (FElDBWideLookupComboBox.Items.Count>0) and
      FElDBWideLookupComboBox.FListBox.MultiSelect
    then
      FElDBWideLookupComboBox.Selected[0] := False;
  end;
end;

function TElWideDBLookupComboControl.Select(Value: Integer):Boolean;
var
  DataSet: TDataSet;
begin
  if ListLink.Active then
  begin
    DataSet := ListSource.DataSet;
    Result := (Value>=0) and (DataSet.RecordCount>0) and (FElDBWideLookupComboBox.FKeyIndex>=0) and
      DataSet.Locate(
        TField(ListFields.Items[FElDBWideLookupComboBox.FKeyIndex]).DisplayName,
        FElDBWideLookupComboBox.Fields[FElDBWideLookupComboBox.FKeyIndex][Value],
        []);
    if Result then
      SelectKeyValue(DataSet.FieldValues[KeyField]);
  end
  else
    Result := True;
end;

function TElWideDBLookupComboControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataSource<>nil)
    and (DataSource.ExecuteAction(Action));
end;

function TElWideDBLookupComboControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataSource<>nil)
    and (DataSource.UpdateAction(Action));
end;

procedure TElWideDBLookUpComboControl.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    if HandleAllocated and Visible then
      Invalidate;
  end;
end;

{ TElWideDBLookupListBox }

constructor TElWideDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MultiSelect := true;
  FElDBWideLookupControl := TElWideDBLookupListControl.Create(Self);
  FElDBWideLookupControl.FElDBWideLookupListBox := Self;
  FReadOnly := false;
  FFieldCount := 0;
  {$IFDEF _VIRTUAL_LIST_SUPPORTED_}
    inherited Style := lbVirtualOwnerDraw;
  {$ENDIF}
  HideSelection := False;
end;

destructor TElWideDBLookupListBox.Destroy;
begin
  FElDBWideLookupControl.FElDBWideLookupListBox := nil;
  FElDBWideLookupControl.free;
  FElDBWideLookupControl := nil;
  SetLength(FFieldWidth, 0);
  inherited Destroy;
end;

procedure TElWideDBLookupListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  if CompareText(ClassName, TElWideDBLookupListBox.ClassName)=0 then
  with GetElReader do
    FakeDefineProperty(Filer);
end;

function TElWideDBLookupListBox.GetStyle:TListBoxStyle;
begin
  Result := inherited Style;
end;

procedure TElWideDBLookupListBox.SetStyle(Value:TListBoxStyle);
begin
end;

procedure TElWideDBLookupListBox.SetDataSource(Value: TDataSource);
begin
  FElDBWideLookupControl.DataSource := Value;
end;

procedure TElWideDBLookupListBox.SetListSource(Value: TDataSource);
begin
  if FElDBWideLookupControl.ListSource <> Value then
  begin
    if FElDBWideLookupControl.ListSource <> nil then
    begin
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.FSavedOnUpdateDataEvent;
      FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
    end;
    FElDBWideLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FElDBWideLookupControl.ListSource.OnUpdateData) then
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := FElDBWideLookupControl.ListSource.OnUpdateData
      else
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.UpdateData
    end;
  end;
end;

procedure TElWideDBLookupListBox.SetDataFieldName(const Value: string);
begin
  FElDBWideLookupControl.DataField := Value;
end;

procedure TElWideDBLookupListBox.SetListFieldName(const Value: string);
begin
  FElDBWideLookupControl.ListField := Value;
end;

procedure TElWideDBLookupListBox.SetKeyFieldName(const Value: string);
begin
  FElDBWideLookupControl.KeyField := Value;
end;

function TElWideDBLookupListBox.GetDataSource: TDataSource;
begin
  Result := FElDBWideLookupControl.DataSource;
end;

function TElWideDBLookupListBox.GetListSource: TDataSource;
begin
  Result := FElDBWideLookupControl.ListSource;
end;

function TElWideDBLookupListBox.GetListFieldName: string;
begin
  Result := FElDBWideLookupControl.ListField;
end;

function TElWideDBLookupListBox.GetDataFieldName: string;
begin
  Result := FElDBWideLookupControl.DataField;
end;

function TElWideDBLookupListBox.GetKeyFieldName: string;
begin
  Result := FElDBWideLookupControl.KeyField;
end;

procedure TElWideDBLookupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft)and (not FReadOnly) then
    FElDBWideLookupControl.Select(ItemAtPos(Point(X, Y),true));
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TElWideDBLookupListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  idx: integer;
begin
  if not Focused then
    Windows.SetFocus(Handle);
  if FReadOnly then
    exit;
  idx := ItemIndex;
  MouseDown(mbLeft, [], Message.XPos, Message.YPos);
  if ( idx<>ItemIndex ) and Assigned( FOnChange ) then
    FOnChange( Self );
end;

procedure TElWideDBLookupListBox.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
end;

procedure TElWideDBLookupListBox.SetKeyValue(const Value: Variant);
begin
  FElDBWideLookupControl.KeyValue := Value;
end;

function TElWideDBLookupListBox.GetKeyValue: Variant;
begin
  Result := FElDBWideLookupControl.KeyValue;
end;

function TElWideDBLookupListBox.GetSelectedString: WideString;
var
  i, ActiveRec: integer;
  FKeyField :TField;
begin
  Result := '';
  if Items.Count=0 then
    exit;
  FKeyField := FElDBWideLookupControl.ListLink.DataSet.FindField(FElDBWideLookupControl.KeyField);
  if FKeyField= nil then
    exit;
  ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
  for i := 0 to Items.Count-1 do
    if Selected[i] then
    begin
      FElDBWideLookupControl.ListLink.ActiveRecord := i;
      Result := Result + FKeyField.AsString + ';';
    end;
  FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  if Result <> '' then
    SetLength( Result, length( Result )-1 );
end;

procedure TElWideDBLookupListBox.SetListFieldIndex(Value: integer);
begin
  FElDBWideLookupControl.ListFieldIndex := Value;
end;

function TElWideDBLookupListBox.GetListFieldIndex: integer;
begin
  Result := FElDBWideLookupControl.ListFieldIndex;
end;

function TElWideDBLookupListBox.GetField: TField;
begin
  Result := FElDBWideLookupControl.Field;
end;

function TElWideDBLookupListBox.ExecuteAction(Action: TBasicAction): boolean;
begin
  Result := inherited ExecuteAction(Action) and FElDBWideLookupControl.ExecuteAction(Action);
end;

function TElWideDBLookupListBox.UpdateAction(Action: TBasicAction): boolean;
begin
  Result := inherited UpdateAction(Action) and FElDBWideLookupControl.UpdateAction(Action);
end;

procedure TElWideDBLookupListBox.WMKeyDown( var Message: TWMKeyDown );
begin
  if not FElDBWideLookupControl.FUpdate then
    case Message.CharCode of
      VK_DOWN:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex<Items.Count-1 then
          begin
            FElDBWideLookupControl.Select( ItemIndex+1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_UP:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
          begin
            FElDBWideLookupControl.Select( ItemIndex-1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_HOME:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
            begin
              FElDBWideLookupControl.Select( 0 );
            end;
        end;
      VK_END:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( ItemIndex < Items.Count-1 ) then
            begin
              FElDBWideLookupControl.Select( Items.Count-1 );
            end;
        end;
      VK_PRIOR,VK_NEXT:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( (Message.CharCode = VK_PRIOR) and ( ItemIndex >0 ) )
             or
             ( (Message.CharCode = VK_NEXT) and ( ItemIndex < Items.Count-1 ) )
          then
            begin
              inherited;
              FElDBWideLookupControl.Select( ItemIndex );
            end;
        end;
      VK_ESCAPE:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if Assigned(DataSource) and
             Assigned(DataSource.DataSet) and
             DataSource.DataSet.Active and
             ( DataSource.DataSet.State in [dsEdit, dsInsert] )
          then
            begin
              DataSource.DataSet.Cancel;
              //???
              if Assigned( FOnChange ) then
                FOnChange( self );
            end;
        end;
      else
        inherited;
    end
  else
    inherited;
end;

procedure TElWideDBLookupListBox.WMPaint(var Message: TWMPaint);
var
  ActiveRec:integer;
begin
  if not HandleAllocated then
    exit;
  if Assigned(FElDBWideLookupControl.ListLink.DataSet) and
     FElDBWideLookupControl.ListLink.DataSet.Active and
     Assigned(DataSource) and Assigned(DataSource.DataSet) and DataSource.DataSet.Active
  then
  begin
      ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
      inherited;
      FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  end
  else
    inherited;
end;

function TElWideDBLookupListBox.GetSelected(Index: Integer): Boolean;
var
  ActiveRec:Integer;
  FKeyField:TField;
begin
  Items[Index];//check range overflow
  Result := False;
  FKeyField := GetFieldProperty( FElDBWideLookupControl.ListLink.DataSet, Self, KeyField );
  if FKeyField=nil then
    exit;
  ActiveRec := FElDBWideLookupControl.ListLink.ActiveRecord;
  FElDBWideLookupControl.ListLink.DataSet.DisableControls;
  try
    FElDBWideLookupControl.ListLink.ActiveRecord := Index;
    Result := FKeyField.Value = Field.Value;
    FElDBWideLookupControl.ListLink.ActiveRecord := ActiveRec;
  finally
    FElDBWideLookupControl.ListLink.DataSet.EnableControls;
  end;
end;

procedure TElWideDBLookupListBox.DoDrawText(Sender : TObject; ACanvas: TCanvas;
  const ACaption: TElFString; var Rect: TRect; Flags: LongInt);
var
  i, TextHeight: integer;
  R: TRect;
  S: WideString;
begin
  TextHeight:= Canvas.TextHeight( '0' );
  R := Rect;
  inc(R.Left, 5);
  for i := 1 to FFieldCount do
  begin
    with TField(FElDBWideLookupControl.ListFields.Items[i-1]) do
    begin
      if isNull then
        S := ''
      else
      begin
        if (UnicodeMode = umForceUTF8) and
           (ConvertUTF8toUTF16(DisplayText, S, strictConversion, false) <> sourceIllegal)
        then
        else
        begin
          if DataType = ftWideString then
            S := Value
          else
            S := DisplayText;
        end;
      end;
    end;
    inherited DoDrawText(Sender, ACanvas, S, R, Flags );
    R.Left := R.Left + FFieldWidth[i-1];
    if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
      ACanvas.Pen.Color := clBtnFace
    else
      ACanvas.Pen.Color := clBtnShadow;

    if i<FFieldCount then
    begin
      if i>0 then
        ACanvas.MoveTo(R.Left-3, R.Top-3)
      else
        ACanvas.MoveTo(R.Left-3, R.Top);
      if i<FFieldCount then
        ACanvas.LineTo(R.Left-3, R.Top + TextHeight+3)
      else
        ACanvas.LineTo(R.Left-3, R.Top + TextHeight);
    end;
    inc(R.Left, 7);
  end;
end;

procedure TElWideDBLookupListBox.DrawItem(Index: Integer; R: TRect; State:TOwnerDrawState);
begin
 if Index>FElDBWideLookupControl.ListLink.BufferCount then
   exit;
  FElDBWideLookupControl.ListLink.ActiveRecord := Index;
  // Check Selected
  if Assigned(DataSource) and Assigned(DataSource.DataSet) and
     Assigned(DataSource.DataSet.FindField(DataField)) and
     (not VarIsNull(KeyValue)) and
     Assigned(ListSource.DataSet) and
     Assigned(ListSource.DataSet.FindField(KeyField)) and
     VarEquals( ListSource.DataSet.FindField(KeyField).Value, KeyValue)
  then
  // is selected
  begin
   System.Include(State, odSelected);
   Canvas.Font.Color  := SelectedFont.Color;
   Canvas.Brush.Color := FocusedSelectColor;
  end
  else
  begin
   System.Exclude(State, odSelected);
   Canvas.Font.Color  := Font.Color;
   Canvas.Brush.Color := Color;
  end;
  //comment: findex := index;
  inherited DrawItem(Index, R, State);
end;

procedure TElWideDBLookupListBox.SetHorizontalExtent;
var
  j: integer;
begin
  FMaxWidth := 0;
  for j := 0 to FFieldCount-1 do
    inc(FMaxWidth, FFieldWidth[j] + 7);
  inherited;
end;

procedure TElWideDBLookupListBox.SetFieldCount(Value: integer);
begin
  if Value>FFieldCount then
  begin
    SetLength(FFieldWidth, Value);
    inc(FFieldCount);
    FFieldCount := Value;
  end
  else
  if Value<FFieldCount then
  begin
    SetLength(FFieldWidth, Value);
    FFieldCount := Value;
  end;
end;

procedure TElWideDBLookupListBox.ClearFields;
begin
  Items.Clear;
end;

{ TElWideDBLookupComboBox }

constructor TElWideDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FElDBWideLookupControl := TElWideDBLookUpComboControl.Create(Self);
  FElDBWideLookupControl.FElDBWideLookupComboBox := Self;
  FListBox.OnDrawText := DoDrawText;
  FListBox.MultiSelect:= True;
  FFieldCount := 0;
  FHasCaret := False; //???
  inherited Style := csDropDown;
end;

destructor TElWideDBLookupComboBox.Destroy;
var
  i: integer;
begin
  FElDBWideLookupControl.FElDBWideLookupComboBox := nil;
  FElDBWideLookupControl.free;
  FElDBWideLookupControl := nil;
  SetLength(FFieldWidth, 0);
  for i := 1 to FFieldCount do
    FFields[i-1].Free;
  SetLength(FFields, 0);
  inherited Destroy;
end;

procedure TElWideDBLookupComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  if CompareText(ClassName, TElWideDBLookupComboBox.ClassName)=0 then
  with GetElReader do
    FakeDefineProperty(Filer);
end;

function TElWideDBLookupComboBox.GetMultiSelectLookup:Boolean;
begin
  Result := FListBox.MultiSelect;
end;


procedure TElWideDBLookupComboBox.SetMultiSelectLookup(const Value:Boolean);
begin
  FListBox.MultiSelect := Value;
end;

function TElWideDBLookupComboBox.GetStyle:TComboBoxStyle;
begin
  Result := inherited Style;
end;

procedure TElWideDBLookupComboBox.SetStyle(Value:TComboBoxStyle);
begin
  if Value<>csDropDown then
  begin
     if (csDesigning in ComponentState) and
        (not (csReading in ComponentState) )
     then
       raise exception.Create('TElWideDBLookupComboBox support only "csDropDown" mode');
  end
  else
    inherited Style := Value;
end;

procedure TElWideDBLookupComboBox.UpdateData;
begin
  FElDBWideLookupControl.FUpdate := true;
  FElDBWideLookupControl.UpdateListFields;
end;

procedure TElWideDBLookupComboBox.SetDataSource(Value: TDataSource);
begin
  FElDBWideLookupControl.DataSource := Value;
end;

procedure TElWideDBLookupComboBox.SetListSource(Value: TDataSource);
begin
  if FElDBWideLookupControl.ListSource <> Value then
  begin
    if FElDBWideLookupControl.ListSource <> nil then
    begin
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.FSavedOnUpdateDataEvent;
      FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
    end;
    FElDBWideLookupControl.ListSource := Value;
    if Value <> nil then
    begin
      if Assigned(FElDBWideLookupControl.ListSource.OnUpdateData) then
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := FElDBWideLookupControl.ListSource.OnUpdateData
      else
        FElDBWideLookupControl.FSavedOnUpdateDataEvent := nil;
      FElDBWideLookupControl.ListSource.OnUpdateData := FElDBWideLookupControl.UpdateData;
    end;
  end;
end;

procedure TElWideDBLookupComboBox.SetDataFieldName(const Value: string);
begin
  FElDBWideLookupControl.DataField := Value;
end;

procedure TElWideDBLookupComboBox.SetListFieldName(const Value: string);
begin
  fListFieldNames := Value;
  if Trim(KeyField)<>'' then
  begin
    if pos(';'+LowerCase(KeyField)+';', ';'+LowerCase(Value)+';')=0 then
    begin
      if Trim(Value)<>'' then
        FElDBWideLookupControl.ListField := Value+';'+KeyField
      else
        FElDBWideLookupControl.ListField := KeyField;
    end;
  end
  else
  begin
    FElDBWideLookupControl.ListField := Value;
  end;
end;

procedure TElWideDBLookupComboBox.SetKeyFieldName(const Value: string);
begin
  FElDBWideLookupControl.KeyField := Value;
  SetListFieldName(fListFieldNames);
end;

function TElWideDBLookupComboBox.GetDataSource: TDataSource;
begin
  Result := FElDBWideLookupControl.DataSource;
end;

function TElWideDBLookupComboBox.GetListSource: TDataSource;
begin
  Result := FElDBWideLookupControl.ListSource;
end;

function TElWideDBLookupComboBox.GetListFieldName: string;
begin
  Result := fListFieldNames;
end;

function TElWideDBLookupComboBox.GetDataFieldName: string;
begin
  Result := FElDBWideLookupControl.DataField;
end;

function TElWideDBLookupComboBox.GetKeyFieldName: string;
begin
  Result := FElDBWideLookupControl.KeyField;
end;

procedure TElWideDBLookupComboBox.SetKeyValue(const Value: Variant);
begin
  FElDBWideLookupControl.KeyValue := Value;
end;

function TElWideDBLookupComboBox.GetKeyValue: Variant;
begin
  Result := FElDBWideLookupControl.KeyValue;
end;

function TElWideDBLookupComboBox.GetSelectedString: WideString;
var
  i: integer;
begin
  Result := '';
  for i:=0 to Items.Count-1 do
    if FListBox.Selected[i] then Result := Result+Items.Strings[i]+';';
  if Result <> '' then SetLength(Result, length(Result)-1);
end;

procedure TElWideDBLookupComboBox.SetListFieldIndex(Value: integer);
begin
  FElDBWideLookupControl.ListFieldIndex := Value;
end;

function TElWideDBLookupComboBox.GetListFieldIndex: integer;
begin
  Result := FElDBWideLookupControl.ListFieldIndex;
end;

function TElWideDBLookupComboBox.GetField: TField;
begin
  Result := FElDBWideLookupControl.Field;
end;

function TElWideDBLookupComboBox.ExecuteAction(Action: TBasicAction): boolean;
begin
  Result := inherited ExecuteAction(Action) and FElDBWideLookupControl.ExecuteAction(Action);
end;

function TElWideDBLookupComboBox.UpdateAction(Action: TBasicAction): boolean;
begin
  Result := inherited UpdateAction(Action) and FElDBWideLookupControl.UpdateAction(Action);
end;

function TElWideDBLookupComboBox.GetSelected(index: integer): Boolean;
begin
  if FListBox.MultiSelect then
    Result := FListBox.Selected[index]
  else
    Result := index = ItemIndex;
end;

procedure TElWideDBLookupComboBox.SetSelected(index: integer; Value: Boolean);
begin
  if FListBox.MultiSelect then
    FListBox.Selected[index] := Value
  else
  begin
   if Value then
     FListBox.ItemIndex := index
   else
    if FListBox.ItemIndex = index then
      FListBox.ItemIndex := -1;
  end;
end;

procedure TElWideDBLookupComboBox.DropDown;
begin
  fSaveItemIndex := ItemIndex;
  if FListBox.MultiSelect then
    TElWideDBLookUpComboControl(FElDBWideLookupControl).SelectCurrent;
  inherited;
  if fSaveItemIndex>=0 then
    FListBox.TopIndex := fSaveItemIndex;
end;

procedure TElWideDBLookupComboBox.CloseUp(AcceptValue: boolean);
begin
  inherited;
  if (fSaveItemIndex <> ItemIndex) then
  begin
    if (AcceptValue) and (not ReadOnly) and FElDBWideLookupControl.Select(ItemIndex) then
    begin
      if Assigned(OnChange) then
        OnChange(self);
    end
    else
    begin
      if FListBox.MultiSelect and (ItemIndex>=0) and (ItemIndex<Items.Count) then
        Selected[ItemIndex] := False;
      ItemIndex := fSaveItemIndex;
      if FListBox.MultiSelect and (ItemIndex>=0) and (ItemIndex<Items.Count) then
        Selected[ItemIndex] := True;
    end;
  end;
  {$IFDEF MSWINDOWS}
  HideCaret(Handle);
  {$ENDIF}
end;

procedure TElWideDBLookupComboBox.WMMouseWheel( var Message: TWMMouseWheel );
var
  idx: integer;
begin
  if (not DroppedDown) or ReadOnly then
    exit;
  idx := ItemIndex;
  inherited;
  FListBox.Invalidate;
  if idx <> ItemIndex then
  begin
    if ReadOnly then
    begin
      ItemIndex := idx;
      exit;
    end;
    FElDBWideLookupControl.Select( ItemIndex );
    if Assigned( OnChange ) then
      OnChange( Self );
  end;
end;

procedure TElWideDBLookupComboBox.WMKeyDown( var Message: TWMKeyDown );
begin
  if (not DroppedDown) and (not FElDBWideLookupControl.FUpdate) then
    case Message.CharCode of
      VK_DOWN:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex<Items.Count-1 then
          begin
            FElDBWideLookupControl.Select( ItemIndex+1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_UP:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
          begin
            FElDBWideLookupControl.Select( ItemIndex-1 );
            if Assigned( FOnChange ) then
              FOnChange( self );
          end;
        end;
      VK_HOME:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ItemIndex>0 then
            begin
              FElDBWideLookupControl.Select( 0 );
            end;
        end;
      VK_END:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( ItemIndex < Items.Count-1 ) then
            begin
              FElDBWideLookupControl.Select( Items.Count-1 );
            end;
        end;
      VK_PRIOR,VK_NEXT:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if ( (Message.CharCode = VK_PRIOR) and ( ItemIndex >0 ) )
             or
             ( (Message.CharCode = VK_NEXT) and ( ItemIndex < Items.Count-1 ) )
          then
            begin
              Items.BeginUpdate;
                inherited;
                FElDBWideLookupControl.Select( ItemIndex );
              Items.EndUpdate;
            end;
        end;
      VK_ESCAPE:
        begin
          if ReadOnly then
          begin
            Message.CharCode := 0;
            exit;
          end;
          if Assigned(DataSource) and
             Assigned(DataSource.DataSet) and
             DataSource.DataSet.Active and
             ( DataSource.DataSet.State in [dsEdit, dsInsert] )
          then
            begin
              DataSource.DataSet.Cancel;
              if Assigned( FOnChange ) then
                FOnChange( self );
            end;
        end;
      else
        inherited;
    end
  else
  begin
    if ReadOnly then
      Message.CharCode := 0;
    inherited;
  end;
end;

procedure TElWideDBLookupComboBox.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  HideCaret(Handle);
end;

procedure TElWideDBLookupComboBox.PaintText(Canvas : TCanvas);
  procedure DoDrawText2(Sender : TObject; ACanvas: TCanvas; Index: integer;
      var Rect: TRect; Flags: LongInt);
  var
    i, TextHeight: integer;
    S: WideString;
    vFieldCount :Integer;
  begin
    if (index>=0) and (index<Items.Count) then
    begin
      vFieldCount := FFieldCount;
      if FFieldWidth[vFieldCount-1] = 0 then
        dec(vFieldCount);
    end
    else
      vFieldCount := 0;
    TextHeight:= Canvas.TextHeight( '0' );
    for i := 1 to vFieldCount do
    begin
      S := FFields[i-1].Strings[index];
      if S<>'' then
      begin
        SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
        DrawTextW(ACanvas.Handle, PWideChar(S), Length(S), Rect, Flags);
        inc(Rect.Left, Canvas_TextWidthW(ACanvas, S, Flags ) + 5);
      end
      else
        inc(Rect.Left, 5);
      if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
        ACanvas.Pen.Color := clBtnFace
      else
        ACanvas.Pen.Color := clBtnShadow;
      if i<vFieldCount then
      begin
        ACanvas.MoveTo(Rect.Left, Rect.Top);
        ACanvas.LineTo(Rect.Left, Rect.Top + TextHeight+3);
      end;
      inc(Rect.Left, 5);
    end;
  end;
var
  R: TRect;
  Flags :longint;
begin
    R := EditRect;
    InflateRect(R, -1,-1);
    dec(R.Right, 1);
    {$IFDEF VCL_5_USED}
    if Assigned(OnDrawItem) then
    begin
      if not Focused then
      begin
        Canvas.Brush.Color := Color;
        Canvas.Font.Color := Font.Color;
      end
      else
      begin
        Canvas.Brush.Color := FocusedSelectColor;
        Canvas.Font.Color := FocusedSelectTextColor;
      end;
      FCanvas := Canvas;
      DrawItem(FItemIndex, R, [odComboBoxEdit]);
    end
    else
    {$ENDIF}
    begin
      Flags := DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX;
      if RightAlignedText then
        Flags := Flags or DT_RTLREADING;
      if Focused then
      begin
        if (HighlightAlphaLevel < 255) then
          AlphaFillRect(Canvas, R, FocusedSelectColor, HighlightAlphaLevel)
        else
        begin
          Canvas.Brush.Color := FocusedSelectColor;
          Canvas.FillRect(R);
        end;
        Canvas.Brush.Color := clBtnFace;
        Canvas.Pen.Color := clWindowFrame;
        DrawFocusRect(Canvas.Handle, R);
        Canvas.Font.Color := FocusedSelectTextColor;
      end;
      inc(R.Left, 4);
      DoDrawText2(Self, Canvas, ItemIndex, R, Flags);
    end;
end;

procedure TElWideDBLookupComboBox.DoDrawText(Sender : TObject; ACanvas: TCanvas; Index: integer;
    var Rect: TRect; Flags: LongInt);
var
  i, TextHeight, vFieldCount: integer;
  S: WideString;
begin
  if (index>=0) and (index<Items.Count) then
  begin
    vFieldCount := FFieldCount;
    if FFieldWidth[vFieldCount-1] = 0 then
      dec(vFieldCount);
  end
  else
    vFieldCount := 0;
  TextHeight:= ACanvas.TextHeight( '0' );
  for i := 1 to vFieldCount do
  begin
    inc(Rect.Left, 7);
    S := FFields[i-1].Strings[index];
    SetBkMode(ACanvas.Handle, Windows.TRANSPARENT);
    DrawTextW(ACanvas.Handle, PWideChar(S), Length(S), Rect, Flags);
    Rect.Left := Rect.Left + FFieldWidth[i-1];
    if ColorToRGB(Color) <> ColorToRGB(clBtnFace) then
      ACanvas.Pen.Color := clBtnFace
    else
      ACanvas.Pen.Color := clBtnShadow;
    if i<vFieldCount then
    begin
      if i>0 then
        ACanvas.MoveTo(Rect.Left-3, Rect.Top-3)
      else
        ACanvas.MoveTo(Rect.Left-3, Rect.Top);
      if i<vFieldCount then
        ACanvas.LineTo(Rect.Left-3, Rect.Top + TextHeight+3)
      else
        ACanvas.LineTo(Rect.Left-3, Rect.Top + TextHeight);
    end;
  end;
end;

function TElWideDBLookupComboBox.GetFields(Index: integer): TElFStrings;
begin
  if (Index>=0) and (Index<FFieldCount) then
    Result := FFields[Index]
  else
    // ??? todo: raise exception index out of bounds ...
    Result := nil;
end;

procedure TElWideDBLookupComboBox.SetFieldCount(Value: integer);
var
  i: integer;
begin
  if Value>FFieldCount then
  begin
    SetLength(FFields, Value);
    SetLength(FFieldWidth, Value);
    inc(FFieldCount);
    for i := FFieldCount to Value do
      FFields[i-1] := TElWideStringList.Create;
    FFieldCount := Value;
  end
  else
    if Value<FFieldCount then
    begin
      for i := Value+1 to FFieldCount do
        FFields[i-1].Free;
      SetLength(FFields, Value);
      SetLength(FFieldWidth, Value);
      FFieldCount := Value;
    end;
end;

procedure TElWideDBLookupComboBox.ClearFields;
var
  i: integer;
begin
  Items.Clear;
  for i:= 1 to FFieldCount do
    FFields[i-1].Clear;
end;

procedure TElWideDBLookupComboBox.AddItem(const Value: TElFString; Field: integer);
begin
  Fields[Field].Add(Value);
  if Field=0 then
    Items.Add(Value);
end;

procedure TElWideDBLookupComboBox.SetHScrollBarWidth;
var
   j: integer;
   MaxWidth :integer;
begin
  if not HorizontalScroll then
    exit;
  MaxWidth := 0;
  for j := 0 to FFieldCount-1 do
    inc(MaxWidth, FFieldWidth[j] +7 );
  FListBox.Perform(LB_SETHORIZONTALEXTENT, MaxWidth, 0 );
end;

procedure TElWideDBLookupComboBox.DoDropDown;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
    inherited
  else
  begin
    if fNeedUpdate
       or
       (
        Assigned(FElDBWideLookupControl.ListSource) and Assigned(FElDBWideLookupControl.ListSource.DataSet) and
        (FElDBWideLookupControl.ListSource.DataSet.Active) and
        (FElDBWideLookupControl.ListSource.DataSet.RecordCount <> Items.Count)
       )
    then
      FElDBWideLookupControl.UpdateListFields;
    inherited;
  end;
end;

procedure TElWideDBLookupComboBox.SetUnicodeMode(Value: TElDBUnicodeMode);
begin
  if FUnicodeMode <> Value then
  begin
    FUnicodeMode := Value;
    FElDBWideLookupControl.UnicodeMode := Value;
  end;
end;

{$ENDIF ELPACK_UNICODE}

end.
