program TestClient;

uses
  Forms,
  ClientMain in 'ClientMain.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
