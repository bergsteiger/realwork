program dbTreeExample;

uses
  Forms,
  main in 'main.pas' {Example};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TExample, Example);
  Application.Run;
end.
