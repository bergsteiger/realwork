{*********************************************************}
{*                    TBITS.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TBits;

{$I STDEFINE.INC}
{$R-,S-,X+}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  sysutils,
  classes,
  stbase,
  stbits
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  BitMax = 10000;
var
  BS : TStBits;
  Errors : LongInt;

type
  TModRec = record
    ModVal : Word;
    Tst : LongInt;
  end;
  PModRec = ^TModRec;

function TestModBit(Container : TStBits;
                    N : LongInt;
                    OtherData : Pointer) : Boolean; far;
begin
  with PModRec(OtherData)^ do
    if N mod ModVal <> 0 then begin
      WriteLn('Iterate returned bogus element ', N);
      inc(Errors);
    end else
      inc(Tst);
  Result := True;
end;

procedure TestMod(ModVal : Word; SetBits : boolean);
var
  B : LongInt;
  Cnt : LongInt;
  V : Boolean;
  TMR : TModRec;
begin
  WriteLn;

  if SetBits then begin
    BS.SetBits;
    WriteLn('Testing set bits operation');
    for B := 0 to BitMax do
      if not BS.BitIsSet(B) then begin
        WriteLn('SetBits failed');
        inc(Errors);
      end;

(* requires moving btRecount to a public section of the TStBits class,
   or creating a descendant that makes the routine public.
    BS.btRecount;
    if BS.Count <> BitMax+1 then begin
      WriteLn('Recount failed');
      inc(Errors);
    end;
*)

    BS.Clear;
    WriteLn('Testing clear operation');
    for B := 0 to BitMax do
      if BS.BitIsSet(B) then begin
        WriteLn('Clear failed');
        inc(Errors);
      end;

    WriteLn('Setting bits mod ', ModVal);
    Cnt := 0;
    for B := 0 to BitMax do
      if B mod ModVal = 0 then begin
        BS.SetBit(B);
        inc(Cnt);
      end;

    WriteLn('Testing set bit count');
    if BS.Count <> Cnt then begin
      WriteLn('Count returned bogus count ', BS.Count);
      inc(Errors);
    end;

  end else begin
    WriteLn('Testing bits mod ', ModVal);
    Cnt := BS.Count;
  end;

  WriteLn('Testing all bits');
  for B := 0 to BitMax do begin
    V := BS.BitIsSet(B);
    if B mod ModVal = 0 then begin
      if not V then begin
        WriteLn('Bit ', B, ' is not set');
        inc(Errors);
      end;
    end else begin
      if V then begin
        WriteLn('Bit ', B, ' is set');
        inc(Errors);
      end;
    end;
  end;

  if BS.FirstSet <> 0 then begin
    WriteLn('Error in FirstSet');
    inc(Errors);
  end;

  if (ModVal <> 1) and (BS.FirstClear <> 1) then begin
    WriteLn('Error in FirstClear');
    inc(Errors);
  end;

  if BS.LastSet <> (BitMax div ModVal)*ModVal then begin
    WriteLn('Error in LastSet');
    inc(Errors);
  end;

  B := BS.LastSet;
  if B = BitMax then
    B := BitMax-1
  else
    B := BitMax;
  if (ModVal <> 1) and (BS.LastClear <> B) then begin
    WriteLn('Error in LastClear');
    inc(Errors);
  end;

  WriteLn('Iterating, up, set');
  TMR.ModVal := ModVal;
  TMR.Tst := 0;
  BS.Iterate(TestModBit, True, True, @TMR);
  if TMR.Tst <> Cnt then begin
    WriteLn('Iterate missed some bits ', Cnt-TMR.Tst);
    inc(Errors);
  end;

  WriteLn('Iterating, down, set');
  TMR.ModVal := ModVal;
  TMR.Tst := 0;
  BS.Iterate(TestModBit, True, False, @TMR);
  if TMR.Tst <> Cnt then begin
    WriteLn('Iterate missed some bits ', Cnt-TMR.Tst);
    inc(Errors);
  end;

  WriteLn('Testing FirstSet, NextSet');
  TMR.ModVal := ModVal;
  TMR.Tst := 0;
  B := BS.FirstSet;
  if B <> -1 then
   while B <> -1 do begin
    inc(TMR.Tst);
    B := BS.NextSet(B);
   end;
  if TMR.Tst <> Cnt then begin
    WriteLn('FirstSet/NextSet missed some bits ', Cnt-TMR.Tst);
    inc(Errors);
  end;

  WriteLn('Testing LastSet, PrevSet');
  TMR.ModVal := ModVal;
  TMR.Tst := 0;
  B := BS.LastSet;
  if B <> -1 then
   while B <> -1 do begin
    inc(TMR.Tst);
    B := BS.PrevSet(B);
   end;
  if TMR.Tst <> Cnt then begin
    WriteLn('LastSet/PrevSet missed some bits ', Cnt-TMR.Tst);
    inc(Errors);
  end;
end;

begin
  Errors := 0;

  BS := TStBits.Create(BitMax);

  {Test when setting every 9th bit}
  TestMod(9, true);

  {Test when setting every 3rd bit}
  TestMod(3, true);

  {Test when setting every 127th bit}
  TestMod(127, true);

  {Test when setting every bit}
  TestMod(1, true);

  {Test when setting every 11th bit}
  TestMod(11, true);

  BS.StoreToFile('Test.stm');
  BS.Free;

  RegisterClasses([TStBits]);
  BS := TStBits.Create(8);
  BS.LoadFromFile('Test.stm');
  {Test every 11th bit set}
  TestMod(11, false);

  WriteLn;
  WriteLn(Errors, ' errors detected');
  readln;
end.
