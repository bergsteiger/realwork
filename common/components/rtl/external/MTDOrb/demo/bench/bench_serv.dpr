program bench_serv;

uses
  Forms,
  serv_main in 'serv_main.pas' {Form1},
  bench_impl in 'bench_impl.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
