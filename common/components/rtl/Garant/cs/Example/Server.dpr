program Server;

uses
  Forms,
  MainServer in 'MainServer.pas' {MainServerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainServerForm, MainServerForm);
  Application.Run;
end.
