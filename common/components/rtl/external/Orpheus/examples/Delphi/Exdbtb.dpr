program ExDbTb;

uses
  Forms,
  ExDbTbU in 'ExDbTbU.pas' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
