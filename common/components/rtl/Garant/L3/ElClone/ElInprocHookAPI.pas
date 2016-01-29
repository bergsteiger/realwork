{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$I ElPack.inc}

(*

Version History

01/06/2003

  Original version created.

*)

{$IFNDEF MSWINDOWS}
  {$MESSAGE Error 'for windows platform only and only Intel x86 '}
{$ENDIF}

unit ElInprocHookAPI;
{$B-}

interface

uses
 Windows,
 SysUtils,
 TlHelp32;

type
 {$IFNDEF VCL_6_USED}
  PPointer  = ^Pointer;
 {$IFDEF BUILDER_USED}
 {$EXTERNALSYM PWORD}
 {$ENDIF}
  PWORD     = ^WORD;
 {$IFDEF BUILDER_USED}
 {$EXTERNALSYM PDWORD}
 {$ENDIF}
  PDWORD    = ^DWORD;
 {$ENDIF IFNDEF VCL_6_USED}

  {$IFDEF B_6_UP}
  {$EXTERNALSYM PPPointer}
  {$ENDIF}
  PPPointer = ^PPointer;

  PJumpInstruction = ^TJumpInstruction;
  TJumpInstruction = packed record
    case byte of
      1:(
        Code   :Byte;  // jump instruction ($FF)
        Offset :DWORD; // jump offset
      );
      2:(
        DW1: DWORD;
        DW2: DWORD;
      );
  end;

function GetNativeAddr( Ptr: Pointer ):Pointer;
function JumpFromCode( MSrc, MDest: Pointer; SaveJump: PJumpInstruction ): Boolean;
function RestoreSavedCode( MSrc: Pointer; var SaveJump: TJumpInstruction ): Boolean;

function IsJumpFromCode( MSrc, MDest: Pointer ): Boolean;

// winnt.h

type
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM PImageImportByName}
  {$ENDIF}
  PImageImportByName    = ^TImageImportByName;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM _IMAGE_IMPORT_BY_NAME}
  {$ENDIF}
  _IMAGE_IMPORT_BY_NAME = packed record
    Hint  :WORD;
    Name  :BYTE;
  end;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM IMAGE_IMPORT_BY_NAME}
  {$ENDIF}
  IMAGE_IMPORT_BY_NAME  = _IMAGE_IMPORT_BY_NAME;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM PIMAGE_IMPORT_BY_NAME}
  {$ENDIF}
  PIMAGE_IMPORT_BY_NAME = ^IMAGE_IMPORT_BY_NAME;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM TImageImportByName}
  {$ENDIF}
  TImageImportByName    = _IMAGE_IMPORT_BY_NAME;

  PImageThunkData   = ^TImageThunkData;
  {$IFDEF BUILDER_USED}
  {$IFNDEF B_5_UP}
  {$EXTERNALSYM IMAGE_THUNK_DATA}
  {$ENDIF}
  {$ENDIF}
  _IMAGE_THUNK_DATA = packed record
     case byte of
       0: (ForwarderString  :PBYTE);
       1: (FFunction        :PDWORD);
       2: (Ordinal          :DWORD);
       3: (AddressOfData    :PIMAGE_IMPORT_BY_NAME)
  end;
  {$IFDEF BUILDER_USED}
  {$IFNDEF B_5_UP}
  {$EXTERNALSYM IMAGE_THUNK_DATA}
  {$ENDIF}
  {$ENDIF}
  IMAGE_THUNK_DATA  = _IMAGE_THUNK_DATA;
  {$IFDEF BUILDER_USED}
  {$IFNDEF B_5_UP}
  {$EXTERNALSYM IMAGE_THUNK_DATA}
  {$ENDIF}
  {$ENDIF}
  PIMAGE_THUNK_DATA = ^IMAGE_THUNK_DATA;
  {.$IFDEF BUILDER_USED}
  {.$EXTERNALSYM TImageThunkData}
  {.$ENDIF}
  TImageThunkData   = _IMAGE_THUNK_DATA;

  {.$IFDEF BUILDER_USED}
  {.$EXTERNALSYM PImageImportDescriptor}
  {.$ENDIF}
  PImageImportDescriptor   = ^TImageImportDescriptor;
  {.$IFDEF BUILDER_USED}
  {.$EXTERNALSYM _IMAGE_IMPORT_DESCRIPTOR}
  {.$ENDIF}
  _IMAGE_IMPORT_DESCRIPTOR = packed record
    OriginalFirstThunk  :PIMAGE_THUNK_DATA; // = DWORD
    TimeDateStamp       :DWORD;
    ForwarderChain      :DWORD;
    Name                :DWORD;
    FirstThunk          :PIMAGE_THUNK_DATA;
  end;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM IMAGE_IMPORT_DESCRIPTOR}
  {$ENDIF}
  IMAGE_IMPORT_DESCRIPTOR  = _IMAGE_IMPORT_DESCRIPTOR;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM PIMAGE_IMPORT_DESCRIPTOR}
  {$ENDIF}
  PIMAGE_IMPORT_DESCRIPTOR = ^IMAGE_IMPORT_DESCRIPTOR;
  {.$IFDEF BUILDER_USED}
  {.$EXTERNALSYM TImageImportDescriptor}
  {.$ENDIF}
  TImageImportDescriptor   = _IMAGE_IMPORT_DESCRIPTOR;

{$IFNDEF VCL_5_USED}
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM PImageDosHeader}
  {$ENDIF}
  PImageDosHeader = ^TImageDosHeader;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM TImageDosHeader}
  {$ENDIF}
  TImageDosHeader = packed record  { DOS .EXE header                  }
    e_magic: Word;                 { Magic number                     }
    e_cblp: Word;                  { Bytes on last page of file       }
    e_cp: Word;                    { Pages in file                    }
    e_crlc: Word;                  { Relocations                      }
    e_cparhdr: Word;               { Size of header in paragraphs     }
    e_minalloc: Word;              { Minimum extra paragraphs needed  }
    e_maxalloc: Word;              { Maximum extra paragraphs needed  }
    e_ss: Word;                    { Initial (relative) SS value      }
    e_sp: Word;                    { Initial SP value                 }
    e_csum: Word;                  { Checksum                         }
    e_ip: Word;                    { Initial IP value                 }
    e_cs: Word;                    { Initial (relative) CS value      }
    e_lfarlc: Word;                { File address of relocation table }
    e_ovno: Word;                  { Overlay number                   }
    e_res: array [0..3] of Word;   { Reserved words                   }
    e_oemid: Word;                 { OEM identifier (for e_oeminfo)   }
    e_oeminfo: Word;               { OEM information; e_oemid specific}
    e_res2: array [0..9] of Word;  { Reserved words                   }
    _lfanew: LongInt;              { File address of new exe header   }
  end;

  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM PImageExportDirectory}
  {$ENDIF}
  PImageExportDirectory = ^TImageExportDirectory;
  {$IFDEF BUILDER_USED}
  {$EXTERNALSYM TImageExportDirectory}
  {$ENDIF}
  TImageExportDirectory = packed record
    Characteristics: DWord;
    TimeDateStamp: DWord;
    MajorVersion: Word;
    MinorVersion: Word;
    Name: DWord;
    Base: DWord;
    NumberOfFunctions: DWord;
    NumberOfNames: DWord;
    AddressOfFunctions: ^PDWORD;
    AddressOfNames: ^PDWORD;
    AddressOfNameOrdinals: ^PWord;
  end;
{$ENDIF IFNDEF VCL_5_USED}

function GetModuleFromAddress( Addr: Pointer ): HMODULE;
function GetModuleNtHeaders( Module: THandle ): PImageNTHeaders;
function GetModuleExportDirectory( Module: THandle ): PImageExportDirectory;
function GetModuleImportDirectory( Module: THandle ): PImageImportDescriptor;
function SetProcAddressETA( Module: THandle; const ProcName: String; NewAddr: Pointer ): Boolean;
function GetProcAddressETAOrd( Module: THandle; Ord: DWORD ): Pointer;
function GetProcAddressETA( Module: THandle; const ProcName: String ): Pointer;
function UnprotectMemory( Addr: Pointer; MemSize: DWORD; MemProtection: DWORD ): Boolean;

function HookImportTableApiFunction( hFromModule: hModule; const FunctionModule,
                                     FunctionName: String; NewProc: Pointer): Pointer;

const
 // HookApi_GetCodeTemplateInfo
  ci_code_ptr  = 1;
  ci_code_size = 2;
  ci_code_data_offset = 3;

procedure HookApi_GetCodeTemplateInfo(
  pTemplate: Pointer; DataAllocSize: DWORD;
  var pCode: Pointer; var DataOffset, CodeSize: DWORD );
function HookApi_GetBuffer( BuffSize: DWORD; const sBuffID: String;
  var hSharedMem: THandle;var bFirstAllocate: Boolean ): Pointer;
function HookApi_CreateCodeTemplate( pCodeTemplate: Pointer; DataAllocSize: DWORD;
  const sCodeID: String; var hSharedMem: THandle; var bFirstAllocate: Boolean;
  var CodeData: Pointer; var CodeSize: DWORD ): Pointer;
function HookApi_LockCodeTemplate( var hSharedMem: THandle; bFirstAllocate: Boolean ): Boolean;

function BeginLock( const LockName: String; var hLock: THandle ): Boolean;
procedure EndLock( var hLock: THandle );

function IsBadWritePtrSize( Ptr: Pointer; Size: DWORD): Boolean;
function IsBadWritePtrPtr( Ptr: Pointer ): Boolean;
function IsBadReadPtrSize( Ptr: Pointer; Size: DWORD): Boolean;
function IsBadReadPtrPtr( Ptr: Pointer ): Boolean;

{$IFNDEF VCL_6_USED}
function GetModuleName( Module: HMODULE ): String;
{$ENDIF IFNDEF VCL_6_USED}

implementation

uses
{$IFNDEF VCL_5_USED}
 ElVCLUtils, // usage of SafeLoadLibrary
{$ENDIF IFNDEF VCL_5_USED}
 l3Base
 ;

{ InProcess Hook Hack API }

{$IFNDEF VCL_6_USED}
function GetModuleName( Module: HMODULE ): String;
var
  ModName: array[0..MAX_PATH] of Char;
begin
  SetString(Result, ModName, Windows.GetModuleFileName(Module, ModName, SizeOf(ModName)));
end;
{$ENDIF IFNDEF VCL_6_USED}

function MakePtr( Addr: Pointer; Shift: Integer ): Pointer;
begin
  Result := Pointer( Integer(Addr)+Shift );
end;

function IsBadWritePtrSize( Ptr: Pointer; Size: DWORD): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_WRITABLE = PAGE_EXECUTE_WRITECOPY or PAGE_EXECUTE_READWRITE or
                  PAGE_READWRITE or PAGE_WRITECOPY;
begin
  Result := VirtualQuery(Ptr, mbi, SizeOf(mbi)) <> 0;
  if Result then
  begin
    Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_WRITABLE)= 0);
    if Result then
      exit;
    if Ptr<>mbi.BaseAddress then
      Inc(Size, DWORD(Ptr) - DWORD(mbi.BaseAddress) );
    if (Size<= mbi.RegionSize) then
      exit;
    while True do // search bad write block
    begin
      Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_WRITABLE)= 0);
      if Result or (Size<= mbi.RegionSize) then
        break;
      Dec(Size, mbi.RegionSize);
      // Seek Ptr to next region:
      Ptr := Pointer(DWORD(mbi.BaseAddress) + mbi.RegionSize + 1);
      if VirtualQuery(Ptr, mbi, SizeOf(mbi)) = 0 then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function IsBadWritePtrPtr( Ptr: Pointer ): Boolean;
begin
 Result := IsBadWritePtrSize( Ptr, SizeOf(Pointer));
end;

function IsBadReadPtrSize( Ptr: Pointer; Size: DWORD): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_READABLE = PAGE_READONLY or PAGE_EXECUTE_READWRITE or
                  PAGE_READWRITE or PAGE_EXECUTE_READ;
begin
  Result := VirtualQuery(Ptr, mbi, SizeOf(mbi)) <> 0;
  if Result then
  begin
    Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_READABLE) = 0);
    if Result then
      exit;
    if Ptr<>mbi.BaseAddress then
      Inc(Size, DWORD(Ptr) - DWORD(mbi.BaseAddress) );
    if (Size<= mbi.RegionSize) then
      exit;
    while True do // search bad read block
    begin
      Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_READABLE) = 0);
      if Result or (Size<= mbi.RegionSize) then
        break;
      Dec(Size, mbi.RegionSize);
      // Seek Ptr to next region:
      Ptr := Pointer(DWORD(mbi.BaseAddress) + mbi.RegionSize + 1);
      if VirtualQuery(Ptr, mbi, SizeOf(mbi)) = 0 then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function IsBadReadPtrPtr( Ptr: Pointer): Boolean;
begin
 Result := IsBadReadPtrSize(Ptr, SizeOf(Pointer));
end;

function GetModuleFromAddress( Addr: Pointer ): HMODULE;
  var
    mbi: TMemoryBasicInformation;
begin
   if (VirtualQuery(Addr, mbi, SizeOf(mbi)) <> 0) then
     Result := DWORD(mbi.AllocationBase)
   else
     Result := 0;
end;

function GetModuleNtHeaders( Module: THandle ): PImageNTHeaders;
var
  pDosHeader: PImageDosHeader absolute Module;
  pNTHeader: PImageNTHeaders;
begin
  Result := nil;
  if (Module=0) then
    exit;
  try
    if IsBadReadPtrSize( pDosHeader, SizeOf(TImageDosHeader) ) or
       (pDosHeader.e_magic <> IMAGE_DOS_SIGNATURE ) then
      exit;
    Pointer(pNTHeader) := MakePtr(pDosHeader, pDosHeader._lfanew);
    if IsBadReadPtrSize( pNTHeader, SizeOf(TImageNTHeaders) ) or
       (pNTHeader.Signature <> IMAGE_NT_SIGNATURE) then
       exit;
    Result := pNTHeader;
  except
  end;
end;

function GetModuleExportDirectory( Module: THandle ): PImageExportDirectory;
var
  pNTHeader: PImageNTHeaders;
begin
  Result:=nil;
  if (Module=0) then
    exit;
  try
    pNTHeader := GetModuleNtHeaders(Module);
    if (pNTHeader = nil) or
       (pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress = 0 )
    then
      exit;
    Pointer(Result) :=
      MakePtr( Pointer(Module),
       pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress );
  except
  end;
end;

function GetModuleImportDirectory( Module: THandle ): PImageImportDescriptor;
var
  pNTHeader: PImageNTHeaders;
begin
  Result:=nil;
  if (Module=0) then
    exit;
  try
    pNTHeader := GetModuleNtHeaders(Module);
    if (pNTHeader = nil) or
       (pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress = 0 )
    then
      exit;
    Pointer(Result) :=
      MakePtr( Pointer(Module),
       pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress );
  except
  end;
end;

{$R-} // !!!
type
  TArrayOfDWord = array [0..0] of DWORD;
  PArrayOfDWord = ^TArrayOfDWord;
  TArrayOfWord = array [0..0] of WORD;
  PArrayOfWord = ^TArrayOfWord;

function GetProcAddressETAOrd( Module: THandle; Ord: DWORD ): Pointer;
var
  ETA : PImageExportDirectory;
begin
  dec(Ord);
  Result:=nil;
  try
    ETA:=GetModuleExportDirectory(Module);
    if (ETA<>nil)and(Ord<ETA.NumberOfFunctions) then
      Result:=Pointer(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[Ord]);
  except
  end;
end;

function UnprotectMemoryWin9X( Addr: Pointer; MemSize: DWORD ): Boolean;
var
  IntAddr: DWORD absolute Addr;
  FirstPage: DWORD;
  PageCount: DWORD;
  VxDCall0 : Pointer;
const
 // PageCommit Flags:
  PC_WRITEABLE = $00020000;  // make the pages writeable
  PC_USER      = $00040000;  // make the pages ring 3 accessible
  PC_STATIC    = $20000000;  // allow commit in PR_STATIC object
  PC_FIXED     = $00000008;  // pages are permanently locked
  PC_LOCKED    = $00000080;  // pages are made present and locked
 // Page Permisions Flags:
  c_PageModifyPermissions = $1000D;
begin
  Result := False;
  if (MemSize=0)or(Addr=nil) then
    exit;
  FirstPage:=IntAddr div 4096;
  PageCount := (IntAddr+MemSize-FirstPage*4096+4095) div 4096;
  dec(IntAddr, IntAddr mod 4096 );
  MemSize := PageCount*4096;
  if  not IsBadWritePtrSize(Addr, MemSize) then
    Result := True
  else
  try
    VxDCall0:=GetProcAddressETAOrd(GetModuleHandle(kernel32), 1);
    if @VxDCall0=nil then
      exit;
    asm
      push    PC_WRITEABLE or PC_USER or PC_STATIC
      push    $0FFFFFFFF
      push    PageCount
      push    dword ptr [FirstPage]
      push    c_PageModifyPermissions
      call    dword ptr [VxDCall0]
    end;
    Result := not IsBadWritePtrSize(Addr, MemSize);
  except
  end;
end;

function IsExecutePage( Addr: Pointer ): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_EXECUTABLE = PAGE_EXECUTE_READWRITE or PAGE_EXECUTE_READ or
    PAGE_EXECUTE or PAGE_EXECUTE_WRITECOPY;
begin
 Result := Assigned(Addr) and ( VirtualQuery(Addr, mbi, SizeOf(mbi)) <> 0 );
 if Result then
   Result := (mbi.Protect and PAGE_EXECUTABLE) <> 0;
end;

function UnprotectMemory( Addr: Pointer; MemSize: DWORD; MemProtection: DWORD ): Boolean;
var
  SaveFlag: DWORD;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    if (MemSize=0)or(Addr=nil) then
    begin
      Result := False;
      exit;
    end;
    Result := IsBadWritePtrSize(Addr, MemSize);
    if Result then
    begin
      if MemProtection <>0 then
        Result := VirtualProtect( Addr,  MemSize, MemProtection, @SaveFlag )
      else
      if IsExecutePage(Addr) then
        Result := VirtualProtect( Addr,  MemSize, PAGE_EXECUTE_READWRITE, @SaveFlag )
      else
        Result := VirtualProtect( Addr,  MemSize, PAGE_READWRITE, @SaveFlag );
    end;
    if not Result then
      Result := not IsBadWritePtrSize(Addr, MemSize);
  end
  else
    Result := UnprotectMemoryWin9X(Addr, MemSize);
end;

function SetProcAddressETA( Module: THandle; const ProcName: String; NewAddr: Pointer ): Boolean;
var
  ETA: PImageExportDirectory;
  i: integer;
  pAddr: PInteger;
begin
  Result := False;
  if (Module=0) or (ProcName='') or (NewAddr=nil) or
     (GetProcAddressETA(Module, ProcName) = NewAddr) then
    exit;
  try
    ETA:=GetModuleExportDirectory(module);
    if ETA<>nil then
      for i:=0 to ETA.NumberOfNames-1 do
        if CompareText(PChar(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfNames))^[i]), ProcName)=0 then
        begin
          pAddr := @(PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[
            PArrayOfWord(Module+DWORD(ETA.AddressOfNameOrdinals))^[i]]);

          if not UnprotectMemory(pAddr,  SizeOf(DWORD), PAGE_READWRITE) then
            exit;

          Integer(Module) := integer(NewAddr)-integer(Module);

          asm // pAddr^ := Integer(Module);
            mov     eax, pAddr
            mov     edx, Module
            xchg    [eax], edx
          end;

          Result:=True;
          break;
        end;
  except
  end;
end;

function GetProcAddressETA( Module: THandle; const ProcName: String ): Pointer;
var
  ETA: PImageExportDirectory;
  i: integer;
begin
  Result := nil;
  if (Module=0) or (ProcName='') then
    exit;
  try
    ETA:=GetModuleExportDirectory(Module);
    if ETA<>nil then
      for i:=0 to ETA.NumberOfNames-1 do
        if CompareText(
            PChar(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfNames))^[i]),
            ProcName
           )=0 then
        begin
          Result := Pointer(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[
            PArrayOfWord(Module+DWORD(ETA.AddressOfNameOrdinals))^[i]]);
          break;
        end;
  except
  end;
  if (Result=nil) and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    Result := Windows.GetProcAddress(Module, PChar(ProcName));
end;

function HookImportTableApiFunction( hFromModule: hModule; const FunctionModule,
                                     FunctionName: String; NewProc: Pointer): Pointer;
 var
  pDosHeader        :PImageDosHeader absolute hFromModule;
  pfnOriginalProc   :Pointer;
  pImportDesc       :PImageImportDescriptor;
  pThunk            :PImageThunkData;
  pszModName        :PChar;
const
  cPushOpCode: byte = $68;   // The PUSH opcode on x86 platforms
var
  ppfn: ppointer;
  lpNumberOfBytesWritten :{$IfDef XE}SIZE_T{$Else}DWORD{$EndIf};
  // Win9X:
  si: TSystemInfo; // The highest private memory address (used for Windows 9X only).
begin
  Result := nil;
  // Verify that a valid pfn was passed
  if (hFromModule=0) or (NewProc=nil) or (FunctionModule='') or (FunctionName='') or
     IsBadCodePtr(NewProc) then
    exit;
  pImportDesc := GetModuleImportDirectory(hFromModule);
  if pImportDesc=nil then
    exit;
  // First, verify the the module and function names passed to use are valid
  pfnOriginalProc := GetProcAddressETA(GetModuleHandleA(PAnsiChar(FunctionModule)),
    PAnsiChar(FunctionName));
  if pfnOriginalProc=nil then
    exit;

  // Functions with address above lpMaximumApplicationAddress require
  // special processing (Windows 9X only)
  GetSystemInfo(si);

  if (DWORD(pfnOriginalProc) > DWORD(si.lpMaximumApplicationAddress)) then
  begin
    // The address is in a shared DLL; the address needs fixing up
    if Byte(PChar(pfnOriginalProc)[0]) = cPushOpCode then
    begin
       // Skip over the PUSH op code and grab the real address
       pfnOriginalProc := PPointer((DWORD(pfnOriginalProc)+SizeOf(Byte)))^;
    end;
  end;
  // Iterate through the array of imported module descriptors, looking
  // for the module whose name matches the pszFunctionModule parameter
  while pImportDesc.Name <> 0 do
  begin
    Pointer(pszModName) := MakePtr(pDosHeader, pImportDesc.Name);
    if StrIComp(pszModName, PChar(FunctionModule)) = 0 then
    begin
      // Get a pointer to the found module's import address table (IAT)
      Pointer(pThunk) := MakePtr(pDosHeader, Integer(pImportDesc.FirstThunk) );
      // Blast through the table of import addresses, looking for the one
      // that matches the address we got back from GetProcAddress above.
      while Assigned(pThunk.FFunction) do
      begin
        ppfn := @(pThunk.FFunction);
        if (PDWORD(ppfn^) <> PDWORD(pfnOriginalProc)) and
           (DWORD(ppfn^) > DWORD(si.lpMaximumApplicationAddress)) then
        begin
          // If this is not the function and the address is in a shared DLL,
          // then maybe we're running under a debugger on Windows 9X. In this
          // case, this address points to an instruction that may have the
          // correct address.
          if (Byte(PChar(ppfn^)[0]) = cPushOpCode) then
          begin
            // We see the PUSH instruction, the real function address follows
            ppfn := @PPointer((DWORD(ppfn^)+SizeOf(Byte)))^;
          end;
        end;
        if PDWORD(ppfn^) = PDWORD(pfnOriginalProc) then
        begin
          if ppfn^ = PDWORD(NewProc) then
            exit;
          // Get the current protection attributes
          try
            if not UnprotectMemory(ppfn, SizeOf(Pointer), PAGE_READWRITE) then
              exit;
            if not WriteProcessMemory( GetCurrentProcess(), ppfn, @NewProc, SizeOf(Pointer),
              lpNumberOfBytesWritten) then
            asm // ppfn^ := PDWORD(NewProc);
              mov     eax, ppfn
              mov     edx, NewProc
              xchg    [eax], edx
            end;
          except
            exit;
          end;
          Result := pfnOriginalProc;
          exit;
        end;
        // Advance to next imported function address
        Inc(pThunk);
      end;
    end;
    // Advance to next imported module descriptor
    Inc(pImportDesc);
  end;
end; { HookImportTableApiFunction }

procedure HookApi_GetCodeTemplateInfo(
  pTemplate: Pointer; DataAllocSize: DWORD;
  var pCode: Pointer; var DataOffset, CodeSize: DWORD );
begin
  asm
    // 1
    mov   eax, ci_code_ptr
    call  dword ptr [pTemplate]

    mov   edx, pCode
    mov   [edx], eax // - address of first entry point of code

    // 2
    mov   eax, ci_code_data_offset
    call  dword ptr [pTemplate]

    mov   edx, DataOffset
    mov   [edx], eax // - offset data from code_start

    // 3
    mov   eax, ci_code_size
    call  dword ptr [pTemplate]

    add   eax, DataAllocSize
    mov   edx, CodeSize
    mov   [edx], eax // - code and data size
  end;
end;

function HookApi_GetBuffer( BuffSize: DWORD; const sBuffID: String;
  var hSharedMem: THandle; var bFirstAllocate: Boolean): Pointer;
begin
  hSharedMem := 0;
  bFirstAllocate := False;
  Result := nil;
  if Length(sBuffID)=0 then
    exit;
  hSharedMem := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
    PAGE_READWRITE or SEC_NOCACHE or SEC_COMMIT, 0, BuffSize, PChar(sBuffID) );
  bFirstAllocate := not (GetLastError = ERROR_ALREADY_EXISTS);
  if (not bFirstAllocate) and ((hSharedMem=ERROR_INVALID_HANDLE)or(hSharedMem=0)) then
    hSharedMem := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(sBuffID) );
  if (hSharedMem=ERROR_INVALID_HANDLE)or(hSharedMem=0) then
  begin
    hSharedMem := 0;
    bFirstAllocate := False;
    exit;
  end;
  Result := MapViewOfFile(hSharedMem, FILE_MAP_ALL_ACCESS, 0, 0, 0);
  if Result=nil then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
    bFirstAllocate := False;
  end
  else
  if bFirstAllocate then
    l3FillChar(Result^, BuffSize, 0);
end;

function HookApi_CreateCodeTemplate( pCodeTemplate: Pointer; DataAllocSize: DWORD;
  const sCodeID: String; var hSharedMem: THandle; var bFirstAllocate: Boolean;
  var CodeData: Pointer; var CodeSize: DWORD): Pointer;
var
  DataOffset: DWORD;
  pCode: Pointer;
begin
  hSharedMem := 0;
  CodeData := nil;
  CodeSize := 0;
  bFirstAllocate := False;
  HookApi_GetCodeTemplateInfo( pCodeTemplate, DataAllocSize, pCode, DataOffset, CodeSize);
  Result := HookApi_GetBuffer( CodeSize, sCodeID, hSharedMem, bFirstAllocate);
  CodeData :=  Pointer( DWORD(Result)+ DataOffset );
  if bFirstAllocate then // copy code:
    l3Move(pCode^, Result^, CodeSize-DataAllocSize);
end;

function HookApi_LockCodeTemplate( var hSharedMem: THandle; bFirstAllocate: Boolean): Boolean;
var
  PH, CPH :THandle;
 // CreateToolhelp32Snapshot
  hSnapshot: THandle;
  pe: TProcessEntry32;
  bOk: Boolean;
  bIsDuplicated: Boolean;
begin
  Result := False;
  if (hSharedMem=0) then
    exit;
  if not bFirstAllocate then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
  end
  else
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Result := True;
    CPH := GetCurrentProcess;
    if not DuplicateHandle(CPH, hSharedMem, CPH, nil, 0, False, DUPLICATE_SAME_ACCESS) then
      hSharedMem := 0;
  end
  else
  begin
    hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnapshot = INVALID_HANDLE_VALUE) then
      exit;
    CPH := GetCurrentProcess;
    try
      l3FillChar(pe, SizeOf(pe), 0);
      pe.dwSize := sizeof(pe);
      bOK := Process32First(hSnapshot, pe);
      bIsDuplicated := False;
      while bOk do
      begin
        PH := OpenProcess( PROCESS_DUP_HANDLE, False, pe.th32ProcessID);
        if PH<>0 then
        begin
          if (PH<>CPH)and
            DuplicateHandle(GetCurrentProcess, hSharedMem, PH, nil, 0, False, DUPLICATE_SAME_ACCESS)
          then
            bIsDuplicated := True;
          CloseHandle(PH);
        end;
        bOK := Process32Next(hSnapshot, pe);
      end;//of: while bOK
      Result := bIsDuplicated;
    finally
      CloseHandle(hSnapshot);
    end;
  end;
  if hSharedMem<>0 then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
  end;
end;

function GetNativeAddr( Ptr:Pointer ): Pointer;
begin
  Result := Ptr;
  if  (PJumpInstruction(Result)^.Code=$FF) and               // if instruction == jump to table
      (PJumpInstruction(Integer(Result)+6)^.Code=$8B) and    // if instruction == mov eax, eax
      (PJumpInstruction(Integer(Result)+7)^.Code=$C0)
  then
    Result := PPPointer(Integer(Result) + 2)^^;
end; { GetNativeAddr }

function JumpFromCode( MSrc, MDest: Pointer; SaveJump: PJumpInstruction ): Boolean;
var
  mCache: TJumpInstruction;
begin
  Result := False;
  if MSrc=nil then
    exit;
  try
    if Assigned(SaveJump) then
      l3FillChar(SaveJump^, SizeOf(TJumpInstruction), 0);
    UnprotectMemory( MSrc, SizeOf(TJumpInstruction), PAGE_EXECUTE_READWRITE );
    if Assigned(SaveJump) then
      SaveJump^ := PJumpInstruction(MSrc)^;
    with mCache do
    begin
      DW2             := 0;
      Code            := $E9;
      Integer(Offset) := Integer(MDest) - Integer(MSrc) - 5;
    end;
    asm // PJumpInstruction(MSrc)^ : =mCache;
      push    ecx
      mov     eax, MSrc
      mov     edx, mCache.DW1
      mov     ecx, mCache.DW2
      xchg    [eax].TJumpInstruction.DW1, edx
      xchg    [eax].TJumpInstruction.DW2, ecx
      pop     ecx
    end;
    FlushInstructionCache(GetCurrentProcess, MSrc, SizeOf(TJumpInstruction));
    Result := True;
  except
  end;
end; { JumpFromCode }

function RestoreSavedCode( MSrc: Pointer; var SaveJump: TJumpInstruction ): Boolean;
begin
  Result := False;
  if Assigned(MSrc)and(SaveJump.Code<>0) then
  try
    UnprotectMemory( MSrc, SizeOf(TJumpInstruction), PAGE_EXECUTE_READWRITE );
    asm // PJumpInstruction(MSrc)^ := SaveJump;
      push    ecx
      mov     eax, SaveJump
      mov     edx, [eax].TJumpInstruction.DW1
      mov     ecx, [eax].TJumpInstruction.DW2
      mov     eax, MSrc
      xchg    [eax].TJumpInstruction.DW1, edx
      xchg    [eax].TJumpInstruction.DW2, ecx
      pop     ecx
    end;
    FlushInstructionCache(GetCurrentProcess, MSrc, SizeOf(TJumpInstruction));
    // Clear Buffer
    l3FillChar(SaveJump, SizeOf(TJumpInstruction), 0);
    Result := True;
  except
  end;
end; { RestoreSavedCode }

function IsJumpFromCode( MSrc, MDest: Pointer): Boolean;
begin
  if (MSrc=nil) or (MDest=nil) then
    Result := False
  else
    with PJumpInstruction(MSrc)^ do
      Result := (Code = $E9) and (Integer(Offset) = (Integer(MDest) - Integer(MSrc) - 5));
end; { IsJumpFromCode }

function BeginLock( const LockName: String; var hLock: THandle ): Boolean;
begin
  hLock := CreateMutex(nil, True, PChar(LockName));
  Result := hLock<>0;
  if Result then
  begin
    Result := WaitForSingleObject( hLock, INFINITE ) = WAIT_OBJECT_0;
    if not Result then
    begin
      CloseHandle(hLock);
      hLock := 0;
    end;
  end;
end;

procedure EndLock( var hLock: THandle );
begin
  if hLock<>0 then
  begin
    CloseHandle(hLock);
    hLock := 0;
  end;
end;

end.
