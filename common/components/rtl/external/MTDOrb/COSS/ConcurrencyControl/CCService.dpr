// **********************************************************************
//
// Copyright (c) 2002 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
program CCService;
{$APPTYPE CONSOLE}
uses
  orb_int,
  orb,
  poa_int,
  poa_impl,
  policy_int,
  SysUtils,
  Classes,
  CosConcurrencyControl_impl in 'CosConcurrencyControl_impl.pas';

var
  ORB_var: IORB;
  props: TStrings;
  obj: IORBObject;
  rootPOA, p: IPOA;
  i: integer;
  policy: PolicyList;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    ORB_var := ORB_init(props);
    //obtain root POA
    obj := ORB_var.resolve_initial_reference('RootPOA');
    rootPOA := TPOA_impl._narrow(obj);
    //create Persistent POA
    SetLength(policy, 2);
    policy[0] := RootPOA.create_lifespan_policy(PERSISTENT);
    policy[1] := RootPOA.create_id_assignment_policy(USER_ID);
    p := rootPOA.create_POA('LockSetFactory', RootPOA.the_POAManager(), policy);

    CosConcurrencyControl_impl.CCServiceInit(ORB_var, p, props);
  finally
    props.free;
  end; { try/finally }
  WriteLn('Concurrency Control Service');
  WriteLn('Copyright (c) 2001 - 2002 MT Tools');
  WriteLn('All rights reserved');
  //WriteLn('Concurrency Control Server is ready ...');
  p.the_POAManager.activate;
  ORB_var.run;
end.
