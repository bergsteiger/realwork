unit srv_main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,ex_int, ex;

type

  TCalc_impl = class(TCalc_stub)
    procedure m; override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int,
  throw;

//***********************************************************
// Calc_impl
//***********************************************************
procedure TCalc_impl.m;
var
  ex : ICalc_ex1;
begin
  ex := TCalc_ex1.Create('test');
  dorb_throw(ex);
end;

procedure mainproc;
var
  dorb : IORB;
  params : TStrings;
begin
  params := TStringList.Create;
  try
    params.Add('-ORBIIOPAddr');
    params.Add('inet:localhost:1000');
    dorb := ORB_Init(params);
  finally
    params.free;
  end;
  dorb.BOA_Init;
  TCalc_impl.Create;
  dorb.run;
end;

end.
