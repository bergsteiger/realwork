{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.CheckLst;

{$T-,H+,X+}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls;

type
  TCheckListBox = class(TCustomListBox)
  private
    FAllowGrayed: Boolean;
    FFlat: Boolean;
    FStandardItemHeight: Integer;
    FOnClickCheck: TNotifyEvent;
    FHeaderColor: TColor;
    FHeaderBackgroundColor: TColor;
{$IF NOT DEFINED(CLR)}
    FWrapperList: TList;
{$ENDIF}
    class var FCheckWidth: Integer;
    class var FCheckHeight: Integer;
    class constructor Create;
    class destructor Destroy;
    class procedure GetCheckSize;
    procedure ResetItemHeight;
    procedure DrawCheck(const R: TRect; AState: TCheckBoxState; AEnabled: Boolean);
    procedure SetChecked(Index: Integer; AChecked: Boolean);
    function GetChecked(Index: Integer): Boolean;
    procedure SetState(Index: Integer; AState: TCheckBoxState);
    function GetState(Index: Integer): TCheckBoxState;
    procedure ToggleClickCheck(Index: Integer);
    procedure InvalidateCheck(Index: Integer);
    function CreateWrapper(Index: Integer): TObject;
    function ExtractWrapper(Index: Integer): TObject;
    function GetWrapper(Index: Integer): TObject;
    function HaveWrapper(Index: Integer): Boolean;
    procedure SetFlat(Value: Boolean);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    function GetItemEnabled(Index: Integer): Boolean;
    procedure SetItemEnabled(Index: Integer; const Value: Boolean);
    function GetHeader(Index: Integer): Boolean;
    procedure SetHeader(Index: Integer; const Value: Boolean);
    procedure SetHeaderBackgroundColor(const Value: TColor);
    procedure SetHeaderColor(const Value: TColor);
    function IsStyleEnabled: Boolean;
{$IF DEFINED(CLR)}
    procedure WMDestroy(var Msg : TWMDestroy); message WM_DESTROY;
{$ENDIF}
  protected
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    function InternalGetItemData(Index: Integer): TListBoxItemData; override;
    procedure InternalSetItemData(Index: Integer; AData: TListBoxItemData); override;
    procedure SetItemData(Index: Integer; AData: TListBoxItemData); override;
    function GetItemData(Index: Integer): TListBoxItemData; override;
    procedure KeyPress(var Key: Char); override;
    procedure LoadRecreateItems(RecreateItems: TStrings); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ResetContent; override;
    procedure SaveRecreateItems(RecreateItems: TStrings); override;
    procedure DeleteString(Index: Integer); override;
    procedure ClickCheck; dynamic;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetCheckWidth: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CheckAll(AState: TCheckBoxState; AllowGrayed: Boolean = True;
      AllowDisabled: Boolean = True);
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property ItemEnabled[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
    property Header[Index: Integer]: Boolean read GetHeader write SetHeader;
  published
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property Align;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property Anchors;
    property AutoComplete;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Flat: Boolean read FFlat write SetFlat default True;
    property Font;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clInfoText;
    property HeaderBackgroundColor: TColor read FHeaderBackgroundColor write SetHeaderBackgroundColor default clInfoBk;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollWidth;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Touch;
    property Visible;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataObject;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses 
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Security.Permissions,
{$ENDIF}
  Vcl.Themes, System.Types, System.UITypes, System.RTLConsts;

type
  TCheckListBoxDataWrapper = class
  private
    FData: TListBoxItemData;
    FState: TCheckBoxState;
    FDisabled: Boolean;
    FHeader: Boolean;
    procedure SetChecked(Check: Boolean);
    function GetChecked: Boolean;
  public
    class function GetDefaultState: TCheckBoxState; static;
    property Checked: Boolean read GetChecked write SetChecked;
    property State: TCheckBoxState read FState write FState;
    property Disabled: Boolean read FDisabled write FDisabled;
    property Header: Boolean read FHeader write FHeader;
  end;


{ TCheckListBoxDataWrapper }

procedure TCheckListBoxDataWrapper.SetChecked(Check: Boolean);
begin
  if Check then FState := cbChecked else FState := cbUnchecked;
end;

function TCheckListBoxDataWrapper.GetChecked: Boolean;
begin
  Result := FState = cbChecked;
end;

class function TCheckListBoxDataWrapper.GetDefaultState: TCheckBoxState;
begin
  Result := cbUnchecked;
end;

{ TCheckListBox }

class constructor TCheckListBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCheckListBox, TListBoxStyleHook);
end;

constructor TCheckListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFlat := True;
  FHeaderColor := clInfoText;
  FHeaderBackgroundColor := clInfoBk;
  if (FCheckWidth = 0) and (FCheckHeight = 0) then
    GetCheckSize;
{$IF NOT DEFINED(CLR)}
  FWrapperList := TList.Create;
{$ENDIF}
end;

class destructor TCheckListBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCheckListBox, TListBoxStyleHook);
end;

destructor TCheckListBox.Destroy;
{$IF NOT DEFINED(CLR)}
var
  I: Integer;
{$ENDIF}
begin
{$IF NOT DEFINED(CLR)}
  for I := 0 to FWrapperList.Count - 1 do
    TCheckListBoxDataWrapper(FWrapperList[I]).Free;
  FWrapperList.Free;
{$ENDIF}
  inherited;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCheckListBox.CreateWnd;
begin
  inherited CreateWnd;
  ResetItemHeight;
end;

function  TCheckListBox.IsStyleEnabled: Boolean;
begin
  Result := StyleServices.Enabled;
  if Result and TStyleManager.IsCustomStyleActive and not (seClient in StyleElements) then
    Result := False;
end;

procedure TCheckListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    if Style and (LBS_OWNERDRAWFIXED or LBS_OWNERDRAWVARIABLE) = 0 then
      Style := Style or LBS_OWNERDRAWFIXED;
end;

function TCheckListBox.GetCheckWidth: Integer;
begin
  Result := FCheckWidth + 2;
end;

procedure TCheckListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TCheckListBox.ResetItemHeight;
begin
  if HandleAllocated and (Style = lbStandard) then
  begin
    Canvas.Font := Font;
    FStandardItemHeight := Canvas.TextHeight('Wg');
    if FCheckHeight > FStandardItemHeight then
      FStandardItemHeight := FCheckHeight;
    Perform(LB_SETITEMHEIGHT, 0, FStandardItemHeight);
  end;
end;

procedure TCheckListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  HeaderState: array[Boolean] of TThemedCheckListBox = (tclHeaderItemDisabled, tclHeaderItemNormal);
  ItemState: array[Boolean] of TThemedCheckListBox = (tclListItemDisabled, tclListItemNormal);
var
  LRect: TRect;
  ACheckWidth: Integer;
  SaveEvent: TDrawItemEvent;
  Enable: Boolean;
  LColor: TColor;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
  LHeaderColor, LHeaderBackgroundColor: TColor;
begin
  ACheckWidth := GetCheckWidth;

  if Index < Items.Count then
  begin
    LRect := Rect;
    Enable := Self.Enabled and GetItemEnabled(Index);

    LStyle := StyleServices;
    if not Header[Index] then
    begin
      if not UseRightToLeftAlignment then
      begin
        LRect.Right := Rect.Left;
        LRect.Left := LRect.Right - ACheckWidth;
      end
      else
      begin
        LRect.Left := Rect.Right;
        LRect.Right := LRect.Left + ACheckWidth;
      end;

      DrawCheck(LRect, GetState(Index), Enable);

      if IsStyleEnabled then
      begin
        LDetails := LStyle.GetElementDetails(ItemState[Enable]);
        if (seFont in StyleElements) and LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
          Canvas.Font.Color := LColor;
      end
      else if not Enable then
        Canvas.Font.Color := clGrayText;
    end
    else
    begin
      if Enable then
        LHeaderColor := HeaderColor
      else
        LHeaderColor := clGrayText;
      LHeaderBackgroundColor := HeaderBackgroundColor;

      if IsStyleEnabled then
      begin
        LDetails := LStyle.GetElementDetails(HeaderState[Enable]);
        if LStyle.GetElementColor(LDetails, ecTextColor, LColor) and (LColor <> clNone) then
          LHeaderColor := LColor;
        if LStyle.GetElementColor(LDetails, ecFillColor, LColor) and (LColor <> clNone) then
          LHeaderBackgroundColor := LColor;
      end;

      Canvas.Font.Color := LHeaderColor;
      Canvas.Brush.Color := LHeaderBackgroundColor;
    end;

  end;

  if (Style = lbStandard) and Assigned(OnDrawItem) then
  begin
    { Force lbStandard list to ignore OnDrawItem event. }
    SaveEvent := OnDrawItem;
    OnDrawItem := nil;
    try
      inherited;
    finally
      OnDrawItem := SaveEvent;
    end;
  end
  else
    inherited;
end;

procedure TCheckListBox.CNDrawItem(var Message: TWMDrawItem);
var
{$IF DEFINED(CLR)}
  LDrawItemStruct: TDrawItemStruct;
{$ELSE}
  LDrawItemStruct: PDrawItemStruct;
{$ENDIF}
begin
  if not (csDestroying in ComponentState) then
  begin
    if Items.Count = 0 then exit;
    LDrawItemStruct := Message.DrawItemStruct;
    with LDrawItemStruct{$IFNDEF CLR}^{$ENDIF} do
    if not Header[itemID] then
    begin
      if not UseRightToLeftAlignment then
        rcItem.Left := rcItem.Left + GetCheckWidth
      else
        rcItem.Right := rcItem.Right - GetCheckWidth;
  {$IF DEFINED(CLR)}
      Message.DrawItemStruct := LDrawItemStruct;
  {$ENDIF}
    end;
    inherited;
  end;
end;

procedure TCheckListBox.DrawCheck(const R: TRect; AState: TCheckBoxState; AEnabled: Boolean);
var
  DrawState: Integer;
  DrawRect: TRect;
  OldBrushColor: TColor;
  OldBrushStyle: TBrushStyle;
  OldPenColor: TColor;
  ElementDetails: TThemedElementDetails;
  ExRect: TRect;
  SaveIndex: Integer;
  SaveColor: TColor;
begin
  DrawRect.Left := R.Left + (R.Right - R.Left - FCheckWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckHeight) div 2;
  DrawRect.Right := DrawRect.Left + FCheckWidth;
  DrawRect.Bottom := DrawRect.Top + FCheckHeight;
  with Canvas do
  begin
    if ThemeControl(Self) then
    begin
      case AState of
        cbChecked:
          if AEnabled then
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxCheckedNormal)
          else
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxCheckedDisabled);
        cbUnchecked:
          if AEnabled then
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal)
          else
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxUncheckedDisabled)
        else // cbGrayed
          if AEnabled then
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxMixedNormal)
          else
            ElementDetails := StyleServices.GetElementDetails(tbCheckBoxMixedDisabled);
      end;
      SaveColor := Brush.Color;
      SaveIndex := SaveDC(Handle);
      try
        if TStyleManager.IsCustomStyleActive and (seClient in StyleElements) then
          Brush.Color := StyleServices.GetStyleColor(scListBox)
        else
          Brush.Color := Color;
        FillRect(R);
        IntersectClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
        StyleServices.DrawElement(Handle, ElementDetails, R);
      finally
        RestoreDC(Handle, SaveIndex);
      end;
      Brush.Color := SaveColor;
    end
    else
    begin
      case AState of
        cbChecked:
          DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
        cbUnchecked:
          DrawState := DFCS_BUTTONCHECK;
        else // cbGrayed
          DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
      end;
      if not AEnabled then
        DrawState := DrawState or DFCS_INACTIVE;
      DrawFrameControl(Handle, DrawRect, DFC_BUTTON, DrawState);
    end;

    if Flat and not TStyleManager.IsCustomStyleActive then
    begin
      { Clip the 3d checkbox }
      OldBrushStyle := Brush.Style;
      OldBrushColor := Brush.Color;
      OldPenColor := Pen.Color;

      Brush.Style := bsClear;
      Pen.Color := Color;
      with DrawRect do
        Rectangle(Left, Top, Right, Bottom);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
      Brush.Style := bsClear;
      Pen.Color := clBtnShadow;
      with DrawRect do
        Rectangle(Left + 1, Top + 1, Right - 1, Bottom - 1);
      SaveIndex := SaveDC(Handle);
      try
        ExRect := Rect(R.Left, R.Top, DrawRect.Right + 2, R.Bottom);
        Brush.Style := bsSolid;
        Brush.Color := Color;
        ExcludeClipRect(Handle, DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);
        FillRect(ExRect);
      finally
        RestoreDC(Handle, SaveIndex);
        Brush.Style := bsClear;
      end;
      Brush.Style := OldBrushStyle;
      Brush.Color := OldBrushColor;
      Pen.Color := OldPenColor;
    end;
  end;
end;

class procedure TCheckListBox.GetCheckSize;
var
  DC: HDC;
  LCheckSize: TSize;
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  if LStyle.Enabled then
  begin
    DC := CreateCompatibleDC(0);
    try
      LStyle.GetElementSize(DC, LStyle.GetElementDetails(tbCheckBoxCheckedNormal), esActual, LCheckSize);
      if (LCheckSize.Width <= 0) or (LCheckSize.Height <= 0) then
      begin 
        LStyle := TStyleManager.SystemStyle;
        LStyle.GetElementSize(DC, LStyle.GetElementDetails(tbCheckBoxCheckedNormal), esActual, LCheckSize);
      end;
      FCheckWidth := LCheckSize.Width;
      FCheckHeight := LCheckSize.Height;
    finally
      DeleteDC(DC);
    end;
  end
  else
    with TBitmap.Create do
      try
{$IF DEFINED(CLR)}
        Handle := LoadBitmap(0, OBM_CHECKBOXES);
{$ELSE}
        Handle := LoadBitmap(0, PChar(OBM_CHECKBOXES));
{$ENDIF}
        FCheckWidth := Width div 4;
        FCheckHeight := Height div 3;
      finally
        Free;
      end;
end;

procedure TCheckListBox.SetChecked(Index: Integer; AChecked: Boolean);
begin
  if AChecked <> GetChecked(Index) then
  begin
    TCheckListBoxDataWrapper(GetWrapper(Index)).SetChecked(AChecked);
    InvalidateCheck(Index);
  end;
end;

procedure TCheckListBox.SetItemEnabled(Index: Integer; const Value: Boolean);
begin
  if Value <> GetItemEnabled(Index) then
  begin
    TCheckListBoxDataWrapper(GetWrapper(Index)).Disabled := not Value;
    InvalidateCheck(Index);
  end;
end;

procedure TCheckListBox.SetState(Index: Integer; AState: TCheckBoxState);
begin
  if AState <> GetState(Index) then
  begin
    TCheckListBoxDataWrapper(GetWrapper(Index)).State := AState;
    InvalidateCheck(Index);
  end;
end;

procedure TCheckListBox.InvalidateCheck(Index: Integer);
var
  R: TRect;
begin
  if not Header[Index] then
  begin
    R := ItemRect(Index);
    if not UseRightToLeftAlignment then
      R.Right := R.Left + GetCheckWidth
    else
      R.Left := R.Right - GetCheckWidth;
    InvalidateRect(Handle, R, not (csOpaque in ControlStyle));
    UpdateWindow(Handle);
  end;
end;

function TCheckListBox.GetChecked(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TCheckListBoxDataWrapper(GetWrapper(Index)).GetChecked
  else
    Result := False;
end;

function TCheckListBox.GetItemEnabled(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := not TCheckListBoxDataWrapper(GetWrapper(Index)).Disabled
  else
    Result := True;
end;

function TCheckListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if HaveWrapper(Index) then
    Result := TCheckListBoxDataWrapper(GetWrapper(Index)).State
  else
    Result := TCheckListBoxDataWrapper.GetDefaultState;
end;

procedure TCheckListBox.CheckAll(AState: TCheckBoxState; AllowGrayed: Boolean; AllowDisabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if ItemEnabled[I] or (not ItemEnabled[I] and AllowDisabled) then
      if(AllowGrayed or (GetState(I) <> cbGrayed))then
        SetState(I, AState);
end;

procedure TCheckListBox.KeyPress(var Key: Char);
begin
  if (Key = ' ') then
    ToggleClickCheck(ItemIndex);
  inherited KeyPress(Key);
end;

procedure TCheckListBox.LoadRecreateItems(RecreateItems: TStrings);
var
  I, Index: Integer;
begin
  with RecreateItems do
  begin
    BeginUpdate;
    try
      Items.NameValueSeparator := NameValueSeparator;
      Items.QuoteChar := QuoteChar;
      Items.Delimiter := Delimiter;
      Items.LineBreak := LineBreak;
      for I := 0 to Count - 1 do
      begin
        Index := Items.Add(RecreateItems[I]);
        if Objects[I] <> nil then
          InternalSetItemData(Index, TListBoxItemData(Objects[I]));
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Index: Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    Index := ItemAtPos(Point(X,Y),True);
    if (Index <> -1) and GetItemEnabled(Index) then
      if not UseRightToLeftAlignment then
      begin
        if X - ItemRect(Index).Left < GetCheckWidth then
          ToggleClickCheck(Index)
      end
      else
      begin
        Dec(X, ItemRect(Index).Right - GetCheckWidth);
        if (X > 0) and (X < GetCheckWidth) then
          ToggleClickCheck(Index)
      end;
  end;
end;

procedure TCheckListBox.ToggleClickCheck;
var
  State: TCheckBoxState;
begin
  if (Index >= 0) and (Index < Items.Count) and GetItemEnabled(Index) then
  begin
    State := Self.State[Index];
    case State of
      cbUnchecked:
        if AllowGrayed then State := cbGrayed else State := cbChecked;
      cbChecked: State := cbUnchecked;
      cbGrayed: State := cbChecked;
    end;
    Self.State[Index] := State;
    ClickCheck;
  end;
end;

procedure TCheckListBox.ClickCheck;
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;

function TCheckListBox.GetItemData(Index: Integer): TListBoxItemData;
begin
{$IF DEFINED(CLR)}
  Result := nil;
{$ELSE}
  Result := 0;
{$ENDIF}
  if HaveWrapper(Index) then
    Result := TCheckListBoxDataWrapper(GetWrapper(Index)).FData;
end;

function TCheckListBox.GetWrapper(Index: Integer): TObject;
begin
  Result := ExtractWrapper(Index);
  if Result = nil then
    Result := CreateWrapper(Index);
end;

function TCheckListBox.ExtractWrapper(Index: Integer): TObject;
begin
{$IF DEFINED(CLR)}
  if (Index < 0) or (Index >= Count) then
    raise EListError.Create(Format(SListIndexError, [Index]));
  Result := inherited GetItemData(Index);
{$ELSE}
  Result := TCheckListBoxDataWrapper(inherited GetItemData(Index));
  if LB_ERR = IntPtr(Result) then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
{$ENDIF}
  if (Result <> nil) and (not (Result is TCheckListBoxDataWrapper)) then
    Result := nil;
end;

function TCheckListBox.InternalGetItemData(Index: Integer): TListBoxItemData;
begin
  Result := inherited GetItemData(Index);
end;

procedure TCheckListBox.InternalSetItemData(Index: Integer; AData: TListBoxItemData);
begin
  inherited SetItemData(Index, AData);
end;

function TCheckListBox.CreateWrapper(Index: Integer): TObject;
begin
{$IF NOT DEFINED(CLR)}
  FWrapperList.Expand;
{$ENDIF}
  Result := TCheckListBoxDataWrapper.Create;
{$IF NOT DEFINED(CLR)}
  FWrapperList.Add(Result);
{$ENDIF}
  inherited SetItemData(Index, TListBoxItemData(Result));
end;

function TCheckListBox.HaveWrapper(Index: Integer): Boolean;
begin
  Result := ExtractWrapper(Index) <> nil;
end;

procedure TCheckListBox.SetItemData(Index: Integer; AData: TListBoxItemData);
var
  Wrapper: TCheckListBoxDataWrapper;
begin
{$IF DEFINED(CLR)}
  if HaveWrapper(Index) or (AData <> nil) then
{$ELSE}
  if HaveWrapper(Index) or (AData <> 0) then
{$ENDIF}
  begin
    Wrapper := TCheckListBoxDataWrapper(GetWrapper(Index));
    Wrapper.FData := AData;
  end;
end;

procedure TCheckListBox.ResetContent;
{$IF DEFINED(CLR)}
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if HaveWrapper(I) then
      GetWrapper(I).Free;
  inherited;
{$ELSE}
var
  I, Index: Integer;
  LWrapper: TCheckListBoxDataWrapper;
begin
  for I := 0 to Items.Count - 1 do
  begin
    LWrapper := TCheckListBoxDataWrapper(ExtractWrapper(I));
    if Assigned(LWrapper) then
    begin
      Index := FWrapperList.IndexOf(LWrapper);
      if Index <> -1 then
        FWrapperList.Delete(Index);
      LWrapper.Free;
    end;
  end;
  inherited;
{$ENDIF}
end;

procedure TCheckListBox.SaveRecreateItems(RecreateItems: TStrings);
var
{$IF DEFINED(CLR)}
  I, Index: Integer;
{$ELSE}
  I: Integer;
  LWrapper: TCheckListBoxDataWrapper;
{$ENDIF}
begin
{$IF NOT DEFINED(CLR)}
  FWrapperList.Clear;
{$ENDIF}
  with RecreateItems do
  begin
    BeginUpdate;
    try
      NameValueSeparator := Items.NameValueSeparator;
      QuoteChar := Items.QuoteChar;
      Delimiter := Items.Delimiter;
      LineBreak := Items.LineBreak;
      for I := 0 to Items.Count - 1 do
{$IF DEFINED(CLR)}
        AddObject(Items[I], ExtractWrapper(I));
{$ELSE}
      begin
        LWrapper := TCheckListBoxDataWrapper(ExtractWrapper(I));
        AddObject(Items[I], LWrapper);
        if LWrapper <> nil then
          FWrapperList.Add(LWrapper);
      end;
{$ENDIF}
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCheckListBox.DeleteString(Index: Integer);
{$IF DEFINED(CLR)}
begin
  if HaveWrapper(Index) then
    GetWrapper(Index).Free;
  inherited;
{$ELSE}
var
  LIndex: Integer;
  LWrapper: TCheckListBoxDataWrapper;
begin
  if HaveWrapper(Index) then
  begin
    LWrapper := TCheckListBoxDataWrapper(GetWrapper(Index));
    LIndex := FWrapperList.IndexOf(LWrapper);
    if LIndex <> -1 then
      FWrapperList.Delete(LIndex);
    LWrapper.Free;
  end;
  inherited;
{$ENDIF}
end;

procedure TCheckListBox.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

{$IF DEFINED(CLR)}
procedure TCheckListBox.WMDestroy(var Msg: TWMDestroy);
begin
  ResetContent;
  inherited;
end;
{$ENDIF}

function TCheckListBox.GetHeader(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TCheckListBoxDataWrapper(GetWrapper(Index)).Header
  else
    Result := False;
end;

procedure TCheckListBox.SetHeader(Index: Integer; const Value: Boolean);
begin
  if Value <> GetHeader(Index) then
  begin
    TCheckListBoxDataWrapper(GetWrapper(Index)).Header := Value;
    InvalidateCheck(Index);
  end;
end;

procedure TCheckListBox.SetHeaderBackgroundColor(const Value: TColor);
begin
  if Value <> HeaderBackgroundColor then
  begin
    FHeaderBackgroundColor := Value;
    Invalidate;
  end;
end;

procedure TCheckListBox.SetHeaderColor(const Value: TColor);
begin
  if Value <> HeaderColor then
  begin
    FHeaderColor := Value;
    Invalidate;
  end;
end;

end.

