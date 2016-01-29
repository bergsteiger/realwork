{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.FmtBcd;

interface

uses
  System.SysUtils;

const
  MaxStringDigits = 100;
  _NoDecimal = -255;
  _DefaultDecimals = 10;

  { From DB.pas }
  { Max supported by Midas }
  MaxFMTBcdFractionSize = 64;
  { Max supported by Midas }
  MaxFMTBcdDigits =   32;
  DefaultFMTBcdScale = 6;
  MaxBcdPrecision =   18;
  MaxBcdScale     =   4;
  SizeOfFraction  = 32;
  SizeOfTBCD      = 2 + SizeOfFraction;

type
  PBcd = ^TBcd;
  TBcd  = record
    Precision: Byte;                        { 1..64 }
    SignSpecialPlaces: Byte;                { Sign:1, Special:1, Places:6 }
    Fraction: packed array [0..31] of Byte; { BCD Nibbles, 00..99 per Byte, high Nibble 1st }

    class operator Implicit(const str: string): TBcd;
    class operator Implicit(const d: double): TBcd;
    class operator Implicit(const I: Integer): TBcd;
    class operator Explicit(const ABcd: TBcd): string;
    class operator Explicit(const ABcd: TBcd): Integer;

    class operator Add(const A, B: TBcd): TBcd;
    class operator Subtract(const A, B: TBcd): TBcd;
    class operator Multiply(const A, B: TBcd): TBcd;
    class operator Divide(const A, B: TBcd): TBcd;
    class operator Negative(const A: TBcd): TBcd;

    class operator Equal(const A, B: TBcd): Boolean;
    class operator NotEqual(const A, B: TBcd): Boolean;
    class operator GreaterThan(const A, B: TBcd): Boolean;
    class operator LessThan(const A, B: TBcd): Boolean;
    class operator GreaterThanOrEqual(const A, B: TBcd): Boolean;
    class operator LessThanOrEqual(const A, B: TBcd): Boolean;
  end;

{ Exception classes }
  EBcdException = class(Exception);
  EBcdOverflowException = class(EBcdException);

{ Utility functions for TBcd access }

function BcdFromBytes(const AValue: TArray<Byte>): TBcd;
function BcdToBytes(const Value: TBcd): TArray<Byte>;

function BcdPrecision(const Bcd: TBcd): Word;
function BcdScale(const Bcd: TBcd): Word; inline;
function IsBcdNegative(const Bcd: TBcd): Boolean; inline;

{ Bcd Arithmetic}

procedure BcdAdd(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd);
procedure BcdSubtract(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd);
procedure BcdMultiply(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd); overload;
procedure BcdDivide(const Dividend, Divisor: TBcd; var bcdOut: TBcd); overload;
{ Returns True if successful, False if Int Digits needed to be truncated }
function NormalizeBcd(const InBCD: TBcd; var OutBcd: TBcd; Precision, Places: Integer): Boolean;
function BcdCompare(const bcd1, bcd2: TBcd): Integer;
function BCDRoundTo(const bcdIn: TBcd; Digits: Integer): TBcd;

{ Convert String/Double/Integer to BCD struct }
function StrToBcd(const AValue: string): TBcd; overload;
function StrToBcd(const AValue: string; Format: TFormatSettings): TBcd; overload;
function TryStrToBcd(const AValue: string; var Bcd: TBcd): Boolean; overload;
function TryStrToBcd(const AValue: string; var Bcd: TBcd; Format: TFormatSettings): Boolean; overload;
function DoubleToBcd(const AValue: Double): TBcd; overload;
procedure DoubleToBcd(const AValue: Double; var bcd: TBcd); overload;
function IntegerToBcd(const AValue: Integer): TBcd;


{ Convert Bcd struct to string/Double/Integer }
function BcdToStr(const Bcd: TBcd): string; overload;
function BcdToStr(const Bcd: TBcd; Format: TFormatSettings): string; overload;
function BcdToDouble(const Bcd: TBcd): Double;
function BcdToInteger(const Bcd: TBcd; Truncate: Boolean = False): Integer;

{ From DB.pas }
function CurrToBCD(const Curr: Currency; var BCD: TBcd; Precision: Integer = 32;
  Decimals: Integer = 4): Boolean;
function BCDToCurr(const BCD: TBcd; var Curr: Currency): Boolean;

function CurrencyToBcd(const Curr: Currency): TBcd;
function BCDToCurrency(const BCD: TBcd): Currency;

{ Formatting Bcd as string }
function BcdToStrF(const Bcd: TBcd; Format: TFloatFormat;
  const Precision, Digits: Integer): string; overload;
function BcdToStrF(const Bcd: TBcd; Format: TFloatFormat;
  const Precision, Digits: Integer; FS: TFormatSettings): string; overload;
function FormatBcd(const Format: string; Bcd: TBcd): string; overload;
function FormatBcd(const Format: string; Bcd: TBcd; FS: TFormatSettings): string; overload;

{ TBcd variant creation utils }
procedure VarFMTBcdCreate(var ADest: Variant; const ABcd: TBcd); overload;
function VarFMTBcdCreate: Variant; overload;
function VarFMTBcdCreate(const AValue: string; Precision, Scale: Word): Variant; overload;
function VarFMTBcdCreate(const AValue: Double; Precision: Word = 18; Scale: Word = 4): Variant; overload;
function VarFMTBcdCreate(const ABcd: TBcd): Variant; overload;
function VarIsFMTBcd(const AValue: Variant): Boolean; overload;
function VarFMTBcd: TVarType;
function VarToBcd(const AValue: Variant): TBcd;

const
  NullBcd: TBcd = (
    Precision: 0;
    SignSpecialPlaces: 0;
    Fraction: (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));

// deprecated overloads
{$IFNDEF NEXTGEN}
procedure BcdMultiply(const bcdIn: TBcd; const DoubleIn: Double; var bcdOut: TBcd); overload; deprecated 'use BcdMultiply(TBcd, TBcd, TBcd)';
procedure BcdMultiply(const bcdIn: TBcd; const StringIn: string; var bcdOut: TBcd); overload; deprecated 'use BcdMultiply(TBcd, TBcd, TBcd)';
procedure BcdMultiply(StringIn1, StringIn2: string; var bcdOut: TBcd); overload; deprecated 'use BcdMultiply(TBcd, TBcd, TBcd)';
procedure BcdDivide(Dividend, Divisor: string; var bcdOut: TBcd); overload; deprecated 'use BcdDivide(TBcd, TBcd, TBcd)';
procedure BcdDivide(const Dividend: TBcd; const Divisor: Double; var bcdOut: TBcd); overload; deprecated 'use BcdDivide(TBcd, TBcd, TBcd)';
procedure BcdDivide(const Dividend: TBcd; const Divisor: string; var bcdOut: TBcd); overload; deprecated 'use BcdDivide(TBcd, TBcd, TBcd)';

function RoundAt(const Value: string; Position: SmallInt): string; deprecated 'use BcdRoundTo';
{$ENDIF !NEXTGEN}

var
  BcdOverflowChecks: Boolean;

implementation

uses
  System.Classes,
  System.Variants,
  System.TypInfo,
  System.Math,
  System.SysConst,
  Data.DBConsts;

const
  BcdOne: TBcd = (Precision: 2; SignSpecialPlaces: 1;
    Fraction: ($10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) );
  BcdZero: TBcd = (Precision: 0; SignSpecialPlaces: 0;
    Fraction: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) );

procedure BcdError(const Message: string);
begin
  raise EBcdException.Create(Message);
end;

procedure BcdErrorFmt(const Message, BcdAsString: string);
begin
  raise EBcdException.CreateFmt(Message, [BcdAsString]);
end;

procedure OverflowError(const Message: string);
begin
  raise EBcdOverflowException.Create(Message);
end;

function IsZero(const ABcd: TBcd): Boolean;
var
  I: Integer;
begin
  for I := 0 to ((ABcd.Precision) div 2) - 1 do
    if ABcd.Fraction[I] <> 0 then Exit(False);
  if ((abcd.Precision and 1) <> 0) and
    ((ABcd.Fraction[(Abcd.Precision + 1) div 2 - 1] and $F0) <> 0) then
      Exit(false);

  Result := True;
end;

procedure RequiredDigits(ABcd: TBcd; out Left, Right: Integer);
var
  I: Integer;
  B: Byte;
begin
  Right :=  ABcd.SignSpecialPlaces and 63;
  Left := ABcd.Precision - Right;
  for I := 0 to (ABcd.Precision div 2) - 1 do
  begin
    if ABcd.Fraction[I] = 0 then
      Dec(Left, 2)
    else
    begin
      if (ABcd.Fraction[I] and $F0) = 0 then
        Dec(Left);
      break;
    end;
    if Left <= 0 then
    begin
      Left := 0;
      break;
    end;
  end;
  if Right > 0 then
    for I := 1 to (abcd.SignSpecialPlaces and 63)  do
    begin
      if ((ABcd.Precision - I) and 1) = 0 then
        B := ABcd.Fraction[(ABcd.Precision - I) div 2 ] and $F0
      else
        B := ABcd.Fraction[(ABcd.Precision - I) div 2 ] and $F
        ;
      if B = 0 then
        dec(Right)
      else
        Break;
    end;
end;

function Compact(const ABcd: TBcd; out Power: Integer): TBcd;
var
  Left, Right: Integer;
  B: Byte;
begin
  Power := 0;
  if IsZero(ABcd) then
  begin
    Exit(BcdZero);
  end;
  Left := 0;
  while Left < abcd.Precision do
  begin
    B := ABcd.Fraction[Left div 2];
    if (((Left and 1) = 0) and ((B and $F0) <> 0)) or
       (((Left and 1) = 1) and ((B and $0F) <> 0)) then
       break;
    Inc(Left);
  end;
  Right := Abcd.Precision - 1;
  while Right > Left do
  begin
    B := ABcd.Fraction[Right div 2];
    if (((Right and 1) = 0) and ((B and $F0) <> 0)) or
       (((Right and 1) = 1) and ((B and $0F) <> 0)) then
       break;
    Dec(Right);
  end;
  Power := abcd.Precision - (ABcd.SignSpecialPlaces and 63) - Left-1;
  Result.Fraction := ABcd.Fraction;
  Result.Precision := Right + 1;
  Result.SignSpecialPlaces := 0;
  normalizeBCD(Result, Result, 1 + Right - Left, 0);
  Result.SignSpecialPlaces := (Result.Precision - 1) or (Abcd.SignSpecialPlaces and $80);

end;

procedure NormalizePair(const A, B: TBcd; var NA, NB: TBcd);
var
  LeftA, RightA: Integer;
  LeftB, RightB: Integer;
  LeftMax, RightMin: Integer;
  Precision: Integer;
begin
  NA := A;
  NB := B;
  if (NA.Precision = NB.Precision) and
    ((NA.SignSpecialPlaces and 63) = (NB.SignSpecialPlaces and 63) ) then
    Exit;
  RequiredDigits(NA, LeftA, RightA);
  RequiredDigits(NB, LeftB, RightB);
  LeftMax := Max(LeftA, LeftB);
  if LeftMax = 0 then LeftMax := 1;
  RightMin := Min(64 - LeftMax, Max(RightA, RightB));
  Precision := LeftMax + RightMin;
  if (Precision < 64) and (((Precision) and 1) <> 0) then
  begin
    Inc(Precision);
    Inc(RightMin);
  end;

  NormalizeBcd(NA, NA, Precision, RightMin);
  NormalizeBcd(NB, NB, Precision, RightMin);
end;

function PackedBCDAdd(A, B: UInt32; var Carry: UInt32): UInt32;
// Adds 3 bytes of BCD (6 digits) plus a carry in/out
// Note: A and B must be in range of $000000 and $999999. Carry must be 0 or 1
var
  T1, T2, T3, T4, T5, T6: UInt32;
begin
  T1 := A + $00666666; // Assume A is valid, T1 produces no carrys
  T2 := T1 + B + Carry;
  T3 := T1 xor B; // T2 and T3 differ where there are carries
  T4 := T2 xor T3;
  T5 := (not T4)  and $01111110; // T5 is the carries
  T6 := (T5 SHR 2) or ( T5 SHR 3 ); // 6 if there is no carry, 0 if there was
  Result := T2 - T6;
  Carry := Result SHR 24;
  Result := Result and $FFFFFF;
end;

procedure DoAdd(const NA, NB: TBcd; out Result: TBcd; IgnoreCarry: Boolean = False);
var
  I, J: Integer;
  Sum, L, R, C: UInt32;
begin
  I := NA.Precision;
  C := 0;
  while I > 0 do
  begin
    J := (I + 1) div 2 - 1;
    if J = 0 then
    begin
      L := NA.Fraction[0];
      R := NB.Fraction[0];
    end
    else if J = 1 then
    begin
      L := (NA.Fraction[0] * $100) + NA.Fraction[1];
      R := (NB.Fraction[0] * $100) + NB.Fraction[1];
    end
    else // J > 1
    begin
      L := (NA.Fraction[J-2] * $10000) + (NA.Fraction[J-1] * $100) + NA.Fraction[J];
      R := (NB.Fraction[J-2] * $10000) + (NB.Fraction[J-1] * $100) + NB.Fraction[J];
    end;
    Sum := PackedBCDAdd(L, R, C);
    if J = 0 then
    begin
      C := Sum div $100;
      Result.Fraction[0] := Sum and $FF;
    end
    else if J = 1 then
    begin
      C := Sum div $10000;
      Result.Fraction[0] := (Sum and $FF00) div $100;
      Result.Fraction[1] := Sum and $FF;
    end
    else
    begin
      Result.Fraction[J-2] := (Sum and $FF0000) div $10000;
      Result.Fraction[J-1] := (Sum and $FF00) div $100;
      Result.Fraction[J] := Sum and $FF;
    end;
    I := I - 6;
  end;
  Result.SignSpecialPlaces := NA.SignSpecialPlaces;
  Result.Precision := NA.Precision;
  if not IgnoreCarry and (C = 1) then
  begin
    // If we're about to carry past max precision, it's okay only if there are decimals
    // and the last one is a 0 or when BcdOverflowChecks is false
    if (Result.Precision = 64) and ((Result.SignSpecialPlaces and 63) > 0) and
      ((not BcdOverflowChecks) or ((Result.Fraction[31] and $0F) = 0)) then
    begin
      dec(result.Precision);
      Result.SignSpecialPlaces := (Result.SignSpecialPlaces and $80)
        or ((Result.SignSpecialPlaces and 63) - 1);
    end;
    if not NormalizeBcd(Result, Result, Result.Precision +1, Result.SignSpecialPlaces and 63) then
      OverflowError(SBcdOverflow);
    Result.Fraction[0] := Result.Fraction[0] or $10; // add in carry
  end;

end;

procedure TensComplement(var ABcd: TBcd);
var
  I: Integer;
  LOne: TBcd;
begin
  NormalizeBcd(BcdOne, LOne, ABcd.Precision, 0);
  for I := 0 to (ABcd.Precision) div 2 -1 do
    ABcd.Fraction[I] := $99 - ABcd.Fraction[I];
  if Abcd.Precision and 1 <> 0 then
    ABcd.Fraction[ABcd.Precision div 2] := $90 - (ABcd.Fraction[ABcd.Precision div 2] and $F0);
  DoAdd(ABcd, LOne, ABcd, True);
  ABcd.SignSpecialPlaces := ABcd.SignSpecialPlaces xor $80; // Swap sign
end;

{ TBcd }

class operator TBcd.Implicit(const str: string): TBcd;
begin
  if not TryStrToBcd(str, Result) then
    raise EBcdException.Create(SInvalidInput);
end;

class operator TBcd.Implicit(const I: Integer): TBcd;
begin
  Result := TBcd(IntToStr(I));
end;

class operator TBcd.Implicit(const d: double): TBcd;
begin
  Result := TBCD(FloatToStr(d));
end;

class operator TBcd.Explicit(const ABcd: TBcd): string;
begin
  Result := BcdToStr(ABcd, FormatSettings);
end;

class operator TBcd.Explicit(const ABcd: TBcd): Integer;
begin
  Result := StrToInt(string(ABcd));
end;

class operator TBcd.Add(const A, B: TBcd): TBcd;
begin
  BcdAdd(A, B, Result);
end;

class operator TBcd.Subtract(const A, B: TBcd): TBcd;
begin
  BcdSubtract(A, B, Result);
end;

class operator TBcd.Multiply(const A, B: TBcd): TBcd;
begin
  BcdMultiply(A, B, Result);
end;

class operator TBcd.Divide(const A, B: TBcd): TBcd;
begin
  BcdDivide(A, B, Result);
end;

class operator TBcd.Equal(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A, B) = 0;
end;

class operator TBcd.Negative(const A: TBcd): TBcd;
begin
  Result := A;
  Result.SignSpecialPlaces := Result.SignSpecialPlaces xor $80;
end;

class operator TBcd.NotEqual(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A, B) <> 0;
end;

class operator TBcd.GreaterThan(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A,B) > 0;
end;

class operator TBcd.LessThan(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A,B) < 0;
end;

class operator TBcd.GreaterThanOrEqual(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A,B) >= 0;
end;

class operator TBcd.LessThanOrEqual(const A, B: TBcd): Boolean;
begin
  Result := BcdCompare(A,B) <= 0;
end;
// End TBcd
function BcdFromBytes(const AValue: TArray<Byte>): TBcd;
begin
  Result.Precision := AValue[0];
  Result.SignSpecialPlaces := AValue[1];
  Move(AValue[2], Result.Fraction, 32);
end;

function BcdToBytes(const Value: TBcd): TArray<Byte>;
begin
  SetLength(Result, SizeOf(TBcd));
  Result[0] := Value.Precision;
  Result[1] := Value.SignSpecialPlaces;
  Move(Value.Fraction, Result[2], 32);
end;

function BcdPrecision(const Bcd: TBcd): Word;
begin
  Result := Bcd.Precision - BcdScale(Bcd);
end;

function BcdScale(const Bcd: TBcd): Word;
begin
  Result := (Bcd.SignSpecialPlaces and 63);
end;

function IsBcdNegative(const Bcd: TBcd): Boolean;
begin
  Result := (Bcd.SignSpecialPlaces and (1 shl 7)) <> 0;
end;

procedure BcdAdd(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd);
var
  NA, NB: TBcd;
  I: Integer;
begin
  NormalizePair(bcdIn1,bcdIn2, NA, NB);
  bcdOut := BcdZero;
  if NA.SignSpecialPlaces <> NB.SignSpecialPlaces then
  begin
    // Take 10s compilment before adding
    I := 0;
    while (I < ((NA.Precision + 1) div 2)) and (NA.Fraction[I] = NB.Fraction[I]) do
      Inc(I);
    if NA.Fraction[I] >= NB.Fraction[I] then
      TensComplement(NB)
    else
      TensComplement(NA);
    DoAdd(NA, NB, bcdOut, True); // Overflow expected. Ignore.
  end
  else
    DoAdd(NA, NB, bcdOut);
end;

procedure BcdSubtract(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd);
var
  LB: TBcd;
begin
  LB := bcdIn2;
  LB.SignSpecialPlaces := LB.SignSpecialPlaces xor $80; // Switch sign
  BcdAdd(bcdIn1, LB, bcdOut); // Add handles both addition and subtraction
end;

procedure BcdMultiply(const bcdIn1, bcdIn2: TBcd; var bcdOut: TBcd); overload;
var
  LA, LB: TBcd;
  PA, PB: Integer;
  N: Byte;
  I: Integer;
  Negative: Boolean;
begin
  if IsZero(bcdIn1) then
  begin
    bcdOut := bcdIn1;
    Exit;
  end;
  if IsZero(bcdIn2) then
  begin
    bcdOut := bcdIn2;
    Exit;
  end;
  Negative := (bcdIn1.SignSpecialPlaces and $80) <> (bcdIn2.SignSpecialPlaces and $80);
  LA := Compact(bcdIn1, PA); // A := LA * 10^PA, LA has no decimal
  LB := Compact(bcdIn2, PB); // B := LB * 10^PB, LB has no decimal
  Dec(PA, LA.SignSpecialPlaces and 63);
  Dec(PB, LB.SignSpecialPlaces and 63);
  LA.SignSpecialPlaces := 0;
  LB.SignSpecialPlaces := 0;
                                  
  if LA.Precision < LB.Precision then // Swap so LB has shortest precision
  begin
    bcdOut := LA; // use bcdOut as a tmp
    LA := LB;
    LB := bcdOut;
  end;
  bcdOut := BcdZero;
  for I := LB.Precision-1 downto 0 do
  begin
    if LA.Precision > MaxFMTBcdFractionSize then
      OverflowError(SBcdOverflow);
    if I and 1 = 0 then
      N := LB.Fraction[I div 2] div $10
    else
      N := LB.Fraction[I div 2] and $F;
    while N > 0 do
    begin
      bcdOut := bcdOut + LA;
      Dec(N);
    end;
    Inc(LA.Precision);
  end;
  PA := PA + PB;
  if PA > 0 then
  begin
    if bcdOut.SignSpecialPlaces <= PA then
    begin
      Dec(PA, bcdOut.SignSpecialPlaces);
      bcdOut.SignSpecialPlaces := 0;
    end;

    bcdOut.Precision := bcdOut.Precision + PA;
    if bcdOut.Precision > MaxFMTBcdFractionSize then
      OverflowError(SBcdOverflow);

  end;
  if PA < 0 then
  begin
    if 1-PA > (bcdOut.Precision - bcdOut.SignSpecialPlaces) then
    begin
      NormalizeBcd(bcdOut, bcdOut,1-PA, 0);
    end;
    inc(bcdOut.SignSpecialPlaces, -PA);
  end;

  if Negative then
    bcdOut.SignSpecialPlaces := bcdOut.SignSpecialPlaces or $80;
end;

procedure BcdDivide(const Dividend, Divisor: TBcd; var bcdOut: TBcd);
var
  LA, LB: TBcd;
  PA, PB: Integer;
  Diff: TBcd;
  Digit: Byte;
  Negative: Boolean;
begin
  if IsZero(Divisor) then  // Divisor = 0, DivByZero
    BcdError(SDivByZero);
  If IsZero(Dividend) then  // Dividend = 0, bcdOut := 0
  begin
    bcdOut := Dividend;
    Exit;
  end;
  Negative := (Dividend.SignSpecialPlaces and $80) <> (Divisor.SignSpecialPlaces  and $80);
  // Other possible special case optimizations:
  // Divisor = +/- 1, bcdOut := +/- Dividend
  // Divisor = +/ Dividend, bcdOut := 1 (Only one subtraction required, not much overhead)

  // Divide by repeated subtraction
  LA := Compact(Dividend, PA);
  LB := Compact(Divisor, PB);

  LA.SignSpecialPlaces := LA.SignSpecialPlaces and 63;
  LB.SignSpecialPlaces := $80 or (LB.SignSpecialPlaces);
  bcdOut := BcdZero;
  PA := PA - PB;
  if PA < 0 then
  begin
    bcdOut.Precision := -PA;
    bcdOut.signSpecialPlaces := -PA-1;
    PA := 0;
  end;

  while not IsZero(LA) do
  begin
    Digit := 0;
    BcdAdd(LA, LB, Diff);
    while (Diff.SignSpecialPlaces and $80) = 0 do
    begin
      LA := Diff;
      Inc(Digit);
      BcdAdd(LA, LB, Diff);
    end;

    Inc(bcdOut.Precision);
    if (bcdOut.Precision and 1 <> 0) then
      bcdOut.Fraction[bcdOut.Precision div 2] := Digit * $10
    else
      bcdOut.Fraction[(bcdOut.Precision -1) div 2] :=
        bcdOut.Fraction[(bcdOut.Precision -1) div 2] or Digit;

    if bcdOut.Precision > PA + 1 then
      Inc(bcdOut.SignSpecialPlaces);

    if (bcdOut.Precision = 64) or (bcdOut.Precision >= (PA + _DefaultDecimals + 1)) then
      break;

    if (LA.Precision < 64) and (LA.Precision < (PA + _DefaultDecimals + 1)) then
      Inc(LA.Precision)
    else if LA.SignSpecialPlaces > 0 then
      Dec(LA.SignSpecialPlaces);                        
  end;

  if bcdOut.Precision <= PA then
    bcdOut.Precision := PA + 1;

  if Negative then
    bcdOut.SignSpecialPlaces := bcdOut.SignSpecialPlaces or $80;
end;

function NormalizeBcd(const InBCD: TBcd; var OutBcd: TBcd; Precision, Places: Integer): Boolean;
var
  Distance : Integer;
  I: Integer;
  B: Byte;
begin
  if Precision > MaxFMTBcdFractionSize then
    Exit(False);
  OutBcd := InBcd;
  Result := True;
  if not ((OutBcd.Precision = Precision) and ((Outbcd.SignSpecialPlaces and 63) = Places)) then
  begin
    // Verify reducing Places will only truncate 0s
    for I := 0 to  (InBcd.SignSpecialPlaces and 63) - Places -1 do
    begin
      if ((InBcd.Precision - I) and 1) = 0 then
        B := InBcd.Fraction[(InBcd.Precision - I + 1) div 2 - 1] and $F
      else
        B := InBcd.Fraction[(InBcd.Precision - I + 1) div 2 - 1] div $10;
      if B <> 0 then
      begin
        Result := False;
        break;
      end;
    end;
    Distance := (InBcd.Precision - (InBcd.SignSpecialPlaces and 63)) - (Precision - Places);
    if Distance < 0 then // Move left to right
    begin
      for I := Precision - 1 downto 0 do
      begin
        if I+Distance < 0 then
          B := 0
        else if ((I+Distance) and 1) = 0 then
          B := InBcd.Fraction[(I + distance) div 2] div $10
        else
          B := InBcd.Fraction[(I + distance) div 2] and $F;
        if (I and 1) = 0 then
          OutBcd.Fraction[I div 2] := (OutBcd.Fraction[I div 2] and $F) or (B * $10)
        else
          OutBcd.Fraction[I div 2] := B;
      end
    end
    else if Distance > 0 then // move right to left
    begin
      for I := 0 to Distance-1 do // Verify we're only ditching leading 0s
      begin
        if ((I) and 1) = 0 then
          B := InBcd.Fraction[(I) div 2] div $10
        else
          B := InBcd.Fraction[(I) div 2] and $F;
        if B <> 0 then
        begin
          Result := False;
          Break;
        end;
      end;

      for I := 0 to Precision - 1 do
      begin
        if I+Distance > InBcd.Precision then
          B := 0
        else if ((I+Distance) and 1) = 0 then
          B := InBcd.Fraction[(I + distance) div 2] div $10
        else
          B := InBcd.Fraction[(I + distance) div 2] and $F;
        if (I and 1) = 0 then
          OutBcd.Fraction[I div 2] := (B * $10)
        else
          OutBcd.Fraction[I div 2] := B or OutBcd.Fraction[I div 2];
      end;
    end;
  end;
  if (Precision and 1) <> 0 then
    OutBcd.Fraction[Precision div 2] := OutBcd.Fraction[Precision div 2] and $F0;
  if Precision < 64 then
    fillchar(OutBcd.Fraction[(Precision+1) div 2], Length(Outbcd.Fraction) - ((Precision+1) div 2), 0);

  OutBcd.Precision := Precision;
  OutBcd.SignSpecialPlaces := (InBcd.SignSpecialPlaces and $80) + (Places and 63);
end;

function BcdCompare(const bcd1, bcd2: TBcd): Integer;
var
  Diff: TBcd;
begin
  Diff := bcd1 - bcd2;
  if IsZero(Diff) then Exit(0);
  if (Diff.SignSpecialPlaces and $80) = 0 then
    Result := 1
  else
    Result := -1;
end;

function BcdToStr(const Bcd: TBcd): string;
begin
  Result := BcdToStr(Bcd, FormatSettings);
end;

procedure PutChar(var Buf: PChar; C: Char);
begin
   Buf^ := C;
  Inc(Buf);
end;

function BcdToStr(const Bcd: TBcd; Format: TFormatSettings): string;
var
  Buf: array [0..66] of Char; //64 Nibbles + 1 sign + 1 decimal + #0
  PBuf: PChar;
  DecimalPos: Byte;
  I: Integer;
begin
  if Bcd.Precision = 0 then
    Exit('0');
  if (Bcd.Precision > MaxFMTBcdFractionSize) or
     ((Bcd.SignSpecialPlaces and $3F) > Bcd.Precision) then
    OverflowError(SBcdOverflow);
  PBuf := @Buf[1];
  DecimalPos := Bcd.Precision - Bcd.SignSpecialPlaces and $3F;
  for I := 0 to Bcd.Precision - 1 do
  begin
    if I = DecimalPos then
    begin
      if I = 0 then
        PutChar(PBuf, '0');
      PutChar(PBuf, Format.DecimalSeparator);
    end;
    if (I and 1) = 0 then
      PutChar(PBuf, Char( ((Bcd.Fraction[I div 2] and $F0) SHR 4) + ord('0')) )
    else
      PutChar(PBuf, Char( ((Bcd.Fraction[I div 2] and $0F)) + ord('0')) );
  end;
  // Remove trailing 0s after decmial
  Dec(PBuf);
  I := Bcd.Precision;
  while (I > DecimalPos) and (PBuf^ = '0') do
  begin
    Dec(PBuf);
    Dec(I);
  end;
  if PBuf^ = Format.DecimalSeparator then
    PBuf^ := #0
  else
    PBuf[1] := #0;
  PBuf := @Buf[1];
  // Remove leading 0s before decimal
  while PBuf^ = '0' do
    Inc(PBuf);
  if (PBuf^ = #0) or (PBuf^ = Format.DecimalSeparator) then
    Dec(PBuf);

  if ((Bcd.SignSpecialPlaces and $80) = $80) and
    not ((PBuf^ = '0') and (PBuf[1] = #0)) then // only add - if not 0
  begin
    Dec(PBuf);
    PBuf^ := '-';
  end;
  Result := PChar(PBuf);
end;

function StrToBcd(const AValue: string): TBcd;
begin
  if not TryStrToBcd(AValue, Result, FormatSettings) then
    BcdErrorFmt(SInvalidBcdValue, AValue);
end;

function StrToBcd(const AValue: string; Format: TFormatSettings): TBcd;
begin
  if not TryStrToBcd(AValue, Result, Format) then
    BcdErrorFmt(SInvalidBcdValue, AValue);
end;

function TryStrToBcd(const AValue: string; var Bcd: TBcd): Boolean;
begin
  Result := TryStrToBcd(AValue, Bcd, FormatSettings);
end;

function TryStrToBcd(const AValue: string; var Bcd: TBcd; Format: TFormatSettings): Boolean;

  function IsSpaceChar(theChar: Char): Boolean;
  begin
    Result := False;
    if (theChar = ' ') or (theChar = #6) or (theChar = #10) or (theChar = #13) or (theChar = #14) then
      Result := True;
  end;

var
  Negative: Boolean;
  PStr: PChar;
  DecimalPos, Exp: Integer;
  Pos: Byte;
begin
  FillChar(Bcd, SizeOf(Bcd), #0);
  PStr := @AValue[Low(AValue)];
  while IsSpaceChar(PStr^) do
    Inc(PStr);
  Negative := PStr^ = '-';
  if (Pstr^ = '-') or (PStr^ = '+') then
    Inc(PStr);
  // Skip leading 0s;
  while PStr^ = '0' do
    Inc(PStr);

  Pos := 0;
  DecimalPos := -1;
  while PStr^ <> #0 do
  begin
    if (PStr^ = Format.DecimalSeparator) then
    begin
      if DecimalPos <> -1 then Exit(False);
      if Pos = 0 then
        Inc(Pos);
      DecimalPos := Pos;
      Inc(PStr);
    end;
    if IsSpaceChar(PStr^) or (PStr^ = 'E') or (PStr^ = 'e') then
      Break;

    if (PStr^ < '0') or (PStr^ > '9') then
      Exit(False);

    if (Pos = 64) and (DecimalPos = -1) then
      Exit(False); // Too many digits
    if Pos < 64 then
    begin
      if (Pos and 1) = 0 then
        Bcd.Fraction[Pos div 2] := Byte(Ord(PStr^) - Ord('0')) * $10
      else
        Bcd.Fraction[Pos div 2] := (Bcd.Fraction[Pos div 2] and $F0) + Byte(Ord(PStr^) - Ord('0'));
      Inc(Pos);
    end;
    Inc(PStr);
  end;

  // Scientific notation
  if (PStr^ = 'E') or (PStr^ = 'e') then   // Most typical situation: X.XXEYYY. DecimalPos = 1
  begin
    if not TryStrToInt(PChar(@PStr[1]), Exp) then
      Exit(False);
    if DecimalPos < 0 then
    begin
      DecimalPos := Pos;
      Inc(Pos);
    end;
    if Exp < 0 then
    begin
      begin
        if DecimalPos < -Exp then
        begin
          bcd.Precision := Pos;
          bcd.SignSpecialPlaces := Pos -1;
          Exp := Pos - Exp;
          Pos := Pos - DecimalPos;
          if Exp > MaxFMTBcdFractionSize then
          begin
            dec(Pos,  Exp - MaxFMTBcdFractionSize);
            DecimalPos := Exp - MaxFMTBcdFractionSize;
            Exp := MaxFMTBcdFractionSize;
          end;
          if not NormalizeBcd(bcd, bcd, Exp, Pos) then
            Exit(False);
          Pos := Exp;
        end
        else
          Inc(DecimalPos, Exp);

      end;
    end
    else
    begin
      inc(DecimalPos, Exp);
      if DecimalPos > Pos then
      begin
        Pos := DecimalPos;
        DecimalPos := -1;
      end;
    end;

  end else
  begin
    while IsSpaceChar(PStr^) do
      Inc(PStr);
    if PStr^ <> #0 then
      Exit(False);
  end;

  if Pos = 0 then
  begin
    Bcd.Precision := 10;
    Bcd.SignSpecialPlaces := 2;
  end
  else
  begin
    if Pos > 64 then
      Exit(False);
    Bcd.Precision := Pos;
    if DecimalPos = -1 then
      Bcd.SignSpecialPlaces := 0
    else
      Bcd.SignSpecialPlaces := Pos - DecimalPos;
    // Because it's easier to shift bytes than nibbles,
    // Always make it an even precision, add a 0 if needed
    if (Pos and 1) = 1 then
    begin
      Inc(Bcd.Precision);
      Inc(Bcd.SignSpecialPlaces);
    end;

    if Negative then
      Bcd.SignSpecialPlaces := Bcd.SignSpecialPlaces or $80;
  end;
  Result := True;
end;

procedure DoubleToBcd(const AValue: Double; var bcd: TBcd);
begin
  bcd := StrToBcd(FloatToStr(AValue));
end;

function DoubleToBcd(const AValue: Double): TBcd;
begin
  DoubleToBcd(AValue, Result);
end;

function IntegerToBcd( const AValue: Integer): TBcd;
begin
  Result := StrToBcd(IntToStr(AValue));
end;

function BcdToDouble(const Bcd: TBcd): Double;
begin
  Result := StrToFloat(BcdToStr(Bcd));
end;

function BcdToInteger(const Bcd: TBcd; Truncate: Boolean = False): Integer;
var
  ABcd: TBcd;
begin
  if (Truncate) and (BcdScale(Bcd) > 0 ) then
    NormalizeBcd(Bcd, ABcd, Bcd.Precision, 0)
  else
    ABcd := Bcd;
  Result := StrToInt(BcdToStr(ABcd));
end;

function CurrToBCD(const Curr: Currency; var BCD: TBcd; Precision: Integer = 32;
  Decimals: Integer = 4): Boolean;
begin
  Bcd := TBcd(CurrToStr(Curr));
  Result := True;
end;

function BCDToCurr(const BCD: TBcd; var Curr: Currency): Boolean;
begin
  Curr := StrToCurr(string(Bcd));
  Result := True;
end;

function CurrencyToBcd(const Curr: Currency): TBcd;
begin
  Result := TBcd(CurrToStr(Curr));
end;

function BCDToCurrency(const BCD: TBcd): Currency;
begin
  Result := StrToCurr(string(Bcd));
end;

function BcdToStrF(const Bcd: TBcd; Format: TFloatFormat;
  const Precision, Digits: Integer): string;
begin
  Result := BcdToStrF(Bcd, Format, Precision, Digits, FormatSettings);
end;

// Precision < 0, # of digits to the right of decimal
// Precision >= 0, # of digits to the left of decimal.
procedure Round(var S: string; DecSep: Char; Precision: Integer);
  procedure Increase(P: PChar);
  begin
    while (P^ = DecSep) or (P^ = '9') do
    begin
      if P^ = '9' then
        P^ := '0';
      Dec(P);
    end;
    if P^ = ' ' then
      P^ := '1'
    else
      Inc(P^);
  end;

  function AllZeros(P: PChar): Boolean;
  begin
    while (P^ = '0') or (P^ = DecSep) do
      inc(P);
    Result := P^ = #0;
  end;

  procedure FillZeros(P: PChar);
  begin
    while p^ <> #0 do
    begin
      if P^ <> DecSep then
        P^ := '0';
      Inc(P);
    end;
  end;
var
  DecPos: Integer;
  Negative : Boolean;
  Buffer: string;
  P, Q: PChar;
begin
  DecPos := S.IndexOf(DecSep);
  if (Precision <= 0) and ((DecPos = -1) or ((S.Length - DecPos - 1) <= -Precision)) then
     Exit;

  Negative := S.Chars[0] = '-';
  if Negative then
    Buffer := ' ' + S.Substring(1, S.Length)
  else
    Buffer := ' ' + S.Substring(0, S.Length);
  DecPos := Buffer.IndexOf(DecSep) + Low(Buffer);
  if DecPos = Low(Buffer) - 1 then DecPos := High(Buffer) + 1;
  P := @Buffer[DecPos - Precision];

  if (Precision < 0) or (P^ = DecSep) then
    Inc(P);
  case GetRoundMode of
    rmNearest:
    begin
      if P^ = '5' then
      begin
        if AllZeros(P+1) then
        begin
          Q := P-1;
          if Q^ = DecSep then
            Dec(Q);
          if (Ord(Q^) and 1) <> 0 then // Nearest or even.
            Increase(Q);
        end
        else
          Increase(P-1);
      end
      else if (P^ > '5') then
        Increase(P-1); // Do Increase;
    end;
    rmDown:
      if Negative and not AllZeros(P) then
        Increase(P-1);
    rmUp:
      if (not Negative) and not AllZeros(P) then
        Increase(P-1);
    rmTruncate: ; // no need to do anything, FillZeros does the rounding.
  end;
  FillZeros(P);
  if Buffer.IndexOf(DecSep) <> -1 then
  begin
    P := @Buffer[High(Buffer)];
    while P^ = '0' do
      Dec(P);
    if P^ = DecSep then
      P^ := #0
    else
      (P+1)^ := #0;
  end;

  if Buffer.Chars[0] = ' ' then
  begin
    if Negative then
    begin
      Buffer[Low(Buffer)] := '-';
      S := PChar(@Buffer[Low(Buffer)]);
    end else
      S := PChar(@Buffer[Low(Buffer) + 1]);
  end else
  begin
    if Negative then
      S := '-' + PChar(@Buffer[Low(Buffer)])
    else
      S := PChar(@Buffer[Low(Buffer)]);
  end;
end;

function BCDRoundTo(const bcdIn: TBcd; Digits: Integer): TBcd;
var
  LFormatSettings: TFormatSettings;
  S: string;
begin
  LFormatSettings := FormatSettings;
  S := BcdToStr(bcdIn, LFormatSettings);
  Round(S, LFormatSettings.DecimalSeparator, Digits);
  Result := StrToBcd(S, LFormatSettings);
end;

procedure RoundPrecision(var S: string; DecSep: Char; Precision: Integer);
var
  DecPos: Integer;
  P: PChar;
begin
  DecPos := S.IndexOf(DecSep) + 1;
  if DecPos = 0 then
    DecPos := S.Length+1;
  P := @S[Low(S)];
  while (P^ = '-') or (P^ = '0') or (P^ = DecSep) do
    Inc(P);
  while Precision-1 > 0 do
  begin
    Dec(Precision);
    if P^ = #0 then
      Break;
    Inc(P);
    if P^ = DecSep then
      Inc(P);
  end;

  DecPos := DecPos - (1 + P - @S[Low(S)]);
  if DecPos > 0 then
    Dec(DecPos);
  Round(s, DecSep, DecPos);
end;

function AddCurrencySymbol(const Value, CurrSymbol: string; const CurrFormat: Byte): string;
begin
  case CurrFormat of
    0: Result := Format('%s%s', [CurrSymbol, Value]);
    1: Result := Format('%s%s', [Value, CurrSymbol]);
    2: Result := Format('%s %s', [CurrSymbol, Value]);
    3: Result := Format('%s %s', [Value, CurrSymbol]);
  end;
end;

{   0 = '($1)'      4 = '(1$)'      8 = '-1 $'      12 = '$ -1'
    1 = '-$1'       5 = '-1$'       9 = '-$ 1'      13 = '1- $'
    2 = '$-1'       6 = '1-$'      10 = '1 $-'      14 = '($ 1)'
    3 = '$1-'       7 = '1$-'      11 = '$ 1-'      15 = '(1 $)'  }
function AddNegCurrencySymbol(const Value, CurrSymbol: string; const CurrFormat: Byte): string;
begin
  case CurrFormat of
    0: Result := Format('(%s%s)', [CurrSymbol, Value]);
    1: Result := Format('-%s%s', [CurrSymbol, Value]);
    2: Result := Format('%s-%s', [CurrSymbol, Value]);
    3: Result := Format('%s%s-', [CurrSymbol, Value]);
    4: Result := Format('(%s%s)', [Value, CurrSymbol]);
    5: Result := Format('-%s%s', [Value, CurrSymbol]);
    6: Result := Format('%s-%s', [Value, CurrSymbol]);
    7: Result := Format('%s%s-', [Value, CurrSymbol]);
    8: Result := Format('-%s %s', [Value, CurrSymbol]);
    9: Result := Format('-%s %s', [CurrSymbol, Value]);
   10: Result := Format('%s %s-', [Value, CurrSymbol]);
   11: Result := Format('%s %s-', [CurrSymbol, Value]);
   12: Result := Format('%s %s', [CurrSymbol, Value]);
   13: Result := Format('%s -%s', [Value, CurrSymbol]);
   14: Result := Format('(%s- %s)', [CurrSymbol, Value]);
   15: Result := Format('(%s %s)', [Value, CurrSymbol]);
  end;
end;

procedure BcdExponentString(var S: string; Format: TFloatFormat; DecSep: Char;
  Precision, Digits: Integer);
var
  Negative: Boolean;
  Exponent: Integer;
begin
  Negative := S.Chars[0] = '-';
  if Negative then
    S := S.Remove(0, 1);
  Exponent := S.IndexOf(DecSep) - 2;
  if Exponent = -3 then
    Exponent := S.Length - 2
  else
  begin
    S := S.Remove(Exponent+2, 1);
    while (S.Length > 1) and (S.Chars[0] = '0') do
    begin
      Dec(Exponent);
      S := S.Remove(0, 1);
    end;
  end;
  if S.Length < Precision then
    S := S.PadRight(Precision, '0');
  if S.Length > Precision then
    S := S.Remove(Precision, S.Length);

  S := S.Insert(1, DecSep);

  if Digits > 4 then
    Digits := 4;
  if Digits < 0 then
    Digits := 0;
  if Negative then
    S := '-' + S;
  if (Exponent >= -1) and (Format = ffExponent) then
    S := S + string.Format('E+%.*d', [Digits, Exponent+1])
  else
    S := S + string.Format('E%.*d', [Digits, Exponent+1]);
end;

procedure BcdNumberString(var S: string; Format: TFloatFormat;
  Precision, Digits: Integer; FS: TFormatSettings);
var
  Negative: Boolean;
  DecPos: Integer;
  Buf: string;
begin
  Buf := s;
  Negative := Buf[Low(Buf)] = '-';

  Round(Buf, fs.DecimalSeparator, - Digits);
  DecPos := Buf.IndexOf(FS.DecimalSeparator) + 1;
  if DecPos = 0 then
  begin
    DecPos := Buf.Length + 1;
    if Digits > 0 then
      S := Buf + FS.DecimalSeparator + string.Create('0', Digits)
    else
      S := Buf;
  end
  else
    S := Buf + string.Create('0', Digits - (Buf.Length - DecPos));
  if (DecPos -1 > Precision) then
  begin
    BcdExponentString(S, Format, FS.DecimalSeparator, Precision, Digits);
    Exit;
  end;

  // Add Thousdands seperators if ffNumber or ffCurrency
  if (Format = ffNumber) or (Format = ffCurrency) then
  begin
    Dec(DecPos, 3);
    while (DecPos > 1) and (S.Chars[DecPos-2] <> '-') do
    begin
      S.Insert(DecPos - 1, FS.ThousandSeparator);
      Dec(DecPos, 3);
    end;
  end;
  if Format = ffCurrency then
    if Negative then
    begin
      S := S.Remove(0, 1);
      S := AddNegCurrencySymbol(S, FS.CurrencyString, fs.NegCurrFormat);
    end
    else
      S := AddCurrencySymbol(S, FS.CurrencyString, fs.CurrencyFormat);
end;

function BcdToStrF(const Bcd: TBcd; Format: TFloatFormat;
  const Precision, Digits: Integer; FS: TFormatSettings): string;
var
  LBcd: TBcd;
  DecPos: Integer;
  LPrecision: Integer;
begin
  LBcd := Bcd;
  Result := BcdToStr(LBcd, FS);
  // Compatibility with XE and earlier.  Precision was previously ignored.
  // If passed zero for precision use the value from the actual Bcd instead.
  if Precision > 0 then
    LPrecision := Precision else
    LPrecision := Bcd.Precision;
  RoundPrecision(Result, FS.DecimalSeparator, LPrecision);
  DecPos := Result.IndexOf(FS.DecimalSeparator) + 1;
  case Format of
    ffGeneral: if ((DecPos = 0) and (Result.Length > LPrecision)) or (DecPos - 1 > LPrecision) then
                 BcdExponentString(Result, Format, FS.DecimalSeparator, LPrecision, Digits); // Fallback if to big
    ffExponent: BcdExponentString(Result, Format, FS.DecimalSeparator, LPrecision, Digits);
    ffFixed,
    ffNumber,
    ffCurrency: BcdNumberString(Result, Format, LPrecision, Digits, FS);
  end;
end;

type
  TFormatSection = (fsPositive=0, fsNegative, fsZero);
  TFormatFloatOptions = record
    ThousandSep: Boolean;
    Scientific: Boolean;
    DigitCount: Integer;
    DecimalIndex: Integer;
    FirstDigit: Integer;
    LastDigit: Integer;
    FormatSettings: TFormatSettings;
  end;

procedure ScanSection(Section: PChar; var Options: TFormatFloatOptions);
var
  QuoteChar: Char;
begin
  Options.DigitCount := 0;
  Options.DecimalIndex := -1;
  Options.FirstDigit := -1;
  Options.LastDigit := 0;
  Options.ThousandSep := False;
  Options.Scientific := False;

  while (Section^ > #0) and (Section^ <> ';') do
  begin
    case Section^ of
      '#': Inc(Options.DigitCount);
      '0':
      begin
        Inc(Options.DigitCount);
        if Options.FirstDigit = -1 then
          Options.FirstDigit := Options.DigitCount;
        Options.LastDigit := Options.DigitCount;
      end;
      '''', '"': begin
        QuoteChar := Section^;
        repeat
          Inc(Section);
        until (Section^ = #0) or (Section^ = QuoteChar);
      end;
      ',': Options.ThousandSep := True;
      '.':
        if Options.DecimalIndex = -1 then
          Options.DecimalIndex := Options.DigitCount;
      'E', 'e':
      begin
        Inc(Section);
        if (Section^ = '-') or (Section^ = '+') then
        begin
          Options.Scientific := True;
          repeat Inc(Section); until (Section^ <> '0');
        end;
      end;
    end;
    if (Section^ <> #0) then
      Inc(Section);
  end;
  if Options.DecimalIndex = -1 then
    Options.DecimalIndex := Options.DigitCount;
  if Options.FirstDigit = -1 then
    Options.FirstDigit := 0
  else
    Options.FirstDigit := Options.DecimalIndex - Options.FirstDigit+1;
  if Options.FirstDigit < 0 then Options.FirstDigit := 0;
  Options.LastDigit := Options.DecimalIndex - Options.LastDigit;
  if Options.LastDigit > 0 then Options.LastDigit := 0;
end;

function FindSection(Index: TFormatSection; Formats: PChar): PChar;
var
  SaveFormats: PChar;
  QuoteChar: Char;
begin
  SaveFormats := Formats;
  Result := Formats;
  while ((Formats^) > #0) and (Integer(Index) > 0) do
  begin
    if (Formats^ = ';') then
    begin
      Dec(Index);
      Result := Formats+1;
    end
    else if (Formats^ = '''') or (Formats^ = '"') then
    begin
      QuoteChar := Formats^;
      repeat
        Inc(Formats);
      until (Formats^ = #0) or (Formats^ = QuoteChar);
    end;
    if (Formats^ <> #0) then
      Inc(Formats);
  end;
  if (Formats^ = #0) or (Formats^ = ';') then
    Result := SaveFormats;
end;

procedure ApplyFormat(Section: PChar; var Buf: PChar; const Bcd: TBcd;
  var Options:TFormatFloatOptions);
var
  QuoteChar: Char;
  LStr: string;
  LExp: string;
  BufStart, LPStr: PChar;
  Power: Integer;
  Digit: Integer;

  procedure PutFmtDigit;
  begin
    Dec(Digit);
    if (Power >= 0) and (Digit > Power) then
    begin
      if (Digit < Options.FirstDigit) then
      begin
        PutChar(Buf, '0');
        if Options.ThousandSep and (Digit > 1) and (Digit mod 3 = 0) then
          PutChar(Buf, Options.FormatSettings.ThousandSeparator);
      end;
      exit;
    end;
    if (Power = -1) and
       ( (Options.LastDigit <> 0) or
         ((LPStr^ <> #0) and ((Options.FirstDigit <> 0) or (Options.DecimalIndex = 1))) ) then
      PutChar(Buf, Options.FormatSettings.DecimalSeparator);

    while Power >= Options.FirstDigit do
    begin
      PutChar(Buf, LPStr^);
      Inc(LPStr);
      if Options.ThousandSep and (Power > 1) and (Power mod 3 = 0) then
        PutChar(Buf, Options.FormatSettings.ThousandSeparator);
      Dec(Power);
      if Power = -1 then
        PutChar(Buf, Options.FormatSettings.DecimalSeparator);
    end;

    if Power < Options.FirstDigit then
    begin
      if LPStr^ <> #0 then
      begin
        PutChar(Buf, LPStr^);
        Inc(LPStr);
      end
      else if Power >= Options.LastDigit then
        PutChar(Buf, '0');
      if Options.ThousandSep and (Power > 1) and (Power mod 3 = 0) then
        PutChar(Buf, Options.FormatSettings.ThousandSeparator);

      Dec(Power);
    end;
  end;

begin
  BufStart := Buf;
  LStr := BcdToStr(Bcd, Options.FormatSettings);
  if options.Scientific then
  begin
    RoundPrecision(LStr, Options.FormatSettings.DecimalSeparator, options.DigitCount);
  end
  else
    Round(LStr, Options.FormatSettings.DecimalSeparator, Options.DecimalIndex - Options.DigitCount);
  if LStr.Chars[0] = '-' then
    LStr := LStr.Remove(0, 1);

  Power := LStr.IndexOf(Options.FormatSettings.DecimalSeparator) - 1;
  if Power = -2 then
    Power := LStr.Length - 1;
  LStr := LStr.Remove(Power+1, 1);


  if Options.Scientific then
  begin
    while (LStr.Chars[0] = '0') do
    begin
      LStr := LStr.Remove(0, 1);
      Dec(Power);
    end;
  end;

  Digit := Options.DecimalIndex;
  LPStr := @LStr[Low(LStr)];
  if (Options.FirstDigit = 0) and (LStr.Chars[0] = '0') then
  begin
    Inc(LPStr);
    Dec(Power);
  end;
  while (Section^ <> #0) and (Section^ <> ';') do
  begin
    case Section^ of
      '0', '#':
        PutFmtDigit;
      '"', '''':
      begin
        QuoteChar := Section^;
        Inc(Section);
        while (Section^ <> #0) and (Section^ <> QuoteChar) do
        begin
          PutChar(Buf, Section^);
          Inc(Section);
        end;
        if Section^ = #0 then
          Dec(Section);
      end;
      'e', 'E':
      begin
        PutChar(Buf, Section^);
        if (Section[1] = '+') or (Section[1] = '-') then
        begin
          Power := Power - (Options.DecimalIndex -1);
          if (Power >= 0) and (Section[1] = '+') then
            PutChar(Buf, '+');
          Inc(Section, 2);
          Digit := 0;
          while Section^ = '0' do
          begin
            Inc(Digit);
            Inc(Section);
          end;
          if Digit > 4 then
            Digit := 4;
          Dec(Section);
          LExp := string.Format('%.*d', [Digit, Power]);
          Move(LExp[Low(LExp)], Buf^, LExp.Length * Sizeof(Char));
          Inc(Buf, LExp.Length);
        end
      end;
      ',', '.': ;
      else
        PutChar(Buf, Section^);
    end;
    Inc(Section);
  end;
  // If no string was written to the buffer, then just return the raw BcdToStr result.
  if (Buf = BufStart) then
  begin
    StrPCopy(Buf, LStr);
    Inc(Buf, LStr.Length);
  end;
end;

function FormatBcd(const Format: string; Bcd: TBcd): string;
begin
  Result := FormatBcd(Format, Bcd, FormatSettings);
end;

function FormatBcd(const Format: string; Bcd: TBcd; FS: TFormatSettings): string;
var
  Buffer: array [0..255] of Char;
  Options: TFormatFloatOptions;
  LBuffer: PChar;
  Section: PChar;
begin
  FillChar(Buffer, SizeOf(Buffer), #0);
  LBuffer := @Buffer[0];
  if IsBcdNegative(Bcd) then
  begin
    Section := FindSection(fsNegative, @Format[Low(Format)]);
    if Section = @Format[Low(Format)] then // Negative section was blank, put '-'
      PutChar(LBuffer, '-');
  end
  else if IsZero(Bcd) then
    Section := FindSection(fsZero, @Format[Low(Format)])
  else
    Section := FindSection(fsPositive, @Format[Low(Format)]);
  ScanSection(Section, Options);
  Options.FormatSettings := FS;
  ApplyFormat(Section, LBuffer, Bcd, Options);

  Result := string.Create(Buffer, 0, LBuffer - @Buffer[0]);
end;

{$IFNDEF NEXTGEN}
procedure BcdMultiply(const bcdIn: TBcd; const DoubleIn: Double; var bcdOut: TBcd);
begin
  BcdMultiply(bcdIn, TBcd(DoubleIn), bcdOut);
end;

procedure BcdMultiply(const bcdIn: TBcd; const StringIn: string; var bcdOut: TBcd);
begin
  BcdMultiply(bcdIn, TBcd(StringIn), bcdOut);
end;

procedure BcdMultiply(StringIn1, StringIn2: string; var bcdOut: TBcd);
begin
  BcdMultiply(TBcd(StringIn1), TBcd(StringIn2), bcdOut);
end;

procedure BcdDivide(Dividend, Divisor: string; var bcdOut: TBcd);
begin
  BcdDivide(TBcd(Dividend), TBcd(Divisor), bcdOut);
end;

procedure BcdDivide(const Dividend: TBcd; const Divisor: Double; var bcdOut: TBcd);
begin
  BcdDivide(Dividend, TBcd(Divisor), bcdOut);
end;

procedure BcdDivide(const Dividend: TBcd; const Divisor: string; var bcdOut: TBcd);
begin
  BcdDivide(Dividend, TBcd(Divisor), bcdOut);
end;
{$ENDIF !NEXTGEN}


{$REGION 'Variant Support'}

{ TFMTBcdVariantType }

type
  TFMTBcdVariantType = class(TPublishableVariantType)
  protected
    function GetInstance(const V: TVarData): TObject; override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean); override;
    procedure Cast(var Dest: TVarData; const Source: TVarData); override;
    procedure CastTo(var Dest: TVarData; const Source: TVarData; const AVarType: TVarType); override;
    procedure BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp); override;
    procedure Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult); override;
  end;

var
{ FMTBcd that the complex variant points to }
  FMTBcdVariantType: TFMTBcdVariantType = nil;

{ TFMTBcdData }
type
  TFMTBcdData = class(TPersistent)
  private
    FBcd: TBcd;
  public
    constructor Create(const ABcd: TBcd); overload;
    constructor Create(const AValue: Double; Precision, Scale: Word); overload;
    constructor Create(const AValue: Currency); overload;
    constructor Create(const AText: string; Precision, Scale: Word); overload;
    property Bcd: TBcd read FBcd write FBcd;

    function Compare(const Value: TFMTBcdData): TVarCompareResult;
  end;

{ Helper record that helps crack open TFMTBcdObject }

  TFMTBcdVarData = record
  strict private
    function GetVBcd: TFMTBcdData; inline;
    procedure SetVBcd(const Value: TFMTBcdData); inline;
  public
    procedure Clear; inline;
  public
     VType: TVarType;
     Reserved1, Reserved2, Reserved3: Word;
    property VBcd: TFMTBcdData read GetVBcd write SetVBcd;
  public
    case Integer of
    0: (_VBcd: Pointer);
    1: (VLargest: TLargestVarData); // to match size as Variant/TVarData type
  end;

{ TFMTBcdVarData }

procedure TFMTBcdVarData.Clear;
begin
  FreeAndNil(TFMTBcdData(Self._VBcd));
end;

function TFMTBcdVarData.GetVBcd: TFMTBcdData;
begin
  Result := TFMTBcdData(Self._VBcd);
end;

procedure TFMTBcdVarData.SetVBcd(const Value: TFMTBcdData);
begin
  TFMTBcdData(Self._VBcd) := Value;
end;

{ TFMTBcdVariantType }

procedure TFMTBcdVariantType.Clear(var V: TVarData);
begin
  V.VType := varEmpty;
  TFMTBcdVarData(V).Clear;
end;

procedure TFMTBcdVariantType.Copy(var Dest: TVarData; const Source: TVarData; const Indirect: Boolean);
begin
  if Indirect and VarDataIsByRef(Source) then
    VarDataCopyNoInd(Dest, Source)
  else
  begin
    TFMTBcdVarData(Dest).VType := VarType;
    TFMTBcdVarData(Dest).VBcd := TFMTBcdData.Create(TFMTBcdData(TFMTBcdVarData(Source).VBcd).Bcd);
  end;
end;

procedure TFMTBcdVariantType.Cast(var Dest: TVarData;
  const Source: TVarData);
var
  LSource, LTemp: TVarData;
begin
  VarDataInit(LSource);
  try
    VarDataCopyNoInd(LSource, Source);
    if VarDataIsStr(LSource) then
      TFMTBcdVarData(Dest).VBcd := TFMTBcdData.Create(VarDataToStr(LSource), 32, 8)
    else
    begin
      VarDataInit(LTemp);
      try
        VarDataCastTo(LTemp, LSource, varDouble);
        TFMTBcdVarData(Dest).VBcd := TFMTBcdData.Create(LTemp.VDouble, 32, 8);
      finally
        VarDataClear(LTemp);
      end;
    end;
    Dest.VType := VarType;
  finally
    VarDataClear(LSource);
  end;
end;

procedure TFMTBcdVariantType.CastTo(var Dest: TVarData;
  const Source: TVarData; const AVarType: TVarType);
var
  LTemp: TVarData;
begin
  if Source.VType = VarType then
    case AVarType of
{$IFNDEF NEXTGEN}
      varOleStr:
        VarDataFromOleStr(Dest, string(TFMTBcdVarData(Source).VBcd.Bcd));
      varString:
        VarDataFromLStr(Dest, AnsiString(string(TFMTBcdVarData(Source).VBcd.bcd)));
{$ELSE}
      varOleStr, varString,
{$ENDIF !NEXTGEN}
      varUString:
        VarDataFromStr(Dest, string(TFMTBcdData(TFMTBcdVarData(Source).VBcd).bcd));
    else
      VarDataInit(LTemp);
      try
        LTemp.VType := varDouble;
        LTemp.VDouble := BcdToDouble(TFMTBcdData(TFMTBcdVarData(Source).VBcd).Bcd);
        VarDataCastTo(Dest, LTemp, AVarType);
      finally
        VarDataClear(LTemp);
      end;
    end
  else
    inherited;
end;

procedure TFMTBcdVariantType.BinaryOp(var Left: TVarData; const Right: TVarData; const Operator: TVarOp);
begin
  case Operator of
    opAdd:
      BcdAdd(TFMTBcdData(TFmtBcdVarData(Left).VBcd).Bcd, TFMTBcdData(TFmtBcdVarData(Right).VBcd).Bcd,
        TFMTBcdData(TFmtBcdVarData(Left).VBcd).FBcd);
    opSubtract:
      BcdSubtract(TFMTBcdData(TFmtBcdVarData(Left).VBcd).Bcd, TFMTBcdData(TFmtBcdVarData(Right).VBcd).Bcd,
        TFMTBcdData(TFmtBcdVarData(Left).VBcd).FBcd);
    opMultiply:
      BcdMultiply(TFMTBcdData(TFmtBcdVarData(Left).VBcd).Bcd, TFMTBcdData(TFmtBcdVarData(Right).VBcd).Bcd,
        TFMTBcdData(TFmtBcdVarData(Left).VBcd).FBcd);
    opDivide:
      BcdDivide(TFMTBcdData(TFmtBcdVarData(Left).VBcd).Bcd, TFMTBcdData(TFmtBcdVarData(Right).VBcd).Bcd,
        TFMTBcdData(TFmtBcdVarData(Left).VBcd).FBcd);
  else
    RaiseInvalidOp;
  end;
end;

procedure TFMTBcdVariantType.Compare(const Left, Right: TVarData; var Relationship: TVarCompareResult);
begin
  Relationship := TFMTBcdData(TFMTBcdVarData(Left).VBcd).Compare(TFMTBcdVarData(Right).VBcd);
end;

function TFMTBcdVariantType.GetInstance(const V: TVarData): TObject;
begin
  Result := TFMTBcdVarData(V).VBcd;
end;

constructor TFMTBcdData.Create(const ABcd: TBcd);
begin
  inherited Create;
  Move(ABcd, FBcd, SizeOf(TBcd));
end;

constructor TFMTBcdData.Create(const AValue: Currency);
var
  OutBcd: TBcd;
begin
  CurrToBcd(AValue, OutBcd);
  Create(OutBcd);
end;

constructor TFMTBcdData.Create(const AText: string; Precision, Scale: Word);
var
  ABcd, OutBcd: TBcd;
begin
  ABcd := StrToBcd(AText);
  if not NormalizeBcd(ABcd, OutBcd, Precision, Scale) then
    OverflowError(SBcdOverflow);
  Create(OutBcd);
end;

constructor TFMTBcdData.Create(const AValue: Double; Precision, Scale: Word);
var
  ABcd, OutBcd: TBcd;
begin
  if (Precision = 0) or (Precision > MaxFMTBcdFractionSize) or (Scale > Precision) then
    OverflowError(SBcdOverflow);
  ABcd := StrToBcd(FloatToStrF(AValue, ffFixed, Precision, Scale));
  if not NormalizeBcd(ABcd, OutBcd, Precision, Scale) then
    OverflowError(SBcdOverflow);
  Create(OutBcd);
end;

function TFMTBcdData.Compare(const Value: TFMTBcdData): TVarCompareResult;
begin
  Result := TVarCompareResult(BcdCompare(Self.FBcd, Value.FBcd)+1);
end;

procedure VarFMTBcdCreate(var ADest: Variant; const ABcd: TBcd);
begin
  VarClear(ADest);
  TFMTBcdVarData(ADest).VType := FMTBcdVariantType.VarType;
  TFMTBcdVarData(ADest).VBcd := TFMTBcdData.Create(ABcd);
end;

function VarFMTBcdCreate: Variant;
begin
  VarFMTBcdCreate(Result, NullBcd);
end;

function VarFMTBcdCreate(const AValue: string; Precision, Scale: Word): Variant;
begin
  VarClear(Result);
  TFMTBcdVarData(Result).VType := FMTBcdVariantType.VarType;
  TFmtBcdVarData(Result).VBcd := TFMTBcdData.Create(AValue, Precision, Scale);
end;

function VarFMTBcdCreate(const AValue: Double; Precision, Scale: Word): Variant;
begin
  VarClear(Result);
  TFMTBcdVarData(Result).VType := FMTBcdVariantType.VarType;
  TFmtBcdVarData(Result).VBcd := TFMTBcdData.Create(AValue, Precision, Scale);
end;

function VarFMTBcdCreate(const ABcd: TBcd): Variant;
begin
  VarFMTBcdCreate(Result, ABcd);
end;

function VarIsFMTBcd(const AValue: Variant): Boolean;
begin
  Result := (TVarData(AValue).VType = FMTBcdVariantType.VarType);
end;

function VarFMTBcd: TVarType;
begin
  Result := FMTBcdVariantType.VarType;
end;

function VarToBcd(const AValue: Variant): TBcd;
begin
  if VarType(AValue) = FMTBcdVariantType.VarType then
    Result := TFMTBcdData(TFMTBcdVarData(AValue).VBcd).FBcd
  else
  if VarType(AValue) = varCurrency then
    CurrToBcd(AValue, Result)
  else
    Result := StrToBcd(AValue);
end;

{$IFNDEF NEXTGEN}
{ used internally, and only to round decimals, not integer portion }
{ requires at least 1 digit!! }
function RoundAt(const Value: string; Position: SmallInt): string;

  Procedure RoundChar(const PrevChar: SmallInt; var Carry: Boolean);
  begin
    if CharInSet(Result[PrevChar], ['0' .. '9']) then
    begin
      if Result[PrevChar] = '9' then
      begin
        Result[PrevChar] := '0';
        Carry := True;
      end else
      begin
        Result[PrevChar] := Char(Byte(Result[PrevChar]) + 1);
        Carry := False;
      end;
    end;
  end;

var
  C, Dot: Char;
  PrevChar, I, DecPos, DecDigits: SmallInt;
  Carry: Boolean;
  Neg: string;
begin
  if Length(Value) = 0 then
  begin
    Result := Value;
    Exit;
  end;

  Dot := FormatSettings.DecimalSeparator;
  if Value[1] = '-' then
  begin
    Result := Copy(Value, 2, MaxInt);
    Neg := '-';
  end else
  begin
    Result := Value;
    Neg := '';
  end;
  DecPos := Pos(Dot, Result);
  if DecPos > 0 then
    DecDigits := Length(Result) - DecPos
  else
    DecDigits := 0;
  if (DecPos = 0) or (DecDigits <= Position) then
    { nothing to round }
  begin
    Result := Value;
    Exit;
  end;
  if Result[DecPos + Position + 1] < '5' then
  begin
    { no possible rounding required }
    if Position = 0 then
      Result := Neg + Copy(Result, 1, DecPos + Position -1)
    else
      Result := Neg + Copy(Result, 1, DecPos + Position);
  end else
  begin
    Carry := False;
    PrevChar := 1;
    for I := DecPos + DecDigits downto (DecPos + 1 + Position) do
    begin
      C := Result[I];
      PrevChar := I-1;
      if Result[PrevChar] = Dot then
      begin
        Dec(PrevChar);
        Dec(Position);
      end;
      if (Byte(C) >= 53) or Carry then { if '5' or greater }
        RoundChar(PrevChar, Carry);
    end;
    while Carry do
    begin
      if PrevChar >= DecPos then
        Dec(Position);
      Dec(PrevChar);
      if PrevChar = 0 then
        break;
      if Result[PrevChar] <> Dot then
        RoundChar(PrevChar, Carry);
    end;
    if Carry then
      Result := Neg + '1' + Copy(Result, 1, DecPos + Position)
    else
      Result := Neg + Copy(Result, 1, DecPos + Position);
  end;
end;
{$ENDIF !NEXTGEN}

{$ENDREGION}

initialization
  FMTBcdVariantType := TFMTBcdVariantType.Create;
  BcdOverflowChecks := True;
finalization
  FreeAndNil(FMTBcdVariantType);
end.
