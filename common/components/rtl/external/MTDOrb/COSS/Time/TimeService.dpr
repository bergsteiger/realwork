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
program TimeService;
{$APPTYPE CONSOLE}
uses
  orb_int,
  orb,
  poa_int,
  poa_impl,
  SysUtils,
  Classes,
  CosTime_impl in 'CosTime_impl.pas',
  CosTimerEvent_impl in 'CosTimerEvent_impl.pas';
  //timehelper in '..\..\src\orb\timehelper.pas';

var
  ORB_var: IORB;
  props: TStrings;
  obj: IORBObject;
  p : IPOA;
  i: integer;

begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    ORB_var := ORB_init(props);
    obj := ORB_var.resolve_initial_reference('RootPOA');
    p := TPOA_impl._narrow(obj);
    CosTime_impl.TimeServiceInit(ORB_var, p, props);
    CosTimerEvent_impl.TimerEventServiceInit(ORB_var, p, props);
  finally
    props.free;
  end; { try/finally }
  WriteLn('TimeService');
  WriteLn('Copyright (c) 2001 - 2002 MT Tools');
  WriteLn('All rights reserved');
  p.the_POAManager.activate;
  ORB_var.run;
end.
