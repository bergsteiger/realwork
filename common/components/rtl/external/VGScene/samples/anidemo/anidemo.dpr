program anidemo;

uses
  Forms,
  aniform in 'aniform.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
