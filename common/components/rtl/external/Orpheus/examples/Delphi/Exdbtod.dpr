program Exdbtod;

uses
  Forms,
  Exdbtodu in 'Exdbtodu.pas' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.