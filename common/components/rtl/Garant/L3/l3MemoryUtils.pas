unit l3MemoryUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3MemoryUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3Utils::l3MemoryUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Windows
  ;

type
 Tl3MemKind = (
   l3_mkFree
 , l3_mkReserved
 );//Tl3MemKind
function L3GetMaxMemoryAvail(aKind: Tl3MemKind = l3_mkFree): DWORD;
   {* Размер максимального непрерывного куска памяти }
procedure L3GetMemoryAvail(aKind: Tl3MemKind;
  out theMax: DWORD;
  out theAll: DWORD);

implementation

uses
  SysUtils
  ;

// unit methods

function L3GetMaxMemoryAvail(aKind: Tl3MemKind = l3_mkFree): DWORD;
//#UC START# *56937CAF0279_56937C98002D_var*
var
 l_Info: TMemoryBasicInformation;
 l_Ptr: PAnsiChar;
 l_Res: LongWord;
 l_Entry: TProcessHeapEntry;
const
 cMap: array [Tl3MemKind] of DWORD = (MEM_FREE, MEM_RESERVE);
//#UC END# *56937CAF0279_56937C98002D_var*
begin
//#UC START# *56937CAF0279_56937C98002D_impl*
 Result := 0;

 // Virtual memory
 l_Ptr := Pointer(0);
 l_Res := VirtualQuery(l_Ptr, l_Info, SizeOf(l_Info));
 if l_Res <> SizeOf(l_Info) then
  RaiseLastOSError;
 while l_Res = SizeOf(l_Info) do
 begin
  if ((l_Info.State and cMap[aKind]) <> 0) and (l_Info.RegionSize > Result) then
   Result := l_Info.RegionSize;
  Inc(l_Ptr, l_Info.RegionSize);
  l_Res := VirtualQuery(l_Ptr, l_Info, SizeOf(l_Info));
 end;

 // Heap
 l_Entry.lpData := nil;
 while HeapWalk(GetProcessHeap, l_Entry) do
 begin
  if ((l_Entry.wFlags and PROCESS_HEAP_UNCOMMITTED_RANGE) <> 0) and (l_Entry.cbData > Result) then
   Result := l_Entry.cbData;
  if ((l_Entry.wFlags and PROCESS_HEAP_REGION) <> 0) and (l_Entry.dwUnCommittedSize > Result) then
   Result := l_Entry.dwUnCommittedSize;
 end;
//#UC END# *56937CAF0279_56937C98002D_impl*
end;//L3GetMaxMemoryAvail

procedure L3GetMemoryAvail(aKind: Tl3MemKind;
  out theMax: DWORD;
  out theAll: DWORD);
//#UC START# *56A9E4250177_56937C98002D_var*
var
 l_Info: TMemoryBasicInformation;
 l_Ptr: PAnsiChar;
 l_Res: LongWord;
 l_Entry: TProcessHeapEntry;
const
 cMap: array [Tl3MemKind] of DWORD = (MEM_FREE, MEM_RESERVE);
//#UC END# *56A9E4250177_56937C98002D_var*
begin
//#UC START# *56A9E4250177_56937C98002D_impl*
 theMax := 0;
 theAll := 0;

 // Virtual memory
 l_Ptr := Pointer(0);
 l_Res := VirtualQuery(l_Ptr, l_Info, SizeOf(l_Info));
 if l_Res <> SizeOf(l_Info) then
  RaiseLastOSError;
 while l_Res = SizeOf(l_Info) do
 begin
  if ((l_Info.State and cMap[aKind]) <> 0) then
  begin
   if (l_Info.RegionSize > theMax) then
    theMax := l_Info.RegionSize;
   theAll := theAll + l_Info.RegionSize;
  end; 
  Inc(l_Ptr, l_Info.RegionSize);
  l_Res := VirtualQuery(l_Ptr, l_Info, SizeOf(l_Info));
 end;
//#UC END# *56A9E4250177_56937C98002D_impl*
end;//L3GetMemoryAvail

end.