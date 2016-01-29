{*********************************************************}
{*                   TBITS3.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program TBits3;

{$I STDEFINE.INC}
{$R-,S-,X+}

{$IFDEF Win32}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  stbase,
  stbits
{$IFNDEF OS32}
  , wincrt
{$ENDIF}
  ;

const
  {A range of bit counts that crosses a 16-bit segment boundary}
  BitMaxStart = 65530*8*2;
  BitMaxStop  = 65540*8*2;
  BitMaxDelta = 1;

var
  BitMax : LongInt;
  BS, BS0 : TStBits;

begin
  BitMax := BitMaxStart;

  {Create a bitset with all bits set}
  BS := TStBits.Create(BitMax);
  BS.SetBits;

  while BitMax < BitMaxStop do begin
    write(BitMax);

    {Create a fresh zero-filled bitset}
    BS0 := TStBits.Create(BitMax);

    {Force a recount of the bits in BS}
    BS.OrBits(BS0);

    BS0.Free;

    if BS.Count <> BitMaxStart+1 then begin
      writeln(' Error!');
      halt;
    end;
    writeln;

    {Resize the test set}
    inc(BitMax, BitMaxDelta);
    BS.Max := BitMax;
  end;

  BS.Free;
  readln;
end.
