program exdsplit;

uses
  Forms,
  Exdspltu in 'EXDSPLTU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
