unit m2HASLib;

{$Include m2Define.inc}

{$R *.res}

interface

uses
 Windows,
 SysUtils,

 m2AddDbg,
 m2AddPrc,
 m2RESLib
 ;

const
 Cm2HASVersionCRC = $0001;

 Cm2HASVersion = Cm2HASVersionCRC;

 Cm2HASDefCount = $4000;
 Cm2HASDefSize = High(LongInt);

type
 Pm2HASTable16 = ^Tm2HASTable16;
 Tm2HASTable16 = packed array[$00..$ff] of Word;

 Tm2HASUpdateProc16 = function(const ABuff: PAnsiChar; const ASize: LongInt; const ATable: Pm2HASTable16): Word;

 Tm2HASVersionItem = packed record
  RRHnd16: THandle;
  RSeed16: Pm2HASTable16;
  RProc16: Tm2HASUpdateProc16;
 end;//Tm2HASVersionItem

 Tm2HASVersionArray = packed array [1..Cm2HASVersion] of Tm2HASVersionItem;

function m2HASUpdate16(const ABuff: PAnsiChar;
                       const ASize: LongInt;
                       const AVersion: Word): Word;

function m2Hash16(const aValue: WideString;
                  const aHashVersion: Word): Word;
function m2SmallHash16(const aValue: WideString;
                       const aHashVersion: Word): Word;

function m2Hash16Table: Pm2HASTable16;

implementation

uses
 l3MinMax,
 l3Base
 ;

const
 CResourcePrefix = 'm2HAS';

 CMagic16Seed = Word(-1);

function _UpdateProc160001(const ABuff: PAnsiChar;
                           const ASize: LongInt;
                           const ATable: Pm2HASTable16): Word;
type
 P16to08 = ^T16to08;
 T16to08 = packed record
  RLoByte: Byte;
  RHiByte: Byte;
 end;//T16to08
var
 LBuff: PAnsiChar;
 LHash: Word;
 LSize: LongInt;
begin
 Result := 0;
 if ((ABuff <> nil) and (ASize <> 0) and (ATable <> nil)) then
 begin
  LBuff := ABuff;
  LSize := ASize;
  Result := Result xor CMagic16Seed;
  while (LSize <> 0) do
  begin
   LHash := Word(LBuff^);
   P16to08(@LHash)^.RLoByte := P16to08(@LHash)^.RLoByte xor P16to08(@Result)^.RHiByte;
   P16to08(@Result)^.RHiByte := P16to08(@Result)^.RLoByte;
   P16to08(@Result)^.RLoByte := P16to08(@LHash)^.RHiByte;
   Result := Result xor ATable^[P16to08(@LHash)^.RLoByte];
   Inc(LongInt(LBuff));
   Dec(LSize);
  end;//while (LSize <> 0)
  Result := Result xor CMagic16Seed;
 end;//(ABuff <> nil)
end;

var
 GVersionArray : Tm2HASVersionArray = (
  (RRHnd16: 0; RSeed16: nil; RProc16: _UpdateProc160001)
 );

function _CheckVersion(const AVersion: Word): LongBool;
begin
 Result := ((AVersion > 0) and (AVersion <= Cm2HASVersion));
end;

procedure _AllocData16(const AVersion: Word);
begin
 with GVersionArray[AVersion] do
  RSeed16 := Pm2HASTable16(m2RESAllocRCDATA(RRHnd16,CResourcePrefix+Format('16_%.4x',[AVersion])));
end;

procedure _FreeData16(const AVersion: Word);
begin
 with GVersionArray[AVersion] do
  RSeed16 := Pm2HASTable16(m2RESFreeRCDATA(RRHnd16));
end;

{$IfOpt Q+}
 {$Define WasOver}
 {$OverflowChecks Off}
{$EndIf}

function SuperFastHash(AData:pointer; ADataLength: integer):longword;
// Pascal translation of the SuperFastHash function by Paul Hsieh
// more info: http://www.azillionmonkeys.com/qed/hash.html
// Translation by: Davy Landman
// No warranties, but have fun :)
var
  TempPart: longword;
  RemainingBytes: integer;
begin
  if not Assigned(AData) or (ADataLength <= 0) then
  begin
    Result := 0;
    Exit;
  end;
  Result := ADataLength;
  RemainingBytes := ADataLength and 3;
  ADataLength := ADataLength shr 2; // div 4, so var name is not correct anymore..
  // main loop
  while ADataLength > 0 do
  begin
    inc(Result, PWord(AData)^);
    TempPart := (PWord(Pointer(Cardinal(AData)+2))^ shl 11) xor Result;
    Result := (Result shl 16) xor TempPart;
    AData := Pointer(Cardinal(AData) + 4);
    inc(Result, Result shr 11);
    dec(ADataLength);
  end;
  // end case
  if RemainingBytes = 3 then
  begin
    inc(Result, PWord(AData)^);
    Result := Result xor (Result shl 16);
    Result := Result xor (PByte(Pointer(Cardinal(AData)+2))^ shl 18);
    inc(Result, Result shr 11);
  end
  else if RemainingBytes = 2 then
  begin
    inc(Result, PWord(AData)^);
    Result := Result xor (Result shl 11);
    inc(Result, Result shr 17);
  end
  else if RemainingBytes = 1 then
  begin
    inc(Result, PByte(AData)^);
    Result := Result xor (Result shl 10);
    inc(Result, Result shr 1);
  end;
  // avalance
  Result := Result xor (Result shl 3);
  inc(Result, Result shr 5);
  Result := Result xor (Result shl 4);
  inc(Result, Result shr 17);
  Result := Result xor (Result shl 25);
  inc(Result, Result shr 6);
end;

function SuperFastHash16(AData:pointer; ADataLength: integer): word;
type
 P32to16 = ^T32to16;
 T32to16 = packed record
  rLo: Word;
  rHi: Word;
 end;//T32to16
var
 l_W : LongWord;
begin//SuperFastHash16
 Result := 0;
 Assert(SizeOf(l_W) = SizeOf(T32to16));
 l_W := SuperFastHash(aData, aDataLength);

 Result := P32to16(@l_W).rLo xor P32to16(@l_W).rHi;
end;//SuperFastHash16
{$IfDef WasOver}
 {$OverflowChecks On}
{$EndIf WasOver}

function m2HASUpdate16(const aBuff: PAnsiChar;
                       const aSize: LongInt;
                       const aVersion: Word): Word;
begin
 if (aVersion = Cm2HASVersion + 1) then
  Result := SuperFastHash16(aBuff, aSize)
 else
 begin
  m2CheckValue(_CheckVersion(aVersion));
  with GVersionArray[aVersion] do
   Result := RProc16(aBuff, aSize, RSeed16);
 end;//aVersion = Cm2HASVersion + 1
end;

function m2Hash16Table: Pm2HASTable16;
begin
 Result := GVersionArray[Cm2HASVersionCRC].RSeed16;
end;

function m2Hash16(const aValue: WideString;
                  const aHashVersion: Word): Word;
begin
 Result:=m2HASUpdate16(PAnsiChar(AValue),
                       Length(AValue)*SizeOf(WideChar),
                       aHashVersion);
end;

function m2SmallHash16(const aValue: WideString;
                       const aHashVersion: Word): Word;
begin
 Result:=LongInt(m2HASUpdate16(PAnsiChar(AValue),
                               Min(Length(AValue)*SizeOf(WideChar),Cm2HASDefSize),
                               aHashVersion) and Pred(Cm2HASDefCount));
end;

 type
        TUnitHelper               = class(TObject)
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );

         public


                constructor       Create              (
                                                      );

                destructor        Destroy             (
                                                      ); override;


         end;


 var
        GUnitHelper:              TUnitHelper = nil;


// TUnitHelper.private

 function    TUnitHelper.InitProc00000001(const ABitMask: LongWord
                                         ): LongWord;
 begin

  with Self do
   begin

    _AllocData16(Cm2HASVersionCRC);

   end;

  Result:=ABitMask;

 end;

 procedure   TUnitHelper.DoneProc00000001(
                                         );
 begin

  with Self do
   begin

    _FreeData16(Cm2HASVersionCRC);

   end;

 end;


// TUnitHelper.public

 constructor TUnitHelper.Create(
                               );
 begin

  inherited Create;

  m2InitOperation(_Status,InitProc00000001($00000001));

 end;

 destructor  TUnitHelper.Destroy(
                                );
 begin

  m2DoneOperation(_Status,$00000001,DoneProc00000001);

  inherited Destroy;

 end;

// TUnitHelper.end

initialization
 {$IfDef LogInit}
 l3System.Msg2Log('m2HASLib init enter');
 {$EndIf LogInit}
 GUnitHelper := TUnitHelper.Create;
 {$IfDef LogInit}
 l3System.Msg2Log('m2HASLib init leave');
 {$EndIf LogInit}
finalization
 GUnitHelper.Free;

end.

