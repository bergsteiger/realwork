unit m1LZOLib;

// $Id: m1lzolib.pas,v 1.8 2013/04/12 16:25:08 lulin Exp $

// $Log: m1lzolib.pas,v $
// Revision 1.8  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.7  2012/01/13 12:44:39  lulin
// {RequestLink:326769483}
// - используем функцию распаковки с проверкой выхода за границу буфера.
//
// Revision 1.6  2012/01/12 12:48:40  lulin
// {RequestLink:326769483}
// - защищаем буфер для записи средствами Windows.
//
// Revision 1.5  2012/01/12 12:08:31  lulin
// {RequestLink:326769483}
// - опираемся на поданную длину буфера для распаковки.
//
// Revision 1.4  2012/01/12 11:59:18  lulin
// {RequestLink:326769483}
// - поднимаем исключение сразу же после проезда.
//
// Revision 1.3  2012/01/12 11:51:44  lulin
// {RequestLink:326769483}
// - пытаемся восстановиться после проезда по памяти.
//
// Revision 1.2  2012/01/11 17:30:01  lulin
// {RequestLink:326769483}
//
// Revision 1.1  2007/12/07 12:24:11  lulin
// - переезд.
//
// Revision 1.1  2007/12/07 11:22:35  lulin
// - переезд.
//
// Revision 1.3  2007/12/07 11:15:04  lulin
// - cleanup.
//

{$I m1Define.inc}

interface

function m1LZOIsValidResult(ACode: Integer): LongBool;

function m1LZOMaxMem(ASize: Integer): Integer;

function m1LZOEncode(ADest     : Pointer;
                     var ADLen : Integer;
                     ASour     : Pointer;
                     ASLen     : Integer): Integer;

function m1LZODecode(ADest     : PAnsiChar;
                     var ADLen : Integer;
                     ASour     : PAnsiChar;
                     ASLen     : Integer): Integer;

implementation

uses
  Windows,
  
  SysUtils,
  
  m0LZOLib,

  m2MemLib,

  l3Base
  ;

function m1LZOIsValidResult(ACode: Integer): LongBool;
  {-}
begin
 Result := (aCode = 0);
end;

function m1LZOMaxMem(ASize: Integer): Integer;
  {-}
begin
 Result := m0LZOCompressBuffSize(aSize);
end;

function m1LZOEncode(ADest     : Pointer;
                     var ADLen : Integer;
                     ASour     : Pointer;
                     ASLen     : Integer): Integer;
  {-}
begin
 Result := m0LZOCompress(aDest, aDLen, aSour, aSLen);
end;

function m1LZODecode(ADest       : PAnsiChar;
                     var   ADLen : Integer;
                     ASour       : PAnsiChar;
                     ASLen       : Integer): Integer;
  {-}
(*const
 cGap = 4 * 1024;
var
 l_SafeBuffer : PAnsiChar;
 l_NeedFree   : Boolean;
 l_Size       : Integer;
 l_OldProtect : Cardinal;
 l_Tail       : PAnsiChar;
var
 OldEBX : Cardinal;
 OldEDI : Cardinal;
 OldESI : Cardinal;*)
begin
(* l_NeedFree := true;
 Assert(ADLen > 0);
 Assert(ADLen > ASLen);
 l_Size := ADLen * 2;
 l_Size := ((l_Size div cGap) + 2) * cGap;
 l_SafeBuffer := l3System.GlobalAllocPtr(l_Size);
 try
  l_Tail := PAnsiChar(l_SafeBuffer) + l3System.GlobalSize(l_SafeBuffer) - cGap;
  if not VirtualProtect(l_Tail,
                        cGap,
                        PAGE_READONLY,
                        @l_OldProtect) then
   Assert(false, 'Не удалось защитить хвост буфера');
  try
   asm
    mov OldEBX, ebx
    mov OldEDI, edi
    mov OldESI, esi
   end;//asm
   try
    Result := m0LZODecompress(l_SafeBuffer, aDLen, ASour, aSLen);
   except
    asm
     mov ebx, OldEBX
     mov edi, OldEDI
     mov esi, OldESI
    end;//asm
    raise Exception.Create('Проезд по память в распаковщике LZO');
    Result := Cm0LZOLibEOutputOvr;
    l_NeedFree := false; 
    Exit;
   end;//try..except
   //if m1LZOIsValidResult(Result) then
   begin
    //Assert(ADLen <= ASLen);
    //m2MEMCopy(ADest, l_SafeBuffer, ADLen);
    m2MEMCopy(ADest, l_SafeBuffer, ADLen);
   end;//m1LZOIsValidResult(Result)
  finally
   if not VirtualProtect(l_Tail,
                         cGap,
                         l_OldProtect,
                         @l_OldProtect) then
    Assert(false, 'Не удалось снять защиту с буфера');
  end;//try..finally
 finally
  if l_NeedFree then
   l3System.GlobalFreePtr(Pointer(l_SafeBuffer));
 end;//try..finally*)
 Result := m0LZODecompress(aDest, aDLen, aSour, aSLen);
end;

end.
