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
unit timermanager_int;

interface

{$I dorb.inc}

uses {$IFDEF MSWINDOWS}WinSock{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF}, orbtypes;

type
  ITimer = interface(IInterface)
  ['{393D5047-52D6-4A11-88C9-9C83722B1C0D}']
    procedure Notify;
  end;

  ITimerManager = interface(IInterface)
  ['{FF8A19B5-E605-4846-9A2D-4C3ED350060E}']
    procedure Add(const ATimer: ITimer; const AWhen: TTimeVal);
    procedure Remove(const ATimer: ITimer);
    procedure _Destroy;
  end;

implementation

end.
