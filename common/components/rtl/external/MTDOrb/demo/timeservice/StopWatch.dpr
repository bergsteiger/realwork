program StopWatch;
{$APPTYPE CONSOLE}
uses
  Classes, SysUtils, orb_int, orb, CosTime_int, CosTime, timehelper;

var
  ORB_var: IORB;
  props: TStrings;
  obj: IORBObject;
  ts: ICosTime_TimeService;
  start, stop: ICosTime_UTO;
  i: integer;

  procedure Test;
  begin
    //WriteLn('Foo1');
    Test;
  end;

begin
  WriteLn('Foo');
  try
    Test;
  except
    {on E: Exception do begin
      WriteLn('Foo');
      //WriteLn(E.ClassName);
      //WriteLn(E.Message);
      Exit;
    end;}
      WriteLn('Foo');
  end; { try/except }
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    ORB_var := ORB_init(props);
  finally
    props.free;
  end; { try/finally }

  // Get time service
  obj := ORB_var.bind('IDL:omg.org/CosTime/TimeService:1.0');
  if obj = nil then begin
    WriteLn('Can''t resolve "TimeService"');
    Exit;
  end;
  ts := TCosTime_TimeService._narrow(obj);
  if ts = nil then begin
    WriteLn('"TimeService" is not a TimeService object reference');
    Exit;
  end;

  // Get start and stop times
  WriteLn('Press Enter to start');
  ReadLn;
  start := ts.universal_time();
  WriteLn('Press Enter to stop');
  ReadLn;
  stop := ts.universal_time();

  // Display start and stop times
  WriteLn('Start time: ' + TTimeHelper.toTimeString(start.utc_time));
  WriteLn('Stop time: ' + TTimeHelper.toTimeString(stop.utc_time));
  // Display elapsed time
  WriteLn('Elapsed time: ' + IntToStr((stop.time - start.time) div 10000) + ' ms');
  ReadLn;
end.