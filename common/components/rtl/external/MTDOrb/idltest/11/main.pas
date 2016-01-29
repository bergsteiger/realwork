unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,_const_int, _const;

type

  Tfoo_impl = class(Tfoo_stub)
  private
    FArr: Tfoo_ss;
  protected
    procedure ss_in(const s: Tfoo_ss); override;
    function ss_out: Tfoo_ss; override;
  end;

  procedure mainproc;


implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int;


//***********************************************************
// foo_impl
//***********************************************************
procedure Tfoo_impl.ss_in(const s: Tfoo_ss);
begin
  FArr := s;
end;

function Tfoo_impl.ss_out: Tfoo_ss;
begin
  result := FArr;
end;

procedure mainproc;
var
  dorb : IORB;
  impl: Tfoo_impl;
  ref: AnsiString;
  obj: IORBObject;
  foo : Ifoo;
  boa: IBOA;
  fl: TStringList;
  arr,arr2 : Tfoo_ss;
  i : integer;
begin
  dorb := ORB_Init(nil);
  boa := dorb.BOA_Init as IBOA;
  impl := Tfoo_impl.Create;
  if (ParamCount = 1) and (lowercase(ParamStr(1)) = 's') then
    begin
      fl := TStringList.Create;
      fl.Text := dorb.object_to_string(impl);
      fl.SaveToFile('server.objid');
      fl.free;
      dorb.run;
      exit;
    end
  else if (ParamCount = 1) and (lowercase(ParamStr(1)) = 'c') then
    begin
      fl := TStringList.Create;
      fl.LoadFromFile('server.objid');
      ref := fl.Text;
      fl.free;
    end
  else if (ParamCount >= 1)  then
    begin
      writeln('usage: '+ExtractFileName(ParamStr(0))+' s|c');
      exit;
    end
  else
    ref := dorb.object_to_string(impl);
  // client side
  obj := dorb.string_to_object(ref);
  foo := Tfoo._narrow(obj);
  arr[0] := 'a';
  arr[1] := 'b';
  arr[2] := 'c';
  arr[3] := 'd';
  arr[4] := 'e';
  arr[5] := 'f';
  arr[6] := 'g';
  arr[7] := 'h';
  arr[8] := 'i';
  arr[9] := 'g';
  arr[10] := 'k';
  arr[11] := 'l';
  arr[12] := 'm';
  arr[13] := 'n';
  foo.ss_in(arr);
  arr2 := foo.ss_out;
  for i := 0 to 13 do
    write(arr2[i]);
  writeln;  
end;

end.
