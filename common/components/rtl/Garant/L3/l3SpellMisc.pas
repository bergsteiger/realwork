unit l3SpellMisc;

{ ���������� "L3 (Low Level Library)" }
{ �����: ������� �.�.                 }
{ ������: l3SpellMisc - ��������� � ��������������� ���������� ��������� mlma32ru.dll }
{ �����: 01.04.2009 }
{ $Id: l3SpellMisc.pas,v 1.1 2016/02/15 16:07:49 voba Exp $ }

// $Log: l3SpellMisc.pas,v $
// Revision 1.1  2016/02/15 16:07:49  voba
// no message
//

interface
uses
 Types,
 SysUtils,
 l3Interfaces;

type
{$IF not Declared(PPAnsiCharArray)}
  TPAnsiCharArray = packed array[0..(MaxLongint div SizeOf(PAnsiChar))-1] of PAnsiChar;
  PPAnsiCharArray = ^TPAnsiCharArray;
{$IFEND}

{$IF Declared(UnicodeString)}
  TAnsiStringDynArray = array of AnsiString;
  TUnicodeStringDynArray = TStringDynArray;
{$ELSE}
  TAnsiStringDynArray = TStringDynArray;
  UnicodeString = type WideString;
  TUnicodeStringDynArray = array of UnicodeString;
{$IFEND}

type
 TLingException = class(Exception);

type
 TllAddUStrProc = procedure(aWord : PWideChar; aWordLen : integer);
 TllAddStrProc = procedure(aWord : PAnsiChar; aWordLen : integer);

 function  L2llAddStrProc(Action: Pointer): TllAddStrProc; register;
 procedure FreellAddStrProc(var Stub: TllAddStrProc); register;
 function  L2llAddUStrProc(Action: Pointer): TllAddUStrProc; register;
 procedure FreellAddUStrProc(var Stub: TllAddUStrProc); register;

type
 TCapScheme = Set Of byte;

 function GetCapsScheme(aWord : PAnsiChar; aWordLen : Word) : TCapScheme;
 // �������� ����� �������������
 procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aScheme : TCapScheme); overload;
 // ��������� ����� �������������
 procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aSrcWord : PAnsiChar; aSrcWordLen : Word); overload;
 // ����������� ����� ������������� � aSrcWord

implementation
uses
 Windows,
 l3Base,
 l3Bits,
 l3MinMax,
 l3String;

function GetCapsScheme(aWord : PAnsiChar; aWordLen : Word) : TCapScheme;
// �������� ����� �������������
var
 lHasLow : boolean;
 I : Byte;
begin
 Result := [];
 lHasLow := False;
 aWordLen := Min(aWordLen, High(Byte));
 for I := 0 to Pred(aWordLen) do
  if l3IsUpper(aWord[I]) then
   Include(Result, I)
  else
   lHasLow := True;
 if not lHasLow then
  Result := [Low(Byte) .. High(Byte)];
end;

procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aScheme : TCapScheme); overload;
// ��������� ����� �������������
var
 I : Byte;
begin
 if aScheme = [] then exit; // ��������� ��� � ������
 if aScheme = [Low(Byte) .. High(Byte)] then
  CharUpperBuffA(aWord, aWordLen);
 aWordLen := Min(aWordLen, High(Byte));
 for I := 0 to Pred(aWordLen) do
  if I in aScheme then
   CharUpperBuffA(@aWord[I], 1);
end;

procedure ApplayCapsScheme(aWord : PAnsiChar; aWordLen : Word; aSrcWord : PAnsiChar; aSrcWordLen : Word); overload;
// ����������� ����� ������������� � aSrcWord
begin
 ApplayCapsScheme(aWord, aWordLen, GetCapsScheme(aSrcWord, aSrcWordLen));
end;

function L2llAddStrProc(Action: Pointer): TllAddStrProc; register;
asm
 jmp  l3LocalStub
end;{asm}

procedure FreellAddStrProc(var Stub: TllAddStrProc); register;
asm
 jmp  l3FreeLocalStub
end;{asm}

function L2llAddUStrProc(Action: Pointer): TllAddUStrProc; register;
asm
 jmp  l3LocalStub
end;{asm}

procedure FreellAddUStrProc(var Stub: TllAddUStrProc); register;
asm
 jmp  l3FreeLocalStub
end;{asm}
end.
