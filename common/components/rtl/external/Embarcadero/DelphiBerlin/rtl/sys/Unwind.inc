{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IF defined(ZCX_BASED_EXCEPTIONS) and not Defined(LINUX)}
// ToDo: almost functions will move into System.pas

const
  librtlhelper = 'librtlhelper.a';

function _Unwind_RaiseException(var exception_object: _Unwind_Exception): _Unwind_Reason_Code; cdecl;
    external librtlhelper name '_Unwind_RaiseException';

{$IFDEF CPUARM32}
function __aeabi_unwind_cpp_pr0 (status: _Unwind_State; var exceptionObject: _Unwind_Exception;
  var context: _Unwind_Context): _Unwind_Reason_Code; cdecl;
    external librtlhelper name '__aeabi_unwind_cpp_pr0';

function __aeabi_unwind_cpp_pr1 (status: _Unwind_State; var exceptionObject: _Unwind_Exception;
  var context: _Unwind_Context): _Unwind_Reason_Code; cdecl;
    external librtlhelper name '__aeabi_unwind_cpp_pr1';

function __aeabi_unwind_cpp_pr2 (status: _Unwind_State; var exceptionObject: _Unwind_Exception;
  var context: _Unwind_Context): _Unwind_Reason_Code; cdecl;
    external librtlhelper name '__aeabi_unwind_cpp_pr2';
{$ENDIF CPUARM32}

{$IFDEF CPUARM32}
type
  _Unwind_VRS_RegClass = UInt32;
  _Unwind_VRS_DataRepresentation = UInt32;
  _Unwind_VRS_Result = UInt32;

const
  _UVRSC_CORE = _Unwind_VRS_RegClass(0);
  _UVRSC_VFP = _Unwind_VRS_RegClass(1);
  _UVRSC_WMMXD = _Unwind_VRS_RegClass(3);
  _UVRSC_WMMXC = _Unwind_VRS_RegClass(4);

  _UVRSD_UINT32 = _Unwind_VRS_DataRepresentation(0);
  _UVRSD_VFPX = _Unwind_VRS_DataRepresentation(1);
  _UVRSD_UINT64 = _Unwind_VRS_DataRepresentation(3);
  _UVRSD_FLOAT = _Unwind_VRS_DataRepresentation(4);
  _UVRSD_DOUBLE = _Unwind_VRS_DataRepresentation(5);

  _UVRSR_OK = _Unwind_VRS_Result(0);
  _UVRSR_NOT_IMPLEMENTED = _Unwind_VRS_Result(1);
  _UVRSR_FAILED = _Unwind_VRS_Result(2);

type
  TReg = record
    GPReg : array[0..15] of UInt32;
    LRReg : UInt32;
    VFPReg : array[0..31] of UInt64;
  end;

procedure _RestoreCoreRegs(var Register: TReg);
   external librtlhelper name '_RestoreCoreRegs';

{$ELSE }
// TODO -cELBRUS_LLVM_NON_ARM: FIXME: ZCX / _RestoreCoreRegs / librtlhelper.a
// CPUX86 or CPUARM64
type
  TReg = record
  end;

procedure _RestoreCoreRegs(var Register: TReg);
begin
  Error(rePlatformNotImplemented);
end;
{$ENDIF}

type
  PReg = ^TReg;

{$IF Defined(CPUARM32)}
const
  UNWIND_POINTER_REG = 12;
  UNWIND_STACK_REG   = 13;
  UNWIND_LINK_REG    = 14;
  UNWIND_IP_REG      = 15;

function _Unwind_VRS_Pop(
    context : PUnwind_Context;
    regclass: _Unwind_VRS_RegClass;
    discriminator: UInt32;
    representation: _Unwind_VRS_DataRepresentation
): _Unwind_VRS_Result;
var
  regInd, mask: Cardinal;
  Reg: PReg;
  _SP: NativeUInt;
begin
  Result := _UVRSR_FAILED;
  Reg := PReg(context);
  case regclass of
    _UVRSC_CORE:
      if representation = _UVRSD_UINT32 then
      begin
        _SP := Reg.GPReg[UNWIND_STACK_REG];

        mask := discriminator and $FFFF;
        regInd := 0;
        while (mask <> 0) do
        begin
          if (mask and 1) <> 0 then
          begin
            Reg.GPReg[regInd] := PCardinal(_SP)^;
            Inc(_SP, sizeof(UInt32));
          end;
          mask := mask shr 1;
          inc(regInd);
        end;

        if (discriminator and (1 shl UNWIND_STACK_REG)) = 0 then
          Reg.GPReg[UNWIND_STACK_REG] := _SP;

        Result := _UVRSR_OK;
      end;

    _UVRSC_VFP:
      if representation in [_UVRSD_DOUBLE, _UVRSD_VFPX] then
      begin
        _SP := Reg.GPReg[UNWIND_STACK_REG];

        regInd := ((discriminator shr 16) and $001F); // VFPReg : array[0..31]
        mask   := ( discriminator         and $FFFF);

        while (mask > 0) and (regInd < 32) do
        begin
          Reg.VFPReg[regInd] := PUInt64(_SP)^;
          Inc(_SP, sizeof(UInt64));
          Dec(mask);
          Inc(regInd);
        end;

        if representation = _UVRSD_VFPX then
          Inc(_SP, sizeof(UInt64));
        if mask = 0 then
        begin
          Reg.GPReg[UNWIND_STACK_REG] := _SP;
          Result := _UVRSR_OK;
        end;
      end;
//    _UVRSC_WMMXD:
//    _UVRSC_WMMXC:
  else
    // Not supported yet.
  end;
end;

function _Unwind_VRS_Get(
    context : PUnwind_Context;
    regclass: _Unwind_VRS_RegClass;
    regno: UInt32;
    representation: _Unwind_VRS_DataRepresentation;
var valuep: UInt32
): _Unwind_VRS_Result;
var
  Reg: PReg;
begin
  Result := _UVRSR_FAILED;
  case regclass of
    _UVRSC_CORE:
      if representation = _UVRSD_UINT32 then
      begin

        Reg := PReg(context);
        valuep := Reg.GPreg[regno];
        Result := _UVRSR_OK;
      end;
//    _UVRSC_VFP:
//      begin
//      end;
//    _UVRSC_WMMXD:
//    _UVRSC_WMMXC:
  else
    // Not supported yet.
  end;
end;
exports _Unwind_VRS_Get;

function _Unwind_VRS_Set(
    context: PUnwind_Context;
    regclass: _Unwind_VRS_RegClass;
    regno: UInt32;
    representation: _Unwind_VRS_DataRepresentation;
var valuep: UInt32
): _Unwind_VRS_Result;
var
  Reg: PReg;
begin
  Result := _UVRSR_FAILED;
  case regclass of
    _UVRSC_CORE:
      if representation = _UVRSD_UINT32 then
      begin
        Reg := PReg(context);
        Reg.GPReg[regno] := valuep;

        Result := _UVRSR_OK;
      end;
//    _UVRSC_VFP:
//      begin
//      end;
//    _UVRSC_WMMXD:
//    _UVRSC_WMMXC:
  else
    // Not supported yet.
  end;
end;
exports _Unwind_VRS_Set;

function _Unwind_GetGR(ctx: PUnwind_Context; reg: integer): UInt32;
begin
  _Unwind_VRS_Get(ctx, _UVRSC_CORE, reg, _UVRSD_UINT32, Result);
end;

procedure _Unwind_SetGR(ctx: PUnwind_Context; reg: Integer; val: UInt32);
begin
  _Unwind_VRS_Set(ctx, _UVRSC_CORE, reg, _UVRSD_UINT32, val);
end;

function _Unwind_GetIP(ctx: PUnwind_Context): UInt32;
begin
  Result := _Unwind_GetGR(ctx, UNWIND_IP_REG) and (not 1);
end;

procedure _Unwind_SetIP(ctx: PUnwind_Context; val: UInt32);
var
  thumbState: UInt32;
begin
  thumbState := _Unwind_GetGR(ctx, UNWIND_IP_REG) and 1;
  _Unwind_SetGR(ctx, UNWIND_IP_REG, (val or thumbState));
end;
{$ELSEIF Defined(CPUARM64)}
const
  UNWIND_POINTER_REG = 12;
  UNWIND_STACK_REG   = 13;

function _Unwind_GetGR(ctx: PUnwind_Context; reg: integer): UInt32;
begin
  Result := 0;
end;

procedure _Unwind_SetGR(ctx: PUnwind_Context; reg: Integer; val: UInt32);
begin
  //
end;

function _Unwind_GetIP(ctx: PUnwind_Context): UInt32;
begin
  Result := 0;
end;

procedure _Unwind_SetIP(ctx: PUnwind_Context; val: UInt32);
begin
  //
end;
{$ELSE}
{$MESSAGE ERROR 'Unknown Platform'}
{$ENDIF}


// void _Unwind_Complete(_Unwind_Control_Block *ucbp);
procedure _Unwind_Complete(var ucbp: _Unwind_Exception);
begin
end;
exports _Unwind_Complete;

// _Unwind_Reason_Code _Unwind_Resume_or_Rethrow (_Unwind_Control_Block *ucbp);
function  _Unwind_Resume_or_Rethrow(var ucbp: _Unwind_Exception): _Unwind_Reason_Code;
begin
  Result := _URC_NO_REASON;
end;
exports _Unwind_Resume_or_Rethrow;

// _Unwind_Ptr _Unwind_GetDataRelBase (_Unwind_Context *);
function _Unwind_GetDataRelBase(var context: _Unwind_Context): Pointer;
begin
  Result := nil;
end;
exports _Unwind_GetDataRelBase;

// _Unwind_Ptr _Unwind_GetTextRelBase (_Unwind_Context *);
function _Unwind_GetTextRelBase(var context: _Unwind_Context): Pointer;
begin
  Result := nil;
end;
exports _Unwind_GetTextRelBase;

{$ELSE}
{$IF Defined(CPUARM) and Defined(LINUX)}
type
  _Unwind_VRS_RegClass = UInt32;
  _Unwind_VRS_DataRepresentation = UInt32;
  _Unwind_VRS_Result = UInt32;

const
  _UVRSC_CORE = _Unwind_VRS_RegClass(0);
  _UVRSC_VFP = _Unwind_VRS_RegClass(1);
  _UVRSC_WMMXD = _Unwind_VRS_RegClass(3);
  _UVRSC_WMMXC = _Unwind_VRS_RegClass(4);

  _UVRSD_UINT32 = _Unwind_VRS_DataRepresentation(0);
  _UVRSD_VFPX = _Unwind_VRS_DataRepresentation(1);
  _UVRSD_UINT64 = _Unwind_VRS_DataRepresentation(3);
  _UVRSD_FLOAT = _Unwind_VRS_DataRepresentation(4);
  _UVRSD_DOUBLE = _Unwind_VRS_DataRepresentation(5);

  _UVRSR_OK = _Unwind_VRS_Result(0);
  _UVRSR_NOT_IMPLEMENTED = _Unwind_VRS_Result(1);
  _UVRSR_FAILED = _Unwind_VRS_Result(2);

const
  UNWIND_POINTER_REG = 12;
  UNWIND_STACK_REG   = 13;
  UNWIND_LINK_REG    = 14;
  UNWIND_IP_REG      = 15;
{$ENDIF}

const
{$IF Defined(LINUX)}
  libcppabi = 'libgcc_s.so.1';
{$ELSEIF Defined(MACOS)}
  libcppabi = '/usr/lib/libc++abi.dylib';
{$ENDIF}

function _Unwind_RaiseException(var exception_object: _Unwind_Exception): _Unwind_Reason_Code; cdecl;
  external libcppabi name _PU + {$IFDEF SJLJ_BASED_EXCEPTIONS}'_Unwind_SjLj_RaiseException'{$ELSE}'_Unwind_RaiseException'{$ENDIF};

procedure _Unwind_Resume(var exception_object: _Unwind_Exception); cdecl;
  external libcppabi name _PU + {$IFDEF SJLJ_BASED_EXCEPTIONS}'_Unwind_SjLj_Resume'{$ELSE}'_Unwind_Resume'{$ENDIF};

procedure _Unwind_Resume_or_Rethrow(var exception_object: _Unwind_Exception); cdecl;
  external libcppabi name _PU + {$IFDEF SJLJ_BASED_EXCEPTIONS}'_Unwind_SjLj_Resume_or_Rethrow'{$ELSE}'_Unwind_Resume_or_Rethrow'{$ENDIF};

procedure _Unwind_DeleteException(var exception_object: _Unwind_Exception); cdecl;
  external libcppabi name _PU + '_Unwind_DeleteException';

function _Unwind_GetRegionStart(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetRegionStart';

function _Unwind_GetLanguageSpecificData(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetLanguageSpecificData';

function _Unwind_ForcedUnwind(var exception_object: _Unwind_Exception; stop: _Unwind_Stop_Fn; stop_parameter: Pointer): _Unwind_Reason_Code; cdecl;
  external libcppabi name _PU + {$IFDEF SJLJ_BASED_EXCEPTIONS}'_Unwind_SjLj_ForcedUnwind'{$ELSE}'_Unwind_ForcedUnwind'{$ENDIF};

{$IF Defined(CPUARM) and Defined(LINUX)}
function _Unwind_VRS_Get(context : PUnwind_Context; regclass: _Unwind_VRS_RegClass; regno: UInt32; representation: _Unwind_VRS_DataRepresentation;
  var valuep): _Unwind_VRS_Result; cdecl;
  external libcppabi name _PU + '_Unwind_VRS_Get';

function _Unwind_VRS_Set(context: PUnwind_Context; regclass: _Unwind_VRS_RegClass; regno: UInt32; representation: _Unwind_VRS_DataRepresentation;
  var valuep): _Unwind_VRS_Result; cdecl;
  external libcppabi name _PU + '_Unwind_VRS_Set';

function _Unwind_VRS_Pop(context : PUnwind_Context; regclass: _Unwind_VRS_RegClass; discriminator: UInt32; representation: _Unwind_VRS_DataRepresentation): _Unwind_VRS_Result; cdecl;
  external libcppabi name _PU + '_Unwind_VRS_Pop';

function _Unwind_GetGR(context: PUnwind_Context; index: Integer): UIntPtr; inline;
begin
  _Unwind_VRS_Get(context, _UVRSC_CORE, Cardinal(index), _UVRSD_UINT32, Result);
end;

procedure _Unwind_SetGR(context: PUnwind_Context; index: Integer; new_value: UIntPtr); inline;
begin
  _Unwind_VRS_Set(context, _UVRSC_CORE, Cardinal(Index), _UVRSD_UINT32, new_value);
end;

function _Unwind_GetIP(context: PUnwind_Context): UIntPtr; inline;
begin
  Result := _Unwind_GetGR(context, 15) and not 1;
end;

procedure _Unwind_SetIP(context: PUnwind_Context; new_value: UIntPtr); inline;
begin
  _Unwind_SetGR(context, 15, new_value or (_Unwind_GetGR(context, 15) and 1));
end;
{$ENDIF}

function _Unwind_GetCFA(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetCFA';

function _Unwind_GetDataRelBase(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetDataRelBase';

function _Unwind_GetTextRelBase(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetTextRelBase';

type
  TUnwindTraceFn = function (context: PUnwind_Context; p: Pointer): _Unwind_Reason_Code; cdecl;
  PUnwindTraceFn = ^TUnwindTraceFn;

function _Unwind_Backtrace(f: PUnwindTraceFn; p: Pointer): _Unwind_Reason_Code; cdecl;
  external libcppabi name _PU + '_Unwind_Backtrace';

{$IF (Defined(CPUX64) and Defined(LINUX64)) or Defined(MACOS)}

function _Unwind_GetGR(context: PUnwind_Context; index: Integer): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetGR';

procedure _Unwind_SetGR(context: PUnwind_Context; index: Integer; new_value: UIntPtr); cdecl;
  external libcppabi name _PU + '_Unwind_SetGR';

function _Unwind_GetIP(context: PUnwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetIP';

procedure _Unwind_SetIP(context: PUnwind_Context; new_value: UIntPtr); cdecl;
  external libcppabi name _PU + '_Unwind_SetIP';

function _Unwind_GetIPInfo(context: PUnwind_Context; var ipBefore: Integer): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetIPInfo';

function _Unwind_FindEnclosingFunction(pc: Pointer): Pointer; cdecl;
  external libcppabi name _PU + '_Unwind_FindEnclosingFunction';

type
  TDwarfEhBases = record
    tbase: UIntPtr;
    dbase: UIntPtr;
    func:  UIntPtr;
  end;
  PDwarfEhBases = ^TDwarfEhBases;

function _Unwind_Find_FDE(pc: Pointer; var dwarf_eh_bases: TDwarfEhBases): Pointer; cdecl;
  external libcppabi name _PU + '_Unwind_Find_FDE';

{$ENDIF Defined(LINUX64)}

{$ENDIF}
