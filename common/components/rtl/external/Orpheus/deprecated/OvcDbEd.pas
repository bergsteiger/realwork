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
{*                   OVCDBED.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

{!!.12}  {removed 32K max restriction}

unit OvcDbEd;
  {-Data aware editor component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Db, DbConsts, DbCtrls, DbTables, Forms, Graphics,
  Menus, Messages, StdCtrls, SysUtils,
  OvcBase, OvcCaret, OvcCmd, OvcColor, OvcData, OvcEdit, OvcEditU,
  OvcFxFnt;

const
  dbedDefAutoUpdate = True;

type
  TOvcDbEditor = class(TOvcCustomEditor)
  {.Z+}
  protected
    {property variables}
    FAutoUpdate : Boolean;
    FDataLink   : TFieldDataLink;

    {internal variables}
    edUpdating  : Boolean;

    {property methods}
    function GetField : TField;
    function GetDataField : string;
    function GetDataSource : TDataSource;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);

    {internal methods}
    procedure eddbGetEditorValue;
    procedure eddbDataChange(Sender : TObject);
    procedure eddbEditingChange(Sender : TObject);
    procedure eddbSetEditorValue;
    procedure eddbUpdateData(Sender : TObject);

    {vcl methods}
    procedure CMEnter(var Msg : TMessage);
      message CM_ENTER;
    procedure CMExit(var Msg : TMessage);
      message CM_EXIT;
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

    {windows message methods}
    procedure WMChar(var Msg : TWMChar);
      message WM_CHAR;
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN    ;

    procedure CreateWnd;
      override;
    procedure edAddSampleParas;
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

    {virtual property methods}
    function GetReadOnly : Boolean;
      override;
      {-return the read-only status}
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

    procedure CutToClipboard;
      override;
      {-copy highlighted text to the clipboard and then delete it}
    procedure Redo;
      {-redo the last undone operation}
      override;
    function Replace(const S, R : string;
                     Options : TSearchOptionSet) : LongInt;
      {-search for a string and replace it with another string}
      override;
    procedure PasteFromClipboard;
      override;
      {-paste the contents of the clipboard}
    procedure Undo;
      {-undo the last change}
      override;

    property Field : TField
      read GetField;

  published
    property AutoUpdate : Boolean
      read FAutoUpdate
      write FAutoUpdate
      default dbedDefAutoUpdate;

    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property AutoIndent;
    property BorderStyle;
    property ByteLimit;
    property CaretIns;
    property CaretOvr;
    property FixedFont;
    property HideSelection;
    property HighlightColors;
    property InsertMode;
    property LeftMargin;
    property ParaLengthLimit;
    property ParaLimit;
    property ReadOnly;
    property RightMargin;
    property ScrollBars;
    property ScrollBarsAlways;
    property ScrollPastEnd;
    property ShowBookmarks;
    property TabSize;
    property TabType;
    property UndoBufferSize;
    property WantEnter;
    property WantTab;
    property WordWrap;
    property WrapAtLeft;
    property WrapColumn;
    property WrapToWindow;

    property OnError;
    property OnShowStatus;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D default edDefCtl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentColor default edDefParentColor;
    property ParentCtl3D default edDefParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default edDefTabStop;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
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
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation



{*** TOvcDbEditor ***}

procedure TOvcDbEditor.CMEnter(var Msg : TMessage);
begin
  FDataLink.Reset;

  inherited;
end;

procedure TOvcDbEditor.CMExit(var Msg : TMessage);
begin
  if Modified and AutoUpdate then
    try
      FDataLink.UpdateRecord;
    except
      SetFocus;
      raise;
    end;

  inherited;
end;

{$IFDEF Win32}
procedure TOvcDbEditor.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := LongInt(FDataLink);
end;
{$ENDIF}

constructor TOvcDbEditor.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  FAutoUpdate               := dbedDefAutoUpdate;
  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := eddbDataChange;
  FDataLink.OnEditingChange := eddbEditingChange;
  FDataLink.OnUpdateData    := eddbUpdateData;
end;

procedure TOvcDbEditor.CreateWnd;
begin
  inherited CreateWnd;

  if Field <> nil then
    eddbSetEditorValue;
end;

procedure TOvcDbEditor.CutToClipboard;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited CutToClipboard;
  {eddbGetEditorValue;}                                                {!!.12}
  FDataLink.Modified;                                                  {!!.13}
end;

destructor TOvcDbEditor.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

procedure TOvcDbEditor.edAddSampleParas;
begin
  {do nothing}
end;

procedure TOvcDbEditor.eddbDataChange(Sender : TObject);
begin
  if Showing then                                                      {!!.13}
    eddbSetEditorValue;                                                {!!.13}
end;

procedure TOvcDbEditor.eddbEditingChange(Sender : TObject);
begin
{}
end;

procedure TOvcDbEditor.eddbGetEditorValue;
var
  B     : TStream;
  I     : LongInt;
  Len   : Word;
  Para  : PChar;
  Count : LongInt;
  CrLf  : array[0..2] of Char;
begin
  HandleNeeded;
  StrCopy(Crlf, #13#10#0);
  if Field <> nil then begin
    if Field.DataType in [ftMemo, ftBlob {$IFDEF Win32}, ftFmtMemo {$ENDIF}] then begin
      {$IFDEF Version3}
      B := Field.DataSet.CreateBlobStream(TBlobField(Field), bmWrite);
      {$ELSE}
      B := TBlobStream.Create(TBlobField(Field), bmWrite);
      {$ENDIF}
      try
        Count := ParaCount;
        for I := 1 to Count do begin
          Para := GetPara(I, Len);
          B.Write(Para^, Len);
          if I <> Count then
            {end each paragraph with a crlf}
            B.Write(Crlf, 2)
          else if Len > 0 then
            {end last paragraph with crlf if it has length > 0}
            B.Write(Crlf, 2)
        end;
      finally
        B.Free;
      end;
    end;
  end;
end;

procedure TOvcDbEditor.eddbSetEditorValue;
const
  BufSize   = 4096;
var
  B         : TStream;
  HaveSel   : Boolean;
  C, C1, C2 : Integer;
  L, L1, L2 : LongInt;
  TL        : LongInt;
  Buf       : PChar;
  BytesRead : LongInt;
  Paras     : PChar;
  SaveUndo  : Integer;                                                 {!!.16}
begin
  HandleNeeded;
  SaveUndo := UndoBufferSize;                                          {!!.16}
  UndoBufferSize := 0; {disable undo}                                  {!!.16}
  if Field <> nil then begin
    if Field.DataType in [ftMemo, ftBlob {$IFDEF Win32}, ftFmtMemo {$ENDIF}] then begin
      {save current caret and selection status}
      HaveSel := GetSelection(L1, C1, L2, C2) and (FDataLink.Editing);
      L := GetCaretPosition(C);
      {save current top line}
      TL := TopLine;
      BeginUpdate;
      try
        DeleteAll(True);
        {if Field.Size > 0 then begin}                                 {!!.13}
        {$IFDEF Version3}
        B := Field.DataSet.CreateBlobStream(TBlobField(Field), bmRead);
        {$ELSE}
        B := TBlobStream.Create(TBlobField(Field), bmRead);
        {$ENDIF}
        try
          Buf := StrAlloc(BufSize+2);
          try
            B.Position :=0;
            repeat
              BytesRead := B.Read(Buf^, BufSize);
              Buf[BytesRead] := #0;
              edUpdating := True;
              try
                Insert(Buf);
              finally
                edUpdating := False;
              end;
            until BytesRead < BufSize;
          finally
            StrDispose(Buf);
          end;
        finally
          B.Free;
        end;
      {end;}                                                           {!!.13}
      finally
        EndUpdate;
      end;

      {reset top row}
      if TL <= LineCount then
        TopLine := TL
      else
        TopLine := 1;

      {set caret and highlight state}
      if HaveSel then
        SetSelection(L1, C1, L2, C2, (L > L1) or ((L = L1) and (C > C1)))
      else begin
        if (L <= LineCount) and (C <= LineLength[L]+1) then
          SetCaretPosition(L, C)
        else
          SetCaretPosition(1, 1);
      end;

    end else begin  {not a supported field}
      Paras := StrAlloc(256);
      try
        StrPCopy(Paras, Field.ClassName);
        StrLCat(Paras, ')', 255);
        Paras[0] := '(';
        SetText(Paras);
        SetCaretPosition(1, 1);
      finally
        StrDispose(Paras);
      end;
    end;
  end else
    inherited edAddSampleParas;

  Modified := False;                                                   {!!.12}
  UndoBufferSize := SaveUndo; {restore size}                           {!!.16}
end;

procedure TOvcDbEditor.eddbUpdateData(Sender : TObject);
begin
  eddbGetEditorValue;
end;

function TOvcDbEditor.GetReadOnly : Boolean;
  {-return read-only status}
begin
  if edUpdating then begin
    Result := False;
    Exit;
  end;

  if csDesigning in ComponentState then
    Result := inherited GetReadOnly
  else begin
    Result := inherited GetReadOnly or (DataSource = nil) or (not FDataLink.CanModify);
    if Field <> nil then
    if not (Field.DataType in [ftMemo, ftBlob {$IFDEF Win32}, ftFmtMemo {$ENDIF}]) then
      Result := True;
    if not Result then
      Result := not (DataSource.State in [dsEdit, dsInsert]);
  end;
end;

function TOvcDbEditor.GetField : TField;
begin
  Result := FDataLink.Field;
end;

function TOvcDbEditor.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbEditor.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

procedure TOvcDbEditor.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent = DataSource) then begin
    DataSource := nil;
    Refresh;
  end;
end;

procedure TOvcDbEditor.PasteFromClipboard;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited PasteFromClipboard;

  {eddbGetEditorValue;}                                                {!!.12}
  FDataLink.Modified;                                                  {!!.13}
end;

procedure TOvcDbEditor.Redo;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited Redo;

  {eddbGetEditorValue;}                                                {!!.12}
  FDataLink.Modified;                                                  {!!.13}
end;

function TOvcDbEditor.Replace(const S, R : string;
                              Options : TSearchOptionSet) : LongInt;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  Result := inherited Replace(S, R, Options);

  {eddbGetEditorValue;}                                                {!!.12}
  FDataLink.Modified;                                                  {!!.13}
end;

procedure TOvcDbEditor.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
  Refresh;
end;

procedure TOvcDbEditor.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  Refresh;
end;

procedure TOvcDbEditor.Undo;
begin
  if not FDataLink.Editing then
    {$IFDEF VERSION3}                                                  {!!.16}
    DatabaseError(SNotEditing);
    {$ELSE}
    DbError(SNotEditing);
    {$ENDIF}

  inherited Undo;

  {eddbGetEditorValue;}                                                {!!.12}
  FDataLink.Modified;                                                  {!!.13}
end;

procedure TOvcDbEditor.WMChar(var Msg : TWMChar);
begin
  with Msg do begin
    if (CharCode in [32..255]) and (Field <> nil) and
       not Field.IsValidChar(Char(Lo(CharCode))) then
      MessageBeep(0)
    else
      inherited;
  end;
end;

procedure TOvcDbEditor.WMKeyDown(var Msg : TWMKeyDown);
var                                                                    {!!.14}
  Shift  : Boolean;                                                    {!!.14}
  Insert : Boolean;                                                    {!!.14}

  procedure DoChange;
  begin
    if FDataLink.Editing then                                          {!!.11}
      FDataLink.Modified                                               {!!.11}
    else if (DataSource <> nil) and DataSource.AutoEdit then           {!!.11}
      if not inherited GetReadOnly then begin
        if FDataLink.Edit then
          FDataLink.Modified;
      end;
  end;
begin
  case Msg.CharCode of
    VK_ESCAPE,
    VK_NONE,
    VK_SHIFT,
    VK_CONTROL,
    VK_ALT,
    VK_CAPITAL,
    VK_NUMLOCK,
    VK_SCROLL,
    VK_HOME,
    VK_END,
    VK_UP,
    VK_DOWN,
    VK_LEFT,
    VK_RIGHT    : {};
    VK_TAB      : if WantTab or                                        {!!.13}
                    (GetAsyncKeyState(VK_CONTROL) and $8000 <> 0) then {!!.13}
                    DoChange;
    VK_RETURN   : if WantEnter then
                    DoChange;
  else
    {!!.14} {block revised}
    {special handling for <Ins> and <Shift><Ins> key sequences}
    Shift := (GetAsyncKeyState(VK_SHIFT) and $8000 <> 0);
    Insert := (Msg.CharCode = VK_INSERT);
    if not Insert or (Shift and Insert) then
      DoChange;
  end;

  inherited;
end;


end.