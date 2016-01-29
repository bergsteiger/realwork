unit client_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,orb_int;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  dorb : IORB;

{$DEFINE NESTED}

implementation

uses
  orb,bench_impl,bench,bench_int,poa_impl,poa_int;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  params: TStrings;
  bench,mybench : IBench;
  bench_serv: TBench_impl;
  obj : IORBObject;
  p: IPOA;
  start,stop: _SYSTEMTIME;
  duration : double;
begin
  if dorb = nil then
    begin
      params := TStringList.Create;
      try
        params.add('-ORBBindAddr');
        params.add(Edit1.text);
        dorb := ORB_Init(params);
      finally
        params.free;
      end;
    end;
  obj := dorb.resolve_initial_reference('RootPOA');
  p := TPOA_impl._narrow(obj);
  bench_serv := TBench_impl.Create();
  p.activate_object(bench_serv);
  mybench := bench_serv._this;
  p.the_POAManager.activate;
  obj := dorb.bind('IDL:Bench:1.0',AnsiString(Edit1.text));
  if obj = nil then exit;
  bench := TBench._narrow(obj);
  if bench = nil then
    begin
      Memo1.Lines.add('server not found');
      exit;
    end;

{$ifdef NESTED}
  mybench.connect (bench, 100);
  bench.connect (mybench, 100);
{$endif}

  getsystemtime(start);
{$ifdef NESTED}
  bench.g;
{$ELSE}
  for i := 1 to 3000 do
    bench.f;
  bench.sync;
{$ENDIF}
  getsystemtime(stop);
{$ifdef NESTED}
  duration := ((stop.wMinute - start.wMinute)*60000 + (stop.wSecond - start.wSecond)*1000 + (stop.wMilliseconds - start.wMilliseconds)) / 200;
{$ELSE}
  duration := ((stop.wMinute - start.wMinute)*60000 + (stop.wSecond - start.wSecond)*1000 + (stop.wMilliseconds - start.wMilliseconds)) / 3000;
{$ENDIF}
  Memo1.Lines.add(FloatToStr(duration)+' ms per call');
end;

end.

