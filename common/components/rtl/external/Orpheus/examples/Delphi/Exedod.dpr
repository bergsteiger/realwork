program ExEdOD;

uses
  Forms,
  ExEdODu in 'ExEdODu.pas' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
