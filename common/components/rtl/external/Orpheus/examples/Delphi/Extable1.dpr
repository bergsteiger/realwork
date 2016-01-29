program Extable1;

uses
  Forms,
  Extbl1u in 'EXTBL1U.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
