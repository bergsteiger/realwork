unit cl_main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,ex_int, ex;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int,
  throw;

procedure mainproc;
var
  dorb : IORB;
  obj : IORBObject;
  calc : ICalc;
begin
  dorb := ORB_Init(nil);
  dorb.BOA_Init;
  obj := dorb.bind('IDL:Calc:1.0','inet:localhost:1000');
  calc := TCalc._narrow(obj);
  try
    calc.m;
  except
    on x : TCalc_ex1 do
      writeln('ex1: '+x.msg);
  end;
end;

end.
