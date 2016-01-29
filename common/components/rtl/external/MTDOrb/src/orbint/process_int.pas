// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit process_int;

interface

{$I dorb.inc}

uses {$IFDEF MSWINDOWS}Windows,{$ENDIF}{$IFDEF LINUX}Libc,{$ENDIF}orbtypes;

type
  TProcessCallbackEvent = (pceExited);

  IProcessCallback = interface;

  IProcess = interface(IInterface)
  ['{6DF36EBE-D618-44C0-8960-4F43CEED0BBA}']
    procedure Detach;
    procedure Terminate;
    function Run: boolean;
{$IFDEF MSWINDOWS}
    function PId: DWORD;
    function PHandle: THandle;
{$ENDIF}
{$IFDEF LINUX}
    function PId: __pid_t;
{$ENDIF}
    function Callback: IProcessCallback;
  end;

  IProcessCallback = interface(IInterface)
  ['{75F29AE0-EDD3-498B-9B0C-D32D6FF2A470}']
    procedure ProcessCallback(const AProcess: IProcess; const AEvent: TProcessCallbackEvent);
  end;

  IProcessFactory = interface(IInterface)
  ['{5E42F6EE-1D1A-4741-B6B1-172F4FB4AE29}']
    function CreateProcess(const ACommand: string; const ACallback: IProcessCallback): IProcess;
  end;

implementation

end.
