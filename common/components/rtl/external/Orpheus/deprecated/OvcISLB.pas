{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCISLB.PAS 2.17                     *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcISLB;
  {-Incremental search listbox component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Menus, Messages, StdCtrls,
  SysUtils,
  OvcBase, OvcData, OvcISEB;

const
  DefBorderStyle = bsSingle;
  DefColor       = clWindow;
  DefCtl3D       = True;
  DefHeight      = 150;
  DefParentColor = False;
  DefParentCtl3D = True;
  DefParentFont  = True;
  DefTabStop     = True;
  DefWidth       = 100;

type
  {.Z+}
  TOvcSearchEdit = class(TOvcBaseISE)
  public
    procedure PerformSearch;
      override;
  end;

  TOvcSearchListBox = class(TCustomListBox)
  protected {private}
    procedure WMNCHitTest(var Msg : TMessage);
      message WM_NCHITTEST;
  protected
    procedure Click;
      override;
  end;
  {.Z-}

  TOvcSearchList = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FBorderStyle : TBorderStyle;
    FEdit        : TOvcSearchEdit;
    FListBox     : TOvcSearchListBox;

    {property methods}
    function GetAutoSearch : Boolean;
    function GetAutoSelect : Boolean;
    function GetCaseSensitive : Boolean;
    function GetColumns : LongInt;
    function GetEdit : TEdit;
    function GetHideSelection : Boolean;
    function GetItemHeight : Integer;
    function GetItems : TStrings;
    function GetItemIndex : Integer;
    function GetKeyDelay : Integer;
    function GetListBox : TListBox;
    function GetPasswordChar : AnsiChar;
    function GetShowResults : Boolean;
    procedure SetAutoSearch(Value : Boolean);
    procedure SetAutoSelect(Value : Boolean);
    procedure SetBorderStyle(Value : TBorderStyle);
    procedure SetCaseSensitive(Value : Boolean);
    procedure SetColumns(Value : LongInt);
    procedure SetHideSelection(Value : Boolean);
    procedure SetItemHeight(Value : Integer);
    procedure SetItems(Value : TStrings);
    procedure SetItemIndex(Value : Integer);
    procedure SetKeyDelay(Value : Integer);
    procedure SetOnChange(Value : TNotifyEvent);
    procedure SetPasswordChar(Value : AnsiChar);
    procedure SetShowResults(Value : Boolean);

    {event methods}
    function GetOnChange : TNotifyEvent;

    {VCL control methods}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;

    {internal methods}
    procedure isSetPositions;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Loaded;                                                  {!!.16}
      override;
    procedure Paint;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor  Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
      override;

  {.Z-}

    {public properties}
    property Canvas;

    property Edit : TEdit
      read GetEdit;

    property ItemIndex : Integer
      read GetItemIndex
      write SetItemIndex;

    property ListBox : TListBox
      read GetListBox;

  published
    property AutoSearch : Boolean
      read GetAutoSearch
      write SetAutoSearch
      default DefAutoSearch;

    property AutoSelect : Boolean
      read GetAutoSelect
      write SetAutoSelect;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default DefBorderStyle;

    property CaseSensitive : Boolean
      read GetCaseSensitive
      write SetCaseSensitive
      default DefCaseSensitive;

    property Columns : LongInt
      read GetColumns
      write SetColumns;

    property HideSelection : Boolean
      read GetHideSelection
      write SetHideSelection;

    property ItemHeight : Integer
      read GetItemHeight
      write SetItemHeight;

    property Items : TStrings
      read GetItems
      write SetItems;

    property KeyDelay : Integer
      read GetKeyDelay
      write SetKeyDelay
      default DefKeyDelay;

    property PasswordChar : AnsiChar
      read GetPasswordChar
      write SetPasswordChar;

    property ShowResults : Boolean
      read GetShowResults
      write SetShowResults
      default DefShowResults;

    {events}
    {property AfterEnter;}                                             {!!.16}
    {property AfterExit;}                                              {!!.16}
    property OnChange : TNotifyEvent
      read GetOnChange
      write SetOnChange;

    {inherited properties}
    property Align;
    property Color default DefColor;
    property Ctl3D default DefCtl3D;
    property Enabled;
    property Font;
    property ParentColor default DefParentColor;
    property ParentCtl3D default DefParentCtl3D;
    property ParentFont default DefParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default DefTabStop;
    property Visible;

    {inherited events}
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}


{*** TOvcSearchEdit ***}

procedure TOvcSearchEdit.PerformSearch;
var
  ISL : TOvcSearchList;
  I   : Integer;
  Idx : Integer;

  function SearchFor(const S : string) : Integer;
  var
    Left  : Integer;
    Right : Integer;
    Found : Boolean;
  begin
    Result := -1;
    if ISL.Items.Count = 0 then
      Exit;

    Left := 0;
    Right := Pred(ISL.Items.Count);

    repeat
      Result := (Left+Right) div 2;
      if S < ISUpperCase(ISL.Items[Result]) then
        Right := Pred(Result)
      else
        Left := Succ(Result);
      Found := Pos(S, ISUpperCase(ISL.Items[Result])) = 1;
    until Found or (Left > Right);

    {back up to first match}
    if Found then begin
      repeat
        Dec(Result);
      until (Result < 0) or (Pos(S, ISUpperCase(ISL.Items[Result])) <> 1);
      Inc(Result);
    end else
      Result := -1;
  end;

begin
  ISL := TOvcSearchList(Owner);

  if (Text > '') then begin
    {search for this item}
    Idx := SearchFor(ISUpperCase(Text));

    if Idx > -1 then begin
      ISL.ItemIndex := Idx;

      {attempt to place this item at the center of the list}
      I := (ISL.ListBox.Height div ISL.ItemHeight) div 2;
      if (Idx - I) >= 0 then
        ISL.ListBox.TopIndex := Idx - I;

      if ShowResults then begin
        {record previous value}
        PreviousText := ISUpperCase(Text);

        {assign new value and select added characters}
        I := Length(Text);
        Text := ISL.Items[Idx];
        SelStart := I;
        SelLength := Length(Text)-I;
        Self.Modified := False;
      end;
    end;
  end else if ISL.Items.Count > 0 then
    ISL.ItemIndex := 0;
end;


{*** TOvcSearchListBox ***}

procedure TOvcSearchListBox.Click;
var
  ISL : TOvcSearchList;
begin
  inherited Click;

  ISL := TOvcSearchList(Owner);
  if ItemIndex > -1 then
    ISL.Edit.Text := Items[ItemIndex];
end;

procedure TOvcSearchListBox.WMNCHitTest(var Msg : TMessage);
begin
  if (csDesigning in ComponentState) then
    DefaultHandler(Msg)
  else
    inherited;
end;


{*** TOvcSearchList ***}

procedure TOvcSearchList.CMCtl3DChanged(var Msg : TMessage);
begin
  if (csLoading in ComponentState) or not HandleAllocated then
    Exit;

  {$IFDEF Win32}
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  {$ENDIF}

  inherited;
end;

constructor TOvcSearchList.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  if NewStyleControls then
    ControlStyle := ControlStyle + []
  else
    ControlStyle := ControlStyle + [csFramed];
  {$ELSE}
    ControlStyle := ControlStyle + [csFramed];
  {$ENDIF}

  {initialize inherited properties}
  Color       := DefColor;
  Ctl3D       := DefCtl3D;
  Height      := DefHeight;
  ParentColor := DefParentColor;
  ParentCtl3D := DefParentCtl3D;
  ParentFont  := DefParentFont;
  TabStop     := DefTabStop;
  Width       := DefWidth;

  {initialize property variables}
  FBorderStyle := DefBorderStyle;

  FEdit := TOvcSearchEdit.Create(Self);
  FEdit.BorderStyle := bsNone;
  FEdit.Ctl3D := False;
  FEdit.ParentColor := True;
  FEdit.ParentCtl3D := False;
  FEdit.Parent := Self;

  FListBox := TOvcSearchListBox.Create(Self);
  FListBox.BorderStyle := bsNone;
  FListBox.Ctl3D := False;
  FListBox.ParentColor := True;
  FListBox.ParentCtl3D := False;
  FListBox.Sorted := True;
  FListBox.Parent := Self;
end;

procedure TOvcSearchList.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);

  with Params do
    Style := LongInt(Style) or BorderStyles[FBorderStyle];             {!!.D4}

  {$IFDEF Win32}
  if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
    Params.Style := Params.Style and not WS_BORDER;
    Params.ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
  end;
  {$ENDIF}
end;

{!!.16}
procedure TOvcSearchList.CreateWnd;
begin
  inherited CreateWnd;

  FListBox.HandleNeeded;
  isSetPositions;
end;

destructor TOvcSearchList.Destroy;
begin
  FEdit.Free;
  FEdit := nil;

  FListBox.Free;
  FListBox := nil;

  inherited Destroy;
end;

function TOvcSearchList.GetAutoSearch : Boolean;
begin
  Result := FEdit.AutoSearch;
end;

function TOvcSearchList.GetAutoSelect : Boolean;
begin
  Result := FEdit.AutoSelect;
end;

function TOvcSearchList.GetCaseSensitive : Boolean;
begin
  Result := FEdit.CaseSensitive;
end;

function TOvcSearchList.GetColumns : LongInt;
begin
  Result := FListBox.Columns;
end;

function TOvcSearchList.GetEdit : TEdit;
begin
  Result := TEdit(FEdit);
end;

function TOvcSearchList.GetHideSelection : Boolean;
begin
  Result := FEdit.HideSelection;
end;

function TOvcSearchList.GetItemHeight : Integer;
begin
  Result := FListBox.ItemHeight;
end;

function TOvcSearchList.GetItems : TStrings;
begin
  Result := FListBox.Items;
end;

function TOvcSearchList.GetItemIndex : Integer;
begin
  Result := FListBox.ItemIndex;
end;

function TOvcSearchList.GetKeyDelay : Integer;
begin
  Result := FEdit.KeyDelay;
end;

function TOvcSearchList.GetListBox : TListBox;
begin
  Result := TListBox(FListBox);
end;

function TOvcSearchList.GetOnChange : TNotifyEvent;
begin
  Result := FEdit.OnChange;
end;

function TOvcSearchList.GetPasswordChar : AnsiChar;
begin
  Result := FEdit.PassWordChar;
end;

function TOvcSearchList.GetShowResults : Boolean;
begin
  Result := FEdit.ShowResults;
end;

procedure TOvcSearchList.isSetPositions;
begin
  if not HandleAllocated then
    Exit;

  FEdit.SetBounds(3, 4, ClientWidth-6, ItemHeight);
  FListBox.SetBounds(0, FEdit.Height + 5, ClientWidth, ClientHeight-FEdit.Height - 5);
end;

{!!.16}
procedure TOvcSearchList.Loaded;
begin
  inherited Loaded;

  {set edit events}
  FEdit.Controller := Controller;
  FEdit.OnClick := OnClick;
  FEdit.OnDblClick := OnDblClick;
  FEdit.OnEnter := OnEnter;
  FEdit.OnExit := OnExit;
  FEdit.OnKeyDown := OnKeyDown;
  FEdit.OnKeyPress := OnKeyPress;
  FEdit.OnKeyUp := OnKeyUp;
  FEdit.OnMouseDown := OnMouseDown;
  FEdit.OnMouseMove := OnMouseMove;
  FEdit.OnMouseUp := OnMouseUp;

  {set listbox events}
  FListBox.OnClick := OnClick;
  FListBox.OnDblClick := OnDblClick;
  FListBox.OnEnter := OnEnter;
  FListBox.OnExit := OnExit;
  FListBox.OnKeyDown := OnKeyDown;
  FListBox.OnKeyPress := OnKeyPress;
  FListBox.OnKeyUp := OnKeyUp;
  FListBox.OnMouseDown := OnMouseDown;
  FListBox.OnMouseMove := OnMouseMove;
  FListBox.OnMouseUp := OnMouseUp;

  {at run-time, pass TabStop setting on to children}                   {!!.15}
  if not (csDesigning in ComponentState) then begin                    {!!.15}
    FEdit.TabStop := TabStop;                                          {!!.15}
    FListBox.TabStop := TabStop;                                       {!!.15}
    TabStop := False;                                                  {!!.15}
  end;                                                                 {!!.15}
end;

procedure TOvcSearchList.Paint;
begin
  inherited Paint;

  Canvas.PolyLine([Point(0, FEdit.Height+4), Point(Width, FEdit.Height+4)]);
end;

procedure TOvcSearchList.SetAutoSearch(Value : Boolean);
begin
  FEdit.AutoSearch := Value;
end;

procedure TOvcSearchList.SetAutoSelect(Value : Boolean);
begin
  FEdit.AutoSelect:= Value;
end;

procedure TOvcSearchList.SetBorderStyle(Value : TBorderStyle);
  {-set the type of border to use}
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcSearchList.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  isSetPositions;
end;

procedure TOvcSearchList.SetCaseSensitive(Value : Boolean);
begin
  FEdit.CaseSensitive := Value;
end;

procedure TOvcSearchList.SetColumns(Value : LongInt);
begin
  FListBox.Columns := Value;
end;

procedure TOvcSearchList.SetHideSelection(Value : Boolean);
begin
  FEdit.HideSelection := Value;
end;

procedure TOvcSearchList.SetItemHeight(Value : Integer);
begin
  FListBox.ItemHeight := Value;
end;

procedure TOvcSearchList.SetItems(Value : TStrings);
begin
  FListBox.Items.Assign(Value);
end;

procedure TOvcSearchList.SetItemIndex(Value : Integer);
begin
  FListBox.ItemIndex := Value;
end;

procedure TOvcSearchList.SetKeyDelay(Value : Integer);
begin
  FEdit.KeyDelay := Value;
end;

procedure TOvcSearchList.SetOnChange(Value : TNotifyEvent);
begin
  FEdit.OnChange := Value;
end;

procedure TOvcSearchList.SetPasswordChar(Value : AnsiChar);
begin
  FEdit.PasswordChar := Value;
end;

procedure TOvcSearchList.SetShowResults(Value : Boolean);
begin
  FEdit.ShowResults := Value;
end;


end.