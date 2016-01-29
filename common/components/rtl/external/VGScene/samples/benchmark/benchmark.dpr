program benchmark;

uses
  Forms,
  benchmarkfrm in 'benchmarkfrm.pas' {frmBenchmark};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBenchmark, frmBenchmark);
  Application.Run;
end.
