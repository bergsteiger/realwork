program TestServer;

uses
  Forms,
  ServerMain in 'ServerMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
