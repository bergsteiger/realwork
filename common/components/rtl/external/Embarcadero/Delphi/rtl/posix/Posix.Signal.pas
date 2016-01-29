{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Signal;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SignalTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SignalTypes.inc}
{$ENDIF LINUX}

{$I SignalAPI.inc}

(*$HPPEMIT '#include <signal.h>' *)
{$IFDEF MACOS}
(*$HPPEMIT 'typedef struct sigaction sigaction_t;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_exception_state exception_state;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_thread_state thread_state;' *)
(*$HPPEMIT 'typedef struct __darwin_mmst_reg mmst_reg;' *)
(*$HPPEMIT 'typedef struct __darwin_xmm_reg xmm_reg;' *)
(*$HPPEMIT 'typedef struct __darwin_i386_float_state float_state;' *)
{$ENDIF MACOS}

implementation

end.
