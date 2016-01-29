{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}

{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

unit ElThemeSysColorHook;

{$B-,R-}
{$D-,L-}

(*

Version History

18/07/2003

 Added WinXp Mystic Code

01/07/2003

 Original version created.

*)

{.$DEFINE RUCOMMENTS}


interface

uses
  SysUtils,
  Windows,
  Forms,
  Classes,
  ElVCLUtils,
  ElInprocHookAPI,
  ElList,
  ElProcessUtils;

const
  cSpecialColorArraySize = 30;

type
  TSpecialColorMap = array [0..cSpecialColorArraySize] of DWord;
  TSpecialBrushMap = array [0..cSpecialColorArraySize] of HBrush;
  PSpecialColorData = ^TSpecialColorData;
  TSpecialColorData = packed record
    pDataNT: PSpecialColorData;
    LockCount: Integer;
    Map: TSpecialColorMap;
    BrushMap: TSpecialBrushMap;
    CurrentTheme: THandle;
  end;

function SysColorAPIHooked:Boolean;
function SpecialColorMapsInstalled: Boolean;
function BeginWriteSpecialColors(var hLock:THandle):PSpecialColorData;
procedure EndWriteSpecialColors(var hLock:THandle);
function GetGlobalCurrentTheme: THandle;
function SetGlobalCurrentTheme(Theme: THandle): Boolean;


implementation

const
  cSizeOfTSpecialColorData = SizeOf(TSpecialColorData);
  cSharedCodeID =         'HookApi:{7423122B-4A04-4C2E-B057-D2EC94A3E30A}';
  cSpecialColorDataID =   'ThemeColors:{6EAEF4C3-D1FF-4C69-8885-60CD10CC4D3F}';
  cSpecialColorDataIDT =  cSpecialColorDataID+':%u';

var
  bSysColorAPIHooked: Boolean = False;
  bSpecialColorMapsInstalled: Boolean;
  SpecialColorData: PSpecialColorData = nil;

procedure FirstCheckInstaled; forward;

var
  CheckInstaled: TProcedure = FirstCheckInstaled;

function SysColorAPIHooked:Boolean;
begin
  CheckInstaled;
  Result := bSysColorAPIHooked;
end;

function SpecialColorMapsInstalled: Boolean;
begin
  CheckInstaled;
  Result := bSpecialColorMapsInstalled;
end;


function SpecialColorDataID:String;
begin
  Result := cSpecialColorDataID+':'+DWordToStr(GetCurrentProcessID());
end;

function FirstBeginWriteSpecialColors(var hLock:THandle):PSpecialColorData; forward;

type
  TBeginWriteSpecialColors = function (var hLock:THandle):PSpecialColorData;

var
  ProcBeginWriteSpecialColors: TBeginWriteSpecialColors = FirstBeginWriteSpecialColors;

function BeginWriteSpecialColors(var hLock:THandle):PSpecialColorData;
begin
  Result := ProcBeginWriteSpecialColors(hLock);
end;

function SecondBeginWriteSpecialColors(var hLock:THandle):PSpecialColorData;
begin
  if SpecialColorData<>nil then
  begin
    BeginLock(SpecialColorDataID+':Lock', hLock);
    if (not IsBadReadPtrSize(SpecialColorData, SizeOf(TSpecialColorData))) and
        UnprotectMemory(SpecialColorData, SizeOf(TSpecialColorData), PAGE_READWRITE)
    then
        Result := SpecialColorData
    else
      Result := nil;
  end
  else
  begin
    Result := nil;
    hLock := 0;
  end;
end;

function HookSysColorAPI:Boolean; forward;

function FirstBeginWriteSpecialColors(var hLock:THandle):PSpecialColorData;
begin
  BeginLock(SpecialColorDataID+':Lock', hLock);
  try
    if not bSysColorAPIHooked then
    begin
      ProcBeginWriteSpecialColors := SecondBeginWriteSpecialColors;
      HookSysColorAPI;
    end;
  finally
    EndWriteSpecialColors(hLock);
  end;
  Result := SecondBeginWriteSpecialColors(hLock);
end;

procedure SecondCheckInstaled;
begin
end;

procedure FirstCheckInstaled;
var
  hLock:THandle;
begin
  if @ProcBeginWriteSpecialColors = @FirstBeginWriteSpecialColors then
  begin
    FirstBeginWriteSpecialColors(hLock);
    CheckInstaled := SecondCheckInstaled;
    EndWriteSpecialColors(hLock);
  end;
end;

procedure EndWriteSpecialColors(var hLock:THandle);
begin
  EndLock(hLock);
end;

function GetGlobalCurrentTheme: THandle;
var
  hLock:THandle;
  vSpecialColorData: PSpecialColorData;
begin
  CheckInstaled;
  Result := 0;
  if SpecialColorData=nil then
    exit;
  vSpecialColorData := BeginWriteSpecialColors(hLock);
  try
    if vSpecialColorData <> nil then
      Result := vSpecialColorData.CurrentTheme;
  finally
    EndWriteSpecialColors(hLock);
  end;
end;

function SetGlobalCurrentTheme(Theme: THandle): Boolean;
var
  hLock:THandle;
  vSpecialColorData: PSpecialColorData;
begin
  CheckInstaled;
  Result := False;
  if SpecialColorData=nil then
    exit;
  vSpecialColorData := BeginWriteSpecialColors(hLock);
  try
    if vSpecialColorData <> nil then
    begin
      vSpecialColorData.CurrentTheme := Theme;
      Result := True;
    end;
  finally
    EndWriteSpecialColors(hLock);
  end;
end;

type
 TCodeData = packed record
   tSpecialColorDataID: array[0..Length(cSpecialColorDataIDT)] of Char;
   // kernel32
   LocalAlloc: Pointer;          // kernel32 'LocalAlloc'
   GetCurrentProcessID: Pointer; // kernel32 'GetCurrentProcessID'
   OpenFileMapping: Pointer;     // kernel32 'OpenFileMappingA'
   LocalFree: Pointer;           // kernel32 'LocalFree'
   MapViewOfFile: Pointer;       // kernel32 'MapViewOfFile'
   UnmapViewOfFile: Pointer;     // kernel32 'UnmapViewOfFile'
   CloseHandle: Pointer;         // kernel32 'CloseHandle'
   VirtualQuery: Pointer;        // kernel32 'VirtualQuery'
   // user32
   wsprintf: Pointer;            // user32 'wsprintfA'
   // old handlers
   OldSysColor: Pointer;         // user32 'GetSysColor'
   OldSysColorBrush: Pointer;    // user32 'GetSysColorBrush'
   // other
   SpecialColorDataNT: PSpecialColorData;   bApiHooked: WORD;              end;
 PCodeData = ^TCodeData;

const
  bApiHooked_False = 0;
  bApiHooked_True  = 1;
  bApiHooked_Error = 2;


procedure NewGetSysColorsTemplate;
label
 LB_CODE_START, LB_CODE_END, LB_CODE_DATA,
 LB_NewGetSysColorBrush;
type
  TLocalData = packed record
    bSpecialColorAvailable: Boolean;
    SpecialColorData: PSpecialColorData;
    hSharedMem :THandle;
    sID:PChar;
  end;
  PLocalData=^TLocalData;
const
  // parameter
  idx_Index  =  $08; // [ebp+$08]
  // result
  idx_Result = -$14; // [ebp-$14]
  // size of result and local variables:
  SizeOfDWORD =               SizeOf(DWORD);
  SizeOfResult =              SizeOfDWORD;
  cSizeOfLocalData =          (SizeOf(TLocalData) + SizeOfDWORD-1) div SizeOfDWORD * SizeOfDWORD; // = $10 = 16; dword aligment
  cSizeOfLocalDataAndResult = SizeOfResult+cSizeOfLocalData;      // = $14 = 20; dword aligment
  cSpecialColorDataIDTBuffSize = Length(cSpecialColorDataIDT)+15; // wsprintf buffer size
  PAGE_READABLE = PAGE_READONLY or PAGE_EXECUTE_READWRITE or
                  PAGE_READWRITE or PAGE_EXECUTE_READ;
begin
asm
    // input: eax
    // output: eax
            cmp    eax, ci_code_ptr
            jz     @@ci_code_ptr
            cmp    eax, ci_code_size
            jz     @@ci_code_size
            cmp    eax, ci_code_data_offset
            jz     @@ci_code_data_offset
            cmp    eax, ci_code_data_offset+1
            jz     @@code2_offset
            xor    eax, eax
            jmp    @@exit
@@ci_code_ptr:
            mov    eax, offset LB_CODE_START
            jmp    @@exit
@@ci_code_size:
            mov   eax, offset LB_CODE_END
            sub   eax, offset LB_CODE_START
            jmp @@exit
@@ci_code_data_offset:
            mov   eax, offset LB_CODE_DATA
            sub   eax, offset LB_CODE_START
            jmp @@exit
@@code2_offset:
            mov   eax, offset LB_NewGetSysColorBrush
            sub   eax, offset LB_CODE_START
@@exit:
end;
exit;
asm
LB_CODE_START:
// ** NewGetSysColor **
//    function NewGetSysColor(Index: integer): DWord; stdcall;
            mov   eax, 0
            jmp @@Common

LB_NewGetSysColorBrush:
// ** NewGetSysColorBrush **
//    function NewGetSysColorBrush(Index: integer): DWord; stdcall;
            mov   eax, 1

@@Common:
            push  ebp
            mov   ebp, esp
            add   esp, - cSizeOfLocalDataAndResult

            mov   [ebp+idx_Result], eax // save function id (0=GetSysColor; 1=GetSysColorBrush)
            push  ebx
            push  edx
            push  esi
            push  ecx

          // load to ebx address of local variables ( ebx == PLocalData )
            lea   ebx, [ebp-cSizeOfLocalData]

{load to esi address of LB_CODE_DATA in dynamic} // (mov esi, offset LB_CODE_DATA)
{-------------------------------------------------------------------------------}
            push  ebp
              @@code_start:
              call  @@delta
              @@delta:
              // load to esi address of @@code_start:
              pop   esi
              // sub esi, (offset @@delta) - (offset @@code_start):
              mov   eax, offset @@delta
              sub   eax, offset @@code_start
              sub   esi, eax
              // load to esi address of LB_CODE_DATA
              // lea esi,[esi+ ( (offset LB_CODE_DATA)-(offset @@code_start) ) ]:
              mov   eax, offset LB_CODE_DATA
              sub   eax, offset @@code_start
              lea   esi, [esi+eax]
            pop   ebp
{-------------------------------------------------------------------------------}
{/load to esi address of LB_CODE_DATA in dynamic}

            mov   [ebx].TLocalData.hSharedMem, $00
            mov   [ebx].TLocalData.SpecialColorData, $00

          // check Index
            // if (Index < Low(TSpecialColorMap)) or (Index > High(TSpecialColorMap)) then
            cmp    dword ptr [ebp+idx_Index], 0 // = Low(TSpecialColorMap) = 0
            jl    @@ClearLocalDataFlags
            cmp    dword ptr [ebp+idx_Index], cSpecialColorArraySize // = High(TSpecialColorMap) = cSpecialColorArraySize
            ja    @@ClearLocalDataFlags

          // check Assigned(SpecialColorDataNT). = True for NT only.
            cmp   [esi].TCodeData.SpecialColorDataNT, 0
            jz    @@LoadDataWin9X
            mov   eax, [esi].TCodeData.SpecialColorDataNT
            mov   [ebx].TLocalData.SpecialColorData, eax
            jmp   @@CheckValidPtrSpecialColorData

@@LoadDataWin9X:
          // calculate shared memory string_id from template:
            // sID := PChar(LocalAlloc(LPTR, cSpecialColorDataIDTBuffSize))
            push  cSpecialColorDataIDTBuffSize  // Buffer Size
            push  LPTR  // FixMem and Zero Init
            call  dword ptr [esi].TCodeData.LocalAlloc
            test  eax, eax
            jnz   @@Allocated

@@ClearLocalDataFlags:
            // Clear LocalData Flags
            mov   [ebx].TLocalData.SpecialColorData, 0
@@ClearLocalDataFlags2:
            mov   byte ptr [ebx].TLocalData.bSpecialColorAvailable, 0
            jmp   @@CheckLocalData

@@Allocated:
            mov   dword ptr [ebx].TLocalData.sID, eax
            // wsprintf(sID, cSpecialColorDataIDT, GetCurrentProcessID)
            call  dword ptr [esi].TCodeData.GetCurrentProcessID
            push  eax
            push  esi // esi = @TCodeData.tSpecialColorDataID = @CodeData
            push  [ebx].TLocalData.sID
            call  dword ptr [esi].TCodeData.wsprintf
            add   esp, $0C // add ParamCount*SizeOf(DWORD)

          // hSharedMem := OpenFileMapping(FILE_MAP_READ, False, sID)
            push  [ebx].TLocalData.sID
            push  False
            push  FILE_MAP_READ
            call  dword ptr [esi].TCodeData.OpenFileMapping
            mov   [ebx].TLocalData.hSharedMem, eax
            // LocalFree(HLOCAL(sID))
            push  [ebx].TLocalData.sID
            call  dword ptr [esi].TCodeData.LocalFree
            // if (hSharedMem<>ERROR_INVALID_HANDLE)and(hSharedMem<>0) then
            cmp   [ebx].TLocalData.hSharedMem, ERROR_INVALID_HANDLE
            jz    @@ClearLocalDataFlags
            cmp   [ebx].TLocalData.hSharedMem, $00
            jz    @@ClearLocalDataFlags
          // SpecialColorData := MapViewOfFile(hSharedMem, FILE_MAP_READ, 0, 0, 0)
            push  $00
            push  $00
            push  $00
            push  FILE_MAP_READ
            push  [ebx].TLocalData.hSharedMem
            call  dword ptr [esi].TCodeData.MapViewOfFile
            mov   [ebx].TLocalData.SpecialColorData, eax

@@CheckValidPtrSpecialColorData:
{check valid pointer TLocalData.SpecialColorData:}
{-------------------------------------------------------------------------------}
            cmp   [ebx].TLocalData.SpecialColorData, 0
            jz    @@ClearLocalDataFlags2
            push  cSizeOfTSpecialColorData; // = SizeOf(TSpecialColorData)
            push  [ebx].TLocalData.SpecialColorData
            call  @@IsBadReadPtrSize // alternative to IsBadReadPtr
            test  al, al
            jnz   @@ClearLocalDataFlags
{-------------------------------------------------------------------------------}
{/check valid pointer TLocalData.SpecialColorData}

@@CheckLocalData:
            mov   eax, [ebp+idx_Result]
            test  eax, eax
            jnz   @@GetSysColorBrush
// *** GetSysColor ***
          // bSpecialColorAvailable := (SpecialColorData <> nil) and (SpecialColorData.CurrentTheme<>0) and (SpecialColorData.Map[Index] <> $FFFFFFFF);
            cmp   [ebx].TLocalData.SpecialColorData, 0
            jz    @@FalsebSpecialColorAvailable
            mov   edx, [ebx].TLocalData.SpecialColorData
            cmp   [edx].TSpecialColorData.CurrentTheme, 0
            jz    @@FalsebSpecialColorAvailable
            mov   eax, [ebx].TLocalData.SpecialColorData
            mov   edx, [ebp+idx_Index]
            cmp   dword ptr [eax + (offset TSpecialColorData.Map) + edx*SizeOfDWORD], $FFFFFFFF
            jne   @@TruebSpecialColorAvailable

@@FalsebSpecialColorAvailable:
            xor   eax, eax
            jmp   @@CheckbSpecialColorAvailable

@@TruebSpecialColorAvailable:
            mov   al, True

@@CheckbSpecialColorAvailable:
            mov   byte ptr [ebx].TLocalData.bSpecialColorAvailable, al
          // if not bSpecialColorAvailable then
            cmp   byte ptr [ebx].TLocalData.bSpecialColorAvailable, $00
            jnz   @@ThemedCall
          // Result := OldSysColor(Index)
            mov   eax, [ebp+idx_Index]
            push  eax
            call  dword ptr [esi].TCodeData.OldSysColor
            mov   [ebp+idx_Result], eax
            jmp   @@Ret

@@ThemedCall:
          // Result := SpecialColorData.Map[Index];
            mov   eax, [ebx].TLocalData.SpecialColorData
            mov   edx, [ebp+idx_Index]
            mov   eax, dword ptr [eax + (offset TSpecialColorData.Map) + edx*SizeOfDWORD]
            mov   [ebp+idx_Result], eax

@@Ret:   // *** Ret ***

@@UnLoadDataWin9X:

            // UnmapViewOfFile(SpecialColorData)
            mov   eax, [ebx].TLocalData.SpecialColorData
            test  eax, eax
            jz    @@UnLoadData_CloseSharedMem
            cmp   eax, [esi].TCodeData.SpecialColorDataNT
            je    @@UnLoadDataFinish
            push  eax
            call  dword ptr [esi].TCodeData.UnmapViewOfFile

@@UnLoadData_CloseSharedMem:

            // CloseHandle(hSharedMem)
            mov   eax, [ebx].TLocalData.hSharedMem
            test  eax, eax
            jz    @@UnLoadDataFinish
            push  eax
            call  dword ptr [esi].TCodeData.CloseHandle

@@UnLoadDataFinish:

            mov   eax, [ebp+idx_Result] // Restore Result

            pop   ecx
            pop   esi
            pop   edx
            pop   ebx

@@ShortRet:
            mov   esp, ebp
            pop   ebp
            ret   $04

@@GetSysColorBrush:
// *** GetSysColorBrush ***
          // bSpecialColorAvailable := (SpecialColorData <> nil) and (SpecialColorData.CurrentTheme<>0) and (SpecialColorData.BrushMap[Index] <> 0);
            cmp   dword ptr [ebx].TLocalData.SpecialColorData, $00
            jz    @@FalsebSpecialColorAvailableBrush
            mov   edx, [ebx].TLocalData.SpecialColorData
            cmp   [edx].TSpecialColorData.CurrentTheme, 0
            jz    @@FalsebSpecialColorAvailableBrush
            mov   eax, [ebx].TLocalData.SpecialColorData
            mov   edx, [ebp+idx_Index]
            cmp   dword ptr [eax + (offset TSpecialColorData.BrushMap) + edx*SizeOfDWORD], $00
            jnz   @@TruebSpecialColorAvailableBrush

@@FalsebSpecialColorAvailableBrush:
            xor   eax, eax
            jmp   @@CheckbSpecialColorAvailableBrush

@@TruebSpecialColorAvailableBrush:
            mov   al, True

@@CheckbSpecialColorAvailableBrush:
            mov   byte ptr [ebx].TLocalData.bSpecialColorAvailable, al
          // if not bSpecialColorAvailable then
            cmp   byte ptr [ebx].TLocalData.bSpecialColorAvailable, $00
            jnz   @@ThemedCallBrush
          // Result := OldSysColorBrush(Index)
            mov   eax, [ebp+idx_Index]
            push  eax
            call  dword ptr [esi].TCodeData.OldSysColorBrush
            mov   [ebp+idx_Result], eax
            jmp   @@Ret

@@ThemedCallBrush:
          // Result := SpecialColorData.BrushMap[Index];
            mov   eax, [ebx].TLocalData.SpecialColorData
            mov   edx, [ebp+idx_Index]
            mov   eax, dword ptr [eax + (offset TSpecialColorData.BrushMap) + edx*SizeOfDWORD]
            mov   [ebp+idx_Result], eax
            jmp   @@Ret

//{IsBadReadPtrSize (see source in  ElInprocHookApi.pas)}:
{-------------------------------------------------------------------------------}
// function IsBadReadPtrSize(Ptr:Pointer; Size:DWORD):Boolean; stdcall;
@@IsBadReadPtrSize:
            push  ebp
            mov   ebp, esp
            add   esp, -$20
            push  1Ch  // dwLength
            lea   eax, [ebp-$20]
            push  eax  // lpBuffer
            mov   eax, [ebp+$08]
            push  eax  // lpAddress
            call  dword ptr [esi].TCodeData.VirtualQuery
            test  eax, eax
            setnz byte ptr [ebp-$01]
            cmp   byte ptr [ebp-$01], $00
            jz    @@IsBadReadPtrSize_Ret
            cmp   dword ptr [ebp-$0c], PAGE_NOACCESS
            jz    @@BadResult
            test  byte ptr [ebp-$0c], PAGE_READABLE
            jz    @@BadResult
            xor   eax, eax
            jmp   @@ChkVirtQryResult
@@BadResult:
            mov   al, $01
@@ChkVirtQryResult:
            mov   [ebp-$01], al
            cmp   byte ptr [ebp-$01], 0
            jnz   @@IsBadReadPtrSize_Ret
            mov   eax, [ebp+$08]
            cmp   eax, [ebp-$20]
            jz    @CheckSize
            mov   eax, [ebp+$08]
            sub   eax, [ebp-$20]
            add   [ebp+$0C], eax
@CheckSize:
            mov   eax, [ebp+$0C]
            cmp   eax, [ebp-$14]
            jbe   @@IsBadReadPtrSize_Ret
@@LoopCheckPageReadable:
            cmp   dword ptr [ebp-$0c], PAGE_NOACCESS
            jz    @@LoopBadResult
            test  byte ptr [ebp-$0c], PAGE_READABLE
            jz    @@LoopBadResult
            xor   eax, eax
            jmp   @@LoopChkVirtQryResult
@@LoopBadResult:
            mov   al, $01
@@LoopChkVirtQryResult:
            mov   [ebp-$01], al
            cmp   byte ptr [ebp-$01], 0
            jnz   @@IsBadReadPtrSize_Ret
            mov   eax, [ebp+$0C]
            cmp   eax, [ebp-$14]
            jbe   @@IsBadReadPtrSize_Ret
            mov   eax, [ebp-$14]
            sub   [ebp+$0C], eax
            mov   eax, [ebp-$20]
            add   eax, [ebp-$14]
            inc   eax
            mov   [ebp+$08], eax
            push  1Ch // dwLength
            lea   eax, [ebp-$20]
            push  eax // lpBuffer
            mov   eax, [ebp+$08]
            push  eax // lpAddress
            call  dword ptr [esi].TCodeData.VirtualQuery
            test  eax, eax
            jnz   @@LoopCheckPageReadable
            mov   byte ptr [ebp-$01], $01
@@IsBadReadPtrSize_Ret:
            mov   al, [ebp-$01]
            mov   esp, ebp
            pop   ebp
            ret   8
{-------------------------------------------------------------------------------}
//{/IsBadReadPtrSize}

LB_CODE_DATA:
LB_CODE_END:
end;
end;


procedure InstallSpecialColorMaps;
var
  hSharedMem: THandle;
  bFirstAllocate:Boolean;
  PH :THandle;
  hLock:THandle;
begin
  if bSpecialColorMapsInstalled then
    exit;
  BeginWriteSpecialColors(hLock);
  try
    if (SpecialColorData=nil)and(not bSpecialColorMapsInstalled) then
    begin
      // create current process shared data:
      SpecialColorData := HookApi_GetBuffer(
        SizeOf(TSpecialColorData),
        SpecialColorDataID,
        hSharedMem, bFirstAllocate);
      if SpecialColorData=nil then
        exit;
      // increment lock count:
      if not UnprotectMemory(SpecialColorData, SizeOf(TSpecialColorData), PAGE_READWRITE) then
      begin
        UnmapViewOfFile(SpecialColorData);
        CloseHandle(hSharedMem);
        exit;
      end;
      inc(SpecialColorData.LockCount);
      bSpecialColorMapsInstalled := True;
      if bFirstAllocate then
      begin
        // fix MapView Ptr for read SpecialColorData
        if Win32Platform = VER_PLATFORM_WIN32_NT then
          SpecialColorData.pDataNT := MapViewOfFile(hSharedMem, FILE_MAP_READ, 0, 0, 0);
        // lock data in current process:
        PH := GetCurrentProcess;
        if not DuplicateHandle(PH, hSharedMem, PH, nil, 0, False, DUPLICATE_SAME_ACCESS) then
          hSharedMem := 0;
      end;
      if bFirstAllocate or (SpecialColorData.LockCount=1) then
      begin
        SpecialColorData.CurrentTheme := 0;
        FillChar(SpecialColorData.Map, SizeOf(SpecialColorData.Map), $FFFFFFFF);
        FillChar(SpecialColorData.BrushMap, SizeOf(SpecialColorData.BrushMap), 0);
      end;
      if hSharedMem<>0 then
        CloseHandle(hSharedMem);
    end
    else
    begin
      if SpecialColorData=nil then
        exit;
      if IsBadReadPtrSize(SpecialColorData, SizeOf(TSpecialColorData)) and
         (not UnprotectMemory(SpecialColorData, SizeOf(TSpecialColorData), PAGE_READWRITE))
      then
        SpecialColorData := nil
      else
      begin
        // increment lock count:
        inc(SpecialColorData.LockCount);
        bSpecialColorMapsInstalled := True;
      end;
    end;
  finally
    EndWriteSpecialColors(hLock);
  end;
end;

procedure UninstallSpecialColorMaps;
var
  hLock:THandle;
  vSpecialColorData: PSpecialColorData;
begin
  if bSpecialColorMapsInstalled and (SpecialColorData<>nil) then
  begin
    vSpecialColorData := BeginWriteSpecialColors(hLock);
    try
      SpecialColorData := nil;
      bSpecialColorMapsInstalled := False;
      if vSpecialColorData<>nil then
      try
        // decrement lock count:
        dec(vSpecialColorData.LockCount);
        if vSpecialColorData.LockCount=0 then
        begin
          vSpecialColorData.CurrentTheme := 0;
          FillChar(vSpecialColorData.Map, SizeOf(vSpecialColorData.Map), $FFFFFFFF);
          FillChar(vSpecialColorData.BrushMap, SizeOf(vSpecialColorData.BrushMap), 0);
        end;
        UnmapViewOfFile(vSpecialColorData);
      except
        on e:exception do
        begin
          OutputDebugString( PChar('ERROR: UninstallSpecialColorMaps: '+e.Message) );
        end;
      end;
    finally
      EndWriteSpecialColors(hLock);
    end;
  end;
end;

function HookSysColorAPI:Boolean;
var
  hLock: THandle;
  hSharedMem: THandle;
  bFirstAllocate: Boolean;
  SharedCodeID: String;
  NewGetSysColor: Pointer;
  NewGetSysColorBrush: Pointer;
  codeData: PCodeData;
  codeSize: DWORD;
  h:THandle;
  ModuleList: TElList;
  i: Integer;
  HookCount: Integer;
  {$ifndef VCL_5_USED}
  SF : TStrings;
  {$endif}
  //SaveFlagSrcCode: DWORD;
begin
  Result := False;

  if SpecialColorData=nil then
    InstallSpecialColorMaps;
  if SpecialColorData=nil then
    exit;


  if not bSysColorAPIHooked then
  try

    // create shared code:
    if Win32Platform = VER_PLATFORM_WIN32_NT then
         // process lock:
      SharedCodeID := cSharedCodeID+':'+DWordToStr(GetCurrentProcessID())
    else // global system lock:
      SharedCodeID := cSharedCodeID;
    BeginLock(SharedCodeID+':Lock', hLock);
    try

      NewGetSysColor := HookApi_CreateCodeTemplate(
        @NewGetSysColorsTemplate,
        SizeOf(TCodeData),
        SharedCodeID,
        hSharedMem,
        bFirstAllocate,
        Pointer(codeData),
        codeSize);

      if hSharedMem=0 then
        exit;

      try

        // Calculate address of NewGetSysColorBrush:
        NewGetSysColorBrush := NewGetSysColor;
        asm
          mov   eax, ci_code_data_offset+1
          call  NewGetSysColorsTemplate
          add   NewGetSysColorBrush, eax
        end;

        if bFirstAllocate then // INIT CODE DATA
        begin
          if not UnprotectMemory( codeData,  SizeOf(TCodeData), PAGE_EXECUTE_READWRITE ) then
          begin
            UnmapViewOfFile(NewGetSysColor);
            exit;
          end;
          codeData.bApiHooked := bApiHooked_False;
          if (Win32Platform = VER_PLATFORM_WIN32_NT) then
            codeData.SpecialColorDataNT := SpecialColorData.pDataNT
          else
            codeData.SpecialColorDataNT := nil;

        // fill string template
          StrCopy(codeData.tSpecialColorDataID, cSpecialColorDataIDT);
        // fill cache of system functions addresses
          // kernel32
          h := GetModuleHandle(kernel32);
          codeData.LocalAlloc := GetProcAddressETA(h, 'LocalAlloc' );
          codeData.LocalFree := GetProcAddressETA(h, 'LocalFree' );
          codeData.GetCurrentProcessID := GetProcAddressETA(h, 'GetCurrentProcessID' );
          codeData.OpenFileMapping := GetProcAddressETA(h, 'OpenFileMappingA' );
          codeData.MapViewOfFile := GetProcAddressETA(h, 'MapViewOfFile' );
          codeData.UnmapViewOfFile := GetProcAddressETA(h, 'UnmapViewOfFile' );
          codeData.CloseHandle := GetProcAddressETA(h, 'CloseHandle' );
          codeData.VirtualQuery := GetProcAddressETA(h, 'VirtualQuery' );
          // user32
          h := GetModuleHandle(user32);
          codeData.wsprintf := GetProcAddressETA(h, 'wsprintfA' );
          // save old handlers addresses
          codeData.OldSysColor := GetProcAddressETA(h, 'GetSysColor' );
          codeData.OldSysColorBrush := GetProcAddressETA(h, 'GetSysColorBrush' );
          if // check pointers
             // kernel32:
             (codeData.LocalAlloc=nil)or(codeData.LocalFree=nil)or
             (codeData.GetCurrentProcessID=nil)or(codeData.OpenFileMapping=nil)or
             (codeData.MapViewOfFile=nil)or(codeData.UnmapViewOfFile=nil)or
             (codeData.CloseHandle=nil)or(codeData.VirtualQuery=nil)or
             // user32:
             (codeData.wsprintf=nil)or
             // old handlers:
             (codeData.OldSysColor=nil)or(codeData.OldSysColorBrush=nil)
          then
          begin
            UnmapViewOfFile(NewGetSysColor);
            exit;
          end;
          if not HookApi_LockCodeTemplate(hSharedMem, bFirstAllocate) then
          begin
            UnmapViewOfFile(NewGetSysColor);
            exit;
          end;
        end
        else
        begin
          bSysColorAPIHooked := codeData.bApiHooked = bApiHooked_True;
          UnmapViewOfFile(NewGetSysColor);
          exit;
        end;

        if codeData.bApiHooked = bApiHooked_False then
        try
          if not UnprotectMemory( @codeData.bApiHooked,  SizeOf(codeData.bApiHooked), PAGE_READWRITE ) then
            exit;

          // { *** XPMysticCode ***:
          {$ifndef VCL_5_USED}SF := {$endif}Screen.Fonts; // !!!
          // } *** XPMysticCode ***.

          // hoook code (GetSysColor):
            h := GetModuleHandle(user32);
            if (GetProcAddressETA(h, 'GetSysColor' ) <> NewGetSysColor) then // in Win9X hook is global in system
            begin
              // import tables:
              ModuleList := TElList.Create;
              try
                FillModuleList(GetCurrentProcessId(), ModuleList);
                HookCount := 0;
                for i:=0 to ModuleList.Count-1 do
                begin
                  if HookImportTableApiFunction(
                    TModuleInformation(ModuleList.Items[i]).hModule,
                    user32, 'GetSysColor',
                    NewGetSysColor
                    )<> nil then
                  begin
                    // Import Table hooked for module: TModuleInformation(ModuleList.Items[i]).ModuleName
                    inc(HookCount);
                  end;
                end;
              finally
                ModuleList.Free;
              end;

              if (HookCount>0) then
                codeData.bApiHooked := bApiHooked_Error;

              // export table:
              if not SetProcAddressETA(GetModuleHandle(PAnsiChar(user32)), 'GetSysColor',
                 NewGetSysColor) then
              begin
                codeData.bApiHooked := bApiHooked_Error;
                exit;
              end;
              if (codeData.bApiHooked <> bApiHooked_Error) then
                codeData.bApiHooked := bApiHooked_Error;
            end;
          // hoook code (GetSysColorBrush):
            if (GetProcAddressETA(h, 'GetSysColorBrush' ) <> NewGetSysColorBrush) then // in Win9X hook is global in system
            begin
              // import tables:
              ModuleList := TElList.Create;
              try
                FillModuleList(GetCurrentProcessId(), ModuleList);
                HookCount := 0;
                for i:=0 to ModuleList.Count-1 do
                begin
                  if HookImportTableApiFunction(
                    TModuleInformation(ModuleList.Items[i]).hModule,
                    user32, 'GetSysColorBrush',
                    NewGetSysColorBrush
                    )<> nil then
                  begin
                    // Import Table hooked for module: TModuleInformation(ModuleList.Items[i]).ModuleName
                    inc(HookCount);
                  end;
                end;
              finally
                ModuleList.Free;
              end;
              if (HookCount>0)and(codeData.bApiHooked <> bApiHooked_Error) then
                codeData.bApiHooked := bApiHooked_Error;
              // export table:
              if not SetProcAddressETA(GetModuleHandle(PAnsiChar(user32)), 'GetSysColorBrush',
                 NewGetSysColorBrush) then
              begin
                codeData.bApiHooked := bApiHooked_Error;
                exit;
              end;
              if (codeData.bApiHooked <> bApiHooked_Error) then
                codeData.bApiHooked := bApiHooked_Error;
            end;
            codeData.bApiHooked := bApiHooked_True;
            //VirtualProtect( NewGetSysColor, codeSize, PAGE_READONLY, @SaveFlagSrcCode );
        except
          on e:exception do
          begin
            OutputDebugString( PChar('ERROR: 1) Install Hook Error (GetSysColors): '+e.Message) );
            exit;
          end;
        end;
        bSysColorAPIHooked := codeData.bApiHooked = bApiHooked_True;
      finally
        if hSharedMem<>0 then
          CloseHandle(hSharedMem);
      end;
    finally
      EndLock(hLock);
    end;
  except
    on e:exception do
    begin
      OutputDebugString( PChar('ERROR: 2) Install Hook Error (GetSysColors): '+e.Message) );
    end;
  end;
  Result := bSysColorAPIHooked;
end;


initialization

  if isLibrary or ModuleIsLib or ModuleIsPackage then
  begin
    if DisableThreadLibraryCalls(hInstance) then
    ;
  end;
  {$IFDEF ELPACK_THEME_ENGINE}
    CheckInstaled;
  {$ELSE}
    {$IFDEF VCL_5_USED}{$IFNDEF VCL_6_USED}
      CheckInstaled;     {$ENDIF}{$ENDIF}
  {$ENDIF}


finalization
  UninstallSpecialColorMaps;
end.
