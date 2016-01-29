{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcregexpr;

interface
{$I dc.inc}
uses
  classes, sysutils, dcsystem, dcdreamlib;

type
  TRegExpr = class
  private
    FList          : TList;
    FStack         : TList;
    FCaseSensitive : boolean;
    FRegExpr       : string;
    procedure InitRegStates(const RegExpr : string);
    function  FindRegExpr(const S : string; var AStart, AEnd : integer; Direction : boolean): Boolean;
  public
    constructor Create(const RegExpr: string; CaseSensitive : boolean);
    destructor Destroy; override;
    function Find(const S : string; var AStart, ALen : integer; Direction : boolean): boolean;
  end;

  function EmptyLineStr(const s : string) : boolean;

implementation

const
  SInvalidMask = '%s is invalid mask at (%d)';
  WildCardChars : TCharSet = ['^', '$', '*', '+', '.', '[', ']', '{', '}'];

type
  PCharSet = ^TCharSet;
  TRegStates = (msLiteral, msAny, msSet, msLineStart, msLineEnd, msGroupBegin, msGroupEnd, msSlash, msPlus, msStar);

  PRegState = ^TRegState;
  TRegState = record
    GroupIndex  : integer;
    case State : TRegStates of
      msLiteral, msSlash :
        (Literal : char);
      msAny, msLineStart, msLineEnd :
        ();
      msSet:
      (
        Negate  : Boolean;
        CharSet : TCharSet;
      );
  end;
  PStackRec = ^TStackRec;
  TStackRec = record
    sP: PChar;
    sI: Integer;
  end;

{------------------------------------------------------------------}

function EmptyLineStr(const s : string) : boolean;
begin
  result := (s = '^') or (s = '$') or (s = '^$');
end;

{------------------------------------------------------------------}

procedure ClearRecordList(List : TList);
var
  i:integer;
begin
  if List <> nil then
    with List do
      begin
        for i := 0 to Count - 1 do
          Dispose(Items[i]);
        Clear;
      end;
end;

{------------------------------------------------------------------}

procedure TRegExpr.InitRegStates(const RegExpr : string);
var
  Literal     : char;
  P           : PChar;
  Negate      : boolean;
  NeedGroup   : boolean;
  CharSet     : TCharSet;
  AIndex      : integer;
  i           : integer;
  FCurGroup   : integer;
  GroupCount  : integer;
  FGroups     : TList;

  {--------------------------------------------------------}

  procedure InvalidMask;
  begin
    raise Exception.CreateFmt(SInvalidMask, [RegExpr, P - PChar(RegExpr) + 1]);
  end;

  {--------------------------------------------------------}

  procedure Reset;
  begin
    if NeedGroup then
      exit;
    Negate := False;
    CharSet := [];
    FCurGroup := -1;
  end;

  {--------------------------------------------------------}

  procedure WriteScan(RegState : TRegStates);
  var
    State : PRegState;
  begin
    new(State);
    try
      State.GroupIndex := -1;
      State.State := RegState;
      case RegState of
        msLiteral, msSlash :
          if FCaseSensitive then
            State.Literal := Literal
          else
            State.Literal := UpCase(Literal);
        msSet:
          begin
            State.Negate := Negate;
            State.CharSet := CharSet;
          end;
      end;
      FList.Add(State);
    except
      dispose(State);
    end;
    Reset;
  end;

  {--------------------------------------------------------}

  procedure BeforeGroup;
  begin
    NeedGroup :=  (P + 1)^ in ['*', '+'];
    if NeedGroup then
    begin
      WriteScan(msGroupBegin);
      FCurGroup := FList.Count - 1;
    end;
  end;

  {--------------------------------------------------------}

  procedure AfterGroup;
  begin
    if NeedGroup then
    begin
      WriteScan(msGroupEnd);
      NeedGroup := false;
    end;
  end;

  {--------------------------------------------------------}

  procedure ScanSet;
  var
    LastChar: Char;
    C: Char;
  begin
    Inc(P);
    if P^ = '^' then
    begin
      Negate := true;
      Inc(P);
    end;
    LastChar := #0;
    while not (P^ in [#0, ']']) do
    begin
      case P^ of
        '-':
          if LastChar = #0 then
            InvalidMask
          else
          begin
            Inc(P);
            if FCaseSensitive then
              for C := LastChar to P^ do
                Include(CharSet, C)
            else
              for C := LastChar to UpCase(P^) do
                Include(CharSet, C);
          end;
        else
        begin
          if (P^ = '\') and ((P + 1)^ in WildCardChars + ['-']) then
            inc(P);
          if FCaseSensitive then
            LastChar := P^
          else
            LastChar := UpCase(P^);
          Include(CharSet, LastChar);
        end;
      end;
      Inc(P);
    end;
    if (P^ <> ']') or (CharSet = []) then
      InvalidMask;
    NeedGroup :=  (P + 1)^ in ['*', '+'];
    if NeedGroup then
      WriteScan(msGroupBegin);
    BeforeGroup;
    WriteScan(msSet);
    AfterGroup;
  end;

  {--------------------------------------------------------}


begin
  ClearRecordList(FList);
  FGroups := TList.Create;
  try
    P := PChar(RegExpr);
    GroupCount := 0;
    FCurGroup := -1;
    NeedGroup := false;
    Reset;
    while P^ <> #0 do
    begin
      case P^ of
        '^' : WriteScan(msLineStart);
        '$' : WriteScan(msLineEnd);
        '*',
        '+' :
          begin
            with FList do
            begin
              if FCurGroup >= 0 then
                AIndex := FCurGroup
              else
                AIndex := Count - 1;
              if (AIndex >= 0) and not (PRegState(Items[AIndex])^.State in ([msSlash, msPlus, msStar, msLineStart, msLineEnd])) then
              begin
                for i := AIndex to Count - 1 do
                  with PRegState(Items[i])^ do
                    if GroupIndex = -1 then
                      GroupIndex := Count - 1
              end
              else
                InvalidMask;
            end;
            if P^ = '+' then
              WriteScan(msPlus)
            else
              WriteScan(msStar)
          end;
        '.' : WriteScan(msAny);
        '[' : ScanSet;
        '{' :
          begin
            WriteScan(msGroupBegin);
            FGroups.Add(Pointer(FList.Count - 1));
            inc(GroupCount);
          end;
        '}' :
          begin
            WriteScan(msGroupEnd);
            with FGroups do
              if Count > 0 then
              begin
                FCurGroup := integer(Items[Count - 1]);
                Delete(Count - 1);
              end;
            dec(GroupCount);
          end;
        '\' :
          begin
            if (P + 1) ^ = #0 then
              InvalidMask;
            //if  (P + 1)^ in WildCardChars then
            begin
              Literal := (P + 1)^;
              WriteScan(msSlash);
              inc(P);
              Literal := P^;
              WriteScan(msLiteral);
            end;
          end;
        else
          begin
            BeforeGroup;
            Literal := P^;
            WriteScan(msLiteral);
            AfterGroup;
          end;
      end;
      Inc(P);
    end;
    Literal := #0;
    WriteScan(msLiteral);
    if GroupCount <> 0 then
      InvalidMask;
  finally
    FGroups.Free;
  end;
end;

{------------------------------------------------------------------}

function TRegExpr.FindRegExpr(const S : string; var AStart, AEnd : integer; Direction : boolean): Boolean;
var
  i        : integer;
  P        : PChar;
  OldP     : PChar;

  {--------------------------------------------------------}

  procedure Push(P : PChar; i : integer);
  var
    StackRec : PStackRec;
  begin
    new(StackRec);
    with StackRec^ do
    begin
      sP := P;
      sI := i;
    end;
    FStack.Add(StackRec);
  end;

  {--------------------------------------------------------}

  function Pop(var P : PChar; var i : integer): boolean;
  var
    StackRec : PStackRec;
  begin
    if FStack.Count = 0 then
      Result := false
    else
      with FStack do
      begin
        StackRec := PStackRec(Items[Count - 1]);
        with StackRec^ do
        begin
          P := sP;
          I := sI;
        end;
        Dispose(StackRec);
        Delete(Count - 1);
        result := true;
      end;
  end;

  {--------------------------------------------------------}

  function FindToken(P : PChar; AIndex : integer) : byte;
  begin
    result := 0;
    with PRegState(FList[AIndex])^ do
      if State = msLiteral then
      begin
        if (Literal = #0) then
        begin
          if AEnd = 0 then
            AEnd := P - Pchar(S);
          result := 1;
          exit;
        end;
        AEnd := 0;
        if FCaseSensitive then
        begin
          if P^ <> Literal then
            exit;
        end
        else
          if UpCase(P^) <> Literal then
            exit;
      end
      else
      begin
        AEnd := 0;
        case State of
          msSet:
            if FCaseSensitive then
            begin
              if not (Negate xor (P^ in CharSet)) then
                exit;
            end
            else
              if not (Negate xor (UpCase(P^) in CharSet)) then
                exit;
          msLineStart:
            begin
              if P <> Pchar(S) then
                Exit;
              result := 2;
              exit;
            end;
          msLineEnd :
            begin
              if P^ <> #0 then
                exit;
              result := 2;
              exit;
            end;
          msGroupBegin, msGroupEnd, msSlash, msPlus, msStar :
            begin
              result := 2;
              exit;
            end;
        end;
      end;
    result := 3;
  end;

  {--------------------------------------------------------}

  function Find(var P : PChar; AStart, AEnd : integer) : boolean;
  var
    i      : integer;
    Last   : boolean;
    AStar  : boolean;

    {-------------------------------------------------}

    function _Find(var P : PChar; AStart, AEnd : integer) : boolean;
    var
      OldP : PChar;
    begin
      OldP := P;
      result := Find(P, AStart, AEnd) and (OldP <> P);
      if not result then
        P := OldP;
    end;

    {-------------------------------------------------}

  begin

    Result := false;
    Last := false;
    i := AStart;
    while i <= AEnd do
      with PRegState(FList[i])^ do
      begin
        if (GroupIndex >= 0) and (GroupIndex <> AEnd) then
        begin
          AStar := PRegState(FList[GroupIndex + 1])^.State = msStar;
          if (P^ = #0) then
          begin
            if not AStar  then
            begin
              result := false;
              exit;
            end;
          end
          else
          begin
            if not (AStar or _Find(P, i, GroupIndex)) then
              exit;
            Push(@P[0], GroupIndex + 2);
            while _Find(P, i, GroupIndex) do
              if (P^ = #0) then
                break
              else
                Push(@P[0], GroupIndex + 2);
          end;
          i := GroupIndex + 2;
        end;

        case FindToken(P, i) of
          0 : exit;
          1 : break;
          2 :
              begin
                inc(i);
                continue;
              end;
        end;
        inc(i);
        if Last then
          exit;
        if P^ <> #0 then
          inc(P)
        else
          Last := true;
      end;
    Result := true;
  end;

  {--------------------------------------------------------}

begin
  result := false;
    AEnd := 0;
  AStart := Min(AStart, Length(S));
  if S = '' then
  begin
    if EmptyLineStr(FRegExpr) then
      result := true;
    exit;
  end;
  ClearRecordlist(FStack);
  Result := false;
  P := PChar(S);
  if AStart > 0 then
    inc(P, AStart - 1);
  repeat
    AStart := P - Pchar(S) + 1;
    OldP := P;
    i := 0;
    repeat
      if Find(P, i, FList.Count - 1) then
      begin
        result := true;
        exit;
      end;
    until not Pop(P, i);
    P := OldP;
    if Direction then
      inc(P)
    else
      dec(P)
  until (Direction and (P^ = #0)) or (not Direction and (P < Pchar(S)));
  ClearRecordlist(FStack);
  AStart := 0;
  AEnd := 0;
end;

{------------------------------------------------------------------}

constructor TRegExpr.Create(const RegExpr : string; CaseSensitive : boolean);
begin
  FList := TList.Create;
  FStack := TList.Create;
  FCaseSensitive := CaseSensitive;
  FRegExpr := RegExpr;
  InitRegStates(RegExpr);
end;

{------------------------------------------------------------------}

destructor TRegExpr.Destroy;
begin
  ClearRecordList(FList);
  ClearRecordList(FStack);
  FList.Free;
  FStack.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TRegExpr.Find(const S : string; var AStart, ALen : integer; Direction : boolean): Boolean;
begin
  ALen := 0;
  if (FRegExpr = '$') and ((Direction) or not Direction and (AStart = length(S))) then
  begin
    AStart := length(S) + 1;
    result := true;
    exit;
  end;
  result := FindRegExpr(S, AStart, ALen, Direction);
  if result then
  begin
    if ALen > 0 then
      inc(ALen);
    ALen := ALen - AStart;
    if ALen < 0 then
      ALen := 0;
  end;
end;

end.
