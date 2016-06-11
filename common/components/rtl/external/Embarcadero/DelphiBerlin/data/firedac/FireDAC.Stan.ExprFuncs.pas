{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC expression custom functions          }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}
{$HPPEMIT LINKUNIT}

unit FireDAC.Stan.ExprFuncs;

interface

implementation

uses
{$IFDEF MSWINDOWS}
  // Preventing from "Inline has not expanded"
  Winapi.Windows,
  System.Win.ComObj,
{$ENDIF}
  System.Classes, System.SysUtils, System.Math,
  System.Variants, System.StrUtils, System.DateUtils,
  Data.FMTBcd, Data.SQLTimSt,
  FireDAC.Stan.Intf, FireDAC.Stan.Expr, FireDAC.Stan.Util, FireDAC.Stan.Error,
    FireDAC.Stan.Consts, FireDAC.Stan.SQLTimeInt;

{-------------------------------------------------------------------------------}
procedure ExprTypMisError;
begin
  FDException(nil, [S_FD_LStan, S_FD_LStan_PEval], er_FD_ExprTypeMis, []);
end;

{-------------------------------------------------------------------------------}
function FunAbs(const AArgs: array of Variant): Variant;
var
  d: Double;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    d := AArgs[0];
    Result := Abs(d);
  end;
end;

{-------------------------------------------------------------------------------}
function FunCeil(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Ceil(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunCos(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Cos(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunCosh(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Cosh(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunExp(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Exp(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunFloor(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Floor(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunLn(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Ln(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunLog(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if Length(AArgs) = 1 then
    Result := Ln(AArgs[0])
  else if FDStrIsNull(AArgs[1]) then
    Result := Null
  else
    Result := LogN(AArgs[0], AArgs[1]);
end;

{-------------------------------------------------------------------------------}
function FunMod(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else if AArgs[1] = 0 then
    Result := AArgs[0]
  else
    Result := AArgs[0] mod AArgs[1];
end;

{-------------------------------------------------------------------------------}
function FunPower(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else
    Result := Power(AArgs[0], AArgs[1]);
end;

{-------------------------------------------------------------------------------}
function FunRound(const AArgs: array of Variant): Variant;
begin
              
             
               
             
                        
 
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Round(Double(AArgs[0])) + 0.0;
end;

{-------------------------------------------------------------------------------}
function FunSign(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if AArgs[0] > 0.0 then
    Result := 1
  else if AArgs[0] < 0.0 then
    Result := -1
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function FunSin(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := sin(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunSinh(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := sinh(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunSqrt(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := sqrt(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunTan(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := tan(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunTanh(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := tanh(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunTrunc(const AArgs: array of Variant): Variant;
begin
              
             
               
             
                        
 
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Trunc(Double(AArgs[0])) + 0.0;
end;

{-------------------------------------------------------------------------------}
function FunChr(const AArgs: array of Variant): Variant;
var
  s: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    s := Chr(Integer(AArgs[0]));
    Result := s;
  end;
end;

{-------------------------------------------------------------------------------}
function FunConcat(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := AArgs[1]
  else if FDStrIsNull(AArgs[1]) then
    Result := AArgs[0]
  else
    Result := Concat(VarToStr(AArgs[0]), VarToStr(AArgs[1]));
end;

{-------------------------------------------------------------------------------}
function FunInitCap(const AArgs: array of Variant): Variant;
var
  s: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    s := VarToStr(AArgs[0]);
    Result := AnsiUpperCase(Copy(s, 1, 1)) + AnsiLowerCase(Copy(s, 2, MAXINT));
  end;
end;

{-------------------------------------------------------------------------------}
function InternalPad(const AArgs: array of Variant; AFront: Boolean): Variant;
var
  n: Integer;
  s, ps: String;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) or
    (Length(AArgs) = 3) and FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    s := AArgs[0];
    n := AArgs[1] - Length(s);
    if Length(AArgs) = 2 then
      ps := ' '
    else
      ps := AArgs[2];
    while Length(ps) < n do
      ps := ps + ps;
    if Length(ps) > n then
      ps := Copy(ps, 1, n);
    if AFront then
      Result := FDStrToVar(ps + s)
    else
      Result := FDStrToVar(s + ps);
  end;
end;

{-------------------------------------------------------------------------------}
function FunLPad(const AArgs: array of Variant): Variant;
begin
  Result := InternalPad(AArgs, True);
end;

{-------------------------------------------------------------------------------}
function FunRPad(const AArgs: array of Variant): Variant;
begin
  Result := InternalPad(AArgs, False);
end;

{-------------------------------------------------------------------------------}
function FunReplace(const AArgs: array of Variant): Variant;
var
  sWhere, sFrom, sTo: String;
  i: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if FDStrIsNull(AArgs[1]) then
    Result := AArgs[0]
  else begin
    sWhere := AArgs[0];
    sFrom := AArgs[1];
    if Length(AArgs) = 3 then
      sTo := AArgs[2]
    else
      sTo := '';
    while True do begin
      i := Pos(sFrom, sWhere);
      if i = 0 then
        Break;
      Delete(sWhere, i, Length(sFrom));
      if sTo <> '' then
        Insert(sTo, sWhere, i);
    end;
    Result := FDStrToVar(sWhere);
  end;
end;

{-------------------------------------------------------------------------------}
function FunTranslate(const AArgs: array of Variant): Variant;
var
  sWhere, sFrom, sTo: String;
  i, j: Integer;
  pCh: PChar;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) or FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    sWhere := AArgs[0];
    sFrom := AArgs[1];
    sTo := AArgs[2];
    for i := 1 to Length(sFrom) do begin
      pCh := StrScan(PChar(sWhere), sFrom[i]);
      if pCh <> nil then begin
        j := pCh - PChar(sWhere) + 1;
        if i > Length(sTo) then
          Delete(sWhere, j, 1)
        else
          sWhere[j] := sTo[i];
      end;
    end;
    Result := FDStrToVar(sWhere);
  end;
end;

{-------------------------------------------------------------------------------}
function FunAscii(const AArgs: array of Variant): Variant;
var
  s: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    s := AArgs[0];
    Result := Ord(s[1]);
  end;
end;

{-------------------------------------------------------------------------------}
function FunInstr(const AArgs: array of Variant): Variant;
var
  sWhere, sWhat: String;
  iCount, iFrom, hBnd: Integer;
  pStart, pCh: PChar;
  v: Variant;
  bReverse: Boolean;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    sWhere := AArgs[0];
    sWhat := AArgs[1];
    hBnd := Length(AArgs) - 1;
    iCount := 1;
    iFrom := 1;
    bReverse := False;
    if hBnd >= 2 then begin
      v := AArgs[2];
      if FDStrIsNull(v) then begin
        Result := Null;
        Exit;
      end;
      iFrom := v;
      bReverse := iFrom < 0;
      if bReverse then
        iFrom := Length(sWhere) + iFrom + 1;
      if hBnd >= 3 then begin
        v := AArgs[3];
        if FDStrIsNull(v) or (v <= 0) then begin
          Result := Null;
          Exit;
        end;
        iCount := v;
      end;
    end;
    pStart := PChar(sWhere) + iFrom - 1;
    pCh := nil;
    while iCount > 0 do begin
      if bReverse then begin
        pCh := FDStrRPos(pStart, PChar(sWhat));
        if pCh = nil then
          Break;
        pStart := pCh - Length(sWhat);
      end
      else begin
        pCh := StrPos(pStart, PChar(sWhat));
        if pCh = nil then
          Break;
        pStart := pCh + Length(sWhat);
      end;
      Dec(iCount);
    end;
    if pCh = nil then
      Result := 0
    else
      Result := pCh - PChar(sWhere) + 1;
  end;
end;

{-------------------------------------------------------------------------------}
function FunLength(const AArgs: array of Variant): Variant;
begin
  if VarIsNull(AArgs[0]) or VarIsEmpty(AArgs[0]) then
    Result := Null
  else
    Result := Length(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunAddMonths(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else
    Result := IncMonth(AArgs[0], AArgs[1]);
end;

{-------------------------------------------------------------------------------}
function FunLastDay(const AArgs: array of Variant): Variant;
var
  AYear, AMonth, ADay: Word;
  dt: TDateTime;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    dt := AArgs[0];
    AYear := 0;
    AMonth := 0;
    ADay := 0;
    DecodeDate(dt, AYear, AMonth, ADay);
    ADay := DaysInAMonth(AYear, AMonth);
    Result := EncodeDate(AYear, AMonth, ADay) + (dt - Trunc(dt));
    TVarData(Result).VType := varDate;
  end;
end;

{-------------------------------------------------------------------------------}
function FunFirstDay(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := StartOfTheMonth(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunMonthsBW(const AArgs: array of Variant): Variant;
var
  AYear1, AMonth1, ADay1: Word;
  AYear2, AMonth2, ADay2: Word;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    AYear1 := 0;
    AMonth1 := 0;
    ADay1 := 0;
    DecodeDate(AArgs[0], AYear1, AMonth1, ADay1);
    AYear2 := 0;
    AMonth2 := 0;
    ADay2 := 0;
    DecodeDate(AArgs[1], AYear2, AMonth2, ADay2);
    Result := (Integer(AYear1 * 12 * 31 + AMonth1 * 31 + ADay1) -
               Integer(AYear2 * 12 * 31 + AMonth2 * 31 + ADay2)) / 31;
  end;
end;

{-------------------------------------------------------------------------------}
function FunNextDay(const AArgs: array of Variant): Variant;
var
  dt: TDateTime;
  nd, d: String;
  i: Integer;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    dt := AArgs[0];
    nd := AArgs[1];
    for i := 1 to 7 do begin
      dt := dt + 1;
      d := '';
      DateTimeToString(d, 'dddd', dt);
      if AnsiCompareText(d, nd) = 0 then begin
        Result := dt;
        Exit;
      end;
    end;
    Result := Null;
                  
                                      
     
  end;
end;

{-------------------------------------------------------------------------------}
function FunToChar(const AArgs: array of Variant): Variant;
var
  N, i: Integer;
  E: Extended;
  V: Variant;
  rFS: TFormatSettings;
  sFormatDate: String;
begin
              
                          
 
  N := Length(AArgs) - 1;
  if FDStrIsNull(AArgs[0]) or
    (N > 0) and FDStrIsNull(AArgs[1]) or
    (N > 1) and FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    V := AArgs[0];
    if N > 0 then
      if (VarType(V) and varTypeMask) = varDate then begin
        rFS.TwoDigitYearCenturyWindow := 50;
        rFS.ShortDateFormat := AArgs[1];
        sFormatDate := AArgs[1];
        for i := 1 to Length(sFormatDate) do
          if FDInSet(sFormatDate[i], [' ', '-', '\', '.', '/']) then begin
            rFS.DateSeparator := sFormatDate[i];
            Break;
          end;
        Result := FormatDateTime(sFormatDate, V, rFS);
      end
      else if VarIsNumeric(V) then begin
        E := V;
        Result := FormatFloat(AArgs[1], E);
      end
      else if VarIsFMTBcd(V) then
        Result := FormatBcd(AArgs[1], VarToBcd(V))
      else if VarIsSQLTimeStamp(V) then
        Result := SQLTimeStampToStr(AArgs[1], VarToSQLTimeStamp(V))
      else
        Result := VarAsType(V, varUString)
    else
      Result := VarAsType(V, varUString);
  end;
end;

{-------------------------------------------------------------------------------}
function FunToDate(const AArgs: array of Variant): Variant;
var
  N, i: Integer;
  sDate: String;
  rFS: TFormatSettings;
begin
              
                          
 
  N := Length(AArgs) - 1;
  if FDStrIsNull(AArgs[0]) or
    (N > 0) and FDStrIsNull(AArgs[1]) or
    (N > 1) and FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    sDate := AArgs[0];
    rFS.TwoDigitYearCenturyWindow := 50;
    if N > 0 then
      rFS.ShortDateFormat := AArgs[1]
    else
      rFS.ShortDateFormat := FormatSettings.ShortDateFormat;
    for i := 1 to Length(sDate) do
      if not FDInSet(sDate[i], ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', ' ']) then begin
        rFS.DateSeparator := sDate[i];
        Break;
      end;
    Result := StrToDate(sDate, rFS);
  end;
end;

{-------------------------------------------------------------------------------}
function FunToTime(const AArgs: array of Variant): Variant;
var
  N, i: Integer;
  sTime: String;
  rFS: TFormatSettings;
begin
  N := Length(AArgs) - 1;
  if FDStrIsNull(AArgs[0]) or
    (N > 0) and FDStrIsNull(AArgs[1]) or
    (N > 1) and FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    sTime := AArgs[0];
    rFS.TwoDigitYearCenturyWindow := 50;
    if N > 0 then
      rFS.ShortTimeFormat := AArgs[1]
    else
      rFS.ShortTimeFormat := FormatSettings.ShortTimeFormat;
    for i := 1 to Length(sTime) do
      if not FDInSet(sTime[i], ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', ' ']) then begin
        rFS.TimeSeparator := sTime[i];
        Break;
      end;
    Result := StrToTime(sTime, rFS);
  end;
end;

{-------------------------------------------------------------------------------}
function VarRemOleStr(const AValue: Variant): Variant;
begin
  if VarType(AValue) = varOleStr then
    Result := VarAsType(AValue, varUString)
  else
    Result := AValue;
end;

{-------------------------------------------------------------------------------}
function FunToNumber(const AArgs: array of Variant): Variant;
var
  N: Integer;
begin
              
                          
 
  N := Length(AArgs) - 1;
  if FDStrIsNull(AArgs[0]) or
    (N > 0) and FDStrIsNull(AArgs[1]) or
    (N > 1) and FDStrIsNull(AArgs[2]) then
    Result := Null
  else
    Result := VarAsType(VarRemOleStr(AArgs[0]), varDouble);
end;

{-------------------------------------------------------------------------------}
function FunDecode(const AArgs: array of Variant): Variant;
var
  n, i: Integer;
begin
  n := Length(AArgs) - 1;
  i := 1;
  Result := AArgs[0];
  while i <= n - 1 do begin
    if Result = AArgs[i] then begin
      Result := AArgs[i + 1];
      Break;
    end;
    Inc(i, 2);
  end;
  if i = n then
    Result := AArgs[i];
end;

{-------------------------------------------------------------------------------}
function FunNvl(const AArgs: array of Variant): Variant;
begin
  Result := AArgs[0];
  if FDStrIsNull(Result) then
    Result := AArgs[1];
end;

{-------------------------------------------------------------------------------}
function FunGreatest(const AArgs: array of Variant): Variant;
var
  n, i: Integer;
begin
  n := Length(AArgs) - 1;
  Result := AArgs[0];
  for i := 0 to n do begin
    if FDStrIsNull(AArgs[i]) then begin
      Result := Null;
      Break;
    end;
    if Result < AArgs[i] then
      Result := AArgs[i];
  end;
end;

{-------------------------------------------------------------------------------}
function FunLeast(const AArgs: array of Variant): Variant;
var
  n, i: Integer;
begin
  n := Length(AArgs) - 1;
  Result := AArgs[0];
  for i := 0 to n do begin
    if FDStrIsNull(AArgs[i]) then begin
      Result := Null;
      Break;
    end;
    if Result > AArgs[i] then
      Result := AArgs[i];
  end;
end;

{-------------------------------------------------------------------------------}
function FunRowNum(const AArgs: array of Variant; const AExpr: IFDStanExpressionEvaluator): Variant;
begin
  Result := AExpr.DataSource.RowNum;
end;

{-------------------------------------------------------------------------------}
function FunDatabase(const AArgs: array of Variant; const AExpr: IFDStanExpressionEvaluator): Variant;
begin
  Result := AExpr.DataSource.Database;
end;

{-------------------------------------------------------------------------------}
function FunUser(const AArgs: array of Variant; const AExpr: IFDStanExpressionEvaluator): Variant;
begin
  Result := AExpr.DataSource.User;
end;

{-------------------------------------------------------------------------------}
function FunInsert(const AArgs: array of Variant): Variant;
var
  i, iIndex, iCount: Integer;
  sWhat, sTo: String;
begin
  for i := 0 to 2 do
    if FDStrIsNull(AArgs[i]) then begin
      Result := Null;
      Exit;
    end;
  sTo := AArgs[0];
  sWhat := AArgs[3];
  iIndex := VarAsType(AArgs[1], varInteger);
  iCount := VarAsType(AArgs[2], varInteger);
  Delete(sTo, iIndex, iCount);
  if not FDStrIsNull(AArgs[3]) then
    Insert(sWhat, sTo, iIndex);
  Result := sTo;
end;

{-------------------------------------------------------------------------------}
function FunLeft(const AArgs: array of Variant): Variant;
var
  iIndex: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if FDStrIsNull(AArgs[1]) then
    Result := AArgs[0]
  else begin
    iIndex := VarAsType(AArgs[1], varInteger);
    Result := Copy(VarToStr(AArgs[0]), 1, iIndex);
  end;
end;

{-------------------------------------------------------------------------------}
function FunRight(const AArgs: array of Variant): Variant;
var
  iIndex: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if FDStrIsNull(AArgs[1]) then
    Result := AArgs[0]
  else begin
    iIndex := VarAsType(AArgs[1], varInteger);
    Result := Copy(VarToStr(AArgs[0]), Length(AArgs[0]) - iIndex + 1, iIndex);
  end;
end;

{-------------------------------------------------------------------------------}
function FunPos(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else
    Result := Pos(VarToStr(AArgs[0]), VarToStr(AArgs[1]));
end;

{-------------------------------------------------------------------------------}
function FunLocate(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else if (Length(AArgs) > 2) and not FDStrIsNull(AArgs[2]) then
    Result := Pos(VarToStr(AArgs[0]), VarToStr(AArgs[1]), AArgs[2])
  else
    Result := Pos(VarToStr(AArgs[0]), VarToStr(AArgs[1]));
end;

{-------------------------------------------------------------------------------}
function FunRepeat(const AArgs: array of Variant): Variant;
var
  i: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if FDStrIsNull(AArgs[1]) then
    Result := AArgs[0]
  else begin
    Result := '';
    for i := 0 to AArgs[1] - 1 do
      Result := Result + AArgs[0];
  end;
end;

{-------------------------------------------------------------------------------}
function FunSpace(const AArgs: array of Variant): Variant;
var
  i: Integer;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Result := '';
    for i := 0 to AArgs[0] - 1 do
      Result := Result + ' ';
  end;
end;

{-------------------------------------------------------------------------------}
function FunACos(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if (AArgs[0] < -1) or (AArgs[0] > 1) then
    Result := Null
  else
    Result := ArcCos(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunASin(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if (AArgs[0] < -1) or (AArgs[0] > 1) then
    Result := Null
  else
    Result := ArcSin(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunATan(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := ArcTan(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunATan2(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else if AArgs[0] = 0 then
    Result := Null
  else
    Result := ArcTan(AArgs[1] / AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunCot(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else if Tan(AArgs[0]) = 0 then
    Result := Null
  else
    Result := 1 / Tan(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunDegrees(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := 180 / C_FD_Pi * AArgs[0];
end;

{-------------------------------------------------------------------------------}
function FunLog10(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := Log10(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunPi(const AArgs: array of Variant): Variant;
begin
  Result := C_FD_Pi;
end;

{-------------------------------------------------------------------------------}
function FunRadians(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := C_FD_Pi / 180 * AArgs[0];
end;

{-------------------------------------------------------------------------------}
function FunRand(const AArgs: array of Variant): Variant;
var
  iRange, iLen, i: Integer;
  sRange, sVal: String;
begin
  if Length(AArgs) = 0 then
    Result := Random
  else
    if (VarType(AArgs[0]) = varUString) or
       (VarType(AArgs[0]) = varString) or
       (VarType(AArgs[0]) = varOleStr) then begin
      sRange := AArgs[0];
      if Length(AArgs) >= 2 then
        iLen := AArgs[1]
      else
        iLen := 1;
      SetLength(sVal, iLen);
      for i := 1 to iLen do
        sVal[i] := sRange[1 + Random(Length(sRange))];
    end
    else begin
      iRange := VarAsType(AArgs[0], varInteger);
      Result := Random(iRange);
    end;
end;

{-------------------------------------------------------------------------------}
function FunGetTime(const AArgs: array of Variant): Variant;
begin
  Result := Now - Trunc(Now);
end;

{-------------------------------------------------------------------------------}
function FunGetCurDate(const AArgs: array of Variant): Variant;
begin
  Result := Trunc(Now) + 0.0;
end;

{-------------------------------------------------------------------------------}
function FunDayName(const AArgs: array of Variant): Variant;
var
  s: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    s := '';
    DateTimeToString(s, 'dddd', TDateTime(VarAsType(AArgs[0], varDouble)));
    Result := s;
  end
end;

{-------------------------------------------------------------------------------}
function FunDayOfWeek(const AArgs: array of Variant): Variant;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else
    Result := DayOfWeek(AArgs[0]);
end;

{-------------------------------------------------------------------------------}
function FunDayOfYear(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    Result := Integer(Trunc(Double(AArgs[0] - EncodeDate(Y, 1, 1))) + 1);
  end
end;

{-------------------------------------------------------------------------------}
function FunExtract(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
  H, MM, S, MS: Word;
  sWhat: String;
  V: Variant;
  rInt: TFDSQLTimeInterval;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    sWhat := Trim(AnsiUpperCase(AArgs[0]));
    V := AArgs[1];
    if FDVarIsSQLTimeInterval(V) then begin
      rInt := FDVar2SQLTimeInterval(V);
      if sWhat = 'YEAR' then
        Result := rInt.Years
      else if sWhat = 'MONTH' then
        Result := rInt.Months
      else if sWhat = 'DAY' then
        Result := rInt.Days
      else if sWhat = 'HOUR' then
        Result := rInt.Hours
      else if sWhat = 'MINUTE' then
        Result := rInt.Minutes
      else if sWhat = 'SECOND' then
        Result := rInt.Seconds
      else if sWhat = 'FRAC_SECOND' then
        Result := rInt.Fractions * 1000
      else
        ExprTypMisError;
    end
    else
    begin
      Y := 0;
      M := 0;
      D := 0;
      DecodeDate(V, Y, M, D);
      H := 0;
      MM := 0;
      S := 0;
      MS := 0;
      DecodeTime(V, H, MM, S, MS);
      if sWhat = 'YEAR' then
        Result := Y
      else if sWhat = 'MONTH' then
        Result := M
      else if sWhat = 'DAY' then
        Result := D
      else if sWhat = 'HOUR' then
        Result := H
      else if sWhat = 'MINUTE' then
        Result := MM
      else if sWhat = 'SECOND' then
        Result := S
      else if sWhat = 'FRAC_SECOND' then
        Result := MS * 1000
      else
        ExprTypMisError;
    end;
  end
end;

{-------------------------------------------------------------------------------}
function FunMonthName(const AArgs: array of Variant): Variant;
var
  s: String;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    s := '';
    DateTimeToString(s, 'mmmm', TDateTime(VarAsType(AArgs[0], varDouble)));
    Result := s;
  end
end;

{-------------------------------------------------------------------------------}
function FunQuarter(const AArgs: array of Variant): Variant;
var
  Y, M, D: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    if M < 4 then
      Result := 1
    else if (M >= 4) and (M < 7) then
      Result := 2
    else if (M >= 6) and (M < 10) then
      Result := 3
    else
      Result := 4;
  end
end;

{-------------------------------------------------------------------------------}
function FunTimeStampAdd(const AArgs: array of Variant): Variant;
var
  sWhat: String;
  iInterval: Integer;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) or FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    sWhat := Trim(AnsiUpperCase(AArgs[0]));
    if sWhat = 'FRAC_SECOND' then
      Result := VarAsType(((AArgs[2] * MSecsPerDay) + AArgs[1] div 1000) / MSecsPerDay, varDate)
    else begin
      iInterval := AArgs[1];
      if sWhat = 'SECOND' then
        Result := ((AArgs[2] * SecsPerDay) + iInterval) / SecsPerDay
      else if sWhat = 'MINUTE' then
        Result := ((AArgs[2] * MinsPerDay) + iInterval) / MinsPerDay
      else if sWhat = 'HOUR' then
        Result := ((AArgs[2] * HoursPerDay) + iInterval) / HoursPerDay
      else if sWhat = 'DAY' then
        Result := AArgs[2] + iInterval
      else if sWhat = 'WEEK' then
        Result := AArgs[2] + iInterval * 7
      else if sWhat = 'MONTH' then
        Result := IncMonth(AArgs[2], iInterval)
      else if sWhat = 'QUARTER' then
        Result := IncMonth(AArgs[2], iInterval * 3)
      else if sWhat = 'YEAR' then
        Result := IncMonth(AArgs[2], iInterval * 12)
      else
        ExprTypMisError;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function FunTimeStampDiff(const AArgs: array of Variant): Variant;
var
  sWhat: String;
  d: TDateTime;
  r: Double;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) or FDStrIsNull(AArgs[2]) then
    Result := Null
  else begin
    sWhat := Trim(AnsiUpperCase(AArgs[0]));
    d := AArgs[2] - AArgs[1];
    if sWhat = 'FRAC_SECOND' then begin
      d := MSecsPerDay * d;
      Result := Trunc(d) * 1000;
    end
    else if sWhat = 'SECOND' then begin
      d := SecsPerDay * d;
      Result := Integer(Trunc(d));
    end
    else if sWhat = 'MINUTE' then begin
      d := MinsPerDay * d;
      Result := Integer(Trunc(d));
    end
    else if sWhat = 'HOUR' then begin
      d := HoursPerDay * d;
      Result := Integer(Trunc(d));
    end
    else if sWhat = 'DAY' then
      Result := Integer(Trunc(d))
    else if sWhat = 'WEEK' then
      Result := Integer(Trunc(d / 7))
    else if sWhat = 'MONTH' then
      Result := Integer(Trunc(d / 30.4375))
    else if sWhat = 'QUARTER' then
      Result := Integer(Trunc(Trunc(d / 30.4375) / 3))
    else if sWhat = 'YEAR' then begin
      r := VarAsType(d, varDouble);
      if (r / 365 = Trunc(r / 365)) and (r / 365 > 0) then
        Result := r / 365
      else
        Result := Integer(Trunc(d / 365.25));
    end
    else
      ExprTypMisError;
  end
end;

{-------------------------------------------------------------------------------}
function FunWeek(const AArgs: array of Variant): Variant;
var
  Y, M, D, W: Word;
begin
  if FDStrIsNull(AArgs[0]) then
    Result := Null
  else begin
    Y := 0;
    M := 0;
    D := 0;
    DecodeDate(AArgs[0], Y, M, D);
    D := Word(Trunc(Double(AArgs[0] - EncodeDate(Y, 1, 1))) + 1);
    W := Word(D div 7);
    if D mod 7 <> 0 then
      Inc(W);
    Result := W;
  end
end;

{-------------------------------------------------------------------------------}
function FunConvert(const AArgs: array of Variant): Variant;
var
  sType: String;
  V: Variant;
begin
  if FDStrIsNull(AArgs[0]) or FDStrIsNull(AArgs[1]) then
    Result := Null
  else begin
    sType := Trim(AnsiUpperCase(AArgs[0]));
    V := AArgs[1];
    if sType = 'BIGINT' then
      Result := VarAsType(V, varInt64)
    else if sType = 'BINARY' then
      ExprTypMisError
    else if sType = 'BIT' then
      Result := VarAsType(V, varBoolean)
    else if sType = 'CHAR' then
      Result := VarAsType(V, varFDAString)
    else if sType = 'DECIMAL' then
      Result := VarAsType(V, VarFMTBcd)
    else if sType = 'DOUBLE' then
      Result := VarAsType(VarRemOleStr(V), varDouble)
    else if sType = 'FLOAT' then
      Result := VarAsType(VarRemOleStr(V), varDouble)
    else if sType = 'GUID' then
      Result := GUIDToString(StringToGUID(V))
    else if sType = 'INTEGER' then
      Result := VarAsType(V, varInteger)
    else if (sType = 'INTERVAL_MONTH') or (sType = 'INTERVAL_YEAR') or
            (sType = 'INTERVAL_YEAR_TO_MONTH') or (sType = 'INTERVAL_DAY') or
            (sType = 'INTERVAL_HOUR') or (sType = 'INTERVAL_MINUTE') or
            (sType = 'INTERVAL_SECOND') or (sType = 'INTERVAL_DAY_TO_HOUR') or
            (sType = 'INTERVAL_DAY_TO_MINUTE') or (sType = 'INTERVAL_DAY_TO_SECOND') or
            (sType = 'INTERVAL_HOUR_TO_MINUTE') or (sType = 'INTERVAL_HOUR_TO_SECOND') or
            (sType = 'INTERVAL_MINUTE_TO_SECOND') or (sType = 'INTERVAL') then
      Result := VarAsType(V, FDVarSQLTimeInterval)
    else if sType = 'LONGVARBINARY' then
      Result := VarAsType(V, varFDAString)
    else if sType = 'LONGVARCHAR' then
      Result := VarAsType(V, varFDAString)
    else if sType = 'NUMERIC' then
      Result := VarAsType(V, VarFMTBcd)
    else if sType = 'REAL' then
      Result := VarAsType(VarRemOleStr(V), varSingle)
    else if sType = 'SMALLINT' then
      Result := VarAsType(V, varSmallint)
    else if sType = 'DATE' then
      Result := Trunc(Double(VarAsType(V, varDate))) + 0.0
    else if sType = 'TIME' then
      Result := VarAsType(V, varDate) - (Trunc(Double(VarAsType(V, varDate))) + 0.0)
    else if sType = 'TIMESTAMP' then
      Result := VarAsType(V, VarSQLTimeStamp)
    else if sType = 'TINYINT' then
      Result := VarAsType(V, varShortInt)
    else if sType = 'VARBINARY' then
      Result := VarAsType(V, varFDAString)
    else if sType = 'VARCHAR' then
      Result := VarAsType(V, varFDAString)
    else if sType = 'WCHAR' then
      Result := VarAsType(V, varUString)
    else if sType = 'WLONGVARCHAR' then
      Result := VarAsType(V, varUString)
    else if sType = 'WVARCHAR' then
      Result := VarAsType(V, varUString)
    else
      ExprTypMisError;
  end
end;

{-------------------------------------------------------------------------------}
function FunNewGuid(const AArgs: array of Variant): Variant;
{$IFDEF POSIX}
var
  rGUID: TGUID;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Result := CreateClassID;
{$ENDIF}
{$IFDEF POSIX}
  if CreateGUID(rGUID) = 0 then
    Result := GUIDToString(rGUID)
  else
    Result := Null;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure RegisterFuncs;
var
  oMan: TFDExpressionManager;
begin
  oMan := FDExpressionManager();
  // ---------------------------------------------
  // Oracle's
  // Numeric
  oMan.AddFunction('ABS',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunAbs);
  oMan.AddFunction('CEIL',      ckUnknown, 0, dtInt32,     -1, 1, 1, 'f', @FunCeil);
  oMan.AddFunction('COS',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunCos);
  oMan.AddFunction('COSH',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunCosh);
  oMan.AddFunction('EXP',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunExp);
  oMan.AddFunction('FLOOR',     ckUnknown, 0, dtInt32,     -1, 1, 1, 'f', @FunFloor);
  oMan.AddFunction('LN',        ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunLn);
  oMan.AddFunction('LOG',       ckUnknown, 0, dtDouble,    -1, 1, 2, 'ff', @FunLog);
  oMan.AddFunction('MOD',       ckUnknown, 0, dtInt32,     -1, 2, 2, 'ii', @FunMod);
  oMan.AddFunction('POWER',     ckUnknown, 0, dtDouble,    -1, 2, 2, 'ff', @FunPower);
  oMan.AddFunction('ROUND',     ckUnknown, 0, dtDouble,    -1, 1, 2, 'fs', @FunRound);
  oMan.AddFunction('SIGN',      ckUnknown, 0, dtInt32,     -1, 1, 1, 'f', @FunSign);
  oMan.AddFunction('SIN',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunSin);
  oMan.AddFunction('SINH',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunSinh);
  oMan.AddFunction('SQRT',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunSqrt);
  oMan.AddFunction('TAN',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunTan);
  oMan.AddFunction('TANH',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunTanh);
  oMan.AddFunction('TRUNC',     ckUnknown, 0, dtDouble,    -1, 1, 2, 'fs', @FunTrunc);
  oMan.AddFunction('ROWNUM',    ckField,  -1, dtInt32,     -1, 0, 0, '', @FunRowNum);
  oMan.AddFunction('DATABASE',  ckField,  -1, dtAnsiString,-1, 0, 0, '', @FunDatabase);
  oMan.AddFunction('USER',      ckField,  -1, dtAnsiString,-1, 0, 0, '', @FunUser);
  // Strings, result string
  oMan.AddFunction('CHR',       ckUnknown, 0, dtAnsiString,-1, 1, 1, 'i', @FunChr);
  oMan.AddFunction('CONCAT',    ckUnknown, 0, dtUnknown,    0, 2, 2, 'ss', @FunConcat);
  oMan.AddFunction('INITCAP',   ckUnknown, 0, dtUnknown,    0, 1, 1, 's', @FunInitCap);
  oMan.AddFunction('LPAD',      ckUnknown, 0, dtUnknown,    0, 2, 3, 'sis', @FunLPad);
  oMan.AddSynonym('TRIMLEFT', 'LTRIM');
  oMan.AddFunction('REPLACE',   ckUnknown, 0, dtUnknown,    0, 2, 3, 'sss', @FunReplace);
  oMan.AddFunction('RPAD',      ckUnknown, 0, dtUnknown,    0, 2, 3, 'sis', @FunRPad);
  oMan.AddSynonym('TRIMRIGHT', 'RTRIM');
  oMan.AddSynonym('SUBSTRING', 'SUBSTR');
  oMan.AddFunction('TRANSLATE', ckUnknown, 0, dtUnknown,    0, 3, 3, 'sss', @FunTranslate);
  // Strings, result integer
  oMan.AddFunction('ASCII',     ckUnknown, 0, dtInt32,     -1, 1, 1, 'a', @FunAscii);
  oMan.AddFunction('INSTR',     ckUnknown, 0, dtInt32,     -1, 2, 4, 'ssii', @FunInstr);
  oMan.AddFunction('LENGTH',    ckUnknown, 0, dtInt32,     -1, 1, 1, 's', @FunLength);
  // Date
  oMan.AddFunction('ADD_MONTHS',ckUnknown, 0, dtDateTime,  -1, 2, 2, 'di', @FunAddMonths);
  oMan.AddFunction('MONTHS_BETWEEN',
                                ckUnknown, 0, dtInt32,     -1, 2, 2, 'dd', @FunMonthsBW);
  oMan.AddFunction('LAST_DAY',  ckUnknown, 0, dtDateTime,  -1, 1, 1, 'd', @FunLastDay);
  oMan.AddFunction('FIRST_DAY', ckUnknown, 0, dtDateTime,  -1, 1, 1, 'd', @FunFirstDay);
  oMan.AddFunction('NEXT_DAY',  ckUnknown, 0, dtDateTime,  -1, 2, 2, 'ds', @FunNextDay);
  oMan.AddSynonym('GETDATE', 'SYSDATE');
  // Convert
  oMan.AddFunction('TO_CHAR',   ckUnknown, 0, dtAnsiString,-1, 1, 2, '*s', @FunToChar);
  oMan.AddFunction('TO_DATE',   ckUnknown, 0, dtDateTime,  -1, 1, 2, 'ss', @FunToDate);
  oMan.AddFunction('TO_TIME',   ckUnknown, 0, dtDateTime,  -1, 1, 2, 'ss', @FunToTime);
  oMan.AddFunction('TO_NUMBER', ckUnknown, 0, dtDouble,    -1, 1, 2, 'ss', @FunToNumber);
  // Others
  oMan.AddFunction('DECODE',    ckUnknown, 2, dtUnknown,    2, 3, MAXINT, '***', @FunDecode);
  oMan.AddFunction('NVL',       ckUnknown, 0, dtUnknown,    0, 2, 2,      '**', @FunNvl);
  oMan.AddFunction('GREATEST',  ckUnknown, 0, dtUnknown,    0, 1, MAXINT, '*', @FunGreatest);
  oMan.AddFunction('LEAST',     ckUnknown, 0, dtUnknown,    0, 1, MAXINT, '*', @FunLeast);
  // Used in semi-natural language
  oMan.AddSynonym('GETDATE', 'TODAY');

  // ---------------------------------------------
  // ODBC escape funcs
  oMan.AddSynonym('CHR', 'CHAR');
  oMan.AddSynonym('LENGTH', 'CHAR_LENGTH');
  oMan.AddSynonym('CHAR_LENGTH', 'CHARACTER_LENGTH');
  oMan.AddFunction('INSERT',    ckUnknown, 0, dtAnsiString,-1, 4, 4, 'siis', @FunInsert);
  oMan.AddSynonym('LOWER', 'LCASE');
  oMan.AddFunction('LEFT',      ckUnknown, 0, dtAnsiString,-1, 2, 2, 'si', @FunLeft);
  oMan.AddFunction('LOCATE',    ckUnknown, 0, dtInt32,     -1, 2, 3, 'ssi', @FunLocate);
  oMan.AddSynonym('LENGTH', 'OCTET_LENGTH');
  oMan.AddFunction('POSITION',  ckUnknown, 0, dtInt32,     -1, 2, 2, 'ss', @FunPos);
  oMan.AddFunction('REPEAT',    ckUnknown, 0, dtAnsiString,-1, 2, 2, 'si', @FunRepeat);
  oMan.AddFunction('RIGHT',     ckUnknown, 0, dtAnsiString,-1, 2, 2, 'si', @FunRight);
  oMan.AddFunction('SPACE',     ckUnknown, 0, dtAnsiString,-1, 1, 1, 'i', @FunSpace);
  oMan.AddSynonym('UPPER', 'UCASE');
  oMan.AddFunction('ACOS',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunACos);
  oMan.AddFunction('ASIN',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunASin);
  oMan.AddFunction('ATAN',      ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunATan);
  oMan.AddFunction('ATAN2',     ckUnknown, 0, dtDouble,    -1, 2, 2, 'ff', @FunATan2);
  oMan.AddFunction('CEILING',   ckUnknown, 0, dtInt32,     -1, 1, 1, 'f', @FunCeil);
  oMan.AddFunction('COT',       ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunCot);
  oMan.AddFunction('DEGREES',   ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunDegrees);
  oMan.AddFunction('LOG10',     ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunLog10);
  oMan.AddFunction('PI',        ckConst, 0, dtDouble,      -1, 0, 0, '', @FunPi);
  oMan.AddFunction('RADIANS',   ckUnknown, 0, dtDouble,    -1, 1, 1, 'f', @FunRadians);
  Randomize;
  oMan.AddFunction('RAND',      ckUnknown, 0, dtUnknown,    0, 0, 2, '*i', @FunRand);
  oMan.AddSynonym('TRUNC', 'TRUNCATE');
  oMan.AddFunction('CURRENT_DATE',
                                ckConst,  -1, dtDateTime,  -1, 0, 0, '', @FunGetCurDate);
  oMan.AddFunction('CURRENT_TIME',
                                ckConst,  -1, dtDateTime,  -1, 0, 0, '', @FunGetTime);
  oMan.AddSynonym('GETDATE', 'CURRENT_TIMESTAMP');
  oMan.AddSynonym('CURRENT_DATE', 'CURDATE');
  oMan.AddSynonym('CURRENT_TIME', 'CURTIME');
  oMan.AddFunction('DAYNAME',   ckUnknown, 0, dtAnsiString,-1, 1, 1, 'd', @FunDayName);
  oMan.AddSynonym('DAY', 'DAYOFMONTH');
  oMan.AddFunction('DAYOFWEEK', ckUnknown, 0, dtInt16,     -1, 1, 1, 'd', @FunDayOfWeek);
  oMan.AddFunction('DAYOFYEAR', ckUnknown, 0, dtInt16,     -1, 1, 1, 'd', @FunDayOfYear);
  oMan.AddFunction('EXTRACT',   ckUnknown, 0, dtInt32,     -1, 2, 2, 'sd', @FunExtract);
  oMan.AddFunction('MONTHNAME', ckUnknown, 0, dtAnsiString,-1, 1, 1, 'd', @FunMonthName);
  oMan.AddSynonym('GETDATE', 'NOW');
  oMan.AddFunction('QUARTER',   ckUnknown, 0, dtInt16,     -1, 1, 1, 'd', @FunQuarter);
  oMan.AddFunction('TIMESTAMPADD',
                                ckUnknown, 0, dtDateTime,  -1, 3, 3, 'sid', @FunTimeStampAdd);
  oMan.AddFunction('TIMESTAMPDIFF',
                                ckUnknown, 0, dtInt32,     -1, 3, 3, 'sdd', @FunTimeStampDiff);
  oMan.AddFunction('WEEK',      ckUnknown, 0, dtInt16,     -1, 1, 1, 'd', @FunWeek);
  oMan.AddSynonym('NVL', 'IFNULL');
  oMan.AddFunction('CONVERT',   ckUnknown, 0, dtUnknown,   -1, 2, 2, 's*', @FunConvert);

  // ---------------------------------------------
  // Other
  oMan.AddFunction('NEWGUID',   ckConst,  -1, dtGUID,      -1, 0, 0, '', @FunNewGuid);
end;

{-------------------------------------------------------------------------------}
initialization

  RegisterFuncs;

end.
