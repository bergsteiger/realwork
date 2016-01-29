program multilang;

uses
  Forms,
  multilangfrm in 'multilangfrm.pas' {frmMultilang};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMultilang, frmMultilang);
  Application.Run;
end.
