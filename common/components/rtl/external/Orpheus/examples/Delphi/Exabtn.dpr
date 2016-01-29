program Exabtn;

uses
  Forms,
  Exabtn1 in 'EXABTN1.PAS' {Form1},
  Exabtn2 in 'EXABTN2.PAS' {frmCal};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmCal, frmCal);
  Application.Run;
end.
