program Mdiedit;

uses
  Forms,
  Mdieditm in 'MDIEDITM.PAS' {MainForm},
  Mdieditc in 'MDIEDITC.PAS' {MDIChild},
  Mdiedita in 'MDIEDITA.PAS' {MdiAbout};

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TMdiAbout, MdiAbout);
  Application.Run;
end.
