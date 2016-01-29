program PUSA;

uses
  Forms,
  evdSchema,
  alcuSpyForm in 'alcuSpyForm.pas' {TalcuSpyForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TalcuSpyForm, PusaForm);
  Application.Run;
end.
