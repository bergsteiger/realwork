program Exef;

uses
  Forms,
  Exefu in 'EXEFU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
