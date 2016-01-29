program DevExpressDemo;

uses
  Forms,
  eDocDevExpress in 'eDocDevExpress.pas' {frmDevExpress};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDevExpress, frmDevExpress);
  Application.Run;
end.
