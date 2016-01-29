program Excombo;

uses
  Forms,
  Excombo1 in 'EXCOMBO1.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
