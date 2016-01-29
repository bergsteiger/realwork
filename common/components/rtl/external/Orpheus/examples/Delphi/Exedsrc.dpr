program Exedsrc;

uses
  Forms,
  Exedsrcu in 'EXEDSRCU.PAS' {frmSearch};

{$R *.RES}

begin
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.Run;
end.
