{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Internal.Unwind;

interface

type
  _Unwind_Reason_Code = Integer;
  _Unwind_Action = Integer;
  _Unwind_Exception = Pointer;
  _Unwind_Context = Pointer;
  _Unwind_RegVal = NativeUInt;
  _PUnwind_RegVal = ^_Unwind_RegVal;

const
  _URC_NO_REASON = 0;
  _URC_FOREIGN_EXCEPTION_CAUGHT = 1;
  _URC_FATAL_PHASE2_ERROR = 2;
  _URC_FATAL_PHASE1_ERROR = 3;
  _URC_NORMAL_STOP = 4;
  _URC_END_OF_STACK = 5;
  _URC_HANDLER_FOUND = 6;
  _URC_INSTALL_CONTEXT = 7;
  _URC_CONTINUE_UNWIND = 8;

  _UA_SEARCH_PHASE = 1;
  _UA_CLEANUP_PHASE = 2;
  _UA_HANDLER_FRAME = 3;
  _UA_FORCE_UNWIND = 4;
  
  _UW_REG_EBP = 0;
  _UW_REG_ESP = 1;
  _UW_REG_EBX = 2;
  _UW_REG_EAX = 3;
  _UW_REG_EDX = 4;
  _UW_REG_ECX = 5;
  _UW_REG_EIP = 6;

function BorUnwind_GetGR(context: _Unwind_Context; Idx: Integer): _Unwind_RegVal; cdecl;
procedure  BorUnwind_SetGR(context: _Unwind_Context; Idx: Integer; Value: _Unwind_RegVal); cdecl;

implementation

const
{$IFDEF MSWINDOWS}
  unwind = 'unwind.dll';
{$ENDIF MSWINDOWS}
{$IFDEF LINUX}
  unwind = 'libcgunwind.so.1';
{$ENDIF LINUX}
{$IFDEF MACOS}
  unwind = 'libcgunwind.1.0.dylib';
{$ENDIF MACOS}

const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}

function BorUnwind_GetGR(context: _Unwind_Context; Idx: Integer): _Unwind_RegVal; cdecl;
  external unwind name _PU + '_BorUnwind_GetGR';
procedure  BorUnwind_SetGR(context: _Unwind_Context; Idx: Integer; Value: _Unwind_RegVal); cdecl;
  external unwind name _PU + '_BorUnwind_SetGR';

end.
