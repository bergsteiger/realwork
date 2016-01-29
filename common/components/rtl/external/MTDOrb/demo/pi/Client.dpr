program Client;
{$APPTYPE CONSOLE}
uses
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  Classes,
  poa,
  poa_int,
  poa_impl,
  SysUtils,
  orb_int,
  orb,
  code_int,
  env_int,
  exceptions,
  orbtypes,
  any,
  policy_int,
  policy,
  PIDemo,
  PIDemo_int,
  LoggerPolicy_int,
  RILogger in 'RILogger.pas';

var
  dorb : IORB;

procedure help;
begin
  WriteLn('Portable Interceptor Demo');
  WriteLn('~~~~~~~~~~~~~~~~~~~~~~~~~');
  WriteLn('m: Display this menu');
  WriteLn('l: Enable/disable logging');
  WriteLn('q: Quit client and shutdown server');
  WriteLn('1: Invoke "void   noargs()"');
  WriteLn('2: Invoke "void   noargs_oneway()"');
  WriteLn('3: Invoke "string noargs_return()"');
  WriteLn('4: Invoke "void   withargs(in string, inout string, out string)"');
  WriteLn('5: Invoke "void   systemexception()"');
  WriteLn('6: Invoke "void   userexception()"');
  WriteLn('7: Invoke "void   switch_to_static_impl()"');
  WriteLn('8: Invoke "void   switch_to_dynamic_impl()"');
  WriteLn('9: Invoke "void   call_other_impl(in short)"');
end;

procedure run;
var
  obj: IORBObject;
  fl : TStream;
  ref: AnsiString;
  logLevel: short;
  piDemoWithoutLogging,
  piDemoWithLogging,
  demo: IPIDemo;
  policies: PolicyList;
  a: IAny;
  cmd: Char;
  logging: Boolean;
  str1, str2, str3: AnsiString;
  level: short;
begin
  logLevel := 1;

  fl := TFileStream.Create('PIDemo.ref', fmOpenRead);
  try
    fl.Position := 0;
    SetLength(ref, fl.Size);
    fl.ReadBuffer(Pointer(ref)^, fl.Size);
  finally
    fl.free;
  end; { try/finally }

  obj := dorb.string_to_object(ref);
  piDemoWithoutLogging := TPIDemo._narrow(obj);
  if piDemoWithoutLogging = nil then begin
    WriteLn('IOR in PIDemo.ref is not a PIDemo IOR');
    Exit;
  end;

  //
  // Create a policy set on the object reference to set the
  // logging level
  //
  SetLength(policies, 1);
  a := CreateAny();
  a.put_short(logLevel);
  policies[0] := dorb.create_policy(LOGGER_POLICY_ID, a);
  obj := obj.set_policy_overrides(policies, ADD_OVERRIDE);

  piDemoWithLogging := TPIDemo._narrow(obj);
  if piDemoWithLogging = nil then begin
    WriteLn('IOR in PIDemo.ref is not a PIDemo IOR');
    Exit;
  end;

  demo := piDemoWithLogging;
  logging := true;
  help();

  //
  // Main loop
  //
  repeat
    Write('> ');
    ReadLn(cmd);
    case cmd of
	'm': help();
	'l': begin
	    logging := not logging;
            if logging then
	      Demo :=  piDemoWithLogging
            else
	      Demo :=  piDemoWithoutLogging;
	    Write('Client logging is now ');
            if logging then
              WriteLn('enabled')
            else
              WriteLn('disabled');
        end;
	'q': Demo.deactivate();
	'1': begin
	    WriteLn('void PIDemo::noargs()');
	    Demo.noargs();
        end;
	'2': begin
	    WriteLn('void PIDemo::noargs_oneway()');
	    Demo.noargs_oneway();
        end;
	'3': begin
	    WriteLn('string PIDemo::noargs_return()');
	    Demo.noargs_return();
        end;
	'4': begin
	    WriteLn('void PIDemo::withargs(in string, inout string, out string)');
	    Demo.withargs(str1, str2, str3);
        end;
	'5': begin
	    WriteLn('void PIDemo::systemexception()');
	    try
		Demo.systemexception();
	    except
              on E: SystemException do ;
            end;
        end;
	'6': begin
	    WriteLn('void PIDemo::userexception()');
	    try
		Demo.userexception();
	    except
              on E: TPIDemo_User do ;
	    end;
        end;
	'7': begin
	    WriteLn('void PIDemo::switch_to_static_impl()');
	    Demo.switch_to_static_impl();
        end;
	'8': begin
	    WriteLn('void PIDemo::switch_to_dynamic_impl()');
	    Demo.switch_to_dynamic_impl();
        end;
	'9': begin
	    WriteLn('void PIDemo::call_other_impl(in short level)');
	    WriteLn('Enter level> ');

	    ReadLn(level);

	    Demo.call_other_impl(level);
        end;
    end;
  until cmd = 'q';
end;

procedure mainproc;
var
  prm: TStrings;
begin
  try
    prm := TStringList.Create;
    try
      //
      // Initialize the request interceptors
      //
      TRIORBInitializerImpl.Init();
      //
      // Initialize the ORB
      //
      dorb := ORB_Init(prm);
      //
      // Start the client
      //
      run();
    finally
      prm.Free;
    end; { try/finally }
  except
    on E: Exception do
      WriteLn(E.Message);
  end; { try/except }

  if dorb <> nil then
    try
      dorb._destroy();
    except
      on E: Exception do
        WriteLn(E.Message);
    end; { try/except }
end;

begin
  mainproc;
end.