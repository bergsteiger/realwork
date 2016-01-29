{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}
{$R-} {Range-Checking}
{$S-} {Stack-Overflow Checking}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCEDITP.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcEditP;
  {-editor paragraph list and undo buffer classes}

interface

uses
  Controls, Forms, SysUtils,
  OvcData, OvcMisc, OvcEditN, OvcEditU;                                {!!.10}

{.Z+}
type
  TUndoBuffer = class;

  TParaList = class(TObject)
  public
    Owner      : TOvcEditBase; {original owner of this object}
    Head       : TParaNode;    {start of list}
    Tail       : TParaNode;    {end of list}
    LastNode   : TParaNode;    {last node found}
    LastP      : LongInt;      {last paragraph found}
    LastN      : LongInt;      {last line found}
    LastO      : Integer;      {lastO is line offset into LastNode for LastN}
    ParaCount  : LongInt;      {total number of paragraphs}
    ByteCount  : LongInt;      {total number of bytes}
    LineCount  : LongInt;      {total number of lines}
    MaxParas   : LongInt;      {max number of paragraphs}
    MaxBytes   : LongInt;      {max number of bytes}
    MaxParaLen : Integer;      {max paragraph length}
    WordWrap   : Boolean;      {if True, word wrap is on}
    WrapColumn : Integer;      {column for word wrap}
    TabSize    : Byte;         {size for tab stops}
    Modified   : Boolean;      {if True, text stream has been modified}
    FixMarkers : Boolean;      {should markers be adjusted yet?}
    Markers    : TMarkerArray; {position markers}
    UndoBuffer : TUndoBuffer;  {buffer of insertions/deletions}
    InUndo     : Boolean;      {are we in the Undo routine?}
    FLine      : LongInt;      {first changed line}
    LLine      : LongInt;      {last changed line}

    constructor Init(AOwner : TOvcEditBase; UndoSize : Word; Wrap : Boolean);
      virtual;
      {-initialize the paragraph list; POwner is original owner of list}
    destructor Destroy;
      override;
      {-destroy the paragraph list}

    {undo facility}
    procedure MakeUndoRec(UT : UndoType; P : LongInt; Pos : Integer;
                          S : PAnsiChar; Len : Word);
      {-create an undo record}
    procedure MakeReplaceUndoRec(P : LongInt; Pos : Integer;
                                 S : PAnsiChar; Len : Word;
                                 R : PAnsiChar; RLen : Word);
      {-create an undo record for a replace operation}
    procedure Undo(Editor : TOvcEditBase; var P : LongInt; var Pos : Integer);
      {-undo last insertion/deletion/replacement}
    procedure Redo(Editor : TOvcEditBase; var P : LongInt; var Pos : Integer);
      {-redo last undone operation}
    procedure SetUndoSize(Size : Word);
      {-set size of undo buffer}

    {adding and deleting nodes}
    procedure Insert(PPN : TParaNode);
      {-insert element PPN at beginning of list}
    procedure Append(PPN : TParaNode);
      {-add a node to the end of the list}
    procedure Place(PPN, LPN : TParaNode);
      {-place element PPN into list after existing element LPN}
    procedure PlaceBefore(PPN, LPN : TParaNode);
      {-place element PPN into list before existing element LPN}

    {finding lines/paragraphs}
    procedure SetLastNode(PPN : TParaNode; P, N : LongInt; O : Integer);
      {-set LastNode to PPN, LastP to P, LastN to N, LastO to O}
    function  NthPara(P : LongInt) : TParaNode;
      {-return pointer to Nth paragraph}
    function  NthLine(N : LongInt; var S : PAnsiChar; var Len : Word) : TParaNode;
      {-return pointer to Nth line and its length}
    function  FindParaByLine(N : LongInt; var LinePos : Integer) : LongInt;
      {-return the index of the paragraph containing line N}
    function  FindLineByPara(P : LongInt; Pos : Integer;
                             var Col : Integer) : LongInt;
      {-return the Line,Col corresponding to paragraph P, position Pos}

    {settings}
    procedure ResetPositionInfo;
      {-tell all editors to reset their position info}
    procedure Recalculate;
      {-recalculate number of lines}
    function  GetWrapColumn : Integer;
      {-get the column for word wrap}
    procedure SetWrapColumn(Value : Integer);
      {-set the column for word wrap}
    procedure SetTabSize(Value : Byte);
      {-set the tab size}
    procedure SetByteLimit(Value : LongInt);
      {-set limit on total bytes}
    procedure SetParaLimit(Value : LongInt);
      {-set limit on total paragraphs}
    procedure SetWordWrap(Value : Boolean);
      {-turn word wrap on or off}

    {effective columns to actual columns, etc.}
    function  ParaLength(Value : LongInt) : Integer;
      {-return length of paragraph P}
    function  LineLength(Value : LongInt) : Integer;
      {-return length of line N}
    function  EffStrLen(S : PAnsiChar; Len : Word) : Word;
      {-compute effective length of S}
    function  EffLen(N : LongInt) : Word;
      {-compute effective length of line N}
    function  EffCol(S : PAnsiChar; Len, Col : Word) : Word;
      {-compute effective column}
    function  ActualCol(S : PAnsiChar; Len, Col : Word) : Word;
      {-given an effective column #, return an actual column #}

    {inserting and deleting text}
    function  OkToInsert(P : LongInt; Paras, Bytes : Word) : Word;
      {-is it OK to insert Bytes characters into paragraph P?}
    function  AppendParaEof(S : PAnsiChar; SLen : Word; Trim : Boolean) : Word;
      {-create a new paragraph from S and append to end of file}
    procedure InsertParaNode(Editor : TOvcEditBase; P : LongInt; NPN : TParaNode);
      {-insert a new paragraph before paragraph P}
    function  InsertParaPrim(Editor : TOvcEditBase; P : LongInt;
                             S : PAnsiChar; Len : Word) : Word;
      {-create a new paragraph with text from S^ and insert before paragraph P}
    procedure PlaceParaNode(Editor : TOvcEditBase; P : LongInt; NPN : TParaNode);
      {-place a new paragraph after paragraph P}
    function PlaceParaPrim(Editor : TOvcEditBase; P : LongInt;
                           S : PAnsiChar; Len : Word) : Word;
      {-create a new paragraph with text from S^ and place it after paragraph P}
    function  InsertTextPrim(Editor : TOvcEditBase; P : LongInt; Pos : Integer;
                             S : PAnsiChar; SLen : Word) : Word;
      {-insert SLen characters from S^ in paragraph P at Pos}
    function  InsertBlock(Editor : TOvcEditBase; var P : LongInt;
                          var Pos : Integer; S : PAnsiChar) : Word;
      {-insert a block of text}
    procedure DeletePara(Editor : TOvcEditBase; P : LongInt);
      {-delete paragraph P}
    procedure DeleteText(Editor : TOvcEditBase; P : LongInt; Pos, Count : Integer);
      {-delete Count characters from paragraph P at Pos}
    procedure DeleteBlock(Editor : TOvcEditBase; Para1 : LongInt; Pos1 : Integer;
                          Para2 : LongInt; Pos2 : Integer);
      {-delete the block from Para1,Pos1 to Para2,Pos2}
    function  JoinWithNext(Editor : TOvcEditBase; P : LongInt; Pos : Integer) : Word;
      {-join paragraph P with the following paragraph at Pos}
    function  BreakPara(Editor : TOvcEditBase; P : LongInt; Pos, TabSz : Integer;
                        var Indent : Integer; Trim : Boolean) : Word;
      {-break paragraph P at Pos and indent the new paragraph}
    function  ReplaceText(Editor : TOvcEditBase; P : LongInt;
                          Pos, Count : Integer;
                          St : PAnsiChar; StLen : Integer) : Word;
      {-replace the next Count characters at P,Pos with text of St^}

    {text markers}
    procedure SetMarker(N : Byte; Para : LongInt; Pos : Integer);
    procedure SetMarkerAt(N : Byte; Line : LongInt; Col : Integer);
    procedure FixMarkerInsertedPara(var M : TMarker; N : LongInt; Pos, Indent : Integer);
    procedure FixMarkersInsertedPara(Editor : TOvcEditBase; N : LongInt; Pos, Indent : Integer);
    procedure FixMarkerInsertedText(var M : TMarker; N : LongInt; Pos, Count : Integer);
    procedure FixMarkersInsertedText(Editor : TOvcEditBase; N : LongInt; Pos, Count : Integer);
    procedure FixMarkDeletedPara(var M : TMarker; N : LongInt);
    procedure FixMarkerDeletedPara(var M : TMarker; N : LongInt);
    procedure FixMarkersDeletedPara(Editor : TOvcEditBase; N : LongInt);
    procedure FixMarkDeletedText(var M : TMarker; N : LongInt; Pos, Count : Integer);
    procedure FixMarkerDeletedText(var M : TMarker; N : LongInt; Pos, Count : Integer);
    procedure FixMarkersDeletedText(Editor : TOvcEditBase; N : LongInt; Pos, Count : Integer);
    procedure FixMarkerJoinedParas(var M : TMarker; N : LongInt; Pos : Integer);
    procedure FixMarkersJoinedParas(Editor : TOvcEditBase; N : LongInt; Pos : Integer);
  end;

  TUndoBuffer = class(TObject)
  public
    Owner    : TParaList;
    Buffer   : Pointer;   {pointer to the undo/redo buffer}
    BufSize  : Word;      {size of the undo/redo buffer}
    BufAvail : Word;      {free space in the buffer}
    Last     : PUndoRec;  {points to the last TUndoRec in the buffer}
    Undos    : Word;      {number of undo entries}
    Redos    : Word;      {number of redo entries}
    CurLink  : Byte;
    Linking  : Boolean;
    Error    : Boolean;
    GUN      : TUndoNode; {general undo node object}

    constructor Init(ParaList : TParaList; Size : Word);
      virtual;
    destructor Destroy;
      override;

    procedure Flush;
    function  CheckSize(Bytes : LongInt) : Boolean;
    function  SameOperation(UT : UndoType; var Before : Boolean; P : LongInt;
                            Pos : Integer; DLen : Word) : Boolean;
    procedure Append(D : PAnsiChar; DLen : Word);
    procedure Prepend(D : PAnsiChar; DLen : Word);
    procedure AppendReplace(D : PAnsiChar; DLen : Word; R : PAnsiChar; RLen : Word);
    procedure Push(UT : UndoType; MF : Boolean; P : LongInt; Pos : Integer;
                   D : PAnsiChar; DLen : Word);
    procedure PushReplace(MF : Boolean; P : LongInt; Pos : Integer;
                          D : PAnsiChar; DLen : Word;
                          R : PAnsiChar; RLen : Word);
    procedure GetUndo(var UT : UndoType; var Link : Byte; var MF : Boolean;
                      var P : LongInt; var Pos : Integer;
                      var D : PAnsiChar; var DLen : Word);
    procedure GetRedo(var UT : UndoType; var Link : Byte; var MF : Boolean;
                      var P : LongInt; var Pos : Integer;
                      var D : PAnsiChar; var DLen : Word);
    procedure PeekUndoLink(var Link : Byte);
    procedure PeekRedoLink(var Link : Byte);
    function  NthRec(N : Integer) : PUndoRec;
    procedure SetModified;
    procedure BeginComplexOp(var SaveLinking : Boolean);
    procedure EndComplexOp(SaveLinking : Boolean);
  end;
{.Z-}


implementation

uses
  OvcEdit;



{*** TParaList ***}

function TParaList.ActualCol(S : PAnsiChar; Len, Col : Word) : Word;
  {-given an effective column #, return an actual column #}
var
  ELen : Word;
  HT   : Boolean;
begin
  if (Col <= 1) or (Len = 0) then
    Result := Col
  else begin
    HT := edHaveTabs(S, Len);
    if HT then
      ELen := EffCol(S, Len, Len)
    else
      ELen := Len;
    if Col > ELen then
      Result := Len+(Col-ELen)
    else if HT then
      Result := edGetActualCol(S, Col, TabSize)
    else
      Result := Col;
  end;
end;

procedure TParaList.Append(PPN : TParaNode);
  {-add a node to the end of the list}
begin
  {Exit for bad input}
  if PPN = nil then
    Exit;
  PPN.Prev := Tail;
  PPN.Next := nil;
  if Head = nil then begin
    Head := PPN;
    Tail := PPN;
  end else begin
    Tail.Next := PPN;
    Tail := PPN;
  end;
  Inc(ParaCount);
end;

function TParaList.AppendParaEof(S : PAnsiChar; SLen : Word; Trim : Boolean) : Word;
  {-create a new paragraph from S and append to end of file}
var
  PPN : TParaNode;
begin
  PPN := TParaNode.InitLen(S, SLen, GetWrapColumn, TabSize);
  if PPN = nil then
    Result := oeOutOfMemory
  else begin
    PlaceBefore(PPN, Tail);
    SetLastNode(Head, 1, 1, 1);
    Inc(ByteCount, SLen+2);
    if Trim then
      Dec(ByteCount, PPN.TrimWhiteSpace);
    Inc(LineCount, PPN.LineCount);
    Result := 0;
  end;
end;

function TParaList.BreakPara(Editor : TOvcEditBase; P : LongInt;
                             Pos, TabSz : Integer; var Indent : Integer;
                             Trim : Boolean) : Word;
  {-break paragraph P at Pos and indent the new paragraph}
var
  PPN         : TParaNode;
  S, T        : PAnsiChar;
  Len, WC     : Word;
  Spaces      : Integer;
  Tabs        : Integer;
  SaveLinking : Boolean;
begin
  Result := 0;
  PPN := NthPara(P);
  if (PPN <> nil) then begin
    {When ScrollPastEnd is on Pos can be > Len+1, So, set}
    {Len to the end of the string during para break}
    Len := PPN.SLen;
    if Pos-1 > Len then
      Pos := Len+1;

    if (Pos = 1) then
      Result := InsertParaPrim(Editor, P, '', 0)
    else begin
      UndoBuffer.BeginComplexOp(SaveLinking);

      S := PPN.GetS;
      MakeUndoRec(utSavePos, P, Pos, S, 0);
      FixMarkers := False;

      {create the new paragraph and link it in after this one}
      T := @S[Pos-1];
      Result := PlaceParaPrim(Editor, P, T, StrLen(T));
      if Result <> 0 then begin
        UndoBuffer.EndComplexOp(SaveLinking);
        Exit;
      end;

      {delete any text we've broken off}
      if Pos <= Len then begin
        if Trim then
          WC := PPN.CountWhiteSpace(Pos-1)
        else
          WC := 0;
        DeleteText(Editor, P, Pos-WC, Succ(Len-(Pos-WC)));
      end;

      {do we need to indent?}
      if Indent <> 0 then begin
        if TabSz = 0 then begin
          Spaces := Indent;
          Tabs := 0;
        end else begin
          Tabs := Indent div TabSz;
          Spaces := Indent mod TabSz;
        end;
        Indent := Spaces+Tabs;

        GetMem(T, Indent+1);
        if T <> nil then begin
          FillChar(T[0], Tabs, ^I);
          FillChar(T[Tabs], Spaces, ' ');
          T[Indent] := #0;

          InsertTextPrim(Editor, P+1, 1, T, Indent);
        end else
          Indent := 0;
      end;

      MakeUndoRec(utSavePos, P+1, Indent+1, S, 0);
      FixMarkers := True;
      FixMarkersInsertedPara(Editor, P, Pos, Indent);
      UndoBuffer.EndComplexOp(SaveLinking);
    end;
  end;
end;

procedure TParaList.DeleteBlock(Editor : TOvcEditBase;
                                Para1 : LongInt; Pos1 : Integer;
                                Para2 : LongInt; Pos2 : Integer);
  {-delete the block from Para1,Pos1 to Para2,Pos2}
var
  P           : LongInt;
  I           : Integer;
  SaveLinking : Boolean;
begin
  UndoBuffer.BeginComplexOp(SaveLinking);
  if (Pos1 = 1) and (Pos2 = 1) then begin
    {these are whole paragraphs that need to be deleted}
    for I := Para2-1 downto Para1 do
      DeletePara(Editor, Para1);
  end else begin
    {delete text in 1st paragraph}
    I := Succ(ParaLength(Para1)-Pos1);
    if I > 0 then
      DeleteText(Editor, Para1, Pos1, I);

    {delete text in 2st paragraph}
    if Pos2 > 1 then
      DeleteText(Editor, Para2, 1, Pos2-1);

    {now scan and delete all intervening paragraphs}
    for P := Para2-1 downto Para1+1 do
      DeletePara(Editor, Para1+1);

    {splice}
    JoinWithNext(Editor, Para1, ParaLength(Para1)+1);
  end;
  UndoBuffer.EndComplexOp(SaveLinking);
end;

procedure TParaList.DeletePara(Editor : TOvcEditBase; P : LongInt);
  {-delete paragraph P}
var
  PPN : TParaNode;
begin
  PPN := NthPara(P);
  if not InUndo then
    MakeUndoRec(utDelPara, P, 1, @PPN, SizeOf(PPN));

  if P = 1 then
    SetLastNode(PPN.Next, 1, 1, 1)
  else
    SetLastNode(PPN.Prev, P-1, LastN-PPN.Prev.LineCount, 1);

  with PPN do begin
    {Fix pointers of surrounding nodes}
    if Next <> nil then
      Next.Prev := Prev;
    if Prev <> nil then
      Prev.Next := Next;
  end;

  {Fix head and tail of list}
  if Tail = PPN then
    Tail := Tail.Prev;
  if Head = PPN then
    Head := Head.Next;

  {adjust counters}
  Dec(ParaCount);
  Dec(LineCount, PPN.LineCount);
  Dec(ByteCount, PPN.SLen+2);

  {dispose of the node if we didn't create an undo record}
  if not InUndo then
    if UndoBuffer.Error then
      PPN.Free;

  FixMarkersDeletedPara(Editor, P);
  Modified := True;
end;

procedure TParaList.DeleteText(Editor : TOvcEditBase; P : LongInt;
                               Pos, Count : Integer);
  {-delete Count characters from paragraph P at Pos}
var
  PPN    : TParaNode;
  LC     : LongInt;
  FL, LL : Integer;
begin
  PPN := NthPara(P);

  {make sure that we have at least this many characters to delete}
  if Count + Pos-1 > PPN.SLen then
    Count := PPN.SLen-Pos+1;
  if (Count < 0) or (PPN.S = nil) then
    Count := 0;

  LC := PPN.LineCount;
  MakeUndoRec(utDelete, P, Pos, @PPN.S[Pos-1], Count);
  PPN.DeleteText(Pos, Count, GetWrapColumn, TabSize, FL, LL);
  Dec(ByteCount, Count);
  Dec(LineCount, LC-PPN.LineCount);
  FLine := Pred(LastN)+FL;
  if PPN.LineCount <> LC then
    LLine := MaxLongInt
  else
    LLine := Pred(LastN)+LL;
  FixMarkersDeletedText(Editor, P, Pos, Count);
  Modified := True;
end;

destructor TParaList.Destroy;
  {-destroy the paragraph list}
var
  N, P : TParaNode;
begin
  UndoBuffer.Free;
  N := Tail;
  while N <> nil do begin
    {Get pointer to previous node}
    P := N.Prev;
    N.Free;
    N := P;
  end;
end;

function TParaList.EffCol(S : PAnsiChar; Len, Col : Word) : Word;
  {-compute effective column}
begin
  if (Col <= 1) or (Len = 0) then
    if Col = 0 then
      Result := 1
    else
      Result := Col
  else if Col > Len then
    Result := EffStrLen(S, Len)+(Col-Len)
  else
    Result := EffStrLen(S, Col-1)+1;
end;

function TParaList.EffLen(N : LongInt) : Word;
  {-compute effective length of line N}
var
  S   : PAnsiChar;
  Len : Word;
begin
  NthLine(N, S, Len);
  Result := EffStrLen(S, Len);
end;

function TParaList.EffStrLen(S : PAnsiChar; Len : Word) : Word;
  {-compute effective length of S}
begin
  if (Len > 0) and edHaveTabs(S, Len) then
    Result := edEffectiveLen(S, Len, TabSize)
  else
    Result := Len;
end;

function TParaList.FindLineByPara(P : LongInt; Pos : Integer;
                                  var Col : Integer) : LongInt;
  {-return the Line,Col corresponding to paragraph P, position Pos}
var
  PPN : TParaNode;
begin
  if P > ParaCount then
    P := ParaCount;
  if P < 1 then
    P := 1;
  PPN := NthPara(P);
  Result := LastN+PPN.PosToLine(Pos, Col)-1
end;

function TParaList.FindParaByLine(N : LongInt; var LinePos : Integer) : LongInt;
  {-return the index of the paragraph containing line N}
var
  PPN  : TParaNode;
  S, T : PAnsiChar;
  Len  : Word;
begin
  if not WordWrap then begin
    LinePos := 0;
    Result := N;
  end else begin
    PPN := NthLine(N, S, Len);
    T := PPN.GetS;
    LinePos := PtrDiff(S, T);                                          {!!.10}
    Result := LastP;
  end;
end;

procedure TParaList.FixMarkDeletedPara(var M : TMarker; N : LongInt);
begin
  if M.Para = N then
    M.Pos := 1
  else if M.Para > N then
    Dec(M.Para);
  if M.Para > ParaCount then
    M.Para := ParaCount;
end;

procedure TParaList.FixMarkDeletedText(var M : TMarker; N : LongInt;
                                       Pos, Count : Integer);
begin
  if M.Para = N then
    if M.Pos >= Pos then
      if M.Pos < Pos+Count then
        M.Pos := Pos
      else
        Dec(M.Pos, Count);
end;

procedure TParaList.FixMarkerDeletedPara(var M : TMarker; N : LongInt);
begin
  if M.Para = N then
    FillChar(M, SizeOf(TMarker), 0)
  else if M.Para > N then
    Dec(M.Para);
end;

procedure TParaList.FixMarkerDeletedText(var M : TMarker; N : LongInt;
                                         Pos, Count : Integer);
begin
  if M.Para = N then
    if M.Pos >= Pos then
      if M.Pos < Pos+Count then
        FillChar(M, SizeOf(TMarker), 0)
      else
        Dec(M.Pos, Count);
end;

procedure TParaList.FixMarkerInsertedPara(var M : TMarker; N : LongInt;
                                          Pos, Indent : Integer);
begin
  if M.Para > N then
    Inc(M.Para)
  else if M.Para = N then
    if M.Pos >= Pos then begin
      Inc(M.Para);
      Inc(M.Pos, Indent-Pred(Pos));
    end;
end;

procedure TParaList.FixMarkerInsertedText(var M : TMarker; N : LongInt;
                                          Pos, Count : Integer);
begin
  if (M.Para = N) and (M.Pos >= Pos) then
    Inc(M.Pos, Count);
end;

procedure TParaList.FixMarkerJoinedParas(var M : TMarker; N : LongInt; Pos : Integer);
begin
  if M.Para > N then
    if M.Para = N+1 then begin
      Dec(M.Para);
      Inc(M.Pos, Pred(Pos));
    end else
      Dec(M.Para);
end;

procedure TParaList.FixMarkersDeletedPara(Editor : TOvcEditBase; N : LongInt);
var
  I : Integer;
begin
  if FixMarkers then begin
    for I := 0 to MaxMarkers-1 do
      FixMarkerDeletedPara(Markers[I], N);
    TOvcCustomEditor(Editor).edUpdateOnDeletedPara(N);
  end;
end;

procedure TParaList.FixMarkersDeletedText(Editor : TOvcEditBase; N : LongInt;
                                          Pos, Count : Integer);
var
  I : Integer;
begin
  if FixMarkers then begin
    for I := 0 to MaxMarkers-1 do
      FixMarkerDeletedText(Markers[I], N, Pos, Count);
    TOvcCustomEditor(Editor).edUpdateOnDeletedText(N, Pos, Count);
  end;
end;

procedure TParaList.FixMarkersInsertedPara(Editor : TOvcEditBase; N : LongInt;
                                           Pos, Indent : Integer);
var
  I : Integer;
begin
  if FixMarkers then begin
    for I := 0 to MaxMarkers-1 do
      FixMarkerInsertedPara(Markers[I], N, Pos, Indent);
    TOvcCustomEditor(Editor).edUpdateOnInsertedPara(N, Pos, Indent);
  end;
end;

procedure TParaList.FixMarkersInsertedText(Editor : TOvcEditBase; N : LongInt;
                                           Pos, Count : Integer);
var
  I : Integer;
begin
  if FixMarkers then begin
    for I := 0 to MaxMarkers-1 do
      FixMarkerInsertedText(Markers[I], N, Pos, Count);
    TOvcCustomEditor(Editor).edUpdateOnInsertedText(N, Pos, Count);
  end;
end;

procedure TParaList.FixMarkersJoinedParas(Editor : TOvcEditBase; N : LongInt;
                                          Pos : Integer);
var
  I : Integer;
begin
  if FixMarkers then begin
    for I := 0 to MaxMarkers-1 do
      FixMarkerJoinedParas(Markers[I], N, Pos);
    TOvcCustomEditor(Editor).edUpdateOnJoinedParas(N, Pos);
  end;
end;

function TParaList.GetWrapColumn : Integer;
  {-get the wrap column}
begin
  if WordWrap then
    Result := WrapColumn
  else
    Result := High(SmallInt);
end;

constructor TParaList.Init(AOwner : TOvcEditBase; UndoSize : Word; Wrap : Boolean);
  {-initialize the paragraph list; POwner is original owner of list}
var
  PPN : TParaNode;
begin
  inherited Create;

  Owner := AOwner;
  Head := nil;
  Tail := nil;
  ParaCount := 0;
  LineCount := 1;
  ByteCount := 0;
  MaxParas := edDefParaLimit;
  MaxBytes := edDefMaxBytes;
  MaxParaLen := edDefParaLengthLimit;
  WordWrap := Wrap;
  WrapColumn := edDefWrapColumn;
  TabSize := 8;
  Modified := False;
  FixMarkers := True;
  PPN := TParaNode.InitLen('', 0, 0, TabSize);
  Append(PPN);
  SetLastNode(PPN, 1, 1, 1);
  FillChar(Markers, SizeOf(Markers), 0);
  UndoBuffer := TUndoBuffer.Init(@Self, UndoSize);
  InUndo := False;
end;

procedure TParaList.Insert(PPN : TParaNode);
  {-insert element PPN at beginning of list}
begin
  {Exit for bad input}
  if (PPN = nil) then
    Exit;
  PPN.Prev := nil;
  PPN.Next := Head;
  if Head = nil then
    {Special case for first node}
    Tail := PPN
  else
    {Add at start of existing list}
    Head.Prev := PPN;
  Head := PPN;
  Inc(ParaCount);
end;

function TParaList.InsertBlock(Editor : TOvcEditBase; var P : LongInt;
                               var Pos : Integer; S : PAnsiChar) : Word;
  {-insert a block of text}
var
  L, Len, Max : Word;
  I, OPos : Integer;
  SaveLinking : Boolean;
  OP : LongInt;
begin
  Max := StrLen(S);
  Len := edScanToEnd(S, Max);
  L := Len;
  while (L > 0) and ((S[L-1] = ^M) or (S[L-1] = ^J)) do
    Dec(L);
  if (Len = Max) and (L = Len) then begin
    Result := InsertTextPrim(Editor, P, Pos, S, Len);
    if Result = 0 then
      Inc(Pos, Len);
  end else begin
    OP := P;
    OPos := Pos;
    Result := 0;
    I := 0;
    UndoBuffer.BeginComplexOp(SaveLinking);
    while (Result = 0) and (S^ <> #0) do begin
      if (Len > L) and (Pos = 1) then
        Result := InsertParaPrim(Editor, P, S, L)
      else begin
        if L <> 0 then begin
          Result := InsertTextPrim(Editor, P, Pos, S, L);
          if Result = 0 then
            Inc(Pos, L);
        end;
        if (Result = 0) and (Len > L) then
          Result := BreakPara(Editor, P, Pos, 0, I, True);
      end;
      if (Result = 0) and (Len > L) then begin
        Inc(P);
        Pos := 1;
      end;
      if (Result = 0) then begin
        Inc(S, Len);
        Dec(Max, Len);
      end;
      if S^ <> #0 then begin
        Len := edScanToEnd(S, Max);
        L := Len;
        while (L > 0) and ((S[L-1] = ^M) or (S[L-1] = ^J)) do
          Dec(L);
      end;
    end;
    UndoBuffer.EndComplexOp(SaveLinking);
    FLine := FindLineByPara(OP, OPos, I);
    if FLine > 1 then
      Dec(FLine);
    LLine := MaxLongInt;
  end;
end;

procedure TParaList.InsertParaNode(Editor : TOvcEditBase; P : LongInt;
                                   NPN : TParaNode);
  {-insert a new paragraph before paragraph N}
var
  PPN : TParaNode;
begin
  PPN := NthPara(P);
  Inc(ByteCount, NPN.SLen+2);
  NPN.Recalc(GetWrapColumn, TabSize);
  Inc(LineCount, NPN.LineCount);
  if PPN = nil then
    Append(NPN)
  else
    PlaceBefore(NPN, PPN);
  SetLastNode(NPN, P, LastN, 1);
  FixMarkersInsertedPara(Editor, P, 1, 0);
  Modified := True;
end;

function TParaList.InsertParaPrim(Editor : TOvcEditBase; P : LongInt;
                                  S : PAnsiChar; Len : Word) : Word;
  {-create a new paragraph with text from S^ and insert before paragraph P}
var
  PPN, NPN : TParaNode;
  Res : Word;
begin
  Result := 0;
  PPN := NthPara(P);
  if PPN = nil then
    Exit;
  Res := OkToInsert(0, 1, Len+2);
  if Res = 0 then begin
    NPN := TParaNode.InitLen(S, Len, GetWrapColumn, TabSize);
    if NPN = nil then
      Result := oeOutOfMemory
    else begin
      MakeUndoRec(utInsPara, P, 1, @NPN, SizeOf(NPN));
      InsertParaNode(Editor, P, NPN);
    end;
  end else
    Result := Res;
end;

function TParaList.InsertTextPrim(Editor : TOvcEditBase; P : LongInt; Pos : Integer;
                                  S : PAnsiChar; SLen : Word) : Word;
  {-insert SLen characters from S^ in paragraph P at Pos}
var
  PPN   : TParaNode;
  I     : Word;
  OLen  : Word;
  NLen  : Word;
  Delta : Word;
  NS    : PAnsiChar;
  LC    : LongInt;
  FL    : Integer;
  LL    : Integer;
begin
  Result := 0;                                                         {!!.10}
  PPN := NthPara(P);
  if PPN = nil then
    Exit;
  OLen := PPN.SLen;
  LC := PPN.LineCount;
  I := OkToInsert(P, 0, SLen);
  if I = 0 then
    I := PPN.InsertTextPrim(S, SLen, Pos, GetWrapColumn, TabSize, FL, LL);
  if I = 0 then begin
    NS := PPN.GetS;
    NLen := PPN.SLen;
    Delta := (NLen-OLen)-SLen;
    if Delta > 0 then
      MakeUndoRec(utInsert, P, Pos-Delta, @NS[OLen], Delta+SLen)
    else
      MakeUndoRec(utInsert, P, Pos, S, SLen);
    Inc(ByteCount, NLen-OLen);
    Inc(LineCount, PPN.LineCount-LC);
    FLine := Pred(LastN)+FL;
    if PPN.LineCount <> LC then
      LLine := MaxLongInt
    else
      LLine := Pred(LastN)+LL;
    FixMarkersInsertedText(Editor, P, Pos, SLen);
    Modified := True;
  end;
  Result := I;
end;

function TParaList.JoinWithNext(Editor : TOvcEditBase; P : LongInt; Pos : Integer) : Word;
  {-join paragraph P with the following paragraph at Pos}
var
  PPN         : TParaNode;
  NPN         : TParaNode;
  S           : PAnsiChar;
  SLen        : Word;
  D           : Word;
  SaveLinking : Boolean;
begin
  Result := 0;

  PPN := NthPara(P);
  if (PPN = nil) or (PPN.Next = nil) then
    Exit;

  UndoBuffer.BeginComplexOp(SaveLinking);

  if (Pos = 1) then begin
    FixMarkers := False;
    DeletePara(Editor, P);
    FixMarkers := True;
    FixMarkersJoinedParas(Editor, P, Pos);
  end else begin
    NPN := PPN.Next;
    S := NPN.GetS;
    SLen := NPN.SLen;
    D := Pred(Pos)-ParaLength(P);
    Result := OkToInsert(P, 0, SLen+D);
    if Result <> 0 then
      Result := oeCannotJoin
    else begin
      FixMarkers := False;
      if SLen > 0 then
        Result := InsertTextPrim(Editor, P, Pos, S, SLen);
      if Result = 0 then
        DeletePara(Editor, P+1);
      FixMarkers := True;
      MakeUndoRec(utSavePos, P, Pos, S, 0);
      if Result = 0 then
        FixMarkersJoinedParas(Editor, P, Pos);
    end;
  end;

  UndoBuffer.EndComplexOp(SaveLinking);
end;

function TParaList.LineLength(Value : LongInt) : Integer;
  {-return length of line N}
var
  S : PAnsiChar;
  W : Word;
begin
  NthLine(Value, S, W);
  Result := W;
end;

procedure TParaList.MakeReplaceUndoRec(P : LongInt; Pos : Integer;
                                       S : PAnsiChar; Len : Word;
                                       R : PAnsiChar; RLen : Word);
  {-create an undo record for a replace operation}
begin
  if not InUndo then
    UndoBuffer.PushReplace(Modified, P, Pos, S, Len, R, RLen);
end;

procedure TParaList.MakeUndoRec(UT : UndoType; P : LongInt; Pos : Integer;
                                S : PAnsiChar; Len : Word);
  {-create an undo record}
begin
  if not InUndo then
    UndoBuffer.Push(UT, Modified, P, Pos, S, Len);
end;

function TParaList.NthLine(N : LongInt; var S : PAnsiChar;
                           var Len : Word) : TParaNode;
  {-return pointer to Nth line and its length}
var
  I   : LongInt;
  P   : LongInt;
  O   : Integer;
  PPN : TParaNode;
  DF  : LongInt;
  DL  : LongInt;
  DE  : LongInt;
begin
  if not WordWrap then begin
    PPN := NthPara(N);
    if PPN = nil then begin                                            {!!.10}
      S := '';                                                         {!!.10}
      Len := 0;                                                        {!!.10}
      Result := nil;                                                   {!!.10}
      Exit;                                                            {!!.10}
    end;                                                               {!!.10}
    S := PPN.GetS;
    Len := PPN.SLen;
    Result := PPN;
    Exit;
  end;

  if N = LastN then begin
    S := LastNode.NthLine(LastO, Len);
    Result := LastNode;
  end else if N = 1 then begin
    S := Head.NthLine(1, Len);
    SetLastNode(Head, 1, 1, 1);
    Result := Head;
  end else if N = LineCount then begin
    S := Tail.NthLine(Tail.LineCount, Len);
    SetLastNode(Tail, ParaCount, N, Tail.LineCount);
    Result := Tail;
  end else begin
    {is it the next line after the last one we found?}
    if N = LastN+1 then begin
      if LastO < LastNode.LineCount then begin
        PPN := LastNode;
        P := LastP;
        O := LastO+1;
      end else begin
        PPN := LastNode.Next;
        P := LastP+1;
        O := 1;
      end;
    end else if N = LastN-1 then begin
      {the line before the last one we found?}
      if LastO > 1 then begin
        PPN := LastNode;
        P := LastP;
        O := LastO-1;
      end else begin
        PPN := LastNode.Prev;
        P := LastP-1;
        O := PPN.LineCount;
      end;
    end else begin  {we need to search}
      DF := N-1;
      DL := Abs(N-LastN);
      DE := LineCount-N;

      {is it closest to the first line?}
      if (DF <= DL) and (DF <= DE) then begin
        PPN := Head;
        P := 1;
        I := 1;
      end else if (DE <= DL) then begin
        {closest to the last line?}
        PPN := Tail;
        P := ParaCount;
        I := LineCount-Pred(PPN.LineCount);
      end else begin
        {closest to the last known line}
        PPN := LastNode;
        P := LastP;
        I := LastN-Pred(LastO);
      end;

      {go backward if we're too far}
      while I > N do begin
        PPN := PPN.Prev;
        Dec(P);
        Dec(I, PPN.LineCount);
      end;

      {go forward if we're not far enough}
      while (I+PPN.LineCount <= N) do begin
        Inc(I, PPN.LineCount);
        Inc(P);
        {stop if at the end of the text stream}
        if PPN.Next = nil then                                         {!!.10}
          Break;                                                       {!!.10}
        PPN := PPN.Next;
      end;

      O := Succ(N-I);
    end;

    {we found the line}
    SetLastNode(PPN, P, N, O);
    S := PPN.NthLine(O, Len);
    Result := PPN;
  end;
end;

function TParaList.NthPara(P : LongInt) : TParaNode;
  {-return pointer to Pth paragraph}
var
  I   : LongInt;
  N   : LongInt;
  PPN : TParaNode;
  DF  : LongInt;
  DL  : LongInt;
  DE  : LongInt;
begin
  if (P < 1) or (P > ParaCount) then begin
    Result := nil;
    Exit;
  end;

  Dec(LastN, Pred(LastO));
  LastO := 1;
  if P = LastP then
    Result := LastNode
  else if P = 1 then begin
    SetLastNode(Head, 1, 1, 1);
    Result := Head;
  end else if P = ParaCount then begin
    SetLastNode(Tail, P, LineCount-Pred(Tail.LineCount), 1);
    Result := Tail;
  end else begin
    if P = LastP+1 then begin
      N := LastN+LastNode.LineCount;
      PPN := LastNode.Next;
    end else if P = LastP-1 then begin
      PPN := LastNode.Prev;
      N := LastN-PPN.LineCount;
    end else begin
      DF := P-1;
      DL := Abs(P-LastP);
      DE := ParaCount-P;

      {is it closest to the first paragraph?}
      if (DF <= DL) and (DF <= DE) then begin
        PPN := Head;
        I := 1;
        N := 1;
      end else if (DE <= DL) then begin
        {closest to the last paragraph?}
        PPN := Tail;
        I := ParaCount;
        N := LineCount-Pred(PPN.LineCount);
      end else if (P > LastP) then begin
        {after the last known paragraph?}
        I := LastP;
        PPN := LastNode;
        N := LastN;
      end else begin
        {before the last known paragraph?}
        I := LastP;
        PPN := LastNode;
        N := LastN;
      end;

      {go backward as necessary}
      while (I > P) and (PPN <> nil) do begin
        PPN := PPN.Prev;
        Dec(N, PPN.LineCount);
        Dec(I);
      end;

      {go forward as necessary}
      while (I < P) and (PPN <> nil) do begin
        Inc(N, PPN.LineCount);
        PPN := PPN.Next;
        Inc(I);
      end;
    end;

    if PPN <> nil then
      SetLastNode(PPN, P, N, 1);
    Result := PPN;
  end;
end;

function TParaList.OkToInsert(P : LongInt; Paras, Bytes : Word) : Word;
  {-is it OK to insert Bytes characters into paragraph P?}
var
  PPN : TParaNode;
  M   : LongInt;
begin
  Result := 0;

  {check for too many paragraphs}
  if (Paras <> 0) or (P > MaxParas) then begin
    if (P > MaxParas) or (ParaLength(ParaCount) <> 0) then
      M := MaxParas
    else if MaxParas = MaxLongInt then
      M := MaxLongInt
    else
      M := MaxParas+1;
    if (ParaCount+Paras > M) then begin
      Result := oeTooManyParas;
      Exit;
    end;
  end;

  {check for too many total bytes}
  if ByteCount+Bytes > MaxBytes then begin
    Result := oeTooManyBytes;
    Exit;
  end;

  {check for paragraph too long}
  if (P <> 0) and (Paras = 0) then begin
    PPN := NthPara(P);
    if PPN <> nil then
      if LongInt(Bytes)+PPN.SLen > MaxParaLen then
        Result := oeParaTooLong;
  end;
end;

function TParaList.ParaLength(Value : LongInt) : Integer;
  {-return length of paragraph}
var
  PPN : TParaNode;
begin
  PPN := NthPara(Value);
  if PPN = nil then
    Result := 0
  else
    Result := PPN.SLen;
end;

procedure TParaList.Place(PPN, LPN : TParaNode);
  {-place element PPN into list after existing element LPN}
begin
  {Exit for bad input}
  if (PPN = nil) or (PPN = LPN) then
    Exit;
  if LPN = nil then
    Insert(PPN)
  else if LPN = Tail then
    Append(PPN)
  else begin
    PPN.Prev := LPN;
    PPN.Next := LPN.Next;
    LPN.Next.Prev := PPN;
    LPN.Next := PPN;
    Inc(ParaCount);
  end;
end;

procedure TParaList.PlaceBefore(PPN, LPN : TParaNode);
  {-place element PPN into list before existing element LPN}
begin
  {Exit for bad input}
  if (PPN = nil) or (PPN = LPN) then
    Exit;
  if (LPN = nil) or (LPN = Head) then
    {Place the new element at the start of the list}
    Insert(PPN)
  else begin
    {Patch in the new element}
    PPN.Next := LPN;
    PPN.Prev := LPN.Prev;
    LPN.Prev.Next := PPN;
    LPN.Prev := PPN;
    Inc(ParaCount);
  end;
end;

procedure TParaList.PlaceParaNode(Editor : TOvcEditBase; P : LongInt;
                                  NPN : TParaNode);
  {-place a new paragraph after paragraph P}
var
  PPN : TParaNode;
begin
  PPN := NthPara(P);
  if PPN = nil then
    Exit;

  Inc(ByteCount, NPN.SLen+2);
  NPN.Recalc(GetWrapColumn, TabSize);
  Inc(LineCount, NPN.LineCount);
  Place(NPN, PPN);
  FixMarkersInsertedPara(Editor, P+1, 1, 0);

  Modified := True;
end;

function TParaList.PlaceParaPrim(Editor : TOvcEditBase; P : LongInt;
                                 S : PAnsiChar; Len : Word) : Word;
  {-create a new paragraph with text from S^ and place it after paragraph P}
var
  PPN : TParaNode;
  NPN : TParaNode;
begin
  Result := 0;
  PPN := NthPara(P);
  if PPN = nil then
    Exit;
  NPN := TParaNode.InitLen(S, Len, GetWrapColumn, TabSize);
  if NPN = nil then
    Result := oeOutOfMemory
  else begin
    MakeUndoRec(utPlacePara, P, 1, @NPN, SizeOf(NPN));
    PlaceParaNode(Editor, P, NPN);
  end;
end;

procedure TParaList.Recalculate;
  {-recalculate number of lines}
var
  PPN : TParaNode;
  LC  : LongInt;
  WC  : Integer;
begin
  {switch cursors if this is going to take a while}
  if ByteCount > 10000 then
    Screen.Cursor := crHourGlass;
  try
    {recalculate the total number of lines}
    WC := GetWrapColumn;
    LC := 0;
    PPN := Head;
    while PPN <> nil do begin
      PPN.Recalc(WC, TabSize);
      Inc(LC, PPN.LineCount);
      PPN := PPN.Next;
    end;
    LineCount := LC;
    SetLastNode(Head, 1, 1, 1);
  finally
    {restore cursor}
    if ByteCount > 10000 then
      Screen.Cursor := crDefault;
  end;
end;

procedure TParaList.Redo(Editor : TOvcEditBase; var P : LongInt; var Pos : Integer);
  {-redo last undone operation}
var
  UT       : UndoType;
  D        : PAnsiChar;
  S        : PAnsiChar;
  DLen     : Word;
  OrigLink : Byte;
  Link     : Byte;
  PPPN     : ^TParaNode absolute D;
begin
  InUndo := True;
  UndoBuffer.PeekRedoLink(OrigLink);
  repeat
    UndoBuffer.GetRedo(UT, Link, Modified, P, Pos, D, DLen);
    case UT of
      utInsert :
        begin
          InsertTextPrim(Editor, P, Pos, D, DLen);
          Inc(Pos, DLen);
        end;
      utInsPara :
        begin
          InsertParaNode(Editor, P, PPPN^);
          Inc(P);
          Pos := 1;
        end;
      utPlacePara :
        begin
          PlaceParaNode(Editor, P, PPPN^);
          Inc(P);
          Pos := 1;
        end;
      utDelete :
        DeleteText(Editor, P, Pos, DLen);
      utDelPara :
        DeletePara(Editor, P);
      utReplace :
        begin
          S := D;
          Inc(S, StrLen(S)+1);
          ReplaceText(Editor, P, Pos, StrLen(D), S, StrLen(S));
          Inc(Pos, StrLen(S));
        end;
    end;
    UndoBuffer.PeekRedoLink(Link);
  until (Link <> OrigLink);
  InUndo := False;
end;

function TParaList.ReplaceText(Editor : TOvcEditBase; P : LongInt;
                               Pos, Count : Integer;
                               St : PAnsiChar; StLen : Integer) : Word;
  {-replace the next Count characters at P,Pos with text of St^}
var
  S     : PAnsiChar;
  PPN   : TParaNode;
  LC    : LongInt;
  FL    : Integer;
  LL    : Integer;
  Delta : Integer;
begin
  Result := 0;                                                         {!!.10}
  PPN := NthPara(P);
  if PPN = nil then
    Exit;

  S := PPN.GetS;
  LC := PPN.LineCount;

  {create undo record}
  MakeReplaceUndoRec(P, Pos, @S[Pos-1], Count, St, StLen);

  {make the replacement}
  Delta := StLen-Count;
  Result := PPN.ReplaceText(Pos, Count, GetWrapColumn,
                            TabSize, St, StLen, FL, LL);
  {adjust text markers and line,byte count}
  if Result = 0 then begin
    Modified := True;
    Inc(LineCount, PPN.LineCount-LC);
    Inc(ByteCount, StLen-Count);

    FLine := Pred(LastN)+FL;
    if PPN.LineCount <> LC then
      LLine := MaxLongInt
    else
      LLine := Pred(LastN)+LL;

    if Delta = 0 then
      FixMarkersInsertedText(Editor, P, Pos, 0)
    else if Delta > 0 then
      FixMarkersInsertedText(Editor, P, Pos+Count, Delta)
    else
      FixMarkersDeletedText(Editor, P, Pos+Count, -Delta);
  end;
end;

procedure TParaList.ResetPositionInfo;
  {-tell all editors to reset their position info}
var
  PE, SE : TOvcCustomEditor;
begin
  PE := TOvcCustomEditor(Owner);
  SE := PE;
  repeat
    PE.edResetPositionInfo;
    PE := PE.edNext;
  until PE = SE;
end;

procedure TParaList.SetByteLimit(Value : LongInt);
  {-set limit on total bytes}
begin
  MaxBytes := Value;
end;

procedure TParaList.SetLastNode(PPN : TParaNode; P, N : LongInt; O : Integer);
  {-set LastNode to PPN, LastP to P}
begin
  LastNode := PPN;
  LastP := P;
  LastN := N;
  LastO := O;
end;

procedure TParaList.SetMarker(N : Byte; Para : LongInt; Pos : Integer);
begin
  if N < MaxMarkers then begin
    Markers[N].Para := Para;
    Markers[N].Pos := Pos;
  end;
end;

procedure TParaList.SetMarkerAt(N : Byte; Line : LongInt; Col : Integer);
var
  Para    : LongInt;
  LinePos : Integer;
begin
  if N < MaxMarkers then begin
    Para := FindParaByLine(Line, LinePos);
    SetMarker(N, Para, LinePos+Col);
  end;
end;

procedure TParaList.SetParaLimit(Value : LongInt);
  {-set limit on total paragraphs}
begin
  MaxParas := Value;
end;

procedure TParaList.SetTabSize(Value : Byte);
  {-set the tab size}
begin
  if TabSize <> Value then begin
    TabSize := Value;
    {recalculate if word wrap is on}
    if WordWrap then begin
      {recalculate number of lines}
      Recalculate;
      {reset position info}
      ResetPositionInfo;
    end;
  end;
end;

procedure TParaList.SetUndoSize(Size : Word);
  {-set size of undo buffer}
begin
  UndoBuffer.Free;
  UndoBuffer := TUndoBuffer.Init(@Self, Size);
end;

procedure TParaList.SetWordWrap(Value : Boolean);
  {-turn word wrap on or off}
begin
  if Value <> WordWrap then begin
    {turn word wrap on/off}
    WordWrap := Value;
    {recalculate number of lines}
    Recalculate;
    {reset position info}
    ResetPositionInfo;
  end;
end;

procedure TParaList.SetWrapColumn(Value : Integer);
  {-set the wrap column}
begin
  if Value <> WrapColumn then begin
    {change the wrap column}
    WrapColumn := Value;
    {no need to recalculate if word wrap is off}
    if WordWrap then begin
      {recalculate number of lines}
      Recalculate;
      {reset position info}
      ResetPositionInfo;
    end;
  end;
end;

procedure TParaList.Undo(Editor : TOvcEditBase; var P : LongInt; var Pos : Integer);
  {-undo last insertion/deletion/replacement}
var
  UT       : UndoType;
  D        : PAnsiChar;
  S        : PAnsiChar;
  PPPN     : ^TParaNode absolute D;
  DLen     : Word;
  MF       : Boolean;
  OrigLink : Byte;
  Link     : Byte;
begin
  InUndo := True;
  UndoBuffer.PeekUndoLink(OrigLink);
  repeat
    UndoBuffer.GetUndo(UT, Link, MF, P, Pos, D, DLen);
    case UT of
      utInsert :
        DeleteText(Editor, P, Pos, DLen);
      utInsPara :
        DeletePara(Editor, P);
      utPlacePara :
        DeletePara(Editor, P+1);
      utDelete :
        InsertTextPrim(Editor, P, Pos, D, DLen);
      utDelPara :
        InsertParaNode(Editor, P, PPPN^);
      utReplace :
        begin
          S := D;
          Inc(S, StrLen(S)+1);
          ReplaceText(Editor, P, Pos, StrLen(S), D, StrLen(D));
        end;
    end;
    UndoBuffer.PeekUndoLink(Link);
  until (Link <> OrigLink);
  Modified := MF;
  InUndo := False;
end;

{*** TUndoBuffer ***}

procedure TUndoBuffer.Append(D : PAnsiChar; DLen : Word);
var
  S : PAnsiChar;
begin
  {make sure there's room}
  if not CheckSize(DLen) then
    Exit;

  {append the data}
  S := @Last^.Data;
  Inc(S, Last^.DSize);
  Move(D^, S^, DLen);

  {adjust the record size}
  Inc(Last^.DSize, DLen);

  {adjust the BufAvail figure}
  Dec(BufAvail, DLen);
end;

procedure TUndoBuffer.AppendReplace(D : PAnsiChar; DLen : Word;
                                    R : PAnsiChar; RLen : Word);
var
  S : PAnsiChar;
  Len : Word;
begin
  if not CheckSize(DLen+RLen) then
    Exit;

  {get a pointer to the existing data}
  S := @Last^.Data;
  Len := StrLen(S);

  {insert the D string}
  Move(S[Len], S[Len+DLen], Last^.DSize-Len);
  Move(D^, S[Len], DLen);
  Inc(Last^.DSize, DLen);

  {insert the R string}
  Inc(S, Len+DLen+1);
  Len := StrLen(S);
  Move(R^, S[Len], RLen);
  S[Len+RLen] := #0;
  Inc(Last^.DSize, RLen);

  {adjust the BufAvail figure}
  Dec(BufAvail, DLen+RLen);
end;

procedure TUndoBuffer.BeginComplexOp(var SaveLinking : Boolean);
begin
  SaveLinking := Linking;
  if not Linking then begin
    Linking := True;
    Inc(CurLink);
  end;
end;

function TUndoBuffer.CheckSize(Bytes : LongInt) : Boolean;
var
  MinAvail, I, Sz, LN : Word;
  PUR : PUndoRec;
begin
  Result := False;
  if Error then
    Exit;

  {is it too big to fit?}
  if (Bytes > BufSize) then begin
    {yes, flush and exit}
    Flush;
    Error := Linking;
    Exit;
  end;

  {will it fit without deleting anything?}
  Result := True;
  if Bytes <= BufAvail then
    Exit;

  {we'll need to delete some stuff}
  MinAvail := BufSize div 16;
  if Bytes > MinAvail then
    MinAvail := Bytes;
  I := 0;
  PUR := Buffer;
  while BufAvail < MinAvail do begin
    LN := PUR^.LinkNum;
    repeat
      {get rid of this group}
      Inc(I);
      GUN.Done(PUR);
      Sz := PUR^.DSize + UndoRecSize;
      Inc(BufAvail, Sz);
      PtrInc(PUR, Sz);                                                 {!!.10}
    until (I = Undos) or (PUR^.LinkNum <> LN);
  end;

  {do the deletion}
  if I = Undos then begin
    {nothing left, so clear everything}
    Undos := 0;
    Flush;
    Error := Linking;
    Result := not Linking;
  end else begin
    Sz := BufSize - PtrDiff(PUR, Buffer);                              {!!.10}
    Move(PUR^, Buffer^, Sz);
    PUndoRec(Buffer)^.PrevSize := 0;
    Dec(Undos, I);
    Redos := 0;
    Last := NthRec(Undos);
  end;
end;

destructor TUndoBuffer.Destroy;
begin
  if BufSize <> 0 then begin
    {dispose of any memory associated with deleted paragraphs}
    Flush;

    {deallocate the buffer}
    FreeMem(Buffer, BufSize);
  end;

  {destroy the general undo object}
  GUN.Free;

  inherited Destroy;
end;

procedure TUndoBuffer.EndComplexOp(SaveLinking : Boolean);
begin
  Linking := SaveLinking;
  if not Linking then
    Error := False;
end;

procedure TUndoBuffer.Flush;
var
  PUR  : PUndoRec;
  I    : Word;
begin
  {destroy all the undo records, some of which have pointers to data}
  PUR := Buffer;
  for I := 1 to Undos do begin
    GUN.Done(PUR);
    PtrInc(PUR, PUR^.DSize + UndoRecSize);                             {!!.10}
  end;

  BufAvail := BufSize;
  Undos := 0;
  Redos := 0;
  Last := Buffer;
  CurLink := 0;
end;

procedure TUndoBuffer.GetRedo(var UT : UndoType; var Link : Byte; var MF : Boolean;
                              var P : LongInt; var Pos : Integer;
                              var D : PAnsiChar; var DLen : Word);
var
  PUR : PUndoRec;
begin
  PUR := Last;
  if Undos > 0 then
    PtrInc(PUR, PUR^.DSize + UndoRecSize);                             {!!.10}
  with PUR^ do begin
    UT := GUN.GetUndoType(PUR);
    Link := LinkNum;
    P := PNum;
    Pos := PPos;
    D := @Data;
    DLen := DSize;

    {adjust the modified flag for this undo record}
    GUN.SetModFlag(PUR, MF);
  end;
  Dec(Redos);
  Inc(Undos);
  Dec(BufAvail, DLen + UndoRecSize);
  Last := PUR;
end;

procedure TUndoBuffer.GetUndo(var UT : UndoType; var Link : Byte; var MF : Boolean;
                              var P : LongInt; var Pos : Integer;
                              var D : PAnsiChar; var DLen : Word);
begin
  with Last^ do begin
    UT := GUN.GetUndoType(Last);
    Link := LinkNum;
    MF := GUN.ModFlag(Last);
    P := PNum;
    Pos := PPos;
    D := @Data;
    DLen := DSize;
  end;
  Dec(Undos);
  Inc(Redos);
  Inc(BufAvail, DLen + UndoRecSize);
  PtrDec(Last, Last^.PrevSize);                                        {!!.10}
end;

constructor TUndoBuffer.Init(ParaList : TParaList; Size : Word);
begin
  inherited Create;

  {assign owner of this undo buffer}
  Owner := ParaList;

  {allocate memory for the undo/redo buffer}
  if Size <> 0 then
    repeat
      {try to allocate the buffer}
      GetMem(Buffer, Size);
      if Buffer = nil then
        if Size <= UndoRecSize then
          Size := 0
        else
          Dec(Size, Size div 2);
    until (Buffer <> nil) or (Size = 0);
  BufSize := Size;

  {reset everything}
  BufAvail := BufSize;
  Undos := 0;
  Redos := 0;
  Last := Buffer;
  CurLink := 0;
  Linking := False;
  Error := False;

  {create one general undo object that is used to access all undo records}
  GUN := TUndoNode.Create;
end;

{$IFDEF Win32}
function TUndoBuffer.NthRec(N : Integer) : PUndoRec; register;
asm
  push   esi                     {save}

  mov    esi,Self                {esi = this object}
  mov    esi,[esi].Buffer        {esi = Buffer}
  mov    ecx,edx                 {ecx = N}
  jecxz  @@2                     {done if CX is 0}
  dec    ecx                     {ecx = N-1}
  jecxz  @@2                     {done if CX is 0}

  xor    eax,eax                 {clear high word}
@@1:
  mov    ax,[esi].TUndoRec.DSize {size of next record}
  add    esi,eax                 {point to next record}
  add    esi,UndoRecSize         {undo record size}
  loop   @@1                     {until done}

@@2:
  mov eax,esi                    {return position in buffer}

  pop    esi                     {restore}
end;
{$ELSE}
function TUndoBuffer.NthRec(N : Integer) : PUndoRec; assembler;
asm
  push ds                    {save DS}
  lds si,Self                {DS:SI = Buffer}
  lds si,[si].Buffer
  mov cx,N                   {CX = N}
  jcxz @2                    {done if CX is 0}
  dec cx                     {CX = N-1}
  jcxz @2                    {done if CX is 0}
  @1:
  add si,[si].TUndoRec.DSize {point to next record}
  add si,UndoRecSize         {undo record size}
  loop @1
  @2:
  mov dx,ds               {return DS:SI}
  mov ax,si
  pop ds                  {restore DS}
end;
{$ENDIF}

procedure TUndoBuffer.PeekRedoLink(var Link : Byte);
var
  PUR : PUndoRec;
begin
  if Redos = 0 then
    Link := not Last^.LinkNum
  else begin
    PUR := Last;
    if Undos > 0 then
      PtrInc(PUR, PUR^.DSize + UndoRecSize);                           {!!.10}
    Link := PUR^.LinkNum;
  end;
end;

procedure TUndoBuffer.PeekUndoLink(var Link : Byte);
begin
  if Undos = 0 then
    Link := not Last^.LinkNum
  else
    Link := Last^.LinkNum;
end;

procedure TUndoBuffer.Prepend(D : PAnsiChar; DLen : Word);
var
  S : PAnsiChar;
begin
  {make sure there's room}
  if not CheckSize(DLen) then
    Exit;

  {prepend the data}
  S := @Last^.Data;
  Move(S[0], S[DLen], Last^.DSize);
  Move(D^, S^, DLen);

  {adjust the position}
  Dec(Last^.PPos, DLen);

  {adjust the record size}
  Inc(Last^.DSize, DLen);

  {adjust the BufAvail figure}
  Dec(BufAvail, DLen);
end;

procedure TUndoBuffer.Push(UT : UndoType; MF : Boolean;
                           P : LongInt; Pos : Integer;
                           D : PAnsiChar; DLen : Word);
var
  PUR    : PUndoRec;
  PSize  : Word;
  Size   : LongInt;
  Before : Boolean;
begin
  if not Linking then
    if SameOperation(UT, Before, P, Pos, DLen) then begin
      Redos := 0;
      if Before then
        Prepend(D, DLen)
      else
        Append(D, DLen);
      Exit;
    end else
      Inc(CurLink);

  {make sure there's room}
  Size := LongInt(DLen) + UndoRecSize;
  if not CheckSize(Size) then
    Exit;

  {get pointer to the undo record and initialize it}
  Inc(Undos);
  PUR := Last;
  if Undos > 1 then begin
    PSize := PUR^.DSize + UndoRecSize;
    PtrInc(PUR, PSize);                                                {!!.10}
  end else
    PSize := 0;
  GUN.Init(PUR, UT, CurLink, MF, PSize, P, Pos, D, DLen);
  Last := PUR;
  Redos := 0;
  Dec(BufAvail, Size);
end;

procedure TUndoBuffer.PushReplace(MF : Boolean; P : LongInt; Pos : Integer;
                                  D : PAnsiChar; DLen : Word;
                                  R : PAnsiChar; RLen : Word);
var
  PUR    : PUndoRec;
  PSize  : Word;
  Size   : LongInt;
  Before : Boolean;
begin
  if not Linking then
    if SameOperation(utReplace, Before, P, Pos, DLen) then begin
      Redos := 0;
      AppendReplace(D, DLen, R, RLen);
      Exit;
    end else
      Inc(CurLink);

  {make sure there's room}
  Size := LongInt(DLen)+RLen+2 + UndoRecSize;
  if not CheckSize(Size) then
    Exit;

  {get pointer to the undo record and initialize it}
  Inc(Undos);
  PUR := Last;
  if Undos > 1 then begin
    PSize := PUR^.DSize + UndoRecSize;
    PtrInc(PUR, PSize);                                                {!!.10}
  end else
    PSize := 0;
  GUN.InitReplace(PUR, CurLink, MF, PSize, P, Pos, D, DLen, R, RLen);
  Last := PUR;
  Redos := 0;
  Dec(BufAvail, Size);
end;

function TUndoBuffer.SameOperation(UT : UndoType; var Before : Boolean;
                                   P : LongInt; Pos : Integer;
                                   DLen : Word) : Boolean;
var
  D : PAnsiChar;
begin
  Result := False;
  Before := False;
  if (Undos = 0) or (UT <> GUN.GetUndoType(Last)) then
    Exit;
  D := PAnsiChar(@Last^.Data);
  case UT of
    utInsert :
      Result := (Last^.PNum = P) and (Pos = Last^.PPos+Last^.DSize);
    utDelete :
      if (Last^.PNum = P) then
        if (Pos = Last^.PPos) then
          SameOperation := True
        else if (Pos+DLen = Last^.PPos) then begin
          Before := True;
          Result := True;
        end;
    utReplace :
      Result := (Last^.PNum = P) and (Pos = Last^.PPos+LongInt(StrLen(D)));{!!.D4}
  end;
end;

procedure TUndoBuffer.SetModified;
var
  PUR  : PUndoRec;
  I, J : Integer;
begin
  PUR := Buffer;
  J := Undos + Redos;
  for I := 1 to J do begin
    GUN.SetModFlag(PUR, True);
    PtrInc(PUR, PUR^.DSize + UndoRecSize);                             {!!.10}
  end;
end;


end.