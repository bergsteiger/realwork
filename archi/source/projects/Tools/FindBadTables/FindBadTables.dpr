program FindBadTables;

uses
  Forms,
  evdSchema,
  FindForm in 'FindForm.pas' {FindMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFindMainForm, FindMainForm);
  Application.Run;
end.
