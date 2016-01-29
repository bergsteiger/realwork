{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFDEF Win32}
{$H+} {Long strings}
{$ENDIF}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCBTNHD.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcBtnHd;
  {-Button header component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, Dialogs, ExtCtrls, Forms,
  Graphics, Menus, Messages, SysUtils,
  OvcBase;

const
  DefAlignment    = taLeftJustify;
  DefAllowResize  = True;
  DefBorderStyle  = bsSingle;
  DefSectionWidth = 75;
  DefTextMargin   = 0;
  DefWordWrap     = False;

type
  TOvcButtonHeader = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FAlignment      : TAlignment;
    FAllowResize    : Boolean;
    FBorderStyle    : TBorderStyle;
    FItemIndex      : Integer;
    FSections       : TStrings;
    FTextMargin     : Integer;
    FWordWrap       : Boolean;

    {event variables}
    FOnClick        : TNotifyEvent;
    FOnSized        : TSectionEvent;
    FOnSizing       : TSectionEvent;

    {internal variables}
    bhCanResize     : Boolean;
    bhHitTest       : TPoint;
    bhMouseOffset   : Integer;
    bhResizeSection : Integer;

    {property methods}
    function GetWidth(X : Integer) : Integer;
    procedure SetAlignment(Value : TAlignment);
    procedure SetBorderStyle(Value : TBorderStyle);
    procedure SetItemIndex(Value : Integer);
    procedure SetSections(Strings : TStrings);
    procedure SetTextMargin(Value : Integer);
    procedure SetWidth(X : Integer; Value : Integer);
    procedure SetWordWrap(Value : Boolean);

    {internal methods}
    procedure bhFreeSections;

    {VCL control methods}
    procedure CMDialogChar(var Msg : TCMDialogChar);
      message CM_DIALOGCHAR;
    procedure CMDesignHitTest(var Msg : TCMDesignHitTest);
      message CM_DESIGNHITTEST;

    {windows message response methods}
    procedure WMSetCursor(var Msg : TWMSetCursor);
      message WM_SETCURSOR;
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer);
      override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;
    procedure Paint;
      override;

    procedure DoOnClick;
      virtual;
    procedure DoOnSized(ASection, AWidth : Integer);
      dynamic;
    procedure DoOnSizing(ASection, AWidth : Integer);
      dynamic;

  public
    constructor Create(AOwner: TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    {public properties}
    property SectionWidth[X : Integer] : Integer
      read GetWidth
      write SetWidth;

  published
    {properties}
    property Alignment : TAlignment
      read FAlignment
      write SetAlignment
      default DefAlignment;

    property AllowResize : Boolean
      read FAllowResize
      write FAllowResize
      default DefAllowResize;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default DefBorderStyle;

    property ItemIndex : Integer
      read FItemIndex
      write SetItemIndex;

    property Sections : TStrings
      read FSections
      write SetSections;

    property TextMargin : Integer
      read FTextMargin
      write SetTextMargin;

    property WordWrap : Boolean
      read FWordWrap
      write SetWordWrap
      default DefWordWrap;

    {events}
    property OnClick : TNotifyEvent
      read FOnClick
      write FOnClick;

    property OnSizing : TSectionEvent
      read FOnSizing
      write FOnSizing;

    property OnSized : TSectionEvent
      read FOnSized
      write FOnSized;

    {inherited properties}
    property Align;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
  end;

type
  PHeaderSection = ^THeaderSection;
  THeaderSection = record
    FObject : TObject;
    Width   : Integer;
    Title   : string;
  end;

type
  THeaderStrings = class(TStrings)
  private
    FHeader : TOvcButtonHeader;
    FList   : TList;

    procedure ReadData(Reader : TReader);
    procedure WriteData(Writer : TWriter);

  protected
    procedure DefineProperties(Filer : TFiler);
      override;
    function Get(Index : Integer): string;
      override;
    function GetCount : Integer;
      override;
    function GetObject(Index : Integer) : TObject;
      override;
    procedure Put(Index : Integer; const S : string);
      override;
    procedure PutObject(Index : Integer; AObject : TObject);
      override;
    procedure SetUpdateState(Updating : Boolean);
      override;

  public
    constructor Create;
    destructor Destroy;
      override;
    procedure Assign(Source : TPersistent);
      override;
    procedure Delete(Index : Integer);
      override;
    procedure Insert(Index : Integer; const S: string);
      override;
    procedure Clear; override;
  end;



implementation



{*** THeaderStrings helper routines ***}

procedure FreeSection(Section : PHeaderSection);
begin
  if Section <> nil then
    Dispose(Section);
end;

function NewSection(const ATitle : string; AWidth : Integer; AObject : TObject) : PHeaderSection;
begin
  New(Result);
  with Result^ do begin
    Title := ATitle;
    Width := AWidth;
    FObject := AObject;
  end;
end;

{*** THeaderStrings ***}

procedure THeaderStrings.Assign(Source : TPersistent);
var
  I, J    : Integer;
  Strings : TStrings;
  NewList : TList;
  Section : PHeaderSection;
  TempStr : string;
  Found   : Boolean;
begin
  if Source is TStrings then begin
    Strings := TStrings(Source);
    BeginUpdate;
    try
      NewList := TList.Create;
      try
        {delete any sections not in the new list}
        I := FList.Count - 1;
        Found := False;
        while I >= 0 do begin
          TempStr := Get(I);
          for J := 0 to Strings.Count - 1 do begin
            Found := CompareStr(Strings[J], TempStr) = 0;
            if Found then
              Break;
          end;
          if not Found then
            Delete(I);
          Dec(I);
        end;

        {now, iterate over the lists and maintain section widths of sections in the new list }
        I := 0;
        for J := 0 to Strings.Count - 1 do begin
          if (I < FList.Count) and (CompareStr(Strings[J], Get(I)) = 0) then begin
            Section := NewSection(Get(I), PHeaderSection(FList[I])^.Width, GetObject(I));
            Inc(I);
          end else
            Section := NewSection(Strings[J],
              FHeader.Canvas.TextWidth(Strings[J]) + 8, Strings.Objects[J]);
          NewList.Add(Section);
        end;

        Clear;
        FList.Destroy;
        FList := NewList;
        FHeader.Invalidate;
      except
        for I := 0 to NewList.Count - 1 do
          FreeSection(NewList[I]);
        NewList.Destroy;
        raise;
      end;
    finally
      EndUpdate;
    end;
    Exit;
  end;

  inherited Assign(Source);
end;

procedure THeaderStrings.Clear;
var
  I : Integer;
begin
  for I := 0 to FList.Count - 1 do
    FreeSection(FList[I]);
  FList.Clear;
end;

constructor THeaderStrings.Create;
begin
  inherited Create;

  FList := TList.Create;
end;

procedure THeaderStrings.DefineProperties(Filer : TFiler);
begin
  {this will allow the old file image to be read in}
  if Filer is TReader then
    inherited DefineProperties(Filer);

  Filer.DefineProperty('Sections', ReadData, WriteData, Count > 0);
end;

destructor THeaderStrings.Destroy;
begin
  if FList <> nil then begin
    Clear;
    FList.Destroy;
    FList := nil;
  end;

  inherited Destroy;
end;

procedure THeaderStrings.Delete(Index : Integer);
begin
  FreeSection(FList[Index]);
  FList.Delete(Index);
  if FHeader <> nil then
    FHeader.Invalidate;
end;

function THeaderStrings.Get(Index : Integer) : string;
begin
  Result := PHeaderSection(FList[Index])^.Title;
end;

function THeaderStrings.GetCount : Integer;
begin
  Result := FList.Count;
end;

function THeaderStrings.GetObject(Index : Integer) : TObject;
begin
  Result := PHeaderSection(FList[Index])^.FObject;
end;

procedure THeaderStrings.Insert(Index : Integer; const S : string);
var
  Width : Integer;
begin
  if FHeader <> nil then
    Width := FHeader.Canvas.TextWidth(S) + 8
  else
    Width := DefSectionWidth;
  FList.Expand.Insert(Index, NewSection(S, Width, nil));
  if FHeader <> nil then
    FHeader.Invalidate;
end;

procedure THeaderStrings.Put(Index : Integer; const S : string);
var
  P     : PHeaderSection;
  Width : Integer;
begin
  P := FList[Index];
  if FHeader <> nil then
    Width := FHeader.Canvas.TextWidth(S) + 8
  else
    Width := DefSectionWidth;
  FList[Index] := NewSection(S, Width, P^.FObject);
  FreeSection(P);
  if FHeader <> nil then
    FHeader.Invalidate;
end;

procedure THeaderStrings.PutObject(Index : Integer; AObject : TObject);
begin
  PHeaderSection(FList[Index])^.FObject := AObject;
  if FHeader <> nil then
    FHeader.Invalidate;
end;

procedure THeaderStrings.ReadData(Reader : TReader);
var
  Width : Integer;
  I     : Integer;
  Str   : string;
begin
  Reader.ReadListBegin;
  Clear;
  while not Reader.EndOfList do begin
    Str := Reader.ReadString;
    Width := DefSectionWidth;
    I := 1;
    if Str[1] = #0 then begin
      repeat
        Inc(I);
      until (I > Length(Str)) or (Str[I] = #0);
      Width := StrToIntDef(Copy(Str, 2, I - 2), DefSectionWidth);
      System.Delete(Str, 1, I);
    end;
    FList.Expand.Insert(FList.Count, NewSection(Str, Width, nil));
  end;
  Reader.ReadListEnd;
end;

procedure THeaderStrings.SetUpdateState(Updating: Boolean);
begin
  if FHeader <> nil then begin
    SendMessage(FHeader.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then
      FHeader.Refresh;
  end;
end;

procedure THeaderStrings.WriteData(Writer: TWriter);
var
  I             : Integer;
  HeaderSection : PHeaderSection;
begin
  Writer.WriteListBegin;
  for I := 0 to Count - 1 do begin
    HeaderSection := FList[I];
    with HeaderSection^ do
      Writer.WriteString(Format(#0'%d'#0'%s', [Width, Title]));
  end;
  Writer.WriteListEnd;
end;



{*** TOvcButtonHeader ***}

procedure TOvcButtonHeader.bhFreeSections;
begin
  if FSections <> nil then
    FSections.Clear;
end;

procedure TOvcButtonHeader.CMDialogChar(var Msg : TCMDialogChar);
var
  I : Integer;
begin
  if Enabled then with Msg do begin
    for I := 0 to pred(FSections.Count) do
    if IsAccel(CharCode, FSections[I]) then begin
      ItemIndex := I;
      Result := 1;
      Exit;
    end;
  end;

  inherited;
end;

procedure TOvcButtonHeader.CMDesignHitTest(var Msg : TCMDesignHitTest);
begin
  if bhCanResize then
    Msg.Result := 1
  else
    inherited;
end;

constructor TOvcButtonHeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csOpaque];

  Width := 250;
  Height := 25;

  FSections := THeaderStrings.Create;
  FSections.Add('&First');
  FSections.Add('&Second');
  FSections.Add('&Third');
  THeaderStrings(FSections).FHeader := Self;

  FAlignment   := DefAlignment;
  FAllowResize := DefAllowResize;
  FBorderStyle := DefBorderStyle;
  FTextMargin  := DefTextMargin;
  FWordWrap    := DefWordWrap;
end;

procedure TOvcButtonHeader.CreateParams(var Params : TCreateParams);
const
  BorderStyles: array[TBorderStyle] of Longint = (0, WS_BORDER);
begin
  inherited CreateParams(Params);

  Params.Style := LongInt(Params.Style) or BorderStyles[FBorderStyle]; {!!.D4}
end;

destructor TOvcButtonHeader.Destroy;
begin
  bhFreeSections;

  FSections.Free;
  FSections := nil;

  inherited Destroy;
end;

procedure TOvcButtonHeader.DoOnClick;
begin
  Invalidate;
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TOvcButtonHeader.DoOnSizing(ASection, AWidth : Integer);
begin
  if Assigned(FOnSizing) then
    FOnSizing(Self, ASection, AWidth);
end;

procedure TOvcButtonHeader.DoOnSized(ASection, AWidth : Integer);
begin
  if Assigned(FOnSized) then
    FOnSized(Self, ASection, AWidth);
end;

function TOvcButtonHeader.GetWidth(X : Integer) : Integer;
var
  I, W : Integer;
begin
  if X = FSections.Count - 1 then begin
    W := 0;
    for I := 0 to X - 1 do
      Inc(W, PHeaderSection(THeaderStrings(FSections).FList[I])^.Width);
    Result := ClientWidth - W;
  end else if (X >= 0) and (X < FSections.Count) then
    Result := PHeaderSection(THeaderStrings(FSections).FList[X])^.Width
  else
    Result := 0;
end;

procedure TOvcButtonHeader.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
var
  I : Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);

  if bhCanResize then
    if (Button = mbLeft) then
      SetCapture(Handle)
    else
  else
    if not (csDesigning in ComponentState) and (Button = mbLeft) then begin
      Y := 2;
      for I := 0 to FSections.Count - 1 do begin
        Inc(Y, PHeaderSection(THeaderStrings(FSections).FList[I])^.Width);
        if Y > X then
          Break;
      end;
      if I > FSections.Count - 1 then
        I := FSections.Count - 1;
      ItemIndex := I;
      Invalidate;
    end;
end;

procedure TOvcButtonHeader.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  I      : Integer;
  AbsPos : Integer;
  MinPos : Integer;
  MaxPos : Integer;
begin
  inherited MouseMove(Shift, X, Y);

  if (GetCapture = Handle) and bhCanResize then begin
    {absolute position of this item}
    AbsPos := 2;
    for I := 0 to bhResizeSection do
      Inc(AbsPos, PHeaderSection(THeaderStrings(FSections).FList[I])^.Width);

    if bhResizeSection > 0 then MinPos := AbsPos -
      PHeaderSection(THeaderStrings(FSections).FList[bhResizeSection])^.Width + 2
    else
      MinPos := 2;

    MaxPos := ClientWidth - 2;
    if X < MinPos then
      X := MinPos;
    if X > MaxPos then
      X := MaxPos;

    Dec(PHeaderSection(THeaderStrings(FSections).FList[bhResizeSection])^.Width,
      (AbsPos - X - 2) - bhMouseOffset);
    DoOnSizing(bhResizeSection,
      PHeaderSection(THeaderStrings(FSections).FList[bhResizeSection])^.Width);

    Refresh;
  end;
end;

procedure TOvcButtonHeader.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if bhCanResize then begin
    ReleaseCapture;
    DoOnSized(bhResizeSection,
      PHeaderSection(THeaderStrings(FSections).FList[bhResizeSection])^.Width);
    bhCanResize := False;
  end;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TOvcButtonHeader.Paint;
var
  I, Y, W : Integer;
  P       : array[0..255] of Char;
  R, R2   : TRect;
  WM, AL  : Word;
begin
  with Canvas do begin
    Font := Self.Font;
    Brush.Color := clBtnFace;
    I := 0;
    Y := (ClientHeight - Canvas.TextHeight('T')) div 2;
    R := Rect(0, 0, 0, ClientHeight);
    W := 0;
    repeat
      if I < FSections.Count then begin
        with PHeaderSection(THeaderStrings(FSections).FList[I])^ do begin
          W := Width;
          StrPLCopy(@P, Title, 255);
        end;
        Inc(I);
      end else
        StrPCopy(@P, '');
      R.Left := R.Right;
      Inc(R.Right, W);
      if (ClientWidth - R.Right < 2) or (I = FSections.Count) then
        R.Right := ClientWidth;

      if (FItemIndex = I-1) then begin
        Pen.Color := clBtnHighlight;
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Right - 1, R.Bottom - 1);
        LineTo(R.Right - 1, R.Top - 1);
        Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Bottom - 2);
        LineTo(R.Left, R.Top);
        LineTo(R.Right - 1, R.Top);
      end else begin
        Pen.Color := clBtnShadow;
        MoveTo(R.Left, R.Bottom - 1);
        LineTo(R.Right - 1, R.Bottom - 1);
        LineTo(R.Right - 1, R.Top - 1);
        Pen.Color := clBtnHighlight;
        MoveTo(R.Left, R.Bottom - 2);
        LineTo(R.Left, R.Top);
        LineTo(R.Right - 1, R.Top);
      end;

      TextRect(Rect(R.Left+1, R.Top+1, R.Right-1, R.Bottom-1), R.Left+3, Y, '');

      case FAlignment of
        taLeftJustify  : AL := DT_LEFT;
        taRightJustify : AL := DT_RIGHT;
        taCenter       : AL := DT_CENTER;
      else
        AL := 0;
      end;

      if FWordWrap then
        WM := DT_WORDBREAK
      else
        WM := DT_VCENTER or DT_SINGLELINE;

      R2 := Rect(R.Left+2, R.Top+1, R.Right-2, R.Bottom-1);
      if TextMargin < (R2.Right-R2.Left) div 2 then
        InflateRect(R2, -TextMargin, 0);
      DrawText(Handle, @P, StrLen(@P), R2, AL or WM);
    until R.Right = ClientWidth;
  end;
end;

procedure TOvcButtonHeader.SetAlignment(Value : TAlignment);
begin
  if (Value <> FAlignment) then begin
    FAlignment := Value;
    Refresh;
  end;
end;

procedure TOvcButtonHeader.SetBorderStyle(Value : TBorderStyle);
begin
  if (Value <> FBorderStyle) then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcButtonHeader.SetItemIndex(Value : Integer);
begin
  if (Value <> FItemIndex) and (Value < fSections.Count) then begin
    FItemIndex := Value;
    DoOnClick;
  end;
end;

procedure TOvcButtonHeader.SetSections(Strings : TStrings);
begin
  FSections.Assign(Strings);
end;

procedure TOvcButtonHeader.SetTextMargin(Value : Integer);
begin
  if (Value <> FTextMargin) and (Value >= 0) then begin
    FTextMargin := Value;
    Refresh;
  end;
end;

procedure TOvcButtonHeader.SetWidth(X : Integer; Value : Integer);
begin
  if (X < 0) then
    Exit;

  PHeaderSection(THeaderStrings(FSections).FList[X])^.Width := Value;
  Invalidate;
end;

procedure TOvcButtonHeader.SetWordWrap(Value : Boolean);
begin
  if (Value <> FWordWrap) then begin
    FWordWrap := Value;
    Refresh;
  end;
end;

procedure TOvcButtonHeader.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  inherited;

  bhHitTest := SmallPointToPoint(Msg.Pos);
end;

procedure TOvcButtonHeader.WMSetCursor(var Msg : TWMSetCursor);
var
  Cur : hCursor;
  I   : Integer;
  X   : Integer;
begin
  Cur := 0;
  bhResizeSection := 0;
  bhHitTest := ScreenToClient(bhHitTest);
  X := 2;
  if Msg.HitTest = HTCLIENT then
    for I := 0 to FSections.Count - 2 do begin { don't count last section }
      Inc(X, PHeaderSection(THeaderStrings(FSections).FList[I])^.Width);
      bhMouseOffset := X - (bhHitTest.X + 2);
      if Abs(bhMouseOffset) < 4 then begin
        Cur := LoadCursor(0, IDC_SIZEWE);
        bhResizeSection := I;
        Break;
      end;
    end;

  bhCanResize := (FAllowResize or (csDesigning in ComponentState)) and (Cur <> 0);
  if bhCanResize then
    SetCursor(Cur)
  else
    inherited;
end;



end.
