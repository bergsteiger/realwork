unit FastShareMem;

(*
 * Shared Memory Allocator for Delphi DLL's
 * Version: 1.21
 *
 * Features:
 *   no runtime dll required.
 *   no performance degradation.
 *
 * Usage:
 *   Must be the first unit listed in the project file's USES section
 *   for both dll and exe projects. If you install a memory manager for
 *   leak detection, it should be listed immediately after this unit.
 *
 * Author: Emil M. Santos
 *   You may use and modify this software as you wish, but this section
 *   must be kept intact. Please see Readme.txt for copyright and disclaimer.
 *
 * Send bugs/comments to fastsharemem@codexterity.com
 * On the web: http://www.codexterity.com
 * To be notified of new versions by email, subscribe to the site alerter facility.

   Revision History:
   2002 Oct  9: Separated MEM_DECOMMIT and MEM_RELEASE calls. Thanks to Maurice Fletcher and Alexandr Kozin.
   2002 Sep  9: Thanks to Ai Ming (aiming@ynxx.com) for these changes:
   				Modified to work with Windows NT/2000/XP.
   				Added reference-counting mechanism.
   2002 Aug 14: Rewrote address-computation code to better match windows 98
                allocation. VirtualAlloc may round down requested address *twice*.
                Replaced ASSERTs with (lower-level) Win32 MessageBox calls.
                (Thanks to Darryl Strickland (DStrickland@carolina.rr.com))
 *)

interface

implementation
uses Windows, SysUtils;

const SignatureBytes1 = $BABE01234567FEED;
      SignatureBytes2 = $F00D76543210B00B;
const iPagesBound     = 15;

type
    TMemMgrPack = record
         RefCount: Integer;  //Reference Count of the MemMgr
         Signature1: int64;
         MemMgr: TMemoryManager;
         Signature2: int64;
    end;
    PMemMgrPack = ^TMemMgrPack;


    procedure ValidatePack( p: PMemMgrPack );
    var pid: DWORD;
    begin
         // use pid for additional safety;
         p^.RefCount := 1;
         pid := GetCurrentProcessId;
         p^.Signature1 := SignatureBytes1 xor pid;
         p^.Signature2 := SignatureBytes2 xor pid;
    end;

    function IsPackValid( p: PMemMgrPack ): boolean;
    var pid: DWORD;
    begin
         pid := GetCurrentProcessId;
         Result := (p^.Signature1 = SignatureBytes1 xor pid) and
                   (p^.Signature2 = SignatureBytes2 xor pid);
    end;

var
  si: TSYSTEMINFO;
  OldMemMgr: TMemoryManager;
  requested, allocated: PMemMgrPack;

  err: integer;
  lpMsgBuf: PChar;
  granul: integer;
  iPages: integer;

initialization
  GetSystemInfo( si );
  iPages := 0;

  //next, fixed by Aimingoo
  repeat
    requested := si.lpMaximumApplicationAddress ;
    requested := pointer( (integer(requested) div $10000) * $10000 ); // align on start of last full 64k page
    dec(integer(requested), iPages * $10000);
    requested := pointer( (integer(requested) div si.dwPageSize) * si.dwPageSize ); // align on start of last full 64k page
    allocated := VirtualAlloc( requested, si.dwPageSize, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE );

    //find a free memory block or a valid MemMgr
    if (allocated <> nil) then
      if (requested = allocated) then
        Break
      else
    else
      if IsPackValid(requested) then
        Break;

    inc(iPages);
  until iPages > iPagesBound;

  if allocated <> nil then
  begin
    if requested <> allocated then
    begin
      MessageBox( 0, 'Shared Memory Allocator setup failed: Address was relocated.', 'FastShareMem', 0 );
      Halt;
    end;

    GetMemoryManager( allocated^.MemMgr );
    ValidatePack( allocated );
  end
  else
  begin
    if not IsPackValid( requested ) then
    begin
      MessageBox( 0, 'Shared Memory Allocator setup failed: Address already reserved.', 'FastShareMem', 0 );
      Halt;
    end;

    GetMemoryManager( OldMemMgr );
    SetMemoryManager( requested^.MemMgr );
    inc(requested^.RefCount);
  end;

finalization
  //next, fixed by Aimingoo
  
  (* fix Reference Count *)
  dec(requested^.RefCount);

  (* restore MemMgr to Old, only for DLL or other model *)
  if allocated = nil then
    SetMemoryManager( OldMemMgr )
  else
    if requested^.RefCount > 0 then
    begin
      TerminateProcess(GetCurrentProcess, 0);
    end;


  (* cleanup *)
  if requested^.RefCount = 0 then
  begin
    VirtualFree( allocated, si.dwPageSize, MEM_DECOMMIT );
    VirtualFree( allocated, 0, MEM_RELEASE );
  end;
end.
