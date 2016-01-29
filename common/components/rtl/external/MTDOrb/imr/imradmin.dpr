program imradmin;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  orb,
  orb_int,
  poa_int,
  poa_impl,
  imr_impl,
  imr,
  imr_int,
  addr_int;

var
  dorb: IORB;

procedure usage();
begin
  WriteLn(Format('usage: %s <command> ...', [ParamStr(0)]));
  WriteLn('where <command> is one of the following:');
  WriteLn(Chr($09) + 'list ....................................... show entries');
  WriteLn(Chr($09) + 'info <name> ................................ info for entry <name>');
  WriteLn(Chr($09) + 'delete <name> .............................. remove entry <name>');
  WriteLn(Chr($09) + 'create <name> <mode> <command> <repoids> ... create new entry');
  WriteLn(Chr($09) + 'activate <name> [<address>] ................ activate implementation');
  WriteLn(Chr($09) + 'stop <name> [<address>] .................... stop server and hold requests');
  WriteLn(Chr($09) + 'continue <name> [<address>] ................ restart server when stopped');
  WriteLn(Chr($09) + 'locate <name> ....... ...................... locate tagged implementation of repoid');
  Halt(1);
end;

procedure imr_list(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  i: integer;
begin
  impls := AImr.find_all();
  for i := 0 to Length(impls) - 1 do
    WriteLn(impls[i].name);
end;

procedure imr_info(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  idx, i: integer;
  impl: IImplementationDef;
  objs: TObjectInfoList;
begin
  idx := Args.IndexOf('info');
  if (idx = -1) or ((idx + 1) = Args.Count) then
    usage();
  impls := AImr.find_by_name(AnsiString(Args[idx + 1]));
  if Length(impls) = 0 then begin
    WriteLn('no such server: ' + Args[idx]);
    Halt(1);
  end;
  Assert(Length(impls) = 1);

  impl := impls[0];

    WriteLn(Format('server name: %s', [Args[idx + 1]]));
    Write('activation mode: ');
    case impl.mode of
      ActivateShared: Write('shared');
      ActivateUnshared: Write('unshared');
      ActivatePerMethod: Write('permethod');
      ActivatePersistent: Write('persistent');
      ActivateLibrary: Write('library');
      ActivatePOA: Write('poa');
    end;
    WriteLn;

    WriteLn(Format('activation command: %s', [impl.command]));

    objs := impl.objs;
    for i := 0 to Length(objs) - 1 do begin
	Write(Format('object #%d: %s', [i, objs[i].repoid]));
	//if (Length(objs[i].tag) > 0) then
          //Write(Format('#%s', [tag_to_string(objs[i].tag])));
	WriteLn;
    end;
end;

procedure imr_delete(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  idx: integer;
begin
  idx := Args.IndexOf('delete');
  if (idx = -1) or ((idx + 1) = Args.Count) then
    usage();
  impls := AImr.find_by_name(AnsiString(Args[idx + 1]));
  if Length(impls) = 0 then begin
    WriteLn('no such server: ' + Args[idx]);
    Halt(1);
  end;
  Assert(Length(impls) = 1);
  AImr._destroy(impls[0]);
end;

procedure imr_create(Args: TStrings; AImr: IImplRepository);
var
  idx, n, objCnt, p: integer;
  impls: TImplDefSeq;
  mode: TActivationMode;
  command: string;
  objs: TObjectInfoList;
  tagStr: string;
  impl: IImplementationDef;
begin
  mode := ActivatePOA;
  idx := Args.IndexOf('create');
  Inc(idx);
  if idx = Args.Count then
    usage();

  n := idx;
  impls := AImr.find_by_name(AnsiString(Args[idx]));
  if Length(impls) > 0 then begin
    WriteLn(Format('there is already a server called %s, please choose a unique name!', [Args[idx]]));
    Halt(1);
  end;

  Inc(idx);
  if idx = Args.Count then
    usage();
  if Args[idx] = 'poa' then
    mode := ActivatePOA
  else begin
    WriteLn(Format('invalid activation mode: %s. Valid mode is poa', [Args[idx]]));
    Halt(1);
  end;

  Inc(idx);
  if (idx = Args.Count) and (mode <> ActivatePersistent) then begin
    WriteLn('create needs a command');
    Halt(1);
  end
  else
    command := Args[idx];

  Inc(idx); objCnt := 0;
  while idx < Args.Count do begin
    SetLength(objs, objCnt + 1);
    p := Pos('#', Args[idx]);
    if p > 0 then begin
      objs[objCnt].repoid := AnsiString(Copy(Args[idx], 1, p));
      SetLength(objs[objCnt].tag, Length(Args[idx]) - p);
      tagStr := Copy(Args[idx], p, Length(Args[idx]) - p);
      Move(Pointer(tagStr)^, Pointer(objs[objCnt].tag)^, Length(Args[idx]) - p);
    end
    else
      objs[objCnt].repoid := AnsiString(Args[idx]);
    Inc(objCnt);
    Inc(idx);
  end;

  impl := AImr._create(mode, objs, AnsiString(Args[n]), command);
  Assert(impl <> nil);
end;

procedure imr_activate(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  idx: integer;
  obj: IORBObject;
  addr: IAddress;
  //oamed: IOAMediator;
  poamed: IPOAMediator;
begin
  idx := Args.IndexOf('activate');
  if (idx = -1) or ((idx + 1) = Args.Count) then
    usage();

  impls := AImr.find_by_name(AnsiString(Args[idx + 1]));
  if Length(impls) = 0 then begin
    WriteLn('no such server: ' + Args[idx]);
    Halt(1);
  end;
  Assert(Length(impls) = 1);
  AImr._destroy(impls[0]);

  (*if ((idx + 2) < Args.Count) then
      // try given address
      obj := dorb.bind('IDL:mg.org/CORBA/OAMediator:1.0', Args[idx + 2]);
  if obj = nil then begin
    // try address of the impl repo
    addr := (AImr as IORBObject).ior().address();
    obj := dorb.bind('IDL:mg.org/CORBA/OAMediator:1.0', addr.toString());
  end;
  if obj = nil then
    // try default addresses
    obj := dorb.bind('IDL:mg.org/CORBA/OAMediator:1.0');
  if obj = nil then begin
      WriteLn('error: cannot connect to orbimr');
      Halt(1);
  end;
  oamed := TOAMediator._narrow(obj);
  if (oamed.force_activation(impls[0])) then
    Exit;*)

  (*
   * Try again with POA Mediator
   *)
  if ((idx + 2) < Args.Count) then
      // try given address
      try
        obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', AnsiString(Args[idx + 2]));
      except

      end; { try/except }
  if obj = nil then begin
    // try address of the impl repo
    addr := (AImr as IORBObject)._ior().address();
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', addr.toString());
  end;
  if obj = nil then
    // try default addresses
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0');
  if obj = nil then begin
      WriteLn('error: cannot connect to orbimr');
      Halt(1);
  end;
  poamed := TPOAMediator._narrow(obj);
  if (poamed.force_activation(impls[0])) then
    Exit;
end;

procedure imr_locate(Args: TStrings; AImr: IImplRepository);
begin
end;

procedure imr_hold(Args: TStrings; AImr: IImplRepository);
begin
end;

procedure imr_stop(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  idx: integer;
  obj: IORBObject;
  addr: IAddress;
  //oamed: IOAMediator;
  poamed: IPOAMediator;
begin
  idx := Args.IndexOf('stop');
  if (idx = -1) or ((idx + 1) = Args.Count) then
    usage();

  impls := AImr.find_by_name(AnsiString(Args[idx + 1]));
  if Length(impls) = 0 then begin
    WriteLn('no such server: ' + Args[idx]);
    Halt(1);
  end;
  Assert(Length(impls) = 1);

  (*
   * Try again with POA Mediator
   *)
  if ((idx + 2) < Args.Count) then
      // try given address
      obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', AnsiString(Args[idx + 2]));
  if obj = nil then begin
    // try address of the impl repo
    addr := (AImr as IORBObject)._ior().address();
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', addr.toString());
  end;
  if obj = nil then
    // try default addresses
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0');
  if obj = nil then begin
      WriteLn('error: cannot connect to orbimr');
      Halt(1);
  end;
  poamed := TPOAMediator._narrow(obj);
  if not poamed.stop(impls[0]) then begin
    WriteLn('error: cannot stop server ' + Args[idx]);
    Halt(1);
  end;
end;

procedure imr_continue(Args: TStrings; AImr: IImplRepository);
var
  impls: TImplDefSeq;
  idx: integer;
  obj: IORBObject;
  addr: IAddress;
  //oamed: IOAMediator;
  poamed: IPOAMediator;
begin
  idx := Args.IndexOf('continue');
  if (idx = -1) or ((idx + 1) = Args.Count) then
    usage();

  impls := AImr.find_by_name(AnsiString(Args[idx + 1]));
  if Length(impls) = 0 then begin
    WriteLn('no such server: ' + Args[idx]);
    Halt(1);
  end;
  Assert(Length(impls) = 1);

  (*
   * Try again with POA Mediator
   *)
  if ((idx + 2) < Args.Count) then
      // try given address
      obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', AnsiString(Args[idx + 2]));
  if obj = nil then begin
    // try address of the impl repo
    addr := (AImr as IORBObject)._ior().address();
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0', addr.toString());
  end;
  if obj = nil then
    // try default addresses
    obj := dorb.bind('IDL:mg.org/CORBA/POAMediator:1.0');
  if obj = nil then begin
      WriteLn('error: cannot connect to orbimr');
      Halt(1);
  end;
  poamed := TPOAMediator._narrow(obj);
  if not poamed.continue(impls[0]) then begin
    WriteLn('error: cannot continue server ' + Args[idx]);
    Halt(1);
  end;
end;

procedure main();
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  prm: string;
  imrVar: IImplRepository;
begin
  if ParamCount = 0 then
    usage();
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do begin
      prm := ParamStr(i);
      props.Add(prm);
    end;
    dorb := ORB_Init(props);

    //resolve Implementation Repository
    obj := dorb.resolve_initial_reference('ImplementationRepository');
    imrVar := TImplRepository._narrow(obj);
    if imrVar = nil then begin
      WriteLn('error: cannot contact Implementation Repository');
      Halt(1);
    end;

    if props.IndexOf('list') <> -1 then
      imr_list(props, imrVar)
    else if props.IndexOf('info') <> -1 then
      imr_info(props, imrVar)
    else if props.IndexOf('delete') <> -1 then
      imr_delete(props, imrVar)
    else if props.IndexOf('create') <> -1 then
      imr_create(props, imrVar)
    else if props.IndexOf('activate') <> -1 then
      imr_activate(props, imrVar)
    else if props.IndexOf('locate') <> -1 then
      imr_locate(props, imrVar)
    else if props.IndexOf('hold') <> -1 then
      imr_hold(props, imrVar)
    else if props.IndexOf('stop') <> -1 then
      imr_stop(props, imrVar)
    else if props.IndexOf('continue') <> -1 then
      imr_continue(props, imrVar)
    else
      usage();
  finally
    props.Free;
  end; { try/finally }
end;

begin
  try
    main();
  except
    on E: Exception do
      WriteLn(E.Message);
  end; { try/except }
end.
