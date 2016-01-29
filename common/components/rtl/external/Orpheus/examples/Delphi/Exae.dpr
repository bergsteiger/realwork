program Exae;

uses
  Forms,
  Exaeu in 'EXAEU.PAS' {AEForm},
  CalUnit in 'CALUNIT.PAS' {CalForm};

{$R *.RES}

begin
  Application.CreateForm(TAEForm, AEForm);
  Application.CreateForm(TCalForm, CalForm);
  Application.Run;
end.
