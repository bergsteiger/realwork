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
unit mtdebug_int;

interface

{$I dorb.inc}

uses orbtypes;

const
  {Size of the call stack we store when GetMem is called, must be an EVEN number}
  StoredCallStackDepth = 26;

type
  TCallStack = array[0..StoredCallStackDepth] of Pointer;

  TMessageType = (
      mtInfo,           // trivial stuff
      mtError,          // errors that must be noticed
      mtWarning,        // warnings that might be of interest 
      mtTrace);         // trace
  TMessageTypes = set of TMessageType;

  ILogger = interface(IInterface)
  ['{199C5C49-1063-49C2-AC68-B335538AA02C}']
    function IsLogged(const MsgType: TMessageType): boolean;
    procedure Info(const Msg: AnsiString);
    procedure Error(const Msg: AnsiString);
    procedure Warning(const Msg: AnsiString);
    procedure Trace(const Category, Msg: AnsiString);
  end;

implementation

end.
