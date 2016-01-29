program OrdEntry;

uses
  Forms,
  Ordntry1 in 'ORDNTRY1.PAS' {OrdEntryForm},
  Ordntry2 in 'ORDNTRY2.PAS' {OrdAbout};

{$R *.RES}

begin
  Application.CreateForm(TOrdEntryForm, OrdEntryForm);
  Application.CreateForm(TOrdAbout, OrdAbout);
  Application.Run;
end.
