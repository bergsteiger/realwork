program flash1;

uses
  Forms,
  ft1main in 'ft1main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
