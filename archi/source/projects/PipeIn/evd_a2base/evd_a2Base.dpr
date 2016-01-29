program evd_a2Base;

uses
  evdSchema,
  Forms,
  evd_aform in 'evd_aform.pas' {ImportEVDForm},
  dd_lcCaseCodeGenerator;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TImportEVDForm, ImportEVDForm);
  Application.Run;
end.
