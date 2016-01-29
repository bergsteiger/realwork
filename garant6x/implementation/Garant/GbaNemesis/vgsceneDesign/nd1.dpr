program nd1;

uses
  Forms,
  nd1_main in 'nd1_main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
