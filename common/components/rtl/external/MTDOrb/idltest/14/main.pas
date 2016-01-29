unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,_array_int, _array;

type

  Tfoo_impl = class(Tfoo_stub)
  protected
    function bar(const x: TSS; var y: TSS; out z: TSS; out w: Tlong_arr): TSS; override;
    function baz: Tlong_arr; override;
  end;

  procedure mainproc;


implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int;

procedure fill_SS(var ss: TSS);
var
  i,j: integer;
begin
  for i := 0 to 4 do
    for j := 0 to 3 do
      ss[i][j] := Chr(ord('A')+i*j);
end;

procedure print_SS( const ss: TSS );
var
  i,j: integer;
begin
  for i := 0 to 4 do
    for j := 0 to 3 do
      writeln('ss[' +inttostr(i) +']['+inttostr(j)+'] = ' + ss[ i ][ j ]);
  writeln('---------------------');
end;

procedure print_long_arr(const arr: Tlong_arr);
var
  j: integer;
begin
  for j := 0 to 9 do
      writeln('long_arr[' +inttostr(j) +'] = ' + inttostr(arr[ j ]));
  writeln('---------------------');
end;

//***********************************************************
// foo_impl
//***********************************************************
function Tfoo_impl.bar(const x: TSS; var y: TSS; out z: TSS; out w: Tlong_arr): TSS;
var
  i : integer;
begin
  print_SS(x);
  y[0][0] := 'Hello';
  print_SS(y);
  for i := 0 to 9 do
    w[i] := i+1;
  fill_ss(z);
  result := z;
end;

function Tfoo_impl.baz: Tlong_arr;
var
  i : integer;
begin
  for i := 0 to 9 do
    result[i] := i+1;
end;

procedure mainproc;
var
  dorb : IORB;
  foo_impl : TFoo_impl;
  ref: AnsiString;
  foo_client : IFoo;
  obj : IORBObject;
  x,y,z,rss : TSS;
  l : Tlong_arr;
begin
  dorb := ORB_Init(nil);
  foo_impl := TFoo_impl.Create;
  ref := dorb.object_to_string(foo_impl);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(ref));
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo_client := TFoo._narrow(obj);
  fill_SS(x);
  fill_SS(y);
  rss := foo_client.bar(x,y,z,l);
  print_long_arr(l);
  print_ss(z);
  print_ss(rss);
  l := foo_client.baz;
  print_long_arr(l);
end;

end.
