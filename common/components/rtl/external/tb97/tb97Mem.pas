unit tb97Mem;

{ ���������� "Toolbar 97" }
{ �����: ����� �.�. �     }
{ ������: tb97Mem -       }
{ �����: 13.09.2004 16:23 }
{ $Id: tb97Mem.pas,v 1.7 2013/07/08 16:43:20 lulin Exp $ }

// $Log: tb97Mem.pas,v $
// Revision 1.7  2013/07/08 16:43:20  lulin
// - �������� ������ � �������� ����� ������.
//
// Revision 1.6  2008/01/31 16:15:53  lulin
// - cleanup.
//
// Revision 1.5  2007/08/14 19:31:49  lulin
// - ������������ ������� ������.
//
// Revision 1.4  2004/09/13 15:00:49  lulin
// - bug fix: ���� ����������� ��������.
//
// Revision 1.3  2004/09/13 14:52:43  lulin
// - bug fix: �� ��������������� ��� L3.
// - bug fix: ���� ��������� Destroy, � �� Cleanup - ��-�� ����� ��������� Toolbar'�.
//
// Revision 1.2  2004/09/13 13:19:44  lulin
// - ����������� tb97GetMem �� ������ ������ � ��� ��� ���� ����� �������������� ����� ������ �������� 4 � 12.
//
// Revision 1.1  2004/09/13 12:52:10  lulin
// - � Toolbar97 ���������� �������� �� �������.
//

{$I TB97Ver.inc}

interface

procedure tb97GetMem(var P; Size: Cardinal);
  {* - �������� ����� ��������� ������ �������� Size. }
function  tb97AllocMem(Size: Cardinal): Pointer;
  {-}
procedure tb97FreeMem(var P);
  {* - ���������� ����� ��������� ������. }
procedure tb97FreeMemPrim(P: Pointer);
  {* - ���������� ����� ��������� ������. }

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
  {* - �������� ����� ��������� ������ �������� Size. }
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
  {* - ���������� ����� ��������� ������. }
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
  {* - ���������� ����� ��������� ������. }
begin
 tb97FreeMem(P);
end;

initialization
 gBuf4 := l3NewMemoryChain(12);
 gBuf12 := l3NewMemoryChain(12);

end.

