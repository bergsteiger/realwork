unit tb97Mem;

{ Ѕиблиотека "Toolbar 97" }
{ јвтор: Ћюлин ј.¬. ©     }
{ ћодуль: tb97Mem -       }
{ Ќачат: 13.09.2004 16:23 }
{ $Id: tb97Mem.pas,v 1.7 2013/07/08 16:43:20 lulin Exp $ }

// $Log: tb97Mem.pas,v $
// Revision 1.7  2013/07/08 16:43:20  lulin
// - выдел€ем работу с размером куска пам€ти.
//
// Revision 1.6  2008/01/31 16:15:53  lulin
// - cleanup.
//
// Revision 1.5  2007/08/14 19:31:49  lulin
// - оптимизируем очистку пам€ти.
//
// Revision 1.4  2004/09/13 15:00:49  lulin
// - bug fix: была бесконечна€ рекурси€.
//
// Revision 1.3  2004/09/13 14:52:43  lulin
// - bug fix: не компилировалось без L3.
// - bug fix: были перекрыты Destroy, а не Cleanup - из-за этого отьезжали Toolbar'ы.
//
// Revision 1.2  2004/09/13 13:19:44  lulin
// - оптимизаци€ tb97GetMem на основе знаний о том что чаще всего распредел€ютс€ куски пам€ти размером 4 и 12.
//
// Revision 1.1  2004/09/13 12:52:10  lulin
// - в Toolbar97 прикрутили слежение за пам€тью.
//

{$I TB97Ver.inc}

interface

procedure tb97GetMem(var P; Size: Cardinal);
  {* - получить кусок локальной пам€ти размером Size. }
function  tb97AllocMem(Size: Cardinal): Pointer;
  {-}
procedure tb97FreeMem(var P);
  {* - освободить кусок локальной пам€ти. }
procedure tb97FreeMemPrim(P: Pointer);
  {* - освободить кусок локальной пам€ти. }

implementation

uses
  l3Base,
  l3MemorySizeUtils,
  l3Memory
  ;

var
 gBuf4: Pl3MemoryChain = nil;
 gBuf12: Pl3MemoryChain = nil;

procedure tb97GetMem(var P; Size: Cardinal);
  {* - получить кусок локальной пам€ти размером Size. }
begin
 Case Size of
  4:
   gBuf4.AllocItem(Pointer(P));
  12:
   gBuf12.AllocItem(Pointer(P));
  else
   l3System.GetLocalMem(P, Size);
 end;//Case Size
end;

function tb97AllocMem(Size: Cardinal): Pointer;
  {-}
begin
 tb97GetMem(Result, Size);
 l3FillChar(Result^, Size, 0);
end;

procedure tb97FreeMem(var P);
  {* - освободить кусок локальной пам€ти. }
begin
 Case l3MemorySize(Pointer(P)) of
  4:
   gBuf4.FreeItem(Pointer(P));
  12:
   gBuf12.FreeItem(Pointer(P));
  else
   l3System.FreeLocalMem(P);
 end;//Case l3MemorySize(Pointer(P))
end;

procedure tb97FreeMemPrim(P: Pointer);
  {* - освободить кусок локальной пам€ти. }
begin
 tb97FreeMem(P);
end;

initialization
 gBuf4 := l3NewMemoryChain(12);
 gBuf12 := l3NewMemoryChain(12);

end.

