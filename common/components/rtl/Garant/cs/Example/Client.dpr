program Client;

uses
  Forms,
  MainClient in 'MainClient.pas' {MainClientForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainClientForm, MainClientForm);
  Application.Run;
end.
