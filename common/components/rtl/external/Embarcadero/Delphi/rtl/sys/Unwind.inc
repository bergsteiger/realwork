{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

const
  libcppabi = '/usr/lib/libc++abi.dylib';

function _Unwind_RaiseException(var exception_object: _Unwind_Exception): _Unwind_Reason_Code; cdecl;
{$IF Defined(CPUARM)}
  external libcppabi name _PU + '_Unwind_SjLj_RaiseException';
{$ELSE}
  external libcppabi name _PU + '_Unwind_RaiseException';
{$ENDIF}

procedure _Unwind_Resume(var exception_object: _Unwind_Exception); cdecl;
{$IF Defined(CPUARM)}
  external libcppabi name _PU + '_Unwind_SjLj_Resume';
{$ELSE}
  external libcppabi name _PU + '_Unwind_Resume';
{$ENDIF}

procedure _Unwind_Resume_or_Rethrow(var exception_object: _Unwind_Exception); cdecl;
{$IF Defined(CPUARM)}
  external libcppabi name _PU + '_Unwind_SjLj_Resume_or_Rethrow';
{$ELSE}
  external libcppabi name _PU + '_Unwind_Resume_or_Rethrow';
{$ENDIF}

procedure _Unwind_DeleteException(var exception_object: _Unwind_Exception); cdecl;
  external libcppabi name _PU + '_Unwind_DeleteException';

function _Unwind_GetGR(var context: _Unwind_Context; index: Integer): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetGR';

procedure _Unwind_SetGR(var context: _Unwind_Context; index: Integer; new_value: UIntPtr); cdecl;
  external libcppabi name _PU + '_Unwind_SetGR';

function _Unwind_GetIP(var context: _Unwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetIP';

procedure _Unwind_SetIP(var context: _Unwind_Context; new_value: UIntPtr); cdecl;
  external libcppabi name _PU + '_Unwind_SetIP';

function _Unwind_GetRegionStart(var context: _Unwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetRegionStart';

function _Unwind_GetLanguageSpecificData(var context: _Unwind_Context): UIntPtr; cdecl;
  external libcppabi name _PU + '_Unwind_GetLanguageSpecificData';

function _Unwind_ForcedUnwind(var exception_object: _Unwind_Exception; stop: _Unwind_Stop_Fn; stop_parameter: Pointer): _Unwind_Reason_Code; cdecl;
{$IF Defined(CPUARM)}
  external libcppabi name _PU + '_Unwind_SjLj_ForcedUnwind';
{$ELSE}
  external libcppabi name _PU + '_Unwind_ForcedUnwind';
{$ENDIF}

{$IF Defined(CPUARM)}
//typedef struct _Unwind_FunctionContext* _Unwind_FunctionContext_t;
//extern void _Unwind_SjLj_Register(_Unwind_FunctionContext_t fc);
//extern void _Unwind_SjLj_Unregister(_Unwind_FunctionContext_t fc);
{$ENDIF}
