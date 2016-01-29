
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{       Virtual Pascal v2.1                             }
{       Copyright (C) 1996-2000 vpascal.com             }
{                                                       }
{*******************************************************}

unit Outline;

{$X+,I-,S-,R-,H-}

interface

uses Use32, Objects, Drivers, Views;

const
  ovExpanded = $01;
  ovChildren = $02;
  ovLast     = $04;

const
  cmOutlineItemSelected = 301;

const
  COutlineViewer = CScroller + #8#8;

type

{ TOutlineViewer  object }

  { Palette layout }
  { 1 = Normal color }
  { 2 = Focus color }
  { 3 = Select color }
  { 4 = Not expanded color }

  POutlineViewer = ^TOutlineViewer;
  TOutlineViewer = object(TScroller)
    Foc: Integer;
    constructor Init(var Bounds: TRect; AHScrollBar,
      AVScrollBar: PScrollBar);
    constructor Load(var S: TStream);
    procedure Adjust(Node: Pointer; Expand: Boolean); virtual;
    function CreateGraph(Level: Integer; Lines: LongInt; Flags: Word;
      LevWidth, EndWidth: Integer; const Chars: String): String; pascal;
    procedure Draw; virtual;
    procedure ExpandAll(Node: Pointer);
    function FirstThat(Test: Pointer): Pointer;
    procedure Focused(I: Integer); virtual;
    function ForEach(Action: Pointer): Pointer;
    function GetChild(Node: Pointer; I: Integer): Pointer; virtual;
    function GetGraph(Level: Integer; Lines: LongInt; Flags: Word): String; virtual;
    function GetNumChildren(Node: Pointer): Integer; virtual;
    function GetNode(I: Integer): Pointer;
    function GetPalette: PPalette; virtual;
    function GetRoot: Pointer; virtual;
    function GetText(Node: Pointer): String; virtual;
    procedure HandleEvent(var Event: TEvent); virtual;
    function HasChildren(Node: Pointer): Boolean; virtual;
    function IsExpanded(Node: Pointer): Boolean; virtual;
    function IsSelected(I: Integer): Boolean; virtual;
    procedure Selected(I: Integer); virtual;
    procedure SetState(AState: Word; Enable: Boolean); virtual;
    procedure Store(var S: TStream);
    procedure Update;
  private
    procedure AdjustFocus(NewFocus: Integer);
    function Iterate(Action: Pointer; CallerFrame: Word;
      CheckRslt: Boolean): Pointer; pascal;
  end;

{ TNode }

  PNode = ^TNode;
  TNode = record
    Next: PNode;
    Text: PString;
    ChildList: PNode;
    Expanded: Boolean;
  end;

{ TOutline object }

  { Palette layout }
  { 1 = Normal color }
  { 2 = Focus color }
  { 3 = Select color }

  POutline = ^TOutline;
  TOutline = object(TOutlineViewer)
    Root: PNode;

    constructor Init(var Bounds: TRect; AHScrollBar,
      AVScrollBar: PScrollBar; ARoot: PNode);
    constructor Load(var S: TStream);
    destructor Done; virtual;

    procedure Adjust(Node: Pointer; Expand: Boolean); virtual;
    function GetRoot: Pointer; virtual;
    function GetNumChildren(Node: Pointer): Integer; virtual;
    function GetChild(Node: Pointer; I: Integer): Pointer; virtual;
    function GetText(Node: Pointer): String; virtual;
    function IsExpanded(Node: Pointer): Boolean; virtual;
    function HasChildren(Node: Pointer): Boolean; virtual;
    procedure Store(var S: TStream);
  end;

const
  ROutline: TStreamRec = (
     ObjType: 91;
     VmtLink: TypeOf(TOutline);
     Load:    @TOutline.Load;
     Store:   @TOutline.Store
  );

procedure RegisterOutline;
function NewNode(const AText: String; AChildren, ANext: PNode): PNode;
procedure DisposeNode(Node: PNode);

implementation

{ TOutlineViewer }

constructor TOutlineViewer.Init(var Bounds: TRect; AHScrollBar,
  AVScrollBar: PScrollBar);
begin
  inherited Init(Bounds, AHScrollBar, AVScrollBar);
  GrowMode := gfGrowHiX + gfGrowHiY;
  Foc := 0;
end;

constructor TOutlineViewer.Load(var S: TStream);
begin
  inherited Load(S);
  S.Read(Foc, SizeOf(Foc));
end;

{ Called when the user requests Node to be contracted or
  expanded (i.e. its children to be hidden or shown) }

procedure TOutlineViewer.Adjust(Node: Pointer; Expand: Boolean);
begin
  Abstract;
end;

{ Called internally to ensure the focus is within range and displayed }

procedure TOutlineViewer.AdjustFocus(NewFocus: Integer);
begin
  if NewFocus < 0 then NewFocus := 0
  else if NewFocus >= Limit.Y then NewFocus := Limit.Y - 1;
  if Foc <> NewFocus then Focused(NewFocus);
  if NewFocus < Delta.Y then
    ScrollTo(Delta.X, NewFocus)
  else if NewFocus - Size.Y >= Delta.Y then
    ScrollTo(Delta.X, NewFocus - Size.Y + 1);
end;

{ Called to draw the outline }

procedure TOutlineViewer.Draw;
var
  NrmColor, SelColor, FocColor: Word;
  B: TDrawBuffer;
  I: Integer;

  function DrawTree(Cur: Pointer; Level, Position: Integer; Lines: LongInt;
    Flags: Word): Boolean; far;
  var
    Color: Word;
    S: String;
  begin
    DrawTree := False;

    if Position >= Delta.Y then
    begin
      if Position >= Delta.Y + Size.Y then
      begin
        DrawTree := True;
        Exit;
      end;

      if (Position = Foc) and (State and sfFocused <> 0) then
        Color := FocColor
      else if IsSelected(Position) then
        Color := SelColor
      else
        Color := NrmColor;
      MoveChar(B, ' ', Color, Size.X);
      S := GetGraph(Level, Lines, Flags);
      if Flags and  ovExpanded = 0 then
        S := Concat(S, '~', GetText(Cur), '~')
      else
        S := Concat(S, GetText(Cur));
      MoveCStr(B, Copy(S, Delta.X + 1, 255), Color);
      WriteLine(0, Position - Delta.Y, Size.X, 1, B);
      I := Position;
    end;
  end;

begin
  NrmColor := GetColor($0401);
  FocColor := GetColor($0202);
  SelColor := GetColor($0303);
  FirstThat(@DrawTree);
  MoveChar(B, ' ', NrmColor, Size.X);
  WriteLine(0, I + 1, Size.X, Size.Y - (I - Delta.Y), B);
end;

{ ExpandAll expands the current node and all child nodes }

procedure TOutlineViewer.ExpandAll(Node: Pointer);
var
  I, N: Integer;
begin
  if HasChildren(Node) then
  begin
    Adjust(Node, True);
    N := GetNumChildren(Node) - 1;
    for I := 0 to N do
      ExpandAll(GetChild(Node, I));
  end;
end;

{ Draws a graph string suitable for returning from GetGraph.  Level
  indicates the outline level.  Lines is the set of bits decribing
  the which levels have a "continuation" mark (usually a vertical
  lines).  If bit 3 is set, level 3 is continued beyond this level.
  Flags gives extra information about how to draw the end of the
  graph (see the ovXXX constants).  LevWidth is how many characters
  to indent for each level.  EndWidth is the length the end characters.

  The graphics is divided into two parts: the level marks, and the end
  or node graphic.  The level marks consist of the Level Mark character
  separated by Level Filler.  What marks are present is determined by
  Lines.  The end graphic is constructed by placing on of the End First
  charcters followed by EndWidth-4 End Filler characters, followed by the
  End Child character, followed by the Retract/Expand character.  If
  EndWidth equals 2, End First and Retract/Expand are used.  If EndWidth
  equals 1, only the Retract/Expand character is used.  Which characters
  are selected is determined by Flags.

  The layout for the characters in the Chars is:

   1: Level Filler
     Typically a space.  Used between level markers.
   2: Level Mark
     Typically a vertical bar.  Used to mark the levels currenly active.
   3: End First (not last child)
     Typically a sideways T.  Used as the first character of the end part
     of a node graphic if the node is not the last child of the parent.
   4: End First (last child)
     Typically a L shape.  Used as the first character of the end part
     of a node graphic if the node is the last child of the parent.
   5: End Filler
     Typically a horizontal line.  Used as filler for the end part of a
     node graphic.
   6: End Child position
     Typically not used.  If EndWidth > LevWidth this character will
     be placed on top of the markers for next level.  If used it is
     typically a T.
   7: Retracted character
     Typically a '+'.  Displayed as the last character of the end
     node if the level has children and they are not expanded.
   8: Expanded character
     Typically as straight line. Displayed as the last character of
     the end node if the level has children and they are expanded.

  As an example GetGraph calls CreateGraph with the following paramters:

    CreateGraph(Level, Lines, Flags, 3, 3, ' '#179#195#192#196#196'+'#196);

  To use double, instead of single lines use:

    CreateGraph(Level, Lines, Flags, 3, 3, ' '#186#204#200#205#205'+'#205);

  To have the children line drop off prior to the text instead of underneath,
  use the following call:

    CreateGraph(Level, Lines, Flags, 2, 4, ' '#179#195#192#196#194'+'#196);

  }

function TOutlineViewer.CreateGraph(Level: Integer; Lines: LongInt;
  Flags: Word; LevWidth, EndWidth: Integer;
  const Chars: String): String;
const
  FillerOrBar   = 0;
  YorL          = 2;
  StraightOrTee = 4;
  Retracted     = 6;
var
  Last, Children, Expanded: Boolean;
asm
                push ebx
                push esi
                push edi
                cld

        { Break out flags }
                xor     ebx,ebx
                mov     eax,Flags
                mov     Expanded,bl
                shr     eax,1
                adc     Expanded,bl
                mov     Children,bl
                shr     eax,1
                adc     Children,bl
                mov     Last,bl
                shr     eax,1
                adc     Last,bl

        { Load registers }
                mov     esi,Chars
                inc     esi
                mov     edi,@Result
                inc     edi
                mov     edx,Lines
                inc     Level

        { Write bar characters }
                jmp     @@2
              @@1:
                xor     ebx,ebx
                shr     edx,1
                rcl     ebx,1
                mov     al,[esi].FillerOrBar[ebx]
                stosb
                mov     al,[esi].FillerOrBar
                mov     ecx,LevWidth
                dec     ecx
                rep     stosb
              @@2:
                dec     Level
                jnz     @@1

        { Write end characters }
                mov     ecx,EndWidth
                dec     ecx
                jz      @@4
                mov     bl,Last
                mov     al,[esi].YorL[ebx]
                stosb
                dec     ecx
                jz      @@4
                dec     ecx
                jz      @@3
                mov     al,[esi].StraightOrTee
                rep     stosb
              @@3:
                mov     bl,Children
                mov     al,[esi].StraightOrTee[ebx]
                stosb
              @@4:
                mov     bl,Expanded
                mov     al,[esi].Retracted[ebx]
                stosb
                mov     eax,edi
                mov     edi,@Result
                sub     eax,edi
                dec     eax
                stosb
                pop edi
                pop esi
                pop ebx
end;

{ Internal function used to fetch the caller's stack frame }

function CallerFrame: Word; pascal; 
asm
                mov     eax,[ebp]
end;

{ FirstThat iterates over the nodes of the outline until the given
  local function returns true. The declaration for the local function
  must look like (save for the names, of course):

    function MyIter(Cur: Pointer; Level, Position: Integer;
      Lines: LongInt; Flags: Word); far;

  The parameters are as follows:

    Cur:        A pointer to the node being checked.
    Level:      The level of the node (how many node above it it has)
                Level is 0 based.  This can be used to a call to
                either GetGraph or CreateGraph.
    Position:   The display order position of the node in the list.
                This can be used in a call to Focused or Selected.
                If in range, Position - Delta.Y is location the node
                is displayed on the view.
    Lines:      Bits indicating the active levels.  This can be used in a
                call to GetGraph or CreateGraph. It dicatates which
                horizontal lines need to be drawn.
    Flags:      Various flags for drawing (see ovXXXX flags).  Can be used
                in a call to GetGraph or CreateGraph. }

function TOutlineViewer.FirstThat(Test: Pointer): Pointer;
begin
  FirstThat := Iterate(Test, CallerFrame, True);
end;

{ Called whenever Node receives focus }

procedure TOutlineViewer.Focused(I: Integer);
begin
  Foc := I;
end;

{ Iterates over all the nodes.  See FirstThat for a more details }

function TOutlineViewer.ForEach(Action: Pointer): Pointer;
begin
  Iterate(Action, CallerFrame, False);
end;

{ Returns the outline palette }

function TOutlineViewer.GetPalette: PPalette;
const
  P: String[Length(COutlineViewer)] = COutlineViewer;
begin
  GetPalette := @P;
end;

{ Overridden to return a pointer to the root of the outline }

function TOutlineViewer.GetRoot: Pointer;
begin
  Abstract;
end;

{ Called to retrieve the characters to display prior to the
  text returned by GetText.  Can be overridden to return
  change the appearance of the outline. My default calls
  CreateGraph with the default. }

function TOutlineViewer.GetGraph(Level: Integer; Lines: LongInt;
  Flags: Word): String;
{const
  LevelWidth = 2;
  EndWidth   = LevelWidth + 2;
  GraphChars = ' '#179#195#192#196#194'+'#196; }
{  GraphChars = ' '#186#204#200#205#203'+'#205;}
const
  LevelWidth = 3;
  EndWidth   = LevelWidth;
  GraphChars = ' '#179#195#192#196#196'+'#196;
{  GraphChars = ' '#186#204#200#205#205'+'#205;}
begin
  GetGraph := Copy(CreateGraph(Level, Lines, Flags, LevelWidth, EndWidth,
    GraphChars), EndWidth, 255);
end;

{ Returns a pointer to the node that is to be shown on line I }

function TOutlineViewer.GetNode(I: Integer): Pointer;
var
  Cur: Pointer;

  function IsNode(Node: Pointer; Level, Position: Integer; Lines: LongInt;
    Flags: Word): Boolean; far;
  begin
    IsNode := I = Position;
  end;

begin
  GetNode := FirstThat(@IsNode);
end;

{ Overridden to return the number of children in Node. Will not be
  called if HasChildren returns false.  }

function TOutlineViewer.GetNumChildren(Node: Pointer): Integer;
begin
  Abstract;
end;

{ Overriden to return the I'th child of Node. Will not be called if
  HasChildren returns false. }

function TOutlineViewer.GetChild(Node: Pointer; I: Integer): Pointer;
begin
  Abstract;
end;

{ Overridden to return the text of Node }

function TOutlineViewer.GetText(Node: Pointer): String;
begin
  Abstract;
end;

{ Overriden to return if Node's children should be displayed.  Will
  never be called if HasChildren returns False. }

function TOutlineViewer.IsExpanded(Node: Pointer): Boolean;
begin
  Abstract;
end;

{ Returns if Node is selected.  By default, returns true if Node is
  Focused (i.e. single selection).  Can be overriden to handle
  multiple selections. }

function TOutlineViewer.IsSelected(I: Integer): Boolean;
begin
  IsSelected := Foc = I;
end;

{ Internal function used by both FirstThat and ForEach to do the
  actual iteration over the data. See FirstThat for more details }

function TOutlineViewer.Iterate(Action: Pointer; CallerFrame: Word;
  CheckRslt: Boolean): Pointer;
var
  Position: Integer;

  function TraverseTree(Cur: Pointer; Level: Integer;
    Lines: LongInt; LastChild: Boolean): Pointer; far;
  var
    J, ChildCount: Integer;
    Ret: Pointer;
    Flags: Word;
    Children,Done: Boolean;
  begin
    TraverseTree := Cur;
    if Cur = nil then Exit;

    Children := HasChildren(Cur);

    Flags := 0;
    if LastChild then Inc(Flags, ovLast);
    if Children and IsExpanded(Cur) then Inc(Flags, ovChildren);
    if not Children or IsExpanded(Cur) then Inc(Flags, ovExpanded);

    Inc(Position);

    { Perform call }
    { IMPORTANT! Virtual Pascal's code generation differs from BP's one.}
    { In the prolog of a nested procedure Virtual Pascal uses 'ENTER'   }
    { CPU instruction with the appropriate lexical (nested) level.      }
    { Exact lexical level of a procedure that issues FirstThat or       }
    { ForEach is NOT known here. So I made an assumption that FirstThat }
    { or ForEach CANNOT BE ISSUED FROM THE PROCEDURE WITH THE LEXICAL   }
    { LEVEL GREATER THAN 3. For example, FirstThat function is called   }
    { in a GetFocusedGraphic function which lexical level is 2.         }
    asm
                push    DWord Ptr [ebp-12] { Preserve local variables   }
                push    DWord Ptr [ebp-8]
                mov     ecx,[ebp-4]     { Load parent frame into ecx    }
                push    ecx             { Save it on stack              }
                push    Cur             { [1] = Cur: Pointer;           }
                push    Level           { [2] = Level: Integer;         }
                push    DWord Ptr [ecx+OFFSET Position] { [3] = Position: Integer; }
                push    Lines           { [4] = Lines: LongInt;         }
                push    Flags           { [5] = Flags: Word;            }
                mov     edx,[ecx+OFFSET CallerFrame]
                mov     eax,[edx-4]     { Copy stack frames of the      }
                mov     [ebp-4],eax     { parents                       }
                mov     eax,[edx-8]
                mov     [ebp-8],eax
                mov     eax,[edx-12]
                mov     [ebp-12],eax
                Call    DWord Ptr [ecx+OFFSET Action]
                pop     ecx
                pop     DWord Ptr [ebp-8]
                pop     DWord Ptr [ebp-12]
                mov     [ebp-4],ecx     { Restore parent frame          }
                and     al,[ecx+OFFSET CheckRslt].Boolean { Force to 0 if CheckRslt False }
                setnz   Done
    end;

    if Done then Exit;

    if Children and IsExpanded(Cur) then
    begin
      ChildCount := GetNumChildren(Cur);

      if not LastChild then Lines := Lines or (1 shl Level);
      for J := 0 to ChildCount - 1 do
      begin
        Ret := TraverseTree(GetChild(Cur, J), Level + 1, Lines,
          J = (ChildCount - 1));
        TraverseTree := Ret;
        if Ret <> nil then Exit;
      end;
    end;
    TraverseTree := nil;
  end;

begin
  Position := -1;

  asm
        pusha
        DEC     CheckRslt
        NOT     CheckRslt
        popa
  end;

  Iterate := TraverseTree(GetRoot, 0, 0, True);
end;

{ Called to handle an event }

procedure TOutlineViewer.HandleEvent(var Event: TEvent);
const
  MouseAutoToSkip = 3;
var
  Mouse: TPoint;
  Cur: Pointer;
  NewFocus: Integer;
  Count: Integer;
  Graph: String;
  Dragged: Byte;

  function GetFocusedGraphic(var Graph: String): Pointer;
  var
    Lvl: Integer;
    Lns: LongInt;
    Flgs: Word;

    function IsFocused(Cur: Pointer; Level, Position: Integer;
      Lines: LongInt; Flags: Word): Boolean; far;
    begin
      if Position = Foc then
      begin
        IsFocused := True;
        Lvl := Level;
        Lns := Lines;
        Flgs := Flags;
      end
      else IsFocused := False;
    end;

  begin
    GetFocusedGraphic := FirstThat(@IsFocused);
    Graph := GetGraph(Lvl, Lns, Flgs);
  end;


begin
  inherited HandleEvent(Event);
  case Event.What of
    evMouseDown:
      begin
        Count := 0;
        Dragged := 0;
        repeat
          if Dragged < 2 then Inc(Dragged);
          MakeLocal(Event.Where, Mouse);
          if MouseInView(Event.Where) then
            NewFocus := Delta.Y + Mouse.Y
          else
          begin
            if Event.What = evMouseAuto then Inc(Count);
            if Count = MouseAutoToSkip then
            begin
              Count := 0;
              if Mouse.Y < 0 then Dec(NewFocus);
              if Mouse.Y >= Size.Y then Inc(NewFocus);
            end;
          end;
          if Foc <> NewFocus then
          begin
            AdjustFocus(NewFocus);
            DrawView;
          end;
        until not MouseEvent(Event, evMouseMove + evMouseAuto);
        if Event.Double then Selected(Foc)
        else
        begin
          if Dragged < 2 then
          begin
            Cur := GetFocusedGraphic(Graph);
            if Mouse.X < Length(Graph) then
            begin
              Adjust(Cur, not IsExpanded(Cur));
              Update;
              DrawView;
            end;
          end;
        end;
      end;
    evKeyboard:
      begin
        NewFocus := Foc;
        case CtrlToArrow(Event.KeyCode) of
          kbUp, kbLeft:    Dec(NewFocus);
          kbDown, kbRight: Inc(NewFocus);
          kbPgDn:          Inc(NewFocus, Size.Y - 1);
          kbPgUp:          Dec(NewFocus, Size.Y - 1);
          kbHome:          NewFocus := Delta.Y;
          kbEnd:           NewFocus := Delta.Y + Size.Y - 1;
          kbCtrlPgUp:      NewFocus := 0;
          kbCtrlPgDn:      NewFocus := Limit.Y - 1;
          kbCtrlEnter,
          kbEnter:         Selected(NewFocus);
        else
          case Event.CharCode of
            '-', '+': Adjust(GetNode(NewFocus), Event.CharCode = '+');
            '*':      ExpandAll(GetNode(NewFocus));
          else
            Exit;
          end;
          Update;
        end;
        ClearEvent(Event);
        AdjustFocus(NewFocus);
        DrawView;
      end;
  end;
end;

{ Called to determine if the given node has children }

function TOutlineViewer.HasChildren(Node: Pointer): Boolean;
begin
  Abstract;
end;

{ Called whenever Node is selected by the user either via keyboard
  control or by the mouse. }

procedure TOutlineViewer.Selected(I: Integer);
begin
end;

{ Redraws the outline if the outliner sfFocus state changes }

procedure TOutlineViewer.SetState(AState: Word; Enable: Boolean);
begin
  inherited SetState(AState, Enable);
  if AState and sfFocused <> 0 then DrawView;
end;

{ Store the object to a stream }

procedure TOutlineViewer.Store(var S: TStream);
begin
  inherited Store(S);
  S.Write(Foc, SizeOf(Foc));
end;

{ Updates the limits of the outline viewer.  Should be called whenever
  the data of the outline viewer changes.  This includes during
  the initalization of base classes.  TOutlineViewer assumes that
  the outline is empty.  If the outline becomes non-empty during the
  initialization, Update must be called. Also, if during the operation
  of the TOutlineViewer the data being displayed changes, Update
  and DrawView must be called. }

procedure TOutlineViewer.Update;
var
  Count, MaxX: Integer;

  function CountNode(P: Pointer; Level, Position: Integer; Lines: LongInt;
    Flags: Word): Boolean; far;
  var
    Len: Integer;
  begin
    Inc(Count);
    Len := Length(GetText(P)) + Length(GetGraph(Level, Lines, Flags));
    if MaxX < Len then MaxX := Len;
    CountNode := False;
  end;

begin
  Count := 0;
  MaxX := 0;
  FirstThat(@CountNode);
  SetLimit(MaxX, Count);
  AdjustFocus(Foc);
end;

{ TOutline }

constructor TOutline.Init(var Bounds: TRect; AHScrollBar, AVScrollBar: PScrollBar;
  ARoot: PNode);
begin
  inherited Init(Bounds, AHScrollBar, AVScrollBar);
  Root := ARoot;
  Update;
end;

constructor TOutline.Load(var S: TStream);

  function LoadNode: PNode;
  var
    IsNode: Boolean;
    Node: PNode;
  begin
    S.Read(IsNode, SizeOf(IsNode));
    if IsNode then
    begin
      New(Node);
      with Node^ do
      begin
        S.Read(Expanded, SizeOf(Expanded));
        Text := S.ReadStr;
        ChildList := LoadNode;
        Next := LoadNode;
      end;
      LoadNode := Node;
    end
    else
      LoadNode := nil;
  end;

begin
  inherited Load(S);
  Root := LoadNode;
end;

destructor TOutline.Done;
begin
  DisposeNode(Root);
  inherited Done;
end;

procedure TOutline.Adjust(Node: Pointer; Expand: Boolean);
begin
  PNode(Node)^.Expanded := Expand;
end;

function TOutline.GetRoot: Pointer;
begin
  GetRoot := Root;
end;

function TOutline.GetNumChildren(Node: Pointer): Integer;
var
  I: Integer;
  P: PNode;
begin
  P := PNode(Node)^.ChildList;
  I := 0;
  while P <> nil do
  begin
    P := P^.Next;
    Inc(I);
  end;
  GetNumChildren := I;
end;

function TOutline.GetChild(Node: Pointer; I: Integer): Pointer;
var
  P: PNode;
begin
  P := PNode(Node)^.ChildList;
  while (I <> 0) and (P <> nil) do
  begin
    P := P^.Next;
    Dec(I);
  end;
  GetChild := P;
end;

function TOutline.GetText(Node: Pointer): String;
begin
  GetText := PNode(Node)^.Text^;
end;

function TOutline.IsExpanded(Node: Pointer): Boolean;
begin
  IsExpanded := PNode(Node)^.Expanded;
end;

function TOutline.HasChildren(Node: Pointer): Boolean;
begin
  HasChildren := PNode(Node)^.ChildList <> nil;
end;

procedure TOutline.Store(var S: TStream);

  procedure StoreNode(Node: PNode);
  var
    IsNode: Boolean;
  begin
    IsNode := Node <> nil;
    S.Write(IsNode, SizeOf(IsNode));
    if IsNode then
    begin
      with Node^ do
      begin
        S.Write(Expanded, SizeOf(Expanded));
        S.WriteStr(Text);
        StoreNode(ChildList);
        StoreNode(Next);
      end;
    end;
  end;

begin
  inherited Store(S);
  StoreNode(Root);
end;

function NewNode(const AText: String; AChildren, ANext: PNode): PNode;
var
  P: PNode;
begin
  New(P);
  with P^ do
  begin
    Text := NewStr(AText);
    Next := ANext;
    ChildList := AChildren;
    Expanded := True;
  end;
  NewNode := P;
end;

procedure DisposeNode(Node: PNode);
begin
  if Node <> nil then
    with Node^ do
    begin
      DisposeNode(ChildList);
      DisposeNode(Next);
      DisposeStr(Text);
      Dispose(Node);
    end;
end;

procedure RegisterOutline;
begin
  RegisterType(ROutline);
end;

end.
