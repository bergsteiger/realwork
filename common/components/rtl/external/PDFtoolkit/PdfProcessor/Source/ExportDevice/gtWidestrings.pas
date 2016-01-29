unit gtWidestrings;

interface

uses
  Classes, SysUtils;

Type

  TWString = record
    FString: WideString;
    FObject: TObject;
  end;

  TgtWideStringList = class;

  TgtWideStringListSortCompare = function(List: TgtWideStringList; Index1,
    Index2: Integer): Integer;

  TgtWideStringList = class
  private
    FWideStringList: TList;
    function Get(Index: Integer): WideString;
    procedure Put(Index: Integer; const S: WideString);
    function GetObject(Index: Integer): TObject;
    procedure PutObject(Index: Integer; const Value: TObject);
    procedure QuickSort(L, R: Integer; SCompare: TgtWideStringListSortCompare);
    procedure ExchangeItems(Index1, Index2: Integer);
    function GetTextStr: Widestring;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Add(const S: WideString): Integer;
    function Delete(Index: Integer): WideString;
    function IndexOf(const S: WideString): Integer;
    function IndexOfIgnoreCase(const S: WideString): Integer;
    function AddObject(const S: WideString; AObject: TObject): Integer;
    procedure SaveToFile(AFileName: string);
    procedure SaveToStream(AStream: TStream);
    procedure SaveToStreamA(AStream: TStream);
    procedure Insert(Index: Integer; const S: WideString);
    procedure CustomSort(Compare: TgtWideStringListSortCompare); virtual;
    property Strings[Index: Integer]: WideString read Get write Put; default;
    property Objects[Index: Integer]: TObject read GetObject write PutObject;
    property Count: Integer read GetCount;
  end;


implementation


{ TgtWideStringList implementation }
constructor TgtWideStringList.Create;
begin
  FWideStringList := TList.Create;
end;

procedure TgtWideStringList.CustomSort(Compare: TgtWideStringListSortCompare);
begin
  if (Count > 1) then
  begin
    QuickSort(0, Count - 1, Compare);
  end;
end;

destructor TgtWideStringList.Destroy;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  { TODO - BB Investigate : Could call Clear here }
  for Index := 0 to FWideStringList.Count-1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Dispose(PWStr);
  end;
  FWideStringList.Free;
  inherited Destroy;
end;

procedure TgtWideStringList.ExchangeItems(Index1, Index2: Integer);
var
  Temp: Integer;
  Item1, Item2: ^TWString;
begin
  Item1 := FWideStringList[Index1];
  Item2 := FWideStringList[Index2];
  Temp := Integer(Item1^.FString);
  Integer(Item1^.FString) := Integer(Item2^.FString);
  Integer(Item2^.FString) := Temp;
  Temp := Integer(Item1^.FObject);
  Integer(Item1^.FObject) := Integer(Item2^.FObject);
  Integer(Item2^.FObject) := Temp;
end;

function TgtWideStringList.Delete(Index: Integer): WideString;
begin
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    FWideStringList.Delete(Index);
  end;
end;

function TgtWideStringList.Get(Index: Integer): WideString;
var
  PWStr: ^TWString;
begin
  Result := '';
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Result := PWStr^.FString;
  end;
end;

function TgtWideStringList.GetCount: Integer;
begin
  Result := FWideStringList.Count;
end;

function TgtWideStringList.GetObject(Index: Integer): TObject;
var
  PWStr: ^TWString;
begin
  Result := nil;
  if ( (Index >= 0) and (Index < FWideStringList.Count) ) then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Result := PWStr^.FObject;
  end;
end;

function TgtWideStringList.GetTextStr: Widestring;
var
  I, L, Size, LCount: Integer;
  P: PChar;
  S, LB: Widestring;
begin
  LCount := GetCount;
  Size := 0;
  LB := #13#10;

  for I := 0 to Count - 1 do
    Inc(Size, Length(Get(I)) + Length(LB));

  SetString(Result, nil, Size);
  P := Pointer(Result);
  for I := 0 to LCount - 1 do
  begin
    S := Get(I);
    L := Length(S);
    if L <> 0 then
    begin
      System.Move(Pointer(S)^, P^, L);
      Inc(P, L);
    end;
    L := Length(LB);
    if L <> 0 then
    begin
      System.Move(Pointer(LB)^, P^, L);
      Inc(P, L);
    end;
  end;
end;

procedure TgtWideStringList.Put(Index: Integer; const S: WideString);
var
  PWStr: ^TWString;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then Exit;
    //raise Exception.Create(SWideStringOutofBounds);
  if Index < FWideStringList.Count then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr.FString := S;
  end
  else
    Add(S);
end;

procedure TgtWideStringList.PutObject(Index: Integer; const Value: TObject);
var
  PWStr: ^TWString;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then Exit;
    //raise Exception.Create(SWideStringOutofBounds);
  if Index < FWideStringList.Count then
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      PWStr.FString := '';
      PWStr.FObject := Value;
    end;
  end
  else
    AddObject('', Value);
end;

procedure TgtWideStringList.QuickSort(L, R: Integer;
  SCompare: TgtWideStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TgtWideStringList.SaveToFile(AFileName: string);
var
  LFileStream: TFileStream;
begin
  LFileStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(LFileStream);
  finally
    FreeAndNil(LFileStream);
  end;
end;

procedure TgtWideStringList.SaveToStream(AStream: TStream);
var
  LBuffer: WideString;
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
  begin
    LBuffer := Strings[LI] + #13#10;
    AStream.Write(LBuffer[1], Length(LBuffer) * SizeOf(WideChar));
  end;
end;

procedure TgtWideStringList.SaveToStreamA(AStream: TStream);
var
  LBuffer: AnsiString;
  LI: Integer;
begin
  for LI := 0 to Count - 1 do
  begin
    LBuffer := AnsiString(Strings[LI]) + #13#10;
    AStream.Write(LBuffer[1], Length(LBuffer) * SizeOf(AnsiChar));
  end;
end;

function TgtWideStringList.Add(const S: WideString): Integer;
begin
  Result := AddObject(S, nil);
end;

function TgtWideStringList.IndexOfIgnoreCase(const S: WideString): Integer;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FWideStringList.Count -1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      if SameText(S, PWStr^.FString) then
      begin
        Result := Index;
        break;
      end;
    end;
  end;
end;

function TgtWideStringList.IndexOf(const S: WideString): Integer;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  Result := -1;
  for Index := 0 to FWideStringList.Count -1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
    begin
      if S = PWStr^.FString then
      begin
        Result := Index;
        break;
      end;
    end;
  end;
end;

function TgtWideStringList.AddObject(const S: WideString; AObject: TObject): Integer;
var
  PWStr: ^TWString;
begin
  New(PWStr);
  PWStr^.FString := S;
  PWStr^.FObject := AObject;
  Result := FWideStringList.Add(PWStr);
end;

procedure TgtWideStringList.Clear;
var
  Index: Integer;
  PWStr: ^TWString;
begin
  for Index := 0 to FWideStringList.Count-1 do
  begin
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      Dispose(PWStr);
  end;
  FWideStringList.Clear;
end;

procedure TgtWideStringList.Insert(Index: Integer; const S: WideString);
var
  PWStr: ^TWString;
  LIdx: Integer;
begin
  if((Index < 0) or (Index > FWideStringList.Count)) then Exit;
    //raise Exception.Create(SWideStringOutofBounds);
  if Index < FWideStringList.Count then
  begin
    Add(S);
    for LIdx := Count - 1 downto (Index + 1) do
    begin
      PWStr := FWideStringList.Items[LIdx];
      if PWStr <> nil then
        PWStr.FString := Strings[LIdx - 1];
    end;
    PWStr := FWideStringList.Items[Index];
    if PWStr <> nil then
      PWStr.FString := S;
  end
  else
    Add(S);
end;

end.
