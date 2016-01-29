unit PDDate;

interface

type
  TgtPDDate = class
  private
    FYear: Word;
    FMonth: Word;
    FDay: Word;
    FHour: Word;
    FMinutes: Word;
    FSeconds: Word;

    procedure FillValues(Value: AnsiString);

    function GetYear: Word;
    function GetDay: Word;
    function GetMinutes: Word;
    function GetMonth: Word;
    function GetSeconds: Word;

    procedure SetYear(const Value: Word);
    procedure SetDay(const Value: Word);
    procedure SetMinutes(const Value: Word);
    procedure SetMonth(const Value: Word);
    procedure SetSeconds(const Value: Word);
    function GetHOur: Word;
    procedure SetHour(const Value: Word);

  public
    constructor Create(AString: AnsiString);

    function ToString: AnsiString;

    property Year: Word read GetYear write SetYear;
    property Month: Word read GetMonth write SetMonth;
    property Day: Word read GetDay write SetDay;
    property Hour: Word read GetHOur write SetHour;
    property Minutes: Word read GetMinutes write SetMinutes;
    property Seconds: Word read GetSeconds write SetSeconds;
  end;
implementation

{ TgtPDDate }

uses
  gtMethods;

constructor TgtPDDate.Create(AString: AnsiString);
begin
  FillValues(AString);
end;

function TgtPDDate.GetDay: Word;
begin
  Result := FDay;
end;

function TgtPDDate.GetHOur: Word;
begin
  Result := FHour;
end;

function TgtPDDate.GetMinutes: Word;
begin
  Result := FMinutes;
end;

function TgtPDDate.GetMonth: Word;
begin
  Result := FMonth;
end;

function TgtPDDate.GetSeconds: Word;
begin
  Result := FSeconds;
end;

function TgtPDDate.GetYear: Word;
begin
  Result := FYear;
end;

function TgtPDDate.ToString: AnsiString;
var
  Month: AnsiString;
  Day: AnsiString;
  Hour: AnsiString;
  Minutes: AnsiString;
  Seconds: AnsiString;
begin
  Month := IntegerToString(FMonth);
  if FMonth < 10 then
    Month := '0' + Month;

  Day := IntegerToString(FDay);
  if FDay < 10 then
    Day := '0' + Day;

  Hour := IntegerToString(FHour);
  if FHour < 10 then
    Hour := '0' + Hour;

  Minutes := IntegerToString(FMinutes);
  if FMinutes < 10 then
    Minutes := '0' + Minutes;

  Seconds := IntegerToString(FSeconds);
  if FSeconds < 10 then
    Seconds := '0' + Seconds;

  Result := 'D:' + IntegerToString(FYear) + Month + Day + Hour + Minutes +
    Seconds;
end;

procedure TgtPDDate.FillValues(Value: AnsiString);
var
//  LValid: Boolean;
  LPos: Integer;
begin
//  LValid := True;

  if Pos('D:', Value) = 0 then
  begin
    Exit;
  end;

  Delete(Value, Pos('D:', Value), 2);

  if (Length(Value) > 4) then
    FYear := StringToInteger(Copy(Value, 1, 4));

  if Length(Value) >= 6 then
    FMonth := StringToInteger(Copy(Value, 5, 2));
  if (FMonth < 1) or (FMonth > 12) then
  begin
    FMonth := 1;
//    LValid := False;
  end;

  if Length(Value) >= 8 then
    FDay := StringToInteger(Copy(Value, 7, 2));
  if (FDay < 1) or (FDay > 31) then
  begin
    FDay := 1;
//    LValid := False;
  end;

  if Length(Value) >= 10 then
    FHour := StringToInteger(Copy(Value, 9, 2));
  if FHour = 00 then
    FHour := 12;
  if FHour > 23 then
  begin
    FHour := 0;
//    LValid := False;
  end;

  LPos := pos('+', Value) or pos('-', Value) or pos('Z', Value);
  if (Length(Value) >= 12) and (LPos <> 11) then
    FMinutes := StringToInteger(Copy(Value, 11, 2));
  if FMinutes > 59 then
  begin
    FMinutes := 0;
//    LValid := False;
  end;

  LPos := pos('+', Value) or pos('-', Value) or pos('Z', Value);
  if ((LPos = 0) and (Length(Value) = 14)) or (LPos = 15) then
    FSeconds := StringToInteger(Copy(Value, 13, 2));

  if FSeconds > 59 then
  begin
    FSeconds := 0;
//    LValid := False;
  end;
end;

procedure TgtPDDate.SetDay(const Value: Word);
begin

end;

procedure TgtPDDate.SetHour(const Value: Word);
begin

end;

procedure TgtPDDate.SetMinutes(const Value: Word);
begin

end;

procedure TgtPDDate.SetMonth(const Value: Word);
begin

end;

procedure TgtPDDate.SetSeconds(const Value: Word);
begin

end;

procedure TgtPDDate.SetYear(const Value: Word);
begin

end;

end.
